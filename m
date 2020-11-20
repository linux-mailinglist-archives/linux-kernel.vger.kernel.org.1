Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52BDF2BA781
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 11:36:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727300AbgKTKdS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 05:33:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726826AbgKTKdR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 05:33:17 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5906EC061A04
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 02:33:17 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id v5so3407572pff.10
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 02:33:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UsS6BwELHQFBs6wYocFk33SI0hNJVApsWPqjjwO0pIg=;
        b=MXukd6hdqebfCVmvaC32gdmcgYyA7hCeC+66VEc/xj+GYVdeI7SmMc9yfOaKn2grMJ
         QSI0j4cqgRutOMouMjuv4tGNmiOJ+NUw9s391xQJJqjs5P9XVGISyx2680WhGChty4Xc
         ORvQzynmtkhN0WHynNb2WJFv1f/mSDSjsRYrwNdU2/NrwpocFeTfrxh8IpylO5uZF2HB
         QiQBcvmmJFIAbUATdSXgNh0A+BMqBCcesIh7ZQCDkwzb4+gCiYuXPDcIrHZAFE2Yr6UV
         w5gsqc6JxQ3N7NzWfLDuD+VTwZUTnUKW9DLkgD6wZUv0ElJ9HX3frAWbb1Mgqgie6pgi
         56hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UsS6BwELHQFBs6wYocFk33SI0hNJVApsWPqjjwO0pIg=;
        b=FiHqvgCW2u9Llc9FfnokTFCovde6v0yqz3hCRreWfLoz0wPxRqCb3U/ZtPTdu5wph8
         5ukMjx1GPm+rFyEpPp/+xqPUekf3nRht3y6d9NPNaR1tGl3ycnq5AkDgU/pRe5BJbmgh
         ryrA6fSL9gqrV+d5euTttV0rdkxLpH/VMQZrB6GLVB7A2+o+GfX24+ITtfC6uOJf0UOh
         UXgGJjCbovSSID2L8gjqzOq6eGUVdm1KafQP6DBpeoMT+MTmF1B6Bx0Zbtg39sQLJc+V
         tRAANg3UwLrLyMQClPYxlVWAQ5gpE2+l8wHTe2O3DqFZiUiHArLXzMYu98tKpIpMRDo9
         XIWA==
X-Gm-Message-State: AOAM530H1GxaTx4SKuDiNBw2z0utYXvljIKZGvGhHOtjFsdIKkg3QHTw
        MPl4Hx4aFhGTCv8yQ+whjnHT7A9R9Sfymx8yKCG+cQ==
X-Google-Smtp-Source: ABdhPJxfv45R/dS1L8+h3jIhMzMxG7gkHNSADvlzeP3zS+xAY8Bn0OgWgJ4R3njDshhjg8x0srlDY4mieIZF69vDhdc=
X-Received: by 2002:a17:90b:941:: with SMTP id dw1mr9467911pjb.147.1605868396746;
 Fri, 20 Nov 2020 02:33:16 -0800 (PST)
MIME-Version: 1.0
References: <20201120064325.34492-1-songmuchun@bytedance.com>
 <20201120064325.34492-16-songmuchun@bytedance.com> <20201120081940.GE3200@dhcp22.suse.cz>
In-Reply-To: <20201120081940.GE3200@dhcp22.suse.cz>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Fri, 20 Nov 2020 18:32:34 +0800
Message-ID: <CAMZfGtUZJ2dCtVa67X9ackjbxVVJSn=7Y4DtUJzG4yNghDnNCQ@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v5 15/21] mm/hugetlb: Set the PageHWPoison
 to the raw error page
To:     Michal Hocko <mhocko@suse.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org,
        Peter Zijlstra <peterz@infradead.org>, viro@zeniv.linux.org.uk,
        Andrew Morton <akpm@linux-foundation.org>, paulmck@kernel.org,
        mchehab+huawei@kernel.org, pawan.kumar.gupta@linux.intel.com,
        Randy Dunlap <rdunlap@infradead.org>, oneukum@suse.com,
        anshuman.khandual@arm.com, jroedel@suse.de,
        Mina Almasry <almasrymina@google.com>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Oscar Salvador <osalvador@suse.de>,
        "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 20, 2020 at 4:19 PM Michal Hocko <mhocko@suse.com> wrote:
>
> On Fri 20-11-20 14:43:19, Muchun Song wrote:
> > Because we reuse the first tail page, if we set PageHWPosion on a
> > tail page. It indicates that we may set PageHWPoison on a series
> > of pages. So we can use the head[4].mapping to record the real
> > error page index and set the raw error page PageHWPoison later.
>
> This really begs more explanation. Maybe I misremember but If there
> is a HWPoison hole in a hugepage then the whole page is demolished, no?
> If that is the case then why do we care about tail pages?

It seems like that I should make the commit log more clear. If there is
a HWPoison hole in a HugeTLB, we should dissolve the HugeTLB page.
It means that we set the HWPoison on the raw error page(not the head
page) and free the HugeTLB to the buddy allocator. Then we will remove
only one HWPoison page from the buddy free list. You can see the
take_page_off_buddy() for more details. Thanks.

>
> > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > ---
> >  mm/hugetlb.c         | 11 +++--------
> >  mm/hugetlb_vmemmap.h | 39 +++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 42 insertions(+), 8 deletions(-)
> >
> > diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > index 055604d07046..b853aacd5c16 100644
> > --- a/mm/hugetlb.c
> > +++ b/mm/hugetlb.c
> > @@ -1383,6 +1383,7 @@ static void __free_hugepage(struct hstate *h, struct page *page)
> >       int i;
> >
> >       alloc_huge_page_vmemmap(h, page);
> > +     subpage_hwpoison_deliver(page);
> >
> >       for (i = 0; i < pages_per_huge_page(h); i++) {
> >               page[i].flags &= ~(1 << PG_locked | 1 << PG_error |
> > @@ -1944,14 +1945,8 @@ int dissolve_free_huge_page(struct page *page)
> >               int nid = page_to_nid(head);
> >               if (h->free_huge_pages - h->resv_huge_pages == 0)
> >                       goto out;
> > -             /*
> > -              * Move PageHWPoison flag from head page to the raw error page,
> > -              * which makes any subpages rather than the error page reusable.
> > -              */
> > -             if (PageHWPoison(head) && page != head) {
> > -                     SetPageHWPoison(page);
> > -                     ClearPageHWPoison(head);
> > -             }
> > +
> > +             set_subpage_hwpoison(head, page);
> >               list_del(&head->lru);
> >               h->free_huge_pages--;
> >               h->free_huge_pages_node[nid]--;
> > diff --git a/mm/hugetlb_vmemmap.h b/mm/hugetlb_vmemmap.h
> > index 779d3cb9333f..65e94436ffff 100644
> > --- a/mm/hugetlb_vmemmap.h
> > +++ b/mm/hugetlb_vmemmap.h
> > @@ -20,6 +20,29 @@ void __init gather_vmemmap_pgtable_init(struct huge_bootmem_page *m,
> >  void alloc_huge_page_vmemmap(struct hstate *h, struct page *head);
> >  void free_huge_page_vmemmap(struct hstate *h, struct page *head);
> >
> > +static inline void subpage_hwpoison_deliver(struct page *head)
> > +{
> > +     struct page *page = head;
> > +
> > +     if (PageHWPoison(head))
> > +             page = head + page_private(head + 4);
> > +
> > +     /*
> > +      * Move PageHWPoison flag from head page to the raw error page,
> > +      * which makes any subpages rather than the error page reusable.
> > +      */
> > +     if (page != head) {
> > +             SetPageHWPoison(page);
> > +             ClearPageHWPoison(head);
> > +     }
> > +}
> > +
> > +static inline void set_subpage_hwpoison(struct page *head, struct page *page)
> > +{
> > +     if (PageHWPoison(head))
> > +             set_page_private(head + 4, page - head);
> > +}
> > +
> >  static inline unsigned int free_vmemmap_pages_per_hpage(struct hstate *h)
> >  {
> >       return h->nr_free_vmemmap_pages;
> > @@ -56,6 +79,22 @@ static inline void free_huge_page_vmemmap(struct hstate *h, struct page *head)
> >  {
> >  }
> >
> > +static inline void subpage_hwpoison_deliver(struct page *head)
> > +{
> > +}
> > +
> > +static inline void set_subpage_hwpoison(struct page *head, struct page *page)
> > +{
> > +     /*
> > +      * Move PageHWPoison flag from head page to the raw error page,
> > +      * which makes any subpages rather than the error page reusable.
> > +      */
> > +     if (PageHWPoison(head) && page != head) {
> > +             SetPageHWPoison(page);
> > +             ClearPageHWPoison(head);
> > +     }
> > +}
> > +
> >  static inline unsigned int free_vmemmap_pages_per_hpage(struct hstate *h)
> >  {
> >       return 0;
> > --
> > 2.11.0
> >
>
> --
> Michal Hocko
> SUSE Labs



-- 
Yours,
Muchun
