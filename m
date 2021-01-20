Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABF432FD1BF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 14:55:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388819AbhATNZu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 08:25:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:53946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731202AbhATNRT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 08:17:19 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9041D23359;
        Wed, 20 Jan 2021 13:16:30 +0000 (UTC)
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1l2DLY-008wya-N7; Wed, 20 Jan 2021 13:16:28 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 20 Jan 2021 13:16:28 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Mohamed Mediouni <mohamed.mediouni@caramail.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Stan Skowronek <stan@corellium.com>
Subject: Re: [PATCH 1/3] arm64/kernel: FIQ support
In-Reply-To: <9C00B3A8-FDE3-4F5F-B23B-6296A7993C9F@caramail.com>
References: <9C00B3A8-FDE3-4F5F-B23B-6296A7993C9F@caramail.com>
User-Agent: Roundcube Webmail/1.4.10
Message-ID: <1818f98d257c2431c600240ccda628e4@misterjones.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: mohamed.mediouni@caramail.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com, will@kernel.org, stan@corellium.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mohamed,

On 2021-01-20 11:36, Mohamed Mediouni wrote:
> From: Stan Skowronek <stan@corellium.com>
> 
> On Apple processors, the timer is wired through FIQ.

Which timer? There are at least 3, potentially 4 timers per CPU
that can fire.

> As such, add FIQ support to the kernel.
> 
> Signed-off-by: Stan Skowronek <stan@corellium.com>

Missing SoB from the sender.

> ---
>  arch/arm64/include/asm/arch_gicv3.h |  2 +-
>  arch/arm64/include/asm/assembler.h  |  8 ++--
>  arch/arm64/include/asm/daifflags.h  |  4 +-
>  arch/arm64/include/asm/irq.h        |  4 ++
>  arch/arm64/include/asm/irqflags.h   |  6 +--
>  arch/arm64/kernel/entry.S           | 74 ++++++++++++++++++++++++++---
>  arch/arm64/kernel/irq.c             | 14 ++++++
>  arch/arm64/kernel/process.c         |  2 +-
>  8 files changed, 97 insertions(+), 17 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/arch_gicv3.h
> b/arch/arm64/include/asm/arch_gicv3.h
> index 880b9054d75c..934b9be582d2 100644
> --- a/arch/arm64/include/asm/arch_gicv3.h
> +++ b/arch/arm64/include/asm/arch_gicv3.h
> @@ -173,7 +173,7 @@ static inline void gic_pmr_mask_irqs(void)
> 
>  static inline void gic_arch_enable_irqs(void)
>  {
> -	asm volatile ("msr daifclr, #2" : : : "memory");
> +	asm volatile ("msr daifclr, #3" : : : "memory");

If I trust the persistent rumour, this system doesn't have a GIC.
Why this change?

>  }
> 
>  #endif /* __ASSEMBLY__ */
> diff --git a/arch/arm64/include/asm/assembler.h
> b/arch/arm64/include/asm/assembler.h
> index bf125c591116..6fe55713dfe0 100644
> --- a/arch/arm64/include/asm/assembler.h
> +++ b/arch/arm64/include/asm/assembler.h
> @@ -40,9 +40,9 @@
>  	msr	daif, \flags
>  	.endm
> 
> -	/* IRQ is the lowest priority flag, unconditionally unmask the rest. 
> */
> -	.macro enable_da_f
> -	msr	daifclr, #(8 | 4 | 1)
> +	/* IRQ/FIQ is the lowest priority flag, unconditionally unmask the 
> rest. */
> +	.macro enable_da
> +	msr	daifclr, #(8 | 4)

This cannot be unconditional. This potentially changes existing 
behaviours,
and I'd feel a lot safer if FIQ was only messed with on that specific 
HW.

I have the feeling that this should be detected on the boot CPU and 
patched
before any interrupt can fire.

>  	.endm
> 
>  /*
> @@ -50,7 +50,7 @@
>   */
>  	.macro	save_and_disable_irq, flags
>  	mrs	\flags, daif
> -	msr	daifset, #2
> +	msr	daifset, #3
>  	.endm
> 
>  	.macro	restore_irq, flags
> diff --git a/arch/arm64/include/asm/daifflags.h
> b/arch/arm64/include/asm/daifflags.h
> index 1c26d7baa67f..44de96c7fb1a 100644
> --- a/arch/arm64/include/asm/daifflags.h
> +++ b/arch/arm64/include/asm/daifflags.h
> @@ -13,8 +13,8 @@
>  #include <asm/ptrace.h>
> 
>  #define DAIF_PROCCTX		0
> -#define DAIF_PROCCTX_NOIRQ	PSR_I_BIT
> -#define DAIF_ERRCTX		(PSR_I_BIT | PSR_A_BIT)
> +#define DAIF_PROCCTX_NOIRQ	(PSR_I_BIT | PSR_F_BIT)
> +#define DAIF_ERRCTX		(PSR_I_BIT | PSR_F_BIT | PSR_A_BIT)
>  #define DAIF_MASK		(PSR_D_BIT | PSR_A_BIT | PSR_I_BIT | PSR_F_BIT)
> 
> 
> diff --git a/arch/arm64/include/asm/irq.h 
> b/arch/arm64/include/asm/irq.h
> index b2b0c6405eb0..2d1537d3a245 100644
> --- a/arch/arm64/include/asm/irq.h
> +++ b/arch/arm64/include/asm/irq.h
> @@ -13,5 +13,9 @@ static inline int nr_legacy_irqs(void)
>  	return 0;
>  }
> 
> +int set_handle_fiq(void (*handle_fiq)(struct pt_regs *));
> +
> +extern void (*handle_arch_fiq)(struct pt_regs *) __ro_after_init;

I guess this is set from the root interrupt controller, which also
will set handle_arch_irq? Why do we need two entry points? We have
ISR_EL1 to find out what is pending. Isn't that enough?

> +
>  #endif /* !__ASSEMBLER__ */
>  #endif
> diff --git a/arch/arm64/include/asm/irqflags.h
> b/arch/arm64/include/asm/irqflags.h
> index ff328e5bbb75..26d7f378113e 100644
> --- a/arch/arm64/include/asm/irqflags.h
> +++ b/arch/arm64/include/asm/irqflags.h
> @@ -35,7 +35,7 @@ static inline void arch_local_irq_enable(void)
>  	}
> 
>  	asm volatile(ALTERNATIVE(
> -		"msr	daifclr, #2		// arch_local_irq_enable",
> +		"msr	daifclr, #3		// arch_local_irq_enable",
>  		__msr_s(SYS_ICC_PMR_EL1, "%0"),
>  		ARM64_HAS_IRQ_PRIO_MASKING)
>  		:
> @@ -54,7 +54,7 @@ static inline void arch_local_irq_disable(void)
>  	}
> 
>  	asm volatile(ALTERNATIVE(
> -		"msr	daifset, #2		// arch_local_irq_disable",
> +		"msr	daifset, #3		// arch_local_irq_disable",
>  		__msr_s(SYS_ICC_PMR_EL1, "%0"),
>  		ARM64_HAS_IRQ_PRIO_MASKING)
>  		:
> @@ -85,7 +85,7 @@ static inline int arch_irqs_disabled_flags(unsigned
> long flags)
>  	int res;
> 
>  	asm volatile(ALTERNATIVE(
> -		"and	%w0, %w1, #" __stringify(PSR_I_BIT),
> +		"and	%w0, %w1, #" __stringify(PSR_I_BIT | PSR_F_BIT),
>  		"eor	%w0, %w1, #" __stringify(GIC_PRIO_IRQON),
>  		ARM64_HAS_IRQ_PRIO_MASKING)
>  		: "=&r" (res)
> diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
> index c9bae73f2621..abcca0db0736 100644
> --- a/arch/arm64/kernel/entry.S
> +++ b/arch/arm64/kernel/entry.S
> @@ -499,6 +499,14 @@ tsk	.req	x28		// current thread_info
>  	irq_stack_exit
>  	.endm
> 
> +	.macro	fiq_handler
> +	ldr_l	x1, handle_arch_fiq
> +	mov	x0, sp
> +	irq_stack_entry
> +	blr	x1
> +	irq_stack_exit
> +	.endm
> +
>  #ifdef CONFIG_ARM64_PSEUDO_NMI
>  	/*
>  	 * Set res to 0 if irqs were unmasked in interrupted context.
> @@ -547,18 +555,18 @@ SYM_CODE_START(vectors)
> 
>  	kernel_ventry	1, sync				// Synchronous EL1h
>  	kernel_ventry	1, irq				// IRQ EL1h
> -	kernel_ventry	1, fiq_invalid			// FIQ EL1h
> +	kernel_ventry	1, fiq				// FIQ EL1h
>  	kernel_ventry	1, error			// Error EL1h
> 
>  	kernel_ventry	0, sync				// Synchronous 64-bit EL0
>  	kernel_ventry	0, irq				// IRQ 64-bit EL0
> -	kernel_ventry	0, fiq_invalid			// FIQ 64-bit EL0
> +	kernel_ventry	0, fiq				// FIQ 64-bit EL0
>  	kernel_ventry	0, error			// Error 64-bit EL0
> 
>  #ifdef CONFIG_COMPAT
>  	kernel_ventry	0, sync_compat, 32		// Synchronous 32-bit EL0
>  	kernel_ventry	0, irq_compat, 32		// IRQ 32-bit EL0
> -	kernel_ventry	0, fiq_invalid_compat, 32	// FIQ 32-bit EL0
> +	kernel_ventry	0, fiq_compat, 32		// FIQ 32-bit EL0
>  	kernel_ventry	0, error_compat, 32		// Error 32-bit EL0
>  #else
>  	kernel_ventry	0, sync_invalid, 32		// Synchronous 32-bit EL0
> @@ -661,7 +669,7 @@ SYM_CODE_END(el1_sync)
>  SYM_CODE_START_LOCAL_NOALIGN(el1_irq)
>  	kernel_entry 1
>  	gic_prio_irq_setup pmr=x20, tmp=x1
> -	enable_da_f
> +	enable_da
> 
>  	mov	x0, sp
>  	bl	enter_el1_irq_or_nmi
> @@ -689,6 +697,38 @@ alternative_else_nop_endif
>  	kernel_exit 1
>  SYM_CODE_END(el1_irq)
> 
> +	.align	6
> +SYM_CODE_START_LOCAL_NOALIGN(el1_fiq)
> +	kernel_entry 1
> +	gic_prio_irq_setup pmr=x20, tmp=x1

This doesn't make much sense. The HW doesn't have a GIC, and Linux
doesn't use Group-0 interrupts, even in a guest.

> +	enable_da
> +
> +	mov	x0, sp
> +	bl	enter_el1_irq_or_nmi
> +
> +	fiq_handler
> +
> +#ifdef CONFIG_PREEMPTION
> +	ldr	x24, [tsk, #TSK_TI_PREEMPT]	// get preempt count
> +alternative_if ARM64_HAS_IRQ_PRIO_MASKING
> +	/*
> +	 * DA_F were cleared at start of handling. If anything is set in 
> DAIF,
> +	 * we come back from an NMI, so skip preemption
> +	 */
> +	mrs	x0, daif
> +	orr	x24, x24, x0
> +alternative_else_nop_endif
> +	cbnz	x24, 1f				// preempt count != 0 || NMI return path
> +	bl	arm64_preempt_schedule_irq	// irq en/disable is done inside
> +1:
> +#endif
> +
> +	mov	x0, sp
> +	bl	exit_el1_irq_or_nmi
> +
> +	kernel_exit 1
> +SYM_CODE_END(el1_fiq)

Given that this is essentially a copy paste of el1_irq, and that
a separate FIQ entry point seems superfluous, I don't think we
need any of this, and it could be implemented just as the IRQ
vector.

> +
>  /*
>   * EL0 mode handlers.
>   */
> @@ -715,6 +755,12 @@ SYM_CODE_START_LOCAL_NOALIGN(el0_irq_compat)
>  	b	el0_irq_naked
>  SYM_CODE_END(el0_irq_compat)
> 
> +	.align	6
> +SYM_CODE_START_LOCAL_NOALIGN(el0_fiq_compat)
> +	kernel_entry 0, 32
> +	b	el0_fiq_naked
> +SYM_CODE_END(el0_fiq_compat)
> +
>  SYM_CODE_START_LOCAL_NOALIGN(el0_error_compat)
>  	kernel_entry 0, 32
>  	b	el0_error_naked
> @@ -727,7 +773,7 @@ SYM_CODE_START_LOCAL_NOALIGN(el0_irq)
>  el0_irq_naked:
>  	gic_prio_irq_setup pmr=x20, tmp=x0
>  	user_exit_irqoff
> -	enable_da_f
> +	enable_da
> 
>  	tbz	x22, #55, 1f
>  	bl	do_el0_irq_bp_hardening
> @@ -737,6 +783,22 @@ el0_irq_naked:
>  	b	ret_to_user
>  SYM_CODE_END(el0_irq)
> 
> +	.align	6
> +SYM_CODE_START_LOCAL_NOALIGN(el0_fiq)
> +	kernel_entry 0
> +el0_fiq_naked:
> +	gic_prio_irq_setup pmr=x20, tmp=x0
> +	user_exit_irqoff
> +	enable_da
> +
> +	tbz	x22, #55, 1f
> +	bl	do_el0_irq_bp_hardening
> +1:
> +	fiq_handler
> +
> +	b	ret_to_user
> +SYM_CODE_END(el0_fiq)

Same thing.

> +
>  SYM_CODE_START_LOCAL(el1_error)
>  	kernel_entry 1
>  	mrs	x1, esr_el1
> @@ -757,7 +819,7 @@ el0_error_naked:
>  	mov	x0, sp
>  	mov	x1, x25
>  	bl	do_serror
> -	enable_da_f
> +	enable_da
>  	b	ret_to_user
>  SYM_CODE_END(el0_error)
> 
> diff --git a/arch/arm64/kernel/irq.c b/arch/arm64/kernel/irq.c
> index dfb1feab867d..4d7a9fb41d93 100644
> --- a/arch/arm64/kernel/irq.c
> +++ b/arch/arm64/kernel/irq.c
> @@ -88,3 +88,17 @@ void __init init_IRQ(void)
>  		local_daif_restore(DAIF_PROCCTX_NOIRQ);
>  	}
>  }
> +
> +/*
> + * Analogous to the generic handle_arch_irq / set_handle_irq
> + */
> +void (*handle_arch_fiq)(struct pt_regs *) __ro_after_init;
> +
> +int __init set_handle_fiq(void (*handle_fiq)(struct pt_regs *))
> +{
> +	if (handle_arch_fiq)
> +		return -EBUSY;
> +
> +	handle_arch_fiq = handle_fiq;
> +	return 0;
> +}

Also, this has no caller, so it is pretty hard to judge how useful
this is.

> diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
> index 6616486a58fe..34ec400288d0 100644
> --- a/arch/arm64/kernel/process.c
> +++ b/arch/arm64/kernel/process.c
> @@ -84,7 +84,7 @@ static void noinstr __cpu_do_idle_irqprio(void)
>  	unsigned long daif_bits;
> 
>  	daif_bits = read_sysreg(daif);
> -	write_sysreg(daif_bits | PSR_I_BIT, daif);
> +	write_sysreg(daif_bits | PSR_I_BIT | PSR_F_BIT, daif);
> 
>  	/*
>  	 * Unmask PMR before going idle to make sure interrupts can

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
