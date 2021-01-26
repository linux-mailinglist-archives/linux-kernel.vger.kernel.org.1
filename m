Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8947F304FE3
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 04:35:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236261AbhA0Ddt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 22:33:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729562AbhAZVTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 16:19:20 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68B79C06178B
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 13:15:58 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1611695757;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wUpXpMYAdAvE9UZtc2jfZUagcTXEJhG3G+xBbDRVwq8=;
        b=4Dax5kNOT2bocf/aehqkrytG1RlMjslSq32AiyimzrPILAQQhiHZ82UJmcSWHWmq0d2dYR
        PXRMShaTXOAdpqlNjCmpX4/vZ/1tCPbrTNFHHO/rT7+yEcyI8O3w1ONmmKFKd+Z6V+fwnn
        7xa7NmVN3Rhj2QjGiXe4L6Fk+7bglGGAPt59hhI/WmfFHVmRm9oR47ug3FQHVWHyU9Io5y
        iTKjB6M7VnZvCmzUbm2I8MkOpLtoJr2BXhbOak8UMen4nXhxQAdN+LkrEt31e4tKhJYkXO
        NZSvDoBp6EjHYWvW5qsSti6mAA6u9d4FMv8lMENIXD1HG09vMNkYwF1GSzhVmw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1611695757;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wUpXpMYAdAvE9UZtc2jfZUagcTXEJhG3G+xBbDRVwq8=;
        b=Vt7tnh+8Hxw5xFit4+kYoQ7ctVbxKB+SpLiK3p4M56U9WLKz4oBUn+57l+3yZgdPRy8WyQ
        Q5lCxa4ZzN1I+nBw==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH printk-rework 11/12] printk: remove logbuf_lock
Date:   Tue, 26 Jan 2021 22:21:50 +0106
Message-Id: <20210126211551.26536-12-john.ogness@linutronix.de>
In-Reply-To: <20210126211551.26536-1-john.ogness@linutronix.de>
References: <20210126211551.26536-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the ringbuffer is lockless, there is no need for it to be
protected by @logbuf_lock. Remove @logbuf_lock.

This means that printk_nmi_direct and printk_safe_flush_on_panic()
no longer need to acquire any lock to run.

@console_seq, @exclusive_console_stop_seq, @console_dropped are
protected by @console_lock.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 kernel/printk/internal.h    |   4 +-
 kernel/printk/printk.c      | 134 +++++++++++-------------------------
 kernel/printk/printk_safe.c |  29 +++-----
 3 files changed, 50 insertions(+), 117 deletions(-)

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
index d14a4afc5b72..b57dba7f077d 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -355,41 +355,6 @@ enum log_flags {
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
-
 /* syslog_lock protects syslog_* variables and write access to clear_seq. */
 static DEFINE_RAW_SPINLOCK(syslog_lock);
 
@@ -401,6 +366,7 @@ static u64 syslog_seq;
 static size_t syslog_partial;
 static bool syslog_time;
 
+/* All 3 protected by @console_sem. */
 /* the next printk record to write to the console */
 static u64 console_seq;
 static u64 exclusive_console_stop_seq;
@@ -762,27 +728,27 @@ static ssize_t devkmsg_read(struct file *file, char __user *buf,
 	if (ret)
 		return ret;
 
-	logbuf_lock_irq();
+	printk_safe_enter_irq();
 	if (!prb_read_valid(prb, atomic64_read(&user->seq), r)) {
 		if (file->f_flags & O_NONBLOCK) {
 			ret = -EAGAIN;
-			logbuf_unlock_irq();
+			printk_safe_exit_irq();
 			goto out;
 		}
 
-		logbuf_unlock_irq();
+		printk_safe_exit_irq();
 		ret = wait_event_interruptible(log_wait,
 				prb_read_valid(prb, atomic64_read(&user->seq), r));
 		if (ret)
 			goto out;
-		logbuf_lock_irq();
+		printk_safe_enter_irq();
 	}
 
 	if (atomic64_read(&user->seq) < prb_first_valid_seq(prb)) {
 		/* our last seen message is gone, return error and reset */
 		atomic64_set(&user->seq, prb_first_valid_seq(prb));
 		ret = -EPIPE;
-		logbuf_unlock_irq();
+		printk_safe_exit_irq();
 		goto out;
 	}
 
@@ -792,7 +758,7 @@ static ssize_t devkmsg_read(struct file *file, char __user *buf,
 				  &r->info->dev_info);
 
 	atomic64_set(&user->seq, r->info->seq + 1);
-	logbuf_unlock_irq();
+	printk_safe_exit_irq();
 
 	if (len > count) {
 		ret = -EINVAL;
@@ -827,7 +793,7 @@ static loff_t devkmsg_llseek(struct file *file, loff_t offset, int whence)
 	if (offset)
 		return -ESPIPE;
 
-	logbuf_lock_irq();
+	printk_safe_enter_irq();
 	switch (whence) {
 	case SEEK_SET:
 		/* the first record */
@@ -848,7 +814,7 @@ static loff_t devkmsg_llseek(struct file *file, loff_t offset, int whence)
 	default:
 		ret = -EINVAL;
 	}
-	logbuf_unlock_irq();
+	printk_safe_exit_irq();
 	return ret;
 }
 
@@ -862,7 +828,7 @@ static __poll_t devkmsg_poll(struct file *file, poll_table *wait)
 
 	poll_wait(file, &log_wait, wait);
 
-	logbuf_lock_irq();
+	printk_safe_enter_irq();
 	if (prb_read_valid(prb, atomic64_read(&user->seq), NULL)) {
 		/* return error when data has vanished underneath us */
 		if (atomic64_read(&user->seq) < prb_first_valid_seq(prb))
@@ -870,7 +836,7 @@ static __poll_t devkmsg_poll(struct file *file, poll_table *wait)
 		else
 			ret = EPOLLIN|EPOLLRDNORM;
 	}
-	logbuf_unlock_irq();
+	printk_safe_exit_irq();
 
 	return ret;
 }
@@ -903,9 +869,9 @@ static int devkmsg_open(struct inode *inode, struct file *file)
 	prb_rec_init_rd(&user->record, &user->info,
 			&user->text_buf[0], sizeof(user->text_buf));
 
-	logbuf_lock_irq();
+	printk_safe_enter_irq();
 	atomic64_set(&user->seq, prb_first_valid_seq(prb));
-	logbuf_unlock_irq();
+	printk_safe_exit_irq();
 
 	file->private_data = user;
 	return 0;
@@ -1518,11 +1484,11 @@ static int syslog_print(char __user *buf, int size)
 		size_t n;
 		size_t skip;
 
-		logbuf_lock_irq();
+		printk_safe_enter_irq();
 		raw_spin_lock(&syslog_lock);
 		if (!prb_read_valid(prb, syslog_seq, &r)) {
 			raw_spin_unlock(&syslog_lock);
-			logbuf_unlock_irq();
+			printk_safe_exit_irq();
 			break;
 		}
 		if (r.info->seq != syslog_seq) {
@@ -1552,7 +1518,7 @@ static int syslog_print(char __user *buf, int size)
 		} else
 			n = 0;
 		raw_spin_unlock(&syslog_lock);
-		logbuf_unlock_irq();
+		printk_safe_exit_irq();
 
 		if (!n)
 			break;
@@ -1586,7 +1552,7 @@ static int syslog_print_all(char __user *buf, int size, bool clear)
 		return -ENOMEM;
 
 	time = printk_time;
-	logbuf_lock_irq();
+	printk_safe_enter_irq();
 	/*
 	 * Find first record that fits, including all following records,
 	 * into the user-provided buffer for this dump.
@@ -1607,12 +1573,12 @@ static int syslog_print_all(char __user *buf, int size, bool clear)
 			break;
 		}
 
-		logbuf_unlock_irq();
+		printk_safe_exit_irq();
 		if (copy_to_user(buf + len, text, textlen))
 			len = -EFAULT;
 		else
 			len += textlen;
-		logbuf_lock_irq();
+		printk_safe_enter_irq();
 
 		if (len < 0)
 			break;
@@ -1623,7 +1589,7 @@ static int syslog_print_all(char __user *buf, int size, bool clear)
 		latched_seq_write(&clear_seq, seq);
 		raw_spin_unlock(&syslog_lock);
 	}
-	logbuf_unlock_irq();
+	printk_safe_exit_irq();
 
 	kfree(text);
 	return len;
@@ -1631,11 +1597,11 @@ static int syslog_print_all(char __user *buf, int size, bool clear)
 
 static void syslog_clear(void)
 {
-	logbuf_lock_irq();
+	printk_safe_enter_irq();
 	raw_spin_lock(&syslog_lock);
 	latched_seq_write(&clear_seq, prb_next_seq(prb));
 	raw_spin_unlock(&syslog_lock);
-	logbuf_unlock_irq();
+	printk_safe_exit_irq();
 }
 
 int do_syslog(int type, char __user *buf, int len, int source)
@@ -1716,7 +1682,7 @@ int do_syslog(int type, char __user *buf, int len, int source)
 		break;
 	/* Number of chars in the log buffer */
 	case SYSLOG_ACTION_SIZE_UNREAD:
-		logbuf_lock_irq();
+		printk_safe_enter_irq();
 		raw_spin_lock(&syslog_lock);
 		if (syslog_seq < prb_first_valid_seq(prb)) {
 			/* messages are gone, move to first one */
@@ -1745,7 +1711,7 @@ int do_syslog(int type, char __user *buf, int len, int source)
 			error -= syslog_partial;
 		}
 		raw_spin_unlock(&syslog_lock);
-		logbuf_unlock_irq();
+		printk_safe_exit_irq();
 		break;
 	/* Size of the log buffer */
 	case SYSLOG_ACTION_SIZE_BUFFER:
@@ -2593,7 +2559,6 @@ void console_unlock(void)
 		size_t len;
 
 		printk_safe_enter_irqsave(flags);
-		raw_spin_lock(&logbuf_lock);
 skip:
 		if (!prb_read_valid(prb, console_seq, &r))
 			break;
@@ -2637,7 +2602,6 @@ void console_unlock(void)
 				console_msg_format & MSG_FORMAT_SYSLOG,
 				printk_time);
 		console_seq++;
-		raw_spin_unlock(&logbuf_lock);
 
 		/*
 		 * While actively printing out messages, if another printk()
@@ -2664,8 +2628,6 @@ void console_unlock(void)
 
 	console_locked = 0;
 
-	raw_spin_unlock(&logbuf_lock);
-
 	up_console_sem();
 
 	/*
@@ -2674,9 +2636,7 @@ void console_unlock(void)
 	 * there's a new owner and the console_unlock() from them will do the
 	 * flush, no worries.
 	 */
-	raw_spin_lock(&logbuf_lock);
 	retry = prb_read_valid(prb, console_seq, NULL);
-	raw_spin_unlock(&logbuf_lock);
 	printk_safe_exit_irqrestore(flags);
 
 	if (retry && console_trylock())
@@ -2743,9 +2703,9 @@ void console_flush_on_panic(enum con_flush_mode mode)
 	if (mode == CONSOLE_REPLAY_ALL) {
 		unsigned long flags;
 
-		logbuf_lock_irqsave(flags);
+		printk_safe_enter_irqsave(flags);
 		console_seq = prb_first_valid_seq(prb);
-		logbuf_unlock_irqrestore(flags);
+		printk_safe_exit_irqrestore(flags);
 	}
 	console_unlock();
 }
@@ -2973,9 +2933,7 @@ void register_console(struct console *newcon)
 		/*
 		 * console_unlock(); will print out the buffered messages
 		 * for us.
-		 */
-		logbuf_lock_irqsave(flags);
-		/*
+		 *
 		 * We're about to replay the log buffer.  Only do this to the
 		 * just-registered console to avoid excessive message spam to
 		 * the already-registered consoles.
@@ -2988,11 +2946,9 @@ void register_console(struct console *newcon)
 		exclusive_console_stop_seq = console_seq;
 
 		/* Get a consistent copy of @syslog_seq. */
-		raw_spin_lock(&syslog_lock);
+		raw_spin_lock_irqsave(&syslog_lock, flags);
 		console_seq = syslog_seq;
-		raw_spin_unlock(&syslog_lock);
-
-		logbuf_unlock_irqrestore(flags);
+		raw_spin_unlock_irqrestore(&syslog_lock, flags);
 	}
 	console_unlock();
 	console_sysfs_notify();
@@ -3359,7 +3315,6 @@ void kmsg_dump(enum kmsg_dump_reason reason)
 {
 	struct kmsg_dumper_iter iter;
 	struct kmsg_dumper *dumper;
-	unsigned long flags;
 
 	rcu_read_lock();
 	list_for_each_entry_rcu(dumper, &dump_list, list) {
@@ -3378,10 +3333,7 @@ void kmsg_dump(enum kmsg_dump_reason reason)
 
 		/* initialize iterator with data about the stored records */
 		iter.active = true;
-		logbuf_lock_irqsave(flags);
-		iter.cur_seq = latched_seq_read_nolock(&clear_seq);
-		iter.next_seq = prb_next_seq(prb);
-		logbuf_unlock_irqrestore(flags);
+		kmsg_dump_rewind_nolock(&iter);
 
 		/* invoke dumper which will iterate over records */
 		dumper->dump(dumper, reason, &iter);
@@ -3414,9 +3366,11 @@ bool kmsg_dump_get_line_nolock(struct kmsg_dumper_iter *iter, bool syslog,
 	struct printk_info info;
 	unsigned int line_count;
 	struct printk_record r;
+	unsigned long flags;
 	size_t l = 0;
 	bool ret = false;
 
+	printk_safe_enter_irqsave(flags);
 	prb_rec_init_rd(&r, &info, line, size);
 
 	if (!iter->active)
@@ -3440,6 +3394,7 @@ bool kmsg_dump_get_line_nolock(struct kmsg_dumper_iter *iter, bool syslog,
 	iter->cur_seq = r.info->seq + 1;
 	ret = true;
 out:
+	printk_safe_exit_irqrestore(flags);
 	if (len)
 		*len = l;
 	return ret;
@@ -3465,14 +3420,7 @@ bool kmsg_dump_get_line_nolock(struct kmsg_dumper_iter *iter, bool syslog,
 bool kmsg_dump_get_line(struct kmsg_dumper_iter *iter, bool syslog,
 			char *line, size_t size, size_t *len)
 {
-	unsigned long flags;
-	bool ret;
-
-	logbuf_lock_irqsave(flags);
-	ret = kmsg_dump_get_line_nolock(iter, syslog, line, size, len);
-	logbuf_unlock_irqrestore(flags);
-
-	return ret;
+	return kmsg_dump_get_line_nolock(iter, syslog, line, size, len);
 }
 EXPORT_SYMBOL_GPL(kmsg_dump_get_line);
 
@@ -3510,7 +3458,7 @@ bool kmsg_dump_get_buffer(struct kmsg_dumper_iter *iter, bool syslog,
 	if (!iter->active || !buf || !size)
 		goto out;
 
-	logbuf_lock_irqsave(flags);
+	printk_safe_enter_irqsave(flags);
 	if (iter->cur_seq < prb_first_valid_seq(prb)) {
 		/* messages are gone, move to first available one */
 		iter->cur_seq = prb_first_valid_seq(prb);
@@ -3518,7 +3466,7 @@ bool kmsg_dump_get_buffer(struct kmsg_dumper_iter *iter, bool syslog,
 
 	/* last entry */
 	if (iter->cur_seq >= iter->next_seq) {
-		logbuf_unlock_irqrestore(flags);
+		printk_safe_exit_irqrestore(flags);
 		goto out;
 	}
 
@@ -3549,7 +3497,7 @@ bool kmsg_dump_get_buffer(struct kmsg_dumper_iter *iter, bool syslog,
 
 	iter->next_seq = next_seq;
 	ret = true;
-	logbuf_unlock_irqrestore(flags);
+	printk_safe_exit_irqrestore(flags);
 out:
 	if (len_out)
 		*len_out = len;
@@ -3569,8 +3517,12 @@ EXPORT_SYMBOL_GPL(kmsg_dump_get_buffer);
  */
 void kmsg_dump_rewind_nolock(struct kmsg_dumper_iter *iter)
 {
+	unsigned long flags;
+
+	printk_safe_enter_irqsave(flags);
 	iter->cur_seq = latched_seq_read_nolock(&clear_seq);
 	iter->next_seq = prb_next_seq(prb);
+	printk_safe_exit_irqrestore(flags);
 }
 
 /**
@@ -3583,11 +3535,7 @@ void kmsg_dump_rewind_nolock(struct kmsg_dumper_iter *iter)
  */
 void kmsg_dump_rewind(struct kmsg_dumper_iter *iter)
 {
-	unsigned long flags;
-
-	logbuf_lock_irqsave(flags);
 	kmsg_dump_rewind_nolock(iter);
-	logbuf_unlock_irqrestore(flags);
 }
 EXPORT_SYMBOL_GPL(kmsg_dump_rewind);
 
diff --git a/kernel/printk/printk_safe.c b/kernel/printk/printk_safe.c
index a0e6f746de6c..a9a3137bd972 100644
--- a/kernel/printk/printk_safe.c
+++ b/kernel/printk/printk_safe.c
@@ -16,7 +16,7 @@
 #include "internal.h"
 
 /*
- * printk() could not take logbuf_lock in NMI context. Instead,
+ * In NMI and safe mode, printk() avoids taking locks. Instead,
  * it uses an alternative implementation that temporary stores
  * the strings into a per-CPU buffer. The content of the buffer
  * is later flushed into the main ring buffer via IRQ work.
@@ -266,18 +266,6 @@ void printk_safe_flush(void)
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
 
@@ -311,9 +299,7 @@ void noinstr printk_nmi_exit(void)
  * reordering.
  *
  * It has effect only when called in NMI context. Then printk()
- * will try to store the messages into the main logbuf directly
- * and use the per-CPU buffers only as a fallback when the lock
- * is not available.
+ * will store the messages into the main logbuf directly.
  */
 void printk_nmi_direct_enter(void)
 {
@@ -368,20 +354,21 @@ __printf(1, 0) int vprintk_func(const char *fmt, va_list args)
 #endif
 
 	/*
-	 * Try to use the main logbuf even in NMI. But avoid calling console
+	 * Use the main logbuf even in NMI. But avoid calling console
 	 * drivers that might have their own locks.
 	 */
-	if ((this_cpu_read(printk_context) & PRINTK_NMI_DIRECT_CONTEXT_MASK) &&
-	    raw_spin_trylock(&logbuf_lock)) {
+	if ((this_cpu_read(printk_context) & PRINTK_NMI_DIRECT_CONTEXT_MASK)) {
+		unsigned long flags;
 		int len;
 
+		printk_safe_enter_irqsave(flags);
 		len = vprintk_store(0, LOGLEVEL_DEFAULT, NULL, fmt, args);
-		raw_spin_unlock(&logbuf_lock);
+		printk_safe_exit_irqrestore(flags);
 		defer_console_output();
 		return len;
 	}
 
-	/* Use extra buffer in NMI when logbuf_lock is taken or in safe mode. */
+	/* Use extra buffer in NMI. */
 	if (this_cpu_read(printk_context) & PRINTK_NMI_CONTEXT_MASK)
 		return vprintk_nmi(fmt, args);
 
-- 
2.20.1

