Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C156D268D7B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 16:25:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726838AbgINOZB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 10:25:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:55708 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726695AbgINOWf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 10:22:35 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 090E8AE07;
        Mon, 14 Sep 2020 14:22:49 +0000 (UTC)
Date:   Mon, 14 Sep 2020 16:22:33 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     mateusznosek0@gmail.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org
Subject: Re: [RFC PATCH] mm/page_alloc.c: micro-optimization reduce oom
 critical section size
Message-ID: <20200914142233.GT16999@dhcp22.suse.cz>
References: <20200914100654.21746-1-mateusznosek0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200914100654.21746-1-mateusznosek0@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 14-09-20 12:06:54, mateusznosek0@gmail.com wrote:
> From: Mateusz Nosek <mateusznosek0@gmail.com>
> 
> Most operations from '__alloc_pages_may_oom' do not require oom_mutex hold.
> Exception is 'out_of_memory'. The patch refactors '__alloc_pages_may_oom'
> to reduce critical section size and improve overall system performance.

This is a real slow path. What is the point of optimizing it? Do you
have any numbers?

Also I am not convinced the patch is entirely safe. At least the last
allocation attempt is meant to be done under the lock to allow only one
task to perform this. I have forgot the complete reasoning behind that
but at least the changelog should argue why that is ok.

> Signed-off-by: Mateusz Nosek <mateusznosek0@gmail.com>
> ---
>  mm/page_alloc.c | 45 ++++++++++++++++++++++++---------------------
>  1 file changed, 24 insertions(+), 21 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index b9bd75cacf02..b07f950a5825 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -3935,18 +3935,7 @@ __alloc_pages_may_oom(gfp_t gfp_mask, unsigned int order,
>  		.order = order,
>  	};
>  	struct page *page;
> -
> -	*did_some_progress = 0;
> -
> -	/*
> -	 * Acquire the oom lock.  If that fails, somebody else is
> -	 * making progress for us.
> -	 */
> -	if (!mutex_trylock(&oom_lock)) {
> -		*did_some_progress = 1;
> -		schedule_timeout_uninterruptible(1);
> -		return NULL;
> -	}
> +	bool success;
>  
>  	/*
>  	 * Go through the zonelist yet one more time, keep very high watermark
> @@ -3959,14 +3948,17 @@ __alloc_pages_may_oom(gfp_t gfp_mask, unsigned int order,
>  				      ~__GFP_DIRECT_RECLAIM, order,
>  				      ALLOC_WMARK_HIGH|ALLOC_CPUSET, ac);
>  	if (page)
> -		goto out;
> +		return page;
> +
> +	/* Check if somebody else is making progress for us. */
> +	*did_some_progress = mutex_is_locked(&oom_lock);
>  
>  	/* Coredumps can quickly deplete all memory reserves */
>  	if (current->flags & PF_DUMPCORE)
> -		goto out;
> +		return NULL;
>  	/* The OOM killer will not help higher order allocs */
>  	if (order > PAGE_ALLOC_COSTLY_ORDER)
> -		goto out;
> +		return NULL;
>  	/*
>  	 * We have already exhausted all our reclaim opportunities without any
>  	 * success so it is time to admit defeat. We will skip the OOM killer
> @@ -3976,12 +3968,12 @@ __alloc_pages_may_oom(gfp_t gfp_mask, unsigned int order,
>  	 * The OOM killer may not free memory on a specific node.
>  	 */
>  	if (gfp_mask & (__GFP_RETRY_MAYFAIL | __GFP_THISNODE))
> -		goto out;
> +		return NULL;
>  	/* The OOM killer does not needlessly kill tasks for lowmem */
>  	if (ac->highest_zoneidx < ZONE_NORMAL)
> -		goto out;
> +		return NULL;
>  	if (pm_suspended_storage())
> -		goto out;
> +		return NULL;
>  	/*
>  	 * XXX: GFP_NOFS allocations should rather fail than rely on
>  	 * other request to make a forward progress.
> @@ -3992,8 +3984,20 @@ __alloc_pages_may_oom(gfp_t gfp_mask, unsigned int order,
>  	 * failures more gracefully we should just bail out here.
>  	 */
>  
> +	/*
> +	 * Acquire the oom lock.  If that fails, somebody else is
> +	 * making progress for us.
> +	 */
> +	if (!mutex_trylock(&oom_lock)) {
> +		*did_some_progress = 1;
> +		schedule_timeout_uninterruptible(1);
> +		return NULL;
> +	}
> +	success = out_of_memory(&oc);
> +	mutex_unlock(&oom_lock);
> +
>  	/* Exhausted what can be done so it's blame time */
> -	if (out_of_memory(&oc) || WARN_ON_ONCE(gfp_mask & __GFP_NOFAIL)) {
> +	if (success || WARN_ON_ONCE(gfp_mask & __GFP_NOFAIL)) {
>  		*did_some_progress = 1;
>  
>  		/*
> @@ -4004,8 +4008,7 @@ __alloc_pages_may_oom(gfp_t gfp_mask, unsigned int order,
>  			page = __alloc_pages_cpuset_fallback(gfp_mask, order,
>  					ALLOC_NO_WATERMARKS, ac);
>  	}
> -out:
> -	mutex_unlock(&oom_lock);
> +
>  	return page;
>  }
>  
> -- 
> 2.20.1
> 

-- 
Michal Hocko
SUSE Labs
