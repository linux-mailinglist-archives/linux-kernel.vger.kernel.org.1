Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8ACE2CDB34
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 17:29:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731253AbgLCQ2F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 11:28:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52464 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727518AbgLCQ2E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 11:28:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607012798;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FXnZplMMKGwZ14qGf4Awkf5MDG2sv4VomdvDsZTHm1Q=;
        b=dgjeypkbkpy7zbgs/aI/ocJvOhnnhNT/FV3fhUm/uok5NbvhCUpIDK3JeQkrT44eXK6q3f
        HtucH8KXgPcdgTiIxx09cb0cZc+HdA3Um5Qz/2ZCsgApE6jtT23Sb5ZA1T/mwkl/G6729p
        D2Ct1dz7YkpSopaQMAx0cnem3BXySH8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-227-PckhPSH8Mr2aq2UqFYAc_Q-1; Thu, 03 Dec 2020 11:26:36 -0500
X-MC-Unique: PckhPSH8Mr2aq2UqFYAc_Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 40E37800D55;
        Thu,  3 Dec 2020 16:26:34 +0000 (UTC)
Received: from [10.36.113.250] (ovpn-113-250.ams2.redhat.com [10.36.113.250])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D2E2B60854;
        Thu,  3 Dec 2020 16:26:32 +0000 (UTC)
Subject: Re: [PATCH] mm/page_isolation: do not isolate the max order page
To:     Vlastimil Babka <vbabka@suse.cz>,
        Muchun Song <songmuchun@bytedance.com>,
        akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
References: <20201202122114.75316-1-songmuchun@bytedance.com>
 <1505b548-968b-2053-fd17-0cc4ae240a2f@suse.cz>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <29022300-6d8e-0532-7abc-6d11ab1db04a@redhat.com>
Date:   Thu, 3 Dec 2020 17:26:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <1505b548-968b-2053-fd17-0cc4ae240a2f@suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03.12.20 01:03, Vlastimil Babka wrote:
> On 12/2/20 1:21 PM, Muchun Song wrote:
>> The max order page has no buddy page and never merge to other order.
>> So isolating and then freeing it is pointless.
>>
>> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> 
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> 
>> ---
>>  mm/page_isolation.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/mm/page_isolation.c b/mm/page_isolation.c
>> index a254e1f370a3..bddf788f45bf 100644
>> --- a/mm/page_isolation.c
>> +++ b/mm/page_isolation.c
>> @@ -88,7 +88,7 @@ static void unset_migratetype_isolate(struct page *page, unsigned migratetype)
>>  	 */
>>  	if (PageBuddy(page)) {
>>  		order = buddy_order(page);
>> -		if (order >= pageblock_order) {
>> +		if (order >= pageblock_order && order < MAX_ORDER - 1) {
>>  			pfn = page_to_pfn(page);
>>  			buddy_pfn = __find_buddy_pfn(pfn, order);
>>  			buddy = page + (buddy_pfn - pfn);
> 
> Hm I wonder if order == MAX_ORDER - 1, then the buddy can actually be a
> !pfn_valid() in some corner case? pfn_valid_within(buddy_pfn) that follows would
> only catch it on archs with holes in zone. Then is_migrate_isolate_page(buddy)
> might access an invalid buddy. So this might be actually a bug fix and not just
> optimization, just the bug hasn't been observed in practice.

I think we have no users that isolate/unisolate close to holes.

CMA regions are properly aligned (to max of page_order /
max_order_nr_pages) and don't contain holes.

virtio-mem does not apply as it knows its range has no holes.

gigantic pages are aligned naturally and we check that there are no
holes upfront.

There are no other users.


I don't see a need for stable/fixes.

-- 
Thanks,

David / dhildenb

