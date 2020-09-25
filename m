Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D756A2784D7
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 12:16:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727668AbgIYKQE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 06:16:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:46410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726990AbgIYKQE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 06:16:04 -0400
Received: from gaia (unknown [31.124.44.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4201620717;
        Fri, 25 Sep 2020 10:16:01 +0000 (UTC)
Date:   Fri, 25 Sep 2020 11:15:58 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        kasan-dev@googlegroups.com,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Elena Petrova <lenaptr@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 24/39] arm64: mte: Add in-kernel MTE helpers
Message-ID: <20200925101558.GB4846@gaia>
References: <cover.1600987622.git.andreyknvl@google.com>
 <ae603463aed82bdff74942f23338a681b8ed8820.1600987622.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ae603463aed82bdff74942f23338a681b8ed8820.1600987622.git.andreyknvl@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 25, 2020 at 12:50:31AM +0200, Andrey Konovalov wrote:
> diff --git a/arch/arm64/include/asm/esr.h b/arch/arm64/include/asm/esr.h
> index 035003acfa87..bc0dc66a6a27 100644
> --- a/arch/arm64/include/asm/esr.h
> +++ b/arch/arm64/include/asm/esr.h
> @@ -103,6 +103,7 @@
>  #define ESR_ELx_FSC		(0x3F)
>  #define ESR_ELx_FSC_TYPE	(0x3C)
>  #define ESR_ELx_FSC_EXTABT	(0x10)
> +#define ESR_ELx_FSC_MTE		(0x11)
>  #define ESR_ELx_FSC_SERROR	(0x11)
>  #define ESR_ELx_FSC_ACCESS	(0x08)
>  #define ESR_ELx_FSC_FAULT	(0x04)
> diff --git a/arch/arm64/include/asm/mte-kasan.h b/arch/arm64/include/asm/mte-kasan.h
> new file mode 100644
> index 000000000000..b0f27de8de33
> --- /dev/null
> +++ b/arch/arm64/include/asm/mte-kasan.h
> @@ -0,0 +1,60 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2020 ARM Ltd.
> + */
> +#ifndef __ASM_MTE_ASM_H
> +#define __ASM_MTE_ASM_H
> +
> +#include <asm/compiler.h>
> +
> +#define __MTE_PREAMBLE		ARM64_ASM_PREAMBLE ".arch_extension memtag\n"

Can this not live in mte.h?

> +#define MTE_GRANULE_SIZE	UL(16)
> +#define MTE_GRANULE_MASK	(~(MTE_GRANULE_SIZE - 1))
> +#define MTE_TAG_SHIFT		56
> +#define MTE_TAG_SIZE		4
> +#define MTE_TAG_MASK		GENMASK((MTE_TAG_SHIFT + (MTE_TAG_SIZE - 1)), MTE_TAG_SHIFT)
> +#define MTE_TAG_MAX		(MTE_TAG_MASK >> MTE_TAG_SHIFT)

I'd still like these MTE_* macros in a separate mte-hwdef.h file. The
only reason I see they were not in mte.h is because they need to be
included in asm/cache.h. They are not KASAN specific.

> +
> +#ifndef __ASSEMBLY__
> +
> +#include <linux/types.h>
> +
> +#ifdef CONFIG_ARM64_MTE
> +
> +static inline u8 mte_get_ptr_tag(void *ptr)
> +{
> +	u8 tag = (u8)(((u64)(ptr)) >> MTE_TAG_SHIFT);
> +
> +	return tag;
> +}

So this returns the top 8 bits of the address (i.e. no masking with
MTE_TAG_MASK). Fine by me.

> +
> +u8 mte_get_mem_tag(void *addr);
> +u8 mte_get_random_tag(void);
> +void *mte_set_mem_tag_range(void *addr, size_t size, u8 tag);
> +
> +#else /* CONFIG_ARM64_MTE */
> +
> +static inline u8 mte_get_ptr_tag(void *ptr)
> +{
> +	return 0xFF;
> +}
> +
> +static inline u8 mte_get_mem_tag(void *addr)
> +{
> +	return 0xFF;
> +}
> +static inline u8 mte_get_random_tag(void)
> +{
> +	return 0xFF;
> +}
> +static inline void *mte_set_mem_tag_range(void *addr, size_t size, u8 tag)
> +{
> +	return addr;
> +}

Maybe these can stay in mte-kasan.h, although they are not a direct
interface for KASAN AFAICT (the arch_* equivalent are defined in
asm/memory.h. If there's no good reason, we could move them to mte.h.

> diff --git a/arch/arm64/include/asm/mte.h b/arch/arm64/include/asm/mte.h
> index 1c99fcadb58c..3a2bf3ccb26c 100644
> --- a/arch/arm64/include/asm/mte.h
> +++ b/arch/arm64/include/asm/mte.h
> @@ -5,14 +5,13 @@
>  #ifndef __ASM_MTE_H
>  #define __ASM_MTE_H
>  
> -#define MTE_GRANULE_SIZE	UL(16)
> -#define MTE_GRANULE_MASK	(~(MTE_GRANULE_SIZE - 1))
> -#define MTE_TAG_SHIFT		56
> -#define MTE_TAG_SIZE		4
> +#include <asm/mte-kasan.h>
>  
>  #ifndef __ASSEMBLY__
>  
> +#include <linux/bitfield.h>
>  #include <linux/page-flags.h>
> +#include <linux/types.h>
>  
>  #include <asm/pgtable-types.h>
>  
> @@ -45,7 +44,9 @@ long get_mte_ctrl(struct task_struct *task);
>  int mte_ptrace_copy_tags(struct task_struct *child, long request,
>  			 unsigned long addr, unsigned long data);
>  
> -#else
> +void mte_assign_mem_tag_range(void *addr, size_t size);

So mte_set_mem_tag_range() is KASAN specific but
mte_assign_mem_tag_range() is not. Slightly confusing.

> diff --git a/arch/arm64/kernel/mte.c b/arch/arm64/kernel/mte.c
> index 52a0638ed967..833b63fdd5e2 100644
> --- a/arch/arm64/kernel/mte.c
> +++ b/arch/arm64/kernel/mte.c
> @@ -13,8 +13,10 @@
>  #include <linux/swap.h>
>  #include <linux/swapops.h>
>  #include <linux/thread_info.h>
> +#include <linux/types.h>
>  #include <linux/uio.h>
>  
> +#include <asm/barrier.h>
>  #include <asm/cpufeature.h>
>  #include <asm/mte.h>
>  #include <asm/ptrace.h>
> @@ -72,6 +74,48 @@ int memcmp_pages(struct page *page1, struct page *page2)
>  	return ret;
>  }
>  
> +u8 mte_get_mem_tag(void *addr)
> +{
> +	if (!system_supports_mte())
> +		return 0xFF;
> +
> +	asm volatile(__MTE_PREAMBLE "ldg %0, [%0]"
> +		    : "+r" (addr));

Nitpick: do we need volatile or plain asm would do?

I wonder whether we'd need the "memory" clobber. I don't see how this
would fail though, maybe later on with stack tagging if the compiler
writes tags behind our back.

> +
> +	return 0xF0 | mte_get_ptr_tag(addr);

Since mte_get_ptr_tag() returns the top byte of the address, we don't
need the additional 0xF0 or'ing. LDG only sets bits 59:56.

> +}
> +
> +u8 mte_get_random_tag(void)
> +{
> +	void *addr;
> +
> +	if (!system_supports_mte())
> +		return 0xFF;
> +
> +	asm volatile(__MTE_PREAMBLE "irg %0, %0"
> +		    : "+r" (addr));
> +
> +	return 0xF0 | mte_get_ptr_tag(addr);

Same here.

> +}
> +
> +void *mte_set_mem_tag_range(void *addr, size_t size, u8 tag)
> +{
> +	void *ptr = addr;
> +
> +	if ((!system_supports_mte()) || (size == 0))
> +		return addr;
> +
> +	/* Make sure that size is aligned. */
> +	WARN_ON(size & (MTE_GRANULE_SIZE - 1));

Doesn't the address need to be aligned as well?

> +
> +	tag = 0xF0 | tag;
> +	ptr = (void *)__tag_set(ptr, tag);
> +
> +	mte_assign_mem_tag_range(ptr, size);
> +
> +	return ptr;
> +}
> +
>  static void update_sctlr_el1_tcf0(u64 tcf0)
>  {
>  	/* ISB required for the kernel uaccess routines */
> diff --git a/arch/arm64/lib/mte.S b/arch/arm64/lib/mte.S
> index 03ca6d8b8670..aa0ab01252fe 100644
> --- a/arch/arm64/lib/mte.S
> +++ b/arch/arm64/lib/mte.S
> @@ -149,3 +149,22 @@ SYM_FUNC_START(mte_restore_page_tags)
>  
>  	ret
>  SYM_FUNC_END(mte_restore_page_tags)
> +
> +/*
> + * Assign allocation tags for a region of memory based on the pointer tag
> + *   x0 - source pointer
> + *   x1 - size
> + *
> + * Note: size must be non-zero and MTE_GRANULE_SIZE aligned

Doesn't the address need to be aligned as well?

> + */
> +SYM_FUNC_START(mte_assign_mem_tag_range)
> +	/* if (src == NULL) return; */
> +	cbz	x0, 2f
> +	/* if (size == 0) return; */
> +	cbz	x1, 2f

I find these checks unnecessary, as I said a couple of times before,
just document the function pre-conditions. They are also incomplete
(i.e. you check for NULL but not alignment).

> +1:	stg	x0, [x0]
> +	add	x0, x0, #MTE_GRANULE_SIZE
> +	subs	x1, x1, #MTE_GRANULE_SIZE
> +	b.gt	1b
> +2:	ret
> +SYM_FUNC_END(mte_assign_mem_tag_range)
> -- 
> 2.28.0.681.g6f77f65b4e-goog

-- 
Catalin
