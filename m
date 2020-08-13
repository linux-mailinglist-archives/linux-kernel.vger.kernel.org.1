Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16BA52436F6
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Aug 2020 10:55:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726249AbgHMIzR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Aug 2020 04:55:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbgHMIzQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 04:55:16 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80127C061757
        for <linux-kernel@vger.kernel.org>; Thu, 13 Aug 2020 01:55:16 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id g8so4009740wmk.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Aug 2020 01:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JKYiLYK7bURAphGtstRcLZdMB577DXsbKaLESGsrXLQ=;
        b=rbDCoRQkhTNh2AkfUqDQYaSQIV049YTK/6K7NEeRbaYAkewMaelZsPAFKBgCPxLcJi
         Sb61f2o+AxREPTsiSGtrQyWHhM0pWYyibmFZw1eLX84itLQTn/P91+xeGrcQPjTdjpha
         L5edI88QvqmODIHcmfvwtrFOdKkYkUPuxQBxHKQnVP7Vkb+tEX1pqchRGpjvjO6vXatL
         jRYa27sFfBAqBiNmR44b4QxCeL+0Zp9nnlesoKFOv791plAujVCApsN/1iTxK9cMH6sO
         5n9tiOjOLi+KsCvaxzCxq/KGgYjMC2Qsp2wqTLt148Q3LiGK/o5gEvZRvftwM4zBZRwf
         lQuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JKYiLYK7bURAphGtstRcLZdMB577DXsbKaLESGsrXLQ=;
        b=pE9SilyEGzV1wqp2EBN7iMO7k8ucA6cluVCDy7CvAvNE7FHHYZ8Wmd5CXmWKoQoAux
         qOYzhP2fTVO+cFSGzBkbKV8G5lBEIeNkqmkmLrhW33X0QbKe62vt+sILTfGRHT5joPWJ
         uhWK3bweYSjY8jVh2FH5uxY4V0lSfnjjFe9lzbhJ0Zd8K2ISwZTXh+ciJQDoNba8RQ+n
         avpwwNxJy7scF2ju7pW+Rblqnx//cOZPlHmvcsSYdnPFhoRO52CyuPiUF0CpyTYdwvpv
         zwlmfCJBh26RdPdZXZrQx5bUayU4x46qjKDCoMbJnZj/M5aXlBwrQdEcRP0iSttrJgTf
         tFrQ==
X-Gm-Message-State: AOAM532j9AFkYREpS+RBr59GRsFlu2QPKIpLIoDN3+yDG1n0TfWpnPFn
        ddqfRsR+CIoH2cyhUGFHIz0wZpK1Ct7vC+MBKdsnJQ==
X-Google-Smtp-Source: ABdhPJxN5KnUnDP/cDmL4rhsc6+uNbIZmHZJqCKCT1BvEMOaQybj8EP2yzNnHJKNSMOCAJ3sR+wTAGYp+9en0GoVMaU=
X-Received: by 2002:a7b:c4d5:: with SMTP id g21mr3586072wmk.185.1597308915101;
 Thu, 13 Aug 2020 01:55:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200812234758.3563-1-atish.patra@wdc.com> <20200812234758.3563-3-atish.patra@wdc.com>
In-Reply-To: <20200812234758.3563-3-atish.patra@wdc.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Thu, 13 Aug 2020 14:25:02 +0530
Message-ID: <CAAhSdy0PyE3UoS-+7-ei15TgA_qEPAUcutTQ_51DTEjbHdO1YA@mail.gmail.com>
Subject: Re: [PATCH v5 2/9] RISC-V: Add early ioremap support
To:     Atish Patra <atish.patra@wdc.com>
Cc:     "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alistair Francis <alistair.francis@wdc.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anup Patel <anup.patel@wdc.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Borislav Petkov <bp@suse.de>,
        Greentime Hu <greentime.hu@sifive.com>,
        Ingo Molnar <mingo@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        fwts-devel@lists.ubuntu.com, Mao Han <han_mao@c-sky.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Mike Rapoport <rppt@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Steven Price <steven.price@arm.com>,
        Waiman Long <longman@redhat.com>,
        Will Deacon <will@kernel.org>,
        Daniel Schaefer <daniel.schaefer@hpe.com>,
        "abner.chang@hpe.com" <abner.chang@hpe.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 13, 2020 at 5:18 AM Atish Patra <atish.patra@wdc.com> wrote:
>
> UEFI uses early IO or memory mappings for runtime services before
> normal ioremap() is usable. Add the necessary fixmap bindings and
> pmd mappings for generic ioremap support to work.
>
> Signed-off-by: Atish Patra <atish.patra@wdc.com>
> ---
>  arch/riscv/Kconfig              |  1 +
>  arch/riscv/include/asm/Kbuild   |  1 +
>  arch/riscv/include/asm/fixmap.h | 13 +++++++++++++
>  arch/riscv/include/asm/io.h     |  1 +
>  arch/riscv/kernel/setup.c       |  1 +
>  arch/riscv/mm/init.c            | 33 +++++++++++++++++++++++++++++++++
>  6 files changed, 50 insertions(+)
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 7b5905529146..15597f5f504f 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -37,6 +37,7 @@ config RISCV
>         select GENERIC_ARCH_TOPOLOGY if SMP
>         select GENERIC_ATOMIC64 if !64BIT
>         select GENERIC_CLOCKEVENTS
> +       select GENERIC_EARLY_IOREMAP
>         select GENERIC_GETTIMEOFDAY if HAVE_GENERIC_VDSO
>         select GENERIC_IOREMAP
>         select GENERIC_IRQ_MULTI_HANDLER
> diff --git a/arch/riscv/include/asm/Kbuild b/arch/riscv/include/asm/Kbuild
> index 3d9410bb4de0..59dd7be55005 100644
> --- a/arch/riscv/include/asm/Kbuild
> +++ b/arch/riscv/include/asm/Kbuild
> @@ -1,4 +1,5 @@
>  # SPDX-License-Identifier: GPL-2.0
> +generic-y += early_ioremap.h
>  generic-y += extable.h
>  generic-y += flat.h
>  generic-y += kvm_para.h
> diff --git a/arch/riscv/include/asm/fixmap.h b/arch/riscv/include/asm/fixmap.h
> index 11613f38228a..54cbf07fb4e9 100644
> --- a/arch/riscv/include/asm/fixmap.h
> +++ b/arch/riscv/include/asm/fixmap.h
> @@ -27,6 +27,19 @@ enum fixed_addresses {
>         FIX_TEXT_POKE1,
>         FIX_TEXT_POKE0,
>         FIX_EARLYCON_MEM_BASE,
> +
> +       __end_of_permanent_fixed_addresses,
> +       /*
> +        * Temporary boot-time mappings, used by early_ioremap(),
> +        * before ioremap() is functional.
> +        */
> +#define NR_FIX_BTMAPS          (SZ_256K / PAGE_SIZE)
> +#define FIX_BTMAPS_SLOTS       7
> +#define TOTAL_FIX_BTMAPS       (NR_FIX_BTMAPS * FIX_BTMAPS_SLOTS)
> +
> +       FIX_BTMAP_END = __end_of_permanent_fixed_addresses,
> +       FIX_BTMAP_BEGIN = FIX_BTMAP_END + TOTAL_FIX_BTMAPS - 1,
> +
>         __end_of_fixed_addresses
>  };
>
> diff --git a/arch/riscv/include/asm/io.h b/arch/riscv/include/asm/io.h
> index 3835c3295dc5..c025a746a148 100644
> --- a/arch/riscv/include/asm/io.h
> +++ b/arch/riscv/include/asm/io.h
> @@ -14,6 +14,7 @@
>  #include <linux/types.h>
>  #include <linux/pgtable.h>
>  #include <asm/mmiowb.h>
> +#include <asm/early_ioremap.h>
>
>  /*
>   * MMIO access functions are separated out to break dependency cycles
> diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
> index 6a0ee2405813..c71788e6aff4 100644
> --- a/arch/riscv/kernel/setup.c
> +++ b/arch/riscv/kernel/setup.c
> @@ -72,6 +72,7 @@ void __init setup_arch(char **cmdline_p)
>
>         *cmdline_p = boot_command_line;
>
> +       early_ioremap_setup();
>         parse_early_param();
>
>         setup_bootmem();
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index 2b651f63f5c4..b75ebe8e7a92 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -403,6 +403,9 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
>         uintptr_t load_pa = (uintptr_t)(&_start);
>         uintptr_t load_sz = (uintptr_t)(&_end) - load_pa;
>         uintptr_t map_size = best_map_size(load_pa, MAX_EARLY_MAPPING_SIZE);
> +#ifndef __PAGETABLE_PMD_FOLDED
> +       pmd_t fix_bmap_spmd, fix_bmap_epmd;
> +#endif
>
>         va_pa_offset = PAGE_OFFSET - load_pa;
>         pfn_base = PFN_DOWN(load_pa);
> @@ -456,6 +459,36 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
>                            pa + PGDIR_SIZE, PGDIR_SIZE, PAGE_KERNEL);
>         dtb_early_va = (void *)DTB_EARLY_BASE_VA + (dtb_pa & (PGDIR_SIZE - 1));
>         dtb_early_pa = dtb_pa;
> +
> +       /*
> +        * Bootime fixmap only can handle PMD_SIZE mapping. Thus, boot-ioremap
> +        * range can not span multiple pmds.
> +        */
> +       BUILD_BUG_ON((__fix_to_virt(FIX_BTMAP_BEGIN) >> PMD_SHIFT)
> +                    != (__fix_to_virt(FIX_BTMAP_END) >> PMD_SHIFT));
> +
> +#ifndef __PAGETABLE_PMD_FOLDED
> +       /*
> +        * Early ioremap fixmap is already created as it lies within first 2MB
> +        * of fixmap region. We always map PMD_SIZE. Thus, both FIX_BTMAP_END
> +        * FIX_BTMAP_BEGIN should lie in the same pmd. Verify that and warn
> +        * the user if not.
> +        */
> +       fix_bmap_spmd = fixmap_pmd[pmd_index(__fix_to_virt(FIX_BTMAP_BEGIN))];
> +       fix_bmap_epmd = fixmap_pmd[pmd_index(__fix_to_virt(FIX_BTMAP_END))];
> +       if (pmd_val(fix_bmap_spmd) != pmd_val(fix_bmap_epmd)) {
> +               WARN_ON(1);
> +               pr_warn("fixmap btmap start [%08lx] != end [%08lx]\n",
> +                       pmd_val(fix_bmap_spmd), pmd_val(fix_bmap_epmd));
> +               pr_warn("fix_to_virt(FIX_BTMAP_BEGIN): %08lx\n",
> +                       fix_to_virt(FIX_BTMAP_BEGIN));
> +               pr_warn("fix_to_virt(FIX_BTMAP_END):   %08lx\n",
> +                       fix_to_virt(FIX_BTMAP_END));
> +
> +               pr_warn("FIX_BTMAP_END:       %d\n", FIX_BTMAP_END);
> +               pr_warn("FIX_BTMAP_BEGIN:     %d\n", FIX_BTMAP_BEGIN);
> +       }
> +#endif
>  }
>
>  static void __init setup_vm_final(void)
> --
> 2.24.0
>

Looks good to me.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup
