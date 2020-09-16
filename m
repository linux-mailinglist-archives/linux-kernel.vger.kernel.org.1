Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C47526BED9
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 10:11:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726438AbgIPILP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 04:11:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726068AbgIPILM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 04:11:12 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89D99C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 01:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Mp7kNPDyqWwplraoK0gqQ2HI42Y/k4k6SwtQAUL0cLs=; b=ZsKOyPFsoDeyUDWHUmm+CnzZpt
        0b96zoqCrKymqAOXDI6sRABxNfDJEEj9jxhe/aIgYBA6UApvJMxP8VKPJF5Cg2nI2+Bs/5YvZlraH
        NrfAYU76qUwuoUgw6ACoeeLY4GtP1hA6Atg5PgsTzfrReEeGDr1fs7id9xFCmiFTclDaELsGuoK7T
        L2iTsZ2+L46Tr9Jno25zH0sQ/VFkmeCckMHSSffZvDqRKqGb6VgfblqyNTq+2c02DEb9kfAt5yyzw
        B6dzk8VxwFt949FHL12IV0tvfK/G0qhKwUnXOxo4li841Q9lwsdEYPcEnIr6qmIj/IWChojBifn8x
        9xpyz+zQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kISWj-0005g0-Jv; Wed, 16 Sep 2020 08:10:53 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 407223012C3;
        Wed, 16 Sep 2020 10:10:52 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 22A132C32F829; Wed, 16 Sep 2020 10:10:52 +0200 (CEST)
Date:   Wed, 16 Sep 2020 10:10:52 +0200
From:   peterz@infradead.org
To:     Huang Ying <ying.huang@intel.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>, Mel Gorman <mgorman@suse.de>,
        Rik van Riel <riel@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>,
        David Rientjes <rientjes@google.com>
Subject: Re: [RFC] autonuma: Migrate on fault among multiple bound nodes
Message-ID: <20200916081052.GI2674@hirez.programming.kicks-ass.net>
References: <20200916005936.232788-1-ying.huang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200916005936.232788-1-ying.huang@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 16, 2020 at 08:59:36AM +0800, Huang Ying wrote:

> So in this patch, if MPOL_BIND is used to bind the memory of the
> application to multiple nodes, and in the hint page fault handler both
> the faulting page node and the accessing node are in the policy
> nodemask, the page will be tried to be migrated to the accessing node
> to reduce the cross-node accessing.

Seems fair enough..

> Questions:
> 
> Sysctl knob kernel.numa_balancing can enable/disable AutoNUMA
> optimizing globally.  And now, it appears that the explicit NUMA
> memory policy specifying (e.g. via numactl, mbind(), etc.) acts like
> an implicit per-thread/VMA knob to enable/disable the AutoNUMA
> optimizing for the thread/VMA.  Although this looks like a side effect
> instead of an API, from commit fc3147245d19 ("mm: numa: Limit NUMA
> scanning to migrate-on-fault VMAs"), this is used by some users?  So
> the question is, do we need an explicit per-thread/VMA knob to
> enable/disable AutoNUMA optimizing for the thread/VMA?  Or just use
> the global knob, either optimize all thread/VMAs as long as the
> explicitly specified memory policies are respected, or don't optimize
> at all.

I don't understand the question; that commit is not about disabling numa
balancing, it's about avoiding pointless work and overhead. What's the
point of scanning memory if you're not going to be allowed to move it
anyway.

> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Mel Gorman <mgorman@suse.de>
> Cc: Rik van Riel <riel@redhat.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> Cc: Dave Hansen <dave.hansen@intel.com>
> Cc: Andi Kleen <ak@linux.intel.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: David Rientjes <rientjes@google.com>
> ---
>  mm/mempolicy.c | 43 +++++++++++++++++++++++++++++++------------
>  1 file changed, 31 insertions(+), 12 deletions(-)
> 
> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> index eddbe4e56c73..a941eab2de24 100644
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -1827,6 +1827,13 @@ static struct mempolicy *get_vma_policy(struct vm_area_struct *vma,
>  	return pol;
>  }
>  
> +static bool mpol_may_mof(struct mempolicy *pol)
> +{
> +	/* May migrate among bound nodes for MPOL_BIND */
> +	return pol->flags & MPOL_F_MOF ||
> +		(pol->mode == MPOL_BIND && nodes_weight(pol->v.nodes) > 1);
> +}

This is weird, why not just set F_MOF on the policy?

In fact, why wouldn't something like:

  mbind(.mode=MPOL_BIND, .flags=MPOL_MF_LAZY);

work today? Afaict MF_LAZY will unconditionally result in M_MOF.

> @@ -2494,20 +2503,30 @@ int mpol_misplaced(struct page *page, struct vm_area_struct *vma, unsigned long
>  		break;
>  
>  	case MPOL_BIND:
>  		/*
> +		 * Allows binding to multiple nodes.  If both current and
> +		 * accessing nodes are in policy nodemask, migrate to
> +		 * accessing node to optimize page placement. Otherwise,
> +		 * use current page if in policy nodemask or MPOL_F_MOF not
> +		 * set, else select nearest allowed node, if any.  If no
> +		 * allowed nodes, use current [!misplaced].
>  		 */
> +		if (node_isset(curnid, pol->v.nodes)) {
> +			if (node_isset(thisnid, pol->v.nodes)) {
> +				moron = true;
> +				polnid = thisnid;
> +			} else {
> +				goto out;
> +			}
> +		} else if (!(pol->flags & MPOL_F_MOF)) {
>  			goto out;
> +		} else {
> +			z = first_zones_zonelist(
>  				node_zonelist(numa_node_id(), GFP_HIGHUSER),
>  				gfp_zone(GFP_HIGHUSER),
>  				&pol->v.nodes);
> +			polnid = zone_to_nid(z->zone);
> +		}
>  		break;
>  
>  	default:

Did that want to be this instead? I don't think I follow the other
changes.

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index eddbe4e56c73..2a64913f9ac6 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -2501,8 +2501,11 @@ int mpol_misplaced(struct page *page, struct vm_area_struct *vma, unsigned long
 		 * else select nearest allowed node, if any.
 		 * If no allowed nodes, use current [!misplaced].
 		 */
-		if (node_isset(curnid, pol->v.nodes))
+		if (node_isset(curnid, pol->v.nodes)) {
+			if (node_isset(thisnod, pol->v.nodes))
+				goto moron;
 			goto out;
+		}
 		z = first_zones_zonelist(
 				node_zonelist(numa_node_id(), GFP_HIGHUSER),
 				gfp_zone(GFP_HIGHUSER),
@@ -2516,6 +2519,7 @@ int mpol_misplaced(struct page *page, struct vm_area_struct *vma, unsigned long
 
 	/* Migrate the page towards the node whose CPU is referencing it */
 	if (pol->flags & MPOL_F_MORON) {
+moron:
 		polnid = thisnid;
 
 		if (!should_numa_migrate_memory(current, page, curnid, thiscpu))

