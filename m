Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1181D2CD3D4
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 11:38:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389042AbgLCKg4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 05:36:56 -0500
Received: from foss.arm.com ([217.140.110.172]:36554 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387840AbgLCKgz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 05:36:55 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B7987113E;
        Thu,  3 Dec 2020 02:36:09 -0800 (PST)
Received: from [10.37.8.53] (unknown [10.37.8.53])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 54BB33F575;
        Thu,  3 Dec 2020 02:36:06 -0800 (PST)
Subject: Re: [PATCH mm v11 27/42] arm64: mte: Add in-kernel tag fault handler
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
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
References: <cover.1606161801.git.andreyknvl@google.com>
 <ad31529b073e22840b7a2246172c2b67747ed7c4.1606161801.git.andreyknvl@google.com>
 <20201203102628.GB2224@gaia>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <c1e9c10a-c4d0-caf5-5501-6d676ac2abea@arm.com>
Date:   Thu, 3 Dec 2020 10:39:22 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201203102628.GB2224@gaia>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/3/20 10:26 AM, Catalin Marinas wrote:
>>  static inline void uaccess_enable(void)
>>  {
>> +	asm volatile(ALTERNATIVE("nop", SET_PSTATE_TCO(1),
>> +				 ARM64_MTE, CONFIG_KASAN_HW_TAGS));
>> +
>>  	__uaccess_enable(ARM64_HAS_PAN);
>>  }
> 
> I think that's insufficient if CONFIG_ARM64_PAN is disabled. In the !PAN
> case, the get/put_user() accessors use standard LDR/STR instructions
> which would follow the TCF rather than TCF0 mode checking. However, they
> don't use the above uaccess_disable/enable() functions.
> 
> The current user space support is affected as well but luckily we just
> skip tag checking on the uaccess routines if !PAN since the kernel TCF
> is 0. With the in-kernel MTE, TCF may be more strict than TCF0.
> 
> My suggestion is to simply make CONFIG_ARM64_MTE depend on (or select)
> PAN. Architecturally this should work since PAN is required for ARMv8.1,
> so present with any MTE implementation. This patch is on top of -next,
> though it has a Fixes tag in 5.10:
> 

Agreed, since PAN is required for ARMv8.1 we should not find any implementation
of MTE that lacks PAN.

> --------------------------8<---------------------------
> From ecc819804c1fb1ad498d7ced07e01e3b3e055a3f Mon Sep 17 00:00:00 2001
> From: Catalin Marinas <catalin.marinas@arm.com>
> Date: Thu, 3 Dec 2020 10:15:39 +0000
> Subject: [PATCH] arm64: mte: Ensure CONFIG_ARM64_PAN is enabled with MTE
> 
> The uaccess routines like get/put_user() rely on the user TCF0 mode
> setting for tag checking. However, if CONFIG_ARM64_PAN is disabled,
> these routines would use the standard LDR/STR instructions and therefore
> the kernel TCF mode. In 5.10, the kernel TCF==0, so no tag checking, but
> this will change with the in-kernel MTE support.
> 
> Make ARM64_MTE depend on ARM64_PAN.
> 
> Fixes: 89b94df9dfb1 ("arm64: mte: Kconfig entry")
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>

Reviewed-by: Vincenzo Frascino <vincenzo.frascino@arm.com>

> ---
>  arch/arm64/Kconfig | 2 ++
>  1 file changed, 2 insertions(+)
> 
> =======================================
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 844d62df776c..f9eed3a5917e 100644
> 
> --- a/arch/arm64/Kconfig
> 
> +++ b/arch/arm64/Kconfig
> 
> @@ -1673,6 +1673,8 @@
> 
>  config ARM64_MTE
> 
> » default·y
> » depends·on·ARM64_AS_HAS_MTE·&&·ARM64_TAGGED_ADDR_ABI
> » depends·on·AS_HAS_ARMV8_5
> +» #·Required·for·tag·checking·in·the·uaccess·routines
> +» depends·on·ARM64_PAN
> » select·ARCH_USES_HIGH_VMA_FLAGS
> » help
> » ··Memory·Tagging·(part·of·the·ARMv8.5·Extensions)·provides

-- 
Regards,
Vincenzo
