Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E8F5303519
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 06:35:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387982AbhAZFfN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 00:35:13 -0500
Received: from mx2.suse.de ([195.135.220.15]:56114 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727466AbhAYKkk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 05:40:40 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 3D70CB8F2;
        Mon, 25 Jan 2021 10:39:58 +0000 (UTC)
Date:   Mon, 25 Jan 2021 11:39:55 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     David Hildenbrand <david@redhat.com>
Cc:     akpm@linux-foundation.org, mhocko@kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, vbabka@suse.cz,
        pasha.tatashin@soleen.com
Subject: Re: [PATCH 2/5] mm,memory_hotplug: Allocate memmap from the added
 memory range
Message-ID: <20210125103951.GA27851@linux>
References: <20201217130758.11565-1-osalvador@suse.de>
 <20201217130758.11565-3-osalvador@suse.de>
 <21079c2d-67d0-fc59-8d7f-0795b3f8a3e3@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <21079c2d-67d0-fc59-8d7f-0795b3f8a3e3@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 19, 2021 at 02:58:41PM +0100, David Hildenbrand wrote:
> IIRC, there is a conflict with the hpage vmemmap freeing patch set,
> right? How are we going to handle that?

First of all, sorry for the lateness David, was a bit busy.

AFAIK, there is no conflict at the moment.
hpage vmemmap populates with basepages (PMD support is disabled).

But even with PMD support enabled, I cannot see how it can interfere.

From the mhp point of view vmemmap pages only matter when allocating it and
when freeing it.
The only moment we would have to worry about is when we have to get rid of them
(aka: the memory range that describe is being hot-removed), but the hpage
vmemmap patchset makes sure that by the time we return from dissolve_free_huge_page
the vemmap pages look as they did before the remapping.

But as I said, we do not have to worry about this one as that feature only works
when populating with base pages.

> > diff --git a/include/linux/memory.h b/include/linux/memory.h
> > index 439a89e758d8..f09d60ef8ad9 100644
> > --- a/include/linux/memory.h
> > +++ b/include/linux/memory.h
> > @@ -30,6 +30,11 @@ struct memory_block {
> >  	int phys_device;		/* to which fru does this belong? */
> >  	struct device dev;
> >  	int nid;			/* NID for this memory block */
> > +	unsigned long nr_vmemmap_pages;	/*
> > +					 * Number of vmemmap pages. These pages
> > +					 * lay at the beginning of the memory
> > +					 * block.
> > +					 */
> 
> I suggest moving this comment above nr_vmemmap_pages.

Sure, will do.

> > -static void online_pages_range(unsigned long start_pfn, unsigned long nr_pages)
> > +static void online_pages_range(unsigned long start_pfn, unsigned long nr_pages,
> > +			       unsigned long buddy_start_pfn)
> >  {
> >  	const unsigned long end_pfn = start_pfn + nr_pages;
> > -	unsigned long pfn;
> > +	unsigned long pfn = buddy_start_pfn;
> > +	unsigned int order = MAX_ORDER - 1;
> > +
> > +	/*
> > +	 * When using memmap_on_memory, the range might be unaligned as the
> > +	 * first pfns are used for vmemmap pages. Align it in case we need to.
> > +	 */
> > +	if (pfn & ((1 << order) - 1)) {
> > +		while (pfn & ((1 << order) - 1))
> > +			order--;
> > +		(*online_page_callback)(pfn_to_page(pfn), order);
> > +		pfn += 1 << order;
> > +	}
> >  
> 
> Most probably we can simplify once we assure buddy_start_pfn follows
> specific requirements (e.g., at least aligned to pageblock_nr_pages, see
> below).

Yeah, on x86_64 this is pageblock_nr_pages aligned, but will have to check
on arm64.

> > +	buddy_start_pfn = pfn + nr_vmemmap_pages;
> > +	buddy_nr_pages = nr_pages - nr_vmemmap_pages;
> > +
> >  	mem_hotplug_begin();
> >  
> >  	/* associate pfn range with the zone */
> >  	zone = zone_for_pfn_range(online_type, nid, pfn, nr_pages);
> > -	move_pfn_range_to_zone(zone, pfn, nr_pages, NULL, MIGRATE_ISOLATE);
> > +	if (nr_vmemmap_pages)
> > +		move_pfn_range_to_zone(zone, pfn, nr_vmemmap_pages, NULL,
> > +				       MIGRATE_UNMOVABLE);
> 
> One sign that we have to take care that nr_vmemmap_pages has a certain
> minimum alignment.

Right.

> > +	move_pfn_range_to_zone(zone, buddy_start_pfn, buddy_nr_pages, NULL,
> > +			       MIGRATE_ISOLATE);
> >  
> >  	arg.start_pfn = pfn;
> >  	arg.nr_pages = nr_pages;
> > @@ -810,7 +832,7 @@ int __ref online_pages(unsigned long pfn, unsigned long nr_pages,
> >  	 * onlining, such that undo_isolate_page_range() works correctly.
> >  	 */
> >  	spin_lock_irqsave(&zone->lock, flags);
> > -	zone->nr_isolate_pageblock += nr_pages / pageblock_nr_pages;
> > +	zone->nr_isolate_pageblock += buddy_nr_pages / pageblock_nr_pages;
> 
> And, another sign :)

Yap

> > -	online_pages_range(pfn, nr_pages);
> > +	online_pages_range(pfn, nr_pages, buddy_start_pfn);
> >  	zone->present_pages += nr_pages;
> >  
> >  	pgdat_resize_lock(zone->zone_pgdat, &flags);
> > @@ -836,7 +858,9 @@ int __ref online_pages(unsigned long pfn, unsigned long nr_pages,
> >  	zone_pcp_update(zone);
> >  
> >  	/* Basic onlining is complete, allow allocation of onlined pages. */
> > -	undo_isolate_page_range(pfn, pfn + nr_pages, MIGRATE_MOVABLE);
> > +	undo_isolate_page_range(buddy_start_pfn,
> > +				buddy_start_pfn + buddy_nr_pages,
> > +				MIGRATE_MOVABLE);
> 
> Yet another sign :)

Yap


> >  int __ref add_memory_resource(int nid, struct resource *res, mhp_t mhp_flags)
> >  {
> >  	struct mhp_params params = { .pgprot = PAGE_KERNEL };
> > +	struct vmem_altmap mhp_altmap = {};
> >  	u64 start, size;
> >  	bool new_node = false;
> >  	int ret;
> > @@ -1046,13 +1077,32 @@ int __ref add_memory_resource(int nid, struct resource *res, mhp_t mhp_flags)
> >  		goto error;
> >  	new_node = ret;
> >  
> > +	/*
> > +	 * Return -EINVAL if the caller specified MHP_MEMMAP_ON_MEMORY and we do
> > +	 * not support it.
> > +	 */
> 
> The "Return -EINVAL" part is obvious. Maybe drop that comment.

Sure.

> > +	if (mhp_flags & MHP_MEMMAP_ON_MEMORY) {
> > +		mhp_altmap.free = size >> PAGE_SHIFT;
> > +		mhp_altmap.base_pfn = start >> PAGE_SHIFT;
> 
> Could use PFN_PHYS() for both.

Will do.

> I'd combine both parts
> 
> if (mhp_flags & MHP_MEMMAP_ON_MEMORY) {
> 	if (!mhp_supports_memmap_on_memory(size)) {
> 		ret = -EINVAL;
> 		goto error;
> 	}
> 	mhp_altmap.free = PFN_PHYS(size);
> 	mhp_altmap.base_pfn = PFN_PHYS(size);
> 	params.altmap = &mhp_altmap;
> 
> }

Ok, cleaner.

> Interresting, so we automatically support differeing sizeof(struct
> page). I guess it will be problematic in case of sizeof(struct page) !=
> 64, because then, we might not have multiples of 2MB for the memmap of a
> memory block.
> 
> IIRC, it could happen that if we add two consecutive memory blocks, that
> the second one might reuse parts of the vmemmap residing on the first
> memory block. If you remove the first one, you might be in trouble.
> 
> E.g., on x86-64
>  vmemmap_populate()->vmemmap_populate_hugepages()->vmemmap_alloc_block_buf():
> - Populate a huge page
> 
> vmemmap_free()->remove_pagetable()...->remove_pmd_table():
> - memchr_inv() will leave the hugepage populated.
> 
> Do we want to fence that off, maybe in mhp_supports_memmap_on_memory()?
> Or do we somehow want to fix that? We should never populate partial huge
> pages from an altmap ...
> 
> But maybe I am missing something.

No, you are not missing anything.

I think that remove_pmd_table() should be fixed.
vmemmap_populate_hugepages() allocates PMD_SIZE chunk and marks the PMD as
PAGE_KERNEL_LARGE, so when remove_pmd_table() sees that 1) the PMD
is large and 2) the chunk is not aligned, the memset() should be writing
PAGE_INUSE for a PMD chunk.

I do not really a see a reason why this should not happen.
Actually, we will be leaving pagetables behind as we never get to free
the PMD chunk when sizeof(struct page) is not a multiple of 2MB.

I plan to fix remove_pmd_table(), but for now let us not allow to use this feature
if the size of a struct page is not 64.
Let us keep it simply for the time being, shall we?

> >  	/* set above range as isolated */
> > -	ret = start_isolate_page_range(start_pfn, end_pfn,
> > +	ret = start_isolate_page_range(buddy_start_pfn, end_pfn,
> >  				       MIGRATE_MOVABLE,
> >  				       MEMORY_OFFLINE | REPORT_FAILURE);
> 
> If buddy_start_pfn is not aligned to pageblocks,
> start_isolate_page_range will BUG_ON(). another sign that we need to
> check that somewhere while adding that nr_vmemmap_pages is suitable.

Will come up with a way to 1) ensure that vmemmap pages is aligned and
2) disallow to use the feature in case it cannot be aligned for some reason.

 
> Let's avoid using the "memblock" terminology. Just call it
> "get_nr_vmemmap_pages_cb" or maybe "detect_memmap_on_memory_cb"

Fine.

> > +	unsigned long *nr_vmemmap_pages = (unsigned long *)arg;
> > +	int ret = !mem->nr_vmemmap_pages;
> > +
> > +	if (!ret)
> > +		*nr_vmemmap_pages += mem->nr_vmemmap_pages;
> > +	return ret;
> 
> I think you can avoid "ret".
> 
> Also, we want to stop whenever we find "mem->nr_vmemmap_pages != 0",
> right? AFAIU, you would currently stop whenever you find
> mem->nr_vmemmap_pages == 0", which is wrong.
> 
> *nr_vmemmap_pages += mem->nr_vmemmap_pages;
> /* Stop whenever we find any sign of MHP_MEMMAP_ON_MEMORY. */
> return mem->nr_vmemmap_pages;

Yeah, true is that current logic is wrong, but we do not want to stop when
mem->nr_vmemmap_pages == 0 either.
Since we want to avoid people to remove with a different granularity than it was
added, we need to check the whole memory range that is going to be hot-removed
and check for mem->nr_vmemmap_pages to make sure that the range does not
have any self-hosted vmemmap pages.

E.g:

[memory_block not using vmemmap] memblock#0
[memory block using vmemmap]	 memblock#1

So, if someone tries to remove memblock#0 and memblock#1 and once, we need
to check whether any of the memblocks used self-hosted vmemmap, and if so,
scream out loud if we are trying to remove site != memblock_size.

> > +	/*
> > +	 * When using MHP_MEMMAP_ON_MEMORY, add_memory and remove_memory needs
> > +	 * to work with the same granularity.
> > +	 * Check that we are not violating that assumption.
> > +	 * The only way we have right now is to walk all the memory
> > +	 * blocks we are trying to remove and see if any has vmemmap pages.
> > +	 * We should not have any as memmap_on_memory only works with ranges
> > +	 * that spans a single memory block, so if we found any and size spans
> > +	 * more than a memory block, we know we have to scream.
> > +	 * We only need to check this if memmap_on_memory_enabled=true.
> > +	 */
> 
> Can we simplify that comment?
> 
> /*
>  * We only support remvoing memory added with MHP_MEMMAP_ON_MEMORY in
>  * the same granularity it was added - a single memory block.
>  */

Yeah.

> 
> > +	if (memmap_on_memory_enabled) {
> > +		(void)walk_memory_blocks(start, size, &nr_vmemmap_pages,
> > +					 get_memblock_vmemmap_pages_cb);
> 
> you can drop the "(void)", just like other users that ignore the return
> value.

ok

Thanks for the throughout review!
 

-- 
Oscar Salvador
SUSE L3
