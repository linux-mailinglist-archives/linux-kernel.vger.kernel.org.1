Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B08B01B5E81
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Apr 2020 17:01:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728961AbgDWPBQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Apr 2020 11:01:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:60340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726380AbgDWPBP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 11:01:15 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8FF6420857;
        Thu, 23 Apr 2020 15:01:14 +0000 (UTC)
Date:   Thu, 23 Apr 2020 11:01:12 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Hillf Danton <hdanton@sina.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Mike Galbraith <efault@gmx.de>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH] sched: make p->prio independent of p->mm
Message-ID: <20200423110112.3e06e508@gandalf.local.home>
In-Reply-To: <20200423141609.5224-1-hdanton@sina.com>
References: <20200423040128.6120-1-hdanton@sina.com>
        <20200423092620.GR20730@hirez.programming.kicks-ass.net>
        <20200423141609.5224-1-hdanton@sina.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Apr 2020 22:16:09 +0800
Hillf Danton <hdanton@sina.com> wrote:

> On Thu, 23 Apr 2020 09:44:03 -0400 Steven Rostedt wrote:
> > 
> > On Thu, 23 Apr 2020 11:26:20 +0200
> > Peter Zijlstra <peterz@infradead.org> wrote:
> >   
> > > On Thu, Apr 23, 2020 at 12:01:28PM +0800, Hillf Danton wrote:  
> > > > --- a/kernel/sched/core.c
> > > > +++ b/kernel/sched/core.c
> > > > @@ -4796,13 +4796,19 @@ recheck:
> > > >  		return -EINVAL;
> > > >  
> > > >  	/*
> > > > -	 * Valid priorities for SCHED_FIFO and SCHED_RR are
> > > > -	 * 1..MAX_USER_RT_PRIO-1, valid priority for SCHED_NORMAL,
> > > > -	 * SCHED_BATCH and SCHED_IDLE is 0.
> > > > +	 * The MAX_USER_RT_PRIO value allows the actual maximum
> > > > +	 * RT priority to be separate from the value exported to
> > > > +	 * user-space.  This allows kernel threads to set their
> > > > +	 * priority to a value higher than any user task.
> > > >  	 */
> > > > -	if ((p->mm && attr->sched_priority > MAX_USER_RT_PRIO-1) ||
> > > > -	    (!p->mm && attr->sched_priority > MAX_RT_PRIO-1))
> > > > -		return -EINVAL;
> > > > +	if (p->flags & PF_KTHREAD) {
> > > > +		if (attr->sched_priority > MAX_RT_PRIO - 1)
> > > > +			return -EINVAL;
> > > > +	} else {
> > > > +		if (attr->sched_priority > MAX_USER_RT_PRIO - 1)
> > > > +			return -EINVAL;
> > > > +	}
> > > > +    
> > > 
> > > Arguably we can do away with the check entirely, MAX_RT_PRIO ==
> > > MAX_USER_RT_PRIO.  
> > 
> > Heh, that was one of my first patches accepted in the mainline kernel! :-) 
> > 
> > And the reason we added it, was because there was a small time when the RT
> > patch (or my variation of it) had MAX_USER_RT_PRIO and MAX_RT_PRIO different
> > values, and would crash in that case here.
> > 
> > d46523ea32a79 ("fix MAX_USER_RT_PRIO and MAX_RT_PRIO")
> > 
> > I would say if we get rid of that check, get rid of the MAX_USER_RT_PRIO
> > with it, and make everything use MAX_RT_PRIO.  
> 
> BTW the newprio compuation at the beginning of the function looks
> questionable if that check is axed without anything added, because
> it's then used in the case of pi boost.


I believe Peter meant axing the double check, not the check together.

That is, instead of:

	if (p->flags & PF_KTHREAD) {
		if (attr->sched_priority > MAX_RT_PRIO - 1)
			return -EINVAL;
	} else {
		if (attr->sched_priority > MAX_USER_RT_PRIO - 1)
			return -EINVAL;
	}

Just have:

	if (attr->sched_priority > MAX_RT_PRIO -1)
		return -EINVAL;

-- Steve
