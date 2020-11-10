Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2E682ADA6E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 16:30:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730791AbgKJPa0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 10:30:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:34102 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730200AbgKJPa0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 10:30:26 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 84A4720797;
        Tue, 10 Nov 2020 15:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605022224;
        bh=p4iuopjuRljxHBDDNrLSLutPV2YsIkBcZAQ/CN7b5Z4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=z9+sksTtGkjPrDfCsuPoYz3eBJLWgKss6WxR4i9sUeZm093o77dytQAJDhb+uTGkU
         sKIX+ND0Z0jcIsUXqnCFR2Jhv/cNEx4qs9r6kp0/5t+9stIHC+4O0DLXeqcuwo9NaS
         D0zPG0svBU4jVSAvfgRvuDVMJpH6pUQYx6+6cgsU=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1kcVbC-009UQ8-B4; Tue, 10 Nov 2020 15:30:22 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 10 Nov 2020 15:30:22 +0000
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
Subject: Re: [PATCH v1 08/24] kvm: arm64: Move hyp-init params to a per-CPU
 struct
In-Reply-To: <20201109113233.9012-9-dbrazdil@google.com>
References: <20201109113233.9012-1-dbrazdil@google.com>
 <20201109113233.9012-9-dbrazdil@google.com>
User-Agent: Roundcube Webmail/1.4.9
Message-ID: <be241d5b3db1ce9e5529c18ebef8c800@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: dbrazdil@google.com, kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, james.morse@arm.com, julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com, catalin.marinas@arm.com, will@kernel.org, dennis@kernel.org, tj@kernel.org, cl@linux.com, mark.rutland@arm.com, lorenzo.pieralisi@arm.com, qperret@google.com, ascull@google.com, qwandor@google.com, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-11-09 11:32, David Brazdil wrote:
> Once we start initializing KVM on newly booted cores before the rest of
> the kernel, parameters to __do_hyp_init will need to be provided by EL2
> rather than EL1. At that point it will not be possible to pass its four
> arguments directly because PSCI_CPU_ON only supports one context
> argument.
> 
> Refactor __do_hyp_init to accept its parameters in a struct. This
> prepares the code for KVM booting cores as well as removes any limits 
> on
> the number of __do_hyp_init arguments.
> 
> Signed-off-by: David Brazdil <dbrazdil@google.com>
> ---
>  arch/arm64/include/asm/kvm_asm.h   |  7 +++++++
>  arch/arm64/include/asm/kvm_hyp.h   |  4 ++++
>  arch/arm64/kernel/asm-offsets.c    |  4 ++++
>  arch/arm64/kvm/arm.c               | 26 ++++++++++++++------------
>  arch/arm64/kvm/hyp/nvhe/hyp-init.S | 21 ++++++++++-----------
>  arch/arm64/kvm/hyp/nvhe/hyp-main.c |  2 ++
>  6 files changed, 41 insertions(+), 23 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/kvm_asm.h 
> b/arch/arm64/include/asm/kvm_asm.h
> index 54387ccd1ab2..a49a87a186c3 100644
> --- a/arch/arm64/include/asm/kvm_asm.h
> +++ b/arch/arm64/include/asm/kvm_asm.h
> @@ -150,6 +150,13 @@ extern void *__vhe_undefined_symbol;
> 
>  #endif
> 
> +struct kvm_nvhe_init_params {
> +	phys_addr_t pgd_ptr;
> +	unsigned long tpidr_el2;
> +	unsigned long hyp_stack_ptr;
> +	unsigned long vector_ptr;
> +};

Please add some documentation here, specially indicating what address 
space
the values are relative to.

> +
>  /* Translate a kernel address @ptr into its equivalent linear mapping 
> */
>  #define kvm_ksym_ref(ptr)						\
>  	({								\
> diff --git a/arch/arm64/include/asm/kvm_hyp.h 
> b/arch/arm64/include/asm/kvm_hyp.h
> index 6b664de5ec1f..a3289071f3d8 100644
> --- a/arch/arm64/include/asm/kvm_hyp.h
> +++ b/arch/arm64/include/asm/kvm_hyp.h
> @@ -15,6 +15,10 @@
>  DECLARE_PER_CPU(struct kvm_cpu_context, kvm_hyp_ctxt);
>  DECLARE_PER_CPU(unsigned long, kvm_hyp_vector);
> 
> +#ifdef __KVM_NVHE_HYPERVISOR__
> +DECLARE_PER_CPU(struct kvm_nvhe_init_params, kvm_init_params);
> +#endif
> +
>  #define read_sysreg_elx(r,nvh,vh)					\
>  	({								\
>  		u64 reg;						\
> diff --git a/arch/arm64/kernel/asm-offsets.c 
> b/arch/arm64/kernel/asm-offsets.c
> index 7d32fc959b1a..0cbb86135c7c 100644
> --- a/arch/arm64/kernel/asm-offsets.c
> +++ b/arch/arm64/kernel/asm-offsets.c
> @@ -110,6 +110,10 @@ int main(void)
>    DEFINE(CPU_APGAKEYLO_EL1,	offsetof(struct kvm_cpu_context,
> sys_regs[APGAKEYLO_EL1]));
>    DEFINE(HOST_CONTEXT_VCPU,	offsetof(struct kvm_cpu_context,
> __hyp_running_vcpu));
>    DEFINE(HOST_DATA_CONTEXT,	offsetof(struct kvm_host_data, 
> host_ctxt));
> +  DEFINE(NVHE_INIT_PGD_PTR,	offsetof(struct kvm_nvhe_init_params, 
> pgd_ptr));
> +  DEFINE(NVHE_INIT_TPIDR_EL2,	offsetof(struct kvm_nvhe_init_params,
> tpidr_el2));
> +  DEFINE(NVHE_INIT_STACK_PTR,	offsetof(struct kvm_nvhe_init_params,
> hyp_stack_ptr));
> +  DEFINE(NVHE_INIT_VECTOR_PTR,	offsetof(struct kvm_nvhe_init_params,
> vector_ptr));
>  #endif
>  #ifdef CONFIG_CPU_PM
>    DEFINE(CPU_CTX_SP,		offsetof(struct cpu_suspend_ctx, sp));
> diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
> index b85b4294b72d..1a57b6025937 100644
> --- a/arch/arm64/kvm/arm.c
> +++ b/arch/arm64/kvm/arm.c
> @@ -50,6 +50,7 @@ DECLARE_KVM_HYP_PER_CPU(unsigned long, 
> kvm_hyp_vector);
> 
>  static DEFINE_PER_CPU(unsigned long, kvm_arm_hyp_stack_page);
>  unsigned long kvm_arm_hyp_percpu_base[NR_CPUS];
> +DECLARE_KVM_NVHE_PER_CPU(struct kvm_nvhe_init_params, 
> kvm_init_params);
> 
>  /* The VMID used in the VTTBR */
>  static atomic64_t kvm_vmid_gen = ATOMIC64_INIT(1);
> @@ -1331,10 +1332,7 @@ static int kvm_map_vectors(void)
> 
>  static void cpu_init_hyp_mode(void)
>  {
> -	phys_addr_t pgd_ptr;
> -	unsigned long hyp_stack_ptr;
> -	unsigned long vector_ptr;
> -	unsigned long tpidr_el2;
> +	struct kvm_nvhe_init_params *params = 
> this_cpu_ptr_nvhe_sym(kvm_init_params);
>  	struct arm_smccc_res res;
> 
>  	/* Switch from the HYP stub to our own HYP init vector */
> @@ -1345,13 +1343,18 @@ static void cpu_init_hyp_mode(void)
>  	 * kernel's mapping to the linear mapping, and store it in tpidr_el2
>  	 * so that we can use adr_l to access per-cpu variables in EL2.
>  	 */
> -	tpidr_el2 = (unsigned long)this_cpu_ptr_nvhe_sym(__per_cpu_start) -
> -		    (unsigned long)kvm_ksym_ref(CHOOSE_NVHE_SYM(__per_cpu_start));
> +	params->tpidr_el2 = (unsigned 
> long)this_cpu_ptr_nvhe_sym(__per_cpu_start) -
> +			    (unsigned long)kvm_ksym_ref(CHOOSE_NVHE_SYM(__per_cpu_start));
> 
> -	pgd_ptr = kvm_mmu_get_httbr();
> -	hyp_stack_ptr = __this_cpu_read(kvm_arm_hyp_stack_page) + PAGE_SIZE;
> -	hyp_stack_ptr = kern_hyp_va(hyp_stack_ptr);
> -	vector_ptr = (unsigned 
> long)kern_hyp_va(kvm_ksym_ref(__kvm_hyp_host_vector));
> +	params->pgd_ptr = kvm_mmu_get_httbr();
> +	params->vector_ptr = (unsigned
> long)kern_hyp_va(kvm_ksym_ref(__kvm_hyp_host_vector));
> +	params->hyp_stack_ptr =
> kern_hyp_va(__this_cpu_read(kvm_arm_hyp_stack_page) + PAGE_SIZE);
> +
> +	/*
> +	 * Flush the init params from the data cache because the struct will
> +	 * be read from while the MMU is off.

s/from while/while/ ?

> +	 */
> +	__flush_dcache_area(params, sizeof(*params));
> 
>  	/*
>  	 * Call initialization code, and switch to the full blown HYP code.
> @@ -1360,8 +1363,7 @@ static void cpu_init_hyp_mode(void)
>  	 * cpus_have_const_cap() wrapper.
>  	 */
>  	BUG_ON(!system_capabilities_finalized());
> -	arm_smccc_1_1_hvc(KVM_HOST_SMCCC_FUNC(__kvm_hyp_init),
> -			  pgd_ptr, tpidr_el2, hyp_stack_ptr, vector_ptr, &res);
> +	arm_smccc_1_1_hvc(KVM_HOST_SMCCC_FUNC(__kvm_hyp_init),
> virt_to_phys(params), &res);
>  	WARN_ON(res.a0 != SMCCC_RET_SUCCESS);
> 
>  	/*
> diff --git a/arch/arm64/kvm/hyp/nvhe/hyp-init.S
> b/arch/arm64/kvm/hyp/nvhe/hyp-init.S
> index 96e70f976ff5..6f3ac5d428ec 100644
> --- a/arch/arm64/kvm/hyp/nvhe/hyp-init.S
> +++ b/arch/arm64/kvm/hyp/nvhe/hyp-init.S
> @@ -47,10 +47,7 @@ __invalid:
> 
>  	/*
>  	 * x0: SMCCC function ID
> -	 * x1: HYP pgd
> -	 * x2: per-CPU offset
> -	 * x3: HYP stack
> -	 * x4: HYP vectors
> +	 * x1: struct kvm_nvhe_init_params PA
>  	 */
>  __do_hyp_init:
>  	/* Check for a stub HVC call */
> @@ -71,10 +68,16 @@ __do_hyp_init:
>  	mov	x0, #SMCCC_RET_NOT_SUPPORTED
>  	eret
> 
> -1:
> -	/* Set tpidr_el2 for use by HYP to free a register */
> -	msr	tpidr_el2, x2
> +1:	ldr	x0, [x1, #NVHE_INIT_TPIDR_EL2]
> +	msr	tpidr_el2, x0
> 
> +	ldr	x0, [x1, #NVHE_INIT_STACK_PTR]
> +	mov	sp, x0
> +
> +	ldr	x0, [x1, #NVHE_INIT_VECTOR_PTR]
> +	msr	vbar_el2, x0
> +
> +	ldr	x1, [x1, #NVHE_INIT_PGD_PTR]
>  	phys_to_ttbr x0, x1
>  alternative_if ARM64_HAS_CNP
>  	orr	x0, x0, #TTBR_CNP_BIT
> @@ -134,10 +137,6 @@ alternative_else_nop_endif
>  	msr	sctlr_el2, x0
>  	isb
> 
> -	/* Set the stack and new vectors */
> -	mov	sp, x3
> -	msr	vbar_el2, x4
> -
>  	/* Hello, World! */
>  	mov	x0, #SMCCC_RET_SUCCESS
>  	eret
> diff --git a/arch/arm64/kvm/hyp/nvhe/hyp-main.c
> b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
> index e2eafe2c93af..411b0f652417 100644
> --- a/arch/arm64/kvm/hyp/nvhe/hyp-main.c
> +++ b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
> @@ -14,6 +14,8 @@
> 
>  #include <kvm/arm_hypercalls.h>
> 
> +DEFINE_PER_CPU(struct kvm_nvhe_init_params, kvm_init_params);
> +
>  static void handle_host_hcall(unsigned long func_id,
>  			      struct kvm_cpu_context *host_ctxt)
>  {

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
