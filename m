Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 554EE2AD200
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 10:05:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730163AbgKJJFh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 04:05:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:38250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729149AbgKJJDT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 04:03:19 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1207420780;
        Tue, 10 Nov 2020 09:03:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604998998;
        bh=rwemNQkLKgK6qtt+akwirG2D0i6i6Gd2zIB34YrDm+k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=MyUKEW0lfs9/MBqy125ntzabowU60nAIGOXW0Ln7J4fRusN+Ob0vQw2s5R7y8Mtj1
         PmPZ+JA+4ijzWqW1G6UR5cVn0Q0LYAMq3Y+XH1Xh4dx6YICYkVmWqJ+/PB4GEVCaum
         teqtmFShqCprpL8v4t5b/qHGCve7YuIie0qiG/2Y=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1kcPYZ-009ONP-Pf; Tue, 10 Nov 2020 09:03:15 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 10 Nov 2020 09:03:15 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     David Brazdil <dbrazdil@google.com>
Cc:     kvmarm@lists.cs.columbia.edu, kernel-team@android.com,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Walbran <qwandor@google.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Tejun Heo <tj@kernel.org>, Dennis Zhou <dennis@kernel.org>,
        Christoph Lameter <cl@linux.com>, Will Deacon <will@kernel.org>
Subject: Re: [PATCH v1 23/24] kvm: arm64: Trap host SMCs in protected mode.
In-Reply-To: <20201109113233.9012-24-dbrazdil@google.com>
References: <20201109113233.9012-1-dbrazdil@google.com>
 <20201109113233.9012-24-dbrazdil@google.com>
User-Agent: Roundcube Webmail/1.4.9
Message-ID: <10952bcf24bebd5e317d09ced415bfb1@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: dbrazdil@google.com, kvmarm@lists.cs.columbia.edu, kernel-team@android.com, lorenzo.pieralisi@arm.com, qwandor@google.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com, tj@kernel.org, dennis@kernel.org, cl@linux.com, will@kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-11-09 11:32, David Brazdil wrote:
> While protected nVHE KVM is installed, start trapping all host SMCs.
> By default, these are simply forwarded to EL3, but PSCI SMCs are
> validated first.
> 
> Create new constant HCR_HOST_NVHE_PROTECTED_FLAGS with the new set of 
> HCR
> flags to use while the nVHE vector is installed when the kernel was
> booted with the protected flag enabled. Switch back to the default HCR
> flags when switching back to the stub vector.
> 
> Signed-off-by: David Brazdil <dbrazdil@google.com>
> ---
>  arch/arm64/include/asm/kvm_arm.h   |  1 +
>  arch/arm64/kernel/image-vars.h     |  4 ++++
>  arch/arm64/kvm/arm.c               | 35 ++++++++++++++++++++++++++++++
>  arch/arm64/kvm/hyp/nvhe/hyp-init.S |  8 +++++++
>  arch/arm64/kvm/hyp/nvhe/switch.c   |  5 ++++-
>  5 files changed, 52 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/include/asm/kvm_arm.h 
> b/arch/arm64/include/asm/kvm_arm.h
> index 64ce29378467..4e90c2debf70 100644
> --- a/arch/arm64/include/asm/kvm_arm.h
> +++ b/arch/arm64/include/asm/kvm_arm.h
> @@ -80,6 +80,7 @@
>  			 HCR_FMO | HCR_IMO | HCR_PTW )
>  #define HCR_VIRT_EXCP_MASK (HCR_VSE | HCR_VI | HCR_VF)
>  #define HCR_HOST_NVHE_FLAGS (HCR_RW | HCR_API | HCR_APK | HCR_ATA)
> +#define HCR_HOST_NVHE_PROTECTED_FLAGS (HCR_HOST_NVHE_FLAGS | HCR_TSC)
>  #define HCR_HOST_VHE_FLAGS (HCR_RW | HCR_TGE | HCR_E2H)
> 
>  /* TCR_EL2 Registers bits */
> diff --git a/arch/arm64/kernel/image-vars.h 
> b/arch/arm64/kernel/image-vars.h
> index 78a42a7cdb72..75cda51674f4 100644
> --- a/arch/arm64/kernel/image-vars.h
> +++ b/arch/arm64/kernel/image-vars.h
> @@ -62,9 +62,13 @@ __efistub__ctype		= _ctype;
>   */
> 
>  /* Alternative callbacks for init-time patching of nVHE hyp code. */
> +KVM_NVHE_ALIAS(kvm_patch_hcr_flags);
>  KVM_NVHE_ALIAS(kvm_patch_vector_branch);
>  KVM_NVHE_ALIAS(kvm_update_va_mask);
> 
> +/* Static key enabled when the user opted into nVHE protected mode. */
> +KVM_NVHE_ALIAS(kvm_protected_mode);
> +
>  /* Global kernel state accessed by nVHE hyp code. */
>  KVM_NVHE_ALIAS(kvm_vgic_global_state);
> 
> diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
> index 574aa2d026e6..c09b95cfa00a 100644
> --- a/arch/arm64/kvm/arm.c
> +++ b/arch/arm64/kvm/arm.c
> @@ -1861,6 +1861,41 @@ void kvm_arch_exit(void)
>  	kvm_perf_teardown();
>  }
> 
> +static inline u32 __init __gen_mov_hcr_insn(u64 hcr, u32 rd, int i)
> +{
> +	int shift = 48 - (i * 16);
> +	u16 imm = (hcr >> shift) & GENMASK(16, 0);

I really doubt you want to encode 17 bits.

> +
> +	return aarch64_insn_gen_movewide(rd, imm, shift,
> +					 AARCH64_INSN_VARIANT_64BIT,
> +					 (i == 0) ? AARCH64_INSN_MOVEWIDE_ZERO
> +						  : AARCH64_INSN_MOVEWIDE_KEEP);
> +}

I've added a generate_mov_q() helper as part of my host EL2 entry 
rework.
We can probably share some stuff here.

> +
> +void __init kvm_patch_hcr_flags(struct alt_instr *alt,
> +				__le32 *origptr, __le32 *updptr, int nr_inst)
> +{
> +	int i;
> +	u32 rd;
> +
> +	BUG_ON(nr_inst != 4);
> +
> +	/* Skip for VHE and unprotected nVHE modes. */
> +	if (!is_kvm_protected_mode())
> +		return;
> +
> +	rd = aarch64_insn_decode_register(AARCH64_INSN_REGTYPE_RD,
> +					  le32_to_cpu(origptr[0]));
> +
> +	for (i = 0; i < nr_inst; i++) {
> +		u32 oinsn = __gen_mov_hcr_insn(HCR_HOST_NVHE_FLAGS, rd, i);
> +		u32 insn = __gen_mov_hcr_insn(HCR_HOST_NVHE_PROTECTED_FLAGS, rd, i);
> +
> +		BUG_ON(oinsn != le32_to_cpu(origptr[i]));
> +		updptr[i] = cpu_to_le32(insn);
> +	}
> +}
> +
>  static int __init early_kvm_protected_cfg(char *buf)
>  {
>  	bool val;
> diff --git a/arch/arm64/kvm/hyp/nvhe/hyp-init.S
> b/arch/arm64/kvm/hyp/nvhe/hyp-init.S
> index f999a35b2c8c..bbe6c5f558e0 100644
> --- a/arch/arm64/kvm/hyp/nvhe/hyp-init.S
> +++ b/arch/arm64/kvm/hyp/nvhe/hyp-init.S
> @@ -88,6 +88,12 @@ SYM_CODE_END(__kvm_hyp_init)
>   * x0: struct kvm_nvhe_init_params PA
>   */
>  SYM_CODE_START(___kvm_hyp_init)
> +alternative_cb kvm_patch_hcr_flags
> +	mov_q	x1, HCR_HOST_NVHE_FLAGS

You really want to be careful here: the mov_q macro expands to 2, 3 or 4
instructions, depending on the input data...

It is also odd that you have both a static key and a patching 
alternative.
Why isn't "protected KVM" a capability that can be evaluated as a a non
patching alternative? In general, I'd like to reserve patching 
alternatives
to values that cannot be evaluated at compile time (VM offsets, for 
example).

> +alternative_cb_end
> +	msr	hcr_el2, x1
> +	isb
> +
>  	ldr	x1, [x0, #NVHE_INIT_TPIDR_EL2]
>  	msr	tpidr_el2, x1
> 
> @@ -220,6 +226,8 @@ reset:
>  	bic	x5, x5, x6		// Clear SCTL_M and etc
>  	pre_disable_mmu_workaround
>  	msr	sctlr_el2, x5
> +	mov_q	x5, HCR_HOST_NVHE_FLAGS
> +	msr	hcr_el2, x5
>  	isb
> 
>  	/* Install stub vectors */
> diff --git a/arch/arm64/kvm/hyp/nvhe/switch.c 
> b/arch/arm64/kvm/hyp/nvhe/switch.c
> index 8ae8160bc93a..f605b25a9afc 100644
> --- a/arch/arm64/kvm/hyp/nvhe/switch.c
> +++ b/arch/arm64/kvm/hyp/nvhe/switch.c
> @@ -96,7 +96,10 @@ static void __deactivate_traps(struct kvm_vcpu 
> *vcpu)
>  	mdcr_el2 |= MDCR_EL2_E2PB_MASK << MDCR_EL2_E2PB_SHIFT;
> 
>  	write_sysreg(mdcr_el2, mdcr_el2);
> -	write_sysreg(HCR_HOST_NVHE_FLAGS, hcr_el2);
> +	if (is_kvm_protected_mode())
> +		write_sysreg(HCR_HOST_NVHE_PROTECTED_FLAGS, hcr_el2);
> +	else
> +		write_sysreg(HCR_HOST_NVHE_FLAGS, hcr_el2);
>  	write_sysreg(CPTR_EL2_DEFAULT, cptr_el2);
>  	write_sysreg(__kvm_hyp_host_vector, vbar_el2);
>  }

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
