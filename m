Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9CC02E76E8
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Dec 2020 08:59:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726279AbgL3H5h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Dec 2020 02:57:37 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:9658 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725853AbgL3H5h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Dec 2020 02:57:37 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4D5Nrb75S9z15dDp;
        Wed, 30 Dec 2020 15:55:59 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.498.0; Wed, 30 Dec 2020 15:56:40 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH v2] f2fs: fix to keep isolation of atomic write
Date:   Wed, 30 Dec 2020 15:55:57 +0800
Message-ID: <20201230075557.108818-1-yuchao0@huawei.com>
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
v2:
- use i_mmap_sem to avoid mkwrite racing with below flows:
 * f2fs_ioc_start_atomic_write
 * f2fs_drop_inmem_pages
 * f2fs_commit_inmem_pages

 fs/f2fs/file.c    | 3 +++
 fs/f2fs/segment.c | 7 +++++++
 2 files changed, 10 insertions(+)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 4e6d4b9120a8..a48ec650d691 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -2050,6 +2050,7 @@ static int f2fs_ioc_start_atomic_write(struct file *filp)
 		goto out;
 
 	down_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
+	down_write(&F2FS_I(inode)->i_mmap_sem);
 
 	/*
 	 * Should wait end_io to count F2FS_WB_CP_DATA correctly by
@@ -2060,6 +2061,7 @@ static int f2fs_ioc_start_atomic_write(struct file *filp)
 			  inode->i_ino, get_dirty_pages(inode));
 	ret = filemap_write_and_wait_range(inode->i_mapping, 0, LLONG_MAX);
 	if (ret) {
+		up_write(&F2FS_I(inode)->i_mmap_sem);
 		up_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
 		goto out;
 	}
@@ -2073,6 +2075,7 @@ static int f2fs_ioc_start_atomic_write(struct file *filp)
 	/* add inode in inmem_list first and set atomic_file */
 	set_inode_flag(inode, FI_ATOMIC_FILE);
 	clear_inode_flag(inode, FI_ATOMIC_REVOKE_REQUEST);
+	up_write(&F2FS_I(inode)->i_mmap_sem);
 	up_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
 
 	f2fs_update_time(F2FS_I_SB(inode), REQ_TIME);
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index d8570b0359f5..dab870d9faf6 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -327,6 +327,8 @@ void f2fs_drop_inmem_pages(struct inode *inode)
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	struct f2fs_inode_info *fi = F2FS_I(inode);
 
+	down_write(&F2FS_I(inode)->i_mmap_sem);
+
 	while (!list_empty(&fi->inmem_pages)) {
 		mutex_lock(&fi->inmem_lock);
 		__revoke_inmem_pages(inode, &fi->inmem_pages,
@@ -344,6 +346,8 @@ void f2fs_drop_inmem_pages(struct inode *inode)
 		sbi->atomic_files--;
 	}
 	spin_unlock(&sbi->inode_lock[ATOMIC_FILE]);
+
+	up_write(&F2FS_I(inode)->i_mmap_sem);
 }
 
 void f2fs_drop_inmem_page(struct inode *inode, struct page *page)
@@ -467,6 +471,7 @@ int f2fs_commit_inmem_pages(struct inode *inode)
 	f2fs_balance_fs(sbi, true);
 
 	down_write(&fi->i_gc_rwsem[WRITE]);
+	down_write(&F2FS_I(inode)->i_mmap_sem);
 
 	f2fs_lock_op(sbi);
 	set_inode_flag(inode, FI_ATOMIC_COMMIT);
@@ -478,6 +483,8 @@ int f2fs_commit_inmem_pages(struct inode *inode)
 	clear_inode_flag(inode, FI_ATOMIC_COMMIT);
 
 	f2fs_unlock_op(sbi);
+
+	up_write(&F2FS_I(inode)->i_mmap_sem);
 	up_write(&fi->i_gc_rwsem[WRITE]);
 
 	return err;
-- 
2.29.2

