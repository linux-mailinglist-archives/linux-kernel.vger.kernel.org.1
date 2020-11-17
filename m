Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EABC2B67B6
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 15:46:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728933AbgKQOop (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 09:44:45 -0500
Received: from outbound-smtp21.blacknight.com ([81.17.249.41]:47110 "EHLO
        outbound-smtp21.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728740AbgKQOom (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 09:44:42 -0500
Received: from mail.blacknight.com (pemlinmail05.blacknight.ie [81.17.254.26])
        by outbound-smtp21.blacknight.com (Postfix) with ESMTPS id 58372CCC42
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 14:44:40 +0000 (GMT)
Received: (qmail 16539 invoked from network); 17 Nov 2020 14:44:40 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.22.4])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 17 Nov 2020 14:44:40 -0000
Date:   Tue, 17 Nov 2020 14:44:38 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>
Subject: Re: [PATCH 2/3] sched/numa: Allow a floating imbalance between NUMA
 nodes
Message-ID: <20201117144438.GA3371@techsingularity.net>
References: <20201117134222.31482-1-mgorman@techsingularity.net>
 <20201117134222.31482-3-mgorman@techsingularity.net>
 <CAKfTPtBj1nJhQrsAoH0mBrc9Md+_icNJuWx7P=yQbqM2fYCAwg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <CAKfTPtBj1nJhQrsAoH0mBrc9Md+_icNJuWx7P=yQbqM2fYCAwg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 17, 2020 at 03:24:56PM +0100, Vincent Guittot wrote:
> On Tue, 17 Nov 2020 at 14:42, Mel Gorman <mgorman@techsingularity.net> wrote:
> >
> > Currently, an imbalance is only allowed when a destination node
> > is almost completely idle. This solved one basic class of problems
> > and was the cautious approach.
> >
> > This patch revisits the possibility that NUMA nodes can be imbalanced
> > until 25% of the CPUs are occupied. The reasoning behind 25% is somewhat
> > superficial -- it's half the cores when HT is enabled.  At higher
> > utilisations, balancing should continue as normal and keep things even
> > until scheduler domains are fully busy or over utilised.
> 
> This reminds me previous discussions on the same topic: how much
> imbalance is allowed that will not screw up the bandwidth of the node
> I'm worried that there is no topology insight in the decision like
> hyperthreading, or number of cpus in the LLC
> 

We still don't have a good answer for that. It could be a tunable I guess
but it would be horrible to tune properly.

-- 
Mel Gorman
SUSE Labs
