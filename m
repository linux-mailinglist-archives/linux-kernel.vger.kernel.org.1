Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C9632F25E7
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 02:56:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729235AbhALB4P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 20:56:15 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:10705 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726734AbhALB4O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 20:56:14 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4DFDCB5MGPzl3vf;
        Tue, 12 Jan 2021 09:54:14 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.498.0; Tue, 12 Jan 2021 09:55:23 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: fix to set/clear I_LINKABLE under i_lock
Date:   Tue, 12 Jan 2021 09:55:09 +0800
Message-ID: <20210112015509.28083-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fsstress + fault injection test case reports a warning message as
below:

WARNING: CPU: 13 PID: 6226 at fs/inode.c:361 inc_nlink+0x32/0x40
Call Trace:
 f2fs_init_inode_metadata+0x25c/0x4a0 [f2fs]
 f2fs_add_inline_entry+0x153/0x3b0 [f2fs]
 f2fs_add_dentry+0x75/0x80 [f2fs]
 f2fs_do_add_link+0x108/0x160 [f2fs]
 f2fs_rename2+0x6ab/0x14f0 [f2fs]
 vfs_rename+0x70c/0x940
 do_renameat2+0x4d8/0x4f0
 __x64_sys_renameat2+0x4b/0x60
 do_syscall_64+0x33/0x80
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

Following race case can cause this:
Thread A				Kworker
- f2fs_rename
 - f2fs_create_whiteout
  - __f2fs_tmpfile
   - f2fs_i_links_write
    - f2fs_mark_inode_dirty_sync
     - mark_inode_dirty_sync
					- writeback_single_inode
					 - __writeback_single_inode
					  - spin_lock(&inode->i_lock)
   - inode->i_state |= I_LINKABLE
					  - inode->i_state &= ~dirty
					  - spin_unlock(&inode->i_lock)
 - f2fs_add_link
  - f2fs_do_add_link
   - f2fs_add_dentry
    - f2fs_add_inline_entry
     - f2fs_init_inode_metadata
      - f2fs_i_links_write
       - inc_nlink
        - WARN_ON(!(inode->i_state & I_LINKABLE))

Fix to add i_lock to avoid i_state update race condition.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/namei.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index 6edb1ab579a1..887804968576 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -855,7 +855,11 @@ static int __f2fs_tmpfile(struct inode *dir, struct dentry *dentry,
 
 	if (whiteout) {
 		f2fs_i_links_write(inode, false);
+
+		spin_lock(&inode->i_lock);
 		inode->i_state |= I_LINKABLE;
+		spin_unlock(&inode->i_lock);
+
 		*whiteout = inode;
 	} else {
 		d_tmpfile(dentry, inode);
@@ -1041,7 +1045,11 @@ static int f2fs_rename(struct inode *old_dir, struct dentry *old_dentry,
 		err = f2fs_add_link(old_dentry, whiteout);
 		if (err)
 			goto put_out_dir;
+
+		spin_lock(&whiteout->i_lock);
 		whiteout->i_state &= ~I_LINKABLE;
+		spin_unlock(&whiteout->i_lock);
+
 		iput(whiteout);
 	}
 
-- 
2.29.2

