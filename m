Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F3472C6896
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 16:18:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730253AbgK0PRj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 10:17:39 -0500
Received: from mx2.suse.de ([195.135.220.15]:41162 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729225AbgK0PRi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 10:17:38 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 26425AC2D;
        Fri, 27 Nov 2020 15:17:37 +0000 (UTC)
Subject: Re: [PATCH] mm/page_alloc: Do not isolate redundant pageblock
To:     Muchun Song <songmuchun@bytedance.com>, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20201127141900.43348-1-songmuchun@bytedance.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <9e32e476-3812-2616-b2f5-a9b6f3531b8b@suse.cz>
Date:   Fri, 27 Nov 2020 16:17:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201127141900.43348-1-songmuchun@bytedance.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/27/20 3:19 PM, Muchun Song wrote:
> Current pageblock isolation logic could isolate each pageblock individually
> since commit d9dddbf55667 ("mm/page_alloc: prevent merging between isolated
> and other pageblocks"). So we not need to concern about page allocator
> merges buddies from different pageblocks and changes MIGRATE_ISOLATE to
> some other migration type.

Yeah, that should be the case now.

> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
>   mm/page_alloc.c | 26 ++++++++------------------
>   1 file changed, 8 insertions(+), 18 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index cefbef32bf4a..608a2c2b8ab7 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -8313,16 +8313,14 @@ struct page *has_unmovable_pages(struct zone *zone, struct page *page,
>   }
>   
>   #ifdef CONFIG_CONTIG_ALLOC
> -static unsigned long pfn_max_align_down(unsigned long pfn)
> +static unsigned long pfn_align_down(unsigned long pfn)
>   {
> -	return pfn & ~(max_t(unsigned long, MAX_ORDER_NR_PAGES,
> -			     pageblock_nr_pages) - 1);
> +	return pfn & ~(pageblock_nr_pages - 1);
>   }
>   
> -static unsigned long pfn_max_align_up(unsigned long pfn)
> +static unsigned long pfn_align_up(unsigned long pfn)
>   {
> -	return ALIGN(pfn, max_t(unsigned long, MAX_ORDER_NR_PAGES,
> -				pageblock_nr_pages));
> +	return ALIGN(pfn, pageblock_nr_pages);
>   }

How bout just removing these wrappers completely and using ALIGN and ALIGN_DOWN 
directly, as there are just two uses for each?

>   /* [start, end) must belong to a single zone. */
> @@ -8415,14 +8413,6 @@ int alloc_contig_range(unsigned long start, unsigned long end,
>   	INIT_LIST_HEAD(&cc.migratepages);
>   
>   	/*
> -	 * What we do here is we mark all pageblocks in range as
> -	 * MIGRATE_ISOLATE.  Because pageblock and max order pages may
> -	 * have different sizes, and due to the way page allocator
> -	 * work, we align the range to biggest of the two pages so
> -	 * that page allocator won't try to merge buddies from
> -	 * different pageblocks and change MIGRATE_ISOLATE to some
> -	 * other migration type.
> -	 *
>   	 * Once the pageblocks are marked as MIGRATE_ISOLATE, we
>   	 * migrate the pages from an unaligned range (ie. pages that
>   	 * we are interested in).  This will put all the pages in
> @@ -8438,8 +8428,8 @@ int alloc_contig_range(unsigned long start, unsigned long end,
>   	 * put back to page allocator so that buddy can use them.
>   	 */
>   
> -	ret = start_isolate_page_range(pfn_max_align_down(start),
> -				       pfn_max_align_up(end), migratetype, 0);
> +	ret = start_isolate_page_range(pfn_align_down(start), pfn_align_up(end),
> +				       migratetype, 0);
>   	if (ret)
>   		return ret;
>   
> @@ -8522,8 +8512,8 @@ int alloc_contig_range(unsigned long start, unsigned long end,
>   		free_contig_range(end, outer_end - end);
>   
>   done:
> -	undo_isolate_page_range(pfn_max_align_down(start),
> -				pfn_max_align_up(end), migratetype);
> +	undo_isolate_page_range(pfn_align_down(start), pfn_align_up(end),
> +				migratetype);
>   	return ret;
>   }
>   EXPORT_SYMBOL(alloc_contig_range);
> 

