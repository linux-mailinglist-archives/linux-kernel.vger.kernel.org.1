Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C8BD278569
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 12:54:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728054AbgIYKyX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 06:54:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:40558 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726990AbgIYKyW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 06:54:22 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601031259;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=BWVDpAeXbkH8Cf7QokeuC6QWApCF0HV+yWAZ5a42RV8=;
        b=gA0sOVrVx4nykAcGT9nMgbBTKQQ9M0TPGHTLXKfsWDjX+MGfUXHhpzxocfABQo699Fk+DQ
        Sy+PibjAwqvI4VCjE8ylMxCGIVeE9HJGuy/mKbbueVbuDMSOjA0YKg63t8Lpp45FdzjFPT
        S8axo+eGGZULMcW7TeDfNzKod6m9VCg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-218-pj0o7H8nOzeKmS0_VcLtGQ-1; Fri, 25 Sep 2020 06:54:15 -0400
X-MC-Unique: pj0o7H8nOzeKmS0_VcLtGQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 62C3C8712FE;
        Fri, 25 Sep 2020 10:54:14 +0000 (UTC)
Received: from [10.36.112.211] (ovpn-112-211.ams2.redhat.com [10.36.112.211])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AC3E35C1C7;
        Fri, 25 Sep 2020 10:54:11 +0000 (UTC)
Subject: Re: [PATCH 9/9] mm, page_alloc: optionally disable pcplists during
 page isolation
From:   David Hildenbrand <david@redhat.com>
To:     Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, Michal Hocko <mhocko@kernel.org>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Oscar Salvador <osalvador@suse.de>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Michal Hocko <mhocko@suse.com>
References: <20200922143712.12048-1-vbabka@suse.cz>
 <20200922143712.12048-10-vbabka@suse.cz>
 <10cdae53-c64b-e371-1b83-01d1af7a131e@redhat.com>
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
 WNyWQQ==
Organization: Red Hat GmbH
Message-ID: <e0ab17e9-6c05-cf32-9e2d-efbf011860a2@redhat.com>
Date:   Fri, 25 Sep 2020 12:54:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <10cdae53-c64b-e371-1b83-01d1af7a131e@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25.09.20 12:53, David Hildenbrand wrote:
> On 22.09.20 16:37, Vlastimil Babka wrote:
>> Page isolation can race with process freeing pages to pcplists in a way that
>> a page from isolated pageblock can end up on pcplist. This can be fixed by
>> repeated draining of pcplists, as done by patch "mm/memory_hotplug: drain
>> per-cpu pages again during memory offline" in [1].
>>
>> David and Michal would prefer that this race was closed in a way that callers
>> of page isolation who need stronger guarantees don't need to repeatedly drain.
>> David suggested disabling pcplists usage completely during page isolation,
>> instead of repeatedly draining them.
>>
>> To achieve this without adding special cases in alloc/free fastpath, we can use
>> the same approach as boot pagesets - when pcp->high is 0, any pcplist addition
>> will be immediately flushed.
>>
>> The race can thus be closed by setting pcp->high to 0 and draining pcplists
>> once, before calling start_isolate_page_range(). The draining will serialize
>> after processes that already disabled interrupts and read the old value of
>> pcp->high in free_unref_page_commit(), and processes that have not yet disabled
>> interrupts, will observe pcp->high == 0 when they are rescheduled, and skip
>> pcplists. This guarantees no stray pages on pcplists in zones where isolation
>> happens.
>>
>> This patch thus adds zone_pcplist_disable() and zone_pcplist_enable() functions
>> that page isolation users can call before start_isolate_page_range() and after
>> unisolating (or offlining) the isolated pages. A new zone->pcplist_disabled
>> atomic variable makes sure we disable only pcplists once and don't enable
>> them prematurely in case there are multiple users in parallel.
>>
>> We however have to avoid external updates to high and batch by taking
>> pcp_batch_high_lock. To allow multiple isolations in parallel, change this lock
>> from mutex to rwsem.
>>
>> Currently the only user of this functionality is offline_pages().
>>
>> [1] https://lore.kernel.org/linux-mm/20200903140032.380431-1-pasha.tatashin@soleen.com/
>>
>> Suggested-by: David Hildenbrand <david@redhat.com>
>> Suggested-by: Michal Hocko <mhocko@suse.com>
>> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
>> ---
>>  include/linux/mmzone.h         |  2 ++
>>  include/linux/page-isolation.h |  2 ++
>>  mm/internal.h                  |  4 ++++
>>  mm/memory_hotplug.c            | 28 ++++++++++++----------------
>>  mm/page_alloc.c                | 29 ++++++++++++++++++-----------
>>  mm/page_isolation.c            | 22 +++++++++++++++++++---
>>  6 files changed, 57 insertions(+), 30 deletions(-)
>>
>> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
>> index 7ad3f14dbe88..3c653d6348b1 100644
>> --- a/include/linux/mmzone.h
>> +++ b/include/linux/mmzone.h
>> @@ -536,6 +536,8 @@ struct zone {
>>  	 * of pageblock. Protected by zone->lock.
>>  	 */
>>  	unsigned long		nr_isolate_pageblock;
>> +	/* Track requests for disabling pcplists */
>> +	atomic_t		pcplist_disabled;
>>  #endif
>>  
>>  #ifdef CONFIG_MEMORY_HOTPLUG
>> diff --git a/include/linux/page-isolation.h b/include/linux/page-isolation.h
>> index 572458016331..1dec5d0f62a6 100644
>> --- a/include/linux/page-isolation.h
>> +++ b/include/linux/page-isolation.h
>> @@ -38,6 +38,8 @@ struct page *has_unmovable_pages(struct zone *zone, struct page *page,
>>  void set_pageblock_migratetype(struct page *page, int migratetype);
>>  int move_freepages_block(struct zone *zone, struct page *page,
>>  				int migratetype, int *num_movable);
>> +void zone_pcplist_disable(struct zone *zone);
>> +void zone_pcplist_enable(struct zone *zone);
>>  
>>  /*
>>   * Changes migrate type in [start_pfn, end_pfn) to be MIGRATE_ISOLATE.
>> diff --git a/mm/internal.h b/mm/internal.h
>> index ea66ef45da6c..154e38e702dd 100644
>> --- a/mm/internal.h
>> +++ b/mm/internal.h
>> @@ -7,6 +7,7 @@
>>  #ifndef __MM_INTERNAL_H
>>  #define __MM_INTERNAL_H
>>  
>> +#include <linux/rwsem.h>
>>  #include <linux/fs.h>
>>  #include <linux/mm.h>
>>  #include <linux/pagemap.h>
>> @@ -199,8 +200,11 @@ extern void post_alloc_hook(struct page *page, unsigned int order,
>>  					gfp_t gfp_flags);
>>  extern int user_min_free_kbytes;
>>  
>> +extern struct rw_semaphore pcp_batch_high_lock;
>>  extern void zone_pcp_update(struct zone *zone);
>>  extern void zone_pcp_reset(struct zone *zone);
>> +extern void zone_update_pageset_high_and_batch(struct zone *zone,
>> +		unsigned long high, unsigned long batch);
>>  
>>  #if defined CONFIG_COMPACTION || defined CONFIG_CMA
>>  
>> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
>> index bbde415b558b..6fe9be550160 100644
>> --- a/mm/memory_hotplug.c
>> +++ b/mm/memory_hotplug.c
>> @@ -1515,17 +1515,21 @@ int __ref offline_pages(unsigned long start_pfn, unsigned long nr_pages)
>>  	}
>>  	node = zone_to_nid(zone);
>>  
>> +	/*
>> +	 * Disable pcplists so that page isolation cannot race with freeing
>> +	 * in a way that pages from isolated pageblock are left on pcplists.
>> +	 */
>> +	zone_pcplist_disable(zone);
>> +
>>  	/* set above range as isolated */
>>  	ret = start_isolate_page_range(start_pfn, end_pfn,
>>  				       MIGRATE_MOVABLE,
>>  				       MEMORY_OFFLINE | REPORT_FAILURE);
>>  	if (ret) {
>>  		reason = "failure to isolate range";
>> -		goto failed_removal;
>> +		goto failed_removal_pcplists_disabled;
>>  	}
>>  
>> -	__drain_all_pages(zone, true);
>> -
>>  	arg.start_pfn = start_pfn;
>>  	arg.nr_pages = nr_pages;
>>  	node_states_check_changes_offline(nr_pages, zone, &arg);
>> @@ -1575,20 +1579,8 @@ int __ref offline_pages(unsigned long start_pfn, unsigned long nr_pages)
>>  			goto failed_removal_isolated;
>>  		}
>>  
>> -		/*
>> -		 * per-cpu pages are drained after start_isolate_page_range, but
>> -		 * if there are still pages that are not free, make sure that we
>> -		 * drain again, because when we isolated range we might have
>> -		 * raced with another thread that was adding pages to pcp list.
>> -		 *
>> -		 * Forward progress should be still guaranteed because
>> -		 * pages on the pcp list can only belong to MOVABLE_ZONE
>> -		 * because has_unmovable_pages explicitly checks for
>> -		 * PageBuddy on freed pages on other zones.
>> -		 */
>>  		ret = test_pages_isolated(start_pfn, end_pfn, MEMORY_OFFLINE);
>> -		if (ret)
>> -			__drain_all_pages(zone, true);
>> +
>>  	} while (ret);
>>  
>>  	/* Mark all sections offline and remove free pages from the buddy. */
>> @@ -1604,6 +1596,8 @@ int __ref offline_pages(unsigned long start_pfn, unsigned long nr_pages)
>>  	zone->nr_isolate_pageblock -= nr_pages / pageblock_nr_pages;
>>  	spin_unlock_irqrestore(&zone->lock, flags);
>>  
>> +	zone_pcplist_enable(zone);
>> +
>>  	/* removal success */
>>  	adjust_managed_page_count(pfn_to_page(start_pfn), -nr_pages);
>>  	zone->present_pages -= nr_pages;
>> @@ -1637,6 +1631,8 @@ int __ref offline_pages(unsigned long start_pfn, unsigned long nr_pages)
>>  failed_removal_isolated:
>>  	undo_isolate_page_range(start_pfn, end_pfn, MIGRATE_MOVABLE);
>>  	memory_notify(MEM_CANCEL_OFFLINE, &arg);
>> +failed_removal_pcplists_disabled:
>> +	zone_pcplist_enable(zone);
>>  failed_removal:
>>  	pr_debug("memory offlining [mem %#010llx-%#010llx] failed due to %s\n",
>>  		 (unsigned long long) start_pfn << PAGE_SHIFT,
>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>> index 33cc35d152b1..673d353f9311 100644
>> --- a/mm/page_alloc.c
>> +++ b/mm/page_alloc.c
>> @@ -78,7 +78,7 @@
>>  #include "page_reporting.h"
>>  
>>  /* prevent >1 _updater_ of zone percpu pageset ->high and ->batch fields */
>> -static DEFINE_MUTEX(pcp_batch_high_lock);
>> +DECLARE_RWSEM(pcp_batch_high_lock);
>>  #define MIN_PERCPU_PAGELIST_FRACTION	(8)
>>  
>>  #ifdef CONFIG_USE_PERCPU_NUMA_NODE_ID
>> @@ -6230,6 +6230,18 @@ static void pageset_init(struct per_cpu_pageset *p)
>>  	pcp->batch = BOOT_PAGESET_BATCH;
>>  }
>>  
>> +void zone_update_pageset_high_and_batch(struct zone *zone, unsigned long high,
>> +		unsigned long batch)
>> +{
>> +	struct per_cpu_pageset *p;
>> +	int cpu;
>> +
>> +	for_each_possible_cpu(cpu) {
>> +		p = per_cpu_ptr(zone->pageset, cpu);
>> +		pageset_update(&p->pcp, high, batch);
>> +	}
>> +}
>> +
>>  /*
>>   * Calculate and set new high and batch values for all per-cpu pagesets of a
>>   * zone, based on the zone's size and the percpu_pagelist_fraction sysctl.
>> @@ -6237,8 +6249,6 @@ static void pageset_init(struct per_cpu_pageset *p)
>>  static void zone_set_pageset_high_and_batch(struct zone *zone)
>>  {
>>  	unsigned long new_high, new_batch;
>> -	struct per_cpu_pageset *p;
>> -	int cpu;
>>  
>>  	if (percpu_pagelist_fraction) {
>>  		new_high = zone_managed_pages(zone) / percpu_pagelist_fraction;
>> @@ -6259,10 +6269,7 @@ static void zone_set_pageset_high_and_batch(struct zone *zone)
>>  		return;
>>  	}
>>  
>> -	for_each_possible_cpu(cpu) {
>> -		p = per_cpu_ptr(zone->pageset, cpu);
>> -		pageset_update(&p->pcp, new_high, new_batch);
>> -	}
>> +	zone_update_pageset_high_and_batch(zone, new_high, new_batch);
>>  }
>>  
>>  void __meminit setup_zone_pageset(struct zone *zone)
>> @@ -8024,7 +8031,7 @@ int percpu_pagelist_fraction_sysctl_handler(struct ctl_table *table, int write,
>>  	int old_percpu_pagelist_fraction;
>>  	int ret;
>>  
>> -	mutex_lock(&pcp_batch_high_lock);
>> +	down_write(&pcp_batch_high_lock);
>>  	old_percpu_pagelist_fraction = percpu_pagelist_fraction;
>>  
>>  	ret = proc_dointvec_minmax(table, write, buffer, length, ppos);
>> @@ -8046,7 +8053,7 @@ int percpu_pagelist_fraction_sysctl_handler(struct ctl_table *table, int write,
>>  	for_each_populated_zone(zone)
>>  		zone_set_pageset_high_and_batch(zone);
>>  out:
>> -	mutex_unlock(&pcp_batch_high_lock);
>> +	up_write(&pcp_batch_high_lock);
>>  	return ret;
>>  }
>>  
>> @@ -8652,9 +8659,9 @@ EXPORT_SYMBOL(free_contig_range);
>>   */
>>  void __meminit zone_pcp_update(struct zone *zone)
>>  {
>> -	mutex_lock(&pcp_batch_high_lock);
>> +	down_write(&pcp_batch_high_lock);
>>  	zone_set_pageset_high_and_batch(zone);
>> -	mutex_unlock(&pcp_batch_high_lock);
>> +	up_write(&pcp_batch_high_lock);
>>  }
>>  
>>  void zone_pcp_reset(struct zone *zone)
>> diff --git a/mm/page_isolation.c b/mm/page_isolation.c
>> index 57d8bc1e7760..c0e895e8f322 100644
>> --- a/mm/page_isolation.c
>> +++ b/mm/page_isolation.c
>> @@ -15,6 +15,22 @@
>>  #define CREATE_TRACE_POINTS
>>  #include <trace/events/page_isolation.h>
>>  
>> +void zone_pcplist_disable(struct zone *zone)
>> +{
>> +	down_read(&pcp_batch_high_lock);
>> +	if (atomic_inc_return(&zone->pcplist_disabled) == 1) {
>> +		zone_update_pageset_high_and_batch(zone, 0, 1);
>> +		__drain_all_pages(zone, true);
>> +	}
> 
> Hm, if one CPU is still inside the if-clause, the other one would
> continue, however pcp wpould not be disabled and zones not drained when
> returning.
> 
> (while we only allow a single Offline_pages() call, it will be different
> when we use the function in other context - especially,
> alloc_contig_range() for some users)
> 
> Can't we use down_write() here? So it's serialized and everybody has to
> properly wait. (and we would not have to rely on an atomic_t)

Sorry, I meant down_write only temporarily in this code path. Not
keeping it locked in write when returning (I remember there is a way to
downgrade).


-- 
Thanks,

David / dhildenb

