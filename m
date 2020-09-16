Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AE7226BFA3
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 10:46:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbgIPIqm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 04:46:42 -0400
Received: from mga11.intel.com ([192.55.52.93]:20004 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726161AbgIPIqk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 04:46:40 -0400
IronPort-SDR: uX/Gee+UP5pCO+yzjmeAgMyIumQzrqrJOYK9pUwBj31mL84B7VsmGW0gn61YD4aWeyLR6VRaLJ
 2xJIFqT6v1jw==
X-IronPort-AV: E=McAfee;i="6000,8403,9745"; a="156835735"
X-IronPort-AV: E=Sophos;i="5.76,432,1592895600"; 
   d="scan'208";a="156835735"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2020 01:46:40 -0700
IronPort-SDR: x1Kb3+pCkKLuTJHZu4s9JgvNMpHiut9sXRkmv6enea3P3C6+xp9WDokcsDl+4HbVfN5/PWk0vh
 JsId+mfoikBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,432,1592895600"; 
   d="scan'208";a="331588621"
Received: from yhuang-dev.sh.intel.com (HELO yhuang-dev) ([10.239.159.164])
  by fmsmga004.fm.intel.com with ESMTP; 16 Sep 2020 01:46:37 -0700
From:   "Huang\, Ying" <ying.huang@intel.com>
To:     peterz@infradead.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>, Mel Gorman <mgorman@suse.de>,
        Rik van Riel <riel@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "Matthew Wilcox \(Oracle\)" <willy@infradead.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>,
        David Rientjes <rientjes@google.com>
Subject: Re: [RFC] autonuma: Migrate on fault among multiple bound nodes
References: <20200916005936.232788-1-ying.huang@intel.com>
        <20200916081052.GI2674@hirez.programming.kicks-ass.net>
Date:   Wed, 16 Sep 2020 16:46:37 +0800
In-Reply-To: <20200916081052.GI2674@hirez.programming.kicks-ass.net>
        (peterz@infradead.org's message of "Wed, 16 Sep 2020 10:10:52 +0200")
Message-ID: <87pn6mrtw2.fsf@yhuang-dev.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Peter,

Thanks for comments!

peterz@infradead.org writes:

> On Wed, Sep 16, 2020 at 08:59:36AM +0800, Huang Ying wrote:
>
>> So in this patch, if MPOL_BIND is used to bind the memory of the
>> application to multiple nodes, and in the hint page fault handler both
>> the faulting page node and the accessing node are in the policy
>> nodemask, the page will be tried to be migrated to the accessing node
>> to reduce the cross-node accessing.
>
> Seems fair enough..
>
>> Questions:
>> 
>> Sysctl knob kernel.numa_balancing can enable/disable AutoNUMA
>> optimizing globally.  And now, it appears that the explicit NUMA
>> memory policy specifying (e.g. via numactl, mbind(), etc.) acts like
>> an implicit per-thread/VMA knob to enable/disable the AutoNUMA
>> optimizing for the thread/VMA.  Although this looks like a side effect
>> instead of an API, from commit fc3147245d19 ("mm: numa: Limit NUMA
>> scanning to migrate-on-fault VMAs"), this is used by some users?  So
>> the question is, do we need an explicit per-thread/VMA knob to
>> enable/disable AutoNUMA optimizing for the thread/VMA?  Or just use
>> the global knob, either optimize all thread/VMAs as long as the
>> explicitly specified memory policies are respected, or don't optimize
>> at all.
>
> I don't understand the question; that commit is not about disabling numa
> balancing, it's about avoiding pointless work and overhead. What's the
> point of scanning memory if you're not going to be allowed to move it
> anyway.

Because we are going to enable the moving, this makes scanning not
pointless, but may also introduce overhead.

>> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: Ingo Molnar <mingo@redhat.com>
>> Cc: Mel Gorman <mgorman@suse.de>
>> Cc: Rik van Riel <riel@redhat.com>
>> Cc: Johannes Weiner <hannes@cmpxchg.org>
>> Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
>> Cc: Dave Hansen <dave.hansen@intel.com>
>> Cc: Andi Kleen <ak@linux.intel.com>
>> Cc: Michal Hocko <mhocko@suse.com>
>> Cc: David Rientjes <rientjes@google.com>
>> ---
>>  mm/mempolicy.c | 43 +++++++++++++++++++++++++++++++------------
>>  1 file changed, 31 insertions(+), 12 deletions(-)
>> 
>> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
>> index eddbe4e56c73..a941eab2de24 100644
>> --- a/mm/mempolicy.c
>> +++ b/mm/mempolicy.c
>> @@ -1827,6 +1827,13 @@ static struct mempolicy *get_vma_policy(struct vm_area_struct *vma,
>>  	return pol;
>>  }
>>  
>> +static bool mpol_may_mof(struct mempolicy *pol)
>> +{
>> +	/* May migrate among bound nodes for MPOL_BIND */
>> +	return pol->flags & MPOL_F_MOF ||
>> +		(pol->mode == MPOL_BIND && nodes_weight(pol->v.nodes) > 1);
>> +}
>
> This is weird, why not just set F_MOF on the policy?
>
> In fact, why wouldn't something like:
>
>   mbind(.mode=MPOL_BIND, .flags=MPOL_MF_LAZY);
>
> work today? Afaict MF_LAZY will unconditionally result in M_MOF.

There are some subtle difference.

- LAZY appears unnecessary for the per-task memory policy via
  set_mempolicy().  While migrating among multiple bound nodes appears
  reasonable as a per-task memory policy.

- LAZY also means move the pages not on the bound nodes to the bound
  nodes if the memory is available.  Some users may want to do that only
  if should_numa_migrate_memory() returns true.

>> @@ -2494,20 +2503,30 @@ int mpol_misplaced(struct page *page, struct vm_area_struct *vma, unsigned long
>>  		break;
>>  
>>  	case MPOL_BIND:
>>  		/*
>> +		 * Allows binding to multiple nodes.  If both current and
>> +		 * accessing nodes are in policy nodemask, migrate to
>> +		 * accessing node to optimize page placement. Otherwise,
>> +		 * use current page if in policy nodemask or MPOL_F_MOF not
>> +		 * set, else select nearest allowed node, if any.  If no
>> +		 * allowed nodes, use current [!misplaced].
>>  		 */
>> +		if (node_isset(curnid, pol->v.nodes)) {
>> +			if (node_isset(thisnid, pol->v.nodes)) {
>> +				moron = true;
>> +				polnid = thisnid;
>> +			} else {
>> +				goto out;
>> +			}
>> +		} else if (!(pol->flags & MPOL_F_MOF)) {
>>  			goto out;
>> +		} else {
>> +			z = first_zones_zonelist(
>>  				node_zonelist(numa_node_id(), GFP_HIGHUSER),
>>  				gfp_zone(GFP_HIGHUSER),
>>  				&pol->v.nodes);
>> +			polnid = zone_to_nid(z->zone);
>> +		}
>>  		break;
>>  
>>  	default:
>
> Did that want to be this instead? I don't think I follow the other
> changes.
>
> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> index eddbe4e56c73..2a64913f9ac6 100644
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -2501,8 +2501,11 @@ int mpol_misplaced(struct page *page, struct vm_area_struct *vma, unsigned long
>  		 * else select nearest allowed node, if any.
>  		 * If no allowed nodes, use current [!misplaced].
>  		 */
> -		if (node_isset(curnid, pol->v.nodes))
> +		if (node_isset(curnid, pol->v.nodes)) {
> +			if (node_isset(thisnod, pol->v.nodes))
> +				goto moron;
>  			goto out;
> +		}
>  		z = first_zones_zonelist(
>  				node_zonelist(numa_node_id(), GFP_HIGHUSER),
>  				gfp_zone(GFP_HIGHUSER),
> @@ -2516,6 +2519,7 @@ int mpol_misplaced(struct page *page, struct vm_area_struct *vma, unsigned long
>  
>  	/* Migrate the page towards the node whose CPU is referencing it */
>  	if (pol->flags & MPOL_F_MORON) {
> +moron:
>  		polnid = thisnid;
>  
>  		if (!should_numa_migrate_memory(current, page, curnid, thiscpu))

Yes.  This looks better if we can just use F_MOF.

Best Regards,
Huang, Ying
