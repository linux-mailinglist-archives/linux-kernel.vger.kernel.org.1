Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E337C283680
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 15:28:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726018AbgJEN2f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 09:28:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:50568 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725914AbgJEN2f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 09:28:35 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1601904513;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IPqPNbDqClbP8EksYsOoKg3cRZhaMTz9vJe273I/bK0=;
        b=krA5UWKlDkZ8d6gQzz6GVnSDlOTpq8O4pe01xbORAvttEp0Gzw71JSEInos1S4atPTME/n
        9Y0tAZeKgGDZ+xA6yFopD4TuC79/IY3EgltPVyucHOz7CTngy7EFAGNe/hQLrvZ+CXWO7F
        SDn0q2jTm7UQh+npH5kFG/M490rvevU=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 70346ACD8;
        Mon,  5 Oct 2020 13:28:33 +0000 (UTC)
Date:   Mon, 5 Oct 2020 15:28:30 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Subject: Re: [PATCH 6/9] mm, page_alloc: cache pageset high and batch in
 struct zone
Message-ID: <20201005132830.GB4555@dhcp22.suse.cz>
References: <20200922143712.12048-1-vbabka@suse.cz>
 <20200922143712.12048-7-vbabka@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200922143712.12048-7-vbabka@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 22-09-20 16:37:09, Vlastimil Babka wrote:
> All per-cpu pagesets for a zone use the same high and batch values, that are
> duplicated there just for performance (locality) reasons. This patch adds the
> same variables also to struct zone as a shared copy.
> 
> This will be useful later for making possible to disable pcplists temporarily
> by setting high value to 0, while remembering the values for restoring them
> later. But we can also immediately benefit from not updating pagesets of all
> possible cpus in case the newly recalculated values (after sysctl change or
> memory online/offline) are actually unchanged from the previous ones.

Advantage of this patch is not really clear from it in isolation. Maybe
merge it with the patch which uses the duplicated state.

> 
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---
>  include/linux/mmzone.h |  6 ++++++
>  mm/page_alloc.c        | 16 ++++++++++++++--
>  2 files changed, 20 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index 90721f3156bc..7ad3f14dbe88 100644
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
> index de3b48bda45c..901907799bdc 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -5824,6 +5824,8 @@ static void build_zonelists(pg_data_t *pgdat)
>   * Other parts of the kernel may not check if the zone is available.
>   */
>  static void pageset_init(struct per_cpu_pageset *p);
> +#define BOOT_PAGESET_HIGH	0
> +#define BOOT_PAGESET_BATCH	1
>  static DEFINE_PER_CPU(struct per_cpu_pageset, boot_pageset);
>  static DEFINE_PER_CPU(struct per_cpu_nodestat, boot_nodestats);
>  
> @@ -6213,8 +6215,8 @@ static void pageset_init(struct per_cpu_pageset *p)
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
> @@ -6238,6 +6240,14 @@ static void zone_set_pageset_high_and_batch(struct zone *zone)
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
> @@ -6300,6 +6310,8 @@ static __meminit void zone_pcp_init(struct zone *zone)
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
