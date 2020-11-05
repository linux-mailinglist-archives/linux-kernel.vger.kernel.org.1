Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A842B2A84EA
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 18:30:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731527AbgKERal (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 12:30:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:60582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725862AbgKERal (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 12:30:41 -0500
Received: from gaia (unknown [2.26.170.190])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5C3DF206B6;
        Thu,  5 Nov 2020 17:30:37 +0000 (UTC)
Date:   Thu, 5 Nov 2020 17:30:34 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Will Deacon <will.deacon@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev@googlegroups.com, linux-arm-kernel@lists.infradead.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 32/43] arm64: mte: Switch GCR_EL1 in kernel entry and
 exit
Message-ID: <20201105173033.GF30030@gaia>
References: <cover.1604531793.git.andreyknvl@google.com>
 <5d9ece04df8e9d60e347a2f6f96b8c52316bfe66.1604531793.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d9ece04df8e9d60e347a2f6f96b8c52316bfe66.1604531793.git.andreyknvl@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 05, 2020 at 12:18:47AM +0100, Andrey Konovalov wrote:
> diff --git a/arch/arm64/kernel/mte.c b/arch/arm64/kernel/mte.c
> index 14b0c19a33e3..cc7e0f8707f7 100644
> --- a/arch/arm64/kernel/mte.c
> +++ b/arch/arm64/kernel/mte.c
> @@ -23,6 +23,8 @@
>  #include <asm/ptrace.h>
>  #include <asm/sysreg.h>
>  
> +u64 gcr_kernel_excl __ro_after_init;
> +
>  static void mte_sync_page_tags(struct page *page, pte_t *ptep, bool check_swap)
>  {
>  	pte_t old_pte = READ_ONCE(*ptep);
> @@ -123,6 +125,23 @@ void *mte_set_mem_tag_range(void *addr, size_t size, u8 tag)
>  
>  void __init mte_init_tags(u64 max_tag)
>  {
> +	static bool gcr_kernel_excl_initialized = false;
> +
> +	if (!gcr_kernel_excl_initialized) {
> +		/*
> +		 * The format of the tags in KASAN is 0xFF and in MTE is 0xF.
> +		 * This conversion extracts an MTE tag from a KASAN tag.
> +		 */
> +		u64 incl = GENMASK(FIELD_GET(MTE_TAG_MASK >> MTE_TAG_SHIFT,
> +					     max_tag), 0);
> +
> +		gcr_kernel_excl = ~incl & SYS_GCR_EL1_EXCL_MASK;
> +		gcr_kernel_excl_initialized = true;
> +	}
> +
> +	/* Enable the kernel exclude mask for random tags generation. */
> +	write_sysreg_s(SYS_GCR_EL1_RRND | gcr_kernel_excl, SYS_GCR_EL1);

Same question as on a previous patch. Is SYS_GCR_EL1 written on the
other registers via cpu_enable_mte()?

-- 
Catalin
