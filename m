Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C4E8285FAA
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 15:01:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728386AbgJGNB3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 09:01:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:56584 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728371AbgJGNB2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 09:01:28 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C61D5AE9A;
        Wed,  7 Oct 2020 13:01:27 +0000 (UTC)
Date:   Wed, 7 Oct 2020 14:01:25 +0100
From:   Mel Gorman <mgorman@suse.de>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <fweisbecker@suse.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [RFC PATCH] kernel: allow to configure PREEMPT_NONE,
 PREEMPT_VOLUNTARY on kernel command line
Message-ID: <20201007130125.GI3165@suse.de>
References: <20201007120401.11200-1-mhocko@kernel.org>
 <20201007121939.GE2628@hirez.programming.kicks-ass.net>
 <20201007122923.GJ29020@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20201007122923.GJ29020@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 07, 2020 at 02:29:23PM +0200, Michal Hocko wrote:
> On Wed 07-10-20 14:19:39, Peter Zijlstra wrote:
> > On Wed, Oct 07, 2020 at 02:04:01PM +0200, Michal Hocko wrote:
> > > From: Michal Hocko <mhocko@suse.com>
> > > 
> > > Many people are still relying on pre built distribution kernels and so
> > > distributions have to provide mutliple kernel flavors to offer different
> > > preemption models. Most of them are providing PREEMPT_NONE for typical
> > > server deployments and PREEMPT_VOLUNTARY for desktop users.
> > 
> > Is there actually a benefit to NONE? We were recently talking about
> > removing it.
> 
> I believe Mel can provide much better insight. We have been historically using
> PREEMPT_NONE for our enterprise customers mostly for nice throughput
> numbers. Many users are really targeting throughput much more than
> latencies. My understanding is that even though VOLUNTARY preemption model
> doesn't add too many preemption points on top of NONE it is still
> something that is observable (IIRC 2-3% on hackbench).
>  

It's marginal from the tests I ran but that was based on 5.3. At worst,
it looked like roughly a hit but a lot of loads simply didn't notice.
However, it might vary between architectures that I cannot cover or
workloads that I didn't consider.  As the impact of PREEMPT_VOLUNTARY
depends on where cond_resched and might_sleep is used, it's also something
that can vary over time. The intent was that by having the command-line
switch, a user could test the switch if there was a suspicion that a
regression was related to PREEMPT_VOLUNTARY as opposed to telling them
"tough, that's the reality now".

-- 
Mel Gorman
SUSE Labs
