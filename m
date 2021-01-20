Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C6372FD243
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 15:20:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389551AbhATOC4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 09:02:56 -0500
Received: from foss.arm.com ([217.140.110.172]:34086 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387679AbhATN2n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 08:28:43 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 905A5D6E;
        Wed, 20 Jan 2021 05:27:51 -0800 (PST)
Received: from [10.57.39.58] (unknown [10.57.39.58])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D76613F66E;
        Wed, 20 Jan 2021 05:27:49 -0800 (PST)
Subject: Re: [PATCH 1/2] perf/smmuv3: Don't reserve the register space that
 overlaps with the SMMUv3
To:     "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        iommu <iommu@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Cc:     Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
References: <20210119015951.1042-1-thunder.leizhen@huawei.com>
 <20210119015951.1042-2-thunder.leizhen@huawei.com>
 <30665cd6-b438-1d1d-7445-9e45e240f79a@arm.com>
 <a2d7d94c-8e4e-d91d-8587-7a5b3594b4ca@huawei.com>
 <9ad3c863-ec80-e177-4d11-24d1f706b4af@huawei.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <f6fde527-8c87-1128-52ca-77d096194eb6@arm.com>
Date:   Wed, 20 Jan 2021 13:27:48 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <9ad3c863-ec80-e177-4d11-24d1f706b4af@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-01-20 09:26, Leizhen (ThunderTown) wrote:
> 
> 
> On 2021/1/20 11:37, Leizhen (ThunderTown) wrote:
>>
>>
>> On 2021/1/19 20:32, Robin Murphy wrote:
>>> On 2021-01-19 01:59, Zhen Lei wrote:
>>>> Some SMMUv3 implementation embed the Perf Monitor Group Registers (PMCG)
>>>> inside the first 64kB region of the SMMU. Since SMMU and PMCG are managed
>>>> by two separate drivers, and this driver depends on ARM_SMMU_V3, so the
>>>> SMMU driver reserves the corresponding resource first, this driver should
>>>> not reserve the corresponding resource again. Otherwise, a resource
>>>> reservation conflict is reported during boot.
>>>>
>>>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
>>>> ---
>>>>    drivers/perf/arm_smmuv3_pmu.c | 42 ++++++++++++++++++++++++++++++++++++++++--
>>>>    1 file changed, 40 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/perf/arm_smmuv3_pmu.c b/drivers/perf/arm_smmuv3_pmu.c
>>>> index 74474bb322c3f26..dcce085431c6ce8 100644
>>>> --- a/drivers/perf/arm_smmuv3_pmu.c
>>>> +++ b/drivers/perf/arm_smmuv3_pmu.c
>>>> @@ -761,6 +761,44 @@ static void smmu_pmu_get_acpi_options(struct smmu_pmu *smmu_pmu)
>>>>        dev_notice(smmu_pmu->dev, "option mask 0x%x\n", smmu_pmu->options);
>>>>    }
>>>>    +static void __iomem *
>>>> +smmu_pmu_get_and_ioremap_resource(struct platform_device *pdev,
>>>> +                  unsigned int index,
>>>> +                  struct resource **out_res)
>>>> +{
>>>> +    int ret;
>>>> +    void __iomem *base;
>>>> +    struct resource *res;
>>>> +
>>>> +    res = platform_get_resource(pdev, IORESOURCE_MEM, index);
>>>> +    if (!res) {
>>>> +        dev_err(&pdev->dev, "invalid resource\n");
>>>> +        return IOMEM_ERR_PTR(-EINVAL);
>>>> +    }
>>>> +    if (out_res)
>>>> +        *out_res = res;
>>>> +
>>>> +    ret = region_intersects(res->start, resource_size(res),
>>>> +                IORESOURCE_MEM, IORES_DESC_NONE);
>>>> +    if (ret == REGION_INTERSECTS) {
>>>> +        /*
>>>> +         * The resource has already been reserved by the SMMUv3 driver.
>>>> +         * Don't reserve it again, just do devm_ioremap().
>>>> +         */
>>>> +        base = devm_ioremap(&pdev->dev, res->start, resource_size(res));
>>>> +    } else {
>>>> +        /*
>>>> +         * The resource may have not been reserved by any driver, or
>>>> +         * has been reserved but not type IORESOURCE_MEM. In the latter
>>>> +         * case, devm_ioremap_resource() reports a conflict and returns
>>>> +         * IOMEM_ERR_PTR(-EBUSY).
>>>> +         */
>>>> +        base = devm_ioremap_resource(&pdev->dev, res);
>>>> +    }
>>>
>>> What if the PMCG driver simply happens to probe first?
>>
>> There are 4 cases:
>> 1) ARM_SMMU_V3=m, ARM_SMMU_V3_PMU=y
>>     It's not allowed. Becase: ARM_SMMU_V3_PMU depends on ARM_SMMU_V3
>>     config ARM_SMMU_V3_PMU
>>           tristate "ARM SMMUv3 Performance Monitors Extension"
>>           depends on ARM64 && ACPI && ARM_SMMU_V3
>>
>> 2) ARM_SMMU_V3=y, ARM_SMMU_V3_PMU=m
>>     No problem, SMMUv3 will be initialized first.
>>
>> 3) ARM_SMMU_V3=y, ARM_SMMU_V3_PMU=y
>>     vi drivers/Makefile
>>     60 obj-y                           += iommu/
>>     172 obj-$(CONFIG_PERF_EVENTS)       += perf/
>>
>>     This link sequence ensure that SMMUv3 driver will be initialized first.
>>     They are currently at the same initialization level.
>>
>> 4) ARM_SMMU_V3=m, ARM_SMMU_V3_PMU=m
>>     Sorry, I thought module dependencies were generated based on "depends on".
>>     But I tried it today，module dependencies are generated only when symbol
>>     dependencies exist. I should use MODULE_SOFTDEP() to explicitly mark the
>>     dependency. I will send V2 later.
>>
> 
> Hi Robin:
>    I think I misunderstood your question. The probe() instead of module_init()
> determines the time for reserving register space resources.  So we'd better
> reserve multiple small blocks of resources in SMMUv3 but perform ioremap() for
> the entire resource, if the probe() of the PMCG occurs first.
>    I'll refine these patches to make both initialization sequences work well.
> I'm trying to send V2 this week.

There's still the possibility that a PMCG is implemented in a root 
complex or some other device that isn't an SMMU, so as I've said before, 
none of this trickery really scales.

As far as I understand it, the main point of reserving resources is to 
catch bugs where things definitely should not be overlapping. PMCGs are 
by definition part of some other device, so in general they *can* be 
expected to overlap with whatever device that is. I still think it's 
most logical to simply *not* try to reserve PMCG resources at all.

Robin.

>>>> +
>>>> +    return base;
>>>> +}
>>>> +
>>>>    static int smmu_pmu_probe(struct platform_device *pdev)
>>>>    {
>>>>        struct smmu_pmu *smmu_pmu;
>>>> @@ -793,7 +831,7 @@ static int smmu_pmu_probe(struct platform_device *pdev)
>>>>            .capabilities    = PERF_PMU_CAP_NO_EXCLUDE,
>>>>        };
>>>>    -    smmu_pmu->reg_base = devm_platform_get_and_ioremap_resource(pdev, 0, &res_0);
>>>> +    smmu_pmu->reg_base = smmu_pmu_get_and_ioremap_resource(pdev, 0, &res_0);
>>>>        if (IS_ERR(smmu_pmu->reg_base))
>>>>            return PTR_ERR(smmu_pmu->reg_base);
>>>>    @@ -801,7 +839,7 @@ static int smmu_pmu_probe(struct platform_device *pdev)
>>>>          /* Determine if page 1 is present */
>>>>        if (cfgr & SMMU_PMCG_CFGR_RELOC_CTRS) {
>>>> -        smmu_pmu->reloc_base = devm_platform_ioremap_resource(pdev, 1);
>>>> +        smmu_pmu->reloc_base = smmu_pmu_get_and_ioremap_resource(pdev, 1, NULL);
>>>>            if (IS_ERR(smmu_pmu->reloc_base))
>>>>                return PTR_ERR(smmu_pmu->reloc_base);
>>>>        } else {
>>>>
>>>
>>> .
>>>
> 
