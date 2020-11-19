Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 056A92B8C93
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 08:55:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726231AbgKSHu5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 02:50:57 -0500
Received: from mx2.suse.de ([195.135.220.15]:60046 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725937AbgKSHu5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 02:50:57 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id DD595AD60;
        Thu, 19 Nov 2020 07:50:55 +0000 (UTC)
Date:   Thu, 19 Nov 2020 07:50:52 +0000
From:   Mel Gorman <mgorman@suse.de>
To:     "Huang, Ying" <ying.huang@intel.com>
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
Message-ID: <20201119075052.GF3306@suse.de>
References: <20201118051952.39097-1-ying.huang@intel.com>
 <20201118095637.GC3306@suse.de>
 <878saxvpji.fsf@yhuang-dev.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <878saxvpji.fsf@yhuang-dev.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 19, 2020 at 02:17:21PM +0800, Huang, Ying wrote:
> >> Various page placement optimization based on the NUMA balancing can be
> >> done with these flags.  As the first step, in this patch, if the
> >> memory of the application is bound to multiple nodes (MPOL_BIND), and
> >> in the hint page fault handler the accessing node are in the policy
> >> nodemask, the page will be tried to be migrated to the accessing node
> >> to reduce the cross-node accessing.
> >> 
> >
> > The patch still lacks supporting data. It really should have a basic
> > benchmark of some sort serving as an example of how the policies should
> > be set and a before/after comparison showing the throughput of MPOL_BIND
> > accesses spanning 2 or more nodes is faster when numa balancing is enabled.
> 
> Sure.  Will add some basic benchmark data and usage example.
> 

Thanks

> > A man page update should also be added clearly outlining when an
> > application should consider using it with the linux-api people cc'd
> > for review.
> 
> Yes.  Will Cc linux-api for review and will submit patches to
> manpages.git after the API is finalized.
> 

Add the manpages patch to this series. While it is not merged through
the kernel, it's important for review purposes.

> > The main limitation is that if this requires application modification,
> > it may never be used. For example, if an application uses openmp places
> > that translates into bind then openmp needs knowledge of the flag.
> > Similar limitations apply to MPI. This feature has a risk that no one
> > uses it.
> 
> My plan is to add a new option to `numactl`
> (https://github.com/numactl/numactl/), so users who want to enable NUMA
> balancing within the constrains of NUMA binding can use that.  I can
> reach some Openstack and Kubernate developers to check whether it's
> possible to add the support to these software.  For other applications,
> Yes, it may take long time for the new flag to be used.
> 

Patch for numactl should also be included to see what it looks like in
practice. Document what happens if the flag does not exist in the
running kernel.

I know this is awkward, but it's an interface exposed to userspace and
as it is expected that applications will exist that then try run on
older kernels, it needs to be very up-front about what happens on older
kernels. It would not be a complete surprise for openmp and openmpi
packages to be updated on distributions with older kernels (either by
source or via packaging) leading to surprises.

> >> Huang Ying (2):
> >>   mempolicy: Rename MPOL_F_MORON to MPOL_F_MOPRON
> >>   autonuma: Migrate on fault among multiple bound nodes
> >> ---
> >>  include/uapi/linux/mempolicy.h | 4 +++-
> >>  mm/mempolicy.c                 | 9 +++++++++
> >>  2 files changed, 12 insertions(+), 1 deletion(-)
> >> 
> >> diff --git a/include/uapi/linux/mempolicy.h b/include/uapi/linux/mempolicy.h
> >> index 3354774af61e..adb49f13840e 100644
> >> --- a/include/uapi/linux/mempolicy.h
> >> +++ b/include/uapi/linux/mempolicy.h
> >> @@ -28,12 +28,14 @@ enum {
> >>  /* Flags for set_mempolicy */
> >>  #define MPOL_F_STATIC_NODES	(1 << 15)
> >>  #define MPOL_F_RELATIVE_NODES	(1 << 14)
> >> +#define MPOL_F_AUTONUMA		(1 << 13) /* Optimize with AutoNUMA if possible */
> >>  
> >
> > Order by flag usage, correct the naming.
> 
> I will correct the naming.  Sorry, what does "order" refer to?
> 

Never mind, it was already in reverse order, it was a silly comment.
Just fix the name.

> >>  /*
> >>   * MPOL_MODE_FLAGS is the union of all possible optional mode flags passed to
> >>   * either set_mempolicy() or mbind().
> >>   */
> >> -#define MPOL_MODE_FLAGS	(MPOL_F_STATIC_NODES | MPOL_F_RELATIVE_NODES)
> >> +#define MPOL_MODE_FLAGS							\
> >> +	(MPOL_F_STATIC_NODES | MPOL_F_RELATIVE_NODES | MPOL_F_AUTONUMA)
> >>  
> >>  /* Flags for get_mempolicy */
> >>  #define MPOL_F_NODE	(1<<0)	/* return next IL mode instead of node mask */
> >
> > How does an application discover if MPOL_F_NUMAB is supported by the
> > current running kernel? It looks like they might receive -EINVAL (didn't
> > check for sure).
> 
> Yes.
> 

Needs to be documented so applications know they can recover. Also needs
to be determined how numactl should behave if the flag does not exist.
Likely it will simply fail in which case the error should be clear.

> > In that case, a manual page is defintely needed to
> > explain that an error can be returned if the flag is used and the kernel
> > does not support it so the application can cover by falling back to a
> > strict binding. If it fails silently, then that also needs to be documented
> > because it'll lead to different behaviour depending on the running
> > kernel.
> 
> Sure.  Will describe this in the manual page.
> 

Thanks.

-- 
Mel Gorman
SUSE Labs
