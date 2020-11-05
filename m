Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 519E02A8329
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 17:12:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730669AbgKEQMp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 11:12:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43803 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725862AbgKEQMp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 11:12:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604592762;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XH1Cfju6MZ640Pe1FCbEa5SrQlXLpmK1upziHCywFic=;
        b=iWWNbvGcPUu4oowTzzhUJ2gd8qPnBHspftbBb8ffUcqThe20osTv/7NNXHLM273l8FaFRO
        o76ZbL7COwaf3WGENJl/VPH8Fseov1AVQYgsQaCFxvd3FIe/+2zuq0GcStJy9azqc/agVB
        TSYYmOgWiqnMQMymnV1To9qu20vFdEw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-27-kCVW6sqaPauLLd8a66iYSg-1; Thu, 05 Nov 2020 11:12:41 -0500
X-MC-Unique: kCVW6sqaPauLLd8a66iYSg-1
Received: by mail-wr1-f72.google.com with SMTP id i1so899077wrb.18
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 08:12:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XH1Cfju6MZ640Pe1FCbEa5SrQlXLpmK1upziHCywFic=;
        b=OHD0cAmDBhQ2RqCCjuBtMPIgsSePFbrE3yBk1EslH4rYA/yRYzbC/D6qaez3YrvM1d
         K02U3qmsm9CPXjK1dY3V2lSmFOgBnbCTINoBy2kVL6eYkxHO8hsMAQ3CFHMVQ031iz9h
         wX1mT681ySJzsKXUKv3iBGjQ5AIzAuYG5hCI6xVJEg3mz6QHh3SowSdKo0mfFpXsd//F
         5JiVpfKTm1DsHXBtCQe0atEGVIOd9mqKV+y0R1jNLaj85zK0uPnV1Fckm3jRUAW5JKBw
         +M+OkPmUl9QXeeKG92NE8u19ztvShhPoCHpUYRnP6iQb2j2X3W+1+r3iLPgnNVuk9VpE
         Ak/g==
X-Gm-Message-State: AOAM53036z17/LjYQ7oj/CyUGKX7iTGMb+mV73+SGdxF1UQm5hX4qkje
        nbW2ykquSAz1P0FevTHCFQHAeavuTL3na9aJeEbN4oohlAKLyPxvYere2miZkFVNLSEXXfiTGVf
        8C3aa3SSkFOFpd50xnkOkcTTZ
X-Received: by 2002:adf:d4ce:: with SMTP id w14mr3921288wrk.142.1604592760219;
        Thu, 05 Nov 2020 08:12:40 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy2CzJJV1ypEfEvxQQL+OiRx3bJ2Jl36Tk3llwe0igl1W0mD/Ql63aFdxrxXcT29tHk9YicIQ==
X-Received: by 2002:adf:d4ce:: with SMTP id w14mr3921254wrk.142.1604592759901;
        Thu, 05 Nov 2020 08:12:39 -0800 (PST)
Received: from localhost.localdomain ([151.29.191.209])
        by smtp.gmail.com with ESMTPSA id c17sm3104308wml.14.2020.11.05.08.12.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 08:12:39 -0800 (PST)
Date:   Thu, 5 Nov 2020 17:12:36 +0100
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     peterz@infradead.org, mingo@redhat.com, glenn@aurora.tech,
        linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        tglx@linutronix.de, luca.abeni@santannapisa.it,
        tommaso.cucinotta@santannapisa.it, bristot@redhat.com
Subject: Re: [PATCH] sched/deadline: Fix priority inheritance with multiple
 scheduling classes
Message-ID: <20201105161236.GA5522@localhost.localdomain>
References: <20201105075021.1302386-1-juri.lelli@redhat.com>
 <jhja6vvztvk.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <jhja6vvztvk.mognet@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Valentin,

On 05/11/20 15:49, Valentin Schneider wrote:
> 
> Hi Juri,
> 
> On 05/11/20 07:50, Juri Lelli wrote:
> > He also provided a simple reproducer creating the situation below:
> >
> >  So the execution order of locking steps are the following
> >  (N1 and N2 are non-deadline tasks. D1 is a deadline task. M1 and M2
> >  are mutexes that are enabled * with priority inheritance.)
> >
> >  Time moves forward as this timeline goes down:
> >
> >  N1              N2               D1
> >  |               |                |
> >  |               |                |
> >  Lock(M1)        |                |
> >  |               |                |
> >  |             Lock(M2)           |
> >  |               |                |
> >  |               |              Lock(M2)
> >  |               |                |
> >  |             Lock(M1)           |
> >  |             (!!bug triggered!) |
> >
> > Daniel reported a similar situation as well, by just letting ksoftirqd
> > run with DEADLINE (and eventually block on a mutex).
> >
> > Problem is that boosted entities (Priority Inheritance) use static
> > DEADLINE parameters of the top priority waiter. However, there might be
> > cases where top waiter could be a non-DEADLINE entity that is currently
> > boosted by a DEADLINE entity from a different lock chain (i.e., nested
> > priority chains involving entities of non-DEADLINE classes). In this
> > case, top waiter static DEADLINE parameters could be null (initialized
> > to 0 at fork()) and replenish_dl_entity() would hit a BUG().
> >
> 
> IIUC, rt_mutex_get_top_task(N1) == N2, and N2->dl->deadline = 0, which
> makes enqueue_task_dl() unhappy. And that happens because, unlike p->prio,
> DL parameters aren't properly propagated through the chain(s).

Yep. Replenishment as well, as it's going to find dl_runtime == 0.

> > Fix this by keeping track of the original donor and using its parameters
> > when a task is boosted.
> >
> > Reported-by: Glenn Elliott <glenn@aurora.tech>
> > Reported-by: Daniel Bristot de Oliveira <bristot@redhat.com>
> > Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
> >
> > ---
> >
> > This is actually a v2 attempt (didn't keep $SUBJECT since it's quite
> > different than v1 [1]) to fix this problem.
> >
> > v1 was admittedly pretty ugly. Hope this looks slightly better (even
> > though there is of course overhead associated to the additional
> > pointer).
> >
> > Again, the proper way to fix this is by proxy execution. But, I don't
> > think we are yet there and this problem needs a quick band-aid.
> >
> > One could probably also think to complicate the present approach and
> > actually perform accounting using donor's dynamic parameters, but I fear
> > it would be of little benefit since it would still bring all the
> > problems associated to affinities. So, I'd propose let's try to fix all
> > this properly with proxy and just avoid crashes in the meantime.
> >
> 
> For my own sake, what affinity problems are you thinking of?
> 
> With proxy exec we have this "funny" dance of shoving the entire blocked-on
> chain on a single runqueue to get the right selection out of
> pick_next_task(), and that needs to deal with affinity (i.e. move the task
> back to a sensible rq once it becomes runnable).
> 
> With the current PI, the waiting tasks are blocked and enqueued in the
> pi_waiters tree, so as I see it affinity shouldn't matter; what am I
> missing / not seeing? Is that related to bandwidth handling?

Think we might break admission control checks if donor and bosted are,
for example, on different exclusive sets of CPUs. Guess that is a
problem with proxy as well, though. As said in the comment above, this
is unfortunately not much more than a band-aid. Hoping we can buy us
some time and fix it properly with proxy.

> > 1 - 20191112075056.19971-1-juri.lelli@redhat.com
> > ---
> >  include/linux/sched.h   |  9 +++++
> >  kernel/sched/core.c     | 13 ++++++--
> >  kernel/sched/deadline.c | 74 ++++++++++++++++++++---------------------
> >  3 files changed, 56 insertions(+), 40 deletions(-)
> >
> > diff --git a/include/linux/sched.h b/include/linux/sched.h
> > index 063cd120b459..db29ab492181 100644
> > --- a/include/linux/sched.h
> > +++ b/include/linux/sched.h
> > @@ -571,6 +571,15 @@ struct sched_dl_entity {
> >        * time.
> >        */
> >       struct hrtimer inactive_timer;
> > +
> > +#ifdef CONFIG_RT_MUTEXES
> > +	/*
> > +	 * Priority Inheritance. When a DEADLINE scheduling entity is boosted
> > +	 * pi_se points to the donor, otherwise points to the dl_se it belongs
> > +	 * to (the original one/itself).
> > +	 */
> > +	struct sched_dl_entity *pi_se;
> > +#endif
> >  };
> >
> >  #ifdef CONFIG_UCLAMP_TASK
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index 6f533bb7d3b9..e10aba6c363d 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -4908,19 +4908,26 @@ void rt_mutex_setprio(struct task_struct *p, struct task_struct *pi_task)
> >                   (pi_task && dl_prio(pi_task->prio) &&
> >                    dl_entity_preempt(&pi_task->dl, &p->dl))) {
> >                       p->dl.dl_boosted = 1;
> > +			p->dl.pi_se = pi_task->dl.pi_se;
> >                       queue_flag |= ENQUEUE_REPLENISH;
> > -		} else
> > +		} else {
> >                       p->dl.dl_boosted = 0;
> > +			p->dl.pi_se = &p->dl;
> > +		}
> >               p->sched_class = &dl_sched_class;
> >       } else if (rt_prio(prio)) {
> > -		if (dl_prio(oldprio))
> > +		if (dl_prio(oldprio)) {
> >                       p->dl.dl_boosted = 0;
> > +			p->dl.pi_se = &p->dl;
> > +		}
> >               if (oldprio < prio)
> >                       queue_flag |= ENQUEUE_HEAD;
> >               p->sched_class = &rt_sched_class;
> >       } else {
> > -		if (dl_prio(oldprio))
> > +		if (dl_prio(oldprio)) {
> >                       p->dl.dl_boosted = 0;
> > +			p->dl.pi_se = &p->dl;
> > +		}
> 
> With this change, do we still need sched_dl_entity.dl_boosted? AIUI this
> could become
> 
>   bool is_dl_boosted(struct sched_dl_entity *dl_se)
>   {
>           return pi_of(dl_se) != dl_se;
>   }

Makes sense to me. I'll add this change as a separate patch if the rest
makes sense to people as well. :-)

Thanks for the quick review!

Best,
Juri

