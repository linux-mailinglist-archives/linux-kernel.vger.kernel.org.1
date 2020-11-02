Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 889742A28DD
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 12:17:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728454AbgKBLRX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 06:17:23 -0500
Received: from mx2.suse.de ([195.135.220.15]:53702 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728288AbgKBLRW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 06:17:22 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B52C7ABE3;
        Mon,  2 Nov 2020 11:17:20 +0000 (UTC)
Date:   Mon, 2 Nov 2020 11:17:17 +0000
From:   Mel Gorman <mgorman@suse.de>
To:     Huang Ying <ying.huang@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, linux-mm@kvack.org,
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
Message-ID: <20201102111717.GB3306@suse.de>
References: <20201028023411.15045-1-ying.huang@intel.com>
 <20201028023411.15045-3-ying.huang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20201028023411.15045-3-ying.huang@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 28, 2020 at 10:34:11AM +0800, Huang Ying wrote:
> Now, AutoNUMA can only optimize the page placement among the NUMA nodes if the
> default memory policy is used.  Because the memory policy specified explicitly
> should take precedence.  But this seems too strict in some situations.  For
> example, on a system with 4 NUMA nodes, if the memory of an application is bound
> to the node 0 and 1, AutoNUMA can potentially migrate the pages between the node
> 0 and 1 to reduce cross-node accessing without breaking the explicit memory
> binding policy.
> 
> So in this patch, if mbind(.mode=MPOL_BIND, .flags=MPOL_MF_LAZY) is used to bind
> the memory of the application to multiple nodes, and in the hint page fault
> handler both the faulting page node and the accessing node are in the policy
> nodemask, the page will be tried to be migrated to the accessing node to reduce
> the cross-node accessing.
> 
> [Peter Zijlstra: provided the simplified implementation method.]
> 
> Questions:
> 
> Sysctl knob kernel.numa_balancing can enable/disable AutoNUMA optimizing
> globally.  But for the memory areas that are bound to multiple NUMA nodes, even
> if the AutoNUMA is enabled globally via the sysctl knob, we still need to enable
> AutoNUMA again with a special flag.  Why not just optimize the page placement if
> possible as long as AutoNUMA is enabled globally?  The interface would look
> simpler with that.
> 
> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>

I've no specific objection to the patch or the name change. I can't
remember exactly why I picked the name, it was 8 years ago but I think it
was because the policy represented the most basic possible approach that
could be done without any attempt at being intelligent and established
a baseline. The intent was that anything built on top had to be better
than the most basic policy imaginable. The name reflected the dictionary
definition at the time and happened to match the acronym closely enough
and I wanted to make it absolutely clear to reviewers that the policy
was not good enough (ruling out MPOL_BASIC or variants thereof) even if
it happened to work for some workload and there was no intent to report
it to the userspace API.

The only hazard with the patch is that applications that use MPOL_BIND
on multiple nodes may now incur some NUMA balancing overhead due to
trapping faults and migrations. It might still end up being better but
I was not aware of a *realistic* workload that binds to multiple nodes
deliberately. Generally I expect if an application is binding, it's
binding to one local node.

If it shows up in regressions, it'll be interesting to get a detailed
description of the workload. Pay particular attention to if THP is
disabled as I learned relatively recently that NUMA balancing with THP
disabled has higher overhead (which is hardly surprising).

Lacking data or a specific objection

Acked-by: Mel Gorman <mgorman@suse.de>

-- 
Mel Gorman
SUSE Labs
