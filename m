Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF72B2CD11C
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 09:18:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388304AbgLCIRx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 03:17:53 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:1168 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727957AbgLCIRw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 03:17:52 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fc89f080001>; Thu, 03 Dec 2020 00:17:12 -0800
Received: from [10.2.53.244] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 3 Dec
 2020 08:17:02 +0000
Subject: Re: [PATCH 5/6] mm: honor PF_MEMALLOC_NOMOVABLE for all allocations
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
 <20201202052330.474592-6-pasha.tatashin@soleen.com>
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <18c9ab89-185b-395a-97ce-31940388df0e@nvidia.com>
Date:   Thu, 3 Dec 2020 00:17:02 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:83.0) Gecko/20100101
 Thunderbird/83.0
MIME-Version: 1.0
In-Reply-To: <20201202052330.474592-6-pasha.tatashin@soleen.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1606983432; bh=tt3ipWNRmelZIOH1gok6CPu43cySDBNfdp0EafzWIpw=;
        h=Subject:To:References:From:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Language:
         Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
        b=HN8ouwon52VjICOn9XNJ3C2+eiv4+jZrliRSIA83IAb96b2hCuI8/BzT2/2kyFNDJ
         FvR2biCjaQNHMLYPWIqdtVHYQP4AvnSMCep4OrY1YiJM8LHEEGOn1LD+oBfYgt7Tdl
         8w7i8TPKAGHYyHhsO6QICreNLhDoJs/TUhsuz6CuOis5EDHlf+f3wTuDTDO0KVx/qO
         hWwGlvChrSk5+6Ahy//qPHmosYfjESFoiZdmmGQhQnQgpW0bXCii0f4dCcDh9rhuUi
         Fx2HHJJ2VNEDcCp/vTvdZHsBltkHVNi6+EWl3evkNjciXGhrjcXFFowqUjbvy0x9Zh
         q1cHSOIiwuwjA==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/1/20 9:23 PM, Pavel Tatashin wrote:
> PF_MEMALLOC_NOMOVABLE is only honored for CMA allocations, extend
> this flag to work for any allocations by removing __GFP_MOVABLE from
> gfp_mask when this flag is passed in the current context, thus
> prohibiting allocations from ZONE_MOVABLE.
> 
> Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
> ---
>   mm/hugetlb.c    |  2 +-
>   mm/page_alloc.c | 26 ++++++++++++++++----------
>   2 files changed, 17 insertions(+), 11 deletions(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 02213c74ed6b..00e786201d8b 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -1036,7 +1036,7 @@ static struct page *dequeue_huge_page_node_exact(struct hstate *h, int nid)
>   	bool nomovable = !!(current->flags & PF_MEMALLOC_NOMOVABLE);
>   
>   	list_for_each_entry(page, &h->hugepage_freelists[nid], lru) {
> -		if (nomovable && is_migrate_cma_page(page))
> +		if (nomovable && is_migrate_movable(get_pageblock_migratetype(page)))


I wonder if we should add a helper, like is_migrate_cma_page(), that avoids having
to call get_pageblock_migratetype() at all of the callsites?


>   			continue;
>   
>   		if (PageHWPoison(page))
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 611799c72da5..7a6d86d0bc5f 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -3766,20 +3766,25 @@ alloc_flags_nofragment(struct zone *zone, gfp_t gfp_mask)
>   	return alloc_flags;
>   }
>   
> -static inline unsigned int current_alloc_flags(gfp_t gfp_mask,
> -					unsigned int alloc_flags)
> +static inline unsigned int cma_alloc_flags(gfp_t gfp_mask,
> +					   unsigned int alloc_flags)

Actually, maybe the original name should be left intact. This handles current alloc
flags, which right now happen to only cover CMA flags, so the original name seems
accurate, right?


thanks,

John Hubbard
NVIDIA

>   {
>   #ifdef CONFIG_CMA
> -	unsigned int pflags = current->flags;
> -
> -	if (!(pflags & PF_MEMALLOC_NOMOVABLE) &&
> -	    gfp_migratetype(gfp_mask) == MIGRATE_MOVABLE)
> +	if (gfp_migratetype(gfp_mask) == MIGRATE_MOVABLE)
>   		alloc_flags |= ALLOC_CMA;
> -
>   #endif
>   	return alloc_flags;
>   }
>   
> +static inline gfp_t current_gfp_checkmovable(gfp_t gfp_mask)
> +{
> +	unsigned int pflags = current->flags;
> +
> +	if ((pflags & PF_MEMALLOC_NOMOVABLE))
> +		return gfp_mask & ~__GFP_MOVABLE;
> +	return gfp_mask;
> +}
> +
>   /*
>    * get_page_from_freelist goes through the zonelist trying to allocate
>    * a page.
> @@ -4423,7 +4428,7 @@ gfp_to_alloc_flags(gfp_t gfp_mask)
>   	} else if (unlikely(rt_task(current)) && !in_interrupt())
>   		alloc_flags |= ALLOC_HARDER;
>   
> -	alloc_flags = current_alloc_flags(gfp_mask, alloc_flags);
> +	alloc_flags = cma_alloc_flags(gfp_mask, alloc_flags);
>   
>   	return alloc_flags;
>   }
> @@ -4725,7 +4730,7 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
>   
>   	reserve_flags = __gfp_pfmemalloc_flags(gfp_mask);
>   	if (reserve_flags)
> -		alloc_flags = current_alloc_flags(gfp_mask, reserve_flags);
> +		alloc_flags = cma_alloc_flags(gfp_mask, reserve_flags);
>   
>   	/*
>   	 * Reset the nodemask and zonelist iterators if memory policies can be
> @@ -4894,7 +4899,7 @@ static inline bool prepare_alloc_pages(gfp_t gfp_mask, unsigned int order,
>   	if (should_fail_alloc_page(gfp_mask, order))
>   		return false;
>   
> -	*alloc_flags = current_alloc_flags(gfp_mask, *alloc_flags);
> +	*alloc_flags = cma_alloc_flags(gfp_mask, *alloc_flags);
>   
>   	/* Dirty zone balancing only done in the fast path */
>   	ac->spread_dirty_pages = (gfp_mask & __GFP_WRITE);
> @@ -4932,6 +4937,7 @@ __alloc_pages_nodemask(gfp_t gfp_mask, unsigned int order, int preferred_nid,
>   	}
>   
>   	gfp_mask &= gfp_allowed_mask;
> +	gfp_mask = current_gfp_checkmovable(gfp_mask);
>   	alloc_mask = gfp_mask;
>   	if (!prepare_alloc_pages(gfp_mask, order, preferred_nid, nodemask, &ac, &alloc_mask, &alloc_flags))
>   		return NULL;
> 

