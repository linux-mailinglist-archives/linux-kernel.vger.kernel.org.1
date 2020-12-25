Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BB662E2A81
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Dec 2020 09:54:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728941AbgLYIxq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Dec 2020 03:53:46 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:9687 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725863AbgLYIxp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Dec 2020 03:53:45 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4D2LKP6wDJzkwCq;
        Fri, 25 Dec 2020 16:51:53 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.498.0; Fri, 25 Dec 2020 16:52:40 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: enhance to update i_mode and acl atomically in f2fs_setattr()
Date:   Fri, 25 Dec 2020 16:52:27 +0800
Message-ID: <20201225085227.114230-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previously, in f2fs_setattr(), we don't update S_ISUID|S_ISGID|S_ISVTX
bits with S_IRWXUGO bits and acl entries atomically, so in error path,
chmod() may partially success, this patch enhances to make chmod() flow
being atomical.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/acl.c   | 23 ++++++++++++++++++++++-
 fs/f2fs/file.c  |  7 ++++---
 fs/f2fs/xattr.c | 15 +++++++++------
 3 files changed, 35 insertions(+), 10 deletions(-)

diff --git a/fs/f2fs/acl.c b/fs/f2fs/acl.c
index 1e5e9b1136ee..732ec10e7890 100644
--- a/fs/f2fs/acl.c
+++ b/fs/f2fs/acl.c
@@ -200,6 +200,27 @@ struct posix_acl *f2fs_get_acl(struct inode *inode, int type)
 	return __f2fs_get_acl(inode, type, NULL);
 }
 
+static int f2fs_acl_update_mode(struct inode *inode, umode_t *mode_p,
+			  struct posix_acl **acl)
+{
+	umode_t mode = inode->i_mode;
+	int error;
+
+	if (is_inode_flag_set(inode, FI_ACL_MODE))
+		mode = F2FS_I(inode)->i_acl_mode;
+
+	error = posix_acl_equiv_mode(*acl, &mode);
+	if (error < 0)
+		return error;
+	if (error == 0)
+		*acl = NULL;
+	if (!in_group_p(inode->i_gid) &&
+	    !capable_wrt_inode_uidgid(inode, CAP_FSETID))
+		mode &= ~S_ISGID;
+	*mode_p = mode;
+	return 0;
+}
+
 static int __f2fs_set_acl(struct inode *inode, int type,
 			struct posix_acl *acl, struct page *ipage)
 {
@@ -213,7 +234,7 @@ static int __f2fs_set_acl(struct inode *inode, int type,
 	case ACL_TYPE_ACCESS:
 		name_index = F2FS_XATTR_INDEX_POSIX_ACL_ACCESS;
 		if (acl && !ipage) {
-			error = posix_acl_update_mode(inode, &mode, &acl);
+			error = f2fs_acl_update_mode(inode, &mode, &acl);
 			if (error)
 				return error;
 			set_acl_inode(inode, mode);
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 596778f662fd..22a0101538c0 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -851,7 +851,6 @@ static void __setattr_copy(struct inode *inode, const struct iattr *attr)
 		if (!in_group_p(inode->i_gid) &&
 			!capable_wrt_inode_uidgid(inode, CAP_FSETID))
 			mode &= ~S_ISGID;
-		inode->i_mode = (inode->i_mode & S_IRWXUGO) | (mode & ~S_IRWXUGO);
 		set_acl_inode(inode, mode);
 	}
 }
@@ -951,8 +950,10 @@ int f2fs_setattr(struct dentry *dentry, struct iattr *attr)
 
 	if (attr->ia_valid & ATTR_MODE) {
 		err = posix_acl_chmod(inode, f2fs_get_inode_mode(inode));
-		if (err || is_inode_flag_set(inode, FI_ACL_MODE)) {
-			inode->i_mode = F2FS_I(inode)->i_acl_mode;
+
+		if (is_inode_flag_set(inode, FI_ACL_MODE)) {
+			if (!err)
+				inode->i_mode = F2FS_I(inode)->i_acl_mode;
 			clear_inode_flag(inode, FI_ACL_MODE);
 		}
 	}
diff --git a/fs/f2fs/xattr.c b/fs/f2fs/xattr.c
index 65afcc3cc68a..2086bef6c154 100644
--- a/fs/f2fs/xattr.c
+++ b/fs/f2fs/xattr.c
@@ -673,7 +673,7 @@ static int __f2fs_setxattr(struct inode *inode, int index,
 		}
 
 		if (value && f2fs_xattr_value_same(here, value, size))
-			goto exit;
+			goto same;
 	} else if ((flags & XATTR_REPLACE)) {
 		error = -ENODATA;
 		goto exit;
@@ -738,17 +738,20 @@ static int __f2fs_setxattr(struct inode *inode, int index,
 	if (error)
 		goto exit;
 
-	if (is_inode_flag_set(inode, FI_ACL_MODE)) {
-		inode->i_mode = F2FS_I(inode)->i_acl_mode;
-		inode->i_ctime = current_time(inode);
-		clear_inode_flag(inode, FI_ACL_MODE);
-	}
 	if (index == F2FS_XATTR_INDEX_ENCRYPTION &&
 			!strcmp(name, F2FS_XATTR_NAME_ENCRYPTION_CONTEXT))
 		f2fs_set_encrypted_inode(inode);
 	f2fs_mark_inode_dirty_sync(inode, true);
 	if (!error && S_ISDIR(inode->i_mode))
 		set_sbi_flag(F2FS_I_SB(inode), SBI_NEED_CP);
+
+same:
+	if (is_inode_flag_set(inode, FI_ACL_MODE)) {
+		inode->i_mode = F2FS_I(inode)->i_acl_mode;
+		inode->i_ctime = current_time(inode);
+		clear_inode_flag(inode, FI_ACL_MODE);
+	}
+
 exit:
 	kfree(base_addr);
 	return error;
-- 
2.29.2

