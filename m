Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C185426D116
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 04:25:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726115AbgIQCZQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 22:25:16 -0400
Received: from mga02.intel.com ([134.134.136.20]:8729 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726009AbgIQCZO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 22:25:14 -0400
X-Greylist: delayed 427 seconds by postgrey-1.27 at vger.kernel.org; Wed, 16 Sep 2020 22:25:14 EDT
IronPort-SDR: RLPAwYg3QBZ+OcJmLAdwnLzIx/yx4+eS+Nkd5Z6QRHEUyi5UZjvPSTybuSZMVyaZ7MPKu8V+1u
 hvrbCpatoB1w==
X-IronPort-AV: E=McAfee;i="6000,8403,9746"; a="147293194"
X-IronPort-AV: E=Sophos;i="5.76,434,1592895600"; 
   d="scan'208";a="147293194"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2020 19:18:07 -0700
IronPort-SDR: RyW/XF2QCFYjBGFf4yPbqq0p+JS78SW5ZGhiITYlXrKKk3I9Vna4p8LPaDYdOgUXbMXlKWQoiM
 OSgGhpMn3p9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,434,1592895600"; 
   d="scan'208";a="344116004"
Received: from yhuang-dev.sh.intel.com (HELO yhuang-dev) ([10.239.159.164])
  by FMSMGA003.fm.intel.com with ESMTP; 16 Sep 2020 19:18:04 -0700
From:   "Huang\, Ying" <ying.huang@intel.com>
To:     peterz@infradead.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>, Mel Gorman <mgorman@suse.de>,
        Rik van Riel <riel@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "Matthew Wilcox \(Oracle\)" <willy@infradead.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>,
        David Rientjes <rientjes@google.com>
Subject: Re: [RFC] autonuma: Migrate on fault among multiple bound nodes
References: <20200916005936.232788-1-ying.huang@intel.com>
        <20200916081052.GI2674@hirez.programming.kicks-ass.net>
Date:   Thu, 17 Sep 2020 10:18:03 +0800
In-Reply-To: <20200916081052.GI2674@hirez.programming.kicks-ass.net>
        (peterz@infradead.org's message of "Wed, 16 Sep 2020 10:10:52 +0200")
Message-ID: <87ft7hrvs4.fsf@yhuang-dev.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

peterz@infradead.org writes:

> On Wed, Sep 16, 2020 at 08:59:36AM +0800, Huang Ying wrote:
>> +static bool mpol_may_mof(struct mempolicy *pol)
>> +{
>> +	/* May migrate among bound nodes for MPOL_BIND */
>> +	return pol->flags & MPOL_F_MOF ||
>> +		(pol->mode == MPOL_BIND && nodes_weight(pol->v.nodes) > 1);
>> +}
>
> This is weird, why not just set F_MOF on the policy?
>
> In fact, why wouldn't something like:
>
>   mbind(.mode=MPOL_BIND, .flags=MPOL_MF_LAZY);
>
> work today? Afaict MF_LAZY will unconditionally result in M_MOF.

Another question.

This means for all VMAs that are mbind() without MPOL_MF_LAZY and tasks
which binds memory via set_mempolicy(), we will not try to optimize
their page placement among the bound nodes even if sysctl knob
kernel.numa_balancing is enabled.

Is this the intended behavior?  Although we enable AutoNUMA globally, we
will not try to use it in any places if possible.  In some places, it
needs to be enabled again.

Best Regards,
Huang, Ying
