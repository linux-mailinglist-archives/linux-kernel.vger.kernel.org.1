Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89A2127C061
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 11:02:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727918AbgI2JCp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 05:02:45 -0400
Received: from mx2.suse.de ([195.135.220.15]:39440 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727799AbgI2JCp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 05:02:45 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 64FD3AD03;
        Tue, 29 Sep 2020 09:02:43 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 343211E12E9; Tue, 29 Sep 2020 11:02:43 +0200 (CEST)
Date:   Tue, 29 Sep 2020 11:02:43 +0200
From:   Jan Kara <jack@suse.cz>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        William Kucharski <william.kucharski@oracle.com>,
        Johannes Weiner <hannes@cmpxchg.org>, Jan Kara <jack@suse.cz>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Dave Chinner <dchinner@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 07/12] mm: Add an 'end' parameter to
 pagevec_lookup_entries
Message-ID: <20200929090243.GE10896@quack2.suse.cz>
References: <20200914130042.11442-1-willy@infradead.org>
 <20200914130042.11442-8-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200914130042.11442-8-willy@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 14-09-20 14:00:37, Matthew Wilcox (Oracle) wrote:
> Simplifies the callers and uses the existing functionality
> in find_get_entries().  We can also drop the final argument of
> truncate_exceptional_pvec_entries() and simplify the logic in that
> function.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Looks good to me. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  include/linux/pagevec.h |  5 ++---
>  mm/swap.c               |  8 ++++----
>  mm/truncate.c           | 41 ++++++++++-------------------------------
>  3 files changed, 16 insertions(+), 38 deletions(-)
> 
> diff --git a/include/linux/pagevec.h b/include/linux/pagevec.h
> index 081d934eda64..4b245592262c 100644
> --- a/include/linux/pagevec.h
> +++ b/include/linux/pagevec.h
> @@ -26,9 +26,8 @@ struct pagevec {
>  void __pagevec_release(struct pagevec *pvec);
>  void __pagevec_lru_add(struct pagevec *pvec);
>  unsigned pagevec_lookup_entries(struct pagevec *pvec,
> -				struct address_space *mapping,
> -				pgoff_t start, unsigned nr_entries,
> -				pgoff_t *indices);
> +		struct address_space *mapping, pgoff_t start, pgoff_t end,
> +		unsigned nr_entries, pgoff_t *indices);
>  void pagevec_remove_exceptionals(struct pagevec *pvec);
>  unsigned pagevec_lookup_range(struct pagevec *pvec,
>  			      struct address_space *mapping,
> diff --git a/mm/swap.c b/mm/swap.c
> index fcf6ccb94b09..b6e56a84b466 100644
> --- a/mm/swap.c
> +++ b/mm/swap.c
> @@ -1036,6 +1036,7 @@ void __pagevec_lru_add(struct pagevec *pvec)
>   * @pvec:	Where the resulting entries are placed
>   * @mapping:	The address_space to search
>   * @start:	The starting entry index
> + * @end:	The highest index to return (inclusive).
>   * @nr_entries:	The maximum number of pages
>   * @indices:	The cache indices corresponding to the entries in @pvec
>   *
> @@ -1056,11 +1057,10 @@ void __pagevec_lru_add(struct pagevec *pvec)
>   * found.
>   */
>  unsigned pagevec_lookup_entries(struct pagevec *pvec,
> -				struct address_space *mapping,
> -				pgoff_t start, unsigned nr_entries,
> -				pgoff_t *indices)
> +		struct address_space *mapping, pgoff_t start, pgoff_t end,
> +		unsigned nr_entries, pgoff_t *indices)
>  {
> -	pvec->nr = find_get_entries(mapping, start, ULONG_MAX, nr_entries,
> +	pvec->nr = find_get_entries(mapping, start, end, nr_entries,
>  				    pvec->pages, indices);
>  	return pagevec_count(pvec);
>  }
> diff --git a/mm/truncate.c b/mm/truncate.c
> index 5dbe0c77b5ac..69ea72e7fc1c 100644
> --- a/mm/truncate.c
> +++ b/mm/truncate.c
> @@ -57,11 +57,10 @@ static void clear_shadow_entry(struct address_space *mapping, pgoff_t index,
>   * exceptional entries similar to what pagevec_remove_exceptionals does.
>   */
>  static void truncate_exceptional_pvec_entries(struct address_space *mapping,
> -				struct pagevec *pvec, pgoff_t *indices,
> -				pgoff_t end)
> +				struct pagevec *pvec, pgoff_t *indices)
>  {
>  	int i, j;
> -	bool dax, lock;
> +	bool dax;
>  
>  	/* Handled by shmem itself */
>  	if (shmem_mapping(mapping))
> @@ -75,8 +74,7 @@ static void truncate_exceptional_pvec_entries(struct address_space *mapping,
>  		return;
>  
>  	dax = dax_mapping(mapping);
> -	lock = !dax && indices[j] < end;
> -	if (lock)
> +	if (!dax)
>  		xa_lock_irq(&mapping->i_pages);
>  
>  	for (i = j; i < pagevec_count(pvec); i++) {
> @@ -88,9 +86,6 @@ static void truncate_exceptional_pvec_entries(struct address_space *mapping,
>  			continue;
>  		}
>  
> -		if (index >= end)
> -			continue;
> -
>  		if (unlikely(dax)) {
>  			dax_delete_mapping_entry(mapping, index);
>  			continue;
> @@ -99,7 +94,7 @@ static void truncate_exceptional_pvec_entries(struct address_space *mapping,
>  		__clear_shadow_entry(mapping, index, page);
>  	}
>  
> -	if (lock)
> +	if (!dax)
>  		xa_unlock_irq(&mapping->i_pages);
>  	pvec->nr = j;
>  }
> @@ -329,7 +324,7 @@ void truncate_inode_pages_range(struct address_space *mapping,
>  	while (index < end && find_lock_entries(mapping, index, end - 1,
>  			&pvec, indices)) {
>  		index = indices[pagevec_count(&pvec) - 1] + 1;
> -		truncate_exceptional_pvec_entries(mapping, &pvec, indices, end);
> +		truncate_exceptional_pvec_entries(mapping, &pvec, indices);
>  		for (i = 0; i < pagevec_count(&pvec); i++)
>  			truncate_cleanup_page(mapping, pvec.pages[i]);
>  		delete_from_page_cache_batch(mapping, &pvec);
> @@ -381,8 +376,8 @@ void truncate_inode_pages_range(struct address_space *mapping,
>  	index = start;
>  	for ( ; ; ) {
>  		cond_resched();
> -		if (!pagevec_lookup_entries(&pvec, mapping, index,
> -			min(end - index, (pgoff_t)PAGEVEC_SIZE), indices)) {
> +		if (!pagevec_lookup_entries(&pvec, mapping, index, end - 1,
> +				PAGEVEC_SIZE, indices)) {
>  			/* If all gone from start onwards, we're done */
>  			if (index == start)
>  				break;
> @@ -390,23 +385,12 @@ void truncate_inode_pages_range(struct address_space *mapping,
>  			index = start;
>  			continue;
>  		}
> -		if (index == start && indices[0] >= end) {
> -			/* All gone out of hole to be punched, we're done */
> -			pagevec_remove_exceptionals(&pvec);
> -			pagevec_release(&pvec);
> -			break;
> -		}
>  
>  		for (i = 0; i < pagevec_count(&pvec); i++) {
>  			struct page *page = pvec.pages[i];
>  
>  			/* We rely upon deletion not changing page->index */
>  			index = indices[i];
> -			if (index >= end) {
> -				/* Restart punch to make sure all gone */
> -				index = start - 1;
> -				break;
> -			}
>  
>  			if (xa_is_value(page))
>  				continue;
> @@ -417,7 +401,7 @@ void truncate_inode_pages_range(struct address_space *mapping,
>  			truncate_inode_page(mapping, page);
>  			unlock_page(page);
>  		}
> -		truncate_exceptional_pvec_entries(mapping, &pvec, indices, end);
> +		truncate_exceptional_pvec_entries(mapping, &pvec, indices);
>  		pagevec_release(&pvec);
>  		index++;
>  	}
> @@ -528,8 +512,6 @@ unsigned long invalidate_mapping_pages(struct address_space *mapping,
>  
>  			/* We rely upon deletion not changing page->index */
>  			index = indices[i];
> -			if (index > end)
> -				break;
>  
>  			if (xa_is_value(page)) {
>  				invalidate_exceptional_entry(mapping, index,
> @@ -629,16 +611,13 @@ int invalidate_inode_pages2_range(struct address_space *mapping,
>  
>  	pagevec_init(&pvec);
>  	index = start;
> -	while (index <= end && pagevec_lookup_entries(&pvec, mapping, index,
> -			min(end - index, (pgoff_t)PAGEVEC_SIZE - 1) + 1,
> -			indices)) {
> +	while (pagevec_lookup_entries(&pvec, mapping, index, end,
> +			PAGEVEC_SIZE, indices)) {
>  		for (i = 0; i < pagevec_count(&pvec); i++) {
>  			struct page *page = pvec.pages[i];
>  
>  			/* We rely upon deletion not changing page->index */
>  			index = indices[i];
> -			if (index > end)
> -				break;
>  
>  			if (xa_is_value(page)) {
>  				if (!invalidate_exceptional_entry2(mapping,
> -- 
> 2.28.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
