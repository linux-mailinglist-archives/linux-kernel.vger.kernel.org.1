Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8927B2E32B5
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Dec 2020 21:37:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726194AbgL0UdY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Dec 2020 15:33:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726067AbgL0UdX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Dec 2020 15:33:23 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AAA9C061794
        for <linux-kernel@vger.kernel.org>; Sun, 27 Dec 2020 12:32:43 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id g20so11992872ejb.1
        for <linux-kernel@vger.kernel.org>; Sun, 27 Dec 2020 12:32:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tometzki.de; s=google;
        h=date:from:to:cc:subject:message-id:reply-to:mail-followup-to
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=SLf/bQHuPIk4kCUSXjBvZosjTCtFoLnAczMk9hzDGw0=;
        b=hOaOqRDsDWRR7Zd5L3bK6xnnsbQq6NWMNf1omt0sLcofEbO9bn6BPJpOg8r+4+DFYD
         RrCcWyzlA8tB6JJVOzdubKhdy+TXT7kqPEdk2iCHAktZIpaVhRKRvJePE1sjZOLhXYaf
         W09CzGpbNkw3Z3PCUC4uxcatMuK9L+E9AFB89CUOvJzoeWwwD9qkMK88s8oiVSxYKm35
         kt45u+PmDiGFBZf8d/smMWnYt5iHuXKKwaqt/h7/RK3OlXPRuU4k6ZJWR/fP49HfeV+J
         dszCwJEARt07zWBfJ7EmiPJEmJk9j+itfrsf7dJyT1IXSgjTgG3tjeO2COBL+XPAnazo
         mHkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=SLf/bQHuPIk4kCUSXjBvZosjTCtFoLnAczMk9hzDGw0=;
        b=enED4odpfdO5QoL5J5vj7g/kZas2oVBhmpfT7Sx0KfhdtLtCTZWJVFuTSfLtTCJCe5
         XOvOHlUkfSCOpWBBi7mIuqFvyk8Sy+SHvQzmz9DXhxeE6w7Zqkrru93KSiFlwwgn+MPw
         KxbnvRJGIHuxI/XdilbTFASAi1lW/EZ/iISVH3egnQ6LfqGtEINtRMS6EWc4MLcox7Yu
         DFgXsP7WIXf4Y+a7wfuit2PgJKWZrQKj48o/IhNc6FvXOB1lkEzmCDG9LSaKidBoHUhE
         J5a/dEcSWwcociWgSoMq/0qzyWHj+yreEwWfBB31bjqdAgA84AYjPIIdz7NM2WaWmMNX
         RG5A==
X-Gm-Message-State: AOAM5303uqTvX9g54XsawXLi6UCYj/uNIJ+YgPgZvtRNi7klKMqHlLML
        ZyQnIfvdcUxYUENSkwqr0Ee4hA==
X-Google-Smtp-Source: ABdhPJz9lND6jenE4yJViyO/k+i8ByeuJD/UHH11fv/AlJUIleGM5XqAEYjb5/bodoHBab6R4PqOfg==
X-Received: by 2002:a17:906:378f:: with SMTP id n15mr38567548ejc.263.1609101161687;
        Sun, 27 Dec 2020 12:32:41 -0800 (PST)
Received: from fedora.tometzki.de (p200300e68f334e009f56fbcb8d40a599.dip0.t-ipconnect.de. [2003:e6:8f33:4e00:9f56:fbcb:8d40:a599])
        by smtp.gmail.com with ESMTPSA id gl23sm11446551ejb.87.2020.12.27.12.32.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Dec 2020 12:32:41 -0800 (PST)
Date:   Sun, 27 Dec 2020 21:32:37 +0100
From:   Damian Tometzki <linux@tometzki.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Hugh Dickins <hughd@google.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Will Deacon <will@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jan Kara <jack@suse.cz>, Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vinayak Menon <vinmenon@codeaurora.org>,
        Android Kernel Team <kernel-team@android.com>
Subject: Re: [PATCH 1/2] mm: Allow architectures to request 'old' entries
 when prefaulting
Message-ID: <X+jvZchuTptrxkCH@fedora.tometzki.de>
Reply-To: Damian Tometzki <damian@tometzki.de>
Mail-Followup-To: Linus Torvalds <torvalds@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Will Deacon <will@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>, Jan Kara <jack@suse.cz>,
        Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vinayak Menon <vinmenon@codeaurora.org>,
        Android Kernel Team <kernel-team@android.com>
References: <alpine.LSU.2.11.2012231905300.5723@eggly.anvils>
 <20201225113157.e7hmluffh56fszfc@box>
 <CAHk-=wiT50aEErZgZOrbFQ=GhFuM3MnBmHoSBSScN9rmXMnOKQ@mail.gmail.com>
 <20201226204335.dikqkrkezqet6oqf@box>
 <alpine.LSU.2.11.2012261246450.1629@eggly.anvils>
 <CAHk-=wjesveWEQZ4tqRssSSQvuxx46LqYfME+uxKfghxAe6U_w@mail.gmail.com>
 <20201226224016.dxjmordcfj75xgte@box>
 <alpine.LSU.2.11.2012261623140.1022@eggly.anvils>
 <alpine.LSU.2.11.2012261816520.1071@eggly.anvils>
 <CAHk-=wjHvipz5DqWUFP5zuPK-kWM4QD-eokf75V8NGNATnn+BQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=wjHvipz5DqWUFP5zuPK-kWM4QD-eokf75V8NGNATnn+BQ@mail.gmail.com>
User-Agent: Mutt
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 27. Dec 11:38, Linus Torvalds wrote:
> On Sat, Dec 26, 2020 at 6:38 PM Hugh Dickins <hughd@google.com> wrote:
> >
> > This patch (like its antecedents) moves the pte_unmap_unlock() from
> > after do_fault_around()'s "check if the page fault is solved" into
> > filemap_map_pages() itself (which apparently does not NULLify vmf->pte
> > after unmapping it, which is poor, but good for revealing this issue).
> > That looks cleaner, but of course there was a very good reason for its
> > original positioning.
> 
> Good catch.
> 
> > Maybe you want to change the ->map_pages prototype, to pass down the
> > requested address too, so that it can report whether the requested
> > address was resolved or not.  Or it could be left to __do_fault(),
> > or even to a repeated fault; but those would be less efficient.
> 
> Let's keep the old really odd "let's unlock in the caller" for now,
> and minimize the changes.
> 
> Adding a big big comment at the end of filemap_map_pages() to note the
> odd delayed page table unlocking.
> 
> Here's an updated patch that combines Kirill's original patch, his
> additional incremental patch, and the fix for the pte lock oddity into
> one thing.
> 
> Does this finally pass your testing?
> 
>                Linus
Hello together,

when i try to build this patch, i got the following error:

 CC      arch/x86/kernel/cpu/mce/threshold.o
mm/memory.c:3716:19: error: static declaration of ‘do_set_pmd’ follows non-static declaration
 static vm_fault_t do_set_pmd(struct vm_fault *vmf, struct page *page)
                   ^~~~~~~~~~
In file included from mm/memory.c:43:
./include/linux/mm.h:984:12: note: previous declaration of ‘do_set_pmd’ was here
 vm_fault_t do_set_pmd(struct vm_fault *vmf, struct page *page);
            ^~~~~~~~~~
make[3]: *** [scripts/Makefile.build:279: mm/memory.o] Error 1
make[2]: *** [Makefile:1805: mm] Error 2
make[2]: *** Waiting for unfinished jobs....
  CC      arch/x86/kernel/cpu/mce/therm_throt.o

Best regards
Damian

> From 4d221d934d112aa40c3f4978460be098fc9ce831 Mon Sep 17 00:00:00 2001
> From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> Date: Sat, 19 Dec 2020 15:19:23 +0300
> Subject: [PATCH] mm: Cleanup faultaround and finish_fault() codepaths
> 
> alloc_set_pte() has two users with different requirements: in the
> faultaround code, it called from an atomic context and PTE page table
> has to be preallocated. finish_fault() can sleep and allocate page table
> as needed.
> 
> PTL locking rules are also strange, hard to follow and overkill for
> finish_fault().
> 
> Let's untangle the mess. alloc_set_pte() has gone now. All locking is
> explicit.
> 
> The price is some code duplication to handle huge pages in faultaround
> path, but it should be fine, having overall improvement in readability.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
> ---
>  include/linux/mm.h      |   8 +-
>  include/linux/pgtable.h |  11 +++
>  mm/filemap.c            | 168 ++++++++++++++++++++++++++++++----------
>  mm/memory.c             | 161 +++++++++++---------------------------
>  4 files changed, 192 insertions(+), 156 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 5299b90a6c40..c0643a0ad5ff 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -535,8 +535,8 @@ struct vm_fault {
>  					 * is not NULL, otherwise pmd.
>  					 */
>  	pgtable_t prealloc_pte;		/* Pre-allocated pte page table.
> -					 * vm_ops->map_pages() calls
> -					 * alloc_set_pte() from atomic context.
> +					 * vm_ops->map_pages() sets up a page
> +					 * table from from atomic context.
>  					 * do_fault_around() pre-allocates
>  					 * page table to avoid allocation from
>  					 * atomic context.
> @@ -981,7 +981,9 @@ static inline pte_t maybe_mkwrite(pte_t pte, struct vm_area_struct *vma)
>  	return pte;
>  }
>  
> -vm_fault_t alloc_set_pte(struct vm_fault *vmf, struct page *page);
> +vm_fault_t do_set_pmd(struct vm_fault *vmf, struct page *page);
> +void do_set_pte(struct vm_fault *vmf, struct page *page);
> +
>  vm_fault_t finish_fault(struct vm_fault *vmf);
>  vm_fault_t finish_mkwrite_fault(struct vm_fault *vmf);
>  #endif
> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> index 8fcdfa52eb4b..36eb748f3c97 100644
> --- a/include/linux/pgtable.h
> +++ b/include/linux/pgtable.h
> @@ -1314,6 +1314,17 @@ static inline int pmd_trans_unstable(pmd_t *pmd)
>  #endif
>  }
>  
> +/*
> + * the ordering of these checks is important for pmds with _page_devmap set.
> + * if we check pmd_trans_unstable() first we will trip the bad_pmd() check
> + * inside of pmd_none_or_trans_huge_or_clear_bad(). this will end up correctly
> + * returning 1 but not before it spams dmesg with the pmd_clear_bad() output.
> + */
> +static inline int pmd_devmap_trans_unstable(pmd_t *pmd)
> +{
> +	return pmd_devmap(*pmd) || pmd_trans_unstable(pmd);
> +}
> +
>  #ifndef CONFIG_NUMA_BALANCING
>  /*
>   * Technically a PTE can be PROTNONE even when not doing NUMA balancing but
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 5c9d564317a5..dbc2eda92a53 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -42,6 +42,7 @@
>  #include <linux/psi.h>
>  #include <linux/ramfs.h>
>  #include <linux/page_idle.h>
> +#include <asm/pgalloc.h>
>  #include "internal.h"
>  
>  #define CREATE_TRACE_POINTS
> @@ -2911,50 +2912,133 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
>  }
>  EXPORT_SYMBOL(filemap_fault);
>  
> +static bool filemap_map_pmd(struct vm_fault *vmf, struct page *page)
> +{
> +	struct mm_struct *mm = vmf->vma->vm_mm;
> +
> +	/* Huge page is mapped? No need to proceed. */
> +	if (pmd_trans_huge(*vmf->pmd)) {
> +		unlock_page(page);
> +		put_page(page);
> +		return true;
> +	}
> +
> +	if (pmd_none(*vmf->pmd) && PageTransHuge(page)) {
> +	    vm_fault_t ret = do_set_pmd(vmf, page);
> +	    if (!ret) {
> +		    /* The page is mapped successfully, reference consumed. */
> +		    unlock_page(page);
> +		    return true;
> +	    }
> +	}
> +
> +	if (pmd_none(*vmf->pmd)) {
> +		vmf->ptl = pmd_lock(mm, vmf->pmd);
> +		if (likely(pmd_none(*vmf->pmd))) {
> +			mm_inc_nr_ptes(mm);
> +			pmd_populate(mm, vmf->pmd, vmf->prealloc_pte);
> +			vmf->prealloc_pte = NULL;
> +		}
> +		spin_unlock(vmf->ptl);
> +	}
> +
> +	/* See comment in handle_pte_fault() */
> +	if (pmd_devmap_trans_unstable(vmf->pmd)) {
> +		unlock_page(page);
> +		put_page(page);
> +		return true;
> +	}
> +
> +	return false;
> +}
> +
> +static struct page *next_uptodate_page(struct page *page, struct vm_fault *vmf,
> +				     struct xa_state *xas, pgoff_t end_pgoff)
> +{
> +	struct address_space *mapping = vmf->vma->vm_file->f_mapping;
> +	unsigned long max_idx;
> +
> +	do {
> +		if (!page)
> +			return NULL;
> +		if (xas_retry(xas, page))
> +			continue;
> +		if (xa_is_value(page))
> +			continue;
> +		if (PageLocked(page))
> +			continue;
> +		if (!page_cache_get_speculative(page))
> +			continue;
> +		/* Has the page moved or been split? */
> +		if (unlikely(page != xas_reload(xas)))
> +			goto skip;
> +		if (!PageUptodate(page) || PageReadahead(page))
> +			goto skip;
> +		if (PageHWPoison(page))
> +			goto skip;
> +		if (!trylock_page(page))
> +			goto skip;
> +		if (page->mapping != mapping)
> +			goto unlock;
> +		if (!PageUptodate(page))
> +			goto unlock;
> +		max_idx = DIV_ROUND_UP(i_size_read(mapping->host), PAGE_SIZE);
> +		if (xas->xa_index >= max_idx)
> +			goto unlock;
> +		return page;
> +unlock:
> +		unlock_page(page);
> +skip:
> +		put_page(page);
> +	} while ((page = xas_next_entry(xas, end_pgoff)) != NULL);
> +
> +	return NULL;
> +}
> +
> +static inline struct page *first_map_page(struct vm_fault *vmf,
> +					  struct xa_state *xas,
> +					  pgoff_t end_pgoff)
> +{
> +	return next_uptodate_page(xas_find(xas, end_pgoff),
> +				  vmf, xas, end_pgoff);
> +}
> +
> +static inline struct page *next_map_page(struct vm_fault *vmf,
> +					  struct xa_state *xas,
> +					  pgoff_t end_pgoff)
> +{
> +	return next_uptodate_page(xas_next_entry(xas, end_pgoff),
> +				  vmf, xas, end_pgoff);
> +}
> +
>  void filemap_map_pages(struct vm_fault *vmf,
>  		pgoff_t start_pgoff, pgoff_t end_pgoff)
>  {
> -	struct file *file = vmf->vma->vm_file;
> +	struct vm_area_struct *vma = vmf->vma;
> +	struct file *file = vma->vm_file;
>  	struct address_space *mapping = file->f_mapping;
>  	pgoff_t last_pgoff = start_pgoff;
> -	unsigned long max_idx;
>  	XA_STATE(xas, &mapping->i_pages, start_pgoff);
>  	struct page *head, *page;
>  	unsigned int mmap_miss = READ_ONCE(file->f_ra.mmap_miss);
>  
>  	rcu_read_lock();
> -	xas_for_each(&xas, head, end_pgoff) {
> -		if (xas_retry(&xas, head))
> -			continue;
> -		if (xa_is_value(head))
> -			goto next;
> +	head = first_map_page(vmf, &xas, end_pgoff);
> +	if (!head) {
> +		rcu_read_unlock();
> +		return;
> +	}
>  
> -		/*
> -		 * Check for a locked page first, as a speculative
> -		 * reference may adversely influence page migration.
> -		 */
> -		if (PageLocked(head))
> -			goto next;
> -		if (!page_cache_get_speculative(head))
> -			goto next;
> +	if (filemap_map_pmd(vmf, head)) {
> +		rcu_read_unlock();
> +		return;
> +	}
>  
> -		/* Has the page moved or been split? */
> -		if (unlikely(head != xas_reload(&xas)))
> -			goto skip;
> +	vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd,
> +				       vmf->address, &vmf->ptl);
> +	do {
>  		page = find_subpage(head, xas.xa_index);
> -
> -		if (!PageUptodate(head) ||
> -				PageReadahead(page) ||
> -				PageHWPoison(page))
> -			goto skip;
> -		if (!trylock_page(head))
> -			goto skip;
> -
> -		if (head->mapping != mapping || !PageUptodate(head))
> -			goto unlock;
> -
> -		max_idx = DIV_ROUND_UP(i_size_read(mapping->host), PAGE_SIZE);
> -		if (xas.xa_index >= max_idx)
> +		if (PageHWPoison(page))
>  			goto unlock;
>  
>  		if (mmap_miss > 0)
> @@ -2964,19 +3048,25 @@ void filemap_map_pages(struct vm_fault *vmf,
>  		if (vmf->pte)
>  			vmf->pte += xas.xa_index - last_pgoff;
>  		last_pgoff = xas.xa_index;
> -		if (alloc_set_pte(vmf, page))
> +
> +		if (!pte_none(*vmf->pte))
>  			goto unlock;
> +
> +		do_set_pte(vmf, page);
> +		/* no need to invalidate: a not-present page won't be cached */
> +		update_mmu_cache(vma, vmf->address, vmf->pte);
>  		unlock_page(head);
> -		goto next;
> +		continue;
>  unlock:
>  		unlock_page(head);
> -skip:
>  		put_page(head);
> -next:
> -		/* Huge page is mapped? No need to proceed. */
> -		if (pmd_trans_huge(*vmf->pmd))
> -			break;
> -	}
> +	} while ((head = next_map_page(vmf, &xas, end_pgoff)) != NULL);
> +
> +	/*
> +	 * NOTE! We return with the pte still locked! It is unlocked
> +	 * by do_fault_around() after it has tested whether the target
> +	 * address got filled in.
> +	 */
>  	rcu_read_unlock();
>  	WRITE_ONCE(file->f_ra.mmap_miss, mmap_miss);
>  }
> diff --git a/mm/memory.c b/mm/memory.c
> index 7d608765932b..07a408c7d38b 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -3501,7 +3501,7 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
>  	if (pte_alloc(vma->vm_mm, vmf->pmd))
>  		return VM_FAULT_OOM;
>  
> -	/* See the comment in pte_alloc_one_map() */
> +	/* See comment in handle_pte_fault() */
>  	if (unlikely(pmd_trans_unstable(vmf->pmd)))
>  		return 0;
>  
> @@ -3641,66 +3641,6 @@ static vm_fault_t __do_fault(struct vm_fault *vmf)
>  	return ret;
>  }
>  
> -/*
> - * The ordering of these checks is important for pmds with _PAGE_DEVMAP set.
> - * If we check pmd_trans_unstable() first we will trip the bad_pmd() check
> - * inside of pmd_none_or_trans_huge_or_clear_bad(). This will end up correctly
> - * returning 1 but not before it spams dmesg with the pmd_clear_bad() output.
> - */
> -static int pmd_devmap_trans_unstable(pmd_t *pmd)
> -{
> -	return pmd_devmap(*pmd) || pmd_trans_unstable(pmd);
> -}
> -
> -static vm_fault_t pte_alloc_one_map(struct vm_fault *vmf)
> -{
> -	struct vm_area_struct *vma = vmf->vma;
> -
> -	if (!pmd_none(*vmf->pmd))
> -		goto map_pte;
> -	if (vmf->prealloc_pte) {
> -		vmf->ptl = pmd_lock(vma->vm_mm, vmf->pmd);
> -		if (unlikely(!pmd_none(*vmf->pmd))) {
> -			spin_unlock(vmf->ptl);
> -			goto map_pte;
> -		}
> -
> -		mm_inc_nr_ptes(vma->vm_mm);
> -		pmd_populate(vma->vm_mm, vmf->pmd, vmf->prealloc_pte);
> -		spin_unlock(vmf->ptl);
> -		vmf->prealloc_pte = NULL;
> -	} else if (unlikely(pte_alloc(vma->vm_mm, vmf->pmd))) {
> -		return VM_FAULT_OOM;
> -	}
> -map_pte:
> -	/*
> -	 * If a huge pmd materialized under us just retry later.  Use
> -	 * pmd_trans_unstable() via pmd_devmap_trans_unstable() instead of
> -	 * pmd_trans_huge() to ensure the pmd didn't become pmd_trans_huge
> -	 * under us and then back to pmd_none, as a result of MADV_DONTNEED
> -	 * running immediately after a huge pmd fault in a different thread of
> -	 * this mm, in turn leading to a misleading pmd_trans_huge() retval.
> -	 * All we have to ensure is that it is a regular pmd that we can walk
> -	 * with pte_offset_map() and we can do that through an atomic read in
> -	 * C, which is what pmd_trans_unstable() provides.
> -	 */
> -	if (pmd_devmap_trans_unstable(vmf->pmd))
> -		return VM_FAULT_NOPAGE;
> -
> -	/*
> -	 * At this point we know that our vmf->pmd points to a page of ptes
> -	 * and it cannot become pmd_none(), pmd_devmap() or pmd_trans_huge()
> -	 * for the duration of the fault.  If a racing MADV_DONTNEED runs and
> -	 * we zap the ptes pointed to by our vmf->pmd, the vmf->ptl will still
> -	 * be valid and we will re-check to make sure the vmf->pte isn't
> -	 * pte_none() under vmf->ptl protection when we return to
> -	 * alloc_set_pte().
> -	 */
> -	vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd, vmf->address,
> -			&vmf->ptl);
> -	return 0;
> -}
> -
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>  static void deposit_prealloc_pte(struct vm_fault *vmf)
>  {
> @@ -3715,7 +3655,7 @@ static void deposit_prealloc_pte(struct vm_fault *vmf)
>  	vmf->prealloc_pte = NULL;
>  }
>  
> -static vm_fault_t do_set_pmd(struct vm_fault *vmf, struct page *page)
> +vm_fault_t do_set_pmd(struct vm_fault *vmf, struct page *page)
>  {
>  	struct vm_area_struct *vma = vmf->vma;
>  	bool write = vmf->flags & FAULT_FLAG_WRITE;
> @@ -3780,45 +3720,11 @@ static vm_fault_t do_set_pmd(struct vm_fault *vmf, struct page *page)
>  }
>  #endif
>  
> -/**
> - * alloc_set_pte - setup new PTE entry for given page and add reverse page
> - * mapping. If needed, the function allocates page table or use pre-allocated.
> - *
> - * @vmf: fault environment
> - * @page: page to map
> - *
> - * Caller must take care of unlocking vmf->ptl, if vmf->pte is non-NULL on
> - * return.
> - *
> - * Target users are page handler itself and implementations of
> - * vm_ops->map_pages.
> - *
> - * Return: %0 on success, %VM_FAULT_ code in case of error.
> - */
> -vm_fault_t alloc_set_pte(struct vm_fault *vmf, struct page *page)
> +void do_set_pte(struct vm_fault *vmf, struct page *page)
>  {
>  	struct vm_area_struct *vma = vmf->vma;
>  	bool write = vmf->flags & FAULT_FLAG_WRITE;
>  	pte_t entry;
> -	vm_fault_t ret;
> -
> -	if (pmd_none(*vmf->pmd) && PageTransCompound(page)) {
> -		ret = do_set_pmd(vmf, page);
> -		if (ret != VM_FAULT_FALLBACK)
> -			return ret;
> -	}
> -
> -	if (!vmf->pte) {
> -		ret = pte_alloc_one_map(vmf);
> -		if (ret)
> -			return ret;
> -	}
> -
> -	/* Re-check under ptl */
> -	if (unlikely(!pte_none(*vmf->pte))) {
> -		update_mmu_tlb(vma, vmf->address, vmf->pte);
> -		return VM_FAULT_NOPAGE;
> -	}
>  
>  	flush_icache_page(vma, page);
>  	entry = mk_pte(page, vma->vm_page_prot);
> @@ -3835,14 +3741,8 @@ vm_fault_t alloc_set_pte(struct vm_fault *vmf, struct page *page)
>  		page_add_file_rmap(page, false);
>  	}
>  	set_pte_at(vma->vm_mm, vmf->address, vmf->pte, entry);
> -
> -	/* no need to invalidate: a not-present page won't be cached */
> -	update_mmu_cache(vma, vmf->address, vmf->pte);
> -
> -	return 0;
>  }
>  
> -
>  /**
>   * finish_fault - finish page fault once we have prepared the page to fault
>   *
> @@ -3860,12 +3760,12 @@ vm_fault_t alloc_set_pte(struct vm_fault *vmf, struct page *page)
>   */
>  vm_fault_t finish_fault(struct vm_fault *vmf)
>  {
> +	struct vm_area_struct *vma = vmf->vma;
>  	struct page *page;
> -	vm_fault_t ret = 0;
> +	vm_fault_t ret;
>  
>  	/* Did we COW the page? */
> -	if ((vmf->flags & FAULT_FLAG_WRITE) &&
> -	    !(vmf->vma->vm_flags & VM_SHARED))
> +	if ((vmf->flags & FAULT_FLAG_WRITE) && !(vma->vm_flags & VM_SHARED))
>  		page = vmf->cow_page;
>  	else
>  		page = vmf->page;
> @@ -3874,13 +3774,35 @@ vm_fault_t finish_fault(struct vm_fault *vmf)
>  	 * check even for read faults because we might have lost our CoWed
>  	 * page
>  	 */
> -	if (!(vmf->vma->vm_flags & VM_SHARED))
> -		ret = check_stable_address_space(vmf->vma->vm_mm);
> -	if (!ret)
> -		ret = alloc_set_pte(vmf, page);
> -	if (vmf->pte)
> -		pte_unmap_unlock(vmf->pte, vmf->ptl);
> -	return ret;
> +	if (!(vma->vm_flags & VM_SHARED))
> +		ret = check_stable_address_space(vma->vm_mm);
> +	if (ret)
> +		return ret;
> +
> +	if (pmd_none(*vmf->pmd)) {
> +		if (PageTransCompound(page)) {
> +			ret = do_set_pmd(vmf, page);
> +			if (ret != VM_FAULT_FALLBACK)
> +				return ret;
> +		}
> +
> +		if (unlikely(pte_alloc(vma->vm_mm, vmf->pmd)))
> +			return VM_FAULT_OOM;
> +	}
> +
> +	/* See comment in handle_pte_fault() */
> +	if (pmd_devmap_trans_unstable(vmf->pmd))
> +		return 0;
> +
> +	vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd,
> +				      vmf->address, &vmf->ptl);
> +	/* Re-check under ptl */
> +	if (likely(pte_none(*vmf->pte)))
> +		do_set_pte(vmf, page);
> +
> +	update_mmu_tlb(vma, vmf->address, vmf->pte);
> +	pte_unmap_unlock(vmf->pte, vmf->ptl);
> +	return 0;
>  }
>  
>  static unsigned long fault_around_bytes __read_mostly =
> @@ -4351,7 +4273,18 @@ static vm_fault_t handle_pte_fault(struct vm_fault *vmf)
>  		 */
>  		vmf->pte = NULL;
>  	} else {
> -		/* See comment in pte_alloc_one_map() */
> +		/*
> +		 * If a huge pmd materialized under us just retry later.  Use
> +		 * pmd_trans_unstable() via pmd_devmap_trans_unstable() instead
> +		 * of pmd_trans_huge() to ensure the pmd didn't become
> +		 * pmd_trans_huge under us and then back to pmd_none, as a
> +		 * result of MADV_DONTNEED running immediately after a huge pmd
> +		 * fault in a different thread of this mm, in turn leading to a
> +		 * misleading pmd_trans_huge() retval. All we have to ensure is
> +		 * that it is a regular pmd that we can walk with
> +		 * pte_offset_map() and we can do that through an atomic read
> +		 * in C, which is what pmd_trans_unstable() provides.
> +		 */
>  		if (pmd_devmap_trans_unstable(vmf->pmd))
>  			return 0;
>  		/*
> -- 
> 2.29.2.157.g1d47791a39
> 

