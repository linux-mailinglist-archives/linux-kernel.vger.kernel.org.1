Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67AF82A2847
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 11:31:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728424AbgKBKbB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 05:31:01 -0500
Received: from foss.arm.com ([217.140.110.172]:57462 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728156AbgKBKbA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 05:31:00 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E1BE1101E;
        Mon,  2 Nov 2020 02:30:59 -0800 (PST)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C67A53F719;
        Mon,  2 Nov 2020 02:30:58 -0800 (PST)
References: <20201101131430.257038-1-maz@kernel.org>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     LAK <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Android Kernel Team <kernel-team@android.com>
Subject: Re: [PATCH 0/2] arm64: Allow the rescheduling IPI to bypass irq_enter/exit
In-reply-to: <20201101131430.257038-1-maz@kernel.org>
Date:   Mon, 02 Nov 2020 10:30:50 +0000
Message-ID: <jhjsg9syrs5.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Marc,

On 01/11/20 13:14, Marc Zyngier wrote:
> Vincent recently reported [1] that 5.10-rc1 showed a significant
> regression when running "perf bench sched pipe" on arm64, and
> pinpointed it to the recent move to handling IPIs as normal
> interrupts.
>
> The culprit is the use of irq_enter/irq_exit around the handling of
> the rescheduling IPI, meaning that we enter the scheduler right after
> the handling of the IPI instead of deferring it to the next preemption
> event. This accounts for most of the overhead introduced.
>
> On architectures that have architected IPIs at the CPU level (x86
> being the obvious one), the absence of irq_enter/exit is natural. ARM
> (both 32 and 64bits) mimicked this behaviour by having some
> arch-specific handling for the interrupts that are used to implement
> IPIs. Moving IPIs on the normal interrupt path introduced the
> regression.
>
> This couple of patches try to acknowledge the fact that some IPIs are
> "special", in the sense that they don't need to follow the standard
> interrupt handling flow.
>
> The good news is that it cures the regression on arm64, and could
> be similarly beneficial to both 32bit ARM, MIPS, or any other
> architecture that uses a unique IRQ to represent the scheduler IPI.
>
> The bad news is that these patches are ugly as sin, and I really don't
> like them. I specially hate that they can give driver authors the idea
> that they can make random interrupts "faster".
>
> Comments, suggestions and hate mails appreciated, as always.

So since

  90b5363acd47 ("sched: Clean up scheduler_ipi()")
  https://lore.kernel.org/lkml/20200505134058.361859938@linutronix.de/

scheduler_ipi() is indeed pretty lean, though I wonder if moving SGI
handling to genirq didn't just bring us back to before it went on a diet
(< ~5.8).

I don't really have a much better idea, sadly. Perhaps a variant of
handle_domain_irq() that doesn't issue the irq_{enter, exit}() pair we
would call within the GIC driver itself, but then:
- we're back to adding special SGI sauce to the GIC drivers
- it does prevent random drivers from "accelerating" their IRQs, though
  truly invested speed addicts will go and hack the GIC driver anyway :(


Now, I'd like to pen exactly why we think it's okay to forgo irq_{enter,
exit}() for that one IRQ and not any other.

AIUI proper irq_{enter,exit}() signalling is required by RCU, but AFAICT
there is no read side section down this specific path
(CONFIG_RCU_EQS_DEBUG=y may or may not agree with me).

Regarding CONFIG_IRQ_TIME_ACCOUNTING=y, I would tend to say that given this
is genuinely happening within an IRQ, it should be accounted as such. The
other side of the coin is that the actual work is nigh-insignificant, so
one may argue about ignoring it. IMO this is somewhat borderline on the
correctness side of things :/

>       M.
>
> [1] https://lore.kernel.org/r/CAKfTPtDjPpri5Gt6kLeFp_B_zJUZ5DYXEqtJ+0VKohU-y9bFEQ@mail.gmail.com
>
> Marc Zyngier (2):
>   genirq: Allow an interrupt to be marked as 'naked'
>   arm64: Mark the recheduling IPI as naked interrupt
>
>  arch/arm64/kernel/smp.c |  4 ++++
>  include/linux/irq.h     |  4 +++-
>  kernel/irq/debugfs.c    |  1 +
>  kernel/irq/irqdesc.c    | 17 ++++++++++++-----
>  kernel/irq/settings.h   |  7 +++++++
>  5 files changed, 27 insertions(+), 6 deletions(-)
