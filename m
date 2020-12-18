Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D5492DE18C
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 11:55:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389173AbgLRKwl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Dec 2020 05:52:41 -0500
Received: from mx2.suse.de ([195.135.220.15]:38928 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389078AbgLRKwk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Dec 2020 05:52:40 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1608288713; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8MQYiPPFwOXe1yceAmnwSQFW51gmPEmADZJTW8S8zQI=;
        b=p4Oy1M04f2z+5mTIDxeHlLDELqaylg9Gmjc2rKY/4RyCJDvjqifw7iPZAP3KOtOk3LWusj
        XB3+Z9mwv9BWy78dBl7B2PWo//ZMnBQjrPCLemF0ObWjjZg0oXwVXiF+/7agKiHYhzni+P
        wOtyf+ZVCSfPvvWFnhnAyi3ncPW8slA=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D0827ABC6;
        Fri, 18 Dec 2020 10:51:53 +0000 (UTC)
Date:   Fri, 18 Dec 2020 11:51:53 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Jacob Wen <jian.w.wen@oracle.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org
Subject: Re: [PATCH] mm/vmscan: DRY cleanup for do_try_to_free_pages()
Message-ID: <20201218105153.GX32193@dhcp22.suse.cz>
References: <20201218102217.186836-1-jian.w.wen@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201218102217.186836-1-jian.w.wen@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 18-12-20 18:22:17, Jacob Wen wrote:
> This patch reduces repetition of set_task_reclaim_state() around
> do_try_to_free_pages().

The changelog really should be talking about why this is needed/useful.
From the above it is not really clear whether you aimed at doing
a clean up or this is a fix for some misbehavior. I do assume the former
but this should be clearly articulated.

> Signed-off-by: Jacob Wen <jian.w.wen@oracle.com>
> ---
>  mm/vmscan.c | 27 ++++++++++++++++-----------
>  1 file changed, 16 insertions(+), 11 deletions(-)
> 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 257cba79a96d..4bc244b23686 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -3023,6 +3023,10 @@ static unsigned long do_try_to_free_pages(struct zonelist *zonelist,
>  	pg_data_t *last_pgdat;
>  	struct zoneref *z;
>  	struct zone *zone;
> +	unsigned long ret;
> +
> +	set_task_reclaim_state(current, &sc->reclaim_state);
> +
>  retry:
>  	delayacct_freepages_start();
>  
> @@ -3069,12 +3073,16 @@ static unsigned long do_try_to_free_pages(struct zonelist *zonelist,
>  
>  	delayacct_freepages_end();
>  
> -	if (sc->nr_reclaimed)
> -		return sc->nr_reclaimed;
> +	if (sc->nr_reclaimed) {
> +		ret = sc->nr_reclaimed;
> +		goto out;
> +	}
>  
>  	/* Aborted reclaim to try compaction? don't OOM, then */
> -	if (sc->compaction_ready)
> -		return 1;
> +	if (sc->compaction_ready) {
> +		ret = 1;
> +		goto out;
> +	}
>  
>  	/*
>  	 * We make inactive:active ratio decisions based on the node's
> @@ -3101,7 +3109,10 @@ static unsigned long do_try_to_free_pages(struct zonelist *zonelist,
>  		goto retry;
>  	}
>  
> -	return 0;
> +	ret = 0;
> +out:
> +	set_task_reclaim_state(current, NULL);
> +	return ret;
>  }
>  
>  static bool allow_direct_reclaim(pg_data_t *pgdat)
> @@ -3269,13 +3280,11 @@ unsigned long try_to_free_pages(struct zonelist *zonelist, int order,
>  	if (throttle_direct_reclaim(sc.gfp_mask, zonelist, nodemask))
>  		return 1;
>  
> -	set_task_reclaim_state(current, &sc.reclaim_state);
>  	trace_mm_vmscan_direct_reclaim_begin(order, sc.gfp_mask);
>  
>  	nr_reclaimed = do_try_to_free_pages(zonelist, &sc);
>  
>  	trace_mm_vmscan_direct_reclaim_end(nr_reclaimed);
> -	set_task_reclaim_state(current, NULL);
>  
>  	return nr_reclaimed;
>  }
> @@ -3347,7 +3356,6 @@ unsigned long try_to_free_mem_cgroup_pages(struct mem_cgroup *memcg,
>  	 */
>  	struct zonelist *zonelist = node_zonelist(numa_node_id(), sc.gfp_mask);
>  
> -	set_task_reclaim_state(current, &sc.reclaim_state);
>  	trace_mm_vmscan_memcg_reclaim_begin(0, sc.gfp_mask);
>  	noreclaim_flag = memalloc_noreclaim_save();
>  
> @@ -3355,7 +3363,6 @@ unsigned long try_to_free_mem_cgroup_pages(struct mem_cgroup *memcg,
>  
>  	memalloc_noreclaim_restore(noreclaim_flag);
>  	trace_mm_vmscan_memcg_reclaim_end(nr_reclaimed);
> -	set_task_reclaim_state(current, NULL);
>  
>  	return nr_reclaimed;
>  }
> @@ -4023,11 +4030,9 @@ unsigned long shrink_all_memory(unsigned long nr_to_reclaim)
>  
>  	fs_reclaim_acquire(sc.gfp_mask);
>  	noreclaim_flag = memalloc_noreclaim_save();
> -	set_task_reclaim_state(current, &sc.reclaim_state);
>  
>  	nr_reclaimed = do_try_to_free_pages(zonelist, &sc);
>  
> -	set_task_reclaim_state(current, NULL);
>  	memalloc_noreclaim_restore(noreclaim_flag);
>  	fs_reclaim_release(sc.gfp_mask);
>  
> -- 
> 2.25.1
> 

-- 
Michal Hocko
SUSE Labs
