Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BF9B2A921F
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 10:09:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbgKFJJH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 04:09:07 -0500
Received: from mga18.intel.com ([134.134.136.126]:39166 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725830AbgKFJJE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 04:09:04 -0500
IronPort-SDR: lqvkCOzMtYSOfgkgrmVoQAnJJOUrLAg4bLkeBzJOOri8vxj9fgI8oXXC8BVBSKWZxnLZimNmH4
 EzzsKEUud9/g==
X-IronPort-AV: E=McAfee;i="6000,8403,9796"; a="157301827"
X-IronPort-AV: E=Sophos;i="5.77,456,1596524400"; 
   d="scan'208";a="157301827"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2020 01:09:03 -0800
IronPort-SDR: TBtlvc0eJCtMQMatJj0VpxkULfLhPXMNTgUi24B3j6jrI8K2agWhjEWT28LxL8i2Vfs7ZTyFmU
 /1qmmUp7jkFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,456,1596524400"; 
   d="scan'208";a="354660587"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.147.98])
  by fmsmga004.fm.intel.com with ESMTP; 06 Nov 2020 01:08:58 -0800
Date:   Fri, 6 Nov 2020 17:08:57 +0800
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
Message-ID: <20201106090857.GB129085@shbuild999.sh.intel.com>
References: <20201105014028.GA86777@shbuild999.sh.intel.com>
 <20201105120818.GC21348@dhcp22.suse.cz>
 <4029c079-b1f3-f290-26b6-a819c52f5200@suse.cz>
 <20201105125828.GG21348@dhcp22.suse.cz>
 <20201105130710.GB16525@shbuild999.sh.intel.com>
 <20201105131245.GH21348@dhcp22.suse.cz>
 <20201105134305.GA16424@shbuild999.sh.intel.com>
 <20201105161612.GM21348@dhcp22.suse.cz>
 <20201106070656.GA129085@shbuild999.sh.intel.com>
 <20201106081026.GB7247@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201106081026.GB7247@dhcp22.suse.cz>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 06, 2020 at 09:10:26AM +0100, Michal Hocko wrote:
> > > > The incomming parameter nodemask is NULL, and the function will first try the
> > > > cpuset nodemask (1 here), and the zoneidx is only granted 2, which makes the
> > > > 'ac's preferred zone to be NULL. so it goes into __alloc_pages_slowpath(),
> > > > which will first set the nodemask to 'NULL', and this time it got a preferred
> > > > zone: zone DMA32 from node 0, following get_page_from_freelist will allocate
> > > > one page from that zone. 
> > > 
> > > I do not follow. Both hot and slow paths of the allocator set
> > > ALLOC_CPUSET or emulate it by mems_allowed when cpusets are nebaled
> > > IIRC. This is later enforced in get_page_from_free_list. There are some
> > > exceptions when the allocating process can run away from its cpusets -
> > > e.g. IRQs, OOM victims and few other cases but definitely not a random
> > > allocation. There might be some subtle details that have changed or I
> > > might have forgot but 
> > 
> > yes, I was confused too. IIUC, the key check inside get_page_from_freelist()
> > is 
> > 
> > 	if (cpusets_enabled() &&
> > 		(alloc_flags & ALLOC_CPUSET) &&
> > 		!__cpuset_zone_allowed(zone, gfp_mask))
> > 
> > In our case (kernel page got allocated), the first 2 conditions are true,
> > and for __cpuset_zone_allowed(), the possible place to return true is
> > checking parent cpuset's nodemask
> > 
> > 	cs = nearest_hardwall_ancestor(task_cs(current));
> > 	allowed = node_isset(node, cs->mems_allowed);
> > 
> > This will override the ALLOC_CPUSET check.
> 
> Yes and this is ok because that is defined hierarchical semantic of the
> cpusets which applies to any !hardwalled allocation. Cpusets are quite
> non intuitive. Re-reading the previous discussion I have realized that
> me trying to not go into those details might have mislead you. Let me
> try again and clarify that now.
> 
> I was talking in context of the patch you are proposing and that is a
> clear violation of the cpuset isolation. Especially for hardwalled
> setups because it allows to spill over to other nodes which shouldn't be
> possible except for few exceptions which shouldn't generate a lot of
> allocations (e.g. oom victim exiting, IRQ context).

I agree my patch is pretty hacky. As said in the cover-letter, I would
bring up this usage case, and get suggestions on how to support it.
 
> What I was not talking about, and should have been more clear about, is
> that without hardwall resp. exclusive nodes the isolation is best effort
> only for most kernel allocation requests (or more specifically those
> without __GFP_HARDWALL). Your patch doesn't distinguish between those
> and any non movable allocations and effectively allowed to runaway even
> for hardwalled allocations which are not movable. Those can be controlled
> by userspace very easily.

You are right, there are quiet several types of page allocations failures.
The callstack in patch 2/2 is a GFP_HIGHUSER from pipe_write, and there
are more types of kernel allocation requests which will got blocked by
the differnt  check. My RFC patch just gave a easiest one-for-all hack to
let them bypass it.

Do we need to tackle them case by case?

> I hope this clarifies it a bit more and sorry if I mislead you.

Yes, it does and many thanks for the clarifying!

- Feng

> -- 
> Michal Hocko
> SUSE Labs
