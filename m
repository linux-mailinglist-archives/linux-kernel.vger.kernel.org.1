Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05E132FA09E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 14:02:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391987AbhARNB0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 08:01:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:56386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390479AbhARM6N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 07:58:13 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5710322B48;
        Mon, 18 Jan 2021 12:57:18 +0000 (UTC)
Date:   Mon, 18 Jan 2021 12:57:15 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, Will Deacon <will@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>
Subject: Re: [PATCH v3 3/4] arm64: mte: Enable async tag check fault
Message-ID: <20210118125715.GA4483@gaia>
References: <20210115120043.50023-1-vincenzo.frascino@arm.com>
 <20210115120043.50023-4-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210115120043.50023-4-vincenzo.frascino@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 15, 2021 at 12:00:42PM +0000, Vincenzo Frascino wrote:
> diff --git a/arch/arm64/include/asm/mte.h b/arch/arm64/include/asm/mte.h
> index d02aff9f493d..1a715963d909 100644
> --- a/arch/arm64/include/asm/mte.h
> +++ b/arch/arm64/include/asm/mte.h
> @@ -92,5 +92,26 @@ static inline void mte_assign_mem_tag_range(void *addr, size_t size)
>  
>  #endif /* CONFIG_ARM64_MTE */
>  
> +#ifdef CONFIG_KASAN_HW_TAGS
> +void mte_check_tfsr_el1_no_sync(void);
> +static inline void mte_check_tfsr_el1(void)
> +{
> +	mte_check_tfsr_el1_no_sync();
> +	/*
> +	 * The asynchronous faults are synch'ed automatically with
> +	 * TFSR_EL1 on kernel entry but for exit an explicit dsb()
> +	 * is required.
> +	 */
> +	dsb(ish);
> +}

Mark commented already, the barrier should be above
mte_check_tfsr_el1_no_sync(). Regarding the ISB, we are waiting for
confirmation from the architects.

> diff --git a/arch/arm64/kernel/mte.c b/arch/arm64/kernel/mte.c
> index df7a1ae26d7c..6cb92e9d6ad1 100644
> --- a/arch/arm64/kernel/mte.c
> +++ b/arch/arm64/kernel/mte.c
> @@ -180,6 +180,32 @@ void mte_enable_kernel(enum kasan_hw_tags_mode mode)
>  	isb();
>  }
>  
> +#ifdef CONFIG_KASAN_HW_TAGS
> +void mte_check_tfsr_el1_no_sync(void)
> +{
> +	u64 tfsr_el1;
> +
> +	if (!system_supports_mte())
> +		return;
> +
> +	tfsr_el1 = read_sysreg_s(SYS_TFSR_EL1);
> +
> +	/*
> +	 * The kernel should never hit the condition TF0 == 1
> +	 * at this point because for the futex code we set
> +	 * PSTATE.TCO.
> +	 */
> +	WARN_ON(tfsr_el1 & SYS_TFSR_EL1_TF0);

I'd change this to a WARN_ON_ONCE() in case we trip over this due to
model bugs etc. and it floods the log.

> +	if (tfsr_el1 & SYS_TFSR_EL1_TF1) {
> +		write_sysreg_s(0, SYS_TFSR_EL1);
> +		isb();

While in general we use ISB after a sysreg update, I haven't convinced
myself it's needed here. There's no side-effect to updating this reg and
a subsequent TFSR access should see the new value. If a speculated load
is allowed to update this reg, we'd probably need an ISB+DSB (I don't
think it does, something to check with the architects).

> +
> +		pr_err("MTE: Asynchronous tag exception detected!");

We discussed this already, I think we should replace this pr_err() with
a call to kasan_report(). In principle, kasan already knows the mode as
it asked for sync/async but we could make this explicit and expand the
kasan API to take some argument (or have separate function like
kasan_report_async()).

-- 
Catalin
