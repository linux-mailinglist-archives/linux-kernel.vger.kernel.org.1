Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB6D32AF7A0
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 18:58:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbgKKR6s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 12:58:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25100 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726397AbgKKR6r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 12:58:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605117524;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ciK9r023Tpi3UGiTFGhz7IuU3n7JAjfqAod4vSoQAgc=;
        b=aQs65UnD4efgBTujju/DvYeWwNP1L2fnVE6IqAJcUV/Hvu7a//CWVhnXn5GasbH1odd0qN
        B0xShofGOtv7MuAOPXenr8H+E6dIF8AYbKuI5vuI1CJQkLtlGHDi+mfUjnast2s86rHlH6
        f31hIXPu+TFWdFsqhnY7bv9CPzq03Uw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-579-TUhbgmdKPoGL2GAgJjvWGw-1; Wed, 11 Nov 2020 12:58:40 -0500
X-MC-Unique: TUhbgmdKPoGL2GAgJjvWGw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 10D591084D63;
        Wed, 11 Nov 2020 17:58:39 +0000 (UTC)
Received: from [10.36.114.151] (ovpn-114-151.ams2.redhat.com [10.36.114.151])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C80405091D;
        Wed, 11 Nov 2020 17:58:36 +0000 (UTC)
Subject: Re: [PATCH v3 7/7] mm, page_alloc: disable pcplists during memory
 offline
To:     Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Michal Hocko <mhocko@kernel.org>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Oscar Salvador <osalvador@suse.de>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Michal Hocko <mhocko@suse.com>
References: <20201111092812.11329-1-vbabka@suse.cz>
 <20201111092812.11329-8-vbabka@suse.cz>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <6fdaaeeb-154b-5de1-3008-e56a8be53a5a@redhat.com>
Date:   Wed, 11 Nov 2020 18:58:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20201111092812.11329-8-vbabka@suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.11.20 10:28, Vlastimil Babka wrote:
> Memory offlining relies on page isolation to guarantee a forward
> progress because pages cannot be reused while they are isolated. But the
> page isolation itself doesn't prevent from races while freed pages are
> stored on pcp lists and thus can be reused.  This can be worked around by
> repeated draining of pcplists, as done by commit 968318261221
> ("mm/memory_hotplug: drain per-cpu pages again during memory offline").
> 
> David and Michal would prefer that this race was closed in a way that callers
> of page isolation who need stronger guarantees don't need to repeatedly drain.
> David suggested disabling pcplists usage completely during page isolation,
> instead of repeatedly draining them.
> 
> To achieve this without adding special cases in alloc/free fastpath, we can use
> the same approach as boot pagesets - when pcp->high is 0, any pcplist addition
> will be immediately flushed.
> 
> The race can thus be closed by setting pcp->high to 0 and draining pcplists
> once, before calling start_isolate_page_range(). The draining will serialize
> after processes that already disabled interrupts and read the old value of
> pcp->high in free_unref_page_commit(), and processes that have not yet disabled
> interrupts, will observe pcp->high == 0 when they are rescheduled, and skip
> pcplists. This guarantees no stray pages on pcplists in zones where isolation
> happens.
> 
> This patch thus adds zone_pcp_disable() and zone_pcp_enable() functions that
> page isolation users can call before start_isolate_page_range() and after
> unisolating (or offlining) the isolated pages.
> 
> Also, drain_all_pages() is optimized to only execute on cpus where pcplists are
> not empty. The check can however race with a free to pcplist that has not yet
> increased the pcp->count from 0 to 1. Thus make the drain optionally skip the
> racy check and drain on all cpus, and use this option in zone_pcp_disable().
> 
> As we have to avoid external updates to high and batch while pcplists are
> disabled, we take pcp_batch_high_lock in zone_pcp_disable() and release it in
> zone_pcp_enable(). This also synchronizes multiple users of
> zone_pcp_disable()/enable().
> 
> Currently the only user of this functionality is offline_pages().
> 
> Suggested-by: David Hildenbrand <david@redhat.com>
> Suggested-by: Michal Hocko <mhocko@suse.com>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> Reviewed-by: Oscar Salvador <osalvador@suse.de>
> Acked-by: Michal Hocko <mhocko@suse.com>
> ---
>   mm/internal.h       |  2 ++
>   mm/memory_hotplug.c | 28 ++++++++----------
>   mm/page_alloc.c     | 69 +++++++++++++++++++++++++++++++++++----------
>   mm/page_isolation.c |  6 ++--
>   4 files changed, 71 insertions(+), 34 deletions(-)
> 
> diff --git a/mm/internal.h b/mm/internal.h
> index c43ccdddb0f6..2966496680bc 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -201,6 +201,8 @@ extern int user_min_free_kbytes;
>   
>   extern void zone_pcp_update(struct zone *zone);
>   extern void zone_pcp_reset(struct zone *zone);
> +extern void zone_pcp_disable(struct zone *zone);
> +extern void zone_pcp_enable(struct zone *zone);
>   
>   #if defined CONFIG_COMPACTION || defined CONFIG_CMA
>   
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 3c494ab0d075..e0a561c550b3 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -1491,17 +1491,21 @@ int __ref offline_pages(unsigned long start_pfn, unsigned long nr_pages)
>   	}
>   	node = zone_to_nid(zone);
>   
> +	/*
> +	 * Disable pcplists so that page isolation cannot race with freeing
> +	 * in a way that pages from isolated pageblock are left on pcplists.
> +	 */
> +	zone_pcp_disable(zone);
> +
>   	/* set above range as isolated */
>   	ret = start_isolate_page_range(start_pfn, end_pfn,
>   				       MIGRATE_MOVABLE,
>   				       MEMORY_OFFLINE | REPORT_FAILURE);
>   	if (ret) {
>   		reason = "failure to isolate range";
> -		goto failed_removal;
> +		goto failed_removal_pcplists_disabled;
>   	}
>   
> -	drain_all_pages(zone);
> -
>   	arg.start_pfn = start_pfn;
>   	arg.nr_pages = nr_pages;
>   	node_states_check_changes_offline(nr_pages, zone, &arg);
> @@ -1551,20 +1555,8 @@ int __ref offline_pages(unsigned long start_pfn, unsigned long nr_pages)
>   			goto failed_removal_isolated;
>   		}
>   
> -		/*
> -		 * per-cpu pages are drained after start_isolate_page_range, but
> -		 * if there are still pages that are not free, make sure that we
> -		 * drain again, because when we isolated range we might have
> -		 * raced with another thread that was adding pages to pcp list.
> -		 *
> -		 * Forward progress should be still guaranteed because
> -		 * pages on the pcp list can only belong to MOVABLE_ZONE
> -		 * because has_unmovable_pages explicitly checks for
> -		 * PageBuddy on freed pages on other zones.
> -		 */
>   		ret = test_pages_isolated(start_pfn, end_pfn, MEMORY_OFFLINE);
> -		if (ret)
> -			drain_all_pages(zone);
> +

Why two empty lines before the "} while (ret);" ? (unless I'm confused 
while looking at this diff)

[...]

> +void __drain_all_pages(struct zone *zone, bool force_all_cpus)
>   {
>   	int cpu;
>   
> @@ -3076,7 +3069,13 @@ void drain_all_pages(struct zone *zone)
>   		struct zone *z;
>   		bool has_pcps = false;
>   
> -		if (zone) {
> +		if (force_all_cpus) {
> +			/*
> +			 * The pcp.count check is racy, some callers need a
> +			 * guarantee that no cpu is missed.

Why this comment is helpful, it doesn't tell the whole story. Who 
exactly/in which situations?

> +			 */
> +			has_pcps = true;
> +		} else if (zone) {
>   			pcp = per_cpu_ptr(zone->pageset, cpu);
>   			if (pcp->pcp.count)
>   				has_pcps = true;
> @@ -3109,6 +3108,18 @@ void drain_all_pages(struct zone *zone)
>   	mutex_unlock(&pcpu_drain_mutex);
>   }
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

It's still somewhat unclear to me why we don't need "force_all_cpus" 
here. Can you clarify that? (e.g., add a comment somewhere?)

[...]

> +void __zone_set_pageset_high_and_batch(struct zone *zone, unsigned long high,
> +		unsigned long batch)
> +{
> +	struct per_cpu_pageset *p;
> +	int cpu;
> +
> +	for_each_possible_cpu(cpu) {
> +		p = per_cpu_ptr(zone->pageset, cpu);
> +		pageset_update(&p->pcp, high, batch);
> +	}
> +}
> +
>   /*
>    * Calculate and set new high and batch values for all per-cpu pagesets of a
>    * zone, based on the zone's size and the percpu_pagelist_fraction sysctl.
> @@ -6315,8 +6338,6 @@ static void pageset_init(struct per_cpu_pageset *p)
>   static void zone_set_pageset_high_and_batch(struct zone *zone)
>   {
>   	unsigned long new_high, new_batch;
> -	struct per_cpu_pageset *p;
> -	int cpu;
>   
>   	if (percpu_pagelist_fraction) {
>   		new_high = zone_managed_pages(zone) / percpu_pagelist_fraction;
> @@ -6336,10 +6357,7 @@ static void zone_set_pageset_high_and_batch(struct zone *zone)
>   	zone->pageset_high = new_high;
>   	zone->pageset_batch = new_batch;
>   
> -	for_each_possible_cpu(cpu) {
> -		p = per_cpu_ptr(zone->pageset, cpu);
> -		pageset_update(&p->pcp, new_high, new_batch);
> -	}
> +	__zone_set_pageset_high_and_batch(zone, new_high, new_batch);
>   }

These two hunks look like an unrelated cleanup, or am I missing something?

Thanks for looking into this!

-- 
Thanks,

David / dhildenb

