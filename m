Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F3832D173C
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 18:14:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726841AbgLGRLQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 12:11:16 -0500
Received: from outbound-smtp48.blacknight.com ([46.22.136.219]:47191 "EHLO
        outbound-smtp48.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725863AbgLGRLQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 12:11:16 -0500
Received: from mail.blacknight.com (pemlinmail06.blacknight.ie [81.17.255.152])
        by outbound-smtp48.blacknight.com (Postfix) with ESMTPS id 48CF3FA7DA
        for <linux-kernel@vger.kernel.org>; Mon,  7 Dec 2020 17:10:24 +0000 (GMT)
Received: (qmail 9767 invoked from network); 7 Dec 2020 17:10:23 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.22.4])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 7 Dec 2020 17:10:23 -0000
Date:   Mon, 7 Dec 2020 17:10:21 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Aubrey Li <aubrey.li@linux.intel.com>, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        valentin.schneider@arm.com, qais.yousef@arm.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        tim.c.chen@linux.intel.com, linux-kernel@vger.kernel.org,
        Mel Gorman <mgorman@suse.de>, Jiang Biao <benbjiang@gmail.com>
Subject: Re: [RFC PATCH v5] sched/fair: select idle cpu from idle cpumask for
 task wakeup
Message-ID: <20201207171021.GF3371@techsingularity.net>
References: <20201118043113.53128-1-aubrey.li@linux.intel.com>
 <20201207155015.GQ3040@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20201207155015.GQ3040@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 07, 2020 at 04:50:15PM +0100, Peter Zijlstra wrote:
> On Wed, Nov 18, 2020 at 12:31:13PM +0800, Aubrey Li wrote:
> > Add idle cpumask to track idle cpus in sched domain. When a CPU
> > enters idle, if the idle driver indicates to stop tick, this CPU
> > is set in the idle cpumask to be a wakeup target. And if the CPU
> > is not in idle, the CPU is cleared in idle cpumask during scheduler
> > tick to ratelimit idle cpumask update.
> 
> So this will only have SIS consider CPUs that have the tick stopped?
> That might affect the facebook tail-latency workloads quite a bit.
> 

This is the concern I had as well. That's why patch "sched/fair: Avoid
revisiting CPUs multiple times during select_idle_sibling" was created. The
intent was that a mask could be used as a hint about what runqueues to
look at first but continue looking at other runqueues without examining
the same runqueue twice. While the patch would not be merged on its own,
it may still be relevant in the context of an idle CPU mask depending on
how up to date it is.

-- 
Mel Gorman
SUSE Labs
