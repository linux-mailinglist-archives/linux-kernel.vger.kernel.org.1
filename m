Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A835C2FDB95
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 22:26:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732974AbhATU4m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 15:56:42 -0500
Received: from foss.arm.com ([217.140.110.172]:35356 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732704AbhATNyD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 08:54:03 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A4BCED6E;
        Wed, 20 Jan 2021 05:52:46 -0800 (PST)
Received: from e107158-lin (e107158-lin.cambridge.arm.com [10.1.194.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1B3793F66E;
        Wed, 20 Jan 2021 05:52:46 -0800 (PST)
Date:   Wed, 20 Jan 2021 13:52:43 +0000
From:   Qais Yousef <qais.yousef@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: Re: hrtimer_interrupt::pr_warn_once() causes BUG: Invalid wait
 context
Message-ID: <20210120135243.cztbdfbdy6qzlevw@e107158-lin>
References: <20210114124512.mg3vexudfmoadef5@e107158-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210114124512.mg3vexudfmoadef5@e107158-lin>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/14/21 12:45, Qais Yousef wrote:
> Hi
> 
> I hit this splat today
> 
> 	# [67628.388606] hrtimer: interrupt took 304720 ns
> 	[67628.393546]
> 	[67628.393550] =============================
> 	[67628.393554] [ BUG: Invalid wait context ]
> 	[67628.393557] 5.11.0-rc3-00019-g86be331946f7 #37 Not tainted
> 	[67628.393560] -----------------------------
> 	[67628.393563] sugov:0/192 is trying to lock:
> 	[67628.393566] ffff000800b1d898 (&port_lock_key){-.-.}-{3:3}, at: pl011_console_write+0x138/0x218
> 	[67628.393581] other info that might help us debug this:
> 	[67628.393584] context-{2:2}
> 	[67628.393586] 4 locks held by sugov:0/192:
> 	[67628.393589]  #0: ffff0008059cb720 (&sg_policy->work_lock){+.+.}-{4:4}, at: sugov_work+0x58/0x88
> 	[67628.393603]  #1: ffff800015446f20 (prepare_lock){+.+.}-{4:4}, at: clk_prepare_lock+0x34/0xb0
> 	[67628.393618]  #2: ffff8000152aaa60 (console_lock){+.+.}-{0:0}, at: vprintk_emit+0x12c/0x310
> 	[67628.393632]  #3: ffff8000152aab88 (console_owner){-.-.}-{0:0}, at: console_unlock+0x190/0x6d8
> 	[67628.393646] stack backtrace:
> 	[67628.393649] CPU: 0 PID: 192 Comm: sugov:0 Not tainted 5.11.0-rc3-00019-g86be331946f7 #37
> 	[67628.393653] Hardware name: ARM Juno development board (r2) (DT)
> 	[67628.393656] Call trace:
> 	[67628.393659]  dump_backtrace+0x0/0x1b0
> 	[67628.393661]  show_stack+0x20/0x70
> 	[67628.393664]  dump_stack+0xf8/0x168
> 	[67628.393666]  __lock_acquire+0x964/0x1c88
> 	[67628.393669]  lock_acquire+0x26c/0x500
> 	[67628.393671]  _raw_spin_lock+0x64/0x88
> 	[67628.393674]  pl011_console_write+0x138/0x218
> 	[67628.393677]  console_unlock+0x2c4/0x6d8
> 	[67628.393680]  vprintk_emit+0x134/0x310
> 	[67628.393682]  vprintk_default+0x40/0x50
> 	[67628.393685]  vprintk_func+0xfc/0x2b0
> 	[67628.393687]  printk+0x68/0x90
> 	[67628.393690]  hrtimer_interrupt+0x24c/0x250
> 	[67628.393693]  arch_timer_handler_phys+0x3c/0x50
> 	[67628.393695]  handle_percpu_devid_irq+0xd8/0x460
> 	[67628.393698]  generic_handle_irq+0x38/0x50
> 	[67628.393701]  __handle_domain_irq+0x6c/0xc8
> 	[67628.393704]  gic_handle_irq+0xb0/0xf0
> 	[67628.393706]  el1_irq+0xb4/0x180
> 	[67628.393709]  _raw_spin_unlock_irqrestore+0x58/0xa8
> 	[67628.393712]  hrtimer_start_range_ns+0x1b0/0x420
> 	[67628.393715]  msg_submit+0x100/0x108
> 	[67628.393717]  mbox_send_message+0x84/0x128
> 	[67628.393720]  scpi_send_message+0x11c/0x2a8
> 	[67628.393723]  scpi_dvfs_set_idx+0x48/0x70
> 	[67628.393726]  scpi_dvfs_set_rate+0x60/0x78
> 	[67628.393728]  clk_change_rate+0x184/0x8a8
> 	[67628.393731]  clk_core_set_rate_nolock+0x1c0/0x280
> 	[67628.393734]  clk_set_rate+0x40/0x98
> 	[67628.393736]  scpi_cpufreq_set_target+0x40/0x68
> 	[67628.393739]  __cpufreq_driver_target+0x1a0/0x5d0
> 
> AFAICT the call to pr_warn_once() is how we end up here. Not sure if there's an
> appropriate or easy fix for that.

Oh I just accidentally came across printk_deferred_once() which looks like the
right thing to do. I can't reproduce but I'll send a patch over the weekend to
see if anyone will complain why it shouldn't work.

Thanks

--
Qais Yousef
