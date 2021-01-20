Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B8392FD398
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 16:14:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390865AbhATPLZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 10:11:25 -0500
Received: from foss.arm.com ([217.140.110.172]:38872 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390908AbhATPDT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 10:03:19 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C67B231B;
        Wed, 20 Jan 2021 07:02:33 -0800 (PST)
Received: from [10.57.39.58] (unknown [10.57.39.58])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 215003F68F;
        Wed, 20 Jan 2021 07:02:31 -0800 (PST)
Subject: Re: [PATCH 2/2] Revert "iommu/arm-smmu-v3: Don't reserve
 implementation defined register space"
To:     Zhen Lei <thunder.leizhen@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        iommu <iommu@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Cc:     Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Neil Leeder <nleeder@codeaurora.org>,
        Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
References: <20210119015951.1042-1-thunder.leizhen@huawei.com>
 <20210119015951.1042-3-thunder.leizhen@huawei.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <888312dc-85b7-4d5e-f264-bbdd9e3638f6@arm.com>
Date:   Wed, 20 Jan 2021 15:02:30 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210119015951.1042-3-thunder.leizhen@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-01-19 01:59, Zhen Lei wrote:
> This reverts commit 52f3fab0067d6fa9e99c1b7f63265dd48ca76046.
> 
> This problem has been fixed by another patch. The original method had side
> effects, it was not mapped to the user-specified resource size. The code
> will become more complex when ECMDQ is supported later.

FWIW I don't think that's a significant issue either way - there could 
be any number of imp-def pages between SMMU page 0 and the ECMDQ control 
pages, so it will still be logical to map them as another separate thing 
anyway.

Robin.

> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 32 ++++-------------------------
>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  3 ---
>   2 files changed, 4 insertions(+), 31 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 8ca7415d785d9bf..477f473842e5272 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -91,8 +91,9 @@ struct arm_smmu_option_prop {
>   static inline void __iomem *arm_smmu_page1_fixup(unsigned long offset,
>   						 struct arm_smmu_device *smmu)
>   {
> -	if (offset > SZ_64K)
> -		return smmu->page1 + offset - SZ_64K;
> +	if ((offset > SZ_64K) &&
> +	    (smmu->options & ARM_SMMU_OPT_PAGE0_REGS_ONLY))
> +		offset -= SZ_64K;
>   
>   	return smmu->base + offset;
>   }
> @@ -3486,18 +3487,6 @@ static int arm_smmu_set_bus_ops(struct iommu_ops *ops)
>   	return err;
>   }
>   
> -static void __iomem *arm_smmu_ioremap(struct device *dev, resource_size_t start,
> -				      resource_size_t size)
> -{
> -	struct resource res = {
> -		.flags = IORESOURCE_MEM,
> -		.start = start,
> -		.end = start + size - 1,
> -	};
> -
> -	return devm_ioremap_resource(dev, &res);
> -}
> -
>   static int arm_smmu_device_probe(struct platform_device *pdev)
>   {
>   	int irq, ret;
> @@ -3533,23 +3522,10 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
>   	}
>   	ioaddr = res->start;
>   
> -	/*
> -	 * Don't map the IMPLEMENTATION DEFINED regions, since they may contain
> -	 * the PMCG registers which are reserved by the PMU driver.
> -	 */
> -	smmu->base = arm_smmu_ioremap(dev, ioaddr, ARM_SMMU_REG_SZ);
> +	smmu->base = devm_ioremap_resource(dev, res);
>   	if (IS_ERR(smmu->base))
>   		return PTR_ERR(smmu->base);
>   
> -	if (arm_smmu_resource_size(smmu) > SZ_64K) {
> -		smmu->page1 = arm_smmu_ioremap(dev, ioaddr + SZ_64K,
> -					       ARM_SMMU_REG_SZ);
> -		if (IS_ERR(smmu->page1))
> -			return PTR_ERR(smmu->page1);
> -	} else {
> -		smmu->page1 = smmu->base;
> -	}
> -
>   	/* Interrupt lines */
>   
>   	irq = platform_get_irq_byname_optional(pdev, "combined");
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> index 96c2e9565e00282..0c3090c60840c22 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> @@ -152,8 +152,6 @@
>   #define ARM_SMMU_PRIQ_IRQ_CFG1		0xd8
>   #define ARM_SMMU_PRIQ_IRQ_CFG2		0xdc
>   
> -#define ARM_SMMU_REG_SZ			0xe00
> -
>   /* Common MSI config fields */
>   #define MSI_CFG0_ADDR_MASK		GENMASK_ULL(51, 2)
>   #define MSI_CFG2_SH			GENMASK(5, 4)
> @@ -584,7 +582,6 @@ struct arm_smmu_strtab_cfg {
>   struct arm_smmu_device {
>   	struct device			*dev;
>   	void __iomem			*base;
> -	void __iomem			*page1;
>   
>   #define ARM_SMMU_FEAT_2_LVL_STRTAB	(1 << 0)
>   #define ARM_SMMU_FEAT_2_LVL_CDTAB	(1 << 1)
> 
