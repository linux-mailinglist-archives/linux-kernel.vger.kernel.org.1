Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 650712FF7AE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 23:03:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbhAUWAz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 17:00:55 -0500
Received: from mga14.intel.com ([192.55.52.115]:15112 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725283AbhAUWAM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 17:00:12 -0500
IronPort-SDR: Jc6kVbhbgc9AwmGM21z2X0BOXPuu7lUyh41znAfw74O6DbdBApwtjTYKPDqJOuxPYdRkbXpq9J
 pnaqcgiFWdxA==
X-IronPort-AV: E=McAfee;i="6000,8403,9871"; a="178573929"
X-IronPort-AV: E=Sophos;i="5.79,365,1602572400"; 
   d="scan'208";a="178573929"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2021 13:58:24 -0800
IronPort-SDR: jU7W06Fra1SDEpgQ4NnjZJ9hcVnlTmsZzB4ZWXz/TkJ6KwuAJYlubYpq28xY1LlafUTptm4UuX
 ieoMqKMuZIJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,365,1602572400"; 
   d="scan'208";a="385478481"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga008.jf.intel.com with ESMTP; 21 Jan 2021 13:58:23 -0800
Received: from [10.255.230.225] (kliang2-MOBL.ccr.corp.intel.com [10.255.230.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 001035808DB;
        Thu, 21 Jan 2021 13:58:22 -0800 (PST)
Subject: Re: [PATCH] perf stat: Add Topdown metrics events as default events
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org, jolsa@redhat.com,
        namhyung@kernel.org, ak@linux.intel.com, yao.jin@linux.intel.com
References: <20210121133752.118327-1-kan.liang@linux.intel.com>
 <20210121195707.GA356537@kernel.org>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <76cae815-3c0c-9120-9e2d-b80a20593f70@linux.intel.com>
Date:   Thu, 21 Jan 2021 16:58:21 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210121195707.GA356537@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/21/2021 2:57 PM, Arnaldo Carvalho de Melo wrote:
> Em Thu, Jan 21, 2021 at 05:37:52AM -0800, kan.liang@linux.intel.com escreveu:
>> From: Kan Liang <kan.liang@linux.intel.com>
>>
>> The Topdown Microarchitecture Analysis (TMA) Method is a structured
>> analysis methodology to identify critical performance bottlenecks in
>> out-of-order processors. From the Ice Lake and later platforms, the
>> Topdown information can be retrieved from the dedicated "metrics"
>> register, which isn't impacted by other events. Also, the Topdown
>> metrics support both per thread/process and per core measuring.
>> Adding Topdown metrics events as default events can enrich the default
>> measuring information, and would not cost any extra multiplexing.
>>
>> Introduce arch_evlist__add_default_attrs() to allow architecture
>> specific default events. Add the Topdown metrics events in the X86
>> specific arch_evlist__add_default_attrs(). Other architectures can
>> add their own default events later separately.
>>
>> With the patch,
>>
>>   $perf stat sleep 1
>>
>>   Performance counter stats for 'sleep 1':
>>
>>             0.82 msec task-clock:u              #    0.001 CPUs utilized
>>                0      context-switches:u        #    0.000 K/sec
>>                0      cpu-migrations:u          #    0.000 K/sec
>>               61      page-faults:u             #    0.074 M/sec
>>          319,941      cycles:u                  #    0.388 GHz
>>          242,802      instructions:u            #    0.76  insn per cycle
>>           54,380      branches:u                #   66.028 M/sec
>>            4,043      branch-misses:u           #    7.43% of all branches
>>        1,585,555      slots:u                   # 1925.189 M/sec
>>          238,941      topdown-retiring:u        #     15.0% retiring
>>          410,378      topdown-bad-spec:u        #     25.8% bad speculation
>>          634,222      topdown-fe-bound:u        #     39.9% frontend bound
>>          304,675      topdown-be-bound:u        #     19.2% backend bound
> 
> Shouldn't we be adding this to one of the -d levels?

The -d levels' events are architecture events, which should be available 
on all architectures. The Topdown events are X86 specific for now.
I don't think we should add the Topdown events into any of the -d levels.

Different architectures should have their unique events. I think we 
should allow architectures to default their unique and very useful events.

> 
> But you say that this is essentially for free, so you check if this
> extra register is in place and if it is, hey, its for free, add it, is
> that the rationale?
> > I.e. it doesn't cause any impact to what we were getting before, so we
> should default to use free stuff?

Free is just one of the benefits. The key motivation is that we think 
the Topdown information is very useful information, which can help users 
identify performance bottlenecks in modern out-of-order processors.

Here is an example that triggers lots of itlb misses.

With the patch, users can simply identify the performance issue with 
default perf stat (98.0% frontend bound, which leads the users to check 
the fetch bandwidth or the fetch latency related events, e.g., itlb 
misses).

$perf stat ./itlb -b10000 -n200 -c0
  Performance counter stats for './itlb -b10000 -n200 -c0':

          14,567.03 msec task-clock:u              #    1.000 CPUs utilized
                  0      context-switches:u        #    0.000 K/sec
                  0      cpu-migrations:u          #    0.000 K/sec
                683      page-faults:u             #    0.047 K/sec
     55,890,568,522      cycles:u                  #    3.837 GHz
      3,601,934,137      instructions:u            #    0.06  insn per cycle
        400,353,806      branches:u                #   27.484 M/sec
             24,078      branch-misses:u           #    0.01% of all 
branches
    279,391,452,475      slots:u                   # 19179.715 M/sec
      2,230,224,702      topdown-retiring:u        #      0.8% retiring
      3,286,958,264      topdown-bad-spec:u        #      1.2% bad 
speculation
    273,953,648,626      topdown-fe-bound:u        #     98.0% frontend 
bound
          4,579,804      topdown-be-bound:u        #      0.0% backend bound



Without the patch, users cannot get any useful hints from the default 
perf stat. Even with -d -d, users still cannot locate the issue to itlb 
misses, because we don't have an architecture iTLB-loads event.
The -d -d also triggers the multiplexing.

$ perf stat -d -d ./itlb -b10000 -n200 -c0

  Performance counter stats for './itlb -b10000 -n200 -c0':

          14,633.58 msec task-clock:u              #    1.000 CPUs utilized
                  0      context-switches:u        #    0.000 K/sec
                  0      cpu-migrations:u          #    0.000 K/sec
                682      page-faults:u             #    0.047 K/sec
     56,198,668,109      cycles:u                  #    3.840 GHz 
                (38.41%)
      3,602,460,111      instructions:u            #    0.06  insn per 
cycle           (46.12%)
        400,445,992      branches:u                #   27.365 M/sec 
                (53.83%)
             28,757      branch-misses:u           #    0.01% of all 
branches          (61.54%)
            761,047      L1-dcache-loads:u         #    0.052 M/sec 
                (69.27%)
         24,619,906      L1-dcache-load-misses:u   # 3235.00% of all 
L1-dcache accesses  (69.28%)
            905,610      LLC-loads:u               #    0.062 M/sec 
                (69.28%)
            603,464      LLC-load-misses:u         #   66.64% of all 
LL-cache accesses  (69.28%)
    <not supported>      L1-icache-loads:u
      3,870,274,747      L1-icache-load-misses:u 
                (30.73%)
              7,341      dTLB-loads:u              #    0.502 K/sec 
                (30.72%)
              4,730      dTLB-load-misses:u        #   64.43% of all 
dTLB cache accesses  (30.72%)
    <not supported>      iTLB-loads:u
        196,493,394      iTLB-load-misses:u 
                (30.72%)


Thanks,
Kan

> 
> - Arnaldo
>   
>>         1.001791625 seconds time elapsed
>>
>>         0.000000000 seconds user
>>         0.001572000 seconds sys
>>
>> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
>> ---
>>   tools/perf/arch/x86/util/Build    |  1 +
>>   tools/perf/arch/x86/util/evlist.c | 15 +++++++++++++++
>>   tools/perf/builtin-stat.c         |  3 +++
>>   tools/perf/util/evlist.c          |  5 +++++
>>   tools/perf/util/evlist.h          |  2 ++
>>   5 files changed, 26 insertions(+)
>>   create mode 100644 tools/perf/arch/x86/util/evlist.c
>>
>> diff --git a/tools/perf/arch/x86/util/Build b/tools/perf/arch/x86/util/Build
>> index 347c39b960eb..ce1ec92fecdc 100644
>> --- a/tools/perf/arch/x86/util/Build
>> +++ b/tools/perf/arch/x86/util/Build
>> @@ -6,6 +6,7 @@ perf-y += perf_regs.o
>>   perf-y += topdown.o
>>   perf-y += machine.o
>>   perf-y += event.o
>> +perf-y += evlist.o
>>   
>>   perf-$(CONFIG_DWARF) += dwarf-regs.o
>>   perf-$(CONFIG_BPF_PROLOGUE) += dwarf-regs.o
>> diff --git a/tools/perf/arch/x86/util/evlist.c b/tools/perf/arch/x86/util/evlist.c
>> new file mode 100644
>> index 000000000000..8c6732cc7794
>> --- /dev/null
>> +++ b/tools/perf/arch/x86/util/evlist.c
>> @@ -0,0 +1,15 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +#include <stdio.h>
>> +#include "util/pmu.h"
>> +#include "util/evlist.h"
>> +#include "util/parse-events.h"
>> +
>> +#define TOPDOWN_L1_EVENTS	"{slots,topdown-retiring,topdown-bad-spec,topdown-fe-bound,topdown-be-bound}"
>> +
>> +int arch_evlist__add_default_attrs(struct evlist *evlist)
>> +{
>> +	if (!pmu_have_event("cpu", "slots"))
>> +		return 0;
>> +
>> +	return parse_events(evlist, TOPDOWN_L1_EVENTS, NULL);
>> +}
>> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
>> index 3c054b8d4677..abcdabaf1701 100644
>> --- a/tools/perf/builtin-stat.c
>> +++ b/tools/perf/builtin-stat.c
>> @@ -1827,6 +1827,9 @@ static int add_default_attributes(void)
>>   		}
>>   		if (evlist__add_default_attrs(evsel_list, default_attrs1) < 0)
>>   			return -1;
>> +
>> +		if (arch_evlist__add_default_attrs(evsel_list) < 0)
>> +			return -1;
>>   	}
>>   
>>   	/* Detailed events get appended to the event list: */
>> diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
>> index 05363a7247c4..b38589d8c027 100644
>> --- a/tools/perf/util/evlist.c
>> +++ b/tools/perf/util/evlist.c
>> @@ -303,6 +303,11 @@ int __evlist__add_default_attrs(struct evlist *evlist, struct perf_event_attr *a
>>   	return evlist__add_attrs(evlist, attrs, nr_attrs);
>>   }
>>   
>> +__weak int arch_evlist__add_default_attrs(struct evlist *evlist __maybe_unused)
>> +{
>> +	return 0;
>> +}
>> +
>>   struct evsel *evlist__find_tracepoint_by_id(struct evlist *evlist, int id)
>>   {
>>   	struct evsel *evsel;
>> diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
>> index 1aae75895dea..9eba4958a1e9 100644
>> --- a/tools/perf/util/evlist.h
>> +++ b/tools/perf/util/evlist.h
>> @@ -110,6 +110,8 @@ int __evlist__add_default_attrs(struct evlist *evlist,
>>   #define evlist__add_default_attrs(evlist, array) \
>>   	__evlist__add_default_attrs(evlist, array, ARRAY_SIZE(array))
>>   
>> +int arch_evlist__add_default_attrs(struct evlist *evlist);
>> +
>>   int evlist__add_dummy(struct evlist *evlist);
>>   
>>   int evlist__add_sb_event(struct evlist *evlist, struct perf_event_attr *attr,
>> -- 
>> 2.25.1
>>
> 
