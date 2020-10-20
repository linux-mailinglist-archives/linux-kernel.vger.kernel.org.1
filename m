Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4B20284605
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 08:29:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727033AbgJFG31 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 02:29:27 -0400
Received: from foss.arm.com ([217.140.110.172]:39454 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726022AbgJFG31 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 02:29:27 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3C9B71435;
        Mon,  5 Oct 2020 23:29:26 -0700 (PDT)
Received: from [10.163.74.99] (unknown [10.163.74.99])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B50FF3F66B;
        Mon,  5 Oct 2020 23:29:22 -0700 (PDT)
Subject: Re: [PATCH] arm64/mm: Validate hotplug range before creating linear
 mapping
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Will Deacon <will@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Steven Price <steven.price@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1600332402-30123-1-git-send-email-anshuman.khandual@arm.com>
 <20200928203539.GA12218@willie-the-truck>
 <09266aed-7eef-5b16-5d52-0dcb7dcb7246@arm.com>
 <20200929152221.GA13995@willie-the-truck>
 <f44d34df-8a21-712c-138d-f7f633b0eb6c@arm.com>
 <CAMj1kXGhja2cxQOpnboj1mos314Nku209dkgmmz74X3wq=j8Rg@mail.gmail.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <0784f1ec-c044-7fc8-70dc-a378c2b586fa@arm.com>
Date:   Tue, 6 Oct 2020 11:58:51 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAMj1kXGhja2cxQOpnboj1mos314Nku209dkgmmz74X3wq=j8Rg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/30/2020 04:31 PM, Ard Biesheuvel wrote:
> On Wed, 30 Sep 2020 at 10:03, Anshuman Khandual
> <anshuman.khandual@arm.com> wrote:
>>
>>
>> On 09/29/2020 08:52 PM, Will Deacon wrote:
>>> On Tue, Sep 29, 2020 at 01:34:24PM +0530, Anshuman Khandual wrote:
>>>>
>>>>
>>>> On 09/29/2020 02:05 AM, Will Deacon wrote:
>>>>> On Thu, Sep 17, 2020 at 02:16:42PM +0530, Anshuman Khandual wrote:
>>>>>> During memory hotplug process, the linear mapping should not be created for
>>>>>> a given memory range if that would fall outside the maximum allowed linear
>>>>>> range. Else it might cause memory corruption in the kernel virtual space.
>>>>>>
>>>>>> Maximum linear mapping region is [PAGE_OFFSET..(PAGE_END -1)] accommodating
>>>>>> both its ends but excluding PAGE_END. Max physical range that can be mapped
>>>>>> inside this linear mapping range, must also be derived from its end points.
>>>>>>
>>>>>> When CONFIG_ARM64_VA_BITS_52 is enabled, PAGE_OFFSET is computed with the
>>>>>> assumption of 52 bits virtual address space. However, if the CPU does not
>>>>>> support 52 bits, then it falls back using 48 bits instead and the PAGE_END
>>>>>> is updated to reflect this using the vabits_actual. As for PAGE_OFFSET,
>>>>>> bits [51..48] are ignored by the MMU and remain unchanged, even though the
>>>>>> effective start address of linear map is now slightly different. Hence, to
>>>>>> reliably check the physical address range mapped by the linear map, the
>>>>>> start address should be calculated using vabits_actual. This ensures that
>>>>>> arch_add_memory() validates memory hot add range for its potential linear
>>>>>> mapping requirement, before creating it with __create_pgd_mapping().
>>>>>>
>>>>>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>>>>>> Cc: Will Deacon <will@kernel.org>
>>>>>> Cc: Mark Rutland <mark.rutland@arm.com>
>>>>>> Cc: Ard Biesheuvel <ardb@kernel.org>
>>>>>> Cc: Steven Price <steven.price@arm.com>
>>>>>> Cc: Robin Murphy <robin.murphy@arm.com>
>>>>>> Cc: David Hildenbrand <david@redhat.com>
>>>>>> Cc: Andrew Morton <akpm@linux-foundation.org>
>>>>>> Cc: linux-arm-kernel@lists.infradead.org
>>>>>> Cc: linux-kernel@vger.kernel.org
>>>>>> Fixes: 4ab215061554 ("arm64: Add memory hotplug support")
>>>>>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>>>>>> ---
>>>>>>  arch/arm64/mm/mmu.c | 27 +++++++++++++++++++++++++++
>>>>>>  1 file changed, 27 insertions(+)
>>>>>>
>>>>>> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
>>>>>> index 75df62fea1b6..d59ffabb9c84 100644
>>>>>> --- a/arch/arm64/mm/mmu.c
>>>>>> +++ b/arch/arm64/mm/mmu.c
>>>>>> @@ -1433,11 +1433,38 @@ static void __remove_pgd_mapping(pgd_t *pgdir, unsigned long start, u64 size)
>>>>>>    free_empty_tables(start, end, PAGE_OFFSET, PAGE_END);
>>>>>>  }
>>>>>>
>>>>>> +static bool inside_linear_region(u64 start, u64 size)
>>>>>> +{
>>>>>> +  /*
>>>>>> +   * Linear mapping region is the range [PAGE_OFFSET..(PAGE_END - 1)]
>>>>>> +   * accommodating both its ends but excluding PAGE_END. Max physical
>>>>>> +   * range which can be mapped inside this linear mapping range, must
>>>>>> +   * also be derived from its end points.
>>>>>> +   *
>>>>>> +   * With CONFIG_ARM64_VA_BITS_52 enabled, PAGE_OFFSET is defined with
>>>>>> +   * the assumption of 52 bits virtual address space. However, if the
>>>>>> +   * CPU does not support 52 bits, it falls back using 48 bits and the
>>>>>> +   * PAGE_END is updated to reflect this using the vabits_actual. As
>>>>>> +   * for PAGE_OFFSET, bits [51..48] are ignored by the MMU and remain
>>>>>> +   * unchanged, even though the effective start address of linear map
>>>>>> +   * is now slightly different. Hence, to reliably check the physical
>>>>>> +   * address range mapped by the linear map, the start address should
>>>>>> +   * be calculated using vabits_actual.
>>>>>> +   */
>>>>>> +  return ((start >= __pa(_PAGE_OFFSET(vabits_actual)))
>>>>>> +                  && ((start + size) <= __pa(PAGE_END - 1)));
>>>>>> +}
>>>>>
>>>>> Why isn't this implemented using the existing __is_lm_address()?
>>>>
>>>> Not sure, if I understood your suggestion here. The physical address range
>>>> [start..start + size] needs to be checked against maximum physical range
>>>> that can be represented inside effective boundaries for the linear mapping
>>>> i.e [__pa(_PAGE_OFFSET(vabits_actual)..__pa(PAGE_END - 1)].
>>>>
>>>> Are you suggesting [start..start + size] should be first be converted into
>>>> a virtual address range and then checked against __is_lm_addresses() ? But
>>>> is not deriving the physical range from from know limits of linear mapping
>>>> much cleaner ?
>>>
>>> I just think having a function called "inside_linear_region()" as well as a
>>> macro called "__is_lm_address()" is weird when they have completely separate
>>> implementations. They're obviously trying to do the same thing, just the
>>> first one gets given physical address as parameters.
>>>
>>> Implementing one in terms of the other is much better for maintenance.
>>
>> /*
>>  * The linear kernel range starts at the bottom of the virtual address
>>  * space. Testing the top bit for the start of the region is a
>>  * sufficient check and avoids having to worry about the tag.
>>  */
>> #define __is_lm_address(addr)   (!(((u64)addr) & BIT(vabits_actual - 1)))
>>
>> __is_lm_address() currently just check the highest bit in a virtual address
>> where the linear mapping ends i.e the lower half and all other kernel mapping
>> starts i.e the upper half. But I would believe, it misses the blind range
>> [_PAGE_OFFSET(VA_BITS).._PAGE_OFFSET(vabits_actual)] in some configurations,
>> even though it does not really affect anything because it gets ignored by the
>> MMU. Hence in current form __is_lm_address() cannot be used to derive maximum
>> linear range and it's corresponding physical range for hotplug range check.
>>
> 
> This is actually something that I brought up when the 52-bit VA
> changes were under review: currently, we split the VA space in half,
> and use the lower half for the linear range, and the upper half for
> vmalloc, kernel, modules, vmemmap etc

Right.

> 
> When we run a 48-bit kernel on 52-bit capable hardware, we mostly
> stick with the same arrangement: 2^51 bytes of linear range, but only
> 2^47 bytes of vmalloc range (as the size is fixed), and so we are
> wasting 15/16 of the vmalloc region (2^51 - 2^47), by not using it to
> map anything.

Right, there are unused gaps in the kernel virtual space with current
arrangement for various sections.

> 
> So it would be better to get away from this notion that the VA space
> is divided evenly between linear and vmalloc regions, and use the
> entire range between ~0 << 52 and ~0 << 47 for the linear region (Note
> that the KASAN region defimnition will overlap the linear region in
> this case, by we should be able to sort that at runtime)

Right, kernel virtual space management needs rethink for optimal address
range utilization while reducing unused areas. I have been experimenting
with this for a while but nothing particular to propose yet. Nonetheless
for now, we need to fix this address range problem for memory hotplug.
