Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEB192CA3F0
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 14:36:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391122AbgLANfb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 08:35:31 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:55556 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387723AbgLANfb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 08:35:31 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1606829690;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Qd+SEc9hp97PwahsT1I+aQoYgPiQshE5SVUuDff6QAY=;
        b=4K4egpat7x6FFRLS3MxurqgpG7jrMD/HV3t3+/NFf0k0hkmt2TfeNHE4TbAModNTHgB4dm
        8Fc05SAKaCvhjfh0aY1q/fitC6rUPSSJwC9BIrhjs5W6PKgNggRxY5X6Z5v0vXg/SSClJ5
        jj18CaL9+P7+FLidyYuRUAcQLKpDAM3toklVggv2oP5SiEH6pFz1PuRgt+JqdR5Rt4NH8l
        vxpl+PXfPEOWvcgdMdd+YXUeAbd3BWaJsHLFqr52Ltgv4xerkYkgyaGbn/UxWVgcydz3Tq
        vJjzCRHROCiudbDHScGYdAJKVKAQ+R7gWkPV89Fxn8HlUuTSonHv92i/40OTFA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1606829690;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Qd+SEc9hp97PwahsT1I+aQoYgPiQshE5SVUuDff6QAY=;
        b=oidPvyDTpGCvjtth3sCNchXifzxG8IFZQj9dEvwZSNOYf7Ihil4Idl0a6QD91kIESK8o3/
        GKVrBAzKppAzuSBQ==
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Heiko Carstens <hca@linux.ibm.com>
Subject: Re: [PATCH 4/5] irqtime: Move irqtime entry accounting after irq offset incrementation
In-Reply-To: <20201201114026.GB72897@lothringen>
References: <20201201001226.65107-1-frederic@kernel.org> <20201201001226.65107-5-frederic@kernel.org> <20201201092011.GS2414@hirez.programming.kicks-ass.net> <87im9lhibd.fsf@nanos.tec.linutronix.de> <20201201114026.GB72897@lothringen>
Date:   Tue, 01 Dec 2020 14:34:49 +0100
Message-ID: <87blfdhcp2.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 01 2020 at 12:40, Frederic Weisbecker wrote:
> On Tue, Dec 01, 2020 at 12:33:26PM +0100, Thomas Gleixner wrote:
>> > 	/*
>> > 	 * We do not account for softirq time from ksoftirqd here.
>> > 	 * We want to continue accounting softirq time to ksoftirqd thread
>> > 	 * in that case, so as not to confuse scheduler with a special task
>> > 	 * that do not consume any time, but still wants to run.
>> > 	 */
>> > 	if (pc & HARDIRQ_MASK)
>> > 		irqtime_account_delta(irqtime, delta, CPUTIME_IRQ);
>> > 	else if ((pc & SOFTIRQ_OFFSET) && curr != this_cpu_ksoftirqd())
>> > 		irqtime_account_delta(irqtime, delta, CPUTIME_SOFTIRQ);
>> > }
>> 
>> Why not making all of this explicit instead of these conditionals?
>
> Hmm, I'm not sure I get what you suggest?

Instead of playing games with preeempt count and offsets and checking
for ksoftirqd, can't you just have:

        account_hardirqtime()
        account_softirqtime()

and call them from the right spots. See the below for illustration (it's
obviously incomplete).

Thanks,

        tglx
---
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -377,6 +377,7 @@ static inline void invoke_softirq(void)
 		return;
 
 	if (!force_irqthreads) {
+		account_softirq_enter_time(current);
 #ifdef CONFIG_HAVE_IRQ_EXIT_ON_IRQ_STACK
 		/*
 		 * We can safely execute softirq on the current stack if
@@ -391,6 +392,7 @@ static inline void invoke_softirq(void)
 		 * to prevent from any overrun.
 		 */
 		do_softirq_own_stack();
+		account_softirq_exit_time(current);
 #endif
 	} else {
 		wakeup_softirqd();
@@ -417,7 +419,7 @@ static inline void __irq_exit_rcu(void)
 #else
 	lockdep_assert_irqs_disabled();
 #endif
-	account_irq_exit_time(current);
+	account_hardirq_exit_time(current);
 	preempt_count_sub(HARDIRQ_OFFSET);
 	if (!in_interrupt() && local_softirq_pending())
 		invoke_softirq();
