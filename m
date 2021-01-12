Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F27F02F407F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 01:56:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393481AbhAMAmz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 19:42:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:46554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392016AbhALXyF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 18:54:05 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id F3E1223131;
        Tue, 12 Jan 2021 23:53:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610495605;
        bh=+h7b3rUIhPENc+HKyVs0iLZILMk5fdaMSiKtpgPVn/4=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=ERpl4Hyq9+BN8HkaEcKE990bsUf1e38Srxlu2/3bzTq2iFH+/k69MOmBDPurReBal
         L1+i39xkWqwWlByAkif98cUnDjnpJTXw09OqbRtHtUUfcZArFHD0hLuenhLNCPS0qe
         49ODgHHu0Zl7et4DknxnVgfA6ljt0opD6T1GAwNZnxxFqy+/S7XCsNZrCMXQIw+wKN
         q7zjWt44xXLqc3u2NOohADQio2hAH85OvGbMUMilOblAkv0xEqcDMBFg/JKPaL+NSb
         7z+NevUu4fAl7FhMJ/6mYT+0sbhc0WYGTgRMpNnMt8DUqolhjtSSTVmyO2gb+DY57s
         axMbKC2XeY3DA==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id B027A3522AC3; Tue, 12 Jan 2021 15:53:24 -0800 (PST)
Date:   Tue, 12 Jan 2021 15:53:24 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kernel@vger.kernel.org,
        Valentin Schneider <valentin.schneider@arm.com>,
        Qian Cai <cai@redhat.com>,
        Vincent Donnefort <vincent.donnefort@arm.com>,
        Dexuan Cui <decui@microsoft.com>,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH -tip V3 0/8] workqueue: break affinity initiatively
Message-ID: <20210112235324.GA17895@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20201226025117.2770-1-jiangshanlai@gmail.com>
 <X/hGHNGB9fltElWB@hirez.programming.kicks-ass.net>
 <87o8hv7pnd.fsf@nanos.tec.linutronix.de>
 <X/wv7+PP8ywNYmIS@hirez.programming.kicks-ass.net>
 <X/yH9+MGa1JCNZ8x@hirez.programming.kicks-ass.net>
 <20210111180907.GE2743@paulmck-ThinkPad-P72>
 <20210111215052.GA19589@paulmck-ThinkPad-P72>
 <20210112171411.GA22823@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210112171411.GA22823@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 12, 2021 at 09:14:11AM -0800, Paul E. McKenney wrote:
> On Mon, Jan 11, 2021 at 01:50:52PM -0800, Paul E. McKenney wrote:
> > On Mon, Jan 11, 2021 at 10:09:07AM -0800, Paul E. McKenney wrote:
> > > On Mon, Jan 11, 2021 at 06:16:39PM +0100, Peter Zijlstra wrote:
> > > > 
> > > > While thinking more about this, I'm thinking a big part of the problem
> > > > is that we're not dinstinguishing between geniuine per-cpu kthreads and
> > > > kthreads that just happen to be per-cpu.
> > > > 
> > > > Geniuine per-cpu kthreads are kthread_bind() and have PF_NO_SETAFFINITY,
> > > > but sadly a lot of non-per-cpu kthreads, that might happen to still be
> > > > per-cpu also have that -- again workqueue does that even to it's unbound
> > > > workers :-(
> > > > 
> > > > Now, anything created by smpboot, is created through
> > > > kthread_create_on_cpu() and that additionally sets to_kthread(p)->flags
> > > > KTHREAD_IS_PER_CPU.
> > > > 
> > > > And I'm thinking that might be sufficient, if we modify
> > > > is_per_cpu_kthread() to check that, then we only match smpboot threads
> > > > (which include the hotplug and stopper threads, but notably not the idle
> > > > thread)
> > > > 
> > > > Sadly it appears like io_uring() uses kthread_create_on_cpu() without
> > > > then having any hotplug crud on, so that needs additinoal frobbing.
> > > > 
> > > > Also, init_task is PF_KTHREAD but doesn't have a struct kthread on.. and
> > > > I suppose bound workqueues don't go through this either.
> > > > 
> > > > Let me rummage around a bit...
> > > > 
> > > > This seems to not insta-explode... opinions?
> > > 
> > > It passes quick tests on -rcu both with and without the rcutorture fixes,
> > > which is encouraging.  I will start a more vigorous test in about an hour.
> > 
> > And 672 ten-minute instances of RUDE01 passed with this patch applied
> > and with my rcutorture patch reverted.  So looking good, thank you!!!
> 
> Still on the yesterday's patch, an overnight 12-hour run hit workqueue
> warnings in three of four instances of the SRCU-P scenario, two
> at not quite three hours in and the third at about ten hours in.
> All runs were otherwise successful.  One of the runs also had "BUG:
> using __this_cpu_read() in preemptible" as well, so that is the warning
> shown below.  There was a series of these BUGs, then things settled down.
> 
> This is the warning at the end of process_one_work() that is complaining
> about being on the wrong CPU.
> 
> I will fire up some tests on the new series.

An SRCU-P run on the new series reproduced the warning below.  Repeat-by:

tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --duration 10 --configs "112*SRCU-P" --bootargs "rcupdate.rcu_cpu_stall_suppress_at_boot=1 torture.disable_onoff_at_boot rcupdate.rcu_task_stall_timeout=30000 rcutree.softirq=0" --trust-make

A RUDE01 run on the new series completed without incident.  Repeat-by:

tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --duration 10 --configs "672*RUDE01" --bootargs "rcupdate.rcu_cpu_stall_suppress_at_boot=1 torture.disable_onoff_at_boot rcupdate.rcu_task_stall_timeout=30000 rcutree.softirq=0" --trust-make

I will be doing an overnight (PST) run having more variety and longer durations.

							Thanx, Paul

> ------------------------------------------------------------------------
> 
> WARNING: CPU: 0 PID: 413 at kernel/workqueue.c:2193 process_one_work+0x8c/0x5f0
> Modules linked in:
> CPU: 0 PID: 413 Comm: kworker/3:3 Not tainted 5.11.0-rc3+ #1104
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.11.0-2.el7 04/01/2014
> Workqueue:  0x0 (events)
> RIP: 0010:process_one_work+0x8c/0x5f0
> Code: 48 8b 46 38 41 83 e6 20 48 89 45 c0 48 8b 46 40 48 89 45 c8 41 f6 44 24 4c 04 75 10 65 8b 05 eb 5d 78 59 41 39 44 24 40 74 02 <0f> 0b 48 ba eb 83 b5 80 46 86 c8 61 48 0f af d3 48 c1 ea 3a 49 8b
> RSP: 0018:ffffb5a540847e70 EFLAGS: 00010006
> RAX: 0000000000000000 RBX: ffff8fcc5f4f27e0 RCX: 2b970af959bb2a7d
> RDX: ffff8fcc5f4f27e8 RSI: ffff8fcc5f4f27e0 RDI: ffff8fcc4306e3c0
> RBP: ffffb5a540847ed0 R08: 0000000000000001 R09: ffff8fcc425e4680
> R10: 0000000000000000 R11: 0000000000000000 R12: ffff8fcc5f4eadc0
> R13: ffff8fcc5f4ef700 R14: 0000000000000000 R15: ffff8fcc4306e3c0
> FS:  0000000000000000(0000) GS:ffff8fcc5f400000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00000000004001e1 CR3: 0000000003084000 CR4: 00000000000006f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  ? process_one_work+0x5f0/0x5f0
>  worker_thread+0x28/0x3c0
>  ? process_one_work+0x5f0/0x5f0
>  kthread+0x13b/0x160
>  ? kthread_insert_work_sanity_check+0x50/0x50
>  ret_from_fork+0x22/0x30
> irq event stamp: 138141554
> hardirqs last  enabled at (138141553): [<ffffffffa74a928f>] _raw_spin_unlock_irq+0x1f/0x40
> hardirqs last disabled at (138141554): [<ffffffffa74a9071>] _raw_spin_lock_irq+0x41/0x50
> softirqs last  enabled at (138140828): [<ffffffffa68ece37>] srcu_invoke_callbacks+0xe7/0x1a0
> softirqs last disabled at (138140824): [<ffffffffa68ece37>] srcu_invoke_callbacks+0xe7/0x1a0
> ---[ end trace e31d6dded2c52564 ]---
> kvm-guest: stealtime: cpu 3, msr 1f4d7b00
> BUG: using __this_cpu_read() in preemptible [00000000] code: kworker/3:3/413
> caller is refresh_cpu_vm_stats+0x1a6/0x320
> CPU: 5 PID: 413 Comm: kworker/3:3 Tainted: G        W         5.11.0-rc3+ #1104
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.11.0-2.el7 04/01/2014
> Workqueue: mm_percpu_wq vmstat_update
> Call Trace:
>  dump_stack+0x77/0x97
>  check_preemption_disabled+0xb6/0xd0
>  refresh_cpu_vm_stats+0x1a6/0x320
>  vmstat_update+0xe/0x60
>  process_one_work+0x2a0/0x5f0
>  ? process_one_work+0x5f0/0x5f0
>  worker_thread+0x28/0x3c0
>  ? process_one_work+0x5f0/0x5f0
>  kthread+0x13b/0x160
>  ? kthread_insert_work_sanity_check+0x50/0x50
>  ret_from_fork+0x22/0x30
