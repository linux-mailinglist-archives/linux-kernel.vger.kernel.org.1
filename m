Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF8442DF94F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Dec 2020 07:35:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728518AbgLUGeQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 01:34:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:45678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725984AbgLUGeP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 01:34:15 -0500
Date:   Mon, 21 Dec 2020 08:33:26 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608532414;
        bh=Pu2KlTzNFkg2ggf8lcNvuv1kU8SafJaGgQpfcKLGtj4=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=fzF7+548kLv8XIsLLszXrTI4kvgvwWtvjrdz+/5z0yTcBwjxHttmF7nW2m9eY7DvX
         7lf/i1mjW3c/bQi02/Z4OEFciitpaw2N7j6cpoYRCNzOTbJKFk9kFW8UvITdgam4kS
         CFxskjar0TL19CVfcnNYv4pUWu7LWwpfhpkup787u6hV2sSaXCAQmzMum6Q8Z6RJUA
         HGIljekApZUkcGu0MR+BJ2xG/tGBZ4sfTR+eWXuSDfIUUPiuIVXCtpQpUDzFN21vKG
         r26r72OXHt4JAxwyrG4Rr7oV35IVtxp656XnFlfLW/gvr0xl0ADnQdKJAcG0PdlGof
         CBf60er/u0Q7Q==
From:   Mike Rapoport <rppt@kernel.org>
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, gopakumarr@vmware.com, david@redhat.com
Subject: Re: [PATCH v2 2/5] mm: rename memmap_init() and memmap_init_zone()
Message-ID: <20201221063326.GD392325@kernel.org>
References: <20201220082754.6900-1-bhe@redhat.com>
 <20201220082754.6900-3-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201220082754.6900-3-bhe@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 20, 2020 at 04:27:51PM +0800, Baoquan He wrote:
> The current memmap_init_zone() only handles memory region inside one zone,
> actually memmap_init() does the memmap init of one zone. So rename both of
> them accordingly.
> 
> And also rename the function parameter 'range_start_pfn' and local variable
> 'range_end_pfn' of memmap_init() to zone_start_pfn/zone_end_pfn.
> 
> Signed-off-by: Baoquan He <bhe@redhat.com>

Reviewed-by: Mike Rapoport <rppt@linux.ibm.com>

> ---
>  arch/ia64/include/asm/pgtable.h |  2 +-
>  arch/ia64/mm/init.c             |  6 +++---
>  include/linux/mm.h              |  2 +-
>  mm/memory_hotplug.c             |  2 +-
>  mm/page_alloc.c                 | 24 ++++++++++++------------
>  5 files changed, 18 insertions(+), 18 deletions(-)
> 
> diff --git a/arch/ia64/include/asm/pgtable.h b/arch/ia64/include/asm/pgtable.h
> index 779b6972aa84..dce2ff37df65 100644
> --- a/arch/ia64/include/asm/pgtable.h
> +++ b/arch/ia64/include/asm/pgtable.h
> @@ -520,7 +520,7 @@ extern struct page *zero_page_memmap_ptr;
>  
>  #  ifdef CONFIG_VIRTUAL_MEM_MAP
>    /* arch mem_map init routine is needed due to holes in a virtual mem_map */
> -    extern void memmap_init (unsigned long size, int nid, unsigned long zone,
> +    extern void memmap_init_zone(unsigned long size, int nid, unsigned long zone,
>  			     unsigned long start_pfn);
>  #  endif /* CONFIG_VIRTUAL_MEM_MAP */
>  # endif /* !__ASSEMBLY__ */
> diff --git a/arch/ia64/mm/init.c b/arch/ia64/mm/init.c
> index e76386a3479e..c8e68e92beb3 100644
> --- a/arch/ia64/mm/init.c
> +++ b/arch/ia64/mm/init.c
> @@ -535,18 +535,18 @@ virtual_memmap_init(u64 start, u64 end, void *arg)
>  		    / sizeof(struct page));
>  
>  	if (map_start < map_end)
> -		memmap_init_zone((unsigned long)(map_end - map_start),
> +		memmap_init_range((unsigned long)(map_end - map_start),
>  				 args->nid, args->zone, page_to_pfn(map_start), page_to_pfn(map_end),
>  				 MEMINIT_EARLY, NULL, MIGRATE_MOVABLE);
>  	return 0;
>  }
>  
>  void __meminit
> -memmap_init (unsigned long size, int nid, unsigned long zone,
> +memmap_init_zone(unsigned long size, int nid, unsigned long zone,
>  	     unsigned long start_pfn)
>  {
>  	if (!vmem_map) {
> -		memmap_init_zone(size, nid, zone, start_pfn, start_pfn + size,
> +		memmap_init_range(size, nid, zone, start_pfn, start_pfn + size,
>  				 MEMINIT_EARLY, NULL, MIGRATE_MOVABLE);
>  	} else {
>  		struct page *start;
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 92e06ea053f4..f72c138c2272 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -2432,7 +2432,7 @@ extern int __meminit early_pfn_to_nid(unsigned long pfn);
>  #endif
>  
>  extern void set_dma_reserve(unsigned long new_dma_reserve);
> -extern void memmap_init_zone(unsigned long, int, unsigned long,
> +extern void memmap_init_range(unsigned long, int, unsigned long,
>  		unsigned long, unsigned long, enum meminit_context,
>  		struct vmem_altmap *, int migratetype);
>  extern void setup_per_zone_wmarks(void);
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index f9d57b9be8c7..ddcb1cd24c60 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -713,7 +713,7 @@ void __ref move_pfn_range_to_zone(struct zone *zone, unsigned long start_pfn,
>  	 * expects the zone spans the pfn range. All the pages in the range
>  	 * are reserved so nobody should be touching them so we should be safe
>  	 */
> -	memmap_init_zone(nr_pages, nid, zone_idx(zone), start_pfn, 0,
> +	memmap_init_range(nr_pages, nid, zone_idx(zone), start_pfn, 0,
>  			 MEMINIT_HOTPLUG, altmap, migratetype);
>  
>  	set_zone_contiguous(zone);
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 32645f2e7b96..4b46326099d9 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -6117,7 +6117,7 @@ overlap_memmap_init(unsigned long zone, unsigned long *pfn)
>   * (usually MIGRATE_MOVABLE). Besides setting the migratetype, no related
>   * zone stats (e.g., nr_isolate_pageblock) are touched.
>   */
> -void __meminit memmap_init_zone(unsigned long size, int nid, unsigned long zone,
> +void __meminit memmap_init_range(unsigned long size, int nid, unsigned long zone,
>  		unsigned long start_pfn, unsigned long zone_end_pfn,
>  		enum meminit_context context,
>  		struct vmem_altmap *altmap, int migratetype)
> @@ -6292,24 +6292,24 @@ static inline u64 init_unavailable_range(unsigned long spfn, unsigned long epfn,
>  }
>  #endif
>  
> -void __init __weak memmap_init(unsigned long size, int nid,
> +void __init __weak memmap_init_zone(unsigned long size, int nid,
>  			       unsigned long zone,
> -			       unsigned long range_start_pfn)
> +			       unsigned long zone_start_pfn)
>  {
>  	unsigned long start_pfn, end_pfn, hole_start_pfn = 0;
> -	unsigned long range_end_pfn = range_start_pfn + size;
> +	unsigned long zone_end_pfn = zone_start_pfn + size;
>  	u64 pgcnt = 0;
>  	int i;
>  
>  	for_each_mem_pfn_range(i, nid, &start_pfn, &end_pfn, NULL) {
> -		start_pfn = clamp(start_pfn, range_start_pfn, range_end_pfn);
> -		end_pfn = clamp(end_pfn, range_start_pfn, range_end_pfn);
> -		hole_start_pfn = clamp(hole_start_pfn, range_start_pfn,
> -				       range_end_pfn);
> +		start_pfn = clamp(start_pfn, zone_start_pfn, zone_end_pfn);
> +		end_pfn = clamp(end_pfn, zone_start_pfn, zone_end_pfn);
> +		hole_start_pfn = clamp(hole_start_pfn, zone_start_pfn,
> +				       zone_end_pfn);
>  
>  		if (end_pfn > start_pfn) {
>  			size = end_pfn - start_pfn;
> -			memmap_init_zone(size, nid, zone, start_pfn, range_end_pfn,
> +			memmap_init_range(size, nid, zone, start_pfn, zone_end_pfn,
>  					 MEMINIT_EARLY, NULL, MIGRATE_MOVABLE);
>  		}
>  
> @@ -6326,8 +6326,8 @@ void __init __weak memmap_init(unsigned long size, int nid,
>  	 * considered initialized. Make sure that memmap has a well defined
>  	 * state.
>  	 */
> -	if (hole_start_pfn < range_end_pfn)
> -		pgcnt += init_unavailable_range(hole_start_pfn, range_end_pfn,
> +	if (hole_start_pfn < zone_end_pfn)
> +		pgcnt += init_unavailable_range(hole_start_pfn, zone_end_pfn,
>  						zone, nid);
>  
>  	if (pgcnt)
> @@ -7039,7 +7039,7 @@ static void __init free_area_init_core(struct pglist_data *pgdat)
>  		set_pageblock_order();
>  		setup_usemap(pgdat, zone, zone_start_pfn, size);
>  		init_currently_empty_zone(zone, zone_start_pfn, size);
> -		memmap_init(size, nid, j, zone_start_pfn);
> +		memmap_init_zone(size, nid, j, zone_start_pfn);
>  	}
>  }
>  
> -- 
> 2.17.2
> 

-- 
Sincerely yours,
Mike.
