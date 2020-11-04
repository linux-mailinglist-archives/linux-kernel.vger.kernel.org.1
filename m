Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9A482A5CA6
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 03:19:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730596AbgKDCTc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 21:19:32 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:7139 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730211AbgKDCTc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 21:19:32 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4CQr275BY5z15R4y;
        Wed,  4 Nov 2020 10:19:27 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.487.0; Wed, 4 Nov 2020 10:19:19 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH RFC] f2fs: fix compat F2FS_IOC_{MOVE,GARBAGE_COLLECT}_RANGE
Date:   Wed, 4 Nov 2020 10:19:06 +0800
Message-ID: <20201104021906.108534-1-yuchao0@huawei.com>
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
due to mismatched value of ioctl command in betweeen binary and f2fs
module, similarly, F2FS_IOC_MOVE_RANGE will fail too.

In this patch we introduce two ioctls for compatibility of above special
32-bit binary:
- F2FS_IOC32_GARBAGE_COLLECT_RANGE
- F2FS_IOC32_MOVE_RANGE

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---

Jaegeuk, Eric,

I have no 32-bit machine now, so I don't run any test on this patch,
please take a look at this RFC patch first.

 fs/f2fs/file.c            | 45 +++++++++++++++++++++++++++++++++++++--
 include/uapi/linux/f2fs.h | 25 ++++++++++++++++++++++
 2 files changed, 68 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 52417a2e3f4f..2e0a5469745a 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -4236,6 +4236,45 @@ static ssize_t f2fs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 }
 
 #ifdef CONFIG_COMPAT
+static int f2fs_compat_ioc_gc_range(struct file *file, unsigned long arg)
+{
+	struct compat_f2fs_gc_range __user *urange;
+	struct f2fs_gc_range range;
+	int err;
+
+	urange = compat_ptr(arg);
+	err = get_user(range.sync, &urange->sync);
+	err |= get_user(range.start, &urange->start);
+	err |= get_user(range.len, &urange->len);
+	if (err)
+		return -EFAULT;
+	if (unlikely(f2fs_cp_error(F2FS_I_SB(file_inode(file)))))
+		return -EIO;
+	if (!f2fs_is_checkpoint_ready(F2FS_I_SB(file_inode(file))))
+		return -ENOSPC;
+	return f2fs_ioc_gc_range(file, (unsigned long)&range);
+}
+
+static int f2fs_compat_ioc_move_range(struct file *file, unsigned long arg)
+{
+	struct compat_f2fs_move_range __user *urange;
+	struct f2fs_move_range range;
+	int err;
+
+	urange = compat_ptr(arg);
+	err = get_user(range.dst_fd, &urange->dst_fd);
+	err |= get_user(range.pos_in, &urange->pos_in);
+	err |= get_user(range.pos_out, &urange->pos_out);
+	err |= get_user(range.len, &urange->len);
+	if (err)
+		return -EFAULT;
+	if (unlikely(f2fs_cp_error(F2FS_I_SB(file_inode(file)))))
+		return -EIO;
+	if (!f2fs_is_checkpoint_ready(F2FS_I_SB(file_inode(file))))
+		return -ENOSPC;
+	return f2fs_ioc_move_range(file, (unsigned long)&range);
+}
+
 long f2fs_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 {
 	switch (cmd) {
@@ -4248,6 +4287,10 @@ long f2fs_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
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
@@ -4265,10 +4308,8 @@ long f2fs_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
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
diff --git a/include/uapi/linux/f2fs.h b/include/uapi/linux/f2fs.h
index f00199a2e38b..8c14e88a9645 100644
--- a/include/uapi/linux/f2fs.h
+++ b/include/uapi/linux/f2fs.h
@@ -5,6 +5,10 @@
 #include <linux/types.h>
 #include <linux/ioctl.h>
 
+#ifdef __KERNEL__
+#include <linux/compat.h>
+#endif
+
 /*
  * f2fs-specific ioctl commands
  */
@@ -65,6 +69,16 @@ struct f2fs_gc_range {
 	__u64 len;
 };
 
+#if defined(__KERNEL__) && defined(CONFIG_COMPAT)
+struct compat_f2fs_gc_range {
+	u32 sync;
+	compat_u64 start;
+	compat_u64 len;
+};
+#define F2FS_IOC32_GARBAGE_COLLECT_RANGE	_IOW(F2FS_IOCTL_MAGIC, 11,\
+						struct compat_f2fs_gc_range)
+#endif
+
 struct f2fs_defragment {
 	__u64 start;
 	__u64 len;
@@ -77,6 +91,17 @@ struct f2fs_move_range {
 	__u64 len;		/* size to move */
 };
 
+#if defined(__KERNEL__) && defined(CONFIG_COMPAT)
+struct compat_f2fs_move_range {
+	u32 dst_fd;
+	compat_u64 pos_in;
+	compat_u64 pos_out;
+	compat_u64 len;
+};
+#define F2FS_IOC32_MOVE_RANGE		_IOWR(F2FS_IOCTL_MAGIC, 9,	\
+					struct compat_f2fs_move_range)
+#endif
+
 struct f2fs_flush_device {
 	__u32 dev_num;		/* device number to flush */
 	__u32 segments;		/* # of segments to flush */
-- 
2.26.2

