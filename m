Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C02029759F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 19:15:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753255AbgJWRO7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 13:14:59 -0400
Received: from foss.arm.com ([217.140.110.172]:57074 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S465533AbgJWRO7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 13:14:59 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8A2EE1FB;
        Fri, 23 Oct 2020 10:14:58 -0700 (PDT)
Received: from [192.168.178.2] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 605163F719;
        Fri, 23 Oct 2020 10:14:56 -0700 (PDT)
Subject: Re: [PATCH] sched/fair: prefer prev cpu in asymmetric wakeup path
To:     Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>
References: <20201022134354.3485-1-vincent.guittot@linaro.org>
 <jhj1rhqqplq.mognet@arm.com>
 <CAKfTPtBP8GntXP40mkq6NeppeFU1vZfFN_u41Athwouw-BBAMA@mail.gmail.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <2a2699ee-e62f-1590-c846-009af0478c59@arm.com>
Date:   Fri, 23 Oct 2020 19:14:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAKfTPtBP8GntXP40mkq6NeppeFU1vZfFN_u41Athwouw-BBAMA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/10/2020 17:33, Vincent Guittot wrote:
> On Thu, 22 Oct 2020 at 16:53, Valentin Schneider
> <valentin.schneider@arm.com> wrote:
>>
>>
>> Hi Vincent,
>>
>> On 22/10/20 14:43, Vincent Guittot wrote:

[...]

>>>  static int
>>> -select_idle_capacity(struct task_struct *p, struct sched_domain *sd, int target)
>>> +select_idle_capacity(struct task_struct *p, struct sched_domain *sd, int prev, int target)
>>>  {
>>>       unsigned long best_cap = 0;
>>>       int cpu, best_cpu = -1;
>>> @@ -6178,9 +6178,22 @@ select_idle_capacity(struct task_struct *p, struct sched_domain *sd, int target)
>>>
>>>       sync_entity_load_avg(&p->se);
>>>
>>> +     if ((available_idle_cpu(target) || sched_idle_cpu(target)) &&
>>> +         task_fits_capacity(p, capacity_of(target)))
>>> +             return target;
>>> +
>>
>> I think we still need to check for CPU affinity here.
> 
> yes good point

We don't check CPU affinity on target and prev in the symmetric case.

I always thought that since we:

(1) check 'want_affine = ... && cpumask_test_cpu(cpu, p->cpus_ptr);' in
    select_task_rq_fair() and

(2) we have the select_fallback_rq() in select_task_rq() for prev

that this would be sufficient?

[...]
