Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27FC92D81E3
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 23:23:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387416AbgLKWWK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 17:22:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:50072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728668AbgLKWVr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 17:21:47 -0500
Date:   Fri, 11 Dec 2020 23:21:04 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607725266;
        bh=QjcAyGeOdHLkJ34+U+ps+ACBJVcdcJxP0G2iwWZMTEg=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=PRfgAHmbCX2a8hpRBXSy39XAT6/7u81neovUyoR2sSu8ilw7JXo66ut5ZhSCdGGns
         ubI73UWt3LQq5GNf2F5zinRnsgVPvEMxdhOSEMeupcwr8XK9Awy1t/Q/Qd2etWhOWf
         S9fehJPf1x2x3PJ91qAgnae6+fTmY7u1FEuTeJlfrvzB9Uxi/daVWp+GnHYYkm7k3t
         FDGPmmaGzMLxAcExtQokLQ+a3q3+0YUWwijXYBx++okR8SwrzhQLGBzhS1MT3hPlTd
         H7qYHiTzDtkRVLDcR2XnBUNz7FGfYhGXk0EPPzsl5R8YHaDscr57Iv8uOuMfXFymeU
         rPojYTSKJ+6/Q==
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
Message-ID: <20201211222104.GB595642@lothringen>
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

I was about to whine that this randomly chosen CPU may be idle and leave
the timekeeping stale until I realized that stop_machine() is running at that
time. Might be worth adding a comment about that.

Also why not just setting it to TICK_DO_TIMER_NONE and be done with it? Perhaps
to avoid that all the CPUs to compete and contend on jiffies update after stop
machine?

If so:

   Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

Thanks.

