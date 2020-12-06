Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E5222D0831
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 00:48:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728477AbgLFXsK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Dec 2020 18:48:10 -0500
Received: from mx2.suse.de ([195.135.220.15]:42098 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726400AbgLFXsK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Dec 2020 18:48:10 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 809D1ACB5;
        Sun,  6 Dec 2020 23:47:28 +0000 (UTC)
Date:   Sun, 6 Dec 2020 23:47:26 +0000
From:   Mel Gorman <mgorman@suse.de>
To:     Andrea Arcangeli <aarcange@redhat.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Qian Cai <cai@lca.pw>, Michal Hocko <mhocko@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        linux-kernel@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>,
        Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH 1/1] mm: compaction: avoid fast_isolate_around() to set
 pageblock_skip on reserved pages
Message-ID: <20201206234726.GH3306@suse.de>
References: <8C537EB7-85EE-4DCF-943E-3CC0ED0DF56D@lca.pw>
 <20201121194506.13464-1-aarcange@redhat.com>
 <20201121194506.13464-2-aarcange@redhat.com>
 <ea911b11-945f-d2c5-5558-a3fe0bda492a@suse.cz>
 <20201124133205.GK3306@suse.de>
 <X71zdnZd61r429aO@redhat.com>
 <20201125103053.GL3306@suse.de>
 <X76bnmBb2rkef/nS@redhat.com>
 <20201126104720.GO3306@suse.de>
 <X8xBZ03epeQD/hsn@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <X8xBZ03epeQD/hsn@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 05, 2020 at 09:26:47PM -0500, Andrea Arcangeli wrote:
> Hi Mel,
> 
> On Thu, Nov 26, 2020 at 10:47:20AM +0000, Mel Gorman wrote:
> > Agreed. This thread has a lot of different directions in it at this
> > point so what I'd hope for is first, a patch that initialises holes with
> > zone/node linkages within a 1<<(MAX_ORDER-1) alignment. If there is a
> > hole, it would be expected the pages are PageReserved. Second, a fix to
> > fast_isolate that forces PFNs returned to always be within the stated
> > zone boundaries.
> 
> The last two patches should resolve the struct page
> initialization
> https://git.kernel.org/pub/scm/linux/kernel/git/andrea/aa.git/ and the
> VM_BUG_ON_PAGE never happened again as expected.
> 
> So I looked back to see how the "distance" logic is accurate. I added
> those checks and I get negative hits:
> 
> diff --git a/mm/compaction.c b/mm/compaction.c
> index cc1a7f600a86..844a90b0acdf 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -1331,6 +1331,12 @@ fast_isolate_freepages(struct compact_control *cc)
>  	low_pfn = pageblock_start_pfn(cc->free_pfn - (distance >> 2));
>  	min_pfn = pageblock_start_pfn(cc->free_pfn - (distance >> 1));
>  
> +	WARN_ON_ONCE((long) low_pfn < 0);
> +	WARN_ON_ONCE((long) min_pfn < 0);
> +	if ((long) low_pfn < 0)
> +		return cc->free_pfn;
> +	if ((long) min_pfn < 0)
> +		return cc->free_pfn;
>  	if (WARN_ON_ONCE(min_pfn > low_pfn))
>  		low_pfn = min_pfn;
> 
> Both warn-on-once triggers, so it goes negative. While it appears not
> kernel crashing since pfn_valid won't succeed on negative entries and
> they'll always be higher than any pfn in the freelist, is this sign
> that there's further room for improvement here?
> 

Possibly, checking the wrong pfns is simply risky. This is not tested
at all, just checking if it's in the right ballpark even. Intent is that
when the free/migrate PFNs are too close or already overlapping that no
attempt is made and it returns back to detect the scanners have met.

diff --git a/mm/compaction.c b/mm/compaction.c
index 13cb7a961b31..208cb5857446 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -1313,6 +1313,10 @@ fast_isolate_freepages(struct compact_control *cc)
 	if (cc->order <= 0)
 		return cc->free_pfn;
 
+	/* Ensure that migration and free scanner are not about to cross */
+	if (cc->migrate_pfn < cc->free_pfn)
+		return cc->free_pfn;
+
 	/*
 	 * If starting the scan, use a deeper search and use the highest
 	 * PFN found if a suitable one is not found.
@@ -1324,9 +1328,12 @@ fast_isolate_freepages(struct compact_control *cc)
 
 	/*
 	 * Preferred point is in the top quarter of the scan space but take
-	 * a pfn from the top half if the search is problematic.
+	 * a pfn from the top half if the search is problematic. Ensure
+	 * there is enough distance to make the fast search worthwhile.
 	 */
 	distance = (cc->free_pfn - cc->migrate_pfn);
+	if (distance <= (pageblock_nr_pages << 2))
+		return cc->free_pfn;
 	low_pfn = pageblock_start_pfn(cc->free_pfn - (distance >> 2));
 	min_pfn = pageblock_start_pfn(cc->free_pfn - (distance >> 1));
 

-- 
Mel Gorman
SUSE Labs
