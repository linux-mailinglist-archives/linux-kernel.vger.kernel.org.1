Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9F1F2A9051
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 08:29:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726466AbgKFH3E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 02:29:04 -0500
Received: from mga18.intel.com ([134.134.136.126]:30669 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725830AbgKFH3E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 02:29:04 -0500
IronPort-SDR: QUl+KxmImdBiN9AZAriuCLrFgp60TwRXhDaXI1PuHYzIf9skOEoVEvA4TgoLmg3hLsZs/8Df9l
 BiBUbgL0BAQA==
X-IronPort-AV: E=McAfee;i="6000,8403,9796"; a="157292853"
X-IronPort-AV: E=Sophos;i="5.77,455,1596524400"; 
   d="scan'208";a="157292853"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2020 23:29:03 -0800
IronPort-SDR: 7V1IJ6pjk8oQLtLEcGW9OjlhbuwWfMdcaCDbIGN/97HD6vuY+I3SKCm+h2OvjHDbOkruujbqKH
 s65cIa9Mlwkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,455,1596524400"; 
   d="scan'208";a="354616998"
Received: from yhuang-dev.sh.intel.com (HELO yhuang-dev) ([10.239.159.65])
  by fmsmga004.fm.intel.com with ESMTP; 05 Nov 2020 23:29:00 -0800
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
        David Rientjes <rientjes@google.com>, ben.widawsky@intel.com
Subject: Re: [PATCH -V2 2/2] autonuma: Migrate on fault among multiple bound nodes
References: <20201028023411.15045-1-ying.huang@intel.com>
        <20201028023411.15045-3-ying.huang@intel.com>
        <20201102111717.GB3306@suse.de> <87eel9wumd.fsf@yhuang-dev.intel.com>
        <20201105112523.GQ3306@suse.de>
Date:   Fri, 06 Nov 2020 15:28:59 +0800
In-Reply-To: <20201105112523.GQ3306@suse.de> (Mel Gorman's message of "Thu, 5
        Nov 2020 11:25:23 +0000")
Message-ID: <87v9ejosec.fsf@yhuang-dev.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mel Gorman <mgorman@suse.de> writes:

> On Wed, Nov 04, 2020 at 01:36:58PM +0800, Huang, Ying wrote:
>> But from another point of view, I suggest to remove the constraints of
>> MPOL_F_MOF in the future.  If the overhead of AutoNUMA isn't acceptable,
>> why not just disable AutoNUMA globally via sysctl knob?
>> 
>
> Because it's a double edged sword. NUMA Balancing can make a workload
> faster while still incurring more overhead than it should -- particularly
> when threads are involved rescanning the same or unrelated regions.
> Global disabling only really should happen when an application is running
> that is the only application on the machine and has full NUMA awareness.

Got it.  So NUMA Balancing may in generally benefit some workloads but
hurt some other workloads on one machine.  So we need a method to
enable/disable NUMA Balancing for one workload.  Previously, this is
done via the explicit NUMA policy.  If some explicit NUMA policy is
specified, NUMA Balancing is disabled for the memory region or the
thread.  And this can be reverted again for a memory region via
MPOL_MF_LAZY.  It appears that we lacks MPOL_MF_LAZY for the thread yet.

>> > It might still end up being better but I was not aware of a
>> > *realistic* workload that binds to multiple nodes
>> > deliberately. Generally I expect if an application is binding, it's
>> > binding to one local node.
>> 
>> Yes.  It's not popular configuration for now.  But for the memory
>> tiering system with both DRAM and PMEM, the DRAM and PMEM in one socket
>> will become 2 NUMA nodes.  To avoid too much cross-socket memory
>> accessing, but take advantage of both the DRAM and PMEM, the workload
>> can be bound to 2 NUMA nodes (DRAM and PMEM).
>> 
>
> Ok, that may lead to unpredictable performance as it'll have variable
> performance with limited control of the "important" applications that
> should use DRAM over PMEM. That's a long road but the step is not
> incompatible with the long-term goal.

Yes.  Ben Widawsky is working on a patchset to make it possible to
prefer the remote DRAM instead of the local PMEM as follows,

https://lore.kernel.org/linux-mm/20200630212517.308045-1-ben.widawsky@intel.com/

Best Regards,
Huang, Ying
