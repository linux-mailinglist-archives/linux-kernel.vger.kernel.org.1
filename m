Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A1982C60BF
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 09:18:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726760AbgK0IPE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 03:15:04 -0500
Received: from mx2.suse.de ([195.135.220.15]:39700 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725616AbgK0IPE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 03:15:04 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1606464901; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ip7MWk8vAkxs5znMPhTijonXmPq5zuvObTXdOJ83AZ0=;
        b=LWUMFtM92bOPkMj8iQu+WhuRX5EiDjBI33xReqUFQQCXjM0NlNTjbufGXMUPAhO4thQphs
        teQ4W9KgtNHBBBDc9pAXJakMcSi/E7DAlNemyfpVgeVo4DYLBkSO74L1BYUCPm68yNMCXa
        pFCEJJAVFiXL+Z2b2FjKCbtzoMrMM3o=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C24F7AC2F;
        Fri, 27 Nov 2020 08:15:01 +0000 (UTC)
Date:   Fri, 27 Nov 2020 09:15:00 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Rik van Riel <riel@surriel.com>
Cc:     hughd@google.com, xuyu@linux.alibaba.com,
        akpm@linux-foundation.org, mgorman@suse.de, aarcange@redhat.com,
        willy@infradead.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, linux-mm@kvack.org, vbabka@suse.cz
Subject: Re: [PATCH 1/3] mm,thp,shmem: limit shmem THP alloc gfp_mask
Message-ID: <20201127081500.GL31550@dhcp22.suse.cz>
References: <20201124194925.623931-1-riel@surriel.com>
 <20201124194925.623931-2-riel@surriel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201124194925.623931-2-riel@surriel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 24-11-20 14:49:23, Rik van Riel wrote:
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
> Controlling the gfp_mask of THP allocations through the knobs in
> sysfs allows users to determine the balance between how aggressively
> the system tries to allocate THPs at fault time, and how much the
> application may end up stalling attempting those allocations.
> 
> This way a THP defrag setting of "never" or "defer+madvise" will result
> in quick allocation failures without direct reclaim when no 2MB free
> pages are available.
> 
> With this patch applied, THP allocations for tmpfs will be a little
> more aggressive than today for files mmapped with MADV_HUGEPAGE,
> and a little less aggressive for files that are not mmapped or
> mapped without that flag.

As already said I am not against this unification. On the other I really
hope that we will not hear about somebody really requesting a per mount
control over this behavior because some might be benefiting from THPs
more than others and the initial cost would pay off. This is not
something we do care about now so this patch wouldn't regress in that
aspect.

> Signed-off-by: Rik van Riel <riel@surriel.com>

Acked-by: Michal Hocko <mhocko@suse.com>

Btw. Documentation/admin-guide/mm/transhuge.rst needs some update as
well. What about the following?

diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation/admin-guide/mm/transhuge.rst
index b2acd0d395ca..41fe84c5b808 100644
--- a/Documentation/admin-guide/mm/transhuge.rst
+++ b/Documentation/admin-guide/mm/transhuge.rst
@@ -104,7 +104,7 @@ regions (to avoid the risk of consuming more memory resources) or enabled
 	echo never >/sys/kernel/mm/transparent_hugepage/enabled
 
 It's also possible to limit defrag efforts in the VM to generate
-anonymous hugepages in case they're not immediately free to madvise
+anonymous and shmem hugepages in case they're not immediately free to madvise
 regions or to never try to defrag memory and simply fallback to regular
 pages unless hugepages are immediately available. Clearly if we spend CPU
 time to defrag memory, we would expect to gain even more by the fact we

> ---
>  include/linux/gfp.h | 2 ++
>  mm/huge_memory.c    | 6 +++---
>  mm/shmem.c          | 8 +++++---
>  3 files changed, 10 insertions(+), 6 deletions(-)
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
> -- 
> 2.25.4

-- 
Michal Hocko
SUSE Labs
