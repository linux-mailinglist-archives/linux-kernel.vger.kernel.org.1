Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB7192CAB35
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 20:00:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730070AbgLAS6b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 13:58:31 -0500
Received: from foss.arm.com ([217.140.110.172]:48394 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726213AbgLAS6b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 13:58:31 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1379130E;
        Tue,  1 Dec 2020 10:57:45 -0800 (PST)
Received: from C02TD0UTHF1T.local (unknown [10.57.26.117])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0011C3F575;
        Tue,  1 Dec 2020 10:57:42 -0800 (PST)
Date:   Tue, 1 Dec 2020 18:57:37 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sven Schnelle <svens@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>
Subject: Re: [GIT pull] locking/urgent for v5.10-rc6
Message-ID: <20201201185737.GA93208@C02TD0UTHF1T.local>
References: <yt9dpn3v3u1m.fsf@linux.ibm.com>
 <20201130125211.GN2414@hirez.programming.kicks-ass.net>
 <20201130130315.GJ3092@hirez.programming.kicks-ass.net>
 <CAHk-=whSdxfCW3YpoZafPaCD_DQsuxFWMKLyYFsdGWL2wu9haQ@mail.gmail.com>
 <dcdb13e3-36a0-031d-6ec3-3ab5ee4a69cb@de.ibm.com>
 <20201201080734.GQ2414@hirez.programming.kicks-ass.net>
 <20201201110724.GL3092@hirez.programming.kicks-ass.net>
 <20201201144644.GF1437@paulmck-ThinkPad-P72>
 <20201201145519.GY2414@hirez.programming.kicks-ass.net>
 <20201201181506.GM3092@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201201181506.GM3092@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 01, 2020 at 07:15:06PM +0100, Peter Zijlstra wrote:
> On Tue, Dec 01, 2020 at 03:55:19PM +0100, Peter Zijlstra wrote:
> > On Tue, Dec 01, 2020 at 06:46:44AM -0800, Paul E. McKenney wrote:
> > 
> > > > So after having talked to Sven a bit, the thing that is happening, is
> > > > that this is the one place where we take interrupts with RCU being
> > > > disabled. Normally RCU is watching and all is well, except during idle.
> > > 
> > > Isn't interrupt entry supposed to invoke rcu_irq_enter() at some point?
> > > Or did this fall victim to recent optimizations?
> > 
> > It does, but the problem is that s390 is still using
> 
> I might've been too quick there, I can't actually seem to find where
> s390 does rcu_irq_enter()/exit().
> 
> Also, I'm thinking the below might just about solve the current problem.
> The next problem would then be it calling TRACE_IRQS_ON after it did
> rcu_irq_exit()... :/

I gave this patch a go under QEMU TCG atop v5.10-rc6 s390 defconfig with
PROVE_LOCKING and DEBUG_ATOMIC_SLEEP. It significantly reduces the
number of lockdep splats, but IIUC we need to handle the io_int_handler
path in addition to the ext_int_handler path, and there's a remaining
lockdep splat (below).

If this ends up looking like we'll need more point-fixes, I wonder if we
should conditionalise the new behaviour of the core idle code under a
new CONFIG symbol for now, and opt-in x86 and arm64, then transition the
rest once they've had a chance to test. They'll still be broken in the
mean time, but no more so than they previously were.

Thanks,
Mark.

[    3.870912] ------------[ cut here ]------------
[    3.871225] DEBUG_LOCKS_WARN_ON(current->hardirq_chain_key != current->curr_chain_key)
[    3.872025] WARNING: CPU: 1 PID: 0 at kernel/locking/lockdep.c:4155 lockdep_hardirqs_on+0x150/0x158
[    3.872249] Modules linked in:
[    3.873096] CPU: 1 PID: 0 Comm: swapper/1 Not tainted 5.10.0-rc6-dirty #9
[    3.873262] Hardware name: QEMU 2964 QEMU (KVM/Linux)
[    3.873584] Krnl PSW : 0404e00180000000 0000000000ce51ac (lockdep_hardirqs_on+0x154/0x158)
[    3.873967]            R:0 T:1 IO:0 EX:0 Key:0 M:1 W:0 P:0 AS:3 CC:2 PM:0 RI:0 EA:3
[    3.874214] Krnl GPRS: c0000000ffffefff 00000000011e5218 000000000000004a 00000000001d988a
[    3.874363]            00000000ffffffea 000003e000000001 0000000000000000 0000000000000000
[    3.874511]            0000000000000000 000000000141e5f0 0000000003278000 0000000000cf354a
[    3.874658]            0000000000000000 0000000000000000 0000000000ce51a8 000003e000073db0
[    3.876258] Krnl Code: 0000000000ce519c: c0200012432c        larl    %r2,0000000000f2d7f4
[    3.876258]            0000000000ce51a2: c0e5ffff83db        brasl   %r14,0000000000cd5958
[    3.876258]           #0000000000ce51a8: af000000            mc      0,0
[    3.876258]           >0000000000ce51ac: a7f4ffb3            brc     15,0000000000ce5112
[    3.876258]            0000000000ce51b0: ebeff0880024        stmg    %r14,%r15,136(%r15)
[    3.876258]            0000000000ce51b6: b90400ef            lgr     %r14,%r15
[    3.876258]            0000000000ce51ba: e3f0ffe0ff71        lay     %r15,-32(%r15)
[    3.876258]            0000000000ce51c0: e3e0f0980024        stg     %r14,152(%r15)
[    3.877823] Call Trace:
[    3.878073]  [<0000000000ce51ac>] lockdep_hardirqs_on+0x154/0x158 
[    3.878260] ([<0000000000ce51a8>] lockdep_hardirqs_on+0x150/0x158)
[    3.878406]  [<0000000000cf3596>] default_idle_call+0xb6/0x2a8 
[    3.878549]  [<0000000000194f60>] do_idle+0xe0/0x190 
[    3.878682]  [<00000000001952ae>] cpu_startup_entry+0x36/0x40 
[    3.878816]  [<0000000000118152>] smp_start_secondary+0x82/0x88 
[    3.878975] INFO: lockdep is turned off.
[    3.879119] Last Breaking-Event-Address:
[    3.879273]  [<0000000000cf76d0>] __s390_indirect_jump_r14+0x0/0xc
[    3.879456] irq event stamp: 104
[    3.879619] hardirqs last  enabled at (102): [<00000000001a540c>] load_balance+0x28c/0x990
[    3.879783] hardirqs last disabled at (103): [<0000000000cf7626>] __do_softirq+0x536/0x5c8
[    3.879945] softirqs last  enabled at (104): [<0000000000cf7584>] __do_softirq+0x494/0x5c8
[    3.880114] softirqs last disabled at (95): [<000000000010df60>] do_softirq_own_stack+0x70/0x80
[    3.880724] random: get_random_bytes called from __warn+0x12a/0x160 with crng_init=0
[    3.882060] ---[ end trace ffae6482e242107b ]---

> ---
> diff --git a/arch/s390/include/asm/irq.h b/arch/s390/include/asm/irq.h
> index 9f75d67b8c20..24d3dd482df7 100644
> --- a/arch/s390/include/asm/irq.h
> +++ b/arch/s390/include/asm/irq.h
> @@ -113,6 +113,8 @@ void irq_subclass_unregister(enum irq_subclass subclass);
>  
>  #define irq_canonicalize(irq)  (irq)
>  
> +extern __visible void ext_do_IRQ(struct pt_regs *regs, unsigned long vector);
> +
>  #endif /* __ASSEMBLY__ */
>  
>  #endif /* _ASM_IRQ_H */
> diff --git a/arch/s390/kernel/entry.S b/arch/s390/kernel/entry.S
> index 26bb0603c5a1..b8e89b685038 100644
> --- a/arch/s390/kernel/entry.S
> +++ b/arch/s390/kernel/entry.S
> @@ -976,16 +976,10 @@ ENTRY(ext_int_handler)
>  	xc	__PT_FLAGS(8,%r11),__PT_FLAGS(%r11)
>  	TSTMSK	__LC_CPU_FLAGS,_CIF_IGNORE_IRQ
>  	jo	.Lio_restore
> -#if IS_ENABLED(CONFIG_TRACE_IRQFLAGS)
> -	tmhh	%r8,0x300
> 	jz	1f
> -	TRACE_IRQS_OFF
> -1:
> -#endif
>  	xc	__SF_BACKCHAIN(8,%r15),__SF_BACKCHAIN(%r15)
>  	lgr	%r2,%r11		# pass pointer to pt_regs
>  	lghi	%r3,EXT_INTERRUPT
> -	brasl	%r14,do_IRQ
> +	brasl	%r14,ext_do_IRQ
>  	j	.Lio_return
>  ENDPROC(ext_int_handler)
>  
> diff --git a/arch/s390/kernel/irq.c b/arch/s390/kernel/irq.c
> index 3514420f0259..f4a29114e9fd 100644
> --- a/arch/s390/kernel/irq.c
> +++ b/arch/s390/kernel/irq.c
> @@ -329,3 +329,23 @@ void irq_subclass_unregister(enum irq_subclass subclass)
>  	spin_unlock(&irq_subclass_lock);
>  }
>  EXPORT_SYMBOL(irq_subclass_unregister);
> +
> +noinstr void ext_do_IRQ(struct pt_regs *regs, unsigned long vector)
> +{
> +	bool rcu = false;
> +
> +	lockdep_hardirqs_off(CALLER_ADDR0);
> +	if (!IS_ENABLED(CONFIG_TINY_RCU) && is_idle_task(current)) {
> +		rcu_irq_enter();
> +		rcu = true;
> +	}
> +	/* instrumentation_begin(); */
> +
> +	trace_hardirqs_off_finish();
> +
> +	do_IRQ(regs, vector);
> +
> +	/* instrumentation_end(); */
> +	if (rcu)
> +		rcu_irq_exit();
> +}
