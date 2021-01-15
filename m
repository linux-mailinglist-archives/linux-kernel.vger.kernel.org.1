Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7ED22F7F0C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 16:09:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732695AbhAOPJK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 10:09:10 -0500
Received: from foss.arm.com ([217.140.110.172]:42436 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730569AbhAOPJI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 10:09:08 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1D92BD6E;
        Fri, 15 Jan 2021 07:08:23 -0800 (PST)
Received: from C02TD0UTHF1T.local (unknown [10.57.41.13])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 270B53F70D;
        Fri, 15 Jan 2021 07:08:18 -0800 (PST)
Date:   Fri, 15 Jan 2021 15:08:11 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, Marco Elver <elver@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Alexander Potapenko <glider@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Will Deacon <will@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>
Subject: Re: [PATCH v3 1/4] kasan, arm64: Add KASAN light mode
Message-ID: <20210115150811.GA44111@C02TD0UTHF1T.local>
References: <20210115120043.50023-1-vincenzo.frascino@arm.com>
 <20210115120043.50023-2-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210115120043.50023-2-vincenzo.frascino@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 15, 2021 at 12:00:40PM +0000, Vincenzo Frascino wrote:
> Architectures supported by KASAN HW can provide a light mode of
> execution. On an MTE enabled arm64 hw for example this can be identified
> with the asynch mode of execution.
> In this mode, if a tag check fault occurs, the TFSR_EL1 register is
> updated asynchronously. The kernel checks the corresponding bits
> periodically.

What's the expected usage of this relative to prod, given that this has
to be chosen at boot time? When/where is this expected to be used
relative to prod mode?

> diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
> index 18fce223b67b..3a7c5beb7096 100644
> --- a/arch/arm64/include/asm/memory.h
> +++ b/arch/arm64/include/asm/memory.h
> @@ -231,7 +231,7 @@ static inline const void *__tag_set(const void *addr, u8 tag)
>  }
>  
>  #ifdef CONFIG_KASAN_HW_TAGS
> -#define arch_enable_tagging()			mte_enable_kernel()
> +#define arch_enable_tagging(mode)		mte_enable_kernel(mode)

Rather than passing a mode in, I think it'd be better to have:

* arch_enable_tagging_prod()
* arch_enable_tagging_light()

... that we can map in the arch code to separate:

* mte_enable_kernel_sync()
* mte_enable_kernel_async()

... as by construction that avoids calls with an unhandled mode, and we
wouldn't need the mode enum kasan_hw_tags_mode...

> +static inline int hw_init_mode(enum kasan_arg_mode mode)
> +{
> +	switch (mode) {
> +	case KASAN_ARG_MODE_LIGHT:
> +		return KASAN_HW_TAGS_ASYNC;
> +	default:
> +		return KASAN_HW_TAGS_SYNC;
> +	}
> +}

... and we can just have a wrapper like this to call either of the two functions directly, i.e.

static inline void hw_enable_tagging_mode(enum kasan_arg_mode mode)
{
	if (mode == KASAN_ARG_MODE_LIGHT)
		arch_enable_tagging_mode_light();
	else
		arch_enable_tagging_mode_prod();
}

Thanks,
Mark.
