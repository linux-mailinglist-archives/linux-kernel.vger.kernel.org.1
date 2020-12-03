Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 100A22CDC86
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 18:38:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726737AbgLCRhn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 12:37:43 -0500
Received: from mx2.suse.de ([195.135.220.15]:56222 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726264AbgLCRhm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 12:37:42 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5A47CAD2D;
        Thu,  3 Dec 2020 17:37:01 +0000 (UTC)
To:     Muchun Song <songmuchun@bytedance.com>, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20201202121838.75218-1-songmuchun@bytedance.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH] mm/page_alloc: speeding up the iteration of max_order
Message-ID: <320c8522-4ed5-809f-e6fc-8a185587519c@suse.cz>
Date:   Thu, 3 Dec 2020 18:37:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201202121838.75218-1-songmuchun@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/2/20 1:18 PM, Muchun Song wrote:
> When we free a page whose order is very close to MAX_ORDER and greater
> than pageblock_order, it wastes some CPU cycles to increase max_order
> to MAX_ORDER one by one and check the pageblock migratetype of that page

But we have to do that. It's not the same page, it's the merged page and the new
buddy is a different pageblock and we need to check if they have compatible
migratetypes and can merge, or we have to bail out. So the patch is wrong.

> repeatedly especially when MAX_ORDER is much larger than pageblock_order.

Do we have such architectures/configurations anyway?

> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
>  mm/page_alloc.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 141f12e5142c..959541234e1d 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -1041,7 +1041,7 @@ static inline void __free_one_page(struct page *page,
>  		pfn = combined_pfn;
>  		order++;
>  	}
> -	if (max_order < MAX_ORDER) {
> +	if (max_order < MAX_ORDER && order < MAX_ORDER - 1) {
>  		/* If we are here, it means order is >= pageblock_order.
>  		 * We want to prevent merge between freepages on isolate
>  		 * pageblock and normal pageblock. Without this, pageblock
> @@ -1062,6 +1062,8 @@ static inline void __free_one_page(struct page *page,
>  						is_migrate_isolate(buddy_mt)))
>  				goto done_merging;
>  		}
> +		if (unlikely(order != max_order - 1))
> +			max_order = order + 1;

Or maybe I just don't understand what this is doing. When is the new 'if' even
true? We just bailed out of "while (order < max_order - 1)" after the last
"order++", which means it should hold that "order == max_order - 1")?
Your description sounds like you want to increase max_order to MAX_ORDER in one
step, which as I explained would be wrong. But the implementation looks actually
like a no-op.

>  		max_order++;
>  		goto continue_merging;
>  	}
> 

