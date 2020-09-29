Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF59927BF0D
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 10:18:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727742AbgI2IRz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 04:17:55 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:14703 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726064AbgI2IRz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 04:17:55 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id B8E5CAEB3C33E8880E6F;
        Tue, 29 Sep 2020 16:17:51 +0800 (CST)
Received: from [10.174.178.63] (10.174.178.63) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.487.0; Tue, 29 Sep 2020 16:17:45 +0800
Subject: Re: [PATCH 1/4] drivers/perf: Add support for ARMv8.3-SPE
To:     Will Deacon <will@kernel.org>
CC:     Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Clark <james.clark@arm.com>,
        Jiri Olsa <jolsa@redhat.com>, Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        <zhangshaokun@hisilicon.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>,
        "Peter Zijlstra" <peterz@infradead.org>, <guohanjun@huawei.com>
References: <20200724091607.41903-1-liwei391@huawei.com>
 <20200724091607.41903-2-liwei391@huawei.com>
 <20200907125128.GB12237@willie-the-truck>
From:   "liwei (GF)" <liwei391@huawei.com>
Message-ID: <00fa8b58-0e86-8b05-dbc5-1f8909ec7459@huawei.com>
Date:   Tue, 29 Sep 2020 16:17:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.0
MIME-Version: 1.0
In-Reply-To: <20200907125128.GB12237@willie-the-truck>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.63]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Will,

On 2020/9/7 20:51, Will Deacon wrote:
> On Fri, Jul 24, 2020 at 05:16:04PM +0800, Wei Li wrote:
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
>> alignment event in kernel driver.
>>
>> Signed-off-by: Wei Li <liwei391@huawei.com>
>> ---
>>  arch/arm64/include/asm/sysreg.h |  4 +++-
>>  drivers/perf/arm_spe_pmu.c      | 18 ++++++++++++++----
>>  2 files changed, 17 insertions(+), 5 deletions(-)
>>
>> diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
>> index 463175f80341..be4c44ccdb56 100644
>> --- a/arch/arm64/include/asm/sysreg.h
>> +++ b/arch/arm64/include/asm/sysreg.h
>> @@ -281,7 +281,6 @@
>>  #define SYS_PMSFCR_EL1_ST_SHIFT		18
>>  
>>  #define SYS_PMSEVFR_EL1			sys_reg(3, 0, 9, 9, 5)
>> -#define SYS_PMSEVFR_EL1_RES0		0x0000ffff00ff0f55UL
> 
> I think we can just update this mask unconditionally to allow the new bits.
> 
>>  #define SYS_PMSLATFR_EL1		sys_reg(3, 0, 9, 9, 6)
>>  #define SYS_PMSLATFR_EL1_MINLAT_SHIFT	0
>> @@ -769,6 +768,9 @@
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
>> index e51ddb6d63ed..5ec7ee0c8fa1 100644
>> --- a/drivers/perf/arm_spe_pmu.c
>> +++ b/drivers/perf/arm_spe_pmu.c
>> @@ -54,7 +54,7 @@ struct arm_spe_pmu {
>>  	struct hlist_node			hotplug_node;
>>  
>>  	int					irq; /* PPI */
>> -
>> +	int					pmuver;
> 
> nit: please call this "pmsver" to align with the architecture (where
> "pmuver" means something else).

OK, i will rename it in v2.

>>  	u16					min_period;
>>  	u16					counter_sz;
>>  
>> @@ -80,6 +80,15 @@ struct arm_spe_pmu {
>>  /* Keep track of our dynamic hotplug state */
>>  static enum cpuhp_state arm_spe_pmu_online;
>>  
>> +static u64 sys_pmsevfr_el1_mask[] = {
>> +	[ID_AA64DFR0_PMSVER_8_2] = GENMASK_ULL(63, 48) | GENMASK_ULL(31, 24) |
>> +		GENMASK_ULL(15, 12) | BIT_ULL(7) | BIT_ULL(5) | BIT_ULL(3) |
>> +		BIT_ULL(1),
>> +	[ID_AA64DFR0_PMSVER_8_3] = GENMASK_ULL(63, 48) | GENMASK_ULL(31, 24) |
>> +		GENMASK_ULL(18, 17) | GENMASK_ULL(15, 11) | BIT_ULL(7) |
>> +		BIT_ULL(5) | BIT_ULL(3) | BIT_ULL(1),
>> +};
> 
> As I said above, you can drop this and just update the #define.
> 
>> +
>>  enum arm_spe_pmu_buf_fault_action {
>>  	SPE_PMU_BUF_FAULT_ACT_SPURIOUS,
>>  	SPE_PMU_BUF_FAULT_ACT_FATAL,
>> @@ -670,7 +679,7 @@ static int arm_spe_pmu_event_init(struct perf_event *event)
>>  	    !cpumask_test_cpu(event->cpu, &spe_pmu->supported_cpus))
>>  		return -ENOENT;
>>  
>> -	if (arm_spe_event_to_pmsevfr(event) & SYS_PMSEVFR_EL1_RES0)
>> +	if (arm_spe_event_to_pmsevfr(event) & ~sys_pmsevfr_el1_mask[spe_pmu->pmuver])
>>  		return -EOPNOTSUPP;
> 
> Same here.

What if we use these new bits on the system which just support ARMv8.2-SPE?
It will return success and never work, i don't think that is suitable.

>>  
>>  	if (attr->exclude_idle)
>> @@ -937,6 +946,7 @@ static void __arm_spe_pmu_dev_probe(void *info)
>>  			fld, smp_processor_id());
>>  		return;
>>  	}
>> +	spe_pmu->pmuver = fld;
>>  
>>  	/* Read PMBIDR first to determine whether or not we have access */
>>  	reg = read_sysreg_s(SYS_PMBIDR_EL1);
>> @@ -1027,8 +1037,8 @@ static void __arm_spe_pmu_dev_probe(void *info)
>>  	}
>>  
>>  	dev_info(dev,
>> -		 "probed for CPUs %*pbl [max_record_sz %u, align %u, features 0x%llx]\n",
>> -		 cpumask_pr_args(&spe_pmu->supported_cpus),
>> +		 "v%d probed for CPUs %*pbl [max_record_sz %u, align %u, features 0x%llx]\n",
>> +		 spe_pmu->pmuver, cpumask_pr_args(&spe_pmu->supported_cpus),
> 
> There's no need for this. If userspace finds this information useful, then
> we should expose it in sysfs, like we do for other PMU paramaters. If
> userspace doesn't find it useful, then there's no need to expose it at all.
> 
> So I would suggest adding something like SPE_PMU_CAP_PMSVER and exposing the
> field on a per-SPE-PMU basis in sysfs.

We may need this as then we can know which events are supported. It is meaningful to testcases.
So i will expose it as cap attribute in v2.

> big.LITTLE should work as before, where we expose a completely separate PMU
> instance for each CPU type.
> 

The of_compatible of SPE PMU is "arm,statistical-profiling-extension-v1", and the platform_device
name is "arm,spe-v1". Should we add a "v2" entry for ARMv8.3-SPE or not?

Thanks for your time.

Best regards,
Wei
