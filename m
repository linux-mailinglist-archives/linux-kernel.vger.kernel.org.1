Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92F9028742B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 14:31:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729839AbgJHMbc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 08:31:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:36186 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725802AbgJHMbc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 08:31:32 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1602160290;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FwgNglZThh7lrmJ3c8RyrDNvU40KcuzQSeo+eyxxFKk=;
        b=CU7RpW+HXaWSu7xYGXTNXLQjGsPo1ECkhd1AC4t0R8JBDuugM4O7E2Q7T1VHG4eJEkvnfr
        5+d9NAuXLWL9PtDVhnwUSJN6WyynG2kfcftUamJC6hT+kgDWCyn3PgM7olslF8HdS4DMOG
        QsWlr2sAU09nuL5m3g3LFkuHd2CU1EQ=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 13EA9AEF8;
        Thu,  8 Oct 2020 12:31:30 +0000 (UTC)
Date:   Thu, 8 Oct 2020 14:31:29 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Subject: Re: [PATCH v2 5/7] mm, page_alloc: cache pageset high and batch in
 struct zone
Message-ID: <20201008123129.GC4967@dhcp22.suse.cz>
References: <20201008114201.18824-1-vbabka@suse.cz>
 <20201008114201.18824-6-vbabka@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201008114201.18824-6-vbabka@suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 08-10-20 13:41:59, Vlastimil Babka wrote:
> All per-cpu pagesets for a zone use the same high and batch values, that are
> duplicated there just for performance (locality) reasons. This patch adds the
> same variables also to struct zone as a shared copy.
> 
> This will be useful later for making possible to disable pcplists temporarily
> by setting high value to 0, while remembering the values for restoring them
> later. But we can also immediately benefit from not updating pagesets of all
> possible cpus in case the newly recalculated values (after sysctl change or
> memory online/offline) are actually unchanged from the previous ones.
> 
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>

Acked-by: Michal Hocko <mhocko@suse.com>

I would consider the check flipped with early return more pleasing to my
eyes but nothing to lose sleep over.

> ---
>  include/linux/mmzone.h |  6 ++++++
>  mm/page_alloc.c        | 17 +++++++++++++++--
>  2 files changed, 21 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index fb3bf696c05e..c63863794afc 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -470,6 +470,12 @@ struct zone {
>  #endif
>  	struct pglist_data	*zone_pgdat;
>  	struct per_cpu_pageset __percpu *pageset;
> +	/*
> +	 * the high and batch values are copied to individual pagesets for
> +	 * faster access
> +	 */
> +	int pageset_high;
> +	int pageset_batch;
>  
>  #ifndef CONFIG_SPARSEMEM
>  	/*
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index f33c36312eb5..5b98dd5ab006 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -5900,6 +5900,9 @@ static void build_zonelists(pg_data_t *pgdat)
>   * Other parts of the kernel may not check if the zone is available.
>   */
>  static void pageset_init(struct per_cpu_pageset *p);
> +/* These effectively disable the pcplists in the boot pageset completely */
> +#define BOOT_PAGESET_HIGH	0
> +#define BOOT_PAGESET_BATCH	1
>  static DEFINE_PER_CPU(struct per_cpu_pageset, boot_pageset);
>  static DEFINE_PER_CPU(struct per_cpu_nodestat, boot_nodestats);
>  
> @@ -6289,8 +6292,8 @@ static void pageset_init(struct per_cpu_pageset *p)
>  	 * need to be as careful as pageset_update() as nobody can access the
>  	 * pageset yet.
>  	 */
> -	pcp->high = 0;
> -	pcp->batch = 1;
> +	pcp->high = BOOT_PAGESET_HIGH;
> +	pcp->batch = BOOT_PAGESET_BATCH;
>  }
>  
>  /*
> @@ -6314,6 +6317,14 @@ static void zone_set_pageset_high_and_batch(struct zone *zone)
>  		new_batch = max(1UL, 1 * new_batch);
>  	}
>  
> +	if (zone->pageset_high != new_high ||
> +	    zone->pageset_batch != new_batch) {
> +		zone->pageset_high = new_high;
> +		zone->pageset_batch = new_batch;
> +	} else {
> +		return;
> +	}
> +
>  	for_each_possible_cpu(cpu) {
>  		p = per_cpu_ptr(zone->pageset, cpu);
>  		pageset_update(&p->pcp, new_high, new_batch);
> @@ -6374,6 +6385,8 @@ static __meminit void zone_pcp_init(struct zone *zone)
>  	 * offset of a (static) per cpu variable into the per cpu area.
>  	 */
>  	zone->pageset = &boot_pageset;
> +	zone->pageset_high = BOOT_PAGESET_HIGH;
> +	zone->pageset_batch = BOOT_PAGESET_BATCH;
>  
>  	if (populated_zone(zone))
>  		printk(KERN_DEBUG "  %s zone: %lu pages, LIFO batch:%u\n",
> -- 
> 2.28.0

-- 
Michal Hocko
SUSE Labs
