Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A831A2F10C7
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 12:05:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729592AbhAKLFN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 06:05:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728202AbhAKLFM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 06:05:12 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9A84C061795
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 03:04:31 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id y22so3053298ljn.9
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 03:04:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4R1fwsSrwLjmh8ZdiXQ4lQdTh0Itj/J0SBLUHd0+SiA=;
        b=qMvuHyurfgY9QKjyssRUhiDtzSHNvm4IKqx7lbpCiPV0MetyyxLN2y9eKLyt/BZJFx
         53c+TQY91NktGJH8M9kQ7kKWLv/8YUN+3zJS6y/XAOpSl/RyRqRymdhqrlXzuAxmv5rU
         oTtZuSX3C66mVmfEVUqXeOmjdDgyhN4Kv7Krl0QnhZVLxqWR/KcoPVdcB6VzNT2YjA4b
         y5cTZVCCFPV1qG2mzStkmEDmRlD2U8DnfymIWt+3eVXwhEvYcPJShK9zEdvsm/IfyIWc
         sC8t8tfuJ9cm9zCmw5ySsJRSXtk8O7yyB/ci2/LqZ07CNPZKEqaZpUK5vgD+0KhZY9/I
         Ze7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4R1fwsSrwLjmh8ZdiXQ4lQdTh0Itj/J0SBLUHd0+SiA=;
        b=a/sVV5q2qzKt4a8739XiEXLeYMIUjyDXyPSgXBVTHtlDiOgfQq66kwczLxOOnq9P6W
         WqgMwkANt+8F8g0xu5Fxq9B8lVcnZudmPaHmjGXNdHB1Q7JH9DEsszdxN6ZRvq+iqOy2
         RHYcfLxFioNd8vG/Pzwnn+/Mi3LACbKtUlye1EqGN+FqzqvcSbOffh7Zmwnc7n/L1gMW
         hpYuwHATw/A37PwiFhkWMg7oRtalDnT7eGlaIC/7DycwwbJYEM0pF/1RNz5+wEg8ql5r
         WBRiAvr8n1ok+8C8FK56/2EbwikKvnRqoYfHFUYhrn2sdJ5TQmBGfT2IbQEfAJrs7UaY
         Hlwg==
X-Gm-Message-State: AOAM533SIsLnYV6BJUyAqN8phNiy3yNZFXQMIywVHpgL447gse4XG4L1
        H0nCAS7F9EXeTk/dF0QSdasWXJ6hjPgW4PpgSmkhzw==
X-Google-Smtp-Source: ABdhPJz4o+sFD7KNbLo4gjvMf1DcoJq67UGcOZpEwMu3dQXc1XrcHy/WsvjXa8LYGK9Nr3RtwomYfdR8xocsP1l7vRE=
X-Received: by 2002:a2e:7613:: with SMTP id r19mr7611167ljc.284.1610363070347;
 Mon, 11 Jan 2021 03:04:30 -0800 (PST)
MIME-Version: 1.0
References: <1608710968-31475-1-git-send-email-ultrachin@163.com>
 <CAKfTPtA9zdU76Q6AyjB8_gqvAm8SP_N0rJuydQdNFbDAKSb2jw@mail.gmail.com> <1fefea2e.70bf.176f08d9fae.Coremail.ultrachin@163.com>
In-Reply-To: <1fefea2e.70bf.176f08d9fae.Coremail.ultrachin@163.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 11 Jan 2021 12:04:19 +0100
Message-ID: <CAKfTPtDWARbx=xqwr47iFkEMVo7=+5_o_gMX+h=gAcXZP341oA@mail.gmail.com>
Subject: Re: [PATCH] sched: pull tasks when CPU is about to run SCHED_IDLE tasks
To:     chin <ultrachin@163.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        heddchen@tencent.com,
        =?UTF-8?B?eGlhb2dnY2hlbijpmYjlsI/lhYkp?= <xiaoggchen@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Jan 2021 at 09:27, chin <ultrachin@163.com> wrote:
>
>
> At 2020-12-23 19:30:26, "Vincent Guittot" <vincent.guittot@linaro.org> wrote:
> >On Wed, 23 Dec 2020 at 09:32, <ultrachin@163.com> wrote:
> >>
> >> From: Chen Xiaoguang <xiaoggchen@tencent.com>
> >>
> >> Before a CPU switches from running SCHED_NORMAL task to
> >> SCHED_IDLE task, trying to pull SCHED_NORMAL tasks from other
> >
> >Could you explain more in detail why you only care about this use case
>
> >in particular and not the general case?
>
>
> We want to run online tasks using SCHED_NORMAL policy and offline tasks
> using SCHED_IDLE policy. The online tasks and the offline tasks run in
> the same computer in order to use the computer efficiently.
> The online tasks are in sleep in most times but should responce soon once
> wake up. The offline tasks are in low priority and will run only when no online
> tasks.
>
> The online tasks are more important than the offline tasks and are latency
> sensitive we should make sure the online tasks preempt the offline tasks
> as soon as possilbe while there are online tasks waiting to run.
> So in our situation we hope the SCHED_NORMAL to run if has any.
>
> Let's assume we have 2 CPUs,
> In CPU1 we got 2 SCHED_NORMAL tasks.
> in CPU2 we got 1 SCHED_NORMAL task and 2 SCHED_IDLE tasks.
>
>              CPU1                      CPU2
>         curr       rq1            curr          rq2
>       +------+ | +------+       +------+ | +----+ +----+
> t0    |NORMAL| | |NORMAL|       |NORMAL| | |IDLE| |IDLE|
>       +------+ | +------+       +------+ | +----+ +----+
>
>                                  NORMAL exits or blocked
>       +------+ | +------+                | +----+ +----+
> t1    |NORMAL| | |NORMAL|                | |IDLE| |IDLE|
>       +------+ | +------+                | +----+ +----+
>
>                                  pick_next_task_fair
>       +------+ | +------+         +----+ | +----+
> t2    |NORMAL| | |NORMAL|         |IDLE| | |IDLE|
>       +------+ | +------+         +----+ | +----+
>
>                                  SCHED_IDLE running
> t3    +------+ | +------+        +----+  | +----+
>       |NORMAL| | |NORMAL|        |IDLE|  | |IDLE|
>       +------+ | +------+        +----+  | +----+
>
>                                  run_rebalance_domains
>       +------+ |                +------+ | +----+ +----+
> t4    |NORMAL| |                |NORMAL| | |IDLE| |IDLE|
>       +------+ |                +------+ | +----+ +----+
>
> As we can see
> t1: NORMAL task in CPU2 exits or blocked
> t2: CPU2 pick_next_task_fair would pick a SCHED_IDLE to run while
> another SCHED_NORMAL in rq1 is waiting.
> t3: SCHED_IDLE run in CPU2 while a SCHED_NORMAL wait in CPU1.
> t4: after a short time, periodic load_balance triggerd and pull
> SCHED_NORMAL in rq1 to rq2, and SCHED_NORMAL likely preempts SCHED_IDLE.
>
> In this scenario, SCHED_IDLE is running while SCHED_NORMAL is waiting to run.
> The latency of this SCHED_NORMAL will be high which is not acceptble.
>
> Do a load_balance before running the SCHED_IDLE may fix this problem.
>
> This patch works as below:
>
>              CPU1                      CPU2
>         curr       rq1            curr          rq2
>       +------+ | +------+       +------+ | +----+ +----+
> t0    |NORMAL| | |NORMAL|       |NORMAL| | |IDLE| |IDLE|
>       +------+ | +------+       +------+ | +----+ +----+
>
>                                  NORMAL exits or blocked
>       +------+ | +------+                | +----+ +----+
> t1    |NORMAL| | |NORMAL|                | |IDLE| |IDLE|
>       +------+ | +------+                | +----+ +----+
>
> t2                            pick_next_task_fair (all se are SCHED_IDLE)
>
>                                  newidle_balance
>       +------+ |                 +------+ | +----+ +----+
> t3    |NORMAL| |                 |NORMAL| | |IDLE| |IDLE|
>       +------+ |                 +------+ | +----+ +----+
>
>
> t1: NORMAL task in CPU2 exits or blocked
> t2: pick_next_task_fair check all se in rbtree are SCHED_IDLE and calls
> newidle_balance who tries to pull a SCHED_NORMAL(if has).
> t3: pick_next_task_fair would pick a SCHED_NORMAL to run instead of
> SCHED_IDLE(likely).
>
> >
> >> CPU by doing load_balance first.
> >>
> >> Signed-off-by: Chen Xiaoguang <xiaoggchen@tencent.com>
> >> Signed-off-by: Chen He <heddchen@tencent.com>
> >> ---
> >>  kernel/sched/fair.c | 5 +++++
> >>  1 file changed, 5 insertions(+)
> >>
> >> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> >> index ae7ceba..0a26132 100644
> >> --- a/kernel/sched/fair.c
> >> +++ b/kernel/sched/fair.c
> >> @@ -7004,6 +7004,11 @@ struct task_struct *
> >>         struct task_struct *p;
> >>         int new_tasks;
> >>
> >> +       if (prev &&
> >> +           fair_policy(prev->policy) &&
> >
> >Why do you need a prev and fair task  ? You seem to target the special
> >case of pick_next_task  but in this case why not only testing rf!=null
> > to make sure to not return immediately after jumping to the idle
>
> >label?
> We just want to do load_balance only when CPU switches from SCHED_NORMAL
> to SCHED_IDLE.
> If not check prev, when the running tasks are all SCHED_IDLE, we would
> do newidle_balance everytime in pick_next_task_fair, it makes no sense
> and kind of wasting.

I agree that calling newidle_balance every time pick_next_task_fair is
called when there are only sched_idle tasks is useless.
But you also have to take into account cases where there was another
class of task running on the cpu like RT one. In your example above,
if you replace the normal task on CPU2 by a RT task, you still want to
pick the normal task on CPU1 once RT task goes to sleep.

Another point that you will have to consider the impact on
rq->idle_stamp because newidle_balance is assumed to be called before
going idle which is not the case anymore with your use case

>
> >
>
> >Also why not doing that for default case too ? i.e. balance_fair() ?
> You are right, if you think this scenario makes sense, we will send a
> refined patch soon :-)
>
> >
> >> +           sched_idle_cpu(rq->cpu))
> >> +               goto idle;
> >> +
> >>  again:
> >>         if (!sched_fair_runnable(rq))
> >>                 goto idle;
> >> --
> >> 1.8.3.1
> >>
> >>
