Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23052283552
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 14:03:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726217AbgJEMDF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 08:03:05 -0400
Received: from mx2.suse.de ([195.135.220.15]:47182 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725891AbgJEMDE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 08:03:04 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1601899383;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PV99pQKv9zqVFOLcRmVPpukhOJoGn7cxASz+W/Ndtrk=;
        b=E2JUo/cj+DKc+Qv/kA3xoJDQIWh+Fcs+0TbZpvKAOGXFsXRMDxF3PEFyHiEhmFgbGx8fRU
        7O8ZcKypnBpIGYT2UKGJOF0opHB4BlS6//D1OU68g5E0p6iYFuU5nHjAVyycVJStSpdqf8
        JI8DUN4+NpRPkfs1PqpuNKubqJt4P0U=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id F189AB46F;
        Mon,  5 Oct 2020 12:03:02 +0000 (UTC)
Date:   Mon, 5 Oct 2020 14:03:01 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Subject: Re: [PATCH 1/9] mm, page_alloc: clean up pageset high and batch
 update
Message-ID: <20201005120301.GW4555@dhcp22.suse.cz>
References: <20200922143712.12048-1-vbabka@suse.cz>
 <20200922143712.12048-2-vbabka@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200922143712.12048-2-vbabka@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 22-09-20 16:37:04, Vlastimil Babka wrote:
> The updates to pcplists' high and batch valued are handled by multiple
> functions that make the calculations hard to follow. Consolidate everything
> to pageset_set_high_and_batch() and remove pageset_set_batch() and
> pageset_set_high() wrappers.
> 
> The only special case using one of the removed wrappers was:
> build_all_zonelists_init()
>   setup_pageset()
>     pageset_set_batch()
> which was hardcoding batch as 0, so we can just open-code a call to
> pageset_update() with constant parameters instead.
> 
> No functional change.
> 
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> Reviewed-by: Oscar Salvador <osalvador@suse.de>

yes this looks better, the original code was really hard to follow.

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  mm/page_alloc.c | 49 ++++++++++++++++++++-----------------------------
>  1 file changed, 20 insertions(+), 29 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 60a0e94645a6..a163c5e561f2 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -5823,7 +5823,7 @@ static void build_zonelists(pg_data_t *pgdat)
>   * not check if the processor is online before following the pageset pointer.
>   * Other parts of the kernel may not check if the zone is available.
>   */
> -static void setup_pageset(struct per_cpu_pageset *p, unsigned long batch);
> +static void setup_pageset(struct per_cpu_pageset *p);
>  static DEFINE_PER_CPU(struct per_cpu_pageset, boot_pageset);
>  static DEFINE_PER_CPU(struct per_cpu_nodestat, boot_nodestats);
>  
> @@ -5891,7 +5891,7 @@ build_all_zonelists_init(void)
>  	 * (a chicken-egg dilemma).
>  	 */
>  	for_each_possible_cpu(cpu)
> -		setup_pageset(&per_cpu(boot_pageset, cpu), 0);
> +		setup_pageset(&per_cpu(boot_pageset, cpu));
>  
>  	mminit_verify_zonelist();
>  	cpuset_init_current_mems_allowed();
> @@ -6200,12 +6200,6 @@ static void pageset_update(struct per_cpu_pages *pcp, unsigned long high,
>  	pcp->batch = batch;
>  }
>  
> -/* a companion to pageset_set_high() */
> -static void pageset_set_batch(struct per_cpu_pageset *p, unsigned long batch)
> -{
> -	pageset_update(&p->pcp, 6 * batch, max(1UL, 1 * batch));
> -}
> -
>  static void pageset_init(struct per_cpu_pageset *p)
>  {
>  	struct per_cpu_pages *pcp;
> @@ -6218,35 +6212,32 @@ static void pageset_init(struct per_cpu_pageset *p)
>  		INIT_LIST_HEAD(&pcp->lists[migratetype]);
>  }
>  
> -static void setup_pageset(struct per_cpu_pageset *p, unsigned long batch)
> +static void setup_pageset(struct per_cpu_pageset *p)
>  {
>  	pageset_init(p);
> -	pageset_set_batch(p, batch);
> +	pageset_update(&p->pcp, 0, 1);
>  }
>  
>  /*
> - * pageset_set_high() sets the high water mark for hot per_cpu_pagelist
> - * to the value high for the pageset p.
> + * Calculate and set new high and batch values for given per-cpu pageset of a
> + * zone, based on the zone's size and the percpu_pagelist_fraction sysctl.
>   */
> -static void pageset_set_high(struct per_cpu_pageset *p,
> -				unsigned long high)
> -{
> -	unsigned long batch = max(1UL, high / 4);
> -	if ((high / 4) > (PAGE_SHIFT * 8))
> -		batch = PAGE_SHIFT * 8;
> -
> -	pageset_update(&p->pcp, high, batch);
> -}
> -
>  static void pageset_set_high_and_batch(struct zone *zone,
> -				       struct per_cpu_pageset *pcp)
> +				       struct per_cpu_pageset *p)
>  {
> -	if (percpu_pagelist_fraction)
> -		pageset_set_high(pcp,
> -			(zone_managed_pages(zone) /
> -				percpu_pagelist_fraction));
> -	else
> -		pageset_set_batch(pcp, zone_batchsize(zone));
> +	unsigned long new_high, new_batch;
> +
> +	if (percpu_pagelist_fraction) {
> +		new_high = zone_managed_pages(zone) / percpu_pagelist_fraction;
> +		new_batch = max(1UL, new_high / 4);
> +		if ((new_high / 4) > (PAGE_SHIFT * 8))
> +			new_batch = PAGE_SHIFT * 8;
> +	} else {
> +		new_batch = zone_batchsize(zone);
> +		new_high = 6 * new_batch;
> +		new_batch = max(1UL, 1 * new_batch);
> +	}
> +	pageset_update(&p->pcp, new_high, new_batch);
>  }
>  
>  static void __meminit zone_pageset_init(struct zone *zone, int cpu)
> -- 
> 2.28.0

-- 
Michal Hocko
SUSE Labs
