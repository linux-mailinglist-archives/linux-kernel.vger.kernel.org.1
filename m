Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AF8E2785F7
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 13:34:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728156AbgIYLej (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 07:34:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:46626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726990AbgIYLej (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 07:34:39 -0400
Received: from gaia (unknown [31.124.44.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 358C421741;
        Fri, 25 Sep 2020 11:34:36 +0000 (UTC)
Date:   Fri, 25 Sep 2020 12:34:33 +0100
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
Subject: Re: [PATCH v3 29/39] arm64: mte: Switch GCR_EL1 in kernel entry and
 exit
Message-ID: <20200925113433.GF4846@gaia>
References: <cover.1600987622.git.andreyknvl@google.com>
 <4e503a54297cf46ea1261f43aa325c598d9bd73e.1600987622.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4e503a54297cf46ea1261f43aa325c598d9bd73e.1600987622.git.andreyknvl@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 25, 2020 at 12:50:36AM +0200, Andrey Konovalov wrote:
> diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
> index ff34461524d4..c7cc1fdfbd1a 100644
> --- a/arch/arm64/kernel/entry.S
> +++ b/arch/arm64/kernel/entry.S
> @@ -175,6 +175,49 @@ alternative_else_nop_endif
>  #endif
>  	.endm
>  
> +	.macro mte_set_gcr, tmp, tmp2
> +#ifdef CONFIG_ARM64_MTE
> +alternative_if_not ARM64_MTE
> +	b	1f
> +alternative_else_nop_endif

You don't need the alternative here. The macro is only invoked in an
alternative path already (I'd be surprised if it even works, we don't
handle nested alternatives well).

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
> +	.macro mte_set_kernel_gcr, tsk, tmp, tmp2

What's the point of a 'tsk' argument here?

> +#ifdef CONFIG_KASAN_HW_TAGS
> +#ifdef CONFIG_ARM64_MTE

Does KASAN_HW_TAGS depend on ARM64_MTE already? Just to avoid too may
ifdefs. Otherwise, you can always write it as:

#if defined(CONFIG_KASAN_HW_TAGS) && defined(CONFIG_ARM64_MTE)

to save two lines (and its easier to read).

> +alternative_if_not ARM64_MTE
> +	b	1f
> +alternative_else_nop_endif
> +	ldr_l	\tmp, gcr_kernel_excl
> +
> +	mte_set_gcr \tmp, \tmp2
> +1:
> +#endif
> +#endif
> +	.endm
> +
> +	.macro mte_set_user_gcr, tsk, tmp, tmp2
> +#ifdef CONFIG_ARM64_MTE
> +alternative_if_not ARM64_MTE
> +	b	1f
> +alternative_else_nop_endif
> +	ldr	\tmp, [\tsk, #THREAD_GCR_EL1_USER]
> +
> +	mte_set_gcr \tmp, \tmp2
> +1:
> +#endif
> +	.endm
> +
>  	.macro	kernel_entry, el, regsize = 64
>  	.if	\regsize == 32
>  	mov	w0, w0				// zero upper 32 bits of x0
> @@ -214,6 +257,8 @@ alternative_else_nop_endif
>  
>  	ptrauth_keys_install_kernel tsk, x20, x22, x23
>  
> +	mte_set_kernel_gcr tsk, x22, x23
> +
>  	scs_load tsk, x20
>  	.else
>  	add	x21, sp, #S_FRAME_SIZE
> @@ -332,6 +377,8 @@ alternative_else_nop_endif
>  	/* No kernel C function calls after this as user keys are set. */
>  	ptrauth_keys_install_user tsk, x0, x1, x2
>  
> +	mte_set_user_gcr tsk, x0, x1
> +
>  	apply_ssbd 0, x0, x1
>  	.endif
>  
> diff --git a/arch/arm64/kernel/mte.c b/arch/arm64/kernel/mte.c
> index 393d0c794be4..c3b4f056fc54 100644
> --- a/arch/arm64/kernel/mte.c
> +++ b/arch/arm64/kernel/mte.c
> @@ -22,6 +22,8 @@
>  #include <asm/ptrace.h>
>  #include <asm/sysreg.h>
>  
> +u64 gcr_kernel_excl __ro_after_init;
> +
>  static void mte_sync_page_tags(struct page *page, pte_t *ptep, bool check_swap)
>  {
>  	pte_t old_pte = READ_ONCE(*ptep);
> @@ -116,6 +118,13 @@ void *mte_set_mem_tag_range(void *addr, size_t size, u8 tag)
>  	return ptr;
>  }
>  
> +void mte_init_tags(u64 max_tag)
> +{
> +	u64 incl = GENMASK(max_tag & MTE_TAG_MAX, 0);
> +
> +	gcr_kernel_excl = ~incl & SYS_GCR_EL1_EXCL_MASK;
> +}
> +
>  static void update_sctlr_el1_tcf0(u64 tcf0)
>  {
>  	/* ISB required for the kernel uaccess routines */
> @@ -151,7 +160,11 @@ static void update_gcr_el1_excl(u64 excl)
>  static void set_gcr_el1_excl(u64 excl)
>  {
>  	current->thread.gcr_user_excl = excl;
> -	update_gcr_el1_excl(excl);
> +
> +	/*
> +	 * SYS_GCR_EL1 will be set to current->thread.gcr_user_incl value
                                                      ^^^^^^^^^^^^^
That's gcr_user_excl now.

> +	 * by mte_restore_gcr() in kernel_exit,

I don't think mte_restore_gcr is still around in this patch.

-- 
Catalin
