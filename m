Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 613702ADAF9
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 16:56:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731200AbgKJP4E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 10:56:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:42972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730865AbgKJP4D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 10:56:03 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B077B20678;
        Tue, 10 Nov 2020 15:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605023762;
        bh=Eo0MWPPGvXTFnYkuWfDnVUHwKz8AEJ3ivHYMYusnut0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hm7VSa4yMcZIFtuMT+B3gPOylF14tJBlCmKDdyjnEGz14C1i9nNMqZcMRdncsP+av
         kIlIpdAinU+hi2pS1WhuseW/xN8qTBySD9YVJigLo9H6J0et2fo8pLEIKryy/41epx
         IF+pp87icY6zd1XFSYbTm/XrzuxR4bDaRoBWqo1Q=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1kcW00-009UrU-Ha; Tue, 10 Nov 2020 15:56:00 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 10 Nov 2020 15:56:00 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     David Brazdil <dbrazdil@google.com>
Cc:     kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Dennis Zhou <dennis@kernel.org>,
        Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Quentin Perret <qperret@google.com>,
        Andrew Scull <ascull@google.com>,
        Andrew Walbran <qwandor@google.com>, kernel-team@android.com
Subject: Re: [PATCH v1 10/24] kvm: arm64: Extract parts of el2_setup into a
 macro
In-Reply-To: <20201109113233.9012-11-dbrazdil@google.com>
References: <20201109113233.9012-1-dbrazdil@google.com>
 <20201109113233.9012-11-dbrazdil@google.com>
User-Agent: Roundcube Webmail/1.4.9
Message-ID: <a6f5d318eb7e7adde2106df068121b48@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: dbrazdil@google.com, kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, james.morse@arm.com, julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com, catalin.marinas@arm.com, will@kernel.org, dennis@kernel.org, tj@kernel.org, cl@linux.com, mark.rutland@arm.com, lorenzo.pieralisi@arm.com, qperret@google.com, ascull@google.com, qwandor@google.com, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-11-09 11:32, David Brazdil wrote:
> When the a CPU is booted in EL2, the kernel checks for VHE support and
> initializes the CPU core accordingly. For nVHE it also installs the 
> stub
> vectors and drops down to EL1.
> 
> Once KVM gains the ability to boot cores without going through the
> kernel entry point, it will need to initialize the CPU the same way.
> Extract the relevant bits of el2_setup into init_el2_state macro
> with an argument specifying whether to initialize for VHE or nVHE.
> 
> No functional change. Size of el2_setup increased by 148 bytes due
> to duplication.
> 
> Signed-off-by: David Brazdil <dbrazdil@google.com>
> ---
>  arch/arm64/include/asm/kvm_asm.h | 128 ++++++++++++++++++++++++++++
>  arch/arm64/kernel/head.S         | 140 +++----------------------------
>  2 files changed, 141 insertions(+), 127 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/kvm_asm.h 
> b/arch/arm64/include/asm/kvm_asm.h
> index a49a87a186c3..893327d1e449 100644
> --- a/arch/arm64/include/asm/kvm_asm.h
> +++ b/arch/arm64/include/asm/kvm_asm.h
> @@ -331,6 +331,134 @@ extern char
> __smccc_workaround_1_smc[__SMCCC_WORKAROUND_1_SMC_SZ];
>  	msr	sp_el0, \tmp
>  .endm
> 
> +.macro init_el2_state mode
> +
> +.ifnes "\mode", "vhe"
> +.ifnes "\mode", "nvhe"
> +.error "Invalid 'mode' argument"
> +.endif
> +.endif
> +
> +	mov_q	x0, (SCTLR_EL2_RES1 | ENDIAN_SET_EL2)
> +	msr	sctlr_el2, x0
> +	isb
> +
> +	/*
> +	 * Allow Non-secure EL1 and EL0 to access physical timer and counter.
> +	 * This is not necessary for VHE, since the host kernel runs in EL2,
> +	 * and EL0 accesses are configured in the later stage of boot 
> process.
> +	 * Note that when HCR_EL2.E2H == 1, CNTHCTL_EL2 has the same bit 
> layout
> +	 * as CNTKCTL_EL1, and CNTKCTL_EL1 accessing instructions are 
> redefined
> +	 * to access CNTHCTL_EL2. This allows the kernel designed to run at 
> EL1
> +	 * to transparently mess with the EL0 bits via CNTKCTL_EL1 access in
> +	 * EL2.
> +	 */
> +.ifeqs "\mode", "nvhe"
> +	mrs	x0, cnthctl_el2
> +	orr	x0, x0, #3			// Enable EL1 physical timers
> +	msr	cnthctl_el2, x0
> +.endif
> +	msr	cntvoff_el2, xzr		// Clear virtual offset
> +
> +#ifdef CONFIG_ARM_GIC_V3
> +	/* GICv3 system register access */
> +	mrs	x0, id_aa64pfr0_el1
> +	ubfx	x0, x0, #ID_AA64PFR0_GIC_SHIFT, #4
> +	cbz	x0, 3f
> +
> +	mrs_s	x0, SYS_ICC_SRE_EL2
> +	orr	x0, x0, #ICC_SRE_EL2_SRE	// Set ICC_SRE_EL2.SRE==1
> +	orr	x0, x0, #ICC_SRE_EL2_ENABLE	// Set ICC_SRE_EL2.Enable==1
> +	msr_s	SYS_ICC_SRE_EL2, x0
> +	isb					// Make sure SRE is now set
> +	mrs_s	x0, SYS_ICC_SRE_EL2		// Read SRE back,
> +	tbz	x0, #0, 3f			// and check that it sticks
> +	msr_s	SYS_ICH_HCR_EL2, xzr		// Reset ICC_HCR_EL2 to defaults
> +3:
> +#endif
> +
> +	/* Populate ID registers. */
> +	mrs	x0, midr_el1
> +	mrs	x1, mpidr_el1
> +	msr	vpidr_el2, x0
> +	msr	vmpidr_el2, x1

I don't think this has any effect on VHE, and could be lumped
together with the nVHE code.

> +
> +#ifdef CONFIG_COMPAT
> +	msr	hstr_el2, xzr			// Disable CP15 traps to EL2
> +#endif
> +
> +	/* EL2 debug */
> +	mrs	x1, id_aa64dfr0_el1
> +	sbfx	x0, x1, #ID_AA64DFR0_PMUVER_SHIFT, #4
> +	cmp	x0, #1
> +	b.lt	4f				// Skip if no PMU present
> +	mrs	x0, pmcr_el0			// Disable debug access traps
> +	ubfx	x0, x0, #11, #5			// to EL2 and allow access to
> +4:
> +	csel	x3, xzr, x0, lt			// all PMU counters from EL1
> +
> +	/* Statistical profiling */
> +	ubfx	x0, x1, #ID_AA64DFR0_PMSVER_SHIFT, #4
> +	cbz	x0, 7f				// Skip if SPE not present
> +.ifeqs "\mode", "nvhe"
> +	mrs_s	x4, SYS_PMBIDR_EL1		// If SPE available at EL2,
> +	and	x4, x4, #(1 << SYS_PMBIDR_EL1_P_SHIFT)
> +	cbnz	x4, 5f				// then permit sampling of physical
> +	mov	x4, #(1 << SYS_PMSCR_EL2_PCT_SHIFT | \
> +		      1 << SYS_PMSCR_EL2_PA_SHIFT)
> +	msr_s	SYS_PMSCR_EL2, x4		// addresses and physical counter
> +5:
> +	mov	x1, #(MDCR_EL2_E2PB_MASK << MDCR_EL2_E2PB_SHIFT)
> +	orr	x3, x3, x1			// If we don't have VHE, then
> +	b	7f				// use EL1&0 translation.
> +.endif
> +	orr	x3, x3, #MDCR_EL2_TPMS		// and disable access from EL1

This orr would probably be better placed in an "else" close to the
previous macro. And since you are making things "modular", why not
go the extra mile, and define macros for each functionality that
defer between modes? It would certainly make this change more digest,
and the result more readable.

> +7:
> +	msr	mdcr_el2, x3			// Configure debug traps
> +
> +	/* LORegions */
> +	mrs	x1, id_aa64mmfr1_el1
> +	ubfx	x0, x1, #ID_AA64MMFR1_LOR_SHIFT, 4
> +	cbz	x0, 1f
> +	msr_s	SYS_LORC_EL1, xzr
> +1:
> +
> +	/* Stage-2 translation */
> +	msr	vttbr_el2, xzr
> +
> +.ifeqs "\mode", "nvhe"
> +	/*
> +	 * When VHE is not in use, early init of EL2 and EL1 needs to be
> +	 * done here.
> +	 * When VHE _is_ in use, EL1 will not be used in the host and
> +	 * requires no configuration, and all non-hyp-specific EL2 setup
> +	 * will be done via the _EL1 system register aliases in __cpu_setup.
> +	 */
> +	mov_q	x0, (SCTLR_EL1_RES1 | ENDIAN_SET_EL1)
> +	msr	sctlr_el1, x0
> +
> +	/* Coprocessor traps. */
> +	mov	x0, #0x33ff
> +	msr	cptr_el2, x0			// Disable copro. traps to EL2
> +
> +	/* SVE register access */
> +	mrs	x1, id_aa64pfr0_el1
> +	ubfx	x1, x1, #ID_AA64PFR0_SVE_SHIFT, #4
> +	cbz	x1, 7f
> +
> +	bic	x0, x0, #CPTR_EL2_TZ		// Also disable SVE traps
> +	msr	cptr_el2, x0			// Disable copro. traps to EL2
> +	isb
> +	mov	x1, #ZCR_ELx_LEN_MASK		// SVE: Enable full vector
> +	msr_s	SYS_ZCR_EL2, x1			// length for EL1.
> +
> +	/* spsr */
> +7:	mov	x0, #(PSR_F_BIT | PSR_I_BIT | PSR_A_BIT | PSR_D_BIT |\
> +		      PSR_MODE_EL1h)
> +	msr	spsr_el2, x0
> +.endif
> +.endm
> +
>  #endif
> 
>  #endif /* __ARM_KVM_ASM_H__ */
> diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
> index d8d9caf02834..e7270b63abed 100644
> --- a/arch/arm64/kernel/head.S
> +++ b/arch/arm64/kernel/head.S
> @@ -25,6 +25,7 @@
>  #include <asm/image.h>
>  #include <asm/kernel-pgtable.h>
>  #include <asm/kvm_arm.h>
> +#include <asm/kvm_asm.h>
>  #include <asm/memory.h>
>  #include <asm/pgtable-hwdef.h>
>  #include <asm/page.h>
> @@ -499,153 +500,38 @@ SYM_FUNC_START(el2_setup)
>  	isb
>  	ret
> 
> -1:	mov_q	x0, (SCTLR_EL2_RES1 | ENDIAN_SET_EL2)
> -	msr	sctlr_el2, x0
> -
> +1:
>  #ifdef CONFIG_ARM64_VHE
>  	/*
> -	 * Check for VHE being present. For the rest of the EL2 setup,
> -	 * x2 being non-zero indicates that we do have VHE, and that the
> -	 * kernel is intended to run at EL2.
> +	 * Check for VHE being present. x2 being non-zero indicates that we
> +	 * do have VHE, and that the kernel is intended to run at EL2.
>  	 */
>  	mrs	x2, id_aa64mmfr1_el1
>  	ubfx	x2, x2, #ID_AA64MMFR1_VHE_SHIFT, #4
> -#else
> -	mov	x2, xzr
> -#endif
> +	cbz	x2, el2_setup_nvhe

What initialises x2 to zero when CONFIG_VHE is disabled?

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
