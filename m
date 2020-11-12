Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B14472B0991
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 17:09:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728890AbgKLQJ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 11:09:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43690 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728599AbgKLQJV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 11:09:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605197360;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2jKkxUNBVBuz7hz3sv4q6pZ/I/3BwEfzsjfdJ4qFdKk=;
        b=NwxzmoHEb3ir6gzLaVTZl1B0kT9Q3XQSNCbmaZzJinbZ4Krvy4XR0I6IBjLTBWxGfcE1ST
        fTzPcmtBYBUFM0L4HWnnT5i6SNLK34qozfLkk2O2snqYol7apdxltMdWgAhD8yzy7lvOSc
        wrwQA9y3va6Hjtq5kIyEksUVk7RE0Ak=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-529-yBHZQpSQM8yPvpsCQKSibg-1; Thu, 12 Nov 2020 11:09:16 -0500
X-MC-Unique: yBHZQpSQM8yPvpsCQKSibg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 33151D8EEB;
        Thu, 12 Nov 2020 16:09:10 +0000 (UTC)
Received: from [10.36.115.61] (ovpn-115-61.ams2.redhat.com [10.36.115.61])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0A7C755778;
        Thu, 12 Nov 2020 16:09:07 +0000 (UTC)
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
 <6fdaaeeb-154b-5de1-3008-e56a8be53a5a@redhat.com>
 <527480ef-ed72-e1c1-52a0-1c5b0113df45@suse.cz>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <36fbd86a-dd1b-70eb-9372-7523b65d1e72@redhat.com>
Date:   Thu, 12 Nov 2020 17:09:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <527480ef-ed72-e1c1-52a0-1c5b0113df45@suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12.11.20 16:18, Vlastimil Babka wrote:
> On 11/11/20 6:58 PM, David Hildenbrand wrote:
>> On 11.11.20 10:28, Vlastimil Babka wrote:
>>> -		/*
>>> -		 * per-cpu pages are drained after start_isolate_page_range, but
>>> -		 * if there are still pages that are not free, make sure that we
>>> -		 * drain again, because when we isolated range we might have
>>> -		 * raced with another thread that was adding pages to pcp list.
>>> -		 *
>>> -		 * Forward progress should be still guaranteed because
>>> -		 * pages on the pcp list can only belong to MOVABLE_ZONE
>>> -		 * because has_unmovable_pages explicitly checks for
>>> -		 * PageBuddy on freed pages on other zones.
>>> -		 */
>>>    		ret = test_pages_isolated(start_pfn, end_pfn, MEMORY_OFFLINE);
>>> -		if (ret)
>>> -			drain_all_pages(zone);
>>> +
>>
>> Why two empty lines before the "} while (ret);" ? (unless I'm confused
>> while looking at this diff)
>>
> 
> No there's just a single emply line after "ret = test_pages_isolated..."
> Before there was none, which looked ok with the extra identation of the
> now-removed "drain_all_pages(zone);"
> 
>>> +void __zone_set_pageset_high_and_batch(struct zone *zone, unsigned long high,
>>> +		unsigned long batch)
>>> +{
>>> +	struct per_cpu_pageset *p;
>>> +	int cpu;
>>> +
>>> +	for_each_possible_cpu(cpu) {
>>> +		p = per_cpu_ptr(zone->pageset, cpu);
>>> +		pageset_update(&p->pcp, high, batch);
>>> +	}
>>> +}
>>> +
>>>    /*
>>>     * Calculate and set new high and batch values for all per-cpu pagesets of a
>>>     * zone, based on the zone's size and the percpu_pagelist_fraction sysctl.
>>> @@ -6315,8 +6338,6 @@ static void pageset_init(struct per_cpu_pageset *p)
>>>    static void zone_set_pageset_high_and_batch(struct zone *zone)
>>>    {
>>>    	unsigned long new_high, new_batch;
>>> -	struct per_cpu_pageset *p;
>>> -	int cpu;
>>>    
>>>    	if (percpu_pagelist_fraction) {
>>>    		new_high = zone_managed_pages(zone) / percpu_pagelist_fraction;
>>> @@ -6336,10 +6357,7 @@ static void zone_set_pageset_high_and_batch(struct zone *zone)
>>>    	zone->pageset_high = new_high;
>>>    	zone->pageset_batch = new_batch;
>>>    
>>> -	for_each_possible_cpu(cpu) {
>>> -		p = per_cpu_ptr(zone->pageset, cpu);
>>> -		pageset_update(&p->pcp, new_high, new_batch);
>>> -	}
>>> +	__zone_set_pageset_high_and_batch(zone, new_high, new_batch);
>>>    }
>>
>> These two hunks look like an unrelated cleanup, or am I missing something?
> 
> It's extracting part of functionality to __zone_set_pageset_high_and_batch()
> that's now called also from zone_pcp_enable() and zone_pcp_disable() - to only
> adjust the per-cpu zone->pageset values without the usual calculation.
> 
>> Thanks for looking into this!
> 
> Thanks for review. Here's updated version that adds more detailed comment about
> force_all_cpus parameter to __drain_all_pages() header, hopefully that clarifies
> your concerns.


LGTM!

Reviewed-by: David Hildenbrand <david@redhat.com>


-- 
Thanks,

David / dhildenb

