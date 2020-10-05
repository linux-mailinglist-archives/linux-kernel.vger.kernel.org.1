Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7EEB283677
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 15:24:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726073AbgJENYs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 09:24:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:47104 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725931AbgJENYr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 09:24:47 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1601904286;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AxNmOxhloOkNLG5z3f4ksZwozQa5YHSZyRWOBA5+GD8=;
        b=XFAbO+ue/U0zs1Ggm0iNU7hZ4STznQoWd9hsElmUP60R2/UXDsq3r6mltEelEZE6WKPuTR
        hpcYRmIoEJ4+aOZzkeupC4X20tdqsXQg+4QmCLSRziv1NyAze5n1+3yqDxMoh7z3c3QSD8
        mMqdAsYiFxRL7biwarHNPzwvhORlQsM=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 10BB6ADE4;
        Mon,  5 Oct 2020 13:24:46 +0000 (UTC)
Date:   Mon, 5 Oct 2020 15:24:45 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Subject: Re: [PATCH 5/9] mm, page_alloc: make per_cpu_pageset accessible only
 after init
Message-ID: <20201005132445.GA4555@dhcp22.suse.cz>
References: <20200922143712.12048-1-vbabka@suse.cz>
 <20200922143712.12048-6-vbabka@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200922143712.12048-6-vbabka@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 22-09-20 16:37:08, Vlastimil Babka wrote:
> setup_zone_pageset() replaces the boot_pageset by allocating and initializing a
> proper percpu one. Currently it assigns zone->pageset with the newly allocated
> one before initializing it. That's currently not an issue, because the zone
> should not be in any zonelist, thus not visible to allocators at this point.
> 
> Memory ordering between the pcplist contents and its visibility is also not
> guaranteed here, but that also shouldn't be an issue because online_pages()
> does a spin_unlock(pgdat->node_size_lock) before building the zonelists.
> 
> However it's best that we don't silently rely on operations that can be changed
> in the future. Make sure only properly initialized pcplists are visible, using
> smp_store_release(). The read side has a data dependency via the zone->pageset
> pointer instead of an explicit read barrier.

Heh, this looks like inveting a similar trap the previous patch was
removing. But more seriously considering that we need a locking for the
whole setup, wouldn't it be better to simply document the locking
requirements rather than adding scary looking barriers future ourselves
or somebody else will need to scratch heads about. I am pretty sure we
don't do anything like that when initializating numa node or other data
structures that might be allocated during the memory hotadd.

> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---
>  mm/page_alloc.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 99b74c1c2b0a..de3b48bda45c 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -6246,15 +6246,17 @@ static void zone_set_pageset_high_and_batch(struct zone *zone)
>  
>  void __meminit setup_zone_pageset(struct zone *zone)
>  {
> +	struct per_cpu_pageset __percpu * new_pageset;
>  	struct per_cpu_pageset *p;
>  	int cpu;
>  
> -	zone->pageset = alloc_percpu(struct per_cpu_pageset);
> +	new_pageset = alloc_percpu(struct per_cpu_pageset);
>  	for_each_possible_cpu(cpu) {
> -		p = per_cpu_ptr(zone->pageset, cpu);
> +		p = per_cpu_ptr(new_pageset, cpu);
>  		pageset_init(p);
>  	}
>  
> +	smp_store_release(&zone->pageset, new_pageset);
>  	zone_set_pageset_high_and_batch(zone);
>  }
>  
> -- 
> 2.28.0

-- 
Michal Hocko
SUSE Labs
