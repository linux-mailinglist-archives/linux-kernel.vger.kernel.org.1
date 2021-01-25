Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22F14303566
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 06:41:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729403AbhAZFkV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 00:40:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:29172 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727699AbhAYLC2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 06:02:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611572461;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nXjKbf5cyWq/evw/w8OTc3aqHNnip65/6TqQ+PJNleY=;
        b=Hyxgzf75gY442WJsP2UN0FliNRWjCg+54osjyEQvRC9pO7IcJalcG19q/vUK53zWBJaHcV
        vXOP3hhUBOJ9JEc2XPJ1p1wA63uDWC9LIyayuhpnj8cgmZB0hyzXPkcelkzbAPAxfwusDf
        hgARHnvBUu5p9iy4hrsnKpGHdeVyonQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-374-3Svv2nK8M7KnvKBFWLPeKQ-1; Mon, 25 Jan 2021 05:57:25 -0500
X-MC-Unique: 3Svv2nK8M7KnvKBFWLPeKQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 44A03801B12;
        Mon, 25 Jan 2021 10:57:23 +0000 (UTC)
Received: from [10.36.115.13] (ovpn-115-13.ams2.redhat.com [10.36.115.13])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 721FC5B6A8;
        Mon, 25 Jan 2021 10:57:21 +0000 (UTC)
Subject: Re: [PATCH 2/5] mm,memory_hotplug: Allocate memmap from the added
 memory range
To:     Oscar Salvador <osalvador@suse.de>,
        Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     akpm@linux-foundation.org, mhocko@kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, vbabka@suse.cz,
        pasha.tatashin@soleen.com
References: <20201217130758.11565-1-osalvador@suse.de>
 <20201217130758.11565-3-osalvador@suse.de>
 <21079c2d-67d0-fc59-8d7f-0795b3f8a3e3@redhat.com>
 <20210125103951.GA27851@linux>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <a0193441-4c79-b85e-ff38-e7ab3a462beb@redhat.com>
Date:   Mon, 25 Jan 2021 11:57:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20210125103951.GA27851@linux>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25.01.21 11:39, Oscar Salvador wrote:
> On Tue, Jan 19, 2021 at 02:58:41PM +0100, David Hildenbrand wrote:
>> IIRC, there is a conflict with the hpage vmemmap freeing patch set,
>> right? How are we going to handle that?
> 
> First of all, sorry for the lateness David, was a bit busy.
> 
> AFAIK, there is no conflict at the moment.
> hpage vmemmap populates with basepages (PMD support is disabled).

I don't see how that makes a difference? We end up consuming the altmap
via vmemmap_alloc_block_buf(). Read below, most probably I am missing
something.

> 
> But even with PMD support enabled, I cannot see how it can interfere.
> 
> From the mhp point of view vmemmap pages only matter when allocating it and
> when freeing it.
> The only moment we would have to worry about is when we have to get rid of them
> (aka: the memory range that describe is being hot-removed), but the hpage
> vmemmap patchset makes sure that by the time we return from dissolve_free_huge_page
> the vemmap pages look as they did before the remapping.

Aehm I don't think that's the case. there might be a vmemmap but these
are then other pages than the altmap.

> 
> But as I said, we do not have to worry about this one as that feature only works
> when populating with base pages.

I'm confused.

1. Assume we hotplug memory, online it to ZONE_MOVABLE. The vmemmap gets
allocated from altmap space.

2. Allocate huge pages. The vmemmap gets freed, which ends up freeing
pages in the altmap space that are even PageReserved() and not even
accounted properly in managed pages. Problem?

3. Try offlining memory, skip the altmap space. The altmap pages might
now be used for something else in the meantime. Problem?

This should hold with both, basepages and hugepages in the vmemmap. What
am I missing?

[...]

>> IIRC, it could happen that if we add two consecutive memory blocks, that
>> the second one might reuse parts of the vmemmap residing on the first
>> memory block. If you remove the first one, you might be in trouble.
>>
>> E.g., on x86-64
>>  vmemmap_populate()->vmemmap_populate_hugepages()->vmemmap_alloc_block_buf():
>> - Populate a huge page
>>
>> vmemmap_free()->remove_pagetable()...->remove_pmd_table():
>> - memchr_inv() will leave the hugepage populated.
>>
>> Do we want to fence that off, maybe in mhp_supports_memmap_on_memory()?
>> Or do we somehow want to fix that? We should never populate partial huge
>> pages from an altmap ...
>>
>> But maybe I am missing something.
> 
> No, you are not missing anything.
> 
> I think that remove_pmd_table() should be fixed.
> vmemmap_populate_hugepages() allocates PMD_SIZE chunk and marks the PMD as
> PAGE_KERNEL_LARGE, so when remove_pmd_table() sees that 1) the PMD
> is large and 2) the chunk is not aligned, the memset() should be writing
> PAGE_INUSE for a PMD chunk.

I tried to handle such stuff (dealing with partially present vmemmap on
a PMD) a little bit smarter in the s390x code I added recently.

Anyhow, we should never ever consume memory from an altmap when it might
cover more than the added range; that really only works with anon
memory, but not with memory from the altmap space.

> 
> I do not really a see a reason why this should not happen.
> Actually, we will be leaving pagetables behind as we never get to free
> the PMD chunk when sizeof(struct page) is not a multiple of 2MB.
> 
> I plan to fix remove_pmd_table(), but for now let us not allow to use this feature
> if the size of a struct page is not 64.
> Let us keep it simply for the time being, shall we?

Fine with me, as long as we never ever accidentally allocate more from
the altmap than we actually need - the vmemmap must either span complete
PMDs or we have to fallback to PTEs for the problematic parts.

So while we require "IS_ALIGNED(nr_vmemmap_pages, pageblock_nr_pages)",
we actually require here "IS_ALIGNED(nr_vmemmap_pages, PMD_SIZE >>
PAGE_SHIFT)" IIUC. (+ alignment of the start address)

For x86-64 this holds, for arm64 as well at least for 4k base pages. I
*hope* 64k base pages never ever use PMDs (512MB) in the vmemmap when
hotplugging :D (did not check, but I assume they don't, would be
horribly ugly otherwise)

> 
>>>  	/* set above range as isolated */
>>> -	ret = start_isolate_page_range(start_pfn, end_pfn,
>>> +	ret = start_isolate_page_range(buddy_start_pfn, end_pfn,
>>>  				       MIGRATE_MOVABLE,
>>>  				       MEMORY_OFFLINE | REPORT_FAILURE);
>>
>> If buddy_start_pfn is not aligned to pageblocks,
>> start_isolate_page_range will BUG_ON(). another sign that we need to
>> check that somewhere while adding that nr_vmemmap_pages is suitable.
> 
> Will come up with a way to 1) ensure that vmemmap pages is aligned and
> 2) disallow to use the feature in case it cannot be aligned for some reason.
> 
>  
>> Let's avoid using the "memblock" terminology. Just call it
>> "get_nr_vmemmap_pages_cb" or maybe "detect_memmap_on_memory_cb"
> 
> Fine.
> 
>>> +	unsigned long *nr_vmemmap_pages = (unsigned long *)arg;
>>> +	int ret = !mem->nr_vmemmap_pages;
>>> +
>>> +	if (!ret)
>>> +		*nr_vmemmap_pages += mem->nr_vmemmap_pages;
>>> +	return ret;
>>
>> I think you can avoid "ret".
>>
>> Also, we want to stop whenever we find "mem->nr_vmemmap_pages != 0",
>> right? AFAIU, you would currently stop whenever you find
>> mem->nr_vmemmap_pages == 0", which is wrong.
>>
>> *nr_vmemmap_pages += mem->nr_vmemmap_pages;
>> /* Stop whenever we find any sign of MHP_MEMMAP_ON_MEMORY. */
>> return mem->nr_vmemmap_pages;
> 
> Yeah, true is that current logic is wrong, but we do not want to stop when
> mem->nr_vmemmap_pages == 0 either.

Yeah, as the comment said "Stop whenever we find any sign of
MHP_MEMMAP_ON_MEMORY", whcih is the case with "mem->nr_vmemmap_pages", no?

> Since we want to avoid people to remove with a different granularity than it was
> added, we need to check the whole memory range that is going to be hot-removed
> and check for mem->nr_vmemmap_pages to make sure that the range does not
> have any self-hosted vmemmap pages.
> 
> E.g:
> 
> [memory_block not using vmemmap] memblock#0
> [memory block using vmemmap]	 memblock#1
> 
> So, if someone tries to remove memblock#0 and memblock#1 and once, we need
> to check whether any of the memblocks used self-hosted vmemmap, and if so,
> scream out loud if we are trying to remove site != memblock_size.

That's what my suggestion does, no?


-- 
Thanks,

David / dhildenb

