Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 824E31FA132
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jun 2020 22:16:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731556AbgFOUQv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Jun 2020 16:16:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731547AbgFOUQt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 16:16:49 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88D6EC05BD43
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 13:16:49 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id di13so8384683qvb.12
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 13:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NzhfudWzFXurQXJFFY6vmZI0IP33jXkPNuEEVWW9ngg=;
        b=HIkFMbitJmwxA+wuBmiV/tLZRI8bv58z/NXUoopl8qO0ywOkldDeby/ja0GC3/IAqx
         lHbWvl07kJ1b3BoUH/cGWmMJSISFk3ll1hp3T8i1L30GckXMMEDcAV9j77zO9P9veybN
         Rj9uBwrAc4FG4en8AeH5Suk7m/opKG6AaCfS0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NzhfudWzFXurQXJFFY6vmZI0IP33jXkPNuEEVWW9ngg=;
        b=U+XMwfNlCFBdMqp9RbH8X3fMcJ+w/SZjPqiSKTfJ7JY/cE/ginrjAPNZUNqPaEGkSq
         BOXaWBM+GlpE3buleHEWHp45j5zCJtfPnSEx/Ho/dujvue76Rl85+RXLdQHdDkOY4nuO
         UbqZnD9yLPhvzJjVx8AR+OzrJC+ortQUouxz6I/OHlMDh504iKgzzJSEmhZ2Cm4cZn2k
         87rWZDAhK0g/If+GFkkwS1atQGSTx4kwPDHnSnyh9GMfPEo9mpff3gQ3RG4BdiglallA
         6qBn3FSRIKo2RjtpJeam4f2oUAtwRHVLzJLpKA554Kekx07L62hfKODWexO17c450cv1
         bVxg==
X-Gm-Message-State: AOAM532coMGNxsT317W3oK9Ju80F5F44R0FwoSI+HnFnnVjrcfDKnRcm
        AXT5vJSQt7GwEGmqGSE+MoethRdfJyo=
X-Google-Smtp-Source: ABdhPJxHwdiVrt4vLkrYyu+U112rb6GNpXazXrwy/4PK9SltE0k6ktbFvzYya9iwY9wzc2LAGeSrfw==
X-Received: by 2002:a0c:bd9a:: with SMTP id n26mr26886256qvg.21.1592252208523;
        Mon, 15 Jun 2020 13:16:48 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id x66sm11800990qkb.33.2020.06.15.13.16.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 13:16:47 -0700 (PDT)
Date:   Mon, 15 Jun 2020 16:16:47 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, rcu@vger.kernel.org,
        Andrew Lutomirski <luto@kernel.org>, X86 ML <x86@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH x86/entry: Force rcu_irq_enter() when in idle task
Message-ID: <20200615201647.GC12037@google.com>
References: <20200611235305.GA32342@paulmck-ThinkPad-P72>
 <CALCETrWo-zpiDsYGtKvm8LzW6CQ5L19a3+Ag_9g8aL4wHaJj9g@mail.gmail.com>
 <871rmkzcc8.fsf@nanos.tec.linutronix.de>
 <87wo4cxubv.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87wo4cxubv.fsf@nanos.tec.linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas, Paul,

On Fri, Jun 12, 2020 at 03:55:00PM +0200, Thomas Gleixner wrote:
> The idea of conditionally calling into rcu_irq_enter() only when RCU is
> not watching turned out to be not completely thought through.
> 
> Paul noticed occasional premature end of grace periods in RCU torture
> testing. Bisection led to the commit which made the invocation of
> rcu_irq_enter() conditional on !rcu_is_watching().
> 
> It turned out that this conditional breaks RCU assumptions about the idle
> task when the scheduler tick happens to be a nested interrupt. Nested
> interrupts can happen when the first interrupt invokes softirq processing
> on return which enables interrupts. If that nested tick interrupt does not
> invoke rcu_irq_enter() then the nest accounting in RCU claims that this is
> the first interrupt which might mark a quiescient state and end grace
> periods prematurely.
> 
> Change the condition from !rcu_is_watching() to is_idle_task(current) which
> enforces that interrupts in the idle task unconditionally invoke
> rcu_irq_enter() independent of the RCU state.
> 
> This is also correct vs. user mode entries in NOHZ full scenarios because
> user mode entries bring RCU out of EQS and force the RCU irq nesting state

I had to re-read this sentence a couple of times. The 'user mode entries'
sounds like 'entry into user mode'. It would be good to reword it to 'IRQ
entry in user mode'.

My knowledge predates the rcu-watching reworks so apologies on the below
question but I still didn't fully follow why when the idle task behaves
differently from being in user mode. Even with user mode we should have:

<user mode>  (in EQS)
  <irq entry>   <---------- exits EQS so now rcu is watching
     <softirq entry in the exit path>
        <timer tick irq entry>  <-- the buggy !watching logic prevents rcu_irq_enter
	    -> report QS since tick thinks it is first level.

Is there a subtlety here I'm missing? I checked the RCU code and I did not
see anywhere that rcu_user_enter() makes it behave differently. Both
rcu_user_enter() and rcu_idle_enter() call rcu_eqs_enter().

> accounting to nested. As only the first interrupt can enter from user mode
> a nested tick interrupt will enter from kernel mode and as the nesting
> state accounting is forced to nesting it will not do anything stupid even
> if rcu_irq_enter() has not been invoked.
> 
> Fixes: 3eeec3858488 ("x86/entry: Provide idtentry_entry/exit_cond_rcu()")
> Reported-by: "Paul E. McKenney" <paulmck@kernel.org>

> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  arch/x86/entry/common.c |   35 ++++++++++++++++++++++++++++-------
>  1 file changed, 28 insertions(+), 7 deletions(-)
> --- a/arch/x86/entry/common.c
> +++ b/arch/x86/entry/common.c
> @@ -557,14 +557,34 @@ bool noinstr idtentry_enter_cond_rcu(str
>  		return false;
>  	}
>  
> -	if (!__rcu_is_watching()) {
> +	/*
> +	 * If this entry hit the idle task invoke rcu_irq_enter() whether
> +	 * RCU is watching or not.
> +	 *
> +	 * Interupts can nest when the first interrupt invokes softirq
> +	 * processing on return which enables interrupts.
> +	 *
> +	 * Scheduler ticks in the idle task can mark quiescent state and
> +	 * terminate a grace period, if and only if the timer interrupt is
> +	 * not nested into another interrupt.
> +	 *
> +	 * Checking for __rcu_is_watching() here would prevent the nesting
> +	 * interrupt to invoke rcu_irq_enter(). If that nested interrupt is
> +	 * the tick then rcu_flavor_sched_clock_irq() would wrongfully
> +	 * assume that it is the first interupt and eventually claim
> +	 * quiescient state and end grace periods prematurely.
> +	 *
> +	 * Unconditionally invoke rcu_irq_enter() so RCU state stays
> +	 * consistent.

It is not really unconditional though, we are checking for the idle task
below.  I suggest a slight reword of the comments accordingly.

thanks,

 - Joel


> +	 *
> +	 * TINY_RCU does not support EQS, so let the compiler eliminate
> +	 * this part when enabled.
> +	 */
> +	if (!IS_ENABLED(CONFIG_TINY_RCU) && is_idle_task(current)) {
>  		/*
>  		 * If RCU is not watching then the same careful
>  		 * sequence vs. lockdep and tracing is required
>  		 * as in enter_from_user_mode().
> -		 *
> -		 * This only happens for IRQs that hit the idle
> -		 * loop, i.e. if idle is not using MWAIT.
>  		 */
>  		lockdep_hardirqs_off(CALLER_ADDR0);
>  		rcu_irq_enter();
> @@ -576,9 +596,10 @@ bool noinstr idtentry_enter_cond_rcu(str
>  	}
>  
>  	/*
> -	 * If RCU is watching then RCU only wants to check
> -	 * whether it needs to restart the tick in NOHZ
> -	 * mode.
> +	 * If RCU is watching then RCU only wants to check whether it needs
> +	 * to restart the tick in NOHZ mode. rcu_irq_enter_check_tick()
> +	 * already contains a warning when RCU is not watching, so no point
> +	 * in having another one here.
>  	 */
>  	instrumentation_begin();
>  	rcu_irq_enter_check_tick();
