Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 057DC2A98DA
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 16:55:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727621AbgKFPzI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 10:55:08 -0500
Received: from mga09.intel.com ([134.134.136.24]:36159 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726422AbgKFPzH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 10:55:07 -0500
IronPort-SDR: sDHMnabFTUBUAX7OU01wNA/Cwn38IrUzPLVdQMhuNU5CrDAfXr0VTPWoJ2yZlmSQclEw3BSlrl
 Ak5VsP1IbYHQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9797"; a="169708692"
X-IronPort-AV: E=Sophos;i="5.77,456,1596524400"; 
   d="scan'208";a="169708692"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2020 07:55:05 -0800
IronPort-SDR: tDj4OyVIr9tk9Jtb24z9upN02k6+2l9N5E3bn+CjQVK86EYvuJOEAKrf0fz4kpJP9s3z3c/+mg
 yEaWMJRkQYcw==
X-IronPort-AV: E=Sophos;i="5.77,456,1596524400"; 
   d="scan'208";a="472104901"
Received: from rseth-mobl2.amr.corp.intel.com (HELO intel.com) ([10.252.131.79])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2020 07:55:04 -0800
Date:   Fri, 6 Nov 2020 07:55:03 -0800
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Mel Gorman <mgorman@suse.de>,
        Peter Zijlstra <peterz@infradead.org>, linux-mm@kvack.org,
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
Message-ID: <20201106155503.nkwuxr5mkneggzl7@intel.com>
Mail-Followup-To: "Huang, Ying" <ying.huang@intel.com>,
        Mel Gorman <mgorman@suse.de>, Peter Zijlstra <peterz@infradead.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>, Rik van Riel <riel@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Andi Kleen <ak@linux.intel.com>, Michal Hocko <mhocko@suse.com>,
        David Rientjes <rientjes@google.com>
References: <20201028023411.15045-1-ying.huang@intel.com>
 <20201028023411.15045-3-ying.huang@intel.com>
 <20201102111717.GB3306@suse.de>
 <87eel9wumd.fsf@yhuang-dev.intel.com>
 <20201105112523.GQ3306@suse.de>
 <87v9ejosec.fsf@yhuang-dev.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87v9ejosec.fsf@yhuang-dev.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-11-06 15:28:59, Huang, Ying wrote:
> Mel Gorman <mgorman@suse.de> writes:
> 
> > On Wed, Nov 04, 2020 at 01:36:58PM +0800, Huang, Ying wrote:
> >> But from another point of view, I suggest to remove the constraints of
> >> MPOL_F_MOF in the future.  If the overhead of AutoNUMA isn't acceptable,
> >> why not just disable AutoNUMA globally via sysctl knob?
> >> 
> >
> > Because it's a double edged sword. NUMA Balancing can make a workload
> > faster while still incurring more overhead than it should -- particularly
> > when threads are involved rescanning the same or unrelated regions.
> > Global disabling only really should happen when an application is running
> > that is the only application on the machine and has full NUMA awareness.
> 
> Got it.  So NUMA Balancing may in generally benefit some workloads but
> hurt some other workloads on one machine.  So we need a method to
> enable/disable NUMA Balancing for one workload.  Previously, this is
> done via the explicit NUMA policy.  If some explicit NUMA policy is
> specified, NUMA Balancing is disabled for the memory region or the
> thread.  And this can be reverted again for a memory region via
> MPOL_MF_LAZY.  It appears that we lacks MPOL_MF_LAZY for the thread yet.
> 
> >> > It might still end up being better but I was not aware of a
> >> > *realistic* workload that binds to multiple nodes
> >> > deliberately. Generally I expect if an application is binding, it's
> >> > binding to one local node.
> >> 
> >> Yes.  It's not popular configuration for now.  But for the memory
> >> tiering system with both DRAM and PMEM, the DRAM and PMEM in one socket
> >> will become 2 NUMA nodes.  To avoid too much cross-socket memory
> >> accessing, but take advantage of both the DRAM and PMEM, the workload
> >> can be bound to 2 NUMA nodes (DRAM and PMEM).
> >> 
> >
> > Ok, that may lead to unpredictable performance as it'll have variable
> > performance with limited control of the "important" applications that
> > should use DRAM over PMEM. That's a long road but the step is not
> > incompatible with the long-term goal.
> 
> Yes.  Ben Widawsky is working on a patchset to make it possible to
> prefer the remote DRAM instead of the local PMEM as follows,
> 
> https://lore.kernel.org/linux-mm/20200630212517.308045-1-ben.widawsky@intel.com/
> 
> Best Regards,
> Huang, Ying
> 

Rebased version was posted here:
https://lore.kernel.org/linux-mm/20201030190238.306764-1-ben.widawsky@intel.com/

Thanks.
Ben
