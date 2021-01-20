Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9014E2FCDFD
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 11:50:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731570AbhATKPY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 05:15:24 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:11419 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731294AbhATJ1e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 04:27:34 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4DLKrP3nGLzj87l;
        Wed, 20 Jan 2021 17:25:41 +0800 (CST)
Received: from [127.0.0.1] (10.174.176.220) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.498.0; Wed, 20 Jan 2021
 17:26:28 +0800
Subject: Re: [PATCH 1/2] perf/smmuv3: Don't reserve the register space that
 overlaps with the SMMUv3
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
To:     Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>,
        "Mark Rutland" <mark.rutland@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        iommu <iommu@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Neil Leeder <nleeder@codeaurora.org>,
        Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
References: <20210119015951.1042-1-thunder.leizhen@huawei.com>
 <20210119015951.1042-2-thunder.leizhen@huawei.com>
 <30665cd6-b438-1d1d-7445-9e45e240f79a@arm.com>
 <a2d7d94c-8e4e-d91d-8587-7a5b3594b4ca@huawei.com>
Message-ID: <9ad3c863-ec80-e177-4d11-24d1f706b4af@huawei.com>
Date:   Wed, 20 Jan 2021 17:26:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <a2d7d94c-8e4e-d91d-8587-7a5b3594b4ca@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.220]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/1/20 11:37, Leizhen (ThunderTown) wrote:
> 
> 
> On 2021/1/19 20:32, Robin Murphy wrote:
>> On 2021-01-19 01:59, Zhen Lei wrote:
>>> Some SMMUv3 implementation embed the Perf Monitor Group Registers (PMCG)
>>> inside the first 64kB region of the SMMU. Since SMMU and PMCG are managed
>>> by two separate drivers, and this driver depends on ARM_SMMU_V3, so the
>>> SMMU driver reserves the corresponding resource first, this driver should
>>> not reserve the corresponding resource again. Otherwise, a resource
>>> reservation conflict is reported during boot.
>>>
>>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
>>> ---
>>>   drivers/perf/arm_smmuv3_pmu.c | 42 ++++++++++++++++++++++++++++++++++++++++--
>>>   1 file changed, 40 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/perf/arm_smmuv3_pmu.c b/drivers/perf/arm_smmuv3_pmu.c
>>> index 74474bb322c3f26..dcce085431c6ce8 100644
>>> --- a/drivers/perf/arm_smmuv3_pmu.c
>>> +++ b/drivers/perf/arm_smmuv3_pmu.c
>>> @@ -761,6 +761,44 @@ static void smmu_pmu_get_acpi_options(struct smmu_pmu *smmu_pmu)
>>>       dev_notice(smmu_pmu->dev, "option mask 0x%x\n", smmu_pmu->options);
>>>   }
>>>   +static void __iomem *
>>> +smmu_pmu_get_and_ioremap_resource(struct platform_device *pdev,
>>> +                  unsigned int index,
>>> +                  struct resource **out_res)
>>> +{
>>> +    int ret;
>>> +    void __iomem *base;
>>> +    struct resource *res;
>>> +
>>> +    res = platform_get_resource(pdev, IORESOURCE_MEM, index);
>>> +    if (!res) {
>>> +        dev_err(&pdev->dev, "invalid resource\n");
>>> +        return IOMEM_ERR_PTR(-EINVAL);
>>> +    }
>>> +    if (out_res)
>>> +        *out_res = res;
>>> +
>>> +    ret = region_intersects(res->start, resource_size(res),
>>> +                IORESOURCE_MEM, IORES_DESC_NONE);
>>> +    if (ret == REGION_INTERSECTS) {
>>> +        /*
>>> +         * The resource has already been reserved by the SMMUv3 driver.
>>> +         * Don't reserve it again, just do devm_ioremap().
>>> +         */
>>> +        base = devm_ioremap(&pdev->dev, res->start, resource_size(res));
>>> +    } else {
>>> +        /*
>>> +         * The resource may have not been reserved by any driver, or
>>> +         * has been reserved but not type IORESOURCE_MEM. In the latter
>>> +         * case, devm_ioremap_resource() reports a conflict and returns
>>> +         * IOMEM_ERR_PTR(-EBUSY).
>>> +         */
>>> +        base = devm_ioremap_resource(&pdev->dev, res);
>>> +    }
>>
>> What if the PMCG driver simply happens to probe first?
> 
> There are 4 cases:
> 1) ARM_SMMU_V3=m, ARM_SMMU_V3_PMU=y
>    It's not allowed. Becase: ARM_SMMU_V3_PMU depends on ARM_SMMU_V3
>    config ARM_SMMU_V3_PMU
>          tristate "ARM SMMUv3 Performance Monitors Extension"
>          depends on ARM64 && ACPI && ARM_SMMU_V3
> 
> 2) ARM_SMMU_V3=y, ARM_SMMU_V3_PMU=m
>    No problem, SMMUv3 will be initialized first.
> 
> 3) ARM_SMMU_V3=y, ARM_SMMU_V3_PMU=y
>    vi drivers/Makefile
>    60 obj-y                           += iommu/
>    172 obj-$(CONFIG_PERF_EVENTS)       += perf/
> 
>    This link sequence ensure that SMMUv3 driver will be initialized first.
>    They are currently at the same initialization level.
> 
> 4) ARM_SMMU_V3=m, ARM_SMMU_V3_PMU=m
>    Sorry, I thought module dependencies were generated based on "depends on".
>    But I tried it today，module dependencies are generated only when symbol
>    dependencies exist. I should use MODULE_SOFTDEP() to explicitly mark the
>    dependency. I will send V2 later.
> 

Hi Robin:
  I think I misunderstood your question. The probe() instead of module_init()
determines the time for reserving register space resources.  So we'd better
reserve multiple small blocks of resources in SMMUv3 but perform ioremap() for
the entire resource, if the probe() of the PMCG occurs first.
  I'll refine these patches to make both initialization sequences work well.
I'm trying to send V2 this week.

> 
>>
>> Robin.
>>
>>> +
>>> +    return base;
>>> +}
>>> +
>>>   static int smmu_pmu_probe(struct platform_device *pdev)
>>>   {
>>>       struct smmu_pmu *smmu_pmu;
>>> @@ -793,7 +831,7 @@ static int smmu_pmu_probe(struct platform_device *pdev)
>>>           .capabilities    = PERF_PMU_CAP_NO_EXCLUDE,
>>>       };
>>>   -    smmu_pmu->reg_base = devm_platform_get_and_ioremap_resource(pdev, 0, &res_0);
>>> +    smmu_pmu->reg_base = smmu_pmu_get_and_ioremap_resource(pdev, 0, &res_0);
>>>       if (IS_ERR(smmu_pmu->reg_base))
>>>           return PTR_ERR(smmu_pmu->reg_base);
>>>   @@ -801,7 +839,7 @@ static int smmu_pmu_probe(struct platform_device *pdev)
>>>         /* Determine if page 1 is present */
>>>       if (cfgr & SMMU_PMCG_CFGR_RELOC_CTRS) {
>>> -        smmu_pmu->reloc_base = devm_platform_ioremap_resource(pdev, 1);
>>> +        smmu_pmu->reloc_base = smmu_pmu_get_and_ioremap_resource(pdev, 1, NULL);
>>>           if (IS_ERR(smmu_pmu->reloc_base))
>>>               return PTR_ERR(smmu_pmu->reloc_base);
>>>       } else {
>>>
>>
>> .
>>

