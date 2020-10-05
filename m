Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6746728374B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 16:05:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726182AbgJEOFe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 10:05:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:54666 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725903AbgJEOFd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 10:05:33 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1601906732;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mDtDQhketcq7bMXAoB6v7sjRm5Re7JG6raTUQ0gvII0=;
        b=J6sJ0/9XfbH2tDhmw6JcLzTejZ6/O+2B99IlIP1jiHEFQd47mJRtX5qFt5VLVsmXIUTtiO
        KsY/UlocAlhcdgVaax+795HYkTbvfT63EEut912Uw2J5KFN5a7K6iNqLse6WyIDnzGrnKB
        KZn+RafdJBQi9weioRMV6Q1DU1da5hc=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 446F6ADD8;
        Mon,  5 Oct 2020 14:05:32 +0000 (UTC)
Date:   Mon, 5 Oct 2020 16:05:31 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Oscar Salvador <osalvador@suse.de>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Subject: Re: [PATCH 9/9] mm, page_alloc: optionally disable pcplists during
 page isolation
Message-ID: <20201005140531.GE4555@dhcp22.suse.cz>
References: <20200922143712.12048-1-vbabka@suse.cz>
 <20200922143712.12048-10-vbabka@suse.cz>
 <10cdae53-c64b-e371-1b83-01d1af7a131e@redhat.com>
 <e0ab17e9-6c05-cf32-9e2d-efbf011860a2@redhat.com>
 <2ce92f9a-eaa2-45b2-207c-46a79d6a2bde@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2ce92f9a-eaa2-45b2-207c-46a79d6a2bde@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 25-09-20 13:10:05, Vlastimil Babka wrote:
> On 9/25/20 12:54 PM, David Hildenbrand wrote:
> >>> --- a/mm/page_isolation.c
> >>> +++ b/mm/page_isolation.c
> >>> @@ -15,6 +15,22 @@
> >>>  #define CREATE_TRACE_POINTS
> >>>  #include <trace/events/page_isolation.h>
> >>>  
> >>> +void zone_pcplist_disable(struct zone *zone)
> >>> +{
> >>> +	down_read(&pcp_batch_high_lock);
> >>> +	if (atomic_inc_return(&zone->pcplist_disabled) == 1) {
> >>> +		zone_update_pageset_high_and_batch(zone, 0, 1);
> >>> +		__drain_all_pages(zone, true);
> >>> +	}
> >> Hm, if one CPU is still inside the if-clause, the other one would
> >> continue, however pcp wpould not be disabled and zones not drained when
> >> returning.
> 
> Ah, well spotted, thanks!
> 
> >> (while we only allow a single Offline_pages() call, it will be different
> >> when we use the function in other context - especially,
> >> alloc_contig_range() for some users)
> >>
> >> Can't we use down_write() here? So it's serialized and everybody has to
> >> properly wait. (and we would not have to rely on an atomic_t)
> > Sorry, I meant down_write only temporarily in this code path. Not
> > keeping it locked in write when returning (I remember there is a way to
> > downgrade).
> 
> Hmm that temporary write lock would still block new callers until previous
> finish with the downgraded-to-read lock.
> 
> But I guess something like this would work:
> 
> retry:
>   if (atomic_read(...) == 0) {
>     // zone_update... + drain
>     atomic_inc(...);
>   else if (atomic_inc_return == 1)
>     // atomic_cmpxchg from 0 to 1; if that fails, goto retry
> 
> Tricky, but races could only read to unnecessary duplicated updates + flushing
> but nothing worse?
> 
> Or add another spinlock to cover this part instead of the temp write lock...

Do you plan to post a new version or should I review this one?

-- 
Michal Hocko
SUSE Labs
