Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C4FD2B67B3
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 15:44:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728915AbgKQOnz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 09:43:55 -0500
Received: from outbound-smtp24.blacknight.com ([81.17.249.192]:55616 "EHLO
        outbound-smtp24.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728285AbgKQOnz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 09:43:55 -0500
Received: from mail.blacknight.com (pemlinmail01.blacknight.ie [81.17.254.10])
        by outbound-smtp24.blacknight.com (Postfix) with ESMTPS id C2C83C0F11
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 14:43:53 +0000 (GMT)
Received: (qmail 31257 invoked from network); 17 Nov 2020 14:43:53 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.22.4])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 17 Nov 2020 14:43:53 -0000
Date:   Tue, 17 Nov 2020 14:43:52 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>
Subject: Re: [PATCH 2/3] sched/numa: Allow a floating imbalance between NUMA
 nodes
Message-ID: <20201117144352.GZ3371@techsingularity.net>
References: <20201117134222.31482-1-mgorman@techsingularity.net>
 <20201117134222.31482-3-mgorman@techsingularity.net>
 <20201117141603.GM3121392@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20201117141603.GM3121392@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 17, 2020 at 03:16:03PM +0100, Peter Zijlstra wrote:
> On Tue, Nov 17, 2020 at 01:42:21PM +0000, Mel Gorman wrote:
> > This patch revisits the possibility that NUMA nodes can be imbalanced
> > until 25% of the CPUs are occupied. The reasoning behind 25% is somewhat
> > superficial -- it's half the cores when HT is enabled.  At higher
> > utilisations, balancing should continue as normal and keep things even
> > until scheduler domains are fully busy or over utilised.
> 
> Do we want to make that shift depend on the actual SMT factor?

I considered it but decided against it. I wanted the balance point to
be somewhere below SMT because select_idle_sibling tries to avoid SMT
sharing so I didn't want a point where SMT sharing caused more problems
than memory locality. However, I worried that picking a different imbalance
point depending on SMT would be surprising to some.

-- 
Mel Gorman
SUSE Labs
