Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 899A9304F3B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 03:59:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405316AbhA0BpJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 20:45:09 -0500
Received: from mx2.suse.de ([195.135.220.15]:39006 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731992AbhAZS5u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 13:57:50 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 8FDD5AC97;
        Tue, 26 Jan 2021 18:57:09 +0000 (UTC)
Subject: Re: [PATCH v2 01/10] mm: use add_page_to_lru_list()
To:     Yu Zhao <yuzhao@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Roman Gushchin <guro@fb.com>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20210122220600.906146-1-yuzhao@google.com>
 <20210122220600.906146-2-yuzhao@google.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <5f53f969-b92e-1d86-6b90-7bd93e390a21@suse.cz>
Date:   Tue, 26 Jan 2021 19:57:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210122220600.906146-2-yuzhao@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/22/21 11:05 PM, Yu Zhao wrote:
> There is add_page_to_lru_list(), and move_pages_to_lru() should reuse
> it, not duplicate it.
> 
> Link: https://lore.kernel.org/linux-mm/20201207220949.830352-2-yuzhao@google.com/
> Signed-off-by: Yu Zhao <yuzhao@google.com>
> Reviewed-by: Alex Shi <alex.shi@linux.alibaba.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  mm/vmscan.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 04509994aed4..19875660e8f8 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -1823,7 +1823,6 @@ static unsigned noinline_for_stack move_pages_to_lru(struct lruvec *lruvec,
>  	int nr_pages, nr_moved = 0;
>  	LIST_HEAD(pages_to_free);
>  	struct page *page;
> -	enum lru_list lru;
>  
>  	while (!list_empty(list)) {
>  		page = lru_to_page(list);
> @@ -1868,11 +1867,8 @@ static unsigned noinline_for_stack move_pages_to_lru(struct lruvec *lruvec,
>  		 * inhibits memcg migration).
>  		 */
>  		VM_BUG_ON_PAGE(!lruvec_holds_page_lru_lock(page, lruvec), page);
> -		lru = page_lru(page);
> +		add_page_to_lru_list(page, lruvec, page_lru(page));
>  		nr_pages = thp_nr_pages(page);
> -
> -		update_lru_size(lruvec, lru, page_zonenum(page), nr_pages);
> -		list_add(&page->lru, &lruvec->lists[lru]);
>  		nr_moved += nr_pages;
>  		if (PageActive(page))
>  			workingset_age_nonresident(lruvec, nr_pages);
> 

