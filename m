Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8C3D27717D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 14:49:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727862AbgIXMo4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 08:44:56 -0400
Received: from relay.sw.ru ([185.231.240.75]:58594 "EHLO relay3.sw.ru"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727719AbgIXMop (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 08:44:45 -0400
X-Greylist: delayed 3354 seconds by postgrey-1.27 at vger.kernel.org; Thu, 24 Sep 2020 08:44:41 EDT
Received: from [192.168.15.231]
        by relay3.sw.ru with esmtp (Exim 4.94)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1kLPjE-000u65-Pb; Thu, 24 Sep 2020 14:48:00 +0300
Subject: Re: [PATCH 4/5] mm: Do early cow for pinned pages during fork() for
 ptes
To:     Peter Xu <peterx@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Kirill Shutemov <kirill@shutemov.name>,
        Jann Horn <jannh@google.com>, Oleg Nesterov <oleg@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Leon Romanovsky <leonro@nvidia.com>, Jan Kara <jack@suse.cz>,
        John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Andrea Arcangeli <aarcange@redhat.com>
References: <20200921211744.24758-1-peterx@redhat.com>
 <20200921212028.25184-1-peterx@redhat.com>
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <2a590103-95dc-5aed-6e7a-5f8b58337dd0@virtuozzo.com>
Date:   Thu, 24 Sep 2020 14:48:00 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200921212028.25184-1-peterx@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.09.2020 00:20, Peter Xu wrote:
> This patch is greatly inspired by the discussions on the list from Linus, Jason
> Gunthorpe and others [1].
> 
> It allows copy_pte_range() to do early cow if the pages were pinned on the
> source mm.  Currently we don't have an accurate way to know whether a page is
> pinned or not.  The only thing we have is page_maybe_dma_pinned().  However
> that's good enough for now.  Especially, with the newly added mm->has_pinned
> flag to make sure we won't affect processes that never pinned any pages.
> 
> It would be easier if we can do GFP_KERNEL allocation within copy_one_pte().
> Unluckily, we can't because we're with the page table locks held for both the
> parent and child processes.  So the page copy process needs to be done outside
> copy_one_pte().
> 
> The new COPY_MM_BREAK_COW is introduced for this - copy_one_pte() would return
> this when it finds any pte that may need an early breaking of cow.
> 
> page_duplicate() is used to handle the page copy process in copy_pte_range().
> Of course we need to do that after releasing of the locks.
> 
> The slightly tricky part is page_duplicate() will fill in the copy_mm_data with
> the new page copied and we'll need to re-install the pte again with page table
> locks held again.  That's done in pte_install_copied_page().
> 
> The whole procedure looks quite similar to wp_page_copy() however it's simpler
> because we know the page is special (pinned) and we know we don't need tlb
> flushings because no one is referencing the new mm yet.
> 
> Though we still have to be very careful on maintaining the two pages (one old
> source page, one new allocated page) across all these lock taking/releasing
> process and make sure neither of them will get lost.
> 
> [1] https://lore.kernel.org/lkml/20200914143829.GA1424636@nvidia.com/
> 
> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  mm/memory.c | 174 +++++++++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 167 insertions(+), 7 deletions(-)
> 
> diff --git a/mm/memory.c b/mm/memory.c
> index 1530bb1070f4..8f3521be80ca 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -691,12 +691,72 @@ struct page *vm_normal_page_pmd(struct vm_area_struct *vma, unsigned long addr,
>  
>  #define  COPY_MM_DONE               0
>  #define  COPY_MM_SWAP_CONT          1
> +#define  COPY_MM_BREAK_COW          2
>  
>  struct copy_mm_data {
>  	/* COPY_MM_SWAP_CONT */
>  	swp_entry_t entry;
> +	/* COPY_MM_BREAK_COW */
> +	struct {
> +		struct page *cow_old_page; /* Released by page_duplicate() */
> +		struct page *cow_new_page; /* Released by page_release_cow() */
> +		pte_t cow_oldpte;
> +	};
>  };
>  
> +static inline void page_release_cow(struct copy_mm_data *data)
> +{
> +	/* The old page should only be released in page_duplicate() */
> +	WARN_ON_ONCE(data->cow_old_page);
> +
> +	if (data->cow_new_page) {
> +		put_page(data->cow_new_page);
> +		data->cow_new_page = NULL;
> +	}
> +}
> +
> +/*
> + * Duplicate the page for this PTE.  Returns zero if page copied (so we need to
> + * retry on the same PTE again to arm the copied page very soon), or negative
> + * if error happened.  In all cases, the old page will be properly released.
> + */
> +static int page_duplicate(struct mm_struct *src_mm, struct vm_area_struct *vma,
> +			  unsigned long address, struct copy_mm_data *data)
> +{
> +	struct page *new_page = NULL;
> +	int ret;
> +
> +	/* This should have been set in change_one_pte() when reach here */
> +	WARN_ON_ONCE(!data->cow_old_page);

Despite WARN() is preferred over BUG() in kernel, it looks a little strange that
we catch WARN once here, but later avoid panic in put_page().

> +	new_page = alloc_page_vma(GFP_HIGHUSER_MOVABLE, vma, address);
> +	if (!new_page) {
> +		ret = -ENOMEM;
> +		goto out;
> +	}
> +
> +	copy_user_highpage(new_page, data->cow_old_page, address, vma);
> +	ret = mem_cgroup_charge(new_page, src_mm, GFP_KERNEL);

All failing operations should go first, while copy_user_highpage() should go last.

> +	if (ret) {
> +		put_page(new_page);
> +		ret = -ENOMEM;
> +		goto out;
> +	}
> +
> +	cgroup_throttle_swaprate(new_page, GFP_KERNEL);
> +	__SetPageUptodate(new_page);
> +
> +	/* So far so good; arm the new page for the next attempt */
> +	data->cow_new_page = new_page;
> +
> +out:
> +	/* Always release the old page */
> +	put_page(data->cow_old_page);
> +	data->cow_old_page = NULL;
> +
> +	return ret;
> +}
> +
>  /*
>   * copy one vm_area from one task to the other. Assumes the page tables
>   * already present in the new task to be cleared in the whole range
> @@ -711,6 +771,7 @@ copy_one_pte(struct mm_struct *dst_mm, struct mm_struct *src_mm,
>  	unsigned long vm_flags = vma->vm_flags;
>  	pte_t pte = *src_pte;
>  	struct page *page;
> +	bool wp;
>  
>  	/* pte contains position in swap or file, so copy. */
>  	if (unlikely(!pte_present(pte))) {
> @@ -789,10 +850,7 @@ copy_one_pte(struct mm_struct *dst_mm, struct mm_struct *src_mm,
>  	 * If it's a COW mapping, write protect it both
>  	 * in the parent and the child
>  	 */
> -	if (is_cow_mapping(vm_flags) && pte_write(pte)) {
> -		ptep_set_wrprotect(src_mm, addr, src_pte);
> -		pte = pte_wrprotect(pte);
> -	}
> +	wp = is_cow_mapping(vm_flags) && pte_write(pte);
>  
>  	/*
>  	 * If it's a shared mapping, mark it clean in
> @@ -813,15 +871,80 @@ copy_one_pte(struct mm_struct *dst_mm, struct mm_struct *src_mm,
>  	page = vm_normal_page(vma, addr, pte);
>  	if (page) {
>  		get_page(page);
> +
> +		/*
> +		 * If the page is pinned in source mm, do early cow right now
> +		 * so that the pinned page won't be replaced by another random
> +		 * page without being noticed after the fork().
> +		 *
> +		 * Note: there can be some very rare cases that we'll do
> +		 * unnecessary cow here, due to page_maybe_dma_pinned() is
> +		 * sometimes bogus, and has_pinned flag is currently aggresive
> +		 * too.  However this should be good enough for us for now as
> +		 * long as we covered all the pinned pages.  We can make this
> +		 * better in the future by providing an accurate accounting for
> +		 * pinned pages.
> +		 *
> +		 * Because we'll need to release the locks before doing cow,
> +		 * pass this work to upper layer.
> +		 */
> +		if (READ_ONCE(src_mm->has_pinned) && wp &&
> +		    page_maybe_dma_pinned(page)) {
> +			/* We've got the page already; we're safe */
> +			data->cow_old_page = page;
> +			data->cow_oldpte = *src_pte;
> +			return COPY_MM_BREAK_COW;
> +		}
> +
>  		page_dup_rmap(page, false);
>  		rss[mm_counter(page)]++;
>  	}
>  
> +	if (wp) {
> +		ptep_set_wrprotect(src_mm, addr, src_pte);
> +		pte = pte_wrprotect(pte);
> +	}
> +
>  out_set_pte:
>  	set_pte_at(dst_mm, addr, dst_pte, pte);
>  	return COPY_MM_DONE;
>  }
>  
> +/*
> + * Install the pte with the copied page stored in `data'.  Returns true when
> + * installation completes, or false when src pte has changed.
> + */
> +static int pte_install_copied_page(struct mm_struct *dst_mm,
> +				   struct vm_area_struct *new,
> +				   pte_t *src_pte, pte_t *dst_pte,
> +				   unsigned long addr, int *rss,
> +				   struct copy_mm_data *data)
> +{
> +	struct page *new_page = data->cow_new_page;
> +	pte_t entry;
> +
> +	if (!pte_same(*src_pte, data->cow_oldpte)) {
> +		/* PTE has changed under us.  Release the page and retry */
> +		page_release_cow(data);
> +		return false;
> +	}
> +
> +	entry = mk_pte(new_page, new->vm_page_prot);
> +	entry = pte_sw_mkyoung(entry);
> +	entry = maybe_mkwrite(pte_mkdirty(entry), new);
> +	page_add_new_anon_rmap(new_page, new, addr, false);
> +	set_pte_at(dst_mm, addr, dst_pte, entry);
> +	rss[mm_counter(new_page)]++;
> +
> +	/*
> +	 * Manually clear the new page pointer since we've moved ownership to
> +	 * the newly armed PTE.
> +	 */
> +	data->cow_new_page = NULL;
> +
> +	return true;
> +}
> +
>  static int copy_pte_range(struct mm_struct *dst_mm, struct mm_struct *src_mm,
>  		   pmd_t *dst_pmd, pmd_t *src_pmd, struct vm_area_struct *vma,
>  		   struct vm_area_struct *new,
> @@ -830,16 +953,23 @@ static int copy_pte_range(struct mm_struct *dst_mm, struct mm_struct *src_mm,
>  	pte_t *orig_src_pte, *orig_dst_pte;
>  	pte_t *src_pte, *dst_pte;
>  	spinlock_t *src_ptl, *dst_ptl;
> -	int progress, copy_ret = COPY_MM_DONE;
> +	int progress, ret, copy_ret = COPY_MM_DONE;
>  	int rss[NR_MM_COUNTERS];
>  	struct copy_mm_data data;
>  
>  again:
> +	/* We don't reset this for COPY_MM_BREAK_COW */
> +	memset(&data, 0, sizeof(data));
> +
> +again_break_cow:
>  	init_rss_vec(rss);
>  
>  	dst_pte = pte_alloc_map_lock(dst_mm, dst_pmd, addr, &dst_ptl);
> -	if (!dst_pte)
> +	if (!dst_pte) {
> +		/* Guarantee that the new page is released if there is */
> +		page_release_cow(&data);
>  		return -ENOMEM;
> +	}
>  	src_pte = pte_offset_map(src_pmd, addr);
>  	src_ptl = pte_lockptr(src_mm, src_pmd);
>  	spin_lock_nested(src_ptl, SINGLE_DEPTH_NESTING);
> @@ -859,6 +989,25 @@ static int copy_pte_range(struct mm_struct *dst_mm, struct mm_struct *src_mm,
>  			    spin_needbreak(src_ptl) || spin_needbreak(dst_ptl))
>  				break;
>  		}
> +
> +		if (unlikely(data.cow_new_page)) {
> +			/*
> +			 * If cow_new_page set, we must be at the 2nd round of
> +			 * a previous COPY_MM_BREAK_COW.  Try to arm the new
> +			 * page now.  Note that in all cases page_break_cow()
> +			 * will properly release the objects in copy_mm_data.
> +			 */
> +			WARN_ON_ONCE(copy_ret != COPY_MM_BREAK_COW);
> +			if (pte_install_copied_page(dst_mm, new, src_pte,
> +						    dst_pte, addr, rss,
> +						    &data)) {

It looks a little confusing, that all helpers in this function return 0 in case of success,
while pte_install_copied_page() returns true. Won't be better to return 0 and -EAGAIN instead
from it?

> +				/* We installed the pte successfully; move on */
> +				progress++;
> +				continue;
> +			}
> +			/* PTE changed.  Retry this pte (falls through) */
> +		}
> +
>  		if (pte_none(*src_pte)) {
>  			progress++;
>  			continue;
> @@ -882,8 +1031,19 @@ static int copy_pte_range(struct mm_struct *dst_mm, struct mm_struct *src_mm,
>  		if (add_swap_count_continuation(data.entry, GFP_KERNEL) < 0)
>  			return -ENOMEM;
>  		break;
> -	default:
> +	case COPY_MM_BREAK_COW:
> +		/* Do accounting onto parent mm directly */
> +		ret = page_duplicate(src_mm, vma, addr, &data);
> +		if (ret)
> +			return ret;
> +		goto again_break_cow;
> +	case COPY_MM_DONE:
> +		/* This means we're all good. */
>  		break;
> +	default:
> +		/* This should mean copy_ret < 0.  Time to fail this fork().. */
> +		WARN_ON_ONCE(copy_ret >= 0);
> +		return copy_ret;
>  	}
>  
>  	if (addr != end)
> 

