Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAED52963DD
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 19:46:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S369246AbgJVRqG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 13:46:06 -0400
Received: from foss.arm.com ([217.140.110.172]:34016 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2443926AbgJVRqG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 13:46:06 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1E363101E;
        Thu, 22 Oct 2020 10:46:05 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C2C003F719;
        Thu, 22 Oct 2020 10:46:03 -0700 (PDT)
References: <20201022134354.3485-1-vincent.guittot@linaro.org> <jhj1rhqqplq.mognet@arm.com> <CAKfTPtBP8GntXP40mkq6NeppeFU1vZfFN_u41Athwouw-BBAMA@mail.gmail.com>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>
Subject: Re: [PATCH] sched/fair: prefer prev cpu in asymmetric wakeup path
In-reply-to: <CAKfTPtBP8GntXP40mkq6NeppeFU1vZfFN_u41Athwouw-BBAMA@mail.gmail.com>
Date:   Thu, 22 Oct 2020 18:45:58 +0100
Message-ID: <jhjzh4ep31l.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 22/10/20 16:33, Vincent Guittot wrote:
> On Thu, 22 Oct 2020 at 16:53, Valentin Schneider
> <valentin.schneider@arm.com> wrote:
>> > @@ -6170,7 +6170,7 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
>> >   * maximize capacity.
>> >   */
>> >  static int
>> > -select_idle_capacity(struct task_struct *p, struct sched_domain *sd, int target)
>> > +select_idle_capacity(struct task_struct *p, struct sched_domain *sd, int prev, int target)
>> >  {
>> >       unsigned long best_cap = 0;
>> >       int cpu, best_cpu = -1;
>> > @@ -6178,9 +6178,22 @@ select_idle_capacity(struct task_struct *p, struct sched_domain *sd, int target)
>> >
>> >       sync_entity_load_avg(&p->se);
>> >
>> > +     if ((available_idle_cpu(target) || sched_idle_cpu(target)) &&
>> > +         task_fits_capacity(p, capacity_of(target)))
>> > +             return target;
>> > +
>>
>> I think we still need to check for CPU affinity here.
>
> yes good point
>
>>
>> >       cpus = this_cpu_cpumask_var_ptr(select_idle_mask);
>> >       cpumask_and(cpus, sched_domain_span(sd), p->cpus_ptr);
>> >
>> > +     /*
>> > +      * If the previous CPU belongs to this asymmetric domain and is idle,
>> > +      * check it 1st as it's the best candidate.
>> > +      */
>> > +     if (prev != target && cpumask_test_cpu(prev, cpus) &&
>> > +         (available_idle_cpu(prev) || sched_idle_cpu(prev)) &&
>> > +         task_fits_capacity(p, capacity_of(prev)))
>> > +             return prev;
>> > +
>> >       for_each_cpu_wrap(cpu, cpus, target) {
>>
>> So we prioritize target over prev, like the rest of the
>> select_idle_sibling() family. Here however we apply the same acceptability
>> function to target, prev and the loop body, so perhaps we could simplify
>> this to:
>
> My 1st implementation was similar to you proposal below but i finally
> decided to strictly follow the same sequence as symmetric which:
> - checks target
> - then prev cpu
> - and finally uses target as the starting point of the loop for
> looking for another cpu
>
> Using prev as the starting point of the loop will change which cpu
> will be selected but I don't have a strong opinion if this will make a
> real difference at the end because bit position doesn't imply any
> relation with others cpus.
>

Yep, also one difference with the symmetric path here is that the first
checks against target & prev use exactly the same criteria as the loop
body, so we shouldn't feel shy about doing this here.

> So I'm fine to go with your proposal below
>
> Also I wonder if i should also add the test of p->recent_used_cpu and
> the per cpu kthread optimization, which benefit XFS IIRC.
>

If we head down that route it would be nice to reuse the existing
conditions (rather than copy and tweak them) and move the asymmetric loop
further down. Maybe with something like (with a better name though):

  static inline bool asym_task_fits_capacity(struct task_struct *p, int cpu)
  {
          if (!static_branch_unlikely(&sched_asym_cpucapacity))
                  return true;

          return task_fits_capacity(p, capacity_of(cpu));
  }

and we could && that to the existing cases. Food for thought.

>>
>>   if (accept(target))
>>       return target;
>>
>>   ...
>>
>>   for_each_cpu_wrap(cpu, cpus, prev) {
>>       ...
>>   }
>>
>> That way we evaluate target twice only if it isn't a direct candidate
>> (but might be a fallback one).
>>
>> >               unsigned long cpu_cap = capacity_of(cpu);
>> >
>> > @@ -6223,7 +6236,7 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
>> >               if (!sd)
>> >                       goto symmetric;
>> >
>> > -             i = select_idle_capacity(p, sd, target);
>> > +             i = select_idle_capacity(p, sd, prev, target);
>> >               return ((unsigned)i < nr_cpumask_bits) ? i : target;
>> >       }
