Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BB982DF952
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Dec 2020 07:36:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728568AbgLUGf5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 01:35:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:46088 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728409AbgLUGf5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 01:35:57 -0500
Date:   Mon, 21 Dec 2020 08:35:09 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608532516;
        bh=CDzFFK1gZq+ZpVRYJf1GjMW3wuMU9Dcb6QR1oomaDfM=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=OMF06ym19B/k2FQ2dIssmTAfwFEO/FxjVmoA6sZJ3fyaohMGhiAnlt57zPB0j75kM
         aOWGpRr9uhBmdyO79DEar2tM4wz5kKA79Hrnfxf0haI9yiRiWgGjqkAgq1OkBznrp6
         s+r+lGPBDXs62/ZJdam993Zf12zjt+o9iDon0+idOFVsbBvSKR/bYCDo1YFKIkyTpI
         DLhniYs2Grw3DTzVFIMI5hJ5GqpRgY8I3mWnM6upskVu2FY18DJEbC2U48QeyDF77b
         f99Z4UabATOTtwxPCzA70lrDNv0sCsWFvYYAvkoW9qneIAxpdw+A9XTU9fs2F2iNpq
         xEve3WA9sjQgQ==
From:   Mike Rapoport <rppt@kernel.org>
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, gopakumarr@vmware.com, david@redhat.com
Subject: Re: [PATCH v2 5/5] mm: remove unneeded local variable in
 free_area_init_core
Message-ID: <20201221063509.GG392325@kernel.org>
References: <20201220082754.6900-1-bhe@redhat.com>
 <20201220082754.6900-6-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201220082754.6900-6-bhe@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 20, 2020 at 04:27:54PM +0800, Baoquan He wrote:
> Local variable 'zone_start_pfn' is not needed since there's only
> one call site in free_area_init_core(). Let's remove it and pass
> zone->zone_start_pfn directly to init_currently_empty_zone().
> 
> Signed-off-by: Baoquan He <bhe@redhat.com>

Reviewed-by: Mike Rapoport <rppt@linux.ibm.com>

> ---
>  mm/page_alloc.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 7f0a917ab858..189a86253c93 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -6986,7 +6986,6 @@ static void __init free_area_init_core(struct pglist_data *pgdat)
>  	for (j = 0; j < MAX_NR_ZONES; j++) {
>  		struct zone *zone = pgdat->node_zones + j;
>  		unsigned long size, freesize, memmap_pages;
> -		unsigned long zone_start_pfn = zone->zone_start_pfn;
>  
>  		size = zone->spanned_pages;
>  		freesize = zone->present_pages;
> @@ -7035,7 +7034,7 @@ static void __init free_area_init_core(struct pglist_data *pgdat)
>  
>  		set_pageblock_order();
>  		setup_usemap(zone);
> -		init_currently_empty_zone(zone, zone_start_pfn, size);
> +		init_currently_empty_zone(zone, zone->zone_start_pfn, size);
>  		memmap_init_zone(zone);
>  	}
>  }
> -- 
> 2.17.2
> 

-- 
Sincerely yours,
Mike.
