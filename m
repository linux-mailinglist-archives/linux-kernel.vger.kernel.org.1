Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 318382FFAAB
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 03:51:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726560AbhAVCvW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 21:51:22 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:11425 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726189AbhAVCvO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 21:51:14 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4DMNyK6wpBzj9h7;
        Fri, 22 Jan 2021 10:49:29 +0800 (CST)
Received: from [127.0.0.1] (10.174.176.220) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.498.0; Fri, 22 Jan 2021
 10:50:18 +0800
Subject: Re: [PATCH 2/2] Revert "iommu/arm-smmu-v3: Don't reserve
 implementation defined register space"
To:     Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>,
        "Mark Rutland" <mark.rutland@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        iommu <iommu@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
References: <20210119015951.1042-1-thunder.leizhen@huawei.com>
 <20210119015951.1042-3-thunder.leizhen@huawei.com>
 <888312dc-85b7-4d5e-f264-bbdd9e3638f6@arm.com>
 <ca469958-179d-02c5-b147-0a0ff951d503@huawei.com>
 <72c979bd-501f-df9b-7bca-02b8c11d3860@arm.com>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <cfa002c0-593a-b4e8-7015-224726d73504@huawei.com>
Date:   Fri, 22 Jan 2021 10:50:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <72c979bd-501f-df9b-7bca-02b8c11d3860@arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.220]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/1/21 20:50, Robin Murphy wrote:
> On 2021-01-21 02:04, Leizhen (ThunderTown) wrote:
>>
>>
>> On 2021/1/20 23:02, Robin Murphy wrote:
>>> On 2021-01-19 01:59, Zhen Lei wrote:
>>>> This reverts commit 52f3fab0067d6fa9e99c1b7f63265dd48ca76046.
>>>>
>>>> This problem has been fixed by another patch. The original method had side
>>>> effects, it was not mapped to the user-specified resource size. The code
>>>> will become more complex when ECMDQ is supported later.
>>>
>>> FWIW I don't think that's a significant issue either way - there could be any number of imp-def pages between SMMU page 0 and the ECMDQ control pages, so it will still be logical to map them as another separate thing anyway.
>>
>> Yes, so now I'm thinking of preserving the SMMUv3 resources and eliminating the imp-def area. Then use another devm_ioremap() to cover the entire resource，assign it to smmu->base.
>> Otherwise, a base pointer needs to be defined for each separated register space，or call a function to convert each time.
> 
> But we'll almost certainly want to maintain a pointer to start of the ECMDQ control page block anyway, since that's not fixed relative to smmu->base. Therefore what's the harm in handling that via a dedicated mapping, once we've determined that we *do* intend to use ECMDQs? Otherwise we end up with in the complicated dance of trying to map "everything" up-front in order to be able to read the ID registers to determine what the actual extent of "everything" is supposed to be.

Currently, we only mapped the first 0xe00 size, so the SMMU_CMDQ_CONTROL_PAGE_XXXn registers space at offset 0x4000 should be mapped again.
The size of this ECMDQ resource is not fixed, depending on SMMU_IDR6.CMDQ_CONTROL_PAGE_LOG2NUMQ.
Processing its resource reservation to avoid resource conflict with PMCG is a bit more complicated.

> 
> (also this reminds me that I was going to remove arm_smmu_page1_fixup() entirely - I'd totally forgotten about that...)

Ah, that patch you made is so clever.

> 
> Robin.
> 
>>>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
>>>> ---
>>>>    drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 32 ++++-------------------------
>>>>    drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  3 ---
>>>>    2 files changed, 4 insertions(+), 31 deletions(-)
>>>>
>>>> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>>>> index 8ca7415d785d9bf..477f473842e5272 100644
>>>> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>>>> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>>>> @@ -91,8 +91,9 @@ struct arm_smmu_option_prop {
>>>>    static inline void __iomem *arm_smmu_page1_fixup(unsigned long offset,
>>>>                             struct arm_smmu_device *smmu)
>>>>    {
>>>> -    if (offset > SZ_64K)
>>>> -        return smmu->page1 + offset - SZ_64K;
>>>> +    if ((offset > SZ_64K) &&
>>>> +        (smmu->options & ARM_SMMU_OPT_PAGE0_REGS_ONLY))
>>>> +        offset -= SZ_64K;
>>>>          return smmu->base + offset;
>>>>    }
>>>> @@ -3486,18 +3487,6 @@ static int arm_smmu_set_bus_ops(struct iommu_ops *ops)
>>>>        return err;
>>>>    }
>>>>    -static void __iomem *arm_smmu_ioremap(struct device *dev, resource_size_t start,
>>>> -                      resource_size_t size)
>>>> -{
>>>> -    struct resource res = {
>>>> -        .flags = IORESOURCE_MEM,
>>>> -        .start = start,
>>>> -        .end = start + size - 1,
>>>> -    };
>>>> -
>>>> -    return devm_ioremap_resource(dev, &res);
>>>> -}
>>>> -
>>>>    static int arm_smmu_device_probe(struct platform_device *pdev)
>>>>    {
>>>>        int irq, ret;
>>>> @@ -3533,23 +3522,10 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
>>>>        }
>>>>        ioaddr = res->start;
>>>>    -    /*
>>>> -     * Don't map the IMPLEMENTATION DEFINED regions, since they may contain
>>>> -     * the PMCG registers which are reserved by the PMU driver.
>>>> -     */
>>>> -    smmu->base = arm_smmu_ioremap(dev, ioaddr, ARM_SMMU_REG_SZ);
>>>> +    smmu->base = devm_ioremap_resource(dev, res);
>>>>        if (IS_ERR(smmu->base))
>>>>            return PTR_ERR(smmu->base);
>>>>    -    if (arm_smmu_resource_size(smmu) > SZ_64K) {
>>>> -        smmu->page1 = arm_smmu_ioremap(dev, ioaddr + SZ_64K,
>>>> -                           ARM_SMMU_REG_SZ);
>>>> -        if (IS_ERR(smmu->page1))
>>>> -            return PTR_ERR(smmu->page1);
>>>> -    } else {
>>>> -        smmu->page1 = smmu->base;
>>>> -    }
>>>> -
>>>>        /* Interrupt lines */
>>>>          irq = platform_get_irq_byname_optional(pdev, "combined");
>>>> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
>>>> index 96c2e9565e00282..0c3090c60840c22 100644
>>>> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
>>>> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
>>>> @@ -152,8 +152,6 @@
>>>>    #define ARM_SMMU_PRIQ_IRQ_CFG1        0xd8
>>>>    #define ARM_SMMU_PRIQ_IRQ_CFG2        0xdc
>>>>    -#define ARM_SMMU_REG_SZ            0xe00
>>>> -
>>>>    /* Common MSI config fields */
>>>>    #define MSI_CFG0_ADDR_MASK        GENMASK_ULL(51, 2)
>>>>    #define MSI_CFG2_SH            GENMASK(5, 4)
>>>> @@ -584,7 +582,6 @@ struct arm_smmu_strtab_cfg {
>>>>    struct arm_smmu_device {
>>>>        struct device            *dev;
>>>>        void __iomem            *base;
>>>> -    void __iomem            *page1;
>>>>      #define ARM_SMMU_FEAT_2_LVL_STRTAB    (1 << 0)
>>>>    #define ARM_SMMU_FEAT_2_LVL_CDTAB    (1 << 1)
>>>>
>>>
>>> .
>>>
>>
> 
> .
> 

