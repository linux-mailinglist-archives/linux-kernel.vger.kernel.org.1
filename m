Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8003B28366B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 15:20:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725995AbgJENUK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 09:20:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:41586 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725936AbgJENUJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 09:20:09 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1601904008;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5/nnJfNVwNyk0HQNwQ3EoUiunupQjmv9k+ikLi3sGG4=;
        b=oh+4QO0b2Z0PlCmKdptZI3ACUrScrT85BThm+6R9qbfaEiEY+ACl5FlpqgD/XcNYCEA0y9
        ByDsq5VG96YY1zTSpqvZ2QoBe1qi7uHobgihwoxP5iuQS0cotfqctF3Z7gdG50Ls7648+3
        lLFrSud2cUrzKOJFEXIyRrP+vJWjeuU=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 20126AC65;
        Mon,  5 Oct 2020 13:20:08 +0000 (UTC)
Date:   Mon, 5 Oct 2020 15:20:06 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Subject: Re: [PATCH 4/9] mm, page_alloc: simplify pageset_update()
Message-ID: <20201005132006.GZ4555@dhcp22.suse.cz>
References: <20200922143712.12048-1-vbabka@suse.cz>
 <20200922143712.12048-5-vbabka@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200922143712.12048-5-vbabka@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 22-09-20 16:37:07, Vlastimil Babka wrote:
> pageset_update() attempts to update pcplist's high and batch values in a way
> that readers don't observe batch > high. It uses smp_wmb() to order the updates
> in a way to achieve this. However, without proper pairing read barriers in
> readers this guarantee doesn't hold, and there are no such barriers in
> e.g. free_unref_page_commit().
> 
> Commit 88e8ac11d2ea ("mm, page_alloc: fix core hung in free_pcppages_bulk()")
> already showed this is problematic, and solved this by ultimately only trusing
> pcp->count of the current cpu with interrupts disabled.
> 
> The update dance with unpaired write barriers thus makes no sense. Replace
> them with plain WRITE_ONCE to prevent store tearing, and document that the
> values can change asynchronously and should not be trusted for correctness.
> 
> All current readers appear to be OK after 88e8ac11d2ea. Convert them to
> READ_ONCE to prevent unnecessary read tearing, but mainly to alert anybody
> making future changes to the code that special care is needed.
> 
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>

Yes, this should be safe AFAICS. I believe the original intention was
well minded but didn't go all the way to do the thing properly.

I have to admit I have stumbled over this weirdness few times and never
found enough motivation to think that through.

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  mm/page_alloc.c | 40 ++++++++++++++++++----------------------
>  1 file changed, 18 insertions(+), 22 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 76c2b4578723..99b74c1c2b0a 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -1297,7 +1297,7 @@ static void free_pcppages_bulk(struct zone *zone, int count,
>  {
>  	int migratetype = 0;
>  	int batch_free = 0;
> -	int prefetch_nr = 0;
> +	int prefetch_nr = READ_ONCE(pcp->batch);
>  	bool isolated_pageblocks;
>  	struct page *page, *tmp;
>  	LIST_HEAD(head);
> @@ -1348,8 +1348,10 @@ static void free_pcppages_bulk(struct zone *zone, int count,
>  			 * avoid excessive prefetching due to large count, only
>  			 * prefetch buddy for the first pcp->batch nr of pages.
>  			 */
> -			if (prefetch_nr++ < pcp->batch)
> +			if (prefetch_nr) {
>  				prefetch_buddy(page);
> +				prefetch_nr--;
> +			}
>  		} while (--count && --batch_free && !list_empty(list));
>  	}
>  
> @@ -3131,10 +3133,8 @@ static void free_unref_page_commit(struct page *page, unsigned long pfn)
>  	pcp = &this_cpu_ptr(zone->pageset)->pcp;
>  	list_add(&page->lru, &pcp->lists[migratetype]);
>  	pcp->count++;
> -	if (pcp->count >= pcp->high) {
> -		unsigned long batch = READ_ONCE(pcp->batch);
> -		free_pcppages_bulk(zone, batch, pcp);
> -	}
> +	if (pcp->count >= READ_ONCE(pcp->high))
> +		free_pcppages_bulk(zone, READ_ONCE(pcp->batch), pcp);
>  }
>  
>  /*
> @@ -3318,7 +3318,7 @@ static struct page *__rmqueue_pcplist(struct zone *zone, int migratetype,
>  	do {
>  		if (list_empty(list)) {
>  			pcp->count += rmqueue_bulk(zone, 0,
> -					pcp->batch, list,
> +					READ_ONCE(pcp->batch), list,
>  					migratetype, alloc_flags);
>  			if (unlikely(list_empty(list)))
>  				return NULL;
> @@ -6174,13 +6174,16 @@ static int zone_batchsize(struct zone *zone)
>  }
>  
>  /*
> - * pcp->high and pcp->batch values are related and dependent on one another:
> - * ->batch must never be higher then ->high.
> - * The following function updates them in a safe manner without read side
> - * locking.
> + * pcp->high and pcp->batch values are related and generally batch is lower
> + * than high. They are also related to pcp->count such that count is lower
> + * than high, and as soon as it reaches high, the pcplist is flushed.
>   *
> - * Any new users of pcp->batch and pcp->high should ensure they can cope with
> - * those fields changing asynchronously (acording to the above rule).
> + * However, guaranteeing these relations at all times would require e.g. write
> + * barriers here but also careful usage of read barriers at the read side, and
> + * thus be prone to error and bad for performance. Thus the update only prevents
> + * store tearing. Any new users of pcp->batch and pcp->high should ensure they
> + * can cope with those fields changing asynchronously, and fully trust only the
> + * pcp->count field on the local CPU with interrupts disabled.
>   *
>   * mutex_is_locked(&pcp_batch_high_lock) required when calling this function
>   * outside of boot time (or some other assurance that no concurrent updaters
> @@ -6189,15 +6192,8 @@ static int zone_batchsize(struct zone *zone)
>  static void pageset_update(struct per_cpu_pages *pcp, unsigned long high,
>  		unsigned long batch)
>  {
> -       /* start with a fail safe value for batch */
> -	pcp->batch = 1;
> -	smp_wmb();
> -
> -       /* Update high, then batch, in order */
> -	pcp->high = high;
> -	smp_wmb();
> -
> -	pcp->batch = batch;
> +	WRITE_ONCE(pcp->batch, batch);
> +	WRITE_ONCE(pcp->high, high);
>  }
>  
>  static void pageset_init(struct per_cpu_pageset *p)
> -- 
> 2.28.0

-- 
Michal Hocko
SUSE Labs
