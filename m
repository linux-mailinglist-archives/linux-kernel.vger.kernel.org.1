Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E321B2D25C8
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 09:24:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727612AbgLHIYx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 03:24:53 -0500
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:42772 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726734AbgLHIYw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 03:24:52 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0UHyFYxY_1607415844;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0UHyFYxY_1607415844)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 08 Dec 2020 16:24:04 +0800
Subject: Re: [PATCH 03/11] mm: don't pass "enum lru_list" to lru list addition
 functions
To:     Yu Zhao <yuzhao@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Roman Gushchin <guro@fb.com>, Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20201207220949.830352-1-yuzhao@google.com>
 <20201207220949.830352-4-yuzhao@google.com>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <0035a169-8c9c-85dd-7823-7d7d6e33ae81@linux.alibaba.com>
Date:   Tue, 8 Dec 2020 16:24:04 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201207220949.830352-4-yuzhao@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2020/12/8 上午6:09, Yu Zhao 写道:
> The "enum lru_list" parameter to add_page_to_lru_list() and
> add_page_to_lru_list_tail() is redundant in the sense that it can
> be extracted from the "struct page" parameter by page_lru().
> 
> A caveat is that we need to make sure PageActive() or
> PageUnevictable() is correctly set or cleared before calling
> these two functions. And they are indeed.
> 
> Signed-off-by: Yu Zhao <yuzhao@google.com>
> ---
>  include/linux/mm_inline.h |  8 ++++++--
>  mm/swap.c                 | 15 +++++++--------
>  mm/vmscan.c               |  6 ++----
>  3 files changed, 15 insertions(+), 14 deletions(-)
> 
> diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
> index 2889741f450a..130ba3201d3f 100644
> --- a/include/linux/mm_inline.h
> +++ b/include/linux/mm_inline.h
> @@ -106,15 +106,19 @@ static __always_inline enum lru_list page_lru(struct page *page)
>  }
>  
>  static __always_inline void add_page_to_lru_list(struct page *page,
> -				struct lruvec *lruvec, enum lru_list lru)
> +				struct lruvec *lruvec)
>  {
> +	enum lru_list lru = page_lru(page);
> +
>  	update_lru_size(lruvec, lru, page_zonenum(page), thp_nr_pages(page));
>  	list_add(&page->lru, &lruvec->lists[lru]);
>  }
>  
>  static __always_inline void add_page_to_lru_list_tail(struct page *page,
> -				struct lruvec *lruvec, enum lru_list lru)
> +				struct lruvec *lruvec)
>  {
> +	enum lru_list lru = page_lru(page);
> +
>  	update_lru_size(lruvec, lru, page_zonenum(page), thp_nr_pages(page));
>  	list_add_tail(&page->lru, &lruvec->lists[lru]);
>  }
> diff --git a/mm/swap.c b/mm/swap.c
> index 5022dfe388ad..136acabbfab5 100644
> --- a/mm/swap.c
> +++ b/mm/swap.c
> @@ -231,7 +231,7 @@ static void pagevec_move_tail_fn(struct page *page, struct lruvec *lruvec)
>  	if (!PageUnevictable(page)) {
>  		del_page_from_lru_list(page, lruvec, page_lru(page));
>  		ClearPageActive(page);
> -		add_page_to_lru_list_tail(page, lruvec, page_lru(page));
> +		add_page_to_lru_list_tail(page, lruvec);
>  		__count_vm_events(PGROTATED, thp_nr_pages(page));
>  	}
>  }
> @@ -313,8 +313,7 @@ static void __activate_page(struct page *page, struct lruvec *lruvec)
>  
>  		del_page_from_lru_list(page, lruvec, lru);
>  		SetPageActive(page);
> -		lru += LRU_ACTIVE;

Uh, actully, page to lru functions like, page_lru(page), always inline, so generally, no instruction
increasing, except few place like here.

 
> -		add_page_to_lru_list(page, lruvec, lru);
> +		add_page_to_lru_list(page, lruvec);
>  		trace_mm_lru_activate(page);
>  
>  		__count_vm_events(PGACTIVATE, nr_pages);
> @@ -543,14 +542,14 @@ static void lru_deactivate_file_fn(struct page *page, struct lruvec *lruvec)
>  		 * It can make readahead confusing.  But race window
>  		 * is _really_ small and  it's non-critical problem.
>  		 */
> -		add_page_to_lru_list(page, lruvec, lru);
> +		add_page_to_lru_list(page, lruvec);
>  		SetPageReclaim(page);
>  	} else {
>  		/*
>  		 * The page's writeback ends up during pagevec
>  		 * We moves tha page into tail of inactive.
>  		 */
> -		add_page_to_lru_list_tail(page, lruvec, lru);
> +		add_page_to_lru_list_tail(page, lruvec);
>  		__count_vm_events(PGROTATED, nr_pages);
>  	}
>  
> @@ -570,7 +569,7 @@ static void lru_deactivate_fn(struct page *page, struct lruvec *lruvec)
>  		del_page_from_lru_list(page, lruvec, lru + LRU_ACTIVE);
>  		ClearPageActive(page);
>  		ClearPageReferenced(page);
> -		add_page_to_lru_list(page, lruvec, lru);
> +		add_page_to_lru_list(page, lruvec);
>  
>  		__count_vm_events(PGDEACTIVATE, nr_pages);
>  		__count_memcg_events(lruvec_memcg(lruvec), PGDEACTIVATE,
> @@ -595,7 +594,7 @@ static void lru_lazyfree_fn(struct page *page, struct lruvec *lruvec)
>  		 * anonymous pages
>  		 */
>  		ClearPageSwapBacked(page);
> -		add_page_to_lru_list(page, lruvec, LRU_INACTIVE_FILE);
> +		add_page_to_lru_list(page, lruvec);
>  
>  		__count_vm_events(PGLAZYFREE, nr_pages);
>  		__count_memcg_events(lruvec_memcg(lruvec), PGLAZYFREE,
> @@ -1005,7 +1004,7 @@ static void __pagevec_lru_add_fn(struct page *page, struct lruvec *lruvec)
>  			__count_vm_events(UNEVICTABLE_PGCULLED, nr_pages);
>  	}
>  
> -	add_page_to_lru_list(page, lruvec, lru);
> +	add_page_to_lru_list(page, lruvec);
>  	trace_mm_lru_insertion(page, lru);
>  }
>  
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index a174594e40f8..8fc8f2c9d7ec 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -1865,7 +1865,7 @@ static unsigned noinline_for_stack move_pages_to_lru(struct lruvec *lruvec,
>  		 * inhibits memcg migration).
>  		 */
>  		VM_BUG_ON_PAGE(!lruvec_holds_page_lru_lock(page, lruvec), page);
> -		add_page_to_lru_list(page, lruvec, page_lru(page));
> +		add_page_to_lru_list(page, lruvec);
>  		nr_pages = thp_nr_pages(page);
>  		nr_moved += nr_pages;
>  		if (PageActive(page))
> @@ -4280,12 +4280,10 @@ void check_move_unevictable_pages(struct pagevec *pvec)
>  
>  		lruvec = relock_page_lruvec_irq(page, lruvec);
>  		if (page_evictable(page) && PageUnevictable(page)) {
> -			enum lru_list lru = page_lru_base_type(page);
> -
>  			VM_BUG_ON_PAGE(PageActive(page), page);
>  			ClearPageUnevictable(page);
>  			del_page_from_lru_list(page, lruvec, LRU_UNEVICTABLE);
> -			add_page_to_lru_list(page, lruvec, lru);

And here.


> +			add_page_to_lru_list(page, lruvec);
>  			pgrescued += nr_pages;
>  		}
>  		SetPageLRU(page);
> 
