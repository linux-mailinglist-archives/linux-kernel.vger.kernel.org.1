Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59EF62A7FB8
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 14:34:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730530AbgKENeK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 08:34:10 -0500
Received: from mx2.suse.de ([195.135.220.15]:51612 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726067AbgKENeJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 08:34:09 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 3C782ABDE;
        Thu,  5 Nov 2020 13:34:08 +0000 (UTC)
To:     Michal Hocko <mhocko@suse.com>
Cc:     Feng Tang <feng.tang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>, dave.hansen@intel.com,
        ying.huang@intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Christoph Lameter <cl@linux.com>
References: <20201104071308.GN21990@dhcp22.suse.cz>
 <20201104073826.GA15700@shbuild999.sh.intel.com>
 <20201104075819.GA10052@dhcp22.suse.cz>
 <20201104084021.GB15700@shbuild999.sh.intel.com>
 <20201104085343.GA18718@dhcp22.suse.cz>
 <20201105014028.GA86777@shbuild999.sh.intel.com>
 <20201105120818.GC21348@dhcp22.suse.cz>
 <4029c079-b1f3-f290-26b6-a819c52f5200@suse.cz>
 <20201105125828.GG21348@dhcp22.suse.cz>
 <b04a2c6f-160a-fe8d-05a0-0c68c65b369a@suse.cz>
 <20201105131957.GI21348@dhcp22.suse.cz>
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [RFC PATCH 0/2] mm: fix OOMs for binding workloads to movable
 zone only node
Message-ID: <222708b7-73e3-65ea-b4db-0ef3b857463d@suse.cz>
Date:   Thu, 5 Nov 2020 14:34:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201105131957.GI21348@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/5/20 2:19 PM, Michal Hocko wrote:
> On Thu 05-11-20 14:14:25, Vlastimil Babka wrote:
>> On 11/5/20 1:58 PM, Michal Hocko wrote:
>> > On Thu 05-11-20 13:53:24, Vlastimil Babka wrote:
>> > > On 11/5/20 1:08 PM, Michal Hocko wrote:
>> > > > On Thu 05-11-20 09:40:28, Feng Tang wrote:
>> > > > > > > Could you be more specific? This sounds like a bug. Allocations
>> > > > > > shouldn't spill over to a node which is not in the cpuset. There are few
>> > > > > > exceptions like IRQ context but that shouldn't happen regurarly.
>> > > > > > > I mean when the docker starts, it will spawn many processes
>> > > which obey
>> > > > > the mem binding set, and they have some kernel page requests, which got
>> > > > > successfully allocated, like the following callstack:
>> > > > > > > 	[  567.044953] CPU: 1 PID: 2021 Comm: runc:[1:CHILD]
>> > > Tainted: G        W I       5.9.0-rc8+ #6
>> > > > > 	[  567.044956] Hardware name:  /NUC6i5SYB, BIOS SYSKLi35.86A.0051.2016.0804.1114 08/04/2016
>> > > > > 	[  567.044958] Call Trace:
>> > > > > 	[  567.044972]  dump_stack+0x74/0x9a
>> > > > > 	[  567.044978]  __alloc_pages_nodemask.cold+0x22/0xe5
>> > > > > 	[  567.044986]  alloc_pages_current+0x87/0xe0
>> > > > > 	[  567.044991]  allocate_slab+0x2e5/0x4f0
>> > > > > 	[  567.044996]  ___slab_alloc+0x380/0x5d0
>> > > > > 	[  567.045021]  __slab_alloc+0x20/0x40
>> > > > > 	[  567.045025]  kmem_cache_alloc+0x2a0/0x2e0
>> > > > > 	[  567.045033]  mqueue_alloc_inode+0x1a/0x30
>> > > > > 	[  567.045041]  alloc_inode+0x22/0xa0
>> > > > > 	[  567.045045]  new_inode_pseudo+0x12/0x60
>> > > > > 	[  567.045049]  new_inode+0x17/0x30
>> > > > > 	[  567.045052]  mqueue_get_inode+0x45/0x3b0
>> > > > > 	[  567.045060]  mqueue_fill_super+0x41/0x70
>> > > > > 	[  567.045067]  vfs_get_super+0x7f/0x100
>> > > > > 	[  567.045074]  get_tree_keyed+0x1d/0x20
>> > > > > 	[  567.045080]  mqueue_get_tree+0x1c/0x20
>> > > > > 	[  567.045086]  vfs_get_tree+0x2a/0xc0
>> > > > > 	[  567.045092]  fc_mount+0x13/0x50
>> > > > > 	[  567.045099]  mq_create_mount+0x92/0xe0
>> > > > > 	[  567.045102]  mq_init_ns+0x3b/0x50
>> > > > > 	[  567.045106]  copy_ipcs+0x10a/0x1b0
>> > > > > 	[  567.045113]  create_new_namespaces+0xa6/0x2b0
>> > > > > 	[  567.045118]  unshare_nsproxy_namespaces+0x5a/0xb0
>> > > > > 	[  567.045124]  ksys_unshare+0x19f/0x360
>> > > > > 	[  567.045129]  __x64_sys_unshare+0x12/0x20
>> > > > > 	[  567.045135]  do_syscall_64+0x38/0x90
>> > > > > 	[  567.045143]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
>> > > > > > > For it, the __alloc_pages_nodemask() will first try
>> > > process's targed
>> > > > > nodemask(unmovable node here), and there is no availabe zone, so it
>> > > > > goes with the NULL nodemask, and get a page in the slowpath.
>> > > > > OK, I see your point now. I was not aware of the slab allocator
>> > > not
>> > > > following cpusets. Sounds like a bug to me.
>> > > 
>> > > SLAB and SLUB seem to not care about cpusets in the fast path.
>> > 
>> > Is a fallback to a different node which is outside of the cpuset
>> > possible?
>> 
>> AFAICS anything in per-cpu cache will be allocated without looking at the
>> cpuset, so it can be outside of the cpuset. In SLUB slowpath,
>> get_partial_node() looking for fallback on the same node will also not look
>> at cpuset. get_any_partial() looking for a fallback allocation on any node
>> does check cpuset_zone_allowed() and obey it strictly. A fallback to page
>> allocator will obey whatever page allocator obeys.
> 
> IIUC this means that if there is no strong CPU binding to cpuset nodes
> then a runaway is possible. Albeit only partially and relying on
> somebody to fill up pcp object caches, right?

Seems so.

> Is that an overlook or a decision design or a performance optimization?
  ... yes :)

More seriously, let's ask Christoph, as that code goes all the way to first SLUB 
commit.
On SLAB side, it would seem percpu caches came first, then cpuset support was 
added for page allocator, but SLAB was oblivious until it learned some of it in 
commit 765c4507af71c to properly support __GFP_THISNODE.

My guess is that the amount of cpuset constraint violation through percpu caches 
was never considered to be a problem serious enough to justify making the 
fastpaths slower.
