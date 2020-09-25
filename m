Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 641BC278503
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 12:23:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728077AbgIYKX2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 06:23:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41006 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727132AbgIYKX2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 06:23:28 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601029405;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=V3vaqaIY3rmmgN4JqR75E56kLRzQLKqolgzm9PrIplo=;
        b=OGCNnPVUL/5BuHwGQCxt+4knpLQIxQE0kR7rVIoyR21tT+FhmAsHAi9mntjY76rAXKHNmv
        zX4fpfjXlxBUop5Lf3T+yxoJAVQfJdyXjxzuHnhGBVOXHUZ7ujSiwEW+EJjYsehz0qb2tG
        viE2QuylZUc5J+AlOlt+RJ5YLYJxeZ8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-211-675avHVpP7234P3_DG-bFw-1; Fri, 25 Sep 2020 06:23:24 -0400
X-MC-Unique: 675avHVpP7234P3_DG-bFw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BCF931008558;
        Fri, 25 Sep 2020 10:23:22 +0000 (UTC)
Received: from [10.36.112.211] (ovpn-112-211.ams2.redhat.com [10.36.112.211])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2729C5D9FC;
        Fri, 25 Sep 2020 10:23:20 +0000 (UTC)
Subject: Re: [PATCH 4/9] mm, page_alloc: simplify pageset_update()
To:     Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, Michal Hocko <mhocko@kernel.org>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Oscar Salvador <osalvador@suse.de>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
References: <20200922143712.12048-1-vbabka@suse.cz>
 <20200922143712.12048-5-vbabka@suse.cz>
From:   David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
 WNyWQQ==
Organization: Red Hat GmbH
Message-ID: <96cb97df-fe33-5a99-6618-1560467f8ffa@redhat.com>
Date:   Fri, 25 Sep 2020 12:23:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200922143712.12048-5-vbabka@suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.09.20 16:37, Vlastimil Babka wrote:
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
> 

I *think* this is okay and obviously simplifies things. But to be 100%
sure, I'll have to rely on your judgment :)

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

