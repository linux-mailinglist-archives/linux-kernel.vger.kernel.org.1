Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 751222FFE9D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 09:47:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbhAVIqG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 03:46:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20387 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725912AbhAVIpd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 03:45:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611305029;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ifhzLfxFZhE5fOvGrt8CGTkG+ZtK2ZNaRaWj8wQGq+0=;
        b=A8ja11bk4ekeitT5e2kRawDd8mRK7BO/VxGnaIaButRQ6d6gRUheBHBTvfBS6Pew9A0iT5
        rS7oeYxbNrkTFoXt4hS5b6g3nOTkN0pEw4NB6LY3QiB5KkcfoAE7mE1RaaZUXJM/oIbGti
        kJ5Ukzbjx0/nRByutkLr5Z4A6isG6KQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-561-f3xK7qJyPJ66xXEYMyXRaw-1; Fri, 22 Jan 2021 03:43:47 -0500
X-MC-Unique: f3xK7qJyPJ66xXEYMyXRaw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4287C107ACF8;
        Fri, 22 Jan 2021 08:43:46 +0000 (UTC)
Received: from [10.36.114.142] (ovpn-114-142.ams2.redhat.com [10.36.114.142])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 030605D9E8;
        Fri, 22 Jan 2021 08:43:44 +0000 (UTC)
Subject: Re: [PATCH v4 2/4] mm: simplify parater of function
 memmap_init_zone()
To:     Baoquan He <bhe@redhat.com>, linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org, rppt@kernel.org
References: <20210120045213.6571-1-bhe@redhat.com>
 <20210120045213.6571-3-bhe@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <eed1319e-a48d-5aa8-9dcd-9eb96cccab0d@redhat.com>
Date:   Fri, 22 Jan 2021 09:43:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20210120045213.6571-3-bhe@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.01.21 05:52, Baoquan He wrote:
> As David suggested, simply passing 'struct zone *zone' is enough. We can
> get all needed information from 'struct zone*' easily.
> 
> Suggested-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Baoquan He <bhe@redhat.com>
> ---
>  arch/ia64/include/asm/pgtable.h |  3 +--
>  arch/ia64/mm/init.c             | 12 +++++++-----
>  mm/page_alloc.c                 | 24 +++++++++++-------------
>  3 files changed, 19 insertions(+), 20 deletions(-)
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
> index c8e68e92beb3..88fb44895408 100644
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
> +	int nid = zone_to_nid(zone), zone_id = zone_idx(zone);
> +	unsigned long start_pfn = zone->zone_start_pfn;
> +	unsigned long size = zone->spanned_pages;
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
> index 42a1d2d2a87d..cbb67d9c1b2a 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -6254,23 +6254,21 @@ static void __meminit zone_init_free_lists(struct zone *zone)
>  	}
>  }
>  
> -void __meminit __weak memmap_init_zone(unsigned long size, int nid,
> -				  unsigned long zone,
> -				  unsigned long range_start_pfn)
> +void __meminit __weak memmap_init_zone(struct zone *zone)
>  {
> +	unsigned long zone_start_pfn = zone->zone_start_pfn;
> +	unsigned long zone_end_pfn = zone_start_pfn + zone->spanned_pages;
> +	int i, nid = zone_to_nid(zone), zone_id = zone_idx(zone);
>  	unsigned long start_pfn, end_pfn;
> -	unsigned long range_end_pfn = range_start_pfn + size;
> -	int i;
>  
>  	for_each_mem_pfn_range(i, nid, &start_pfn, &end_pfn, NULL) {
> -		start_pfn = clamp(start_pfn, range_start_pfn, range_end_pfn);
> -		end_pfn = clamp(end_pfn, range_start_pfn, range_end_pfn);
> +		start_pfn = clamp(start_pfn, zone_start_pfn, zone_end_pfn);
> +		end_pfn = clamp(end_pfn, zone_start_pfn, zone_end_pfn);
>  
> -		if (end_pfn > start_pfn) {
> -			size = end_pfn - start_pfn;
> -			memmap_init_range(size, nid, zone, start_pfn, range_end_pfn,
> -					 MEMINIT_EARLY, NULL, MIGRATE_MOVABLE);
> -		}
> +		if (end_pfn > start_pfn)
> +			memmap_init_range(end_pfn - start_pfn, nid,
> +					zone_id, start_pfn, zone_end_pfn,
> +					MEMINIT_EARLY, NULL, MIGRATE_MOVABLE);
>  	}
>  }
>  
> @@ -6978,7 +6976,7 @@ static void __init free_area_init_core(struct pglist_data *pgdat)
>  		set_pageblock_order();
>  		setup_usemap(pgdat, zone, zone_start_pfn, size);
>  		init_currently_empty_zone(zone, zone_start_pfn, size);
> -		memmap_init_zone(size, nid, j, zone_start_pfn);
> +		memmap_init_zone(zone);
>  	}
>  }
>  
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

