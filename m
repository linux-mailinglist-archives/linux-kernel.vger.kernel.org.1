Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 218AE2EEABE
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 02:12:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729803AbhAHBLH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 20:11:07 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:9983 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729697AbhAHBLH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 20:11:07 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4DBlPb1xsPzj3WC;
        Fri,  8 Jan 2021 09:09:39 +0800 (CST)
Received: from [10.174.176.61] (10.174.176.61) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.498.0; Fri, 8 Jan 2021 09:10:13 +0800
Subject: Re: [PATCH 2/2] arm64: mm: fix kdump broken with ZONE_DMA
 reintroduced
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
References: <20201226033557.116251-1-chenzhou10@huawei.com>
 <20201226033557.116251-3-chenzhou10@huawei.com>
 <653d43ed326e6a3974660c0ca2ad8a847a4ff986.camel@suse.de>
 <20210107142541.GA26159@gaia>
CC:     <will@kernel.org>, <ardb@kernel.org>, <akpm@linux-foundation.org>,
        <rppt@kernel.org>, <song.bao.hua@hisilicon.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <huawei.libin@huawei.com>,
        <xiexiuqi@huawei.com>
From:   chenzhou <chenzhou10@huawei.com>
Message-ID: <cf1a0700-4cd4-4550-c0eb-645b60cc83b4@huawei.com>
Date:   Fri, 8 Jan 2021 09:09:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20210107142541.GA26159@gaia>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.61]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/1/7 22:25, Catalin Marinas wrote:
> On Sat, Dec 26, 2020 at 11:34:58AM +0100, Nicolas Saenz Julienne wrote:
>> On Sat, 2020-12-26 at 11:35 +0800, Chen Zhou wrote:
>>> If the memory reserved for crash dump kernel falled in ZONE_DMA32,
>>> the devices in crash dump kernel need to use ZONE_DMA will alloc fail.
>>>
>>> Fix this by reserving low memory in ZONE_DMA if CONFIG_ZONE_DMA is
>>> enabled, otherwise, reserving in ZONE_DMA32.
>>>
>>> Fixes: bff3b04460a8 ("arm64: mm: reserve CMA and crashkernel in ZONE_DMA32")
>> I'm not so sure this counts as a fix, if someone backports it it'll probably
>> break things as it depends on the series that dynamically sizes DMA zones.
>>
>>> Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
>>> ---
>> Why not doing the same with CMA? You'll probably have to move the
>> dma_contiguous_reserve() call into bootmem_init() so as to make sure that
>> arm64_dma_phys_limit is populated.
> Do we need the arm64_dma32_phys_limit at all? I can see the
> (arm64_dma_phys_limit ? : arm64_dma32_phys_limit) pattern in several
> places but I think we can just live with the arm64_dma_phys_limit.
Yes, arm64_dma_phys_limit is enough.
>
> Also, I don't think we need any early ARCH_LOW_ADDRESS_LIMIT. It's only
> used by memblock_alloc_low() and that's called from swiotlb_init()
> after arm64_dma_phys_limit was initialised.
>
> What about something like below (on top of you ARCH_LOW_ADDRESS_LIMIT
> fix but I can revert that)? I haven't tested it in all configurations
> yet.
>
> diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
> index 69ad25fbeae4..ca2cd75d3286 100644
> --- a/arch/arm64/include/asm/processor.h
> +++ b/arch/arm64/include/asm/processor.h
> @@ -94,8 +94,7 @@
>  #endif /* CONFIG_ARM64_FORCE_52BIT */
>  
>  extern phys_addr_t arm64_dma_phys_limit;
> -extern phys_addr_t arm64_dma32_phys_limit;
> -#define ARCH_LOW_ADDRESS_LIMIT	((arm64_dma_phys_limit ? : arm64_dma32_phys_limit) - 1)
> +#define ARCH_LOW_ADDRESS_LIMIT	(arm64_dma_phys_limit - 1)
>  
>  struct debug_info {
>  #ifdef CONFIG_HAVE_HW_BREAKPOINT
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index 7deddf56f7c3..596a94bf5ed6 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -59,7 +59,6 @@ EXPORT_SYMBOL(memstart_addr);
>   * bit addressable memory area.
>   */
>  phys_addr_t arm64_dma_phys_limit __ro_after_init;
> -phys_addr_t arm64_dma32_phys_limit __ro_after_init;
>  
>  #ifdef CONFIG_KEXEC_CORE
>  /*
> @@ -84,7 +83,7 @@ static void __init reserve_crashkernel(void)
>  
>  	if (crash_base == 0) {
>  		/* Current arm64 boot protocol requires 2MB alignment */
> -		crash_base = memblock_find_in_range(0, arm64_dma32_phys_limit,
> +		crash_base = memblock_find_in_range(0, arm64_dma_phys_limit,
>  				crash_size, SZ_2M);
>  		if (crash_base == 0) {
>  			pr_warn("cannot allocate crashkernel (size:0x%llx)\n",
> @@ -196,6 +195,7 @@ static void __init zone_sizes_init(unsigned long min, unsigned long max)
>  	unsigned long max_zone_pfns[MAX_NR_ZONES]  = {0};
>  	unsigned int __maybe_unused acpi_zone_dma_bits;
>  	unsigned int __maybe_unused dt_zone_dma_bits;
> +	phys_addr_t dma32_phys_limit = max_zone_phys(32);
>  
>  #ifdef CONFIG_ZONE_DMA
>  	acpi_zone_dma_bits = fls64(acpi_iort_dma_get_max_cpu_address());
> @@ -205,8 +205,12 @@ static void __init zone_sizes_init(unsigned long min, unsigned long max)
>  	max_zone_pfns[ZONE_DMA] = PFN_DOWN(arm64_dma_phys_limit);
>  #endif
>  #ifdef CONFIG_ZONE_DMA32
> -	max_zone_pfns[ZONE_DMA32] = PFN_DOWN(arm64_dma32_phys_limit);
> +	max_zone_pfns[ZONE_DMA32] = PFN_DOWN(dma32_phys_limit);
> +	if (!arm64_dma_phys_limit)
> +		arm64_dma_phys_limit = dma32_phys_limit;
>  #endif
> +	if (!arm64_dma_phys_limit)
> +		arm64_dma_phys_limit = PHYS_MASK + 1;
>  	max_zone_pfns[ZONE_NORMAL] = max;
>  
>  	free_area_init(max_zone_pfns);
> @@ -394,16 +398,9 @@ void __init arm64_memblock_init(void)
>  
>  	early_init_fdt_scan_reserved_mem();
>  
> -	if (IS_ENABLED(CONFIG_ZONE_DMA32))
> -		arm64_dma32_phys_limit = max_zone_phys(32);
> -	else
> -		arm64_dma32_phys_limit = PHYS_MASK + 1;
> -
>  	reserve_elfcorehdr();
>  
>  	high_memory = __va(memblock_end_of_DRAM() - 1) + 1;
> -
> -	dma_contiguous_reserve(arm64_dma32_phys_limit);
>  }
>  
>  void __init bootmem_init(void)
> @@ -438,6 +435,11 @@ void __init bootmem_init(void)
>  	sparse_init();
>  	zone_sizes_init(min, max);
>  
> +	/*
> +	 * Reserve the CMA area after arm64_dma_phys_limit was initialised.
> +	 */
> +	dma_contiguous_reserve(arm64_dma_phys_limit);
> +
>  	/*
>  	 * request_standard_resources() depends on crashkernel's memory being
>  	 * reserved, so do it here.
> @@ -455,7 +457,7 @@ void __init bootmem_init(void)
>  void __init mem_init(void)
>  {
>  	if (swiotlb_force == SWIOTLB_FORCE ||
> -	    max_pfn > PFN_DOWN(arm64_dma_phys_limit ? : arm64_dma32_phys_limit))
> +	    max_pfn > PFN_DOWN(arm64_dma_phys_limit))
>  		swiotlb_init(1);
>  	else
>  		swiotlb_force = SWIOTLB_NO_FORCE;
> .
>

