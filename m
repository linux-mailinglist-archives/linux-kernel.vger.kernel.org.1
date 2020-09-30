Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3F3527E80D
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 13:59:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729646AbgI3L7W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 07:59:22 -0400
Received: from mx2.suse.de ([195.135.220.15]:38178 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727997AbgI3L7W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 07:59:22 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 296CAADFE;
        Wed, 30 Sep 2020 11:59:20 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 9BA101E0E76; Wed, 30 Sep 2020 13:59:19 +0200 (CEST)
Date:   Wed, 30 Sep 2020 13:59:19 +0200
From:   Jan Kara <jack@suse.cz>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        William Kucharski <william.kucharski@oracle.com>,
        Johannes Weiner <hannes@cmpxchg.org>, Jan Kara <jack@suse.cz>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Dave Chinner <dchinner@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 11/12] mm/truncate,shmem: Handle truncates that split
 THPs
Message-ID: <20200930115919.GS10896@quack2.suse.cz>
References: <20200914130042.11442-1-willy@infradead.org>
 <20200914130042.11442-12-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200914130042.11442-12-willy@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 14-09-20 14:00:41, Matthew Wilcox (Oracle) wrote:
> Handle THP splitting in the parts of the truncation functions which
> already handle partial pages.  Factor all that code out into a new
> function called truncate_inode_partial_page().
> 
> We lose the easy 'bail out' path if a truncate or hole punch is entirely
> within a single page.  We can add some more complex logic to restore
> the optimisation if it proves to be worthwhile.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Overall this looks OK. Some smaller suggestions below...

> @@ -931,33 +904,39 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, loff_t lend,
>  		index++;
>  	}
>  
> -	if (partial_start) {
> -		struct page *page = NULL;
> -		shmem_getpage(inode, start - 1, &page, SGP_READ);
> -		if (page) {
> -			unsigned int top = PAGE_SIZE;
> -			if (start > end) {
> -				top = partial_end;
> -				partial_end = 0;
> -			}
> -			zero_user_segment(page, partial_start, top);
> -			set_page_dirty(page);
> -			unlock_page(page);
> -			put_page(page);
> +	index = -1;
> +	if (end != -1 && ((lend + 1) % PAGE_SIZE))
				    ^^
Hum, is this guaranteed to compile properly on 32-bit archs without
optimization? It would be 64-bit division... Maybe we don't care, it just
caught my eye...

BTW you could just drop end != -1 part because end == -1 iff lend == -1 so
(lend + 1) % PAGE_SIZE is stronger.

> +		index = lend >> PAGE_SHIFT;
> +	page = NULL;
> +	shmem_getpage(inode, lstart >> PAGE_SHIFT, &page, SGP_READ);
> +	if (page) {
> +		bool same_page;
> +
> +		page = thp_head(page);
> +		same_page = lend + 1 < page_offset(page) + thp_size(page);
			    ^^^^^^^^ Just lend here?

> +		if (same_page)
> +			index = -1;
> +		set_page_dirty(page);
> +		if (!truncate_inode_partial_page(page, lstart, lend)) {
> +			start = page->index + thp_nr_pages(page);
> +			if (same_page)
> +				end = page->index;
>  		}
> +		unlock_page(page);
> +		put_page(page);
> +		page = NULL;
>  	}
> -	if (partial_end) {
> -		struct page *page = NULL;
> +
> +	if (index != -1)
>  		shmem_getpage(inode, end, &page, SGP_READ);
> -		if (page) {
> -			zero_user_segment(page, 0, partial_end);
> -			set_page_dirty(page);
> -			unlock_page(page);
> -			put_page(page);
> -		}
> +	if (page) {
> +		page = thp_head(page);
> +		set_page_dirty(page);
> +		if (!truncate_inode_partial_page(page, lstart, lend))
> +			end = page->index;
> +		unlock_page(page);
> +		put_page(page);
>  	}
> -	if (start >= end)
> -		return;

You use 'index' effectively as bool in all of the above (only ever check
index != -1). And effectively you only use it to communicate whether tail
partial page got already handled or not. Maybe there's some less cryptic
way to achieve that? Even separate bool just for that would be probably
better that this.

>  	index = start;
>  	while (index < end) {

> diff --git a/mm/truncate.c b/mm/truncate.c
> index d62aeffbffcc..06ed2f93069d 100644
> --- a/mm/truncate.c
> +++ b/mm/truncate.c
> @@ -224,6 +224,53 @@ int truncate_inode_page(struct address_space *mapping, struct page *page)
>  	return 0;
>  }
>  
> +/*
> + * Handle partial (transparent) pages.  The page may be entirely within the
> + * range if a split has raced with us.  If not, we zero the part of the
> + * page that's within the (start, end] range, and then split the page if
                             ^ '[' here - start is inclusive as well...

> + * it's a THP.  split_page_range() will discard pages which now lie beyond
> + * i_size, and we rely on the caller to discard pages which lie within a
> + * newly created hole.
> + *
> + * Returns false if THP splitting failed so the caller can can avoid
							  ^^^^^^^ just 'can'

> + * discarding the entire page which is stubbornly unsplit.
> + */
> +bool truncate_inode_partial_page(struct page *page, loff_t start, loff_t end)
> +{
> +	loff_t pos = page_offset(page);
> +	unsigned int offset, length;
> +
> +	if (pos < start)
> +		offset = start - pos;
> +	else
> +		offset = 0;
> +	length = thp_size(page);
> +	if (pos + length <= (u64)end)
> +		length = length - offset;
> +	else
> +		length = end + 1 - pos - offset;
> +
> +	wait_on_page_writeback(page);
> +	if (length == thp_size(page)) {
> +		truncate_inode_page(page->mapping, page);
> +		return true;
> +	}
> +
> +	/*
> +	 * We may be zeroing pages we're about to discard, but it avoids
> +	 * doing a complex calculation here, and then doing the zeroing
> +	 * anyway if the page split fails.
> +	 */
> +	zero_user(page, offset, length);
> +
> +	cleancache_invalidate_page(page->mapping, page);
> +	if (page_has_private(page))
> +		do_invalidatepage(page, offset, length);
> +	if (!PageTransHuge(page))
> +		return true;
> +	return split_huge_page(page) == 0;
> +}
> +
>  /*
>   * Used to get rid of pages on hardware memory corruption.
>   */
> @@ -288,20 +335,15 @@ void truncate_inode_pages_range(struct address_space *mapping,
>  {
>  	pgoff_t		start;		/* inclusive */
>  	pgoff_t		end;		/* exclusive */
> -	unsigned int	partial_start;	/* inclusive */
> -	unsigned int	partial_end;	/* exclusive */
>  	struct pagevec	pvec;
>  	pgoff_t		indices[PAGEVEC_SIZE];
>  	pgoff_t		index;
>  	int		i;
> +	struct page *	page;
>  
>  	if (mapping->nrpages == 0 && mapping->nrexceptional == 0)
>  		goto out;
>  
> -	/* Offsets within partial pages */
> -	partial_start = lstart & (PAGE_SIZE - 1);
> -	partial_end = (lend + 1) & (PAGE_SIZE - 1);
> -
>  	/*
>  	 * 'start' and 'end' always covers the range of pages to be fully
>  	 * truncated. Partial pages are covered with 'partial_start' at the
> @@ -334,48 +376,37 @@ void truncate_inode_pages_range(struct address_space *mapping,
>  		cond_resched();
>  	}
>  
> -	if (partial_start) {
> -		struct page *page = find_lock_page(mapping, start - 1);
> -		if (page) {
> -			unsigned int top = PAGE_SIZE;
> -			if (start > end) {
> -				/* Truncation within a single page */
> -				top = partial_end;
> -				partial_end = 0;
> -			}
> -			wait_on_page_writeback(page);
> -			zero_user_segment(page, partial_start, top);
> -			cleancache_invalidate_page(mapping, page);
> -			if (page_has_private(page))
> -				do_invalidatepage(page, partial_start,
> -						  top - partial_start);
> -			unlock_page(page);
> -			put_page(page);
> +	index = -1;
> +	if (end != -1 && ((lend + 1) % PAGE_SIZE))
            ^^^^^^^^^ Again this is unnecessary...

> +		index = lend >> PAGE_SHIFT;
> +	page = find_lock_head(mapping, lstart >> PAGE_SHIFT);
> +	if (page) {
> +		bool same_page = lend + 1 < page_offset(page) + thp_size(page);
				  ^^^^^^^ Again why +1 here?

> +		if (same_page)
> +			index = -1;
> +		if (!truncate_inode_partial_page(page, lstart, lend)) {
> +			start = page->index + thp_nr_pages(page);
> +			if (same_page)
> +				end = page->index;
>  		}
> +		unlock_page(page);
> +		put_page(page);
> +		page = NULL;
>  	}
> -	if (partial_end) {
> -		struct page *page = find_lock_page(mapping, end);
> -		if (page) {
> -			wait_on_page_writeback(page);
> -			zero_user_segment(page, 0, partial_end);
> -			cleancache_invalidate_page(mapping, page);
> -			if (page_has_private(page))
> -				do_invalidatepage(page, 0,
> -						  partial_end);
> -			unlock_page(page);
> -			put_page(page);
> -		}
> +
> +	if (index != -1)
> +		page = find_lock_head(mapping, index);

Similarly to shmem the use of index is a bit confusing here but it at least
gets used in this case so OK. But I'd still find something like:

	if (!tail_page_already_truncated)
		page = find_lock_head(mapping, lend >> PAGE_SHIFT);

easier to grasp.

> +	if (page) {
> +		if (!truncate_inode_partial_page(page, lstart, lend))
> +			end = page->index;
> +		unlock_page(page);
> +		put_page(page);
>  	}

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
