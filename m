Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E868A2FC51B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 00:51:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730508AbhASXuR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 18:50:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:56397 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730607AbhASOAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 09:00:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611064729;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=upN0l1v8TV9hP8WKy0q3Q/XZl5FE88Afz3yauIRsUkU=;
        b=ey7VrEV0YENhjnrfHXobFuseh5SpJhyrZrR4dH4F7qey5gyKA7FTNpU3ND6lRxZxtJNZrx
        uZ/WUb/Fvv8aCwD1XprRI5djEMMCOwRwyLRnf/+2aN6C7N0+fAdZ9ymuio+g2jmtEdm7JK
        DZpdhivabVIJliACfhgCy0KVijF/P2Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-146-hTJ_wrUFNRyR3Ki4AhXT7Q-1; Tue, 19 Jan 2021 08:58:45 -0500
X-MC-Unique: hTJ_wrUFNRyR3Ki4AhXT7Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E02A79CC09;
        Tue, 19 Jan 2021 13:58:43 +0000 (UTC)
Received: from [10.36.114.143] (ovpn-114-143.ams2.redhat.com [10.36.114.143])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1A9D510023B2;
        Tue, 19 Jan 2021 13:58:41 +0000 (UTC)
Subject: Re: [PATCH 2/5] mm,memory_hotplug: Allocate memmap from the added
 memory range
To:     Oscar Salvador <osalvador@suse.de>, akpm@linux-foundation.org
Cc:     mhocko@kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, vbabka@suse.cz, pasha.tatashin@soleen.com
References: <20201217130758.11565-1-osalvador@suse.de>
 <20201217130758.11565-3-osalvador@suse.de>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <21079c2d-67d0-fc59-8d7f-0795b3f8a3e3@redhat.com>
Date:   Tue, 19 Jan 2021 14:58:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201217130758.11565-3-osalvador@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17.12.20 14:07, Oscar Salvador wrote:
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
> struct pages which back the allocated space then just need to be treated
> carefully.
> 
> Implementation wise we will reuse vmem_altmap infrastructure to override
> the default allocator used by __populate_section_memmap.
> Part of the implementation also relies on memory_block structure gaining
> a new field which specifies the number of vmemmap_pages at the beginning.
> This comes in handy as in {online,offline}_pages, all the isolation and
> migration is being done on (buddy_start_pfn, end_pfn] range,
> being buddy_start_pfn = start_pfn + nr_vmemmap_pages.
> 
> In this way, we have:
> 
> (start_pfn, buddy_start_pfn - 1] = Initialized and PageReserved
> (buddy_start_pfn, end_pfn]       = Initialized and sent to buddy
> 
> Hot-remove:
> 
>  We need to be careful when removing memory, as adding and
>  removing memory needs to be done with the same granularity.
>  To check that this assumption is not violated, we check the
>  memory range we want to remove and if a) any memory block has
>  vmemmap pages and b) the range spans more than a single memory
>  block, we scream out loud and refuse to proceed.
> 
>  If all is good and the range was using memmap on memory (aka vmemmap pages),
>  we construct an altmap structure so free_hugepage_table does the right
>  thing and calls vmem_altmap_free instead of free_pagetable.
> 
> Signed-off-by: Oscar Salvador <osalvador@suse.de>

IIRC, there is a conflict with the hpage vmemmap freeing patch set,
right? How are we going to handle that?

[...]

> diff --git a/include/linux/memory.h b/include/linux/memory.h
> index 439a89e758d8..f09d60ef8ad9 100644
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

I suggest moving this comment above nr_vmemmap_pages.

>  };
>  
>  int arch_get_memory_phys_device(unsigned long start_pfn);
> @@ -81,7 +86,8 @@ static inline int memory_notify(unsigned long val, void *v)
>  #else
>  extern int register_memory_notifier(struct notifier_block *nb);
>  extern void unregister_memory_notifier(struct notifier_block *nb);
> -int create_memory_block_devices(unsigned long start, unsigned long size);
> +int create_memory_block_devices(unsigned long start, unsigned long size,
> +				unsigned long vmemmap_pages);
>  void remove_memory_block_devices(unsigned long start, unsigned long size);
>  extern void memory_dev_init(void);
>  extern int memory_notify(unsigned long val, void *v);
> diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
> index 15acce5ab106..67ea4a0b25bd 100644
> --- a/include/linux/memory_hotplug.h
> +++ b/include/linux/memory_hotplug.h
> @@ -70,6 +70,14 @@ typedef int __bitwise mhp_t;
>   */
>  #define MEMHP_MERGE_RESOURCE	((__force mhp_t)BIT(0))
>  
> +/*
> + * We want memmap (struct page array) to be self contained.
> + * To do so, we will use the beginning of the hot-added range to build
> + * the page tables for the memmap array that describes the entire range.
> + * Only selected architectures support it with SPARSE_VMEMMAP.
> + */
> +#define MHP_MEMMAP_ON_MEMORY   ((__force mhp_t)BIT(1))
> +
>  /*
>   * Extended parameters for memory hotplug:
>   * altmap: alternative allocator for memmap array (optional)
> @@ -113,11 +121,13 @@ extern int zone_grow_waitqueues(struct zone *zone, unsigned long nr_pages);
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
> @@ -312,7 +322,8 @@ static inline void pgdat_resize_init(struct pglist_data *pgdat) {}
>  #ifdef CONFIG_MEMORY_HOTREMOVE
>  
>  extern void try_offline_node(int nid);
> -extern int offline_pages(unsigned long start_pfn, unsigned long nr_pages);
> +extern int offline_pages(unsigned long start_pfn, unsigned long nr_pages,
> +			 unsigned long nr_vmemmap_pages);
>  extern int remove_memory(int nid, u64 start, u64 size);
>  extern void __remove_memory(int nid, u64 start, u64 size);
>  extern int offline_and_remove_memory(int nid, u64 start, u64 size);
> @@ -320,7 +331,8 @@ extern int offline_and_remove_memory(int nid, u64 start, u64 size);
>  #else
>  static inline void try_offline_node(int nid) {}
>  
> -static inline int offline_pages(unsigned long start_pfn, unsigned long nr_pages)
> +static inline int offline_pages(unsigned long start_pfn, unsigned long nr_pages,
> +				unsigned long nr_vmemmap_pages)
>  {
>  	return -EINVAL;
>  }
> @@ -364,6 +376,7 @@ extern struct zone *zone_for_pfn_range(int online_type, int nid, unsigned start_
>  extern int arch_create_linear_mapping(int nid, u64 start, u64 size,
>  				      struct mhp_params *params);
>  void arch_remove_linear_mapping(u64 start, u64 size);
> +extern bool mhp_supports_memmap_on_memory(unsigned long size);
>  #endif /* CONFIG_MEMORY_HOTPLUG */
>  
>  #endif /* __LINUX_MEMORY_HOTPLUG_H */
> diff --git a/include/linux/memremap.h b/include/linux/memremap.h
> index 86c6c368ce9b..3de5d482ac1a 100644
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
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index b593316bff3d..d16b4411e422 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -407,6 +407,11 @@ enum zone_type {
>  	 *    techniques might use alloc_contig_range() to hide previously
>  	 *    exposed pages from the buddy again (e.g., to implement some sort
>  	 *    of memory unplug in virtio-mem).
> +	 * 6. Memory-hotplug: when using memmap_on_memory and onlining the memory
> +	 *    to the MOVABLE zone, the vmemmap pages are also placed in such
> +	 *    zone. Such pages cannot be really moved around as they are
> +	 *    self-stored in the range, but they are treated as movable when
> +	 *    the range that they describe is about to be offlined.
>  	 *
>  	 * In general, no unmovable allocations that degrade memory offlining
>  	 * should end up in ZONE_MOVABLE. Allocators (like alloc_contig_range())
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index a8cef4955907..9371e7d3f583 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -42,6 +42,8 @@
>  #include "internal.h"
>  #include "shuffle.h"
>  
> +static bool memmap_on_memory_enabled;
> +
>  /*
>   * online_page_callback contains pointer to current page onlining function.
>   * Initially it is generic_online_page(). If it is required it could be
> @@ -606,10 +608,23 @@ void generic_online_page(struct page *page, unsigned int order)
>  }
>  EXPORT_SYMBOL_GPL(generic_online_page);
>  
> -static void online_pages_range(unsigned long start_pfn, unsigned long nr_pages)
> +static void online_pages_range(unsigned long start_pfn, unsigned long nr_pages,
> +			       unsigned long buddy_start_pfn)
>  {
>  	const unsigned long end_pfn = start_pfn + nr_pages;
> -	unsigned long pfn;
> +	unsigned long pfn = buddy_start_pfn;
> +	unsigned int order = MAX_ORDER - 1;
> +
> +	/*
> +	 * When using memmap_on_memory, the range might be unaligned as the
> +	 * first pfns are used for vmemmap pages. Align it in case we need to.
> +	 */
> +	if (pfn & ((1 << order) - 1)) {
> +		while (pfn & ((1 << order) - 1))
> +			order--;
> +		(*online_page_callback)(pfn_to_page(pfn), order);
> +		pfn += 1 << order;
> +	}
>  

Most probably we can simplify once we assure buddy_start_pfn follows
specific requirements (e.g., at least aligned to pageblock_nr_pages, see
below).

>  	/*
>  	 * Online the pages in MAX_ORDER - 1 aligned chunks. The callback might
> @@ -617,7 +632,7 @@ static void online_pages_range(unsigned long start_pfn, unsigned long nr_pages)
>  	 * later). We account all pages as being online and belonging to this
>  	 * zone ("present").
>  	 */
> -	for (pfn = start_pfn; pfn < end_pfn; pfn += MAX_ORDER_NR_PAGES)
> +	for (; pfn < end_pfn; pfn += MAX_ORDER_NR_PAGES)
>  		(*online_page_callback)(pfn_to_page(pfn), MAX_ORDER - 1);
>  
>  	/* mark all involved sections as online */
> @@ -777,9 +792,9 @@ struct zone * zone_for_pfn_range(int online_type, int nid, unsigned start_pfn,
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
> @@ -790,11 +805,18 @@ int __ref online_pages(unsigned long pfn, unsigned long nr_pages,
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

One sign that we have to take care that nr_vmemmap_pages has a certain
minimum alignment.

> +	move_pfn_range_to_zone(zone, buddy_start_pfn, buddy_nr_pages, NULL,
> +			       MIGRATE_ISOLATE);
>  
>  	arg.start_pfn = pfn;
>  	arg.nr_pages = nr_pages;
> @@ -810,7 +832,7 @@ int __ref online_pages(unsigned long pfn, unsigned long nr_pages,
>  	 * onlining, such that undo_isolate_page_range() works correctly.
>  	 */
>  	spin_lock_irqsave(&zone->lock, flags);
> -	zone->nr_isolate_pageblock += nr_pages / pageblock_nr_pages;
> +	zone->nr_isolate_pageblock += buddy_nr_pages / pageblock_nr_pages;

And, another sign :)

>  	spin_unlock_irqrestore(&zone->lock, flags);
>  
>  	/*
> @@ -823,7 +845,7 @@ int __ref online_pages(unsigned long pfn, unsigned long nr_pages,
>  		setup_zone_pageset(zone);
>  	}
>  
> -	online_pages_range(pfn, nr_pages);
> +	online_pages_range(pfn, nr_pages, buddy_start_pfn);
>  	zone->present_pages += nr_pages;
>  
>  	pgdat_resize_lock(zone->zone_pgdat, &flags);
> @@ -836,7 +858,9 @@ int __ref online_pages(unsigned long pfn, unsigned long nr_pages,
>  	zone_pcp_update(zone);
>  
>  	/* Basic onlining is complete, allow allocation of onlined pages. */
> -	undo_isolate_page_range(pfn, pfn + nr_pages, MIGRATE_MOVABLE);
> +	undo_isolate_page_range(buddy_start_pfn,
> +				buddy_start_pfn + buddy_nr_pages,
> +				MIGRATE_MOVABLE);

Yet another sign :)

>  
>  	/*
>  	 * Freshly onlined pages aren't shuffled (e.g., all pages are placed to
> @@ -1011,6 +1035,12 @@ static int online_memory_block(struct memory_block *mem, void *arg)
>  	return device_online(&mem->dev);
>  }
>  
> +bool mhp_supports_memmap_on_memory(unsigned long size)
> +{
> +	return memmap_on_memory_enabled &&
> +	       size == memory_block_size_bytes();
> +}
> +
>  /*
>   * NOTE: The caller must call lock_device_hotplug() to serialize hotplug
>   * and online/offline operations (triggered e.g. by sysfs).
> @@ -1020,6 +1050,7 @@ static int online_memory_block(struct memory_block *mem, void *arg)
>  int __ref add_memory_resource(int nid, struct resource *res, mhp_t mhp_flags)
>  {
>  	struct mhp_params params = { .pgprot = PAGE_KERNEL };
> +	struct vmem_altmap mhp_altmap = {};
>  	u64 start, size;
>  	bool new_node = false;
>  	int ret;
> @@ -1046,13 +1077,32 @@ int __ref add_memory_resource(int nid, struct resource *res, mhp_t mhp_flags)
>  		goto error;
>  	new_node = ret;
>  
> +	/*
> +	 * Return -EINVAL if the caller specified MHP_MEMMAP_ON_MEMORY and we do
> +	 * not support it.
> +	 */

The "Return -EINVAL" part is obvious. Maybe drop that comment.

> +	if ((mhp_flags & MHP_MEMMAP_ON_MEMORY) &&
> +	    !mhp_supports_memmap_on_memory(size)) {
> +		ret = -EINVAL;
> +		goto error;
> +	}
> +
> +	/*
> +	 * Self hosted memmap array
> +	 */
> +	if (mhp_flags & MHP_MEMMAP_ON_MEMORY) {
> +		mhp_altmap.free = size >> PAGE_SHIFT;
> +		mhp_altmap.base_pfn = start >> PAGE_SHIFT;

Could use PFN_PHYS() for both.

> +		params.altmap = &mhp_altmap;
> +	}
> +

I'd combine both parts

if (mhp_flags & MHP_MEMMAP_ON_MEMORY) {
	if (!mhp_supports_memmap_on_memory(size)) {
		ret = -EINVAL;
		goto error;
	}
	mhp_altmap.free = PFN_PHYS(size);
	mhp_altmap.base_pfn = PFN_PHYS(size);
	params.altmap = &mhp_altmap;

}

>  	/* call arch's memory hotadd */
>  	ret = arch_add_memory(nid, start, size, &params);
>  	if (ret < 0)
>  		goto error;
>  
>  	/* create memory block devices after memory was added */
> -	ret = create_memory_block_devices(start, size);
> +	ret = create_memory_block_devices(start, size, mhp_altmap.alloc);

Interresting, so we automatically support differeing sizeof(struct
page). I guess it will be problematic in case of sizeof(struct page) !=
64, because then, we might not have multiples of 2MB for the memmap of a
memory block.

IIRC, it could happen that if we add two consecutive memory blocks, that
the second one might reuse parts of the vmemmap residing on the first
memory block. If you remove the first one, you might be in trouble.

E.g., on x86-64
 vmemmap_populate()->vmemmap_populate_hugepages()->vmemmap_alloc_block_buf():
- Populate a huge page

vmemmap_free()->remove_pagetable()...->remove_pmd_table():
- memchr_inv() will leave the hugepage populated.

Do we want to fence that off, maybe in mhp_supports_memmap_on_memory()?
Or do we somehow want to fix that? We should never populate partial huge
pages from an altmap ...

But maybe I am missing something.

>  	if (ret) {
>  		arch_remove_memory(nid, start, size, NULL);
>  		goto error;
> @@ -1448,10 +1498,11 @@ static int count_system_ram_pages_cb(unsigned long start_pfn,
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
> @@ -1463,6 +1514,9 @@ int __ref offline_pages(unsigned long start_pfn, unsigned long nr_pages)
>  			 !IS_ALIGNED(start_pfn | nr_pages, PAGES_PER_SECTION)))
>  		return -EINVAL;
>  
> +	buddy_start_pfn = start_pfn + nr_vmemmap_pages;
> +	buddy_nr_pages = nr_pages - nr_vmemmap_pages;
> +
>  	mem_hotplug_begin();
>  
>  	/*
> @@ -1498,7 +1552,7 @@ int __ref offline_pages(unsigned long start_pfn, unsigned long nr_pages)
>  	zone_pcp_disable(zone);
>  
>  	/* set above range as isolated */
> -	ret = start_isolate_page_range(start_pfn, end_pfn,
> +	ret = start_isolate_page_range(buddy_start_pfn, end_pfn,
>  				       MIGRATE_MOVABLE,
>  				       MEMORY_OFFLINE | REPORT_FAILURE);

If buddy_start_pfn is not aligned to pageblocks,
start_isolate_page_range will BUG_ON(). another sign that we need to
check that somewhere while adding that nr_vmemmap_pages is suitable.


[...]

>  
> +static int get_memblock_vmemmap_pages_cb(struct memory_block *mem, void *arg)

Let's avoid using the "memblock" terminology. Just call it
"get_nr_vmemmap_pages_cb" or maybe "detect_memmap_on_memory_cb"

> +{
> +	unsigned long *nr_vmemmap_pages = (unsigned long *)arg;
> +	int ret = !mem->nr_vmemmap_pages;
> +
> +	if (!ret)
> +		*nr_vmemmap_pages += mem->nr_vmemmap_pages;
> +	return ret;

I think you can avoid "ret".

Also, we want to stop whenever we find "mem->nr_vmemmap_pages != 0",
right? AFAIU, you would currently stop whenever you find
mem->nr_vmemmap_pages == 0", which is wrong.

*nr_vmemmap_pages += mem->nr_vmemmap_pages;
/* Stop whenever we find any sign of MHP_MEMMAP_ON_MEMORY. */
return mem->nr_vmemmap_pages;

> +}
> +
>  static int check_cpu_on_node(pg_data_t *pgdat)
>  {
>  	int cpu;
> @@ -1709,6 +1773,9 @@ EXPORT_SYMBOL(try_offline_node);
>  static int __ref try_remove_memory(int nid, u64 start, u64 size)
>  {
>  	int rc = 0;
> +	struct vmem_altmap mhp_altmap = {};
> +	struct vmem_altmap *altmap = NULL;
> +	unsigned long nr_vmemmap_pages = 0;
>  
>  	BUG_ON(check_hotplug_memory_range(start, size));
>  
> @@ -1721,6 +1788,37 @@ static int __ref try_remove_memory(int nid, u64 start, u64 size)
>  	if (rc)
>  		return rc;
>  
> +	/*
> +	 * When using MHP_MEMMAP_ON_MEMORY, add_memory and remove_memory needs
> +	 * to work with the same granularity.
> +	 * Check that we are not violating that assumption.
> +	 * The only way we have right now is to walk all the memory
> +	 * blocks we are trying to remove and see if any has vmemmap pages.
> +	 * We should not have any as memmap_on_memory only works with ranges
> +	 * that spans a single memory block, so if we found any and size spans
> +	 * more than a memory block, we know we have to scream.
> +	 * We only need to check this if memmap_on_memory_enabled=true.
> +	 */

Can we simplify that comment?

/*
 * We only support remvoing memory added with MHP_MEMMAP_ON_MEMORY in
 * the same granularity it was added - a single memory block.
 */

> +	if (memmap_on_memory_enabled) {
> +		(void)walk_memory_blocks(start, size, &nr_vmemmap_pages,
> +					 get_memblock_vmemmap_pages_cb);

you can drop the "(void)", just like other users that ignore the return
value.

> +		if (nr_vmemmap_pages) {
> +			if (size != memory_block_size_bytes()) {
> +				pr_warn("Refuse to remove %#llx - %#llx, wrong granularity\n"
> +					 start, start + size);
> +				return -EINVAL;
> +			}
> +
> +			/*
> +			 * Let remove_pmd_table->free_hugepage_table
> +			 * do the right thing if we used vmem_altmap
> +			 * when hot-adding the range.
> +			 */
> +			mhp_altmap.alloc = nr_vmemmap_pages;
> +			altmap = &mhp_altmap;
> +		}
> +	}
> +



-- 
Thanks,

David / dhildenb

