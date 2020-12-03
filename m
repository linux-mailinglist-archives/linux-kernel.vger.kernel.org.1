Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D0512CD192
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 09:47:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388499AbgLCIo2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 03:44:28 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:8934 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728741AbgLCIo1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 03:44:27 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4Cmq8K6KNtzhm0F;
        Thu,  3 Dec 2020 16:42:09 +0800 (CST)
Received: from [10.174.178.63] (10.174.178.63) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.487.0; Thu, 3 Dec 2020 16:42:22 +0800
Subject: Re: [PATCH v3] drivers/perf: Add support for ARMv8.3-SPE
To:     Will Deacon <will@kernel.org>
CC:     Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        "Anshuman Khandual" <anshuman.khandual@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        "Amit Daniel Kachhap" <amit.kachhap@arm.com>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <guohanjun@huawei.com>
References: <20201127060322.29025-1-liwei391@huawei.com>
 <20201130100628.GB24098@willie-the-truck>
From:   "liwei (GF)" <liwei391@huawei.com>
Message-ID: <47201e85-7cf3-7c94-d1be-9c83ef8c3416@huawei.com>
Date:   Thu, 3 Dec 2020 16:42:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.0
MIME-Version: 1.0
In-Reply-To: <20201130100628.GB24098@willie-the-truck>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.63]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Will,

On 2020/11/30 18:06, Will Deacon wrote:
> On Fri, Nov 27, 2020 at 02:03:22PM +0800, Wei Li wrote:
>> Armv8.3 extends the SPE by adding:
>> - Alignment field in the Events packet, and filtering on this event
>>   using PMSEVFR_EL1.
>> - Support for the Scalable Vector Extension (SVE).
>>
>> The main additions for SVE are:
>> - Recording the vector length for SVE operations in the Operation Type
>>   packet. It is not possible to filter on vector length.
>> - Incomplete predicate and empty predicate fields in the Events packet,
>>   and filtering on these events using PMSEVFR_EL1.
>>
>> Update the check of pmsevfr for empty/partial predicated SVE and
>> alignment event in SPE driver. For adaption by the version of SPE,
>> expose 'pmsver' as cap attribute to userspace.
>>
>> Signed-off-by: Wei Li <liwei391@huawei.com>
>> ---
>> v2 -> v3:
>>  - Make the definition of 'pmsevfr_res0' progressive and easy to check.
>>    (Suggested by Will.)
>> ---
>> v1 -> v2:
>>  - Rename 'pmuver' to 'pmsver', change it's type to 'u16' from 'int'.
>>    (Suggested by Will and Leo.)
>>  - Expose 'pmsver' as cap attribute through sysfs, instead of printing.
>>    (Suggested by Will.)
>> ---
>>  arch/arm64/include/asm/sysreg.h |  9 ++++++++-
>>  drivers/perf/arm_spe_pmu.c      | 21 +++++++++++++++++++--
>>  2 files changed, 27 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
>> index d52c1b3ce589..57e5aee6f7e6 100644
>> --- a/arch/arm64/include/asm/sysreg.h
>> +++ b/arch/arm64/include/asm/sysreg.h
>> @@ -287,7 +287,11 @@
>>  #define SYS_PMSFCR_EL1_ST_SHIFT		18
>>  
>>  #define SYS_PMSEVFR_EL1			sys_reg(3, 0, 9, 9, 5)
>> -#define SYS_PMSEVFR_EL1_RES0		0x0000ffff00ff0f55UL
>> +#define SYS_PMSEVFR_EL1_RES0_8_2	\
>> +	(GENMASK_ULL(47, 32) | GENMASK_ULL(23, 16) | GENMASK_ULL(11, 8) |\
>> +	 BIT_ULL(6) | BIT_ULL(4) | BIT_ULL(2) | BIT_ULL(0))
>> +#define SYS_PMSEVFR_EL1_RES0_8_3	\
>> +	(SYS_PMSEVFR_EL1_RES0_8_2 & ~(BIT_ULL(18) | BIT_ULL(17) | BIT_ULL(11)))
>>  
>>  #define SYS_PMSLATFR_EL1		sys_reg(3, 0, 9, 9, 6)
>>  #define SYS_PMSLATFR_EL1_MINLAT_SHIFT	0
>> @@ -829,6 +833,9 @@
>>  #define ID_AA64DFR0_PMUVER_8_5		0x6
>>  #define ID_AA64DFR0_PMUVER_IMP_DEF	0xf
>>  
>> +#define ID_AA64DFR0_PMSVER_8_2		0x1
>> +#define ID_AA64DFR0_PMSVER_8_3		0x2
>> +
>>  #define ID_DFR0_PERFMON_SHIFT		24
>>  
>>  #define ID_DFR0_PERFMON_8_1		0x4
>> diff --git a/drivers/perf/arm_spe_pmu.c b/drivers/perf/arm_spe_pmu.c
>> index cc00915ad6d1..515c51271d7f 100644
>> --- a/drivers/perf/arm_spe_pmu.c
>> +++ b/drivers/perf/arm_spe_pmu.c
>> @@ -54,7 +54,7 @@ struct arm_spe_pmu {
>>  	struct hlist_node			hotplug_node;
>>  
>>  	int					irq; /* PPI */
>> -
>> +	u16					pmsver;
>>  	u16					min_period;
>>  	u16					counter_sz;
>>  
>> @@ -93,6 +93,7 @@ enum arm_spe_pmu_capabilities {
>>  	SPE_PMU_CAP_FEAT_MAX,
>>  	SPE_PMU_CAP_CNT_SZ = SPE_PMU_CAP_FEAT_MAX,
>>  	SPE_PMU_CAP_MIN_IVAL,
>> +	SPE_PMU_CAP_PMSVER,
>>  };
>>  
>>  static int arm_spe_pmu_feat_caps[SPE_PMU_CAP_FEAT_MAX] = {
>> @@ -110,6 +111,8 @@ static u32 arm_spe_pmu_cap_get(struct arm_spe_pmu *spe_pmu, int cap)
>>  		return spe_pmu->counter_sz;
>>  	case SPE_PMU_CAP_MIN_IVAL:
>>  		return spe_pmu->min_period;
>> +	case SPE_PMU_CAP_PMSVER:
>> +		return spe_pmu->pmsver;
>>  	default:
>>  		WARN(1, "unknown cap %d\n", cap);
>>  	}
>> @@ -143,6 +146,7 @@ static struct attribute *arm_spe_pmu_cap_attr[] = {
>>  	SPE_CAP_EXT_ATTR_ENTRY(ernd, SPE_PMU_CAP_ERND),
>>  	SPE_CAP_EXT_ATTR_ENTRY(count_size, SPE_PMU_CAP_CNT_SZ),
>>  	SPE_CAP_EXT_ATTR_ENTRY(min_interval, SPE_PMU_CAP_MIN_IVAL),
>> +	SPE_CAP_EXT_ATTR_ENTRY(pmsver, SPE_PMU_CAP_PMSVER),
>>  	NULL,
>>  };
>>  
>> @@ -655,6 +659,18 @@ static irqreturn_t arm_spe_pmu_irq_handler(int irq, void *dev)
>>  	return IRQ_HANDLED;
>>  }
>>  
>> +static u64 arm_spe_pmsevfr_res0(u16 pmsver)
>> +{
>> +	switch (pmsver) {
>> +	case ID_AA64DFR0_PMSVER_8_2:
>> +		return SYS_PMSEVFR_EL1_RES0_8_2;
>> +	case ID_AA64DFR0_PMSVER_8_3:
>> +		return SYS_PMSEVFR_EL1_RES0_8_3;
>> +	default:
>> +		return -1;
>> +	}
> 
> I don't think -1 is the right choice here if we don't recognise the
> version, as it means that old kernels won't work on new hardware. I think
> it would be better to return the highest architecture version we know about
> in that case...

ACK.

>> +}
>> +
>>  /* Perf callbacks */
>>  static int arm_spe_pmu_event_init(struct perf_event *event)
>>  {
>> @@ -670,7 +686,7 @@ static int arm_spe_pmu_event_init(struct perf_event *event)
>>  	    !cpumask_test_cpu(event->cpu, &spe_pmu->supported_cpus))
>>  		return -ENOENT;
>>  
>> -	if (arm_spe_event_to_pmsevfr(event) & SYS_PMSEVFR_EL1_RES0)
>> +	if (arm_spe_event_to_pmsevfr(event) & arm_spe_pmsevfr_res0(spe_pmu->pmsver))
>>  		return -EOPNOTSUPP;
>>  
>>  	if (attr->exclude_idle)
>> @@ -937,6 +953,7 @@ static void __arm_spe_pmu_dev_probe(void *info)
>>  			fld, smp_processor_id());
>>  		return;
>>  	}
>> +	spe_pmu->pmsver = (u16)fld;
> 
> ... which also means we should clamp this value now that we expose it to
> userspace. Otherwise, userspace can't rely on this field for anything.
> 
> That said -- please can you tell me what userspace intends to do with
> this version number?
> 

In fact, it is only used in our testcase for now, which needs to know the real version the
chip has implemented, as these is no other way to get the info now. So i added it in the
probe message in v1 at first.

Especially we use the of_device_id "arm,statistical-profiling-extension-v1" and the
platform_device_id "arm,spe-v1". It's a little weird to ARMv8.3-SPE.

Further more i am wondering if we need to add the 'spe-v2' device_id. If not, i think it's
broken on a big.LITTLE system [1] as we can register only one device and the driver will work
incorrectly if the big and LITTLE cores have different version of SPE.

If add, we may really support two instance. Even two different versions of SPE pmus which work
on different range of cores with the same PPI. Their functional scopes are the same as the PPI
partitions. Exporting the version is not needed as we can get it from the device_id.

Thanks,
Wei

[1] https://www.spinics.net/lists/arm-kernel/msg827183.html
