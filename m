Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB89B27C040
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 10:59:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727900AbgI2I65 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 04:58:57 -0400
Received: from mx2.suse.de ([195.135.220.15]:36044 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727759AbgI2I65 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 04:58:57 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 713EDACA3;
        Tue, 29 Sep 2020 08:58:55 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 252501E12E9; Tue, 29 Sep 2020 10:58:55 +0200 (CEST)
Date:   Tue, 29 Sep 2020 10:58:55 +0200
From:   Jan Kara <jack@suse.cz>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        William Kucharski <william.kucharski@oracle.com>,
        Johannes Weiner <hannes@cmpxchg.org>, Jan Kara <jack@suse.cz>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Dave Chinner <dchinner@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 05/12] mm: Add and use find_lock_entries
Message-ID: <20200929085855.GD10896@quack2.suse.cz>
References: <20200914130042.11442-1-willy@infradead.org>
 <20200914130042.11442-6-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200914130042.11442-6-willy@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 14-09-20 14:00:35, Matthew Wilcox (Oracle) wrote:
> We have three functions (shmem_undo_range(), truncate_inode_pages_range()
> and invalidate_mapping_pages()) which want exactly this function, so
> add it to filemap.c.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> diff --git a/mm/shmem.c b/mm/shmem.c
...
> index b65263d9bb67..a73ce8ce28e3 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -905,12 +905,8 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, loff_t lend,
>  
>  	pagevec_init(&pvec);
>  	index = start;
> -	while (index < end) {
> -		pvec.nr = find_get_entries(mapping, index,
> -			min(end - index, (pgoff_t)PAGEVEC_SIZE),
> -			pvec.pages, indices);
> -		if (!pvec.nr)
> -			break;
> +	while (index < end && find_lock_entries(mapping, index, end - 1,
> +			&pvec, indices)) {
>  		for (i = 0; i < pagevec_count(&pvec); i++) {
>  			struct page *page = pvec.pages[i];
>  
> @@ -925,18 +921,10 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, loff_t lend,
>  								index, page);
>  				continue;
>  			}
> +			index += thp_nr_pages(page) - 1;
>  
> -			VM_BUG_ON_PAGE(page_to_pgoff(page) != index, page);
> -
> -			if (!trylock_page(page))
> -				continue;
> -
> -			if ((!unfalloc || !PageUptodate(page)) &&
> -			    page_mapping(page) == mapping) {
> -				VM_BUG_ON_PAGE(PageWriteback(page), page);
> -				if (shmem_punch_compound(page, start, end))
> -					truncate_inode_page(mapping, page);
> -			}
> +			if (!unfalloc || !PageUptodate(page))
> +				truncate_inode_page(mapping, page);

Is dropping shmem_punch_compound() really safe? AFAICS it can also call
split_huge_page() which will try to split THP to be able to truncate it.
That being said there's another loop in shmem_undo_range() which will try
again so what you did might make a difference with performance but not much
else. But still it would be good to at least comment about this in the
changelog...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
