Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C615235033
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Aug 2020 06:11:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726197AbgHAELX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Aug 2020 00:11:23 -0400
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:40586 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725280AbgHAELX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Aug 2020 00:11:23 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07425;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0U4N-V5x_1596255078;
Received: from IT-FVFX43SYHV2H.lan(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0U4N-V5x_1596255078)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 01 Aug 2020 12:11:19 +0800
Subject: Re: [PATCH 1/4] mm/thp: move lru_add_page_tail func to huge_memory.c
From:   Alex Shi <alex.shi@linux.alibaba.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Matthew Wilcox <willy@infradead.org>,
        Hugh Dickins <hughd@google.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
References: <1596254957-22560-1-git-send-email-alex.shi@linux.alibaba.com>
Message-ID: <69b09ccd-e353-9310-7fb2-41dc20374eb0@linux.alibaba.com>
Date:   Sat, 1 Aug 2020 12:11:10 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <1596254957-22560-1-git-send-email-alex.shi@linux.alibaba.com>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

This patchset is just cleanup and get reviewed by Kirill, is it cath up 5.9?

Thanks
Alex

�� 2020/8/1 ����12:09, Alex Shi д��:
> The func is only used in huge_memory.c, defining it in other file with a
> CONFIG_TRANSPARENT_HUGEPAGE macro restrict just looks weird.
> 
> Let's move it THP. And make it static as Hugh Dickin suggested.
> 
> Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
> Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-mm@kvack.org
> ---
>  include/linux/swap.h |  2 --
>  mm/huge_memory.c     | 30 ++++++++++++++++++++++++++++++
>  mm/swap.c            | 33 ---------------------------------
>  3 files changed, 30 insertions(+), 35 deletions(-)
> 
> diff --git a/include/linux/swap.h b/include/linux/swap.h
> index 661046994db4..43e6b3458f58 100644
> --- a/include/linux/swap.h
> +++ b/include/linux/swap.h
> @@ -338,8 +338,6 @@ extern void lru_note_cost(struct lruvec *lruvec, bool file,
>  			  unsigned int nr_pages);
>  extern void lru_note_cost_page(struct page *);
>  extern void lru_cache_add(struct page *);
> -extern void lru_add_page_tail(struct page *page, struct page *page_tail,
> -			 struct lruvec *lruvec, struct list_head *head);
>  extern void activate_page(struct page *);
>  extern void mark_page_accessed(struct page *);
>  extern void lru_add_drain(void);
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 90733cefa528..bc905e7079bf 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -2315,6 +2315,36 @@ static void remap_page(struct page *page)
>  	}
>  }
>  
> +static void lru_add_page_tail(struct page *page, struct page *page_tail,
> +				struct lruvec *lruvec, struct list_head *list)
> +{
> +	VM_BUG_ON_PAGE(!PageHead(page), page);
> +	VM_BUG_ON_PAGE(PageCompound(page_tail), page);
> +	VM_BUG_ON_PAGE(PageLRU(page_tail), page);
> +	lockdep_assert_held(&lruvec_pgdat(lruvec)->lru_lock);
> +
> +	if (!list)
> +		SetPageLRU(page_tail);
> +
> +	if (likely(PageLRU(page)))
> +		list_add_tail(&page_tail->lru, &page->lru);
> +	else if (list) {
> +		/* page reclaim is reclaiming a huge page */
> +		get_page(page_tail);
> +		list_add_tail(&page_tail->lru, list);
> +	} else {
> +		/*
> +		 * Head page has not yet been counted, as an hpage,
> +		 * so we must account for each subpage individually.
> +		 *
> +		 * Put page_tail on the list at the correct position
> +		 * so they all end up in order.
> +		 */
> +		add_page_to_lru_list_tail(page_tail, lruvec,
> +					  page_lru(page_tail));
> +	}
> +}
> +
>  static void __split_huge_page_tail(struct page *head, int tail,
>  		struct lruvec *lruvec, struct list_head *list)
>  {
> diff --git a/mm/swap.c b/mm/swap.c
> index d16d65d9b4e0..c674fb441fe9 100644
> --- a/mm/swap.c
> +++ b/mm/swap.c
> @@ -935,39 +935,6 @@ void __pagevec_release(struct pagevec *pvec)
>  }
>  EXPORT_SYMBOL(__pagevec_release);
>  
> -#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> -/* used by __split_huge_page_refcount() */
> -void lru_add_page_tail(struct page *page, struct page *page_tail,
> -		       struct lruvec *lruvec, struct list_head *list)
> -{
> -	VM_BUG_ON_PAGE(!PageHead(page), page);
> -	VM_BUG_ON_PAGE(PageCompound(page_tail), page);
> -	VM_BUG_ON_PAGE(PageLRU(page_tail), page);
> -	lockdep_assert_held(&lruvec_pgdat(lruvec)->lru_lock);
> -
> -	if (!list)
> -		SetPageLRU(page_tail);
> -
> -	if (likely(PageLRU(page)))
> -		list_add_tail(&page_tail->lru, &page->lru);
> -	else if (list) {
> -		/* page reclaim is reclaiming a huge page */
> -		get_page(page_tail);
> -		list_add_tail(&page_tail->lru, list);
> -	} else {
> -		/*
> -		 * Head page has not yet been counted, as an hpage,
> -		 * so we must account for each subpage individually.
> -		 *
> -		 * Put page_tail on the list at the correct position
> -		 * so they all end up in order.
> -		 */
> -		add_page_to_lru_list_tail(page_tail, lruvec,
> -					  page_lru(page_tail));
> -	}
> -}
> -#endif /* CONFIG_TRANSPARENT_HUGEPAGE */
> -
>  static void __pagevec_lru_add_fn(struct page *page, struct lruvec *lruvec,
>  				 void *arg)
>  {
> 
