Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B7332C323E
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 21:57:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728745AbgKXU4f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 15:56:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53156 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726546AbgKXU4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 15:56:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606251392;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DQaAq+ErSQX3LvC7eedI83glP+nWCxJM2V9VY+ARwaM=;
        b=hcVEqZ+CRbkK9OY9T+TTZ4riLFszVjO8Q+Q/NU103VSj1UkCj4ZqvgR4vNQdDI4mMFGRKP
        AamZqjpS50qcT7fusLMZ85ZQKknE4mv+VOiKBN/g2uQtqCGwfyL0mpRyHZErSdPtAuXDrG
        kwkS2FD1mL0rM03SfsqyeNO8MgeYdK0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-349-EM2vTFtDOkO35lqCbw-ikw-1; Tue, 24 Nov 2020 15:56:29 -0500
X-MC-Unique: EM2vTFtDOkO35lqCbw-ikw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3B019100C60F;
        Tue, 24 Nov 2020 20:56:27 +0000 (UTC)
Received: from mail (ovpn-112-190.rdu2.redhat.com [10.10.112.190])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4A0885D9CA;
        Tue, 24 Nov 2020 20:56:23 +0000 (UTC)
Date:   Tue, 24 Nov 2020 15:56:22 -0500
From:   Andrea Arcangeli <aarcange@redhat.com>
To:     Mel Gorman <mgorman@suse.de>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Qian Cai <cai@lca.pw>, Michal Hocko <mhocko@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        linux-kernel@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>,
        Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH 1/1] mm: compaction: avoid fast_isolate_around() to set
 pageblock_skip on reserved pages
Message-ID: <X71zdnZd61r429aO@redhat.com>
References: <8C537EB7-85EE-4DCF-943E-3CC0ED0DF56D@lca.pw>
 <20201121194506.13464-1-aarcange@redhat.com>
 <20201121194506.13464-2-aarcange@redhat.com>
 <ea911b11-945f-d2c5-5558-a3fe0bda492a@suse.cz>
 <20201124133205.GK3306@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201124133205.GK3306@suse.de>
User-Agent: Mutt/2.0.2 (2020-11-20)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Tue, Nov 24, 2020 at 01:32:05PM +0000, Mel Gorman wrote:
> I would hope that is not the case because they are not meant to overlap.
> However, if the beginning of the pageblock was not the start of a zone
> then the pages would be valid but the pfn would still be outside the
> zone boundary. If it was reserved, the struct page is valid but not
> suitable for set_pfnblock_flags_mask. However, it is a concern in
> general because the potential is there that pages are isolated from the
> wrong zone.

I guess we have more than one issue to correct in that function
because the same BUG_ON reproduced again even with the tentative patch
I posted earlier.

So my guess is that the problematic reserved page isn't pointed by the
min_pfn, but it must have been pointed by the "highest" variable
calculated below?

			if (pfn >= highest)
				highest = pageblock_start_pfn(pfn);

When I looked at where "highest" comes from, it lacks
pageblock_pfn_to_page check (which was added around v5.7 to min_pfn).

Is that the real bug, which may be fixed by something like this? (untested)

==
From 262671e88723b3074251189004ceae39dcd1689d Mon Sep 17 00:00:00 2001
From: Andrea Arcangeli <aarcange@redhat.com>
Date: Sat, 21 Nov 2020 12:55:58 -0500
Subject: [PATCH 1/1] mm: compaction: avoid fast_isolate_around() to set
 pageblock_skip on reserved pages

A corollary issue was fixed in
e577c8b64d58fe307ea4d5149d31615df2d90861. A second issue remained in
v5.7:

	https://lkml.kernel.org/r/8C537EB7-85EE-4DCF-943E-3CC0ED0DF56D@lca.pw

==
page:ffffea0000aa0000 refcount:1 mapcount:0 mapping:000000002243743b index:0x0
flags: 0x1fffe000001000(reserved)
==

73a6e474cb376921a311786652782155eac2fdf0 was applied to supposedly fix
the second issue, but it still reproduces with v5.9 on two different
systems:

==
page:0000000062b3e92f refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x39800
flags: 0x1000(reserved)
raw: 0000000000001000 fffff5b880e60008 fffff5b880e60008 0000000000000000
raw: 0000000000000000 0000000000000000 00000001ffffffff 0000000000000000
page dumped because: VM_BUG_ON_PAGE(!zone_spans_pfn(page_zone(page), pfn))
==
page:000000004d32675d refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x7a200
flags: 0x1fff000000001000(reserved)
raw: 1fff000000001000 ffffe6c5c1e88008 ffffe6c5c1e88008 0000000000000000
raw: 0000000000000000 0000000000000000 00000001ffffffff 0000000000000000
page dumped because: VM_BUG_ON_PAGE(!zone_spans_pfn(page_zone(page), pfn))
==

The page is "reserved" in all cases. In the last two crashes with the
pfn:

pfn 0x39800 -> 0x39800000 min_pfn hit non-RAM:

39639000-39814fff : Unknown E820 type

pfn 0x7a200 -> 0x7a200000 min_pfn hit non-RAM:

7a17b000-7a216fff : Unknown E820 type

The pageblock_pfn_to_page check was missing when rewinding pfn to the
start of the pageblock to calculate the "highest" value.

So the "highest" pfn could point to a non valid pfn or not within the
zone, checking the pageblock_pfn_to_page fixes it.

Fixes: 5a811889de10 ("mm, compaction: use free lists to quickly locate a migration target")
Signed-off-by: Andrea Arcangeli <aarcange@redhat.com>
---
 mm/compaction.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/mm/compaction.c b/mm/compaction.c
index 653862aba266..76f061af8f22 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -1418,8 +1418,14 @@ fast_isolate_freepages(struct compact_control *cc)
 			nr_scanned++;
 			pfn = page_to_pfn(freepage);
 
-			if (pfn >= highest)
-				highest = pageblock_start_pfn(pfn);
+			if (pfn >= highest) {
+				unsigned long start_pfn, end_pfn;
+				start_pfn = pageblock_start_pfn(pfn);
+				end_pfn = pageblock_end_pfn(start_pfn);
+				if (pageblock_pfn_to_page(start_pfn, end_pfn,
+							  cc->zone))
+					highest = pfn;
+			}
 
 			if (pfn >= low_pfn) {
 				cc->fast_search_fail = 0;
==


Can't we also try to scan in between start_pfn and "pfn" to see if
there's one pfn that passes the pageblock_pfn_to_page test or isn't it
worth it for the fast isolate variant?

> > Then compact_finished() detects that in
> > compact_zone(), but only after migrate_pages() and thus
> > fast_isolate_freepages() is called.
> > 
> > That would mean distance can be negative, or rather a large unsigned number
> > and low_pfn and min_pfn end up away from the zone?
> > 
> > Or maybe the above doesn't happen, but cc->free_pfn gets so close to start
> > of the zone, that the calculations above make min_pfn go below start_pfn?
> > 
> 
> I think the last part is more likely, going below start_pfn

Would it help if I dump the whole status of the zone and pages around
those addresses in the two systems that are reproducing this in v5.9
as extra check?

I was going to do that right now, to validate all zone->zone_start_pfn
and zone_end_pfn() were correct around that non-RAM reserved page
physical address.

> > In any case I would rather make sure we stay within the expected zone
> > boundaries, than play tricks with PageReserved. Mel?
> > 
> 
> It would be preferable because this time it's PageReserved that happened
> to trip up an assumption in set_pfnblock_flags_mask but if it was a real
> zone and real page then compaction is migrating cross-zone which would
> be surprising.
> 
> Maybe this untested patch?

"highest" is not influenced by either low_pfn or min_pfn so it may
very well be needed, but for another case, I don't think this can help
this specific VM_BUG_ON_PAGE if it's caused by "highest" pfn after all?

> diff --git a/mm/compaction.c b/mm/compaction.c
> index 13cb7a961b31..ef1b5dacc289 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -1330,6 +1330,10 @@ fast_isolate_freepages(struct compact_control *cc)
>  	low_pfn = pageblock_start_pfn(cc->free_pfn - (distance >> 2));
>  	min_pfn = pageblock_start_pfn(cc->free_pfn - (distance >> 1));
>  
> +	/* Ensure the PFN is within the zone */
> +	low_pfn = max(cc->zone->zone_start_pfn, low_pfn);
> +	min_pfn = max(cc->zone->zone_start_pfn, min_pfn);
> +
>  	if (WARN_ON_ONCE(min_pfn > low_pfn))
>  		low_pfn = min_pfn;
>  
> 
> 
> -- 
> Mel Gorman
> SUSE Labs
> 

