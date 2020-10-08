Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 558462873F4
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 14:23:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729793AbgJHMXM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 08:23:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:58702 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729722AbgJHMXM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 08:23:12 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1602159790;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TtXgBFrg0rFqKIY1cOlrbxSoEXaREYSY+5dIWTCP/uM=;
        b=T+nFtKLTGTJrJBoydciXFCQzl450l+Ulqo4gBD9IFFKY4UF184At1sa+KdiPJi6sct3ZDq
        iYaRmD2G1RICLXNumJD3jdjbkiH8z2tfORxxZ4nefA0qvJ4Ir9aXWzHObcHsDSjbK1t1Fa
        aEakux03USysNhD4nyySam+UyYWgP3A=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A5E92AEF8;
        Thu,  8 Oct 2020 12:23:10 +0000 (UTC)
Date:   Thu, 8 Oct 2020 14:23:09 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Subject: Re: [PATCH v2 3/7] mm, page_alloc: remove setup_pageset()
Message-ID: <20201008122309.GB4967@dhcp22.suse.cz>
References: <20201008114201.18824-1-vbabka@suse.cz>
 <20201008114201.18824-4-vbabka@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201008114201.18824-4-vbabka@suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 08-10-20 13:41:57, Vlastimil Babka wrote:
> We initialize boot-time pagesets with setup_pageset(), which sets high and
> batch values that effectively disable pcplists.
> 
> We can remove this wrapper if we just set these values for all pagesets in
> pageset_init(). Non-boot pagesets then subsequently update them to the proper
> values.
> 
> No functional change.
> 
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> Reviewed-by: David Hildenbrand <david@redhat.com>

Acked-by: Michal Hocko <mhocko@suse.com>

Btw. where do we initialize pcp->count? I thought that pcp allocator
zeroes out the allocated memory but alloc_percpu is GFP_KERNEL like.

> ---
>  mm/page_alloc.c | 17 ++++++++++-------
>  1 file changed, 10 insertions(+), 7 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 463f40b12aca..f827b42a2475 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -5899,7 +5899,7 @@ static void build_zonelists(pg_data_t *pgdat)
>   * not check if the processor is online before following the pageset pointer.
>   * Other parts of the kernel may not check if the zone is available.
>   */
> -static void setup_pageset(struct per_cpu_pageset *p);
> +static void pageset_init(struct per_cpu_pageset *p);
>  static DEFINE_PER_CPU(struct per_cpu_pageset, boot_pageset);
>  static DEFINE_PER_CPU(struct per_cpu_nodestat, boot_nodestats);
>  
> @@ -5967,7 +5967,7 @@ build_all_zonelists_init(void)
>  	 * (a chicken-egg dilemma).
>  	 */
>  	for_each_possible_cpu(cpu)
> -		setup_pageset(&per_cpu(boot_pageset, cpu));
> +		pageset_init(&per_cpu(boot_pageset, cpu));
>  
>  	mminit_verify_zonelist();
>  	cpuset_init_current_mems_allowed();
> @@ -6286,12 +6286,15 @@ static void pageset_init(struct per_cpu_pageset *p)
>  	pcp = &p->pcp;
>  	for (migratetype = 0; migratetype < MIGRATE_PCPTYPES; migratetype++)
>  		INIT_LIST_HEAD(&pcp->lists[migratetype]);
> -}
>  
> -static void setup_pageset(struct per_cpu_pageset *p)
> -{
> -	pageset_init(p);
> -	pageset_update(&p->pcp, 0, 1);
> +	/*
> +	 * Set batch and high values safe for a boot pageset. A true percpu
> +	 * pageset's initialization will update them subsequently. Here we don't
> +	 * need to be as careful as pageset_update() as nobody can access the
> +	 * pageset yet.
> +	 */
> +	pcp->high = 0;
> +	pcp->batch = 1;
>  }
>  
>  /*
> -- 
> 2.28.0

-- 
Michal Hocko
SUSE Labs
