Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EB1E2FCC78
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 09:13:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730423AbhATIMu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 03:12:50 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:11418 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730342AbhATILa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 03:11:30 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4DLJ8p6Dmrzj8Rb;
        Wed, 20 Jan 2021 16:09:46 +0800 (CST)
Received: from [10.174.177.2] (10.174.177.2) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.498.0; Wed, 20 Jan 2021
 16:10:37 +0800
Subject: Re: [PATCH v2 1/5] hugetlb: use page.private for hugetlb specific
 page flags
To:     Mike Kravetz <mike.kravetz@oracle.com>
CC:     Michal Hocko <mhocko@kernel.org>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Muchun Song <songmuchun@bytedance.com>,
        "David Hildenbrand" <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        "Matthew Wilcox" <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
References: <20210120013049.311822-1-mike.kravetz@oracle.com>
 <20210120013049.311822-2-mike.kravetz@oracle.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <2c1d4815-6dc9-bd32-b564-8dbe7efb7705@huawei.com>
Date:   Wed, 20 Jan 2021 16:10:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210120013049.311822-2-mike.kravetz@oracle.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.2]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi:
On 2021/1/20 9:30, Mike Kravetz wrote:
> As hugetlbfs evolved, state information about hugetlb pages was added.
> One 'convenient' way of doing this was to use available fields in tail
> pages.  Over time, it has become difficult to know the meaning or contents
> of fields simply by looking at a small bit of code.  Sometimes, the
> naming is just confusing.  For example: The PagePrivate flag indicates
> a huge page reservation was consumed and needs to be restored if an error
> is encountered and the page is freed before it is instantiated.  The

This PagePrivate flag really confused me for a long time. :(

> page.private field contains the pointer to a subpool if the page is
> associated with one.
> 
> In an effort to make the code more readable, use page.private to contain
> hugetlb specific page flags.  These flags will have test, set and clear
> functions similar to those used for 'normal' page flags.  More importantly,
> an enum of flag values will be created with names that actually reflect
> their purpose.

Thanks for doing this. This would make life easier.

> 
> In this patch,
> - Create infrastructure for hugetlb specific page flag functions
> - Move subpool pointer to page[1].private to make way for flags
>   Create routines with meaningful names to modify subpool field
> - Use new HPageRestoreReserve flag instead of PagePrivate
> 
> Conversion of other state information will happen in subsequent patches.
> 
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> ---
>  fs/hugetlbfs/inode.c    | 12 ++-----
>  include/linux/hugetlb.h | 72 +++++++++++++++++++++++++++++++++++++++++
>  mm/hugetlb.c            | 45 +++++++++++++-------------
>  3 files changed, 97 insertions(+), 32 deletions(-)
> 
> diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
> index 740693d7f255..b8a661780c4a 100644
> --- a/fs/hugetlbfs/inode.c
> +++ b/fs/hugetlbfs/inode.c
> @@ -955,15 +955,9 @@ static int hugetlbfs_migrate_page(struct address_space *mapping,
>  	if (rc != MIGRATEPAGE_SUCCESS)
>  		return rc;
>  
> -	/*
> -	 * page_private is subpool pointer in hugetlb pages.  Transfer to
> -	 * new page.  PagePrivate is not associated with page_private for
> -	 * hugetlb pages and can not be set here as only page_huge_active
> -	 * pages can be migrated.
> -	 */
> -	if (page_private(page)) {
> -		set_page_private(newpage, page_private(page));
> -		set_page_private(page, 0);
> +	if (hugetlb_page_subpool(page)) {
> +		hugetlb_set_page_subpool(newpage, hugetlb_page_subpool(page));
> +		hugetlb_set_page_subpool(page, NULL);
>  	}
>  
>  	if (mode != MIGRATE_SYNC_NO_COPY)
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index ef5b144b8aac..be71a00ee2a0 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -472,6 +472,64 @@ unsigned long hugetlb_get_unmapped_area(struct file *file, unsigned long addr,
>  					unsigned long flags);
>  #endif /* HAVE_ARCH_HUGETLB_UNMAPPED_AREA */
>  
> +/*
> + * huegtlb page specific state flags.  These flags are located in page.private
> + * of the hugetlb head page.  Functions created via the below macros should be
> + * used to manipulate these flags.
> + *
> + * HPG_restore_reserve - Set when a hugetlb page consumes a reservation at
> + *	allocation time.  Cleared when page is fully instantiated.  Free
> + *	routine checks flag to restore a reservation on error paths.
> + */
> +enum hugetlb_page_flags {
> +	HPG_restore_reserve = 0,
> +	__NR_HPAGEFLAGS,
> +};
> +
> +/*
> + * Macros to create test, set and clear function definitions for
> + * hugetlb specific page flags.
> + */
> +#ifdef CONFIG_HUGETLB_PAGE
> +#define TESTHPAGEFLAG(uname, flname)				\
> +static inline int HPage##uname(struct page *page)		\
> +	{ BUILD_BUG_ON(sizeof_field(struct page, private) *	\
> +			BITS_PER_BYTE < __NR_HPAGEFLAGS);	\
> +	return test_bit(HPG_##flname, &(page->private)); }
> +
> +#define SETHPAGEFLAG(uname, flname)				\
> +static inline void SetHPage##uname(struct page *page)		\
> +	{ set_bit(HPG_##flname, &(page->private)); }
> +
> +#define CLEARHPAGEFLAG(uname, flname)				\
> +static inline void ClearHPage##uname(struct page *page)		\
> +	{ clear_bit(HPG_##flname, &(page->private)); }
> +#else
> +#define TESTHPAGEFLAG(uname, flname)				\
> +static inline int HPage##uname(struct page *page)		\
> +	{ BUILD_BUG_ON(sizeof_field(struct page, private) *	\
> +			BITS_PER_BYTE < __NR_HPAGEFLAGS);	\
> +	return 0 }
> +
> +#define SETHPAGEFLAG(uname, flname)				\
> +static inline void SetHPage##uname(struct page *page)		\
> +	{ }
> +
> +#define CLEARHPAGEFLAG(uname, flname)				\
> +static inline void ClearHPage##uname(struct page *page)		\
> +	{ }
> +#endif
> +
> +#define HPAGEFLAG(uname, flname)				\
> +	TESTHPAGEFLAG(uname, flname)				\
> +	SETHPAGEFLAG(uname, flname)				\
> +	CLEARHPAGEFLAG(uname, flname)				\
> +
> +/*
> + * Create functions associated with hugetlb page flags
> + */
> +HPAGEFLAG(RestoreReserve, restore_reserve)
> +
>  #ifdef CONFIG_HUGETLB_PAGE
>  
>  #define HSTATE_NAME_LEN 32
> @@ -531,6 +589,20 @@ extern unsigned int default_hstate_idx;
>  
>  #define default_hstate (hstates[default_hstate_idx])
>  
> +/*
> + * hugetlb page subpool pointer located in hpage[1].private
> + */
> +static inline struct hugepage_subpool *hugetlb_page_subpool(struct page *hpage)
> +{
> +	return (struct hugepage_subpool *)(hpage+1)->private;
> +}
> +
> +static inline void hugetlb_set_page_subpool(struct page *hpage,
> +					struct hugepage_subpool *subpool)
> +{
> +	set_page_private(hpage+1, (unsigned long)subpool);
> +}
> +
>  static inline struct hstate *hstate_file(struct file *f)
>  {
>  	return hstate_inode(file_inode(f));
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 737b2dce19e6..8bed6b5202d2 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -1133,7 +1133,7 @@ static struct page *dequeue_huge_page_vma(struct hstate *h,
>  	nid = huge_node(vma, address, gfp_mask, &mpol, &nodemask);
>  	page = dequeue_huge_page_nodemask(h, gfp_mask, nid, nodemask);
>  	if (page && !avoid_reserve && vma_has_reserves(vma, chg)) {
> -		SetPagePrivate(page);
> +		SetHPageRestoreReserve(page);
>  		h->resv_huge_pages--;
>  	}
>  
> @@ -1407,20 +1407,19 @@ static void __free_huge_page(struct page *page)
>  	 */
>  	struct hstate *h = page_hstate(page);
>  	int nid = page_to_nid(page);
> -	struct hugepage_subpool *spool =
> -		(struct hugepage_subpool *)page_private(page);
> +	struct hugepage_subpool *spool = hugetlb_page_subpool(page);
>  	bool restore_reserve;
>  
>  	VM_BUG_ON_PAGE(page_count(page), page);
>  	VM_BUG_ON_PAGE(page_mapcount(page), page);
>  
> -	set_page_private(page, 0);
> +	hugetlb_set_page_subpool(page, NULL);
>  	page->mapping = NULL;
> -	restore_reserve = PagePrivate(page);
> -	ClearPagePrivate(page);
> +	restore_reserve = HPageRestoreReserve(page);
> +	ClearHPageRestoreReserve(page);
>  
>  	/*
> -	 * If PagePrivate() was set on page, page allocation consumed a
> +	 * If HPageRestoreReserve was set on page, page allocation consumed a
>  	 * reservation.  If the page was associated with a subpool, there
>  	 * would have been a page reserved in the subpool before allocation
>  	 * via hugepage_subpool_get_pages().  Since we are 'restoring' the
> @@ -2254,24 +2253,24 @@ static long vma_add_reservation(struct hstate *h,
>   * This routine is called to restore a reservation on error paths.  In the
>   * specific error paths, a huge page was allocated (via alloc_huge_page)
>   * and is about to be freed.  If a reservation for the page existed,
> - * alloc_huge_page would have consumed the reservation and set PagePrivate
> - * in the newly allocated page.  When the page is freed via free_huge_page,
> - * the global reservation count will be incremented if PagePrivate is set.
> - * However, free_huge_page can not adjust the reserve map.  Adjust the
> - * reserve map here to be consistent with global reserve count adjustments
> - * to be made by free_huge_page.
> + * alloc_huge_page would have consumed the reservation and set
> + * HPageRestoreReserve in the newly allocated page.  When the page is freed
> + * via free_huge_page, the global reservation count will be incremented if
> + * HPageRestoreReserve is set.  However, free_huge_page can not adjust the
> + * reserve map.  Adjust the reserve map here to be consistent with global
> + * reserve count adjustments to be made by free_huge_page.
>   */
>  static void restore_reserve_on_error(struct hstate *h,
>  			struct vm_area_struct *vma, unsigned long address,
>  			struct page *page)
>  {
> -	if (unlikely(PagePrivate(page))) {
> +	if (unlikely(HPageRestoreReserve(page))) {
>  		long rc = vma_needs_reservation(h, vma, address);
>  
>  		if (unlikely(rc < 0)) {
>  			/*
>  			 * Rare out of memory condition in reserve map
> -			 * manipulation.  Clear PagePrivate so that
> +			 * manipulation.  Clear HPageRestoreReserve so that
>  			 * global reserve count will not be incremented
>  			 * by free_huge_page.  This will make it appear
>  			 * as though the reservation for this page was
> @@ -2280,7 +2279,7 @@ static void restore_reserve_on_error(struct hstate *h,
>  			 * is better than inconsistent global huge page
>  			 * accounting of reserve counts.
>  			 */
> -			ClearPagePrivate(page);
> +			ClearHPageRestoreReserve(page);
>  		} else if (rc) {
>  			rc = vma_add_reservation(h, vma, address);
>  			if (unlikely(rc < 0))
> @@ -2288,7 +2287,7 @@ static void restore_reserve_on_error(struct hstate *h,
>  				 * See above comment about rare out of
>  				 * memory condition.
>  				 */
> -				ClearPagePrivate(page);
> +				ClearHPageRestoreReserve(page);
>  		} else
>  			vma_end_reservation(h, vma, address);
>  	}
> @@ -2369,7 +2368,7 @@ struct page *alloc_huge_page(struct vm_area_struct *vma,
>  		if (!page)
>  			goto out_uncharge_cgroup;
>  		if (!avoid_reserve && vma_has_reserves(vma, gbl_chg)) {
> -			SetPagePrivate(page);
> +			SetHPageRestoreReserve(page);
>  			h->resv_huge_pages--;
>  		}
>  		spin_lock(&hugetlb_lock);
> @@ -2387,7 +2386,7 @@ struct page *alloc_huge_page(struct vm_area_struct *vma,
>  
>  	spin_unlock(&hugetlb_lock);
>  
> -	set_page_private(page, (unsigned long)spool);
> +	hugetlb_set_page_subpool(page, spool);
>  
>  	map_commit = vma_commit_reservation(h, vma, addr);
>  	if (unlikely(map_chg > map_commit)) {
> @@ -4212,7 +4211,7 @@ static vm_fault_t hugetlb_cow(struct mm_struct *mm, struct vm_area_struct *vma,
>  	spin_lock(ptl);
>  	ptep = huge_pte_offset(mm, haddr, huge_page_size(h));
>  	if (likely(ptep && pte_same(huge_ptep_get(ptep), pte))) {
> -		ClearPagePrivate(new_page);
> +		ClearHPageRestoreReserve(new_page);
>  
>  		/* Break COW */
>  		huge_ptep_clear_flush(vma, haddr, ptep);
> @@ -4279,7 +4278,7 @@ int huge_add_to_page_cache(struct page *page, struct address_space *mapping,
>  
>  	if (err)
>  		return err;
> -	ClearPagePrivate(page);
> +	ClearHPageRestoreReserve(page);
>  
>  	/*
>  	 * set page dirty so that it will not be removed from cache/file
> @@ -4441,7 +4440,7 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
>  		goto backout;
>  
>  	if (anon_rmap) {
> -		ClearPagePrivate(page);
> +		ClearHPageRestoreReserve(page);
>  		hugepage_add_new_anon_rmap(page, vma, haddr);
>  	} else
>  		page_dup_rmap(page, true);
> @@ -4755,7 +4754,7 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
>  	if (vm_shared) {
>  		page_dup_rmap(page, true);
>  	} else {
> -		ClearPagePrivate(page);
> +		ClearHPageRestoreReserve(page);
>  		hugepage_add_new_anon_rmap(page, dst_vma, dst_addr);
>  	}
>  
> 

Looks good to me.Thanks.

Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>
