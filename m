Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3829D2B895E
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 02:13:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727363AbgKSBNP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 20:13:15 -0500
Received: from mga09.intel.com ([134.134.136.24]:16346 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727238AbgKSBNP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 20:13:15 -0500
IronPort-SDR: khWteIRhFpZKIFHirz4UMCmbAfCesiW45m6Ro3tzj6OkQM4pFdK6BXIsCj2tBtKs3tKVoxIk7U
 JpIZI5kIxx0g==
X-IronPort-AV: E=McAfee;i="6000,8403,9809"; a="171382406"
X-IronPort-AV: E=Sophos;i="5.77,488,1596524400"; 
   d="scan'208";a="171382406"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2020 17:13:14 -0800
IronPort-SDR: XmnOwdhb8nBV3dHO8tLz40nMCMV+mCwGfBBqVBauiLe47xX0C16JKgqz6Vi7zGNsjXmb0UWfN9
 Q96ogSJl3Tkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,488,1596524400"; 
   d="scan'208";a="368576551"
Received: from cli6-desk1.ccr.corp.intel.com (HELO [10.239.161.125]) ([10.239.161.125])
  by FMSMGA003.fm.intel.com with ESMTP; 18 Nov 2020 17:13:10 -0800
Subject: Re: [RFC PATCH v4] sched/fair: select idle cpu from idle cpumask for
 task wakeup
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, mgorman@techsingularity.net,
        qais.yousef@arm.com, dietmar.eggemann@arm.com, rostedt@goodmis.org,
        bsegall@google.com, tim.c.chen@linux.intel.com,
        linux-kernel@vger.kernel.org, Aubrey Li <aubrey.li@intel.com>,
        Mel Gorman <mgorman@suse.de>, Jiang Biao <benbjiang@gmail.com>
References: <20201116200428.47359-1-aubrey.li@linux.intel.com>
 <jhjlfeyx41f.mognet@arm.com>
From:   "Li, Aubrey" <aubrey.li@linux.intel.com>
Message-ID: <bf7b6dd3-7922-2a4e-8df5-735b24c2dfc7@linux.intel.com>
Date:   Thu, 19 Nov 2020 09:13:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <jhjlfeyx41f.mognet@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/11/18 20:06, Valentin Schneider wrote:
> 
> On 16/11/20 20:04, Aubrey Li wrote:
>> From: Aubrey Li <aubrey.li@intel.com>
>>
>> Add idle cpumask to track idle cpus in sched domain. When a CPU
>> enters idle, if the idle driver indicates to stop tick, this CPU
>> is set in the idle cpumask to be a wakeup target. And if the CPU
>> is not in idle, the CPU is cleared in idle cpumask during scheduler
>> tick to ratelimit idle cpumask update.
>>
>> When a task wakes up to select an idle cpu, scanning idle cpumask
>> has low cost than scanning all the cpus in last level cache domain,
>> especially when the system is heavily loaded.
>>
>> Benchmarks were tested on a x86 4 socket system with 24 cores per
>> socket and 2 hyperthreads per core, total 192 CPUs. Hackbench and
>> schbench have no notable change, uperf has:
>>
>> uperf throughput: netperf workload, tcp_nodelay, r/w size = 90
>>
>>   threads       baseline-avg    %std    patch-avg       %std
>>   96            1               0.83    1.23            3.27
>>   144           1               1.03    1.67            2.67
>>   192           1               0.69    1.81            3.59
>>   240           1               2.84    1.51            2.67
>>
>> Cc: Mel Gorman <mgorman@suse.de>
>> Cc: Vincent Guittot <vincent.guittot@linaro.org>
>> Cc: Qais Yousef <qais.yousef@arm.com>
>> Cc: Valentin Schneider <valentin.schneider@arm.com>
>> Cc: Jiang Biao <benbjiang@gmail.com>
>> Cc: Tim Chen <tim.c.chen@linux.intel.com>
>> Signed-off-by: Aubrey Li <aubrey.li@linux.intel.com>
> 
> That's missing a v3 -> v4 change summary
> 

okay, I'll add in the next version soon.

Thanks,
-Aubrey
