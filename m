Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6857028B48D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 14:23:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388495AbgJLMXD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 08:23:03 -0400
Received: from foss.arm.com ([217.140.110.172]:42242 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388334AbgJLMXC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 08:23:02 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3752BD6E;
        Mon, 12 Oct 2020 05:23:02 -0700 (PDT)
Received: from [192.168.178.2] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 67E113F66B;
        Mon, 12 Oct 2020 05:22:59 -0700 (PDT)
Subject: Re: [PATCH -v2 15/17] sched: Fix migrate_disable() vs rt/dl balancing
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     tglx@linutronix.de, mingo@kernel.org, linux-kernel@vger.kernel.org,
        bigeasy@linutronix.de, qais.yousef@arm.com, swood@redhat.com,
        valentin.schneider@arm.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, rostedt@goodmis.org,
        bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
        vincent.donnefort@arm.com, tj@kernel.org
References: <20201005145717.346020688@infradead.org>
 <20201005150922.458081448@infradead.org>
 <54bebe28-1d6d-5f71-da57-deb2eee111d3@arm.com>
 <20201012112824.GU2628@hirez.programming.kicks-ass.net>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <c50326d5-4039-44f1-51e9-4adc0d3c57ea@arm.com>
Date:   Mon, 12 Oct 2020 14:22:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201012112824.GU2628@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/10/2020 13:28, Peter Zijlstra wrote:
> On Mon, Oct 12, 2020 at 11:56:09AM +0200, Dietmar Eggemann wrote:
>> On 05/10/2020 16:57, Peter Zijlstra wrote:
>>
>> [...]
>>
>>> --- a/kernel/sched/rt.c
>>> +++ b/kernel/sched/rt.c
>>> @@ -1859,7 +1859,7 @@ static struct task_struct *pick_next_pus
>>>   * running task can migrate over to a CPU that is running a task
>>>   * of lesser priority.
>>>   */
>>> -static int push_rt_task(struct rq *rq)
>>> +static int push_rt_task(struct rq *rq, bool pull)
>>>  {
>>>  	struct task_struct *next_task;
>>>  	struct rq *lowest_rq;
>>> @@ -1873,6 +1873,34 @@ static int push_rt_task(struct rq *rq)
>>>  		return 0;
>>>  
>>>  retry:
>>> +	if (is_migration_disabled(next_task)) {
>>> +		struct task_struct *push_task = NULL;
>>> +		int cpu;
>>> +
>>> +		if (!pull || rq->push_busy)
>>> +			return 0;
>>
>> Shouldn't there be the same functionality in push_dl_task(), i.e.
>> returning 0 earlier for a task with migration_disabled?
> 
> No, deadline didn't implement HAVE_RT_PUSH_IPI. 

Right, so 'is_migration_disabled(next_task) && !pull' should never
happen then (for RT and DL).
