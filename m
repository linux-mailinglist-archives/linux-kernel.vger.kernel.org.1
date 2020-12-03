Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A1BD2CD1EB
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 10:00:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729973AbgLCI6d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 03:58:33 -0500
Received: from mx2.suse.de ([195.135.220.15]:32962 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726623AbgLCI6c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 03:58:32 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1606985866; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ln3Pm20ZaJuOuL271okwbIe6rExjknKU69nUHr8eu+4=;
        b=HMHcnvypAkDdQDgAFRkWTM8LYhwJt4JbXEcoO2T7TeL+unuNAbiOa0UAqN261i/pHAQuGN
        jLlrh/YlVgsxWFgWHOXjQRPuGdGiV8/PiqG911didNEguornWBtQxAlkSTBV0fSEqYqEpg
        bIh33QK8OXBmxWrXrxxfpKt6xneWfT0=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E5BF4AC55;
        Thu,  3 Dec 2020 08:57:45 +0000 (UTC)
Date:   Thu, 3 Dec 2020 09:57:44 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Pavel Tatashin <pasha.tatashin@soleen.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, vbabka@suse.cz, david@redhat.com,
        osalvador@suse.de, dan.j.williams@intel.com, sashal@kernel.org,
        tyhicks@linux.microsoft.com, iamjoonsoo.kim@lge.com,
        mike.kravetz@oracle.com, rostedt@goodmis.org, mingo@redhat.com,
        jgg@ziepe.ca, peterz@infradead.org, mgorman@suse.de,
        willy@infradead.org, rientjes@google.com, jhubbard@nvidia.com
Subject: Re: [PATCH 4/6] mm cma: rename PF_MEMALLOC_NOCMA to
 PF_MEMALLOC_NOMOVABLE
Message-ID: <20201203085744.GZ17338@dhcp22.suse.cz>
References: <20201202052330.474592-1-pasha.tatashin@soleen.com>
 <20201202052330.474592-5-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201202052330.474592-5-pasha.tatashin@soleen.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 02-12-20 00:23:28, Pavel Tatashin wrote:
> PF_MEMALLOC_NOCMA is used for longterm pinning and has an effect of
> clearing _GFP_MOVABLE or prohibiting allocations from ZONE_MOVABLE.

This is not precise. You are mixing the implementation and the intention
here. I would say "PF_MEMALLOC_NOCMA is used ot guarantee that the
allocator will not return pages that might belong to CMA region. This is
currently used for long term gup to make sure that such pins are not
going to be done on any CMA pages."
 
> We will prohibit allocating any pages that are getting
> longterm pinned from ZONE_MOVABLE, and we would want to unify and re-use
> this flag. So, rename it to generic PF_MEMALLOC_NOMOVABLE.
> Also re-name:
> memalloc_nocma_save()/memalloc_nocma_restore
> to
> memalloc_nomovable_save()/memalloc_nomovable_restore()
> and make the new functions common.

This is hard to parse for me. I would go with something like:
"
When PF_MEMALLOC_NOCMA has been introduced we haven't realized that it
is focusing on CMA pages too much and that there is larger class of
pages that need the same treatment. MOVABLE zone cannot contain
any long term pins as well so it makes sense to reuse and redefine this
flag for that usecase as well. Rename the flag to PF_MEMALLOC_NOMOVABLE
which defines an allocation context which can only get pages suitable
for long-term pins.
"

Btw. the naming is hard but PF_MEMALLOC_NOMOVABLE is a bit misnomer. CMA
pages are not implicitly movable. So in fact we do care more about
pinning than movability. PF_MEMALLOC_PIN or something similar would be
better fit for the overal intention.

Other than that looks good to me. Thanks!
 
> Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
> ---
>  include/linux/sched.h    |  2 +-
>  include/linux/sched/mm.h | 21 +++++----------------
>  mm/gup.c                 |  4 ++--
>  mm/hugetlb.c             |  4 ++--
>  mm/page_alloc.c          |  4 ++--
>  5 files changed, 12 insertions(+), 23 deletions(-)
> 
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 76cd21fa5501..f1bf05f5f5fa 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -1548,7 +1548,7 @@ extern struct pid *cad_pid;
>  #define PF_SWAPWRITE		0x00800000	/* Allowed to write to swap */
>  #define PF_NO_SETAFFINITY	0x04000000	/* Userland is not allowed to meddle with cpus_mask */
>  #define PF_MCE_EARLY		0x08000000      /* Early kill for mce process policy */
> -#define PF_MEMALLOC_NOCMA	0x10000000	/* All allocation request will have _GFP_MOVABLE cleared */
> +#define PF_MEMALLOC_NOMOVABLE	0x10000000	/* All allocation request will have _GFP_MOVABLE cleared */
>  #define PF_FREEZER_SKIP		0x40000000	/* Freezer should not count it as freezable */
>  #define PF_SUSPEND_TASK		0x80000000      /* This thread called freeze_processes() and should not be frozen */
>  
> diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
> index d5ece7a9a403..5bb9a6b69479 100644
> --- a/include/linux/sched/mm.h
> +++ b/include/linux/sched/mm.h
> @@ -254,29 +254,18 @@ static inline void memalloc_noreclaim_restore(unsigned int flags)
>  	current->flags = (current->flags & ~PF_MEMALLOC) | flags;
>  }
>  
> -#ifdef CONFIG_CMA
> -static inline unsigned int memalloc_nocma_save(void)
> +static inline unsigned int memalloc_nomovable_save(void)
>  {
> -	unsigned int flags = current->flags & PF_MEMALLOC_NOCMA;
> +	unsigned int flags = current->flags & PF_MEMALLOC_NOMOVABLE;
>  
> -	current->flags |= PF_MEMALLOC_NOCMA;
> +	current->flags |= PF_MEMALLOC_NOMOVABLE;
>  	return flags;
>  }
>  
> -static inline void memalloc_nocma_restore(unsigned int flags)
> +static inline void memalloc_nomovable_restore(unsigned int flags)
>  {
> -	current->flags = (current->flags & ~PF_MEMALLOC_NOCMA) | flags;
> +	current->flags = (current->flags & ~PF_MEMALLOC_NOMOVABLE) | flags;
>  }
> -#else
> -static inline unsigned int memalloc_nocma_save(void)
> -{
> -	return 0;
> -}
> -
> -static inline void memalloc_nocma_restore(unsigned int flags)
> -{
> -}
> -#endif
>  
>  #ifdef CONFIG_MEMCG
>  DECLARE_PER_CPU(struct mem_cgroup *, int_active_memcg);
> diff --git a/mm/gup.c b/mm/gup.c
> index 0e2de888a8b0..724d8a65e1df 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -1726,7 +1726,7 @@ static long __gup_longterm_locked(struct mm_struct *mm,
>  			if (!vmas_tmp)
>  				return -ENOMEM;
>  		}
> -		flags = memalloc_nocma_save();
> +		flags = memalloc_nomovable_save();
>  	}
>  
>  	rc = __get_user_pages_locked(mm, start, nr_pages, pages,
> @@ -1749,7 +1749,7 @@ static long __gup_longterm_locked(struct mm_struct *mm,
>  		rc = check_and_migrate_cma_pages(mm, start, rc, pages,
>  						 vmas_tmp, gup_flags);
>  out:
> -		memalloc_nocma_restore(flags);
> +		memalloc_nomovable_restore(flags);
>  	}
>  
>  	if (vmas_tmp != vmas)
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 37f15c3c24dc..02213c74ed6b 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -1033,10 +1033,10 @@ static void enqueue_huge_page(struct hstate *h, struct page *page)
>  static struct page *dequeue_huge_page_node_exact(struct hstate *h, int nid)
>  {
>  	struct page *page;
> -	bool nocma = !!(current->flags & PF_MEMALLOC_NOCMA);
> +	bool nomovable = !!(current->flags & PF_MEMALLOC_NOMOVABLE);
>  
>  	list_for_each_entry(page, &h->hugepage_freelists[nid], lru) {
> -		if (nocma && is_migrate_cma_page(page))
> +		if (nomovable && is_migrate_cma_page(page))
>  			continue;
>  
>  		if (PageHWPoison(page))
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index eaa227a479e4..611799c72da5 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -3772,8 +3772,8 @@ static inline unsigned int current_alloc_flags(gfp_t gfp_mask,
>  #ifdef CONFIG_CMA
>  	unsigned int pflags = current->flags;
>  
> -	if (!(pflags & PF_MEMALLOC_NOCMA) &&
> -			gfp_migratetype(gfp_mask) == MIGRATE_MOVABLE)
> +	if (!(pflags & PF_MEMALLOC_NOMOVABLE) &&
> +	    gfp_migratetype(gfp_mask) == MIGRATE_MOVABLE)
>  		alloc_flags |= ALLOC_CMA;
>  
>  #endif
> -- 
> 2.25.1
> 

-- 
Michal Hocko
SUSE Labs
