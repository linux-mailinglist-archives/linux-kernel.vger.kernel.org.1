Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1E1726E0DD
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 18:38:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728552AbgIQQhp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 12:37:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:44906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728513AbgIQQfn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 12:35:43 -0400
Received: from gaia (unknown [31.124.44.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0D54420672;
        Thu, 17 Sep 2020 16:35:39 +0000 (UTC)
Date:   Thu, 17 Sep 2020 17:35:37 +0100
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
Subject: Re: [PATCH v2 25/37] arm64: kasan: Enable in-kernel MTE
Message-ID: <20200917163536.GE10662@gaia>
References: <cover.1600204505.git.andreyknvl@google.com>
 <859111cf1d862ce26f094cf14511461c372e5bbc.1600204505.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <859111cf1d862ce26f094cf14511461c372e5bbc.1600204505.git.andreyknvl@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 15, 2020 at 11:16:07PM +0200, Andrey Konovalov wrote:
> diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
> index 23c326a06b2d..5ba7ac5e9c77 100644
> --- a/arch/arm64/mm/proc.S
> +++ b/arch/arm64/mm/proc.S
> @@ -427,6 +427,10 @@ SYM_FUNC_START(__cpu_setup)
>  	 */
>  	mov_q	x5, MAIR_EL1_SET
>  #ifdef CONFIG_ARM64_MTE
> +	mte_present	.req	x20
> +
> +	mov	mte_present, #0
> +
>  	/*
>  	 * Update MAIR_EL1, GCR_EL1 and TFSR*_EL1 if MTE is supported
>  	 * (ID_AA64PFR1_EL1[11:8] > 1).
> @@ -447,6 +451,8 @@ SYM_FUNC_START(__cpu_setup)
>  	/* clear any pending tag check faults in TFSR*_EL1 */
>  	msr_s	SYS_TFSR_EL1, xzr
>  	msr_s	SYS_TFSRE0_EL1, xzr
> +
> +	mov	mte_present, #1
>  1:
>  #endif
>  	msr	mair_el1, x5
> @@ -485,6 +491,13 @@ SYM_FUNC_START(__cpu_setup)
>  	orr	x10, x10, #TCR_HA		// hardware Access flag update
>  1:
>  #endif	/* CONFIG_ARM64_HW_AFDBM */
> +#ifdef CONFIG_ARM64_MTE
> +	/* Update TCR_EL1 if MTE is supported (ID_AA64PFR1_EL1[11:8] > 1) */
> +	cbz	mte_present, 1f
> +	orr	x10, x10, #SYS_TCR_EL1_TCMA1
> +1:
> +	.unreq	mte_present
> +#endif
>  	msr	tcr_el1, x10
>  	/*
>  	 * Prepare SCTLR

I'd keep this simpler, no branches or #ifdefs (you can still add the
.req if you want):

diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
index 23c326a06b2d..a35344754081 100644
--- a/arch/arm64/mm/proc.S
+++ b/arch/arm64/mm/proc.S
@@ -426,6 +426,7 @@ SYM_FUNC_START(__cpu_setup)
 	 * Memory region attributes
 	 */
 	mov_q	x5, MAIR_EL1_SET
+	mov	x8, #0
 #ifdef CONFIG_ARM64_MTE
 	/*
 	 * Update MAIR_EL1, GCR_EL1 and TFSR*_EL1 if MTE is supported
@@ -447,6 +448,9 @@ SYM_FUNC_START(__cpu_setup)
 	/* clear any pending tag check faults in TFSR*_EL1 */
 	msr_s	SYS_TFSR_EL1, xzr
 	msr_s	SYS_TFSRE0_EL1, xzr
+
+	/* set the TCR_EL1 bits */
+	orr	x8, x8, #SYS_TCR_EL1_TCMA1
 1:
 #endif
 	msr	mair_el1, x5
@@ -457,6 +461,7 @@ SYM_FUNC_START(__cpu_setup)
 	mov_q	x10, TCR_TxSZ(VA_BITS) | TCR_CACHE_FLAGS | TCR_SMP_FLAGS | \
 			TCR_TG_FLAGS | TCR_KASLR_FLAGS | TCR_ASID16 | \
 			TCR_TBI0 | TCR_A1 | TCR_KASAN_FLAGS
+	orr	x10, x10, x8
 	tcr_clear_errata_bits x10, x9, x5
 
 #ifdef CONFIG_ARM64_VA_BITS_52

-- 
Catalin
