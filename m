Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E80AA274575
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 17:38:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726806AbgIVPib (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 11:38:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726632AbgIVPiV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 11:38:21 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEA3CC061755
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 08:38:20 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1600789099;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TlG7gAJDgVhu/+EMU+cZkwX3m1nEWRdR3JAg/KdekiQ=;
        b=4Y4RAPjc5Qcki+x9CFgsSaKkuPC/AoQlZeHenbwFeeTLHr+RsRV2sun/JepI5p1FuhCNxj
        O1aUMFuqmLlOP97I1Vv6ElNkEFBH9sGsc99gKnpmEDcfV6wpnVHqLCEhYdWOydRPE2OfwV
        G4gB4pZzBCBM1elEs4a7QpEV542dfkGQtuiRtf16dW5n+QrEN/+XJ6vr4QRRqZ5H/oje7O
        AMZynuYpvV6Apr35dDs3jqaXor/OOHpQVfzndHgBCC6BIIcMBQ3r4xlKIOy4DmHAJaAr+E
        6qCzhwHVIKPNhu8hLdzx+Ya/tAIhAMkG6Xt0teh0/xSbx6PU4O+5N3yUqj+Bng==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1600789099;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TlG7gAJDgVhu/+EMU+cZkwX3m1nEWRdR3JAg/KdekiQ=;
        b=U+lQJZR4VzwInGhMgYEfOaRS3qicj5Be4MyEzmrqLSPWsTxyBUTfgMTXJmF5SEZN4p6o4a
        2BZFekM6pi8SKzAA==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH printk 4/5] printk: remove logbuf_lock, add syslog_lock
Date:   Tue, 22 Sep 2020 17:44:15 +0206
Message-Id: <20200922153816.5883-5-john.ogness@linutronix.de>
In-Reply-To: <20200922153816.5883-1-john.ogness@linutronix.de>
References: <20200922153816.5883-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the ringbuffer is lockless, there is no need for it to be
protected by @logbuf_lock. Remove @logbuf_lock.

This means that printk_nmi_direct and printk_safe_flush_on_panic()
no longer need to acquire any lock to run.

The global variables @syslog_seq, @syslog_partial, @syslog_time,
@clear_seq were also protected by @logbuf_lock. Introduce
@syslog_lock to protect these.

@console_seq, @exclusive_console_stop_seq, @console_dropped are
protected by @console_lock.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 kernel/printk/internal.h    |   4 +-
 kernel/printk/printk.c      | 162 +++++++++++++++---------------------
 kernel/printk/printk_safe.c |  21 +----
 3 files changed, 70 insertions(+), 117 deletions(-)

diff --git a/kernel/printk/internal.h b/kernel/printk/internal.h
index 3a8fd491758c..e7acc2888c8e 100644
--- a/kernel/printk/internal.h
+++ b/kernel/printk/internal.h
@@ -12,8 +12,6 @@
 
 #define PRINTK_NMI_CONTEXT_OFFSET	0x010000000
 
-extern raw_spinlock_t logbuf_lock;
-
 __printf(4, 0)
 int vprintk_store(int facility, int level,
 		  const struct dev_printk_info *dev_info,
@@ -59,7 +57,7 @@ void defer_console_output(void);
 __printf(1, 0) int vprintk_func(const char *fmt, va_list args) { return 0; }
 
 /*
- * In !PRINTK builds we still export logbuf_lock spin_lock, console_sem
+ * In !PRINTK builds we still export console_sem
  * semaphore and some of console functions (console_unlock()/etc.), so
  * printk-safe must preserve the existing local IRQ guarantees.
  */
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 763494d1d6b3..65e3cdbddeff 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -355,53 +355,29 @@ enum log_flags {
 	LOG_CONT	= 8,	/* text is a fragment of a continuation line */
 };
 
-/*
- * The logbuf_lock protects kmsg buffer, indices, counters.  This can be taken
- * within the scheduler's rq lock. It must be released before calling
- * console_unlock() or anything else that might wake up a process.
- */
-DEFINE_RAW_SPINLOCK(logbuf_lock);
-
-/*
- * Helper macros to lock/unlock logbuf_lock and switch between
- * printk-safe/unsafe modes.
- */
-#define logbuf_lock_irq()				\
-	do {						\
-		printk_safe_enter_irq();		\
-		raw_spin_lock(&logbuf_lock);		\
-	} while (0)
-
-#define logbuf_unlock_irq()				\
-	do {						\
-		raw_spin_unlock(&logbuf_lock);		\
-		printk_safe_exit_irq();			\
-	} while (0)
-
-#define logbuf_lock_irqsave(flags)			\
-	do {						\
-		printk_safe_enter_irqsave(flags);	\
-		raw_spin_lock(&logbuf_lock);		\
-	} while (0)
-
-#define logbuf_unlock_irqrestore(flags)		\
-	do {						\
-		raw_spin_unlock(&logbuf_lock);		\
-		printk_safe_exit_irqrestore(flags);	\
-	} while (0)
+/* The syslog_lock protects syslog_* and clear_seq variables. */
+DEFINE_RAW_SPINLOCK(syslog_lock);
+#define syslog_lock_irq() raw_spin_lock_irq(&syslog_lock)
+#define syslog_unlock_irq() raw_spin_unlock_irq(&syslog_lock)
+#define syslog_lock_irqsave(flags) raw_spin_lock_irqsave(&syslog_lock, flags)
+#define syslog_unlock_irqrestore(flags) raw_spin_unlock_irqrestore(&syslog_lock, flags)
 
 #ifdef CONFIG_PRINTK
 DECLARE_WAIT_QUEUE_HEAD(log_wait);
+
+/* All 3 protected by @syslog_lock. */
 /* the next printk record to read by syslog(READ) or /proc/kmsg */
 static u64 syslog_seq;
 static size_t syslog_partial;
 static bool syslog_time;
 
+/* All 3 protected by @console_lock. */
 /* the next printk record to write to the console */
 static u64 console_seq;
 static u64 exclusive_console_stop_seq;
 static unsigned long console_dropped;
 
+/* Protected by @syslog_lock. */
 /* the next printk record to read after the last 'clear' command */
 static u64 clear_seq;
 
@@ -766,27 +742,22 @@ static ssize_t devkmsg_read(struct file *file, char __user *buf,
 	if (ret)
 		return ret;
 
-	logbuf_lock_irq();
 	if (!prb_read_valid(prb, user->seq, r)) {
 		if (file->f_flags & O_NONBLOCK) {
 			ret = -EAGAIN;
-			logbuf_unlock_irq();
 			goto out;
 		}
 
-		logbuf_unlock_irq();
 		ret = wait_event_interruptible(log_wait,
 					prb_read_valid(prb, user->seq, r));
 		if (ret)
 			goto out;
-		logbuf_lock_irq();
 	}
 
 	if (user->seq < prb_first_valid_seq(prb)) {
 		/* our last seen message is gone, return error and reset */
 		user->seq = prb_first_valid_seq(prb);
 		ret = -EPIPE;
-		logbuf_unlock_irq();
 		goto out;
 	}
 
@@ -796,7 +767,6 @@ static ssize_t devkmsg_read(struct file *file, char __user *buf,
 				  &r->info->dev_info);
 
 	user->seq = r->info->seq + 1;
-	logbuf_unlock_irq();
 
 	if (len > count) {
 		ret = -EINVAL;
@@ -823,7 +793,6 @@ static loff_t devkmsg_llseek(struct file *file, loff_t offset, int whence)
 	if (offset)
 		return -ESPIPE;
 
-	logbuf_lock_irq();
 	switch (whence) {
 	case SEEK_SET:
 		/* the first record */
@@ -835,7 +804,9 @@ static loff_t devkmsg_llseek(struct file *file, loff_t offset, int whence)
 		 * like issued by 'dmesg -c'. Reading /dev/kmsg itself
 		 * changes no global state, and does not clear anything.
 		 */
+		syslog_lock_irq();
 		user->seq = clear_seq;
+		syslog_unlock_irq();
 		break;
 	case SEEK_END:
 		/* after the last record */
@@ -844,7 +815,6 @@ static loff_t devkmsg_llseek(struct file *file, loff_t offset, int whence)
 	default:
 		ret = -EINVAL;
 	}
-	logbuf_unlock_irq();
 	return ret;
 }
 
@@ -858,7 +828,6 @@ static __poll_t devkmsg_poll(struct file *file, poll_table *wait)
 
 	poll_wait(file, &log_wait, wait);
 
-	logbuf_lock_irq();
 	if (prb_read_valid(prb, user->seq, NULL)) {
 		/* return error when data has vanished underneath us */
 		if (user->seq < prb_first_valid_seq(prb))
@@ -866,7 +835,6 @@ static __poll_t devkmsg_poll(struct file *file, poll_table *wait)
 		else
 			ret = EPOLLIN|EPOLLRDNORM;
 	}
-	logbuf_unlock_irq();
 
 	return ret;
 }
@@ -899,9 +867,7 @@ static int devkmsg_open(struct inode *inode, struct file *file)
 	prb_rec_init_rd(&user->record, &user->info,
 			&user->text_buf[0], sizeof(user->text_buf));
 
-	logbuf_lock_irq();
 	user->seq = prb_first_valid_seq(prb);
-	logbuf_unlock_irq();
 
 	file->private_data = user;
 	return 0;
@@ -1164,7 +1130,7 @@ void __init setup_log_buf(int early)
 		 new_descs, ilog2(new_descs_count),
 		 new_infos);
 
-	logbuf_lock_irqsave(flags);
+	local_irq_save(flags);
 
 	log_buf_len = new_log_buf_len;
 	log_buf = new_log_buf;
@@ -1183,7 +1149,7 @@ void __init setup_log_buf(int early)
 
 	seq = prb_next_seq(&printk_rb_static) - seq;
 
-	logbuf_unlock_irqrestore(flags);
+	local_irq_restore(flags);
 
 	if (seq)
 		pr_err("dropped %llu messages\n", seq);
@@ -1451,9 +1417,9 @@ static int syslog_print(char __user *buf, int size)
 		size_t n;
 		size_t skip;
 
-		logbuf_lock_irq();
+		syslog_lock_irq();
 		if (!prb_read_valid(prb, syslog_seq, &r)) {
-			logbuf_unlock_irq();
+			syslog_unlock_irq();
 			break;
 		}
 		if (r.info->seq != syslog_seq) {
@@ -1482,7 +1448,7 @@ static int syslog_print(char __user *buf, int size)
 			syslog_partial += n;
 		} else
 			n = 0;
-		logbuf_unlock_irq();
+		syslog_unlock_irq();
 
 		if (!n)
 			break;
@@ -1507,6 +1473,8 @@ static int syslog_print_all(char __user *buf, int size, bool clear)
 	struct printk_info info;
 	unsigned int line_count;
 	struct printk_record r;
+	u64 newest_seq;
+	u64 clr_seq;
 	char *text;
 	int len = 0;
 	u64 seq;
@@ -1517,17 +1485,31 @@ static int syslog_print_all(char __user *buf, int size, bool clear)
 		return -ENOMEM;
 
 	time = printk_time;
-	logbuf_lock_irq();
+	syslog_lock_irq();
+	clr_seq = clear_seq;
+	syslog_unlock_irq();
+
 	/*
 	 * Find first record that fits, including all following records,
 	 * into the user-provided buffer for this dump.
 	 */
-	prb_for_each_info(clear_seq, prb, seq, &info, &line_count)
+	prb_for_each_info(clr_seq, prb, seq, &info, &line_count)
 		len += get_record_print_text_size(&info, line_count, true, time);
 
-	/* move first record forward until length fits into the buffer */
-	prb_for_each_info(clear_seq, prb, seq, &info, &line_count) {
-		if (len <= size)
+	/*
+	 * Keep track of the latest in case new records are coming in fast
+	 * and overwriting the older records.
+	 */
+	newest_seq = seq;
+
+	/*
+	 * Move first record forward until length fits into the buffer. This
+	 * is a best effort attempt. If @newest_seq is reached because the
+	 * ringbuffer is wrapping too fast, just start filling the buffer
+	 * from there.
+	 */
+	prb_for_each_info(clr_seq, prb, seq, &info, &line_count) {
+		if (len <= size || seq > newest_seq)
 			break;
 		len -= get_record_print_text_size(&info, line_count, true, time);
 	}
@@ -1545,20 +1527,20 @@ static int syslog_print_all(char __user *buf, int size, bool clear)
 			break;
 		}
 
-		logbuf_unlock_irq();
 		if (copy_to_user(buf + len, text, textlen))
 			len = -EFAULT;
 		else
 			len += textlen;
-		logbuf_lock_irq();
 
 		if (len < 0)
 			break;
 	}
 
-	if (clear)
+	if (clear) {
+		syslog_lock_irq();
 		clear_seq = seq;
-	logbuf_unlock_irq();
+		syslog_unlock_irq();
+	}
 
 	kfree(text);
 	return len;
@@ -1566,9 +1548,9 @@ static int syslog_print_all(char __user *buf, int size, bool clear)
 
 static void syslog_clear(void)
 {
-	logbuf_lock_irq();
+	syslog_lock_irq();
 	clear_seq = prb_next_seq(prb);
-	logbuf_unlock_irq();
+	syslog_unlock_irq();
 }
 
 int do_syslog(int type, char __user *buf, int len, int source)
@@ -1576,6 +1558,7 @@ int do_syslog(int type, char __user *buf, int len, int source)
 	bool clear = false;
 	static int saved_console_loglevel = LOGLEVEL_DEFAULT;
 	int error;
+	u64 seq;
 
 	error = check_syslog_permissions(type, source);
 	if (error)
@@ -1593,8 +1576,11 @@ int do_syslog(int type, char __user *buf, int len, int source)
 			return 0;
 		if (!access_ok(buf, len))
 			return -EFAULT;
+		syslog_lock_irq();
+		seq = syslog_seq;
+		syslog_unlock_irq();
 		error = wait_event_interruptible(log_wait,
-				prb_read_valid(prb, syslog_seq, NULL));
+				prb_read_valid(prb, seq, NULL));
 		if (error)
 			return error;
 		error = syslog_print(buf, len);
@@ -1642,7 +1628,7 @@ int do_syslog(int type, char __user *buf, int len, int source)
 		break;
 	/* Number of chars in the log buffer */
 	case SYSLOG_ACTION_SIZE_UNREAD:
-		logbuf_lock_irq();
+		syslog_lock_irq();
 		if (syslog_seq < prb_first_valid_seq(prb)) {
 			/* messages are gone, move to first one */
 			syslog_seq = prb_first_valid_seq(prb);
@@ -1669,7 +1655,7 @@ int do_syslog(int type, char __user *buf, int len, int source)
 			}
 			error -= syslog_partial;
 		}
-		logbuf_unlock_irq();
+		syslog_unlock_irq();
 		break;
 	/* Size of the log buffer */
 	case SYSLOG_ACTION_SIZE_BUFFER:
@@ -2106,10 +2092,9 @@ asmlinkage int vprintk_emit(int facility, int level,
 	boot_delay_msec(level);
 	printk_delay();
 
-	/* This stops the holder of console_sem just where we want him */
-	logbuf_lock_irqsave(flags);
+	printk_safe_enter_irqsave(flags);
 	printed_len = vprintk_store(facility, level, dev_info, fmt, args);
-	logbuf_unlock_irqrestore(flags);
+	printk_safe_exit_irqrestore(flags);
 
 	/* If called from the scheduler, we can not call up(). */
 	if (!in_sched) {
@@ -2541,7 +2526,6 @@ void console_unlock(void)
 		size_t len;
 
 		printk_safe_enter_irqsave(flags);
-		raw_spin_lock(&logbuf_lock);
 skip:
 		if (!prb_read_valid(prb, console_seq, &r))
 			break;
@@ -2585,7 +2569,6 @@ void console_unlock(void)
 				console_msg_format & MSG_FORMAT_SYSLOG,
 				printk_time);
 		console_seq++;
-		raw_spin_unlock(&logbuf_lock);
 
 		/*
 		 * While actively printing out messages, if another printk()
@@ -2612,8 +2595,6 @@ void console_unlock(void)
 
 	console_locked = 0;
 
-	raw_spin_unlock(&logbuf_lock);
-
 	up_console_sem();
 
 	/*
@@ -2622,9 +2603,7 @@ void console_unlock(void)
 	 * there's a new owner and the console_unlock() from them will do the
 	 * flush, no worries.
 	 */
-	raw_spin_lock(&logbuf_lock);
 	retry = prb_read_valid(prb, console_seq, NULL);
-	raw_spin_unlock(&logbuf_lock);
 	printk_safe_exit_irqrestore(flags);
 
 	if (retry && console_trylock())
@@ -2691,9 +2670,9 @@ void console_flush_on_panic(enum con_flush_mode mode)
 	if (mode == CONSOLE_REPLAY_ALL) {
 		unsigned long flags;
 
-		logbuf_lock_irqsave(flags);
+		local_irq_save(flags);
 		console_seq = prb_first_valid_seq(prb);
-		logbuf_unlock_irqrestore(flags);
+		local_irq_restore(flags);
 	}
 	console_unlock();
 }
@@ -2922,7 +2901,6 @@ void register_console(struct console *newcon)
 		 * console_unlock(); will print out the buffered messages
 		 * for us.
 		 */
-		logbuf_lock_irqsave(flags);
 		/*
 		 * We're about to replay the log buffer.  Only do this to the
 		 * just-registered console to avoid excessive message spam to
@@ -2934,8 +2912,10 @@ void register_console(struct console *newcon)
 		 */
 		exclusive_console = newcon;
 		exclusive_console_stop_seq = console_seq;
+
+		syslog_lock_irqsave(flags);
 		console_seq = syslog_seq;
-		logbuf_unlock_irqrestore(flags);
+		syslog_unlock_irqrestore(flags);
 	}
 	console_unlock();
 	console_sysfs_notify();
@@ -3338,10 +3318,11 @@ void kmsg_dump(enum kmsg_dump_reason reason)
 		/* initialize iterator with data about the stored records */
 		dumper->active = true;
 
-		logbuf_lock_irqsave(flags);
+		syslog_lock_irqsave(flags);
 		dumper->cur_seq = clear_seq;
+		syslog_unlock_irqrestore(flags);
+
 		dumper->next_seq = prb_next_seq(prb);
-		logbuf_unlock_irqrestore(flags);
 
 		/* invoke dumper which will iterate over records */
 		dumper->dump(dumper, reason);
@@ -3428,14 +3409,7 @@ bool kmsg_dump_get_line_nolock(struct kmsg_dumper *dumper, bool syslog,
 bool kmsg_dump_get_line(struct kmsg_dumper *dumper, bool syslog,
 			char *line, size_t size, size_t *len)
 {
-	unsigned long flags;
-	bool ret;
-
-	logbuf_lock_irqsave(flags);
-	ret = kmsg_dump_get_line_nolock(dumper, syslog, line, size, len);
-	logbuf_unlock_irqrestore(flags);
-
-	return ret;
+	return kmsg_dump_get_line_nolock(dumper, syslog, line, size, len);
 }
 EXPORT_SYMBOL_GPL(kmsg_dump_get_line);
 
@@ -3464,7 +3438,6 @@ bool kmsg_dump_get_buffer(struct kmsg_dumper *dumper, bool syslog,
 	struct printk_info info;
 	unsigned int line_count;
 	struct printk_record r;
-	unsigned long flags;
 	u64 seq;
 	u64 next_seq;
 	size_t l = 0;
@@ -3476,17 +3449,14 @@ bool kmsg_dump_get_buffer(struct kmsg_dumper *dumper, bool syslog,
 	if (!dumper->active || !buf || !size)
 		goto out;
 
-	logbuf_lock_irqsave(flags);
 	if (dumper->cur_seq < prb_first_valid_seq(prb)) {
 		/* messages are gone, move to first available one */
 		dumper->cur_seq = prb_first_valid_seq(prb);
 	}
 
 	/* last entry */
-	if (dumper->cur_seq >= dumper->next_seq) {
-		logbuf_unlock_irqrestore(flags);
+	if (dumper->cur_seq >= dumper->next_seq)
 		goto out;
-	}
 
 	/* calculate length of entire buffer */
 	seq = dumper->cur_seq;
@@ -3526,7 +3496,6 @@ bool kmsg_dump_get_buffer(struct kmsg_dumper *dumper, bool syslog,
 
 	dumper->next_seq = next_seq;
 	ret = true;
-	logbuf_unlock_irqrestore(flags);
 out:
 	if (len)
 		*len = l;
@@ -3563,10 +3532,11 @@ void kmsg_dump_rewind(struct kmsg_dumper *dumper)
 {
 	unsigned long flags;
 
-	logbuf_lock_irqsave(flags);
+	syslog_lock_irqsave(flags);
 	dumper->cur_seq = clear_seq;
+	syslog_unlock_irqrestore(flags);
+
 	dumper->next_seq = prb_next_seq(prb);
-	logbuf_unlock_irqrestore(flags);
 }
 EXPORT_SYMBOL_GPL(kmsg_dump_rewind);
 
diff --git a/kernel/printk/printk_safe.c b/kernel/printk/printk_safe.c
index 5dbc40160990..7c186cefdb50 100644
--- a/kernel/printk/printk_safe.c
+++ b/kernel/printk/printk_safe.c
@@ -16,8 +16,7 @@
 #include "internal.h"
 
 /*
- * printk() could not take logbuf_lock in NMI context. Instead,
- * it uses an alternative implementation that temporary stores
+ * Use an alternative implementation that temporary stores
  * the strings into a per-CPU buffer. The content of the buffer
  * is later flushed into the main ring buffer via IRQ work.
  *
@@ -266,18 +265,6 @@ void printk_safe_flush(void)
  */
 void printk_safe_flush_on_panic(void)
 {
-	/*
-	 * Make sure that we could access the main ring buffer.
-	 * Do not risk a double release when more CPUs are up.
-	 */
-	if (raw_spin_is_locked(&logbuf_lock)) {
-		if (num_online_cpus() > 1)
-			return;
-
-		debug_locks_off();
-		raw_spin_lock_init(&logbuf_lock);
-	}
-
 	printk_safe_flush();
 }
 
@@ -371,17 +358,15 @@ __printf(1, 0) int vprintk_func(const char *fmt, va_list args)
 	 * Try to use the main logbuf even in NMI. But avoid calling console
 	 * drivers that might have their own locks.
 	 */
-	if ((this_cpu_read(printk_context) & PRINTK_NMI_DIRECT_CONTEXT_MASK) &&
-	    raw_spin_trylock(&logbuf_lock)) {
+	if ((this_cpu_read(printk_context) & PRINTK_NMI_DIRECT_CONTEXT_MASK)) {
 		int len;
 
 		len = vprintk_store(0, LOGLEVEL_DEFAULT, NULL, fmt, args);
-		raw_spin_unlock(&logbuf_lock);
 		defer_console_output();
 		return len;
 	}
 
-	/* Use extra buffer in NMI when logbuf_lock is taken or in safe mode. */
+	/* Use extra buffer in NMI. */
 	if (this_cpu_read(printk_context) & PRINTK_NMI_CONTEXT_MASK)
 		return vprintk_nmi(fmt, args);
 
-- 
2.20.1

