Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2370E2DACD2
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 13:17:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727486AbgLOMO5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 07:14:57 -0500
Received: from mga09.intel.com ([134.134.136.24]:46563 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726156AbgLOMO4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 07:14:56 -0500
IronPort-SDR: eJHLkP9lExaywZucswweuThWNZWESlDy92wjQG8UuwGgTkVu/16yRj+KlqyptAwsxv9AquyVw+
 lpytWFnmDgoQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9835"; a="175011333"
X-IronPort-AV: E=Sophos;i="5.78,420,1599548400"; 
   d="scan'208";a="175011333"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2020 04:13:10 -0800
IronPort-SDR: IFxsBVE6eMXGs+O+Ka4TEF45X9NKcB0cm+3+OfxpQy73jlEnTwolO/ucKXXv+fV62Xs0Myonlw
 sZY3FtFFncSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,420,1599548400"; 
   d="scan'208";a="383513847"
Received: from cli6-desk1.ccr.corp.intel.com (HELO [10.239.161.125]) ([10.239.161.125])
  by fmsmga004.fm.intel.com with ESMTP; 15 Dec 2020 04:13:07 -0800
Subject: Re: [RFC][PATCH 1/5] sched/fair: Fix select_idle_cpu()s cost
 accounting
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mgorman@techsingularity.net, vincent.guittot@linaro.org,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        juri.lelli@redhat.com, valentin.schneider@arm.com,
        qais.yousef@arm.com, dietmar.eggemann@arm.com, rostedt@goodmis.org,
        bsegall@google.com, tim.c.chen@linux.intel.com, benbjiang@gmail.com
References: <20201214164822.402812729@infradead.org>
 <20201214170017.877557652@infradead.org>
 <c4e31235-e1fb-52ac-99a8-ae943ee0de54@linux.intel.com>
 <20201215075911.GA3040@hirez.programming.kicks-ass.net>
From:   "Li, Aubrey" <aubrey.li@linux.intel.com>
Message-ID: <ec2e0453-9fab-f7ac-effe-f64601806595@linux.intel.com>
Date:   Tue, 15 Dec 2020 20:13:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20201215075911.GA3040@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/12/15 15:59, Peter Zijlstra wrote:
> On Tue, Dec 15, 2020 at 11:36:35AM +0800, Li, Aubrey wrote:
>> On 2020/12/15 0:48, Peter Zijlstra wrote:
>>> We compute the average cost of the total scan, but then use it as a
>>> per-cpu scan cost when computing the scan proportion. Fix this by
>>> properly computing a per-cpu scan cost.
>>>
>>> This also fixes a bug where we would terminate early (!--nr, case) and
>>> not account that cost at all.
>>
>> I'm a bit worried this may introduce a regression under heavy load.
>> The overhead of adding another cpu_clock() and calculation becomes 
>> significant when sis_scan is throttled by nr.
> 
> The thing is, the code as it exists today makes no sense what so ever.
> It's plain broken batshit.
> 
> We calculate the total scanning time (irrespective of how many CPUs we
> touched), and then use that calculate the number of cpus to scan. That's
> just daft.
> 
> After this patch we calculate the avg cost of scanning 1 cpu and use
> that to calculate how many cpus to scan. Which is coherent and sane.

I see and all of these make sense to me.

> 
> Maybe it can be improved, but that's a completely different thing.
> 

OK, I'll go through the workloads in hand and paste the data here.

Thanks,
-Aubrey
