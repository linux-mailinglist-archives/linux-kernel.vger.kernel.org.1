Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6692304F7E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 04:20:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233939AbhA0DNO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 22:13:14 -0500
Received: from mx2.suse.de ([195.135.220.15]:44138 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2395252AbhAZTOC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 14:14:02 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 3403CAC97;
        Tue, 26 Jan 2021 19:13:12 +0000 (UTC)
Subject: Re: [PATCH v2 03/10] mm: don't pass "enum lru_list" to lru list
 addition functions
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
 <20210122220600.906146-4-yuzhao@google.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <85b3e8f2-5982-3329-c20d-cf062b8da71e@suse.cz>
Date:   Tue, 26 Jan 2021 20:13:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210122220600.906146-4-yuzhao@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/22/21 11:05 PM, Yu Zhao wrote:
> The "enum lru_list" parameter to add_page_to_lru_list() and
> add_page_to_lru_list_tail() is redundant in the sense that it can
> be extracted from the "struct page" parameter by page_lru().

Okay, however, it means repeated extraction of a value that we already knew. The
result of compilation is rather sad. This is bloat-o-meter on mm/built-in.a
(without CONFIG_DEBUG_VM, btw) between patch 2 and 5:

add/remove: 0/0 grow/shrink: 10/5 up/down: 1837/-60 (1777)
Function                                     old     new   delta
lru_deactivate_file_fn                       932    1368    +436
lru_lazyfree_fn.part                         629     953    +324
check_move_unevictable_pages                1171    1424    +253
__activate_page.part                         735     984    +249
lru_deactivate_fn.part                       593     822    +229
perf_trace_mm_lru_insertion                  458     560    +102
trace_event_raw_event_mm_lru_insertion       412     500     +88
__page_cache_release                         479     558     +79
release_pages                               1430    1499     +69
pagevec_move_tail_fn.part                    761     769      +8
isolate_lru_page                             471     470      -1
__bpf_trace_mm_lru_insertion                   7       5      -2
__traceiter_mm_lru_insertion                  55      47      -8
isolate_migratepages_block                  3200    3185     -15
__pagevec_lru_add_fn                        1092    1058     -34


> A caveat is that we need to make sure PageActive() or
> PageUnevictable() is correctly set or cleared before calling
> these two functions. And they are indeed.
> 
> Link: https://lore.kernel.org/linux-mm/20201207220949.830352-4-yuzhao@google.com/
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
> index 490553f3f9ef..4b058ef37add 100644
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
> index 19875660e8f8..09e4f97488c9 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -1867,7 +1867,7 @@ static unsigned noinline_for_stack move_pages_to_lru(struct lruvec *lruvec,
>  		 * inhibits memcg migration).
>  		 */
>  		VM_BUG_ON_PAGE(!lruvec_holds_page_lru_lock(page, lruvec), page);
> -		add_page_to_lru_list(page, lruvec, page_lru(page));
> +		add_page_to_lru_list(page, lruvec);
>  		nr_pages = thp_nr_pages(page);
>  		nr_moved += nr_pages;
>  		if (PageActive(page))
> @@ -4282,12 +4282,10 @@ void check_move_unevictable_pages(struct pagevec *pvec)
>  
>  		lruvec = relock_page_lruvec_irq(page, lruvec);
>  		if (page_evictable(page) && PageUnevictable(page)) {
> -			enum lru_list lru = page_lru_base_type(page);
> -
>  			VM_BUG_ON_PAGE(PageActive(page), page);
>  			ClearPageUnevictable(page);
>  			del_page_from_lru_list(page, lruvec, LRU_UNEVICTABLE);
> -			add_page_to_lru_list(page, lruvec, lru);
> +			add_page_to_lru_list(page, lruvec);
>  			pgrescued += nr_pages;
>  		}
>  		SetPageLRU(page);
> 

