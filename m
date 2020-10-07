Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84096286249
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 17:39:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727746AbgJGPjd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 11:39:33 -0400
Received: from mail.efficios.com ([167.114.26.124]:41192 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726504AbgJGPjc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 11:39:32 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 3B8D92B8486;
        Wed,  7 Oct 2020 11:39:31 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id y8aq3lC37-5w; Wed,  7 Oct 2020 11:39:30 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id B5F322B8485;
        Wed,  7 Oct 2020 11:39:30 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com B5F322B8485
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1602085170;
        bh=oYcLhml/Vu2rcwrC6cdk1vAf2bRtvBVVdTcbv2NC41o=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=FrUcX1pyjwFje9H5PFWxcPg2MH02X2Ni8/NTW9EmPjHe20lkAfCoNMvmS8k5wq+KS
         WsEjkhWB6ifyNp2x9/h/14pOtogbRR3jf7P+/wNa2400Ftmyw6NNqB2IOlTgHCjGKD
         3sifN7K8SNOe/bECuqt0WQkZNXO8wkNqK2GIQhpu8JqHNGJYIQx4EPk8eMfjMqARau
         dMsxQfw1PLNN/ELRATU9h9d+QZ/uCckRPFaHYRpswCLlOwq+9U5pS75gna1r7LbLJb
         L/We+Tx9pJ+Hh/DPweN8oTtwE1H3nx0+pDb4yn9ZqwpZrdtUZjPnNZyq3B7bt3IeKH
         RIadKsqTBhexw==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 7ca02b-VvgA6; Wed,  7 Oct 2020 11:39:30 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id A7F702B8226;
        Wed,  7 Oct 2020 11:39:30 -0400 (EDT)
Date:   Wed, 7 Oct 2020 11:39:30 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Boqun Feng <boqun.feng@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Will Deacon <will@kernel.org>, paulmck <paulmck@kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Andrew Morton <akpm@linux-foundation.org>
Message-ID: <1286784649.11153.1602085170586.JavaMail.zimbra@efficios.com>
In-Reply-To: <20201007150704.GH2628@hirez.programming.kicks-ass.net>
References: <20200924172508.8724-1-mathieu.desnoyers@efficios.com> <20200924172508.8724-3-mathieu.desnoyers@efficios.com> <20201007150704.GH2628@hirez.programming.kicks-ass.net>
Subject: Re: [RFC PATCH 2/3] sched: membarrier: cover kthread_use_mm (v3)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3968 (ZimbraWebClient - FF81 (Linux)/8.8.15_GA_3968)
Thread-Topic: sched: membarrier: cover kthread_use_mm (v3)
Thread-Index: X4rtGzTiC/gdtRcWrfxY5lcPzEj2Wg==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Oct 7, 2020, at 11:07 AM, Peter Zijlstra peterz@infradead.org wrote:

> On Thu, Sep 24, 2020 at 01:25:07PM -0400, Mathieu Desnoyers wrote:
> 
>> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
>> index 2d95dc3f4644..bab6f4f2809f 100644
>> --- a/kernel/sched/core.c
>> +++ b/kernel/sched/core.c
>> @@ -3736,6 +3736,8 @@ context_switch(struct rq *rq, struct task_struct *prev,
>>  	 */
>>  	arch_start_context_switch(prev);
>>  
>> +	membarrier_switch_mm(rq, prev->mm, next->mm);
>> +
>>  	/*
>>  	 * kernel -> kernel   lazy + transfer active
>>  	 *   user -> kernel   lazy + mmgrab() active
>> @@ -3752,7 +3754,6 @@ context_switch(struct rq *rq, struct task_struct *prev,
>>  		else
>>  			prev->active_mm = NULL;
>>  	} else {                                        // to user
>> -		membarrier_switch_mm(rq, prev->active_mm, next->mm);
>>  		/*
>>  		 * sys_membarrier() requires an smp_mb() between setting
>>  		 * rq->curr / membarrier_switch_mm() and returning to userspace.
> 
> I was thinking... do we need the above, when:
> 
>> diff --git a/kernel/sched/membarrier.c b/kernel/sched/membarrier.c
>> index 8bc8b8a888b7..e5246580201b 100644
>> --- a/kernel/sched/membarrier.c
>> +++ b/kernel/sched/membarrier.c
>> @@ -112,13 +112,9 @@ static int membarrier_global_expedited(void)
>>  		    MEMBARRIER_STATE_GLOBAL_EXPEDITED))
>>  			continue;
>>  
>> -		/*
>> -		 * Skip the CPU if it runs a kernel thread. The scheduler
>> -		 * leaves the prior task mm in place as an optimization when
>> -		 * scheduling a kthread.
>> -		 */
>> +		/* Skip the CPU if it runs the idle thread. */
>>  		p = rcu_dereference(cpu_rq(cpu)->curr);
>> -		if (p->flags & PF_KTHREAD)
> 
> We retain this in the form:
> 
>		if ((p->flags & PF_KTHREAD) && !p-mm)
>			continue;
> 
>> +		if (is_idle_task(p))
>>  			continue;
>>  
>>  		__cpumask_set_cpu(cpu, tmpmask);
> 
> Specifically, we only care about kthreads when they're between
> kthread_use_mm() / kthread_unuse_mm(), and in that case they will have
> updated state already.
> 
> It's too late in the day to be sure about the memory ordering though;
> but if we see !->mm, they'll do/have-done switch_mm() which implies
> sufficient barriers().
> 
> Hmm?

Interesting. There are two things we want to ensure here:

1) That we issue an IPI or have the kthread issue the proper barriers when a kthread is
   using/unusing a mm,
2) That we don't issue an IPI to kthreads with NULL mm, so we don't disturb them.

Moving the membarrier_switch_mm to cover kthread cases was to ensure (2), but if we
add a p->mm NULL check in the global expedited iteration, I think we would be OK
leaving the stale runqueue's membarrier state while in lazy tlb state.

As far as (1) is concerned, I think your idea would work, because as you say we will
have the proper barriers in kthread use/unuse mm.

I just wonder whether having this stale membarrier state for lazy tlb is warranted
performance-wise, as it adds complexity: the rq membarrier state will therefore not be
relevant when we are in lazy tlb mode.

Thoughts ?

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
