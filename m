Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3D1D2A5EA9
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 08:18:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729032AbgKDHSb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 02:18:31 -0500
Received: from mx2.suse.de ([195.135.220.15]:60470 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728494AbgKDHSb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 02:18:31 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1604474309;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=k+x5KwHlLohxp0Hlr5WDb5Law8fHA93CulDDqpCr6sM=;
        b=bisJcfYCgVZPvfi9lk2wCaGLnM2dpk6rGZl2paTg63tB0cQKo4RWbXVlxdG5uHEIzZs6S2
        3NghJ/Qfj/3I/ru0CSSI1f6zB07DBJaSukMo0PFJPlmlw4Zab5MqPEZM3BYXz/W1p4mEfi
        Yw3NYvASG6cDCsppOpBYcIwUzOzGbms=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id ACE70AC65;
        Wed,  4 Nov 2020 07:18:29 +0000 (UTC)
Date:   Wed, 4 Nov 2020 08:18:28 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Feng Tang <feng.tang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>, dave.hansen@intel.com,
        ying.huang@intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/2] mm, oom: dump meminfo for all memory nodes
Message-ID: <20201104071828.GO21990@dhcp22.suse.cz>
References: <1604470210-124827-1-git-send-email-feng.tang@intel.com>
 <1604470210-124827-2-git-send-email-feng.tang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1604470210-124827-2-git-send-email-feng.tang@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 04-11-20 14:10:09, Feng Tang wrote:
> In some OOM cases, if there is memory node binding(current->mems_allowed
> is not NULL), system may only print the meminfo for these bound nodes,
> while other nodes' info could still be important for debugging.
> 
> For example on a platform with one normal node (has DMA/DMA32/NORMAL...
> zones) and one node which only has movable zone (either for memory hotplug
> case or a persistent memory node), some user will run docker while binding
> memory to the movable node. many memory allocations originated from the
> docker instance will fall back to the other node, and when a OOM happens,
> meminfo for both nodes are needed.
> 
> So extend the show_mem() to cover all memory nodes.

I do not like this change. The reason why we print only relevant numa
nodes is the size of the oom report. Also all other numa nodes are not
really relevant to the allocation so there is no real reason to print
their info. We used to do that in the past and decided that this is more
than suboptimal.

I do understand that this is a preliminary work for your later patch
which tweaks the node binding and so more numa nodes are eligible but
then I would propose to merge the two patches.
 
> Signed-off-by: Feng Tang <feng.tang@intel.com>
> ---
>  mm/oom_kill.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/oom_kill.c b/mm/oom_kill.c
> index 8b84661..601476cc 100644
> --- a/mm/oom_kill.c
> +++ b/mm/oom_kill.c
> @@ -462,7 +462,7 @@ static void dump_header(struct oom_control *oc, struct task_struct *p)
>  	if (is_memcg_oom(oc))
>  		mem_cgroup_print_oom_meminfo(oc->memcg);
>  	else {
> -		show_mem(SHOW_MEM_FILTER_NODES, oc->nodemask);
> +		show_mem(SHOW_MEM_FILTER_NODES, &node_states[N_MEMORY]);
>  		if (is_dump_unreclaim_slabs())
>  			dump_unreclaimable_slab();
>  	}
> -- 
> 2.7.4

-- 
Michal Hocko
SUSE Labs
