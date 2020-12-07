Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AE2D2D16DB
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 17:54:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727530AbgLGQxQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 11:53:16 -0500
Received: from foss.arm.com ([217.140.110.172]:55560 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725832AbgLGQxQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 11:53:16 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 879BA101E;
        Mon,  7 Dec 2020 08:52:30 -0800 (PST)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BF3013F66B;
        Mon,  7 Dec 2020 08:52:28 -0800 (PST)
References: <20201118043113.53128-1-aubrey.li@linux.intel.com> <20201207154838.GP3040@hirez.programming.kicks-ass.net>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Aubrey Li <aubrey.li@linux.intel.com>, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        mgorman@techsingularity.net, qais.yousef@arm.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        tim.c.chen@linux.intel.com, linux-kernel@vger.kernel.org,
        Mel Gorman <mgorman@suse.de>, Jiang Biao <benbjiang@gmail.com>
Subject: Re: [RFC PATCH v5] sched/fair: select idle cpu from idle cpumask for task wakeup
In-reply-to: <20201207154838.GP3040@hirez.programming.kicks-ass.net>
Date:   Mon, 07 Dec 2020 16:52:24 +0000
Message-ID: <jhjtusxtv7b.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 07/12/20 15:48, Peter Zijlstra wrote:
> On Wed, Nov 18, 2020 at 12:31:13PM +0800, Aubrey Li wrote:
>> diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
>> index f324dc36fc43..6f5947673e66 100644
>> --- a/kernel/sched/idle.c
>> +++ b/kernel/sched/idle.c
>> @@ -163,6 +163,7 @@ static void cpuidle_idle_call(void)
>>       */
>>
>>      if (cpuidle_not_available(drv, dev)) {
>> +		update_idle_cpumask(this_rq(), true);
>>              tick_nohz_idle_stop_tick();
>>
>>              default_idle_call();
>> @@ -193,6 +194,7 @@ static void cpuidle_idle_call(void)
>>                      max_latency_ns = dev->forced_idle_latency_limit_ns;
>>              }
>>
>> +		update_idle_cpumask(this_rq(), true);
>>              tick_nohz_idle_stop_tick();
>>
>>              next_state = cpuidle_find_deepest_state(drv, dev, max_latency_ns);
>> @@ -205,10 +207,12 @@ static void cpuidle_idle_call(void)
>>               */
>>              next_state = cpuidle_select(drv, dev, &stop_tick);
>>
>> -		if (stop_tick || tick_nohz_tick_stopped())
>> +		if (stop_tick || tick_nohz_tick_stopped()) {
>> +			update_idle_cpumask(this_rq(), true);
>>                      tick_nohz_idle_stop_tick();
>
> We already have a callback in tick_nohz_idle_stop_tick(), namely
> nohz_balance_enter_idle().

That's a no-op for !NO_HZ_COMMON though. For similar reasons, Aubrey moved
the clearing of the cpumask to scheduler_tick().

Are you saying this mechanism should only be driven for NO_HZ kernels? I
would tend to agree with Vincent that this could still be useful for idling
without cutting the tick (!NO_HZ or shallow idle state); see:

  20201124170136.GA26613@vingu-book
