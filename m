Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D90D2785AE
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 13:23:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728112AbgIYLXx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 07:23:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:38622 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726255AbgIYLXx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 07:23:53 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 06CBAADAB;
        Fri, 25 Sep 2020 11:23:49 +0000 (UTC)
Subject: Re: [PATCH 9/9] mm, page_alloc: optionally disable pcplists during
 page isolation
To:     David Hildenbrand <david@redhat.com>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, Michal Hocko <mhocko@kernel.org>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Oscar Salvador <osalvador@suse.de>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Michal Hocko <mhocko@suse.com>
References: <20200922143712.12048-1-vbabka@suse.cz>
 <20200922143712.12048-10-vbabka@suse.cz>
 <10cdae53-c64b-e371-1b83-01d1af7a131e@redhat.com>
 <e0ab17e9-6c05-cf32-9e2d-efbf011860a2@redhat.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <2ce92f9a-eaa2-45b2-207c-46a79d6a2bde@suse.cz>
Date:   Fri, 25 Sep 2020 13:10:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <e0ab17e9-6c05-cf32-9e2d-efbf011860a2@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/25/20 12:54 PM, David Hildenbrand wrote:
>>> --- a/mm/page_isolation.c
>>> +++ b/mm/page_isolation.c
>>> @@ -15,6 +15,22 @@
>>>  #define CREATE_TRACE_POINTS
>>>  #include <trace/events/page_isolation.h>
>>>  
>>> +void zone_pcplist_disable(struct zone *zone)
>>> +{
>>> +	down_read(&pcp_batch_high_lock);
>>> +	if (atomic_inc_return(&zone->pcplist_disabled) == 1) {
>>> +		zone_update_pageset_high_and_batch(zone, 0, 1);
>>> +		__drain_all_pages(zone, true);
>>> +	}
>> Hm, if one CPU is still inside the if-clause, the other one would
>> continue, however pcp wpould not be disabled and zones not drained when
>> returning.

Ah, well spotted, thanks!

>> (while we only allow a single Offline_pages() call, it will be different
>> when we use the function in other context - especially,
>> alloc_contig_range() for some users)
>>
>> Can't we use down_write() here? So it's serialized and everybody has to
>> properly wait. (and we would not have to rely on an atomic_t)
> Sorry, I meant down_write only temporarily in this code path. Not
> keeping it locked in write when returning (I remember there is a way to
> downgrade).

Hmm that temporary write lock would still block new callers until previous
finish with the downgraded-to-read lock.

But I guess something like this would work:

retry:
  if (atomic_read(...) == 0) {
    // zone_update... + drain
    atomic_inc(...);
  else if (atomic_inc_return == 1)
    // atomic_cmpxchg from 0 to 1; if that fails, goto retry

Tricky, but races could only read to unnecessary duplicated updates + flushing
but nothing worse?

Or add another spinlock to cover this part instead of the temp write lock...
