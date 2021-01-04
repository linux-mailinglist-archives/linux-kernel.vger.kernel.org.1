Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 613542E97AC
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 15:54:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726950AbhADOxI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 09:53:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:49403 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725889AbhADOxI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 09:53:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1609771900;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gxcfWJQksOjY0DyqWcZrS6xpnJ2DbSipm7BPCLqL/EU=;
        b=SpClmOA/JKj7T1O4xV3x0X4Aeziedbnob5ihtEzuAAI38KT//o6syR2mvXkcDM2/QvfUNX
        Tmgc4lAxFP2o0F3qkSaEvyqqY78E46yvzgJpQCwFOgGY+F+2YmBIEA3TrJ/716dZkuP+JQ
        jJ/QQi7HFBGyJgLZTAl71jsGXMQx/as=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-370-DleNEs_zNJaPQVW8H-8F9w-1; Mon, 04 Jan 2021 09:51:38 -0500
X-MC-Unique: DleNEs_zNJaPQVW8H-8F9w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9AAA3190D340;
        Mon,  4 Jan 2021 14:51:37 +0000 (UTC)
Received: from [10.36.114.59] (ovpn-114-59.ams2.redhat.com [10.36.114.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 498FE6F81E;
        Mon,  4 Jan 2021 14:51:36 +0000 (UTC)
Subject: Re: uninitialized pmem struct pages
To:     Michal Hocko <mhocko@suse.com>
Cc:     Dan Williams <dan.j.williams@intel.com>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Oscar Salvador <osalvador@suse.de>
References: <20210104100323.GC13207@dhcp22.suse.cz>
 <033e1cd6-9762-5de6-3e88-47d3038fda7f@redhat.com>
 <20210104142624.GI13207@dhcp22.suse.cz>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <23a4eea2-9fdb-fd1d-ee92-9cd8ac6e8f41@redhat.com>
Date:   Mon, 4 Jan 2021 15:51:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20210104142624.GI13207@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04.01.21 15:26, Michal Hocko wrote:
> On Mon 04-01-21 11:45:39, David Hildenbrand wrote:
>> On 04.01.21 11:03, Michal Hocko wrote:
>>> Hi,
>>> back in March [1] you have recommended 53cdc1cb29e8
>>> ("drivers/base/memory.c: indicate all memory blocks as removable") to be
>>> backported to stable trees and that has led to a more general discussion
>>> about the current state of pfn walkers wrt. uninitialized pmem struct
>>> pages. We haven't concluded any specific solution for that except for a
>>> general sentiment that pfn_to_online_page should be able to catch those.
>>> I might have missed any follow ups on that but I do not think we have
>>> landed on any actual solution in the end. Have I just missed any followups?
>>
>> Thanks for raising this issue. It's still on my list of "broken and
>> non-trivial to fix" things.
>>
>> So, as far as I recall, we still have the following two issues remaining:
>>
>> 1. pfn_to_online_page() false positives
>>
>> The semantics of pfn_to_online_page() were broken with sub-section
>> hot-add in corner cases.
>>
>> If we have ZONE_DEVICE hot-added memory that overlaps in a section with
>> boot memory, this memory section will contain parts ZONE_DEVICE memory
>> and parts !ZONE_DEVICE memory. This can happen in sub-section
>> granularity (2MB IIRC). pfn_to_online_page() will succeed on ZONE_DEVICE
>> memory parts as the whole section is marked as online. Bad.
> 
> OK, I was not aware of this problem. Anyway, those pages should be still
> allocated and their state should retain their last state. I would have
> to double check but this shouldn't be harmfull. Or what would be an
> actual problem?
> 
>> One instance where this is still an issue is
>> mm/memory-failure.c:memory_failure() and
>> mm/memory-failure.c:soft_offline_page(). I thought for a while about
>> "fixing" these, but to me it felt like fixing pfn_to_online_page() is
>> actually the right approach.
>>
>> But worse, before ZONE_DEVICE hot-add
>> 1. The whole section memmap does already exist (early sections always
>> have a full memmap for the whole section)
>> 2. The whole section memmap is initialized (although eventually with
>> dummy node/zone 0/0 for memory holes until that part is fixed) and might
>> be accessed by pfn walkers.
>>
>> So when hotadding ZONE_DEVICE we are modifying already existing and
>> visible memmaps. Bad.
> 
> Could you elaborate please?

Simplistic example: Assume you have a VM with 64MB on x86-64.

We need exactly one memory section (-> one memory block device). We
allocate the memmap for a full section - an "early section". So we have
a memmap for 128MB, while 64MB are actually in use, the other 64MB is
initialized (like a memory hole). pfn_to_online_page() would return a
valid struct page for the whole section memmap.

The remaining 64MB can later be used for hot-adding ZONE_DEVICE memory,
essentially re-initializing that part of the already-existing memmap.

See pfn_valid():

/*
 * Traditionally early sections always returned pfn_valid() for
 * the entire section-sized span.
 */
return early_section(ms) || pfn_section_valid(ms, pfn);


Depending on the memory layout of the system, a pfn walker might just be
about to stumble over this range getting re-initialized.

>  
>> 2. Deferred init of ZONE_DEVICE ranges
>>
>> memmap_init_zone_device() runs after the ZONE_DEVICE zone was resized
>> and outside the memhp lock. I did not follow if the use of
>> get_dev_pagemap() actually makes sure that memmap_init_zone_device() in
>> pagemap_range() actually completed. I don't think it does.
> 
> So a pfn walker can see an unitialized struct page for a while, right?
> 
> The problem that I have encountered is that some zone device pages are
> not initialized at all. That sounds like a different from those 2 above.
> I am having hard time to track what kind of pages those are and why we
> cannot initialized their zone/node and make them reserved at least.

And you are sure that these are in fact ZONE_DEVICE pages? Not memory
holes e.g., tackled by

commit 4b094b7851bf4bf551ad456195d3f26e1c03bd74
Author: David Hildenbrand <david@redhat.com>
Date:   Mon Feb 3 17:33:55 2020 -0800

    mm/page_alloc.c: initialize memmap of unavailable memory directly


commit e822969cab48b786b64246aad1a3ba2a774f5d23
Author: David Hildenbrand <david@redhat.com>
Date:   Mon Feb 3 17:33:48 2020 -0800

    mm/page_alloc.c: fix uninitialized memmaps on a partially populated
last section


(note there is currently an upstream discussion on improving this
initialization, especially getting better node/zone information, mostly
involving Andrea and Mike - but it only changes "how" these parts are
initialized, not "if" or "when")

---

However, I do remember a discussion regarding "reserved altmap space"
ZONE_DEVICE ranges, and whether to initialize them or leave them
uninitialized. See comment in

commit 77e080e7680e1e615587352f70c87b9e98126d03
Author: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
Date:   Fri Oct 18 20:19:39 2019 -0700

    mm/memunmap: don't access uninitialized memmap in memunmap_pages()


"With an altmap, the memmap falling into the reserved altmap space are
not initialized and, therefore, contain a garbage NID and a garbage zone.".

I think the issue is that the ZONE_DEVICE pages that *host* the memmap
of other pages might be left uninitialized.

Like pfn_to_page(VIRT_TO_PFN(pfn_to_page(zone_device_pfn))), which falls
onto ZONE_DEVICE with an altmap, could be uninitialized. This is very
similar to our Oscar's vmemmap-on-hotadded-memory approach, however,
there we implicitly initialize the memmap of these pages just by the way
the vmemmap is placed at the beginning of the memory block.

If altmap-reserved space is placed partially into an early section that
is marked as online (issue 1. I described), we have the same issue as
1., just a little harder to fix :)

> 
>>> Is anybody working on that?
>>>
>>
>> I believe Dan mentioned somewhere that he wants to see a real instance
>> of this producing a BUG before actually moving forward with a fix. I
>> might be wrong.
> 
> We have seen reports about those uninitialized struct pages on our 5.3
> based kernels. Backporting 53cdc1cb29e8 helped for the particular report
> but I still consider it a workaround rather than a fix. I do not have
> any reports for other pfn walkers but we might be just lucky and I will
> sleep better if I do not have rely on the luck.

Yeah, I think we are now at 3 different but related problems.

-- 
Thanks,

David / dhildenb

