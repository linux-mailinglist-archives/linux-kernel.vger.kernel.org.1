Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DDDB2A24BB
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 07:22:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726749AbgKBGWM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 01:22:12 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:7567 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725208AbgKBGWL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 01:22:11 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4CPjW266TyzLnLK;
        Mon,  2 Nov 2020 14:22:06 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.487.0; Mon, 2 Nov 2020 14:22:00 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH v3] f2fs: move ioctl interface definitions to separated file
Date:   Mon, 2 Nov 2020 14:21:31 +0800
Message-ID: <20201102062131.14205-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Like other filesystem does, we introduce a new file f2fs.h in path of
include/uapi/linux/, and move f2fs-specified ioctl interface definitions
to that file, after then, in order to use those definitions, userspace
developer only need to include the new header file rather than
copy & paste definitions from fs/f2fs/f2fs.h.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
v3:
- use __u{32,64} rather than u{32,64} in userspace header file.
 MAINTAINERS                 |  1 +
 fs/f2fs/f2fs.h              | 79 ---------------------------------
 fs/f2fs/file.c              |  1 +
 include/trace/events/f2fs.h |  1 +
 include/uapi/linux/f2fs.h   | 87 +++++++++++++++++++++++++++++++++++++
 5 files changed, 90 insertions(+), 79 deletions(-)
 create mode 100644 include/uapi/linux/f2fs.h

diff --git a/MAINTAINERS b/MAINTAINERS
index e73636b75f29..9f02671e874e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6685,6 +6685,7 @@ F:	Documentation/filesystems/f2fs.rst
 F:	fs/f2fs/
 F:	include/linux/f2fs_fs.h
 F:	include/trace/events/f2fs.h
+F:	include/uapi/linux/f2fs.h
 
 F71805F HARDWARE MONITORING DRIVER
 M:	Jean Delvare <jdelvare@suse.com>
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index cb700d797296..99bcf4b44a9c 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -402,85 +402,6 @@ static inline bool __has_cursum_space(struct f2fs_journal *journal,
 	return size <= MAX_SIT_JENTRIES(journal);
 }
 
-/*
- * f2fs-specific ioctl commands
- */
-#define F2FS_IOCTL_MAGIC		0xf5
-#define F2FS_IOC_START_ATOMIC_WRITE	_IO(F2FS_IOCTL_MAGIC, 1)
-#define F2FS_IOC_COMMIT_ATOMIC_WRITE	_IO(F2FS_IOCTL_MAGIC, 2)
-#define F2FS_IOC_START_VOLATILE_WRITE	_IO(F2FS_IOCTL_MAGIC, 3)
-#define F2FS_IOC_RELEASE_VOLATILE_WRITE	_IO(F2FS_IOCTL_MAGIC, 4)
-#define F2FS_IOC_ABORT_VOLATILE_WRITE	_IO(F2FS_IOCTL_MAGIC, 5)
-#define F2FS_IOC_GARBAGE_COLLECT	_IOW(F2FS_IOCTL_MAGIC, 6, __u32)
-#define F2FS_IOC_WRITE_CHECKPOINT	_IO(F2FS_IOCTL_MAGIC, 7)
-#define F2FS_IOC_DEFRAGMENT		_IOWR(F2FS_IOCTL_MAGIC, 8,	\
-						struct f2fs_defragment)
-#define F2FS_IOC_MOVE_RANGE		_IOWR(F2FS_IOCTL_MAGIC, 9,	\
-						struct f2fs_move_range)
-#define F2FS_IOC_FLUSH_DEVICE		_IOW(F2FS_IOCTL_MAGIC, 10,	\
-						struct f2fs_flush_device)
-#define F2FS_IOC_GARBAGE_COLLECT_RANGE	_IOW(F2FS_IOCTL_MAGIC, 11,	\
-						struct f2fs_gc_range)
-#define F2FS_IOC_GET_FEATURES		_IOR(F2FS_IOCTL_MAGIC, 12, __u32)
-#define F2FS_IOC_SET_PIN_FILE		_IOW(F2FS_IOCTL_MAGIC, 13, __u32)
-#define F2FS_IOC_GET_PIN_FILE		_IOR(F2FS_IOCTL_MAGIC, 14, __u32)
-#define F2FS_IOC_PRECACHE_EXTENTS	_IO(F2FS_IOCTL_MAGIC, 15)
-#define F2FS_IOC_RESIZE_FS		_IOW(F2FS_IOCTL_MAGIC, 16, __u64)
-#define F2FS_IOC_GET_COMPRESS_BLOCKS	_IOR(F2FS_IOCTL_MAGIC, 17, __u64)
-#define F2FS_IOC_RELEASE_COMPRESS_BLOCKS				\
-					_IOR(F2FS_IOCTL_MAGIC, 18, __u64)
-#define F2FS_IOC_RESERVE_COMPRESS_BLOCKS				\
-					_IOR(F2FS_IOCTL_MAGIC, 19, __u64)
-#define F2FS_IOC_SEC_TRIM_FILE		_IOW(F2FS_IOCTL_MAGIC, 20,	\
-						struct f2fs_sectrim_range)
-
-/*
- * should be same as XFS_IOC_GOINGDOWN.
- * Flags for going down operation used by FS_IOC_GOINGDOWN
- */
-#define F2FS_IOC_SHUTDOWN	_IOR('X', 125, __u32)	/* Shutdown */
-#define F2FS_GOING_DOWN_FULLSYNC	0x0	/* going down with full sync */
-#define F2FS_GOING_DOWN_METASYNC	0x1	/* going down with metadata */
-#define F2FS_GOING_DOWN_NOSYNC		0x2	/* going down */
-#define F2FS_GOING_DOWN_METAFLUSH	0x3	/* going down with meta flush */
-#define F2FS_GOING_DOWN_NEED_FSCK	0x4	/* going down to trigger fsck */
-
-/*
- * Flags used by F2FS_IOC_SEC_TRIM_FILE
- */
-#define F2FS_TRIM_FILE_DISCARD		0x1	/* send discard command */
-#define F2FS_TRIM_FILE_ZEROOUT		0x2	/* zero out */
-#define F2FS_TRIM_FILE_MASK		0x3
-
-struct f2fs_gc_range {
-	u32 sync;
-	u64 start;
-	u64 len;
-};
-
-struct f2fs_defragment {
-	u64 start;
-	u64 len;
-};
-
-struct f2fs_move_range {
-	u32 dst_fd;		/* destination fd */
-	u64 pos_in;		/* start position in src_fd */
-	u64 pos_out;		/* start position in dst_fd */
-	u64 len;		/* size to move */
-};
-
-struct f2fs_flush_device {
-	u32 dev_num;		/* device number to flush */
-	u32 segments;		/* # of segments to flush */
-};
-
-struct f2fs_sectrim_range {
-	u64 start;
-	u64 len;
-	u64 flags;
-};
-
 /* for inline stuff */
 #define DEF_INLINE_RESERVED_SIZE	1
 static inline int get_extra_isize(struct inode *inode);
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index ee861c6d9ff0..d898f1e2764b 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -31,6 +31,7 @@
 #include "gc.h"
 #include "trace.h"
 #include <trace/events/f2fs.h>
+#include <uapi/linux/f2fs.h>
 
 static vm_fault_t f2fs_filemap_fault(struct vm_fault *vmf)
 {
diff --git a/include/trace/events/f2fs.h b/include/trace/events/f2fs.h
index f8f1e85ff130..56b113e3cd6a 100644
--- a/include/trace/events/f2fs.h
+++ b/include/trace/events/f2fs.h
@@ -6,6 +6,7 @@
 #define _TRACE_F2FS_H
 
 #include <linux/tracepoint.h>
+#include <uapi/linux/f2fs.h>
 
 #define show_dev(dev)		MAJOR(dev), MINOR(dev)
 #define show_dev_ino(entry)	show_dev(entry->dev), (unsigned long)entry->ino
diff --git a/include/uapi/linux/f2fs.h b/include/uapi/linux/f2fs.h
new file mode 100644
index 000000000000..28bcfe8d2c27
--- /dev/null
+++ b/include/uapi/linux/f2fs.h
@@ -0,0 +1,87 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+
+#ifndef _UAPI_LINUX_F2FS_H
+#define _UAPI_LINUX_F2FS_H
+#include <linux/types.h>
+#include <linux/ioctl.h>
+
+/*
+ * f2fs-specific ioctl commands
+ */
+#define F2FS_IOCTL_MAGIC		0xf5
+#define F2FS_IOC_START_ATOMIC_WRITE	_IO(F2FS_IOCTL_MAGIC, 1)
+#define F2FS_IOC_COMMIT_ATOMIC_WRITE	_IO(F2FS_IOCTL_MAGIC, 2)
+#define F2FS_IOC_START_VOLATILE_WRITE	_IO(F2FS_IOCTL_MAGIC, 3)
+#define F2FS_IOC_RELEASE_VOLATILE_WRITE	_IO(F2FS_IOCTL_MAGIC, 4)
+#define F2FS_IOC_ABORT_VOLATILE_WRITE	_IO(F2FS_IOCTL_MAGIC, 5)
+#define F2FS_IOC_GARBAGE_COLLECT	_IOW(F2FS_IOCTL_MAGIC, 6, __u32)
+#define F2FS_IOC_WRITE_CHECKPOINT	_IO(F2FS_IOCTL_MAGIC, 7)
+#define F2FS_IOC_DEFRAGMENT		_IOWR(F2FS_IOCTL_MAGIC, 8,	\
+						struct f2fs_defragment)
+#define F2FS_IOC_MOVE_RANGE		_IOWR(F2FS_IOCTL_MAGIC, 9,	\
+						struct f2fs_move_range)
+#define F2FS_IOC_FLUSH_DEVICE		_IOW(F2FS_IOCTL_MAGIC, 10,	\
+						struct f2fs_flush_device)
+#define F2FS_IOC_GARBAGE_COLLECT_RANGE	_IOW(F2FS_IOCTL_MAGIC, 11,	\
+						struct f2fs_gc_range)
+#define F2FS_IOC_GET_FEATURES		_IOR(F2FS_IOCTL_MAGIC, 12, __u32)
+#define F2FS_IOC_SET_PIN_FILE		_IOW(F2FS_IOCTL_MAGIC, 13, __u32)
+#define F2FS_IOC_GET_PIN_FILE		_IOR(F2FS_IOCTL_MAGIC, 14, __u32)
+#define F2FS_IOC_PRECACHE_EXTENTS	_IO(F2FS_IOCTL_MAGIC, 15)
+#define F2FS_IOC_RESIZE_FS		_IOW(F2FS_IOCTL_MAGIC, 16, __u64)
+#define F2FS_IOC_GET_COMPRESS_BLOCKS	_IOR(F2FS_IOCTL_MAGIC, 17, __u64)
+#define F2FS_IOC_RELEASE_COMPRESS_BLOCKS				\
+					_IOR(F2FS_IOCTL_MAGIC, 18, __u64)
+#define F2FS_IOC_RESERVE_COMPRESS_BLOCKS				\
+					_IOR(F2FS_IOCTL_MAGIC, 19, __u64)
+#define F2FS_IOC_SEC_TRIM_FILE		_IOW(F2FS_IOCTL_MAGIC, 20,	\
+						struct f2fs_sectrim_range)
+
+/*
+ * should be same as XFS_IOC_GOINGDOWN.
+ * Flags for going down operation used by FS_IOC_GOINGDOWN
+ */
+#define F2FS_IOC_SHUTDOWN	_IOR('X', 125, __u32)	/* Shutdown */
+#define F2FS_GOING_DOWN_FULLSYNC	0x0	/* going down with full sync */
+#define F2FS_GOING_DOWN_METASYNC	0x1	/* going down with metadata */
+#define F2FS_GOING_DOWN_NOSYNC		0x2	/* going down */
+#define F2FS_GOING_DOWN_METAFLUSH	0x3	/* going down with meta flush */
+#define F2FS_GOING_DOWN_NEED_FSCK	0x4	/* going down to trigger fsck */
+
+/*
+ * Flags used by F2FS_IOC_SEC_TRIM_FILE
+ */
+#define F2FS_TRIM_FILE_DISCARD		0x1	/* send discard command */
+#define F2FS_TRIM_FILE_ZEROOUT		0x2	/* zero out */
+#define F2FS_TRIM_FILE_MASK		0x3
+
+struct f2fs_gc_range {
+	__u32 sync;
+	__u64 start;
+	__u64 len;
+};
+
+struct f2fs_defragment {
+	__u64 start;
+	__u64 len;
+};
+
+struct f2fs_move_range {
+	__u32 dst_fd;		/* destination fd */
+	__u64 pos_in;		/* start position in src_fd */
+	__u64 pos_out;		/* start position in dst_fd */
+	__u64 len;		/* size to move */
+};
+
+struct f2fs_flush_device {
+	__u32 dev_num;		/* device number to flush */
+	__u32 segments;		/* # of segments to flush */
+};
+
+struct f2fs_sectrim_range {
+	__u64 start;
+	__u64 len;
+	__u64 flags;
+};
+
+#endif /* _UAPI_LINUX_F2FS_H */
-- 
2.26.2

