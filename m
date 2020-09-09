Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E20C262D7A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Sep 2020 12:55:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729741AbgIIKzm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Sep 2020 06:55:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:57748 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729005AbgIIKyr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 06:54:47 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 822B2AEB6;
        Wed,  9 Sep 2020 10:54:46 +0000 (UTC)
Subject: Re: [RFC 0/5] disable pcplists during page isolation
To:     David Hildenbrand <david@redhat.com>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, Michal Hocko <mhocko@kernel.org>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Oscar Salvador <osalvador@suse.de>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
References: <20200907163628.26495-1-vbabka@suse.cz>
 <0ffb1c2d-1b28-23f7-53e1-63e6f0f4cd41@redhat.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <ce8d05db-b804-21c7-0d12-43e11fc232e5@suse.cz>
Date:   Wed, 9 Sep 2020 12:54:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <0ffb1c2d-1b28-23f7-53e1-63e6f0f4cd41@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/8/20 8:29 PM, David Hildenbrand wrote:
> On 07.09.20 18:36, Vlastimil Babka wrote:
>> As per the discussions [1] [2] this is an attempt to implement David's
>> suggestion that page isolation should disable pcplists to avoid races. This is
>> done without extra checks in fast paths, as I mentioned should be possible in
>> the discussion, and explained in patch 5. Patches 1-4 are preparatory cleanups.
>> 
>> Note this is untested RFC for now. Based on v5.9-rc4 plus Pavel's patch [2]
>> (slated as a quick fix for mainline+stable).
>> 
>> [1] https://lore.kernel.org/linux-mm/20200901124615.137200-1-pasha.tatashin@soleen.com/
>> [2] https://lore.kernel.org/linux-mm/20200903140032.380431-1-pasha.tatashin@soleen.com/
>> 
>> Vlastimil Babka (5):
>>   mm, page_alloc: clean up pageset high and batch update
>>   mm, page_alloc: calculate pageset high and batch once per zone
>>   mm, page_alloc(): remove setup_pageset()
>>   mm, page_alloc: cache pageset high and batch in struct zone
>>   mm, page_alloc: disable pcplists during page isolation
>> 
>>  include/linux/gfp.h    |   1 +
>>  include/linux/mmzone.h |   2 +
>>  mm/internal.h          |   4 ++
>>  mm/memory_hotplug.c    |  24 +++----
>>  mm/page_alloc.c        | 138 ++++++++++++++++++++++-------------------
>>  mm/page_isolation.c    |  45 +++++++++++---
>>  6 files changed, 127 insertions(+), 87 deletions(-)
>> 
> 
> Thanks for looking into this! Just a heads-up that -mm and -next contain
> some changes to memory hotplug code, whereby new pageblocks start out in
> MIGRATE_ISOLATE when onlining, until we're done with the heavy lifting.
> Might require some tweaks, similar to when isolating pageblocks.

Thanks for the heads-up. I've posted updated patch 5/5 for the -next as a reply
to the first one. It was a bit tricky to order everything correctly in
online_pages(), hopefully I avoided any deadlock.

> Will dive into this in the following days. What's you're general
> perception of performance aspects?

Thanks! I expect no performance change while no isolation is in progress, as
there are no new tests added in alloc/free paths. During page isolation there's
a single drain instead of once-per-pageblock, which is a benefit. But the
pcplists are effectively disabled for the whole of online_pages(),
offline_pages() or alloc_contig_range(), which will affect parallel page
allocator users. It depends on how long these operations take and how heavy the
parallel usage is, so I have no good answers. Might be similar to the current
periodic drain.
