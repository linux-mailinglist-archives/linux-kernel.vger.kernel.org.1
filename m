Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C4201AE7C4
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Apr 2020 23:48:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728329AbgDQVry (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Apr 2020 17:47:54 -0400
Received: from mga01.intel.com ([192.55.52.88]:46712 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728160AbgDQVrx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 17:47:53 -0400
IronPort-SDR: 63wkaoaRGAy41sit5BJ2Yr2qiSMInCW0zg8bpPinSvXwd4a8JBKkBEXtDoorecDJZv5m1zqY/V
 8Nrc8PKYKNJg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2020 14:47:52 -0700
IronPort-SDR: fFPddu3mvQupnlIsApYW5/xk/I9KK2P0rLOtk0tbtVHi50EszeoVAAgp3z+FTWg3dG5C7/mDO2
 24zX8lAx0MLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,395,1580803200"; 
   d="scan'208";a="364444563"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga001.fm.intel.com with ESMTP; 17 Apr 2020 14:47:52 -0700
Received: from [10.252.130.106] (kliang2-mobl.ccr.corp.intel.com [10.252.130.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id A17D15802C9;
        Fri, 17 Apr 2020 14:47:50 -0700 (PDT)
Subject: Re: [PATCH V4 00/17] Stitch LBR call stack (Perf Tools)
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     jolsa@redhat.com, peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, namhyung@kernel.org,
        adrian.hunter@intel.com, mathieu.poirier@linaro.org,
        ravi.bangoria@linux.ibm.com, alexey.budankov@linux.intel.com,
        vitaly.slobodskoy@intel.com, pavel.gerasimov@intel.com,
        mpe@ellerman.id.au, eranian@google.com, ak@linux.intel.com
References: <20200319202517.23423-1-kan.liang@linux.intel.com>
 <20200417174803.GA21512@kernel.org>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <2b34783b-85d1-6d30-d9e1-f550f8b6e9c0@linux.intel.com>
Date:   Fri, 17 Apr 2020 17:47:49 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200417174803.GA21512@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/17/2020 1:48 PM, Arnaldo Carvalho de Melo wrote:
> Em Thu, Mar 19, 2020 at 01:25:00PM -0700, kan.liang@linux.intel.com escreveu:
>> From: Kan Liang <kan.liang@linux.intel.com>
>>
>> Changes since V3:
>> - There is no dependency among the 'capabilities'. If perf fails to read
>>    one, it should not impact others. Continue to parse the rest of caps.
>>    (Patch 1)
>> - Use list_for_each_entry() to replace perf_pmu__scan_caps() (Patch 1 &
>>    2)
>> - Combine the declaration plus assignment when possible (Patch 1 & 2)
>> - Add check for script/report/c2c.. (Patch 13, 14 & 16)
>>
>> Changes since V2:
>> - Check strdup() in Patch 1
>> - Split several patches into smaller patches
>>
>> Changes since V1:
>> - Rebase on top of commit 5100c2b77049 ("perf header: Add check for
>>    unexpected use of reserved membrs in event attr")
>> - Fix compling error with GCC9 in patch 1.
>>
>>
>> The kernel patches have been merged into linux-next.
>>    commit bbfd5e4fab63 ("perf/core: Add new branch sample type for HW
>> index of raw branch records")
>>    commit db278b90c326 ("perf/x86/intel: Output LBR TOS information
>> correctly")
>>
>> Start from Haswell, Linux perf can utilize the existing Last Branch
>> Record (LBR) facility to record call stack. However, the depth of the
>> reconstructed LBR call stack limits to the number of LBR registers.
>> E.g. on skylake, the depth of reconstructed LBR call stack is <= 32
>> That's because HW will overwrite the oldest LBR registers when it's
>> full.
>>
>> However, the overwritten LBRs may still be retrieved from previous
>> sample. At that moment, HW hasn't overwritten the LBR registers yet.
>> Perf tools can stitch those overwritten LBRs on current call stacks to
>> get a more complete call stack.
>>
>> To determine if LBRs can be stitched, the maximum number of LBRs is
>> required. Patch 1 - 4 retrieve the capabilities information from sysfs
>> and save them in perf header.
>>
>> Patch 5 - 12 implements the LBR stitching approach.
>>
>> Users can use the options introduced in patch 13-16 to enable the LBR
>> stitching approach for perf report, script, top and c2c.
>>
>> Patch 17 adds a fast path for duplicate entries check. It benefits all
>> call stack parsing, not just for stitch LBR call stack. It can be
>> merged independently.
>>
>> The stitching approach base on LBR call stack technology. The known
>> limitations of LBR call stack technology still apply to the approach,
>> e.g. Exception handing such as setjmp/longjmp will have calls/returns
>> not match.
>> This approach is not full proof. There can be cases where it creates
>> incorrect call stacks from incorrect matches. There is no attempt
>> to validate any matches in another way. So it is not enabled by default.
>> However in many common cases with call stack overflows it can recreate
>> better call stacks than the default lbr call stack output. So if there
>> are problems with LBR overflows this is a possible workaround.
>>
>> Regression:
>> Users may collect LBR call stack on a machine with new perf tool and
>> new kernel (support LBR TOS). However, they may parse the perf.data with
>> old perf tool (not support LBR TOS). The old tool doesn't check
>> attr.branch_sample_type. Users probably get incorrect information
>> without any warning.
>>
>> Performance impact:
>> The processing time may increase with the LBR stitching approach
>> enabled. The impact depends on the increased depth of call stacks.
>>
>> For a simple test case tchain_edit with 43 depth of call stacks.
>> perf record --call-graph lbr -- ./tchain_edit
>> perf report --stitch-lbr
>>
>> Without --stitch-lbr, perf report only display 32 depth of call stacks.
>> With --stitch-lbr, perf report can display all 43 depth of call stacks.
>> The depth of call stacks increase 34.3%.
>>
>> Correspondingly, the processing time of perf report increases 39%,
>> Without --stitch-lbr:                           11.0 sec
>> With --stitch-lbr:                              15.3 sec
> 
> Next time provide the full test proggie, I had to expand those ... to
> reproduce your results,

Sure, I will do so in the future.

> all I have is in perf/core, some patches are
> still to be processed, will continue later, have to stop now, see:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/commit/?id=13cfba6b741ff
> 
> For my testing, looks really great!

Thanks for the testing. :)

Kan

> 
> - Arnaldo
>   
>> The source code of tchain_edit.c is something similar as below.
>> noinline void f43(void)
>> {
>>          int i;
>>          for (i = 0; i < 10000;) {
>>
>>                  if(i%2)
>>                          i++;
>>                  else
>>                          i++;
>>          }
>> }
>>
>> noinline void f42(void)
>> {
>>          int i;
>>          for (i = 0; i < 100; i++) {
>>                  f43();
>>                  f43();
>>                  f43();
>>          }
>> }
>>
>> noinline void f41(void)
>> {
>>          int i;
>>          for (i = 0; i < 100; i++) {
>>                  f42();
>>                  f42();
>>                  f42();
>>          }
>> }
>> noinline void f40(void)
>> {
>>          f41();
>> }
>>
>> ... ...
>>
>> noinline void f32(void)
>> {
>>          f33();
>> }
>>
>> noinline void f31(void)
>> {
>>          int i;
>>
>>          for (i = 0; i < 10000; i++) {
>>                  if(i%2)
>>                          i++;
>>                  else
>>                          i++;
>>          }
>>
>>          f32();
>> }
>>
>> noinline void f30(void)
>> {
>>          f31();
>> }
>>
>> ... ...
>>
>> noinline void f1(void)
>> {
>>          f2();
>> }
>>
>> int main()
>> {
>>          f1();
>> }
>>
>> Kan Liang (17):
>>    perf pmu: Add support for PMU capabilities
>>    perf header: Support CPU PMU capabilities
>>    perf record: Clear HEADER_CPU_PMU_CAPS for non LBR call stack mode
>>    perf stat: Clear HEADER_CPU_PMU_CAPS
>>    perf machine: Remove the indent in resolve_lbr_callchain_sample
>>    perf machine: Refine the function for LBR call stack reconstruction
>>    perf machine: Factor out lbr_callchain_add_kernel_ip()
>>    perf machine: Factor out lbr_callchain_add_lbr_ip()
>>    perf thread: Add a knob for LBR stitch approach
>>    perf tools: Save previous sample for LBR stitching approach
>>    perf tools: Save previous cursor nodes for LBR stitching approach
>>    perf tools: Stitch LBR call stack
>>    perf report: Add option to enable the LBR stitching approach
>>    perf script: Add option to enable the LBR stitching approach
>>    perf top: Add option to enable the LBR stitching approach
>>    perf c2c: Add option to enable the LBR stitching approach
>>    perf hist: Add fast path for duplicate entries check
>>
>>   tools/perf/Documentation/perf-c2c.txt         |  11 +
>>   tools/perf/Documentation/perf-report.txt      |  11 +
>>   tools/perf/Documentation/perf-script.txt      |  11 +
>>   tools/perf/Documentation/perf-top.txt         |   9 +
>>   .../Documentation/perf.data-file-format.txt   |  16 +
>>   tools/perf/builtin-c2c.c                      |  12 +
>>   tools/perf/builtin-record.c                   |   3 +
>>   tools/perf/builtin-report.c                   |  12 +
>>   tools/perf/builtin-script.c                   |  12 +
>>   tools/perf/builtin-stat.c                     |   1 +
>>   tools/perf/builtin-top.c                      |  11 +
>>   tools/perf/util/branch.h                      |  19 +-
>>   tools/perf/util/callchain.h                   |   8 +
>>   tools/perf/util/env.h                         |   3 +
>>   tools/perf/util/header.c                      | 108 +++++
>>   tools/perf/util/header.h                      |   1 +
>>   tools/perf/util/hist.c                        |  23 +
>>   tools/perf/util/machine.c                     | 423 +++++++++++++++---
>>   tools/perf/util/pmu.c                         |  82 ++++
>>   tools/perf/util/pmu.h                         |   9 +
>>   tools/perf/util/sort.c                        |   2 +-
>>   tools/perf/util/sort.h                        |   2 +
>>   tools/perf/util/thread.c                      |   2 +
>>   tools/perf/util/thread.h                      |  35 ++
>>   tools/perf/util/top.h                         |   1 +
>>   25 files changed, 757 insertions(+), 70 deletions(-)
>>
>> -- 
>> 2.17.1
>>
> 
