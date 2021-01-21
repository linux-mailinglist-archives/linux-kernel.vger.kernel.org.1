Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B07932FF137
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 17:59:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388285AbhAUQ7R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 11:59:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388235AbhAUQ6U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 11:58:20 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B1DBC06174A
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 08:57:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=a3vZpZDv6MO3Xpi9WELGB6t/XxhKnwc5WC4KkNkludU=; b=BXwwHorllYfX2+UoFjT4g98G1c
        stHM4B9UUb0LDHG8I7B5HIX5mPhTZ7GE97pmmLGaz5pjtQ1OB9UYZA55TisGslOAFR4X7CjP1f6la
        EZia4wEBwAx4HHPlyd0RullK2HjrhHu38H7aVLFeTBiYZuO9zDhSUOHkXDNLkuJfLaGMeKSIx8BGy
        4vQGBuvZpmMRBmYs1cfOLQ0AQyen7ZkFdUcDhVK+Zm8sMHhYyXTq+Rt3JQD90niDL2yXALXanSGRy
        HYvdIgMYsjd/xB3g0UAqhzVuV4xARuVXWEappHwMC5+lC7zvfcgHOol/zfhwXGZULuhry6skNGmXj
        W9md0Fow==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1l2dGQ-00HHnq-Rm; Thu, 21 Jan 2021 16:57:01 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 78AF3303271;
        Thu, 21 Jan 2021 17:56:53 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6700F2028FE72; Thu, 21 Jan 2021 17:56:53 +0100 (CET)
Date:   Thu, 21 Jan 2021 17:56:53 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     tglx@linutronix.de, frederic@kernel.org,
        linux-kernel@vger.kernel.org, x86@kernel.org, cai@lca.pw,
        mgorman@techsingularity.net, joel@joelfernandes.org,
        valentin.schneider@arm.com
Subject: Re: [RFC][PATCH 4/7] smp: Optimize send_call_function_single_ipi()
Message-ID: <YAmyVW1r0xQOwneB@hirez.programming.kicks-ass.net>
References: <20200526161057.531933155@infradead.org>
 <20200526161907.953304789@infradead.org>
 <20200527095645.GH325280@hirez.programming.kicks-ass.net>
 <20200527101513.GJ325303@hirez.programming.kicks-ass.net>
 <20200527155656.GU2869@paulmck-ThinkPad-P72>
 <20200527163543.GA706478@hirez.programming.kicks-ass.net>
 <20200527171236.GC706495@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200527171236.GC706495@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 27, 2020 at 07:12:36PM +0200, Peter Zijlstra wrote:
> Subject: rcu: Allow for smp_call_function() running callbacks from idle
> 
> Current RCU hard relies on smp_call_function() callbacks running from
> interrupt context. A pending optimization is going to break that, it
> will allow idle CPUs to run the callbacks from the idle loop. This
> avoids raising the IPI on the requesting CPU and avoids handling an
> exception on the receiving CPU.
> 
> Change rcu_is_cpu_rrupt_from_idle() to also accept task context,
> provided it is the idle task.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  kernel/rcu/tree.c   | 25 +++++++++++++++++++------
>  kernel/sched/idle.c |  4 ++++
>  2 files changed, 23 insertions(+), 6 deletions(-)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index d8e9dbbefcfa..c716eadc7617 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -418,16 +418,23 @@ void rcu_momentary_dyntick_idle(void)
>  EXPORT_SYMBOL_GPL(rcu_momentary_dyntick_idle);
>  
>  /**
> - * rcu_is_cpu_rrupt_from_idle - see if interrupted from idle
> + * rcu_is_cpu_rrupt_from_idle - see if 'interrupted' from idle
>   *
>   * If the current CPU is idle and running at a first-level (not nested)
> - * interrupt from idle, return true.  The caller must have at least
> - * disabled preemption.
> + * interrupt, or directly, from idle, return true.
> + *
> + * The caller must have at least disabled IRQs.
>   */
>  static int rcu_is_cpu_rrupt_from_idle(void)
>  {
> -	/* Called only from within the scheduling-clock interrupt */
> -	lockdep_assert_in_irq();
> +	long nesting;
> +
> +	/*
> +	 * Usually called from the tick; but also used from smp_function_call()
> +	 * for expedited grace periods. This latter can result in running from
> +	 * the idle task, instead of an actual IPI.
> +	 */
> +	lockdep_assert_irqs_disabled();
>  
>  	/* Check for counter underflows */
>  	RCU_LOCKDEP_WARN(__this_cpu_read(rcu_data.dynticks_nesting) < 0,
> @@ -436,9 +443,15 @@ static int rcu_is_cpu_rrupt_from_idle(void)
>  			 "RCU dynticks_nmi_nesting counter underflow/zero!");
>  
>  	/* Are we at first interrupt nesting level? */
> -	if (__this_cpu_read(rcu_data.dynticks_nmi_nesting) != 1)
> +	nesting = __this_cpu_read(rcu_data.dynticks_nmi_nesting);
> +	if (nesting > 1)
>  		return false;
>  
> +	/*
> +	 * If we're not in an interrupt, we must be in the idle task!
> +	 */
> +	WARN_ON_ONCE(!nesting && !is_idle_task(current));
> +
>  	/* Does CPU appear to be idle from an RCU standpoint? */
>  	return __this_cpu_read(rcu_data.dynticks_nesting) == 0;
>  }

Let me revive this thread after yesterdays IRC conversation.

As said; it might be _extremely_ unlikely, but somewhat possible for us
to send the IPI concurrent with hot-unplug, not yet observing
rcutree_offline_cpu() or thereabout.

Then have the IPI 'delayed' enough to not happen until smpcfd_dying()
and getting ran there.

This would then run the function from the stopper thread instead of the
idle thread and trigger the warning, even though we're not holding
rcu_read_lock() (which, IIRC, was the only constraint).

So would something like the below be acceptable?

---
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 368749008ae8..2c8d4c3e341e 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -445,7 +445,7 @@ static int rcu_is_cpu_rrupt_from_idle(void)
 	/*
 	 * Usually called from the tick; but also used from smp_function_call()
 	 * for expedited grace periods. This latter can result in running from
-	 * the idle task, instead of an actual IPI.
+	 * a (usually the idle) task, instead of an actual IPI.
 	 */
 	lockdep_assert_irqs_disabled();
 
@@ -461,9 +461,14 @@ static int rcu_is_cpu_rrupt_from_idle(void)
 		return false;
 
 	/*
-	 * If we're not in an interrupt, we must be in the idle task!
+	 * If we're not in an interrupt, we must be in task context.
+	 *
+	 * This will typically be the idle task through:
+	 *   flush_smp_call_function_from_idle(),
+	 *
+	 * but can also be in CPU HotPlug through smpcfd_dying().
 	 */
-	WARN_ON_ONCE(!nesting && !is_idle_task(current));
+	WARN_ON_ONCE(!nesting && !in_task(current));
 
 	/* Does CPU appear to be idle from an RCU standpoint? */
 	return __this_cpu_read(rcu_data.dynticks_nesting) == 0;
