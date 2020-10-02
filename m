Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 609E628148D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 16:00:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387412AbgJBOAX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 10:00:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:47904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726017AbgJBOAX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 10:00:23 -0400
Received: from gaia (unknown [95.149.105.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 756C6206CD;
        Fri,  2 Oct 2020 14:00:20 +0000 (UTC)
Date:   Fri, 2 Oct 2020 15:00:18 +0100
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
Subject: Re: [PATCH v4 27/39] arm64: kasan: Enable in-kernel MTE
Message-ID: <20201002140017.GF7034@gaia>
References: <cover.1601593784.git.andreyknvl@google.com>
 <e8d5ed9bc12086670cbde30d390de32730d0371f.1601593784.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e8d5ed9bc12086670cbde30d390de32730d0371f.1601593784.git.andreyknvl@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 02, 2020 at 01:10:28AM +0200, Andrey Konovalov wrote:
> diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
> index 23c326a06b2d..6c1a6621d769 100644
> --- a/arch/arm64/mm/proc.S
> +++ b/arch/arm64/mm/proc.S
> @@ -40,9 +40,15 @@
>  #define TCR_CACHE_FLAGS	TCR_IRGN_WBWA | TCR_ORGN_WBWA
>  
>  #ifdef CONFIG_KASAN_SW_TAGS
> -#define TCR_KASAN_FLAGS TCR_TBI1
> +#define TCR_KASAN_SW_FLAGS TCR_TBI1
>  #else
> -#define TCR_KASAN_FLAGS 0
> +#define TCR_KASAN_SW_FLAGS 0
> +#endif
> +
> +#ifdef CONFIG_KASAN_HW_TAGS
> +#define TCR_KASAN_HW_FLAGS SYS_TCR_EL1_TCMA1
> +#else
> +#define TCR_KASAN_HW_FLAGS 0
>  #endif
>  
>  /*
> @@ -427,6 +433,10 @@ SYM_FUNC_START(__cpu_setup)
>  	 */
>  	mov_q	x5, MAIR_EL1_SET
>  #ifdef CONFIG_ARM64_MTE
> +	mte_tcr	.req	x20
> +
> +	mov	mte_tcr, #0
> +
>  	/*
>  	 * Update MAIR_EL1, GCR_EL1 and TFSR*_EL1 if MTE is supported
>  	 * (ID_AA64PFR1_EL1[11:8] > 1).
> @@ -447,6 +457,9 @@ SYM_FUNC_START(__cpu_setup)
>  	/* clear any pending tag check faults in TFSR*_EL1 */
>  	msr_s	SYS_TFSR_EL1, xzr
>  	msr_s	SYS_TFSRE0_EL1, xzr
> +
> +	/* set the TCR_EL1 bits */
> +	mov_q	mte_tcr, TCR_KASAN_HW_FLAGS
>  1:
>  #endif
>  	msr	mair_el1, x5
> @@ -456,7 +469,11 @@ SYM_FUNC_START(__cpu_setup)
>  	 */
>  	mov_q	x10, TCR_TxSZ(VA_BITS) | TCR_CACHE_FLAGS | TCR_SMP_FLAGS | \
>  			TCR_TG_FLAGS | TCR_KASLR_FLAGS | TCR_ASID16 | \
> -			TCR_TBI0 | TCR_A1 | TCR_KASAN_FLAGS
> +			TCR_TBI0 | TCR_A1 | TCR_KASAN_SW_FLAGS
> +#ifdef CONFIG_ARM64_MTE
> +	orr	x10, x10, mte_tcr
> +	.unreq	mte_tcr
> +#endif

Don't we miss the TBI1 bit here? I think the v3 version of this patch
was better.

-- 
Catalin
