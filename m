Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70A182CDEC5
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 20:27:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731202AbgLCTZe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 14:25:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:42162 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726438AbgLCTZd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 14:25:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607023446;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=efV73LyUgTd5E5cnANarY69V1upOhjEKjDTFLhTEw0E=;
        b=KJurJ5QFq1nBzyjFrSZ79R2q8tbuWosMoR9zQINBIs8vnn9E/zq71ByY3XK1G31vIDwN44
        i1A+skuAJVm3tRvgf/Nyzzl2gbomJKVfuEJW6bpodN22ehGQQ+fNaILg7mbtjUPW14uw1M
        yOG/T5FK2m0Xb5xfRNEeAFcVtqHGXaI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-42-nSGgsFzVPm6kO0YBJNaOag-1; Thu, 03 Dec 2020 14:24:04 -0500
X-MC-Unique: nSGgsFzVPm6kO0YBJNaOag-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 04B328581A4;
        Thu,  3 Dec 2020 19:24:03 +0000 (UTC)
Received: from [10.36.113.250] (ovpn-113-250.ams2.redhat.com [10.36.113.250])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7E456189BB;
        Thu,  3 Dec 2020 19:24:01 +0000 (UTC)
Subject: Re: [PATCH] mm/page_isolation: do not isolate the max order page
From:   David Hildenbrand <david@redhat.com>
To:     Vlastimil Babka <vbabka@suse.cz>,
        Muchun Song <songmuchun@bytedance.com>,
        akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
References: <20201202122114.75316-1-songmuchun@bytedance.com>
 <1505b548-968b-2053-fd17-0cc4ae240a2f@suse.cz>
 <29022300-6d8e-0532-7abc-6d11ab1db04a@redhat.com>
 <92e54bf2-adc5-d51b-3b78-b881567335dc@suse.cz>
 <4acd86de-e5a7-7fbe-5cdc-939e12f7fb3a@redhat.com>
Organization: Red Hat GmbH
Message-ID: <c53e1580-8d16-1e94-48d2-f112b49ca5a2@redhat.com>
Date:   Thu, 3 Dec 2020 20:24:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <4acd86de-e5a7-7fbe-5cdc-939e12f7fb3a@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03.12.20 18:48, David Hildenbrand wrote:
> On 03.12.20 18:15, Vlastimil Babka wrote:
>> On 12/3/20 5:26 PM, David Hildenbrand wrote:
>>> On 03.12.20 01:03, Vlastimil Babka wrote:
>>>> On 12/2/20 1:21 PM, Muchun Song wrote:
>>>>> The max order page has no buddy page and never merge to other order.
>>>>> So isolating and then freeing it is pointless.
>>>>>
>>>>> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>>>>
>>>> Acked-by: Vlastimil Babka <vbabka@suse.cz>
>>>>
>>>>> ---
>>>>>  mm/page_isolation.c | 2 +-
>>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/mm/page_isolation.c b/mm/page_isolation.c
>>>>> index a254e1f370a3..bddf788f45bf 100644
>>>>> --- a/mm/page_isolation.c
>>>>> +++ b/mm/page_isolation.c
>>>>> @@ -88,7 +88,7 @@ static void unset_migratetype_isolate(struct page *page, unsigned migratetype)
>>>>>  	 */
>>>>>  	if (PageBuddy(page)) {
>>>>>  		order = buddy_order(page);
>>>>> -		if (order >= pageblock_order) {
>>>>> +		if (order >= pageblock_order && order < MAX_ORDER - 1) {
>>>>>  			pfn = page_to_pfn(page);
>>>>>  			buddy_pfn = __find_buddy_pfn(pfn, order);
>>>>>  			buddy = page + (buddy_pfn - pfn);
>>>>
>>>> Hm I wonder if order == MAX_ORDER - 1, then the buddy can actually be a
>>>> !pfn_valid() in some corner case? pfn_valid_within(buddy_pfn) that follows would
>>>> only catch it on archs with holes in zone. Then is_migrate_isolate_page(buddy)
>>>> might access an invalid buddy. So this might be actually a bug fix and not just
>>>> optimization, just the bug hasn't been observed in practice.
>>>
>>> I think we have no users that isolate/unisolate close to holes.
>>>
>>> CMA regions are properly aligned (to max of page_order /
>>> max_order_nr_pages) and don't contain holes.
>>
>> The problem as I see it, is that buddy_order(page) might be already MAX_ORDER -
>> 1 (e.g. two pageblocks on x86), and then finding buddy of that one is beyond the
>> guaranteed alignment (if they merged, which they can't, it would be four
> 
> Oh, I see. I would have assume that __find_buddy_pfn() would not hand
> out invalid buddies. But you're right, it's generic:
> 
> pfn = 1024 (4M)
> order = MAX_ORDER - 1 = 10
> buddy_pfn = __find_buddy_pfn(pfn, order)
> 
> -> pfn ^ (1 << order) = 0
> 
> 
> If that page has no struct page (!pfn_valid), we're doomed, I agree. It
> would be problematic if we have alloc_contig_range() users with ranges
> not aligned/multiples of to 8 MB (MAX_ORDER) I guess. virtio-mem and
> gigantic pages should be fine. CMA might be problematic, though? Do we
> have such small CMA ranges or with such alignment? COuld be I guess.
> 
> cma_init_reserved_mem() only checks
> 
> alignment = PAGE_SIZE << max_t(unsigned long, MAX_ORDER - 1,
> pageblock_order);
> 

Thinking again (SPARSE), we always end up in a single memory section.
Usually, all pfns within a single section are valid. The only exception
is with HAVE_ARCH_PFN_VALID - arm and arm6.

arm64 also has HOLES_IN_ZONE - so we always check for pfn_valid() in
this code.

arm only has HAVE_ARCH_PFN_VALID with SPARSE on ARCH_OMAP1. So only in
that combination, we might run into that issue if I am not wrong.


Not sure about !SPARSE and mips.

-- 
Thanks,

David / dhildenb

