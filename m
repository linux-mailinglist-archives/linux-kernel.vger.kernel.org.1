Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0018E2FFEA8
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 09:50:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727122AbhAVIsK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 03:48:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43152 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727065AbhAVIrx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 03:47:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611305171;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=W9hpPJvAyhnuHSgbD9g4m8T5svdyibCO1NZRNpgCoXk=;
        b=PuW7KNsRnWLD7RGUMJcCOaVxYopT46aAG7cdvugbd2O/JFMtC09MNlVTizzzS+0mc+RawR
        QBuu89jC3YF0BlUZ/QiUi2WBFkbemf/qooF73UM8HPDuQO4DgLlb1fwjfL57Qalcf6lkTy
        RG9LA39sBJ9ZO4pBaxdHsGzM1mthjFg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-121-fu4px1tBMR66myn7zam_Ug-1; Fri, 22 Jan 2021 03:46:09 -0500
X-MC-Unique: fu4px1tBMR66myn7zam_Ug-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 05E8684E240;
        Fri, 22 Jan 2021 08:46:08 +0000 (UTC)
Received: from [10.36.114.142] (ovpn-114-142.ams2.redhat.com [10.36.114.142])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CE1D85D9E8;
        Fri, 22 Jan 2021 08:46:06 +0000 (UTC)
Subject: Re: [PATCH v4 1/4] mm: rename memmap_init() and memmap_init_zone()
To:     Baoquan He <bhe@redhat.com>, linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org, rppt@kernel.org
References: <20210120045213.6571-1-bhe@redhat.com>
 <20210120045213.6571-2-bhe@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <567ddadb-dc4b-e016-b0d6-947e7e1381b3@redhat.com>
Date:   Fri, 22 Jan 2021 09:46:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20210120045213.6571-2-bhe@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.01.21 05:52, Baoquan He wrote:
> The current memmap_init_zone() only handles memory region inside one zone,
> actually memmap_init() does the memmap init of one zone. So rename both of
> them accordingly.
> 
> Signed-off-by: Baoquan He <bhe@redhat.com>
> ---
>  arch/ia64/include/asm/pgtable.h | 2 +-
>  arch/ia64/mm/init.c             | 6 +++---
>  include/linux/mm.h              | 2 +-
>  mm/memory_hotplug.c             | 2 +-
>  mm/page_alloc.c                 | 8 ++++----
>  5 files changed, 10 insertions(+), 10 deletions(-)
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
> index 3dac7bc667ee..56bb239f9150 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -2398,7 +2398,7 @@ extern int __meminit early_pfn_to_nid(unsigned long pfn);
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

