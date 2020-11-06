Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5FEA2A8FFF
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 08:07:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726300AbgKFHHA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 02:07:00 -0500
Received: from mga07.intel.com ([134.134.136.100]:39854 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725828AbgKFHHA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 02:07:00 -0500
IronPort-SDR: IQ7Ng/zE2cTGaUtmtYhWbxdhMTbD9hw7XXOeuPD/2QQeAeiAGygQvkRa2DIqzX4mHGw5sXaqw/
 aZg1+3uHjNqg==
X-IronPort-AV: E=McAfee;i="6000,8403,9796"; a="233677208"
X-IronPort-AV: E=Sophos;i="5.77,455,1596524400"; 
   d="scan'208";a="233677208"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2020 23:06:59 -0800
IronPort-SDR: Tqs3Igj9aFSu78o2eV3CEG5Qrl7tkXtBTj7kOv6uEDJBbkwdv4hmpHbWCKYYI6ANwgorq2xg6y
 sFRXkptN3f9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,455,1596524400"; 
   d="scan'208";a="528243897"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.147.98])
  by fmsmga006.fm.intel.com with ESMTP; 05 Nov 2020 23:06:57 -0800
Date:   Fri, 6 Nov 2020 15:06:56 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>, dave.hansen@intel.com,
        ying.huang@intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/2] mm: fix OOMs for binding workloads to movable
 zone only node
Message-ID: <20201106070656.GA129085@shbuild999.sh.intel.com>
References: <20201104084021.GB15700@shbuild999.sh.intel.com>
 <20201104085343.GA18718@dhcp22.suse.cz>
 <20201105014028.GA86777@shbuild999.sh.intel.com>
 <20201105120818.GC21348@dhcp22.suse.cz>
 <4029c079-b1f3-f290-26b6-a819c52f5200@suse.cz>
 <20201105125828.GG21348@dhcp22.suse.cz>
 <20201105130710.GB16525@shbuild999.sh.intel.com>
 <20201105131245.GH21348@dhcp22.suse.cz>
 <20201105134305.GA16424@shbuild999.sh.intel.com>
 <20201105161612.GM21348@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201105161612.GM21348@dhcp22.suse.cz>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 05, 2020 at 05:16:12PM +0100, Michal Hocko wrote:
> On Thu 05-11-20 21:43:05, Feng Tang wrote:
> > On Thu, Nov 05, 2020 at 02:12:45PM +0100, Michal Hocko wrote:
> > > On Thu 05-11-20 21:07:10, Feng Tang wrote:
> > > [...]
> > > > My debug traces shows it is, and its gfp_mask is 'GFP_KERNEL'
> > > 
> > > Can you provide the full information please? Which node has been
> > > requested. Which cpuset the calling process run in and which node has
> > > the allocation succeeded from? A bare dump_stack without any further
> > > context is not really helpful.
> > 
> > I don't have the same platform as the original report, so I simulated
> > one similar setup (with fakenuma and movablecore), which has 2 memory
> > nodes: node 0 has DMA0/DMA32/Movable zones, while node 1 has only
> > Movable zone. With it, I can got the same error and same oom callstack
> > as the original report (as in the cover-letter).
> > 
> > The test command is:
> > 	# docker run -it --rm --cpuset-mems 1 ubuntu:latest bash -c "grep Mems_allowed /proc/self/status"
> > 
> > To debug I only added some trace in the __alloc_pages_nodemask(), and
> > for the callstack which get the page successfully:
> > 
> > 	[  567.510903] Call Trace:
> > 	[  567.510909]  dump_stack+0x74/0x9a
> > 	[  567.510910]  __alloc_pages_nodemask.cold+0x22/0xe5
> > 	[  567.510913]  alloc_pages_current+0x87/0xe0
> > 	[  567.510914]  __vmalloc_node_range+0x14c/0x240
> > 	[  567.510918]  module_alloc+0x82/0xe0
> > 	[  567.510921]  bpf_jit_alloc_exec+0xe/0x10
> > 	[  567.510922]  bpf_jit_binary_alloc+0x7a/0x120
> > 	[  567.510925]  bpf_int_jit_compile+0x145/0x424
> > 	[  567.510926]  bpf_prog_select_runtime+0xac/0x130
> 
> As already said this doesn't really tell much without the additional
> information.
> 
> > The incomming parameter nodemask is NULL, and the function will first try the
> > cpuset nodemask (1 here), and the zoneidx is only granted 2, which makes the
> > 'ac's preferred zone to be NULL. so it goes into __alloc_pages_slowpath(),
> > which will first set the nodemask to 'NULL', and this time it got a preferred
> > zone: zone DMA32 from node 0, following get_page_from_freelist will allocate
> > one page from that zone. 
> 
> I do not follow. Both hot and slow paths of the allocator set
> ALLOC_CPUSET or emulate it by mems_allowed when cpusets are nebaled
> IIRC. This is later enforced in get_page_from_free_list. There are some
> exceptions when the allocating process can run away from its cpusets -
> e.g. IRQs, OOM victims and few other cases but definitely not a random
> allocation. There might be some subtle details that have changed or I
> might have forgot but 

yes, I was confused too. IIUC, the key check inside get_page_from_freelist()
is 

	if (cpusets_enabled() &&
		(alloc_flags & ALLOC_CPUSET) &&
		!__cpuset_zone_allowed(zone, gfp_mask))

In our case (kernel page got allocated), the first 2 conditions are true,
and for __cpuset_zone_allowed(), the possible place to return true is
checking parent cpuset's nodemask

	cs = nearest_hardwall_ancestor(task_cs(current));
	allowed = node_isset(node, cs->mems_allowed);

This will override the ALLOC_CPUSET check.

Thanks,
Feng
> -- 
> Michal Hocko
> SUSE Labs
