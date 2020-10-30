Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E85582A0B15
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 17:29:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727014AbgJ3Q3O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 12:29:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:41716 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725844AbgJ3Q3N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 12:29:13 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 2C09EACF5;
        Fri, 30 Oct 2020 16:29:12 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id A1F6B1E12F3; Fri, 30 Oct 2020 17:29:11 +0100 (CET)
Date:   Fri, 30 Oct 2020 17:29:11 +0100
From:   Jan Kara <jack@suse.cz>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-kernel@vger.kernel.org, Peter Xu <peterx@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Hugh Dickins <hughd@google.com>, Jan Kara <jack@suse.cz>,
        Jann Horn <jannh@google.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Kirill Shutemov <kirill@shutemov.name>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Linux-MM <linux-mm@kvack.org>, Michal Hocko <mhocko@suse.com>,
        Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH v2 1/2] mm: reorganize internal_get_user_pages_fast()
Message-ID: <20201030162911.GG19757@quack2.suse.cz>
References: <0-v2-dfe9ecdb6c74+2066-gup_fork_jgg@nvidia.com>
 <1-v2-dfe9ecdb6c74+2066-gup_fork_jgg@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1-v2-dfe9ecdb6c74+2066-gup_fork_jgg@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 30-10-20 11:46:20, Jason Gunthorpe wrote:
> The next patch in this series makes the lockless flow a little more
> complex, so move the entire block into a new function and remove a level
> of indention. Tidy a bit of cruft:
> 
>  - addr is always the same as start, so use start
> 
>  - Use the modern check_add_overflow() for computing end = start + len
> 
>  - nr_pinned/pages << PAGE_SHIFT needs the LHS to be unsigned long to
>    avoid shift overflow, make the variables unsigned long to avoid coding
>    casts in both places. nr_pinned was missing its cast
> 
>  - The handling of ret and nr_pinned can be streamlined a bit
> 
> No functional change.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Looks good to me. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  mm/gup.c | 99 ++++++++++++++++++++++++++++++--------------------------
>  1 file changed, 54 insertions(+), 45 deletions(-)
> 
> diff --git a/mm/gup.c b/mm/gup.c
> index 102877ed77a4b4..150cc962c99201 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -2671,13 +2671,43 @@ static int __gup_longterm_unlocked(unsigned long start, int nr_pages,
>  	return ret;
>  }
>  
> -static int internal_get_user_pages_fast(unsigned long start, int nr_pages,
> +static unsigned long lockless_pages_from_mm(unsigned long start,
> +					    unsigned long end,
> +					    unsigned int gup_flags,
> +					    struct page **pages)
> +{
> +	unsigned long flags;
> +	int nr_pinned = 0;
> +
> +	if (!IS_ENABLED(CONFIG_HAVE_FAST_GUP) ||
> +	    !gup_fast_permitted(start, end))
> +		return 0;
> +
> +	/*
> +	 * Disable interrupts. The nested form is used, in order to allow full,
> +	 * general purpose use of this routine.
> +	 *
> +	 * With interrupts disabled, we block page table pages from being freed
> +	 * from under us. See struct mmu_table_batch comments in
> +	 * include/asm-generic/tlb.h for more details.
> +	 *
> +	 * We do not adopt an rcu_read_lock() here as we also want to block IPIs
> +	 * that come from THPs splitting.
> +	 */
> +	local_irq_save(flags);
> +	gup_pgd_range(start, end, gup_flags, pages, &nr_pinned);
> +	local_irq_restore(flags);
> +	return nr_pinned;
> +}
> +
> +static int internal_get_user_pages_fast(unsigned long start,
> +					unsigned long nr_pages,
>  					unsigned int gup_flags,
>  					struct page **pages)
>  {
> -	unsigned long addr, len, end;
> -	unsigned long flags;
> -	int nr_pinned = 0, ret = 0;
> +	unsigned long len, end;
> +	unsigned long nr_pinned;
> +	int ret;
>  
>  	if (WARN_ON_ONCE(gup_flags & ~(FOLL_WRITE | FOLL_LONGTERM |
>  				       FOLL_FORCE | FOLL_PIN | FOLL_GET |
> @@ -2691,54 +2721,33 @@ static int internal_get_user_pages_fast(unsigned long start, int nr_pages,
>  		might_lock_read(&current->mm->mmap_lock);
>  
>  	start = untagged_addr(start) & PAGE_MASK;
> -	addr = start;
> -	len = (unsigned long) nr_pages << PAGE_SHIFT;
> -	end = start + len;
> -
> -	if (end <= start)
> +	len = nr_pages << PAGE_SHIFT;
> +	if (check_add_overflow(start, len, &end))
>  		return 0;
>  	if (unlikely(!access_ok((void __user *)start, len)))
>  		return -EFAULT;
>  
> -	/*
> -	 * Disable interrupts. The nested form is used, in order to allow
> -	 * full, general purpose use of this routine.
> -	 *
> -	 * With interrupts disabled, we block page table pages from being
> -	 * freed from under us. See struct mmu_table_batch comments in
> -	 * include/asm-generic/tlb.h for more details.
> -	 *
> -	 * We do not adopt an rcu_read_lock(.) here as we also want to
> -	 * block IPIs that come from THPs splitting.
> -	 */
> -	if (IS_ENABLED(CONFIG_HAVE_FAST_GUP) && gup_fast_permitted(start, end)) {
> -		unsigned long fast_flags = gup_flags;
> -
> -		local_irq_save(flags);
> -		gup_pgd_range(addr, end, fast_flags, pages, &nr_pinned);
> -		local_irq_restore(flags);
> -		ret = nr_pinned;
> -	}
> +	nr_pinned = lockless_pages_from_mm(start, end, gup_flags, pages);
> +	if (nr_pinned == nr_pages || gup_flags & FOLL_FAST_ONLY)
> +		return nr_pinned;
>  
> -	if (nr_pinned < nr_pages && !(gup_flags & FOLL_FAST_ONLY)) {
> -		/* Try to get the remaining pages with get_user_pages */
> -		start += nr_pinned << PAGE_SHIFT;
> -		pages += nr_pinned;
> -
> -		ret = __gup_longterm_unlocked(start, nr_pages - nr_pinned,
> -					      gup_flags, pages);
> -
> -		/* Have to be a bit careful with return values */
> -		if (nr_pinned > 0) {
> -			if (ret < 0)
> -				ret = nr_pinned;
> -			else
> -				ret += nr_pinned;
> -		}
> +	/* Slow path: try to get the remaining pages with get_user_pages */
> +	start += nr_pinned << PAGE_SHIFT;
> +	pages += nr_pinned;
> +	ret = __gup_longterm_unlocked(start, nr_pages - nr_pinned, gup_flags,
> +				      pages);
> +	if (ret < 0) {
> +		/*
> +		 * The caller has to unpin the pages we already pinned so
> +		 * returning -errno is not an option
> +		 */
> +		if (nr_pinned)
> +			return nr_pinned;
> +		return ret;
>  	}
> -
> -	return ret;
> +	return ret + nr_pinned;
>  }
> +
>  /**
>   * get_user_pages_fast_only() - pin user pages in memory
>   * @start:      starting user address
> -- 
> 2.28.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
