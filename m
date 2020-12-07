Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FF002D08BF
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 02:16:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728474AbgLGBPc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Dec 2020 20:15:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:58212 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726046AbgLGBPb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Dec 2020 20:15:31 -0500
Date:   Mon, 7 Dec 2020 02:14:48 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607303691;
        bh=VqRQ7iKirwWIux4wAq03tm7o6Qg9yrT+iDhtIX5XAac=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=RFBhGL/pvMuQYcqiByPC+xhmm+LZHNE1OlnBTZVfOXSABeV6REk7NduYuvxhuUDO9
         JezlvxjhugigUAQvlPKR13On85ExW7QrW3uCsny/fY8g4rjMOxhs0ITi2veD5uStLi
         v6rweOprXRuJd9nIipfB4tApv2F7Lkdb6uluVSozfBjl+2L/LFcypFWg1cVgna3XRX
         kAaVCw72ehAzvwkZQ1G9vYMlv1KzP8IPz+PVMb2z28ucAjiIuhJ021WxxYwmnNMdwl
         BCEps+QRfaLfr8P5PSZQqt/FFTFn4lg6AF7ZKIjMsbxAlFGhjSAqudvE6hVBnWto8J
         nNQrxuHDuq51Q==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Paul McKenney <paulmck@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [patch V2 2/9] irqtime: Make accounting correct on RT
Message-ID: <20201207011448.GC113660@lothringen>
References: <20201204170151.960336698@linutronix.de>
 <20201204170804.889561591@linutronix.de>
 <20201207002343.GA113660@lothringen>
 <87czzm77re.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87czzm77re.fsf@nanos.tec.linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 07, 2020 at 01:57:25AM +0100, Thomas Gleixner wrote:
> On Mon, Dec 07 2020 at 01:23, Frederic Weisbecker wrote:
> >> --- a/kernel/sched/cputime.c
> >> +++ b/kernel/sched/cputime.c
> >> @@ -60,7 +60,7 @@ void irqtime_account_irq(struct task_str
> >>  	cpu = smp_processor_id();
> >>  	delta = sched_clock_cpu(cpu) - irqtime->irq_start_time;
> >>  	irqtime->irq_start_time += delta;
> >> -	pc = preempt_count() - offset;
> >> +	pc = irq_count() - offset;
> >
> > There are many preempt_count() users all around waiting for similar issues.
> > Wouldn't it be more reasonable to have current->softirq_disable_cnt just saving
> > the softirq count on context switch?
> 
> There are not that many and all of them need to be looked at.
> 
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index d2003a7d5ab5..6c899c35d6ba 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -3469,6 +3469,10 @@ static inline void prepare_task(struct task_struct *next)
> >  
> >  static inline void finish_task(struct task_struct *prev)
> >  {
> > +#ifdef CONFIG_PREEMPT_RT
> > +	prev->softirq_disable_cnt = softirq_count();
> > +	__preempt_count_sub(prev->softirq_disable_cnt);
> > +#endif
> 
> You fundamentaly break RT with that.
> 
> If local_bh_disable() fiddles with the actual preempt_count on RT then
> softirq disabled sections and softirq processing are not longer
> preemtible.
> 
> You asked me in the last round of patches to add a proper argument for
> pulling out the softirq count from preempt_count. Here is the revised
> changelog which you agreed with:
> 
>  "RT requires the softirq processing and local bottomhalf disabled regions to
>   be preemptible. Using the normal preempt count based serialization is
>   therefore not possible because this implicitely disables preemption.
>   ....
>  "
> 
> Full text in patch 1/9.
> 
> According to the above folding of softirq count into the actual preempt
> count cannot work at all.
> 
> The current RT approach just works except for the places which look at
> the raw preempt_count and not using the wrappers. Those places are
> restricted to core code and a pretty small number.
> 
> Trying to do what you suggest would be a major surgery all over the
> place including a complete trainwreck on the highly optimized
> preempt_enable() --> preempt decision.

I suspected it was more complicated than I imagined :-)
Nevermind.

Thanks.
