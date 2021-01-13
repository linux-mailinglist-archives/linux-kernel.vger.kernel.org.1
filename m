Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 572742F4872
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 11:20:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726238AbhAMKQQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 05:16:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725681AbhAMKQP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 05:16:15 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D77FAC061575
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 02:15:34 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id i5so1211559pgo.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 02:15:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rcaLsuqlhl7AUPdK1MZqrBVd9AgtDva3ByblrNRXVVQ=;
        b=QBthpibIbhXcNn0sING9h1ZwCyVuLKDCxT12fHrKn8pifxGsxaFYAvbHyPvl6qEdfz
         pFQzsPSd4EDq33qYmPxHQwnR4VMI6dzQQ62FjSmJpPogUXABQQN8Bjm4JtF534gmDh7k
         7RpU4Ln6XAiRj12yBYmtxTXmBIHCGu8yzsMkRx7HKIpq29DQjB+E0Ez7fJnMjqvB6N7v
         QWRVmwjr+ueQbdvJtoFqlgFN1c57T6roP8LRbc1RURwe48P4JrsYJWAauB+fBtfs4CL2
         boOFGKsbU2WT1a0q8+sWr1UH72TLZNF4wk1V7Jcp4x1CBYMTHpSleNUPqDlQiaYLZkhH
         fuwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rcaLsuqlhl7AUPdK1MZqrBVd9AgtDva3ByblrNRXVVQ=;
        b=tg/G5qvxm7exz33V0xHWFo+W6ZNPDYa+RwPq+QM8sbznrOHNryoNlsiPpuBxiPdhtU
         TDxADSTlcI0NIFrfPmFCGXQM0dzpqixI280bc35WhyHM1pa/uJcJWCNpX4x0UsPUeTjJ
         Wg2nCaNSaCWE8/midSK8qmP36PAd01KD+Ve15KS0B0ltwy+C789Oc5Ilg/iDgL31IQSf
         Pll/fESYbSgUnYNuG2fVYfjdea1GKemxIvR690xWJstYPVFeNHez1sFkRB9V12YL/BW7
         Wc/UI50TNvjfB7qQizR1DfTJhDK2wzhEct3wVvtMxLqPCl+YI2S2E/+lRm1C7PfG9t6E
         1JAA==
X-Gm-Message-State: AOAM5321NxMG/zc93BsicSo9QoBJ8mKl/77mHdBfvbwSBWZvFbeaDdvF
        E5CNqVUGY3yBlifQrjWRvPrUqYaY3Y0fiHbT6GClBw==
X-Google-Smtp-Source: ABdhPJyiYaQx1lHd114SOzLARU4DDZgoo6iWc/G7lrJC+z7xCIHbNZzFRzLYmo/YYcyr5zLYNJ83/U9UJIdsG47fBSI=
X-Received: by 2002:a63:50a:: with SMTP id 10mr1416399pgf.273.1610532934323;
 Wed, 13 Jan 2021 02:15:34 -0800 (PST)
MIME-Version: 1.0
References: <20210113052209.75531-1-songmuchun@bytedance.com>
 <20210113052209.75531-5-songmuchun@bytedance.com> <20210113093331.GV22493@dhcp22.suse.cz>
In-Reply-To: <20210113093331.GV22493@dhcp22.suse.cz>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Wed, 13 Jan 2021 18:14:55 +0800
Message-ID: <CAMZfGtUObSSyRZfv8CHucp6WmUZZBupKD9hbNHVpAv_PuWtMhw@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v4 4/6] mm: hugetlb: retry dissolve page
 when hitting race
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

On Wed, Jan 13, 2021 at 5:33 PM Michal Hocko <mhocko@suse.com> wrote:
>
> On Wed 13-01-21 13:22:07, Muchun Song wrote:
> > There is a race between dissolve_free_huge_page() and put_page().
> > Theoretically, we should return -EBUSY when we encounter this race.
> > In fact, we have a chance to successfully dissolve the page if we
> > do a retry. Because the race window is quite small. If we seize
> > this opportunity, it is an optimization for increasing the success
> > rate of dissolving page.
> >
> > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > ---
> >  mm/hugetlb.c | 20 ++++++++++++++++++--
> >  1 file changed, 18 insertions(+), 2 deletions(-)
> >
> > diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > index 4a9011e12175..898e4ea43e13 100644
> > --- a/mm/hugetlb.c
> > +++ b/mm/hugetlb.c
> > @@ -1772,6 +1772,7 @@ int dissolve_free_huge_page(struct page *page)
> >  {
> >       int rc = -EBUSY;
> >
> > +retry:
> >       /* Not to disrupt normal path by vainly holding hugetlb_lock */
> >       if (!PageHuge(page))
> >               return 0;
> > @@ -1793,8 +1794,23 @@ int dissolve_free_huge_page(struct page *page)
> >                * We should make sure that the page is already on the free list
> >                * when it is dissolved.
> >                */
> > -             if (unlikely(!PageHugeFreed(head)))
> > -                     goto out;
> > +             if (unlikely(!PageHugeFreed(head))) {
> > +                     spin_unlock(&hugetlb_lock);
> > +
> > +                     /*
> > +                      * Theoretically, we should return -EBUSY when we
> > +                      * encounter this race. In fact, we have a chance
> > +                      * to successfully dissolve the page if we do a
> > +                      * retry. Because the race window is quite small.
> > +                      * If we seize this opportunity, it is an optimization
> > +                      * for increasing the success rate of dissolving page.
> > +                      */
> > +                     while (PageHeadHuge(head) && !PageHugeFreed(head)) {
> > +                             cond_resched();
> > +                             cpu_relax();
> > +                     }
> > +                     goto retry;
>
> OK, so you have done the retry here. Please fold it into the previous
> patch. Also do we need cpu_relax on top of cond_resched as well?

Because the previous patch is a bugfix and should be backprt to the other
stable tree, right? I just want the fix patch to be small enough.
So I do the retry in this patch. If you do not agree with this. I
will fold this into the previous patch.

Do you mean this?

cpu_relax();
cond_resched();
cpu_relax();

If yes, IMHO, I don't think it is necessary.

>
> > +             }
> >
> >               /*
> >                * Move PageHWPoison flag from head page to the raw error page,
> > --
> > 2.11.0
>
> --
> Michal Hocko
> SUSE Labs
