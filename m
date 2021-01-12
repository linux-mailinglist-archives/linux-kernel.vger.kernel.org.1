Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA9CE2F3D45
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 01:43:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725973AbhALVfw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 16:35:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437132AbhALVQQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 16:16:16 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF576C061575
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 13:15:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=XD0MEFOHVAwKRoybdH5YiX94y2AQr1pj0mKrqT0lmqo=; b=eNPxJ8l0qZ15XHVDB0uNUu2ONQ
        99ihURG0KkBqNN6oEzzlwDAoljStq8+AJe7My7joiKsf+gHK3DPp/69vdWlkxLqvCq/hpEpDdzIn+
        9dwUFp/6xVX4cVbcmGyU4VEkgBGVdDy6UJYmVUDNOHAFqW+fa/vSPypnpCgnjYerRLJGhUl5Fr0E8
        xYOLWhybIc4TNZ0BalHH0zTxRUAqcF9FyNz0LKzZQ9stZ6fGApF5SSqtYzCsQ7e+pltqbEoQv43u0
        3LWlsRxysJ3l3LmHcgsn9e6tQ2uuVggklN3i1FBmHRM+E7kYR+Fz/BZiTssRVhF0pE8tXbMGt8ijx
        q5whPgDA==;
Received: from [2601:1c0:6280:3f0::79df]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kzR0b-0005NF-24; Tue, 12 Jan 2021 21:15:21 +0000
Subject: Re: [PATCH v2 14/70] mm/mmap: Change do_brk_flags() to expand
 existing VMA and add do_brk_munmap()
To:     "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@google.com>, Song Liu <songliubraving@fb.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jerome Glisse <jglisse@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Rik van Riel <riel@surriel.com>,
        Peter Zijlstra <peterz@infradead.org>
References: <20210112161240.2024684-1-Liam.Howlett@Oracle.com>
 <20210112161240.2024684-15-Liam.Howlett@Oracle.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <c02c31eb-7063-510f-2c2d-8d18a6bb5eee@infradead.org>
Date:   Tue, 12 Jan 2021 13:15:12 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20210112161240.2024684-15-Liam.Howlett@Oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi--

On 1/12/21 8:11 AM, Liam R. Howlett wrote:
> Avoid allocating a new VMA when it is not necessary.  Expand or contract
> the existing VMA instead.  This avoids unnecessary tree manipulations
> and allocations.
> 
> Once the VMA is known, use it directly when populating to avoid
> unnecessary lookup work.
> 
> Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
> ---
>  mm/mmap.c | 299 +++++++++++++++++++++++++++++++++++++++++++-----------
>  1 file changed, 237 insertions(+), 62 deletions(-)
> 
> diff --git a/mm/mmap.c b/mm/mmap.c
> index a2b32202191d6..f500d5e490f1c 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c



> @@ -2022,8 +2068,7 @@ get_unmapped_area(struct file *file, unsigned long addr, unsigned long len,
>  EXPORT_SYMBOL(get_unmapped_area);
>  
>  /**
> - * find_vma() - Find the VMA for a given address, or the next vma.  May return
> - * NULL in the case of no vma at addr or above
> + * find_vma() - Find the VMA for a given address, or the next vma.
>   * @mm The mm_struct to check

    * @mm: ...

>   * @addr: The address
>   *
> @@ -2777,16 +2825,102 @@ SYSCALL_DEFINE5(remap_file_pages, unsigned long, start, unsigned long, size,
>  }
>  
>  /*
> - *  this is really a simplified "do_mmap".  it only handles
> - *  anonymous maps.  eventually we may be able to do some
> - *  brk-specific accounting here.
> + * bkr_munmap() - Unmap a parital vma.
> + * @mas: The maple tree state.
> + * @vma: The vma to be modified
> + * @newbrk: the start of the address to unmap
> + * @oldbrk: The end of the address to unmap

missing:
 * @uf: ...

> + *
> + * Returns: 0 on success.
> + * unmaps a partial VMA mapping.  Does not handle alignment, downgrades lock if
> + * possible.
>   */
> -static int do_brk_flags(unsigned long addr, unsigned long len,
> -			unsigned long flags, struct list_head *uf)
> +static int do_brk_munmap(struct ma_state *mas, struct vm_area_struct *vma,
> +			 unsigned long newbrk, unsigned long oldbrk,
> +			 struct list_head *uf)
> +{
> +	struct mm_struct *mm = vma->vm_mm;
> +	struct vm_area_struct unmap;
> +	unsigned long unmap_pages;
> +	int ret = 1;
> +
> +	arch_unmap(mm, newbrk, oldbrk);
> +
> +	if (likely(vma->vm_start >= newbrk)) { // remove entire mapping(s)
> +		mas_set(mas, newbrk);
> +		if (vma->vm_start != newbrk)
> +			mas_reset(mas); // cause a re-walk for the first overlap.
> +		ret = do_mas_munmap(mas, mm, newbrk, oldbrk-newbrk, uf, true);
> +		goto munmap_full_vma;
> +	}
> +
> +	vma_init(&unmap, mm);
> +	unmap.vm_start = newbrk;
> +	unmap.vm_end = oldbrk;
> +	ret = userfaultfd_unmap_prep(&unmap, newbrk, oldbrk, uf);
> +	if (ret)
> +		return ret;
> +	ret = 1;
> +
> +	// Change the oldbrk of vma to the newbrk of the munmap area
> +	vma_adjust_trans_huge(vma, vma->vm_start, newbrk, 0);
> +	if (vma->anon_vma) {
> +		anon_vma_lock_write(vma->anon_vma);
> +		anon_vma_interval_tree_pre_update_vma(vma);
> +	}
> +
> +	vma->vm_end = newbrk;
> +	if (vma_mas_remove(&unmap, mas))
> +		goto mas_store_fail;
> +
> +	vmacache_invalidate(vma->vm_mm);
> +	if (vma->anon_vma) {
> +		anon_vma_interval_tree_post_update_vma(vma);
> +		anon_vma_unlock_write(vma->anon_vma);
> +	}
> +
> +	unmap_pages = vma_pages(&unmap);
> +	if (unmap.vm_flags & VM_LOCKED) {
> +		mm->locked_vm -= unmap_pages;
> +		munlock_vma_pages_range(&unmap, newbrk, oldbrk);
> +	}
> +
> +	mmap_write_downgrade(mm);
> +	unmap_region(mm, &unmap, vma, newbrk, oldbrk);
> +	/* Statistics */
> +	vm_stat_account(mm, unmap.vm_flags, -unmap_pages);
> +	if (unmap.vm_flags & VM_ACCOUNT)
> +		vm_unacct_memory(unmap_pages);
> +
> +munmap_full_vma:
> +	validate_mm_mt(mm);
> +	return ret;
> +
> +mas_store_fail:
> +	vma->vm_end = oldbrk;
> +	anon_vma_interval_tree_post_update_vma(vma);
> +	anon_vma_unlock_write(vma->anon_vma);
> +	return -ENOMEM;
> +}
> +
> +/*
> + * do_brk_flags() - Increase the brk vma if the flags match.
> + * @mas: The maple tree state.
> + * @addr: The start address
> + * @len: The length of the increase
> + * @vma: The vma,

s/@vma/@brkvma/ ??

> + * @flags: The VMA Flags
> + *
> + * Extend the brk VMA from addr to addr + len.  If the VMA is NULL or the flags
> + * do not match then create a new anonymous VMA.  Eventually we may be able to
> + * do some brk-specific accounting here.
> + */
> +static int do_brk_flags(struct ma_state *mas, struct vm_area_struct **brkvma,
> +			unsigned long addr, unsigned long len,
> +			unsigned long flags)
>  {
>  	struct mm_struct *mm = current->mm;
> -	struct vm_area_struct *vma, *prev;
> -	pgoff_t pgoff = addr >> PAGE_SHIFT;
> +	struct vm_area_struct *prev = NULL, *vma;
>  	int error;
>  	unsigned long mapped_addr;
>  	validate_mm_mt(mm);




thanks.
-- 
~Randy

