Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 461A72D089A
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 01:26:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727468AbgLGAY2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Dec 2020 19:24:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:33910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726046AbgLGAY1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Dec 2020 19:24:27 -0500
Date:   Mon, 7 Dec 2020 01:23:43 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607300626;
        bh=uzg76RoAJKJBlTCkBlcr8KmqaTbxYyZzJiAiQV8KHdU=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=QWuf6IFkGprugo7CoBuF2Ygp2wRcPj8TKj2g7fNRWT3nebHxaOAFr8hnfgPcxGmbj
         wUq/U9FoZIUpeLj50iMZjOC86eVn1CzldO2eXu1C+EemGNfkqWS1RJHvjNnoXwYPUm
         Hl9zKAsepM8PIAs2PbElB2A/JH4f4x6naFnrUYhTPh5MYBYhJNylY8OeHJBqcNxajD
         ZNGioi4VzUd6/h4/ATQxA0aVGj8s0hLgx8jgX11NmQzNqKCShgGuznobn/IxPhMkgg
         VGzpa7NDGJIieic6NN3suyP7oTSWKIcJyKF89VIg3n5DZNLyEa/OGjn5T0VxlNXDEA
         rTu6u3xd/F3Lg==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Paul McKenney <paulmck@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [patch V2 2/9] irqtime: Make accounting correct on RT
Message-ID: <20201207002343.GA113660@lothringen>
References: <20201204170151.960336698@linutronix.de>
 <20201204170804.889561591@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201204170804.889561591@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 04, 2020 at 06:01:53PM +0100, Thomas Gleixner wrote:
> vtime_account_irq and irqtime_account_irq() base checks on preempt_count()
> which fails on RT because preempt_count() does not contain the softirq
> accounting which is seperate on RT.
> 
> These checks do not need the full preempt count as they only operate on the
> hard and softirq sections.
> 
> Use irq_count() instead which provides the correct value on both RT and non
> RT kernels. The compiler is clever enough to fold the masking for !RT:
> 
>        99b:	65 8b 05 00 00 00 00 	mov    %gs:0x0(%rip),%eax
>  -     9a2:	25 ff ff ff 7f       	and    $0x7fffffff,%eax
>  +     9a2:	25 00 ff ff 00       	and    $0xffff00,%eax
> 
> Reported-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
> V2: New patch
> ---
>  kernel/sched/cputime.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> --- a/kernel/sched/cputime.c
> +++ b/kernel/sched/cputime.c
> @@ -60,7 +60,7 @@ void irqtime_account_irq(struct task_str
>  	cpu = smp_processor_id();
>  	delta = sched_clock_cpu(cpu) - irqtime->irq_start_time;
>  	irqtime->irq_start_time += delta;
> -	pc = preempt_count() - offset;
> +	pc = irq_count() - offset;

There are many preempt_count() users all around waiting for similar issues.
Wouldn't it be more reasonable to have current->softirq_disable_cnt just saving
the softirq count on context switch?

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index d2003a7d5ab5..6c899c35d6ba 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3469,6 +3469,10 @@ static inline void prepare_task(struct task_struct *next)
 
 static inline void finish_task(struct task_struct *prev)
 {
+#ifdef CONFIG_PREEMPT_RT
+	prev->softirq_disable_cnt = softirq_count();
+	__preempt_count_sub(prev->softirq_disable_cnt);
+#endif
 #ifdef CONFIG_SMP
 	/*
 	 * This must be the very last reference to @prev from this CPU. After
@@ -3610,6 +3614,9 @@ static struct rq *finish_task_switch(struct task_struct *prev)
 	vtime_task_switch(prev);
 	perf_event_task_sched_in(prev, current);
 	finish_task(prev);
+#ifdef CONFIG_PREEMPT_RT	
+	__preempt_count_add(current->softirq_disable_cnt);
+#endif
 	finish_lock_switch(rq);
 	finish_arch_post_lock_switch();
 	kcov_finish_switch(current);


And I expect a few adjustments in schedule_debug() and atomic checks more
generally but that should be it and it would probably be less error-prone.
Although I'm probably overlooking other issues on the way.

Thanks.

>  
>  	/*
>  	 * We do not account for softirq time from ksoftirqd here.
> @@ -421,7 +421,7 @@ void vtime_task_switch(struct task_struc
>  
>  void vtime_account_irq(struct task_struct *tsk, unsigned int offset)
>  {
> -	unsigned int pc = preempt_count() - offset;
> +	unsigned int pc = irq_count() - offset;
>  
>  	if (pc & HARDIRQ_OFFSET) {
>  		vtime_account_hardirq(tsk);
> 
