Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E6242D0D4D
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 10:46:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726511AbgLGJq0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 04:46:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45325 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726178AbgLGJqZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 04:46:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607334299;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=60RwvP6MhS9NxqDxL1ryxBLqNxzb7ws7UJi6gMrnHrQ=;
        b=fiqXl+TRc47Ke8YwuQa/D7powEhBQZ5PmTw1xE1SSAlobiCBsdTaCNwRf6xp4az88TLrfI
        +G6+MnCmzyAR7ffHTgMRAOCSlCFzpuOM0w4rUvt8jFCsObEzXpYXfwLOl9Hdy6hvIX0Q1f
        d4qp8gId1vy8qxK7++cty6odc5rUzfA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-293-oYJsurXhOGCLnOykFcb0pQ-1; Mon, 07 Dec 2020 04:44:55 -0500
X-MC-Unique: oYJsurXhOGCLnOykFcb0pQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A8E80107ACE8;
        Mon,  7 Dec 2020 09:44:53 +0000 (UTC)
Received: from [10.36.114.33] (ovpn-114-33.ams2.redhat.com [10.36.114.33])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 501F35C1A1;
        Mon,  7 Dec 2020 09:44:52 +0000 (UTC)
Subject: Re: [PATCH v3] mm/page_alloc: speeding up the iteration of max_order
To:     Muchun Song <songmuchun@bytedance.com>, akpm@linux-foundation.org,
        vbabka@suse.cz
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20201204155109.55451-1-songmuchun@bytedance.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <157411c6-90ad-e99d-b75e-002783f984b1@redhat.com>
Date:   Mon, 7 Dec 2020 10:44:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201204155109.55451-1-songmuchun@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04.12.20 16:51, Muchun Song wrote:
> When we free a page whose order is very close to MAX_ORDER and greater
> than pageblock_order, it wastes some CPU cycles to increase max_order
> to MAX_ORDER one by one and check the pageblock migratetype of that page
> repeatedly especially when MAX_ORDER is much larger than pageblock_order.
> 
> We also should not be checking migratetype of buddy when "order ==
> MAX_ORDER - 1" as the buddy pfn may be invalid, so adjust the condition.
> With the new check, we don't need the max_order check anymore, so we
> replace it.
> 
> Also adjust max_order initialization so that it's lower by one than
> previously, which makes the code hopefully more clear.
> 
> Fixes: d9dddbf55667 ("mm/page_alloc: prevent merging between isolated and other pageblocks")
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> ---
> Changes in v3:
>  - Update commit log.
> 
> Changes in v2:
>  - Rework the code suggested by Vlastimil. Thanks.
> 
>  mm/page_alloc.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index f91df593bf71..56e603eea1dd 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -1002,7 +1002,7 @@ static inline void __free_one_page(struct page *page,
>  	struct page *buddy;
>  	bool to_tail;
>  
> -	max_order = min_t(unsigned int, MAX_ORDER, pageblock_order + 1);
> +	max_order = min_t(unsigned int, MAX_ORDER - 1, pageblock_order);
>  
>  	VM_BUG_ON(!zone_is_initialized(zone));
>  	VM_BUG_ON_PAGE(page->flags & PAGE_FLAGS_CHECK_AT_PREP, page);
> @@ -1015,7 +1015,7 @@ static inline void __free_one_page(struct page *page,
>  	VM_BUG_ON_PAGE(bad_range(zone, page), page);
>  
>  continue_merging:
> -	while (order < max_order - 1) {
> +	while (order < max_order) {
>  		if (compaction_capture(capc, page, order, migratetype)) {
>  			__mod_zone_freepage_state(zone, -(1 << order),
>  								migratetype);
> @@ -1041,7 +1041,7 @@ static inline void __free_one_page(struct page *page,
>  		pfn = combined_pfn;
>  		order++;
>  	}
> -	if (max_order < MAX_ORDER) {
> +	if (order < MAX_ORDER - 1) {
>  		/* If we are here, it means order is >= pageblock_order.
>  		 * We want to prevent merge between freepages on isolate
>  		 * pageblock and normal pageblock. Without this, pageblock
> @@ -1062,7 +1062,7 @@ static inline void __free_one_page(struct page *page,
>  						is_migrate_isolate(buddy_mt)))
>  				goto done_merging;
>  		}
> -		max_order++;
> +		max_order = order + 1;
>  		goto continue_merging;
>  	}
>  
> 


LGTM

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

