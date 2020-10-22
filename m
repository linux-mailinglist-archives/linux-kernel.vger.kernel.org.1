Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 910DB29624A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 18:00:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2508759AbgJVQAa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 12:00:30 -0400
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:48939 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2439112AbgJVQAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 12:00:30 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=alimailimapcm10staff010182156082;MF=xuyu@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0UCrLpdS_1603382424;
Received: from xuyu-mbp15.local(mailfrom:xuyu@linux.alibaba.com fp:SMTPD_---0UCrLpdS_1603382424)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 23 Oct 2020 00:00:25 +0800
Subject: Re: [PATCH] mm,thp,shmem: limit shmem THP alloc gfp_mask
To:     Rik van Riel <riel@surriel.com>, Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        Mel Gorman <mgorman@suse.de>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Matthew Wilcox <willy@infradead.org>
References: <20201021234846.5cc97e62@imladris.surriel.com>
From:   Yu Xu <xuyu@linux.alibaba.com>
Message-ID: <f0b4a9de-1f2f-4147-e188-c946207fb29e@linux.alibaba.com>
Date:   Fri, 23 Oct 2020 00:00:22 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20201021234846.5cc97e62@imladris.surriel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/22/20 11:48 AM, Rik van Riel wrote:
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

It is fine to reuse `alloc_hugepage_direct_gfpmask`, but
`pvma.vm_flags & VM_HUGEPAGE` is always false here, thus,
`vma_madvised` in `alloc_hugepage_direct_gfpmask` will always
be false.

That is why I chose to do the gfp_mask fixup in `shmem_getpage_gfp`,
using `sgp_huge` to indicate `vma_madvised`, although with some silly
mistakes pointed out by you, in another mail thread.

It will be better if vma_madvised is well handled in your solution.

> +	page = alloc_pages_vma(gfp, HPAGE_PMD_ORDER, &pvma, 0, numa_node_id(),
> +			       true);
>   	shmem_pseudo_vma_destroy(&pvma);
>   	if (page)
>   		prep_transhuge_page(page);
> 

-- 
Thanks,
Yu
