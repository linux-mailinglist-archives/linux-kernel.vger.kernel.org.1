Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A5EA274574
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 17:38:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbgIVPi2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 11:38:28 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:59338 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726767AbgIVPiW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 11:38:22 -0400
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1600789099;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4IrRVxS7QOAQdmw03gbB463FwkTjROcrzN0zB1lGxvg=;
        b=yBgp7n8WI6p+eeXtlzwrrRSZ1Oqh8NS4Nsejzo0Hk5fE8O/q65D94dGTx0yFxLKfiongkE
        QF6MZIQrZVBdeIjMUOclsDcfRDuQEyd9dpQPTRwYxxmNUshacSKmAS/k8qeZWfsr4cphqp
        SvH2sopTiWoj2Az45TzUmDdsIJTeslH2QV8b9IzaL1QqbJNWnnX6F0OgD1bALvIUWnK4PA
        OoOgjmJyeD773hJkGVwOIMw7IuEhnmSK7OpF+d6nwPW2kpk9w3u0mJslRf1BRfKIVRA5kq
        AP1Y+jNMfS5xpiJuzqOKmPOXL00lQv0OAD2ccrjIfPGXl5JiUNbty/KW0BDtpQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1600789099;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4IrRVxS7QOAQdmw03gbB463FwkTjROcrzN0zB1lGxvg=;
        b=yehgaM6Go4TlqIuXohYtal2Vvh+3lCBvjqTRyXvfmt8HIOm3z19TQ69qNfTkBRHt/LTAxs
        uVx1vQKUHgWPBPCg==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH printk 5/5] printk: remove nmi safe buffers
Date:   Tue, 22 Sep 2020 17:44:16 +0206
Message-Id: <20200922153816.5883-6-john.ogness@linutronix.de>
In-Reply-To: <20200922153816.5883-1-john.ogness@linutronix.de>
References: <20200922153816.5883-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the ringbuffer is now lockless, new records can be inserted
directly from NMI context. There is no need for the NMI safe
buffers. Handle all NMI printk() calls using defer_console_output()
to avoid calling console drivers that might have their own locks.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 kernel/printk/printk_safe.c | 47 ++++---------------------------------
 1 file changed, 4 insertions(+), 43 deletions(-)

diff --git a/kernel/printk/printk_safe.c b/kernel/printk/printk_safe.c
index 7c186cefdb50..720935d19a3e 100644
--- a/kernel/printk/printk_safe.c
+++ b/kernel/printk/printk_safe.c
@@ -44,10 +44,6 @@ struct printk_safe_seq_buf {
 static DEFINE_PER_CPU(struct printk_safe_seq_buf, safe_print_seq);
 static DEFINE_PER_CPU(int, printk_context);
 
-#ifdef CONFIG_PRINTK_NMI
-static DEFINE_PER_CPU(struct printk_safe_seq_buf, nmi_print_seq);
-#endif
-
 /* Get flushed in a more safe context. */
 static void queue_flush_work(struct printk_safe_seq_buf *s)
 {
@@ -245,12 +241,8 @@ void printk_safe_flush(void)
 {
 	int cpu;
 
-	for_each_possible_cpu(cpu) {
-#ifdef CONFIG_PRINTK_NMI
-		__printk_safe_flush(&per_cpu(nmi_print_seq, cpu).work);
-#endif
+	for_each_possible_cpu(cpu)
 		__printk_safe_flush(&per_cpu(safe_print_seq, cpu).work);
-	}
 }
 
 /**
@@ -268,20 +260,6 @@ void printk_safe_flush_on_panic(void)
 	printk_safe_flush();
 }
 
-#ifdef CONFIG_PRINTK_NMI
-/*
- * Safe printk() for NMI context. It uses a per-CPU buffer to
- * store the message. NMIs are not nested, so there is always only
- * one writer running. But the buffer might get flushed from another
- * CPU, so we need to be careful.
- */
-static __printf(1, 0) int vprintk_nmi(const char *fmt, va_list args)
-{
-	struct printk_safe_seq_buf *s = this_cpu_ptr(&nmi_print_seq);
-
-	return printk_safe_log_store(s, fmt, args);
-}
-
 void noinstr printk_nmi_enter(void)
 {
 	this_cpu_add(printk_context, PRINTK_NMI_CONTEXT_OFFSET);
@@ -313,15 +291,6 @@ void printk_nmi_direct_exit(void)
 	this_cpu_and(printk_context, ~PRINTK_NMI_DIRECT_CONTEXT_MASK);
 }
 
-#else
-
-static __printf(1, 0) int vprintk_nmi(const char *fmt, va_list args)
-{
-	return 0;
-}
-
-#endif /* CONFIG_PRINTK_NMI */
-
 /*
  * Lock-less printk(), to avoid deadlocks should the printk() recurse
  * into itself. It uses a per-CPU buffer to store the message, just like
@@ -355,10 +324,11 @@ __printf(1, 0) int vprintk_func(const char *fmt, va_list args)
 #endif
 
 	/*
-	 * Try to use the main logbuf even in NMI. But avoid calling console
+	 * Use the main ringbuffer in NMI. But avoid calling console
 	 * drivers that might have their own locks.
 	 */
-	if ((this_cpu_read(printk_context) & PRINTK_NMI_DIRECT_CONTEXT_MASK)) {
+	if ((this_cpu_read(printk_context) &
+	     (PRINTK_NMI_CONTEXT_MASK | PRINTK_NMI_DIRECT_CONTEXT_MASK))) {
 		int len;
 
 		len = vprintk_store(0, LOGLEVEL_DEFAULT, NULL, fmt, args);
@@ -366,10 +336,6 @@ __printf(1, 0) int vprintk_func(const char *fmt, va_list args)
 		return len;
 	}
 
-	/* Use extra buffer in NMI. */
-	if (this_cpu_read(printk_context) & PRINTK_NMI_CONTEXT_MASK)
-		return vprintk_nmi(fmt, args);
-
 	/* Use extra buffer to prevent a recursion deadlock in safe mode. */
 	if (this_cpu_read(printk_context) & PRINTK_SAFE_CONTEXT_MASK)
 		return vprintk_safe(fmt, args);
@@ -387,11 +353,6 @@ void __init printk_safe_init(void)
 
 		s = &per_cpu(safe_print_seq, cpu);
 		init_irq_work(&s->work, __printk_safe_flush);
-
-#ifdef CONFIG_PRINTK_NMI
-		s = &per_cpu(nmi_print_seq, cpu);
-		init_irq_work(&s->work, __printk_safe_flush);
-#endif
 	}
 
 	/* Flush pending messages that did not have scheduled IRQ works. */
-- 
2.20.1

