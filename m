Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3E6D2EC093
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 16:42:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727261AbhAFPl6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 10:41:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726251AbhAFPl5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 10:41:57 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A5F6C06134C
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jan 2021 07:41:17 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id m25so7379491lfc.11
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jan 2021 07:41:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QnsZVMNNWqyoVgF4tUbGmmkENHhENYQondkwh2lusPc=;
        b=efvi54/wi5hfPe2INnC+GViZusEotLSPaOUbdfe36KnDEhpaNfF8CWvtW9CeigLeb4
         FSNXlqRrbcYzdhN+ZgiouWQguOp5lTmSR3dGqEbLdPyBc4+fKDZbATy71kz+42BpSXL6
         LB9js5kYDQCT0IdLSeil1HSP+4DKmeQV2rTGx6CMX83WN/osMJNHJ59UyqUeiiHKmWDR
         GTN1xAFy/VVWKQ1A8mwKFAkLEprUv4A5g5Thsp/3WnRMiOIQ4nxn6Pxb+KZj/lVYFwYF
         eBckLIUFdHJUBbqf2LuM3QmJ+C9qaRb6LfUdk3hdNW5pheFdWwsZxpW9Y/kweIEXZq7g
         i0yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QnsZVMNNWqyoVgF4tUbGmmkENHhENYQondkwh2lusPc=;
        b=ckZAFIw5hZk9JTPz6lgx/DnNeuFThChDkSuriJGdGMW3PmPJFl+O+Y5stYxSuu1Quq
         d1oJW0ppj5KlXiAxMV+PuyLe9soUlaAQsVdW7drAiq/Azr3Csmhekk54u4RLPRq74iSi
         2K7e7F2IlzFKkPwjKgYlLOHBIEht9ok9DRtzoXZkovoNjAdJHc9sE6shxuaAN1mO5WX4
         Gqw7WPCHljsQf7+LUfGgMhpKRa3Td2ScZdcwJxyXeWhqf9Qlk93096dCJJDewIF+XBmx
         29vO9krHfTizBDvacCC+ZGD/B5yiRqQPA3JK63zrDVIWjGe2YbUxO+aUZVMh1jBawbiJ
         i6QA==
X-Gm-Message-State: AOAM530siG7pXysBNvf4MGn3x4rKuwVWJ4bA8Pw1VlbHkaMhsY9tggKR
        za+sI4xVIU7HTOpb+LcNIuLbjMtWO1dsrdYzvukEYg==
X-Google-Smtp-Source: ABdhPJx0Vr8kotlPC2HaFczchGsQMQHErclYzYUxX/91yqmB3xhQddvI7OGsk3RNhEaD+gygMz3+QnH6qJrBb4gCHT8=
X-Received: by 2002:a2e:9246:: with SMTP id v6mr2234434ljg.221.1609947675565;
 Wed, 06 Jan 2021 07:41:15 -0800 (PST)
MIME-Version: 1.0
References: <20210106133419.2971-1-vincent.guittot@linaro.org>
 <20210106133419.2971-4-vincent.guittot@linaro.org> <X/XTlRMiOVs7L28B@hirez.programming.kicks-ass.net>
In-Reply-To: <X/XTlRMiOVs7L28B@hirez.programming.kicks-ass.net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 6 Jan 2021 16:41:04 +0100
Message-ID: <CAKfTPtCEV5zzXLM3RNf2-6XhVcDsstHdzh9OKX_j6WviRUVeYw@mail.gmail.com>
Subject: Re: [PATCH 3/3] sched/fair: reduce cases for active balance
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

On Wed, 6 Jan 2021 at 16:13, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Wed, Jan 06, 2021 at 02:34:19PM +0100, Vincent Guittot wrote:
> > Active balance is triggered for a number of voluntary case like misfit or
>                                                         cases
> > pinned tasks cases but also after that a number of load balance failed to
>                                                                  ^attempts
> > migrate a task. Remove the active load balance case for overloaded group
>                                                          ^an ?
> > as an overloaded state means that there is at least one waiting tasks. The
>                                                                   task
> > threshold on the upper limit of the task's load will decrease with the
> > number of failed LB until the task has migrated.
>
> And I'm not sure I follow that last part, irrespective of spelling nits,
> help?

Argh, come back to work is difficult for me

Let me try again:

Active balance is triggered for a number of voluntary cases like
misfit or pinned tasks cases but also after that a number of load
balance attempts failed to migrate a task. There is no need to use
active load balance when the group is overloaded because an overloaded
state means that there is at least one waiting task. Nevertheless, the
waiting task is not selected and detached until the threshold becomes
higher than its load. This threshold increases with the number of
failed lb (see the condition if ((load >> env->sd->nr_balance_failed)
> env->imbalance) in detach_tasks()) and the waiting task will end up
to be selected after a number of attempts.

>
> > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > ---
> >  kernel/sched/fair.c | 43 +++++++++++++++++++++----------------------
> >  1 file changed, 21 insertions(+), 22 deletions(-)
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 69a455113b10..ee87fd6f7359 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -9499,13 +9499,30 @@ asym_active_balance(struct lb_env *env)
> >  }
> >
> >  static inline bool
> > -voluntary_active_balance(struct lb_env *env)
> > +imbalanced_active_balance(struct lb_env *env)
> > +{
> > +     struct sched_domain *sd = env->sd;
> > +
> > +     /* The imbalanced case includes the case of pinned tasks preventing a fair
> > +      * distribution of the load on the system but also the even distribution of the
> > +      * threads on a system with spare capacity
> > +      */
>
> comment style fail
>
> > +     if ((env->migration_type == migrate_task) &&
> > +             (sd->nr_balance_failed > sd->cache_nice_tries+2))
>
> indent fail; try: set cino=(0:0
>
> > +             return 1;
> > +
> > +     return 0;
> > +}
> > +
> > +static int need_active_balance(struct lb_env *env)
> >  {
> >       struct sched_domain *sd = env->sd;
> >
> >       if (asym_active_balance(env))
> >               return 1;
> >
> > +     if (imbalanced_active_balance(env))
> > +             return 1;
>
> + whitespace
>
> >       /*
> >        * The dst_cpu is idle and the src_cpu CPU has only 1 CFS task.
> >        * It's worth migrating the task if the src_cpu's capacity is reduced
