Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B8BF1E1FFA
	for <lists+linux-kernel@lfdr.de>; Tue, 26 May 2020 12:43:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388592AbgEZKm5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 May 2020 06:42:57 -0400
Received: from foss.arm.com ([217.140.110.172]:48942 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731890AbgEZKm5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 06:42:57 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 151781FB;
        Tue, 26 May 2020 03:42:56 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D94EF3F52E;
        Tue, 26 May 2020 03:42:52 -0700 (PDT)
Date:   Tue, 26 May 2020 11:42:49 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Gavin Shan <gshan@redhat.com>
Cc:     kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, maz@kernel.org, will@kernel.org,
        catalin.marinas@arm.com, james.morse@arm.com,
        suzuki.poulose@arm.com, drjones@redhat.com, eric.auger@redhat.com,
        aarcange@redhat.com, shan.gavin@gmail.com
Subject: Re: [PATCH RFCv2 3/9] kvm/arm64: Rename kvm_vcpu_get_hsr() to
 kvm_vcpu_get_esr()
Message-ID: <20200526104249.GB1363@C02TD0UTHF1T.local>
References: <20200508032919.52147-1-gshan@redhat.com>
 <20200508032919.52147-4-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200508032919.52147-4-gshan@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 08, 2020 at 01:29:13PM +1000, Gavin Shan wrote:
> Since kvm/arm32 was removed, this renames kvm_vcpu_get_hsr() to
> kvm_vcpu_get_esr() to it a bit more self-explaining because the
> functions returns ESR instead of HSR on aarch64. This shouldn't
> cause any functional changes.
> 
> Signed-off-by: Gavin Shan <gshan@redhat.com>

I think that this would be a nice cleanup on its own, and could be taken
independently of the rest of this series if it were rebased and sent as
a single patch.

Mark.

> ---
>  arch/arm64/include/asm/kvm_emulate.h | 36 +++++++++++++++-------------
>  arch/arm64/kvm/handle_exit.c         | 12 +++++-----
>  arch/arm64/kvm/hyp/switch.c          |  2 +-
>  arch/arm64/kvm/sys_regs.c            |  6 ++---
>  virt/kvm/arm/hyp/aarch32.c           |  2 +-
>  virt/kvm/arm/hyp/vgic-v3-sr.c        |  4 ++--
>  virt/kvm/arm/mmu.c                   |  6 ++---
>  7 files changed, 35 insertions(+), 33 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/kvm_emulate.h b/arch/arm64/include/asm/kvm_emulate.h
> index a30b4eec7cb4..bd1a69e7c104 100644
> --- a/arch/arm64/include/asm/kvm_emulate.h
> +++ b/arch/arm64/include/asm/kvm_emulate.h
> @@ -265,14 +265,14 @@ static inline bool vcpu_mode_priv(const struct kvm_vcpu *vcpu)
>  	return mode != PSR_MODE_EL0t;
>  }
>  
> -static __always_inline u32 kvm_vcpu_get_hsr(const struct kvm_vcpu *vcpu)
> +static __always_inline u32 kvm_vcpu_get_esr(const struct kvm_vcpu *vcpu)
>  {
>  	return vcpu->arch.fault.esr_el2;
>  }
>  
>  static __always_inline int kvm_vcpu_get_condition(const struct kvm_vcpu *vcpu)
>  {
> -	u32 esr = kvm_vcpu_get_hsr(vcpu);
> +	u32 esr = kvm_vcpu_get_esr(vcpu);
>  
>  	if (esr & ESR_ELx_CV)
>  		return (esr & ESR_ELx_COND_MASK) >> ESR_ELx_COND_SHIFT;
> @@ -297,64 +297,66 @@ static inline u64 kvm_vcpu_get_disr(const struct kvm_vcpu *vcpu)
>  
>  static inline u32 kvm_vcpu_hvc_get_imm(const struct kvm_vcpu *vcpu)
>  {
> -	return kvm_vcpu_get_hsr(vcpu) & ESR_ELx_xVC_IMM_MASK;
> +	return kvm_vcpu_get_esr(vcpu) & ESR_ELx_xVC_IMM_MASK;
>  }
>  
>  static __always_inline bool kvm_vcpu_dabt_isvalid(const struct kvm_vcpu *vcpu)
>  {
> -	return !!(kvm_vcpu_get_hsr(vcpu) & ESR_ELx_ISV);
> +	return !!(kvm_vcpu_get_esr(vcpu) & ESR_ELx_ISV);
>  }
>  
>  static inline unsigned long kvm_vcpu_dabt_iss_nisv_sanitized(const struct kvm_vcpu *vcpu)
>  {
> -	return kvm_vcpu_get_hsr(vcpu) & (ESR_ELx_CM | ESR_ELx_WNR | ESR_ELx_FSC);
> +	return kvm_vcpu_get_esr(vcpu) &
> +	       (ESR_ELx_CM | ESR_ELx_WNR | ESR_ELx_FSC);
>  }
>  
>  static inline bool kvm_vcpu_dabt_issext(const struct kvm_vcpu *vcpu)
>  {
> -	return !!(kvm_vcpu_get_hsr(vcpu) & ESR_ELx_SSE);
> +	return !!(kvm_vcpu_get_esr(vcpu) & ESR_ELx_SSE);
>  }
>  
>  static inline bool kvm_vcpu_dabt_issf(const struct kvm_vcpu *vcpu)
>  {
> -	return !!(kvm_vcpu_get_hsr(vcpu) & ESR_ELx_SF);
> +	return !!(kvm_vcpu_get_esr(vcpu) & ESR_ELx_SF);
>  }
>  
>  static __always_inline int kvm_vcpu_dabt_get_rd(const struct kvm_vcpu *vcpu)
>  {
> -	return (kvm_vcpu_get_hsr(vcpu) & ESR_ELx_SRT_MASK) >> ESR_ELx_SRT_SHIFT;
> +	return (kvm_vcpu_get_esr(vcpu) & ESR_ELx_SRT_MASK) >> ESR_ELx_SRT_SHIFT;
>  }
>  
>  static __always_inline bool kvm_vcpu_dabt_iss1tw(const struct kvm_vcpu *vcpu)
>  {
> -	return !!(kvm_vcpu_get_hsr(vcpu) & ESR_ELx_S1PTW);
> +	return !!(kvm_vcpu_get_esr(vcpu) & ESR_ELx_S1PTW);
>  }
>  
>  static __always_inline bool kvm_vcpu_dabt_iswrite(const struct kvm_vcpu *vcpu)
>  {
> -	return !!(kvm_vcpu_get_hsr(vcpu) & ESR_ELx_WNR) ||
> +	return !!(kvm_vcpu_get_esr(vcpu) & ESR_ELx_WNR) ||
>  		kvm_vcpu_dabt_iss1tw(vcpu); /* AF/DBM update */
>  }
>  
>  static inline bool kvm_vcpu_dabt_is_cm(const struct kvm_vcpu *vcpu)
>  {
> -	return !!(kvm_vcpu_get_hsr(vcpu) & ESR_ELx_CM);
> +	return !!(kvm_vcpu_get_esr(vcpu) & ESR_ELx_CM);
>  }
>  
>  static __always_inline unsigned int kvm_vcpu_dabt_get_as(const struct kvm_vcpu *vcpu)
>  {
> -	return 1 << ((kvm_vcpu_get_hsr(vcpu) & ESR_ELx_SAS) >> ESR_ELx_SAS_SHIFT);
> +	return 1 << ((kvm_vcpu_get_esr(vcpu) & ESR_ELx_SAS) >>
> +		     ESR_ELx_SAS_SHIFT);
>  }
>  
>  /* This one is not specific to Data Abort */
>  static __always_inline bool kvm_vcpu_trap_il_is32bit(const struct kvm_vcpu *vcpu)
>  {
> -	return !!(kvm_vcpu_get_hsr(vcpu) & ESR_ELx_IL);
> +	return !!(kvm_vcpu_get_esr(vcpu) & ESR_ELx_IL);
>  }
>  
>  static __always_inline u8 kvm_vcpu_trap_get_class(const struct kvm_vcpu *vcpu)
>  {
> -	return ESR_ELx_EC(kvm_vcpu_get_hsr(vcpu));
> +	return ESR_ELx_EC(kvm_vcpu_get_esr(vcpu));
>  }
>  
>  static inline bool kvm_vcpu_trap_is_iabt(const struct kvm_vcpu *vcpu)
> @@ -364,12 +366,12 @@ static inline bool kvm_vcpu_trap_is_iabt(const struct kvm_vcpu *vcpu)
>  
>  static __always_inline u8 kvm_vcpu_trap_get_fault(const struct kvm_vcpu *vcpu)
>  {
> -	return kvm_vcpu_get_hsr(vcpu) & ESR_ELx_FSC;
> +	return kvm_vcpu_get_esr(vcpu) & ESR_ELx_FSC;
>  }
>  
>  static __always_inline u8 kvm_vcpu_trap_get_fault_type(const struct kvm_vcpu *vcpu)
>  {
> -	return kvm_vcpu_get_hsr(vcpu) & ESR_ELx_FSC_TYPE;
> +	return kvm_vcpu_get_esr(vcpu) & ESR_ELx_FSC_TYPE;
>  }
>  
>  static __always_inline bool kvm_vcpu_dabt_isextabt(const struct kvm_vcpu *vcpu)
> @@ -393,7 +395,7 @@ static __always_inline bool kvm_vcpu_dabt_isextabt(const struct kvm_vcpu *vcpu)
>  
>  static __always_inline int kvm_vcpu_sys_get_rt(struct kvm_vcpu *vcpu)
>  {
> -	u32 esr = kvm_vcpu_get_hsr(vcpu);
> +	u32 esr = kvm_vcpu_get_esr(vcpu);
>  	return ESR_ELx_SYS64_ISS_RT(esr);
>  }
>  
> diff --git a/arch/arm64/kvm/handle_exit.c b/arch/arm64/kvm/handle_exit.c
> index aacfc55de44c..c5b75a4d5eda 100644
> --- a/arch/arm64/kvm/handle_exit.c
> +++ b/arch/arm64/kvm/handle_exit.c
> @@ -89,7 +89,7 @@ static int handle_no_fpsimd(struct kvm_vcpu *vcpu, struct kvm_run *run)
>   */
>  static int kvm_handle_wfx(struct kvm_vcpu *vcpu, struct kvm_run *run)
>  {
> -	if (kvm_vcpu_get_hsr(vcpu) & ESR_ELx_WFx_ISS_WFE) {
> +	if (kvm_vcpu_get_esr(vcpu) & ESR_ELx_WFx_ISS_WFE) {
>  		trace_kvm_wfx_arm64(*vcpu_pc(vcpu), true);
>  		vcpu->stat.wfe_exit_stat++;
>  		kvm_vcpu_on_spin(vcpu, vcpu_mode_priv(vcpu));
> @@ -119,7 +119,7 @@ static int kvm_handle_wfx(struct kvm_vcpu *vcpu, struct kvm_run *run)
>   */
>  static int kvm_handle_guest_debug(struct kvm_vcpu *vcpu, struct kvm_run *run)
>  {
> -	u32 hsr = kvm_vcpu_get_hsr(vcpu);
> +	u32 hsr = kvm_vcpu_get_esr(vcpu);
>  	int ret = 0;
>  
>  	run->exit_reason = KVM_EXIT_DEBUG;
> @@ -146,7 +146,7 @@ static int kvm_handle_guest_debug(struct kvm_vcpu *vcpu, struct kvm_run *run)
>  
>  static int kvm_handle_unknown_ec(struct kvm_vcpu *vcpu, struct kvm_run *run)
>  {
> -	u32 hsr = kvm_vcpu_get_hsr(vcpu);
> +	u32 hsr = kvm_vcpu_get_esr(vcpu);
>  
>  	kvm_pr_unimpl("Unknown exception class: hsr: %#08x -- %s\n",
>  		      hsr, esr_get_class_string(hsr));
> @@ -226,7 +226,7 @@ static exit_handle_fn arm_exit_handlers[] = {
>  
>  static exit_handle_fn kvm_get_exit_handler(struct kvm_vcpu *vcpu)
>  {
> -	u32 hsr = kvm_vcpu_get_hsr(vcpu);
> +	u32 hsr = kvm_vcpu_get_esr(vcpu);
>  	u8 hsr_ec = ESR_ELx_EC(hsr);
>  
>  	return arm_exit_handlers[hsr_ec];
> @@ -267,7 +267,7 @@ int handle_exit(struct kvm_vcpu *vcpu, struct kvm_run *run,
>  		       int exception_index)
>  {
>  	if (ARM_SERROR_PENDING(exception_index)) {
> -		u8 hsr_ec = ESR_ELx_EC(kvm_vcpu_get_hsr(vcpu));
> +		u8 hsr_ec = ESR_ELx_EC(kvm_vcpu_get_esr(vcpu));
>  
>  		/*
>  		 * HVC/SMC already have an adjusted PC, which we need
> @@ -333,5 +333,5 @@ void handle_exit_early(struct kvm_vcpu *vcpu, struct kvm_run *run,
>  	exception_index = ARM_EXCEPTION_CODE(exception_index);
>  
>  	if (exception_index == ARM_EXCEPTION_EL1_SERROR)
> -		kvm_handle_guest_serror(vcpu, kvm_vcpu_get_hsr(vcpu));
> +		kvm_handle_guest_serror(vcpu, kvm_vcpu_get_esr(vcpu));
>  }
> diff --git a/arch/arm64/kvm/hyp/switch.c b/arch/arm64/kvm/hyp/switch.c
> index 8a1e81a400e0..2c3242bcfed2 100644
> --- a/arch/arm64/kvm/hyp/switch.c
> +++ b/arch/arm64/kvm/hyp/switch.c
> @@ -437,7 +437,7 @@ static bool __hyp_text __hyp_handle_fpsimd(struct kvm_vcpu *vcpu)
>  
>  static bool __hyp_text handle_tx2_tvm(struct kvm_vcpu *vcpu)
>  {
> -	u32 sysreg = esr_sys64_to_sysreg(kvm_vcpu_get_hsr(vcpu));
> +	u32 sysreg = esr_sys64_to_sysreg(kvm_vcpu_get_esr(vcpu));
>  	int rt = kvm_vcpu_sys_get_rt(vcpu);
>  	u64 val = vcpu_get_reg(vcpu, rt);
>  
> diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
> index 51db934702b6..5b61465927b7 100644
> --- a/arch/arm64/kvm/sys_regs.c
> +++ b/arch/arm64/kvm/sys_regs.c
> @@ -2214,7 +2214,7 @@ static int kvm_handle_cp_64(struct kvm_vcpu *vcpu,
>  			    size_t nr_specific)
>  {
>  	struct sys_reg_params params;
> -	u32 hsr = kvm_vcpu_get_hsr(vcpu);
> +	u32 hsr = kvm_vcpu_get_esr(vcpu);
>  	int Rt = kvm_vcpu_sys_get_rt(vcpu);
>  	int Rt2 = (hsr >> 10) & 0x1f;
>  
> @@ -2271,7 +2271,7 @@ static int kvm_handle_cp_32(struct kvm_vcpu *vcpu,
>  			    size_t nr_specific)
>  {
>  	struct sys_reg_params params;
> -	u32 hsr = kvm_vcpu_get_hsr(vcpu);
> +	u32 hsr = kvm_vcpu_get_esr(vcpu);
>  	int Rt  = kvm_vcpu_sys_get_rt(vcpu);
>  
>  	params.is_aarch32 = true;
> @@ -2387,7 +2387,7 @@ static void reset_sys_reg_descs(struct kvm_vcpu *vcpu,
>  int kvm_handle_sys_reg(struct kvm_vcpu *vcpu, struct kvm_run *run)
>  {
>  	struct sys_reg_params params;
> -	unsigned long esr = kvm_vcpu_get_hsr(vcpu);
> +	unsigned long esr = kvm_vcpu_get_esr(vcpu);
>  	int Rt = kvm_vcpu_sys_get_rt(vcpu);
>  	int ret;
>  
> diff --git a/virt/kvm/arm/hyp/aarch32.c b/virt/kvm/arm/hyp/aarch32.c
> index d31f267961e7..864b477e660a 100644
> --- a/virt/kvm/arm/hyp/aarch32.c
> +++ b/virt/kvm/arm/hyp/aarch32.c
> @@ -51,7 +51,7 @@ bool __hyp_text kvm_condition_valid32(const struct kvm_vcpu *vcpu)
>  	int cond;
>  
>  	/* Top two bits non-zero?  Unconditional. */
> -	if (kvm_vcpu_get_hsr(vcpu) >> 30)
> +	if (kvm_vcpu_get_esr(vcpu) >> 30)
>  		return true;
>  
>  	/* Is condition field valid? */
> diff --git a/virt/kvm/arm/hyp/vgic-v3-sr.c b/virt/kvm/arm/hyp/vgic-v3-sr.c
> index ccf1fde9836c..8a7a14ec9120 100644
> --- a/virt/kvm/arm/hyp/vgic-v3-sr.c
> +++ b/virt/kvm/arm/hyp/vgic-v3-sr.c
> @@ -441,7 +441,7 @@ static int __hyp_text __vgic_v3_bpr_min(void)
>  
>  static int __hyp_text __vgic_v3_get_group(struct kvm_vcpu *vcpu)
>  {
> -	u32 esr = kvm_vcpu_get_hsr(vcpu);
> +	u32 esr = kvm_vcpu_get_esr(vcpu);
>  	u8 crm = (esr & ESR_ELx_SYS64_ISS_CRM_MASK) >> ESR_ELx_SYS64_ISS_CRM_SHIFT;
>  
>  	return crm != 8;
> @@ -1007,7 +1007,7 @@ int __hyp_text __vgic_v3_perform_cpuif_access(struct kvm_vcpu *vcpu)
>  	bool is_read;
>  	u32 sysreg;
>  
> -	esr = kvm_vcpu_get_hsr(vcpu);
> +	esr = kvm_vcpu_get_esr(vcpu);
>  	if (vcpu_mode_is_32bit(vcpu)) {
>  		if (!kvm_condition_valid(vcpu)) {
>  			__kvm_skip_instr(vcpu);
> diff --git a/virt/kvm/arm/mmu.c b/virt/kvm/arm/mmu.c
> index e3b9ee268823..5da0d0e7519b 100644
> --- a/virt/kvm/arm/mmu.c
> +++ b/virt/kvm/arm/mmu.c
> @@ -1922,7 +1922,7 @@ int kvm_handle_guest_abort(struct kvm_vcpu *vcpu, struct kvm_run *run)
>  		 * For RAS the host kernel may handle this abort.
>  		 * There is no need to pass the error into the guest.
>  		 */
> -		if (!kvm_handle_guest_sea(fault_ipa, kvm_vcpu_get_hsr(vcpu)))
> +		if (!kvm_handle_guest_sea(fault_ipa, kvm_vcpu_get_esr(vcpu)))
>  			return 1;
>  
>  		if (unlikely(!is_iabt)) {
> @@ -1931,7 +1931,7 @@ int kvm_handle_guest_abort(struct kvm_vcpu *vcpu, struct kvm_run *run)
>  		}
>  	}
>  
> -	trace_kvm_guest_fault(*vcpu_pc(vcpu), kvm_vcpu_get_hsr(vcpu),
> +	trace_kvm_guest_fault(*vcpu_pc(vcpu), kvm_vcpu_get_esr(vcpu),
>  			      kvm_vcpu_get_hfar(vcpu), fault_ipa);
>  
>  	/* Check the stage-2 fault is trans. fault or write fault */
> @@ -1940,7 +1940,7 @@ int kvm_handle_guest_abort(struct kvm_vcpu *vcpu, struct kvm_run *run)
>  		kvm_err("Unsupported FSC: EC=%#x xFSC=%#lx ESR_EL2=%#lx\n",
>  			kvm_vcpu_trap_get_class(vcpu),
>  			(unsigned long)kvm_vcpu_trap_get_fault(vcpu),
> -			(unsigned long)kvm_vcpu_get_hsr(vcpu));
> +			(unsigned long)kvm_vcpu_get_esr(vcpu));
>  		return -EFAULT;
>  	}
>  
> -- 
> 2.23.0
> 
