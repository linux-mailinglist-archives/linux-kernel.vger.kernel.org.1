Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EB412CDC32
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 18:16:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502007AbgLCRQT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 12:16:19 -0500
Received: from mx2.suse.de ([195.135.220.15]:39256 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2502001AbgLCRQT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 12:16:19 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id EFBA6AC2E;
        Thu,  3 Dec 2020 17:15:37 +0000 (UTC)
To:     David Hildenbrand <david@redhat.com>,
        Muchun Song <songmuchun@bytedance.com>,
        akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
References: <20201202122114.75316-1-songmuchun@bytedance.com>
 <1505b548-968b-2053-fd17-0cc4ae240a2f@suse.cz>
 <29022300-6d8e-0532-7abc-6d11ab1db04a@redhat.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH] mm/page_isolation: do not isolate the max order page
Message-ID: <92e54bf2-adc5-d51b-3b78-b881567335dc@suse.cz>
Date:   Thu, 3 Dec 2020 18:15:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <29022300-6d8e-0532-7abc-6d11ab1db04a@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/3/20 5:26 PM, David Hildenbrand wrote:
> On 03.12.20 01:03, Vlastimil Babka wrote:
>> On 12/2/20 1:21 PM, Muchun Song wrote:
>>> The max order page has no buddy page and never merge to other order.
>>> So isolating and then freeing it is pointless.
>>>
>>> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>> 
>> Acked-by: Vlastimil Babka <vbabka@suse.cz>
>> 
>>> ---
>>>  mm/page_isolation.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/mm/page_isolation.c b/mm/page_isolation.c
>>> index a254e1f370a3..bddf788f45bf 100644
>>> --- a/mm/page_isolation.c
>>> +++ b/mm/page_isolation.c
>>> @@ -88,7 +88,7 @@ static void unset_migratetype_isolate(struct page *page, unsigned migratetype)
>>>  	 */
>>>  	if (PageBuddy(page)) {
>>>  		order = buddy_order(page);
>>> -		if (order >= pageblock_order) {
>>> +		if (order >= pageblock_order && order < MAX_ORDER - 1) {
>>>  			pfn = page_to_pfn(page);
>>>  			buddy_pfn = __find_buddy_pfn(pfn, order);
>>>  			buddy = page + (buddy_pfn - pfn);
>> 
>> Hm I wonder if order == MAX_ORDER - 1, then the buddy can actually be a
>> !pfn_valid() in some corner case? pfn_valid_within(buddy_pfn) that follows would
>> only catch it on archs with holes in zone. Then is_migrate_isolate_page(buddy)
>> might access an invalid buddy. So this might be actually a bug fix and not just
>> optimization, just the bug hasn't been observed in practice.
> 
> I think we have no users that isolate/unisolate close to holes.
> 
> CMA regions are properly aligned (to max of page_order /
> max_order_nr_pages) and don't contain holes.

The problem as I see it, is that buddy_order(page) might be already MAX_ORDER -
1 (e.g. two pageblocks on x86), and then finding buddy of that one is beyond the
guaranteed alignment (if they merged, which they can't, it would be four
pageblocks). Might not be just a hole within zone, but also across zone boundary?
While being isolated and used pages migrated away, the freed pages shouldn't
merge to MAX_ORDER-1, but if the MAX_ORDER-1 free page was already there before
the isolation?

> virtio-mem does not apply as it knows its range has no holes.
> 
> gigantic pages are aligned naturally and we check that there are no
> holes upfront.
> 
> There are no other users.
> 
> 
> I don't see a need for stable/fixes.
> 

