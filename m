Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12FD22F48D3
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 11:41:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727611AbhAMKj1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 05:39:27 -0500
Received: from mx2.suse.de ([195.135.220.15]:35050 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727557AbhAMKj0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 05:39:26 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1610534319; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=L9WjQjeV/bLcwajRiCZA3UtPCYTm19xe+pqGl6o2F8c=;
        b=hSHguEU6fg658n4LF4FN7DjB0xPVe4GXgD9RYR9OxVcqKqevW2N5oT1y4wzCYVmm3KZrCU
        raxhsLdMKEgykt79BYTHK9QQ1OY2Sdk832B0Hq/X0Uw3mOXPMb72+fiOXtm5545TJ3kFNQ
        NRpq3wbh86YRYGbT+4IccWex8PGlXdM=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id DEF0FAC5B;
        Wed, 13 Jan 2021 10:38:38 +0000 (UTC)
Date:   Wed, 13 Jan 2021 11:38:36 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Andi Kleen <ak@linux.intel.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [External] Re: [PATCH v4 4/6] mm: hugetlb: retry dissolve page
 when hitting race
Message-ID: <20210113103836.GW22493@dhcp22.suse.cz>
References: <20210113052209.75531-1-songmuchun@bytedance.com>
 <20210113052209.75531-5-songmuchun@bytedance.com>
 <20210113093331.GV22493@dhcp22.suse.cz>
 <CAMZfGtUObSSyRZfv8CHucp6WmUZZBupKD9hbNHVpAv_PuWtMhw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMZfGtUObSSyRZfv8CHucp6WmUZZBupKD9hbNHVpAv_PuWtMhw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 13-01-21 18:14:55, Muchun Song wrote:
> On Wed, Jan 13, 2021 at 5:33 PM Michal Hocko <mhocko@suse.com> wrote:
> >
> > On Wed 13-01-21 13:22:07, Muchun Song wrote:
> > > There is a race between dissolve_free_huge_page() and put_page().
> > > Theoretically, we should return -EBUSY when we encounter this race.
> > > In fact, we have a chance to successfully dissolve the page if we
> > > do a retry. Because the race window is quite small. If we seize
> > > this opportunity, it is an optimization for increasing the success
> > > rate of dissolving page.
> > >
> > > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > > ---
> > >  mm/hugetlb.c | 20 ++++++++++++++++++--
> > >  1 file changed, 18 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > > index 4a9011e12175..898e4ea43e13 100644
> > > --- a/mm/hugetlb.c
> > > +++ b/mm/hugetlb.c
> > > @@ -1772,6 +1772,7 @@ int dissolve_free_huge_page(struct page *page)
> > >  {
> > >       int rc = -EBUSY;
> > >
> > > +retry:
> > >       /* Not to disrupt normal path by vainly holding hugetlb_lock */
> > >       if (!PageHuge(page))
> > >               return 0;
> > > @@ -1793,8 +1794,23 @@ int dissolve_free_huge_page(struct page *page)
> > >                * We should make sure that the page is already on the free list
> > >                * when it is dissolved.
> > >                */
> > > -             if (unlikely(!PageHugeFreed(head)))
> > > -                     goto out;
> > > +             if (unlikely(!PageHugeFreed(head))) {
> > > +                     spin_unlock(&hugetlb_lock);
> > > +
> > > +                     /*
> > > +                      * Theoretically, we should return -EBUSY when we
> > > +                      * encounter this race. In fact, we have a chance
> > > +                      * to successfully dissolve the page if we do a
> > > +                      * retry. Because the race window is quite small.
> > > +                      * If we seize this opportunity, it is an optimization
> > > +                      * for increasing the success rate of dissolving page.
> > > +                      */
> > > +                     while (PageHeadHuge(head) && !PageHugeFreed(head)) {
> > > +                             cond_resched();
> > > +                             cpu_relax();
> > > +                     }
> > > +                     goto retry;
> >
> > OK, so you have done the retry here. Please fold it into the previous
> > patch. Also do we need cpu_relax on top of cond_resched as well?
> 
> Because the previous patch is a bugfix and should be backprt to the other
> stable tree, right?

Yes, it is a bugfix but it arguably opens another issue so the follow up
patch should better be applied along with it.

> I just want the fix patch to be small enough.
> So I do the retry in this patch. If you do not agree with this. I
> will fold this into the previous patch.
> 
> Do you mean this?
> 
> cpu_relax();
> cond_resched();
> cpu_relax();

No, I am questiong the use of cpu_relax. What is the point?

-- 
Michal Hocko
SUSE Labs
