Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 064F12B68DB
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 16:41:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726248AbgKQPjC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 10:39:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:46271 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725790AbgKQPjB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 10:39:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605627539;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sH79sBvWQLdxUsZcWapOd7F7PQ0P3+hye/9vwSnwrO4=;
        b=SRF1j+DQhfFCmrn0G70WyUYj+uZuWzL2rn28raaVblmpfyCM9hqpXY0MPzwOZEK7CRyizX
        8JjbJV7iWs+lBi7ENyqlFzqTOD1IE0heaNoXq40Sr0vxFGloLFc0dCSw6sFP/JGvke516U
        Xcm66DfOGZjSaXdXve7zt3lWuZ8s7ZQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-186-6RamNdHsPziCDEtISKlNUA-1; Tue, 17 Nov 2020 10:38:56 -0500
X-MC-Unique: 6RamNdHsPziCDEtISKlNUA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 981E2106BC28;
        Tue, 17 Nov 2020 15:38:55 +0000 (UTC)
Received: from [10.36.114.99] (ovpn-114-99.ams2.redhat.com [10.36.114.99])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A0A5260C04;
        Tue, 17 Nov 2020 15:38:53 +0000 (UTC)
Subject: Re: [RFC PATCH 3/3] mm,memory_hotplug: Allocate memmap from the added
 memory range
To:     Oscar Salvador <osalvador@suse.de>
Cc:     mhocko@kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, vbabka@suse.cz, pasha.tatashin@soleen.com
References: <20201022125835.26396-1-osalvador@suse.de>
 <20201022125835.26396-4-osalvador@suse.de>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <3cc37927-538e-ae7d-27bc-45aaabe06b3a@redhat.com>
Date:   Tue, 17 Nov 2020 16:38:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20201022125835.26396-4-osalvador@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.10.20 14:58, Oscar Salvador wrote:
> Physical memory hotadd has to allocate a memmap (struct page array) for
> the newly added memory section. Currently, alloc_pages_node() is used
> for those allocations.
> 
> This has some disadvantages:
>   a) an existing memory is consumed for that purpose
>      (eg: ~2MB per 128MB memory section on x86_64)
>   b) if the whole node is movable then we have off-node struct pages
>      which has performance drawbacks.
>   c) It might be there are no PMD_ALIGNED chunks so memmap array gets
>      populated with base pages.
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
> the default allocator used by __populate_section_memmap. Once the memmap is
> allocated, we are going to need a way to mark altmap pfns used for the allocation.
> If MHP_MEMMAP_ON_MEMORY flag was passed, we will set up the layout of the
> altmap structure in add_memory_resouce(), and then we will call
> mhp_mark_vmemmap_pages() to properly mark those pages.
> 
> Online/Offline:
> 
>   In the memory_block structure, a new field is created in order to
>   store the number of vmemmap_pages.
>   Having that around simplifies things a lot since in {online/offline}_pages
>   we can know how much we have to skip forward until we have the first non-
>   vmemmap page, for operations like isolation/migration/initialization.
> 
> Hot-remove:
> 
>   If the range was using memmap on memory (aka vmemmap pages),
>   we construct an altmap structure so free_hugepage_table does
>   the right thing and calls vmem_altmap_free instead of
>   free_pagetable.
> 

Sorry for the late replay, fairly busy with all kinds of things.

[...]

> diff --git a/drivers/acpi/acpi_memhotplug.c b/drivers/acpi/acpi_memhotplug.c
> index b02fd51e5589..6b57bf90ca72 100644
> --- a/drivers/acpi/acpi_memhotplug.c
> +++ b/drivers/acpi/acpi_memhotplug.c
> @@ -195,7 +195,7 @@ static int acpi_memory_enable_device(struct acpi_memory_device *mem_device)
>   			node = memory_add_physaddr_to_nid(info->start_addr);
>   
>   		result = __add_memory(node, info->start_addr, info->length,
> -				      MHP_NONE);
> +				      MEMHP_MEMMAP_ON_MEMORY);

I'd suggest moving that into a separate patch.

[...]

> diff --git a/include/linux/memory.h b/include/linux/memory.h
> index 439a89e758d8..7cc93de5856c 100644
> --- a/include/linux/memory.h
> +++ b/include/linux/memory.h
> @@ -30,6 +30,7 @@ struct memory_block {
>   	int phys_device;		/* to which fru does this belong? */
>   	struct device dev;
>   	int nid;			/* NID for this memory block */
> +	unsigned long nr_vmemmap_pages;	/* Number for vmemmap pages */

Maybe also document that these pages are directly at the beginning of 
the memory block.


>   
> -static inline int offline_pages(unsigned long start_pfn, unsigned long nr_pages)
> +static inline int offline_pages(unsigned long start_pfn, unsigned long nr_pages,
> +				unsigned long nr_vmemmap_pages)
>   {
>   	return -EINVAL;
>   }
> @@ -369,10 +372,12 @@ extern int add_memory_driver_managed(int nid, u64 start, u64 size,
>   				     mhp_t mhp_flags);
>   extern void move_pfn_range_to_zone(struct zone *zone, unsigned long start_pfn,
>   				   unsigned long nr_pages,
> +				   unsigned long nr_vmemmap_pages,
>   				   struct vmem_altmap *altmap, int migratetype);
>   extern void remove_pfn_range_from_zone(struct zone *zone,
>   				       unsigned long start_pfn,
> -				       unsigned long nr_pages);
> +				       unsigned long nr_pages,
> +				       unsigned long nr_vmemmap_pages);

I think we should not pass nr_vmemmap_pages down here but instead do two 
separate calls to move_pfn_range_to_zone()/remove_pfn_range_from_zone() 
from online_pages()/offline_pages()

1. for vmemmap pages, migratetype = MIGRATE_UNMOVABLE
2. for remaining pages, migratetype = MIGRATE_ISOLATE

[...]

>   
>   		/* Select all remaining pages up to the next section boundary */
> @@ -629,6 +630,7 @@ static void online_pages_range(unsigned long start_pfn, unsigned long nr_pages)
>   {
>   	const unsigned long end_pfn = start_pfn + nr_pages;
>   	unsigned long pfn;
> +	unsigned int order;
>   
>   	/*
>   	 * Online the pages in MAX_ORDER - 1 aligned chunks. The callback might
> @@ -636,8 +638,12 @@ static void online_pages_range(unsigned long start_pfn, unsigned long nr_pages)
>   	 * later). We account all pages as being online and belonging to this
>   	 * zone ("present").
>   	 */
> -	for (pfn = start_pfn; pfn < end_pfn; pfn += MAX_ORDER_NR_PAGES)
> -		(*online_page_callback)(pfn_to_page(pfn), MAX_ORDER - 1);
> +	for (pfn = start_pfn; pfn < end_pfn; pfn += (1 << order)) {
> +		order = MAX_ORDER - 1;
> +		while (pfn & ((1 << order) - 1))
> +			order--;
> +		(*online_page_callback)(pfn_to_page(pfn), order);
> +	}
>   
>   	/* mark all involved sections as online */
>   	online_mem_sections(start_pfn, end_pfn);
> @@ -697,6 +703,18 @@ static void __meminit resize_pgdat_range(struct pglist_data *pgdat, unsigned lon
>   	pgdat->node_spanned_pages = max(start_pfn + nr_pages, old_end_pfn) - pgdat->node_start_pfn;
>   
>   }
> +
> +static void link_vmemmap_pages(unsigned long pfn, unsigned long nr_pages,
> +			       struct zone *zone, int nid)
> +{
> +	struct page *p = pfn_to_page(pfn);
> +	enum zone_type z = zone_idx(zone);
> +	unsigned long i;
> +
> +	for (i = 0; i < nr_pages; i++)
> +		set_page_links(p + i, z, nid, pfn);
> +}
> +
>   /*
>    * Associate the pfn range with the given zone, initializing the memmaps
>    * and resizing the pgdat/zone data to span the added pages. After this
> @@ -708,6 +726,7 @@ static void __meminit resize_pgdat_range(struct pglist_data *pgdat, unsigned lon
>    */
>   void __ref move_pfn_range_to_zone(struct zone *zone, unsigned long start_pfn,
>   				  unsigned long nr_pages,
> +				  unsigned long nr_vmemmap_pages,
>   				  struct vmem_altmap *altmap, int migratetype)
>   {
>   	struct pglist_data *pgdat = zone->zone_pgdat;
> @@ -726,14 +745,22 @@ void __ref move_pfn_range_to_zone(struct zone *zone, unsigned long start_pfn,
>   	resize_pgdat_range(pgdat, start_pfn, nr_pages);
>   	pgdat_resize_unlock(pgdat, &flags);
>   
> +	if (nr_vmemmap_pages)
> +		/*
> +		 * Vmemmap pages are already initialized at hot-add state.
> +		 * What is left is to link them to a node and a zone.
> +		 */
> +		link_vmemmap_pages(start_pfn, nr_vmemmap_pages, zone, nid);
> +
>   	/*
>   	 * TODO now we have a visible range of pages which are not associated
>   	 * with their zone properly. Not nice but set_pfnblock_flags_mask
>   	 * expects the zone spans the pfn range. All the pages in the range
>   	 * are reserved so nobody should be touching them so we should be safe
>   	 */
> -	memmap_init_zone(nr_pages, nid, zone_idx(zone), start_pfn,
> -			 MEMINIT_HOTPLUG, altmap, migratetype);
> +	memmap_init_zone(nr_pages - nr_vmemmap_pages, nid, zone_idx(zone),
> +			 start_pfn + nr_vmemmap_pages, MEMINIT_HOTPLUG, altmap,
> +			 migratetype);
>   
>   	set_zone_contiguous(zone);
>   }
> @@ -796,9 +823,9 @@ struct zone * zone_for_pfn_range(int online_type, int nid, unsigned start_pfn,
>   }
>   
>   int __ref online_pages(unsigned long pfn, unsigned long nr_pages,
> -		       int online_type, int nid)
> +		       unsigned long nr_vmemmap_pages, int online_type, int nid)
>   {
> -	unsigned long flags;
> +	unsigned long flags, valid_start_pfn, valid_nr_pages;
>   	struct zone *zone;
>   	int need_zonelists_rebuild = 0;
>   	int ret;
> @@ -809,11 +836,15 @@ int __ref online_pages(unsigned long pfn, unsigned long nr_pages,
>   			 !IS_ALIGNED(pfn | nr_pages, PAGES_PER_SECTION)))
>   		return -EINVAL;
>   
> +	valid_start_pfn = pfn + nr_vmemmap_pages;
> +	valid_nr_pages = nr_pages - nr_vmemmap_pages;

Hm, valid sounds strange. More like "free_start_pfn" or "buddy_start_pfn".

> +
>   	mem_hotplug_begin();
>   
>   	/* associate pfn range with the zone */
>   	zone = zone_for_pfn_range(online_type, nid, pfn, nr_pages);
> -	move_pfn_range_to_zone(zone, pfn, nr_pages, NULL, MIGRATE_ISOLATE);
> +	move_pfn_range_to_zone(zone, pfn, nr_pages, nr_vmemmap_pages, NULL,
> +			       MIGRATE_ISOLATE);

As mentioned, I'd suggest properly initializing the memmap here

if (nr_vmemmap_pages) {
	move_pfn_range_to_zone(zone, pfn, nr_vmemmap_pages, NULL,
			       MIGRATE_UNMOVABLE);
}
move_pfn_range_to_zone(zone, valid_start_pfn, valid_nr_pages, NULL,
		       MIGRATE_ISOLATE);

[...]

>   /*
>    * NOTE: The caller must call lock_device_hotplug() to serialize hotplug
>    * and online/offline operations (triggered e.g. by sysfs).
> @@ -1039,6 +1080,7 @@ static int online_memory_block(struct memory_block *mem, void *arg)
>   int __ref add_memory_resource(int nid, struct resource *res, mhp_t mhp_flags)
>   {
>   	struct mhp_params params = { .pgprot = PAGE_KERNEL };
> +	struct vmem_altmap mhp_altmap = {};
>   	u64 start, size;
>   	bool new_node = false;
>   	int ret;
> @@ -1065,18 +1107,36 @@ int __ref add_memory_resource(int nid, struct resource *res, mhp_t mhp_flags)
>   		goto error;
>   	new_node = ret;
>   
> +	/*
> +	 * Check whether we support memmap_on_memory
> +	 */
> +	if (!support_memmap_on_memory(size))
> +		mhp_flags &= ~MEMHP_MEMMAP_ON_MEMORY;

Callers (e.g., virtio-mem) might rely on this. We should reject this 
with -EINVAL and provide a way for callers to test whether this flag is 
possible.

> +
> +	/*
> +	 * Self hosted memmap array
> +	 */
> +	if (mhp_flags & MEMHP_MEMMAP_ON_MEMORY) {
> +		mhp_altmap.free = size >> PAGE_SHIFT;
> +		mhp_altmap.base_pfn = start >> PAGE_SHIFT;
> +		params.altmap = &mhp_altmap;
> +	}
> +
>   	/* call arch's memory hotadd */
>   	ret = arch_add_memory(nid, start, size, &params);
>   	if (ret < 0)
>   		goto error;
>   
>   	/* create memory block devices after memory was added */
> -	ret = create_memory_block_devices(start, size);
> +	ret = create_memory_block_devices(start, size, mhp_altmap.alloc);
>   	if (ret) {
>   		arch_remove_memory(nid, start, size, NULL);
>   		goto error;
>   	}
>   
> +	if (mhp_flags & MEMHP_MEMMAP_ON_MEMORY)
> +		mhp_mark_vmemmap_pages(params.altmap);

Do we really still need that? Pages are offline, so we're messing with 
an invalid memmap. online_pages() should handle initializing the memmap 
of these pages.

[...]

> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index e74ca22baaa1..043503fb8c6e 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -8761,6 +8761,13 @@ void __offline_isolated_pages(unsigned long start_pfn, unsigned long end_pfn)
>   	spin_lock_irqsave(&zone->lock, flags);
>   	while (pfn < end_pfn) {
>   		page = pfn_to_page(pfn);
> +		/*
> +		 * Skip vmemmap pages
> +		 */
> +		if (PageVmemmap(page)) {
> +			pfn += vmemmap_nr_pages(page);
> +			continue;
> +		}

I'd assume calling code can handle that and exclude isolating such pages.


-- 
Thanks,

David / dhildenb

