Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0B4D300798
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 16:43:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728984AbhAVPmB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 10:42:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:38503 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727407AbhAVPkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 10:40:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611329931;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mqraKcbUqK611Wr8e1+vEgQa44uOEjEoJLlWqlVN1Bo=;
        b=HLCdMP0Ip95TFMCJiC+9kMmVcXefrRaBZg6e7LYJWiAm/ZBcrwEShfJP5DcQwfLHF5fEPJ
        AR/TCLj9iUYoqI9eIgij20QHAZXppFsLP2ldwIdp+zXVN50O9qPKReXUgyzxiVQO+dg2Di
        jb5+a3toO9rCHwBNCw817B7qEnPOBz0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-266-bxqkoubLN-ypFJ2twc3Isg-1; Fri, 22 Jan 2021 10:38:49 -0500
X-MC-Unique: bxqkoubLN-ypFJ2twc3Isg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B7F65800D55;
        Fri, 22 Jan 2021 15:38:47 +0000 (UTC)
Received: from [10.36.114.142] (ovpn-114-142.ams2.redhat.com [10.36.114.142])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5E0845D960;
        Fri, 22 Jan 2021 15:38:46 +0000 (UTC)
Subject: Re: [PATCH v5 2/5] mm: rename memmap_init() and memmap_init_zone()
To:     Baoquan He <bhe@redhat.com>, linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org, rppt@kernel.org,
        lkp@intel.com
References: <20210122135956.5946-1-bhe@redhat.com>
 <20210122135956.5946-3-bhe@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <de696b7f-8234-865e-c9bc-2c2b60954ce4@redhat.com>
Date:   Fri, 22 Jan 2021 16:38:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20210122135956.5946-3-bhe@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.01.21 14:59, Baoquan He wrote:
> The current memmap_init_zone() only handles memory region inside one zone,
> actually memmap_init() does the memmap init of one zone. So rename both of
> them accordingly.
> 
> Signed-off-by: Baoquan He <bhe@redhat.com>
> ---
>  arch/ia64/mm/init.c | 6 +++---
>  include/linux/mm.h  | 4 ++--
>  mm/memory_hotplug.c | 2 +-
>  mm/page_alloc.c     | 8 ++++----
>  4 files changed, 10 insertions(+), 10 deletions(-)
> 
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
> index 3d82b4f7cabc..2395dc212221 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -2398,10 +2398,10 @@ extern int __meminit early_pfn_to_nid(unsigned long pfn);
>  #endif
>  
>  extern void set_dma_reserve(unsigned long new_dma_reserve);
> -extern void memmap_init_zone(unsigned long, int, unsigned long,
> +extern void memmap_init_range(unsigned long, int, unsigned long,
>  		unsigned long, unsigned long, enum meminit_context,
>  		struct vmem_altmap *, int migratetype);
> -extern void memmap_init(unsigned long size, int nid,
> +extern void memmap_init_zone(unsigned long size, int nid,
>  		unsigned long zone, unsigned long range_start_pfn);
>  extern void setup_per_zone_wmarks(void);
>  extern int __meminit init_per_zone_wmark_min(void);
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
> index 44ec5594798d..42a1d2d2a87d 100644
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
> @@ -6254,7 +6254,7 @@ static void __meminit zone_init_free_lists(struct zone *zone)
>  	}
>  }
>  
> -void __meminit __weak memmap_init(unsigned long size, int nid,
> +void __meminit __weak memmap_init_zone(unsigned long size, int nid,
>  				  unsigned long zone,
>  				  unsigned long range_start_pfn)
>  {
> @@ -6268,7 +6268,7 @@ void __meminit __weak memmap_init(unsigned long size, int nid,
>  
>  		if (end_pfn > start_pfn) {
>  			size = end_pfn - start_pfn;
> -			memmap_init_zone(size, nid, zone, start_pfn, range_end_pfn,
> +			memmap_init_range(size, nid, zone, start_pfn, range_end_pfn,
>  					 MEMINIT_EARLY, NULL, MIGRATE_MOVABLE);
>  		}
>  	}
> @@ -6978,7 +6978,7 @@ static void __init free_area_init_core(struct pglist_data *pgdat)
>  		set_pageblock_order();
>  		setup_usemap(pgdat, zone, zone_start_pfn, size);
>  		init_currently_empty_zone(zone, zone_start_pfn, size);
> -		memmap_init(size, nid, j, zone_start_pfn);
> +		memmap_init_zone(size, nid, j, zone_start_pfn);
>  	}
>  }
>  
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

