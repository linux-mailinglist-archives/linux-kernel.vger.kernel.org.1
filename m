Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BA58303690
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 07:31:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729244AbhAZGau (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 01:30:50 -0500
Received: from mga14.intel.com ([192.55.52.115]:6256 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729231AbhAYODP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 09:03:15 -0500
IronPort-SDR: olnKeSyVGiO20xHeOUqU5OFzOBwYHyZ9a+fEvhPdngM+j4IC89xfXlF2CmRr/kV+zMe2Bp1htT
 osQH1OCZGFoQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9874"; a="178950885"
X-IronPort-AV: E=Sophos;i="5.79,373,1602572400"; 
   d="scan'208";a="178950885"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2021 06:00:47 -0800
IronPort-SDR: gjy6pZq3wMViW4h7MF9es+N+Anp0xO/0fWsqc+bBSX9/94M/IT5nKUEBI35eGPfThCew2J7BWP
 0M5p3TK/BhQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,373,1602572400"; 
   d="scan'208";a="402342851"
Received: from cli6-desk1.ccr.corp.intel.com (HELO [10.239.161.125]) ([10.239.161.125])
  by fmsmga004.fm.intel.com with ESMTP; 25 Jan 2021 06:00:44 -0800
Subject: Re: [RFC PATCH v1] sched/fair: limit load balance redo times at the
 same sched_domain level
To:     Vincent Guittot <vincent.guittot@linaro.org>,
        Aubrey Li <aubrey.li@intel.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
References: <1611554578-6464-1-git-send-email-aubrey.li@intel.com>
 <CAKfTPtAxnsEDL436zUypLj2XyMQyhgPvJ8q_23835sQxWzGtxw@mail.gmail.com>
From:   "Li, Aubrey" <aubrey.li@linux.intel.com>
Message-ID: <a99d59c3-2023-1e8f-83cd-d964e156ffd6@linux.intel.com>
Date:   Mon, 25 Jan 2021 22:00:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <CAKfTPtAxnsEDL436zUypLj2XyMQyhgPvJ8q_23835sQxWzGtxw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/1/25 18:56, Vincent Guittot wrote:
> On Mon, 25 Jan 2021 at 06:50, Aubrey Li <aubrey.li@intel.com> wrote:
>>
>> A long-tail load balance cost is observed on the newly idle path,
>> this is caused by a race window between the first nr_running check
>> of the busiest runqueue and its nr_running recheck in detach_tasks.
>>
>> Before the busiest runqueue is locked, the tasks on the busiest
>> runqueue could be pulled by other CPUs and nr_running of the busiest
>> runqueu becomes 1, this causes detach_tasks breaks with LBF_ALL_PINNED
> 
> We should better detect that when trying to detach task like below

This should be a compromise from my understanding. If we give up load balance
this time due to the race condition, we do reduce the load balance cost on the
newly idle path, but if there is an imbalance indeed at the same sched_domain
level, we have to wait the next softirq entry to handle that imbalance. This
means the tasks on the second busiest runqueue have to stay longer, which could
introduce tail latency as well. That's why I introduced a variable to control
the redo loops. I'll send this to the benchmark queue to see if it makes any
difference.

Thanks,
-Aubrey

> 
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -7688,6 +7688,16 @@ static int detach_tasks(struct lb_env *env)
> 
>         lockdep_assert_held(&env->src_rq->lock);
> 
> +       /*
> +        * Another CPU has emptied this runqueue in the meantime.
> +        * Just return and leave the load_balance properly.
> +        */
> +       if (env->src_rq->nr_running <= 1 && !env->loop) {
> +               /* Clear the flag as we will not test any task */
> +               env->flags &= ~LBF_ALL_PINNED;
> +               return 0;
> +       }
> +
>         if (env->imbalance <= 0)
>                 return 0;
> 
> 
>> flag set, and triggers load_balance redo at the same sched_domain level.
>>
>> In order to find the new busiest sched_group and CPU, load balance will
>> recompute and update the various load statistics, which eventually leads
>> to the long-tail load balance cost.
>>
>> This patch introduces a variable(sched_nr_lb_redo) to limit load balance
>> redo times, combined with sysctl_sched_nr_migrate, the max load balance
>> cost is reduced from 100+ us to 70+ us, measured on a 4s x86 system with
>> 192 logical CPUs.
>>
>> Cc: Andi Kleen <ak@linux.intel.com>
>> Cc: Tim Chen <tim.c.chen@linux.intel.com>
>> Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
>> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> Signed-off-by: Aubrey Li <aubrey.li@linux.intel.com>
>> ---
>>  kernel/sched/fair.c | 7 ++++++-
>>  1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index ae7ceba..b59f371 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -7407,6 +7407,8 @@ struct lb_env {
>>         unsigned int            loop;
>>         unsigned int            loop_break;
>>         unsigned int            loop_max;
>> +       unsigned int            redo_cnt;
>> +       unsigned int            redo_max;
>>
>>         enum fbq_type           fbq_type;
>>         enum migration_type     migration_type;
>> @@ -9525,6 +9527,7 @@ static int should_we_balance(struct lb_env *env)
>>         return group_balance_cpu(sg) == env->dst_cpu;
>>  }
>>
>> +static const unsigned int sched_nr_lb_redo = 1;
>>  /*
>>   * Check this_cpu to ensure it is balanced within domain. Attempt to move
>>   * tasks if there is an imbalance.
>> @@ -9547,6 +9550,7 @@ static int load_balance(int this_cpu, struct rq *this_rq,
>>                 .dst_grpmask    = sched_group_span(sd->groups),
>>                 .idle           = idle,
>>                 .loop_break     = sched_nr_migrate_break,
>> +               .redo_max       = sched_nr_lb_redo,
>>                 .cpus           = cpus,
>>                 .fbq_type       = all,
>>                 .tasks          = LIST_HEAD_INIT(env.tasks),
>> @@ -9682,7 +9686,8 @@ static int load_balance(int this_cpu, struct rq *this_rq,
>>                          * destination group that is receiving any migrated
>>                          * load.
>>                          */
>> -                       if (!cpumask_subset(cpus, env.dst_grpmask)) {
>> +                       if (!cpumask_subset(cpus, env.dst_grpmask) &&
>> +                                       ++env.redo_cnt < env.redo_max) {
>>                                 env.loop = 0;
>>                                 env.loop_break = sched_nr_migrate_break;
>>                                 goto redo;
>> --
>> 2.7.4
>>

