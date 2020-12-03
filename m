Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF2B52CD0C2
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 09:06:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729871AbgLCIFn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 03:05:43 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:18840 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726451AbgLCIFm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 03:05:42 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fc89c2e0000>; Thu, 03 Dec 2020 00:05:02 -0800
Received: from [10.2.53.244] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 3 Dec
 2020 08:04:55 +0000
Subject: Re: [PATCH 4/6] mm cma: rename PF_MEMALLOC_NOCMA to
 PF_MEMALLOC_NOMOVABLE
To:     Pavel Tatashin <pasha.tatashin@soleen.com>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <akpm@linux-foundation.org>, <vbabka@suse.cz>, <mhocko@suse.com>,
        <david@redhat.com>, <osalvador@suse.de>,
        <dan.j.williams@intel.com>, <sashal@kernel.org>,
        <tyhicks@linux.microsoft.com>, <iamjoonsoo.kim@lge.com>,
        <mike.kravetz@oracle.com>, <rostedt@goodmis.org>,
        <mingo@redhat.com>, <jgg@ziepe.ca>, <peterz@infradead.org>,
        <mgorman@suse.de>, <willy@infradead.org>, <rientjes@google.com>
References: <20201202052330.474592-1-pasha.tatashin@soleen.com>
 <20201202052330.474592-5-pasha.tatashin@soleen.com>
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <eea5da76-e753-e7c8-60a4-c3e7e58649c1@nvidia.com>
Date:   Thu, 3 Dec 2020 00:04:55 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:83.0) Gecko/20100101
 Thunderbird/83.0
MIME-Version: 1.0
In-Reply-To: <20201202052330.474592-5-pasha.tatashin@soleen.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1606982702; bh=0r2hX9f4dCvSevFUUl1H/pKvxaPM+mKO3kQFm8fBXXI=;
        h=Subject:To:References:From:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Language:
         Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
        b=D/DXVdb7Cld/GynKoUML+/mRn/fWrKZsD/2oBT+AM6Kc46Fk6o2dQ3U+1+oufuh3b
         bMn7CbwLdOVFk3ZR7p12qiF4WzoPyXwtryxPyGx76e1wQyYKvyTJrK9kjdTehLdA0+
         5KbbOsWhFX7MYG92VEFCl52Ac+bXKMrI01YHykF0pNcCE01/uMJG9mz+9oCBiwY+w2
         qD+UgRIsgzkmWSgfMLsajVuqnH2SrihjZ3qU1JbxKWAc0ZJ1yMVTjYQtg0xwRjNLjQ
         H0OsUrGm5fwMrwk28gq39/UjfaEP1M9ZPVFGsv9fD75r8RjBTmjtGlza5hM1vc0ayT
         v4IjXhNiuw5ZQ==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/1/20 9:23 PM, Pavel Tatashin wrote:
> PF_MEMALLOC_NOCMA is used for longterm pinning and has an effect of
> clearing _GFP_MOVABLE or prohibiting allocations from ZONE_MOVABLE.
> 
> We will prohibit allocating any pages that are getting
> longterm pinned from ZONE_MOVABLE, and we would want to unify and re-use
> this flag. So, rename it to generic PF_MEMALLOC_NOMOVABLE.
> Also re-name:
> memalloc_nocma_save()/memalloc_nocma_restore
> to
> memalloc_nomovable_save()/memalloc_nomovable_restore()
> and make the new functions common.
> 
> Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>

Looks accurate, and grep didn't find any lingering rename candidates
after this series is applied. And it's a good rename.


Reviewed-by: John Hubbard <jhubbard@nvidia.com>


thanks,
-- 
John Hubbard
NVIDIA

> ---
>   include/linux/sched.h    |  2 +-
>   include/linux/sched/mm.h | 21 +++++----------------
>   mm/gup.c                 |  4 ++--
>   mm/hugetlb.c             |  4 ++--
>   mm/page_alloc.c          |  4 ++--
>   5 files changed, 12 insertions(+), 23 deletions(-)
> 
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 76cd21fa5501..f1bf05f5f5fa 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -1548,7 +1548,7 @@ extern struct pid *cad_pid;
>   #define PF_SWAPWRITE		0x00800000	/* Allowed to write to swap */
>   #define PF_NO_SETAFFINITY	0x04000000	/* Userland is not allowed to meddle with cpus_mask */
>   #define PF_MCE_EARLY		0x08000000      /* Early kill for mce process policy */
> -#define PF_MEMALLOC_NOCMA	0x10000000	/* All allocation request will have _GFP_MOVABLE cleared */
> +#define PF_MEMALLOC_NOMOVABLE	0x10000000	/* All allocation request will have _GFP_MOVABLE cleared */
>   #define PF_FREEZER_SKIP		0x40000000	/* Freezer should not count it as freezable */
>   #define PF_SUSPEND_TASK		0x80000000      /* This thread called freeze_processes() and should not be frozen */
>   
> diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
> index d5ece7a9a403..5bb9a6b69479 100644
> --- a/include/linux/sched/mm.h
> +++ b/include/linux/sched/mm.h
> @@ -254,29 +254,18 @@ static inline void memalloc_noreclaim_restore(unsigned int flags)
>   	current->flags = (current->flags & ~PF_MEMALLOC) | flags;
>   }
>   
> -#ifdef CONFIG_CMA
> -static inline unsigned int memalloc_nocma_save(void)
> +static inline unsigned int memalloc_nomovable_save(void)
>   {
> -	unsigned int flags = current->flags & PF_MEMALLOC_NOCMA;
> +	unsigned int flags = current->flags & PF_MEMALLOC_NOMOVABLE;
>   
> -	current->flags |= PF_MEMALLOC_NOCMA;
> +	current->flags |= PF_MEMALLOC_NOMOVABLE;
>   	return flags;
>   }
>   
> -static inline void memalloc_nocma_restore(unsigned int flags)
> +static inline void memalloc_nomovable_restore(unsigned int flags)
>   {
> -	current->flags = (current->flags & ~PF_MEMALLOC_NOCMA) | flags;
> +	current->flags = (current->flags & ~PF_MEMALLOC_NOMOVABLE) | flags;
>   }
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
>   #ifdef CONFIG_MEMCG
>   DECLARE_PER_CPU(struct mem_cgroup *, int_active_memcg);
> diff --git a/mm/gup.c b/mm/gup.c
> index 0e2de888a8b0..724d8a65e1df 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -1726,7 +1726,7 @@ static long __gup_longterm_locked(struct mm_struct *mm,
>   			if (!vmas_tmp)
>   				return -ENOMEM;
>   		}
> -		flags = memalloc_nocma_save();
> +		flags = memalloc_nomovable_save();
>   	}
>   
>   	rc = __get_user_pages_locked(mm, start, nr_pages, pages,
> @@ -1749,7 +1749,7 @@ static long __gup_longterm_locked(struct mm_struct *mm,
>   		rc = check_and_migrate_cma_pages(mm, start, rc, pages,
>   						 vmas_tmp, gup_flags);
>   out:
> -		memalloc_nocma_restore(flags);
> +		memalloc_nomovable_restore(flags);
>   	}
>   
>   	if (vmas_tmp != vmas)
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 37f15c3c24dc..02213c74ed6b 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -1033,10 +1033,10 @@ static void enqueue_huge_page(struct hstate *h, struct page *page)
>   static struct page *dequeue_huge_page_node_exact(struct hstate *h, int nid)
>   {
>   	struct page *page;
> -	bool nocma = !!(current->flags & PF_MEMALLOC_NOCMA);
> +	bool nomovable = !!(current->flags & PF_MEMALLOC_NOMOVABLE);
>   
>   	list_for_each_entry(page, &h->hugepage_freelists[nid], lru) {
> -		if (nocma && is_migrate_cma_page(page))
> +		if (nomovable && is_migrate_cma_page(page))
>   			continue;
>   
>   		if (PageHWPoison(page))
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index eaa227a479e4..611799c72da5 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -3772,8 +3772,8 @@ static inline unsigned int current_alloc_flags(gfp_t gfp_mask,
>   #ifdef CONFIG_CMA
>   	unsigned int pflags = current->flags;
>   
> -	if (!(pflags & PF_MEMALLOC_NOCMA) &&
> -			gfp_migratetype(gfp_mask) == MIGRATE_MOVABLE)
> +	if (!(pflags & PF_MEMALLOC_NOMOVABLE) &&
> +	    gfp_migratetype(gfp_mask) == MIGRATE_MOVABLE)
>   		alloc_flags |= ALLOC_CMA;
>   
>   #endif
> 

