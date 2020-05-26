Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3DCE1C1A68
	for <lists+linux-kernel@lfdr.de>; Fri,  1 May 2020 18:12:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730152AbgEAQMN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 May 2020 12:12:13 -0400
Received: from foss.arm.com ([217.140.110.172]:43348 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730082AbgEAQMM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 12:12:12 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A474C31B;
        Fri,  1 May 2020 09:12:11 -0700 (PDT)
Received: from [192.168.0.7] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 362503F85E;
        Fri,  1 May 2020 09:12:09 -0700 (PDT)
Subject: Re: [PATCH v2 5/6] sched/deadline: Make DL capacity-aware
To:     Pavan Kondeti <pkondeti@codeaurora.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Luca Abeni <luca.abeni@santannapisa.it>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Wei Wang <wvw@google.com>, Quentin Perret <qperret@google.com>,
        Alessio Balsini <balsini@google.com>,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Qais Yousef <qais.yousef@arm.com>, linux-kernel@vger.kernel.org
References: <20200427083709.30262-1-dietmar.eggemann@arm.com>
 <20200427083709.30262-6-dietmar.eggemann@arm.com>
 <20200430131036.GE19464@codeaurora.org>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <aa00aee6-2adb-569b-825b-781da12ad8d3@arm.com>
Date:   Fri, 1 May 2020 18:12:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200430131036.GE19464@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/04/2020 15:10, Pavan Kondeti wrote:
> On Mon, Apr 27, 2020 at 10:37:08AM +0200, Dietmar Eggemann wrote:
>> From: Luca Abeni <luca.abeni@santannapisa.it>

[...]

>> @@ -1653,10 +1654,19 @@ select_task_rq_dl(struct task_struct *p, int cpu, int sd_flag, int flags)
>>  	 * other hand, if it has a shorter deadline, we
>>  	 * try to make it stay here, it might be important.
>>  	 */
>> -	if (unlikely(dl_task(curr)) &&
>> -	    (curr->nr_cpus_allowed < 2 ||
>> -	     !dl_entity_preempt(&p->dl, &curr->dl)) &&
>> -	    (p->nr_cpus_allowed > 1)) {
>> +	select_rq = unlikely(dl_task(curr)) &&
>> +		    (curr->nr_cpus_allowed < 2 ||
>> +		     !dl_entity_preempt(&p->dl, &curr->dl)) &&
>> +		    p->nr_cpus_allowed > 1;
>> +
>> +	/*
>> +	 * Take the capacity of the CPU into account to
>> +	 * ensure it fits the requirement of the task.
>> +	 */
>> +	if (static_branch_unlikely(&sched_asym_cpucapacity))
>> +		select_rq |= !dl_task_fits_capacity(p, cpu);
>> +
>> +	if (select_rq) {
>>  		int target = find_later_rq(p);
> 
> I see that find_later_rq() checks if the previous CPU is part of
> later_mask and returns it immediately. So we don't migrate the
> task in the case where there previous CPU can't fit the task and
> there are no idle CPUs on which the task can fit. LGTM.

Hope I understand you here. I don't think that [patch 6/6] provides this
already.

In case 'later_mask' has no fitting CPUs, 'max_cpu' is set in the
otherwise empty 'later_mask'. But 'max_cpu' is not necessary task_cpu(p).

Example on Juno [L b b L L L] with thread0-0 (big task)

     cpudl_find [thread0-0 2117] orig later_mask=0,3-4 later_mask=0
  find_later_rq [thread0-0 2117] task_cpu=2 later_mask=0

A tweak could be added favor task_cpu(p) in case it is amongst the CPUs
with the maximum capacity in cpudl_find() for the !fit case.

[...]

>> +/*
>> + * Verify the fitness of task @p to run on @cpu taking into account the
>> + * CPU original capacity and the runtime/deadline ratio of the task.
>> + *
>> + * The function will return true if the CPU original capacity of the
>> + * @cpu scaled by SCHED_CAPACITY_SCALE >= runtime/deadline ratio of the
>> + * task and false otherwise.
>> + */
>> +static inline bool dl_task_fits_capacity(struct task_struct *p, int cpu)
>> +{
>> +	unsigned long cap = arch_scale_cpu_capacity(cpu);
>> +
>> +	return cap_scale(p->dl.dl_deadline, cap) >= p->dl.dl_runtime;
>> +}
>> +
> 
> This is same as
> 
> return p->dl.dl_bw >> (BW_SHIFT - SCHED_CAPACITY_SHIFT) <= cap
> 
> Correct?  If yes, would it be better to use this?

We could use sched_dl_entity::dl_density (dl_runtime / dl_deadline) but
then I would have to export BW_SHIFT.
