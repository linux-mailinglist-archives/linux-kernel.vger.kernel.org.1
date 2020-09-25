Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8937278595
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 13:14:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727957AbgIYLOm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 07:14:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:35614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727201AbgIYLOm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 07:14:42 -0400
Received: from gaia (unknown [31.124.44.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8777E208B6;
        Fri, 25 Sep 2020 11:14:39 +0000 (UTC)
Date:   Fri, 25 Sep 2020 12:14:37 +0100
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
Subject: Re: [PATCH v3 27/39] arm64: kasan: Enable in-kernel MTE
Message-ID: <20200925111435.GE4846@gaia>
References: <cover.1600987622.git.andreyknvl@google.com>
 <20326c060cd1535b15a0df43d1b9627a329f2277.1600987622.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20326c060cd1535b15a0df43d1b9627a329f2277.1600987622.git.andreyknvl@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 25, 2020 at 12:50:34AM +0200, Andrey Konovalov wrote:
> diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
> index 23c326a06b2d..12ba98bc3b3f 100644
> --- a/arch/arm64/mm/proc.S
> +++ b/arch/arm64/mm/proc.S
> @@ -427,6 +427,10 @@ SYM_FUNC_START(__cpu_setup)
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
> @@ -447,6 +451,9 @@ SYM_FUNC_START(__cpu_setup)
>  	/* clear any pending tag check faults in TFSR*_EL1 */
>  	msr_s	SYS_TFSR_EL1, xzr
>  	msr_s	SYS_TFSRE0_EL1, xzr
> +
> +	/* set the TCR_EL1 bits */
> +	orr	mte_tcr, mte_tcr, #SYS_TCR_EL1_TCMA1
>  1:
>  #endif
>  	msr	mair_el1, x5
> @@ -457,6 +464,10 @@ SYM_FUNC_START(__cpu_setup)
>  	mov_q	x10, TCR_TxSZ(VA_BITS) | TCR_CACHE_FLAGS | TCR_SMP_FLAGS | \
>  			TCR_TG_FLAGS | TCR_KASLR_FLAGS | TCR_ASID16 | \
>  			TCR_TBI0 | TCR_A1 | TCR_KASAN_FLAGS
> +#ifdef CONFIG_ARM64_MTE
> +	orr	x10, x10, mte_tcr
> +	.unreq	mte_tcr
> +#endif
>  	tcr_clear_errata_bits x10, x9, x5

I had a slightly different preference (see the previous version) to
avoid the #ifdef altogether but this works as well.

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
