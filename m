Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 493AC283624
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 15:03:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726719AbgJENDn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 09:03:43 -0400
Received: from mx2.suse.de ([195.135.220.15]:36716 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726064AbgJENDm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 09:03:42 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1601902369;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ns5ZwFCdhDQq4nuYCyyIwqB39q09F/YpJPjZ7uWOQmY=;
        b=EDNTZtVlRR9rydSnWsBPBEsy9+JwwzprOyNvfSZbCe1SyXZ8VlxTvHFinU4FWOO501B9o7
        Gv6AuREmjDmsxD6vP90QvMQ9bzlZxBJFlt6g1zYyRwdr0p3Oys4PvXdZti26k7ffY+6Ga1
        4fdeizJ2gsnSAz3DO9aooUaw9MS2+m8=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 6B235ADBE;
        Mon,  5 Oct 2020 12:52:49 +0000 (UTC)
Date:   Mon, 5 Oct 2020 14:52:47 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Subject: Re: [PATCH 2/9] mm, page_alloc: calculate pageset high and batch
 once per zone
Message-ID: <20201005125247.GX4555@dhcp22.suse.cz>
References: <20200922143712.12048-1-vbabka@suse.cz>
 <20200922143712.12048-3-vbabka@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200922143712.12048-3-vbabka@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 22-09-20 16:37:05, Vlastimil Babka wrote:
> We currently call pageset_set_high_and_batch() for each possible cpu, which
> repeats the same calculations of high and batch values.
> 
> Instead call the function just once per zone, and make it apply the calculated
> values to all per-cpu pagesets of the zone.
> 
> This also allows removing the zone_pageset_init() and __zone_pcp_update()
> wrappers.
> 
> No functional change.
> 
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> Reviewed-by: Oscar Salvador <osalvador@suse.de>
> Reviewed-by: David Hildenbrand <david@redhat.com>

I like this. One question below
Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  mm/page_alloc.c | 42 ++++++++++++++++++------------------------
>  1 file changed, 18 insertions(+), 24 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index a163c5e561f2..26069c8d1b19 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -6219,13 +6219,14 @@ static void setup_pageset(struct per_cpu_pageset *p)
>  }
>  
>  /*
> - * Calculate and set new high and batch values for given per-cpu pageset of a
> + * Calculate and set new high and batch values for all per-cpu pagesets of a
>   * zone, based on the zone's size and the percpu_pagelist_fraction sysctl.
>   */
> -static void pageset_set_high_and_batch(struct zone *zone,
> -				       struct per_cpu_pageset *p)
> +static void zone_set_pageset_high_and_batch(struct zone *zone)
>  {
>  	unsigned long new_high, new_batch;
> +	struct per_cpu_pageset *p;
> +	int cpu;
>  
>  	if (percpu_pagelist_fraction) {
>  		new_high = zone_managed_pages(zone) / percpu_pagelist_fraction;
> @@ -6237,23 +6238,25 @@ static void pageset_set_high_and_batch(struct zone *zone,
>  		new_high = 6 * new_batch;
>  		new_batch = max(1UL, 1 * new_batch);
>  	}
> -	pageset_update(&p->pcp, new_high, new_batch);
> -}
> -
> -static void __meminit zone_pageset_init(struct zone *zone, int cpu)
> -{
> -	struct per_cpu_pageset *pcp = per_cpu_ptr(zone->pageset, cpu);
>  
> -	pageset_init(pcp);
> -	pageset_set_high_and_batch(zone, pcp);
> +	for_each_possible_cpu(cpu) {
> +		p = per_cpu_ptr(zone->pageset, cpu);
> +		pageset_update(&p->pcp, new_high, new_batch);
> +	}
>  }
>  
>  void __meminit setup_zone_pageset(struct zone *zone)
>  {
> +	struct per_cpu_pageset *p;
>  	int cpu;
> +
>  	zone->pageset = alloc_percpu(struct per_cpu_pageset);
> -	for_each_possible_cpu(cpu)
> -		zone_pageset_init(zone, cpu);
> +	for_each_possible_cpu(cpu) {
> +		p = per_cpu_ptr(zone->pageset, cpu);
> +		pageset_init(p);
> +	}
> +
> +	zone_set_pageset_high_and_batch(zone);

I hope I am not misreading the diff but it seems that setup_zone_pageset
is calling pageset_init which is then done again by
zone_set_pageset_high_and_batch as a part of pageset_update

-- 
Michal Hocko
SUSE Labs
