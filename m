Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD17C2C6AD7
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 18:48:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732457AbgK0Rrf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 12:47:35 -0500
Received: from foss.arm.com ([217.140.110.172]:47578 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731834AbgK0Rre (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 12:47:34 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 33FAD31B;
        Fri, 27 Nov 2020 09:47:33 -0800 (PST)
Received: from bogus (unknown [10.57.59.53])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4F5AA3F71F;
        Fri, 27 Nov 2020 09:47:30 -0800 (PST)
Date:   Fri, 27 Nov 2020 17:47:26 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     David Brazdil <dbrazdil@google.com>
Cc:     kvmarm@lists.cs.columbia.edu, Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel-team@android.com
Subject: Re: [PATCH v3 19/23] kvm: arm64: Intercept host's CPU_ON SMCs
Message-ID: <20201127174726.4b6azdyzn5j6qmao@bogus>
References: <20201126155421.14901-1-dbrazdil@google.com>
 <20201126155421.14901-20-dbrazdil@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201126155421.14901-20-dbrazdil@google.com>
User-Agent: NeoMutt/20171215
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 26, 2020 at 03:54:17PM +0000, David Brazdil wrote:
> Add a handler of the CPU_ON PSCI call from host. When invoked, it looks
> up the logical CPU ID corresponding to the provided MPIDR and populates
> the state struct of the target CPU with the provided x0, pc. It then
> calls CPU_ON itself, with an entry point in hyp that initializes EL2
> state before returning ERET to the provided PC in EL1.
> 
> There is a simple atomic lock around the boot args struct. If it is
> already locked, CPU_ON will return PENDING_ON error code.
> 
> Signed-off-by: David Brazdil <dbrazdil@google.com>
> ---
>  arch/arm64/kvm/hyp/nvhe/hyp-init.S   |  30 ++++++++
>  arch/arm64/kvm/hyp/nvhe/psci-relay.c | 109 +++++++++++++++++++++++++++
>  2 files changed, 139 insertions(+)
> 
> diff --git a/arch/arm64/kvm/hyp/nvhe/hyp-init.S b/arch/arm64/kvm/hyp/nvhe/hyp-init.S
> index 98ce40e17b42..ea71f653af55 100644
> --- a/arch/arm64/kvm/hyp/nvhe/hyp-init.S
> +++ b/arch/arm64/kvm/hyp/nvhe/hyp-init.S
> @@ -9,6 +9,7 @@
>  
>  #include <asm/alternative.h>
>  #include <asm/assembler.h>
> +#include <asm/el2_setup.h>
>  #include <asm/kvm_arm.h>
>  #include <asm/kvm_asm.h>
>  #include <asm/kvm_mmu.h>
> @@ -161,6 +162,35 @@ alternative_else_nop_endif
>  	ret
>  SYM_CODE_END(___kvm_hyp_init)
>  
> +SYM_CODE_START(__kvm_hyp_cpu_on_entry)
> +	msr	SPsel, #1			// We want to use SP_EL{1,2}
> +
> +	/* Check that the core was booted in EL2. */
> +	mrs	x1, CurrentEL
> +	cmp	x1, #CurrentEL_EL2
> +	b.eq	2f
> +
> +	/* The core booted in EL1. KVM cannot be initialized on it. */
> +1:	wfe
> +	wfi
> +	b	1b
> +
> +	/* Initialize EL2 CPU state to sane values. */
> +2:	mov	x29, x0
> +	init_el2_state nvhe
> +	mov	x0, x29
> +
> +	/* Enable MMU, set vectors and stack. */
> +	bl	___kvm_hyp_init
> +
> +	/* Load address of the C handler. */
> +	ldr	x1, =__kvm_hyp_psci_cpu_entry
> +	kimg_hyp_va x1, x2
> +
> +	/* Leave idmap. */
> +	br	x1
> +SYM_CODE_END(__kvm_hyp_cpu_on_entry)
> +
>  SYM_CODE_START(__kvm_handle_stub_hvc)
>  	cmp	x0, #HVC_SOFT_RESTART
>  	b.ne	1f
> diff --git a/arch/arm64/kvm/hyp/nvhe/psci-relay.c b/arch/arm64/kvm/hyp/nvhe/psci-relay.c
> index 7aa87ab7f5ce..39e507672e6e 100644
> --- a/arch/arm64/kvm/hyp/nvhe/psci-relay.c
> +++ b/arch/arm64/kvm/hyp/nvhe/psci-relay.c
> @@ -9,12 +9,17 @@
>  #include <asm/kvm_mmu.h>
>  #include <kvm/arm_hypercalls.h>
>  #include <linux/arm-smccc.h>
> +#include <linux/kvm_host.h>
>  #include <linux/psci.h>
>  #include <kvm/arm_psci.h>
>  #include <uapi/linux/psci.h>
>  
>  #include <nvhe/trap_handler.h>
>  
> +extern char __kvm_hyp_cpu_on_entry[];
> +
> +void __noreturn __host_enter(struct kvm_cpu_context *host_ctxt);
> +
>  /* Config options set by the host. */
>  u32 __ro_after_init kvm_host_psci_version;
>  u32 __ro_after_init kvm_host_psci_function_id[PSCI_FN_MAX];
> @@ -22,6 +27,19 @@ s64 __ro_after_init hyp_physvirt_offset;
>  
>  #define __hyp_pa(x) ((phys_addr_t)((x)) + hyp_physvirt_offset)
>  
> +#define INVALID_CPU_ID	UINT_MAX
> +
> +#define CPU_UNLOCKED	0
> +#define CPU_LOCKED	1
> +
> +struct cpu_boot_args {
> +	unsigned long pc;
> +	unsigned long r0;
> +};
> +
> +static DEFINE_PER_CPU(atomic_t, cpu_on_lock) = ATOMIC_INIT(0);
> +static DEFINE_PER_CPU(struct cpu_boot_args, cpu_on_args);
> +
>  static u64 get_psci_func_id(struct kvm_cpu_context *host_ctxt)
>  {
>  	DECLARE_REG(u64, func_id, host_ctxt, 0);
> @@ -78,10 +96,99 @@ static __noreturn unsigned long psci_forward_noreturn(struct kvm_cpu_context *ho
>  	hyp_panic(); /* unreachable */
>  }
>
> +static unsigned int find_cpu_id(u64 mpidr)
> +{
> +	unsigned int i;
> +
> +	/* Reject invalid MPIDRs */
> +	if (mpidr & ~MPIDR_HWID_BITMASK)
> +		return INVALID_CPU_ID;
> +
> +	for (i = 0; i < NR_CPUS; i++) {

I may not have understood the flow correctly, so just asking:
This is just called for secondaries on boot right ? And the cpumasks
are setup by then ? Just trying to see if we can use cpu_possible_mask
instead of running through all 256/1k/4k cpus(ofcourse based on NR_CPUS
config)

--
Regards,
Sudeep
