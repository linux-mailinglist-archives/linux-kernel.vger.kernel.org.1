Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03C5227BF57
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 10:27:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727789AbgI2I1K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 04:27:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:38938 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725320AbgI2I1K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 04:27:10 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 0E3C2B283;
        Tue, 29 Sep 2020 08:27:09 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 896C11E12E9; Tue, 29 Sep 2020 10:27:08 +0200 (CEST)
Date:   Tue, 29 Sep 2020 10:27:08 +0200
From:   Jan Kara <jack@suse.cz>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        William Kucharski <william.kucharski@oracle.com>,
        Johannes Weiner <hannes@cmpxchg.org>, Jan Kara <jack@suse.cz>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Dave Chinner <dchinner@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 03/12] mm/filemap: Add helper for finding pages
Message-ID: <20200929082708.GA10896@quack2.suse.cz>
References: <20200914130042.11442-1-willy@infradead.org>
 <20200914130042.11442-4-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200914130042.11442-4-willy@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 14-09-20 14:00:33, Matthew Wilcox (Oracle) wrote:
> There is a lot of common code in find_get_entries(),
> find_get_pages_range() and find_get_pages_range_tag().  Factor out
> xas_find_get_entry() which simplifies all three functions.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Looks good. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  mm/filemap.c | 98 +++++++++++++++++++++++-----------------------------
>  1 file changed, 43 insertions(+), 55 deletions(-)
> 
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 7d8cf1a25628..d8f5ff07eb9c 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -1758,6 +1758,43 @@ struct page *pagecache_get_page(struct address_space *mapping, pgoff_t index,
>  }
>  EXPORT_SYMBOL(pagecache_get_page);
>  
> +static inline struct page *xas_find_get_entry(struct xa_state *xas,
> +		pgoff_t max, xa_mark_t mark)
> +{
> +	struct page *page;
> +
> +retry:
> +	if (mark == XA_PRESENT)
> +		page = xas_find(xas, max);
> +	else
> +		page = xas_find_marked(xas, max, mark);
> +
> +	if (xas_retry(xas, page))
> +		goto retry;
> +	/*
> +	 * A shadow entry of a recently evicted page, a swap
> +	 * entry from shmem/tmpfs or a DAX entry.  Return it
> +	 * without attempting to raise page count.
> +	 */
> +	if (!page || xa_is_value(page))
> +		return page;
> +
> +	if (!page_cache_get_speculative(page))
> +		goto reset;
> +
> +	/* Has the page moved or been split? */
> +	if (unlikely(page != xas_reload(xas))) {
> +		put_page(page);
> +		goto reset;
> +	}
> +	VM_BUG_ON_PAGE(!thp_contains(page, xas->xa_index), page);
> +
> +	return page;
> +reset:
> +	xas_reset(xas);
> +	goto retry;
> +}
> +
>  /**
>   * find_get_entries - gang pagecache lookup
>   * @mapping:	The address_space to search
> @@ -1797,42 +1834,21 @@ unsigned find_get_entries(struct address_space *mapping,
>  		return 0;
>  
>  	rcu_read_lock();
> -	xas_for_each(&xas, page, ULONG_MAX) {
> -		if (xas_retry(&xas, page))
> -			continue;
> -		/*
> -		 * A shadow entry of a recently evicted page, a swap
> -		 * entry from shmem/tmpfs or a DAX entry.  Return it
> -		 * without attempting to raise page count.
> -		 */
> -		if (xa_is_value(page))
> -			goto export;
> -
> -		if (!page_cache_get_speculative(page))
> -			goto retry;
> -
> -		/* Has the page moved or been split? */
> -		if (unlikely(page != xas_reload(&xas)))
> -			goto put_page;
> -
> +	while ((page = xas_find_get_entry(&xas, ULONG_MAX, XA_PRESENT))) {
>  		/*
>  		 * Terminate early on finding a THP, to allow the caller to
>  		 * handle it all at once; but continue if this is hugetlbfs.
>  		 */
> -		if (PageTransHuge(page) && !PageHuge(page)) {
> +		if (!xa_is_value(page) && PageTransHuge(page) &&
> +				!PageHuge(page)) {
>  			page = find_subpage(page, xas.xa_index);
>  			nr_entries = ret + 1;
>  		}
> -export:
> +
>  		indices[ret] = xas.xa_index;
>  		entries[ret] = page;
>  		if (++ret == nr_entries)
>  			break;
> -		continue;
> -put_page:
> -		put_page(page);
> -retry:
> -		xas_reset(&xas);
>  	}
>  	rcu_read_unlock();
>  	return ret;
> @@ -1871,30 +1887,16 @@ unsigned find_get_pages_range(struct address_space *mapping, pgoff_t *start,
>  		return 0;
>  
>  	rcu_read_lock();
> -	xas_for_each(&xas, page, end) {
> -		if (xas_retry(&xas, page))
> -			continue;
> +	while ((page = xas_find_get_entry(&xas, end, XA_PRESENT))) {
>  		/* Skip over shadow, swap and DAX entries */
>  		if (xa_is_value(page))
>  			continue;
>  
> -		if (!page_cache_get_speculative(page))
> -			goto retry;
> -
> -		/* Has the page moved or been split? */
> -		if (unlikely(page != xas_reload(&xas)))
> -			goto put_page;
> -
>  		pages[ret] = find_subpage(page, xas.xa_index);
>  		if (++ret == nr_pages) {
>  			*start = xas.xa_index + 1;
>  			goto out;
>  		}
> -		continue;
> -put_page:
> -		put_page(page);
> -retry:
> -		xas_reset(&xas);
>  	}
>  
>  	/*
> @@ -1993,9 +1995,7 @@ unsigned find_get_pages_range_tag(struct address_space *mapping, pgoff_t *index,
>  		return 0;
>  
>  	rcu_read_lock();
> -	xas_for_each_marked(&xas, page, end, tag) {
> -		if (xas_retry(&xas, page))
> -			continue;
> +	while ((page = xas_find_get_entry(&xas, end, tag))) {
>  		/*
>  		 * Shadow entries should never be tagged, but this iteration
>  		 * is lockless so there is a window for page reclaim to evict
> @@ -2004,23 +2004,11 @@ unsigned find_get_pages_range_tag(struct address_space *mapping, pgoff_t *index,
>  		if (xa_is_value(page))
>  			continue;
>  
> -		if (!page_cache_get_speculative(page))
> -			goto retry;
> -
> -		/* Has the page moved or been split? */
> -		if (unlikely(page != xas_reload(&xas)))
> -			goto put_page;
> -
>  		pages[ret] = page;
>  		if (++ret == nr_pages) {
>  			*index = page->index + thp_nr_pages(page);
>  			goto out;
>  		}
> -		continue;
> -put_page:
> -		put_page(page);
> -retry:
> -		xas_reset(&xas);
>  	}
>  
>  	/*
> -- 
> 2.28.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
