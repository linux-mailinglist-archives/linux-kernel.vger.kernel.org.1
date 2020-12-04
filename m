Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E21D2CEA0B
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 09:44:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728504AbgLDIoA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 03:44:00 -0500
Received: from mx2.suse.de ([195.135.220.15]:46310 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727069AbgLDIoA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 03:44:00 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1607071393; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HI67x8wgUuRFJMifoHJdppXQZOBKg1Z9h2SXs1njUEc=;
        b=eMt0MtPCcV8zg51XvfnNsUBBpaPQY1Cac0pEeEOMAhTUo8fE76lubPSFtm8EheCEwwA7kG
        ll3halDFdD4E5Rs0JeBg9m+8kDWOuQFy00fv/+o/ryn43GFq5gh0KHqmlAvv14orbkIcLA
        CNfESr+NlLyNV4JCKkhlWuKeWYU5Knc=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 517E6ACC3;
        Fri,  4 Dec 2020 08:43:13 +0000 (UTC)
Date:   Fri, 4 Dec 2020 09:43:12 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Pavel Tatashin <pasha.tatashin@soleen.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Sasha Levin <sashal@kernel.org>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, mike.kravetz@oracle.com,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Matthew Wilcox <willy@infradead.org>,
        David Rientjes <rientjes@google.com>,
        John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH 5/6] mm: honor PF_MEMALLOC_NOMOVABLE for all allocations
Message-ID: <20201204084312.GA25569@dhcp22.suse.cz>
References: <20201202052330.474592-1-pasha.tatashin@soleen.com>
 <20201202052330.474592-6-pasha.tatashin@soleen.com>
 <20201203091703.GA17338@dhcp22.suse.cz>
 <CA+CK2bB-BC-5Szs1Piv3O=OGxQbJSGWzgMmDUtDewrCqEoNaXw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+CK2bB-BC-5Szs1Piv3O=OGxQbJSGWzgMmDUtDewrCqEoNaXw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 03-12-20 10:15:41, Pavel Tatashin wrote:
> On Thu, Dec 3, 2020 at 4:17 AM Michal Hocko <mhocko@suse.com> wrote:
> >
> > On Wed 02-12-20 00:23:29, Pavel Tatashin wrote:
> > [...]
> > > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > > index 611799c72da5..7a6d86d0bc5f 100644
> > > --- a/mm/page_alloc.c
> > > +++ b/mm/page_alloc.c
> > > @@ -3766,20 +3766,25 @@ alloc_flags_nofragment(struct zone *zone, gfp_t gfp_mask)
> > >       return alloc_flags;
> > >  }
> > >
> > > -static inline unsigned int current_alloc_flags(gfp_t gfp_mask,
> > > -                                     unsigned int alloc_flags)
> > > +static inline unsigned int cma_alloc_flags(gfp_t gfp_mask,
> > > +                                        unsigned int alloc_flags)
> > >  {
> > >  #ifdef CONFIG_CMA
> > > -     unsigned int pflags = current->flags;
> > > -
> > > -     if (!(pflags & PF_MEMALLOC_NOMOVABLE) &&
> > > -         gfp_migratetype(gfp_mask) == MIGRATE_MOVABLE)
> > > +     if (gfp_migratetype(gfp_mask) == MIGRATE_MOVABLE)
> > >               alloc_flags |= ALLOC_CMA;
> > > -
> > >  #endif
> > >       return alloc_flags;
> > >  }
> > >
> > > +static inline gfp_t current_gfp_checkmovable(gfp_t gfp_mask)
> > > +{
> > > +     unsigned int pflags = current->flags;
> > > +
> > > +     if ((pflags & PF_MEMALLOC_NOMOVABLE))
> > > +             return gfp_mask & ~__GFP_MOVABLE;
> > > +     return gfp_mask;
> > > +}
> > > +
> >
> > It sucks that we have to control both ALLOC and gfp flags. But wouldn't
> > it be simpler and more straightforward to keep current_alloc_flags as is
> > (module PF rename) and hook the gfp mask evaluation into current_gfp_context
> > and move it up before the first allocation attempt?
> 
> We could do that, but perhaps as a separate patch? I am worried about
> hidden implication of adding extra scope (GFP_NOIO|GFP_NOFS) to the
> fast path.

Why?

> Also, current_gfp_context() is used elsewhere, and in some
> places removing __GFP_MOVABLE from gfp_mask means that we will need to
> also change other things. For example [1], in try_to_free_pages() we
> call current_gfp_context(gfp_mask) which can reduce the maximum zone
> idx, yet we simply set it to: reclaim_idx = gfp_zone(gfp_mask), not to
> the newly determined gfp_mask.

Yes and the direct reclaim should honor the movable zone restriction.
Why should we reclaim ZONE_MOVABLE when the allocation cannot really
allocate from it? Or have I misunderstood your concern?

> 
> [1] https://soleen.com/source/xref/linux/mm/vmscan.c?r=2da9f630#3239
> 
> 
>  All scope flags
> > should be applicable to the hot path as well. It would add few cycles to
> > there but the question is whether that would be noticeable over just
> > handling PF_MEMALLOC_NOMOVABLE on its own. The cache line would be
> > pulled in anyway.
> 
> Let's try it in a separate patch? I will add it in the next version of
> this series.

Separate patch or not is up to you. But I do not see a strong reason why
this cannot be addressed in a single one.

-- 
Michal Hocko
SUSE Labs
