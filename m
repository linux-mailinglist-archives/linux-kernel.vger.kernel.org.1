Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDC982D125C
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 14:43:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726042AbgLGNmw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 08:42:52 -0500
Received: from mx2.suse.de ([195.135.220.15]:41974 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725800AbgLGNmw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 08:42:52 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id ACE32AD18;
        Mon,  7 Dec 2020 13:42:10 +0000 (UTC)
Date:   Mon, 7 Dec 2020 14:42:08 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v2] mm/page_isolation: do not isolate the max order page
Message-ID: <20201207134208.GB12191@linux>
References: <20201203162237.21885-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201203162237.21885-1-songmuchun@bytedance.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 04, 2020 at 12:22:37AM +0800, Muchun Song wrote:
> The max order page has no buddy page and never merge to other order.
> So isolating and then freeing it is pointless. And if order == MAX_ORDER
> - 1, then the buddy can actually be a !pfn_valid() in some corner case?
> pfn_valid_within(buddy_pfn) that follows would only catch it on archs
> with holes in zone. Then is_migrate_isolate_page(buddy) might access an
> invalid buddy. So this is also a bug fix.
> 
> Fixes: 3c605096d315 ("mm/page_alloc: restrict max order of merging on isolated pageblock")
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Acked-by: Vlastimil Babka <vbabka@suse.cz>

Reviewed-by: Oscar Salvador <osalvador@suse.de>

> ---
> Changes in v2:
>  - Add Fixes tag in the commit log.
> 
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
> -- 
> 2.11.0
> 
> 

-- 
Oscar Salvador
SUSE L3
