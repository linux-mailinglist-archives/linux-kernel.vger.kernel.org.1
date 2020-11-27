Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DCDD2C688E
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 16:16:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730567AbgK0PPk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 10:15:40 -0500
Received: from mx2.suse.de ([195.135.220.15]:39766 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727653AbgK0PPj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 10:15:39 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1606490136; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=896bNgG1i3qNNcIk7piIhQBIwrBaFyT+9Ceh2gB/bGs=;
        b=hGLfVsVqaD8nrsB2HRKx3ttJ/Zl8CLhDAUYbcOGssyxJQWAbC4VyzUeGNXjL90v6cnWTFU
        VU9CX729amxVaZXxGYlTBboKwtnoWdnJ9yvW1ogHAQA4O0RGNjvPJL/9PH96o32JmSsC7Y
        C3SivVK+fmzXQskgqjX7Dm8XpOpN4D4=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C77CEAC2D;
        Fri, 27 Nov 2020 15:15:36 +0000 (UTC)
Date:   Fri, 27 Nov 2020 16:15:36 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Oscar Salvador <osalvador@suse.de>
Cc:     david@redhat.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        vbabka@suse.cz, pasha.tatashin@soleen.com
Subject: Re: [RFC PATCH v2 2/4] mm,memory_hotplug: Allocate memmap from the
 added memory range
Message-ID: <20201127151536.GV31550@dhcp22.suse.cz>
References: <20201125112048.8211-1-osalvador@suse.de>
 <20201125112048.8211-3-osalvador@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201125112048.8211-3-osalvador@suse.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 25-11-20 12:20:46, Oscar Salvador wrote:
> Physical memory hotadd has to allocate a memmap (struct page array) for
> the newly added memory section. Currently, alloc_pages_node() is used
> for those allocations.
> 
> This has some disadvantages:
>  a) an existing memory is consumed for that purpose
>     (eg: ~2MB per 128MB memory section on x86_64)
>  b) if the whole node is movable then we have off-node struct pages
>     which has performance drawbacks.
>  c) It might be there are no PMD_ALIGNED chunks so memmap array gets
>     populated with base pages.
> 
> This can be improved when CONFIG_SPARSEMEM_VMEMMAP is enabled.
> 
> Vmemap page tables can map arbitrary memory.
> That means that we can simply use the beginning of each memory section and
> map struct pages there.

Did you mean each memory block rather than section?

> struct pages which back the allocated space then just need to be treated
> carefully.
> 
> Implementation wise we will reuse vmem_altmap infrastructure to override
> the default allocator used by __populate_section_memmap. Once the memmap is
> allocated, we are going to need a way to mark altmap pfns used for the allocation.
> If MHP_MEMMAP_ON_MEMORY flag was passed, we will set up the layout of the
> altmap structure in add_memory_resouce(), and then we will call
> mhp_mark_vmemmap_pages() to properly mark those pages.
> 
> Online/Offline:
> 
>  In the memory_block structure, a new field is created in order to
>  store the number of vmemmap_pages.

Is this really needed? We know how many pfns are required for a block of
a specific size, right?

I have only glanced through the patch so I might be missing something
but I am really wondering why you haven't chosen to use altmap directly
here.

>  Having that around simplifies things a lot since in {online/offline}_pages
>  we can know how much we have to skip forward until we have the first non-
>  vmemmap page, for operations like isolation/migration/initialization.
> 
> Hot-remove:
> 
>  If the range was using memmap on memory (aka vmemmap pages),
>  we construct an altmap structure so free_hugepage_table does
>  the right thing and calls vmem_altmap_free instead of
>  free_pagetable.

It would be also good to describe how does a pfn walker recognize such a
page? Most of them will simply ignore it but e.g. hotplug walker will
need to skip over those because they are not preventing offlining as
they will go away with the memory block together.

Some basic description of testing done would be suitable as well.

Thanks!

> Signed-off-by: Oscar Salvador <osalvador@suse.de>
> ---
>  arch/powerpc/platforms/powernv/memtrace.c |  2 +-
>  drivers/base/memory.c                     | 21 +++--
>  include/linux/memory.h                    |  7 +-
>  include/linux/memory_hotplug.h            | 13 +++-
>  include/linux/memremap.h                  |  2 +-
>  mm/memory_hotplug.c                       | 95 ++++++++++++++++++-----
>  mm/page_alloc.c                           |  4 +-
>  7 files changed, 107 insertions(+), 37 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/powernv/memtrace.c b/arch/powerpc/platforms/powernv/memtrace.c
> index 6828108486f8..8d45b8a5a9d0 100644
> --- a/arch/powerpc/platforms/powernv/memtrace.c
> +++ b/arch/powerpc/platforms/powernv/memtrace.c
> @@ -79,7 +79,7 @@ static bool memtrace_offline_pages(u32 nid, u64 start_pfn, u64 nr_pages)
>  	walk_memory_blocks(start, size, (void *)MEM_GOING_OFFLINE,
>  			   change_memblock_state);
>  
> -	if (offline_pages(start_pfn, nr_pages)) {
> +	if (offline_pages(start_pfn, nr_pages, 0)) {
>  		walk_memory_blocks(start, size, (void *)MEM_ONLINE,
>  				   change_memblock_state);
>  		return false;
> diff --git a/drivers/base/memory.c b/drivers/base/memory.c
> index eef4ffb6122c..675974e39a84 100644
> --- a/drivers/base/memory.c
> +++ b/drivers/base/memory.c
> @@ -175,7 +175,7 @@ int memory_notify(unsigned long val, void *v)
>   */
>  static int
>  memory_block_action(unsigned long start_section_nr, unsigned long action,
> -		    int online_type, int nid)
> +		    int online_type, int nid, unsigned long nr_vmemmap_pages)
>  {
>  	unsigned long start_pfn;
>  	unsigned long nr_pages = PAGES_PER_SECTION * sections_per_block;
> @@ -185,10 +185,11 @@ memory_block_action(unsigned long start_section_nr, unsigned long action,
>  
>  	switch (action) {
>  	case MEM_ONLINE:
> -		ret = online_pages(start_pfn, nr_pages, online_type, nid);
> +		ret = online_pages(start_pfn, nr_pages, nr_vmemmap_pages,
> +				   online_type, nid);
>  		break;
>  	case MEM_OFFLINE:
> -		ret = offline_pages(start_pfn, nr_pages);
> +		ret = offline_pages(start_pfn, nr_pages, nr_vmemmap_pages);
>  		break;
>  	default:
>  		WARN(1, KERN_WARNING "%s(%ld, %ld) unknown action: "
> @@ -211,7 +212,7 @@ static int memory_block_change_state(struct memory_block *mem,
>  		mem->state = MEM_GOING_OFFLINE;
>  
>  	ret = memory_block_action(mem->start_section_nr, to_state,
> -				  mem->online_type, mem->nid);
> +				  mem->online_type, mem->nid, mem->nr_vmemmap_pages);
>  
>  	mem->state = ret ? from_state_req : to_state;
>  
> @@ -571,7 +572,8 @@ int register_memory(struct memory_block *memory)
>  	return ret;
>  }
>  
> -static int init_memory_block(unsigned long block_id, unsigned long state)
> +static int init_memory_block(unsigned long block_id, unsigned long state,
> +			     unsigned long nr_vmemmap_pages)
>  {
>  	struct memory_block *mem;
>  	unsigned long start_pfn;
> @@ -591,6 +593,7 @@ static int init_memory_block(unsigned long block_id, unsigned long state)
>  	start_pfn = section_nr_to_pfn(mem->start_section_nr);
>  	mem->phys_device = arch_get_memory_phys_device(start_pfn);
>  	mem->nid = NUMA_NO_NODE;
> +	mem->nr_vmemmap_pages = nr_vmemmap_pages;
>  
>  	ret = register_memory(mem);
>  
> @@ -610,7 +613,7 @@ static int add_memory_block(unsigned long base_section_nr)
>  	if (section_count == 0)
>  		return 0;
>  	return init_memory_block(memory_block_id(base_section_nr),
> -				 MEM_ONLINE);
> +				 MEM_ONLINE, 0);
>  }
>  
>  static void unregister_memory(struct memory_block *memory)
> @@ -632,7 +635,8 @@ static void unregister_memory(struct memory_block *memory)
>   *
>   * Called under device_hotplug_lock.
>   */
> -int create_memory_block_devices(unsigned long start, unsigned long size)
> +int create_memory_block_devices(unsigned long start, unsigned long size,
> +				unsigned long vmemmap_pages)
>  {
>  	const unsigned long start_block_id = pfn_to_block_id(PFN_DOWN(start));
>  	unsigned long end_block_id = pfn_to_block_id(PFN_DOWN(start + size));
> @@ -645,9 +649,10 @@ int create_memory_block_devices(unsigned long start, unsigned long size)
>  		return -EINVAL;
>  
>  	for (block_id = start_block_id; block_id != end_block_id; block_id++) {
> -		ret = init_memory_block(block_id, MEM_OFFLINE);
> +		ret = init_memory_block(block_id, MEM_OFFLINE, vmemmap_pages);
>  		if (ret)
>  			break;
> +		vmemmap_pages = 0;
>  	}
>  	if (ret) {
>  		end_block_id = block_id;
> diff --git a/include/linux/memory.h b/include/linux/memory.h
> index 439a89e758d8..b910d2aea879 100644
> --- a/include/linux/memory.h
> +++ b/include/linux/memory.h
> @@ -30,6 +30,11 @@ struct memory_block {
>  	int phys_device;		/* to which fru does this belong? */
>  	struct device dev;
>  	int nid;			/* NID for this memory block */
> +	unsigned long nr_vmemmap_pages;	/*
> +					 * Number of vmemmap pages. These pages
> +					 * lay at the beginning of the memory
> +					 * block.
> +					 */
>  };
>  
>  int arch_get_memory_phys_device(unsigned long start_pfn);
> @@ -81,7 +86,7 @@ static inline int memory_notify(unsigned long val, void *v)
>  #else
>  extern int register_memory_notifier(struct notifier_block *nb);
>  extern void unregister_memory_notifier(struct notifier_block *nb);
> -int create_memory_block_devices(unsigned long start, unsigned long size);
> +int create_memory_block_devices(unsigned long start, unsigned long size, unsigned long vmemmap_pages);
>  void remove_memory_block_devices(unsigned long start, unsigned long size);
>  extern void memory_dev_init(void);
>  extern int memory_notify(unsigned long val, void *v);
> diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
> index 5b1ea1f8d1ab..757452279965 100644
> --- a/include/linux/memory_hotplug.h
> +++ b/include/linux/memory_hotplug.h
> @@ -121,11 +121,13 @@ extern int zone_grow_waitqueues(struct zone *zone, unsigned long nr_pages);
>  extern int add_one_highpage(struct page *page, int pfn, int bad_ppro);
>  /* VM interface that may be used by firmware interface */
>  extern int online_pages(unsigned long pfn, unsigned long nr_pages,
> -			int online_type, int nid);
> +			unsigned long nr_vmemmap_pages, int online_type,
> +			int nid);
>  extern struct zone *test_pages_in_a_zone(unsigned long start_pfn,
>  					 unsigned long end_pfn);
>  extern void __offline_isolated_pages(unsigned long start_pfn,
> -				     unsigned long end_pfn);
> +				     unsigned long end_pfn,
> +				     unsigned long buddy_start_pfn);
>  
>  typedef void (*online_page_callback_t)(struct page *page, unsigned int order);
>  
> @@ -320,7 +322,8 @@ static inline void pgdat_resize_init(struct pglist_data *pgdat) {}
>  #ifdef CONFIG_MEMORY_HOTREMOVE
>  
>  extern void try_offline_node(int nid);
> -extern int offline_pages(unsigned long start_pfn, unsigned long nr_pages);
> +extern int offline_pages(unsigned long start_pfn, unsigned long nr_pages,
> +			 unsigned long nr_vmemmap_pages);
>  extern int remove_memory(int nid, u64 start, u64 size);
>  extern void __remove_memory(int nid, u64 start, u64 size);
>  extern int offline_and_remove_memory(int nid, u64 start, u64 size);
> @@ -328,7 +331,8 @@ extern int offline_and_remove_memory(int nid, u64 start, u64 size);
>  #else
>  static inline void try_offline_node(int nid) {}
>  
> -static inline int offline_pages(unsigned long start_pfn, unsigned long nr_pages)
> +static inline int offline_pages(unsigned long start_pfn, unsigned long nr_pages,
> +				unsigned long nr_vmemmap_pages)
>  {
>  	return -EINVAL;
>  }
> @@ -369,6 +373,7 @@ extern struct page *sparse_decode_mem_map(unsigned long coded_mem_map,
>  					  unsigned long pnum);
>  extern struct zone *zone_for_pfn_range(int online_type, int nid, unsigned start_pfn,
>  		unsigned long nr_pages);
> +extern bool mhp_supports_memmap_on_memory(unsigned long size);
>  #endif /* CONFIG_MEMORY_HOTPLUG */
>  
>  #endif /* __LINUX_MEMORY_HOTPLUG_H */
> diff --git a/include/linux/memremap.h b/include/linux/memremap.h
> index 79c49e7f5c30..3465681cf664 100644
> --- a/include/linux/memremap.h
> +++ b/include/linux/memremap.h
> @@ -17,7 +17,7 @@ struct device;
>   * @alloc: track pages consumed, private to vmemmap_populate()
>   */
>  struct vmem_altmap {
> -	const unsigned long base_pfn;
> +	unsigned long base_pfn;
>  	const unsigned long end_pfn;
>  	const unsigned long reserve;
>  	unsigned long free;
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 63b2e46b6555..87fbc2cc0d90 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -607,10 +607,12 @@ void generic_online_page(struct page *page, unsigned int order)
>  }
>  EXPORT_SYMBOL_GPL(generic_online_page);
>  
> -static void online_pages_range(unsigned long start_pfn, unsigned long nr_pages)
> +static void online_pages_range(unsigned long start_pfn, unsigned long nr_pages,
> +			       unsigned long buddy_start_pfn)
>  {
>  	const unsigned long end_pfn = start_pfn + nr_pages;
>  	unsigned long pfn;
> +	unsigned int order;
>  
>  	/*
>  	 * Online the pages in MAX_ORDER - 1 aligned chunks. The callback might
> @@ -618,8 +620,12 @@ static void online_pages_range(unsigned long start_pfn, unsigned long nr_pages)
>  	 * later). We account all pages as being online and belonging to this
>  	 * zone ("present").
>  	 */
> -	for (pfn = start_pfn; pfn < end_pfn; pfn += MAX_ORDER_NR_PAGES)
> -		(*online_page_callback)(pfn_to_page(pfn), MAX_ORDER - 1);
> +	for (pfn = buddy_start_pfn; pfn < end_pfn; pfn += (1 << order)) {
> +		order = MAX_ORDER - 1;
> +		while (pfn & ((1 << order) - 1))
> +			order--;
> +		(*online_page_callback)(pfn_to_page(pfn), order);
> +	}
>  
>  	/* mark all involved sections as online */
>  	online_mem_sections(start_pfn, end_pfn);
> @@ -679,6 +685,7 @@ static void __meminit resize_pgdat_range(struct pglist_data *pgdat, unsigned lon
>  	pgdat->node_spanned_pages = max(start_pfn + nr_pages, old_end_pfn) - pgdat->node_start_pfn;
>  
>  }
> +
>  /*
>   * Associate the pfn range with the given zone, initializing the memmaps
>   * and resizing the pgdat/zone data to span the added pages. After this
> @@ -778,9 +785,9 @@ struct zone * zone_for_pfn_range(int online_type, int nid, unsigned start_pfn,
>  }
>  
>  int __ref online_pages(unsigned long pfn, unsigned long nr_pages,
> -		       int online_type, int nid)
> +		       unsigned long nr_vmemmap_pages, int online_type, int nid)
>  {
> -	unsigned long flags;
> +	unsigned long flags, buddy_start_pfn, buddy_nr_pages;
>  	struct zone *zone;
>  	int need_zonelists_rebuild = 0;
>  	int ret;
> @@ -791,11 +798,18 @@ int __ref online_pages(unsigned long pfn, unsigned long nr_pages,
>  			 !IS_ALIGNED(pfn | nr_pages, PAGES_PER_SECTION)))
>  		return -EINVAL;
>  
> +	buddy_start_pfn = pfn + nr_vmemmap_pages;
> +	buddy_nr_pages = nr_pages - nr_vmemmap_pages;
> +
>  	mem_hotplug_begin();
>  
>  	/* associate pfn range with the zone */
>  	zone = zone_for_pfn_range(online_type, nid, pfn, nr_pages);
> -	move_pfn_range_to_zone(zone, pfn, nr_pages, NULL, MIGRATE_ISOLATE);
> +	if (nr_vmemmap_pages)
> +		move_pfn_range_to_zone(zone, pfn, nr_vmemmap_pages, NULL,
> +				       MIGRATE_UNMOVABLE);
> +	move_pfn_range_to_zone(zone, buddy_start_pfn, buddy_nr_pages, NULL,
> +			       MIGRATE_ISOLATE);
>  
>  	arg.start_pfn = pfn;
>  	arg.nr_pages = nr_pages;
> @@ -811,7 +825,7 @@ int __ref online_pages(unsigned long pfn, unsigned long nr_pages,
>  	 * onlining, such that undo_isolate_page_range() works correctly.
>  	 */
>  	spin_lock_irqsave(&zone->lock, flags);
> -	zone->nr_isolate_pageblock += nr_pages / pageblock_nr_pages;
> +	zone->nr_isolate_pageblock += buddy_nr_pages / pageblock_nr_pages;
>  	spin_unlock_irqrestore(&zone->lock, flags);
>  
>  	/*
> @@ -824,7 +838,7 @@ int __ref online_pages(unsigned long pfn, unsigned long nr_pages,
>  		setup_zone_pageset(zone);
>  	}
>  
> -	online_pages_range(pfn, nr_pages);
> +	online_pages_range(pfn, nr_pages, buddy_start_pfn);
>  	zone->present_pages += nr_pages;
>  
>  	pgdat_resize_lock(zone->zone_pgdat, &flags);
> @@ -837,7 +851,9 @@ int __ref online_pages(unsigned long pfn, unsigned long nr_pages,
>  	zone_pcp_update(zone);
>  
>  	/* Basic onlining is complete, allow allocation of onlined pages. */
> -	undo_isolate_page_range(pfn, pfn + nr_pages, MIGRATE_MOVABLE);
> +	undo_isolate_page_range(buddy_start_pfn,
> +				buddy_start_pfn + buddy_nr_pages,
> +				MIGRATE_MOVABLE);
>  
>  	/*
>  	 * Freshly onlined pages aren't shuffled (e.g., all pages are placed to
> @@ -1021,6 +1037,7 @@ static int online_memory_block(struct memory_block *mem, void *arg)
>  int __ref add_memory_resource(int nid, struct resource *res, mhp_t mhp_flags)
>  {
>  	struct mhp_params params = { .pgprot = PAGE_KERNEL };
> +	struct vmem_altmap mhp_altmap = {};
>  	u64 start, size;
>  	bool new_node = false;
>  	int ret;
> @@ -1047,13 +1064,22 @@ int __ref add_memory_resource(int nid, struct resource *res, mhp_t mhp_flags)
>  		goto error;
>  	new_node = ret;
>  
> +	/*
> +	 * Self hosted memmap array
> +	 */
> +	if (mhp_flags & MHP_MEMMAP_ON_MEMORY) {
> +		mhp_altmap.free = size >> PAGE_SHIFT;
> +		mhp_altmap.base_pfn = start >> PAGE_SHIFT;
> +		params.altmap = &mhp_altmap;
> +	}
> +
>  	/* call arch's memory hotadd */
>  	ret = arch_add_memory(nid, start, size, &params);
>  	if (ret < 0)
>  		goto error;
>  
>  	/* create memory block devices after memory was added */
> -	ret = create_memory_block_devices(start, size);
> +	ret = create_memory_block_devices(start, size, mhp_altmap.alloc);
>  	if (ret) {
>  		arch_remove_memory(nid, start, size, NULL);
>  		goto error;
> @@ -1449,10 +1475,11 @@ static int count_system_ram_pages_cb(unsigned long start_pfn,
>  	return 0;
>  }
>  
> -int __ref offline_pages(unsigned long start_pfn, unsigned long nr_pages)
> +int __ref offline_pages(unsigned long start_pfn, unsigned long nr_pages,
> +			unsigned long nr_vmemmap_pages)
>  {
>  	const unsigned long end_pfn = start_pfn + nr_pages;
> -	unsigned long pfn, system_ram_pages = 0;
> +	unsigned long pfn, buddy_start_pfn, buddy_nr_pages, system_ram_pages = 0;
>  	unsigned long flags;
>  	struct zone *zone;
>  	struct memory_notify arg;
> @@ -1464,6 +1491,9 @@ int __ref offline_pages(unsigned long start_pfn, unsigned long nr_pages)
>  			 !IS_ALIGNED(start_pfn | nr_pages, PAGES_PER_SECTION)))
>  		return -EINVAL;
>  
> +	buddy_start_pfn = start_pfn + nr_vmemmap_pages;
> +	buddy_nr_pages = nr_pages - nr_vmemmap_pages;
> +
>  	mem_hotplug_begin();
>  
>  	/*
> @@ -1493,8 +1523,7 @@ int __ref offline_pages(unsigned long start_pfn, unsigned long nr_pages)
>  	node = zone_to_nid(zone);
>  
>  	/* set above range as isolated */
> -	ret = start_isolate_page_range(start_pfn, end_pfn,
> -				       MIGRATE_MOVABLE,
> +	ret = start_isolate_page_range(buddy_start_pfn, end_pfn, MIGRATE_MOVABLE,
>  				       MEMORY_OFFLINE | REPORT_FAILURE);
>  	if (ret) {
>  		reason = "failure to isolate range";
> @@ -1513,7 +1542,7 @@ int __ref offline_pages(unsigned long start_pfn, unsigned long nr_pages)
>  	}
>  
>  	do {
> -		pfn = start_pfn;
> +		pfn = buddy_start_pfn;
>  		do {
>  			if (signal_pending(current)) {
>  				ret = -EINTR;
> @@ -1544,7 +1573,7 @@ int __ref offline_pages(unsigned long start_pfn, unsigned long nr_pages)
>  		 * offlining actually in order to make hugetlbfs's object
>  		 * counting consistent.
>  		 */
> -		ret = dissolve_free_huge_pages(start_pfn, end_pfn);
> +		ret = dissolve_free_huge_pages(buddy_start_pfn, end_pfn);
>  		if (ret) {
>  			reason = "failure to dissolve huge pages";
>  			goto failed_removal_isolated;
> @@ -1562,13 +1591,13 @@ int __ref offline_pages(unsigned long start_pfn, unsigned long nr_pages)
>  		 * because has_unmovable_pages explicitly checks for
>  		 * PageBuddy on freed pages on other zones.
>  		 */
> -		ret = test_pages_isolated(start_pfn, end_pfn, MEMORY_OFFLINE);
> +		ret = test_pages_isolated(buddy_start_pfn, end_pfn, MEMORY_OFFLINE);
>  		if (ret)
>  			drain_all_pages(zone);
>  	} while (ret);
>  
>  	/* Mark all sections offline and remove free pages from the buddy. */
> -	__offline_isolated_pages(start_pfn, end_pfn);
> +	__offline_isolated_pages(start_pfn, end_pfn, buddy_start_pfn);
>  	pr_info("Offlined Pages %ld\n", nr_pages);
>  
>  	/*
> @@ -1577,11 +1606,11 @@ int __ref offline_pages(unsigned long start_pfn, unsigned long nr_pages)
>  	 * of isolated pageblocks, memory onlining will properly revert this.
>  	 */
>  	spin_lock_irqsave(&zone->lock, flags);
> -	zone->nr_isolate_pageblock -= nr_pages / pageblock_nr_pages;
> +	zone->nr_isolate_pageblock -= buddy_nr_pages / pageblock_nr_pages;
>  	spin_unlock_irqrestore(&zone->lock, flags);
>  
>  	/* removal success */
> -	adjust_managed_page_count(pfn_to_page(start_pfn), -nr_pages);
> +	adjust_managed_page_count(pfn_to_page(start_pfn), -buddy_nr_pages);
>  	zone->present_pages -= nr_pages;
>  
>  	pgdat_resize_lock(zone->zone_pgdat, &flags);
> @@ -1639,6 +1668,16 @@ static int check_memblock_offlined_cb(struct memory_block *mem, void *arg)
>  	return 0;
>  }
>  
> +static int get_memblock_vmemmap_pages_cb(struct memory_block *mem, void *arg)
> +{
> +	unsigned long *nr_vmemmap_pages = (unsigned long *)arg;
> +	int ret = !mem->nr_vmemmap_pages;
> +
> +	if (!ret)
> +		*nr_vmemmap_pages += mem->nr_vmemmap_pages;
> +	return ret;
> +}
> +
>  static int check_cpu_on_node(pg_data_t *pgdat)
>  {
>  	int cpu;
> @@ -1713,6 +1752,9 @@ EXPORT_SYMBOL(try_offline_node);
>  static int __ref try_remove_memory(int nid, u64 start, u64 size)
>  {
>  	int rc = 0;
> +	struct vmem_altmap mhp_altmap = {};
> +	struct vmem_altmap *altmap = NULL;
> +	unsigned long nr_vmemmap_pages = 0;
>  
>  	BUG_ON(check_hotplug_memory_range(start, size));
>  
> @@ -1725,6 +1767,17 @@ static int __ref try_remove_memory(int nid, u64 start, u64 size)
>  	if (rc)
>  		return rc;
>  
> +	/*
> +	 * Prepare a vmem_altmap struct if we used it at hot-add, so
> +	 * remove_pmd_table->free_hugepage_table does the right thing.
> +	 */
> +	(void)walk_memory_blocks(start, size, &nr_vmemmap_pages,
> +	     get_memblock_vmemmap_pages_cb);
> +	if (nr_vmemmap_pages) {
> +		mhp_altmap.alloc = nr_vmemmap_pages;
> +		altmap = &mhp_altmap;
> +	}
> +
>  	/* remove memmap entry */
>  	firmware_map_remove(start, start + size, "System RAM");
>  
> @@ -1736,7 +1789,7 @@ static int __ref try_remove_memory(int nid, u64 start, u64 size)
>  
>  	mem_hotplug_begin();
>  
> -	arch_remove_memory(nid, start, size, NULL);
> +	arch_remove_memory(nid, start, size, altmap);
>  
>  	if (IS_ENABLED(CONFIG_ARCH_KEEP_MEMBLOCK)) {
>  		memblock_free(start, size);
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index eaa227a479e4..aac60d02e04b 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -8753,7 +8753,8 @@ void zone_pcp_reset(struct zone *zone)
>   * All pages in the range must be in a single zone, must not contain holes,
>   * must span full sections, and must be isolated before calling this function.
>   */
> -void __offline_isolated_pages(unsigned long start_pfn, unsigned long end_pfn)
> +void __offline_isolated_pages(unsigned long start_pfn, unsigned long end_pfn,
> +			      unsigned long buddy_start_pfn)
>  {
>  	unsigned long pfn = start_pfn;
>  	struct page *page;
> @@ -8764,6 +8765,7 @@ void __offline_isolated_pages(unsigned long start_pfn, unsigned long end_pfn)
>  	offline_mem_sections(pfn, end_pfn);
>  	zone = page_zone(pfn_to_page(pfn));
>  	spin_lock_irqsave(&zone->lock, flags);
> +	pfn = buddy_start_pfn;
>  	while (pfn < end_pfn) {
>  		page = pfn_to_page(pfn);
>  		/*
> -- 
> 2.26.2

-- 
Michal Hocko
SUSE Labs
