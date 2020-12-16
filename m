Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 946B12DC608
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 19:18:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729134AbgLPSSO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 13:18:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:59668 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729148AbgLPSSN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 13:18:13 -0500
Date:   Wed, 16 Dec 2020 09:54:42 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608141282;
        bh=lqu24/Iif2fz1yKLQNXbGnTnjsy377jQdnMvLFGyt0U=;
        h=From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=LXjiWYDrQduZxaEdBn2nJtVjFp/GoiC/2MHVkl8lUOeByfrP4CjoPLTV30jhQQctG
         FHiZlFdUWtbFXkHWJeGHTvJ4Q6bHF8FlHzaIMBNBxBKr20HjMBpxrDKOLkvd5clUbO
         UQdnQpzF74dmer6Eg9L6d3GF0FKfAus1bEdFKSBkRYnPclM2KxJ7siCrRbL7i2WsI9
         rQ12K/T46YgbWHit9n0GogrDmneKJH0zlf+zKedPdr7Sg9gTF/lD1irLep19Qoh5Ck
         g6RDXFo9eSqEV8EAwIvBEtdVDjnZlUyLITtmcKh7i0L0f0NGuSn6oEdxLy8nzNTfTW
         ykNdbqckARlQQ==
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: Re: RCU stall leading to deadlock warning
Message-ID: <20201216175442.GK2657@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20201216172939.ts72yy3ekalavlpm@e107158-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201216172939.ts72yy3ekalavlpm@e107158-lin.cambridge.arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 16, 2020 at 05:29:39PM +0000, Qais Yousef wrote:
> Hi Paul
> 
> We hit the below splat a couple of days ago in our testing. Sadly I can't
> reproduce it. And it was on android-mainline branch..
> 
> It's the deadlock message that bothers me. I can't see how we could have ended
> there. We detect a stall and when trying to dump the stack LOCKDEP spits the
> warning.
> 
> Maybe should take this report with a pinch of salt since it wasn't on mainline.
> I just thought it might be something worth sharing in case you can actually
> spot something obvious that I can't see. If I got more info or a reproducer
> I will share them.
> 
> The failure was triggered twice on that day running 2 different tests.

This looks like the same problem that Mark Rutland's recent patch series
was fixing.  Do you have this series applied?

lore.kernel.org/lkml/20201126123602.23454-1-mark.rutland@arm.com

							Thanx, Paul

> [  310.073379] LTP: starting leapsec01
> [  345.070123] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
> [  345.076717] rcu:     0-...!: (1 ticks this GP) idle=798/0/0x0 softirq=19187/19187 fqs=0  (false positive?)
> [  345.087533]    (detected by 2, t=6502 jiffies, g=57249, q=184)
> [  345.093284]
> [  345.094797] ============================================
> [  345.100139] WARNING: possible recursive locking detected
> [  345.105485] 5.10.0-rc7-02296-g3f43bd6f2c3b-ab89 #1 Not tainted
> [  345.111349] --------------------------------------------
> [  345.116693] swapper/2/0 is trying to acquire lock:
> [  345.121515] ffffa00013b50c58 (rcu_node_0){-.-.}-{2:2}, at: rcu_dump_cpu_stacks+0x7c/0x14c
> [  345.129813]
> [  345.129813] but task is already holding lock:
> [  345.135678] ffffa00013b50c58 (rcu_node_0){-.-.}-{2:2}, at: rcu_sched_clock_irq+0x68c/0x11c0
> [  345.144143]
> [  345.144143] other info that might help us debug this:
> [  345.150702]  Possible unsafe locking scenario:
> [  345.150702]
> [  345.156651]        CPU0
> [  345.159119]        ----
> [  345.161585]   lock(rcu_node_0);
> [  345.164779]   lock(rcu_node_0);
> [  345.167973]
> [  345.167973]  *** DEADLOCK ***
> [  345.167973]
> [  345.173923]  May be due to missing lock nesting notation
> [  345.173923]
> [  345.180746] 1 lock held by swapper/2/0:
> [  345.184607]  #0: ffffa00013b50c58 (rcu_node_0){-.-.}-{2:2}, at: rcu_sched_clock_irq+0x68c/0x11c0
> [  345.193517]
> [  345.193517] stack backtrace:
> [  345.197910] CPU: 2 PID: 0 Comm: swapper/2 Not tainted 5.10.0-rc7-02296-g3f43bd6f2c3b-ab89 #1
> [  345.206389] Hardware name: ARM LTD ARM Juno Development Platform/ARM Juno Development Platform, BIOS EDK II Oct 19 2019
> [  345.217215] Call trace:
> [  345.219691]  dump_backtrace+0x0/0x2b8
> [  345.223383]  show_stack+0x18/0x68
> [  345.226731]  dump_stack+0x110/0x188
> [  345.230255]  __lock_acquire+0x23f0/0x2410
> [  345.234300]  lock_acquire+0x3b8/0x730
> [  345.237997]  _raw_spin_lock_irqsave+0x80/0x168
> [  345.242476]  rcu_dump_cpu_stacks+0x7c/0x14c
> [  345.246693]  rcu_sched_clock_irq+0xfd4/0x11c0
> [  345.251087]  update_process_times+0x84/0xe0
> [  345.255306]  tick_sched_handle.isra.0+0x68/0x98
> [  345.259871]  tick_sched_timer+0x60/0xd8
> [  345.263742]  __hrtimer_run_queues+0x534/0x9e0
> [  345.268134]  hrtimer_interrupt+0x1a8/0x398
> [  345.272264]  tick_receive_broadcast+0x60/0x88
> [  345.276657]  ipi_handler+0x250/0x4b8
> [  345.280270]  handle_percpu_devid_fasteoi_ipi+0x138/0x4f0
> [  345.285619]  generic_handle_irq+0x4c/0x68
> [  345.289661]  __handle_domain_irq+0x9c/0x118
> [  345.293880]  gic_handle_irq+0xdc/0x118
> [  345.297661]  el1_irq+0xc8/0x180
> [  345.300835]  cpuidle_enter_state+0x16c/0x810
> [  345.305139]  cpuidle_enter+0x4c/0x78
> [  345.308749]  call_cpuidle+0x44/0x88
> [  345.312271]  do_idle+0x2d4/0x338
> [  345.315532]  cpu_startup_entry+0x24/0x68
> [  345.319491]  secondary_start_kernel+0x1d4/0x2d8
> 
> Thanks
> 
> --
> Qais Yousef
