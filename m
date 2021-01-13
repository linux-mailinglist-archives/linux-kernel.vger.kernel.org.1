Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB8E92F49C6
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 12:21:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728176AbhAMLM1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 06:12:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727052AbhAMLM0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 06:12:26 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31D6AC061795
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 03:11:46 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id md11so929519pjb.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 03:11:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2SLKDdrQFM+WKaMV48OG/N2sM0JT//xOlqtXb3zZwTM=;
        b=tTu7f6bnfxotrdB4JETUlesNGyB16DkTfyA/8UvHNfMq0QW9me+kof54gMELVaGeVI
         EbesI5FCIwQO1vCJUNw3KR2kGj6QALlS44wK/zibHCvF6+ELlBrZMe+1f0QB1W0fk1Ku
         BRD+3fMPFvd7jsFp7vwWvXQPlX1CUpXyWE10es/mBOC3pevgA54Nn0NpitnpxbnsE2cC
         OzWcCP+5qwwnBRnKGlmgTOkN6o2joxynqk1LfK0tBvFoN4fNTvhmKv+v++k68EkM+Gta
         CPkzEEPjRWJBlPGAt3rFnrROxpF/j8hzZqb0tO12mibE+HnDvBThhkXWS4AMaK+h5wGB
         qcdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2SLKDdrQFM+WKaMV48OG/N2sM0JT//xOlqtXb3zZwTM=;
        b=TGyHLa0BfvPOTwd1CAjVYeepklGFyS1axRl6Nsl5jRJU5VJjjyWQJA8lMdA74TKj9f
         fDUfK58CVYUfL93odCllCT6+hCXeZme7GKehhorUcvy7NElPQfR9N7dwJZKUT4LEO4oL
         05+XO54M+CROf5MO73wsmJ1rJ39RTgksPIgQsbwvLr8xA1kwsDV6jI2cka3kjxyQULEE
         vOLnP7iaZCIPYPuIMrSvGUVWQ0AnEAJbgsH1Heq5PKJ/uHQoC1iKVELAUfq3WjGGqCWQ
         lOevG9IK+/7bqg9TJuKpyPBY6Vdni6xPIVEF9JOH2SsJMhsR7OoTHlxsjRznYCtwDumM
         znsg==
X-Gm-Message-State: AOAM533V/IASfNel+2x4iIg1SQt9H1SwTtyVf0mEvVXh8vd7XeKgSxwZ
        9+szYwnp+BLwVRd7ja20GP7dyOGtJl7bTgY/eEBAXW7asb/8N9dDZHE=
X-Google-Smtp-Source: ABdhPJxEclREtaF8KMJhPc6n8HXvQMOJj+quJHpcDJGFXs+/Ww1SZjKGKbAzR42YPHfJhPnnuVgxOHBZgTZPbAO2bBk=
X-Received: by 2002:a17:90a:ba88:: with SMTP id t8mr1792739pjr.229.1610536305779;
 Wed, 13 Jan 2021 03:11:45 -0800 (PST)
MIME-Version: 1.0
References: <20210113052209.75531-1-songmuchun@bytedance.com>
 <20210113052209.75531-5-songmuchun@bytedance.com> <20210113093331.GV22493@dhcp22.suse.cz>
 <CAMZfGtUObSSyRZfv8CHucp6WmUZZBupKD9hbNHVpAv_PuWtMhw@mail.gmail.com> <20210113103836.GW22493@dhcp22.suse.cz>
In-Reply-To: <20210113103836.GW22493@dhcp22.suse.cz>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Wed, 13 Jan 2021 19:11:06 +0800
Message-ID: <CAMZfGtUTZZyL6Pdop-SHt2vs2hLuYfB9dumhRHBm7QLzyRNzZA@mail.gmail.com>
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

On Wed, Jan 13, 2021 at 6:38 PM Michal Hocko <mhocko@suse.com> wrote:
>
> On Wed 13-01-21 18:14:55, Muchun Song wrote:
> > On Wed, Jan 13, 2021 at 5:33 PM Michal Hocko <mhocko@suse.com> wrote:
> > >
> > > On Wed 13-01-21 13:22:07, Muchun Song wrote:
> > > > There is a race between dissolve_free_huge_page() and put_page().
> > > > Theoretically, we should return -EBUSY when we encounter this race.
> > > > In fact, we have a chance to successfully dissolve the page if we
> > > > do a retry. Because the race window is quite small. If we seize
> > > > this opportunity, it is an optimization for increasing the success
> > > > rate of dissolving page.
> > > >
> > > > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > > > ---
> > > >  mm/hugetlb.c | 20 ++++++++++++++++++--
> > > >  1 file changed, 18 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > > > index 4a9011e12175..898e4ea43e13 100644
> > > > --- a/mm/hugetlb.c
> > > > +++ b/mm/hugetlb.c
> > > > @@ -1772,6 +1772,7 @@ int dissolve_free_huge_page(struct page *page)
> > > >  {
> > > >       int rc = -EBUSY;
> > > >
> > > > +retry:
> > > >       /* Not to disrupt normal path by vainly holding hugetlb_lock */
> > > >       if (!PageHuge(page))
> > > >               return 0;
> > > > @@ -1793,8 +1794,23 @@ int dissolve_free_huge_page(struct page *page)
> > > >                * We should make sure that the page is already on the free list
> > > >                * when it is dissolved.
> > > >                */
> > > > -             if (unlikely(!PageHugeFreed(head)))
> > > > -                     goto out;
> > > > +             if (unlikely(!PageHugeFreed(head))) {
> > > > +                     spin_unlock(&hugetlb_lock);
> > > > +
> > > > +                     /*
> > > > +                      * Theoretically, we should return -EBUSY when we
> > > > +                      * encounter this race. In fact, we have a chance
> > > > +                      * to successfully dissolve the page if we do a
> > > > +                      * retry. Because the race window is quite small.
> > > > +                      * If we seize this opportunity, it is an optimization
> > > > +                      * for increasing the success rate of dissolving page.
> > > > +                      */
> > > > +                     while (PageHeadHuge(head) && !PageHugeFreed(head)) {
> > > > +                             cond_resched();
> > > > +                             cpu_relax();
> > > > +                     }
> > > > +                     goto retry;
> > >
> > > OK, so you have done the retry here. Please fold it into the previous
> > > patch. Also do we need cpu_relax on top of cond_resched as well?
> >
> > Because the previous patch is a bugfix and should be backprt to the other
> > stable tree, right?
>
> Yes, it is a bugfix but it arguably opens another issue so the follow up
> patch should better be applied along with it.

OK. I will fold this one into the previous one. Thanks.

>
> > I just want the fix patch to be small enough.
> > So I do the retry in this patch. If you do not agree with this. I
> > will fold this into the previous patch.
> >
> > Do you mean this?
> >
> > cpu_relax();
> > cond_resched();
> > cpu_relax();
>
> No, I am questiong the use of cpu_relax. What is the point?

If there is no task to be scheduled. Here is just a while loop.
The cpu_relax is a good thing to insert into busy-wait loops,
right?


>
> --
> Michal Hocko
> SUSE Labs
