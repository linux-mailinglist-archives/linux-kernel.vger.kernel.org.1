Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 659D92F26CB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 04:47:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728190AbhALDq6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 22:46:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727478AbhALDq6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 22:46:58 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EACDAC061786
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 19:46:11 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id l23so818649pjg.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 19:46:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cDQIrU7xmxgvEAoB53gspTpLRgNgnuyqcNPfveY0WNc=;
        b=IzKW2M4DhUgZ4kgbpL5d/SXmqiPiFweklRS+xDO+ggPJBb4CldiEqr9VsAdOATN6EE
         oinC8vjmy8DRpyAeShDzcxNuP/Vr1osXLPazuv0GmFwxg6/0eSwzje8dZht8sDIu+nR5
         b5AXiaKFleWMGMaWen/uWwZykBDVctDkZ4Zc8p2Zk1dBX1fLu7SzwfthWXHNgg3Y1XTM
         HAINDOouLcsVlt4YpnshGg67n5JPqwI/27sPTNi/crDvzZmcFrT70PezBd1EIbS58nYJ
         42OLJhApekJYPW4uVJigWlE8SxvNcWd7v8UYnBKdJ0wX3PpJ0Ru9DP/bJS71iNYS6eT1
         UsPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cDQIrU7xmxgvEAoB53gspTpLRgNgnuyqcNPfveY0WNc=;
        b=fl9mZIuuTkts53KGVgkXc7/TjLzmfyainpWOuPgvfKgIfvXIZYTeo5JHFpGTYfsSUT
         Xac8KGEXVp0TN80ms5880HX9QBThIqK//QCqLl/zZpcpP4qFd4sPC1UAZZ4LWk2rJN5Z
         a5P9PzQ/ikqbwfWjg2ZAE9F7ns7UY9ZA5FZltld+1gAbyPS6G0sIfAlsYd+LgBV2OnZs
         mHrZ1tZBcZKgudPyLIUVanhlTEv0uJwQ/Eocp7BT3HCSMVGw9J9pabCVih5Gz2qDT9hP
         jwmw0m0Upi3qZJiK0KswHFugM6YwAgmVk0uNgz3oXje9Z743I3G18a45UZmPcm/PnJ3U
         yYqw==
X-Gm-Message-State: AOAM532Jj/eytxOjsryoCkVPsgV/qYylhK1kH5dCwU7XeAtf9iSHTezL
        rRvSwgBNmSzHVVXFBxtAqvPgRP2iDpWIh4a0ZEzU/w==
X-Google-Smtp-Source: ABdhPJwT5rFDfG1p+fDRkYRLSd7/vxPDjt4UVIRzaJrO6AHmSfFAzNTjUVUiZYKjC3QCKDNZpyZ2V6LeCt6jcBuFNIA=
X-Received: by 2002:a17:90a:c588:: with SMTP id l8mr2223491pjt.147.1610423171400;
 Mon, 11 Jan 2021 19:46:11 -0800 (PST)
MIME-Version: 1.0
References: <20210111210152.118394-1-mike.kravetz@oracle.com> <20210111210152.118394-3-mike.kravetz@oracle.com>
In-Reply-To: <20210111210152.118394-3-mike.kravetz@oracle.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Tue, 12 Jan 2021 11:45:33 +0800
Message-ID: <CAMZfGtV+xs+pRMOtv8DOBJUeuorQmPYbpG9uktjeaZOFdtbBZQ@mail.gmail.com>
Subject: Re: [External] [RFC PATCH 2/3] hugetlb: convert page_huge_active() to
 HPageMigratable flag
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Michal Hocko <mhocko@kernel.org>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 12, 2021 at 5:02 AM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>
> Use the new hugetlb page specific flag to replace the page_huge_active
> interfaces.  By it's name, page_huge_active implied that a huge page
> was on the active list.  However, that is not really what code checking
> the flag wanted to know.  It really wanted to determine if the huge
> page could be migrated.  This happens when the page is actually added
> the page cache and/or task page table.  This is the reasoning behind the
> name change.
>
> The VM_BUG_ON_PAGE() calls in the interfaces were not really necessary
> as in all case but one we KNOW the page is a hugetlb page.  Therefore,
> they are removed.  In one call to HPageMigratable() is it possible for
> the page to not be a hugetlb page due to a race.  However, the code
> making the call (scan_movable_pages) is inherently racy, and page state
> will be validated later in the migration process.
>
> Note:  Since HPageMigratable is used outside hugetlb.c, it can not be
> static.  Therefore, a new set of hugetlb page flag macros is added for
> non-static flag functions.
>
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> ---
>  include/linux/hugetlb.h    | 17 +++++++++++
>  include/linux/page-flags.h |  6 ----
>  mm/hugetlb.c               | 60 +++++++++++++++++---------------------
>  mm/memory_hotplug.c        |  2 +-
>  4 files changed, 45 insertions(+), 40 deletions(-)
>
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index 4f0159f1b9cc..46e590552d55 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -190,6 +190,9 @@ unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
>
>  bool is_hugetlb_entry_migration(pte_t pte);
>
> +int HPageMigratable(struct page *page);
> +void SetHPageMigratable(struct page *page);
> +void ClearHPageMigratable(struct page *page);
>  #else /* !CONFIG_HUGETLB_PAGE */
>
>  static inline void reset_vma_resv_huge_pages(struct vm_area_struct *vma)
> @@ -370,6 +373,20 @@ static inline vm_fault_t hugetlb_fault(struct mm_struct *mm,
>         return 0;
>  }
>
> +static inline int HPageMigratable(struct page *page)
> +{
> +       return(0);
> +}
> +
> +static inline void SetHPageMigratable(struct page *page)
> +{
> +       return;
> +}
> +
> +static inline void ClearHPageMigratable(struct page *page)
> +{
> +       return;
> +}

How about introducing the HPAGEFLAG_NOOP macro to do
that?

#define TESTHPAGEFLAG_FALSE(flname) \
static inline int HPage##flname(struct page *page) { return 0; }

#define SETHPAGEFLAG_NOOP(flname) \
static inline void SetHPage##flname(struct page *page) {}

#define CLEARHPAGEFLAG_NOOP(flname) \
static inline void ClearHPage##flname(struct page *page) {}

#define HPAGEFLAG_NOOP(flname) \
TESTHPAGEFLAG_FALSE(flname) \
SETHPAGEFLAG_NOOP(flname) \
CLEARHPAGEFLAG_NOOP(flname)

HPAGEFLAG_NOOP(Migratable)

>  #endif /* !CONFIG_HUGETLB_PAGE */
>  /*
>   * hugepages at page global directory. If arch support
> diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
> index 4f6ba9379112..167250466c9c 100644
> --- a/include/linux/page-flags.h
> +++ b/include/linux/page-flags.h
> @@ -593,15 +593,9 @@ static inline void ClearPageCompound(struct page *page)
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
> index 3eb3b102c589..34ce82f4823c 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -57,6 +57,7 @@ static unsigned long hugetlb_cma_size __initdata;
>   */
>  enum htlb_page_flags {
>         HPAGE_RestoreReserve = 0,
> +       HPAGE_Migratable,
>  };
>
>  /*
> @@ -79,7 +80,25 @@ static inline void ClearHPage##flname(struct page *page)     \
>         SETHPAGEFLAG(flname)                                    \
>         CLEARHPAGEFLAG(flname)
>
> +#define EXT_TESTHPAGEFLAG(flname)                                      \
> +int HPage##flname(struct page *page)           \
> +       { return test_bit(HPAGE_##flname, &(page->private)); }
> +
> +#define EXT_SETHPAGEFLAG(flname)                                       \
> +void SetHPage##flname(struct page *page)               \
> +       { set_bit(HPAGE_##flname, &(page->private)); }
> +
> +#define EXT_CLEARHPAGEFLAG(flname)                                     \
> +void ClearHPage##flname(struct page *page)     \
> +       { clear_bit(HPAGE_##flname, &(page->private)); }
> +
> +#define EXT_HPAGEFLAG(flname)                                  \
> +       EXT_TESTHPAGEFLAG(flname)                                       \
> +       EXT_SETHPAGEFLAG(flname)                                        \
> +       EXT_CLEARHPAGEFLAG(flname)
> +
>  HPAGEFLAG(RestoreReserve)
> +EXT_HPAGEFLAG(Migratable)

How about moving HPAGEFLAG to include/linux/hugetlb.h
(including enum htlb_page_flags)? In this case, we do not need
EXT_HPAGEFLAG. Although other nodule do not need
the function of HPAGEFLAG(RestoreReserve). IMHO, I think
it can make code more clean. Right?

>
>  /*
>   * hugetlb page subpool pointer located in hpage[1].private
> @@ -1379,31 +1398,6 @@ struct hstate *size_to_hstate(unsigned long size)
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
> -       VM_BUG_ON_PAGE(!PageHuge(page), page);
> -       return PageHead(page) && PagePrivate(&page[1]);
> -}
> -
> -/* never called for tail page */
> -static void set_page_huge_active(struct page *page)
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
> @@ -1465,7 +1459,7 @@ static void __free_huge_page(struct page *page)
>         }
>
>         spin_lock(&hugetlb_lock);
> -       clear_page_huge_active(page);
> +       ClearHPageMigratable(page);
>         hugetlb_cgroup_uncharge_page(hstate_index(h),
>                                      pages_per_huge_page(h), page);
>         hugetlb_cgroup_uncharge_page_rsvd(hstate_index(h),
> @@ -4201,7 +4195,7 @@ static vm_fault_t hugetlb_cow(struct mm_struct *mm, struct vm_area_struct *vma,
>                                 make_huge_pte(vma, new_page, 1));
>                 page_remove_rmap(old_page, true);
>                 hugepage_add_new_anon_rmap(new_page, vma, haddr);
> -               set_page_huge_active(new_page);
> +               SetHPageMigratable(new_page);
>                 /* Make the old page be freed below */
>                 new_page = old_page;
>         }
> @@ -4439,11 +4433,11 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
>
>         /*
>          * Only make newly allocated pages active.  Existing pages found
> -        * in the pagecache could be !page_huge_active() if they have been
> +        * in the pagecache could be !HPageMigratable if they have been
>          * isolated for migration.
>          */
>         if (new_page)
> -               set_page_huge_active(page);
> +               SetHPageMigratable(page);
>
>         unlock_page(page);
>  out:
> @@ -4754,7 +4748,7 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
>         update_mmu_cache(dst_vma, dst_addr, dst_pte);
>
>         spin_unlock(ptl);
> -       set_page_huge_active(page);
> +       SetHPageMigratable(page);
>         if (vm_shared)
>                 unlock_page(page);
>         ret = 0;
> @@ -5580,11 +5574,11 @@ bool isolate_huge_page(struct page *page, struct list_head *list)
>
>         VM_BUG_ON_PAGE(!PageHead(page), page);
>         spin_lock(&hugetlb_lock);
> -       if (!page_huge_active(page) || !get_page_unless_zero(page)) {
> +       if (!HPageMigratable(page) || !get_page_unless_zero(page)) {
>                 ret = false;
>                 goto unlock;
>         }
> -       clear_page_huge_active(page);
> +       ClearHPageMigratable(page);
>         list_move_tail(&page->lru, list);
>  unlock:
>         spin_unlock(&hugetlb_lock);
> @@ -5595,7 +5589,7 @@ void putback_active_hugepage(struct page *page)
>  {
>         VM_BUG_ON_PAGE(!PageHead(page), page);
>         spin_lock(&hugetlb_lock);
> -       set_page_huge_active(page);
> +       SetHPageMigratable(page);
>         list_move_tail(&page->lru, &(page_hstate(page))->hugepage_activelist);
>         spin_unlock(&hugetlb_lock);
>         put_page(page);
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 0f855deea4b2..fefd43757017 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -1261,7 +1261,7 @@ static int scan_movable_pages(unsigned long start, unsigned long end,
>                 if (!PageHuge(page))
>                         continue;
>                 head = compound_head(page);
> -               if (page_huge_active(head))
> +               if (HPageMigratable(head))
>                         goto found;
>                 skip = compound_nr(head) - (page - head);
>                 pfn += skip - 1;
> --
> 2.29.2
>
