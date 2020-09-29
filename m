Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7D1C27C064
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 11:04:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727909AbgI2JD4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 05:03:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:40134 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726064AbgI2JD4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 05:03:56 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 54009ACA3;
        Tue, 29 Sep 2020 09:03:54 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 263AB1E12E9; Tue, 29 Sep 2020 11:03:54 +0200 (CEST)
Date:   Tue, 29 Sep 2020 11:03:54 +0200
From:   Jan Kara <jack@suse.cz>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        William Kucharski <william.kucharski@oracle.com>,
        Johannes Weiner <hannes@cmpxchg.org>, Jan Kara <jack@suse.cz>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Dave Chinner <dchinner@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 08/12] mm: Remove nr_entries parameter from
 pagevec_lookup_entries
Message-ID: <20200929090354.GF10896@quack2.suse.cz>
References: <20200914130042.11442-1-willy@infradead.org>
 <20200914130042.11442-9-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200914130042.11442-9-willy@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 14-09-20 14:00:38, Matthew Wilcox (Oracle) wrote:
> All callers want to fetch the full size of the pvec.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Looks good. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  include/linux/pagevec.h | 2 +-
>  mm/swap.c               | 4 ++--
>  mm/truncate.c           | 5 ++---
>  3 files changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/include/linux/pagevec.h b/include/linux/pagevec.h
> index 4b245592262c..ce77724a2ab7 100644
> --- a/include/linux/pagevec.h
> +++ b/include/linux/pagevec.h
> @@ -27,7 +27,7 @@ void __pagevec_release(struct pagevec *pvec);
>  void __pagevec_lru_add(struct pagevec *pvec);
>  unsigned pagevec_lookup_entries(struct pagevec *pvec,
>  		struct address_space *mapping, pgoff_t start, pgoff_t end,
> -		unsigned nr_entries, pgoff_t *indices);
> +		pgoff_t *indices);
>  void pagevec_remove_exceptionals(struct pagevec *pvec);
>  unsigned pagevec_lookup_range(struct pagevec *pvec,
>  			      struct address_space *mapping,
> diff --git a/mm/swap.c b/mm/swap.c
> index b6e56a84b466..d4e3ba4c967c 100644
> --- a/mm/swap.c
> +++ b/mm/swap.c
> @@ -1058,9 +1058,9 @@ void __pagevec_lru_add(struct pagevec *pvec)
>   */
>  unsigned pagevec_lookup_entries(struct pagevec *pvec,
>  		struct address_space *mapping, pgoff_t start, pgoff_t end,
> -		unsigned nr_entries, pgoff_t *indices)
> +		pgoff_t *indices)
>  {
> -	pvec->nr = find_get_entries(mapping, start, end, nr_entries,
> +	pvec->nr = find_get_entries(mapping, start, end, PAGEVEC_SIZE,
>  				    pvec->pages, indices);
>  	return pagevec_count(pvec);
>  }
> diff --git a/mm/truncate.c b/mm/truncate.c
> index 69ea72e7fc1c..bbd0a02eaed7 100644
> --- a/mm/truncate.c
> +++ b/mm/truncate.c
> @@ -377,7 +377,7 @@ void truncate_inode_pages_range(struct address_space *mapping,
>  	for ( ; ; ) {
>  		cond_resched();
>  		if (!pagevec_lookup_entries(&pvec, mapping, index, end - 1,
> -				PAGEVEC_SIZE, indices)) {
> +				indices)) {
>  			/* If all gone from start onwards, we're done */
>  			if (index == start)
>  				break;
> @@ -611,8 +611,7 @@ int invalidate_inode_pages2_range(struct address_space *mapping,
>  
>  	pagevec_init(&pvec);
>  	index = start;
> -	while (pagevec_lookup_entries(&pvec, mapping, index, end,
> -			PAGEVEC_SIZE, indices)) {
> +	while (pagevec_lookup_entries(&pvec, mapping, index, end, indices)) {
>  		for (i = 0; i < pagevec_count(&pvec); i++) {
>  			struct page *page = pvec.pages[i];
>  
> -- 
> 2.28.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
