Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E20E82DF951
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Dec 2020 07:36:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728552AbgLUGfe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 01:35:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:45984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727891AbgLUGfe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 01:35:34 -0500
Date:   Mon, 21 Dec 2020 08:34:47 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608532493;
        bh=/XMITvGVQXi1Q86vNeHjvKaZkVpvGHlqwhLih1f1p3w=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=lDF2/KXCgVybiH9zGQ/umO+Gwa8ffNocP6YXhkFKJpZa4g2MeoEvJOYowNUGDQZCR
         9rW/JctPjgxSkfDDDzZN/2G8wvfwIDQPgc4VDfa4FSB6lP2olsAAUIs51YCBX9txZ8
         Ah5bOqKKmNqiBttJcuso6cI63g8vT7ZQNXVJXo3c3DvKOExfXyRN9F4WBs/IeY+AJ9
         1scIwCQHl54v+hOp6CQJgiDiUujiUYkLLP2eMjnLyCpFxLMZxuRt5LQ+R5b6bvcCSl
         jMYT91dpWSP8o954c+Wmguzjy6xBdMOBDrt1GTR0AO0VeF1gFscr8huTEVf3gfFYob
         ftg+vmDWlXZgg==
From:   Mike Rapoport <rppt@kernel.org>
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, gopakumarr@vmware.com, david@redhat.com
Subject: Re: [PATCH v2 4/5] mm: simplify parameter of setup_usemap()
Message-ID: <20201221063447.GF392325@kernel.org>
References: <20201220082754.6900-1-bhe@redhat.com>
 <20201220082754.6900-5-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201220082754.6900-5-bhe@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 20, 2020 at 04:27:53PM +0800, Baoquan He wrote:
> Parameter 'zone' has got needed information, let's remove other
> unnecessary parameters.
> 
> Signed-off-by: Baoquan He <bhe@redhat.com>

Reviewed-by: Mike Rapoport <rppt@linux.ibm.com>

> ---
>  mm/page_alloc.c | 17 +++++++----------
>  1 file changed, 7 insertions(+), 10 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 7a6626351ed7..7f0a917ab858 100644
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
> -- 
> 2.17.2
> 

-- 
Sincerely yours,
Mike.
