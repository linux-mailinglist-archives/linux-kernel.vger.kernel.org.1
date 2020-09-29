Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15A5327BF5F
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 10:28:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727682AbgI2I2a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 04:28:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:40790 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725550AbgI2I2a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 04:28:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 97FA8B2B0;
        Tue, 29 Sep 2020 08:28:28 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 693C41E12E9; Tue, 29 Sep 2020 10:28:28 +0200 (CEST)
Date:   Tue, 29 Sep 2020 10:28:28 +0200
From:   Jan Kara <jack@suse.cz>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        William Kucharski <william.kucharski@oracle.com>,
        Johannes Weiner <hannes@cmpxchg.org>, Jan Kara <jack@suse.cz>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Dave Chinner <dchinner@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 02/12] mm/shmem: Use pagevec_lookup in
 shmem_unlock_mapping
Message-ID: <20200929082828.GB10896@quack2.suse.cz>
References: <20200914130042.11442-1-willy@infradead.org>
 <20200914130042.11442-3-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200914130042.11442-3-willy@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 14-09-20 14:00:32, Matthew Wilcox (Oracle) wrote:
> The comment shows that the reason for using find_get_entries() is now
> stale; find_get_pages() will not return 0 if it hits a consecutive run
> of swap entries, and I don't believe it has since 2011.  pagevec_lookup()
> is a simpler function to use than find_get_pages(), so use it instead.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Looks good to me. BTW, I think I've already reviewed this... You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  mm/shmem.c | 11 +----------
>  1 file changed, 1 insertion(+), 10 deletions(-)
> 
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 58bc9e326d0d..108931a6cc43 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -840,7 +840,6 @@ unsigned long shmem_swap_usage(struct vm_area_struct *vma)
>  void shmem_unlock_mapping(struct address_space *mapping)
>  {
>  	struct pagevec pvec;
> -	pgoff_t indices[PAGEVEC_SIZE];
>  	pgoff_t index = 0;
>  
>  	pagevec_init(&pvec);
> @@ -848,16 +847,8 @@ void shmem_unlock_mapping(struct address_space *mapping)
>  	 * Minor point, but we might as well stop if someone else SHM_LOCKs it.
>  	 */
>  	while (!mapping_unevictable(mapping)) {
> -		/*
> -		 * Avoid pagevec_lookup(): find_get_pages() returns 0 as if it
> -		 * has finished, if it hits a row of PAGEVEC_SIZE swap entries.
> -		 */
> -		pvec.nr = find_get_entries(mapping, index,
> -					   PAGEVEC_SIZE, pvec.pages, indices);
> -		if (!pvec.nr)
> +		if (!pagevec_lookup(&pvec, mapping, &index))
>  			break;
> -		index = indices[pvec.nr - 1] + 1;
> -		pagevec_remove_exceptionals(&pvec);
>  		check_move_unevictable_pages(&pvec);
>  		pagevec_release(&pvec);
>  		cond_resched();
> -- 
> 2.28.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
