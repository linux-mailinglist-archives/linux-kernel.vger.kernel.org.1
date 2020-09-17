Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E33526DE84
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 16:43:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727253AbgIQO2T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 10:28:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727300AbgIQOZR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 10:25:17 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBD8DC06121F
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 07:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=gCs180ytkKUaS+Wq9DNLh+g1KuuMb+5Nrrize9sxCw4=; b=aid0Kc3AP1igsdTelMDQ+ltCgV
        6kmiW8wuTsrgIHwexmYy6Ynzt0++k3i5gnZnAaQ0Z0v/fFZozcYAsx0cxzrZQtXD6X0vVh+f4veQk
        jQfjctW5YgeDu5jki7l7JJJoxnTyMBPrgtcl5HgzIPgw6VbfB6do1k+KjDgpdhUI/PflNnApqFLEu
        PfCchcJwSOeGxO7PqE2NAUlg//hq1VnP4iUEGEir3I72lXU+Nuenqns06CsTzrHtrOwa7/dr069jd
        qtcBuP4T7d4t1cbsL3oJmwSzghLQTN1Bz76KsbfePVwaLMGFIacT/o+eOFzE1z0E1ksk3IEHV5cFk
        E+oqSoXQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kIuq5-0006hc-18; Thu, 17 Sep 2020 14:24:45 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4FAE53011FE;
        Thu, 17 Sep 2020 16:24:38 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 412EB2BC7FEE5; Thu, 17 Sep 2020 16:24:38 +0200 (CEST)
Date:   Thu, 17 Sep 2020 16:24:38 +0200
From:   peterz@infradead.org
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Sebastian Siewior <bigeasy@linutronix.de>,
        Qais Yousef <qais.yousef@arm.com>,
        Scott Wood <swood@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Vincent Donnefort <vincent.donnefort@arm.com>
Subject: Re: [patch 09/10] sched/core: Add migrate_disable/enable()
Message-ID: <20200917142438.GH1362448@hirez.programming.kicks-ass.net>
References: <20200917094202.301694311@linutronix.de>
 <20200917101624.813835219@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200917101624.813835219@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 17, 2020 at 11:42:11AM +0200, Thomas Gleixner wrote:

> +static inline void update_nr_migratory(struct task_struct *p, long delta)
> +{
> +	if (p->nr_cpus_allowed > 1 && p->sched_class->update_migratory)
> +		p->sched_class->update_migratory(p, delta);
> +}

Right, so as you know, I totally hate this thing :-) It adds a second
(and radically different) version of changing affinity. I'm working on a
version that uses the normal *set_cpus_allowed*() interface.

> +/*
> + * The migrate_disable/enable() fastpath updates only the tasks migrate
> + * disable count which is sufficient as long as the task stays on the CPU.
> + *
> + * When a migrate disabled task is scheduled out it can become subject to
> + * load balancing. To prevent this, update task::cpus_ptr to point to the
> + * current CPUs cpumask and set task::nr_cpus_allowed to 1.
> + *
> + * If task::cpus_ptr does not point to task::cpus_mask then the update has
> + * been done already. This check is also used in in migrate_enable() as an
> + * indicator to restore task::cpus_ptr to point to task::cpus_mask
> + */
> +static inline void sched_migration_ctrl(struct task_struct *prev, int cpu)
> +{
> +	if (!prev->migration_ctrl.disable_cnt ||
> +	    prev->cpus_ptr != &prev->cpus_mask)
> +		return;
> +
> +	prev->cpus_ptr = cpumask_of(cpu);
> +	update_nr_migratory(prev, -1);
> +	prev->nr_cpus_allowed = 1;
> +}

So this thing is called from schedule(), with only rq->lock held, and
that violates the locking rules for changing the affinity.

I have a comment that explains how it's broken and why it's sort-of
working.

> +void migrate_disable(void)
> +{
> +	unsigned long flags;
> +
> +	if (!current->migration_ctrl.disable_cnt) {
> +		raw_spin_lock_irqsave(&current->pi_lock, flags);
> +		current->migration_ctrl.disable_cnt++;
> +		raw_spin_unlock_irqrestore(&current->pi_lock, flags);
> +	} else {
> +		current->migration_ctrl.disable_cnt++;
> +	}
> +}

That pi_lock seems unfortunate, and it isn't obvious what the point of
it is.

> +void migrate_enable(void)
> +{
> +	struct task_migrate_data *pending;
> +	struct task_struct *p = current;
> +	struct rq_flags rf;
> +	struct rq *rq;
> +
> +	if (WARN_ON_ONCE(p->migration_ctrl.disable_cnt <= 0))
> +		return;
> +
> +	if (p->migration_ctrl.disable_cnt > 1) {
> +		p->migration_ctrl.disable_cnt--;
> +		return;
> +	}
> +
> +	raw_spin_lock_irqsave(&p->pi_lock, rf.flags);
> +	p->migration_ctrl.disable_cnt = 0;
> +	pending = p->migration_ctrl.pending;
> +	p->migration_ctrl.pending = NULL;
> +
> +	/*
> +	 * If the task was never scheduled out while in the migrate
> +	 * disabled region and there is no migration request pending,
> +	 * return.
> +	 */
> +	if (!pending && p->cpus_ptr == &p->cpus_mask) {
> +		raw_spin_unlock_irqrestore(&p->pi_lock, rf.flags);
> +		return;
> +	}
> +
> +	rq = __task_rq_lock(p, &rf);
> +	/* Was it scheduled out while in a migrate disabled region? */
> +	if (p->cpus_ptr != &p->cpus_mask) {
> +		/* Restore the tasks CPU mask and update the weight */
> +		p->cpus_ptr = &p->cpus_mask;
> +		p->nr_cpus_allowed = cpumask_weight(&p->cpus_mask);
> +		update_nr_migratory(p, 1);
> +	}
> +
> +	/* If no migration request is pending, no further action required. */
> +	if (!pending) {
> +		task_rq_unlock(rq, p, &rf);
> +		return;
> +	}
> +
> +	/* Migrate self to the requested target */
> +	pending->res = set_cpus_allowed_ptr_locked(p, pending->mask,
> +						   pending->check, rq, &rf);
> +	complete(pending->done);
> +}

So, what I'm missing with all this are the design contraints for this
trainwreck. Because the 'sane' solution was having migrate_disable()
imply cpus_read_lock(). But that didn't fly because we can't have
migrate_disable() / migrate_enable() schedule for raisins.

And if I'm not mistaken, the above migrate_enable() *does* require being
able to schedule, and our favourite piece of futex:

	raw_spin_lock_irq(&q.pi_state->pi_mutex.wait_lock);
	spin_unlock(q.lock_ptr);

is broken. Consider that spin_unlock() doing migrate_enable() with a
pending sched_setaffinity().

Let me ponder this more..
