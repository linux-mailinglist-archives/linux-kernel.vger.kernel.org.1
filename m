Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B86E2B03B5
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 12:20:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727964AbgKLLUP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 06:20:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:40362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727865AbgKLLUL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 06:20:11 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8D8DC21D40;
        Thu, 12 Nov 2020 11:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605180010;
        bh=K8snTlzRrBmCFb3kcN8jLGjUTIdHXOt33Jd0fecxr4g=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=eZ+vrSimKFesca0wJwgzMJ8ZkL/HxvQN5r3Cen8yfqrxZlfrAwmEcmDo2TKcJZE9+
         7kgR/DVURdNy2KRbVFtbrK+nV+XFGksDkpdo5YLxVvx7xj8L1VWE6rndL6M+7v2uYg
         lfZdQWkZJN9TLtm7FbCbfu/eHqp3cKe8nLkyqy/U=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1kdAe8-00A17J-CY; Thu, 12 Nov 2020 11:20:08 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 12 Nov 2020 11:20:08 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        LAKML <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 1/2] arm64: cpufeature: Add GIC CPUIF v4.1 detection
In-Reply-To: <20201111162841.3151-2-lorenzo.pieralisi@arm.com>
References: <20201111162841.3151-1-lorenzo.pieralisi@arm.com>
 <20201111162841.3151-2-lorenzo.pieralisi@arm.com>
User-Agent: Roundcube Webmail/1.4.9
Message-ID: <89291c496e6e868c442f5763db53d22d@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: lorenzo.pieralisi@arm.com, linux-kernel@vger.kernel.org, will@kernel.org, catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-11-11 16:28, Lorenzo Pieralisi wrote:
> GIC v4.1 introduced changes to the GIC CPU interface; systems that
> integrate CPUs that do not support GIC v4.1 features (as reported in 
> the
> ID_AA64PFR0_EL1.GIC bitfield) and a GIC v4.1 controller must disable in
> software virtual SGIs support since the CPUIF and GIC controller 
> version
> mismatch results in CONSTRAINED UNPREDICTABLE behaviour at 
> architectural
> level.
> 
> Add a cpufeature and related capability to detect GIC v4.1 CPUIF
> features so that the GIC driver can probe it to detect GIC CPUIF
> hardware configuration and take action accordingly.
> 
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Marc Zyngier <maz@kernel.org>
> ---
>  arch/arm64/include/asm/cpucaps.h |  3 ++-
>  arch/arm64/kernel/cpufeature.c   | 10 ++++++++++
>  2 files changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/include/asm/cpucaps.h 
> b/arch/arm64/include/asm/cpucaps.h
> index 42868dbd29fd..35ef0319f422 100644
> --- a/arch/arm64/include/asm/cpucaps.h
> +++ b/arch/arm64/include/asm/cpucaps.h
> @@ -65,7 +65,8 @@
>  #define ARM64_HAS_ARMv8_4_TTL			55
>  #define ARM64_HAS_TLB_RANGE			56
>  #define ARM64_MTE				57
> +#define ARM64_HAS_GIC_CPUIF_VSGI		58
> 
> -#define ARM64_NCAPS				58
> +#define ARM64_NCAPS				59
> 
>  #endif /* __ASM_CPUCAPS_H */
> diff --git a/arch/arm64/kernel/cpufeature.c 
> b/arch/arm64/kernel/cpufeature.c
> index dcc165b3fc04..9eabbaddfe5e 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -2136,6 +2136,16 @@ static const struct arm64_cpu_capabilities
> arm64_features[] = {
>  		.cpu_enable = cpu_enable_mte,
>  	},
>  #endif /* CONFIG_ARM64_MTE */
> +	{
> +		.desc = "GIC CPUIF virtual SGI",

nit: that's not really what this feature is. It only means that the
sysreg interface complies to v4.1. Which on its own is totally rubbish,
because the sysreg don't change behaviour between 3.0/4.0 and 4.1.

> +		.capability = ARM64_HAS_GIC_CPUIF_VSGI,
> +		.type = ARM64_CPUCAP_BOOT_CPU_FEATURE,
> +		.matches = has_cpuid_feature,
> +		.sys_reg = SYS_ID_AA64PFR0_EL1,
> +		.field_pos = ID_AA64PFR0_GIC_SHIFT,
> +		.sign = FTR_UNSIGNED,
> +		.min_field_value = 3,
> +	},

Do we really need a new cap for that? Or can we rely on simply looking
at the sanitised feature set? I'm not overly keen on advertising a 
feature
at CPU boot time if we discover later on that we cannot use it because 
all
we have in a non-4.1 GIC.

Another thing is that we currently assume that *all* CPUs will be the 
same
at the point where we setup the GIC (we only have a single CPU booted at 
that
point).

         M.
-- 
Jazz is not dead. It just smells funny...
