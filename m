Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AC002F1022
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 11:32:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729186AbhAKKcl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 05:32:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54172 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728959AbhAKKck (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 05:32:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610361073;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/QT/Hp5d8s31dfaDUdmb1dSbYnAGLRZtytEVGSsU3o4=;
        b=BvrqDye1mPhuNgRsVn4VGl20u9ksK6LDNvqcsYIvDnFcqo660qsBqwFzz4UOGAixoIFo9s
        EOQ7oPXcJsMsrjI6E/FKWQ4gF1G/b3eq09nlk0uhD4zBZzuP8T6MkJhaCmj/PBHFSm9a1a
        7OeYCAyFFce6vXZ1xKJf7tsq2qfr1DY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-103-rzFCbHHGPiCPR8n1V_r2cw-1; Mon, 11 Jan 2021 05:31:09 -0500
X-MC-Unique: rzFCbHHGPiCPR8n1V_r2cw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1055E15720;
        Mon, 11 Jan 2021 10:31:07 +0000 (UTC)
Received: from [10.36.115.103] (ovpn-115-103.ams2.redhat.com [10.36.115.103])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 43FEF6A8EE;
        Mon, 11 Jan 2021 10:31:03 +0000 (UTC)
Subject: Re: [RFC 1/2] arm64/mm: Fix pfn_valid() for ZONE_DEVICE based memory
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     catalin.marinas@arm.com, will@kernel.org, ardb@kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        James Morse <james.morse@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Michael Ellerman <michael@ellerman.id.au>
References: <1608621144-4001-1-git-send-email-anshuman.khandual@arm.com>
 <1608621144-4001-2-git-send-email-anshuman.khandual@arm.com>
 <4b282848-d2d7-6156-4726-ce974b2dff41@redhat.com>
 <75d0da03-204a-c2b2-aba9-f70d2f5b6e40@arm.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <3616e9f5-b825-6575-45ce-bfc1b1408c89@redhat.com>
Date:   Mon, 11 Jan 2021 11:31:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <75d0da03-204a-c2b2-aba9-f70d2f5b6e40@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04.01.21 07:18, Anshuman Khandual wrote:
> 
> On 12/22/20 2:41 PM, David Hildenbrand wrote:
>> On 22.12.20 08:12, Anshuman Khandual wrote:
>>> pfn_valid() validates a pfn but basically it checks for a valid struct page
>>> backing for that pfn. It should always return positive for memory ranges
>>> backed with struct page mapping. But currently pfn_valid() fails for all
>>> ZONE_DEVICE based memory types even though they have struct page mapping.
>>>
>>> pfn_valid() asserts that there is a memblock entry for a given pfn without
>>> MEMBLOCK_NOMAP flag being set. The problem with ZONE_DEVICE based memory is
>>> that they do not have memblock entries. Hence memblock_is_map_memory() will
>>> invariably fail via memblock_search() for a ZONE_DEVICE based address. This
>>> eventually fails pfn_valid() which is wrong. memblock_is_map_memory() needs
>>> to be skipped for such memory ranges. As ZONE_DEVICE memory gets hotplugged
>>> into the system via memremap_pages() called from a driver, their respective
>>> memory sections will not have SECTION_IS_EARLY set.
>>>
>>> Normal hotplug memory will never have MEMBLOCK_NOMAP set in their memblock
>>> regions. Because the flag MEMBLOCK_NOMAP was specifically designed and set
>>> for firmware reserved memory regions. memblock_is_map_memory() can just be
>>> skipped as its always going to be positive and that will be an optimization
>>> for the normal hotplug memory. Like ZONE_DEVIE based memory, all hotplugged
>>> normal memory too will not have SECTION_IS_EARLY set for their sections.
>>>
>>> Skipping memblock_is_map_memory() for all non early memory sections would
>>> fix pfn_valid() problem for ZONE_DEVICE based memory and also improve its
>>> performance for normal hotplug memory as well.
>>>
>>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>>> Cc: Will Deacon <will@kernel.org>
>>> Cc: Ard Biesheuvel <ardb@kernel.org>
>>> Cc: Robin Murphy <robin.murphy@arm.com>
>>> Cc: linux-arm-kernel@lists.infradead.org
>>> Cc: linux-kernel@vger.kernel.org
>>> Fixes: 73b20c84d42d ("arm64: mm: implement pte_devmap support")
>>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>>> ---
>>>  arch/arm64/mm/init.c | 12 ++++++++++++
>>>  1 file changed, 12 insertions(+)
>>>
>>> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
>>> index 75addb36354a..ee23bda00c28 100644
>>> --- a/arch/arm64/mm/init.c
>>> +++ b/arch/arm64/mm/init.c
>>> @@ -225,6 +225,18 @@ int pfn_valid(unsigned long pfn)
>>>  
>>>  	if (!valid_section(__pfn_to_section(pfn)))
>>>  		return 0;
>>> +
>>> +	/*
>>> +	 * ZONE_DEVICE memory does not have the memblock entries.
>>> +	 * memblock_is_map_memory() check for ZONE_DEVICE based
>>> +	 * addresses will always fail. Even the normal hotplugged
>>> +	 * memory will never have MEMBLOCK_NOMAP flag set in their
>>> +	 * memblock entries. Skip memblock search for all non early
>>> +	 * memory sections covering all of hotplug memory including
>>> +	 * both normal and ZONE_DEVIE based.
>>> +	 */
>>> +	if (!early_section(__pfn_to_section(pfn)))
>>> +		return 1;
>>
>> Actually, I think we want to check for partial present sections.
>>
>> Maybe we can rather switch to generic pfn_valid() and tweak it to
>> something like
>>
>> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
>> index fb3bf696c05e..7b1fcce5bd5a 100644
>> --- a/include/linux/mmzone.h
>> +++ b/include/linux/mmzone.h
>> @@ -1382,9 +1382,13 @@ static inline int pfn_valid(unsigned long pfn)
>>                 return 0;
>>         /*
>>          * Traditionally early sections always returned pfn_valid() for
>> -        * the entire section-sized span.
>> +        * the entire section-sized span. Some archs might have holes in
>> +        * early sections, so double check with memblock if configured.
>>          */
>> -       return early_section(ms) || pfn_section_valid(ms, pfn);
>> +       if (early_section(ms))
>> +               return IS_ENABLED(CONFIG_EARLY_SECTION_MEMMAP_HOLES) ?
>> +                      memblock_is_map_memory(pfn << PAGE_SHIFT) : 1;
>> +       return pfn_section_valid(ms, pfn);
>>  }
>>  #endif
> 
> Could not find CONFIG_EARLY_SECTION_MEMMAP_HOLES. Are you suggesting to
> create this config which could track platform scenarios where all early
> sections might not have mmap coverage such as arm64 ?

Yes, a new config that states what's actually happening.

> 
>>
>>
>>
>> Which users are remaining that require us to add/remove memblocks when
>> hot(un)plugging memory
>>
>>  $ git grep KEEP_MEM | grep memory_hotplug
>> mm/memory_hotplug.c:    if (IS_ENABLED(CONFIG_ARCH_KEEP_MEMBLOCK))
>> mm/memory_hotplug.c:    if (IS_ENABLED(CONFIG_ARCH_KEEP_MEMBLOCK))
>> mm/memory_hotplug.c:    if (IS_ENABLED(CONFIG_ARCH_KEEP_MEMBLOCK)) {
> 
> Did not follow, do we want to drop ARCH_KEEP_MEMBLOCK ? Without it arm64
> will not be able to track MEMBLOCK_NOMAP memory at runtime.

I'd only like the hot(un)plug parts gone for now, if possible: I don't
see the need for that handling really that cannot be handled easier, as
in the proposed pfn_valid() changes.

I understand that current handling of memory holes in early sections and
memory marked as MEMBLOCK_NOMAP requires ARCH_KEEP_MEMBLOCK for now.

> 
>>
>>
>> I think one user we would have to handle is
>> arch/arm64/mm/mmap.c:valid_phys_addr_range(). AFAIS, powerpc at least
>> does not rely on memblock_is_map_memory.
> 
> memblock_is_map_memory() is currently used only on arm/arm64 platforms.
> Apart from the above example in valid_phys_addr_range(), there are some
> other memblock_is_map_memory() call sites as well. But then, we are not
> trying to completely drop memblock_is_map_memory() or are we ?

No, just change the semantics: only relevant for early sections. Imagine
freezing MEMBLOCK state after boot.

Only early sections can have memory holes and might be marked
MEMBLOCK_NOMAP. For hotplugged memory, we don't have to call
memblock_is_map_memory().

-- 
Thanks,

David / dhildenb

