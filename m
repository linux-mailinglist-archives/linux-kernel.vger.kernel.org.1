Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B69C42BA5E5
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 10:22:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727755AbgKTJU0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 04:20:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:40018 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727527AbgKTJUV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 04:20:21 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 180B12224C;
        Fri, 20 Nov 2020 09:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605864020;
        bh=8RZpdc9rhvQ7VBlC0MqUV7y9Pd6IAW8XU8MT5TxsxtI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Ds2ReALj76fYX0N9YcUBzIBPwBsr9Uf3CQFvm7iLhEfc3P/Qg7QVtvY91ba3t/d1y
         sqW3JKMsjWtLDodt27D7BapHVvxNXMELvJEXT+nMethmXcDSrXyBb919mEQ7EVop2M
         vad/tsLIWr/BRVuzZjTAF7hRK6ct1YOD5cXiMYpA=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1kg2aX-00CCq5-M9; Fri, 20 Nov 2020 09:20:17 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 20 Nov 2020 09:20:17 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LAK <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Valentin Schneider <Valentin.Schneider@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Android Kernel Team <kernel-team@android.com>,
        mark.rutland@arm.com
Subject: Re: [PATCH 0/2] arm64: Allow the rescheduling IPI to bypass
 irq_enter/exit
In-Reply-To: <87ft5q18qs.fsf@nanos.tec.linutronix.de>
References: <20201101131430.257038-1-maz@kernel.org>
 <87ft5q18qs.fsf@nanos.tec.linutronix.de>
User-Agent: Roundcube Webmail/1.4.9
Message-ID: <91cde5eeb22eb2926515dd27113c664a@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: tglx@linutronix.de, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, will@kernel.org, catalin.marinas@arm.com, Valentin.Schneider@arm.com, peterz@infradead.org, kernel-team@android.com, mark.rutland@arm.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[+ Mark who has been hacking in the same area lately]

Hi Thomas,

On 2020-11-03 20:32, Thomas Gleixner wrote:
> On Sun, Nov 01 2020 at 13:14, Marc Zyngier wrote:
>> Vincent recently reported [1] that 5.10-rc1 showed a significant
>> regression when running "perf bench sched pipe" on arm64, and
>> pinpointed it to the recent move to handling IPIs as normal
>> interrupts.
>> 
>> The culprit is the use of irq_enter/irq_exit around the handling of
>> the rescheduling IPI, meaning that we enter the scheduler right after
>> the handling of the IPI instead of deferring it to the next preemption
>> event. This accounts for most of the overhead introduced.
> 
> irq_enter()/exit() does not end up in the scheduler. If it does then
> please show the call chain.
> 
> Scheduling happens when the IPI returns just before returning into the
> low level code (or on ARM in the low level code) when NEED_RESCHED is
> set (which is usually the case when the IPI is sent) and:
> 
>   the IPI hit user space
> 
> or
> 
>   the IPI hit in preemptible kernel context and CONFIG_PREEMPT[_RT] is
>   enabled.
> 
> Not doing so would be a bug. So I really don't understand your 
> reasoning
> here.

You are of course right. I somehow associated the overhead of the 
resched
IPI with the scheduler itself. I stand corrected.

> 
>> On architectures that have architected IPIs at the CPU level (x86
>> being the obvious one), the absence of irq_enter/exit is natural.
> 
> It's not really architected IPIs. We reserve the top 20ish vectors on
> each CPU for IPIs and other per processor interrupts, e.g. the per cpu
> timer.
> 
> Now lets look at what x86 does:
> 
> Interrupts and regular IPIs (function call ....) do
> 
>     irqentry_enter()   <- handles rcu_irq_enter() or context tracking
>       ...
>       irq_enter_rcu()
>       ...
>       irq_exit_rcu()
>     irqentry_exit()     <- handles need_resched()
> 
> The scheduler IPI does:
> 
>     irqentry_enter()   <- handles rcu_irq_enter() or context tracking
>       ...
>       __irq_enter_raw()
>       ...
>       __irq_exit_raw()
>     irqentry_exit()     <- handles need_resched()
> 
> So we don't invoke irq_enter_rcu() on enter and on exit we skip
> irq_exit_rcu(). That's fine because
> 
>   - Calling the tick management is pointless because this is going to
>     schedule anyway or something consumed the need_resched already.
> 
>   - The irqtime accounting is silly because it covers only the call and
>     returns. The time spent in the accounting is more than the time
>     we are accounting (empty call).
> 
> So what your hack fails to invoke is rcu_irq_enter()/exit() in case 
> that
> the IPI hits the idle task in an RCU off region. You also fail to tell
> lockdep. No cookies!

Who needs cookies when you can have cheese? ;-)

More seriously, it seems to me that we have a bit of a 
cross-architecture
disconnect here. I have been trying to join the dots between what you
describe above, and the behaviour of arm64 (and probably a large number
of the non-x86 architectures), and I feel massively confused.

Up to 5.9, our handling of the rescheduling IPI was "do as little as
possible": decode the interrupt from the lowest possible level (the
root irqchip), call into arch code, end-up in scheduler_ipi(), the end.

No lockdep, no RCU, no nothing.

What changed? Have we missed some radical change in the way the core
kernel expects the arch code to do thing? I'm aware of the 
kernel/entry/common.c stuff, which implements most of the goodies you
mention, but this effectively is x86-only at the moment.

If arm64 has forever been broken, I'd really like to know and fix it.

>> The bad news is that these patches are ugly as sin, and I really don't
>> like them.
> 
> Yes, they are ugly and the extra conditional in the irq handling path 
> is
> not pretty either.
> 
>> I specially hate that they can give driver authors the idea that they
>> can make random interrupts "faster".
> 
> Just split the guts of irq_modify_status() into __irq_modify_status()
> and call that from irq_modify_status().
> 
> Reject IRQ_HIDDEN (which should have been IRQ_IPI really) and IRQ_NAKED
> (IRQ_RAW perhaps) in irq_modify_status().
> 
> Do not export __irq_modify_status() so it can be only used from 
> built-in
> code which takes it away from driver writers.

Yup, done.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
