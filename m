Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94D3C2F7FF3
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 16:47:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733201AbhAOPqQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 10:46:16 -0500
Received: from foss.arm.com ([217.140.110.172]:43290 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725910AbhAOPqQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 10:46:16 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 457CBD6E;
        Fri, 15 Jan 2021 07:45:30 -0800 (PST)
Received: from C02TD0UTHF1T.local (unknown [10.57.41.13])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 70C153F70D;
        Fri, 15 Jan 2021 07:45:24 -0800 (PST)
Date:   Fri, 15 Jan 2021 15:45:20 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>
Subject: Re: [PATCH v3 4/4] arm64: mte: Optimize mte_assign_mem_tag_range()
Message-ID: <20210115154520.GD44111@C02TD0UTHF1T.local>
References: <20210115120043.50023-1-vincenzo.frascino@arm.com>
 <20210115120043.50023-5-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210115120043.50023-5-vincenzo.frascino@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 15, 2021 at 12:00:43PM +0000, Vincenzo Frascino wrote:
> mte_assign_mem_tag_range() is called on production KASAN HW hot
> paths. It makes sense to optimize it in an attempt to reduce the
> overhead.
> 
> Optimize mte_assign_mem_tag_range() based on the indications provided at
> [1].

... what exactly is the optimization?

I /think/ you're just trying to have it inlined, but you should mention
that explicitly.

> 
> [1] https://lore.kernel.org/r/CAAeHK+wCO+J7D1_T89DG+jJrPLk3X9RsGFKxJGd0ZcUFjQT-9Q@mail.gmail.com/
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> ---
>  arch/arm64/include/asm/mte.h | 26 +++++++++++++++++++++++++-
>  arch/arm64/lib/mte.S         | 15 ---------------
>  2 files changed, 25 insertions(+), 16 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/mte.h b/arch/arm64/include/asm/mte.h
> index 1a715963d909..9730f2b07b79 100644
> --- a/arch/arm64/include/asm/mte.h
> +++ b/arch/arm64/include/asm/mte.h
> @@ -49,7 +49,31 @@ long get_mte_ctrl(struct task_struct *task);
>  int mte_ptrace_copy_tags(struct task_struct *child, long request,
>  			 unsigned long addr, unsigned long data);
>  
> -void mte_assign_mem_tag_range(void *addr, size_t size);
> +static inline void mte_assign_mem_tag_range(void *addr, size_t size)
> +{
> +	u64 _addr = (u64)addr;
> +	u64 _end = _addr + size;
> +
> +	/*
> +	 * This function must be invoked from an MTE enabled context.
> +	 *
> +	 * Note: The address must be non-NULL and MTE_GRANULE_SIZE aligned and
> +	 * size must be non-zero and MTE_GRANULE_SIZE aligned.
> +	 */
> +	do {
> +		/*
> +		 * 'asm volatile' is required to prevent the compiler to move
> +		 * the statement outside of the loop.
> +		 */
> +		asm volatile(__MTE_PREAMBLE "stg %0, [%0]"
> +			     :
> +			     : "r" (_addr)
> +			     : "memory");
> +
> +		_addr += MTE_GRANULE_SIZE;
> +	} while (_addr < _end);

Is there any chance that this can be used for the last bytes of the
virtual address space? This might need to change to `_addr == _end` if
that is possible, otherwise it'll terminate early in that case.

> +}

What does the code generation look like for this, relative to the
assembly version?

Thanks,
Mark.

> +
>  
>  #else /* CONFIG_ARM64_MTE */
>  
> diff --git a/arch/arm64/lib/mte.S b/arch/arm64/lib/mte.S
> index 9e1a12e10053..a0a650451510 100644
> --- a/arch/arm64/lib/mte.S
> +++ b/arch/arm64/lib/mte.S
> @@ -150,18 +150,3 @@ SYM_FUNC_START(mte_restore_page_tags)
>  	ret
>  SYM_FUNC_END(mte_restore_page_tags)
>  
> -/*
> - * Assign allocation tags for a region of memory based on the pointer tag
> - *   x0 - source pointer
> - *   x1 - size
> - *
> - * Note: The address must be non-NULL and MTE_GRANULE_SIZE aligned and
> - * size must be non-zero and MTE_GRANULE_SIZE aligned.
> - */
> -SYM_FUNC_START(mte_assign_mem_tag_range)
> -1:	stg	x0, [x0]
> -	add	x0, x0, #MTE_GRANULE_SIZE
> -	subs	x1, x1, #MTE_GRANULE_SIZE
> -	b.gt	1b
> -	ret
> -SYM_FUNC_END(mte_assign_mem_tag_range)
> -- 
> 2.30.0
> 
