Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BA372F0ED8
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 10:17:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728266AbhAKJPh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 04:15:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728099AbhAKJPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 04:15:37 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFE09C061786
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 01:14:56 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id b5so10187788pjl.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 01:14:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=f5WDa3fYBRa8jJhxj1MyxUq10Ucw4qhKps7XATdOsUQ=;
        b=JAKlD+E1qkbf95NPOb9dvkH6vieyTDCQtQgNxJdj7IHPmhh5w/lnT2nMQ/54bJrjW1
         PyPsmDqJiSRFIogTaWIP01M7BNd6RtaVaQTAju5RX3UZ11hg5MSSFLIe3eSETmC7IWgC
         MQtYrWdLR6mK5YplFqZdhvGsWuJiAwjNcO+8RVZvxKsARXsD/Lroom06sKuKwJHPx6TX
         kSP7fGVaSDowo0QyB2x/oj3uGSxcDjlIdWVk51IuDhOaVxMxL4Wil3I6sdYYRJNRtVK0
         MC8gk2VVaCPJvOsUaZU5BjMxK1QRBR7KAojCWJ4JqYF2as2shrvHRi3jw8M0fXzi9FHY
         CU2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=f5WDa3fYBRa8jJhxj1MyxUq10Ucw4qhKps7XATdOsUQ=;
        b=Dz/3gVSzSiKsNcv12R2nR5uVRLNZgPinWbVvjBqXa1fmATg208ZCM+t78u41ZiAAyN
         ggBtIwXGiREwTY8F50gpHeaLdDZue9snBzxfyXXrdOz+q7elBji/46LtQAeCl1Bl+b1t
         V/Tq3+0KwgFXU4bWLSYLTeRwQRqSWbJ/Lt6255B3qzW72m0JxVDyD7T+dR8HvviodtSQ
         Nzda6Zff5/oHi31MhcueQzKtjp7PEWKMkB+j5z5OHTVlCMiUYMkX68kbsxQpOvRC6C2b
         uUASM6UgigCToPeundqFxIbKTNg8jpVWUL3CSKCST8yOSTwKBYyBPtnJFeHBquQGqzg0
         Z2Qg==
X-Gm-Message-State: AOAM530PNI7ZRMdSwiBfXdS/I2rh2Ul7wIuWI/Dk+3JdENTzgf0uphF+
        ubvNQjb+IhaX+W64pOGrOBs=
X-Google-Smtp-Source: ABdhPJx5lVfb3OnzxEhqFVSDJ9y1YhgUnOFjmQXwxzU+Q92FCwgyV3kCY8E/W7/9P6WXEgAHjkiZ+w==
X-Received: by 2002:a17:902:8687:b029:dc:2a2c:e99b with SMTP id g7-20020a1709028687b02900dc2a2ce99bmr15412252plo.37.1610356496311;
        Mon, 11 Jan 2021 01:14:56 -0800 (PST)
Received: from localhost ([203.205.141.39])
        by smtp.gmail.com with ESMTPSA id z6sm18466636pfj.22.2021.01.11.01.14.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Jan 2021 01:14:55 -0800 (PST)
From:   He Chen <chenhe.dev@gmail.com>
X-Google-Original-From: He Chen <chenhe.dev@mail.com>
Date:   Mon, 11 Jan 2021 17:15:08 +0800
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        He Chen <heddchen@tencent.com>, He Chen <chenhe.dev@gmail.com>,
        Xiaoguang Chen <xiaoggchen@tencent.com>,
        Xiaoguang Chen <ultrachin@163.com>
Subject: Re: [PATCH] sched: pull tasks when CPU is about to run SCHED_IDLE
 tasks
Message-ID: <20210111091508.GA24561@VM_192_20_centos>
Mail-Followup-To: Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        He Chen <heddchen@tencent.com>, He Chen <chenhe.dev@gmail.com>,
        Xiaoguang Chen <xiaoggchen@tencent.com>,
        Xiaoguang Chen <ultrachin@163.com>
References: <1608710968-31475-1-git-send-email-ultrachin@163.com>
 <CAKfTPtA9zdU76Q6AyjB8_gqvAm8SP_N0rJuydQdNFbDAKSb2jw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtA9zdU76Q6AyjB8_gqvAm8SP_N0rJuydQdNFbDAKSb2jw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 23, 2020 at 12:30:26PM +0100, Vincent Guittot wrote:
> On Wed, 23 Dec 2020 at 09:32, <ultrachin@163.com> wrote:
> >
> > From: Chen Xiaoguang <xiaoggchen@tencent.com>
> >
> > Before a CPU switches from running SCHED_NORMAL task to
> > SCHED_IDLE task, trying to pull SCHED_NORMAL tasks from other
> 
> Could you explain more in detail why you only care about this use case
> in particular and not the general case?
> 

We want to run online tasks using SCHED_NORMAL policy and offline tasks
using SCHED_IDLE policy. The online tasks and the offline tasks run in
the same computer in order to use the computer efficiently.
The online tasks are in sleep in most times but should responce soon
once
wake up. The offline tasks are in low priority and will run only when no
online
tasks.

The online tasks are more important than the offline tasks and are
latency
sensitive we should make sure the online tasks preempt the offline tasks
as soon as possilbe while there are online tasks waiting to run.
So in our situation we hope the SCHED_NORMAL to run if has any.

Let's assume we have 2 CPUs,
In CPU1 we got 2 SCHED_NORMAL tasks.
in CPU2 we got 1 SCHED_NORMAL task and 2 SCHED_IDLE tasks.

             CPU1                      CPU2
        curr       rq1            curr          rq2
      +------+ | +------+       +------+ | +----+ +----+
t0    |NORMAL| | |NORMAL|       |NORMAL| | |IDLE| |IDLE|
      +------+ | +------+       +------+ | +----+ +----+

                                 NORMAL exits or blocked
      +------+ | +------+                | +----+ +----+
t1    |NORMAL| | |NORMAL|                | |IDLE| |IDLE|
      +------+ | +------+                | +----+ +----+

                                 pick_next_task_fair
      +------+ | +------+         +----+ | +----+
t2    |NORMAL| | |NORMAL|         |IDLE| | |IDLE|
      +------+ | +------+         +----+ | +----+

                                 SCHED_IDLE running
t3    +------+ | +------+        +----+  | +----+
      |NORMAL| | |NORMAL|        |IDLE|  | |IDLE|
      +------+ | +------+        +----+  | +----+
                 
                                 run_rebalance_domains
      +------+ |                +------+ | +----+ +----+
t4    |NORMAL| |                |NORMAL| | |IDLE| |IDLE|
      +------+ |                +------+ | +----+ +----+

As we can see
t1: NORMAL task in CPU2 exits or blocked
t2: CPU2 pick_next_task_fair would pick a SCHED_IDLE to run while
another SCHED_NORMAL in rq1 is waiting. 
t3: SCHED_IDLE run in CPU2 while a SCHED_NORMAL wait in CPU1.
t4: after a short time, periodic load_balance triggerd and pull
SCHED_NORMAL in rq1 to rq2, and SCHED_NORMAL likely preempts SCHED_IDLE.

In this scenario, SCHED_IDLE is running while SCHED_NORMAL is waiting to
run.
The latency of this SCHED_NORMAL will be high which is not acceptble.

Do a load_balance before running the SCHED_IDLE may fix this problem.

This patch works as below:

             CPU1                      CPU2
        curr       rq1            curr          rq2
      +------+ | +------+       +------+ | +----+ +----+
t0    |NORMAL| | |NORMAL|       |NORMAL| | |IDLE| |IDLE|
      +------+ | +------+       +------+ | +----+ +----+

                                 NORMAL exits or blocked
      +------+ | +------+                | +----+ +----+
t1    |NORMAL| | |NORMAL|                | |IDLE| |IDLE|
      +------+ | +------+                | +----+ +----+

t2                            pick_next_task_fair (all se are
SCHED_IDLE)

                                 newidle_balance
      +------+ |                 +------+ | +----+ +----+
t3    |NORMAL| |                 |NORMAL| | |IDLE| |IDLE|
      +------+ |                 +------+ | +----+ +----+


t1: NORMAL task in CPU2 exits or blocked
t2: pick_next_task_fair check all se in rbtree are SCHED_IDLE and calls
newidle_balance who tries to pull a SCHED_NORMAL(if has).
t3: pick_next_task_fair would pick a SCHED_NORMAL to run instead of
SCHED_IDLE(likely).

> > CPU by doing load_balance first.
> >
> > Signed-off-by: Chen Xiaoguang <xiaoggchen@tencent.com>
> > Signed-off-by: Chen He <heddchen@tencent.com>
> > ---
> >  kernel/sched/fair.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index ae7ceba..0a26132 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -7004,6 +7004,11 @@ struct task_struct *
> >         struct task_struct *p;
> >         int new_tasks;
> >
> > +       if (prev &&
> > +           fair_policy(prev->policy) &&
> 
> Why do you need a prev and fair task  ? You seem to target the special
> case of pick_next_task  but in this case why not only testing rf!=null
>  to make sure to not return immediately after jumping to the idle
> label?
> 

We just want to do load_balance only when CPU switches from SCHED_NORMAL
to SCHED_IDLE.
If not check prev, when the running tasks are all SCHED_IDLE, we would
do newidle_balance everytime in pick_next_task_fair, it makes no sense
and kind of wasting.

> Also why not doing that for default case too ? i.e. balance_fair() ?

You are right, if you think this scenario makes sense, we will send a
refined patch soon :-)

Thanks,
-He

> 
> > +           sched_idle_cpu(rq->cpu))
> > +               goto idle;
> > +
> >  again:
> >         if (!sched_fair_runnable(rq))
> >                 goto idle;
> > --
> > 1.8.3.1
> >
> >
> 
