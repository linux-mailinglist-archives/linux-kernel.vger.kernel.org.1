Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26C892AE939
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 07:50:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725975AbgKKGuN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 01:50:13 -0500
Received: from mga05.intel.com ([192.55.52.43]:30347 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725882AbgKKGuM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 01:50:12 -0500
IronPort-SDR: KF0kMh6MvV/Md5RoC3pfXIrWibP9RRrt5HZHBjWqyjsbeI7ACdvYfKXpS3IOzCd2TQ4XntkR03
 uo69grgpLcnw==
X-IronPort-AV: E=McAfee;i="6000,8403,9801"; a="254813109"
X-IronPort-AV: E=Sophos;i="5.77,468,1596524400"; 
   d="scan'208";a="254813109"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2020 22:50:12 -0800
IronPort-SDR: Ps/7aR3q9CySFdV9ZwR7dKqpPUUIQ+PSDQcFNh7FTPkKcC+/I8PVN5oOidodpGLwNpkHP4vDS7
 0RYDH8C8QAQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,468,1596524400"; 
   d="scan'208";a="338984011"
Received: from yhuang-dev.sh.intel.com (HELO yhuang-dev) ([10.239.159.120])
  by orsmga002.jf.intel.com with ESMTP; 10 Nov 2020 22:50:08 -0800
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
        <20201102111717.GB3306@suse.de> <87eel9wumd.fsf@yhuang-dev.intel.com>
        <20201105112523.GQ3306@suse.de>
Date:   Wed, 11 Nov 2020 14:50:07 +0800
In-Reply-To: <20201105112523.GQ3306@suse.de> (Mel Gorman's message of "Thu, 5
        Nov 2020 11:25:23 +0000")
Message-ID: <87blg48k0w.fsf@yhuang-dev.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Mel,

Mel Gorman <mgorman@suse.de> writes:

> On Wed, Nov 04, 2020 at 01:36:58PM +0800, Huang, Ying wrote:
>> > I've no specific objection to the patch or the name change. I can't
>> > remember exactly why I picked the name, it was 8 years ago but I think it
>> > was because the policy represented the most basic possible approach that
>> > could be done without any attempt at being intelligent and established
>> > a baseline. The intent was that anything built on top had to be better
>> > than the most basic policy imaginable. The name reflected the dictionary
>> > definition at the time and happened to match the acronym closely enough
>> > and I wanted to make it absolutely clear to reviewers that the policy
>> > was not good enough (ruling out MPOL_BASIC or variants thereof) even if
>> > it happened to work for some workload and there was no intent to report
>> > it to the userspace API.
>> >
>> > The only hazard with the patch is that applications that use MPOL_BIND
>> > on multiple nodes may now incur some NUMA balancing overhead due to
>> > trapping faults and migrations.
>> 
>> For this specific version of patch, I don't think this will happen.
>> Because now, MPOL_F_MOF need to be set in struct mempolicy, for
>> MPOL_BIND, only if mbind() syscall is called with MPOL_MF_LAZY, that
>> will be the case.  So I think most workloads will not be affected by
>> this patch.  The feature is opt-in.
>> 
>
> Ok.

I just found MPOL_MF_LAZY is disabled now.  And as in commit
a720094ded8c ("mm: mempolicy: Hide MPOL_NOOP and MPOL_MF_LAZY from
userspace for now"), the ABI needs to be revisted before exporting to
the user space formally.  Sorry about that, I should have found that
earlier.

Think about that.  I think MPOL_MF_LAZY is tied with MPOL_MF_MOVE, so
it's semantics isn't good for the purpose of the patch.  So I have
rewritten the patch and the description and sent it as follows, can you
help to review it?

https://lore.kernel.org/lkml/20201111063717.186589-1-ying.huang@intel.com/

Best Regards,
Huang, Ying
