Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92A7027854B
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 12:40:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727960AbgIYKj6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 06:39:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41409 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726255AbgIYKj6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 06:39:58 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601030395;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=vMVsKW7sU+vSMwHsDegqCNvzVlAjtKeJ6U7JK1ER05s=;
        b=d7ORzU8p2EE4y6ZgH56V8au1RuDz59eJGH4OvAKPAbgOS4xNh/xT6yIoxpMynHZEJCQ8Sb
        YSoo82h1vWr2GjslUtyn3pS/QF+PbEA4UR08k0gQPgKbtcXak+wOxIwee/kY7FybiG0LIw
        tuCpcSkf/sMeT6x6jBRZHhQoXIZNFgo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-205-U8kmAIcDON2MDJw36pfrZg-1; Fri, 25 Sep 2020 06:39:52 -0400
X-MC-Unique: U8kmAIcDON2MDJw36pfrZg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A2FE11091066;
        Fri, 25 Sep 2020 10:39:50 +0000 (UTC)
Received: from [10.36.112.211] (ovpn-112-211.ams2.redhat.com [10.36.112.211])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0EA5C73667;
        Fri, 25 Sep 2020 10:39:47 +0000 (UTC)
Subject: Re: [PATCH 7/9] mm, page_alloc: move draining pcplists to page
 isolation users
To:     Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, Michal Hocko <mhocko@kernel.org>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Oscar Salvador <osalvador@suse.de>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
References: <20200922143712.12048-1-vbabka@suse.cz>
 <20200922143712.12048-8-vbabka@suse.cz>
From:   David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
 WNyWQQ==
Organization: Red Hat GmbH
Message-ID: <678262d6-cb82-d78c-9738-db70ab01f6de@redhat.com>
Date:   Fri, 25 Sep 2020 12:39:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200922143712.12048-8-vbabka@suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.09.20 16:37, Vlastimil Babka wrote:
> Currently, pcplists are drained during set_migratetype_isolate() which means
> once per pageblock processed start_isolate_page_range(). This is somewhat
> wasteful. Moreover, the callers might need different guarantees, and the
> draining is currently prone to races and does not guarantee that no page
> from isolated pageblock will end up on the pcplist after the drain.
> 
> Better guarantees are added by later patches and require explicit actions
> by page isolation users that need them. Thus it makes sense to move the
> current imperfect draining to the callers also as a preparation step.
> 
> Suggested-by: Pavel Tatashin <pasha.tatashin@soleen.com>

I would have guessed I suggested that one first as well :)

https://lkml.kernel.org/r/6ec66eb9-eeba-5076-af97-cef59ed5cbaa@redhat.com

(But honestly, I don't care :), just stumbled over it)

> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---
>  mm/memory_hotplug.c | 11 ++++++-----
>  mm/page_alloc.c     |  2 ++
>  mm/page_isolation.c | 10 +++++-----
>  3 files changed, 13 insertions(+), 10 deletions(-)
> 
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 9db80ee29caa..08f729922e18 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -1524,6 +1524,8 @@ int __ref offline_pages(unsigned long start_pfn, unsigned long nr_pages)
>  		goto failed_removal;
>  	}
>  
> +	drain_all_pages(zone);
> +
>  	arg.start_pfn = start_pfn;
>  	arg.nr_pages = nr_pages;
>  	node_states_check_changes_offline(nr_pages, zone, &arg);
> @@ -1574,11 +1576,10 @@ int __ref offline_pages(unsigned long start_pfn, unsigned long nr_pages)
>  		}
>  
>  		/*
> -		 * per-cpu pages are drained in start_isolate_page_range, but if
> -		 * there are still pages that are not free, make sure that we
> -		 * drain again, because when we isolated range we might
> -		 * have raced with another thread that was adding pages to pcp
> -		 * list.
> +		 * per-cpu pages are drained after start_isolate_page_range, but
> +		 * if there are still pages that are not free, make sure that we
> +		 * drain again, because when we isolated range we might have
> +		 * raced with another thread that was adding pages to pcp list.
>  		 *
>  		 * Forward progress should be still guaranteed because
>  		 * pages on the pcp list can only belong to MOVABLE_ZONE
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 901907799bdc..4e37bc3f6077 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -8432,6 +8432,8 @@ int alloc_contig_range(unsigned long start, unsigned long end,
>  	if (ret)
>  		return ret;
>  
> +	drain_all_pages(cc.zone);
> +
>  	/*
>  	 * In case of -EBUSY, we'd like to know which page causes problem.
>  	 * So, just fall through. test_pages_isolated() has a tracepoint
> diff --git a/mm/page_isolation.c b/mm/page_isolation.c
> index abfe26ad59fd..57d8bc1e7760 100644
> --- a/mm/page_isolation.c
> +++ b/mm/page_isolation.c
> @@ -49,7 +49,6 @@ static int set_migratetype_isolate(struct page *page, int migratetype, int isol_
>  
>  		__mod_zone_freepage_state(zone, -nr_pages, mt);
>  		spin_unlock_irqrestore(&zone->lock, flags);
> -		drain_all_pages(zone);
>  		return 0;
>  	}
>  
> @@ -167,11 +166,12 @@ __first_valid_page(unsigned long pfn, unsigned long nr_pages)
>   *
>   * Please note that there is no strong synchronization with the page allocator
>   * either. Pages might be freed while their page blocks are marked ISOLATED.
> - * In some cases pages might still end up on pcp lists and that would allow
> + * A call to drain_all_pages() after isolation can flush most of them. However
> + * in some cases pages might still end up on pcp lists and that would allow
>   * for their allocation even when they are in fact isolated already. Depending
> - * on how strong of a guarantee the caller needs drain_all_pages might be needed
> - * (e.g. __offline_pages will need to call it after check for isolated range for
> - * a next retry).
> + * on how strong of a guarantee the caller needs, further drain_all_pages()
> + * might be needed (e.g. __offline_pages will need to call it after check for
> + * isolated range for a next retry).
>   *
>   * Return: 0 on success and -EBUSY if any part of range cannot be isolated.
>   */
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

