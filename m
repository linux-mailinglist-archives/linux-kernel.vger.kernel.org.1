Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B06C32926AA
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 13:50:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbgJSLt6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 07:49:58 -0400
Received: from mga07.intel.com ([134.134.136.100]:3813 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726890AbgJSLt6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 07:49:58 -0400
IronPort-SDR: 0ZUCGunYweUsquLRtXQzDN7zoIlXG/V7HG643e7TDpNe7iRexUvY0loaVsmnCqQ6X8Vk26hH63
 1BuM58awUtfw==
X-IronPort-AV: E=McAfee;i="6000,8403,9778"; a="231203201"
X-IronPort-AV: E=Sophos;i="5.77,394,1596524400"; 
   d="scan'208";a="231203201"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2020 04:49:57 -0700
IronPort-SDR: LglYMxrgOJWa/15A7yhxWKYN72X957pGeCidXppxBWukErwIbyTXWRX1e6NUhSHcz1XTRatLeM
 34WeMilcTBEg==
X-IronPort-AV: E=Sophos;i="5.77,394,1596524400"; 
   d="scan'208";a="523090044"
Received: from yzheng5-mobl3.ccr.corp.intel.com (HELO [10.254.210.169]) ([10.254.210.169])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2020 04:49:51 -0700
Subject: Re: [perf metricgroup] fcc9c5243c:
 perf-sanity-tests.Parse_and_process_metrics.fail
To:     John Garry <john.garry@huawei.com>,
        Ian Rogers <irogers@google.com>,
        kernel test robot <rong.a.chen@intel.com>,
        Andi Kleen <ak@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
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
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <023f1db8-118f-c9e6-28da-e4e7fb2134ef@linux.intel.com>
Date:   Mon, 19 Oct 2020 19:49:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <602e6bb8-a4ac-fae7-ed61-edf252e08d9a@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Garry, Hi Ian,

On 10/19/2020 5:48 PM, John Garry wrote:
> On 19/10/2020 00:30, Ian Rogers wrote:
>> On Sun, Oct 18, 2020 at 1:51 AM kernel test robot <rong.a.chen@intel.com> wrote:
>>>
>>> Greeting,
>>>
>>> FYI, we noticed the following commit (built with gcc-9):
>>>
>>> commit: fcc9c5243c478f104014daf4d23db86098d2aef0 ("perf metricgroup: Hack a fix for aliases when 
>>> covering multiple PMUs")
>>> url: 
>>> https://github.com/0day-ci/linux/commits/John-Garry/perf-pmu-events-Support-event-aliasing-for-system-PMUs/20201008-182049 
>>>
>>>
>>>
>>> in testcase: perf-sanity-tests
>>> version: perf-x86_64-c85fb28b6f99-1_20201008
>>> with following parameters:
>>>
>>>          perf_compiler: gcc
>>>          ucode: 0xdc
>>>
>>>
>>>
>>> on test machine: 4 threads Intel(R) Core(TM) i5-6500 CPU @ 3.20GHz with 32G memory
>>>
>>> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
>>
>> I believe this is a Skylake and there is a known bug in the Skylake
>> metric DRAM_Parallel_Reads as described here:
>> https://lore.kernel.org/lkml/CAP-5=fXejVaQa9qfW66cY77qB962+jbe8tT5bsLoOOcFmODnWQ@mail.gmail.com/
>> Fixing the bug needs more knowledge than what is available in manuals.
>> Hopefully Intel can take a look.
>>
>> Thanks,
>> Ian
> 
> So this named patch ("perf metricgroup: Hack a fix for aliases...") is breaking test #67 on my 
> machine also, which is a broadwell.
> 
> I will have a look, but I was hoping that Ian would have a proper fix for this on top of ("perf 
> metricgroup: Fix uncore metric expressions"), which now looks to be merged.
> 
> Thanks!
> 

I just think they are different issues.

On my KBL client, the perf test #67 is passed.

But DRAM_Parallel_Reads does have issue.

root@kbl-ppc:~# perf stat -M DRAM_Parallel_Reads -- sleep 1
event syntax error: '{arb/event=0x80,umask=0x2/,arb/event=0x80,umask=0x2,thresh=1/}:W'
                      \___ unknown term 'thresh' for pmu 'uncore_arb'

valid terms: event,edge,inv,umask,cmask,config,config1,config2,name,period,percore

Initial error:
event syntax error: '..umask=0x2/,arb/event=0x80,umask=0x2,thresh=1/}:W'
                                   \___ Cannot find PMU `arb'. Missing kernel support?

  Usage: perf stat [<options>] [<command>]

     -M, --metrics <metric/metric group list>
                           monitor specified metrics or metric groups (separated by ,)

I have a patch to fix DRAM_Parallel_Reads.

After:

root@kbl-ppc:~# perf stat -M MEM_Parallel_Reads -- sleep 1

  Performance counter stats for 'system wide':

          3,043,952      arb/event=0x80,umask=0x2/ #     1.00 MEM_Parallel_Reads

        1.000879932 seconds time elapsed

I will post the patch later.

Thanks
Jin Yao

>>
>>>
>>>
>>> If you fix the issue, kindly add following tag
>>> Reported-by: kernel test robot <rong.a.chen@intel.com>
>>>
>>>
>>> 2020-10-16 19:31:52 sudo 
>>> /usr/src/perf_selftests-x86_64-rhel-8.3-fcc9c5243c478f104014daf4d23db86098d2aef0/tools/perf/perf 
>>> test 67
>>> 67: Parse and process metrics                             : FAILED!
>>> 2020-10-16 19:31:52 sudo 
>>> /usr/src/perf_selftests-x86_64-rhel-8.3-fcc9c5243c478f104014daf4d23db86098d2aef0/tools/perf/perf 
>>> test 68
>>> 68: x86 rdpmc                                             : Ok
>>> 2020-10-16 19:31:52 sudo 
>>> /usr/src/perf_selftests-x86_64-rhel-8.3-fcc9c5243c478f104014daf4d23db86098d2aef0/tools/perf/perf 
>>> test 69
>>> 69: Convert perf time to TSC                              : Ok
>>> 2020-10-16 19:31:52 sudo 
>>> /usr/src/perf_selftests-x86_64-rhel-8.3-fcc9c5243c478f104014daf4d23db86098d2aef0/tools/perf/perf 
>>> test 70
>>> 70: DWARF unwind                                          : Ok
>>> 2020-10-16 19:31:52 sudo 
>>> /usr/src/perf_selftests-x86_64-rhel-8.3-fcc9c5243c478f104014daf4d23db86098d2aef0/tools/perf/perf 
>>> test 71
>>> 71: x86 instruction decoder - new instructions            : Ok
>>> 2020-10-16 19:31:52 sudo 
>>> /usr/src/perf_selftests-x86_64-rhel-8.3-fcc9c5243c478f104014daf4d23db86098d2aef0/tools/perf/perf 
>>> test 72
>>> 72: Intel PT packet decoder                               : Ok
>>> 2020-10-16 19:31:52 sudo 
>>> /usr/src/perf_selftests-x86_64-rhel-8.3-fcc9c5243c478f104014daf4d23db86098d2aef0/tools/perf/perf 
>>> test 73
>>> 73: x86 bp modify                                         : Ok
>>> 2020-10-16 19:31:53 sudo 
>>> /usr/src/perf_selftests-x86_64-rhel-8.3-fcc9c5243c478f104014daf4d23db86098d2aef0/tools/perf/perf 
>>> test 74
>>> 74: probe libc's inet_pton & backtrace it with ping       : Ok
>>> 2020-10-16 19:31:54 sudo 
>>> /usr/src/perf_selftests-x86_64-rhel-8.3-fcc9c5243c478f104014daf4d23db86098d2aef0/tools/perf/perf 
>>> test 75
>>> 75: Zstd perf.data compression/decompression              : Ok
>>>
>>>
>>>
>>> To reproduce:
>>>
>>>          git clone https://github.com/intel/lkp-tests.git
>>>          cd lkp-tests
>>>          bin/lkp install job.yaml  # job file is attached in this email
>>>          bin/lkp run     job.yaml
>>>
>>>
>>>
>>> Thanks,
>>> Rong Chen
>>>
>> .
>>
> 
