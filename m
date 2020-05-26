Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 523BD1E2005
	for <lists+linux-kernel@lfdr.de>; Tue, 26 May 2020 12:45:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388705AbgEZKpO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 May 2020 06:45:14 -0400
Received: from foss.arm.com ([217.140.110.172]:48996 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726977AbgEZKpO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 06:45:14 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4BF9E55D;
        Tue, 26 May 2020 03:45:13 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 65DF43F52E;
        Tue, 26 May 2020 03:45:10 -0700 (PDT)
Date:   Tue, 26 May 2020 11:45:07 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Gavin Shan <gshan@redhat.com>
Cc:     kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, maz@kernel.org, will@kernel.org,
        catalin.marinas@arm.com, james.morse@arm.com,
        suzuki.poulose@arm.com, drjones@redhat.com, eric.auger@redhat.com,
        aarcange@redhat.com, shan.gavin@gmail.com
Subject: Re: [PATCH RFCv2 5/9] kvm/arm64: Replace hsr with esr
Message-ID: <20200526104507.GC1363@C02TD0UTHF1T.local>
References: <20200508032919.52147-1-gshan@redhat.com>
 <20200508032919.52147-6-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200508032919.52147-6-gshan@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 08, 2020 at 01:29:15PM +1000, Gavin Shan wrote:
> This replace the variable names to make them self-explaining. The
> tracepoint isn't changed accordingly because they're part of ABI:
> 
>    * @hsr to @esr
>    * @hsr_ec to @ec
>    * Use kvm_vcpu_trap_get_class() helper if possible
> 
> Signed-off-by: Gavin Shan <gshan@redhat.com>

As with patch 3, I think this cleanup makes sense independent from the
rest of the series, and I think it'd make sense to bundle all the
patches renaming hsr -> esr, and send those as a preparatory series.

Thanks,
Mark.

> ---
>  arch/arm64/kvm/handle_exit.c | 28 ++++++++++++++--------------
>  arch/arm64/kvm/hyp/switch.c  |  9 ++++-----
>  arch/arm64/kvm/sys_regs.c    | 30 +++++++++++++++---------------
>  3 files changed, 33 insertions(+), 34 deletions(-)
> 
> diff --git a/arch/arm64/kvm/handle_exit.c b/arch/arm64/kvm/handle_exit.c
> index 00858db82a64..e3b3dcd5b811 100644
> --- a/arch/arm64/kvm/handle_exit.c
> +++ b/arch/arm64/kvm/handle_exit.c
> @@ -123,13 +123,13 @@ static int kvm_handle_wfx(struct kvm_vcpu *vcpu, struct kvm_run *run)
>   */
>  static int kvm_handle_guest_debug(struct kvm_vcpu *vcpu, struct kvm_run *run)
>  {
> -	u32 hsr = kvm_vcpu_get_esr(vcpu);
> +	u32 esr = kvm_vcpu_get_esr(vcpu);
>  	int ret = 0;
>  
>  	run->exit_reason = KVM_EXIT_DEBUG;
> -	run->debug.arch.hsr = hsr;
> +	run->debug.arch.hsr = esr;
>  
> -	switch (ESR_ELx_EC(hsr)) {
> +	switch (kvm_vcpu_trap_get_class(esr)) {
>  	case ESR_ELx_EC_WATCHPT_LOW:
>  		run->debug.arch.far = vcpu->arch.fault.far_el2;
>  		/* fall through */
> @@ -139,8 +139,8 @@ static int kvm_handle_guest_debug(struct kvm_vcpu *vcpu, struct kvm_run *run)
>  	case ESR_ELx_EC_BRK64:
>  		break;
>  	default:
> -		kvm_err("%s: un-handled case hsr: %#08x\n",
> -			__func__, (unsigned int) hsr);
> +		kvm_err("%s: un-handled case esr: %#08x\n",
> +			__func__, (unsigned int)esr);
>  		ret = -1;
>  		break;
>  	}
> @@ -150,10 +150,10 @@ static int kvm_handle_guest_debug(struct kvm_vcpu *vcpu, struct kvm_run *run)
>  
>  static int kvm_handle_unknown_ec(struct kvm_vcpu *vcpu, struct kvm_run *run)
>  {
> -	u32 hsr = kvm_vcpu_get_esr(vcpu);
> +	u32 esr = kvm_vcpu_get_esr(vcpu);
>  
> -	kvm_pr_unimpl("Unknown exception class: hsr: %#08x -- %s\n",
> -		      hsr, esr_get_class_string(hsr));
> +	kvm_pr_unimpl("Unknown exception class: esr: %#08x -- %s\n",
> +		      esr, esr_get_class_string(esr));
>  
>  	kvm_inject_undefined(vcpu);
>  	return 1;
> @@ -230,10 +230,10 @@ static exit_handle_fn arm_exit_handlers[] = {
>  
>  static exit_handle_fn kvm_get_exit_handler(struct kvm_vcpu *vcpu)
>  {
> -	u32 hsr = kvm_vcpu_get_esr(vcpu);
> -	u8 hsr_ec = ESR_ELx_EC(hsr);
> +	u32 esr = kvm_vcpu_get_esr(vcpu);
> +	u8 ec = kvm_vcpu_trap_get_class(esr);
>  
> -	return arm_exit_handlers[hsr_ec];
> +	return arm_exit_handlers[ec];
>  }
>  
>  /*
> @@ -273,15 +273,15 @@ int handle_exit(struct kvm_vcpu *vcpu, struct kvm_run *run,
>  {
>  	if (ARM_SERROR_PENDING(exception_index)) {
>  		u32 esr = kvm_vcpu_get_esr(vcpu);
> -		u8 hsr_ec = ESR_ELx_EC(esr);
> +		u8 ec = kvm_vcpu_trap_get_class(esr);
>  
>  		/*
>  		 * HVC/SMC already have an adjusted PC, which we need
>  		 * to correct in order to return to after having
>  		 * injected the SError.
>  		 */
> -		if (hsr_ec == ESR_ELx_EC_HVC32 || hsr_ec == ESR_ELx_EC_HVC64 ||
> -		    hsr_ec == ESR_ELx_EC_SMC32 || hsr_ec == ESR_ELx_EC_SMC64) {
> +		if (ec == ESR_ELx_EC_HVC32 || ec == ESR_ELx_EC_HVC64 ||
> +		    ec == ESR_ELx_EC_SMC32 || ec == ESR_ELx_EC_SMC64) {
>  			u32 adj =  kvm_vcpu_trap_il_is32bit(esr) ? 4 : 2;
>  			*vcpu_pc(vcpu) -= adj;
>  		}
> diff --git a/arch/arm64/kvm/hyp/switch.c b/arch/arm64/kvm/hyp/switch.c
> index 369f22f49f3d..7bf4840bf90e 100644
> --- a/arch/arm64/kvm/hyp/switch.c
> +++ b/arch/arm64/kvm/hyp/switch.c
> @@ -356,8 +356,8 @@ static bool __hyp_text __populate_fault_info(struct kvm_vcpu *vcpu)
>  static bool __hyp_text __hyp_handle_fpsimd(struct kvm_vcpu *vcpu)
>  {
>  	u32 esr = kvm_vcpu_get_esr(vcpu);
> +	u8 ec = kvm_vcpu_trap_get_class(esr);
>  	bool vhe, sve_guest, sve_host;
> -	u8 hsr_ec;
>  
>  	if (!system_supports_fpsimd())
>  		return false;
> @@ -372,14 +372,13 @@ static bool __hyp_text __hyp_handle_fpsimd(struct kvm_vcpu *vcpu)
>  		vhe = has_vhe();
>  	}
>  
> -	hsr_ec = kvm_vcpu_trap_get_class(esr);
> -	if (hsr_ec != ESR_ELx_EC_FP_ASIMD &&
> -	    hsr_ec != ESR_ELx_EC_SVE)
> +	if (ec != ESR_ELx_EC_FP_ASIMD &&
> +	    ec != ESR_ELx_EC_SVE)
>  		return false;
>  
>  	/* Don't handle SVE traps for non-SVE vcpus here: */
>  	if (!sve_guest)
> -		if (hsr_ec != ESR_ELx_EC_FP_ASIMD)
> +		if (ec != ESR_ELx_EC_FP_ASIMD)
>  			return false;
>  
>  	/* Valid trap.  Switch the context: */
> diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
> index 012fff834a4b..58f81ab519af 100644
> --- a/arch/arm64/kvm/sys_regs.c
> +++ b/arch/arm64/kvm/sys_regs.c
> @@ -2182,10 +2182,10 @@ static void unhandled_cp_access(struct kvm_vcpu *vcpu,
>  				struct sys_reg_params *params)
>  {
>  	u32 esr = kvm_vcpu_get_esr(vcpu);
> -	u8 hsr_ec = kvm_vcpu_trap_get_class(esr);
> +	u8 ec = kvm_vcpu_trap_get_class(esr);
>  	int cp = -1;
>  
> -	switch(hsr_ec) {
> +	switch (ec) {
>  	case ESR_ELx_EC_CP15_32:
>  	case ESR_ELx_EC_CP15_64:
>  		cp = 15;
> @@ -2216,17 +2216,17 @@ static int kvm_handle_cp_64(struct kvm_vcpu *vcpu,
>  			    size_t nr_specific)
>  {
>  	struct sys_reg_params params;
> -	u32 hsr = kvm_vcpu_get_esr(vcpu);
> -	int Rt = kvm_vcpu_sys_get_rt(hsr);
> -	int Rt2 = (hsr >> 10) & 0x1f;
> +	u32 esr = kvm_vcpu_get_esr(vcpu);
> +	int Rt = kvm_vcpu_sys_get_rt(esr);
> +	int Rt2 = (esr >> 10) & 0x1f;
>  
>  	params.is_aarch32 = true;
>  	params.is_32bit = false;
> -	params.CRm = (hsr >> 1) & 0xf;
> -	params.is_write = ((hsr & 1) == 0);
> +	params.CRm = (esr >> 1) & 0xf;
> +	params.is_write = ((esr & 1) == 0);
>  
>  	params.Op0 = 0;
> -	params.Op1 = (hsr >> 16) & 0xf;
> +	params.Op1 = (esr >> 16) & 0xf;
>  	params.Op2 = 0;
>  	params.CRn = 0;
>  
> @@ -2273,18 +2273,18 @@ static int kvm_handle_cp_32(struct kvm_vcpu *vcpu,
>  			    size_t nr_specific)
>  {
>  	struct sys_reg_params params;
> -	u32 hsr = kvm_vcpu_get_esr(vcpu);
> -	int Rt  = kvm_vcpu_sys_get_rt(hsr);
> +	u32 esr = kvm_vcpu_get_esr(vcpu);
> +	int Rt = kvm_vcpu_sys_get_rt(esr);
>  
>  	params.is_aarch32 = true;
>  	params.is_32bit = true;
> -	params.CRm = (hsr >> 1) & 0xf;
> +	params.CRm = (esr >> 1) & 0xf;
>  	params.regval = vcpu_get_reg(vcpu, Rt);
> -	params.is_write = ((hsr & 1) == 0);
> -	params.CRn = (hsr >> 10) & 0xf;
> +	params.is_write = ((esr & 1) == 0);
> +	params.CRn = (esr >> 10) & 0xf;
>  	params.Op0 = 0;
> -	params.Op1 = (hsr >> 14) & 0x7;
> -	params.Op2 = (hsr >> 17) & 0x7;
> +	params.Op1 = (esr >> 14) & 0x7;
> +	params.Op2 = (esr >> 17) & 0x7;
>  
>  	if (!emulate_cp(vcpu, &params, target_specific, nr_specific) ||
>  	    !emulate_cp(vcpu, &params, global, nr_global)) {
> -- 
> 2.23.0
> 
