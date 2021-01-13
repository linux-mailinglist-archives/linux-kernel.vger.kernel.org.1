Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A32B42F552B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 00:24:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729444AbhAMXXC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 18:23:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:50208 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729424AbhAMXUp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 18:20:45 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0BABC2339D;
        Wed, 13 Jan 2021 23:08:24 +0000 (UTC)
Date:   Wed, 13 Jan 2021 18:08:23 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "peterz@infradead.org" <peterz@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     Tianxianting <tian.xianting@h3c.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
        "bsegall@google.com" <bsegall@google.com>,
        "mgorman@suse.de" <mgorman@suse.de>
Subject: Re: [PATCH] sched/rt: Print curr when RT throttling activated
Message-ID: <20210113180823.4c53f433@gandalf.local.home>
In-Reply-To: <20201208093701.3a890235@gandalf.local.home>
References: <20201203075129.17902-1-tian.xianting@h3c.com>
        <20201203093956.6dd8a753@gandalf.local.home>
        <f3265adc26d4416dacf157f61fa60ad6@h3c.com>
        <20201208093701.3a890235@gandalf.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Peter? ;-)

This one looks useful as well. Simple patch.

-- Steve


On Tue, 8 Dec 2020 09:37:01 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> Peter?
> 
> -- Steve
> 
> 
> On Tue, 8 Dec 2020 07:58:54 +0000
> Tianxianting <tian.xianting@h3c.com> wrote:
> 
> > Thanks,
> > We met an issue that a normal thread can't get cpu, 
> > And at this moment, we found 'sched: RT throttling activated' log.
> > 
> > So I think this patch is useful for such issue.
> > 
> > Could I get more comments?  Thanks in advance
> > -----Original Message-----
> > From: Steven Rostedt [mailto:rostedt@goodmis.org] 
> > Sent: Thursday, December 03, 2020 10:40 PM
> > To: tianxianting (RD) <tian.xianting@h3c.com>
> > Cc: mingo@redhat.com; peterz@infradead.org; juri.lelli@redhat.com; vincent.guittot@linaro.org; dietmar.eggemann@arm.com; bsegall@google.com; mgorman@suse.de; linux-kernel@vger.kernel.org
> > Subject: Re: [PATCH] sched/rt: Print curr when RT throttling activated
> > 
> > On Thu, 3 Dec 2020 15:51:29 +0800
> > Xianting Tian <tian.xianting@h3c.com> wrote:
> >   
> > > We may meet the issue, that one RT thread occupied the cpu by 
> > > 950ms/1s, The RT thread maybe is a business thread or other unknown thread.
> > > 
> > > Currently, it only outputs the print "sched: RT throttling activated"
> > > when RT throttling happen. It is hard to know what is the RT thread, 
> > > For further analysis, we need add more prints.
> > > 
> > > This patch is to print current RT task when RT throttling activated, 
> > > It help us to know what is the RT thread in the first time.    
> > 
> > I think this can be useful information to include.
> > 
> > Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> > 
> > -- Steve
> >   
> > > 
> > > Signed-off-by: Xianting Tian <tian.xianting@h3c.com>
> > > ---
> > >  kernel/sched/rt.c | 7 ++++---
> > >  1 file changed, 4 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c index 
> > > f215eea6a..8913f38cb 100644
> > > --- a/kernel/sched/rt.c
> > > +++ b/kernel/sched/rt.c
> > > @@ -946,7 +946,7 @@ static inline int rt_se_prio(struct sched_rt_entity *rt_se)
> > >  	return rt_task_of(rt_se)->prio;
> > >  }
> > >  
> > > -static int sched_rt_runtime_exceeded(struct rt_rq *rt_rq)
> > > +static int sched_rt_runtime_exceeded(struct rt_rq *rt_rq, struct 
> > > +task_struct *curr)
> > >  {
> > >  	u64 runtime = sched_rt_runtime(rt_rq);
> > >  
> > > @@ -970,7 +970,8 @@ static int sched_rt_runtime_exceeded(struct rt_rq *rt_rq)
> > >  		 */
> > >  		if (likely(rt_b->rt_runtime)) {
> > >  			rt_rq->rt_throttled = 1;
> > > -			printk_deferred_once("sched: RT throttling activated\n");
> > > +			printk_deferred_once("sched: RT throttling activated (curr: pid %d, comm %s)\n",
> > > +						curr->pid, curr->comm);
> > >  		} else {
> > >  			/*
> > >  			 * In case we did anyway, make it go away, @@ -1026,7 +1027,7 @@ 
> > > static void update_curr_rt(struct rq *rq)
> > >  		if (sched_rt_runtime(rt_rq) != RUNTIME_INF) {
> > >  			raw_spin_lock(&rt_rq->rt_runtime_lock);
> > >  			rt_rq->rt_time += delta_exec;
> > > -			if (sched_rt_runtime_exceeded(rt_rq))
> > > +			if (sched_rt_runtime_exceeded(rt_rq, curr))
> > >  				resched_curr(rq);
> > >  			raw_spin_unlock(&rt_rq->rt_runtime_lock);
> > >  		}    
> 

