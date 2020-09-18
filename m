Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 928C926F669
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 09:01:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726540AbgIRHBQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 03:01:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726154AbgIRHAG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 03:00:06 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BF02C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 00:00:05 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1600412403;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CUh0yM3VGv2eNPFk03IRR4TGjfFIgJ1jo2OXABZkwXY=;
        b=btkF6NI1FpaoRUGxtDhKylcY15PdhZrkc7kvdbeue793PBnV8ZsBwfmYVnmFrUT5Cbos1a
        lw2W7w1fge6e76RrdZAfutYUse5LrVZufYanh8MoXXFesOGJNuf84lGp6pRy837J8XxPIh
        EJeajny+w32QMTiadeou4rK/AhkylJiWnwSByCcHXwZC8XJW6C9ts0ewz0X81PPLCgupLM
        U0Ftk701wIajacZgbUQwkBYs2hOZK0ez+xnpGXvm4Ruj6daAKl/nm3W/hP0Y0K3aJLDA6F
        68bIdBD3VVYpN/AsQ2ANSnXPaFkUleSXrbvJ7wBtv1tN8yUs+Qmwbv/kz+YJ1g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1600412403;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CUh0yM3VGv2eNPFk03IRR4TGjfFIgJ1jo2OXABZkwXY=;
        b=ezLL/7HbBfSd8FQPIBVcqN6SbEqIYI1CBNuP7m/xgMZD9IhkpYeqJE49OsVkBuMPgVK1bj
        MfUzu6wx5j27otDw==
To:     peterz@infradead.org
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
In-Reply-To: <20200917142438.GH1362448@hirez.programming.kicks-ass.net>
References: <20200917094202.301694311@linutronix.de> <20200917101624.813835219@linutronix.de> <20200917142438.GH1362448@hirez.programming.kicks-ass.net>
Date:   Fri, 18 Sep 2020 09:00:03 +0200
Message-ID: <87bli3y3gs.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 17 2020 at 16:24, peterz wrote:
> On Thu, Sep 17, 2020 at 11:42:11AM +0200, Thomas Gleixner wrote:
>
>> +static inline void update_nr_migratory(struct task_struct *p, long delta)
>> +{
>> +	if (p->nr_cpus_allowed > 1 && p->sched_class->update_migratory)
>> +		p->sched_class->update_migratory(p, delta);
>> +}
>
> Right, so as you know, I totally hate this thing :-) It adds a second
> (and radically different) version of changing affinity. I'm working on a
> version that uses the normal *set_cpus_allowed*() interface.

Tried that back and forth and ended either up in locking hell or with
race conditions of sorts, but my scheduler foo is rusty.

>> +static inline void sched_migration_ctrl(struct task_struct *prev, int cpu)
>> +{
>> +	if (!prev->migration_ctrl.disable_cnt ||
>> +	    prev->cpus_ptr != &prev->cpus_mask)
>> +		return;
>> +
>> +	prev->cpus_ptr = cpumask_of(cpu);
>> +	update_nr_migratory(prev, -1);
>> +	prev->nr_cpus_allowed = 1;
>> +}
>
> So this thing is called from schedule(), with only rq->lock held, and
> that violates the locking rules for changing the affinity.
>
> I have a comment that explains how it's broken and why it's sort-of
> working.

Yeah :(

>> +void migrate_disable(void)
>> +{
>> +	unsigned long flags;
>> +
>> +	if (!current->migration_ctrl.disable_cnt) {
>> +		raw_spin_lock_irqsave(&current->pi_lock, flags);
>> +		current->migration_ctrl.disable_cnt++;
>> +		raw_spin_unlock_irqrestore(&current->pi_lock, flags);
>> +	} else {
>> +		current->migration_ctrl.disable_cnt++;
>> +	}
>> +}
>
> That pi_lock seems unfortunate, and it isn't obvious what the point of
> it is.

Indeed. That obviously lacks a big fat comment.

current->migration_ctrl.disable_cnt++ is obviously a RMW operation. So
you end up with the following:

CPU0                                            CPU1
migrate_disable()
   R = current->migration_ctrl.disable_cnt;
                                                set_cpus_allowed_ptr()
                                                  task_rq_lock();
                                                  if
                                                  (!p->migration_ctrl.disable_cnt) {
   current->migration_ctrl.disable_cnt = R + 1;
   							stop_one_cpu();
---> stopper_thread()
        BUG_ON(task->migration_ctrl.disable_cnt);

I tried to back out from that instead of BUG(), but that ended up being
even more of a hacky trainwreck than just biting the bullet and taking
pi_lock.

>
> So, what I'm missing with all this are the design contraints for this
> trainwreck. Because the 'sane' solution was having migrate_disable()
> imply cpus_read_lock(). But that didn't fly because we can't have
> migrate_disable() / migrate_enable() schedule for raisins.

Yeah. The original code had some magic

      if (preemptible())
      	    cpus_read_lock();
      else
            p->atomic_migrate_disable++;

but that caused another set of horrors with asymetric code like the
below and stuff like try_lock().

> And if I'm not mistaken, the above migrate_enable() *does* require being
> able to schedule, and our favourite piece of futex:
>
> 	raw_spin_lock_irq(&q.pi_state->pi_mutex.wait_lock);
> 	spin_unlock(q.lock_ptr);
>
> is broken. Consider that spin_unlock() doing migrate_enable() with a
> pending sched_setaffinity().

Yes, we have the extra migrate_disable()/enable() pair around that.

The other way I solved that was to have a spin_[un]lock() variant which
does not have a migrate disable/enable. That works in that code because
there is no per CPUness requirement. Not pretty either...

Thanks,

        tglx
