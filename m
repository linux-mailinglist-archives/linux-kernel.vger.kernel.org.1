Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25AA82FD272
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 15:21:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390504AbhATON4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 09:13:56 -0500
Received: from mout.gmx.net ([212.227.15.15]:37897 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390052AbhATNfE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 08:35:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1611149599;
        bh=g50aE0N4TVqsuWaAqsaI2olYhTmwFA8ijHlLjx7bQio=;
        h=X-UI-Sender-Class:Subject:From:In-Reply-To:Date:Cc:References:To;
        b=ZzYFNf2qDgQOTzIogNL6BYrOrPgL7FIz0FGRz8VZ4qCn0fJPYW3YsHH9CHJIQ8WfO
         BS68SxXRZk6A/J/xLnMek9MUn79zBur7DsIgxJUU7HVXFc6J9PgIh9+Z29Ex8mCqyG
         vMMLfdvtASLueeXeD7C51AGokRPM96AUqX/phPvo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [10.42.0.78] ([83.204.192.78]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M7sDg-1l79YL0lUI-0052sl; Wed, 20
 Jan 2021 14:33:19 +0100
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.60.0.2.5\))
Subject: Re: [PATCH 1/3] arm64/kernel: FIQ support
From:   Mohamed Mediouni <mohamed.mediouni@caramail.com>
In-Reply-To: <1818f98d257c2431c600240ccda628e4@misterjones.org>
Date:   Wed, 20 Jan 2021 14:33:18 +0100
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Stan Skowronek <stan@corellium.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <1B8021A9-7FA0-4B30-8E22-AD463203669A@caramail.com>
References: <9C00B3A8-FDE3-4F5F-B23B-6296A7993C9F@caramail.com>
 <1818f98d257c2431c600240ccda628e4@misterjones.org>
To:     Marc Zyngier <maz@kernel.org>
X-Mailer: Apple Mail (2.3654.60.0.2.5)
X-Provags-ID: V03:K1:Xs8oF1Xbnb0LVHDotbcpZEN2r9ga9RIvptAEJYR51VRYZ4iK/65
 mYDgs62jybNikUctizf6OCefj8ePuUCZeXmXYcwUjCfwxBqrvZ9Un0YCWHDAKkWcaK+YAl9
 0nrrxYgL84ccJnrjjv+32KTRuyKxrcPeZOrVIAGb3vq6o6ipEO3alaPZcNYfNuTpjQ033AP
 w/YHlGoE1JbJs7DXb0N6A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:SbRzq6ofIQw=:wqIq31A10mbuDkD1c1bVMv
 qWAxXxblwVuucDSRyVnXy8Rgz2x8c+EzyDKXenfBd3ATJIVoA1yElg4N8mSOHKETtTe7fx4ma
 9l2qV7FI8Pxqjg56D6SreKqpIuEeakNNtzKefOdjDLyFhwIJvzHsmYgWKzGSvIBThGDSe7Nr/
 /AI385AnuHRq3kmrm9JNdA8o8LFjlkqIgVTdwcdEgTlMMkp3LxzUw9S1fqthL3jNe1CXWl6bq
 eIpnxMS9B6k4oxAC6QTXV7GjLAWvQwaunh752pX67zlrQyTDIzsI25osTrbzu6pxRXvsbrPFC
 hDwvYw835+bYR92cwoBOZ3BIztT+JnGCtfeIe0OR7tyP5mjGjuehyGaz7y1aNd/3fV3uzX2fJ
 aOB3wnsuz6BMdocpbtzjr0lyJyGBQYAQaWB9EJE909wAmg8fdluhsshGYpeGtaY/mjySqyjLc
 DgXgEPmKjlrI7annmL2nn4+BFz5yIf/1FDaMOFaXDgZwB7bZiV7SBZQqXDcVV3Wou31aKIlqj
 nDndS6Smcce1HDPuerB1vNZoL27B2U50QCHrLdpfnM/wFxXOVzSUnXbDehf5hdBqUNzY0kiM8
 KRtfX8RfdDklVvNHl+LzWjH54qJ4Jznh7bGRufvyIdis5iTmEvju7VNjJNFUDckNohLVW5/s7
 qiiCHKMV0eMu9XQTjmYsDTpN/FZRfC/2p5xHiFdfSpXBaQnQwvc412in8kjj8pH9AcmmBEAdA
 /+fA4I6I+Pg4ot08kypJeJmmMuWZoJANssUmNyHfOFY18fa54Y0vqp6+tbS53pseLw0+FA6+l
 gF6+srQ8wggHvSyHZGsqA0J5Jis9abhkWx5hheVko/+7H125HgtHkIb+Mdk7E3FVCP7n5mh1w
 g9gsny4cZnqpFIJIl9fGS6pJiOJT+x+fNJma2eeqE=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On 20 Jan 2021, at 14:16, Marc Zyngier <maz@kernel.org> wrote:
>=20
> Hi Mohamed,
>=20
> On 2021-01-20 11:36, Mohamed Mediouni wrote:
>> From: Stan Skowronek <stan@corellium.com>
>> On Apple processors, the timer is wired through FIQ.
>=20
> Which timer? There are at least 3, potentially 4 timers per CPU
> that can fire.
This is about the Arm architectural timers.
>> As such, add FIQ support to the kernel.
>> Signed-off-by: Stan Skowronek <stan@corellium.com>
>=20
> Missing SoB from the sender.
>=20
Fixed in the RFC.
>> ---
>> arch/arm64/include/asm/arch_gicv3.h |  2 +-
>> arch/arm64/include/asm/assembler.h  |  8 ++--
>> arch/arm64/include/asm/daifflags.h  |  4 +-
>> arch/arm64/include/asm/irq.h        |  4 ++
>> arch/arm64/include/asm/irqflags.h   |  6 +--
>> arch/arm64/kernel/entry.S           | 74 =
++++++++++++++++++++++++++---
>> arch/arm64/kernel/irq.c             | 14 ++++++
>> arch/arm64/kernel/process.c         |  2 +-
>> 8 files changed, 97 insertions(+), 17 deletions(-)
>> diff --git a/arch/arm64/include/asm/arch_gicv3.h
>> b/arch/arm64/include/asm/arch_gicv3.h
>> index 880b9054d75c..934b9be582d2 100644
>> --- a/arch/arm64/include/asm/arch_gicv3.h
>> +++ b/arch/arm64/include/asm/arch_gicv3.h
>> @@ -173,7 +173,7 @@ static inline void gic_pmr_mask_irqs(void)
>> static inline void gic_arch_enable_irqs(void)
>> {
>> -	asm volatile ("msr daifclr, #2" : : : "memory");
>> +	asm volatile ("msr daifclr, #3" : : : "memory");
>=20
> If I trust the persistent rumour, this system doesn't have a GIC.
> Why this change?
>=20
Will ask about why GIC functions were changed too=E2=80=A6 and yeah
This exclusively has an Apple AIC interrupt controller.

>> #endif /* __ASSEMBLY__ */
>> diff --git a/arch/arm64/include/asm/assembler.h
>> b/arch/arm64/include/asm/assembler.h
>> index bf125c591116..6fe55713dfe0 100644
>> --- a/arch/arm64/include/asm/assembler.h
>> +++ b/arch/arm64/include/asm/assembler.h
>> @@ -40,9 +40,9 @@
>> 	msr	daif, \flags
>> 	.endm
>> -	/* IRQ is the lowest priority flag, unconditionally unmask the =
rest. */
>> -	.macro enable_da_f
>> -	msr	daifclr, #(8 | 4 | 1)
>> +	/* IRQ/FIQ is the lowest priority flag, unconditionally unmask =
the rest. */
>> +	.macro enable_da
>> +	msr	daifclr, #(8 | 4)
>=20
> This cannot be unconditional. This potentially changes existing =
behaviours,
> and I'd feel a lot safer if FIQ was only messed with on that specific =
HW.
>=20
> I have the feeling that this should be detected on the boot CPU and =
patched
> before any interrupt can fire.
>=20
Could alternatives be the proper mechanism for this?
>> 	.endm
>> /*
>> @@ -50,7 +50,7 @@
>>  */
>> 	.macro	save_and_disable_irq, flags
>> 	mrs	\flags, daif
>> -	msr	daifset, #2
>> +	msr	daifset, #3
>> 	.endm
>> 	.macro	restore_irq, flags
>> diff --git a/arch/arm64/include/asm/daifflags.h
>> b/arch/arm64/include/asm/daifflags.h
>> index 1c26d7baa67f..44de96c7fb1a 100644
>> --- a/arch/arm64/include/asm/daifflags.h
>> +++ b/arch/arm64/include/asm/daifflags.h
>> @@ -13,8 +13,8 @@
>> #include <asm/ptrace.h>
>> #define DAIF_PROCCTX		0
>> -#define DAIF_PROCCTX_NOIRQ	PSR_I_BIT
>> -#define DAIF_ERRCTX		(PSR_I_BIT | PSR_A_BIT)
>> +#define DAIF_PROCCTX_NOIRQ	(PSR_I_BIT | PSR_F_BIT)
>> +#define DAIF_ERRCTX		(PSR_I_BIT | PSR_F_BIT | PSR_A_BIT)
>> #define DAIF_MASK		(PSR_D_BIT | PSR_A_BIT | PSR_I_BIT | =
PSR_F_BIT)
>> diff --git a/arch/arm64/include/asm/irq.h =
b/arch/arm64/include/asm/irq.h
>> index b2b0c6405eb0..2d1537d3a245 100644
>> --- a/arch/arm64/include/asm/irq.h
>> +++ b/arch/arm64/include/asm/irq.h
>> @@ -13,5 +13,9 @@ static inline int nr_legacy_irqs(void)
>> 	return 0;
>> }
>> +int set_handle_fiq(void (*handle_fiq)(struct pt_regs *));
>> +
>> +extern void (*handle_arch_fiq)(struct pt_regs *) __ro_after_init;
>=20
> I guess this is set from the root interrupt controller, which also
> will set handle_arch_irq? Why do we need two entry points? We have
> ISR_EL1 to find out what is pending. Isn't that enough?
>=20
>> +
>> #endif /* !__ASSEMBLER__ */
>> #endif
>> diff --git a/arch/arm64/include/asm/irqflags.h
>> b/arch/arm64/include/asm/irqflags.h
>> index ff328e5bbb75..26d7f378113e 100644
>> --- a/arch/arm64/include/asm/irqflags.h
>> +++ b/arch/arm64/include/asm/irqflags.h
>> @@ -35,7 +35,7 @@ static inline void arch_local_irq_enable(void)
>> 	}
>> 	asm volatile(ALTERNATIVE(
>> -		"msr	daifclr, #2		// =
arch_local_irq_enable",
>> +		"msr	daifclr, #3		// =
arch_local_irq_enable",
>> 		__msr_s(SYS_ICC_PMR_EL1, "%0"),
>> 		ARM64_HAS_IRQ_PRIO_MASKING)
>> 		:
>> @@ -54,7 +54,7 @@ static inline void arch_local_irq_disable(void)
>> 	}
>> 	asm volatile(ALTERNATIVE(
>> -		"msr	daifset, #2		// =
arch_local_irq_disable",
>> +		"msr	daifset, #3		// =
arch_local_irq_disable",
>> 		__msr_s(SYS_ICC_PMR_EL1, "%0"),
>> 		ARM64_HAS_IRQ_PRIO_MASKING)
>> 		:
>> @@ -85,7 +85,7 @@ static inline int arch_irqs_disabled_flags(unsigned
>> long flags)
>> 	int res;
>> 	asm volatile(ALTERNATIVE(
>> -		"and	%w0, %w1, #" __stringify(PSR_I_BIT),
>> +		"and	%w0, %w1, #" __stringify(PSR_I_BIT | PSR_F_BIT),
>> 		"eor	%w0, %w1, #" __stringify(GIC_PRIO_IRQON),
>> 		ARM64_HAS_IRQ_PRIO_MASKING)
>> 		: "=3D&r" (res)
>> diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
>> index c9bae73f2621..abcca0db0736 100644
>> --- a/arch/arm64/kernel/entry.S
>> +++ b/arch/arm64/kernel/entry.S
>> @@ -499,6 +499,14 @@ tsk	.req	x28		// current =
thread_info
>> 	irq_stack_exit
>> 	.endm
>> +	.macro	fiq_handler
>> +	ldr_l	x1, handle_arch_fiq
>> +	mov	x0, sp
>> +	irq_stack_entry
>> +	blr	x1
>> +	irq_stack_exit
>> +	.endm
>> +
>> #ifdef CONFIG_ARM64_PSEUDO_NMI
>> 	/*
>> 	 * Set res to 0 if irqs were unmasked in interrupted context.
>> @@ -547,18 +555,18 @@ SYM_CODE_START(vectors)
>> 	kernel_ventry	1, sync				// Synchronous =
EL1h
>> 	kernel_ventry	1, irq				// IRQ EL1h
>> -	kernel_ventry	1, fiq_invalid			// FIQ EL1h
>> +	kernel_ventry	1, fiq				// FIQ EL1h
>> 	kernel_ventry	1, error			// Error EL1h
>> 	kernel_ventry	0, sync				// Synchronous =
64-bit EL0
>> 	kernel_ventry	0, irq				// IRQ 64-bit =
EL0
>> -	kernel_ventry	0, fiq_invalid			// FIQ 64-bit =
EL0
>> +	kernel_ventry	0, fiq				// FIQ 64-bit =
EL0
>> 	kernel_ventry	0, error			// Error 64-bit =
EL0
>> #ifdef CONFIG_COMPAT
>> 	kernel_ventry	0, sync_compat, 32		// Synchronous =
32-bit EL0
>> 	kernel_ventry	0, irq_compat, 32		// IRQ 32-bit =
EL0
>> -	kernel_ventry	0, fiq_invalid_compat, 32	// FIQ 32-bit =
EL0
>> +	kernel_ventry	0, fiq_compat, 32		// FIQ 32-bit =
EL0
>> 	kernel_ventry	0, error_compat, 32		// Error 32-bit =
EL0
>> #else
>> 	kernel_ventry	0, sync_invalid, 32		// Synchronous =
32-bit EL0
>> @@ -661,7 +669,7 @@ SYM_CODE_END(el1_sync)
>> SYM_CODE_START_LOCAL_NOALIGN(el1_irq)
>> 	kernel_entry 1
>> 	gic_prio_irq_setup pmr=3Dx20, tmp=3Dx1
>> -	enable_da_f
>> +	enable_da
>> 	mov	x0, sp
>> 	bl	enter_el1_irq_or_nmi
>> @@ -689,6 +697,38 @@ alternative_else_nop_endif
>> 	kernel_exit 1
>> SYM_CODE_END(el1_irq)
>> +	.align	6
>> +SYM_CODE_START_LOCAL_NOALIGN(el1_fiq)
>> +	kernel_entry 1
>> +	gic_prio_irq_setup pmr=3Dx20, tmp=3Dx1
>=20
> This doesn't make much sense. The HW doesn't have a GIC, and Linux
> doesn't use Group-0 interrupts, even in a guest.
>=20
>> +	enable_da
>> +
>> +	mov	x0, sp
>> +	bl	enter_el1_irq_or_nmi
>> +
>> +	fiq_handler
>> +
>> +#ifdef CONFIG_PREEMPTION
>> +	ldr	x24, [tsk, #TSK_TI_PREEMPT]	// get preempt count
>> +alternative_if ARM64_HAS_IRQ_PRIO_MASKING
>> +	/*
>> +	 * DA_F were cleared at start of handling. If anything is set in =
DAIF,
>> +	 * we come back from an NMI, so skip preemption
>> +	 */
>> +	mrs	x0, daif
>> +	orr	x24, x24, x0
>> +alternative_else_nop_endif
>> +	cbnz	x24, 1f				// preempt count !=3D 0 =
|| NMI return path
>> +	bl	arm64_preempt_schedule_irq	// irq en/disable is =
done inside
>> +1:
>> +#endif
>> +
>> +	mov	x0, sp
>> +	bl	exit_el1_irq_or_nmi
>> +
>> +	kernel_exit 1
>> +SYM_CODE_END(el1_fiq)
>=20
> Given that this is essentially a copy paste of el1_irq, and that
> a separate FIQ entry point seems superfluous, I don't think we
> need any of this, and it could be implemented just as the IRQ
> vector.
>=20
>> +
>> /*
>>  * EL0 mode handlers.
>>  */
>> @@ -715,6 +755,12 @@ SYM_CODE_START_LOCAL_NOALIGN(el0_irq_compat)
>> 	b	el0_irq_naked
>> SYM_CODE_END(el0_irq_compat)
>> +	.align	6
>> +SYM_CODE_START_LOCAL_NOALIGN(el0_fiq_compat)
>> +	kernel_entry 0, 32
>> +	b	el0_fiq_naked
>> +SYM_CODE_END(el0_fiq_compat)
>> +
>> SYM_CODE_START_LOCAL_NOALIGN(el0_error_compat)
>> 	kernel_entry 0, 32
>> 	b	el0_error_naked
>> @@ -727,7 +773,7 @@ SYM_CODE_START_LOCAL_NOALIGN(el0_irq)
>> el0_irq_naked:
>> 	gic_prio_irq_setup pmr=3Dx20, tmp=3Dx0
>> 	user_exit_irqoff
>> -	enable_da_f
>> +	enable_da
>> 	tbz	x22, #55, 1f
>> 	bl	do_el0_irq_bp_hardening
>> @@ -737,6 +783,22 @@ el0_irq_naked:
>> 	b	ret_to_user
>> SYM_CODE_END(el0_irq)
>> +	.align	6
>> +SYM_CODE_START_LOCAL_NOALIGN(el0_fiq)
>> +	kernel_entry 0
>> +el0_fiq_naked:
>> +	gic_prio_irq_setup pmr=3Dx20, tmp=3Dx0
>> +	user_exit_irqoff
>> +	enable_da
>> +
>> +	tbz	x22, #55, 1f
>> +	bl	do_el0_irq_bp_hardening
>> +1:
>> +	fiq_handler
>> +
>> +	b	ret_to_user
>> +SYM_CODE_END(el0_fiq)
>=20
> Same thing.
>=20
>> +
>> SYM_CODE_START_LOCAL(el1_error)
>> 	kernel_entry 1
>> 	mrs	x1, esr_el1
>> @@ -757,7 +819,7 @@ el0_error_naked:
>> 	mov	x0, sp
>> 	mov	x1, x25
>> 	bl	do_serror
>> -	enable_da_f
>> +	enable_da
>> 	b	ret_to_user
>> SYM_CODE_END(el0_error)
>> diff --git a/arch/arm64/kernel/irq.c b/arch/arm64/kernel/irq.c
>> index dfb1feab867d..4d7a9fb41d93 100644
>> --- a/arch/arm64/kernel/irq.c
>> +++ b/arch/arm64/kernel/irq.c
>> @@ -88,3 +88,17 @@ void __init init_IRQ(void)
>> 		local_daif_restore(DAIF_PROCCTX_NOIRQ);
>> 	}
>> }
>> +
>> +/*
>> + * Analogous to the generic handle_arch_irq / set_handle_irq
>> + */
>> +void (*handle_arch_fiq)(struct pt_regs *) __ro_after_init;
>> +
>> +int __init set_handle_fiq(void (*handle_fiq)(struct pt_regs *))
>> +{
>> +	if (handle_arch_fiq)
>> +		return -EBUSY;
>> +
>> +	handle_arch_fiq =3D handle_fiq;
>> +	return 0;
>> +}
>=20
> Also, this has no caller, so it is pretty hard to judge how useful
> this is.
Hello, in the RFC patch set that I just sent, it=E2=80=99s available =
now.
>> diff --git a/arch/arm64/kernel/process.c =
b/arch/arm64/kernel/process.c
>> index 6616486a58fe..34ec400288d0 100644
>> --- a/arch/arm64/kernel/process.c
>> +++ b/arch/arm64/kernel/process.c
>> @@ -84,7 +84,7 @@ static void noinstr __cpu_do_idle_irqprio(void)
>> 	unsigned long daif_bits;
>> 	daif_bits =3D read_sysreg(daif);
>> -	write_sysreg(daif_bits | PSR_I_BIT, daif);
>> +	write_sysreg(daif_bits | PSR_I_BIT | PSR_F_BIT, daif);
>> 	/*
>> 	 * Unmask PMR before going idle to make sure interrupts can
>=20
Thank you,
> Thanks,
>=20
>        M.
> --=20
> Jazz is not dead. It just smells funny...

