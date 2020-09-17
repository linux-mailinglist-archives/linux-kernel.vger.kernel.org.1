Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EE8326D910
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 12:33:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726592AbgIQKbU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 06:31:20 -0400
Received: from foss.arm.com ([217.140.110.172]:44236 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726446AbgIQKaU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 06:30:20 -0400
X-Greylist: delayed 444 seconds by postgrey-1.27 at vger.kernel.org; Thu, 17 Sep 2020 06:30:19 EDT
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9AF2230E;
        Thu, 17 Sep 2020 03:22:53 -0700 (PDT)
Received: from [10.57.47.84] (unknown [10.57.47.84])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 35C5C3F68F;
        Thu, 17 Sep 2020 03:22:52 -0700 (PDT)
Subject: Re: [PATCH 2/2] arm64/mm: Enable color zero pages
To:     Gavin Shan <gshan@redhat.com>, Will Deacon <will@kernel.org>
Cc:     mark.rutland@arm.com, anshuman.khandual@arm.com,
        catalin.marinas@arm.com, linux-kernel@vger.kernel.org,
        shan.gavin@gmail.com, linux-arm-kernel@lists.infradead.org
References: <20200916032523.13011-1-gshan@redhat.com>
 <20200916032523.13011-3-gshan@redhat.com>
 <20200916082819.GB27496@willie-the-truck>
 <c1b79a8c-e5a5-f375-87e1-20bbc5cc2707@redhat.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <33e9a04e-9f93-6a06-273d-284900bc1535@arm.com>
Date:   Thu, 17 Sep 2020 11:22:50 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <c1b79a8c-e5a5-f375-87e1-20bbc5cc2707@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-09-17 04:35, Gavin Shan wrote:
> Hi Will,
> 
> On 9/16/20 6:28 PM, Will Deacon wrote:
>> On Wed, Sep 16, 2020 at 01:25:23PM +1000, Gavin Shan wrote:
>>> This enables color zero pages by allocating contigous page frames
>>> for it. The number of pages for this is determined by L1 dCache
>>> (or iCache) size, which is probbed from the hardware.
>>>
>>>     * Add cache_total_size() to return L1 dCache (or iCache) size
>>>
>>>     * Implement setup_zero_pages(), which is called after the page
>>>       allocator begins to work, to allocate the contigous pages
>>>       needed by color zero page.
>>>
>>>     * Reworked ZERO_PAGE() and define __HAVE_COLOR_ZERO_PAGE.
>>>
>>> Signed-off-by: Gavin Shan <gshan@redhat.com>
>>> ---
>>>   arch/arm64/include/asm/cache.h   | 22 ++++++++++++++++++++
>>>   arch/arm64/include/asm/pgtable.h |  9 ++++++--
>>>   arch/arm64/kernel/cacheinfo.c    | 34 +++++++++++++++++++++++++++++++
>>>   arch/arm64/mm/init.c             | 35 ++++++++++++++++++++++++++++++++
>>>   arch/arm64/mm/mmu.c              |  7 -------
>>>   5 files changed, 98 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/arch/arm64/include/asm/cache.h 
>>> b/arch/arm64/include/asm/cache.h
>>> index a4d1b5f771f6..420e9dde2c51 100644
>>> --- a/arch/arm64/include/asm/cache.h
>>> +++ b/arch/arm64/include/asm/cache.h
>>> @@ -39,6 +39,27 @@
>>>   #define CLIDR_LOC(clidr)    (((clidr) >> CLIDR_LOC_SHIFT) & 0x7)
>>>   #define CLIDR_LOUIS(clidr)    (((clidr) >> CLIDR_LOUIS_SHIFT) & 0x7)
>>> +#define CSSELR_TND_SHIFT    4
>>> +#define CSSELR_TND_MASK        (UL(1) << CSSELR_TND_SHIFT)
>>> +#define CSSELR_LEVEL_SHIFT    1
>>> +#define CSSELR_LEVEL_MASK    (UL(7) << CSSELR_LEVEL_SHIFT)
>>> +#define CSSELR_IND_SHIFT    0
>>> +#define CSSERL_IND_MASK        (UL(1) << CSSELR_IND_SHIFT)
>>> +
>>> +#define CCSIDR_64_LS_SHIFT    0
>>> +#define CCSIDR_64_LS_MASK    (UL(7) << CCSIDR_64_LS_SHIFT)
>>> +#define CCSIDR_64_ASSOC_SHIFT    3
>>> +#define CCSIDR_64_ASSOC_MASK    (UL(0x1FFFFF) << CCSIDR_64_ASSOC_SHIFT)
>>> +#define CCSIDR_64_SET_SHIFT    32
>>> +#define CCSIDR_64_SET_MASK    (UL(0xFFFFFF) << CCSIDR_64_SET_SHIFT)
>>> +
>>> +#define CCSIDR_32_LS_SHIFT    0
>>> +#define CCSIDR_32_LS_MASK    (UL(7) << CCSIDR_32_LS_SHIFT)
>>> +#define CCSIDR_32_ASSOC_SHIFT    3
>>> +#define CCSIDR_32_ASSOC_MASK    (UL(0x3FF) << CCSIDR_32_ASSOC_SHIFT)
>>> +#define CCSIDR_32_SET_SHIFT    13
>>> +#define CCSIDR_32_SET_MASK    (UL(0x7FFF) << CCSIDR_32_SET_SHIFT)
>>
>> I don't think we should be inferring cache structure from these register
>> values. The Arm ARM helpfully says:
>>
>>    | You cannot make any inference about the actual sizes of caches based
>>    | on these parameters.
>>
>> so we need to take the topology information from elsewhere.
>>
> 
> Yeah, I also noticed the statement in the spec. However, the L1 cache size
> figured out from above registers are matching with "lscpu" on the machine
> where I did my tests. Note "lscpu" depends on sysfs entries whose 
> information
> is retrieved from ACPI (PPTT) table. The number of cache levels are 
> partially
> retrieved from system register (clidr_el1).
> 
> It's doable to retrieve the L1 cache size from ACPI (PPTT) table. I'll
> change accordingly in v2 if this enablement is really needed. More clarify
> is provided below.
> 
>> But before we get into that, can you justify why we need to do this at 
>> all,
>> please? Do you have data to show the benefit of adding this complexity?
>>
> 
> Initially, I found it's the missed feature which has been enabled on
> mips/s390. Currently, all read-only anonymous VMAs are backed up by
> same zero page. It means all reads to these VMAs are cached by same
> set of cache, but still multiple ways if supported. So it would be
> nice to have multiple zero pages to back up these read-only anonymous
> VMAs, so that the reads on them can be cached by multiple sets (multiple
> ways still if supported). It's overall beneficial to the performance.

Is this a concern for true PIPT caches, or is it really just working 
around a pathological case for alias-detecting VIPT caches?

> Unfortunately, I didn't find a machine where the size of cache set is
> larger than page size. So I had one experiment as indication how L1
> data cache miss affects the overall performance:
> 
>      L1 data cache size:           32KB
>      L1 data cache line size:      64
>      Number of L1 data cache set:  64
>      Number of L1 data cache ways: 8
>      ----------------------------------------------------------------------
>                    size = (cache_line_size) * (num_of_sets) * (num_of_ways)
> 
>      Kernel configuration:
>             VA_BITS:               48
>             PAGE_SIZE:             4KB
>             PMD HugeTLB Page Size: 2MB
> 
>      Experiment:
>             I have a program to do the following things and check the
>             consumed time and L1-data-cache-misses by perf.
> 
>             (1) Allocate (mmap) a PMD HugeTLB Page, which is 2MB.
>             (2) Read on the mmap'd region in step of page size (4KB)
>                 for 8 or 9 times. Note 8 is the number of data cache
>                 ways.
>             (3) Repeat (2) for 1000000 times.
>      Result:
>             (a) when we have 8 for the steps in (2):
>                 37,103      L1-dcache-load-misses
>                 0.217522515 seconds time elapsed
>                 0.217564000 seconds user
>                 0.000000000 seconds sys
>             (b) when we have 9 for the steps in (2):
>                 4,687,932   L1-dcache-load-misses            (126 times)
>                 0.248132105 seconds time elapsed             (+14.2%)
>                 0.248267000 seconds user
>                 0.000000000 seconds sys

I have a vague feeling this may have come up before, but are there 
real-world applications that have a performance bottleneck on reading 
from uninitialised memory? As far as synthetic benchmarks go, I'm sure 
we could equally come up with one that shows a regression due to real 
data being pushed out of the cache by all those extra zeros ;)

Robin.

> Please let me know if it's worthy for a v2, to retrieve the cache size
> from ACPI (PPTT) table. The cost is to allocate multiple zero pages and
> the worst case is fail back to one zero page, as before :)
> 
> Cheers,
> Gavin
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
