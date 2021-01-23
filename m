Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03A77301292
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jan 2021 04:19:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726587AbhAWDRX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 22:17:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726413AbhAWDRL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 22:17:11 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FFD3C061786
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 19:16:23 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id r4so4342041pls.11
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 19:16:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C9os8STP6+MhnEh2q97mBClktafIxYQKkBXeyVRcYes=;
        b=Q8iczL3HgBNt3qX4PHjdYbHrZaSY+Naqd9Hvn6oN4uVyhXVGS6FoaQ5+hXZtc54bg6
         58MdHqBte6IB9nwIvr8+aOpt82ecOapAC1GoKCw1iwdE3YVSkfYv3zVbYDuSOhmpqRxF
         ebjw6PQZMK9p2G5nBSoZtn4VhBUbqeI+0uWPv3Q3Z4KwZsdXLbkx1juCE0IzGcE9mA1z
         kmY7r2G2lX999mQRAW0GpLReB3cSeFBcuGa/oYWOA9xcxj05szfgnJ8erG2/e9xoSc3Y
         4OhmLDMdTwt0OiEcBR+x04QMuU5R/cA1y1Dl2sMg88OVLrw9PEBhUDOD00MbcQmt8lb5
         WyyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C9os8STP6+MhnEh2q97mBClktafIxYQKkBXeyVRcYes=;
        b=h45k8O8TOb+g3UhQs15QUz7XLw58qEln0CRdWRDl7sqdw+zG2jT0i/PKzwJtAuuLaa
         XWtWN4srskMV1qa98xZ+j8XAiHN7RgCG7ac4fdUoCEM0WynEDHJzffsoa9MQGS1cVRMX
         kt0FAMA9SS2wGoChORLfihE56SJgmQetHkV920e/bL73gXi6DK3qaREwBZoj5wnd8LoF
         GPOewp5np3lFTlUaTxK86ROc4C2BtbZKt1oTi4uuMHpeNq1UzhOkRqg48sqRMlRCcQYK
         Eg9HIWpPgBxQ4Otd9iDNSR1/rtq6emCDOARC7GJ+X9sb/PgX6kCD27u2C22UPm+shZYy
         047A==
X-Gm-Message-State: AOAM530Gq/GdGrIGYR91z78os6InZh/+fOQ/l1Igeuc/ehCuJUn2h9V4
        fqB7x4USc/7mgPNK6tErcxHWRlClnNZiU+8O6StiKQ==
X-Google-Smtp-Source: ABdhPJy46rOxqyIO8KfIUJR0V+0IuifiGCqxYbu0rnc+0P2fVAFFGUNTGJox09tu6iF1s+MIjUotZHa8Z7sXFo7GA74=
X-Received: by 2002:a17:90b:46d7:: with SMTP id jx23mr8858544pjb.147.1611371782931;
 Fri, 22 Jan 2021 19:16:22 -0800 (PST)
MIME-Version: 1.0
References: <20210122195231.324857-1-mike.kravetz@oracle.com> <20210122195231.324857-5-mike.kravetz@oracle.com>
In-Reply-To: <20210122195231.324857-5-mike.kravetz@oracle.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Sat, 23 Jan 2021 11:15:46 +0800
Message-ID: <CAMZfGtU03FqXL0dEJtG+4jxf3QyAtJxOC8s5yLfhAToXb0OHAw@mail.gmail.com>
Subject: Re: [External] [PATCH v3 4/5] hugetlb: convert PageHugeTemporary() to
 HPageTemporary flag
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Michal Hocko <mhocko@kernel.org>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Matthew Wilcox <willy@infradead.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 23, 2021 at 3:55 AM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>
> X-Gm-Spam: 0
> X-Gm-Phishy: 0
>
> Use new hugetlb specific HPageTemporary flag to replace the
> PageHugeTemporary() interfaces.  PageHugeTemporary does contain
> a PageHuge() check.  However, this interface is only used within
> hugetlb code where we know we are dealing with a hugetlb page.
> Therefore, the check can be eliminated.
>
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> Reviewed-by: Oscar Salvador <osalvador@suse.de>

Reviewed-by: Muchun Song <songmuchun@bytedance.com>

> ---
>  include/linux/hugetlb.h |  6 ++++++
>  mm/hugetlb.c            | 36 +++++++-----------------------------
>  2 files changed, 13 insertions(+), 29 deletions(-)
>
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index cd1960541f2a..3c86c3a0e144 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -483,10 +483,15 @@ unsigned long hugetlb_get_unmapped_area(struct file *file, unsigned long addr,
>   * HPG_migratable  - Set after a newly allocated page is added to the page
>   *     cache and/or page tables.  Indicates the page is a candidate for
>   *     migration.
> + * HPG_temporary - - Set on a page that is temporarily allocated from the buddy
> + *     allocator.  Typically used for migration target pages when no pages
> + *     are available in the pool.  The hugetlb free page path will
> + *     immediately free pages with this flag set to the buddy allocator.
>   */
>  enum hugetlb_page_flags {
>         HPG_restore_reserve = 0,
>         HPG_migratable,
> +       HPG_temporary,
>         __NR_HPAGEFLAGS,
>  };
>
> @@ -530,6 +535,7 @@ static inline void ClearHPage##uname(struct page *page)             \
>   */
>  HPAGEFLAG(RestoreReserve, restore_reserve)
>  HPAGEFLAG(Migratable, migratable)
> +HPAGEFLAG(Temporary, temporary)
>
>  #ifdef CONFIG_HUGETLB_PAGE
>
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 4da1a29ac5e2..70ffa1027988 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -1353,28 +1353,6 @@ struct hstate *size_to_hstate(unsigned long size)
>         return NULL;
>  }
>
> -/*
> - * Internal hugetlb specific page flag. Do not use outside of the hugetlb
> - * code
> - */
> -static inline bool PageHugeTemporary(struct page *page)
> -{
> -       if (!PageHuge(page))
> -               return false;
> -
> -       return (unsigned long)page[2].mapping == -1U;
> -}
> -
> -static inline void SetPageHugeTemporary(struct page *page)
> -{
> -       page[2].mapping = (void *)-1U;
> -}
> -
> -static inline void ClearPageHugeTemporary(struct page *page)
> -{
> -       page[2].mapping = NULL;
> -}
> -
>  static void __free_huge_page(struct page *page)
>  {
>         /*
> @@ -1422,9 +1400,9 @@ static void __free_huge_page(struct page *page)
>         if (restore_reserve)
>                 h->resv_huge_pages++;
>
> -       if (PageHugeTemporary(page)) {
> +       if (HPageTemporary(page)) {
>                 list_del(&page->lru);
> -               ClearPageHugeTemporary(page);
> +               ClearHPageTemporary(page);
>                 update_and_free_page(h, page);
>         } else if (h->surplus_huge_pages_node[nid]) {
>                 /* remove the page from active list */
> @@ -1860,7 +1838,7 @@ static struct page *alloc_surplus_huge_page(struct hstate *h, gfp_t gfp_mask,
>          * codeflow
>          */
>         if (h->surplus_huge_pages >= h->nr_overcommit_huge_pages) {
> -               SetPageHugeTemporary(page);
> +               SetHPageTemporary(page);
>                 spin_unlock(&hugetlb_lock);
>                 put_page(page);
>                 return NULL;
> @@ -1891,7 +1869,7 @@ static struct page *alloc_migrate_huge_page(struct hstate *h, gfp_t gfp_mask,
>          * We do not account these pages as surplus because they are only
>          * temporary and will be released properly on the last reference
>          */
> -       SetPageHugeTemporary(page);
> +       SetHPageTemporary(page);
>
>         return page;
>  }
> @@ -5612,12 +5590,12 @@ void move_hugetlb_state(struct page *oldpage, struct page *newpage, int reason)
>          * here as well otherwise the global surplus count will not match
>          * the per-node's.
>          */
> -       if (PageHugeTemporary(newpage)) {
> +       if (HPageTemporary(newpage)) {
>                 int old_nid = page_to_nid(oldpage);
>                 int new_nid = page_to_nid(newpage);
>
> -               SetPageHugeTemporary(oldpage);
> -               ClearPageHugeTemporary(newpage);
> +               SetHPageTemporary(oldpage);
> +               ClearHPageTemporary(newpage);
>
>                 spin_lock(&hugetlb_lock);
>                 if (h->surplus_huge_pages_node[old_nid]) {
> --
> 2.29.2
>
