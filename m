Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76D7726E154
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 18:55:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728756AbgIQQzq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 12:55:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:60884 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728734AbgIQQzC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 12:55:02 -0400
Received: from gaia (unknown [31.124.44.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0CD1F2078D;
        Thu, 17 Sep 2020 16:54:59 +0000 (UTC)
Date:   Thu, 17 Sep 2020 17:54:57 +0100
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
Subject: Re: [PATCH v2 28/37] arm64: kasan: Enable TBI EL1
Message-ID: <20200917165457.GG10662@gaia>
References: <cover.1600204505.git.andreyknvl@google.com>
 <9ecc27d43a01ca32bcacf44b393a9a100e0dfdb2.1600204505.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9ecc27d43a01ca32bcacf44b393a9a100e0dfdb2.1600204505.git.andreyknvl@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 15, 2020 at 11:16:10PM +0200, Andrey Konovalov wrote:
> diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
> index 5ba7ac5e9c77..1687447dee7a 100644
> --- a/arch/arm64/mm/proc.S
> +++ b/arch/arm64/mm/proc.S
> @@ -40,9 +40,13 @@
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
> +#define TCR_KASAN_HW_FLAGS TCR_TBI1
>  #endif
>  
>  /*
> @@ -462,7 +466,7 @@ SYM_FUNC_START(__cpu_setup)
>  	 */
>  	mov_q	x10, TCR_TxSZ(VA_BITS) | TCR_CACHE_FLAGS | TCR_SMP_FLAGS | \
>  			TCR_TG_FLAGS | TCR_KASLR_FLAGS | TCR_ASID16 | \
> -			TCR_TBI0 | TCR_A1 | TCR_KASAN_FLAGS
> +			TCR_TBI0 | TCR_A1 | TCR_KASAN_SW_FLAGS
>  	tcr_clear_errata_bits x10, x9, x5
>  
>  #ifdef CONFIG_ARM64_VA_BITS_52
> @@ -495,6 +499,9 @@ SYM_FUNC_START(__cpu_setup)
>  	/* Update TCR_EL1 if MTE is supported (ID_AA64PFR1_EL1[11:8] > 1) */
>  	cbz	mte_present, 1f
>  	orr	x10, x10, #SYS_TCR_EL1_TCMA1
> +#ifdef CONFIG_KASAN_HW_TAGS
> +	orr	x10, x10, #TCR_KASAN_HW_FLAGS
> +#endif

That's fine in general but see my comment about refactoring the other
patch touching this file, this will move around a bit.

-- 
Catalin
