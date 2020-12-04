Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE6492CF0BA
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 16:30:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730502AbgLDP3W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 10:29:22 -0500
Received: from mx2.suse.de ([195.135.220.15]:55066 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730378AbgLDP3W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 10:29:22 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 904DDACA8;
        Fri,  4 Dec 2020 15:28:40 +0000 (UTC)
To:     Muchun Song <songmuchun@bytedance.com>, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20201204125640.51804-1-songmuchun@bytedance.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v2] mm/page_alloc: speeding up the iteration of max_order
Message-ID: <27277a9f-c726-b033-51c1-d88f978fabfd@suse.cz>
Date:   Fri, 4 Dec 2020 16:28:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201204125640.51804-1-songmuchun@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/4/20 1:56 PM, Muchun Song wrote:
> When we free a page whose order is very close to MAX_ORDER and greater
> than pageblock_order, it wastes some CPU cycles to increase max_order
> to MAX_ORDER one by one and check the pageblock migratetype of that page
> repeatedly especially when MAX_ORDER is much larger than pageblock_order.

I would add:

We also should not be checking migratetype of buddy when "order == MAX_ORDER -
1" as the buddy pfn may be invalid, so adjust the condition. With the new check,
we don't need the max_order check anymore, so we replace it.

Also adjust max_order initialization so that it's lower by one than previously,
which makes the code hopefully more clear.

> Signed-off-by: Muchun Song <songmuchun@bytedance.com>

Fixes: d9dddbf55667 ("mm/page_alloc: prevent merging between isolated and other
pageblocks")
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Thanks!

> ---
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

