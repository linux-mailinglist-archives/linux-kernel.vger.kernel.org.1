Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C1612D93B6
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 08:56:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391285AbgLNHzF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 02:55:05 -0500
Received: from mga09.intel.com ([134.134.136.24]:7244 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726330AbgLNHzF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 02:55:05 -0500
IronPort-SDR: l8COn/hs1cqVWoeaP9z3u19qA3G+tkHInrj80EvonYX7FPu8VG9umN53gL3AAwXezD2IkGXgLy
 bI12oQS0agqg==
X-IronPort-AV: E=McAfee;i="6000,8403,9834"; a="174813728"
X-IronPort-AV: E=Sophos;i="5.78,417,1599548400"; 
   d="scan'208";a="174813728"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2020 23:53:18 -0800
IronPort-SDR: m1i8tifOhS0xowL/qHCwQZ10Mq7PqULQdjgeRL/nXsGcHI6NIXSOkaERjxslQfsQKnfkXfjGQ1
 7+G+73/qf2vA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,417,1599548400"; 
   d="scan'208";a="381213435"
Received: from cli6-desk1.ccr.corp.intel.com (HELO [10.239.161.125]) ([10.239.161.125])
  by fmsmga004.fm.intel.com with ESMTP; 13 Dec 2020 23:53:15 -0800
Subject: Re: [RFC PATCH v7] sched/fair: select idle cpu from idle cpumask for
 task wakeup
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, valentin.schneider@arm.com,
        qais.yousef@arm.com, dietmar.eggemann@arm.com, rostedt@goodmis.org,
        bsegall@google.com, tim.c.chen@linux.intel.com,
        linux-kernel@vger.kernel.org, Mel Gorman <mgorman@suse.de>,
        Jiang Biao <benbjiang@gmail.com>
References: <20201209062404.175565-1-aubrey.li@linux.intel.com>
 <20201209143510.GO3371@techsingularity.net>
 <3802e27a-56ed-9495-21b9-7c4277065155@linux.intel.com>
 <20201210113441.GS3371@techsingularity.net>
From:   "Li, Aubrey" <aubrey.li@linux.intel.com>
Message-ID: <0c81e6f1-b017-89fb-35a8-65c9b3f96a1c@linux.intel.com>
Date:   Mon, 14 Dec 2020 15:53:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20201210113441.GS3371@techsingularity.net>
Content-Type: text/plain; charset=iso-8859-15
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/12/10 19:34, Mel Gorman wrote:
> On Thu, Dec 10, 2020 at 04:23:47PM +0800, Li, Aubrey wrote:
>>> I ran this patch with tbench on top of of the schedstat patches that
>>> track SIS efficiency. The tracking adds overhead so it's not a perfect
>>> performance comparison but the expectation would be that the patch reduces
>>> the number of runqueues that are scanned
>>
>> Thanks for the measurement! I don't play with tbench so may need a while
>> to digest the data.
>>
> 
> They key point is that it appears the idle mask was mostly equivalent to
> the full domain mask, at least for this test.
> 
>>>
>>> tbench4
>>>                           5.10.0-rc6             5.10.0-rc6
>>>                       schedstat-v1r1          idlemask-v7r1
>>> Hmean     1        504.76 (   0.00%)      500.14 *  -0.91%*
>>> Hmean     2       1001.22 (   0.00%)      970.37 *  -3.08%*
>>> Hmean     4       1930.56 (   0.00%)     1880.96 *  -2.57%*
>>> Hmean     8       3688.05 (   0.00%)     3537.72 *  -4.08%*
>>> Hmean     16      6352.71 (   0.00%)     6439.53 *   1.37%*
>>> Hmean     32     10066.37 (   0.00%)    10124.65 *   0.58%*


>>> Hmean     64     12846.32 (   0.00%)    11627.27 *  -9.49%*

I focused on this case and run it 5 times, and here is the data on my side.
5 times x 600s tbench, thread number is 153(80% x 192(h/w thread num)).

Hmean 153		v5.9.12			v5.9.12
			schedstat-v1		idlemask-v8(with schedstat)
Round 1			15717.3			15608.1
Round 2			14856.9			15642.5
Round 3			14856.7			15782.1
Round 4			15408.9			15912.9
Round 5			15436.6			15927.7

From tbench throughput data, bigger is better, it looks like idlemask wins

And here is SIS_scanned data:

Hmean 153		v5.9.12			v5.9.12
			schedstat-v1		idlemask-v8(with schedstat)
Round 1			22562490432		21894932302
Round 2			21288529957		21693722629
Round 3			20657521771		21268308377
Round 4			21868486414		22289128955
Round 5			21859614988		22214740417

From SIS_scanned data, less is better, it looks like the default one is better.

But combined with throughput data, this can be explained as bigger throughput
performs more SIS_scanned.

So at least, there is no regression of this case.

Thanks,
-Aubrey
