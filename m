Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E10EB2A103D
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 22:32:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727852AbgJ3Vb4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 17:31:56 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:12872 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727836AbgJ3Vb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 17:31:56 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f9c86560005>; Fri, 30 Oct 2020 14:32:06 -0700
Received: from [10.2.58.85] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 30 Oct
 2020 21:31:55 +0000
Subject: Re: [PATCH v2 1/2] mm: reorganize internal_get_user_pages_fast()
To:     Jason Gunthorpe <jgg@nvidia.com>, <linux-kernel@vger.kernel.org>,
        Peter Xu <peterx@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
CC:     Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Hugh Dickins <hughd@google.com>, Jan Kara <jack@suse.cz>,
        Jann Horn <jannh@google.com>,
        Kirill Shutemov <kirill@shutemov.name>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Linux-MM <linux-mm@kvack.org>, Michal Hocko <mhocko@suse.com>,
        Oleg Nesterov <oleg@redhat.com>
References: <1-v2-dfe9ecdb6c74+2066-gup_fork_jgg@nvidia.com>
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <aba86298-cced-bdb7-542f-678646468502@nvidia.com>
Date:   Fri, 30 Oct 2020 14:31:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <1-v2-dfe9ecdb6c74+2066-gup_fork_jgg@nvidia.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1604093526; bh=1mc0Fp4jVz+8KrtVi+SMgOqlryl8D8Pz0DF+cX1srFU=;
        h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Language:
         Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
        b=h9Q18+++j1c82wPbP4bAgxjzYKFU7mKQKk5m0R+97ejbiXRTGHWognE4h+fIqWiop
         q+cNY9rjhmWCDF1QDb2xQlA+h6OK614RrVCRbCmB3B1+NMhHyw+RLHI5k3hPazXnWV
         GVtqKHQ0hZsTKenmuLL5Ltj/oRehogrzBqW1o9flywivslmapS1LBuMVBFGVGrZUI5
         NdB0snjcGT3NNPJp+Davt34STjn8pdV9qrFhEACieCY5s6icuitgNJoCQ3ieuZFgVk
         S9aFdPZZxDhQAde34id279AmytC4OCNp+cpZ9iKUtBkvXkUSb7HnZqGlxXtYe393Py
         Ni21eK92eNLhA==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/30/20 7:46 AM, Jason Gunthorpe wrote:
> The next patch in this series makes the lockless flow a little more
> complex, so move the entire block into a new function and remove a level
> of indention. Tidy a bit of cruft:
> 
>   - addr is always the same as start, so use start
> 
>   - Use the modern check_add_overflow() for computing end = start + len
> 
>   - nr_pinned/pages << PAGE_SHIFT needs the LHS to be unsigned long to
>     avoid shift overflow, make the variables unsigned long to avoid coding
>     casts in both places. nr_pinned was missing its cast
> 
>   - The handling of ret and nr_pinned can be streamlined a bit
> 
> No functional change.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>   mm/gup.c | 99 ++++++++++++++++++++++++++++++--------------------------
>   1 file changed, 54 insertions(+), 45 deletions(-)

Everything still looks correct.

Reviewed-by: John Hubbard <jhubbard@nvidia.com>


thanks,
-- 
John Hubbard
NVIDIA


> 
> diff --git a/mm/gup.c b/mm/gup.c
> index 102877ed77a4b4..150cc962c99201 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -2671,13 +2671,43 @@ static int __gup_longterm_unlocked(unsigned long start, int nr_pages,
>   	return ret;
>   }
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
>   					unsigned int gup_flags,
>   					struct page **pages)
>   {
> -	unsigned long addr, len, end;
> -	unsigned long flags;
> -	int nr_pinned = 0, ret = 0;
> +	unsigned long len, end;
> +	unsigned long nr_pinned;
> +	int ret;
>   
>   	if (WARN_ON_ONCE(gup_flags & ~(FOLL_WRITE | FOLL_LONGTERM |
>   				       FOLL_FORCE | FOLL_PIN | FOLL_GET |
> @@ -2691,54 +2721,33 @@ static int internal_get_user_pages_fast(unsigned long start, int nr_pages,
>   		might_lock_read(&current->mm->mmap_lock);
>   
>   	start = untagged_addr(start) & PAGE_MASK;
> -	addr = start;
> -	len = (unsigned long) nr_pages << PAGE_SHIFT;
> -	end = start + len;
> -
> -	if (end <= start)
> +	len = nr_pages << PAGE_SHIFT;
> +	if (check_add_overflow(start, len, &end))
>   		return 0;
>   	if (unlikely(!access_ok((void __user *)start, len)))
>   		return -EFAULT;
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
>   	}
> -
> -	return ret;
> +	return ret + nr_pinned;
>   }
> +
>   /**
>    * get_user_pages_fast_only() - pin user pages in memory
>    * @start:      starting user address
> 

