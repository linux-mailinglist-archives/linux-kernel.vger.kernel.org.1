Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19805296122
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 16:51:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S368211AbgJVOvr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 10:51:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:55654 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S368201AbgJVOvr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 10:51:47 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A1B4EAC6C;
        Thu, 22 Oct 2020 14:51:45 +0000 (UTC)
Subject: Re: [PATCH] mm,thp,shmem: limit shmem THP alloc gfp_mask
To:     Rik van Riel <riel@surriel.com>, Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        Mel Gorman <mgorman@suse.de>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>
References: <20201021234846.5cc97e62@imladris.surriel.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <06c1e573-cddd-c17c-9f18-3af2d9d09f80@suse.cz>
Date:   Thu, 22 Oct 2020 16:51:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.2
MIME-Version: 1.0
In-Reply-To: <20201021234846.5cc97e62@imladris.surriel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/22/20 5:48 AM, Rik van Riel wrote:
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
> Signed-off-by: Rik van Riel <riel@surriel.com>

FTR, a patch to the same effect was sent by Xu Yu:

https://lore.kernel.org/r/11e1ead211eb7d141efa0eb75a46ee2096ee63f8.1603267572.git.xuyu@linux.alibaba.com

> ---
> 
> diff --git a/include/linux/gfp.h b/include/linux/gfp.h
> index c603237e006c..0a5b164a26d9 100644
> --- a/include/linux/gfp.h
> +++ b/include/linux/gfp.h
> @@ -614,6 +614,8 @@ bool gfp_pfmemalloc_allowed(gfp_t gfp_mask);
>   extern void pm_restrict_gfp_mask(void);
>   extern void pm_restore_gfp_mask(void);
>   
> +extern gfp_t alloc_hugepage_direct_gfpmask(struct vm_area_struct *vma);
> +
>   #ifdef CONFIG_PM_SLEEP
>   extern bool pm_suspended_storage(void);
>   #else
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 9474dbc150ed..9b08ce5cc387 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -649,7 +649,7 @@ static vm_fault_t __do_huge_pmd_anonymous_page(struct vm_fault *vmf,
>    *	    available
>    * never: never stall for any thp allocation
>    */
> -static inline gfp_t alloc_hugepage_direct_gfpmask(struct vm_area_struct *vma)
> +gfp_t alloc_hugepage_direct_gfpmask(struct vm_area_struct *vma)
>   {
>   	const bool vma_madvised = !!(vma->vm_flags & VM_HUGEPAGE);
>   
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 537c137698f8..d1290eb508e5 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -1545,8 +1545,11 @@ static struct page *shmem_alloc_hugepage(gfp_t gfp,
>   		return NULL;
>   
>   	shmem_pseudo_vma_init(&pvma, info, hindex);
> -	page = alloc_pages_vma(gfp | __GFP_COMP | __GFP_NORETRY | __GFP_NOWARN,
> -			HPAGE_PMD_ORDER, &pvma, 0, numa_node_id(), true);
> +	/* Limit the gfp mask according to THP configuration. */
> +	gfp |= __GFP_COMP | __GFP_NORETRY | __GFP_NOWARN;
> +	gfp &= alloc_hugepage_direct_gfpmask(&pvma);
> +	page = alloc_pages_vma(gfp, HPAGE_PMD_ORDER, &pvma, 0, numa_node_id(),
> +			       true);
>   	shmem_pseudo_vma_destroy(&pvma);
>   	if (page)
>   		prep_transhuge_page(page);
> 

