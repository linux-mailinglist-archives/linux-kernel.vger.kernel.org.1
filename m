Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7303B2A0863
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 15:49:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726982AbgJ3OtU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 10:49:20 -0400
Received: from mx2.suse.de ([195.135.220.15]:59112 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726596AbgJ3OtT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 10:49:19 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1604069358;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jC196offWe8kZaKf5Rpbbnzmhqts/gI7NsBHR/i23IY=;
        b=j+ISWsOZGJGLNKcv59Kl8bfKr0BHSQ3sw34cw5g0O/yq3SJfwO498lNZmdrf2z/7YCc9Vq
        GcVXPCUTNzvomOIqAKgfQ/R3wBxU7K/vbWgugsCbQQVMsH3mth+gOOIK/gi6ACd5PyxpFZ
        d0idin88Iu2Z+XwNiLrEwR9HbnYTRM0=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 0D118AF0B;
        Fri, 30 Oct 2020 14:49:18 +0000 (UTC)
Date:   Fri, 30 Oct 2020 15:49:17 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Zi Yan <ziy@nvidia.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Rik van Riel <riel@surriel.com>,
        linux-kernel@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH] mm/compaction: count pages and stop correctly during
 page isolation.
Message-ID: <20201030144917.GK1478@dhcp22.suse.cz>
References: <20201029200435.3386066-1-zi.yan@sent.com>
 <20201030094308.GG1478@dhcp22.suse.cz>
 <6CAAB1FC-2B41-490B-A67A-93063629C19B@nvidia.com>
 <20201030133625.GJ1478@dhcp22.suse.cz>
 <400B3460-65C0-4C48-A7EA-1A9F5780EC9C@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <400B3460-65C0-4C48-A7EA-1A9F5780EC9C@nvidia.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 30-10-20 10:35:43, Zi Yan wrote:
> On 30 Oct 2020, at 9:36, Michal Hocko wrote:
> 
> > On Fri 30-10-20 08:20:50, Zi Yan wrote:
> >> On 30 Oct 2020, at 5:43, Michal Hocko wrote:
> >>
> >>> [Cc Vlastimil]
> >>>
> >>> On Thu 29-10-20 16:04:35, Zi Yan wrote:
> >>>> From: Zi Yan <ziy@nvidia.com>
> >>>>
> >>>> In isolate_migratepages_block, when cc->alloc_contig is true, we are
> >>>> able to isolate compound pages, nr_migratepages and nr_isolated did not
> >>>> count compound pages correctly, causing us to isolate more pages than we
> >>>> thought. Use thp_nr_pages to count pages. Otherwise, we might be trapped
> >>>> in too_many_isolated while loop, since the actual isolated pages can go
> >>>> up to COMPACT_CLUSTER_MAX*512=16384, where COMPACT_CLUSTER_MAX is 32,
> >>>> since we stop isolation after cc->nr_migratepages reaches to
> >>>> COMPACT_CLUSTER_MAX.
> >>>>
> >>>> In addition, after we fix the issue above, cc->nr_migratepages could
> >>>> never be equal to COMPACT_CLUSTER_MAX if compound pages are isolated,
> >>>> thus page isolation could not stop as we intended. Change the isolation
> >>>> stop condition to >=.
> >>>>
> >>>> Signed-off-by: Zi Yan <ziy@nvidia.com>
> >>>> ---
> >>>>  mm/compaction.c | 8 ++++----
> >>>>  1 file changed, 4 insertions(+), 4 deletions(-)
> >>>>
> >>>> diff --git a/mm/compaction.c b/mm/compaction.c
> >>>> index ee1f8439369e..0683a4999581 100644
> >>>> --- a/mm/compaction.c
> >>>> +++ b/mm/compaction.c
> >>>> @@ -1012,8 +1012,8 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
> >>>>
> >>>>  isolate_success:
> >>>>  		list_add(&page->lru, &cc->migratepages);
> >>>> -		cc->nr_migratepages++;
> >>>> -		nr_isolated++;
> >>>> +		cc->nr_migratepages += thp_nr_pages(page);
> >>>> +		nr_isolated += thp_nr_pages(page);
> >>>
> >>> Does thp_nr_pages work for __PageMovable pages?
> >>
> >> Yes. It is the same as compound_nr() but compiled
> >> to 1 when THP is not enabled.
> >
> > I am sorry but I do not follow. First of all the implementation of the
> > two is different and also I was asking about __PageMovable which should
> > never be THP IIRC. Can they be compound though?
> 
> __PageMovable, non-lru movable pages, can be compound and thp_nr_page cannot
> be used for it, since when THP is off, thp_nr_page will return the wrong number.
> I got confused by its name, sorry.

OK, this matches my understanding. Good we are on the same page.

> But __PageMovable is irrelevant to this patch, since we are using
> __isolate_lru_page to isolate pages. non-lru __PageMovable should not appear
> after isolate_succes. thp_nr_pages can be used here.

But this is still not clear to me. __PageMovable pages are isolated by
isolate_movable_page and then jump to isolate_succes. Does that somehow
changes the nature of the page being compound or tat thp_nr_page would
start working on those pages.
-- 
Michal Hocko
SUSE Labs
