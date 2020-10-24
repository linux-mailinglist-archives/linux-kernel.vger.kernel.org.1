Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFF8B297A50
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Oct 2020 04:09:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758900AbgJXCJe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 22:09:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756462AbgJXCJe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 22:09:34 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31DD4C0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 19:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=RzNHOCYQ4xJRdKe5TcT6iQTXGCT7yybZ343knApl/AA=; b=AD2j7MmhRRxAwLhKomRXF3tlDJ
        CpvodUK4U4D9S5o2yX+9N2c0hZ2izTgcwzrAIjBEAt0YN0gL97/UUpWt8S8rSt6RWuRCQHww86g3V
        Z0RHtsOuXlrZ272JVhhtIYePWYhRzF5DMaGyLn5m9MOdb2mT1oWDtrGPHK3Z9daemIXsrPaP6+UHo
        8G2oLQbRBTYUlldc29uenjMaJA3n+2AuZvkdfPcH0i2Hg/HoCsJuFFT7NBFdzYd8PsHYTroJu28sP
        6hmBhaciBE0oJ2fHDNTXCpmCp8/NCF4NUgoDa7T+IZLFuCrdbVuDA3XZVwfb9355G6wygXNf3s9Xj
        s+PluDkQ==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kW8zi-00086a-3F; Sat, 24 Oct 2020 02:09:22 +0000
Date:   Sat, 24 Oct 2020 03:09:22 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Rik van Riel <riel@surriel.com>
Cc:     Hugh Dickins <hughd@google.com>, Yu Xu <xuyu@linux.alibaba.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>,
        Andrea Arcangeli <aarcange@redhat.com>,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        linux-mm@kvack.org, Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH v4] mm,thp,shmem: limit shmem THP alloc gfp_mask
Message-ID: <20201024020922.GH20115@casper.infradead.org>
References: <20201023204804.3f8d19c1@imladris.surriel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201023204804.3f8d19c1@imladris.surriel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 23, 2020 at 08:48:04PM -0400, Rik van Riel wrote:
> The allocation flags of anonymous transparent huge pages can be controlled
> through the files in /sys/kernel/mm/transparent_hugepage/defrag, which can
> help the system from getting bogged down in the page reclaim and compaction
> code when many THPs are getting allocated simultaneously.
> 
> However, the gfp_mask for shmem THP allocations were not limited by those
> configuration settings, and some workloads ended up with all CPUs stuck
> on the LRU lock in the page reclaim code, trying to allocate dozens of
> THPs simultaneously.
> 
> This patch applies the same configurated limitation of THPs to shmem
> hugepage allocations, to prevent that from happening.
> 
> This way a THP defrag setting of "never" or "defer+madvise" will result
> in quick allocation failures without direct reclaim when no 2MB free
> pages are available.
> 
> With this patch applied, THP allocations for tmpfs will be a little
> more aggressive than today for files mmapped with MADV_HUGEPAGE,
> and a little less aggressive for files that are not mmapped or
> mapped without that flag.

How about this code path though?

shmem_get_pages() [ in i915 ]
  shmem_read_mapping_page_gfp(__GFP_NORETRY | __GFP_NOWARN)
    shmem_getpage_gfp()
      shmem_alloc_and_acct_page()
        shmem_alloc_hugepage()

I feel like the NORETRY from i915 should override whatever is set
in sysfs for anon THPs.  What do others think?

> Signed-off-by: Rik van Riel <riel@surriel.com>
> --- 
> v4: rename alloc_hugepage_direct_gfpmask to vma_thp_gfp_mask (Matthew Wilcox)
> v3: fix NULL vma issue spotted by Hugh Dickins & tested
> v2: move gfp calculation to shmem_getpage_gfp as suggested by Yu Xu
> 
> diff --git a/include/linux/gfp.h b/include/linux/gfp.h
> index c603237e006c..c7615c9ba03c 100644
> --- a/include/linux/gfp.h
> +++ b/include/linux/gfp.h
> @@ -614,6 +614,8 @@ bool gfp_pfmemalloc_allowed(gfp_t gfp_mask);
>  extern void pm_restrict_gfp_mask(void);
>  extern void pm_restore_gfp_mask(void);
>  
> +extern gfp_t vma_thp_gfp_mask(struct vm_area_struct *vma);
> +
>  #ifdef CONFIG_PM_SLEEP
>  extern bool pm_suspended_storage(void);
>  #else
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 9474dbc150ed..c5d03b2f2f2f 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -649,9 +649,9 @@ static vm_fault_t __do_huge_pmd_anonymous_page(struct vm_fault *vmf,
>   *	    available
>   * never: never stall for any thp allocation
>   */
> -static inline gfp_t alloc_hugepage_direct_gfpmask(struct vm_area_struct *vma)
> +gfp_t vma_thp_gfp_mask(struct vm_area_struct *vma)
>  {
> -	const bool vma_madvised = !!(vma->vm_flags & VM_HUGEPAGE);
> +	const bool vma_madvised = vma && (vma->vm_flags & VM_HUGEPAGE);
>  
>  	/* Always do synchronous compaction */
>  	if (test_bit(TRANSPARENT_HUGEPAGE_DEFRAG_DIRECT_FLAG, &transparent_hugepage_flags))
> @@ -744,7 +744,7 @@ vm_fault_t do_huge_pmd_anonymous_page(struct vm_fault *vmf)
>  			pte_free(vma->vm_mm, pgtable);
>  		return ret;
>  	}
> -	gfp = alloc_hugepage_direct_gfpmask(vma);
> +	gfp = vma_thp_gfp_mask(vma);
>  	page = alloc_hugepage_vma(gfp, vma, haddr, HPAGE_PMD_ORDER);
>  	if (unlikely(!page)) {
>  		count_vm_event(THP_FAULT_FALLBACK);
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 537c137698f8..6c3cb192a88d 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -1545,8 +1545,8 @@ static struct page *shmem_alloc_hugepage(gfp_t gfp,
>  		return NULL;
>  
>  	shmem_pseudo_vma_init(&pvma, info, hindex);
> -	page = alloc_pages_vma(gfp | __GFP_COMP | __GFP_NORETRY | __GFP_NOWARN,
> -			HPAGE_PMD_ORDER, &pvma, 0, numa_node_id(), true);
> +	page = alloc_pages_vma(gfp, HPAGE_PMD_ORDER, &pvma, 0, numa_node_id(),
> +			       true);
>  	shmem_pseudo_vma_destroy(&pvma);
>  	if (page)
>  		prep_transhuge_page(page);
> @@ -1802,6 +1802,7 @@ static int shmem_getpage_gfp(struct inode *inode, pgoff_t index,
>  	struct page *page;
>  	enum sgp_type sgp_huge = sgp;
>  	pgoff_t hindex = index;
> +	gfp_t huge_gfp;
>  	int error;
>  	int once = 0;
>  	int alloced = 0;
> @@ -1887,7 +1888,8 @@ static int shmem_getpage_gfp(struct inode *inode, pgoff_t index,
>  	}
>  
>  alloc_huge:
> -	page = shmem_alloc_and_acct_page(gfp, inode, index, true);
> +	huge_gfp = vma_thp_gfp_mask(vma);
> +	page = shmem_alloc_and_acct_page(huge_gfp, inode, index, true);
>  	if (IS_ERR(page)) {
>  alloc_nohuge:
>  		page = shmem_alloc_and_acct_page(gfp, inode,
