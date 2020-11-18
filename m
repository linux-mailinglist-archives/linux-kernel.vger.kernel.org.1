Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA56B2B7AD2
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 10:57:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726989AbgKRJ4n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 04:56:43 -0500
Received: from mx2.suse.de ([195.135.220.15]:52594 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725772AbgKRJ4m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 04:56:42 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A1C95ABDE;
        Wed, 18 Nov 2020 09:56:40 +0000 (UTC)
Date:   Wed, 18 Nov 2020 09:56:38 +0000
From:   Mel Gorman <mgorman@suse.de>
To:     Huang Ying <ying.huang@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>,
        David Rientjes <rientjes@google.com>
Subject: Re: [RFC -V5] autonuma: Migrate on fault among multiple bound nodes
Message-ID: <20201118095637.GC3306@suse.de>
References: <20201118051952.39097-1-ying.huang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20201118051952.39097-1-ying.huang@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 18, 2020 at 01:19:52PM +0800, Huang Ying wrote:
> Now, AutoNUMA can only optimize the page placement among the NUMA

Note that the feature is referred to as NUMA_BALANCING in the kernel
configs as AUTONUMA as it was first presented was not merged. The sysctl
for it is kernel.numa_balancing as you already note. So use NUMAB or
NUMA_BALANCING but not AUTONUMA because at least a new person grepping
for NUMA_BALANCING or variants will find it where as autonuma only creeped
into the powerpc arch code.

If exposing to userspace, the naming should definitely be consistent.

> - sysctl knob numa_balancing can enable/disable the NUMA balancing
>   globally.
> 
> - even if sysctl numa_balancing is enabled, the NUMA balancing will be
>   disabled for the memory areas or applications with the explicit memory
>   policy by default.
> 
> - MPOL_F_AUTONUMA can be used to enable the NUMA balancing for the
>   applications when specifying the explicit memory policy.
> 

MPOL_F_NUMAB

> Various page placement optimization based on the NUMA balancing can be
> done with these flags.  As the first step, in this patch, if the
> memory of the application is bound to multiple nodes (MPOL_BIND), and
> in the hint page fault handler the accessing node are in the policy
> nodemask, the page will be tried to be migrated to the accessing node
> to reduce the cross-node accessing.
> 

The patch still lacks supporting data. It really should have a basic
benchmark of some sort serving as an example of how the policies should
be set and a before/after comparison showing the throughput of MPOL_BIND
accesses spanning 2 or more nodes is faster when numa balancing is enabled.

A man page update should also be added clearly outlining when an
application should consider using it with the linux-api people cc'd
for review.

The main limitation is that if this requires application modification,
it may never be used. For example, if an application uses openmp places
that translates into bind then openmp needs knowledge of the flag.
Similar limitations apply to MPI. This feature has a risk that no one
uses it.

> Huang Ying (2):
>   mempolicy: Rename MPOL_F_MORON to MPOL_F_MOPRON
>   autonuma: Migrate on fault among multiple bound nodes
> ---
>  include/uapi/linux/mempolicy.h | 4 +++-
>  mm/mempolicy.c                 | 9 +++++++++
>  2 files changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/include/uapi/linux/mempolicy.h b/include/uapi/linux/mempolicy.h
> index 3354774af61e..adb49f13840e 100644
> --- a/include/uapi/linux/mempolicy.h
> +++ b/include/uapi/linux/mempolicy.h
> @@ -28,12 +28,14 @@ enum {
>  /* Flags for set_mempolicy */
>  #define MPOL_F_STATIC_NODES	(1 << 15)
>  #define MPOL_F_RELATIVE_NODES	(1 << 14)
> +#define MPOL_F_AUTONUMA		(1 << 13) /* Optimize with AutoNUMA if possible */
>  

Order by flag usage, correct the naming.

>  /*
>   * MPOL_MODE_FLAGS is the union of all possible optional mode flags passed to
>   * either set_mempolicy() or mbind().
>   */
> -#define MPOL_MODE_FLAGS	(MPOL_F_STATIC_NODES | MPOL_F_RELATIVE_NODES)
> +#define MPOL_MODE_FLAGS							\
> +	(MPOL_F_STATIC_NODES | MPOL_F_RELATIVE_NODES | MPOL_F_AUTONUMA)
>  
>  /* Flags for get_mempolicy */
>  #define MPOL_F_NODE	(1<<0)	/* return next IL mode instead of node mask */

How does an application discover if MPOL_F_NUMAB is supported by the
current running kernel? It looks like they might receive -EINVAL (didn't
check for sure). In that case, a manual page is defintely needed to
explain that an error can be returned if the flag is used and the kernel
does not support it so the application can cover by falling back to a
strict binding. If it fails silently, then that also needs to be documented
because it'll lead to different behaviour depending on the running
kernel.

-- 
Mel Gorman
SUSE Labs
