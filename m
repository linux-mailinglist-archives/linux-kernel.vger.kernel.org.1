Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40FCD2C6A46
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 17:57:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731848AbgK0Q40 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 11:56:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50164 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731419AbgK0Q40 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 11:56:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606496185;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5TPAySe2O5m8NZ8mMlBXdHGaigMA0wKhPa5QzZY75YU=;
        b=BVrN1KnVOzQvA295YpGUcgR2zeNPOZszVcgAPoooiEXIlDfw/iyYY9GBdWZiRdclzPflGd
        Oo44u5DnDJEPh4kGLj9esdq4Rz962UCh8iJ9EN24gwiMdTtkpmTQ4AtFaiE4XdLaVl7hHa
        2U9j9RAgglD9Aau6YboVUit+rN4VxBg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-423-y5ztGhzDObGft1RGaPqpVw-1; Fri, 27 Nov 2020 11:56:21 -0500
X-MC-Unique: y5ztGhzDObGft1RGaPqpVw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 04789107ACF7;
        Fri, 27 Nov 2020 16:56:20 +0000 (UTC)
Received: from [10.36.114.118] (ovpn-114-118.ams2.redhat.com [10.36.114.118])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CEC126085D;
        Fri, 27 Nov 2020 16:56:18 +0000 (UTC)
Subject: Re: [PATCH] mm/page_alloc: Do not isolate redundant pageblock
From:   David Hildenbrand <david@redhat.com>
To:     Muchun Song <songmuchun@bytedance.com>, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20201127141900.43348-1-songmuchun@bytedance.com>
 <54061152-2a1b-694f-8d45-d1333bc4a3fb@redhat.com>
Organization: Red Hat GmbH
Message-ID: <f1e13f66-26f8-a7be-a99d-662ef1adfb04@redhat.com>
Date:   Fri, 27 Nov 2020 17:56:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <54061152-2a1b-694f-8d45-d1333bc4a3fb@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27.11.20 17:54, David Hildenbrand wrote:
> On 27.11.20 15:19, Muchun Song wrote:
>> Current pageblock isolation logic could isolate each pageblock individually
>> since commit d9dddbf55667 ("mm/page_alloc: prevent merging between isolated
>> and other pageblocks"). So we not need to concern about page allocator
>> merges buddies from different pageblocks and changes MIGRATE_ISOLATE to
>> some other migration type.
>>
>> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>> ---
>>  mm/page_alloc.c | 26 ++++++++------------------
>>  1 file changed, 8 insertions(+), 18 deletions(-)
>>
>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>> index cefbef32bf4a..608a2c2b8ab7 100644
>> --- a/mm/page_alloc.c
>> +++ b/mm/page_alloc.c
>> @@ -8313,16 +8313,14 @@ struct page *has_unmovable_pages(struct zone *zone, struct page *page,
>>  }
>>  
>>  #ifdef CONFIG_CONTIG_ALLOC
>> -static unsigned long pfn_max_align_down(unsigned long pfn)
>> +static unsigned long pfn_align_down(unsigned long pfn)
>>  {
>> -	return pfn & ~(max_t(unsigned long, MAX_ORDER_NR_PAGES,
>> -			     pageblock_nr_pages) - 1);
>> +	return pfn & ~(pageblock_nr_pages - 1);
>>  }
>>  
>> -static unsigned long pfn_max_align_up(unsigned long pfn)
>> +static unsigned long pfn_align_up(unsigned long pfn)
>>  {
>> -	return ALIGN(pfn, max_t(unsigned long, MAX_ORDER_NR_PAGES,
>> -				pageblock_nr_pages));
>> +	return ALIGN(pfn, pageblock_nr_pages);
>>  }
>>  
>>  /* [start, end) must belong to a single zone. */
>> @@ -8415,14 +8413,6 @@ int alloc_contig_range(unsigned long start, unsigned long end,
>>  	INIT_LIST_HEAD(&cc.migratepages);
>>  
>>  	/*
>> -	 * What we do here is we mark all pageblocks in range as
>> -	 * MIGRATE_ISOLATE.  Because pageblock and max order pages may
>> -	 * have different sizes, and due to the way page allocator
>> -	 * work, we align the range to biggest of the two pages so
>> -	 * that page allocator won't try to merge buddies from
>> -	 * different pageblocks and change MIGRATE_ISOLATE to some
>> -	 * other migration type.
>> -	 *
>>  	 * Once the pageblocks are marked as MIGRATE_ISOLATE, we
>>  	 * migrate the pages from an unaligned range (ie. pages that
>>  	 * we are interested in).  This will put all the pages in
>> @@ -8438,8 +8428,8 @@ int alloc_contig_range(unsigned long start, unsigned long end,
>>  	 * put back to page allocator so that buddy can use them.
>>  	 */
>>  
>> -	ret = start_isolate_page_range(pfn_max_align_down(start),
>> -				       pfn_max_align_up(end), migratetype, 0);
>> +	ret = start_isolate_page_range(pfn_align_down(start), pfn_align_up(end),
>> +				       migratetype, 0);
>>  	if (ret)
>>  		return ret;
>>  
>> @@ -8522,8 +8512,8 @@ int alloc_contig_range(unsigned long start, unsigned long end,
>>  		free_contig_range(end, outer_end - end);
>>  
>>  done:
>> -	undo_isolate_page_range(pfn_max_align_down(start),
>> -				pfn_max_align_up(end), migratetype);
>> +	undo_isolate_page_range(pfn_align_down(start), pfn_align_up(end),
>> +				migratetype);
>>  	return ret;
>>  }
>>  EXPORT_SYMBOL(alloc_contig_range);
>>
> 
> Last time I checked, set_migratetype_isolate()->has_unmovable_pages()
> was not prepared for that in case of !CMA and !ZONE_MOVABLE.
> 
> Assume you have an unmovable MAX_ORDER - 1 page that spans two
> pageblocks (e.g., x86-64). Assume you try to isolate the second
> pageblock. IIRC, you would answer "yes", as the refcount of all involved
> pages is 0.
> 
> 
> How did you test this works as expected?
> 

And I forgot to mention, in case it's a movable MAX_ORDER - 1 page (or
simply free), would __alloc_contig_migrate_range() do the right thing
and migrate the whole page?

-- 
Thanks,

David / dhildenb

