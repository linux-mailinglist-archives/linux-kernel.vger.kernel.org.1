Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C6FC2CD9D6
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 16:08:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730999AbgLCPHj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 10:07:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727037AbgLCPHj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 10:07:39 -0500
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9FA1C061A4E
        for <linux-kernel@vger.kernel.org>; Thu,  3 Dec 2020 07:06:58 -0800 (PST)
Received: by mail-ed1-x542.google.com with SMTP id q16so2407709edv.10
        for <linux-kernel@vger.kernel.org>; Thu, 03 Dec 2020 07:06:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a1iPrMkb0iX1XvtR+qTACxaYKXWZSPoP+tl7W9BGvHQ=;
        b=ixOggIJMdAbM8y8k0hlBNIOBcAoFI4ZlpBsXYeyrhVL583C/wTkfuB56SPFcUtImBF
         KXPMdYYfsT8cT16Ec8DTWsj2kLWzRo8zxeE9hgzZEwMUv1rFZWG3D2Dn9Iy943jBm7Jb
         bKt2zpWQSjijAefPwl9y7qUjrbConnEb1o+0OMp3VVWrJEKrQaQy9yY1+Xv8+WMz355x
         tXGQECjj6RhKuRXQPLSwVRc570dD7Z5QTZEYFhpBRkSVRrxq5k1CDQlLx6VJB6L8StgT
         jYWz+o4LimGeIWt77Wr2ksR9gT4U+LIgetKKlNtwfi8pWmK8hmU9n+SjjaJ6mCTyg/IY
         C6og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a1iPrMkb0iX1XvtR+qTACxaYKXWZSPoP+tl7W9BGvHQ=;
        b=sfb6ytbYwD+EtiRfj0Ps/gupjyHgxbZIARGha/umilRXqeusU++KfgS8myeuK3ddE3
         6TwvcbLu8AWnQhJEzHNSZT1vcLnwRGWE7xGWPliwiX8aYUc3iQxRqvPzZ26zejdjTcrI
         icXkjiWBR38TinjWV+8DQnoEDaWT9+IpbVUwHh16TKWBVv5Dpx8W7oIhYGFowNc6311f
         Po4doCKL9yyfaCRbbIycSvrVbsFw8SdBvXPcQfQFx8IQ0TWqj+/USqbVcVBB/mK2VVBw
         WXcP/ajrLMdeDpoD2BYLihV9SEkPm9PUKjbXzElTQQLj0rF+alSKINsw4VlrM5pvIS0u
         884g==
X-Gm-Message-State: AOAM533HoMn+0re1Rk1TqIVSsdBBXatqfq1UDd9s0WVhE/9fvJSnHvIX
        hIFhIrkvcvRsLLrZIYQ8/jSZTTWvx5OOwqXrh/30cg==
X-Google-Smtp-Source: ABdhPJxGaMgQhso6rpkxxrb8k6AG9G2HGQLYHfqIOpYAY40150Oe/yvCghUxlQrMFOvrhCpQ5GEg8WLA/QZXRkfLg04=
X-Received: by 2002:a05:6402:456:: with SMTP id p22mr3221593edw.26.1607008017570;
 Thu, 03 Dec 2020 07:06:57 -0800 (PST)
MIME-Version: 1.0
References: <20201202052330.474592-1-pasha.tatashin@soleen.com>
 <20201202052330.474592-6-pasha.tatashin@soleen.com> <18c9ab89-185b-395a-97ce-31940388df0e@nvidia.com>
In-Reply-To: <18c9ab89-185b-395a-97ce-31940388df0e@nvidia.com>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Thu, 3 Dec 2020 10:06:21 -0500
Message-ID: <CA+CK2bBBcMKcCzQJDwEXgzTZKp7KezUAyPi2DOGX16K75dE7Qw@mail.gmail.com>
Subject: Re: [PATCH 5/6] mm: honor PF_MEMALLOC_NOMOVABLE for all allocations
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
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
        David Rientjes <rientjes@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 3, 2020 at 3:17 AM John Hubbard <jhubbard@nvidia.com> wrote:
>
> On 12/1/20 9:23 PM, Pavel Tatashin wrote:
> > PF_MEMALLOC_NOMOVABLE is only honored for CMA allocations, extend
> > this flag to work for any allocations by removing __GFP_MOVABLE from
> > gfp_mask when this flag is passed in the current context, thus
> > prohibiting allocations from ZONE_MOVABLE.
> >
> > Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
> > ---
> >   mm/hugetlb.c    |  2 +-
> >   mm/page_alloc.c | 26 ++++++++++++++++----------
> >   2 files changed, 17 insertions(+), 11 deletions(-)
> >
> > diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > index 02213c74ed6b..00e786201d8b 100644
> > --- a/mm/hugetlb.c
> > +++ b/mm/hugetlb.c
> > @@ -1036,7 +1036,7 @@ static struct page *dequeue_huge_page_node_exact(struct hstate *h, int nid)
> >       bool nomovable = !!(current->flags & PF_MEMALLOC_NOMOVABLE);
> >
> >       list_for_each_entry(page, &h->hugepage_freelists[nid], lru) {
> > -             if (nomovable && is_migrate_cma_page(page))
> > +             if (nomovable && is_migrate_movable(get_pageblock_migratetype(page)))
>
>
> I wonder if we should add a helper, like is_migrate_cma_page(), that avoids having
> to call get_pageblock_migratetype() at all of the callsites?

Good idea, I will add it.

>
>
> >                       continue;
> >
> >               if (PageHWPoison(page))
> > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > index 611799c72da5..7a6d86d0bc5f 100644
> > --- a/mm/page_alloc.c
> > +++ b/mm/page_alloc.c
> > @@ -3766,20 +3766,25 @@ alloc_flags_nofragment(struct zone *zone, gfp_t gfp_mask)
> >       return alloc_flags;
> >   }
> >
> > -static inline unsigned int current_alloc_flags(gfp_t gfp_mask,
> > -                                     unsigned int alloc_flags)
> > +static inline unsigned int cma_alloc_flags(gfp_t gfp_mask,
> > +                                        unsigned int alloc_flags)
>
> Actually, maybe the original name should be left intact. This handles current alloc
> flags, which right now happen to only cover CMA flags, so the original name seems
> accurate, right?

The reason I re-named it is because we do not access current context
anymore, only use gfp_mask to get cma flag.
>> -     unsigned int pflags = current->flags;

So, keeping "current" in the function name makes its intent misleading.

Thank you,
Pasha
