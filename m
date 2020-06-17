Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 894251FC2AE
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jun 2020 02:30:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726577AbgFQAa1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Jun 2020 20:30:27 -0400
Received: from mga18.intel.com ([134.134.136.126]:47970 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725894AbgFQAa0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 20:30:26 -0400
IronPort-SDR: fhJvINKryu8r0+wOS8b7hZKokqyi2I67LvYhTSU7n9WJ750mYgAjAINwApyAUuInx1yw1Wr3Ed
 vh9CZv+ge/hg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2020 17:30:25 -0700
IronPort-SDR: 3qH5oXVqwG6zI/fTsfkwa2Fa+n4dXy02BV4OnVAV82PJTgghtm3cHeJ1kFypaSMq9mqCbHhcT+
 CPR8rap54TRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,520,1583222400"; 
   d="scan'208";a="383034065"
Received: from xingzhen-mobl1.ccr.corp.intel.com (HELO [10.238.6.47]) ([10.238.6.47])
  by fmsmga001.fm.intel.com with ESMTP; 16 Jun 2020 17:30:22 -0700
Subject: Re: [LKP] [sched/fair] 070f5e860e: reaim.jobs_per_min -10.5%
 regression
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Hillf Danton <hdanton@sina.com>,
        kernel test robot <rong.a.chen@intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Phil Auld <pauld@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <20200319023819.GO11705@shao2-debian>
 <20200612110616.20264-1-hdanton@sina.com>
 <90f4036d-bb16-af67-8776-a2cbe67dfe7f@linux.intel.com>
 <20200615081041.GA16990@vingu-book>
 <d60343e9-b3a0-bdc7-84f4-e8c912f92c46@linux.intel.com>
 <20200616065432.GA18401@vingu-book>
From:   Xing Zhengjun <zhengjun.xing@linux.intel.com>
Message-ID: <3de4937b-1dcd-6d2e-836f-fed1c295dd7c@linux.intel.com>
Date:   Wed, 17 Jun 2020 08:30:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200616065432.GA18401@vingu-book>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/16/2020 2:54 PM, Vincent Guittot wrote:
> 
> Hi Xing,
> 
> Le mardi 16 juin 2020 à 11:17:16 (+0800), Xing Zhengjun a écrit :
>>
>>
>> On 6/15/2020 4:10 PM, Vincent Guittot wrote:
>>> Hi Xing,
>>>
>>> Le lundi 15 juin 2020 à 15:26:59 (+0800), Xing Zhengjun a écrit :
>>>>
>>>>
>>>> On 6/12/2020 7:06 PM, Hillf Danton wrote:
>>>>>
>>>>> On Fri, 12 Jun 2020 14:36:49 +0800 Xing Zhengjun wrote:
>>>
> 
> ...
> 
>>>
>>
>> I apply the patch based on v5.7, the test result is as the following:
> 
> TBH, I didn't expect that the results would still be bad, so i wonder if the threshold are
> the root problem.
> 
> Could you run tests with the patch below that removes condition with runnable_avg ?
> I just want to make sure that those 2 conditions are the root cause.
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index da3e5b54715b..f5774d0af059 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -8210,10 +8210,6 @@ group_has_capacity(unsigned int imbalance_pct, struct sg_lb_stats *sgs)
>          if (sgs->sum_nr_running < sgs->group_weight)
>                  return true;
> 
> -       if ((sgs->group_capacity * imbalance_pct) <
> -                       (sgs->group_runnable * 100))
> -               return false;
> -
>          if ((sgs->group_capacity * 100) >
>                          (sgs->group_util * imbalance_pct))
>                  return true;
> @@ -8239,10 +8235,6 @@ group_is_overloaded(unsigned int imbalance_pct, struct sg_lb_stats *sgs)
>                          (sgs->group_util * imbalance_pct))
>                  return true;
> 
> -       if ((sgs->group_capacity * imbalance_pct) <
> -                       (sgs->group_runnable * 100))
> -               return true;
> -
>          return false;
>   }
> 
> 
> 
> Thanks.
> Vincent
> 


I apply the patch based on v5.7, the test result is as the following:

=========================================================================================
tbox_group/testcase/rootfs/kconfig/compiler/runtime/nr_task/debug-setup/test/cpufreq_governor/ucode:
 
lkp-ivb-d04/reaim/debian-x86_64-20191114.cgz/x86_64-rhel-7.6/gcc-7/300s/100%/test/five_sec/performance/0x21

commit:
   9f68395333ad7f5bfe2f83473fed363d4229f11c
   070f5e860ee2bf588c99ef7b4c202451faa48236
   v5.7
   63a5d0fbb5ec62f5148c251c01e709b8358cd0ee (the test patch)

9f68395333ad7f5b 070f5e860ee2bf588c99ef7b4c2                        v5.7 
63a5d0fbb5ec62f5148c251c01e
---------------- --------------------------- --------------------------- 
---------------------------
          %stddev     %change         %stddev     %change 
%stddev     %change         %stddev
              \          |                \          |                \ 
         |                \
       0.69           -10.3%       0.62            -9.1%       0.62 
       +1.0%       0.69        reaim.child_systime
       0.62            -1.0%       0.61            +0.5%       0.62 
       -0.1%       0.62        reaim.child_utime
      66870           -10.0%      60187            -7.6%      61787 
       +1.1%      67636        reaim.jobs_per_min
      16717           -10.0%      15046            -7.6%      15446 
       +1.1%      16909        reaim.jobs_per_min_child
      97.84            -1.1%      96.75            -0.4%      97.43 
       +0.3%      98.09        reaim.jti
      72000           -10.8%      64216            -8.3%      66000 
       +0.0%      72000        reaim.max_jobs_per_min
       0.36           +10.6%       0.40            +7.8%       0.39 
       -1.1%       0.36        reaim.parent_time
       1.58 ±  2%     +71.0%       2.70 ±  2%     +26.9%       2.01 ± 
2%     -11.9%       1.39 ±  4%  reaim.std_dev_percent
       0.00 ±  5%    +110.4%       0.01 ±  3%     +48.8%       0.01 ± 
7%     -27.3%       0.00 ± 15%  reaim.std_dev_time
      50800            -2.4%      49600            -1.6%      50000 
       +0.0%      50800        reaim.workload


>>
>> =========================================================================================
>> tbox_group/testcase/rootfs/kconfig/compiler/runtime/nr_task/debug-setup/test/cpufreq_governor/ucode:
>>
>> lkp-ivb-d04/reaim/debian-x86_64-20191114.cgz/x86_64-rhel-7.6/gcc-7/300s/100%/test/five_sec/performance/0x21
>>
>> commit:
>>    9f68395333ad7f5bfe2f83473fed363d4229f11c
>>    070f5e860ee2bf588c99ef7b4c202451faa48236
>>    v5.7
>>    3e1643da53f3fc7414cfa3ad2a16ab2a164b7f4d (the test patch)
>>
>> 9f68395333ad7f5b 070f5e860ee2bf588c99ef7b4c2                        v5.7
>> 3e1643da53f3fc7414cfa3ad2a1
>> ---------------- --------------------------- ---------------------------
>> ---------------------------
>>           %stddev     %change         %stddev     %change %stddev     %change
>> %stddev
>>               \          |                \          |                \
>> |                \
>>        0.69           -10.3%       0.62            -9.1%       0.62
>> -7.1%       0.64        reaim.child_systime
>>        0.62            -1.0%       0.61            +0.5%       0.62
>> +1.3%       0.63        reaim.child_utime
>>       66870           -10.0%      60187            -7.6%      61787
>> -6.1%      62807        reaim.jobs_per_min
>>       16717           -10.0%      15046            -7.6%      15446
>> -6.1%      15701        reaim.jobs_per_min_child
>>       97.84            -1.1%      96.75            -0.4%      97.43
>> -0.5%      97.34        reaim.jti
>>       72000           -10.8%      64216            -8.3%      66000
>> -5.7%      67885        reaim.max_jobs_per_min
>>        0.36           +10.6%       0.40            +7.8%       0.39
>> +6.9%       0.38        reaim.parent_time
>>        1.58 ±  2%     +71.0%       2.70 ±  2%     +26.9%       2.01 ± 2%
>> +32.5%       2.09 ±  6%  reaim.std_dev_percent
>>        0.00 ±  5%    +110.4%       0.01 ±  3%     +48.8%       0.01 ± 7%
>> +61.7%       0.01 ±  8%  reaim.std_dev_time
>>       50800            -2.4%      49600            -1.6%      50000
>> -1.3%      50133        reaim.workload
>>
>>
>>>>
>>>> =========================================================================================
>>>> tbox_group/testcase/rootfs/kconfig/compiler/runtime/nr_task/debug-setup/test/cpufreq_governor/ucode:
>>>>
>>>> lkp-ivb-d04/reaim/debian-x86_64-20191114.cgz/x86_64-rhel-7.6/gcc-7/300s/100%/test/five_sec/performance/0x21
>>>>
>>>> commit:
>>>>     9f68395333ad7f5bfe2f83473fed363d4229f11c
>>>>     070f5e860ee2bf588c99ef7b4c202451faa48236
>>>>     v5.7
>>>>     6b33257768b8dd3982054885ea310871be2cfe0b (Hillf's patch)
>>>>
>>>> 9f68395333ad7f5b 070f5e860ee2bf588c99ef7b4c2                        v5.7
>>>> 6b33257768b8dd3982054885ea3
>>>> ---------------- --------------------------- ---------------------------
>>>> ---------------------------
>>>>            %stddev     %change         %stddev     %change %stddev     %change
>>>> %stddev
>>>>                \          |                \          |                \
>>>> |                \
>>>>         0.69           -10.3%       0.62            -9.1%       0.62
>>>> -10.1%       0.62        reaim.child_systime
>>>>         0.62            -1.0%       0.61            +0.5%       0.62
>>>> +0.3%       0.62        reaim.child_utime
>>>>        66870           -10.0%      60187            -7.6%      61787
>>>> -8.3%      61305        reaim.jobs_per_min
>>>>        16717           -10.0%      15046            -7.6%      15446
>>>> -8.3%      15326        reaim.jobs_per_min_child
>>>>        97.84            -1.1%      96.75            -0.4%      97.43
>>>> -0.5%      97.37        reaim.jti
>>>>        72000           -10.8%      64216            -8.3%      66000
>>>> -8.3%      66000        reaim.max_jobs_per_min
>>>>         0.36           +10.6%       0.40            +7.8%       0.39
>>>> +9.4%       0.39        reaim.parent_time
>>>>         1.58 ±  2%     +71.0%       2.70 ±  2%     +26.9%       2.01 ± 2%
>>>> +33.2%       2.11        reaim.std_dev_percent
>>>>         0.00 ±  5%    +110.4%       0.01 ±  3%     +48.8%       0.01 ± 7%
>>>> +65.3%       0.01 ±  3%  reaim.std_dev_time
>>>>        50800            -2.4%      49600            -1.6%      50000
>>>> -1.8%      49866        reaim.workload
>>>>
>>>>
>>>>
>>>> -- 
>>>> Zhengjun Xing
>>
>> -- 
>> Zhengjun Xing

-- 
Zhengjun Xing
