Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C88027C080
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 11:07:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727804AbgI2JHV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 05:07:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:43122 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725776AbgI2JHV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 05:07:21 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 1209DADD9;
        Tue, 29 Sep 2020 09:07:20 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id C68251E12E9; Tue, 29 Sep 2020 11:07:19 +0200 (CEST)
Date:   Tue, 29 Sep 2020 11:07:19 +0200
From:   Jan Kara <jack@suse.cz>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        William Kucharski <william.kucharski@oracle.com>,
        Johannes Weiner <hannes@cmpxchg.org>, Jan Kara <jack@suse.cz>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Dave Chinner <dchinner@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 09/12] mm: Pass pvec directly to find_get_entries
Message-ID: <20200929090719.GG10896@quack2.suse.cz>
References: <20200914130042.11442-1-willy@infradead.org>
 <20200914130042.11442-10-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200914130042.11442-10-willy@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 14-09-20 14:00:39, Matthew Wilcox (Oracle) wrote:
> All callers of find_get_entries() use a pvec, so pass it directly
> instead of manipulating it in the caller.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Looks good. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  include/linux/pagemap.h |  3 +--
>  mm/filemap.c            | 21 +++++++++------------
>  mm/shmem.c              |  5 ++---
>  mm/swap.c               |  4 +---
>  4 files changed, 13 insertions(+), 20 deletions(-)
> 
> diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> index d440c6750757..788c280737e0 100644
> --- a/include/linux/pagemap.h
> +++ b/include/linux/pagemap.h
> @@ -414,8 +414,7 @@ static inline struct page *find_subpage(struct page *head, pgoff_t index)
>  }
>  
>  unsigned find_get_entries(struct address_space *mapping, pgoff_t start,
> -		pgoff_t end, unsigned int nr_entries, struct page **entries,
> -		pgoff_t *indices);
> +		pgoff_t end, struct pagevec *pvec, pgoff_t *indices);
>  unsigned find_get_pages_range(struct address_space *mapping, pgoff_t *start,
>  			pgoff_t end, unsigned int nr_pages,
>  			struct page **pages);
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 6dc0a9b8c0fa..a4ad294a34dc 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -1800,14 +1800,12 @@ static inline struct page *xas_find_get_entry(struct xa_state *xas,
>   * @mapping:	The address_space to search
>   * @start:	The starting page cache index
>   * @end:	The final page index (inclusive).
> - * @nr_entries:	The maximum number of entries
> - * @entries:	Where the resulting entries are placed
> + * @pvec:	Where the resulting entries are placed.
>   * @indices:	The cache indices corresponding to the entries in @entries
>   *
> - * find_get_entries() will search for and return a group of up to
> - * @nr_entries entries in the mapping.  The entries are placed at
> - * @entries.  find_get_entries() takes a reference against any actual
> - * pages it returns.
> + * find_get_entries() will search for and return a batch of entries in
> + * the mapping.  The entries are placed in @pvec.  find_get_entries()
> + * takes a reference on any actual pages it returns.
>   *
>   * The search returns a group of mapping-contiguous page cache entries
>   * with ascending indexes.  There may be holes in the indices due to
> @@ -1824,15 +1822,12 @@ static inline struct page *xas_find_get_entry(struct xa_state *xas,
>   * Return: the number of pages and shadow entries which were found.
>   */
>  unsigned find_get_entries(struct address_space *mapping, pgoff_t start,
> -		pgoff_t end, unsigned int nr_entries, struct page **entries,
> -		pgoff_t *indices)
> +		pgoff_t end, struct pagevec *pvec, pgoff_t *indices)
>  {
>  	XA_STATE(xas, &mapping->i_pages, start);
>  	struct page *page;
>  	unsigned int ret = 0;
> -
> -	if (!nr_entries)
> -		return 0;
> +	unsigned nr_entries = PAGEVEC_SIZE;
>  
>  	rcu_read_lock();
>  	while ((page = xas_find_get_entry(&xas, end, XA_PRESENT))) {
> @@ -1847,11 +1842,13 @@ unsigned find_get_entries(struct address_space *mapping, pgoff_t start,
>  		}
>  
>  		indices[ret] = xas.xa_index;
> -		entries[ret] = page;
> +		pvec->pages[ret] = page;
>  		if (++ret == nr_entries)
>  			break;
>  	}
>  	rcu_read_unlock();
> +
> +	pvec->nr = ret;
>  	return ret;
>  }
>  
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 404e45c285ca..b2b94025841a 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -963,9 +963,8 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, loff_t lend,
>  	while (index < end) {
>  		cond_resched();
>  
> -		pvec.nr = find_get_entries(mapping, index, end - 1,
> -				PAGEVEC_SIZE, pvec.pages, indices);
> -		if (!pvec.nr) {
> +		if (!find_get_entries(mapping, index, end - 1, &pvec,
> +				indices)) {
>  			/* If all gone or hole-punch or unfalloc, we're done */
>  			if (index == start || end != -1)
>  				break;
> diff --git a/mm/swap.c b/mm/swap.c
> index d4e3ba4c967c..40b23300d353 100644
> --- a/mm/swap.c
> +++ b/mm/swap.c
> @@ -1060,9 +1060,7 @@ unsigned pagevec_lookup_entries(struct pagevec *pvec,
>  		struct address_space *mapping, pgoff_t start, pgoff_t end,
>  		pgoff_t *indices)
>  {
> -	pvec->nr = find_get_entries(mapping, start, end, PAGEVEC_SIZE,
> -				    pvec->pages, indices);
> -	return pagevec_count(pvec);
> +	return find_get_entries(mapping, start, end, pvec, indices);
>  }
>  
>  /**
> -- 
> 2.28.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
