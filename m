Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FB642D8227
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 23:33:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406951AbgLKWcw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 17:32:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:55142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406925AbgLKWci (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 17:32:38 -0500
Date:   Fri, 11 Dec 2020 23:31:55 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607725917;
        bh=cQDvNDfLPRHr8ml7+eYmQf2xrnCF8Fjs9k+mB8nUpQw=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=eKhSc8azfx35osizM4x+tSP4ZCMPGjlK3VLs2BfwSgvErgLRVsdT3x9fT8IsF6o1Z
         jmHf5NB7j5ZysdkHicqI4CnR2Ykl2Hp1dembS8EKTPh0pGpOK43KQvMz3xt6gI50L+
         ka5bD+8FzOpPSz10mf64sysWxHTy8ndL++t3q+HbcXkc4ZSdjZW5gaHNS8HLMKStHh
         I4bjZtsrfi0KjMwyltp0QcDrHyUiUV0wL7b3iO6O2G06Cc2p+EYQqorgZKSIeaibk6
         EwMulj0Q8cj00tZvxPz1aZ9OT2R55ZReUdDdtOj9CM9W9U5hf2i9qxaE8O9U34utUV
         5mY44F3CxOQAw==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Marco Elver <elver@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>
Subject: Re: [patch 1/3] tick: Remove pointless cpu valid check in hotplug
 code
Message-ID: <20201211223155.GC595642@lothringen>
References: <20201206211253.919834182@linutronix.de>
 <20201206212002.582579516@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201206212002.582579516@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 06, 2020 at 10:12:54PM +0100, Thomas Gleixner wrote:
> tick_handover_do_timer() which is invoked when a CPU is unplugged has a
> check for cpumask_first(cpu_online_mask) when it tries to hand over the
> tick update duty.
> 
> Checking the result of cpumask_first() there is pointless because if the
> online mask is empty at this point, then this would be the last CPU in the
> system going offline, which is impossible. There is always at least one CPU
> remaining. If online mask would be really empty then the timer duty would
> be the least of the resulting problems.
> 
> Remove the well meant check simply because it is pointless and confusing.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  kernel/time/tick-common.c |   10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
> 
> --- a/kernel/time/tick-common.c
> +++ b/kernel/time/tick-common.c
> @@ -407,17 +407,13 @@ EXPORT_SYMBOL_GPL(tick_broadcast_oneshot
>  /*
>   * Transfer the do_timer job away from a dying cpu.
>   *
> - * Called with interrupts disabled. Not locking required. If
> + * Called with interrupts disabled. No locking required. If
>   * tick_do_timer_cpu is owned by this cpu, nothing can change it.
>   */
>  void tick_handover_do_timer(void)
>  {
> -	if (tick_do_timer_cpu == smp_processor_id()) {
> -		int cpu = cpumask_first(cpu_online_mask);
> -
> -		tick_do_timer_cpu = (cpu < nr_cpu_ids) ? cpu :
> -			TICK_DO_TIMER_NONE;
> -	}
> +	if (tick_do_timer_cpu == smp_processor_id())
> +		tick_do_timer_cpu = cpumask_first(cpu_online_mask);
>  }

BTW since we have that, why do we need:

static bool can_stop_idle_tick(int cpu, struct tick_sched *ts)
{
	/*
	 * If this CPU is offline and it is the one which updates
	 * jiffies, then give up the assignment and let it be taken by
	 * the CPU which runs the tick timer next. If we don't drop
	 * this here the jiffies might be stale and do_timer() never
	 * invoked.
	 */
	if (unlikely(!cpu_online(cpu))) {
		if (cpu == tick_do_timer_cpu)
			tick_do_timer_cpu = TICK_DO_TIMER_NONE;


We should only enter idle with an offline CPU after calling
tick_handover_do_timer() so (cpu == tick_do_timer_cpu) shouldn't be possible.

Or am I missing something?
