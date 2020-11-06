Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A09542A8FB5
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 07:54:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726236AbgKFGyD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 01:54:03 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:7416 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbgKFGyD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 01:54:03 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4CSB1r6X62z72JH;
        Fri,  6 Nov 2020 14:53:52 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.487.0; Fri, 6 Nov 2020 14:53:46 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>,
        Eric Biggers <ebiggers@google.com>
Subject: [PATCH v4 2/2] f2fs: fix compat F2FS_IOC_{MOVE,GARBAGE_COLLECT}_RANGE
Date:   Fri, 6 Nov 2020 14:53:31 +0800
Message-ID: <20201106065331.76236-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Eric reported a ioctl bug in below link:

https://lore.kernel.org/linux-f2fs-devel/20201103032234.GB2875@sol.localdomain/

That said, on some 32-bit architectures, u64 has only 32-bit alignment,
notably i386 and x86_32, so that size of struct f2fs_gc_range compiled
in x86_32 is 20 bytes, however the size in x86_64 is 24 bytes, binary
compiled in x86_32 can not call F2FS_IOC_GARBAGE_COLLECT_RANGE successfully
due to mismatched value of ioctl command in between binary and f2fs
module, similarly, F2FS_IOC_MOVE_RANGE will fail too.

In this patch we introduce two ioctls for compatibility of above special
32-bit binary:
- F2FS_IOC32_GARBAGE_COLLECT_RANGE
- F2FS_IOC32_MOVE_RANGE

Reported-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
v4:
- add Reported-by tag
- avoid redundant codes for cleanup
- move compat definitions to .c
 fs/f2fs/file.c | 127 +++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 101 insertions(+), 26 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 22ae8ae0072f..1464a8d8e969 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -2480,26 +2480,19 @@ static int f2fs_ioc_gc(struct file *filp, unsigned long arg)
 	return ret;
 }
 
-static int f2fs_ioc_gc_range(struct file *filp, unsigned long arg)
+static int __f2fs_ioc_gc_range(struct file *filp, struct f2fs_gc_range *range)
 {
-	struct inode *inode = file_inode(filp);
-	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
-	struct f2fs_gc_range range;
+	struct f2fs_sb_info *sbi = F2FS_I_SB(file_inode(filp));
 	u64 end;
 	int ret;
 
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
-
-	if (copy_from_user(&range, (struct f2fs_gc_range __user *)arg,
-							sizeof(range)))
-		return -EFAULT;
-
 	if (f2fs_readonly(sbi->sb))
 		return -EROFS;
 
-	end = range.start + range.len;
-	if (end < range.start || range.start < MAIN_BLKADDR(sbi) ||
+	end = range->start + range->len;
+	if (end < range->start || range->start < MAIN_BLKADDR(sbi) ||
 					end >= MAX_BLKADDR(sbi))
 		return -EINVAL;
 
@@ -2508,7 +2501,7 @@ static int f2fs_ioc_gc_range(struct file *filp, unsigned long arg)
 		return ret;
 
 do_more:
-	if (!range.sync) {
+	if (!range->sync) {
 		if (!down_write_trylock(&sbi->gc_lock)) {
 			ret = -EBUSY;
 			goto out;
@@ -2517,20 +2510,30 @@ static int f2fs_ioc_gc_range(struct file *filp, unsigned long arg)
 		down_write(&sbi->gc_lock);
 	}
 
-	ret = f2fs_gc(sbi, range.sync, true, GET_SEGNO(sbi, range.start));
+	ret = f2fs_gc(sbi, range->sync, true, GET_SEGNO(sbi, range->start));
 	if (ret) {
 		if (ret == -EBUSY)
 			ret = -EAGAIN;
 		goto out;
 	}
-	range.start += BLKS_PER_SEC(sbi);
-	if (range.start <= end)
+	range->start += BLKS_PER_SEC(sbi);
+	if (range->start <= end)
 		goto do_more;
 out:
 	mnt_drop_write_file(filp);
 	return ret;
 }
 
+static int f2fs_ioc_gc_range(struct file *filp, unsigned long arg)
+{
+	struct f2fs_gc_range range;
+
+	if (copy_from_user(&range, (struct f2fs_gc_range __user *)arg,
+							sizeof(range)))
+		return -EFAULT;
+	return __f2fs_ioc_gc_range(filp, &range);
+}
+
 static int f2fs_ioc_write_checkpoint(struct file *filp, unsigned long arg)
 {
 	struct inode *inode = file_inode(filp);
@@ -2867,9 +2870,9 @@ static int f2fs_move_file_range(struct file *file_in, loff_t pos_in,
 	return ret;
 }
 
-static int f2fs_ioc_move_range(struct file *filp, unsigned long arg)
+static int __f2fs_ioc_move_range(struct file *filp,
+				struct f2fs_move_range *range)
 {
-	struct f2fs_move_range range;
 	struct fd dst;
 	int err;
 
@@ -2877,11 +2880,7 @@ static int f2fs_ioc_move_range(struct file *filp, unsigned long arg)
 			!(filp->f_mode & FMODE_WRITE))
 		return -EBADF;
 
-	if (copy_from_user(&range, (struct f2fs_move_range __user *)arg,
-							sizeof(range)))
-		return -EFAULT;
-
-	dst = fdget(range.dst_fd);
+	dst = fdget(range->dst_fd);
 	if (!dst.file)
 		return -EBADF;
 
@@ -2894,8 +2893,8 @@ static int f2fs_ioc_move_range(struct file *filp, unsigned long arg)
 	if (err)
 		goto err_out;
 
-	err = f2fs_move_file_range(filp, range.pos_in, dst.file,
-					range.pos_out, range.len);
+	err = f2fs_move_file_range(filp, range->pos_in, dst.file,
+					range->pos_out, range->len);
 
 	mnt_drop_write_file(filp);
 err_out:
@@ -2903,6 +2902,16 @@ static int f2fs_ioc_move_range(struct file *filp, unsigned long arg)
 	return err;
 }
 
+static int f2fs_ioc_move_range(struct file *filp, unsigned long arg)
+{
+	struct f2fs_move_range range;
+
+	if (copy_from_user(&range, (struct f2fs_move_range __user *)arg,
+							sizeof(range)))
+		return -EFAULT;
+	return __f2fs_ioc_move_range(filp, &range);
+}
+
 static int f2fs_ioc_flush_device(struct file *filp, unsigned long arg)
 {
 	struct inode *inode = file_inode(filp);
@@ -4230,6 +4239,70 @@ static ssize_t f2fs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 }
 
 #ifdef CONFIG_COMPAT
+#if defined(__KERNEL__)
+struct compat_f2fs_gc_range {
+	u32 sync;
+	compat_u64 start;
+	compat_u64 len;
+};
+#define F2FS_IOC32_GARBAGE_COLLECT_RANGE	_IOW(F2FS_IOCTL_MAGIC, 11,\
+						struct compat_f2fs_gc_range)
+#endif
+static int f2fs_compat_ioc_gc_range(struct file *file, unsigned long arg)
+{
+	struct f2fs_sb_info *sbi = F2FS_I_SB(file_inode(file));
+	struct compat_f2fs_gc_range __user *urange;
+	struct f2fs_gc_range range;
+	int err;
+
+	if (unlikely(f2fs_cp_error(sbi)))
+		return -EIO;
+	if (!f2fs_is_checkpoint_ready(sbi))
+		return -ENOSPC;
+
+	urange = compat_ptr(arg);
+	err = get_user(range.sync, &urange->sync);
+	err |= get_user(range.start, &urange->start);
+	err |= get_user(range.len, &urange->len);
+	if (err)
+		return -EFAULT;
+
+	return __f2fs_ioc_gc_range(file, &range);
+}
+
+#if defined(__KERNEL__)
+struct compat_f2fs_move_range {
+	u32 dst_fd;
+	compat_u64 pos_in;
+	compat_u64 pos_out;
+	compat_u64 len;
+};
+#define F2FS_IOC32_MOVE_RANGE		_IOWR(F2FS_IOCTL_MAGIC, 9,	\
+					struct compat_f2fs_move_range)
+#endif
+static int f2fs_compat_ioc_move_range(struct file *file, unsigned long arg)
+{
+	struct f2fs_sb_info *sbi = F2FS_I_SB(file_inode(file));
+	struct compat_f2fs_move_range __user *urange;
+	struct f2fs_move_range range;
+	int err;
+
+	if (unlikely(f2fs_cp_error(sbi)))
+		return -EIO;
+	if (!f2fs_is_checkpoint_ready(sbi))
+		return -ENOSPC;
+
+	urange = compat_ptr(arg);
+	err = get_user(range.dst_fd, &urange->dst_fd);
+	err |= get_user(range.pos_in, &urange->pos_in);
+	err |= get_user(range.pos_out, &urange->pos_out);
+	err |= get_user(range.len, &urange->len);
+	if (err)
+		return -EFAULT;
+
+	return __f2fs_ioc_move_range(file, &range);
+}
+
 long f2fs_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 {
 	switch (cmd) {
@@ -4242,6 +4315,10 @@ long f2fs_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 	case FS_IOC32_GETVERSION:
 		cmd = FS_IOC_GETVERSION;
 		break;
+	case F2FS_IOC32_GARBAGE_COLLECT_RANGE:
+		return f2fs_compat_ioc_gc_range(file, arg);
+	case F2FS_IOC32_MOVE_RANGE:
+		return f2fs_compat_ioc_move_range(file, arg);
 	case F2FS_IOC_START_ATOMIC_WRITE:
 	case F2FS_IOC_COMMIT_ATOMIC_WRITE:
 	case F2FS_IOC_START_VOLATILE_WRITE:
@@ -4259,10 +4336,8 @@ long f2fs_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 	case FS_IOC_GET_ENCRYPTION_KEY_STATUS:
 	case FS_IOC_GET_ENCRYPTION_NONCE:
 	case F2FS_IOC_GARBAGE_COLLECT:
-	case F2FS_IOC_GARBAGE_COLLECT_RANGE:
 	case F2FS_IOC_WRITE_CHECKPOINT:
 	case F2FS_IOC_DEFRAGMENT:
-	case F2FS_IOC_MOVE_RANGE:
 	case F2FS_IOC_FLUSH_DEVICE:
 	case F2FS_IOC_GET_FEATURES:
 	case FS_IOC_FSGETXATTR:
-- 
2.26.2

