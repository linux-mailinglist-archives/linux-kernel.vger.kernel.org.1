Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 925F62A8E66
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 05:33:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726184AbgKFEcu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 23:32:50 -0500
Received: from mga18.intel.com ([134.134.136.126]:15061 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725616AbgKFEct (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 23:32:49 -0500
IronPort-SDR: coM2nO51e5UofuKDDSEz9R+wJtbbggwrYjwB4aMOPuhkaTxESvAiqUOfjh+5eaQDat1VpQHsSZ
 nv3fpV+0IhWQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9796"; a="157280271"
X-IronPort-AV: E=Sophos;i="5.77,455,1596524400"; 
   d="scan'208";a="157280271"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2020 20:32:47 -0800
IronPort-SDR: fX9GZUa01MB4tbYWMM4a4rW8LnXAuRWyCmQvf4RV08oLFvMn5d1WfOrXi6mvOvQR286HC3SdZd
 EciBD0uUvurg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,455,1596524400"; 
   d="scan'208";a="528210883"
Received: from yhuang-dev.sh.intel.com (HELO yhuang-dev) ([10.239.159.65])
  by fmsmga006.fm.intel.com with ESMTP; 05 Nov 2020 20:32:45 -0800
From:   "Huang\, Ying" <ying.huang@intel.com>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Feng Tang <feng.tang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>, dave.hansen@intel.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/2] mm: fix OOMs for binding workloads to movable zone only node
References: <1604470210-124827-1-git-send-email-feng.tang@intel.com>
        <20201104071308.GN21990@dhcp22.suse.cz>
        <20201104073826.GA15700@shbuild999.sh.intel.com>
        <20201104075819.GA10052@dhcp22.suse.cz>
        <20201104084021.GB15700@shbuild999.sh.intel.com>
        <20201104085343.GA18718@dhcp22.suse.cz>
        <20201105014028.GA86777@shbuild999.sh.intel.com>
        <20201105120818.GC21348@dhcp22.suse.cz>
Date:   Fri, 06 Nov 2020 12:32:44 +0800
In-Reply-To: <20201105120818.GC21348@dhcp22.suse.cz> (Michal Hocko's message
        of "Thu, 5 Nov 2020 13:08:18 +0100")
Message-ID: <87zh3vp0k3.fsf@yhuang-dev.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Michal Hocko <mhocko@suse.com> writes:

> On Thu 05-11-20 09:40:28, Feng Tang wrote:
>> On Wed, Nov 04, 2020 at 09:53:43AM +0100, Michal Hocko wrote:
>>  
>> > > > As I've said in reply to your second patch. I think we can make the oom
>> > > > killer behavior more sensible in this misconfigured cases but I do not
>> > > > think we want break the cpuset isolation for such a configuration.
>> > > 
>> > > Do you mean we skip the killing and just let the allocation fail? We've
>> > > checked the oom killer code first, when the oom happens, both DRAM
>> > > node and unmovable node have lots of free memory, and killing process
>> > > won't improve the situation.
>> > 
>> > We already do skip oom killer and fail for lowmem allocation requests already.
>> > This is similar in some sense. Another option would be to kill the
>> > allocating context which will have less corner cases potentially because
>> > some allocation failures might be unexpected.
>> 
>> Yes, this can avoid the helpless oom killing to kill a good process(no
>> memory pressure at all)
>> 
>> And I think the important thing is to judge whether this usage (binding
>> docker like workload to unmovable node) is a valid case :) 
>
> I am confused. Why wouldbe an unmovable node a problem. Movable
> allocations can be satisfied from the Zone Normal just fine. It is other
> way around that is a problem.
>
>> Initially, I thought it invalid too, but later think it still makes some
>> sense for the 2 cases:
>>     * user want to bind his workload to one node(most of user space
>>       memory) to avoid cross-node traffic, and that node happens to
>>       be configured as unmovable
>
> See above
>
>>     * one small DRAM node + big PMEM node, and memory latency insensitive
>>       workload could be bound to the cheaper unmovable PMEM node
>
> Please elaborate some more. As long as you have movable and normal nodes
> then this should be possible with a deal of care - most notably the
> movable:kernel ratio memory shouldn't be too big.
>
> Besides that why does PMEM node have to be MOVABLE only in the first
> place?

The performance of PMEM is much worse than that of DRAM.  If we found
that some pages on PMEM are accessed frequently (hot), we may want to
move them to DRAM to optimize the system performance.  If the unmovable
pages are allocated on PMEM and hot, it's possible that we cannot move
the pages to DRAM unless rebooting the system.  So we think we should
make the PMEM nodes to be MOVABLE only.

Best Regards,
Huang, Ying

