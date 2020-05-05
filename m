Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1A7D1C51C3
	for <lists+linux-kernel@lfdr.de>; Tue,  5 May 2020 11:20:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728667AbgEEJUH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 May 2020 05:20:07 -0400
Received: from foss.arm.com ([217.140.110.172]:35376 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728650AbgEEJUH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 05:20:07 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A5F2A30E;
        Tue,  5 May 2020 02:20:06 -0700 (PDT)
Received: from [10.37.12.10] (unknown [10.37.12.10])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EC9973F305;
        Tue,  5 May 2020 02:20:02 -0700 (PDT)
Subject: Re: [PATCH V3 11/16] arm64/cpufeature: Add remaining feature bits in
 ID_AA64PFR1 register
To:     anshuman.khandual@arm.com, linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org
References: <1588426445-24344-1-git-send-email-anshuman.khandual@arm.com>
 <1588426445-24344-12-git-send-email-anshuman.khandual@arm.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <4c6e9f6e-fffa-8fdf-ad1a-f0c6514c3571@arm.com>
Date:   Tue, 5 May 2020 10:24:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1588426445-24344-12-git-send-email-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/02/2020 02:34 PM, Anshuman Khandual wrote:
> Enable the following features bits in ID_AA64PFR1 register as per ARM DDI
> 0487F.a specification.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> 
> Suggested-by: Will Deacon <will@kernel.org>
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
>   arch/arm64/include/asm/sysreg.h | 4 ++++
>   arch/arm64/kernel/cpufeature.c  | 4 ++++
>   2 files changed, 8 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
> index c93ea6613f51..f1c0d874220a 100644
> --- a/arch/arm64/include/asm/sysreg.h
> +++ b/arch/arm64/include/asm/sysreg.h
> @@ -666,7 +666,11 @@
>   #define ID_AA64PFR0_EL0_32BIT_64BIT	0x2
>   
>   /* id_aa64pfr1 */
> +#define ID_AA64PFR1_MPAMFRAC_SHIFT	16
> +#define ID_AA64PFR1_RASFRAC_SHIFT	12
> +#define ID_AA64PFR1_MTE_SHIFT		8
>   #define ID_AA64PFR1_SSBS_SHIFT		4
> +#define ID_AA64PFR1_BT_SHIFT		0
>   
>   #define ID_AA64PFR1_SSBS_PSTATE_NI	0
>   #define ID_AA64PFR1_SSBS_PSTATE_ONLY	1
> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index f5a39e040804..181e09d62147 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -233,7 +233,11 @@ static const struct arm64_ftr_bits ftr_id_aa64pfr0[] = {
>   };
>   
>   static const struct arm64_ftr_bits ftr_id_aa64pfr1[] = {
> +	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64PFR1_MPAMFRAC_SHIFT, 4, 0),
> +	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64PFR1_RASFRAC_SHIFT, 4, 0),

These should be hidden as well.

> +	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64PFR1_MTE_SHIFT, 4, 0),
>   	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64PFR1_SSBS_SHIFT, 4, ID_AA64PFR1_SSBS_PSTATE_NI),
> +	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64PFR1_BT_SHIFT, 4, 0),

I would say remove the MTE, BTI fields for now. As they must be VISIBLE, 
but with the kernel support for these merged. They will be added with 
their respective series.

Suzuki
