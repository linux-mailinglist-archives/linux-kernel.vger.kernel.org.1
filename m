Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A98F72D96FA
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 12:06:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407548AbgLNLF4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 06:05:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:50718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2407536AbgLNLFn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 06:05:43 -0500
Date:   Mon, 14 Dec 2020 13:04:48 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607943897;
        bh=fKqa8TVApB7xa01h/YZquhdJwHKNBQpknfYR9R4FfQI=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=koD3ffQkmYVKJC7bV1XPAXNipuetPJxHgY4cgLOoYnh5hcQCSUkjyxf3b0LxTNL9g
         pdLdINw7KKOGoaMh8mI56wYZckQcp4312U3jCdZPDT05FrV9cjiDgqz6rTfA5MWI6v
         TLOjumu/0S6v7sE2Ubu0DYY0dY+siPhkV9RqoJuVjB/T1cmSTw6A1xKgSLr0kPPcLg
         H2aRgLrM+BYus3qFEqPt7JVyqzMQkT1j5MoF0ETrVsOKbZ64fVfx4TfT6ocFfS1PWR
         z7e/899Yhmf2D3xURBviGhCBeftF4iNq6S7/Efrh4r1tO8atTS9FguO08l57SJgb66
         deE1/B+T1q1GQ==
From:   Mike Rapoport <rppt@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Baoquan He <bhe@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, gopakumarr@vmware.com,
        akpm@linux-foundation.org, natechancellor@gmail.com,
        ndesaulniers@google.com, clang-built-linux@googlegroups.com,
        rostedt@goodmis.org, manir@vmware.com, lauyiuch@vmware.com,
        pjonasson@vmware.com, rajaramv@vmware.com
Subject: Re: [PATCH 2/2] mm: rename memmap_init() and memmap_init_zone()
Message-ID: <20201214110448.GB198219@kernel.org>
References: <20201213150942.20990-1-bhe@redhat.com>
 <20201213150942.20990-3-bhe@redhat.com>
 <c53c5290-b5c1-87bb-d562-348d4c8bd7eb@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c53c5290-b5c1-87bb-d562-348d4c8bd7eb@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 14, 2020 at 11:00:07AM +0100, David Hildenbrand wrote:
> On 13.12.20 16:09, Baoquan He wrote:
> > The current memmap_init_zone() only handles memory region inside one zone.
> > Actually memmap_init() does the memmap init of one zone. So rename both of
> > them accordingly.
> > 
> > And also rename the function parameter 'range_start_pfn' and local variable
> > 'range_end_pfn' to zone_start_pfn/zone_end_pfn.
> > 
> > Signed-off-by: Baoquan He <bhe@redhat.com>
> > ---
> >  arch/ia64/mm/init.c |  6 +++---
> >  include/linux/mm.h  |  2 +-
> >  mm/memory_hotplug.c |  2 +-
> >  mm/page_alloc.c     | 16 ++++++++--------
> >  4 files changed, 13 insertions(+), 13 deletions(-)
> > 
> > diff --git a/arch/ia64/mm/init.c b/arch/ia64/mm/init.c
> > index 27ca549ff47e..af678197ac2d 100644
> > --- a/arch/ia64/mm/init.c
> > +++ b/arch/ia64/mm/init.c
> > @@ -535,18 +535,18 @@ virtual_memmap_init(u64 start, u64 end, void *arg)
> >  		    / sizeof(struct page));
> >  
> >  	if (map_start < map_end)
> > -		memmap_init_zone((unsigned long)(map_end - map_start),
> > +		memmap_init_range((unsigned long)(map_end - map_start),
> >  				 args->nid, args->zone, page_to_pfn(map_start), page_to_pfn(map_end),
> >  				 MEMINIT_EARLY, NULL, MIGRATE_MOVABLE);
> >  	return 0;
> >  }
> >  
> >  void __meminit
> > -memmap_init (unsigned long size, int nid, unsigned long zone,
> > +memmap_init_zone (unsigned long size, int nid, unsigned long zone,
> >  	     unsigned long start_pfn)
> 
> While at it s/zone /zone/ please. :)
> 
> >  {
> >  	if (!vmem_map) {
> > -		memmap_init_zone(size, nid, zone, start_pfn, start_pfn + size,
> > +		memmap_init_range(size, nid, zone, start_pfn, start_pfn + size,
> >  				 MEMINIT_EARLY, NULL, MIGRATE_MOVABLE);
> >  	} else {
> >  		struct page *start;
> > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > index cd5c313729ea..3d81ebbbef89 100644
> > --- a/include/linux/mm.h
> > +++ b/include/linux/mm.h
> > @@ -2439,7 +2439,7 @@ extern int __meminit __early_pfn_to_nid(unsigned long pfn,
> >  #endif
> >  
> >  extern void set_dma_reserve(unsigned long new_dma_reserve);
> > -extern void memmap_init_zone(unsigned long, int, unsigned long,
> > +extern void memmap_init_range(unsigned long, int, unsigned long,
> >  		unsigned long, unsigned long, enum meminit_context,
> >  		struct vmem_altmap *, int migratetype);
> >  extern void setup_per_zone_wmarks(void);
> > diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> > index 47b75da63f01..579762e4f8d8 100644
> > --- a/mm/memory_hotplug.c
> > +++ b/mm/memory_hotplug.c
> > @@ -714,7 +714,7 @@ void __ref move_pfn_range_to_zone(struct zone *zone, unsigned long start_pfn,
> >  	 * expects the zone spans the pfn range. All the pages in the range
> >  	 * are reserved so nobody should be touching them so we should be safe
> >  	 */
> > -	memmap_init_zone(nr_pages, nid, zone_idx(zone), start_pfn, 0,
> > +	memmap_init_range(nr_pages, nid, zone_idx(zone), start_pfn, 0,
> >  			 MEMINIT_HOTPLUG, altmap, migratetype);
> >  
> >  	set_zone_contiguous(zone);
> > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > index 315c22974f0d..fac599deba56 100644
> > --- a/mm/page_alloc.c
> > +++ b/mm/page_alloc.c
> > @@ -6050,7 +6050,7 @@ overlap_memmap_init(unsigned long zone, unsigned long *pfn)
> >   * (usually MIGRATE_MOVABLE). Besides setting the migratetype, no related
> >   * zone stats (e.g., nr_isolate_pageblock) are touched.
> >   */
> > -void __meminit memmap_init_zone(unsigned long size, int nid, unsigned long zone,
> > +void __meminit memmap_init_range(unsigned long size, int nid, unsigned long zone,
> >  		unsigned long start_pfn, unsigned long zone_end_pfn,
> >  		enum meminit_context context,
> >  		struct vmem_altmap *altmap, int migratetype)
> > @@ -6187,21 +6187,21 @@ static void __meminit zone_init_free_lists(struct zone *zone)
> >  	}
> >  }
> >  
> > -void __meminit __weak memmap_init(unsigned long size, int nid,
> > +void __meminit __weak memmap_init_zone(unsigned long size, int nid,
> >  				  unsigned long zone,
> > -				  unsigned long range_start_pfn)
> > +				  unsigned long zone_start_pfn)
> 
> Why are we not simply passing "struct zone" like
> 
> void __meminit __weak  memmap_init_zone(struct zone *zone)
> 
> from which we can derive
> - nid
> - zone idx
> - zone_start_pfn
> - spanned_pages / zone_end_pfn
> 
> At least when called from free_area_init_core() this should work just
> fine I think.
 
There is also a custom memmap init in ia64 which at least should be
tested ;-)

More broadly, while Baoquan's fix looks Ok to me, I think we can
calculate node->first_deferred_pfn earlier in, say,
free_area_init_node() rather than do defer_init() check for each pfn.
 
> >  {
> >  	unsigned long start_pfn, end_pfn;
> > -	unsigned long range_end_pfn = range_start_pfn + size;
> > +	unsigned long zone_end_pfn = zone_start_pfn + size;
> >  	int i;
> >  
> >  	for_each_mem_pfn_range(i, nid, &start_pfn, &end_pfn, NULL) {
> > -		start_pfn = clamp(start_pfn, range_start_pfn, range_end_pfn);
> > -		end_pfn = clamp(end_pfn, range_start_pfn, range_end_pfn);
> > +		start_pfn = clamp(start_pfn, zone_start_pfn, zone_end_pfn);
> > +		end_pfn = clamp(end_pfn, zone_start_pfn, zone_end_pfn);
> >  
> >  		if (end_pfn > start_pfn) {
> >  			size = end_pfn - start_pfn;
> > -			memmap_init_zone(size, nid, zone, start_pfn, range_end_pfn,
> > +			memmap_init_range(size, nid, zone, start_pfn, zone_end_pfn,
> >  					 MEMINIT_EARLY, NULL, MIGRATE_MOVABLE);
> >  		}
> >  	}
> > @@ -6903,7 +6903,7 @@ static void __init free_area_init_core(struct pglist_data *pgdat)
> >  		set_pageblock_order();
> >  		setup_usemap(pgdat, zone, zone_start_pfn, size);
> >  		init_currently_empty_zone(zone, zone_start_pfn, size);
> > -		memmap_init(size, nid, j, zone_start_pfn);
> > +		memmap_init_zone(size, nid, j, zone_start_pfn);
> >  	}
> >  }
> >  
> > 
> 
> 
> -- 
> Thanks,
> 
> David / dhildenb
> 

-- 
Sincerely yours,
Mike.
