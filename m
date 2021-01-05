Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 781A52EA40B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 04:50:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728294AbhAEDsL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 22:48:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726168AbhAEDsL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 22:48:11 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D349AC061574
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jan 2021 19:47:30 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id b5so917145pjl.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jan 2021 19:47:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=R6VBjqcK5YLZ5deMeqMm/AgkrrOL5bx12zvyrtcYvt8=;
        b=zvrg0g37kYpekFpHzLswoui8ovwcJGCeMJ0giV3ONJTxaEWTlz3OM7ncuumobeYx7y
         UNHcSxUmzThAZrUk2KUaMe1WLxtH9ab4j772D6wYNU2l3nQ8OCgqU3yavW7PrriYyK3z
         fQcIpEQh1munE0iiKCuBZu4Py0iM5kkqAoQNJTyrzGEHIL9ybMU5TMukupp6yQ14C9NA
         /x7zeMMd0ma90NGVQKdMTl90wF9VkyWz513nR2emqWoZmWRPKZyVNg0dQgkOHy2OkLAP
         SqYS0VopNy94c1MIibYggwMA0avL0WEPWEsj781DB18Blig+mVZ1NuQQyaTSuXrP1F78
         s2VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R6VBjqcK5YLZ5deMeqMm/AgkrrOL5bx12zvyrtcYvt8=;
        b=iBiJHFF+u+Rs8mrPPZLYVS47E8nJ9CeOd8SHV7P28kj6Fc6OkaM7LM/lYglfxsrp+3
         /bB54n+EwBSZOsWtTY2srI8deSOZhIyz8hmIK0FolCsAIbabIySSa+LEoxisddVi9Lvc
         gz4UHX7ZJCvZ4aNqugZMUZ3qy6dURBu241oAHcg1Dj7Txhjhf8EB3PYTDnOro5EckCf+
         aR6LRxUeBwegnkcA9wW70QQx2186Mhfn0F3sHDIdV+CeCZ7wVoD6RF6jxp+EEaJ/FNm2
         n9N2GjtZjnERgxw9g3k/ihM7ipUnvSVimkHhEQ8NuV4ZAfJAFH0SfnKaCHOb0CxADf2q
         NPvA==
X-Gm-Message-State: AOAM5322dT6R/twaqwX+3Ex3ZH+WEHUyL2IFDqTuoXIltuetqb1jUj6b
        449KvKCux23VQ/lCJSa8bMFRmN/5IN7hYICnR+Qbow==
X-Google-Smtp-Source: ABdhPJybN/E/OaP+FLb4Fj1fxoISneSpVEx88JYdCzoMgKviF1z6kKZ8+17Ucm+6/BUwqg3Ft6T65hGLpA5K+XDZ6hQ=
X-Received: by 2002:a17:90a:c588:: with SMTP id l8mr2061839pjt.147.1609818450281;
 Mon, 04 Jan 2021 19:47:30 -0800 (PST)
MIME-Version: 1.0
References: <20210104065843.5658-1-songmuchun@bytedance.com>
 <20210104065843.5658-4-songmuchun@bytedance.com> <e043e137-5ca7-d478-248c-9defcecc6ac7@oracle.com>
 <CAMZfGtXZqbNwb2k5sq29gXSBMO3sVNaATiJnPWSggoAG5mZMqA@mail.gmail.com>
In-Reply-To: <CAMZfGtXZqbNwb2k5sq29gXSBMO3sVNaATiJnPWSggoAG5mZMqA@mail.gmail.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Tue, 5 Jan 2021 11:46:51 +0800
Message-ID: <CAMZfGtVU5WfEWbin5hxAkkWLVJw15n2crtPMkmHDRxkBo4_TOQ@mail.gmail.com>
Subject: Re: [External] Re: [PATCH 4/6] mm: hugetlb: add return -EAGAIN for dissolve_free_huge_page
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

On Tue, Jan 5, 2021 at 11:14 AM Muchun Song <songmuchun@bytedance.com> wrote:
>
> On Tue, Jan 5, 2021 at 9:33 AM Mike Kravetz <mike.kravetz@oracle.com> wrote:
> >
> > On 1/3/21 10:58 PM, Muchun Song wrote:
> > > When dissolve_free_huge_page() races with __free_huge_page(), we can
> > > do a retry. Because the race window is small.
> >
> > In general, I agree that the race window is small.  However, worst case
> > would be if the freeing of the page is put on a work queue.  Is it acceptable
> > to keep retrying in that case?  In addition, the 'Free some vmemmap' series
> > may slow the free_huge_page path even more.
>
> I also consider the 'Free some vmemmap' series case. In my next
> version series, I will flush the work before dissolve_free_huge_page
> returns when encountering this race. So the retry is acceptable.
> Right?

Hi Mike,

How about flushing the @free_hpage_work when
encountering this race?

>
> Thanks.
>
> >
> > In these worst case scenarios, I am not sure we want to just spin retrying.
> >
> > --
> > Mike Kravetz
> >
> > >
> > > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > > ---
> > >  mm/hugetlb.c | 16 +++++++++++-----
> > >  1 file changed, 11 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > > index 72608008f8b4..db00ae375d2a 100644
> > > --- a/mm/hugetlb.c
> > > +++ b/mm/hugetlb.c
> > > @@ -1763,10 +1763,11 @@ static int free_pool_huge_page(struct hstate *h, nodemask_t *nodes_allowed,
> > >   * nothing for in-use hugepages and non-hugepages.
> > >   * This function returns values like below:
> > >   *
> > > - *  -EBUSY: failed to dissolved free hugepages or the hugepage is in-use
> > > - *          (allocated or reserved.)
> > > - *       0: successfully dissolved free hugepages or the page is not a
> > > - *          hugepage (considered as already dissolved)
> > > + *  -EAGAIN: race with __free_huge_page() and can do a retry
> > > + *  -EBUSY:  failed to dissolved free hugepages or the hugepage is in-use
> > > + *           (allocated or reserved.)
> > > + *       0:  successfully dissolved free hugepages or the page is not a
> > > + *           hugepage (considered as already dissolved)
> > >   */
> > >  int dissolve_free_huge_page(struct page *page)
> > >  {
> > > @@ -1815,8 +1816,10 @@ int dissolve_free_huge_page(struct page *page)
> > >                * We should make sure that the page is already on the free list
> > >                * when it is dissolved.
> > >                */
> > > -             if (unlikely(!PageHugeFreed(head)))
> > > +             if (unlikely(!PageHugeFreed(head))) {
> > > +                     rc = -EAGAIN;
> > >                       goto out;
> > > +             }
> > >
> > >               /*
> > >                * Move PageHWPoison flag from head page to the raw error page,
> > > @@ -1857,7 +1860,10 @@ int dissolve_free_huge_pages(unsigned long start_pfn, unsigned long end_pfn)
> > >
> > >       for (pfn = start_pfn; pfn < end_pfn; pfn += 1 << minimum_order) {
> > >               page = pfn_to_page(pfn);
> > > +retry:
> > >               rc = dissolve_free_huge_page(page);
> > > +             if (rc == -EAGAIN)
> > > +                     goto retry;
> > >               if (rc)
> > >                       break;
> > >       }
> > >
