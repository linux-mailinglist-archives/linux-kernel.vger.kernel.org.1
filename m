Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63B8A2FCF91
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 13:13:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731675AbhATLjK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 06:39:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729869AbhATKqd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 05:46:33 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F9D7C061575
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 02:45:21 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id 15so14929444pgx.7
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 02:45:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6SjORLENF92riIGeJfZ5A1xf2v8XQdFzn5b/CqTBC7s=;
        b=jv7NPPPWUQHH/nfsSwCRDcXJCzcY0xUJLgtb99rNy+2T+ty/HJCeynfpbKP9KMTc0o
         2JBKbNEvARL9PKdkIdRPEeY35hHIMqvH6WtlFV/rHVvBGqNVSv2v5/4ugLEMxg7NVSTW
         kq5Ex1QJhl2M+HYPl5jzmyofjRWO1jpguLS3lIq/ig4RbtZDVRcwVwueSpR2qw4QXyKm
         vi9B+c2LxH41/lTTcuSrM4bFK4iMP2676AAFaQlR96G8lHQR8u/4No55cAoaROG7Mxvv
         T25VZ3FMssyDL4zS/L6U4mCfUHDz2pt/HKAlRFTNfT0hw9z1DMaEK5rbffoEXwWTk/Bl
         PdYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6SjORLENF92riIGeJfZ5A1xf2v8XQdFzn5b/CqTBC7s=;
        b=VlUtqRqq2VNoAbyZOlcPupYaDZl60D1ra5JAhkjyC6nxKBKU1O5XFLgPbewNurC6sO
         Ra1338JvS6tpDEYauxxxKFP1Gsb4vXo6DWmBhGRA9c7llH0W5imMd8F/Ur7S9p8q+VpW
         uWXMzoArlxd9/+6OmnOTKHgVeJfB/TioeBfakYSWSXz50UJ/sBra/EJC1JeKFtJZBGjP
         HBRzHLhhF4rtvlpAlcjl9s/sSSPIAGYZoZXvBIM1tCFBPRZXw5XEccWoiAq+xWl3JGxq
         in0TXMhurthj2r3BfkL5JlzlHqV66uPvhDm1DEny+/RK1h3IBRHKs8tDFKdMhyZtYixg
         5xqg==
X-Gm-Message-State: AOAM531fcHm2fQA2HFkg5FwsBx4E5wNP7QtJf4Rji25iP5gxACRRcOHw
        DBksCIUtIwINBxMyerSUZ8ud3x8llr3mwjCBP70q9g==
X-Google-Smtp-Source: ABdhPJxd2wTKc+IYW15gwCI0FakmX2YZ2x/+bNncDfjzsSljVb7V5ro2XC3hPWZFrbKdHIZ0y3mkiZlMTlfSJBIEkqg=
X-Received: by 2002:a63:480f:: with SMTP id v15mr8647704pga.341.1611139520616;
 Wed, 20 Jan 2021 02:45:20 -0800 (PST)
MIME-Version: 1.0
References: <20210120013049.311822-1-mike.kravetz@oracle.com> <20210120013049.311822-6-mike.kravetz@oracle.com>
In-Reply-To: <20210120013049.311822-6-mike.kravetz@oracle.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Wed, 20 Jan 2021 18:44:41 +0800
Message-ID: <CAMZfGtWEzrRkVuRU-9GOFcRi6OvvZ7Akw_eH2vbK4kUMOXH9ZQ@mail.gmail.com>
Subject: Re: [External] [PATCH v2 5/5] hugetlb: convert PageHugeFreed to
 HPageFreed flag
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

On Wed, Jan 20, 2021 at 9:31 AM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>
> Use new hugetlb specific HPageFreed flag to replace the
> PageHugeFreed interfaces.
>
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>

Reviewed-by: Muchun Song <songmuchun@bytedance.com>

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
>   *     allocator.  Typically used for migration target pages when no pages
>   *     are available in the pool.  The hugetlb free page path will
>   *     immediately free pages with this flag set to the buddy allocator.
> + * HPG_freed - Set when page is on the free lists.
>   */
>  enum hugetlb_page_flags {
>         HPG_restore_reserve = 0,
>         HPG_migratable,
>         HPG_temporary,
> +       HPG_freed,
>         __NR_HPAGEFLAGS,
>  };
>
> @@ -540,6 +542,7 @@ static inline void ClearHPage##uname(struct page *page)             \
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
> -       return page_private(head + 4) == -1UL;
> -}
> -
> -static inline void SetPageHugeFreed(struct page *head)
> -{
> -       set_page_private(head + 4, -1UL);
> -}
> -
> -static inline void ClearPageHugeFreed(struct page *head)
> -{
> -       set_page_private(head + 4, 0);
> -}
> -
>  /* Forward declaration */
>  static int hugetlb_acct_memory(struct hstate *h, long delta);
>
> @@ -1043,7 +1028,7 @@ static void enqueue_huge_page(struct hstate *h, struct page *page)
>         list_move(&page->lru, &h->hugepage_freelists[nid]);
>         h->free_huge_pages++;
>         h->free_huge_pages_node[nid]++;
> -       SetPageHugeFreed(page);
> +       SetHPageFreed(page);
>  }
>
>  static struct page *dequeue_huge_page_node_exact(struct hstate *h, int nid)
> @@ -1060,7 +1045,7 @@ static struct page *dequeue_huge_page_node_exact(struct hstate *h, int nid)
>
>                 list_move(&page->lru, &h->hugepage_activelist);
>                 set_page_refcounted(page);
> -               ClearPageHugeFreed(page);
> +               ClearHPageFreed(page);
>                 h->free_huge_pages--;
>                 h->free_huge_pages_node[nid]--;
>                 return page;
> @@ -1474,7 +1459,7 @@ static void prep_new_huge_page(struct hstate *h, struct page *page, int nid)
>         spin_lock(&hugetlb_lock);
>         h->nr_huge_pages++;
>         h->nr_huge_pages_node[nid]++;
> -       ClearPageHugeFreed(page);
> +       ClearHPageFreed(page);
>         spin_unlock(&hugetlb_lock);
>  }
>
> @@ -1747,7 +1732,7 @@ int dissolve_free_huge_page(struct page *page)
>                  * We should make sure that the page is already on the free list
>                  * when it is dissolved.
>                  */
> -               if (unlikely(!PageHugeFreed(head))) {
> +               if (unlikely(!HPageFreed(head))) {
>                         rc = -EAGAIN;
>                         goto out;
>                 }
> --
> 2.29.2
>
