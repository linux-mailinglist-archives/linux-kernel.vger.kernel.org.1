Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F492292C59
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 19:08:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731028AbgJSRII (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 13:08:08 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2994 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730938AbgJSRII (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 13:08:08 -0400
Received: from lhreml724-chm.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id 24118B690575A8B28DCE;
        Mon, 19 Oct 2020 18:08:05 +0100 (IST)
Received: from [127.0.0.1] (10.47.6.70) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Mon, 19 Oct
 2020 18:08:03 +0100
Subject: Re: [perf metricgroup] fcc9c5243c:
 perf-sanity-tests.Parse_and_process_metrics.fail
To:     Ian Rogers <irogers@google.com>
CC:     kernel test robot <rong.a.chen@intel.com>,
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
        Linuxarm <linuxarm@huawei.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Joakim Zhang <qiangqing.zhang@nxp.com>,
        Zhangshaokun <zhangshaokun@hisilicon.com>,
        James Clark <james.clark@arm.com>,
        "linux-imx@nxp.com" <linux-imx@nxp.com>,
        0day robot <lkp@intel.com>,
        "lkp@lists.01.org" <lkp@lists.01.org>
References: <1602152121-240367-10-git-send-email-john.garry@huawei.com>
 <20201018085031.GK11647@shao2-debian>
 <CAP-5=fWg4W_fpu-uTZkh-ZoL_7nvqU4F_2LqQgKFvBkfn174HQ@mail.gmail.com>
 <602e6bb8-a4ac-fae7-ed61-edf252e08d9a@huawei.com>
 <CAP-5=fWuUVkn35Ep7TQpFvdVJHi8MntAAbRAXVCU_1bYM2rPeQ@mail.gmail.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <c131f294-f294-0f5f-bd62-186d39810fbf@huawei.com>
Date:   Mon, 19 Oct 2020 18:04:49 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <CAP-5=fWuUVkn35Ep7TQpFvdVJHi8MntAAbRAXVCU_1bYM2rPeQ@mail.gmail.com>
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

On 19/10/2020 17:20, Ian Rogers wrote:
>>> n
>> So this named patch ("perf metricgroup: Hack a fix for aliases...") is
>> breaking test #67 on my machine also, which is a broadwell.
> Thanks for taking a look John. If you want help you can send the
> output of "perf test 67 -vvv" to me. It is possible Broadwell has
> similar glitches in the json to Skylake. I tested the original test on
> server parts as I can access them as cloud machines.

Here it is:

john@localhost:~/kernel-dev7/tools/perf> ./perf test -vv 67
Couldn't bump rlimit(MEMLOCK), failures may take place when creating BPF 
maps, etc
67: Parse and process metrics                             :
--- start ---
test child forked, pid 24433
metric expr inst_retired.any / cpu_clk_unhalted.thread for IPC
parsing metric: inst_retired.any / cpu_clk_unhalted.thread
found event inst_retired.any
found event cpu_clk_unhalted.thread
adding {inst_retired.any,cpu_clk_unhalted.thread}:W
Attempting to add event pmu 'inst_retired.any' with '' that may result 
in non-fatal errors
Attempting to add event pmu 'cpu_clk_unhalted.thread' with '' that may 
result in non-fatal errors
parsing metric: inst_retired.any / cpu_clk_unhalted.thread
lookup: is_ref 0, counted 0, val 300.000000: inst_retired.any
lookup: is_ref 0, counted 101, val 200.000000: cpu_clk_unhalted.thread
metric expr idq_uops_not_delivered.core / (4 * (( ( 
cpu_clk_unhalted.thread / 2 ) * ( 1 + cpu_clk_unhalted.one_thread_active 
/ cpu_clk_unhalted.ref_xclk ) ))) for Frontend_Bound_SMT
parsing metric: idq_uops_not_delivered.core / (4 * (( ( 
cpu_clk_unhalted.thread / 2 ) * ( 1 + cpu_clk_unhalted.one_thread_active 
/ cpu_clk_unhalted.ref_xclk ) )))
found event cpu_clk_unhalted.one_thread_active
found event cpu_clk_unhalted.ref_xclk
found event idq_uops_not_delivered.core
found event cpu_clk_unhalted.thread
adding 
{cpu_clk_unhalted.one_thread_active,cpu_clk_unhalted.ref_xclk,idq_uops_not_delivered.core,cpu_clk_unhalted.thread}:W
Attempting to add event pmu 'cpu_clk_unhalted.one_thread_active' with '' 
that may result in non-fatal errors
Attempting to add event pmu 'cpu_clk_unhalted.ref_xclk' with '' that may 
result in non-fatal errors
Attempting to add event pmu 'idq_uops_not_delivered.core' with '' that 
may result in non-fatal errors
Attempting to add event pmu 'cpu_clk_unhalted.thread' with '' that may 
result in non-fatal errors
parsing metric: idq_uops_not_delivered.core / (4 * (( ( 
cpu_clk_unhalted.thread / 2 ) * ( 1 + cpu_clk_unhalted.one_thread_active 
/ cpu_clk_unhalted.ref_xclk ) )))
lookup: is_ref 0, counted 46, val 300.000000: idq_uops_not_delivered.core
lookup: is_ref 0, counted 0, val 200.000000: cpu_clk_unhalted.thread
lookup: is_ref 0, counted 216, val 400.000000: 
cpu_clk_unhalted.one_thread_active
lookup: is_ref 0, counted 46, val 600.000000: cpu_clk_unhalted.ref_xclk
metric expr (dcache_miss_cpi + icache_miss_cycles) for cache_miss_cycles
parsing metric: (dcache_miss_cpi + icache_miss_cycles)
metric expr l1d\-loads\-misses / inst_retired.any for dcache_miss_cpi
parsing metric: l1d\-loads\-misses / inst_retired.any
metric expr l1i\-loads\-misses / inst_retired.any for icache_miss_cycles
parsing metric: l1i\-loads\-misses / inst_retired.any
found event inst_retired.any
found event l1i-loads-misses
found event l1d-loads-misses
adding {inst_retired.any,l1i-loads-misses,l1d-loads-misses}:W
Attempting to add event pmu 'inst_retired.any' with '' that may result 
in non-fatal errors
adding ref metric icache_miss_cycles: l1i\-loads\-misses / inst_retired.any
adding ref metric dcache_miss_cpi: l1d\-loads\-misses / inst_retired.any
parsing metric: (dcache_miss_cpi + icache_miss_cycles)
lookup: is_ref 1, counted 0, val 0.000000: dcache_miss_cpi
processing metric: dcache_miss_cpi ENTRY
parsing metric: l1d\-loads\-misses / inst_retired.any
lookup: is_ref 0, counted 105, val 300.000000: l1d-loads-misses
lookup: is_ref 0, counted 46, val 400.000000: inst_retired.any
processing metric: dcache_miss_cpi EXIT: 0.750000
lookup: is_ref 1, counted 0, val 0.000000: icache_miss_cycles
processing metric: icache_miss_cycles ENTRY
parsing metric: l1i\-loads\-misses / inst_retired.any
lookup: is_ref 0, counted 216, val 200.000000: l1i-loads-misses
lookup: is_ref 0, counted 46, val 400.000000: inst_retired.any
processing metric: icache_miss_cycles EXIT: 0.500000
metric expr d_ratio(dcache_l2_all_hits, dcache_l2_all) for DCache_L2_Hits
parsing metric: d_ratio(dcache_l2_all_hits, dcache_l2_all)
metric expr l2_rqsts.demand_data_rd_hit + l2_rqsts.pf_hit + 
l2_rqsts.rfo_hit for DCache_L2_All_Hits
parsing metric: l2_rqsts.demand_data_rd_hit + l2_rqsts.pf_hit + 
l2_rqsts.rfo_hit
metric expr dcache_l2_all_hits + dcache_l2_all_miss for DCache_L2_All
parsing metric: dcache_l2_all_hits + dcache_l2_all_miss
metric expr l2_rqsts.demand_data_rd_hit + l2_rqsts.pf_hit + 
l2_rqsts.rfo_hit for DCache_L2_All_Hits
parsing metric: l2_rqsts.demand_data_rd_hit + l2_rqsts.pf_hit + 
l2_rqsts.rfo_hit
metric expr max(l2_rqsts.all_demand_data_rd - 
l2_rqsts.demand_data_rd_hit, 0) + l2_rqsts.pf_miss + l2_rqsts.rfo_miss 
for DCache_L2_All_Miss
parsing metric: max(l2_rqsts.all_demand_data_rd - 
l2_rqsts.demand_data_rd_hit, 0) + l2_rqsts.pf_miss + l2_rqsts.rfo_miss
found event l2_rqsts.rfo_miss
found event l2_rqsts.pf_miss
found event l2_rqsts.rfo_hit
found event l2_rqsts.demand_data_rd_hit
found event l2_rqsts.all_demand_data_rd
found event l2_rqsts.pf_hit
adding 
{l2_rqsts.rfo_miss,l2_rqsts.pf_miss,l2_rqsts.rfo_hit,l2_rqsts.demand_data_rd_hit,l2_rqsts.all_demand_data_rd,l2_rqsts.pf_hit}:W
Attempting to add event pmu 'l2_rqsts.rfo_miss' with '' that may result 
in non-fatal errors
Attempting to add event pmu 'l2_rqsts.pf_miss' with '' that may result 
in non-fatal errors
Attempting to add event pmu 'l2_rqsts.rfo_hit' with '' that may result 
in non-fatal errors
Attempting to add event pmu 'l2_rqsts.demand_data_rd_hit' with '' that 
may result in non-fatal errors
Attempting to add event pmu 'l2_rqsts.all_demand_data_rd' with '' that 
may result in non-fatal errors
Attempting to add event pmu 'l2_rqsts.pf_hit' with '' that may result in 
non-fatal errors
adding ref metric DCache_L2_All_Miss: max(l2_rqsts.all_demand_data_rd - 
l2_rqsts.demand_data_rd_hit, 0) + l2_rqsts.pf_miss + l2_rqsts.rfo_miss
adding ref metric DCache_L2_All_Hits: l2_rqsts.demand_data_rd_hit + 
l2_rqsts.pf_hit + l2_rqsts.rfo_hit
adding ref metric DCache_L2_All: dcache_l2_all_hits + dcache_l2_all_miss
adding ref metric DCache_L2_All_Hits: l2_rqsts.demand_data_rd_hit + 
l2_rqsts.pf_hit + l2_rqsts.rfo_hit
parsing metric: d_ratio(dcache_l2_all_hits, dcache_l2_all)
lookup: is_ref 1, counted 0, val 0.000000: dcache_l2_all_hits
processing metric: dcache_l2_all_hits ENTRY
parsing metric: l2_rqsts.demand_data_rd_hit + l2_rqsts.pf_hit + 
l2_rqsts.rfo_hit
lookup: is_ref 0, counted 8, val 100.000000: l2_rqsts.demand_data_rd_hit
lookup: is_ref 0, counted 224, val 200.000000: l2_rqsts.pf_hit
lookup: is_ref 0, counted 46, val 300.000000: l2_rqsts.rfo_hit
processing metric: dcache_l2_all_hits EXIT: 600.000000
lookup: is_ref 1, counted 0, val 0.000000: dcache_l2_all
processing metric: dcache_l2_all ENTRY
parsing metric: dcache_l2_all_hits + dcache_l2_all_miss
lookup: is_ref 1, counted 1, val 600.000000: dcache_l2_all_hits
lookup: is_ref 1, counted 0, val 0.000000: dcache_l2_all_miss
processing metric: dcache_l2_all_miss ENTRY
parsing metric: max(l2_rqsts.all_demand_data_rd - 
l2_rqsts.demand_data_rd_hit, 0) + l2_rqsts.pf_miss + l2_rqsts.rfo_miss
lookup: is_ref 0, counted 112, val 400.000000: l2_rqsts.all_demand_data_rd
lookup: is_ref 0, counted 8, val 100.000000: l2_rqsts.demand_data_rd_hit
lookup: is_ref 0, counted 100, val 500.000000: l2_rqsts.pf_miss
lookup: is_ref 0, counted 120, val 600.000000: l2_rqsts.rfo_miss
processing metric: dcache_l2_all_miss EXIT: 1400.000000
processing metric: dcache_l2_all EXIT: 2000.000000
metric expr d_ratio(dcache_l2_all_miss, dcache_l2_all) for DCache_L2_Misses
parsing metric: d_ratio(dcache_l2_all_miss, dcache_l2_all)
metric expr max(l2_rqsts.all_demand_data_rd - 
l2_rqsts.demand_data_rd_hit, 0) + l2_rqsts.pf_miss + l2_rqsts.rfo_miss 
for DCache_L2_All_Miss
parsing metric: max(l2_rqsts.all_demand_data_rd - 
l2_rqsts.demand_data_rd_hit, 0) + l2_rqsts.pf_miss + l2_rqsts.rfo_miss
metric expr dcache_l2_all_hits + dcache_l2_all_miss for DCache_L2_All
parsing metric: dcache_l2_all_hits + dcache_l2_all_miss
metric expr l2_rqsts.demand_data_rd_hit + l2_rqsts.pf_hit + 
l2_rqsts.rfo_hit for DCache_L2_All_Hits
parsing metric: l2_rqsts.demand_data_rd_hit + l2_rqsts.pf_hit + 
l2_rqsts.rfo_hit
metric expr max(l2_rqsts.all_demand_data_rd - 
l2_rqsts.demand_data_rd_hit, 0) + l2_rqsts.pf_miss + l2_rqsts.rfo_miss 
for DCache_L2_All_Miss
parsing metric: max(l2_rqsts.all_demand_data_rd - 
l2_rqsts.demand_data_rd_hit, 0) + l2_rqsts.pf_miss + l2_rqsts.rfo_miss
found event l2_rqsts.rfo_miss
found event l2_rqsts.pf_miss
found event l2_rqsts.rfo_hit
found event l2_rqsts.demand_data_rd_hit
found event l2_rqsts.all_demand_data_rd
found event l2_rqsts.pf_hit
adding 
{l2_rqsts.rfo_miss,l2_rqsts.pf_miss,l2_rqsts.rfo_hit,l2_rqsts.demand_data_rd_hit,l2_rqsts.all_demand_data_rd,l2_rqsts.pf_hit}:W
Attempting to add event pmu 'l2_rqsts.rfo_miss' with '' that may result 
in non-fatal errors
Attempting to add event pmu 'l2_rqsts.pf_miss' with '' that may result 
in non-fatal errors
Attempting to add event pmu 'l2_rqsts.rfo_hit' with '' that may result 
in non-fatal errors
Attempting to add event pmu 'l2_rqsts.demand_data_rd_hit' with '' that 
may result in non-fatal errors
Attempting to add event pmu 'l2_rqsts.all_demand_data_rd' with '' that 
may result in non-fatal errors
Attempting to add event pmu 'l2_rqsts.pf_hit' with '' that may result in 
non-fatal errors
adding ref metric DCache_L2_All_Miss: max(l2_rqsts.all_demand_data_rd - 
l2_rqsts.demand_data_rd_hit, 0) + l2_rqsts.pf_miss + l2_rqsts.rfo_miss
adding ref metric DCache_L2_All_Hits: l2_rqsts.demand_data_rd_hit + 
l2_rqsts.pf_hit + l2_rqsts.rfo_hit
adding ref metric DCache_L2_All: dcache_l2_all_hits + dcache_l2_all_miss
adding ref metric DCache_L2_All_Miss: max(l2_rqsts.all_demand_data_rd - 
l2_rqsts.demand_data_rd_hit, 0) + l2_rqsts.pf_miss + l2_rqsts.rfo_miss
parsing metric: d_ratio(dcache_l2_all_miss, dcache_l2_all)
lookup: is_ref 1, counted 0, val 0.000000: dcache_l2_all_miss
processing metric: dcache_l2_all_miss ENTRY
parsing metric: max(l2_rqsts.all_demand_data_rd - 
l2_rqsts.demand_data_rd_hit, 0) + l2_rqsts.pf_miss + l2_rqsts.rfo_miss
lookup: is_ref 0, counted 128, val 400.000000: l2_rqsts.all_demand_data_rd
lookup: is_ref 0, counted 224, val 100.000000: l2_rqsts.demand_data_rd_hit
lookup: is_ref 0, counted 112, val 500.000000: l2_rqsts.pf_miss
lookup: is_ref 0, counted 0, val 600.000000: l2_rqsts.rfo_miss
processing metric: dcache_l2_all_miss EXIT: 1400.000000
lookup: is_ref 1, counted 0, val 0.000000: dcache_l2_all
processing metric: dcache_l2_all ENTRY
parsing metric: dcache_l2_all_hits + dcache_l2_all_miss
lookup: is_ref 1, counted 0, val 0.000000: dcache_l2_all_hits
processing metric: dcache_l2_all_hits ENTRY
parsing metric: l2_rqsts.demand_data_rd_hit + l2_rqsts.pf_hit + 
l2_rqsts.rfo_hit
lookup: is_ref 0, counted 224, val 100.000000: l2_rqsts.demand_data_rd_hit
lookup: is_ref 0, counted 0, val 200.000000: l2_rqsts.pf_hit
lookup: is_ref 0, counted 152, val 300.000000: l2_rqsts.rfo_hit
processing metric: dcache_l2_all_hits EXIT: 600.000000
lookup: is_ref 1, counted 1, val 1400.000000: dcache_l2_all_miss
processing metric: dcache_l2_all EXIT: 2000.000000
metric expr ipc + m2 for M1
parsing metric: ipc + m2
metric expr ipc + m1 for M2
parsing metric: ipc + m1
metric expr ipc + m2 for M1
parsing metric: ipc + m2
failed: recursion detected for m2
metric expr 1/m3 for M3
parsing metric: 1/m3
metric expr 1/m3 for M3
parsing metric: 1/m3
failed: recursion detected for m3
metric expr inst_retired.any / cpu_clk_unhalted.thread for IPC
parsing metric: inst_retired.any / cpu_clk_unhalted.thread
metric expr (dcache_miss_cpi + icache_miss_cycles) for cache_miss_cycles
parsing metric: (dcache_miss_cpi + icache_miss_cycles)
metric expr l1d\-loads\-misses / inst_retired.any for dcache_miss_cpi
parsing metric: l1d\-loads\-misses / inst_retired.any
metric expr l1i\-loads\-misses / inst_retired.any for icache_miss_cycles
parsing metric: l1i\-loads\-misses / inst_retired.any
found event inst_retired.any
found event cpu_clk_unhalted.thread
found event inst_retired.any
found event l1i-loads-misses
found event l1d-loads-misses
adding 
{inst_retired.any,cpu_clk_unhalted.thread}:W,{inst_retired.any,l1i-loads-misses,l1d-loads-misses}:W
Attempting to add event pmu 'inst_retired.any' with '' that may result 
in non-fatal errors
Attempting to add event pmu 'cpu_clk_unhalted.thread' with '' that may 
result in non-fatal errors
Attempting to add event pmu 'inst_retired.any' with '' that may result 
in non-fatal errors
parsing metric: inst_retired.any / cpu_clk_unhalted.thread
lookup: is_ref 0, counted 64, val 800.000000: inst_retired.any
lookup: is_ref 0, counted 32, val 200.000000: cpu_clk_unhalted.thread
adding ref metric icache_miss_cycles: l1i\-loads\-misses / inst_retired.any
adding ref metric dcache_miss_cpi: l1d\-loads\-misses / inst_retired.any
parsing metric: (dcache_miss_cpi + icache_miss_cycles)
lookup: is_ref 1, counted 0, val 0.000000: dcache_miss_cpi
processing metric: dcache_miss_cpi ENTRY
parsing metric: l1d\-loads\-misses / inst_retired.any
lookup: is_ref 0, counted 0, val 300.000000: l1d-loads-misses
lookup: is_ref 0, counted 64, val 800.000000: inst_retired.any
processing metric: dcache_miss_cpi EXIT: 0.375000
lookup: is_ref 1, counted 0, val 0.000000: icache_miss_cycles
processing metric: icache_miss_cycles ENTRY
parsing metric: l1i\-loads\-misses / inst_retired.any
lookup: is_ref 0, counted 32, val 200.000000: l1i-loads-misses
lookup: is_ref 0, counted 64, val 800.000000: inst_retired.any
processing metric: icache_miss_cycles EXIT: 0.250000
FAILED tests/parse-metric.c:343 group IPC failed, wrong ratio
FAILED tests/parse-metric.c:357 test metric group
test child finished with -1
---- end ----
Parse and process metrics: FAILED!
john@localhost:~/kernel-dev7/tools/perf>


> 
>> I will have a look, but I was hoping that Ian would have a proper fix
>> for this on top of ("perf metricgroup: Fix uncore metric expressions"),
>> which now looks to be merged.
> I still have these changes to look at in my inbox but I'm assuming
> they're good:-) 

really? I wouldn't assume my hacky patch is good :)

> Sorry for not getting to them, but it's good they are
> merged.

cheers
