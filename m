Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33C272C9468
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 02:06:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729855AbgLABFu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 20:05:50 -0500
Received: from mga11.intel.com ([192.55.52.93]:18941 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726684AbgLABFu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 20:05:50 -0500
IronPort-SDR: tPvpeZSgCe+NVvNxdXjRROenaHNdhlNMLckC90/aLPKtL7c98dxv85ySzmvwWRmIN1mPj428cg
 pZfCxBukzooA==
X-IronPort-AV: E=McAfee;i="6000,8403,9821"; a="169241197"
X-IronPort-AV: E=Sophos;i="5.78,382,1599548400"; 
   d="scan'208";a="169241197"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2020 17:04:08 -0800
IronPort-SDR: /mW1ORI8gJYO/d4eXbn0W7cBdywJ1g3/aMylkXFWWOT8rwUY/M67xXZW7gYpcQXTYKk5LkZWrn
 H7L87bh90mqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,382,1599548400"; 
   d="scan'208";a="372715290"
Received: from cli6-desk1.ccr.corp.intel.com (HELO [10.239.161.125]) ([10.239.161.125])
  by FMSMGA003.fm.intel.com with ESMTP; 30 Nov 2020 17:04:07 -0800
Subject: Re: [PATCH] sched/fair: Clear SMT siblings after determining the core
 is not idle
To:     Vincent Guittot <vincent.guittot@linaro.org>,
        Mel Gorman <mgorman@techsingularity.net>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20201130144020.GS3371@techsingularity.net>
 <CAKfTPtBcZnxR073=eRsWNAGOnA8K4emL0BYEUzbkzZx6qJWmSg@mail.gmail.com>
From:   "Li, Aubrey" <aubrey.li@linux.intel.com>
Message-ID: <f31178dd-34e4-0e9d-e8e3-fda396641daf@linux.intel.com>
Date:   Tue, 1 Dec 2020 09:04:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <CAKfTPtBcZnxR073=eRsWNAGOnA8K4emL0BYEUzbkzZx6qJWmSg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/11/30 22:47, Vincent Guittot wrote:
> On Mon, 30 Nov 2020 at 15:40, Mel Gorman <mgorman@techsingularity.net> wrote:
>>
>> The clearing of SMT siblings from the SIS mask before checking for an idle
>> core is a small but unnecessary cost. Defer the clearing of the siblings
>> until the scan moves to the next potential target. The cost of this was
>> not measured as it is borderline noise but it should be self-evident.
> 
> Good point

This is more reasonable, thanks Mel.

> 
>>
>> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
> 
> Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
> 
>> ---
>>  kernel/sched/fair.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index 0d54d69ba1a5..d9acd55d309b 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -6087,10 +6087,11 @@ static int select_idle_core(struct task_struct *p, struct sched_domain *sd, int
>>                                 break;
>>                         }
>>                 }
>> -               cpumask_andnot(cpus, cpus, cpu_smt_mask(core));
>>
>>                 if (idle)
>>                         return core;
>> +
>> +               cpumask_andnot(cpus, cpus, cpu_smt_mask(core));
>>         }
>>
>>         /*

