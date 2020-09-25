Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF9B7278558
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 12:46:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728060AbgIYKqj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 06:46:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:54426 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727982AbgIYKqi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 06:46:38 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601030796;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=Hgi+AP8CPgUVCwzhH/QiPnwj64R/2tmrl6b3bpliDVQ=;
        b=fte2sbswoJpFYozQoHP/7NFD/GMtuVWFCHmp3h5ni4jIR+3JWiepxywFacvOM+q0CWirsm
        20RcfHoWvPkCW+KyiV2C31lZ+xEsYg2C0GnFY8P5X6+FQCT13se1lO/oWpqnOJ/O/ZC3kx
        fGwJgY8Ys51ox/HN7SUqp3bnpmNdod8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-588-iK4vulDwOIyr9Lo3i97nNw-1; Fri, 25 Sep 2020 06:46:32 -0400
X-MC-Unique: iK4vulDwOIyr9Lo3i97nNw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 77BEB800E23;
        Fri, 25 Sep 2020 10:46:30 +0000 (UTC)
Received: from [10.36.112.211] (ovpn-112-211.ams2.redhat.com [10.36.112.211])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DC7735D9E2;
        Fri, 25 Sep 2020 10:46:28 +0000 (UTC)
Subject: Re: [PATCH 8/9] mm, page_alloc: drain all pcplists during memory
 offline
To:     Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, Michal Hocko <mhocko@kernel.org>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Oscar Salvador <osalvador@suse.de>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
References: <20200922143712.12048-1-vbabka@suse.cz>
 <20200922143712.12048-9-vbabka@suse.cz>
From:   David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
 WNyWQQ==
Organization: Red Hat GmbH
Message-ID: <a247fc08-d2d8-4f09-88e0-2ebbb5f67890@redhat.com>
Date:   Fri, 25 Sep 2020 12:46:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200922143712.12048-9-vbabka@suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.09.20 16:37, Vlastimil Babka wrote:
> drain_all_pages() is optimized to only execute on cpus where pcplists are not
> empty. The check can however race with a free to pcplist that has not yet
> increased the pcp->count from 0 to 1. Make the drain optionally skip the racy
> check and drain on all cpus, and use it in memory offline context, where we
> want to make sure no isolated pages are left behind on pcplists.
> 
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---
>  include/linux/gfp.h |  1 +
>  mm/memory_hotplug.c |  4 ++--
>  mm/page_alloc.c     | 29 ++++++++++++++++++++---------
>  3 files changed, 23 insertions(+), 11 deletions(-)
> 
> diff --git a/include/linux/gfp.h b/include/linux/gfp.h
> index 67a0774e080b..cc52c5cc9fab 100644
> --- a/include/linux/gfp.h
> +++ b/include/linux/gfp.h
> @@ -592,6 +592,7 @@ extern void page_frag_free(void *addr);
>  
>  void page_alloc_init(void);
>  void drain_zone_pages(struct zone *zone, struct per_cpu_pages *pcp);
> +void __drain_all_pages(struct zone *zone, bool page_isolation);
>  void drain_all_pages(struct zone *zone);
>  void drain_local_pages(struct zone *zone);
>  
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 08f729922e18..bbde415b558b 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -1524,7 +1524,7 @@ int __ref offline_pages(unsigned long start_pfn, unsigned long nr_pages)
>  		goto failed_removal;
>  	}
>  
> -	drain_all_pages(zone);
> +	__drain_all_pages(zone, true);
>  
>  	arg.start_pfn = start_pfn;
>  	arg.nr_pages = nr_pages;
> @@ -1588,7 +1588,7 @@ int __ref offline_pages(unsigned long start_pfn, unsigned long nr_pages)
>  		 */
>  		ret = test_pages_isolated(start_pfn, end_pfn, MEMORY_OFFLINE);
>  		if (ret)
> -			drain_all_pages(zone);
> +			__drain_all_pages(zone, true);
>  	} while (ret);
>  
>  	/* Mark all sections offline and remove free pages from the buddy. */
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 4e37bc3f6077..33cc35d152b1 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -2960,14 +2960,7 @@ static void drain_local_pages_wq(struct work_struct *work)
>  	preempt_enable();
>  }
>  
> -/*
> - * Spill all the per-cpu pages from all CPUs back into the buddy allocator.
> - *
> - * When zone parameter is non-NULL, spill just the single zone's pages.
> - *
> - * Note that this can be extremely slow as the draining happens in a workqueue.
> - */
> -void drain_all_pages(struct zone *zone)
> +void __drain_all_pages(struct zone *zone, bool force_all_cpus)
>  {
>  	int cpu;
>  
> @@ -3006,7 +2999,13 @@ void drain_all_pages(struct zone *zone)
>  		struct zone *z;
>  		bool has_pcps = false;
>  
> -		if (zone) {
> +		if (force_all_cpus) {
> +			/*
> +			 * The pcp.count check is racy, some callers need a
> +			 * guarantee that no cpu is missed.
> +			 */
> +			has_pcps = true;
> +		} else if (zone) {
>  			pcp = per_cpu_ptr(zone->pageset, cpu);
>  			if (pcp->pcp.count)
>  				has_pcps = true;
> @@ -3039,6 +3038,18 @@ void drain_all_pages(struct zone *zone)
>  	mutex_unlock(&pcpu_drain_mutex);
>  }
>  
> +/*
> + * Spill all the per-cpu pages from all CPUs back into the buddy allocator.
> + *
> + * When zone parameter is non-NULL, spill just the single zone's pages.
> + *
> + * Note that this can be extremely slow as the draining happens in a workqueue.
> + */
> +void drain_all_pages(struct zone *zone)
> +{
> +	__drain_all_pages(zone, false);
> +}
> +
>  #ifdef CONFIG_HIBERNATION
>  
>  /*
> 

Interesting race. Instead of this ugly __drain_all_pages() with a
boolean parameter, can we have two properly named functions to be used
in !page_alloc.c code without scratching your head what the difference is?

(yeah, coming up with a proper name is difficult. the one gives more
guarantees than the other, that cannot really be deducted from
"force_all_cpus" - maybe we can encode the actual semantics in the name)


-- 
Thanks,

David / dhildenb

