Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEA412C2824
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 14:36:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388386AbgKXNfu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 08:35:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:40178 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725616AbgKXNfu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 08:35:50 -0500
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3C9E720866
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 13:35:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606224949;
        bh=av6mZG1ceIPJ1PjcHIA9oEIcJwL3MRA6RT952RIF28w=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=c/IzzxHNo4IQziRbNPD5QALDAFqNgdMqL1sDFeZKsTStphv4sZn47vf6n15kAT6tf
         +fSTBu+idchdTXllYjG9vB0LcRua+cY1Sf+WhD5AHtCm0rpvHhonyROp8QPzbKCHxQ
         5NcwTBCR83CMpEqQykiUIWZ13LtEFApL+OueGi2g=
Received: by mail-ot1-f51.google.com with SMTP id 11so6783271oty.9
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 05:35:49 -0800 (PST)
X-Gm-Message-State: AOAM531yvC9LgJZlPQKZ3mRfa58FH8NFBlThW7GHXuMh0PpyfZ+USk89
        rEIR8LK4vIY+ec/Shb4Xki0NIndzoFXsm3+J7Pg=
X-Google-Smtp-Source: ABdhPJx33kXMvm+DBUw5BfCj3VTH1jYG9tsjFADMXg3BJktWswRVhFUOrxgJyJAa205vDsgLOP1sCDq+YyxBDD38iCI=
X-Received: by 2002:a05:6830:214c:: with SMTP id r12mr3115803otd.90.1606224948439;
 Tue, 24 Nov 2020 05:35:48 -0800 (PST)
MIME-Version: 1.0
References: <20201119162543.78001-1-dbrazdil@google.com> <20201119162543.78001-2-dbrazdil@google.com>
In-Reply-To: <20201119162543.78001-2-dbrazdil@google.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 24 Nov 2020 14:35:37 +0100
X-Gmail-Original-Message-ID: <CAMj1kXGLy0no6pDU5QmFLjjuwVCt3MbqdetnFU8T4PMfOsy-9Q@mail.gmail.com>
Message-ID: <CAMj1kXGLy0no6pDU5QmFLjjuwVCt3MbqdetnFU8T4PMfOsy-9Q@mail.gmail.com>
Subject: Re: [RFC PATCH 1/6] kvm: arm64: Set up .hyp.rodata ELF section
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

On Thu, 19 Nov 2020 at 17:25, David Brazdil <dbrazdil@google.com> wrote:
>
> We will need to recognize pointers in .rodata specific to hyp,

Why?

> so
> establish a .hyp.rodata ELF section. Merge it with the existing
> .hyp.data..ro_after_init as they are treated the same at runtime.
>

Does this mean HYP .text, .rodata etc are all writable some time after
the kernel .text/.rodata have been mapped read-only? That is not a
problem per se, but it deserves being called out.


> Signed-off-by: David Brazdil <dbrazdil@google.com>
> ---
>  arch/arm64/include/asm/sections.h | 2 +-
>  arch/arm64/kernel/vmlinux.lds.S   | 7 ++++---
>  arch/arm64/kvm/arm.c              | 7 +++----
>  arch/arm64/kvm/hyp/nvhe/hyp.lds.S | 1 +
>  4 files changed, 9 insertions(+), 8 deletions(-)
>
> diff --git a/arch/arm64/include/asm/sections.h b/arch/arm64/include/asm/sections.h
> index 8ff579361731..a6f3557d1ab2 100644
> --- a/arch/arm64/include/asm/sections.h
> +++ b/arch/arm64/include/asm/sections.h
> @@ -11,7 +11,7 @@ extern char __alt_instructions[], __alt_instructions_end[];
>  extern char __hibernate_exit_text_start[], __hibernate_exit_text_end[];
>  extern char __hyp_idmap_text_start[], __hyp_idmap_text_end[];
>  extern char __hyp_text_start[], __hyp_text_end[];
> -extern char __hyp_data_ro_after_init_start[], __hyp_data_ro_after_init_end[];
> +extern char __hyp_rodata_start[], __hyp_rodata_end[];
>  extern char __idmap_text_start[], __idmap_text_end[];
>  extern char __initdata_begin[], __initdata_end[];
>  extern char __inittext_begin[], __inittext_end[];
> diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
> index 4382b5d0645d..6f2fd9734d63 100644
> --- a/arch/arm64/kernel/vmlinux.lds.S
> +++ b/arch/arm64/kernel/vmlinux.lds.S
> @@ -31,10 +31,11 @@ jiffies = jiffies_64;
>         __stop___kvm_ex_table = .;
>
>  #define HYPERVISOR_DATA_SECTIONS                               \
> -       HYP_SECTION_NAME(.data..ro_after_init) : {              \
> -               __hyp_data_ro_after_init_start = .;             \
> +       HYP_SECTION_NAME(.rodata) : {                           \
> +               __hyp_rodata_start = .;                         \
>                 *(HYP_SECTION_NAME(.data..ro_after_init))       \
> -               __hyp_data_ro_after_init_end = .;               \
> +               *(HYP_SECTION_NAME(.rodata))                    \
> +               __hyp_rodata_end = .;                           \
>         }
>
>  #define HYPERVISOR_PERCPU_SECTION                              \
> diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
> index d6d5211653b7..119c97e8900a 100644
> --- a/arch/arm64/kvm/arm.c
> +++ b/arch/arm64/kvm/arm.c
> @@ -1688,11 +1688,10 @@ static int init_hyp_mode(void)
>                 goto out_err;
>         }
>
> -       err = create_hyp_mappings(kvm_ksym_ref(__hyp_data_ro_after_init_start),
> -                                 kvm_ksym_ref(__hyp_data_ro_after_init_end),
> -                                 PAGE_HYP_RO);
> +       err = create_hyp_mappings(kvm_ksym_ref(__hyp_rodata_start),
> +                                 kvm_ksym_ref(__hyp_rodata_end), PAGE_HYP_RO);
>         if (err) {
> -               kvm_err("Cannot map .hyp.data..ro_after_init section\n");
> +               kvm_err("Cannot map .hyp.rodata section\n");
>                 goto out_err;
>         }
>
> diff --git a/arch/arm64/kvm/hyp/nvhe/hyp.lds.S b/arch/arm64/kvm/hyp/nvhe/hyp.lds.S
> index 5d76ff2ba63e..b0789183d49d 100644
> --- a/arch/arm64/kvm/hyp/nvhe/hyp.lds.S
> +++ b/arch/arm64/kvm/hyp/nvhe/hyp.lds.S
> @@ -17,4 +17,5 @@ SECTIONS {
>                 PERCPU_INPUT(L1_CACHE_BYTES)
>         }
>         HYP_SECTION(.data..ro_after_init)
> +       HYP_SECTION(.rodata)
>  }
> --
> 2.29.2.299.gdc1121823c-goog
>
