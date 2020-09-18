Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D7DA26FBE5
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 13:58:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726556AbgIRL62 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 07:58:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:38070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726130AbgIRL62 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 07:58:28 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A7EED2100A;
        Fri, 18 Sep 2020 11:58:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600430307;
        bh=TpvsNRIT0A6VtxEhgI5MhD7WAEWs8qrYhkK4T++wnP4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MweCyFFMa++URq9mDUFNihVj7Vn8UJNHq5rPnvhtRln3QswuX+9z3bnLYnb+Eu7G3
         P7o0kuxSCd1yg1lH5h/+yoJ6ZaBNrRdX3F9VZlxFN3F9u66hEsWGGf8f9nbu0AdDFy
         Nr7yApqARdgFx0m+TO+rpa325DWaKqY/RU5ZE64E=
Date:   Fri, 18 Sep 2020 12:58:22 +0100
From:   Will Deacon <will@kernel.org>
To:     David Brazdil <dbrazdil@google.com>
Cc:     kvmarm@lists.cs.columbia.edu,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [PATCH v3 08/11] kvm: arm64: Create separate instances of
 kvm_host_data for VHE/nVHE
Message-ID: <20200918115821.GA31096@willie-the-truck>
References: <20200916173439.32265-1-dbrazdil@google.com>
 <20200916173439.32265-9-dbrazdil@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200916173439.32265-9-dbrazdil@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 16, 2020 at 06:34:36PM +0100, David Brazdil wrote:
> Host CPU context is stored in a global per-cpu variable `kvm_host_data`.
> In preparation for introducing independent per-CPU region for nVHE hyp,
> create two separate instances of `kvm_host_data`, one for VHE and one
> for nVHE.
> 
> Signed-off-by: David Brazdil <dbrazdil@google.com>
> ---
>  arch/arm64/include/asm/kvm_host.h | 2 +-
>  arch/arm64/kernel/image-vars.h    | 1 -
>  arch/arm64/kvm/arm.c              | 5 ++---
>  arch/arm64/kvm/hyp/nvhe/switch.c  | 3 +++
>  arch/arm64/kvm/hyp/vhe/switch.c   | 3 +++
>  arch/arm64/kvm/pmu.c              | 8 ++++----
>  6 files changed, 13 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
> index 905c2b87e05a..5d8c63f5e97e 100644
> --- a/arch/arm64/include/asm/kvm_host.h
> +++ b/arch/arm64/include/asm/kvm_host.h
> @@ -565,7 +565,7 @@ void kvm_set_sei_esr(struct kvm_vcpu *vcpu, u64 syndrome);
>  
>  struct kvm_vcpu *kvm_mpidr_to_vcpu(struct kvm *kvm, unsigned long mpidr);
>  
> -DECLARE_PER_CPU(kvm_host_data_t, kvm_host_data);
> +DECLARE_KVM_HYP_PER_CPU(kvm_host_data_t, kvm_host_data);
>  
>  static inline void kvm_init_host_cpu_context(struct kvm_cpu_context *cpu_ctxt)
>  {
> diff --git a/arch/arm64/kernel/image-vars.h b/arch/arm64/kernel/image-vars.h
> index 59d12a0b4622..80da861b8180 100644
> --- a/arch/arm64/kernel/image-vars.h
> +++ b/arch/arm64/kernel/image-vars.h
> @@ -67,7 +67,6 @@ KVM_NVHE_ALIAS(kvm_patch_vector_branch);
>  KVM_NVHE_ALIAS(kvm_update_va_mask);
>  
>  /* Global kernel state accessed by nVHE hyp code. */
> -KVM_NVHE_ALIAS(kvm_host_data);
>  KVM_NVHE_ALIAS(kvm_vgic_global_state);
>  
>  /* Kernel constant needed to compute idmap addresses. */
> diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
> index 3bdc2661d276..7af9809fa193 100644
> --- a/arch/arm64/kvm/arm.c
> +++ b/arch/arm64/kvm/arm.c
> @@ -46,7 +46,6 @@
>  __asm__(".arch_extension	virt");
>  #endif
>  
> -DEFINE_PER_CPU(kvm_host_data_t, kvm_host_data);
>  static DEFINE_PER_CPU(unsigned long, kvm_arm_hyp_stack_page);
>  
>  /* The VMID used in the VTTBR */
> @@ -1308,7 +1307,7 @@ static void cpu_hyp_reset(void)
>  
>  static void cpu_hyp_reinit(void)
>  {
> -	kvm_init_host_cpu_context(&this_cpu_ptr(&kvm_host_data)->host_ctxt);
> +	kvm_init_host_cpu_context(&this_cpu_ptr_hyp(kvm_host_data)->host_ctxt);
>  
>  	cpu_hyp_reset();
>  
> @@ -1543,7 +1542,7 @@ static int init_hyp_mode(void)
>  	for_each_possible_cpu(cpu) {
>  		kvm_host_data_t *cpu_data;
>  
> -		cpu_data = per_cpu_ptr(&kvm_host_data, cpu);
> +		cpu_data = per_cpu_ptr_hyp(kvm_host_data, cpu);

I stand by my earlier comment to add _sym here, given that the ampersand
gets dropped from the argument.

So assuming you do that in the earlier patch:

Acked-by: Will Deacon <will@kernel.org>

Will
