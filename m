Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E7152C5248
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 11:47:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388334AbgKZKrZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 05:47:25 -0500
Received: from mx2.suse.de ([195.135.220.15]:57850 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388289AbgKZKrZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 05:47:25 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 45855AC2E;
        Thu, 26 Nov 2020 10:47:23 +0000 (UTC)
Date:   Thu, 26 Nov 2020 10:47:20 +0000
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
Message-ID: <20201126104720.GO3306@suse.de>
References: <8C537EB7-85EE-4DCF-943E-3CC0ED0DF56D@lca.pw>
 <20201121194506.13464-1-aarcange@redhat.com>
 <20201121194506.13464-2-aarcange@redhat.com>
 <ea911b11-945f-d2c5-5558-a3fe0bda492a@suse.cz>
 <20201124133205.GK3306@suse.de>
 <X71zdnZd61r429aO@redhat.com>
 <20201125103053.GL3306@suse.de>
 <X76bnmBb2rkef/nS@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <X76bnmBb2rkef/nS@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 25, 2020 at 12:59:58PM -0500, Andrea Arcangeli wrote:
> On Wed, Nov 25, 2020 at 10:30:53AM +0000, Mel Gorman wrote:
> > On Tue, Nov 24, 2020 at 03:56:22PM -0500, Andrea Arcangeli wrote:
> > > Hello,
> > > 
> > > On Tue, Nov 24, 2020 at 01:32:05PM +0000, Mel Gorman wrote:
> > > > I would hope that is not the case because they are not meant to overlap.
> > > > However, if the beginning of the pageblock was not the start of a zone
> > > > then the pages would be valid but the pfn would still be outside the
> > > > zone boundary. If it was reserved, the struct page is valid but not
> > > > suitable for set_pfnblock_flags_mask. However, it is a concern in
> > > > general because the potential is there that pages are isolated from the
> > > > wrong zone.
> > > 
> > > I guess we have more than one issue to correct in that function
> > > because the same BUG_ON reproduced again even with the tentative patch
> > > I posted earlier.
> > > 
> > > So my guess is that the problematic reserved page isn't pointed by the
> > > min_pfn, but it must have been pointed by the "highest" variable
> > > calculated below?
> > > 
> > > 			if (pfn >= highest)
> > > 				highest = pageblock_start_pfn(pfn);
> > > 
> > > When I looked at where "highest" comes from, it lacks
> > > pageblock_pfn_to_page check (which was added around v5.7 to min_pfn).
> > > 
> > > Is that the real bug, which may be fixed by something like this? (untested)
> > > 
> > 
> > It's plausible as it is a potential source of leaking but as you note
> > in another mail, it's surprising to me that valid struct pages, even if
> > within memory holes and reserved would have broken node/zone information
> > in the page flags.
> 
> I think the patch to add pageblock_pfn_to_page is still needed to cope
> with !pfn_valid or a pageblock in between zones, but pfn_valid or
> pageblock in between zones is not what happens here.
> 
> So the patch adding pageblock_pfn_to_page would have had the undesired
> side effect of hiding the bug so it's best to deal with the other bug
> first.
> 

Agreed. This thread has a lot of different directions in it at this
point so what I'd hope for is first, a patch that initialises holes with
zone/node linkages within a 1<<(MAX_ORDER-1) alignment. If there is a
hole, it would be expected the pages are PageReserved. Second, a fix to
fast_isolate that forces PFNs returned to always be within the stated
zone boundaries.

The first is because there are assumptions that without HOLES_IN_ZONE, a
true pfn_valid within 1<<(MAX_ORDER-1) means pfn_valid would be true for
any PFN within that range. That assumption is relaxed in many cases --
e.g. the page allocator may not care at the moment because of how it
orders checks but compaction assumes that pfn_valid within a pageblock
means that all PFNs within that pageblock are valid.

-- 
Mel Gorman
SUSE Labs
