Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A507927D4EE
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 19:50:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729287AbgI2RuT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 13:50:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:51908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728565AbgI2RuT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 13:50:19 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 58725208B8;
        Tue, 29 Sep 2020 17:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601401818;
        bh=uBLV+tu6o+mROcgLnwH2kdhzX8zXFfZBmHNyNsTufv8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=v3iYD7OpFw8zFjcLyDlK28tE1YugikhyVROqyNQNQXGTtRvbJ5nMFGBGZU4jhQpyD
         QrT9/eGRyiE+wLiMK5xmIbrszrN+BrjVfcIQuG9GTaJx0xdTgZQhPYNgzze8QWXdy5
         S/tgJ5YYrn1TGsSGZEyBNR3kTP/ZyWfI6gf2nYzc=
Date:   Tue, 29 Sep 2020 18:50:13 +0100
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
Subject: Re: [PATCH v4 09/10] kvm: arm64: Set up hyp percpu data for nVHE
Message-ID: <20200929175012.GH14317@willie-the-truck>
References: <20200922204910.7265-1-dbrazdil@google.com>
 <20200922204910.7265-10-dbrazdil@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200922204910.7265-10-dbrazdil@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 22, 2020 at 09:49:09PM +0100, David Brazdil wrote:
> Add hyp percpu section to linker script and rename the corresponding ELF
> sections of hyp/nvhe object files. This moves all nVHE-specific percpu
> variables to the new hyp percpu section.
> 
> Allocate sufficient amount of memory for all percpu hyp regions at global KVM
> init time and create corresponding hyp mappings.
> 
> The base addresses of hyp percpu regions are kept in a dynamically allocated
> array in the kernel.
> 
> Add NULL checks in PMU event-reset code as it may run before KVM memory is
> initialized.
> 
> Signed-off-by: David Brazdil <dbrazdil@google.com>
> ---
>  arch/arm64/include/asm/kvm_asm.h  | 19 +++++++++--
>  arch/arm64/kernel/vmlinux.lds.S   |  8 +++++
>  arch/arm64/kvm/arm.c              | 55 +++++++++++++++++++++++++++++--
>  arch/arm64/kvm/hyp/nvhe/hyp.lds.S |  6 ++++
>  arch/arm64/kvm/pmu.c              |  5 ++-
>  5 files changed, 87 insertions(+), 6 deletions(-)

Acked-by: Will Deacon <will@kernel.org>

But one comment for Marc below...

> diff --git a/arch/arm64/include/asm/kvm_asm.h b/arch/arm64/include/asm/kvm_asm.h
> index 911d91787fa0..863f669d4dc8 100644
> --- a/arch/arm64/include/asm/kvm_asm.h
> +++ b/arch/arm64/include/asm/kvm_asm.h
> @@ -66,8 +66,19 @@
>  #define CHOOSE_VHE_SYM(sym)	sym
>  #define CHOOSE_NVHE_SYM(sym)	kvm_nvhe_sym(sym)
>  
> -#define this_cpu_ptr_nvhe_sym(sym)	this_cpu_ptr(&kvm_nvhe_sym(sym))
> -#define per_cpu_ptr_nvhe_sym(sym, cpu)	per_cpu_ptr(&kvm_nvhe_sym(sym), cpu)
> +/*
> + * Compute pointer to a symbol defined in nVHE percpu region.
> + * Returns NULL if percpu memory has not been allocated yet.
> + */
> +#define this_cpu_ptr_nvhe_sym(sym)	per_cpu_ptr_nvhe_sym(sym, smp_processor_id())
> +#define per_cpu_ptr_nvhe_sym(sym, cpu)						\
> +	({									\
> +		unsigned long base, off;					\
> +		base = kvm_arm_hyp_percpu_base[cpu];				\
> +		off = (unsigned long)&CHOOSE_NVHE_SYM(sym) -			\
> +		      (unsigned long)&CHOOSE_NVHE_SYM(__per_cpu_start);		\
> +		base ? (typeof(CHOOSE_NVHE_SYM(sym))*)(base + off) : NULL;	\
> +	})
>  
>  #ifndef __KVM_NVHE_HYPERVISOR__
>  /*
> @@ -117,6 +128,10 @@ DECLARE_KVM_HYP_SYM(__kvm_hyp_vector);
>  #define __kvm_hyp_init		CHOOSE_NVHE_SYM(__kvm_hyp_init)
>  #define __kvm_hyp_vector	CHOOSE_HYP_SYM(__kvm_hyp_vector)
>  
> +extern unsigned long kvm_arm_hyp_percpu_base[NR_CPUS];
> +DECLARE_KVM_NVHE_SYM(__per_cpu_start);
> +DECLARE_KVM_NVHE_SYM(__per_cpu_end);
> +
>  #ifdef CONFIG_KVM_INDIRECT_VECTORS
>  extern atomic_t arm64_el2_vector_last_slot;
>  DECLARE_KVM_HYP_SYM(__bp_harden_hyp_vecs);

The changes in this file will collide quite badly with Andrew's "handler"
branch which you've already queued, so you'll probably want to chat with
Andrew and David when you get to resolve that. In particular, I think it
would be good if the this_cpu_ptr_nvhe_sym() macro only ends up in the EL1
block, since I don't think that its use of smp_processor_id() is safe at
EL2. That's not a problem as it stands, as its only used by the host.

Will
