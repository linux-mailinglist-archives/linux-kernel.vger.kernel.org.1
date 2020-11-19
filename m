Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0D482B95EA
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 16:17:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728254AbgKSPOM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 10:14:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:33492 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727699AbgKSPOL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 10:14:11 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-104-11.bvtn.or.frontiernet.net [50.39.104.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9E78922202;
        Thu, 19 Nov 2020 15:14:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605798849;
        bh=O0F77QORdyXIOJ8KhKLqKUGe5MOFzgcomRJIXAE1PzU=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=owzVPshzbN5pfQpIxJqX/8Pilxys5Ch4xqLCORBsfx6GgcovXoctWIZNKJ687Y0Il
         EtybIbBaHu5XmbfnFqPTQRgRIyOxoALkpvJHC0qodKa6WSdTVa1I5KnSmISXWTwcyF
         zK5SqJAwtpPRkdDQj8BESX7+5JsoqUeQE0FPFgOU=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 3A16435225C9; Thu, 19 Nov 2020 07:14:09 -0800 (PST)
Date:   Thu, 19 Nov 2020 07:14:09 -0800
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
        Peter Zijlstra <peterz@infradead.org>,
        Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: Re: [PATCH] kfence: Avoid stalling work queue task without
 allocations
Message-ID: <20201119151409.GU1437@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20201112001129.GD3249@paulmck-ThinkPad-P72>
 <CANpmjNNyZs6NrHPmomC4=9MPEvCy1bFA5R2pRsMhG7=c3LhL_Q@mail.gmail.com>
 <20201112161439.GA2989297@elver.google.com>
 <20201112175406.GF3249@paulmck-ThinkPad-P72>
 <20201113175754.GA6273@paulmck-ThinkPad-P72>
 <20201117105236.GA1964407@elver.google.com>
 <20201117182915.GM1437@paulmck-ThinkPad-P72>
 <20201118225621.GA1770130@elver.google.com>
 <20201118233841.GS1437@paulmck-ThinkPad-P72>
 <20201119125357.GA2084963@elver.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201119125357.GA2084963@elver.google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 19, 2020 at 01:53:57PM +0100, Marco Elver wrote:
> On Wed, Nov 18, 2020 at 03:38PM -0800, Paul E. McKenney wrote:
> > On Wed, Nov 18, 2020 at 11:56:21PM +0100, Marco Elver wrote:
> > > [...]
> > > I think I figured out one piece of the puzzle. Bisection keeps pointing
> > > me at some -rcu merge commit, which kept throwing me off. Nor did it
> > > help that reproduction is a bit flaky. However, I think there are 2
> > > independent problems, but the manifestation of 1 problem triggers the
> > > 2nd problem:
> > > 
> > > 1. problem: slowed forward progress (workqueue lockup / RCU stall reports)
> > > 
> > > 2. problem: DEADLOCK which causes complete system lockup
> > > 
> > > 	| ...
> > > 	|        CPU0
> > > 	|        ----
> > > 	|   lock(rcu_node_0);
> > > 	|   <Interrupt>
> > > 	|     lock(rcu_node_0);
> > > 	| 
> > > 	|  *** DEADLOCK ***
> > > 	| 
> > > 	| 1 lock held by event_benchmark/105:
> > > 	|  #0: ffffbb6e0b804458 (rcu_node_0){?.-.}-{2:2}, at: print_other_cpu_stall kernel/rcu/tree_stall.h:493 [inline]
> > > 	|  #0: ffffbb6e0b804458 (rcu_node_0){?.-.}-{2:2}, at: check_cpu_stall kernel/rcu/tree_stall.h:652 [inline]
> > > 	|  #0: ffffbb6e0b804458 (rcu_node_0){?.-.}-{2:2}, at: rcu_pending kernel/rcu/tree.c:3752 [inline]
> > > 	|  #0: ffffbb6e0b804458 (rcu_node_0){?.-.}-{2:2}, at: rcu_sched_clock_irq+0x428/0xd40 kernel/rcu/tree.c:2581
> > > 	| ...
> > > 
> > > Problem 2 can with reasonable confidence (5 trials) be fixed by reverting:
> > > 
> > > 	rcu: Don't invoke try_invoke_on_locked_down_task() with irqs disabled
> > > 
> > > At which point the system always boots to user space -- albeit with a
> > > bunch of warnings still (attached). The supposed "good" version doesn't
> > > end up with all those warnings deterministically, so I couldn't say if
> > > the warnings are expected due to recent changes or not (Arm64 QEMU
> > > emulation, 1 CPU, and lots of debugging tools on).
> > > 
> > > Does any of that make sense?
> > 
> > Marco, it makes all too much sense!  :-/
> > 
> > Does the patch below help?
> > 
> > 							Thanx, Paul
> > 
> > ------------------------------------------------------------------------
> > 
> > commit 444ef3bbd0f243b912fdfd51f326704f8ee872bf
> > Author: Peter Zijlstra <peterz@infradead.org>
> > Date:   Sat Aug 29 10:22:24 2020 -0700
> > 
> >     sched/core: Allow try_invoke_on_locked_down_task() with irqs disabled
> 
> My assumption is that this is a replacement for "rcu: Don't invoke
> try_invoke_on_locked_down_task() with irqs disabled", right?

Hmmm...  It was actually intended to be in addition.

> That seems to have the same result (same test setup) as only reverting
> "rcu: Don't invoke..." does: still results in a bunch of workqueue
> lockup warnings and RCU stall warnings, but boots to user space. I
> attached a log. If the warnings are expected (are they?), then it looks
> fine to me.

No, they are not at all expected, but might be a different symptom
of the original problem.  Please see below.

> (And just in case: with "rcu: Don't invoke..." and "sched/core:
> Allow..." both applied I still get DEADLOCKs -- but that's probably
> expected.)

As noted earlier, it is a surprise.  Could you please send me the
console output?

> Thanks,
> -- Marco

> Testing all events: OK
> hrtimer: interrupt took 17120368 ns
> Running tests again, along with the function tracer
> Running tests on all trace events:
> Testing all events: 
> BUG: workqueue lockup - pool cpus=0 node=0 flags=0x0 nice=0 stuck for 12s!
> Showing busy workqueues and worker pools:
> workqueue events: flags=0x0
>   pwq 0: cpus=0 node=0 flags=0x0 nice=0 active=1/256 refcnt=2
>     pending: vmstat_shepherd
> BUG: workqueue lockup - pool cpus=0 node=0 flags=0x0 nice=0 stuck for 17s!
> Showing busy workqueues and worker pools:
> workqueue events: flags=0x0
>   pwq 0: cpus=0 node=0 flags=0x0 nice=0 active=1/256 refcnt=2
>     pending: vmstat_shepherd
> workqueue events_power_efficient: flags=0x82
>   pwq 2: cpus=0 flags=0x4 nice=0 active=1/256 refcnt=3
>     pending: neigh_periodic_work
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 1 at kernel/rcu/tree_stall.h:758 rcu_check_gp_start_stall kernel/rcu/tree_stall.h:750 [inline]
> WARNING: CPU: 0 PID: 1 at kernel/rcu/tree_stall.h:758 rcu_check_gp_start_stall.isra.0+0x14c/0x210 kernel/rcu/tree_stall.h:711

I have different line numbering, but the only warning that I see in this
function is the one complaining that RCU has been ignoring a request to
start a grace period for too long.  This usually happens because the RCU
grace-period kthread (named "rcu_preempt" in your case, but can also be
named "rcu_sched") is being prevented from running, but can be caused
by other things as well.

> Modules linked in:
> CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.10.0-rc3-next-20201110-00003-g920304642405-dirty #30
> Hardware name: linux,dummy-virt (DT)
> pstate: 20000085 (nzCv daIf -PAN -UAO -TCO BTYPE=--)
> pc : rcu_check_gp_start_stall kernel/rcu/tree_stall.h:750 [inline]
> pc : rcu_check_gp_start_stall.isra.0+0x14c/0x210 kernel/rcu/tree_stall.h:711
> lr : __xchg_mb arch/arm64/include/asm/cmpxchg.h:88 [inline]
> lr : atomic_xchg include/asm-generic/atomic-instrumented.h:615 [inline]
> lr : rcu_check_gp_start_stall kernel/rcu/tree_stall.h:751 [inline]
> lr : rcu_check_gp_start_stall.isra.0+0x148/0x210 kernel/rcu/tree_stall.h:711

Two program counters and four link registers?  Awesome!  ;-)

> sp : ffff800010003d20
> x29: ffff800010003d20 x28: ffff274ac3a10000 
> x27: 0000000000000000 x26: ffff274b3dbe72d8 
> x25: ffffbcb867722000 x24: 0000000000000000 
> x23: 0000000000000000 x22: ffffbcb8681d1260 
> x21: ffffbcb86735b000 x20: ffffbcb867404440 
> x19: ffffbcb867404440 x18: 0000000000000123 
> x17: ffffbcb865d400f0 x16: 0000000000000002 
> x15: 0000000000000002 x14: 0000000000000000 
> x13: 003d090000000000 x12: 00001e8480000000 
> x11: ffffbcb867958980 x10: ffff800010003cf0 
> x9 : ffffbcb864f4b7c8 x8 : 0000000000000080 
> x7 : 0000000000000026 x6 : ffffbcb86774e4c0 
> x5 : 0000000000000000 x4 : 00000000d4001f4b 
> x3 : 0000000000000000 x2 : 0000000000000000 
> x1 : 0000000000000001 x0 : 0000000000000000 
> Call trace:
>  rcu_check_gp_start_stall kernel/rcu/tree_stall.h:750 [inline]
>  rcu_check_gp_start_stall.isra.0+0x14c/0x210 kernel/rcu/tree_stall.h:711
>  rcu_core+0x168/0x9e0 kernel/rcu/tree.c:2719
>  rcu_core_si+0x18/0x28 kernel/rcu/tree.c:2737

The RCU_SOFTIRQ handler is causing this checking to occur, for whatever
that is worth.

>  __do_softirq+0x188/0x6b4 kernel/softirq.c:298
>  do_softirq_own_stack include/linux/interrupt.h:568 [inline]
>  invoke_softirq kernel/softirq.c:393 [inline]
>  __irq_exit_rcu kernel/softirq.c:423 [inline]
>  irq_exit+0x1cc/0x1e0 kernel/softirq.c:447
>  __handle_domain_irq+0xb4/0x130 kernel/irq/irqdesc.c:690
>  handle_domain_irq include/linux/irqdesc.h:170 [inline]
>  gic_handle_irq+0x70/0x108 drivers/irqchip/irq-gic.c:370
>  el1_irq+0xc0/0x180 arch/arm64/kernel/entry.S:651
>  arch_local_irq_restore+0x8/0x10 arch/arm64/include/asm/irqflags.h:124
>  release_probes kernel/tracepoint.c:113 [inline]
>  tracepoint_remove_func kernel/tracepoint.c:315 [inline]
>  tracepoint_probe_unregister+0x220/0x378 kernel/tracepoint.c:382
>  trace_event_reg+0x58/0x150 kernel/trace/trace_events.c:298
>  __ftrace_event_enable_disable+0x424/0x608 kernel/trace/trace_events.c:412
>  ftrace_event_enable_disable kernel/trace/trace_events.c:495 [inline]
>  __ftrace_set_clr_event_nolock+0x120/0x180 kernel/trace/trace_events.c:811
>  __ftrace_set_clr_event+0x60/0x90 kernel/trace/trace_events.c:833
>  event_trace_self_tests+0xd4/0x114 kernel/trace/trace_events.c:3661
>  event_trace_self_test_with_function kernel/trace/trace_events.c:3734 [inline]
>  event_trace_self_tests_init+0x88/0xa8 kernel/trace/trace_events.c:3747
>  do_one_initcall+0xa4/0x500 init/main.c:1212
>  do_initcall_level init/main.c:1285 [inline]
>  do_initcalls init/main.c:1301 [inline]
>  do_basic_setup init/main.c:1321 [inline]
>  kernel_init_freeable+0x344/0x3c4 init/main.c:1521
>  kernel_init+0x20/0x16c init/main.c:1410
>  ret_from_fork+0x10/0x34 arch/arm64/kernel/entry.S:961
> irq event stamp: 3274113
> hardirqs last  enabled at (3274112): [<ffffbcb864f8aee4>] rcu_core+0x974/0x9e0 kernel/rcu/tree.c:2716
> hardirqs last disabled at (3274113): [<ffffbcb866233bf0>] __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:108 [inline]
> hardirqs last disabled at (3274113): [<ffffbcb866233bf0>] _raw_spin_lock_irqsave+0xb8/0x14c kernel/locking/spinlock.c:159
> softirqs last  enabled at (3272576): [<ffffbcb864e10b80>] __do_softirq+0x630/0x6b4 kernel/softirq.c:325
> softirqs last disabled at (3274101): [<ffffbcb864ec6c54>] do_softirq_own_stack include/linux/interrupt.h:568 [inline]
> softirqs last disabled at (3274101): [<ffffbcb864ec6c54>] invoke_softirq kernel/softirq.c:393 [inline]
> softirqs last disabled at (3274101): [<ffffbcb864ec6c54>] __irq_exit_rcu kernel/softirq.c:423 [inline]
> softirqs last disabled at (3274101): [<ffffbcb864ec6c54>] irq_exit+0x1cc/0x1e0 kernel/softirq.c:447
> ---[ end trace 902768efebf5a607 ]---
> rcu: rcu_preempt: wait state: RCU_GP_WAIT_GPS(1) ->state: 0x0 delta ->gp_activity 4452 ->gp_req_activity 3848 ->gp_wake_time 3848 ->gp_wake_seq 2696 ->gp_seq 2696 ->gp_seq_needed 2700 ->gp_flags 0x1

The last thing that RCU's grace-period kthread did was to go to sleep
waiting for a grace-period request (RCU_GP_WAIT_GPS).

> rcu: 	rcu_node 0:0 ->gp_seq 2696 ->gp_seq_needed 2700
> rcu: RCU callbacks invoked since boot: 2583
> rcu_tasks: RTGS_WAIT_CBS(11) since 567120 g:1 i:0/0 k. 
> rcu_tasks_rude: RTGS_WAIT_CBS(11) since 567155 g:1 i:0/1 k. 
> rcu_tasks_trace: RTGS_INIT(0) since 4295464549 g:0 i:0/0 k. N0 h:0/0/0
> rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
> 	(detected by 0, t=3752 jiffies, g=2705, q=8)
> rcu: All QSes seen, last rcu_preempt kthread activity 557 (4295471128-4295470571), jiffies_till_next_fqs=1, root ->qsmask 0x0
> rcu: rcu_preempt kthread starved for 557 jiffies! g2705 f0x2 RCU_GP_CLEANUP(7) ->state=0x0 ->cpu=0

And here we see that RCU's grace-period kthread has in fact been starved.

This kthread is now in RCU_GP_CLEANUP, perhaps because of the wakeup that is
sent in rcu_check_gp_kthread_starvation().

My current guess is that this is a consequence of the earlier failures,
but who knows?

							Thanx, Paul

> rcu: 	Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
> rcu: RCU grace-period kthread stack dump:
> task:rcu_preempt     state:R  running task     stack:    0 pid:   10 ppid:     2 flags:0x00000428
> Call trace:
>  __switch_to+0x10c/0x200 arch/arm64/kernel/process.c:578
>  context_switch kernel/sched/core.c:3772 [inline]
>  __schedule+0x2d8/0x980 kernel/sched/core.c:4521
>  preempt_schedule_common+0x4c/0x1a8 kernel/sched/core.c:4680
>  preempt_schedule+0x38/0x40 kernel/sched/core.c:4705
>  __raw_spin_unlock_irq include/linux/spinlock_api_smp.h:169 [inline]
>  _raw_spin_unlock_irq+0x84/0x98 kernel/locking/spinlock.c:199
>  rcu_gp_cleanup kernel/rcu/tree.c:2015 [inline]
>  rcu_gp_kthread+0x1038/0x1bd8 kernel/rcu/tree.c:2119
>  kthread+0x13c/0x188 kernel/kthread.c:292
>  ret_from_fork+0x10/0x34 arch/arm64/kernel/entry.S:961
> OK
> Testing ftrace filter: OK
> Loading compiled-in X.509 certificates
> input: gpio-keys as /devices/platform/gpio-keys/input/input0
> ALSA device list:
>   No soundcards found.
> TAP version 14
> 1..0
> uart-pl011 9000000.pl011: no DMA platform data
> EXT4-fs (sda): mounting ext3 file system using the ext4 subsystem
> EXT4-fs (sda): mounted filesystem with ordered data mode. Opts: (null)
> VFS: Mounted root (ext3 filesystem) readonly on device 8:0.
> devtmpfs: mounted
> Freeing unused kernel memory: 8832K
> Run /sbin/init as init process

