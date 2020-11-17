Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3BAA2B6ECA
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 20:36:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729259AbgKQTfx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 14:35:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:46524 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726352AbgKQTfv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 14:35:51 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6A4D52463B;
        Tue, 17 Nov 2020 19:35:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605641750;
        bh=99AH2Pflh0GwKHkWBYpSX6kuQO3h28x2SHcSILfOZbk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=SsOiLaC2b5E319CIqSVfbBjX1ZCEiVfxcU+YTgV5K2evaZJiz5Kecgq1KkBq3vMkr
         i7WmyYfxEWMnDM6f9T1wmrWwz2uDrDTMaJVkpwpJPc8jOiXrKxuzJpGkOIVlmXHWjw
         F08wCG8b1AXUBpnxdrUACJo6BjrsWAas6hRc5SK8=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1kf6lY-00BTAR-6r; Tue, 17 Nov 2020 19:35:48 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 17 Nov 2020 19:35:48 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Steven Price <steven.price@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Dave Martin <Dave.Martin@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>, qemu-devel@nongnu.org,
        Juan Quintela <quintela@redhat.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        Peter Maydell <peter.maydell@linaro.org>,
        Haibo Xu <Haibo.Xu@arm.com>, Andrew Jones <drjones@redhat.com>
Subject: Re: [PATCH v4 2/2] arm64: kvm: Introduce MTE VCPU feature
In-Reply-To: <20201026155727.36685-3-steven.price@arm.com>
References: <20201026155727.36685-1-steven.price@arm.com>
 <20201026155727.36685-3-steven.price@arm.com>
User-Agent: Roundcube Webmail/1.4.9
Message-ID: <8507a92b4ba3bbc45814b7197bd4e2fb@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: steven.price@arm.com, catalin.marinas@arm.com, will@kernel.org, james.morse@arm.com, julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com, kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Dave.Martin@arm.com, mark.rutland@arm.com, tglx@linutronix.de, qemu-devel@nongnu.org, quintela@redhat.com, dgilbert@redhat.com, richard.henderson@linaro.org, peter.maydell@linaro.org, Haibo.Xu@arm.com, drjones@redhat.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steven,

On 2020-10-26 15:57, Steven Price wrote:
> Add a new VM feature 'KVM_ARM_CAP_MTE' which enables memory tagging
> for a VM. This exposes the feature to the guest and automatically tags
> memory pages touched by the VM as PG_mte_tagged (and clears the tags
> storage) to ensure that the guest cannot see stale tags, and so that 
> the
> tags are correctly saved/restored across swap.
> 
> Signed-off-by: Steven Price <steven.price@arm.com>
> Reviewed-by: Andrew Jones <drjones@redhat.com>
> ---
>  arch/arm64/include/asm/kvm_emulate.h |  3 +++
>  arch/arm64/include/asm/kvm_host.h    |  3 +++
>  arch/arm64/kvm/arm.c                 |  9 +++++++++
>  arch/arm64/kvm/mmu.c                 | 20 ++++++++++++++++++++
>  arch/arm64/kvm/sys_regs.c            |  6 +++++-
>  include/uapi/linux/kvm.h             |  1 +
>  6 files changed, 41 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/include/asm/kvm_emulate.h
> b/arch/arm64/include/asm/kvm_emulate.h
> index 5ef2669ccd6c..66c0d9e7c2b4 100644
> --- a/arch/arm64/include/asm/kvm_emulate.h
> +++ b/arch/arm64/include/asm/kvm_emulate.h
> @@ -79,6 +79,9 @@ static inline void vcpu_reset_hcr(struct kvm_vcpu 
> *vcpu)
>  	if (cpus_have_const_cap(ARM64_MISMATCHED_CACHE_TYPE) ||
>  	    vcpu_el1_is_32bit(vcpu))
>  		vcpu->arch.hcr_el2 |= HCR_TID2;
> +
> +	if (vcpu->kvm->arch.mte_enabled)

Please add a predicate (vcpu_has_mte() or kvm_has_mte()?) for this.

> +		vcpu->arch.hcr_el2 |= HCR_ATA;
>  }
> 
>  static inline unsigned long *vcpu_hcr(struct kvm_vcpu *vcpu)
> diff --git a/arch/arm64/include/asm/kvm_host.h
> b/arch/arm64/include/asm/kvm_host.h
> index 95ab7345dcc8..cd993aec0440 100644
> --- a/arch/arm64/include/asm/kvm_host.h
> +++ b/arch/arm64/include/asm/kvm_host.h
> @@ -118,6 +118,9 @@ struct kvm_arch {
>  	 */
>  	unsigned long *pmu_filter;
>  	unsigned int pmuver;
> +
> +	/* Memory Tagging Extension enabled for the guest */
> +	bool mte_enabled;
>  };
> 
>  struct kvm_vcpu_fault_info {
> diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
> index f56122eedffc..7ee93bcac017 100644
> --- a/arch/arm64/kvm/arm.c
> +++ b/arch/arm64/kvm/arm.c
> @@ -89,6 +89,12 @@ int kvm_vm_ioctl_enable_cap(struct kvm *kvm,
>  		r = 0;
>  		kvm->arch.return_nisv_io_abort_to_user = true;
>  		break;
> +	case KVM_CAP_ARM_MTE:
> +		if (!system_supports_mte() || kvm->created_vcpus)
> +			return -EINVAL;

You also want to avoid 32bit guests. Also, what is the rational for
this being a VM capability as opposed to a CPU feature, similar
to SVE and PMU?

> +		r = 0;
> +		kvm->arch.mte_enabled = true;
> +		break;
>  	default:
>  		r = -EINVAL;
>  		break;
> @@ -210,6 +216,9 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, 
> long ext)
>  		 */
>  		r = 1;
>  		break;
> +	case KVM_CAP_ARM_MTE:
> +		r = system_supports_mte();

Same comment about 32bit.

> +		break;
>  	case KVM_CAP_STEAL_TIME:
>  		r = kvm_arm_pvtime_supported();
>  		break;
> diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
> index 19aacc7d64de..38fe25310ca1 100644
> --- a/arch/arm64/kvm/mmu.c
> +++ b/arch/arm64/kvm/mmu.c
> @@ -862,6 +862,26 @@ static int user_mem_abort(struct kvm_vcpu *vcpu,
> phys_addr_t fault_ipa,
>  	if (vma_pagesize == PAGE_SIZE && !force_pte)
>  		vma_pagesize = transparent_hugepage_adjust(memslot, hva,
>  							   &pfn, &fault_ipa);
> +
> +	/*
> +	 * The otherwise redundant test for system_supports_mte() allows the
> +	 * code to be compiled out when CONFIG_ARM64_MTE is not present.
> +	 */
> +	if (system_supports_mte() && kvm->arch.mte_enabled && pfn_valid(pfn)) 
> {
> +		/*
> +		 * VM will be able to see the page's tags, so we must ensure
> +		 * they have been initialised.
> +		 */
> +		struct page *page = pfn_to_page(pfn);
> +		long i, nr_pages = compound_nr(page);
> +
> +		/* if PG_mte_tagged is set, tags have already been initialised */
> +		for (i = 0; i < nr_pages; i++, page++) {
> +			if (!test_and_set_bit(PG_mte_tagged, &page->flags))
> +				mte_clear_page_tags(page_address(page));
> +		}
> +	}

What are the visibility requirements for the tags, specially if the
guest has its MMU off? Is there any cache management that needs to
occur?

Another thing is device-like memory that is managed by userspace,
such as the QEMU emulated flash, for which there also might be tags.
How is that dealt with? In general, what are the expectations for
tags on memory shared between host and guest? Who owns them?

> +
>  	if (writable) {
>  		prot |= KVM_PGTABLE_PROT_W;
>  		kvm_set_pfn_dirty(pfn);
> diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
> index 430e36e1a13d..35a3dc448231 100644
> --- a/arch/arm64/kvm/sys_regs.c
> +++ b/arch/arm64/kvm/sys_regs.c
> @@ -1132,7 +1132,8 @@ static u64 read_id_reg(const struct kvm_vcpu 
> *vcpu,
>  		    arm64_get_spectre_v2_state() == SPECTRE_UNAFFECTED)
>  			val |= (1UL << ID_AA64PFR0_CSV2_SHIFT);
>  	} else if (id == SYS_ID_AA64PFR1_EL1) {
> -		val &= ~(0xfUL << ID_AA64PFR1_MTE_SHIFT);
> +		if (!vcpu->kvm->arch.mte_enabled)
> +			val &= ~(0xfUL << ID_AA64PFR1_MTE_SHIFT);
>  	} else if (id == SYS_ID_AA64ISAR1_EL1 && !vcpu_has_ptrauth(vcpu)) {
>  		val &= ~((0xfUL << ID_AA64ISAR1_APA_SHIFT) |
>  			 (0xfUL << ID_AA64ISAR1_API_SHIFT) |
> @@ -1394,6 +1395,9 @@ static bool access_mte_regs(struct kvm_vcpu
> *vcpu, struct sys_reg_params *p,
>  static unsigned int mte_visibility(const struct kvm_vcpu *vcpu,
>  				   const struct sys_reg_desc *rd)
>  {
> +	if (vcpu->kvm->arch.mte_enabled)
> +		return 0;
> +
>  	return REG_HIDDEN_USER | REG_HIDDEN_GUEST;
>  }
> 
> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> index ca41220b40b8..3e6fb5b580a9 100644
> --- a/include/uapi/linux/kvm.h
> +++ b/include/uapi/linux/kvm.h
> @@ -1053,6 +1053,7 @@ struct kvm_ppc_resize_hpt {
>  #define KVM_CAP_X86_USER_SPACE_MSR 188
>  #define KVM_CAP_X86_MSR_FILTER 189
>  #define KVM_CAP_ENFORCE_PV_FEATURE_CPUID 190
> +#define KVM_CAP_ARM_MTE 191
> 
>  #ifdef KVM_CAP_IRQ_ROUTING

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
