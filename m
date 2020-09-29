Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9D2527D10F
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 16:28:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729321AbgI2O2B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 10:28:01 -0400
Received: from foss.arm.com ([217.140.110.172]:46258 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727543AbgI2O2B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 10:28:01 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1F3D031B;
        Tue, 29 Sep 2020 07:28:00 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.51.69])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2B01F3F6CF;
        Tue, 29 Sep 2020 07:27:55 -0700 (PDT)
Date:   Tue, 29 Sep 2020 15:27:52 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Marco Elver <elver@google.com>
Cc:     akpm@linux-foundation.org, glider@google.com, hpa@zytor.com,
        paulmck@kernel.org, andreyknvl@google.com, aryabinin@virtuozzo.com,
        luto@kernel.org, bp@alien8.de, catalin.marinas@arm.com,
        cl@linux.com, dave.hansen@linux.intel.com, rientjes@google.com,
        dvyukov@google.com, edumazet@google.com,
        gregkh@linuxfoundation.org, hdanton@sina.com, mingo@redhat.com,
        jannh@google.com, Jonathan.Cameron@huawei.com, corbet@lwn.net,
        iamjoonsoo.kim@lge.com, keescook@chromium.org, penberg@kernel.org,
        peterz@infradead.org, sjpark@amazon.com, tglx@linutronix.de,
        vbabka@suse.cz, will@kernel.org, x86@kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, linux-arm-kernel@lists.infradead.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v3 03/10] arm64, kfence: enable KFENCE for ARM64
Message-ID: <20200929142752.GD53442@C02TD0UTHF1T.local>
References: <20200921132611.1700350-1-elver@google.com>
 <20200921132611.1700350-4-elver@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200921132611.1700350-4-elver@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 21, 2020 at 03:26:04PM +0200, Marco Elver wrote:
> Add architecture specific implementation details for KFENCE and enable
> KFENCE for the arm64 architecture. In particular, this implements the
> required interface in <asm/kfence.h>. Currently, the arm64 version does
> not yet use a statically allocated memory pool, at the cost of a pointer
> load for each is_kfence_address().
> 
> Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
> Co-developed-by: Alexander Potapenko <glider@google.com>
> Signed-off-by: Alexander Potapenko <glider@google.com>
> Signed-off-by: Marco Elver <elver@google.com>
> ---
> For ARM64, we would like to solicit feedback on what the best option is
> to obtain a constant address for __kfence_pool. One option is to declare
> a memory range in the memory layout to be dedicated to KFENCE (like is
> done for KASAN), however, it is unclear if this is the best available
> option. We would like to avoid touching the memory layout.
> ---
>  arch/arm64/Kconfig              |  1 +
>  arch/arm64/include/asm/kfence.h | 39 +++++++++++++++++++++++++++++++++
>  arch/arm64/mm/fault.c           |  4 ++++
>  3 files changed, 44 insertions(+)
>  create mode 100644 arch/arm64/include/asm/kfence.h
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 6d232837cbee..1acc6b2877c3 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -132,6 +132,7 @@ config ARM64
>  	select HAVE_ARCH_JUMP_LABEL_RELATIVE
>  	select HAVE_ARCH_KASAN if !(ARM64_16K_PAGES && ARM64_VA_BITS_48)
>  	select HAVE_ARCH_KASAN_SW_TAGS if HAVE_ARCH_KASAN
> +	select HAVE_ARCH_KFENCE if (!ARM64_16K_PAGES && !ARM64_64K_PAGES)
>  	select HAVE_ARCH_KGDB
>  	select HAVE_ARCH_MMAP_RND_BITS
>  	select HAVE_ARCH_MMAP_RND_COMPAT_BITS if COMPAT
> diff --git a/arch/arm64/include/asm/kfence.h b/arch/arm64/include/asm/kfence.h
> new file mode 100644
> index 000000000000..608dde80e5ca
> --- /dev/null
> +++ b/arch/arm64/include/asm/kfence.h
> @@ -0,0 +1,39 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#ifndef __ASM_KFENCE_H
> +#define __ASM_KFENCE_H
> +
> +#include <linux/kfence.h>
> +#include <linux/log2.h>
> +#include <linux/mm.h>
> +
> +#include <asm/cacheflush.h>
> +
> +#define KFENCE_SKIP_ARCH_FAULT_HANDLER "el1_sync"
> +
> +/*
> + * FIXME: Support HAVE_ARCH_KFENCE_STATIC_POOL: Use the statically allocated
> + * __kfence_pool, to avoid the extra pointer load for is_kfence_address(). By
> + * default, however, we do not have struct pages for static allocations.
> + */
> +
> +static inline bool arch_kfence_initialize_pool(void)
> +{
> +	const unsigned int num_pages = ilog2(roundup_pow_of_two(KFENCE_POOL_SIZE / PAGE_SIZE));
> +	struct page *pages = alloc_pages(GFP_KERNEL, num_pages);
> +
> +	if (!pages)
> +		return false;
> +
> +	__kfence_pool = page_address(pages);
> +	return true;
> +}
> +
> +static inline bool kfence_protect_page(unsigned long addr, bool protect)
> +{
> +	set_memory_valid(addr, 1, !protect);
> +
> +	return true;
> +}

This is only safe if the linear map is force ot page granularity. That's
the default with rodata=full, but this is not always the case, so this
will need some interaction with the MMU setup in arch/arm64/mm/mmu.c.

Thanks,
Mark.
