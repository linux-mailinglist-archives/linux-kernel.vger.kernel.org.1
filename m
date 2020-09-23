Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AF4A275065
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 07:44:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727011AbgIWFoT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 01:44:19 -0400
Received: from mga03.intel.com ([134.134.136.65]:42422 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726883AbgIWFoT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 01:44:19 -0400
IronPort-SDR: nHBUuQEVn+REe69ix/w6Y+RgMnAPAbaKWe9WX8iCsDzGziJLFhKKv3iEfSlil+0nxkxfWJCLiZ
 UBw4J3U9S0qA==
X-IronPort-AV: E=McAfee;i="6000,8403,9752"; a="160869434"
X-IronPort-AV: E=Sophos;i="5.77,293,1596524400"; 
   d="scan'208";a="160869434"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2020 22:44:16 -0700
IronPort-SDR: ecSZn7beoVqP/TqvZcl1OzTC3kykreZ5ip1xx5+wWc0Jw2P8qE+3tzgCOSM0m0R26e/CQZhdM9
 SEdPvw7ke0+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,293,1596524400"; 
   d="scan'208";a="347216154"
Received: from yhuang-dev.sh.intel.com (HELO yhuang-dev) ([10.239.159.164])
  by FMSMGA003.fm.intel.com with ESMTP; 22 Sep 2020 22:44:12 -0700
From:   "Huang\, Ying" <ying.huang@intel.com>
To:     Phil Auld <pauld@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>, Mel Gorman <mgorman@suse.de>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "Matthew Wilcox \(Oracle\)" <willy@infradead.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>,
        David Rientjes <rientjes@google.com>
Subject: Re: [RFC -V2] autonuma: Migrate on fault among multiple bound nodes
References: <20200922065401.376348-1-ying.huang@intel.com>
        <20200922125049.GA10420@lorien.usersys.redhat.com>
Date:   Wed, 23 Sep 2020 13:44:12 +0800
In-Reply-To: <20200922125049.GA10420@lorien.usersys.redhat.com> (Phil Auld's
        message of "Tue, 22 Sep 2020 08:51:53 -0400")
Message-ID: <87o8lxoxn7.fsf@yhuang-dev.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Phil Auld <pauld@redhat.com> writes:

> Hi,
>
> On Tue, Sep 22, 2020 at 02:54:01PM +0800 Huang Ying wrote:
>> Now, AutoNUMA can only optimize the page placement among the NUMA nodes if the
>> default memory policy is used.  Because the memory policy specified explicitly
>> should take precedence.  But this seems too strict in some situations.  For
>> example, on a system with 4 NUMA nodes, if the memory of an application is bound
>> to the node 0 and 1, AutoNUMA can potentially migrate the pages between the node
>> 0 and 1 to reduce cross-node accessing without breaking the explicit memory
>> binding policy.
>> 
>> So in this patch, if mbind(.mode=MPOL_BIND, .flags=MPOL_MF_LAZY) is used to bind
>> the memory of the application to multiple nodes, and in the hint page fault
>> handler both the faulting page node and the accessing node are in the policy
>> nodemask, the page will be tried to be migrated to the accessing node to reduce
>> the cross-node accessing.
>>
>
> Do you have any performance numbers that show the effects of this on
> a workload?

I have done some simple test to confirm that NUMA balancing works in the
target configuration.

As for performance numbers, it's exactly same as that of the original
NUMA balancing in a different configuration.  Between without memory
binding and with memory bound to all NUMA nodes.

>
>> [Peter Zijlstra: provided the simplified implementation method.]
>> 
>> Questions:
>> 
>> Sysctl knob kernel.numa_balancing can enable/disable AutoNUMA optimizing
>> globally.  But for the memory areas that are bound to multiple NUMA nodes, even
>> if the AutoNUMA is enabled globally via the sysctl knob, we still need to enable
>> AutoNUMA again with a special flag.  Why not just optimize the page placement if
>> possible as long as AutoNUMA is enabled globally?  The interface would look
>> simpler with that.
>
>
> I agree. I think it should try to do this if globally enabled.

Thanks!

>> 
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
>>  mm/mempolicy.c | 17 +++++++++++------
>>  1 file changed, 11 insertions(+), 6 deletions(-)
>> 
>> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
>> index eddbe4e56c73..273969204732 100644
>> --- a/mm/mempolicy.c
>> +++ b/mm/mempolicy.c
>> @@ -2494,15 +2494,19 @@ int mpol_misplaced(struct page *page, struct vm_area_struct *vma, unsigned long
>>  		break;
>>  
>>  	case MPOL_BIND:
>> -
>>  		/*
>> -		 * allows binding to multiple nodes.
>> -		 * use current page if in policy nodemask,
>> -		 * else select nearest allowed node, if any.
>> -		 * If no allowed nodes, use current [!misplaced].
>> +		 * Allows binding to multiple nodes.  If both current and
>> +		 * accessing nodes are in policy nodemask, migrate to
>> +		 * accessing node to optimize page placement. Otherwise,
>> +		 * use current page if in policy nodemask, else select
>> +		 * nearest allowed node, if any.  If no allowed nodes, use
>> +		 * current [!misplaced].
>>  		 */
>> -		if (node_isset(curnid, pol->v.nodes))
>> +		if (node_isset(curnid, pol->v.nodes)) {
>> +			if (node_isset(thisnid, pol->v.nodes))
>> +				goto moron;
>
> Nice label :)

OK.  Because quite some people pay attention to this.  I will rename all
"moron" to "mopron" as suggested by Matthew.  Although MPOL_F_MORON is
defined in include/uapi/linux/mempolicy.h, it is explicitly marked as
internal flags.

Best Regards,
Huang, Ying

>>  			goto out;
>> +		}
>>  		z = first_zones_zonelist(
>>  				node_zonelist(numa_node_id(), GFP_HIGHUSER),
>>  				gfp_zone(GFP_HIGHUSER),
>> @@ -2516,6 +2520,7 @@ int mpol_misplaced(struct page *page, struct vm_area_struct *vma, unsigned long
>>  
>>  	/* Migrate the page towards the node whose CPU is referencing it */
>>  	if (pol->flags & MPOL_F_MORON) {
>> +moron:
>>  		polnid = thisnid;
>>  
>>  		if (!should_numa_migrate_memory(current, page, curnid, thiscpu))
>> -- 
>> 2.28.0
>> 
>
>
> Cheers,
> Phil
