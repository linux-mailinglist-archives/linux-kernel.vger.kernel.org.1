Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 641CB2D95B6
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 11:02:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727200AbgLNKCM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 05:02:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:42951 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2404665AbgLNKBx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 05:01:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607940026;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WezndR1ZPErHJpbLiJwq4svAXKlYawM5qHHibjeL66A=;
        b=gB8rzQjtivErHBPWXz9M9TTAUY8eyy7B9gdmkny0EtCoFgvSJIAvmqXdQ2TjlR8SwhcK+I
        29cWCtAs5QdpImXhq2s58Ra6HySNQzLJQGpwCp4LnK7BqsCWeWyWRTAj9C9a3qgPihJ2A1
        fFgLsR0MUu9IOs4DmN8Z6evoCyMKHDs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-214-B4tLvSdHNBazOg3Ax8KNrg-1; Mon, 14 Dec 2020 05:00:22 -0500
X-MC-Unique: B4tLvSdHNBazOg3Ax8KNrg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 75B7B809DE1;
        Mon, 14 Dec 2020 10:00:19 +0000 (UTC)
Received: from [10.36.114.184] (ovpn-114-184.ams2.redhat.com [10.36.114.184])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A82DC60C7A;
        Mon, 14 Dec 2020 10:00:08 +0000 (UTC)
Subject: Re: [PATCH 2/2] mm: rename memmap_init() and memmap_init_zone()
To:     Baoquan He <bhe@redhat.com>, linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, gopakumarr@vmware.com,
        akpm@linux-foundation.org, rppt@kernel.org,
        natechancellor@gmail.com, ndesaulniers@google.com,
        clang-built-linux@googlegroups.com, rostedt@goodmis.org,
        manir@vmware.com, lauyiuch@vmware.com, pjonasson@vmware.com,
        rajaramv@vmware.com
References: <20201213150942.20990-1-bhe@redhat.com>
 <20201213150942.20990-3-bhe@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <c53c5290-b5c1-87bb-d562-348d4c8bd7eb@redhat.com>
Date:   Mon, 14 Dec 2020 11:00:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201213150942.20990-3-bhe@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13.12.20 16:09, Baoquan He wrote:
> The current memmap_init_zone() only handles memory region inside one zone.
> Actually memmap_init() does the memmap init of one zone. So rename both of
> them accordingly.
> 
> And also rename the function parameter 'range_start_pfn' and local variable
> 'range_end_pfn' to zone_start_pfn/zone_end_pfn.
> 
> Signed-off-by: Baoquan He <bhe@redhat.com>
> ---
>  arch/ia64/mm/init.c |  6 +++---
>  include/linux/mm.h  |  2 +-
>  mm/memory_hotplug.c |  2 +-
>  mm/page_alloc.c     | 16 ++++++++--------
>  4 files changed, 13 insertions(+), 13 deletions(-)
> 
> diff --git a/arch/ia64/mm/init.c b/arch/ia64/mm/init.c
> index 27ca549ff47e..af678197ac2d 100644
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
> +memmap_init_zone (unsigned long size, int nid, unsigned long zone,
>  	     unsigned long start_pfn)

While at it s/zone /zone/ please. :)

>  {
>  	if (!vmem_map) {
> -		memmap_init_zone(size, nid, zone, start_pfn, start_pfn + size,
> +		memmap_init_range(size, nid, zone, start_pfn, start_pfn + size,
>  				 MEMINIT_EARLY, NULL, MIGRATE_MOVABLE);
>  	} else {
>  		struct page *start;
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index cd5c313729ea..3d81ebbbef89 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -2439,7 +2439,7 @@ extern int __meminit __early_pfn_to_nid(unsigned long pfn,
>  #endif
>  
>  extern void set_dma_reserve(unsigned long new_dma_reserve);
> -extern void memmap_init_zone(unsigned long, int, unsigned long,
> +extern void memmap_init_range(unsigned long, int, unsigned long,
>  		unsigned long, unsigned long, enum meminit_context,
>  		struct vmem_altmap *, int migratetype);
>  extern void setup_per_zone_wmarks(void);
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 47b75da63f01..579762e4f8d8 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -714,7 +714,7 @@ void __ref move_pfn_range_to_zone(struct zone *zone, unsigned long start_pfn,
>  	 * expects the zone spans the pfn range. All the pages in the range
>  	 * are reserved so nobody should be touching them so we should be safe
>  	 */
> -	memmap_init_zone(nr_pages, nid, zone_idx(zone), start_pfn, 0,
> +	memmap_init_range(nr_pages, nid, zone_idx(zone), start_pfn, 0,
>  			 MEMINIT_HOTPLUG, altmap, migratetype);
>  
>  	set_zone_contiguous(zone);
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 315c22974f0d..fac599deba56 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -6050,7 +6050,7 @@ overlap_memmap_init(unsigned long zone, unsigned long *pfn)
>   * (usually MIGRATE_MOVABLE). Besides setting the migratetype, no related
>   * zone stats (e.g., nr_isolate_pageblock) are touched.
>   */
> -void __meminit memmap_init_zone(unsigned long size, int nid, unsigned long zone,
> +void __meminit memmap_init_range(unsigned long size, int nid, unsigned long zone,
>  		unsigned long start_pfn, unsigned long zone_end_pfn,
>  		enum meminit_context context,
>  		struct vmem_altmap *altmap, int migratetype)
> @@ -6187,21 +6187,21 @@ static void __meminit zone_init_free_lists(struct zone *zone)
>  	}
>  }
>  
> -void __meminit __weak memmap_init(unsigned long size, int nid,
> +void __meminit __weak memmap_init_zone(unsigned long size, int nid,
>  				  unsigned long zone,
> -				  unsigned long range_start_pfn)
> +				  unsigned long zone_start_pfn)

Why are we not simply passing "struct zone" like

void __meminit __weak  memmap_init_zone(struct zone *zone)

from which we can derive
- nid
- zone idx
- zone_start_pfn
- spanned_pages / zone_end_pfn

At least when called from free_area_init_core() this should work just
fine I think.



>  {
>  	unsigned long start_pfn, end_pfn;
> -	unsigned long range_end_pfn = range_start_pfn + size;
> +	unsigned long zone_end_pfn = zone_start_pfn + size;
>  	int i;
>  
>  	for_each_mem_pfn_range(i, nid, &start_pfn, &end_pfn, NULL) {
> -		start_pfn = clamp(start_pfn, range_start_pfn, range_end_pfn);
> -		end_pfn = clamp(end_pfn, range_start_pfn, range_end_pfn);
> +		start_pfn = clamp(start_pfn, zone_start_pfn, zone_end_pfn);
> +		end_pfn = clamp(end_pfn, zone_start_pfn, zone_end_pfn);
>  
>  		if (end_pfn > start_pfn) {
>  			size = end_pfn - start_pfn;
> -			memmap_init_zone(size, nid, zone, start_pfn, range_end_pfn,
> +			memmap_init_range(size, nid, zone, start_pfn, zone_end_pfn,
>  					 MEMINIT_EARLY, NULL, MIGRATE_MOVABLE);
>  		}
>  	}
> @@ -6903,7 +6903,7 @@ static void __init free_area_init_core(struct pglist_data *pgdat)
>  		set_pageblock_order();
>  		setup_usemap(pgdat, zone, zone_start_pfn, size);
>  		init_currently_empty_zone(zone, zone_start_pfn, size);
> -		memmap_init(size, nid, j, zone_start_pfn);
> +		memmap_init_zone(size, nid, j, zone_start_pfn);
>  	}
>  }
>  
> 


-- 
Thanks,

David / dhildenb

