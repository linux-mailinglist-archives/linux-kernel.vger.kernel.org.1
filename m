Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B832C293740
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 10:57:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390074AbgJTI52 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 04:57:28 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:5196 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2389913AbgJTI51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 04:57:27 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09K8X4Y9136845;
        Tue, 20 Oct 2020 04:56:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=dCRvuP1HBcvIHAPZEByuICxQSfoNWdnoOmB4XJNXBDw=;
 b=NRDDlrR9PNHngOygoMnmuZm3ExcluZ6vpZ+BcChQIsI484/pOcl+aC7IBUiOxsuncHm7
 ovu5OLbBXjHFoTX/V5stM1kIIZR3kYURwDvUnxvzthDofOqzU3cgLmkLDiddfy6kA9RK
 VrTfgovQz8Ow0AUROU8vP0grOIXO1p44TeDfp/UrIbhjF4b7OqCPpg7Hgszb5gyB6MUG
 LJdxFdQp7LzxTT4g0ADkhuTWg0VPIPnj0qEBac2yPlizdX3wEYCVStj38ul3tCAKA+t0
 2rvBbyMIb8N7k5ky39a5U6qRtEMzLrOfW0tkSNu5pVg6aoT7MTa3Lca9GMrBZbBUhLwB Ow== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 349uk12j45-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Oct 2020 04:56:53 -0400
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 09K8XYZu139429;
        Tue, 20 Oct 2020 04:56:53 -0400
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0b-001b2d01.pphosted.com with ESMTP id 349uk12j3x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Oct 2020 04:56:53 -0400
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 09K8q4eK005625;
        Tue, 20 Oct 2020 08:56:52 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
        by ppma03dal.us.ibm.com with ESMTP id 347r89422s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Oct 2020 08:56:52 +0000
Received: from b03ledav006.gho.boulder.ibm.com (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 09K8up0P62980548
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 20 Oct 2020 08:56:51 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3FA29C6057;
        Tue, 20 Oct 2020 08:56:51 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 18E7CC6059;
        Tue, 20 Oct 2020 08:56:42 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.199.43.175])
        by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue, 20 Oct 2020 08:56:41 +0000 (GMT)
Subject: Re: [perf metricgroup] fcc9c5243c:
 perf-sanity-tests.Parse_and_process_metrics.fail
To:     Ian Rogers <irogers@google.com>, John Garry <john.garry@huawei.com>
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
From:   kajoljain <kjain@linux.ibm.com>
Message-ID: <6d22bbdf-1a7c-1ba9-3c1a-88600178facf@linux.ibm.com>
Date:   Tue, 20 Oct 2020 14:26:40 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CAP-5=fWuUVkn35Ep7TQpFvdVJHi8MntAAbRAXVCU_1bYM2rPeQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-20_04:2020-10-20,2020-10-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 phishscore=0 mlxlogscore=999 impostorscore=0 malwarescore=0
 adultscore=0 spamscore=0 mlxscore=0 clxscore=1011 priorityscore=1501
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010200053
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/19/20 9:50 PM, Ian Rogers wrote:
> On Mon, Oct 19, 2020 at 2:51 AM John Garry <john.garry@huawei.com> wrote:
>>
>> On 19/10/2020 00:30, Ian Rogers wrote:
>>> On Sun, Oct 18, 2020 at 1:51 AM kernel test robot <rong.a.chen@intel.com> wrote:
>>>>
>>>> Greeting,
>>>>
>>>> FYI, we noticed the following commit (built with gcc-9):
>>>>
>>>> commit: fcc9c5243c478f104014daf4d23db86098d2aef0 ("perf metricgroup: Hack a fix for aliases when covering multiple PMUs")
>>>> url: https://github.com/0day-ci/linux/commits/John-Garry/perf-pmu-events-Support-event-aliasing-for-system-PMUs/20201008-182049
>>>>
>>>>
>>>> in testcase: perf-sanity-tests
>>>> version: perf-x86_64-c85fb28b6f99-1_20201008
>>>> with following parameters:
>>>>
>>>>          perf_compiler: gcc
>>>>          ucode: 0xdc
>>>>
>>>>
>>>>
>>>> on test machine: 4 threads Intel(R) Core(TM) i5-6500 CPU @ 3.20GHz with 32G memory
>>>>
>>>> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
>>>
>>> I believe this is a Skylake and there is a known bug in the Skylake
>>> metric DRAM_Parallel_Reads as described here:
>>> https://lore.kernel.org/lkml/CAP-5=fXejVaQa9qfW66cY77qB962+jbe8tT5bsLoOOcFmODnWQ@mail.gmail.com/
>>> Fixing the bug needs more knowledge than what is available in manuals.
>>> Hopefully Intel can take a look.
>>>
>>> Thanks,
>>> Ian
>>
>> So this named patch ("perf metricgroup: Hack a fix for aliases...") is
>> breaking test #67 on my machine also, which is a broadwell.
> 
> Thanks for taking a look John. If you want help you can send the
> output of "perf test 67 -vvv" to me. It is possible Broadwell has
> similar glitches in the json to Skylake. I tested the original test on
> server parts as I can access them as cloud machines.
> 
>> I will have a look, but I was hoping that Ian would have a proper fix
>> for this on top of ("perf metricgroup: Fix uncore metric expressions"),
>> which now looks to be merged.
> 
> I still have these changes to look at in my inbox but I'm assuming
> they're good :-) Sorry for not getting to them, but it's good they are
> merged.

Hi Ian,
   Checked in upstream kernel with your fix patch, in powerpc also test case 67 is passing. 
But I am getting issue in test 10 for powerpc

[command]# ./perf test 10 
10: PMU events                                                      :
10.1: PMU event table sanity                                        : Ok
10.2: PMU event map aliases                                         : Ok
10.3: Parsing of PMU event table metrics                            : Skip (some metrics failed)
10.4: Parsing of PMU event table metrics with fake PMUs             : FAILED!

Was debugging it, issue is with commit e1c92a7fbbc5 perf tests: Add another metric parsing test.

So, there we are passing different runtime parameter value in "expr__find_other and expr__parse"
in function `metric_parse_fake`. I believe we need to send same value.
I will send fix patch for the same.

Thanks,
Kajol Jain

> 
> Thanks,
> Ian
> 
>> Thanks!
>>
>>>
>>>>
>>>>
>>>> If you fix the issue, kindly add following tag
>>>> Reported-by: kernel test robot <rong.a.chen@intel.com>
>>>>
>>>>
>>>> 2020-10-16 19:31:52 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-fcc9c5243c478f104014daf4d23db86098d2aef0/tools/perf/perf test 67
>>>> 67: Parse and process metrics                             : FAILED!
>>>> 2020-10-16 19:31:52 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-fcc9c5243c478f104014daf4d23db86098d2aef0/tools/perf/perf test 68
>>>> 68: x86 rdpmc                                             : Ok
>>>> 2020-10-16 19:31:52 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-fcc9c5243c478f104014daf4d23db86098d2aef0/tools/perf/perf test 69
>>>> 69: Convert perf time to TSC                              : Ok
>>>> 2020-10-16 19:31:52 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-fcc9c5243c478f104014daf4d23db86098d2aef0/tools/perf/perf test 70
>>>> 70: DWARF unwind                                          : Ok
>>>> 2020-10-16 19:31:52 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-fcc9c5243c478f104014daf4d23db86098d2aef0/tools/perf/perf test 71
>>>> 71: x86 instruction decoder - new instructions            : Ok
>>>> 2020-10-16 19:31:52 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-fcc9c5243c478f104014daf4d23db86098d2aef0/tools/perf/perf test 72
>>>> 72: Intel PT packet decoder                               : Ok
>>>> 2020-10-16 19:31:52 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-fcc9c5243c478f104014daf4d23db86098d2aef0/tools/perf/perf test 73
>>>> 73: x86 bp modify                                         : Ok
>>>> 2020-10-16 19:31:53 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-fcc9c5243c478f104014daf4d23db86098d2aef0/tools/perf/perf test 74
>>>> 74: probe libc's inet_pton & backtrace it with ping       : Ok
>>>> 2020-10-16 19:31:54 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-fcc9c5243c478f104014daf4d23db86098d2aef0/tools/perf/perf test 75
>>>> 75: Zstd perf.data compression/decompression              : Ok
>>>>
>>>>
>>>>
>>>> To reproduce:
>>>>
>>>>          git clone https://github.com/intel/lkp-tests.git
>>>>          cd lkp-tests
>>>>          bin/lkp install job.yaml  # job file is attached in this email
>>>>          bin/lkp run     job.yaml
>>>>
>>>>
>>>>
>>>> Thanks,
>>>> Rong Chen
>>>>
>>> .
>>>
>>
