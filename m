Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9DC12A5D7E
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 06:01:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728967AbgKDE7j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 23:59:39 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45198 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727754AbgKDE7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 23:59:38 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0A44Wgd8064941;
        Tue, 3 Nov 2020 23:59:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=P6n7LBqV40O/BiTI6o3GhYdSTCHNDcuFZrs5SnKCrnE=;
 b=iSm3X5e5piJbE5DBkjkVpOqA93Tl5SYdmCmoMUwSvQ5fUU+0M34AO2VlMsI3lHVFz9yQ
 b1atcG2UqQ/tvPITZhOlZnGBHefMFz5stjpGy/vARr5j98aeGmUfS1Qtw2/6RmACGOcI
 +hQWm16D/BNhXBPDWXseVq6ic26iPf80Da+rcmxH706b8oba4Adc6kQnV9Y2ur5ZVTcU
 wu+JpIJUqG/7BrBd1xDHZ2w02G0Q6rdTS+UaqANtxkSSJ/Bl7Fj12GFC9xuEL4Icc5NL
 zqqezAxwYOdCR7YedyyRVxsWumD+jTFIXgJeaRI3p/hkmqV9fjWa0WnKit7wI9WOrz9z YQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 34kahjk065-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 Nov 2020 23:59:04 -0500
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0A44XE1j067977;
        Tue, 3 Nov 2020 23:59:03 -0500
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0a-001b2d01.pphosted.com with ESMTP id 34kahjk05j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 Nov 2020 23:59:03 -0500
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0A44ugSA023112;
        Wed, 4 Nov 2020 04:59:02 GMT
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com [9.57.198.25])
        by ppma05wdc.us.ibm.com with ESMTP id 34h09n3cuq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 Nov 2020 04:59:02 +0000
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com [9.57.199.107])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0A44x12G9634432
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 4 Nov 2020 04:59:01 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C314A124052;
        Wed,  4 Nov 2020 04:59:01 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 69809124054;
        Wed,  4 Nov 2020 04:58:54 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.79.217.16])
        by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed,  4 Nov 2020 04:58:53 +0000 (GMT)
Subject: Re: [perf metricgroup] fcc9c5243c:
 perf-sanity-tests.Parse_and_process_metrics.fail
To:     John Garry <john.garry@huawei.com>, Ian Rogers <irogers@google.com>
Cc:     kernel test robot <rong.a.chen@intel.com>,
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
        linuxarm@huawei.com, LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Joakim Zhang <qiangqing.zhang@nxp.com>,
        zhangshaokun@hisilicon.com, James Clark <james.clark@arm.com>,
        linux-imx@nxp.com, 0day robot <lkp@intel.com>, lkp@lists.01.org
References: <1602152121-240367-10-git-send-email-john.garry@huawei.com>
 <20201018085031.GK11647@shao2-debian>
 <CAP-5=fWg4W_fpu-uTZkh-ZoL_7nvqU4F_2LqQgKFvBkfn174HQ@mail.gmail.com>
 <602e6bb8-a4ac-fae7-ed61-edf252e08d9a@huawei.com>
 <CAP-5=fWuUVkn35Ep7TQpFvdVJHi8MntAAbRAXVCU_1bYM2rPeQ@mail.gmail.com>
 <6d22bbdf-1a7c-1ba9-3c1a-88600178facf@linux.ibm.com>
 <CAP-5=fUU7Smr7ij8bQTd0Gn6RimXppjSFUBYkLRROb8vbvMJXA@mail.gmail.com>
 <935893a3-297d-c6ed-524b-e50e5d5a0d54@huawei.com>
 <CAP-5=fUz+r+jSAKecnTmAi2r6XT7+YmB=8f73sFTuVDptL5Owg@mail.gmail.com>
 <5c7f029d-8aa2-e4a3-8a1e-b66593753672@huawei.com>
From:   kajoljain <kjain@linux.ibm.com>
Message-ID: <62685627-5631-19c7-a65c-b892581b32aa@linux.ibm.com>
Date:   Wed, 4 Nov 2020 10:28:52 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <5c7f029d-8aa2-e4a3-8a1e-b66593753672@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-04_03:2020-11-04,2020-11-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1015
 suspectscore=0 bulkscore=0 spamscore=0 priorityscore=1501 phishscore=0
 lowpriorityscore=0 adultscore=0 mlxlogscore=999 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011040032
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/3/20 10:24 PM, John Garry wrote:
> On 03/11/2020 16:05, Ian Rogers wrote:
>> On Tue, Nov 3, 2020 at 6:43 AM John Garry<john.garry@huawei.com>  wrote:
>>> On 20/10/2020 17:53, Ian Rogers wrote:
>>>>>> Thanks for taking a look John. If you want help you can send the
>>>>>> output of "perf test 67 -vvv" to me. It is possible Broadwell has
>>>>>> similar glitches in the json to Skylake. I tested the original test on
>>>>>> server parts as I can access them as cloud machines.
>>>>>>
>>>>>>> I will have a look, but I was hoping that Ian would have a proper fix
>>>>>>> for this on top of ("perf metricgroup: Fix uncore metric expressions"),
>>>>>>> which now looks to be merged.
>>>>>> I still have these changes to look at in my inbox but I'm assuming
>>>>>> they're good:-)  Sorry for not getting to them, but it's good they are
>>>>>> merged.
>>>>> Hi Ian,
>>>>>      Checked in upstream kernel with your fix patch, in powerpc also test case 67 is passing.
>>>>> But I am getting issue in test 10 for powerpc
>>>>>
>>>>> [command]# ./perf test 10
>>>>> 10: PMU events                                                      :
>>>>> 10.1: PMU event table sanity                                        : Ok
>>>>> 10.2: PMU event map aliases                                         : Ok
>>>>> 10.3: Parsing of PMU event table metrics                            : Skip (some metrics failed)
>>>>> 10.4: Parsing of PMU event table metrics with fake PMUs             : FAILED!
>>>>>
>>>>> Was debugging it, issue is with commit e1c92a7fbbc5 perf tests: Add another metric parsing test.
>>>>>
>>>>> So, there we are passing different runtime parameter value in "expr__find_other and expr__parse"
>>>>> in function `metric_parse_fake`. I believe we need to send same value.
>>>>> I will send fix patch for the same.
>>> Just wondering, was a patch ever submitted for this? Something still
>>> broken? I can't see any recent relevant changes to tests/pmu-events.c
>> The test itself shouldn't have changed, but the json files parsed by
>> jevents and turned into C code that the test exercises should have
>> changed. Jin Yao has sent two patch sets fixing a metric issue on SKL
>> (Skylake non-server) that should hopefully fix the issue there - I'll
>> check the status on these. Are you testing on Skylake?
> 
> So I have re-read this thread, and it seems that 2x different things are being discussed:
> a. some breakage for test #10 on skylake
> b. test #67 being broken
> 
> It seems that a. has been addressed. That's what I was asking about just now.

Hi Ian/John,
        The breakage for test #10 which I mentioned is for power9 machine, if that you were asking.
I still need to send fix patch out. I will send it soon.

Thanks,
Kajol Jain

> 
> So about b., which I thought may be broken for some other reason apart from my hacky patch. But it seems not the case, and a proper patch is needed there.
> 
> Ian, have you had a chance to consider this issue in b.? That is, we have breakage for metrics using uncore alias expressions for when multiple uncore PMUs associated exist in the system? As before, looks broken by ded80bda8bc9 ("perf expr: Migrate expr ids table to a hashmap")
> 
> Thanks,
> John
> 
> 
