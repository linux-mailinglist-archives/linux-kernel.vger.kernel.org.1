Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D651F2C08CE
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 14:17:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387948AbgKWNBV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 08:01:21 -0500
Received: from mx2.suse.de ([195.135.220.15]:49310 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729696AbgKWNBS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 08:01:18 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 8B828ABCE;
        Mon, 23 Nov 2020 13:01:16 +0000 (UTC)
To:     Andrea Arcangeli <aarcange@redhat.com>,
        Mel Gorman <mgorman@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Qian Cai <cai@lca.pw>
Cc:     Michal Hocko <mhocko@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        linux-kernel@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>,
        Baoquan He <bhe@redhat.com>
References: <8C537EB7-85EE-4DCF-943E-3CC0ED0DF56D@lca.pw>
 <20201121194506.13464-1-aarcange@redhat.com>
 <20201121194506.13464-2-aarcange@redhat.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH 1/1] mm: compaction: avoid fast_isolate_around() to set
 pageblock_skip on reserved pages
Message-ID: <ea911b11-945f-d2c5-5558-a3fe0bda492a@suse.cz>
Date:   Mon, 23 Nov 2020 14:01:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <20201121194506.13464-2-aarcange@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/21/20 8:45 PM, Andrea Arcangeli wrote:
> A corollary issue was fixed in
> e577c8b64d58fe307ea4d5149d31615df2d90861. A second issue remained in
> v5.7:
> 
> 	https://lkml.kernel.org/r/8C537EB7-85EE-4DCF-943E-3CC0ED0DF56D@lca.pw
> 
> ==
> page:ffffea0000aa0000 refcount:1 mapcount:0 mapping:000000002243743b index:0x0
> flags: 0x1fffe000001000(reserved)
> ==
> 
> 73a6e474cb376921a311786652782155eac2fdf0 was applied to supposedly the
> second issue, but I still reproduced it twice with v5.9 on two
> different systems:
> 
> ==
> page:0000000062b3e92f refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x39800
> flags: 0x1000(reserved)
> ==
> page:000000002a7114f8 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x7a200
> flags: 0x1fff000000001000(reserved)
> ==
> 
> I actually never reproduced it until v5.9, but it's still the same bug
> as it was reported first for v5.7.
> 
> See the page is "reserved" in all 3 cases. In the last two crashes
> with the pfn:
> 
> pfn 0x39800 -> 0x39800000 min_pfn hit non-RAM:
> 
> 39639000-39814fff : Unknown E820 type
> 
> pfn 0x7a200 -> 0x7a200000 min_pfn hit non-RAM:
> 
> 7a17b000-7a216fff : Unknown E820 type

It would be nice to also provide a /proc/zoneinfo and how exactly the 
"zone_spans_pfn" was violated. I assume we end up below zone's 
start_pfn, but is it true?

> This actually seems a false positive bugcheck, the page structures are
> valid and the zones are correct, just it's non-RAM but setting
> pageblockskip should do no harm. However it's possible to solve the
> crash without lifting the bugcheck, by enforcing the invariant that
> the free_pfn cursor doesn't point to reserved pages (which would be
> otherwise implicitly achieved through the PageBuddy check, except in
> the new fast_isolate_around() path).
> 
> Fixes: 5a811889de10 ("mm, compaction: use free lists to quickly locate a migration target")
> Signed-off-by: Andrea Arcangeli <aarcange@redhat.com>
> ---
>   mm/compaction.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/compaction.c b/mm/compaction.c
> index 13cb7a961b31..d17e69549d34 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -1433,7 +1433,10 @@ fast_isolate_freepages(struct compact_control *cc)
>   					page = pageblock_pfn_to_page(min_pfn,
>   						pageblock_end_pfn(min_pfn),
>   						cc->zone);
> -					cc->free_pfn = min_pfn;
> +					if (likely(!PageReserved(page)))

PageReserved check seems rather awkward solution to me. Wouldn't it be 
more obvious if we made sure we don't end up below zone's start_pfn (if 
my assumption is correct) in the first place?

When I check the code:

unsigned long distance;
distance = (cc->free_pfn - cc->migrate_pfn);
low_pfn = pageblock_start_pfn(cc->free_pfn - (distance >> 2));
min_pfn = pageblock_start_pfn(cc->free_pfn - (distance >> 1));

I think what can happen is that cc->free_pfn <= cc->migrate_pfn after 
the very last isolate_migratepages(). Then compact_finished() detects 
that in compact_zone(), but only after migrate_pages() and thus 
fast_isolate_freepages() is called.

That would mean distance can be negative, or rather a large unsigned 
number and low_pfn and min_pfn end up away from the zone?

Or maybe the above doesn't happen, but cc->free_pfn gets so close to 
start of the zone, that the calculations above make min_pfn go below 
start_pfn?

In any case I would rather make sure we stay within the expected zone 
boundaries, than play tricks with PageReserved. Mel?

> +						cc->free_pfn = min_pfn;
> +					else
> +						page = NULL;
>   				}
>   			}
>   		}
> 

