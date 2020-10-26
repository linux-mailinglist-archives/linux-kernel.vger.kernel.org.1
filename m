Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C832A298FAB
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 15:42:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1781842AbgJZOm4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 10:42:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:35306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1781724AbgJZOm4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 10:42:56 -0400
Received: from localhost (bny93-h09-176-172-152-46.dsl.sta.abo.bbox.fr [176.172.152.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6767722263;
        Mon, 26 Oct 2020 14:42:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603723375;
        bh=bpuObpcLJtZiDmzQS2y2dFX1l3G60DHiaBNVEThZDbU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fUVz3TRnfuRrFaO/UAEVAr9jUymYgKp/NAytBrlIhlN2CgjYE1yYNJDMS2PImwoM3
         IzmWevNpz4hxj6Myk55TEOpz+54cPW7VNOSLUXGigLvHuV1h9QepGVyMcUmyTezrHU
         4ntZU9tWMjK5NRxRAfeGiiFSJr9ExqCxM277aYo4=
Date:   Mon, 26 Oct 2020 15:42:53 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Marcelo Tosatti <mtosatti@redhat.com>,
        linux-kernel@vger.kernel.org,
        Nitesh Narayan Lal <nitesh@redhat.com>,
        Peter Xu <peterx@redhat.com>
Subject: Re: [patch 1/2] nohz: only wakeup a single target cpu when kicking a
 task
Message-ID: <20201026144253.GB120760@lothringen>
References: <20201007180151.623061463@redhat.com>
 <20201007180229.724302019@redhat.com>
 <20201008122256.GW2628@hirez.programming.kicks-ass.net>
 <20201008175409.GB14207@fuller.cnet>
 <20201008195444.GB86389@lothringen>
 <20201013171328.GA19284@fuller.cnet>
 <20201014083321.GA2628@hirez.programming.kicks-ass.net>
 <20201014234053.GA86158@lothringen>
 <20201015101235.GA2611@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201015101235.GA2611@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 15, 2020 at 12:12:35PM +0200, Peter Zijlstra wrote:
> On Thu, Oct 15, 2020 at 01:40:53AM +0200, Frederic Weisbecker wrote:
> > > re tick_nohz_task_switch() being placed wrong, it should probably be
> > > placed before finish_lock_switch(). Something like so.
> > > 
> > > 
> > > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > > index cf044580683c..5c92c959824f 100644
> > > --- a/kernel/sched/core.c
> > > +++ b/kernel/sched/core.c
> > > @@ -4084,6 +4084,7 @@ static struct rq *finish_task_switch(struct task_struct *prev)
> > >  	vtime_task_switch(prev);
> > >  	perf_event_task_sched_in(prev, current);
> > >  	finish_task(prev);
> > > +	tick_nohz_task_switch();
> > >  	finish_lock_switch(rq);
> > >  	finish_arch_post_lock_switch();
> > >  	kcov_finish_switch(current);
> > > @@ -4121,7 +4122,6 @@ static struct rq *finish_task_switch(struct task_struct *prev)
> > >  		put_task_struct_rcu_user(prev);
> > >  	}
> > >  
> > > -	tick_nohz_task_switch();
> > 
> > IIRC, we wanted to keep it outside rq lock because it shouldn't it...
> 
> But now you've created a window with IRQs on and cause additional IRQ
> state changes.
> 
> If you're really worried about rq->lock, I suppose we can do:
> 
> 	rq_unlock(rq->lock);
> 	tick_nohz_task_switch();
> 	local_irq_enable();
> 
> (much like we do at the beginning of __schedule for RCU)

Right. Well I'm not that worried about rq->lock though. If you're ok
with it I can just move it before finish_lock_switch().

Thanks.
