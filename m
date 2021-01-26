Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3EA530462A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 19:20:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394622AbhAZST0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 13:19:26 -0500
Received: from foss.arm.com ([217.140.110.172]:51186 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731462AbhAZSIz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 13:08:55 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E8BF0106F;
        Tue, 26 Jan 2021 10:08:07 -0800 (PST)
Received: from e107158-lin (unknown [10.1.194.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E76C43F66B;
        Tue, 26 Jan 2021 10:08:06 -0800 (PST)
Date:   Tue, 26 Jan 2021 18:08:04 +0000
From:   Qais Yousef <qais.yousef@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] Fix BUG: Invalid wait context in hrtimer_interrupt()
Message-ID: <20210126180804.ez6i24sdzq2hqxj3@e107158-lin>
References: <20210123233741.3614408-1-qais.yousef@arm.com>
 <YA+em8XkTidYetGE@jagdpanzerIV.localdomain>
 <20210126145917.r64vzibgpiwyuake@e107158-lin>
 <YBA8KTyANXe0v1kR@jagdpanzerIV.localdomain>
 <YBBCDw8tBpgMSY3L@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YBBCDw8tBpgMSY3L@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/26/21 17:23, Peter Zijlstra wrote:
> On Wed, Jan 27, 2021 at 12:58:33AM +0900, Sergey Senozhatsky wrote:
> > On (21/01/26 14:59), Qais Yousef wrote:
> 
> > > 	# [67628.388606] hrtimer: interrupt took 304720 ns
> > > 	[67628.393546]
> > > 	[67628.393550] =============================
> > > 	[67628.393554] [ BUG: Invalid wait context ]
> > > 	[67628.393557] 5.11.0-rc3-00019-g86be331946f7 #37 Not tainted
> > > 	[67628.393560] -----------------------------
> > > 	[67628.393563] sugov:0/192 is trying to lock:
> > > 	[67628.393566] ffff000800b1d898 (&port_lock_key){-.-.}-{3:3}, at: pl011_console_write+0x138/0x218
> > > 	[67628.393581] other info that might help us debug this:
> > > 	[67628.393584] context-{2:2}
> > > 	[67628.393586] 4 locks held by sugov:0/192:
> > > 	[67628.393589]  #0: ffff0008059cb720 (&sg_policy->work_lock){+.+.}-{4:4}, at: sugov_work+0x58/0x88
> > > 	[67628.393603]  #1: ffff800015446f20 (prepare_lock){+.+.}-{4:4}, at: clk_prepare_lock+0x34/0xb0
> > > 	[67628.393618]  #2: ffff8000152aaa60 (console_lock){+.+.}-{0:0}, at: vprintk_emit+0x12c/0x310
> > > 	[67628.393632]  #3: ffff8000152aab88 (console_owner){-.-.}-{0:0}, at: console_unlock+0x190/0x6d8
> 
> > > Did I miss something?
> > 
> > printk() is not permitted to sleep/schedule/etc and it never does.
> > Generally it should be OK to call it from IRQ (module recursion paths).
> 
> The report is that it is trying to acquire spin_lock() while holding
> raw_spin_lock(), which is an invalid lock nesting.
> 
> Note that this is CONFIG_PROVE_RAW_LOCK_NESTING=y which specifically
> checks for this.
> 
> On current (mainline) kernel configs this is not yet a problem, but the
> moment we do land PREEMPT_RT this order will be problematic.

I should have dug more into the history of printk() and the meaning of the
splat. Sorry for the noise.

Looking at v5.10.8-rt24 the following fix is applied in RT

	https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git/commit/drivers/tty/serial/amba-pl011.c?h=linux-5.10.y-rt&id=008cc77aff249e830e5eb90b7ae3a6784597b8cf

which is what John suggested.

Looking at the locks held

> > > 	[67628.393589]  #0: ffff0008059cb720 (&sg_policy->work_lock){+.+.}-{4:4}, at: sugov_work+0x58/0x88
> > > 	[67628.393603]  #1: ffff800015446f20 (prepare_lock){+.+.}-{4:4}, at: clk_prepare_lock+0x34/0xb0

These two are mutexes.

> > > 	[67628.393618]  #2: ffff8000152aaa60 (console_lock){+.+.}-{0:0}, at: vprintk_emit+0x12c/0x310

This is a semaphore.

> > > 	[67628.393632]  #3: ffff8000152aab88 (console_owner){-.-.}-{0:0}, at: console_unlock+0x190/0x6d8

I think this is acquired by console_lock_spinning_enable() which has acquiring
syntax I'm not familiar with. console_owner_lock is defined as RAW_SPINLOCK, so
regardless of how it is acquired, it must be the problem.

Looks like John has reworked this code in RT too. So maybe this is just a red
herring after all..

	https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git/commit/kernel/printk/printk.c?h=linux-5.10.y-rt&id=0097798fd99948d3ffea535005eee7eb3b14fd06

Thanks

--
Qais Yousef
