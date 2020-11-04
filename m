Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D7942A69C0
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 17:29:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731081AbgKDQ3X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 11:29:23 -0500
Received: from foss.arm.com ([217.140.110.172]:39818 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727285AbgKDQ3X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 11:29:23 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 478D6139F;
        Wed,  4 Nov 2020 08:29:22 -0800 (PST)
Received: from C02TD0UTHF1T.local (unknown [10.57.57.109])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E35AE3F718;
        Wed,  4 Nov 2020 08:29:20 -0800 (PST)
Date:   Wed, 4 Nov 2020 16:29:18 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org
Subject: Re: entry: Fix the incorrect ordering of lockdep and RCU check
Message-ID: <20201104162918.GD7577@C02TD0UTHF1T.local>
References: <87y2jhl19s.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87y2jhl19s.fsf@nanos.tec.linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 04, 2020 at 02:06:23PM +0100, Thomas Gleixner wrote:
> When an exception/interrupt hits kernel space and the kernel is not
> currently in the idle task then RCU must be watching.
> 
> irqentry_enter() validates this via rcu_irq_enter_check_tick(), which in
> turn invokes lockdep when taking a lock. But at that point lockdep does not
> yet know about the fact that interrupts have been disabled by the CPU,
> which triggers a lockdep splat complaining about inconsistent state.
> 
> Invoking trace_hardirqs_off() before rcu_irq_enter_check_tick() defeats the
> point of rcu_irq_enter_check_tick() because trace_hardirqs_off() uses RCU.
> 
> So use the same sequence as for the idle case and tell lockdep about the
> irq state change first, invoke the RCU check and then do the lockdep and
> tracer update.
> 
> Fixes: a5497bab5f72 ("entry: Provide generic interrupt entry/exit code")
> Reported-by: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: stable@vger.kernel.org

I just gave this a spin on x86_64 defconfig + PROVE_LOCKING +
DEBUG_LOCKDEP + NO_HZ_FULL + CONTEXT_TRACKING_FORCE, and it gets rid of
the boot-time splat. So FWIW:

Tested-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> ---
>  kernel/entry/common.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> --- a/kernel/entry/common.c
> +++ b/kernel/entry/common.c
> @@ -337,10 +337,10 @@ noinstr irqentry_state_t irqentry_enter(
>  	 * already contains a warning when RCU is not watching, so no point
>  	 * in having another one here.
>  	 */
> +	lockdep_hardirqs_off(CALLER_ADDR0);
>  	instrumentation_begin();
>  	rcu_irq_enter_check_tick();
> -	/* Use the combo lockdep/tracing function */
> -	trace_hardirqs_off();
> +	trace_hardirqs_off_finish();
>  	instrumentation_end();
>  
>  	return ret;
