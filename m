Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEF312FCE45
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 11:53:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732812AbhATKUE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 05:20:04 -0500
Received: from mx2.suse.de ([195.135.220.15]:42660 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729997AbhATKKB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 05:10:01 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 7C8BAAC97;
        Wed, 20 Jan 2021 10:09:19 +0000 (UTC)
Date:   Wed, 20 Jan 2021 11:09:13 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Michal Hocko <mhocko@kernel.org>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Muchun Song <songmuchun@bytedance.com>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2 4/5] hugetlb: convert PageHugeTemporary() to
 HPageTemporary flag
Message-ID: <20210120100913.GC4752@localhost.localdomain>
References: <20210120013049.311822-1-mike.kravetz@oracle.com>
 <20210120013049.311822-5-mike.kravetz@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210120013049.311822-5-mike.kravetz@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 19, 2021 at 05:30:48PM -0800, Mike Kravetz wrote:
> Use new hugetlb specific HPageTemporary flag to replace the
> PageHugeTemporary() interfaces.
> 
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>

I would have added a brief comment explaining why it is ok to drop
the PageHuge() check in PageHugeTemporary.
AFAICS, the paths checking it already know they are handling with a 
hugetlb page, but still it is better to mention it in the changelog
in case someone wonders.

Other than that looks good to me:

Reviewed-by: Oscar Salvador <osalvador@suse.de>

> ---
>  include/linux/hugetlb.h |  6 ++++++
>  mm/hugetlb.c            | 36 +++++++-----------------------------
>  2 files changed, 13 insertions(+), 29 deletions(-)
> 
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index 1e17529c8b81..ec329b9cc0fc 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -483,10 +483,15 @@ unsigned long hugetlb_get_unmapped_area(struct file *file, unsigned long addr,
>   * HPG_migratable  - Set after a newly allocated page is added to the page
>   *	cache and/or page tables.  Indicates the page is a candidate for
>   *	migration.
> + * HPG_temporary - - Set on a page that is temporarily allocated from the buddy
> + *	allocator.  Typically used for migration target pages when no pages
> + *	are available in the pool.  The hugetlb free page path will
> + *	immediately free pages with this flag set to the buddy allocator.
>   */
>  enum hugetlb_page_flags {
>  	HPG_restore_reserve = 0,
>  	HPG_migratable,
> +	HPG_temporary,
>  	__NR_HPAGEFLAGS,
>  };
>  
> @@ -534,6 +539,7 @@ static inline void ClearHPage##uname(struct page *page)		\
>   */
>  HPAGEFLAG(RestoreReserve, restore_reserve)
>  HPAGEFLAG(Migratable, migratable)
> +HPAGEFLAG(Temporary, temporary)
>  
>  #ifdef CONFIG_HUGETLB_PAGE
>  
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 6e32751489e8..0d2bfc2b6adc 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -1353,28 +1353,6 @@ struct hstate *size_to_hstate(unsigned long size)
>  	return NULL;
>  }
>  
> -/*
> - * Internal hugetlb specific page flag. Do not use outside of the hugetlb
> - * code
> - */
> -static inline bool PageHugeTemporary(struct page *page)
> -{
> -	if (!PageHuge(page))
> -		return false;
> -
> -	return (unsigned long)page[2].mapping == -1U;
> -}
> -
> -static inline void SetPageHugeTemporary(struct page *page)
> -{
> -	page[2].mapping = (void *)-1U;
> -}
> -
> -static inline void ClearPageHugeTemporary(struct page *page)
> -{
> -	page[2].mapping = NULL;
> -}
> -
>  static void __free_huge_page(struct page *page)
>  {
>  	/*
> @@ -1422,9 +1400,9 @@ static void __free_huge_page(struct page *page)
>  	if (restore_reserve)
>  		h->resv_huge_pages++;
>  
> -	if (PageHugeTemporary(page)) {
> +	if (HPageTemporary(page)) {
>  		list_del(&page->lru);
> -		ClearPageHugeTemporary(page);
> +		ClearHPageTemporary(page);
>  		update_and_free_page(h, page);
>  	} else if (h->surplus_huge_pages_node[nid]) {
>  		/* remove the page from active list */
> @@ -1863,7 +1841,7 @@ static struct page *alloc_surplus_huge_page(struct hstate *h, gfp_t gfp_mask,
>  	 * codeflow
>  	 */
>  	if (h->surplus_huge_pages >= h->nr_overcommit_huge_pages) {
> -		SetPageHugeTemporary(page);
> +		SetHPageTemporary(page);
>  		spin_unlock(&hugetlb_lock);
>  		put_page(page);
>  		return NULL;
> @@ -1894,7 +1872,7 @@ static struct page *alloc_migrate_huge_page(struct hstate *h, gfp_t gfp_mask,
>  	 * We do not account these pages as surplus because they are only
>  	 * temporary and will be released properly on the last reference
>  	 */
> -	SetPageHugeTemporary(page);
> +	SetHPageTemporary(page);
>  
>  	return page;
>  }
> @@ -5607,12 +5585,12 @@ void move_hugetlb_state(struct page *oldpage, struct page *newpage, int reason)
>  	 * here as well otherwise the global surplus count will not match
>  	 * the per-node's.
>  	 */
> -	if (PageHugeTemporary(newpage)) {
> +	if (HPageTemporary(newpage)) {
>  		int old_nid = page_to_nid(oldpage);
>  		int new_nid = page_to_nid(newpage);
>  
> -		SetPageHugeTemporary(oldpage);
> -		ClearPageHugeTemporary(newpage);
> +		SetHPageTemporary(oldpage);
> +		ClearHPageTemporary(newpage);
>  
>  		spin_lock(&hugetlb_lock);
>  		if (h->surplus_huge_pages_node[old_nid]) {
> -- 
> 2.29.2
> 

-- 
Oscar Salvador
SUSE L3
