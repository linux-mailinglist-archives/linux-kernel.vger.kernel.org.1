Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E83D12C3F96
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 13:10:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729059AbgKYMI5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 07:08:57 -0500
Received: from mx2.suse.de ([195.135.220.15]:46482 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725836AbgKYMI5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 07:08:57 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 6BD3BAF0B;
        Wed, 25 Nov 2020 12:08:55 +0000 (UTC)
To:     Andrea Arcangeli <aarcange@redhat.com>,
        David Hildenbrand <david@redhat.com>
Cc:     Mel Gorman <mgorman@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Qian Cai <cai@lca.pw>, Michal Hocko <mhocko@kernel.org>,
        linux-kernel@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>,
        Baoquan He <bhe@redhat.com>
References: <8C537EB7-85EE-4DCF-943E-3CC0ED0DF56D@lca.pw>
 <20201121194506.13464-1-aarcange@redhat.com>
 <20201121194506.13464-2-aarcange@redhat.com>
 <ea911b11-945f-d2c5-5558-a3fe0bda492a@suse.cz> <X73s8fxDKPRD6wET@redhat.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH 1/1] mm: compaction: avoid fast_isolate_around() to set
 pageblock_skip on reserved pages
Message-ID: <1c4c405b-52e0-cf6b-1f82-91a0a1e3dd53@suse.cz>
Date:   Wed, 25 Nov 2020 13:08:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <X73s8fxDKPRD6wET@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/25/20 6:34 AM, Andrea Arcangeli wrote:
> Hello,
> 
> On Mon, Nov 23, 2020 at 02:01:16PM +0100, Vlastimil Babka wrote:
>> On 11/21/20 8:45 PM, Andrea Arcangeli wrote:
>> > A corollary issue was fixed in
>> > 39639000-39814fff : Unknown E820 type
>> > 
>> > pfn 0x7a200 -> 0x7a200000 min_pfn hit non-RAM:
>> > 
>> > 7a17b000-7a216fff : Unknown E820 type
>> 
>> It would be nice to also provide a /proc/zoneinfo and how exactly the 
>> "zone_spans_pfn" was violated. I assume we end up below zone's 
>> start_pfn, but is it true?
> 
> Agreed, I was about to grab that info along with all page struct
> around the pfn 0x7a200 and phys address 0x7a216fff.
> 
> # grep -A1 E820 /proc/iomem
> 7a17b000-7a216fff : Unknown E820 type
> 7a217000-7bffffff : System RAM
> 
> DMA      zone_start_pfn 1            zone_end_pfn() 4096         contiguous 1
> DMA32    zone_start_pfn 4096         zone_end_pfn() 1048576      contiguous 0
> Normal   zone_start_pfn 1048576      zone_end_pfn() 4715392      contiguous 1
> Movable  zone_start_pfn 0            zone_end_pfn() 0            contiguous 0

So the above means that around the "Unknown E820 type" we have:

pfn 499712 - start of pageblock in ZONE_DMA32
pfn 500091 - start of the "Unknown E820 type" range
pfn 500224 - start of another pageblock
pfn 500246 - end of "Unknown E820 type"

So this is indeed not a zone boundary issue, but basically a hole not 
aligned to pageblock boundary and really unexpected.
We have CONFIG_HOLES_IN_ZONE (that x86 doesn't set) for architectures 
that do this, and even that config only affects pfn_valid_within(). But 
here pfn_valid() is true, but the zone/node linkage is unexpected.

> However the real bug seems that reserved pages have a zero zone_id in
> the page->flags when it should have the real zone id/nid. The patch I
> sent earlier to validate highest would only be needed to deal with
> pfn_valid.
> 
> Something must have changed more recently than v5.1 that caused the
> zoneid of reserved pages to be wrong, a possible candidate for the
> real would be this change below:
> 
> +               __init_single_page(pfn_to_page(pfn), pfn, 0, 0);
> 
> Even if it may not be it, at the light of how the reserved page
> zoneid/nid initialized went wrong, the above line like it's too flakey
> to stay.
> 
> It'd be preferable if the pfn_valid fails and the
> pfn_to_section_nr(pfn) returns an invalid section for the intermediate
> step. Even better memset 0xff over the whole page struct until the
> second stage comes around.
> 
> Whenever pfn_valid is true, it's better that the zoneid/nid is correct
> all times, otherwise if the second stage fails we end up in a bug with
> weird side effects.

Yeah I guess it would be simpler if zoneid/nid was correct for 
pfn_valid() pfns within a zone's range, even if they are reserved due 
not not being really usable memory.

I don't think we want to introduce CONFIG_HOLES_IN_ZONE to x86. If the 
chosen solution is to make this to a real hole, the hole should be 
extended to MAX_ORDER_NR_PAGES aligned boundaries.

In any case, compaction code can't fix this with better range checks.

> Maybe it's not the above that left a zero zoneid though, I haven't
> tried to bisect it yet to look how the page->flags looked like on a
> older kernel that didn't seem to reproduce this crash, I'm just
> guessing.
> 
> Thanks,
> Andrea
> 

