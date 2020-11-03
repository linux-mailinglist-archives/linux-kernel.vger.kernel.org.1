Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E8C22A4C08
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 17:54:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728644AbgKCQyJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 11:54:09 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:3034 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727323AbgKCQyI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 11:54:08 -0500
Received: from lhreml724-chm.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id 0B1FB3A836DBBDFFCB5B;
        Tue,  3 Nov 2020 16:54:07 +0000 (GMT)
Received: from [10.47.5.37] (10.47.5.37) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Tue, 3 Nov 2020
 16:54:05 +0000
Subject: Re: [perf metricgroup] fcc9c5243c:
 perf-sanity-tests.Parse_and_process_metrics.fail
To:     Ian Rogers <irogers@google.com>
CC:     kajoljain <kjain@linux.ibm.com>,
        kernel test robot <rong.a.chen@intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@redhat.com>, Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        <linuxarm@huawei.com>, LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Joakim Zhang <qiangqing.zhang@nxp.com>,
        <zhangshaokun@hisilicon.com>, James Clark <james.clark@arm.com>,
        <linux-imx@nxp.com>, 0day robot <lkp@intel.com>, <lkp@lists.01.org>
References: <1602152121-240367-10-git-send-email-john.garry@huawei.com>
 <20201018085031.GK11647@shao2-debian>
 <CAP-5=fWg4W_fpu-uTZkh-ZoL_7nvqU4F_2LqQgKFvBkfn174HQ@mail.gmail.com>
 <602e6bb8-a4ac-fae7-ed61-edf252e08d9a@huawei.com>
 <CAP-5=fWuUVkn35Ep7TQpFvdVJHi8MntAAbRAXVCU_1bYM2rPeQ@mail.gmail.com>
 <6d22bbdf-1a7c-1ba9-3c1a-88600178facf@linux.ibm.com>
 <CAP-5=fUU7Smr7ij8bQTd0Gn6RimXppjSFUBYkLRROb8vbvMJXA@mail.gmail.com>
 <935893a3-297d-c6ed-524b-e50e5d5a0d54@huawei.com>
 <CAP-5=fUz+r+jSAKecnTmAi2r6XT7+YmB=8f73sFTuVDptL5Owg@mail.gmail.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <5c7f029d-8aa2-e4a3-8a1e-b66593753672@huawei.com>
Date:   Tue, 3 Nov 2020 16:54:02 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <CAP-5=fUz+r+jSAKecnTmAi2r6XT7+YmB=8f73sFTuVDptL5Owg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.5.37]
X-ClientProxiedBy: lhreml754-chm.china.huawei.com (10.201.108.204) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/11/2020 16:05, Ian Rogers wrote:
> On Tue, Nov 3, 2020 at 6:43 AM John Garry<john.garry@huawei.com>  wrote:
>> On 20/10/2020 17:53, Ian Rogers wrote:
>>>>> Thanks for taking a look John. If you want help you can send the
>>>>> output of "perf test 67 -vvv" to me. It is possible Broadwell has
>>>>> similar glitches in the json to Skylake. I tested the original test on
>>>>> server parts as I can access them as cloud machines.
>>>>>
>>>>>> I will have a look, but I was hoping that Ian would have a proper fix
>>>>>> for this on top of ("perf metricgroup: Fix uncore metric expressions"),
>>>>>> which now looks to be merged.
>>>>> I still have these changes to look at in my inbox but I'm assuming
>>>>> they're good:-)  Sorry for not getting to them, but it's good they are
>>>>> merged.
>>>> Hi Ian,
>>>>      Checked in upstream kernel with your fix patch, in powerpc also test case 67 is passing.
>>>> But I am getting issue in test 10 for powerpc
>>>>
>>>> [command]# ./perf test 10
>>>> 10: PMU events                                                      :
>>>> 10.1: PMU event table sanity                                        : Ok
>>>> 10.2: PMU event map aliases                                         : Ok
>>>> 10.3: Parsing of PMU event table metrics                            : Skip (some metrics failed)
>>>> 10.4: Parsing of PMU event table metrics with fake PMUs             : FAILED!
>>>>
>>>> Was debugging it, issue is with commit e1c92a7fbbc5 perf tests: Add another metric parsing test.
>>>>
>>>> So, there we are passing different runtime parameter value in "expr__find_other and expr__parse"
>>>> in function `metric_parse_fake`. I believe we need to send same value.
>>>> I will send fix patch for the same.
>> Just wondering, was a patch ever submitted for this? Something still
>> broken? I can't see any recent relevant changes to tests/pmu-events.c
> The test itself shouldn't have changed, but the json files parsed by
> jevents and turned into C code that the test exercises should have
> changed. Jin Yao has sent two patch sets fixing a metric issue on SKL
> (Skylake non-server) that should hopefully fix the issue there - I'll
> check the status on these. Are you testing on Skylake?

So I have re-read this thread, and it seems that 2x different things are 
being discussed:
a. some breakage for test #10 on skylake
b. test #67 being broken

It seems that a. has been addressed. That's what I was asking about just 
now.

So about b., which I thought may be broken for some other reason apart 
from my hacky patch. But it seems not the case, and a proper patch is 
needed there.

Ian, have you had a chance to consider this issue in b.? That is, we 
have breakage for metrics using uncore alias expressions for when 
multiple uncore PMUs associated exist in the system? As before, looks 
broken by ded80bda8bc9 ("perf expr: Migrate expr ids table to a hashmap")

Thanks,
John


