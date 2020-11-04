Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77F102A5EAD
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 08:24:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727878AbgKDHYC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 02:24:02 -0500
Received: from mx2.suse.de ([195.135.220.15]:43032 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726844AbgKDHYB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 02:24:01 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1604474639;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OK0FZn90g9JpV5gR2O6XfhHvi8GUcnni/4Q8pn9floU=;
        b=GOB62Jig4L8wlauPoQXR594Uc6r/8k6uf12PyG5QjXIX9ao5o5oyn0354rKXILJbNCZ0Ku
        5BWYgqAzSBVJF+tsVnchGWcHlulluAW/Ounu0wypWPuXlZ3oMNmBJLeJGFB1GyYSgpxtKx
        RzYclGwOK9EObRv3JwoutI/2AFPYc38=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 99304AC8C;
        Wed,  4 Nov 2020 07:23:59 +0000 (UTC)
Date:   Wed, 4 Nov 2020 08:23:58 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Feng Tang <feng.tang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>, dave.hansen@intel.com,
        ying.huang@intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 2/2] mm, page_alloc: loose the node binding check to
 avoid helpless oom killing
Message-ID: <20201104072358.GP21990@dhcp22.suse.cz>
References: <1604470210-124827-1-git-send-email-feng.tang@intel.com>
 <1604470210-124827-3-git-send-email-feng.tang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1604470210-124827-3-git-send-email-feng.tang@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 04-11-20 14:10:10, Feng Tang wrote:
> With the incoming of memory hotplug feature and persitent memory, in
> some platform there are memory nodes which only have movable zone.
> 
> Users may bind some of their workload(like docker/container) to
> these nodes, and there are many reports of OOM and page allocation
> failures, one callstack is:
> 
> 	[ 1387.877565] runc:[2:INIT] invoked oom-killer: gfp_mask=0x500cc2(GFP_HIGHUSER|__GFP_ACCOUNT), order=0, oom_score_adj=0
> 	[ 1387.877568] CPU: 8 PID: 8291 Comm: runc:[2:INIT] Tainted: G        W I E     5.8.2-0.g71b519a-default #1 openSUSE Tumbleweed (unreleased)
> 	[ 1387.877569] Hardware name: Dell Inc. PowerEdge R640/0PHYDR, BIOS 2.6.4 04/09/2020
> 	[ 1387.877570] Call Trace:
> 	[ 1387.877579]  dump_stack+0x6b/0x88
> 	[ 1387.877584]  dump_header+0x4a/0x1e2
> 	[ 1387.877586]  oom_kill_process.cold+0xb/0x10
> 	[ 1387.877588]  out_of_memory.part.0+0xaf/0x230
> 	[ 1387.877591]  out_of_memory+0x3d/0x80
> 	[ 1387.877595]  __alloc_pages_slowpath.constprop.0+0x954/0xa20
> 	[ 1387.877599]  __alloc_pages_nodemask+0x2d3/0x300
> 	[ 1387.877602]  pipe_write+0x322/0x590
> 	[ 1387.877607]  new_sync_write+0x196/0x1b0
> 	[ 1387.877609]  vfs_write+0x1c3/0x1f0
> 	[ 1387.877611]  ksys_write+0xa7/0xe0
> 	[ 1387.877617]  do_syscall_64+0x52/0xd0
> 	[ 1387.877621]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> 
> In a full container run, like installing and running the stress tool
> "stress-ng", there are many different kinds of page requests (gfp_masks),
> many of which only allow non-movable zones. Some of them can fall back
> to other nodes with NORMAL/DMA32/DMA zones, but others are blocked by
> the __GFP_HARDWALL or ALLOC_CPUSET check, and cause OOM killing. But
> OOM killing won't do any help here, as this is not an issue of lack of
> free memory, but simply blocked by the node binding policy check.
> 
> So loose the policy check for this case.

This allows to spill memory allocations over to any other node which has
Normal (or other lower) zones and as such it breaks cpuset isolation. As
I've pointed out in the reply to your cover letter it seems that this is
more of a misconfiguration than a bug.

I do understand that killing any other task which can allocate from this
node is quite goofy and that is something we can detect and better
target. E.g. fail the allocation or kill the allocating context when the
allocation request cannot be satisfied by no means. But breaking the
node isolation which is a user contract sounds like a bad workaround.
Binding to a movable node(s) without any other fallback is simply
something you shouldn't do.

> Signed-off-by: Feng Tang <feng.tang@intel.com>
> ---
>  mm/page_alloc.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index d772206..efd49a9 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -4669,6 +4669,28 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
>  	if (!ac->preferred_zoneref->zone)
>  		goto nopage;
>  
> +	/*
> +	 * If the task's target memory nodes only has movable zones, while the
> +	 * gfp_mask allowed zone is lower than ZONE_MOVABLE, loose the check
> +	 * for __GFP_HARDWALL and ALLOC_CPUSET, otherwise it could trigger OOM
> +	 * killing, which still can not solve this policy check.
> +	 */
> +	if (ac->highest_zoneidx <= ZONE_NORMAL) {
> +		int nid;
> +		unsigned long unmovable = 0;
> +
> +		/* FIXME: this could be a separate function */
> +		for_each_node_mask(nid, cpuset_current_mems_allowed) {
> +			unmovable += NODE_DATA(nid)->node_present_pages -
> +				NODE_DATA(nid)->node_zones[ZONE_MOVABLE].present_pages;
> +		}
> +
> +		if (!unmovable) {
> +			gfp_mask &= ~(__GFP_HARDWALL);
> +			alloc_flags &= ~ALLOC_CPUSET;
> +		}
> +	}
> +
>  	if (alloc_flags & ALLOC_KSWAPD)
>  		wake_all_kswapds(order, gfp_mask, ac);
>  
> -- 
> 2.7.4
> 

-- 
Michal Hocko
SUSE Labs
