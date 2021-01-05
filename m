Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAF932EA37F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 03:57:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728118AbhAEC5G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 21:57:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726477AbhAEC5G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 21:57:06 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E11B0C061793
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jan 2021 18:56:25 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id 15so20359220pgx.7
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jan 2021 18:56:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9AEybwBm69eftg0EYajj+axAG59q1uYEjCyvlHbtWBw=;
        b=baZfvCvW6DzeGHxZGTYllRm8nfGKjooORbGZN724+erCePBgDl7vsa5pzxKVrK+1sB
         DyMvSAEwybBGKLXSbkI/yXvagvGrTcGw8fWqTToS6k/wYKVn8Bd01W6bvNp3P5/t/pXz
         AKfCHLFIxemOoD44gRQqFtjjk3Fa7av6/FWhoPxJ4xHGCk8AAUj9kOsRuJm8fN3JPU2j
         4+n2KfMARA42l/AWgsvPl0DLIRAggS0822E2cge/wbTKDstgTDN7IuI6NtLQvETQJndG
         CIyDO7l/D4E1h7k8MNz6G8xQeYJB0Y1MRx1cIhl1kY0MT3ZSBcAJ6vU3DxD+64qvVW0G
         DFKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9AEybwBm69eftg0EYajj+axAG59q1uYEjCyvlHbtWBw=;
        b=icjlCfB7Er7NoOia+RcH4EEZ8NWCipVfLmibVWYEYBZIwLCKN0LP3PRlt81HuHTmOj
         +LvYU1ufxmXru3dDhB7o5LonTvxXkdI6cYmlA59hNq64b8sWomFL8muh075cJZno1SIh
         XfHEobtdTsbthwXuSB1bUQX+2xQ0Z241xKYAzmQ6ThP4Oltr0kaHt02MlxA/XNYxTu4d
         jQi8/o/BU1axpgvXgMlUvMCG2pFrpx4Zx/r5QqcLGhE16HLmLNBnp3kjjYxAWjSD92LL
         P3HcBavQHXD4H0OIljCAlmtVQEdtC0PFaNcycaAm9dAv3G4TQznnzv4yoSJmdbhz6NaC
         tLyg==
X-Gm-Message-State: AOAM531KX+7od9PJiLdbe2800VJL1K1tZB6f3q75QPbWSmqBfXNEs9zI
        USLUW8n12DalIPFPVaQtvywn4X/UZS7uGqPfjmQLSw==
X-Google-Smtp-Source: ABdhPJzFTZnYS94A5UDGnJH/0pYS5Hcr6/QtFKZ95F64YOBsw0Cl7plmMSeUZuONXS0nKjy/Oex7rIy6aKjdll/Gxk0=
X-Received: by 2002:aa7:979d:0:b029:1a4:3b76:a559 with SMTP id
 o29-20020aa7979d0000b02901a43b76a559mr67796241pfp.49.1609815385446; Mon, 04
 Jan 2021 18:56:25 -0800 (PST)
MIME-Version: 1.0
References: <20210104065843.5658-1-songmuchun@bytedance.com>
 <20210104065843.5658-3-songmuchun@bytedance.com> <b41d2f1d-da2c-07ae-6bd0-31022a3378ea@oracle.com>
In-Reply-To: <b41d2f1d-da2c-07ae-6bd0-31022a3378ea@oracle.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Tue, 5 Jan 2021 10:55:46 +0800
Message-ID: <CAMZfGtV-zYoWrHZETd2soOGifRpbhQH=myzQc0NtjpgzC-Fygw@mail.gmail.com>
Subject: Re: [External] Re: [PATCH 3/6] mm: hugetlb: fix a race between
 freeing and dissolving the page
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Andi Kleen <ak@linux.intel.com>, mhocko@suse.cz,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 5, 2021 at 8:02 AM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>
> On 1/3/21 10:58 PM, Muchun Song wrote:
> > There is a race condition between __free_huge_page()
> > and dissolve_free_huge_page().
> >
> > CPU0:                         CPU1:
> >
> > // page_count(page) == 1
> > put_page(page)
> >   __free_huge_page(page)
> >                               dissolve_free_huge_page(page)
> >                                 spin_lock(&hugetlb_lock)
> >                                 // PageHuge(page) && !page_count(page)
> >                                 update_and_free_page(page)
> >                                 // page is freed to the buddy
> >                                 spin_unlock(&hugetlb_lock)
> >     spin_lock(&hugetlb_lock)
> >     clear_page_huge_active(page)
> >     enqueue_huge_page(page)
> >     // It is wrong, the page is already freed
> >     spin_unlock(&hugetlb_lock)
> >
> > The race windows is between put_page() and spin_lock() which
> > is in the __free_huge_page().
> >
> > We should make sure that the page is already on the free list
> > when it is dissolved.
> >
> > Fixes: c8721bbbdd36 ("mm: memory-hotplug: enable memory hotplug to handle hugepage")
> > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > ---
> >  mm/hugetlb.c | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 48 insertions(+)
> >
> > diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > index 1f3bf1710b66..72608008f8b4 100644
> > --- a/mm/hugetlb.c
> > +++ b/mm/hugetlb.c
> > @@ -79,6 +79,21 @@ DEFINE_SPINLOCK(hugetlb_lock);
> >  static int num_fault_mutexes;
> >  struct mutex *hugetlb_fault_mutex_table ____cacheline_aligned_in_smp;
> >
> > +static inline bool PageHugeFreed(struct page *head)
> > +{
> > +     return page_private(head) == -1UL;
>
>         return page_private(head + 4) == -1UL;
>
> > +}
> > +
> > +static inline void SetPageHugeFreed(struct page *head)
> > +{
> > +     set_page_private(head + 4, -1UL);
> > +}
> > +
> > +static inline void ClearPageHugeFreed(struct page *head)
> > +{
> > +     set_page_private(head + 4, 0);
> > +}
>
> It is unfortunate that we can not use some existing value like
> page_huge_active() to determine if dissolve_free_huge_page() should
> proceed with freeing the page to buddy.  If the existing check,
>
>         if (!page_count(page)) {
>
> was changed to
>
>         if (!page_count(page) && !page_huge_active(page)) {
>
> the race window would be shrunk.  However, the most straight forward
> way to fully close the window is with the approach taken here.

I also thought about this fix. But this is not enough. Because
we just call put_page to free the HugeTLB page without
setting activeness in some place (e.g. error handling
routines).

If we use page_huge_active, we should set activeness
before put_page. But we cannot guarantee this.

Thanks.

>
> > +
> >  /* Forward declaration */
> >  static int hugetlb_acct_memory(struct hstate *h, long delta);
> >
> > @@ -1028,6 +1043,7 @@ static void enqueue_huge_page(struct hstate *h, struct page *page)
> >       list_move(&page->lru, &h->hugepage_freelists[nid]);
> >       h->free_huge_pages++;
> >       h->free_huge_pages_node[nid]++;
> > +     SetPageHugeFreed(page);
> >  }
> >
> >  static struct page *dequeue_huge_page_node_exact(struct hstate *h, int nid)
> > @@ -1044,6 +1060,7 @@ static struct page *dequeue_huge_page_node_exact(struct hstate *h, int nid)
> >
> >               list_move(&page->lru, &h->hugepage_activelist);
> >               set_page_refcounted(page);
> > +             ClearPageHugeFreed(page);
> >               h->free_huge_pages--;
> >               h->free_huge_pages_node[nid]--;
> >               return page;
> > @@ -1504,6 +1521,7 @@ static void prep_new_huge_page(struct hstate *h, struct page *page, int nid)
> >       spin_lock(&hugetlb_lock);
> >       h->nr_huge_pages++;
> >       h->nr_huge_pages_node[nid]++;
> > +     ClearPageHugeFreed(page);
> >       spin_unlock(&hugetlb_lock);
> >  }
> >
> > @@ -1770,6 +1788,36 @@ int dissolve_free_huge_page(struct page *page)
> >               int nid = page_to_nid(head);
> >               if (h->free_huge_pages - h->resv_huge_pages == 0)
> >                       goto out;
> > +
> > +             /*
> > +              * There is a race condition between __free_huge_page()
> > +              * and dissolve_free_huge_page().
> > +              *
> > +              * CPU0:                         CPU1:
> > +              *
> > +              * // page_count(page) == 1
> > +              * put_page(page)
> > +              *   __free_huge_page(page)
> > +              *                               dissolve_free_huge_page(page)
> > +              *                                 spin_lock(&hugetlb_lock)
> > +              *                                 // PageHuge(page) && !page_count(page)
> > +              *                                 update_and_free_page(page)
> > +              *                                 // page is freed to the buddy
> > +              *                                 spin_unlock(&hugetlb_lock)
> > +              *     spin_lock(&hugetlb_lock)
> > +              *     enqueue_huge_page(page)
> > +              *     // It is wrong, the page is already freed
> > +              *     spin_unlock(&hugetlb_lock)
> > +              *
> > +              * The race window is between put_page() and spin_lock() which
> > +              * is in the __free_huge_page().
>
> IMO, the description of the race condition in the commit message is
> sufficient.  It does not need to be here in the code.  The below comment
> should be sufficient.

Thanks. Will do.

>
> --
> Mike Kravetz
>
> > +              *
> > +              * We should make sure that the page is already on the free list
> > +              * when it is dissolved.
> > +              */
> > +             if (unlikely(!PageHugeFreed(head)))
> > +                     goto out;
> > +
> >               /*
> >                * Move PageHWPoison flag from head page to the raw error page,
> >                * which makes any subpages rather than the error page reusable.
> >
