Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 555722FCE47
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 11:53:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732843AbhATKUP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 05:20:15 -0500
Received: from mx2.suse.de ([195.135.220.15]:45724 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730242AbhATKL1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 05:11:27 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 1C2F8AF9A;
        Wed, 20 Jan 2021 10:10:46 +0000 (UTC)
Date:   Wed, 20 Jan 2021 11:10:43 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Michal Hocko <mhocko@kernel.org>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Muchun Song <songmuchun@bytedance.com>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2 5/5] hugetlb: convert PageHugeFreed to HPageFreed flag
Message-ID: <20210120101043.GD4752@localhost.localdomain>
References: <20210120013049.311822-1-mike.kravetz@oracle.com>
 <20210120013049.311822-6-mike.kravetz@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210120013049.311822-6-mike.kravetz@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 19, 2021 at 05:30:49PM -0800, Mike Kravetz wrote:
> Use new hugetlb specific HPageFreed flag to replace the
> PageHugeFreed interfaces.
> 
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>

Reviewed-by: Oscar Salvador <osalvador@suse.de>

> ---
>  include/linux/hugetlb.h |  3 +++
>  mm/hugetlb.c            | 23 ++++-------------------
>  2 files changed, 7 insertions(+), 19 deletions(-)
> 
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index ec329b9cc0fc..8fd0970cefdb 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -487,11 +487,13 @@ unsigned long hugetlb_get_unmapped_area(struct file *file, unsigned long addr,
>   *	allocator.  Typically used for migration target pages when no pages
>   *	are available in the pool.  The hugetlb free page path will
>   *	immediately free pages with this flag set to the buddy allocator.
> + * HPG_freed - Set when page is on the free lists.
>   */
>  enum hugetlb_page_flags {
>  	HPG_restore_reserve = 0,
>  	HPG_migratable,
>  	HPG_temporary,
> +	HPG_freed,
>  	__NR_HPAGEFLAGS,
>  };
>  
> @@ -540,6 +542,7 @@ static inline void ClearHPage##uname(struct page *page)		\
>  HPAGEFLAG(RestoreReserve, restore_reserve)
>  HPAGEFLAG(Migratable, migratable)
>  HPAGEFLAG(Temporary, temporary)
> +HPAGEFLAG(Freed, freed)
>  
>  #ifdef CONFIG_HUGETLB_PAGE
>  
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 0d2bfc2b6adc..d5a78aedbfda 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -79,21 +79,6 @@ DEFINE_SPINLOCK(hugetlb_lock);
>  static int num_fault_mutexes;
>  struct mutex *hugetlb_fault_mutex_table ____cacheline_aligned_in_smp;
>  
> -static inline bool PageHugeFreed(struct page *head)
> -{
> -	return page_private(head + 4) == -1UL;
> -}
> -
> -static inline void SetPageHugeFreed(struct page *head)
> -{
> -	set_page_private(head + 4, -1UL);
> -}
> -
> -static inline void ClearPageHugeFreed(struct page *head)
> -{
> -	set_page_private(head + 4, 0);
> -}
> -
>  /* Forward declaration */
>  static int hugetlb_acct_memory(struct hstate *h, long delta);
>  
> @@ -1043,7 +1028,7 @@ static void enqueue_huge_page(struct hstate *h, struct page *page)
>  	list_move(&page->lru, &h->hugepage_freelists[nid]);
>  	h->free_huge_pages++;
>  	h->free_huge_pages_node[nid]++;
> -	SetPageHugeFreed(page);
> +	SetHPageFreed(page);
>  }
>  
>  static struct page *dequeue_huge_page_node_exact(struct hstate *h, int nid)
> @@ -1060,7 +1045,7 @@ static struct page *dequeue_huge_page_node_exact(struct hstate *h, int nid)
>  
>  		list_move(&page->lru, &h->hugepage_activelist);
>  		set_page_refcounted(page);
> -		ClearPageHugeFreed(page);
> +		ClearHPageFreed(page);
>  		h->free_huge_pages--;
>  		h->free_huge_pages_node[nid]--;
>  		return page;
> @@ -1474,7 +1459,7 @@ static void prep_new_huge_page(struct hstate *h, struct page *page, int nid)
>  	spin_lock(&hugetlb_lock);
>  	h->nr_huge_pages++;
>  	h->nr_huge_pages_node[nid]++;
> -	ClearPageHugeFreed(page);
> +	ClearHPageFreed(page);
>  	spin_unlock(&hugetlb_lock);
>  }
>  
> @@ -1747,7 +1732,7 @@ int dissolve_free_huge_page(struct page *page)
>  		 * We should make sure that the page is already on the free list
>  		 * when it is dissolved.
>  		 */
> -		if (unlikely(!PageHugeFreed(head))) {
> +		if (unlikely(!HPageFreed(head))) {
>  			rc = -EAGAIN;
>  			goto out;
>  		}
> -- 
> 2.29.2
> 
> 

-- 
Oscar Salvador
SUSE L3
