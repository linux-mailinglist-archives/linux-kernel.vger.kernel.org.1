Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24A472B16FC
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 09:13:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726260AbgKMIMt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 03:12:49 -0500
Received: from mga07.intel.com ([134.134.136.100]:31947 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726217AbgKMIMt (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 03:12:49 -0500
IronPort-SDR: AJEKklCjOW7yeG2gvAjomdQPCQrgHq6bLUYo2fAhyDWd6fdlLc9tg0lSI9auIKZnEaDXgxDOWJ
 aJKdptOW5tXg==
X-IronPort-AV: E=McAfee;i="6000,8403,9803"; a="234601511"
X-IronPort-AV: E=Sophos;i="5.77,474,1596524400"; 
   d="scan'208";a="234601511"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2020 00:12:42 -0800
IronPort-SDR: 4XFea9hQO71cV+aS9i+KFCEtpeaKq0/fyp4jZfkLDrN/om9LTctsIzl7L35qZM6/UlpDtKCR3w
 4edogvruxLNQ==
X-IronPort-AV: E=Sophos;i="5.77,474,1596524400"; 
   d="scan'208";a="542580418"
Received: from yjin15-mobl1.ccr.corp.intel.com (HELO [10.238.4.27]) ([10.238.4.27])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2020 00:12:39 -0800
Subject: Re: [PATCH] perf vendor events: Update Skylake client events to v50
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-kernel <Linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        "Liang, Kan" <kan.liang@intel.com>, yao.jin@intel.com,
        Ian Rogers <irogers@google.com>
References: <20201104015102.30363-1-yao.jin@linux.intel.com>
 <20201106030018.GA359712@google.com>
 <93fae76f-ce2b-ab0b-3ae9-cc9a2b4cbaec@linux.intel.com>
 <CAM9d7chhrYh1hmHkw8NKkwEHDoU0q2ArpOj3NGm0_RiQ7eSuxQ@mail.gmail.com>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <38be0597-7f93-0aa1-b4c5-3c7f23b74f13@linux.intel.com>
Date:   Fri, 13 Nov 2020 16:12:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <CAM9d7chhrYh1hmHkw8NKkwEHDoU0q2ArpOj3NGm0_RiQ7eSuxQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andi, Ian,

On 11/6/2020 12:21 PM, Namhyung Kim wrote:
> On Fri, Nov 6, 2020 at 12:12 PM Jin, Yao <yao.jin@linux.intel.com> wrote:
>>
>> Hi Namhyung,
>>
>> On 11/6/2020 11:00 AM, Namhyung Kim wrote:
>>> Hi,
>>>
>>> On Wed, Nov 04, 2020 at 09:51:02AM +0800, Jin Yao wrote:
>>>> - Update Skylake events to v50.
>>>> - Update Skylake JSON metrics from TMAM 4.0.
>>>> - Fix the issue in DRAM_Parallel_Reads
>>>> - Fix the perf test warning
>>>>
>>>> Before:
>>>>
>>>> root@kbl-ppc:~# perf stat -M DRAM_Parallel_Reads -- sleep 1
>>>> event syntax error: '{arb/event=0x80,umask=0x2/,arb/event=0x80,umask=0x2,thresh=1/}:W'
>>>>                        \___ unknown term 'thresh' for pmu 'uncore_arb'
>>>>
>>>> valid terms: event,edge,inv,umask,cmask,config,config1,config2,name,period,percore
>>>>
>>>> Initial error:
>>>> event syntax error: '..umask=0x2/,arb/event=0x80,umask=0x2,thresh=1/}:W'
>>>>                                     \___ Cannot find PMU `arb'. Missing kernel support?
>>>>
>>>> root@kbl-ppc:~# perf test metrics
>>>> 10: PMU events                                 :
>>>> 10.3: Parsing of PMU event table metrics               : Skip (some metrics failed)
>>>> 10.4: Parsing of PMU event table metrics with fake PMUs: Ok
>>>> 67: Parse and process metrics                  : Ok
>>>>
>>>> After:
>>>>
>>>> root@kbl-ppc:~# perf stat -M MEM_Parallel_Reads -- sleep 1
>>>>
>>>>    Performance counter stats for 'system wide':
>>>>
>>>>            4,951,646      arb/event=0x80,umask=0x2/ #    26.30 MEM_Parallel_Reads       (50.04%)
>>>>              188,251      arb/event=0x80,umask=0x2,cmask=1/                                     (49.96%)
>>>>
>>>>          1.000867010 seconds time elapsed
>>>>
>>>> root@kbl-ppc:~# perf test metrics
>>>> 10: PMU events                                 :
>>>> 10.3: Parsing of PMU event table metrics               : Ok
>>>> 10.4: Parsing of PMU event table metrics with fake PMUs: Ok
>>>> 67: Parse and process metrics                  : Ok
>>>>
>>>> Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
>>>
>>> It seems not applied to acme/perf/core cleanly.
>>>
>>> Thanks,
>>> Namhyung
>>>
>>
>> It seems the patch mail is truncated. :(
>>
>> I attach the patch file in the mail. Sorry for inconvenience.
> 
> I've checked it fixed the perf test on my laptop (skylake).
> 
> Tested-by: Namhyung Kim <namhyung@kernel.org>
> 
> Thanks,
> Namhyung
> 

Can I get ACK for this patch?

It's mainly for fixing the perf-test issue and MEM_Parallel_Reads issue.

Thanks
Jin Yao
