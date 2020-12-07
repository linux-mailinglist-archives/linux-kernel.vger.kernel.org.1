Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5EF92D1D34
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 23:23:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728012AbgLGWVG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 17:21:06 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:39226 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727281AbgLGWVF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 17:21:05 -0500
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607379623;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ffdn/d6YKHDKkGyemzTmLc5K1NIiOGgQkvkjXNBeldY=;
        b=BNZlynDLUaMcIVZkLpgNtaYz9popsTiNJvzbJcOQbsgf42i9VmV8nZyfve1rJm7FQ0ffvk
        XRXIK2Aa5sGIlTYqFLiqy3hqQAFRyLLfZYEL09Vc/5ywcYiQk0e65SaNXGJNaw8BQLBEC/
        wfsN8fpXranPeZ0HWXlrUcLqV+afJXRdQFJ1580TMGSmzt64xB3V+9xZDAe9901S0/HDpr
        SsTjp7L2bY0DqzIHayekUtpyWy+CmC2MOQeWS1usFFEhKSrD8VE7PWg1UEob18Y8MCUofe
        krUq8wyaLnNp5j6NPy9N9rV3ZJh47eyA2qMMVhYlDCs591amAnu56stOSALmPg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607379623;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ffdn/d6YKHDKkGyemzTmLc5K1NIiOGgQkvkjXNBeldY=;
        b=6ZuOe+lA250UYCSZV7lJvOwC4DNDtImZ0QCcIoV8idAMoLFKlkXxBOusvAB+1jCj8WAlOA
        7pG6rMaI7cJsRyAg==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH next v3 3/3] printk: remove logbuf_lock protection for ringbuffer
Date:   Mon,  7 Dec 2020 23:26:20 +0106
Message-Id: <20201207222020.2923-4-john.ogness@linutronix.de>
In-Reply-To: <20201207222020.2923-1-john.ogness@linutronix.de>
References: <20201207222020.2923-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the ringbuffer is lockless, there is no need for it to be
protected by @logbuf_lock. Remove @logbuf_lock protection of the
ringbuffer.

This means that printk_nmi_direct and printk_safe_flush_on_panic()
no longer need to acquire any lock to run.

Without @logbuf_lock it is no longer possible to use the single
static buffer for temporarily sprint'ing the message. Instead,
use vsnprintf() to determine the length and perform the real
vscnprintf() using the area reserved from the ringbuffer. This
leads to suboptimal packing of the message data, but will
result in less wasted storage than multiple per-cpu buffers to
support lockless temporary sprint'ing.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 kernel/printk/printk.c      | 131 +++++++++++++++++++++++++-----------
 kernel/printk/printk_safe.c |  18 +----
 2 files changed, 95 insertions(+), 54 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index e1f068677a74..f3c0fcc3163f 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -1068,7 +1068,6 @@ void __init setup_log_buf(int early)
 	struct printk_record r;
 	size_t new_descs_size;
 	size_t new_infos_size;
-	unsigned long flags;
 	char *new_log_buf;
 	unsigned int free;
 	u64 seq;
@@ -1126,8 +1125,6 @@ void __init setup_log_buf(int early)
 		 new_descs, ilog2(new_descs_count),
 		 new_infos);
 
-	logbuf_lock_irqsave(flags);
-
 	log_buf_len = new_log_buf_len;
 	log_buf = new_log_buf;
 	new_log_buf_len = 0;
@@ -1143,8 +1140,6 @@ void __init setup_log_buf(int early)
 	 */
 	prb = &printk_rb_dynamic;
 
-	logbuf_unlock_irqrestore(flags);
-
 	if (seq != prb_next_seq(&printk_rb_static)) {
 		pr_err("dropped %llu messages\n",
 		       prb_next_seq(&printk_rb_static) - seq);
@@ -1861,19 +1856,91 @@ static inline u32 printk_caller_id(void)
 		0x80000000 + raw_smp_processor_id();
 }
 
-/* Must be called under logbuf_lock. */
+/**
+ * parse_prefix - Parse level and control flags.
+ *
+ * @text:     The text message.
+ * @text_len: A pointer to a value of strlen(@text), will be updated.
+ * @level:    A pointer to the current level value, will be updated.
+ * @lflags:   A pointer to the current log flags, will be updated.
+ *
+ * The variable pointed to by @text_len is updated to the message length
+ * when subtracting the parsed level and control flag length.
+ *
+ * @level may be NULL if the caller is not interested in the parsed value.
+ * Otherwise the variable pointed to by @level must be set to
+ * LOGLEVEL_DEFAULT in order to be updated with the parsed value.
+ *
+ * @lflags may be NULL if the caller is not interested in the parsed value.
+ * Otherwise the variable pointed to by @lflags will be OR'd with the parsed
+ * value.
+ *
+ * Return: The text message with the parsed level and control flags skipped.
+ */
+static char *parse_prefix(char *text, u16 *text_len, int *level, enum log_flags *lflags)
+{
+	int kern_level;
+
+	while (*text_len >= 2) {
+		kern_level = printk_get_level(text);
+		if (!kern_level)
+			break;
+
+		switch (kern_level) {
+		case '0' ... '7':
+			if (level && *level == LOGLEVEL_DEFAULT)
+				*level = kern_level - '0';
+			break;
+		case 'c':	/* KERN_CONT */
+			if (lflags)
+				*lflags |= LOG_CONT;
+		}
+
+		*text_len -= 2;
+		text += 2;
+	}
+
+	return text;
+}
+
+static u16 printk_sprint(char *text, u16 size, int facility, enum log_flags *lflags,
+			 const char *fmt, va_list args)
+{
+	char *orig_text = text;
+	u16 text_len;
+
+	text_len = vscnprintf(text, size, fmt, args);
+
+	/* Mark and strip a trailing newline. */
+	if (text_len && text[text_len - 1] == '\n') {
+		text_len--;
+		*lflags |= LOG_NEWLINE;
+	}
+
+	/* Strip log level and control flags. */
+	if (facility == 0) {
+		text = parse_prefix(text, &text_len, NULL, NULL);
+		if (text != orig_text)
+			memmove(orig_text, text, text_len);
+	}
+
+	return text_len;
+}
+
+__printf(4, 0)
 int vprintk_store(int facility, int level,
 		  const struct dev_printk_info *dev_info,
 		  const char *fmt, va_list args)
 {
 	const u32 caller_id = printk_caller_id();
-	static char textbuf[LOG_LINE_MAX];
 	struct prb_reserved_entry e;
 	enum log_flags lflags = 0;
 	struct printk_record r;
 	u16 trunc_msg_len = 0;
-	char *text = textbuf;
+	char prefix_buf[8];
+	va_list args2;
 	u16 text_len;
+	int ret = 0;
 	u64 ts_nsec;
 
 	/*
@@ -1884,35 +1951,21 @@ int vprintk_store(int facility, int level,
 	 */
 	ts_nsec = local_clock();
 
+	va_copy(args2, args);
+
 	/*
 	 * The printf needs to come first; we need the syslog
 	 * prefix which might be passed-in as a parameter.
 	 */
-	text_len = vscnprintf(text, sizeof(textbuf), fmt, args);
+	text_len = vsnprintf(&prefix_buf[0], sizeof(prefix_buf), fmt, args) + 1;
+	if (text_len > CONSOLE_LOG_MAX)
+		text_len = CONSOLE_LOG_MAX;
 
-	/* mark and strip a trailing newline */
-	if (text_len && text[text_len-1] == '\n') {
-		text_len--;
-		lflags |= LOG_NEWLINE;
-	}
-
-	/* strip kernel syslog prefix and extract log level or control flags */
+	/* Extract log level or control flags. */
 	if (facility == 0) {
-		int kern_level;
-
-		while ((kern_level = printk_get_level(text)) != 0) {
-			switch (kern_level) {
-			case '0' ... '7':
-				if (level == LOGLEVEL_DEFAULT)
-					level = kern_level - '0';
-				break;
-			case 'c':	/* KERN_CONT */
-				lflags |= LOG_CONT;
-			}
+		u16 tmplen = sizeof(prefix_buf);
 
-			text_len -= 2;
-			text += 2;
-		}
+		parse_prefix(&prefix_buf[0], &tmplen, &level, &lflags);
 	}
 
 	if (level == LOGLEVEL_DEFAULT)
@@ -1924,7 +1977,8 @@ int vprintk_store(int facility, int level,
 	if (lflags & LOG_CONT) {
 		prb_rec_init_wr(&r, text_len);
 		if (prb_reserve_in_last(&e, prb, &r, caller_id, LOG_LINE_MAX)) {
-			memcpy(&r.text_buf[r.info->text_len], text, text_len);
+			text_len = printk_sprint(&r.text_buf[r.info->text_len], text_len,
+						 facility, &lflags, fmt, args2);
 			r.info->text_len += text_len;
 
 			if (lflags & LOG_NEWLINE) {
@@ -1934,7 +1988,8 @@ int vprintk_store(int facility, int level,
 				prb_commit(&e);
 			}
 
-			return text_len;
+			ret = text_len;
+			goto out;
 		}
 	}
 
@@ -1950,11 +2005,11 @@ int vprintk_store(int facility, int level,
 
 		prb_rec_init_wr(&r, text_len + trunc_msg_len);
 		if (!prb_reserve(&e, prb, &r))
-			return 0;
+			goto out;
 	}
 
 	/* fill message */
-	memcpy(&r.text_buf[0], text, text_len);
+	text_len = printk_sprint(&r.text_buf[0], text_len, facility, &lflags, fmt, args2);
 	if (trunc_msg_len)
 		memcpy(&r.text_buf[text_len], trunc_msg, trunc_msg_len);
 	r.info->text_len = text_len + trunc_msg_len;
@@ -1972,7 +2027,10 @@ int vprintk_store(int facility, int level,
 	else
 		prb_final_commit(&e);
 
-	return (text_len + trunc_msg_len);
+	ret = text_len + trunc_msg_len;
+out:
+	va_end(args2);
+	return ret;
 }
 
 asmlinkage int vprintk_emit(int facility, int level,
@@ -1995,10 +2053,7 @@ asmlinkage int vprintk_emit(int facility, int level,
 	boot_delay_msec(level);
 	printk_delay();
 
-	/* This stops the holder of console_sem just where we want him */
-	logbuf_lock_irqsave(flags);
 	printed_len = vprintk_store(facility, level, dev_info, fmt, args);
-	logbuf_unlock_irqrestore(flags);
 
 	/* If called from the scheduler, we can not call up(). */
 	if (!in_sched) {
diff --git a/kernel/printk/printk_safe.c b/kernel/printk/printk_safe.c
index a0e6f746de6c..7248b6e3df6c 100644
--- a/kernel/printk/printk_safe.c
+++ b/kernel/printk/printk_safe.c
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
 
@@ -371,17 +359,15 @@ __printf(1, 0) int vprintk_func(const char *fmt, va_list args)
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
+	/* Use extra buffer in NMI or in safe mode. */
 	if (this_cpu_read(printk_context) & PRINTK_NMI_CONTEXT_MASK)
 		return vprintk_nmi(fmt, args);
 
-- 
2.20.1

