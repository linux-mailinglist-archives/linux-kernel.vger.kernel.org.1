Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43F67303B5A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 12:19:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392236AbhAZLSd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 06:18:33 -0500
Received: from mx2.suse.de ([195.135.220.15]:47558 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389818AbhAZIVD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 03:21:03 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 4CBA5ACF4;
        Tue, 26 Jan 2021 08:20:21 +0000 (UTC)
Date:   Tue, 26 Jan 2021 09:20:18 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Michal Hocko <mhocko@kernel.org>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Muchun Song <songmuchun@bytedance.com>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v3 3/5] hugetlb: only set HPageMigratable for migratable
 hstates
Message-ID: <20210126082018.GB9519@linux>
References: <20210122195231.324857-1-mike.kravetz@oracle.com>
 <20210122195231.324857-4-mike.kravetz@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210122195231.324857-4-mike.kravetz@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 22, 2021 at 11:52:29AM -0800, Mike Kravetz wrote:
> The HP_Migratable flag indicates a page is a candidate for migration.
> Only set the flag if the page's hstate supports migration.  This allows
> the migration paths to detect non-migratable pages earlier.  If migration
> is not supported for the hstate, HP_Migratable will not be set, the page
> will not be isolated and no attempt will be made to migrate.  We should
> never get to unmap_and_move_huge_page for a page where migration is not
> supported, so throw a warning if we do.
> 
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>

I wish there was a better way to do this like opencode it at fault path,
but as you mentioned that is troublesome.

I am not a big fan of the name either, too long for my taste but I cannot
come up with anything better so:

Reviewed-by: Oscar Salvador <osalvador@suse.de>

> ---
>  fs/hugetlbfs/inode.c    | 2 +-
>  include/linux/hugetlb.h | 9 +++++++++
>  mm/hugetlb.c            | 8 ++++----
>  mm/migrate.c            | 9 ++++-----
>  4 files changed, 18 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
> index e1d7ed2a53a9..93f7b8d3c5fd 100644
> --- a/fs/hugetlbfs/inode.c
> +++ b/fs/hugetlbfs/inode.c
> @@ -735,7 +735,7 @@ static long hugetlbfs_fallocate(struct file *file, int mode, loff_t offset,
>  
>  		mutex_unlock(&hugetlb_fault_mutex_table[hash]);
>  
> -		SetHPageMigratable(page);
> +		SetHPageMigratableIfSupported(page);
>  		/*
>  		 * unlock_page because locked by add_to_page_cache()
>  		 * put_page() due to reference from alloc_huge_page()
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index 58be44a915d1..cd1960541f2a 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -740,6 +740,15 @@ static inline bool hugepage_migration_supported(struct hstate *h)
>  	return arch_hugetlb_migration_supported(h);
>  }
>  
> +/*
> + * Only set HPageMigratable if migration supported for page
> + */
> +static inline void SetHPageMigratableIfSupported(struct page *page)
> +{
> +	if (hugepage_migration_supported(page_hstate(page)))
> +		SetHPageMigratable(page);
> +}
> +
>  /*
>   * Movability check is different as compared to migration check.
>   * It determines whether or not a huge page should be placed on
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index f1a3c8230dbf..4da1a29ac5e2 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -4194,7 +4194,7 @@ static vm_fault_t hugetlb_cow(struct mm_struct *mm, struct vm_area_struct *vma,
>  				make_huge_pte(vma, new_page, 1));
>  		page_remove_rmap(old_page, true);
>  		hugepage_add_new_anon_rmap(new_page, vma, haddr);
> -		SetHPageMigratable(new_page);
> +		SetHPageMigratableIfSupported(new_page);
>  		/* Make the old page be freed below */
>  		new_page = old_page;
>  	}
> @@ -4436,7 +4436,7 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
>  	 * been isolated for migration.
>  	 */
>  	if (new_page)
> -		SetHPageMigratable(page);
> +		SetHPageMigratableIfSupported(page);
>  
>  	unlock_page(page);
>  out:
> @@ -4747,7 +4747,7 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
>  	update_mmu_cache(dst_vma, dst_addr, dst_pte);
>  
>  	spin_unlock(ptl);
> -	SetHPageMigratable(page);
> +	SetHPageMigratableIfSupported(page);
>  	if (vm_shared)
>  		unlock_page(page);
>  	ret = 0;
> @@ -5589,7 +5589,7 @@ void putback_active_hugepage(struct page *page)
>  {
>  	VM_BUG_ON_PAGE(!PageHead(page), page);
>  	spin_lock(&hugetlb_lock);
> -	SetHPageMigratable(page);
> +	SetHPageMigratableIfSupported(page);
>  	list_move_tail(&page->lru, &(page_hstate(page))->hugepage_activelist);
>  	spin_unlock(&hugetlb_lock);
>  	put_page(page);
> diff --git a/mm/migrate.c b/mm/migrate.c
> index a3e1acc72ad7..c8d19e83f372 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -1275,13 +1275,12 @@ static int unmap_and_move_huge_page(new_page_t get_new_page,
>  	struct address_space *mapping = NULL;
>  
>  	/*
> -	 * Migratability of hugepages depends on architectures and their size.
> -	 * This check is necessary because some callers of hugepage migration
> -	 * like soft offline and memory hotremove don't walk through page
> -	 * tables or check whether the hugepage is pmd-based or not before
> -	 * kicking migration.
> +	 * Support for migration should be checked at isolation time.
> +	 * Therefore, we should never get here if migration is not supported
> +	 * for the page.
>  	 */
>  	if (!hugepage_migration_supported(page_hstate(hpage))) {
> +		VM_WARN_ON(1);
>  		list_move_tail(&hpage->lru, ret);
>  		return -ENOSYS;
>  	}
> -- 
> 2.29.2
> 
> 

-- 
Oscar Salvador
SUSE L3
