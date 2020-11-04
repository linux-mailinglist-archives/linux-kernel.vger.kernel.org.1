Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 854862A5DE5
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 06:37:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727986AbgKDFhD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 00:37:03 -0500
Received: from mga07.intel.com ([134.134.136.100]:51983 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726018AbgKDFhD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 00:37:03 -0500
IronPort-SDR: S14LxW9kl/ud/k6P+9qrWMA+s2o/9vIbVSrLK2XZWNud04PzfrXna4xDbKUkswdPoH6TxDQ9wq
 86KHDYS8Xihw==
X-IronPort-AV: E=McAfee;i="6000,8403,9794"; a="233332657"
X-IronPort-AV: E=Sophos;i="5.77,450,1596524400"; 
   d="scan'208";a="233332657"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2020 21:37:02 -0800
IronPort-SDR: JBmoy5Ga3Tv7yI/iYiNFRnrmamXSlr95HUuxW8mrShOJ9hOCP5H+/0OLKwJYCiCQuy+9dQD5Si
 T/ABmZUIAaIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,450,1596524400"; 
   d="scan'208";a="325484137"
Received: from yhuang-dev.sh.intel.com (HELO yhuang-dev) ([10.239.159.65])
  by orsmga006.jf.intel.com with ESMTP; 03 Nov 2020 21:36:59 -0800
From:   "Huang\, Ying" <ying.huang@intel.com>
To:     Mel Gorman <mgorman@suse.de>
Cc:     Peter Zijlstra <peterz@infradead.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>, Rik van Riel <riel@redhat.com>,
        "Johannes Weiner" <hannes@cmpxchg.org>,
        "Matthew Wilcox \(Oracle\)" <willy@infradead.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>,
        David Rientjes <rientjes@google.com>
Subject: Re: [PATCH -V2 2/2] autonuma: Migrate on fault among multiple bound nodes
References: <20201028023411.15045-1-ying.huang@intel.com>
        <20201028023411.15045-3-ying.huang@intel.com>
        <20201102111717.GB3306@suse.de>
Date:   Wed, 04 Nov 2020 13:36:58 +0800
In-Reply-To: <20201102111717.GB3306@suse.de> (Mel Gorman's message of "Mon, 2
        Nov 2020 11:17:17 +0000")
Message-ID: <87eel9wumd.fsf@yhuang-dev.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Mel,

Thanks for comments!

Mel Gorman <mgorman@suse.de> writes:

> On Wed, Oct 28, 2020 at 10:34:11AM +0800, Huang Ying wrote:
>> Now, AutoNUMA can only optimize the page placement among the NUMA nodes if the
>> default memory policy is used.  Because the memory policy specified explicitly
>> should take precedence.  But this seems too strict in some situations.  For
>> example, on a system with 4 NUMA nodes, if the memory of an application is bound
>> to the node 0 and 1, AutoNUMA can potentially migrate the pages between the node
>> 0 and 1 to reduce cross-node accessing without breaking the explicit memory
>> binding policy.
>> 
>> So in this patch, if mbind(.mode=MPOL_BIND, .flags=MPOL_MF_LAZY) is used to bind
>> the memory of the application to multiple nodes, and in the hint page fault
>> handler both the faulting page node and the accessing node are in the policy
>> nodemask, the page will be tried to be migrated to the accessing node to reduce
>> the cross-node accessing.
>> 
>> [Peter Zijlstra: provided the simplified implementation method.]
>> 
>> Questions:
>> 
>> Sysctl knob kernel.numa_balancing can enable/disable AutoNUMA optimizing
>> globally.  But for the memory areas that are bound to multiple NUMA nodes, even
>> if the AutoNUMA is enabled globally via the sysctl knob, we still need to enable
>> AutoNUMA again with a special flag.  Why not just optimize the page placement if
>> possible as long as AutoNUMA is enabled globally?  The interface would look
>> simpler with that.
>> 
>> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
>
> I've no specific objection to the patch or the name change. I can't
> remember exactly why I picked the name, it was 8 years ago but I think it
> was because the policy represented the most basic possible approach that
> could be done without any attempt at being intelligent and established
> a baseline. The intent was that anything built on top had to be better
> than the most basic policy imaginable. The name reflected the dictionary
> definition at the time and happened to match the acronym closely enough
> and I wanted to make it absolutely clear to reviewers that the policy
> was not good enough (ruling out MPOL_BASIC or variants thereof) even if
> it happened to work for some workload and there was no intent to report
> it to the userspace API.
>
> The only hazard with the patch is that applications that use MPOL_BIND
> on multiple nodes may now incur some NUMA balancing overhead due to
> trapping faults and migrations.

For this specific version of patch, I don't think this will happen.
Because now, MPOL_F_MOF need to be set in struct mempolicy, for
MPOL_BIND, only if mbind() syscall is called with MPOL_MF_LAZY, that
will be the case.  So I think most workloads will not be affected by
this patch.  The feature is opt-in.

But from another point of view, I suggest to remove the constraints of
MPOL_F_MOF in the future.  If the overhead of AutoNUMA isn't acceptable,
why not just disable AutoNUMA globally via sysctl knob?

> It might still end up being better but I was not aware of a
> *realistic* workload that binds to multiple nodes
> deliberately. Generally I expect if an application is binding, it's
> binding to one local node.

Yes.  It's not popular configuration for now.  But for the memory
tiering system with both DRAM and PMEM, the DRAM and PMEM in one socket
will become 2 NUMA nodes.  To avoid too much cross-socket memory
accessing, but take advantage of both the DRAM and PMEM, the workload
can be bound to 2 NUMA nodes (DRAM and PMEM).

> If it shows up in regressions, it'll be interesting to get a detailed
> description of the workload. Pay particular attention to if THP is
> disabled as I learned relatively recently that NUMA balancing with THP
> disabled has higher overhead (which is hardly surprising).

Got it!

> Lacking data or a specific objection
>
> Acked-by: Mel Gorman <mgorman@suse.de>

Thanks!

Best Regards,
Huang, Ying
