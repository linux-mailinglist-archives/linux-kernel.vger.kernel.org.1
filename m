Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B92E62D0AFE
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 08:15:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726067AbgLGHO0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 02:14:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726000AbgLGHO0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 02:14:26 -0500
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA1E2C0613D0
        for <linux-kernel@vger.kernel.org>; Sun,  6 Dec 2020 23:13:45 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id q3so8157914pgr.3
        for <linux-kernel@vger.kernel.org>; Sun, 06 Dec 2020 23:13:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BuegduoTe+wHssZKdFwfVQK5dfW32mpobttg/54Oqek=;
        b=mhicnEpi95O1H2zQf5C0nreui1P+urNU/iK8Ol2V1uqv1Aha5N5eXnKw45YJWDtQ+q
         J81nhhHRUaF82tOGP1bTTd2tSTqg5qx85qVeo9Ed/MZyUjq91IDIw/5gm5hDb1wF64U7
         cZK/PZD/AiB43FcuElQN5IUha0Mb3QqG7lpAxiaZ1W6kPSsAXoyqXgztvJ7zm+7KdQiW
         4sAoSt1XN9PAcTxrQNTS0j+sOnXjR4XTx51BzllD/6YyDRGqYRE0lvXDgDNBJCuyxjhr
         RXAjuO0MnOWS7zlJSVdwiA2UV/yMrJdcLMDm/saLaoSMlJNK86GiL+xs2sYzhh50ChMH
         c1PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BuegduoTe+wHssZKdFwfVQK5dfW32mpobttg/54Oqek=;
        b=CbuMQi97cSaU/29sYZzayXFbdPx3cJoCZqveoqj1n4va6kFpyEjR5IygSbvpSYkZcL
         Gbu4QdEPuXw/QhCIaG0ZxecX6ZpFGCrUBzxvJ8SW1XC9deKnWXkN5IHYh1GZsnvz8zCU
         NN4cZupjbMI9qVl36XxNjDNqld9pQFMytyRUHtvs9wzKJVo876EWr3z/x3Cjfmbb0CbO
         4GwjfnWGG4gVaKYIfzGFabwN8TRVM+p7GPwIWliJnFkDj8Tfc6SOrl0YjdrQfXGG+mik
         oMogFPtmorX/QpTbWnKw+RxHMFURZKCpFA9gUyiNjymujWAAPk/aL7fEZceM6Sd9vxXT
         bDJg==
X-Gm-Message-State: AOAM533pGFKKSvO4to3W8kXylBz1rREiZzsqzyQFfpM3SnsbET7XcLhn
        6O7XFhrNqx5UaBMMvm8wMyI=
X-Google-Smtp-Source: ABdhPJz/bGRqAzP5r8jUuS0kn9Z+fns/7WZqTFsQ7vcaiX3eb8T1xo1vZmsfbn/lpC4itT+CYDdscw==
X-Received: by 2002:a63:1d26:: with SMTP id d38mr17164270pgd.246.1607325225494;
        Sun, 06 Dec 2020 23:13:45 -0800 (PST)
Received: from js1304-desktop ([114.206.198.176])
        by smtp.gmail.com with ESMTPSA id z25sm11065754pge.66.2020.12.06.23.13.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 06 Dec 2020 23:13:45 -0800 (PST)
Date:   Mon, 7 Dec 2020 16:13:36 +0900
From:   Joonsoo Kim <js1304@gmail.com>
To:     Pavel Tatashin <pasha.tatashin@soleen.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Sasha Levin <sashal@kernel.org>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        mike.kravetz@oracle.com, Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Matthew Wilcox <willy@infradead.org>,
        David Rientjes <rientjes@google.com>,
        John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH 6/6] mm/gup: migrate pinned pages out of movable zone
Message-ID: <20201207071335.GB10731@js1304-desktop>
References: <20201202052330.474592-1-pasha.tatashin@soleen.com>
 <20201202052330.474592-7-pasha.tatashin@soleen.com>
 <20201204041358.GB17056@js1304-desktop>
 <CA+CK2bDtmeyMgd7gkdbb+0hfm5rSow-Lc+FOrZM3tUZAOR+FRw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+CK2bDtmeyMgd7gkdbb+0hfm5rSow-Lc+FOrZM3tUZAOR+FRw@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 04, 2020 at 12:43:29PM -0500, Pavel Tatashin wrote:
> On Thu, Dec 3, 2020 at 11:14 PM Joonsoo Kim <js1304@gmail.com> wrote:
> >
> > On Wed, Dec 02, 2020 at 12:23:30AM -0500, Pavel Tatashin wrote:
> > > We do not allocate pin pages in ZONE_MOVABLE, but if pages were already
> > > allocated before pinning they need to migrated to a different zone.
> > > Currently, we migrate movable CMA pages only. Generalize the function
> > > that migrates CMA pages to migrate all movable pages.
> > >
> > > Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
> > > ---
> > >  include/linux/migrate.h        |  1 +
> > >  include/trace/events/migrate.h |  3 +-
> > >  mm/gup.c                       | 56 +++++++++++++---------------------
> > >  3 files changed, 24 insertions(+), 36 deletions(-)
> > >
> > > diff --git a/include/linux/migrate.h b/include/linux/migrate.h
> > > index 0f8d1583fa8e..00bab23d1ee5 100644
> > > --- a/include/linux/migrate.h
> > > +++ b/include/linux/migrate.h
> > > @@ -27,6 +27,7 @@ enum migrate_reason {
> > >       MR_MEMPOLICY_MBIND,
> > >       MR_NUMA_MISPLACED,
> > >       MR_CONTIG_RANGE,
> > > +     MR_LONGTERM_PIN,
> > >       MR_TYPES
> > >  };
> > >
> > > diff --git a/include/trace/events/migrate.h b/include/trace/events/migrate.h
> > > index 4d434398d64d..363b54ce104c 100644
> > > --- a/include/trace/events/migrate.h
> > > +++ b/include/trace/events/migrate.h
> > > @@ -20,7 +20,8 @@
> > >       EM( MR_SYSCALL,         "syscall_or_cpuset")            \
> > >       EM( MR_MEMPOLICY_MBIND, "mempolicy_mbind")              \
> > >       EM( MR_NUMA_MISPLACED,  "numa_misplaced")               \
> > > -     EMe(MR_CONTIG_RANGE,    "contig_range")
> > > +     EM( MR_CONTIG_RANGE,    "contig_range")                 \
> > > +     EMe(MR_LONGTERM_PIN,    "longterm_pin")
> > >
> > >  /*
> > >   * First define the enums in the above macros to be exported to userspace
> > > diff --git a/mm/gup.c b/mm/gup.c
> > > index 724d8a65e1df..1d511f65f8a7 100644
> > > --- a/mm/gup.c
> > > +++ b/mm/gup.c
> > > @@ -1593,19 +1593,18 @@ static bool check_dax_vmas(struct vm_area_struct **vmas, long nr_pages)
> > >  }
> > >  #endif
> > >
> > > -#ifdef CONFIG_CMA
> > > -static long check_and_migrate_cma_pages(struct mm_struct *mm,
> > > -                                     unsigned long start,
> > > -                                     unsigned long nr_pages,
> > > -                                     struct page **pages,
> > > -                                     struct vm_area_struct **vmas,
> > > -                                     unsigned int gup_flags)
> > > +static long check_and_migrate_movable_pages(struct mm_struct *mm,
> > > +                                         unsigned long start,
> > > +                                         unsigned long nr_pages,
> > > +                                         struct page **pages,
> > > +                                         struct vm_area_struct **vmas,
> > > +                                         unsigned int gup_flags)
> > >  {
> > >       unsigned long i;
> > >       unsigned long step;
> > >       bool drain_allow = true;
> > >       bool migrate_allow = true;
> > > -     LIST_HEAD(cma_page_list);
> > > +     LIST_HEAD(page_list);
> > >       long ret = nr_pages;
> > >       struct migration_target_control mtc = {
> > >               .nid = NUMA_NO_NODE,
> > > @@ -1623,13 +1622,12 @@ static long check_and_migrate_cma_pages(struct mm_struct *mm,
> > >                */
> > >               step = compound_nr(head) - (pages[i] - head);
> > >               /*
> > > -              * If we get a page from the CMA zone, since we are going to
> > > -              * be pinning these entries, we might as well move them out
> > > -              * of the CMA zone if possible.
> > > +              * If we get a movable page, since we are going to be pinning
> > > +              * these entries, try to move them out if possible.
> > >                */
> > > -             if (is_migrate_cma_page(head)) {
> > > +             if (is_migrate_movable(get_pageblock_migratetype(head))) {
> >
> > is_migrate_movable() isn't a check for the ZONE. It's a check for the
> > MIGRATE_TYPE. MIGRATE_TYPE doesn't require hard guarantee for
> > migration, and, most of memory, including ZONE_NORMAL, is
> > MIGRATE_MOVABLE. With this code, long term gup would always fails due
> > to not enough memory. I think that correct change would be
> > "is_migrate_cma_page(hear) && zone == ZONE_MOVABLE".
> 
> Good point. The above should be OR not AND.
> 
> zone_idx(page_zone(head)) == ZONE_MOVABLE || is_migrate_cma_page(hear)

Yep!

Thanks.
