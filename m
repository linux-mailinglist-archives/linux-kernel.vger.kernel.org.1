Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF1022856C3
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 04:50:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727069AbgJGCut (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 22:50:49 -0400
Received: from foss.arm.com ([217.140.110.172]:34800 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726073AbgJGCut (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 22:50:49 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A0E85113E;
        Tue,  6 Oct 2020 19:50:48 -0700 (PDT)
Received: from [192.168.0.130] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 68F343F71F;
        Tue,  6 Oct 2020 19:50:45 -0700 (PDT)
Subject: Re: [PATCH] arm64/mm: Validate hotplug range before creating linear
 mapping
To:     David Hildenbrand <david@redhat.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     will@kernel.org, catalin.marinas@arm.com,
        Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Steven Price <steven.price@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Michal Hocko <mhocko@kernel.org>
References: <1600332402-30123-1-git-send-email-anshuman.khandual@arm.com>
 <7c39c046-b950-ea4c-fa4d-e0a5d6171147@redhat.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <72ea7056-5289-3eb0-eca9-a8444524667e@arm.com>
Date:   Wed, 7 Oct 2020 08:20:14 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <7c39c046-b950-ea4c-fa4d-e0a5d6171147@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/06/2020 09:04 PM, David Hildenbrand wrote:
> On 17.09.20 10:46, Anshuman Khandual wrote:
>> During memory hotplug process, the linear mapping should not be created for
>> a given memory range if that would fall outside the maximum allowed linear
>> range. Else it might cause memory corruption in the kernel virtual space.
>>
>> Maximum linear mapping region is [PAGE_OFFSET..(PAGE_END -1)] accommodating
>> both its ends but excluding PAGE_END. Max physical range that can be mapped
>> inside this linear mapping range, must also be derived from its end points.
>>
>> When CONFIG_ARM64_VA_BITS_52 is enabled, PAGE_OFFSET is computed with the
>> assumption of 52 bits virtual address space. However, if the CPU does not
>> support 52 bits, then it falls back using 48 bits instead and the PAGE_END
>> is updated to reflect this using the vabits_actual. As for PAGE_OFFSET,
>> bits [51..48] are ignored by the MMU and remain unchanged, even though the
>> effective start address of linear map is now slightly different. Hence, to
>> reliably check the physical address range mapped by the linear map, the
>> start address should be calculated using vabits_actual. This ensures that
>> arch_add_memory() validates memory hot add range for its potential linear
>> mapping requirement, before creating it with __create_pgd_mapping().
>>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Will Deacon <will@kernel.org>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: Ard Biesheuvel <ardb@kernel.org>
>> Cc: Steven Price <steven.price@arm.com>
>> Cc: Robin Murphy <robin.murphy@arm.com>
>> Cc: David Hildenbrand <david@redhat.com>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: linux-arm-kernel@lists.infradead.org
>> Cc: linux-kernel@vger.kernel.org
>> Fixes: 4ab215061554 ("arm64: Add memory hotplug support")
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>> ---
>>  arch/arm64/mm/mmu.c | 27 +++++++++++++++++++++++++++
>>  1 file changed, 27 insertions(+)
>>
>> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
>> index 75df62fea1b6..d59ffabb9c84 100644
>> --- a/arch/arm64/mm/mmu.c
>> +++ b/arch/arm64/mm/mmu.c
>> @@ -1433,11 +1433,38 @@ static void __remove_pgd_mapping(pgd_t *pgdir, unsigned long start, u64 size)
>>  	free_empty_tables(start, end, PAGE_OFFSET, PAGE_END);
>>  }
>>  
>> +static bool inside_linear_region(u64 start, u64 size)
>> +{
>> +	/*
>> +	 * Linear mapping region is the range [PAGE_OFFSET..(PAGE_END - 1)]
>> +	 * accommodating both its ends but excluding PAGE_END. Max physical
>> +	 * range which can be mapped inside this linear mapping range, must
>> +	 * also be derived from its end points.
>> +	 *
>> +	 * With CONFIG_ARM64_VA_BITS_52 enabled, PAGE_OFFSET is defined with
>> +	 * the assumption of 52 bits virtual address space. However, if the
>> +	 * CPU does not support 52 bits, it falls back using 48 bits and the
>> +	 * PAGE_END is updated to reflect this using the vabits_actual. As
>> +	 * for PAGE_OFFSET, bits [51..48] are ignored by the MMU and remain
>> +	 * unchanged, even though the effective start address of linear map
>> +	 * is now slightly different. Hence, to reliably check the physical
>> +	 * address range mapped by the linear map, the start address should
>> +	 * be calculated using vabits_actual.
>> +	 */
>> +	return ((start >= __pa(_PAGE_OFFSET(vabits_actual)))
>> +			&& ((start + size) <= __pa(PAGE_END - 1)));
>> +}
>> +
>>  int arch_add_memory(int nid, u64 start, u64 size,
>>  		    struct mhp_params *params)
>>  {
>>  	int ret, flags = 0;
>>  
>> +	if (!inside_linear_region(start, size)) {
>> +		pr_err("[%llx %llx] is outside linear mapping region\n", start, start + size);
>> +		return -EINVAL;
>> +	}
>> +
>>  	if (rodata_full || debug_pagealloc_enabled())
>>  		flags = NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS;
>>  
>>
> 
> Can we please provide a generic way to figure limits like that out,
> especially, before calling add_memory() and friends?
> 
> We do have __add_pages()->check_hotplug_memory_addressable() where we
> already check against MAX_PHYSMEM_BITS.

Initially, I thought about check_hotplug_memory_addressable() but the
existing check that asserts end of hotplug wrt MAX_PHYSMEM_BITS, is
generic in nature. AFAIK the linear mapping problem is arm64 specific,
hence I was not sure whether to add an arch specific callback which
will give platform an opportunity to weigh in for these ranges.

But hold on, check_hotplug_memory_addressable() only gets called from
__add_pages() after linear mapping creation in arch_add_memory(). How
would it help ? We need some thing for add_memory(), its variants and
also possibly for memremap_pages() when it calls arch_add_memory().

> 
> What I'd prefer is a way to get
> 
> 1. Lower address limit we can use for add_memory() and friends
> 2. Upper address limit we can use for add_memory() and friends

A structure based range.

> 
> something like
> 
> 
> struct range memhp_get_addressable_range(void)
> {
> 	const u64 max_phys = (1ull << (MAX_PHYSMEM_BITS + 1)) - 1;
> 	struct range range = arch_get_mappable_range();

What would you suggest as the default fallback range if a platform
does not define this callback.

> 
> 	if (range.start > max_phys) {
> 		range.start = 0;
> 		range.end = 0;
> 	}
> 	range.end = max_t(u64, range.end, max_phys);

min_t instead ?

> 
> 	return range;
> }
> 
> 
> That, we can use in check_hotplug_memory_addressable(), and also allow
> add_memory*() users to make use of it.

So this check would happen twice during a hotplug ?
