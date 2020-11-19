Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F3FC2B8B7B
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 07:18:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725944AbgKSGR0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 01:17:26 -0500
Received: from mga03.intel.com ([134.134.136.65]:48854 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725799AbgKSGR0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 01:17:26 -0500
IronPort-SDR: 3VHxOBo/3r9QhwtJQ9sywydYbDKQLH0nC7HblTFH2jj8DGzyn9Qv1qy2qDj0vph+B14SxqroCV
 Y0MuLUhMymFQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9809"; a="171337424"
X-IronPort-AV: E=Sophos;i="5.77,489,1596524400"; 
   d="scan'208";a="171337424"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2020 22:17:25 -0800
IronPort-SDR: OA95P/mumrFOyGLRic1vf16FHbcadOWffRt5CO8ri96UhVMHBr/VcrLrv/NJWsQ2+gT/AO/9Qz
 j+6IlsSSFIeg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,489,1596524400"; 
   d="scan'208";a="476686621"
Received: from yhuang-dev.sh.intel.com (HELO yhuang-dev) ([10.239.159.50])
  by orsmga004.jf.intel.com with ESMTP; 18 Nov 2020 22:17:22 -0800
From:   "Huang\, Ying" <ying.huang@intel.com>
To:     Mel Gorman <mgorman@suse.de>
Cc:     Peter Zijlstra <peterz@infradead.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        "Johannes Weiner" <hannes@cmpxchg.org>,
        "Matthew Wilcox \(Oracle\)" <willy@infradead.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>,
        David Rientjes <rientjes@google.com>
Subject: Re: [RFC -V5] autonuma: Migrate on fault among multiple bound nodes
References: <20201118051952.39097-1-ying.huang@intel.com>
        <20201118095637.GC3306@suse.de>
Date:   Thu, 19 Nov 2020 14:17:21 +0800
In-Reply-To: <20201118095637.GC3306@suse.de> (Mel Gorman's message of "Wed, 18
        Nov 2020 09:56:38 +0000")
Message-ID: <878saxvpji.fsf@yhuang-dev.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mel Gorman <mgorman@suse.de> writes:

> On Wed, Nov 18, 2020 at 01:19:52PM +0800, Huang Ying wrote:
>> Now, AutoNUMA can only optimize the page placement among the NUMA
>
> Note that the feature is referred to as NUMA_BALANCING in the kernel
> configs as AUTONUMA as it was first presented was not merged. The sysctl
> for it is kernel.numa_balancing as you already note. So use NUMAB or
> NUMA_BALANCING but not AUTONUMA because at least a new person grepping
> for NUMA_BALANCING or variants will find it where as autonuma only creeped
> into the powerpc arch code.

Sure.  Will change this.

>
> If exposing to userspace, the naming should definitely be consistent.
>
>> - sysctl knob numa_balancing can enable/disable the NUMA balancing
>>   globally.
>> 
>> - even if sysctl numa_balancing is enabled, the NUMA balancing will be
>>   disabled for the memory areas or applications with the explicit memory
>>   policy by default.
>> 
>> - MPOL_F_AUTONUMA can be used to enable the NUMA balancing for the
>>   applications when specifying the explicit memory policy.
>> 
>
> MPOL_F_NUMAB

Sure, will change it to MPOL_F_NUMA_BALANCING.

>> Various page placement optimization based on the NUMA balancing can be
>> done with these flags.  As the first step, in this patch, if the
>> memory of the application is bound to multiple nodes (MPOL_BIND), and
>> in the hint page fault handler the accessing node are in the policy
>> nodemask, the page will be tried to be migrated to the accessing node
>> to reduce the cross-node accessing.
>> 
>
> The patch still lacks supporting data. It really should have a basic
> benchmark of some sort serving as an example of how the policies should
> be set and a before/after comparison showing the throughput of MPOL_BIND
> accesses spanning 2 or more nodes is faster when numa balancing is enabled.

Sure.  Will add some basic benchmark data and usage example.

> A man page update should also be added clearly outlining when an
> application should consider using it with the linux-api people cc'd
> for review.

Yes.  Will Cc linux-api for review and will submit patches to
manpages.git after the API is finalized.

> The main limitation is that if this requires application modification,
> it may never be used. For example, if an application uses openmp places
> that translates into bind then openmp needs knowledge of the flag.
> Similar limitations apply to MPI. This feature has a risk that no one
> uses it.

My plan is to add a new option to `numactl`
(https://github.com/numactl/numactl/), so users who want to enable NUMA
balancing within the constrains of NUMA binding can use that.  I can
reach some Openstack and Kubernate developers to check whether it's
possible to add the support to these software.  For other applications,
Yes, it may take long time for the new flag to be used.

>> Huang Ying (2):
>>   mempolicy: Rename MPOL_F_MORON to MPOL_F_MOPRON
>>   autonuma: Migrate on fault among multiple bound nodes
>> ---
>>  include/uapi/linux/mempolicy.h | 4 +++-
>>  mm/mempolicy.c                 | 9 +++++++++
>>  2 files changed, 12 insertions(+), 1 deletion(-)
>> 
>> diff --git a/include/uapi/linux/mempolicy.h b/include/uapi/linux/mempolicy.h
>> index 3354774af61e..adb49f13840e 100644
>> --- a/include/uapi/linux/mempolicy.h
>> +++ b/include/uapi/linux/mempolicy.h
>> @@ -28,12 +28,14 @@ enum {
>>  /* Flags for set_mempolicy */
>>  #define MPOL_F_STATIC_NODES	(1 << 15)
>>  #define MPOL_F_RELATIVE_NODES	(1 << 14)
>> +#define MPOL_F_AUTONUMA		(1 << 13) /* Optimize with AutoNUMA if possible */
>>  
>
> Order by flag usage, correct the naming.

I will correct the naming.  Sorry, what does "order" refer to?

>>  /*
>>   * MPOL_MODE_FLAGS is the union of all possible optional mode flags passed to
>>   * either set_mempolicy() or mbind().
>>   */
>> -#define MPOL_MODE_FLAGS	(MPOL_F_STATIC_NODES | MPOL_F_RELATIVE_NODES)
>> +#define MPOL_MODE_FLAGS							\
>> +	(MPOL_F_STATIC_NODES | MPOL_F_RELATIVE_NODES | MPOL_F_AUTONUMA)
>>  
>>  /* Flags for get_mempolicy */
>>  #define MPOL_F_NODE	(1<<0)	/* return next IL mode instead of node mask */
>
> How does an application discover if MPOL_F_NUMAB is supported by the
> current running kernel? It looks like they might receive -EINVAL (didn't
> check for sure).

Yes.

> In that case, a manual page is defintely needed to
> explain that an error can be returned if the flag is used and the kernel
> does not support it so the application can cover by falling back to a
> strict binding. If it fails silently, then that also needs to be documented
> because it'll lead to different behaviour depending on the running
> kernel.

Sure.  Will describe this in the manual page.

Best Regards,
Huang, Ying
