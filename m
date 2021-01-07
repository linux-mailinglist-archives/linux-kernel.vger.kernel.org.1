Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF6D92EC8DE
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 04:10:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726711AbhAGDJ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 22:09:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726009AbhAGDJ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 22:09:57 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07881C0612EF
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jan 2021 19:09:17 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id h186so2999414pfe.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jan 2021 19:09:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rD99powxPx4r6hhXAyIjhyhZZ+nmITFUObXAUERyXlY=;
        b=Bk0JxjJdEDE7/4PWIkF+SGcHF7jdX3JFoEDoPNVRcrx1l0ik/XZPTwZY9on/Bz/2+r
         AOeVwfegqK8kvYzQRquZZe6uyhubH8HhFAprysqoSzxMG4ytax4SPP8dxwYkZRqf8nqA
         L13NyEmJqefaoC8mtcfnCzNpXW76Ph0s+XIvmTYu/0SlRFH234ARNMKxo/BupgycTg/n
         mG1muXK1yw4VDq3vT9v0MrQ8gJmw6lrxiQyJZSCFoLkTJLBrOrvTh7x5M2n/LKLhQKfO
         USYaGdJcsttfgD3LSq7wuXwZyRyeZmgCgk7UFbeLlOg30WrH3eWtdJIZ8BoSa20R9J7a
         yVJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rD99powxPx4r6hhXAyIjhyhZZ+nmITFUObXAUERyXlY=;
        b=n6k3XG1uZn9y5AhNNhjJFWRTXn3JYFBBOzMIrH1VvoeO4heyG2mSqYO0xJTDF+fNWO
         FJbBX+lxDsMAQLkyhz1U/QybTIvYjvKk5N0+0adrpf8GpPArvFmrydrl5Fmj5rl2WqpJ
         lsRSCVoNazOyehrmtwHSjIK6fck8UADns2VXZ818rp+/gl2YZfHldAqggQRl2gCV1EXp
         OaJyw/zGHdQtj7V6LWE1Ci61Puu4n3w7rO/okLpO4tdy0++Uzd+SR+DOIPoRajrfjm9S
         7s5T/sF4BQVnDkf8Ctm0H05M0b3dT/+PAU80ekUfLWEwcUW8/wHQoNqQrbyTI9qwlA2J
         SAvA==
X-Gm-Message-State: AOAM5303eQw7M/9bvk8HySlWxOoT16OcIlwtJSC0LQTiOT8pcCguvSq2
        8leZjvT7YGgrvDMrbtFfwIUbg7rdMr59+W/5XUK7gA==
X-Google-Smtp-Source: ABdhPJwagtK5gxq7lflxscL2LOMEj3UGq3+cfm1TaSDiu/9I2ESCypact/j4hkxrjaxptrDHS+7UixupbbH4KrfGsCA=
X-Received: by 2002:aa7:8701:0:b029:19e:561:d476 with SMTP id
 b1-20020aa787010000b029019e0561d476mr7080431pfo.2.1609988955884; Wed, 06 Jan
 2021 19:09:15 -0800 (PST)
MIME-Version: 1.0
References: <20210106084739.63318-1-songmuchun@bytedance.com>
 <20210106084739.63318-4-songmuchun@bytedance.com> <20210106165632.GT13207@dhcp22.suse.cz>
 <a9c59b0e-9a9d-c568-5503-5df6fe8db908@oracle.com>
In-Reply-To: <a9c59b0e-9a9d-c568-5503-5df6fe8db908@oracle.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Thu, 7 Jan 2021 11:08:37 +0800
Message-ID: <CAMZfGtWgYVOBdf7cjefoAHEQ8QYO4RtjVwjmsQCauqYf_kFkCA@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v2 3/6] mm: hugetlb: fix a race between
 freeing and dissolving the page
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Andi Kleen <ak@linux.intel.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 7, 2021 at 5:00 AM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>
> On 1/6/21 8:56 AM, Michal Hocko wrote:
> > On Wed 06-01-21 16:47:36, Muchun Song wrote:
> >> There is a race condition between __free_huge_page()
> >> and dissolve_free_huge_page().
> >>
> >> CPU0:                         CPU1:
> >>
> >> // page_count(page) == 1
> >> put_page(page)
> >>   __free_huge_page(page)
> >>                               dissolve_free_huge_page(page)
> >>                                 spin_lock(&hugetlb_lock)
> >>                                 // PageHuge(page) && !page_count(page)
> >>                                 update_and_free_page(page)
> >>                                 // page is freed to the buddy
> >>                                 spin_unlock(&hugetlb_lock)
> >>     spin_lock(&hugetlb_lock)
> >>     clear_page_huge_active(page)
> >>     enqueue_huge_page(page)
> >>     // It is wrong, the page is already freed
> >>     spin_unlock(&hugetlb_lock)
> >>
> >> The race windows is between put_page() and spin_lock() which
> >> is in the __free_huge_page().
> >
> > The race window reall is between put_page and dissolve_free_huge_page.
> > And the result is that the put_page path would clobber an unrelated page
> > (either free or already reused page) which is quite serious.
> > Fortunatelly pages are dissolved very rarely. I believe that user would
> > require to be privileged to hit this by intention.
> >
> >> We should make sure that the page is already on the free list
> >> when it is dissolved.
> >
> > Another option would be to check for PageHuge in __free_huge_page. Have
> > you considered that rather than add yet another state? The scope of the
> > spinlock would have to be extended. If that sounds more tricky then can
> > we check the page->lru in the dissolve path? If the page is still
> > PageHuge and reference count 0 then there shouldn't be many options
> > where it can be queued, right?
>
> The tricky part with expanding lock scope will be the potential call to
> hugepage_subpool_put_pages as it may also try to acquire the hugetlb_lock.
>
> I am not sure what you mean by 'check the page->lru'?  If we knew the page
> was on the free list, then we could dissolve.  But, I do not think there
> is an easy way to determine that from page->lru.  A hugetlb page is either
> going to be on the active list or free list.
>
> >
> >> Fixes: c8721bbbdd36 ("mm: memory-hotplug: enable memory hotplug to handle hugepage")
> >> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> >> ---
> >>  mm/hugetlb.c | 38 ++++++++++++++++++++++++++++++++++++++
> >>  1 file changed, 38 insertions(+)
> >>
> >> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> >> index 4741d60f8955..8ff138c17129 100644
> >> --- a/mm/hugetlb.c
> >> +++ b/mm/hugetlb.c
> >> @@ -79,6 +79,21 @@ DEFINE_SPINLOCK(hugetlb_lock);
> >>  static int num_fault_mutexes;
> >>  struct mutex *hugetlb_fault_mutex_table ____cacheline_aligned_in_smp;
> >>
> >> +static inline bool PageHugeFreed(struct page *head)
> >> +{
> >> +    return (unsigned long)head[3].mapping == -1U;
> >> +}
> >> +
> >> +static inline void SetPageHugeFreed(struct page *head)
> >> +{
> >> +    head[3].mapping = (void *)-1U;
> >> +}
> >> +
> >> +static inline void ClearPageHugeFreed(struct page *head)
> >> +{
> >> +    head[3].mapping = NULL;
> >> +}
> >> +
> >>  /* Forward declaration */
> >>  static int hugetlb_acct_memory(struct hstate *h, long delta);
> >>
> >> @@ -1028,6 +1043,7 @@ static void enqueue_huge_page(struct hstate *h, struct page *page)
> >>      list_move(&page->lru, &h->hugepage_freelists[nid]);
> >>      h->free_huge_pages++;
> >>      h->free_huge_pages_node[nid]++;
> >> +    SetPageHugeFreed(page);
> >>  }
> >>
> >>  static struct page *dequeue_huge_page_node_exact(struct hstate *h, int nid)
> >> @@ -1044,6 +1060,7 @@ static struct page *dequeue_huge_page_node_exact(struct hstate *h, int nid)
> >>
> >>              list_move(&page->lru, &h->hugepage_activelist);
> >>              set_page_refcounted(page);
> >> +            ClearPageHugeFreed(page);
> >>              h->free_huge_pages--;
> >>              h->free_huge_pages_node[nid]--;
> >>              return page;
> >> @@ -1291,6 +1308,17 @@ static inline void destroy_compound_gigantic_page(struct page *page,
> >>                                              unsigned int order) { }
> >>  #endif
> >>
> >> +/*
> >> + * Because we reuse the mapping field of some tail page structs, we should
> >> + * reset those mapping to initial value before @head is freed to the buddy
> >> + * allocator. The invalid value will be checked in the free_tail_pages_check().
> >> + */
>
> When I suggested using head[3].mapping for this state, I was not aware of
> this requirement.  My suggestion was only following the convention used in
> PageHugeTemporary.  I would not have made the suggestion if I had realized
> this was required.  Sorry.

Yeah, PageHugeTemporary is lucky. free_tail_pages_check() not check
head[2].mapping.

I will revert to the previous version (using head[3].private). Thanks.

> --
> Mike Kravetz
>
> >> +static inline void reset_tail_page_mapping(struct hstate *h, struct page *head)
> >> +{
> >> +    if (!hstate_is_gigantic(h))
> >> +            head[3].mapping = TAIL_MAPPING;
> >> +}
> >> +
> >>  static void update_and_free_page(struct hstate *h, struct page *page)
> >>  {
> >>      int i;
> >> @@ -1298,6 +1326,7 @@ static void update_and_free_page(struct hstate *h, struct page *page)
> >>      if (hstate_is_gigantic(h) && !gigantic_page_runtime_supported())
> >>              return;
> >>
> >> +    reset_tail_page_mapping(h, page);
> >>      h->nr_huge_pages--;
> >>      h->nr_huge_pages_node[page_to_nid(page)]--;
> >>      for (i = 0; i < pages_per_huge_page(h); i++) {
> >> @@ -1504,6 +1533,7 @@ static void prep_new_huge_page(struct hstate *h, struct page *page, int nid)
> >>      spin_lock(&hugetlb_lock);
> >>      h->nr_huge_pages++;
> >>      h->nr_huge_pages_node[nid]++;
> >> +    ClearPageHugeFreed(page);
> >>      spin_unlock(&hugetlb_lock);
> >>  }
> >>
> >> @@ -1770,6 +1800,14 @@ int dissolve_free_huge_page(struct page *page)
> >>              int nid = page_to_nid(head);
> >>              if (h->free_huge_pages - h->resv_huge_pages == 0)
> >>                      goto out;
> >> +
> >> +            /*
> >> +             * We should make sure that the page is already on the free list
> >> +             * when it is dissolved.
> >> +             */
> >> +            if (unlikely(!PageHugeFreed(head)))
> >> +                    goto out;
> >> +
> >>              /*
> >>               * Move PageHWPoison flag from head page to the raw error page,
> >>               * which makes any subpages rather than the error page reusable.
> >> --
> >> 2.11.0
> >
