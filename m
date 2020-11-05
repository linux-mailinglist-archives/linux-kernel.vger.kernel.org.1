Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B95182A7FCD
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 14:43:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730525AbgKENnJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 08:43:09 -0500
Received: from mga17.intel.com ([192.55.52.151]:12479 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725468AbgKENnJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 08:43:09 -0500
IronPort-SDR: imW8VNkT5XFMOgURad2QheiHIZh1pQXulsQRppsU8gYRksjfbOmcqRGzKgVtN+9USiNIKVMzWu
 IvnkwHaJkBQA==
X-IronPort-AV: E=McAfee;i="6000,8403,9795"; a="149234281"
X-IronPort-AV: E=Sophos;i="5.77,453,1596524400"; 
   d="scan'208";a="149234281"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2020 05:43:08 -0800
IronPort-SDR: G/RO3kCEmIPvnKHBw807hh47lEwoqexKMMWIAhXADXFeKTly8TOxiJSp/ehMlI2zemH47O+Dak
 jMauaWLcXcNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,453,1596524400"; 
   d="scan'208";a="354286737"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.147.98])
  by fmsmga004.fm.intel.com with ESMTP; 05 Nov 2020 05:43:06 -0800
Date:   Thu, 5 Nov 2020 21:43:05 +0800
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
Message-ID: <20201105134305.GA16424@shbuild999.sh.intel.com>
References: <20201104073826.GA15700@shbuild999.sh.intel.com>
 <20201104075819.GA10052@dhcp22.suse.cz>
 <20201104084021.GB15700@shbuild999.sh.intel.com>
 <20201104085343.GA18718@dhcp22.suse.cz>
 <20201105014028.GA86777@shbuild999.sh.intel.com>
 <20201105120818.GC21348@dhcp22.suse.cz>
 <4029c079-b1f3-f290-26b6-a819c52f5200@suse.cz>
 <20201105125828.GG21348@dhcp22.suse.cz>
 <20201105130710.GB16525@shbuild999.sh.intel.com>
 <20201105131245.GH21348@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201105131245.GH21348@dhcp22.suse.cz>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 05, 2020 at 02:12:45PM +0100, Michal Hocko wrote:
> On Thu 05-11-20 21:07:10, Feng Tang wrote:
> [...]
> > My debug traces shows it is, and its gfp_mask is 'GFP_KERNEL'
> 
> Can you provide the full information please? Which node has been
> requested. Which cpuset the calling process run in and which node has
> the allocation succeeded from? A bare dump_stack without any further
> context is not really helpful.

I don't have the same platform as the original report, so I simulated
one similar setup (with fakenuma and movablecore), which has 2 memory
nodes: node 0 has DMA0/DMA32/Movable zones, while node 1 has only
Movable zone. With it, I can got the same error and same oom callstack
as the original report (as in the cover-letter).

The test command is:
	# docker run -it --rm --cpuset-mems 1 ubuntu:latest bash -c "grep Mems_allowed /proc/self/status"

To debug I only added some trace in the __alloc_pages_nodemask(), and
for the callstack which get the page successfully:

	[  567.510903] Call Trace:
	[  567.510909]  dump_stack+0x74/0x9a
	[  567.510910]  __alloc_pages_nodemask.cold+0x22/0xe5
	[  567.510913]  alloc_pages_current+0x87/0xe0
	[  567.510914]  __vmalloc_node_range+0x14c/0x240
	[  567.510918]  module_alloc+0x82/0xe0
	[  567.510921]  bpf_jit_alloc_exec+0xe/0x10
	[  567.510922]  bpf_jit_binary_alloc+0x7a/0x120
	[  567.510925]  bpf_int_jit_compile+0x145/0x424
	[  567.510926]  bpf_prog_select_runtime+0xac/0x130

The incomming parameter nodemask is NULL, and the function will first try the
cpuset nodemask (1 here), and the zoneidx is only granted 2, which makes the
'ac's preferred zone to be NULL. so it goes into __alloc_pages_slowpath(),
which will first set the nodemask to 'NULL', and this time it got a preferred
zone: zone DMA32 from node 0, following get_page_from_freelist will allocate
one page from that zone. 

Thanks,
Feng

> 
> -- 
> Michal Hocko
> SUSE Labs
