Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1E872543E0
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Aug 2020 12:38:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728520AbgH0Kia (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Aug 2020 06:38:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:53540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726266AbgH0KiZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 06:38:25 -0400
Received: from gaia (unknown [46.69.195.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 01EF022B40;
        Thu, 27 Aug 2020 10:38:21 +0000 (UTC)
Date:   Thu, 27 Aug 2020 11:38:19 +0100
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
Subject: Re: [PATCH 24/35] arm64: mte: Switch GCR_EL1 in kernel entry and exit
Message-ID: <20200827103819.GE29264@gaia>
References: <cover.1597425745.git.andreyknvl@google.com>
 <ec314a9589ef8db18494d533b6eaf1fd678dc010.1597425745.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ec314a9589ef8db18494d533b6eaf1fd678dc010.1597425745.git.andreyknvl@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 14, 2020 at 07:27:06PM +0200, Andrey Konovalov wrote:
> diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
> index cde127508e38..a17fefb0571b 100644
> --- a/arch/arm64/kernel/entry.S
> +++ b/arch/arm64/kernel/entry.S
> @@ -172,6 +172,29 @@ alternative_else_nop_endif
>  #endif
>  	.endm
>  
> +	/* Note: tmp should always be a callee-saved register */

Why callee-saved? Do you preserve it anywhere here?

> +	.macro mte_restore_gcr, el, tsk, tmp, tmp2
> +#ifdef CONFIG_ARM64_MTE
> +alternative_if_not ARM64_MTE
> +	b	1f
> +alternative_else_nop_endif
> +	.if	\el == 0
> +	ldr	\tmp, [\tsk, #THREAD_GCR_EL1_USER]
> +	.else
> +	ldr_l	\tmp, gcr_kernel_excl
> +	.endif
> +	/*
> +	 * Calculate and set the exclude mask preserving
> +	 * the RRND (bit[16]) setting.
> +	 */
> +	mrs_s	\tmp2, SYS_GCR_EL1
> +	bfi	\tmp2, \tmp, #0, #16
> +	msr_s	SYS_GCR_EL1, \tmp2
> +	isb
> +1:
> +#endif
> +	.endm
> +
>  	.macro	kernel_entry, el, regsize = 64
>  	.if	\regsize == 32
>  	mov	w0, w0				// zero upper 32 bits of x0
> @@ -209,6 +232,8 @@ alternative_else_nop_endif
>  
>  	ptrauth_keys_install_kernel tsk, x20, x22, x23
>  
> +	mte_restore_gcr 1, tsk, x22, x23
> +
>  	scs_load tsk, x20
>  	.else
>  	add	x21, sp, #S_FRAME_SIZE
> @@ -386,6 +411,8 @@ alternative_else_nop_endif
>  	/* No kernel C function calls after this as user keys are set. */
>  	ptrauth_keys_install_user tsk, x0, x1, x2
>  
> +	mte_restore_gcr 0, tsk, x0, x1
> +
>  	apply_ssbd 0, x0, x1
>  	.endif
>  
> @@ -957,6 +984,7 @@ SYM_FUNC_START(cpu_switch_to)
>  	mov	sp, x9
>  	msr	sp_el0, x1
>  	ptrauth_keys_install_kernel x1, x8, x9, x10
> +	mte_restore_gcr 1, x1, x8, x9
>  	scs_save x0, x8
>  	scs_load x1, x8
>  	ret

Since we set GCR_EL1 on exception entry and return, why is this needed?
We don't have a per-kernel thread GCR_EL1, it's global to all threads,
so I think cpu_switch_to() should not be touched.

> diff --git a/arch/arm64/kernel/mte.c b/arch/arm64/kernel/mte.c
> index 7717ea9bc2a7..cfac7d02f032 100644
> --- a/arch/arm64/kernel/mte.c
> +++ b/arch/arm64/kernel/mte.c
> @@ -18,10 +18,14 @@
>  
>  #include <asm/barrier.h>
>  #include <asm/cpufeature.h>
> +#include <asm/kasan.h>
> +#include <asm/kprobes.h>
>  #include <asm/mte.h>
>  #include <asm/ptrace.h>
>  #include <asm/sysreg.h>
>  
> +u64 gcr_kernel_excl __read_mostly;

Could we make this __ro_after_init?

> +
>  static void mte_sync_page_tags(struct page *page, pte_t *ptep, bool check_swap)
>  {
>  	pte_t old_pte = READ_ONCE(*ptep);
> @@ -115,6 +119,13 @@ void * __must_check mte_set_mem_tag_range(void *addr, size_t size, u8 tag)
>  	return ptr;
>  }
>  
> +void mte_init_tags(u64 max_tag)
> +{
> +	u64 incl = ((1ULL << ((max_tag & MTE_TAG_MAX) + 1)) - 1);

I'd rather use GENMASK here, it is more readable.

-- 
Catalin
