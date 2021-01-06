Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41C222EC04C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 16:22:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbhAFPVu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 10:21:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726063AbhAFPVu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 10:21:50 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80E99C061357
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jan 2021 07:21:09 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id h22so7393175lfu.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jan 2021 07:21:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gdG8ev5VUgJKwI134A2vq3AaYrSaHx4yRCx+2qIFUl4=;
        b=tg9LWmIPmluAnbwsG+xw/GsUJMH7THiNyd1A8YpdX0ATKCMGtKfXAr6kYJboPH8vTw
         dpwgWnQ+7Ru4RyRcQnOJuatb03Z+XpxMO54B2kFALkZeEXzvHLtGBPRbgQNUEFbwNQc0
         LvJTtH/CA/Mt+u+p9l5AWDHVQdyFzd6S/g/ySltelXSLZJwQ7VVoNxMveUus8aSAYN8f
         i6tcAe8NJpp07DetXwrlXSm1Y1BN8zYuZeTSpWgCOimMNnu5LwSXOGuV3KxkPrK8VeMe
         kBLZ4aPJTkQ7jGhQasHA04xyUHEtZxxsCeKc3ekvbgepLmJ6uv7BZTdJVpyauhm0mQU3
         xXsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gdG8ev5VUgJKwI134A2vq3AaYrSaHx4yRCx+2qIFUl4=;
        b=C+crzwnsQVFOiZBl5u2ijU6QCA9Z8i1tp7eSiYncdSzEBjmimo9gF1vdzObaBDKm+B
         b8qD1+dnHmx4RvKtsjpuT28BzSBHTgY5dKfPlTR3+9VHRd99wcfioAmhGhzSpm1MpSVJ
         nuFvKn9M6/aE7cfwdiBHDfiqBbuT6YOGGVjpTS1frqrzA7zNAlSp9/Ob22M20SDqGdH0
         2tHttYWqg3ZCJ7ify6wEdhcr0NUO13cMQD6yYfglvbX4Os3smKyR50o2wVgEapW3SyJf
         EyvAm63aOAWpb0Tj5/CdxhAsTswy5IlL+6QbmZREASVC743micB9AtOVHskbQMYS/CJo
         qGqg==
X-Gm-Message-State: AOAM5324JZy0Nd28NrWCQdc+qfXADJsQD3iEeGgoTDKgtIEj9bOfXFHn
        MHz4NBwuhW0UuzugK5harbtjQnVh5JajR3Ewf6wu2Q==
X-Google-Smtp-Source: ABdhPJx7RVA+gBwbXHGDuykVUHK0JvKJ3LoAumV/YKliqDofAWLgCj7Q9KNKSNzhAwzn9kv8Q0ixP1hsiHu34UvcqZk=
X-Received: by 2002:a19:be14:: with SMTP id o20mr2318784lff.305.1609946467958;
 Wed, 06 Jan 2021 07:21:07 -0800 (PST)
MIME-Version: 1.0
References: <20210106133419.2971-1-vincent.guittot@linaro.org>
 <20210106133419.2971-3-vincent.guittot@linaro.org> <X/XSH7Qv58pSpi95@hirez.programming.kicks-ass.net>
In-Reply-To: <X/XSH7Qv58pSpi95@hirez.programming.kicks-ass.net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 6 Jan 2021 16:20:55 +0100
Message-ID: <CAKfTPtB+Nrk6ST9c-OacdW3zh07VC6M8GqvgNXzQ=KqucBrqQQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] sched/fair: don't set LBF_ALL_PINNED unnecessarily
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Jan 2021 at 16:10, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Wed, Jan 06, 2021 at 02:34:18PM +0100, Vincent Guittot wrote:
> > Setting LBF_ALL_PINNED during active load balance is only valid when there
> > is only 1 running task on the rq otherwise this ends up increasing the
> > balance interval whereas other tasks could migrate after the next interval
> > once they become cache-cold as an example.
> >
> > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > ---
> >  kernel/sched/fair.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 5428b8723e61..69a455113b10 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -9759,7 +9759,8 @@ static int load_balance(int this_cpu, struct rq *this_rq,
> >                       if (!cpumask_test_cpu(this_cpu, busiest->curr->cpus_ptr)) {
> >                               raw_spin_unlock_irqrestore(&busiest->lock,
> >                                                           flags);
> > -                             env.flags |= LBF_ALL_PINNED;
> > +                             if (busiest->nr_running == 1)
> > +                                     env.flags |= LBF_ALL_PINNED;
> >                               goto out_one_pinned;
> >                       }
>
> Hmm.. that wasn't the intention. It's entirely possible to have multiple
> tasks pinned.

But LBF_ALL_PINNED is already set in this case

>
> ISTR we set all-pinned and then clear it in can_migrate_task() when we
> actually find a task that can be moved to the destination CPU. That's a
> construct that works perfectly fine with multiple tasks.

I agree with you.

This case here is :
we have 2 tasks TA and TB on the rq.
The waiting one TB can't migrate for a reason other than the pinned case.
We decide to start the active migration on the running  TA task but TA
is pinned.
In this case we are not in the all pinned case.

We are in the all pinned case, only if the running task TA is the only
runnable task of the rq

>
>
