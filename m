Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 637F6284A1A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 12:05:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725977AbgJFKFq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 06:05:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:49132 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725891AbgJFKFp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 06:05:45 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1601978744;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=J/4ppGKBWf5m/h2cV7xfqGdqXrn2x0TOHnDaaxC+mlI=;
        b=lUkUEjn++18G8DItQpdOmTPQvp+4K1fAnC/meYSs1w7aQsHACK9q+IBxw7HI2k74YIcfFx
        YRHE5Sx3rJL2zMSFjXXfOUl5j19c4QGFeoEVbY8/EMDJEPOlinjUVxSxs8HM2OhxtvlFQV
        lqcDWZzqGGPtuPxcQEBssGpCjMR0p4w=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 273D3B214;
        Tue,  6 Oct 2020 10:05:44 +0000 (UTC)
Date:   Tue, 6 Oct 2020 12:05:43 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Oscar Salvador <osalvador@suse.de>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Subject: Re: [PATCH 9/9] mm, page_alloc: optionally disable pcplists during
 page isolation
Message-ID: <20201006100543.GC29020@dhcp22.suse.cz>
References: <20200922143712.12048-1-vbabka@suse.cz>
 <20200922143712.12048-10-vbabka@suse.cz>
 <20201006083418.GB29020@dhcp22.suse.cz>
 <a35c1f92-b56a-e6c4-9920-33f99850eb76@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a35c1f92-b56a-e6c4-9920-33f99850eb76@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 06-10-20 10:40:23, David Hildenbrand wrote:
> On 06.10.20 10:34, Michal Hocko wrote:
> > On Tue 22-09-20 16:37:12, Vlastimil Babka wrote:
> >> Page isolation can race with process freeing pages to pcplists in a way that
> >> a page from isolated pageblock can end up on pcplist. This can be fixed by
> >> repeated draining of pcplists, as done by patch "mm/memory_hotplug: drain
> >> per-cpu pages again during memory offline" in [1].
> >>
> >> David and Michal would prefer that this race was closed in a way that callers
> >> of page isolation who need stronger guarantees don't need to repeatedly drain.
> >> David suggested disabling pcplists usage completely during page isolation,
> >> instead of repeatedly draining them.
> >>
> >> To achieve this without adding special cases in alloc/free fastpath, we can use
> >> the same approach as boot pagesets - when pcp->high is 0, any pcplist addition
> >> will be immediately flushed.
> >>
> >> The race can thus be closed by setting pcp->high to 0 and draining pcplists
> >> once, before calling start_isolate_page_range(). The draining will serialize
> >> after processes that already disabled interrupts and read the old value of
> >> pcp->high in free_unref_page_commit(), and processes that have not yet disabled
> >> interrupts, will observe pcp->high == 0 when they are rescheduled, and skip
> >> pcplists. This guarantees no stray pages on pcplists in zones where isolation
> >> happens.
> >>
> >> This patch thus adds zone_pcplist_disable() and zone_pcplist_enable() functions
> >> that page isolation users can call before start_isolate_page_range() and after
> >> unisolating (or offlining) the isolated pages. A new zone->pcplist_disabled
> >> atomic variable makes sure we disable only pcplists once and don't enable
> >> them prematurely in case there are multiple users in parallel.
> >>
> >> We however have to avoid external updates to high and batch by taking
> >> pcp_batch_high_lock. To allow multiple isolations in parallel, change this lock
> >> from mutex to rwsem.
> > 
> > The overall idea makes sense. I just suspect you are over overcomplicating 
> > the implementation a bit. Is there any reason that we cannot start with
> > a really dumb implementation first. The only user of this functionality
> > is the memory offlining and that is already strongly synchronized
> > (mem_hotplug_begin) so a lot of trickery can be dropped here. Should we
> > find a new user later on we can make the implementation finer grained
> > but now it will not serve any purpose. So can we simply update pcp->high
> > and drain all pcp in the given zone and wait for all remote pcp draining
> > in zone_pcplist_enable and updte revert all that in zone_pcplist_enable.
> > We can stick to the existing pcp_batch_high_lock.
> > 
> > What do you think?
> > 
> 
> My two cents, we might want to make use of this in some cases of
> alloc_contig_range() soon ("try hard mode"). So I'd love to see a
> synchronized mechanism. However, that can be factored out into a
> separate patch, so this patch gets significantly simpler.

Exactly. And the incremental patch can be added along with the a-c-r try
harder mode.
-- 
Michal Hocko
SUSE Labs
