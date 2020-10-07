Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 733C4286105
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 16:16:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728583AbgJGOQM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 10:16:12 -0400
Received: from foss.arm.com ([217.140.110.172]:44596 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728177AbgJGOQM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 10:16:12 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4DC3E106F;
        Wed,  7 Oct 2020 07:16:11 -0700 (PDT)
Received: from [172.16.1.113] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A1B263F66B;
        Wed,  7 Oct 2020 07:16:09 -0700 (PDT)
Subject: Re: [PATCH 2/2] arm64: Add support for SMCCC TRNG firmware interface
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        linux-arm-kernel@lists.infradead.org
References: <20201006201808.37665-1-andre.przywara@arm.com>
 <20201006201808.37665-3-andre.przywara@arm.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <65057faa-d06b-6baf-4f12-9587cacbe3a9@arm.com>
Date:   Wed, 7 Oct 2020 15:16:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201006201808.37665-3-andre.przywara@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andre,

On 06/10/2020 21:18, Andre Przywara wrote:
> The ARM architected TRNG firmware interface, described in ARM spec
> DEN0098[1], defines an ARM SMCCC based interface to a true random number
> generator, provided by firmware.
> This can be discovered via the SMCCC >=v1.1 interface, and provides
> up to 192 bits of entropy per call.
> 
> Hook this SMC call into arm64's arch_get_random_*() implementation,
> coming to the rescue when the CPU does not implement the ARM v8.5 RNG
> system registers.
> 
> For the detection, we piggy back on the PSCI/SMCCC discovery (which gives
> us the conduit to use: hvc or smc), then try to call the
> ARM_SMCCC_TRNG_VERSION function, which returns -1 if this interface is
> not implemented.

>  arch/arm64/include/asm/archrandom.h | 83 +++++++++++++++++++++++++----
>  1 file changed, 73 insertions(+), 10 deletions(-)

> diff --git a/arch/arm64/include/asm/archrandom.h b/arch/arm64/include/asm/archrandom.h
> index ffb1a40d5475..b6c291c42a48 100644
> --- a/arch/arm64/include/asm/archrandom.h
> +++ b/arch/arm64/include/asm/archrandom.h
> @@ -7,6 +7,13 @@
>  #include <linux/bug.h>
>  #include <linux/kernel.h>
>  #include <asm/cpufeature.h>
> +#include <linux/arm-smccc.h>
> +
> +static enum smc_trng_status {
> +	SMC_TRNG_UNKNOWN,
> +	SMC_TRNG_NOT_SUPPORTED,
> +	SMC_TRNG_SUPPORTED
> +} smc_trng_status = SMC_TRNG_UNKNOWN;

Doesn't this static variable in a header file mean each file that includes this has its
own copy? Is that intentional?


Thanks,

James
