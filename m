Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2022A297AD7
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Oct 2020 06:51:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759505AbgJXEoU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Oct 2020 00:44:20 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:6061 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759497AbgJXEoT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Oct 2020 00:44:19 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f93b1290001>; Fri, 23 Oct 2020 21:44:25 -0700
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sat, 24 Oct
 2020 04:44:19 +0000
Received: from [10.2.51.100] (10.124.1.5) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sat, 24 Oct
 2020 04:44:18 +0000
Subject: Re: [PATCH 1/2] mm: reorganize internal_get_user_pages_fast()
To:     Jason Gunthorpe <jgg@nvidia.com>, <linux-kernel@vger.kernel.org>
CC:     Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Hugh Dickins <hughd@google.com>, Jan Kara <jack@suse.cz>,
        Jann Horn <jannh@google.com>,
        Kirill Shutemov <kirill@shutemov.name>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Linux-MM <linux-mm@kvack.org>, Michal Hocko <mhocko@suse.com>,
        Oleg Nesterov <oleg@redhat.com>, Peter Xu <peterx@redhat.com>
References: <1-v1-281e425c752f+2df-gup_fork_jgg@nvidia.com>
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <16c50bb0-431d-5bfb-7b80-a8af0b4da90f@nvidia.com>
Date:   Fri, 23 Oct 2020 21:44:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <1-v1-281e425c752f+2df-gup_fork_jgg@nvidia.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1603514665; bh=dZmEj41ZnNcA0Bwj+XEkxo0hna5AZJyyxKSR/d6Km+o=;
        h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Language:
         Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
        b=EoIy1YvBUxSmIyjTrRpnQ0qz8flZqHuGaZky6hgIArWebizbcTNjy9nEXyt+UEX1d
         zAThx4gexPNoDXJG8guDShIWCi23fbC0SoGiQ8whamLT5ILfEvqBwy4djjwmGLkMqN
         2rSEBk5mM8Lcz/DHxmTNB7i5n4yIUI/HWrrcB/h7rdR0qeE6VHq07i69Ah2+wivtBm
         7yyrPwzFyBZH15rIAZesROW7123ckNgrplmCMf80EzeXh1lQbl3QSrcYUlFjtEE4Pc
         ImoMXaBH4vf54hex29sym6hh7UakvnGolKxyFVrFR7dBBt67jruGjbDVUnzEbpe/u7
         LgoUjV+ZmhYfA==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/23/20 5:19 PM, Jason Gunthorpe wrote:
> The next patch in this series makes the lockless flow a little more
> complex, so move the entire block into a new function and remove a level
> of indention. Tidy a bit of cruft:
> 
>   - addr is always the same as start, so use start
>   - Use the modern check_add_overflow() for computing end = start + len
>   - nr_pinned << PAGE_SHIFT needs an unsigned long cast, like nr_pages
>   - The handling of ret and nr_pinned can be streamlined a bit
> 
> No functional change.

Looks nice. Because of the above, which is not just code movement but
quite a bit more than that, I had to rake through it with a fine-toothed
comb to be sure it's OK. I think it is. But as a side effect, I noticed
some tiny polishing ideas that popped up, see below.


> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>   mm/gup.c | 88 +++++++++++++++++++++++++++++---------------------------
>   1 file changed, 46 insertions(+), 42 deletions(-)
> 
> diff --git a/mm/gup.c b/mm/gup.c
> index 102877ed77a4b4..ecbe1639ea2af7 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -2671,13 +2671,42 @@ static int __gup_longterm_unlocked(unsigned long start, int nr_pages,
>   	return ret;
>   }
>   
> +static unsigned int lockless_pages_from_mm(unsigned long addr,

It would be slightly more consistent to use "start" here, too, instead of addr.

Separately, I'm not joyful about the change to unsigned int for the
return type. I understand why you did it and that's perfectly sound
reasoning: there is no -ERRNO possible here, and nr_pinned will always
be >=0. And it's correct, although it does have a type mismatch in the
return value.

However, I'd argue, mildly, that it's better to just leave everything as
"int" for nr_pages and nr_pinned, in gup.c, and just keep all the types
matched perfectly. This helps avoid bugs. And if we want to meaningfully
upgrade that, then either:

a) change all the nr_pages and nr_pinned throughout, to "long", or

b) change all the nr_pages and nr_pinned all function args, and use int
return types throughout, as a "O or -ERRNO, only" return value
convention.



> +					   unsigned long end,
> +					   unsigned int gup_flags,
> +					   struct page **pages)
> +{
> +	unsigned long flags;
> +	int nr_pinned = 0;
> +
> +	if (!IS_ENABLED(CONFIG_HAVE_FAST_GUP) ||
> +	    !gup_fast_permitted(addr, end))

That actually fits on a single 80-col line, so let's leave it that way:

	if (!IS_ENABLED(CONFIG_HAVE_FAST_GUP) || !gup_fast_permitted(addr, end))

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
> +	 * We do not adopt an rcu_read_lock(.) here as we also want to block
> +	 * IPIs that come from THPs splitting.
> +	 */
> +	local_irq_save(flags);
> +	gup_pgd_range(addr, end, gup_flags, pages, &nr_pinned);
> +	local_irq_restore(flags);
> +	return nr_pinned;
> +}
> +
>   static int internal_get_user_pages_fast(unsigned long start, int nr_pages,
>   					unsigned int gup_flags,
>   					struct page **pages)
>   {
> -	unsigned long addr, len, end;
> -	unsigned long flags;
> -	int nr_pinned = 0, ret = 0;
> +	unsigned long len, end;
> +	unsigned int nr_pinned;

If you choose to take the advice above, then this should be left as "int
nr_pinned".

> +	int ret;
>   
>   	if (WARN_ON_ONCE(gup_flags & ~(FOLL_WRITE | FOLL_LONGTERM |
>   				       FOLL_FORCE | FOLL_PIN | FOLL_GET |
> @@ -2691,53 +2720,28 @@ static int internal_get_user_pages_fast(unsigned long start, int nr_pages,
>   		might_lock_read(&current->mm->mmap_lock);
>   
>   	start = untagged_addr(start) & PAGE_MASK;
> -	addr = start;
>   	len = (unsigned long) nr_pages << PAGE_SHIFT;
> -	end = start + len;
> -
> -	if (end <= start)
> +	if (check_add_overflow(start, len, &end))
>   		return 0;

Very nice.

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

I wish I had not copied that comment verbatim when I moved it here. Can
you please delete the weird ".", so that it just reads:

	 * We do not adopt an rcu_read_lock() here, because we also want to

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
> -
> -	if (nr_pinned < nr_pages && !(gup_flags & FOLL_FAST_ONLY)) {
> -		/* Try to get the remaining pages with get_user_pages */
> -		start += nr_pinned << PAGE_SHIFT;
> -		pages += nr_pinned;
> -
> -		ret = __gup_longterm_unlocked(start, nr_pages - nr_pinned,
> -					      gup_flags, pages);
> +	nr_pinned = lockless_pages_from_mm(start, end, gup_flags, pages);
> +	if (nr_pinned == nr_pages || gup_flags & FOLL_FAST_ONLY)
> +		return nr_pinned;
>   
> +	/* Try to get the remaining pages with get_user_pages */

Could we tweak that to this, as long as we're here:

	/* Slow path: Try to get the remaining pages with get_user_pages */


> +	start += (unsigned long)nr_pinned << PAGE_SHIFT;
> +	pages += nr_pinned;
> +	ret = __gup_longterm_unlocked(start, nr_pages - nr_pinned, gup_flags,
> +				      pages);
> +	if (ret < 0) {
>   		/* Have to be a bit careful with return values */

...and can we move that comment up one level, so that it reads:

	/* Have to be a bit careful with return values */
	if (ret < 0) {
		if (nr_pinned)
			return nr_pinned;
		return ret;
	}
	return ret + nr_pinned;

Thinking about this longer term, it would be nice if the whole gup/pup API
set just stopped pretending that anyone cares about partial success, because
they *don't*. If we had return values of "0 or -ERRNO" throughout, and an
additional set of API wrappers that did some sort of limited retry just like
some of the callers do, that would be a happier story.

That has nothing to do with your patch, I'm just baiting Matthew Wilcox and
linux-mm to tell me that they love the idea, or hate it, or don't care. :)


> -		if (nr_pinned > 0) {
> -			if (ret < 0)
> -				ret = nr_pinned;
> -			else
> -				ret += nr_pinned;
> -		}
> +		if (nr_pinned)
> +			return nr_pinned;
> +		return ret;
>   	}
> -
> -	return ret;
> +	return ret + nr_pinned;
>   }
>   /**
>    * get_user_pages_fast_only() - pin user pages in memory
> 

thanks,
-- 
John Hubbard
NVIDIA
