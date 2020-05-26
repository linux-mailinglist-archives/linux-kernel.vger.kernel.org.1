Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D24C11CF2EB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 May 2020 12:53:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729521AbgELKxs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 May 2020 06:53:48 -0400
Received: from foss.arm.com ([217.140.110.172]:52276 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727859AbgELKxs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 06:53:48 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B0DB830E;
        Tue, 12 May 2020 03:53:47 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.28.99])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CFB633F71E;
        Tue, 12 May 2020 03:53:45 -0700 (PDT)
Date:   Tue, 12 May 2020 11:53:43 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        linux-kernel@vger.kernel.org, kvmarm@lists.cs.columbia.edu
Subject: Re: [PATCH] arm64/cpufeature: Add ID_AA64MMFR0_PARANGE_MASK
Message-ID: <20200512105343.GB60359@C02TD0UTHF1T.local>
References: <1589249606-27177-1-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1589249606-27177-1-git-send-email-anshuman.khandual@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 12, 2020 at 07:43:26AM +0530, Anshuman Khandual wrote:
> This replaces multiple open encoding (0x7) with ID_AA64MMFR0_PARANGE_MASK
> thus cleaning the clutter. It modifies an existing ID_AA64MMFR0 helper and
> introduces a new one i.e id_aa64mmfr0_iparange() and id_aa64mmfr0_parange()
> respectively.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: James Morse <james.morse@arm.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Cc: kvmarm@lists.cs.columbia.edu
> 
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
> This applies after (https://patchwork.kernel.org/patch/11541893/).
> 
>  arch/arm64/include/asm/cpufeature.h | 11 ++++++++++-
>  arch/arm64/kernel/cpufeature.c      |  5 ++---
>  arch/arm64/kvm/reset.c              |  9 +++++----
>  3 files changed, 17 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
> index 1291ad5a9ccb..320cfc5b6025 100644
> --- a/arch/arm64/include/asm/cpufeature.h
> +++ b/arch/arm64/include/asm/cpufeature.h
> @@ -706,8 +706,17 @@ void arm64_set_ssbd_mitigation(bool state);
>  
>  extern int do_emulate_mrs(struct pt_regs *regs, u32 sys_reg, u32 rt);
>  
> -static inline u32 id_aa64mmfr0_parange_to_phys_shift(int parange)
> +#define ID_AA64MMFR0_PARANGE_MASK 0x7

We already have ID_AA64MMFR0_PARANGE_SHIFT in <asm/sysreg.h>, so if we
need this it should live there too.

The ARM ARM tells me ID_AA64MMFR0_EL1.PARange is bits 3:0, so this
should be 0xf.

Given it's a standard 4-bit field, do we even need this? We have helpers
that assume 4 bits for standard fields, e.g.
cpuid_feature_extract_unsigned_field().

> +
> +static inline u32 id_aa64mmfr0_parange(u64 mmfr0)
>  {
> +	return mmfr0 & ID_AA64MMFR0_PARANGE_MASK;
> +}

	return cpuid_feature_extract_unsigned_field(mmfr0,
		ID_AA64MMFR0_PARANGE_SHIFT);

> +
> +static inline u32 id_aa64mmfr0_iparange(u64 mmfr0)
> +{
> +	int parange = id_aa64mmfr0_parange(mmfr0);
> +
>  	switch (parange) {
>  	case 0: return 32;
>  	case 1: return 36;
> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index 30917fe7942a..2c62f7c64a3c 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -2185,7 +2185,7 @@ static void verify_sve_features(void)
>  void verify_hyp_capabilities(void)
>  {
>  	u64 safe_mmfr1, mmfr0, mmfr1;
> -	int parange, ipa_max;
> +	int ipa_max;
>  	unsigned int safe_vmid_bits, vmid_bits;
>  
>  	safe_mmfr1 = read_sanitised_ftr_reg(SYS_ID_AA64MMFR1_EL1);
> @@ -2201,8 +2201,7 @@ void verify_hyp_capabilities(void)
>  	}
>  
>  	/* Verify IPA range */
> -	parange = mmfr0 & 0x7;
> -	ipa_max = id_aa64mmfr0_parange_to_phys_shift(parange);
> +	ipa_max = id_aa64mmfr0_iparange(mmfr0);

Why drop id_aa64mmfr0_parange_to_phys_shift()?

>  	if (ipa_max < get_kvm_ipa_limit()) {
>  		pr_crit("CPU%d: IPA range mismatch\n", smp_processor_id());
>  		cpu_die_early();
> diff --git a/arch/arm64/kvm/reset.c b/arch/arm64/kvm/reset.c
> index 841b492ff334..2e4da75d79ea 100644
> --- a/arch/arm64/kvm/reset.c
> +++ b/arch/arm64/kvm/reset.c
> @@ -347,10 +347,10 @@ u32 get_kvm_ipa_limit(void)
>  
>  void kvm_set_ipa_limit(void)
>  {
> -	unsigned int ipa_max, pa_max, va_max, parange;
> +	unsigned int ipa_max, pa_max, va_max;
>  
> -	parange = read_sanitised_ftr_reg(SYS_ID_AA64MMFR0_EL1) & 0x7;
> -	pa_max = id_aa64mmfr0_parange_to_phys_shift(parange);
> +	pa_max = id_aa64mmfr0_iparange(read_sanitised_ftr_reg
> +						(SYS_ID_AA64MMFR0_EL1));

Weird style here. the '(' should be kept next to the function name.

>
>  	/* Clamp the IPA limit to the PA size supported by the kernel */
>  	ipa_max = (pa_max > PHYS_MASK_SHIFT) ? PHYS_MASK_SHIFT : pa_max;
> @@ -411,7 +411,8 @@ int kvm_arm_setup_stage2(struct kvm *kvm, unsigned long type)
>  		phys_shift = KVM_PHYS_SHIFT;
>  	}
>  
> -	parange = read_sanitised_ftr_reg(SYS_ID_AA64MMFR0_EL1) & 7;
> +	parange = id_aa64mmfr0_parange(read_sanitised_ftr_reg
> +						(SYS_ID_AA64MMFR0_EL1));

Can't we add a system_ipa_range() helper, and avoid more boilerplate in
each of these?

e.g.

int system_ipa_range(void)
{
	u64 mmfr0;
	int parange;

	mmfr0 = read_sanitised_ftr_reg(SYS_ID_AA64MMFR0_EL1);
	parange = cpuid_feature_extract_unsigned_field(mmfr0,
		ID_AA64MMFR0_PARANGE_SHIFT);
	
	return parange;
}

... we do similar for the system_supports_xxx() helpers.

Thanks,
Mark.
