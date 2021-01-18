Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62E932F9C83
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 11:35:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389057AbhARJmt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 04:42:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388852AbhARJbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 04:31:23 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8B1EC061573
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 01:30:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6bZ+tjVem9NiiCz8+tie0IkJT1+H8oQhEMfEUdICqAE=; b=HNiuzpCLRr3uBFJSeD25QxwNLQ
        Q4usXQ69KZcrf7I4Ebz1eeJLKRmcPdmunGrQuUlPQCXi2s9K2qVElCJeKYEBAPiC1Iu8iMaWDSmtA
        4jyF6sS/S6dsun2VPAS/qswGgYeDJyuK4oYRbTlBe+U7FAypSvIAJK+2fb0yTvD7NScWYMYOw3LSU
        L8UgZRL9xy3GOpoRb/hcC0x8Y2y18eLtvCXK4CMZs2FtL2bKxzFJSeQuNW7S55NZjbTOyqzgpi+Vl
        ccKFhmBCq819aSHox134YRoX3GbOs954TYG8v4ZYezEJ0l0iAoz5eB/lUoAcAswyJZfkV/RS9Hkm5
        rM8XAsCQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l1Qrj-0005oW-8Z; Mon, 18 Jan 2021 09:30:28 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8A70830015A;
        Mon, 18 Jan 2021 10:30:21 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4FB5F20291083; Mon, 18 Jan 2021 10:30:21 +0100 (CET)
Date:   Mon, 18 Jan 2021 10:30:21 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     mingo@kernel.org, tglx@linutronix.de, linux-kernel@vger.kernel.org,
        jiangshanlai@gmail.com, cai@redhat.com, vincent.donnefort@arm.com,
        decui@microsoft.com, paulmck@kernel.org,
        vincent.guittot@linaro.org, rostedt@goodmis.org, tj@kernel.org
Subject: Re: [PATCH 7/8] sched: Fix CPU hotplug / tighten is_per_cpu_kthread()
Message-ID: <YAVVLRWCLbnQoXz2@hirez.programming.kicks-ass.net>
References: <20210116113033.608340773@infradead.org>
 <20210116113920.103635633@infradead.org>
 <jhjsg6z4i2w.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <jhjsg6z4i2w.mognet@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 17, 2021 at 04:57:27PM +0000, Valentin Schneider wrote:
> On 16/01/21 12:30, Peter Zijlstra wrote:
> > @@ -1796,13 +1796,28 @@ static inline bool rq_has_pinned_tasks(s
> >   */
> >  static inline bool is_cpu_allowed(struct task_struct *p, int cpu)
> >  {
> > +	/* When not in the task's cpumask, no point in looking further. */
> >       if (!cpumask_test_cpu(cpu, p->cpus_ptr))
> >               return false;
> >
> > +	/* migrate_disabled() must be allowed to finish. */
> > +	if (is_migration_disabled(p))
> >               return cpu_online(cpu);
> >
> > +	/* Non kernel threads are not allowed during either online or offline. */
> > +	if (!(p->flags & PF_KTHREAD))
> > +		return cpu_active(cpu);
> > +
> > +	/* KTHREAD_IS_PER_CPU is always allowed. */
> > +	if (kthread_is_per_cpu(p))
> > +		return cpu_online(cpu);
> > +
> > +	/* Regular kernel threads don't get to stay during offline. */
> > +	if (cpu_rq(cpu)->balance_callback == &balance_push_callback)
> > +		return cpu_active(cpu);
> 
> is_cpu_allowed(, cpu) isn't guaranteed to have cpu_rq(cpu)'s rq_lock
> held, so this can race with balance_push_set(, true). This shouldn't
> matter under normal circumstances as we'll have sched_cpu_wait_empty()
> further down the line.
> 
> This might get ugly with the rollback faff - this is jumping the gun a
> bit, but that's something we'll have to address, and I think what I'm
> concerned about is close to what you mentioned in
> 
>   http://lore.kernel.org/r/YAM1t2Qzr7Rib3bN@hirez.programming.kicks-ass.net
> 
> Here's what I'm thinking of:
> 
> _cpu_up()                            ttwu()
>                                        select_task_rq()
>                                          is_cpu_allowed()
>                                            rq->balance_callback != balance_push_callback
>   smpboot_unpark_threads() // FAIL
>   (now going down, set push here)
>   sched_cpu_wait_empty()
>   ...                                  ttwu_queue()
>   sched_cpu_dying()
>   *ARGH*
> 

Let me try this then...

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 5057054b1cff..9b045296d646 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7495,6 +7495,8 @@ int sched_cpu_activate(unsigned int cpu)
 	return 0;
 }
 
+unsigned long sched_cpu_rcu_state;
+
 int sched_cpu_deactivate(unsigned int cpu)
 {
 	struct rq *rq = cpu_rq(cpu);
@@ -7519,6 +7521,11 @@ int sched_cpu_deactivate(unsigned int cpu)
 	 */
 	balance_push_set(cpu, true);
 
+	/*
+	 * See sched_cpu_wait_empty().
+	 */
+	sched_cpu_rcu_state = get_state_synchronize_rcu();
+
 	rq_lock_irqsave(rq, &rf);
 	if (rq->rd) {
 		update_rq_clock(rq);
@@ -7578,6 +7585,12 @@ int sched_cpu_starting(unsigned int cpu)
  */
 int sched_cpu_wait_empty(unsigned int cpu)
 {
+	/*
+	 * Guarantee that TTWU will observe balance_push_set(true),
+	 * such that all wakeups will refuse this CPU.
+	 */
+	cond_synchronize_rcu(sched_cpu_rcu_state);
+
 	balance_hotplug_wait();
 	return 0;
 }
