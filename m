Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D5EB304FDA
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 04:32:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231639AbhA0Dbi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 22:31:38 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:51970 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728972AbhAZVQl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 16:16:41 -0500
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1611695755;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1VMLS99e7GLX54QIqDUriax8uAYki14LQK3ROVpMWzE=;
        b=ljL8X0G1ZPwvxOdtTVGloOYaRW53jC6rmZj2keRVs6WvMv+vr9soJtuXZEsOOzXvqPQlBX
        8Kzc27zxN7TtejwIP4ZZB4mHXWg7sVRrCX2btTYjgDreyCgrrAMdKKzPsVYGypd3JvnQ3H
        azJswOgHaqY3+BbBE06ISKFpvgBGKzmpZ3qgboeAKRSR5BtIN3NXicnYSsmdKbbnahPu6q
        t52il4U62MfFz9kVJ0FIAr7iQJFd6Nk4tyZH6jyX9Yu/QJfVk2UR0yCHcvUy+LLYaZJhjs
        QYWkLfRUaHa3gbsOVUohK9mB4CTk7UtH6ttiJSqbsbPOWqw0fhnNe1bHSSWWLg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1611695755;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1VMLS99e7GLX54QIqDUriax8uAYki14LQK3ROVpMWzE=;
        b=k5SQH+KvUmAQOCIU23Arx9ROLaka6zjAdyTxuyXuQxgxFJF6sz5/8eT0BubQPJIZaG7UCS
        e6vTB7Hx6fV8eQCA==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH printk-rework 07/12] printk: add syslog_lock
Date:   Tue, 26 Jan 2021 22:21:46 +0106
Message-Id: <20210126211551.26536-8-john.ogness@linutronix.de>
In-Reply-To: <20210126211551.26536-1-john.ogness@linutronix.de>
References: <20210126211551.26536-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The global variables @syslog_seq, @syslog_partial, @syslog_time
and write access to @clear_seq are protected by @logbuf_lock.
Once @logbuf_lock is removed, these variables will need their
own synchronization method. Introduce @syslog_lock for this
purpose.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 kernel/printk/printk.c | 34 ++++++++++++++++++++++++++++++----
 1 file changed, 30 insertions(+), 4 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index fe3df16315c0..506d334c065e 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -390,8 +390,12 @@ DEFINE_RAW_SPINLOCK(logbuf_lock);
 		printk_safe_exit_irqrestore(flags);	\
 	} while (0)
 
+/* syslog_lock protects syslog_* variables and write access to clear_seq. */
+static DEFINE_RAW_SPINLOCK(syslog_lock);
+
 #ifdef CONFIG_PRINTK
 DECLARE_WAIT_QUEUE_HEAD(log_wait);
+/* All 3 protected by @syslog_lock. */
 /* the next printk record to read by syslog(READ) or /proc/kmsg */
 static u64 syslog_seq;
 static size_t syslog_partial;
@@ -410,7 +414,7 @@ struct latched_seq {
 /*
  * The next printk record to read after the last 'clear' command. There are
  * two copies (updated with seqcount_latch) so that reads can locklessly
- * access a valid value. Writers are synchronized by @logbuf_lock.
+ * access a valid value. Writers are synchronized by @syslog_lock.
  */
 static struct latched_seq clear_seq = {
 	.latch		= SEQCNT_LATCH_ZERO(clear_seq.latch),
@@ -465,7 +469,7 @@ bool printk_percpu_data_ready(void)
 	return __printk_percpu_data_ready;
 }
 
-/* Must be called under logbuf_lock. */
+/* Must be called under syslog_lock. */
 static void latched_seq_write(struct latched_seq *ls, u64 val)
 {
 	raw_write_seqcount_latch(&ls->latch);
@@ -1515,7 +1519,9 @@ static int syslog_print(char __user *buf, int size)
 		size_t skip;
 
 		logbuf_lock_irq();
+		raw_spin_lock(&syslog_lock);
 		if (!prb_read_valid(prb, syslog_seq, &r)) {
+			raw_spin_unlock(&syslog_lock);
 			logbuf_unlock_irq();
 			break;
 		}
@@ -1545,6 +1551,7 @@ static int syslog_print(char __user *buf, int size)
 			syslog_partial += n;
 		} else
 			n = 0;
+		raw_spin_unlock(&syslog_lock);
 		logbuf_unlock_irq();
 
 		if (!n)
@@ -1611,8 +1618,11 @@ static int syslog_print_all(char __user *buf, int size, bool clear)
 			break;
 	}
 
-	if (clear)
+	if (clear) {
+		raw_spin_lock(&syslog_lock);
 		latched_seq_write(&clear_seq, seq);
+		raw_spin_unlock(&syslog_lock);
+	}
 	logbuf_unlock_irq();
 
 	kfree(text);
@@ -1622,7 +1632,9 @@ static int syslog_print_all(char __user *buf, int size, bool clear)
 static void syslog_clear(void)
 {
 	logbuf_lock_irq();
+	raw_spin_lock(&syslog_lock);
 	latched_seq_write(&clear_seq, prb_next_seq(prb));
+	raw_spin_unlock(&syslog_lock);
 	logbuf_unlock_irq();
 }
 
@@ -1631,6 +1643,7 @@ int do_syslog(int type, char __user *buf, int len, int source)
 	bool clear = false;
 	static int saved_console_loglevel = LOGLEVEL_DEFAULT;
 	int error;
+	u64 seq;
 
 	error = check_syslog_permissions(type, source);
 	if (error)
@@ -1648,8 +1661,14 @@ int do_syslog(int type, char __user *buf, int len, int source)
 			return 0;
 		if (!access_ok(buf, len))
 			return -EFAULT;
+
+		/* Get a consistent copy of @syslog_seq. */
+		raw_spin_lock_irq(&syslog_lock);
+		seq = syslog_seq;
+		raw_spin_unlock_irq(&syslog_lock);
+
 		error = wait_event_interruptible(log_wait,
-				prb_read_valid(prb, syslog_seq, NULL));
+				prb_read_valid(prb, seq, NULL));
 		if (error)
 			return error;
 		error = syslog_print(buf, len);
@@ -1698,6 +1717,7 @@ int do_syslog(int type, char __user *buf, int len, int source)
 	/* Number of chars in the log buffer */
 	case SYSLOG_ACTION_SIZE_UNREAD:
 		logbuf_lock_irq();
+		raw_spin_lock(&syslog_lock);
 		if (syslog_seq < prb_first_valid_seq(prb)) {
 			/* messages are gone, move to first one */
 			syslog_seq = prb_first_valid_seq(prb);
@@ -1724,6 +1744,7 @@ int do_syslog(int type, char __user *buf, int len, int source)
 			}
 			error -= syslog_partial;
 		}
+		raw_spin_unlock(&syslog_lock);
 		logbuf_unlock_irq();
 		break;
 	/* Size of the log buffer */
@@ -2965,7 +2986,12 @@ void register_console(struct console *newcon)
 		 */
 		exclusive_console = newcon;
 		exclusive_console_stop_seq = console_seq;
+
+		/* Get a consistent copy of @syslog_seq. */
+		raw_spin_lock(&syslog_lock);
 		console_seq = syslog_seq;
+		raw_spin_unlock(&syslog_lock);
+
 		logbuf_unlock_irqrestore(flags);
 	}
 	console_unlock();
-- 
2.20.1

