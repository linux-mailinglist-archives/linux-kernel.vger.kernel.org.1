Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D98842E2A82
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Dec 2020 09:54:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729041AbgLYIyC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Dec 2020 03:54:02 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:9993 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725863AbgLYIyB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Dec 2020 03:54:01 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4D2LLC2slSzhxJW;
        Fri, 25 Dec 2020 16:52:35 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.498.0; Fri, 25 Dec 2020 16:53:12 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: fix to keep isolation of atomic write
Date:   Fri, 25 Dec 2020 16:53:04 +0800
Message-ID: <20201225085304.114448-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ThreadA					ThreadB
- f2fs_ioc_start_atomic_write
- write
- f2fs_ioc_commit_atomic_write
 - f2fs_commit_inmem_pages
 - f2fs_drop_inmem_pages
 - f2fs_drop_inmem_pages
  - __revoke_inmem_pages
					- f2fs_vm_page_mkwrite
					 - set_page_dirty
					  - tag ATOMIC_WRITTEN_PAGE and add page
					    to inmem_pages list
  - clear_inode_flag(FI_ATOMIC_FILE)
					- f2fs_vm_page_mkwrite
					  - set_page_dirty
					   - f2fs_update_dirty_page
					    - f2fs_trace_pid
					     - tag inmem page private to pid
					- truncate
					 - f2fs_invalidate_page
					 - set page->mapping to NULL
					  then it will cause panic once we
					  access page->mapping

The root cause is we missed to keep isolation of atomic write in the case
of commit_atomic_write vs mkwrite, let commit_atomic_write helds i_mmap_sem
lock to avoid this issue.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/file.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 22a0101538c0..1ff5fc10e1fa 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -2094,10 +2094,12 @@ static int f2fs_ioc_commit_atomic_write(struct file *filp)
 		goto err_out;
 	}
 
+	down_write(&F2FS_I(inode)->i_mmap_sem);
+
 	if (f2fs_is_atomic_file(inode)) {
 		ret = f2fs_commit_inmem_pages(inode);
 		if (ret)
-			goto err_out;
+			goto up_write;
 
 		ret = f2fs_do_sync_file(filp, 0, LLONG_MAX, 0, true);
 		if (!ret)
@@ -2105,6 +2107,8 @@ static int f2fs_ioc_commit_atomic_write(struct file *filp)
 	} else {
 		ret = f2fs_do_sync_file(filp, 0, LLONG_MAX, 1, false);
 	}
+up_write:
+	up_write(&F2FS_I(inode)->i_mmap_sem);
 err_out:
 	if (is_inode_flag_set(inode, FI_ATOMIC_REVOKE_REQUEST)) {
 		clear_inode_flag(inode, FI_ATOMIC_REVOKE_REQUEST);
-- 
2.29.2

