Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC1FC304FDD
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 04:33:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236185AbhA0Dcd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 22:32:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729205AbhAZVR2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 16:17:28 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35690C061786
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 13:15:57 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1611695755;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0nvQJARPy1bFO0vbzNGXDE69awAXTNQwTWnx4C195ew=;
        b=XyqVxBd9sFldYLrRdNXRqWpeMmJQchbNCWyXc3RCmBO+0qK4xMoERGIIOzokWNzgVfvbQa
        yqnH7JHvTeZFaOgK8EwHlA6Ce2eYz74ir6yIgI+HMR6U6Aq3inyK6A9RybZa5uOvvi7qQr
        6AgAJ6tV+Hrw3o1xS0SWIpFUOTbeUuiG04iqqvPOgNxlEjJg49j/OXEweBravLNrw82L+o
        2YziWfWuoSNqGstmdo+fpvmILH2cuyxtRuh+ZUQ/8Le9aJblPYbI010JcGvbduZERxf9vO
        yPZb1JPrQZ3gpdCvjexjAZqlFy5BJfo/i5aqI+fkS9S8nG8Qg+wKoiMFgtficw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1611695755;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0nvQJARPy1bFO0vbzNGXDE69awAXTNQwTWnx4C195ew=;
        b=VO6uunOo4jL9BnxoXd5zzrEfTWLGGfx+7NIOu7IQNoH3/mIPPH63rB/CQ+4P9Qetf3IYHo
        Rg1roSYVg/eBqhBg==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH printk-rework 08/12] printk: introduce a kmsg_dump iterator
Date:   Tue, 26 Jan 2021 22:21:47 +0106
Message-Id: <20210126211551.26536-9-john.ogness@linutronix.de>
In-Reply-To: <20210126211551.26536-1-john.ogness@linutronix.de>
References: <20210126211551.26536-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rather than store the iterator information into the registered
kmsg_dump structure, create a separate iterator structure. The
kmsg_dump_iter structure can reside on the stack of the caller,
thus allowing lockless use of the kmsg_dump functions.

This is in preparation for removal of @logbuf_lock.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 arch/powerpc/kernel/nvram_64.c             | 12 +++--
 arch/powerpc/platforms/powernv/opal-kmsg.c |  3 +-
 arch/powerpc/xmon/xmon.c                   |  6 +--
 arch/um/kernel/kmsg_dump.c                 |  5 +-
 drivers/hv/vmbus_drv.c                     |  5 +-
 drivers/mtd/mtdoops.c                      |  5 +-
 fs/pstore/platform.c                       |  5 +-
 include/linux/kmsg_dump.h                  | 43 ++++++++-------
 kernel/debug/kdb/kdb_main.c                | 10 ++--
 kernel/printk/printk.c                     | 63 +++++++++++-----------
 10 files changed, 83 insertions(+), 74 deletions(-)

diff --git a/arch/powerpc/kernel/nvram_64.c b/arch/powerpc/kernel/nvram_64.c
index 532f22637783..1ef55f4b389a 100644
--- a/arch/powerpc/kernel/nvram_64.c
+++ b/arch/powerpc/kernel/nvram_64.c
@@ -73,7 +73,8 @@ static const char *nvram_os_partitions[] = {
 };
 
 static void oops_to_nvram(struct kmsg_dumper *dumper,
-			  enum kmsg_dump_reason reason);
+			  enum kmsg_dump_reason reason,
+			  struct kmsg_dumper_iter *iter);
 
 static struct kmsg_dumper nvram_kmsg_dumper = {
 	.dump = oops_to_nvram
@@ -643,7 +644,8 @@ void __init nvram_init_oops_partition(int rtas_partition_exists)
  * partition.  If that's too much, go back and capture uncompressed text.
  */
 static void oops_to_nvram(struct kmsg_dumper *dumper,
-			  enum kmsg_dump_reason reason)
+			  enum kmsg_dump_reason reason,
+			  struct kmsg_dumper_iter *iter)
 {
 	struct oops_log_info *oops_hdr = (struct oops_log_info *)oops_buf;
 	static unsigned int oops_count = 0;
@@ -681,13 +683,13 @@ static void oops_to_nvram(struct kmsg_dumper *dumper,
 		return;
 
 	if (big_oops_buf) {
-		kmsg_dump_get_buffer(dumper, false,
+		kmsg_dump_get_buffer(iter, false,
 				     big_oops_buf, big_oops_buf_sz, &text_len);
 		rc = zip_oops(text_len);
 	}
 	if (rc != 0) {
-		kmsg_dump_rewind(dumper);
-		kmsg_dump_get_buffer(dumper, false,
+		kmsg_dump_rewind(iter);
+		kmsg_dump_get_buffer(iter, false,
 				     oops_data, oops_data_sz, &text_len);
 		err_type = ERR_TYPE_KERNEL_PANIC;
 		oops_hdr->version = cpu_to_be16(OOPS_HDR_VERSION);
diff --git a/arch/powerpc/platforms/powernv/opal-kmsg.c b/arch/powerpc/platforms/powernv/opal-kmsg.c
index 6c3bc4b4da98..ec862846bc82 100644
--- a/arch/powerpc/platforms/powernv/opal-kmsg.c
+++ b/arch/powerpc/platforms/powernv/opal-kmsg.c
@@ -20,7 +20,8 @@
  * message, it just ensures that OPAL completely flushes the console buffer.
  */
 static void kmsg_dump_opal_console_flush(struct kmsg_dumper *dumper,
-				     enum kmsg_dump_reason reason)
+					 enum kmsg_dump_reason reason,
+					 struct kmsg_dumper_iter *iter)
 {
 	/*
 	 * Outside of a panic context the pollers will continue to run,
diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index 55c43a6c9111..43162b885259 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -3003,7 +3003,7 @@ print_address(unsigned long addr)
 static void
 dump_log_buf(void)
 {
-	struct kmsg_dumper dumper = { .active = 1 };
+	struct kmsg_dumper_iter iter = { .active = 1 };
 	unsigned char buf[128];
 	size_t len;
 
@@ -3015,9 +3015,9 @@ dump_log_buf(void)
 	catch_memory_errors = 1;
 	sync();
 
-	kmsg_dump_rewind_nolock(&dumper);
+	kmsg_dump_rewind_nolock(&iter);
 	xmon_start_pagination();
-	while (kmsg_dump_get_line_nolock(&dumper, false, buf, sizeof(buf), &len)) {
+	while (kmsg_dump_get_line_nolock(&iter, false, buf, sizeof(buf), &len)) {
 		buf[len] = '\0';
 		printf("%s", buf);
 	}
diff --git a/arch/um/kernel/kmsg_dump.c b/arch/um/kernel/kmsg_dump.c
index e4abac6c9727..f38349ad00ea 100644
--- a/arch/um/kernel/kmsg_dump.c
+++ b/arch/um/kernel/kmsg_dump.c
@@ -6,7 +6,8 @@
 #include <os.h>
 
 static void kmsg_dumper_stdout(struct kmsg_dumper *dumper,
-				enum kmsg_dump_reason reason)
+				enum kmsg_dump_reason reason,
+				struct kmsg_dumper_iter *iter)
 {
 	static char line[1024];
 	struct console *con;
@@ -25,7 +26,7 @@ static void kmsg_dumper_stdout(struct kmsg_dumper *dumper,
 		return;
 
 	printf("kmsg_dump:\n");
-	while (kmsg_dump_get_line(dumper, true, line, sizeof(line), &len)) {
+	while (kmsg_dump_get_line(iter, true, line, sizeof(line), &len)) {
 		line[len] = '\0';
 		printf("%s", line);
 	}
diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 4fad3e6745e5..fbeddef90941 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -1359,7 +1359,8 @@ static void vmbus_isr(void)
  * buffer and call into Hyper-V to transfer the data.
  */
 static void hv_kmsg_dump(struct kmsg_dumper *dumper,
-			 enum kmsg_dump_reason reason)
+			 enum kmsg_dump_reason reason,
+			 struct kmsg_dumper_iter *iter)
 {
 	size_t bytes_written;
 	phys_addr_t panic_pa;
@@ -1374,7 +1375,7 @@ static void hv_kmsg_dump(struct kmsg_dumper *dumper,
 	 * Write dump contents to the page. No need to synchronize; panic should
 	 * be single-threaded.
 	 */
-	kmsg_dump_get_buffer(dumper, false, hv_panic_page, HV_HYP_PAGE_SIZE,
+	kmsg_dump_get_buffer(iter, false, hv_panic_page, HV_HYP_PAGE_SIZE,
 			     &bytes_written);
 	if (bytes_written)
 		hyperv_report_panic_msg(panic_pa, bytes_written);
diff --git a/drivers/mtd/mtdoops.c b/drivers/mtd/mtdoops.c
index 774970bfcf85..6bc2c728adb7 100644
--- a/drivers/mtd/mtdoops.c
+++ b/drivers/mtd/mtdoops.c
@@ -267,7 +267,8 @@ static void find_next_position(struct mtdoops_context *cxt)
 }
 
 static void mtdoops_do_dump(struct kmsg_dumper *dumper,
-			    enum kmsg_dump_reason reason)
+			    enum kmsg_dump_reason reason,
+			    struct kmsg_dumper_iter *iter)
 {
 	struct mtdoops_context *cxt = container_of(dumper,
 			struct mtdoops_context, dump);
@@ -276,7 +277,7 @@ static void mtdoops_do_dump(struct kmsg_dumper *dumper,
 	if (reason == KMSG_DUMP_OOPS && !dump_oops)
 		return;
 
-	kmsg_dump_get_buffer(dumper, true, cxt->oops_buf + MTDOOPS_HEADER_SIZE,
+	kmsg_dump_get_buffer(iter, true, cxt->oops_buf + MTDOOPS_HEADER_SIZE,
 			     record_size - MTDOOPS_HEADER_SIZE, NULL);
 
 	if (reason != KMSG_DUMP_OOPS) {
diff --git a/fs/pstore/platform.c b/fs/pstore/platform.c
index 36714df37d5d..a939559b0c9a 100644
--- a/fs/pstore/platform.c
+++ b/fs/pstore/platform.c
@@ -383,7 +383,8 @@ void pstore_record_init(struct pstore_record *record,
  * end of the buffer.
  */
 static void pstore_dump(struct kmsg_dumper *dumper,
-			enum kmsg_dump_reason reason)
+			enum kmsg_dump_reason reason,
+			struct kmsg_dumper_iter *iter)
 {
 	unsigned long	total = 0;
 	const char	*why;
@@ -435,7 +436,7 @@ static void pstore_dump(struct kmsg_dumper *dumper,
 		dst_size -= header_size;
 
 		/* Write dump contents. */
-		if (!kmsg_dump_get_buffer(dumper, true, dst + header_size,
+		if (!kmsg_dump_get_buffer(iter, true, dst + header_size,
 					  dst_size, &dump_size))
 			break;
 
diff --git a/include/linux/kmsg_dump.h b/include/linux/kmsg_dump.h
index 76cc4122d08e..ecc98f549d93 100644
--- a/include/linux/kmsg_dump.h
+++ b/include/linux/kmsg_dump.h
@@ -29,6 +29,18 @@ enum kmsg_dump_reason {
 	KMSG_DUMP_MAX
 };
 
+/**
+ * struct kmsg_dumper_iter - iterator for kernel crash message dumper
+ * @active:	Flag that specifies if this is currently dumping
+ * @cur_seq:	The record to dump (private)
+ * @next_seq:	The first record of the next block (private)
+ */
+struct kmsg_dumper_iter {
+	bool	active;
+	u64	cur_seq;
+	u64	next_seq;
+};
+
 /**
  * struct kmsg_dumper - kernel crash message dumper structure
  * @list:	Entry in the dumper list (private)
@@ -36,37 +48,30 @@ enum kmsg_dump_reason {
  * 		through the record iterator
  * @max_reason:	filter for highest reason number that should be dumped
  * @registered:	Flag that specifies if this is already registered
- * @active:	Flag that specifies if this is currently dumping
- * @cur_seq:	The record to dump (private)
- * @next_seq:	The first record of the next block (private)
  */
 struct kmsg_dumper {
 	struct list_head list;
-	void (*dump)(struct kmsg_dumper *dumper, enum kmsg_dump_reason reason);
+	void (*dump)(struct kmsg_dumper *dumper, enum kmsg_dump_reason reason,
+		     struct kmsg_dumper_iter *iter);
 	enum kmsg_dump_reason max_reason;
-	bool active;
 	bool registered;
-
-	/* private state of the kmsg iterator */
-	u64 cur_seq;
-	u64 next_seq;
 };
 
 #ifdef CONFIG_PRINTK
 void kmsg_dump(enum kmsg_dump_reason reason);
 
-bool kmsg_dump_get_line_nolock(struct kmsg_dumper *dumper, bool syslog,
+bool kmsg_dump_get_line_nolock(struct kmsg_dumper_iter *iter, bool syslog,
 			       char *line, size_t size, size_t *len);
 
-bool kmsg_dump_get_line(struct kmsg_dumper *dumper, bool syslog,
+bool kmsg_dump_get_line(struct kmsg_dumper_iter *iter, bool syslog,
 			char *line, size_t size, size_t *len);
 
-bool kmsg_dump_get_buffer(struct kmsg_dumper *dumper, bool syslog,
+bool kmsg_dump_get_buffer(struct kmsg_dumper_iter *iter, bool syslog,
 			  char *buf, size_t size, size_t *len_out);
 
-void kmsg_dump_rewind_nolock(struct kmsg_dumper *dumper);
+void kmsg_dump_rewind_nolock(struct kmsg_dumper_iter *iter);
 
-void kmsg_dump_rewind(struct kmsg_dumper *dumper);
+void kmsg_dump_rewind(struct kmsg_dumper_iter *dumper_iter);
 
 int kmsg_dump_register(struct kmsg_dumper *dumper);
 
@@ -78,30 +83,30 @@ static inline void kmsg_dump(enum kmsg_dump_reason reason)
 {
 }
 
-static inline bool kmsg_dump_get_line_nolock(struct kmsg_dumper *dumper,
+static inline bool kmsg_dump_get_line_nolock(struct kmsg_dumper_iter *iter,
 					     bool syslog, const char *line,
 					     size_t size, size_t *len)
 {
 	return false;
 }
 
-static inline bool kmsg_dump_get_line(struct kmsg_dumper *dumper, bool syslog,
+static inline bool kmsg_dump_get_line(struct kmsg_dumper_iter *iter, bool syslog,
 				const char *line, size_t size, size_t *len)
 {
 	return false;
 }
 
-static inline bool kmsg_dump_get_buffer(struct kmsg_dumper *dumper, bool syslog,
+static inline bool kmsg_dump_get_buffer(struct kmsg_dumper_iter *iter, bool syslog,
 					char *buf, size_t size, size_t *len)
 {
 	return false;
 }
 
-static inline void kmsg_dump_rewind_nolock(struct kmsg_dumper *dumper)
+static inline void kmsg_dump_rewind_nolock(struct kmsg_dumper_iter *iter)
 {
 }
 
-static inline void kmsg_dump_rewind(struct kmsg_dumper *dumper)
+static inline void kmsg_dump_rewind(struct kmsg_dumper_iter *iter)
 {
 }
 
diff --git a/kernel/debug/kdb/kdb_main.c b/kernel/debug/kdb/kdb_main.c
index 930ac1b25ec7..7ae9da245e4b 100644
--- a/kernel/debug/kdb/kdb_main.c
+++ b/kernel/debug/kdb/kdb_main.c
@@ -2101,7 +2101,7 @@ static int kdb_dmesg(int argc, const char **argv)
 	int adjust = 0;
 	int n = 0;
 	int skip = 0;
-	struct kmsg_dumper dumper = { .active = 1 };
+	struct kmsg_dumper_iter iter = { .active = 1 };
 	size_t len;
 	char buf[201];
 
@@ -2126,8 +2126,8 @@ static int kdb_dmesg(int argc, const char **argv)
 		kdb_set(2, setargs);
 	}
 
-	kmsg_dump_rewind_nolock(&dumper);
-	while (kmsg_dump_get_line_nolock(&dumper, 1, NULL, 0, NULL))
+	kmsg_dump_rewind_nolock(&iter);
+	while (kmsg_dump_get_line_nolock(&iter, 1, NULL, 0, NULL))
 		n++;
 
 	if (lines < 0) {
@@ -2159,8 +2159,8 @@ static int kdb_dmesg(int argc, const char **argv)
 	if (skip >= n || skip < 0)
 		return 0;
 
-	kmsg_dump_rewind_nolock(&dumper);
-	while (kmsg_dump_get_line_nolock(&dumper, 1, buf, sizeof(buf), &len)) {
+	kmsg_dump_rewind_nolock(&iter);
+	while (kmsg_dump_get_line_nolock(&iter, 1, buf, sizeof(buf), &len)) {
 		if (skip) {
 			skip--;
 			continue;
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 506d334c065e..d14a4afc5b72 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -3357,6 +3357,7 @@ EXPORT_SYMBOL_GPL(kmsg_dump_reason_str);
  */
 void kmsg_dump(enum kmsg_dump_reason reason)
 {
+	struct kmsg_dumper_iter iter;
 	struct kmsg_dumper *dumper;
 	unsigned long flags;
 
@@ -3376,25 +3377,21 @@ void kmsg_dump(enum kmsg_dump_reason reason)
 			continue;
 
 		/* initialize iterator with data about the stored records */
-		dumper->active = true;
-
+		iter.active = true;
 		logbuf_lock_irqsave(flags);
-		dumper->cur_seq = latched_seq_read_nolock(&clear_seq);
-		dumper->next_seq = prb_next_seq(prb);
+		iter.cur_seq = latched_seq_read_nolock(&clear_seq);
+		iter.next_seq = prb_next_seq(prb);
 		logbuf_unlock_irqrestore(flags);
 
 		/* invoke dumper which will iterate over records */
-		dumper->dump(dumper, reason);
-
-		/* reset iterator */
-		dumper->active = false;
+		dumper->dump(dumper, reason, &iter);
 	}
 	rcu_read_unlock();
 }
 
 /**
  * kmsg_dump_get_line_nolock - retrieve one kmsg log line (unlocked version)
- * @dumper: registered kmsg dumper
+ * @iter: kmsg dumper iterator
  * @syslog: include the "<4>" prefixes
  * @line: buffer to copy the line to
  * @size: maximum size of the buffer
@@ -3411,7 +3408,7 @@ void kmsg_dump(enum kmsg_dump_reason reason)
  *
  * The function is similar to kmsg_dump_get_line(), but grabs no locks.
  */
-bool kmsg_dump_get_line_nolock(struct kmsg_dumper *dumper, bool syslog,
+bool kmsg_dump_get_line_nolock(struct kmsg_dumper_iter *iter, bool syslog,
 			       char *line, size_t size, size_t *len)
 {
 	struct printk_info info;
@@ -3422,16 +3419,16 @@ bool kmsg_dump_get_line_nolock(struct kmsg_dumper *dumper, bool syslog,
 
 	prb_rec_init_rd(&r, &info, line, size);
 
-	if (!dumper->active)
+	if (!iter->active)
 		goto out;
 
 	/* Read text or count text lines? */
 	if (line) {
-		if (!prb_read_valid(prb, dumper->cur_seq, &r))
+		if (!prb_read_valid(prb, iter->cur_seq, &r))
 			goto out;
 		l = record_print_text(&r, syslog, printk_time);
 	} else {
-		if (!prb_read_valid_info(prb, dumper->cur_seq,
+		if (!prb_read_valid_info(prb, iter->cur_seq,
 					 &info, &line_count)) {
 			goto out;
 		}
@@ -3440,7 +3437,7 @@ bool kmsg_dump_get_line_nolock(struct kmsg_dumper *dumper, bool syslog,
 
 	}
 
-	dumper->cur_seq = r.info->seq + 1;
+	iter->cur_seq = r.info->seq + 1;
 	ret = true;
 out:
 	if (len)
@@ -3450,7 +3447,7 @@ bool kmsg_dump_get_line_nolock(struct kmsg_dumper *dumper, bool syslog,
 
 /**
  * kmsg_dump_get_line - retrieve one kmsg log line
- * @dumper: registered kmsg dumper
+ * @iter: kmsg dumper iterator
  * @syslog: include the "<4>" prefixes
  * @line: buffer to copy the line to
  * @size: maximum size of the buffer
@@ -3465,14 +3462,14 @@ bool kmsg_dump_get_line_nolock(struct kmsg_dumper *dumper, bool syslog,
  * A return value of FALSE indicates that there are no more records to
  * read.
  */
-bool kmsg_dump_get_line(struct kmsg_dumper *dumper, bool syslog,
+bool kmsg_dump_get_line(struct kmsg_dumper_iter *iter, bool syslog,
 			char *line, size_t size, size_t *len)
 {
 	unsigned long flags;
 	bool ret;
 
 	logbuf_lock_irqsave(flags);
-	ret = kmsg_dump_get_line_nolock(dumper, syslog, line, size, len);
+	ret = kmsg_dump_get_line_nolock(iter, syslog, line, size, len);
 	logbuf_unlock_irqrestore(flags);
 
 	return ret;
@@ -3481,7 +3478,7 @@ EXPORT_SYMBOL_GPL(kmsg_dump_get_line);
 
 /**
  * kmsg_dump_get_buffer - copy kmsg log lines
- * @dumper: registered kmsg dumper
+ * @iter: kmsg dumper iterator
  * @syslog: include the "<4>" prefixes
  * @buf: buffer to copy the line to
  * @size: maximum size of the buffer
@@ -3498,7 +3495,7 @@ EXPORT_SYMBOL_GPL(kmsg_dump_get_line);
  * A return value of FALSE indicates that there are no more records to
  * read.
  */
-bool kmsg_dump_get_buffer(struct kmsg_dumper *dumper, bool syslog,
+bool kmsg_dump_get_buffer(struct kmsg_dumper_iter *iter, bool syslog,
 			  char *buf, size_t size, size_t *len_out)
 {
 	struct printk_info info;
@@ -3510,17 +3507,17 @@ bool kmsg_dump_get_buffer(struct kmsg_dumper *dumper, bool syslog,
 	bool ret = false;
 	bool time = printk_time;
 
-	if (!dumper->active || !buf || !size)
+	if (!iter->active || !buf || !size)
 		goto out;
 
 	logbuf_lock_irqsave(flags);
-	if (dumper->cur_seq < prb_first_valid_seq(prb)) {
+	if (iter->cur_seq < prb_first_valid_seq(prb)) {
 		/* messages are gone, move to first available one */
-		dumper->cur_seq = prb_first_valid_seq(prb);
+		iter->cur_seq = prb_first_valid_seq(prb);
 	}
 
 	/* last entry */
-	if (dumper->cur_seq >= dumper->next_seq) {
+	if (iter->cur_seq >= iter->next_seq) {
 		logbuf_unlock_irqrestore(flags);
 		goto out;
 	}
@@ -3531,7 +3528,7 @@ bool kmsg_dump_get_buffer(struct kmsg_dumper *dumper, bool syslog,
 	 * because this function (by way of record_print_text()) will
 	 * not write more than size-1 bytes of text into @buf.
 	 */
-	seq = find_first_fitting_seq(dumper->cur_seq, dumper->next_seq,
+	seq = find_first_fitting_seq(iter->cur_seq, iter->next_seq,
 				     size - 1, &info, syslog, time);
 
 	/* Keep track of the last message for the next iteration. */
@@ -3541,7 +3538,7 @@ bool kmsg_dump_get_buffer(struct kmsg_dumper *dumper, bool syslog,
 
 	len = 0;
 	prb_for_each_record(seq, prb, seq, &r) {
-		if (r.info->seq >= dumper->next_seq)
+		if (r.info->seq >= iter->next_seq)
 			break;
 
 		len += record_print_text(&r, syslog, time);
@@ -3550,7 +3547,7 @@ bool kmsg_dump_get_buffer(struct kmsg_dumper *dumper, bool syslog,
 		prb_rec_init_rd(&r, &info, buf + len, size - len);
 	}
 
-	dumper->next_seq = next_seq;
+	iter->next_seq = next_seq;
 	ret = true;
 	logbuf_unlock_irqrestore(flags);
 out:
@@ -3562,7 +3559,7 @@ EXPORT_SYMBOL_GPL(kmsg_dump_get_buffer);
 
 /**
  * kmsg_dump_rewind_nolock - reset the iterator (unlocked version)
- * @dumper: registered kmsg dumper
+ * @iter: kmsg dumper iterator
  *
  * Reset the dumper's iterator so that kmsg_dump_get_line() and
  * kmsg_dump_get_buffer() can be called again and used multiple
@@ -3570,26 +3567,26 @@ EXPORT_SYMBOL_GPL(kmsg_dump_get_buffer);
  *
  * The function is similar to kmsg_dump_rewind(), but grabs no locks.
  */
-void kmsg_dump_rewind_nolock(struct kmsg_dumper *dumper)
+void kmsg_dump_rewind_nolock(struct kmsg_dumper_iter *iter)
 {
-	dumper->cur_seq = latched_seq_read_nolock(&clear_seq);
-	dumper->next_seq = prb_next_seq(prb);
+	iter->cur_seq = latched_seq_read_nolock(&clear_seq);
+	iter->next_seq = prb_next_seq(prb);
 }
 
 /**
  * kmsg_dump_rewind - reset the iterator
- * @dumper: registered kmsg dumper
+ * @iter: kmsg dumper iterator
  *
  * Reset the dumper's iterator so that kmsg_dump_get_line() and
  * kmsg_dump_get_buffer() can be called again and used multiple
  * times within the same dumper.dump() callback.
  */
-void kmsg_dump_rewind(struct kmsg_dumper *dumper)
+void kmsg_dump_rewind(struct kmsg_dumper_iter *iter)
 {
 	unsigned long flags;
 
 	logbuf_lock_irqsave(flags);
-	kmsg_dump_rewind_nolock(dumper);
+	kmsg_dump_rewind_nolock(iter);
 	logbuf_unlock_irqrestore(flags);
 }
 EXPORT_SYMBOL_GPL(kmsg_dump_rewind);
-- 
2.20.1

