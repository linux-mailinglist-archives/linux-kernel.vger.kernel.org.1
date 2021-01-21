Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 732892FE99A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 13:06:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730940AbhAUMFa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 07:05:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730850AbhAUMCk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 07:02:40 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10A9BC061575
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 04:01:54 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id q4so1161382plr.7
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 04:01:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9zEj33G+/f7SKLVCmHj6CuzSHpc4OEl9xYJk1xQ2zHg=;
        b=KWm0w8bhrmf+kRj/jE8m6r5XoOhaBVOutYgs0OJ+IigifPxXYbnqRi+rdXAPFGJx1v
         6eaLqAMnFYq8+gEMFEim+ghqjAJziPsFFMKHovAAQh7FtJzNM/ikqINtmb/nkPEjNm/N
         u7bW3E5Lz0TVPFlBjn7PAo9f6ePk7kx/CgVMTDSDF3SbwtXCHoeRV7eI0Tq/UJq0GWdB
         tJ+oZCTESPsgotzEDzEr+c0TVHAULN5gQ0PrJ0GFCxOf/bPwLJ4ymSolqvFQGufe3KVY
         fYGTz1I1SiOs2xpL/pN3WZFUE/guoLarAze/bTXPFdkyGP/UDSh77iOiVSJBF2DIsmhY
         5jIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9zEj33G+/f7SKLVCmHj6CuzSHpc4OEl9xYJk1xQ2zHg=;
        b=aYDBTU9sf1u9yZzcNjXavOOd+eozo1qZk5UoWgFyOqZndnbneiD5+GOHM/oranQO+r
         dDWrA5AQoFwS3K+L5ypjcc++qg6tWVabzw2AtfAw2K8Zn9HF+a4MeOpgG+WX17GGicCN
         M8dIG73xqw1Rj8AWgZPfhs6/1hn5qh8luRQ00hxKT7jfqvJ19RA9WYVESjv5FIrC0KXR
         FqR9prUKjpGB7X85/W1jdvtqSbmFf18BkyIILpjRzUsiYi/czrAxhuVARYJYhNZFEz0p
         lGFyFmDFYDkj7NdOQChCJMmlXyIxUWmveEFweK5PAskn3s39ny7pGkyvUK7oeqHWktqd
         IXCQ==
X-Gm-Message-State: AOAM532H5KH3tm1B7G80TW5tS0VRptALGItjDEpFnmuEuthgjav1O1ie
        TkZULPmuQ8an3Sz6NzVYU1ceI+Am7MF668XpAChW8mxpI8Igd5kp
X-Google-Smtp-Source: ABdhPJwmsbPO9zRWE/Z//iaB62pdHGPKssDpE7namvpRMPJJVAjoiFAWSffilw7OP7hDWF+wG2DxZFHL4/pe4T6sENA=
X-Received: by 2002:a17:90a:808a:: with SMTP id c10mr11487636pjn.229.1611230513542;
 Thu, 21 Jan 2021 04:01:53 -0800 (PST)
MIME-Version: 1.0
References: <20210120013049.311822-1-mike.kravetz@oracle.com> <20210120013049.311822-3-mike.kravetz@oracle.com>
In-Reply-To: <20210120013049.311822-3-mike.kravetz@oracle.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Thu, 21 Jan 2021 20:01:15 +0800
Message-ID: <CAMZfGtWSLDFvZQgWByE-uoDxh_icH0jz_EH51rV+56mKcGTEcQ@mail.gmail.com>
Subject: Re: [External] [PATCH v2 2/5] hugetlb: convert page_huge_active()
 HPageMigratable flag
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Michal Hocko <mhocko@kernel.org>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 20, 2021 at 9:33 AM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>
> Use the new hugetlb page specific flag HPageMigratable to replace the
> page_huge_active interfaces.  By it's name, page_huge_active implied
> that a huge page was on the active list.  However, that is not really
> what code checking the flag wanted to know.  It really wanted to determine
> if the huge page could be migrated.  This happens when the page is actually
> added the page cache and/or task page table.  This is the reasoning behind
> the name change.
>
> The VM_BUG_ON_PAGE() calls in the *_huge_active() interfaces are not
> really necessary as we KNOW the page is a hugetlb page.  Therefore, they
> are removed.
>
> The routine page_huge_active checked for PageHeadHuge before testing the
> active bit.  This is unnecessary in the case where we hold a reference or
> lock and know it is a hugetlb head page.  page_huge_active is also called
> without holding a reference or lock (scan_movable_pages), and can race with
> code freeing the page.  The extra check in page_huge_active shortened the
> race window, but did not prevent the race.  Offline code calling
> scan_movable_pages already deals with these races, so removing the check
> is acceptable.  Add comment to racy code.
>
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>

Reviewed-by: Muchun Song <songmuchun@bytedance.com>

Thanks.

> ---
>  fs/hugetlbfs/inode.c       |  2 +-
>  include/linux/hugetlb.h    |  5 +++++
>  include/linux/page-flags.h |  6 -----
>  mm/hugetlb.c               | 45 ++++++++++----------------------------
>  mm/memory_hotplug.c        |  8 ++++++-
>  5 files changed, 24 insertions(+), 42 deletions(-)
>
> diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
> index b8a661780c4a..ec9f03aa2738 100644
> --- a/fs/hugetlbfs/inode.c
> +++ b/fs/hugetlbfs/inode.c
> @@ -735,7 +735,7 @@ static long hugetlbfs_fallocate(struct file *file, int mode, loff_t offset,
>
>                 mutex_unlock(&hugetlb_fault_mutex_table[hash]);
>
> -               set_page_huge_active(page);
> +               SetHPageMigratable(page);
>                 /*
>                  * unlock_page because locked by add_to_page_cache()
>                  * put_page() due to reference from alloc_huge_page()
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index be71a00ee2a0..ce3d03da0133 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -480,9 +480,13 @@ unsigned long hugetlb_get_unmapped_area(struct file *file, unsigned long addr,
>   * HPG_restore_reserve - Set when a hugetlb page consumes a reservation at
>   *     allocation time.  Cleared when page is fully instantiated.  Free
>   *     routine checks flag to restore a reservation on error paths.
> + * HPG_migratable  - Set after a newly allocated page is added to the page
> + *     cache and/or page tables.  Indicates the page is a candidate for
> + *     migration.
>   */
>  enum hugetlb_page_flags {
>         HPG_restore_reserve = 0,
> +       HPG_migratable,
>         __NR_HPAGEFLAGS,
>  };
>
> @@ -529,6 +533,7 @@ static inline void ClearHPage##uname(struct page *page)             \
>   * Create functions associated with hugetlb page flags
>   */
>  HPAGEFLAG(RestoreReserve, restore_reserve)
> +HPAGEFLAG(Migratable, migratable)
>
>  #ifdef CONFIG_HUGETLB_PAGE
>
> diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
> index bc6fd1ee7dd6..04a34c08e0a6 100644
> --- a/include/linux/page-flags.h
> +++ b/include/linux/page-flags.h
> @@ -592,15 +592,9 @@ static inline void ClearPageCompound(struct page *page)
>  #ifdef CONFIG_HUGETLB_PAGE
>  int PageHuge(struct page *page);
>  int PageHeadHuge(struct page *page);
> -bool page_huge_active(struct page *page);
>  #else
>  TESTPAGEFLAG_FALSE(Huge)
>  TESTPAGEFLAG_FALSE(HeadHuge)
> -
> -static inline bool page_huge_active(struct page *page)
> -{
> -       return 0;
> -}
>  #endif
>
>
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 8bed6b5202d2..c24da40626d3 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -1353,30 +1353,6 @@ struct hstate *size_to_hstate(unsigned long size)
>         return NULL;
>  }
>
> -/*
> - * Test to determine whether the hugepage is "active/in-use" (i.e. being linked
> - * to hstate->hugepage_activelist.)
> - *
> - * This function can be called for tail pages, but never returns true for them.
> - */
> -bool page_huge_active(struct page *page)
> -{
> -       return PageHeadHuge(page) && PagePrivate(&page[1]);
> -}
> -
> -/* never called for tail page */
> -void set_page_huge_active(struct page *page)
> -{
> -       VM_BUG_ON_PAGE(!PageHeadHuge(page), page);
> -       SetPagePrivate(&page[1]);
> -}
> -
> -static void clear_page_huge_active(struct page *page)
> -{
> -       VM_BUG_ON_PAGE(!PageHeadHuge(page), page);
> -       ClearPagePrivate(&page[1]);
> -}
> -
>  /*
>   * Internal hugetlb specific page flag. Do not use outside of the hugetlb
>   * code
> @@ -1438,7 +1414,7 @@ static void __free_huge_page(struct page *page)
>         }
>
>         spin_lock(&hugetlb_lock);
> -       clear_page_huge_active(page);
> +       ClearHPageMigratable(page);
>         hugetlb_cgroup_uncharge_page(hstate_index(h),
>                                      pages_per_huge_page(h), page);
>         hugetlb_cgroup_uncharge_page_rsvd(hstate_index(h),
> @@ -4220,7 +4196,7 @@ static vm_fault_t hugetlb_cow(struct mm_struct *mm, struct vm_area_struct *vma,
>                                 make_huge_pte(vma, new_page, 1));
>                 page_remove_rmap(old_page, true);
>                 hugepage_add_new_anon_rmap(new_page, vma, haddr);
> -               set_page_huge_active(new_page);
> +               SetHPageMigratable(new_page);
>                 /* Make the old page be freed below */
>                 new_page = old_page;
>         }
> @@ -4457,12 +4433,12 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
>         spin_unlock(ptl);
>
>         /*
> -        * Only make newly allocated pages active.  Existing pages found
> -        * in the pagecache could be !page_huge_active() if they have been
> -        * isolated for migration.
> +        * Only set HPageMigratable in newly allocated pages.  Existing pages
> +        * found in the pagecache may not have HPageMigratableset if they have
> +        * been isolated for migration.
>          */
>         if (new_page)
> -               set_page_huge_active(page);
> +               SetHPageMigratable(page);
>
>         unlock_page(page);
>  out:
> @@ -4773,7 +4749,7 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
>         update_mmu_cache(dst_vma, dst_addr, dst_pte);
>
>         spin_unlock(ptl);
> -       set_page_huge_active(page);
> +       SetHPageMigratable(page);
>         if (vm_shared)
>                 unlock_page(page);
>         ret = 0;
> @@ -5591,12 +5567,13 @@ bool isolate_huge_page(struct page *page, struct list_head *list)
>         bool ret = true;
>
>         spin_lock(&hugetlb_lock);
> -       if (!PageHeadHuge(page) || !page_huge_active(page) ||
> +       if (!PageHeadHuge(page) ||
> +           !HPageMigratable(page) ||
>             !get_page_unless_zero(page)) {
>                 ret = false;
>                 goto unlock;
>         }
> -       clear_page_huge_active(page);
> +       ClearHPageMigratable(page);
>         list_move_tail(&page->lru, list);
>  unlock:
>         spin_unlock(&hugetlb_lock);
> @@ -5607,7 +5584,7 @@ void putback_active_hugepage(struct page *page)
>  {
>         VM_BUG_ON_PAGE(!PageHead(page), page);
>         spin_lock(&hugetlb_lock);
> -       set_page_huge_active(page);
> +       SetHPageMigratable(page);
>         list_move_tail(&page->lru, &(page_hstate(page))->hugepage_activelist);
>         spin_unlock(&hugetlb_lock);
>         put_page(page);
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index f9d57b9be8c7..563da803e0e0 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -1260,7 +1260,13 @@ static int scan_movable_pages(unsigned long start, unsigned long end,
>                 if (!PageHuge(page))
>                         continue;
>                 head = compound_head(page);
> -               if (page_huge_active(head))
> +               /*
> +                * This test is racy as we hold no reference or lock.  The
> +                * hugetlb page could have been free'ed and head is no longer
> +                * a hugetlb page before the following check.  In such unlikely
> +                * cases false positives and negatives are possible.
> +                */
> +               if (HPageMigratable(head))
>                         goto found;
>                 skip = compound_nr(head) - (page - head);
>                 pfn += skip - 1;
> --
> 2.29.2
>
