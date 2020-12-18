Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0390F2DE404
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 15:29:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727788AbgLRO2F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Dec 2020 09:28:05 -0500
Received: from mx2.suse.de ([195.135.220.15]:44298 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727425AbgLRO2F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Dec 2020 09:28:05 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1608301638; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rJYU3BD79AgOBcyIHbSaDSXOqTfnBGcyG8ujMIbf1EI=;
        b=F/dMi/subvq0OtCa3rKYQerwZCQJaa2UKRP7jFIx00B6kJ+Eq6z3aO2+GeC36PpLAv/Q2J
        qiT/BHmr1eIq6uL6TTb2FqROjZFdfeopM7dBq4ZUo4hpwTAbOl0WKbHVJpA/zpVuqQ9Zx3
        VTbTtkOBwPuphZWUv05qxt30ybgHzEQ=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id BE130B72C;
        Fri, 18 Dec 2020 14:27:18 +0000 (UTC)
Date:   Fri, 18 Dec 2020 15:27:17 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Jacob Wen <jian.w.wen@oracle.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org
Subject: Re: [PATCH] mm/vmscan: DRY cleanup for do_try_to_free_pages()
Message-ID: <20201218142717.GA32193@dhcp22.suse.cz>
References: <20201218102217.186836-1-jian.w.wen@oracle.com>
 <20201218105153.GX32193@dhcp22.suse.cz>
 <f376b551-9a90-c036-d34b-b32d93107b6c@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f376b551-9a90-c036-d34b-b32d93107b6c@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 18-12-20 21:51:48, Jacob Wen wrote:
> 
> On 12/18/20 6:51 PM, Michal Hocko wrote:
> > On Fri 18-12-20 18:22:17, Jacob Wen wrote:
> > > This patch reduces repetition of set_task_reclaim_state() around
> > > do_try_to_free_pages().
> > The changelog really should be talking about why this is needed/useful.
> >  From the above it is not really clear whether you aimed at doing
> > a clean up or this is a fix for some misbehavior. I do assume the former
> > but this should be clearly articulated.
> 
> How about this?
> 
> mm/vmscan: remove duplicate code around do_try_to_free_pages()
> 
> This patch moves set_task_reclaim_state() into do_try_to_free_pages()
> to avoid unnecessary repetition. It doesn't introduce functional
> change.

This is still more about what is changed more than why it is changed. I
would go with something like the following:
"
reclaim_state has to be set for all reclaim paths because it acts as a
storage to collect reclaim feedback. Currently set_task_reclaim_state is
called from each highlevel reclaim function. Simplify the code flow by
moving set_task_reclaim_state into core direct reclaim function
(do_try_to_free_pages) for all direct reclaim paths.
"

To the patch itself. I am not opposed but I do not see an urgent reason
to take it either. The net LOC increases slightly, it makes
do_try_to_free_pages slightly more tricky due to different early return
paths. Highlevel direct reclaim functions do not tend to change a lot.

> > > Signed-off-by: Jacob Wen <jian.w.wen@oracle.com>
> > > ---
> > >   mm/vmscan.c | 27 ++++++++++++++++-----------
> > >   1 file changed, 16 insertions(+), 11 deletions(-)
> > > 
> > > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > > index 257cba79a96d..4bc244b23686 100644
> > > --- a/mm/vmscan.c
> > > +++ b/mm/vmscan.c
> > > @@ -3023,6 +3023,10 @@ static unsigned long do_try_to_free_pages(struct zonelist *zonelist,
> > >   	pg_data_t *last_pgdat;
> > >   	struct zoneref *z;
> > >   	struct zone *zone;
> > > +	unsigned long ret;
> > > +
> > > +	set_task_reclaim_state(current, &sc->reclaim_state);
> > > +
> > >   retry:
> > >   	delayacct_freepages_start();
> > > @@ -3069,12 +3073,16 @@ static unsigned long do_try_to_free_pages(struct zonelist *zonelist,
> > >   	delayacct_freepages_end();
> > > -	if (sc->nr_reclaimed)
> > > -		return sc->nr_reclaimed;
> > > +	if (sc->nr_reclaimed) {
> > > +		ret = sc->nr_reclaimed;
> > > +		goto out;
> > > +	}
> > >   	/* Aborted reclaim to try compaction? don't OOM, then */
> > > -	if (sc->compaction_ready)
> > > -		return 1;
> > > +	if (sc->compaction_ready) {
> > > +		ret = 1;
> > > +		goto out;
> > > +	}
> > >   	/*
> > >   	 * We make inactive:active ratio decisions based on the node's
> > > @@ -3101,7 +3109,10 @@ static unsigned long do_try_to_free_pages(struct zonelist *zonelist,
> > >   		goto retry;
> > >   	}
> > > -	return 0;
> > > +	ret = 0;
> > > +out:
> > > +	set_task_reclaim_state(current, NULL);
> > > +	return ret;
> > >   }
> > >   static bool allow_direct_reclaim(pg_data_t *pgdat)
> > > @@ -3269,13 +3280,11 @@ unsigned long try_to_free_pages(struct zonelist *zonelist, int order,
> > >   	if (throttle_direct_reclaim(sc.gfp_mask, zonelist, nodemask))
> > >   		return 1;
> > > -	set_task_reclaim_state(current, &sc.reclaim_state);
> > >   	trace_mm_vmscan_direct_reclaim_begin(order, sc.gfp_mask);
> > >   	nr_reclaimed = do_try_to_free_pages(zonelist, &sc);
> > >   	trace_mm_vmscan_direct_reclaim_end(nr_reclaimed);
> > > -	set_task_reclaim_state(current, NULL);
> > >   	return nr_reclaimed;
> > >   }
> > > @@ -3347,7 +3356,6 @@ unsigned long try_to_free_mem_cgroup_pages(struct mem_cgroup *memcg,
> > >   	 */
> > >   	struct zonelist *zonelist = node_zonelist(numa_node_id(), sc.gfp_mask);
> > > -	set_task_reclaim_state(current, &sc.reclaim_state);
> > >   	trace_mm_vmscan_memcg_reclaim_begin(0, sc.gfp_mask);
> > >   	noreclaim_flag = memalloc_noreclaim_save();
> > > @@ -3355,7 +3363,6 @@ unsigned long try_to_free_mem_cgroup_pages(struct mem_cgroup *memcg,
> > >   	memalloc_noreclaim_restore(noreclaim_flag);
> > >   	trace_mm_vmscan_memcg_reclaim_end(nr_reclaimed);
> > > -	set_task_reclaim_state(current, NULL);
> > >   	return nr_reclaimed;
> > >   }
> > > @@ -4023,11 +4030,9 @@ unsigned long shrink_all_memory(unsigned long nr_to_reclaim)
> > >   	fs_reclaim_acquire(sc.gfp_mask);
> > >   	noreclaim_flag = memalloc_noreclaim_save();
> > > -	set_task_reclaim_state(current, &sc.reclaim_state);
> > >   	nr_reclaimed = do_try_to_free_pages(zonelist, &sc);
> > > -	set_task_reclaim_state(current, NULL);
> > >   	memalloc_noreclaim_restore(noreclaim_flag);
> > >   	fs_reclaim_release(sc.gfp_mask);
> > > -- 
> > > 2.25.1
> > > 

-- 
Michal Hocko
SUSE Labs
