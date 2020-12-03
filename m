Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FC232CCAD9
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 01:06:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729286AbgLCAEd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 19:04:33 -0500
Received: from mx2.suse.de ([195.135.220.15]:50980 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727474AbgLCAEd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 19:04:33 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 84A7EAB63;
        Thu,  3 Dec 2020 00:03:51 +0000 (UTC)
To:     Muchun Song <songmuchun@bytedance.com>, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
References: <20201202122114.75316-1-songmuchun@bytedance.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH] mm/page_isolation: do not isolate the max order page
Message-ID: <1505b548-968b-2053-fd17-0cc4ae240a2f@suse.cz>
Date:   Thu, 3 Dec 2020 01:03:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201202122114.75316-1-songmuchun@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/2/20 1:21 PM, Muchun Song wrote:
> The max order page has no buddy page and never merge to other order.
> So isolating and then freeing it is pointless.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  mm/page_isolation.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/page_isolation.c b/mm/page_isolation.c
> index a254e1f370a3..bddf788f45bf 100644
> --- a/mm/page_isolation.c
> +++ b/mm/page_isolation.c
> @@ -88,7 +88,7 @@ static void unset_migratetype_isolate(struct page *page, unsigned migratetype)
>  	 */
>  	if (PageBuddy(page)) {
>  		order = buddy_order(page);
> -		if (order >= pageblock_order) {
> +		if (order >= pageblock_order && order < MAX_ORDER - 1) {
>  			pfn = page_to_pfn(page);
>  			buddy_pfn = __find_buddy_pfn(pfn, order);
>  			buddy = page + (buddy_pfn - pfn);

Hm I wonder if order == MAX_ORDER - 1, then the buddy can actually be a
!pfn_valid() in some corner case? pfn_valid_within(buddy_pfn) that follows would
only catch it on archs with holes in zone. Then is_migrate_isolate_page(buddy)
might access an invalid buddy. So this might be actually a bug fix and not just
optimization, just the bug hasn't been observed in practice.

> 

