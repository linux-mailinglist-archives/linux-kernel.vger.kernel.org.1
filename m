Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4473329DBAD
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 01:11:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389128AbgJ2ALZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 20:11:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732558AbgJ1Wq4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:46:56 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A25FC0613CF
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 15:46:56 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id c5so747536qtw.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 15:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PZef5tw/nzxfeTNGoZfWo9FnqFR59/C7pLoAJniJg8E=;
        b=j/gMAMTDPuJ0eMWMGMCNvyDXfCghwKtruJ7OuV3QrZmHN6gxGuNo4aMDs9wDnH5vHb
         NrVHD7z3e7sKkQtHVRYu0I/SwgVhD7V48BqVggZ5LwTYAPGN4YZcKu+TxrAU8esbcGJI
         f3/fcfygarJFYfMYSI+/jYwSCqslDMtGRoTigibZb+O2PNeJ54YSaYkSeHLjrWqtBkVz
         H8fQ9dq8ctl7J9XEO44r6zEmlBsNPoo2L63KxXyPG6myRkP/RmHwqYPe32YEuF8HepI6
         aJOf5vyhEETA7F8lSUAqp4Dbf7oAaKXAzlxM3Xdm5GwP8xiXPm+aEsVMVuLs1C9jCjaA
         oTAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PZef5tw/nzxfeTNGoZfWo9FnqFR59/C7pLoAJniJg8E=;
        b=lsTF3/LlfsF+lHEhszCLGiZ7X14evTMtLzDsfIR+JG2NPdfq+6Z2rF/jl5MaH7ykYq
         nlGPq5ZyHyeb7VAyUCCcgmgpXcLy/v638b8aHxPQPp+hPg4gIT0mqK4pH6NAV64zQnLB
         QqR+lc7U9kZ1Buc+7C8b9zuNR+EXnuICZ2xrP8ZIdzcMVwG4XY5uyTNj1WVopOdgYsBH
         TauMMRweM59bgraQVWKeh0actGMddduGKqfRH94k4hUndzWB/tq9DNKomd1U7kt8NfZk
         qqAiYUYGIr5MafgEwfOSH/CUVNtaZ7rQcNsIzI4qPLYxzLLkX0fytDxHpRLDFdp9KnPZ
         /hGA==
X-Gm-Message-State: AOAM5316glvKK0DKNtR/ZnHMbhWx3OT9S4BHATiXzoKe3Fwdhgu3pK5T
        Ig6P0ymkJ94jb/Byw+7skP64Zb/rm8nkL9pG1F1KruFx22YtJg==
X-Google-Smtp-Source: ABdhPJz+XMaWe98mBebdYsOq6qOqEPETaOwzxlSYuxkPvG1joCpr32ftBs045Zz060BC0QaVoci83XejJNon8VyWzJo=
X-Received: by 2002:ac8:44b1:: with SMTP id a17mr6582933qto.43.1603884500705;
 Wed, 28 Oct 2020 04:28:20 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1602535397.git.andreyknvl@google.com> <94dfda607f7f7a28a5df9ee68703922aa9a52a1e.1602535397.git.andreyknvl@google.com>
In-Reply-To: <94dfda607f7f7a28a5df9ee68703922aa9a52a1e.1602535397.git.andreyknvl@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 28 Oct 2020 12:28:09 +0100
Message-ID: <CACT4Y+YhWM0MhS8wVsAmFmpBf4A8yDTLuV-JXtFYr79FJ9GGrQ@mail.gmail.com>
Subject: Re: [PATCH v5 02/40] arm64: mte: Add in-kernel MTE helpers
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Elena Petrova <lenaptr@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 12, 2020 at 10:44 PM Andrey Konovalov <andreyknvl@google.com> wrote:
>
> From: Vincenzo Frascino <vincenzo.frascino@arm.com>
>
> Provide helper functions to manipulate allocation and pointer tags for
> kernel addresses.
>
> Low-level helper functions (mte_assign_*, written in assembly) operate
> tag values from the [0x0, 0xF] range. High-level helper functions
> (mte_get/set_*) use the [0xF0, 0xFF] range to preserve compatibility
> with normal kernel pointers that have 0xFF in their top byte.
>
> MTE_GRANULE_SIZE and related definitions are moved to mte-def.h header
> that doesn't have any dependencies and is safe to include into any
> low-level header.
>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> Co-developed-by: Andrey Konovalov <andreyknvl@google.com>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> ---
> Change-Id: I1b5230254f90dc21a913447cb17f07fea7944ece
> ---
>  arch/arm64/include/asm/esr.h       |  1 +
>  arch/arm64/include/asm/mte-def.h   | 15 ++++++++
>  arch/arm64/include/asm/mte-kasan.h | 56 ++++++++++++++++++++++++++++++
>  arch/arm64/include/asm/mte.h       | 20 +++++++----
>  arch/arm64/kernel/mte.c            | 48 +++++++++++++++++++++++++
>  arch/arm64/lib/mte.S               | 16 +++++++++
>  6 files changed, 150 insertions(+), 6 deletions(-)
>  create mode 100644 arch/arm64/include/asm/mte-def.h
>  create mode 100644 arch/arm64/include/asm/mte-kasan.h
>
> diff --git a/arch/arm64/include/asm/esr.h b/arch/arm64/include/asm/esr.h
> index 035003acfa87..bc0dc66a6a27 100644
> --- a/arch/arm64/include/asm/esr.h
> +++ b/arch/arm64/include/asm/esr.h
> @@ -103,6 +103,7 @@
>  #define ESR_ELx_FSC            (0x3F)
>  #define ESR_ELx_FSC_TYPE       (0x3C)
>  #define ESR_ELx_FSC_EXTABT     (0x10)
> +#define ESR_ELx_FSC_MTE                (0x11)
>  #define ESR_ELx_FSC_SERROR     (0x11)
>  #define ESR_ELx_FSC_ACCESS     (0x08)
>  #define ESR_ELx_FSC_FAULT      (0x04)
> diff --git a/arch/arm64/include/asm/mte-def.h b/arch/arm64/include/asm/mte-def.h
> new file mode 100644
> index 000000000000..8401ac5840c7
> --- /dev/null
> +++ b/arch/arm64/include/asm/mte-def.h
> @@ -0,0 +1,15 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2020 ARM Ltd.
> + */
> +#ifndef __ASM_MTE_DEF_H
> +#define __ASM_MTE_DEF_H
> +
> +#define MTE_GRANULE_SIZE       UL(16)
> +#define MTE_GRANULE_MASK       (~(MTE_GRANULE_SIZE - 1))
> +#define MTE_TAG_SHIFT          56
> +#define MTE_TAG_SIZE           4
> +#define MTE_TAG_MASK           GENMASK((MTE_TAG_SHIFT + (MTE_TAG_SIZE - 1)), MTE_TAG_SHIFT)
> +#define MTE_TAG_MAX            (MTE_TAG_MASK >> MTE_TAG_SHIFT)
> +
> +#endif /* __ASM_MTE_DEF_H  */
> diff --git a/arch/arm64/include/asm/mte-kasan.h b/arch/arm64/include/asm/mte-kasan.h
> new file mode 100644
> index 000000000000..3a70fb1807fd
> --- /dev/null
> +++ b/arch/arm64/include/asm/mte-kasan.h
> @@ -0,0 +1,56 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2020 ARM Ltd.
> + */
> +#ifndef __ASM_MTE_KASAN_H
> +#define __ASM_MTE_KASAN_H
> +
> +#include <asm/mte-def.h>
> +
> +#ifndef __ASSEMBLY__
> +
> +#include <linux/types.h>
> +
> +/*
> + * The functions below are meant to be used only for the
> + * KASAN_HW_TAGS interface defined in asm/memory.h.
> + */
> +#ifdef CONFIG_ARM64_MTE
> +
> +static inline u8 mte_get_ptr_tag(void *ptr)
> +{
> +       /* Note: The format of KASAN tags is 0xF<x> */
> +       u8 tag = 0xF0 | (u8)(((u64)(ptr)) >> MTE_TAG_SHIFT);
> +
> +       return tag;
> +}
> +
> +u8 mte_get_mem_tag(void *addr);
> +u8 mte_get_random_tag(void);
> +void *mte_set_mem_tag_range(void *addr, size_t size, u8 tag);
> +
> +#else /* CONFIG_ARM64_MTE */
> +
> +static inline u8 mte_get_ptr_tag(void *ptr)
> +{
> +       return 0xFF;
> +}
> +
> +static inline u8 mte_get_mem_tag(void *addr)
> +{
> +       return 0xFF;
> +}
> +static inline u8 mte_get_random_tag(void)
> +{
> +       return 0xFF;
> +}
> +static inline void *mte_set_mem_tag_range(void *addr, size_t size, u8 tag)
> +{
> +       return addr;
> +}
> +
> +#endif /* CONFIG_ARM64_MTE */
> +
> +#endif /* __ASSEMBLY__ */
> +
> +#endif /* __ASM_MTE_KASAN_H  */
> diff --git a/arch/arm64/include/asm/mte.h b/arch/arm64/include/asm/mte.h
> index 1c99fcadb58c..cf1cd181dcb2 100644
> --- a/arch/arm64/include/asm/mte.h
> +++ b/arch/arm64/include/asm/mte.h
> @@ -5,14 +5,16 @@
>  #ifndef __ASM_MTE_H
>  #define __ASM_MTE_H
>
> -#define MTE_GRANULE_SIZE       UL(16)
> -#define MTE_GRANULE_MASK       (~(MTE_GRANULE_SIZE - 1))
> -#define MTE_TAG_SHIFT          56
> -#define MTE_TAG_SIZE           4
> +#include <asm/compiler.h>
> +#include <asm/mte-def.h>
> +
> +#define __MTE_PREAMBLE         ARM64_ASM_PREAMBLE ".arch_extension memtag\n"
>
>  #ifndef __ASSEMBLY__
>
> +#include <linux/bitfield.h>
>  #include <linux/page-flags.h>
> +#include <linux/types.h>
>
>  #include <asm/pgtable-types.h>
>
> @@ -45,7 +47,9 @@ long get_mte_ctrl(struct task_struct *task);
>  int mte_ptrace_copy_tags(struct task_struct *child, long request,
>                          unsigned long addr, unsigned long data);
>
> -#else
> +void mte_assign_mem_tag_range(void *addr, size_t size);
> +
> +#else /* CONFIG_ARM64_MTE */
>
>  /* unused if !CONFIG_ARM64_MTE, silence the compiler */
>  #define PG_mte_tagged  0
> @@ -80,7 +84,11 @@ static inline int mte_ptrace_copy_tags(struct task_struct *child,
>         return -EIO;
>  }
>
> -#endif
> +static inline void mte_assign_mem_tag_range(void *addr, size_t size)
> +{
> +}
> +
> +#endif /* CONFIG_ARM64_MTE */
>
>  #endif /* __ASSEMBLY__ */
>  #endif /* __ASM_MTE_H  */
> diff --git a/arch/arm64/kernel/mte.c b/arch/arm64/kernel/mte.c
> index 52a0638ed967..8f99c65837fd 100644
> --- a/arch/arm64/kernel/mte.c
> +++ b/arch/arm64/kernel/mte.c
> @@ -13,10 +13,13 @@
>  #include <linux/swap.h>
>  #include <linux/swapops.h>
>  #include <linux/thread_info.h>
> +#include <linux/types.h>
>  #include <linux/uio.h>
>
> +#include <asm/barrier.h>
>  #include <asm/cpufeature.h>
>  #include <asm/mte.h>
> +#include <asm/mte-kasan.h>
>  #include <asm/ptrace.h>
>  #include <asm/sysreg.h>
>
> @@ -72,6 +75,51 @@ int memcmp_pages(struct page *page1, struct page *page2)
>         return ret;
>  }
>
> +u8 mte_get_mem_tag(void *addr)
> +{
> +       if (!system_supports_mte())
> +               return 0xFF;
> +
> +       asm(__MTE_PREAMBLE "ldg %0, [%0]"
> +           : "+r" (addr));
> +
> +       return mte_get_ptr_tag(addr);
> +}
> +
> +u8 mte_get_random_tag(void)
> +{
> +       void *addr;
> +
> +       if (!system_supports_mte())
> +               return 0xFF;
> +
> +       asm(__MTE_PREAMBLE "irg %0, %0"
> +           : "+r" (addr));
> +
> +       return mte_get_ptr_tag(addr);
> +}
> +
> +void *mte_set_mem_tag_range(void *addr, size_t size, u8 tag)
> +{
> +       void *ptr = addr;
> +
> +       if ((!system_supports_mte()) || (size == 0))
> +               return addr;
> +
> +       /* Make sure that size is MTE granule aligned. */
> +       WARN_ON(size & (MTE_GRANULE_SIZE - 1));
> +
> +       /* Make sure that the address is MTE granule aligned. */
> +       WARN_ON((u64)addr & (MTE_GRANULE_SIZE - 1));
> +
> +       tag = 0xF0 | tag;
> +       ptr = (void *)__tag_set(ptr, tag);
> +
> +       mte_assign_mem_tag_range(ptr, size);

This function will be called on production hot paths. I think it makes
sense to shave off some overheads here.

The additional debug checks may be useful, so maybe we need an
additional debug mode (debug of MTE/KASAN itself)?

Do we ever call this when !system_supports_mte()? I think we wanted to
have static_if's higher up the stack. Having additional checks
scattered across lower-level functions is overhead for every
malloc/free.

Looking at how this is called from KASAN code.
KASAN code already ensures addr/size are properly aligned. I think we
should either remove the duplicate alignment checks, or do them only
in the additional debugging mode.
Does KASAN also ensure proper tag value (0xF0 mask)?

KASAN wrapper is inlined in this patch:
https://linux-review.googlesource.com/c/linux/kernel/git/torvalds/linux/+/3699
but here we still have 2 non-inlined calls. The
mte_assign_mem_tag_range is kinda inherent since it's in .S. But then
I think this wrapper should be inlinable.

Also, can we move mte_assign_mem_tag_range into inline asm in the
header? This would avoid register spills around the call in
malloc/free.

The asm code seems to do the rounding of the size up at no additional
cost (checks remaining size > 0, right?). I think it makes sense to
document that as the contract and remove the additional round_up(size,
KASAN_GRANULE_SIZE) in KASAN code.



> +       return ptr;
> +}
> +
>  static void update_sctlr_el1_tcf0(u64 tcf0)
>  {
>         /* ISB required for the kernel uaccess routines */
> diff --git a/arch/arm64/lib/mte.S b/arch/arm64/lib/mte.S
> index 03ca6d8b8670..ede1ea65428c 100644
> --- a/arch/arm64/lib/mte.S
> +++ b/arch/arm64/lib/mte.S
> @@ -149,3 +149,19 @@ SYM_FUNC_START(mte_restore_page_tags)
>
>         ret
>  SYM_FUNC_END(mte_restore_page_tags)
> +
> +/*
> + * Assign allocation tags for a region of memory based on the pointer tag
> + *   x0 - source pointer
> + *   x1 - size
> + *
> + * Note: The address must be non-NULL and MTE_GRANULE_SIZE aligned and
> + * size must be non-zero and MTE_GRANULE_SIZE aligned.
> + */
> +SYM_FUNC_START(mte_assign_mem_tag_range)
> +1:     stg     x0, [x0]
> +       add     x0, x0, #MTE_GRANULE_SIZE
> +       subs    x1, x1, #MTE_GRANULE_SIZE
> +       b.gt    1b
> +       ret
> +SYM_FUNC_END(mte_assign_mem_tag_range)
> --
> 2.28.0.1011.ga647a8990f-goog
>
