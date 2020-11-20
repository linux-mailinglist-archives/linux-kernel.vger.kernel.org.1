Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A8242BABB9
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 15:17:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727310AbgKTORP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 09:17:15 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:41062 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726172AbgKTORO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 09:17:14 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605881832;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Buf8x4Ou5MZhSoXZCYI+1T9A41SEQ6+K3dIHpAxreAo=;
        b=FiHhmr5LKkTiUpMmJJTQELShRPvsd1KCl+PVqBeG80cq/bC6NtE1F7+BuIMmptZ4DgXPPq
        zo/b2mfJp2N5PDzl75cEBaYnVaNPehWyGCuVmGRO4UZZJFioSHJ4/B81dG4giqYItIXmNB
        bJwFfBUmLv7eX6nanyK3bt4i4/261u69D9YS2gWzW+PO6KGWfjveNU1i3ZqqA0YpVqw7QE
        FOYNwDVRQPtq93uwFOqgTw5zr514XuAwUsmDwMeiQhoRRlRm7sNnVwZNTfT/C8y6/Ac0Xl
        6F54O3AKpWo37tr3K2tq27v8gbl6fzdaueOCuxNAKOLHJUr1kHhkub8jKmOQaA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605881832;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Buf8x4Ou5MZhSoXZCYI+1T9A41SEQ6+K3dIHpAxreAo=;
        b=+9zoVf/cFYU0z4U9aTn174MgGCj8mQWitRl5QUxWdMO9ZWs84XBJFxI8bBXxy5oSwzDdKd
        dBjQwbAGFQFkkCDg==
To:     Marc Zyngier <maz@kernel.org>
Cc:     LAK <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Valentin Schneider <Valentin.Schneider@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Android Kernel Team <kernel-team@android.com>,
        mark.rutland@arm.com
Subject: Re: [PATCH 0/2] arm64: Allow the rescheduling IPI to bypass irq_enter/exit
In-Reply-To: <91cde5eeb22eb2926515dd27113c664a@kernel.org>
References: <20201101131430.257038-1-maz@kernel.org> <87ft5q18qs.fsf@nanos.tec.linutronix.de> <91cde5eeb22eb2926515dd27113c664a@kernel.org>
Date:   Fri, 20 Nov 2020 15:17:12 +0100
Message-ID: <87lfewnmdz.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Marc,

On Fri, Nov 20 2020 at 09:20, Marc Zyngier wrote:
> On 2020-11-03 20:32, Thomas Gleixner wrote:
>> On Sun, Nov 01 2020 at 13:14, Marc Zyngier wrote:
>

> More seriously, it seems to me that we have a bit of a
> cross-architecture disconnect here. I have been trying to join the
> dots between what you describe above, and the behaviour of arm64 (and
> probably a large number of the non-x86 architectures), and I feel
> massively confused.
>
> Up to 5.9, our handling of the rescheduling IPI was "do as little as
> possible": decode the interrupt from the lowest possible level (the
> root irqchip), call into arch code, end-up in scheduler_ipi(), the end.
>
> No lockdep, no RCU, no nothing.
>
> What changed? Have we missed some radical change in the way the core
> kernel expects the arch code to do thing? I'm aware of the 
> kernel/entry/common.c stuff, which implements most of the goodies you
> mention, but this effectively is x86-only at the moment.
>
> If arm64 has forever been broken, I'd really like to know and fix it.

So with the pre 5.8 scheduler IPI we had scheduler_ipi() doing wonderful
things

scheduler_ipi()
       ...
       if (llist_empty(&this_rq()->wake_list) && !got_nohz_idle_kick())
               return;
       irq_enter();
       ...
       irq_exit();

When Peter and I started to investigate the correctness and robustness
of syscalls, interrupts and exceptions versus RCU, instrumentation,
breakpoints for live patching etc., we stumbled over this and a lot of
other things.

Especially instrumentation had grown warts over time to deal with the
problem that it can hit into a RCU idle section. That started to get
worse which made us look deeper and the decision was to have strict
non-instrumentable sections which call out into instrumentable sections
_after_ establishing state. That moved all of the context tracking, RCU,
tracing muck out into C code which is what we have in kernel/entry/ now.

Back to the scheduler IPI. 5.8 made the scheduler IPI an almost empty
function which just folds need resched on architectures which need that.

Of course when I wrote the last reply I had the current x86
implementation in mind which does:

DEFINE_IDTENTRY_SYSVEC_SIMPLE(sysvec_reschedule_ipi)
{
        ack_APIC_irq();
        trace_reschedule_entry(RESCHEDULE_VECTOR);
        inc_irq_stat(irq_resched_count);
        scheduler_ipi();
        trace_reschedule_exit(RESCHEDULE_VECTOR);
}

ack_APIC_irq() can be traced and the tracepoints of course want a proper
established context too.

Now you surely could do:

ASM-IPI-enter:
       asm_ack_irq();
       asm_fold_need_resched();
       reti();

But that's not enough, because the point of the scheduler_ipi is
unsurprisingly to reevaluate need_resched() and to schedule. So you get:

ASM-IPI-enter:
       asm_ack_irq();
       asm_fold_need_resched()
       if (!asm_need_resched())
            reti();

       /* context tracking, rcu, .... */
       handle_enter_from_user_or_kernel();

       preempt_schedule_irq();

       /* context tracking, rcu, .... */
       handle_exit_to_user_or_kernel();
       reti();

We did not do that because we have the tracepoints there and I couldn't
find a reason why having yet another slightly different codepath to get
straight vs. context tracking and RCU was desirable. So we ended up
with:

ASM-IPI-enter:
  asm_enter();

    irqentry_enter() {
      handle_enter_from_user_or_kernel();

      /* Start of safe and instrumentable section */
    }

    __irq_enter_raw();

    sysvec_scheduler_ipi();

    __irq_exit_raw();

    irqentry_exit() {
      if (need_resched())
        preempt_schedule_irq();

      /* End of safe and instrumentable section */

      handle_exit_to_user_or_kernel();
    }

  asm_exit();

The only difference to other IPIs is that it avoids the accounting
overhead because accounting the almost empty scheduler_ipi() function is
pretty much pointless.

Hope that clarifies it.

> If arm64 has forever been broken, I'd really like to know and fix it.

Define broken. It kinda works with all the warts and bolts in tracing,
context tracking and other places. Is it entirely correct? Probably not.

The scheduler IPI is trivial compared to the more interesting ones like
NMI, MCE, breakpoint, debug exceptions etc. We found quite some
interesting issues with all of that muck during our 'noinstr' chase.

Thanks,

        tglx
