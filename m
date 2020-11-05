Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABE022A74F8
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 02:40:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731131AbgKEBkh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 20:40:37 -0500
Received: from mga11.intel.com ([192.55.52.93]:10724 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725862AbgKEBkh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 20:40:37 -0500
IronPort-SDR: yYgTg9+8YlFuBDmdQSDVjC+CLOBv3GeEQ7t2dH3IZ/uBd17HK5MXqjkSPZqfbpAgAdX7Ysir1v
 cLEiBXX3prYQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9795"; a="165804642"
X-IronPort-AV: E=Sophos;i="5.77,451,1596524400"; 
   d="scan'208";a="165804642"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2020 17:40:31 -0800
IronPort-SDR: LAdQnDdfHjgZrnnmDPquScBQ9eDbLP22HLys8lzwoaJos9sN1jCISzfGOIZ4YayAQOGOe3oLN5
 BT0nWpsnO8Bw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,451,1596524400"; 
   d="scan'208";a="325836281"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.147.98])
  by orsmga006.jf.intel.com with ESMTP; 04 Nov 2020 17:40:28 -0800
Date:   Thu, 5 Nov 2020 09:40:28 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>, dave.hansen@intel.com,
        ying.huang@intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/2] mm: fix OOMs for binding workloads to movable
 zone only node
Message-ID: <20201105014028.GA86777@shbuild999.sh.intel.com>
References: <1604470210-124827-1-git-send-email-feng.tang@intel.com>
 <20201104071308.GN21990@dhcp22.suse.cz>
 <20201104073826.GA15700@shbuild999.sh.intel.com>
 <20201104075819.GA10052@dhcp22.suse.cz>
 <20201104084021.GB15700@shbuild999.sh.intel.com>
 <20201104085343.GA18718@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201104085343.GA18718@dhcp22.suse.cz>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 04, 2020 at 09:53:43AM +0100, Michal Hocko wrote:
 
> > > As I've said in reply to your second patch. I think we can make the oom
> > > killer behavior more sensible in this misconfigured cases but I do not
> > > think we want break the cpuset isolation for such a configuration.
> > 
> > Do you mean we skip the killing and just let the allocation fail? We've
> > checked the oom killer code first, when the oom happens, both DRAM
> > node and unmovable node have lots of free memory, and killing process
> > won't improve the situation.
> 
> We already do skip oom killer and fail for lowmem allocation requests already.
> This is similar in some sense. Another option would be to kill the
> allocating context which will have less corner cases potentially because
> some allocation failures might be unexpected.

Yes, this can avoid the helpless oom killing to kill a good process(no
memory pressure at all)

And I think the important thing is to judge whether this usage (binding
docker like workload to unmovable node) is a valid case :) 

Initially, I thought it invalid too, but later think it still makes some
sense for the 2 cases:
    * user want to bind his workload to one node(most of user space
      memory) to avoid cross-node traffic, and that node happens to
      be configured as unmovable
    * one small DRAM node + big PMEM node, and memory latency insensitive
      workload could be bound to the cheaper unmovable PMEM node
 
> > (Folloing is copied from your comments for 2/2) 
> > > This allows to spill memory allocations over to any other node which
> > > has Normal (or other lower) zones and as such it breaks cpuset isolation.
> > > As I've pointed out in the reply to your cover letter it seems that
> > > this is more of a misconfiguration than a bug.
> > 
> > For the usage case (docker container running), the spilling is already
> > happening, I traced its memory allocation requests, many of them are
> > movable, and got fallback to the normal node naturally with current
> 
> Could you be more specific? This sounds like a bug. Allocations
> shouldn't spill over to a node which is not in the cpuset. There are few
> exceptions like IRQ context but that shouldn't happen regurarly.

I mean when the docker starts, it will spawn many processes which obey
the mem binding set, and they have some kernel page requests, which got
successfully allocated, like the following callstack:

	[  567.044953] CPU: 1 PID: 2021 Comm: runc:[1:CHILD] Tainted: G        W I       5.9.0-rc8+ #6
	[  567.044956] Hardware name:  /NUC6i5SYB, BIOS SYSKLi35.86A.0051.2016.0804.1114 08/04/2016
	[  567.044958] Call Trace:
	[  567.044972]  dump_stack+0x74/0x9a
	[  567.044978]  __alloc_pages_nodemask.cold+0x22/0xe5
	[  567.044986]  alloc_pages_current+0x87/0xe0
	[  567.044991]  allocate_slab+0x2e5/0x4f0
	[  567.044996]  ___slab_alloc+0x380/0x5d0
	[  567.045021]  __slab_alloc+0x20/0x40
	[  567.045025]  kmem_cache_alloc+0x2a0/0x2e0
	[  567.045033]  mqueue_alloc_inode+0x1a/0x30
	[  567.045041]  alloc_inode+0x22/0xa0
	[  567.045045]  new_inode_pseudo+0x12/0x60
	[  567.045049]  new_inode+0x17/0x30
	[  567.045052]  mqueue_get_inode+0x45/0x3b0
	[  567.045060]  mqueue_fill_super+0x41/0x70
	[  567.045067]  vfs_get_super+0x7f/0x100
	[  567.045074]  get_tree_keyed+0x1d/0x20
	[  567.045080]  mqueue_get_tree+0x1c/0x20
	[  567.045086]  vfs_get_tree+0x2a/0xc0
	[  567.045092]  fc_mount+0x13/0x50
	[  567.045099]  mq_create_mount+0x92/0xe0
	[  567.045102]  mq_init_ns+0x3b/0x50
	[  567.045106]  copy_ipcs+0x10a/0x1b0
	[  567.045113]  create_new_namespaces+0xa6/0x2b0
	[  567.045118]  unshare_nsproxy_namespaces+0x5a/0xb0
	[  567.045124]  ksys_unshare+0x19f/0x360
	[  567.045129]  __x64_sys_unshare+0x12/0x20
	[  567.045135]  do_syscall_64+0x38/0x90
	[  567.045143]  entry_SYSCALL_64_after_hwframe+0x44/0xa9

For it, the __alloc_pages_nodemask() will first try process's targed
nodemask(unmovable node here), and there is no availabe zone, so it
goes with the NULL nodemask, and get a page in the slowpath.

And this process happens to the user space allocation as well, but
it got blocked by the CPUSET node binding check.

Thanks,
Feng


