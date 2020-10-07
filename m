Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 469D52861A6
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 16:57:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728734AbgJGO5y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 10:57:54 -0400
Received: from mail.efficios.com ([167.114.26.124]:57484 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728727AbgJGO5x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 10:57:53 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id CF1C62A7D26;
        Wed,  7 Oct 2020 10:57:52 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id O9AZFKOHq3-g; Wed,  7 Oct 2020 10:57:52 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 907BF2A7FA5;
        Wed,  7 Oct 2020 10:57:52 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 907BF2A7FA5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1602082672;
        bh=1Ktb8dVEjdCHzeKbUWH2JD+Y0IDfX3A/rL26vV5/0Ag=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=I27kyyO/RGK8dE2er29khZX9ggVc0M5cGtxto1/6T8w8xqkJp4WiuNE5z1LngdeG0
         dnKLtQOUrty5B2yDgs8EIEylzl0lw2qLD7Ojjid6aSpDO1OdjREa+UcE1y9iJNhwpt
         Tc18pbFJRG92Je2tSi7HD20qAf0PZuzF6XQu1vaCZ6VoqDpb92BTlSAsr+MIeWou3l
         +P3VWWpz3kFWTlqt+ZTmxqxKJLbD2YRqRkDfX6C4OXuvG4M6z/l8xrnk+z83bFWZWw
         AuxoqYl6O41rc2vCj2ArEpBxUYRTg/3+5JvZhjSLDxQX+Osvfee0h4/rWUrQIBBZRr
         zsdp9StiUixPA==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id N_SunlkMaROq; Wed,  7 Oct 2020 10:57:52 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 82DA82A7C1D;
        Wed,  7 Oct 2020 10:57:52 -0400 (EDT)
Date:   Wed, 7 Oct 2020 10:57:52 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Boqun Feng <boqun.feng@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Will Deacon <will@kernel.org>, paulmck <paulmck@kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        linux-mm <linux-mm@kvack.org>
Message-ID: <1929468067.11124.1602082672412.JavaMail.zimbra@efficios.com>
In-Reply-To: <20201007142947.GG2628@hirez.programming.kicks-ass.net>
References: <20200924172508.8724-1-mathieu.desnoyers@efficios.com> <20200924172508.8724-2-mathieu.desnoyers@efficios.com> <20201007142947.GG2628@hirez.programming.kicks-ass.net>
Subject: Re: [RFC PATCH 1/3] sched: fix exit_mm vs membarrier (v3)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3968 (ZimbraWebClient - FF81 (Linux)/8.8.15_GA_3968)
Thread-Topic: sched: fix exit_mm vs membarrier (v3)
Thread-Index: H5oSZrcmgKMm8xI6y1tQ8Xx6TofG7A==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Oct 7, 2020, at 10:29 AM, Peter Zijlstra peterz@infradead.org wrote:

> On Thu, Sep 24, 2020 at 01:25:06PM -0400, Mathieu Desnoyers wrote:
>> diff --git a/kernel/exit.c b/kernel/exit.c
>> index 733e80f334e7..0767a2dbf245 100644
>> --- a/kernel/exit.c
>> +++ b/kernel/exit.c
>> @@ -475,7 +475,19 @@ static void exit_mm(void)
>>  	BUG_ON(mm != current->active_mm);
>>  	/* more a memory barrier than a real lock */
>>  	task_lock(current);
>> +	/*
>> +	 * When a thread stops operating on an address space, the loop
>> +	 * in membarrier_private_expedited() may not observe that
>> +	 * tsk->mm, and the loop in membarrier_global_expedited() may
>> +	 * not observe a MEMBARRIER_STATE_GLOBAL_EXPEDITED
>> +	 * rq->membarrier_state, so those would not issue an IPI.
>> +	 * Membarrier requires a memory barrier after accessing
>> +	 * user-space memory, before clearing tsk->mm or the
>> +	 * rq->membarrier_state.
>> +	 */
>> +	smp_mb__after_spinlock();
>>  	current->mm = NULL;
>> +	membarrier_update_current_mm(NULL);
>>  	mmap_read_unlock(mm);
>>  	enter_lazy_tlb(mm, current);
>>  	task_unlock(current);
> 
> This site seems to be lacking in IRQ disabling. As proposed it will
> explode on RT.

Right, so irq off is needed for accessing this_rq()'s fields safely,
correct ?

I'll fold that fix in my patch for the next round, thanks!

Mathieu

> 
> Something like so to match kthread_unuse_mm().
> 
> --- a/kernel/exit.c
> +++ b/kernel/exit.c
> @@ -486,11 +486,13 @@ static void exit_mm(void)
> 	 * rq->membarrier_state.
> 	 */
> 	smp_mb__after_spinlock();
> +	local_irq_disable()
> 	current->mm = NULL;
> 	membarrier_update_current_mm(NULL);
> -	mmap_read_unlock(mm);
> 	enter_lazy_tlb(mm, current);
> +	local_irq_enable();
> 	task_unlock(current);
> +	mmap_read_unlock(mm);
> 	mm_update_next_owner(mm);
> 	mmput(mm);
>  	if (test_thread_flag(TIF_MEMDIE))

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
