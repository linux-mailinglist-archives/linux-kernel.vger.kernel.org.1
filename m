Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A76972C27FD
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 14:33:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388387AbgKXNcL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 08:32:11 -0500
Received: from mx2.suse.de ([195.135.220.15]:48744 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388349AbgKXNcJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 08:32:09 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id DD8CFAFC9;
        Tue, 24 Nov 2020 13:32:07 +0000 (UTC)
Date:   Tue, 24 Nov 2020 13:32:05 +0000
From:   Mel Gorman <mgorman@suse.de>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Qian Cai <cai@lca.pw>, Michal Hocko <mhocko@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        linux-kernel@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>,
        Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH 1/1] mm: compaction: avoid fast_isolate_around() to set
 pageblock_skip on reserved pages
Message-ID: <20201124133205.GK3306@suse.de>
References: <8C537EB7-85EE-4DCF-943E-3CC0ED0DF56D@lca.pw>
 <20201121194506.13464-1-aarcange@redhat.com>
 <20201121194506.13464-2-aarcange@redhat.com>
 <ea911b11-945f-d2c5-5558-a3fe0bda492a@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <ea911b11-945f-d2c5-5558-a3fe0bda492a@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 23, 2020 at 02:01:16PM +0100, Vlastimil Babka wrote:
> > I actually never reproduced it until v5.9, but it's still the same bug
> > as it was reported first for v5.7.
> > 
> > See the page is "reserved" in all 3 cases. In the last two crashes
> > with the pfn:
> > 
> > pfn 0x39800 -> 0x39800000 min_pfn hit non-RAM:
> > 
> > 39639000-39814fff : Unknown E820 type
> > 
> > pfn 0x7a200 -> 0x7a200000 min_pfn hit non-RAM:
> > 
> > 7a17b000-7a216fff : Unknown E820 type
> 
> It would be nice to also provide a /proc/zoneinfo and how exactly the
> "zone_spans_pfn" was violated. I assume we end up below zone's start_pfn,
> but is it true?
> 

It must be if zone_spans_pfn is getting triggered.

> > This actually seems a false positive bugcheck, the page structures are
> > valid and the zones are correct, just it's non-RAM but setting
> > pageblockskip should do no harm. However it's possible to solve the
> > crash without lifting the bugcheck, by enforcing the invariant that
> > the free_pfn cursor doesn't point to reserved pages (which would be
> > otherwise implicitly achieved through the PageBuddy check, except in
> > the new fast_isolate_around() path).
> > 
> > Fixes: 5a811889de10 ("mm, compaction: use free lists to quickly locate a migration target")
> > Signed-off-by: Andrea Arcangeli <aarcange@redhat.com>
> > ---
> >   mm/compaction.c | 5 ++++-
> >   1 file changed, 4 insertions(+), 1 deletion(-)
> > 
> > diff --git a/mm/compaction.c b/mm/compaction.c
> > index 13cb7a961b31..d17e69549d34 100644
> > --- a/mm/compaction.c
> > +++ b/mm/compaction.c
> > @@ -1433,7 +1433,10 @@ fast_isolate_freepages(struct compact_control *cc)
> >   					page = pageblock_pfn_to_page(min_pfn,
> >   						pageblock_end_pfn(min_pfn),
> >   						cc->zone);
> > -					cc->free_pfn = min_pfn;
> > +					if (likely(!PageReserved(page)))
> 
> PageReserved check seems rather awkward solution to me. Wouldn't it be more
> obvious if we made sure we don't end up below zone's start_pfn (if my
> assumption is correct) in the first place?
> 
> When I check the code:
> 
> unsigned long distance;
> distance = (cc->free_pfn - cc->migrate_pfn);
> low_pfn = pageblock_start_pfn(cc->free_pfn - (distance >> 2));
> min_pfn = pageblock_start_pfn(cc->free_pfn - (distance >> 1));
> 
> I think what can happen is that cc->free_pfn <= cc->migrate_pfn after the
> very last isolate_migratepages().

I would hope that is not the case because they are not meant to overlap.
However, if the beginning of the pageblock was not the start of a zone
then the pages would be valid but the pfn would still be outside the
zone boundary. If it was reserved, the struct page is valid but not
suitable for set_pfnblock_flags_mask. However, it is a concern in
general because the potential is there that pages are isolated from the
wrong zone.

> Then compact_finished() detects that in
> compact_zone(), but only after migrate_pages() and thus
> fast_isolate_freepages() is called.
> 
> That would mean distance can be negative, or rather a large unsigned number
> and low_pfn and min_pfn end up away from the zone?
> 
> Or maybe the above doesn't happen, but cc->free_pfn gets so close to start
> of the zone, that the calculations above make min_pfn go below start_pfn?
> 

I think the last part is more likely, going below start_pfn

> In any case I would rather make sure we stay within the expected zone
> boundaries, than play tricks with PageReserved. Mel?
> 

It would be preferable because this time it's PageReserved that happened
to trip up an assumption in set_pfnblock_flags_mask but if it was a real
zone and real page then compaction is migrating cross-zone which would
be surprising.

Maybe this untested patch?


diff --git a/mm/compaction.c b/mm/compaction.c
index 13cb7a961b31..ef1b5dacc289 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -1330,6 +1330,10 @@ fast_isolate_freepages(struct compact_control *cc)
 	low_pfn = pageblock_start_pfn(cc->free_pfn - (distance >> 2));
 	min_pfn = pageblock_start_pfn(cc->free_pfn - (distance >> 1));
 
+	/* Ensure the PFN is within the zone */
+	low_pfn = max(cc->zone->zone_start_pfn, low_pfn);
+	min_pfn = max(cc->zone->zone_start_pfn, min_pfn);
+
 	if (WARN_ON_ONCE(min_pfn > low_pfn))
 		low_pfn = min_pfn;
 


-- 
Mel Gorman
SUSE Labs
