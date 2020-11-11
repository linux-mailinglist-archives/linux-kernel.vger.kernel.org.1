Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18F372AF21E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 14:27:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726760AbgKKN1f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 08:27:35 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:8064 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725979AbgKKN1e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 08:27:34 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4CWQWT67SRzLxPs;
        Wed, 11 Nov 2020 21:27:17 +0800 (CST)
Received: from [10.174.176.61] (10.174.176.61) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.487.0; Wed, 11 Nov 2020 21:27:20 +0800
Subject: Re: [PATCH v13 6/8] arm64: kdump: reimplement crashkernel=X
To:     Baoquan He <bhe@redhat.com>
References: <20201031074437.168008-1-chenzhou10@huawei.com>
 <20201031074437.168008-7-chenzhou10@huawei.com>
 <20201111015926.GD24747@MiWiFi-R3L-srv>
CC:     <tglx@linutronix.de>, <mingo@redhat.com>, <dyoung@redhat.com>,
        <catalin.marinas@arm.com>, <will@kernel.org>, <corbet@lwn.net>,
        <John.P.donnelly@oracle.com>, <bhsharma@redhat.com>,
        <prabhakar.pkin@gmail.com>, <wangkefeng.wang@huawei.com>,
        <arnd@arndb.de>, <linux-doc@vger.kernel.org>,
        <xiexiuqi@huawei.com>, <kexec@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <robh+dt@kernel.org>,
        <horms@verge.net.au>, <james.morse@arm.com>,
        <linux-arm-kernel@lists.infradead.org>, <huawei.libin@huawei.com>,
        <guohanjun@huawei.com>, <nsaenzjulienne@suse.de>
From:   chenzhou <chenzhou10@huawei.com>
Message-ID: <23389389-2855-50fd-25b7-4f7d4246bf0c@huawei.com>
Date:   Wed, 11 Nov 2020 21:27:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20201111015926.GD24747@MiWiFi-R3L-srv>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.61]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Baoquan,


On 2020/11/11 9:59, Baoquan He wrote:
> On 10/31/20 at 03:44pm, Chen Zhou wrote:
>> There are following issues in arm64 kdump:
>> 1. We use crashkernel=X to reserve crashkernel below 4G, which
>> will fail when there is no enough low memory.
>> 2. If reserving crashkernel above 4G, in this case, crash dump
>> kernel will boot failure because there is no low memory available
>> for allocation.
>> 3. Since commit 1a8e1cef7603 ("arm64: use both ZONE_DMA and ZONE_DMA32"),
>> if the memory reserved for crash dump kernel falled in ZONE_DMA32,
>> the devices in crash dump kernel need to use ZONE_DMA will alloc
>> fail.
>>
>> To solve these issues, change the behavior of crashkernel=X and
>> introduce crashkernel=X,[high,low]. crashkernel=X tries low allocation
>> in DMA zone or DMA32 zone if CONFIG_ZONE_DMA is disabled, and fall back
>> to high allocation if it fails.
>> We can also use "crashkernel=X,high" to select a region above DMA zone,
>> which also tries to allocate at least 256M in DMA zone automatically
>> (or the DMA32 zone if CONFIG_ZONE_DMA is disabled).
>> "crashkernel=Y,low" can be used to allocate specified size low memory.
>>
>> Another minor change, there may be two regions reserved for crash
>> dump kernel, in order to distinct from the high region and make no
>> effect to the use of existing kexec-tools, rename the low region as
>> "Crash kernel (low)".
>>
>> Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
>> Tested-by: John Donnelly <John.p.donnelly@oracle.com>
>> ---
>>  arch/arm64/include/asm/kexec.h |  9 +++++
>>  arch/arm64/kernel/setup.c      | 13 +++++++-
>>  arch/arm64/mm/init.c           | 60 ++--------------------------------
>>  arch/arm64/mm/mmu.c            |  4 +++
>>  kernel/crash_core.c            |  8 +++--
>>  5 files changed, 34 insertions(+), 60 deletions(-)
>>
>> diff --git a/arch/arm64/include/asm/kexec.h b/arch/arm64/include/asm/kexec.h
>> index 402d208265a3..79909ae5e22e 100644
>> --- a/arch/arm64/include/asm/kexec.h
>> +++ b/arch/arm64/include/asm/kexec.h
>> @@ -28,7 +28,12 @@
>>  /* 2M alignment for crash kernel regions */
>>  #define CRASH_ALIGN	SZ_2M
>>  
>> +#ifdef CONFIG_ZONE_DMA
>> +#define CRASH_ADDR_LOW_MAX	arm64_dma_phys_limit
>> +#else
>>  #define CRASH_ADDR_LOW_MAX	arm64_dma32_phys_limit
>> +#endif
>> +
>>  #define CRASH_ADDR_HIGH_MAX	MEMBLOCK_ALLOC_ACCESSIBLE
>>  
>>  #ifndef __ASSEMBLY__
>> @@ -96,6 +101,10 @@ static inline void crash_prepare_suspend(void) {}
>>  static inline void crash_post_resume(void) {}
>>  #endif
>>  
>> +#ifdef CONFIG_KEXEC_CORE
>> +extern void __init reserve_crashkernel(void);
>> +#endif
>> +
>>  #ifdef CONFIG_KEXEC_FILE
>>  #define ARCH_HAS_KIMAGE_ARCH
>>  
>> diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
>> index 133257ffd859..6aff30de8f47 100644
>> --- a/arch/arm64/kernel/setup.c
>> +++ b/arch/arm64/kernel/setup.c
>> @@ -238,7 +238,18 @@ static void __init request_standard_resources(void)
>>  		    kernel_data.end <= res->end)
>>  			request_resource(res, &kernel_data);
>>  #ifdef CONFIG_KEXEC_CORE
>> -		/* Userspace will find "Crash kernel" region in /proc/iomem. */
>> +		/*
>> +		 * Userspace will find "Crash kernel" or "Crash kernel (low)"
>> +		 * region in /proc/iomem.
>> +		 * In order to distinct from the high region and make no effect
>> +		 * to the use of existing kexec-tools, rename the low region as
>> +		 * "Crash kernel (low)".
>> +		 */
>> +		if (crashk_low_res.end && crashk_low_res.start >= res->start &&
>> +				crashk_low_res.end <= res->end) {
>> +			crashk_low_res.name = "Crash kernel (low)";
>> +			request_resource(res, &crashk_low_res);
>> +		}
>>  		if (crashk_res.end && crashk_res.start >= res->start &&
>>  		    crashk_res.end <= res->end)
>>  			request_resource(res, &crashk_res);
>> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
>> index a07fd8e1f926..888c4f7eadc3 100644
>> --- a/arch/arm64/mm/init.c
>> +++ b/arch/arm64/mm/init.c
>> @@ -34,6 +34,7 @@
>>  #include <asm/fixmap.h>
>>  #include <asm/kasan.h>
>>  #include <asm/kernel-pgtable.h>
>> +#include <asm/kexec.h>
>>  #include <asm/memory.h>
>>  #include <asm/numa.h>
>>  #include <asm/sections.h>
>> @@ -62,66 +63,11 @@ EXPORT_SYMBOL(memstart_addr);
>>  phys_addr_t arm64_dma_phys_limit __ro_after_init;
>>  phys_addr_t arm64_dma32_phys_limit __ro_after_init;
>>  
>> -#ifdef CONFIG_KEXEC_CORE
>> -/*
>> - * reserve_crashkernel() - reserves memory for crash kernel
>> - *
>> - * This function reserves memory area given in "crashkernel=" kernel command
>> - * line parameter. The memory reserved is used by dump capture kernel when
>> - * primary kernel is crashing.
>> - */
>> -static void __init reserve_crashkernel(void)
>> -{
>> -	unsigned long long crash_base, crash_size;
>> -	int ret;
>> -
>> -	ret = parse_crashkernel(boot_command_line, memblock_phys_mem_size(),
>> -				&crash_size, &crash_base);
>> -	/* no crashkernel= or invalid value specified */
>> -	if (ret || !crash_size)
>> -		return;
>> -
>> -	crash_size = PAGE_ALIGN(crash_size);
>> -
>> -	if (crash_base == 0) {
>> -		/* Current arm64 boot protocol requires 2MB alignment */
>> -		crash_base = memblock_find_in_range(CRASH_ALIGN, CRASH_ADDR_LOW_MAX,
>> -				crash_size, CRASH_ALIGN);
>> -		if (crash_base == 0) {
>> -			pr_warn("cannot allocate crashkernel (size:0x%llx)\n",
>> -				crash_size);
>> -			return;
>> -		}
>> -	} else {
>> -		/* User specifies base address explicitly. */
>> -		if (!memblock_is_region_memory(crash_base, crash_size)) {
>> -			pr_warn("cannot reserve crashkernel: region is not memory\n");
>> -			return;
>> -		}
>> -
>> -		if (memblock_is_region_reserved(crash_base, crash_size)) {
>> -			pr_warn("cannot reserve crashkernel: region overlaps reserved memory\n");
>> -			return;
>> -		}
>> -
>> -		if (!IS_ALIGNED(crash_base, CRASH_ALIGN)) {
>> -			pr_warn("cannot reserve crashkernel: base address is not 2MB aligned\n");
>> -			return;
>> -		}
>> -	}
>> -	memblock_reserve(crash_base, crash_size);
>> -
>> -	pr_info("crashkernel reserved: 0x%016llx - 0x%016llx (%lld MB)\n",
>> -		crash_base, crash_base + crash_size, crash_size >> 20);
>> -
>> -	crashk_res.start = crash_base;
>> -	crashk_res.end = crash_base + crash_size - 1;
>> -}
>> -#else
>> +#ifndef CONFIG_KEXEC_CORE
>>  static void __init reserve_crashkernel(void)
>>  {
>>  }
>> -#endif /* CONFIG_KEXEC_CORE */
>> +#endif
>>  
>>  #ifdef CONFIG_CRASH_DUMP
>>  static int __init early_init_dt_scan_elfcorehdr(unsigned long node,
>> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
>> index 1c0f3e02f731..c55cee290bbb 100644
>> --- a/arch/arm64/mm/mmu.c
>> +++ b/arch/arm64/mm/mmu.c
>> @@ -488,6 +488,10 @@ static void __init map_mem(pgd_t *pgdp)
>>  	 */
>>  	memblock_mark_nomap(kernel_start, kernel_end - kernel_start);
>>  #ifdef CONFIG_KEXEC_CORE
>> +	if (crashk_low_res.end)
>> +		memblock_mark_nomap(crashk_low_res.start,
>> +				    resource_size(&crashk_low_res));
>> +
>>  	if (crashk_res.end)
>>  		memblock_mark_nomap(crashk_res.start,
>>  				    resource_size(&crashk_res));
>> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
>> index d39892bdb9ae..cdef7d8c91a6 100644
>> --- a/kernel/crash_core.c
>> +++ b/kernel/crash_core.c
>> @@ -321,7 +321,7 @@ int __init parse_crashkernel_low(char *cmdline,
>>  
>>  int __init reserve_crashkernel_low(void)
>>  {
>> -#ifdef CONFIG_X86_64
>> +#if defined(CONFIG_X86_64) || defined(CONFIG_ARM64)
> Not very sure if a CONFIG_64BIT checking is better.
If doing like this, there may be some compiling errors for other 64-bit kernel, such as mips.
>
>>  	unsigned long long base, low_base = 0, low_size = 0;
>>  	unsigned long low_mem_limit;
>>  	int ret;
>> @@ -362,12 +362,14 @@ int __init reserve_crashkernel_low(void)
>>  
>>  	crashk_low_res.start = low_base;
>>  	crashk_low_res.end   = low_base + low_size - 1;
>> +#ifdef CONFIG_X86_64
>>  	insert_resource(&iomem_resource, &crashk_low_res);
>> +#endif
>>  #endif
>>  	return 0;
>>  }
>>  
>> -#ifdef CONFIG_X86
>> +#if defined(CONFIG_X86) || defined(CONFIG_ARM64)
> Should we make this weak default so that we can remove the ARCH config?
The same as above, some arch may not support kdump, in that case,  compiling errors occur.

Thanks,
Chen Zhou
>
>>  #ifdef CONFIG_KEXEC_CORE
>>  /*
>>   * reserve_crashkernel() - reserves memory for crash kernel
>> @@ -453,7 +455,9 @@ void __init reserve_crashkernel(void)
>>  
>>  	crashk_res.start = crash_base;
>>  	crashk_res.end   = crash_base + crash_size - 1;
>> +#ifdef CONFIG_X86
>>  	insert_resource(&iomem_resource, &crashk_res);
>> +#endif
>>  }
>>  #endif /* CONFIG_KEXEC_CORE */
>>  #endif
>> -- 
>> 2.20.1
>>
>>
>> _______________________________________________
>> kexec mailing list
>> kexec@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/kexec
>>
> .
>

