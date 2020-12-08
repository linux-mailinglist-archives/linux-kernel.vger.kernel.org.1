Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B40CC2D2EDE
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 16:57:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730255AbgLHP5Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 10:57:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:49832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729558AbgLHP5Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 10:57:24 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5FDF823AA9;
        Tue,  8 Dec 2020 15:56:42 +0000 (UTC)
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1kmfM0-00H7fO-1u; Tue, 08 Dec 2020 15:56:40 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 08 Dec 2020 15:56:39 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     David Brazdil <dbrazdil@google.com>
Cc:     kvmarm@lists.cs.columbia.edu, James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [PATCH 1/6] kvm: arm64: Prevent use of invalid PSCI v0.1 function
 IDs
In-Reply-To: <20201208142452.87237-2-dbrazdil@google.com>
References: <20201208142452.87237-1-dbrazdil@google.com>
 <20201208142452.87237-2-dbrazdil@google.com>
User-Agent: Roundcube Webmail/1.4.9
Message-ID: <e3f93946d66c0312a9778e49f1d85abe@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: dbrazdil@google.com, kvmarm@lists.cs.columbia.edu, james.morse@arm.com, julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com, catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-12-08 14:24, David Brazdil wrote:
> PSCI driver exposes a struct containing the PSCI v0.1 function IDs
> configured in the DT. However, the struct does not convey the
> information whether these were set from DT or contain the default value
> zero. This could be a problem for PSCI proxy in KVM protected mode.
> 
> Extend config passed to KVM with a bit mask with individual bits set
> depending on whether the corresponding function pointer in psci_ops is
> set, eg. set bit for PSCI_CPU_SUSPEND if psci_ops.cpu_suspend != NULL.
> 
> Previously config was split into multiple global variables. Put
> everything into a single struct for convenience.
> 
> Reported-by: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: David Brazdil <dbrazdil@google.com>
> ---
>  arch/arm64/include/asm/kvm_host.h    | 20 +++++++++++
>  arch/arm64/kvm/arm.c                 | 14 +++++---
>  arch/arm64/kvm/hyp/nvhe/psci-relay.c | 53 +++++++++++++++++++++-------
>  3 files changed, 70 insertions(+), 17 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/kvm_host.h
> b/arch/arm64/include/asm/kvm_host.h
> index 11beda85ee7e..828d50d40dc2 100644
> --- a/arch/arm64/include/asm/kvm_host.h
> +++ b/arch/arm64/include/asm/kvm_host.h
> @@ -17,6 +17,7 @@
>  #include <linux/jump_label.h>
>  #include <linux/kvm_types.h>
>  #include <linux/percpu.h>
> +#include <linux/psci.h>
>  #include <asm/arch_gicv3.h>
>  #include <asm/barrier.h>
>  #include <asm/cpufeature.h>
> @@ -240,6 +241,25 @@ struct kvm_host_data {
>  	struct kvm_pmu_events pmu_events;
>  };
> 
> +#define KVM_HOST_PSCI_0_1_CPU_SUSPEND	BIT(0)
> +#define KVM_HOST_PSCI_0_1_CPU_ON	BIT(1)
> +#define KVM_HOST_PSCI_0_1_CPU_OFF	BIT(2)
> +#define KVM_HOST_PSCI_0_1_MIGRATE	BIT(3)
> +
> +struct kvm_host_psci_config {
> +	/* PSCI version used by host. */
> +	u32 version;
> +
> +	/* Function IDs used by host if version is v0.1. */
> +	struct psci_0_1_function_ids function_ids_0_1;
> +
> +	/* Bitmask of functions enabled for v0.1, bits KVM_HOST_PSCI_0_1_*. 
> */
> +	unsigned int enabled_functions_0_1;

Nit: the conventional type for bitmaps is 'unsigned long'.
Also, "enabled" seems odd. Isn't it actually "available"?

> +};
> +
> +extern struct kvm_host_psci_config kvm_nvhe_sym(kvm_host_psci_config);
> +#define kvm_host_psci_config CHOOSE_NVHE_SYM(kvm_host_psci_config)
> +
>  struct vcpu_reset_state {
>  	unsigned long	pc;
>  	unsigned long	r0;
> diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
> index 6e637d2b4cfb..6a2f4e01b04f 100644
> --- a/arch/arm64/kvm/arm.c
> +++ b/arch/arm64/kvm/arm.c
> @@ -66,8 +66,6 @@ static DEFINE_PER_CPU(unsigned char,
> kvm_arm_hardware_enabled);
>  DEFINE_STATIC_KEY_FALSE(userspace_irqchip_in_use);
> 
>  extern u64 kvm_nvhe_sym(__cpu_logical_map)[NR_CPUS];
> -extern u32 kvm_nvhe_sym(kvm_host_psci_version);
> -extern struct psci_0_1_function_ids
> kvm_nvhe_sym(kvm_host_psci_0_1_function_ids);
> 
>  int kvm_arch_vcpu_should_kick(struct kvm_vcpu *vcpu)
>  {
> @@ -1618,8 +1616,16 @@ static bool init_psci_relay(void)
>  		return false;
>  	}
> 
> -	kvm_nvhe_sym(kvm_host_psci_version) = psci_ops.get_version();
> -	kvm_nvhe_sym(kvm_host_psci_0_1_function_ids) = 
> get_psci_0_1_function_ids();
> +	kvm_host_psci_config.version = psci_ops.get_version();
> +
> +	if (kvm_host_psci_config.version == PSCI_VERSION(0, 1)) {
> +		kvm_host_psci_config.function_ids_0_1 = get_psci_0_1_function_ids();
> +		kvm_host_psci_config.enabled_functions_0_1 =
> +			(psci_ops.cpu_suspend ? KVM_HOST_PSCI_0_1_CPU_SUSPEND : 0) |
> +			(psci_ops.cpu_off ? KVM_HOST_PSCI_0_1_CPU_OFF : 0) |
> +			(psci_ops.cpu_on ? KVM_HOST_PSCI_0_1_CPU_ON : 0) |
> +			(psci_ops.migrate ? KVM_HOST_PSCI_0_1_MIGRATE : 0);
> +	}
>  	return true;
>  }
> 
> diff --git a/arch/arm64/kvm/hyp/nvhe/psci-relay.c
> b/arch/arm64/kvm/hyp/nvhe/psci-relay.c
> index 08dc9de69314..0d6f4aa39621 100644
> --- a/arch/arm64/kvm/hyp/nvhe/psci-relay.c
> +++ b/arch/arm64/kvm/hyp/nvhe/psci-relay.c
> @@ -22,9 +22,8 @@ void kvm_hyp_cpu_resume(unsigned long r0);
>  void __noreturn __host_enter(struct kvm_cpu_context *host_ctxt);
> 
>  /* Config options set by the host. */
> -__ro_after_init u32 kvm_host_psci_version;
> -__ro_after_init struct psci_0_1_function_ids 
> kvm_host_psci_0_1_function_ids;
> -__ro_after_init s64 hyp_physvirt_offset;
> +struct kvm_host_psci_config __ro_after_init kvm_host_psci_config;
> +s64 __ro_after_init hyp_physvirt_offset;

Unrelated change?

> 
>  #define __hyp_pa(x) ((phys_addr_t)((x)) + hyp_physvirt_offset)
> 
> @@ -54,12 +53,41 @@ static u64 get_psci_func_id(struct kvm_cpu_context
> *host_ctxt)
>  	return func_id;
>  }
> 
> +static inline bool is_psci_0_1_function_enabled(unsigned int fn_bit)

Don't bother with "inline" outside of an include file. It really
doesn't mean much (the compiler is free to ignore it), and it is
likely that the compiler will optimise better without guidance
(not to mention this is hardly a fast path anyway).

> +{
> +	return kvm_host_psci_config.enabled_functions_0_1 & fn_bit;
> +}
> +
> +static inline bool is_psci_0_1_cpu_suspend(u64 func_id)
> +{
> +	return is_psci_0_1_function_enabled(KVM_HOST_PSCI_0_1_CPU_SUSPEND) &&
> +	       (func_id == 
> kvm_host_psci_config.function_ids_0_1.cpu_suspend);
> +}
> +
> +static inline bool is_psci_0_1_cpu_on(u64 func_id)
> +{
> +	return is_psci_0_1_function_enabled(KVM_HOST_PSCI_0_1_CPU_ON) &&
> +	       (func_id == kvm_host_psci_config.function_ids_0_1.cpu_on);
> +}
> +
> +static inline bool is_psci_0_1_cpu_off(u64 func_id)
> +{
> +	return is_psci_0_1_function_enabled(KVM_HOST_PSCI_0_1_CPU_OFF) &&
> +	       (func_id == kvm_host_psci_config.function_ids_0_1.cpu_off);
> +}
> +
> +static inline bool is_psci_0_1_migrate(u64 func_id)
> +{
> +	return is_psci_0_1_function_enabled(KVM_HOST_PSCI_0_1_MIGRATE) &&
> +	       (func_id == kvm_host_psci_config.function_ids_0_1.migrate);
> +}
> +
>  static bool is_psci_0_1_call(u64 func_id)
>  {
> -	return (func_id == kvm_host_psci_0_1_function_ids.cpu_suspend) ||
> -	       (func_id == kvm_host_psci_0_1_function_ids.cpu_on) ||
> -	       (func_id == kvm_host_psci_0_1_function_ids.cpu_off) ||
> -	       (func_id == kvm_host_psci_0_1_function_ids.migrate);
> +	return is_psci_0_1_cpu_suspend(func_id) ||
> +	       is_psci_0_1_cpu_on(func_id) ||
> +	       is_psci_0_1_cpu_off(func_id) ||
> +	       is_psci_0_1_migrate(func_id);
>  }
> 
>  static bool is_psci_0_2_call(u64 func_id)
> @@ -71,7 +99,7 @@ static bool is_psci_0_2_call(u64 func_id)
> 
>  static bool is_psci_call(u64 func_id)
>  {
> -	switch (kvm_host_psci_version) {
> +	switch (kvm_host_psci_config.version) {
>  	case PSCI_VERSION(0, 1):
>  		return is_psci_0_1_call(func_id);
>  	default:
> @@ -248,12 +276,11 @@ asmlinkage void __noreturn
> kvm_host_psci_cpu_entry(bool is_cpu_on)
> 
>  static unsigned long psci_0_1_handler(u64 func_id, struct
> kvm_cpu_context *host_ctxt)
>  {
> -	if ((func_id == kvm_host_psci_0_1_function_ids.cpu_off) ||
> -	    (func_id == kvm_host_psci_0_1_function_ids.migrate))
> +	if (is_psci_0_1_cpu_off(func_id) || is_psci_0_1_migrate(func_id))
>  		return psci_forward(host_ctxt);
> -	else if (func_id == kvm_host_psci_0_1_function_ids.cpu_on)
> +	else if (is_psci_0_1_cpu_on(func_id))
>  		return psci_cpu_on(func_id, host_ctxt);
> -	else if (func_id == kvm_host_psci_0_1_function_ids.cpu_suspend)
> +	else if (is_psci_0_1_cpu_suspend(func_id))
>  		return psci_cpu_suspend(func_id, host_ctxt);
>  	else
>  		return PSCI_RET_NOT_SUPPORTED;
> @@ -304,7 +331,7 @@ bool kvm_host_psci_handler(struct kvm_cpu_context
> *host_ctxt)
>  	if (!is_psci_call(func_id))
>  		return false;
> 
> -	switch (kvm_host_psci_version) {
> +	switch (kvm_host_psci_config.version) {
>  	case PSCI_VERSION(0, 1):
>  		ret = psci_0_1_handler(func_id, host_ctxt);
>  		break;

Otherwise looks OK. Don't bother respinning the series for
my comments, I can tidy things up as I apply it if there
are no other issues.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
