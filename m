Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE9072C424F
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 15:46:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729717AbgKYOnC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 09:43:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:50748 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726508AbgKYOnC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 09:43:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606315380;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1vPA7rC3R/gmKAEpc/ySQI79tc2O6P5R+qcWI6scxZw=;
        b=IetmBCxjr0dbH7ukxHthm0havTkqtSRHV/Tg7SqrPN1Qlk7d7QrEGWV5u9mTW6F/Z2PYmD
        UV/fBwtlRWFYIpx7rk5oau0NFge1aCSjymCS3tUb6xkF/7TEmiAxb3YAfBfe/PpcQoHo65
        UUg+V/Ru7PSreeImIgccoqySEESvFzQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-450-L6NhTTWLMwioEaCmwek55A-1; Wed, 25 Nov 2020 09:42:56 -0500
X-MC-Unique: L6NhTTWLMwioEaCmwek55A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 77C7C8FE84B;
        Wed, 25 Nov 2020 14:42:40 +0000 (UTC)
Received: from [10.36.112.131] (ovpn-112-131.ams2.redhat.com [10.36.112.131])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1B92019D61;
        Wed, 25 Nov 2020 14:42:37 +0000 (UTC)
Subject: Re: [PATCH 1/1] mm: compaction: avoid fast_isolate_around() to set
 pageblock_skip on reserved pages
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mel Gorman <mgorman@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Qian Cai <cai@lca.pw>, Michal Hocko <mhocko@kernel.org>,
        linux-kernel@vger.kernel.org, Baoquan He <bhe@redhat.com>
References: <8C537EB7-85EE-4DCF-943E-3CC0ED0DF56D@lca.pw>
 <20201121194506.13464-1-aarcange@redhat.com>
 <20201121194506.13464-2-aarcange@redhat.com>
 <ea911b11-945f-d2c5-5558-a3fe0bda492a@suse.cz> <X73s8fxDKPRD6wET@redhat.com>
 <1c4c405b-52e0-cf6b-1f82-91a0a1e3dd53@suse.cz>
 <cd9f0b9f-c4f6-b80c-03cd-12697324bfca@redhat.com>
 <20201125141325.GK123287@linux.ibm.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <3a25844f-f6c4-a794-69ef-fdf49e5b7cf8@redhat.com>
Date:   Wed, 25 Nov 2020 15:42:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201125141325.GK123287@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25.11.20 15:13, Mike Rapoport wrote:
> On Wed, Nov 25, 2020 at 02:32:02PM +0100, David Hildenbrand wrote:
>> On 25.11.20 13:08, Vlastimil Babka wrote:
>>> On 11/25/20 6:34 AM, Andrea Arcangeli wrote:
>>>> Hello,
>>>>
>>>> On Mon, Nov 23, 2020 at 02:01:16PM +0100, Vlastimil Babka wrote:
>>>>> On 11/21/20 8:45 PM, Andrea Arcangeli wrote:
>>>>>> A corollary issue was fixed in
>>>>>> 39639000-39814fff : Unknown E820 type
>>>>>>
>>>>>> pfn 0x7a200 -> 0x7a200000 min_pfn hit non-RAM:
>>>>>>
>>>>>> 7a17b000-7a216fff : Unknown E820 type
>>>>>
>>>>> It would be nice to also provide a /proc/zoneinfo and how exactly the 
>>>>> "zone_spans_pfn" was violated. I assume we end up below zone's 
>>>>> start_pfn, but is it true?
>>>>
>>>> Agreed, I was about to grab that info along with all page struct
>>>> around the pfn 0x7a200 and phys address 0x7a216fff.
>>>>
>>>> # grep -A1 E820 /proc/iomem
>>>> 7a17b000-7a216fff : Unknown E820 type
>>>> 7a217000-7bffffff : System RAM
>>>>
>>>> DMA      zone_start_pfn 1            zone_end_pfn() 4096         contiguous 1
>>>> DMA32    zone_start_pfn 4096         zone_end_pfn() 1048576      contiguous 0
>>>> Normal   zone_start_pfn 1048576      zone_end_pfn() 4715392      contiguous 1
>>>> Movable  zone_start_pfn 0            zone_end_pfn() 0            contiguous 0
>>>
>>> So the above means that around the "Unknown E820 type" we have:
>>>
>>> pfn 499712 - start of pageblock in ZONE_DMA32
>>> pfn 500091 - start of the "Unknown E820 type" range
>>> pfn 500224 - start of another pageblock
>>> pfn 500246 - end of "Unknown E820 type"
>>>
>>> So this is indeed not a zone boundary issue, but basically a hole not 
>>> aligned to pageblock boundary and really unexpected.
>>> We have CONFIG_HOLES_IN_ZONE (that x86 doesn't set) for architectures 
>>> that do this, and even that config only affects pfn_valid_within(). But 
>>> here pfn_valid() is true, but the zone/node linkage is unexpected.
>>>
>>>> However the real bug seems that reserved pages have a zero zone_id in
>>>> the page->flags when it should have the real zone id/nid. The patch I
>>>> sent earlier to validate highest would only be needed to deal with
>>>> pfn_valid.
>>>>
>>>> Something must have changed more recently than v5.1 that caused the
>>>> zoneid of reserved pages to be wrong, a possible candidate for the
>>>> real would be this change below:
>>>>
>>>> +               __init_single_page(pfn_to_page(pfn), pfn, 0, 0);
>>>>
>>>> Even if it may not be it, at the light of how the reserved page
>>>> zoneid/nid initialized went wrong, the above line like it's too flakey
>>>> to stay.
>>>>
>>>> It'd be preferable if the pfn_valid fails and the
>>>> pfn_to_section_nr(pfn) returns an invalid section for the intermediate
>>>> step. Even better memset 0xff over the whole page struct until the
>>>> second stage comes around.
>>>>
>>>> Whenever pfn_valid is true, it's better that the zoneid/nid is correct
>>>> all times, otherwise if the second stage fails we end up in a bug with
>>>> weird side effects.
>>>
>>> Yeah I guess it would be simpler if zoneid/nid was correct for 
>>> pfn_valid() pfns within a zone's range, even if they are reserved due 
>>> not not being really usable memory.
>>>
>>> I don't think we want to introduce CONFIG_HOLES_IN_ZONE to x86. If the 
>>> chosen solution is to make this to a real hole, the hole should be 
>>> extended to MAX_ORDER_NR_PAGES aligned boundaries.
>>
>> As we don't punch out pages of the memmap on x86-64, pfn_valid() keeps
>> working as expected. There is a memmap that can be accessed and that was
>> initialized.
> 
> I suspect that memmap for the reserved pages is not properly initialized
> after recent changes in free_area_init(). They are cleared at
> init_unavailable_mem() to have zone=0 and node=0, but they seem to be
> never re-initialized with proper zone and node links which was not the
> case before commit 73a6e474cb37 ("mm: memmap_init: iterate over memblock
> regions rather that check each PFN").
> 
> Back then, memmap_init_zone() looped from zone_start_pfn till
> zone_end_pfn and struct page for reserved pages with pfns inside the
> zone would be initialized.
> 
> Now the loop is for interesection of [zone_start_pfn, zone_end_pfn] with
> memblock.memory and for x86 reserved ranges are not in memblock.memory,
> so the memmap for them remains semi-initialized.

As far as I understood Mel, rounding these ranges up/down to cover full
MAX_ORDER blocks/pageblocks might work.

-- 
Thanks,

David / dhildenb

