Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 392BD2AF8F0
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 20:22:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727855AbgKKTWE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 14:22:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:38400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726953AbgKKTVY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 14:21:24 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-104-11.bvtn.or.frontiernet.net [50.39.104.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9D5AC20658;
        Wed, 11 Nov 2020 19:21:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605122483;
        bh=LafJ6oCJWnOblQVCQ3oYdVp3bd8t6pBGaglg4BikY94=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=AqZT3O24tsLYPMGrUI4hcE2UEIAT6KtbRCur8nrmm2D7yHt1NOobTWIxACIEgFYck
         4fWTY8mUbTFc18XNv987ut2GQERuPeT/hZJNCvA03g398dbDegX+qfVsMAZ6MU3lvo
         a7KfzzKAusyi+FL4Tzq9IJ8XC6Q347ml4YVA6cII=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 3899535225D6; Wed, 11 Nov 2020 11:21:23 -0800 (PST)
Date:   Wed, 11 Nov 2020 11:21:23 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Marco Elver <elver@google.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Jann Horn <jannh@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        kasan-dev <kasan-dev@googlegroups.com>, rcu@vger.kernel.org,
        peterz@infradead.org
Subject: Re: [PATCH] kfence: Avoid stalling work queue task without
 allocations
Message-ID: <20201111192123.GB3249@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20201110135320.3309507-1-elver@google.com>
 <CADYN=9+=-ApMi_eEdAeHU6TyuQ7ZJSTQ8F-FCSD33kZH8HR+xg@mail.gmail.com>
 <CANpmjNM8MZphvkTSo=KgCBXQ6fNY4qo6NZD5SBHjNse_L9i5FQ@mail.gmail.com>
 <20201111133813.GA81547@elver.google.com>
 <20201111130543.27d29462@gandalf.local.home>
 <20201111182333.GA3249@paulmck-ThinkPad-P72>
 <20201111183430.GN517454@elver.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201111183430.GN517454@elver.google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 11, 2020 at 07:34:30PM +0100, Marco Elver wrote:
> On Wed, Nov 11, 2020 at 10:23AM -0800, Paul E. McKenney wrote:
> > On Wed, Nov 11, 2020 at 01:05:43PM -0500, Steven Rostedt wrote:
> > > On Wed, 11 Nov 2020 14:38:13 +0100
> > > Marco Elver <elver@google.com> wrote:
> > > 
> > > > [+Cc folks who can maybe help figure out what's going on, since I get
> > > >   warnings even without KFENCE on next-20201110.]
> > > > 
> > > > On Wed, Nov 11, 2020 at 09:29AM +0100, Marco Elver wrote:
> > > > > On Wed, 11 Nov 2020 at 00:23, Anders Roxell <anders.roxell@linaro.org> wrote:
> > > > > [...]
> > > > > > I gave them a spin on next-20201105 [1] and on next-20201110 [2].
> > > > > >
> > > > > > I eventually got to a prompt on next-20201105.
> > > > > > However, I got to this kernel panic on the next-20201110:
> > > > > >
> > > > > > [...]
> > > > > > [ 1514.089966][    T1] Testing event system initcall: OK
> > > > > > [ 1514.806232][    T1] Running tests on all trace events:
> > > > > > [ 1514.857835][    T1] Testing all events:
> > > > > > [ 1525.503262][    C0] hrtimer: interrupt took 10902600 ns
> > > > > > [ 1623.861452][    C0] BUG: workqueue lockup - pool cpus=0 node=0
> > > > > > flags=0x0 nice=0 stuck for 65s!
> > > > > > [...]
> > > 
> > > OK, so this blows up when you enable all events?
> > > 
> > > Note, it could just be adding overhead (which is exasperated with other
> > > debug options enabled), which could open up a race window.
> > >  
> > > 
> > > > > > [ 7823.104349][   T28]       Tainted: G        W
> > > > > > 5.10.0-rc3-next-20201110-00008-g8dc06700529d #3
> > > > > > [ 7833.206491][   T28] "echo 0 >
> > > > > > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> > > > > > [ 7840.750700][   T28] task:kworker/0:1     state:D stack:26640 pid:
> > > > > > 1872 ppid:     2 flags:0x00000428
> > > > > > [ 7875.642531][   T28] Workqueue: events toggle_allocation_gate
> > > > > > [ 7889.178334][   T28] Call trace:
> > > > > > [ 7897.066649][   T28]  __switch_to+0x1cc/0x1e0
> > > > > > [ 7905.326856][   T28]  0xffff00000f7077b0
> > > > > > [ 7928.354644][   T28] INFO: lockdep is turned off.
> > > > > > [ 7934.022572][   T28] Kernel panic - not syncing: hung_task: blocked tasks
> > > > > > [ 7934.032039][   T28] CPU: 0 PID: 28 Comm: khungtaskd Tainted: G
> > > > > >   W         5.10.0-rc3-next-20201110-00008-g8dc06700529d #3
> > > > > > [ 7934.045586][   T28] Hardware name: linux,dummy-virt (DT)
> > > > > > [ 7934.053677][   T28] Call trace:
> > > > > > [ 7934.060276][   T28]  dump_backtrace+0x0/0x420
> > > > > > [ 7934.067635][   T28]  show_stack+0x38/0xa0
> > > > > > [ 7934.091277][   T28]  dump_stack+0x1d4/0x278
> > > > > > [ 7934.098878][   T28]  panic+0x304/0x5d8
> > > > > > [ 7934.114923][   T28]  check_hung_uninterruptible_tasks+0x5e4/0x640
> > > > > > [ 7934.123823][   T28]  watchdog+0x138/0x160
> > > > > > [ 7934.131561][   T28]  kthread+0x23c/0x260
> > > > > > [ 7934.138590][   T28]  ret_from_fork+0x10/0x18
> > > > > > [ 7934.146631][   T28] Kernel Offset: disabled
> > > > > > [ 7934.153749][   T28] CPU features: 0x0240002,20002004
> > > > > > [ 7934.161476][   T28] Memory Limit: none
> > > > > > [ 7934.171272][   T28] ---[ end Kernel panic - not syncing: hung_task:
> > > > > > blocked tasks ]---
> > > > > >
> > > > > > Cheers,
> > > > > > Anders
> > > > > > [1] https://people.linaro.org/~anders.roxell/output-next-20201105-test.log
> > > > > > [2] https://people.linaro.org/~anders.roxell/output-next-20201110-test.log
> > > > > 
> > > > > Thanks for testing. The fact that it passes on next-20201105 but not
> > > > > on 20201110 is strange. If you boot with KFENCE disabled (boot param
> > > > > kfence.sample_interval=0), does it boot?
> > > > [...]
> > > > 
> > > > Right, so I think this is no longer KFENCE's fault. This looks like
> > > > something scheduler/RCU/ftrace related?! I notice that there have been
> > > > scheduler changes between next-20201105 and next-20201110.
> > > 
> > > I'm not sure any of that would cause this.
> > > 
> > > > 
> > > > I get this with KFENCE disabled:
> > > > 
> > > > | Running tests on all trace events:
> > > > | Testing all events: 
> > > > | BUG: workqueue lockup - pool cpus=0 node=0 flags=0x0 nice=0 stuck for 32s!
> > > > | Showing busy workqueues and worker pools:
> > > > | workqueue events: flags=0x0
> > > > |   pwq 0: cpus=0 node=0 flags=0x0 nice=0 active=1/256 refcnt=2
> > > > |     pending: vmstat_shepherd
> > > > | workqueue events_power_efficient: flags=0x82
> > > > |   pwq 2: cpus=0 flags=0x5 nice=0 active=2/256 refcnt=4
> > > > |     in-flight: 107:neigh_periodic_work
> > > > |     pending: do_cache_clean
> > > > | pool 2: cpus=0 flags=0x5 nice=0 hung=3s workers=2 manager: 7
> > > > | rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
> > > > | 	(detected by 0, t=6502 jiffies, g=2885, q=4)
> > > > | rcu: All QSes seen, last rcu_preempt kthread activity 5174 (4295523265-4295518091), jiffies_till_next_fqs=1, root ->qsmask 0x0
> > > > | rcu: rcu_preempt kthread starved for 5174 jiffies! g2885 f0x2 RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=0
> > > > | rcu: 	Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
> > > > | rcu: RCU grace-period kthread stack dump:
> > > > | task:rcu_preempt     state:R  running task     stack:    0 pid:   10 ppid:     2 flags:0x00000428
> > > > | Call trace:
> > > > |  __switch_to+0x100/0x1e0
> > > > |  __schedule+0x2d0/0x890
> > > > |  preempt_schedule_notrace+0x70/0x1c0
> > > > |  ftrace_ops_no_ops+0x174/0x250
> > > > |  ftrace_graph_call+0x0/0xc
> > > 
> > > Note, just because ftrace is called here, the blocked task was preempted
> > > when the ftrace code called preempt_enable_notrace().
> > > 
> > > 
> > > > |  preempt_count_add+0x1c/0x180
> > > > |  schedule+0x44/0x108
> > > > |  schedule_timeout+0x394/0x530
> > > > |  rcu_gp_kthread+0x76c/0x19a8
> > > > |  kthread+0x174/0x188
> > > > |  ret_from_fork+0x10/0x18
> > > > | 
> > > > | ================================
> > > > | WARNING: inconsistent lock state
> > > > | 5.10.0-rc3-next-20201110-00001-gc07b306d7fa5-dirty #18 Not tainted
> > > > | --------------------------------
> > > > | inconsistent {IN-HARDIRQ-W} -> {HARDIRQ-ON-W} usage.
> > > > | kcompactd0/26 [HC0[0]:SC0[0]:HE0:SE1] takes:
> > > > | ffffae32e6bd4358 (rcu_node_0){?.-.}-{2:2}, at: rcu_sched_clock_irq+0x4a0/0xd18
> > > > | {IN-HARDIRQ-W} state was registered at:
> > > 
> > > I did some digging here and it looks like the rcu_node lock could be taken
> > > without interrupts enabled when it does a stall print. That probably should
> > > be fixed, but it's a symptom of the underlining bug and not the cause.
> > 
> > Does this patch (in -next) help?
> > 
> > 							Thanx, Paul
>  
> >     rcu: Don't invoke try_invoke_on_locked_down_task() with irqs disabled
> 
> Sadly, no, next-20201110 already included that one, and that's what I
> tested and got me all those warnings above.

Hey, I had to ask!  The only uncertainty I seee is the acquisition of
the lock in rcu_iw_handler(), for which I add a lockdep check in the
(untested) patch below.  The other thing I could do is sprinkle such
checks through the stall-warning code on the assumption that something
RCU is calling is enabling interrupts.

Other thoughts?

							Thanx, Paul

------------------------------------------------------------------------

diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index 70d48c5..3d67650 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -189,6 +189,7 @@ static void rcu_iw_handler(struct irq_work *iwp)
 
 	rdp = container_of(iwp, struct rcu_data, rcu_iw);
 	rnp = rdp->mynode;
+	lockdep_assert_irqs_disabled();
 	raw_spin_lock_rcu_node(rnp);
 	if (!WARN_ON_ONCE(!rdp->rcu_iw_pending)) {
 		rdp->rcu_iw_gp_seq = rnp->gp_seq;
