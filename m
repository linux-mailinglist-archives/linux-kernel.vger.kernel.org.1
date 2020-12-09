Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 329C82D447C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 15:38:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733099AbgLIOhX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 09:37:23 -0500
Received: from outbound-smtp20.blacknight.com ([46.22.139.247]:60987 "EHLO
        outbound-smtp20.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731331AbgLIOhW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 09:37:22 -0500
Received: from mail.blacknight.com (pemlinmail02.blacknight.ie [81.17.254.11])
        by outbound-smtp20.blacknight.com (Postfix) with ESMTPS id 49D3C1C3F43
        for <linux-kernel@vger.kernel.org>; Wed,  9 Dec 2020 14:36:23 +0000 (GMT)
Received: (qmail 10606 invoked from network); 9 Dec 2020 14:36:23 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.22.4])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 9 Dec 2020 14:36:22 -0000
Date:   Wed, 9 Dec 2020 14:36:21 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Aubrey Li <aubrey.li@linux.intel.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, valentin.schneider@arm.com,
        qais.yousef@arm.com, dietmar.eggemann@arm.com, rostedt@goodmis.org,
        bsegall@google.com, tim.c.chen@linux.intel.com,
        linux-kernel@vger.kernel.org, Mel Gorman <mgorman@suse.de>,
        Jiang Biao <benbjiang@gmail.com>
Subject: Re: [RFC PATCH v7] sched/fair: select idle cpu from idle cpumask for
 task wakeup
Message-ID: <20201209143510.GO3371@techsingularity.net>
References: <20201209062404.175565-1-aubrey.li@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20201209062404.175565-1-aubrey.li@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 09, 2020 at 02:24:04PM +0800, Aubrey Li wrote:
> Add idle cpumask to track idle cpus in sched domain. Every time
> a CPU enters idle, the CPU is set in idle cpumask to be a wakeup
> target. And if the CPU is not in idle, the CPU is cleared in idle
> cpumask during scheduler tick to ratelimit idle cpumask update.
> 
> When a task wakes up to select an idle cpu, scanning idle cpumask
> has lower cost than scanning all the cpus in last level cache domain,
> especially when the system is heavily loaded.
> 
> Benchmarks including hackbench, schbench, uperf, sysbench mysql
> and kbuild were tested on a x86 4 socket system with 24 cores per
> socket and 2 hyperthreads per core, total 192 CPUs, no regression
> found.
> 

I ran this patch with tbench on top of of the schedstat patches that
track SIS efficiency. The tracking adds overhead so it's not a perfect
performance comparison but the expectation would be that the patch reduces
the number of runqueues that are scanned

tbench4
                          5.10.0-rc6             5.10.0-rc6
                      schedstat-v1r1          idlemask-v7r1
Hmean     1        504.76 (   0.00%)      500.14 *  -0.91%*
Hmean     2       1001.22 (   0.00%)      970.37 *  -3.08%*
Hmean     4       1930.56 (   0.00%)     1880.96 *  -2.57%*
Hmean     8       3688.05 (   0.00%)     3537.72 *  -4.08%*
Hmean     16      6352.71 (   0.00%)     6439.53 *   1.37%*
Hmean     32     10066.37 (   0.00%)    10124.65 *   0.58%*
Hmean     64     12846.32 (   0.00%)    11627.27 *  -9.49%*
Hmean     128    22278.41 (   0.00%)    22304.33 *   0.12%*
Hmean     256    21455.52 (   0.00%)    20900.13 *  -2.59%*
Hmean     320    21802.38 (   0.00%)    21928.81 *   0.58%*

Not very optimistic result. The schedstats indicate;

                                5.10.0-rc6     5.10.0-rc6
                            schedstat-v1r1  idlemask-v7r1
Ops TTWU Count               5599714302.00  5589495123.00
Ops TTWU Local               2687713250.00  2563662550.00
Ops SIS Search               5596677950.00  5586381168.00
Ops SIS Domain Search        3268344934.00  3229088045.00
Ops SIS Scanned             15909069113.00 16568899405.00
Ops SIS Domain Scanned      13580736097.00 14211606282.00
Ops SIS Failures             2944874939.00  2843113421.00
Ops SIS Core Search           262853975.00   311781774.00
Ops SIS Core Hit              185189656.00   216097102.00
Ops SIS Core Miss              77664319.00    95684672.00
Ops SIS Recent Used Hit       124265515.00   146021086.00
Ops SIS Recent Used Miss      338142547.00   403547579.00
Ops SIS Recent Attempts       462408062.00   549568665.00
Ops SIS Search Efficiency            35.18          33.72
Ops SIS Domain Search Eff            24.07          22.72
Ops SIS Fast Success Rate            41.60          42.20
Ops SIS Success Rate                 47.38          49.11
Ops SIS Recent Success Rate          26.87          26.57

The field I would expect to decrease is SIS Domain Scanned -- the number
of runqueues that were examined but it's actually worse and graphing over
time shows it's worse for the client thread counts.  select_idle_cpu()
is definitely being called because "Domain Search" is 10 times higher than
"Core Search" and there "Core Miss" is non-zero.

I suspect the issue is that the mask is only marked busy from the tick
context which is a very wide window. If select_idle_cpu() picks an idle
CPU from the mask, it's still marked as idle in the mask.

-- 
Mel Gorman
SUSE Labs
