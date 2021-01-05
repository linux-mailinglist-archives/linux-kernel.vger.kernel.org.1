Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 901D22EA747
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 10:28:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728010AbhAEJ1D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 04:27:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:26393 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725822AbhAEJ1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 04:27:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1609838735;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=W046ADtp2FIsW+KHHPQzy7iJDu5dTv1JAqb4rsCd02c=;
        b=giEJQqTTgxAREJ0buuABfQw2D2Nlz6TQnNBd9R7eZEkNmiOxwmC38F+a11kZ0KjnQx7zVM
        L2kmRQahkyx/YG0p+Dxh8OV8uRyZ9cRUwYPpH3dBkC/HzM2FRiBY80XlB8H/1FuSppbYXf
        JVc/N7CdmqjGMhP9hh7Qf3rJnHog9Ag=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-310-HvyRhj3WMpmb2gdHSdQNQQ-1; Tue, 05 Jan 2021 04:25:31 -0500
X-MC-Unique: HvyRhj3WMpmb2gdHSdQNQQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 80BC4809DC9;
        Tue,  5 Jan 2021 09:25:30 +0000 (UTC)
Received: from [10.36.114.117] (ovpn-114-117.ams2.redhat.com [10.36.114.117])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 302DE779CD;
        Tue,  5 Jan 2021 09:25:29 +0000 (UTC)
Subject: Re: uninitialized pmem struct pages
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Michal Hocko <mhocko@suse.com>, Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20210104100323.GC13207@dhcp22.suse.cz>
 <033e1cd6-9762-5de6-3e88-47d3038fda7f@redhat.com>
 <CAPcyv4h6mdKrwpqXfO0e_=sKjB-pY5KbP9ii+tQyFsK5bPkb=A@mail.gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <b5109800-a860-0f82-3e45-c0768cb1b038@redhat.com>
Date:   Tue, 5 Jan 2021 10:25:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <CAPcyv4h6mdKrwpqXfO0e_=sKjB-pY5KbP9ii+tQyFsK5bPkb=A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05.01.21 06:17, Dan Williams wrote:
> On Mon, Jan 4, 2021 at 2:45 AM David Hildenbrand <david@redhat.com> wrote:
>>
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
> 
> The motivation for that backport was for pre-subsection kernels. When
> onlining pmem that collides with the same section as System-RAM we may
> have a situation like:
> 
> |--               SECTION                   -- |
> |-- System RAM      --        PMEM          -- |
> |-- pfn_valid()     --     PMEM metadata    -- |
> 
> So problem 0. is just System RAM + PMEM collisions independent of
> sub-section support.

IIRC, you were not able to hot-add the PMEM device before sub-section
support (which was bad and fixed by sub-section hot-add). How was this a
problem before?

> 
>>
>> If we have ZONE_DEVICE hot-added memory that overlaps in a section with
>> boot memory, this memory section will contain parts ZONE_DEVICE memory
>> and parts !ZONE_DEVICE memory. This can happen in sub-section
>> granularity (2MB IIRC). pfn_to_online_page() will succeed on ZONE_DEVICE
>> memory parts as the whole section is marked as online. Bad.
>>
>> One instance where this is still an issue is
>> mm/memory-failure.c:memory_failure() and
>> mm/memory-failure.c:soft_offline_page(). I thought for a while about
>> "fixing" these, but to me it felt like fixing pfn_to_online_page() is
>> actually the right approach.
> 
> This is complicated by MEMORY_DEVICE_PRIVATE that I believe wants to
> say "yes" to pfn_to_online_page().
> 
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
> Where does the rewrite of a dummy page entry matter in practice? It
> would certainly be exceedingly Bad if in-use 'struct page' instances
> we're rewritten. You're only alleging the former, correct?

Yes, just another piece of the puzzle.

>> 2. Deferred init of ZONE_DEVICE ranges
>>
>> memmap_init_zone_device() runs after the ZONE_DEVICE zone was resized
>> and outside the memhp lock. I did not follow if the use of
>> get_dev_pagemap() actually makes sure that memmap_init_zone_device() in
>> pagemap_range() actually completed. I don't think it does.
>>
>>>
>>> Is anybody working on that?
>>>
>>
>> I believe Dan mentioned somewhere that he wants to see a real instance
>> of this producing a BUG before actually moving forward with a fix. I
>> might be wrong.
> 
> I think I'm missing an argument for the user-visible effects of the
> "Bad." statements above. I think soft_offline_page() is a candidate
> for a local fix because mm/memory-failure.c already has a significant
> amount of page-type specific knowledge. So teaching it "yes" for
> MEMORY_DEVICE_PRIVATE-ZONE_DEVICE and "no" for other ZONE_DEVICE seems
> ok to me.

I am not completely against working around the issue we have in the code
but nobody stumbled over them. IMHO it's just error prone code and
handling we have here that will bite us in the long term. E.g., any pfn
walker/code that sticks to the current documentation of
pfn_to_online_page().

I am not sure it's the right thing to do for
MEMORY_DEVICE_PRIVATE-ZONE_DEVICE, that requires more discussion.

>> We might tackle 1. by:

[...]
>> d) fixed by not allowing ZONE_DEVICE and !ZONE_DEVICE within a single
>> section. In the worst case, don't add partially present sections that
>> have big holes in the beginning/end. Like, if there is a 128MB section
>> with 126MB of memory followed by a 2MB hole, don't add that memory to
>> Linux with CONFIG_ZONE_DEVICE. Might turn some memory unusable, but
>> well, it would be the price to pay for simplicity. Being able to hotadd
>> PMEM is more important than using each and every last MB of memory.
> 
> The collisions that are out there in the wild are 64MB System RAM
> followed by 64MB of PMEM. If you're suggesting reducing System RAM
> that collides with PMEM that's a consideration. It can't go the other
> way because there are deployed configurations that have persistent
> data there. Reducing System RAM runs into the problem of how early
> does the kernel know that it's bordering ZONE_DEVICE. It's not just
> PMEM, it's also EFI_MEMORY_SP (Linux Soft Reserved) memory.

Yeah, obviously the first one. Being able to add+use PMEM is more
important than using each and every last MB of main memory.

I wonder if we can just stop adding any system RAM like

[     Memory Section    ]
[ RAM ] [      Hole     ]

When there could be the possibility that the hole might actually be
PMEM. (e.g., with CONFIG_ZONE_DEVICE and it being the last section in a
sequence of sections, not just a tiny hole)

-- 
Thanks,

David / dhildenb

