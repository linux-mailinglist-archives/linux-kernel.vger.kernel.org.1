Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09AC7234596
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Jul 2020 14:18:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732990AbgGaMS1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Jul 2020 08:18:27 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:43866 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732842AbgGaMS0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 08:18:26 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 199D19A795D05647D42A;
        Fri, 31 Jul 2020 20:18:17 +0800 (CST)
Received: from [10.174.178.63] (10.174.178.63) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.487.0; Fri, 31 Jul 2020 20:18:11 +0800
Subject: Re: [PATCH 1/4] drivers/perf: Add support for ARMv8.3-SPE
To:     Leo Yan <leo.yan@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>
CC:     <adrian.hunter@intel.com>, <alexander.shishkin@linux.intel.com>,
        <acme@kernel.org>, <catalin.marinas@arm.com>,
        <James.Clark@arm.com>, <jolsa@redhat.com>, <mark.rutland@arm.com>,
        <namhyung@kernel.org>, <will@kernel.org>,
        <zhangshaokun@hisilicon.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <mingo@redhat.com>,
        <peterz@infradead.org>, <guohanjun@huawei.com>
References: <20200724091607.41903-1-liwei391@huawei.com>
 <20200724091607.41903-2-liwei391@huawei.com>
 <a9c59cb6-80f7-1abe-cef4-33127f051488@arm.com>
 <20200730081458.GA23324@leoy-ThinkPad-X240s>
From:   "liwei (GF)" <liwei391@huawei.com>
Message-ID: <92273648-8638-a56f-dbd1-9aaae089d1cc@huawei.com>
Date:   Fri, 31 Jul 2020 20:18:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.0
MIME-Version: 1.0
In-Reply-To: <20200730081458.GA23324@leoy-ThinkPad-X240s>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.63]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020/7/30 16:14, Leo Yan wrote:
> Hi Suzuki,
> 
> On Wed, Jul 29, 2020 at 10:12:50AM +0100, Suzuki Kuruppassery Poulose wrote:
>> On 07/24/2020 10:16 AM, Wei Li wrote:
>>> Armv8.3 extends the SPE by adding:
>>> - Alignment field in the Events packet, and filtering on this event
>>>    using PMSEVFR_EL1.
>>> - Support for the Scalable Vector Extension (SVE).
>>>
>>> The main additions for SVE are:
>>> - Recording the vector length for SVE operations in the Operation Type
>>>    packet. It is not possible to filter on vector length.
>>> - Incomplete predicate and empty predicate fields in the Events packet,
>>>    and filtering on these events using PMSEVFR_EL1.
>>>
>>> Update the check of pmsevfr for empty/partial predicated SVE and
>>> alignment event in kernel driver.
>>>
>>> Signed-off-by: Wei Li <liwei391@huawei.com>
>>> ---
>>>   arch/arm64/include/asm/sysreg.h |  4 +++-
>>>   drivers/perf/arm_spe_pmu.c      | 18 ++++++++++++++----
>>>   2 files changed, 17 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
>>> index 463175f80341..be4c44ccdb56 100644
>>> --- a/arch/arm64/include/asm/sysreg.h
>>> +++ b/arch/arm64/include/asm/sysreg.h
>>> @@ -281,7 +281,6 @@
>>>   #define SYS_PMSFCR_EL1_ST_SHIFT		18
>>>   #define SYS_PMSEVFR_EL1			sys_reg(3, 0, 9, 9, 5)
>>> -#define SYS_PMSEVFR_EL1_RES0		0x0000ffff00ff0f55UL
>>>   #define SYS_PMSLATFR_EL1		sys_reg(3, 0, 9, 9, 6)
>>>   #define SYS_PMSLATFR_EL1_MINLAT_SHIFT	0
>>> @@ -769,6 +768,9 @@
>>>   #define ID_AA64DFR0_PMUVER_8_5		0x6
>>>   #define ID_AA64DFR0_PMUVER_IMP_DEF	0xf
>>> +#define ID_AA64DFR0_PMSVER_8_2		0x1
>>> +#define ID_AA64DFR0_PMSVER_8_3		0x2
>>> +
>>>   #define ID_DFR0_PERFMON_SHIFT		24
>>>   #define ID_DFR0_PERFMON_8_1		0x4
>>> diff --git a/drivers/perf/arm_spe_pmu.c b/drivers/perf/arm_spe_pmu.c
>>> index e51ddb6d63ed..5ec7ee0c8fa1 100644
>>> --- a/drivers/perf/arm_spe_pmu.c
>>> +++ b/drivers/perf/arm_spe_pmu.c
>>> @@ -54,7 +54,7 @@ struct arm_spe_pmu {
>>>   	struct hlist_node			hotplug_node;
>>>   	int					irq; /* PPI */
>>> -
>>> +	int					pmuver;
>>>   	u16					min_period;
>>>   	u16					counter_sz;
>>> @@ -80,6 +80,15 @@ struct arm_spe_pmu {
>>>   /* Keep track of our dynamic hotplug state */
>>>   static enum cpuhp_state arm_spe_pmu_online;
>>> +static u64 sys_pmsevfr_el1_mask[] = {
>>> +	[ID_AA64DFR0_PMSVER_8_2] = GENMASK_ULL(63, 48) | GENMASK_ULL(31, 24) |
>>> +		GENMASK_ULL(15, 12) | BIT_ULL(7) | BIT_ULL(5) | BIT_ULL(3) |
>>> +		BIT_ULL(1),
>>> +	[ID_AA64DFR0_PMSVER_8_3] = GENMASK_ULL(63, 48) | GENMASK_ULL(31, 24) |
>>> +		GENMASK_ULL(18, 17) | GENMASK_ULL(15, 11) | BIT_ULL(7) |
>>> +		BIT_ULL(5) | BIT_ULL(3) | BIT_ULL(1),
>>> +};
>>> +
>>>   enum arm_spe_pmu_buf_fault_action {
>>>   	SPE_PMU_BUF_FAULT_ACT_SPURIOUS,
>>>   	SPE_PMU_BUF_FAULT_ACT_FATAL,
>>> @@ -670,7 +679,7 @@ static int arm_spe_pmu_event_init(struct perf_event *event)
>>>   	    !cpumask_test_cpu(event->cpu, &spe_pmu->supported_cpus))
>>>   		return -ENOENT;
>>> -	if (arm_spe_event_to_pmsevfr(event) & SYS_PMSEVFR_EL1_RES0)
>>> +	if (arm_spe_event_to_pmsevfr(event) & ~sys_pmsevfr_el1_mask[spe_pmu->pmuver])
>>>   		return -EOPNOTSUPP;
>>>   	if (attr->exclude_idle)
>>> @@ -937,6 +946,7 @@ static void __arm_spe_pmu_dev_probe(void *info)
>>>   			fld, smp_processor_id());
>>>   		return;
>>>   	}
>>> +	spe_pmu->pmuver = fld;
>>
>> How do we deal with cases where we have big.LITTLE system with differing
>> SPE versions ?
> 
> Good point.
> 
> The first question we need to answer is: how to define SPE version?
> From my understanding, if SPE uses the same sample specification and
> the same packet format, then we should consider the SPE is the same
> version cross CPUs.  So even some CPUs are ARMv8.2 and other CPUs are
> ARMv8.3 variants, we still should take the SPE as the same version.
> 
> And when read the SPE driver in the file drivers/perf/arm_spe_pmu.c and
> I concluded that so far the SPE perf driver is to only support SPE-v1
> with single instance, it cannot support a complex usage case like
> below:
> 
>   CPU0-3: ARMv8.2 architecture with SPE
>   CPU4-7: ARMv8.3 architecture with SPE
> 
> For this case, if we take SPE as two different versions, let's say
> SPE-8.2 and SPE-8.3, then should the SPE driver need to create multi
> perf PMU events?  For example, we should create a perf PMU event
> 'arm_spe_8.2' and another PMU event 'arm_spe_8.3'.

As we have supported SPE v2 (ARMv8.3-SPE) now, if we add the new
of_device_id: "arm,statistical-profiling-extension-v2" and the new
platform_device_id: "arm,spe-v2", we may really support two instance now.
Even two different versions of SPE pmus which work on different range of
cores with the same PPI. Their functional scopes are the same as the PPI partitions.

> Another option is we always take this as SPE-v1 and only create single
> PMU event, just keep what's we are doing with the perf event
> 'arm_spe_0', but the driver needs to dynamically detect SPE PMU version
> number in the function arm_spe_pmu_event_init(), and then based on
> version number to select corresponding mask for PMSEVFR.

Thus, the driver will service two devices, and will also register two PMUs 'arm_spe_0' and
'arm_spe_1', so i think there is no conflict here.

Back to Suzuki's question, refer to the ACPI parsing code for SPE device, function
arm_spe_acpi_register_device(), there is a check of hetero_id for all cores.
It seems that we only support homogeneous ACPI/SPE machines, but i can't find the similar
check in OF/SPE parsing code.

> Thanks,
> Leo
> 
> [1] https://lore.kernel.org/linux-arm-kernel/20200724071111.35593-1-liwei391@huawei.com/
> 


Thanks,
Wei
