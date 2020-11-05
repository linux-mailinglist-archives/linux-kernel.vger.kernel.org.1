Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22AD62A7F70
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 14:07:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730484AbgKENHP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 08:07:15 -0500
Received: from mga17.intel.com ([192.55.52.151]:7969 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730139AbgKENHO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 08:07:14 -0500
IronPort-SDR: Mio96fnY8mgfNNp5XBcns1ZXT1aOWhvSYYyJv4o6OtFT2SaW+f9PInyYkOb8QgaF6o2tjigNn0
 kjS3wIZgxzLg==
X-IronPort-AV: E=McAfee;i="6000,8403,9795"; a="149230052"
X-IronPort-AV: E=Sophos;i="5.77,453,1596524400"; 
   d="scan'208";a="149230052"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2020 05:07:13 -0800
IronPort-SDR: ShdF1OgXEREqx66zZaS07mMXU8iQcI0SQwiBrs0lJfjumEk/P3vjVwvjuXPQCvsMn8lWcNYwuV
 wbZUglh3/9LQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,453,1596524400"; 
   d="scan'208";a="354276130"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.147.98])
  by fmsmga004.fm.intel.com with ESMTP; 05 Nov 2020 05:07:10 -0800
Date:   Thu, 5 Nov 2020 21:07:10 +0800
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
Message-ID: <20201105130710.GB16525@shbuild999.sh.intel.com>
References: <1604470210-124827-1-git-send-email-feng.tang@intel.com>
 <20201104071308.GN21990@dhcp22.suse.cz>
 <20201104073826.GA15700@shbuild999.sh.intel.com>
 <20201104075819.GA10052@dhcp22.suse.cz>
 <20201104084021.GB15700@shbuild999.sh.intel.com>
 <20201104085343.GA18718@dhcp22.suse.cz>
 <20201105014028.GA86777@shbuild999.sh.intel.com>
 <20201105120818.GC21348@dhcp22.suse.cz>
 <4029c079-b1f3-f290-26b6-a819c52f5200@suse.cz>
 <20201105125828.GG21348@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201105125828.GG21348@dhcp22.suse.cz>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 05, 2020 at 01:58:28PM +0100, Michal Hocko wrote:
> On Thu 05-11-20 13:53:24, Vlastimil Babka wrote:
> > On 11/5/20 1:08 PM, Michal Hocko wrote:
> > > On Thu 05-11-20 09:40:28, Feng Tang wrote:
> > > > > > Could you be more specific? This sounds like a bug. Allocations
> > > > > shouldn't spill over to a node which is not in the cpuset. There are few
> > > > > exceptions like IRQ context but that shouldn't happen regurarly.
> > > > 
> > > > I mean when the docker starts, it will spawn many processes which obey
> > > > the mem binding set, and they have some kernel page requests, which got
> > > > successfully allocated, like the following callstack:
> > > > 
> > > > 	[  567.044953] CPU: 1 PID: 2021 Comm: runc:[1:CHILD] Tainted: G        W I       5.9.0-rc8+ #6
> > > > 	[  567.044956] Hardware name:  /NUC6i5SYB, BIOS SYSKLi35.86A.0051.2016.0804.1114 08/04/2016
> > > > 	[  567.044958] Call Trace:
> > > > 	[  567.044972]  dump_stack+0x74/0x9a
> > > > 	[  567.044978]  __alloc_pages_nodemask.cold+0x22/0xe5
> > > > 	[  567.044986]  alloc_pages_current+0x87/0xe0
> > > > 	[  567.044991]  allocate_slab+0x2e5/0x4f0
> > > > 	[  567.044996]  ___slab_alloc+0x380/0x5d0
> > > > 	[  567.045021]  __slab_alloc+0x20/0x40
> > > > 	[  567.045025]  kmem_cache_alloc+0x2a0/0x2e0
> > > > 	[  567.045033]  mqueue_alloc_inode+0x1a/0x30
> > > > 	[  567.045041]  alloc_inode+0x22/0xa0
> > > > 	[  567.045045]  new_inode_pseudo+0x12/0x60
> > > > 	[  567.045049]  new_inode+0x17/0x30
> > > > 	[  567.045052]  mqueue_get_inode+0x45/0x3b0
> > > > 	[  567.045060]  mqueue_fill_super+0x41/0x70
> > > > 	[  567.045067]  vfs_get_super+0x7f/0x100
> > > > 	[  567.045074]  get_tree_keyed+0x1d/0x20
> > > > 	[  567.045080]  mqueue_get_tree+0x1c/0x20
> > > > 	[  567.045086]  vfs_get_tree+0x2a/0xc0
> > > > 	[  567.045092]  fc_mount+0x13/0x50
> > > > 	[  567.045099]  mq_create_mount+0x92/0xe0
> > > > 	[  567.045102]  mq_init_ns+0x3b/0x50
> > > > 	[  567.045106]  copy_ipcs+0x10a/0x1b0
> > > > 	[  567.045113]  create_new_namespaces+0xa6/0x2b0
> > > > 	[  567.045118]  unshare_nsproxy_namespaces+0x5a/0xb0
> > > > 	[  567.045124]  ksys_unshare+0x19f/0x360
> > > > 	[  567.045129]  __x64_sys_unshare+0x12/0x20
> > > > 	[  567.045135]  do_syscall_64+0x38/0x90
> > > > 	[  567.045143]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> > > > 
> > > > For it, the __alloc_pages_nodemask() will first try process's targed
> > > > nodemask(unmovable node here), and there is no availabe zone, so it
> > > > goes with the NULL nodemask, and get a page in the slowpath.
> > > 
> > > OK, I see your point now. I was not aware of the slab allocator not
> > > following cpusets. Sounds like a bug to me.
> > 
> > SLAB and SLUB seem to not care about cpusets in the fast path.
> 
> Is a fallback to a different node which is outside of the cpuset
> possible?
 
My debug traces shows it is, and its gfp_mask is 'GFP_KERNEL'

And actually in this usage, I seen other types of kernel allocation
request got fallback to the normal node which is not in cpuset mem
nodemasks, like

	[  567.510901] CPU: 3 PID: 2022 Comm: runc:[2:INIT] Tainted: G        W I       5.9.0-rc8+ #6
	[  567.510902] Hardware name:  /NUC6i5SYB, BIOS SYSKLi35.86A.0051.2016.0804.1114 08/04/2016
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
	[  567.510928]  bpf_prepare_filter+0x44c/0x4b0
	[  567.510932]  bpf_prog_create_from_user+0xc7/0x120
	[  567.510934]  do_seccomp+0x118/0x990
	[  567.510937]  __x64_sys_seccomp+0x1a/0x20
	[  567.510939]  do_syscall_64+0x38/0x90

And its gfp_mask is (GFP_KERNEL|__GFP_HIGHMEM|__GFP_NOWARN)

Thanks,
Feng

> > But this
> > stack shows that it went all the way to the page allocator, so the cpusets
> > should have been obeyed there at least.
> 
> Looking closer what is this dump_stack saying actually?
> 
> -- 
> Michal Hocko
> SUSE Labs
