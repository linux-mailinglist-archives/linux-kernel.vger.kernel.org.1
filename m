Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1C9327F25A
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 21:10:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729954AbgI3TK3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 15:10:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:42706 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728916AbgI3TK3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 15:10:29 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 72C8320709;
        Wed, 30 Sep 2020 19:10:28 +0000 (UTC)
Date:   Wed, 30 Sep 2020 15:10:26 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [WARNING] kernel/rcu/tree.c:1058 rcu_irq_enter+0x15/0x20
Message-ID: <20200930151026.4a87ab79@gandalf.local.home>
In-Reply-To: <20200930181323.GF2628@hirez.programming.kicks-ass.net>
References: <20200917131647.2b55ebb1@gandalf.local.home>
        <20200930181323.GF2628@hirez.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Sep 2020 20:13:23 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

>  diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
> > index 6a584b3e5c74..3e5bc1dd71c6 100644
> > --- a/include/linux/lockdep.h
> > +++ b/include/linux/lockdep.h
> > @@ -550,7 +550,8 @@ do {									\
> >  
> >  #define lockdep_assert_irqs_disabled()					\
> >  do {									\
> > -	WARN_ON_ONCE(debug_locks && raw_cpu_read(hardirqs_enabled));	\
> > +	WARN_ON_ONCE(debug_locks && raw_cpu_read(hardirqs_enabled) &&	\
> > +           likely(!(current->lockdep_recursion & LOCKDEP_RECURSION_MASK)));\
> >  } while (0)  
> 
> Blergh, IIRC there's header hell that way. The sane fix is killing off
> that trace_*_rcuidle() disease.

Really?

I could run this through all my other tests to see if that is the case.
That is, to see if it stumbles across header hell.

> 
> But I think this will also cure it.
> 
> ---
> diff --git a/arch/x86/kernel/unwind_orc.c b/arch/x86/kernel/unwind_orc.c
> index 6a339ce328e0..4f90293d170b 100644
> --- a/arch/x86/kernel/unwind_orc.c
> +++ b/arch/x86/kernel/unwind_orc.c
> @@ -432,7 +432,7 @@ bool unwind_next_frame(struct unwind_state *state)
>  		return false;
>  
>  	/* Don't let modules unload while we're reading their ORC data. */
> -	preempt_disable();
> +	preempt_disable_notrace();
>  
>  	/* End-of-stack check for user tasks: */
>  	if (state->regs && user_mode(state->regs))
> @@ -612,14 +612,14 @@ bool unwind_next_frame(struct unwind_state *state)
>  		goto err;
>  	}
>  
> -	preempt_enable();
> +	preempt_enable_notrace();
>  	return true;
>  
>  err:
>  	state->error = true;
>  
>  the_end:
> -	preempt_enable();
> +	preempt_enable_notrace();
>  	state->stack_info.type = STACK_TYPE_UNKNOWN;
>  	return false;
>  }

I think you are going to play whack-a-mole with this approach. This will
happen anytime preempt_disable is being traced within lockdep internal code.

I just hit this:

register_lock_class
  assign_lock_key
    __is_module_percpu_address
      preempt_disable
         trace_preempt_disable
            rcu_irq_enter_irqson
              [..]


Same thing, different path.

-- Steve
