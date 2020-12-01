Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 170C72CA8C9
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 17:53:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389178AbgLAQwD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 11:52:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:36870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387953AbgLAQwC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 11:52:02 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3605A20758;
        Tue,  1 Dec 2020 16:51:19 +0000 (UTC)
Date:   Tue, 1 Dec 2020 11:51:17 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Righi <andrea.righi@canonical.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Minchan Kim <minchan@kernel.org>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Vasily Averin <vvs@virtuozzo.com>
Subject: [GIT PULL] tracing: Fixes for 5.10-rc6
Message-ID: <20201201115117.056f3c1f@gandalf.local.home>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

Tracing fixes for 5.10-rc6

 - Use correct timestamp variable for ring buffer write stamp update
 - Fix up before stamp and write stamp when crossing ring buffer sub
   buffers
 - Keep a zero delta in ring buffer in slow path if cmpxchg fails
 - Fix trace_printk static buffer alignment for archs that care
 - Fix ftrace record accounting for ftrace ops with trampolines
 - Fix DYNAMIC_FTRACE_WITH_DIRECT_CALLS dependency
 - Remove WARN_ON in hwlat tracer that triggers on something that is OK
 - Make "my_tramp" trampoline in ftrace direct sample code global
 - Fixes in the bootconfig tool for better alignment management


Please pull the latest trace-v5.10-rc6 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
trace-v5.10-rc6

Tag SHA1: 12fb5fc11f67463def8e96a7d35c94832bb061f9
Head SHA1: 68e10d5ff512b503dcba1246ad5620f32035e135


Andrea Righi (1):
      ring-buffer: Set the right timestamp in the slow path of __rb_reserve_next()

Masami Hiramatsu (4):
      tools/bootconfig: Fix errno reference after printf()
      tools/bootconfig: Fix to check the write failure correctly
      tools/bootconfig: Align the bootconfig applied initrd image size to 4
      docs: bootconfig: Update file format on initrd image

Minchan Kim (1):
      tracing: Fix alignment of static buffer

Naveen N. Rao (2):
      ftrace: Fix updating FTRACE_FL_TRAMP
      ftrace: Fix DYNAMIC_FTRACE_WITH_DIRECT_CALLS dependency

Sami Tolvanen (1):
      samples/ftrace: Mark my_tramp[12]? global

Steven Rostedt (VMware) (2):
      ring-buffer: Update write stamp with the correct ts
      ring-buffer: Always check to put back before stamp when crossing pages

Vasily Averin (1):
      tracing: Remove WARN_ON in start_thread()

----
 Documentation/admin-guide/bootconfig.rst |  18 +++--
 include/linux/bootconfig.h               |   3 +
 kernel/trace/Kconfig                     |   2 +-
 kernel/trace/ftrace.c                    |  22 +++++-
 kernel/trace/ring_buffer.c               |  20 +++--
 kernel/trace/trace.c                     |   2 +-
 kernel/trace/trace_hwlat.c               |   2 +-
 samples/ftrace/ftrace-direct-modify.c    |   2 +
 samples/ftrace/ftrace-direct-too.c       |   1 +
 samples/ftrace/ftrace-direct.c           |   1 +
 tools/bootconfig/main.c                  | 121 ++++++++++++++++++++-----------
 tools/bootconfig/test-bootconfig.sh      |   6 +-
 12 files changed, 138 insertions(+), 62 deletions(-)
---------------------------
diff --git a/Documentation/admin-guide/bootconfig.rst b/Documentation/admin-guide/bootconfig.rst
index a22024f9175e..363599683784 100644
--- a/Documentation/admin-guide/bootconfig.rst
+++ b/Documentation/admin-guide/bootconfig.rst
@@ -137,15 +137,22 @@ Boot Kernel With a Boot Config
 ==============================
 
 Since the boot configuration file is loaded with initrd, it will be added
-to the end of the initrd (initramfs) image file with size, checksum and
-12-byte magic word as below.
+to the end of the initrd (initramfs) image file with padding, size,
+checksum and 12-byte magic word as below.
 
-[initrd][bootconfig][size(u32)][checksum(u32)][#BOOTCONFIG\n]
+[initrd][bootconfig][padding][size(u32)][checksum(u32)][#BOOTCONFIG\n]
+
+When the boot configuration is added to the initrd image, the total
+file size is aligned to 4 bytes. To fill the gap, null characters
+(``\0``) will be added. Thus the ``size`` is the length of the bootconfig
+file + padding bytes.
 
 The Linux kernel decodes the last part of the initrd image in memory to
 get the boot configuration data.
 Because of this "piggyback" method, there is no need to change or
-update the boot loader and the kernel image itself.
+update the boot loader and the kernel image itself as long as the boot
+loader passes the correct initrd file size. If by any chance, the boot
+loader passes a longer size, the kernel feils to find the bootconfig data.
 
 To do this operation, Linux kernel provides "bootconfig" command under
 tools/bootconfig, which allows admin to apply or delete the config file
@@ -176,7 +183,8 @@ up to 512 key-value pairs. If keys contains 3 words in average, it can
 contain 256 key-value pairs. In most cases, the number of config items
 will be under 100 entries and smaller than 8KB, so it would be enough.
 If the node number exceeds 1024, parser returns an error even if the file
-size is smaller than 32KB.
+size is smaller than 32KB. (Note that this maximum size is not including
+the padding null characters.)
 Anyway, since bootconfig command verifies it when appending a boot config
 to initrd image, user can notice it before boot.
 
diff --git a/include/linux/bootconfig.h b/include/linux/bootconfig.h
index 9903088891fa..2696eb0fc149 100644
--- a/include/linux/bootconfig.h
+++ b/include/linux/bootconfig.h
@@ -12,6 +12,9 @@
 
 #define BOOTCONFIG_MAGIC	"#BOOTCONFIG\n"
 #define BOOTCONFIG_MAGIC_LEN	12
+#define BOOTCONFIG_ALIGN_SHIFT	2
+#define BOOTCONFIG_ALIGN	(1 << BOOTCONFIG_ALIGN_SHIFT)
+#define BOOTCONFIG_ALIGN_MASK	(BOOTCONFIG_ALIGN - 1)
 
 /* XBC tree node */
 struct xbc_node {
diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index a4020c0b4508..e1bf5228fb69 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -202,7 +202,7 @@ config DYNAMIC_FTRACE_WITH_REGS
 
 config DYNAMIC_FTRACE_WITH_DIRECT_CALLS
 	def_bool y
-	depends on DYNAMIC_FTRACE
+	depends on DYNAMIC_FTRACE_WITH_REGS
 	depends on HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
 
 config FUNCTION_PROFILER
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 8185f7240095..9c1bba8cc51b 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -1629,6 +1629,8 @@ static bool test_rec_ops_needs_regs(struct dyn_ftrace *rec)
 static struct ftrace_ops *
 ftrace_find_tramp_ops_any(struct dyn_ftrace *rec);
 static struct ftrace_ops *
+ftrace_find_tramp_ops_any_other(struct dyn_ftrace *rec, struct ftrace_ops *op_exclude);
+static struct ftrace_ops *
 ftrace_find_tramp_ops_next(struct dyn_ftrace *rec, struct ftrace_ops *ops);
 
 static bool __ftrace_hash_rec_update(struct ftrace_ops *ops,
@@ -1778,7 +1780,7 @@ static bool __ftrace_hash_rec_update(struct ftrace_ops *ops,
 			 * to it.
 			 */
 			if (ftrace_rec_count(rec) == 1 &&
-			    ftrace_find_tramp_ops_any(rec))
+			    ftrace_find_tramp_ops_any_other(rec, ops))
 				rec->flags |= FTRACE_FL_TRAMP;
 			else
 				rec->flags &= ~FTRACE_FL_TRAMP;
@@ -2244,6 +2246,24 @@ ftrace_find_tramp_ops_any(struct dyn_ftrace *rec)
 	return NULL;
 }
 
+static struct ftrace_ops *
+ftrace_find_tramp_ops_any_other(struct dyn_ftrace *rec, struct ftrace_ops *op_exclude)
+{
+	struct ftrace_ops *op;
+	unsigned long ip = rec->ip;
+
+	do_for_each_ftrace_op(op, ftrace_ops_list) {
+
+		if (op == op_exclude || !op->trampoline)
+			continue;
+
+		if (hash_contains_ip(ip, op->func_hash))
+			return op;
+	} while_for_each_ftrace_op(op);
+
+	return NULL;
+}
+
 static struct ftrace_ops *
 ftrace_find_tramp_ops_next(struct dyn_ftrace *rec,
 			   struct ftrace_ops *op)
diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index dc83b3fa9fe7..a6268e09160a 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -3234,14 +3234,12 @@ __rb_reserve_next(struct ring_buffer_per_cpu *cpu_buffer,
 
 	/* See if we shot pass the end of this buffer page */
 	if (unlikely(write > BUF_PAGE_SIZE)) {
-		if (tail != w) {
-			/* before and after may now different, fix it up*/
-			b_ok = rb_time_read(&cpu_buffer->before_stamp, &info->before);
-			a_ok = rb_time_read(&cpu_buffer->write_stamp, &info->after);
-			if (a_ok && b_ok && info->before != info->after)
-				(void)rb_time_cmpxchg(&cpu_buffer->before_stamp,
-						      info->before, info->after);
-		}
+		/* before and after may now different, fix it up*/
+		b_ok = rb_time_read(&cpu_buffer->before_stamp, &info->before);
+		a_ok = rb_time_read(&cpu_buffer->write_stamp, &info->after);
+		if (a_ok && b_ok && info->before != info->after)
+			(void)rb_time_cmpxchg(&cpu_buffer->before_stamp,
+					      info->before, info->after);
 		return rb_move_tail(cpu_buffer, tail, info);
 	}
 
@@ -3287,11 +3285,11 @@ __rb_reserve_next(struct ring_buffer_per_cpu *cpu_buffer,
 		ts = rb_time_stamp(cpu_buffer->buffer);
 		barrier();
  /*E*/		if (write == (local_read(&tail_page->write) & RB_WRITE_MASK) &&
-		    info->after < ts) {
+		    info->after < ts &&
+		    rb_time_cmpxchg(&cpu_buffer->write_stamp,
+				    info->after, ts)) {
 			/* Nothing came after this event between C and E */
 			info->delta = ts - info->after;
-			(void)rb_time_cmpxchg(&cpu_buffer->write_stamp,
-					      info->after, info->ts);
 			info->ts = ts;
 		} else {
 			/*
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 410cfeb16db5..7d53c5bdea3e 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -3534,7 +3534,7 @@ __find_next_entry(struct trace_iterator *iter, int *ent_cpu,
 }
 
 #define STATIC_TEMP_BUF_SIZE	128
-static char static_temp_buf[STATIC_TEMP_BUF_SIZE];
+static char static_temp_buf[STATIC_TEMP_BUF_SIZE] __aligned(4);
 
 /* Find the next real entry, without updating the iterator itself */
 struct trace_entry *trace_find_next_entry(struct trace_iterator *iter,
diff --git a/kernel/trace/trace_hwlat.c b/kernel/trace/trace_hwlat.c
index c9ad5c6fbaad..d071fc271eef 100644
--- a/kernel/trace/trace_hwlat.c
+++ b/kernel/trace/trace_hwlat.c
@@ -368,7 +368,7 @@ static int start_kthread(struct trace_array *tr)
 	struct task_struct *kthread;
 	int next_cpu;
 
-	if (WARN_ON(hwlat_kthread))
+	if (hwlat_kthread)
 		return 0;
 
 	/* Just pick the first CPU on first iteration */
diff --git a/samples/ftrace/ftrace-direct-modify.c b/samples/ftrace/ftrace-direct-modify.c
index c13a5bc5095b..5b9a09957c6e 100644
--- a/samples/ftrace/ftrace-direct-modify.c
+++ b/samples/ftrace/ftrace-direct-modify.c
@@ -21,6 +21,7 @@ static unsigned long my_ip = (unsigned long)schedule;
 asm (
 "	.pushsection    .text, \"ax\", @progbits\n"
 "	.type		my_tramp1, @function\n"
+"	.globl		my_tramp1\n"
 "   my_tramp1:"
 "	pushq %rbp\n"
 "	movq %rsp, %rbp\n"
@@ -29,6 +30,7 @@ asm (
 "	.size		my_tramp1, .-my_tramp1\n"
 "	ret\n"
 "	.type		my_tramp2, @function\n"
+"	.globl		my_tramp2\n"
 "   my_tramp2:"
 "	pushq %rbp\n"
 "	movq %rsp, %rbp\n"
diff --git a/samples/ftrace/ftrace-direct-too.c b/samples/ftrace/ftrace-direct-too.c
index d5c5022be664..3f0079c9bd6f 100644
--- a/samples/ftrace/ftrace-direct-too.c
+++ b/samples/ftrace/ftrace-direct-too.c
@@ -16,6 +16,7 @@ extern void my_tramp(void *);
 asm (
 "	.pushsection    .text, \"ax\", @progbits\n"
 "	.type		my_tramp, @function\n"
+"	.globl		my_tramp\n"
 "   my_tramp:"
 "	pushq %rbp\n"
 "	movq %rsp, %rbp\n"
diff --git a/samples/ftrace/ftrace-direct.c b/samples/ftrace/ftrace-direct.c
index 63ca06d42c80..a2729d1ef17f 100644
--- a/samples/ftrace/ftrace-direct.c
+++ b/samples/ftrace/ftrace-direct.c
@@ -14,6 +14,7 @@ extern void my_tramp(void *);
 asm (
 "	.pushsection    .text, \"ax\", @progbits\n"
 "	.type		my_tramp, @function\n"
+"	.globl		my_tramp\n"
 "   my_tramp:"
 "	pushq %rbp\n"
 "	movq %rsp, %rbp\n"
diff --git a/tools/bootconfig/main.c b/tools/bootconfig/main.c
index eb92027817a7..4a445b6304bb 100644
--- a/tools/bootconfig/main.c
+++ b/tools/bootconfig/main.c
@@ -147,6 +147,12 @@ static int load_xbc_file(const char *path, char **buf)
 	return ret;
 }
 
+static int pr_errno(const char *msg, int err)
+{
+	pr_err("%s: %d\n", msg, err);
+	return err;
+}
+
 static int load_xbc_from_initrd(int fd, char **buf)
 {
 	struct stat stat;
@@ -162,26 +168,24 @@ static int load_xbc_from_initrd(int fd, char **buf)
 	if (stat.st_size < 8 + BOOTCONFIG_MAGIC_LEN)
 		return 0;
 
-	if (lseek(fd, -BOOTCONFIG_MAGIC_LEN, SEEK_END) < 0) {
-		pr_err("Failed to lseek: %d\n", -errno);
-		return -errno;
-	}
+	if (lseek(fd, -BOOTCONFIG_MAGIC_LEN, SEEK_END) < 0)
+		return pr_errno("Failed to lseek for magic", -errno);
+
 	if (read(fd, magic, BOOTCONFIG_MAGIC_LEN) < 0)
-		return -errno;
+		return pr_errno("Failed to read", -errno);
+
 	/* Check the bootconfig magic bytes */
 	if (memcmp(magic, BOOTCONFIG_MAGIC, BOOTCONFIG_MAGIC_LEN) != 0)
 		return 0;
 
-	if (lseek(fd, -(8 + BOOTCONFIG_MAGIC_LEN), SEEK_END) < 0) {
-		pr_err("Failed to lseek: %d\n", -errno);
-		return -errno;
-	}
+	if (lseek(fd, -(8 + BOOTCONFIG_MAGIC_LEN), SEEK_END) < 0)
+		return pr_errno("Failed to lseek for size", -errno);
 
 	if (read(fd, &size, sizeof(u32)) < 0)
-		return -errno;
+		return pr_errno("Failed to read size", -errno);
 
 	if (read(fd, &csum, sizeof(u32)) < 0)
-		return -errno;
+		return pr_errno("Failed to read checksum", -errno);
 
 	/* Wrong size error  */
 	if (stat.st_size < size + 8 + BOOTCONFIG_MAGIC_LEN) {
@@ -190,10 +194,8 @@ static int load_xbc_from_initrd(int fd, char **buf)
 	}
 
 	if (lseek(fd, stat.st_size - (size + 8 + BOOTCONFIG_MAGIC_LEN),
-		  SEEK_SET) < 0) {
-		pr_err("Failed to lseek: %d\n", -errno);
-		return -errno;
-	}
+		  SEEK_SET) < 0)
+		return pr_errno("Failed to lseek", -errno);
 
 	ret = load_xbc_fd(fd, buf, size);
 	if (ret < 0)
@@ -262,14 +264,16 @@ static int show_xbc(const char *path, bool list)
 
 	ret = stat(path, &st);
 	if (ret < 0) {
-		pr_err("Failed to stat %s: %d\n", path, -errno);
-		return -errno;
+		ret = -errno;
+		pr_err("Failed to stat %s: %d\n", path, ret);
+		return ret;
 	}
 
 	fd = open(path, O_RDONLY);
 	if (fd < 0) {
-		pr_err("Failed to open initrd %s: %d\n", path, fd);
-		return -errno;
+		ret = -errno;
+		pr_err("Failed to open initrd %s: %d\n", path, ret);
+		return ret;
 	}
 
 	ret = load_xbc_from_initrd(fd, &buf);
@@ -307,8 +311,9 @@ static int delete_xbc(const char *path)
 
 	fd = open(path, O_RDWR);
 	if (fd < 0) {
-		pr_err("Failed to open initrd %s: %d\n", path, fd);
-		return -errno;
+		ret = -errno;
+		pr_err("Failed to open initrd %s: %d\n", path, ret);
+		return ret;
 	}
 
 	size = load_xbc_from_initrd(fd, &buf);
@@ -332,11 +337,13 @@ static int delete_xbc(const char *path)
 
 static int apply_xbc(const char *path, const char *xbc_path)
 {
+	char *buf, *data, *p;
+	size_t total_size;
+	struct stat stat;
+	const char *msg;
 	u32 size, csum;
-	char *buf, *data;
+	int pos, pad;
 	int ret, fd;
-	const char *msg;
-	int pos;
 
 	ret = load_xbc_file(xbc_path, &buf);
 	if (ret < 0) {
@@ -346,13 +353,12 @@ static int apply_xbc(const char *path, const char *xbc_path)
 	size = strlen(buf) + 1;
 	csum = checksum((unsigned char *)buf, size);
 
-	/* Prepare xbc_path data */
-	data = malloc(size + 8);
+	/* Backup the bootconfig data */
+	data = calloc(size + BOOTCONFIG_ALIGN +
+		      sizeof(u32) + sizeof(u32) + BOOTCONFIG_MAGIC_LEN, 1);
 	if (!data)
 		return -ENOMEM;
-	strcpy(data, buf);
-	*(u32 *)(data + size) = size;
-	*(u32 *)(data + size + 4) = csum;
+	memcpy(data, buf, size);
 
 	/* Check the data format */
 	ret = xbc_init(buf, &msg, &pos);
@@ -383,28 +389,61 @@ static int apply_xbc(const char *path, const char *xbc_path)
 	/* Apply new one */
 	fd = open(path, O_RDWR | O_APPEND);
 	if (fd < 0) {
-		pr_err("Failed to open %s: %d\n", path, fd);
+		ret = -errno;
+		pr_err("Failed to open %s: %d\n", path, ret);
 		free(data);
-		return fd;
+		return ret;
 	}
 	/* TODO: Ensure the @path is initramfs/initrd image */
-	ret = write(fd, data, size + 8);
-	if (ret < 0) {
-		pr_err("Failed to apply a boot config: %d\n", ret);
+	if (fstat(fd, &stat) < 0) {
+		pr_err("Failed to get the size of %s\n", path);
 		goto out;
 	}
-	/* Write a magic word of the bootconfig */
-	ret = write(fd, BOOTCONFIG_MAGIC, BOOTCONFIG_MAGIC_LEN);
-	if (ret < 0) {
-		pr_err("Failed to apply a boot config magic: %d\n", ret);
-		goto out;
-	}
-	ret = 0;
+
+	/* To align up the total size to BOOTCONFIG_ALIGN, get padding size */
+	total_size = stat.st_size + size + sizeof(u32) * 2 + BOOTCONFIG_MAGIC_LEN;
+	pad = ((total_size + BOOTCONFIG_ALIGN - 1) & (~BOOTCONFIG_ALIGN_MASK)) - total_size;
+	size += pad;
+
+	/* Add a footer */
+	p = data + size;
+	*(u32 *)p = size;
+	p += sizeof(u32);
+
+	*(u32 *)p = csum;
+	p += sizeof(u32);
+
+	memcpy(p, BOOTCONFIG_MAGIC, BOOTCONFIG_MAGIC_LEN);
+	p += BOOTCONFIG_MAGIC_LEN;
+
+	total_size = p - data;
+
+	ret = write(fd, data, total_size);
+	if (ret < total_size) {
+		if (ret < 0)
+			ret = -errno;
+		pr_err("Failed to apply a boot config: %d\n", ret);
+		if (ret >= 0)
+			goto out_rollback;
+	} else
+		ret = 0;
+
 out:
 	close(fd);
 	free(data);
 
 	return ret;
+
+out_rollback:
+	/* Map the partial write to -ENOSPC */
+	if (ret >= 0)
+		ret = -ENOSPC;
+	if (ftruncate(fd, stat.st_size) < 0) {
+		ret = -errno;
+		pr_err("Failed to rollback the write error: %d\n", ret);
+		pr_err("The initrd %s may be corrupted. Recommend to rebuild.\n", path);
+	}
+	goto out;
 }
 
 static int usage(void)
diff --git a/tools/bootconfig/test-bootconfig.sh b/tools/bootconfig/test-bootconfig.sh
index d295e406a756..baed891d0ba4 100755
--- a/tools/bootconfig/test-bootconfig.sh
+++ b/tools/bootconfig/test-bootconfig.sh
@@ -9,6 +9,7 @@ else
   TESTDIR=.
 fi
 BOOTCONF=${TESTDIR}/bootconfig
+ALIGN=4
 
 INITRD=`mktemp ${TESTDIR}/initrd-XXXX`
 TEMPCONF=`mktemp ${TESTDIR}/temp-XXXX.bconf`
@@ -59,7 +60,10 @@ echo "Show command test"
 xpass $BOOTCONF $INITRD
 
 echo "File size check"
-xpass test $new_size -eq $(expr $bconf_size + $initrd_size + 9 + 12)
+total_size=$(expr $bconf_size + $initrd_size + 9 + 12 + $ALIGN - 1 )
+total_size=$(expr $total_size / $ALIGN)
+total_size=$(expr $total_size \* $ALIGN)
+xpass test $new_size -eq $total_size
 
 echo "Apply command repeat test"
 xpass $BOOTCONF -a $TEMPCONF $INITRD
