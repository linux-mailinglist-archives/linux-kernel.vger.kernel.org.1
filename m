Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA033275937
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 15:57:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbgIWN5Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 09:57:25 -0400
Received: from mx2.suse.de ([195.135.220.15]:49614 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726332AbgIWN5Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 09:57:25 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1600869442;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ktHuq3zdjo7/chXpRH/fkD6FNl2+60HtgLQmtzGpw1Y=;
        b=uXeekFJyHq3CtI1L/hqkOEKIbHoe+SRQi21s2M8i5qB/tOrnm9EqBtO6h+I4juYMWkMRzW
        /CqY8Rcfrc57J89k0IGV0GSiEiNNR5JKeT/qfVjNmytgLRj+mvzUm54YvbECU46H1dzivv
        J78sm6jdfLeXcAvFxDpAgi9NEE+8y6Q=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 8CA37AC26;
        Wed, 23 Sep 2020 13:57:59 +0000 (UTC)
From:   Petr Mladek <pmladek@suse.com>
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Prarit Bhargava <prarit@redhat.com>,
        Mark Salyzyn <salyzyn@android.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Changki Kim <changki.kim@samsung.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>
Subject: [RFC 2/2] printk: Add more information about the printk caller
Date:   Wed, 23 Sep 2020 15:56:17 +0200
Message-Id: <20200923135617.27149-3-pmladek@suse.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200923135617.27149-1-pmladek@suse.com>
References: <20200923135617.27149-1-pmladek@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The information about the printk caller has been added by the commit
15ff2069cb7f967da ("printk: Add caller information to printk() output.").
The main motivation was to reconstruct original messages when they
longer output from different CPUs got mixed.

But there are more usecases. The number of CPUs and tasks running on
a single system is growing. It brings bigger challenges when debugging
problems. The context in which kernel reports its state is sometimes
pretty useful.

In particular, people suggest to remember the task id, cpu id, more details
about the interrupt context, and even the task name [0][1].

Prepare for extending the caller information by replacing caller_id
with struct printk_caller. And always store task id, cpu id, and
exact interrupt context.

The output to console and /dev/kmsg stays the same for now. I will
get improved by followup patches.

[0] https://lore.kernel.org/r/CAHk-=wibPWj9m1jQWeJUq+iPMG9tHaLANY-UaruakHuezFHr4w@mail.gmail.com
[1] https://lore.kernel.org/r/20200904082438.20707-1-changki.kim@samsung.com

Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 kernel/printk/printk.c            | 107 +++++++++++++++++++-----------
 kernel/printk/printk_ringbuffer.c |  43 ++++++------
 kernel/printk/printk_ringbuffer.h |  39 ++++++++++-
 3 files changed, 131 insertions(+), 58 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 0ed8901916f4..2f904bb744a6 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -333,7 +333,8 @@ static int console_msg_format = MSG_FORMAT_DEFAULT;
  *   record.info.facility           = 0 (LOG_KERN)
  *   record.info.flags              = 0
  *   record.info.level              = 3 (LOG_ERR)
- *   record.info.caller_id          = 299 (task 299)
+ *   record.info.caller.pid         = 299 (task 299)
+ *   record.info.cpu_ctx            = 0x80000003 (in hardirq context on cpu 3)
  *   record.info.dev_info.subsystem = "pci" (terminated)
  *   record.info.dev_info.device    = "+pci:0000:00:01.0" (terminated)
  *
@@ -494,8 +495,9 @@ static void truncate_msg(u16 *text_len, u16 *trunc_msg_len)
 }
 
 /* insert record into the buffer, discard old ones, update heads */
-static int log_store(u32 caller_id, int facility, int level,
-		     enum log_flags flags, struct ktime_timestamps *ts,
+static int log_store(const struct printk_caller *caller,
+		     int facility, int level, enum log_flags flags,
+		     struct ktime_timestamps *ts,
 		     const struct dev_printk_info *dev_info,
 		     const char *text, u16 text_len)
 {
@@ -526,7 +528,7 @@ static int log_store(u32 caller_id, int facility, int level,
 		r.info->ts = *ts;
 	else
 		ktime_get_fast_timestamps(&r.info->ts);
-	r.info->caller_id = caller_id;
+	r.info->caller = *caller;
 	if (dev_info)
 		memcpy(&r.info->dev_info, dev_info, sizeof(r.info->dev_info));
 
@@ -588,26 +590,40 @@ static void append_char(char **pp, char *e, char c)
 		*(*pp)++ = c;
 }
 
+static size_t info_print_caller_id(char *buf, size_t size,
+				   const struct printk_caller *caller)
+{
+	enum printk_caller_ctx ctx;
+
+	ctx = printk_to_caller_ctx(caller->cpu_ctx);
+
+	if (ctx == printk_ctx_task)
+		return snprintf(buf, size, "T%u", caller->pid);
+
+	return snprintf(buf, size, "C%u", printk_to_caller_cpu(caller->cpu_ctx));
+}
+
 static ssize_t info_print_ext_header(char *buf, size_t size,
 				     struct printk_info *info)
 {
 	u64 ts_mono_usec = info->ts.mono;
-	char caller[20];
-#ifdef CONFIG_PRINTK_CALLER
-	u32 id = info->caller_id;
-
-	snprintf(caller, sizeof(caller), ",caller=%c%u",
-		 id & 0x80000000 ? 'C' : 'T', id & ~0x80000000);
-#else
-	caller[0] = '\0';
-#endif
+	char caller_id[12];
+	size_t len;
 
 	do_div(ts_mono_usec, 1000);
 
-	return scnprintf(buf, size, "%u,%llu,%llu,%c%s;",
-			 (info->facility << 3) | info->level, info->seq,
-			 ts_mono_usec, info->flags & LOG_CONT ? 'c' : '-',
-			 caller);
+	len = scnprintf(buf, size, "%u,%llu,%llu,%c",
+			(info->facility << 3) | info->level, info->seq,
+			ts_mono_usec, info->flags & LOG_CONT ? 'c' : '-');
+
+	if (IS_ENABLED(CONFIG_PRINTK_CALLER)) {
+		info_print_caller_id(caller_id, sizeof(caller_id), &info->caller);
+		len += scnprintf(buf + len, size - len, ",caller=%s", caller_id);
+	}
+
+	len += scnprintf(buf + len, size - len, ";");
+
+	return len;
 }
 
 static ssize_t msg_add_ext_text(char *buf, size_t size,
@@ -987,7 +1003,7 @@ void log_buf_vmcoreinfo_setup(void)
 	VMCOREINFO_OFFSET(printk_info, seq);
 	VMCOREINFO_OFFSET(printk_info, ts);
 	VMCOREINFO_OFFSET(printk_info, text_len);
-	VMCOREINFO_OFFSET(printk_info, caller_id);
+	VMCOREINFO_OFFSET(printk_info, caller);
 	VMCOREINFO_OFFSET(printk_info, dev_info);
 
 	VMCOREINFO_STRUCT_SIZE(ktime_timestamps);
@@ -995,6 +1011,10 @@ void log_buf_vmcoreinfo_setup(void)
 	VMCOREINFO_OFFSET(ktime_timestamps, boot);
 	VMCOREINFO_OFFSET(ktime_timestamps, real);
 
+	VMCOREINFO_STRUCT_SIZE(printk_caller);
+	VMCOREINFO_OFFSET(printk_caller, pid);
+	VMCOREINFO_OFFSET(printk_caller, cpu_ctx);
+
 	VMCOREINFO_STRUCT_SIZE(dev_printk_info);
 	VMCOREINFO_OFFSET(dev_printk_info, subsystem);
 	VMCOREINFO_LENGTH(printk_info_subsystem, sizeof(dev_info->subsystem));
@@ -1103,7 +1123,7 @@ static unsigned int __init add_to_rb(struct printk_ringbuffer *rb,
 	dest_r.info->level = r->info->level;
 	dest_r.info->flags = r->info->flags;
 	dest_r.info->ts = r->info->ts;
-	dest_r.info->caller_id = r->info->caller_id;
+	dest_r.info->caller = r->info->caller;
 	memcpy(&dest_r.info->dev_info, &r->info->dev_info, sizeof(dest_r.info->dev_info));
 
 	prb_final_commit(&e);
@@ -1306,18 +1326,13 @@ static size_t print_time(u64 ts, char *buf)
 		       (unsigned long)ts, rem_nsec / 1000);
 }
 
-#ifdef CONFIG_PRINTK_CALLER
-static size_t print_caller(u32 id, char *buf)
+static size_t print_caller_id(const struct printk_caller *caller, char *buf)
 {
-	char caller[12];
+	char caller_id[12];
 
-	snprintf(caller, sizeof(caller), "%c%u",
-		 id & 0x80000000 ? 'C' : 'T', id & ~0x80000000);
-	return sprintf(buf, "[%6s]", caller);
+	info_print_caller_id(caller_id, sizeof(caller_id), caller);
+	return sprintf(buf, "[%6s]", caller_id);
 }
-#else
-#define print_caller(id, buf) 0
-#endif
 
 static size_t info_print_prefix(const struct printk_info  *info, bool syslog,
 				bool time, char *buf)
@@ -1330,7 +1345,8 @@ static size_t info_print_prefix(const struct printk_info  *info, bool syslog,
 	if (time)
 		len += print_time(info->ts.mono, buf + len);
 
-	len += print_caller(info->caller_id, buf + len);
+	if (IS_ENABLED(CONFIG_PRINTK_CALLER))
+		len += print_caller_id(&info->caller, buf + len);
 
 	if (IS_ENABLED(CONFIG_PRINTK_CALLER) || time) {
 		buf[len++] = ' ';
@@ -1902,24 +1918,42 @@ static inline void printk_delay(void)
 	}
 }
 
-static inline u32 printk_caller_id(void)
+static enum printk_caller_ctx get_printk_caller_ctx(void)
+{
+	if (in_nmi())
+		return printk_ctx_nmi;
+
+	if (in_irq())
+		return printk_ctx_hardirq;
+
+	if (in_softirq())
+		return printk_ctx_softirq;
+
+	return printk_ctx_task;
+}
+
+static void set_current_printk_caller(struct printk_caller *caller)
 {
-	return in_task() ? task_pid_nr(current) :
-		0x80000000 + raw_smp_processor_id();
+	caller->pid = task_pid_nr(current);
+
+	caller->cpu_ctx = printk_to_caller_cpu_ctx(raw_smp_processor_id(),
+						   get_printk_caller_ctx());
 }
 
 static size_t log_output(int facility, int level, enum log_flags lflags,
 			 const struct dev_printk_info *dev_info,
 			 char *text, size_t text_len)
 {
-	const u32 caller_id = printk_caller_id();
+	struct printk_caller caller;
+
+	set_current_printk_caller(&caller);
 
 	if (lflags & LOG_CONT) {
 		struct prb_reserved_entry e;
 		struct printk_record r;
 
 		prb_rec_init_wr(&r, text_len);
-		if (prb_reserve_in_last(&e, prb, &r, caller_id)) {
+		if (prb_reserve_in_last(&e, prb, &r, &caller)) {
 			memcpy(&r.text_buf[r.info->text_len], text, text_len);
 			r.info->text_len += text_len;
 			if (lflags & LOG_NEWLINE) {
@@ -1933,7 +1967,7 @@ static size_t log_output(int facility, int level, enum log_flags lflags,
 	}
 
 	/* Store it in the record log */
-	return log_store(caller_id, facility, level, lflags, 0,
+	return log_store(&caller, facility, level, lflags, 0,
 			 dev_info, text, text_len);
 }
 
@@ -3095,8 +3129,7 @@ EXPORT_SYMBOL(__printk_ratelimit);
  * printk_timed_ratelimit - caller-controlled printk ratelimiting
  * @caller_jiffies: pointer to caller's state
  * @interval_msecs: minimum interval between prints
- *
- * printk_timed_ratelimit() returns true if more than @interval_msecs
+ *_timed_ratelimit() returns true if more than @interval_msecs
  * milliseconds have elapsed since the last time printk_timed_ratelimit()
  * returned true.
  */
diff --git a/kernel/printk/printk_ringbuffer.c b/kernel/printk/printk_ringbuffer.c
index 13b94b92342e..86d98e692d75 100644
--- a/kernel/printk/printk_ringbuffer.c
+++ b/kernel/printk/printk_ringbuffer.c
@@ -175,7 +175,7 @@
  *
  *		r.info->text_len = strlen(textstr);
  *		r.info->ts_nsec = local_clock();
- *		r.info->caller_id = printk_caller_id();
+ *		set_current_printk_caller(&r.info->caller);
  *
  *		// commit and finalize the record
  *		prb_final_commit(&e);
@@ -191,7 +191,7 @@
  *
  *		r.info->text_len = strlen(textstr);
  *		r.info->ts_nsec = local_clock();
- *		r.info->caller_id = printk_caller_id();
+ *		set_current_printk_caller(&r.info->caller);
  *
  *		// commit the record (but do not finalize yet)
  *		prb_commit(&e);
@@ -202,7 +202,7 @@
  *	// specify additional 5 bytes text space to extend
  *	prb_rec_init_wr(&r, 5);
  *
- *	if (prb_reserve_in_last(&e, &test_rb, &r, printk_caller_id())) {
+ *	if (prb_reserve_in_last(&e, &test_rb, &r, &caller)) {
  *		snprintf(&r.text_buf[r.info->text_len],
  *			 r.text_buf_size - r.info->text_len, "hello");
  *
@@ -424,13 +424,13 @@ static enum desc_state get_desc_state(unsigned long id,
  * descriptor is in an inconsistent state (miss or reserved), the caller can
  * only expect the descriptor's @state_var field to be valid.
  *
- * The sequence number and caller_id can be optionally retrieved. Like all
- * non-state_var data, they are only valid if the descriptor is in a
- * consistent state.
+ * The sequence number and caller information can be optionally retrieved.
+ * Like all non-state_var data, they are only valid if the descriptor is
+ * in a consistent state.
  */
 static enum desc_state desc_read(struct prb_desc_ring *desc_ring,
 				 unsigned long id, struct prb_desc *desc_out,
-				 u64 *seq_out, u32 *caller_id_out)
+				 u64 *seq_out, struct printk_caller *caller_out)
 {
 	struct printk_info *info = to_info(desc_ring, id);
 	struct prb_desc *desc = to_desc(desc_ring, id);
@@ -477,8 +477,8 @@ static enum desc_state desc_read(struct prb_desc_ring *desc_ring,
 	       sizeof(desc_out->text_blk_lpos)); /* LMM(desc_read:C) */
 	if (seq_out)
 		*seq_out = info->seq; /* also part of desc_read:C */
-	if (caller_id_out)
-		*caller_id_out = info->caller_id; /* also part of desc_read:C */
+	if (caller_out)
+		*caller_out = info->caller; /* also part of desc_read:C */
 
 	/*
 	 * 1. Guarantee the descriptor content is loaded before re-checking
@@ -1253,24 +1253,28 @@ static const char *get_data(struct prb_data_ring *data_ring,
  * if the descriptor is not yet finalized and the provided @caller_id matches.
  */
 static struct prb_desc *desc_reopen_last(struct prb_desc_ring *desc_ring,
-					 u32 caller_id, unsigned long *id_out)
+					 const struct printk_caller *caller,
+					 unsigned long *id_out)
 {
 	unsigned long prev_state_val;
+	struct printk_caller cal;
 	enum desc_state d_state;
 	struct prb_desc desc;
 	struct prb_desc *d;
 	unsigned long id;
-	u32 cid;
 
 	id = atomic_long_read(&desc_ring->head_id);
 
 	/*
 	 * To reduce unnecessarily reopening, first check if the descriptor
-	 * state and caller ID are correct.
+	 * state and caller infromation are correct.
 	 */
-	d_state = desc_read(desc_ring, id, &desc, NULL, &cid);
-	if (d_state != desc_committed || cid != caller_id)
+	d_state = desc_read(desc_ring, id, &desc, NULL, &cal);
+	if (d_state != desc_committed ||
+	    cal.pid != caller->pid ||
+	    cal.cpu_ctx != caller->cpu_ctx) {
 		return NULL;
+	}
 
 	d = to_desc(desc_ring, id);
 
@@ -1308,7 +1312,7 @@ static struct prb_desc *desc_reopen_last(struct prb_desc_ring *desc_ring,
  * @e:         The entry structure to setup.
  * @rb:        The ringbuffer to re-reserve and extend data in.
  * @r:         The record structure to allocate buffers for.
- * @caller_id: The caller ID of the caller (reserving writer).
+ * @caller:    The information about the caller (reserving writer).
  *
  * This is the public function available to writers to re-reserve and extend
  * data.
@@ -1317,7 +1321,7 @@ static struct prb_desc *desc_reopen_last(struct prb_desc_ring *desc_ring,
  * setting the @text_buf_size field of @r. To ensure proper initialization
  * of @r, prb_rec_init_wr() should be used.
  *
- * This function will fail if @caller_id does not match the caller ID of the
+ * This function will fail if @caller does not match the caller of the
  * newest record. In that case the caller must reserve new data using
  * prb_reserve().
  *
@@ -1343,7 +1347,7 @@ static struct prb_desc *desc_reopen_last(struct prb_desc_ring *desc_ring,
  *            @r->info->text_len after concatenating.
  */
 bool prb_reserve_in_last(struct prb_reserved_entry *e, struct printk_ringbuffer *rb,
-			 struct printk_record *r, u32 caller_id)
+			 struct printk_record *r, const struct printk_caller *caller)
 {
 	struct prb_desc_ring *desc_ring = &rb->desc_ring;
 	struct printk_info *info;
@@ -1354,7 +1358,7 @@ bool prb_reserve_in_last(struct prb_reserved_entry *e, struct printk_ringbuffer
 	local_irq_save(e->irqflags);
 
 	/* Transition the newest descriptor back to the reserved state. */
-	d = desc_reopen_last(desc_ring, caller_id, &id);
+	d = desc_reopen_last(desc_ring, caller, &id);
 	if (!d) {
 		local_irq_restore(e->irqflags);
 		goto fail_reopen;
@@ -1376,7 +1380,8 @@ bool prb_reserve_in_last(struct prb_reserved_entry *e, struct printk_ringbuffer
 	 * exclusive access at that point. The descriptor may have
 	 * changed since then.
 	 */
-	if (caller_id != info->caller_id)
+	if (caller->pid != info->caller.pid ||
+	    caller->cpu_ctx != info->caller.cpu_ctx)
 		goto fail;
 
 	if (BLK_DATALESS(&d->text_blk_lpos)) {
diff --git a/kernel/printk/printk_ringbuffer.h b/kernel/printk/printk_ringbuffer.h
index 09082c8472d3..93117bd82afb 100644
--- a/kernel/printk/printk_ringbuffer.h
+++ b/kernel/printk/printk_ringbuffer.h
@@ -7,6 +7,12 @@
 #include <linux/dev_printk.h>
 #include <linux/timekeeping.h>
 
+/* Information about the process and context that adds the message */
+struct printk_caller {
+	pid_t pid;	/* thread id */
+	u32 cpu_ctx;	/* processor id and interrupt context */
+};
+
 /*
  * Meta information about each stored message.
  *
@@ -20,8 +26,8 @@ struct printk_info {
 	u8	facility;	/* syslog facility */
 	u8	flags:5;	/* internal record flags */
 	u8	level:3;	/* syslog level */
-	u32	caller_id;	/* thread id or processor id */
 
+	struct printk_caller caller;	/* information about the caller */
 	struct dev_printk_info	dev_info;
 };
 
@@ -118,6 +124,35 @@ enum desc_state {
 	desc_reusable	= 0x3,	/* free, not yet used by any writer */
 };
 
+/* Handling the shared cpu id and interupt context caller value */
+#define PRINTK_CALLER_CTX_MASK 0xc0000000
+#define PRINTK_CALLER_CPU_MASK 0x3fffffff
+
+#define PRINTK_CALLER_CTX_SHIFT (32 - 2)
+
+enum printk_caller_ctx {
+	printk_ctx_task		= 0x0,
+	printk_ctx_softirq	= 0x1,
+	printk_ctx_hardirq	= 0x2,
+	printk_ctx_nmi		= 0x3,
+};
+
+/* Get context id from the common cpu and interrupt context id value. */
+#define printk_to_caller_ctx(cpu_ctx)		\
+	(enum printk_caller_ctx)		\
+		(((cpu_ctx) & PRINTK_CALLER_CTX_MASK) >> PRINTK_CALLER_CTX_SHIFT)
+
+/* Get cpu id from the common cpu and interrupt context id value. */
+#define printk_to_caller_cpu(cpu_ctx)		\
+	(u32)((cpu_ctx) & PRINTK_CALLER_CPU_MASK)
+
+/* Merge cpu and interrupt context id into a single value */
+#define printk_to_caller_cpu_ctx(cpu, ctx)			\
+	(u32)							\
+		(((cpu) & PRINTK_CALLER_CPU_MASK) |		\
+		 (((ctx) << PRINTK_CALLER_CTX_SHIFT) & PRINTK_CALLER_CTX_MASK))
+
+/* Ringbuffer handling */
 #define _DATA_SIZE(sz_bits)	(1UL << (sz_bits))
 #define _DESCS_COUNT(ct_bits)	(1U << (ct_bits))
 #define DESC_SV_BITS		(sizeof(unsigned long) * 8)
@@ -304,7 +339,7 @@ static inline void prb_rec_init_wr(struct printk_record *r,
 bool prb_reserve(struct prb_reserved_entry *e, struct printk_ringbuffer *rb,
 		 struct printk_record *r);
 bool prb_reserve_in_last(struct prb_reserved_entry *e, struct printk_ringbuffer *rb,
-			 struct printk_record *r, u32 caller_id);
+			 struct printk_record *r, const struct printk_caller *caller);
 void prb_commit(struct prb_reserved_entry *e);
 void prb_final_commit(struct prb_reserved_entry *e);
 
-- 
2.26.2

