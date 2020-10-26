Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 161F2299340
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 18:02:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1787080AbgJZRCl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 13:02:41 -0400
Received: from foss.arm.com ([217.140.110.172]:45112 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1786718AbgJZRB4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 13:01:56 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 14F6B11FB;
        Mon, 26 Oct 2020 10:01:56 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.56.187])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EE0E73F719;
        Mon, 26 Oct 2020 10:01:53 -0700 (PDT)
Date:   Mon, 26 Oct 2020 17:01:51 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Will Deacon <will.deacon@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Steven Price <steven.price@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] arm64: avoid -Woverride-init warning
Message-ID: <20201026170151.GB42952@C02TD0UTHF1T.local>
References: <20201026160342.3705327-1-arnd@kernel.org>
 <20201026160342.3705327-3-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201026160342.3705327-3-arnd@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 26, 2020 at 05:03:30PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The icache_policy_str[] definition causes a warning when extra
> warning flags are enabled:
> 
> arch/arm64/kernel/cpuinfo.c:38:26: warning: initialized field overwritten [-Woverride-init]
>    38 |  [ICACHE_POLICY_VIPT]  = "VIPT",
>       |                          ^~~~~~
> arch/arm64/kernel/cpuinfo.c:38:26: note: (near initialization for 'icache_policy_str[2]')
> arch/arm64/kernel/cpuinfo.c:39:26: warning: initialized field overwritten [-Woverride-init]
>    39 |  [ICACHE_POLICY_PIPT]  = "PIPT",
>       |                          ^~~~~~
> arch/arm64/kernel/cpuinfo.c:39:26: note: (near initialization for 'icache_policy_str[3]')
> arch/arm64/kernel/cpuinfo.c:40:27: warning: initialized field overwritten [-Woverride-init]
>    40 |  [ICACHE_POLICY_VPIPT]  = "VPIPT",
>       |                           ^~~~~~~
> arch/arm64/kernel/cpuinfo.c:40:27: note: (near initialization for 'icache_policy_str[0]')
> 
> There is no real need for the default initializer here, as printing a
> NULL string is harmless. Rewrite the logic to have an explicit
> reserved value for the only one that uses the default value.
> 
> This partially reverts the commit that removed ICACHE_POLICY_AIVIVT.
> 
> Fixes: 155433cb365e ("arm64: cache: Remove support for ASID-tagged VIVT I-caches")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

> ---
>  arch/arm64/include/asm/cache.h | 1 +
>  arch/arm64/kernel/cpuinfo.c    | 5 +++--
>  2 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/cache.h b/arch/arm64/include/asm/cache.h
> index a4d1b5f771f6..16e1e16e7e61 100644
> --- a/arch/arm64/include/asm/cache.h
> +++ b/arch/arm64/include/asm/cache.h
> @@ -24,6 +24,7 @@
>  #define CTR_L1IP(ctr)		(((ctr) >> CTR_L1IP_SHIFT) & CTR_L1IP_MASK)
>  
>  #define ICACHE_POLICY_VPIPT	0
> +#define ICACHE_POLICY_RESERVED	1
>  #define ICACHE_POLICY_VIPT	2
>  #define ICACHE_POLICY_PIPT	3
>  
> diff --git a/arch/arm64/kernel/cpuinfo.c b/arch/arm64/kernel/cpuinfo.c
> index 6a7bb3729d60..b63269c7fcdb 100644
> --- a/arch/arm64/kernel/cpuinfo.c
> +++ b/arch/arm64/kernel/cpuinfo.c
> @@ -34,10 +34,10 @@ DEFINE_PER_CPU(struct cpuinfo_arm64, cpu_data);
>  static struct cpuinfo_arm64 boot_cpu_data;
>  
>  static const char *icache_policy_str[] = {
> -	[0 ... ICACHE_POLICY_PIPT]	= "RESERVED/UNKNOWN",
> +	[ICACHE_POLICY_VPIPT]		= "VPIPT",
> +	[ICACHE_POLICY_RESERVED]	= "RESERVED/UNKNOWN",
>  	[ICACHE_POLICY_VIPT]		= "VIPT",
>  	[ICACHE_POLICY_PIPT]		= "PIPT",
> -	[ICACHE_POLICY_VPIPT]		= "VPIPT",
>  };

Given it's not clear that ICACHE_POLICY_PIPT is the max value, I agree
this is a bit cleaner. I don't have a nicer way of making this clearer.

[...]

> @@ -335,6 +335,7 @@ static void cpuinfo_detect_icache_policy(struct cpuinfo_arm64 *info)
>  		set_bit(ICACHEF_VPIPT, &__icache_flags);
>  		break;
>  	default:
> +	case ICACHE_POLICY_RESERVED:
>  	case ICACHE_POLICY_VIPT:
>  		/* Assume aliasing */
>  		set_bit(ICACHEF_ALIASING, &__icache_flags);
>
... but it's a bit weird to have both the default and
ICACHE_POLICY_RESERVED cases. If we get rid of the default case, does
any compiler warn? I suspect the masking in CTR_L1IP() might be
sufficient to let the compiler see we've handled all cases.

Thanks,
Mark.
