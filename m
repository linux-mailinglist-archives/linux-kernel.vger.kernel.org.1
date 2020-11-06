Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3DE72A988C
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 16:30:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727562AbgKFPaG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 10:30:06 -0500
Received: from disco-boy.misterjones.org ([51.254.78.96]:43348 "EHLO
        disco-boy.misterjones.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726812AbgKFPaF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 10:30:05 -0500
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94)
        (envelope-from <maz@misterjones.org>)
        id 1kb3gc-008Eeb-Vr; Fri, 06 Nov 2020 15:29:59 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 06 Nov 2020 15:29:58 +0000
From:   Marc Zyngier <maz@misterjones.org>
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 3/5] ARM: implement support for SMCCC TRNG entropy
 source
In-Reply-To: <20201105125656.25259-4-andre.przywara@arm.com>
References: <20201105125656.25259-1-andre.przywara@arm.com>
 <20201105125656.25259-4-andre.przywara@arm.com>
User-Agent: Roundcube Webmail/1.4.9
Message-ID: <7b36daa49c78d60dc788bbb3c9c1bdaa@misterjones.org>
X-Sender: maz@misterjones.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: andre.przywara@arm.com, will@kernel.org, catalin.marinas@arm.com, ardb@kernel.org, linux@armlinux.org.uk, lorenzo.pieralisi@arm.com, linus.walleij@linaro.org, linux-kernel@vger.kernel.org, broonie@kernel.org, sudeep.holla@arm.com, kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org
X-SA-Exim-Mail-From: maz@misterjones.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-11-05 12:56, Andre Przywara wrote:
> From: Ard Biesheuvel <ardb@kernel.org>
> 
> Implement arch_get_random_seed_*() for ARM based on the firmware
> or hypervisor provided entropy source described in ARM DEN0098.
> 
> This will make the kernel's random number generator consume entropy
> provided by this interface, at early boot, and periodically at
> runtime when reseeding.
> 
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Russell King <linux@armlinux.org.uk>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> [Andre: rework to be initialised by the SMCCC firmware driver]
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  arch/arm/Kconfig                  |  4 ++
>  arch/arm/include/asm/archrandom.h | 64 +++++++++++++++++++++++++++++++
>  2 files changed, 68 insertions(+)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index fe2f17eb2b50..06fda4f954fd 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -1667,6 +1667,10 @@ config STACKPROTECTOR_PER_TASK
>  	  Enable this option to switch to a different method that uses a
>  	  different canary value for each task.
> 
> +config ARCH_RANDOM
> +	def_bool y
> +	depends on HAVE_ARM_SMCCC
> +
>  endmenu
> 
>  menu "Boot options"
> diff --git a/arch/arm/include/asm/archrandom.h
> b/arch/arm/include/asm/archrandom.h
> index a8e84ca5c2ee..f3e96a5b65f8 100644
> --- a/arch/arm/include/asm/archrandom.h
> +++ b/arch/arm/include/asm/archrandom.h
> @@ -2,9 +2,73 @@
>  #ifndef _ASM_ARCHRANDOM_H
>  #define _ASM_ARCHRANDOM_H
> 
> +#ifdef CONFIG_ARCH_RANDOM
> +
> +#include <linux/arm-smccc.h>
> +#include <linux/kernel.h>
> +
> +#define ARM_SMCCC_TRNG_MIN_VERSION     0x10000UL
> +
> +extern bool smccc_trng_available;
> +
> +static inline bool __init smccc_probe_trng(void)
> +{
> +	struct arm_smccc_res res;
> +
> +	arm_smccc_1_1_invoke(ARM_SMCCC_TRNG_VERSION, &res);
> +	if ((s32)res.a0 < 0)
> +		return false;
> +	if (res.a0 >= ARM_SMCCC_TRNG_MIN_VERSION) {
> +		/* double check that the 32-bit flavor is available */
> +		arm_smccc_1_1_invoke(ARM_SMCCC_TRNG_FEATURES,
> +				     ARM_SMCCC_TRNG_RND32,
> +				     &res);
> +		if ((s32)res.a0 >= 0)
> +			return true;
> +	}
> +
> +	return false;
> +}
> +
> +static inline bool __must_check arch_get_random_long(unsigned long *v)
> +{
> +	return false;
> +}
> +
> +static inline bool __must_check arch_get_random_int(unsigned int *v)
> +{
> +	return false;
> +}
> +
> +static inline bool __must_check arch_get_random_seed_long(unsigned 
> long *v)
> +{
> +	struct arm_smccc_res res;
> +
> +	if (smccc_trng_available) {
> +		arm_smccc_1_1_invoke(ARM_SMCCC_TRNG_RND32, 8 * sizeof(*v), &res);
> +
> +		if (res.a0 != 0)
> +			return false;
> +
> +		*v = res.a3;
> +		return true;
> +	}
> +
> +	return false;
> +}
> +
> +static inline bool __must_check arch_get_random_seed_int(unsigned int 
> *v)
> +{
> +	return arch_get_random_seed_long((unsigned long *)v);

I don't think this cast is safe. At least not on 64bit.

         M.
-- 
Who you jivin' with that Cosmik Debris?
