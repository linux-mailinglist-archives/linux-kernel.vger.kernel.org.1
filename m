Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB82A2CBB60
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 12:18:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727329AbgLBLRB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 06:17:01 -0500
Received: from foss.arm.com ([217.140.110.172]:36542 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725885AbgLBLRB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 06:17:01 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 19045101E;
        Wed,  2 Dec 2020 03:16:15 -0800 (PST)
Received: from C02TD0UTHF1T.local (unknown [10.57.23.201])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E59873F66B;
        Wed,  2 Dec 2020 03:16:12 -0800 (PST)
Date:   Wed, 2 Dec 2020 11:16:05 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sven Schnelle <svens@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>
Subject: Re: [GIT pull] locking/urgent for v5.10-rc6
Message-ID: <20201202111605.GA63790@C02TD0UTHF1T.local>
References: <20201201080734.GQ2414@hirez.programming.kicks-ass.net>
 <20201201110724.GL3092@hirez.programming.kicks-ass.net>
 <20201201144644.GF1437@paulmck-ThinkPad-P72>
 <20201201145519.GY2414@hirez.programming.kicks-ass.net>
 <20201201181506.GM3092@hirez.programming.kicks-ass.net>
 <20201201185737.GA93208@C02TD0UTHF1T.local>
 <20201201191441.GW3040@hirez.programming.kicks-ass.net>
 <20201201191856.GD8316@osiris>
 <20201202092116.GA3040@hirez.programming.kicks-ass.net>
 <20201202105649.GB6202@osiris>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201202105649.GB6202@osiris>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 02, 2020 at 11:56:49AM +0100, Heiko Carstens wrote:
> From 7bd86fb3eb039a4163281472ca79b9158e726526 Mon Sep 17 00:00:00 2001
> From: Heiko Carstens <hca@linux.ibm.com>
> Date: Wed, 2 Dec 2020 11:46:01 +0100
> Subject: [PATCH] s390: fix irq state tracing
> 
> With commit 58c644ba512c ("sched/idle: Fix arch_cpu_idle() vs
> tracing") common code calls arch_cpu_idle() with a lockdep state that
> tells irqs are on.
> 
> This doesn't work very well for s390: psw_idle() will enable interrupts
> to wait for an interrupt. As soon as an interrupt occurs the interrupt
> handler will verify if the old context was psw_idle(). If that is the
> case the interrupt enablement bits in the old program status word will
> be cleared.
> 
> A subsequent test in both the external as well as the io interrupt
> handler checks if in the old context interrupts were enabled. Due to
> the above patching of the old program status word it is assumed the
> old context had interrupts disabled, and therefore a call to
> TRACE_IRQS_OFF (aka trace_hardirqs_off_caller) is skipped. Which in
> turn makes lockdep incorrectly "think" that interrupts are enabled
> within the interrupt handler.
> 
> Fix this by unconditionally calling TRACE_IRQS_OFF when entering
> interrupt handlers. Also call unconditionally TRACE_IRQS_ON when
> leaving interrupts handlers.
> 
> This leaves the special psw_idle() case, which now returns with
> interrupts disabled, but has an "irqs on" lockdep state. So callers of
> psw_idle() must adjust the state on their own, if required. This is
> currently only __udelay_disabled().
> 
> Fixes: 58c644ba512c ("sched/idle: Fix arch_cpu_idle() vs tracing")
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

FWIW, this makes sense to me from what I had to chase on the arm64 side,
and this seems happy atop v5.10-rc6 with all the lockdep and RCU debug
options enabled when booting to userspace under QEMU.

Thanks,
Mark.

> ---
>  arch/s390/kernel/entry.S | 15 ---------------
>  arch/s390/lib/delay.c    |  5 ++---
>  2 files changed, 2 insertions(+), 18 deletions(-)
> 
> diff --git a/arch/s390/kernel/entry.S b/arch/s390/kernel/entry.S
> index 26bb0603c5a1..92beb1444644 100644
> --- a/arch/s390/kernel/entry.S
> +++ b/arch/s390/kernel/entry.S
> @@ -763,12 +763,7 @@ ENTRY(io_int_handler)
>  	xc	__PT_FLAGS(8,%r11),__PT_FLAGS(%r11)
>  	TSTMSK	__LC_CPU_FLAGS,_CIF_IGNORE_IRQ
>  	jo	.Lio_restore
> -#if IS_ENABLED(CONFIG_TRACE_IRQFLAGS)
> -	tmhh	%r8,0x300
> -	jz	1f
>  	TRACE_IRQS_OFF
> -1:
> -#endif
>  	xc	__SF_BACKCHAIN(8,%r15),__SF_BACKCHAIN(%r15)
>  .Lio_loop:
>  	lgr	%r2,%r11		# pass pointer to pt_regs
> @@ -791,12 +786,7 @@ ENTRY(io_int_handler)
>  	TSTMSK	__LC_CPU_FLAGS,_CIF_WORK
>  	jnz	.Lio_work
>  .Lio_restore:
> -#if IS_ENABLED(CONFIG_TRACE_IRQFLAGS)
> -	tm	__PT_PSW(%r11),3
> -	jno	0f
>  	TRACE_IRQS_ON
> -0:
> -#endif
>  	mvc	__LC_RETURN_PSW(16),__PT_PSW(%r11)
>  	tm	__PT_PSW+1(%r11),0x01	# returning to user ?
>  	jno	.Lio_exit_kernel
> @@ -976,12 +966,7 @@ ENTRY(ext_int_handler)
>  	xc	__PT_FLAGS(8,%r11),__PT_FLAGS(%r11)
>  	TSTMSK	__LC_CPU_FLAGS,_CIF_IGNORE_IRQ
>  	jo	.Lio_restore
> -#if IS_ENABLED(CONFIG_TRACE_IRQFLAGS)
> -	tmhh	%r8,0x300
> -	jz	1f
>  	TRACE_IRQS_OFF
> -1:
> -#endif
>  	xc	__SF_BACKCHAIN(8,%r15),__SF_BACKCHAIN(%r15)
>  	lgr	%r2,%r11		# pass pointer to pt_regs
>  	lghi	%r3,EXT_INTERRUPT
> diff --git a/arch/s390/lib/delay.c b/arch/s390/lib/delay.c
> index daca7bad66de..8c0c68e7770e 100644
> --- a/arch/s390/lib/delay.c
> +++ b/arch/s390/lib/delay.c
> @@ -33,7 +33,7 @@ EXPORT_SYMBOL(__delay);
>  
>  static void __udelay_disabled(unsigned long long usecs)
>  {
> -	unsigned long cr0, cr0_new, psw_mask, flags;
> +	unsigned long cr0, cr0_new, psw_mask;
>  	struct s390_idle_data idle;
>  	u64 end;
>  
> @@ -45,9 +45,8 @@ static void __udelay_disabled(unsigned long long usecs)
>  	psw_mask = __extract_psw() | PSW_MASK_EXT | PSW_MASK_WAIT;
>  	set_clock_comparator(end);
>  	set_cpu_flag(CIF_IGNORE_IRQ);
> -	local_irq_save(flags);
>  	psw_idle(&idle, psw_mask);
> -	local_irq_restore(flags);
> +	trace_hardirqs_off();
>  	clear_cpu_flag(CIF_IGNORE_IRQ);
>  	set_clock_comparator(S390_lowcore.clock_comparator);
>  	__ctl_load(cr0, 0, 0);
> -- 
> 2.17.1
> 
