Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A38652774B7
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 17:01:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728370AbgIXPBJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 11:01:09 -0400
Received: from mail.efficios.com ([167.114.26.124]:38396 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728233AbgIXPBJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 11:01:09 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id D6DBC2D53CC;
        Thu, 24 Sep 2020 11:01:07 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id nLOEPWIbPagi; Thu, 24 Sep 2020 11:01:07 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 5AD222D53CB;
        Thu, 24 Sep 2020 11:01:07 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 5AD222D53CB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1600959667;
        bh=5ZRlq7ZuFCz2+2F8HW2zumswqp4iesEAF1uFv08MBW0=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=NySRi5tbajQBlNy0v5RnJ6MH+iIXlAzVsRG9pI4iILSI4opmstXoRz+8htcydO9PV
         5RCE0VQnRWbDphklCX0vZFvjiqAgjrcChGZVzITFwYDxSK67Wdw7V+0ZSPpvrZZPya
         ZjjZsMJE91xqRyTTjFJeXBWWl7HrG7A73gTADrm8w1ne8g9v2vecfm8BJuD9D+Fn1o
         6MjTvS4jdXqe0SkVdA2JPqfCOpRucX7TIUm3eBPmWZFue2UcTkrOgLz+OO4KNdUrr/
         D0rXFq0tf7gpjd1NwglFspUtBXBtpmVJ7rYHCtrKELZF0NNAcM04UddWx505G1I3JX
         NRSb8cn/bpjLw==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 1l0-rTxCWbJ9; Thu, 24 Sep 2020 11:01:07 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 4B2BD2D5175;
        Thu, 24 Sep 2020 11:01:07 -0400 (EDT)
Date:   Thu, 24 Sep 2020 11:01:07 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Will Deacon <will@kernel.org>, paulmck <paulmck@kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Nicholas Piggin <npiggin@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>
Message-ID: <1511468187.68016.1600959667218.JavaMail.zimbra@efficios.com>
In-Reply-To: <20200816152330.GA87259@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
References: <20200814164358.4783-1-mathieu.desnoyers@efficios.com> <20200814164358.4783-2-mathieu.desnoyers@efficios.com> <20200816152330.GA87259@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
Subject: Re: [RFC PATCH 1/3] sched: fix exit_mm vs membarrier (v2)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3965 (ZimbraWebClient - FF80 (Linux)/8.8.15_GA_3963)
Thread-Topic: sched: fix exit_mm vs membarrier (v2)
Thread-Index: 9mxzdZP9+5HX7oIp3aImuECyfGJLug==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Aug 16, 2020, at 11:23 AM, Boqun Feng boqun.feng@gmail.com wrote:

> Hi Mathieu,
> 
> On Fri, Aug 14, 2020 at 12:43:56PM -0400, Mathieu Desnoyers wrote:
>> exit_mm should issue memory barriers after user-space memory accesses,
>> before clearing current->mm, to order user-space memory accesses
>> performed prior to exit_mm before clearing tsk->mm, which has the
>> effect of skipping the membarrier private expedited IPIs.
>> 
>> The membarrier system call can be issued concurrently with do_exit
>> if we have thread groups created with CLONE_VM but not CLONE_THREAD.
>> 
>> Here is the scenario I have in mind:
>> 
>> Two thread groups are created, A and B. Thread group B is created by
>> issuing clone from group A with flag CLONE_VM set, but not CLONE_THREAD.
>> Let's assume we have a single thread within each thread group (Thread A
>> and Thread B).
>> 
>> The AFAIU we can have:
>> 
>> Userspace variables:
>> 
>> int x = 0, y = 0;
>> 
>> CPU 0                   CPU 1
>> Thread A                Thread B
>> (in thread group A)     (in thread group B)
>> 
>> x = 1
>> barrier()
>> y = 1
>> exit()
>> exit_mm()
>> current->mm = NULL;
>>                         r1 = load y
>>                         membarrier()
>>                           skips CPU 0 (no IPI) because its current mm is NULL
>>                         r2 = load x
>>                         BUG_ON(r1 == 1 && r2 == 0)
>> 
>> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>> Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
>> Cc: Will Deacon <will@kernel.org>
>> Cc: Paul E. McKenney <paulmck@kernel.org>
>> Cc: Nicholas Piggin <npiggin@gmail.com>
>> Cc: Andy Lutomirski <luto@amacapital.net>
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Cc: Linus Torvalds <torvalds@linux-foundation.org>
>> Cc: Alan Stern <stern@rowland.harvard.edu>
>> Cc: linux-mm@kvack.org
>> ---
>> Changes since v1:
>> - Use smp_mb__after_spinlock rather than smp_mb.
>> - Document race scenario in commit message.
>> ---
>>  kernel/exit.c | 8 ++++++++
>>  1 file changed, 8 insertions(+)
>> 
>> diff --git a/kernel/exit.c b/kernel/exit.c
>> index 733e80f334e7..fe64e6e28dd5 100644
>> --- a/kernel/exit.c
>> +++ b/kernel/exit.c
>> @@ -475,6 +475,14 @@ static void exit_mm(void)
>>  	BUG_ON(mm != current->active_mm);
>>  	/* more a memory barrier than a real lock */
>>  	task_lock(current);
>> +	/*
>> +	 * When a thread stops operating on an address space, the loop
>> +	 * in membarrier_{private,global}_expedited() may not observe
> 
> Is it accurate to say that the correctness of
> membarrier_global_expedited() relies on the observation of ->mm? Because
> IIUC membarrier_global_expedited() loop doesn't check ->mm.

Good point, I was wrong. Will instead reword as:

        /*
         * When a thread stops operating on an address space, the loop
         * in membarrier_private_expedited() may not observe that
         * tsk->mm, and the loop in membarrier_global_expedited() may
         * not observe a MEMBARRIER_STATE_GLOBAL_EXPEDITED
         * rq->membarrier_state, so those would not issue an IPI.
         * Membarrier requires a memory barrier after accessing
         * user-space memory, before clearing tsk->mm or the
         * rq->membarrier_state.
         */

And I'll make sure exit_mm clears this_rq()->membarrier_state as well.

Thanks,

Mathieu

> 
> Regards,
> Boqun
> 
>> +	 * that tsk->mm, and not issue an IPI. Membarrier requires a
>> +	 * memory barrier after accessing user-space memory, before
>> +	 * clearing tsk->mm.
>> +	 */
>> +	smp_mb__after_spinlock();
>>  	current->mm = NULL;
>>  	mmap_read_unlock(mm);
>>  	enter_lazy_tlb(mm, current);
>> --
>> 2.11.0

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
