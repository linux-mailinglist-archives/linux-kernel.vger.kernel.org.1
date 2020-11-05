Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63A672A8342
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 17:16:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729113AbgKEQQQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 11:16:16 -0500
Received: from mx2.suse.de ([195.135.220.15]:47782 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726371AbgKEQQP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 11:16:15 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1604592974;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lKB3aZJEDbJcd0NY8J24kxMePym/I6vQZWeeO8AULYg=;
        b=JBloRvyRqCiMl5OOXJ5kCyn53/9fx39/QfWByfv3igJQ+B/f0PhKZCFDZW/NnyBP8dl7+S
        e+tKRjJ+vCfmjIIaVkWa7TyFtmQOHJfRlzm7v88Z0l0I/CqKfhiVqQn72n2jvgjS2NinRx
        0ggbORWaoJKwdW9mCqFwQ7pYzNx0Pxs=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E3506AB4C;
        Thu,  5 Nov 2020 16:16:13 +0000 (UTC)
Date:   Thu, 5 Nov 2020 17:16:12 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Feng Tang <feng.tang@intel.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>, dave.hansen@intel.com,
        ying.huang@intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/2] mm: fix OOMs for binding workloads to movable
 zone only node
Message-ID: <20201105161612.GM21348@dhcp22.suse.cz>
References: <20201104075819.GA10052@dhcp22.suse.cz>
 <20201104084021.GB15700@shbuild999.sh.intel.com>
 <20201104085343.GA18718@dhcp22.suse.cz>
 <20201105014028.GA86777@shbuild999.sh.intel.com>
 <20201105120818.GC21348@dhcp22.suse.cz>
 <4029c079-b1f3-f290-26b6-a819c52f5200@suse.cz>
 <20201105125828.GG21348@dhcp22.suse.cz>
 <20201105130710.GB16525@shbuild999.sh.intel.com>
 <20201105131245.GH21348@dhcp22.suse.cz>
 <20201105134305.GA16424@shbuild999.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201105134305.GA16424@shbuild999.sh.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 05-11-20 21:43:05, Feng Tang wrote:
> On Thu, Nov 05, 2020 at 02:12:45PM +0100, Michal Hocko wrote:
> > On Thu 05-11-20 21:07:10, Feng Tang wrote:
> > [...]
> > > My debug traces shows it is, and its gfp_mask is 'GFP_KERNEL'
> > 
> > Can you provide the full information please? Which node has been
> > requested. Which cpuset the calling process run in and which node has
> > the allocation succeeded from? A bare dump_stack without any further
> > context is not really helpful.
> 
> I don't have the same platform as the original report, so I simulated
> one similar setup (with fakenuma and movablecore), which has 2 memory
> nodes: node 0 has DMA0/DMA32/Movable zones, while node 1 has only
> Movable zone. With it, I can got the same error and same oom callstack
> as the original report (as in the cover-letter).
> 
> The test command is:
> 	# docker run -it --rm --cpuset-mems 1 ubuntu:latest bash -c "grep Mems_allowed /proc/self/status"
> 
> To debug I only added some trace in the __alloc_pages_nodemask(), and
> for the callstack which get the page successfully:
> 
> 	[  567.510903] Call Trace:
> 	[  567.510909]  dump_stack+0x74/0x9a
> 	[  567.510910]  __alloc_pages_nodemask.cold+0x22/0xe5
> 	[  567.510913]  alloc_pages_current+0x87/0xe0
> 	[  567.510914]  __vmalloc_node_range+0x14c/0x240
> 	[  567.510918]  module_alloc+0x82/0xe0
> 	[  567.510921]  bpf_jit_alloc_exec+0xe/0x10
> 	[  567.510922]  bpf_jit_binary_alloc+0x7a/0x120
> 	[  567.510925]  bpf_int_jit_compile+0x145/0x424
> 	[  567.510926]  bpf_prog_select_runtime+0xac/0x130

As already said this doesn't really tell much without the additional
information.

> The incomming parameter nodemask is NULL, and the function will first try the
> cpuset nodemask (1 here), and the zoneidx is only granted 2, which makes the
> 'ac's preferred zone to be NULL. so it goes into __alloc_pages_slowpath(),
> which will first set the nodemask to 'NULL', and this time it got a preferred
> zone: zone DMA32 from node 0, following get_page_from_freelist will allocate
> one page from that zone. 

I do not follow. Both hot and slow paths of the allocator set
ALLOC_CPUSET or emulate it by mems_allowed when cpusets are nebaled
IIRC. This is later enforced in get_page_from_free_list. There are some
exceptions when the allocating process can run away from its cpusets -
e.g. IRQs, OOM victims and few other cases but definitely not a random
allocation. There might be some subtle details that have changed or I
might have forgot but 
-- 
Michal Hocko
SUSE Labs
