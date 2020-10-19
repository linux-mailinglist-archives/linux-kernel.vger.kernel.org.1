Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A24C292500
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 11:51:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727882AbgJSJve (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 05:51:34 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2986 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726249AbgJSJvd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 05:51:33 -0400
Received: from lhreml724-chm.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id 2EA37F02C2EC6AA13725;
        Mon, 19 Oct 2020 10:51:32 +0100 (IST)
Received: from [127.0.0.1] (10.47.6.70) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Mon, 19 Oct
 2020 10:51:30 +0100
Subject: Re: [perf metricgroup] fcc9c5243c:
 perf-sanity-tests.Parse_and_process_metrics.fail
To:     Ian Rogers <irogers@google.com>,
        kernel test robot <rong.a.chen@intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>
CC:     Arnaldo Carvalho de Melo <acme@kernel.org>,
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
From:   John Garry <john.garry@huawei.com>
Message-ID: <602e6bb8-a4ac-fae7-ed61-edf252e08d9a@huawei.com>
Date:   Mon, 19 Oct 2020 10:48:18 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <CAP-5=fWg4W_fpu-uTZkh-ZoL_7nvqU4F_2LqQgKFvBkfn174HQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.6.70]
X-ClientProxiedBy: lhreml725-chm.china.huawei.com (10.201.108.76) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/10/2020 00:30, Ian Rogers wrote:
> On Sun, Oct 18, 2020 at 1:51 AM kernel test robot <rong.a.chen@intel.com> wrote:
>>
>> Greeting,
>>
>> FYI, we noticed the following commit (built with gcc-9):
>>
>> commit: fcc9c5243c478f104014daf4d23db86098d2aef0 ("perf metricgroup: Hack a fix for aliases when covering multiple PMUs")
>> url: https://github.com/0day-ci/linux/commits/John-Garry/perf-pmu-events-Support-event-aliasing-for-system-PMUs/20201008-182049
>>
>>
>> in testcase: perf-sanity-tests
>> version: perf-x86_64-c85fb28b6f99-1_20201008
>> with following parameters:
>>
>>          perf_compiler: gcc
>>          ucode: 0xdc
>>
>>
>>
>> on test machine: 4 threads Intel(R) Core(TM) i5-6500 CPU @ 3.20GHz with 32G memory
>>
>> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> 
> I believe this is a Skylake and there is a known bug in the Skylake
> metric DRAM_Parallel_Reads as described here:
> https://lore.kernel.org/lkml/CAP-5=fXejVaQa9qfW66cY77qB962+jbe8tT5bsLoOOcFmODnWQ@mail.gmail.com/
> Fixing the bug needs more knowledge than what is available in manuals.
> Hopefully Intel can take a look.
> 
> Thanks,
> Ian

So this named patch ("perf metricgroup: Hack a fix for aliases...") is 
breaking test #67 on my machine also, which is a broadwell.

I will have a look, but I was hoping that Ian would have a proper fix 
for this on top of ("perf metricgroup: Fix uncore metric expressions"), 
which now looks to be merged.

Thanks!

> 
>>
>>
>> If you fix the issue, kindly add following tag
>> Reported-by: kernel test robot <rong.a.chen@intel.com>
>>
>>
>> 2020-10-16 19:31:52 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-fcc9c5243c478f104014daf4d23db86098d2aef0/tools/perf/perf test 67
>> 67: Parse and process metrics                             : FAILED!
>> 2020-10-16 19:31:52 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-fcc9c5243c478f104014daf4d23db86098d2aef0/tools/perf/perf test 68
>> 68: x86 rdpmc                                             : Ok
>> 2020-10-16 19:31:52 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-fcc9c5243c478f104014daf4d23db86098d2aef0/tools/perf/perf test 69
>> 69: Convert perf time to TSC                              : Ok
>> 2020-10-16 19:31:52 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-fcc9c5243c478f104014daf4d23db86098d2aef0/tools/perf/perf test 70
>> 70: DWARF unwind                                          : Ok
>> 2020-10-16 19:31:52 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-fcc9c5243c478f104014daf4d23db86098d2aef0/tools/perf/perf test 71
>> 71: x86 instruction decoder - new instructions            : Ok
>> 2020-10-16 19:31:52 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-fcc9c5243c478f104014daf4d23db86098d2aef0/tools/perf/perf test 72
>> 72: Intel PT packet decoder                               : Ok
>> 2020-10-16 19:31:52 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-fcc9c5243c478f104014daf4d23db86098d2aef0/tools/perf/perf test 73
>> 73: x86 bp modify                                         : Ok
>> 2020-10-16 19:31:53 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-fcc9c5243c478f104014daf4d23db86098d2aef0/tools/perf/perf test 74
>> 74: probe libc's inet_pton & backtrace it with ping       : Ok
>> 2020-10-16 19:31:54 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-fcc9c5243c478f104014daf4d23db86098d2aef0/tools/perf/perf test 75
>> 75: Zstd perf.data compression/decompression              : Ok
>>
>>
>>
>> To reproduce:
>>
>>          git clone https://github.com/intel/lkp-tests.git
>>          cd lkp-tests
>>          bin/lkp install job.yaml  # job file is attached in this email
>>          bin/lkp run     job.yaml
>>
>>
>>
>> Thanks,
>> Rong Chen
>>
> .
> 

