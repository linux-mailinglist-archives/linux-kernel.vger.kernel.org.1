Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D7112F29DE
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 09:20:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392303AbhALITp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 03:19:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732825AbhALITo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 03:19:44 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BC05C061786
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 00:19:04 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id m13so1842145ljo.11
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 00:19:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oEYwmc3G8F2SI0zKsqUFCRO5ynw/Nc8fZS+jyp0Vcxk=;
        b=smN0x4+EfNbQcST1EEmM5ryTTNIVW++c5Gfzkm8WxwfJWZE8iCKRq2f0NxuS27+4sP
         yaB+qzAASLJdsMAej1Gu2V87qS5TWeo3t0Y6oyQho6szn5M74IQDkd39LND6JLWOchnt
         iXVmHVYE25+gLTDXzxQuLYtWFdu54dN9PKKX/rMGJWsn1aMMw9NKjmud8R0hEZ7vxsI9
         4d7JOI/e4qlWo9aVxjO+e8EvdWekCtDIH+6WM6VMOkjrDeTTFoD6snuMlDs/sBtzcz+F
         2dGrVLB5IwWIgzy0b+HZWaBXekdVCq9/vSAZbRU0/VbtQgraVUZVJu0fqu98lL/YDkoR
         rnjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oEYwmc3G8F2SI0zKsqUFCRO5ynw/Nc8fZS+jyp0Vcxk=;
        b=Uq8NBIzoiAp9CpjXiPZ5KCjpRIsd8F0iN4mF/jvOA/VXhdFcu7iQNVFHxkx7l9thgG
         ZyuRCQ3/KBhxAXhoITEwW/tjHdTrmbhnieYjuX/8eqUi1Rc+hOqVKcbvIw9Kfq0C4Qlv
         ieXY6s+SF+VTodPIKWNWGH3L63nrVlLgVYG0AIrB8ruGq/N9plVZARvxzIxUv18FSzl3
         ZEjFVWweq/mO73Tko4SHkL2OQH2F/IRUXr3nUO9GqVo8E2Sxw9NlMEfEfFplPXH69FL7
         2dsPibCiU7/73oI4PsEMi3JTJuD+MKiQLF/1UnqxfPJXBDgWrdQsXLaEAzGSucE295A5
         bhPg==
X-Gm-Message-State: AOAM5313TBZmXsJHwg/aZ9s1VXU8aR5eyjTsVigv3V3l7o+ZAC4x31TW
        GaMcvtnk80QAfKH+ibp5f100KxY9t2rwlGI6G5H/0w==
X-Google-Smtp-Source: ABdhPJyM8XVzWgLsU+yIzNScNsXLTtOCVV9yYd+ZGmXQo9n5zleiOPRH6ExuAg+FXyxdpeoemFQP9N+uXaqoV/4Dw6o=
X-Received: by 2002:a05:651c:20b:: with SMTP id y11mr1443010ljn.176.1610439542317;
 Tue, 12 Jan 2021 00:19:02 -0800 (PST)
MIME-Version: 1.0
References: <1608710968-31475-1-git-send-email-ultrachin@163.com>
 <CAKfTPtA9zdU76Q6AyjB8_gqvAm8SP_N0rJuydQdNFbDAKSb2jw@mail.gmail.com>
 <1fefea2e.70bf.176f08d9fae.Coremail.ultrachin@163.com> <CAKfTPtDWARbx=xqwr47iFkEMVo7=+5_o_gMX+h=gAcXZP341oA@mail.gmail.com>
 <61e22917.538b.176f56231f6.Coremail.ultrachin@163.com>
In-Reply-To: <61e22917.538b.176f56231f6.Coremail.ultrachin@163.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 12 Jan 2021 09:18:51 +0100
Message-ID: <CAKfTPtCSra_kfncR7J_7ona+8MoO0ZX8uTEXvZ7PU7C0pYiM5w@mail.gmail.com>
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

On Tue, 12 Jan 2021 at 07:59, chin <ultrachin@163.com> wrote:
>
>
>
>
> At 2021-01-11 19:04:19, "Vincent Guittot" <vincent.guittot@linaro.org> wrote:
> >On Mon, 11 Jan 2021 at 09:27, chin <ultrachin@163.com> wrote:
> >>
> >>
> >> At 2020-12-23 19:30:26, "Vincent Guittot" <vincent.guittot@linaro.org> wrote:
> >> >On Wed, 23 Dec 2020 at 09:32, <ultrachin@163.com> wrote:
> >> >>
> >> >> From: Chen Xiaoguang <xiaoggchen@tencent.com>
> >> >>
> >> >> Before a CPU switches from running SCHED_NORMAL task to
> >> >> SCHED_IDLE task, trying to pull SCHED_NORMAL tasks from other
> >> >
> >> >Could you explain more in detail why you only care about this use case
> >>
> >> >in particular and not the general case?
> >>
> >>
> >> We want to run online tasks using SCHED_NORMAL policy and offline tasks
> >> using SCHED_IDLE policy. The online tasks and the offline tasks run in
> >> the same computer in order to use the computer efficiently.
> >> The online tasks are in sleep in most times but should responce soon once
> >> wake up. The offline tasks are in low priority and will run only when no online
> >> tasks.
> >>
> >> The online tasks are more important than the offline tasks and are latency
> >> sensitive we should make sure the online tasks preempt the offline tasks
> >> as soon as possilbe while there are online tasks waiting to run.
> >> So in our situation we hope the SCHED_NORMAL to run if has any.
> >>
> >> Let's assume we have 2 CPUs,
> >> In CPU1 we got 2 SCHED_NORMAL tasks.
> >> in CPU2 we got 1 SCHED_NORMAL task and 2 SCHED_IDLE tasks.
> >>
> >>              CPU1                      CPU2
> >>         curr       rq1            curr          rq2
> >>       +------+ | +------+       +------+ | +----+ +----+
> >> t0    |NORMAL| | |NORMAL|       |NORMAL| | |IDLE| |IDLE|
> >>       +------+ | +------+       +------+ | +----+ +----+
> >>
> >>                                  NORMAL exits or blocked
> >>       +------+ | +------+                | +----+ +----+
> >> t1    |NORMAL| | |NORMAL|                | |IDLE| |IDLE|
> >>       +------+ | +------+                | +----+ +----+
> >>
> >>                                  pick_next_task_fair
> >>       +------+ | +------+         +----+ | +----+
> >> t2    |NORMAL| | |NORMAL|         |IDLE| | |IDLE|
> >>       +------+ | +------+         +----+ | +----+
> >>
> >>                                  SCHED_IDLE running
> >> t3    +------+ | +------+        +----+  | +----+
> >>       |NORMAL| | |NORMAL|        |IDLE|  | |IDLE|
> >>       +------+ | +------+        +----+  | +----+
> >>
> >>                                  run_rebalance_domains
> >>       +------+ |                +------+ | +----+ +----+
> >> t4    |NORMAL| |                |NORMAL| | |IDLE| |IDLE|
> >>       +------+ |                +------+ | +----+ +----+
> >>
> >> As we can see
> >> t1: NORMAL task in CPU2 exits or blocked
> >> t2: CPU2 pick_next_task_fair would pick a SCHED_IDLE to run while
> >> another SCHED_NORMAL in rq1 is waiting.
> >> t3: SCHED_IDLE run in CPU2 while a SCHED_NORMAL wait in CPU1.
> >> t4: after a short time, periodic load_balance triggerd and pull
> >> SCHED_NORMAL in rq1 to rq2, and SCHED_NORMAL likely preempts SCHED_IDLE.
> >>
> >> In this scenario, SCHED_IDLE is running while SCHED_NORMAL is waiting to run.
> >> The latency of this SCHED_NORMAL will be high which is not acceptble.
> >>
> >> Do a load_balance before running the SCHED_IDLE may fix this problem.
> >>
> >> This patch works as below:
> >>
> >>              CPU1                      CPU2
> >>         curr       rq1            curr          rq2
> >>       +------+ | +------+       +------+ | +----+ +----+
> >> t0    |NORMAL| | |NORMAL|       |NORMAL| | |IDLE| |IDLE|
> >>       +------+ | +------+       +------+ | +----+ +----+
> >>
> >>                                  NORMAL exits or blocked
> >>       +------+ | +------+                | +----+ +----+
> >> t1    |NORMAL| | |NORMAL|                | |IDLE| |IDLE|
> >>       +------+ | +------+                | +----+ +----+
> >>
> >> t2                            pick_next_task_fair (all se are SCHED_IDLE)
> >>
> >>                                  newidle_balance
> >>       +------+ |                 +------+ | +----+ +----+
> >> t3    |NORMAL| |                 |NORMAL| | |IDLE| |IDLE|
> >>       +------+ |                 +------+ | +----+ +----+
> >>
> >>
> >> t1: NORMAL task in CPU2 exits or blocked
> >> t2: pick_next_task_fair check all se in rbtree are SCHED_IDLE and calls
> >> newidle_balance who tries to pull a SCHED_NORMAL(if has).
> >> t3: pick_next_task_fair would pick a SCHED_NORMAL to run instead of
> >> SCHED_IDLE(likely).
> >>
> >> >
> >> >> CPU by doing load_balance first.
> >> >>
> >> >> Signed-off-by: Chen Xiaoguang <xiaoggchen@tencent.com>
> >> >> Signed-off-by: Chen He <heddchen@tencent.com>
> >> >> ---
> >> >>  kernel/sched/fair.c | 5 +++++
> >> >>  1 file changed, 5 insertions(+)
> >> >>
> >> >> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> >> >> index ae7ceba..0a26132 100644
> >> >> --- a/kernel/sched/fair.c
> >> >> +++ b/kernel/sched/fair.c
> >> >> @@ -7004,6 +7004,11 @@ struct task_struct *
> >> >>         struct task_struct *p;
> >> >>         int new_tasks;
> >> >>
> >> >> +       if (prev &&
> >> >> +           fair_policy(prev->policy) &&
> >> >
> >> >Why do you need a prev and fair task  ? You seem to target the special
> >> >case of pick_next_task  but in this case why not only testing rf!=null
> >> > to make sure to not return immediately after jumping to the idle
> >>
> >> >label?
> >> We just want to do load_balance only when CPU switches from SCHED_NORMAL
> >> to SCHED_IDLE.
> >> If not check prev, when the running tasks are all SCHED_IDLE, we would
> >> do newidle_balance everytime in pick_next_task_fair, it makes no sense
> >> and kind of wasting.
> >
> >I agree that calling newidle_balance every time pick_next_task_fair is
> >called when there are only sched_idle tasks is useless.
> >But you also have to take into account cases where there was another
> >class of task running on the cpu like RT one. In your example above,
> >if you replace the normal task on CPU2 by a RT task, you still want to
>
> >pick the normal task on CPU1 once RT task goes to sleep.
> Sure, this case should be taken into account,  we should also try to
> pick normal task in this case.
>
> >
> >Another point that you will have to consider the impact on
> >rq->idle_stamp because newidle_balance is assumed to be called before
>
> >going idle which is not the case anymore with your use case
> Yes. rq->idle_stamp should not be changed in this case.
>
>
>
> Actually we want to pull a SCHED_NORMAL task (if possible) to run when a cpu is
> about to run SCHED_IDLE task. But currently newidle_balance is not
> designed for SCHED_IDLE  so SCHED_IDLE can also be pulled which
> is useless in our situation.

newidle_balance will pull a sched_idle task only if there is an
imbalance which is the right thing to do IMO to ensure fairness
between sched_idle tasks.  Being a sched_idle task doesn't mean that
we should break the fairness

>
> So we plan to add a new function sched_idle_balance which only try to
> pull SCHED_NORMAL tasks from the busiest cpu. And we will call
> sched_idle_balance when the previous task is normal or RT and
> hoping we can pull a SCHED_NORMAL task to run.
>
> Do you think it is ok to add a new sched_idle_balance?

I don't see any reason why the scheduler should not pull a sched_idle
task if there is an imbalance. That will happen anyway during the next
periodic load balance

>
> >
> >>
> >> >
> >>
> >> >Also why not doing that for default case too ? i.e. balance_fair() ?
> >> You are right, if you think this scenario makes sense, we will send a
> >> refined patch soon :-)
> >>
> >> >
> >> >> +           sched_idle_cpu(rq->cpu))
> >> >> +               goto idle;
> >> >> +
> >> >>  again:
> >> >>         if (!sched_fair_runnable(rq))
> >> >>                 goto idle;
> >> >> --
> >> >> 1.8.3.1
> >> >>
> >> >>
