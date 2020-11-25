Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 061192C4846
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 20:28:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728340AbgKYT1c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 14:27:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:25978 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727848AbgKYT1b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 14:27:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606332449;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mgegr/huHXkvLGJYhWAuXrrVW2MXY/ic/lw8L7IGsrQ=;
        b=gXkHnYT7NrJhXHvOI5saxJrMtFQEI1d/OyB/QJPb2lsWvLT/Q6b7jjOheOk+hUs3zDRyl4
        cknAjZzEbioinRg0oi59wq05m+pIlSSeWZ5nBh3ny0coxeelquut9C2gnHvfBYXZXy0M1j
        Xpbu66wLs1kHNvMoRpDJI9koMCFU968=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-556-ZI6srYw3NJKHP0W85XdzRA-1; Wed, 25 Nov 2020 14:27:26 -0500
X-MC-Unique: ZI6srYw3NJKHP0W85XdzRA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4B0AF1E7D8;
        Wed, 25 Nov 2020 19:27:25 +0000 (UTC)
Received: from [10.36.112.131] (ovpn-112-131.ams2.redhat.com [10.36.112.131])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3760960854;
        Wed, 25 Nov 2020 19:27:23 +0000 (UTC)
Subject: Re: [PATCH 1/1] mm: compaction: avoid fast_isolate_around() to set
 pageblock_skip on reserved pages
To:     Andrea Arcangeli <aarcange@redhat.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>, Mel Gorman <mgorman@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Qian Cai <cai@lca.pw>, Michal Hocko <mhocko@kernel.org>,
        linux-kernel@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>,
        Baoquan He <bhe@redhat.com>
References: <X73s8fxDKPRD6wET@redhat.com>
 <35F8AADA-6CAA-4BD6-A4CF-6F29B3F402A4@redhat.com>
 <X76iatgBErQH5El4@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <a4cc62ba-8066-3e9c-cead-98cd74d313dd@redhat.com>
Date:   Wed, 25 Nov 2020 20:27:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <X76iatgBErQH5El4@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25.11.20 19:28, Andrea Arcangeli wrote:
> On Wed, Nov 25, 2020 at 07:45:30AM +0100, David Hildenbrand wrote:
>> Before that change, the memmap of memory holes were only zeroed
>> out. So the zones/nid was 0, however, pages were not reserved and
>> had a refcount of zero - resulting in other issues.
> 
> So maybe that "0,0" zoneid/nid was not actually the thing that
> introduced the regression? Note: I didn't bisect anything yet, it was
> just a guess.

I guess 0/0 is the issue, but that existed before when we had a simple
memmset(0). The root issue should be what Mike said:

73a6e474cb37 ("mm: memmap_init: iterate over memblock regions rather
that check each PFN")


>> Most pfn walkers shouldn‘t mess with reserved pages and simply skip
>> them. That would be the right fix here.
> 
> What would then be the advantage of keeping wrong page->flags in
> reserved pages compared to actually set it correct?

"correct" is problematic. If you have an actual memory hole, there is
not always a right answer - unless I am missing something important.


Assume you have a layout like this

[  zone X ] [ hole ] [ zone Y ]

If either X and or Y starts within a memory section, you have a valid
memmap for X - but what would be the right node/zone?


Assume you have a layout like this

[ zone X ]

whereby X ends inside a memory section. The you hotplug memory. Assume
it goes to X

[ zone X ][ hole in X ][ zone X]

or it goes to y

[ zone X ][ hole ][ zone Y ]

This can easily be reproduced by starting a VM in qemu with a memory
size not aligned to 128 MB (e.g., -M 4000) and hotplugging memory.

> 
> How do you plan to enforce that every VM bit will call PageReserved
> (as it should be introduced in pageblock_pfn_to_page in that case) if
> it's not possible to disambiguate a real DMA zone and nid 0 from the
> uninitialized value? How can we patch page_nodenum to enforce it won't
> read an uninitialized value because a PageReserved check was missing
> in the caller?

We can't. The general rule is (as I was once told by Michal IIRC) that
there is no trusting on memmap content when the reserved bit is set -
unless you know "why it was set" - e.g., to distinguish early boot
allocations from ordinary allocations.

See below for pointer to documentation.

> 
> I don't see this easily enforceable by code review, it'd be pretty
> flakey to leave a 0,0 wrong value in there with no way to verify if a
> PageResered check in the caller was missing.

I'm not rooting for "keep this at 0/0" - I'm saying that I think there
are corner cases where it might not be that easy.

> 
>>> It'd be preferable if the pfn_valid fails and the
>>> pfn_to_section_nr(pfn) returns an invalid section for the intermediate
>>> step. Even better memset 0xff over the whole page struct until the
>>> second stage comes around.
>>
>> I recently discussed with Baoquan to
>> 1. Using a new pagetype to mark memory holes
>> 2. Using special nid/zid to mark memory holes
>>
>> Setting the memmap to 0xff would be even more dangerous - pfn_zone() might simply BUG_ON.
> 
> What would need to call pfn_zone in between first and second stage?
> 
> If something calls pfn_zone in between first and second stage isn't it
> a feature if it crashes the kernel at boot?
> 
> Note: I suggested 0xff kernel crashing "until the second stage comes
> around" during meminit at boot, not permanently.

Yes, then it makes sense - if we're able to come up with a way to
initialize any memmap we might have - including actual memory holes that
have a memmap.

> 
> 		/*
> 		 * Use a fake node/zone (0) for now. Some of these pages
> 		 * (in memblock.reserved but not in memblock.memory) will
> 		 * get re-initialized via reserve_bootmem_region() later.
> 		 */
> 
> Specifically I relied on the comment "get re-initialized via
> reserve_bootmem_region() later".

Yes, but there is a "Some of these" :)

Boot a VM with "-M 4000" and observe the memmap in the last section -
they won't get initialized a second time.

> 
> I assumed the second stage overwrites the 0,0 to the real zoneid/nid
> value, which is clearly not happening, hence it'd be preferable to get
> a crash at boot reliably.
> 
> Now I have CONFIG_DEFERRED_STRUCT_PAGE_INIT=n so the second stage
> calling init_reserved_page(start_pfn) won't do much with
> CONFIG_DEFERRED_STRUCT_PAGE_INIT=n but I already tried to enable
> CONFIG_DEFERRED_STRUCT_PAGE_INIT=y yesterday and it didn't help, the
> page->flags were still wrong for reserved pages in the "Unknown E820
> type" region.
> 
>>> Whenever pfn_valid is true, it's better that the zoneid/nid is correct
>>> all times, otherwise if the second stage fails we end up in a bug with
>>> weird side effects.
>>
>> Memory holes with a valid memmap might not have a zone/nid. For now, skipping reserved pages should be good enough, no?
> 
> zoneid is always a pure abstract concept, not just the RAM-holes but
> the RAM itself doesn't have a zoneid at all.
> 
> Nid is hardware defined for RAM, but for reserved RAM holes it becomes
> a pure software construct as the zoneid.
> 
> So while it's right that they have no zone/nid in the hardware, they
> still have a very well defined zoneid/nid in the software implementation.
> 
> The page struct belongs to one and only one mem_map array, that has a
> specific nodeid and nid. So it can be always initialized right even
> for non-RAM.

AFAIK, the mem_map array might have multiple NIDs - and it's set when
initializing the zones.

> 
> Only if the pfn is !pfn_valid, then it has no page struct and then
> there's no zone/nid association, but in that case there's no reason to
> even worry about it since nobody can possibly get a wrong value out of
> the page struct because there's no page struct in the case.
> 
> Last but not the least, RAM pages can be marked reserved and assigned
> to hardware and so it'd be really messy if real reserved RAM pages
> given to hw, behaved different than non-RAM that accidentally got a
> struct page because of section alignment issues.

Well, "reserved" is not a good indication "what" something actually is.

I documented that a while ago in include/linux/page-flags.h

"PG_reserved is set for special pages. The "struct page" of such a page
 should in general not be touched (e.g. set dirty) except by its owner.
 Pages marked as PG_reserved include:."

I suggest looking at that.

AFAIR, we have been setting *most* memmap in memory holes/non-ram
reserved for a long time - long before I added the __init_single_page -
see init_reserved_page() for example.

-- 
Thanks,

David / dhildenb

