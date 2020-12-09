Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E6112D3FFC
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 11:34:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730073AbgLIKdM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 05:33:12 -0500
Received: from mx2.suse.de ([195.135.220.15]:48802 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729841AbgLIKdK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 05:33:10 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id AE081AB63;
        Wed,  9 Dec 2020 10:32:28 +0000 (UTC)
Date:   Wed, 9 Dec 2020 11:32:26 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     David Hildenbrand <david@redhat.com>
Cc:     mhocko@kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, vbabka@suse.cz, pasha.tatashin@soleen.com
Subject: Re: [RFC PATCH v3 2/4] mm,memory_hotplug: Allocate memmap from the
 added memory range
Message-ID: <20201209103226.GC30892@linux>
References: <20201201115158.22638-1-osalvador@suse.de>
 <20201201115158.22638-3-osalvador@suse.de>
 <0e53ae49-6b0a-0714-df0f-fd6183061752@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0e53ae49-6b0a-0714-df0f-fd6183061752@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 02, 2020 at 11:05:53AM +0100, David Hildenbrand wrote:
> If you take a look at generic_online_page() there are some things that
> won't be done for our vmemmap pages
> 
> 1. kernel_map_pages(page, 1 << order, 1);
> 
> We're accessing these pages already when initializing the memmap. We
> might have to explicitly map these vmemmap pages at some point. Might
> require some thought. Did you test with debug pagealloc?

I always try to run with all debug stuff enabled, but I definitely
did not enable debug_pagealloc.
I will have a look at it.

> 2. totalram_pages_add(1UL << order);
> 
> We should add/remove the vmemmap pages manually from totalram I guess.

Yes, we should. That was a clear oversight.

> Also, I wonder if we should add these pages to the zone managed page
> count. Not quite sure yet what the benefit would be and if we care at
> all. (it's a change in behavior when hotplugging memory, though, that's
> why I am poining it out)

I would rather not since they are not "manageable" per se.
The same we do not account the pages used for bootmem stuff into zone->managed.

> > Hot-remove:
> > 
> >  If the range was using memmap on memory (aka vmemmap pages),
> >  we construct an altmap structure so free_hugepage_table does
> >  the right thing and calls vmem_altmap_free instead of
> >  free_pagetable.
> > 
> 
> You might want to update the comment in include/linux/mmzone.h for
> ZONE_MOVABLE, adding this special case when onlining such memory to the
> MOVABLE zone. The pages are movable for offlining only, not for allocations.

Sure, let us document that.

> > -int create_memory_block_devices(unsigned long start, unsigned long size)
> > +int create_memory_block_devices(unsigned long start, unsigned long size,
> > +				unsigned long vmemmap_pages)
> >  {
> >  	const unsigned long start_block_id = pfn_to_block_id(PFN_DOWN(start));
> >  	unsigned long end_block_id = pfn_to_block_id(PFN_DOWN(start + size));
> > @@ -645,9 +649,10 @@ int create_memory_block_devices(unsigned long start, unsigned long size)
> >  		return -EINVAL;
> >  
> >  	for (block_id = start_block_id; block_id != end_block_id; block_id++) {
> > -		ret = init_memory_block(block_id, MEM_OFFLINE);
> > +		ret = init_memory_block(block_id, MEM_OFFLINE, vmemmap_pages);
> >  		if (ret)
> >  			break;
> > +		vmemmap_pages = 0;
> 
> We should even bail out if someone would have vmemmap_pages set when
> creating more than one memory block device.

That cannot really happen as we would have bailed out earlier prior to
call create_memory_block_devices, by the checks in mhp_supports_memmap_on_memory.

> > -	for (pfn = start_pfn; pfn < end_pfn; pfn += MAX_ORDER_NR_PAGES)
> > -		(*online_page_callback)(pfn_to_page(pfn), MAX_ORDER - 1);
> > +	for (pfn = buddy_start_pfn; pfn < end_pfn; pfn += (1 << order)) {
> > +		order = MAX_ORDER - 1;
> > +		while (pfn & ((1 << order) - 1))
> > +			order--;
> > +		(*online_page_callback)(pfn_to_page(pfn), order);
> > +	}
> 
> I think it would be nicer to handle the unaligned part in a separate loop.

No strong opinion here, I can certainly do it.

> >  	/* mark all involved sections as online */
> >  	online_mem_sections(start_pfn, end_pfn);
> > @@ -678,6 +684,7 @@ static void __meminit resize_pgdat_range(struct pglist_data *pgdat, unsigned lon
> >  	pgdat->node_spanned_pages = max(start_pfn + nr_pages, old_end_pfn) - pgdat->node_start_pfn;
> >  
> >  }
> > +
> 
> Unrelated change.

Ups ^^

> > +static int get_memblock_vmemmap_pages_cb(struct memory_block *mem, void *arg)
> > +{
> > +	unsigned long *nr_vmemmap_pages = (unsigned long *)arg;
> > +	int ret = !mem->nr_vmemmap_pages;
> > +
> > +	if (!ret)
> > +		*nr_vmemmap_pages += mem->nr_vmemmap_pages;
> > +	return ret;
> 
> When removing in the same granularity than adding, all we care about it
> the first memory block.
> 
> 
> unsigned long *nr_vmemmap_pages = (unsigned long *)arg;
> 
> *nr_vmemmap_pages = mem->nr_vmemmap_pages;
> /* We only care about the first memory block. */
> return 1;

Yeah, cleaner, thanks

> > +	/*
> > +	 * Prepare a vmem_altmap struct if we used it at hot-add, so
> > +	 * remove_pmd_table->free_hugepage_table does the right thing.
> > +	 */
> > +	(void)walk_memory_blocks(start, size, &nr_vmemmap_pages,
> > +	     get_memblock_vmemmap_pages_cb);
> > +	if (nr_vmemmap_pages) {
> > +		mhp_altmap.alloc = nr_vmemmap_pages;
> > +		altmap = &mhp_altmap;
> > +	}
> > +
> 
> If someone would remove_memory() in a different granularity than
> add_memory(), this would no longer work. How can we catch that
> efficiently? Or at least document that this is not supported with
> memmap_on_memory).

Well, we can check whether the size spans more than a single memory block.
And if it does, we can print a warning with pr_warn and refuse to remove
the memory.

We could document that "memory_hotplug.memmap_on_memory" is meant to operate
with ranges that span a single memory block.
And I guess that we could place that documentation under [1].

[1] Documentation/admin-guide/kernel-parameters.txt

Thanks for the review David

-- 
Oscar Salvador
SUSE L3
