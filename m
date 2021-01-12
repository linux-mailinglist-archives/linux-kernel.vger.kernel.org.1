Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB19C2F26A1
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 04:27:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbhALDZb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 22:25:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725885AbhALDZa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 22:25:30 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C6AAC061575
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 19:24:44 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id y12so751718pji.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 19:24:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=88MhZZkiTYL095y5cHODK9nBa0PLN1eNKk834Xx6AoM=;
        b=Eyr6gw/Epnsk9y/QALUwVMBevbVdAn5qUe+kORbqBChkh1+fGQFCnSg23wmKH9KsZa
         9CLY+umsk+8PXjdkeOZzOf5936NRqKSpINERFlzigO+Nk327B0HU4xI323iQkZuj7r5s
         KjpCoqd62SqX+5ksBnAUOE3E+ziJFKA9kDYjVpS2P9+Zno/9HeFGlwfclozCcsuDnqmM
         +Fa4Ar27rbNK8pMQchfs607b3ZeS/72x92XIMhSSyutsjvkp26zS16nkxep8372zZRX0
         Y8VWxVdt0UILIM/0q+w2Zb4rdPhud+U2KYFmsdG08RdgsJX7n0pgV2cs0CQkkh6jJN0W
         aFmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=88MhZZkiTYL095y5cHODK9nBa0PLN1eNKk834Xx6AoM=;
        b=YHFKQc9PnVVGDY+N4/bIjWjMdmUlhkA7XDGDVlofJIqYPgBlEFJ9CuUsRvqXfftW28
         ImFNh2jKiGoltQBLFsix2jRDviHSP5Nq8LCO+ltnoPwnpiQCLzbgGXGuUONpgNjc3+Wy
         D3NZAEBAbxu3gw1l7V8MpLg7BKheBoP8bi8i7336tl7XJ4iLqhYKga2godTzVq5XSgvt
         9d0lyOtkkHzm0LpbBjgIjszOArcAoBLpY/Jk+5cjpeAGoFr/RDBA9bIuLBYUFzCudiT9
         7uYxSs0rFMAN3MnGUWh+vMNrNI9Pz2GHEvTSPLucoP10nk6CMSjaizv15D4rn9Q0f9qE
         fghA==
X-Gm-Message-State: AOAM532DtOZowlsxHi3Fdw02MeHrPMIPwvzlF0dS8f2xcKtO7iaAjFH7
        4XlePUtvCp8g2uqszTOejF2qdz2RGlMKO7vyUie0QqSSkrHWVwJCLzQ=
X-Google-Smtp-Source: ABdhPJz1Vbh21hprw7xZT0rhB3RJxFLThTGKPEcsKVs3HixxOQYFziJO9zs8iO3CyuJb5AsnFXWl+AD7Uh+OgNBIGCU=
X-Received: by 2002:a17:90a:c588:: with SMTP id l8mr2143656pjt.147.1610421883700;
 Mon, 11 Jan 2021 19:24:43 -0800 (PST)
MIME-Version: 1.0
References: <20210111210152.118394-1-mike.kravetz@oracle.com> <20210111210152.118394-2-mike.kravetz@oracle.com>
In-Reply-To: <20210111210152.118394-2-mike.kravetz@oracle.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Tue, 12 Jan 2021 11:24:05 +0800
Message-ID: <CAMZfGtW=y=SESn_M7TC_N=hAVDQJXJkSSswmcy68XKw_KqDD2w@mail.gmail.com>
Subject: Re: [External] [RFC PATCH 1/3] hugetlb: use page.private for hugetlb
 specific page flags
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

On Tue, Jan 12, 2021 at 5:04 AM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>
> As hugetlbfs evolved, state information about hugetlb pages was added.
> One 'convenient' way of doing this was to use available fields in tail
> pages.  Over time, it has become difficult to know the meaning or contents
> of fields simply be looking at a small bit of code.  Sometimes, the
> naming is just confusing.  For example: The PagePrivate flag indicates
> a huge page reservation was consumed and needs to be restored if an error
> is encountered and the page is freed before it is instantiated.  The
> page.private field contains the pointer to a subpool if the page is
> associated with one.
>
> In an effort to make the code more readable, use page.private to contain
> hugetlb specific flags.  These flags will have test, set and clear functions
> similar to those used for 'normal' page flags.  More importantly, the
> flags will have names which actually reflect their purpose.
>
> In this patch,
> - Create infrastructure for huge page flag functions
> - Move subpool pointer to page[1].private to make way for flags
>   Create routines with meaningful names to modify subpool field
> - Use new HPageRestoreReserve reserve flag instead of PagePrivate
>
> Conversion of other state information will happen in subsequent patches.

Great. We can add more meta information easily in the feature.
And it also makes the code more readable. Thanks.

>
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> ---
>  fs/hugetlbfs/inode.c    | 11 +++---
>  include/linux/hugetlb.h |  2 ++
>  mm/hugetlb.c            | 80 +++++++++++++++++++++++++++++++----------
>  3 files changed, 67 insertions(+), 26 deletions(-)
>
> diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
> index b5c109703daa..8bfb80bc6e96 100644
> --- a/fs/hugetlbfs/inode.c
> +++ b/fs/hugetlbfs/inode.c
> @@ -966,14 +966,11 @@ static int hugetlbfs_migrate_page(struct address_space *mapping,
>                 return rc;
>
>         /*
> -        * page_private is subpool pointer in hugetlb pages.  Transfer to
> -        * new page.  PagePrivate is not associated with page_private for
> -        * hugetlb pages and can not be set here as only page_huge_active
> -        * pages can be migrated.
> +        * Transfer any subpool pointer to the new page.
>          */
> -       if (page_private(page)) {
> -               set_page_private(newpage, page_private(page));
> -               set_page_private(page, 0);
> +       if (hpage_spool(page)) {
> +               set_hpage_spool(newpage, hpage_spool(page));
> +               set_hpage_spool(page, 0);
>         }
>
>         if (mode != MIGRATE_SYNC_NO_COPY)
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index ebca2ef02212..4f0159f1b9cc 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -104,6 +104,8 @@ extern int hugetlb_max_hstate __read_mostly;
>  struct hugepage_subpool *hugepage_new_subpool(struct hstate *h, long max_hpages,
>                                                 long min_hpages);
>  void hugepage_put_subpool(struct hugepage_subpool *spool);
> +struct hugepage_subpool *hpage_spool(struct page *hpage);
> +void set_hpage_spool(struct page *hpage, struct hugepage_subpool *spool);
>
>  void reset_vma_resv_huge_pages(struct vm_area_struct *vma);
>  int hugetlb_sysctl_handler(struct ctl_table *, int, void *, size_t *, loff_t *);
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 3b38ea958e95..3eb3b102c589 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -52,6 +52,49 @@ static struct cma *hugetlb_cma[MAX_NUMNODES];
>  #endif
>  static unsigned long hugetlb_cma_size __initdata;
>
> +/*
> + * hugetlb specific state flags located in hpage.private
> + */
> +enum htlb_page_flags {
> +       HPAGE_RestoreReserve = 0,

IMHO, can we rename it to HPG_restore_reserve? I just want to
make the name consistent with the page flags (see enum pageflags
in include/linux/page-flags.h).

May we also should add a __NR_HPAGEFLAGS to indicate
how many bits that we already used. And add a BUILD_BUG_ON
to check whether the used bits exceed sizeof(unsigned long).
Although it is not necessary now. If we can check it, I think it
would be better.

> +};
> +
> +/*
> + * Macros to create function definitions for hpage flags
> + */
> +#define TESTHPAGEFLAG(flname)                                  \
> +static inline int HPage##flname(struct page *page)             \
> +       { return test_bit(HPAGE_##flname, &(page->private)); }
> +
> +#define SETHPAGEFLAG(flname)                                   \
> +static inline void SetHPage##flname(struct page *page)         \
> +       { set_bit(HPAGE_##flname, &(page->private)); }
> +
> +#define CLEARHPAGEFLAG(flname)                                 \
> +static inline void ClearHPage##flname(struct page *page)       \
> +       { clear_bit(HPAGE_##flname, &(page->private)); }
> +
> +#define HPAGEFLAG(flname)                                      \
> +       TESTHPAGEFLAG(flname)                                   \
> +       SETHPAGEFLAG(flname)                                    \
> +       CLEARHPAGEFLAG(flname)
> +
> +HPAGEFLAG(RestoreReserve)
> +
> +/*
> + * hugetlb page subpool pointer located in hpage[1].private
> + */
> +struct hugepage_subpool *hpage_spool(struct page *hpage)
> +{
> +       return (struct hugepage_subpool *)(hpage+1)->private;
> +}
> +
> +void set_hpage_spool(struct page *hpage,
> +               struct hugepage_subpool *spool)
> +{
> +       set_page_private(hpage+1, (unsigned long)spool);
> +}
> +
>  /*
>   * Minimum page order among possible hugepage sizes, set to a proper value
>   * at boot time.
> @@ -1116,7 +1159,7 @@ static struct page *dequeue_huge_page_vma(struct hstate *h,
>         nid = huge_node(vma, address, gfp_mask, &mpol, &nodemask);
>         page = dequeue_huge_page_nodemask(h, gfp_mask, nid, nodemask);
>         if (page && !avoid_reserve && vma_has_reserves(vma, chg)) {
> -               SetPagePrivate(page);
> +               SetHPageRestoreReserve(page);
>                 h->resv_huge_pages--;
>         }
>
> @@ -1391,20 +1434,19 @@ static void __free_huge_page(struct page *page)
>          */
>         struct hstate *h = page_hstate(page);
>         int nid = page_to_nid(page);
> -       struct hugepage_subpool *spool =
> -               (struct hugepage_subpool *)page_private(page);
> +       struct hugepage_subpool *spool = hpage_spool(page);
>         bool restore_reserve;
>
>         VM_BUG_ON_PAGE(page_count(page), page);
>         VM_BUG_ON_PAGE(page_mapcount(page), page);
>
> -       set_page_private(page, 0);
> +       set_hpage_spool(page, 0);
>         page->mapping = NULL;
> -       restore_reserve = PagePrivate(page);
> -       ClearPagePrivate(page);
> +       restore_reserve = HPageRestoreReserve(page);
> +       ClearHPageRestoreReserve(page);
>
>         /*
> -        * If PagePrivate() was set on page, page allocation consumed a
> +        * If RestoreReserve was set on page, page allocation consumed a
>          * reservation.  If the page was associated with a subpool, there
>          * would have been a page reserved in the subpool before allocation
>          * via hugepage_subpool_get_pages().  Since we are 'restoring' the
> @@ -2213,9 +2255,9 @@ static long vma_add_reservation(struct hstate *h,
>   * This routine is called to restore a reservation on error paths.  In the
>   * specific error paths, a huge page was allocated (via alloc_huge_page)
>   * and is about to be freed.  If a reservation for the page existed,
> - * alloc_huge_page would have consumed the reservation and set PagePrivate
> + * alloc_huge_page would have consumed the reservation and set RestoreReserve
>   * in the newly allocated page.  When the page is freed via free_huge_page,
> - * the global reservation count will be incremented if PagePrivate is set.
> + * the global reservation count will be incremented if RestoreReserve is set.
>   * However, free_huge_page can not adjust the reserve map.  Adjust the
>   * reserve map here to be consistent with global reserve count adjustments
>   * to be made by free_huge_page.
> @@ -2224,13 +2266,13 @@ static void restore_reserve_on_error(struct hstate *h,
>                         struct vm_area_struct *vma, unsigned long address,
>                         struct page *page)
>  {
> -       if (unlikely(PagePrivate(page))) {
> +       if (unlikely(HPageRestoreReserve(page))) {
>                 long rc = vma_needs_reservation(h, vma, address);
>
>                 if (unlikely(rc < 0)) {
>                         /*
>                          * Rare out of memory condition in reserve map
> -                        * manipulation.  Clear PagePrivate so that
> +                        * manipulation.  Clear RestoreReserve so that
>                          * global reserve count will not be incremented
>                          * by free_huge_page.  This will make it appear
>                          * as though the reservation for this page was
> @@ -2239,7 +2281,7 @@ static void restore_reserve_on_error(struct hstate *h,
>                          * is better than inconsistent global huge page
>                          * accounting of reserve counts.
>                          */
> -                       ClearPagePrivate(page);
> +                       ClearHPageRestoreReserve(page);
>                 } else if (rc) {
>                         rc = vma_add_reservation(h, vma, address);
>                         if (unlikely(rc < 0))
> @@ -2247,7 +2289,7 @@ static void restore_reserve_on_error(struct hstate *h,
>                                  * See above comment about rare out of
>                                  * memory condition.
>                                  */
> -                               ClearPagePrivate(page);
> +                               ClearHPageRestoreReserve(page);
>                 } else
>                         vma_end_reservation(h, vma, address);
>         }
> @@ -2328,7 +2370,7 @@ struct page *alloc_huge_page(struct vm_area_struct *vma,
>                 if (!page)
>                         goto out_uncharge_cgroup;
>                 if (!avoid_reserve && vma_has_reserves(vma, gbl_chg)) {
> -                       SetPagePrivate(page);
> +                       SetHPageRestoreReserve(page);
>                         h->resv_huge_pages--;
>                 }
>                 spin_lock(&hugetlb_lock);
> @@ -2346,7 +2388,7 @@ struct page *alloc_huge_page(struct vm_area_struct *vma,
>
>         spin_unlock(&hugetlb_lock);
>
> -       set_page_private(page, (unsigned long)spool);
> +       set_hpage_spool(page, spool);
>
>         map_commit = vma_commit_reservation(h, vma, addr);
>         if (unlikely(map_chg > map_commit)) {
> @@ -4150,7 +4192,7 @@ static vm_fault_t hugetlb_cow(struct mm_struct *mm, struct vm_area_struct *vma,
>         spin_lock(ptl);
>         ptep = huge_pte_offset(mm, haddr, huge_page_size(h));
>         if (likely(ptep && pte_same(huge_ptep_get(ptep), pte))) {
> -               ClearPagePrivate(new_page);
> +               ClearHPageRestoreReserve(new_page);
>
>                 /* Break COW */
>                 huge_ptep_clear_flush(vma, haddr, ptep);
> @@ -4217,7 +4259,7 @@ int huge_add_to_page_cache(struct page *page, struct address_space *mapping,
>
>         if (err)
>                 return err;
> -       ClearPagePrivate(page);
> +       ClearHPageRestoreReserve(page);
>
>         /*
>          * set page dirty so that it will not be removed from cache/file
> @@ -4379,7 +4421,7 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
>                 goto backout;
>
>         if (anon_rmap) {
> -               ClearPagePrivate(page);
> +               ClearHPageRestoreReserve(page);
>                 hugepage_add_new_anon_rmap(page, vma, haddr);
>         } else
>                 page_dup_rmap(page, true);
> @@ -4693,7 +4735,7 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
>         if (vm_shared) {
>                 page_dup_rmap(page, true);
>         } else {
> -               ClearPagePrivate(page);
> +               ClearHPageRestoreReserve(page);
>                 hugepage_add_new_anon_rmap(page, dst_vma, dst_addr);
>         }
>
> --
> 2.29.2
>
