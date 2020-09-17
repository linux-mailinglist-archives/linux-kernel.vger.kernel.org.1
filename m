Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A20126E136
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 18:54:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728685AbgIQQxw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 12:53:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:57114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728544AbgIQQxI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 12:53:08 -0400
Received: from gaia (unknown [31.124.44.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E9B5A2078D;
        Thu, 17 Sep 2020 16:52:23 +0000 (UTC)
Date:   Thu, 17 Sep 2020 17:52:21 +0100
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
Subject: Re: [PATCH v2 27/37] arm64: mte: Switch GCR_EL1 in kernel entry and
 exit
Message-ID: <20200917165221.GF10662@gaia>
References: <cover.1600204505.git.andreyknvl@google.com>
 <c801517c8c6c0b14ac2f5d9e189ff86fdbf1d495.1600204505.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c801517c8c6c0b14ac2f5d9e189ff86fdbf1d495.1600204505.git.andreyknvl@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 15, 2020 at 11:16:09PM +0200, Andrey Konovalov wrote:
> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index eca06b8c74db..3602ac45d093 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -1721,6 +1721,9 @@ static void cpu_enable_mte(struct arm64_cpu_capabilities const *cap)
>  
>  	/* Enable in-kernel MTE only if KASAN_HW_TAGS is enabled */
>  	if (IS_ENABLED(CONFIG_KASAN_HW_TAGS)) {
> +		/* Enable the kernel exclude mask for random tags generation */
> +		write_sysreg_s((SYS_GCR_EL1_RRND | gcr_kernel_excl), SYS_GCR_EL1);

Nitpick: no need for extra braces, the comma has lower precedence.

> +
>  		/* Enable MTE Sync Mode for EL1 */
>  		sysreg_clear_set(sctlr_el1, SCTLR_ELx_TCF_MASK, SCTLR_ELx_TCF_SYNC);
>  		isb();
> diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
> index ff34461524d4..79a6848840bd 100644
> --- a/arch/arm64/kernel/entry.S
> +++ b/arch/arm64/kernel/entry.S
> @@ -175,6 +175,28 @@ alternative_else_nop_endif
>  #endif
>  	.endm
>  
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
> @@ -214,6 +236,8 @@ alternative_else_nop_endif
>  
>  	ptrauth_keys_install_kernel tsk, x20, x22, x23
>  
> +	mte_restore_gcr 1, tsk, x22, x23
> +
>  	scs_load tsk, x20
>  	.else
>  	add	x21, sp, #S_FRAME_SIZE
> @@ -332,6 +356,8 @@ alternative_else_nop_endif
>  	/* No kernel C function calls after this as user keys are set. */
>  	ptrauth_keys_install_user tsk, x0, x1, x2
>  
> +	mte_restore_gcr 0, tsk, x0, x1

Some nitpicks on these macros to match the ptrauth_keys_* above. Define
separate mte_set_{user,kernel}_gcr macros with a common mte_set_gcr that
is used by both.

> +
>  	apply_ssbd 0, x0, x1
>  	.endif
>  
> diff --git a/arch/arm64/kernel/mte.c b/arch/arm64/kernel/mte.c
> index 858e75cfcaa0..1c7d963b5038 100644
> --- a/arch/arm64/kernel/mte.c
> +++ b/arch/arm64/kernel/mte.c
> @@ -18,10 +18,13 @@
>  
>  #include <asm/barrier.h>
>  #include <asm/cpufeature.h>
> +#include <asm/kprobes.h>

What's this apparently random kprobes.h include?

>  #include <asm/mte.h>
>  #include <asm/ptrace.h>
>  #include <asm/sysreg.h>
>  
> +u64 gcr_kernel_excl __ro_after_init;
> +
>  static void mte_sync_page_tags(struct page *page, pte_t *ptep, bool check_swap)
>  {
>  	pte_t old_pte = READ_ONCE(*ptep);
> @@ -120,6 +123,13 @@ void *mte_set_mem_tag_range(void *addr, size_t size, u8 tag)
>  	return ptr;
>  }
>  
> +void mte_init_tags(u64 max_tag)
> +{
> +	u64 incl = GENMASK(max_tag & MTE_TAG_MAX, 0);
> +
> +	gcr_kernel_excl = ~incl & SYS_GCR_EL1_EXCL_MASK;
> +}

Do we need to set the actual GCR_EL1 register here? We may not get an
exception by the time KASAN starts using it.

-- 
Catalin
