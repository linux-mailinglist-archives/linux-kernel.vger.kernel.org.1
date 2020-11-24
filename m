Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EF572C290D
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 15:10:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388078AbgKXOJM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 09:09:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:48792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727123AbgKXOJM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 09:09:12 -0500
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 642C52083E
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 14:09:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606226951;
        bh=xognvjsytGj3akJ5LEQ71E+KBAhbOlqmPPB8px69Qp0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=XtDdcDt3433O/UKIhEsFWGlwSsfAmOFPSWJ/CfXRQlwHQyD8QY5LDGcFDCWh6yI//
         opFvkJ4NaSKNE+XaOQFevNvdx9anLQPzZhGNbx7aYgzTzzN9fwBF9nJ4JkGyvy/ywa
         pUerazLkjbstIcnO0f7nCFlEtekdKgLvAYkYB43s=
Received: by mail-ot1-f53.google.com with SMTP id g19so19400713otp.13
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 06:09:11 -0800 (PST)
X-Gm-Message-State: AOAM5303IsTo6Z91gSmCWtdlcHRVmREPlAH70B5hRhTMwDurQ437WXGr
        pl5DoDOUSoS7bdz4qjz9H4+yGnkO6DHtpRG36qs=
X-Google-Smtp-Source: ABdhPJxP9c5r3xRR6eKId2+eDoJlAYjem8Qv3lNy8uEeC9FGwM2kxRA23AIDh6vAm0s0dGArxN0nZ3qovNeDMfX/qLI=
X-Received: by 2002:a9d:62c1:: with SMTP id z1mr3391150otk.108.1606226950606;
 Tue, 24 Nov 2020 06:09:10 -0800 (PST)
MIME-Version: 1.0
References: <20201119162543.78001-1-dbrazdil@google.com> <20201119162543.78001-7-dbrazdil@google.com>
In-Reply-To: <20201119162543.78001-7-dbrazdil@google.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 24 Nov 2020 15:08:59 +0100
X-Gmail-Original-Message-ID: <CAMj1kXH8sPjU2C7E++J+yP8FnfWbgEVGtj4i-XXqOF7DGxiaOw@mail.gmail.com>
Message-ID: <CAMj1kXH8sPjU2C7E++J+yP8FnfWbgEVGtj4i-XXqOF7DGxiaOw@mail.gmail.com>
Subject: Re: [RFC PATCH 6/6] kvm: arm64: Remove hyp_symbol_addr
To:     David Brazdil <dbrazdil@google.com>
Cc:     kvmarm <kvmarm@lists.cs.columbia.edu>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Scull <ascull@google.com>,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Nov 2020 at 17:26, David Brazdil <dbrazdil@google.com> wrote:
>
> The helper was used to force PC-relative addressing in hyp code because
> absolute addressing via constant-pools used to generate kernel VAs. This
> was cumbersome and required programmers to remember to use the helper
> whenever they wanted to take a pointer.
>
> Now that hyp relocations are fixed up, there is no need for the helper
> any logner. Remove it.
>
> Signed-off-by: David Brazdil <dbrazdil@google.com>

Acked-by: Ard Biesheuvel <ardb@kernel.org>

> ---
>  arch/arm64/include/asm/kvm_asm.h         | 20 --------------------
>  arch/arm64/kvm/hyp/include/hyp/switch.h  |  4 ++--
>  arch/arm64/kvm/hyp/nvhe/hyp-smp.c        |  4 ++--
>  arch/arm64/kvm/hyp/nvhe/psci-relay.c     |  4 ++--
>  arch/arm64/kvm/hyp/vgic-v2-cpuif-proxy.c |  2 +-
>  5 files changed, 7 insertions(+), 27 deletions(-)
>
> diff --git a/arch/arm64/include/asm/kvm_asm.h b/arch/arm64/include/asm/kvm_asm.h
> index 1a86581e581e..1961d23c0c40 100644
> --- a/arch/arm64/include/asm/kvm_asm.h
> +++ b/arch/arm64/include/asm/kvm_asm.h
> @@ -203,26 +203,6 @@ extern void __vgic_v3_init_lrs(void);
>
>  extern u32 __kvm_get_mdcr_el2(void);
>
> -/*
> - * Obtain the PC-relative address of a kernel symbol
> - * s: symbol
> - *
> - * The goal of this macro is to return a symbol's address based on a
> - * PC-relative computation, as opposed to a loading the VA from a
> - * constant pool or something similar. This works well for HYP, as an
> - * absolute VA is guaranteed to be wrong. Only use this if trying to
> - * obtain the address of a symbol (i.e. not something you obtained by
> - * following a pointer).
> - */
> -#define hyp_symbol_addr(s)                                             \
> -       ({                                                              \
> -               typeof(s) *addr;                                        \
> -               asm("adrp       %0, %1\n"                               \
> -                   "add        %0, %0, :lo12:%1\n"                     \
> -                   : "=r" (addr) : "S" (&s));                          \
> -               addr;                                                   \
> -       })
> -
>  #define __KVM_EXTABLE(from, to)                                                \
>         "       .pushsection    __kvm_ex_table, \"a\"\n"                \
>         "       .align          3\n"                                    \
> diff --git a/arch/arm64/kvm/hyp/include/hyp/switch.h b/arch/arm64/kvm/hyp/include/hyp/switch.h
> index 84473574c2e7..54f4860cd87c 100644
> --- a/arch/arm64/kvm/hyp/include/hyp/switch.h
> +++ b/arch/arm64/kvm/hyp/include/hyp/switch.h
> @@ -505,8 +505,8 @@ static inline void __kvm_unexpected_el2_exception(void)
>         struct exception_table_entry *entry, *end;
>         unsigned long elr_el2 = read_sysreg(elr_el2);
>
> -       entry = hyp_symbol_addr(__start___kvm_ex_table);
> -       end = hyp_symbol_addr(__stop___kvm_ex_table);
> +       entry = &__start___kvm_ex_table;
> +       end = &__stop___kvm_ex_table;
>
>         while (entry < end) {
>                 addr = (unsigned long)&entry->insn + entry->insn;
> diff --git a/arch/arm64/kvm/hyp/nvhe/hyp-smp.c b/arch/arm64/kvm/hyp/nvhe/hyp-smp.c
> index ceb427aabb91..6870d9f3d4b7 100644
> --- a/arch/arm64/kvm/hyp/nvhe/hyp-smp.c
> +++ b/arch/arm64/kvm/hyp/nvhe/hyp-smp.c
> @@ -33,8 +33,8 @@ unsigned long __hyp_per_cpu_offset(unsigned int cpu)
>         if (cpu >= ARRAY_SIZE(kvm_arm_hyp_percpu_base))
>                 hyp_panic();
>
> -       cpu_base_array = (unsigned long*)hyp_symbol_addr(kvm_arm_hyp_percpu_base);
> +       cpu_base_array = (unsigned long*)(&kvm_arm_hyp_percpu_base[0]);
>         this_cpu_base = kern_hyp_va(cpu_base_array[cpu]);
> -       elf_base = (unsigned long)hyp_symbol_addr(__per_cpu_start);
> +       elf_base = (unsigned long)&__per_cpu_start;
>         return this_cpu_base - elf_base;
>  }
> diff --git a/arch/arm64/kvm/hyp/nvhe/psci-relay.c b/arch/arm64/kvm/hyp/nvhe/psci-relay.c
> index 313ef42f0eab..f64380a49a72 100644
> --- a/arch/arm64/kvm/hyp/nvhe/psci-relay.c
> +++ b/arch/arm64/kvm/hyp/nvhe/psci-relay.c
> @@ -147,7 +147,7 @@ static int psci_cpu_suspend(u64 func_id, struct kvm_cpu_context *host_ctxt)
>          * point if it is a deep sleep state.
>          */
>         ret = psci_call(func_id, power_state,
> -                       __hyp_pa(hyp_symbol_addr(__kvm_hyp_cpu_entry)),
> +                       __hyp_pa(__kvm_hyp_cpu_entry),
>                         __hyp_pa(cpu_params));
>
>         release_reset_state(cpu_state);
> @@ -182,7 +182,7 @@ static int psci_cpu_on(u64 func_id, struct kvm_cpu_context *host_ctxt)
>                 return PSCI_RET_ALREADY_ON;
>
>         ret = psci_call(func_id, mpidr,
> -                       __hyp_pa(hyp_symbol_addr(__kvm_hyp_cpu_entry)),
> +                       __hyp_pa(__kvm_hyp_cpu_entry),
>                         __hyp_pa(cpu_params));
>
>         /*
> diff --git a/arch/arm64/kvm/hyp/vgic-v2-cpuif-proxy.c b/arch/arm64/kvm/hyp/vgic-v2-cpuif-proxy.c
> index 8f0585640241..87a54375bd6e 100644
> --- a/arch/arm64/kvm/hyp/vgic-v2-cpuif-proxy.c
> +++ b/arch/arm64/kvm/hyp/vgic-v2-cpuif-proxy.c
> @@ -64,7 +64,7 @@ int __vgic_v2_perform_cpuif_access(struct kvm_vcpu *vcpu)
>         }
>
>         rd = kvm_vcpu_dabt_get_rd(vcpu);
> -       addr  = hyp_symbol_addr(kvm_vgic_global_state)->vcpu_hyp_va;
> +       addr  = kvm_vgic_global_state.vcpu_hyp_va;
>         addr += fault_ipa - vgic->vgic_cpu_base;
>
>         if (kvm_vcpu_dabt_iswrite(vcpu)) {
> --
> 2.29.2.299.gdc1121823c-goog
>
