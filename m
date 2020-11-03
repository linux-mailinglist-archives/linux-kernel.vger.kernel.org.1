Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA6DD2A50E8
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 21:33:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729213AbgKCUdB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 15:33:01 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:44502 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726709AbgKCUdB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 15:33:01 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1604435579;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cVcGz5CDVRdovfRvxcP/ga3ZgQwWWcWu3Qsc8ARs+ao=;
        b=ROO1JE5OXeDbqvxdPGuziCgBNgOnWHUTS7KIIfahi9fpoHeMOF14yQOucSNW6ADAMNToM+
        GpsE7PVsmeGz5xpDyArAT5O0YXwe6lb6gTV0QOrP1LngAucsdZbwEXAOEKcpP5BIEgZ1E3
        jL4hixdCRI4hl5MT3GJIbc9xh/EcYYmGoMw0GqVAMwlzSWVxshVuse8XqSUih3LaS64BfJ
        jhgBNUjZ3v4sIRi4FFdIJlyJumZtPTFOM7IXCx/dQrBvqfepi3N+ldhDXu+2hrEAEAH8Ee
        IGIXKnN1b3uF1R/sDhqB0XV6yP5laCiTzu91T7JStqzGAAe7taRdLxYcT2H/kA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1604435579;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cVcGz5CDVRdovfRvxcP/ga3ZgQwWWcWu3Qsc8ARs+ao=;
        b=gRj8fYaR/h7W5n6W33KK2dB8XvkY0jQhkZT8ZrMGJUKVewgoyRkJ1Kx6bhYFbuPezB6+N0
        cLBQ7CWBDgczIaDA==
To:     Marc Zyngier <maz@kernel.org>,
        LAK <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Valentin Schneider <Valentin.Schneider@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Android Kernel Team <kernel-team@android.com>
Subject: Re: [PATCH 0/2] arm64: Allow the rescheduling IPI to bypass irq_enter/exit
In-Reply-To: <20201101131430.257038-1-maz@kernel.org>
References: <20201101131430.257038-1-maz@kernel.org>
Date:   Tue, 03 Nov 2020 21:32:59 +0100
Message-ID: <87ft5q18qs.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 01 2020 at 13:14, Marc Zyngier wrote:
> Vincent recently reported [1] that 5.10-rc1 showed a significant
> regression when running "perf bench sched pipe" on arm64, and
> pinpointed it to the recent move to handling IPIs as normal
> interrupts.
>
> The culprit is the use of irq_enter/irq_exit around the handling of
> the rescheduling IPI, meaning that we enter the scheduler right after
> the handling of the IPI instead of deferring it to the next preemption
> event. This accounts for most of the overhead introduced.

irq_enter()/exit() does not end up in the scheduler. If it does then
please show the call chain.

Scheduling happens when the IPI returns just before returning into the
low level code (or on ARM in the low level code) when NEED_RESCHED is
set (which is usually the case when the IPI is sent) and:

  the IPI hit user space

or

  the IPI hit in preemptible kernel context and CONFIG_PREEMPT[_RT] is
  enabled.

Not doing so would be a bug. So I really don't understand your reasoning
here.

> On architectures that have architected IPIs at the CPU level (x86
> being the obvious one), the absence of irq_enter/exit is natural.

It's not really architected IPIs. We reserve the top 20ish vectors on
each CPU for IPIs and other per processor interrupts, e.g. the per cpu
timer.

Now lets look at what x86 does:

Interrupts and regular IPIs (function call ....) do

    irqentry_enter()   <- handles rcu_irq_enter() or context tracking
      ...
      irq_enter_rcu()
      ...
      irq_exit_rcu()
    irqentry_exit()     <- handles need_resched()

The scheduler IPI does:

    irqentry_enter()   <- handles rcu_irq_enter() or context tracking
      ...
      __irq_enter_raw()
      ...
      __irq_exit_raw()
    irqentry_exit()     <- handles need_resched()

So we don't invoke irq_enter_rcu() on enter and on exit we skip
irq_exit_rcu(). That's fine because

  - Calling the tick management is pointless because this is going to
    schedule anyway or something consumed the need_resched already.

  - The irqtime accounting is silly because it covers only the call and
    returns. The time spent in the accounting is more than the time
    we are accounting (empty call).

So what your hack fails to invoke is rcu_irq_enter()/exit() in case that
the IPI hits the idle task in an RCU off region. You also fail to tell
lockdep. No cookies!

> The bad news is that these patches are ugly as sin, and I really don't
> like them.

Yes, they are ugly and the extra conditional in the irq handling path is
not pretty either.

> I specially hate that they can give driver authors the idea that they
> can make random interrupts "faster".

Just split the guts of irq_modify_status() into __irq_modify_status()
and call that from irq_modify_status().

Reject IRQ_HIDDEN (which should have been IRQ_IPI really) and IRQ_NAKED
(IRQ_RAW perhaps) in irq_modify_status().

Do not export __irq_modify_status() so it can be only used from built-in
code which takes it away from driver writers.

We probably should add a few of the other IRQ_ bits to the reject mask
for completness sake, but that's not urgent.

Thanks,

        tglx

