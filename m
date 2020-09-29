Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD9D127C081
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 11:08:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727832AbgI2JIo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 05:08:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:44046 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725320AbgI2JIo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 05:08:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D8F80AD03;
        Tue, 29 Sep 2020 09:08:42 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 8EDB91E12E9; Tue, 29 Sep 2020 11:08:42 +0200 (CEST)
Date:   Tue, 29 Sep 2020 11:08:42 +0200
From:   Jan Kara <jack@suse.cz>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        William Kucharski <william.kucharski@oracle.com>,
        Johannes Weiner <hannes@cmpxchg.org>, Jan Kara <jack@suse.cz>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Dave Chinner <dchinner@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 10/12] mm: Remove pagevec_lookup_entries
Message-ID: <20200929090842.GH10896@quack2.suse.cz>
References: <20200914130042.11442-1-willy@infradead.org>
 <20200914130042.11442-11-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200914130042.11442-11-willy@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 14-09-20 14:00:40, Matthew Wilcox (Oracle) wrote:
> pagevec_lookup_entries() is now just a wrapper around find_get_entries()
> so remove it and convert all its callers.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Looks good. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  include/linux/pagevec.h |  3 ---
>  mm/swap.c               | 36 ++----------------------------------
>  mm/truncate.c           |  4 ++--
>  3 files changed, 4 insertions(+), 39 deletions(-)
> 
> diff --git a/include/linux/pagevec.h b/include/linux/pagevec.h
> index ce77724a2ab7..a45bea4b4d08 100644
> --- a/include/linux/pagevec.h
> +++ b/include/linux/pagevec.h
> @@ -25,9 +25,6 @@ struct pagevec {
>  
>  void __pagevec_release(struct pagevec *pvec);
>  void __pagevec_lru_add(struct pagevec *pvec);
> -unsigned pagevec_lookup_entries(struct pagevec *pvec,
> -		struct address_space *mapping, pgoff_t start, pgoff_t end,
> -		pgoff_t *indices);
>  void pagevec_remove_exceptionals(struct pagevec *pvec);
>  unsigned pagevec_lookup_range(struct pagevec *pvec,
>  			      struct address_space *mapping,
> diff --git a/mm/swap.c b/mm/swap.c
> index 40b23300d353..cc0d648f79d4 100644
> --- a/mm/swap.c
> +++ b/mm/swap.c
> @@ -1031,44 +1031,12 @@ void __pagevec_lru_add(struct pagevec *pvec)
>  	pagevec_lru_move_fn(pvec, __pagevec_lru_add_fn, NULL);
>  }
>  
> -/**
> - * pagevec_lookup_entries - gang pagecache lookup
> - * @pvec:	Where the resulting entries are placed
> - * @mapping:	The address_space to search
> - * @start:	The starting entry index
> - * @end:	The highest index to return (inclusive).
> - * @nr_entries:	The maximum number of pages
> - * @indices:	The cache indices corresponding to the entries in @pvec
> - *
> - * pagevec_lookup_entries() will search for and return a group of up
> - * to @nr_pages pages and shadow entries in the mapping.  All
> - * entries are placed in @pvec.  pagevec_lookup_entries() takes a
> - * reference against actual pages in @pvec.
> - *
> - * The search returns a group of mapping-contiguous entries with
> - * ascending indexes.  There may be holes in the indices due to
> - * not-present entries.
> - *
> - * Only one subpage of a Transparent Huge Page is returned in one call:
> - * allowing truncate_inode_pages_range() to evict the whole THP without
> - * cycling through a pagevec of extra references.
> - *
> - * pagevec_lookup_entries() returns the number of entries which were
> - * found.
> - */
> -unsigned pagevec_lookup_entries(struct pagevec *pvec,
> -		struct address_space *mapping, pgoff_t start, pgoff_t end,
> -		pgoff_t *indices)
> -{
> -	return find_get_entries(mapping, start, end, pvec, indices);
> -}
> -
>  /**
>   * pagevec_remove_exceptionals - pagevec exceptionals pruning
>   * @pvec:	The pagevec to prune
>   *
> - * pagevec_lookup_entries() fills both pages and exceptional radix
> - * tree entries into the pagevec.  This function prunes all
> + * find_get_entries() fills both pages and XArray value entries (aka
> + * exceptional entries) into the pagevec.  This function prunes all
>   * exceptionals from @pvec without leaving holes, so that it can be
>   * passed on to page-only pagevec operations.
>   */
> diff --git a/mm/truncate.c b/mm/truncate.c
> index bbd0a02eaed7..d62aeffbffcc 100644
> --- a/mm/truncate.c
> +++ b/mm/truncate.c
> @@ -376,7 +376,7 @@ void truncate_inode_pages_range(struct address_space *mapping,
>  	index = start;
>  	for ( ; ; ) {
>  		cond_resched();
> -		if (!pagevec_lookup_entries(&pvec, mapping, index, end - 1,
> +		if (!find_get_entries(mapping, index, end - 1, &pvec,
>  				indices)) {
>  			/* If all gone from start onwards, we're done */
>  			if (index == start)
> @@ -611,7 +611,7 @@ int invalidate_inode_pages2_range(struct address_space *mapping,
>  
>  	pagevec_init(&pvec);
>  	index = start;
> -	while (pagevec_lookup_entries(&pvec, mapping, index, end, indices)) {
> +	while (find_get_entries(mapping, index, end, &pvec, indices)) {
>  		for (i = 0; i < pagevec_count(&pvec); i++) {
>  			struct page *page = pvec.pages[i];
>  
> -- 
> 2.28.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
