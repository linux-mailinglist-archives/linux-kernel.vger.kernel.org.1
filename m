Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55D2F296132
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 16:53:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S368290AbgJVOxd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 10:53:33 -0400
Received: from foss.arm.com ([217.140.110.172]:59150 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S368273AbgJVOxa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 10:53:30 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5F742D6E;
        Thu, 22 Oct 2020 07:53:29 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0B3E73F66E;
        Thu, 22 Oct 2020 07:53:27 -0700 (PDT)
References: <20201022134354.3485-1-vincent.guittot@linaro.org>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, linux-kernel@vger.kernel.org,
        morten.rasmussen@arm.com
Subject: Re: [PATCH] sched/fair: prefer prev cpu in asymmetric wakeup path
In-reply-to: <20201022134354.3485-1-vincent.guittot@linaro.org>
Date:   Thu, 22 Oct 2020 15:53:21 +0100
Message-ID: <jhj1rhqqplq.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Vincent,

On 22/10/20 14:43, Vincent Guittot wrote:
> During fast wakeup path, scheduler always check whether local or prev cpus
> are good candidates for the task before looking for other cpus in the
> domain. With
>   commit b7a331615d25 ("sched/fair: Add asymmetric CPU capacity wakeup scan")
> the heterogenous system gains a dedicated path but doesn't try to keep
> reusing prev cpu whenever possible. If the previous cpu is idle and belong to the
> asymmetric domain, we should check it 1st before looking for another cpu
> because it stays one of the best candidate and it stabilizes task placement
> on the system.
>
> This change aligns asymmetric path behavior with symmetric one and reduces
> cases where the task migrates across all cpus of the sd_asym_cpucapacity
> domains at wakeup.
>
> This change does not impact normal EAS mode but only the overloaded case or
> when EAS is not used.
>
> On hikey960 with performance governor (EAS disable)
>
> ./perf bench sched pipe -T -l 150000
>              mainline           w/ patch
> # migrations   299811                  3

Colour me impressed!

Now AFAICT the only thing that makes new_cpu != prev_cpu in
select_task_rq_fair() is the WAKE_AFFINE stuff, and the likelihood of that
happening increases when WF_SYNC (which the Android binder uses, at least
on a mainline tree). I had severely underestimated how often that thing
picks this_cpu.

> ops/sec        154535(+/-0.13%)   181754(+/- 0.29) +17%
>
> Fixes: b7a331615d25 ("sched/fair: Add asymmetric CPU capacity wakeup scan")
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
>  kernel/sched/fair.c | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index aa4c6227cd6d..f39638fe6b94 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6170,7 +6170,7 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
>   * maximize capacity.
>   */
>  static int
> -select_idle_capacity(struct task_struct *p, struct sched_domain *sd, int target)
> +select_idle_capacity(struct task_struct *p, struct sched_domain *sd, int prev, int target)
>  {
>       unsigned long best_cap = 0;
>       int cpu, best_cpu = -1;
> @@ -6178,9 +6178,22 @@ select_idle_capacity(struct task_struct *p, struct sched_domain *sd, int target)
>
>       sync_entity_load_avg(&p->se);
>
> +	if ((available_idle_cpu(target) || sched_idle_cpu(target)) &&
> +	    task_fits_capacity(p, capacity_of(target)))
> +		return target;
> +

I think we still need to check for CPU affinity here.

>       cpus = this_cpu_cpumask_var_ptr(select_idle_mask);
>       cpumask_and(cpus, sched_domain_span(sd), p->cpus_ptr);
>
> +	/*
> +	 * If the previous CPU belongs to this asymmetric domain and is idle,
> +	 * check it 1st as it's the best candidate.
> +	 */
> +	if (prev != target && cpumask_test_cpu(prev, cpus) &&
> +	    (available_idle_cpu(prev) || sched_idle_cpu(prev)) &&
> +	    task_fits_capacity(p, capacity_of(prev)))
> +		return prev;
> +
>       for_each_cpu_wrap(cpu, cpus, target) {

So we prioritize target over prev, like the rest of the
select_idle_sibling() family. Here however we apply the same acceptability
function to target, prev and the loop body, so perhaps we could simplify
this to:

  if (accept(target))
      return target;

  ...

  for_each_cpu_wrap(cpu, cpus, prev) {
      ...
  }

That way we evaluate target twice only if it isn't a direct candidate
(but might be a fallback one).

>               unsigned long cpu_cap = capacity_of(cpu);
>
> @@ -6223,7 +6236,7 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
>               if (!sd)
>                       goto symmetric;
>
> -		i = select_idle_capacity(p, sd, target);
> +		i = select_idle_capacity(p, sd, prev, target);
>               return ((unsigned)i < nr_cpumask_bits) ? i : target;
>       }
