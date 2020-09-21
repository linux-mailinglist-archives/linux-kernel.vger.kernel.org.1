Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D406F27197D
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 04:59:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726326AbgIUC5C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Sep 2020 22:57:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:35766 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726104AbgIUC5C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Sep 2020 22:57:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600657020;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YeKw+/y7Dc2RU9VjLNTsXLBHSQ9qLyRYCz78WrOYT30=;
        b=UNYinvlQjwfskOy4F4KiP4Vd+1Qb8GuElSTNVc6l4W1NDoMdKqiYvsjp3MiAWt4bM+ha06
        y/oxwrzlvP37LN6tb3rRfr2/j5GcK+atvQUG3sxkBQ0tPX8VE4z4SQEdp1bU3Lbbz3hh5F
        +pugu3odp+hInyWP85BqZLV4ENAaFXA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-370-7Gw7oaaNPXi57DyeyO4ITw-1; Sun, 20 Sep 2020 22:56:55 -0400
X-MC-Unique: 7Gw7oaaNPXi57DyeyO4ITw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 47D111005E5B;
        Mon, 21 Sep 2020 02:56:54 +0000 (UTC)
Received: from [10.64.54.34] (vpn2-54-34.bne.redhat.com [10.64.54.34])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C6B495D9D5;
        Mon, 21 Sep 2020 02:56:51 +0000 (UTC)
Reply-To: Gavin Shan <gshan@redhat.com>
Subject: Re: [PATCH 2/2] arm64/mm: Enable color zero pages
To:     Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>
Cc:     mark.rutland@arm.com, anshuman.khandual@arm.com,
        catalin.marinas@arm.com, linux-kernel@vger.kernel.org,
        shan.gavin@gmail.com, linux-arm-kernel@lists.infradead.org
References: <20200916032523.13011-1-gshan@redhat.com>
 <20200916032523.13011-3-gshan@redhat.com>
 <20200916082819.GB27496@willie-the-truck>
 <c1b79a8c-e5a5-f375-87e1-20bbc5cc2707@redhat.com>
 <33e9a04e-9f93-6a06-273d-284900bc1535@arm.com>
From:   Gavin Shan <gshan@redhat.com>
Message-ID: <968a5ae7-ebed-8191-15df-6c9860dc72fe@redhat.com>
Date:   Mon, 21 Sep 2020 12:56:47 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <33e9a04e-9f93-6a06-273d-284900bc1535@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robin,

On 9/17/20 8:22 PM, Robin Murphy wrote:
> On 2020-09-17 04:35, Gavin Shan wrote:
>> On 9/16/20 6:28 PM, Will Deacon wrote:
>>> On Wed, Sep 16, 2020 at 01:25:23PM +1000, Gavin Shan wrote:
>>>> This enables color zero pages by allocating contigous page frames
>>>> for it. The number of pages for this is determined by L1 dCache
>>>> (or iCache) size, which is probbed from the hardware.
>>>>
>>>>     * Add cache_total_size() to return L1 dCache (or iCache) size
>>>>
>>>>     * Implement setup_zero_pages(), which is called after the page
>>>>       allocator begins to work, to allocate the contigous pages
>>>>       needed by color zero page.
>>>>
>>>>     * Reworked ZERO_PAGE() and define __HAVE_COLOR_ZERO_PAGE.
>>>>
>>>> Signed-off-by: Gavin Shan <gshan@redhat.com>
>>>> ---
>>>>   arch/arm64/include/asm/cache.h   | 22 ++++++++++++++++++++
>>>>   arch/arm64/include/asm/pgtable.h |  9 ++++++--
>>>>   arch/arm64/kernel/cacheinfo.c    | 34 +++++++++++++++++++++++++++++++
>>>>   arch/arm64/mm/init.c             | 35 ++++++++++++++++++++++++++++++++
>>>>   arch/arm64/mm/mmu.c              |  7 -------
>>>>   5 files changed, 98 insertions(+), 9 deletions(-)
>>>>
>>>> diff --git a/arch/arm64/include/asm/cache.h b/arch/arm64/include/asm/cache.h
>>>> index a4d1b5f771f6..420e9dde2c51 100644
>>>> --- a/arch/arm64/include/asm/cache.h
>>>> +++ b/arch/arm64/include/asm/cache.h
>>>> @@ -39,6 +39,27 @@
>>>>   #define CLIDR_LOC(clidr)    (((clidr) >> CLIDR_LOC_SHIFT) & 0x7)
>>>>   #define CLIDR_LOUIS(clidr)    (((clidr) >> CLIDR_LOUIS_SHIFT) & 0x7)
>>>> +#define CSSELR_TND_SHIFT    4
>>>> +#define CSSELR_TND_MASK        (UL(1) << CSSELR_TND_SHIFT)
>>>> +#define CSSELR_LEVEL_SHIFT    1
>>>> +#define CSSELR_LEVEL_MASK    (UL(7) << CSSELR_LEVEL_SHIFT)
>>>> +#define CSSELR_IND_SHIFT    0
>>>> +#define CSSERL_IND_MASK        (UL(1) << CSSELR_IND_SHIFT)
>>>> +
>>>> +#define CCSIDR_64_LS_SHIFT    0
>>>> +#define CCSIDR_64_LS_MASK    (UL(7) << CCSIDR_64_LS_SHIFT)
>>>> +#define CCSIDR_64_ASSOC_SHIFT    3
>>>> +#define CCSIDR_64_ASSOC_MASK    (UL(0x1FFFFF) << CCSIDR_64_ASSOC_SHIFT)
>>>> +#define CCSIDR_64_SET_SHIFT    32
>>>> +#define CCSIDR_64_SET_MASK    (UL(0xFFFFFF) << CCSIDR_64_SET_SHIFT)
>>>> +
>>>> +#define CCSIDR_32_LS_SHIFT    0
>>>> +#define CCSIDR_32_LS_MASK    (UL(7) << CCSIDR_32_LS_SHIFT)
>>>> +#define CCSIDR_32_ASSOC_SHIFT    3
>>>> +#define CCSIDR_32_ASSOC_MASK    (UL(0x3FF) << CCSIDR_32_ASSOC_SHIFT)
>>>> +#define CCSIDR_32_SET_SHIFT    13
>>>> +#define CCSIDR_32_SET_MASK    (UL(0x7FFF) << CCSIDR_32_SET_SHIFT)
>>>
>>> I don't think we should be inferring cache structure from these register
>>> values. The Arm ARM helpfully says:
>>>
>>>    | You cannot make any inference about the actual sizes of caches based
>>>    | on these parameters.
>>>
>>> so we need to take the topology information from elsewhere.
>>>
>>
>> Yeah, I also noticed the statement in the spec. However, the L1 cache size
>> figured out from above registers are matching with "lscpu" on the machine
>> where I did my tests. Note "lscpu" depends on sysfs entries whose information
>> is retrieved from ACPI (PPTT) table. The number of cache levels are partially
>> retrieved from system register (clidr_el1).
>>
>> It's doable to retrieve the L1 cache size from ACPI (PPTT) table. I'll
>> change accordingly in v2 if this enablement is really needed. More clarify
>> is provided below.
>>
>>> But before we get into that, can you justify why we need to do this at all,
>>> please? Do you have data to show the benefit of adding this complexity?
>>>
>>
>> Initially, I found it's the missed feature which has been enabled on
>> mips/s390. Currently, all read-only anonymous VMAs are backed up by
>> same zero page. It means all reads to these VMAs are cached by same
>> set of cache, but still multiple ways if supported. So it would be
>> nice to have multiple zero pages to back up these read-only anonymous
>> VMAs, so that the reads on them can be cached by multiple sets (multiple
>> ways still if supported). It's overall beneficial to the performance.
> 
> Is this a concern for true PIPT caches, or is it really just working around a pathological case for alias-detecting VIPT caches?
> 

I think it's definitely a concern for PIPT caches. However, I'm not
sure about VIPT caches because I failed to understand how it works
from ARM8-A spec. If I'm correct, the index of VIPT cache line is
still determined by the physical address and the number of sets is
another limitation? For example, two virtual addresses (v1) and (v2)
are translated to same physical address (p1), there is still one
cache line (from particular set) for them. If so, this should helps
in terms of performance.

However, I'm not sure I understood VIPT caches correctly because there
is one statement in the ARM8-A spec as below. It seems (v1) and (v2)
can be backed by two different cache line from one particular set.

----

The only architecturally-guaranteed way to invalidate all aliases of
a PA from a VIPT instruction cache is to invalidate the entire instruction
cache.

>> Unfortunately, I didn't find a machine where the size of cache set is
>> larger than page size. So I had one experiment as indication how L1
>> data cache miss affects the overall performance:
>>
>>      L1 data cache size:           32KB
>>      L1 data cache line size:      64
>>      Number of L1 data cache set:  64
>>      Number of L1 data cache ways: 8
>>      ----------------------------------------------------------------------
>>                    size = (cache_line_size) * (num_of_sets) * (num_of_ways)
>>
>>      Kernel configuration:
>>             VA_BITS:               48
>>             PAGE_SIZE:             4KB
>>             PMD HugeTLB Page Size: 2MB
>>
>>      Experiment:
>>             I have a program to do the following things and check the
>>             consumed time and L1-data-cache-misses by perf.
>>
>>             (1) Allocate (mmap) a PMD HugeTLB Page, which is 2MB.
>>             (2) Read on the mmap'd region in step of page size (4KB)
>>                 for 8 or 9 times. Note 8 is the number of data cache
>>                 ways.
>>             (3) Repeat (2) for 1000000 times.
>>      Result:
>>             (a) when we have 8 for the steps in (2):
>>                 37,103      L1-dcache-load-misses
>>                 0.217522515 seconds time elapsed
>>                 0.217564000 seconds user
>>                 0.000000000 seconds sys
>>             (b) when we have 9 for the steps in (2):
>>                 4,687,932   L1-dcache-load-misses            (126 times)
>>                 0.248132105 seconds time elapsed             (+14.2%)
>>                 0.248267000 seconds user
>>                 0.000000000 seconds sys
> 
> I have a vague feeling this may have come up before, but are there real-world applications that have a performance bottleneck on reading from uninitialised memory? As far as synthetic benchmarks go, I'm sure we could equally come up with one that shows a regression due to real data being pushed out of the cache by all those extra zeros ;)

[...]

Ok. If this was proposed before, I'm not sure if the link to that
patchset is still available? :)

When I was searching "my_zero_pfn" in upstream kernel, DAX uses the
zero pages to fill the holes in one particular file in dax_load_hole().
mmap() on /proc/kcore could use zero page either.

Yes, it's correct that the data cache has more chance to be flushed by
these extra zeroes. However, it's not why we compromise the performance
on reading zero page and depress it intentionally. The cache lines won't
be used if there is no reading activities on zero page :)

Cheers,
Gavin

  

