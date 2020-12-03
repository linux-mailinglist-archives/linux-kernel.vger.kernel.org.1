Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 165132CD36C
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 11:28:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388667AbgLCK1Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 05:27:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:51960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730157AbgLCK1P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 05:27:15 -0500
Date:   Thu, 3 Dec 2020 10:26:29 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        kasan-dev@googlegroups.com, linux-arm-kernel@lists.infradead.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH mm v11 27/42] arm64: mte: Add in-kernel tag fault handler
Message-ID: <20201203102628.GB2224@gaia>
References: <cover.1606161801.git.andreyknvl@google.com>
 <ad31529b073e22840b7a2246172c2b67747ed7c4.1606161801.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad31529b073e22840b7a2246172c2b67747ed7c4.1606161801.git.andreyknvl@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 23, 2020 at 09:07:51PM +0100, Andrey Konovalov wrote:
> diff --git a/arch/arm64/include/asm/uaccess.h b/arch/arm64/include/asm/uaccess.h
> index 385a189f7d39..d841a560fae7 100644
> --- a/arch/arm64/include/asm/uaccess.h
> +++ b/arch/arm64/include/asm/uaccess.h
> @@ -200,13 +200,36 @@ do {									\
>  				CONFIG_ARM64_PAN));			\
>  } while (0)
>  
> +/*
> + * The Tag Check Flag (TCF) mode for MTE is per EL, hence TCF0
> + * affects EL0 and TCF affects EL1 irrespective of which TTBR is
> + * used.
> + * The kernel accesses TTBR0 usually with LDTR/STTR instructions
> + * when UAO is available, so these would act as EL0 accesses using
> + * TCF0.
> + * However futex.h code uses exclusives which would be executed as
> + * EL1, this can potentially cause a tag check fault even if the
> + * user disables TCF0.
> + *
> + * To address the problem we set the PSTATE.TCO bit in uaccess_enable()
> + * and reset it in uaccess_disable().
> + *
> + * The Tag check override (TCO) bit disables temporarily the tag checking
> + * preventing the issue.
> + */
>  static inline void uaccess_disable(void)
>  {
> +	asm volatile(ALTERNATIVE("nop", SET_PSTATE_TCO(0),
> +				 ARM64_MTE, CONFIG_KASAN_HW_TAGS));
> +
>  	__uaccess_disable(ARM64_HAS_PAN);
>  }
>  
>  static inline void uaccess_enable(void)
>  {
> +	asm volatile(ALTERNATIVE("nop", SET_PSTATE_TCO(1),
> +				 ARM64_MTE, CONFIG_KASAN_HW_TAGS));
> +
>  	__uaccess_enable(ARM64_HAS_PAN);
>  }

I think that's insufficient if CONFIG_ARM64_PAN is disabled. In the !PAN
case, the get/put_user() accessors use standard LDR/STR instructions
which would follow the TCF rather than TCF0 mode checking. However, they
don't use the above uaccess_disable/enable() functions.

The current user space support is affected as well but luckily we just
skip tag checking on the uaccess routines if !PAN since the kernel TCF
is 0. With the in-kernel MTE, TCF may be more strict than TCF0.

My suggestion is to simply make CONFIG_ARM64_MTE depend on (or select)
PAN. Architecturally this should work since PAN is required for ARMv8.1,
so present with any MTE implementation. This patch is on top of -next,
though it has a Fixes tag in 5.10:

--------------------------8<---------------------------
From ecc819804c1fb1ad498d7ced07e01e3b3e055a3f Mon Sep 17 00:00:00 2001
From: Catalin Marinas <catalin.marinas@arm.com>
Date: Thu, 3 Dec 2020 10:15:39 +0000
Subject: [PATCH] arm64: mte: Ensure CONFIG_ARM64_PAN is enabled with MTE

The uaccess routines like get/put_user() rely on the user TCF0 mode
setting for tag checking. However, if CONFIG_ARM64_PAN is disabled,
these routines would use the standard LDR/STR instructions and therefore
the kernel TCF mode. In 5.10, the kernel TCF==0, so no tag checking, but
this will change with the in-kernel MTE support.

Make ARM64_MTE depend on ARM64_PAN.

Fixes: 89b94df9dfb1 ("arm64: mte: Kconfig entry")
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 844d62df776c..f9eed3a5917e 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1673,6 +1673,8 @@ config ARM64_MTE
 	default y
 	depends on ARM64_AS_HAS_MTE && ARM64_TAGGED_ADDR_ABI
 	depends on AS_HAS_ARMV8_5
+	# Required for tag checking in the uaccess routines
+	depends on ARM64_PAN
 	select ARCH_USES_HIGH_VMA_FLAGS
 	help
 	  Memory Tagging (part of the ARMv8.5 Extensions) provides
