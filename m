Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 529422B1D3F
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 15:25:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726915AbgKMOZD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 09:25:03 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:52544 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726876AbgKMOYb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 09:24:31 -0500
Message-Id: <20201113141734.207605126@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605277470;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=hOeV4Uk7rTRj8OzrhfpKRZ7P0pi7lfMrsyiB2KyVEto=;
        b=URSw8F8qCzxPeiiiqFqLJq9vgbvQvNB5bDnNWfPE+JIpuybZnnqa6IY2ofJgdJEzeECG1k
        nhxbzeTOcEEvoxg1p1gpTnBtwmuhcli6AM1SNnRvxqaWxfgHNpCparobE9ZTa6h2KAAa+v
        MBrwhlBSGWEvD5ZpHidwQC8lXS2eus6R0/70ep00jQRw4a9jRrgh1//4WmUXUh58ZUnCFL
        xPUZYjZdaJI+U0Hp3OvS3r/2BITHOzsrQgk94F3mhIhmRjdcJz/nKaMQBzJN4VqrZeDiF+
        dQnYFmwrcpE8ZJZTEriBYAiF9Sk4DG/6XxukcDyuOXKxIX9aB5EE6QSD48kitQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605277470;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=hOeV4Uk7rTRj8OzrhfpKRZ7P0pi7lfMrsyiB2KyVEto=;
        b=Fz21tLWb3UVdRRr7AeS4qYH3y/k/kNtsttrdQl7tgpxPBCYlIGzhDVQ+drwgixYSrTaLVV
        n5yXU+FH5qMvt3Dw==
Date:   Fri, 13 Nov 2020 15:02:20 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Paul McKenney <paulmck@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        linux-um@lists.infradead.org, Russell King <linux@armlinux.org.uk>,
        Marc Zyngier <maz@kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Subject: [patch 13/19] softirq: Move various protections into inline helpers
References: <20201113140207.499353218@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To allow reuse of the bulk of softirq processing code for RT and to avoid
#ifdeffery all over the place, split protections for various code sections
out into inline helpers so the RT variant can just replace them in one go.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/softirq.c |   53 ++++++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 44 insertions(+), 9 deletions(-)

--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -204,6 +204,42 @@ void __local_bh_enable_ip(unsigned long
 }
 EXPORT_SYMBOL(__local_bh_enable_ip);
 
+static inline void local_bh_disable_irq_enter(void)
+{
+	local_bh_disable();
+}
+
+static inline void local_bh_enable_irq_enter(void)
+{
+	_local_bh_enable();
+}
+
+static inline void softirq_handle_begin(void)
+{
+	__local_bh_disable_ip(_RET_IP_, SOFTIRQ_OFFSET);
+}
+
+static inline void softirq_handle_end(void)
+{
+	__local_bh_enable(SOFTIRQ_OFFSET);
+	WARN_ON_ONCE(in_interrupt());
+}
+
+static inline void ksoftirqd_run_begin(void)
+{
+	local_irq_disable();
+}
+
+static inline void ksoftirqd_run_end(void)
+{
+	local_irq_enable();
+}
+
+static inline bool should_wake_ksoftirqd(void)
+{
+	return true;
+}
+
 static inline void invoke_softirq(void)
 {
 	if (ksoftirqd_running(local_softirq_pending()))
@@ -317,7 +353,7 @@ asmlinkage __visible void __softirq_entr
 	pending = local_softirq_pending();
 	account_irq_enter_time(current);
 
-	__local_bh_disable_ip(_RET_IP_, SOFTIRQ_OFFSET);
+	softirq_handle_begin();
 	in_hardirq = lockdep_softirq_start();
 
 restart:
@@ -367,8 +403,7 @@ asmlinkage __visible void __softirq_entr
 
 	lockdep_softirq_end(in_hardirq);
 	account_irq_exit_time(current);
-	__local_bh_enable(SOFTIRQ_OFFSET);
-	WARN_ON_ONCE(in_interrupt());
+	softirq_handle_end();
 	current_restore_flags(old_flags, PF_MEMALLOC);
 }
 
@@ -382,9 +417,9 @@ void irq_enter_rcu(void)
 		 * Prevent raise_softirq from needlessly waking up ksoftirqd
 		 * here, as softirq will be serviced on return from interrupt.
 		 */
-		local_bh_disable();
+		local_bh_disable_irq_enter();
 		tick_irq_enter();
-		_local_bh_enable();
+		local_bh_enable_irq_enter();
 	}
 	__irq_enter();
 }
@@ -467,7 +502,7 @@ inline void raise_softirq_irqoff(unsigne
 	 * Otherwise we wake up ksoftirqd to make sure we
 	 * schedule the softirq soon.
 	 */
-	if (!in_interrupt())
+	if (!in_interrupt() && should_wake_ksoftirqd())
 		wakeup_softirqd();
 }
 
@@ -645,18 +680,18 @@ static int ksoftirqd_should_run(unsigned
 
 static void run_ksoftirqd(unsigned int cpu)
 {
-	local_irq_disable();
+	ksoftirqd_run_begin();
 	if (local_softirq_pending()) {
 		/*
 		 * We can safely run softirq on inline stack, as we are not deep
 		 * in the task stack here.
 		 */
 		__do_softirq();
-		local_irq_enable();
+		ksoftirqd_run_end();
 		cond_resched();
 		return;
 	}
-	local_irq_enable();
+	ksoftirqd_run_end();
 }
 
 #ifdef CONFIG_HOTPLUG_CPU

