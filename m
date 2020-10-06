Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7E04285490
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 00:28:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727660AbgJFW2F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 18:28:05 -0400
Received: from mx2.suse.de ([195.135.220.15]:59644 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726323AbgJFW2F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 18:28:05 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id CF634AD72;
        Tue,  6 Oct 2020 22:28:03 +0000 (UTC)
Subject: Re: [PATCH 5/9] mm, page_alloc: make per_cpu_pageset accessible only
 after init
To:     Michal Hocko <mhocko@suse.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
References: <20200922143712.12048-1-vbabka@suse.cz>
 <20200922143712.12048-6-vbabka@suse.cz>
 <20201005132445.GA4555@dhcp22.suse.cz>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <bbe42c37-a442-52cb-b620-b1753be1d643@suse.cz>
Date:   Wed, 7 Oct 2020 00:28:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201005132445.GA4555@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/5/20 3:24 PM, Michal Hocko wrote:
> On Tue 22-09-20 16:37:08, Vlastimil Babka wrote:
>> setup_zone_pageset() replaces the boot_pageset by allocating and initializing a
>> proper percpu one. Currently it assigns zone->pageset with the newly allocated
>> one before initializing it. That's currently not an issue, because the zone
>> should not be in any zonelist, thus not visible to allocators at this point.
>> 
>> Memory ordering between the pcplist contents and its visibility is also not
>> guaranteed here, but that also shouldn't be an issue because online_pages()
>> does a spin_unlock(pgdat->node_size_lock) before building the zonelists.
>> 
>> However it's best that we don't silently rely on operations that can be changed
>> in the future. Make sure only properly initialized pcplists are visible, using
>> smp_store_release(). The read side has a data dependency via the zone->pageset
>> pointer instead of an explicit read barrier.
> 
> Heh, this looks like inveting a similar trap the previous patch was
> removing. But more seriously considering that we need a locking for the
> whole setup, wouldn't it be better to simply document the locking
> requirements rather than adding scary looking barriers future ourselves
> or somebody else will need to scratch heads about. I am pretty sure we
> don't do anything like that when initializating numa node or other data
> structures that might be allocated during the memory hotadd.

Yeah it will be best to drop this for now. I just looked closed at 
build_zonelist() implementation and got scared how it just modifies the list 
that others might be reading at the same time. zoneref_set_zone() sets 
zoneref->zone and zoneref->zone_idx without any sync, what if somebody, e.g. 
for_next_zone_zonelist_nodemask() makes decision based on zone_idx and then 
picks wrong zone pointer? etc.

>> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
>> ---
>>  mm/page_alloc.c | 6 ++++--
>>  1 file changed, 4 insertions(+), 2 deletions(-)
>> 
>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>> index 99b74c1c2b0a..de3b48bda45c 100644
>> --- a/mm/page_alloc.c
>> +++ b/mm/page_alloc.c
>> @@ -6246,15 +6246,17 @@ static void zone_set_pageset_high_and_batch(struct zone *zone)
>>  
>>  void __meminit setup_zone_pageset(struct zone *zone)
>>  {
>> +	struct per_cpu_pageset __percpu * new_pageset;
>>  	struct per_cpu_pageset *p;
>>  	int cpu;
>>  
>> -	zone->pageset = alloc_percpu(struct per_cpu_pageset);
>> +	new_pageset = alloc_percpu(struct per_cpu_pageset);
>>  	for_each_possible_cpu(cpu) {
>> -		p = per_cpu_ptr(zone->pageset, cpu);
>> +		p = per_cpu_ptr(new_pageset, cpu);
>>  		pageset_init(p);
>>  	}
>>  
>> +	smp_store_release(&zone->pageset, new_pageset);
>>  	zone_set_pageset_high_and_batch(zone);
>>  }
>>  
>> -- 
>> 2.28.0
> 

