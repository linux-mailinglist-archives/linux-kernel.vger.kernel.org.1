Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BCE12A7CE9
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 12:25:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730368AbgKELZ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 06:25:29 -0500
Received: from mx2.suse.de ([195.135.220.15]:33860 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729113AbgKELZ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 06:25:28 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 57CE9AB95;
        Thu,  5 Nov 2020 11:25:26 +0000 (UTC)
Date:   Thu, 5 Nov 2020 11:25:23 +0000
From:   Mel Gorman <mgorman@suse.de>
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>, Rik van Riel <riel@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>,
        David Rientjes <rientjes@google.com>
Subject: Re: [PATCH -V2 2/2] autonuma: Migrate on fault among multiple bound
 nodes
Message-ID: <20201105112523.GQ3306@suse.de>
References: <20201028023411.15045-1-ying.huang@intel.com>
 <20201028023411.15045-3-ying.huang@intel.com>
 <20201102111717.GB3306@suse.de>
 <87eel9wumd.fsf@yhuang-dev.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <87eel9wumd.fsf@yhuang-dev.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 04, 2020 at 01:36:58PM +0800, Huang, Ying wrote:
> > I've no specific objection to the patch or the name change. I can't
> > remember exactly why I picked the name, it was 8 years ago but I think it
> > was because the policy represented the most basic possible approach that
> > could be done without any attempt at being intelligent and established
> > a baseline. The intent was that anything built on top had to be better
> > than the most basic policy imaginable. The name reflected the dictionary
> > definition at the time and happened to match the acronym closely enough
> > and I wanted to make it absolutely clear to reviewers that the policy
> > was not good enough (ruling out MPOL_BASIC or variants thereof) even if
> > it happened to work for some workload and there was no intent to report
> > it to the userspace API.
> >
> > The only hazard with the patch is that applications that use MPOL_BIND
> > on multiple nodes may now incur some NUMA balancing overhead due to
> > trapping faults and migrations.
> 
> For this specific version of patch, I don't think this will happen.
> Because now, MPOL_F_MOF need to be set in struct mempolicy, for
> MPOL_BIND, only if mbind() syscall is called with MPOL_MF_LAZY, that
> will be the case.  So I think most workloads will not be affected by
> this patch.  The feature is opt-in.
> 

Ok.

> But from another point of view, I suggest to remove the constraints of
> MPOL_F_MOF in the future.  If the overhead of AutoNUMA isn't acceptable,
> why not just disable AutoNUMA globally via sysctl knob?
> 

Because it's a double edged sword. NUMA Balancing can make a workload
faster while still incurring more overhead than it should -- particularly
when threads are involved rescanning the same or unrelated regions.
Global disabling only really should happen when an application is running
that is the only application on the machine and has full NUMA awareness.

> > It might still end up being better but I was not aware of a
> > *realistic* workload that binds to multiple nodes
> > deliberately. Generally I expect if an application is binding, it's
> > binding to one local node.
> 
> Yes.  It's not popular configuration for now.  But for the memory
> tiering system with both DRAM and PMEM, the DRAM and PMEM in one socket
> will become 2 NUMA nodes.  To avoid too much cross-socket memory
> accessing, but take advantage of both the DRAM and PMEM, the workload
> can be bound to 2 NUMA nodes (DRAM and PMEM).
> 

Ok, that may lead to unpredictable performance as it'll have variable
performance with limited control of the "important" applications that
should use DRAM over PMEM. That's a long road but the step is not
incompatible with the long-term goal.

-- 
Mel Gorman
SUSE Labs
