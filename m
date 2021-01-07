Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B4EB2ECA39
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 06:42:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726051AbhAGFlA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 00:41:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725763AbhAGFk7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 00:40:59 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57906C0612F0
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jan 2021 21:40:19 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id v1so847141pjr.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jan 2021 21:40:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1jnCkm1owhte9y8px2sov/viXOh3cLFDZwAq5Gr8Nwg=;
        b=p+7kg5ziqAvL8WUTcXPi5/ASddQWqKnDpDRlZp9bTaYRoBPArjxki+Wfn/KwE5GfGh
         99Sr8KC9yQJp2wozkI8jSA4Kdi2IgDQCfG3vrhrtxYbcC8A9ZINziXP27Da+fE9JHL2p
         qKKQoFQqX8ymMWf3HJVm4GqIIh3jBXZCuVl80oMDRC9xT5fu1d3XhgCm+k+Ho9aFNVUg
         4V2Z5tHvB7GkwqGNkx9NsU3+hjE/A7NXuHR0NORJgCNyZCrplBw6L7WGNssvrH81BKkt
         yO1xdETUGIxAh8DKcGdKadT8wrzkVLPW8W/0oOTehcA5QjLTVMEX3KRlfZzA9TiFlnt8
         93MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1jnCkm1owhte9y8px2sov/viXOh3cLFDZwAq5Gr8Nwg=;
        b=T9KsGGlrGC4PZRfWlSpKFDKJ0GM/3SOsPyLRIjwdShB7MPnWzrweaB3f1kOzqll6Px
         8lQjZcHKmR3YRiEkWsZUvanKEaFnqe8tG7q/OJfDr56bZ7Djq+E1R9tGJmHNrMlTMCGW
         K/2S5MZfzsTO7Li8waXh8d4q1p5jV0lAZjTo3fsqwED0toFeklOoqak4vgZ/aZ++op4i
         7w7fPtGD3itKKUbeN0kZPn8eR3jAEzVEvghbEbUNZXdnc6SfFEZl/TlXLuhX1MFg+cW3
         yOR6Cw7QEFkkx5uqhqzXIWzYQgteup3ka43D7Yjn4Llw/nufJbWGjV4iIOejvITc2lTM
         SmtQ==
X-Gm-Message-State: AOAM533iRWcEZi6eCBzU/A34BqrhtSt0hK0057sMERp38Ge2NFlQNT8U
        oq0Nf1oZfhNDF1/CX9p9Zl0zNK0Xnh3gF2QR6Yp2sQ==
X-Google-Smtp-Source: ABdhPJxXzC0R4XPggBOlhY6T2zzIZ1lXQ6+U0TVonqjomDw0Cdx1gWk0kdF4Ni6T3EL8CEacGeb6utMsERIpYlJ2s6U=
X-Received: by 2002:a17:90a:ba88:: with SMTP id t8mr7637885pjr.229.1609998018749;
 Wed, 06 Jan 2021 21:40:18 -0800 (PST)
MIME-Version: 1.0
References: <20210106084739.63318-1-songmuchun@bytedance.com>
 <20210106084739.63318-4-songmuchun@bytedance.com> <20210106165632.GT13207@dhcp22.suse.cz>
In-Reply-To: <20210106165632.GT13207@dhcp22.suse.cz>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Thu, 7 Jan 2021 13:39:38 +0800
Message-ID: <CAMZfGtWML+PUnK=jJJ1XFmv=VdKOZYmKjyYU=nhpq-1sSGKMqg@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v2 3/6] mm: hugetlb: fix a race between
 freeing and dissolving the page
To:     Michal Hocko <mhocko@suse.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Andi Kleen <ak@linux.intel.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 7, 2021 at 12:56 AM Michal Hocko <mhocko@suse.com> wrote:
>
> On Wed 06-01-21 16:47:36, Muchun Song wrote:
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
>
> The race window reall is between put_page and dissolve_free_huge_page.
> And the result is that the put_page path would clobber an unrelated page
> (either free or already reused page) which is quite serious.
> Fortunatelly pages are dissolved very rarely. I believe that user would
> require to be privileged to hit this by intention.
>
> > We should make sure that the page is already on the free list
> > when it is dissolved.
>
> Another option would be to check for PageHuge in __free_huge_page. Have
> you considered that rather than add yet another state? The scope of the
> spinlock would have to be extended. If that sounds more tricky then can
> we check the page->lru in the dissolve path? If the page is still
> PageHuge and reference count 0 then there shouldn't be many options
> where it can be queued, right?

Did you mean that we iterate over the free list to check whether
the page is on the free list? If so, I do not think it is a good solution
than introducing another state. Because if there are a lot of pages
on the free list, it may take some time to do it with holding
hugetlb_lock. Right? Actually, we have some tail page structs
to store the state. At least it's not in short supply right now.

Thanks.

>
> > Fixes: c8721bbbdd36 ("mm: memory-hotplug: enable memory hotplug to handle hugepage")
> > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > ---
> >  mm/hugetlb.c | 38 ++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 38 insertions(+)
> >
> > diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > index 4741d60f8955..8ff138c17129 100644
> > --- a/mm/hugetlb.c
> > +++ b/mm/hugetlb.c
> > @@ -79,6 +79,21 @@ DEFINE_SPINLOCK(hugetlb_lock);
> >  static int num_fault_mutexes;
> >  struct mutex *hugetlb_fault_mutex_table ____cacheline_aligned_in_smp;
> >
> > +static inline bool PageHugeFreed(struct page *head)
> > +{
> > +     return (unsigned long)head[3].mapping == -1U;
> > +}
> > +
> > +static inline void SetPageHugeFreed(struct page *head)
> > +{
> > +     head[3].mapping = (void *)-1U;
> > +}
> > +
> > +static inline void ClearPageHugeFreed(struct page *head)
> > +{
> > +     head[3].mapping = NULL;
> > +}
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
> > @@ -1291,6 +1308,17 @@ static inline void destroy_compound_gigantic_page(struct page *page,
> >                                               unsigned int order) { }
> >  #endif
> >
> > +/*
> > + * Because we reuse the mapping field of some tail page structs, we should
> > + * reset those mapping to initial value before @head is freed to the buddy
> > + * allocator. The invalid value will be checked in the free_tail_pages_check().
> > + */
> > +static inline void reset_tail_page_mapping(struct hstate *h, struct page *head)
> > +{
> > +     if (!hstate_is_gigantic(h))
> > +             head[3].mapping = TAIL_MAPPING;
> > +}
> > +
> >  static void update_and_free_page(struct hstate *h, struct page *page)
> >  {
> >       int i;
> > @@ -1298,6 +1326,7 @@ static void update_and_free_page(struct hstate *h, struct page *page)
> >       if (hstate_is_gigantic(h) && !gigantic_page_runtime_supported())
> >               return;
> >
> > +     reset_tail_page_mapping(h, page);
> >       h->nr_huge_pages--;
> >       h->nr_huge_pages_node[page_to_nid(page)]--;
> >       for (i = 0; i < pages_per_huge_page(h); i++) {
> > @@ -1504,6 +1533,7 @@ static void prep_new_huge_page(struct hstate *h, struct page *page, int nid)
> >       spin_lock(&hugetlb_lock);
> >       h->nr_huge_pages++;
> >       h->nr_huge_pages_node[nid]++;
> > +     ClearPageHugeFreed(page);
> >       spin_unlock(&hugetlb_lock);
> >  }
> >
> > @@ -1770,6 +1800,14 @@ int dissolve_free_huge_page(struct page *page)
> >               int nid = page_to_nid(head);
> >               if (h->free_huge_pages - h->resv_huge_pages == 0)
> >                       goto out;
> > +
> > +             /*
> > +              * We should make sure that the page is already on the free list
> > +              * when it is dissolved.
> > +              */
> > +             if (unlikely(!PageHugeFreed(head)))
> > +                     goto out;
> > +
> >               /*
> >                * Move PageHWPoison flag from head page to the raw error page,
> >                * which makes any subpages rather than the error page reusable.
> > --
> > 2.11.0
>
> --
> Michal Hocko
> SUSE Labs
