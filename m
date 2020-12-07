Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10DED2D158E
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 17:07:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727440AbgLGQHa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 11:07:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:52332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725994AbgLGQHa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 11:07:30 -0500
Date:   Mon, 7 Dec 2020 08:06:48 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607357209;
        bh=i+seZr7VqfNGgwLm3kHrQbZ8rgv9VLIp3uYfQdQVJtQ=;
        h=From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=cL8X5GJdOEVM+H9bXQR9RCtpf+86SWG4qOBw197I6JTlLQDbl5nEI5gZgtW0uKIdp
         VUYyCInp5joOPrwaaaLxfUy8VKYvwfMN7lzw8c2NbGtNMiEJuvPcFD+/YVgHcQwBdt
         VwLJPKNrqYsJ/Qid1fKSeidZoudUPvWxZptq6prT9dJe/GJCTaWps2VANIVi+w85Qk
         SS+M80+UaYn+AUuEOL+2E+XWrTUhv31OVh0dYyKWif+iIX5QQmi4zsuTrdlnFvS49J
         qBhhWIoK//R3Cm/s9jl7fu1uAjn3qGFXdFd5hLMwyvJ8Py/TMMjNVil+YminFZJMqF
         w+FyHxU+3X5yw==
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Marco Elver <elver@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>
Subject: Re: timers: Move clearing of base::timer_running under base::lock
Message-ID: <20201207160648.GF2657@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <87lfea7gw8.fsf@nanos.tec.linutronix.de>
 <20201207130753.kpxf2ydroccjzrge@linutronix.de>
 <87a6up7kpt.fsf@nanos.tec.linutronix.de>
 <20201207152533.rybefuzd57kxxv57@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201207152533.rybefuzd57kxxv57@linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 07, 2020 at 04:25:33PM +0100, Sebastian Andrzej Siewior wrote:
> On 2020-12-07 15:29:50 [+0100], Thomas Gleixner wrote:
> > On Mon, Dec 07 2020 at 14:07, Sebastian Andrzej Siewior wrote:
> > > One thing I noticed while testing it is that the "corner" case in
> > > timer_sync_wait_running() is quite reliably hit by rcu_preempt
> > > rcu_gp_fqs_loop() -> swait_event_idle_timeout_exclusive() invocation.
> > 
> > I assume it's something like this:
> > 
> >      timeout -> wakeup
> > 
> > ->preemption
> >         del_timer_sync()
> >                 .....
> 
> Yes, but it triggers frequently. Like `rcuc' is somehow is aligned with
> the timeout.

Given that a lot of RCU processing is event-driven based on timers,
and given that the scheduling-clock interrupts are synchronized for
energy-efficiency reasons on many configs, maybe this alignment is
expected behavior?

							Thanx, Paul

> |          <idle>-0       [007] dN.h4..    46.299705: sched_wakeup: comm=rcuc/7 pid=53 prio=98 target_cpu=007
> |          <idle>-0       [007] d...2..    46.299728: sched_switch: prev_comm=swapper/7 prev_pid=0 prev_prio=120 prev_state=R ==> next_comm=rcuc/7 next_pid=53 next_prio=98
> |          rcuc/7-53      [007] d...2..    46.299742: sched_switch: prev_comm=rcuc/7 prev_pid=53 prev_prio=98 prev_state=S ==> next_comm=ksoftirqd/7 next_pid=54 next_prio=120
> |     ksoftirqd/7-54      [007] .....13    46.299750: timer_expire_entry: timer=000000003bd1e045 function=process_timeout now=4294903802 baseclk=4294903802
> |     ksoftirqd/7-54      [007] d...213    46.299750: sched_waking: comm=rcu_preempt pid=11 prio=98 target_cpu=007
> |     ksoftirqd/7-54      [007] dN..313    46.299754: sched_wakeup: comm=rcu_preempt pid=11 prio=98 target_cpu=007
> |     ksoftirqd/7-54      [007] dN..213    46.299756: sched_stat_runtime: comm=ksoftirqd/7 pid=54 runtime=13265 [ns] vruntime=3012610540 [ns]
> |     ksoftirqd/7-54      [007] d...213    46.299760: sched_switch: prev_comm=ksoftirqd/7 prev_pid=54 prev_prio=120 prev_state=R+ ==> next_comm=rcu_preempt next_pid=11 next_prio=98
> |     rcu_preempt-11      [007] d...311    46.299766: sched_pi_setprio: comm=ksoftirqd/7 pid=54 oldprio=120 newprio=98
> del_timer_sync()
> |     rcu_preempt-11      [007] d...211    46.299773: sched_switch: prev_comm=rcu_preempt prev_pid=11 prev_prio=98 prev_state=R+ ==> next_comm=ksoftirqd/7 next_pid=54 next_prio=98
> |     ksoftirqd/7-54      [007] .....13    46.299774: timer_expire_exit: timer=000000003bd1e045
> |     ksoftirqd/7-54      [007] dN..311    46.299784: sched_pi_setprio: comm=ksoftirqd/7 pid=54 oldprio=98 newprio=120
> |     ksoftirqd/7-54      [007] dN..311    46.299788: sched_waking: comm=rcu_preempt pid=11 prio=98 target_cpu=007
> |     ksoftirqd/7-54      [007] dN..411    46.299790: sched_wakeup: comm=rcu_preempt pid=11 prio=98 target_cpu=007
> |     ksoftirqd/7-54      [007] dN..311    46.299792: sched_stat_runtime: comm=ksoftirqd/7 pid=54 runtime=7404 [ns] vruntime=3012617944 [ns]
> |     ksoftirqd/7-54      [007] d...2..    46.299797: sched_switch: prev_comm=ksoftirqd/7 prev_pid=54 prev_prio=120 prev_state=S ==> next_comm=rcu_preempt next_pid=11 next_prio=98
> 
> 
> > Thanks,
> > 
> >         tglx
> 
> Sebastian
