Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07C542A4569
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 13:44:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729011AbgKCMoh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 07:44:37 -0500
Received: from foss.arm.com ([217.140.110.172]:48238 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728993AbgKCMoh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 07:44:37 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3EA3A106F;
        Tue,  3 Nov 2020 04:44:36 -0800 (PST)
Received: from C02TD0UTHF1T.local (unknown [10.57.57.89])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 46A003F718;
        Tue,  3 Nov 2020 04:44:33 -0800 (PST)
Date:   Tue, 3 Nov 2020 12:44:31 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        Kees Cook <keescook@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/4] arm64: cpufeatures: Add capability for LDAPR
 instruction
Message-ID: <20201103124431.GB40454@C02TD0UTHF1T.local>
References: <20201103121721.5166-1-will@kernel.org>
 <20201103121721.5166-3-will@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201103121721.5166-3-will@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 03, 2020 at 12:17:19PM +0000, Will Deacon wrote:
> Armv8.3 introduced the LDAPR instruction, which provides weaker memory
> ordering semantics than LDARi (RCpc vs RCsc). Generally, we provide an
> RCsc implementation when implementing the Linux memory model, but LDAPR
> can be used as a useful alternative to dependency ordering, particularly
> when the compiler is capable of breaking the dependencies.
> 
> Since LDAPR is not available on all CPUs, add a cpufeature to detect it at
> runtime and allow the instruction to be used with alternative code
> patching.
> 
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Signed-off-by: Will Deacon <will@kernel.org>

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> ---
>  arch/arm64/Kconfig               |  3 +++
>  arch/arm64/include/asm/cpucaps.h |  3 ++-
>  arch/arm64/kernel/cpufeature.c   | 10 ++++++++++
>  3 files changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 1d466addb078..356c50b0447f 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -1388,6 +1388,9 @@ config ARM64_PAN
>  	 The feature is detected at runtime, and will remain as a 'nop'
>  	 instruction if the cpu does not implement the feature.
>  
> +config AS_HAS_LDAPR
> +	def_bool $(as-instr,.arch_extension rcpc)
> +
>  config ARM64_LSE_ATOMICS
>  	bool
>  	default ARM64_USE_LSE_ATOMICS
> diff --git a/arch/arm64/include/asm/cpucaps.h b/arch/arm64/include/asm/cpucaps.h
> index e7d98997c09c..64ea0bb9f420 100644
> --- a/arch/arm64/include/asm/cpucaps.h
> +++ b/arch/arm64/include/asm/cpucaps.h
> @@ -66,7 +66,8 @@
>  #define ARM64_HAS_TLB_RANGE			56
>  #define ARM64_MTE				57
>  #define ARM64_WORKAROUND_1508412		58
> +#define ARM64_HAS_LDAPR				59
>  
> -#define ARM64_NCAPS				59
> +#define ARM64_NCAPS				60
>  
>  #endif /* __ASM_CPUCAPS_H */
> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index dcc165b3fc04..b7b6804cb931 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -2136,6 +2136,16 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
>  		.cpu_enable = cpu_enable_mte,
>  	},
>  #endif /* CONFIG_ARM64_MTE */
> +	{
> +		.desc = "RCpc load-acquire (LDAPR)",
> +		.capability = ARM64_HAS_LDAPR,
> +		.type = ARM64_CPUCAP_SYSTEM_FEATURE,
> +		.sys_reg = SYS_ID_AA64ISAR1_EL1,
> +		.sign = FTR_UNSIGNED,
> +		.field_pos = ID_AA64ISAR1_LRCPC_SHIFT,
> +		.matches = has_cpuid_feature,
> +		.min_field_value = 1,
> +	},
>  	{},
>  };
>  
> -- 
> 2.29.1.341.ge80a0c044ae-goog
> 
