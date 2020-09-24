Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D5A427753A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 17:26:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728402AbgIXP0u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 11:26:50 -0400
Received: from mail.efficios.com ([167.114.26.124]:45984 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728285AbgIXP0t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 11:26:49 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 328082D55C7;
        Thu, 24 Sep 2020 11:26:48 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id NDMqWxTKxly2; Thu, 24 Sep 2020 11:26:47 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id C815F2D55C6;
        Thu, 24 Sep 2020 11:26:47 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com C815F2D55C6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1600961207;
        bh=PGfwt5U5NML2mjINchc3+DAt5mrL+wPPGXgN9Dzye8Q=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=YL6+wquo3pWf1a9fN7i309Hayq2cM0cu8HIBYKR/15niCwOJbEYY3Qxd4pyXahXbn
         A9YDCuynB1wmIf6sxqWflQVzcmwxCl/o26JImoOGv5ru/yRvACR/h3rLab6Zjp2EVd
         e1C2R3NxVTYtXXsfrLwO7+aqgiGOvScrx0D/Eu1s8qWhN/dA0aEuVVhks68SB7YLPr
         zCQEtlVY1Cu9wP7nBT6gFm70Icd0L3gWju1zeqBBSuQEeEMqG9ZyBRxcvM/qywkqZc
         8mFGg9N9Gc07TqZhWULazRaWslVaTN/M0ezdeZUt3q0Uad1DoRkZKD5PP9PdPLCucb
         D3zuPMq/wdm/g==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id cDyxUEfj1uaN; Thu, 24 Sep 2020 11:26:47 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id B9A392D52C0;
        Thu, 24 Sep 2020 11:26:47 -0400 (EDT)
Date:   Thu, 24 Sep 2020 11:26:47 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Will Deacon <will@kernel.org>, paulmck <paulmck@kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Nicholas Piggin <npiggin@gmail.com>
Message-ID: <977127494.68046.1600961207672.JavaMail.zimbra@efficios.com>
In-Reply-To: <20200825020640.GA72178@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
References: <20200814164358.4783-1-mathieu.desnoyers@efficios.com> <20200814164358.4783-3-mathieu.desnoyers@efficios.com> <20200816152907.GB87259@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net> <764014395.16126.1598282869127.JavaMail.zimbra@efficios.com> <20200825020640.GA72178@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
Subject: Re: [RFC PATCH 2/3] sched: membarrier: cover kthread_use_mm (v2)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3965 (ZimbraWebClient - FF80 (Linux)/8.8.15_GA_3963)
Thread-Topic: sched: membarrier: cover kthread_use_mm (v2)
Thread-Index: 8RKETO3lb9tRkpQ7wxH9UU76ffJhMQ==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Aug 24, 2020, at 10:06 PM, Boqun Feng boqun.feng@gmail.com wrote:

> On Mon, Aug 24, 2020 at 11:27:49AM -0400, Mathieu Desnoyers wrote:
>> ----- On Aug 16, 2020, at 11:29 AM, Boqun Feng boqun.feng@gmail.com wrote:
>> 
>> > On Fri, Aug 14, 2020 at 12:43:57PM -0400, Mathieu Desnoyers wrote:
>> >> Add comments and memory barrier to kthread_use_mm and kthread_unuse_mm
>> >> to allow the effect of membarrier(2) to apply to kthreads accessing
>> >> user-space memory as well.
>> >> 
>> >> Given that no prior kthread use this guarantee and that it only affects
>> >> kthreads, adding this guarantee does not affect user-space ABI.
>> >> 
>> >> Refine the check in membarrier_global_expedited to exclude runqueues
>> >> running the idle thread rather than all kthreads from the IPI cpumask.
>> >> 
>> >> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>> >> Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
>> >> Cc: Will Deacon <will@kernel.org>
>> >> Cc: Paul E. McKenney <paulmck@kernel.org>
>> >> Cc: Nicholas Piggin <npiggin@gmail.com>
>> >> Cc: Andy Lutomirski <luto@amacapital.net>
>> >> Cc: Andrew Morton <akpm@linux-foundation.org>
>> >> ---
>> >> Changes since v1:
>> >> - Add WARN_ON_ONCE(current->mm) in play_idle_precise (PeterZ),
>> >> - Use smp_mb__after_spinlock rather than smp_mb after task_lock.
>> >> ---
>> >>  kernel/kthread.c          | 19 +++++++++++++++++++
>> >>  kernel/sched/idle.c       |  1 +
>> >>  kernel/sched/membarrier.c |  8 ++------
>> >>  3 files changed, 22 insertions(+), 6 deletions(-)
>> >> 
>> >> diff --git a/kernel/kthread.c b/kernel/kthread.c
>> >> index 3edaa380dc7b..77aaaa7bc8d9 100644
>> >> --- a/kernel/kthread.c
>> >> +++ b/kernel/kthread.c
>> >> @@ -1255,8 +1255,19 @@ void kthread_use_mm(struct mm_struct *mm)
>> >>  	finish_arch_post_lock_switch();
>> >>  #endif
>> >>  
>> >> +	/*
>> >> +	 * When a kthread starts operating on an address space, the loop
>> >> +	 * in membarrier_{private,global}_expedited() may not observe
>> >> +	 * that tsk->mm, and not issue an IPI. Membarrier requires a
>> >> +	 * memory barrier after storing to tsk->mm, before accessing
>> >> +	 * user-space memory. A full memory barrier for membarrier
>> >> +	 * {PRIVATE,GLOBAL}_EXPEDITED is implicitly provided by
>> >> +	 * mmdrop(), or explicitly with smp_mb().
>> >> +	 */
>> >>  	if (active_mm != mm)
>> >>  		mmdrop(active_mm);
>> >> +	else
>> >> +		smp_mb();
>> > 
>> > Similar question here: could smp_mb() guarantee the correctness of
>> > GLOBAL_EXPEDITED? Don't you need membarrier_switch_mm() here and in
>> > kthread_unuse_mm(), too?
>> > 
>> > Am I miss something here?
>> 
>> I think you have a good point there. Which brings me to wonder why we
>> don't have membarrier_switch_mm() when entering/leaving lazy TLB mode.
>> This means an IPI can be sent to a kthread even if it does not use an
>> mm, just because the membarrier state in the runqueue is that of the
>> active_mm.
>> 
>> Thoughts ?
>> 
> 
> Right, I think we should also handle the percpu membarrier_state. The
> basic rule is whenever we change current->mm or current (i.e. rq->curr)
> itself, we need to update the percpu membarrier_state accordingly.

OK, so as we introduce IPIs to kthreads which are using kthread_use_mm, we need to
reconsider how the scheduler deals with runqueues entering lazy TLB state. Currently,
membarrier_switch_mm() is not issued when entering lazy TLB state. But as we
start considering kthreads as candidates for sending IPIs, we need to update
the rq->membarrier_state whenever we enter lazy TLB state as well.

So I plan to do this change to cover this:

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 84758f34cdb0..44521dc5602a 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3736,6 +3736,8 @@ context_switch(struct rq *rq, struct task_struct *prev,
         */
        arch_start_context_switch(prev);
 
+       membarrier_switch_mm(rq, prev->mm, next->mm);
+
        /*
         * kernel -> kernel   lazy + transfer active
         *   user -> kernel   lazy + mmgrab() active
@@ -3752,7 +3754,6 @@ context_switch(struct rq *rq, struct task_struct *prev,
                else
                        prev->active_mm = NULL;
        } else {                                        // to user
-               membarrier_switch_mm(rq, prev->active_mm, next->mm);
                /*
                 * sys_membarrier() requires an smp_mb() between setting
                 * rq->curr / membarrier_switch_mm() and returning to userspace.
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 3fd283892761..481149066086 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2592,12 +2592,13 @@ static inline void membarrier_switch_mm(struct rq *rq,
                                        struct mm_struct *prev_mm,
                                        struct mm_struct *next_mm)
 {
-       int membarrier_state;
+       int membarrier_state = 0;
 
        if (prev_mm == next_mm)
                return;
 
-       membarrier_state = atomic_read(&next_mm->membarrier_state);
+       if (next_mm)
+               membarrier_state = atomic_read(&next_mm->membarrier_state);
        if (READ_ONCE(rq->membarrier_state) == membarrier_state)
                return;

Thoughts ?

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
