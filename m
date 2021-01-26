Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFD6D303D0E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 13:33:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404129AbhAZKev (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 05:34:51 -0500
Received: from mga02.intel.com ([134.134.136.20]:23898 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730170AbhAZBmy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 20:42:54 -0500
IronPort-SDR: GbG+WP5dPd/MTH9/Z+Lg6wQcuP8pqTVKjKt3ynwJCQqTBCmzGNlBs2nzOoE/v33wR8JQNi/qJi
 5RLnoCLq2nQQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9875"; a="166932365"
X-IronPort-AV: E=Sophos;i="5.79,375,1602572400"; 
   d="scan'208";a="166932365"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2021 17:40:43 -0800
IronPort-SDR: oltjSG4Cjrx1U9CaXkurV2Wtn8wScfoSZr6SpTKSMcqjzt3VV7/fqL1Qis2N++AI1bDBro1iUI
 zTSCvIJxheNQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,375,1602572400"; 
   d="scan'208";a="402591086"
Received: from cli6-desk1.ccr.corp.intel.com (HELO [10.239.161.125]) ([10.239.161.125])
  by fmsmga004.fm.intel.com with ESMTP; 25 Jan 2021 17:40:39 -0800
Subject: Re: [RFC PATCH v1] sched/fair: limit load balance redo times at the
 same sched_domain level
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Aubrey Li <aubrey.li@intel.com>, Ingo Molnar <mingo@redhat.com>,
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
 <a99d59c3-2023-1e8f-83cd-d964e156ffd6@linux.intel.com>
 <CAKfTPtCCzy5keKcEOUX6D1+wty0dtYEfA5=oezWRgKY_beO5NQ@mail.gmail.com>
From:   "Li, Aubrey" <aubrey.li@linux.intel.com>
Message-ID: <c4066132-d7a2-ef22-2ec0-6ba0c6fc3357@linux.intel.com>
Date:   Tue, 26 Jan 2021 09:40:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <CAKfTPtCCzy5keKcEOUX6D1+wty0dtYEfA5=oezWRgKY_beO5NQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/1/25 22:51, Vincent Guittot wrote:
> On Mon, 25 Jan 2021 at 15:00, Li, Aubrey <aubrey.li@linux.intel.com> wrote:
>>
>> On 2021/1/25 18:56, Vincent Guittot wrote:
>>> On Mon, 25 Jan 2021 at 06:50, Aubrey Li <aubrey.li@intel.com> wrote:
>>>>
>>>> A long-tail load balance cost is observed on the newly idle path,
>>>> this is caused by a race window between the first nr_running check
>>>> of the busiest runqueue and its nr_running recheck in detach_tasks.
>>>>
>>>> Before the busiest runqueue is locked, the tasks on the busiest
>>>> runqueue could be pulled by other CPUs and nr_running of the busiest
>>>> runqueu becomes 1, this causes detach_tasks breaks with LBF_ALL_PINNED
>>>
>>> We should better detect that when trying to detach task like below
>>
>> This should be a compromise from my understanding. If we give up load balance
>> this time due to the race condition, we do reduce the load balance cost on the
>> newly idle path, but if there is an imbalance indeed at the same sched_domain
> 
> Redo path is there in case, LB has found an imbalance but it can't
> move some loads from this busiest rq to dest rq because of some cpu
> affinity. So it tries to fix the imbalance by moving load onto another
> rq of the group. In your case, the imbalance has disappeared because
> it has already been pulled by another rq so you don't have to try to
> find another imbalance. And I would even say you should not in order
> to let other level to take a chance to spread the load

Here is one simple case I have seen:
1) CPU_a becomes idle and invoke newly idle balance
2) Group_b is found as the busiest group
3) CPU_b_1 is found as the busiest CPU, nr_running = 5
4) detach_tasks check CPU_b_1's run queue again, nr_running = 1, goto redo
5) Group_b is still found as the busiest group
6) This time CPU_b_2 is found as the busiest CPU, nr_running = 3
7) detach_tasks successfully, 2 tasks moved.

If we skipped redo,
- CPU_a exit load balance and remain idle
- tasks stay on CPU_b_2's runqueue, wait for the next load balancing

The two tasks could have been moved to the idle CPU and get executed
immediately.

> 
>> level, we have to wait the next softirq entry to handle that imbalance. This
>> means the tasks on the second busiest runqueue have to stay longer, which could
>> introduce tail latency as well. That's why I introduced a variable to control
>> the redo loops. I'll send this to the benchmark queue to see if it makes any
> 
> TBH, I don't like multiplying the number of knobs
> I see.

Thanks,
-Aubrey
