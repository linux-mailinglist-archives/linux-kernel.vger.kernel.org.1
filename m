Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 590C1274278
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 14:52:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbgIVMwF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 08:52:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46101 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726566AbgIVMwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 08:52:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600779120;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mzF2SsHUb3UjWmBZrtDmWdBk/7nlXgiRIsvkXf0DAaI=;
        b=e8ScccpqfV6R5va+u9CzHjJqjARniMMvOVjIgGVRRMFSBFKWfBjM6Nposk5shrouGbF7h1
        7hh9Q+2IrsUfUNwbIADeZ9kmOWAu3gF136MDzShVZXj1Br7W9lvsCwKrjuB7iW49QeGCBG
        j+TUZW47XlkWuA1Mp8LuxDlI+mEtudw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-39-rO_3mtOtMJ6jT1OnKmE6PA-1; Tue, 22 Sep 2020 08:51:58 -0400
X-MC-Unique: rO_3mtOtMJ6jT1OnKmE6PA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7BE7A56C21;
        Tue, 22 Sep 2020 12:51:56 +0000 (UTC)
Received: from lorien.usersys.redhat.com (ovpn-113-73.phx2.redhat.com [10.3.113.73])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id EE06C55780;
        Tue, 22 Sep 2020 12:51:54 +0000 (UTC)
Date:   Tue, 22 Sep 2020 08:51:53 -0400
From:   Phil Auld <pauld@redhat.com>
To:     Huang Ying <ying.huang@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>, Mel Gorman <mgorman@suse.de>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>,
        David Rientjes <rientjes@google.com>
Subject: Re: [RFC -V2] autonuma: Migrate on fault among multiple bound nodes
Message-ID: <20200922125049.GA10420@lorien.usersys.redhat.com>
References: <20200922065401.376348-1-ying.huang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200922065401.376348-1-ying.huang@intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Sep 22, 2020 at 02:54:01PM +0800 Huang Ying wrote:
> Now, AutoNUMA can only optimize the page placement among the NUMA nodes if the
> default memory policy is used.  Because the memory policy specified explicitly
> should take precedence.  But this seems too strict in some situations.  For
> example, on a system with 4 NUMA nodes, if the memory of an application is bound
> to the node 0 and 1, AutoNUMA can potentially migrate the pages between the node
> 0 and 1 to reduce cross-node accessing without breaking the explicit memory
> binding policy.
> 
> So in this patch, if mbind(.mode=MPOL_BIND, .flags=MPOL_MF_LAZY) is used to bind
> the memory of the application to multiple nodes, and in the hint page fault
> handler both the faulting page node and the accessing node are in the policy
> nodemask, the page will be tried to be migrated to the accessing node to reduce
> the cross-node accessing.
>

Do you have any performance numbers that show the effects of this on
a workload?


> [Peter Zijlstra: provided the simplified implementation method.]
> 
> Questions:
> 
> Sysctl knob kernel.numa_balancing can enable/disable AutoNUMA optimizing
> globally.  But for the memory areas that are bound to multiple NUMA nodes, even
> if the AutoNUMA is enabled globally via the sysctl knob, we still need to enable
> AutoNUMA again with a special flag.  Why not just optimize the page placement if
> possible as long as AutoNUMA is enabled globally?  The interface would look
> simpler with that.


I agree. I think it should try to do this if globally enabled.


> 
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
>  mm/mempolicy.c | 17 +++++++++++------
>  1 file changed, 11 insertions(+), 6 deletions(-)
> 
> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> index eddbe4e56c73..273969204732 100644
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -2494,15 +2494,19 @@ int mpol_misplaced(struct page *page, struct vm_area_struct *vma, unsigned long
>  		break;
>  
>  	case MPOL_BIND:
> -
>  		/*
> -		 * allows binding to multiple nodes.
> -		 * use current page if in policy nodemask,
> -		 * else select nearest allowed node, if any.
> -		 * If no allowed nodes, use current [!misplaced].
> +		 * Allows binding to multiple nodes.  If both current and
> +		 * accessing nodes are in policy nodemask, migrate to
> +		 * accessing node to optimize page placement. Otherwise,
> +		 * use current page if in policy nodemask, else select
> +		 * nearest allowed node, if any.  If no allowed nodes, use
> +		 * current [!misplaced].
>  		 */
> -		if (node_isset(curnid, pol->v.nodes))
> +		if (node_isset(curnid, pol->v.nodes)) {
> +			if (node_isset(thisnid, pol->v.nodes))
> +				goto moron;

Nice label :)

>  			goto out;
> +		}
>  		z = first_zones_zonelist(
>  				node_zonelist(numa_node_id(), GFP_HIGHUSER),
>  				gfp_zone(GFP_HIGHUSER),
> @@ -2516,6 +2520,7 @@ int mpol_misplaced(struct page *page, struct vm_area_struct *vma, unsigned long
>  
>  	/* Migrate the page towards the node whose CPU is referencing it */
>  	if (pol->flags & MPOL_F_MORON) {
> +moron:
>  		polnid = thisnid;
>  
>  		if (!should_numa_migrate_memory(current, page, curnid, thiscpu))
> -- 
> 2.28.0
> 


Cheers,
Phil

-- 

