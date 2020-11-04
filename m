Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21DB62A5FBC
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 09:38:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728522AbgKDIht (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 03:37:49 -0500
Received: from mx2.suse.de ([195.135.220.15]:35730 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725891AbgKDIht (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 03:37:49 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1604479067;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BXrxwtWFFGW7i/sPKc1/C4GjAg2pI7UBPBtCX2IYUyE=;
        b=MYvVUJnm+tNlx3UXq+8sbVOeL2l73sBl73vL9fypAofxexuto3g5+dYsmPK4uUW9JUxW/R
        fSZrKwc/dTm6iMShibichmjZgf3MQNAhO+QkKeSNsG2dkiNfJyi4gV7Jq0XjxLQXB0NTnv
        ILWkNzB/DEQlbrKQUPQtrzDyeFM+KSI=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 6B7E9ACBF;
        Wed,  4 Nov 2020 08:37:47 +0000 (UTC)
Date:   Wed, 4 Nov 2020 09:37:46 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Roman Gushchin <guro@fb.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH rfc 1/3] mm: memcg: deprecate the non-hierarchical mode
Message-ID: <20201104083746.GC10052@dhcp22.suse.cz>
References: <20201103212725.3716088-1-guro@fb.com>
 <20201103212725.3716088-2-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201103212725.3716088-2-guro@fb.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 03-11-20 13:27:23, Roman Gushchin wrote:
> The non-hierarchical cgroup v1 mode is a legacy of early days
> of the memory controller and doesn't bring any value today.

This is a bold statement ;)
All that we know today is that we have a warning in place to complain
loudly when somebody relies on use_hierarchy=0 with a deeper
hierarchy. For all those years we have seen _zero_ reports that would
describe a sensible usecase.
Moreover we (SUSE) have backported this warning into old distribution
kernels (since 3.0 based kernels) to extend the coverage and didn't hear
even for users who adopt new kernels only very slowly. The only report
we have seen so far was a LTP test suite which doesn't really reflect
any real life usecase.

Feel free to reuse the above in the changelog.

> However, it complicates the code and creates many edge cases
> all over the memory controller code.
> 
> It's a good time to deprecate it completely.
> 
> Functionally this patch enabled is by default for all cgroups
> and forbids switching it off. Nothing changes if cgroup v2 is used:
> hierarchical mode was enforced from scratch.
> 
> To protect the ABI memory.use_hierarchy interface is preserved
> with a limited functionality: reading always returns "1", writing
> of "1" passes silently, writing of any other value fails with
> -EINVAL and a warning to dmesg (on the first occasion).

Yes, that makes sense.
 
> Signed-off-by: Roman Gushchin <guro@fb.com>

I do not see any problems with the patch or any left overs behind
(except for the documentation which you handle in the follow up
patches).

Acked-by: Michal Hocko <mhocko@suse.com>

Thanks and let's see whether some last minute usecase show up.

> ---
>  include/linux/memcontrol.h |  7 ---
>  kernel/cgroup/cgroup.c     |  5 ---
>  mm/memcontrol.c            | 90 ++++++--------------------------------
>  3 files changed, 13 insertions(+), 89 deletions(-)
> 
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 0f4dd7829fb2..31000929db4b 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -234,11 +234,6 @@ struct mem_cgroup {
>  	/* vmpressure notifications */
>  	struct vmpressure vmpressure;
>  
> -	/*
> -	 * Should the accounting and control be hierarchical, per subtree?
> -	 */
> -	bool use_hierarchy;
> -
>  	/*
>  	 * Should the OOM killer kill all belonging tasks, had it kill one?
>  	 */
> @@ -758,8 +753,6 @@ static inline bool mem_cgroup_is_descendant(struct mem_cgroup *memcg,
>  {
>  	if (root == memcg)
>  		return true;
> -	if (!root->use_hierarchy)
> -		return false;
>  	return cgroup_is_descendant(memcg->css.cgroup, root->css.cgroup);
>  }
>  
> diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
> index f2eeff74d713..621a586e3529 100644
> --- a/kernel/cgroup/cgroup.c
> +++ b/kernel/cgroup/cgroup.c
> @@ -281,9 +281,6 @@ bool cgroup_ssid_enabled(int ssid)
>   * - cpuset: a task can be moved into an empty cpuset, and again it takes
>   *   masks of ancestors.
>   *
> - * - memcg: use_hierarchy is on by default and the cgroup file for the flag
> - *   is not created.
> - *
>   * - blkcg: blk-throttle becomes properly hierarchical.
>   *
>   * - debug: disallowed on the default hierarchy.
> @@ -5156,8 +5153,6 @@ static struct cgroup_subsys_state *css_create(struct cgroup *cgrp,
>  	    cgroup_parent(parent)) {
>  		pr_warn("%s (%d) created nested cgroup for controller \"%s\" which has incomplete hierarchy support. Nested cgroups may change behavior in the future.\n",
>  			current->comm, current->pid, ss->name);
> -		if (!strcmp(ss->name, "memory"))
> -			pr_warn("\"memory\" requires setting use_hierarchy to 1 on the root\n");
>  		ss->warned_broken_hierarchy = true;
>  	}
>  
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 4b0cd4b78d47..2a37785e9abd 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -1127,12 +1127,6 @@ struct mem_cgroup *mem_cgroup_iter(struct mem_cgroup *root,
>  	if (prev && !reclaim)
>  		pos = prev;
>  
> -	if (!root->use_hierarchy && root != root_mem_cgroup) {
> -		if (prev)
> -			goto out;
> -		return root;
> -	}
> -
>  	rcu_read_lock();
>  
>  	if (reclaim) {
> @@ -1212,7 +1206,6 @@ struct mem_cgroup *mem_cgroup_iter(struct mem_cgroup *root,
>  
>  out_unlock:
>  	rcu_read_unlock();
> -out:
>  	if (prev && prev != root)
>  		css_put(&prev->css);
>  
> @@ -3440,10 +3433,7 @@ unsigned long mem_cgroup_soft_limit_reclaim(pg_data_t *pgdat, int order,
>  }
>  
>  /*
> - * Test whether @memcg has children, dead or alive.  Note that this
> - * function doesn't care whether @memcg has use_hierarchy enabled and
> - * returns %true if there are child csses according to the cgroup
> - * hierarchy.  Testing use_hierarchy is the caller's responsibility.
> + * Test whether @memcg has children, dead or alive.
>   */
>  static inline bool memcg_has_children(struct mem_cgroup *memcg)
>  {
> @@ -3503,37 +3493,20 @@ static ssize_t mem_cgroup_force_empty_write(struct kernfs_open_file *of,
>  static u64 mem_cgroup_hierarchy_read(struct cgroup_subsys_state *css,
>  				     struct cftype *cft)
>  {
> -	return mem_cgroup_from_css(css)->use_hierarchy;
> +	return 1;
>  }
>  
>  static int mem_cgroup_hierarchy_write(struct cgroup_subsys_state *css,
>  				      struct cftype *cft, u64 val)
>  {
> -	int retval = 0;
> -	struct mem_cgroup *memcg = mem_cgroup_from_css(css);
> -	struct mem_cgroup *parent_memcg = mem_cgroup_from_css(memcg->css.parent);
> -
> -	if (memcg->use_hierarchy == val)
> +	if (val == 1)
>  		return 0;
>  
> -	/*
> -	 * If parent's use_hierarchy is set, we can't make any modifications
> -	 * in the child subtrees. If it is unset, then the change can
> -	 * occur, provided the current cgroup has no children.
> -	 *
> -	 * For the root cgroup, parent_mem is NULL, we allow value to be
> -	 * set if there are no children.
> -	 */
> -	if ((!parent_memcg || !parent_memcg->use_hierarchy) &&
> -				(val == 1 || val == 0)) {
> -		if (!memcg_has_children(memcg))
> -			memcg->use_hierarchy = val;
> -		else
> -			retval = -EBUSY;
> -	} else
> -		retval = -EINVAL;
> +	pr_warn_once("Non-hierarchical mode is deprecated. "
> +		     "Please report your usecase to linux-mm@kvack.org if you "
> +		     "depend on this functionality.\n");
>  
> -	return retval;
> +	return -EINVAL;
>  }
>  
>  static unsigned long mem_cgroup_usage(struct mem_cgroup *memcg, bool swap)
> @@ -3727,8 +3700,6 @@ static void memcg_offline_kmem(struct mem_cgroup *memcg)
>  		child = mem_cgroup_from_css(css);
>  		BUG_ON(child->kmemcg_id != kmemcg_id);
>  		child->kmemcg_id = parent->kmemcg_id;
> -		if (!memcg->use_hierarchy)
> -			break;
>  	}
>  	rcu_read_unlock();
>  
> @@ -5319,38 +5290,22 @@ mem_cgroup_css_alloc(struct cgroup_subsys_state *parent_css)
>  	if (parent) {
>  		memcg->swappiness = mem_cgroup_swappiness(parent);
>  		memcg->oom_kill_disable = parent->oom_kill_disable;
> -	}
> -	if (!parent) {
> -		page_counter_init(&memcg->memory, NULL);
> -		page_counter_init(&memcg->swap, NULL);
> -		page_counter_init(&memcg->kmem, NULL);
> -		page_counter_init(&memcg->tcpmem, NULL);
> -	} else if (parent->use_hierarchy) {
> -		memcg->use_hierarchy = true;
> +
>  		page_counter_init(&memcg->memory, &parent->memory);
>  		page_counter_init(&memcg->swap, &parent->swap);
>  		page_counter_init(&memcg->kmem, &parent->kmem);
>  		page_counter_init(&memcg->tcpmem, &parent->tcpmem);
>  	} else {
> -		page_counter_init(&memcg->memory, &root_mem_cgroup->memory);
> -		page_counter_init(&memcg->swap, &root_mem_cgroup->swap);
> -		page_counter_init(&memcg->kmem, &root_mem_cgroup->kmem);
> -		page_counter_init(&memcg->tcpmem, &root_mem_cgroup->tcpmem);
> -		/*
> -		 * Deeper hierachy with use_hierarchy == false doesn't make
> -		 * much sense so let cgroup subsystem know about this
> -		 * unfortunate state in our controller.
> -		 */
> -		if (parent != root_mem_cgroup)
> -			memory_cgrp_subsys.broken_hierarchy = true;
> -	}
> +		page_counter_init(&memcg->memory, NULL);
> +		page_counter_init(&memcg->swap, NULL);
> +		page_counter_init(&memcg->kmem, NULL);
> +		page_counter_init(&memcg->tcpmem, NULL);
>  
> -	/* The following stuff does not apply to the root */
> -	if (!parent) {
>  		root_mem_cgroup = memcg;
>  		return &memcg->css;
>  	}
>  
> +	/* The following stuff does not apply to the root */
>  	error = memcg_online_kmem(memcg);
>  	if (error)
>  		goto fail;
> @@ -6187,24 +6142,6 @@ static void mem_cgroup_move_task(void)
>  }
>  #endif
>  
> -/*
> - * Cgroup retains root cgroups across [un]mount cycles making it necessary
> - * to verify whether we're attached to the default hierarchy on each mount
> - * attempt.
> - */
> -static void mem_cgroup_bind(struct cgroup_subsys_state *root_css)
> -{
> -	/*
> -	 * use_hierarchy is forced on the default hierarchy.  cgroup core
> -	 * guarantees that @root doesn't have any children, so turning it
> -	 * on for the root memcg is enough.
> -	 */
> -	if (cgroup_subsys_on_dfl(memory_cgrp_subsys))
> -		root_mem_cgroup->use_hierarchy = true;
> -	else
> -		root_mem_cgroup->use_hierarchy = false;
> -}
> -
>  static int seq_puts_memcg_tunable(struct seq_file *m, unsigned long value)
>  {
>  	if (value == PAGE_COUNTER_MAX)
> @@ -6542,7 +6479,6 @@ struct cgroup_subsys memory_cgrp_subsys = {
>  	.can_attach = mem_cgroup_can_attach,
>  	.cancel_attach = mem_cgroup_cancel_attach,
>  	.post_attach = mem_cgroup_move_task,
> -	.bind = mem_cgroup_bind,
>  	.dfl_cftypes = memory_files,
>  	.legacy_cftypes = mem_cgroup_legacy_files,
>  	.early_init = 0,
> -- 
> 2.26.2

-- 
Michal Hocko
SUSE Labs
