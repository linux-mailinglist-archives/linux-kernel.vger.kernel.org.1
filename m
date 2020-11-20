Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BCE12BAF61
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 16:57:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729934AbgKTPy6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 10:54:58 -0500
Received: from foss.arm.com ([217.140.110.172]:51526 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728404AbgKTPy6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 10:54:58 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 46D2711D4;
        Fri, 20 Nov 2020 07:54:57 -0800 (PST)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1229F3F70D;
        Fri, 20 Nov 2020 07:54:55 -0800 (PST)
References: <20201118180030.22764-1-valentin.schneider@arm.com> <20201118180030.22764-3-valentin.schneider@arm.com> <c3370c24-98f2-dac8-e390-9c80a3321cf0@arm.com>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     James Morse <james.morse@arm.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 2/2] x86/intel_rdt: Plug task_work vs task_struct {rmid,closid} update race
In-reply-to: <c3370c24-98f2-dac8-e390-9c80a3321cf0@arm.com>
Date:   Fri, 20 Nov 2020 15:54:53 +0000
Message-ID: <jhjtutkuipe.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi James,

On 20/11/20 14:53, James Morse wrote:
> Hi Valentin,
>
> On 18/11/2020 18:00, Valentin Schneider wrote:
>> Upon moving a task to a new control / monitor group, said task's {closid,
>> rmid} fields are updated *after* triggering the move_myself() task_work
>> callback. This can cause said callback to miss the update, e.g. if the
>> triggering thread got preempted before fiddling with task_struct, or if the
>> targeted task was already on its way to return to userspace.
>
> So, if move_myself() runs after task_work_add() but before tsk is written to.
> Sounds fun!
>
>
>> Update the task_struct's {closid, rmid} tuple *before* invoking
>> task_work_add(). As they can happen concurrently, wrap {closid, rmid}
>> accesses with READ_ONCE() and WRITE_ONCE(). Highlight the required ordering
>> with a pair of comments.
>
> ... and this one is if move_myself() or __resctrl_sched_in() runs while tsk is being
> written to on another CPU. It might get torn values, or multiple-reads get different values.
>
> The READ_ONCE/WRITE_ONCEry would have been easier to read as a separate patch as you touch
> all sites, and move/change some of them.
>

True, I initially only fixed up the reads/writes involved with
__rdtgroup_move_task(), but ended up coccinelle'ing the whole lot - which I
should have then moved to a dedicated patch. Thanks for powering through
it, I'll send a v2 with a neater split. 

> Regardless:
> Reviewed-by: James Morse <james.morse@arm.com>
>

Thanks!

>
> I don't 'get' memory-ordering, so one curiosity below:
>
>> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> index b6b5b95df833..135a51529f70 100644
>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> @@ -524,11 +524,13 @@ static void move_myself(struct callback_head *head)
>>  	 * If resource group was deleted before this task work callback
>>  	 * was invoked, then assign the task to root group and free the
>>  	 * resource group.
>> +	 *
>> +	 * See pairing atomic_inc() in __rdtgroup_move_task()
>>  	 */
>>  	if (atomic_dec_and_test(&rdtgrp->waitcount) &&
>>  	    (rdtgrp->flags & RDT_DELETED)) {
>> -		current->closid = 0;
>> -		current->rmid = 0;
>> +		WRITE_ONCE(current->closid, 0);
>> +		WRITE_ONCE(current->rmid, 0);
>>  		kfree(rdtgrp);
>>  	}
>>  
>> @@ -553,14 +555,32 @@ static int __rdtgroup_move_task(struct task_struct *tsk,
>
>>  	/*
>>  	 * Take a refcount, so rdtgrp cannot be freed before the
>>  	 * callback has been invoked.
>> +	 *
>> +	 * Also ensures above {closid, rmid} writes are observed by
>> +	 * move_myself(), as it can run immediately after task_work_add().
>> +	 * Otherwise old values may be loaded, and the move will only actually
>> +	 * happen at the next context switch.
>
> But __resctrl_sched_in() can still occur at anytime and READ_ONCE() a pair of values that
> don't go together?

Yes, the thought did cross my mind...

> I don't think this is a problem for RDT as with old-rmid the task was a member of that
> monitor-group previously, and 'freed' rmid are kept in limbo for a while after.
> (old-closid is the same as the task having not schedule()d since the change, which is fine).
>
> For MPAM, this is more annoying as changing just the closid may put the task in a
> monitoring group that never existed, meaning its surprise dirty later.
>
> If this all makes sense, I guess the fix (for much later) is to union closid/rmid, and
> WRITE_ONCE() them together where necessary.
> (I've made a note for when I next pass that part of the MPAM tree)
>

It does make sense to me - one more question back to you: can RDT exist on
an X86_32 system? It shouldn't be a stopper, but would be an inconvenience.

FWIW kernel/sched/fair.c uses two synced u64's for this; see

  struct cfs_rq { .min_vruntime, .min_vruntime_copy }

and

  kernel/sched/fair.c:update_min_vruntime()
  kernel/sched/fair.c:migrate_task_rq_fair()
>
>> +	 *
>> +	 * Pairs with atomic_dec() in move_myself().
>>  	 */
>>  	atomic_inc(&rdtgrp->waitcount);
>> +
>>  	ret = task_work_add(tsk, &callback->work, TWA_RESUME);
>>  	if (ret) {
>>  		/*
>
>
> Thanks!
>
> James

