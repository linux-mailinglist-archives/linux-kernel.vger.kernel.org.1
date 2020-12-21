Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A02A2DF950
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Dec 2020 07:35:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728543AbgLUGfC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 01:35:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:45892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727891AbgLUGfB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 01:35:01 -0500
Date:   Mon, 21 Dec 2020 08:34:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608532461;
        bh=AllzIseDJB+veTvgx8klX9+WufFcUIm+qeAcrzQmfw4=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=lt+Bz+nC2ZIqzHkjwv5NGyL0Lujs3YAnLU97zy/PABJBbDOSfgiXt4r2BNcc1VxNO
         cX32pvmUOjysFPCXE9i3RtnnsvAB7E6NqpR0RzXmJNw7qGSDhiRAIJT2OeXACr5DJs
         KdLZ8fEOTSdyZUDo1jkkbnmN1mIIdIctZudV1YslLSwsvpxJkyB1a48ZrascHR4n/y
         +JCwURkq6A6c+QG4gxJy40GhUJa0mhQydcUN1aiK9IWHRkGBFZBj+nuq+UbTgM1eB0
         xlB4gkGdraG0zY3rRrHWiwTPHEoazyczAJfAVEVHpP2O3NX6DK/jZxi3jsr47Co2M4
         yugGLVzTkhtqQ==
From:   Mike Rapoport <rppt@kernel.org>
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, gopakumarr@vmware.com, david@redhat.com
Subject: Re: [PATCH v2 3/5] mm: simplify parater of function
 memmap_init_zone()
Message-ID: <20201221063414.GE392325@kernel.org>
References: <20201220082754.6900-1-bhe@redhat.com>
 <20201220082754.6900-4-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201220082754.6900-4-bhe@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 20, 2020 at 04:27:52PM +0800, Baoquan He wrote:
> As David suggested, simply passing 'struct zone *zone' is enough. We can
> get all needed information from 'struct zone*' easily.
> 
> Suggested-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Baoquan He <bhe@redhat.com>

Reviewed-by: Mike Rapoport <rppt@linux.ibm.com>

> ---
>  arch/ia64/include/asm/pgtable.h |  3 +--
>  arch/ia64/mm/init.c             | 12 +++++++-----
>  mm/page_alloc.c                 | 20 ++++++++++----------
>  3 files changed, 18 insertions(+), 17 deletions(-)
> 
> diff --git a/arch/ia64/include/asm/pgtable.h b/arch/ia64/include/asm/pgtable.h
> index dce2ff37df65..2c81394a2430 100644
> --- a/arch/ia64/include/asm/pgtable.h
> +++ b/arch/ia64/include/asm/pgtable.h
> @@ -520,8 +520,7 @@ extern struct page *zero_page_memmap_ptr;
>  
>  #  ifdef CONFIG_VIRTUAL_MEM_MAP
>    /* arch mem_map init routine is needed due to holes in a virtual mem_map */
> -    extern void memmap_init_zone(unsigned long size, int nid, unsigned long zone,
> -			     unsigned long start_pfn);
> +    extern void memmap_init_zone(struct zone *zone);
>  #  endif /* CONFIG_VIRTUAL_MEM_MAP */
>  # endif /* !__ASSEMBLY__ */
>  
> diff --git a/arch/ia64/mm/init.c b/arch/ia64/mm/init.c
> index c8e68e92beb3..ccbda1a74c95 100644
> --- a/arch/ia64/mm/init.c
> +++ b/arch/ia64/mm/init.c
> @@ -541,12 +541,14 @@ virtual_memmap_init(u64 start, u64 end, void *arg)
>  	return 0;
>  }
>  
> -void __meminit
> -memmap_init_zone(unsigned long size, int nid, unsigned long zone,
> -	     unsigned long start_pfn)
> +void __meminit memmap_init_zone(struct zone *zone)
>  {
> +	unsigned long size = zone->spanned_pages;
> +	int nid = zone_to_nid(zone), zone_id = zone_idx(zone);
> +	unsigned long start_pfn = zone->zone_start_pfn;
> +
>  	if (!vmem_map) {
> -		memmap_init_range(size, nid, zone, start_pfn, start_pfn + size,
> +		memmap_init_range(size, nid, zone_id, start_pfn, start_pfn + size,
>  				 MEMINIT_EARLY, NULL, MIGRATE_MOVABLE);
>  	} else {
>  		struct page *start;
> @@ -556,7 +558,7 @@ memmap_init_zone(unsigned long size, int nid, unsigned long zone,
>  		args.start = start;
>  		args.end = start + size;
>  		args.nid = nid;
> -		args.zone = zone;
> +		args.zone = zone_id;
>  
>  		efi_memmap_walk(virtual_memmap_init, &args);
>  	}
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 4b46326099d9..7a6626351ed7 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -6292,16 +6292,16 @@ static inline u64 init_unavailable_range(unsigned long spfn, unsigned long epfn,
>  }
>  #endif
>  
> -void __init __weak memmap_init_zone(unsigned long size, int nid,
> -			       unsigned long zone,
> -			       unsigned long zone_start_pfn)
> +void __init __weak memmap_init_zone(struct zone *zone)
>  {
>  	unsigned long start_pfn, end_pfn, hole_start_pfn = 0;
> -	unsigned long zone_end_pfn = zone_start_pfn + size;
> +	int i, nid = zone_to_nid(zone), zone_id = zone_idx(zone);
> +	unsigned long zone_start_pfn = zone->zone_start_pfn;
> +	unsigned long zone_end_pfn = zone_start_pfn + zone->spanned_pages;
>  	u64 pgcnt = 0;
> -	int i;
>  
>  	for_each_mem_pfn_range(i, nid, &start_pfn, &end_pfn, NULL) {
> +		unsigned long size;
>  		start_pfn = clamp(start_pfn, zone_start_pfn, zone_end_pfn);
>  		end_pfn = clamp(end_pfn, zone_start_pfn, zone_end_pfn);
>  		hole_start_pfn = clamp(hole_start_pfn, zone_start_pfn,
> @@ -6309,13 +6309,13 @@ void __init __weak memmap_init_zone(unsigned long size, int nid,
>  
>  		if (end_pfn > start_pfn) {
>  			size = end_pfn - start_pfn;
> -			memmap_init_range(size, nid, zone, start_pfn, zone_end_pfn,
> +			memmap_init_range(size, nid, zone_id, start_pfn, zone_end_pfn,
>  					 MEMINIT_EARLY, NULL, MIGRATE_MOVABLE);
>  		}
>  
>  		if (hole_start_pfn < start_pfn)
>  			pgcnt += init_unavailable_range(hole_start_pfn,
> -							start_pfn, zone, nid);
> +							start_pfn, zone_id, nid);
>  		hole_start_pfn = end_pfn;
>  	}
>  
> @@ -6328,11 +6328,11 @@ void __init __weak memmap_init_zone(unsigned long size, int nid,
>  	 */
>  	if (hole_start_pfn < zone_end_pfn)
>  		pgcnt += init_unavailable_range(hole_start_pfn, zone_end_pfn,
> -						zone, nid);
> +						zone_id, nid);
>  
>  	if (pgcnt)
>  		pr_info("%s: Zeroed struct page in unavailable ranges: %lld\n",
> -			zone_names[zone], pgcnt);
> +			zone_names[zone_id], pgcnt);
>  }
>  
>  static int zone_batchsize(struct zone *zone)
> @@ -7039,7 +7039,7 @@ static void __init free_area_init_core(struct pglist_data *pgdat)
>  		set_pageblock_order();
>  		setup_usemap(pgdat, zone, zone_start_pfn, size);
>  		init_currently_empty_zone(zone, zone_start_pfn, size);
> -		memmap_init_zone(size, nid, j, zone_start_pfn);
> +		memmap_init_zone(zone);
>  	}
>  }
>  
> -- 
> 2.17.2
> 

-- 
Sincerely yours,
Mike.
