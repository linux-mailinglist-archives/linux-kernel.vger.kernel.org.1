Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78338279FB3
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Sep 2020 10:38:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730505AbgI0Ih7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Sep 2020 04:37:59 -0400
Received: from mga17.intel.com ([192.55.52.151]:9825 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730438AbgI0Ih6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Sep 2020 04:37:58 -0400
IronPort-SDR: 3jh06MT2h0ga7JMdr88kpcm7+lR9i2PFPOZqhG4hu3QiLZRl8UL5Ag6l02HL/1t3XDFq31pZSK
 TWYurtEz9JRQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9756"; a="141861087"
X-IronPort-AV: E=Sophos;i="5.77,309,1596524400"; 
   d="scan'208";a="141861087"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2020 22:56:06 -0700
IronPort-SDR: 9oqP1bHZM0aubjyxN/MQ/IcRCDT3cfShUUigwZ7pc3L/Nx73DkcCao9w/Pqj6wpt1leXxKeXLL
 EsC6f2fuNeYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,309,1596524400"; 
   d="scan'208";a="337726177"
Received: from cli6-desk1.ccr.corp.intel.com (HELO [10.239.161.135]) ([10.239.161.135])
  by fmsmga004.fm.intel.com with ESMTP; 26 Sep 2020 22:56:03 -0700
Subject: Re: [RFC PATCH v2] sched/fair: select idle cpu from idle cpumask in
 sched domain
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Mel Gorman <mgorman@suse.de>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Qais Yousef <qais.yousef@arm.com>,
        Jiang Biao <benbjiang@gmail.com>
References: <78d608f2-b974-e940-da32-b37777bc405a@linux.intel.com>
 <CAKfTPtAVkg081VEGp3Hx3i7D+jxRJcyBi2=NJypvHH6HVJ8Nwg@mail.gmail.com>
 <CAKfTPtA2yE_sFfP5MFN=K+ph7rqpYUhapUdDBJ5hFLxnQPktJw@mail.gmail.com>
 <af0237e0-1451-9d11-2ee2-1468a8bb6180@linux.intel.com>
 <CAKfTPtD71z-n2dVTpZk5tLwy5OZjkju9v5vJ-3QNHhw8Grhc_Q@mail.gmail.com>
 <8a86b085-b445-b1c2-9b46-6346d923abf0@linux.intel.com>
 <CAKfTPtB-L3uM34N1w5ELzceuJxiMdkwXV5nQcqWitBAhsLoMhQ@mail.gmail.com>
 <eb1c4c84-e361-d5a7-d071-b0dd7310eab4@linux.intel.com>
 <CAKfTPtBYmAauUi1-bKpN1UmMTWEQL-TZqQJxtkVFnYjo-E1mRg@mail.gmail.com>
 <aff0c293-cf4d-9770-cd54-fc0d06662f09@linux.intel.com>
 <20200925164514.GA6432@vingu-book>
From:   "Li, Aubrey" <aubrey.li@linux.intel.com>
Message-ID: <d4c7437a-e7a6-d8e3-497e-1c99152dde7e@linux.intel.com>
Date:   Sun, 27 Sep 2020 13:56:02 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200925164514.GA6432@vingu-book>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/9/26 0:45, Vincent Guittot wrote:
> Le vendredi 25 sept. 2020 à 17:21:46 (+0800), Li, Aubrey a écrit :
>> Hi Vicent,
>>
>> On 2020/9/24 21:09, Vincent Guittot wrote:
>>>>>>
>>>>>> Would you mind share uperf(netperf load) result on your side? That's the
>>>>>> workload I have seen the most benefit this patch contributed under heavy
>>>>>> load level.
>>>>>
>>>>> with uperf, i've got the same kind of result as sched pipe
>>>>> tip/sched/core: Throughput 24.83Mb/s (+/- 0.09%)
>>>>> with this patch:  Throughput 19.02Mb/s (+/- 0.71%) which is a 23%
>>>>> regression as for sched pipe
>>>>>
>>>> In case this is caused by the logic error in this patch(sorry again), did
>>>> you see any improvement in patch V2? Though it does not helps for nohz=off
>>>> case, just want to know if it helps or does not help at all on arm platform.
>>>
>>> With the v2 which rate limit the update of the cpumask (but doesn't
>>> support sched_idle stask),  I don't see any performance impact:
>>
>> I agree we should go the way with cpumask update rate limited.
>>
>> And I think no performance impact for sched-pipe is expected, as this workload
>> has only 2 threads and the platform has 8 cores, so mostly previous cpu is
>> returned, and even if select_idle_sibling is called, select_idle_core is hit
>> and rarely call select_idle_cpu.
> 
> my platform is not smt so select_idle_core is nop. Nevertheless select_idle_cpu
> is almost never called because prev is idle and selected before calling it in
> our case
> 
>>
>> But I'm more curious why there is 23% performance penalty? So for this patch, if
>> you revert this change but keep cpumask updated, is 23% penalty still there?
>>
>> -       cpumask_and(cpus, sched_domain_span(sd), p->cpus_ptr);
>> +       cpumask_and(cpus, sds_idle_cpus(sd->shared), p->cpus_ptr);
> 
> I was about to say that reverting this line should not change anything because
> we never reach this point but it does in fact. And after looking at a trace,
> I can see that the 2 threads of perf bench sched pipe are on the same CPU and
> that the sds_idle_cpus(sd->shared) is always empty. In fact, the rq->curr is
> not yet idle and still point to the cfs task when you call update_idle_cpumask().
> This means that once cleared, the bit will never be set
> You can remove the test in update_idle_cpumask() which is called either when
> entering idle or when there is only sched_idle tasks that are runnable.
> 
> @@ -6044,8 +6044,7 @@ void update_idle_cpumask(struct rq *rq)
>         sd = rcu_dereference(per_cpu(sd_llc, cpu));
>         if (!sd || !sd->shared)
>                 goto unlock;
> -       if (!available_idle_cpu(cpu) || !sched_idle_cpu(cpu))
> -               goto unlock;
> +
>         cpumask_set_cpu(cpu, sds_idle_cpus(sd->shared));
>  unlock:
>         rcu_read_unlock();
> 
> With this fix, the performance decrease is only 2%
> 
>>
>> I just wonder if it's caused by the atomic ops as you have two cache domains with
>> sd_llc(?). Do you have a x86 machine to make a comparison? It's hard for me to find
>> an ARM machine but I'll try.
>>
>> Also, for uperf(task thread num = cpu num) workload, how is it on patch v2? no any
>> performance impact?
> 
> with v2 :  Throughput 24.97Mb/s (+/- 0.07%) so there is no perf regression
> 

Thanks Vincent, let me try to refine this patch.

-Aubrey
