Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 122592CBA2A
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 11:10:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729360AbgLBKH1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 05:07:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44551 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727773AbgLBKH1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 05:07:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606903559;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xf0FpVyvaIHDpV0EKgsWk9KRCi8ZsYZaVGVgrMyivf8=;
        b=AWEBsdFXj56mqse70inT/6noq9QIOcr7K4z+HSjKNAiw+CU33skjKyZiFO7ySYd+aWJwmQ
        tBD3tsK33kNi2NrsAW76gIA1Mhx0JlSkGA7ikaWu8oJTixsAUJhZV/u7qo8wVU8KWIDaII
        rAKjDZL7MviynpvQHFZoy1FaViIimu4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-5-odxvSW_ENQGmdMYPPcEw2g-1; Wed, 02 Dec 2020 05:05:57 -0500
X-MC-Unique: odxvSW_ENQGmdMYPPcEw2g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B27FC3E747;
        Wed,  2 Dec 2020 10:05:55 +0000 (UTC)
Received: from [10.36.113.108] (ovpn-113-108.ams2.redhat.com [10.36.113.108])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 520C860BFA;
        Wed,  2 Dec 2020 10:05:54 +0000 (UTC)
Subject: Re: [RFC PATCH v3 2/4] mm,memory_hotplug: Allocate memmap from the
 added memory range
To:     Oscar Salvador <osalvador@suse.de>
Cc:     mhocko@kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, vbabka@suse.cz, pasha.tatashin@soleen.com
References: <20201201115158.22638-1-osalvador@suse.de>
 <20201201115158.22638-3-osalvador@suse.de>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <0e53ae49-6b0a-0714-df0f-fd6183061752@redhat.com>
Date:   Wed, 2 Dec 2020 11:05:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201201115158.22638-3-osalvador@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01.12.20 12:51, Oscar Salvador wrote:
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
> migration is being one on (buddy_start_pfn, end_pfn] range,
> being buddy_start_pfn = start_pfn + nr_vmemmap_pages.
> 
> In this way, we have:
> 
> (start_pfn, buddy_start_pfn - 1] = Initialized and PageReserved
> (buddy_start_pfn, end_pfn]       = Initialized and sent to buddy

If you take a look at generic_online_page() there are some things that
won't be done for our vmemmap pages

1. kernel_map_pages(page, 1 << order, 1);

We're accessing these pages already when initializing the memmap. We
might have to explicitly map these vmemmap pages at some point. Might
require some thought. Did you test with debug pagealloc?

2. totalram_pages_add(1UL << order);

We should add/remove the vmemmap pages manually from totalram I guess.


Also, I wonder if we should add these pages to the zone managed page
count. Not quite sure yet what the benefit would be and if we care at
all. (it's a change in behavior when hotplugging memory, though, that's
why I am poining it out)

> 
> Hot-remove:
> 
>  If the range was using memmap on memory (aka vmemmap pages),
>  we construct an altmap structure so free_hugepage_table does
>  the right thing and calls vmem_altmap_free instead of
>  free_pagetable.
> 

You might want to update the comment in include/linux/mmzone.h for
ZONE_MOVABLE, adding this special case when onlining such memory to the
MOVABLE zone. The pages are movable for offlining only, not for allocations.

[...]
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

We should even bail out if someone would have vmemmap_pages set when
creating more than one memory block device.

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
> index a54310abee79..b828ddf07682 100644
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
> @@ -321,7 +323,8 @@ static inline void pgdat_resize_init(struct pglist_data *pgdat) {}
>  #ifdef CONFIG_MEMORY_HOTREMOVE
>  
>  extern void try_offline_node(int nid);
> -extern int offline_pages(unsigned long start_pfn, unsigned long nr_pages);
> +extern int offline_pages(unsigned long start_pfn, unsigned long nr_pages,
> +			 unsigned long nr_vmemmap_pages);
>  extern int remove_memory(int nid, u64 start, u64 size);
>  extern void __remove_memory(int nid, u64 start, u64 size);
>  extern int offline_and_remove_memory(int nid, u64 start, u64 size);
> @@ -329,7 +332,8 @@ extern int offline_and_remove_memory(int nid, u64 start, u64 size);
>  #else
>  static inline void try_offline_node(int nid) {}
>  
> -static inline int offline_pages(unsigned long start_pfn, unsigned long nr_pages)
> +static inline int offline_pages(unsigned long start_pfn, unsigned long nr_pages,
> +				unsigned long nr_vmemmap_pages)
>  {
>  	return -EINVAL;
>  }
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
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index e3c310225a60..4b4708512f82 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -606,10 +606,12 @@ void generic_online_page(struct page *page, unsigned int order)
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
> @@ -617,8 +619,12 @@ static void online_pages_range(unsigned long start_pfn, unsigned long nr_pages)
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

I think it would be nicer to handle the unaligned part in a separate loop.

>  
>  	/* mark all involved sections as online */
>  	online_mem_sections(start_pfn, end_pfn);
> @@ -678,6 +684,7 @@ static void __meminit resize_pgdat_range(struct pglist_data *pgdat, unsigned lon
>  	pgdat->node_spanned_pages = max(start_pfn + nr_pages, old_end_pfn) - pgdat->node_start_pfn;
>  
>  }
> +

Unrelated change.
[...]

> +static int get_memblock_vmemmap_pages_cb(struct memory_block *mem, void *arg)
> +{
> +	unsigned long *nr_vmemmap_pages = (unsigned long *)arg;
> +	int ret = !mem->nr_vmemmap_pages;
> +
> +	if (!ret)
> +		*nr_vmemmap_pages += mem->nr_vmemmap_pages;
> +	return ret;

When removing in the same granularity than adding, all we care about it
the first memory block.


unsigned long *nr_vmemmap_pages = (unsigned long *)arg;

*nr_vmemmap_pages = mem->nr_vmemmap_pages;
/* We only care about the first memory block. */
return 1;


Removing in different granularity doesn't work at all.

> +}
> +
>  static int check_cpu_on_node(pg_data_t *pgdat)
>  {
>  	int cpu;
> @@ -1733,6 +1773,9 @@ EXPORT_SYMBOL(try_offline_node);
>  static int __ref try_remove_memory(int nid, u64 start, u64 size)
>  {
>  	int rc = 0;
> +	struct vmem_altmap mhp_altmap = {};
> +	struct vmem_altmap *altmap = NULL;
> +	unsigned long nr_vmemmap_pages = 0;
>  
>  	BUG_ON(check_hotplug_memory_range(start, size));
>  
> @@ -1745,6 +1788,17 @@ static int __ref try_remove_memory(int nid, u64 start, u64 size)
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

If someone would remove_memory() in a different granularity than
add_memory(), this would no longer work. How can we catch that
efficiently? Or at least document that this is not supported with
memmap_on_memory).


-- 
Thanks,

David / dhildenb

