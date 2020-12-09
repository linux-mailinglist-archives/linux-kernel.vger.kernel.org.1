Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DECE32D3A78
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 06:31:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727228AbgLIFaA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 00:30:00 -0500
Received: from mga18.intel.com ([134.134.136.126]:6497 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727208AbgLIFaA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 00:30:00 -0500
IronPort-SDR: 0jyBKvK5ScicukHl1VBnESCP8sxiBHOB+iSUkCXNHCQGiikoKvAU8pzCUoCSsetr8xW1s5PbXk
 IkTxAPC2Rrhw==
X-IronPort-AV: E=McAfee;i="6000,8403,9829"; a="161783338"
X-IronPort-AV: E=Sophos;i="5.78,404,1599548400"; 
   d="scan'208";a="161783338"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2020 21:28:14 -0800
IronPort-SDR: 6eAQcGkxSGqEwn8BR0S8GYbvj8FHapUmR1uyLN4yvZyLeEoawDJ4mKUBLtWIfxWgY0gvFKMmfU
 if82vtnqmryA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,404,1599548400"; 
   d="scan'208";a="368047029"
Received: from cli6-desk1.ccr.corp.intel.com (HELO [10.239.161.125]) ([10.239.161.125])
  by fmsmga004.fm.intel.com with ESMTP; 08 Dec 2020 21:28:11 -0800
Subject: Re: [PATCH 2/4] sched/fair: Move avg_scan_cost calculations under
 SIS_PROP
To:     Vincent Guittot <vincent.guittot@linaro.org>,
        Mel Gorman <mgorman@techsingularity.net>
Cc:     Peter Ziljstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Linux-ARM <linux-arm-kernel@lists.infradead.org>
References: <20201208153501.1467-1-mgorman@techsingularity.net>
 <20201208153501.1467-3-mgorman@techsingularity.net>
 <CAKfTPtBGghbKimO17UTPUHQGZc=GkY849HFrkqqojirPhJKFoQ@mail.gmail.com>
From:   "Li, Aubrey" <aubrey.li@linux.intel.com>
Message-ID: <3255625e-fa92-dc09-9fab-5621122f4af0@linux.intel.com>
Date:   Wed, 9 Dec 2020 13:28:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <CAKfTPtBGghbKimO17UTPUHQGZc=GkY849HFrkqqojirPhJKFoQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/12/9 0:03, Vincent Guittot wrote:
> On Tue, 8 Dec 2020 at 16:35, Mel Gorman <mgorman@techsingularity.net> wrote:
>>
>> As noted by Vincent Guittot, avg_scan_costs are calculated for SIS_PROP
>> even if SIS_PROP is disabled. Move the time calculations under a SIS_PROP
>> check and while we are at it, exclude the cost of initialising the CPU
>> mask from the average scan cost.
>>
>> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
>> ---
>>  kernel/sched/fair.c | 14 ++++++++------
>>  1 file changed, 8 insertions(+), 6 deletions(-)
>>
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index ac7b34e7372b..5c41875aec23 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -6153,6 +6153,8 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
>>         if (!this_sd)
>>                 return -1;
> 
> Just noticed while reviewing the patch that the above related to
> this_sd can also go under sched_feat(SIS_PROP)
> 
>>
>> +       cpumask_and(cpus, sched_domain_span(sd), p->cpus_ptr);
>> +
>>         if (sched_feat(SIS_PROP)) {
>>                 u64 avg_cost, avg_idle, span_avg;
>>
>> @@ -6168,11 +6170,9 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
>>                         nr = div_u64(span_avg, avg_cost);
>>                 else
>>                         nr = 4;
>> -       }
>> -
>> -       time = cpu_clock(this);
>>
>> -       cpumask_and(cpus, sched_domain_span(sd), p->cpus_ptr);
>> +               time = cpu_clock(this);
>> +       }
>>
>>         for_each_cpu_wrap(cpu, cpus, target) {
>>                 if (!--nr)

nr is the key of this throttling mechanism, need to be placed under sched_feat(SIS_PROP) as well.

Thanks,
-Aubrey
