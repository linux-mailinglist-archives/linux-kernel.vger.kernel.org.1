Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAC602D37F1
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 01:47:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730579AbgLIApo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 19:45:44 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:42404 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730013AbgLIApj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 19:45:39 -0500
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607474696;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qUdnmaVUeBCyf8i2OybcburzgvLucPgDLqGr8r6nzPQ=;
        b=wh1Slhj3hGO3g0y8meR1RsHWLpvERP3UeXMTX6MXBejro8R3Mrq636SVWoV8dzLyVoiXoj
        gEhjhbTgAJzwsW1t7EfGRb+VOxdCnjF5fNB1nJmELD4qboy5w4t6fJ+o+/BqVs0DyzAg7u
        +GwLqqilqYph4/UmI7f9+814wsnGN7n4sq9aGzYi7E5u+V6NSJ5m3PlZU6k0wzaGzhMU59
        iTI3VAwwLpuRW8mt3POPaczC3LIpQYR+pprO0ipJ2fUXUcmzCCtZMKBXjN+zqjvtvSrmp1
        ttoD8zrszy7R3QOraYNOWdCb4PERfzp98rwpfBW1oBBJEGRBhm4H1R4qhQFlcw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607474696;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qUdnmaVUeBCyf8i2OybcburzgvLucPgDLqGr8r6nzPQ=;
        b=UVCosGPfW21CS80x/2RTKejG+4gtrJjDpHtSgboaU++hG2977T8MeZhDcXb4XbrdC6D3cB
        OYEE9HQUl7uhPWCw==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH next v4 2/2] printk: remove logbuf_lock writer-protection of ringbuffer
Date:   Wed,  9 Dec 2020 01:50:53 +0106
Message-Id: <20201209004453.17720-3-john.ogness@linutronix.de>
In-Reply-To: <20201209004453.17720-1-john.ogness@linutronix.de>
References: <20201209004453.17720-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the ringbuffer is lockless, there is no need for it to be
protected by @logbuf_lock. Remove @logbuf_lock writer-protection of
the ringbuffer. The reader-protection is not removed because some
some variables used by readers are using @logbuf_lock for
synchronization: @syslog_seq, @syslog_time, @syslog_partial,
@console_seq, struct kmsg_dumper.

For PRINTK_NMI_DIRECT_CONTEXT_MASK, @logbuf_lock usage is not removed
because it may be used for dumper synchronization.

Without @logbuf_lock synchronization of vprintk_store() it is no
longer possible to use the single static buffer for temporarily
sprint'ing the message. Instead, use vsnprintf() to determine the
length and perform the real vscnprintf() using the area reserved from
the ringbuffer. This leads to suboptimal packing of the message data,
but will result in less wasted storage than multiple per-cpu buffers
to support lockless temporary sprint'ing.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 v3
   - restore reader usage of logbuf_lock
   - remove recursion detection
   - consolidate code into parse_prefix() helper

 v4
   - restore printk_safe for setup_log_buf() and vprintk_store()
   - parse_prefix(): simplify caller semantics
   - vprintk_store(): add @reserve_size variable
   - vprintk_store(): document the +1 for vsnprintf()
   - vprintk_store(): swap args/arg2 usage
   - vprintk_store(): remove "out" label
   - restore @logbuf_lock usage in printk_safe.c

 kernel/printk/printk.c | 138 +++++++++++++++++++++++++++++------------
 1 file changed, 98 insertions(+), 40 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index bf5fd2be3a05..a0ba779fb926 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -1126,7 +1126,7 @@ void __init setup_log_buf(int early)
 		 new_descs, ilog2(new_descs_count),
 		 new_infos);
 
-	logbuf_lock_irqsave(flags);
+	printk_safe_enter_irqsave(flags);
 
 	log_buf_len = new_log_buf_len;
 	log_buf = new_log_buf;
@@ -1143,7 +1143,7 @@ void __init setup_log_buf(int early)
 	 */
 	prb = &printk_rb_dynamic;
 
-	logbuf_unlock_irqrestore(flags);
+	printk_safe_exit_irqrestore(flags);
 
 	if (seq != prb_next_seq(&printk_rb_static)) {
 		pr_err("dropped %llu messages\n",
@@ -1861,18 +1861,90 @@ static inline u32 printk_caller_id(void)
 		0x80000000 + raw_smp_processor_id();
 }
 
-/* Must be called under logbuf_lock. */
+/**
+ * parse_prefix - Parse level and control flags.
+ *
+ * @text:     The terminated text message.
+ * @level:    A pointer to the current level value, will be updated.
+ * @lflags:   A pointer to the current log flags, will be updated.
+ *
+ * @level may be NULL if the caller is not interested in the parsed value.
+ * Otherwise the variable pointed to by @level must be set to
+ * LOGLEVEL_DEFAULT in order to be updated with the parsed value.
+ *
+ * @lflags may be NULL if the caller is not interested in the parsed value.
+ * Otherwise the variable pointed to by @lflags will be OR'd with the parsed
+ * value.
+ *
+ * Return: The length of the parsed level and control flags.
+ */
+static u16 parse_prefix(char *text, int *level, enum log_flags *lflags)
+{
+	u16 prefix_len = 0;
+	int kern_level;
+
+	while (*text) {
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
+		prefix_len += 2;
+		text += 2;
+	}
+
+	return prefix_len;
+}
+
+static u16 printk_sprint(char *text, u16 size, int facility, enum log_flags *lflags,
+			 const char *fmt, va_list args)
+{
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
+		u16 prefix_len;
+
+		prefix_len = parse_prefix(text, NULL, NULL);
+		if (prefix_len) {
+			text_len -= prefix_len;
+			memmove(text, text + prefix_len, text_len);
+		}
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
+	u16 reserve_size;
+	va_list args2;
 	u16 text_len;
 	u64 ts_nsec;
 
@@ -1885,35 +1957,21 @@ int vprintk_store(int facility, int level,
 	ts_nsec = local_clock();
 
 	/*
-	 * The printf needs to come first; we need the syslog
-	 * prefix which might be passed-in as a parameter.
+	 * The sprintf needs to come first since the syslog prefix might be
+	 * passed in as a parameter. An extra byte must be reserved so that
+	 * later the vscnprintf() into the reserved buffer has room for the
+	 * terminating '\0', which is not counted by vsnprintf().
 	 */
-	text_len = vscnprintf(text, sizeof(textbuf), fmt, args);
-
-	/* mark and strip a trailing newline */
-	if (text_len && text[text_len-1] == '\n') {
-		text_len--;
-		lflags |= LOG_NEWLINE;
-	}
-
-	/* strip kernel syslog prefix and extract log level or control flags */
-	if (facility == 0) {
-		int kern_level;
+	va_copy(args2, args);
+	reserve_size = vsnprintf(&prefix_buf[0], sizeof(prefix_buf), fmt, args2) + 1;
+	va_end(args2);
 
-		while ((kern_level = printk_get_level(text)) != 0) {
-			switch (kern_level) {
-			case '0' ... '7':
-				if (level == LOGLEVEL_DEFAULT)
-					level = kern_level - '0';
-				break;
-			case 'c':	/* KERN_CONT */
-				lflags |= LOG_CONT;
-			}
+	if (reserve_size > LOG_LINE_MAX)
+		reserve_size = LOG_LINE_MAX;
 
-			text_len -= 2;
-			text += 2;
-		}
-	}
+	/* Extract log level or control flags. */
+	if (facility == 0)
+		parse_prefix(&prefix_buf[0], &level, &lflags);
 
 	if (level == LOGLEVEL_DEFAULT)
 		level = default_message_loglevel;
@@ -1922,9 +1980,10 @@ int vprintk_store(int facility, int level,
 		lflags |= LOG_NEWLINE;
 
 	if (lflags & LOG_CONT) {
-		prb_rec_init_wr(&r, text_len);
+		prb_rec_init_wr(&r, reserve_size);
 		if (prb_reserve_in_last(&e, prb, &r, caller_id, LOG_LINE_MAX)) {
-			memcpy(&r.text_buf[r.info->text_len], text, text_len);
+			text_len = printk_sprint(&r.text_buf[r.info->text_len], reserve_size,
+						 facility, &lflags, fmt, args);
 			r.info->text_len += text_len;
 
 			if (lflags & LOG_NEWLINE) {
@@ -1943,18 +2002,18 @@ int vprintk_store(int facility, int level,
 	 * prb_reserve_in_last() and prb_reserve() purposely invalidate the
 	 * structure when they fail.
 	 */
-	prb_rec_init_wr(&r, text_len);
+	prb_rec_init_wr(&r, reserve_size);
 	if (!prb_reserve(&e, prb, &r)) {
 		/* truncate the message if it is too long for empty buffer */
-		truncate_msg(&text_len, &trunc_msg_len);
+		truncate_msg(&reserve_size, &trunc_msg_len);
 
-		prb_rec_init_wr(&r, text_len + trunc_msg_len);
+		prb_rec_init_wr(&r, reserve_size + trunc_msg_len);
 		if (!prb_reserve(&e, prb, &r))
 			return 0;
 	}
 
 	/* fill message */
-	memcpy(&r.text_buf[0], text, text_len);
+	text_len = printk_sprint(&r.text_buf[0], reserve_size, facility, &lflags, fmt, args);
 	if (trunc_msg_len)
 		memcpy(&r.text_buf[text_len], trunc_msg, trunc_msg_len);
 	r.info->text_len = text_len + trunc_msg_len;
@@ -1995,10 +2054,9 @@ asmlinkage int vprintk_emit(int facility, int level,
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
-- 
2.20.1

