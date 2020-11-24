Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1CFA2C26D5
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 14:10:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387884AbgKXNJZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 08:09:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:60816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387608AbgKXNJY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 08:09:24 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A74B0206D9;
        Tue, 24 Nov 2020 13:09:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606223363;
        bh=ms1OC1jgGP8rsglnaN/qBcxxZ1UrxXPNJn5K7DfbYok=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fm38o4/YbY3u5xAjT/QoQgA1caa9U6lR0nCkzzQekwnHqnxLb/C+Wsv/bS/2UwCZ7
         qdZPbc39etdVCOT6LDni6bEfWfn+MmbwIfEP0HJAQXk4R3u4R9k/az2kg29WITPtcz
         zsyN6M7NYuYMrMY1tzazE5eO3hg/nXE4NvonBgEs=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1khY4P-00DFma-EF; Tue, 24 Nov 2020 13:09:21 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 24 Nov 2020 13:09:21 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     David Brazdil <dbrazdil@google.com>
Cc:     kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Scull <ascull@google.com>,
        Ard Biesheuvel <ardb@kernel.org>, kernel-team@android.com
Subject: Re: [RFC PATCH 2/6] kvm: arm64: Fix up RELA relocations in hyp
 code/data
In-Reply-To: <20201119162543.78001-3-dbrazdil@google.com>
References: <20201119162543.78001-1-dbrazdil@google.com>
 <20201119162543.78001-3-dbrazdil@google.com>
User-Agent: Roundcube Webmail/1.4.9
Message-ID: <ab46f9a28693c10995f9628557bd212e@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: dbrazdil@google.com, kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, james.morse@arm.com, julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com, catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com, ascull@google.com, ardb@kernel.org, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-11-19 16:25, David Brazdil wrote:
> KVM nVHE code runs under a different VA mapping than the kernel, hence
> so far it relied only on PC-relative addressing to avoid accidentally
> using a relocated kernel VA from a constant pool (see hyp_symbol_addr).
> 
> So as to reduce the possibility of a programmer error, fixup the
> relocated addresses instead. Let the kernel relocate them to kernel VA
> first, but then iterate over them again, filter those that point to hyp
> code/data and convert the kernel VA to hyp VA.
> 
> This is done after kvm_compute_layout and before apply_alternatives.
> 
> Signed-off-by: David Brazdil <dbrazdil@google.com>
> ---
>  arch/arm64/include/asm/kvm_mmu.h |  1 +
>  arch/arm64/kernel/smp.c          |  4 +-
>  arch/arm64/kvm/va_layout.c       | 76 ++++++++++++++++++++++++++++++++
>  3 files changed, 80 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/include/asm/kvm_mmu.h 
> b/arch/arm64/include/asm/kvm_mmu.h
> index 5168a0c516ae..e5226f7e4732 100644
> --- a/arch/arm64/include/asm/kvm_mmu.h
> +++ b/arch/arm64/include/asm/kvm_mmu.h
> @@ -105,6 +105,7 @@ alternative_cb_end
>  void kvm_update_va_mask(struct alt_instr *alt,
>  			__le32 *origptr, __le32 *updptr, int nr_inst);
>  void kvm_compute_layout(void);
> +void kvm_fixup_hyp_relocations(void);
> 
>  static __always_inline unsigned long __kern_hyp_va(unsigned long v)
>  {
> diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
> index 18e9727d3f64..30241afc2c93 100644
> --- a/arch/arm64/kernel/smp.c
> +++ b/arch/arm64/kernel/smp.c
> @@ -434,8 +434,10 @@ static void __init hyp_mode_check(void)
>  			   "CPU: CPUs started in inconsistent modes");
>  	else
>  		pr_info("CPU: All CPU(s) started at EL1\n");
> -	if (IS_ENABLED(CONFIG_KVM))
> +	if (IS_ENABLED(CONFIG_KVM)) {
>  		kvm_compute_layout();
> +		kvm_fixup_hyp_relocations();
> +	}
>  }
> 
>  void __init smp_cpus_done(unsigned int max_cpus)
> diff --git a/arch/arm64/kvm/va_layout.c b/arch/arm64/kvm/va_layout.c
> index d8cc51bd60bf..b80fab974896 100644
> --- a/arch/arm64/kvm/va_layout.c
> +++ b/arch/arm64/kvm/va_layout.c
> @@ -10,6 +10,7 @@
>  #include <asm/alternative.h>
>  #include <asm/debug-monitors.h>
>  #include <asm/insn.h>
> +#include <asm/kvm_asm.h>
>  #include <asm/kvm_mmu.h>
>  #include <asm/memory.h>
> 
> @@ -82,6 +83,81 @@ __init void kvm_compute_layout(void)
>  	init_hyp_physvirt_offset();
>  }
> 
> +#define __load_elf_u64(s)					\
> +	({							\
> +		extern u64 s;					\
> +		u64 val;					\
> +								\
> +		asm ("ldr %0, =%1" : "=r"(val) : "S"(&s));	\
> +		val;						\
> +	})

I'm not sure I get the rational about the naming here. None of this
has much to do with ELF, but seems to just load a value from a
constant pool.

> +
> +static bool __is_within_bounds(u64 addr, char *start, char *end)
> +{
> +	return start <= (char*)addr && (char*)addr < end;
> +}
> +
> +static bool __is_in_hyp_section(u64 addr)
> +{
> +	return __is_within_bounds(addr, __hyp_text_start, __hyp_text_end) ||
> +	       __is_within_bounds(addr, __hyp_rodata_start, __hyp_rodata_end) 
> ||
> +	       __is_within_bounds(addr,
> +				  CHOOSE_NVHE_SYM(__per_cpu_start),
> +				  CHOOSE_NVHE_SYM(__per_cpu_end));
> +}
> +
> +static void __fixup_hyp_rel(u64 addr)
> +{
> +	u64 *ptr, kern_va, hyp_va;
> +
> +	/* Adjust the relocation address taken from ELF for KASLR. */
> +	addr += kaslr_offset();
> +
> +	/* Skip addresses not in any of the hyp sections. */
> +	if (!__is_in_hyp_section(addr))
> +		return;
> +
> +	/* Get the LM alias of the relocation address. */
> +	ptr = (u64*)kvm_ksym_ref((void*)addr);

Why the casting? We should be perfectly fine without.

nit: we really need to change the name of this helper, it doesn't have
anything to do with symbols anymore. And actually, lm_alias() *is* the
right thing to use here (we don't relocate anything on VHE).

> +
> +	/*
> +	 * Read the value at the relocation address. It has already been
> +	 * relocated to the actual kernel kimg VA.
> +	 */
> +	kern_va = (u64)kvm_ksym_ref((void*)*ptr);

Same comment.

> +
> +	/* Convert to hyp VA. */
> +	hyp_va = __early_kern_hyp_va(kern_va);
> +
> +	/* Store hyp VA at the relocation address. */
> +	*ptr = __early_kern_hyp_va(kern_va);
> +}
> +
> +static void __fixup_hyp_rela(void)
> +{
> +	Elf64_Rela *rel;
> +	size_t i, n;
> +
> +	rel = (Elf64_Rela*)(kimage_vaddr + __load_elf_u64(__rela_offset));
> +	n = __load_elf_u64(__rela_size) / sizeof(*rel);
> +
> +	for (i = 0; i < n; ++i)
> +		__fixup_hyp_rel(rel[i].r_offset);
> +}
> +
> +/*
> + * The kernel relocated pointers to kernel VA. Iterate over 
> relocations in
> + * the hypervisor ELF sections and convert them to hyp VA. This avoids 
> the
> + * need to only use PC-relative addressing in hyp.
> + */
> +__init void kvm_fixup_hyp_relocations(void)
> +{
> +	if (!IS_ENABLED(CONFIG_RELOCATABLE) || has_vhe())

What do we do if CONFIG_RELOCATABLE is not selected? As far as I can 
tell,
bad things will happen...

I'm also worried that at this stage, the kernel is broken, until you
remove the other bits involved in runtime offsetting pointers.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
