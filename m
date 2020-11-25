Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42F172C4129
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 14:32:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728404AbgKYNcX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 08:32:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:34428 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725616AbgKYNcW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 08:32:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606311140;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rwvgyxDfwQi/NtrjMhcIih8dqcTP9qRQY/AfpUrZ+Y4=;
        b=J3ql5fhfUc6nwZ8MVvFG4z2fskqHZbEcCsbLUfnIleUx7oTinzyOnTks6LUftgk9SDd01k
        ZI9V4uK96rufXEakleRtz3gYwJZseH5DBTbY7FFb3CfA1XKQq8hn0ferURik5TGrbeEL4j
        NtAfLFkZQNc0cpO6F9jWkIyHozBl/oU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-328-a1S4rpDjO2WLmZqTpdYG5w-1; Wed, 25 Nov 2020 08:32:17 -0500
X-MC-Unique: a1S4rpDjO2WLmZqTpdYG5w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 994D01012E77;
        Wed, 25 Nov 2020 13:32:05 +0000 (UTC)
Received: from [10.36.112.131] (ovpn-112-131.ams2.redhat.com [10.36.112.131])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4BD755D9CA;
        Wed, 25 Nov 2020 13:32:03 +0000 (UTC)
Subject: Re: [PATCH 1/1] mm: compaction: avoid fast_isolate_around() to set
 pageblock_skip on reserved pages
To:     Vlastimil Babka <vbabka@suse.cz>,
        Andrea Arcangeli <aarcange@redhat.com>
Cc:     Mel Gorman <mgorman@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Qian Cai <cai@lca.pw>, Michal Hocko <mhocko@kernel.org>,
        linux-kernel@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>,
        Baoquan He <bhe@redhat.com>
References: <8C537EB7-85EE-4DCF-943E-3CC0ED0DF56D@lca.pw>
 <20201121194506.13464-1-aarcange@redhat.com>
 <20201121194506.13464-2-aarcange@redhat.com>
 <ea911b11-945f-d2c5-5558-a3fe0bda492a@suse.cz> <X73s8fxDKPRD6wET@redhat.com>
 <1c4c405b-52e0-cf6b-1f82-91a0a1e3dd53@suse.cz>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <cd9f0b9f-c4f6-b80c-03cd-12697324bfca@redhat.com>
Date:   Wed, 25 Nov 2020 14:32:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <1c4c405b-52e0-cf6b-1f82-91a0a1e3dd53@suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25.11.20 13:08, Vlastimil Babka wrote:
> On 11/25/20 6:34 AM, Andrea Arcangeli wrote:
>> Hello,
>>
>> On Mon, Nov 23, 2020 at 02:01:16PM +0100, Vlastimil Babka wrote:
>>> On 11/21/20 8:45 PM, Andrea Arcangeli wrote:
>>>> A corollary issue was fixed in
>>>> 39639000-39814fff : Unknown E820 type
>>>>
>>>> pfn 0x7a200 -> 0x7a200000 min_pfn hit non-RAM:
>>>>
>>>> 7a17b000-7a216fff : Unknown E820 type
>>>
>>> It would be nice to also provide a /proc/zoneinfo and how exactly the 
>>> "zone_spans_pfn" was violated. I assume we end up below zone's 
>>> start_pfn, but is it true?
>>
>> Agreed, I was about to grab that info along with all page struct
>> around the pfn 0x7a200 and phys address 0x7a216fff.
>>
>> # grep -A1 E820 /proc/iomem
>> 7a17b000-7a216fff : Unknown E820 type
>> 7a217000-7bffffff : System RAM
>>
>> DMA      zone_start_pfn 1            zone_end_pfn() 4096         contiguous 1
>> DMA32    zone_start_pfn 4096         zone_end_pfn() 1048576      contiguous 0
>> Normal   zone_start_pfn 1048576      zone_end_pfn() 4715392      contiguous 1
>> Movable  zone_start_pfn 0            zone_end_pfn() 0            contiguous 0
> 
> So the above means that around the "Unknown E820 type" we have:
> 
> pfn 499712 - start of pageblock in ZONE_DMA32
> pfn 500091 - start of the "Unknown E820 type" range
> pfn 500224 - start of another pageblock
> pfn 500246 - end of "Unknown E820 type"
> 
> So this is indeed not a zone boundary issue, but basically a hole not 
> aligned to pageblock boundary and really unexpected.
> We have CONFIG_HOLES_IN_ZONE (that x86 doesn't set) for architectures 
> that do this, and even that config only affects pfn_valid_within(). But 
> here pfn_valid() is true, but the zone/node linkage is unexpected.
> 
>> However the real bug seems that reserved pages have a zero zone_id in
>> the page->flags when it should have the real zone id/nid. The patch I
>> sent earlier to validate highest would only be needed to deal with
>> pfn_valid.
>>
>> Something must have changed more recently than v5.1 that caused the
>> zoneid of reserved pages to be wrong, a possible candidate for the
>> real would be this change below:
>>
>> +               __init_single_page(pfn_to_page(pfn), pfn, 0, 0);
>>
>> Even if it may not be it, at the light of how the reserved page
>> zoneid/nid initialized went wrong, the above line like it's too flakey
>> to stay.
>>
>> It'd be preferable if the pfn_valid fails and the
>> pfn_to_section_nr(pfn) returns an invalid section for the intermediate
>> step. Even better memset 0xff over the whole page struct until the
>> second stage comes around.
>>
>> Whenever pfn_valid is true, it's better that the zoneid/nid is correct
>> all times, otherwise if the second stage fails we end up in a bug with
>> weird side effects.
> 
> Yeah I guess it would be simpler if zoneid/nid was correct for 
> pfn_valid() pfns within a zone's range, even if they are reserved due 
> not not being really usable memory.
> 
> I don't think we want to introduce CONFIG_HOLES_IN_ZONE to x86. If the 
> chosen solution is to make this to a real hole, the hole should be 
> extended to MAX_ORDER_NR_PAGES aligned boundaries.

As we don't punch out pages of the memmap on x86-64, pfn_valid() keeps
working as expected. There is a memmap that can be accessed and that was
initialized. It's really just a matter of how to handle memory holes in
this scenario.

a) Try initializing them to the covering node/zone (I gave one example
   that might be tricky with hotplug)
b) Mark such pages (either special node/zone or pagetype) and make pfn
   walkers ignore these holes. For now, this can only be done via the
   reserved flag.

-- 
Thanks,

David / dhildenb

