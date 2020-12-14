Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 832462D9977
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 15:11:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407242AbgLNOKC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 09:10:02 -0500
Received: from mx2.suse.de ([195.135.220.15]:60132 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731394AbgLNOKA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 09:10:00 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1607954953; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=n3x7DoQ25WP73SRWg/ewj9P5+TrBA+9Q9ozY3c1IcPk=;
        b=fPUpDWb8rsrb2Sf3QLqdbSlhcGRj+hatXpxJ6Zs659T5oXlnzIKZq2VIwz6V0tt0pf0gVO
        6G1JG6Re2Vtlh4Ktuexpv+DI7gzrk+/xwp2Jz9jgzraG/Ft6tSY9f/1ixBBkdqn3rNAIcy
        Dc37+u6wRUBp1Caq0GPh4taWppyvCI0=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 31C72AC10;
        Mon, 14 Dec 2020 14:09:13 +0000 (UTC)
Date:   Mon, 14 Dec 2020 15:09:12 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Pavel Tatashin <pasha.tatashin@soleen.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, vbabka@suse.cz, david@redhat.com,
        osalvador@suse.de, dan.j.williams@intel.com, sashal@kernel.org,
        tyhicks@linux.microsoft.com, iamjoonsoo.kim@lge.com,
        mike.kravetz@oracle.com, rostedt@goodmis.org, mingo@redhat.com,
        jgg@ziepe.ca, peterz@infradead.org, mgorman@suse.de,
        willy@infradead.org, rientjes@google.com, jhubbard@nvidia.com,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH v3 3/6] mm: apply per-task gfp constraints in fast path
Message-ID: <20201214140912.GE32193@dhcp22.suse.cz>
References: <20201211202140.396852-1-pasha.tatashin@soleen.com>
 <20201211202140.396852-4-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201211202140.396852-4-pasha.tatashin@soleen.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 11-12-20 15:21:37, Pavel Tatashin wrote:
> Function current_gfp_context() is called after fast path. However, soon we
> will add more constraints which will also limit zones based on context.
> Move this call into fast path, and apply the correct constraints for all
> allocations.
> 
> Also update .reclaim_idx based on value returned by current_gfp_context()
> because it soon will modify the allowed zones.
> 
> Note:
> With this patch we will do one extra current->flags load during fast path,
> but we already load current->flags in fast-path:
> 
> __alloc_pages_nodemask()
>  prepare_alloc_pages()
>   current_alloc_flags(gfp_mask, *alloc_flags);
> 
> Later, when we add the zone constrain logic to current_gfp_context() we
> will be able to remove current->flags load from current_alloc_flags, and
> therefore return fast-path to the current performance level.
> 
> Suggested-by: Michal Hocko <mhocko@kernel.org>
> Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
> ---
>  mm/page_alloc.c | 15 ++++++++-------
>  mm/vmscan.c     | 10 ++++++----
>  2 files changed, 14 insertions(+), 11 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index ec05396a597b..c2dea9ad0e98 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -4976,6 +4976,13 @@ __alloc_pages_nodemask(gfp_t gfp_mask, unsigned int order, int preferred_nid,
>  	}
>  
>  	gfp_mask &= gfp_allowed_mask;
> +	/*
> +	 * Apply scoped allocation constraints. This is mainly about GFP_NOFS
> +	 * resp. GFP_NOIO which has to be inherited for all allocation requests
> +	 * from a particular context which has been marked by
> +	 * memalloc_no{fs,io}_{save,restore}.
> +	 */
> +	gfp_mask = current_gfp_context(gfp_mask);
>  	alloc_mask = gfp_mask;
>  	if (!prepare_alloc_pages(gfp_mask, order, preferred_nid, nodemask, &ac, &alloc_mask, &alloc_flags))
>  		return NULL;
> @@ -4991,13 +4998,7 @@ __alloc_pages_nodemask(gfp_t gfp_mask, unsigned int order, int preferred_nid,
>  	if (likely(page))
>  		goto out;
>  
> -	/*
> -	 * Apply scoped allocation constraints. This is mainly about GFP_NOFS
> -	 * resp. GFP_NOIO which has to be inherited for all allocation requests
> -	 * from a particular context which has been marked by
> -	 * memalloc_no{fs,io}_{save,restore}.
> -	 */
> -	alloc_mask = current_gfp_context(gfp_mask);
> +	alloc_mask = gfp_mask;
>  	ac.spread_dirty_pages = false;
>  
>  	/*

Ack to this.

But I do not really understand this. All allocation contexts should have
a proper gfp mask so why do we have to call current_gfp_context here?
In fact moving the current_gfp_context in the allocator path should have
made all this games unnecessary. Memcg reclaim path might need some
careful check because gfp mask is used more creative there but the
general reclaim paths should be ok.

> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 469016222cdb..d9546f5897f4 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -3234,11 +3234,12 @@ static bool throttle_direct_reclaim(gfp_t gfp_mask, struct zonelist *zonelist,
>  unsigned long try_to_free_pages(struct zonelist *zonelist, int order,
>  				gfp_t gfp_mask, nodemask_t *nodemask)
>  {
> +	gfp_t current_gfp_mask = current_gfp_context(gfp_mask);
>  	unsigned long nr_reclaimed;
>  	struct scan_control sc = {
>  		.nr_to_reclaim = SWAP_CLUSTER_MAX,
> -		.gfp_mask = current_gfp_context(gfp_mask),
> -		.reclaim_idx = gfp_zone(gfp_mask),
> +		.gfp_mask = current_gfp_mask,
> +		.reclaim_idx = gfp_zone(current_gfp_mask),
>  		.order = order,
>  		.nodemask = nodemask,
>  		.priority = DEF_PRIORITY,
> @@ -4158,17 +4159,18 @@ static int __node_reclaim(struct pglist_data *pgdat, gfp_t gfp_mask, unsigned in
>  {
>  	/* Minimum pages needed in order to stay on node */
>  	const unsigned long nr_pages = 1 << order;
> +	gfp_t current_gfp_mask = current_gfp_context(gfp_mask);
>  	struct task_struct *p = current;
>  	unsigned int noreclaim_flag;
>  	struct scan_control sc = {
>  		.nr_to_reclaim = max(nr_pages, SWAP_CLUSTER_MAX),
> -		.gfp_mask = current_gfp_context(gfp_mask),
> +		.gfp_mask = current_gfp_mask,
>  		.order = order,
>  		.priority = NODE_RECLAIM_PRIORITY,
>  		.may_writepage = !!(node_reclaim_mode & RECLAIM_WRITE),
>  		.may_unmap = !!(node_reclaim_mode & RECLAIM_UNMAP),
>  		.may_swap = 1,
> -		.reclaim_idx = gfp_zone(gfp_mask),
> +		.reclaim_idx = gfp_zone(current_gfp_mask),

Again, why do we need this when the gfp_mask 
>  	};
>  
>  	trace_mm_vmscan_node_reclaim_begin(pgdat->node_id, order,
> -- 
> 2.25.1

-- 
Michal Hocko
SUSE Labs
