Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D251E2C51C4
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 11:06:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387618AbgKZKF0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 05:05:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:60721 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729690AbgKZKFZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 05:05:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606385123;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VjDMwHQ6rM7OPptuiZGZJahZzJXs0J8TltnG2y82uLY=;
        b=RWdbRdGEF21vl2lzYtWWB+SaFvhA6AmUbJfBllG1DzdzlHTNE+kmMl3AkGM+d2wW13b7hh
        EUCUkABJ4gq0tefzePXHVGzAG6hwEmPfxPHWi5gqsP9dOFRRAk7u3dTOIX/CiA8/0pHqpO
        uH23Bjpz25+aGj0BYDiS+SPnjQa75MU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-92-AonnByU5MQql0KZ5Hqoo3A-1; Thu, 26 Nov 2020 05:05:19 -0500
X-MC-Unique: AonnByU5MQql0KZ5Hqoo3A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B7F5B1E7E5;
        Thu, 26 Nov 2020 10:05:17 +0000 (UTC)
Received: from [10.36.114.243] (ovpn-114-243.ams2.redhat.com [10.36.114.243])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5366F60636;
        Thu, 26 Nov 2020 10:05:15 +0000 (UTC)
Subject: Re: [PATCH 1/1] mm: compaction: avoid fast_isolate_around() to set
 pageblock_skip on reserved pages
To:     Mike Rapoport <rppt@linux.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>, Mel Gorman <mgorman@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Qian Cai <cai@lca.pw>, Michal Hocko <mhocko@kernel.org>,
        linux-kernel@vger.kernel.org, Baoquan He <bhe@redhat.com>
References: <X73s8fxDKPRD6wET@redhat.com>
 <35F8AADA-6CAA-4BD6-A4CF-6F29B3F402A4@redhat.com>
 <X76iatgBErQH5El4@redhat.com>
 <a4cc62ba-8066-3e9c-cead-98cd74d313dd@redhat.com>
 <20201125210414.GO123287@linux.ibm.com> <X77OyM8utmWcq1Di@redhat.com>
 <20201126093602.GQ123287@linux.ibm.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <3bb709a7-6100-aa5c-4125-7ed80c6d9643@redhat.com>
Date:   Thu, 26 Nov 2020 11:05:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201126093602.GQ123287@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26.11.20 10:36, Mike Rapoport wrote:
> On Wed, Nov 25, 2020 at 04:38:16PM -0500, Andrea Arcangeli wrote:
>> On Wed, Nov 25, 2020 at 11:04:14PM +0200, Mike Rapoport wrote:
>>> I think the very root cause is how e820__memblock_setup() registers
>>> memory with memblock:
>>>
>>> 		if (entry->type == E820_TYPE_SOFT_RESERVED)
>>> 			memblock_reserve(entry->addr, entry->size);
>>>
>>> 		if (entry->type != E820_TYPE_RAM && entry->type != E820_TYPE_RESERVED_KERN)
>>> 			continue;
>>>
>>> 		memblock_add(entry->addr, entry->size);
>>>
>>> From that point the system has inconsistent view of RAM in both
>>> memblock.memory and memblock.reserved and, which is then translated to
>>> memmap etc.
>>>
>>> Unfortunately, simply adding all RAM to memblock is not possible as
>>> there are systems that for them "the addresses listed in the reserved
>>> range must never be accessed, or (as we discovered) even be reachable by
>>> an active page table entry" [1].
>>>
>>> [1] https://lore.kernel.org/lkml/20200528151510.GA6154@raspberrypi/
>>
>> It looks like what's missing is a blockmem_reserve which I don't think
>> would interfere at all with the issue above since it won't create
>> direct mapping and it'll simply invoke the second stage that wasn't
>> invoked here.
>>
>> I guess this would have a better chance to have the second
>> initialization stage run in reserve_bootmem_region and it would likely
>> solve the problem without breaking E820_TYPE_RESERVED which is known
>> by the kernel:
>>
>>> 		if (entry->type == E820_TYPE_SOFT_RESERVED)
>>> 			memblock_reserve(entry->addr, entry->size);
>>>
>>
>> +		if (entry->type == 20)
>> +			memblock_reserve(entry->addr, entry->size);
>>
>>> 		if (entry->type != E820_TYPE_RAM && entry->type != E820_TYPE_RESERVED_KERN)
>>> 			continue;
>>>
>>
>> This is however just to show the problem, I didn't check what type 20
>> is.
> 
> I think it's inveneted by your BIOS vendor :)
> 
>> To me it doesn't look the root cause though, the root cause is that if
>> you don't call memblock_reserve the page->flags remains uninitialized.
> 
> I didn't mean that root cause is that we don't call memblock_reserve().
> I meant that the root cause is inconsitency in memory representation.
> 
> On most architectures, memblock.memory represents the entire RAM in the
> system and memblock.reserved represents memory regions that were
> reserved either by the firmware or by the kernel during early boot.
> 
> On x86 the memory that firmware reserved for its use is never considered
> memory and some of the reserved memory types are never registered with
> memblock at all.
> 
> As memblock data is used to initialize the memory map, we end up with
> some page structs not being properly initialized.
> 
>> I think the page_alloc.c need to be more robust and detect at least if
>> if holes within zones (but ideally all pfn_valid of all struct pages
>> in system even if beyond the end of the zone) aren't being initialized
>> in the second stage without relying on the arch code to remember to
>> call memblock_reserve.
> 
> I agree that page_alloc.c needs to be more robust, but it anyway needs
> to rely on some data supplied by arch to know where valid memory is.
> With SPARSMEM, pfn_valid() only says where memmap exists, it's not
> necessary there is an actual page frame behind a valid pfn.
> 
>> In fact it's not clear why memblock_reserve even exists, that
>> information can be calculated reliably by page_alloc in function of
>> memblock.memory alone by walking all nodes and all zones. It doesn't
>> even seem to help in destroying the direct mapping,
>> reserve_bootmem_region just initializes the struct pages so it doesn't
>> need a special memeblock_reserved to find those ranges.
> 
> memblock_reserve() is there to allow architectures to mark memory
> regions as busy so this memory won't be used by buddy as free pages. It
> could be memory that firmware reported as reserved, memory occupied by
> the kernel image and initrd, or the early memory allocations kernel does
> before page allocator is up.
> 
>> In fact it's scary that codes then does stuff like this trusting the
>> memblock_reserve is nearly complete information (which obviously isn't
>> given type 20 doesn't get queued and I got that type 20 in all my systems):
>>
>> 	for_each_reserved_mem_region(i, &start, &end) {
>> 		if (addr >= start && addr_end <= end)
>> 			return true;
>> 	}
>>
>> That code in irq-gic-v3-its.c should stop using
>> for_each_reserved_mem_region and start doing
>> pfn_valid(addr>>PAGE_SHIFT) if
>> PageReserved(pfn_to_page(addr>>PAGE_SHIFT)) instead.
> 
> I think that for coldpluged CPUs this code runs before memmap us set up,
> so pfn_valid() or PageReserved() are not yet available then.
> 
>> At best memory.reserved should be calculated automatically by the
>> page_alloc.c based on the zone_start_pfn/zone_end_pfn and not passed
>> by the e820 caller, instead of adding the memory_reserve call for type
>> 20 we should delete the memory_reserve function.
>  
> memory.reserved cannot be calculated automatically. It represents all
> the memory allocations made before page allocator is up. And as
> memblock_reserve() is the most basic to allocate memory early at boot we
> cannot really delete it ;-)
> 
> As for e820 and type 20, unless it is in memblock, page_alloc.c has no
> way to properly initialize memmap for it. It can continue to guess, like
> it does with init_unavailable_memory().

AFAIS, init_unavailable_mem() has to logic to setup *any* such struct
page properly up - except the node/zid, because that's unknown at that
time. It is documented that (big comment above init_unavailable_mem())
which pages won't get initialized again. They *are* initialized, just
the node/zone is "fake" - that's the real problem we seem to have.

I agree that this is sub-optimal, as such pages are impossible to detect
(PageReserved is just not clear as discussed with Andrea). The basic
question is how we want to proceed:

a) Make sure any online struct page has a valid nid/zid, and is spanned
by the nid/zid.
b) Use a fake nid that will bail out when used for page_zone() and
page_pgdat(), and make pfn walkers detect that.

AFAIU, Andrea seems to prefer a). I thing b) might be easier in corner
cases. Thoughts?

---

The tricky thing for b) is to fix all call places that do a
page_zone()/page_pgdat() without checking if they are allowed to do so.
We would have to audit all callers of page_zone() / page_zone_id() /
page_pgdat() ...


E.g., using a pattern like
mm/memory_hotplug.c:find_biggest_section_pfn() is fine


if (unlikely(!pfn_to_online_page(pfn)))
	continue;
if (unlikely(pfn_to_nid(pfn) != nid))
	continue;


e.g., mm/page_alloc.c:__pageblock_pfn_to_page() would have to be adjusted

start_page = pfn_to_online_page(start_pfn);
if (!start_page)
	return NULL;

// necessary to avoid ...
if (page_to_nid(page) == NODE_INVALID)
	return NULL;

// page_zone() from bailing out
if (page_zone(start_page) != zone)
	return NULL;

-- 
Thanks,

David / dhildenb

