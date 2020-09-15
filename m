Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E539F26B801
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 02:34:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726641AbgIPAeF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 20:34:05 -0400
Received: from mga09.intel.com ([134.134.136.24]:44345 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726455AbgIONko (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 09:40:44 -0400
IronPort-SDR: joN5RT4p5Ggxm695IooCsjmHQnZlTWMlHWUSrCE1PzZRw7ZE5KbxVc82ZXy4Iz1h4rP7+q2Q6Z
 MU5TUuY2L7yg==
X-IronPort-AV: E=McAfee;i="6000,8403,9744"; a="160187970"
X-IronPort-AV: E=Sophos;i="5.76,430,1592895600"; 
   d="scan'208";a="160187970"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2020 06:38:07 -0700
IronPort-SDR: 1LW4adCSbUnt4s0K6C7IcQp+jeqoshblniqRt8gVygmb4Yxp5orBIRgsmgid4xuysjdCOzoikM
 WFBbjpXq5TBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,430,1592895600"; 
   d="scan'208";a="331192786"
Received: from cli6-desk1.ccr.corp.intel.com (HELO [10.239.161.135]) ([10.239.161.135])
  by fmsmga004.fm.intel.com with ESMTP; 15 Sep 2020 06:38:04 -0700
Subject: Re: [RFC PATCH v1 1/1] sched/fair: select idle cpu from idle cpumask
 in sched domain
To:     Vincent Guittot <vincent.guittot@linaro.org>,
        Jiang Biao <benbjiang@gmail.com>
Cc:     Aubrey Li <aubrey.li@intel.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20200910054203.525420-1-aubrey.li@intel.com>
 <20200910054203.525420-2-aubrey.li@intel.com>
 <CAPJCdBm+eyvY3ZUU0sz8WxRhdKquCApTCb1rv8DBDCnG8kS0PA@mail.gmail.com>
 <CAKfTPtBXxFC_FJHbnRafN3-6Fs=kJxMvGaStiKtp8T06p5Xr4A@mail.gmail.com>
 <CAPJCdBn8GPM5ur6i90Lo1T95BPNAvCPASQdSTpOn_kjUxEi3LA@mail.gmail.com>
 <CAKfTPtC1DQOCmQRJYPO4zH99Nw622zx__a-4TKAJNHJJfLpvKg@mail.gmail.com>
From:   "Li, Aubrey" <aubrey.li@linux.intel.com>
Message-ID: <3c9c8db6-86c0-3f62-4a8e-a5df4cb03715@linux.intel.com>
Date:   Tue, 15 Sep 2020 21:38:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <CAKfTPtC1DQOCmQRJYPO4zH99Nw622zx__a-4TKAJNHJJfLpvKg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/9/15 17:23, Vincent Guittot wrote:
> On Tue, 15 Sep 2020 at 10:47, Jiang Biao <benbjiang@gmail.com> wrote:
>>
>> Hi, Vincent
>>
>> On Mon, 14 Sep 2020 at 20:26, Vincent Guittot
>> <vincent.guittot@linaro.org> wrote:
>>>
>>> On Sun, 13 Sep 2020 at 05:59, Jiang Biao <benbjiang@gmail.com> wrote:
>>>>
>>>> Hi, Aubrey
>>>>
>>>> On Fri, 11 Sep 2020 at 23:48, Aubrey Li <aubrey.li@intel.com> wrote:
>>>>>
>>>>> Added idle cpumask to track idle cpus in sched domain. When a CPU
>>>>> enters idle, its corresponding bit in the idle cpumask will be set,
>>>>> and when the CPU exits idle, its bit will be cleared.
>>>>>
>>>>> When a task wakes up to select an idle cpu, scanning idle cpumask
>>>>> has low cost than scanning all the cpus in last level cache domain,
>>>>> especially when the system is heavily loaded.
>>>>>
>>>>> Signed-off-by: Aubrey Li <aubrey.li@linux.intel.com>
>>>>> ---
>>>>>  include/linux/sched/topology.h | 13 +++++++++++++
>>>>>  kernel/sched/fair.c            |  4 +++-
>>>>>  kernel/sched/topology.c        |  2 +-
>>>>>  3 files changed, 17 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
>>>>> index fb11091129b3..43a641d26154 100644
>>>>> --- a/include/linux/sched/topology.h
>>>>> +++ b/include/linux/sched/topology.h
>>>>> @@ -65,8 +65,21 @@ struct sched_domain_shared {
>>>>>         atomic_t        ref;
>>>>>         atomic_t        nr_busy_cpus;
>>>>>         int             has_idle_cores;
>>>>> +       /*
>>>>> +        * Span of all idle CPUs in this domain.
>>>>> +        *
>>>>> +        * NOTE: this field is variable length. (Allocated dynamically
>>>>> +        * by attaching extra space to the end of the structure,
>>>>> +        * depending on how many CPUs the kernel has booted up with)
>>>>> +        */
>>>>> +       unsigned long   idle_cpus_span[];
>>>>>  };
>>>>>
>>>>> +static inline struct cpumask *sds_idle_cpus(struct sched_domain_shared *sds)
>>>>> +{
>>>>> +       return to_cpumask(sds->idle_cpus_span);
>>>>> +}
>>>>> +
>>>>>  struct sched_domain {
>>>>>         /* These fields must be setup */
>>>>>         struct sched_domain __rcu *parent;      /* top domain must be null terminated */
>>>>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>>>>> index 6b3b59cc51d6..3b6f8a3589be 100644
>>>>> --- a/kernel/sched/fair.c
>>>>> +++ b/kernel/sched/fair.c
>>>>> @@ -6136,7 +6136,7 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
>>>>>
>>>>>         time = cpu_clock(this);
>>>>>
>>>>> -       cpumask_and(cpus, sched_domain_span(sd), p->cpus_ptr);
>>>>> +       cpumask_and(cpus, sds_idle_cpus(sd->shared), p->cpus_ptr);
>>>> Is the sds_idle_cpus() always empty if nohz=off?
>>>
>>> Good point
>>>
>>>> Do we need to initialize the idle_cpus_span with sched_domain_span(sd)?
>>>>
>>>>>
>>>>>         for_each_cpu_wrap(cpu, cpus, target) {
>>>>>                 if (!--nr)
>>>>> @@ -10182,6 +10182,7 @@ static void set_cpu_sd_state_busy(int cpu)
>>>>>         sd->nohz_idle = 0;
>>>>>
>>>>>         atomic_inc(&sd->shared->nr_busy_cpus);
>>>>> +       cpumask_clear_cpu(cpu, sds_idle_cpus(sd->shared));
>>>>>  unlock:
>>>>>         rcu_read_unlock();
>>>>>  }
>>>>> @@ -10212,6 +10213,7 @@ static void set_cpu_sd_state_idle(int cpu)
>>>>>         sd->nohz_idle = 1;
>>>>>
>>>>>         atomic_dec(&sd->shared->nr_busy_cpus);
>>>>> +       cpumask_set_cpu(cpu, sds_idle_cpus(sd->shared));
>>>> This only works when entering/exiting tickless mode? :)
>>>> Why not update idle_cpus_span during tick_nohz_idle_enter()/exit()?
>>>
>>> set_cpu_sd_state_busy is only called during a tick in order to limit
>>> the rate of the update to once per tick per cpu at most and prevents
>>> any kind of storm of update if short running tasks wake/sleep all the
>>> time. We don't want to update a cpumask at each and every enter/leave
>>> idle.
>>>
>> Agree. But set_cpu_sd_state_busy seems not being reached when
>> nohz=off, which means it will not work for that case? :)
> 
> Yes set_cpu_sd_state_idle/busy are nohz function

Thanks Biao to point this out.

If the shared idle cpumask is initialized with sched_domain_span(sd),
then nohz=off case will remain the previous behavior.

Thanks,
-Aubrey
