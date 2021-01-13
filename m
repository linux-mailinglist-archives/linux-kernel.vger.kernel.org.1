Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D4752F50F5
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 18:21:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728259AbhAMRTV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 12:19:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:53274 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727484AbhAMRTV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 12:19:21 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 174EA23432;
        Wed, 13 Jan 2021 17:18:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610558320;
        bh=J3ThT5svqpbNq60NwKF+UZW3loRr+WCvQ6JW8Pa+z+A=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=R8S+pvN02iQXicDIkb/2K9LOycTjmAnjb6GtrSmDYs8e3TB6uGFbB5xvKqFSrKRlW
         l2rla6QL1iNMaii4jy5JO+YT857DhvVxLLq7COo2Fdae+yMTfYQ7O4c3J3Y0iaEAdr
         /32NRcgXJxvQAXJ3S6tQFHTGBSgAp/KFNUIUO+a5mhmtXlSOOJa38BVlW04qpaPmrB
         3hDlGyvqmDXDUlfjwOXq8bvC5k0HGh1LiOp4eJzRsXzoWByMgW7bo4KY9alAn6OAyD
         MUcVdXrhGrwAJDaGyvrlDeTjMmgRE7DE8oo3YQ1LF5w3Q4qwP3Jt17bwCpgpJKg1tO
         SFieSVyLxomAw==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id B6FBB3522AC3; Wed, 13 Jan 2021 09:18:39 -0800 (PST)
Date:   Wed, 13 Jan 2021 09:18:39 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org, maz@kernel.org, peterz@infradead.org,
        tglx@linutronix.de
Subject: Re: [PATCH 0/2] irq: detect slow IRQ handlers
Message-ID: <20210113171839.GU2743@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20210112135950.30607-1-mark.rutland@arm.com>
 <20210113000953.GN2743@paulmck-ThinkPad-P72>
 <20210113123915.GA19011@C02TD0UTHF1T.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210113123915.GA19011@C02TD0UTHF1T.local>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 13, 2021 at 12:39:15PM +0000, Mark Rutland wrote:
> On Tue, Jan 12, 2021 at 04:09:53PM -0800, Paul E. McKenney wrote:
> > On Tue, Jan 12, 2021 at 01:59:48PM +0000, Mark Rutland wrote:
> > > Hi,
> > > 
> > > While fuzzing arm64 with Syzkaller (under QEMU+KVM) over a number of releases,
> > > I've occasionally seen some ridiculously long stalls (20+ seconds), where it
> > > appears that a CPU is stuck in a hard IRQ context. As this gets detected after
> > > the CPU returns to the interrupted context, it's difficult to identify where
> > > exactly the stall is coming from.
> > > 
> > > These patches are intended to help tracking this down, with a WARN() if an IRQ
> > > handler takes longer than a given timout (1 second by default), logging the
> > > specific IRQ and handler function. While it's possible to achieve similar with
> > > tracing, it's harder to integrate that into an automated fuzzing setup.
> > > 
> > > I've been running this for a short while, and haven't yet seen any of the
> > > stalls with this applied, but I've tested with smaller timeout periods in the 1
> > > millisecond range by overloading the host, so I'm confident that the check
> > > works.
> > > 
> > > Thanks,
> > > Mark.
> > 
> > Nice!
> > 
> > Acked-by: Paul E. McKenney <paulmck@kernel.org>
> > 
> > I added the patch below to add a three-second delay to the scheduling
> > clock interrupt handler.  This executed, but did not cause your warning
> > to be emitted, probably because rcutorture runs under qemu/KVM.  So no
> > Tested-by, not yet, anyway.
> 
> I think this is because on x86, APIC timer interrupts are handled in
> arch code without going through the usual IRQ management infrastructure.
> A dump_stack() in rcu_sched_clock_irq() shows:
> 
> [   75.131594] rcu: rcu_sched_clock_irq: 3-second delay.
> [   75.132557] CPU: 2 PID: 135 Comm: sh Not tainted 5.11.0-rc3+ #12
> [   75.133610] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
> [   75.135639] Call Trace:
> [   75.136100]  dump_stack+0x57/0x6a
> [   75.136713]  rcu_sched_clock_irq+0x76d/0x880
> [   75.137493]  update_process_times+0x77/0xb0
> [   75.138254]  tick_sched_handle.isra.17+0x2b/0x40
> [   75.139105]  tick_sched_timer+0x36/0x70
> [   75.139803]  ? tick_sched_handle.isra.17+0x40/0x40
> [   75.140665]  __hrtimer_run_queues+0xf8/0x230
> [   75.141441]  hrtimer_interrupt+0xfc/0x240
> [   75.142169]  ? asm_sysvec_apic_timer_interrupt+0xa/0x20
> [   75.143117]  __sysvec_apic_timer_interrupt+0x58/0xf0
> [   75.144017]  sysvec_apic_timer_interrupt+0x27/0x80
> [   75.144892]  asm_sysvec_apic_timer_interrupt+0x12/0x20
> 
> Here __sysvec_apic_timer_interrupt() calls local_apic_timer_interrupt()
> which calls the clock_event_device::event_handler() directly. Since that
> never goes via an irqaction handler, the code I add is never invoked in
> this path. I believe this is true for a number of IRQs on x86 (e.g.
> IPIs). A slow handler for a peripheral interrupt should still be caught,
> though.

This seems to me to be the most important case.  IPIs are already covered
by CONFIG_CSD_LOCK_WAIT_DEBUG=y already, which prints out additional
IPI-specific information.

> On arm64, timer interrupts (and IIUC IPIs too) go though the usual IRQ
> management code, and so delays there get caught:
> 
> [  311.703932] rcu: rcu_sched_clock_irq: 3-second delay.
> [  311.705012] CPU: 3 PID: 199 Comm: bash Not tainted 5.11.0-rc3-00003-gbe60490b2295-dirty #13
> [  311.706694] Hardware name: linux,dummy-virt (DT)
> [  311.707688] Call trace:
> [  311.708233]  dump_backtrace+0x0/0x1a0
> [  311.709053]  show_stack+0x18/0x70
> [  311.709774]  dump_stack+0xd0/0x12c
> [  311.710468]  rcu_sched_clock_irq+0x7d4/0xcf0
> [  311.711356]  update_process_times+0x9c/0xec
> [  311.712288]  tick_sched_handle+0x34/0x60
> [  311.713191]  tick_sched_timer+0x4c/0xa4
> [  311.714043]  __hrtimer_run_queues+0x140/0x1e0
> [  311.715012]  hrtimer_interrupt+0xe8/0x290
> [  311.715943]  arch_timer_handler_virt+0x38/0x4c
> [  311.716951]  handle_percpu_devid_irq+0x94/0x190
> [  311.717953]  __handle_domain_irq+0x7c/0xe0
> [  311.718890]  gic_handle_irq+0xc0/0x140
> [  311.719729]  el0_irq_naked+0x4c/0x54
> [  314.720833] ------------[ cut here ]------------
> [  314.721950] IRQ 11 handler arch_timer_handler_virt took 3016901740 ns
> [  314.723421] WARNING: CPU: 3 PID: 199 at kernel/irq/internals.h:140 handle_percpu_devid_irq+0x158/0x190

And that is in fact the trace in my case.  ;-)

> I think our options are:
> 
> 1) Live with it, and don't check these special cases.
> 
> 2) Rework the special cases to go though the regular irqaction
>    processing.
> 
> 3) Open-code checks in each special case.
> 
> 4) Add a helper/wrapper function that can be called in each special
>    case, and update each one accordingly.
> 
> ... and I reckon some mixture of #3 and #4 is plausible. We could add a
> __handle_check_irq_function() or similar and use that to wrap the call
> to local_apic_timer_interrupt() from sysvec_apic_timer_interrupt(), but
> I'm not sure exactly what that needs to look like to cover any other
> special cases.

I believe that what you have is a good starting point.

							Thanx, Paul
