Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 295EF2D1D39
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 23:23:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728077AbgLGWVM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 17:21:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727942AbgLGWVE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 17:21:04 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5F3EC061793
        for <linux-kernel@vger.kernel.org>; Mon,  7 Dec 2020 14:20:23 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607379621;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4cjdwuUZXyhbLW+Gtg3A2qyd0nc89zig5cOMQo+9MUI=;
        b=T+dAI4LyCSQKZuxOlr4hRv+9Y3ICW4IT8m14esL2SKlk7yWVExy2szbiRvyH4kFI4doxx8
        ivcz48Og0Ur6Ba9DEmL+cpe/8CVj1iBSD9XVUXMaK7a2XsHyfinAyxiJfNGdLnw14vtta0
        3b11dojRmP+87yXLpMEMY31Lm3G5igolMAru++Fyd0Qbt1r+4GxfXyoFRoYoOYcSPSCtJL
        puEXnLtSg0J0nKkWwOPWsa1JvcD03CUlOgasyUAsEdLoPZ2oq+Jga/3zNnWvfFUQ0oJ0w0
        6YspbsQ/ew8ReK1YRdxEMqwuta72d6Z1NZ1w3QzB/0YOzgwWxeZLexCfZE8gFQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607379621;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4cjdwuUZXyhbLW+Gtg3A2qyd0nc89zig5cOMQo+9MUI=;
        b=BiEA4333PhdroYg67T4XF4eQ1XuyVDG6rU1KtRmikLaTBhNXLil94cbFrDPLjdsL5sBHbg
        GT82NN/6feHGJjAA==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH next v3 1/3] printk: inline log_output(),log_store() in vprintk_store()
Date:   Mon,  7 Dec 2020 23:26:18 +0106
Message-Id: <20201207222020.2923-2-john.ogness@linutronix.de>
In-Reply-To: <20201207222020.2923-1-john.ogness@linutronix.de>
References: <20201207222020.2923-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for removing logbuf_lock, inline log_output()
and log_store() into vprintk_store(). This will simplify dealing
with the various code branches and fallbacks that are possible.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
Reviewed-by: Petr Mladek <pmladek@suse.com>
Reviewed-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
---
 kernel/printk/printk.c | 145 +++++++++++++++++++----------------------
 1 file changed, 67 insertions(+), 78 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index f279d4fbd9dd..bf5fd2be3a05 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -491,52 +491,6 @@ static void truncate_msg(u16 *text_len, u16 *trunc_msg_len)
 		*trunc_msg_len = 0;
 }
 
-/* insert record into the buffer, discard old ones, update heads */
-static int log_store(u32 caller_id, int facility, int level,
-		     enum log_flags flags, u64 ts_nsec,
-		     const struct dev_printk_info *dev_info,
-		     const char *text, u16 text_len)
-{
-	struct prb_reserved_entry e;
-	struct printk_record r;
-	u16 trunc_msg_len = 0;
-
-	prb_rec_init_wr(&r, text_len);
-
-	if (!prb_reserve(&e, prb, &r)) {
-		/* truncate the message if it is too long for empty buffer */
-		truncate_msg(&text_len, &trunc_msg_len);
-		prb_rec_init_wr(&r, text_len + trunc_msg_len);
-		/* survive when the log buffer is too small for trunc_msg */
-		if (!prb_reserve(&e, prb, &r))
-			return 0;
-	}
-
-	/* fill message */
-	memcpy(&r.text_buf[0], text, text_len);
-	if (trunc_msg_len)
-		memcpy(&r.text_buf[text_len], trunc_msg, trunc_msg_len);
-	r.info->text_len = text_len + trunc_msg_len;
-	r.info->facility = facility;
-	r.info->level = level & 7;
-	r.info->flags = flags & 0x1f;
-	if (ts_nsec > 0)
-		r.info->ts_nsec = ts_nsec;
-	else
-		r.info->ts_nsec = local_clock();
-	r.info->caller_id = caller_id;
-	if (dev_info)
-		memcpy(&r.info->dev_info, dev_info, sizeof(r.info->dev_info));
-
-	/* A message without a trailing newline can be continued. */
-	if (!(flags & LOG_NEWLINE))
-		prb_commit(&e);
-	else
-		prb_final_commit(&e);
-
-	return (text_len + trunc_msg_len);
-}
-
 int dmesg_restrict = IS_ENABLED(CONFIG_SECURITY_DMESG_RESTRICT);
 
 static int syslog_action_restricted(int type)
@@ -1907,44 +1861,28 @@ static inline u32 printk_caller_id(void)
 		0x80000000 + raw_smp_processor_id();
 }
 
-static size_t log_output(int facility, int level, enum log_flags lflags,
-			 const struct dev_printk_info *dev_info,
-			 char *text, size_t text_len)
-{
-	const u32 caller_id = printk_caller_id();
-
-	if (lflags & LOG_CONT) {
-		struct prb_reserved_entry e;
-		struct printk_record r;
-
-		prb_rec_init_wr(&r, text_len);
-		if (prb_reserve_in_last(&e, prb, &r, caller_id, LOG_LINE_MAX)) {
-			memcpy(&r.text_buf[r.info->text_len], text, text_len);
-			r.info->text_len += text_len;
-			if (lflags & LOG_NEWLINE) {
-				r.info->flags |= LOG_NEWLINE;
-				prb_final_commit(&e);
-			} else {
-				prb_commit(&e);
-			}
-			return text_len;
-		}
-	}
-
-	/* Store it in the record log */
-	return log_store(caller_id, facility, level, lflags, 0,
-			 dev_info, text, text_len);
-}
-
 /* Must be called under logbuf_lock. */
 int vprintk_store(int facility, int level,
 		  const struct dev_printk_info *dev_info,
 		  const char *fmt, va_list args)
 {
+	const u32 caller_id = printk_caller_id();
 	static char textbuf[LOG_LINE_MAX];
-	char *text = textbuf;
-	size_t text_len;
+	struct prb_reserved_entry e;
 	enum log_flags lflags = 0;
+	struct printk_record r;
+	u16 trunc_msg_len = 0;
+	char *text = textbuf;
+	u16 text_len;
+	u64 ts_nsec;
+
+	/*
+	 * Since the duration of printk() can vary depending on the message
+	 * and state of the ringbuffer, grab the timestamp now so that it is
+	 * close to the call of printk(). This provides a more deterministic
+	 * timestamp with respect to the caller.
+	 */
+	ts_nsec = local_clock();
 
 	/*
 	 * The printf needs to come first; we need the syslog
@@ -1983,7 +1921,58 @@ int vprintk_store(int facility, int level,
 	if (dev_info)
 		lflags |= LOG_NEWLINE;
 
-	return log_output(facility, level, lflags, dev_info, text, text_len);
+	if (lflags & LOG_CONT) {
+		prb_rec_init_wr(&r, text_len);
+		if (prb_reserve_in_last(&e, prb, &r, caller_id, LOG_LINE_MAX)) {
+			memcpy(&r.text_buf[r.info->text_len], text, text_len);
+			r.info->text_len += text_len;
+
+			if (lflags & LOG_NEWLINE) {
+				r.info->flags |= LOG_NEWLINE;
+				prb_final_commit(&e);
+			} else {
+				prb_commit(&e);
+			}
+
+			return text_len;
+		}
+	}
+
+	/*
+	 * Explicitly initialize the record before every prb_reserve() call.
+	 * prb_reserve_in_last() and prb_reserve() purposely invalidate the
+	 * structure when they fail.
+	 */
+	prb_rec_init_wr(&r, text_len);
+	if (!prb_reserve(&e, prb, &r)) {
+		/* truncate the message if it is too long for empty buffer */
+		truncate_msg(&text_len, &trunc_msg_len);
+
+		prb_rec_init_wr(&r, text_len + trunc_msg_len);
+		if (!prb_reserve(&e, prb, &r))
+			return 0;
+	}
+
+	/* fill message */
+	memcpy(&r.text_buf[0], text, text_len);
+	if (trunc_msg_len)
+		memcpy(&r.text_buf[text_len], trunc_msg, trunc_msg_len);
+	r.info->text_len = text_len + trunc_msg_len;
+	r.info->facility = facility;
+	r.info->level = level & 7;
+	r.info->flags = lflags & 0x1f;
+	r.info->ts_nsec = ts_nsec;
+	r.info->caller_id = caller_id;
+	if (dev_info)
+		memcpy(&r.info->dev_info, dev_info, sizeof(r.info->dev_info));
+
+	/* A message without a trailing newline can be continued. */
+	if (!(lflags & LOG_NEWLINE))
+		prb_commit(&e);
+	else
+		prb_final_commit(&e);
+
+	return (text_len + trunc_msg_len);
 }
 
 asmlinkage int vprintk_emit(int facility, int level,
-- 
2.20.1

