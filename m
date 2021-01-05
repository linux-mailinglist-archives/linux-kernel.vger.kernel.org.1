Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE81D2EB0B1
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 17:58:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728833AbhAEQ5S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 11:57:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:28128 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725838AbhAEQ5S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 11:57:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1609865751;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=98+pCbtUqbWy+Z4JNrWpa2FBDJ8j13rrHnVYcmJcyK4=;
        b=Q1SOX1FeHGaK0QnekVfqwLpmW9alDvEwGk6BkEAWiqosu/pUtyiXKyOxpyQRi2GJJGDNwE
        ovNYKhSuQyfYYXZA7EpoO8L5svtLvC2z0pgtZ9oZg7fZh0QnLgOP2gd94Q3H4bu38VDyV/
        +1zOOm2xHVeS7Ot0y25K8sq+4qAo2HU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-78-wc2OnmZUOqyhWzCWqLqpqw-1; Tue, 05 Jan 2021 11:55:50 -0500
X-MC-Unique: wc2OnmZUOqyhWzCWqLqpqw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1AB3A1088D70;
        Tue,  5 Jan 2021 16:55:00 +0000 (UTC)
Received: from [10.36.114.117] (ovpn-114-117.ams2.redhat.com [10.36.114.117])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0BC1957;
        Tue,  5 Jan 2021 16:54:58 +0000 (UTC)
Subject: Re: [PATCH v3 3/4] mm: simplify parameter of setup_usemap()
To:     Baoquan He <bhe@redhat.com>, linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org, rppt@kernel.org
References: <20210105074708.18483-1-bhe@redhat.com>
 <20210105074708.18483-4-bhe@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <60b2a544-ee72-99f8-b584-2cf5851ae83a@redhat.com>
Date:   Tue, 5 Jan 2021 17:54:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20210105074708.18483-4-bhe@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05.01.21 08:47, Baoquan He wrote:
> Parameter 'zone' has got needed information, let's remove other
> unnecessary parameters.
> 
> Signed-off-by: Baoquan He <bhe@redhat.com>
> Reviewed-by: Mike Rapoport <rppt@linux.ibm.com>
> ---
>  mm/page_alloc.c | 17 +++++++----------
>  1 file changed, 7 insertions(+), 10 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index b2a46ffdaf0b..e0ce6fb6373b 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -6824,25 +6824,22 @@ static unsigned long __init usemap_size(unsigned long zone_start_pfn, unsigned l
>  	return usemapsize / 8;
>  }
>  
> -static void __ref setup_usemap(struct pglist_data *pgdat,
> -				struct zone *zone,
> -				unsigned long zone_start_pfn,
> -				unsigned long zonesize)
> +static void __ref setup_usemap(struct zone *zone)
>  {
> -	unsigned long usemapsize = usemap_size(zone_start_pfn, zonesize);
> +	unsigned long usemapsize = usemap_size(zone->zone_start_pfn,
> +					       zone->spanned_pages);
>  	zone->pageblock_flags = NULL;
>  	if (usemapsize) {
>  		zone->pageblock_flags =
>  			memblock_alloc_node(usemapsize, SMP_CACHE_BYTES,
> -					    pgdat->node_id);
> +					    zone_to_nid(zone));
>  		if (!zone->pageblock_flags)
>  			panic("Failed to allocate %ld bytes for zone %s pageblock flags on node %d\n",
> -			      usemapsize, zone->name, pgdat->node_id);
> +			      usemapsize, zone->name, zone_to_nid(zone));
>  	}
>  }
>  #else
> -static inline void setup_usemap(struct pglist_data *pgdat, struct zone *zone,
> -				unsigned long zone_start_pfn, unsigned long zonesize) {}
> +static inline void setup_usemap(struct zone *zone) {}
>  #endif /* CONFIG_SPARSEMEM */
>  
>  #ifdef CONFIG_HUGETLB_PAGE_SIZE_VARIABLE
> @@ -7037,7 +7034,7 @@ static void __init free_area_init_core(struct pglist_data *pgdat)
>  			continue;
>  
>  		set_pageblock_order();
> -		setup_usemap(pgdat, zone, zone_start_pfn, size);
> +		setup_usemap(zone);
>  		init_currently_empty_zone(zone, zone_start_pfn, size);
>  		memmap_init_zone(zone);
>  	}
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

