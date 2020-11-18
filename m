Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6391F2B8531
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 20:59:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726719AbgKRT6Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 14:58:24 -0500
Received: from mx2.suse.de ([195.135.220.15]:44116 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726616AbgKRT6Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 14:58:24 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1605729502; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yXTQVoU3RwSOvg1f77SjwmAqVd1yPQ5OfhIqrU1/DEQ=;
        b=MuXEdXJ3AVgDRxV6lv4HcC6J6WKjpSJJWAFVnwTlIchehbt3RmPpFOPTvqsxOB9s/CEJBL
        EOJ8lLcyaOcKaHditz5CVpWZ7MrMZzlFezxPoHSob3YC9bw4EOaNHrvOkG/GlegT66Rm+Q
        RlEiOBD0h0LoABdUCDZQiphpmutaaPg=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id CFD4FAC48;
        Wed, 18 Nov 2020 19:58:22 +0000 (UTC)
Date:   Wed, 18 Nov 2020 20:58:22 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Roman Gushchin <guro@fb.com>, Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] memcg, kmem: further deprecate kmem.limit_in_bytes
Message-ID: <20201118195822.GW12284@dhcp22.suse.cz>
References: <20201118175726.2453120-1-shakeelb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201118175726.2453120-1-shakeelb@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 18-11-20 09:57:26, Shakeel Butt wrote:
> The deprecation process of kmem.limit_in_bytes started with the commit
> 0158115f702 ("memcg, kmem: deprecate kmem.limit_in_bytes") which also
> explains in detail the motivation behind the deprecation. To summarize,
> it is the unexpected behavior on hitting the kmem limit. This patch
> moves the deprecation process to the next stage by disallowing to set
> the kmem limit. In future we might just remove the kmem.limit_in_bytes
> file completely.
> 
> Signed-off-by: Shakeel Butt <shakeelb@google.com>

I am not against this. I am just not sure whether one year is enough for
those users who tend to have a more considervative kernel upgrade path.
I am not worried about SLES user base much as we didn't even enable
KMEM accounting when it was still guarded by a config option. Not sure
about others though.

Considering the code cleanup is not that large, I would rather wait some
more. But you can add
Acked-by: Michal Hocko <mhocko@suse.com>

Maybe we can ask Andrew to put it into mmotm for few releases.

> ---
>  .../admin-guide/cgroup-v1/memory.rst          |  6 ++--
>  mm/memcontrol.c                               | 35 +++----------------
>  2 files changed, 6 insertions(+), 35 deletions(-)
> 
> diff --git a/Documentation/admin-guide/cgroup-v1/memory.rst b/Documentation/admin-guide/cgroup-v1/memory.rst
> index 52688ae34461..cb993d80194d 100644
> --- a/Documentation/admin-guide/cgroup-v1/memory.rst
> +++ b/Documentation/admin-guide/cgroup-v1/memory.rst
> @@ -87,10 +87,8 @@ Brief summary of control files.
>   memory.oom_control		     set/show oom controls.
>   memory.numa_stat		     show the number of memory usage per numa
>  				     node
> - memory.kmem.limit_in_bytes          set/show hard limit for kernel memory
> -                                     This knob is deprecated and shouldn't be
> -                                     used. It is planned that this be removed in
> -                                     the foreseeable future.
> + memory.kmem.limit_in_bytes          This knob is deprecated and writing to
> +                                     it will return -EINVAL.
>   memory.kmem.usage_in_bytes          show current kernel memory allocation
>   memory.kmem.failcnt                 show the number of kernel memory usage
>  				     hits limits
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 45465c03a8d7..78d17b3181ad 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -3075,28 +3075,14 @@ static void memcg_free_cache_id(int id)
>  int __memcg_kmem_charge(struct mem_cgroup *memcg, gfp_t gfp,
>  			unsigned int nr_pages)
>  {
> -	struct page_counter *counter;
>  	int ret;
>  
>  	ret = try_charge(memcg, gfp, nr_pages);
>  	if (ret)
>  		return ret;
>  
> -	if (!cgroup_subsys_on_dfl(memory_cgrp_subsys) &&
> -	    !page_counter_try_charge(&memcg->kmem, nr_pages, &counter)) {
> -
> -		/*
> -		 * Enforce __GFP_NOFAIL allocation because callers are not
> -		 * prepared to see failures and likely do not have any failure
> -		 * handling code.
> -		 */
> -		if (gfp & __GFP_NOFAIL) {
> -			page_counter_charge(&memcg->kmem, nr_pages);
> -			return 0;
> -		}
> -		cancel_charge(memcg, nr_pages);
> -		return -ENOMEM;
> -	}
> +	if (!cgroup_subsys_on_dfl(memory_cgrp_subsys))
> +		page_counter_charge(&memcg->kmem, nr_pages);
>  	return 0;
>  }
>  
> @@ -3769,17 +3755,6 @@ static void memcg_free_kmem(struct mem_cgroup *memcg)
>  }
>  #endif /* CONFIG_MEMCG_KMEM */
>  
> -static int memcg_update_kmem_max(struct mem_cgroup *memcg,
> -				 unsigned long max)
> -{
> -	int ret;
> -
> -	mutex_lock(&memcg_max_mutex);
> -	ret = page_counter_set_max(&memcg->kmem, max);
> -	mutex_unlock(&memcg_max_mutex);
> -	return ret;
> -}
> -
>  static int memcg_update_tcp_max(struct mem_cgroup *memcg, unsigned long max)
>  {
>  	int ret;
> @@ -3845,10 +3820,8 @@ static ssize_t mem_cgroup_write(struct kernfs_open_file *of,
>  			ret = mem_cgroup_resize_max(memcg, nr_pages, true);
>  			break;
>  		case _KMEM:
> -			pr_warn_once("kmem.limit_in_bytes is deprecated and will be removed. "
> -				     "Please report your usecase to linux-mm@kvack.org if you "
> -				     "depend on this functionality.\n");
> -			ret = memcg_update_kmem_max(memcg, nr_pages);
> +			/* kmem.limit_in_bytes is deprecated. */
> +			ret = -EINVAL;
>  			break;
>  		case _TCP:
>  			ret = memcg_update_tcp_max(memcg, nr_pages);
> -- 
> 2.29.2.299.gdc1121823c-goog

-- 
Michal Hocko
SUSE Labs
