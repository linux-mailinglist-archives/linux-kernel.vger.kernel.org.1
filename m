Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C13F02BC45D
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Nov 2020 08:26:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727307AbgKVHYv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Nov 2020 02:24:51 -0500
Received: from mga12.intel.com ([192.55.52.136]:18997 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726957AbgKVHYs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Nov 2020 02:24:48 -0500
IronPort-SDR: lH6E3PN7Jn6d4HLzpFNAxwPYDYYEzgABMFU+Ju/EbWAS5IX3Q+9uJIPCzYJIZxBr9lQUolkn2i
 MbgzynfHnpDQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9812"; a="150896005"
X-IronPort-AV: E=Sophos;i="5.78,360,1599548400"; 
   d="yaml'?scan'208";a="150896005"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2020 23:24:38 -0800
IronPort-SDR: KKXoP4jmAXrGGjvbI34ETvOdrLVqSsYvAKpD37dksJwB/O+f7/AYcpLHDHpgmSMTbwashqdHB5
 zJ1+/7pgLboQ==
X-IronPort-AV: E=Sophos;i="5.78,360,1599548400"; 
   d="yaml'?scan'208";a="546015482"
Received: from xsang-optiplex-9020.sh.intel.com (HELO xsang-OptiPlex-9020) ([10.239.159.140])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2020 23:24:29 -0800
Date:   Sun, 22 Nov 2020 15:38:44 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     Alex Kogan <alex.kogan@oracle.com>
Cc:     linux@armlinux.org.uk, peterz@infradead.org, mingo@redhat.com,
        will.deacon@arm.com, arnd@arndb.de, longman@redhat.com,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, bp@alien8.de,
        hpa@zytor.com, x86@kernel.org, guohanjun@huawei.com,
        jglauber@marvell.com, steven.sistare@oracle.com,
        daniel.m.jordan@oracle.com, alex.kogan@oracle.com,
        dave.dice@oracle.com, 0day robot <lkp@intel.com>, lkp@lists.01.org,
        ying.huang@intel.com, feng.tang@intel.com, zhengjun.xing@intel.com
Subject: [locking/qspinlock]  0dd6d5b8c0:  vm-scalability.throughput 102.9%
 improvement
Message-ID: <20201122073844.GA2390@xsang-OptiPlex-9020>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="wRRV7LY7NUeQGEoC"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201117231323.797104-4-alex.kogan@oracle.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wRRV7LY7NUeQGEoC
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit


Greeting,

FYI, we noticed a 102.9% improvement of vm-scalability.throughput due to commit:


commit: 0dd6d5b8c0f6f31d8d557485fff4931600ae9848 ("[PATCH v12 3/5] locking/qspinlock: Introduce CNA into the slow path of qspinlock")
url: https://github.com/0day-ci/linux/commits/Alex-Kogan/Add-NUMA-awareness-to-qspinlock/20201118-072506
base: https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git 932f8c64d38bb08f69c8c26a2216ba0c36c6daa8

in testcase: vm-scalability
on test machine: 192 threads Intel(R) Xeon(R) Platinum 9242 CPU @ 2.30GHz with 192G memory
with following parameters:

	runtime: 300s
	size: 8T
	test: anon-cow-seq-mt
	cpufreq_governor: performance
	ucode: 0x5003003

test-description: The motivation behind this suite is to exercise functions and regions of the mm/ of the Linux kernel which are of interest to us.
test-url: https://git.kernel.org/cgit/linux/kernel/git/wfg/vm-scalability.git/

In addition to that, the commit also has significant impact on the following tests:

+------------------+---------------------------------------------------------------------------+
| testcase: change | fsmark: fsmark.files_per_sec 77.8% improvement                            |
| test machine     | 192 threads Intel(R) Xeon(R) Platinum 9242 CPU @ 2.30GHz with 192G memory |
| test parameters  | cpufreq_governor=performance                                              |
|                  | disk=1BRD_48G                                                             |
|                  | filesize=4M                                                               |
|                  | fs=xfs                                                                    |
|                  | iterations=1x                                                             |
|                  | nr_threads=64t                                                            |
|                  | sync_method=fsyncBeforeClose                                              |
|                  | test_size=40G                                                             |
|                  | ucode=0x5003003                                                           |
+------------------+---------------------------------------------------------------------------+
| testcase: change | will-it-scale: will-it-scale.per_thread_ops 84.5% improvement             |
| test machine     | 144 threads Intel(R) Xeon(R) CPU E7-8890 v3 @ 2.50GHz with 512G memory    |
| test parameters  | cpufreq_governor=performance                                              |
|                  | mode=thread                                                               |
|                  | nr_task=100%                                                              |
|                  | test=unlink2                                                              |
|                  | ucode=0x16                                                                |
+------------------+---------------------------------------------------------------------------+
| testcase: change | reaim: reaim.jobs_per_min 98.1% improvement                               |
| test machine     | 192 threads Intel(R) Xeon(R) Platinum 9242 CPU @ 2.30GHz with 192G memory |
| test parameters  | cpufreq_governor=performance                                              |
|                  | nr_task=100%                                                              |
|                  | runtime=300s                                                              |
|                  | test=fserver                                                              |
|                  | ucode=0x5003003                                                           |
+------------------+---------------------------------------------------------------------------+
| testcase: change | fsmark: fsmark.files_per_sec 194.3% improvement                           |
| test machine     | 96 threads Intel(R) Xeon(R) CPU @ 2.30GHz with 128G memory                |
| test parameters  | cpufreq_governor=performance                                              |
|                  | disk=1BRD_48G                                                             |
|                  | filesize=4M                                                               |
|                  | fs=f2fs                                                                   |
|                  | iterations=1x                                                             |
|                  | nr_threads=64t                                                            |
|                  | sync_method=NoSync                                                        |
|                  | test_size=40G                                                             |
|                  | ucode=0x5003003                                                           |
+------------------+---------------------------------------------------------------------------+
| testcase: change | reaim: reaim.jobs_per_min 112.6% improvement                              |
| test machine     | 192 threads Intel(R) Xeon(R) Platinum 9242 CPU @ 2.30GHz with 192G memory |
| test parameters  | cpufreq_governor=performance                                              |
|                  | nr_task=100%                                                              |
|                  | runtime=300s                                                              |
|                  | test=five_sec                                                             |
|                  | ucode=0x5003003                                                           |
+------------------+---------------------------------------------------------------------------+
| testcase: change | reaim: reaim.jobs_per_min 99.3% improvement                               |
| test machine     | 192 threads Intel(R) Xeon(R) Platinum 9242 CPU @ 2.30GHz with 192G memory |
| test parameters  | cpufreq_governor=performance                                              |
|                  | nr_task=100%                                                              |
|                  | runtime=300s                                                              |
|                  | test=new_fserver                                                          |
|                  | ucode=0x5003003                                                           |
+------------------+---------------------------------------------------------------------------+
| testcase: change | stress-ng: stress-ng.timerfd.ops_per_sec 1.8% improvement                 |
| test machine     | 192 threads Intel(R) Xeon(R) Platinum 9242 CPU @ 2.30GHz with 192G memory |
| test parameters  | class=interrupt                                                           |
|                  | cpufreq_governor=performance                                              |
|                  | disk=1HDD                                                                 |
|                  | nr_threads=100%                                                           |
|                  | testtime=30s                                                              |
|                  | ucode=0x42e                                                               |
+------------------+---------------------------------------------------------------------------+




Details are as below:
-------------------------------------------------------------------------------------------------->


To reproduce:

        git clone https://github.com/intel/lkp-tests.git
        cd lkp-tests
        bin/lkp install job.yaml  # job file is attached in this email
        bin/lkp run     job.yaml

=========================================================================================
compiler/cpufreq_governor/kconfig/rootfs/runtime/size/tbox_group/test/testcase/ucode:
  gcc-9/performance/x86_64-rhel-8.3/debian-10.4-x86_64-20200603.cgz/300s/8T/lkp-csl-2ap4/anon-cow-seq-mt/vm-scalability/0x5003003

commit: 
  268df4df6c ("locking/qspinlock: Refactor the qspinlock slow path")
  0dd6d5b8c0 ("locking/qspinlock: Introduce CNA into the slow path of qspinlock")

268df4df6cb0a27d 0dd6d5b8c0f6f31d8d557485fff 
---------------- --------------------------- 
       fail:runs  %reproduction    fail:runs
           |             |             |    
           :4            5%           0:4     perf-profile.children.cycles-pp.error_entry
         %stddev     %change         %stddev
             \          |                \  
     30218          +102.9%      61312        vm-scalability.median
   5801952          +102.9%   11772006        vm-scalability.throughput
    231878 ±  2%      -5.5%     219214 ±  3%  vm-scalability.time.involuntary_context_switches
 1.396e+08            +7.0%  1.494e+08 ±  2%  vm-scalability.time.minor_page_faults
     18205            -1.5%      17933        vm-scalability.time.percent_of_cpu_this_job_got
     54447            -5.0%      51712        vm-scalability.time.system_time
    458.00 ±  3%    +434.7%       2448 ±  3%  vm-scalability.time.user_time
 1.744e+09          +102.8%  3.537e+09        vm-scalability.workload
    186314           +23.3%     229696        meminfo.max_used_kB
     34.47            -5.7%      32.50 ±  3%  boot-time.boot
      5753            -7.0%       5350 ±  3%  boot-time.idle
   2858717 ± 36%    +893.6%   28404296 ± 89%  cpuidle.C1.time
     23972 ±  7%   +2337.2%     584263 ± 88%  cpuidle.C1.usage
     94.00            -4.3%      90.00        vmstat.cpu.sy
    866509          +170.0%    2339335 ±  2%  vmstat.system.in
     22761 ± 11%     +20.1%      27326 ± 19%  numa-meminfo.node1.KReclaimable
     22761 ± 11%     +20.1%      27326 ± 19%  numa-meminfo.node1.SReclaimable
     12244 ±121%  +96443.2%   11820751 ±172%  numa-meminfo.node2.AnonHugePages
     10587 ±  5%     -21.3%       8329 ± 17%  softirqs.CPU120.RCU
     10869 ±  6%     -25.4%       8109 ± 15%  softirqs.CPU144.RCU
      6017 ±  3%     +24.9%       7515 ± 24%  softirqs.CPU166.RCU
     10206 ±  7%     -30.9%       7054 ±  5%  softirqs.CPU168.RCU
      4.12 ±  3%      +0.7        4.80 ±  4%  mpstat.cpu.all.idle%
      0.00 ± 33%      +0.0        0.00 ±124%  mpstat.cpu.all.iowait%
      1.33 ±  4%      +0.8        2.09 ±  2%  mpstat.cpu.all.irq%
      0.01 ±  5%      +0.0        0.01 ±  2%  mpstat.cpu.all.soft%
      0.82 ±  2%      +3.4        4.24 ±  3%  mpstat.cpu.all.usr%
  27295236 ± 45%     -95.5%    1233061 ±115%  numa-numastat.node0.local_node
  27318554 ± 45%     -95.4%    1248587 ±113%  numa-numastat.node0.numa_hit
  14733578 ±100%     -99.9%      15548 ± 99%  numa-numastat.node0.other_node
  34533268           -98.8%     431013 ± 26%  numa-numastat.node2.local_node
  34548910           -98.7%     454397 ± 24%  numa-numastat.node2.numa_hit
  14202331 ± 38%     -90.3%    1380038 ± 87%  numa-vmstat.node0.numa_hit
  14161747 ± 38%     -90.6%    1331257 ± 92%  numa-vmstat.node0.numa_local
      5690 ± 11%     +20.1%       6831 ± 19%  numa-vmstat.node1.nr_slab_reclaimable
      5.75 ±120%    +1e+05%       5771 ±172%  numa-vmstat.node2.nr_anon_transparent_hugepages
  17299218           -96.2%     659465 ± 19%  numa-vmstat.node2.numa_hit
  17199526           -96.7%     567759 ± 24%  numa-vmstat.node2.numa_local
     80114           -11.0%      71296 ±  3%  slabinfo.anon_vma_chain.active_objs
      1251           -10.6%       1118 ±  3%  slabinfo.anon_vma_chain.active_slabs
     80114           -10.6%      71620 ±  3%  slabinfo.anon_vma_chain.num_objs
      1251           -10.6%       1118 ±  3%  slabinfo.anon_vma_chain.num_slabs
     91309           -12.0%      80334 ±  2%  slabinfo.vm_area_struct.active_objs
      2290           -12.1%       2013 ±  2%  slabinfo.vm_area_struct.active_slabs
     91619           -12.1%      80560 ±  2%  slabinfo.vm_area_struct.num_objs
      2290           -12.1%       2013 ±  2%  slabinfo.vm_area_struct.num_slabs
  12470155            +9.2%   13615274        proc-vmstat.nr_anon_pages
   3606602            -3.2%    3491988        proc-vmstat.nr_dirty_background_threshold
   7222025            -3.2%    6992514        proc-vmstat.nr_dirty_threshold
  36301486            -3.2%   35153728        proc-vmstat.nr_free_pages
  12496926            +9.2%   13643770        proc-vmstat.nr_inactive_anon
     33080            -3.1%      32042        proc-vmstat.nr_kernel_stack
     75594            -3.0%      73297        proc-vmstat.nr_slab_unreclaimable
  12496926            +9.2%   13643771        proc-vmstat.nr_zone_inactive_anon
     10091 ± 60%    +729.2%      83678 ± 87%  proc-vmstat.numa_hint_faults
  12854167           +17.2%   15062474        proc-vmstat.numa_pte_updates
 1.512e+08            -2.6%  1.472e+08 ±  2%  proc-vmstat.pgalloc_normal
 1.407e+08            +6.9%  1.505e+08 ±  2%  proc-vmstat.pgfault
 1.513e+08            -2.7%  1.473e+08 ±  2%  proc-vmstat.pgfree
      1420          +321.1%       5980 ±  2%  proc-vmstat.thp_split_pmd
      6.41 ±173%  +5.8e+06%     370773 ± 67%  sched_debug.cfs_rq:/.MIN_vruntime.avg
      1186 ±173%  +1.3e+06%   14998137 ± 24%  sched_debug.cfs_rq:/.MIN_vruntime.max
     86.97 ±173%  +2.2e+06%    1917722 ± 38%  sched_debug.cfs_rq:/.MIN_vruntime.stddev
    831.77 ±  8%     +24.2%       1033 ±  9%  sched_debug.cfs_rq:/.exec_clock.stddev
      4874 ±  4%    +362.0%      22520 ± 65%  sched_debug.cfs_rq:/.load.avg
     39395 ±101%   +1152.2%     493308 ± 29%  sched_debug.cfs_rq:/.load.max
      3017 ± 92%   +2392.0%      75197 ± 51%  sched_debug.cfs_rq:/.load.stddev
      7.00 ±  6%    +302.6%      28.19 ± 16%  sched_debug.cfs_rq:/.load_avg.avg
    219.29 ± 32%    +130.4%     505.25 ± 13%  sched_debug.cfs_rq:/.load_avg.max
     19.01 ± 26%    +291.7%      74.44 ± 11%  sched_debug.cfs_rq:/.load_avg.stddev
      6.41 ±173%  +5.8e+06%     370773 ± 67%  sched_debug.cfs_rq:/.max_vruntime.avg
      1186 ±173%  +1.3e+06%   14998137 ± 24%  sched_debug.cfs_rq:/.max_vruntime.max
     86.97 ±173%  +2.2e+06%    1917722 ± 38%  sched_debug.cfs_rq:/.max_vruntime.stddev
      1.00           +45.8%       1.46 ±  9%  sched_debug.cfs_rq:/.nr_running.max
      0.05 ± 41%    +159.9%       0.12 ± 37%  sched_debug.cfs_rq:/.nr_running.stddev
      1.17 ± 21%  +19565.8%     231.01 ±  2%  sched_debug.cfs_rq:/.nr_spread_over.avg
     36.54 ± 16%   +3697.6%       1387 ± 37%  sched_debug.cfs_rq:/.nr_spread_over.max
      2.89 ± 14%   +5089.1%     149.83 ± 14%  sched_debug.cfs_rq:/.nr_spread_over.stddev
      1632 ±  7%     +24.0%       2024 ±  5%  sched_debug.cfs_rq:/.runnable_avg.max
     98.35 ± 18%     +70.7%     167.89 ±  7%  sched_debug.cfs_rq:/.runnable_avg.stddev
     77.28 ±  9%     +20.2%      92.87 ± 12%  sched_debug.cfs_rq:/.util_avg.stddev
    855.09           -18.5%     696.71 ± 12%  sched_debug.cfs_rq:/.util_est_enqueued.avg
     84.61 ± 15%    +246.2%     292.94 ± 31%  sched_debug.cfs_rq:/.util_est_enqueued.stddev
    432875 ±  4%     +79.5%     777140 ± 12%  sched_debug.cpu.avg_idle.avg
      0.11 ± 14%     +82.9%       0.19 ± 24%  sched_debug.cpu.nr_running.stddev
    899.79           -13.4%     779.17 ±  8%  sched_debug.cpu.sched_count.min
    820.74 ±  7%     +13.3%     930.05 ±  6%  sched_debug.cpu.ttwu_count.stddev
    679.06 ±  3%      -8.0%     624.81 ±  7%  sched_debug.cpu.ttwu_local.avg
      2.66 ±  8%     +87.9%       5.00 ±  9%  perf-stat.i.MPKI
 1.347e+10           +45.6%  1.961e+10        perf-stat.i.branch-instructions
      0.26 ± 10%      +0.1        0.32 ± 21%  perf-stat.i.branch-miss-rate%
     48.83           -30.4       18.43 ± 23%  perf-stat.i.cache-miss-rate%
 1.283e+08 ±  2%    +154.4%  3.263e+08 ±  2%  perf-stat.i.cache-references
     10.52           -28.3%       7.54        perf-stat.i.cpi
 5.666e+11            -2.2%  5.543e+11        perf-stat.i.cpu-cycles
    487336 ± 17%     +75.3%     854495 ± 14%  perf-stat.i.dTLB-load-misses
  1.32e+10           +35.8%  1.792e+10        perf-stat.i.dTLB-loads
      0.16            -0.0        0.11        perf-stat.i.dTLB-store-miss-rate%
   1473729          +107.8%    3061936 ±  2%  perf-stat.i.dTLB-store-misses
 9.263e+08          +179.4%  2.588e+09 ±  2%  perf-stat.i.dTLB-stores
     62.59           -23.2       39.38        perf-stat.i.iTLB-load-miss-rate%
   4580511 ±  4%     +25.7%    5759128 ±  3%  perf-stat.i.iTLB-load-misses
   2737401          +233.3%    9124227 ±  2%  perf-stat.i.iTLB-loads
 5.245e+10           +35.6%  7.114e+10        perf-stat.i.instructions
      0.11           +37.3%       0.14        perf-stat.i.ipc
      2.95            -2.3%       2.88        perf-stat.i.metric.GHz
    144.46           +45.7%     210.47        perf-stat.i.metric.M/sec
    463481            +5.8%     490166 ±  2%  perf-stat.i.minor-faults
   7503613           -19.0%    6079046 ±  3%  perf-stat.i.node-load-misses
     96.36            -1.5       94.81        perf-stat.i.node-store-miss-rate%
   9152111           +25.4%   11478512 ± 22%  perf-stat.i.node-store-misses
    169870 ±  5%     +47.6%     250662 ± 12%  perf-stat.i.node-stores
    463482            +5.8%     490167 ±  2%  perf-stat.i.page-faults
      2.44 ±  2%     +86.4%       4.56 ±  2%  perf-stat.overall.MPKI
      0.11            -0.0        0.08 ±  3%  perf-stat.overall.branch-miss-rate%
     49.24           -31.4       17.80 ± 23%  perf-stat.overall.cache-miss-rate%
     10.81           -27.6%       7.83        perf-stat.overall.cpi
      0.16            -0.0        0.12        perf-stat.overall.dTLB-store-miss-rate%
     62.64           -24.0       38.62        perf-stat.overall.iTLB-load-miss-rate%
     11516 ±  4%      +8.7%      12519 ±  2%  perf-stat.overall.instructions-per-iTLB-miss
      0.09           +38.1%       0.13        perf-stat.overall.ipc
      9091           -32.1%       6171        perf-stat.overall.path-length
 1.348e+10           +47.5%  1.988e+10        perf-stat.ps.branch-instructions
 1.283e+08 ±  2%    +156.1%  3.286e+08 ±  3%  perf-stat.ps.cache-references
    579061 ± 16%     +60.5%     929504 ± 15%  perf-stat.ps.dTLB-load-misses
  1.32e+10           +37.6%  1.817e+10        perf-stat.ps.dTLB-loads
   1475148          +109.4%    3088574        perf-stat.ps.dTLB-store-misses
 9.244e+08          +181.8%  2.605e+09 ±  2%  perf-stat.ps.dTLB-stores
   4566981 ±  4%     +26.2%    5762015 ±  2%  perf-stat.ps.iTLB-load-misses
   2720789          +236.6%    9158783 ±  2%  perf-stat.ps.iTLB-loads
 5.247e+10           +37.4%   7.21e+10        perf-stat.ps.instructions
    463758            +6.8%     495422 ±  2%  perf-stat.ps.minor-faults
   7505606           -18.6%    6107819 ±  2%  perf-stat.ps.node-load-misses
   9156405           +24.3%   11380346 ± 21%  perf-stat.ps.node-store-misses
    463760            +6.8%     495424 ±  2%  perf-stat.ps.page-faults
 1.586e+13           +37.6%  2.183e+13        perf-stat.total.instructions
     55.41           -55.4        0.00        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.wp_page_copy.__handle_mm_fault.handle_mm_fault
     43.34           -43.3        0.00        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
     55.53           -32.3       23.18 ±  6%  perf-profile.calltrace.cycles-pp._raw_spin_lock.wp_page_copy.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
     56.06           -32.3       23.73 ±  6%  perf-profile.calltrace.cycles-pp.wp_page_copy.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault
      0.00            +0.8        0.75 ± 23%  perf-profile.calltrace.cycles-pp.asm_sysvec_call_function.__cna_queued_spin_lock_slowpath._raw_spin_lock.__handle_mm_fault.handle_mm_fault
     43.40           +10.6       53.97 ±  2%  perf-profile.calltrace.cycles-pp._raw_spin_lock.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault
      0.00           +21.0       21.02 ±  5%  perf-profile.calltrace.cycles-pp.__cna_queued_spin_lock_slowpath._raw_spin_lock.do_anonymous_page.__handle_mm_fault.handle_mm_fault
      0.00           +21.1       21.06 ±  5%  perf-profile.calltrace.cycles-pp._raw_spin_lock.do_anonymous_page.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
      0.00           +21.1       21.07 ±  5%  perf-profile.calltrace.cycles-pp.do_anonymous_page.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault
      0.00           +23.1       23.10 ±  6%  perf-profile.calltrace.cycles-pp.__cna_queued_spin_lock_slowpath._raw_spin_lock.wp_page_copy.__handle_mm_fault.handle_mm_fault
      0.00           +53.8       53.84 ±  2%  perf-profile.calltrace.cycles-pp.__cna_queued_spin_lock_slowpath._raw_spin_lock.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
     98.94           -98.9        0.00        perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
     56.06           -32.3       23.73 ±  6%  perf-profile.children.cycles-pp.wp_page_copy
      0.20 ±  2%      -0.1        0.09 ± 16%  perf-profile.children.cycles-pp.mem_cgroup_uncharge
      0.20 ±  2%      -0.1        0.09 ± 15%  perf-profile.children.cycles-pp.__put_page
      0.18 ±  2%      -0.1        0.09 ± 13%  perf-profile.children.cycles-pp.uncharge_batch
      0.16 ±  2%      -0.1        0.07 ± 14%  perf-profile.children.cycles-pp.page_counter_uncharge
      0.16            -0.1        0.07 ± 15%  perf-profile.children.cycles-pp.page_counter_cancel
      0.00            +0.1        0.05 ±  8%  perf-profile.children.cycles-pp.irq_exit_rcu
      0.08 ±  6%      +0.1        0.16 ±  7%  perf-profile.children.cycles-pp.native_irq_return_iret
      0.03 ±100%      +0.1        0.14 ± 13%  perf-profile.children.cycles-pp.native_flush_tlb_one_user
      0.00            +0.2        0.17 ± 14%  perf-profile.children.cycles-pp.llist_add_batch
      0.04 ± 58%      +0.2        0.21 ± 23%  perf-profile.children.cycles-pp.llist_reverse_order
      0.06 ± 58%      +0.2        0.30 ± 31%  perf-profile.children.cycles-pp.flush_tlb_func_common
      0.08 ± 11%      +0.2        0.32 ±  5%  perf-profile.children.cycles-pp.flush_tlb_mm_range
      0.07 ± 10%      +0.2        0.32 ±  6%  perf-profile.children.cycles-pp.ptep_clear_flush
      0.07 ± 10%      +0.2        0.32 ±  5%  perf-profile.children.cycles-pp.on_each_cpu_cond_mask
      0.07 ± 10%      +0.2        0.32 ±  5%  perf-profile.children.cycles-pp.smp_call_function_many_cond
      0.08 ± 21%      +0.3        0.38 ± 39%  perf-profile.children.cycles-pp.flush_tlb_func_remote
      0.92 ±  7%      +0.9        1.78 ± 17%  perf-profile.children.cycles-pp.asm_call_sysvec_on_stack
      0.27 ± 16%      +0.9        1.18 ± 28%  perf-profile.children.cycles-pp.flush_smp_call_function_queue
      0.27 ± 16%      +0.9        1.20 ± 28%  perf-profile.children.cycles-pp.__sysvec_call_function
      0.29 ± 16%      +1.0        1.28 ± 27%  perf-profile.children.cycles-pp.sysvec_call_function
      0.34 ± 14%      +1.1        1.48 ± 25%  perf-profile.children.cycles-pp.asm_sysvec_call_function
      0.06 ±  6%     +21.0       21.07 ±  5%  perf-profile.children.cycles-pp.do_anonymous_page
      0.00           +98.6       98.62        perf-profile.children.cycles-pp.__cna_queued_spin_lock_slowpath
     97.93           -97.9        0.00        perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
      0.15            -0.1        0.07 ± 16%  perf-profile.self.cycles-pp.page_counter_cancel
      0.10 ±  4%      -0.1        0.03 ±100%  perf-profile.self.cycles-pp.wp_page_copy
      0.12 ±  3%      -0.1        0.05 ±  9%  perf-profile.self.cycles-pp._raw_spin_lock
      0.00            +0.1        0.06 ± 16%  perf-profile.self.cycles-pp.smp_call_function_many_cond
      0.08 ±  6%      +0.1        0.16 ±  7%  perf-profile.self.cycles-pp.native_irq_return_iret
      0.03 ±100%      +0.1        0.14 ± 13%  perf-profile.self.cycles-pp.native_flush_tlb_one_user
      0.00            +0.2        0.17 ± 48%  perf-profile.self.cycles-pp.flush_tlb_func_common
      0.00            +0.2        0.17 ± 14%  perf-profile.self.cycles-pp.llist_add_batch
      0.04 ± 58%      +0.2        0.21 ± 23%  perf-profile.self.cycles-pp.llist_reverse_order
      0.07 ± 17%      +0.2        0.28 ± 20%  perf-profile.self.cycles-pp.flush_smp_call_function_queue
      0.08 ± 21%      +0.3        0.38 ± 39%  perf-profile.self.cycles-pp.flush_tlb_func_remote
      0.00           +96.6       96.59        perf-profile.self.cycles-pp.__cna_queued_spin_lock_slowpath
 1.445e+08          +307.2%  5.884e+08 ±  2%  interrupts.CAL:Function_call_interrupts
    754855          +300.0%    3019678        interrupts.CPU0.CAL:Function_call_interrupts
    757433          +303.4%    3055634        interrupts.CPU0.TLB:TLB_shootdowns
    752847          +308.7%    3076844 ±  2%  interrupts.CPU1.CAL:Function_call_interrupts
    758040          +310.5%    3111436 ±  2%  interrupts.CPU1.TLB:TLB_shootdowns
    754005          +307.6%    3073264 ±  2%  interrupts.CPU10.CAL:Function_call_interrupts
    272.75 ±  3%     -30.2%     190.50 ±  5%  interrupts.CPU10.RES:Rescheduling_interrupts
    759084          +309.5%    3108513 ±  2%  interrupts.CPU10.TLB:TLB_shootdowns
    752868          +308.4%    3074886 ±  2%  interrupts.CPU100.CAL:Function_call_interrupts
     18.50 ± 20%   +1040.5%     211.00 ± 15%  interrupts.CPU100.RES:Rescheduling_interrupts
    757273          +310.8%    3111185 ±  2%  interrupts.CPU100.TLB:TLB_shootdowns
    753086          +307.7%    3070531 ±  2%  interrupts.CPU101.CAL:Function_call_interrupts
     42.75 ±121%    +708.8%     345.75 ± 74%  interrupts.CPU101.RES:Rescheduling_interrupts
    757952          +309.9%    3106491 ±  2%  interrupts.CPU101.TLB:TLB_shootdowns
    754121          +307.9%    3075829 ±  2%  interrupts.CPU102.CAL:Function_call_interrupts
     16.75 ± 31%   +1062.7%     194.75 ±  8%  interrupts.CPU102.RES:Rescheduling_interrupts
    758461          +310.1%    3110322 ±  2%  interrupts.CPU102.TLB:TLB_shootdowns
    754032          +307.4%    3072225 ±  2%  interrupts.CPU103.CAL:Function_call_interrupts
     18.25 ± 16%   +1045.2%     209.00 ± 20%  interrupts.CPU103.RES:Rescheduling_interrupts
    758330          +309.8%    3107772 ±  2%  interrupts.CPU103.TLB:TLB_shootdowns
    754653          +307.8%    3077320 ±  2%  interrupts.CPU104.CAL:Function_call_interrupts
     26.50 ± 79%    +605.7%     187.00 ±  7%  interrupts.CPU104.RES:Rescheduling_interrupts
    759190          +310.1%    3113539 ±  2%  interrupts.CPU104.TLB:TLB_shootdowns
    752527          +308.2%    3072144 ±  2%  interrupts.CPU105.CAL:Function_call_interrupts
     20.50 ± 35%    +784.1%     181.25 ± 10%  interrupts.CPU105.RES:Rescheduling_interrupts
    757444          +310.4%    3108796 ±  2%  interrupts.CPU105.TLB:TLB_shootdowns
    752256          +308.4%    3072372 ±  2%  interrupts.CPU106.CAL:Function_call_interrupts
     53.25 ± 75%    +339.0%     233.75 ± 27%  interrupts.CPU106.RES:Rescheduling_interrupts
    757056          +310.7%    3108876 ±  2%  interrupts.CPU106.TLB:TLB_shootdowns
    753628          +308.1%    3075792 ±  2%  interrupts.CPU107.CAL:Function_call_interrupts
     19.25 ± 20%   +1164.9%     243.50 ± 36%  interrupts.CPU107.RES:Rescheduling_interrupts
    758508          +310.2%    3111421 ±  2%  interrupts.CPU107.TLB:TLB_shootdowns
    754647          +307.9%    3077857 ±  2%  interrupts.CPU108.CAL:Function_call_interrupts
     24.75 ± 56%    +936.4%     256.50 ± 32%  interrupts.CPU108.RES:Rescheduling_interrupts
    758805          +310.2%    3112570 ±  2%  interrupts.CPU108.TLB:TLB_shootdowns
    753521          +308.1%    3075148 ±  2%  interrupts.CPU109.CAL:Function_call_interrupts
     35.50 ± 50%    +457.7%     198.00 ± 15%  interrupts.CPU109.RES:Rescheduling_interrupts
    757918          +310.4%    3110788 ±  2%  interrupts.CPU109.TLB:TLB_shootdowns
    751778          +309.5%    3078844 ±  2%  interrupts.CPU11.CAL:Function_call_interrupts
    264.50           -26.1%     195.50 ± 14%  interrupts.CPU11.RES:Rescheduling_interrupts
    756489          +311.6%    3113457 ±  2%  interrupts.CPU11.TLB:TLB_shootdowns
    753348          +308.4%    3076637 ±  2%  interrupts.CPU110.CAL:Function_call_interrupts
     35.25 ± 66%    +524.1%     220.00 ± 22%  interrupts.CPU110.RES:Rescheduling_interrupts
    757841          +310.7%    3112637 ±  2%  interrupts.CPU110.TLB:TLB_shootdowns
    754291          +306.4%    3065463 ±  2%  interrupts.CPU111.CAL:Function_call_interrupts
     16.75 ± 37%    +971.6%     179.50 ± 13%  interrupts.CPU111.RES:Rescheduling_interrupts
    759197          +308.6%    3102047 ±  2%  interrupts.CPU111.TLB:TLB_shootdowns
    753415          +307.9%    3073434 ±  2%  interrupts.CPU112.CAL:Function_call_interrupts
     16.25 ± 19%   +1052.3%     187.25 ±  8%  interrupts.CPU112.RES:Rescheduling_interrupts
    758005          +310.3%    3109860 ±  2%  interrupts.CPU112.TLB:TLB_shootdowns
    755116          +307.0%    3073456 ±  2%  interrupts.CPU113.CAL:Function_call_interrupts
     31.25 ± 52%    +557.6%     205.50 ± 15%  interrupts.CPU113.RES:Rescheduling_interrupts
    759682          +309.3%    3109265 ±  2%  interrupts.CPU113.TLB:TLB_shootdowns
    752901          +307.2%    3065556 ±  2%  interrupts.CPU114.CAL:Function_call_interrupts
     28.75 ± 59%    +502.6%     173.25 ± 18%  interrupts.CPU114.RES:Rescheduling_interrupts
    757162          +309.5%    3100711 ±  2%  interrupts.CPU114.TLB:TLB_shootdowns
    754705          +307.6%    3076374 ±  2%  interrupts.CPU115.CAL:Function_call_interrupts
     32.50 ± 50%    +476.9%     187.50 ± 19%  interrupts.CPU115.RES:Rescheduling_interrupts
    758874          +310.0%    3111192 ±  2%  interrupts.CPU115.TLB:TLB_shootdowns
    753777          +307.3%    3070114 ±  2%  interrupts.CPU116.CAL:Function_call_interrupts
     16.50 ±  6%    +927.3%     169.50 ± 24%  interrupts.CPU116.RES:Rescheduling_interrupts
    758528          +309.5%    3106501 ±  2%  interrupts.CPU116.TLB:TLB_shootdowns
    754442          +305.9%    3062186 ±  2%  interrupts.CPU117.CAL:Function_call_interrupts
     26.50 ± 62%    +528.3%     166.50 ± 22%  interrupts.CPU117.RES:Rescheduling_interrupts
    759150          +308.1%    3098051 ±  2%  interrupts.CPU117.TLB:TLB_shootdowns
    752492          +308.6%    3074613 ±  2%  interrupts.CPU118.CAL:Function_call_interrupts
     15.00 ±  4%   +1056.7%     173.50 ± 27%  interrupts.CPU118.RES:Rescheduling_interrupts
    756852          +311.0%    3110993 ±  2%  interrupts.CPU118.TLB:TLB_shootdowns
    752737          +308.1%    3071747 ±  2%  interrupts.CPU119.CAL:Function_call_interrupts
     25.50 ± 40%    +613.7%     182.00 ± 10%  interrupts.CPU119.RES:Rescheduling_interrupts
    756979          +310.4%    3106485 ±  2%  interrupts.CPU119.TLB:TLB_shootdowns
    754754          +307.5%    3075657 ±  2%  interrupts.CPU12.CAL:Function_call_interrupts
    264.75           -23.9%     201.50 ±  8%  interrupts.CPU12.RES:Rescheduling_interrupts
    759406          +309.4%    3109383 ±  2%  interrupts.CPU12.TLB:TLB_shootdowns
    751249          +307.1%    3058053 ±  3%  interrupts.CPU120.CAL:Function_call_interrupts
     59.75 ± 25%    +473.2%     342.50 ± 79%  interrupts.CPU120.RES:Rescheduling_interrupts
    756703          +310.7%    3107456        interrupts.CPU120.TLB:TLB_shootdowns
    751337          +306.5%    3054500 ±  3%  interrupts.CPU121.CAL:Function_call_interrupts
     46.00 ± 37%    +693.5%     365.00 ± 86%  interrupts.CPU121.RES:Rescheduling_interrupts
    757426          +309.6%    3102591        interrupts.CPU121.TLB:TLB_shootdowns
    752472          +305.7%    3053142 ±  3%  interrupts.CPU122.CAL:Function_call_interrupts
     24.75 ± 30%   +1036.4%     281.25 ± 58%  interrupts.CPU122.RES:Rescheduling_interrupts
    758519          +309.2%    3103744 ±  2%  interrupts.CPU122.TLB:TLB_shootdowns
    753259          +306.4%    3061160 ±  3%  interrupts.CPU123.CAL:Function_call_interrupts
     35.25 ± 65%    +509.2%     214.75 ± 44%  interrupts.CPU123.RES:Rescheduling_interrupts
    759087          +309.6%    3109485        interrupts.CPU123.TLB:TLB_shootdowns
    752745          +306.9%    3063155 ±  3%  interrupts.CPU124.CAL:Function_call_interrupts
     22.50 ± 40%    +700.0%     180.00 ± 39%  interrupts.CPU124.RES:Rescheduling_interrupts
    758169          +310.4%    3111332        interrupts.CPU124.TLB:TLB_shootdowns
    753490          +306.3%    3061145 ±  2%  interrupts.CPU125.CAL:Function_call_interrupts
     33.50 ± 12%    +403.0%     168.50 ± 40%  interrupts.CPU125.RES:Rescheduling_interrupts
    759013          +309.5%    3108157        interrupts.CPU125.TLB:TLB_shootdowns
    753699          +306.1%    3060936 ±  2%  interrupts.CPU126.CAL:Function_call_interrupts
     13.50 ±  6%   +1361.1%     197.25 ± 43%  interrupts.CPU126.RES:Rescheduling_interrupts
    758828          +309.2%    3105073        interrupts.CPU126.TLB:TLB_shootdowns
    753119          +306.6%    3062388 ±  2%  interrupts.CPU127.CAL:Function_call_interrupts
     24.00 ± 33%    +883.3%     236.00 ± 48%  interrupts.CPU127.RES:Rescheduling_interrupts
    758103          +310.0%    3108074        interrupts.CPU127.TLB:TLB_shootdowns
    752892          +305.9%    3055985 ±  3%  interrupts.CPU128.CAL:Function_call_interrupts
     27.50 ± 23%    +549.1%     178.50 ± 40%  interrupts.CPU128.RES:Rescheduling_interrupts
    758449          +309.4%    3104976 ±  2%  interrupts.CPU128.TLB:TLB_shootdowns
    751749          +306.9%    3059109 ±  3%  interrupts.CPU129.CAL:Function_call_interrupts
     24.50 ± 33%    +623.5%     177.25 ± 49%  interrupts.CPU129.RES:Rescheduling_interrupts
    757922          +310.5%    3111594        interrupts.CPU129.TLB:TLB_shootdowns
    753498          +308.3%    3076401 ±  2%  interrupts.CPU13.CAL:Function_call_interrupts
    271.25           -31.4%     186.00 ±  7%  interrupts.CPU13.RES:Rescheduling_interrupts
    758149          +310.3%    3110738 ±  2%  interrupts.CPU13.TLB:TLB_shootdowns
    753167          +306.7%    3062979 ±  3%  interrupts.CPU130.CAL:Function_call_interrupts
     19.00 ± 40%    +796.1%     170.25 ± 40%  interrupts.CPU130.RES:Rescheduling_interrupts
    758936          +310.1%    3112772        interrupts.CPU130.TLB:TLB_shootdowns
    752736          +305.9%    3055370 ±  2%  interrupts.CPU131.CAL:Function_call_interrupts
     21.75 ± 42%    +686.2%     171.00 ± 46%  interrupts.CPU131.RES:Rescheduling_interrupts
    758466          +309.3%    3104060        interrupts.CPU131.TLB:TLB_shootdowns
    754347          +305.3%    3057078 ±  2%  interrupts.CPU132.CAL:Function_call_interrupts
     23.50 ± 23%    +772.3%     205.00 ± 44%  interrupts.CPU132.RES:Rescheduling_interrupts
    759390          +308.7%    3103862        interrupts.CPU132.TLB:TLB_shootdowns
    752814          +306.7%    3061381 ±  2%  interrupts.CPU133.CAL:Function_call_interrupts
     21.25 ± 34%    +728.2%     176.00 ± 40%  interrupts.CPU133.RES:Rescheduling_interrupts
    758234          +310.0%    3108979        interrupts.CPU133.TLB:TLB_shootdowns
    753833          +305.1%    3053573 ±  2%  interrupts.CPU134.CAL:Function_call_interrupts
     14.75 ± 25%    +932.2%     152.25 ± 46%  interrupts.CPU134.RES:Rescheduling_interrupts
    759120          +308.5%    3101245        interrupts.CPU134.TLB:TLB_shootdowns
    752059          +305.9%    3052891 ±  3%  interrupts.CPU135.CAL:Function_call_interrupts
     18.25 ± 32%    +715.1%     148.75 ± 46%  interrupts.CPU135.RES:Rescheduling_interrupts
    757923          +309.6%    3104669        interrupts.CPU135.TLB:TLB_shootdowns
    752676          +305.6%    3052924 ±  2%  interrupts.CPU136.CAL:Function_call_interrupts
     38.00 ± 51%    +332.2%     164.25 ± 47%  interrupts.CPU136.RES:Rescheduling_interrupts
    758342          +309.1%    3102369        interrupts.CPU136.TLB:TLB_shootdowns
    753171          +306.8%    3063843 ±  2%  interrupts.CPU137.CAL:Function_call_interrupts
     25.75 ± 50%    +523.3%     160.50 ± 48%  interrupts.CPU137.RES:Rescheduling_interrupts
    758529          +310.2%    3111568        interrupts.CPU137.TLB:TLB_shootdowns
    751015          +306.8%    3055275 ±  2%  interrupts.CPU138.CAL:Function_call_interrupts
     20.50 ± 44%    +729.3%     170.00 ± 41%  interrupts.CPU138.RES:Rescheduling_interrupts
    756223          +310.2%    3102068        interrupts.CPU138.TLB:TLB_shootdowns
    753689          +306.3%    3062333 ±  3%  interrupts.CPU139.CAL:Function_call_interrupts
     19.25 ± 65%    +803.9%     174.00 ± 21%  interrupts.CPU139.RES:Rescheduling_interrupts
    758893          +309.6%    3108255        interrupts.CPU139.TLB:TLB_shootdowns
    752835          +308.6%    3076001 ±  2%  interrupts.CPU14.CAL:Function_call_interrupts
    267.50           -20.9%     211.50 ± 13%  interrupts.CPU14.RES:Rescheduling_interrupts
    757756          +310.5%    3110304 ±  2%  interrupts.CPU14.TLB:TLB_shootdowns
    752669          +304.0%    3040911 ±  3%  interrupts.CPU140.CAL:Function_call_interrupts
     21.00 ± 50%    +592.9%     145.50 ± 58%  interrupts.CPU140.RES:Rescheduling_interrupts
    758371          +307.5%    3090374 ±  2%  interrupts.CPU140.TLB:TLB_shootdowns
    751667          +307.0%    3059445 ±  3%  interrupts.CPU141.CAL:Function_call_interrupts
     17.50 ± 30%    +640.0%     129.50 ± 54%  interrupts.CPU141.RES:Rescheduling_interrupts
    757442          +310.8%    3111205 ±  2%  interrupts.CPU141.TLB:TLB_shootdowns
    750974          +307.3%    3058782 ±  3%  interrupts.CPU142.CAL:Function_call_interrupts
     14.75 ± 40%    +974.6%     158.50 ± 36%  interrupts.CPU142.RES:Rescheduling_interrupts
    756342          +310.9%    3107966        interrupts.CPU142.TLB:TLB_shootdowns
    753415          +305.8%    3057111 ±  2%  interrupts.CPU143.CAL:Function_call_interrupts
     20.25 ± 32%    +948.1%     212.25 ± 58%  interrupts.CPU143.RES:Rescheduling_interrupts
    758620          +309.1%    3103623        interrupts.CPU143.TLB:TLB_shootdowns
    745233          +310.6%    3059907        interrupts.CPU144.CAL:Function_call_interrupts
    751681          +312.4%    3099940 ±  2%  interrupts.CPU144.TLB:TLB_shootdowns
    750015          +308.5%    3063525        interrupts.CPU145.CAL:Function_call_interrupts
    756987          +309.9%    3103209 ±  2%  interrupts.CPU145.TLB:TLB_shootdowns
    749514          +309.2%    3067255        interrupts.CPU146.CAL:Function_call_interrupts
    755935          +311.1%    3107676 ±  2%  interrupts.CPU146.TLB:TLB_shootdowns
    747107          +310.1%    3063820 ±  2%  interrupts.CPU147.CAL:Function_call_interrupts
    753499          +311.8%    3102856 ±  2%  interrupts.CPU147.TLB:TLB_shootdowns
    751505          +308.3%    3068041        interrupts.CPU148.CAL:Function_call_interrupts
    757738          +310.2%    3107960 ±  2%  interrupts.CPU148.TLB:TLB_shootdowns
    752835          +307.1%    3064820        interrupts.CPU149.CAL:Function_call_interrupts
      8738           -37.8%       5436 ± 35%  interrupts.CPU149.NMI:Non-maskable_interrupts
      8738           -37.8%       5436 ± 35%  interrupts.CPU149.PMI:Performance_monitoring_interrupts
    758896          +309.0%    3103522 ±  2%  interrupts.CPU149.TLB:TLB_shootdowns
    753686          +307.4%    3070203 ±  2%  interrupts.CPU15.CAL:Function_call_interrupts
    271.50 ±  3%     -26.2%     200.50 ±  8%  interrupts.CPU15.RES:Rescheduling_interrupts
    758737          +309.3%    3105715        interrupts.CPU15.TLB:TLB_shootdowns
    750460          +308.6%    3066534 ±  2%  interrupts.CPU150.CAL:Function_call_interrupts
    755927          +310.6%    3103871 ±  2%  interrupts.CPU150.TLB:TLB_shootdowns
    753196          +306.5%    3061674        interrupts.CPU151.CAL:Function_call_interrupts
      8740           -37.8%       5434 ± 35%  interrupts.CPU151.NMI:Non-maskable_interrupts
      8740           -37.8%       5434 ± 35%  interrupts.CPU151.PMI:Performance_monitoring_interrupts
    758924          +308.5%    3100139 ±  2%  interrupts.CPU151.TLB:TLB_shootdowns
    752760          +306.6%    3060925        interrupts.CPU152.CAL:Function_call_interrupts
    759459          +308.3%    3100797 ±  2%  interrupts.CPU152.TLB:TLB_shootdowns
    751707          +307.6%    3064092        interrupts.CPU153.CAL:Function_call_interrupts
    758213          +309.3%    3103207 ±  2%  interrupts.CPU153.TLB:TLB_shootdowns
    752968          +306.9%    3063952 ±  2%  interrupts.CPU154.CAL:Function_call_interrupts
    758807          +308.8%    3101812 ±  2%  interrupts.CPU154.TLB:TLB_shootdowns
    751855          +307.2%    3061712 ±  2%  interrupts.CPU155.CAL:Function_call_interrupts
    757422          +309.2%    3099043 ±  2%  interrupts.CPU155.TLB:TLB_shootdowns
    753297          +305.6%    3055250 ±  2%  interrupts.CPU156.CAL:Function_call_interrupts
    758923          +307.5%    3092690 ±  2%  interrupts.CPU156.TLB:TLB_shootdowns
    752018          +307.4%    3063732 ±  2%  interrupts.CPU157.CAL:Function_call_interrupts
    758147          +309.2%    3102085 ±  2%  interrupts.CPU157.TLB:TLB_shootdowns
    750335          +308.4%    3064052        interrupts.CPU158.CAL:Function_call_interrupts
    756987          +310.0%    3103275 ±  2%  interrupts.CPU158.TLB:TLB_shootdowns
    752428          +306.3%    3057164 ±  2%  interrupts.CPU159.CAL:Function_call_interrupts
    758687          +308.1%    3096066 ±  2%  interrupts.CPU159.TLB:TLB_shootdowns
    754647          +307.2%    3073170 ±  2%  interrupts.CPU16.CAL:Function_call_interrupts
    268.00           -15.8%     225.75 ± 11%  interrupts.CPU16.RES:Rescheduling_interrupts
    759882          +309.1%    3108653 ±  2%  interrupts.CPU16.TLB:TLB_shootdowns
    751454          +307.8%    3064431        interrupts.CPU160.CAL:Function_call_interrupts
    757573          +309.5%    3102593 ±  2%  interrupts.CPU160.TLB:TLB_shootdowns
    753288          +306.4%    3061169 ±  2%  interrupts.CPU161.CAL:Function_call_interrupts
    759007          +308.3%    3099248 ±  2%  interrupts.CPU161.TLB:TLB_shootdowns
    753143          +305.4%    3052913 ±  2%  interrupts.CPU162.CAL:Function_call_interrupts
    758931          +307.2%    3090483 ±  2%  interrupts.CPU162.TLB:TLB_shootdowns
    752235          +306.9%    3060567 ±  2%  interrupts.CPU163.CAL:Function_call_interrupts
    757682          +308.8%    3097685 ±  2%  interrupts.CPU163.TLB:TLB_shootdowns
    749521          +307.1%    3051378 ±  2%  interrupts.CPU164.CAL:Function_call_interrupts
    755681          +308.9%    3090087 ±  2%  interrupts.CPU164.TLB:TLB_shootdowns
    751508          +306.4%    3054389 ±  2%  interrupts.CPU165.CAL:Function_call_interrupts
    758159          +308.0%    3093629 ±  2%  interrupts.CPU165.TLB:TLB_shootdowns
    750583          +307.2%    3056541 ±  2%  interrupts.CPU166.CAL:Function_call_interrupts
    756551          +309.0%    3094475 ±  2%  interrupts.CPU166.TLB:TLB_shootdowns
    752837          +306.3%    3058734 ±  2%  interrupts.CPU167.CAL:Function_call_interrupts
    758317          +308.2%    3095770 ±  2%  interrupts.CPU167.TLB:TLB_shootdowns
    747137          +310.3%    3065208 ±  2%  interrupts.CPU168.CAL:Function_call_interrupts
    755081          +309.8%    3094349 ±  2%  interrupts.CPU168.TLB:TLB_shootdowns
    749499          +309.2%    3067236 ±  2%  interrupts.CPU169.CAL:Function_call_interrupts
    756934          +309.2%    3097458 ±  2%  interrupts.CPU169.TLB:TLB_shootdowns
    754995          +307.3%    3075165 ±  2%  interrupts.CPU17.CAL:Function_call_interrupts
    281.75 ±  5%     -34.0%     186.00 ±  7%  interrupts.CPU17.RES:Rescheduling_interrupts
    759532          +309.5%    3110011 ±  2%  interrupts.CPU17.TLB:TLB_shootdowns
    752276          +307.8%    3067995 ±  2%  interrupts.CPU170.CAL:Function_call_interrupts
    758700          +308.4%    3098884 ±  2%  interrupts.CPU170.TLB:TLB_shootdowns
    753022          +308.3%    3074460 ±  2%  interrupts.CPU171.CAL:Function_call_interrupts
    758779          +309.2%    3105168 ±  2%  interrupts.CPU171.TLB:TLB_shootdowns
    751960          +308.4%    3071302 ±  2%  interrupts.CPU172.CAL:Function_call_interrupts
    757808          +309.4%    3102653 ±  2%  interrupts.CPU172.TLB:TLB_shootdowns
    752467          +307.9%    3069162 ±  2%  interrupts.CPU173.CAL:Function_call_interrupts
    758170          +308.8%    3099489 ±  2%  interrupts.CPU173.TLB:TLB_shootdowns
    754274          +307.5%    3073636 ±  2%  interrupts.CPU174.CAL:Function_call_interrupts
    759485          +308.6%    3103461 ±  2%  interrupts.CPU174.TLB:TLB_shootdowns
    753361          +307.3%    3068107 ±  2%  interrupts.CPU175.CAL:Function_call_interrupts
    758661          +308.4%    3098117 ±  2%  interrupts.CPU175.TLB:TLB_shootdowns
    753129          +307.2%    3066381 ±  2%  interrupts.CPU176.CAL:Function_call_interrupts
    759073          +308.1%    3098080 ±  2%  interrupts.CPU176.TLB:TLB_shootdowns
    753415          +307.5%    3069982 ±  2%  interrupts.CPU177.CAL:Function_call_interrupts
    759317          +308.4%    3101390 ±  2%  interrupts.CPU177.TLB:TLB_shootdowns
    752159          +308.5%    3072242 ±  2%  interrupts.CPU178.CAL:Function_call_interrupts
    757730          +309.4%    3101998 ±  2%  interrupts.CPU178.TLB:TLB_shootdowns
    753454          +306.7%    3064061 ±  2%  interrupts.CPU179.CAL:Function_call_interrupts
    758596          +307.8%    3093365 ±  2%  interrupts.CPU179.TLB:TLB_shootdowns
    752948          +307.4%    3067524 ±  2%  interrupts.CPU18.CAL:Function_call_interrupts
    757575          +309.5%    3101913 ±  2%  interrupts.CPU18.TLB:TLB_shootdowns
    750641          +309.0%    3070272 ±  2%  interrupts.CPU180.CAL:Function_call_interrupts
    755270          +310.4%    3099531 ±  2%  interrupts.CPU180.TLB:TLB_shootdowns
    752906          +307.4%    3067360 ±  2%  interrupts.CPU181.CAL:Function_call_interrupts
    758172          +308.6%    3097654 ±  2%  interrupts.CPU181.TLB:TLB_shootdowns
    752346          +307.1%    3063135 ±  2%  interrupts.CPU182.CAL:Function_call_interrupts
    758220          +308.1%    3094251 ±  2%  interrupts.CPU182.TLB:TLB_shootdowns
    752503          +307.3%    3064675 ±  2%  interrupts.CPU183.CAL:Function_call_interrupts
    758339          +308.1%    3094944 ±  2%  interrupts.CPU183.TLB:TLB_shootdowns
    753887          +307.6%    3072813 ±  2%  interrupts.CPU184.CAL:Function_call_interrupts
    759253          +308.6%    3102638 ±  2%  interrupts.CPU184.TLB:TLB_shootdowns
    752875          +307.1%    3064948 ±  2%  interrupts.CPU185.CAL:Function_call_interrupts
    757968          +308.3%    3094956 ±  2%  interrupts.CPU185.TLB:TLB_shootdowns
    753780          +306.5%    3064325 ±  2%  interrupts.CPU186.CAL:Function_call_interrupts
    758745          +307.7%    3093503 ±  2%  interrupts.CPU186.TLB:TLB_shootdowns
    754343          +306.0%    3062581 ±  2%  interrupts.CPU187.CAL:Function_call_interrupts
    759314          +307.1%    3091235 ±  2%  interrupts.CPU187.TLB:TLB_shootdowns
    754292          +306.9%    3069499 ±  2%  interrupts.CPU188.CAL:Function_call_interrupts
    759867          +308.0%    3100060 ±  2%  interrupts.CPU188.TLB:TLB_shootdowns
    753455          +306.6%    3063236 ±  2%  interrupts.CPU189.CAL:Function_call_interrupts
    759179          +307.6%    3094616 ±  2%  interrupts.CPU189.TLB:TLB_shootdowns
    754813          +307.1%    3072761 ±  2%  interrupts.CPU19.CAL:Function_call_interrupts
    267.25           -22.2%     208.00 ±  6%  interrupts.CPU19.RES:Rescheduling_interrupts
    759485          +309.1%    3106932 ±  2%  interrupts.CPU19.TLB:TLB_shootdowns
    752524          +306.0%    3055080 ±  2%  interrupts.CPU190.CAL:Function_call_interrupts
    758157          +306.8%    3084562 ±  2%  interrupts.CPU190.TLB:TLB_shootdowns
    739878 ±  2%    +307.2%    3012543 ±  2%  interrupts.CPU191.CAL:Function_call_interrupts
    744622 ±  2%    +308.4%    3041072 ±  2%  interrupts.CPU191.TLB:TLB_shootdowns
    751285          +309.0%    3073007 ±  2%  interrupts.CPU2.CAL:Function_call_interrupts
    756376          +311.0%    3108450 ±  2%  interrupts.CPU2.TLB:TLB_shootdowns
    753391          +307.3%    3068359 ±  2%  interrupts.CPU20.CAL:Function_call_interrupts
    290.25 ±  3%     -34.3%     190.75 ±  7%  interrupts.CPU20.RES:Rescheduling_interrupts
    758346          +309.2%    3103473 ±  2%  interrupts.CPU20.TLB:TLB_shootdowns
    754901          +305.0%    3057297 ±  3%  interrupts.CPU21.CAL:Function_call_interrupts
    265.75           -24.0%     202.00 ±  9%  interrupts.CPU21.RES:Rescheduling_interrupts
    759573          +307.2%    3092766 ±  2%  interrupts.CPU21.TLB:TLB_shootdowns
    755179          +307.1%    3074230 ±  2%  interrupts.CPU22.CAL:Function_call_interrupts
    759602          +309.3%    3109281 ±  2%  interrupts.CPU22.TLB:TLB_shootdowns
    753962          +306.7%    3066433 ±  2%  interrupts.CPU23.CAL:Function_call_interrupts
    288.25 ± 11%     -32.4%     195.00 ±  3%  interrupts.CPU23.RES:Rescheduling_interrupts
    758488          +308.8%    3100389 ±  2%  interrupts.CPU23.TLB:TLB_shootdowns
    752041          +306.2%    3054686 ±  3%  interrupts.CPU24.CAL:Function_call_interrupts
    758027          +309.1%    3100812 ±  2%  interrupts.CPU24.TLB:TLB_shootdowns
    752000          +306.9%    3059926 ±  3%  interrupts.CPU25.CAL:Function_call_interrupts
    758523          +309.8%    3108095 ±  2%  interrupts.CPU25.TLB:TLB_shootdowns
    752261          +306.9%    3061054 ±  3%  interrupts.CPU26.CAL:Function_call_interrupts
    758711          +309.9%    3110098 ±  2%  interrupts.CPU26.TLB:TLB_shootdowns
    752664          +307.4%    3066729 ±  3%  interrupts.CPU27.CAL:Function_call_interrupts
    279.50 ±  2%     -21.7%     218.75 ± 19%  interrupts.CPU27.RES:Rescheduling_interrupts
    758526          +310.5%    3113818        interrupts.CPU27.TLB:TLB_shootdowns
    753216          +306.0%    3058314 ±  2%  interrupts.CPU28.CAL:Function_call_interrupts
    759118          +309.0%    3104923        interrupts.CPU28.TLB:TLB_shootdowns
    753511          +306.1%    3059873 ±  2%  interrupts.CPU29.CAL:Function_call_interrupts
    759254          +309.1%    3106148        interrupts.CPU29.TLB:TLB_shootdowns
    752180          +309.0%    3076295 ±  2%  interrupts.CPU3.CAL:Function_call_interrupts
    757014          +310.9%    3110725 ±  2%  interrupts.CPU3.TLB:TLB_shootdowns
    753840          +305.6%    3057636 ±  2%  interrupts.CPU30.CAL:Function_call_interrupts
    759383          +308.6%    3102725        interrupts.CPU30.TLB:TLB_shootdowns
    753631          +306.3%    3061688 ±  2%  interrupts.CPU31.CAL:Function_call_interrupts
    759350          +309.1%    3106781 ±  2%  interrupts.CPU31.TLB:TLB_shootdowns
    752520          +306.6%    3059798 ±  2%  interrupts.CPU32.CAL:Function_call_interrupts
    273.75 ±  3%     -20.9%     216.50 ± 17%  interrupts.CPU32.RES:Rescheduling_interrupts
    758478          +309.9%    3109066        interrupts.CPU32.TLB:TLB_shootdowns
    751160          +306.5%    3053344 ±  2%  interrupts.CPU33.CAL:Function_call_interrupts
    757663          +309.8%    3104641        interrupts.CPU33.TLB:TLB_shootdowns
    753619          +306.7%    3065209 ±  3%  interrupts.CPU34.CAL:Function_call_interrupts
    283.50 ±  4%     -28.4%     203.00 ± 17%  interrupts.CPU34.RES:Rescheduling_interrupts
    759085          +310.3%    3114684        interrupts.CPU34.TLB:TLB_shootdowns
    751773          +306.5%    3056320 ±  2%  interrupts.CPU35.CAL:Function_call_interrupts
    281.25 ±  4%     -27.6%     203.50 ± 19%  interrupts.CPU35.RES:Rescheduling_interrupts
    757660          +309.7%    3104078        interrupts.CPU35.TLB:TLB_shootdowns
    754098          +305.2%    3055887 ±  2%  interrupts.CPU36.CAL:Function_call_interrupts
    759508          +308.4%    3101600        interrupts.CPU36.TLB:TLB_shootdowns
    754241          +306.2%    3064001 ±  2%  interrupts.CPU37.CAL:Function_call_interrupts
    274.25 ±  2%     -26.8%     200.75 ± 17%  interrupts.CPU37.RES:Rescheduling_interrupts
    759534          +309.6%    3110725        interrupts.CPU37.TLB:TLB_shootdowns
    752152          +307.3%    3063865 ±  2%  interrupts.CPU38.CAL:Function_call_interrupts
    268.75 ±  3%     -26.5%     197.50 ± 14%  interrupts.CPU38.RES:Rescheduling_interrupts
    757972          +310.5%    3111197        interrupts.CPU38.TLB:TLB_shootdowns
    752345          +306.5%    3058421 ±  3%  interrupts.CPU39.CAL:Function_call_interrupts
    758792          +309.6%    3108187 ±  2%  interrupts.CPU39.TLB:TLB_shootdowns
    754706          +307.5%    3075736 ±  2%  interrupts.CPU4.CAL:Function_call_interrupts
    310.00 ± 12%     -37.6%     193.50 ±  7%  interrupts.CPU4.RES:Rescheduling_interrupts
    759250          +309.7%    3110374 ±  2%  interrupts.CPU4.TLB:TLB_shootdowns
    752914          +304.8%    3047908 ±  2%  interrupts.CPU40.CAL:Function_call_interrupts
    269.50 ±  3%     -24.0%     204.75 ± 19%  interrupts.CPU40.RES:Rescheduling_interrupts
    759343          +307.9%    3097102        interrupts.CPU40.TLB:TLB_shootdowns
    751837          +307.0%    3059872 ±  2%  interrupts.CPU41.CAL:Function_call_interrupts
    269.25 ±  3%     -25.0%     202.00 ± 13%  interrupts.CPU41.RES:Rescheduling_interrupts
    757559          +310.1%    3106595        interrupts.CPU41.TLB:TLB_shootdowns
    752794          +305.8%    3055085 ±  2%  interrupts.CPU42.CAL:Function_call_interrupts
    758606          +308.8%    3100920        interrupts.CPU42.TLB:TLB_shootdowns
    750733          +308.3%    3065535 ±  2%  interrupts.CPU43.CAL:Function_call_interrupts
    756531          +311.3%    3111397        interrupts.CPU43.TLB:TLB_shootdowns
    752233          +306.3%    3056288 ±  2%  interrupts.CPU44.CAL:Function_call_interrupts
    758369          +309.8%    3107450        interrupts.CPU44.TLB:TLB_shootdowns
    752395          +306.7%    3060026 ±  3%  interrupts.CPU45.CAL:Function_call_interrupts
    758599          +310.0%    3110555        interrupts.CPU45.TLB:TLB_shootdowns
    748575          +308.7%    3059187 ±  2%  interrupts.CPU46.CAL:Function_call_interrupts
    269.50           -26.5%     198.00 ± 19%  interrupts.CPU46.RES:Rescheduling_interrupts
    754669          +311.8%    3107442        interrupts.CPU46.TLB:TLB_shootdowns
    751855          +306.7%    3057908 ±  2%  interrupts.CPU47.CAL:Function_call_interrupts
    757356          +309.9%    3104689        interrupts.CPU47.TLB:TLB_shootdowns
    749805          +308.3%    3061084        interrupts.CPU48.CAL:Function_call_interrupts
    756264          +310.1%    3101424 ±  2%  interrupts.CPU48.TLB:TLB_shootdowns
    750718          +308.5%    3066609        interrupts.CPU49.CAL:Function_call_interrupts
    758087          +309.8%    3106363 ±  2%  interrupts.CPU49.TLB:TLB_shootdowns
    754685          +304.5%    3052994        interrupts.CPU5.CAL:Function_call_interrupts
    340.00 ± 30%     -38.7%     208.50 ± 12%  interrupts.CPU5.RES:Rescheduling_interrupts
    759395          +306.6%    3087538        interrupts.CPU5.TLB:TLB_shootdowns
    750255          +308.9%    3067603        interrupts.CPU50.CAL:Function_call_interrupts
    757597          +310.1%    3106952 ±  2%  interrupts.CPU50.TLB:TLB_shootdowns
    751786          +307.3%    3062237        interrupts.CPU51.CAL:Function_call_interrupts
    758719          +308.7%    3100710 ±  2%  interrupts.CPU51.TLB:TLB_shootdowns
    752890          +307.8%    3070028        interrupts.CPU52.CAL:Function_call_interrupts
    759592          +309.4%    3109863 ±  2%  interrupts.CPU52.TLB:TLB_shootdowns
    752265          +307.7%    3066807        interrupts.CPU53.CAL:Function_call_interrupts
    279.50 ±  8%     -30.9%     193.00 ± 19%  interrupts.CPU53.RES:Rescheduling_interrupts
    759046          +309.1%    3105534 ±  2%  interrupts.CPU53.TLB:TLB_shootdowns
    753077          +307.4%    3067801 ±  2%  interrupts.CPU54.CAL:Function_call_interrupts
    279.50 ± 11%     -33.7%     185.25 ± 15%  interrupts.CPU54.RES:Rescheduling_interrupts
    759400          +308.9%    3105331 ±  2%  interrupts.CPU54.TLB:TLB_shootdowns
    750743          +308.0%    3062956        interrupts.CPU55.CAL:Function_call_interrupts
    756996          +309.7%    3101538 ±  2%  interrupts.CPU55.TLB:TLB_shootdowns
    750726          +306.5%    3051396 ±  2%  interrupts.CPU56.CAL:Function_call_interrupts
    758111          +307.8%    3091373 ±  2%  interrupts.CPU56.TLB:TLB_shootdowns
    748740          +308.4%    3058092 ±  2%  interrupts.CPU57.CAL:Function_call_interrupts
    288.25 ± 10%     -29.6%     203.00 ± 25%  interrupts.CPU57.RES:Rescheduling_interrupts
    755829          +309.8%    3097679 ±  2%  interrupts.CPU57.TLB:TLB_shootdowns
    752490          +307.1%    3063387 ±  2%  interrupts.CPU58.CAL:Function_call_interrupts
    252.75 ±  7%     -25.2%     189.00 ± 14%  interrupts.CPU58.RES:Rescheduling_interrupts
    758690          +308.8%    3101764 ±  2%  interrupts.CPU58.TLB:TLB_shootdowns
    753483          +306.3%    3061313 ±  2%  interrupts.CPU59.CAL:Function_call_interrupts
    262.00 ± 13%     -24.0%     199.25 ±  8%  interrupts.CPU59.RES:Rescheduling_interrupts
    759410          +308.0%    3098231 ±  2%  interrupts.CPU59.TLB:TLB_shootdowns
    753975          +308.4%    3079380 ±  2%  interrupts.CPU6.CAL:Function_call_interrupts
    265.00           -19.6%     213.00 ± 14%  interrupts.CPU6.RES:Rescheduling_interrupts
    758531          +310.4%    3113090 ±  2%  interrupts.CPU6.TLB:TLB_shootdowns
    752479          +305.4%    3050203 ±  2%  interrupts.CPU60.CAL:Function_call_interrupts
    758680          +307.0%    3087984 ±  2%  interrupts.CPU60.TLB:TLB_shootdowns
    751171          +308.1%    3065861        interrupts.CPU61.CAL:Function_call_interrupts
    757914          +309.6%    3104606 ±  2%  interrupts.CPU61.TLB:TLB_shootdowns
    752206          +306.8%    3059810        interrupts.CPU62.CAL:Function_call_interrupts
    759411          +308.1%    3099247 ±  2%  interrupts.CPU62.TLB:TLB_shootdowns
    752121          +306.0%    3053599 ±  2%  interrupts.CPU63.CAL:Function_call_interrupts
    758916          +307.5%    3092646 ±  2%  interrupts.CPU63.TLB:TLB_shootdowns
    751860          +306.3%    3054887 ±  2%  interrupts.CPU64.CAL:Function_call_interrupts
    127.25 ±  6%     +48.7%     189.25 ± 13%  interrupts.CPU64.RES:Rescheduling_interrupts
    758394          +307.9%    3093144 ±  2%  interrupts.CPU64.TLB:TLB_shootdowns
    751992          +305.8%    3051929 ±  2%  interrupts.CPU65.CAL:Function_call_interrupts
    102.00 ± 12%     +85.3%     189.00 ± 13%  interrupts.CPU65.RES:Rescheduling_interrupts
    758283          +307.5%    3090150 ±  2%  interrupts.CPU65.TLB:TLB_shootdowns
    752643          +306.2%    3057459 ±  2%  interrupts.CPU66.CAL:Function_call_interrupts
     78.00 ± 11%    +145.8%     191.75 ± 17%  interrupts.CPU66.RES:Rescheduling_interrupts
    759024          +307.8%    3095256 ±  2%  interrupts.CPU66.TLB:TLB_shootdowns
    753202          +306.2%    3059257 ±  2%  interrupts.CPU67.CAL:Function_call_interrupts
     64.75 ± 32%    +188.0%     186.50 ± 16%  interrupts.CPU67.RES:Rescheduling_interrupts
    759297          +307.8%    3096609 ±  2%  interrupts.CPU67.TLB:TLB_shootdowns
    752520          +305.9%    3054270 ±  2%  interrupts.CPU68.CAL:Function_call_interrupts
     49.50 ± 21%    +277.3%     186.75 ± 15%  interrupts.CPU68.RES:Rescheduling_interrupts
    759493          +307.3%    3093761 ±  2%  interrupts.CPU68.TLB:TLB_shootdowns
    750619          +305.4%    3043097 ±  2%  interrupts.CPU69.CAL:Function_call_interrupts
     36.00 ± 15%    +479.2%     208.50 ± 11%  interrupts.CPU69.RES:Rescheduling_interrupts
    757643          +306.9%    3082613 ±  3%  interrupts.CPU69.TLB:TLB_shootdowns
    754413          +307.1%    3070844 ±  2%  interrupts.CPU7.CAL:Function_call_interrupts
    270.25 ±  2%     -23.3%     207.25 ± 12%  interrupts.CPU7.RES:Rescheduling_interrupts
    758915          +309.1%    3104757 ±  2%  interrupts.CPU7.TLB:TLB_shootdowns
    751371          +306.7%    3055825 ±  2%  interrupts.CPU70.CAL:Function_call_interrupts
     31.50 ± 12%    +496.8%     188.00 ± 12%  interrupts.CPU70.RES:Rescheduling_interrupts
    759182          +307.5%    3093379 ±  2%  interrupts.CPU70.TLB:TLB_shootdowns
    752263          +306.4%    3057335 ±  2%  interrupts.CPU71.CAL:Function_call_interrupts
     34.75 ± 49%    +659.7%     264.00 ± 41%  interrupts.CPU71.RES:Rescheduling_interrupts
    758497          +308.0%    3094928 ±  2%  interrupts.CPU71.TLB:TLB_shootdowns
    751582          +308.3%    3068543 ±  2%  interrupts.CPU72.CAL:Function_call_interrupts
     50.75 ± 36%    +330.5%     218.50 ± 13%  interrupts.CPU72.RES:Rescheduling_interrupts
    758084          +308.7%    3098133 ±  2%  interrupts.CPU72.TLB:TLB_shootdowns
    750199          +310.2%    3077562 ±  2%  interrupts.CPU73.CAL:Function_call_interrupts
     42.25 ± 23%    +504.1%     255.25 ± 22%  interrupts.CPU73.RES:Rescheduling_interrupts
    757581          +310.3%    3108527 ±  2%  interrupts.CPU73.TLB:TLB_shootdowns
    751987          +308.4%    3070948 ±  2%  interrupts.CPU74.CAL:Function_call_interrupts
     31.50 ± 23%    +540.5%     201.75 ± 11%  interrupts.CPU74.RES:Rescheduling_interrupts
    758780          +308.9%    3102978 ±  2%  interrupts.CPU74.TLB:TLB_shootdowns
    752596          +309.2%    3079484 ±  2%  interrupts.CPU75.CAL:Function_call_interrupts
     22.75 ±  9%    +978.0%     245.25 ± 36%  interrupts.CPU75.RES:Rescheduling_interrupts
    758870          +309.9%    3110787 ±  2%  interrupts.CPU75.TLB:TLB_shootdowns
    753292          +308.2%    3075219 ±  2%  interrupts.CPU76.CAL:Function_call_interrupts
     17.75 ± 30%   +1042.3%     202.75 ±  9%  interrupts.CPU76.RES:Rescheduling_interrupts
    759824          +309.0%    3107470 ±  2%  interrupts.CPU76.TLB:TLB_shootdowns
    751906          +309.5%    3078741 ±  2%  interrupts.CPU77.CAL:Function_call_interrupts
     29.25 ± 62%    +635.0%     215.00 ± 20%  interrupts.CPU77.RES:Rescheduling_interrupts
    758279          +310.1%    3109866 ±  2%  interrupts.CPU77.TLB:TLB_shootdowns
    753211          +308.1%    3074009 ±  2%  interrupts.CPU78.CAL:Function_call_interrupts
     23.00 ± 29%    +776.1%     201.50 ± 12%  interrupts.CPU78.RES:Rescheduling_interrupts
    758769          +309.1%    3103775 ±  2%  interrupts.CPU78.TLB:TLB_shootdowns
    752518          +308.9%    3077000 ±  2%  interrupts.CPU79.CAL:Function_call_interrupts
     20.50 ± 36%    +808.5%     186.25 ±  8%  interrupts.CPU79.RES:Rescheduling_interrupts
    758332          +309.9%    3108069 ±  2%  interrupts.CPU79.TLB:TLB_shootdowns
    754596          +307.6%    3075616 ±  2%  interrupts.CPU8.CAL:Function_call_interrupts
    283.50 ± 12%     -28.8%     201.75 ± 14%  interrupts.CPU8.RES:Rescheduling_interrupts
    759292          +309.7%    3110508 ±  2%  interrupts.CPU8.TLB:TLB_shootdowns
    752145          +308.8%    3074415 ±  2%  interrupts.CPU80.CAL:Function_call_interrupts
     22.75 ± 44%    +807.7%     206.50 ± 12%  interrupts.CPU80.RES:Rescheduling_interrupts
    758777          +309.6%    3108276 ±  2%  interrupts.CPU80.TLB:TLB_shootdowns
    751888          +308.8%    3073677 ±  2%  interrupts.CPU81.CAL:Function_call_interrupts
     23.50 ± 29%    +762.8%     202.75 ± 12%  interrupts.CPU81.RES:Rescheduling_interrupts
    758069          +309.7%    3105865 ±  2%  interrupts.CPU81.TLB:TLB_shootdowns
    753617          +308.2%    3076182 ±  2%  interrupts.CPU82.CAL:Function_call_interrupts
     18.50 ± 23%   +1159.5%     233.00 ± 30%  interrupts.CPU82.RES:Rescheduling_interrupts
    759489          +309.0%    3106690 ±  2%  interrupts.CPU82.TLB:TLB_shootdowns
    753737          +307.6%    3072126 ±  2%  interrupts.CPU83.CAL:Function_call_interrupts
     23.50 ± 34%    +807.4%     213.25 ± 21%  interrupts.CPU83.RES:Rescheduling_interrupts
    759409          +308.5%    3101951 ±  2%  interrupts.CPU83.TLB:TLB_shootdowns
    753512          +307.8%    3072664 ±  2%  interrupts.CPU84.CAL:Function_call_interrupts
     37.75 ± 51%    +532.5%     238.75 ± 31%  interrupts.CPU84.RES:Rescheduling_interrupts
    759097          +308.8%    3102843 ±  2%  interrupts.CPU84.TLB:TLB_shootdowns
    752958          +308.0%    3072095 ±  2%  interrupts.CPU85.CAL:Function_call_interrupts
     26.00 ± 56%    +626.0%     188.75 ± 11%  interrupts.CPU85.RES:Rescheduling_interrupts
    758873          +309.0%    3103458 ±  2%  interrupts.CPU85.TLB:TLB_shootdowns
    753069          +308.1%    3073200 ±  2%  interrupts.CPU86.CAL:Function_call_interrupts
     21.00 ± 36%    +932.1%     216.75 ± 26%  interrupts.CPU86.RES:Rescheduling_interrupts
    759366          +308.9%    3105351 ±  2%  interrupts.CPU86.TLB:TLB_shootdowns
    753062          +307.9%    3071639 ±  2%  interrupts.CPU87.CAL:Function_call_interrupts
     18.25 ± 29%   +1104.1%     219.75 ± 17%  interrupts.CPU87.RES:Rescheduling_interrupts
    759169          +308.8%    3103245 ±  2%  interrupts.CPU87.TLB:TLB_shootdowns
    753816          +307.9%    3074460 ±  2%  interrupts.CPU88.CAL:Function_call_interrupts
     27.75 ± 77%    +635.1%     204.00 ± 17%  interrupts.CPU88.RES:Rescheduling_interrupts
    759612          +308.8%    3105390 ±  2%  interrupts.CPU88.TLB:TLB_shootdowns
    753959          +306.3%    3063198 ±  2%  interrupts.CPU89.CAL:Function_call_interrupts
     28.00 ± 14%    +672.3%     216.25 ± 16%  interrupts.CPU89.RES:Rescheduling_interrupts
    759834          +307.2%    3094225 ±  2%  interrupts.CPU89.TLB:TLB_shootdowns
    754244          +307.4%    3073104 ±  2%  interrupts.CPU9.CAL:Function_call_interrupts
    286.25 ± 12%     -34.1%     188.50 ±  7%  interrupts.CPU9.RES:Rescheduling_interrupts
    759348          +309.4%    3108829 ±  2%  interrupts.CPU9.TLB:TLB_shootdowns
    752953          +307.5%    3068385 ±  2%  interrupts.CPU90.CAL:Function_call_interrupts
     40.75 ± 52%    +375.5%     193.75 ± 13%  interrupts.CPU90.RES:Rescheduling_interrupts
    758606          +308.5%    3099039 ±  2%  interrupts.CPU90.TLB:TLB_shootdowns
    754310          +305.5%    3058660 ±  2%  interrupts.CPU91.CAL:Function_call_interrupts
     20.75 ± 24%   +1007.2%     229.75 ± 13%  interrupts.CPU91.RES:Rescheduling_interrupts
    759826          +306.5%    3088597 ±  2%  interrupts.CPU91.TLB:TLB_shootdowns
    753838          +307.5%    3071893 ±  2%  interrupts.CPU92.CAL:Function_call_interrupts
     46.25 ± 31%    +347.6%     207.00 ±  8%  interrupts.CPU92.RES:Rescheduling_interrupts
    759833          +308.6%    3104306 ±  2%  interrupts.CPU92.TLB:TLB_shootdowns
    751448          +307.7%    3063481 ±  2%  interrupts.CPU93.CAL:Function_call_interrupts
     29.25 ± 56%    +556.4%     192.00 ±  7%  interrupts.CPU93.RES:Rescheduling_interrupts
    757697          +308.6%    3096181 ±  2%  interrupts.CPU93.TLB:TLB_shootdowns
    752049          +307.4%    3063682 ±  2%  interrupts.CPU94.CAL:Function_call_interrupts
     19.25 ± 20%   +1009.1%     213.50 ± 16%  interrupts.CPU94.RES:Rescheduling_interrupts
    757968          +308.3%    3094685 ±  2%  interrupts.CPU94.TLB:TLB_shootdowns
    753951          +306.8%    3067319 ±  2%  interrupts.CPU95.CAL:Function_call_interrupts
     31.75 ± 34%    +538.6%     202.75 ± 12%  interrupts.CPU95.RES:Rescheduling_interrupts
    759690          +307.8%    3097901 ±  2%  interrupts.CPU95.TLB:TLB_shootdowns
    748911          +309.5%    3067042 ±  2%  interrupts.CPU96.CAL:Function_call_interrupts
     73.00 ± 41%    +415.1%     376.00 ± 74%  interrupts.CPU96.RES:Rescheduling_interrupts
    754244          +311.6%    3104534 ±  2%  interrupts.CPU96.TLB:TLB_shootdowns
    750319          +308.6%    3065682 ±  2%  interrupts.CPU97.CAL:Function_call_interrupts
     48.25 ± 20%    +505.7%     292.25 ± 57%  interrupts.CPU97.RES:Rescheduling_interrupts
    756037          +310.4%    3102468 ±  2%  interrupts.CPU97.TLB:TLB_shootdowns
    752889          +308.2%    3073053 ±  2%  interrupts.CPU98.CAL:Function_call_interrupts
     36.75 ± 35%    +782.3%     324.25 ± 62%  interrupts.CPU98.RES:Rescheduling_interrupts
    758457          +310.1%    3110632 ±  2%  interrupts.CPU98.TLB:TLB_shootdowns
    753699          +307.3%    3069746 ±  2%  interrupts.CPU99.CAL:Function_call_interrupts
     26.25 ± 29%   +1005.7%     290.25 ± 48%  interrupts.CPU99.RES:Rescheduling_interrupts
    758464          +309.5%    3106219 ±  2%  interrupts.CPU99.TLB:TLB_shootdowns
     22042 ±  2%     +59.9%      35255 ± 12%  interrupts.RES:Rescheduling_interrupts
 1.456e+08          +309.2%  5.957e+08 ±  2%  interrupts.TLB:TLB_shootdowns


                                                                                
                           vm-scalability.time.user_time                        
                                                                                
  3000 +--------------------------------------------------------------------+   
       |                                                                    |   
  2500 |-+                                                           O O    |   
       |                                                                  O |   
       |                                                                    |   
  2000 |-+                                                                  |   
       |                                                                    |   
  1500 |-+                                                                  |   
       |                                                                    |   
  1000 |-O    O    O O O O      O  O   O  O O O O                           |   
       |    O   O           O O      O             O O O  O O O  O O        |   
       |                                                                    |   
   500 |.+..+.+.+..+.+.+.+..+.+.+..+.+.+..+.+.+.+                           |   
       |                                                                    |   
     0 +--------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                           vm-scalability.time.system_time                      
                                                                                
  55000 +-------------------------------------------------------------------+   
        |                                                                   |   
  54500 |.+.. .+.+.+..+.+.+.+..+.+.+.+..+. .+..+.+                          |   
        |    +                            +                                 |   
  54000 |-+                                                                 |   
        |                                                                   |   
  53500 |-+  O O O    O   O O  O     O    O O      O O  O O O O  O O        |   
        | O        O    O        O O    O      O O                          |   
  53000 |-+                                                                 |   
        |                                                                   |   
  52500 |-+                                                                 |   
        |                                                                   |   
  52000 |-+                                                          O      |   
        |                                                                 O |   
  51500 +-------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                   vm-scalability.time.percent_of_cpu_this_job_got              
                                                                                
  18300 +-------------------------------------------------------------------+   
        |      +.                                                           |   
  18250 |-+   +  +.+..   .+.+..   .+.  .+       .+                          |   
  18200 |.+..+         .+      +.+   +.  + .+..+                            |   
        |             +                   +                                 |   
  18150 |-+                                                                 |   
  18100 |-+                                                                 |   
        |                                                                   |   
  18050 |-+           O                            O        O               |   
  18000 |-O  O     O      O          O    O O        O  O O   O  O O O      |   
        |      O O      O   O  O O O           O O                          |   
  17950 |-+                             O                                   |   
  17900 |-+                                                            O    |   
        |                                                                 O |   
  17850 +-------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                               vm-scalability.throughput                        
                                                                                
  1.3e+07 +-----------------------------------------------------------------+   
          |                                                                 |   
  1.2e+07 |-+                                                        O  O   |   
  1.1e+07 |-O O  O O O O O  O O O O O  O O O O O  O                       O |   
          |                                         O O O O  O O O O        |   
    1e+07 |-+                                                               |   
          |                                                                 |   
    9e+06 |-+                                                               |   
          |                                                                 |   
    8e+06 |-+                                                               |   
    7e+06 |-+                                                               |   
          |                                                                 |   
    6e+06 |-+                .+.+.                                          |   
          |.+.+..+.+.+.+.+..+     +.+..+.+.+.+.+..+                         |   
    5e+06 +-----------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                                vm-scalability.median                           
                                                                                
  65000 +-------------------------------------------------------------------+   
        |                                                            O O    |   
  60000 |-O    O   O    O O      O O    O O O  O                          O |   
        |    O   O    O     O  O     O           O O O    O O O    O        |   
  55000 |-+                                             O        O          |   
        |                                                                   |   
  50000 |-+                                                                 |   
        |                                                                   |   
  45000 |-+                                                                 |   
        |                                                                   |   
  40000 |-+                                                                 |   
        |                                                                   |   
  35000 |-+                                                                 |   
        |                                                                   |   
  30000 +-------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                                vm-scalability.workload                         
                                                                                
  3.8e+09 +-----------------------------------------------------------------+   
  3.6e+09 |-+                                                        O      |   
          | O        O   O  O     O O      O O O                        O O |   
  3.4e+09 |-+ O  O O   O      O O      O O        O   O   O    O   O        |   
  3.2e+09 |-+                                       O   O    O   O          |   
    3e+09 |-+                                                               |   
  2.8e+09 |-+                                                               |   
          |                                                                 |   
  2.6e+09 |-+                                                               |   
  2.4e+09 |-+                                                               |   
  2.2e+09 |-+                                                               |   
    2e+09 |-+                                                               |   
          |                                                                 |   
  1.8e+09 |.+.+..+.+.+.+.+..+.+.+.+.+..+.+.+.+.+..+                         |   
  1.6e+09 +-----------------------------------------------------------------+   
                                                                                
                                                                                
[*] bisect-good sample
[O] bisect-bad  sample

***************************************************************************************************
lkp-csl-2ap2: 192 threads Intel(R) Xeon(R) Platinum 9242 CPU @ 2.30GHz with 192G memory
=========================================================================================
compiler/cpufreq_governor/disk/filesize/fs/iterations/kconfig/nr_threads/rootfs/sync_method/tbox_group/test_size/testcase/ucode:
  gcc-9/performance/1BRD_48G/4M/xfs/1x/x86_64-rhel-8.3/64t/debian-10.4-x86_64-20200603.cgz/fsyncBeforeClose/lkp-csl-2ap2/40G/fsmark/0x5003003

commit: 
  268df4df6c ("locking/qspinlock: Refactor the qspinlock slow path")
  0dd6d5b8c0 ("locking/qspinlock: Introduce CNA into the slow path of qspinlock")

268df4df6cb0a27d 0dd6d5b8c0f6f31d8d557485fff 
---------------- --------------------------- 
       fail:runs  %reproduction    fail:runs
           |             |             |    
           :4          100%           4:4     kmsg.XFS(ram#):xlog_verify_grant_tail:space>BBTOB(tail_blocks)
           :4            4%           0:4     perf-profile.children.cycles-pp.error_entry
           :4            2%           0:4     perf-profile.self.cycles-pp.error_entry
         %stddev     %change         %stddev
             \          |                \  
    518664           +10.2%     571693        fsmark.app_overhead
      1574 ±  2%     +77.8%       2798 ±  4%  fsmark.files_per_sec
      5443            -7.6%       5027 ±  3%  fsmark.time.involuntary_context_switches
      4357           -27.3%       3167        fsmark.time.percent_of_cpu_this_job_got
    410.92 ±  2%     -43.4%     232.70 ±  5%  fsmark.time.system_time
     35987 ±  2%     +39.5%      50189 ± 11%  fsmark.time.voluntary_context_switches
      4734 ±  7%     +12.2%       5311 ±  4%  boot-time.idle
    195260 ± 99%     -86.0%      27363 ± 23%  cpuidle.C1.usage
    277209 ±  2%      -9.5%     250829        softirqs.RCU
     81.27            +6.7%      86.73        iostat.cpu.idle
     18.23           -29.9%      12.77 ±  4%  iostat.cpu.system
      0.10 ± 10%      +0.0        0.12 ±  4%  mpstat.cpu.all.soft%
     19.00 ±  2%      -5.0       13.98 ±  5%  mpstat.cpu.all.sys%
   3597038 ± 22%     +94.9%    7012262 ± 45%  numa-numastat.node0.local_node
   3623487 ± 22%     +94.2%    7035554 ± 44%  numa-numastat.node0.numa_hit
   5899712 ± 21%     -36.4%    3752782 ± 18%  numa-numastat.node1.local_node
   5915389 ± 21%     -36.1%    3780893 ± 18%  numa-numastat.node1.numa_hit
     80.75            +7.1%      86.50        vmstat.cpu.id
   3126423 ±  3%     +22.5%    3830617        vmstat.io.bo
     32.75 ±  7%     -21.4%      25.75 ±  3%  vmstat.procs.r
     12621 ±  3%     +32.2%      16685 ±  6%  vmstat.system.cs
    405279           -10.2%     363752        vmstat.system.in
      1.33 ±173%    +400.5%       6.67 ± 48%  sched_debug.cfs_rq:/.removed.load_avg.avg
     18.41 ±173%    +295.7%      72.85 ± 36%  sched_debug.cfs_rq:/.removed.load_avg.stddev
      0.73 ±173%    +280.8%       2.77 ± 65%  sched_debug.cfs_rq:/.removed.runnable_avg.avg
      0.73 ±173%    +280.8%       2.77 ± 65%  sched_debug.cfs_rq:/.removed.util_avg.avg
      9478 ±  9%     +45.7%      13814 ± 14%  sched_debug.cpu.nr_switches.max
    995.98 ±  3%     +16.2%       1157 ±  7%  sched_debug.cpu.nr_switches.stddev
      6714 ± 16%     -66.8%       2232        meminfo.Active
      6714 ± 16%     -66.8%       2232        meminfo.Active(anon)
      7221 ± 22%    +108.5%      15057 ±  9%  meminfo.Dirty
     61384 ±  4%     -44.2%      34225        meminfo.Mapped
     40112 ±  6%     -66.9%      13278        meminfo.Shmem
    119453 ±  3%     -34.2%      78653 ± 11%  meminfo.Writeback
   6775460 ±  2%     +25.8%    8526489 ±  2%  meminfo.max_used_kB
      1683 ± 16%     -66.9%     558.00        proc-vmstat.nr_active_anon
      1539 ± 11%    +152.8%       3890 ± 19%  proc-vmstat.nr_dirty
     15487 ±  4%     -43.9%       8689        proc-vmstat.nr_mapped
     10044 ±  6%     -66.9%       3319        proc-vmstat.nr_shmem
     29495 ±  3%     -32.5%      19921 ±  7%  proc-vmstat.nr_writeback
      1683 ± 16%     -66.9%     558.00        proc-vmstat.nr_zone_active_anon
     30332 ±  3%     -30.8%      20986 ±  5%  proc-vmstat.nr_zone_write_pending
    173859 ±  2%     -14.6%     148528 ±  3%  proc-vmstat.pgfault
      6886           -10.7%       6152        proc-vmstat.pgreuse
     11571           -10.8%      10320        slabinfo.Acpi-Parse.active_objs
     11571           -10.8%      10320        slabinfo.Acpi-Parse.num_objs
      1280           -10.4%       1148        slabinfo.biovec-max.active_objs
      1280           -10.4%       1148        slabinfo.biovec-max.num_objs
      6867           -10.9%       6117        slabinfo.ip6-frags.active_objs
      6867           -10.9%       6117        slabinfo.ip6-frags.num_objs
      9725           -11.3%       8624 ±  2%  slabinfo.numa_policy.active_objs
      9725           -11.3%       8624 ±  2%  slabinfo.numa_policy.num_objs
      7963 ±  2%     +13.4%       9034 ±  2%  slabinfo.shmem_inode_cache.active_objs
      7963 ±  2%     +13.4%       9034 ±  2%  slabinfo.shmem_inode_cache.num_objs
      5596           -10.7%       4998        slabinfo.xfs_btree_cur.active_objs
      5596           -10.7%       4998        slabinfo.xfs_btree_cur.num_objs
      5719           -12.4%       5009 ±  2%  slabinfo.xfs_efd_item.active_objs
      5719           -12.4%       5009 ±  2%  slabinfo.xfs_efd_item.num_objs
      5881           -12.3%       5157 ±  2%  slabinfo.xfs_efi_item.active_objs
      5881           -12.3%       5157 ±  2%  slabinfo.xfs_efi_item.num_objs
      1813 ± 11%     +82.6%       3310 ±  8%  slabinfo.xfs_icr.active_objs
      1813 ± 11%     +82.6%       3310 ±  8%  slabinfo.xfs_icr.num_objs
      1623 ± 55%    +192.1%       4740 ± 13%  numa-meminfo.node0.Dirty
   2553025 ± 23%    +118.7%    5582711 ± 47%  numa-meminfo.node0.Inactive
     43707 ± 20%     +94.6%      85034 ± 34%  numa-meminfo.node0.KReclaimable
   7164576 ± 22%    +114.5%   15371546 ± 47%  numa-meminfo.node0.MemUsed
    870.50 ± 26%    +889.9%       8616 ±123%  numa-meminfo.node0.PageTables
     43707 ± 20%     +94.6%      85034 ± 34%  numa-meminfo.node0.SReclaimable
     71035 ±  6%     +33.8%      95050 ± 13%  numa-meminfo.node0.SUnreclaim
    114742 ± 11%     +56.9%     180085 ± 16%  numa-meminfo.node0.Slab
    246152            +7.4%     264307 ±  6%  numa-meminfo.node0.Unevictable
      1067 ± 64%     -90.4%     102.75 ± 92%  numa-meminfo.node1.Active
      1067 ± 64%     -90.4%     102.75 ± 92%  numa-meminfo.node1.Active(anon)
      2044 ± 47%     +82.5%       3732 ± 17%  numa-meminfo.node1.Dirty
   4633832 ± 25%     -37.7%    2886923 ± 22%  numa-meminfo.node1.FilePages
   4497254 ± 27%     -40.0%    2698604 ± 23%  numa-meminfo.node1.Inactive
   4369637 ± 27%     -39.7%    2633672 ± 24%  numa-meminfo.node1.Inactive(file)
     66064 ± 20%     -41.3%      38758 ± 11%  numa-meminfo.node1.KReclaimable
     16364 ± 18%     -38.8%      10009 ± 26%  numa-meminfo.node1.Mapped
  37273065 ±  8%     +12.8%   42061703 ±  3%  numa-meminfo.node1.MemFree
  12261389 ± 26%     -39.1%    7472752 ± 19%  numa-meminfo.node1.MemUsed
     66064 ± 20%     -41.3%      38758 ± 11%  numa-meminfo.node1.SReclaimable
     74187 ±  5%     -19.0%      60087 ± 10%  numa-meminfo.node1.SUnreclaim
    140252 ± 11%     -29.5%      98845 ± 10%  numa-meminfo.node1.Slab
     32642 ± 19%     -55.8%      14433 ± 15%  numa-meminfo.node1.Writeback
     15763 ± 10%     -53.7%       7294 ±  3%  numa-meminfo.node2.Mapped
      4749 ± 27%     -82.0%     856.75 ± 81%  numa-meminfo.node3.Active
      4749 ± 27%     -82.0%     856.75 ± 81%  numa-meminfo.node3.Active(anon)
      1380 ± 39%    +146.1%       3397 ± 26%  numa-meminfo.node3.Dirty
     15088 ±  9%     -51.1%       7378 ±  3%  numa-meminfo.node3.Mapped
     28668 ± 11%     -93.9%       1758 ± 18%  numa-meminfo.node3.Shmem
     39007 ± 23%     -48.9%      19942 ± 63%  numa-meminfo.node3.Writeback
   1001774 ± 25%    +126.0%    2264428 ± 52%  numa-vmstat.node0.nr_dirtied
    460.75 ± 52%    +195.0%       1359 ± 45%  numa-vmstat.node0.nr_dirty
    217.25 ± 26%    +891.1%       2153 ±123%  numa-vmstat.node0.nr_page_table_pages
     10930 ± 20%     +94.6%      21268 ± 34%  numa-vmstat.node0.nr_slab_reclaimable
     17761 ±  6%     +33.8%      23759 ± 13%  numa-vmstat.node0.nr_slab_unreclaimable
     61537            +7.4%      66076 ±  6%  numa-vmstat.node0.nr_unevictable
    996271 ± 25%    +126.6%    2257562 ± 52%  numa-vmstat.node0.nr_written
     61537            +7.4%      66076 ±  6%  numa-vmstat.node0.nr_zone_unevictable
   2366710 ± 21%    +114.3%    5071672 ± 45%  numa-vmstat.node0.numa_hit
   2307883 ± 23%    +117.5%    5020741 ± 46%  numa-vmstat.node0.numa_local
    266.25 ± 64%     -90.5%      25.25 ± 92%  numa-vmstat.node1.nr_active_anon
   1783849 ± 27%     -40.8%    1056135 ± 19%  numa-vmstat.node1.nr_dirtied
   1153649 ± 25%     -37.5%     720737 ± 22%  numa-vmstat.node1.nr_file_pages
   9318632 ±  8%     +12.8%   10511534 ±  3%  numa-vmstat.node1.nr_free_pages
   1087603 ± 27%     -39.6%     657428 ± 25%  numa-vmstat.node1.nr_inactive_file
      4199 ± 18%     -40.0%       2519 ± 26%  numa-vmstat.node1.nr_mapped
     16531 ± 20%     -41.3%       9704 ± 11%  numa-vmstat.node1.nr_slab_reclaimable
     18548 ±  5%     -19.0%      15022 ± 10%  numa-vmstat.node1.nr_slab_unreclaimable
      7925 ±  7%     -50.7%       3910 ±  8%  numa-vmstat.node1.nr_writeback
   1775578 ± 27%     -40.7%    1052211 ± 19%  numa-vmstat.node1.nr_written
    266.25 ± 64%     -90.5%      25.25 ± 92%  numa-vmstat.node1.nr_zone_active_anon
   1087613 ± 27%     -39.6%     657434 ± 25%  numa-vmstat.node1.nr_zone_inactive_file
      8251 ± 10%     -51.1%       4037 ±  5%  numa-vmstat.node1.nr_zone_write_pending
   4077762 ± 24%     -39.1%    2483342 ± 16%  numa-vmstat.node1.numa_hit
   3980529 ± 25%     -40.2%    2379298 ± 17%  numa-vmstat.node1.numa_local
    380.00 ± 26%    +138.8%     907.50 ± 42%  numa-vmstat.node2.nr_dirty
      4023 ±  8%     -53.7%       1861 ±  6%  numa-vmstat.node2.nr_mapped
      1196 ± 28%     -82.1%     214.50 ± 81%  numa-vmstat.node3.nr_active_anon
      3907 ± 11%     -51.8%       1883 ±  6%  numa-vmstat.node3.nr_mapped
      7432 ± 13%     -94.1%     440.00 ± 18%  numa-vmstat.node3.nr_shmem
      9672 ± 26%     -51.4%       4704 ± 57%  numa-vmstat.node3.nr_writeback
      1196 ± 28%     -82.1%     214.50 ± 81%  numa-vmstat.node3.nr_zone_active_anon
     10025 ± 26%     -47.4%       5270 ± 54%  numa-vmstat.node3.nr_zone_write_pending
 5.502e+09 ±  3%      -8.2%  5.051e+09        perf-stat.i.branch-instructions
     48.31 ±  8%      -6.7       41.58        perf-stat.i.cache-miss-rate%
  1.15e+08 ±  5%     +15.3%  1.325e+08 ±  3%  perf-stat.i.cache-misses
 2.032e+08 ±  3%     +29.6%  2.634e+08 ±  3%  perf-stat.i.cache-references
     14138 ±  4%     +41.8%      20045 ±  6%  perf-stat.i.context-switches
      4.51 ±  3%     -25.0%       3.38 ±  6%  perf-stat.i.cpi
 1.386e+11 ±  4%     -23.5%  1.061e+11 ±  4%  perf-stat.i.cpu-cycles
    483.74 ±  5%     +40.1%     677.50 ±  9%  perf-stat.i.cpu-migrations
      1269 ±  2%     -21.1%       1001 ±  2%  perf-stat.i.cycles-between-cache-misses
 2.042e+09 ±  4%     +22.3%  2.498e+09 ±  2%  perf-stat.i.dTLB-stores
   6869002 ±  3%     +16.9%    8030139        perf-stat.i.iTLB-load-misses
   3976982 ±  5%     +10.0%    4374570        perf-stat.i.iTLB-loads
      3693           -18.3%       3016        perf-stat.i.instructions-per-iTLB-miss
      0.36 ±  8%     +24.4%       0.45 ±  7%  perf-stat.i.ipc
     19.24 ±  8%     -41.2%      11.31 ± 16%  perf-stat.i.major-faults
      0.72 ±  4%     -24.0%       0.55 ±  5%  perf-stat.i.metric.GHz
     15448 ±  3%     +12.0%      17296 ±  3%  perf-stat.i.minor-faults
   7798626 ±  5%     -23.6%    5957941 ±  2%  perf-stat.i.node-load-misses
  32866391 ±  7%     +37.9%   45318230 ±  3%  perf-stat.i.node-loads
     46.13 ±  7%      -9.8       36.37 ± 12%  perf-stat.i.node-store-miss-rate%
   4997908 ±  4%     -50.5%    2472590 ±  4%  perf-stat.i.node-store-misses
  10354939 ±  9%     +56.6%   16219241 ±  3%  perf-stat.i.node-stores
     15467 ±  3%     +11.9%      17308 ±  3%  perf-stat.i.page-faults
      7.86 ±  3%     +36.9%      10.76        perf-stat.overall.MPKI
     56.95 ±  5%      -6.4       50.58        perf-stat.overall.cache-miss-rate%
      5.39           -19.6%       4.33 ±  4%  perf-stat.overall.cpi
      1206           -34.1%     795.86 ±  4%  perf-stat.overall.cycles-between-cache-misses
      0.01 ± 21%      -0.0        0.01 ± 17%  perf-stat.overall.dTLB-store-miss-rate%
     63.45            +1.9       65.30        perf-stat.overall.iTLB-load-miss-rate%
      3771           -17.6%       3107        perf-stat.overall.instructions-per-iTLB-miss
      0.19           +24.7%       0.23 ±  4%  perf-stat.overall.ipc
     19.16 ±  4%      -7.7       11.44        perf-stat.overall.node-load-miss-rate%
     32.63 ±  3%     -19.4       13.23 ±  5%  perf-stat.overall.node-store-miss-rate%
 5.031e+09 ±  2%      -8.6%  4.596e+09        perf-stat.ps.branch-instructions
  59906474 ±  3%      -6.2%   56198255        perf-stat.ps.branch-misses
 1.057e+08 ±  4%     +16.1%  1.227e+08        perf-stat.ps.cache-misses
 1.857e+08 ±  2%     +30.6%  2.426e+08        perf-stat.ps.cache-references
     12922 ±  3%     +44.7%      18696 ±  6%  perf-stat.ps.context-switches
    174217            -2.9%     169223        perf-stat.ps.cpu-clock
 1.274e+11 ±  2%     -23.4%  9.764e+10 ±  4%  perf-stat.ps.cpu-cycles
    439.58 ±  5%     +41.3%     621.34 ±  9%  perf-stat.ps.cpu-migrations
 1.862e+09 ±  3%     +22.0%  2.271e+09        perf-stat.ps.dTLB-stores
   6267758 ±  2%     +15.8%    7256430        perf-stat.ps.iTLB-load-misses
   3613586 ±  5%      +6.7%    3855729        perf-stat.ps.iTLB-loads
 2.364e+10 ±  2%      -4.6%  2.255e+10        perf-stat.ps.instructions
     17.86 ±  5%     -39.8%      10.75 ± 18%  perf-stat.ps.major-faults
     13772 ±  2%      +7.2%      14764 ±  4%  perf-stat.ps.minor-faults
   7160453 ±  5%     -23.7%    5462470 ±  2%  perf-stat.ps.node-load-misses
  30245644 ±  5%     +39.8%   42293659 ±  2%  perf-stat.ps.node-loads
   4597804 ±  3%     -50.5%    2275945 ±  4%  perf-stat.ps.node-store-misses
   9517269 ±  7%     +56.9%   14932144 ±  2%  perf-stat.ps.node-stores
     13790 ±  2%      +7.1%      14775 ±  4%  perf-stat.ps.page-faults
    174217            -2.9%     169223        perf-stat.ps.task-clock
 2.603e+11 ±  3%     -25.9%  1.928e+11        perf-stat.total.instructions
     60.22 ±  8%     -60.2        0.00        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.brd_insert_page.brd_do_bvec.brd_submit_bio
     61.63 ±  8%     -28.2       33.47 ± 23%  perf-profile.calltrace.cycles-pp._raw_spin_lock.brd_insert_page.brd_do_bvec.brd_submit_bio.submit_bio_noacct
     62.23 ±  8%     -27.6       34.67 ± 23%  perf-profile.calltrace.cycles-pp.brd_insert_page.brd_do_bvec.brd_submit_bio.submit_bio_noacct.submit_bio
     63.75 ±  8%     -26.3       37.48 ± 22%  perf-profile.calltrace.cycles-pp.brd_do_bvec.brd_submit_bio.submit_bio_noacct.submit_bio.iomap_submit_ioend
     26.57 ± 13%     -25.6        0.96 ± 14%  perf-profile.calltrace.cycles-pp.submit_bio.iomap_submit_ioend.xfs_vm_writepages.do_writepages.__filemap_fdatawrite_range
     26.57 ± 13%     -25.6        0.96 ± 14%  perf-profile.calltrace.cycles-pp.submit_bio_noacct.submit_bio.iomap_submit_ioend.xfs_vm_writepages.do_writepages
     26.57 ± 13%     -25.6        0.96 ± 14%  perf-profile.calltrace.cycles-pp.brd_submit_bio.submit_bio_noacct.submit_bio.iomap_submit_ioend.xfs_vm_writepages
     26.57 ± 13%     -25.6        0.96 ± 14%  perf-profile.calltrace.cycles-pp.iomap_submit_ioend.xfs_vm_writepages.do_writepages.__filemap_fdatawrite_range.file_write_and_wait_range
     64.39 ±  8%     -25.6       38.80 ± 21%  perf-profile.calltrace.cycles-pp.do_writepages.__filemap_fdatawrite_range.file_write_and_wait_range.xfs_file_fsync.do_fsync
     64.39 ±  8%     -25.6       38.80 ± 21%  perf-profile.calltrace.cycles-pp.xfs_vm_writepages.do_writepages.__filemap_fdatawrite_range.file_write_and_wait_range.xfs_file_fsync
     64.39 ±  8%     -25.6       38.80 ± 21%  perf-profile.calltrace.cycles-pp.__filemap_fdatawrite_range.file_write_and_wait_range.xfs_file_fsync.do_fsync.__x64_sys_fsync
     64.39 ±  8%     -25.6       38.81 ± 21%  perf-profile.calltrace.cycles-pp.file_write_and_wait_range.xfs_file_fsync.do_fsync.__x64_sys_fsync.do_syscall_64
     64.43 ±  8%     -25.5       38.90 ± 21%  perf-profile.calltrace.cycles-pp.__x64_sys_fsync.do_syscall_64.entry_SYSCALL_64_after_hwframe
     64.43 ±  8%     -25.5       38.90 ± 21%  perf-profile.calltrace.cycles-pp.do_fsync.__x64_sys_fsync.do_syscall_64.entry_SYSCALL_64_after_hwframe
     64.43 ±  8%     -25.5       38.90 ± 21%  perf-profile.calltrace.cycles-pp.xfs_file_fsync.do_fsync.__x64_sys_fsync.do_syscall_64.entry_SYSCALL_64_after_hwframe
     67.61 ±  8%     -22.5       45.06 ± 19%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe
     67.68 ±  8%     -22.5       45.21 ± 19%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.44 ± 59%      +0.5        0.96 ±  6%  perf-profile.calltrace.cycles-pp.worker_thread.kthread.ret_from_fork
      0.00            +0.6        0.55 ±  5%  perf-profile.calltrace.cycles-pp.end_page_writeback.iomap_finish_ioend.iomap_finish_ioends.xfs_end_ioend.xfs_end_io
      0.30 ±100%      +0.6        0.87 ±  8%  perf-profile.calltrace.cycles-pp.process_one_work.worker_thread.kthread.ret_from_fork
      0.00            +0.6        0.58 ±  5%  perf-profile.calltrace.cycles-pp.iomap_finish_ioends.xfs_end_ioend.xfs_end_io.process_one_work.worker_thread
      0.00            +0.6        0.58 ±  5%  perf-profile.calltrace.cycles-pp.iomap_finish_ioend.iomap_finish_ioends.xfs_end_ioend.xfs_end_io.process_one_work
      0.00            +0.6        0.61 ±  5%  perf-profile.calltrace.cycles-pp.xfs_end_ioend.xfs_end_io.process_one_work.worker_thread.kthread
      0.00            +0.6        0.61 ±  5%  perf-profile.calltrace.cycles-pp.xfs_end_io.process_one_work.worker_thread.kthread.ret_from_fork
      0.63 ±  7%      +0.6        1.25 ±  6%  perf-profile.calltrace.cycles-pp.add_to_page_cache_lru.pagecache_get_page.grab_cache_page_write_begin.iomap_write_begin.iomap_write_actor
      0.47 ± 59%      +0.6        1.09 ±  8%  perf-profile.calltrace.cycles-pp.ret_from_fork
      0.47 ± 59%      +0.6        1.09 ±  8%  perf-profile.calltrace.cycles-pp.kthread.ret_from_fork
      0.00            +0.7        0.69 ±  8%  perf-profile.calltrace.cycles-pp.iomap_set_page_dirty.iomap_write_end.iomap_write_actor.iomap_apply.iomap_file_buffered_write
      0.90 ±  8%      +0.8        1.72 ±  7%  perf-profile.calltrace.cycles-pp.copy_user_enhanced_fast_string.copyin.iov_iter_copy_from_user_atomic.iomap_write_actor.iomap_apply
      0.82 ±  5%      +0.8        1.65 ±  7%  perf-profile.calltrace.cycles-pp.iomap_write_end.iomap_write_actor.iomap_apply.iomap_file_buffered_write.xfs_file_buffered_aio_write
      0.00            +0.8        0.83 ± 24%  perf-profile.calltrace.cycles-pp.update_process_times.tick_sched_handle.tick_sched_timer.__hrtimer_run_queues.hrtimer_interrupt
      0.91 ±  8%      +0.8        1.74 ±  7%  perf-profile.calltrace.cycles-pp.copyin.iov_iter_copy_from_user_atomic.iomap_write_actor.iomap_apply.iomap_file_buffered_write
      0.00            +0.8        0.83 ± 15%  perf-profile.calltrace.cycles-pp.get_page_from_freelist.__alloc_pages_nodemask.brd_insert_page.brd_do_bvec.brd_submit_bio
      0.93 ±  8%      +0.8        1.77 ±  7%  perf-profile.calltrace.cycles-pp.iov_iter_copy_from_user_atomic.iomap_write_actor.iomap_apply.iomap_file_buffered_write.xfs_file_buffered_aio_write
      0.00            +0.8        0.85 ± 24%  perf-profile.calltrace.cycles-pp.tick_sched_handle.tick_sched_timer.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt
      0.90 ±  8%      +0.9        1.77 ±  8%  perf-profile.calltrace.cycles-pp.pagecache_get_page.grab_cache_page_write_begin.iomap_write_begin.iomap_write_actor.iomap_apply
      0.00            +0.9        0.88 ±  6%  perf-profile.calltrace.cycles-pp.__add_to_page_cache_locked.add_to_page_cache_lru.pagecache_get_page.grab_cache_page_write_begin.iomap_write_begin
      0.91 ±  8%      +0.9        1.79 ±  8%  perf-profile.calltrace.cycles-pp.grab_cache_page_write_begin.iomap_write_begin.iomap_write_actor.iomap_apply.iomap_file_buffered_write
      0.00            +0.9        0.89 ± 10%  perf-profile.calltrace.cycles-pp.iomap_set_range_uptodate.iomap_write_end.iomap_write_actor.iomap_apply.iomap_file_buffered_write
      0.00            +0.9        0.89 ± 15%  perf-profile.calltrace.cycles-pp.__alloc_pages_nodemask.brd_insert_page.brd_do_bvec.brd_submit_bio.submit_bio_noacct
      0.00            +0.9        0.90 ± 30%  perf-profile.calltrace.cycles-pp.clockevents_program_event.hrtimer_interrupt.__sysvec_apic_timer_interrupt.asm_call_sysvec_on_stack.sysvec_apic_timer_interrupt
      0.00            +0.9        0.91 ± 35%  perf-profile.calltrace.cycles-pp.irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter
      0.95 ±  8%      +0.9        1.86 ±  8%  perf-profile.calltrace.cycles-pp.iomap_write_begin.iomap_write_actor.iomap_apply.iomap_file_buffered_write.xfs_file_buffered_aio_write
      0.00            +0.9        0.91 ± 27%  perf-profile.calltrace.cycles-pp.free_unref_page_list.release_pages.__pagevec_release.truncate_inode_pages_range.evict
      0.00            +1.1        1.11 ± 24%  perf-profile.calltrace.cycles-pp.tick_sched_timer.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.asm_call_sysvec_on_stack
      0.00            +1.1        1.13 ± 33%  perf-profile.calltrace.cycles-pp.tick_nohz_next_event.tick_nohz_get_sleep_length.menu_select.do_idle.cpu_startup_entry
      0.00            +1.2        1.17 ± 24%  perf-profile.calltrace.cycles-pp.delete_from_page_cache_batch.truncate_inode_pages_range.evict.dispose_list.evict_inodes
      0.00            +1.2        1.25 ± 33%  perf-profile.calltrace.cycles-pp.tick_nohz_get_sleep_length.menu_select.do_idle.cpu_startup_entry.start_secondary
      0.00            +1.8        1.78 ± 29%  perf-profile.calltrace.cycles-pp.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.asm_call_sysvec_on_stack.sysvec_apic_timer_interrupt
      0.00            +1.8        1.83 ± 25%  perf-profile.calltrace.cycles-pp.release_pages.__pagevec_release.truncate_inode_pages_range.evict.dispose_list
      0.00            +1.9        1.86 ± 25%  perf-profile.calltrace.cycles-pp.__pagevec_release.truncate_inode_pages_range.evict.dispose_list.evict_inodes
      0.70 ± 14%      +2.5        3.19 ± 29%  perf-profile.calltrace.cycles-pp.hrtimer_interrupt.__sysvec_apic_timer_interrupt.asm_call_sysvec_on_stack.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      0.71 ± 14%      +2.5        3.24 ± 29%  perf-profile.calltrace.cycles-pp.__sysvec_apic_timer_interrupt.asm_call_sysvec_on_stack.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state
      0.71 ± 14%      +2.5        3.25 ± 29%  perf-profile.calltrace.cycles-pp.asm_call_sysvec_on_stack.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter
      2.86 ±  7%      +2.7        5.56 ±  6%  perf-profile.calltrace.cycles-pp.iomap_write_actor.iomap_apply.iomap_file_buffered_write.xfs_file_buffered_aio_write.new_sync_write
      2.92 ±  7%      +2.7        5.66 ±  6%  perf-profile.calltrace.cycles-pp.iomap_file_buffered_write.xfs_file_buffered_aio_write.new_sync_write.vfs_write.ksys_write
      2.92 ±  7%      +2.7        5.66 ±  6%  perf-profile.calltrace.cycles-pp.iomap_apply.iomap_file_buffered_write.xfs_file_buffered_aio_write.new_sync_write.vfs_write
      2.97 ±  7%      +2.8        5.74 ±  6%  perf-profile.calltrace.cycles-pp.xfs_file_buffered_aio_write.new_sync_write.vfs_write.ksys_write.do_syscall_64
      2.98 ±  7%      +2.8        5.76 ±  6%  perf-profile.calltrace.cycles-pp.new_sync_write.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
      3.00 ±  7%      +2.8        5.81 ±  6%  perf-profile.calltrace.cycles-pp.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
      3.01 ±  7%      +2.8        5.83 ±  6%  perf-profile.calltrace.cycles-pp.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.47 ± 57%      +3.4        3.89 ± 24%  perf-profile.calltrace.cycles-pp.truncate_inode_pages_range.evict.dispose_list.evict_inodes.generic_shutdown_super
      0.47 ± 57%      +3.4        3.91 ± 24%  perf-profile.calltrace.cycles-pp.evict.dispose_list.evict_inodes.generic_shutdown_super.kill_block_super
      0.47 ± 57%      +3.4        3.92 ± 24%  perf-profile.calltrace.cycles-pp.dispose_list.evict_inodes.generic_shutdown_super.kill_block_super.deactivate_locked_super
      0.47 ± 57%      +3.4        3.92 ± 24%  perf-profile.calltrace.cycles-pp.evict_inodes.generic_shutdown_super.kill_block_super.deactivate_locked_super.cleanup_mnt
      0.48 ± 57%      +3.5        3.96 ± 24%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.umount2
      0.48 ± 57%      +3.5        3.96 ± 24%  perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.entry_SYSCALL_64_after_hwframe.umount2
      0.48 ± 57%      +3.5        3.96 ± 24%  perf-profile.calltrace.cycles-pp.exit_to_user_mode_prepare.syscall_exit_to_user_mode.entry_SYSCALL_64_after_hwframe.umount2
      0.48 ± 57%      +3.5        3.96 ± 24%  perf-profile.calltrace.cycles-pp.task_work_run.exit_to_user_mode_prepare.syscall_exit_to_user_mode.entry_SYSCALL_64_after_hwframe.umount2
      0.48 ± 57%      +3.5        3.96 ± 24%  perf-profile.calltrace.cycles-pp.umount2
      0.48 ± 57%      +3.5        3.96 ± 24%  perf-profile.calltrace.cycles-pp.cleanup_mnt.task_work_run.exit_to_user_mode_prepare.syscall_exit_to_user_mode.entry_SYSCALL_64_after_hwframe
      0.48 ± 57%      +3.5        3.96 ± 24%  perf-profile.calltrace.cycles-pp.deactivate_locked_super.cleanup_mnt.task_work_run.exit_to_user_mode_prepare.syscall_exit_to_user_mode
      0.48 ± 57%      +3.5        3.96 ± 24%  perf-profile.calltrace.cycles-pp.kill_block_super.deactivate_locked_super.cleanup_mnt.task_work_run.exit_to_user_mode_prepare
      0.48 ± 57%      +3.5        3.96 ± 24%  perf-profile.calltrace.cycles-pp.generic_shutdown_super.kill_block_super.deactivate_locked_super.cleanup_mnt.task_work_run
      0.14 ±173%      +3.7        3.84 ± 40%  perf-profile.calltrace.cycles-pp.menu_select.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      1.11 ± 12%      +4.1        5.24 ± 30%  perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter.do_idle
      1.28 ±  8%      +8.0        9.23 ± 33%  perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry
     30.02 ± 20%     +12.7       42.69 ± 15%  perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry.start_secondary
     30.20 ± 19%     +14.3       44.46 ± 15%  perf-profile.calltrace.cycles-pp.cpuidle_enter.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     30.72 ± 19%     +17.9       48.66 ± 15%  perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     30.72 ± 19%     +18.0       48.68 ± 15%  perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     30.72 ± 19%     +18.0       48.68 ± 15%  perf-profile.calltrace.cycles-pp.start_secondary.secondary_startup_64_no_verify
     30.75 ± 19%     +18.2       49.00 ± 15%  perf-profile.calltrace.cycles-pp.secondary_startup_64_no_verify
      0.00           +31.2       31.19 ± 24%  perf-profile.calltrace.cycles-pp.__cna_queued_spin_lock_slowpath._raw_spin_lock.brd_insert_page.brd_do_bvec.brd_submit_bio
     60.30 ±  8%     -60.3        0.00        perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
     61.72 ±  8%     -28.0       33.71 ± 23%  perf-profile.children.cycles-pp._raw_spin_lock
     62.24 ±  8%     -27.5       34.70 ± 23%  perf-profile.children.cycles-pp.brd_insert_page
     63.78 ±  8%     -26.3       37.53 ± 22%  perf-profile.children.cycles-pp.brd_do_bvec
     63.77 ±  8%     -26.2       37.52 ± 22%  perf-profile.children.cycles-pp.iomap_submit_ioend
     63.80 ±  8%     -26.2       37.57 ± 22%  perf-profile.children.cycles-pp.submit_bio
     63.80 ±  8%     -26.2       37.57 ± 22%  perf-profile.children.cycles-pp.submit_bio_noacct
     63.80 ±  8%     -26.2       37.57 ± 22%  perf-profile.children.cycles-pp.brd_submit_bio
     64.39 ±  8%     -25.6       38.80 ± 21%  perf-profile.children.cycles-pp.__filemap_fdatawrite_range
     64.39 ±  8%     -25.6       38.80 ± 21%  perf-profile.children.cycles-pp.xfs_vm_writepages
     64.39 ±  8%     -25.6       38.81 ± 21%  perf-profile.children.cycles-pp.file_write_and_wait_range
     64.39 ±  8%     -25.6       38.81 ± 21%  perf-profile.children.cycles-pp.do_writepages
     64.43 ±  8%     -25.5       38.90 ± 21%  perf-profile.children.cycles-pp.__x64_sys_fsync
     64.43 ±  8%     -25.5       38.90 ± 21%  perf-profile.children.cycles-pp.do_fsync
     64.43 ±  8%     -25.5       38.90 ± 21%  perf-profile.children.cycles-pp.xfs_file_fsync
     67.88 ±  8%     -22.4       45.52 ± 19%  perf-profile.children.cycles-pp.do_syscall_64
     68.55 ±  8%     -18.9       49.61 ± 15%  perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.14 ± 38%      -0.1        0.04 ±101%  perf-profile.children.cycles-pp.write
      0.14 ± 40%      -0.1        0.04 ±100%  perf-profile.children.cycles-pp.devkmsg_write.cold
      0.14 ± 40%      -0.1        0.04 ±100%  perf-profile.children.cycles-pp.devkmsg_emit
      0.07 ±  7%      +0.0        0.10 ±  8%  perf-profile.children.cycles-pp.__get_user_nocheck_1
      0.08 ±  6%      +0.0        0.11 ± 14%  perf-profile.children.cycles-pp.iov_iter_fault_in_readable
      0.07 ±  7%      +0.0        0.10 ± 15%  perf-profile.children.cycles-pp.__x64_sys_gettimeofday
      0.05 ±  8%      +0.0        0.10 ± 21%  perf-profile.children.cycles-pp.xfs_generic_create
      0.00            +0.1        0.05 ±  8%  perf-profile.children.cycles-pp.schedule_timeout
      0.04 ± 58%      +0.1        0.10 ± 21%  perf-profile.children.cycles-pp.xfs_create
      0.00            +0.1        0.06 ±  7%  perf-profile.children.cycles-pp.xfs_btree_check_sblock
      0.03 ±100%      +0.1        0.08 ± 10%  perf-profile.children.cycles-pp.page_mapping
      0.00            +0.1        0.06 ± 14%  perf-profile.children.cycles-pp.syscall_return_via_sysret
      0.00            +0.1        0.06 ± 14%  perf-profile.children.cycles-pp.xlog_cil_push_work
      0.00            +0.1        0.06 ± 22%  perf-profile.children.cycles-pp.nr_iowait_cpu
      0.08 ± 10%      +0.1        0.14 ± 15%  perf-profile.children.cycles-pp.radix_tree_insert
      0.06 ±  9%      +0.1        0.11 ±  9%  perf-profile.children.cycles-pp.page_counter_try_charge
      0.00            +0.1        0.06 ± 20%  perf-profile.children.cycles-pp.xfs_buffered_write_iomap_begin
      0.00            +0.1        0.06 ± 20%  perf-profile.children.cycles-pp.xlog_cil_insert_items
      0.00            +0.1        0.06 ± 16%  perf-profile.children.cycles-pp.xfs_defer_finish_noroll
      0.00            +0.1        0.06 ± 16%  perf-profile.children.cycles-pp.xfs_btree_lookup
      0.03 ±100%      +0.1        0.09 ± 24%  perf-profile.children.cycles-pp.balance_dirty_pages_ratelimited
      0.03 ±100%      +0.1        0.09 ± 20%  perf-profile.children.cycles-pp.dec_zone_page_state
      0.00            +0.1        0.06 ± 20%  perf-profile.children.cycles-pp._raw_spin_lock_irq
      0.06            +0.1        0.12 ± 14%  perf-profile.children.cycles-pp.xfs_log_commit_cil
      0.00            +0.1        0.07 ± 25%  perf-profile.children.cycles-pp.free_unref_page_prepare
      0.00            +0.1        0.07 ± 25%  perf-profile.children.cycles-pp.hrtimer_get_next_event
      0.00            +0.1        0.07 ±  7%  perf-profile.children.cycles-pp.xas_find
      0.00            +0.1        0.07 ± 13%  perf-profile.children.cycles-pp.__xa_clear_mark
      0.04 ± 58%      +0.1        0.11 ± 16%  perf-profile.children.cycles-pp.__fput
      0.00            +0.1        0.07 ± 16%  perf-profile.children.cycles-pp.xfs_trans_read_buf_map
      0.01 ±173%      +0.1        0.08 ± 17%  perf-profile.children.cycles-pp.__radix_tree_preload
      0.00            +0.1        0.07 ± 33%  perf-profile.children.cycles-pp.try_to_wake_up
      0.06            +0.1        0.13 ± 12%  perf-profile.children.cycles-pp.__xfs_trans_commit
      0.00            +0.1        0.07 ± 28%  perf-profile.children.cycles-pp.exc_page_fault
      0.00            +0.1        0.07 ± 28%  perf-profile.children.cycles-pp.do_user_addr_fault
      0.00            +0.1        0.07 ± 10%  perf-profile.children.cycles-pp.kmem_cache_alloc
      0.00            +0.1        0.07 ± 10%  perf-profile.children.cycles-pp.___might_sleep
      0.00            +0.1        0.07 ± 22%  perf-profile.children.cycles-pp.mem_cgroup_charge_statistics
      0.17 ± 31%      +0.1        0.24 ± 16%  perf-profile.children.cycles-pp.console_unlock
      0.03 ±100%      +0.1        0.10 ± 15%  perf-profile.children.cycles-pp.xfs_release
      0.07 ± 10%      +0.1        0.14 ± 16%  perf-profile.children.cycles-pp.do_filp_open
      0.07 ± 10%      +0.1        0.14 ± 16%  perf-profile.children.cycles-pp.path_openat
      0.00            +0.1        0.07 ± 31%  perf-profile.children.cycles-pp.asm_exc_page_fault
      0.01 ±173%      +0.1        0.09 ± 17%  perf-profile.children.cycles-pp.xfs_defer_finish
      0.03 ±100%      +0.1        0.10 ± 18%  perf-profile.children.cycles-pp.xfs_free_eofblocks
      0.08 ±  6%      +0.1        0.15 ± 14%  perf-profile.children.cycles-pp.do_sys_open
      0.08 ±  6%      +0.1        0.15 ± 14%  perf-profile.children.cycles-pp.do_sys_openat2
      0.00            +0.1        0.08 ±  6%  perf-profile.children.cycles-pp.xfs_alloc_walk_iter
      0.00            +0.1        0.08 ± 29%  perf-profile.children.cycles-pp.uncharge_page
      0.01 ±173%      +0.1        0.09 ± 20%  perf-profile.children.cycles-pp.xfs_itruncate_extents_flags
      0.00            +0.1        0.08 ± 19%  perf-profile.children.cycles-pp.__count_memcg_events
      0.00            +0.1        0.08 ± 17%  perf-profile.children.cycles-pp.delay_tsc
      0.00            +0.1        0.08 ± 13%  perf-profile.children.cycles-pp.mem_cgroup_track_foreign_dirty_slowpath
      0.00            +0.1        0.08 ± 23%  perf-profile.children.cycles-pp.find_get_entry
      0.14 ± 26%      +0.1        0.23 ± 18%  perf-profile.children.cycles-pp.uart_console_write
      0.15 ± 27%      +0.1        0.23 ± 16%  perf-profile.children.cycles-pp.serial8250_console_write
      0.14 ± 29%      +0.1        0.22 ± 17%  perf-profile.children.cycles-pp.wait_for_xmitr
      0.13 ± 26%      +0.1        0.22 ± 16%  perf-profile.children.cycles-pp.serial8250_console_putchar
      0.00            +0.1        0.09 ± 20%  perf-profile.children.cycles-pp.xfs_log_force_lsn
      0.08 ± 10%      +0.1        0.17 ±  9%  perf-profile.children.cycles-pp.try_charge
      0.00            +0.1        0.09 ± 30%  perf-profile.children.cycles-pp.page_counter_cancel
      0.00            +0.1        0.09 ±  4%  perf-profile.children.cycles-pp.xfs_alloc_ag_vextent_locality
      0.06 ± 14%      +0.1        0.15 ± 22%  perf-profile.children.cycles-pp.get_mem_cgroup_from_mm
      0.00            +0.1        0.10 ± 22%  perf-profile.children.cycles-pp.arch_scale_freq_tick
      0.00            +0.1        0.10 ± 34%  perf-profile.children.cycles-pp.page_counter_uncharge
      0.00            +0.1        0.10 ± 27%  perf-profile.children.cycles-pp.__mod_zone_page_state
      0.00            +0.1        0.10 ± 32%  perf-profile.children.cycles-pp.hrtimer_next_event_without
      0.05 ±  8%      +0.1        0.15 ±  7%  perf-profile.children.cycles-pp.xfs_alloc_ag_vextent
      0.04 ± 57%      +0.1        0.14        perf-profile.children.cycles-pp.xfs_alloc_ag_vextent_near
      0.14 ±  8%      +0.1        0.24 ±  9%  perf-profile.children.cycles-pp.__pagevec_lru_add_fn
      0.05 ± 58%      +0.1        0.15 ± 20%  perf-profile.children.cycles-pp.rcu_sched_clock_irq
      0.00            +0.1        0.11 ± 34%  perf-profile.children.cycles-pp.rcu_idle_exit
      0.00            +0.1        0.11 ± 31%  perf-profile.children.cycles-pp.uncharge_batch
      0.06 ± 11%      +0.1        0.17 ±  6%  perf-profile.children.cycles-pp.pick_next_task_fair
      0.06            +0.1        0.17 ±  6%  perf-profile.children.cycles-pp.xfs_alloc_vextent
      0.00            +0.1        0.11 ± 30%  perf-profile.children.cycles-pp.update_blocked_averages
      0.06 ±  7%      +0.1        0.17 ± 11%  perf-profile.children.cycles-pp.newidle_balance
      0.06            +0.1        0.17 ±  4%  perf-profile.children.cycles-pp.xfs_bmap_btalloc
      0.00            +0.1        0.11 ± 19%  perf-profile.children.cycles-pp.free_unref_page_commit
      0.03 ±100%      +0.1        0.14 ± 33%  perf-profile.children.cycles-pp.update_rq_clock
      0.00            +0.1        0.12 ± 32%  perf-profile.children.cycles-pp.get_next_timer_interrupt
      0.00            +0.1        0.12 ± 27%  perf-profile.children.cycles-pp.run_rebalance_domains
      0.00            +0.1        0.12 ±  7%  perf-profile.children.cycles-pp.xas_start
      0.07 ±  7%      +0.1        0.18 ±  4%  perf-profile.children.cycles-pp.xfs_bmapi_allocate
      0.00            +0.1        0.12 ± 28%  perf-profile.children.cycles-pp.page_cache_free_page
      0.07 ± 10%      +0.1        0.19 ± 11%  perf-profile.children.cycles-pp.schedule
      0.00            +0.1        0.12 ± 40%  perf-profile.children.cycles-pp.kmem_cache_free
      0.00            +0.1        0.13 ± 27%  perf-profile.children.cycles-pp.idle_cpu
      0.01 ±173%      +0.1        0.14 ± 17%  perf-profile.children.cycles-pp.unlock_page
      0.44 ±  7%      +0.1        0.57 ± 11%  perf-profile.children.cycles-pp.__radix_tree_lookup
      0.19 ±  8%      +0.1        0.32 ±  7%  perf-profile.children.cycles-pp.pagevec_lru_move_fn
      0.01 ±173%      +0.1        0.15 ± 23%  perf-profile.children.cycles-pp.calc_global_load_tick
      0.13 ±  8%      +0.1        0.27 ± 10%  perf-profile.children.cycles-pp.rmqueue_bulk
      0.00            +0.1        0.14 ± 32%  perf-profile.children.cycles-pp.rcu_do_batch
      0.00            +0.1        0.14 ± 30%  perf-profile.children.cycles-pp.arch_cpu_idle_enter
      0.00            +0.1        0.14 ± 30%  perf-profile.children.cycles-pp.tsc_verify_tsc_adjust
      0.08 ±  8%      +0.1        0.22 ± 13%  perf-profile.children.cycles-pp.__schedule
      0.01 ±173%      +0.1        0.16 ± 27%  perf-profile.children.cycles-pp.irqtime_account_irq
      0.00            +0.1        0.14 ± 22%  perf-profile.children.cycles-pp.__list_add_valid
      0.45 ±  7%      +0.1        0.59 ± 13%  perf-profile.children.cycles-pp.brd_lookup_page
      0.08            +0.1        0.23 ±  3%  perf-profile.children.cycles-pp.xfs_bmapi_convert_delalloc
      0.20 ± 10%      +0.2        0.35 ±  9%  perf-profile.children.cycles-pp.lru_cache_add
      0.16 ±  5%      +0.2        0.32 ±  6%  perf-profile.children.cycles-pp.clear_page_dirty_for_io
      0.09 ±  4%      +0.2        0.25 ±  4%  perf-profile.children.cycles-pp.xfs_map_blocks
      0.08 ±  5%      +0.2        0.24 ± 10%  perf-profile.children.cycles-pp.__mod_node_page_state
      0.10 ±  8%      +0.2        0.27 ±  9%  perf-profile.children.cycles-pp.xas_load
      0.00            +0.2        0.17 ± 32%  perf-profile.children.cycles-pp.truncate_cleanup_page
      0.01 ±173%      +0.2        0.18 ± 30%  perf-profile.children.cycles-pp.native_sched_clock
      0.03 ±100%      +0.2        0.20 ± 29%  perf-profile.children.cycles-pp.sched_clock
      0.03 ±100%      +0.2        0.20 ± 33%  perf-profile.children.cycles-pp.asm_sysvec_irq_work
      0.03 ±100%      +0.2        0.20 ± 33%  perf-profile.children.cycles-pp.sysvec_irq_work
      0.03 ±100%      +0.2        0.20 ± 33%  perf-profile.children.cycles-pp.__sysvec_irq_work
      0.03 ±100%      +0.2        0.20 ± 33%  perf-profile.children.cycles-pp.irq_work_run
      0.03 ±100%      +0.2        0.20 ± 33%  perf-profile.children.cycles-pp.irq_work_single
      0.01 ±173%      +0.2        0.19 ± 23%  perf-profile.children.cycles-pp.xas_clear_mark
      0.03 ±100%      +0.2        0.20 ± 34%  perf-profile.children.cycles-pp.irq_work_run_list
      0.00            +0.2        0.18 ± 39%  perf-profile.children.cycles-pp.asm_sysvec_call_function
      0.08 ± 16%      +0.2        0.26 ± 22%  perf-profile.children.cycles-pp._raw_spin_unlock_irqrestore
      0.03 ±100%      +0.2        0.21 ± 35%  perf-profile.children.cycles-pp.printk
      0.01 ±173%      +0.2        0.20 ± 27%  perf-profile.children.cycles-pp.__intel_pmu_enable_all
      0.16 ± 12%      +0.2        0.35 ±  8%  perf-profile.children.cycles-pp.account_page_dirtied
      0.00            +0.2        0.19 ± 33%  perf-profile.children.cycles-pp.rcu_core
      0.03 ±100%      +0.2        0.23 ± 26%  perf-profile.children.cycles-pp.sched_clock_cpu
      0.06 ± 14%      +0.2        0.26 ± 40%  perf-profile.children.cycles-pp.lapic_next_deadline
      0.00            +0.2        0.21 ± 29%  perf-profile.children.cycles-pp.mem_cgroup_uncharge_list
      0.21 ±  8%      +0.2        0.41 ± 12%  perf-profile.children.cycles-pp.__test_set_page_writeback
      0.06 ± 13%      +0.2        0.27 ± 40%  perf-profile.children.cycles-pp.read_tsc
      0.11 ±  4%      +0.2        0.33 ± 13%  perf-profile.children.cycles-pp.__mod_lruvec_state
      0.01 ±173%      +0.2        0.23 ± 26%  perf-profile.children.cycles-pp._raw_spin_trylock
      0.18 ± 12%      +0.2        0.39 ±  3%  perf-profile.children.cycles-pp.percpu_counter_add_batch
      0.08 ± 10%      +0.2        0.29 ± 22%  perf-profile.children.cycles-pp.update_sd_lb_stats
      0.08 ±  8%      +0.2        0.30 ± 22%  perf-profile.children.cycles-pp.find_busiest_group
      0.00            +0.2        0.22 ± 25%  perf-profile.children.cycles-pp.xas_init_marks
      0.23 ± 10%      +0.2        0.46 ±  8%  perf-profile.children.cycles-pp.rmqueue
      0.06 ± 11%      +0.2        0.30 ± 24%  perf-profile.children.cycles-pp.__list_del_entry_valid
      0.09 ± 11%      +0.2        0.34 ± 27%  perf-profile.children.cycles-pp.ktime_get_update_offsets_now
      0.16 ±  6%      +0.3        0.42 ± 12%  perf-profile.children.cycles-pp.__mod_memcg_state
      0.28 ±  8%      +0.3        0.55 ±  5%  perf-profile.children.cycles-pp.end_page_writeback
      0.28 ±  8%      +0.3        0.55 ±  5%  perf-profile.children.cycles-pp.test_clear_page_writeback
      0.00            +0.3        0.28 ± 12%  perf-profile.children.cycles-pp.cna_order_queue
      0.31 ±  8%      +0.3        0.58 ±  5%  perf-profile.children.cycles-pp.iomap_finish_ioends
      0.31 ±  8%      +0.3        0.58 ±  5%  perf-profile.children.cycles-pp.iomap_finish_ioend
      0.17 ± 11%      +0.3        0.45 ± 16%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      0.24 ± 10%      +0.3        0.53 ±  7%  perf-profile.children.cycles-pp.__set_page_dirty
      0.21 ±  8%      +0.3        0.49 ± 11%  perf-profile.children.cycles-pp.mem_cgroup_charge
      0.32 ±  8%      +0.3        0.61 ±  5%  perf-profile.children.cycles-pp.xfs_end_ioend
      0.32 ±  8%      +0.3        0.61 ±  5%  perf-profile.children.cycles-pp.xfs_end_io
      0.04 ± 58%      +0.3        0.34 ± 23%  perf-profile.children.cycles-pp.unaccount_page_cache_page
      0.10 ±  9%      +0.3        0.39 ± 29%  perf-profile.children.cycles-pp.load_balance
      0.02 ±173%      +0.3        0.32 ± 32%  perf-profile.children.cycles-pp.start_kernel
      0.04 ± 58%      +0.3        0.36 ± 21%  perf-profile.children.cycles-pp.find_get_entries
      0.04 ± 58%      +0.3        0.36 ± 20%  perf-profile.children.cycles-pp.pagevec_lookup_entries
      0.24 ±  7%      +0.3        0.57 ± 19%  perf-profile.children.cycles-pp.clear_page_erms
      0.52 ± 16%      +0.3        0.87 ±  8%  perf-profile.children.cycles-pp.process_one_work
      0.26 ±  6%      +0.4        0.61 ± 19%  perf-profile.children.cycles-pp.prep_new_page
      0.08 ± 13%      +0.4        0.44 ± 31%  perf-profile.children.cycles-pp.native_irq_return_iret
      0.14 ± 11%      +0.4        0.50 ± 32%  perf-profile.children.cycles-pp.perf_mux_hrtimer_handler
      0.07 ± 11%      +0.4        0.45 ± 29%  perf-profile.children.cycles-pp.tick_nohz_irq_exit
      0.32 ±  9%      +0.4        0.70 ±  8%  perf-profile.children.cycles-pp.iomap_set_page_dirty
      0.29 ± 14%      +0.4        0.67 ± 10%  perf-profile.children.cycles-pp.scheduler_tick
      0.22 ±  6%      +0.4        0.61 ± 10%  perf-profile.children.cycles-pp.__mod_memcg_lruvec_state
      0.12 ± 12%      +0.4        0.52 ± 27%  perf-profile.children.cycles-pp.tick_irq_enter
      0.56 ± 15%      +0.4        0.96 ±  6%  perf-profile.children.cycles-pp.worker_thread
      0.46 ±  4%      +0.4        0.89 ± 10%  perf-profile.children.cycles-pp.iomap_set_range_uptodate
      0.09 ± 14%      +0.4        0.52 ± 38%  perf-profile.children.cycles-pp.rebalance_domains
      0.15 ± 12%      +0.5        0.60 ± 27%  perf-profile.children.cycles-pp.irq_enter_rcu
      0.42 ±  7%      +0.5        0.89 ±  6%  perf-profile.children.cycles-pp.__add_to_page_cache_locked
      0.13 ± 10%      +0.5        0.61 ± 23%  perf-profile.children.cycles-pp.xas_store
      0.59 ± 15%      +0.5        1.09 ±  8%  perf-profile.children.cycles-pp.kthread
      0.59 ± 15%      +0.5        1.09 ±  9%  perf-profile.children.cycles-pp.ret_from_fork
      0.10 ±  9%      +0.5        0.64 ± 28%  perf-profile.children.cycles-pp.free_pcppages_bulk
      0.10 ± 35%      +0.5        0.64 ± 31%  perf-profile.children.cycles-pp.timekeeping_max_deferment
      0.63 ±  8%      +0.6        1.25 ±  6%  perf-profile.children.cycles-pp.add_to_page_cache_lru
      0.56 ±  8%      +0.6        1.18 ± 14%  perf-profile.children.cycles-pp.get_page_from_freelist
      0.44 ± 14%      +0.6        1.09 ± 11%  perf-profile.children.cycles-pp.update_process_times
      0.45 ± 16%      +0.7        1.11 ± 11%  perf-profile.children.cycles-pp.tick_sched_handle
      0.30 ±  8%      +0.7        0.97 ± 28%  perf-profile.children.cycles-pp.clockevents_program_event
      0.62 ±  7%      +0.7        1.30 ± 13%  perf-profile.children.cycles-pp.__alloc_pages_nodemask
      0.17 ± 15%      +0.7        0.85 ± 35%  perf-profile.children.cycles-pp.do_softirq_own_stack
      0.18 ± 15%      +0.7        0.92 ± 35%  perf-profile.children.cycles-pp.__softirqentry_text_start
      0.15 ± 10%      +0.8        0.93 ± 26%  perf-profile.children.cycles-pp.free_unref_page_list
      0.21 ± 12%      +0.8        1.00 ± 34%  perf-profile.children.cycles-pp.irq_exit_rcu
      0.92 ±  8%      +0.8        1.74 ±  7%  perf-profile.children.cycles-pp.copyin
      0.91 ±  8%      +0.8        1.74 ±  7%  perf-profile.children.cycles-pp.copy_user_enhanced_fast_string
      0.82 ±  5%      +0.8        1.65 ±  7%  perf-profile.children.cycles-pp.iomap_write_end
      0.94 ±  8%      +0.8        1.77 ±  7%  perf-profile.children.cycles-pp.iov_iter_copy_from_user_atomic
      0.53 ± 13%      +0.9        1.39 ± 13%  perf-profile.children.cycles-pp.tick_sched_timer
      0.90 ±  8%      +0.9        1.77 ±  8%  perf-profile.children.cycles-pp.pagecache_get_page
      0.91 ±  8%      +0.9        1.79 ±  8%  perf-profile.children.cycles-pp.grab_cache_page_write_begin
      0.95 ±  8%      +0.9        1.86 ±  8%  perf-profile.children.cycles-pp.iomap_write_begin
      0.17 ± 24%      +1.0        1.13 ± 33%  perf-profile.children.cycles-pp.tick_nohz_next_event
      0.18 ± 10%      +1.0        1.18 ± 24%  perf-profile.children.cycles-pp.delete_from_page_cache_batch
      0.20 ± 21%      +1.1        1.25 ± 32%  perf-profile.children.cycles-pp.tick_nohz_get_sleep_length
      0.44 ±  3%      +1.3        1.77 ± 26%  perf-profile.children.cycles-pp.ktime_get
      0.73 ± 14%      +1.4        2.11 ± 20%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      0.29 ± 10%      +1.6        1.90 ± 24%  perf-profile.children.cycles-pp.__pagevec_release
      0.31 ±  9%      +1.6        1.93 ± 24%  perf-profile.children.cycles-pp.release_pages
      1.18 ± 11%      +2.4        3.63 ± 23%  perf-profile.children.cycles-pp.hrtimer_interrupt
      1.19 ± 11%      +2.5        3.68 ± 23%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      3.14 ±  8%      +2.7        5.81 ±  6%  perf-profile.children.cycles-pp.new_sync_write
      2.86 ±  7%      +2.7        5.56 ±  6%  perf-profile.children.cycles-pp.iomap_write_actor
      3.17 ±  8%      +2.7        5.87 ±  6%  perf-profile.children.cycles-pp.ksys_write
      3.16 ±  7%      +2.7        5.86 ±  6%  perf-profile.children.cycles-pp.vfs_write
      2.92 ±  7%      +2.7        5.66 ±  6%  perf-profile.children.cycles-pp.iomap_file_buffered_write
      2.92 ±  7%      +2.7        5.66 ±  6%  perf-profile.children.cycles-pp.iomap_apply
      2.97 ±  7%      +2.8        5.74 ±  6%  perf-profile.children.cycles-pp.xfs_file_buffered_aio_write
      0.59 ± 11%      +3.3        3.91 ± 24%  perf-profile.children.cycles-pp.truncate_inode_pages_range
      0.59 ± 11%      +3.3        3.91 ± 24%  perf-profile.children.cycles-pp.evict
      0.60 ± 10%      +3.3        3.92 ± 24%  perf-profile.children.cycles-pp.dispose_list
      0.60 ± 10%      +3.3        3.92 ± 24%  perf-profile.children.cycles-pp.evict_inodes
      1.40 ± 12%      +3.3        4.75 ± 25%  perf-profile.children.cycles-pp.asm_call_sysvec_on_stack
      0.60 ± 10%      +3.4        3.96 ± 24%  perf-profile.children.cycles-pp.umount2
      0.60 ± 10%      +3.4        3.96 ± 24%  perf-profile.children.cycles-pp.cleanup_mnt
      0.60 ± 10%      +3.4        3.96 ± 24%  perf-profile.children.cycles-pp.deactivate_locked_super
      0.60 ± 10%      +3.4        3.96 ± 24%  perf-profile.children.cycles-pp.kill_block_super
      0.60 ± 10%      +3.4        3.96 ± 24%  perf-profile.children.cycles-pp.generic_shutdown_super
      0.65 ± 10%      +3.4        4.07 ± 24%  perf-profile.children.cycles-pp.task_work_run
      0.66 ± 10%      +3.4        4.07 ± 24%  perf-profile.children.cycles-pp.exit_to_user_mode_prepare
      0.66 ±  9%      +3.4        4.08 ± 24%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      0.44 ± 19%      +3.4        3.87 ± 40%  perf-profile.children.cycles-pp.menu_select
      1.64 ± 11%      +4.1        5.78 ± 25%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      1.84 ±  8%      +6.0        7.86 ± 28%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
     30.23 ± 19%     +14.5       44.75 ± 15%  perf-profile.children.cycles-pp.cpuidle_enter_state
     30.23 ± 19%     +14.5       44.76 ± 15%  perf-profile.children.cycles-pp.cpuidle_enter
     30.72 ± 19%     +18.0       48.68 ± 15%  perf-profile.children.cycles-pp.start_secondary
     30.75 ± 19%     +18.2       49.00 ± 15%  perf-profile.children.cycles-pp.do_idle
     30.75 ± 19%     +18.2       49.00 ± 15%  perf-profile.children.cycles-pp.secondary_startup_64_no_verify
     30.75 ± 19%     +18.2       49.00 ± 15%  perf-profile.children.cycles-pp.cpu_startup_entry
      0.00           +31.3       31.33 ± 24%  perf-profile.children.cycles-pp.__cna_queued_spin_lock_slowpath
     59.82 ±  8%     -59.8        0.00        perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
      0.06 ± 13%      +0.0        0.10 ±  8%  perf-profile.self.cycles-pp.__get_user_nocheck_1
      0.06 ±  6%      +0.0        0.10 ± 18%  perf-profile.self.cycles-pp.__pagevec_lru_add_fn
      0.05 ±  9%      +0.0        0.10 ± 22%  perf-profile.self.cycles-pp.clear_page_dirty_for_io
      0.08 ±  8%      +0.0        0.13 ± 15%  perf-profile.self.cycles-pp.radix_tree_insert
      0.06 ±  7%      +0.1        0.11 ± 10%  perf-profile.self.cycles-pp.__add_to_page_cache_locked
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.iomap_writepage_map
      0.08 ±  5%      +0.1        0.13 ±  8%  perf-profile.self.cycles-pp.rmqueue
      0.00            +0.1        0.06 ± 15%  perf-profile.self.cycles-pp.iomap_write_begin
      0.06 ±  9%      +0.1        0.11 ± 15%  perf-profile.self.cycles-pp.test_clear_page_writeback
      0.00            +0.1        0.06 ± 14%  perf-profile.self.cycles-pp.syscall_return_via_sysret
      0.06 ±  7%      +0.1        0.12 ± 19%  perf-profile.self.cycles-pp.__test_set_page_writeback
      0.00            +0.1        0.06 ± 22%  perf-profile.self.cycles-pp.nr_iowait_cpu
      0.00            +0.1        0.06 ± 11%  perf-profile.self.cycles-pp.try_charge
      0.00            +0.1        0.06 ± 16%  perf-profile.self.cycles-pp._raw_spin_lock_irq
      0.00            +0.1        0.06 ± 13%  perf-profile.self.cycles-pp.brd_insert_page
      0.01 ±173%      +0.1        0.08 ± 11%  perf-profile.self.cycles-pp.__alloc_pages_nodemask
      0.00            +0.1        0.07 ± 17%  perf-profile.self.cycles-pp.__radix_tree_preload
      0.04 ± 57%      +0.1        0.11 ± 10%  perf-profile.self.cycles-pp.page_counter_try_charge
      0.01 ±173%      +0.1        0.08 ± 12%  perf-profile.self.cycles-pp.page_mapping
      0.00            +0.1        0.07 ± 28%  perf-profile.self.cycles-pp.account_page_dirtied
      0.00            +0.1        0.07 ± 28%  perf-profile.self.cycles-pp.uncharge_page
      0.00            +0.1        0.07 ± 22%  perf-profile.self.cycles-pp.free_unref_page_list
      0.00            +0.1        0.07 ± 10%  perf-profile.self.cycles-pp.___might_sleep
      0.00            +0.1        0.07 ± 17%  perf-profile.self.cycles-pp.dec_zone_page_state
      0.00            +0.1        0.08 ± 22%  perf-profile.self.cycles-pp.__mod_lruvec_state
      0.00            +0.1        0.08 ± 19%  perf-profile.self.cycles-pp.__count_memcg_events
      0.00            +0.1        0.08 ± 19%  perf-profile.self.cycles-pp.free_unref_page_commit
      0.00            +0.1        0.08 ± 17%  perf-profile.self.cycles-pp.delay_tsc
      0.00            +0.1        0.08 ± 13%  perf-profile.self.cycles-pp.mem_cgroup_track_foreign_dirty_slowpath
      0.08 ±  8%      +0.1        0.17 ± 15%  perf-profile.self.cycles-pp.xas_load
      0.00            +0.1        0.09 ±  9%  perf-profile.self.cycles-pp.mem_cgroup_charge
      0.00            +0.1        0.09 ± 49%  perf-profile.self.cycles-pp.rebalance_domains
      0.05 ±  8%      +0.1        0.15 ± 22%  perf-profile.self.cycles-pp.get_mem_cgroup_from_mm
      0.04 ± 58%      +0.1        0.14 ± 25%  perf-profile.self.cycles-pp.rcu_sched_clock_irq
      0.00            +0.1        0.10 ± 33%  perf-profile.self.cycles-pp.__mod_zone_page_state
      0.00            +0.1        0.10 ± 22%  perf-profile.self.cycles-pp.arch_scale_freq_tick
      0.09 ± 11%      +0.1        0.19 ± 13%  perf-profile.self.cycles-pp.rmqueue_bulk
      0.43 ±  7%      +0.1        0.54 ±  8%  perf-profile.self.cycles-pp.__radix_tree_lookup
      0.00            +0.1        0.11 ± 42%  perf-profile.self.cycles-pp.do_idle
      0.04 ± 57%      +0.1        0.15 ± 20%  perf-profile.self.cycles-pp.update_process_times
      0.00            +0.1        0.11 ±  7%  perf-profile.self.cycles-pp.xas_start
      0.00            +0.1        0.11 ± 20%  perf-profile.self.cycles-pp.tick_sched_timer
      0.00            +0.1        0.11 ± 27%  perf-profile.self.cycles-pp.unaccount_page_cache_page
      0.00            +0.1        0.12 ± 28%  perf-profile.self.cycles-pp.page_cache_free_page
      0.00            +0.1        0.12 ± 22%  perf-profile.self.cycles-pp.__list_add_valid
      0.00            +0.1        0.12 ± 25%  perf-profile.self.cycles-pp.idle_cpu
      0.00            +0.1        0.13 ± 33%  perf-profile.self.cycles-pp.tsc_verify_tsc_adjust
      0.01 ±173%      +0.1        0.15 ± 23%  perf-profile.self.cycles-pp.calc_global_load_tick
      0.00            +0.1        0.14 ± 18%  perf-profile.self.cycles-pp.unlock_page
      0.07 ± 17%      +0.1        0.21 ± 22%  perf-profile.self.cycles-pp._raw_spin_unlock_irqrestore
      0.00            +0.1        0.15 ± 27%  perf-profile.self.cycles-pp.delete_from_page_cache_batch
      0.00            +0.1        0.15 ± 30%  perf-profile.self.cycles-pp.truncate_cleanup_page
      0.07 ± 10%      +0.1        0.22 ± 10%  perf-profile.self.cycles-pp.__mod_memcg_lruvec_state
      0.06 ±  9%      +0.1        0.20 ± 21%  perf-profile.self.cycles-pp.update_sd_lb_stats
      0.08 ± 10%      +0.2        0.24 ± 11%  perf-profile.self.cycles-pp.__mod_node_page_state
      0.01 ±173%      +0.2        0.18 ± 21%  perf-profile.self.cycles-pp.xas_clear_mark
      0.00            +0.2        0.17 ± 31%  perf-profile.self.cycles-pp.native_sched_clock
      0.01 ±173%      +0.2        0.20 ± 27%  perf-profile.self.cycles-pp.__intel_pmu_enable_all
      0.14 ± 12%      +0.2        0.33 ±  3%  perf-profile.self.cycles-pp.percpu_counter_add_batch
      0.05 ±  8%      +0.2        0.24 ± 27%  perf-profile.self.cycles-pp.xas_store
      0.06 ± 14%      +0.2        0.26 ± 39%  perf-profile.self.cycles-pp.lapic_next_deadline
      0.06 ± 13%      +0.2        0.27 ± 38%  perf-profile.self.cycles-pp.read_tsc
      0.01 ±173%      +0.2        0.22 ± 24%  perf-profile.self.cycles-pp._raw_spin_trylock
      0.08 ± 13%      +0.2        0.30 ± 26%  perf-profile.self.cycles-pp.ktime_get_update_offsets_now
      0.00            +0.2        0.22 ± 25%  perf-profile.self.cycles-pp.truncate_inode_pages_range
      0.06 ±  7%      +0.2        0.29 ± 26%  perf-profile.self.cycles-pp.__list_del_entry_valid
      0.13 ±  3%      +0.2        0.36 ± 15%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.16 ±  8%      +0.2        0.39 ± 12%  perf-profile.self.cycles-pp.__mod_memcg_state
      0.00            +0.3        0.27 ± 11%  perf-profile.self.cycles-pp.cna_order_queue
      0.03 ±100%      +0.3        0.32 ± 23%  perf-profile.self.cycles-pp.find_get_entries
      0.08 ±  6%      +0.3        0.37 ± 18%  perf-profile.self.cycles-pp.release_pages
      0.23 ±  9%      +0.3        0.55 ± 19%  perf-profile.self.cycles-pp.clear_page_erms
      0.02 ±173%      +0.3        0.36 ± 40%  perf-profile.self.cycles-pp.tick_nohz_next_event
      0.08 ± 13%      +0.4        0.44 ± 31%  perf-profile.self.cycles-pp.native_irq_return_iret
      0.45 ±  4%      +0.4        0.84 ±  6%  perf-profile.self.cycles-pp.iomap_set_range_uptodate
      0.07 ± 11%      +0.4        0.48 ± 27%  perf-profile.self.cycles-pp.free_pcppages_bulk
      0.10 ± 35%      +0.5        0.64 ± 30%  perf-profile.self.cycles-pp.timekeeping_max_deferment
      0.90 ±  8%      +0.8        1.72 ±  7%  perf-profile.self.cycles-pp.copy_user_enhanced_fast_string
      1.45 ±  7%      +1.0        2.45 ±  6%  perf-profile.self.cycles-pp._raw_spin_lock
      1.08 ±  9%      +1.1        2.21 ± 18%  perf-profile.self.cycles-pp.brd_do_bvec
      0.40 ±  2%      +1.1        1.55 ± 25%  perf-profile.self.cycles-pp.ktime_get
      0.22 ± 20%      +2.3        2.54 ± 44%  perf-profile.self.cycles-pp.menu_select
      0.30 ± 28%      +3.5        3.82 ± 41%  perf-profile.self.cycles-pp.cpuidle_enter_state
      0.00           +30.7       30.72 ± 24%  perf-profile.self.cycles-pp.__cna_queued_spin_lock_slowpath
      2112 ± 14%     -32.6%       1424 ± 21%  interrupts.CPU0.CAL:Function_call_interrupts
     23255 ±  4%     -20.2%      18562        interrupts.CPU0.LOC:Local_timer_interrupts
      2517 ± 26%     -80.8%     484.50 ± 47%  interrupts.CPU0.NMI:Non-maskable_interrupts
      2517 ± 26%     -80.8%     484.50 ± 47%  interrupts.CPU0.PMI:Performance_monitoring_interrupts
      1645 ±  5%     +26.3%       2078 ± 13%  interrupts.CPU1.CAL:Function_call_interrupts
     23121 ±  4%     -19.7%      18571        interrupts.CPU1.LOC:Local_timer_interrupts
      1766 ± 37%     -78.8%     374.25 ± 68%  interrupts.CPU1.NMI:Non-maskable_interrupts
      1766 ± 37%     -78.8%     374.25 ± 68%  interrupts.CPU1.PMI:Performance_monitoring_interrupts
     23143 ±  4%     -19.8%      18551        interrupts.CPU10.LOC:Local_timer_interrupts
    925.75 ± 33%     -74.9%     232.25 ±103%  interrupts.CPU10.NMI:Non-maskable_interrupts
    925.75 ± 33%     -74.9%     232.25 ±103%  interrupts.CPU10.PMI:Performance_monitoring_interrupts
     23077 ±  4%     -19.7%      18540        interrupts.CPU100.LOC:Local_timer_interrupts
      1133 ± 48%     -70.7%     332.75 ± 51%  interrupts.CPU100.NMI:Non-maskable_interrupts
      1133 ± 48%     -70.7%     332.75 ± 51%  interrupts.CPU100.PMI:Performance_monitoring_interrupts
     23108 ±  4%     -19.9%      18514        interrupts.CPU101.LOC:Local_timer_interrupts
     23142 ±  4%     -20.0%      18517        interrupts.CPU102.LOC:Local_timer_interrupts
      1161 ± 50%     -77.5%     261.50 ± 53%  interrupts.CPU102.NMI:Non-maskable_interrupts
      1161 ± 50%     -77.5%     261.50 ± 53%  interrupts.CPU102.PMI:Performance_monitoring_interrupts
     23180 ±  4%     -20.1%      18529        interrupts.CPU103.LOC:Local_timer_interrupts
      1062 ± 21%     -59.6%     429.25 ± 57%  interrupts.CPU103.NMI:Non-maskable_interrupts
      1062 ± 21%     -59.6%     429.25 ± 57%  interrupts.CPU103.PMI:Performance_monitoring_interrupts
     22855 ±  3%     -19.1%      18479        interrupts.CPU104.LOC:Local_timer_interrupts
      1185 ± 53%     -67.1%     389.50 ± 70%  interrupts.CPU104.NMI:Non-maskable_interrupts
      1185 ± 53%     -67.1%     389.50 ± 70%  interrupts.CPU104.PMI:Performance_monitoring_interrupts
     22911 ±  5%     -19.2%      18514        interrupts.CPU105.LOC:Local_timer_interrupts
    773.00 ± 46%     -65.0%     270.75 ± 77%  interrupts.CPU105.NMI:Non-maskable_interrupts
    773.00 ± 46%     -65.0%     270.75 ± 77%  interrupts.CPU105.PMI:Performance_monitoring_interrupts
     23046 ±  4%     -19.7%      18512        interrupts.CPU106.LOC:Local_timer_interrupts
      1934 ± 41%     -89.6%     200.50 ± 79%  interrupts.CPU106.NMI:Non-maskable_interrupts
      1934 ± 41%     -89.6%     200.50 ± 79%  interrupts.CPU106.PMI:Performance_monitoring_interrupts
     23107 ±  4%     -19.9%      18498        interrupts.CPU107.LOC:Local_timer_interrupts
      1379 ± 39%     -80.3%     272.50 ± 92%  interrupts.CPU107.NMI:Non-maskable_interrupts
      1379 ± 39%     -80.3%     272.50 ± 92%  interrupts.CPU107.PMI:Performance_monitoring_interrupts
     23099 ±  4%     -19.8%      18514        interrupts.CPU108.LOC:Local_timer_interrupts
     23161 ±  4%     -20.1%      18509        interrupts.CPU109.LOC:Local_timer_interrupts
      1515 ± 73%     -71.6%     430.50 ± 65%  interrupts.CPU109.NMI:Non-maskable_interrupts
      1515 ± 73%     -71.6%     430.50 ± 65%  interrupts.CPU109.PMI:Performance_monitoring_interrupts
     23126 ±  4%     -19.8%      18537        interrupts.CPU11.LOC:Local_timer_interrupts
      1476 ± 45%     -85.8%     209.75 ±126%  interrupts.CPU11.NMI:Non-maskable_interrupts
      1476 ± 45%     -85.8%     209.75 ±126%  interrupts.CPU11.PMI:Performance_monitoring_interrupts
     23095 ±  4%     -19.8%      18514        interrupts.CPU110.LOC:Local_timer_interrupts
      1726 ± 68%     -81.3%     323.75 ± 79%  interrupts.CPU110.NMI:Non-maskable_interrupts
      1726 ± 68%     -81.3%     323.75 ± 79%  interrupts.CPU110.PMI:Performance_monitoring_interrupts
     23124 ±  4%     -19.9%      18515        interrupts.CPU111.LOC:Local_timer_interrupts
      1332 ± 14%     -72.2%     370.25 ± 73%  interrupts.CPU111.NMI:Non-maskable_interrupts
      1332 ± 14%     -72.2%     370.25 ± 73%  interrupts.CPU111.PMI:Performance_monitoring_interrupts
     23160 ±  4%     -20.5%      18410 ±  2%  interrupts.CPU112.LOC:Local_timer_interrupts
      1389 ± 24%     -79.2%     288.75 ± 51%  interrupts.CPU112.NMI:Non-maskable_interrupts
      1389 ± 24%     -79.2%     288.75 ± 51%  interrupts.CPU112.PMI:Performance_monitoring_interrupts
     23116 ±  4%     -19.8%      18533        interrupts.CPU113.LOC:Local_timer_interrupts
      1764 ± 50%     -76.6%     413.50 ± 76%  interrupts.CPU113.NMI:Non-maskable_interrupts
      1764 ± 50%     -76.6%     413.50 ± 76%  interrupts.CPU113.PMI:Performance_monitoring_interrupts
     22961 ±  4%     -19.4%      18514        interrupts.CPU114.LOC:Local_timer_interrupts
    969.25 ± 38%     -78.9%     204.25 ± 78%  interrupts.CPU114.NMI:Non-maskable_interrupts
    969.25 ± 38%     -78.9%     204.25 ± 78%  interrupts.CPU114.PMI:Performance_monitoring_interrupts
     23122 ±  4%     -20.3%      18432        interrupts.CPU115.LOC:Local_timer_interrupts
     23116 ±  4%     -19.9%      18521        interrupts.CPU116.LOC:Local_timer_interrupts
     23132 ±  4%     -20.0%      18511        interrupts.CPU117.LOC:Local_timer_interrupts
      1119 ± 46%     -63.6%     407.50 ± 47%  interrupts.CPU117.NMI:Non-maskable_interrupts
      1119 ± 46%     -63.6%     407.50 ± 47%  interrupts.CPU117.PMI:Performance_monitoring_interrupts
     23120 ±  4%     -19.9%      18528        interrupts.CPU118.LOC:Local_timer_interrupts
    953.50 ± 38%     -75.1%     237.50 ± 97%  interrupts.CPU118.NMI:Non-maskable_interrupts
    953.50 ± 38%     -75.1%     237.50 ± 97%  interrupts.CPU118.PMI:Performance_monitoring_interrupts
     23155 ±  4%     -20.0%      18528        interrupts.CPU119.LOC:Local_timer_interrupts
     23003 ±  3%     -19.5%      18528        interrupts.CPU12.LOC:Local_timer_interrupts
      1494 ± 39%     -83.2%     251.00 ± 90%  interrupts.CPU12.NMI:Non-maskable_interrupts
      1494 ± 39%     -83.2%     251.00 ± 90%  interrupts.CPU12.PMI:Performance_monitoring_interrupts
     23150 ±  4%     -20.2%      18480        interrupts.CPU120.LOC:Local_timer_interrupts
     23204 ±  4%     -20.3%      18493        interrupts.CPU121.LOC:Local_timer_interrupts
      1924 ± 50%     -89.1%     209.75 ± 50%  interrupts.CPU121.NMI:Non-maskable_interrupts
      1924 ± 50%     -89.1%     209.75 ± 50%  interrupts.CPU121.PMI:Performance_monitoring_interrupts
     23193 ±  4%     -20.3%      18476        interrupts.CPU122.LOC:Local_timer_interrupts
      1987 ± 40%     -84.2%     313.25 ± 44%  interrupts.CPU122.NMI:Non-maskable_interrupts
      1987 ± 40%     -84.2%     313.25 ± 44%  interrupts.CPU122.PMI:Performance_monitoring_interrupts
     23166 ±  4%     -20.2%      18476        interrupts.CPU123.LOC:Local_timer_interrupts
      1313 ± 47%     -84.3%     206.00 ± 31%  interrupts.CPU123.NMI:Non-maskable_interrupts
      1313 ± 47%     -84.3%     206.00 ± 31%  interrupts.CPU123.PMI:Performance_monitoring_interrupts
     23196 ±  4%     -20.2%      18504        interrupts.CPU124.LOC:Local_timer_interrupts
      2151 ± 52%     -85.4%     313.50 ± 46%  interrupts.CPU124.NMI:Non-maskable_interrupts
      2151 ± 52%     -85.4%     313.50 ± 46%  interrupts.CPU124.PMI:Performance_monitoring_interrupts
     23179 ±  4%     -21.4%      18217 ±  2%  interrupts.CPU125.LOC:Local_timer_interrupts
      1837 ± 14%     -77.6%     410.75 ± 48%  interrupts.CPU125.NMI:Non-maskable_interrupts
      1837 ± 14%     -77.6%     410.75 ± 48%  interrupts.CPU125.PMI:Performance_monitoring_interrupts
     23169 ±  4%     -20.2%      18489        interrupts.CPU126.LOC:Local_timer_interrupts
      2582 ± 31%     -86.4%     350.00 ± 58%  interrupts.CPU126.NMI:Non-maskable_interrupts
      2582 ± 31%     -86.4%     350.00 ± 58%  interrupts.CPU126.PMI:Performance_monitoring_interrupts
     23183 ±  4%     -20.2%      18495        interrupts.CPU127.LOC:Local_timer_interrupts
      2076 ± 36%     -87.9%     251.75 ± 53%  interrupts.CPU127.NMI:Non-maskable_interrupts
      2076 ± 36%     -87.9%     251.75 ± 53%  interrupts.CPU127.PMI:Performance_monitoring_interrupts
     23170 ±  4%     -21.2%      18262 ±  2%  interrupts.CPU128.LOC:Local_timer_interrupts
     23212 ±  3%     -20.1%      18545        interrupts.CPU129.LOC:Local_timer_interrupts
      2250 ± 33%     -86.4%     305.00 ± 52%  interrupts.CPU129.NMI:Non-maskable_interrupts
      2250 ± 33%     -86.4%     305.00 ± 52%  interrupts.CPU129.PMI:Performance_monitoring_interrupts
     23154 ±  4%     -19.9%      18545        interrupts.CPU13.LOC:Local_timer_interrupts
      1228 ± 23%     -78.9%     258.75 ± 90%  interrupts.CPU13.NMI:Non-maskable_interrupts
      1228 ± 23%     -78.9%     258.75 ± 90%  interrupts.CPU13.PMI:Performance_monitoring_interrupts
     23176 ±  4%     -20.2%      18499        interrupts.CPU130.LOC:Local_timer_interrupts
      2568 ±  5%     -89.6%     266.75 ± 57%  interrupts.CPU130.NMI:Non-maskable_interrupts
      2568 ±  5%     -89.6%     266.75 ± 57%  interrupts.CPU130.PMI:Performance_monitoring_interrupts
     23178 ±  4%     -20.2%      18487        interrupts.CPU131.LOC:Local_timer_interrupts
      1726 ± 38%     -77.5%     387.50 ± 22%  interrupts.CPU131.NMI:Non-maskable_interrupts
      1726 ± 38%     -77.5%     387.50 ± 22%  interrupts.CPU131.PMI:Performance_monitoring_interrupts
     23177 ±  4%     -20.4%      18443        interrupts.CPU132.LOC:Local_timer_interrupts
      1924 ± 42%     -84.0%     308.25 ± 53%  interrupts.CPU132.NMI:Non-maskable_interrupts
      1924 ± 42%     -84.0%     308.25 ± 53%  interrupts.CPU132.PMI:Performance_monitoring_interrupts
     23178 ±  4%     -20.1%      18528        interrupts.CPU133.LOC:Local_timer_interrupts
      2300 ± 30%     -89.9%     232.00 ± 49%  interrupts.CPU133.NMI:Non-maskable_interrupts
      2300 ± 30%     -89.9%     232.00 ± 49%  interrupts.CPU133.PMI:Performance_monitoring_interrupts
     23210 ±  4%     -20.3%      18495        interrupts.CPU134.LOC:Local_timer_interrupts
      1610 ± 46%     -84.2%     255.25 ± 34%  interrupts.CPU134.NMI:Non-maskable_interrupts
      1610 ± 46%     -84.2%     255.25 ± 34%  interrupts.CPU134.PMI:Performance_monitoring_interrupts
     23163 ±  4%     -20.2%      18488        interrupts.CPU135.LOC:Local_timer_interrupts
      1094 ± 25%     -83.3%     183.00 ± 90%  interrupts.CPU135.NMI:Non-maskable_interrupts
      1094 ± 25%     -83.3%     183.00 ± 90%  interrupts.CPU135.PMI:Performance_monitoring_interrupts
     23178 ±  4%     -20.2%      18506        interrupts.CPU136.LOC:Local_timer_interrupts
      1886 ± 47%     -88.7%     212.75 ± 56%  interrupts.CPU136.NMI:Non-maskable_interrupts
      1886 ± 47%     -88.7%     212.75 ± 56%  interrupts.CPU136.PMI:Performance_monitoring_interrupts
     23192 ±  4%     -20.3%      18490        interrupts.CPU137.LOC:Local_timer_interrupts
      1386 ± 51%     -80.0%     277.00 ± 38%  interrupts.CPU137.NMI:Non-maskable_interrupts
      1386 ± 51%     -80.0%     277.00 ± 38%  interrupts.CPU137.PMI:Performance_monitoring_interrupts
     23028 ±  4%     -19.7%      18490        interrupts.CPU138.LOC:Local_timer_interrupts
      1388 ± 42%     -76.6%     324.50 ± 49%  interrupts.CPU138.NMI:Non-maskable_interrupts
      1388 ± 42%     -76.6%     324.50 ± 49%  interrupts.CPU138.PMI:Performance_monitoring_interrupts
     23156 ±  4%     -20.1%      18499        interrupts.CPU139.LOC:Local_timer_interrupts
      1652 ± 54%     -81.6%     304.75 ± 69%  interrupts.CPU139.NMI:Non-maskable_interrupts
      1652 ± 54%     -81.6%     304.75 ± 69%  interrupts.CPU139.PMI:Performance_monitoring_interrupts
     23156 ±  4%     -19.9%      18546        interrupts.CPU14.LOC:Local_timer_interrupts
      2553 ± 48%     -89.2%     274.75 ± 76%  interrupts.CPU14.NMI:Non-maskable_interrupts
      2553 ± 48%     -89.2%     274.75 ± 76%  interrupts.CPU14.PMI:Performance_monitoring_interrupts
     23148 ±  4%     -20.1%      18492        interrupts.CPU140.LOC:Local_timer_interrupts
      1195 ± 31%     -89.9%     121.25 ± 44%  interrupts.CPU140.NMI:Non-maskable_interrupts
      1195 ± 31%     -89.9%     121.25 ± 44%  interrupts.CPU140.PMI:Performance_monitoring_interrupts
     23174 ±  4%     -20.1%      18517        interrupts.CPU141.LOC:Local_timer_interrupts
      1416 ± 41%     -94.0%      85.00 ± 16%  interrupts.CPU141.NMI:Non-maskable_interrupts
      1416 ± 41%     -94.0%      85.00 ± 16%  interrupts.CPU141.PMI:Performance_monitoring_interrupts
     23144 ±  4%     -20.1%      18487        interrupts.CPU142.LOC:Local_timer_interrupts
      1862 ± 21%     -95.0%      93.00 ± 25%  interrupts.CPU142.NMI:Non-maskable_interrupts
      1862 ± 21%     -95.0%      93.00 ± 25%  interrupts.CPU142.PMI:Performance_monitoring_interrupts
     23189 ±  4%     -20.3%      18486        interrupts.CPU143.LOC:Local_timer_interrupts
      1522 ± 22%     -87.0%     198.25 ± 70%  interrupts.CPU143.NMI:Non-maskable_interrupts
      1522 ± 22%     -87.0%     198.25 ± 70%  interrupts.CPU143.PMI:Performance_monitoring_interrupts
     23359 ±  4%     -20.9%      18488        interrupts.CPU144.LOC:Local_timer_interrupts
      1470 ± 19%     -84.9%     222.00 ± 62%  interrupts.CPU144.NMI:Non-maskable_interrupts
      1470 ± 19%     -84.9%     222.00 ± 62%  interrupts.CPU144.PMI:Performance_monitoring_interrupts
     23305 ±  4%     -20.6%      18501        interrupts.CPU145.LOC:Local_timer_interrupts
      1917 ± 37%     -92.1%     152.00 ± 46%  interrupts.CPU145.NMI:Non-maskable_interrupts
      1917 ± 37%     -92.1%     152.00 ± 46%  interrupts.CPU145.PMI:Performance_monitoring_interrupts
     23314 ±  4%     -21.5%      18311 ±  2%  interrupts.CPU146.LOC:Local_timer_interrupts
     23221 ±  4%     -20.4%      18476        interrupts.CPU147.LOC:Local_timer_interrupts
      2393 ± 41%     -86.9%     314.00 ± 98%  interrupts.CPU147.NMI:Non-maskable_interrupts
      2393 ± 41%     -86.9%     314.00 ± 98%  interrupts.CPU147.PMI:Performance_monitoring_interrupts
     23233 ±  4%     -20.6%      18452        interrupts.CPU148.LOC:Local_timer_interrupts
      2315 ± 46%     -87.1%     297.75 ± 38%  interrupts.CPU148.NMI:Non-maskable_interrupts
      2315 ± 46%     -87.1%     297.75 ± 38%  interrupts.CPU148.PMI:Performance_monitoring_interrupts
     23296 ±  4%     -20.6%      18486        interrupts.CPU149.LOC:Local_timer_interrupts
      1695 ± 31%     -74.8%     427.50 ± 34%  interrupts.CPU149.NMI:Non-maskable_interrupts
      1695 ± 31%     -74.8%     427.50 ± 34%  interrupts.CPU149.PMI:Performance_monitoring_interrupts
     23126 ±  4%     -19.8%      18538        interrupts.CPU15.LOC:Local_timer_interrupts
      1557 ± 20%     -84.1%     247.25 ± 79%  interrupts.CPU15.NMI:Non-maskable_interrupts
      1557 ± 20%     -84.1%     247.25 ± 79%  interrupts.CPU15.PMI:Performance_monitoring_interrupts
     23315 ±  4%     -20.8%      18468        interrupts.CPU150.LOC:Local_timer_interrupts
      1703 ± 32%     -90.5%     161.75 ± 16%  interrupts.CPU150.NMI:Non-maskable_interrupts
      1703 ± 32%     -90.5%     161.75 ± 16%  interrupts.CPU150.PMI:Performance_monitoring_interrupts
     23307 ±  4%     -20.7%      18487        interrupts.CPU151.LOC:Local_timer_interrupts
      1097 ± 39%     -82.7%     189.75 ± 37%  interrupts.CPU151.NMI:Non-maskable_interrupts
      1097 ± 39%     -82.7%     189.75 ± 37%  interrupts.CPU151.PMI:Performance_monitoring_interrupts
     23319 ±  4%     -20.5%      18536        interrupts.CPU152.LOC:Local_timer_interrupts
      1561 ± 27%     -84.1%     248.00 ± 28%  interrupts.CPU152.NMI:Non-maskable_interrupts
      1561 ± 27%     -84.1%     248.00 ± 28%  interrupts.CPU152.PMI:Performance_monitoring_interrupts
     23296 ±  4%     -20.6%      18496        interrupts.CPU153.LOC:Local_timer_interrupts
      1853 ± 44%     -88.3%     217.25 ± 37%  interrupts.CPU153.NMI:Non-maskable_interrupts
      1853 ± 44%     -88.3%     217.25 ± 37%  interrupts.CPU153.PMI:Performance_monitoring_interrupts
     23309 ±  4%     -20.9%      18427        interrupts.CPU154.LOC:Local_timer_interrupts
      1557 ± 31%     -85.1%     232.75 ± 79%  interrupts.CPU154.NMI:Non-maskable_interrupts
      1557 ± 31%     -85.1%     232.75 ± 79%  interrupts.CPU154.PMI:Performance_monitoring_interrupts
     23301 ±  4%     -20.7%      18469        interrupts.CPU155.LOC:Local_timer_interrupts
      1314 ± 17%     -79.8%     265.00 ± 51%  interrupts.CPU155.NMI:Non-maskable_interrupts
      1314 ± 17%     -79.8%     265.00 ± 51%  interrupts.CPU155.PMI:Performance_monitoring_interrupts
     23209 ±  4%     -20.3%      18486        interrupts.CPU156.LOC:Local_timer_interrupts
      2088 ± 52%     -78.4%     450.25 ± 83%  interrupts.CPU156.NMI:Non-maskable_interrupts
      2088 ± 52%     -78.4%     450.25 ± 83%  interrupts.CPU156.PMI:Performance_monitoring_interrupts
     23333 ±  4%     -20.8%      18490        interrupts.CPU157.LOC:Local_timer_interrupts
      1879 ± 46%     -87.9%     227.25 ± 39%  interrupts.CPU157.NMI:Non-maskable_interrupts
      1879 ± 46%     -87.9%     227.25 ± 39%  interrupts.CPU157.PMI:Performance_monitoring_interrupts
     23306 ±  4%     -20.7%      18492        interrupts.CPU158.LOC:Local_timer_interrupts
      1470 ± 34%     -85.0%     220.75 ± 65%  interrupts.CPU158.NMI:Non-maskable_interrupts
      1470 ± 34%     -85.0%     220.75 ± 65%  interrupts.CPU158.PMI:Performance_monitoring_interrupts
     23252 ±  4%     -20.4%      18500        interrupts.CPU159.LOC:Local_timer_interrupts
     23169 ±  4%     -20.1%      18517        interrupts.CPU16.LOC:Local_timer_interrupts
      1632 ± 82%     -86.9%     214.50 ± 75%  interrupts.CPU16.NMI:Non-maskable_interrupts
      1632 ± 82%     -86.9%     214.50 ± 75%  interrupts.CPU16.PMI:Performance_monitoring_interrupts
     23325 ±  4%     -20.6%      18509        interrupts.CPU160.LOC:Local_timer_interrupts
      1717 ± 55%     -82.2%     305.00 ± 67%  interrupts.CPU160.NMI:Non-maskable_interrupts
      1717 ± 55%     -82.2%     305.00 ± 67%  interrupts.CPU160.PMI:Performance_monitoring_interrupts
     23310 ±  4%     -20.6%      18496        interrupts.CPU161.LOC:Local_timer_interrupts
      2079 ± 35%     -86.4%     283.75 ± 74%  interrupts.CPU161.NMI:Non-maskable_interrupts
      2079 ± 35%     -86.4%     283.75 ± 74%  interrupts.CPU161.PMI:Performance_monitoring_interrupts
     23305 ±  4%     -20.6%      18515        interrupts.CPU162.LOC:Local_timer_interrupts
      1109 ± 57%     -84.7%     169.50 ± 51%  interrupts.CPU162.NMI:Non-maskable_interrupts
      1109 ± 57%     -84.7%     169.50 ± 51%  interrupts.CPU162.PMI:Performance_monitoring_interrupts
     23359 ±  4%     -20.9%      18486        interrupts.CPU163.LOC:Local_timer_interrupts
      1389 ± 32%     -82.9%     237.50 ± 77%  interrupts.CPU163.NMI:Non-maskable_interrupts
      1389 ± 32%     -82.9%     237.50 ± 77%  interrupts.CPU163.PMI:Performance_monitoring_interrupts
     22983 ±  6%     -19.6%      18484        interrupts.CPU164.LOC:Local_timer_interrupts
    917.00 ± 33%     -83.3%     153.00 ± 66%  interrupts.CPU164.NMI:Non-maskable_interrupts
    917.00 ± 33%     -83.3%     153.00 ± 66%  interrupts.CPU164.PMI:Performance_monitoring_interrupts
     23320 ±  4%     -20.7%      18486        interrupts.CPU165.LOC:Local_timer_interrupts
      1564 ± 52%     -90.6%     147.75 ± 72%  interrupts.CPU165.NMI:Non-maskable_interrupts
      1564 ± 52%     -90.6%     147.75 ± 72%  interrupts.CPU165.PMI:Performance_monitoring_interrupts
     23321 ±  4%     -20.8%      18481        interrupts.CPU166.LOC:Local_timer_interrupts
      1811 ± 36%     -90.7%     168.50 ± 73%  interrupts.CPU166.NMI:Non-maskable_interrupts
      1811 ± 36%     -90.7%     168.50 ± 73%  interrupts.CPU166.PMI:Performance_monitoring_interrupts
     23306 ±  4%     -20.6%      18501        interrupts.CPU167.LOC:Local_timer_interrupts
      2062 ± 16%     -89.5%     216.25 ± 22%  interrupts.CPU167.NMI:Non-maskable_interrupts
      2062 ± 16%     -89.5%     216.25 ± 22%  interrupts.CPU167.PMI:Performance_monitoring_interrupts
     23116 ±  4%     -19.9%      18517        interrupts.CPU168.LOC:Local_timer_interrupts
      2226 ± 18%     -77.7%     496.00 ± 48%  interrupts.CPU168.NMI:Non-maskable_interrupts
      2226 ± 18%     -77.7%     496.00 ± 48%  interrupts.CPU168.PMI:Performance_monitoring_interrupts
     23138 ±  4%     -19.9%      18537        interrupts.CPU169.LOC:Local_timer_interrupts
      1943 ± 31%     -78.4%     420.50 ± 21%  interrupts.CPU169.NMI:Non-maskable_interrupts
      1943 ± 31%     -78.4%     420.50 ± 21%  interrupts.CPU169.PMI:Performance_monitoring_interrupts
     23073 ±  3%     -19.7%      18535        interrupts.CPU17.LOC:Local_timer_interrupts
     23133 ±  4%     -20.0%      18509        interrupts.CPU170.LOC:Local_timer_interrupts
      2460 ± 20%     -80.5%     480.00 ± 76%  interrupts.CPU170.NMI:Non-maskable_interrupts
      2460 ± 20%     -80.5%     480.00 ± 76%  interrupts.CPU170.PMI:Performance_monitoring_interrupts
     23109 ±  4%     -20.0%      18483        interrupts.CPU171.LOC:Local_timer_interrupts
      2245 ± 26%     -82.4%     396.00 ± 56%  interrupts.CPU171.NMI:Non-maskable_interrupts
      2245 ± 26%     -82.4%     396.00 ± 56%  interrupts.CPU171.PMI:Performance_monitoring_interrupts
     23080 ±  4%     -19.9%      18495        interrupts.CPU172.LOC:Local_timer_interrupts
      2400 ± 21%     -85.7%     342.75 ± 51%  interrupts.CPU172.NMI:Non-maskable_interrupts
      2400 ± 21%     -85.7%     342.75 ± 51%  interrupts.CPU172.PMI:Performance_monitoring_interrupts
     23076 ±  4%     -20.0%      18463        interrupts.CPU173.LOC:Local_timer_interrupts
     23106 ±  4%     -19.9%      18497        interrupts.CPU174.LOC:Local_timer_interrupts
      1858 ± 69%     -88.1%     220.50 ± 45%  interrupts.CPU174.NMI:Non-maskable_interrupts
      1858 ± 69%     -88.1%     220.50 ± 45%  interrupts.CPU174.PMI:Performance_monitoring_interrupts
     23095 ±  4%     -19.9%      18503        interrupts.CPU175.LOC:Local_timer_interrupts
      1472 ± 34%     -82.2%     261.50 ± 54%  interrupts.CPU175.NMI:Non-maskable_interrupts
      1472 ± 34%     -82.2%     261.50 ± 54%  interrupts.CPU175.PMI:Performance_monitoring_interrupts
     23097 ±  4%     -19.8%      18515        interrupts.CPU176.LOC:Local_timer_interrupts
      1743 ± 66%     -80.9%     332.25 ± 54%  interrupts.CPU176.NMI:Non-maskable_interrupts
      1743 ± 66%     -80.9%     332.25 ± 54%  interrupts.CPU176.PMI:Performance_monitoring_interrupts
     23079 ±  4%     -19.8%      18517        interrupts.CPU177.LOC:Local_timer_interrupts
      1728 ± 34%     -82.3%     306.25 ± 70%  interrupts.CPU177.NMI:Non-maskable_interrupts
      1728 ± 34%     -82.3%     306.25 ± 70%  interrupts.CPU177.PMI:Performance_monitoring_interrupts
     23090 ±  4%     -19.9%      18492        interrupts.CPU178.LOC:Local_timer_interrupts
      1340 ± 38%     -81.7%     245.75 ± 57%  interrupts.CPU178.NMI:Non-maskable_interrupts
      1340 ± 38%     -81.7%     245.75 ± 57%  interrupts.CPU178.PMI:Performance_monitoring_interrupts
     23058 ±  4%     -19.7%      18517        interrupts.CPU179.LOC:Local_timer_interrupts
      1562 ± 49%     -85.2%     230.50 ± 59%  interrupts.CPU179.NMI:Non-maskable_interrupts
      1562 ± 49%     -85.2%     230.50 ± 59%  interrupts.CPU179.PMI:Performance_monitoring_interrupts
     23131 ±  4%     -19.9%      18536        interrupts.CPU18.LOC:Local_timer_interrupts
    952.50 ± 58%     -79.8%     192.25 ±102%  interrupts.CPU18.NMI:Non-maskable_interrupts
    952.50 ± 58%     -79.8%     192.25 ±102%  interrupts.CPU18.PMI:Performance_monitoring_interrupts
     23048 ±  4%     -19.7%      18506        interrupts.CPU180.LOC:Local_timer_interrupts
      1562 ± 51%     -77.5%     352.25 ± 72%  interrupts.CPU180.NMI:Non-maskable_interrupts
      1562 ± 51%     -77.5%     352.25 ± 72%  interrupts.CPU180.PMI:Performance_monitoring_interrupts
     23102 ±  4%     -19.9%      18507        interrupts.CPU181.LOC:Local_timer_interrupts
      1875 ± 49%     -89.6%     195.50 ± 48%  interrupts.CPU181.NMI:Non-maskable_interrupts
      1875 ± 49%     -89.6%     195.50 ± 48%  interrupts.CPU181.PMI:Performance_monitoring_interrupts
     23128 ±  3%     -20.1%      18480        interrupts.CPU182.LOC:Local_timer_interrupts
      1295 ± 18%     -78.0%     285.25 ± 64%  interrupts.CPU182.NMI:Non-maskable_interrupts
      1295 ± 18%     -78.0%     285.25 ± 64%  interrupts.CPU182.PMI:Performance_monitoring_interrupts
     23047 ±  4%     -19.6%      18526        interrupts.CPU183.LOC:Local_timer_interrupts
      2074 ± 42%     -92.4%     157.00 ± 33%  interrupts.CPU183.NMI:Non-maskable_interrupts
      2074 ± 42%     -92.4%     157.00 ± 33%  interrupts.CPU183.PMI:Performance_monitoring_interrupts
     23114 ±  4%     -20.0%      18490        interrupts.CPU184.LOC:Local_timer_interrupts
      1498 ± 26%     -81.3%     280.50 ± 52%  interrupts.CPU184.NMI:Non-maskable_interrupts
      1498 ± 26%     -81.3%     280.50 ± 52%  interrupts.CPU184.PMI:Performance_monitoring_interrupts
     23087 ±  4%     -20.1%      18458        interrupts.CPU185.LOC:Local_timer_interrupts
      2025 ± 32%     -86.2%     279.50 ± 69%  interrupts.CPU185.NMI:Non-maskable_interrupts
      2025 ± 32%     -86.2%     279.50 ± 69%  interrupts.CPU185.PMI:Performance_monitoring_interrupts
     23094 ±  4%     -19.9%      18500        interrupts.CPU186.LOC:Local_timer_interrupts
      2247 ± 47%     -80.3%     442.00 ± 59%  interrupts.CPU186.NMI:Non-maskable_interrupts
      2247 ± 47%     -80.3%     442.00 ± 59%  interrupts.CPU186.PMI:Performance_monitoring_interrupts
     23090 ±  4%     -19.9%      18485        interrupts.CPU187.LOC:Local_timer_interrupts
      1558 ± 27%     -85.9%     219.00 ± 85%  interrupts.CPU187.NMI:Non-maskable_interrupts
      1558 ± 27%     -85.9%     219.00 ± 85%  interrupts.CPU187.PMI:Performance_monitoring_interrupts
     23069 ±  4%     -19.8%      18501        interrupts.CPU188.LOC:Local_timer_interrupts
      2242 ± 21%     -87.6%     277.00 ±101%  interrupts.CPU188.NMI:Non-maskable_interrupts
      2242 ± 21%     -87.6%     277.00 ±101%  interrupts.CPU188.PMI:Performance_monitoring_interrupts
     23097 ±  4%     -19.9%      18501        interrupts.CPU189.LOC:Local_timer_interrupts
      1851 ± 31%     -87.7%     228.25 ±113%  interrupts.CPU189.NMI:Non-maskable_interrupts
      1851 ± 31%     -87.7%     228.25 ±113%  interrupts.CPU189.PMI:Performance_monitoring_interrupts
     23168 ±  4%     -20.7%      18382        interrupts.CPU19.LOC:Local_timer_interrupts
     23074 ±  4%     -19.9%      18493        interrupts.CPU190.LOC:Local_timer_interrupts
      1806 ± 75%     -90.1%     178.25 ± 87%  interrupts.CPU190.NMI:Non-maskable_interrupts
      1806 ± 75%     -90.1%     178.25 ± 87%  interrupts.CPU190.PMI:Performance_monitoring_interrupts
     23122 ±  4%     -19.9%      18515        interrupts.CPU191.LOC:Local_timer_interrupts
      1992 ± 30%     -85.2%     294.75 ± 74%  interrupts.CPU191.NMI:Non-maskable_interrupts
      1992 ± 30%     -85.2%     294.75 ± 74%  interrupts.CPU191.PMI:Performance_monitoring_interrupts
     23161 ±  4%     -20.2%      18477        interrupts.CPU2.LOC:Local_timer_interrupts
      2040 ± 21%     -81.6%     376.00 ± 72%  interrupts.CPU2.NMI:Non-maskable_interrupts
      2040 ± 21%     -81.6%     376.00 ± 72%  interrupts.CPU2.PMI:Performance_monitoring_interrupts
     23144 ±  4%     -19.7%      18578        interrupts.CPU20.LOC:Local_timer_interrupts
     23073 ±  3%     -19.7%      18527        interrupts.CPU21.LOC:Local_timer_interrupts
     23170 ±  3%     -20.2%      18483        interrupts.CPU22.LOC:Local_timer_interrupts
    932.25 ± 59%     -72.6%     255.00 ± 89%  interrupts.CPU22.NMI:Non-maskable_interrupts
    932.25 ± 59%     -72.6%     255.00 ± 89%  interrupts.CPU22.PMI:Performance_monitoring_interrupts
     23131 ±  4%     -19.9%      18526        interrupts.CPU23.LOC:Local_timer_interrupts
      1196 ± 34%     -73.8%     313.50 ± 75%  interrupts.CPU23.NMI:Non-maskable_interrupts
      1196 ± 34%     -73.8%     313.50 ± 75%  interrupts.CPU23.PMI:Performance_monitoring_interrupts
     23190 ±  4%     -20.3%      18488        interrupts.CPU24.LOC:Local_timer_interrupts
     23217 ±  4%     -20.2%      18522        interrupts.CPU25.LOC:Local_timer_interrupts
      1205 ± 16%     -77.0%     277.50 ± 25%  interrupts.CPU25.NMI:Non-maskable_interrupts
      1205 ± 16%     -77.0%     277.50 ± 25%  interrupts.CPU25.PMI:Performance_monitoring_interrupts
     23190 ±  4%     -19.9%      18565        interrupts.CPU26.LOC:Local_timer_interrupts
      2101 ± 36%     -86.1%     291.75 ± 44%  interrupts.CPU26.NMI:Non-maskable_interrupts
      2101 ± 36%     -86.1%     291.75 ± 44%  interrupts.CPU26.PMI:Performance_monitoring_interrupts
     23145 ±  4%     -20.0%      18523        interrupts.CPU27.LOC:Local_timer_interrupts
      2112 ± 12%     -90.2%     207.25 ± 46%  interrupts.CPU27.NMI:Non-maskable_interrupts
      2112 ± 12%     -90.2%     207.25 ± 46%  interrupts.CPU27.PMI:Performance_monitoring_interrupts
     23207 ±  4%     -20.3%      18485        interrupts.CPU28.LOC:Local_timer_interrupts
      1614 ± 62%     -86.3%     221.75 ± 28%  interrupts.CPU28.NMI:Non-maskable_interrupts
      1614 ± 62%     -86.3%     221.75 ± 28%  interrupts.CPU28.PMI:Performance_monitoring_interrupts
     23170 ±  4%     -20.1%      18501        interrupts.CPU29.LOC:Local_timer_interrupts
      1560 ± 18%     -81.0%     296.25 ± 65%  interrupts.CPU29.NMI:Non-maskable_interrupts
      1560 ± 18%     -81.0%     296.25 ± 65%  interrupts.CPU29.PMI:Performance_monitoring_interrupts
     23140 ±  4%     -20.0%      18515        interrupts.CPU3.LOC:Local_timer_interrupts
      2069 ± 43%     -81.3%     386.25 ± 57%  interrupts.CPU3.NMI:Non-maskable_interrupts
      2069 ± 43%     -81.3%     386.25 ± 57%  interrupts.CPU3.PMI:Performance_monitoring_interrupts
     23182 ±  4%     -20.1%      18528        interrupts.CPU30.LOC:Local_timer_interrupts
      1574 ± 54%     -84.9%     238.25 ± 41%  interrupts.CPU30.NMI:Non-maskable_interrupts
      1574 ± 54%     -84.9%     238.25 ± 41%  interrupts.CPU30.PMI:Performance_monitoring_interrupts
     23192 ±  4%     -20.2%      18505        interrupts.CPU31.LOC:Local_timer_interrupts
      1589 ± 56%     -75.0%     397.25 ± 47%  interrupts.CPU31.NMI:Non-maskable_interrupts
      1589 ± 56%     -75.0%     397.25 ± 47%  interrupts.CPU31.PMI:Performance_monitoring_interrupts
     23199 ±  4%     -20.5%      18454        interrupts.CPU32.LOC:Local_timer_interrupts
      2525 ± 14%     -81.6%     464.00 ± 84%  interrupts.CPU32.NMI:Non-maskable_interrupts
      2525 ± 14%     -81.6%     464.00 ± 84%  interrupts.CPU32.PMI:Performance_monitoring_interrupts
     23179 ±  4%     -20.7%      18378 ±  2%  interrupts.CPU33.LOC:Local_timer_interrupts
      2080 ± 52%     -89.6%     216.50 ± 38%  interrupts.CPU33.NMI:Non-maskable_interrupts
      2080 ± 52%     -89.6%     216.50 ± 38%  interrupts.CPU33.PMI:Performance_monitoring_interrupts
     23191 ±  3%     -20.1%      18524        interrupts.CPU34.LOC:Local_timer_interrupts
      2377 ± 36%     -93.4%     155.75 ± 21%  interrupts.CPU34.NMI:Non-maskable_interrupts
      2377 ± 36%     -93.4%     155.75 ± 21%  interrupts.CPU34.PMI:Performance_monitoring_interrupts
     23197 ±  4%     -20.2%      18517        interrupts.CPU35.LOC:Local_timer_interrupts
      2500 ± 25%     -87.9%     301.50 ± 46%  interrupts.CPU35.NMI:Non-maskable_interrupts
      2500 ± 25%     -87.9%     301.50 ± 46%  interrupts.CPU35.PMI:Performance_monitoring_interrupts
     23203 ±  4%     -20.3%      18504        interrupts.CPU36.LOC:Local_timer_interrupts
      1763 ± 54%     -88.7%     199.25 ± 62%  interrupts.CPU36.NMI:Non-maskable_interrupts
      1763 ± 54%     -88.7%     199.25 ± 62%  interrupts.CPU36.PMI:Performance_monitoring_interrupts
     23218 ±  4%     -20.4%      18492        interrupts.CPU37.LOC:Local_timer_interrupts
      2348 ± 12%     -94.3%     133.75 ± 18%  interrupts.CPU37.NMI:Non-maskable_interrupts
      2348 ± 12%     -94.3%     133.75 ± 18%  interrupts.CPU37.PMI:Performance_monitoring_interrupts
     23195 ±  4%     -20.4%      18461        interrupts.CPU38.LOC:Local_timer_interrupts
      1275 ± 52%     -85.3%     187.75 ± 32%  interrupts.CPU38.NMI:Non-maskable_interrupts
      1275 ± 52%     -85.3%     187.75 ± 32%  interrupts.CPU38.PMI:Performance_monitoring_interrupts
     23169 ±  4%     -20.1%      18514        interrupts.CPU39.LOC:Local_timer_interrupts
      1892 ± 57%     -93.2%     128.50 ± 55%  interrupts.CPU39.NMI:Non-maskable_interrupts
      1892 ± 57%     -93.2%     128.50 ± 55%  interrupts.CPU39.PMI:Performance_monitoring_interrupts
     23138 ±  4%     -19.9%      18539        interrupts.CPU4.LOC:Local_timer_interrupts
      1620 ± 38%     -84.4%     253.00 ± 94%  interrupts.CPU4.NMI:Non-maskable_interrupts
      1620 ± 38%     -84.4%     253.00 ± 94%  interrupts.CPU4.PMI:Performance_monitoring_interrupts
     23215 ±  4%     -20.3%      18510        interrupts.CPU40.LOC:Local_timer_interrupts
      1664 ± 55%     -87.9%     201.00 ± 33%  interrupts.CPU40.NMI:Non-maskable_interrupts
      1664 ± 55%     -87.9%     201.00 ± 33%  interrupts.CPU40.PMI:Performance_monitoring_interrupts
     23174 ±  4%     -20.2%      18492        interrupts.CPU41.LOC:Local_timer_interrupts
      1716 ± 30%     -85.8%     243.00 ± 50%  interrupts.CPU41.NMI:Non-maskable_interrupts
      1716 ± 30%     -85.8%     243.00 ± 50%  interrupts.CPU41.PMI:Performance_monitoring_interrupts
     23159 ±  4%     -20.1%      18505        interrupts.CPU42.LOC:Local_timer_interrupts
      1981 ± 33%     -89.7%     204.25 ± 21%  interrupts.CPU42.NMI:Non-maskable_interrupts
      1981 ± 33%     -89.7%     204.25 ± 21%  interrupts.CPU42.PMI:Performance_monitoring_interrupts
     23199 ±  4%     -20.3%      18497        interrupts.CPU43.LOC:Local_timer_interrupts
      1623 ± 26%     -87.1%     209.50 ± 70%  interrupts.CPU43.NMI:Non-maskable_interrupts
      1623 ± 26%     -87.1%     209.50 ± 70%  interrupts.CPU43.PMI:Performance_monitoring_interrupts
     23189 ±  4%     -20.1%      18519        interrupts.CPU44.LOC:Local_timer_interrupts
      1585 ± 58%     -93.7%     100.50 ± 16%  interrupts.CPU44.NMI:Non-maskable_interrupts
      1585 ± 58%     -93.7%     100.50 ± 16%  interrupts.CPU44.PMI:Performance_monitoring_interrupts
     23199 ±  4%     -20.3%      18492        interrupts.CPU45.LOC:Local_timer_interrupts
      1943 ± 37%     -95.1%      96.00 ± 17%  interrupts.CPU45.NMI:Non-maskable_interrupts
      1943 ± 37%     -95.1%      96.00 ± 17%  interrupts.CPU45.PMI:Performance_monitoring_interrupts
     23145 ±  4%     -20.1%      18496        interrupts.CPU46.LOC:Local_timer_interrupts
      2048 ± 39%     -94.9%     104.00 ± 20%  interrupts.CPU46.NMI:Non-maskable_interrupts
      2048 ± 39%     -94.9%     104.00 ± 20%  interrupts.CPU46.PMI:Performance_monitoring_interrupts
     23206 ±  4%     -20.2%      18510        interrupts.CPU47.LOC:Local_timer_interrupts
      2524 ± 17%     -92.3%     193.75 ± 96%  interrupts.CPU47.NMI:Non-maskable_interrupts
      2524 ± 17%     -92.3%     193.75 ± 96%  interrupts.CPU47.PMI:Performance_monitoring_interrupts
     23286 ±  4%     -21.0%      18392 ±  2%  interrupts.CPU48.LOC:Local_timer_interrupts
      2421 ± 14%     -90.5%     231.00 ± 49%  interrupts.CPU48.NMI:Non-maskable_interrupts
      2421 ± 14%     -90.5%     231.00 ± 49%  interrupts.CPU48.PMI:Performance_monitoring_interrupts
     23289 ±  4%     -20.7%      18467        interrupts.CPU49.LOC:Local_timer_interrupts
      2362 ± 27%     -91.3%     205.50 ± 44%  interrupts.CPU49.NMI:Non-maskable_interrupts
      2362 ± 27%     -91.3%     205.50 ± 44%  interrupts.CPU49.PMI:Performance_monitoring_interrupts
     23061 ±  3%     -19.5%      18569        interrupts.CPU5.LOC:Local_timer_interrupts
      1800 ± 27%     -79.2%     375.00 ± 99%  interrupts.CPU5.NMI:Non-maskable_interrupts
      1800 ± 27%     -79.2%     375.00 ± 99%  interrupts.CPU5.PMI:Performance_monitoring_interrupts
     23307 ±  4%     -21.1%      18398 ±  2%  interrupts.CPU50.LOC:Local_timer_interrupts
     23337 ±  4%     -20.8%      18492        interrupts.CPU51.LOC:Local_timer_interrupts
      1728 ±  9%     -82.6%     301.50 ± 33%  interrupts.CPU51.NMI:Non-maskable_interrupts
      1728 ±  9%     -82.6%     301.50 ± 33%  interrupts.CPU51.PMI:Performance_monitoring_interrupts
     23181 ±  4%     -20.2%      18506        interrupts.CPU52.LOC:Local_timer_interrupts
      1150 ±  7%     -68.7%     359.75 ± 39%  interrupts.CPU52.NMI:Non-maskable_interrupts
      1150 ±  7%     -68.7%     359.75 ± 39%  interrupts.CPU52.PMI:Performance_monitoring_interrupts
     23345 ±  4%     -20.7%      18503        interrupts.CPU53.LOC:Local_timer_interrupts
      1994 ± 30%     -83.3%     332.75 ± 46%  interrupts.CPU53.NMI:Non-maskable_interrupts
      1994 ± 30%     -83.3%     332.75 ± 46%  interrupts.CPU53.PMI:Performance_monitoring_interrupts
     23305 ±  4%     -20.6%      18500        interrupts.CPU54.LOC:Local_timer_interrupts
      2601 ± 21%     -93.5%     169.75 ± 34%  interrupts.CPU54.NMI:Non-maskable_interrupts
      2601 ± 21%     -93.5%     169.75 ± 34%  interrupts.CPU54.PMI:Performance_monitoring_interrupts
     23317 ±  4%     -20.6%      18516        interrupts.CPU55.LOC:Local_timer_interrupts
      2153 ± 32%     -91.5%     183.25 ± 35%  interrupts.CPU55.NMI:Non-maskable_interrupts
      2153 ± 32%     -91.5%     183.25 ± 35%  interrupts.CPU55.PMI:Performance_monitoring_interrupts
     23250 ±  4%     -20.4%      18500        interrupts.CPU56.LOC:Local_timer_interrupts
      2177 ± 33%     -88.0%     261.25 ± 22%  interrupts.CPU56.NMI:Non-maskable_interrupts
      2177 ± 33%     -88.0%     261.25 ± 22%  interrupts.CPU56.PMI:Performance_monitoring_interrupts
     23342 ±  4%     -20.7%      18502        interrupts.CPU57.LOC:Local_timer_interrupts
      1851 ±  7%     -87.8%     226.50 ± 23%  interrupts.CPU57.NMI:Non-maskable_interrupts
      1851 ±  7%     -87.8%     226.50 ± 23%  interrupts.CPU57.PMI:Performance_monitoring_interrupts
     23332 ±  4%     -21.1%      18406 ±  2%  interrupts.CPU58.LOC:Local_timer_interrupts
      2203 ± 18%     -88.4%     256.50 ± 51%  interrupts.CPU58.NMI:Non-maskable_interrupts
      2203 ± 18%     -88.4%     256.50 ± 51%  interrupts.CPU58.PMI:Performance_monitoring_interrupts
     23348 ±  4%     -20.8%      18498        interrupts.CPU59.LOC:Local_timer_interrupts
      2238 ± 24%     -83.7%     366.00 ± 60%  interrupts.CPU59.NMI:Non-maskable_interrupts
      2238 ± 24%     -83.7%     366.00 ± 60%  interrupts.CPU59.PMI:Performance_monitoring_interrupts
     23167 ±  4%     -20.0%      18537        interrupts.CPU6.LOC:Local_timer_interrupts
      1537 ± 30%     -80.5%     300.00 ± 62%  interrupts.CPU6.NMI:Non-maskable_interrupts
      1537 ± 30%     -80.5%     300.00 ± 62%  interrupts.CPU6.PMI:Performance_monitoring_interrupts
     23317 ±  4%     -21.6%      18283        interrupts.CPU60.LOC:Local_timer_interrupts
     23294 ±  4%     -20.9%      18414        interrupts.CPU61.LOC:Local_timer_interrupts
      2357 ± 54%     -89.1%     256.25 ± 35%  interrupts.CPU61.NMI:Non-maskable_interrupts
      2357 ± 54%     -89.1%     256.25 ± 35%  interrupts.CPU61.PMI:Performance_monitoring_interrupts
     23300 ±  4%     -20.6%      18500        interrupts.CPU62.LOC:Local_timer_interrupts
      1830 ± 34%     -78.6%     392.50 ± 51%  interrupts.CPU62.NMI:Non-maskable_interrupts
      1830 ± 34%     -78.6%     392.50 ± 51%  interrupts.CPU62.PMI:Performance_monitoring_interrupts
     23278 ±  4%     -20.6%      18478        interrupts.CPU63.LOC:Local_timer_interrupts
      1833 ± 17%     -80.5%     356.75 ± 74%  interrupts.CPU63.NMI:Non-maskable_interrupts
      1833 ± 17%     -80.5%     356.75 ± 74%  interrupts.CPU63.PMI:Performance_monitoring_interrupts
     23309 ±  4%     -21.8%      18220        interrupts.CPU64.LOC:Local_timer_interrupts
      1582 ± 31%     -84.5%     244.50 ±  7%  interrupts.CPU64.NMI:Non-maskable_interrupts
      1582 ± 31%     -84.5%     244.50 ±  7%  interrupts.CPU64.PMI:Performance_monitoring_interrupts
     23323 ±  4%     -20.9%      18448        interrupts.CPU65.LOC:Local_timer_interrupts
      1750 ± 48%     -85.7%     250.00 ± 65%  interrupts.CPU65.NMI:Non-maskable_interrupts
      1750 ± 48%     -85.7%     250.00 ± 65%  interrupts.CPU65.PMI:Performance_monitoring_interrupts
     23339 ±  4%     -21.6%      18305 ±  3%  interrupts.CPU66.LOC:Local_timer_interrupts
      1237 ± 29%     -71.2%     356.00 ± 52%  interrupts.CPU66.NMI:Non-maskable_interrupts
      1237 ± 29%     -71.2%     356.00 ± 52%  interrupts.CPU66.PMI:Performance_monitoring_interrupts
     23252 ±  5%     -20.4%      18500        interrupts.CPU67.LOC:Local_timer_interrupts
      2176 ± 48%     -88.4%     253.50 ± 76%  interrupts.CPU67.NMI:Non-maskable_interrupts
      2176 ± 48%     -88.4%     253.50 ± 76%  interrupts.CPU67.PMI:Performance_monitoring_interrupts
     23335 ±  4%     -20.7%      18499        interrupts.CPU68.LOC:Local_timer_interrupts
      1812 ± 28%     -90.8%     167.00 ± 58%  interrupts.CPU68.NMI:Non-maskable_interrupts
      1812 ± 28%     -90.8%     167.00 ± 58%  interrupts.CPU68.PMI:Performance_monitoring_interrupts
     23302 ±  4%     -20.5%      18525        interrupts.CPU69.LOC:Local_timer_interrupts
      1239 ± 20%     -86.7%     164.50 ± 63%  interrupts.CPU69.NMI:Non-maskable_interrupts
      1239 ± 20%     -86.7%     164.50 ± 63%  interrupts.CPU69.PMI:Performance_monitoring_interrupts
     23163 ±  4%     -20.1%      18513        interrupts.CPU7.LOC:Local_timer_interrupts
      1519 ± 59%     -82.1%     272.50 ± 73%  interrupts.CPU7.NMI:Non-maskable_interrupts
      1519 ± 59%     -82.1%     272.50 ± 73%  interrupts.CPU7.PMI:Performance_monitoring_interrupts
     23309 ±  4%     -20.7%      18486        interrupts.CPU70.LOC:Local_timer_interrupts
      2364 ± 19%     -90.8%     218.50 ± 59%  interrupts.CPU70.NMI:Non-maskable_interrupts
      2364 ± 19%     -90.8%     218.50 ± 59%  interrupts.CPU70.PMI:Performance_monitoring_interrupts
     23318 ±  4%     -21.5%      18297        interrupts.CPU71.LOC:Local_timer_interrupts
      1892 ± 31%     -87.9%     229.50 ± 59%  interrupts.CPU71.NMI:Non-maskable_interrupts
      1892 ± 31%     -87.9%     229.50 ± 59%  interrupts.CPU71.PMI:Performance_monitoring_interrupts
     23095 ±  4%     -20.0%      18485        interrupts.CPU72.LOC:Local_timer_interrupts
      2080 ± 29%     -76.2%     494.50 ± 33%  interrupts.CPU72.NMI:Non-maskable_interrupts
      2080 ± 29%     -76.2%     494.50 ± 33%  interrupts.CPU72.PMI:Performance_monitoring_interrupts
     23158 ±  4%     -20.0%      18518        interrupts.CPU73.LOC:Local_timer_interrupts
      2600 ± 13%     -82.9%     445.75 ± 21%  interrupts.CPU73.NMI:Non-maskable_interrupts
      2600 ± 13%     -82.9%     445.75 ± 21%  interrupts.CPU73.PMI:Performance_monitoring_interrupts
     23146 ±  4%     -20.0%      18506        interrupts.CPU74.LOC:Local_timer_interrupts
      2567 ± 24%     -82.9%     438.50 ± 84%  interrupts.CPU74.NMI:Non-maskable_interrupts
      2567 ± 24%     -82.9%     438.50 ± 84%  interrupts.CPU74.PMI:Performance_monitoring_interrupts
     23092 ±  4%     -19.9%      18500        interrupts.CPU75.LOC:Local_timer_interrupts
      1949 ± 29%     -78.6%     417.00 ± 63%  interrupts.CPU75.NMI:Non-maskable_interrupts
      1949 ± 29%     -78.6%     417.00 ± 63%  interrupts.CPU75.PMI:Performance_monitoring_interrupts
     23079 ±  4%     -19.7%      18538        interrupts.CPU76.LOC:Local_timer_interrupts
      2432 ± 49%     -84.5%     376.75 ± 74%  interrupts.CPU76.NMI:Non-maskable_interrupts
      2432 ± 49%     -84.5%     376.75 ± 74%  interrupts.CPU76.PMI:Performance_monitoring_interrupts
     23094 ±  4%     -19.8%      18522        interrupts.CPU77.LOC:Local_timer_interrupts
      2579 ± 59%     -80.6%     501.50 ± 83%  interrupts.CPU77.NMI:Non-maskable_interrupts
      2579 ± 59%     -80.6%     501.50 ± 83%  interrupts.CPU77.PMI:Performance_monitoring_interrupts
     23104 ±  4%     -19.9%      18515        interrupts.CPU78.LOC:Local_timer_interrupts
      1484 ± 16%     -85.2%     220.25 ± 47%  interrupts.CPU78.NMI:Non-maskable_interrupts
      1484 ± 16%     -85.2%     220.25 ± 47%  interrupts.CPU78.PMI:Performance_monitoring_interrupts
     23117 ±  4%     -19.8%      18539        interrupts.CPU79.LOC:Local_timer_interrupts
      2592 ± 18%     -89.9%     262.25 ± 30%  interrupts.CPU79.NMI:Non-maskable_interrupts
      2592 ± 18%     -89.9%     262.25 ± 30%  interrupts.CPU79.PMI:Performance_monitoring_interrupts
     23127 ±  4%     -19.8%      18537        interrupts.CPU8.LOC:Local_timer_interrupts
      1209 ± 33%     -72.6%     331.00 ± 97%  interrupts.CPU8.NMI:Non-maskable_interrupts
      1209 ± 33%     -72.6%     331.00 ± 97%  interrupts.CPU8.PMI:Performance_monitoring_interrupts
     23107 ±  4%     -20.2%      18445        interrupts.CPU80.LOC:Local_timer_interrupts
      3109 ± 30%     -87.2%     398.25 ± 68%  interrupts.CPU80.NMI:Non-maskable_interrupts
      3109 ± 30%     -87.2%     398.25 ± 68%  interrupts.CPU80.PMI:Performance_monitoring_interrupts
     23120 ±  4%     -20.1%      18472        interrupts.CPU81.LOC:Local_timer_interrupts
      2048 ± 42%     -81.7%     374.50 ± 71%  interrupts.CPU81.NMI:Non-maskable_interrupts
      2048 ± 42%     -81.7%     374.50 ± 71%  interrupts.CPU81.PMI:Performance_monitoring_interrupts
     23085 ±  4%     -19.8%      18506        interrupts.CPU82.LOC:Local_timer_interrupts
      1501 ± 59%     -76.6%     350.75 ± 83%  interrupts.CPU82.NMI:Non-maskable_interrupts
      1501 ± 59%     -76.6%     350.75 ± 83%  interrupts.CPU82.PMI:Performance_monitoring_interrupts
     23106 ±  4%     -19.9%      18519        interrupts.CPU83.LOC:Local_timer_interrupts
      1432 ± 18%     -75.9%     344.75 ± 78%  interrupts.CPU83.NMI:Non-maskable_interrupts
      1432 ± 18%     -75.9%     344.75 ± 78%  interrupts.CPU83.PMI:Performance_monitoring_interrupts
     23115 ±  4%     -20.0%      18498        interrupts.CPU84.LOC:Local_timer_interrupts
      2263 ± 38%     -81.6%     417.25 ± 71%  interrupts.CPU84.NMI:Non-maskable_interrupts
      2263 ± 38%     -81.6%     417.25 ± 71%  interrupts.CPU84.PMI:Performance_monitoring_interrupts
     23140 ±  4%     -20.2%      18459        interrupts.CPU85.LOC:Local_timer_interrupts
      1879 ±  7%     -82.9%     321.25 ± 84%  interrupts.CPU85.NMI:Non-maskable_interrupts
      1879 ±  7%     -82.9%     321.25 ± 84%  interrupts.CPU85.PMI:Performance_monitoring_interrupts
     23104 ±  4%     -19.8%      18530        interrupts.CPU86.LOC:Local_timer_interrupts
      2113 ± 41%     -79.7%     430.00 ± 63%  interrupts.CPU86.NMI:Non-maskable_interrupts
      2113 ± 41%     -79.7%     430.00 ± 63%  interrupts.CPU86.PMI:Performance_monitoring_interrupts
     23125 ±  4%     -19.9%      18513        interrupts.CPU87.LOC:Local_timer_interrupts
      2152 ± 40%     -84.1%     341.50 ± 98%  interrupts.CPU87.NMI:Non-maskable_interrupts
      2152 ± 40%     -84.1%     341.50 ± 98%  interrupts.CPU87.PMI:Performance_monitoring_interrupts
     23137 ±  4%     -19.9%      18533        interrupts.CPU88.LOC:Local_timer_interrupts
      2151 ± 50%     -83.8%     348.50 ± 88%  interrupts.CPU88.NMI:Non-maskable_interrupts
      2151 ± 50%     -83.8%     348.50 ± 88%  interrupts.CPU88.PMI:Performance_monitoring_interrupts
     23085 ±  4%     -20.7%      18301        interrupts.CPU89.LOC:Local_timer_interrupts
      2567 ± 15%     -89.6%     266.50 ± 68%  interrupts.CPU89.NMI:Non-maskable_interrupts
      2567 ± 15%     -89.6%     266.50 ± 68%  interrupts.CPU89.PMI:Performance_monitoring_interrupts
     23110 ±  4%     -19.8%      18541        interrupts.CPU9.LOC:Local_timer_interrupts
      1317 ± 65%     -78.8%     279.50 ±101%  interrupts.CPU9.NMI:Non-maskable_interrupts
      1317 ± 65%     -78.8%     279.50 ±101%  interrupts.CPU9.PMI:Performance_monitoring_interrupts
     23097 ±  3%     -19.8%      18516        interrupts.CPU90.LOC:Local_timer_interrupts
      1783 ± 17%     -76.8%     414.00 ± 57%  interrupts.CPU90.NMI:Non-maskable_interrupts
      1783 ± 17%     -76.8%     414.00 ± 57%  interrupts.CPU90.PMI:Performance_monitoring_interrupts
     23038 ±  4%     -19.6%      18521        interrupts.CPU91.LOC:Local_timer_interrupts
      1825 ±  8%     -88.2%     214.50 ± 64%  interrupts.CPU91.NMI:Non-maskable_interrupts
      1825 ±  8%     -88.2%     214.50 ± 64%  interrupts.CPU91.PMI:Performance_monitoring_interrupts
     23069 ±  4%     -19.7%      18519        interrupts.CPU92.LOC:Local_timer_interrupts
      1661 ± 21%     -89.6%     172.75 ± 46%  interrupts.CPU92.NMI:Non-maskable_interrupts
      1661 ± 21%     -89.6%     172.75 ± 46%  interrupts.CPU92.PMI:Performance_monitoring_interrupts
     23118 ±  4%     -19.9%      18526        interrupts.CPU93.LOC:Local_timer_interrupts
      1478 ± 30%     -90.9%     135.25 ± 79%  interrupts.CPU93.NMI:Non-maskable_interrupts
      1478 ± 30%     -90.9%     135.25 ± 79%  interrupts.CPU93.PMI:Performance_monitoring_interrupts
     23094 ±  4%     -19.8%      18517        interrupts.CPU94.LOC:Local_timer_interrupts
      1410 ± 24%     -88.7%     159.25 ± 86%  interrupts.CPU94.NMI:Non-maskable_interrupts
      1410 ± 24%     -88.7%     159.25 ± 86%  interrupts.CPU94.PMI:Performance_monitoring_interrupts
     23131 ±  4%     -19.9%      18526        interrupts.CPU95.LOC:Local_timer_interrupts
      1553 ± 56%     -81.1%     294.25 ± 74%  interrupts.CPU95.NMI:Non-maskable_interrupts
      1553 ± 56%     -81.1%     294.25 ± 74%  interrupts.CPU95.PMI:Performance_monitoring_interrupts
     23146 ±  4%     -19.9%      18530        interrupts.CPU96.LOC:Local_timer_interrupts
     23187 ±  4%     -20.3%      18480        interrupts.CPU97.LOC:Local_timer_interrupts
     23134 ±  4%     -20.5%      18393        interrupts.CPU98.LOC:Local_timer_interrupts
      1273 ± 35%     -68.5%     400.75 ± 56%  interrupts.CPU98.NMI:Non-maskable_interrupts
      1273 ± 35%     -68.5%     400.75 ± 56%  interrupts.CPU98.PMI:Performance_monitoring_interrupts
     23139 ±  4%     -20.0%      18518        interrupts.CPU99.LOC:Local_timer_interrupts
    982.25 ± 32%     -67.2%     322.00 ± 50%  interrupts.CPU99.NMI:Non-maskable_interrupts
    982.25 ± 32%     -67.2%     322.00 ± 50%  interrupts.CPU99.PMI:Performance_monitoring_interrupts
   4449343 ±  4%     -20.2%    3550337        interrupts.LOC:Local_timer_interrupts
    335115 ±  4%     -82.2%      59773 ± 33%  interrupts.NMI:Non-maskable_interrupts
    335115 ±  4%     -82.2%      59773 ± 33%  interrupts.PMI:Performance_monitoring_interrupts
      1317 ±  7%     +13.8%       1499 ±  2%  interrupts.RES:Rescheduling_interrupts



***************************************************************************************************
lkp-hsw-4ex1: 144 threads Intel(R) Xeon(R) CPU E7-8890 v3 @ 2.50GHz with 512G memory
=========================================================================================
compiler/cpufreq_governor/kconfig/mode/nr_task/rootfs/tbox_group/test/testcase/ucode:
  gcc-9/performance/x86_64-rhel-8.3/thread/100%/debian-10.4-x86_64-20200603.cgz/lkp-hsw-4ex1/unlink2/will-it-scale/0x16

commit: 
  268df4df6c ("locking/qspinlock: Refactor the qspinlock slow path")
  0dd6d5b8c0 ("locking/qspinlock: Introduce CNA into the slow path of qspinlock")

268df4df6cb0a27d 0dd6d5b8c0f6f31d8d557485fff 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
      4792 ±  2%     +84.5%       8842        will-it-scale.per_thread_ops
    301.70            +1.0%     304.59        will-it-scale.time.elapsed_time
    301.70            +1.0%     304.59        will-it-scale.time.elapsed_time.max
    690243 ±  2%     +84.5%    1273343        will-it-scale.workload
 2.328e+08 ± 44%     +70.3%  3.965e+08 ± 16%  cpuidle.C6.time
      4815           -25.6%       3582 ±  8%  vmstat.system.cs
      7.55 ±  3%      +8.9       16.44 ±  2%  mpstat.cpu.all.soft%
     89.46            -9.6       79.87        mpstat.cpu.all.sys%
      0.75 ±  5%      +0.6        1.30        mpstat.cpu.all.usr%
    136767           +18.9%     162618 ±  2%  meminfo.KReclaimable
    136767           +18.9%     162618 ±  2%  meminfo.SReclaimable
    360413           +33.4%     480747 ±  5%  meminfo.SUnreclaim
    497180           +29.4%     643365 ±  4%  meminfo.Slab
     12364           +15.8%      14315 ± 10%  meminfo.max_used_kB
     34175           +18.7%      40573 ±  2%  proc-vmstat.nr_slab_reclaimable
     89744           +33.6%     119875 ±  4%  proc-vmstat.nr_slab_unreclaimable
   6039317 ±  5%    +204.9%   18412459 ±  5%  proc-vmstat.numa_hit
   5930779 ±  5%    +208.6%   18303965 ±  5%  proc-vmstat.numa_local
  27040611 ±  5%    +217.1%   85757823 ±  5%  proc-vmstat.pgalloc_normal
   1129384            -5.6%    1066165 ±  3%  proc-vmstat.pgfault
  26956963 ±  5%    +217.7%   85646911 ±  5%  proc-vmstat.pgfree
     58132            -7.0%      54067 ±  3%  proc-vmstat.pgreuse
   1476135 ±  4%    +144.5%    3609209 ± 14%  numa-numastat.node0.local_node
   1504392 ±  4%    +140.7%    3620824 ± 14%  numa-numastat.node0.numa_hit
     28267 ± 32%     -58.9%      11626 ± 72%  numa-numastat.node0.other_node
   1453766 ±  5%    +259.1%    5220349 ± 13%  numa-numastat.node1.local_node
   1486702 ±  5%    +253.0%    5248367 ± 13%  numa-numastat.node1.numa_hit
   1472109 ±  5%    +127.2%    3344940 ± 16%  numa-numastat.node2.local_node
   1492549 ±  5%    +126.3%    3377602 ± 16%  numa-numastat.node2.numa_hit
   1495896 ±  5%    +308.8%    6115139 ±  4%  numa-numastat.node3.local_node
   1522777 ±  5%    +304.0%    6151319 ±  4%  numa-numastat.node3.numa_hit
     35769 ± 15%     +32.7%      47462 ± 11%  numa-meminfo.node0.KReclaimable
     35769 ± 15%     +32.7%      47462 ± 11%  numa-meminfo.node0.SReclaimable
     96449 ±  4%     +20.4%     116129 ±  7%  numa-meminfo.node0.SUnreclaim
    132218 ±  6%     +23.7%     163591 ±  7%  numa-meminfo.node0.Slab
     29079 ± 14%     +49.4%      43455 ± 13%  numa-meminfo.node1.KReclaimable
    636341 ±  5%     +21.5%     773419 ± 13%  numa-meminfo.node1.MemUsed
     29079 ± 14%     +49.4%      43455 ± 13%  numa-meminfo.node1.SReclaimable
     77895 ±  2%     +70.6%     132858 ± 11%  numa-meminfo.node1.SUnreclaim
    106975 ±  5%     +64.8%     176314 ±  9%  numa-meminfo.node1.Slab
      1315 ± 51%     -42.1%     761.50 ± 15%  numa-meminfo.node2.PageTables
     25458 ± 25%    +311.8%     104824 ± 24%  numa-meminfo.node3.AnonHugePages
     49223 ± 22%    +189.0%     142264 ± 18%  numa-meminfo.node3.AnonPages
     57263 ± 22%    +158.5%     148039 ± 18%  numa-meminfo.node3.Inactive
     57263 ± 22%    +158.5%     148039 ± 18%  numa-meminfo.node3.Inactive(anon)
     95446 ±  9%     +38.9%     132566 ± 16%  numa-meminfo.node3.SUnreclaim
    135228 ±  7%     +29.1%     174527 ± 14%  numa-meminfo.node3.Slab
    269220           +44.9%     390086 ±  6%  slabinfo.dentry.active_objs
      6480           +44.5%       9366 ±  6%  slabinfo.dentry.active_slabs
    272197           +44.5%     393413 ±  6%  slabinfo.dentry.num_objs
      6480           +44.5%       9366 ±  6%  slabinfo.dentry.num_slabs
    166458 ±  2%     +73.1%     288204 ±  9%  slabinfo.filp.active_objs
      2657 ±  2%     +70.7%       4537 ±  9%  slabinfo.filp.active_slabs
    170103 ±  2%     +70.7%     290390 ±  9%  slabinfo.filp.num_objs
      2657 ±  2%     +70.7%       4537 ±  9%  slabinfo.filp.num_slabs
     55838           +28.4%      71689 ±  6%  slabinfo.kmalloc-512.active_objs
    879.25           +29.0%       1134 ±  6%  slabinfo.kmalloc-512.active_slabs
     56288           +29.0%      72620 ±  6%  slabinfo.kmalloc-512.num_objs
    879.25           +29.0%       1134 ±  6%  slabinfo.kmalloc-512.num_slabs
    150989 ±  2%     +84.0%     277860 ± 10%  slabinfo.shmem_inode_cache.active_objs
      3322 ±  2%     +82.3%       6057 ± 10%  slabinfo.shmem_inode_cache.active_slabs
    152847 ±  2%     +82.3%     278641 ± 10%  slabinfo.shmem_inode_cache.num_objs
      3322 ±  2%     +82.3%       6057 ± 10%  slabinfo.shmem_inode_cache.num_slabs
      8938 ± 15%     +32.6%      11850 ± 10%  numa-vmstat.node0.nr_slab_reclaimable
     23900 ±  4%     +20.4%      28765 ±  6%  numa-vmstat.node0.nr_slab_unreclaimable
   1188950 ±  4%     +87.9%    2234624 ± 10%  numa-vmstat.node0.numa_hit
   1108436 ±  5%    +100.2%    2218815 ± 10%  numa-vmstat.node0.numa_local
     80513 ± 30%     -80.4%      15810 ± 47%  numa-vmstat.node0.numa_other
      1962           +34.8%       2646 ± 25%  numa-vmstat.node1.nr_mapped
      7271 ± 14%     +48.3%      10782 ± 13%  numa-vmstat.node1.nr_slab_reclaimable
     19354           +66.1%      32142 ±  9%  numa-vmstat.node1.nr_slab_unreclaimable
   1021592 ±  4%    +195.7%    3020936 ± 13%  numa-vmstat.node1.numa_hit
    898906 ±  5%    +223.1%    2904257 ± 13%  numa-vmstat.node1.numa_local
    328.75 ± 51%     -42.1%     190.25 ± 14%  numa-vmstat.node2.nr_page_table_pages
   1151784 ±  8%     +70.8%    1967482 ± 15%  numa-vmstat.node2.numa_hit
   1058693 ±  9%     +74.2%    1844656 ± 16%  numa-vmstat.node2.numa_local
     93091 ± 27%     +31.9%     122826 ±  4%  numa-vmstat.node2.numa_other
     12306 ± 22%    +188.8%      35545 ± 18%  numa-vmstat.node3.nr_anon_pages
     14323 ± 22%    +158.2%      36980 ± 17%  numa-vmstat.node3.nr_inactive_anon
     23828 ±  9%     +36.6%      32552 ± 15%  numa-vmstat.node3.nr_slab_unreclaimable
     14323 ± 22%    +158.2%      36980 ± 17%  numa-vmstat.node3.nr_zone_inactive_anon
   1157217 ±  7%    +195.3%    3417488 ±  5%  numa-vmstat.node3.numa_hit
   1071718 ±  9%    +207.1%    3291197 ±  5%  numa-vmstat.node3.numa_local
     85499 ± 27%     +47.7%     126291        numa-vmstat.node3.numa_other
     17267 ± 53%     -81.3%       3231 ± 21%  syscalls.sys_close.med
 2.006e+09 ± 69%  -1.7e+09   2.569e+08 ± 45%  syscalls.sys_close.noise.100%
 2.164e+09 ± 67%  -1.9e+09    3.01e+08 ± 40%  syscalls.sys_close.noise.2%
 2.149e+09 ± 67%  -1.9e+09   2.955e+08 ± 41%  syscalls.sys_close.noise.25%
 2.163e+09 ± 67%  -1.9e+09   3.008e+08 ± 40%  syscalls.sys_close.noise.5%
 2.113e+09 ± 67%  -1.8e+09   2.831e+08 ± 42%  syscalls.sys_close.noise.50%
 2.063e+09 ± 68%  -1.8e+09   2.693e+08 ± 43%  syscalls.sys_close.noise.75%
    228453 ±  2%     -88.3%      26729 ±  2%  syscalls.sys_openat.med
  3.22e+09 ±  3%  +1.1e+10   1.435e+10 ±  6%  syscalls.sys_openat.noise.100%
 3.979e+09        +1.1e+10   1.451e+10 ±  6%  syscalls.sys_openat.noise.2%
 3.288e+09 ±  3%  +1.1e+10   1.447e+10 ±  6%  syscalls.sys_openat.noise.25%
 3.873e+09        +1.1e+10    1.45e+10 ±  6%  syscalls.sys_openat.noise.5%
 3.229e+09 ±  3%  +1.1e+10   1.443e+10 ±  6%  syscalls.sys_openat.noise.50%
 3.225e+09 ±  3%  +1.1e+10   1.439e+10 ±  6%  syscalls.sys_openat.noise.75%
 2.609e+09           -71.2%   7.51e+08 ±137%  syscalls.sys_read.max
 3.722e+11 ± 24%    -3e+11   7.291e+10 ± 82%  syscalls.sys_read.noise.100%
 3.722e+11 ± 24%    -3e+11   7.293e+10 ± 82%  syscalls.sys_read.noise.2%
 3.722e+11 ± 24%    -3e+11   7.293e+10 ± 82%  syscalls.sys_read.noise.25%
 3.722e+11 ± 24%    -3e+11   7.293e+10 ± 82%  syscalls.sys_read.noise.5%
 3.722e+11 ± 24%    -3e+11   7.292e+10 ± 82%  syscalls.sys_read.noise.50%
 3.722e+11 ± 24%    -3e+11   7.292e+10 ± 82%  syscalls.sys_read.noise.75%
    200762 ±  6%     -90.5%      19010 ±  3%  syscalls.sys_unlink.med
      5825 ± 11%     -29.7%       4098 ± 16%  syscalls.sys_unlink.min
 1.993e+09 ± 30%    +1e+10   1.215e+10 ±  2%  syscalls.sys_unlink.noise.100%
 2.855e+09 ± 14%  +9.4e+09   1.228e+10 ±  2%  syscalls.sys_unlink.noise.2%
 2.138e+09 ± 23%    +1e+10   1.225e+10 ±  2%  syscalls.sys_unlink.noise.25%
 2.776e+09 ± 13%  +9.5e+09   1.228e+10 ±  2%  syscalls.sys_unlink.noise.5%
 2.004e+09 ± 30%    +1e+10   1.221e+10 ±  2%  syscalls.sys_unlink.noise.50%
 1.997e+09 ± 30%    +1e+10   1.218e+10 ±  2%  syscalls.sys_unlink.noise.75%
    110846 ± 65%   +1279.5%    1529159 ± 73%  sched_debug.cfs_rq:/.MIN_vruntime.avg
   2667682 ± 61%    +435.5%   14286598 ± 18%  sched_debug.cfs_rq:/.MIN_vruntime.max
    454293 ± 33%    +669.5%    3495935 ± 21%  sched_debug.cfs_rq:/.MIN_vruntime.stddev
    281.30 ±  5%     +50.6%     423.71 ± 18%  sched_debug.cfs_rq:/.exec_clock.stddev
     22511 ± 64%    +298.2%      89638 ± 65%  sched_debug.cfs_rq:/.load.avg
    409239 ± 54%     +95.7%     801021 ± 18%  sched_debug.cfs_rq:/.load.max
      5658 ±  8%     -37.1%       3560 ± 40%  sched_debug.cfs_rq:/.load.min
     62960 ± 50%    +190.7%     183018 ± 24%  sched_debug.cfs_rq:/.load.stddev
     85.15 ± 17%     +91.6%     163.16 ± 27%  sched_debug.cfs_rq:/.load_avg.avg
    364.42 ± 20%     +86.9%     681.21 ± 19%  sched_debug.cfs_rq:/.load_avg.max
     62.71 ± 14%    +122.1%     139.28 ± 23%  sched_debug.cfs_rq:/.load_avg.stddev
    110846 ± 65%   +1279.5%    1529159 ± 73%  sched_debug.cfs_rq:/.max_vruntime.avg
   2667682 ± 61%    +435.5%   14286598 ± 18%  sched_debug.cfs_rq:/.max_vruntime.max
    454293 ± 33%    +669.5%    3495935 ± 21%  sched_debug.cfs_rq:/.max_vruntime.stddev
  19269541           -11.5%   17053935        sched_debug.cfs_rq:/.min_vruntime.min
     89504 ±  4%    +520.0%     554953 ± 22%  sched_debug.cfs_rq:/.min_vruntime.stddev
      1.29 ± 10%     +29.0%       1.67 ±  7%  sched_debug.cfs_rq:/.nr_running.max
      0.10 ± 21%    +124.2%       0.23 ± 19%  sched_debug.cfs_rq:/.nr_running.stddev
    925.08 ±  4%     +32.6%       1226 ± 10%  sched_debug.cfs_rq:/.nr_spread_over.avg
      1039 ±  4%     +81.6%       1888 ±  5%  sched_debug.cfs_rq:/.nr_spread_over.max
    646.58 ± 12%     +52.8%     987.92 ±  7%  sched_debug.cfs_rq:/.nr_spread_over.min
     56.08 ±  7%    +181.9%     158.10 ± 30%  sched_debug.cfs_rq:/.nr_spread_over.stddev
      0.96 ± 14%     -55.7%       0.43 ± 74%  sched_debug.cfs_rq:/.removed.runnable_avg.avg
     91.46 ± 14%     -61.6%      35.12 ± 76%  sched_debug.cfs_rq:/.removed.runnable_avg.max
      9.28 ± 11%     -60.0%       3.71 ± 75%  sched_debug.cfs_rq:/.removed.runnable_avg.stddev
      0.92 ± 13%     -53.9%       0.43 ± 74%  sched_debug.cfs_rq:/.removed.util_avg.avg
     86.25 ±  4%     -59.3%      35.12 ± 76%  sched_debug.cfs_rq:/.removed.util_avg.max
      8.84 ±  6%     -58.0%       3.71 ± 75%  sched_debug.cfs_rq:/.removed.util_avg.stddev
    979.20 ±  2%      +7.3%       1050 ±  3%  sched_debug.cfs_rq:/.runnable_avg.avg
      1721 ±  7%     +20.5%       2074 ±  6%  sched_debug.cfs_rq:/.runnable_avg.max
    134.91 ± 17%     +84.8%     249.35 ± 22%  sched_debug.cfs_rq:/.runnable_avg.stddev
    -75655          +379.8%    -362995        sched_debug.cfs_rq:/.spread0.avg
     86118 ± 72%    +272.5%     320810 ± 44%  sched_debug.cfs_rq:/.spread0.max
   -830136          +108.5%   -1731175        sched_debug.cfs_rq:/.spread0.min
     90127 ±  4%    +516.4%     555565 ± 22%  sched_debug.cfs_rq:/.spread0.stddev
    773.49 ±  5%     +11.8%     864.84 ±  2%  sched_debug.cfs_rq:/.util_est_enqueued.avg
      1113 ±  8%     +36.6%       1521 ± 13%  sched_debug.cfs_rq:/.util_est_enqueued.max
     15.80 ±  3%     +41.8%      22.41 ± 19%  sched_debug.cpu.clock.stddev
      2239 ±  9%     -39.7%       1351 ± 35%  sched_debug.cpu.curr->pid.min
      0.16 ±  7%     +91.2%       0.31 ± 18%  sched_debug.cpu.nr_running.stddev
      6551           -19.9%       5247 ±  6%  sched_debug.cpu.nr_switches.avg
      4730 ±  3%     -32.1%       3212 ±  6%  sched_debug.cpu.nr_switches.min
      1506 ±  3%     +15.5%       1740 ±  6%  sched_debug.cpu.nr_switches.stddev
      5775           +60.1%       9244        sched_debug.cpu.sched_count.avg
     10798 ±  2%     +37.3%      14822 ±  5%  sched_debug.cpu.sched_count.max
      4566           +64.5%       7510        sched_debug.cpu.sched_count.min
    171.02 ±  3%     +12.0%     191.54 ±  3%  sched_debug.cpu.sched_goidle.avg
      2390           -28.2%       1716 ±  9%  sched_debug.cpu.ttwu_count.avg
      1797           -40.8%       1064 ±  7%  sched_debug.cpu.ttwu_count.min
      2203           -31.5%       1509 ± 10%  sched_debug.cpu.ttwu_local.avg
      4551 ±  3%     -10.8%       4060 ±  7%  sched_debug.cpu.ttwu_local.max
      1699 ±  2%     -43.2%     964.37 ±  7%  sched_debug.cpu.ttwu_local.min
      1.87           +63.3%       3.05 ±  2%  perf-stat.i.MPKI
 2.159e+10            -3.9%  2.075e+10        perf-stat.i.branch-instructions
      0.19 ±  3%      +0.1        0.28 ±  2%  perf-stat.i.branch-miss-rate%
  37959951           +45.7%   55301974        perf-stat.i.branch-misses
     36.92           -22.3       14.67 ±  4%  perf-stat.i.cache-miss-rate%
  60142077 ±  2%     -35.5%   38806759 ±  2%  perf-stat.i.cache-misses
 1.627e+08           +62.6%  2.646e+08 ±  2%  perf-stat.i.cache-references
      4783           -26.0%       3538 ±  8%  perf-stat.i.context-switches
      4.62            +1.9%       4.71        perf-stat.i.cpi
      6839 ±  2%     +55.5%      10632 ±  2%  perf-stat.i.cycles-between-cache-misses
      0.02 ±  7%      +0.0        0.04 ±  5%  perf-stat.i.dTLB-load-miss-rate%
   4912324 ±  6%     +71.9%    8446161 ±  5%  perf-stat.i.dTLB-load-misses
   2499980 ±  2%     +78.1%    4452631 ±  2%  perf-stat.i.dTLB-store-misses
 2.532e+09 ±  2%     +81.1%  4.585e+09        perf-stat.i.dTLB-stores
   2759393 ±  2%     +65.9%    4577538        perf-stat.i.iTLB-load-misses
 8.882e+10            -1.5%  8.746e+10        perf-stat.i.instructions
     32165 ±  2%     -40.6%      19111        perf-stat.i.instructions-per-iTLB-miss
      0.22            -1.9%       0.21        perf-stat.i.ipc
    325.77            +2.7%     334.61        perf-stat.i.metric.M/sec
      3619            -4.7%       3448 ±  3%  perf-stat.i.minor-faults
     87.57           -36.7       50.90 ±  4%  perf-stat.i.node-load-miss-rate%
  31088820 ±  6%     -72.7%    8500735 ±  8%  perf-stat.i.node-load-misses
   4396410           +85.8%    8168080        perf-stat.i.node-loads
     69.65           -35.6       34.03 ±  5%  perf-stat.i.node-store-miss-rate%
  17089498 ±  2%     -56.4%    7448252 ±  7%  perf-stat.i.node-store-misses
   7433813 ±  4%     +94.1%   14430748        perf-stat.i.node-stores
      3621            -4.7%       3450 ±  3%  perf-stat.i.page-faults
      1.83           +65.1%       3.03 ±  2%  perf-stat.overall.MPKI
      0.18            +0.1        0.27        perf-stat.overall.branch-miss-rate%
     36.95           -22.3       14.69 ±  4%  perf-stat.overall.cache-miss-rate%
      4.63            +1.8%       4.71        perf-stat.overall.cpi
      6840 ±  2%     +55.3%      10622 ±  2%  perf-stat.overall.cycles-between-cache-misses
      0.02 ±  6%      +0.0        0.04 ±  5%  perf-stat.overall.dTLB-load-miss-rate%
     32212 ±  2%     -40.7%      19098        perf-stat.overall.instructions-per-iTLB-miss
      0.22            -1.8%       0.21        perf-stat.overall.ipc
     87.56           -36.7       50.86 ±  5%  perf-stat.overall.node-load-miss-rate%
     69.68           -35.6       34.04 ±  5%  perf-stat.overall.node-store-miss-rate%
  38840128           -46.3%   20845339        perf-stat.overall.path-length
 2.151e+10            -4.2%  2.061e+10        perf-stat.ps.branch-instructions
  37802206           +45.0%   54819867        perf-stat.ps.branch-misses
  59944159 ±  2%     -35.7%   38569333 ±  2%  perf-stat.ps.cache-misses
 1.622e+08           +62.0%  2.628e+08        perf-stat.ps.cache-references
      4762           -26.5%       3498 ±  9%  perf-stat.ps.context-switches
   4906573 ±  6%     +71.2%    8400105 ±  5%  perf-stat.ps.dTLB-load-misses
   2491103 ±  2%     +77.6%    4423591 ±  2%  perf-stat.ps.dTLB-store-misses
 2.522e+09 ±  2%     +80.6%  4.554e+09        perf-stat.ps.dTLB-stores
   2749190 ±  2%     +65.4%    4548193        perf-stat.ps.iTLB-load-misses
  8.85e+10            -1.9%  8.685e+10        perf-stat.ps.instructions
      3601            -6.6%       3365 ±  3%  perf-stat.ps.minor-faults
  30978570 ±  6%     -72.7%    8442311 ±  8%  perf-stat.ps.node-load-misses
   4388611           +85.2%    8125626        perf-stat.ps.node-loads
  17030395 ±  2%     -56.5%    7405122 ±  7%  perf-stat.ps.node-store-misses
   7413447 ±  4%     +93.4%   14335047        perf-stat.ps.node-stores
      3602            -6.5%       3366 ±  3%  perf-stat.ps.page-faults
    122894 ±  2%     -55.4%      54811 ± 22%  softirqs.CPU100.RCU
    122903 ±  2%     -56.0%      54029 ± 25%  softirqs.CPU101.RCU
    122250 ±  3%     -55.9%      53914 ± 26%  softirqs.CPU102.RCU
    123468           -56.8%      53293 ± 25%  softirqs.CPU103.RCU
    123120           -57.8%      51978 ± 25%  softirqs.CPU104.RCU
    123454           -56.3%      53903 ± 24%  softirqs.CPU105.RCU
    123455           -55.9%      54427 ± 23%  softirqs.CPU106.RCU
    123353           -56.0%      54223 ± 23%  softirqs.CPU107.RCU
    118634 ±  2%     -66.1%      40192 ±  3%  softirqs.CPU126.RCU
    117671           -69.0%      36450 ±  8%  softirqs.CPU127.RCU
    123094           -65.0%      43136 ±  7%  softirqs.CPU128.RCU
    122351 ±  3%     -63.3%      44842 ±  8%  softirqs.CPU129.RCU
    123098 ±  2%     -65.8%      42118 ± 10%  softirqs.CPU130.RCU
    123169           -64.7%      43458 ±  8%  softirqs.CPU131.RCU
    123728           -64.8%      43498 ±  8%  softirqs.CPU132.RCU
    123875 ±  2%     -65.8%      42401 ±  8%  softirqs.CPU133.RCU
    121518 ±  3%     -65.5%      41953 ±  6%  softirqs.CPU134.RCU
    123291 ±  2%     -65.0%      43098 ±  9%  softirqs.CPU135.RCU
    123017           -65.9%      41954 ± 11%  softirqs.CPU136.RCU
    123907           -64.4%      44140 ± 10%  softirqs.CPU137.RCU
    123901 ±  2%     -63.2%      45646 ±  7%  softirqs.CPU138.RCU
    124021           -65.3%      43025 ±  5%  softirqs.CPU139.RCU
    123388 ±  2%     -65.2%      42931 ±  6%  softirqs.CPU140.RCU
    124157           -64.0%      44735 ±  7%  softirqs.CPU141.RCU
    123916 ±  2%     -65.3%      43058 ±  7%  softirqs.CPU142.RCU
    123494           -63.7%      44830 ± 10%  softirqs.CPU143.RCU
    124216           -55.4%      55410 ± 19%  softirqs.CPU18.RCU
    123822           -55.2%      55493 ± 22%  softirqs.CPU19.RCU
    123630           -55.7%      54734 ± 24%  softirqs.CPU20.RCU
    124658           -54.6%      56616 ± 23%  softirqs.CPU21.RCU
    124161 ±  2%     -55.9%      54712 ± 22%  softirqs.CPU22.RCU
    123258           -54.5%      56048 ± 21%  softirqs.CPU23.RCU
    123992           -56.1%      54417 ± 23%  softirqs.CPU24.RCU
    123579           -56.4%      53863 ± 21%  softirqs.CPU25.RCU
    123779           -57.1%      53059 ± 25%  softirqs.CPU26.RCU
    122260 ±  3%     -55.6%      54286 ± 23%  softirqs.CPU27.RCU
    123630           -56.5%      53778 ± 24%  softirqs.CPU28.RCU
    124226           -55.8%      54891 ± 26%  softirqs.CPU29.RCU
    123714           -57.2%      52934 ± 26%  softirqs.CPU30.RCU
    123519           -56.1%      54250 ± 22%  softirqs.CPU31.RCU
    119421           -60.2%      47586 ± 28%  softirqs.CPU32.RCU
    120765           -57.9%      50895 ± 27%  softirqs.CPU33.RCU
    120689           -59.6%      48743 ± 27%  softirqs.CPU34.RCU
    120907 ±  2%     -59.4%      49039 ± 26%  softirqs.CPU35.RCU
    123968 ±  2%     -64.5%      44022 ± 10%  softirqs.CPU54.RCU
    122637           -64.4%      43637 ±  7%  softirqs.CPU55.RCU
    122436           -66.3%      41254 ± 10%  softirqs.CPU56.RCU
    122250 ±  2%     -68.1%      38973 ± 12%  softirqs.CPU57.RCU
    120826 ±  3%     -65.3%      41934 ± 15%  softirqs.CPU58.RCU
    123086           -67.1%      40539 ±  7%  softirqs.CPU59.RCU
    123076 ±  2%     -65.2%      42869 ±  8%  softirqs.CPU60.RCU
    122010           -66.8%      40549 ±  7%  softirqs.CPU61.RCU
    122512           -67.1%      40276 ± 10%  softirqs.CPU62.RCU
    122074 ±  2%     -68.3%      38705 ± 11%  softirqs.CPU63.RCU
    121630           -67.1%      39976 ±  7%  softirqs.CPU64.RCU
    122284           -66.4%      41060 ± 12%  softirqs.CPU65.RCU
    122087           -66.8%      40569 ±  9%  softirqs.CPU66.RCU
    121974           -68.6%      38278 ±  3%  softirqs.CPU67.RCU
    121555           -68.9%      37805 ± 10%  softirqs.CPU68.RCU
    121922           -65.8%      41661 ± 19%  softirqs.CPU69.RCU
    122476           -67.7%      39501 ± 12%  softirqs.CPU70.RCU
    123764 ±  2%     -67.8%      39876 ±  9%  softirqs.CPU71.RCU
    121557           -57.3%      51908 ± 20%  softirqs.CPU90.RCU
    121676           -58.2%      50876 ± 25%  softirqs.CPU91.RCU
    121516           -60.1%      48449 ± 28%  softirqs.CPU92.RCU
    120794           -57.5%      51326 ± 24%  softirqs.CPU93.RCU
    121195           -58.0%      50957 ± 24%  softirqs.CPU94.RCU
    120466 ±  3%     -58.3%      50265 ± 24%  softirqs.CPU95.RCU
    123065           -57.0%      52867 ± 27%  softirqs.CPU96.RCU
    122722 ±  2%     -58.4%      51088 ± 26%  softirqs.CPU97.RCU
    121868 ±  3%     -57.0%      52407 ± 25%  softirqs.CPU98.RCU
    122858           -57.3%      52502 ± 26%  softirqs.CPU99.RCU
  17690961           -40.5%   10530407 ± 22%  softirqs.RCU
     65482           -17.0%      54376 ±  5%  softirqs.TIMER
    435679 ±  2%     -13.5%     377047 ±  8%  interrupts.CAL:Function_call_interrupts
      3241 ±  6%     -17.8%       2665 ±  9%  interrupts.CPU1.CAL:Function_call_interrupts
    118.25 ± 19%     +66.2%     196.50 ±  8%  interrupts.CPU100.RES:Rescheduling_interrupts
    129.75 ± 23%     +47.8%     191.75 ±  9%  interrupts.CPU101.RES:Rescheduling_interrupts
      3116 ±  6%     -14.9%       2652 ± 11%  interrupts.CPU102.CAL:Function_call_interrupts
    122.50 ±  6%     +40.6%     172.25 ± 15%  interrupts.CPU103.RES:Rescheduling_interrupts
    178.75 ± 11%    +109.8%     375.00 ± 58%  interrupts.CPU104.RES:Rescheduling_interrupts
    155.00 ± 19%     +58.1%     245.00 ±  8%  interrupts.CPU105.RES:Rescheduling_interrupts
      8099           -24.1%       6146 ± 20%  interrupts.CPU106.NMI:Non-maskable_interrupts
      8099           -24.1%       6146 ± 20%  interrupts.CPU106.PMI:Performance_monitoring_interrupts
    158.50 ± 11%     +59.8%     253.25 ±  9%  interrupts.CPU106.RES:Rescheduling_interrupts
      3096 ±  2%     -15.7%       2608 ±  9%  interrupts.CPU107.CAL:Function_call_interrupts
    172.25 ±  9%     +42.5%     245.50 ± 12%  interrupts.CPU107.RES:Rescheduling_interrupts
    102.50 ± 26%     +49.8%     153.50 ±  5%  interrupts.CPU109.RES:Rescheduling_interrupts
    128.25 ± 11%     +21.6%     156.00 ±  5%  interrupts.CPU111.RES:Rescheduling_interrupts
      3080           -13.8%       2655 ±  9%  interrupts.CPU112.CAL:Function_call_interrupts
    144.00 ± 11%     +32.3%     190.50 ± 11%  interrupts.CPU112.RES:Rescheduling_interrupts
    127.00 ± 19%     +56.3%     198.50 ± 13%  interrupts.CPU113.RES:Rescheduling_interrupts
    137.75 ± 18%     +44.3%     198.75 ±  7%  interrupts.CPU114.RES:Rescheduling_interrupts
      7135 ±  8%     +12.9%       8054        interrupts.CPU115.NMI:Non-maskable_interrupts
      7135 ±  8%     +12.9%       8054        interrupts.CPU115.PMI:Performance_monitoring_interrupts
    118.25 ±  6%     +65.5%     195.75 ±  5%  interrupts.CPU116.RES:Rescheduling_interrupts
    130.50 ± 16%     +44.4%     188.50 ±  7%  interrupts.CPU117.RES:Rescheduling_interrupts
    125.50 ± 19%     +48.2%     186.00 ±  8%  interrupts.CPU118.RES:Rescheduling_interrupts
    144.00 ± 23%     +70.8%     246.00 ± 39%  interrupts.CPU119.RES:Rescheduling_interrupts
      2433 ±  5%      -7.2%       2257 ±  3%  interrupts.CPU119.TLB:TLB_shootdowns
    153.25 ± 15%     +25.9%     193.00 ±  6%  interrupts.CPU120.RES:Rescheduling_interrupts
    129.00 ± 15%     +66.9%     215.25 ± 16%  interrupts.CPU123.RES:Rescheduling_interrupts
      2251 ±  3%      +7.9%       2428 ±  3%  interrupts.CPU123.TLB:TLB_shootdowns
    138.50 ± 21%     +52.2%     210.75 ± 16%  interrupts.CPU124.RES:Rescheduling_interrupts
      3063 ±  3%     -17.7%       2522 ±  8%  interrupts.CPU126.CAL:Function_call_interrupts
      2465 ±  7%     -12.4%       2159 ± 10%  interrupts.CPU126.TLB:TLB_shootdowns
      3020 ±  7%     -16.6%       2520 ±  6%  interrupts.CPU127.CAL:Function_call_interrupts
    150.50 ± 11%     -27.6%     109.00 ± 12%  interrupts.CPU127.RES:Rescheduling_interrupts
      3088 ±  4%     -20.4%       2460 ±  8%  interrupts.CPU128.CAL:Function_call_interrupts
      2387 ±  8%      -9.6%       2157 ±  4%  interrupts.CPU128.TLB:TLB_shootdowns
      3023 ±  3%     -17.1%       2508 ± 11%  interrupts.CPU129.CAL:Function_call_interrupts
      2980 ±  4%     -14.5%       2549 ±  9%  interrupts.CPU130.CAL:Function_call_interrupts
      2973 ±  3%     -14.2%       2552 ±  8%  interrupts.CPU131.CAL:Function_call_interrupts
      2952 ±  2%     -13.8%       2544 ±  7%  interrupts.CPU132.CAL:Function_call_interrupts
      3057 ±  2%     -15.9%       2571 ±  8%  interrupts.CPU133.CAL:Function_call_interrupts
    124.25 ±  8%     +34.4%     167.00 ± 10%  interrupts.CPU133.RES:Rescheduling_interrupts
      3068           -18.1%       2512 ±  8%  interrupts.CPU134.CAL:Function_call_interrupts
      2435 ±  3%     -11.1%       2165 ±  6%  interrupts.CPU134.TLB:TLB_shootdowns
      3034 ±  3%     -15.2%       2572 ±  9%  interrupts.CPU135.CAL:Function_call_interrupts
      3034 ±  3%     -17.3%       2510 ±  9%  interrupts.CPU136.CAL:Function_call_interrupts
      2387 ±  5%      -8.8%       2178 ±  7%  interrupts.CPU136.TLB:TLB_shootdowns
      3009 ±  5%     -14.6%       2569 ±  8%  interrupts.CPU137.CAL:Function_call_interrupts
      2992 ±  4%     -14.2%       2567 ±  7%  interrupts.CPU138.CAL:Function_call_interrupts
      3006 ±  2%     -16.0%       2526 ±  9%  interrupts.CPU139.CAL:Function_call_interrupts
      2412 ±  3%     -11.6%       2133 ±  8%  interrupts.CPU139.TLB:TLB_shootdowns
      3038 ±  3%     -16.4%       2539 ±  9%  interrupts.CPU140.CAL:Function_call_interrupts
    133.75 ± 21%     +29.7%     173.50 ±  5%  interrupts.CPU140.RES:Rescheduling_interrupts
      3011 ±  4%     -15.6%       2541 ±  9%  interrupts.CPU141.CAL:Function_call_interrupts
      2966 ±  6%     -13.0%       2581 ±  9%  interrupts.CPU142.CAL:Function_call_interrupts
      3183 ±  2%     -17.9%       2615 ±  9%  interrupts.CPU143.CAL:Function_call_interrupts
      3017 ±  2%     -14.2%       2589 ±  7%  interrupts.CPU17.CAL:Function_call_interrupts
      3021 ±  2%     -13.1%       2624 ±  7%  interrupts.CPU19.CAL:Function_call_interrupts
      3056 ±  6%     -14.4%       2615 ±  8%  interrupts.CPU21.CAL:Function_call_interrupts
      2965 ±  3%     -13.3%       2571 ±  9%  interrupts.CPU25.CAL:Function_call_interrupts
      3015 ±  3%     -15.4%       2550 ± 10%  interrupts.CPU26.CAL:Function_call_interrupts
      3031 ±  3%     -14.4%       2594 ±  8%  interrupts.CPU28.CAL:Function_call_interrupts
      5104 ± 21%     +55.9%       7958        interrupts.CPU28.NMI:Non-maskable_interrupts
      5104 ± 21%     +55.9%       7958        interrupts.CPU28.PMI:Performance_monitoring_interrupts
      3060 ±  4%     -13.3%       2653 ±  4%  interrupts.CPU3.CAL:Function_call_interrupts
      5443 ± 28%     +39.0%       7569 ± 11%  interrupts.CPU30.NMI:Non-maskable_interrupts
      5443 ± 28%     +39.0%       7569 ± 11%  interrupts.CPU30.PMI:Performance_monitoring_interrupts
      3105 ±  6%     -16.2%       2601 ± 11%  interrupts.CPU32.CAL:Function_call_interrupts
      6496 ± 26%     -22.7%       5019 ± 34%  interrupts.CPU34.NMI:Non-maskable_interrupts
      6496 ± 26%     -22.7%       5019 ± 34%  interrupts.CPU34.PMI:Performance_monitoring_interrupts
    387.00 ±  3%     -14.7%     330.25 ±  8%  interrupts.CPU35.RES:Rescheduling_interrupts
      3001 ±  5%     -11.8%       2647 ±  9%  interrupts.CPU40.CAL:Function_call_interrupts
      3085           -14.2%       2648 ±  9%  interrupts.CPU41.CAL:Function_call_interrupts
      4038           +98.2%       8005        interrupts.CPU51.NMI:Non-maskable_interrupts
      4038           +98.2%       8005        interrupts.CPU51.PMI:Performance_monitoring_interrupts
      3033 ±  3%     -16.0%       2547 ±  9%  interrupts.CPU54.CAL:Function_call_interrupts
      2942 ±  6%     -14.6%       2514 ±  7%  interrupts.CPU55.CAL:Function_call_interrupts
      3099 ±  6%     -17.8%       2547 ± 10%  interrupts.CPU56.CAL:Function_call_interrupts
      3039 ±  2%     -16.8%       2527 ± 10%  interrupts.CPU57.CAL:Function_call_interrupts
      2495 ±  2%     -12.6%       2179 ±  6%  interrupts.CPU57.TLB:TLB_shootdowns
      2984           -15.9%       2511 ± 10%  interrupts.CPU58.CAL:Function_call_interrupts
      2324 ±  6%      -8.6%       2124 ±  7%  interrupts.CPU58.TLB:TLB_shootdowns
      3006           -15.3%       2545 ±  9%  interrupts.CPU59.CAL:Function_call_interrupts
      2378 ±  5%      -9.5%       2151 ±  7%  interrupts.CPU59.TLB:TLB_shootdowns
      2977 ±  2%     -13.8%       2566 ±  9%  interrupts.CPU60.CAL:Function_call_interrupts
      4048           +85.4%       7506 ±  9%  interrupts.CPU60.NMI:Non-maskable_interrupts
      4048           +85.4%       7506 ±  9%  interrupts.CPU60.PMI:Performance_monitoring_interrupts
      3107           -20.3%       2477 ±  8%  interrupts.CPU61.CAL:Function_call_interrupts
      2455 ±  4%     -12.9%       2138 ±  9%  interrupts.CPU61.TLB:TLB_shootdowns
      3072 ±  5%     -19.0%       2489 ±  8%  interrupts.CPU62.CAL:Function_call_interrupts
    404.00 ±  3%     -24.7%     304.25 ± 16%  interrupts.CPU62.RES:Rescheduling_interrupts
      2989 ±  2%     -14.0%       2571 ±  9%  interrupts.CPU63.CAL:Function_call_interrupts
    396.00 ±  2%     -21.2%     312.00 ± 13%  interrupts.CPU63.RES:Rescheduling_interrupts
      3041           -16.6%       2535 ± 10%  interrupts.CPU64.CAL:Function_call_interrupts
    413.50 ± 14%     -25.8%     307.00 ± 15%  interrupts.CPU64.RES:Rescheduling_interrupts
      2978           -16.0%       2500 ± 10%  interrupts.CPU65.CAL:Function_call_interrupts
    393.50 ±  4%     -26.7%     288.25 ± 16%  interrupts.CPU65.RES:Rescheduling_interrupts
      3077 ±  6%     -18.1%       2521 ±  9%  interrupts.CPU66.CAL:Function_call_interrupts
    392.50 ±  3%     -27.0%     286.50 ± 22%  interrupts.CPU66.RES:Rescheduling_interrupts
      2353 ±  6%      -7.9%       2167 ±  5%  interrupts.CPU66.TLB:TLB_shootdowns
      3000           -17.1%       2486 ±  8%  interrupts.CPU67.CAL:Function_call_interrupts
    392.50 ±  3%     -27.5%     284.50 ± 11%  interrupts.CPU67.RES:Rescheduling_interrupts
      2454 ±  6%     -13.2%       2129 ±  7%  interrupts.CPU67.TLB:TLB_shootdowns
    369.75 ±  4%     -22.7%     286.00 ± 23%  interrupts.CPU68.RES:Rescheduling_interrupts
      3102 ±  7%     -16.5%       2592 ±  9%  interrupts.CPU69.CAL:Function_call_interrupts
    385.75 ±  5%     -25.5%     287.25 ± 17%  interrupts.CPU69.RES:Rescheduling_interrupts
      2353 ±  5%      -9.1%       2140 ±  6%  interrupts.CPU69.TLB:TLB_shootdowns
      3030 ±  2%     -16.2%       2539 ±  9%  interrupts.CPU70.CAL:Function_call_interrupts
    367.50 ±  3%     -21.7%     287.75 ± 15%  interrupts.CPU70.RES:Rescheduling_interrupts
      2447 ±  4%      -9.5%       2214 ±  5%  interrupts.CPU70.TLB:TLB_shootdowns
      2990 ±  2%     -17.8%       2459 ± 11%  interrupts.CPU71.CAL:Function_call_interrupts
    373.00 ±  7%     -24.6%     281.25 ± 22%  interrupts.CPU71.RES:Rescheduling_interrupts
    392.00 ±  2%     -20.0%     313.75 ±  9%  interrupts.CPU73.RES:Rescheduling_interrupts
    413.25           -20.1%     330.00 ±  7%  interrupts.CPU74.RES:Rescheduling_interrupts
      3084 ±  4%     -14.0%       2653 ±  7%  interrupts.CPU75.CAL:Function_call_interrupts
    401.75 ±  3%     -24.1%     304.75 ± 17%  interrupts.CPU75.RES:Rescheduling_interrupts
    384.25 ±  3%     -20.0%     307.50 ±  8%  interrupts.CPU76.RES:Rescheduling_interrupts
    410.50 ±  3%     -25.8%     304.50 ±  6%  interrupts.CPU77.RES:Rescheduling_interrupts
    389.50 ±  9%     -22.9%     300.25 ± 13%  interrupts.CPU78.RES:Rescheduling_interrupts
    378.50 ±  2%     -18.8%     307.50 ±  8%  interrupts.CPU79.RES:Rescheduling_interrupts
      3099 ±  6%     -15.6%       2615 ±  8%  interrupts.CPU8.CAL:Function_call_interrupts
    388.50 ±  3%     -21.5%     305.00 ± 11%  interrupts.CPU80.RES:Rescheduling_interrupts
    377.00 ±  6%     -20.2%     300.75 ± 11%  interrupts.CPU81.RES:Rescheduling_interrupts
    380.25 ±  3%     -22.9%     293.00 ± 14%  interrupts.CPU82.RES:Rescheduling_interrupts
    365.25 ±  7%     -26.6%     268.00 ± 11%  interrupts.CPU83.RES:Rescheduling_interrupts
      3010 ±  3%     -15.2%       2551 ±  7%  interrupts.CPU84.CAL:Function_call_interrupts
      7889 ±  4%     -22.1%       6149 ± 24%  interrupts.CPU84.NMI:Non-maskable_interrupts
      7889 ±  4%     -22.1%       6149 ± 24%  interrupts.CPU84.PMI:Performance_monitoring_interrupts
    377.00 ±  7%     -28.4%     269.75 ± 16%  interrupts.CPU84.RES:Rescheduling_interrupts
    359.25 ±  4%     -22.1%     279.75 ± 13%  interrupts.CPU86.RES:Rescheduling_interrupts
      3056 ±  4%     -14.9%       2600 ±  8%  interrupts.CPU87.CAL:Function_call_interrupts
    356.50 ± 11%     -29.5%     251.25 ± 19%  interrupts.CPU87.RES:Rescheduling_interrupts
      3042 ±  4%     -13.6%       2628 ±  6%  interrupts.CPU89.CAL:Function_call_interrupts
      2998 ±  4%     -13.2%       2602 ± 10%  interrupts.CPU90.CAL:Function_call_interrupts
    240.25 ± 16%     -29.9%     168.50 ± 11%  interrupts.CPU91.RES:Rescheduling_interrupts
      3062 ±  2%     -15.1%       2599 ±  7%  interrupts.CPU93.CAL:Function_call_interrupts
      2988 ±  3%     -13.0%       2598 ±  9%  interrupts.CPU94.CAL:Function_call_interrupts
      3171 ±  8%     -18.8%       2576 ± 10%  interrupts.CPU95.CAL:Function_call_interrupts
    128.00 ± 17%     +42.2%     182.00 ± 11%  interrupts.CPU98.RES:Rescheduling_interrupts
    131.75 ± 16%     +30.4%     171.75 ± 12%  interrupts.CPU99.RES:Rescheduling_interrupts
     35.99 ± 10%     -36.0        0.00        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.inode_sb_list_add.new_inode.shmem_get_inode
     35.21 ± 10%     -35.2        0.00        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.evict.do_unlinkat.do_syscall_64
      6.04 ± 64%      -6.0        0.00        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.pick_file.__close_fd.__x64_sys_close
      5.90 ± 63%      -5.9        0.00        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.__alloc_fd.do_sys_openat2.do_sys_open
      6.34 ± 61%      -4.8        1.56 ± 27%  perf-profile.calltrace.cycles-pp.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close
      6.21 ± 62%      -4.8        1.44 ± 28%  perf-profile.calltrace.cycles-pp.pick_file.__close_fd.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe
      6.22 ± 62%      -4.8        1.44 ± 28%  perf-profile.calltrace.cycles-pp.__close_fd.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close
      6.14 ± 63%      -4.8        1.38 ± 29%  perf-profile.calltrace.cycles-pp._raw_spin_lock.pick_file.__close_fd.__x64_sys_close.do_syscall_64
      6.42 ± 60%      -4.7        1.71 ± 24%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close
      6.19 ± 60%      -4.7        1.54 ± 26%  perf-profile.calltrace.cycles-pp.__alloc_fd.do_sys_openat2.do_sys_open.do_syscall_64.entry_SYSCALL_64_after_hwframe
      6.01 ± 62%      -4.6        1.39 ± 28%  perf-profile.calltrace.cycles-pp._raw_spin_lock.__alloc_fd.do_sys_openat2.do_sys_open.do_syscall_64
      6.95 ± 55%      -4.5        2.48 ± 17%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__close
      0.57 ±  3%      +0.2        0.77 ±  2%  perf-profile.calltrace.cycles-pp.__alloc_file.alloc_empty_file.path_openat.do_filp_open.do_sys_openat2
      0.58 ±  3%      +0.2        0.77 ±  2%  perf-profile.calltrace.cycles-pp.alloc_empty_file.path_openat.do_filp_open.do_sys_openat2.do_sys_open
      0.59 ±  7%      +0.3        0.87 ±  5%  perf-profile.calltrace.cycles-pp.file_free_rcu.rcu_do_batch.rcu_core.__softirqentry_text_start.run_ksoftirqd
      0.44 ± 58%      +0.3        0.75        perf-profile.calltrace.cycles-pp.new_inode_pseudo.new_inode.shmem_get_inode.shmem_mknod.path_openat
      0.28 ±100%      +0.4        0.69        perf-profile.calltrace.cycles-pp.alloc_inode.new_inode_pseudo.new_inode.shmem_get_inode.shmem_mknod
      0.26 ±100%      +0.5        0.72 ±  2%  perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.entry_SYSCALL_64_after_hwframe.__close
      0.00            +0.5        0.52        perf-profile.calltrace.cycles-pp.kmem_cache_alloc.shmem_alloc_inode.alloc_inode.new_inode_pseudo.new_inode
      0.00            +0.5        0.52 ±  2%  perf-profile.calltrace.cycles-pp.d_alloc_parallel.path_openat.do_filp_open.do_sys_openat2.do_sys_open
      0.00            +0.5        0.53 ±  2%  perf-profile.calltrace.cycles-pp.shmem_alloc_inode.alloc_inode.new_inode_pseudo.new_inode.shmem_get_inode
      0.58 ±  8%      +0.6        1.20 ± 11%  perf-profile.calltrace.cycles-pp.page_counter_cancel.page_counter_uncharge.drain_obj_stock.refill_obj_stock.kmem_cache_free
      0.68 ±  7%      +0.7        1.40 ± 12%  perf-profile.calltrace.cycles-pp.page_counter_uncharge.drain_obj_stock.refill_obj_stock.kmem_cache_free.rcu_do_batch
      0.27 ±100%      +0.9        1.12 ±  8%  perf-profile.calltrace.cycles-pp.propagate_protected_usage.page_counter_cancel.page_counter_uncharge.__memcg_kmem_uncharge.drain_obj_stock
      0.00            +1.3        1.31 ± 30%  perf-profile.calltrace.cycles-pp.__cna_queued_spin_lock_slowpath._raw_spin_lock.pick_file.__close_fd.__x64_sys_close
      0.00            +1.3        1.31 ± 29%  perf-profile.calltrace.cycles-pp.__cna_queued_spin_lock_slowpath._raw_spin_lock.__alloc_fd.do_sys_openat2.do_sys_open
      1.41 ±  9%      +1.8        3.25 ± 10%  perf-profile.calltrace.cycles-pp.page_counter_cancel.page_counter_uncharge.__memcg_kmem_uncharge.drain_obj_stock.refill_obj_stock
      1.51 ±  9%      +2.0        3.52 ± 10%  perf-profile.calltrace.cycles-pp.page_counter_uncharge.__memcg_kmem_uncharge.drain_obj_stock.refill_obj_stock.kmem_cache_free
      1.52 ±  8%      +2.0        3.54 ± 10%  perf-profile.calltrace.cycles-pp.__memcg_kmem_uncharge.drain_obj_stock.refill_obj_stock.kmem_cache_free.rcu_do_batch
      2.75 ±  7%      +3.3        6.05 ± 10%  perf-profile.calltrace.cycles-pp.drain_obj_stock.refill_obj_stock.kmem_cache_free.rcu_do_batch.rcu_core
      3.29 ±  6%      +3.8        7.09 ± 11%  perf-profile.calltrace.cycles-pp.refill_obj_stock.kmem_cache_free.rcu_do_batch.rcu_core.__softirqentry_text_start
      6.32 ±  3%      +6.8       13.10 ± 11%  perf-profile.calltrace.cycles-pp.kmem_cache_free.rcu_do_batch.rcu_core.__softirqentry_text_start.run_ksoftirqd
      7.13 ±  3%      +7.3       14.40 ± 11%  perf-profile.calltrace.cycles-pp.rcu_core.__softirqentry_text_start.run_ksoftirqd.smpboot_thread_fn.kthread
      7.13 ±  3%      +7.3       14.40 ± 11%  perf-profile.calltrace.cycles-pp.rcu_do_batch.rcu_core.__softirqentry_text_start.run_ksoftirqd.smpboot_thread_fn
      7.14 ±  3%      +7.3       14.41 ± 11%  perf-profile.calltrace.cycles-pp.run_ksoftirqd.smpboot_thread_fn.kthread.ret_from_fork
      7.14 ±  3%      +7.3       14.41 ± 11%  perf-profile.calltrace.cycles-pp.__softirqentry_text_start.run_ksoftirqd.smpboot_thread_fn.kthread.ret_from_fork
      7.14 ±  3%      +7.3       14.43 ± 11%  perf-profile.calltrace.cycles-pp.smpboot_thread_fn.kthread.ret_from_fork
      7.16 ±  3%      +7.3       14.44 ± 11%  perf-profile.calltrace.cycles-pp.ret_from_fork
      7.16 ±  3%      +7.3       14.44 ± 11%  perf-profile.calltrace.cycles-pp.kthread.ret_from_fork
      0.00           +33.5       33.55        perf-profile.calltrace.cycles-pp.__cna_queued_spin_lock_slowpath._raw_spin_lock.evict.do_unlinkat.do_syscall_64
      0.00           +35.9       35.91        perf-profile.calltrace.cycles-pp.__cna_queued_spin_lock_slowpath._raw_spin_lock.inode_sb_list_add.new_inode.shmem_get_inode
     84.08           -84.1        0.00        perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
     84.97            -9.3       75.70 ±  2%  perf-profile.children.cycles-pp._raw_spin_lock
     91.29            -8.1       83.23        perf-profile.children.cycles-pp.do_syscall_64
     92.33            -7.5       84.80        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
      6.22 ± 62%      -4.8        1.44 ± 28%  perf-profile.children.cycles-pp.pick_file
      6.34 ± 61%      -4.8        1.56 ± 27%  perf-profile.children.cycles-pp.__x64_sys_close
      6.22 ± 62%      -4.8        1.44 ± 28%  perf-profile.children.cycles-pp.__close_fd
      6.19 ± 60%      -4.6        1.54 ± 26%  perf-profile.children.cycles-pp.__alloc_fd
      0.17 ± 13%      -0.1        0.11        perf-profile.children.cycles-pp.__mnt_want_write
      0.20 ± 11%      -0.0        0.16 ±  7%  perf-profile.children.cycles-pp.destroy_inode
      0.18 ±  6%      -0.0        0.13 ±  8%  perf-profile.children.cycles-pp.__destroy_inode
      0.16 ±  2%      -0.0        0.12 ±  4%  perf-profile.children.cycles-pp.inode_wait_for_writeback
      0.09            -0.0        0.06 ± 11%  perf-profile.children.cycles-pp.drop_nlink
      0.10 ±  4%      -0.0        0.08 ±  5%  perf-profile.children.cycles-pp._find_next_bit
      0.10            -0.0        0.08 ±  5%  perf-profile.children.cycles-pp.__list_add_valid
      0.07 ±  7%      +0.0        0.08 ±  5%  perf-profile.children.cycles-pp.__memcg_kmem_charge
      0.05            +0.0        0.07        perf-profile.children.cycles-pp.lockref_put_or_lock
      0.12 ±  9%      +0.0        0.14 ±  6%  perf-profile.children.cycles-pp.security_file_alloc
      0.05 ±  8%      +0.0        0.08 ±  6%  perf-profile.children.cycles-pp._cond_resched
      0.07 ±  7%      +0.0        0.09 ±  7%  perf-profile.children.cycles-pp._raw_spin_lock_irq
      0.04 ± 57%      +0.0        0.06 ±  6%  perf-profile.children.cycles-pp.security_path_unlink
      0.10 ±  8%      +0.0        0.13 ±  5%  perf-profile.children.cycles-pp.simple_lookup
      0.08            +0.0        0.11 ±  4%  perf-profile.children.cycles-pp.shmem_undo_range
      0.05            +0.0        0.08 ±  5%  perf-profile.children.cycles-pp.step_into
      0.06            +0.0        0.09        perf-profile.children.cycles-pp.d_add
      0.11 ±  4%      +0.0        0.14 ±  6%  perf-profile.children.cycles-pp.obj_cgroup_charge
      0.09 ±  4%      +0.0        0.12 ±  4%  perf-profile.children.cycles-pp.shmem_truncate_range
      0.04 ± 57%      +0.0        0.07        perf-profile.children.cycles-pp.path_init
      0.04 ± 57%      +0.0        0.07        perf-profile.children.cycles-pp.__x86_retpoline_rax
      0.19 ±  8%      +0.0        0.23 ±  2%  perf-profile.children.cycles-pp.__fput
      0.06            +0.0        0.10 ±  4%  perf-profile.children.cycles-pp.__check_object_size
      0.04 ± 57%      +0.0        0.08 ±  6%  perf-profile.children.cycles-pp.__might_sleep
      0.08 ±  6%      +0.0        0.11 ±  4%  perf-profile.children.cycles-pp.__dentry_kill
      0.06 ±  9%      +0.0        0.10 ±  9%  perf-profile.children.cycles-pp.lookup_fast
      0.07 ±  7%      +0.0        0.11 ±  4%  perf-profile.children.cycles-pp.___might_sleep
      0.06            +0.0        0.10 ± 10%  perf-profile.children.cycles-pp.ring_buffer_unlock_commit
      0.06            +0.0        0.11 ± 12%  perf-profile.children.cycles-pp.trace_clock_x86_tsc
      0.06 ±  9%      +0.0        0.10 ±  4%  perf-profile.children.cycles-pp.shmem_free_in_core_inode
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.rcu_segcblist_enqueue
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.down_write
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.find_get_entries
      0.09            +0.1        0.14 ±  3%  perf-profile.children.cycles-pp.call_rcu
      0.09            +0.1        0.14 ±  5%  perf-profile.children.cycles-pp.__x64_sys_unlink
      0.00            +0.1        0.06 ±  9%  perf-profile.children.cycles-pp.fsnotify_destroy_marks
      0.17 ±  4%      +0.1        0.23 ±  5%  perf-profile.children.cycles-pp.get_obj_cgroup_from_current
      0.00            +0.1        0.06        perf-profile.children.cycles-pp.i_callback
      0.08 ±  5%      +0.1        0.14 ±  5%  perf-profile.children.cycles-pp.trace_buffer_unlock_commit_regs
      0.06 ±  7%      +0.1        0.12 ± 18%  perf-profile.children.cycles-pp.__mod_memcg_state
      0.00            +0.1        0.06 ± 13%  perf-profile.children.cycles-pp.__init_rwsem
      0.01 ±173%      +0.1        0.08 ±  6%  perf-profile.children.cycles-pp.__d_lookup_rcu
      0.25 ±  6%      +0.1        0.32 ±  2%  perf-profile.children.cycles-pp.task_work_run
      0.10            +0.1        0.17 ±  2%  perf-profile.children.cycles-pp.strncpy_from_user
      0.00            +0.1        0.07 ± 10%  perf-profile.children.cycles-pp.rb_commit
      0.13 ± 17%      +0.1        0.21 ± 15%  perf-profile.children.cycles-pp.secondary_startup_64_no_verify
      0.13 ± 17%      +0.1        0.21 ± 15%  perf-profile.children.cycles-pp.cpu_startup_entry
      0.13 ± 17%      +0.1        0.21 ± 15%  perf-profile.children.cycles-pp.do_idle
      0.13 ± 17%      +0.1        0.21 ± 15%  perf-profile.children.cycles-pp.cpuidle_enter
      0.13 ± 17%      +0.1        0.21 ± 15%  perf-profile.children.cycles-pp.cpuidle_enter_state
      0.13 ± 17%      +0.1        0.21 ± 15%  perf-profile.children.cycles-pp.start_secondary
      0.12            +0.1        0.20 ±  5%  perf-profile.children.cycles-pp.walk_component
      0.35 ±  3%      +0.1        0.43 ±  6%  perf-profile.children.cycles-pp.path_parentat
      0.14 ±  3%      +0.1        0.22 ±  3%  perf-profile.children.cycles-pp.__entry_text_start
      0.15 ±  2%      +0.1        0.24 ±  4%  perf-profile.children.cycles-pp.syscall_return_via_sysret
      0.12 ±  5%      +0.1        0.20 ± 10%  perf-profile.children.cycles-pp.__rb_reserve_next
      0.08 ±  8%      +0.1        0.17 ± 14%  perf-profile.children.cycles-pp.__mod_memcg_lruvec_state
      0.36 ±  4%      +0.1        0.46 ±  6%  perf-profile.children.cycles-pp.filename_parentat
      0.16 ±  2%      +0.1        0.25 ±  4%  perf-profile.children.cycles-pp.getname_flags
      0.06 ±  7%      +0.1        0.16 ±  9%  perf-profile.children.cycles-pp.inode_init_once
      0.36 ±  4%      +0.1        0.47 ±  4%  perf-profile.children.cycles-pp.exit_to_user_mode_prepare
      0.58 ±  5%      +0.1        0.69 ±  9%  perf-profile.children.cycles-pp.link_path_walk
      0.00            +0.1        0.11 ± 15%  perf-profile.children.cycles-pp.cna_order_queue
      0.17 ±  2%      +0.1        0.29 ±  6%  perf-profile.children.cycles-pp.ring_buffer_lock_reserve
      0.20 ±  2%      +0.1        0.32 ±  7%  perf-profile.children.cycles-pp.ftrace_syscall_exit
      0.15 ±  3%      +0.1        0.27 ±  4%  perf-profile.children.cycles-pp.rcu_cblist_dequeue
      0.27 ±  3%      +0.1        0.41 ±  2%  perf-profile.children.cycles-pp.__d_alloc
      0.13 ±  5%      +0.1        0.27 ±  8%  perf-profile.children.cycles-pp.__slab_free
      0.21 ±  2%      +0.1        0.36 ±  7%  perf-profile.children.cycles-pp.trace_buffer_lock_reserve
      0.21 ±  2%      +0.1        0.35 ±  8%  perf-profile.children.cycles-pp.ftrace_syscall_enter
      0.36 ±  2%      +0.2        0.52 ±  2%  perf-profile.children.cycles-pp.d_alloc_parallel
      0.23 ±  2%      +0.2        0.39 ±  7%  perf-profile.children.cycles-pp.syscall_trace_enter
      0.29 ±  3%      +0.2        0.47 ±  2%  perf-profile.children.cycles-pp.d_alloc
      0.57 ±  8%      +0.2        0.75        perf-profile.children.cycles-pp.new_inode_pseudo
      0.58 ±  3%      +0.2        0.77 ±  2%  perf-profile.children.cycles-pp.__alloc_file
      0.51 ±  8%      +0.2        0.70        perf-profile.children.cycles-pp.alloc_inode
      0.33 ±  3%      +0.2        0.53        perf-profile.children.cycles-pp.shmem_alloc_inode
      0.12 ±  3%      +0.2        0.32 ± 10%  perf-profile.children.cycles-pp.___slab_alloc
      0.11 ±  4%      +0.2        0.31 ± 10%  perf-profile.children.cycles-pp.allocate_slab
      0.58 ±  2%      +0.2        0.78 ±  2%  perf-profile.children.cycles-pp.alloc_empty_file
      0.12 ±  3%      +0.2        0.32 ± 11%  perf-profile.children.cycles-pp.__slab_alloc
      0.62 ±  7%      +0.3        0.91 ±  5%  perf-profile.children.cycles-pp.file_free_rcu
      1.02 ±  2%      +0.5        1.54 ±  3%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      0.91 ±  3%      +0.5        1.43        perf-profile.children.cycles-pp.kmem_cache_alloc
      0.14 ± 11%      +0.6        0.74 ±100%  perf-profile.children.cycles-pp.terminate_walk
      0.09 ±  9%      +0.7        0.74 ±115%  perf-profile.children.cycles-pp.lockref_get_not_dead
      0.12 ± 10%      +0.7        0.79 ±108%  perf-profile.children.cycles-pp.__legitimize_path
      0.13 ±  8%      +0.7        0.82 ±104%  perf-profile.children.cycles-pp.unlazy_walk
      0.31 ±  4%      +0.7        1.01 ± 74%  perf-profile.children.cycles-pp.dput
      0.66 ±  9%      +0.7        1.40 ±  7%  perf-profile.children.cycles-pp.propagate_protected_usage
      1.70 ±  8%      +2.0        3.70 ±  9%  perf-profile.children.cycles-pp.__memcg_kmem_uncharge
      2.23 ±  8%      +2.4        4.67 ±  9%  perf-profile.children.cycles-pp.page_counter_cancel
      2.45 ±  8%      +2.7        5.17 ±  9%  perf-profile.children.cycles-pp.page_counter_uncharge
      3.09 ±  6%      +3.3        6.38 ±  9%  perf-profile.children.cycles-pp.drain_obj_stock
      3.71 ±  5%      +3.8        7.49 ±  9%  perf-profile.children.cycles-pp.refill_obj_stock
      7.12 ±  3%      +6.8       13.93 ± 10%  perf-profile.children.cycles-pp.kmem_cache_free
      7.14 ±  3%      +7.3       14.41 ± 11%  perf-profile.children.cycles-pp.run_ksoftirqd
      7.14 ±  3%      +7.3       14.43 ± 11%  perf-profile.children.cycles-pp.smpboot_thread_fn
      7.16 ±  3%      +7.3       14.44 ± 11%  perf-profile.children.cycles-pp.ret_from_fork
      7.16 ±  3%      +7.3       14.44 ± 11%  perf-profile.children.cycles-pp.kthread
      7.98 ±  2%      +7.3       15.28 ±  9%  perf-profile.children.cycles-pp.rcu_core
      7.98 ±  2%      +7.3       15.27 ±  9%  perf-profile.children.cycles-pp.rcu_do_batch
      8.00 ±  2%      +7.3       15.29 ±  9%  perf-profile.children.cycles-pp.__softirqentry_text_start
      0.00           +74.9       74.89 ±  2%  perf-profile.children.cycles-pp.__cna_queued_spin_lock_slowpath
     82.90           -82.9        0.00        perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
      0.15 ±  6%      -0.1        0.10 ±  9%  perf-profile.self.cycles-pp.__destroy_inode
      0.16 ± 14%      -0.1        0.11 ±  4%  perf-profile.self.cycles-pp.__mnt_want_write
      0.09            -0.0        0.06 ± 11%  perf-profile.self.cycles-pp.drop_nlink
      0.10 ±  4%      -0.0        0.08 ±  5%  perf-profile.self.cycles-pp._find_next_bit
      0.06 ±  6%      -0.0        0.04 ± 57%  perf-profile.self.cycles-pp.d_alloc_parallel
      0.09 ±  7%      -0.0        0.07 ± 12%  perf-profile.self.cycles-pp.fput_many
      0.10 ±  4%      -0.0        0.08 ±  5%  perf-profile.self.cycles-pp.__list_add_valid
      0.07 ±  7%      -0.0        0.05 ±  8%  perf-profile.self.cycles-pp.shmem_free_inode
      0.06 ± 11%      +0.0        0.08 ±  6%  perf-profile.self.cycles-pp.__d_alloc
      0.07 ±  7%      +0.0        0.09 ±  9%  perf-profile.self.cycles-pp._raw_spin_lock_irq
      0.07 ±  7%      +0.0        0.09 ±  4%  perf-profile.self.cycles-pp.exit_to_user_mode_prepare
      0.08            +0.0        0.10 ±  4%  perf-profile.self.cycles-pp.lockref_get_not_dead
      0.05            +0.0        0.08 ±  6%  perf-profile.self.cycles-pp.ring_buffer_lock_reserve
      0.04 ± 57%      +0.0        0.07 ±  7%  perf-profile.self.cycles-pp.page_counter_try_charge
      0.07 ±  7%      +0.0        0.10 ±  8%  perf-profile.self.cycles-pp.link_path_walk
      0.05            +0.0        0.09 ±  9%  perf-profile.self.cycles-pp.__rb_reserve_next
      0.06            +0.0        0.10 ± 10%  perf-profile.self.cycles-pp.trace_clock_x86_tsc
      0.04 ± 57%      +0.0        0.08 ± 10%  perf-profile.self.cycles-pp.ftrace_syscall_enter
      0.06 ±  6%      +0.0        0.10 ±  4%  perf-profile.self.cycles-pp.___might_sleep
      0.06 ±  9%      +0.0        0.10        perf-profile.self.cycles-pp.shmem_free_in_core_inode
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.strncpy_from_user
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.obj_cgroup_charge
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.rcu_segcblist_enqueue
      0.03 ±100%      +0.1        0.08 ±  6%  perf-profile.self.cycles-pp.call_rcu
      0.00            +0.1        0.05 ±  8%  perf-profile.self.cycles-pp.do_sys_open
      0.00            +0.1        0.05 ±  8%  perf-profile.self.cycles-pp.step_into
      0.00            +0.1        0.06 ±  9%  perf-profile.self.cycles-pp.lockref_put_or_lock
      0.16 ±  2%      +0.1        0.21 ±  5%  perf-profile.self.cycles-pp.get_obj_cgroup_from_current
      0.00            +0.1        0.06 ±  7%  perf-profile.self.cycles-pp.__init_rwsem
      0.00            +0.1        0.06        perf-profile.self.cycles-pp.dput
      0.00            +0.1        0.06        perf-profile.self.cycles-pp.ftrace_syscall_exit
      0.00            +0.1        0.06        perf-profile.self.cycles-pp.__x86_retpoline_rax
      0.00            +0.1        0.06        perf-profile.self.cycles-pp.i_callback
      0.06 ±  7%      +0.1        0.12 ± 18%  perf-profile.self.cycles-pp.__mod_memcg_state
      0.00            +0.1        0.07 ±  7%  perf-profile.self.cycles-pp.__might_sleep
      0.00            +0.1        0.07 ±  6%  perf-profile.self.cycles-pp.rb_commit
      0.00            +0.1        0.07        perf-profile.self.cycles-pp.__d_lookup_rcu
      0.12 ±  3%      +0.1        0.19 ±  3%  perf-profile.self.cycles-pp.__entry_text_start
      0.15 ±  2%      +0.1        0.24 ±  4%  perf-profile.self.cycles-pp.syscall_return_via_sysret
      0.00            +0.1        0.10 ± 11%  perf-profile.self.cycles-pp.inode_init_once
      0.00            +0.1        0.11 ± 16%  perf-profile.self.cycles-pp.cna_order_queue
      0.00            +0.1        0.11 ± 13%  perf-profile.self.cycles-pp.allocate_slab
      0.14 ±  3%      +0.1        0.26 ±  4%  perf-profile.self.cycles-pp.rcu_cblist_dequeue
      0.13 ±  5%      +0.1        0.27 ±  8%  perf-profile.self.cycles-pp.__slab_free
      0.41 ±  5%      +0.2        0.58 ±  5%  perf-profile.self.cycles-pp.kmem_cache_alloc
      0.23 ±  9%      +0.3        0.50 ± 10%  perf-profile.self.cycles-pp.page_counter_uncharge
      0.62 ±  7%      +0.3        0.90 ±  5%  perf-profile.self.cycles-pp.file_free_rcu
      0.49            +0.3        0.78 ±  2%  perf-profile.self.cycles-pp.syscall_exit_to_user_mode
      0.60 ±  2%      +0.5        1.07 ± 11%  perf-profile.self.cycles-pp.refill_obj_stock
      0.63 ±  2%      +0.6        1.21 ± 14%  perf-profile.self.cycles-pp.drain_obj_stock
      0.66 ±  9%      +0.7        1.40 ±  7%  perf-profile.self.cycles-pp.propagate_protected_usage
      1.58 ±  7%      +1.7        3.28 ± 10%  perf-profile.self.cycles-pp.page_counter_cancel
      3.21            +2.8        5.98 ± 13%  perf-profile.self.cycles-pp.kmem_cache_free
      0.00           +73.6       73.64        perf-profile.self.cycles-pp.__cna_queued_spin_lock_slowpath



***************************************************************************************************
lkp-csl-2ap3: 192 threads Intel(R) Xeon(R) Platinum 9242 CPU @ 2.30GHz with 192G memory
=========================================================================================
compiler/cpufreq_governor/kconfig/nr_task/rootfs/runtime/tbox_group/test/testcase/ucode:
  gcc-9/performance/x86_64-rhel-8.3/100%/debian-10.4-x86_64-20200603.cgz/300s/lkp-csl-2ap3/fserver/reaim/0x5003003

commit: 
  268df4df6c ("locking/qspinlock: Refactor the qspinlock slow path")
  0dd6d5b8c0 ("locking/qspinlock: Introduce CNA into the slow path of qspinlock")

268df4df6cb0a27d 0dd6d5b8c0f6f31d8d557485fff 
---------------- --------------------------- 
       fail:runs  %reproduction    fail:runs
           |             |             |    
           :4            7%           0:4     perf-profile.children.cycles-pp.error_entry
         %stddev     %change         %stddev
             \          |                \  
    567.76           -63.8%     205.67        reaim.child_systime
     48.81            +4.6%      51.07        reaim.child_utime
    323828           +98.1%     641489        reaim.jobs_per_min
      1686           +98.1%       3341        reaim.jobs_per_min_child
     91.94            -9.5%      83.21        reaim.jti
    331995          +103.5%     675567        reaim.max_jobs_per_min
      3.59           -49.5%       1.82        reaim.parent_time
      7.57 ±  4%    +115.0%      16.29 ±  2%  reaim.std_dev_percent
    492218            +7.8%     530515 ±  2%  reaim.time.involuntary_context_switches
     37098 ±  4%     +99.2%      73891 ±  3%  reaim.time.major_page_faults
  1.03e+08           +46.0%  1.504e+08        reaim.time.minor_page_faults
     10959           -39.1%       6670        reaim.time.percent_of_cpu_this_job_got
     30517           -47.1%      16147        reaim.time.system_time
      2624           +52.8%       4009        reaim.time.user_time
   2545805 ±  4%     +32.3%    3368675        reaim.time.voluntary_context_switches
   1032000           +46.0%    1507200        reaim.workload
     32.78 ±  3%      -4.6%      31.26 ±  3%  boot-time.boot
     29149           +40.4%      40918        uptime.idle
  12938393 ± 15%     +53.9%   19907205 ±  2%  cpuidle.C1.time
    236410 ± 13%     +57.2%     371533 ±  2%  cpuidle.C1.usage
     40.95           +20.4       61.39        mpstat.cpu.all.idle%
      0.70            +1.6        2.27 ±  3%  mpstat.cpu.all.soft%
     52.54           -24.6       27.98        mpstat.cpu.all.sys%
      4.45            +2.3        6.76        mpstat.cpu.all.usr%
     41.00           +48.8%      61.00        vmstat.cpu.id
     53.75           -41.9%      31.25        vmstat.cpu.sy
    112.25           -24.1%      85.25 ±  3%  vmstat.procs.r
     23073 ±  3%     +38.8%      32033        vmstat.system.cs
     80058 ±  4%     -13.3%      69378 ±  6%  meminfo.Active
     80058 ±  4%     -13.3%      69378 ±  6%  meminfo.Active(anon)
     20491           +54.2%      31595        meminfo.PageTables
    476975           +13.3%     540477        meminfo.SUnreclaim
     95027 ±  4%     -11.9%      83755 ±  6%  meminfo.Shmem
    611188           +12.2%     685736        meminfo.Slab
  18615650           +42.3%   26487518        numa-numastat.node0.local_node
  18638967           +42.2%   26510799        numa-numastat.node0.numa_hit
  18702490           +48.5%   27780165 ±  4%  numa-numastat.node1.local_node
  18725859           +48.4%   27795790 ±  4%  numa-numastat.node1.numa_hit
  18422848           +50.6%   27737870 ±  3%  numa-numastat.node2.local_node
  18438526           +50.6%   27769007 ±  3%  numa-numastat.node2.numa_hit
  18641310           +44.6%   26947640 ±  2%  numa-numastat.node3.local_node
  18672435           +44.4%   26970998 ±  2%  numa-numastat.node3.numa_hit
      5107 ± 65%     +90.7%       9741 ± 43%  numa-meminfo.node1.PageTables
    117084 ± 18%     +25.4%     146782 ± 24%  numa-meminfo.node1.SUnreclaim
     37994 ± 16%     -32.6%      25602 ±  6%  numa-meminfo.node2.KReclaimable
     37994 ± 16%     -32.6%      25602 ±  6%  numa-meminfo.node2.SReclaimable
     74940 ±  5%     -13.5%      64798 ±  7%  numa-meminfo.node3.Active
     74940 ±  5%     -13.5%      64798 ±  7%  numa-meminfo.node3.Active(anon)
      7034 ±  2%     +17.4%       8260 ± 10%  numa-meminfo.node3.KernelStack
      3094 ±  9%    +124.6%       6950 ± 28%  numa-meminfo.node3.PageTables
    104367 ±  4%     +21.0%     126268 ± 11%  numa-meminfo.node3.SUnreclaim
     85363 ±  7%     -17.1%      70793 ±  4%  numa-meminfo.node3.Shmem
   9752445           +40.2%   13675852        numa-vmstat.node0.numa_hit
   9711209           +40.4%   13634832        numa-vmstat.node0.numa_local
      1301 ± 62%     +87.9%       2444 ± 44%  numa-vmstat.node1.nr_page_table_pages
     29310 ± 18%     +24.7%      36536 ± 24%  numa-vmstat.node1.nr_slab_unreclaimable
   9779097           +47.2%   14393295 ±  5%  numa-vmstat.node1.numa_hit
   9675259           +47.8%   14296919 ±  6%  numa-vmstat.node1.numa_local
      9498 ± 16%     -32.6%       6398 ±  6%  numa-vmstat.node2.nr_slab_reclaimable
   9673283           +46.4%   14159354 ±  2%  numa-vmstat.node2.numa_hit
   9578243           +46.7%   14047835 ±  2%  numa-vmstat.node2.numa_local
     18751 ±  4%     -13.5%      16221 ±  8%  numa-vmstat.node3.nr_active_anon
      7040 ±  2%     +17.5%       8273 ± 10%  numa-vmstat.node3.nr_kernel_stack
    791.00 ±  9%    +121.7%       1753 ± 27%  numa-vmstat.node3.nr_page_table_pages
     21319 ±  7%     -17.0%      17705 ±  4%  numa-vmstat.node3.nr_shmem
     26164 ±  3%     +20.5%      31538 ± 11%  numa-vmstat.node3.nr_slab_unreclaimable
     18751 ±  4%     -13.5%      16221 ±  8%  numa-vmstat.node3.nr_zone_active_anon
   9621900           +44.5%   13906971 ±  3%  numa-vmstat.node3.numa_hit
   9525222           +45.1%   13819200 ±  3%  numa-vmstat.node3.numa_local
     20021 ±  4%     -13.1%      17404 ±  6%  proc-vmstat.nr_active_anon
     81577            -4.3%      78062        proc-vmstat.nr_anon_pages
     84480            -4.5%      80695        proc-vmstat.nr_inactive_anon
     33607            +6.0%      35625        proc-vmstat.nr_kernel_stack
      5204           +53.5%       7987        proc-vmstat.nr_page_table_pages
     23723 ±  4%     -11.8%      20935 ±  6%  proc-vmstat.nr_shmem
     33577            +8.2%      36344        proc-vmstat.nr_slab_reclaimable
    119237           +13.3%     135075        proc-vmstat.nr_slab_unreclaimable
     20021 ±  4%     -13.1%      17404 ±  6%  proc-vmstat.nr_zone_active_anon
     84480            -4.5%      80695        proc-vmstat.nr_zone_inactive_anon
    110193 ± 12%     -88.3%      12923 ± 24%  proc-vmstat.numa_hint_faults
  74511118           +46.4%  1.091e+08        proc-vmstat.numa_hit
  74417590           +46.5%   1.09e+08        proc-vmstat.numa_local
    120094 ± 14%     -84.7%      18318 ± 54%  proc-vmstat.numa_pages_migrated
    236001 ± 20%     -22.3%     183274 ±  6%  proc-vmstat.numa_pte_updates
     73869 ±  2%     +25.3%      92565        proc-vmstat.pgactivate
  82036112           +47.7%  1.212e+08        proc-vmstat.pgalloc_normal
 1.043e+08           +45.5%  1.517e+08        proc-vmstat.pgfault
  82081519           +47.7%  1.212e+08        proc-vmstat.pgfree
    120094 ± 14%     -84.7%      18318 ± 54%  proc-vmstat.pgmigrate_success
  10561258           +46.5%   15473727        proc-vmstat.pgreuse
      1606 ±  7%     -13.6%       1387        slabinfo.Acpi-Parse.active_objs
      1606 ±  7%     -13.6%       1387        slabinfo.Acpi-Parse.num_objs
      1953 ±  2%      +7.7%       2103        slabinfo.cred_jar.active_slabs
     82060 ±  2%      +7.7%      88357        slabinfo.cred_jar.num_objs
      1953 ±  2%      +7.7%       2103        slabinfo.cred_jar.num_slabs
    237295           +17.9%     279659 ±  2%  slabinfo.dentry.active_objs
      5739           +17.8%       6763 ±  2%  slabinfo.dentry.active_slabs
    241054           +17.8%     284061 ±  2%  slabinfo.dentry.num_objs
      5739           +17.8%       6763 ±  2%  slabinfo.dentry.num_slabs
     14164           +15.8%      16405        slabinfo.files_cache.active_objs
     14164           +15.8%      16405        slabinfo.files_cache.num_objs
    143833           +64.0%     235906 ±  4%  slabinfo.filp.active_objs
      2268           +64.1%       3722 ±  3%  slabinfo.filp.active_slabs
    145179           +64.1%     238279 ±  3%  slabinfo.filp.num_objs
      2268           +64.1%       3722 ±  3%  slabinfo.filp.num_slabs
     64107           +10.8%      71046        slabinfo.kmalloc-512.active_objs
      1032           +24.0%       1281        slabinfo.kmalloc-512.active_slabs
     66141           +24.0%      82022        slabinfo.kmalloc-512.num_objs
      1032           +24.0%       1281        slabinfo.kmalloc-512.num_slabs
     10856           +19.5%      12973        slabinfo.mm_struct.active_objs
     10856           +19.5%      12974        slabinfo.mm_struct.num_objs
     36632 ±  2%     +66.2%      60869 ±  2%  slabinfo.pid.active_objs
    572.00 ±  2%     +66.2%     950.75 ±  2%  slabinfo.pid.active_slabs
     36632 ±  2%     +66.2%      60869 ±  2%  slabinfo.pid.num_objs
    572.00 ±  2%     +66.2%     950.75 ±  2%  slabinfo.pid.num_slabs
      8781           +17.1%      10286        slabinfo.sighand_cache.active_objs
    589.25           +17.2%     690.50        slabinfo.sighand_cache.active_slabs
      8846           +17.1%      10361        slabinfo.sighand_cache.num_objs
    589.25           +17.2%     690.50        slabinfo.sighand_cache.num_slabs
      8517           +15.5%       9842 ±  2%  slabinfo.sock_inode_cache.active_objs
      8517           +15.5%       9842 ±  2%  slabinfo.sock_inode_cache.num_objs
     40652           +63.1%      66284        slabinfo.task_delay_info.active_objs
    796.50           +63.2%       1299        slabinfo.task_delay_info.active_slabs
     40652           +63.1%      66305        slabinfo.task_delay_info.num_objs
    796.50           +63.2%       1299        slabinfo.task_delay_info.num_slabs
      3116           +32.5%       4127 ±  2%  slabinfo.task_struct.active_objs
      3126           +32.4%       4140 ±  2%  slabinfo.task_struct.active_slabs
      3126           +32.4%       4140 ±  2%  slabinfo.task_struct.num_objs
      3126           +32.4%       4140 ±  2%  slabinfo.task_struct.num_slabs
     86134           -43.0%      49131 ± 11%  sched_debug.cfs_rq:/.exec_clock.avg
     88564           -41.4%      51928 ± 10%  sched_debug.cfs_rq:/.exec_clock.max
     84525           -43.9%      47378 ± 11%  sched_debug.cfs_rq:/.exec_clock.min
    543.32 ±  8%     +23.3%     669.80 ± 14%  sched_debug.cfs_rq:/.exec_clock.stddev
      6887 ± 25%    +396.1%      34171 ± 61%  sched_debug.cfs_rq:/.load.avg
    328459 ± 34%    +154.5%     836010 ± 14%  sched_debug.cfs_rq:/.load.max
     30989 ± 36%    +320.4%     130287 ± 40%  sched_debug.cfs_rq:/.load.stddev
     15.16 ± 46%    +279.6%      57.53 ± 42%  sched_debug.cfs_rq:/.load_avg.avg
    551.83 ± 16%    +165.8%       1466 ± 52%  sched_debug.cfs_rq:/.load_avg.max
      1.12 ± 54%     -69.6%       0.34 ±141%  sched_debug.cfs_rq:/.load_avg.min
     52.73 ± 12%    +231.3%     174.70 ± 47%  sched_debug.cfs_rq:/.load_avg.stddev
  16734846           -49.9%    8383836 ± 10%  sched_debug.cfs_rq:/.min_vruntime.avg
  17021268           -49.1%    8665328 ± 10%  sched_debug.cfs_rq:/.min_vruntime.max
  16107859           -50.4%    7996921 ± 11%  sched_debug.cfs_rq:/.min_vruntime.min
      0.59 ± 14%     -33.0%       0.40 ± 32%  sched_debug.cfs_rq:/.nr_running.avg
      0.12 ±  3%    +114.3%       0.26 ± 11%  sched_debug.cfs_rq:/.nr_running.stddev
    101.78 ±  3%     +62.6%     165.49 ± 11%  sched_debug.cfs_rq:/.nr_spread_over.avg
    143.08 ±  6%    +134.4%     335.33 ± 16%  sched_debug.cfs_rq:/.nr_spread_over.max
     71.92 ±  5%     +77.0%     127.30 ± 11%  sched_debug.cfs_rq:/.nr_spread_over.min
     12.25 ±  2%     +62.6%      19.92 ± 18%  sched_debug.cfs_rq:/.nr_spread_over.stddev
    599.97 ± 13%     -42.2%     346.75 ± 37%  sched_debug.cfs_rq:/.runnable_avg.avg
    160.83 ± 43%     -92.1%      12.70 ± 97%  sched_debug.cfs_rq:/.runnable_avg.min
    123.74 ±  5%     +69.6%     209.91 ± 19%  sched_debug.cfs_rq:/.runnable_avg.stddev
   -518889           -76.4%    -122583        sched_debug.cfs_rq:/.spread0.min
    591.03 ± 12%     -46.4%     316.78 ± 34%  sched_debug.cfs_rq:/.util_avg.avg
    142.04 ± 41%     -92.4%      10.81 ± 89%  sched_debug.cfs_rq:/.util_avg.min
    122.65 ±  5%     +51.1%     185.31 ± 16%  sched_debug.cfs_rq:/.util_avg.stddev
    350.14 ±  7%     -73.6%      92.39 ± 47%  sched_debug.cfs_rq:/.util_est_enqueued.avg
    870.88 ±  8%     -21.3%     685.76 ± 21%  sched_debug.cfs_rq:/.util_est_enqueued.max
    741819 ±  3%     +14.8%     851334 ±  5%  sched_debug.cpu.avg_idle.avg
   1142277 ±  4%     +13.9%    1301547 ±  4%  sched_debug.cpu.avg_idle.max
     14.16 ±  9%     -20.6%      11.24 ± 10%  sched_debug.cpu.clock.stddev
      8006 ±  9%    +155.4%      20446 ± 27%  sched_debug.cpu.curr->pid.stddev
    587566 ±  5%     +15.7%     679543 ±  4%  sched_debug.cpu.max_idle_balance_cost.max
     12034 ± 15%     +60.7%      19340 ± 17%  sched_debug.cpu.max_idle_balance_cost.stddev
      0.15 ±  4%    +106.2%       0.32 ± 15%  sched_debug.cpu.nr_running.stddev
     19632 ±  3%     +22.6%      24079 ± 10%  sched_debug.cpu.nr_switches.avg
     16091 ±  3%     +29.8%      20881 ± 11%  sched_debug.cpu.nr_switches.min
    195.50 ±  5%     +10.3%     215.63        sched_debug.cpu.nr_uninterruptible.max
     21.49 ±  5%     +12.2%      24.11 ±  6%  sched_debug.cpu.nr_uninterruptible.stddev
     18748 ±  4%     +23.9%      23227 ± 10%  sched_debug.cpu.sched_count.avg
     15295 ±  6%     +33.5%      20417 ± 11%  sched_debug.cpu.sched_count.min
      7088 ±  4%     +36.4%       9669 ± 11%  sched_debug.cpu.sched_goidle.avg
     12684 ±  9%     +40.5%      17821 ± 15%  sched_debug.cpu.sched_goidle.max
      5684 ±  7%     +48.8%       8458 ± 11%  sched_debug.cpu.sched_goidle.min
      6997 ±  6%     +15.2%       8057 ± 10%  sched_debug.cpu.ttwu_count.avg
      5585 ±  8%     +24.4%       6945 ± 11%  sched_debug.cpu.ttwu_count.min
      1803           +22.9%       2215 ± 12%  sched_debug.cpu.ttwu_local.min
    333.69 ± 14%     -37.1%     209.78 ± 26%  sched_debug.cpu.ttwu_local.stddev
      4.59          +163.3%      12.08 ± 80%  perf-stat.i.MPKI
 1.369e+10           +12.6%  1.541e+10        perf-stat.i.branch-instructions
      0.84            +0.9        1.73 ± 62%  perf-stat.i.branch-miss-rate%
  80813906           +53.5%  1.241e+08 ±  5%  perf-stat.i.branch-misses
     33.23           -13.2       20.05 ± 22%  perf-stat.i.cache-miss-rate%
  68873436           -15.6%   58152612 ±  3%  perf-stat.i.cache-misses
 1.959e+08           +68.5%  3.301e+08 ±  9%  perf-stat.i.cache-references
     22928 ±  3%     +42.5%      32669        perf-stat.i.context-switches
      4.84           -25.7%       3.60 ± 11%  perf-stat.i.cpi
    192171            +8.1%     207652        perf-stat.i.cpu-clock
 3.395e+11           -26.1%  2.507e+11        perf-stat.i.cpu-cycles
      3004           +66.1%       4990        perf-stat.i.cpu-migrations
      4318           -24.5%       3260 ±  6%  perf-stat.i.cycles-between-cache-misses
      0.02 ±  2%      +0.1        0.12 ± 93%  perf-stat.i.dTLB-load-miss-rate%
   2028412          +107.4%    4206858 ± 25%  perf-stat.i.dTLB-load-misses
 1.237e+10            +6.2%  1.313e+10        perf-stat.i.dTLB-loads
    900493           +66.0%    1494592 ±  9%  perf-stat.i.dTLB-store-misses
 2.481e+09           +50.5%  3.733e+09        perf-stat.i.dTLB-stores
     68.65            -4.4       64.27 ±  2%  perf-stat.i.iTLB-load-miss-rate%
   8263614           +40.4%   11598238 ±  4%  perf-stat.i.iTLB-load-misses
   3627512           +45.9%    5293731 ±  8%  perf-stat.i.iTLB-loads
 6.539e+10           +19.7%  7.827e+10        perf-stat.i.instructions
      7079           -30.0%       4955 ±  3%  perf-stat.i.instructions-per-iTLB-miss
      0.24           +26.5%       0.31 ±  4%  perf-stat.i.ipc
    121.31 ±  4%    +103.0%     246.28 ±  3%  perf-stat.i.major-faults
      1.77           -41.2%       1.04        perf-stat.i.metric.GHz
      0.54 ±  2%     +30.3%       0.71 ±  3%  perf-stat.i.metric.K/sec
    150.31            -3.2%     145.48        perf-stat.i.metric.M/sec
    330469           +52.1%     502687        perf-stat.i.minor-faults
     91.78            -4.4       87.34        perf-stat.i.node-load-miss-rate%
  19141553           -17.6%   15775094 ±  3%  perf-stat.i.node-load-misses
   1554553           +50.0%    2332382        perf-stat.i.node-loads
     87.49           -11.1       76.36 ±  2%  perf-stat.i.node-store-miss-rate%
   9431905           -24.0%    7164991 ±  2%  perf-stat.i.node-store-misses
   1034312          +107.9%    2150621        perf-stat.i.node-stores
    330591           +52.1%     502934        perf-stat.i.page-faults
    192171            +8.1%     207652        perf-stat.i.task-clock
      2.99           +44.9%       4.33 ±  9%  perf-stat.overall.MPKI
      0.59            +0.2        0.83 ±  5%  perf-stat.overall.branch-miss-rate%
     35.19           -16.3       18.87 ± 10%  perf-stat.overall.cache-miss-rate%
      5.23           -41.0%       3.09        perf-stat.overall.cpi
      4975           -23.3%       3815 ±  3%  perf-stat.overall.cycles-between-cache-misses
      0.02 ±  2%      +0.0        0.03 ± 23%  perf-stat.overall.dTLB-load-miss-rate%
      0.04            +0.0        0.04 ±  9%  perf-stat.overall.dTLB-store-miss-rate%
      8022           -16.6%       6687 ±  4%  perf-stat.overall.instructions-per-iTLB-miss
      0.19           +69.5%       0.32        perf-stat.overall.ipc
     92.48            -5.2       87.25        perf-stat.overall.node-load-miss-rate%
     90.15           -11.6       78.60        perf-stat.overall.node-store-miss-rate%
  19570575           -24.4%   14788636        perf-stat.overall.path-length
 1.396e+10            +4.2%  1.454e+10        perf-stat.ps.branch-instructions
  81966699           +46.6%  1.202e+08 ±  5%  perf-stat.ps.branch-misses
  69969287           -14.9%   59546429 ±  3%  perf-stat.ps.cache-misses
 1.989e+08           +60.1%  3.185e+08 ±  8%  perf-stat.ps.cache-references
     23136 ±  3%     +38.5%      32038        perf-stat.ps.context-switches
 3.481e+11           -34.8%  2.269e+11        perf-stat.ps.cpu-cycles
      3038           +58.9%       4828        perf-stat.ps.cpu-migrations
   2074059           +97.3%    4092293 ± 23%  perf-stat.ps.dTLB-load-misses
    914227           +57.6%    1440986 ±  9%  perf-stat.ps.dTLB-store-misses
 2.517e+09           +43.2%  3.603e+09        perf-stat.ps.dTLB-stores
   8295846           +32.8%   11017262 ±  4%  perf-stat.ps.iTLB-load-misses
   3586232           +41.7%    5081984 ±  8%  perf-stat.ps.iTLB-loads
 6.655e+10           +10.5%  7.355e+10        perf-stat.ps.instructions
    123.05 ±  4%     +98.4%     244.14 ±  3%  perf-stat.ps.major-faults
    335795           +45.3%     487969        perf-stat.ps.minor-faults
  19436038           -16.0%   16318378 ±  2%  perf-stat.ps.node-load-misses
   1581111           +50.8%    2384811        perf-stat.ps.node-loads
   9585097           -22.7%    7409677        perf-stat.ps.node-store-misses
   1047177           +92.6%    2016956        perf-stat.ps.node-stores
    335918           +45.3%     488213        perf-stat.ps.page-faults
  2.02e+13           +10.4%  2.229e+13        perf-stat.total.instructions
     29904 ±  5%     +22.1%      36514 ±  3%  softirqs.CPU0.NET_RX
     24633 ±  2%     +36.3%      33569 ±  3%  softirqs.CPU0.SCHED
     28860 ±  2%     +30.8%      37759 ±  6%  softirqs.CPU1.NET_RX
     22443           +44.4%      32397 ±  2%  softirqs.CPU1.SCHED
     29908 ±  9%     +50.7%      45082 ± 13%  softirqs.CPU10.NET_RX
     22311 ±  2%     +42.0%      31692 ±  2%  softirqs.CPU10.SCHED
     26289 ±  3%     +40.9%      37034        softirqs.CPU100.NET_RX
     34342 ±  4%      +7.2%      36825 ±  3%  softirqs.CPU100.RCU
     22216           +43.6%      31892        softirqs.CPU100.SCHED
     26104 ±  2%     +43.5%      37448 ±  4%  softirqs.CPU101.NET_RX
     22274           +42.9%      31838        softirqs.CPU101.SCHED
     26126 ±  2%     +39.5%      36459 ±  5%  softirqs.CPU102.NET_RX
     22364           +42.3%      31824        softirqs.CPU102.SCHED
     25433 ±  7%     +52.6%      38802 ±  2%  softirqs.CPU103.NET_RX
     22129 ±  2%     +43.2%      31697        softirqs.CPU103.SCHED
     27116 ±  2%     +40.9%      38204        softirqs.CPU104.NET_RX
     22382           +41.3%      31635        softirqs.CPU104.SCHED
     25807 ±  8%     +47.8%      38139 ±  2%  softirqs.CPU105.NET_RX
     22317           +43.0%      31911        softirqs.CPU105.SCHED
     26906 ±  9%     +35.4%      36426        softirqs.CPU106.NET_RX
     22613           +39.7%      31597        softirqs.CPU106.SCHED
     25621 ±  2%     +44.0%      36890 ±  6%  softirqs.CPU107.NET_RX
     22208           +43.5%      31866        softirqs.CPU107.SCHED
     26424 ± 14%     +32.3%      34959 ±  5%  softirqs.CPU108.NET_RX
     22307           +42.1%      31689        softirqs.CPU108.SCHED
     26698 ±  7%     +42.8%      38114 ±  2%  softirqs.CPU109.NET_RX
     22372           +41.2%      31580        softirqs.CPU109.SCHED
     28131 ± 10%     +39.3%      39194 ±  3%  softirqs.CPU11.NET_RX
     22013           +42.6%      31389 ±  2%  softirqs.CPU11.SCHED
     26643 ±  5%     +34.4%      35800 ±  4%  softirqs.CPU110.NET_RX
     22453           +41.7%      31815        softirqs.CPU110.SCHED
     25017 ±  7%     +53.7%      38448        softirqs.CPU111.NET_RX
     22217 ±  2%     +42.6%      31680        softirqs.CPU111.SCHED
     25378 ±  3%     +40.7%      35697 ±  7%  softirqs.CPU112.NET_RX
     22403           +41.3%      31647        softirqs.CPU112.SCHED
     27002 ±  7%     +37.6%      37157 ±  5%  softirqs.CPU113.NET_RX
     22517           +40.9%      31723        softirqs.CPU113.SCHED
     25506 ±  4%     +49.3%      38088 ±  4%  softirqs.CPU114.NET_RX
     22255           +42.5%      31714        softirqs.CPU114.SCHED
     25598 ±  3%     +48.2%      37948 ±  3%  softirqs.CPU115.NET_RX
     22143           +43.8%      31844        softirqs.CPU115.SCHED
     25124 ±  7%     +43.6%      36091 ±  4%  softirqs.CPU116.NET_RX
     22195           +43.0%      31729        softirqs.CPU116.SCHED
     28448 ±  3%     +26.6%      36025        softirqs.CPU117.NET_RX
     22348           +41.8%      31686        softirqs.CPU117.SCHED
     26487 ±  7%     +34.5%      35632 ±  7%  softirqs.CPU118.NET_RX
     21913 ±  3%     +42.5%      31234 ±  3%  softirqs.CPU118.SCHED
     27585 ±  9%     +33.3%      36764 ±  8%  softirqs.CPU119.NET_RX
     22394           +41.6%      31715        softirqs.CPU119.SCHED
     22096           +43.1%      31623 ±  2%  softirqs.CPU12.SCHED
     26901 ±  8%     +51.1%      40651 ±  6%  softirqs.CPU120.NET_RX
     22451           +41.9%      31860        softirqs.CPU120.SCHED
     27857 ±  8%     +46.4%      40797 ± 11%  softirqs.CPU121.NET_RX
     22383           +41.7%      31711        softirqs.CPU121.SCHED
     26043 ±  5%     +53.8%      40065 ±  6%  softirqs.CPU122.NET_RX
     22492           +40.7%      31635        softirqs.CPU122.SCHED
     26899 ±  6%     +49.7%      40266 ±  6%  softirqs.CPU123.NET_RX
     22372           +41.3%      31620        softirqs.CPU123.SCHED
     28478 ±  2%     +39.3%      39673 ±  9%  softirqs.CPU124.NET_RX
     22377           +41.4%      31645        softirqs.CPU124.SCHED
     27607 ±  6%     +53.5%      42380 ±  5%  softirqs.CPU125.NET_RX
     34685 ±  3%      +6.3%      36880 ±  3%  softirqs.CPU125.RCU
     22573           +39.6%      31513        softirqs.CPU125.SCHED
     26638 ±  7%     +56.3%      41647 ±  8%  softirqs.CPU126.NET_RX
     22368           +40.5%      31436        softirqs.CPU126.SCHED
     26476 ±  8%     +59.6%      42266 ±  3%  softirqs.CPU127.NET_RX
     22411           +40.3%      31447        softirqs.CPU127.SCHED
     26661 ±  2%     +47.6%      39362 ± 10%  softirqs.CPU128.NET_RX
     22544           +39.3%      31396        softirqs.CPU128.SCHED
     27420 ±  3%     +49.8%      41068 ± 10%  softirqs.CPU129.NET_RX
     22639 ±  2%     +39.0%      31466        softirqs.CPU129.SCHED
     21909           +42.8%      31288 ±  2%  softirqs.CPU13.SCHED
     26577 ±  4%     +60.0%      42527 ±  7%  softirqs.CPU130.NET_RX
     22377           +40.6%      31461        softirqs.CPU130.SCHED
     27088 ±  9%     +54.9%      41969 ± 12%  softirqs.CPU131.NET_RX
     22449           +39.4%      31304        softirqs.CPU131.SCHED
     26783 ±  7%     +52.2%      40759 ± 11%  softirqs.CPU132.NET_RX
     22397           +40.3%      31429        softirqs.CPU132.SCHED
     26838 ±  7%     +63.0%      43753 ±  7%  softirqs.CPU133.NET_RX
     22162           +41.3%      31322        softirqs.CPU133.SCHED
     27367 ±  9%     +55.2%      42478 ±  7%  softirqs.CPU134.NET_RX
     22332           +41.2%      31536        softirqs.CPU134.SCHED
     28472 ±  3%     +42.1%      40471 ± 10%  softirqs.CPU135.NET_RX
     22505           +38.8%      31227        softirqs.CPU135.SCHED
     26757 ±  6%     +51.5%      40536 ±  4%  softirqs.CPU136.NET_RX
     35517 ±  2%      +8.4%      38513 ±  5%  softirqs.CPU136.RCU
     22391           +40.0%      31346        softirqs.CPU136.SCHED
     26958 ±  5%     +49.9%      40406 ±  5%  softirqs.CPU137.NET_RX
     22566           +40.4%      31674        softirqs.CPU137.SCHED
     26061 ±  7%     +57.3%      40994 ±  3%  softirqs.CPU138.NET_RX
     22489           +39.4%      31342        softirqs.CPU138.SCHED
     25915 ±  5%     +56.4%      40527 ± 11%  softirqs.CPU139.NET_RX
     34634 ±  2%     +11.0%      38448 ±  5%  softirqs.CPU139.RCU
     22260           +41.9%      31590        softirqs.CPU139.SCHED
     26375 ±  6%     +36.6%      36036 ±  6%  softirqs.CPU14.NET_RX
     21882           +42.9%      31270 ±  2%  softirqs.CPU14.SCHED
     24875 ±  4%     +68.1%      41822 ±  6%  softirqs.CPU140.NET_RX
     22289           +41.3%      31496        softirqs.CPU140.SCHED
     28273 ±  5%     +46.9%      41527 ±  9%  softirqs.CPU141.NET_RX
     35461 ±  5%     +10.2%      39067 ±  4%  softirqs.CPU141.RCU
     22941           +38.0%      31653        softirqs.CPU141.SCHED
     26181 ±  8%     +51.9%      39759 ±  9%  softirqs.CPU142.NET_RX
     22458           +40.8%      31621        softirqs.CPU142.SCHED
     26306 ±  3%     +55.0%      40769 ± 10%  softirqs.CPU143.NET_RX
     22216           +42.9%      31754        softirqs.CPU143.SCHED
     27242 ±  3%     +49.6%      40762 ±  5%  softirqs.CPU144.NET_RX
     22360           +41.6%      31667        softirqs.CPU144.SCHED
     28276 ±  9%     +54.1%      43566 ±  8%  softirqs.CPU145.NET_RX
     22355           +38.7%      30997        softirqs.CPU145.SCHED
     26523 ±  6%     +57.1%      41661        softirqs.CPU146.NET_RX
     22332           +40.1%      31289        softirqs.CPU146.SCHED
     27759 ±  8%     +45.7%      40440 ±  4%  softirqs.CPU147.NET_RX
     22382           +41.3%      31618        softirqs.CPU147.SCHED
     27584 ±  8%     +49.1%      41132 ± 15%  softirqs.CPU148.NET_RX
     22539           +39.9%      31539        softirqs.CPU148.SCHED
     25571 ±  4%     +58.9%      40645 ±  5%  softirqs.CPU149.NET_RX
     22354           +40.2%      31341        softirqs.CPU149.SCHED
     27344 ±  4%     +36.2%      37245 ±  2%  softirqs.CPU15.NET_RX
     21836           +44.2%      31494        softirqs.CPU15.SCHED
     27099 ±  7%     +47.3%      39927 ±  6%  softirqs.CPU150.NET_RX
     22248           +41.0%      31371        softirqs.CPU150.SCHED
     26349 ±  7%     +54.4%      40674 ±  5%  softirqs.CPU151.NET_RX
     22267           +40.4%      31257        softirqs.CPU151.SCHED
     25603 ±  5%     +56.4%      40048 ±  3%  softirqs.CPU152.NET_RX
     22217           +41.4%      31407        softirqs.CPU152.SCHED
     26899 ±  4%     +54.1%      41441 ±  4%  softirqs.CPU153.NET_RX
     22259           +41.5%      31489        softirqs.CPU153.SCHED
     27911           +45.1%      40490 ±  6%  softirqs.CPU154.NET_RX
     22372           +41.0%      31537        softirqs.CPU154.SCHED
     28295 ±  6%     +45.9%      41287 ±  8%  softirqs.CPU155.NET_RX
     22372           +40.6%      31463        softirqs.CPU155.SCHED
     29027 ±  4%     +37.0%      39770 ±  4%  softirqs.CPU156.NET_RX
     22207           +42.2%      31582        softirqs.CPU156.SCHED
     26245 ±  6%     +53.3%      40238 ±  4%  softirqs.CPU157.NET_RX
     22121           +41.2%      31225        softirqs.CPU157.SCHED
     27478           +52.8%      41991 ±  3%  softirqs.CPU158.NET_RX
     22488           +41.6%      31841        softirqs.CPU158.SCHED
     27491 ±  5%     +46.1%      40166 ±  5%  softirqs.CPU159.NET_RX
     22318           +40.9%      31448        softirqs.CPU159.SCHED
     27073 ±  2%     +39.2%      37696 ±  6%  softirqs.CPU16.NET_RX
     22082           +42.0%      31352        softirqs.CPU16.SCHED
     27644 ± 10%     +45.2%      40148 ±  8%  softirqs.CPU160.NET_RX
     22241           +41.9%      31556        softirqs.CPU160.SCHED
     26361 ±  7%     +62.5%      42836 ±  7%  softirqs.CPU161.NET_RX
     22416           +40.0%      31390        softirqs.CPU161.SCHED
     27105 ±  7%     +54.5%      41882 ±  7%  softirqs.CPU162.NET_RX
     22238           +42.5%      31689        softirqs.CPU162.SCHED
     26779 ±  6%     +57.7%      42242 ±  7%  softirqs.CPU163.NET_RX
     22364           +41.4%      31614        softirqs.CPU163.SCHED
     26386 ±  4%     +50.6%      39736 ±  4%  softirqs.CPU164.NET_RX
     22137           +42.7%      31580        softirqs.CPU164.SCHED
     25973 ±  5%     +57.3%      40857 ±  6%  softirqs.CPU165.NET_RX
     22171           +43.2%      31750        softirqs.CPU165.SCHED
     27815 ±  8%     +52.0%      42272 ±  8%  softirqs.CPU166.NET_RX
     22482           +40.3%      31547        softirqs.CPU166.SCHED
     27568 ±  4%     +50.1%      41372 ±  5%  softirqs.CPU167.NET_RX
     22091           +42.1%      31403        softirqs.CPU167.SCHED
     27891 ±  5%     +40.6%      39209 ±  3%  softirqs.CPU168.NET_RX
     34220 ±  4%      +7.6%      36821 ±  2%  softirqs.CPU168.RCU
     22622           +39.5%      31561        softirqs.CPU168.SCHED
     26549 ±  5%     +45.4%      38598 ±  5%  softirqs.CPU169.NET_RX
     22537           +39.9%      31523        softirqs.CPU169.SCHED
     27946 ±  8%     +36.7%      38201 ±  3%  softirqs.CPU17.NET_RX
     22271 ±  2%     +40.2%      31228 ±  2%  softirqs.CPU17.SCHED
     27172 ±  6%     +45.2%      39452 ±  6%  softirqs.CPU170.NET_RX
     22845           +37.8%      31491        softirqs.CPU170.SCHED
     27171 ±  2%     +44.1%      39143 ±  5%  softirqs.CPU171.NET_RX
     22391           +41.4%      31670        softirqs.CPU171.SCHED
     27418           +37.9%      37804 ±  8%  softirqs.CPU172.NET_RX
     22639           +39.5%      31579        softirqs.CPU172.SCHED
     26914 ±  3%     +39.3%      37483 ±  2%  softirqs.CPU173.NET_RX
     22356           +41.2%      31568        softirqs.CPU173.SCHED
     27325 ±  6%     +48.0%      40440 ±  6%  softirqs.CPU174.NET_RX
     22337           +41.2%      31538        softirqs.CPU174.SCHED
     27748 ±  6%     +34.2%      37247 ±  6%  softirqs.CPU175.NET_RX
     22333           +41.9%      31680        softirqs.CPU175.SCHED
     26737 ±  2%     +39.5%      37296 ±  3%  softirqs.CPU176.NET_RX
     22343           +41.6%      31636        softirqs.CPU176.SCHED
     28029 ±  4%     +39.2%      39014 ±  6%  softirqs.CPU177.NET_RX
     22445           +40.2%      31471        softirqs.CPU177.SCHED
     28904 ±  7%     +33.7%      38632 ±  6%  softirqs.CPU178.NET_RX
     22587           +40.0%      31620        softirqs.CPU178.SCHED
     26334 ±  8%     +39.5%      36732 ±  6%  softirqs.CPU179.NET_RX
     22479           +40.2%      31514        softirqs.CPU179.SCHED
     27221 ±  3%     +38.9%      37805 ±  3%  softirqs.CPU18.NET_RX
     21973           +42.0%      31202        softirqs.CPU18.SCHED
     26670 ±  6%     +51.7%      40462 ±  5%  softirqs.CPU180.NET_RX
     22546           +40.3%      31632        softirqs.CPU180.SCHED
     26624 ±  2%     +41.1%      37576 ±  4%  softirqs.CPU181.NET_RX
     22431           +40.5%      31518        softirqs.CPU181.SCHED
     28394 ±  3%     +35.5%      38478 ±  2%  softirqs.CPU182.NET_RX
     22649           +39.2%      31531        softirqs.CPU182.SCHED
     28315 ±  4%     +41.0%      39928 ±  5%  softirqs.CPU183.NET_RX
     22467           +40.2%      31504        softirqs.CPU183.SCHED
     27189 ±  5%     +39.6%      37966 ±  6%  softirqs.CPU184.NET_RX
     22463           +42.8%      32083        softirqs.CPU184.SCHED
     26148 ± 10%     +47.2%      38500 ±  6%  softirqs.CPU185.NET_RX
     22351           +41.4%      31604        softirqs.CPU185.SCHED
     26653 ±  6%     +49.4%      39829 ±  5%  softirqs.CPU186.NET_RX
     22457           +39.1%      31239        softirqs.CPU186.SCHED
     28024 ±  3%     +34.1%      37568 ±  8%  softirqs.CPU187.NET_RX
     22472           +40.9%      31674        softirqs.CPU187.SCHED
     27287 ±  5%     +33.9%      36541 ±  5%  softirqs.CPU188.NET_RX
     22583           +40.5%      31735        softirqs.CPU188.SCHED
     27447 ±  3%     +41.6%      38858 ±  2%  softirqs.CPU189.NET_RX
     22557           +39.7%      31523        softirqs.CPU189.SCHED
     25613 ±  4%     +43.8%      36824 ±  6%  softirqs.CPU19.NET_RX
     21746           +44.6%      31451        softirqs.CPU19.SCHED
     26395 ±  6%     +48.2%      39128        softirqs.CPU190.NET_RX
     22504           +40.9%      31719        softirqs.CPU190.SCHED
     27373 ±  9%     +39.6%      38217 ±  6%  softirqs.CPU191.NET_RX
     22257           +40.1%      31191        softirqs.CPU191.SCHED
     27755 ±  4%     +31.8%      36567 ±  3%  softirqs.CPU2.NET_RX
     22204           +42.2%      31569 ±  2%  softirqs.CPU2.SCHED
     26020 ±  4%     +39.0%      36160 ±  5%  softirqs.CPU20.NET_RX
     22104           +42.5%      31494 ±  2%  softirqs.CPU20.SCHED
     28160 ±  4%     +39.0%      39143 ±  2%  softirqs.CPU21.NET_RX
     22108           +42.9%      31584 ±  2%  softirqs.CPU21.SCHED
     26480 ±  4%     +51.0%      39997 ±  5%  softirqs.CPU22.NET_RX
     21957           +43.4%      31482 ±  2%  softirqs.CPU22.SCHED
     26338 ±  4%     +43.2%      37715 ±  2%  softirqs.CPU23.NET_RX
     22028           +43.0%      31499        softirqs.CPU23.SCHED
     27011 ±  5%     +53.8%      41531 ± 10%  softirqs.CPU24.NET_RX
     22354 ±  2%     +40.6%      31441        softirqs.CPU24.SCHED
     25355 ±  3%     +64.9%      41811 ±  5%  softirqs.CPU25.NET_RX
     21856           +42.4%      31130        softirqs.CPU25.SCHED
     26362 ±  6%     +55.8%      41065 ±  8%  softirqs.CPU26.NET_RX
     21972           +42.3%      31259        softirqs.CPU26.SCHED
     26740 ±  2%     +53.5%      41055 ±  5%  softirqs.CPU27.NET_RX
     21904           +42.9%      31290        softirqs.CPU27.SCHED
     27219           +53.6%      41817 ±  6%  softirqs.CPU28.NET_RX
     21924           +43.2%      31401        softirqs.CPU28.SCHED
     28266           +42.9%      40380 ±  8%  softirqs.CPU29.NET_RX
     34917 ±  3%      +8.2%      37786 ±  3%  softirqs.CPU29.RCU
     21952           +42.6%      31311        softirqs.CPU29.SCHED
     26501 ±  8%     +43.7%      38086 ±  4%  softirqs.CPU3.NET_RX
     21990           +43.6%      31571        softirqs.CPU3.SCHED
     27687 ±  7%     +44.7%      40053 ±  7%  softirqs.CPU30.NET_RX
     34566 ±  2%     +10.0%      38031 ±  3%  softirqs.CPU30.RCU
     21846           +42.9%      31217        softirqs.CPU30.SCHED
     28377 ±  6%     +48.1%      42026 ±  6%  softirqs.CPU31.NET_RX
     22100           +41.5%      31282        softirqs.CPU31.SCHED
     27735 ±  4%     +53.6%      42595 ±  5%  softirqs.CPU32.NET_RX
     22019           +43.0%      31496        softirqs.CPU32.SCHED
     27936 ±  3%     +46.6%      40944 ±  7%  softirqs.CPU33.NET_RX
     21966           +42.4%      31285        softirqs.CPU33.SCHED
     28144 ±  5%     +52.2%      42845 ±  6%  softirqs.CPU34.NET_RX
     22072           +41.3%      31189        softirqs.CPU34.SCHED
     28102 ±  6%     +52.1%      42735 ± 11%  softirqs.CPU35.NET_RX
     35314 ±  4%     +11.3%      39303 ±  3%  softirqs.CPU35.RCU
     21900           +41.7%      31031        softirqs.CPU35.SCHED
     25587 ±  4%     +58.7%      40603 ±  7%  softirqs.CPU36.NET_RX
     21842           +42.0%      31016        softirqs.CPU36.SCHED
     27266 ±  7%     +52.0%      41435 ±  8%  softirqs.CPU37.NET_RX
     22037           +41.5%      31175        softirqs.CPU37.SCHED
     25956 ±  7%     +61.4%      41886 ±  9%  softirqs.CPU38.NET_RX
     34641 ±  4%      +9.3%      37879 ±  4%  softirqs.CPU38.RCU
     21946           +42.1%      31190        softirqs.CPU38.SCHED
     25804           +68.3%      43417 ±  5%  softirqs.CPU39.NET_RX
     21870           +42.5%      31176        softirqs.CPU39.SCHED
     27133 ±  3%     +36.4%      37005 ±  2%  softirqs.CPU4.NET_RX
     21891           +41.6%      30989 ±  2%  softirqs.CPU4.SCHED
     27299 ±  5%     +53.7%      41953 ±  9%  softirqs.CPU40.NET_RX
     22096           +40.8%      31120        softirqs.CPU40.SCHED
     26050           +59.8%      41621 ±  9%  softirqs.CPU41.NET_RX
     22137           +42.0%      31435        softirqs.CPU41.SCHED
     26364 ±  8%     +61.4%      42549 ±  7%  softirqs.CPU42.NET_RX
     21955           +42.0%      31186        softirqs.CPU42.SCHED
     27069 ±  7%     +56.5%      42360 ±  7%  softirqs.CPU43.NET_RX
     22031           +41.7%      31209        softirqs.CPU43.SCHED
     26772 ±  5%     +56.3%      41845 ± 11%  softirqs.CPU44.NET_RX
     21930           +42.4%      31223        softirqs.CPU44.SCHED
     27194 ±  2%     +56.3%      42508 ± 11%  softirqs.CPU45.NET_RX
     22079           +41.4%      31214        softirqs.CPU45.SCHED
     28961 ±  6%     +39.0%      40249 ± 10%  softirqs.CPU46.NET_RX
     22188           +41.9%      31490        softirqs.CPU46.SCHED
     26753 ±  4%     +57.2%      42044 ±  4%  softirqs.CPU47.NET_RX
     21922           +42.1%      31154        softirqs.CPU47.SCHED
     29116 ±  9%     +38.4%      40283 ±  8%  softirqs.CPU48.NET_RX
     21988 ±  2%     +42.6%      31363        softirqs.CPU48.SCHED
     28667 ±  6%     +47.1%      42171 ±  7%  softirqs.CPU49.NET_RX
     21967           +40.1%      30765        softirqs.CPU49.SCHED
     25520 ±  7%     +46.8%      37458 ±  4%  softirqs.CPU5.NET_RX
     21504 ±  4%     +45.5%      31282        softirqs.CPU5.SCHED
     28645 ±  5%     +40.3%      40178 ±  7%  softirqs.CPU50.NET_RX
     22000           +41.7%      31170        softirqs.CPU50.SCHED
     28866 ±  4%     +43.9%      41526 ±  5%  softirqs.CPU51.NET_RX
     22045           +41.3%      31145        softirqs.CPU51.SCHED
     28005 ±  5%     +49.5%      41881 ±  8%  softirqs.CPU52.NET_RX
     21945           +41.2%      30983        softirqs.CPU52.SCHED
     26940 ±  8%     +43.5%      38647 ±  3%  softirqs.CPU53.NET_RX
     21888           +41.5%      30972        softirqs.CPU53.SCHED
     27801 ±  7%     +50.7%      41903 ±  7%  softirqs.CPU54.NET_RX
     22029           +42.8%      31452        softirqs.CPU54.SCHED
     28667 ±  6%     +40.4%      40260 ±  6%  softirqs.CPU55.NET_RX
     21934           +40.6%      30834        softirqs.CPU55.SCHED
     27112 ±  3%     +54.6%      41927 ±  8%  softirqs.CPU56.NET_RX
     21793 ±  2%     +42.2%      30999        softirqs.CPU56.SCHED
     28162 ±  2%     +43.9%      40522 ±  4%  softirqs.CPU57.NET_RX
     22203 ±  2%     +40.4%      31177        softirqs.CPU57.SCHED
     27995 ±  5%     +44.7%      40510 ±  6%  softirqs.CPU58.NET_RX
     21965           +40.4%      30841        softirqs.CPU58.SCHED
     27929 ±  4%     +50.8%      42118 ±  9%  softirqs.CPU59.NET_RX
     21887           +43.1%      31311        softirqs.CPU59.SCHED
     27643 ±  5%     +29.6%      35831 ±  2%  softirqs.CPU6.NET_RX
     22052 ±  2%     +42.4%      31398 ±  2%  softirqs.CPU6.SCHED
     26934 ±  7%     +52.2%      41006 ±  4%  softirqs.CPU60.NET_RX
     21983           +41.1%      31025        softirqs.CPU60.SCHED
     26881 ±  5%     +57.7%      42397 ±  7%  softirqs.CPU61.NET_RX
     21811           +41.1%      30781        softirqs.CPU61.SCHED
     29462 ±  8%     +38.3%      40733 ±  3%  softirqs.CPU62.NET_RX
     22010 ±  2%     +41.2%      31072        softirqs.CPU62.SCHED
     26000 ±  2%     +50.0%      39003 ±  6%  softirqs.CPU63.NET_RX
     21807           +42.7%      31111        softirqs.CPU63.SCHED
     27559 ±  5%     +47.5%      40649 ±  4%  softirqs.CPU64.NET_RX
     21905           +41.3%      30950        softirqs.CPU64.SCHED
     26948 ±  8%     +51.0%      40700 ±  5%  softirqs.CPU65.NET_RX
     22094           +42.4%      31463        softirqs.CPU65.SCHED
     24473 ±  4%     +67.5%      40990 ±  8%  softirqs.CPU66.NET_RX
     21854           +41.6%      30935        softirqs.CPU66.SCHED
     27062           +47.4%      39903 ±  6%  softirqs.CPU67.NET_RX
     21941           +42.3%      31232        softirqs.CPU67.SCHED
     27230 ±  3%     +54.7%      42132 ±  3%  softirqs.CPU68.NET_RX
     21828           +43.4%      31296        softirqs.CPU68.SCHED
     26745 ±  6%     +50.7%      40309 ±  7%  softirqs.CPU69.NET_RX
     21777           +42.7%      31081        softirqs.CPU69.SCHED
     24881 ±  6%     +54.4%      38423 ±  4%  softirqs.CPU7.NET_RX
     21496 ±  3%     +46.1%      31412 ±  2%  softirqs.CPU7.SCHED
     26854           +48.3%      39823 ±  8%  softirqs.CPU70.NET_RX
     21747           +44.8%      31484        softirqs.CPU70.SCHED
     27447 ±  5%     +48.1%      40646 ±  5%  softirqs.CPU71.NET_RX
     21645           +44.0%      31172        softirqs.CPU71.SCHED
     29119 ±  7%     +35.0%      39300 ±  8%  softirqs.CPU72.NET_RX
     22555           +40.0%      31566        softirqs.CPU72.SCHED
     28137 ±  6%     +39.4%      39232 ±  8%  softirqs.CPU73.NET_RX
     21940           +42.7%      31305        softirqs.CPU73.SCHED
     29657 ±  4%     +33.2%      39488 ±  3%  softirqs.CPU74.NET_RX
     22298           +39.9%      31194        softirqs.CPU74.SCHED
     27721 ±  7%     +37.7%      38167 ±  9%  softirqs.CPU75.NET_RX
     22212           +40.8%      31281        softirqs.CPU75.SCHED
     27420 ±  2%     +43.9%      39455 ±  4%  softirqs.CPU76.NET_RX
     22074           +41.7%      31284        softirqs.CPU76.SCHED
     27762 ± 10%     +42.7%      39613 ±  3%  softirqs.CPU77.NET_RX
     22020           +40.4%      30915 ±  2%  softirqs.CPU77.SCHED
     27195 ±  4%     +47.4%      40082 ±  5%  softirqs.CPU78.NET_RX
     22047           +41.1%      31103        softirqs.CPU78.SCHED
     26973 ±  3%     +43.3%      38642 ±  3%  softirqs.CPU79.NET_RX
     22015           +41.4%      31134        softirqs.CPU79.SCHED
     28331 ±  4%     +30.9%      37093 ±  4%  softirqs.CPU8.NET_RX
     21586           +45.8%      31472 ±  2%  softirqs.CPU8.SCHED
     28612 ±  6%     +33.4%      38178 ±  5%  softirqs.CPU80.NET_RX
     22036           +41.7%      31226        softirqs.CPU80.SCHED
     26947 ±  7%     +44.1%      38826 ±  4%  softirqs.CPU81.NET_RX
     22370 ±  2%     +39.7%      31261        softirqs.CPU81.SCHED
     25082 ±  4%     +60.3%      40203 ±  5%  softirqs.CPU82.NET_RX
     22057           +41.9%      31288        softirqs.CPU82.SCHED
     27997 ±  5%     +42.9%      40006 ±  8%  softirqs.CPU83.NET_RX
     22148           +42.3%      31517        softirqs.CPU83.SCHED
     27101 ± 14%     +42.8%      38688 ±  4%  softirqs.CPU84.NET_RX
     21965           +42.5%      31311        softirqs.CPU84.SCHED
     27241 ±  3%     +41.6%      38586 ±  8%  softirqs.CPU85.NET_RX
     22057           +41.6%      31239        softirqs.CPU85.SCHED
     26502 ±  3%     +56.1%      41371 ±  7%  softirqs.CPU86.NET_RX
     22259           +40.8%      31340        softirqs.CPU86.SCHED
     26299 ±  7%     +53.4%      40343 ±  4%  softirqs.CPU87.NET_RX
     22027           +42.1%      31299        softirqs.CPU87.SCHED
     26494 ±  7%     +43.2%      37944 ±  3%  softirqs.CPU88.NET_RX
     22015           +42.0%      31257        softirqs.CPU88.SCHED
     27133 ±  4%     +49.0%      40420 ±  4%  softirqs.CPU89.NET_RX
     21948           +42.7%      31328        softirqs.CPU89.SCHED
     27338 ±  7%     +31.1%      35850 ±  6%  softirqs.CPU9.NET_RX
     22069           +42.3%      31408 ±  2%  softirqs.CPU9.SCHED
     26687 ±  5%     +49.4%      39881 ±  6%  softirqs.CPU90.NET_RX
     22134           +40.1%      31019        softirqs.CPU90.SCHED
     27034           +42.1%      38414 ±  5%  softirqs.CPU91.NET_RX
     22110           +42.1%      31426        softirqs.CPU91.SCHED
     29072 ±  5%     +36.7%      39732 ±  6%  softirqs.CPU92.NET_RX
     22176           +41.5%      31372        softirqs.CPU92.SCHED
     27814 ±  7%     +39.4%      38777 ±  5%  softirqs.CPU93.NET_RX
     22227           +40.7%      31263        softirqs.CPU93.SCHED
     27201 ±  7%     +38.8%      37742 ±  6%  softirqs.CPU94.NET_RX
     22075           +42.5%      31447        softirqs.CPU94.SCHED
     27483 ±  9%     +42.4%      39144 ±  6%  softirqs.CPU95.NET_RX
     21997 ±  2%     +39.6%      30708        softirqs.CPU95.SCHED
     28427 ± 13%     +28.4%      36494 ±  2%  softirqs.CPU96.NET_RX
     22239           +41.2%      31412        softirqs.CPU96.SCHED
     27917 ±  2%     +29.2%      36069 ±  2%  softirqs.CPU97.NET_RX
     22994 ±  3%     +37.7%      31670        softirqs.CPU97.SCHED
     27549 ±  2%     +40.0%      38557 ±  7%  softirqs.CPU98.NET_RX
     22368           +44.4%      32295 ±  2%  softirqs.CPU98.SCHED
     25996 ±  9%     +44.1%      37453 ±  2%  softirqs.CPU99.NET_RX
     23018 ±  4%     +38.8%      31960 ±  2%  softirqs.CPU99.SCHED
   5224416           +45.9%    7621859        softirqs.NET_RX
   4265074           +41.5%    6035391        softirqs.SCHED
     79.43 ±  3%     -79.4        0.00        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.scan_positives.dcache_readdir.iterate_dir
     81.32 ±  3%     -69.7       11.58 ±  3%  perf-profile.calltrace.cycles-pp.dcache_readdir.iterate_dir.__x64_sys_getdents64.do_syscall_64.entry_SYSCALL_64_after_hwframe
     81.32 ±  3%     -69.7       11.60 ±  3%  perf-profile.calltrace.cycles-pp.iterate_dir.__x64_sys_getdents64.do_syscall_64.entry_SYSCALL_64_after_hwframe
     81.32 ±  3%     -69.7       11.60 ±  3%  perf-profile.calltrace.cycles-pp.__x64_sys_getdents64.do_syscall_64.entry_SYSCALL_64_after_hwframe
     80.02 ±  3%     -69.4       10.62 ±  3%  perf-profile.calltrace.cycles-pp.scan_positives.dcache_readdir.iterate_dir.__x64_sys_getdents64.do_syscall_64
     79.72 ±  3%     -69.3       10.46 ±  3%  perf-profile.calltrace.cycles-pp._raw_spin_lock.scan_positives.dcache_readdir.iterate_dir.__x64_sys_getdents64
     86.05 ±  2%     -62.6       23.45 ± 21%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe
     86.12 ±  2%     -62.5       23.58 ± 21%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe
      1.25 ±  3%      -0.4        0.87 ±  6%  perf-profile.calltrace.cycles-pp._raw_spin_lock.dcache_readdir.iterate_dir.__x64_sys_getdents64.do_syscall_64
      0.54 ± 68%      +0.6        1.18 ± 29%  perf-profile.calltrace.cycles-pp.free_pgtables.exit_mmap.mmput.do_exit.do_group_exit
      0.00            +0.7        0.65 ± 13%  perf-profile.calltrace.cycles-pp.kmem_cache_free.rcu_do_batch.rcu_core.__softirqentry_text_start.asm_call_sysvec_on_stack
      0.17 ±173%      +0.7        0.83 ± 26%  perf-profile.calltrace.cycles-pp.__vma_adjust.__split_vma.mprotect_fixup.do_mprotect_pkey.__x64_sys_mprotect
      0.00            +0.7        0.67 ±  6%  perf-profile.calltrace.cycles-pp.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      0.17 ±173%      +0.7        0.86 ± 26%  perf-profile.calltrace.cycles-pp.__split_vma.mprotect_fixup.do_mprotect_pkey.__x64_sys_mprotect.do_syscall_64
      0.39 ±108%      +0.7        1.08 ± 31%  perf-profile.calltrace.cycles-pp.unlink_file_vma.free_pgtables.exit_mmap.mmput.do_exit
      0.00            +0.7        0.71 ±  6%  perf-profile.calltrace.cycles-pp.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      0.18 ±173%      +0.7        0.89 ± 25%  perf-profile.calltrace.cycles-pp.mprotect_fixup.do_mprotect_pkey.__x64_sys_mprotect.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +0.7        0.72 ± 12%  perf-profile.calltrace.cycles-pp.rcu_core.__softirqentry_text_start.asm_call_sysvec_on_stack.do_softirq_own_stack.irq_exit_rcu
      0.00            +0.7        0.72 ± 12%  perf-profile.calltrace.cycles-pp.rcu_do_batch.rcu_core.__softirqentry_text_start.asm_call_sysvec_on_stack.do_softirq_own_stack
      0.20 ±173%      +0.7        0.93 ± 25%  perf-profile.calltrace.cycles-pp.unlink_file_vma.free_pgtables.exit_mmap.mmput.begin_new_exec
      0.21 ±173%      +0.7        0.93 ± 29%  perf-profile.calltrace.cycles-pp.rwsem_optimistic_spin.rwsem_down_write_slowpath.unlink_file_vma.free_pgtables.unmap_region
      0.18 ±173%      +0.7        0.91 ± 25%  perf-profile.calltrace.cycles-pp.__x64_sys_mprotect.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.18 ±173%      +0.7        0.91 ± 25%  perf-profile.calltrace.cycles-pp.do_mprotect_pkey.__x64_sys_mprotect.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.21 ±173%      +0.7        0.94 ± 29%  perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.unlink_file_vma.free_pgtables.unmap_region.__do_munmap
      0.20 ±173%      +0.7        0.93 ± 28%  perf-profile.calltrace.cycles-pp.osq_lock.rwsem_optimistic_spin.rwsem_down_write_slowpath.vma_link.mmap_region
      0.21 ±173%      +0.7        0.95 ± 29%  perf-profile.calltrace.cycles-pp.unlink_file_vma.free_pgtables.unmap_region.__do_munmap.mmap_region
      0.21 ±173%      +0.7        0.95 ± 29%  perf-profile.calltrace.cycles-pp.free_pgtables.unmap_region.__do_munmap.mmap_region.do_mmap
      0.20 ±173%      +0.7        0.95 ± 28%  perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.vma_link.mmap_region.do_mmap.vm_mmap_pgoff
      0.20 ±173%      +0.7        0.95 ± 28%  perf-profile.calltrace.cycles-pp.rwsem_optimistic_spin.rwsem_down_write_slowpath.vma_link.mmap_region.do_mmap
      0.00            +0.7        0.75 ± 10%  perf-profile.calltrace.cycles-pp.walk_component.link_path_walk.path_openat.do_filp_open.do_sys_openat2
      0.00            +0.8        0.76 ±  9%  perf-profile.calltrace.cycles-pp.__strcat_chk
      0.21 ±173%      +0.8        0.98 ± 28%  perf-profile.calltrace.cycles-pp.unmap_region.__do_munmap.mmap_region.do_mmap.vm_mmap_pgoff
      0.00            +0.8        0.77 ± 10%  perf-profile.calltrace.cycles-pp.link_path_walk.path_openat.do_filp_open.do_sys_openat2.do_sys_open
      0.00            +0.8        0.78 ±  6%  perf-profile.calltrace.cycles-pp.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      0.00            +0.8        0.78 ±  6%  perf-profile.calltrace.cycles-pp.exc_page_fault.asm_exc_page_fault
      0.21 ±173%      +0.8        1.00 ± 27%  perf-profile.calltrace.cycles-pp.vma_link.mmap_region.do_mmap.vm_mmap_pgoff.ksys_mmap_pgoff
      0.00            +0.8        0.79 ± 11%  perf-profile.calltrace.cycles-pp.__softirqentry_text_start.asm_call_sysvec_on_stack.do_softirq_own_stack.irq_exit_rcu.sysvec_apic_timer_interrupt
      0.00            +0.8        0.79 ± 11%  perf-profile.calltrace.cycles-pp.asm_call_sysvec_on_stack.do_softirq_own_stack.irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      0.00            +0.8        0.79 ± 11%  perf-profile.calltrace.cycles-pp.do_softirq_own_stack.irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state
      0.33 ±105%      +0.8        1.14 ± 21%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__libc_fork
      0.33 ±105%      +0.8        1.14 ± 21%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_fork
      0.33 ±105%      +0.8        1.14 ± 21%  perf-profile.calltrace.cycles-pp.__do_sys_clone.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_fork
      0.33 ±105%      +0.8        1.14 ± 21%  perf-profile.calltrace.cycles-pp.kernel_clone.__do_sys_clone.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_fork
      0.00            +0.8        0.81 ± 11%  perf-profile.calltrace.cycles-pp.irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter
      0.36 ±106%      +0.8        1.17 ± 19%  perf-profile.calltrace.cycles-pp.free_pgtables.exit_mmap.mmput.begin_new_exec.load_elf_binary
      0.00            +0.8        0.81 ±  6%  perf-profile.calltrace.cycles-pp.asm_exc_page_fault
      0.43 ± 58%      +0.8        1.26 ± 11%  perf-profile.calltrace.cycles-pp.add_long.add_long
      0.43 ± 58%      +0.8        1.27 ± 11%  perf-profile.calltrace.cycles-pp.add_int.add_int
      0.51 ± 64%      +0.8        1.35 ± 20%  perf-profile.calltrace.cycles-pp.__do_sys_clone.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.51 ± 64%      +0.8        1.35 ± 20%  perf-profile.calltrace.cycles-pp.kernel_clone.__do_sys_clone.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.35 ±105%      +0.8        1.20 ± 20%  perf-profile.calltrace.cycles-pp.__libc_fork
      0.71 ± 30%      +0.9        1.56 ± 14%  perf-profile.calltrace.cycles-pp.exit_mmap.mmput.begin_new_exec.load_elf_binary.exec_binprm
      0.71 ± 30%      +0.9        1.56 ± 14%  perf-profile.calltrace.cycles-pp.mmput.begin_new_exec.load_elf_binary.exec_binprm.bprm_execve
      0.00            +0.9        0.87 ±  6%  perf-profile.calltrace.cycles-pp.__cna_queued_spin_lock_slowpath._raw_spin_lock.dcache_readdir.iterate_dir.__x64_sys_getdents64
      0.40 ±112%      +0.9        1.28 ± 29%  perf-profile.calltrace.cycles-pp.do_sys_openat2.do_sys_open.do_syscall_64.entry_SYSCALL_64_after_hwframe.creat64
      0.72 ± 29%      +0.9        1.60 ± 14%  perf-profile.calltrace.cycles-pp.begin_new_exec.load_elf_binary.exec_binprm.bprm_execve.do_execveat_common
      0.29 ±100%      +0.9        1.17 ± 12%  perf-profile.calltrace.cycles-pp.div_long
      0.40 ±112%      +0.9        1.28 ± 29%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.creat64
      0.40 ±112%      +0.9        1.28 ± 29%  perf-profile.calltrace.cycles-pp.do_sys_open.do_syscall_64.entry_SYSCALL_64_after_hwframe.creat64
      0.40 ±112%      +0.9        1.29 ± 29%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.creat64
      0.40 ±112%      +0.9        1.30 ± 29%  perf-profile.calltrace.cycles-pp.creat64
      0.86 ± 33%      +0.9        1.81 ± 22%  perf-profile.calltrace.cycles-pp.mmput.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      0.86 ± 33%      +0.9        1.81 ± 22%  perf-profile.calltrace.cycles-pp.exit_mmap.mmput.do_exit.do_group_exit.__x64_sys_exit_group
      0.78 ± 69%      +1.0        1.79 ± 27%  perf-profile.calltrace.cycles-pp.__do_munmap.mmap_region.do_mmap.vm_mmap_pgoff.ksys_mmap_pgoff
      0.95 ± 30%      +1.1        2.02 ± 21%  perf-profile.calltrace.cycles-pp.__x64_sys_exit_group.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.95 ± 30%      +1.1        2.02 ± 21%  perf-profile.calltrace.cycles-pp.do_group_exit.__x64_sys_exit_group.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.95 ± 30%      +1.1        2.02 ± 21%  perf-profile.calltrace.cycles-pp.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.28 ±100%      +1.1        1.35 ±  9%  perf-profile.calltrace.cycles-pp.__strncat_chk
      0.00            +1.1        1.15 ± 15%  perf-profile.calltrace.cycles-pp.drain_obj_stock.refill_obj_stock.kmem_cache_free.rcu_do_batch.rcu_core
      0.13 ±173%      +1.2        1.37 ±  9%  perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry
      0.00            +1.3        1.26 ±  9%  perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter.do_idle
      0.00            +1.3        1.26 ± 25%  perf-profile.calltrace.cycles-pp._raw_spin_lock.lockref_get.d_alloc_cursor.dcache_dir_open.do_dentry_open
      0.00            +1.3        1.26 ± 25%  perf-profile.calltrace.cycles-pp.__cna_queued_spin_lock_slowpath._raw_spin_lock.lockref_get.d_alloc_cursor.dcache_dir_open
      0.00            +1.3        1.26 ± 25%  perf-profile.calltrace.cycles-pp.lockref_get.d_alloc_cursor.dcache_dir_open.do_dentry_open.path_openat
      0.00            +1.3        1.26 ± 25%  perf-profile.calltrace.cycles-pp.dcache_dir_open.do_dentry_open.path_openat.do_filp_open.do_sys_openat2
      0.00            +1.3        1.26 ± 25%  perf-profile.calltrace.cycles-pp.d_alloc_cursor.dcache_dir_open.do_dentry_open.path_openat.do_filp_open
      0.57 ±126%      +1.3        1.90 ± 29%  perf-profile.calltrace.cycles-pp.rwsem_optimistic_spin.rwsem_down_write_slowpath.unlink_file_vma.free_pgtables.exit_mmap
      0.57 ±126%      +1.3        1.92 ± 29%  perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.unlink_file_vma.free_pgtables.exit_mmap.mmput
      0.00            +1.4        1.42 ± 15%  perf-profile.calltrace.cycles-pp.refill_obj_stock.kmem_cache_free.rcu_do_batch.rcu_core.__softirqentry_text_start
      1.42 ± 42%      +1.4        2.86 ± 27%  perf-profile.calltrace.cycles-pp.mmap_region.do_mmap.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64
      1.43 ± 42%      +1.4        2.88 ± 27%  perf-profile.calltrace.cycles-pp.do_mmap.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.45 ±112%      +1.5        1.90 ± 55%  perf-profile.calltrace.cycles-pp.do_sys_open.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.45 ±112%      +1.5        1.90 ± 55%  perf-profile.calltrace.cycles-pp.do_sys_openat2.do_sys_open.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.44 ± 42%      +1.5        2.89 ± 27%  perf-profile.calltrace.cycles-pp.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.44 ± 42%      +1.5        2.89 ± 27%  perf-profile.calltrace.cycles-pp.ksys_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.93 ± 24%      +1.5        2.43 ± 19%  perf-profile.calltrace.cycles-pp.load_elf_binary.exec_binprm.bprm_execve.do_execveat_common.__x64_sys_execve
      0.94 ± 23%      +1.5        2.45 ± 19%  perf-profile.calltrace.cycles-pp.exec_binprm.bprm_execve.do_execveat_common.__x64_sys_execve.do_syscall_64
      0.52 ±122%      +1.6        2.09 ± 23%  perf-profile.calltrace.cycles-pp.dup_mmap.dup_mm.copy_process.kernel_clone.__do_sys_clone
      0.53 ±122%      +1.6        2.12 ± 23%  perf-profile.calltrace.cycles-pp.dup_mm.copy_process.kernel_clone.__do_sys_clone.do_syscall_64
      0.00            +1.7        1.72 ± 16%  perf-profile.calltrace.cycles-pp._raw_spin_lock.lockref_get.do_dentry_open.path_openat.do_filp_open
      0.00            +1.7        1.72 ± 16%  perf-profile.calltrace.cycles-pp.__cna_queued_spin_lock_slowpath._raw_spin_lock.lockref_get.do_dentry_open.path_openat
      0.00            +1.7        1.73 ± 16%  perf-profile.calltrace.cycles-pp.lockref_get.do_dentry_open.path_openat.do_filp_open.do_sys_openat2
      0.56 ±121%      +1.8        2.35 ± 21%  perf-profile.calltrace.cycles-pp.copy_process.kernel_clone.__do_sys_clone.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.63 ±173%      +2.1        2.75 ± 29%  perf-profile.calltrace.cycles-pp.osq_lock.rwsem_optimistic_spin.rwsem_down_write_slowpath.unlink_file_vma.free_pgtables
      1.61 ± 22%      +2.8        4.45 ±  9%  perf-profile.calltrace.cycles-pp.string_rtns_1
      0.00            +3.1        3.15 ± 13%  perf-profile.calltrace.cycles-pp.do_dentry_open.path_openat.do_filp_open.do_sys_openat2.do_sys_open
      0.61 ±  7%      +3.2        3.87 ± 16%  perf-profile.calltrace.cycles-pp.kmem_cache_free.rcu_do_batch.rcu_core.__softirqentry_text_start.run_ksoftirqd
      0.67 ±  7%      +3.5        4.13 ± 16%  perf-profile.calltrace.cycles-pp.__softirqentry_text_start.run_ksoftirqd.smpboot_thread_fn.kthread.ret_from_fork
      0.67 ±  7%      +3.5        4.13 ± 16%  perf-profile.calltrace.cycles-pp.rcu_core.__softirqentry_text_start.run_ksoftirqd.smpboot_thread_fn.kthread
      0.67 ±  7%      +3.5        4.13 ± 16%  perf-profile.calltrace.cycles-pp.run_ksoftirqd.smpboot_thread_fn.kthread.ret_from_fork
      0.67 ±  7%      +3.5        4.12 ± 16%  perf-profile.calltrace.cycles-pp.rcu_do_batch.rcu_core.__softirqentry_text_start.run_ksoftirqd.smpboot_thread_fn
      0.67 ±  7%      +3.5        4.15 ± 16%  perf-profile.calltrace.cycles-pp.smpboot_thread_fn.kthread.ret_from_fork
      0.70 ±  7%      +3.5        4.22 ± 15%  perf-profile.calltrace.cycles-pp.kthread.ret_from_fork
      0.70 ±  7%      +3.5        4.24 ± 15%  perf-profile.calltrace.cycles-pp.ret_from_fork
      3.31 ± 40%      +6.0        9.30 ± 18%  perf-profile.calltrace.cycles-pp.intel_idle.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry
      0.00            +6.1        6.08 ± 15%  perf-profile.calltrace.cycles-pp.__cna_queued_spin_lock_slowpath._raw_spin_lock.lockref_put_or_lock.dput.step_into
      0.00            +6.1        6.08 ± 15%  perf-profile.calltrace.cycles-pp._raw_spin_lock.lockref_put_or_lock.dput.step_into.path_openat
      0.00            +6.1        6.08 ± 15%  perf-profile.calltrace.cycles-pp.dput.step_into.path_openat.do_filp_open.do_open_execat
      0.00            +6.1        6.08 ± 15%  perf-profile.calltrace.cycles-pp.lockref_put_or_lock.dput.step_into.path_openat.do_filp_open
      3.73 ± 37%      +7.0       10.75 ± 16%  perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry.start_secondary
      3.79 ± 37%      +7.1       10.86 ± 16%  perf-profile.calltrace.cycles-pp.cpuidle_enter.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      3.98 ± 36%      +7.3       11.27 ± 16%  perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      3.98 ± 36%      +7.3       11.27 ± 16%  perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      3.98 ± 36%      +7.3       11.27 ± 16%  perf-profile.calltrace.cycles-pp.start_secondary.secondary_startup_64_no_verify
      4.00 ± 36%      +7.3       11.32 ± 16%  perf-profile.calltrace.cycles-pp.secondary_startup_64_no_verify
      0.00            +7.7        7.73 ± 13%  perf-profile.calltrace.cycles-pp._raw_spin_lock.lockref_get_not_dead.__legitimize_path.unlazy_walk.complete_walk
      0.00            +7.7        7.73 ± 13%  perf-profile.calltrace.cycles-pp.unlazy_walk.complete_walk.path_openat.do_filp_open.do_sys_openat2
      0.00            +7.7        7.73 ± 13%  perf-profile.calltrace.cycles-pp.__legitimize_path.unlazy_walk.complete_walk.path_openat.do_filp_open
      0.00            +7.7        7.73 ± 13%  perf-profile.calltrace.cycles-pp.lockref_get_not_dead.__legitimize_path.unlazy_walk.complete_walk.path_openat
      0.00            +7.7        7.73 ± 13%  perf-profile.calltrace.cycles-pp.complete_walk.path_openat.do_filp_open.do_sys_openat2.do_sys_open
      0.00           +10.1       10.09 ±  3%  perf-profile.calltrace.cycles-pp.__cna_queued_spin_lock_slowpath._raw_spin_lock.scan_positives.dcache_readdir.iterate_dir
      0.00           +10.9       10.87 ± 16%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__open64_nocancel
      0.00           +10.9       10.87 ± 16%  perf-profile.calltrace.cycles-pp.do_sys_open.do_syscall_64.entry_SYSCALL_64_after_hwframe.__open64_nocancel
      0.00           +10.9       10.87 ± 16%  perf-profile.calltrace.cycles-pp.do_sys_openat2.do_sys_open.do_syscall_64.entry_SYSCALL_64_after_hwframe.__open64_nocancel
      0.00           +10.9       10.88 ± 16%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__open64_nocancel
      0.00           +10.9       10.88 ± 16%  perf-profile.calltrace.cycles-pp.__open64_nocancel
      0.70 ± 67%     +13.2       13.94 ± 10%  perf-profile.calltrace.cycles-pp.path_openat.do_filp_open.do_sys_openat2.do_sys_open.do_syscall_64
      0.70 ± 67%     +13.2       13.95 ± 10%  perf-profile.calltrace.cycles-pp.do_filp_open.do_sys_openat2.do_sys_open.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00           +23.5       23.48 ±  8%  perf-profile.calltrace.cycles-pp._raw_spin_lock.lockref_get_not_dead.__legitimize_path.unlazy_walk.pick_link
      0.00           +23.5       23.48 ±  8%  perf-profile.calltrace.cycles-pp.lockref_get_not_dead.__legitimize_path.unlazy_walk.pick_link.step_into
      0.00           +23.5       23.48 ±  8%  perf-profile.calltrace.cycles-pp.unlazy_walk.pick_link.step_into.path_openat.do_filp_open
      0.00           +23.5       23.48 ±  8%  perf-profile.calltrace.cycles-pp.__legitimize_path.unlazy_walk.pick_link.step_into.path_openat
      0.00           +23.5       23.48 ±  8%  perf-profile.calltrace.cycles-pp.pick_link.step_into.path_openat.do_filp_open.do_open_execat
      1.13 ± 20%     +29.5       30.60 ± 14%  perf-profile.calltrace.cycles-pp.do_execveat_common.__x64_sys_execve.do_syscall_64.entry_SYSCALL_64_after_hwframe.execve
      1.14 ± 20%     +29.5       30.61 ± 14%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.execve
      1.14 ± 20%     +29.5       30.61 ± 14%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.execve
      1.14 ± 20%     +29.5       30.61 ± 14%  perf-profile.calltrace.cycles-pp.__x64_sys_execve.do_syscall_64.entry_SYSCALL_64_after_hwframe.execve
      1.14 ± 20%     +29.5       30.62 ± 14%  perf-profile.calltrace.cycles-pp.execve
      0.00           +29.8       29.78 ±  8%  perf-profile.calltrace.cycles-pp.step_into.path_openat.do_filp_open.do_open_execat.bprm_execve
      0.00           +29.8       29.80 ±  8%  perf-profile.calltrace.cycles-pp.do_filp_open.do_open_execat.bprm_execve.do_execveat_common.__x64_sys_execve
      0.00           +29.8       29.80 ±  8%  perf-profile.calltrace.cycles-pp.path_openat.do_filp_open.do_open_execat.bprm_execve.do_execveat_common
      0.00           +29.8       29.80 ±  8%  perf-profile.calltrace.cycles-pp.do_open_execat.bprm_execve.do_execveat_common.__x64_sys_execve.do_syscall_64
      0.00           +31.2       31.20 ±  7%  perf-profile.calltrace.cycles-pp.__cna_queued_spin_lock_slowpath._raw_spin_lock.lockref_get_not_dead.__legitimize_path.unlazy_walk
      1.06 ± 21%     +31.4       32.46 ±  6%  perf-profile.calltrace.cycles-pp.bprm_execve.do_execveat_common.__x64_sys_execve.do_syscall_64.entry_SYSCALL_64_after_hwframe
     81.91 ±  3%     -81.9        0.00        perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
     81.32 ±  3%     -69.7       11.58 ±  3%  perf-profile.children.cycles-pp.dcache_readdir
     81.32 ±  3%     -69.7       11.60 ±  3%  perf-profile.children.cycles-pp.iterate_dir
     81.32 ±  3%     -69.7       11.60 ±  3%  perf-profile.children.cycles-pp.__x64_sys_getdents64
     80.02 ±  3%     -69.4       10.62 ±  3%  perf-profile.children.cycles-pp.scan_positives
     82.29 ±  3%     -28.0       54.34 ±  6%  perf-profile.children.cycles-pp._raw_spin_lock
     89.44           -20.1       69.31 ±  2%  perf-profile.children.cycles-pp.do_syscall_64
     89.60           -19.8       69.79 ±  2%  perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.61 ±  3%      -0.2        0.43 ± 17%  perf-profile.children.cycles-pp.ksys_lseek
      0.61 ±  3%      -0.2        0.43 ± 17%  perf-profile.children.cycles-pp.dcache_dir_lseek
      0.08 ± 14%      +0.0        0.10 ± 10%  perf-profile.children.cycles-pp.ktime_get_update_offsets_now
      0.20 ±  7%      +0.0        0.23 ±  7%  perf-profile.children.cycles-pp.ktime_get
      0.05 ±  9%      +0.0        0.09 ± 17%  perf-profile.children.cycles-pp.update_load_avg
      0.06 ±  9%      +0.0        0.10 ±  4%  perf-profile.children.cycles-pp.kill_something_info
      0.06 ±  7%      +0.0        0.10 ±  8%  perf-profile.children.cycles-pp.__x64_sys_kill
      0.01 ±173%      +0.0        0.06 ± 11%  perf-profile.children.cycles-pp.update_rq_clock
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.syscall_return_via_sysret
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.__check_object_size
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.sync_regs
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.lru_add_drain
      0.00            +0.1        0.05 ±  8%  perf-profile.children.cycles-pp.setup_arg_pages
      0.05 ±  8%      +0.1        0.11 ±  4%  perf-profile.children.cycles-pp.apparmor_file_open
      0.00            +0.1        0.05 ±  9%  perf-profile.children.cycles-pp.rebalance_domains
      0.00            +0.1        0.05 ±  9%  perf-profile.children.cycles-pp.d_add
      0.00            +0.1        0.05 ±  9%  perf-profile.children.cycles-pp.new_sync_read
      0.04 ± 58%      +0.1        0.10 ±  5%  perf-profile.children.cycles-pp.kill_pid_info
      0.00            +0.1        0.06 ±  9%  perf-profile.children.cycles-pp.pagevec_lru_move_fn
      0.00            +0.1        0.06 ±  9%  perf-profile.children.cycles-pp.anon_vma_interval_tree_insert
      0.00            +0.1        0.06 ±  9%  perf-profile.children.cycles-pp.__pud_alloc
      0.00            +0.1        0.06 ±  9%  perf-profile.children.cycles-pp.__rb_insert_augmented
      0.05 ±  8%      +0.1        0.11        perf-profile.children.cycles-pp.security_file_open
      0.05 ±  8%      +0.1        0.11 ±  6%  perf-profile.children.cycles-pp.security_file_free
      0.05 ±  8%      +0.1        0.11 ±  6%  perf-profile.children.cycles-pp.apparmor_file_free_security
      0.01 ±173%      +0.1        0.07 ± 26%  perf-profile.children.cycles-pp.link
      0.00            +0.1        0.06 ±  7%  perf-profile.children.cycles-pp.simple_lookup
      0.00            +0.1        0.06 ±  7%  perf-profile.children.cycles-pp.ip_finish_output2
      0.00            +0.1        0.06 ±  7%  perf-profile.children.cycles-pp.path_init
      0.01 ±173%      +0.1        0.07 ± 24%  perf-profile.children.cycles-pp.do_linkat
      0.01 ±173%      +0.1        0.07 ± 24%  perf-profile.children.cycles-pp.__x64_sys_link
      0.00            +0.1        0.06 ± 11%  perf-profile.children.cycles-pp.security_task_kill
      0.00            +0.1        0.06 ± 11%  perf-profile.children.cycles-pp.apparmor_task_kill
      0.00            +0.1        0.06        perf-profile.children.cycles-pp.alloc_pages_vma
      0.00            +0.1        0.06        perf-profile.children.cycles-pp.ip_output
      0.00            +0.1        0.06 ± 11%  perf-profile.children.cycles-pp.create_elf_tables
      0.00            +0.1        0.06 ± 11%  perf-profile.children.cycles-pp.try_to_wake_up
      0.00            +0.1        0.06 ± 11%  perf-profile.children.cycles-pp.lock_page_memcg
      0.00            +0.1        0.06 ± 11%  perf-profile.children.cycles-pp.udp_sendmsg
      0.00            +0.1        0.06 ± 11%  perf-profile.children.cycles-pp.try_charge
      0.00            +0.1        0.06 ± 11%  perf-profile.children.cycles-pp.free_pages_and_swap_cache
      0.00            +0.1        0.06 ± 16%  perf-profile.children.cycles-pp.uncharge_batch
      0.00            +0.1        0.06 ± 16%  perf-profile.children.cycles-pp.inode_permission
      0.01 ±173%      +0.1        0.07 ± 11%  perf-profile.children.cycles-pp.vma_interval_tree_remove
      0.06 ± 11%      +0.1        0.12 ±  6%  perf-profile.children.cycles-pp.wake_up_new_task
      0.06 ±  7%      +0.1        0.12 ±  8%  perf-profile.children.cycles-pp.__d_lookup_rcu
      0.05 ±  8%      +0.1        0.12 ±  9%  perf-profile.children.cycles-pp.__mmap
      0.00            +0.1        0.06 ± 13%  perf-profile.children.cycles-pp.worker_thread
      0.00            +0.1        0.06 ± 13%  perf-profile.children.cycles-pp.__waitpid
      0.00            +0.1        0.06 ±  6%  perf-profile.children.cycles-pp.do_truncate
      0.00            +0.1        0.06 ±  6%  perf-profile.children.cycles-pp.__might_sleep
      0.00            +0.1        0.06 ± 20%  perf-profile.children.cycles-pp.kfree
      0.08 ±  6%      +0.1        0.14 ±  5%  perf-profile.children.cycles-pp.native_irq_return_iret
      0.07 ± 13%      +0.1        0.13 ±  5%  perf-profile.children.cycles-pp.down_write
      0.00            +0.1        0.07 ± 13%  perf-profile.children.cycles-pp.compar1
      0.00            +0.1        0.07 ± 13%  perf-profile.children.cycles-pp.memcpy_erms
      0.00            +0.1        0.07 ±  7%  perf-profile.children.cycles-pp.strnlen_user
      0.00            +0.1        0.07 ±  7%  perf-profile.children.cycles-pp.read
      0.00            +0.1        0.07 ±  7%  perf-profile.children.cycles-pp.get_arg_page
      0.00            +0.1        0.07 ±  7%  perf-profile.children.cycles-pp.__get_user_pages_remote
      0.00            +0.1        0.07 ±  7%  perf-profile.children.cycles-pp.__get_user_pages
      0.00            +0.1        0.07 ±  7%  perf-profile.children.cycles-pp.__pmd_alloc
      0.00            +0.1        0.07 ± 17%  perf-profile.children.cycles-pp.__anon_vma_prepare
      0.00            +0.1        0.07 ± 17%  perf-profile.children.cycles-pp.put_task_stack
      0.04 ± 58%      +0.1        0.11 ±  7%  perf-profile.children.cycles-pp.apparmor_task_getsecid
      0.00            +0.1        0.07 ±  6%  perf-profile.children.cycles-pp.group_send_sig_info
      0.00            +0.1        0.07 ±  6%  perf-profile.children.cycles-pp.cfree
      0.00            +0.1        0.07 ± 12%  perf-profile.children.cycles-pp.file_free_rcu
      0.05            +0.1        0.12        perf-profile.children.cycles-pp.getname_flags
      0.04 ± 58%      +0.1        0.11 ±  6%  perf-profile.children.cycles-pp.security_task_getsecid
      0.00            +0.1        0.07 ± 10%  perf-profile.children.cycles-pp.rcu_cblist_dequeue
      0.00            +0.1        0.07 ± 10%  perf-profile.children.cycles-pp.vfs_read
      0.00            +0.1        0.07 ± 14%  perf-profile.children.cycles-pp.mem_cgroup_uncharge_list
      0.00            +0.1        0.07 ± 10%  perf-profile.children.cycles-pp.find_vma
      0.00            +0.1        0.07 ± 38%  perf-profile.children.cycles-pp.irq_enter_rcu
      0.00            +0.1        0.07 ± 15%  perf-profile.children.cycles-pp.tick_nohz_next_event
      0.01 ±173%      +0.1        0.09 ±  4%  perf-profile.children.cycles-pp.up_write
      0.00            +0.1        0.08 ±  6%  perf-profile.children.cycles-pp.ksys_read
      0.00            +0.1        0.08 ± 14%  perf-profile.children.cycles-pp.mem_cgroup_charge
      0.00            +0.1        0.08 ± 27%  perf-profile.children.cycles-pp.put_cred_rcu
      0.04 ± 57%      +0.1        0.11 ±  4%  perf-profile.children.cycles-pp.malloc
      0.05 ± 58%      +0.1        0.12 ±  8%  perf-profile.children.cycles-pp.__close
      0.05 ±  8%      +0.1        0.13 ±  5%  perf-profile.children.cycles-pp.wp_page_copy
      0.00            +0.1        0.08 ±  5%  perf-profile.children.cycles-pp.__dentry_kill
      0.00            +0.1        0.08 ±  5%  perf-profile.children.cycles-pp.wait4
      0.00            +0.1        0.08 ±  5%  perf-profile.children.cycles-pp.down_read
      0.03 ±105%      +0.1        0.11 ± 17%  perf-profile.children.cycles-pp.do_unlinkat
      0.00            +0.1        0.08 ±  8%  perf-profile.children.cycles-pp.arch_do_signal
      0.00            +0.1        0.08        perf-profile.children.cycles-pp.filldir64
      0.00            +0.1        0.08 ± 19%  perf-profile.children.cycles-pp.schedule_idle
      0.00            +0.1        0.08 ±  5%  perf-profile.children.cycles-pp.aa_get_task_label
      0.00            +0.1        0.08 ±  5%  perf-profile.children.cycles-pp.perf_event_mmap
      0.00            +0.1        0.08 ± 10%  perf-profile.children.cycles-pp.__put_anon_vma
      0.00            +0.1        0.08 ± 13%  perf-profile.children.cycles-pp.page_add_file_rmap
      0.00            +0.1        0.08 ± 10%  perf-profile.children.cycles-pp.__slab_free
      0.07 ±  5%      +0.1        0.16 ±  7%  perf-profile.children.cycles-pp.apparmor_file_alloc_security
      0.04 ± 58%      +0.1        0.12 ±  8%  perf-profile.children.cycles-pp.alloc_set_pte
      0.00            +0.1        0.08 ±  5%  perf-profile.children.cycles-pp.sched_exec
      0.00            +0.1        0.08 ±  5%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      0.01 ±173%      +0.1        0.10 ±  4%  perf-profile.children.cycles-pp.ima_file_check
      0.00            +0.1        0.09 ± 13%  perf-profile.children.cycles-pp.tick_nohz_get_sleep_length
      0.00            +0.1        0.09 ± 17%  perf-profile.children.cycles-pp.__memcg_kmem_uncharge_page
      0.08 ± 13%      +0.1        0.17 ±  9%  perf-profile.children.cycles-pp.new_sync_write
      0.00            +0.1        0.09 ±  4%  perf-profile.children.cycles-pp.__get_free_pages
      0.05 ±  8%      +0.1        0.14 ±  5%  perf-profile.children.cycles-pp.load_balance
      0.01 ±173%      +0.1        0.10 ±  7%  perf-profile.children.cycles-pp.prep_new_page
      0.04 ± 58%      +0.1        0.13 ±  9%  perf-profile.children.cycles-pp.copy_pte_range
      0.00            +0.1        0.09 ±  7%  perf-profile.children.cycles-pp.lockref_put_return
      0.00            +0.1        0.09 ±  7%  perf-profile.children.cycles-pp.__pte_alloc
      0.00            +0.1        0.09        perf-profile.children.cycles-pp.strncpy_from_user
      0.00            +0.1        0.09 ±  7%  perf-profile.children.cycles-pp.sock_sendmsg
      0.06 ± 14%      +0.1        0.15 ±  2%  perf-profile.children.cycles-pp.get_page_from_freelist
      0.08 ± 13%      +0.1        0.17 ± 13%  perf-profile.children.cycles-pp.vma_interval_tree_insert
      0.02 ±173%      +0.1        0.11 ± 25%  perf-profile.children.cycles-pp.unlink
      0.04 ± 58%      +0.1        0.13 ±  6%  perf-profile.children.cycles-pp.do_wait
      0.03 ±100%      +0.1        0.12 ±  5%  perf-profile.children.cycles-pp.copy_strings
      0.00            +0.1        0.09 ±  4%  perf-profile.children.cycles-pp.clear_page_erms
      0.00            +0.1        0.09 ±  8%  perf-profile.children.cycles-pp.sock_write_iter
      0.06 ±  7%      +0.1        0.15 ± 13%  perf-profile.children.cycles-pp.obj_cgroup_charge
      0.08 ±  5%      +0.1        0.18 ±  6%  perf-profile.children.cycles-pp.security_file_alloc
      0.08 ±  8%      +0.1        0.17 ±  6%  perf-profile.children.cycles-pp.find_idlest_group
      0.10 ± 11%      +0.1        0.19 ± 22%  perf-profile.children.cycles-pp.update_cfs_group
      0.04 ± 58%      +0.1        0.14 ±  8%  perf-profile.children.cycles-pp.kernel_wait4
      0.03 ±100%      +0.1        0.12 ± 10%  perf-profile.children.cycles-pp.pte_alloc_one
      0.01 ±173%      +0.1        0.11 ±  7%  perf-profile.children.cycles-pp.___might_sleep
      0.08 ± 11%      +0.1        0.17 ±  4%  perf-profile.children.cycles-pp._dl_addr
      0.04 ± 58%      +0.1        0.14 ±  9%  perf-profile.children.cycles-pp.__do_sys_wait4
      0.03 ±100%      +0.1        0.12 ± 12%  perf-profile.children.cycles-pp.pick_next_task_fair
      0.01 ±173%      +0.1        0.11 ±  6%  perf-profile.children.cycles-pp.find_busiest_group
      0.01 ±173%      +0.1        0.11 ±  6%  perf-profile.children.cycles-pp.update_sd_lb_stats
      0.00            +0.1        0.10 ± 12%  perf-profile.children.cycles-pp.__clear_user
      0.06 ± 14%      +0.1        0.16 ±  6%  perf-profile.children.cycles-pp.do_anonymous_page
      0.09 ± 11%      +0.1        0.20 ±  6%  perf-profile.children.cycles-pp.select_task_rq_fair
      0.08 ± 13%      +0.1        0.19 ± 10%  perf-profile.children.cycles-pp.vfs_write
      0.07 ± 58%      +0.1        0.18 ± 14%  perf-profile.children.cycles-pp.kill
      0.07 ± 12%      +0.1        0.17 ±  9%  perf-profile.children.cycles-pp.anon_vma_clone
      0.01 ±173%      +0.1        0.12 ± 10%  perf-profile.children.cycles-pp.schedule
      0.00            +0.1        0.11 ± 17%  perf-profile.children.cycles-pp.vm_area_alloc
      0.08 ± 13%      +0.1        0.19 ±  9%  perf-profile.children.cycles-pp.ksys_write
      0.01 ±173%      +0.1        0.12 ± 12%  perf-profile.children.cycles-pp.newidle_balance
      0.07 ± 14%      +0.1        0.18 ±  9%  perf-profile.children.cycles-pp.page_remove_rmap
      0.06 ± 15%      +0.1        0.17 ± 13%  perf-profile.children.cycles-pp.__d_alloc
      0.05            +0.1        0.16 ± 15%  perf-profile.children.cycles-pp.__vm_munmap
      0.00            +0.1        0.11 ± 15%  perf-profile.children.cycles-pp.finish_task_switch
      0.06 ± 14%      +0.1        0.17 ± 14%  perf-profile.children.cycles-pp.vm_area_dup
      0.06 ± 14%      +0.1        0.17 ± 14%  perf-profile.children.cycles-pp.__mod_memcg_lruvec_state
      0.00            +0.1        0.12 ± 16%  perf-profile.children.cycles-pp.__put_task_struct
      0.07 ± 12%      +0.1        0.19 ± 12%  perf-profile.children.cycles-pp.__memcg_kmem_charge_page
      0.00            +0.1        0.12        perf-profile.children.cycles-pp.cna_order_queue
      0.08 ± 19%      +0.1        0.20 ±  9%  perf-profile.children.cycles-pp.__xstat64
      0.05 ± 57%      +0.1        0.17 ±  8%  perf-profile.children.cycles-pp.write
      0.08 ± 15%      +0.1        0.20 ±  8%  perf-profile.children.cycles-pp.copy_page_range
      0.20 ± 11%      +0.1        0.32 ± 22%  perf-profile.children.cycles-pp.task_tick_fair
      0.01 ±173%      +0.1        0.14 ± 16%  perf-profile.children.cycles-pp.__mod_memcg_state
      0.15 ± 29%      +0.1        0.29 ± 16%  perf-profile.children.cycles-pp.menu_select
      0.10 ± 15%      +0.1        0.24 ± 10%  perf-profile.children.cycles-pp.rwsem_spin_on_owner
      0.09 ± 13%      +0.2        0.24 ± 14%  perf-profile.children.cycles-pp.page_counter_try_charge
      0.29 ± 10%      +0.2        0.44 ± 16%  perf-profile.children.cycles-pp.scheduler_tick
      0.10 ±  9%      +0.2        0.25 ± 10%  perf-profile.children.cycles-pp.release_pages
      0.09 ±  7%      +0.2        0.25 ± 14%  perf-profile.children.cycles-pp.__memcg_kmem_charge
      0.10 ±  9%      +0.2        0.26 ± 12%  perf-profile.children.cycles-pp.__schedule
      0.09 ±  9%      +0.2        0.26 ±  9%  perf-profile.children.cycles-pp.anon_vma_fork
      0.08 ± 13%      +0.2        0.26 ± 17%  perf-profile.children.cycles-pp.remove_vma
      0.14 ±  8%      +0.2        0.31 ±  6%  perf-profile.children.cycles-pp.setlocale
      0.00            +0.2        0.18 ± 53%  perf-profile.children.cycles-pp.__close_nocancel
      0.03 ±100%      +0.2        0.20 ± 21%  perf-profile.children.cycles-pp.__lock_parent
      0.12 ± 10%      +0.2        0.30 ± 11%  perf-profile.children.cycles-pp.tlb_flush_mmu
      0.12 ± 10%      +0.2        0.31 ±  9%  perf-profile.children.cycles-pp.tlb_finish_mmu
      0.39 ±  9%      +0.2        0.57 ± 12%  perf-profile.children.cycles-pp.update_process_times
      0.44 ±  7%      +0.2        0.64 ± 12%  perf-profile.children.cycles-pp.tick_sched_timer
      0.39 ±  9%      +0.2        0.58 ± 12%  perf-profile.children.cycles-pp.tick_sched_handle
      0.08            +0.2        0.28 ±  6%  perf-profile.children.cycles-pp.sync
      0.08            +0.2        0.28 ±  6%  perf-profile.children.cycles-pp.__x64_sys_sync
      0.08            +0.2        0.28 ±  6%  perf-profile.children.cycles-pp.ksys_sync
      0.08 ±  6%      +0.2        0.28 ±  6%  perf-profile.children.cycles-pp.iterate_supers
      0.12 ± 10%      +0.2        0.33 ±  8%  perf-profile.children.cycles-pp.__alloc_pages_nodemask
      0.10 ± 10%      +0.2        0.32 ±  8%  perf-profile.children.cycles-pp.unlink_anon_vmas
      0.12 ±  8%      +0.2        0.35 ± 12%  perf-profile.children.cycles-pp.d_alloc
      0.16 ± 24%      +0.2        0.39 ±  7%  perf-profile.children.cycles-pp.lookup_fast
      0.52 ±  6%      +0.2        0.76 ± 10%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      0.09 ± 17%      +0.2        0.32 ± 19%  perf-profile.children.cycles-pp.get_obj_cgroup_from_current
      0.11 ±  6%      +0.2        0.35 ± 30%  perf-profile.children.cycles-pp.__fput
      0.13 ±  3%      +0.3        0.40 ± 26%  perf-profile.children.cycles-pp.task_work_run
      0.15 ± 24%      +0.3        0.42 ±  7%  perf-profile.children.cycles-pp.mem_rtns_1
      0.10 ±  5%      +0.3        0.36 ± 18%  perf-profile.children.cycles-pp.load_elf_interp
      0.20 ± 12%      +0.3        0.48 ±  6%  perf-profile.children.cycles-pp.zap_pte_range
      0.77 ±  5%      +0.3        1.05 ±  8%  perf-profile.children.cycles-pp.hrtimer_interrupt
      0.21 ± 25%      +0.3        0.49 ± 13%  perf-profile.children.cycles-pp.div_int
      0.21 ± 10%      +0.3        0.50 ±  6%  perf-profile.children.cycles-pp.unmap_page_range
      0.78 ±  5%      +0.3        1.07 ±  8%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      0.16 ±  2%      +0.3        0.46 ± 22%  perf-profile.children.cycles-pp.exit_to_user_mode_prepare
      0.09 ±  8%      +0.3        0.40 ± 15%  perf-profile.children.cycles-pp.propagate_protected_usage
      0.22 ± 11%      +0.3        0.53 ±  6%  perf-profile.children.cycles-pp.unmap_vmas
      0.16 ±  2%      +0.3        0.47 ± 21%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      0.31 ± 18%      +0.3        0.63 ±  6%  perf-profile.children.cycles-pp.filemap_map_pages
      0.12 ±  8%      +0.3        0.45 ± 15%  perf-profile.children.cycles-pp.elf_map
      0.29 ± 17%      +0.3        0.61 ±  6%  perf-profile.children.cycles-pp.path_lookupat
      0.24 ± 24%      +0.3        0.57 ± 13%  perf-profile.children.cycles-pp.div_short
      0.29 ± 16%      +0.3        0.62 ±  7%  perf-profile.children.cycles-pp.filename_lookup
      0.20 ±  6%      +0.3        0.53 ±  8%  perf-profile.children.cycles-pp.alloc_empty_file
      0.19 ±  5%      +0.3        0.53 ±  7%  perf-profile.children.cycles-pp.__alloc_file
      0.29 ± 14%      +0.3        0.63 ±  6%  perf-profile.children.cycles-pp.vfs_statx
      0.22 ±  7%      +0.3        0.55 ± 12%  perf-profile.children.cycles-pp.d_alloc_parallel
      0.29 ± 14%      +0.3        0.63 ±  6%  perf-profile.children.cycles-pp.__do_sys_newstat
      0.22 ±  7%      +0.3        0.57 ± 12%  perf-profile.children.cycles-pp.__lookup_slow
      0.22 ± 24%      +0.4        0.57 ± 11%  perf-profile.children.cycles-pp.add_short
      0.35 ± 18%      +0.4        0.74 ±  7%  perf-profile.children.cycles-pp.do_fault
      0.43 ± 39%      +0.5        0.89 ± 25%  perf-profile.children.cycles-pp.mprotect_fixup
      0.43 ± 39%      +0.5        0.91 ± 25%  perf-profile.children.cycles-pp.__x64_sys_mprotect
      0.43 ± 39%      +0.5        0.91 ± 25%  perf-profile.children.cycles-pp.do_mprotect_pkey
      0.27 ± 21%      +0.5        0.76 ±  9%  perf-profile.children.cycles-pp.__strcat_chk
      0.52 ± 42%      +0.5        1.05 ± 27%  perf-profile.children.cycles-pp.unmap_region
      0.21 ± 59%      +0.6        0.79 ± 17%  perf-profile.children.cycles-pp.terminate_walk
      0.52 ± 16%      +0.6        1.15 ±  5%  perf-profile.children.cycles-pp.__handle_mm_fault
      0.55 ± 33%      +0.6        1.20 ± 20%  perf-profile.children.cycles-pp.__libc_fork
      0.22 ±  9%      +0.7        0.87 ± 15%  perf-profile.children.cycles-pp.__memcg_kmem_uncharge
      0.55 ± 16%      +0.7        1.21 ±  6%  perf-profile.children.cycles-pp.handle_mm_fault
      0.58 ± 14%      +0.7        1.27 ±  6%  perf-profile.children.cycles-pp.do_user_addr_fault
      0.48 ± 25%      +0.7        1.17 ± 12%  perf-profile.children.cycles-pp.div_long
      0.57 ± 39%      +0.7        1.26 ± 24%  perf-profile.children.cycles-pp.vma_link
      0.58 ± 15%      +0.7        1.28 ±  6%  perf-profile.children.cycles-pp.exc_page_fault
      0.32 ± 10%      +0.7        1.02 ± 14%  perf-profile.children.cycles-pp.kmem_cache_alloc
      0.61 ± 14%      +0.7        1.34 ±  6%  perf-profile.children.cycles-pp.asm_exc_page_fault
      0.57 ± 56%      +0.7        1.31 ± 29%  perf-profile.children.cycles-pp.creat64
      0.48 ±  6%      +0.8        1.23 ±  7%  perf-profile.children.cycles-pp.link_path_walk
      0.51 ± 23%      +0.8        1.26 ± 11%  perf-profile.children.cycles-pp.add_long
      0.51 ±  8%      +0.8        1.26 ±  8%  perf-profile.children.cycles-pp.walk_component
      0.51 ± 24%      +0.8        1.27 ± 11%  perf-profile.children.cycles-pp.add_int
      0.80 ± 41%      +0.9        1.66 ± 26%  perf-profile.children.cycles-pp.__vma_adjust
      0.48 ± 21%      +0.9        1.35 ±  9%  perf-profile.children.cycles-pp.__strncat_chk
      0.82 ± 40%      +0.9        1.72 ± 26%  perf-profile.children.cycles-pp.__split_vma
      0.83 ± 34%      +1.0        1.79 ± 20%  perf-profile.children.cycles-pp.begin_new_exec
      0.95 ± 40%      +1.0        1.95 ± 26%  perf-profile.children.cycles-pp.__do_munmap
      0.35 ±  9%      +1.0        1.35 ± 14%  perf-profile.children.cycles-pp.page_counter_cancel
      0.95 ± 30%      +1.1        2.03 ± 21%  perf-profile.children.cycles-pp.__x64_sys_exit_group
      0.95 ± 30%      +1.1        2.03 ± 21%  perf-profile.children.cycles-pp.do_group_exit
      0.95 ± 30%      +1.1        2.03 ± 21%  perf-profile.children.cycles-pp.do_exit
      0.37 ±  8%      +1.1        1.47 ± 15%  perf-profile.children.cycles-pp.page_counter_uncharge
      0.97 ± 37%      +1.1        2.09 ± 23%  perf-profile.children.cycles-pp.dup_mmap
      0.98 ± 37%      +1.1        2.12 ± 23%  perf-profile.children.cycles-pp.dup_mm
      0.39 ± 18%      +1.1        1.54 ± 13%  perf-profile.children.cycles-pp.irq_exit_rcu
      0.39 ± 18%      +1.2        1.55 ± 14%  perf-profile.children.cycles-pp.do_softirq_own_stack
      1.07 ± 34%      +1.3        2.35 ± 21%  perf-profile.children.cycles-pp.copy_process
      0.00            +1.3        1.33 ± 17%  perf-profile.children.cycles-pp.dcache_dir_open
      0.00            +1.3        1.33 ± 17%  perf-profile.children.cycles-pp.d_alloc_cursor
      1.14 ± 32%      +1.3        2.49 ± 20%  perf-profile.children.cycles-pp.__do_sys_clone
      1.14 ± 32%      +1.3        2.49 ± 20%  perf-profile.children.cycles-pp.kernel_clone
      1.13 ±  5%      +1.4        2.50 ±  8%  perf-profile.children.cycles-pp.asm_call_sysvec_on_stack
      0.40 ± 10%      +1.4        1.77 ± 14%  perf-profile.children.cycles-pp.drain_obj_stock
      1.07 ± 28%      +1.5        2.54 ± 18%  perf-profile.children.cycles-pp.load_elf_binary
      1.07 ± 28%      +1.5        2.55 ± 18%  perf-profile.children.cycles-pp.exec_binprm
      1.63 ± 45%      +1.5        3.12 ± 30%  perf-profile.children.cycles-pp.unlink_file_vma
      1.22 ±  5%      +1.5        2.72 ±  8%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      1.48 ± 41%      +1.5        3.00 ± 26%  perf-profile.children.cycles-pp.ksys_mmap_pgoff
      1.33 ±  5%      +1.6        2.90 ±  8%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
      0.48 ±  9%      +1.7        2.17 ± 14%  perf-profile.children.cycles-pp.refill_obj_stock
      1.54 ± 40%      +1.7        3.24 ± 25%  perf-profile.children.cycles-pp.mmap_region
      1.55 ± 39%      +1.7        3.28 ± 25%  perf-profile.children.cycles-pp.do_mmap
      1.76 ± 42%      +1.7        3.50 ± 27%  perf-profile.children.cycles-pp.free_pgtables
      1.57 ± 39%      +1.7        3.31 ± 25%  perf-profile.children.cycles-pp.vm_mmap_pgoff
      1.67 ± 34%      +1.9        3.55 ± 21%  perf-profile.children.cycles-pp.exit_mmap
      1.67 ± 34%      +1.9        3.55 ± 21%  perf-profile.children.cycles-pp.mmput
      1.62 ± 22%      +2.8        4.46 ±  9%  perf-profile.children.cycles-pp.string_rtns_1
      0.00            +3.2        3.16 ± 13%  perf-profile.children.cycles-pp.lockref_get
      0.09 ±  7%      +3.2        3.29 ± 12%  perf-profile.children.cycles-pp.do_dentry_open
      0.67 ±  7%      +3.5        4.13 ± 16%  perf-profile.children.cycles-pp.run_ksoftirqd
      3.66 ± 38%      +3.5        7.12 ± 26%  perf-profile.children.cycles-pp.osq_lock
      0.67 ±  7%      +3.5        4.15 ± 16%  perf-profile.children.cycles-pp.smpboot_thread_fn
      0.70 ±  7%      +3.5        4.22 ± 15%  perf-profile.children.cycles-pp.kthread
      0.71 ±  7%      +3.5        4.25 ± 15%  perf-profile.children.cycles-pp.ret_from_fork
      3.78 ± 38%      +3.6        7.43 ± 25%  perf-profile.children.cycles-pp.rwsem_optimistic_spin
      3.79 ± 38%      +3.7        7.46 ± 25%  perf-profile.children.cycles-pp.rwsem_down_write_slowpath
      0.99 ± 12%      +4.5        5.54 ± 15%  perf-profile.children.cycles-pp.rcu_do_batch
      1.00 ± 11%      +4.5        5.55 ± 15%  perf-profile.children.cycles-pp.rcu_core
      1.06 ± 11%      +4.6        5.68 ± 15%  perf-profile.children.cycles-pp.__softirqentry_text_start
      1.09 ± 12%      +4.7        5.80 ± 15%  perf-profile.children.cycles-pp.kmem_cache_free
      3.32 ± 40%      +6.0        9.34 ± 18%  perf-profile.children.cycles-pp.intel_idle
      0.26 ±  2%      +6.8        7.05 ± 13%  perf-profile.children.cycles-pp.lockref_put_or_lock
      0.62 ± 22%      +7.1        7.68 ± 11%  perf-profile.children.cycles-pp.dput
      3.81 ± 37%      +7.1       10.91 ± 16%  perf-profile.children.cycles-pp.cpuidle_enter
      3.81 ± 37%      +7.1       10.91 ± 16%  perf-profile.children.cycles-pp.cpuidle_enter_state
      3.98 ± 36%      +7.3       11.27 ± 16%  perf-profile.children.cycles-pp.start_secondary
      4.00 ± 36%      +7.3       11.32 ± 16%  perf-profile.children.cycles-pp.secondary_startup_64_no_verify
      4.00 ± 36%      +7.3       11.32 ± 16%  perf-profile.children.cycles-pp.cpu_startup_entry
      4.00 ± 36%      +7.3       11.32 ± 16%  perf-profile.children.cycles-pp.do_idle
      0.00            +7.8        7.79 ± 13%  perf-profile.children.cycles-pp.complete_walk
      0.13 ±  5%     +10.9       11.06 ± 16%  perf-profile.children.cycles-pp.__open64_nocancel
      1.37 ± 22%     +12.9       14.24 ± 10%  perf-profile.children.cycles-pp.do_sys_open
      1.37 ± 22%     +12.9       14.24 ± 10%  perf-profile.children.cycles-pp.do_sys_openat2
      0.09 ± 17%     +23.6       23.66 ±  9%  perf-profile.children.cycles-pp.pick_link
      1.14 ± 20%     +29.5       30.62 ± 14%  perf-profile.children.cycles-pp.execve
      0.11 ±  4%     +29.7       29.84 ±  8%  perf-profile.children.cycles-pp.do_open_execat
      0.21 ±  6%     +29.9       30.10 ±  8%  perf-profile.children.cycles-pp.step_into
      1.22 ± 25%     +31.3       32.48 ±  6%  perf-profile.children.cycles-pp.bprm_execve
      1.30 ± 24%     +31.4       32.70 ±  6%  perf-profile.children.cycles-pp.do_execveat_common
      1.31 ± 25%     +31.4       32.71 ±  6%  perf-profile.children.cycles-pp.__x64_sys_execve
      0.29 ± 44%     +31.5       31.79 ±  7%  perf-profile.children.cycles-pp.lockref_get_not_dead
      0.30 ± 44%     +31.5       31.82 ±  7%  perf-profile.children.cycles-pp.__legitimize_path
      0.30 ± 42%     +31.5       31.83 ±  7%  perf-profile.children.cycles-pp.unlazy_walk
      1.42 ± 21%     +42.5       43.95 ±  8%  perf-profile.children.cycles-pp.path_openat
      1.42 ± 21%     +42.5       43.95 ±  8%  perf-profile.children.cycles-pp.do_filp_open
      0.00           +53.7       53.73 ±  6%  perf-profile.children.cycles-pp.__cna_queued_spin_lock_slowpath
     81.23 ±  3%     -81.2        0.00        perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
      0.08 ±  5%      -0.0        0.07 ±  6%  perf-profile.self.cycles-pp.dput
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.link_path_walk
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.__alloc_file
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.cfree
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.syscall_return_via_sysret
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.sync_regs
      0.06 ± 15%      +0.1        0.11 ±  4%  perf-profile.self.cycles-pp.down_write
      0.00            +0.1        0.05 ±  8%  perf-profile.self.cycles-pp.__might_sleep
      0.05 ±  8%      +0.1        0.11 ±  4%  perf-profile.self.cycles-pp.apparmor_file_open
      0.00            +0.1        0.05 ±  9%  perf-profile.self.cycles-pp.__handle_mm_fault
      0.00            +0.1        0.06 ±  9%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.00            +0.1        0.06 ±  9%  perf-profile.self.cycles-pp.strnlen_user
      0.00            +0.1        0.06 ±  9%  perf-profile.self.cycles-pp.anon_vma_interval_tree_insert
      0.05 ±  8%      +0.1        0.11 ±  6%  perf-profile.self.cycles-pp.apparmor_file_free_security
      0.00            +0.1        0.06 ±  7%  perf-profile.self.cycles-pp.copy_pte_range
      0.00            +0.1        0.06 ± 14%  perf-profile.self.cycles-pp.free_pages_and_swap_cache
      0.06 ±  7%      +0.1        0.12 ±  9%  perf-profile.self.cycles-pp.__d_lookup_rcu
      0.00            +0.1        0.06        perf-profile.self.cycles-pp.filldir64
      0.00            +0.1        0.06 ± 11%  perf-profile.self.cycles-pp.lock_page_memcg
      0.00            +0.1        0.06 ± 16%  perf-profile.self.cycles-pp.file_free_rcu
      0.01 ±173%      +0.1        0.07 ± 11%  perf-profile.self.cycles-pp.vma_interval_tree_remove
      0.08 ±  6%      +0.1        0.14 ±  5%  perf-profile.self.cycles-pp.native_irq_return_iret
      0.00            +0.1        0.07 ± 13%  perf-profile.self.cycles-pp.compar1
      0.00            +0.1        0.07 ± 13%  perf-profile.self.cycles-pp.memcpy_erms
      0.00            +0.1        0.07 ±  6%  perf-profile.self.cycles-pp.down_read
      0.00            +0.1        0.07 ± 12%  perf-profile.self.cycles-pp.rcu_cblist_dequeue
      0.01 ±173%      +0.1        0.08 ±  5%  perf-profile.self.cycles-pp.up_write
      0.00            +0.1        0.07 ± 11%  perf-profile.self.cycles-pp.__slab_free
      0.05 ±  8%      +0.1        0.13 ± 10%  perf-profile.self.cycles-pp.release_pages
      0.06 ±  6%      +0.1        0.14 ±  9%  perf-profile.self.cycles-pp.lockref_get_not_dead
      0.07 ±  5%      +0.1        0.15 ±  4%  perf-profile.self.cycles-pp.apparmor_file_alloc_security
      0.00            +0.1        0.08        perf-profile.self.cycles-pp.aa_get_task_label
      0.08 ± 11%      +0.1        0.16 ±  7%  perf-profile.self.cycles-pp.find_idlest_group
      0.00            +0.1        0.09 ±  5%  perf-profile.self.cycles-pp.lockref_put_return
      0.06 ± 14%      +0.1        0.14 ±  5%  perf-profile.self.cycles-pp.page_remove_rmap
      0.00            +0.1        0.09 ±  9%  perf-profile.self.cycles-pp.update_sd_lb_stats
      0.08 ± 13%      +0.1        0.17 ± 13%  perf-profile.self.cycles-pp.vma_interval_tree_insert
      0.00            +0.1        0.09 ±  4%  perf-profile.self.cycles-pp.clear_page_erms
      0.10 ± 11%      +0.1        0.19 ± 22%  perf-profile.self.cycles-pp.update_cfs_group
      0.07 ± 15%      +0.1        0.17 ±  5%  perf-profile.self.cycles-pp._dl_addr
      0.00            +0.1        0.10 ±  7%  perf-profile.self.cycles-pp.___might_sleep
      0.00            +0.1        0.11 ±  4%  perf-profile.self.cycles-pp.malloc
      0.00            +0.1        0.11 ±  3%  perf-profile.self.cycles-pp.cna_order_queue
      0.00            +0.1        0.11 ± 15%  perf-profile.self.cycles-pp.page_counter_uncharge
      0.08 ± 10%      +0.1        0.20 ± 12%  perf-profile.self.cycles-pp.page_counter_try_charge
      0.11 ± 11%      +0.1        0.23 ±  3%  perf-profile.self.cycles-pp.zap_pte_range
      0.01 ±173%      +0.1        0.14 ± 16%  perf-profile.self.cycles-pp.__mod_memcg_state
      0.10 ± 15%      +0.1        0.23 ±  9%  perf-profile.self.cycles-pp.rwsem_spin_on_owner
      0.23 ± 21%      +0.2        0.44 ±  6%  perf-profile.self.cycles-pp.filemap_map_pages
      0.08 ± 13%      +0.2        0.30 ± 19%  perf-profile.self.cycles-pp.get_obj_cgroup_from_current
      0.41            +0.2        0.65 ±  2%  perf-profile.self.cycles-pp._raw_spin_lock
      0.14 ± 25%      +0.3        0.41 ±  8%  perf-profile.self.cycles-pp.mem_rtns_1
      0.21 ± 25%      +0.3        0.49 ± 13%  perf-profile.self.cycles-pp.div_int
      0.12 ± 11%      +0.3        0.41 ± 13%  perf-profile.self.cycles-pp.kmem_cache_alloc
      0.08 ±  8%      +0.3        0.38 ± 14%  perf-profile.self.cycles-pp.refill_obj_stock
      0.09 ±  8%      +0.3        0.40 ± 16%  perf-profile.self.cycles-pp.propagate_protected_usage
      0.23 ± 23%      +0.3        0.56 ± 14%  perf-profile.self.cycles-pp.div_short
      0.22 ± 24%      +0.4        0.57 ± 11%  perf-profile.self.cycles-pp.add_short
      0.07 ± 17%      +0.4        0.43 ± 15%  perf-profile.self.cycles-pp.drain_obj_stock
      0.27 ± 22%      +0.5        0.74 ± 10%  perf-profile.self.cycles-pp.__strcat_chk
      0.47 ± 26%      +0.7        1.16 ± 12%  perf-profile.self.cycles-pp.div_long
      0.27 ±  9%      +0.7        0.99 ± 15%  perf-profile.self.cycles-pp.page_counter_cancel
      0.50 ± 23%      +0.7        1.24 ± 12%  perf-profile.self.cycles-pp.add_long
      0.51 ± 24%      +0.7        1.25 ± 11%  perf-profile.self.cycles-pp.add_int
      0.48 ± 21%      +0.8        1.33 ±  9%  perf-profile.self.cycles-pp.__strncat_chk
      1.59 ± 22%      +2.8        4.38 ±  9%  perf-profile.self.cycles-pp.string_rtns_1
      0.56 ± 15%      +2.9        3.44 ± 16%  perf-profile.self.cycles-pp.kmem_cache_free
      3.57 ± 38%      +3.3        6.82 ± 25%  perf-profile.self.cycles-pp.osq_lock
      3.32 ± 40%      +6.0        9.34 ± 18%  perf-profile.self.cycles-pp.intel_idle
      0.00           +53.0       52.96 ±  6%  perf-profile.self.cycles-pp.__cna_queued_spin_lock_slowpath
      5365 ±  7%     -38.7%       3289 ± 27%  interrupts.CPU0.NMI:Non-maskable_interrupts
      5365 ±  7%     -38.7%       3289 ± 27%  interrupts.CPU0.PMI:Performance_monitoring_interrupts
    584.25 ± 10%     +62.5%     949.25 ±  2%  interrupts.CPU0.TLB:TLB_shootdowns
      5324 ±  6%     -30.8%       3683 ±  8%  interrupts.CPU1.NMI:Non-maskable_interrupts
      5324 ±  6%     -30.8%       3683 ±  8%  interrupts.CPU1.PMI:Performance_monitoring_interrupts
    864.50 ±  3%     +22.4%       1058 ±  4%  interrupts.CPU1.RES:Rescheduling_interrupts
    529.25 ± 17%     +73.0%     915.50 ± 10%  interrupts.CPU1.TLB:TLB_shootdowns
    844.50 ±  5%     +27.5%       1076 ±  3%  interrupts.CPU10.RES:Rescheduling_interrupts
    424.00 ± 17%    +110.0%     890.50 ± 10%  interrupts.CPU10.TLB:TLB_shootdowns
    814.75 ±  3%     +40.8%       1147 ±  4%  interrupts.CPU100.RES:Rescheduling_interrupts
    406.00 ± 24%    +100.6%     814.50 ± 19%  interrupts.CPU100.TLB:TLB_shootdowns
    837.75 ±  3%     +26.6%       1060 ±  4%  interrupts.CPU101.RES:Rescheduling_interrupts
    386.50 ± 17%    +108.4%     805.50 ± 10%  interrupts.CPU101.TLB:TLB_shootdowns
    825.75 ±  8%     +35.2%       1116 ±  2%  interrupts.CPU102.RES:Rescheduling_interrupts
    387.75 ± 11%    +119.5%     851.00 ± 13%  interrupts.CPU102.TLB:TLB_shootdowns
    832.50 ±  5%     +31.1%       1091 ±  4%  interrupts.CPU103.RES:Rescheduling_interrupts
    427.00 ± 13%     +91.6%     818.25 ±  7%  interrupts.CPU103.TLB:TLB_shootdowns
    813.50 ±  3%     +34.4%       1093 ±  6%  interrupts.CPU104.RES:Rescheduling_interrupts
    390.25 ±  6%    +105.1%     800.50 ±  4%  interrupts.CPU104.TLB:TLB_shootdowns
    829.50 ±  2%     +31.3%       1089 ±  2%  interrupts.CPU105.RES:Rescheduling_interrupts
    450.50 ± 18%     +77.0%     797.25 ±  9%  interrupts.CPU105.TLB:TLB_shootdowns
    813.25 ± 11%     +35.4%       1101 ±  6%  interrupts.CPU106.RES:Rescheduling_interrupts
    487.75 ± 19%     +80.1%     878.50 ±  9%  interrupts.CPU106.TLB:TLB_shootdowns
    775.25           +45.9%       1131 ±  3%  interrupts.CPU107.RES:Rescheduling_interrupts
    407.50 ± 20%     +95.3%     795.75 ± 10%  interrupts.CPU107.TLB:TLB_shootdowns
    809.00 ±  8%     +36.0%       1100 ±  6%  interrupts.CPU108.RES:Rescheduling_interrupts
    405.50 ± 13%    +112.9%     863.50 ±  9%  interrupts.CPU108.TLB:TLB_shootdowns
      5342 ±  7%     -41.1%       3147 ± 23%  interrupts.CPU109.NMI:Non-maskable_interrupts
      5342 ±  7%     -41.1%       3147 ± 23%  interrupts.CPU109.PMI:Performance_monitoring_interrupts
    799.75 ±  6%     +38.8%       1110 ±  3%  interrupts.CPU109.RES:Rescheduling_interrupts
    415.00 ± 14%     +98.8%     825.00 ± 10%  interrupts.CPU109.TLB:TLB_shootdowns
    847.25 ±  5%     +28.0%       1084 ±  3%  interrupts.CPU11.RES:Rescheduling_interrupts
    379.00 ± 11%    +124.4%     850.50 ±  9%  interrupts.CPU11.TLB:TLB_shootdowns
      5339 ±  7%     -41.6%       3120 ± 25%  interrupts.CPU110.NMI:Non-maskable_interrupts
      5339 ±  7%     -41.6%       3120 ± 25%  interrupts.CPU110.PMI:Performance_monitoring_interrupts
    849.75 ± 13%     +26.9%       1078 ±  5%  interrupts.CPU110.RES:Rescheduling_interrupts
    406.25 ± 18%     +95.9%     796.00 ± 10%  interrupts.CPU110.TLB:TLB_shootdowns
    759.75 ± 10%     +48.1%       1125 ±  5%  interrupts.CPU111.RES:Rescheduling_interrupts
    435.50 ± 21%     +92.4%     837.75 ±  6%  interrupts.CPU111.TLB:TLB_shootdowns
    781.50 ±  5%     +42.8%       1115 ±  3%  interrupts.CPU112.RES:Rescheduling_interrupts
    399.50 ± 27%    +111.3%     844.00 ±  6%  interrupts.CPU112.TLB:TLB_shootdowns
      5345 ±  7%     -41.2%       3144 ± 22%  interrupts.CPU113.NMI:Non-maskable_interrupts
      5345 ±  7%     -41.2%       3144 ± 22%  interrupts.CPU113.PMI:Performance_monitoring_interrupts
    821.25 ±  4%     +30.8%       1074 ±  6%  interrupts.CPU113.RES:Rescheduling_interrupts
    444.50 ± 16%     +96.2%     872.25 ±  7%  interrupts.CPU113.TLB:TLB_shootdowns
    790.50 ±  4%     +47.6%       1166 ±  3%  interrupts.CPU114.RES:Rescheduling_interrupts
    794.75 ±  2%     +41.2%       1122 ±  5%  interrupts.CPU115.RES:Rescheduling_interrupts
    407.75 ± 12%    +108.1%     848.50 ± 15%  interrupts.CPU115.TLB:TLB_shootdowns
      5364 ±  7%     -33.3%       3579 ±  8%  interrupts.CPU116.NMI:Non-maskable_interrupts
      5364 ±  7%     -33.3%       3579 ±  8%  interrupts.CPU116.PMI:Performance_monitoring_interrupts
    747.25 ±  8%     +46.2%       1092        interrupts.CPU116.RES:Rescheduling_interrupts
    401.75 ± 15%    +103.9%     819.25        interrupts.CPU116.TLB:TLB_shootdowns
    799.25 ±  4%     +33.1%       1063 ±  5%  interrupts.CPU117.RES:Rescheduling_interrupts
    403.75 ± 17%    +109.0%     844.00 ± 16%  interrupts.CPU117.TLB:TLB_shootdowns
    800.25 ±  9%     +31.1%       1049 ±  3%  interrupts.CPU118.RES:Rescheduling_interrupts
    417.25 ± 18%    +106.6%     862.00 ±  8%  interrupts.CPU118.TLB:TLB_shootdowns
    765.25 ±  2%     +37.6%       1053 ±  4%  interrupts.CPU119.RES:Rescheduling_interrupts
    395.75 ± 14%    +119.5%     868.75 ± 12%  interrupts.CPU119.TLB:TLB_shootdowns
    934.25 ±  6%     +16.9%       1091 ±  4%  interrupts.CPU12.RES:Rescheduling_interrupts
    436.75 ± 13%    +104.4%     892.50 ± 18%  interrupts.CPU12.TLB:TLB_shootdowns
    713.75 ±  3%     +66.4%       1188 ±  4%  interrupts.CPU120.RES:Rescheduling_interrupts
    440.50 ± 22%     +89.0%     832.75 ±  9%  interrupts.CPU120.TLB:TLB_shootdowns
    781.25 ± 10%     +47.2%       1149 ±  5%  interrupts.CPU121.RES:Rescheduling_interrupts
    455.00 ± 12%     +84.7%     840.25 ± 12%  interrupts.CPU121.TLB:TLB_shootdowns
    758.25 ±  6%     +54.3%       1169 ±  5%  interrupts.CPU122.RES:Rescheduling_interrupts
    427.25 ± 11%    +104.6%     874.25 ±  8%  interrupts.CPU122.TLB:TLB_shootdowns
    761.25 ±  7%     +49.1%       1135 ±  8%  interrupts.CPU123.RES:Rescheduling_interrupts
    430.50 ± 11%     +92.2%     827.50 ± 15%  interrupts.CPU123.TLB:TLB_shootdowns
    779.00           +52.6%       1188 ±  5%  interrupts.CPU124.RES:Rescheduling_interrupts
    434.00 ± 18%     +96.0%     850.50 ± 14%  interrupts.CPU124.TLB:TLB_shootdowns
    734.75 ±  4%     +50.3%       1104 ±  6%  interrupts.CPU125.RES:Rescheduling_interrupts
    471.75 ± 15%     +75.3%     826.75 ± 18%  interrupts.CPU125.TLB:TLB_shootdowns
    760.00 ±  7%     +50.6%       1144 ±  4%  interrupts.CPU126.RES:Rescheduling_interrupts
    457.75 ± 12%     +87.4%     857.75 ± 11%  interrupts.CPU126.TLB:TLB_shootdowns
      5318 ±  7%     -29.9%       3727 ±  9%  interrupts.CPU127.NMI:Non-maskable_interrupts
      5318 ±  7%     -29.9%       3727 ±  9%  interrupts.CPU127.PMI:Performance_monitoring_interrupts
    759.25 ±  8%     +48.8%       1129 ±  4%  interrupts.CPU127.RES:Rescheduling_interrupts
    420.00 ± 15%    +108.0%     873.50 ± 14%  interrupts.CPU127.TLB:TLB_shootdowns
    790.25 ±  4%     +51.0%       1193 ±  8%  interrupts.CPU128.RES:Rescheduling_interrupts
    412.25 ± 17%    +111.2%     870.75 ± 10%  interrupts.CPU128.TLB:TLB_shootdowns
      5279 ±  7%     -30.6%       3665 ± 10%  interrupts.CPU129.NMI:Non-maskable_interrupts
      5279 ±  7%     -30.6%       3665 ± 10%  interrupts.CPU129.PMI:Performance_monitoring_interrupts
    734.50 ±  5%     +56.3%       1147 ±  6%  interrupts.CPU129.RES:Rescheduling_interrupts
    439.50 ± 22%    +103.6%     895.00 ±  7%  interrupts.CPU129.TLB:TLB_shootdowns
      5324 ±  7%     -37.2%       3342 ± 30%  interrupts.CPU13.NMI:Non-maskable_interrupts
      5324 ±  7%     -37.2%       3342 ± 30%  interrupts.CPU13.PMI:Performance_monitoring_interrupts
    828.25 ±  3%     +28.7%       1066 ±  5%  interrupts.CPU13.RES:Rescheduling_interrupts
    449.50 ± 16%     +77.6%     798.25 ± 10%  interrupts.CPU13.TLB:TLB_shootdowns
      5332 ±  7%     -58.3%       2224 ± 23%  interrupts.CPU130.NMI:Non-maskable_interrupts
      5332 ±  7%     -58.3%       2224 ± 23%  interrupts.CPU130.PMI:Performance_monitoring_interrupts
    751.75           +52.5%       1146 ±  5%  interrupts.CPU130.RES:Rescheduling_interrupts
    422.00 ± 12%    +100.8%     847.50 ±  9%  interrupts.CPU130.TLB:TLB_shootdowns
    891.75 ± 13%     +26.9%       1131 ±  9%  interrupts.CPU131.RES:Rescheduling_interrupts
    495.00 ± 21%     +76.3%     872.50 ±  6%  interrupts.CPU131.TLB:TLB_shootdowns
      5352 ±  8%     -40.8%       3168 ± 23%  interrupts.CPU132.NMI:Non-maskable_interrupts
      5352 ±  8%     -40.8%       3168 ± 23%  interrupts.CPU132.PMI:Performance_monitoring_interrupts
    793.25 ± 11%     +47.3%       1168 ±  5%  interrupts.CPU132.RES:Rescheduling_interrupts
    508.75 ± 21%     +82.2%     927.00 ±  8%  interrupts.CPU132.TLB:TLB_shootdowns
      5352 ±  6%     -31.3%       3675 ±  9%  interrupts.CPU133.NMI:Non-maskable_interrupts
      5352 ±  6%     -31.3%       3675 ±  9%  interrupts.CPU133.PMI:Performance_monitoring_interrupts
    698.50 ± 13%     +66.2%       1161 ±  8%  interrupts.CPU133.RES:Rescheduling_interrupts
    452.25 ± 13%     +84.3%     833.50 ± 11%  interrupts.CPU133.TLB:TLB_shootdowns
      5326 ±  7%     -57.8%       2249 ± 23%  interrupts.CPU134.NMI:Non-maskable_interrupts
      5326 ±  7%     -57.8%       2249 ± 23%  interrupts.CPU134.PMI:Performance_monitoring_interrupts
    696.00 ± 13%     +67.6%       1166 ± 10%  interrupts.CPU134.RES:Rescheduling_interrupts
    434.75 ± 16%    +100.5%     871.75 ±  9%  interrupts.CPU134.TLB:TLB_shootdowns
      5321 ±  8%     -31.1%       3666 ±  9%  interrupts.CPU135.NMI:Non-maskable_interrupts
      5321 ±  8%     -31.1%       3666 ±  9%  interrupts.CPU135.PMI:Performance_monitoring_interrupts
    772.00 ±  8%     +43.9%       1111 ±  5%  interrupts.CPU135.RES:Rescheduling_interrupts
    490.50 ± 21%     +88.1%     922.50 ±  7%  interrupts.CPU135.TLB:TLB_shootdowns
    731.25 ±  2%     +54.6%       1130 ±  7%  interrupts.CPU136.RES:Rescheduling_interrupts
    447.75 ± 11%    +110.2%     941.00 ± 10%  interrupts.CPU136.TLB:TLB_shootdowns
    777.75 ±  4%     +48.3%       1153 ±  6%  interrupts.CPU137.RES:Rescheduling_interrupts
    432.50 ±  9%    +107.4%     897.00 ±  3%  interrupts.CPU137.TLB:TLB_shootdowns
      5350 ±  6%     -31.1%       3684 ±  9%  interrupts.CPU138.NMI:Non-maskable_interrupts
      5350 ±  6%     -31.1%       3684 ±  9%  interrupts.CPU138.PMI:Performance_monitoring_interrupts
    797.25 ±  4%     +48.5%       1183 ±  7%  interrupts.CPU138.RES:Rescheduling_interrupts
    510.25 ± 15%     +66.0%     847.00 ± 13%  interrupts.CPU138.TLB:TLB_shootdowns
      5341 ±  7%     -30.6%       3705 ±  9%  interrupts.CPU139.NMI:Non-maskable_interrupts
      5341 ±  7%     -30.6%       3705 ±  9%  interrupts.CPU139.PMI:Performance_monitoring_interrupts
    729.25 ±  5%     +60.8%       1172 ±  6%  interrupts.CPU139.RES:Rescheduling_interrupts
    435.75 ± 10%    +105.1%     893.75 ± 10%  interrupts.CPU139.TLB:TLB_shootdowns
    885.75 ±  4%     +18.6%       1050 ±  2%  interrupts.CPU14.RES:Rescheduling_interrupts
    438.25 ± 15%     +95.0%     854.75 ± 19%  interrupts.CPU14.TLB:TLB_shootdowns
      5309 ±  7%     -30.9%       3669 ±  9%  interrupts.CPU140.NMI:Non-maskable_interrupts
      5309 ±  7%     -30.9%       3669 ±  9%  interrupts.CPU140.PMI:Performance_monitoring_interrupts
    729.00 ±  5%     +53.4%       1118 ±  5%  interrupts.CPU140.RES:Rescheduling_interrupts
    485.25 ± 11%     +76.9%     858.50 ± 15%  interrupts.CPU140.TLB:TLB_shootdowns
      5351 ±  7%     -38.3%       3302 ± 29%  interrupts.CPU141.NMI:Non-maskable_interrupts
      5351 ±  7%     -38.3%       3302 ± 29%  interrupts.CPU141.PMI:Performance_monitoring_interrupts
    777.25 ±  7%     +44.1%       1120 ±  6%  interrupts.CPU141.RES:Rescheduling_interrupts
    493.25 ± 14%     +84.2%     908.75 ± 21%  interrupts.CPU141.TLB:TLB_shootdowns
      5311 ±  7%     -41.0%       3136 ± 24%  interrupts.CPU142.NMI:Non-maskable_interrupts
      5311 ±  7%     -41.0%       3136 ± 24%  interrupts.CPU142.PMI:Performance_monitoring_interrupts
    789.50 ±  9%     +46.3%       1154 ±  8%  interrupts.CPU142.RES:Rescheduling_interrupts
    424.00 ± 14%    +116.7%     918.75 ± 10%  interrupts.CPU142.TLB:TLB_shootdowns
      5347 ±  8%     -31.5%       3660 ±  9%  interrupts.CPU143.NMI:Non-maskable_interrupts
      5347 ±  8%     -31.5%       3660 ±  9%  interrupts.CPU143.PMI:Performance_monitoring_interrupts
    736.75 ±  4%     +61.0%       1186 ±  7%  interrupts.CPU143.RES:Rescheduling_interrupts
    470.75 ± 13%     +98.5%     934.50 ± 15%  interrupts.CPU143.TLB:TLB_shootdowns
      5357 ±  7%     -31.1%       3693 ±  8%  interrupts.CPU144.NMI:Non-maskable_interrupts
      5357 ±  7%     -31.1%       3693 ±  8%  interrupts.CPU144.PMI:Performance_monitoring_interrupts
    743.75 ±  6%     +68.2%       1251 ±  6%  interrupts.CPU144.RES:Rescheduling_interrupts
    480.50 ± 21%     +91.8%     921.50 ±  3%  interrupts.CPU144.TLB:TLB_shootdowns
      5343 ±  7%     -40.6%       3171 ± 23%  interrupts.CPU145.NMI:Non-maskable_interrupts
      5343 ±  7%     -40.6%       3171 ± 23%  interrupts.CPU145.PMI:Performance_monitoring_interrupts
    757.75 ± 12%     +57.8%       1195 ±  9%  interrupts.CPU145.RES:Rescheduling_interrupts
    458.00 ± 11%     +90.3%     871.50 ±  7%  interrupts.CPU145.TLB:TLB_shootdowns
      5355 ±  8%     -31.9%       3646 ±  9%  interrupts.CPU146.NMI:Non-maskable_interrupts
      5355 ±  8%     -31.9%       3646 ±  9%  interrupts.CPU146.PMI:Performance_monitoring_interrupts
    722.50 ±  2%     +64.3%       1187 ±  4%  interrupts.CPU146.RES:Rescheduling_interrupts
    443.50 ± 22%    +106.0%     913.75 ±  2%  interrupts.CPU146.TLB:TLB_shootdowns
      5319 ±  6%     -30.9%       3676 ±  8%  interrupts.CPU147.NMI:Non-maskable_interrupts
      5319 ±  6%     -30.9%       3676 ±  8%  interrupts.CPU147.PMI:Performance_monitoring_interrupts
    690.25 ±  6%     +72.8%       1193 ±  6%  interrupts.CPU147.RES:Rescheduling_interrupts
    442.25 ± 16%     +92.0%     849.25 ± 14%  interrupts.CPU147.TLB:TLB_shootdowns
      5342 ±  7%     -39.7%       3221 ± 27%  interrupts.CPU148.NMI:Non-maskable_interrupts
      5342 ±  7%     -39.7%       3221 ± 27%  interrupts.CPU148.PMI:Performance_monitoring_interrupts
    778.50 ±  3%     +61.4%       1256 ±  6%  interrupts.CPU148.RES:Rescheduling_interrupts
    474.25 ± 11%    +104.0%     967.50 ±  9%  interrupts.CPU148.TLB:TLB_shootdowns
      5314 ±  7%     -32.1%       3608 ± 10%  interrupts.CPU149.NMI:Non-maskable_interrupts
      5314 ±  7%     -32.1%       3608 ± 10%  interrupts.CPU149.PMI:Performance_monitoring_interrupts
    695.75 ±  9%     +70.4%       1185 ±  6%  interrupts.CPU149.RES:Rescheduling_interrupts
    419.75 ± 20%    +113.7%     897.00 ±  9%  interrupts.CPU149.TLB:TLB_shootdowns
      5357 ±  7%     -39.9%       3219 ± 27%  interrupts.CPU15.NMI:Non-maskable_interrupts
      5357 ±  7%     -39.9%       3219 ± 27%  interrupts.CPU15.PMI:Performance_monitoring_interrupts
    877.50 ±  5%     +24.1%       1088 ±  2%  interrupts.CPU15.RES:Rescheduling_interrupts
    419.75 ± 10%    +111.7%     888.50 ± 13%  interrupts.CPU15.TLB:TLB_shootdowns
      5377 ±  7%     -32.1%       3649 ±  9%  interrupts.CPU150.NMI:Non-maskable_interrupts
      5377 ±  7%     -32.1%       3649 ±  9%  interrupts.CPU150.PMI:Performance_monitoring_interrupts
    709.00 ±  5%     +69.1%       1199 ±  6%  interrupts.CPU150.RES:Rescheduling_interrupts
    445.00 ± 13%     +87.9%     836.00 ±  7%  interrupts.CPU150.TLB:TLB_shootdowns
    697.50 ±  8%     +73.9%       1213 ± 14%  interrupts.CPU151.RES:Rescheduling_interrupts
    448.25 ± 17%     +88.6%     845.25 ±  6%  interrupts.CPU151.TLB:TLB_shootdowns
      5336 ±  7%     -31.9%       3632 ± 10%  interrupts.CPU152.NMI:Non-maskable_interrupts
      5336 ±  7%     -31.9%       3632 ± 10%  interrupts.CPU152.PMI:Performance_monitoring_interrupts
    759.25 ±  7%     +56.0%       1184 ±  9%  interrupts.CPU152.RES:Rescheduling_interrupts
    458.75 ± 11%     +96.9%     903.25 ±  8%  interrupts.CPU152.TLB:TLB_shootdowns
      5358 ±  7%     -32.0%       3642 ± 10%  interrupts.CPU153.NMI:Non-maskable_interrupts
      5358 ±  7%     -32.0%       3642 ± 10%  interrupts.CPU153.PMI:Performance_monitoring_interrupts
    719.00 ±  5%     +65.3%       1188 ±  5%  interrupts.CPU153.RES:Rescheduling_interrupts
    463.00 ± 15%     +96.7%     910.75 ± 10%  interrupts.CPU153.TLB:TLB_shootdowns
      5335 ±  7%     -41.1%       3140 ± 22%  interrupts.CPU154.NMI:Non-maskable_interrupts
      5335 ±  7%     -41.1%       3140 ± 22%  interrupts.CPU154.PMI:Performance_monitoring_interrupts
    695.75           +72.0%       1196 ±  7%  interrupts.CPU154.RES:Rescheduling_interrupts
    489.50 ± 14%     +63.6%     801.00 ± 10%  interrupts.CPU154.TLB:TLB_shootdowns
      5390 ±  6%     -41.3%       3164 ± 22%  interrupts.CPU155.NMI:Non-maskable_interrupts
      5390 ±  6%     -41.3%       3164 ± 22%  interrupts.CPU155.PMI:Performance_monitoring_interrupts
    758.50 ±  7%     +50.6%       1142 ±  7%  interrupts.CPU155.RES:Rescheduling_interrupts
    448.25 ± 11%     +93.0%     865.25 ± 14%  interrupts.CPU155.TLB:TLB_shootdowns
      5339 ±  7%     -31.5%       3657 ± 10%  interrupts.CPU156.NMI:Non-maskable_interrupts
      5339 ±  7%     -31.5%       3657 ± 10%  interrupts.CPU156.PMI:Performance_monitoring_interrupts
    710.00 ±  6%     +69.8%       1205 ±  6%  interrupts.CPU156.RES:Rescheduling_interrupts
    448.00 ± 10%     +89.8%     850.50 ±  8%  interrupts.CPU156.TLB:TLB_shootdowns
      5327 ±  7%     -31.9%       3627 ±  9%  interrupts.CPU157.NMI:Non-maskable_interrupts
      5327 ±  7%     -31.9%       3627 ±  9%  interrupts.CPU157.PMI:Performance_monitoring_interrupts
    663.50 ±  5%     +74.3%       1156 ±  5%  interrupts.CPU157.RES:Rescheduling_interrupts
    466.50 ± 16%     +96.0%     914.50 ± 10%  interrupts.CPU157.TLB:TLB_shootdowns
      5343 ±  7%     -31.7%       3648 ± 10%  interrupts.CPU158.NMI:Non-maskable_interrupts
      5343 ±  7%     -31.7%       3648 ± 10%  interrupts.CPU158.PMI:Performance_monitoring_interrupts
    755.75 ±  3%     +60.3%       1211 ±  5%  interrupts.CPU158.RES:Rescheduling_interrupts
    431.25 ± 10%    +116.7%     934.50 ±  5%  interrupts.CPU158.TLB:TLB_shootdowns
    719.25 ±  8%     +61.9%       1164 ±  5%  interrupts.CPU159.RES:Rescheduling_interrupts
    430.75 ± 14%    +122.1%     956.75 ± 13%  interrupts.CPU159.TLB:TLB_shootdowns
      5360 ±  7%     -28.8%       3816 ±  8%  interrupts.CPU16.NMI:Non-maskable_interrupts
      5360 ±  7%     -28.8%       3816 ±  8%  interrupts.CPU16.PMI:Performance_monitoring_interrupts
    856.50 ±  5%     +23.8%       1060 ±  3%  interrupts.CPU16.RES:Rescheduling_interrupts
    468.25 ± 20%     +75.1%     820.00 ± 10%  interrupts.CPU16.TLB:TLB_shootdowns
    740.00 ± 10%     +66.2%       1230 ±  6%  interrupts.CPU160.RES:Rescheduling_interrupts
    429.75 ±  9%    +107.2%     890.25 ±  9%  interrupts.CPU160.TLB:TLB_shootdowns
      5337 ±  7%     -46.8%       2837 ± 33%  interrupts.CPU161.NMI:Non-maskable_interrupts
      5337 ±  7%     -46.8%       2837 ± 33%  interrupts.CPU161.PMI:Performance_monitoring_interrupts
    723.25 ±  6%     +68.5%       1218 ±  2%  interrupts.CPU161.RES:Rescheduling_interrupts
    444.75 ±  7%    +101.7%     897.00 ±  9%  interrupts.CPU161.TLB:TLB_shootdowns
      5384 ±  7%     -39.9%       3236 ± 25%  interrupts.CPU162.NMI:Non-maskable_interrupts
      5384 ±  7%     -39.9%       3236 ± 25%  interrupts.CPU162.PMI:Performance_monitoring_interrupts
    694.75 ± 11%     +60.6%       1115 ±  5%  interrupts.CPU162.RES:Rescheduling_interrupts
    718.75 ±  6%     +65.9%       1192 ±  4%  interrupts.CPU163.RES:Rescheduling_interrupts
    475.50 ± 14%     +87.7%     892.75 ±  5%  interrupts.CPU163.TLB:TLB_shootdowns
      5324 ±  7%     -41.0%       3143 ± 24%  interrupts.CPU164.NMI:Non-maskable_interrupts
      5324 ±  7%     -41.0%       3143 ± 24%  interrupts.CPU164.PMI:Performance_monitoring_interrupts
    694.00 ±  8%     +66.9%       1158 ±  2%  interrupts.CPU164.RES:Rescheduling_interrupts
    456.25 ± 18%     +97.6%     901.50 ± 13%  interrupts.CPU164.TLB:TLB_shootdowns
      5385 ±  7%     -40.0%       3233 ± 24%  interrupts.CPU165.NMI:Non-maskable_interrupts
      5385 ±  7%     -40.0%       3233 ± 24%  interrupts.CPU165.PMI:Performance_monitoring_interrupts
    667.50 ±  3%     +84.9%       1234 ±  4%  interrupts.CPU165.RES:Rescheduling_interrupts
    410.00 ± 14%    +112.0%     869.00 ± 12%  interrupts.CPU165.TLB:TLB_shootdowns
      5350 ±  7%     -40.3%       3191 ± 25%  interrupts.CPU166.NMI:Non-maskable_interrupts
      5350 ±  7%     -40.3%       3191 ± 25%  interrupts.CPU166.PMI:Performance_monitoring_interrupts
    740.00 ±  7%     +62.0%       1198 ±  3%  interrupts.CPU166.RES:Rescheduling_interrupts
    461.75 ± 19%     +78.7%     825.25 ±  6%  interrupts.CPU166.TLB:TLB_shootdowns
      5333 ±  7%     -32.0%       3625 ± 10%  interrupts.CPU167.NMI:Non-maskable_interrupts
      5333 ±  7%     -32.0%       3625 ± 10%  interrupts.CPU167.PMI:Performance_monitoring_interrupts
    672.75 ±  3%     +74.1%       1171 ±  2%  interrupts.CPU167.RES:Rescheduling_interrupts
    472.25 ± 19%    +100.1%     944.75 ± 10%  interrupts.CPU167.TLB:TLB_shootdowns
    742.25 ±  4%     +52.1%       1129 ±  5%  interrupts.CPU168.RES:Rescheduling_interrupts
    429.50 ± 15%     +91.3%     821.50 ± 17%  interrupts.CPU168.TLB:TLB_shootdowns
      5367 ±  7%     -49.0%       2736 ± 35%  interrupts.CPU169.NMI:Non-maskable_interrupts
      5367 ±  7%     -49.0%       2736 ± 35%  interrupts.CPU169.PMI:Performance_monitoring_interrupts
    752.75 ±  5%     +50.6%       1133 ±  9%  interrupts.CPU169.RES:Rescheduling_interrupts
    445.75 ± 10%    +103.3%     906.25 ± 20%  interrupts.CPU169.TLB:TLB_shootdowns
    910.00 ±  8%     +19.0%       1082 ±  4%  interrupts.CPU17.RES:Rescheduling_interrupts
    426.75 ± 21%     +98.7%     848.00 ± 10%  interrupts.CPU17.TLB:TLB_shootdowns
      5344 ±  7%     -39.9%       3213 ± 30%  interrupts.CPU170.NMI:Non-maskable_interrupts
      5344 ±  7%     -39.9%       3213 ± 30%  interrupts.CPU170.PMI:Performance_monitoring_interrupts
    765.25 ±  3%     +42.9%       1093 ±  5%  interrupts.CPU170.RES:Rescheduling_interrupts
    408.50 ± 11%    +127.2%     928.25 ± 11%  interrupts.CPU170.TLB:TLB_shootdowns
    754.25 ±  6%     +49.5%       1127 ±  4%  interrupts.CPU171.RES:Rescheduling_interrupts
    489.00 ± 11%     +76.7%     864.25 ±  9%  interrupts.CPU171.TLB:TLB_shootdowns
      5386 ±  7%     -32.5%       3638 ±  8%  interrupts.CPU172.NMI:Non-maskable_interrupts
      5386 ±  7%     -32.5%       3638 ±  8%  interrupts.CPU172.PMI:Performance_monitoring_interrupts
    746.25 ±  8%     +47.2%       1098 ±  4%  interrupts.CPU172.RES:Rescheduling_interrupts
    448.50 ± 11%     +94.2%     871.00 ± 17%  interrupts.CPU172.TLB:TLB_shootdowns
      5342 ±  8%     -39.6%       3226 ± 29%  interrupts.CPU173.NMI:Non-maskable_interrupts
      5342 ±  8%     -39.6%       3226 ± 29%  interrupts.CPU173.PMI:Performance_monitoring_interrupts
    715.00 ±  6%     +49.7%       1070 ±  6%  interrupts.CPU173.RES:Rescheduling_interrupts
    489.75 ± 14%     +75.6%     860.00 ± 18%  interrupts.CPU173.TLB:TLB_shootdowns
      5381 ±  7%     -39.6%       3252 ± 30%  interrupts.CPU174.NMI:Non-maskable_interrupts
      5381 ±  7%     -39.6%       3252 ± 30%  interrupts.CPU174.PMI:Performance_monitoring_interrupts
    696.25 ±  5%     +60.0%       1114 ±  7%  interrupts.CPU174.RES:Rescheduling_interrupts
    485.75 ± 20%     +85.8%     902.50 ± 17%  interrupts.CPU174.TLB:TLB_shootdowns
      5343 ±  8%     -32.5%       3605 ±  9%  interrupts.CPU175.NMI:Non-maskable_interrupts
      5343 ±  8%     -32.5%       3605 ±  9%  interrupts.CPU175.PMI:Performance_monitoring_interrupts
    707.25 ±  5%     +61.0%       1139 ±  5%  interrupts.CPU175.RES:Rescheduling_interrupts
    429.00 ± 17%    +107.9%     891.75 ± 15%  interrupts.CPU175.TLB:TLB_shootdowns
      5345 ±  7%     -33.0%       3582 ±  8%  interrupts.CPU176.NMI:Non-maskable_interrupts
      5345 ±  7%     -33.0%       3582 ±  8%  interrupts.CPU176.PMI:Performance_monitoring_interrupts
    691.50 ±  3%     +55.8%       1077 ±  7%  interrupts.CPU176.RES:Rescheduling_interrupts
    493.75 ± 13%     +73.0%     854.25 ± 14%  interrupts.CPU176.TLB:TLB_shootdowns
      5333 ±  7%     -32.7%       3590 ±  8%  interrupts.CPU177.NMI:Non-maskable_interrupts
      5333 ±  7%     -32.7%       3590 ±  8%  interrupts.CPU177.PMI:Performance_monitoring_interrupts
    717.25 ±  4%     +55.9%       1118 ±  4%  interrupts.CPU177.RES:Rescheduling_interrupts
    459.50 ± 13%     +87.5%     861.75 ± 19%  interrupts.CPU177.TLB:TLB_shootdowns
      5365 ±  7%     -50.5%       2653 ± 34%  interrupts.CPU178.NMI:Non-maskable_interrupts
      5365 ±  7%     -50.5%       2653 ± 34%  interrupts.CPU178.PMI:Performance_monitoring_interrupts
    729.25 ±  2%     +55.4%       1133 ±  3%  interrupts.CPU178.RES:Rescheduling_interrupts
    450.25 ± 14%    +106.6%     930.25 ± 13%  interrupts.CPU178.TLB:TLB_shootdowns
      5313 ±  7%     -40.0%       3190 ± 23%  interrupts.CPU179.NMI:Non-maskable_interrupts
      5313 ±  7%     -40.0%       3190 ± 23%  interrupts.CPU179.PMI:Performance_monitoring_interrupts
    764.75 ±  7%     +46.6%       1120 ±  3%  interrupts.CPU179.RES:Rescheduling_interrupts
    475.25 ± 23%     +72.7%     820.75 ± 13%  interrupts.CPU179.TLB:TLB_shootdowns
      5371 ±  7%     -30.1%       3753 ±  8%  interrupts.CPU18.NMI:Non-maskable_interrupts
      5371 ±  7%     -30.1%       3753 ±  8%  interrupts.CPU18.PMI:Performance_monitoring_interrupts
    870.00 ±  2%     +19.9%       1042 ±  4%  interrupts.CPU18.RES:Rescheduling_interrupts
    425.25 ± 11%    +103.6%     865.75 ±  7%  interrupts.CPU18.TLB:TLB_shootdowns
    691.50 ±  4%     +57.5%       1089 ±  5%  interrupts.CPU180.RES:Rescheduling_interrupts
    441.50 ±  7%     +93.9%     856.00 ± 16%  interrupts.CPU180.TLB:TLB_shootdowns
      5357 ±  7%     -42.7%       3069 ± 21%  interrupts.CPU181.NMI:Non-maskable_interrupts
      5357 ±  7%     -42.7%       3069 ± 21%  interrupts.CPU181.PMI:Performance_monitoring_interrupts
    730.25 ±  4%     +49.6%       1092 ±  6%  interrupts.CPU181.RES:Rescheduling_interrupts
    428.50 ± 21%     +96.7%     842.75 ± 14%  interrupts.CPU181.TLB:TLB_shootdowns
    787.00 ±  5%     +41.0%       1109 ±  2%  interrupts.CPU182.RES:Rescheduling_interrupts
    482.25 ± 14%     +74.0%     839.00 ± 13%  interrupts.CPU182.TLB:TLB_shootdowns
      5351 ±  7%     -40.5%       3181 ± 28%  interrupts.CPU183.NMI:Non-maskable_interrupts
      5351 ±  7%     -40.5%       3181 ± 28%  interrupts.CPU183.PMI:Performance_monitoring_interrupts
    739.50 ±  5%     +44.0%       1064 ±  2%  interrupts.CPU183.RES:Rescheduling_interrupts
    449.00 ± 17%     +93.0%     866.50 ± 16%  interrupts.CPU183.TLB:TLB_shootdowns
      5342 ±  8%     -40.4%       3186 ± 26%  interrupts.CPU184.NMI:Non-maskable_interrupts
      5342 ±  8%     -40.4%       3186 ± 26%  interrupts.CPU184.PMI:Performance_monitoring_interrupts
    721.00 ±  6%     +52.9%       1102 ±  8%  interrupts.CPU184.RES:Rescheduling_interrupts
    451.50 ± 18%     +89.5%     855.75 ± 18%  interrupts.CPU184.TLB:TLB_shootdowns
      5333 ±  8%     -32.2%       3613 ± 10%  interrupts.CPU185.NMI:Non-maskable_interrupts
      5333 ±  8%     -32.2%       3613 ± 10%  interrupts.CPU185.PMI:Performance_monitoring_interrupts
    699.00 ±  4%     +69.1%       1181 ±  7%  interrupts.CPU185.RES:Rescheduling_interrupts
    426.75 ± 11%    +103.6%     868.75 ± 11%  interrupts.CPU185.TLB:TLB_shootdowns
      5362 ±  7%     -31.2%       3691 ± 11%  interrupts.CPU186.NMI:Non-maskable_interrupts
      5362 ±  7%     -31.2%       3691 ± 11%  interrupts.CPU186.PMI:Performance_monitoring_interrupts
    727.25 ±  6%     +49.0%       1083 ±  8%  interrupts.CPU186.RES:Rescheduling_interrupts
    470.75 ± 13%     +85.4%     872.75 ± 14%  interrupts.CPU186.TLB:TLB_shootdowns
      5360 ±  7%     -32.5%       3619 ±  9%  interrupts.CPU187.NMI:Non-maskable_interrupts
      5360 ±  7%     -32.5%       3619 ±  9%  interrupts.CPU187.PMI:Performance_monitoring_interrupts
    760.50 ±  6%     +43.6%       1091 ±  7%  interrupts.CPU187.RES:Rescheduling_interrupts
    470.25 ± 13%    +106.9%     972.75 ± 17%  interrupts.CPU187.TLB:TLB_shootdowns
      5387 ±  7%     -41.1%       3173 ± 24%  interrupts.CPU188.NMI:Non-maskable_interrupts
      5387 ±  7%     -41.1%       3173 ± 24%  interrupts.CPU188.PMI:Performance_monitoring_interrupts
    736.50 ±  5%     +53.2%       1128 ±  4%  interrupts.CPU188.RES:Rescheduling_interrupts
    437.00 ± 16%    +105.7%     898.75 ± 17%  interrupts.CPU188.TLB:TLB_shootdowns
      5351 ±  7%     -32.0%       3638 ±  9%  interrupts.CPU189.NMI:Non-maskable_interrupts
      5351 ±  7%     -32.0%       3638 ±  9%  interrupts.CPU189.PMI:Performance_monitoring_interrupts
    752.75 ±  3%     +48.1%       1114 ±  6%  interrupts.CPU189.RES:Rescheduling_interrupts
    439.75 ± 11%    +111.0%     927.75 ± 20%  interrupts.CPU189.TLB:TLB_shootdowns
      5301 ±  7%     -37.8%       3298 ± 26%  interrupts.CPU19.NMI:Non-maskable_interrupts
      5301 ±  7%     -37.8%       3298 ± 26%  interrupts.CPU19.PMI:Performance_monitoring_interrupts
    823.75 ±  4%     +34.4%       1107 ±  3%  interrupts.CPU19.RES:Rescheduling_interrupts
    396.00 ± 17%    +115.2%     852.00 ± 13%  interrupts.CPU19.TLB:TLB_shootdowns
      5372 ±  7%     -32.5%       3627 ±  9%  interrupts.CPU190.NMI:Non-maskable_interrupts
      5372 ±  7%     -32.5%       3627 ±  9%  interrupts.CPU190.PMI:Performance_monitoring_interrupts
    722.75 ±  4%     +50.0%       1084 ±  7%  interrupts.CPU190.RES:Rescheduling_interrupts
    451.25 ± 18%    +108.1%     939.25 ±  3%  interrupts.CPU190.TLB:TLB_shootdowns
      5342 ±  7%     -57.7%       2258 ± 32%  interrupts.CPU191.NMI:Non-maskable_interrupts
      5342 ±  7%     -57.7%       2258 ± 32%  interrupts.CPU191.PMI:Performance_monitoring_interrupts
    769.25 ±  5%     +41.3%       1086 ±  4%  interrupts.CPU191.RES:Rescheduling_interrupts
    462.75 ±  6%     +92.8%     892.25 ± 14%  interrupts.CPU191.TLB:TLB_shootdowns
      5308 ±  7%     -29.4%       3745 ±  7%  interrupts.CPU2.NMI:Non-maskable_interrupts
      5308 ±  7%     -29.4%       3745 ±  7%  interrupts.CPU2.PMI:Performance_monitoring_interrupts
    883.25 ±  4%     +24.7%       1101 ±  5%  interrupts.CPU2.RES:Rescheduling_interrupts
    539.00 ± 17%     +55.8%     839.75 ± 11%  interrupts.CPU2.TLB:TLB_shootdowns
      5307 ±  7%     -47.2%       2803 ± 34%  interrupts.CPU20.NMI:Non-maskable_interrupts
      5307 ±  7%     -47.2%       2803 ± 34%  interrupts.CPU20.PMI:Performance_monitoring_interrupts
    884.50 ±  3%     +24.2%       1098 ±  4%  interrupts.CPU20.RES:Rescheduling_interrupts
    434.75 ± 20%    +186.7%       1246 ± 56%  interrupts.CPU20.TLB:TLB_shootdowns
      5338 ±  7%     -38.4%       3289 ± 25%  interrupts.CPU21.NMI:Non-maskable_interrupts
      5338 ±  7%     -38.4%       3289 ± 25%  interrupts.CPU21.PMI:Performance_monitoring_interrupts
    900.50 ±  4%     +20.8%       1087 ±  7%  interrupts.CPU21.RES:Rescheduling_interrupts
    463.00 ± 15%     +94.5%     900.50 ±  7%  interrupts.CPU21.TLB:TLB_shootdowns
      5328 ±  7%     -28.9%       3786 ±  8%  interrupts.CPU22.NMI:Non-maskable_interrupts
      5328 ±  7%     -28.9%       3786 ±  8%  interrupts.CPU22.PMI:Performance_monitoring_interrupts
    881.25 ±  6%     +28.4%       1131 ±  5%  interrupts.CPU22.RES:Rescheduling_interrupts
    442.50 ± 23%    +105.3%     908.25 ± 13%  interrupts.CPU22.TLB:TLB_shootdowns
      5341 ±  7%     -30.4%       3717 ±  9%  interrupts.CPU23.NMI:Non-maskable_interrupts
      5341 ±  7%     -30.4%       3717 ±  9%  interrupts.CPU23.PMI:Performance_monitoring_interrupts
    877.25           +23.5%       1083 ±  4%  interrupts.CPU23.RES:Rescheduling_interrupts
    481.75 ±  8%     +79.3%     863.75 ± 11%  interrupts.CPU23.TLB:TLB_shootdowns
      5356 ±  7%     -37.8%       3331 ± 27%  interrupts.CPU24.NMI:Non-maskable_interrupts
      5356 ±  7%     -37.8%       3331 ± 27%  interrupts.CPU24.PMI:Performance_monitoring_interrupts
    893.25 ±  6%     +23.7%       1104 ±  4%  interrupts.CPU24.RES:Rescheduling_interrupts
    623.75 ± 17%     +49.0%     929.50 ±  8%  interrupts.CPU24.TLB:TLB_shootdowns
      5299 ±  7%     -28.7%       3779 ±  7%  interrupts.CPU25.NMI:Non-maskable_interrupts
      5299 ±  7%     -28.7%       3779 ±  7%  interrupts.CPU25.PMI:Performance_monitoring_interrupts
    793.50 ±  2%     +37.6%       1092 ±  6%  interrupts.CPU25.RES:Rescheduling_interrupts
    544.25 ± 13%     +73.5%     944.25 ±  6%  interrupts.CPU25.TLB:TLB_shootdowns
    835.50 ±  3%     +29.6%       1082 ±  5%  interrupts.CPU26.RES:Rescheduling_interrupts
    476.75 ± 18%     +93.9%     924.25 ±  9%  interrupts.CPU26.TLB:TLB_shootdowns
      5364 ±  7%     -29.6%       3776 ± 10%  interrupts.CPU27.NMI:Non-maskable_interrupts
      5364 ±  7%     -29.6%       3776 ± 10%  interrupts.CPU27.PMI:Performance_monitoring_interrupts
    849.50 ±  5%     +29.7%       1102 ±  5%  interrupts.CPU27.RES:Rescheduling_interrupts
    485.25 ±  9%     +97.0%     956.00 ±  7%  interrupts.CPU27.TLB:TLB_shootdowns
    840.25 ±  4%     +33.1%       1118 ±  6%  interrupts.CPU28.RES:Rescheduling_interrupts
    476.25 ± 28%     +97.3%     939.50 ± 11%  interrupts.CPU28.TLB:TLB_shootdowns
    829.75 ±  2%     +33.3%       1106 ±  5%  interrupts.CPU29.RES:Rescheduling_interrupts
    382.50 ± 27%    +138.1%     910.75 ± 13%  interrupts.CPU29.TLB:TLB_shootdowns
      5321 ±  7%     -48.1%       2760 ± 33%  interrupts.CPU3.NMI:Non-maskable_interrupts
      5321 ±  7%     -48.1%       2760 ± 33%  interrupts.CPU3.PMI:Performance_monitoring_interrupts
    859.25 ±  5%     +25.5%       1078 ±  3%  interrupts.CPU3.RES:Rescheduling_interrupts
    416.25 ± 12%    +107.6%     864.00 ± 14%  interrupts.CPU3.TLB:TLB_shootdowns
    835.75 ±  8%     +26.7%       1059 ±  6%  interrupts.CPU30.RES:Rescheduling_interrupts
    478.50 ± 24%     +92.9%     923.25 ± 14%  interrupts.CPU30.TLB:TLB_shootdowns
      5384 ±  7%     -30.2%       3759 ±  9%  interrupts.CPU31.NMI:Non-maskable_interrupts
      5384 ±  7%     -30.2%       3759 ±  9%  interrupts.CPU31.PMI:Performance_monitoring_interrupts
    824.00 ±  5%     +39.4%       1148 ±  7%  interrupts.CPU31.RES:Rescheduling_interrupts
    465.50 ± 20%     +98.9%     925.75 ±  6%  interrupts.CPU31.TLB:TLB_shootdowns
      5315 ±  6%     -37.2%       3336 ± 27%  interrupts.CPU32.NMI:Non-maskable_interrupts
      5315 ±  6%     -37.2%       3336 ± 27%  interrupts.CPU32.PMI:Performance_monitoring_interrupts
    883.25 ±  6%     +31.5%       1161 ±  6%  interrupts.CPU32.RES:Rescheduling_interrupts
    467.75 ± 10%     +97.1%     922.00 ± 14%  interrupts.CPU32.TLB:TLB_shootdowns
      5327 ±  7%     -30.1%       3726 ±  9%  interrupts.CPU33.NMI:Non-maskable_interrupts
      5327 ±  7%     -30.1%       3726 ±  9%  interrupts.CPU33.PMI:Performance_monitoring_interrupts
    844.00 ±  5%     +33.3%       1124 ±  9%  interrupts.CPU33.RES:Rescheduling_interrupts
    416.50 ± 17%    +119.8%     915.50 ±  7%  interrupts.CPU33.TLB:TLB_shootdowns
      5304 ±  8%     -38.0%       3291 ± 26%  interrupts.CPU34.NMI:Non-maskable_interrupts
      5304 ±  8%     -38.0%       3291 ± 26%  interrupts.CPU34.PMI:Performance_monitoring_interrupts
    857.00 ±  3%     +27.5%       1092 ±  4%  interrupts.CPU34.RES:Rescheduling_interrupts
    452.50 ± 24%    +100.0%     905.00 ±  6%  interrupts.CPU34.TLB:TLB_shootdowns
      5298 ±  8%     -28.4%       3792 ± 11%  interrupts.CPU35.NMI:Non-maskable_interrupts
      5298 ±  8%     -28.4%       3792 ± 11%  interrupts.CPU35.PMI:Performance_monitoring_interrupts
    847.75 ±  7%     +33.8%       1134 ±  4%  interrupts.CPU35.RES:Rescheduling_interrupts
    458.00 ± 18%     +94.8%     892.00 ± 11%  interrupts.CPU35.TLB:TLB_shootdowns
      5355 ±  8%     -37.9%       3325 ± 26%  interrupts.CPU36.NMI:Non-maskable_interrupts
      5355 ±  8%     -37.9%       3325 ± 26%  interrupts.CPU36.PMI:Performance_monitoring_interrupts
    872.25 ±  6%     +29.8%       1131 ±  6%  interrupts.CPU36.RES:Rescheduling_interrupts
    461.25 ± 14%    +100.5%     925.00 ±  6%  interrupts.CPU36.TLB:TLB_shootdowns
      5314 ±  7%     -38.4%       3275 ± 25%  interrupts.CPU37.NMI:Non-maskable_interrupts
      5314 ±  7%     -38.4%       3275 ± 25%  interrupts.CPU37.PMI:Performance_monitoring_interrupts
    883.50 ±  4%     +27.0%       1121        interrupts.CPU37.RES:Rescheduling_interrupts
    436.50 ± 17%    +109.6%     915.00 ±  9%  interrupts.CPU37.TLB:TLB_shootdowns
      5341 ±  7%     -28.8%       3803 ± 10%  interrupts.CPU38.NMI:Non-maskable_interrupts
      5341 ±  7%     -28.8%       3803 ± 10%  interrupts.CPU38.PMI:Performance_monitoring_interrupts
    842.50 ±  3%     +32.3%       1114 ±  6%  interrupts.CPU38.RES:Rescheduling_interrupts
    501.00 ± 10%    +114.2%       1073 ± 24%  interrupts.CPU38.TLB:TLB_shootdowns
      5329 ±  7%     -37.5%       3329 ± 27%  interrupts.CPU39.NMI:Non-maskable_interrupts
      5329 ±  7%     -37.5%       3329 ± 27%  interrupts.CPU39.PMI:Performance_monitoring_interrupts
    838.50 ±  6%     +37.3%       1151 ±  4%  interrupts.CPU39.RES:Rescheduling_interrupts
    487.00 ±  6%     +77.6%     864.75 ±  9%  interrupts.CPU39.TLB:TLB_shootdowns
      5364 ±  7%     -31.4%       3679 ±  8%  interrupts.CPU4.NMI:Non-maskable_interrupts
      5364 ±  7%     -31.4%       3679 ±  8%  interrupts.CPU4.PMI:Performance_monitoring_interrupts
    839.00           +23.0%       1032 ±  4%  interrupts.CPU4.RES:Rescheduling_interrupts
    402.00 ± 21%    +112.4%     853.75 ± 12%  interrupts.CPU4.TLB:TLB_shootdowns
      4102 ± 39%     -42.8%       2347 ± 35%  interrupts.CPU40.NMI:Non-maskable_interrupts
      4102 ± 39%     -42.8%       2347 ± 35%  interrupts.CPU40.PMI:Performance_monitoring_interrupts
    854.00 ±  6%     +32.8%       1134 ±  6%  interrupts.CPU40.RES:Rescheduling_interrupts
    461.75 ± 15%     +97.2%     910.75 ±  4%  interrupts.CPU40.TLB:TLB_shootdowns
      5296 ±  7%     -29.4%       3737 ±  9%  interrupts.CPU41.NMI:Non-maskable_interrupts
      5296 ±  7%     -29.4%       3737 ±  9%  interrupts.CPU41.PMI:Performance_monitoring_interrupts
    886.00 ±  5%     +28.4%       1137 ±  7%  interrupts.CPU41.RES:Rescheduling_interrupts
    449.75 ± 14%     +90.7%     857.75 ±  8%  interrupts.CPU41.TLB:TLB_shootdowns
    835.00 ±  4%     +35.1%       1127 ±  7%  interrupts.CPU42.RES:Rescheduling_interrupts
    459.25 ± 18%    +110.2%     965.50 ±  5%  interrupts.CPU42.TLB:TLB_shootdowns
      4054 ± 38%     -40.5%       2414 ± 44%  interrupts.CPU43.NMI:Non-maskable_interrupts
      4054 ± 38%     -40.5%       2414 ± 44%  interrupts.CPU43.PMI:Performance_monitoring_interrupts
    892.75 ±  5%     +24.4%       1111 ±  4%  interrupts.CPU43.RES:Rescheduling_interrupts
    486.25 ± 14%     +84.7%     898.25 ±  8%  interrupts.CPU43.TLB:TLB_shootdowns
    813.75 ±  4%     +36.3%       1108 ±  3%  interrupts.CPU44.RES:Rescheduling_interrupts
    437.75 ± 18%    +105.5%     899.75 ± 12%  interrupts.CPU44.TLB:TLB_shootdowns
    845.75 ±  3%     +31.1%       1109 ±  2%  interrupts.CPU45.RES:Rescheduling_interrupts
    474.75 ± 18%     +86.0%     883.25 ± 11%  interrupts.CPU45.TLB:TLB_shootdowns
    866.25 ±  8%     +33.4%       1155 ±  7%  interrupts.CPU46.RES:Rescheduling_interrupts
    447.00 ± 28%     +87.1%     836.25 ± 14%  interrupts.CPU46.TLB:TLB_shootdowns
      5332 ±  7%     -28.8%       3797 ±  7%  interrupts.CPU47.NMI:Non-maskable_interrupts
      5332 ±  7%     -28.8%       3797 ±  7%  interrupts.CPU47.PMI:Performance_monitoring_interrupts
    842.75 ±  3%     +30.3%       1098 ±  5%  interrupts.CPU47.RES:Rescheduling_interrupts
    498.75 ± 12%     +83.5%     915.25 ± 11%  interrupts.CPU47.TLB:TLB_shootdowns
      5339 ±  7%     -38.0%       3312 ± 30%  interrupts.CPU48.NMI:Non-maskable_interrupts
      5339 ±  7%     -38.0%       3312 ± 30%  interrupts.CPU48.PMI:Performance_monitoring_interrupts
    874.50 ±  6%     +40.1%       1225 ±  4%  interrupts.CPU48.RES:Rescheduling_interrupts
    554.50 ± 33%     +78.3%     988.50 ± 15%  interrupts.CPU48.TLB:TLB_shootdowns
    852.00 ±  4%     +31.1%       1117 ±  3%  interrupts.CPU49.RES:Rescheduling_interrupts
    514.00 ± 21%     +78.2%     915.75 ± 10%  interrupts.CPU49.TLB:TLB_shootdowns
      5349 ±  7%     -39.1%       3259 ± 26%  interrupts.CPU5.NMI:Non-maskable_interrupts
      5349 ±  7%     -39.1%       3259 ± 26%  interrupts.CPU5.PMI:Performance_monitoring_interrupts
    878.25 ±  8%     +18.6%       1041 ±  4%  interrupts.CPU5.RES:Rescheduling_interrupts
    400.00 ± 20%    +112.5%     850.00 ±  3%  interrupts.CPU5.TLB:TLB_shootdowns
    850.75 ±  5%     +32.6%       1128 ±  3%  interrupts.CPU50.RES:Rescheduling_interrupts
    467.00 ± 19%     +99.3%     930.50 ±  5%  interrupts.CPU50.TLB:TLB_shootdowns
      4662 ± 27%     -60.1%       1859 ±  8%  interrupts.CPU51.NMI:Non-maskable_interrupts
      4662 ± 27%     -60.1%       1859 ±  8%  interrupts.CPU51.PMI:Performance_monitoring_interrupts
    862.50 ±  4%     +33.4%       1150 ±  4%  interrupts.CPU51.RES:Rescheduling_interrupts
    494.75 ± 12%     +98.4%     981.75 ± 12%  interrupts.CPU51.TLB:TLB_shootdowns
    835.75           +43.9%       1203 ±  3%  interrupts.CPU52.RES:Rescheduling_interrupts
    482.75 ± 25%    +102.5%     977.50 ±  8%  interrupts.CPU52.TLB:TLB_shootdowns
    803.25 ±  8%     +42.6%       1145 ±  6%  interrupts.CPU53.RES:Rescheduling_interrupts
    462.50 ± 10%     +98.4%     917.75 ±  6%  interrupts.CPU53.TLB:TLB_shootdowns
    857.00 ±  3%     +38.2%       1184 ±  6%  interrupts.CPU54.RES:Rescheduling_interrupts
    486.75 ± 28%     +74.6%     849.75 ± 13%  interrupts.CPU54.TLB:TLB_shootdowns
    829.00 ±  3%     +39.3%       1154 ±  5%  interrupts.CPU55.RES:Rescheduling_interrupts
    501.25 ± 18%     +94.9%     976.75 ±  8%  interrupts.CPU55.TLB:TLB_shootdowns
      5312 ±  7%     -30.0%       3718 ±  8%  interrupts.CPU56.NMI:Non-maskable_interrupts
      5312 ±  7%     -30.0%       3718 ±  8%  interrupts.CPU56.PMI:Performance_monitoring_interrupts
    808.25 ±  7%     +42.6%       1152 ±  7%  interrupts.CPU56.RES:Rescheduling_interrupts
    461.00 ± 23%     +91.6%     883.50 ±  9%  interrupts.CPU56.TLB:TLB_shootdowns
      5302 ±  8%     -29.2%       3755 ± 10%  interrupts.CPU57.NMI:Non-maskable_interrupts
      5302 ±  8%     -29.2%       3755 ± 10%  interrupts.CPU57.PMI:Performance_monitoring_interrupts
    813.00           +34.0%       1089 ±  5%  interrupts.CPU57.RES:Rescheduling_interrupts
    447.75 ± 17%    +108.5%     933.50 ± 11%  interrupts.CPU57.TLB:TLB_shootdowns
      5250 ±  7%     -38.5%       3231 ± 22%  interrupts.CPU58.NMI:Non-maskable_interrupts
      5250 ±  7%     -38.5%       3231 ± 22%  interrupts.CPU58.PMI:Performance_monitoring_interrupts
    881.50 ±  9%     +26.7%       1117 ±  9%  interrupts.CPU58.RES:Rescheduling_interrupts
    464.00 ± 16%     +97.7%     917.50 ± 11%  interrupts.CPU58.TLB:TLB_shootdowns
      5273 ±  7%     -29.4%       3724 ±  7%  interrupts.CPU59.NMI:Non-maskable_interrupts
      5273 ±  7%     -29.4%       3724 ±  7%  interrupts.CPU59.PMI:Performance_monitoring_interrupts
    836.50 ±  2%     +37.6%       1151 ±  5%  interrupts.CPU59.RES:Rescheduling_interrupts
    454.75 ±  9%     +99.3%     906.25 ± 14%  interrupts.CPU59.TLB:TLB_shootdowns
    902.75 ±  5%     +18.6%       1070 ±  2%  interrupts.CPU6.RES:Rescheduling_interrupts
    383.25 ± 22%    +135.6%     902.75 ± 12%  interrupts.CPU6.TLB:TLB_shootdowns
      5308 ±  8%     -55.4%       2365 ± 38%  interrupts.CPU60.NMI:Non-maskable_interrupts
      5308 ±  8%     -55.4%       2365 ± 38%  interrupts.CPU60.PMI:Performance_monitoring_interrupts
    830.25 ±  4%     +42.0%       1179 ±  3%  interrupts.CPU60.RES:Rescheduling_interrupts
    400.75 ± 15%    +112.0%     849.75 ±  9%  interrupts.CPU60.TLB:TLB_shootdowns
    808.50 ±  4%     +38.1%       1116 ±  8%  interrupts.CPU61.RES:Rescheduling_interrupts
    475.00 ± 23%    +110.3%     998.75 ± 12%  interrupts.CPU61.TLB:TLB_shootdowns
      5301 ±  7%     -39.0%       3233 ± 25%  interrupts.CPU62.NMI:Non-maskable_interrupts
      5301 ±  7%     -39.0%       3233 ± 25%  interrupts.CPU62.PMI:Performance_monitoring_interrupts
    882.75 ±  8%     +32.9%       1173 ± 10%  interrupts.CPU62.RES:Rescheduling_interrupts
    476.25 ± 22%     +91.0%     909.50 ± 18%  interrupts.CPU62.TLB:TLB_shootdowns
      5386 ±  7%     -30.4%       3747 ±  8%  interrupts.CPU63.NMI:Non-maskable_interrupts
      5386 ±  7%     -30.4%       3747 ±  8%  interrupts.CPU63.PMI:Performance_monitoring_interrupts
    800.00 ±  8%     +39.3%       1114 ±  4%  interrupts.CPU63.RES:Rescheduling_interrupts
    406.75 ± 22%    +132.2%     944.50 ±  7%  interrupts.CPU63.TLB:TLB_shootdowns
    816.00 ±  8%     +44.3%       1177 ±  7%  interrupts.CPU64.RES:Rescheduling_interrupts
    468.75 ± 16%     +99.1%     933.25 ±  7%  interrupts.CPU64.TLB:TLB_shootdowns
    819.50 ±  6%     +44.9%       1187 ±  4%  interrupts.CPU65.RES:Rescheduling_interrupts
    481.00 ±  7%     +88.5%     906.75 ± 10%  interrupts.CPU65.TLB:TLB_shootdowns
      5347 ±  7%     -39.4%       3242 ± 22%  interrupts.CPU66.NMI:Non-maskable_interrupts
      5347 ±  7%     -39.4%       3242 ± 22%  interrupts.CPU66.PMI:Performance_monitoring_interrupts
    757.75 ±  3%     +43.8%       1089        interrupts.CPU66.RES:Rescheduling_interrupts
    410.50 ± 18%    +124.4%     921.25 ±  9%  interrupts.CPU66.TLB:TLB_shootdowns
      5325 ±  7%     -38.2%       3293 ± 24%  interrupts.CPU67.NMI:Non-maskable_interrupts
      5325 ±  7%     -38.2%       3293 ± 24%  interrupts.CPU67.PMI:Performance_monitoring_interrupts
    825.00 ±  6%     +40.4%       1158 ±  3%  interrupts.CPU67.RES:Rescheduling_interrupts
    389.75 ± 13%    +132.5%     906.25 ±  6%  interrupts.CPU67.TLB:TLB_shootdowns
      5338 ±  8%     -39.5%       3230 ± 22%  interrupts.CPU68.NMI:Non-maskable_interrupts
      5338 ±  8%     -39.5%       3230 ± 22%  interrupts.CPU68.PMI:Performance_monitoring_interrupts
    801.00 ±  4%     +46.8%       1175 ±  5%  interrupts.CPU68.RES:Rescheduling_interrupts
    468.00 ± 12%     +97.1%     922.50 ± 11%  interrupts.CPU68.TLB:TLB_shootdowns
      5350 ±  7%     -38.3%       3303 ± 26%  interrupts.CPU69.NMI:Non-maskable_interrupts
      5350 ±  7%     -38.3%       3303 ± 26%  interrupts.CPU69.PMI:Performance_monitoring_interrupts
    856.75 ±  4%     +35.1%       1157        interrupts.CPU69.RES:Rescheduling_interrupts
    476.50 ± 15%     +89.8%     904.50 ± 11%  interrupts.CPU69.TLB:TLB_shootdowns
      5392 ±  7%     -31.3%       3703 ±  7%  interrupts.CPU7.NMI:Non-maskable_interrupts
      5392 ±  7%     -31.3%       3703 ±  7%  interrupts.CPU7.PMI:Performance_monitoring_interrupts
    808.50 ±  5%     +35.4%       1095 ±  5%  interrupts.CPU7.RES:Rescheduling_interrupts
    414.50 ± 18%    +104.6%     848.00 ± 12%  interrupts.CPU7.TLB:TLB_shootdowns
    830.25 ±  3%     +36.2%       1130 ±  6%  interrupts.CPU70.RES:Rescheduling_interrupts
    451.50 ± 15%     +99.1%     899.00 ±  5%  interrupts.CPU70.TLB:TLB_shootdowns
      5295 ±  8%     -37.4%       3315 ± 30%  interrupts.CPU71.NMI:Non-maskable_interrupts
      5295 ±  8%     -37.4%       3315 ± 30%  interrupts.CPU71.PMI:Performance_monitoring_interrupts
    839.50 ±  6%     +34.3%       1127 ±  4%  interrupts.CPU71.RES:Rescheduling_interrupts
    446.00 ± 12%    +109.2%     933.25 ±  6%  interrupts.CPU71.TLB:TLB_shootdowns
      5315 ±  7%     -38.0%       3296 ± 30%  interrupts.CPU72.NMI:Non-maskable_interrupts
      5315 ±  7%     -38.0%       3296 ± 30%  interrupts.CPU72.PMI:Performance_monitoring_interrupts
    901.75 ±  6%     +24.8%       1125 ±  7%  interrupts.CPU72.RES:Rescheduling_interrupts
    629.50 ± 18%     +57.0%     988.25 ± 14%  interrupts.CPU72.TLB:TLB_shootdowns
    458.50 ± 24%    +107.4%     951.00 ± 16%  interrupts.CPU73.TLB:TLB_shootdowns
      5347 ±  7%     -37.9%       3323 ± 30%  interrupts.CPU74.NMI:Non-maskable_interrupts
      5347 ±  7%     -37.9%       3323 ± 30%  interrupts.CPU74.PMI:Performance_monitoring_interrupts
    878.75           +22.8%       1078 ±  6%  interrupts.CPU74.RES:Rescheduling_interrupts
    555.75 ±  6%     +85.1%       1028 ± 14%  interrupts.CPU74.TLB:TLB_shootdowns
      5348 ±  7%     -31.2%       3679 ±  8%  interrupts.CPU75.NMI:Non-maskable_interrupts
      5348 ±  7%     -31.2%       3679 ±  8%  interrupts.CPU75.PMI:Performance_monitoring_interrupts
    881.75 ±  5%     +21.9%       1074 ±  5%  interrupts.CPU75.RES:Rescheduling_interrupts
    510.50 ±  9%     +91.0%     975.00 ± 15%  interrupts.CPU75.TLB:TLB_shootdowns
      5384 ±  6%     -32.1%       3653 ±  7%  interrupts.CPU76.NMI:Non-maskable_interrupts
      5384 ±  6%     -32.1%       3653 ±  7%  interrupts.CPU76.PMI:Performance_monitoring_interrupts
    857.25 ±  6%     +26.6%       1085 ±  9%  interrupts.CPU76.RES:Rescheduling_interrupts
    445.75 ±  8%    +108.0%     927.25 ± 15%  interrupts.CPU76.TLB:TLB_shootdowns
      5353 ±  7%     -40.4%       3190 ± 24%  interrupts.CPU77.NMI:Non-maskable_interrupts
      5353 ±  7%     -40.4%       3190 ± 24%  interrupts.CPU77.PMI:Performance_monitoring_interrupts
    851.25 ±  9%     +27.2%       1083 ±  6%  interrupts.CPU77.RES:Rescheduling_interrupts
    474.50 ± 12%     +96.2%     930.75 ± 19%  interrupts.CPU77.TLB:TLB_shootdowns
      5339 ±  7%     -30.6%       3703 ±  8%  interrupts.CPU78.NMI:Non-maskable_interrupts
      5339 ±  7%     -30.6%       3703 ±  8%  interrupts.CPU78.PMI:Performance_monitoring_interrupts
    852.00 ±  2%     +21.9%       1038 ±  4%  interrupts.CPU78.RES:Rescheduling_interrupts
    512.50 ± 15%     +77.3%     908.50 ± 17%  interrupts.CPU78.TLB:TLB_shootdowns
      5359 ±  7%     -38.6%       3288 ± 28%  interrupts.CPU79.NMI:Non-maskable_interrupts
      5359 ±  7%     -38.6%       3288 ± 28%  interrupts.CPU79.PMI:Performance_monitoring_interrupts
    827.00           +33.0%       1099        interrupts.CPU79.RES:Rescheduling_interrupts
    482.50 ±  4%    +100.8%     969.00 ± 19%  interrupts.CPU79.TLB:TLB_shootdowns
    819.25 ±  2%     +32.6%       1086 ±  4%  interrupts.CPU8.RES:Rescheduling_interrupts
    450.50 ± 14%     +91.5%     862.75 ± 10%  interrupts.CPU8.TLB:TLB_shootdowns
      5343 ±  7%     -39.0%       3257 ± 29%  interrupts.CPU80.NMI:Non-maskable_interrupts
      5343 ±  7%     -39.0%       3257 ± 29%  interrupts.CPU80.PMI:Performance_monitoring_interrupts
    837.25 ±  2%     +25.6%       1051 ±  7%  interrupts.CPU80.RES:Rescheduling_interrupts
    464.00 ± 21%    +103.2%     942.75 ± 20%  interrupts.CPU80.TLB:TLB_shootdowns
      5301 ±  7%     -49.3%       2688 ± 30%  interrupts.CPU81.NMI:Non-maskable_interrupts
      5301 ±  7%     -49.3%       2688 ± 30%  interrupts.CPU81.PMI:Performance_monitoring_interrupts
    887.00 ±  7%     +21.9%       1081 ± 10%  interrupts.CPU81.RES:Rescheduling_interrupts
    439.75 ± 20%    +113.7%     939.75 ± 11%  interrupts.CPU81.TLB:TLB_shootdowns
      5363 ±  7%     -41.1%       3156 ± 22%  interrupts.CPU82.NMI:Non-maskable_interrupts
      5363 ±  7%     -41.1%       3156 ± 22%  interrupts.CPU82.PMI:Performance_monitoring_interrupts
    831.00 ±  6%     +30.4%       1083 ±  3%  interrupts.CPU82.RES:Rescheduling_interrupts
    467.50 ±  9%    +104.4%     955.50 ± 12%  interrupts.CPU82.TLB:TLB_shootdowns
    830.50 ±  5%     +34.5%       1116 ±  5%  interrupts.CPU83.RES:Rescheduling_interrupts
    453.00 ± 17%    +102.1%     915.50 ± 14%  interrupts.CPU83.TLB:TLB_shootdowns
    872.00 ±  2%     +25.1%       1091 ±  7%  interrupts.CPU84.RES:Rescheduling_interrupts
    460.25 ± 11%     +91.4%     880.75 ± 10%  interrupts.CPU84.TLB:TLB_shootdowns
    839.25 ±  4%     +26.7%       1063 ±  6%  interrupts.CPU85.RES:Rescheduling_interrupts
    438.75 ±  9%    +105.1%     900.00 ± 15%  interrupts.CPU85.TLB:TLB_shootdowns
      5322 ±  7%     -40.7%       3154 ± 23%  interrupts.CPU86.NMI:Non-maskable_interrupts
      5322 ±  7%     -40.7%       3154 ± 23%  interrupts.CPU86.PMI:Performance_monitoring_interrupts
    888.50 ±  6%     +20.6%       1071 ±  6%  interrupts.CPU86.RES:Rescheduling_interrupts
    457.25 ± 14%    +105.9%     941.50 ± 16%  interrupts.CPU86.TLB:TLB_shootdowns
      5360 ±  8%     -31.5%       3672 ±  7%  interrupts.CPU87.NMI:Non-maskable_interrupts
      5360 ±  8%     -31.5%       3672 ±  7%  interrupts.CPU87.PMI:Performance_monitoring_interrupts
    843.75 ±  5%     +34.2%       1132 ±  5%  interrupts.CPU87.RES:Rescheduling_interrupts
    472.50 ± 10%    +104.1%     964.25 ± 21%  interrupts.CPU87.TLB:TLB_shootdowns
    859.75 ±  3%     +25.8%       1081 ±  4%  interrupts.CPU88.RES:Rescheduling_interrupts
    478.00 ± 14%     +95.2%     933.00 ± 15%  interrupts.CPU88.TLB:TLB_shootdowns
    849.25 ±  5%     +27.7%       1084 ±  3%  interrupts.CPU89.RES:Rescheduling_interrupts
    498.00 ± 18%     +82.4%     908.25 ± 11%  interrupts.CPU89.TLB:TLB_shootdowns
    845.50 ± 10%     +26.0%       1065 ±  2%  interrupts.CPU9.RES:Rescheduling_interrupts
    409.00 ± 13%    +119.8%     899.00 ± 11%  interrupts.CPU9.TLB:TLB_shootdowns
    824.00 ±  3%     +33.5%       1099 ±  9%  interrupts.CPU90.RES:Rescheduling_interrupts
    496.00 ± 23%     +99.4%     989.00 ± 16%  interrupts.CPU90.TLB:TLB_shootdowns
    847.25 ±  2%     +31.6%       1114 ±  3%  interrupts.CPU91.RES:Rescheduling_interrupts
    462.25 ± 17%     +91.3%     884.25 ± 11%  interrupts.CPU91.TLB:TLB_shootdowns
    848.50           +28.8%       1093 ±  3%  interrupts.CPU92.RES:Rescheduling_interrupts
    489.50 ±  9%     +86.0%     910.25 ± 12%  interrupts.CPU92.TLB:TLB_shootdowns
    819.25 ±  5%     +30.8%       1071 ±  4%  interrupts.CPU93.RES:Rescheduling_interrupts
    457.00 ±  7%    +102.7%     926.50 ± 13%  interrupts.CPU93.TLB:TLB_shootdowns
      5370 ±  7%     -31.3%       3691 ±  8%  interrupts.CPU94.NMI:Non-maskable_interrupts
      5370 ±  7%     -31.3%       3691 ±  8%  interrupts.CPU94.PMI:Performance_monitoring_interrupts
    833.50 ±  4%     +27.9%       1066 ±  6%  interrupts.CPU94.RES:Rescheduling_interrupts
    466.00 ± 15%    +113.0%     992.50 ±  3%  interrupts.CPU94.TLB:TLB_shootdowns
      5369 ±  7%     -39.2%       3262 ± 25%  interrupts.CPU95.NMI:Non-maskable_interrupts
      5369 ±  7%     -39.2%       3262 ± 25%  interrupts.CPU95.PMI:Performance_monitoring_interrupts
    805.75 ±  7%     +33.4%       1075 ±  2%  interrupts.CPU95.RES:Rescheduling_interrupts
    461.00 ± 24%     +85.5%     855.00 ± 14%  interrupts.CPU95.TLB:TLB_shootdowns
    908.75 ±  5%     +26.1%       1145 ±  4%  interrupts.CPU96.RES:Rescheduling_interrupts
    430.50 ± 10%     +96.6%     846.50 ±  7%  interrupts.CPU96.TLB:TLB_shootdowns
    945.75 ±  5%     +23.3%       1166 ±  5%  interrupts.CPU97.RES:Rescheduling_interrupts
    431.25 ±  9%    +103.8%     879.00 ±  2%  interrupts.CPU97.TLB:TLB_shootdowns
    838.50           +39.2%       1167 ±  2%  interrupts.CPU98.RES:Rescheduling_interrupts
    460.00 ± 26%     +70.9%     786.00 ±  7%  interrupts.CPU98.TLB:TLB_shootdowns
    832.50 ±  7%     +36.9%       1139 ±  5%  interrupts.CPU99.RES:Rescheduling_interrupts
    429.50 ± 12%    +113.8%     918.25 ±  8%  interrupts.CPU99.TLB:TLB_shootdowns
    959224 ±  5%     -32.3%     649233 ±  7%  interrupts.NMI:Non-maskable_interrupts
    959224 ±  5%     -32.3%     649233 ±  7%  interrupts.PMI:Performance_monitoring_interrupts
    154671           +39.6%     215993        interrupts.RES:Rescheduling_interrupts
     87724 ± 13%     +95.7%     171705 ±  9%  interrupts.TLB:TLB_shootdowns



***************************************************************************************************
lkp-csl-2sp4: 96 threads Intel(R) Xeon(R) CPU @ 2.30GHz with 128G memory


***************************************************************************************************
lkp-csl-2ap2: 192 threads Intel(R) Xeon(R) Platinum 9242 CPU @ 2.30GHz with 192G memory
=========================================================================================
compiler/cpufreq_governor/disk/filesize/fs/iterations/kconfig/nr_threads/rootfs/sync_method/tbox_group/test_size/testcase/ucode:
  gcc-9/performance/1BRD_48G/4M/f2fs/1x/x86_64-rhel-8.3/64t/debian-10.4-x86_64-20200603.cgz/NoSync/lkp-csl-2ap2/40G/fsmark/0x5003003

commit: 
  268df4df6c ("locking/qspinlock: Refactor the qspinlock slow path")
  0dd6d5b8c0 ("locking/qspinlock: Introduce CNA into the slow path of qspinlock")

268df4df6cb0a27d 0dd6d5b8c0f6f31d8d557485fff 
---------------- --------------------------- 
       fail:runs  %reproduction    fail:runs
           |             |             |    
           :4           10%           0:4     perf-profile.children.cycles-pp.error_entry
           :4            8%           0:4     perf-profile.self.cycles-pp.error_entry
         %stddev     %change         %stddev
             \          |                \  
    711.38 ±  3%    +194.3%       2093        fsmark.files_per_sec
     40.96            -8.6%      37.43        fsmark.time.elapsed_time
     40.96            -8.6%      37.43        fsmark.time.elapsed_time.max
      1514           -69.3%     464.75 ±  6%  fsmark.time.involuntary_context_switches
      1383 ±  2%     -43.5%     781.00 ±  2%  fsmark.time.percent_of_cpu_this_job_got
    566.34 ±  3%     -48.5%     291.88        fsmark.time.system_time
     36823           -40.0%      22111 ± 41%  fsmark.time.voluntary_context_switches
      4675 ±  5%     +12.7%       5267 ±  5%  boot-time.idle
     23637 ±  2%     -24.3%      17882 ±  4%  softirqs.TIMER
      4.18 ±  3%      -3.0        1.18 ± 11%  mpstat.cpu.all.iowait%
      7.26 ±  2%      -3.2        4.10 ±  9%  mpstat.cpu.all.sys%
     87.04            +7.2%      93.28        iostat.cpu.idle
      4.00 ±  3%     -71.9%       1.12 ± 11%  iostat.cpu.iowait
      8.50 ±  3%     -39.6%       5.14 ±  6%  iostat.cpu.system
    124129 ±  3%     -41.2%      73006 ±  8%  meminfo.Active
     57632 ±  9%     -86.7%       7639 ± 10%  meminfo.Active(anon)
     47357 ±  4%     -30.2%      33034 ±  2%  meminfo.Mapped
     80477 ±  7%     -75.9%      19390 ±  4%  meminfo.Shmem
   3976835 ± 89%     -92.8%     285124 ± 88%  numa-numastat.node2.local_node
   4003203 ± 89%     -92.1%     316120 ± 80%  numa-numastat.node2.numa_hit
   1213435 ± 32%     +79.5%    2178226 ± 12%  numa-numastat.node2.numa_miss
   1239805 ± 31%     +78.2%    2209222 ± 11%  numa-numastat.node2.other_node
     86.50            +7.8%      93.25        vmstat.cpu.id
      7.75 ±  5%     -77.4%       1.75 ± 24%  vmstat.procs.b
      4985           -17.5%       4113 ± 17%  vmstat.system.cs
    397234            -5.3%     376265        vmstat.system.in
      4099 ±  2%     -25.1%       3069 ± 10%  slabinfo.f2fs_xattr_entry-1:0.active_objs
      4099 ±  2%     -25.1%       3069 ± 10%  slabinfo.f2fs_xattr_entry-1:0.num_objs
      8556 ±  3%     -17.2%       7083 ±  6%  slabinfo.kmalloc-rcl-512.active_objs
      8560 ±  3%     -17.2%       7087 ±  6%  slabinfo.kmalloc-rcl-512.num_objs
      7470 ±  3%     +12.7%       8419 ±  4%  slabinfo.shmem_inode_cache.active_objs
      7470 ±  3%     +12.7%       8419 ±  4%  slabinfo.shmem_inode_cache.num_objs
      5763 ±  6%     +11.1%       6404 ±  6%  slabinfo.signal_cache.active_objs
     14373 ±  9%     -86.7%       1904 ± 10%  proc-vmstat.nr_active_anon
  35993775            -1.5%   35450212        proc-vmstat.nr_free_pages
     11887 ±  3%     -29.4%       8396 ±  2%  proc-vmstat.nr_mapped
     20107 ±  8%     -75.9%       4843 ±  4%  proc-vmstat.nr_shmem
     14373 ±  9%     -86.7%       1904 ± 10%  proc-vmstat.nr_zone_active_anon
   3855744 ± 11%     +99.4%    7687054 ± 12%  proc-vmstat.numa_foreign
  17648884 ±  2%     -21.9%   13775490 ±  6%  proc-vmstat.numa_hit
  17555859 ±  2%     -22.1%   13682470 ±  6%  proc-vmstat.numa_local
   3855744 ± 11%     +99.4%    7687054 ± 12%  proc-vmstat.numa_miss
   3948768 ± 10%     +97.0%    7780074 ± 11%  proc-vmstat.numa_other
     22947 ±  6%     -70.2%       6832 ±  5%  proc-vmstat.pgactivate
     56080 ±  7%     -11.4%      49696 ± 13%  sched_debug.cfs_rq:/.min_vruntime.max
     64.65 ±  7%     -24.2%      49.03 ± 25%  sched_debug.cfs_rq:/.util_est_enqueued.stddev
      2206 ± 26%    +413.2%      11323 ± 91%  sched_debug.cpu.avg_idle.min
     34843 ±  3%      +4.5%      36396 ±  4%  sched_debug.cpu.clock.avg
     34863 ±  3%      +4.5%      36421 ±  4%  sched_debug.cpu.clock.max
     34824 ±  3%      +4.5%      36376 ±  4%  sched_debug.cpu.clock.min
     34720 ±  3%      +4.5%      36278 ±  4%  sched_debug.cpu.clock_task.avg
     34837 ±  3%      +4.5%      36397 ±  4%  sched_debug.cpu.clock_task.max
     34824 ±  3%      +4.5%      36379 ±  4%  sched_debug.cpu_clk
     33949 ±  3%      +4.6%      35503 ±  4%  sched_debug.ktime
     35198 ±  3%      +4.5%      36776 ±  4%  sched_debug.sched_clk
     16739 ± 56%     -48.0%       8697 ± 19%  numa-meminfo.node0.Active
  40457383 ±  2%     -25.2%   30262018 ± 16%  numa-meminfo.node0.MemFree
   8699492 ± 11%    +117.2%   18894856 ± 26%  numa-meminfo.node0.MemUsed
   4881680 ± 10%     -39.5%    2951962 ±  6%  numa-meminfo.node1.Dirty
     12557 ± 16%     -33.9%       8295 ± 29%  numa-meminfo.node1.Mapped
     11865 ±  7%     -61.1%       4617 ± 35%  numa-meminfo.node2.Active
     10888 ±  7%     -59.6%       4403 ± 35%  numa-meminfo.node2.Active(file)
     48642 ± 32%     -39.3%      29529 ± 14%  numa-meminfo.node2.KReclaimable
     10335 ± 23%     -35.2%       6697 ±  3%  numa-meminfo.node2.Mapped
  13119136 ± 37%     -37.7%    8179596 ±  7%  numa-meminfo.node2.MemUsed
     48642 ± 32%     -39.3%      29529 ± 14%  numa-meminfo.node2.SReclaimable
     71510 ± 15%     -51.8%      34463 ± 73%  numa-meminfo.node3.Active
     54911 ± 11%     -89.2%       5947 ± 19%  numa-meminfo.node3.Active(anon)
   4019059 ± 16%     -20.9%    3178355 ± 16%  numa-meminfo.node3.Dirty
     14001 ± 34%     -39.2%       8512 ± 32%  numa-meminfo.node3.Mapped
     60361 ±  7%     +20.5%      72735 ± 12%  numa-meminfo.node3.SUnreclaim
     70630 ±  6%     -87.6%       8750 ± 51%  numa-meminfo.node3.Shmem
  10107449 ±  2%     -25.2%    7561166 ± 16%  numa-vmstat.node0.nr_free_pages
    735366 ± 70%    +145.0%    1801824 ± 29%  numa-vmstat.node0.numa_miss
    798165 ± 66%    +136.3%    1885703 ± 28%  numa-vmstat.node0.numa_other
   1222590 ± 10%     -39.9%     734995 ±  6%  numa-vmstat.node1.nr_dirty
      3118 ± 17%     -32.5%       2106 ± 27%  numa-vmstat.node1.nr_mapped
   1258007 ± 13%     +42.3%    1789722 ± 21%  numa-vmstat.node1.nr_written
   1222977 ± 10%     -39.9%     735212 ±  6%  numa-vmstat.node1.nr_zone_write_pending
      2732 ±  8%     -59.9%       1097 ± 35%  numa-vmstat.node2.nr_active_file
      2595 ± 23%     -34.2%       1709 ±  2%  numa-vmstat.node2.nr_mapped
     12103 ± 32%     -39.1%       7373 ± 14%  numa-vmstat.node2.nr_slab_reclaimable
      2732 ±  8%     -59.9%       1097 ± 35%  numa-vmstat.node2.nr_zone_active_file
   2736222 ± 52%     -73.4%     728954 ± 22%  numa-vmstat.node2.numa_hit
   2657615 ± 52%     -76.8%     616103 ± 26%  numa-vmstat.node2.numa_local
    999734 ± 36%     +90.5%    1904830 ± 17%  numa-vmstat.node2.numa_miss
   1078346 ± 30%     +87.1%    2017683 ± 16%  numa-vmstat.node2.numa_other
     13788 ± 10%     -89.2%       1486 ± 19%  numa-vmstat.node3.nr_active_anon
   1005175 ± 16%     -21.3%     791409 ± 16%  numa-vmstat.node3.nr_dirty
      3372 ± 29%     -35.5%       2173 ± 34%  numa-vmstat.node3.nr_mapped
     17642 ±  6%     -87.6%       2187 ± 51%  numa-vmstat.node3.nr_shmem
     15088 ±  7%     +20.5%      18183 ± 12%  numa-vmstat.node3.nr_slab_unreclaimable
   1175804 ± 18%     +47.8%    1738123 ± 15%  numa-vmstat.node3.nr_written
     13788 ± 10%     -89.2%       1486 ± 19%  numa-vmstat.node3.nr_zone_active_anon
   1005539 ± 16%     -21.3%     791647 ± 16%  numa-vmstat.node3.nr_zone_write_pending
    736833 ±121%    +274.4%    2758882 ± 76%  numa-vmstat.node3.numa_foreign
  41641015 ±  3%     -20.2%   33224660 ±  7%  perf-stat.i.cache-misses
      4722 ±  3%     -24.7%       3558 ± 12%  perf-stat.i.context-switches
      2.97 ±  3%     -37.0%       1.88        perf-stat.i.cpi
    192095            +6.9%     205259        perf-stat.i.cpu-clock
 5.281e+10           -30.0%  3.696e+10 ±  8%  perf-stat.i.cpu-cycles
   1076937 ± 87%     -75.9%     259884 ± 27%  perf-stat.i.dTLB-load-misses
      0.02 ± 89%      -0.0        0.00 ± 11%  perf-stat.i.dTLB-store-miss-rate%
    148305 ± 82%     -74.3%      38153 ± 15%  perf-stat.i.dTLB-store-misses
     53.45 ±  2%      -2.6       50.85        perf-stat.i.iTLB-load-miss-rate%
      0.51 ±  7%     +18.3%       0.60        perf-stat.i.ipc
      0.27           -59.2%       0.11 ±  7%  perf-stat.i.metric.GHz
     34.21           -19.6%      27.50 ±  5%  perf-stat.i.metric.M/sec
     80.74 ±  3%     -12.0       68.76 ±  6%  perf-stat.i.node-load-miss-rate%
  12208619 ±  3%     -18.2%    9991889 ± 14%  perf-stat.i.node-load-misses
   3052592 ± 15%     +59.1%    4855826 ± 16%  perf-stat.i.node-loads
   3919002 ±  3%     -22.8%    3024416 ± 12%  perf-stat.i.node-store-misses
    192095            +6.9%     205259        perf-stat.i.task-clock
      4.49           -29.0%       3.19 ±  2%  perf-stat.overall.cpi
      1309 ±  2%     -14.1%       1125        perf-stat.overall.cycles-between-cache-misses
      0.01 ± 81%      -0.0        0.00 ± 13%  perf-stat.overall.dTLB-store-miss-rate%
      0.22           +40.9%       0.31 ±  2%  perf-stat.overall.ipc
     80.27 ±  4%     -12.8       67.52 ±  7%  perf-stat.overall.node-load-miss-rate%
     67.66 ±  2%      -5.3       62.34 ±  9%  perf-stat.overall.node-store-miss-rate%
 2.558e+09           -11.6%  2.261e+09 ±  4%  perf-stat.ps.branch-instructions
  41183741 ±  3%     -24.8%   30949691 ±  6%  perf-stat.ps.cache-misses
      4788 ±  2%     -18.4%       3905 ± 18%  perf-stat.ps.context-switches
 5.389e+10           -35.4%  3.482e+10 ±  7%  perf-stat.ps.cpu-cycles
    225.37            -4.8%     214.45        perf-stat.ps.cpu-migrations
   1034104 ± 84%     -76.5%     242642 ± 26%  perf-stat.ps.dTLB-load-misses
 2.933e+09 ±  2%     -11.5%  2.596e+09 ±  5%  perf-stat.ps.dTLB-loads
    141679 ± 81%     -74.4%      36216 ± 15%  perf-stat.ps.dTLB-store-misses
 1.201e+10            -9.1%  1.091e+10 ±  4%  perf-stat.ps.instructions
      6749            -6.0%       6342 ±  3%  perf-stat.ps.minor-faults
  11936768 ±  3%     -23.4%    9139100 ± 13%  perf-stat.ps.node-load-misses
   2936501 ± 17%     +48.7%    4365349 ± 15%  perf-stat.ps.node-loads
   4049851 ±  4%     -25.6%    3014800 ± 11%  perf-stat.ps.node-store-misses
      6754            -6.0%       6347 ±  3%  perf-stat.ps.page-faults
 5.082e+11           -12.4%  4.451e+11 ±  5%  perf-stat.total.instructions
      3169 ± 43%     -93.5%     205.75 ± 61%  interrupts.CPU0.NMI:Non-maskable_interrupts
      3169 ± 43%     -93.5%     205.75 ± 61%  interrupts.CPU0.PMI:Performance_monitoring_interrupts
      4795 ± 22%     -95.3%     224.50 ± 67%  interrupts.CPU1.NMI:Non-maskable_interrupts
      4795 ± 22%     -95.3%     224.50 ± 67%  interrupts.CPU1.PMI:Performance_monitoring_interrupts
      3327 ± 76%     -77.8%     740.25 ±141%  interrupts.CPU100.NMI:Non-maskable_interrupts
      3327 ± 76%     -77.8%     740.25 ±141%  interrupts.CPU100.PMI:Performance_monitoring_interrupts
      3590 ± 63%     -97.0%     107.25 ± 29%  interrupts.CPU101.NMI:Non-maskable_interrupts
      3590 ± 63%     -97.0%     107.25 ± 29%  interrupts.CPU101.PMI:Performance_monitoring_interrupts
      3117 ± 58%     -97.3%      83.00 ± 34%  interrupts.CPU103.NMI:Non-maskable_interrupts
      3117 ± 58%     -97.3%      83.00 ± 34%  interrupts.CPU103.PMI:Performance_monitoring_interrupts
      2581 ± 93%     -90.0%     258.50 ±107%  interrupts.CPU104.NMI:Non-maskable_interrupts
      2581 ± 93%     -90.0%     258.50 ±107%  interrupts.CPU104.PMI:Performance_monitoring_interrupts
      2415 ± 97%     -94.9%     124.00 ± 19%  interrupts.CPU109.NMI:Non-maskable_interrupts
      2415 ± 97%     -94.9%     124.00 ± 19%  interrupts.CPU109.PMI:Performance_monitoring_interrupts
      1979 ±114%     -92.3%     152.75 ± 63%  interrupts.CPU112.NMI:Non-maskable_interrupts
      1979 ±114%     -92.3%     152.75 ± 63%  interrupts.CPU112.PMI:Performance_monitoring_interrupts
      2530 ±102%     -91.5%     215.00 ±109%  interrupts.CPU113.NMI:Non-maskable_interrupts
      2530 ±102%     -91.5%     215.00 ±109%  interrupts.CPU113.PMI:Performance_monitoring_interrupts
      2787 ± 81%     -95.0%     139.25 ± 51%  interrupts.CPU118.NMI:Non-maskable_interrupts
      2787 ± 81%     -95.0%     139.25 ± 51%  interrupts.CPU118.PMI:Performance_monitoring_interrupts
      3920 ± 16%     -96.2%     147.75 ± 25%  interrupts.CPU120.NMI:Non-maskable_interrupts
      3920 ± 16%     -96.2%     147.75 ± 25%  interrupts.CPU120.PMI:Performance_monitoring_interrupts
      3776 ± 33%     -96.5%     130.75 ± 20%  interrupts.CPU121.NMI:Non-maskable_interrupts
      3776 ± 33%     -96.5%     130.75 ± 20%  interrupts.CPU121.PMI:Performance_monitoring_interrupts
      3387 ± 12%     -96.7%     111.50 ± 25%  interrupts.CPU122.NMI:Non-maskable_interrupts
      3387 ± 12%     -96.7%     111.50 ± 25%  interrupts.CPU122.PMI:Performance_monitoring_interrupts
      3735 ± 25%     -91.2%     327.00 ±104%  interrupts.CPU123.NMI:Non-maskable_interrupts
      3735 ± 25%     -91.2%     327.00 ±104%  interrupts.CPU123.PMI:Performance_monitoring_interrupts
      3017 ± 60%     -88.7%     340.50 ±111%  interrupts.CPU124.NMI:Non-maskable_interrupts
      3017 ± 60%     -88.7%     340.50 ±111%  interrupts.CPU124.PMI:Performance_monitoring_interrupts
      2364 ± 66%     -88.4%     273.75 ± 92%  interrupts.CPU125.NMI:Non-maskable_interrupts
      2364 ± 66%     -88.4%     273.75 ± 92%  interrupts.CPU125.PMI:Performance_monitoring_interrupts
      3254 ± 67%     -86.7%     434.25 ±109%  interrupts.CPU126.NMI:Non-maskable_interrupts
      3254 ± 67%     -86.7%     434.25 ±109%  interrupts.CPU126.PMI:Performance_monitoring_interrupts
      4094 ± 56%     -97.0%     122.25 ± 14%  interrupts.CPU127.NMI:Non-maskable_interrupts
      4094 ± 56%     -97.0%     122.25 ± 14%  interrupts.CPU127.PMI:Performance_monitoring_interrupts
      4315 ± 45%     -83.4%     714.25 ± 95%  interrupts.CPU129.NMI:Non-maskable_interrupts
      4315 ± 45%     -83.4%     714.25 ± 95%  interrupts.CPU129.PMI:Performance_monitoring_interrupts
      3775 ± 62%     -96.8%     121.50 ± 14%  interrupts.CPU132.NMI:Non-maskable_interrupts
      3775 ± 62%     -96.8%     121.50 ± 14%  interrupts.CPU132.PMI:Performance_monitoring_interrupts
      1751 ± 19%     -44.8%     965.75 ± 36%  interrupts.CPU136.CAL:Function_call_interrupts
      3028 ± 54%     -93.7%     191.75 ± 51%  interrupts.CPU137.NMI:Non-maskable_interrupts
      3028 ± 54%     -93.7%     191.75 ± 51%  interrupts.CPU137.PMI:Performance_monitoring_interrupts
      4831 ± 32%     -95.2%     231.75 ± 73%  interrupts.CPU138.NMI:Non-maskable_interrupts
      4831 ± 32%     -95.2%     231.75 ± 73%  interrupts.CPU138.PMI:Performance_monitoring_interrupts
      1661 ± 11%     -41.9%     964.50 ± 36%  interrupts.CPU139.CAL:Function_call_interrupts
     28.75 ±153%     -96.5%       1.00 ±173%  interrupts.CPU14.RES:Rescheduling_interrupts
      3352 ± 39%     -90.7%     312.50 ± 79%  interrupts.CPU140.NMI:Non-maskable_interrupts
      3352 ± 39%     -90.7%     312.50 ± 79%  interrupts.CPU140.PMI:Performance_monitoring_interrupts
      4100 ± 45%     -89.4%     433.25 ± 73%  interrupts.CPU143.NMI:Non-maskable_interrupts
      4100 ± 45%     -89.4%     433.25 ± 73%  interrupts.CPU143.PMI:Performance_monitoring_interrupts
      3510 ± 53%     -95.7%     149.50 ± 64%  interrupts.CPU144.NMI:Non-maskable_interrupts
      3510 ± 53%     -95.7%     149.50 ± 64%  interrupts.CPU144.PMI:Performance_monitoring_interrupts
      2435 ± 27%     -93.7%     153.75 ± 66%  interrupts.CPU145.NMI:Non-maskable_interrupts
      2435 ± 27%     -93.7%     153.75 ± 66%  interrupts.CPU145.PMI:Performance_monitoring_interrupts
      3286 ± 26%     -86.7%     437.50 ±134%  interrupts.CPU146.NMI:Non-maskable_interrupts
      3286 ± 26%     -86.7%     437.50 ±134%  interrupts.CPU146.PMI:Performance_monitoring_interrupts
      2230 ± 54%     -66.6%     745.75 ±150%  interrupts.CPU147.NMI:Non-maskable_interrupts
      2230 ± 54%     -66.6%     745.75 ±150%  interrupts.CPU147.PMI:Performance_monitoring_interrupts
      2527 ± 58%     -94.2%     147.50 ± 77%  interrupts.CPU150.NMI:Non-maskable_interrupts
      2527 ± 58%     -94.2%     147.50 ± 77%  interrupts.CPU150.PMI:Performance_monitoring_interrupts
      2569 ± 73%     -95.4%     118.25 ± 15%  interrupts.CPU151.NMI:Non-maskable_interrupts
      2569 ± 73%     -95.4%     118.25 ± 15%  interrupts.CPU151.PMI:Performance_monitoring_interrupts
      2333 ± 81%     -95.3%     109.25 ± 18%  interrupts.CPU152.NMI:Non-maskable_interrupts
      2333 ± 81%     -95.3%     109.25 ± 18%  interrupts.CPU152.PMI:Performance_monitoring_interrupts
      1130 ± 99%     -90.3%     110.00 ± 18%  interrupts.CPU157.NMI:Non-maskable_interrupts
      1130 ± 99%     -90.3%     110.00 ± 18%  interrupts.CPU157.PMI:Performance_monitoring_interrupts
      2397 ±105%     -93.8%     147.50 ± 32%  interrupts.CPU16.NMI:Non-maskable_interrupts
      2397 ±105%     -93.8%     147.50 ± 32%  interrupts.CPU16.PMI:Performance_monitoring_interrupts
      2528 ± 80%     -95.7%     107.75 ± 16%  interrupts.CPU162.NMI:Non-maskable_interrupts
      2528 ± 80%     -95.7%     107.75 ± 16%  interrupts.CPU162.PMI:Performance_monitoring_interrupts
      2242 ± 92%     -90.0%     225.00 ± 96%  interrupts.CPU163.NMI:Non-maskable_interrupts
      2242 ± 92%     -90.0%     225.00 ± 96%  interrupts.CPU163.PMI:Performance_monitoring_interrupts
      2881 ± 58%     -94.0%     174.00 ± 63%  interrupts.CPU166.NMI:Non-maskable_interrupts
      2881 ± 58%     -94.0%     174.00 ± 63%  interrupts.CPU166.PMI:Performance_monitoring_interrupts
      2808 ± 58%     -80.1%     558.50 ± 13%  interrupts.CPU167.NMI:Non-maskable_interrupts
      2808 ± 58%     -80.1%     558.50 ± 13%  interrupts.CPU167.PMI:Performance_monitoring_interrupts
      4062 ± 32%     -93.3%     272.00 ± 25%  interrupts.CPU168.NMI:Non-maskable_interrupts
      4062 ± 32%     -93.3%     272.00 ± 25%  interrupts.CPU168.PMI:Performance_monitoring_interrupts
      4292 ± 38%     -92.1%     340.00 ± 76%  interrupts.CPU169.NMI:Non-maskable_interrupts
      4292 ± 38%     -92.1%     340.00 ± 76%  interrupts.CPU169.PMI:Performance_monitoring_interrupts
      3120 ± 29%     -95.6%     137.75 ± 18%  interrupts.CPU170.NMI:Non-maskable_interrupts
      3120 ± 29%     -95.6%     137.75 ± 18%  interrupts.CPU170.PMI:Performance_monitoring_interrupts
      3118 ± 36%     -95.6%     136.50 ± 15%  interrupts.CPU171.NMI:Non-maskable_interrupts
      3118 ± 36%     -95.6%     136.50 ± 15%  interrupts.CPU171.PMI:Performance_monitoring_interrupts
      3939 ± 28%     -95.1%     192.75 ± 42%  interrupts.CPU172.NMI:Non-maskable_interrupts
      3939 ± 28%     -95.1%     192.75 ± 42%  interrupts.CPU172.PMI:Performance_monitoring_interrupts
      3045 ± 48%     -95.7%     131.00 ± 16%  interrupts.CPU173.NMI:Non-maskable_interrupts
      3045 ± 48%     -95.7%     131.00 ± 16%  interrupts.CPU173.PMI:Performance_monitoring_interrupts
      3485 ± 70%     -96.2%     132.50 ± 43%  interrupts.CPU174.NMI:Non-maskable_interrupts
      3485 ± 70%     -96.2%     132.50 ± 43%  interrupts.CPU174.PMI:Performance_monitoring_interrupts
      2614 ± 71%     -94.6%     140.00 ± 45%  interrupts.CPU177.NMI:Non-maskable_interrupts
      2614 ± 71%     -94.6%     140.00 ± 45%  interrupts.CPU177.PMI:Performance_monitoring_interrupts
      3606 ± 63%     -95.4%     165.25 ± 53%  interrupts.CPU178.NMI:Non-maskable_interrupts
      3606 ± 63%     -95.4%     165.25 ± 53%  interrupts.CPU178.PMI:Performance_monitoring_interrupts
      2254 ± 88%     -94.9%     115.00 ± 33%  interrupts.CPU180.NMI:Non-maskable_interrupts
      2254 ± 88%     -94.9%     115.00 ± 33%  interrupts.CPU180.PMI:Performance_monitoring_interrupts
      2190 ± 97%     -81.7%     402.00 ±130%  interrupts.CPU181.NMI:Non-maskable_interrupts
      2190 ± 97%     -81.7%     402.00 ±130%  interrupts.CPU181.PMI:Performance_monitoring_interrupts
      3095 ± 61%     -96.2%     116.25 ± 29%  interrupts.CPU185.NMI:Non-maskable_interrupts
      3095 ± 61%     -96.2%     116.25 ± 29%  interrupts.CPU185.PMI:Performance_monitoring_interrupts
      3923 ± 48%     -97.0%     117.50 ± 29%  interrupts.CPU189.NMI:Non-maskable_interrupts
      3923 ± 48%     -97.0%     117.50 ± 29%  interrupts.CPU189.PMI:Performance_monitoring_interrupts
      2365 ± 63%     -94.2%     137.75 ± 23%  interrupts.CPU191.NMI:Non-maskable_interrupts
      2365 ± 63%     -94.2%     137.75 ± 23%  interrupts.CPU191.PMI:Performance_monitoring_interrupts
      3085 ± 31%     -94.4%     171.50 ± 84%  interrupts.CPU2.NMI:Non-maskable_interrupts
      3085 ± 31%     -94.4%     171.50 ± 84%  interrupts.CPU2.PMI:Performance_monitoring_interrupts
      1919 ±109%     -94.8%     100.50 ± 29%  interrupts.CPU21.NMI:Non-maskable_interrupts
      1919 ±109%     -94.8%     100.50 ± 29%  interrupts.CPU21.PMI:Performance_monitoring_interrupts
      3598 ± 62%     -94.8%     186.25 ± 59%  interrupts.CPU22.NMI:Non-maskable_interrupts
      3598 ± 62%     -94.8%     186.25 ± 59%  interrupts.CPU22.PMI:Performance_monitoring_interrupts
      3975 ± 27%     -96.1%     154.50 ± 57%  interrupts.CPU24.NMI:Non-maskable_interrupts
      3975 ± 27%     -96.1%     154.50 ± 57%  interrupts.CPU24.PMI:Performance_monitoring_interrupts
      1727 ± 15%     -44.1%     965.25 ± 36%  interrupts.CPU25.CAL:Function_call_interrupts
      3416 ± 28%     -96.7%     111.75 ± 32%  interrupts.CPU25.NMI:Non-maskable_interrupts
      3416 ± 28%     -96.7%     111.75 ± 32%  interrupts.CPU25.PMI:Performance_monitoring_interrupts
      5405 ± 30%     -97.5%     133.25 ± 13%  interrupts.CPU26.NMI:Non-maskable_interrupts
      5405 ± 30%     -97.5%     133.25 ± 13%  interrupts.CPU26.PMI:Performance_monitoring_interrupts
      1471 ± 11%     -34.5%     963.75 ± 36%  interrupts.CPU27.CAL:Function_call_interrupts
      4128 ±  3%     -95.1%     203.75 ± 64%  interrupts.CPU27.NMI:Non-maskable_interrupts
      4128 ±  3%     -95.1%     203.75 ± 64%  interrupts.CPU27.PMI:Performance_monitoring_interrupts
      3114 ± 36%     -74.9%     780.75 ±151%  interrupts.CPU28.NMI:Non-maskable_interrupts
      3114 ± 36%     -74.9%     780.75 ±151%  interrupts.CPU28.PMI:Performance_monitoring_interrupts
      3041 ± 53%     -90.3%     294.25 ± 64%  interrupts.CPU29.NMI:Non-maskable_interrupts
      3041 ± 53%     -90.3%     294.25 ± 64%  interrupts.CPU29.PMI:Performance_monitoring_interrupts
      1624 ±  4%     -40.5%     966.25 ± 36%  interrupts.CPU30.CAL:Function_call_interrupts
      2771 ± 61%     -77.7%     617.75 ±110%  interrupts.CPU30.NMI:Non-maskable_interrupts
      2771 ± 61%     -77.7%     617.75 ±110%  interrupts.CPU30.PMI:Performance_monitoring_interrupts
      2916 ± 65%     -95.7%     126.00 ± 14%  interrupts.CPU31.NMI:Non-maskable_interrupts
      2916 ± 65%     -95.7%     126.00 ± 14%  interrupts.CPU31.PMI:Performance_monitoring_interrupts
      3378 ± 59%     -96.7%     110.00 ± 31%  interrupts.CPU35.NMI:Non-maskable_interrupts
      3378 ± 59%     -96.7%     110.00 ± 31%  interrupts.CPU35.PMI:Performance_monitoring_interrupts
      3735 ± 56%     -96.7%     123.75 ± 13%  interrupts.CPU36.NMI:Non-maskable_interrupts
      3735 ± 56%     -96.7%     123.75 ± 13%  interrupts.CPU36.PMI:Performance_monitoring_interrupts
      1507 ±  5%     -36.0%     965.00 ± 36%  interrupts.CPU39.CAL:Function_call_interrupts
      3942 ± 44%     -71.7%       1117 ±154%  interrupts.CPU39.NMI:Non-maskable_interrupts
      3942 ± 44%     -71.7%       1117 ±154%  interrupts.CPU39.PMI:Performance_monitoring_interrupts
      2708 ± 63%     -89.7%     279.00 ±118%  interrupts.CPU4.NMI:Non-maskable_interrupts
      2708 ± 63%     -89.7%     279.00 ±118%  interrupts.CPU4.PMI:Performance_monitoring_interrupts
      4454 ± 49%     -94.5%     246.25 ± 79%  interrupts.CPU41.NMI:Non-maskable_interrupts
      4454 ± 49%     -94.5%     246.25 ± 79%  interrupts.CPU41.PMI:Performance_monitoring_interrupts
      5099 ± 16%     -94.1%     299.25 ± 94%  interrupts.CPU42.NMI:Non-maskable_interrupts
      5099 ± 16%     -94.1%     299.25 ± 94%  interrupts.CPU42.PMI:Performance_monitoring_interrupts
      3574 ± 63%     -93.0%     249.00 ± 59%  interrupts.CPU44.NMI:Non-maskable_interrupts
      3574 ± 63%     -93.0%     249.00 ± 59%  interrupts.CPU44.PMI:Performance_monitoring_interrupts
      4069 ± 33%     -91.7%     337.50 ± 85%  interrupts.CPU47.NMI:Non-maskable_interrupts
      4069 ± 33%     -91.7%     337.50 ± 85%  interrupts.CPU47.PMI:Performance_monitoring_interrupts
      5387 ± 10%     -97.4%     139.75 ± 58%  interrupts.CPU48.NMI:Non-maskable_interrupts
      5387 ± 10%     -97.4%     139.75 ± 58%  interrupts.CPU48.PMI:Performance_monitoring_interrupts
      5491 ± 11%     -97.2%     155.00 ± 66%  interrupts.CPU49.NMI:Non-maskable_interrupts
      5491 ± 11%     -97.2%     155.00 ± 66%  interrupts.CPU49.PMI:Performance_monitoring_interrupts
      2072 ± 80%     -95.7%      89.00 ± 38%  interrupts.CPU5.NMI:Non-maskable_interrupts
      2072 ± 80%     -95.7%      89.00 ± 38%  interrupts.CPU5.PMI:Performance_monitoring_interrupts
      4489 ± 25%     -86.9%     587.75 ±154%  interrupts.CPU50.NMI:Non-maskable_interrupts
      4489 ± 25%     -86.9%     587.75 ±154%  interrupts.CPU50.PMI:Performance_monitoring_interrupts
      3531 ± 42%     -85.7%     504.75 ±151%  interrupts.CPU51.NMI:Non-maskable_interrupts
      3531 ± 42%     -85.7%     504.75 ±151%  interrupts.CPU51.PMI:Performance_monitoring_interrupts
      2969 ± 58%     -94.9%     151.75 ±102%  interrupts.CPU54.NMI:Non-maskable_interrupts
      2969 ± 58%     -94.9%     151.75 ±102%  interrupts.CPU54.PMI:Performance_monitoring_interrupts
      2842 ± 79%     -95.9%     117.75 ± 17%  interrupts.CPU55.NMI:Non-maskable_interrupts
      2842 ± 79%     -95.9%     117.75 ± 17%  interrupts.CPU55.PMI:Performance_monitoring_interrupts
      2358 ± 80%     -95.3%     109.75 ± 16%  interrupts.CPU56.NMI:Non-maskable_interrupts
      2358 ± 80%     -95.3%     109.75 ± 16%  interrupts.CPU56.PMI:Performance_monitoring_interrupts
      1589 ± 96%     -93.9%      96.25 ± 36%  interrupts.CPU61.NMI:Non-maskable_interrupts
      1589 ± 96%     -93.9%      96.25 ± 36%  interrupts.CPU61.PMI:Performance_monitoring_interrupts
      1174 ±105%     -91.7%      97.75 ± 36%  interrupts.CPU62.NMI:Non-maskable_interrupts
      1174 ±105%     -91.7%      97.75 ± 36%  interrupts.CPU62.PMI:Performance_monitoring_interrupts
      2365 ± 73%     -95.5%     107.00 ± 17%  interrupts.CPU66.NMI:Non-maskable_interrupts
      2365 ± 73%     -95.5%     107.00 ± 17%  interrupts.CPU66.PMI:Performance_monitoring_interrupts
      1030 ± 74%     -78.9%     217.50 ±102%  interrupts.CPU68.NMI:Non-maskable_interrupts
      1030 ± 74%     -78.9%     217.50 ±102%  interrupts.CPU68.PMI:Performance_monitoring_interrupts
      2882 ± 29%     -97.1%      84.50 ± 38%  interrupts.CPU7.NMI:Non-maskable_interrupts
      2882 ± 29%     -97.1%      84.50 ± 38%  interrupts.CPU7.PMI:Performance_monitoring_interrupts
      1985 ± 34%     -85.6%     286.50 ±107%  interrupts.CPU70.NMI:Non-maskable_interrupts
      1985 ± 34%     -85.6%     286.50 ±107%  interrupts.CPU70.PMI:Performance_monitoring_interrupts
      3174 ± 17%     -78.7%     675.25 ± 79%  interrupts.CPU71.NMI:Non-maskable_interrupts
      3174 ± 17%     -78.7%     675.25 ± 79%  interrupts.CPU71.PMI:Performance_monitoring_interrupts
      3853 ± 21%     -89.3%     412.50 ± 46%  interrupts.CPU72.NMI:Non-maskable_interrupts
      3853 ± 21%     -89.3%     412.50 ± 46%  interrupts.CPU72.PMI:Performance_monitoring_interrupts
      2989 ± 19%     -93.7%     188.25 ± 38%  interrupts.CPU73.NMI:Non-maskable_interrupts
      2989 ± 19%     -93.7%     188.25 ± 38%  interrupts.CPU73.PMI:Performance_monitoring_interrupts
      3406 ± 34%     -96.6%     116.25 ± 19%  interrupts.CPU74.NMI:Non-maskable_interrupts
      3406 ± 34%     -96.6%     116.25 ± 19%  interrupts.CPU74.PMI:Performance_monitoring_interrupts
      3954 ± 37%     -97.2%     112.00 ± 26%  interrupts.CPU75.NMI:Non-maskable_interrupts
      3954 ± 37%     -97.2%     112.00 ± 26%  interrupts.CPU75.PMI:Performance_monitoring_interrupts
      2614 ± 38%     -91.0%     236.50 ± 88%  interrupts.CPU76.NMI:Non-maskable_interrupts
      2614 ± 38%     -91.0%     236.50 ± 88%  interrupts.CPU76.PMI:Performance_monitoring_interrupts
      2287 ±  7%     -94.3%     129.75 ± 15%  interrupts.CPU77.NMI:Non-maskable_interrupts
      2287 ±  7%     -94.3%     129.75 ± 15%  interrupts.CPU77.PMI:Performance_monitoring_interrupts
      2427 ± 52%     -95.3%     115.25 ± 18%  interrupts.CPU78.NMI:Non-maskable_interrupts
      2427 ± 52%     -95.3%     115.25 ± 18%  interrupts.CPU78.PMI:Performance_monitoring_interrupts
      1466 ± 59%     -92.6%     109.00 ± 24%  interrupts.CPU79.NMI:Non-maskable_interrupts
      1466 ± 59%     -92.6%     109.00 ± 24%  interrupts.CPU79.PMI:Performance_monitoring_interrupts
      2326 ± 32%     -92.8%     168.00 ± 44%  interrupts.CPU81.NMI:Non-maskable_interrupts
      2326 ± 32%     -92.8%     168.00 ± 44%  interrupts.CPU81.PMI:Performance_monitoring_interrupts
      2566 ± 32%     -90.4%     245.75 ± 77%  interrupts.CPU82.NMI:Non-maskable_interrupts
      2566 ± 32%     -90.4%     245.75 ± 77%  interrupts.CPU82.PMI:Performance_monitoring_interrupts
      1469 ± 10%     -34.1%     968.50 ± 36%  interrupts.CPU83.CAL:Function_call_interrupts
      1207 ± 65%     -91.0%     108.25 ± 23%  interrupts.CPU84.NMI:Non-maskable_interrupts
      1207 ± 65%     -91.0%     108.25 ± 23%  interrupts.CPU84.PMI:Performance_monitoring_interrupts
      1725 ± 65%     -88.1%     204.50 ± 73%  interrupts.CPU85.NMI:Non-maskable_interrupts
      1725 ± 65%     -88.1%     204.50 ± 73%  interrupts.CPU85.PMI:Performance_monitoring_interrupts
      2516 ± 10%     -96.2%      96.75 ± 40%  interrupts.CPU89.NMI:Non-maskable_interrupts
      2516 ± 10%     -96.2%      96.75 ± 40%  interrupts.CPU89.PMI:Performance_monitoring_interrupts
      2956 ± 59%     -95.5%     133.50 ± 14%  interrupts.CPU93.NMI:Non-maskable_interrupts
      2956 ± 59%     -95.5%     133.50 ± 14%  interrupts.CPU93.PMI:Performance_monitoring_interrupts
      3259 ± 50%     -95.1%     160.25 ± 26%  interrupts.CPU95.NMI:Non-maskable_interrupts
      3259 ± 50%     -95.1%     160.25 ± 26%  interrupts.CPU95.PMI:Performance_monitoring_interrupts
      2922 ± 62%     -94.3%     168.00 ± 36%  interrupts.CPU96.NMI:Non-maskable_interrupts
      2922 ± 62%     -94.3%     168.00 ± 36%  interrupts.CPU96.PMI:Performance_monitoring_interrupts
      2994 ± 50%     -87.7%     368.75 ± 83%  interrupts.CPU97.NMI:Non-maskable_interrupts
      2994 ± 50%     -87.7%     368.75 ± 83%  interrupts.CPU97.PMI:Performance_monitoring_interrupts
      2671 ± 81%     -88.8%     299.25 ±109%  interrupts.CPU98.NMI:Non-maskable_interrupts
      2671 ± 81%     -88.8%     299.25 ±109%  interrupts.CPU98.PMI:Performance_monitoring_interrupts
     87.25 ± 16%     -93.1%       6.00 ± 11%  interrupts.IWI:IRQ_work_interrupts
    511867 ± 10%     -88.6%      58154 ± 10%  interrupts.NMI:Non-maskable_interrupts
    511867 ± 10%     -88.6%      58154 ± 10%  interrupts.PMI:Performance_monitoring_interrupts
      1132 ±  5%     -21.7%     887.00 ±  5%  interrupts.RES:Rescheduling_interrupts
     67.87 ±  7%     -51.3       16.60 ± 26%  perf-profile.calltrace.cycles-pp.f2fs_file_write_iter.new_sync_write.vfs_write.ksys_write.do_syscall_64
     67.89 ±  7%     -51.2       16.65 ± 26%  perf-profile.calltrace.cycles-pp.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
     67.90 ±  7%     -51.2       16.66 ± 26%  perf-profile.calltrace.cycles-pp.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
     68.18 ±  7%     -51.2       16.95 ± 25%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe
     68.20 ±  7%     -51.2       16.98 ± 25%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe
     67.88 ±  7%     -50.6       17.25 ± 24%  perf-profile.calltrace.cycles-pp.new_sync_write.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
     39.99 ±  7%     -40.0        0.00        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.f2fs_inode_dirtied.f2fs_mark_inode_dirty_sync.f2fs_write_end
     40.29 ±  7%     -36.4        3.85 ± 64%  perf-profile.calltrace.cycles-pp.f2fs_inode_dirtied.f2fs_mark_inode_dirty_sync.f2fs_write_end.generic_perform_write.__generic_file_write_iter
     40.29 ±  7%     -36.4        3.85 ± 64%  perf-profile.calltrace.cycles-pp.f2fs_mark_inode_dirty_sync.f2fs_write_end.generic_perform_write.__generic_file_write_iter.f2fs_file_write_iter
     40.27 ±  7%     -36.4        3.84 ± 64%  perf-profile.calltrace.cycles-pp._raw_spin_lock.f2fs_inode_dirtied.f2fs_mark_inode_dirty_sync.f2fs_write_end.generic_perform_write
     44.30 ±  7%     -35.5        8.77 ± 38%  perf-profile.calltrace.cycles-pp.f2fs_write_end.generic_perform_write.__generic_file_write_iter.f2fs_file_write_iter.new_sync_write
     46.49 ±  8%     -32.8       13.65 ± 24%  perf-profile.calltrace.cycles-pp.__generic_file_write_iter.f2fs_file_write_iter.new_sync_write.vfs_write.ksys_write
     46.47 ±  8%     -32.8       13.63 ± 24%  perf-profile.calltrace.cycles-pp.generic_perform_write.__generic_file_write_iter.f2fs_file_write_iter.new_sync_write.vfs_write
     21.26 ±  7%     -18.5        2.75 ± 38%  perf-profile.calltrace.cycles-pp.f2fs_preallocate_blocks.f2fs_file_write_iter.new_sync_write.vfs_write.ksys_write
     21.22 ±  7%     -18.5        2.73 ± 38%  perf-profile.calltrace.cycles-pp.f2fs_map_blocks.f2fs_preallocate_blocks.f2fs_file_write_iter.new_sync_write.vfs_write
     20.21 ±  7%     -18.1        2.15 ± 49%  perf-profile.calltrace.cycles-pp.f2fs_reserve_new_blocks.f2fs_map_blocks.f2fs_preallocate_blocks.f2fs_file_write_iter.new_sync_write
      9.87 ±  7%      -9.9        0.00        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.f2fs_inode_dirtied.f2fs_mark_inode_dirty_sync.f2fs_reserve_new_blocks
      9.82 ±  7%      -9.8        0.00        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.f2fs_inode_dirtied.__mark_inode_dirty.f2fs_reserve_new_blocks
      9.92 ±  7%      -9.4        0.54 ±102%  perf-profile.calltrace.cycles-pp.f2fs_mark_inode_dirty_sync.f2fs_reserve_new_blocks.f2fs_map_blocks.f2fs_preallocate_blocks.f2fs_file_write_iter
      9.92 ±  7%      -9.4        0.53 ±102%  perf-profile.calltrace.cycles-pp._raw_spin_lock.f2fs_inode_dirtied.f2fs_mark_inode_dirty_sync.f2fs_reserve_new_blocks.f2fs_map_blocks
      9.92 ±  7%      -9.4        0.54 ±102%  perf-profile.calltrace.cycles-pp.f2fs_inode_dirtied.f2fs_mark_inode_dirty_sync.f2fs_reserve_new_blocks.f2fs_map_blocks.f2fs_preallocate_blocks
     10.03 ±  7%      -9.1        0.97 ± 72%  perf-profile.calltrace.cycles-pp.__mark_inode_dirty.f2fs_reserve_new_blocks.f2fs_map_blocks.f2fs_preallocate_blocks.f2fs_file_write_iter
      9.90 ±  7%      -9.0        0.89 ± 73%  perf-profile.calltrace.cycles-pp.f2fs_inode_dirtied.__mark_inode_dirty.f2fs_reserve_new_blocks.f2fs_map_blocks.f2fs_preallocate_blocks
      9.89 ±  7%      -9.0        0.89 ± 73%  perf-profile.calltrace.cycles-pp._raw_spin_lock.f2fs_inode_dirtied.__mark_inode_dirty.f2fs_reserve_new_blocks.f2fs_map_blocks
      0.00            +0.6        0.55 ±  7%  perf-profile.calltrace.cycles-pp.get_page_from_freelist.__alloc_pages_nodemask.pagecache_get_page.f2fs_write_begin.generic_perform_write
      0.00            +0.6        0.61 ± 14%  perf-profile.calltrace.cycles-pp.get_page_from_freelist.__alloc_pages_nodemask.brd_insert_page.brd_do_bvec.brd_submit_bio
      0.00            +0.6        0.61 ±  6%  perf-profile.calltrace.cycles-pp.__alloc_pages_nodemask.pagecache_get_page.f2fs_write_begin.generic_perform_write.__generic_file_write_iter
      0.00            +0.6        0.62 ±  9%  perf-profile.calltrace.cycles-pp.memcpy_erms.drm_fb_helper_dirty_work.process_one_work.worker_thread.kthread
      0.00            +0.6        0.63 ±  9%  perf-profile.calltrace.cycles-pp.drm_fb_helper_dirty_work.process_one_work.worker_thread.kthread.ret_from_fork
      0.00            +0.7        0.65 ± 22%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.write
      0.00            +0.7        0.65 ± 22%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
      0.00            +0.7        0.65 ± 22%  perf-profile.calltrace.cycles-pp.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
      0.00            +0.7        0.65 ± 22%  perf-profile.calltrace.cycles-pp.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
      0.00            +0.7        0.65 ± 22%  perf-profile.calltrace.cycles-pp.write
      0.00            +0.7        0.68 ± 15%  perf-profile.calltrace.cycles-pp.__alloc_pages_nodemask.brd_insert_page.brd_do_bvec.brd_submit_bio.submit_bio_noacct
      0.43 ± 58%      +0.7        1.11 ± 14%  perf-profile.calltrace.cycles-pp.add_to_page_cache_lru.pagecache_get_page.f2fs_write_begin.generic_perform_write.__generic_file_write_iter
      0.00            +0.7        0.69 ± 21%  perf-profile.calltrace.cycles-pp.f2fs_write_end_io.brd_submit_bio.submit_bio_noacct.submit_bio.__submit_merged_bio
      0.00            +0.7        0.72 ± 16%  perf-profile.calltrace.cycles-pp.__add_to_page_cache_locked.add_to_page_cache_lru.pagecache_get_page.f2fs_write_begin.generic_perform_write
      0.00            +0.8        0.79 ± 26%  perf-profile.calltrace.cycles-pp.ktime_get_update_offsets_now.hrtimer_interrupt.__sysvec_apic_timer_interrupt.asm_call_sysvec_on_stack.sysvec_apic_timer_interrupt
      0.00            +0.8        0.81 ± 15%  perf-profile.calltrace.cycles-pp.scheduler_tick.update_process_times.tick_sched_handle.tick_sched_timer.__hrtimer_run_queues
      0.00            +0.8        0.82 ± 10%  perf-profile.calltrace.cycles-pp.perf_mux_hrtimer_handler.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.asm_call_sysvec_on_stack
      0.00            +0.8        0.84 ± 20%  perf-profile.calltrace.cycles-pp.f2fs_allocate_data_block.do_write_page.f2fs_outplace_write_data.f2fs_do_write_data_page.f2fs_write_single_data_page
      0.00            +0.8        0.85 ± 16%  perf-profile.calltrace.cycles-pp.ktime_get.tick_nohz_irq_exit.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state
      0.00            +0.9        0.86 ± 16%  perf-profile.calltrace.cycles-pp.tick_nohz_irq_exit.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter
      0.00            +0.9        0.95 ± 21%  perf-profile.calltrace.cycles-pp.f2fs_update_extent_tree_range.f2fs_outplace_write_data.f2fs_do_write_data_page.f2fs_write_single_data_page.f2fs_write_cache_pages
      0.00            +1.0        0.96 ±  6%  perf-profile.calltrace.cycles-pp.rebalance_domains.__softirqentry_text_start.asm_call_sysvec_on_stack.do_softirq_own_stack.irq_exit_rcu
      0.80 ± 11%      +1.0        1.80 ± 10%  perf-profile.calltrace.cycles-pp.pagecache_get_page.f2fs_write_begin.generic_perform_write.__generic_file_write_iter.f2fs_file_write_iter
      0.92 ± 11%      +1.1        2.01 ±  9%  perf-profile.calltrace.cycles-pp.f2fs_write_begin.generic_perform_write.__generic_file_write_iter.f2fs_file_write_iter.new_sync_write
      0.00            +1.2        1.24 ±  6%  perf-profile.calltrace.cycles-pp.timekeeping_max_deferment.tick_nohz_next_event.tick_nohz_get_sleep_length.menu_select.do_idle
      0.00            +1.3        1.32 ± 38%  perf-profile.calltrace.cycles-pp.ktime_get.tick_irq_enter.irq_enter_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      0.00            +1.4        1.37 ±  5%  perf-profile.calltrace.cycles-pp.__softirqentry_text_start.asm_call_sysvec_on_stack.do_softirq_own_stack.irq_exit_rcu.sysvec_apic_timer_interrupt
      0.00            +1.4        1.38 ±  5%  perf-profile.calltrace.cycles-pp.asm_call_sysvec_on_stack.do_softirq_own_stack.irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      0.00            +1.4        1.38 ±  5%  perf-profile.calltrace.cycles-pp.do_softirq_own_stack.irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state
      0.00            +1.4        1.42 ± 24%  perf-profile.calltrace.cycles-pp.ktime_get.clockevents_program_event.hrtimer_interrupt.__sysvec_apic_timer_interrupt.asm_call_sysvec_on_stack
      1.09 ± 12%      +1.4        2.51 ± 10%  perf-profile.calltrace.cycles-pp.copy_user_enhanced_fast_string.copyin.iov_iter_copy_from_user_atomic.generic_perform_write.__generic_file_write_iter
      1.10 ± 12%      +1.4        2.52 ± 10%  perf-profile.calltrace.cycles-pp.copyin.iov_iter_copy_from_user_atomic.generic_perform_write.__generic_file_write_iter.f2fs_file_write_iter
      1.11 ± 12%      +1.4        2.56 ± 10%  perf-profile.calltrace.cycles-pp.iov_iter_copy_from_user_atomic.generic_perform_write.__generic_file_write_iter.f2fs_file_write_iter.new_sync_write
      0.00            +1.5        1.46 ± 34%  perf-profile.calltrace.cycles-pp.tick_irq_enter.irq_enter_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state
      0.00            +1.5        1.51 ± 16%  perf-profile.calltrace.cycles-pp.update_process_times.tick_sched_handle.tick_sched_timer.__hrtimer_run_queues.hrtimer_interrupt
      0.00            +1.6        1.55 ± 16%  perf-profile.calltrace.cycles-pp.tick_sched_handle.tick_sched_timer.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt
      0.00            +1.6        1.58 ± 18%  perf-profile.calltrace.cycles-pp.do_write_page.f2fs_outplace_write_data.f2fs_do_write_data_page.f2fs_write_single_data_page.f2fs_write_cache_pages
      0.00            +1.6        1.60 ±  5%  perf-profile.calltrace.cycles-pp.irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter
      0.00            +1.6        1.63 ± 31%  perf-profile.calltrace.cycles-pp.irq_enter_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter
      0.00            +2.0        1.99 ± 18%  perf-profile.calltrace.cycles-pp.clockevents_program_event.hrtimer_interrupt.__sysvec_apic_timer_interrupt.asm_call_sysvec_on_stack.sysvec_apic_timer_interrupt
      0.00            +2.2        2.16 ±  8%  perf-profile.calltrace.cycles-pp.tick_nohz_next_event.tick_nohz_get_sleep_length.menu_select.do_idle.cpu_startup_entry
      0.00            +2.2        2.17 ± 16%  perf-profile.calltrace.cycles-pp.tick_sched_timer.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.asm_call_sysvec_on_stack
      0.00            +2.4        2.41 ±  8%  perf-profile.calltrace.cycles-pp.tick_nohz_get_sleep_length.menu_select.do_idle.cpu_startup_entry.start_secondary
      0.00            +3.0        3.02 ±  9%  perf-profile.calltrace.cycles-pp.f2fs_outplace_write_data.f2fs_do_write_data_page.f2fs_write_single_data_page.f2fs_write_cache_pages.f2fs_write_data_pages
      0.00            +3.2        3.18 ±  8%  perf-profile.calltrace.cycles-pp._raw_spin_lock.brd_insert_page.brd_do_bvec.brd_submit_bio.submit_bio_noacct
      0.00            +3.4        3.43 ± 14%  perf-profile.calltrace.cycles-pp.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.asm_call_sysvec_on_stack.sysvec_apic_timer_interrupt
      0.00            +3.6        3.64 ± 67%  perf-profile.calltrace.cycles-pp.__cna_queued_spin_lock_slowpath._raw_spin_lock.f2fs_inode_dirtied.f2fs_mark_inode_dirty_sync.f2fs_write_end
      0.00            +4.9        4.88 ±  7%  perf-profile.calltrace.cycles-pp.brd_insert_page.brd_do_bvec.brd_submit_bio.submit_bio_noacct.submit_bio
      0.00            +5.2        5.25 ±  8%  perf-profile.calltrace.cycles-pp.f2fs_do_write_data_page.f2fs_write_single_data_page.f2fs_write_cache_pages.f2fs_write_data_pages.do_writepages
      0.00            +5.5        5.51 ± 18%  perf-profile.calltrace.cycles-pp.f2fs_write_data_pages.do_writepages.__writeback_single_inode.writeback_sb_inodes.wb_writeback
      0.00            +5.5        5.51 ± 18%  perf-profile.calltrace.cycles-pp.do_writepages.__writeback_single_inode.writeback_sb_inodes.wb_writeback.wb_workfn
      0.00            +5.5        5.52 ± 18%  perf-profile.calltrace.cycles-pp.__writeback_single_inode.writeback_sb_inodes.wb_writeback.wb_workfn.process_one_work
      0.00            +5.5        5.52 ± 18%  perf-profile.calltrace.cycles-pp.writeback_sb_inodes.wb_writeback.wb_workfn.process_one_work.worker_thread
      0.00            +5.7        5.73 ±  9%  perf-profile.calltrace.cycles-pp.f2fs_write_single_data_page.f2fs_write_cache_pages.f2fs_write_data_pages.do_writepages.__writeback_single_inode
      0.00            +5.8        5.75 ±  4%  perf-profile.calltrace.cycles-pp.menu_select.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      0.28 ±100%      +6.4        6.63 ± 15%  perf-profile.calltrace.cycles-pp.hrtimer_interrupt.__sysvec_apic_timer_interrupt.asm_call_sysvec_on_stack.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      0.29 ±100%      +6.5        6.76 ± 15%  perf-profile.calltrace.cycles-pp.__sysvec_apic_timer_interrupt.asm_call_sysvec_on_stack.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state
      0.29 ±100%      +6.5        6.78 ± 15%  perf-profile.calltrace.cycles-pp.asm_call_sysvec_on_stack.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter
      0.00            +8.7        8.73 ±  6%  perf-profile.calltrace.cycles-pp.brd_do_bvec.brd_submit_bio.submit_bio_noacct.submit_bio.__submit_merged_bio
      1.06 ± 25%      +9.8       10.84 ± 16%  perf-profile.calltrace.cycles-pp.writeback_sb_inodes.__writeback_inodes_wb.wb_writeback.wb_workfn.process_one_work
      1.05 ± 25%      +9.8       10.84 ± 16%  perf-profile.calltrace.cycles-pp.do_writepages.__writeback_single_inode.writeback_sb_inodes.__writeback_inodes_wb.wb_writeback
      1.06 ± 25%      +9.8       10.85 ± 16%  perf-profile.calltrace.cycles-pp.__writeback_inodes_wb.wb_writeback.wb_workfn.process_one_work.worker_thread
      0.00            +9.8        9.79 ±  7%  perf-profile.calltrace.cycles-pp.brd_submit_bio.submit_bio_noacct.submit_bio.__submit_merged_bio.__submit_merged_write_cond
      0.00            +9.8        9.79 ±  7%  perf-profile.calltrace.cycles-pp.__submit_merged_bio.__submit_merged_write_cond.f2fs_write_cache_pages.f2fs_write_data_pages.do_writepages
      0.00            +9.8        9.79 ±  7%  perf-profile.calltrace.cycles-pp.submit_bio.__submit_merged_bio.__submit_merged_write_cond.f2fs_write_cache_pages.f2fs_write_data_pages
      0.00            +9.8        9.79 ±  7%  perf-profile.calltrace.cycles-pp.submit_bio_noacct.submit_bio.__submit_merged_bio.__submit_merged_write_cond.f2fs_write_cache_pages
      0.00            +9.8        9.79 ±  7%  perf-profile.calltrace.cycles-pp.__submit_merged_write_cond.f2fs_write_cache_pages.f2fs_write_data_pages.do_writepages.__writeback_single_inode
      0.67 ± 59%     +10.2       10.84 ± 16%  perf-profile.calltrace.cycles-pp.__writeback_single_inode.writeback_sb_inodes.__writeback_inodes_wb.wb_writeback.wb_workfn
      0.80 ± 17%     +10.2       11.03 ± 14%  perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter.do_idle
      0.31 ±100%     +10.5       10.82 ± 16%  perf-profile.calltrace.cycles-pp.f2fs_write_data_pages.do_writepages.__writeback_single_inode.writeback_sb_inodes.__writeback_inodes_wb
     28.90 ± 18%     +11.1       39.96 ± 11%  perf-profile.calltrace.cycles-pp.intel_idle.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry
      1.06 ± 25%     +15.3       16.37 ±  8%  perf-profile.calltrace.cycles-pp.wb_workfn.process_one_work.worker_thread.kthread.ret_from_fork
      1.06 ± 25%     +15.3       16.37 ±  8%  perf-profile.calltrace.cycles-pp.wb_writeback.wb_workfn.process_one_work.worker_thread.kthread
      1.17 ± 22%     +15.8       17.01 ±  8%  perf-profile.calltrace.cycles-pp.process_one_work.worker_thread.kthread.ret_from_fork
      1.17 ± 22%     +15.9       17.03 ±  8%  perf-profile.calltrace.cycles-pp.worker_thread.kthread.ret_from_fork
      1.18 ± 22%     +15.9       17.12 ±  8%  perf-profile.calltrace.cycles-pp.ret_from_fork
      1.18 ± 22%     +15.9       17.12 ±  8%  perf-profile.calltrace.cycles-pp.kthread.ret_from_fork
      0.31 ±100%     +16.0       16.32 ±  8%  perf-profile.calltrace.cycles-pp.f2fs_write_cache_pages.f2fs_write_data_pages.do_writepages.__writeback_single_inode.writeback_sb_inodes
      0.90 ± 17%     +16.2       17.06 ± 11%  perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry
     29.73 ± 17%     +25.8       55.53 ±  6%  perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry.start_secondary
     29.82 ± 17%     +27.9       57.71 ±  6%  perf-profile.calltrace.cycles-pp.cpuidle_enter.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     30.20 ± 17%     +34.0       64.17 ±  5%  perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     30.20 ± 17%     +34.0       64.20 ±  5%  perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     30.20 ± 17%     +34.0       64.20 ±  5%  perf-profile.calltrace.cycles-pp.start_secondary.secondary_startup_64_no_verify
     30.38 ± 17%     +34.0       64.40 ±  5%  perf-profile.calltrace.cycles-pp.secondary_startup_64_no_verify
     62.51 ±  7%     -62.5        0.00        perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
     60.55 ±  7%     -54.4        6.13 ± 61%  perf-profile.children.cycles-pp.f2fs_inode_dirtied
     67.87 ±  7%     -51.3       16.60 ± 26%  perf-profile.children.cycles-pp.f2fs_file_write_iter
     63.57 ±  7%     -51.0       12.56 ± 33%  perf-profile.children.cycles-pp._raw_spin_lock
     67.98 ±  7%     -50.7       17.27 ± 24%  perf-profile.children.cycles-pp.new_sync_write
     68.00 ±  7%     -50.7       17.31 ± 24%  perf-profile.children.cycles-pp.vfs_write
     68.01 ±  7%     -50.7       17.33 ± 24%  perf-profile.children.cycles-pp.ksys_write
     68.36 ±  7%     -50.4       17.98 ± 23%  perf-profile.children.cycles-pp.do_syscall_64
     68.38 ±  7%     -50.3       18.11 ± 23%  perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     50.41 ±  7%     -45.2        5.22 ± 60%  perf-profile.children.cycles-pp.f2fs_mark_inode_dirty_sync
     44.30 ±  7%     -35.5        8.77 ± 38%  perf-profile.children.cycles-pp.f2fs_write_end
     46.50 ±  8%     -32.8       13.66 ± 24%  perf-profile.children.cycles-pp.__generic_file_write_iter
     46.48 ±  8%     -32.8       13.64 ± 24%  perf-profile.children.cycles-pp.generic_perform_write
     21.26 ±  7%     -18.5        2.75 ± 38%  perf-profile.children.cycles-pp.f2fs_preallocate_blocks
     21.22 ±  7%     -18.5        2.73 ± 38%  perf-profile.children.cycles-pp.f2fs_map_blocks
     20.22 ±  7%     -18.1        2.15 ± 49%  perf-profile.children.cycles-pp.f2fs_reserve_new_blocks
     10.31 ±  7%      -9.3        1.06 ± 60%  perf-profile.children.cycles-pp.__mark_inode_dirty
      0.60 ±  6%      -0.5        0.05 ± 74%  perf-profile.children.cycles-pp.osq_lock
      0.56 ± 23%      -0.5        0.04 ±115%  perf-profile.children.cycles-pp.block_operations
      0.56 ± 23%      -0.5        0.09 ± 51%  perf-profile.children.cycles-pp.f2fs_write_checkpoint
      0.20 ± 14%      -0.2        0.03 ±100%  perf-profile.children.cycles-pp.f2fs_create
      0.21 ± 14%      -0.1        0.11 ± 12%  perf-profile.children.cycles-pp.do_filp_open
      0.21 ± 14%      -0.1        0.11 ± 12%  perf-profile.children.cycles-pp.path_openat
      0.21 ± 14%      -0.1        0.11 ± 14%  perf-profile.children.cycles-pp.do_sys_open
      0.21 ± 14%      -0.1        0.11 ± 14%  perf-profile.children.cycles-pp.do_sys_openat2
      0.13 ± 12%      -0.1        0.05 ± 58%  perf-profile.children.cycles-pp.task_tick_fair
      0.06 ± 11%      +0.0        0.10 ±  8%  perf-profile.children.cycles-pp.dquot_claim_space_nodirty
      0.01 ±173%      +0.1        0.06 ± 20%  perf-profile.children.cycles-pp.__count_memcg_events
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.xas_clear_mark
      0.01 ±173%      +0.1        0.07 ± 22%  perf-profile.children.cycles-pp.page_counter_try_charge
      0.00            +0.1        0.06 ± 14%  perf-profile.children.cycles-pp.__x64_sys_execve
      0.00            +0.1        0.06 ± 14%  perf-profile.children.cycles-pp.execve
      0.00            +0.1        0.06 ± 14%  perf-profile.children.cycles-pp.do_execveat_common
      0.00            +0.1        0.06 ± 14%  perf-profile.children.cycles-pp.mark_page_accessed
      0.00            +0.1        0.06 ± 14%  perf-profile.children.cycles-pp.io_serial_out
      0.08 ± 14%      +0.1        0.14 ± 23%  perf-profile.children.cycles-pp.__get_user_nocheck_1
      0.00            +0.1        0.06 ± 20%  perf-profile.children.cycles-pp.try_to_wake_up
      0.03 ±100%      +0.1        0.09 ± 14%  perf-profile.children.cycles-pp.__x64_sys_gettimeofday
      0.06 ± 22%      +0.1        0.12 ± 21%  perf-profile.children.cycles-pp.try_charge
      0.00            +0.1        0.06 ± 17%  perf-profile.children.cycles-pp.bio_add_page
      0.00            +0.1        0.06 ± 13%  perf-profile.children.cycles-pp._raw_write_lock
      0.00            +0.1        0.06 ±  6%  perf-profile.children.cycles-pp.rcu_dynticks_eqs_exit
      0.00            +0.1        0.06 ±  6%  perf-profile.children.cycles-pp.kmem_cache_alloc
      0.00            +0.1        0.07 ± 17%  perf-profile.children.cycles-pp.__list_add_valid
      0.00            +0.1        0.07 ± 17%  perf-profile.children.cycles-pp.__fprop_inc_percpu_max
      0.00            +0.1        0.07 ± 17%  perf-profile.children.cycles-pp.rcu_all_qs
      0.00            +0.1        0.07 ± 12%  perf-profile.children.cycles-pp.xas_store
      0.00            +0.1        0.07 ± 21%  perf-profile.children.cycles-pp.run_local_timers
      0.08 ± 13%      +0.1        0.15 ± 17%  perf-profile.children.cycles-pp.iov_iter_fault_in_readable
      0.00            +0.1        0.07 ± 17%  perf-profile.children.cycles-pp.f2fs_set_data_blkaddr
      0.00            +0.1        0.07 ± 14%  perf-profile.children.cycles-pp.down_read_trylock
      0.00            +0.1        0.07 ± 22%  perf-profile.children.cycles-pp.node_page_state
      0.00            +0.1        0.07 ± 17%  perf-profile.children.cycles-pp.update_ts_time_stats
      0.00            +0.1        0.07 ± 31%  perf-profile.children.cycles-pp.trigger_load_balance
      0.00            +0.1        0.07 ± 22%  perf-profile.children.cycles-pp.__hrtimer_get_next_event
      0.00            +0.1        0.07 ± 20%  perf-profile.children.cycles-pp.sys_imageblit
      0.00            +0.1        0.07 ± 20%  perf-profile.children.cycles-pp.drm_fb_helper_sys_imageblit
      0.00            +0.1        0.08 ± 20%  perf-profile.children.cycles-pp.f2fs_update_data_blkaddr
      0.00            +0.1        0.08 ±  6%  perf-profile.children.cycles-pp.inc_zone_page_state
      0.04 ± 58%      +0.1        0.12 ± 15%  perf-profile.children.cycles-pp.balance_dirty_pages_ratelimited
      0.00            +0.1        0.08 ± 10%  perf-profile.children.cycles-pp.rcu_eqs_enter
      0.00            +0.1        0.08 ±  5%  perf-profile.children.cycles-pp._find_next_bit
      0.00            +0.1        0.08 ± 14%  perf-profile.children.cycles-pp.timerqueue_del
      0.00            +0.1        0.08 ± 19%  perf-profile.children.cycles-pp.umount2
      0.00            +0.1        0.08 ± 19%  perf-profile.children.cycles-pp.cleanup_mnt
      0.00            +0.1        0.08 ± 19%  perf-profile.children.cycles-pp.deactivate_locked_super
      0.00            +0.1        0.08 ± 19%  perf-profile.children.cycles-pp.kill_f2fs_super
      0.00            +0.1        0.08 ± 15%  perf-profile.children.cycles-pp.set_page_dirty
      0.00            +0.1        0.08 ± 23%  perf-profile.children.cycles-pp.balance_dirty_pages
      0.00            +0.1        0.08 ± 21%  perf-profile.children.cycles-pp.fbcon_putcs
      0.00            +0.1        0.08 ± 21%  perf-profile.children.cycles-pp.bit_putcs
      0.00            +0.1        0.08 ± 15%  perf-profile.children.cycles-pp.mutex_unlock
      0.00            +0.1        0.08 ± 19%  perf-profile.children.cycles-pp.xas_start
      0.00            +0.1        0.09 ± 24%  perf-profile.children.cycles-pp.f2fs_should_update_outplace
      0.00            +0.1        0.09 ± 29%  perf-profile.children.cycles-pp.__x86_indirect_thunk_rax
      0.00            +0.1        0.09 ± 17%  perf-profile.children.cycles-pp.fbcon_redraw
      0.00            +0.1        0.09 ±  5%  perf-profile.children.cycles-pp.cpumask_next_and
      0.00            +0.1        0.09 ± 20%  perf-profile.children.cycles-pp.task_work_run
      0.00            +0.1        0.09 ±  9%  perf-profile.children.cycles-pp.nr_iowait_cpu
      0.00            +0.1        0.09 ± 20%  perf-profile.children.cycles-pp.con_scroll
      0.00            +0.1        0.09 ± 20%  perf-profile.children.cycles-pp.vt_console_print
      0.00            +0.1        0.09 ± 20%  perf-profile.children.cycles-pp.lf
      0.00            +0.1        0.09 ± 20%  perf-profile.children.cycles-pp.fbcon_scroll
      0.00            +0.1        0.09 ± 13%  perf-profile.children.cycles-pp.call_cpuidle
      0.00            +0.1        0.09 ± 20%  perf-profile.children.cycles-pp._raw_spin_lock_irq
      0.00            +0.1        0.10 ± 15%  perf-profile.children.cycles-pp.up_write
      0.00            +0.1        0.10 ± 18%  perf-profile.children.cycles-pp.exit_to_user_mode_prepare
      0.00            +0.1        0.10 ± 19%  perf-profile.children.cycles-pp.release_pages
      0.00            +0.1        0.10 ± 11%  perf-profile.children.cycles-pp.__remove_hrtimer
      0.00            +0.1        0.10 ± 23%  perf-profile.children.cycles-pp.__handle_mm_fault
      0.00            +0.1        0.10 ± 15%  perf-profile.children.cycles-pp.radix_tree_insert
      0.00            +0.1        0.10 ± 12%  perf-profile.children.cycles-pp.cpuidle_governor_latency_req
      0.00            +0.1        0.10 ± 29%  perf-profile.children.cycles-pp.timerqueue_add
      0.00            +0.1        0.10 ± 22%  perf-profile.children.cycles-pp.handle_mm_fault
      0.00            +0.1        0.10 ± 18%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      0.00            +0.1        0.10 ± 15%  perf-profile.children.cycles-pp.__might_sleep
      0.00            +0.1        0.11 ± 24%  perf-profile.children.cycles-pp.__list_del_entry_valid
      0.00            +0.1        0.11 ± 23%  perf-profile.children.cycles-pp.update_sit_entry
      0.00            +0.1        0.11 ± 37%  perf-profile.children.cycles-pp.__schedule
      0.00            +0.1        0.11 ±  9%  perf-profile.children.cycles-pp.do_user_addr_fault
      0.00            +0.1        0.12 ± 23%  perf-profile.children.cycles-pp.idle_cpu
      0.00            +0.1        0.12 ± 12%  perf-profile.children.cycles-pp.exc_page_fault
      0.00            +0.1        0.12 ±  7%  perf-profile.children.cycles-pp.rcu_eqs_exit
      0.00            +0.1        0.12 ± 26%  perf-profile.children.cycles-pp.enqueue_hrtimer
      0.00            +0.1        0.12 ± 16%  perf-profile.children.cycles-pp.__xa_clear_mark
      0.00            +0.1        0.13 ± 15%  perf-profile.children.cycles-pp.asm_exc_page_fault
      0.00            +0.1        0.13 ±  5%  perf-profile.children.cycles-pp._cond_resched
      0.00            +0.1        0.13 ± 17%  perf-profile.children.cycles-pp.__hrtimer_next_event_base
      0.00            +0.1        0.14 ± 15%  perf-profile.children.cycles-pp.page_mapping
      0.00            +0.1        0.14 ± 10%  perf-profile.children.cycles-pp.pagevec_lookup_range_tag
      0.00            +0.1        0.14 ± 10%  perf-profile.children.cycles-pp.find_get_pages_range_tag
      0.00            +0.1        0.14 ± 15%  perf-profile.children.cycles-pp.up_read
      0.00            +0.1        0.14 ±  9%  perf-profile.children.cycles-pp.hrtimer_get_next_event
      0.00            +0.1        0.15 ± 14%  perf-profile.children.cycles-pp.__is_cp_guaranteed
      0.00            +0.1        0.15 ± 25%  perf-profile.children.cycles-pp.delay_tsc
      0.17 ± 12%      +0.1        0.32 ± 17%  perf-profile.children.cycles-pp.mem_cgroup_charge
      0.00            +0.1        0.15 ± 18%  perf-profile.children.cycles-pp.read_node_page
      0.00            +0.1        0.15 ± 14%  perf-profile.children.cycles-pp.update_irq_load_avg
      0.00            +0.1        0.15 ± 11%  perf-profile.children.cycles-pp.dec_zone_page_state
      0.12 ± 11%      +0.2        0.27 ± 15%  perf-profile.children.cycles-pp.__pagevec_lru_add_fn
      0.00            +0.2        0.15 ± 24%  perf-profile.children.cycles-pp.__lookup_nat_cache
      0.00            +0.2        0.15 ± 14%  perf-profile.children.cycles-pp.brd_lookup_page
      0.13 ±  8%      +0.2        0.28 ± 13%  perf-profile.children.cycles-pp.account_page_dirtied
      0.07 ± 13%      +0.2        0.23 ± 12%  perf-profile.children.cycles-pp.node_dirty_ok
      0.00            +0.2        0.17 ± 12%  perf-profile.children.cycles-pp.mutex_lock
      0.00            +0.2        0.17 ± 21%  perf-profile.children.cycles-pp.update_segment_mtime
      0.00            +0.2        0.18 ±  8%  perf-profile.children.cycles-pp.down_write
      0.00            +0.2        0.18 ± 20%  perf-profile.children.cycles-pp.__mod_node_page_state
      0.00            +0.2        0.19 ± 13%  perf-profile.children.cycles-pp.irq_work_single
      0.00            +0.2        0.19 ± 13%  perf-profile.children.cycles-pp.asm_sysvec_irq_work
      0.00            +0.2        0.19 ± 13%  perf-profile.children.cycles-pp.sysvec_irq_work
      0.00            +0.2        0.19 ± 13%  perf-profile.children.cycles-pp.__sysvec_irq_work
      0.00            +0.2        0.19 ± 13%  perf-profile.children.cycles-pp.irq_work_run
      0.00            +0.2        0.19 ± 13%  perf-profile.children.cycles-pp.printk
      0.00            +0.2        0.19 ± 11%  perf-profile.children.cycles-pp.__radix_tree_lookup
      0.06 ±  7%      +0.2        0.25 ± 16%  perf-profile.children.cycles-pp.__mod_memcg_state
      0.00            +0.2        0.20 ± 13%  perf-profile.children.cycles-pp.irq_work_run_list
      0.00            +0.2        0.20 ± 11%  perf-profile.children.cycles-pp.arch_scale_freq_tick
      0.06 ±  7%      +0.2        0.26 ± 16%  perf-profile.children.cycles-pp.f2fs_balance_fs
      0.00            +0.2        0.20 ± 12%  perf-profile.children.cycles-pp.hrtimer_next_event_without
      0.16 ± 11%      +0.2        0.36 ± 13%  perf-profile.children.cycles-pp.pagevec_lru_move_fn
      0.00            +0.2        0.20 ± 10%  perf-profile.children.cycles-pp.rcu_idle_exit
      0.17 ± 12%      +0.2        0.38 ± 13%  perf-profile.children.cycles-pp.lru_cache_add
      0.00            +0.2        0.21 ± 15%  perf-profile.children.cycles-pp.___might_sleep
      0.04 ± 59%      +0.2        0.26 ± 23%  perf-profile.children.cycles-pp.calc_global_load_tick
      0.00            +0.2        0.21 ±  5%  perf-profile.children.cycles-pp.update_blocked_averages
      0.00            +0.2        0.22 ±  9%  perf-profile.children.cycles-pp.run_rebalance_domains
      0.00            +0.2        0.22 ± 20%  perf-profile.children.cycles-pp.__mod_lruvec_state
      0.00            +0.2        0.22 ± 12%  perf-profile.children.cycles-pp.rcu_sched_clock_irq
      0.08 ± 10%      +0.2        0.32 ± 20%  perf-profile.children.cycles-pp.percpu_counter_add_batch
      0.03 ±100%      +0.2        0.26 ± 20%  perf-profile.children.cycles-pp.find_get_entry
      0.00            +0.2        0.24 ± 11%  perf-profile.children.cycles-pp.get_next_timer_interrupt
      0.00            +0.3        0.26 ± 27%  perf-profile.children.cycles-pp.tsc_verify_tsc_adjust
      0.06 ±  7%      +0.3        0.32 ± 15%  perf-profile.children.cycles-pp.xas_load
      0.00            +0.3        0.26 ± 28%  perf-profile.children.cycles-pp.arch_cpu_idle_enter
      0.00            +0.3        0.27 ± 14%  perf-profile.children.cycles-pp.update_rq_clock
      0.00            +0.3        0.27 ±  4%  perf-profile.children.cycles-pp.__radix_tree_preload
      0.00            +0.3        0.27 ± 14%  perf-profile.children.cycles-pp.down_read
      0.07 ± 16%      +0.3        0.35 ± 13%  perf-profile.children.cycles-pp.rmqueue_bulk
      0.25 ± 11%      +0.3        0.56 ± 13%  perf-profile.children.cycles-pp.__set_page_dirty_nobuffers
      0.00            +0.3        0.31 ± 12%  perf-profile.children.cycles-pp.update_sd_lb_stats
      0.00            +0.3        0.32 ± 18%  perf-profile.children.cycles-pp.f2fs_get_node_info
      0.00            +0.3        0.32 ±  9%  perf-profile.children.cycles-pp.irqtime_account_irq
      0.00            +0.3        0.33 ± 13%  perf-profile.children.cycles-pp.find_busiest_group
      0.10 ±  9%      +0.3        0.42 ± 11%  perf-profile.children.cycles-pp.__mod_memcg_lruvec_state
      0.37 ± 10%      +0.4        0.73 ± 16%  perf-profile.children.cycles-pp.__add_to_page_cache_locked
      0.00            +0.4        0.37 ±  8%  perf-profile.children.cycles-pp.__intel_pmu_enable_all
      0.00            +0.4        0.40 ± 11%  perf-profile.children.cycles-pp._raw_spin_trylock
      0.00            +0.4        0.40 ± 14%  perf-profile.children.cycles-pp._raw_spin_unlock_irqrestore
      0.00            +0.4        0.40 ± 10%  perf-profile.children.cycles-pp.native_sched_clock
      0.00            +0.4        0.42 ± 11%  perf-profile.children.cycles-pp.sched_clock
      0.08 ± 15%      +0.4        0.53 ±  2%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      0.00            +0.4        0.45 ±  8%  perf-profile.children.cycles-pp.load_balance
      0.00            +0.4        0.45 ± 11%  perf-profile.children.cycles-pp.sched_clock_cpu
      0.00            +0.5        0.45 ± 18%  perf-profile.children.cycles-pp.clear_page_dirty_for_io
      0.01 ±173%      +0.5        0.47 ± 11%  perf-profile.children.cycles-pp.read_tsc
      0.07 ± 17%      +0.5        0.53 ± 18%  perf-profile.children.cycles-pp.io_serial_in
      0.12 ±  9%      +0.5        0.60 ± 13%  perf-profile.children.cycles-pp.rmqueue
      0.01 ±173%      +0.5        0.53 ± 12%  perf-profile.children.cycles-pp.lapic_next_deadline
      0.11 ± 31%      +0.5        0.63 ±  9%  perf-profile.children.cycles-pp.drm_fb_helper_dirty_work
      0.11 ± 31%      +0.5        0.64 ±  9%  perf-profile.children.cycles-pp.memcpy_erms
      0.09 ± 25%      +0.5        0.64 ± 22%  perf-profile.children.cycles-pp.devkmsg_write.cold
      0.09 ± 25%      +0.5        0.64 ± 22%  perf-profile.children.cycles-pp.devkmsg_emit
      0.00            +0.5        0.55 ±  5%  perf-profile.children.cycles-pp.clear_page_erms
      0.10 ± 27%      +0.6        0.65 ± 22%  perf-profile.children.cycles-pp.write
      0.08 ± 14%      +0.6        0.64 ± 20%  perf-profile.children.cycles-pp.serial8250_console_putchar
      0.13 ±  8%      +0.6        0.70 ± 14%  perf-profile.children.cycles-pp.__get_node_page
      0.54 ± 11%      +0.6        1.11 ± 14%  perf-profile.children.cycles-pp.add_to_page_cache_lru
      0.21 ±  8%      +0.6        0.81 ± 12%  perf-profile.children.cycles-pp.f2fs_get_dnode_of_data
      0.08 ± 15%      +0.6        0.68 ± 20%  perf-profile.children.cycles-pp.wait_for_xmitr
      0.08 ± 15%      +0.6        0.69 ± 20%  perf-profile.children.cycles-pp.uart_console_write
      0.00            +0.6        0.63 ± 17%  perf-profile.children.cycles-pp.f2fs_submit_page_write
      0.00            +0.6        0.64 ± 15%  perf-profile.children.cycles-pp.__test_set_page_writeback
      0.09 ± 16%      +0.7        0.74 ± 19%  perf-profile.children.cycles-pp.serial8250_console_write
      0.00            +0.7        0.66 ±  4%  perf-profile.children.cycles-pp.prep_new_page
      0.25 ± 12%      +0.7        0.91 ± 14%  perf-profile.children.cycles-pp.scheduler_tick
      0.11 ± 20%      +0.7        0.83 ± 19%  perf-profile.children.cycles-pp.vprintk_emit
      0.11 ± 20%      +0.7        0.83 ± 19%  perf-profile.children.cycles-pp.console_unlock
      0.08 ± 24%      +0.7        0.81 ± 25%  perf-profile.children.cycles-pp.ktime_get_update_offsets_now
      0.00            +0.8        0.77 ± 14%  perf-profile.children.cycles-pp.test_clear_page_writeback
      0.07 ± 24%      +0.8        0.84 ±  9%  perf-profile.children.cycles-pp.perf_mux_hrtimer_handler
      0.06 ± 13%      +0.8        0.84 ±  7%  perf-profile.children.cycles-pp.native_irq_return_iret
      0.00            +0.8        0.80 ± 13%  perf-profile.children.cycles-pp.end_page_writeback
      0.06 ± 17%      +0.8        0.88 ± 15%  perf-profile.children.cycles-pp.tick_nohz_irq_exit
      0.08 ±  6%      +0.9        0.97 ±  7%  perf-profile.children.cycles-pp.rebalance_domains
      0.00            +1.0        1.04 ± 13%  perf-profile.children.cycles-pp.f2fs_write_end_io
      0.03 ±100%      +1.0        1.07 ± 20%  perf-profile.children.cycles-pp.f2fs_update_extent_tree_range
      0.92 ± 11%      +1.1        2.01 ±  9%  perf-profile.children.cycles-pp.f2fs_write_begin
      0.03 ±100%      +1.1        1.17 ± 12%  perf-profile.children.cycles-pp.f2fs_allocate_data_block
      0.10 ± 18%      +1.2        1.25 ±  6%  perf-profile.children.cycles-pp.timekeeping_max_deferment
      0.39 ± 10%      +1.3        1.66 ± 15%  perf-profile.children.cycles-pp.update_process_times
      0.13 ± 14%      +1.3        1.42 ±  5%  perf-profile.children.cycles-pp.__softirqentry_text_start
      0.13 ± 14%      +1.3        1.43 ±  5%  perf-profile.children.cycles-pp.do_softirq_own_stack
      0.39 ± 10%      +1.3        1.70 ± 15%  perf-profile.children.cycles-pp.tick_sched_handle
      0.85 ± 10%      +1.4        2.22 ± 10%  perf-profile.children.cycles-pp.pagecache_get_page
      0.23 ± 10%      +1.4        1.60 ±  3%  perf-profile.children.cycles-pp.get_page_from_freelist
      0.09 ± 15%      +1.4        1.48 ± 34%  perf-profile.children.cycles-pp.tick_irq_enter
      1.10 ± 12%      +1.4        2.52 ± 10%  perf-profile.children.cycles-pp.copy_user_enhanced_fast_string
      1.10 ± 12%      +1.4        2.53 ± 10%  perf-profile.children.cycles-pp.copyin
      1.12 ± 12%      +1.4        2.56 ± 10%  perf-profile.children.cycles-pp.iov_iter_copy_from_user_atomic
      0.26 ±  8%      +1.5        1.76 ±  5%  perf-profile.children.cycles-pp.__alloc_pages_nodemask
      0.15 ± 11%      +1.5        1.67 ±  5%  perf-profile.children.cycles-pp.irq_exit_rcu
      0.11 ± 13%      +1.6        1.66 ± 31%  perf-profile.children.cycles-pp.irq_enter_rcu
      0.23 ± 13%      +1.8        2.04 ± 18%  perf-profile.children.cycles-pp.clockevents_program_event
      0.48 ± 11%      +1.9        2.33 ± 15%  perf-profile.children.cycles-pp.tick_sched_timer
      0.05 ± 62%      +1.9        1.95 ± 14%  perf-profile.children.cycles-pp.do_write_page
      0.17 ± 14%      +2.0        2.17 ±  8%  perf-profile.children.cycles-pp.tick_nohz_next_event
      0.19 ± 15%      +2.2        2.42 ±  8%  perf-profile.children.cycles-pp.tick_nohz_get_sleep_length
      0.60 ± 13%      +3.0        3.63 ± 14%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      0.11 ± 28%      +3.0        3.14 ±  6%  perf-profile.children.cycles-pp.f2fs_outplace_write_data
      0.39 ± 15%      +3.8        4.16 ± 24%  perf-profile.children.cycles-pp.ktime_get
      0.14 ± 28%      +4.8        4.92 ±  7%  perf-profile.children.cycles-pp.brd_insert_page
      0.16 ± 31%      +5.1        5.26 ±  8%  perf-profile.children.cycles-pp.f2fs_do_write_data_page
      0.30 ± 16%      +5.5        5.79 ±  4%  perf-profile.children.cycles-pp.menu_select
      0.18 ± 30%      +5.6        5.75 ±  9%  perf-profile.children.cycles-pp.f2fs_write_single_data_page
      0.94 ± 13%      +6.0        6.91 ± 15%  perf-profile.children.cycles-pp.hrtimer_interrupt
      0.96 ± 12%      +6.1        7.03 ± 15%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      0.00            +7.4        7.40 ± 58%  perf-profile.children.cycles-pp.__cna_queued_spin_lock_slowpath
      1.09 ± 12%      +7.5        8.61 ± 13%  perf-profile.children.cycles-pp.asm_call_sysvec_on_stack
      0.26 ± 28%      +8.5        8.79 ±  7%  perf-profile.children.cycles-pp.brd_do_bvec
      0.29 ± 28%      +9.5        9.79 ±  7%  perf-profile.children.cycles-pp.__submit_merged_write_cond
      0.30 ± 27%      +9.6        9.86 ±  7%  perf-profile.children.cycles-pp.brd_submit_bio
      0.30 ± 27%      +9.6        9.87 ±  7%  perf-profile.children.cycles-pp.__submit_merged_bio
      0.30 ± 27%      +9.6        9.87 ±  7%  perf-profile.children.cycles-pp.submit_bio
      0.30 ± 27%      +9.6        9.87 ±  7%  perf-profile.children.cycles-pp.submit_bio_noacct
      1.06 ± 25%      +9.8       10.85 ± 16%  perf-profile.children.cycles-pp.__writeback_inodes_wb
      1.29 ± 13%     +10.1       11.36 ± 14%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
     28.92 ± 18%     +11.1       40.04 ± 11%  perf-profile.children.cycles-pp.intel_idle
      1.44 ± 13%     +13.1       14.52 ± 12%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
      1.05 ± 25%     +15.3       16.35 ±  8%  perf-profile.children.cycles-pp.do_writepages
      1.06 ± 25%     +15.3       16.36 ±  8%  perf-profile.children.cycles-pp.__writeback_single_inode
      1.06 ± 25%     +15.3       16.36 ±  8%  perf-profile.children.cycles-pp.writeback_sb_inodes
      1.06 ± 25%     +15.3       16.37 ±  8%  perf-profile.children.cycles-pp.wb_workfn
      1.06 ± 25%     +15.3       16.37 ±  8%  perf-profile.children.cycles-pp.wb_writeback
      0.49 ± 29%     +15.8       16.33 ±  8%  perf-profile.children.cycles-pp.f2fs_write_cache_pages
      0.50 ± 29%     +15.8       16.33 ±  8%  perf-profile.children.cycles-pp.f2fs_write_data_pages
      1.17 ± 22%     +15.8       17.01 ±  8%  perf-profile.children.cycles-pp.process_one_work
      1.17 ± 22%     +15.9       17.03 ±  8%  perf-profile.children.cycles-pp.worker_thread
      1.18 ± 22%     +15.9       17.12 ±  8%  perf-profile.children.cycles-pp.ret_from_fork
      1.18 ± 22%     +15.9       17.12 ±  8%  perf-profile.children.cycles-pp.kthread
     30.00 ± 17%     +27.9       57.85 ±  6%  perf-profile.children.cycles-pp.cpuidle_enter_state
     30.00 ± 17%     +27.9       57.88 ±  6%  perf-profile.children.cycles-pp.cpuidle_enter
     30.20 ± 17%     +34.0       64.20 ±  5%  perf-profile.children.cycles-pp.start_secondary
     30.38 ± 17%     +34.0       64.40 ±  5%  perf-profile.children.cycles-pp.secondary_startup_64_no_verify
     30.38 ± 17%     +34.0       64.40 ±  5%  perf-profile.children.cycles-pp.cpu_startup_entry
     30.38 ± 17%     +34.0       64.40 ±  5%  perf-profile.children.cycles-pp.do_idle
     62.04 ±  7%     -62.0        0.00        perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
      0.59 ±  7%      -0.5        0.05 ± 74%  perf-profile.self.cycles-pp.osq_lock
      0.08 ±  8%      +0.0        0.13 ± 21%  perf-profile.self.cycles-pp.f2fs_file_write_iter
      0.01 ±173%      +0.1        0.06 ± 20%  perf-profile.self.cycles-pp.__count_memcg_events
      0.00            +0.1        0.06 ± 14%  perf-profile.self.cycles-pp.io_serial_out
      0.00            +0.1        0.06        perf-profile.self.cycles-pp.mem_cgroup_charge
      0.00            +0.1        0.06        perf-profile.self.cycles-pp.rcu_dynticks_eqs_exit
      0.00            +0.1        0.06 ± 20%  perf-profile.self.cycles-pp._cond_resched
      0.00            +0.1        0.06 ± 13%  perf-profile.self.cycles-pp._raw_write_lock
      0.07 ± 16%      +0.1        0.13 ± 20%  perf-profile.self.cycles-pp.__get_user_nocheck_1
      0.00            +0.1        0.07 ± 23%  perf-profile.self.cycles-pp.page_counter_try_charge
      0.00            +0.1        0.07 ±  7%  perf-profile.self.cycles-pp.__softirqentry_text_start
      0.00            +0.1        0.07 ± 19%  perf-profile.self.cycles-pp.down_read_trylock
      0.00            +0.1        0.07 ±  6%  perf-profile.self.cycles-pp.inc_zone_page_state
      0.00            +0.1        0.07 ± 17%  perf-profile.self.cycles-pp.xas_start
      0.00            +0.1        0.07 ± 22%  perf-profile.self.cycles-pp.node_page_state
      0.00            +0.1        0.07 ± 17%  perf-profile.self.cycles-pp.f2fs_get_dnode_of_data
      0.08 ± 10%      +0.1        0.16 ± 22%  perf-profile.self.cycles-pp.__add_to_page_cache_locked
      0.00            +0.1        0.07 ± 30%  perf-profile.self.cycles-pp.account_page_dirtied
      0.00            +0.1        0.07 ± 20%  perf-profile.self.cycles-pp.sys_imageblit
      0.00            +0.1        0.08 ± 14%  perf-profile.self.cycles-pp.update_blocked_averages
      0.00            +0.1        0.08 ±  5%  perf-profile.self.cycles-pp._find_next_bit
      0.00            +0.1        0.08 ± 19%  perf-profile.self.cycles-pp.release_pages
      0.00            +0.1        0.08 ± 27%  perf-profile.self.cycles-pp.f2fs_should_update_outplace
      0.00            +0.1        0.08 ± 15%  perf-profile.self.cycles-pp.mutex_unlock
      0.00            +0.1        0.09 ± 21%  perf-profile.self.cycles-pp.rcu_idle_exit
      0.00            +0.1        0.09 ± 19%  perf-profile.self.cycles-pp.mutex_lock
      0.03 ±100%      +0.1        0.11 ± 22%  perf-profile.self.cycles-pp.__pagevec_lru_add_fn
      0.00            +0.1        0.09 ±  9%  perf-profile.self.cycles-pp.nr_iowait_cpu
      0.11 ±  9%      +0.1        0.20 ± 10%  perf-profile.self.cycles-pp.f2fs_write_begin
      0.00            +0.1        0.09 ± 12%  perf-profile.self.cycles-pp.down_write
      0.00            +0.1        0.09 ± 13%  perf-profile.self.cycles-pp.radix_tree_insert
      0.00            +0.1        0.09 ± 13%  perf-profile.self.cycles-pp.call_cpuidle
      0.06 ± 14%      +0.1        0.15 ± 13%  perf-profile.self.cycles-pp.__get_node_page
      0.00            +0.1        0.09 ± 14%  perf-profile.self.cycles-pp.pagecache_get_page
      0.00            +0.1        0.09 ± 20%  perf-profile.self.cycles-pp._raw_spin_lock_irq
      0.00            +0.1        0.10 ± 15%  perf-profile.self.cycles-pp.up_write
      0.00            +0.1        0.10 ± 24%  perf-profile.self.cycles-pp.__sysvec_apic_timer_interrupt
      0.00            +0.1        0.10 ± 15%  perf-profile.self.cycles-pp.f2fs_write_cache_pages
      0.00            +0.1        0.10 ± 15%  perf-profile.self.cycles-pp.__might_sleep
      0.00            +0.1        0.10 ± 24%  perf-profile.self.cycles-pp.find_get_entry
      0.00            +0.1        0.10 ± 18%  perf-profile.self.cycles-pp.__hrtimer_run_queues
      0.00            +0.1        0.10 ± 22%  perf-profile.self.cycles-pp.read_node_page
      0.00            +0.1        0.10 ± 24%  perf-profile.self.cycles-pp.__list_del_entry_valid
      0.00            +0.1        0.10 ± 26%  perf-profile.self.cycles-pp.hrtimer_interrupt
      0.00            +0.1        0.10 ± 10%  perf-profile.self.cycles-pp.prep_new_page
      0.00            +0.1        0.11 ± 28%  perf-profile.self.cycles-pp.update_sit_entry
      0.00            +0.1        0.11 ±  6%  perf-profile.self.cycles-pp.get_page_from_freelist
      0.00            +0.1        0.11 ± 19%  perf-profile.self.cycles-pp.__alloc_pages_nodemask
      0.00            +0.1        0.11 ± 18%  perf-profile.self.cycles-pp.update_segment_mtime
      0.00            +0.1        0.11 ± 22%  perf-profile.self.cycles-pp.idle_cpu
      0.00            +0.1        0.12 ± 20%  perf-profile.self.cycles-pp.__hrtimer_next_event_base
      0.00            +0.1        0.12 ± 11%  perf-profile.self.cycles-pp.find_get_pages_range_tag
      0.00            +0.1        0.12 ± 14%  perf-profile.self.cycles-pp.f2fs_update_extent_tree_range
      0.00            +0.1        0.12 ± 18%  perf-profile.self.cycles-pp.asm_sysvec_apic_timer_interrupt
      0.00            +0.1        0.13 ± 16%  perf-profile.self.cycles-pp.page_mapping
      0.00            +0.1        0.13 ±  5%  perf-profile.self.cycles-pp.irqtime_account_irq
      0.03 ±100%      +0.1        0.15 ± 16%  perf-profile.self.cycles-pp.node_dirty_ok
      0.00            +0.1        0.13 ±  9%  perf-profile.self.cycles-pp.dec_zone_page_state
      0.00            +0.1        0.14 ± 15%  perf-profile.self.cycles-pp.up_read
      0.00            +0.1        0.14 ±  8%  perf-profile.self.cycles-pp.__is_cp_guaranteed
      0.00            +0.1        0.14 ± 20%  perf-profile.self.cycles-pp.f2fs_write_end_io
      0.00            +0.1        0.14 ± 27%  perf-profile.self.cycles-pp.delay_tsc
      0.00            +0.1        0.15 ± 14%  perf-profile.self.cycles-pp.update_irq_load_avg
      0.00            +0.2        0.16 ± 17%  perf-profile.self.cycles-pp.f2fs_submit_page_write
      0.00            +0.2        0.17 ± 22%  perf-profile.self.cycles-pp.__mod_node_page_state
      0.00            +0.2        0.17 ± 12%  perf-profile.self.cycles-pp.tick_sched_timer
      0.00            +0.2        0.17 ±  6%  perf-profile.self.cycles-pp.__mod_memcg_lruvec_state
      0.00            +0.2        0.18 ± 12%  perf-profile.self.cycles-pp.rmqueue
      0.00            +0.2        0.18 ± 12%  perf-profile.self.cycles-pp.test_clear_page_writeback
      0.07 ± 11%      +0.2        0.26 ± 21%  perf-profile.self.cycles-pp.percpu_counter_add_batch
      0.06 ±  7%      +0.2        0.25 ± 16%  perf-profile.self.cycles-pp.__mod_memcg_state
      0.00            +0.2        0.19 ± 12%  perf-profile.self.cycles-pp.clear_page_dirty_for_io
      0.00            +0.2        0.19 ± 16%  perf-profile.self.cycles-pp.update_sd_lb_stats
      0.00            +0.2        0.19 ± 19%  perf-profile.self.cycles-pp.down_read
      0.00            +0.2        0.19 ± 11%  perf-profile.self.cycles-pp.__radix_tree_lookup
      0.00            +0.2        0.20 ± 11%  perf-profile.self.cycles-pp.arch_scale_freq_tick
      0.06 ±  7%      +0.2        0.26 ± 16%  perf-profile.self.cycles-pp.f2fs_balance_fs
      0.00            +0.2        0.20 ± 13%  perf-profile.self.cycles-pp.___might_sleep
      0.00            +0.2        0.20 ±  7%  perf-profile.self.cycles-pp.brd_insert_page
      0.00            +0.2        0.20 ± 14%  perf-profile.self.cycles-pp.rcu_sched_clock_irq
      0.00            +0.2        0.20 ± 14%  perf-profile.self.cycles-pp.rebalance_domains
      0.04 ± 59%      +0.2        0.25 ± 22%  perf-profile.self.cycles-pp.calc_global_load_tick
      0.00            +0.2        0.21 ±  9%  perf-profile.self.cycles-pp.__test_set_page_writeback
      0.00            +0.2        0.21 ±  9%  perf-profile.self.cycles-pp.do_idle
      0.00            +0.2        0.22 ±  6%  perf-profile.self.cycles-pp.__radix_tree_preload
      0.01 ±173%      +0.2        0.25 ± 15%  perf-profile.self.cycles-pp.xas_load
      0.04 ± 58%      +0.2        0.28 ± 13%  perf-profile.self.cycles-pp.rmqueue_bulk
      0.00            +0.2        0.25 ± 28%  perf-profile.self.cycles-pp.tsc_verify_tsc_adjust
      0.00            +0.3        0.26 ± 13%  perf-profile.self.cycles-pp.perf_mux_hrtimer_handler
      0.00            +0.3        0.27 ± 11%  perf-profile.self.cycles-pp.f2fs_do_write_data_page
      0.00            +0.3        0.28 ±  8%  perf-profile.self.cycles-pp.f2fs_write_single_data_page
      0.00            +0.3        0.29 ± 19%  perf-profile.self.cycles-pp.f2fs_allocate_data_block
      0.01 ±173%      +0.3        0.31 ± 26%  perf-profile.self.cycles-pp.update_process_times
      0.00            +0.4        0.37 ±  9%  perf-profile.self.cycles-pp._raw_spin_unlock_irqrestore
      0.00            +0.4        0.37 ±  8%  perf-profile.self.cycles-pp.__intel_pmu_enable_all
      0.00            +0.4        0.38 ± 12%  perf-profile.self.cycles-pp.native_sched_clock
      0.00            +0.4        0.40 ± 11%  perf-profile.self.cycles-pp._raw_spin_trylock
      0.05 ±  9%      +0.4        0.46 ± 10%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.01 ±173%      +0.4        0.46 ± 10%  perf-profile.self.cycles-pp.read_tsc
      0.07 ± 17%      +0.5        0.53 ± 18%  perf-profile.self.cycles-pp.io_serial_in
      0.51 ± 10%      +0.5        1.03 ±  9%  perf-profile.self.cycles-pp.f2fs_write_end
      0.01 ±173%      +0.5        0.53 ± 12%  perf-profile.self.cycles-pp.lapic_next_deadline
      0.11 ± 31%      +0.5        0.63 ±  9%  perf-profile.self.cycles-pp.memcpy_erms
      0.00            +0.5        0.54 ±  6%  perf-profile.self.cycles-pp.clear_page_erms
      0.06 ± 14%      +0.6        0.63 ± 21%  perf-profile.self.cycles-pp.tick_nohz_next_event
      0.07 ± 21%      +0.7        0.73 ± 27%  perf-profile.self.cycles-pp.ktime_get_update_offsets_now
      0.06 ± 13%      +0.8        0.84 ±  7%  perf-profile.self.cycles-pp.native_irq_return_iret
      0.10 ± 18%      +1.1        1.25 ±  6%  perf-profile.self.cycles-pp.timekeeping_max_deferment
      1.09 ± 12%      +1.4        2.51 ± 10%  perf-profile.self.cycles-pp.copy_user_enhanced_fast_string
      0.10 ± 30%      +3.1        3.21 ±  4%  perf-profile.self.cycles-pp.menu_select
      0.36 ± 15%      +3.4        3.77 ± 27%  perf-profile.self.cycles-pp.ktime_get
      0.12 ± 27%      +3.6        3.69 ±  7%  perf-profile.self.cycles-pp.brd_do_bvec
      1.08 ±  8%      +4.1        5.14 ±  6%  perf-profile.self.cycles-pp._raw_spin_lock
      0.17 ± 23%      +4.9        5.07 ±  6%  perf-profile.self.cycles-pp.cpuidle_enter_state
      0.00            +7.2        7.20 ± 58%  perf-profile.self.cycles-pp.__cna_queued_spin_lock_slowpath
     28.92 ± 18%     +11.1       40.03 ± 11%  perf-profile.self.cycles-pp.intel_idle



***************************************************************************************************
lkp-csl-2ap3: 192 threads Intel(R) Xeon(R) Platinum 9242 CPU @ 2.30GHz with 192G memory
=========================================================================================
compiler/cpufreq_governor/kconfig/nr_task/rootfs/runtime/tbox_group/test/testcase/ucode:
  gcc-9/performance/x86_64-rhel-8.3/100%/debian-10.4-x86_64-20200603.cgz/300s/lkp-csl-2ap3/five_sec/reaim/0x5003003

commit: 
  268df4df6c ("locking/qspinlock: Refactor the qspinlock slow path")
  0dd6d5b8c0 ("locking/qspinlock: Introduce CNA into the slow path of qspinlock")

268df4df6cb0a27d 0dd6d5b8c0f6f31d8d557485fff 
---------------- --------------------------- 
       fail:runs  %reproduction    fail:runs
           |             |             |    
           :4           10%           0:4     perf-profile.children.cycles-pp.error_entry
         %stddev     %change         %stddev
             \          |                \  
      1771           -70.8%     518.05        reaim.child_systime
     15.13           +16.6%      17.64        reaim.child_utime
    116742          +112.6%     248179        reaim.jobs_per_min
    608.03          +112.6%       1292        reaim.jobs_per_min_child
     97.35           -37.3%      60.99        reaim.jti
    117467          +115.9%     253586        reaim.max_jobs_per_min
      9.77           -53.0%       4.60        reaim.parent_time
      2.09 ±  3%   +1738.8%      38.51        reaim.std_dev_percent
      0.20 ±  3%    +465.4%       1.13        reaim.std_dev_time
    572964           -49.2%     291007 ±  3%  reaim.time.involuntary_context_switches
     29867 ±  2%     +58.3%      47279        reaim.time.major_page_faults
 1.565e+08           +76.7%  2.766e+08        reaim.time.minor_page_faults
     15135           -46.6%       8077        reaim.time.percent_of_cpu_this_job_got
     46065           -48.3%      23832        reaim.time.system_time
    393.55          +106.3%     811.86        reaim.time.user_time
   1999169           +58.9%    3175727        reaim.time.voluntary_context_switches
    499200           +76.9%     883200        reaim.workload
   2360884 ±148%    +438.6%   12716743 ±106%  cpuidle.POLL.time
     17123          +119.2%      37541        uptime.idle
     19.83           +35.5       55.38        mpstat.cpu.all.idle%
      0.29            +1.7        1.96 ±  4%  mpstat.cpu.all.soft%
     78.08           -37.7       40.34        mpstat.cpu.all.sys%
      0.56            +0.4        0.94        mpstat.cpu.all.usr%
     20.00          +176.2%      55.25        vmstat.cpu.id
     79.00           -45.9%      42.75        vmstat.cpu.sy
    152.75           -25.5%     113.75        vmstat.procs.r
     17640           +76.7%      31162        vmstat.system.cs
     97089 ±  6%     -15.8%      81751 ±  8%  meminfo.Active
     97089 ±  6%     -15.8%      81751 ±  8%  meminfo.Active(anon)
    134087           +54.7%     207383        meminfo.KReclaimable
    134087           +54.7%     207383        meminfo.SReclaimable
    440546           +56.3%     688519        meminfo.SUnreclaim
    112379 ±  5%     -13.3%      97390 ±  7%  meminfo.Shmem
    574634           +55.9%     895903        meminfo.Slab
     13052           +19.7%      15621        meminfo.max_used_kB
  35213161           +82.3%   64191046 ± 36%  numa-numastat.node0.local_node
  35236478           +82.2%   64214320 ± 36%  numa-numastat.node0.numa_hit
  34909050          +116.0%   75401509 ± 34%  numa-numastat.node1.local_node
  34932425          +115.9%   75424911 ± 34%  numa-numastat.node1.numa_hit
  34863584           +74.5%   60838625 ± 34%  numa-numastat.node2.local_node
  34886970           +74.4%   60854278 ± 34%  numa-numastat.node2.numa_hit
  34852596           +39.0%   48437248 ±  6%  numa-numastat.node3.local_node
  34875967           +39.0%   48468348 ±  6%  numa-numastat.node3.numa_hit
    120172 ± 10%     +55.2%     186499 ± 35%  numa-meminfo.node0.SUnreclaim
    155552 ± 10%     +58.8%     247040 ± 35%  numa-meminfo.node0.Slab
    254390 ±  5%      -8.1%     233666        numa-meminfo.node1.FilePages
    108054 ± 11%     +83.9%     198659 ± 34%  numa-meminfo.node1.SUnreclaim
     30042 ± 38%     +85.9%      55861 ± 38%  numa-meminfo.node2.KReclaimable
     30042 ± 38%     +85.9%      55861 ± 38%  numa-meminfo.node2.SReclaimable
    104886 ± 15%     +66.0%     174156 ± 36%  numa-meminfo.node2.SUnreclaim
    134929 ± 20%     +70.5%     230018 ± 37%  numa-meminfo.node2.Slab
     92835 ±  5%     -16.7%      77357 ±  9%  numa-meminfo.node3.Active
     92835 ±  5%     -16.7%      77357 ±  9%  numa-meminfo.node3.Active(anon)
    106700 ± 10%     +22.8%     131060 ±  5%  numa-meminfo.node3.SUnreclaim
     97866 ±  6%     -13.9%      84302 ±  9%  numa-meminfo.node3.Shmem
    137163 ± 12%     +21.3%     166362 ±  4%  numa-meminfo.node3.Slab
     30056 ± 10%     +54.4%      46392 ± 35%  numa-vmstat.node0.nr_slab_unreclaimable
  18086907           +79.8%   32525740 ± 36%  numa-vmstat.node0.numa_hit
  18060414           +79.8%   32469658 ± 37%  numa-vmstat.node0.numa_local
     63597 ±  5%      -8.1%      58416        numa-vmstat.node1.nr_file_pages
     27039 ± 11%     +81.7%      49139 ± 35%  numa-vmstat.node1.nr_slab_unreclaimable
  17979353          +108.4%   37474352 ± 33%  numa-vmstat.node1.numa_hit
  17875692          +109.1%   37371374 ± 33%  numa-vmstat.node1.numa_local
      7510 ± 38%     +85.1%      13898 ± 38%  numa-vmstat.node2.nr_slab_reclaimable
     26245 ± 14%     +64.9%      43289 ± 36%  numa-vmstat.node2.nr_slab_unreclaimable
  17796933 ±  2%     +79.6%   31956941 ± 33%  numa-vmstat.node2.numa_hit
  17693688 ±  2%     +80.2%   31891353 ± 33%  numa-vmstat.node2.numa_local
     23226 ±  5%     -16.7%      19350 ±  9%  numa-vmstat.node3.nr_active_anon
     24534 ±  6%     -14.2%      21058 ±  8%  numa-vmstat.node3.nr_shmem
     26700 ± 10%     +21.7%      32500 ±  4%  numa-vmstat.node3.nr_slab_unreclaimable
     23226 ±  5%     -16.7%      19350 ±  9%  numa-vmstat.node3.nr_zone_active_anon
  17813416           +37.9%   24559652 ±  6%  numa-vmstat.node3.numa_hit
  17710159           +38.0%   24448079 ±  6%  numa-vmstat.node3.numa_local
     24225 ±  6%     -15.3%      20530 ±  9%  proc-vmstat.nr_active_anon
     75536            -5.9%      71082        proc-vmstat.nr_anon_pages
    268229            -1.4%     264602        proc-vmstat.nr_file_pages
     78690            -5.2%      74563        proc-vmstat.nr_inactive_anon
      5033            -9.0%       4579 ±  2%  proc-vmstat.nr_page_table_pages
     28090 ±  5%     -12.9%      24463 ±  8%  proc-vmstat.nr_shmem
     33501           +54.8%      51859        proc-vmstat.nr_slab_reclaimable
    109951           +56.7%     172284        proc-vmstat.nr_slab_unreclaimable
     24225 ±  6%     -15.3%      20530 ±  9%  proc-vmstat.nr_zone_active_anon
     78690            -5.2%      74563        proc-vmstat.nr_zone_inactive_anon
    113083 ±  8%     -69.7%      34247 ± 14%  proc-vmstat.numa_hint_faults
     27024 ± 23%     -71.3%       7758 ± 33%  proc-vmstat.numa_hint_faults_local
 1.399e+08           +77.9%   2.49e+08        proc-vmstat.numa_hit
 1.398e+08           +78.0%  2.489e+08        proc-vmstat.numa_local
     93068 ±  5%     -62.7%      34751 ± 33%  proc-vmstat.numa_pages_migrated
    204009 ±  4%     -42.8%     116790 ± 27%  proc-vmstat.numa_pte_updates
  1.46e+08           +80.1%  2.629e+08        proc-vmstat.pgalloc_normal
 1.578e+08           +76.1%  2.779e+08        proc-vmstat.pgfault
 1.461e+08           +80.0%   2.63e+08        proc-vmstat.pgfree
     93068 ±  5%     -62.7%      34751 ± 33%  proc-vmstat.pgmigrate_success
   5578083           +69.5%    9452210        proc-vmstat.pgreuse
    118031           -47.4%      62050 ±  9%  sched_debug.cfs_rq:/.exec_clock.avg
    119805           -41.9%      69568 ±  9%  sched_debug.cfs_rq:/.exec_clock.max
    115953           -52.4%      55183 ±  9%  sched_debug.cfs_rq:/.exec_clock.min
    523.14 ±  4%    +427.6%       2759 ±  2%  sched_debug.cfs_rq:/.exec_clock.stddev
     44392 ± 10%     +89.4%      84066 ± 28%  sched_debug.cfs_rq:/.load.stddev
    602.96 ± 15%     +32.1%     796.53 ± 10%  sched_debug.cfs_rq:/.load_avg.max
  23617146           -60.4%    9343623 ±  9%  sched_debug.cfs_rq:/.min_vruntime.avg
  23857829           -56.2%   10455870 ±  9%  sched_debug.cfs_rq:/.min_vruntime.max
  22828737           -64.3%    8142879 ± 10%  sched_debug.cfs_rq:/.min_vruntime.min
    115862 ±  5%    +345.9%     516599 ±  6%  sched_debug.cfs_rq:/.min_vruntime.stddev
     62.54           +33.3%      83.36 ± 10%  sched_debug.cfs_rq:/.nr_spread_over.avg
    102.12 ± 10%     +51.1%     154.27 ±  6%  sched_debug.cfs_rq:/.nr_spread_over.max
     34.88 ± 13%     +41.7%      49.42 ±  8%  sched_debug.cfs_rq:/.nr_spread_over.min
     11.05 ± 10%     +49.2%      16.49 ±  7%  sched_debug.cfs_rq:/.nr_spread_over.stddev
    361841 ± 23%    +272.3%    1347013 ± 29%  sched_debug.cfs_rq:/.spread0.max
    115875 ±  5%    +345.8%     516558 ±  6%  sched_debug.cfs_rq:/.spread0.stddev
   1219019 ±  9%     +23.4%    1503847 ± 10%  sched_debug.cpu.avg_idle.max
     82501 ± 58%     -90.9%       7518 ±162%  sched_debug.cpu.curr->pid.avg
    152874 ±  9%     -45.3%      83692 ±  8%  sched_debug.cpu.curr->pid.max
     23921 ± 39%     -72.6%       6545 ± 12%  sched_debug.cpu.curr->pid.stddev
    609138 ±  9%     +24.1%     755647 ± 10%  sched_debug.cpu.max_idle_balance_cost.max
     13212 ± 23%     +89.4%      25021 ± 24%  sched_debug.cpu.max_idle_balance_cost.stddev
     15459           +53.5%      23724 ±  8%  sched_debug.cpu.nr_switches.avg
     26961 ±  3%     +72.4%      46486 ± 11%  sched_debug.cpu.nr_switches.max
     11807 ±  4%     +37.1%      16183 ±  9%  sched_debug.cpu.nr_switches.min
      1955 ±  3%    +288.8%       7604 ± 20%  sched_debug.cpu.nr_switches.stddev
    -32.62           +25.9%     -41.07        sched_debug.cpu.nr_uninterruptible.min
     14448           +57.2%      22709 ±  8%  sched_debug.cpu.sched_count.avg
     22585 ±  5%     +95.3%      44113 ± 13%  sched_debug.cpu.sched_count.max
     11223 ±  4%     +36.2%      15288 ± 11%  sched_debug.cpu.sched_count.min
      1587          +371.7%       7488 ± 20%  sched_debug.cpu.sched_count.stddev
      4481          +129.3%      10275 ±  8%  sched_debug.cpu.sched_goidle.avg
      7977 ±  9%    +148.9%      19856 ± 13%  sched_debug.cpu.sched_goidle.max
      3308          +111.9%       7010 ± 11%  sched_debug.cpu.sched_goidle.min
    582.07 ±  4%    +438.8%       3136 ± 19%  sched_debug.cpu.sched_goidle.stddev
      5289           +33.8%       7075 ±  8%  sched_debug.cpu.ttwu_count.avg
      9614 ±  6%     +57.0%      15093 ±  8%  sched_debug.cpu.ttwu_count.max
    806.62 ±  4%    +183.4%       2285 ± 18%  sched_debug.cpu.ttwu_count.stddev
      2369           -13.5%       2048 ±  9%  sched_debug.cpu.ttwu_local.avg
      5461 ±  3%     -36.8%       3450 ± 16%  sched_debug.cpu.ttwu_local.max
      1732 ±  4%     -18.7%       1408 ± 10%  sched_debug.cpu.ttwu_local.min
    101323 ±  2%     +15.5%     116982 ±  2%  slabinfo.anon_vma.active_objs
      2208 ±  2%     +15.6%       2552 ±  2%  slabinfo.anon_vma.active_slabs
    101603 ±  2%     +15.6%     117419 ±  2%  slabinfo.anon_vma.num_objs
      2208 ±  2%     +15.6%       2552 ±  2%  slabinfo.anon_vma.num_slabs
    246717          +139.2%     590069 ±  3%  slabinfo.dentry.active_objs
      5936          +139.7%      14230 ±  3%  slabinfo.dentry.active_slabs
    249341          +139.7%     597683 ±  3%  slabinfo.dentry.num_objs
      5936          +139.7%      14230 ±  3%  slabinfo.dentry.num_slabs
      1201 ±  7%     +14.3%       1372 ±  2%  slabinfo.dmaengine-unmap-16.active_objs
      1201 ±  7%     +14.3%       1372 ±  2%  slabinfo.dmaengine-unmap-16.num_objs
     11757           +13.4%      13335        slabinfo.files_cache.active_objs
     11757           +13.4%      13335        slabinfo.files_cache.num_objs
    130963          +219.1%     417877 ±  4%  slabinfo.filp.active_objs
      2068          +219.5%       6610 ±  4%  slabinfo.filp.active_slabs
    132427          +219.5%     423071 ±  4%  slabinfo.filp.num_objs
      2068          +219.5%       6610 ±  4%  slabinfo.filp.num_slabs
    152432           +69.4%     258277        slabinfo.kmalloc-32.active_objs
      1190           +69.5%       2018        slabinfo.kmalloc-32.active_slabs
    152453           +69.5%     258423        slabinfo.kmalloc-32.num_objs
      1190           +69.5%       2018        slabinfo.kmalloc-32.num_slabs
     62400           +70.0%     106093        slabinfo.kmalloc-512.active_objs
      1006          +123.1%       2244 ±  3%  slabinfo.kmalloc-512.active_slabs
     64435          +123.0%     143670 ±  3%  slabinfo.kmalloc-512.num_objs
      1006          +123.1%       2244 ±  3%  slabinfo.kmalloc-512.num_slabs
    122191          +196.1%     361807 ±  5%  slabinfo.kmalloc-8.active_objs
    239.75          +199.8%     718.75 ±  5%  slabinfo.kmalloc-8.active_slabs
    122884          +199.7%     368278 ±  5%  slabinfo.kmalloc-8.num_objs
    239.75          +199.8%     718.75 ±  5%  slabinfo.kmalloc-8.num_slabs
      8538           +14.4%       9765        slabinfo.mm_struct.active_objs
      8538           +14.6%       9784        slabinfo.mm_struct.num_objs
     39908 ±  2%    +158.3%     103082 ±  3%  slabinfo.pid.active_objs
    623.00 ±  2%    +159.1%       1614 ±  3%  slabinfo.pid.active_slabs
     39908 ±  2%    +159.0%     103367 ±  3%  slabinfo.pid.num_objs
    623.00 ±  2%    +159.1%       1614 ±  3%  slabinfo.pid.num_slabs
     23288           +77.8%      41415        slabinfo.radix_tree_node.active_objs
    415.25           +78.2%     740.00        slabinfo.radix_tree_node.active_slabs
     23288           +78.0%      41461        slabinfo.radix_tree_node.num_objs
    415.25           +78.2%     740.00        slabinfo.radix_tree_node.num_slabs
     64504           +25.6%      80986        slabinfo.shmem_inode_cache.active_objs
      1407           +26.0%       1773        slabinfo.shmem_inode_cache.active_slabs
     64754           +26.0%      81582        slabinfo.shmem_inode_cache.num_objs
      1407           +26.0%       1773        slabinfo.shmem_inode_cache.num_slabs
     21092           +19.1%      25120        slabinfo.signal_cache.active_objs
    762.00           +20.2%     916.00        slabinfo.signal_cache.active_slabs
     21351           +20.2%      25665        slabinfo.signal_cache.num_objs
    762.00           +20.2%     916.00        slabinfo.signal_cache.num_slabs
     43205          +119.4%      94801 ±  2%  slabinfo.task_delay_info.active_objs
    846.75          +120.5%       1867 ±  2%  slabinfo.task_delay_info.active_slabs
     43205          +120.5%      95250 ±  2%  slabinfo.task_delay_info.num_objs
    846.75          +120.5%       1867 ±  2%  slabinfo.task_delay_info.num_slabs
      3143          +202.8%       9517 ±  3%  slabinfo.task_struct.active_objs
      3152          +202.2%       9526 ±  3%  slabinfo.task_struct.active_slabs
      3152          +202.2%       9526 ±  3%  slabinfo.task_struct.num_objs
      3152          +202.2%       9526 ±  3%  slabinfo.task_struct.num_slabs
     26998 ±  2%     +20.1%      32423 ±  4%  slabinfo.vmap_area.active_objs
     31259 ±  2%     +17.1%      36614 ±  3%  slabinfo.vmap_area.num_objs
      6.27 ± 46%    +278.8%      23.75 ± 61%  perf-stat.i.MPKI
      0.83 ± 40%      +1.9        2.70 ± 52%  perf-stat.i.branch-miss-rate%
  53484421 ±  5%     +99.9%  1.069e+08 ± 13%  perf-stat.i.branch-misses
     37.48 ±  4%     -26.9       10.57 ± 29%  perf-stat.i.cache-miss-rate%
  69142920           -55.6%   30725834 ±  6%  perf-stat.i.cache-misses
 1.819e+08 ±  5%    +118.6%  3.977e+08 ± 13%  perf-stat.i.cache-references
     17756          +100.2%      35543 ±  8%  perf-stat.i.context-switches
      8.88           -33.6%       5.90 ±  8%  perf-stat.i.cpi
    192079           +32.6%     254627 ±  5%  perf-stat.i.cpu-clock
 4.689e+11           -24.4%  3.545e+11 ±  8%  perf-stat.i.cpu-cycles
      2423           +90.1%       4607 ±  7%  perf-stat.i.cpu-migrations
      6380           +12.6%       7182        perf-stat.i.cycles-between-cache-misses
      0.04 ±104%      +0.2        0.20 ± 86%  perf-stat.i.dTLB-load-miss-rate%
   1574256 ± 22%    +159.7%    4088485 ± 31%  perf-stat.i.dTLB-load-misses
   1969369 ±  2%    +113.9%    4212594 ± 10%  perf-stat.i.dTLB-store-misses
   1.5e+09          +104.7%   3.07e+09 ±  7%  perf-stat.i.dTLB-stores
     74.01            -7.9       66.12 ±  7%  perf-stat.i.iTLB-load-miss-rate%
   6669058           +79.2%   11948496 ±  5%  perf-stat.i.iTLB-load-misses
   2408534 ±  5%    +137.9%    5729434 ± 12%  perf-stat.i.iTLB-loads
      7261           -59.8%       2917 ±  2%  perf-stat.i.instructions-per-iTLB-miss
      0.13 ±  3%     +44.1%       0.19 ±  8%  perf-stat.i.ipc
     97.97 ±  2%     +82.9%     179.13 ±  6%  perf-stat.i.major-faults
      2.44           -58.1%       1.02        perf-stat.i.metric.GHz
      0.26          +158.5%       0.68 ±  3%  perf-stat.i.metric.K/sec
    128.29           -35.1%      83.26        perf-stat.i.metric.M/sec
    504405          +110.0%    1059332 ±  8%  perf-stat.i.minor-faults
     93.85           -13.0       80.89        perf-stat.i.node-load-miss-rate%
  17976707           -65.3%    6230109 ±  5%  perf-stat.i.node-load-misses
   1095630           +53.9%    1686234 ±  9%  perf-stat.i.node-loads
     91.46           -28.9       62.52 ±  3%  perf-stat.i.node-store-miss-rate%
   9301773           -67.3%    3045362 ±  6%  perf-stat.i.node-store-misses
    692164          +240.0%    2353479 ± 10%  perf-stat.i.node-stores
    504503          +110.0%    1059512 ±  8%  perf-stat.i.page-faults
    192079           +32.6%     254627 ±  5%  perf-stat.i.task-clock
      3.71 ±  5%    +119.9%       8.15 ±  5%  perf-stat.overall.MPKI
      0.47 ±  4%      +0.5        1.02 ±  4%  perf-stat.overall.branch-miss-rate%
     38.25 ±  5%     -29.7        8.51 ±  5%  perf-stat.overall.cache-miss-rate%
      9.65           -32.3%       6.53        perf-stat.overall.cpi
      6824           +38.5%       9450        perf-stat.overall.cycles-between-cache-misses
      0.01 ± 22%      +0.0        0.03 ± 21%  perf-stat.overall.dTLB-load-miss-rate%
      0.13 ±  2%      +0.0        0.14 ±  2%  perf-stat.overall.dTLB-store-miss-rate%
     73.76            -5.8       67.91 ±  3%  perf-stat.overall.iTLB-load-miss-rate%
      7379           -44.4%       4105 ±  2%  perf-stat.overall.instructions-per-iTLB-miss
      0.10           +47.6%       0.15        perf-stat.overall.ipc
     94.26           -16.0       78.28        perf-stat.overall.node-load-miss-rate%
     93.10           -33.9       59.17        perf-stat.overall.node-store-miss-rate%
  30302770           -53.1%   14206881        perf-stat.overall.path-length
 1.133e+10           -23.4%  8.682e+09        perf-stat.ps.branch-instructions
  53498099 ±  4%     +65.3%   88446761 ±  4%  perf-stat.ps.branch-misses
  69435563           -59.2%   28312760        perf-stat.ps.cache-misses
 1.821e+08 ±  5%     +83.3%  3.337e+08 ±  5%  perf-stat.ps.cache-references
     17681           +68.8%      29846        perf-stat.ps.context-switches
 4.738e+11           -43.5%  2.675e+11        perf-stat.ps.cpu-cycles
      2419           +54.0%       3726        perf-stat.ps.cpu-migrations
   1578839 ± 22%    +103.0%    3204266 ± 21%  perf-stat.ps.dTLB-load-misses
 1.178e+10           -20.9%  9.321e+09        perf-stat.ps.dTLB-loads
   1972309 ±  2%     +79.1%    3532579 ±  2%  perf-stat.ps.dTLB-store-misses
 1.503e+09           +71.6%  2.579e+09        perf-stat.ps.dTLB-stores
   6656060           +49.9%    9978306 ±  2%  perf-stat.ps.iTLB-load-misses
   2370133 ±  5%    +100.0%    4739316 ± 11%  perf-stat.ps.iTLB-loads
 4.911e+10           -16.6%  4.094e+10        perf-stat.ps.instructions
     97.73 ±  2%     +58.8%     155.19 ±  2%  perf-stat.ps.major-faults
    505543           +77.0%     894842        perf-stat.ps.minor-faults
  18036059           -68.0%    5777695 ±  2%  perf-stat.ps.node-load-misses
   1098333           +45.9%    1602654        perf-stat.ps.node-loads
   9342877           -69.0%    2896320        perf-stat.ps.node-store-misses
    692364          +188.6%    1998374        perf-stat.ps.node-stores
    505641           +77.0%     894997        perf-stat.ps.page-faults
 1.513e+13           -17.1%  1.255e+13        perf-stat.total.instructions
     90.69           -90.7        0.00        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.scan_positives.dcache_readdir.iterate_dir
     91.31           -71.2       20.15 ±  7%  perf-profile.calltrace.cycles-pp.scan_positives.dcache_readdir.iterate_dir.__x64_sys_getdents64.do_syscall_64
     92.77           -71.1       21.68 ±  8%  perf-profile.calltrace.cycles-pp.dcache_readdir.iterate_dir.__x64_sys_getdents64.do_syscall_64.entry_SYSCALL_64_after_hwframe
     92.77           -71.1       21.69 ±  8%  perf-profile.calltrace.cycles-pp.iterate_dir.__x64_sys_getdents64.do_syscall_64.entry_SYSCALL_64_after_hwframe
     92.77           -71.1       21.69 ±  8%  perf-profile.calltrace.cycles-pp.__x64_sys_getdents64.do_syscall_64.entry_SYSCALL_64_after_hwframe
     90.99           -71.0       19.95 ±  7%  perf-profile.calltrace.cycles-pp._raw_spin_lock.scan_positives.dcache_readdir.iterate_dir.__x64_sys_getdents64
     94.97           -69.9       25.10 ±  9%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe
     95.03           -69.9       25.15 ±  9%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.26 ±100%      +0.4        0.71 ±  7%  perf-profile.calltrace.cycles-pp.__x64_sys_exit_group.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.26 ±100%      +0.4        0.71 ±  7%  perf-profile.calltrace.cycles-pp.do_group_exit.__x64_sys_exit_group.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.26 ±100%      +0.4        0.71 ±  7%  perf-profile.calltrace.cycles-pp.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +0.6        0.60 ±  8%  perf-profile.calltrace.cycles-pp.mmput.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      0.00            +0.6        0.60 ±  8%  perf-profile.calltrace.cycles-pp.exit_mmap.mmput.do_exit.do_group_exit.__x64_sys_exit_group
      0.00            +0.7        0.68 ± 13%  perf-profile.calltrace.cycles-pp.drain_obj_stock.refill_obj_stock.kmem_cache_free.rcu_do_batch.rcu_core
      0.13 ±173%      +0.7        0.85 ±  6%  perf-profile.calltrace.cycles-pp.exec_binprm.bprm_execve.do_execveat_common.__x64_sys_execve.do_syscall_64
      0.13 ±173%      +0.7        0.85 ±  6%  perf-profile.calltrace.cycles-pp.load_elf_binary.exec_binprm.bprm_execve.do_execveat_common.__x64_sys_execve
      0.00            +0.7        0.74 ± 22%  perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter.do_idle
      0.00            +0.7        0.74 ±  2%  perf-profile.calltrace.cycles-pp.add_short.add_short
      0.00            +0.8        0.81 ± 16%  perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry
      0.00            +0.8        0.82 ± 15%  perf-profile.calltrace.cycles-pp.refill_obj_stock.kmem_cache_free.rcu_do_batch.rcu_core.__softirqentry_text_start
      0.00            +1.1        1.14 ± 47%  perf-profile.calltrace.cycles-pp.do_dentry_open.path_openat.do_filp_open.do_sys_openat2.do_sys_open
      0.00            +1.4        1.42 ± 39%  perf-profile.calltrace.cycles-pp.__cna_queued_spin_lock_slowpath._raw_spin_lock.dcache_readdir.iterate_dir.__x64_sys_getdents64
      0.00            +2.1        2.13 ± 16%  perf-profile.calltrace.cycles-pp.kmem_cache_free.rcu_do_batch.rcu_core.__softirqentry_text_start.run_ksoftirqd
      0.00            +2.3        2.29 ± 16%  perf-profile.calltrace.cycles-pp.rcu_do_batch.rcu_core.__softirqentry_text_start.run_ksoftirqd.smpboot_thread_fn
      0.00            +2.3        2.29 ± 16%  perf-profile.calltrace.cycles-pp.__softirqentry_text_start.run_ksoftirqd.smpboot_thread_fn.kthread.ret_from_fork
      0.00            +2.3        2.29 ± 16%  perf-profile.calltrace.cycles-pp.rcu_core.__softirqentry_text_start.run_ksoftirqd.smpboot_thread_fn.kthread
      0.00            +2.3        2.29 ± 16%  perf-profile.calltrace.cycles-pp.run_ksoftirqd.smpboot_thread_fn.kthread.ret_from_fork
      0.00            +2.4        2.42 ± 14%  perf-profile.calltrace.cycles-pp.smpboot_thread_fn.kthread.ret_from_fork
      0.00            +2.5        2.47 ± 14%  perf-profile.calltrace.cycles-pp.kthread.ret_from_fork
      0.00            +2.5        2.47 ± 14%  perf-profile.calltrace.cycles-pp.ret_from_fork
      0.00            +3.2        3.25 ± 40%  perf-profile.calltrace.cycles-pp._raw_spin_lock.lockref_put_or_lock.dput.step_into.path_openat
      0.00            +3.2        3.25 ± 40%  perf-profile.calltrace.cycles-pp.__cna_queued_spin_lock_slowpath._raw_spin_lock.lockref_put_or_lock.dput.step_into
      0.00            +3.3        3.25 ± 39%  perf-profile.calltrace.cycles-pp.dput.step_into.path_openat.do_filp_open.do_open_execat
      0.00            +3.3        3.25 ± 39%  perf-profile.calltrace.cycles-pp.lockref_put_or_lock.dput.step_into.path_openat.do_filp_open
      1.50 ± 28%      +6.2        7.71 ±  9%  perf-profile.calltrace.cycles-pp.intel_idle.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry
      1.68 ± 26%      +6.9        8.59 ±  6%  perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry.start_secondary
      1.71 ± 26%      +6.9        8.66 ±  6%  perf-profile.calltrace.cycles-pp.cpuidle_enter.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      1.79 ± 26%      +7.1        8.91 ±  6%  perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      1.79 ± 26%      +7.1        8.91 ±  6%  perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      1.79 ± 26%      +7.1        8.91 ±  6%  perf-profile.calltrace.cycles-pp.start_secondary.secondary_startup_64_no_verify
      1.80 ± 26%      +7.2        8.97 ±  6%  perf-profile.calltrace.cycles-pp.secondary_startup_64_no_verify
      0.00            +9.7        9.72 ± 10%  perf-profile.calltrace.cycles-pp._raw_spin_lock.lockref_get_not_dead.__legitimize_path.unlazy_walk.complete_walk
      0.00            +9.7        9.73 ± 10%  perf-profile.calltrace.cycles-pp.unlazy_walk.complete_walk.path_openat.do_filp_open.do_sys_openat2
      0.00            +9.7        9.73 ± 10%  perf-profile.calltrace.cycles-pp.__legitimize_path.unlazy_walk.complete_walk.path_openat.do_filp_open
      0.00            +9.7        9.73 ± 10%  perf-profile.calltrace.cycles-pp.lockref_get_not_dead.__legitimize_path.unlazy_walk.complete_walk.path_openat
      0.00            +9.7        9.73 ± 10%  perf-profile.calltrace.cycles-pp.complete_walk.path_openat.do_filp_open.do_sys_openat2.do_sys_open
      0.00           +11.1       11.09 ± 10%  perf-profile.calltrace.cycles-pp.do_filp_open.do_sys_openat2.do_sys_open.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00           +11.1       11.09 ± 10%  perf-profile.calltrace.cycles-pp.path_openat.do_filp_open.do_sys_openat2.do_sys_open.do_syscall_64
      0.00           +11.1       11.09 ± 10%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__open64_nocancel
      0.00           +11.1       11.09 ± 10%  perf-profile.calltrace.cycles-pp.do_sys_open.do_syscall_64.entry_SYSCALL_64_after_hwframe.__open64_nocancel
      0.00           +11.1       11.09 ± 10%  perf-profile.calltrace.cycles-pp.do_sys_openat2.do_sys_open.do_syscall_64.entry_SYSCALL_64_after_hwframe.__open64_nocancel
      0.00           +11.1       11.10 ± 10%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__open64_nocancel
      0.00           +11.1       11.10 ± 10%  perf-profile.calltrace.cycles-pp.__open64_nocancel
      0.00           +19.5       19.48 ±  7%  perf-profile.calltrace.cycles-pp.__cna_queued_spin_lock_slowpath._raw_spin_lock.scan_positives.dcache_readdir.iterate_dir
      0.00           +43.8       43.85 ±  8%  perf-profile.calltrace.cycles-pp._raw_spin_lock.lockref_get_not_dead.__legitimize_path.unlazy_walk.pick_link
      0.00           +43.9       43.86 ±  8%  perf-profile.calltrace.cycles-pp.unlazy_walk.pick_link.step_into.path_openat.do_filp_open
      0.00           +43.9       43.86 ±  8%  perf-profile.calltrace.cycles-pp.__legitimize_path.unlazy_walk.pick_link.step_into.path_openat
      0.00           +43.9       43.86 ±  8%  perf-profile.calltrace.cycles-pp.lockref_get_not_dead.__legitimize_path.unlazy_walk.pick_link.step_into
      0.00           +43.9       43.86 ±  8%  perf-profile.calltrace.cycles-pp.pick_link.step_into.path_openat.do_filp_open.do_open_execat
      0.64 ±  3%     +47.1       47.69 ±  9%  perf-profile.calltrace.cycles-pp.do_execveat_common.__x64_sys_execve.do_syscall_64.entry_SYSCALL_64_after_hwframe.execve
      0.65 ±  4%     +47.1       47.70 ±  9%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.execve
      0.65 ±  4%     +47.1       47.70 ±  9%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.execve
      0.65 ±  4%     +47.1       47.70 ±  9%  perf-profile.calltrace.cycles-pp.__x64_sys_execve.do_syscall_64.entry_SYSCALL_64_after_hwframe.execve
      0.65 ±  3%     +47.1       47.71 ±  9%  perf-profile.calltrace.cycles-pp.execve
      0.00           +47.3       47.28 ±  8%  perf-profile.calltrace.cycles-pp.step_into.path_openat.do_filp_open.do_open_execat.bprm_execve
      0.00           +47.3       47.29 ±  8%  perf-profile.calltrace.cycles-pp.do_filp_open.do_open_execat.bprm_execve.do_execveat_common.__x64_sys_execve
      0.00           +47.3       47.29 ±  8%  perf-profile.calltrace.cycles-pp.path_openat.do_filp_open.do_open_execat.bprm_execve.do_execveat_common
      0.00           +47.3       47.29 ±  8%  perf-profile.calltrace.cycles-pp.do_open_execat.bprm_execve.do_execveat_common.__x64_sys_execve.do_syscall_64
      0.59 ±  3%     +47.6       48.23 ±  7%  perf-profile.calltrace.cycles-pp.bprm_execve.do_execveat_common.__x64_sys_execve.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00           +53.6       53.57 ±  6%  perf-profile.calltrace.cycles-pp.__cna_queued_spin_lock_slowpath._raw_spin_lock.lockref_get_not_dead.__legitimize_path.unlazy_walk
     93.06           -93.1        0.00        perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
     91.31           -71.2       20.15 ±  7%  perf-profile.children.cycles-pp.scan_positives
     92.77           -71.1       21.68 ±  8%  perf-profile.children.cycles-pp.dcache_readdir
     92.77           -71.1       21.69 ±  8%  perf-profile.children.cycles-pp.iterate_dir
     92.77           -71.1       21.69 ±  8%  perf-profile.children.cycles-pp.__x64_sys_getdents64
     93.41           -12.9       80.56        perf-profile.children.cycles-pp._raw_spin_lock
     96.88           -11.1       85.79        perf-profile.children.cycles-pp.do_syscall_64
     97.00           -10.9       86.06        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.18 ±  9%      +0.0        0.21 ±  7%  perf-profile.children.cycles-pp.__x64_sys_mprotect
      0.18 ±  9%      +0.0        0.21 ±  7%  perf-profile.children.cycles-pp.do_mprotect_pkey
      0.06 ±  7%      +0.0        0.09 ±  4%  perf-profile.children.cycles-pp.kill_pid_info
      0.06 ± 13%      +0.0        0.10 ±  4%  perf-profile.children.cycles-pp.__x64_sys_kill
      0.06 ±  7%      +0.0        0.10 ±  8%  perf-profile.children.cycles-pp.kill_something_info
      0.05 ±  9%      +0.0        0.10 ±  8%  perf-profile.children.cycles-pp.update_cfs_group
      0.03 ±100%      +0.0        0.07 ±  5%  perf-profile.children.cycles-pp.vma_interval_tree_insert
      0.03 ±100%      +0.0        0.07 ±  5%  perf-profile.children.cycles-pp.wake_up_new_task
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.__xstat64
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.copy_fpstate_to_sigframe
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.creat64
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.__pagevec_lru_add_fn
      0.04 ± 57%      +0.1        0.09 ±  7%  perf-profile.children.cycles-pp.mem_cgroup_uncharge_list
      0.00            +0.1        0.05 ±  8%  perf-profile.children.cycles-pp.page_add_file_rmap
      0.00            +0.1        0.05 ±  8%  perf-profile.children.cycles-pp.lru_cache_add
      0.00            +0.1        0.05 ±  8%  perf-profile.children.cycles-pp.restore_sigcontext
      0.06 ± 14%      +0.1        0.11 ±  3%  perf-profile.children.cycles-pp.find_idlest_group
      0.04 ± 57%      +0.1        0.09 ±  4%  perf-profile.children.cycles-pp.copy_page_range
      0.00            +0.1        0.05 ±  9%  perf-profile.children.cycles-pp.sched_exec
      0.00            +0.1        0.05 ±  9%  perf-profile.children.cycles-pp.finish_task_switch
      0.00            +0.1        0.05 ±  9%  perf-profile.children.cycles-pp.__slab_free
      0.00            +0.1        0.05 ±  9%  perf-profile.children.cycles-pp.schedule
      0.03 ±100%      +0.1        0.08        perf-profile.children.cycles-pp.__memcg_kmem_charge_page
      0.00            +0.1        0.06 ±  9%  perf-profile.children.cycles-pp.lru_add_drain
      0.00            +0.1        0.06 ±  9%  perf-profile.children.cycles-pp.lru_add_drain_cpu
      0.00            +0.1        0.06 ±  9%  perf-profile.children.cycles-pp.flush_tlb_mm_range
      0.00            +0.1        0.06 ±  9%  perf-profile.children.cycles-pp.newidle_balance
      0.04 ± 58%      +0.1        0.10 ±  4%  perf-profile.children.cycles-pp.lookup_fast
      0.00            +0.1        0.06 ± 15%  perf-profile.children.cycles-pp.vfs_write
      0.00            +0.1        0.06 ± 15%  perf-profile.children.cycles-pp.update_rq_clock
      0.07 ±  7%      +0.1        0.12 ±  3%  perf-profile.children.cycles-pp.select_task_rq_fair
      0.00            +0.1        0.06 ±  7%  perf-profile.children.cycles-pp.down_write
      0.00            +0.1        0.06 ±  7%  perf-profile.children.cycles-pp.copy_pte_range
      0.00            +0.1        0.06 ±  7%  perf-profile.children.cycles-pp.__clear_user
      0.00            +0.1        0.06 ±  7%  perf-profile.children.cycles-pp.pick_next_task_fair
      0.00            +0.1        0.06 ±  7%  perf-profile.children.cycles-pp.find_busiest_group
      0.00            +0.1        0.06 ±  7%  perf-profile.children.cycles-pp.update_sd_lb_stats
      0.00            +0.1        0.06 ± 14%  perf-profile.children.cycles-pp.ksys_write
      0.05 ± 58%      +0.1        0.11 ± 10%  perf-profile.children.cycles-pp.page_counter_try_charge
      0.04 ± 57%      +0.1        0.10 ±  4%  perf-profile.children.cycles-pp.__memcg_kmem_charge
      0.06 ±  6%      +0.1        0.12 ± 48%  perf-profile.children.cycles-pp.task_work_run
      0.00            +0.1        0.06        perf-profile.children.cycles-pp.do_wait
      0.00            +0.1        0.06        perf-profile.children.cycles-pp.getname_flags
      0.00            +0.1        0.06        perf-profile.children.cycles-pp.__setup_rt_frame
      0.00            +0.1        0.06        perf-profile.children.cycles-pp.__mmap
      0.00            +0.1        0.06        perf-profile.children.cycles-pp.pte_alloc_one
      0.00            +0.1        0.06 ±  6%  perf-profile.children.cycles-pp.__do_sys_wait4
      0.00            +0.1        0.06 ±  6%  perf-profile.children.cycles-pp.kernel_wait4
      0.00            +0.1        0.06 ±  6%  perf-profile.children.cycles-pp.find_vma
      0.00            +0.1        0.06 ±  6%  perf-profile.children.cycles-pp.update_load_avg
      0.00            +0.1        0.06 ±  6%  perf-profile.children.cycles-pp.try_charge
      0.15 ±  8%      +0.1        0.22 ±  5%  perf-profile.children.cycles-pp.task_tick_fair
      0.01 ±173%      +0.1        0.08 ±  5%  perf-profile.children.cycles-pp.sync
      0.01 ±173%      +0.1        0.08 ±  5%  perf-profile.children.cycles-pp.__x64_sys_sync
      0.01 ±173%      +0.1        0.08 ±  5%  perf-profile.children.cycles-pp.ksys_sync
      0.01 ±173%      +0.1        0.08 ±  5%  perf-profile.children.cycles-pp.iterate_supers
      0.00            +0.1        0.07 ±  7%  perf-profile.children.cycles-pp.__vm_munmap
      0.01 ±173%      +0.1        0.08 ±  5%  perf-profile.children.cycles-pp.anon_vma_clone
      0.05 ±  8%      +0.1        0.12 ±  5%  perf-profile.children.cycles-pp._dl_addr
      0.01 ±173%      +0.1        0.08 ±  8%  perf-profile.children.cycles-pp.uncharge_batch
      0.00            +0.1        0.07 ± 21%  perf-profile.children.cycles-pp.irq_enter_rcu
      0.04 ± 58%      +0.1        0.11 ±  3%  perf-profile.children.cycles-pp.anon_vma_fork
      0.07 ± 13%      +0.1        0.14 ±  8%  perf-profile.children.cycles-pp.mem_cgroup_charge
      0.06 ±  9%      +0.1        0.12 ±  4%  perf-profile.children.cycles-pp.__schedule
      0.00            +0.1        0.07        perf-profile.children.cycles-pp.sync_regs
      0.00            +0.1        0.07 ± 15%  perf-profile.children.cycles-pp.__put_task_struct
      0.00            +0.1        0.07 ± 11%  perf-profile.children.cycles-pp.load_balance
      0.04 ± 58%      +0.1        0.11 ±  4%  perf-profile.children.cycles-pp.page_remove_rmap
      0.07 ± 20%      +0.1        0.15 ±  5%  perf-profile.children.cycles-pp.d_alloc
      0.00            +0.1        0.08 ±  6%  perf-profile.children.cycles-pp.obj_cgroup_charge
      0.00            +0.1        0.08 ±  6%  perf-profile.children.cycles-pp.sighandler
      0.05 ±  8%      +0.1        0.13 ±  5%  perf-profile.children.cycles-pp.arch_do_signal
      0.00            +0.1        0.08 ±  5%  perf-profile.children.cycles-pp.__x64_sys_rt_sigreturn
      0.04 ± 58%      +0.1        0.12 ±  5%  perf-profile.children.cycles-pp.remove_vma
      0.04 ± 58%      +0.1        0.12 ±  3%  perf-profile.children.cycles-pp.load_elf_interp
      0.00            +0.1        0.08 ±  8%  perf-profile.children.cycles-pp.copy_strings
      0.07 ± 17%      +0.1        0.15 ±  2%  perf-profile.children.cycles-pp.elf_map
      0.08 ± 11%      +0.1        0.16 ±  5%  perf-profile.children.cycles-pp.alloc_empty_file
      0.00            +0.1        0.08 ±  5%  perf-profile.children.cycles-pp.___might_sleep
      0.08 ± 11%      +0.1        0.16 ±  4%  perf-profile.children.cycles-pp.setlocale
      0.07 ± 11%      +0.1        0.16 ±  5%  perf-profile.children.cycles-pp.__alloc_file
      0.00            +0.1        0.09 ±  5%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      0.00            +0.1        0.09 ±  5%  perf-profile.children.cycles-pp.clear_page_erms
      0.00            +0.1        0.09 ±  5%  perf-profile.children.cycles-pp.alloc_set_pte
      0.06 ± 13%      +0.1        0.15 ±  4%  perf-profile.children.cycles-pp.unlink_anon_vmas
      0.00            +0.1        0.09 ±  9%  perf-profile.children.cycles-pp.perf_event_mmap
      0.06 ±  9%      +0.1        0.14 ±  3%  perf-profile.children.cycles-pp.get_page_from_freelist
      0.03 ±100%      +0.1        0.11 ±  4%  perf-profile.children.cycles-pp.__mod_memcg_lruvec_state
      0.00            +0.1        0.09 ±  7%  perf-profile.children.cycles-pp.__mod_memcg_state
      0.00            +0.1        0.09 ±  7%  perf-profile.children.cycles-pp.wp_page_copy
      0.11 ± 11%      +0.1        0.20 ±  4%  perf-profile.children.cycles-pp.filename_lookup
      0.00            +0.1        0.09 ±  4%  perf-profile.children.cycles-pp.vm_area_dup
      0.00            +0.1        0.09 ±  4%  perf-profile.children.cycles-pp.filldir64
      0.00            +0.1        0.09 ±  4%  perf-profile.children.cycles-pp.__d_alloc
      0.11 ± 17%      +0.1        0.20 ±  7%  perf-profile.children.cycles-pp.d_alloc_parallel
      0.00            +0.1        0.10 ±  5%  perf-profile.children.cycles-pp.prep_new_page
      0.10 ± 14%      +0.1        0.20 ±  4%  perf-profile.children.cycles-pp.path_lookupat
      0.08 ± 10%      +0.1        0.18        perf-profile.children.cycles-pp.native_irq_return_iret
      0.11 ± 11%      +0.1        0.21 ±  3%  perf-profile.children.cycles-pp.vfs_statx
      0.11 ± 10%      +0.1        0.21 ±  5%  perf-profile.children.cycles-pp.__do_sys_newstat
      0.01 ±173%      +0.1        0.11 ±  7%  perf-profile.children.cycles-pp.alloc_pages_vma
      0.00            +0.1        0.10 ±  4%  perf-profile.children.cycles-pp.pagevec_lru_move_fn
      0.12 ± 16%      +0.1        0.22 ±  5%  perf-profile.children.cycles-pp.__lookup_slow
      0.01 ±173%      +0.1        0.12 ±  5%  perf-profile.children.cycles-pp.get_obj_cgroup_from_current
      0.23 ±  6%      +0.1        0.34 ±  6%  perf-profile.children.cycles-pp.scheduler_tick
      0.00            +0.1        0.11 ±  3%  perf-profile.children.cycles-pp.do_brk_flags
      0.05 ± 60%      +0.1        0.18 ± 34%  perf-profile.children.cycles-pp.menu_select
      0.00            +0.1        0.13 ±  3%  perf-profile.children.cycles-pp.cna_order_queue
      0.10 ±  8%      +0.1        0.24        perf-profile.children.cycles-pp.__alloc_pages_nodemask
      0.12 ±  9%      +0.1        0.25 ± 24%  perf-profile.children.cycles-pp.exit_to_user_mode_prepare
      0.41 ± 10%      +0.1        0.55 ±  7%  perf-profile.children.cycles-pp.dup_mmap
      0.42 ±  9%      +0.1        0.56 ±  7%  perf-profile.children.cycles-pp.begin_new_exec
      0.26 ±  8%      +0.1        0.40 ±  4%  perf-profile.children.cycles-pp.__libc_fork
      0.14 ± 10%      +0.1        0.28 ±  4%  perf-profile.children.cycles-pp.zap_pte_range
      0.12 ±  9%      +0.1        0.26 ± 24%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      0.10 ±  8%      +0.1        0.25 ±  4%  perf-profile.children.cycles-pp.release_pages
      0.41 ±  9%      +0.1        0.56 ±  7%  perf-profile.children.cycles-pp.dup_mm
      0.27 ± 11%      +0.1        0.42 ±  4%  perf-profile.children.cycles-pp.unmap_region
      0.16 ±  8%      +0.1        0.31 ±  3%  perf-profile.children.cycles-pp.unmap_vmas
      0.15 ±  9%      +0.1        0.30 ±  4%  perf-profile.children.cycles-pp.unmap_page_range
      0.40 ±  2%      +0.2        0.55 ±  6%  perf-profile.children.cycles-pp.tick_sched_timer
      0.32 ±  7%      +0.2        0.47 ±  5%  perf-profile.children.cycles-pp.update_process_times
      0.10 ± 11%      +0.2        0.25 ±  4%  perf-profile.children.cycles-pp.kill
      0.32 ±  5%      +0.2        0.48 ±  7%  perf-profile.children.cycles-pp.tick_sched_handle
      0.13 ±  9%      +0.2        0.30 ±  2%  perf-profile.children.cycles-pp.tlb_finish_mmu
      0.13 ±  8%      +0.2        0.30 ±  4%  perf-profile.children.cycles-pp.tlb_flush_mmu
      0.04 ± 57%      +0.2        0.22 ± 12%  perf-profile.children.cycles-pp.propagate_protected_usage
      0.47 ±  2%      +0.2        0.66 ±  7%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      0.23 ± 13%      +0.2        0.42 ±  4%  perf-profile.children.cycles-pp.walk_component
      0.18 ± 12%      +0.2        0.38 ±  3%  perf-profile.children.cycles-pp.filemap_map_pages
      0.45 ± 13%      +0.2        0.65 ±  6%  perf-profile.children.cycles-pp.__do_munmap
      0.13 ±  9%      +0.2        0.33 ±  3%  perf-profile.children.cycles-pp.do_anonymous_page
      0.22 ± 14%      +0.2        0.42 ±  4%  perf-profile.children.cycles-pp.link_path_walk
      0.47 ± 10%      +0.2        0.67 ±  6%  perf-profile.children.cycles-pp.copy_process
      0.72 ±  2%      +0.2        0.94 ±  6%  perf-profile.children.cycles-pp.hrtimer_interrupt
      0.21 ± 11%      +0.2        0.43 ±  4%  perf-profile.children.cycles-pp.do_fault
      0.13 ±  8%      +0.2        0.35 ±  2%  perf-profile.children.cycles-pp.__x64_sys_brk
      0.72            +0.2        0.96 ±  6%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      0.48 ±  9%      +0.2        0.72 ±  7%  perf-profile.children.cycles-pp.__x64_sys_exit_group
      0.48 ±  9%      +0.2        0.72 ±  7%  perf-profile.children.cycles-pp.do_group_exit
      0.48 ± 10%      +0.2        0.72 ±  7%  perf-profile.children.cycles-pp.do_exit
      0.52 ±  9%      +0.2        0.75 ±  6%  perf-profile.children.cycles-pp.__do_sys_clone
      0.52 ±  9%      +0.2        0.75 ±  6%  perf-profile.children.cycles-pp.kernel_clone
      0.00            +0.3        0.25 ± 41%  perf-profile.children.cycles-pp.terminate_walk
      0.17 ± 17%      +0.3        0.44 ±  4%  perf-profile.children.cycles-pp.kmem_cache_alloc
      0.83 ±  9%      +0.3        1.13 ±  8%  perf-profile.children.cycles-pp.exit_mmap
      0.83 ±  9%      +0.3        1.13 ±  7%  perf-profile.children.cycles-pp.mmput
      0.15 ± 26%      +0.3        0.46 ± 26%  perf-profile.children.cycles-pp.do_softirq_own_stack
      0.56 ± 10%      +0.3        0.89 ±  6%  perf-profile.children.cycles-pp.exec_binprm
      0.56 ± 10%      +0.3        0.88 ±  6%  perf-profile.children.cycles-pp.load_elf_binary
      0.16 ± 25%      +0.3        0.49 ± 24%  perf-profile.children.cycles-pp.irq_exit_rcu
      0.13 ± 16%      +0.4        0.48 ±  4%  perf-profile.children.cycles-pp.brk
      0.10 ± 18%      +0.4        0.46 ±  9%  perf-profile.children.cycles-pp.__memcg_kmem_uncharge
      0.15 ± 16%      +0.4        0.53 ±  2%  perf-profile.children.cycles-pp.page_test
      0.41 ± 10%      +0.5        0.94 ±  3%  perf-profile.children.cycles-pp.__handle_mm_fault
      0.21 ± 15%      +0.5        0.74 ±  2%  perf-profile.children.cycles-pp.add_short
      0.88 ±  3%      +0.5        1.41 ± 10%  perf-profile.children.cycles-pp.asm_call_sysvec_on_stack
      0.45 ± 10%      +0.6        1.00 ±  2%  perf-profile.children.cycles-pp.handle_mm_fault
      0.18 ± 19%      +0.6        0.73 ±  8%  perf-profile.children.cycles-pp.page_counter_cancel
      0.19 ± 18%      +0.6        0.80 ±  8%  perf-profile.children.cycles-pp.page_counter_uncharge
      0.48 ± 10%      +0.6        1.09 ±  3%  perf-profile.children.cycles-pp.do_user_addr_fault
      0.48 ± 10%      +0.6        1.10 ±  3%  perf-profile.children.cycles-pp.exc_page_fault
      0.91 ±  3%      +0.6        1.55 ± 10%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      0.98 ±  4%      +0.7        1.66 ±  8%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
      0.00            +0.7        0.70 ± 70%  perf-profile.children.cycles-pp.dcache_dir_open
      0.00            +0.7        0.70 ± 70%  perf-profile.children.cycles-pp.d_alloc_cursor
      0.53 ±  8%      +0.7        1.25 ±  3%  perf-profile.children.cycles-pp.asm_exc_page_fault
      0.16 ± 19%      +0.7        0.89 ± 11%  perf-profile.children.cycles-pp.drain_obj_stock
      0.20 ± 20%      +0.9        1.08 ± 11%  perf-profile.children.cycles-pp.refill_obj_stock
      0.00            +1.1        1.15 ± 47%  perf-profile.children.cycles-pp.lockref_get
      0.00            +1.2        1.16 ± 46%  perf-profile.children.cycles-pp.do_dentry_open
      0.24 ± 12%      +2.1        2.29 ± 16%  perf-profile.children.cycles-pp.run_ksoftirqd
      0.25 ± 12%      +2.2        2.42 ± 14%  perf-profile.children.cycles-pp.smpboot_thread_fn
      0.26 ± 11%      +2.2        2.47 ± 14%  perf-profile.children.cycles-pp.kthread
      0.27 ± 11%      +2.2        2.48 ± 14%  perf-profile.children.cycles-pp.ret_from_fork
      0.37 ± 18%      +2.3        2.68 ± 13%  perf-profile.children.cycles-pp.rcu_core
      0.36 ± 18%      +2.3        2.68 ± 13%  perf-profile.children.cycles-pp.rcu_do_batch
      0.43 ± 18%      +2.4        2.78 ± 12%  perf-profile.children.cycles-pp.kmem_cache_free
      0.39 ± 17%      +2.4        2.76 ± 13%  perf-profile.children.cycles-pp.__softirqentry_text_start
      0.22 ±  3%      +3.6        3.85 ± 32%  perf-profile.children.cycles-pp.lockref_put_or_lock
      0.38 ±  4%      +3.6        4.01 ± 31%  perf-profile.children.cycles-pp.dput
      1.50 ± 28%      +6.3        7.76 ±  9%  perf-profile.children.cycles-pp.intel_idle
      1.72 ± 26%      +7.0        8.71 ±  6%  perf-profile.children.cycles-pp.cpuidle_enter
      1.72 ± 26%      +7.0        8.71 ±  6%  perf-profile.children.cycles-pp.cpuidle_enter_state
      1.79 ± 26%      +7.1        8.91 ±  6%  perf-profile.children.cycles-pp.start_secondary
      1.80 ± 26%      +7.2        8.97 ±  6%  perf-profile.children.cycles-pp.secondary_startup_64_no_verify
      1.80 ± 26%      +7.2        8.97 ±  6%  perf-profile.children.cycles-pp.cpu_startup_entry
      1.80 ± 26%      +7.2        8.97 ±  6%  perf-profile.children.cycles-pp.do_idle
      0.00            +9.7        9.75 ± 10%  perf-profile.children.cycles-pp.complete_walk
      0.08 ±  8%     +11.1       11.18 ± 10%  perf-profile.children.cycles-pp.__open64_nocancel
      0.34 ± 12%     +11.3       11.68 ± 10%  perf-profile.children.cycles-pp.do_sys_open
      0.34 ± 11%     +11.3       11.68 ± 10%  perf-profile.children.cycles-pp.do_sys_openat2
      0.06 ± 15%     +43.8       43.89 ±  8%  perf-profile.children.cycles-pp.pick_link
      0.65 ±  3%     +47.1       47.71 ±  9%  perf-profile.children.cycles-pp.execve
      0.10 ±  7%     +47.2       47.32 ±  8%  perf-profile.children.cycles-pp.do_open_execat
      0.14 ±  6%     +47.3       47.39 ±  8%  perf-profile.children.cycles-pp.step_into
      0.69 ±  8%     +47.6       48.27 ±  7%  perf-profile.children.cycles-pp.bprm_execve
      0.75 ±  9%     +47.7       48.40 ±  7%  perf-profile.children.cycles-pp.do_execveat_common
      0.76 ±  9%     +47.7       48.41 ±  7%  perf-profile.children.cycles-pp.__x64_sys_execve
      0.09 ±  7%     +53.6       53.68 ±  6%  perf-profile.children.cycles-pp.lockref_get_not_dead
      0.09 ±  7%     +53.6       53.68 ±  6%  perf-profile.children.cycles-pp.__legitimize_path
      0.09 ± 11%     +53.6       53.69 ±  6%  perf-profile.children.cycles-pp.unlazy_walk
      0.42 ±  9%     +58.5       58.95 ±  4%  perf-profile.children.cycles-pp.path_openat
      0.42 ±  9%     +58.5       58.95 ±  4%  perf-profile.children.cycles-pp.do_filp_open
      0.00           +80.0       80.02        perf-profile.children.cycles-pp.__cna_queued_spin_lock_slowpath
     92.33           -92.3        0.00        perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
      0.06 ±  9%      +0.0        0.10 ±  4%  perf-profile.self.cycles-pp.find_idlest_group
      0.05 ±  9%      +0.0        0.10 ±  8%  perf-profile.self.cycles-pp.update_cfs_group
      0.04 ± 58%      +0.0        0.09 ±  5%  perf-profile.self.cycles-pp.page_counter_try_charge
      0.03 ±100%      +0.0        0.07 ±  5%  perf-profile.self.cycles-pp.vma_interval_tree_insert
      0.07 ±  5%      +0.0        0.12 ±  6%  perf-profile.self.cycles-pp.zap_pte_range
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.__slab_free
      0.00            +0.1        0.07 ± 12%  perf-profile.self.cycles-pp.page_counter_uncharge
      0.00            +0.1        0.07        perf-profile.self.cycles-pp.sync_regs
      0.00            +0.1        0.07 ±  5%  perf-profile.self.cycles-pp.filldir64
      0.01 ±173%      +0.1        0.09 ±  4%  perf-profile.self.cycles-pp.page_remove_rmap
      0.00            +0.1        0.08 ±  8%  perf-profile.self.cycles-pp.___might_sleep
      0.00            +0.1        0.08        perf-profile.self.cycles-pp.clear_page_erms
      0.04 ± 57%      +0.1        0.12 ±  5%  perf-profile.self.cycles-pp._dl_addr
      0.00            +0.1        0.08 ±  5%  perf-profile.self.cycles-pp.release_pages
      0.00            +0.1        0.09 ±  9%  perf-profile.self.cycles-pp.__mod_memcg_state
      0.08 ± 10%      +0.1        0.18 ±  2%  perf-profile.self.cycles-pp.native_irq_return_iret
      0.01 ±173%      +0.1        0.11 ±  6%  perf-profile.self.cycles-pp.get_obj_cgroup_from_current
      0.00            +0.1        0.11 ±  4%  perf-profile.self.cycles-pp.page_test
      0.07 ± 13%      +0.1        0.18 ±  4%  perf-profile.self.cycles-pp.kmem_cache_alloc
      0.14 ±  8%      +0.1        0.25 ±  6%  perf-profile.self.cycles-pp.filemap_map_pages
      0.00            +0.1        0.13 ±  3%  perf-profile.self.cycles-pp.cna_order_queue
      0.00            +0.2        0.18 ± 12%  perf-profile.self.cycles-pp.refill_obj_stock
      0.04 ± 57%      +0.2        0.22 ± 12%  perf-profile.self.cycles-pp.propagate_protected_usage
      0.00            +0.2        0.20 ± 15%  perf-profile.self.cycles-pp.drain_obj_stock
      0.38 ±  2%      +0.2        0.61        perf-profile.self.cycles-pp._raw_spin_lock
      0.14 ± 20%      +0.4        0.52 ±  6%  perf-profile.self.cycles-pp.page_counter_cancel
      0.21 ± 15%      +0.5        0.74 ±  2%  perf-profile.self.cycles-pp.add_short
      0.20 ± 20%      +1.4        1.57 ± 14%  perf-profile.self.cycles-pp.kmem_cache_free
      1.50 ± 28%      +6.3        7.76 ±  9%  perf-profile.self.cycles-pp.intel_idle
      0.00           +79.2       79.21        perf-profile.self.cycles-pp.__cna_queued_spin_lock_slowpath
     30378 ±  6%     -53.8%      14040 ± 15%  softirqs.CPU0.RCU
     16017 ±  2%     +93.1%      30937 ±  3%  softirqs.CPU0.SCHED
     27611 ±  4%     -50.7%      13611 ± 21%  softirqs.CPU1.RCU
     14676 ±  3%     +94.3%      28516 ±  2%  softirqs.CPU1.SCHED
     25324 ±  4%     -52.3%      12087 ±  9%  softirqs.CPU10.RCU
     13778 ±  5%    +113.3%      29393 ±  6%  softirqs.CPU10.SCHED
     25241           -52.2%      12059 ±  7%  softirqs.CPU100.RCU
     14167          +107.5%      29396 ±  5%  softirqs.CPU100.SCHED
     26379 ±  5%     -55.9%      11633 ±  9%  softirqs.CPU101.RCU
     14260          +105.1%      29250 ±  4%  softirqs.CPU101.SCHED
     25911           -54.7%      11732 ±  7%  softirqs.CPU102.RCU
     14236          +106.3%      29367 ±  6%  softirqs.CPU102.SCHED
     26947 ±  2%     -55.3%      12041 ±  9%  softirqs.CPU103.RCU
     14315          +103.1%      29077 ±  5%  softirqs.CPU103.SCHED
     24443 ±  2%     -51.1%      11954 ±  9%  softirqs.CPU104.RCU
     14191          +102.8%      28778 ±  5%  softirqs.CPU104.SCHED
     26520 ±  2%     -54.1%      12174 ±  9%  softirqs.CPU105.RCU
     14147          +104.3%      28906 ±  5%  softirqs.CPU105.SCHED
     25197 ±  3%     -51.2%      12296 ± 11%  softirqs.CPU106.RCU
     13977          +103.5%      28443 ±  3%  softirqs.CPU106.SCHED
     26059 ±  3%     -52.7%      12327 ±  8%  softirqs.CPU107.RCU
     14033          +105.2%      28789 ±  4%  softirqs.CPU107.SCHED
     25419 ±  4%     -53.7%      11763 ±  6%  softirqs.CPU108.RCU
     14007 ±  2%    +110.3%      29451 ±  5%  softirqs.CPU108.SCHED
     25656           -53.2%      11996 ±  9%  softirqs.CPU109.RCU
     14043          +106.9%      29053 ±  5%  softirqs.CPU109.SCHED
     25886 ±  4%     -52.1%      12391 ±  8%  softirqs.CPU11.RCU
     14016 ±  3%    +107.6%      29093 ±  4%  softirqs.CPU11.SCHED
     26133           -54.3%      11937 ±  6%  softirqs.CPU110.RCU
     14312 ±  2%    +101.9%      28892 ±  5%  softirqs.CPU110.SCHED
     25540 ±  4%     -52.9%      12017 ±  3%  softirqs.CPU111.RCU
     14063          +104.6%      28771 ±  4%  softirqs.CPU111.SCHED
     26093 ±  6%     -58.6%      10802 ±  8%  softirqs.CPU112.RCU
     14177          +106.0%      29203 ±  4%  softirqs.CPU112.SCHED
     25682           -55.0%      11564 ±  8%  softirqs.CPU113.RCU
     14202          +100.7%      28510 ±  4%  softirqs.CPU113.SCHED
     25967 ±  3%     -57.7%      10990 ±  7%  softirqs.CPU114.RCU
     14203 ±  2%    +101.4%      28608 ±  2%  softirqs.CPU114.SCHED
     25367 ±  3%     -54.5%      11544 ±  6%  softirqs.CPU115.RCU
     14262 ±  2%    +103.8%      29074 ±  3%  softirqs.CPU115.SCHED
     25309 ±  3%     -53.9%      11659 ±  8%  softirqs.CPU116.RCU
     13994 ±  2%    +104.8%      28658 ±  5%  softirqs.CPU116.SCHED
     25249 ±  2%     -54.6%      11459 ±  8%  softirqs.CPU117.RCU
     14196          +103.3%      28867 ±  4%  softirqs.CPU117.SCHED
     25589 ±  3%     -55.9%      11292 ±  3%  softirqs.CPU118.RCU
     14172          +103.1%      28779 ±  3%  softirqs.CPU118.SCHED
     25726           -55.8%      11380 ±  3%  softirqs.CPU119.RCU
     14152          +108.0%      29430 ±  5%  softirqs.CPU119.SCHED
     25561 ±  2%     -53.3%      11946 ±  7%  softirqs.CPU12.RCU
     13937 ±  3%    +104.3%      28471 ±  4%  softirqs.CPU12.SCHED
     24910 ±  4%     -53.8%      11511 ±  8%  softirqs.CPU120.RCU
     14073          +112.8%      29941 ±  4%  softirqs.CPU120.SCHED
     26329           -59.1%      10779 ±  3%  softirqs.CPU121.RCU
     14049          +107.8%      29200 ±  6%  softirqs.CPU121.SCHED
     25974 ±  3%     -56.1%      11400 ±  6%  softirqs.CPU122.RCU
     14028          +108.2%      29205 ±  4%  softirqs.CPU122.SCHED
     25133 ±  3%     -55.6%      11169 ±  3%  softirqs.CPU123.RCU
     14062          +111.4%      29721 ±  7%  softirqs.CPU123.SCHED
     25661 ±  2%     -57.1%      11005 ±  5%  softirqs.CPU124.RCU
     14138          +113.3%      30160 ±  3%  softirqs.CPU124.SCHED
     25513 ±  2%     -57.7%      10790 ±  5%  softirqs.CPU125.RCU
     14091          +110.8%      29704 ±  4%  softirqs.CPU125.SCHED
     25612 ±  2%     -55.7%      11334 ±  8%  softirqs.CPU126.RCU
     13961          +110.0%      29313 ±  4%  softirqs.CPU126.SCHED
     26309 ±  2%     -58.3%      10973 ±  6%  softirqs.CPU127.RCU
     14080          +107.8%      29259 ±  4%  softirqs.CPU127.SCHED
     26163 ±  3%     -54.2%      11975 ±  6%  softirqs.CPU128.RCU
     14315          +105.4%      29401 ±  5%  softirqs.CPU128.SCHED
     26414 ±  4%     -54.9%      11915 ±  6%  softirqs.CPU129.RCU
     13980          +106.5%      28866 ±  4%  softirqs.CPU129.SCHED
     26270 ±  3%     -52.5%      12486 ±  8%  softirqs.CPU13.RCU
     14147          +101.7%      28531 ±  4%  softirqs.CPU13.SCHED
     26380           -55.4%      11763 ±  6%  softirqs.CPU130.RCU
     14150          +110.3%      29761 ±  7%  softirqs.CPU130.SCHED
     26401 ±  2%     -54.4%      12034 ±  6%  softirqs.CPU131.RCU
     14092          +109.4%      29513 ±  5%  softirqs.CPU131.SCHED
     26320 ±  3%     -56.2%      11538 ±  6%  softirqs.CPU132.RCU
     13896          +108.5%      28971 ±  6%  softirqs.CPU132.SCHED
     26219           -55.5%      11670 ±  5%  softirqs.CPU133.RCU
     13996          +108.2%      29138 ±  3%  softirqs.CPU133.SCHED
     25975 ±  3%     -54.8%      11748 ±  5%  softirqs.CPU134.RCU
     14085          +104.9%      28853 ±  2%  softirqs.CPU134.SCHED
     27168 ±  2%     -57.9%      11428 ±  6%  softirqs.CPU135.RCU
     14458 ±  5%    +101.5%      29130 ±  2%  softirqs.CPU135.SCHED
     25969           -53.6%      12043 ±  4%  softirqs.CPU136.RCU
     13994          +104.8%      28659 ±  6%  softirqs.CPU136.SCHED
     26745 ±  3%     -54.8%      12084 ±  8%  softirqs.CPU137.RCU
     14249          +104.1%      29081 ±  4%  softirqs.CPU137.SCHED
     25926 ±  2%     -55.6%      11514 ±  6%  softirqs.CPU138.RCU
     14095          +110.3%      29643 ±  5%  softirqs.CPU138.SCHED
     26479 ±  2%     -55.2%      11870 ±  6%  softirqs.CPU139.RCU
     14100          +111.3%      29797 ±  4%  softirqs.CPU139.SCHED
     26189 ±  3%     -53.6%      12140 ±  9%  softirqs.CPU14.RCU
     14004          +107.1%      28999 ±  2%  softirqs.CPU14.SCHED
     26066 ±  2%     -53.9%      12025 ±  4%  softirqs.CPU140.RCU
     14132          +108.5%      29468 ±  4%  softirqs.CPU140.SCHED
     26103           -55.1%      11711 ±  7%  softirqs.CPU141.RCU
     14136          +105.9%      29099 ±  6%  softirqs.CPU141.SCHED
     25640 ±  4%     -53.5%      11913 ±  7%  softirqs.CPU142.RCU
     14113 ±  2%    +108.3%      29397 ±  5%  softirqs.CPU142.SCHED
     25925 ±  4%     -54.7%      11746 ±  4%  softirqs.CPU143.RCU
     14011          +108.9%      29264 ±  4%  softirqs.CPU143.SCHED
     25233 ±  4%     -51.2%      12319 ±  9%  softirqs.CPU144.RCU
     14089          +103.2%      28626 ±  6%  softirqs.CPU144.SCHED
     25233 ±  3%     -52.1%      12089 ±  7%  softirqs.CPU145.RCU
     13887          +108.3%      28921 ±  4%  softirqs.CPU145.SCHED
     26352 ±  2%     -55.8%      11634 ±  4%  softirqs.CPU146.RCU
     14399 ±  3%    +101.6%      29025 ±  2%  softirqs.CPU146.SCHED
     26049 ±  2%     -54.3%      11902 ±  5%  softirqs.CPU147.RCU
     14206          +104.1%      28993 ±  5%  softirqs.CPU147.SCHED
     26128 ±  3%     -52.1%      12515 ±  3%  softirqs.CPU148.RCU
     14047          +106.1%      28947 ±  3%  softirqs.CPU148.SCHED
     25845 ±  3%     -53.7%      11975 ±  7%  softirqs.CPU149.RCU
     14382 ±  3%    +101.1%      28917 ±  4%  softirqs.CPU149.SCHED
     25967 ±  3%     -53.1%      12177 ±  7%  softirqs.CPU15.RCU
     13938 ±  2%    +108.3%      29027 ±  5%  softirqs.CPU15.SCHED
     25537 ±  4%     -53.5%      11887 ±  6%  softirqs.CPU150.RCU
     14092          +107.9%      29298 ±  5%  softirqs.CPU150.SCHED
     26669 ±  3%     -55.4%      11907 ±  4%  softirqs.CPU151.RCU
     14280          +102.1%      28862 ±  4%  softirqs.CPU151.SCHED
     26578           -54.2%      12170 ±  6%  softirqs.CPU152.RCU
     14161          +103.1%      28760 ±  4%  softirqs.CPU152.SCHED
     25718 ±  2%     -52.5%      12210 ± 10%  softirqs.CPU153.RCU
     14048          +105.4%      28855 ±  4%  softirqs.CPU153.SCHED
     25862           -54.2%      11848 ±  5%  softirqs.CPU154.RCU
     14035          +105.9%      28894 ±  5%  softirqs.CPU154.SCHED
     25825           -54.0%      11885 ±  5%  softirqs.CPU155.RCU
     14101          +106.8%      29161 ±  4%  softirqs.CPU155.SCHED
     25902           -48.3%      13396 ± 15%  softirqs.CPU156.RCU
     14107          +106.9%      29193 ±  3%  softirqs.CPU156.SCHED
     26375 ±  2%     -54.8%      11909 ±  7%  softirqs.CPU157.RCU
     14065          +104.7%      28788 ±  5%  softirqs.CPU157.SCHED
     26197 ±  4%     -52.7%      12402 ±  8%  softirqs.CPU158.RCU
     14189 ±  2%    +103.6%      28890 ±  6%  softirqs.CPU158.SCHED
     25328 ±  5%     -54.2%      11607 ±  8%  softirqs.CPU159.RCU
     14125          +105.5%      29030 ±  6%  softirqs.CPU159.SCHED
     25409 ±  3%     -55.0%      11434 ±  5%  softirqs.CPU16.RCU
     13892          +107.1%      28767 ±  3%  softirqs.CPU16.SCHED
     25840 ±  3%     -57.0%      11100 ±  9%  softirqs.CPU160.RCU
     14090          +107.2%      29192 ±  4%  softirqs.CPU160.SCHED
     26409 ±  2%     -57.6%      11205 ±  9%  softirqs.CPU161.RCU
     14126          +102.6%      28626 ±  6%  softirqs.CPU161.SCHED
     26524           -57.0%      11412 ± 11%  softirqs.CPU162.RCU
     14333          +101.1%      28830 ±  4%  softirqs.CPU162.SCHED
     25852           -55.6%      11490 ±  9%  softirqs.CPU163.RCU
     13950          +102.7%      28279 ±  6%  softirqs.CPU163.SCHED
     25711 ±  4%     -56.3%      11230 ± 10%  softirqs.CPU164.RCU
     14172          +103.1%      28781 ±  5%  softirqs.CPU164.SCHED
     25974           -57.6%      11016 ±  7%  softirqs.CPU165.RCU
     14081          +105.2%      28896 ±  6%  softirqs.CPU165.SCHED
     25677           -53.8%      11870 ± 11%  softirqs.CPU166.RCU
     14102          +105.0%      28909 ±  4%  softirqs.CPU166.SCHED
     25372 ±  3%     -55.9%      11199 ±  9%  softirqs.CPU167.RCU
     13998          +102.5%      28345 ±  6%  softirqs.CPU167.SCHED
     25064 ±  2%     -54.0%      11541 ±  5%  softirqs.CPU168.RCU
     14169           +95.0%      27624 ±  2%  softirqs.CPU168.SCHED
     25273 ±  4%     -55.2%      11334 ±  4%  softirqs.CPU169.RCU
     14214           +96.3%      27896        softirqs.CPU169.SCHED
     26036 ±  3%     -54.7%      11793 ±  6%  softirqs.CPU17.RCU
     14129 ±  2%    +103.0%      28679        softirqs.CPU17.SCHED
     24879 ±  3%     -54.8%      11256 ±  8%  softirqs.CPU170.RCU
     14068           +93.0%      27151        softirqs.CPU170.SCHED
     25438 ±  3%     -55.8%      11255 ± 11%  softirqs.CPU171.RCU
     14164           +94.3%      27522 ±  2%  softirqs.CPU171.SCHED
     24171 ±  2%     -52.2%      11549 ±  3%  softirqs.CPU172.RCU
     14072           +92.1%      27038 ±  3%  softirqs.CPU172.SCHED
     24008           -51.6%      11619 ±  4%  softirqs.CPU173.RCU
     14049           +93.6%      27203 ±  3%  softirqs.CPU173.SCHED
     24669 ±  2%     -53.9%      11369 ±  5%  softirqs.CPU174.RCU
     14109           +89.9%      26793        softirqs.CPU174.SCHED
     25003           -54.9%      11280 ±  5%  softirqs.CPU175.RCU
     14000 ±  2%     +96.5%      27509        softirqs.CPU175.SCHED
     25482 ±  2%     -52.9%      12002 ±  9%  softirqs.CPU176.RCU
     14126           +94.7%      27506 ±  2%  softirqs.CPU176.SCHED
     25818 ±  3%     -54.9%      11633 ±  9%  softirqs.CPU177.RCU
     14104           +91.4%      26994        softirqs.CPU177.SCHED
     25118 ±  3%     -52.4%      11961 ±  7%  softirqs.CPU178.RCU
     14088           +94.6%      27413        softirqs.CPU178.SCHED
     25671           -51.5%      12457 ±  9%  softirqs.CPU179.RCU
     14187 ±  2%     +89.5%      26879 ±  2%  softirqs.CPU179.SCHED
     26224 ±  4%     -57.1%      11244 ±  8%  softirqs.CPU18.RCU
     13877          +102.5%      28099 ±  3%  softirqs.CPU18.SCHED
     24549 ±  3%     -53.3%      11473 ±  7%  softirqs.CPU180.RCU
     14001           +97.8%      27699        softirqs.CPU180.SCHED
     26328           -53.3%      12286 ±  9%  softirqs.CPU181.RCU
     14405           +93.0%      27805        softirqs.CPU181.SCHED
     24959 ±  2%     -50.9%      12244 ±  6%  softirqs.CPU182.RCU
     14081           +95.6%      27538        softirqs.CPU182.SCHED
     25928 ±  2%     -54.7%      11744 ±  7%  softirqs.CPU183.RCU
     14175           +88.5%      26713 ±  2%  softirqs.CPU183.SCHED
     25380 ±  2%     -52.5%      12050 ± 10%  softirqs.CPU184.RCU
     14090           +95.8%      27592        softirqs.CPU184.SCHED
     25405 ±  2%     -52.5%      12063 ±  9%  softirqs.CPU185.RCU
     14083           +94.2%      27355        softirqs.CPU185.SCHED
     25261 ±  4%     -53.3%      11805 ±  8%  softirqs.CPU186.RCU
     14062           +93.7%      27245        softirqs.CPU186.SCHED
     25477 ±  3%     -51.8%      12284 ±  7%  softirqs.CPU187.RCU
     14086           +97.9%      27872        softirqs.CPU187.SCHED
     25741 ±  3%     -54.4%      11746 ±  6%  softirqs.CPU188.RCU
     14141           +97.6%      27942        softirqs.CPU188.SCHED
     25296           -53.2%      11828 ±  8%  softirqs.CPU189.RCU
     13920           +96.7%      27385        softirqs.CPU189.SCHED
     25309 ±  2%     -54.0%      11629 ±  9%  softirqs.CPU19.RCU
     14004          +106.1%      28864 ±  4%  softirqs.CPU19.SCHED
     25522           -51.9%      12273 ±  8%  softirqs.CPU190.RCU
     14113           +99.9%      28210 ±  2%  softirqs.CPU190.SCHED
     25670 ±  5%     -52.8%      12107 ±  9%  softirqs.CPU191.RCU
     14141           +91.1%      27024        softirqs.CPU191.SCHED
     26914 ±  3%     -53.9%      12404 ±  4%  softirqs.CPU2.RCU
     14425 ±  2%     +95.2%      28154 ±  4%  softirqs.CPU2.SCHED
     25651 ±  3%     -54.8%      11590 ±  4%  softirqs.CPU20.RCU
     14012 ±  2%    +105.1%      28733 ±  3%  softirqs.CPU20.SCHED
     25470           -54.2%      11678 ±  5%  softirqs.CPU21.RCU
     14158          +105.5%      29096 ±  3%  softirqs.CPU21.SCHED
     25084 ±  6%     -54.3%      11455 ±  4%  softirqs.CPU22.RCU
     14102 ±  2%    +104.6%      28855 ±  5%  softirqs.CPU22.SCHED
     25502 ±  2%     -53.8%      11774 ±  5%  softirqs.CPU23.RCU
     13968 ±  2%    +104.2%      28530 ±  6%  softirqs.CPU23.SCHED
     27539 ±  3%     -58.0%      11568 ±  8%  softirqs.CPU24.RCU
     14144           +99.6%      28235 ±  2%  softirqs.CPU24.SCHED
     26551 ±  3%     -57.3%      11332 ±  4%  softirqs.CPU25.RCU
     14007 ±  2%    +102.8%      28410 ±  5%  softirqs.CPU25.SCHED
     25014           -53.7%      11591 ±  8%  softirqs.CPU26.RCU
     13697          +109.7%      28719 ±  5%  softirqs.CPU26.SCHED
     26301 ±  2%     -56.9%      11347 ±  9%  softirqs.CPU27.RCU
     14007          +108.8%      29244 ±  2%  softirqs.CPU27.SCHED
     26314           -58.5%      10912 ±  6%  softirqs.CPU28.RCU
     14079          +105.6%      28951 ±  4%  softirqs.CPU28.SCHED
     25746           -54.1%      11815 ±  6%  softirqs.CPU29.RCU
     13979          +106.2%      28819 ±  7%  softirqs.CPU29.SCHED
     25272 ±  3%     -51.5%      12248 ±  7%  softirqs.CPU3.RCU
     13930          +101.1%      28015 ±  4%  softirqs.CPU3.SCHED
     25584 ±  4%     -55.6%      11371 ±  6%  softirqs.CPU30.RCU
     13946          +112.6%      29645 ±  6%  softirqs.CPU30.SCHED
     25701 ±  2%     -56.3%      11237 ±  5%  softirqs.CPU31.RCU
     13822          +111.3%      29206 ±  6%  softirqs.CPU31.SCHED
     26295 ±  2%     -55.1%      11799 ±  7%  softirqs.CPU32.RCU
     14042          +109.7%      29442 ±  4%  softirqs.CPU32.SCHED
     26675 ±  2%     -53.9%      12306 ± 10%  softirqs.CPU33.RCU
     14080          +106.4%      29066 ±  5%  softirqs.CPU33.SCHED
     26460           -52.9%      12469 ±  7%  softirqs.CPU34.RCU
     13979          +107.5%      29013 ±  5%  softirqs.CPU34.SCHED
     26817 ±  3%     -55.0%      12079 ±  6%  softirqs.CPU35.RCU
     13915 ±  2%    +111.9%      29487 ±  5%  softirqs.CPU35.SCHED
     25485           -52.7%      12045 ±  7%  softirqs.CPU36.RCU
     13999          +110.4%      29448 ±  4%  softirqs.CPU36.SCHED
     26545 ±  4%     -55.9%      11699 ±  6%  softirqs.CPU37.RCU
     13922 ±  2%    +107.7%      28921 ±  3%  softirqs.CPU37.SCHED
     27116 ±  2%     -55.5%      12058 ±  8%  softirqs.CPU38.RCU
     13992          +111.5%      29587 ±  4%  softirqs.CPU38.SCHED
     25731 ±  2%     -52.8%      12156 ±  7%  softirqs.CPU39.RCU
     13803          +113.3%      29442 ±  5%  softirqs.CPU39.SCHED
     26689 ±  3%     -53.2%      12482 ±  5%  softirqs.CPU4.RCU
     14044 ±  3%    +101.3%      28270 ±  5%  softirqs.CPU4.SCHED
     25359 ±  2%     -51.4%      12324 ±  5%  softirqs.CPU40.RCU
     13725          +114.7%      29474 ±  3%  softirqs.CPU40.SCHED
     26440 ±  3%     -53.7%      12255 ±  7%  softirqs.CPU41.RCU
     14031          +104.5%      28686 ±  4%  softirqs.CPU41.SCHED
     25473 ±  3%     -53.3%      11884 ±  4%  softirqs.CPU42.RCU
     13836          +104.9%      28350 ±  4%  softirqs.CPU42.SCHED
     26486           -54.2%      12121 ±  4%  softirqs.CPU43.RCU
     14109          +107.2%      29234 ±  6%  softirqs.CPU43.SCHED
     26311 ±  2%     -54.4%      11990 ±  6%  softirqs.CPU44.RCU
     13807          +109.6%      28935 ±  3%  softirqs.CPU44.SCHED
     25901 ±  3%     -54.6%      11753 ±  5%  softirqs.CPU45.RCU
     14057          +106.7%      29061 ±  5%  softirqs.CPU45.SCHED
     26664 ±  2%     -53.1%      12494 ±  7%  softirqs.CPU46.RCU
     14040          +107.5%      29130 ±  4%  softirqs.CPU46.SCHED
     26328 ±  2%     -55.2%      11801 ±  5%  softirqs.CPU47.RCU
     13961          +109.4%      29240 ±  4%  softirqs.CPU47.SCHED
     26585 ±  2%     -52.8%      12540 ±  6%  softirqs.CPU48.RCU
     14041           +97.4%      27711 ±  3%  softirqs.CPU48.SCHED
     25378 ±  4%     -52.6%      12023 ±  6%  softirqs.CPU49.RCU
     13905           +98.2%      27556 ±  5%  softirqs.CPU49.SCHED
     25618 ±  3%     -52.2%      12248 ±  6%  softirqs.CPU5.RCU
     14002          +107.3%      29019 ±  3%  softirqs.CPU5.SCHED
     26244           -55.4%      11709 ±  5%  softirqs.CPU50.RCU
     14141 ±  2%     +97.1%      27874 ±  5%  softirqs.CPU50.SCHED
     26436 ±  3%     -51.6%      12788 ±  5%  softirqs.CPU51.RCU
     14032          +102.8%      28461 ±  5%  softirqs.CPU51.SCHED
     26466 ±  2%     -52.8%      12499 ±  8%  softirqs.CPU52.RCU
     14079          +100.1%      28166 ±  5%  softirqs.CPU52.SCHED
     25742           -50.6%      12726 ±  7%  softirqs.CPU53.RCU
     13954          +104.7%      28568 ±  7%  softirqs.CPU53.SCHED
     26579 ±  3%     -55.8%      11743 ± 10%  softirqs.CPU54.RCU
     14054          +103.2%      28552 ±  7%  softirqs.CPU54.SCHED
     25840 ±  2%     -52.8%      12186 ±  8%  softirqs.CPU55.RCU
     13839          +109.2%      28951 ±  6%  softirqs.CPU55.SCHED
     26617           -54.0%      12239 ±  8%  softirqs.CPU56.RCU
     14024          +105.3%      28790 ±  6%  softirqs.CPU56.SCHED
     26569           -53.5%      12358 ±  7%  softirqs.CPU57.RCU
     14059          +106.1%      28974 ±  7%  softirqs.CPU57.SCHED
     25787 ±  2%     -51.1%      12603 ±  7%  softirqs.CPU58.RCU
     13897          +110.0%      29186 ±  6%  softirqs.CPU58.SCHED
     25988 ±  2%     -52.6%      12324 ±  7%  softirqs.CPU59.RCU
     14100           +98.9%      28040 ±  8%  softirqs.CPU59.SCHED
     24945 ±  3%     -51.6%      12084 ±  6%  softirqs.CPU6.RCU
     13400 ±  2%    +110.1%      28160 ±  5%  softirqs.CPU6.SCHED
     25626           -51.2%      12512 ±  8%  softirqs.CPU60.RCU
     13804          +108.4%      28772 ±  7%  softirqs.CPU60.SCHED
     26270 ±  2%     -53.6%      12200 ±  8%  softirqs.CPU61.RCU
     13691          +107.2%      28371 ±  6%  softirqs.CPU61.SCHED
     26161           -55.5%      11637 ±  7%  softirqs.CPU62.RCU
     13992          +105.3%      28729 ±  6%  softirqs.CPU62.SCHED
     26532           -54.9%      11957 ±  8%  softirqs.CPU63.RCU
     13998          +103.9%      28541 ±  6%  softirqs.CPU63.SCHED
     26334 ±  4%     -57.2%      11269 ±  9%  softirqs.CPU64.RCU
     14017          +103.6%      28539 ±  6%  softirqs.CPU64.SCHED
     25490 ±  2%     -53.7%      11798 ±  9%  softirqs.CPU65.RCU
     13798          +109.0%      28844 ±  6%  softirqs.CPU65.SCHED
     25758 ±  2%     -55.1%      11572 ±  9%  softirqs.CPU66.RCU
     13815          +109.1%      28889 ±  5%  softirqs.CPU66.SCHED
     26099 ±  3%     -54.2%      11961 ±  9%  softirqs.CPU67.RCU
     13790          +112.2%      29261 ±  4%  softirqs.CPU67.SCHED
     26161           -55.2%      11709 ±  9%  softirqs.CPU68.RCU
     14061          +104.1%      28700 ±  8%  softirqs.CPU68.SCHED
     25317 ±  2%     -49.6%      12772 ±  6%  softirqs.CPU69.RCU
     13904          +107.9%      28905 ±  4%  softirqs.CPU69.SCHED
     25709 ±  2%     -52.4%      12231 ±  7%  softirqs.CPU7.RCU
     13865          +103.8%      28256 ±  4%  softirqs.CPU7.SCHED
     25773           -52.9%      12151 ±  7%  softirqs.CPU70.RCU
     13916          +111.6%      29453 ±  5%  softirqs.CPU70.SCHED
     25772           -54.2%      11799 ±  8%  softirqs.CPU71.RCU
     13651 ±  3%    +109.7%      28630 ±  6%  softirqs.CPU71.SCHED
     27151 ±  7%     -54.8%      12268 ±  5%  softirqs.CPU72.RCU
     14119 ±  2%     +83.4%      25889 ±  3%  softirqs.CPU72.SCHED
     25201 ±  3%     -54.9%      11375 ±  6%  softirqs.CPU73.RCU
     13862           +89.8%      26310 ±  2%  softirqs.CPU73.SCHED
     26208 ±  4%     -56.8%      11321 ±  9%  softirqs.CPU74.RCU
     14383 ±  3%     +87.0%      26894 ±  2%  softirqs.CPU74.SCHED
     24965           -53.3%      11657 ±  8%  softirqs.CPU75.RCU
     14010           +94.2%      27215        softirqs.CPU75.SCHED
     25424 ±  3%     -53.5%      11811 ±  5%  softirqs.CPU76.RCU
     13955           +96.9%      27481 ±  3%  softirqs.CPU76.SCHED
     25872 ±  2%     -55.9%      11398 ±  8%  softirqs.CPU77.RCU
     14084           +95.2%      27488        softirqs.CPU77.SCHED
     24382 ±  3%     -52.4%      11601 ±  4%  softirqs.CPU78.RCU
     13720          +101.7%      27666 ±  3%  softirqs.CPU78.SCHED
     24780 ±  2%     -52.0%      11894 ±  7%  softirqs.CPU79.RCU
     13827           +96.5%      27171        softirqs.CPU79.SCHED
     25313 ±  3%     -50.3%      12577 ± 10%  softirqs.CPU8.RCU
     14079          +102.1%      28457 ±  4%  softirqs.CPU8.SCHED
     25498 ±  2%     -53.4%      11884 ±  5%  softirqs.CPU80.RCU
     13897           +96.1%      27250        softirqs.CPU80.SCHED
     24645 ±  4%     -50.4%      12216 ±  5%  softirqs.CPU81.RCU
     13796           +97.9%      27297 ±  3%  softirqs.CPU81.SCHED
     25247 ±  2%     -52.3%      12042 ±  7%  softirqs.CPU82.RCU
     13926           +92.3%      26782 ±  2%  softirqs.CPU82.SCHED
     25131 ±  3%     -51.2%      12269 ±  8%  softirqs.CPU83.RCU
     13878           +97.9%      27469        softirqs.CPU83.SCHED
     25732           -53.5%      11966 ±  8%  softirqs.CPU84.RCU
     14058           +97.6%      27774 ±  2%  softirqs.CPU84.SCHED
     25573 ±  3%     -52.8%      12059 ±  8%  softirqs.CPU85.RCU
     14113           +92.8%      27216 ±  2%  softirqs.CPU85.SCHED
     25429           -50.8%      12502 ±  7%  softirqs.CPU86.RCU
     13868           +98.3%      27506        softirqs.CPU86.SCHED
     25218 ±  2%     -50.7%      12423 ±  2%  softirqs.CPU87.RCU
     13822           +98.5%      27432        softirqs.CPU87.SCHED
     26493           -53.3%      12369 ±  8%  softirqs.CPU88.RCU
     14262           +95.0%      27809        softirqs.CPU88.SCHED
     24926 ±  4%     -50.0%      12475 ± 10%  softirqs.CPU89.RCU
     13829           +99.3%      27563        softirqs.CPU89.SCHED
     25308           -52.6%      11991 ±  6%  softirqs.CPU9.RCU
     13966          +105.7%      28724 ±  3%  softirqs.CPU9.SCHED
     25310 ±  2%     -52.8%      11941 ±  8%  softirqs.CPU90.RCU
     13626 ±  4%    +104.2%      27819 ±  2%  softirqs.CPU90.SCHED
     25155 ±  4%     -50.7%      12399 ±  6%  softirqs.CPU91.RCU
     13877           +96.5%      27265        softirqs.CPU91.SCHED
     25412 ±  2%     -53.4%      11850 ±  7%  softirqs.CPU92.RCU
     13920           +98.1%      27575 ±  2%  softirqs.CPU92.SCHED
     25666           -52.0%      12321 ±  5%  softirqs.CPU93.RCU
     13963           +96.8%      27486 ±  3%  softirqs.CPU93.SCHED
     24228 ±  5%     -49.0%      12353 ± 10%  softirqs.CPU94.RCU
     13786           +95.6%      26960 ±  2%  softirqs.CPU94.SCHED
     25497 ±  2%     -52.1%      12225 ±  7%  softirqs.CPU95.RCU
     14100 ±  3%     +89.4%      26706        softirqs.CPU95.SCHED
     26445           -54.9%      11934 ±  5%  softirqs.CPU96.RCU
     13876          +113.3%      29598 ±  3%  softirqs.CPU96.SCHED
     26401           -55.4%      11784 ±  5%  softirqs.CPU97.RCU
     14422 ±  4%     +99.5%      28771 ±  4%  softirqs.CPU97.SCHED
     26108 ±  3%     -52.6%      12371 ±  5%  softirqs.CPU98.RCU
     14260          +105.0%      29229 ±  4%  softirqs.CPU98.SCHED
     25613 ±  3%     -54.6%      11623 ±  8%  softirqs.CPU99.RCU
     14205          +105.3%      29167 ±  5%  softirqs.CPU99.SCHED
   4959883           -54.0%    2283561 ±  2%  softirqs.RCU
   2698575          +103.1%    5479539        softirqs.SCHED
     70389           -14.6%      60123        softirqs.TIMER
    597003 ±  2%     -21.6%     467967 ±  3%  interrupts.CAL:Function_call_interrupts
    469.50 ±  6%     +62.8%     764.50 ± 19%  interrupts.CPU0.TLB:TLB_shootdowns
      3690 ± 18%     -32.8%       2480 ±  9%  interrupts.CPU1.CAL:Function_call_interrupts
      6901           -38.7%       4233 ± 10%  interrupts.CPU1.NMI:Non-maskable_interrupts
      6901           -38.7%       4233 ± 10%  interrupts.CPU1.PMI:Performance_monitoring_interrupts
    299.75 ± 17%    +105.2%     615.00 ± 19%  interrupts.CPU1.TLB:TLB_shootdowns
      3224 ± 11%     -22.9%       2485 ±  4%  interrupts.CPU10.CAL:Function_call_interrupts
      6869 ±  2%     -38.8%       4206 ±  9%  interrupts.CPU10.NMI:Non-maskable_interrupts
      6869 ±  2%     -38.8%       4206 ±  9%  interrupts.CPU10.PMI:Performance_monitoring_interrupts
    245.50 ± 12%    +191.3%     715.25 ± 22%  interrupts.CPU10.TLB:TLB_shootdowns
      3074 ±  3%     -19.8%       2466 ±  7%  interrupts.CPU100.CAL:Function_call_interrupts
    247.50 ± 37%    +162.6%     650.00 ± 28%  interrupts.CPU100.TLB:TLB_shootdowns
      3102 ±  3%     -21.5%       2434 ±  6%  interrupts.CPU101.CAL:Function_call_interrupts
      6806 ±  2%     -41.9%       3957 ± 30%  interrupts.CPU101.NMI:Non-maskable_interrupts
      6806 ±  2%     -41.9%       3957 ± 30%  interrupts.CPU101.PMI:Performance_monitoring_interrupts
    314.75 ± 29%     +87.5%     590.25 ± 13%  interrupts.CPU101.TLB:TLB_shootdowns
      3142 ±  4%     -23.8%       2395 ±  3%  interrupts.CPU102.CAL:Function_call_interrupts
    246.75 ±  9%    +130.2%     568.00 ± 14%  interrupts.CPU102.TLB:TLB_shootdowns
      3192 ±  7%     -25.6%       2375 ±  4%  interrupts.CPU103.CAL:Function_call_interrupts
      6895           -46.6%       3684 ± 17%  interrupts.CPU103.NMI:Non-maskable_interrupts
      6895           -46.6%       3684 ± 17%  interrupts.CPU103.PMI:Performance_monitoring_interrupts
    337.50 ± 17%     +54.0%     519.75 ± 15%  interrupts.CPU103.TLB:TLB_shootdowns
      3144 ±  3%     -23.1%       2416 ±  6%  interrupts.CPU104.CAL:Function_call_interrupts
      6895           -43.8%       3873 ± 25%  interrupts.CPU104.NMI:Non-maskable_interrupts
      6895           -43.8%       3873 ± 25%  interrupts.CPU104.PMI:Performance_monitoring_interrupts
    240.75 ± 17%    +108.9%     503.00 ± 16%  interrupts.CPU104.TLB:TLB_shootdowns
      3021 ±  5%     -19.1%       2444 ±  3%  interrupts.CPU105.CAL:Function_call_interrupts
      6882 ±  2%     -49.3%       3488 ± 40%  interrupts.CPU105.NMI:Non-maskable_interrupts
      6882 ±  2%     -49.3%       3488 ± 40%  interrupts.CPU105.PMI:Performance_monitoring_interrupts
    283.25 ±  5%    +114.7%     608.25 ± 11%  interrupts.CPU105.TLB:TLB_shootdowns
      2955 ±  5%     -18.2%       2416 ±  4%  interrupts.CPU106.CAL:Function_call_interrupts
      6911           -46.9%       3672 ± 41%  interrupts.CPU106.NMI:Non-maskable_interrupts
      6911           -46.9%       3672 ± 41%  interrupts.CPU106.PMI:Performance_monitoring_interrupts
    206.50 ± 18%    +214.4%     649.25 ± 11%  interrupts.CPU106.TLB:TLB_shootdowns
      3097 ±  3%     -19.5%       2494 ±  6%  interrupts.CPU107.CAL:Function_call_interrupts
      6906           -44.0%       3871 ± 32%  interrupts.CPU107.NMI:Non-maskable_interrupts
      6906           -44.0%       3871 ± 32%  interrupts.CPU107.PMI:Performance_monitoring_interrupts
    267.50 ± 27%    +117.9%     582.75 ± 27%  interrupts.CPU107.TLB:TLB_shootdowns
      2998 ±  3%     -18.7%       2438 ±  7%  interrupts.CPU108.CAL:Function_call_interrupts
    249.75 ± 11%     +88.4%     470.50 ± 15%  interrupts.CPU108.TLB:TLB_shootdowns
      3056           -20.4%       2431 ±  6%  interrupts.CPU109.CAL:Function_call_interrupts
    266.25 ± 29%    +125.6%     600.75 ± 25%  interrupts.CPU109.TLB:TLB_shootdowns
      3057 ±  2%     -21.0%       2415 ±  3%  interrupts.CPU11.CAL:Function_call_interrupts
      6913           -51.0%       3385 ± 20%  interrupts.CPU11.NMI:Non-maskable_interrupts
      6913           -51.0%       3385 ± 20%  interrupts.CPU11.PMI:Performance_monitoring_interrupts
    220.25 ± 32%    +216.3%     696.75 ± 12%  interrupts.CPU11.TLB:TLB_shootdowns
      3019 ±  4%     -20.9%       2388 ±  3%  interrupts.CPU110.CAL:Function_call_interrupts
    308.00 ± 31%     +72.8%     532.25 ±  9%  interrupts.CPU110.TLB:TLB_shootdowns
      2987 ±  2%     -17.8%       2457 ±  2%  interrupts.CPU111.CAL:Function_call_interrupts
      6058 ± 25%     -53.1%       2844 ± 32%  interrupts.CPU111.NMI:Non-maskable_interrupts
      6058 ± 25%     -53.1%       2844 ± 32%  interrupts.CPU111.PMI:Performance_monitoring_interrupts
    239.75 ± 21%    +127.3%     545.00 ± 15%  interrupts.CPU111.TLB:TLB_shootdowns
      3123           -22.8%       2410 ±  6%  interrupts.CPU112.CAL:Function_call_interrupts
      6878 ±  2%     -42.9%       3929 ± 29%  interrupts.CPU112.NMI:Non-maskable_interrupts
      6878 ±  2%     -42.9%       3929 ± 29%  interrupts.CPU112.PMI:Performance_monitoring_interrupts
    247.00 ± 25%    +120.6%     545.00 ± 11%  interrupts.CPU112.TLB:TLB_shootdowns
      3135 ±  2%     -22.4%       2432 ±  5%  interrupts.CPU113.CAL:Function_call_interrupts
    241.25 ± 13%    +142.4%     584.75 ± 28%  interrupts.CPU113.TLB:TLB_shootdowns
      3106           -21.1%       2450 ±  6%  interrupts.CPU114.CAL:Function_call_interrupts
    258.50 ± 24%    +121.5%     572.50 ± 21%  interrupts.CPU114.TLB:TLB_shootdowns
      3172 ±  5%     -23.9%       2413 ±  6%  interrupts.CPU115.CAL:Function_call_interrupts
    276.75 ± 10%    +105.5%     568.75 ±  8%  interrupts.CPU115.TLB:TLB_shootdowns
      3079 ±  5%     -18.8%       2499 ±  4%  interrupts.CPU116.CAL:Function_call_interrupts
      6887           -53.2%       3220 ± 36%  interrupts.CPU116.NMI:Non-maskable_interrupts
      6887           -53.2%       3220 ± 36%  interrupts.CPU116.PMI:Performance_monitoring_interrupts
    200.50 ± 16%    +213.8%     629.25 ± 22%  interrupts.CPU116.TLB:TLB_shootdowns
      3101 ±  5%     -18.8%       2518 ±  4%  interrupts.CPU117.CAL:Function_call_interrupts
      6902           -40.9%       4082 ± 36%  interrupts.CPU117.NMI:Non-maskable_interrupts
      6902           -40.9%       4082 ± 36%  interrupts.CPU117.PMI:Performance_monitoring_interrupts
    228.50 ±  5%    +159.3%     592.50 ± 31%  interrupts.CPU117.TLB:TLB_shootdowns
      3053 ±  2%     -18.9%       2474 ±  9%  interrupts.CPU118.CAL:Function_call_interrupts
      6912           -50.0%       3457 ± 47%  interrupts.CPU118.NMI:Non-maskable_interrupts
      6912           -50.0%       3457 ± 47%  interrupts.CPU118.PMI:Performance_monitoring_interrupts
    259.25 ±  5%    +155.3%     661.75 ± 45%  interrupts.CPU118.TLB:TLB_shootdowns
      3110 ±  3%     -21.3%       2447 ±  4%  interrupts.CPU119.CAL:Function_call_interrupts
      6907           -40.5%       4106 ± 39%  interrupts.CPU119.NMI:Non-maskable_interrupts
      6907           -40.5%       4106 ± 39%  interrupts.CPU119.PMI:Performance_monitoring_interrupts
    234.25 ± 16%    +113.0%     499.00 ± 15%  interrupts.CPU119.TLB:TLB_shootdowns
      2979 ±  3%     -19.4%       2402 ±  4%  interrupts.CPU12.CAL:Function_call_interrupts
      6862 ±  2%     -39.1%       4181 ±  7%  interrupts.CPU12.NMI:Non-maskable_interrupts
      6862 ±  2%     -39.1%       4181 ±  7%  interrupts.CPU12.PMI:Performance_monitoring_interrupts
    259.75 ± 12%    +122.7%     578.50 ± 32%  interrupts.CPU12.TLB:TLB_shootdowns
      3053 ±  4%     -18.5%       2487 ±  6%  interrupts.CPU120.CAL:Function_call_interrupts
    242.25 ± 30%    +155.7%     619.50 ± 19%  interrupts.CPU120.TLB:TLB_shootdowns
      3110 ±  3%     -18.3%       2542 ±  5%  interrupts.CPU121.CAL:Function_call_interrupts
    253.50 ± 17%    +134.3%     594.00 ± 10%  interrupts.CPU121.TLB:TLB_shootdowns
      3126           -18.3%       2554 ±  8%  interrupts.CPU122.CAL:Function_call_interrupts
      6864           -38.2%       4240 ± 32%  interrupts.CPU122.NMI:Non-maskable_interrupts
      6864           -38.2%       4240 ± 32%  interrupts.CPU122.PMI:Performance_monitoring_interrupts
    231.50 ± 24%    +146.1%     569.75 ± 44%  interrupts.CPU122.TLB:TLB_shootdowns
      3059 ±  4%     -16.1%       2567 ±  8%  interrupts.CPU123.CAL:Function_call_interrupts
      6925           -32.1%       4702 ± 12%  interrupts.CPU123.NMI:Non-maskable_interrupts
      6925           -32.1%       4702 ± 12%  interrupts.CPU123.PMI:Performance_monitoring_interrupts
    220.75 ± 34%    +181.4%     621.25 ± 18%  interrupts.CPU123.TLB:TLB_shootdowns
      3054 ±  5%     -18.3%       2495 ±  7%  interrupts.CPU124.CAL:Function_call_interrupts
    205.50 ± 11%    +180.9%     577.25 ± 11%  interrupts.CPU124.TLB:TLB_shootdowns
      3083           -19.4%       2485 ±  8%  interrupts.CPU125.CAL:Function_call_interrupts
    212.00 ± 11%    +208.5%     654.00 ± 14%  interrupts.CPU125.TLB:TLB_shootdowns
      3129 ±  5%     -18.8%       2542 ±  9%  interrupts.CPU126.CAL:Function_call_interrupts
    240.75 ± 16%    +195.6%     711.75 ± 19%  interrupts.CPU126.TLB:TLB_shootdowns
      3209 ±  5%     -20.8%       2543 ± 10%  interrupts.CPU127.CAL:Function_call_interrupts
    235.00 ± 24%    +117.0%     510.00 ± 25%  interrupts.CPU127.TLB:TLB_shootdowns
      3195 ±  2%     -23.4%       2449 ±  7%  interrupts.CPU128.CAL:Function_call_interrupts
    266.75 ± 14%    +183.4%     756.00 ±  8%  interrupts.CPU128.TLB:TLB_shootdowns
      3072 ±  2%     -18.0%       2518 ± 10%  interrupts.CPU129.CAL:Function_call_interrupts
    245.50 ± 12%    +184.6%     698.75 ± 21%  interrupts.CPU129.TLB:TLB_shootdowns
      3063 ±  4%     -21.1%       2416 ±  7%  interrupts.CPU13.CAL:Function_call_interrupts
      6869 ±  2%     -46.8%       3656 ± 23%  interrupts.CPU13.NMI:Non-maskable_interrupts
      6869 ±  2%     -46.8%       3656 ± 23%  interrupts.CPU13.PMI:Performance_monitoring_interrupts
    311.75 ± 19%    +124.4%     699.50 ± 13%  interrupts.CPU13.TLB:TLB_shootdowns
      3204 ±  4%     -24.8%       2410 ±  8%  interrupts.CPU130.CAL:Function_call_interrupts
    249.75 ±  9%    +164.0%     659.25 ± 30%  interrupts.CPU130.TLB:TLB_shootdowns
      3124 ±  3%     -19.3%       2521 ±  9%  interrupts.CPU131.CAL:Function_call_interrupts
    211.00 ± 20%    +180.1%     591.00 ± 30%  interrupts.CPU131.TLB:TLB_shootdowns
      3082 ±  5%     -19.5%       2482 ±  9%  interrupts.CPU132.CAL:Function_call_interrupts
      6934           -37.8%       4310 ± 29%  interrupts.CPU133.NMI:Non-maskable_interrupts
      6934           -37.8%       4310 ± 29%  interrupts.CPU133.PMI:Performance_monitoring_interrupts
    258.25 ± 21%    +152.5%     652.00 ± 34%  interrupts.CPU133.TLB:TLB_shootdowns
      3093 ±  5%     -16.4%       2584 ± 11%  interrupts.CPU134.CAL:Function_call_interrupts
      6846 ±  2%     -37.0%       4312 ± 29%  interrupts.CPU134.NMI:Non-maskable_interrupts
      6846 ±  2%     -37.0%       4312 ± 29%  interrupts.CPU134.PMI:Performance_monitoring_interrupts
    282.00 ± 20%     +98.8%     560.50 ± 24%  interrupts.CPU134.TLB:TLB_shootdowns
      3166 ±  3%     -17.8%       2601 ± 11%  interrupts.CPU135.CAL:Function_call_interrupts
      6893 ±  2%     -38.1%       4263 ± 30%  interrupts.CPU135.NMI:Non-maskable_interrupts
      6893 ±  2%     -38.1%       4263 ± 30%  interrupts.CPU135.PMI:Performance_monitoring_interrupts
    219.50 ±  3%    +151.8%     552.75 ± 24%  interrupts.CPU135.TLB:TLB_shootdowns
      3090 ±  2%     -20.0%       2473 ± 10%  interrupts.CPU136.CAL:Function_call_interrupts
    226.50 ± 13%    +118.0%     493.75 ± 14%  interrupts.CPU136.TLB:TLB_shootdowns
      3187           -20.5%       2533 ±  8%  interrupts.CPU137.CAL:Function_call_interrupts
    271.75 ± 18%    +120.8%     600.00 ± 33%  interrupts.CPU137.TLB:TLB_shootdowns
    214.00 ± 21%    +133.9%     500.50 ± 38%  interrupts.CPU138.TLB:TLB_shootdowns
      3179           -22.1%       2478 ±  9%  interrupts.CPU139.CAL:Function_call_interrupts
    222.50 ± 18%    +239.9%     756.25 ± 39%  interrupts.CPU139.TLB:TLB_shootdowns
      3052 ±  3%     -21.1%       2407 ±  6%  interrupts.CPU14.CAL:Function_call_interrupts
      6873 ±  3%     -38.4%       4236 ±  9%  interrupts.CPU14.NMI:Non-maskable_interrupts
      6873 ±  3%     -38.4%       4236 ±  9%  interrupts.CPU14.PMI:Performance_monitoring_interrupts
    223.25 ± 18%    +231.2%     739.50 ± 23%  interrupts.CPU14.TLB:TLB_shootdowns
      3110 ±  5%     -18.8%       2526 ±  6%  interrupts.CPU140.CAL:Function_call_interrupts
    279.25 ± 14%     +92.8%     538.50 ± 22%  interrupts.CPU140.TLB:TLB_shootdowns
      3142 ±  2%     -20.9%       2485 ±  8%  interrupts.CPU141.CAL:Function_call_interrupts
    255.00 ±  2%    +115.7%     550.00 ± 10%  interrupts.CPU141.TLB:TLB_shootdowns
      2998 ±  4%     -18.0%       2458 ±  9%  interrupts.CPU142.CAL:Function_call_interrupts
      6916           -37.6%       4319 ± 31%  interrupts.CPU142.NMI:Non-maskable_interrupts
      6916           -37.6%       4319 ± 31%  interrupts.CPU142.PMI:Performance_monitoring_interrupts
    232.50 ± 31%    +169.1%     625.75 ± 29%  interrupts.CPU142.TLB:TLB_shootdowns
    189.50 ±  7%    +250.9%     665.00 ± 30%  interrupts.CPU143.TLB:TLB_shootdowns
      3096 ±  3%     -20.3%       2469 ±  3%  interrupts.CPU144.CAL:Function_call_interrupts
    295.75 ± 16%    +120.3%     651.50 ± 29%  interrupts.CPU144.TLB:TLB_shootdowns
      3079           -20.8%       2440 ±  7%  interrupts.CPU145.CAL:Function_call_interrupts
    200.25 ± 17%    +239.6%     680.00 ± 22%  interrupts.CPU145.TLB:TLB_shootdowns
      3063 ±  3%     -20.7%       2428 ±  5%  interrupts.CPU146.CAL:Function_call_interrupts
    297.00 ± 27%     +76.7%     524.75 ± 20%  interrupts.CPU146.TLB:TLB_shootdowns
      3198 ±  8%     -23.4%       2450 ±  2%  interrupts.CPU147.CAL:Function_call_interrupts
      6908           -50.9%       3390 ± 15%  interrupts.CPU147.NMI:Non-maskable_interrupts
      6908           -50.9%       3390 ± 15%  interrupts.CPU147.PMI:Performance_monitoring_interrupts
    277.50 ± 42%    +140.9%     668.50 ± 26%  interrupts.CPU147.TLB:TLB_shootdowns
      3012           -21.3%       2371 ±  3%  interrupts.CPU148.CAL:Function_call_interrupts
      6899           -48.7%       3541 ± 35%  interrupts.CPU148.NMI:Non-maskable_interrupts
      6899           -48.7%       3541 ± 35%  interrupts.CPU148.PMI:Performance_monitoring_interrupts
    238.25 ± 16%    +132.3%     553.50 ± 24%  interrupts.CPU148.TLB:TLB_shootdowns
      3101 ±  2%     -22.1%       2416 ±  3%  interrupts.CPU149.CAL:Function_call_interrupts
      3114 ±  2%     -22.1%       2427 ±  5%  interrupts.CPU15.CAL:Function_call_interrupts
    245.75 ± 23%    +136.8%     582.00 ± 15%  interrupts.CPU15.TLB:TLB_shootdowns
      3018 ±  5%     -21.3%       2375 ±  5%  interrupts.CPU150.CAL:Function_call_interrupts
      5190 ± 34%     -36.3%       3308 ± 15%  interrupts.CPU150.NMI:Non-maskable_interrupts
      5190 ± 34%     -36.3%       3308 ± 15%  interrupts.CPU150.PMI:Performance_monitoring_interrupts
    311.75 ± 36%     +68.9%     526.50 ±  7%  interrupts.CPU150.TLB:TLB_shootdowns
      3100 ±  2%     -23.1%       2385 ±  4%  interrupts.CPU151.CAL:Function_call_interrupts
      6051 ± 25%     -48.0%       3146 ± 14%  interrupts.CPU151.NMI:Non-maskable_interrupts
      6051 ± 25%     -48.0%       3146 ± 14%  interrupts.CPU151.PMI:Performance_monitoring_interrupts
    238.50 ± 27%    +200.1%     715.75 ± 46%  interrupts.CPU151.TLB:TLB_shootdowns
      3138 ±  2%     -22.6%       2428 ±  4%  interrupts.CPU152.CAL:Function_call_interrupts
      3031 ±  2%     -17.4%       2502 ±  8%  interrupts.CPU153.CAL:Function_call_interrupts
    262.00 ± 11%    +136.7%     620.25 ± 24%  interrupts.CPU153.TLB:TLB_shootdowns
      3093 ±  4%     -22.0%       2412 ±  5%  interrupts.CPU154.CAL:Function_call_interrupts
    216.00 ± 11%    +136.5%     510.75 ± 24%  interrupts.CPU154.TLB:TLB_shootdowns
      3124 ±  2%     -20.1%       2497 ±  6%  interrupts.CPU155.CAL:Function_call_interrupts
      6929           -43.1%       3945 ± 30%  interrupts.CPU155.NMI:Non-maskable_interrupts
      6929           -43.1%       3945 ± 30%  interrupts.CPU155.PMI:Performance_monitoring_interrupts
    240.50 ± 15%    +232.7%     800.25 ± 32%  interrupts.CPU155.TLB:TLB_shootdowns
      3051 ±  6%     -17.4%       2519 ±  9%  interrupts.CPU156.CAL:Function_call_interrupts
    220.75 ± 14%    +160.7%     575.50 ± 16%  interrupts.CPU156.TLB:TLB_shootdowns
      3055 ±  4%     -20.3%       2436 ±  4%  interrupts.CPU157.CAL:Function_call_interrupts
    241.50 ± 10%    +161.6%     631.75 ± 23%  interrupts.CPU157.TLB:TLB_shootdowns
      3120 ±  2%     -21.0%       2465 ±  3%  interrupts.CPU158.CAL:Function_call_interrupts
    236.75 ± 11%    +163.7%     624.25 ± 46%  interrupts.CPU158.TLB:TLB_shootdowns
      3159           -22.3%       2454 ±  4%  interrupts.CPU159.CAL:Function_call_interrupts
    266.50 ± 26%    +114.4%     571.25 ± 25%  interrupts.CPU159.TLB:TLB_shootdowns
      2974 ±  3%     -19.5%       2393 ±  3%  interrupts.CPU16.CAL:Function_call_interrupts
    277.75 ± 44%    +100.5%     557.00 ± 20%  interrupts.CPU16.TLB:TLB_shootdowns
      3081           -18.3%       2516 ±  6%  interrupts.CPU160.CAL:Function_call_interrupts
    213.00 ±  9%    +217.4%     676.00 ± 18%  interrupts.CPU160.TLB:TLB_shootdowns
      3134 ±  2%     -21.3%       2467        interrupts.CPU161.CAL:Function_call_interrupts
    215.25 ± 19%    +248.9%     751.00 ± 13%  interrupts.CPU161.TLB:TLB_shootdowns
      3052 ±  3%     -20.1%       2438 ±  6%  interrupts.CPU162.CAL:Function_call_interrupts
    301.25 ± 19%     +89.6%     571.25 ± 39%  interrupts.CPU162.TLB:TLB_shootdowns
      3069 ±  4%     -20.8%       2432 ±  6%  interrupts.CPU163.CAL:Function_call_interrupts
    228.25 ± 19%    +146.5%     562.75 ± 26%  interrupts.CPU163.TLB:TLB_shootdowns
      3074 ±  4%     -16.1%       2579 ± 10%  interrupts.CPU164.CAL:Function_call_interrupts
      6044 ± 24%     -55.0%       2721 ± 25%  interrupts.CPU164.NMI:Non-maskable_interrupts
      6044 ± 24%     -55.0%       2721 ± 25%  interrupts.CPU164.PMI:Performance_monitoring_interrupts
    248.00 ± 23%    +113.4%     529.25 ± 23%  interrupts.CPU164.TLB:TLB_shootdowns
      3174 ±  3%     -24.3%       2404 ±  4%  interrupts.CPU165.CAL:Function_call_interrupts
    236.75 ± 12%    +164.2%     625.50 ±  9%  interrupts.CPU165.TLB:TLB_shootdowns
      3069 ±  3%     -21.0%       2424 ±  5%  interrupts.CPU166.CAL:Function_call_interrupts
    233.25 ± 13%    +131.8%     540.75 ± 25%  interrupts.CPU166.TLB:TLB_shootdowns
      3086 ±  2%     -21.0%       2439 ±  4%  interrupts.CPU167.CAL:Function_call_interrupts
    273.50 ± 18%    +102.0%     552.50 ± 11%  interrupts.CPU167.TLB:TLB_shootdowns
      2976 ±  4%     -15.8%       2504 ± 10%  interrupts.CPU168.CAL:Function_call_interrupts
    649.00 ±  6%     -29.2%     459.50 ± 11%  interrupts.CPU168.RES:Rescheduling_interrupts
    220.25 ±  5%    +169.8%     594.25 ± 38%  interrupts.CPU168.TLB:TLB_shootdowns
      2828 ±  7%     -31.3%       1944 ±  5%  interrupts.CPU169.CAL:Function_call_interrupts
    703.75 ± 12%     -35.9%     451.00 ±  4%  interrupts.CPU169.RES:Rescheduling_interrupts
    213.25 ± 11%    +190.2%     618.75 ±  6%  interrupts.CPU169.TLB:TLB_shootdowns
      3181 ±  4%     -24.6%       2399 ±  2%  interrupts.CPU17.CAL:Function_call_interrupts
      6838 ±  2%     -47.4%       3596 ± 25%  interrupts.CPU17.NMI:Non-maskable_interrupts
      6838 ±  2%     -47.4%       3596 ± 25%  interrupts.CPU17.PMI:Performance_monitoring_interrupts
    284.25 ± 22%     +87.7%     533.50 ± 15%  interrupts.CPU17.TLB:TLB_shootdowns
      3081 ±  6%     -23.9%       2345 ±  4%  interrupts.CPU170.CAL:Function_call_interrupts
    727.00 ±  4%     -36.6%     461.00 ±  8%  interrupts.CPU170.RES:Rescheduling_interrupts
    274.25 ± 33%    +139.0%     655.50 ± 29%  interrupts.CPU170.TLB:TLB_shootdowns
      3087 ±  2%     -20.7%       2448 ±  4%  interrupts.CPU171.CAL:Function_call_interrupts
    710.00 ±  6%     -31.9%     483.50 ± 13%  interrupts.CPU171.RES:Rescheduling_interrupts
    216.50 ± 13%    +135.8%     510.50 ± 22%  interrupts.CPU171.TLB:TLB_shootdowns
      3087 ±  4%     -23.1%       2375 ±  6%  interrupts.CPU172.CAL:Function_call_interrupts
    689.75 ±  2%     -31.6%     471.50 ±  9%  interrupts.CPU172.RES:Rescheduling_interrupts
    219.50 ± 14%    +208.2%     676.50 ± 22%  interrupts.CPU172.TLB:TLB_shootdowns
      3090 ±  6%     -23.2%       2374 ±  4%  interrupts.CPU173.CAL:Function_call_interrupts
    722.75 ±  4%     -41.0%     426.25 ± 14%  interrupts.CPU173.RES:Rescheduling_interrupts
    265.00 ±  9%    +124.6%     595.25 ± 29%  interrupts.CPU173.TLB:TLB_shootdowns
      3069 ±  3%     -24.7%       2310 ±  5%  interrupts.CPU174.CAL:Function_call_interrupts
    725.00 ±  3%     -39.6%     438.00 ± 13%  interrupts.CPU174.RES:Rescheduling_interrupts
    232.75 ±  8%    +103.9%     474.50 ± 28%  interrupts.CPU174.TLB:TLB_shootdowns
      3010 ±  6%     -22.8%       2323 ±  5%  interrupts.CPU175.CAL:Function_call_interrupts
    691.25 ± 12%     -33.1%     462.75 ± 15%  interrupts.CPU175.RES:Rescheduling_interrupts
    231.50 ± 16%    +175.4%     637.50 ± 25%  interrupts.CPU175.TLB:TLB_shootdowns
      3126 ±  2%     -23.5%       2391 ±  3%  interrupts.CPU176.CAL:Function_call_interrupts
    717.25 ±  7%     -35.2%     465.00 ± 12%  interrupts.CPU176.RES:Rescheduling_interrupts
    254.25 ±  9%    +101.2%     511.50 ± 24%  interrupts.CPU176.TLB:TLB_shootdowns
      3112 ±  2%     -24.4%       2354 ±  5%  interrupts.CPU177.CAL:Function_call_interrupts
    722.50 ± 11%     -36.5%     459.00 ± 18%  interrupts.CPU177.RES:Rescheduling_interrupts
    234.00 ± 33%    +110.4%     492.25 ± 17%  interrupts.CPU177.TLB:TLB_shootdowns
      3119 ±  5%     -24.0%       2371 ±  7%  interrupts.CPU178.CAL:Function_call_interrupts
    720.00 ±  7%     -35.0%     468.25 ± 16%  interrupts.CPU178.RES:Rescheduling_interrupts
    305.50 ± 28%    +157.5%     786.75 ± 28%  interrupts.CPU178.TLB:TLB_shootdowns
      3138 ±  3%     -25.1%       2351 ±  4%  interrupts.CPU179.CAL:Function_call_interrupts
      6947           -35.8%       4462 ± 15%  interrupts.CPU179.NMI:Non-maskable_interrupts
      6947           -35.8%       4462 ± 15%  interrupts.CPU179.PMI:Performance_monitoring_interrupts
    729.75           -36.6%     462.75 ± 16%  interrupts.CPU179.RES:Rescheduling_interrupts
    259.50 ± 13%    +124.4%     582.25 ±  9%  interrupts.CPU179.TLB:TLB_shootdowns
      3064 ±  4%     -19.1%       2480 ±  7%  interrupts.CPU18.CAL:Function_call_interrupts
    248.50 ± 18%    +167.7%     665.25 ± 28%  interrupts.CPU18.TLB:TLB_shootdowns
      3056 ±  8%     -23.8%       2330 ±  5%  interrupts.CPU180.CAL:Function_call_interrupts
    706.50 ± 10%     -33.8%     468.00 ± 10%  interrupts.CPU180.RES:Rescheduling_interrupts
    242.75 ± 16%    +110.9%     512.00 ± 17%  interrupts.CPU180.TLB:TLB_shootdowns
      3088 ±  3%     -24.3%       2338 ±  4%  interrupts.CPU181.CAL:Function_call_interrupts
    762.00 ±  5%     -41.0%     449.75 ± 13%  interrupts.CPU181.RES:Rescheduling_interrupts
    246.75 ±  8%    +140.1%     592.50 ± 17%  interrupts.CPU181.TLB:TLB_shootdowns
      3109 ±  3%     -22.9%       2396 ±  4%  interrupts.CPU182.CAL:Function_call_interrupts
    707.25 ±  5%     -35.4%     456.75 ± 13%  interrupts.CPU182.RES:Rescheduling_interrupts
    247.75 ± 34%    +103.9%     505.25 ±  6%  interrupts.CPU182.TLB:TLB_shootdowns
      3159 ±  6%     -25.7%       2348 ±  4%  interrupts.CPU183.CAL:Function_call_interrupts
    751.75 ±  4%     -38.6%     461.25 ± 12%  interrupts.CPU183.RES:Rescheduling_interrupts
    245.50 ± 15%    +133.7%     573.75 ± 13%  interrupts.CPU183.TLB:TLB_shootdowns
      3123 ±  4%     -26.2%       2305 ±  5%  interrupts.CPU184.CAL:Function_call_interrupts
      6845 ±  2%     -31.8%       4666 ± 21%  interrupts.CPU184.NMI:Non-maskable_interrupts
      6845 ±  2%     -31.8%       4666 ± 21%  interrupts.CPU184.PMI:Performance_monitoring_interrupts
    739.75 ±  6%     -41.6%     431.75 ± 15%  interrupts.CPU184.RES:Rescheduling_interrupts
    218.00 ± 14%    +221.1%     700.00 ± 15%  interrupts.CPU184.TLB:TLB_shootdowns
      3024 ±  4%     -20.0%       2420 ±  5%  interrupts.CPU185.CAL:Function_call_interrupts
      6871 ±  2%     -39.1%       4181 ± 17%  interrupts.CPU185.NMI:Non-maskable_interrupts
      6871 ±  2%     -39.1%       4181 ± 17%  interrupts.CPU185.PMI:Performance_monitoring_interrupts
    704.25 ±  4%     -34.6%     460.50 ± 10%  interrupts.CPU185.RES:Rescheduling_interrupts
    260.75 ± 26%    +122.8%     581.00 ± 30%  interrupts.CPU185.TLB:TLB_shootdowns
      3053 ±  2%     -22.7%       2358 ±  4%  interrupts.CPU186.CAL:Function_call_interrupts
      6940           -37.0%       4374 ±  7%  interrupts.CPU186.NMI:Non-maskable_interrupts
      6940           -37.0%       4374 ±  7%  interrupts.CPU186.PMI:Performance_monitoring_interrupts
    710.75 ±  4%     -32.0%     483.25 ± 14%  interrupts.CPU186.RES:Rescheduling_interrupts
    223.50 ±  6%    +145.0%     547.50 ± 18%  interrupts.CPU186.TLB:TLB_shootdowns
      3075 ±  5%     -23.4%       2356 ±  3%  interrupts.CPU187.CAL:Function_call_interrupts
      6890           -37.5%       4305 ± 13%  interrupts.CPU187.NMI:Non-maskable_interrupts
      6890           -37.5%       4305 ± 13%  interrupts.CPU187.PMI:Performance_monitoring_interrupts
    766.25 ±  8%     -40.4%     457.00 ±  9%  interrupts.CPU187.RES:Rescheduling_interrupts
    259.00 ± 20%    +139.4%     620.00 ± 21%  interrupts.CPU187.TLB:TLB_shootdowns
      3059 ±  4%     -24.8%       2301 ±  4%  interrupts.CPU188.CAL:Function_call_interrupts
    702.50 ±  6%     -37.9%     436.25 ± 11%  interrupts.CPU188.RES:Rescheduling_interrupts
    267.50 ± 21%    +136.8%     633.50 ± 11%  interrupts.CPU188.TLB:TLB_shootdowns
      3134 ±  6%     -25.5%       2335 ±  4%  interrupts.CPU189.CAL:Function_call_interrupts
    704.00 ± 11%     -37.6%     439.25 ± 11%  interrupts.CPU189.RES:Rescheduling_interrupts
    226.75 ±  3%    +105.2%     465.25 ± 22%  interrupts.CPU189.TLB:TLB_shootdowns
      3003 ±  5%     -20.2%       2397 ±  6%  interrupts.CPU19.CAL:Function_call_interrupts
      6920           -53.3%       3234 ± 31%  interrupts.CPU19.NMI:Non-maskable_interrupts
      6920           -53.3%       3234 ± 31%  interrupts.CPU19.PMI:Performance_monitoring_interrupts
    201.25 ± 21%    +169.7%     542.75 ± 16%  interrupts.CPU19.TLB:TLB_shootdowns
      3056 ±  5%     -23.3%       2345 ±  3%  interrupts.CPU190.CAL:Function_call_interrupts
    735.00 ±  6%     -36.5%     466.50 ± 12%  interrupts.CPU190.RES:Rescheduling_interrupts
    267.75 ± 18%    +106.4%     552.75 ± 14%  interrupts.CPU190.TLB:TLB_shootdowns
      3358 ±  4%     -29.3%       2375 ±  7%  interrupts.CPU191.CAL:Function_call_interrupts
      6920           -36.6%       4388 ± 17%  interrupts.CPU191.NMI:Non-maskable_interrupts
      6920           -36.6%       4388 ± 17%  interrupts.CPU191.PMI:Performance_monitoring_interrupts
    802.50 ±  9%     -39.4%     486.50 ±  9%  interrupts.CPU191.RES:Rescheduling_interrupts
    274.25 ± 33%    +130.6%     632.50 ± 23%  interrupts.CPU191.TLB:TLB_shootdowns
      3215 ±  4%     -22.0%       2509 ±  7%  interrupts.CPU2.CAL:Function_call_interrupts
      6912           -41.0%       4079 ±  7%  interrupts.CPU2.NMI:Non-maskable_interrupts
      6912           -41.0%       4079 ±  7%  interrupts.CPU2.PMI:Performance_monitoring_interrupts
    288.50 ± 21%     +95.2%     563.25 ± 22%  interrupts.CPU2.TLB:TLB_shootdowns
      3048 ±  3%     -21.1%       2405 ±  6%  interrupts.CPU20.CAL:Function_call_interrupts
    242.50 ± 20%    +214.7%     763.25 ± 46%  interrupts.CPU20.TLB:TLB_shootdowns
      3051 ±  2%     -20.9%       2413 ±  5%  interrupts.CPU21.CAL:Function_call_interrupts
    211.00 ± 12%    +188.4%     608.50 ± 25%  interrupts.CPU21.TLB:TLB_shootdowns
      3139 ±  4%     -22.8%       2424 ±  4%  interrupts.CPU22.CAL:Function_call_interrupts
      6852 ±  2%     -47.5%       3596 ± 32%  interrupts.CPU22.NMI:Non-maskable_interrupts
      6852 ±  2%     -47.5%       3596 ± 32%  interrupts.CPU22.PMI:Performance_monitoring_interrupts
      3077 ±  5%     -20.1%       2459 ±  6%  interrupts.CPU23.CAL:Function_call_interrupts
      6878           -45.7%       3738 ± 26%  interrupts.CPU23.NMI:Non-maskable_interrupts
      6878           -45.7%       3738 ± 26%  interrupts.CPU23.PMI:Performance_monitoring_interrupts
    263.25 ± 30%    +134.0%     616.00 ± 29%  interrupts.CPU23.TLB:TLB_shootdowns
      3298           -25.1%       2470 ±  8%  interrupts.CPU24.CAL:Function_call_interrupts
    456.50 ± 18%     +57.2%     717.75 ± 22%  interrupts.CPU24.TLB:TLB_shootdowns
      3069 ±  2%     -17.9%       2519 ±  8%  interrupts.CPU25.CAL:Function_call_interrupts
      6869 ±  2%     -37.9%       4268 ± 12%  interrupts.CPU25.NMI:Non-maskable_interrupts
      6869 ±  2%     -37.9%       4268 ± 12%  interrupts.CPU25.PMI:Performance_monitoring_interrupts
    297.00 ± 18%    +107.7%     617.00 ± 21%  interrupts.CPU25.TLB:TLB_shootdowns
      3058 ±  3%     -19.0%       2477 ±  8%  interrupts.CPU26.CAL:Function_call_interrupts
      6903           -41.6%       4029 ± 28%  interrupts.CPU26.NMI:Non-maskable_interrupts
      6903           -41.6%       4029 ± 28%  interrupts.CPU26.PMI:Performance_monitoring_interrupts
    234.25 ± 15%    +236.5%     788.25 ± 50%  interrupts.CPU26.TLB:TLB_shootdowns
      3153 ±  4%     -21.2%       2483 ±  7%  interrupts.CPU27.CAL:Function_call_interrupts
      6901           -36.1%       4412 ±  3%  interrupts.CPU27.NMI:Non-maskable_interrupts
      6901           -36.1%       4412 ±  3%  interrupts.CPU27.PMI:Performance_monitoring_interrupts
    281.50 ± 16%    +135.9%     664.00 ± 51%  interrupts.CPU27.TLB:TLB_shootdowns
      3121 ±  6%     -19.9%       2500 ± 11%  interrupts.CPU28.CAL:Function_call_interrupts
      6908           -38.9%       4220 ±  9%  interrupts.CPU28.NMI:Non-maskable_interrupts
      6908           -38.9%       4220 ±  9%  interrupts.CPU28.PMI:Performance_monitoring_interrupts
    253.25 ± 27%    +169.6%     682.75 ± 24%  interrupts.CPU28.TLB:TLB_shootdowns
      3183 ±  3%     -23.7%       2429 ± 10%  interrupts.CPU29.CAL:Function_call_interrupts
      6924           -36.3%       4412 ±  4%  interrupts.CPU29.NMI:Non-maskable_interrupts
      6924           -36.3%       4412 ±  4%  interrupts.CPU29.PMI:Performance_monitoring_interrupts
    252.75 ± 11%    +121.7%     560.25 ± 14%  interrupts.CPU29.TLB:TLB_shootdowns
      3111 ±  3%     -22.3%       2417 ±  6%  interrupts.CPU3.CAL:Function_call_interrupts
      6899           -44.9%       3800 ± 29%  interrupts.CPU3.NMI:Non-maskable_interrupts
      6899           -44.9%       3800 ± 29%  interrupts.CPU3.PMI:Performance_monitoring_interrupts
    301.50 ± 17%     +76.8%     533.00 ± 11%  interrupts.CPU3.TLB:TLB_shootdowns
      3126 ±  3%     -20.4%       2489 ±  9%  interrupts.CPU30.CAL:Function_call_interrupts
      6914           -39.5%       4180 ±  8%  interrupts.CPU30.NMI:Non-maskable_interrupts
      6914           -39.5%       4180 ±  8%  interrupts.CPU30.PMI:Performance_monitoring_interrupts
    263.50 ± 14%    +139.0%     629.75 ± 20%  interrupts.CPU30.TLB:TLB_shootdowns
      3139           -20.1%       2508 ±  9%  interrupts.CPU31.CAL:Function_call_interrupts
      6938           -37.7%       4319 ±  5%  interrupts.CPU31.NMI:Non-maskable_interrupts
      6938           -37.7%       4319 ±  5%  interrupts.CPU31.PMI:Performance_monitoring_interrupts
    245.25 ± 19%    +194.7%     722.75 ± 14%  interrupts.CPU31.TLB:TLB_shootdowns
      3156           -18.4%       2576 ±  9%  interrupts.CPU32.CAL:Function_call_interrupts
      6899           -42.0%       4001 ± 15%  interrupts.CPU32.NMI:Non-maskable_interrupts
      6899           -42.0%       4001 ± 15%  interrupts.CPU32.PMI:Performance_monitoring_interrupts
    253.00 ± 22%    +150.9%     634.75 ± 35%  interrupts.CPU32.TLB:TLB_shootdowns
      3142           -20.6%       2494 ±  7%  interrupts.CPU33.CAL:Function_call_interrupts
      6846 ±  2%     -45.1%       3756 ± 23%  interrupts.CPU33.NMI:Non-maskable_interrupts
      6846 ±  2%     -45.1%       3756 ± 23%  interrupts.CPU33.PMI:Performance_monitoring_interrupts
    265.50 ± 19%    +132.5%     617.25 ± 40%  interrupts.CPU33.TLB:TLB_shootdowns
      3063 ±  3%     -19.9%       2452 ±  6%  interrupts.CPU34.CAL:Function_call_interrupts
      6894           -49.3%       3492 ± 25%  interrupts.CPU34.NMI:Non-maskable_interrupts
      6894           -49.3%       3492 ± 25%  interrupts.CPU34.PMI:Performance_monitoring_interrupts
    251.75 ± 11%    +168.5%     676.00 ± 21%  interrupts.CPU34.TLB:TLB_shootdowns
      3051 ±  3%     -16.1%       2558 ± 11%  interrupts.CPU35.CAL:Function_call_interrupts
      6904           -42.5%       3970 ± 27%  interrupts.CPU35.NMI:Non-maskable_interrupts
      6904           -42.5%       3970 ± 27%  interrupts.CPU35.PMI:Performance_monitoring_interrupts
    208.75 ± 18%    +123.6%     466.75 ± 16%  interrupts.CPU35.TLB:TLB_shootdowns
      3146 ±  4%     -22.6%       2435 ±  8%  interrupts.CPU36.CAL:Function_call_interrupts
      6901           -37.8%       4293        interrupts.CPU36.NMI:Non-maskable_interrupts
      6901           -37.8%       4293        interrupts.CPU36.PMI:Performance_monitoring_interrupts
    240.50 ± 14%    +179.7%     672.75 ± 35%  interrupts.CPU36.TLB:TLB_shootdowns
      3160 ±  2%     -21.5%       2481 ±  7%  interrupts.CPU37.CAL:Function_call_interrupts
      6857 ±  2%     -36.1%       4378 ±  3%  interrupts.CPU37.NMI:Non-maskable_interrupts
      6857 ±  2%     -36.1%       4378 ±  3%  interrupts.CPU37.PMI:Performance_monitoring_interrupts
      3169 ±  7%     -23.3%       2430 ± 10%  interrupts.CPU38.CAL:Function_call_interrupts
      6898 ±  2%     -46.8%       3672 ± 24%  interrupts.CPU38.NMI:Non-maskable_interrupts
      6898 ±  2%     -46.8%       3672 ± 24%  interrupts.CPU38.PMI:Performance_monitoring_interrupts
    261.75 ± 16%    +214.3%     822.75 ± 35%  interrupts.CPU38.TLB:TLB_shootdowns
      3102           -19.2%       2507 ±  7%  interrupts.CPU39.CAL:Function_call_interrupts
    277.00 ± 11%    +150.2%     693.00 ± 45%  interrupts.CPU39.TLB:TLB_shootdowns
      3216 ±  5%     -25.3%       2402 ±  4%  interrupts.CPU4.CAL:Function_call_interrupts
    279.50 ± 16%    +110.9%     589.50 ± 27%  interrupts.CPU4.TLB:TLB_shootdowns
      3042 ±  4%     -18.9%       2467 ±  8%  interrupts.CPU40.CAL:Function_call_interrupts
    271.00 ± 21%    +230.0%     894.25 ± 21%  interrupts.CPU40.TLB:TLB_shootdowns
      6912           -41.5%       4041 ± 14%  interrupts.CPU41.NMI:Non-maskable_interrupts
      6912           -41.5%       4041 ± 14%  interrupts.CPU41.PMI:Performance_monitoring_interrupts
    258.50 ± 10%    +185.1%     737.00 ± 36%  interrupts.CPU41.TLB:TLB_shootdowns
      3154 ±  3%     -20.0%       2522 ±  9%  interrupts.CPU42.CAL:Function_call_interrupts
      6900           -41.4%       4047 ± 15%  interrupts.CPU42.NMI:Non-maskable_interrupts
      6900           -41.4%       4047 ± 15%  interrupts.CPU42.PMI:Performance_monitoring_interrupts
    230.00 ± 18%    +138.6%     548.75 ± 19%  interrupts.CPU42.TLB:TLB_shootdowns
      3247 ±  4%     -24.5%       2452 ±  8%  interrupts.CPU43.CAL:Function_call_interrupts
      6889           -39.7%       4154 ± 10%  interrupts.CPU43.NMI:Non-maskable_interrupts
      6889           -39.7%       4154 ± 10%  interrupts.CPU43.PMI:Performance_monitoring_interrupts
    246.50 ±  8%    +125.1%     554.75 ± 20%  interrupts.CPU43.TLB:TLB_shootdowns
      3127           -21.1%       2467 ±  8%  interrupts.CPU44.CAL:Function_call_interrupts
    248.50 ± 19%    +262.6%     901.00 ± 51%  interrupts.CPU44.TLB:TLB_shootdowns
      3181 ±  2%     -18.2%       2604 ± 12%  interrupts.CPU45.CAL:Function_call_interrupts
    236.00 ± 15%    +149.6%     589.00 ± 28%  interrupts.CPU45.TLB:TLB_shootdowns
      3187 ±  3%     -21.3%       2509 ±  9%  interrupts.CPU46.CAL:Function_call_interrupts
      6895           -44.8%       3803 ± 27%  interrupts.CPU46.NMI:Non-maskable_interrupts
      6895           -44.8%       3803 ± 27%  interrupts.CPU46.PMI:Performance_monitoring_interrupts
    261.25 ± 17%    +155.4%     667.25 ± 21%  interrupts.CPU46.TLB:TLB_shootdowns
      3048 ±  3%     -19.4%       2457 ±  6%  interrupts.CPU47.CAL:Function_call_interrupts
      6882 ±  2%     -53.0%       3237 ± 27%  interrupts.CPU47.NMI:Non-maskable_interrupts
      6882 ±  2%     -53.0%       3237 ± 27%  interrupts.CPU47.PMI:Performance_monitoring_interrupts
    222.25 ± 14%    +211.9%     693.25 ± 39%  interrupts.CPU47.TLB:TLB_shootdowns
      3300 ±  4%     -24.6%       2489 ±  4%  interrupts.CPU48.CAL:Function_call_interrupts
      6895           -50.2%       3433 ± 30%  interrupts.CPU48.NMI:Non-maskable_interrupts
      6895           -50.2%       3433 ± 30%  interrupts.CPU48.PMI:Performance_monitoring_interrupts
      3072 ±  4%     -20.3%       2449 ±  5%  interrupts.CPU49.CAL:Function_call_interrupts
      6017 ± 25%     -42.9%       3434 ± 22%  interrupts.CPU49.NMI:Non-maskable_interrupts
      6017 ± 25%     -42.9%       3434 ± 22%  interrupts.CPU49.PMI:Performance_monitoring_interrupts
    266.50 ± 17%    +128.4%     608.75 ± 20%  interrupts.CPU49.TLB:TLB_shootdowns
      2979 ±  4%     -18.5%       2428 ±  4%  interrupts.CPU5.CAL:Function_call_interrupts
    250.50 ± 13%    +112.2%     531.50 ± 15%  interrupts.CPU5.TLB:TLB_shootdowns
      3118 ±  3%     -23.1%       2397 ±  4%  interrupts.CPU50.CAL:Function_call_interrupts
      6915           -49.2%       3516 ± 23%  interrupts.CPU50.NMI:Non-maskable_interrupts
      6915           -49.2%       3516 ± 23%  interrupts.CPU50.PMI:Performance_monitoring_interrupts
    263.75 ± 19%    +171.2%     715.25 ± 27%  interrupts.CPU50.TLB:TLB_shootdowns
      3174 ±  5%     -22.7%       2454 ±  5%  interrupts.CPU51.CAL:Function_call_interrupts
    248.25 ± 20%    +162.1%     650.75 ± 26%  interrupts.CPU51.TLB:TLB_shootdowns
      3145 ±  3%     -22.0%       2453 ±  2%  interrupts.CPU52.CAL:Function_call_interrupts
      6049 ± 25%     -63.5%       2206 ± 33%  interrupts.CPU52.NMI:Non-maskable_interrupts
      6049 ± 25%     -63.5%       2206 ± 33%  interrupts.CPU52.PMI:Performance_monitoring_interrupts
    273.50 ± 17%    +101.7%     551.75 ± 13%  interrupts.CPU52.TLB:TLB_shootdowns
      3123 ±  5%     -22.2%       2429 ±  3%  interrupts.CPU53.CAL:Function_call_interrupts
      6877           -51.0%       3367 ± 38%  interrupts.CPU53.NMI:Non-maskable_interrupts
      6877           -51.0%       3367 ± 38%  interrupts.CPU53.PMI:Performance_monitoring_interrupts
    236.75 ± 26%    +178.9%     660.25 ± 31%  interrupts.CPU53.TLB:TLB_shootdowns
      3119 ±  4%     -20.9%       2467 ±  6%  interrupts.CPU54.CAL:Function_call_interrupts
      6925           -49.6%       3492 ± 38%  interrupts.CPU54.NMI:Non-maskable_interrupts
      6925           -49.6%       3492 ± 38%  interrupts.CPU54.PMI:Performance_monitoring_interrupts
    234.75 ± 24%    +155.7%     600.25 ± 23%  interrupts.CPU54.TLB:TLB_shootdowns
      3038 ±  4%     -20.0%       2429 ±  4%  interrupts.CPU55.CAL:Function_call_interrupts
    229.00 ± 29%    +176.2%     632.50 ± 27%  interrupts.CPU55.TLB:TLB_shootdowns
      3171           -23.2%       2435 ±  5%  interrupts.CPU56.CAL:Function_call_interrupts
    284.75 ± 31%    +172.6%     776.25 ± 16%  interrupts.CPU56.TLB:TLB_shootdowns
      3092           -19.9%       2477 ±  8%  interrupts.CPU57.CAL:Function_call_interrupts
      6050 ± 25%     -45.1%       3323 ± 39%  interrupts.CPU57.NMI:Non-maskable_interrupts
      6050 ± 25%     -45.1%       3323 ± 39%  interrupts.CPU57.PMI:Performance_monitoring_interrupts
      3071 ±  3%     -22.4%       2384 ±  3%  interrupts.CPU58.CAL:Function_call_interrupts
    300.75 ± 37%    +105.6%     618.25 ± 25%  interrupts.CPU58.TLB:TLB_shootdowns
      3120 ±  2%     -21.4%       2452 ±  4%  interrupts.CPU59.CAL:Function_call_interrupts
      5182 ± 33%     -60.7%       2037 ± 22%  interrupts.CPU59.NMI:Non-maskable_interrupts
      5182 ± 33%     -60.7%       2037 ± 22%  interrupts.CPU59.PMI:Performance_monitoring_interrupts
    274.25 ±  7%    +150.0%     685.50 ± 42%  interrupts.CPU59.TLB:TLB_shootdowns
      2994 ±  3%     -18.1%       2452 ±  5%  interrupts.CPU6.CAL:Function_call_interrupts
    183.50 ± 20%    +245.5%     634.00 ± 27%  interrupts.CPU6.TLB:TLB_shootdowns
      3088 ±  3%     -20.6%       2452 ±  5%  interrupts.CPU60.CAL:Function_call_interrupts
    262.50 ± 19%    +142.4%     636.25 ± 32%  interrupts.CPU60.TLB:TLB_shootdowns
      3117 ±  3%     -22.0%       2432 ±  4%  interrupts.CPU61.CAL:Function_call_interrupts
      6004 ± 23%     -57.8%       2533 ± 54%  interrupts.CPU61.NMI:Non-maskable_interrupts
      6004 ± 23%     -57.8%       2533 ± 54%  interrupts.CPU61.PMI:Performance_monitoring_interrupts
    279.25 ± 26%     +88.6%     526.75 ± 14%  interrupts.CPU61.TLB:TLB_shootdowns
      3059 ±  2%     -21.2%       2409 ±  3%  interrupts.CPU62.CAL:Function_call_interrupts
    262.00 ± 15%    +131.3%     606.00 ± 21%  interrupts.CPU62.TLB:TLB_shootdowns
      3080 ±  2%     -22.0%       2403 ±  3%  interrupts.CPU63.CAL:Function_call_interrupts
    249.25 ± 30%    +119.3%     546.50 ± 31%  interrupts.CPU63.TLB:TLB_shootdowns
      3193           -23.6%       2440 ±  5%  interrupts.CPU64.CAL:Function_call_interrupts
    251.25 ± 21%    +217.9%     798.75 ± 26%  interrupts.CPU64.TLB:TLB_shootdowns
      3067 ±  3%     -20.5%       2438 ±  5%  interrupts.CPU65.CAL:Function_call_interrupts
      6054 ± 25%     -49.5%       3060 ± 48%  interrupts.CPU65.NMI:Non-maskable_interrupts
      6054 ± 25%     -49.5%       3060 ± 48%  interrupts.CPU65.PMI:Performance_monitoring_interrupts
    217.50 ± 15%    +181.5%     612.25 ± 31%  interrupts.CPU65.TLB:TLB_shootdowns
      3020 ±  5%     -12.4%       2645 ±  6%  interrupts.CPU66.CAL:Function_call_interrupts
    221.00 ± 14%    +215.3%     696.75 ± 42%  interrupts.CPU66.TLB:TLB_shootdowns
      3088 ±  3%     -20.6%       2452 ±  4%  interrupts.CPU67.CAL:Function_call_interrupts
      5204 ± 34%     -46.4%       2789 ± 26%  interrupts.CPU67.NMI:Non-maskable_interrupts
      5204 ± 34%     -46.4%       2789 ± 26%  interrupts.CPU67.PMI:Performance_monitoring_interrupts
    262.50 ± 25%    +149.6%     655.25 ± 14%  interrupts.CPU67.TLB:TLB_shootdowns
      3190           -22.4%       2475 ±  7%  interrupts.CPU68.CAL:Function_call_interrupts
    226.00 ± 18%    +218.7%     720.25 ± 27%  interrupts.CPU68.TLB:TLB_shootdowns
      3072 ±  2%     -20.7%       2436 ±  4%  interrupts.CPU69.CAL:Function_call_interrupts
    232.00 ±  8%    +183.9%     658.75 ± 29%  interrupts.CPU69.TLB:TLB_shootdowns
      3036 ±  2%     -20.5%       2414 ±  6%  interrupts.CPU7.CAL:Function_call_interrupts
    248.25 ± 11%    +149.0%     618.25 ± 13%  interrupts.CPU7.TLB:TLB_shootdowns
      2987 ±  3%     -19.9%       2393 ±  5%  interrupts.CPU70.CAL:Function_call_interrupts
    196.50 ± 31%    +239.4%     667.00 ± 27%  interrupts.CPU70.TLB:TLB_shootdowns
      3139           -20.2%       2505 ±  8%  interrupts.CPU71.CAL:Function_call_interrupts
      5161 ± 34%     -56.6%       2239 ± 16%  interrupts.CPU71.NMI:Non-maskable_interrupts
      5161 ± 34%     -56.6%       2239 ± 16%  interrupts.CPU71.PMI:Performance_monitoring_interrupts
    234.75 ± 19%    +162.0%     615.00 ± 25%  interrupts.CPU71.TLB:TLB_shootdowns
      3323 ±  3%     -29.3%       2350 ±  4%  interrupts.CPU72.CAL:Function_call_interrupts
      1006 ±  3%     -57.8%     424.25 ± 10%  interrupts.CPU72.RES:Rescheduling_interrupts
    505.50 ± 14%     +69.3%     855.75 ± 22%  interrupts.CPU72.TLB:TLB_shootdowns
      3007 ±  4%     -21.7%       2354 ±  4%  interrupts.CPU73.CAL:Function_call_interrupts
    930.25 ±  2%     -54.6%     422.25 ± 13%  interrupts.CPU73.RES:Rescheduling_interrupts
    278.50 ±  7%    +133.9%     651.50 ± 34%  interrupts.CPU73.TLB:TLB_shootdowns
      3141 ±  4%     -27.7%       2272 ±  3%  interrupts.CPU74.CAL:Function_call_interrupts
    908.75 ±  2%     -52.7%     429.50 ± 13%  interrupts.CPU74.RES:Rescheduling_interrupts
    312.25 ±  8%    +128.1%     712.25 ± 32%  interrupts.CPU74.TLB:TLB_shootdowns
      3096 ±  2%     -25.6%       2303 ±  3%  interrupts.CPU75.CAL:Function_call_interrupts
      5160 ± 34%     -48.0%       2683 ± 28%  interrupts.CPU75.NMI:Non-maskable_interrupts
      5160 ± 34%     -48.0%       2683 ± 28%  interrupts.CPU75.PMI:Performance_monitoring_interrupts
    865.75 ±  2%     -46.4%     463.75 ±  9%  interrupts.CPU75.RES:Rescheduling_interrupts
    291.00 ± 17%    +114.7%     624.75 ± 19%  interrupts.CPU75.TLB:TLB_shootdowns
      3149 ±  2%     -25.1%       2358 ±  4%  interrupts.CPU76.CAL:Function_call_interrupts
    940.25 ±  5%     -53.4%     438.00 ± 20%  interrupts.CPU76.RES:Rescheduling_interrupts
    354.00 ± 27%    +107.3%     733.75 ± 29%  interrupts.CPU76.TLB:TLB_shootdowns
      3165 ±  7%     -26.6%       2323 ±  4%  interrupts.CPU77.CAL:Function_call_interrupts
    932.75 ±  5%     -56.0%     410.75 ± 16%  interrupts.CPU77.RES:Rescheduling_interrupts
    286.25 ± 27%    +133.0%     667.00 ± 27%  interrupts.CPU77.TLB:TLB_shootdowns
      3010           -24.4%       2277 ±  3%  interrupts.CPU78.CAL:Function_call_interrupts
    931.00 ±  4%     -53.4%     433.50 ± 15%  interrupts.CPU78.RES:Rescheduling_interrupts
    222.25 ± 11%    +170.6%     601.50 ± 19%  interrupts.CPU78.TLB:TLB_shootdowns
      3122 ±  2%     -24.4%       2359 ±  4%  interrupts.CPU79.CAL:Function_call_interrupts
    852.50 ± 10%     -49.0%     434.50 ± 12%  interrupts.CPU79.RES:Rescheduling_interrupts
    238.75 ±  7%    +272.9%     890.25 ± 19%  interrupts.CPU79.TLB:TLB_shootdowns
      3120           -23.3%       2391 ±  3%  interrupts.CPU8.CAL:Function_call_interrupts
      6904           -41.3%       4050 ±  6%  interrupts.CPU8.NMI:Non-maskable_interrupts
      6904           -41.3%       4050 ±  6%  interrupts.CPU8.PMI:Performance_monitoring_interrupts
      3070 ±  4%     -24.2%       2328 ±  3%  interrupts.CPU80.CAL:Function_call_interrupts
    917.00 ±  3%     -54.5%     417.25 ±  7%  interrupts.CPU80.RES:Rescheduling_interrupts
    316.00 ± 20%     +68.1%     531.25 ±  2%  interrupts.CPU80.TLB:TLB_shootdowns
      3120 ±  6%     -26.0%       2309 ±  4%  interrupts.CPU81.CAL:Function_call_interrupts
    922.25 ±  3%     -55.1%     414.50 ±  8%  interrupts.CPU81.RES:Rescheduling_interrupts
    255.75 ±  6%    +130.5%     589.50 ±  9%  interrupts.CPU81.TLB:TLB_shootdowns
      3082 ±  4%     -24.4%       2329 ±  5%  interrupts.CPU82.CAL:Function_call_interrupts
      6910           -52.0%       3314 ± 35%  interrupts.CPU82.NMI:Non-maskable_interrupts
      6910           -52.0%       3314 ± 35%  interrupts.CPU82.PMI:Performance_monitoring_interrupts
    872.25 ±  6%     -52.6%     413.75 ± 12%  interrupts.CPU82.RES:Rescheduling_interrupts
    237.75 ±  6%    +169.5%     640.75 ± 30%  interrupts.CPU82.TLB:TLB_shootdowns
      3108 ±  5%     -26.5%       2285 ±  2%  interrupts.CPU83.CAL:Function_call_interrupts
    973.00 ±  6%     -59.6%     393.25 ± 12%  interrupts.CPU83.RES:Rescheduling_interrupts
    238.25 ± 15%    +135.5%     561.00 ± 19%  interrupts.CPU83.TLB:TLB_shootdowns
      3173 ±  6%     -27.3%       2307 ±  3%  interrupts.CPU84.CAL:Function_call_interrupts
    973.25 ±  9%     -57.4%     414.25 ± 11%  interrupts.CPU84.RES:Rescheduling_interrupts
    261.25 ±  7%    +153.5%     662.25 ± 23%  interrupts.CPU84.TLB:TLB_shootdowns
      3196 ±  3%     -27.3%       2324 ±  3%  interrupts.CPU85.CAL:Function_call_interrupts
    964.00 ±  5%     -54.8%     435.50 ±  8%  interrupts.CPU85.RES:Rescheduling_interrupts
    313.75 ±  7%     +96.7%     617.00 ± 43%  interrupts.CPU85.TLB:TLB_shootdowns
      3105 ±  3%     -25.8%       2305 ±  3%  interrupts.CPU86.CAL:Function_call_interrupts
    879.75 ±  8%     -53.8%     406.50 ± 12%  interrupts.CPU86.RES:Rescheduling_interrupts
    243.75 ± 33%    +168.0%     653.25 ±  7%  interrupts.CPU86.TLB:TLB_shootdowns
      3120 ±  2%     -24.2%       2366 ±  3%  interrupts.CPU87.CAL:Function_call_interrupts
    904.25 ±  7%     -51.8%     435.75 ± 10%  interrupts.CPU87.RES:Rescheduling_interrupts
    293.50 ± 29%    +648.7%       2197 ±117%  interrupts.CPU87.TLB:TLB_shootdowns
      3273 ±  5%     -29.8%       2297 ±  2%  interrupts.CPU88.CAL:Function_call_interrupts
    980.00 ±  4%     -58.5%     407.00 ± 11%  interrupts.CPU88.RES:Rescheduling_interrupts
    248.25 ± 16%    +150.2%     621.00 ± 12%  interrupts.CPU88.TLB:TLB_shootdowns
      3101 ±  4%     -25.6%       2307 ±  3%  interrupts.CPU89.CAL:Function_call_interrupts
    856.50 ±  6%     -48.9%     437.25 ± 11%  interrupts.CPU89.RES:Rescheduling_interrupts
    230.50 ± 18%    +173.9%     631.25 ± 16%  interrupts.CPU89.TLB:TLB_shootdowns
      3069 ±  4%     -21.0%       2424 ±  5%  interrupts.CPU9.CAL:Function_call_interrupts
      6914           -47.3%       3646 ± 27%  interrupts.CPU9.NMI:Non-maskable_interrupts
      6914           -47.3%       3646 ± 27%  interrupts.CPU9.PMI:Performance_monitoring_interrupts
    204.75 ± 10%    +228.8%     673.25 ± 41%  interrupts.CPU9.TLB:TLB_shootdowns
      3046 ±  3%     -22.1%       2371 ±  5%  interrupts.CPU90.CAL:Function_call_interrupts
    909.75 ±  9%     -50.3%     452.00 ±  3%  interrupts.CPU90.RES:Rescheduling_interrupts
    219.00 ±  5%    +154.0%     556.25 ± 27%  interrupts.CPU90.TLB:TLB_shootdowns
      3093 ±  4%     -24.4%       2337 ±  4%  interrupts.CPU91.CAL:Function_call_interrupts
    880.50 ±  5%     -50.6%     435.00 ±  8%  interrupts.CPU91.RES:Rescheduling_interrupts
      3175 ±  2%     -24.3%       2402 ±  3%  interrupts.CPU92.CAL:Function_call_interrupts
      6898           -42.1%       3996 ± 24%  interrupts.CPU92.NMI:Non-maskable_interrupts
      6898           -42.1%       3996 ± 24%  interrupts.CPU92.PMI:Performance_monitoring_interrupts
    892.75 ±  3%     -48.5%     459.50 ± 19%  interrupts.CPU92.RES:Rescheduling_interrupts
    257.25 ±  8%    +134.1%     602.25 ±  6%  interrupts.CPU92.TLB:TLB_shootdowns
      3110 ±  2%     -23.0%       2396 ±  9%  interrupts.CPU93.CAL:Function_call_interrupts
    892.50 ±  6%     -51.3%     434.25 ±  5%  interrupts.CPU93.RES:Rescheduling_interrupts
    307.25 ± 25%    +151.4%     772.50 ± 29%  interrupts.CPU93.TLB:TLB_shootdowns
      2953 ±  4%     -18.1%       2420 ±  3%  interrupts.CPU94.CAL:Function_call_interrupts
    775.25 ±  2%     -44.8%     428.25 ± 11%  interrupts.CPU94.RES:Rescheduling_interrupts
    219.50 ± 20%    +156.6%     563.25 ± 13%  interrupts.CPU94.TLB:TLB_shootdowns
      3130 ±  2%     -26.5%       2301 ±  4%  interrupts.CPU95.CAL:Function_call_interrupts
    811.50 ±  7%     -47.9%     422.75 ± 14%  interrupts.CPU95.RES:Rescheduling_interrupts
    275.75 ± 24%    +165.4%     731.75 ± 27%  interrupts.CPU95.TLB:TLB_shootdowns
      3156 ±  2%     -23.5%       2413 ±  5%  interrupts.CPU96.CAL:Function_call_interrupts
    266.75 ± 33%    +177.4%     740.00 ± 24%  interrupts.CPU96.TLB:TLB_shootdowns
      3097 ±  4%     -21.5%       2432 ±  4%  interrupts.CPU97.CAL:Function_call_interrupts
    295.25 ±  3%     +99.6%     589.25 ± 44%  interrupts.CPU97.TLB:TLB_shootdowns
      3152 ±  5%     -23.0%       2428 ±  5%  interrupts.CPU98.CAL:Function_call_interrupts
      3033 ±  5%     -19.5%       2441 ±  6%  interrupts.CPU99.CAL:Function_call_interrupts
    242.00 ±  9%    +129.2%     554.75 ± 17%  interrupts.CPU99.TLB:TLB_shootdowns
    342.50 ±  8%     -34.2%     225.25 ± 21%  interrupts.IWI:IRQ_work_interrupts
   1173915 ±  8%     -36.7%     743206 ± 11%  interrupts.NMI:Non-maskable_interrupts
   1173915 ±  8%     -36.7%     743206 ± 11%  interrupts.PMI:Performance_monitoring_interrupts
     50587 ± 12%    +140.0%     121421 ± 17%  interrupts.TLB:TLB_shootdowns



***************************************************************************************************
lkp-csl-2ap3: 192 threads Intel(R) Xeon(R) Platinum 9242 CPU @ 2.30GHz with 192G memory
=========================================================================================
compiler/cpufreq_governor/kconfig/nr_task/rootfs/runtime/tbox_group/test/testcase/ucode:
  gcc-9/performance/x86_64-rhel-8.3/100%/debian-10.4-x86_64-20200603.cgz/300s/lkp-csl-2ap3/new_fserver/reaim/0x5003003

commit: 
  268df4df6c ("locking/qspinlock: Refactor the qspinlock slow path")
  0dd6d5b8c0 ("locking/qspinlock: Introduce CNA into the slow path of qspinlock")

268df4df6cb0a27d 0dd6d5b8c0f6f31d8d557485fff 
---------------- --------------------------- 
       fail:runs  %reproduction    fail:runs
           |             |             |    
           :4            7%           0:4     perf-profile.children.cycles-pp.error_entry
         %stddev     %change         %stddev
             \          |                \  
    580.05           -63.9%     209.51 ±  2%  reaim.child_systime
     48.73            +4.6%      50.98        reaim.child_utime
    308230           +99.3%     614239        reaim.jobs_per_min
      1605           +99.3%       3199        reaim.jobs_per_min_child
     91.95            -9.8%      82.94        reaim.jti
    315365          +106.8%     652136 ±  2%  reaim.max_jobs_per_min
      3.66           -49.8%       1.84        reaim.parent_time
      7.59 ±  7%    +118.0%      16.55 ±  2%  reaim.std_dev_percent
    487174            +8.5%     528537 ±  2%  reaim.time.involuntary_context_switches
     36314 ±  2%     +94.5%      70633 ±  2%  reaim.time.major_page_faults
 1.021e+08           +46.3%  1.494e+08        reaim.time.minor_page_faults
     11035           -39.1%       6724        reaim.time.percent_of_cpu_this_job_got
     30887           -47.1%      16341        reaim.time.system_time
      2595           +53.2%       3977        reaim.time.user_time
   2620964 ±  7%     +34.1%    3514107 ±  4%  reaim.time.voluntary_context_switches
   1022400           +46.5%    1497600        reaim.workload
     29324           +41.6%      41513        uptime.idle
  11296948 ± 16%     +81.4%   20495173 ±  9%  cpuidle.C1.time
    240637 ± 16%     +64.9%     396901 ±  7%  cpuidle.C1.usage
     20079           +55.4%      31198 ±  2%  meminfo.PageTables
    475694           +13.0%     537556        meminfo.SUnreclaim
    609283           +11.9%     681905        meminfo.Slab
     40.64           +20.7       61.39        mpstat.cpu.all.idle%
      0.69 ±  2%      +1.5        2.16 ±  4%  mpstat.cpu.all.soft%
     52.92           -24.7       28.19        mpstat.cpu.all.sys%
      4.38            +2.3        6.68        mpstat.cpu.all.usr%
     40.75           +49.1%      60.75        vmstat.cpu.id
     54.00           -42.1%      31.25        vmstat.cpu.sy
    112.50           -24.7%      84.75        vmstat.procs.r
     23383 ±  4%     +40.2%      32778 ±  2%  vmstat.system.cs
  18423952           +43.6%   26451079 ±  5%  numa-numastat.node0.local_node
  18439508           +43.5%   26469740 ±  5%  numa-numastat.node0.numa_hit
  18349839           +48.1%   27179454 ±  3%  numa-numastat.node1.local_node
  18373212           +48.0%   27198273 ±  3%  numa-numastat.node1.numa_hit
  18505142           +49.5%   27672325 ±  4%  numa-numastat.node2.local_node
  18536251           +49.4%   27700404 ±  4%  numa-numastat.node2.numa_hit
  18377452           +45.3%   26694302        numa-numastat.node3.local_node
  18400838           +45.2%   26722370        numa-numastat.node3.numa_hit
    250525 ±  6%      -8.1%     230224        numa-meminfo.node0.Unevictable
      8325 ± 15%     +18.8%       9888 ± 14%  numa-meminfo.node1.KernelStack
    116748 ± 15%     +21.6%     141947 ± 17%  numa-meminfo.node1.SUnreclaim
    145863 ± 19%     +26.2%     184104 ± 16%  numa-meminfo.node1.Slab
     23083 ±  6%     +39.4%      32186 ± 22%  numa-meminfo.node2.KReclaimable
      3045 ± 13%    +192.1%       8896 ± 37%  numa-meminfo.node2.PageTables
     23083 ±  6%     +39.4%      32186 ± 22%  numa-meminfo.node2.SReclaimable
    102954 ±  2%     +36.2%     140237 ± 20%  numa-meminfo.node2.SUnreclaim
    126039 ±  3%     +36.8%     172424 ± 20%  numa-meminfo.node2.Slab
     13098 ± 17%     -25.5%       9753 ± 24%  numa-meminfo.node3.Mapped
     80547 ±  7%     -12.9%      70139 ± 11%  numa-meminfo.node3.Shmem
     22.50 ±173%    +508.9%     137.00 ± 19%  numa-vmstat.node0.nr_mlock
     62631 ±  6%      -8.1%      57555        numa-vmstat.node0.nr_unevictable
     62631 ±  6%      -8.1%      57555        numa-vmstat.node0.nr_zone_unevictable
   9727800           +40.6%   13678916 ±  5%  numa-vmstat.node0.numa_hit
   9695462           +40.4%   13613317 ±  5%  numa-vmstat.node0.numa_local
      8318 ± 15%     +19.1%       9911 ± 14%  numa-vmstat.node1.nr_kernel_stack
     29168 ± 15%     +20.9%      35263 ± 17%  numa-vmstat.node1.nr_slab_unreclaimable
   9675812           +47.2%   14244087 ±  3%  numa-vmstat.node1.numa_hit
   9572293           +47.8%   14145237 ±  3%  numa-vmstat.node1.numa_local
     22.50 ±173%    +366.7%     105.00 ± 24%  numa-vmstat.node2.nr_mlock
    752.50 ± 12%    +198.7%       2247 ± 36%  numa-vmstat.node2.nr_page_table_pages
      5767 ±  6%     +39.6%       8052 ± 21%  numa-vmstat.node2.nr_slab_reclaimable
     25697 ±  2%     +36.1%      34967 ± 20%  numa-vmstat.node2.nr_slab_unreclaimable
   9672328           +47.9%   14308238 ±  4%  numa-vmstat.node2.numa_hit
   9560418           +48.7%   14215114 ±  4%  numa-vmstat.node2.numa_local
     20148 ±  7%     -12.8%      17565 ± 11%  numa-vmstat.node3.nr_shmem
   9638864           +42.5%   13735173        numa-vmstat.node3.numa_hit
   9550094           +43.0%   13656309        numa-vmstat.node3.numa_local
     79974            -4.0%      76778        proc-vmstat.nr_anon_pages
     82887            -4.2%      79380        proc-vmstat.nr_inactive_anon
     32921 ±  2%      +7.5%      35402 ±  2%  proc-vmstat.nr_kernel_stack
      5006           +54.1%       7715 ±  2%  proc-vmstat.nr_page_table_pages
     33389            +8.0%      36051        proc-vmstat.nr_slab_reclaimable
    118846           +13.1%     134384        proc-vmstat.nr_slab_unreclaimable
     82887            -4.2%      79380        proc-vmstat.nr_zone_inactive_anon
    147444 ± 11%     -89.5%      15500 ± 31%  proc-vmstat.numa_hint_faults
     12529 ± 24%     -59.6%       5055 ± 50%  proc-vmstat.numa_hint_faults_local
  73787768           +46.5%  1.081e+08        proc-vmstat.numa_hit
  73694311           +46.6%   1.08e+08        proc-vmstat.numa_local
    147314 ± 14%     -81.1%      27849 ± 30%  proc-vmstat.numa_pages_migrated
    275787 ±  8%     -41.4%     161678 ± 11%  proc-vmstat.numa_pte_updates
     73285 ±  3%     +26.6%      92805 ±  4%  proc-vmstat.pgactivate
  81210043           +47.8%    1.2e+08        proc-vmstat.pgalloc_normal
 1.034e+08           +45.8%  1.507e+08        proc-vmstat.pgfault
  81244165           +47.8%    1.2e+08        proc-vmstat.pgfree
    147312 ± 14%     -81.1%      27849 ± 30%  proc-vmstat.pgmigrate_success
  10448829           +47.0%   15362598        proc-vmstat.pgreuse
    237348           +17.1%     277838        slabinfo.dentry.active_objs
      5725           +17.3%       6715        slabinfo.dentry.active_slabs
    240463           +17.3%     282048        slabinfo.dentry.num_objs
      5725           +17.3%       6715        slabinfo.dentry.num_slabs
      1002 ±  4%     +18.7%       1190 ±  7%  slabinfo.file_lock_cache.active_objs
      1002 ±  4%     +18.7%       1190 ±  7%  slabinfo.file_lock_cache.num_objs
     14199           +15.1%      16343        slabinfo.files_cache.active_objs
     14199           +15.1%      16343        slabinfo.files_cache.num_objs
    144232           +61.3%     232576 ±  2%  slabinfo.filp.active_objs
      2271           +61.5%       3667 ±  2%  slabinfo.filp.active_slabs
    145386           +61.5%     234748 ±  2%  slabinfo.filp.num_objs
      2271           +61.5%       3667 ±  2%  slabinfo.filp.num_slabs
      1040           +22.6%       1275        slabinfo.kmalloc-512.active_slabs
     66610           +22.6%      81641        slabinfo.kmalloc-512.num_objs
      1040           +22.6%       1275        slabinfo.kmalloc-512.num_slabs
    115497           +10.3%     127406        slabinfo.kmalloc-8.active_objs
    116436            +9.7%     127784        slabinfo.kmalloc-8.num_objs
      2808 ±  6%     +15.6%       3246 ±  5%  slabinfo.kmalloc-rcl-512.active_objs
      2808 ±  6%     +15.6%       3246 ±  5%  slabinfo.kmalloc-rcl-512.num_objs
      4232 ±  7%     +14.5%       4848 ±  3%  slabinfo.kmalloc-rcl-64.active_objs
      4232 ±  7%     +14.5%       4848 ±  3%  slabinfo.kmalloc-rcl-64.num_objs
      1740 ±  6%     +12.3%       1954 ±  4%  slabinfo.kmalloc-rcl-96.active_objs
      1740 ±  6%     +12.3%       1954 ±  4%  slabinfo.kmalloc-rcl-96.num_objs
     10840           +19.8%      12983        slabinfo.mm_struct.active_objs
     10851           +19.7%      12985        slabinfo.mm_struct.num_objs
     36338           +60.9%      58469 ±  3%  slabinfo.pid.active_objs
    567.25           +61.0%     913.00 ±  3%  slabinfo.pid.active_slabs
     36338           +60.9%      58470 ±  3%  slabinfo.pid.num_objs
    567.25           +61.0%     913.00 ±  3%  slabinfo.pid.num_slabs
      8815           +17.6%      10365        slabinfo.sighand_cache.active_objs
    593.00           +17.1%     694.50        slabinfo.sighand_cache.active_slabs
      8902           +17.1%      10424        slabinfo.sighand_cache.num_objs
    593.00           +17.1%     694.50        slabinfo.sighand_cache.num_slabs
     14159 ±  5%      -7.0%      13167 ±  3%  slabinfo.skbuff_head_cache.active_objs
     14159 ±  5%      -6.9%      13183 ±  3%  slabinfo.skbuff_head_cache.num_objs
      8481           +16.5%       9879 ±  2%  slabinfo.sock_inode_cache.active_objs
      8481           +16.5%       9879 ±  2%  slabinfo.sock_inode_cache.num_objs
     40933           +57.2%      64330 ±  3%  slabinfo.task_delay_info.active_objs
    802.00           +57.3%       1261 ±  3%  slabinfo.task_delay_info.active_slabs
     40933           +57.2%      64346 ±  3%  slabinfo.task_delay_info.num_objs
    802.00           +57.3%       1261 ±  3%  slabinfo.task_delay_info.num_slabs
      3083           +32.5%       4086        slabinfo.task_struct.active_objs
      3093           +32.5%       4099        slabinfo.task_struct.active_slabs
      3093           +32.5%       4099        slabinfo.task_struct.num_objs
      3093           +32.5%       4099        slabinfo.task_struct.num_slabs
     78028 ± 11%     -29.7%      54877        sched_debug.cfs_rq:/.exec_clock.avg
     80138 ± 11%     -28.8%      57025        sched_debug.cfs_rq:/.exec_clock.max
     76374 ± 11%     -30.3%      53231        sched_debug.cfs_rq:/.exec_clock.min
    492.40 ±  4%     +38.6%     682.52 ± 13%  sched_debug.cfs_rq:/.exec_clock.stddev
    384713 ± 13%     +84.3%     709188 ± 21%  sched_debug.cfs_rq:/.load.max
     44276 ± 33%    +131.4%     102438 ± 30%  sched_debug.cfs_rq:/.load.stddev
     17.15 ± 49%     +92.8%      33.07 ± 19%  sched_debug.cfs_rq:/.load_avg.avg
  15175761 ± 11%     -38.0%    9414410        sched_debug.cfs_rq:/.min_vruntime.avg
  15409350 ± 11%     -37.0%    9711919        sched_debug.cfs_rq:/.min_vruntime.max
  14613313 ± 12%     -38.3%    9015191        sched_debug.cfs_rq:/.min_vruntime.min
    108791 ±  7%     +20.2%     130813 ±  3%  sched_debug.cfs_rq:/.min_vruntime.stddev
      0.58 ± 12%     -56.0%       0.26 ± 33%  sched_debug.cfs_rq:/.nr_running.avg
     90.99 ±  8%     +93.3%     175.91 ±  3%  sched_debug.cfs_rq:/.nr_spread_over.avg
    127.63 ±  8%    +185.9%     364.88 ± 10%  sched_debug.cfs_rq:/.nr_spread_over.max
     63.51 ± 12%    +116.3%     137.38 ±  4%  sched_debug.cfs_rq:/.nr_spread_over.min
     11.35 ±  6%     +94.0%      22.03 ± 14%  sched_debug.cfs_rq:/.nr_spread_over.stddev
    591.29 ± 10%     -60.6%     232.90 ± 32%  sched_debug.cfs_rq:/.runnable_avg.avg
    115.17 ± 49%     -91.6%       9.71 ± 65%  sched_debug.cfs_rq:/.runnable_avg.min
     75119 ±116%    +391.9%     369477 ± 17%  sched_debug.cfs_rq:/.spread0.avg
    307782 ± 34%    +116.8%     667294 ± 10%  sched_debug.cfs_rq:/.spread0.max
   -489162           -94.0%     -29215        sched_debug.cfs_rq:/.spread0.min
    108727 ±  7%     +20.2%     130729 ±  3%  sched_debug.cfs_rq:/.spread0.stddev
    584.06 ±  9%     -63.2%     215.03 ± 31%  sched_debug.cfs_rq:/.util_avg.avg
    108.86 ± 49%     -91.7%       9.08 ± 75%  sched_debug.cfs_rq:/.util_avg.min
    325.02 ± 12%     -79.6%      66.15 ± 44%  sched_debug.cfs_rq:/.util_est_enqueued.avg
    856.69 ± 14%     -26.8%     627.17 ± 16%  sched_debug.cfs_rq:/.util_est_enqueued.max
    167.46 ± 14%     -36.0%     107.22 ± 22%  sched_debug.cfs_rq:/.util_est_enqueued.stddev
    755311 ±  5%     +16.7%     881570 ±  5%  sched_debug.cpu.avg_idle.avg
     13.88 ±  9%     -31.4%       9.52 ±  9%  sched_debug.cpu.clock.stddev
     43862 ±  4%     -55.0%      19758 ± 20%  sched_debug.cpu.curr->pid.avg
     70749 ± 10%     +26.2%      89256 ±  7%  sched_debug.cpu.curr->pid.max
      9754 ± 44%     +61.6%      15762 ± 25%  sched_debug.cpu.curr->pid.stddev
      0.00 ± 14%     -25.7%       0.00 ± 21%  sched_debug.cpu.next_balance.stddev
      0.59 ± 13%     -52.0%       0.28 ± 40%  sched_debug.cpu.nr_running.avg
     18063 ±  7%     +51.6%      27376 ±  2%  sched_debug.cpu.nr_switches.avg
     33183 ±  6%     +30.4%      43285 ±  2%  sched_debug.cpu.nr_switches.max
     14660 ±  8%     +62.3%      23797 ±  2%  sched_debug.cpu.nr_switches.min
    199.38 ±  7%     +16.0%     231.25 ±  7%  sched_debug.cpu.nr_uninterruptible.max
     21.22 ±  4%     +31.3%      27.85 ±  4%  sched_debug.cpu.nr_uninterruptible.stddev
     17082 ±  7%     +56.1%      26667 ±  3%  sched_debug.cpu.sched_count.avg
     29035 ±  6%     +39.7%      40567 ±  3%  sched_debug.cpu.sched_count.max
     13957 ±  7%     +67.8%      23425 ±  3%  sched_debug.cpu.sched_count.min
      1823 ±  7%     +14.5%       2088        sched_debug.cpu.sched_count.stddev
      6490 ±  7%     +70.9%      11095 ±  2%  sched_debug.cpu.sched_goidle.avg
     12293 ±  6%     +46.6%      18021 ±  3%  sched_debug.cpu.sched_goidle.max
      5199 ±  7%     +85.3%       9633 ±  3%  sched_debug.cpu.sched_goidle.min
    795.70 ±  6%     +24.0%     986.52        sched_debug.cpu.sched_goidle.stddev
      6439 ±  7%     +48.1%       9537 ±  6%  sched_debug.cpu.ttwu_count.avg
     14497 ± 12%     +27.8%      18532 ±  4%  sched_debug.cpu.ttwu_count.max
      5120 ±  7%     +62.0%       8296 ±  6%  sched_debug.cpu.ttwu_count.min
    951.33 ± 12%     +19.8%       1139 ±  3%  sched_debug.cpu.ttwu_count.stddev
      2056 ± 11%     +37.8%       2833        sched_debug.cpu.ttwu_local.avg
      1606 ± 12%     +56.0%       2506        sched_debug.cpu.ttwu_local.min
    319.64 ± 15%     -28.0%     230.25 ±  9%  sched_debug.cpu.ttwu_local.stddev
      5.03 ± 10%    +128.6%      11.50 ± 79%  perf-stat.i.MPKI
 1.362e+10           +13.2%  1.542e+10        perf-stat.i.branch-instructions
      0.89 ± 12%      +0.8        1.69 ± 59%  perf-stat.i.branch-miss-rate%
  79850445           +53.2%  1.223e+08 ±  4%  perf-stat.i.branch-misses
     33.59 ±  5%     -14.4       19.17 ± 16%  perf-stat.i.cache-miss-rate%
  69403587           -17.3%   57420534        perf-stat.i.cache-misses
 1.963e+08           +65.5%  3.249e+08 ±  9%  perf-stat.i.cache-references
     23239 ±  5%     +42.9%      33219        perf-stat.i.context-switches
      4.91           -27.9%       3.54 ± 11%  perf-stat.i.cpi
    192188            +8.3%     208120        perf-stat.i.cpu-clock
 3.405e+11           -26.7%  2.495e+11        perf-stat.i.cpu-cycles
      2969           +67.5%       4973        perf-stat.i.cpu-migrations
      4279 ±  3%     -21.9%       3340 ±  3%  perf-stat.i.cycles-between-cache-misses
   2458693 ± 17%     +57.4%    3870988 ± 27%  perf-stat.i.dTLB-load-misses
 1.235e+10            +7.1%  1.323e+10        perf-stat.i.dTLB-loads
    944169 ±  5%     +52.4%    1438481 ±  9%  perf-stat.i.dTLB-store-misses
 2.445e+09           +50.8%  3.688e+09        perf-stat.i.dTLB-stores
     69.46            -6.0       63.45 ±  2%  perf-stat.i.iTLB-load-miss-rate%
   8267439           +36.9%   11316682 ±  3%  perf-stat.i.iTLB-load-misses
   3530473           +50.4%    5309255 ±  8%  perf-stat.i.iTLB-loads
 6.498e+10           +20.5%  7.833e+10        perf-stat.i.instructions
      7086           -28.0%       5103 ±  3%  perf-stat.i.instructions-per-iTLB-miss
      0.24           +28.8%       0.31 ±  5%  perf-stat.i.ipc
    117.84 ±  2%    +100.0%     235.73 ±  3%  perf-stat.i.major-faults
      1.78           -41.3%       1.04        perf-stat.i.metric.GHz
      0.54 ±  2%     +33.0%       0.72 ±  4%  perf-stat.i.metric.K/sec
    325144           +52.7%     496525        perf-stat.i.minor-faults
     91.30            -4.0       87.30        perf-stat.i.node-load-miss-rate%
  18841481           -16.9%   15661971        perf-stat.i.node-load-misses
   1541020           +48.7%    2291048        perf-stat.i.node-loads
     86.54           -10.0       76.56        perf-stat.i.node-store-miss-rate%
   9300730           -23.7%    7095923        perf-stat.i.node-store-misses
   1023696          +105.2%    2100476        perf-stat.i.node-stores
    325262           +52.7%     496761        perf-stat.i.page-faults
    192188            +8.3%     208120        perf-stat.i.task-clock
      3.01           +40.6%       4.23 ±  8%  perf-stat.overall.MPKI
      0.58            +0.2        0.81 ±  4%  perf-stat.overall.branch-miss-rate%
     35.40           -16.4       18.96 ±  7%  perf-stat.overall.cache-miss-rate%
      5.28           -42.0%       3.06        perf-stat.overall.cpi
      4957           -22.5%       3843 ±  2%  perf-stat.overall.cycles-between-cache-misses
      0.02 ± 16%      +0.0        0.03 ± 23%  perf-stat.overall.dTLB-load-miss-rate%
     70.38            -2.4       67.93        perf-stat.overall.iTLB-load-miss-rate%
      7982           -13.7%       6891 ±  3%  perf-stat.overall.instructions-per-iTLB-miss
      0.19           +72.4%       0.33        perf-stat.overall.ipc
     92.44            -5.0       87.41        perf-stat.overall.node-load-miss-rate%
     90.13           -11.2       78.88        perf-stat.overall.node-store-miss-rate%
  19779867           -23.8%   15068108        perf-stat.overall.path-length
 1.391e+10            +5.5%  1.467e+10        perf-stat.ps.branch-instructions
  81069199           +46.6%  1.189e+08 ±  4%  perf-stat.ps.branch-misses
  70564158           -16.2%   59153436        perf-stat.ps.cache-misses
 1.994e+08           +57.6%  3.142e+08 ±  8%  perf-stat.ps.cache-references
     23460 ±  5%     +40.3%      32916 ±  2%  perf-stat.ps.context-switches
 3.497e+11           -35.0%  2.273e+11        perf-stat.ps.cpu-cycles
      3006           +61.1%       4843        perf-stat.ps.cpu-migrations
   2475057 ± 16%     +52.8%    3783052 ± 25%  perf-stat.ps.dTLB-load-misses
    955171 ±  5%     +45.8%    1392345 ±  9%  perf-stat.ps.dTLB-store-misses
 2.483e+09           +43.9%  3.575e+09        perf-stat.ps.dTLB-stores
   8297566           +29.9%   10779389 ±  2%  perf-stat.ps.iTLB-load-misses
   3491097           +46.1%    5100477 ±  7%  perf-stat.ps.iTLB-loads
 6.622e+10           +12.0%   7.42e+10        perf-stat.ps.instructions
    119.72 ±  2%     +94.8%     233.20 ±  2%  perf-stat.ps.major-faults
    330809           +46.4%     484209        perf-stat.ps.minor-faults
  19154438           -14.8%   16321205        perf-stat.ps.node-load-misses
   1567053           +50.0%    2350067        perf-stat.ps.node-loads
   9463142           -22.0%    7380495 ±  2%  perf-stat.ps.node-store-misses
   1036485           +90.6%    1975456        perf-stat.ps.node-stores
    330929           +46.4%     484442        perf-stat.ps.page-faults
 2.022e+13           +11.6%  2.256e+13        perf-stat.total.instructions
     29903 ±  4%     +29.9%      38840 ±  8%  softirqs.CPU0.NET_RX
     24359           +38.8%      33812        softirqs.CPU0.SCHED
     27294 ±  3%     +43.0%      39032 ± 14%  softirqs.CPU1.NET_RX
     23282 ±  2%     +36.9%      31884        softirqs.CPU1.SCHED
     22121           +42.4%      31509        softirqs.CPU10.SCHED
     28269 ±  7%     +39.7%      39504 ±  5%  softirqs.CPU100.NET_RX
     22644           +40.4%      31788        softirqs.CPU100.SCHED
     26674 ±  2%     +40.6%      37514 ±  8%  softirqs.CPU101.NET_RX
     22528           +39.8%      31503 ±  2%  softirqs.CPU101.SCHED
     26219 ±  8%     +38.8%      36391 ±  7%  softirqs.CPU102.NET_RX
     22293           +41.8%      31620        softirqs.CPU102.SCHED
     24911 ± 13%     +44.3%      35951 ± 11%  softirqs.CPU103.NET_RX
     22022 ±  2%     +43.0%      31483        softirqs.CPU103.SCHED
     27555 ±  8%     +35.0%      37204 ± 11%  softirqs.CPU104.NET_RX
     22396           +40.0%      31364        softirqs.CPU104.SCHED
     25931 ±  6%     +48.6%      38531 ±  9%  softirqs.CPU105.NET_RX
     22130           +42.8%      31602        softirqs.CPU105.SCHED
     25651 ±  7%     +45.4%      37302 ± 10%  softirqs.CPU106.NET_RX
     22340           +41.6%      31629        softirqs.CPU106.SCHED
     25996 ±  6%     +42.8%      37115 ±  5%  softirqs.CPU107.NET_RX
     22347           +40.6%      31429 ±  2%  softirqs.CPU107.SCHED
     25496 ±  8%     +52.7%      38924 ±  4%  softirqs.CPU108.NET_RX
     22127           +42.8%      31593        softirqs.CPU108.SCHED
     26191 ±  2%     +49.8%      39246 ±  9%  softirqs.CPU109.NET_RX
     22296           +40.5%      31328        softirqs.CPU109.SCHED
     22292           +40.8%      31377        softirqs.CPU11.SCHED
     27609 ± 10%     +45.8%      40251 ± 11%  softirqs.CPU110.NET_RX
     22378 ±  2%     +40.8%      31500        softirqs.CPU110.SCHED
     24876 ±  5%     +54.5%      38426 ± 12%  softirqs.CPU111.NET_RX
     22432           +39.7%      31336        softirqs.CPU111.SCHED
     26614 ±  6%     +40.6%      37431 ± 16%  softirqs.CPU112.NET_RX
     22534           +40.1%      31568        softirqs.CPU112.SCHED
     27691 ±  6%     +43.7%      39803 ± 10%  softirqs.CPU113.NET_RX
     22484           +40.3%      31556 ±  2%  softirqs.CPU113.SCHED
     26598           +41.5%      37630 ± 13%  softirqs.CPU114.NET_RX
     22344           +41.1%      31517        softirqs.CPU114.SCHED
     25162 ±  7%     +51.8%      38197 ± 14%  softirqs.CPU115.NET_RX
     22294           +41.6%      31559        softirqs.CPU115.SCHED
     26398 ±  7%     +43.7%      37944 ±  9%  softirqs.CPU116.NET_RX
     22527 ±  2%     +40.2%      31586        softirqs.CPU116.SCHED
     27764 ±  4%     +35.5%      37620 ± 10%  softirqs.CPU117.NET_RX
     22349           +42.6%      31867        softirqs.CPU117.SCHED
     27287 ±  6%     +39.8%      38148 ±  5%  softirqs.CPU118.NET_RX
     22445           +40.8%      31611        softirqs.CPU118.SCHED
     27154 ±  8%     +39.5%      37891 ± 11%  softirqs.CPU119.NET_RX
     22468 ±  2%     +40.1%      31478        softirqs.CPU119.SCHED
     31749 ± 14%     +32.1%      41950 ± 15%  softirqs.CPU12.NET_RX
     22296 ±  3%     +40.5%      31316 ±  2%  softirqs.CPU12.SCHED
     26899 ±  4%     +53.1%      41186 ±  8%  softirqs.CPU120.NET_RX
     22715           +40.8%      31982        softirqs.CPU120.SCHED
     25383 ±  4%     +56.5%      39715 ±  7%  softirqs.CPU121.NET_RX
     22459 ±  2%     +41.6%      31800        softirqs.CPU121.SCHED
     28623 ±  5%     +38.0%      39506 ±  9%  softirqs.CPU122.NET_RX
     22451           +41.1%      31675        softirqs.CPU122.SCHED
     24635 ±  6%     +64.3%      40471 ± 10%  softirqs.CPU123.NET_RX
     22414           +42.0%      31828 ±  2%  softirqs.CPU123.SCHED
     26964 ±  8%     +43.0%      38567 ±  9%  softirqs.CPU124.NET_RX
     22516           +40.5%      31642 ±  2%  softirqs.CPU124.SCHED
     27580 ±  2%     +43.8%      39650 ±  9%  softirqs.CPU125.NET_RX
     22282           +44.1%      32109        softirqs.CPU125.SCHED
     26557 ±  5%     +45.9%      38759 ±  5%  softirqs.CPU126.NET_RX
     22291 ±  2%     +42.6%      31792        softirqs.CPU126.SCHED
     27059 ±  3%     +45.2%      39285 ±  8%  softirqs.CPU127.NET_RX
     22415           +40.8%      31558 ±  2%  softirqs.CPU127.SCHED
     28229 ±  3%     +45.9%      41198 ± 10%  softirqs.CPU128.NET_RX
     22438           +41.5%      31753        softirqs.CPU128.SCHED
     24687 ±  9%     +57.7%      38943 ±  6%  softirqs.CPU129.NET_RX
     22703           +39.7%      31707 ±  2%  softirqs.CPU129.SCHED
     32353 ± 15%     +29.4%      41853 ± 10%  softirqs.CPU13.NET_RX
     22264 ±  3%     +41.6%      31535 ±  2%  softirqs.CPU13.SCHED
     25564 ±  4%     +58.8%      40584 ± 10%  softirqs.CPU130.NET_RX
     22460 ±  2%     +41.2%      31703 ±  2%  softirqs.CPU130.SCHED
     27820 ±  8%     +40.9%      39185 ± 15%  softirqs.CPU131.NET_RX
     22570           +41.2%      31866        softirqs.CPU131.SCHED
     27825 ±  6%     +40.5%      39085 ±  9%  softirqs.CPU132.NET_RX
     22239 ±  2%     +43.3%      31861        softirqs.CPU132.SCHED
     25933 ±  6%     +49.3%      38714 ±  3%  softirqs.CPU133.NET_RX
     22432           +40.9%      31610        softirqs.CPU133.SCHED
     25380 ±  7%     +60.0%      40606 ±  7%  softirqs.CPU134.NET_RX
     22177           +42.2%      31546        softirqs.CPU134.SCHED
     27097 ± 11%     +47.1%      39859 ± 10%  softirqs.CPU135.NET_RX
     22279 ±  2%     +41.7%      31579 ±  2%  softirqs.CPU135.SCHED
     27294 ± 10%     +43.6%      39207 ±  9%  softirqs.CPU136.NET_RX
     22470 ±  2%     +40.8%      31631        softirqs.CPU136.SCHED
     25541 ±  9%     +58.9%      40597 ±  5%  softirqs.CPU137.NET_RX
     22316           +41.7%      31627        softirqs.CPU137.SCHED
     27329 ±  4%     +40.3%      38333 ±  6%  softirqs.CPU138.NET_RX
     22391           +41.3%      31642        softirqs.CPU138.SCHED
     26386 ±  5%     +54.4%      40739 ±  6%  softirqs.CPU139.NET_RX
     22072           +43.1%      31575        softirqs.CPU139.SCHED
     28536 ±  3%     +38.4%      39490 ±  8%  softirqs.CPU14.NET_RX
     22238           +40.6%      31268        softirqs.CPU14.SCHED
     27532           +44.9%      39895 ±  6%  softirqs.CPU140.NET_RX
     22596           +42.4%      32172        softirqs.CPU140.SCHED
     25335 ±  8%     +58.9%      40246 ±  4%  softirqs.CPU141.NET_RX
     22439           +41.3%      31714        softirqs.CPU141.SCHED
     25343 ±  7%     +56.1%      39566 ±  7%  softirqs.CPU142.NET_RX
     22241           +42.3%      31649        softirqs.CPU142.SCHED
     25900 ±  4%     +46.4%      37910 ±  8%  softirqs.CPU143.NET_RX
     22544           +40.2%      31617        softirqs.CPU143.SCHED
     26686 ±  7%     +55.0%      41356 ±  7%  softirqs.CPU144.NET_RX
     22658 ±  2%     +41.2%      31991        softirqs.CPU144.SCHED
     26346 ±  8%     +56.4%      41214 ±  7%  softirqs.CPU145.NET_RX
     22449 ±  2%     +41.4%      31742        softirqs.CPU145.SCHED
     26767 ±  9%     +45.1%      38844 ±  6%  softirqs.CPU146.NET_RX
     22421           +42.2%      31893        softirqs.CPU146.SCHED
     27549 ±  2%     +49.5%      41189 ±  6%  softirqs.CPU147.NET_RX
     22598           +40.6%      31778        softirqs.CPU147.SCHED
     25304 ±  6%     +62.6%      41139 ±  8%  softirqs.CPU148.NET_RX
     22510           +40.9%      31706 ±  2%  softirqs.CPU148.SCHED
     27511           +50.2%      41311 ±  7%  softirqs.CPU149.NET_RX
     22499 ±  2%     +41.4%      31814 ±  2%  softirqs.CPU149.SCHED
     26432 ±  4%     +50.8%      39867 ±  6%  softirqs.CPU15.NET_RX
     22042 ±  2%     +41.8%      31252 ±  2%  softirqs.CPU15.SCHED
     26753 ±  6%     +49.0%      39857 ±  5%  softirqs.CPU150.NET_RX
     22392           +41.6%      31697 ±  2%  softirqs.CPU150.SCHED
     26392 ±  6%     +55.8%      41110 ±  5%  softirqs.CPU151.NET_RX
     22402           +43.3%      32099 ±  2%  softirqs.CPU151.SCHED
     26476 ±  6%     +60.4%      42455 ±  7%  softirqs.CPU152.NET_RX
     22313           +42.8%      31853        softirqs.CPU152.SCHED
     25694 ±  7%     +66.1%      42673 ±  8%  softirqs.CPU153.NET_RX
     22480           +42.0%      31916        softirqs.CPU153.SCHED
     26041 ±  8%     +60.3%      41736 ±  7%  softirqs.CPU154.NET_RX
     22434           +41.4%      31733        softirqs.CPU154.SCHED
     25808 ±  4%     +65.8%      42801 ±  3%  softirqs.CPU155.NET_RX
     22484           +41.9%      31908        softirqs.CPU155.SCHED
     24954 ±  8%     +67.7%      41840 ±  7%  softirqs.CPU156.NET_RX
     22323           +42.2%      31750 ±  2%  softirqs.CPU156.SCHED
     25395 ±  6%     +57.5%      39989 ±  8%  softirqs.CPU157.NET_RX
     22260           +42.2%      31656        softirqs.CPU157.SCHED
     26898 ±  3%     +60.4%      43140 ±  9%  softirqs.CPU158.NET_RX
     22331           +42.1%      31728        softirqs.CPU158.SCHED
     27799 ±  5%     +53.7%      42719 ±  6%  softirqs.CPU159.NET_RX
     22524 ±  2%     +40.9%      31748 ±  2%  softirqs.CPU159.SCHED
     26491 ±  5%     +47.4%      39050 ±  9%  softirqs.CPU16.NET_RX
     22172           +41.3%      31325        softirqs.CPU16.SCHED
     28233 ±  3%     +47.0%      41500 ±  7%  softirqs.CPU160.NET_RX
     22579           +40.9%      31812        softirqs.CPU160.SCHED
     25846 ±  4%     +54.4%      39912 ±  8%  softirqs.CPU161.NET_RX
     22306           +43.0%      31898 ±  2%  softirqs.CPU161.SCHED
     27171 ±  4%     +50.0%      40750 ± 12%  softirqs.CPU162.NET_RX
     22706           +40.7%      31951 ±  2%  softirqs.CPU162.SCHED
     25996 ±  7%     +54.2%      40095 ±  7%  softirqs.CPU163.NET_RX
     22271           +42.4%      31706 ±  2%  softirqs.CPU163.SCHED
     26583 ±  8%     +52.0%      40411 ±  6%  softirqs.CPU164.NET_RX
     22356           +43.1%      32001        softirqs.CPU164.SCHED
     27354 ±  4%     +49.2%      40815 ±  6%  softirqs.CPU165.NET_RX
     22339           +43.2%      31987 ±  2%  softirqs.CPU165.SCHED
     26997 ±  3%     +50.3%      40567 ± 11%  softirqs.CPU166.NET_RX
     22526           +41.4%      31856 ±  2%  softirqs.CPU166.SCHED
     26697 ± 11%     +53.2%      40913 ±  9%  softirqs.CPU167.NET_RX
     22425 ±  2%     +42.0%      31843        softirqs.CPU167.SCHED
     25201 ±  4%     +50.2%      37865 ±  4%  softirqs.CPU168.NET_RX
     22931 ±  2%     +37.7%      31567        softirqs.CPU168.SCHED
     26601 ±  4%     +38.6%      36860 ±  2%  softirqs.CPU169.NET_RX
     22439           +39.8%      31366        softirqs.CPU169.SCHED
     25967 ±  3%     +46.7%      38093 ± 10%  softirqs.CPU17.NET_RX
     22035           +41.5%      31175        softirqs.CPU17.SCHED
     28588 ±  5%     +36.4%      39006 ±  4%  softirqs.CPU170.NET_RX
     22555           +39.4%      31448        softirqs.CPU170.SCHED
     26721 ±  2%     +35.5%      36211 ±  4%  softirqs.CPU171.NET_RX
     22479           +39.5%      31350        softirqs.CPU171.SCHED
     26696 ±  7%     +45.9%      38959        softirqs.CPU172.NET_RX
     22506           +39.9%      31493        softirqs.CPU172.SCHED
     27865 ±  5%     +38.9%      38711 ±  3%  softirqs.CPU173.NET_RX
     22601           +40.7%      31795        softirqs.CPU173.SCHED
     25253 ±  5%     +45.1%      36634 ±  6%  softirqs.CPU174.NET_RX
     22457           +40.6%      31572        softirqs.CPU174.SCHED
     24986 ±  7%     +54.1%      38513        softirqs.CPU175.NET_RX
     22330           +41.2%      31540        softirqs.CPU175.SCHED
     27374 ±  6%     +40.2%      38385 ±  2%  softirqs.CPU176.NET_RX
     22522           +40.6%      31675        softirqs.CPU176.SCHED
     27835 ±  6%     +35.0%      37583 ±  6%  softirqs.CPU177.NET_RX
     22484           +40.7%      31624        softirqs.CPU177.SCHED
     26755 ±  6%     +41.0%      37715        softirqs.CPU178.NET_RX
     22478           +41.0%      31688        softirqs.CPU178.SCHED
     26621 ±  6%     +47.3%      39201        softirqs.CPU179.NET_RX
     22502           +40.2%      31552        softirqs.CPU179.SCHED
     27512 ±  5%     +42.0%      39060 ±  7%  softirqs.CPU18.NET_RX
     22107           +40.8%      31126 ±  2%  softirqs.CPU18.SCHED
     26885 ±  9%     +45.7%      39180 ±  3%  softirqs.CPU180.NET_RX
     22483           +40.0%      31486        softirqs.CPU180.SCHED
     26627           +42.3%      37883 ±  2%  softirqs.CPU181.NET_RX
     22304           +40.2%      31277        softirqs.CPU181.SCHED
     28450 ±  2%     +38.3%      39348        softirqs.CPU182.NET_RX
     22409           +41.3%      31653        softirqs.CPU182.SCHED
     26902 ±  6%     +38.9%      37359 ±  2%  softirqs.CPU183.NET_RX
     22525           +42.7%      32150 ±  2%  softirqs.CPU183.SCHED
     26896 ±  4%     +45.4%      39094 ±  4%  softirqs.CPU184.NET_RX
     22666           +40.4%      31831        softirqs.CPU184.SCHED
     26284 ±  4%     +43.3%      37656 ±  6%  softirqs.CPU185.NET_RX
     22504           +40.1%      31530        softirqs.CPU185.SCHED
     26808 ±  5%     +43.5%      38481 ±  6%  softirqs.CPU186.NET_RX
     22468           +41.4%      31765        softirqs.CPU186.SCHED
     26862 ±  4%     +41.7%      38056 ±  3%  softirqs.CPU187.NET_RX
     22310           +42.1%      31698        softirqs.CPU187.SCHED
     27240 ±  4%     +38.4%      37694 ±  5%  softirqs.CPU188.NET_RX
     22536 ±  2%     +40.6%      31680        softirqs.CPU188.SCHED
     26770 ±  7%     +42.2%      38071 ±  4%  softirqs.CPU189.NET_RX
     22379           +41.4%      31641        softirqs.CPU189.SCHED
     27602 ±  7%     +44.1%      39788 ± 10%  softirqs.CPU19.NET_RX
     22178 ±  2%     +41.1%      31299        softirqs.CPU19.SCHED
     26975 ±  5%     +34.9%      36380 ±  3%  softirqs.CPU190.NET_RX
     22453 ±  2%     +40.5%      31535        softirqs.CPU190.SCHED
     26619 ±  8%     +38.3%      36822 ±  6%  softirqs.CPU191.NET_RX
     22356 ±  2%     +40.1%      31331        softirqs.CPU191.SCHED
     25962 ±  4%     +44.0%      37375 ±  5%  softirqs.CPU2.NET_RX
     22236           +41.1%      31366 ±  2%  softirqs.CPU2.SCHED
     26429 ±  5%     +41.6%      37428 ± 10%  softirqs.CPU20.NET_RX
     22138           +42.3%      31494 ±  2%  softirqs.CPU20.SCHED
     28435 ±  5%     +32.9%      37799 ± 10%  softirqs.CPU21.NET_RX
     22367           +39.7%      31255        softirqs.CPU21.SCHED
     25716 ± 10%     +52.8%      39285 ±  9%  softirqs.CPU22.NET_RX
     21998           +42.0%      31231 ±  2%  softirqs.CPU22.SCHED
     26412 ±  9%     +41.3%      37309 ±  4%  softirqs.CPU23.NET_RX
     21938 ±  2%     +45.1%      31843 ±  2%  softirqs.CPU23.SCHED
     29157 ±  6%     +36.1%      39691 ±  5%  softirqs.CPU24.NET_RX
     22379           +39.9%      31315 ±  2%  softirqs.CPU24.SCHED
     28014 ±  3%     +37.1%      38395 ±  5%  softirqs.CPU25.NET_RX
     22291 ±  2%     +39.6%      31113 ±  2%  softirqs.CPU25.SCHED
     26789 ±  6%     +57.1%      42086 ±  7%  softirqs.CPU26.NET_RX
     22212 ±  2%     +40.8%      31283        softirqs.CPU26.SCHED
     27376 ±  2%     +49.3%      40873 ±  7%  softirqs.CPU27.NET_RX
     22103 ±  2%     +41.3%      31229 ±  2%  softirqs.CPU27.SCHED
     25038 ±  4%     +57.7%      39478 ±  7%  softirqs.CPU28.NET_RX
     21902 ±  2%     +42.7%      31250 ±  2%  softirqs.CPU28.SCHED
     27968 ±  5%     +41.6%      39608 ± 14%  softirqs.CPU29.NET_RX
     22350 ±  2%     +40.2%      31332        softirqs.CPU29.SCHED
     27744 ±  2%     +39.0%      38561 ± 11%  softirqs.CPU3.NET_RX
     22293           +40.5%      31326 ±  2%  softirqs.CPU3.SCHED
     26966 ±  3%     +49.1%      40212 ±  5%  softirqs.CPU30.NET_RX
     22055 ±  2%     +42.7%      31478 ±  2%  softirqs.CPU30.SCHED
     25831 ±  5%     +51.3%      39073 ±  5%  softirqs.CPU31.NET_RX
     21978           +42.5%      31317 ±  2%  softirqs.CPU31.SCHED
     26142           +53.6%      40151 ±  7%  softirqs.CPU32.NET_RX
     22034           +43.6%      31631 ±  2%  softirqs.CPU32.SCHED
     28208 ±  8%     +36.2%      38410 ±  8%  softirqs.CPU33.NET_RX
     22205           +40.5%      31200 ±  2%  softirqs.CPU33.SCHED
     25515 ±  5%     +52.5%      38916 ±  9%  softirqs.CPU34.NET_RX
     22249           +41.1%      31394 ±  3%  softirqs.CPU34.SCHED
     27450 ±  8%     +43.0%      39255 ±  8%  softirqs.CPU35.NET_RX
     22080 ±  2%     +42.0%      31343 ±  2%  softirqs.CPU35.SCHED
     25585 ±  4%     +54.6%      39542 ±  7%  softirqs.CPU36.NET_RX
     35079 ±  2%      +9.5%      38395 ±  5%  softirqs.CPU36.RCU
     21853           +42.6%      31154        softirqs.CPU36.SCHED
     27579           +38.3%      38153 ±  5%  softirqs.CPU37.NET_RX
     22315 ±  2%     +40.1%      31253 ±  2%  softirqs.CPU37.SCHED
     28374 ±  7%     +37.1%      38892 ±  2%  softirqs.CPU38.NET_RX
     22351           +39.8%      31247        softirqs.CPU38.SCHED
     26346 ±  3%     +56.3%      41171 ±  9%  softirqs.CPU39.NET_RX
     22130 ±  2%     +41.6%      31339        softirqs.CPU39.SCHED
     28596 ±  8%     +37.1%      39214 ± 11%  softirqs.CPU4.NET_RX
     21907           +42.7%      31251        softirqs.CPU4.SCHED
     28161 ±  6%     +37.3%      38660 ±  9%  softirqs.CPU40.NET_RX
     22020           +43.1%      31505 ±  2%  softirqs.CPU40.SCHED
     27064 ±  3%     +43.3%      38790 ±  9%  softirqs.CPU41.NET_RX
     22178 ±  2%     +42.0%      31487 ±  2%  softirqs.CPU41.SCHED
     27221 ±  2%     +44.0%      39204 ±  2%  softirqs.CPU42.NET_RX
     22132           +41.6%      31345        softirqs.CPU42.SCHED
     27656 ±  2%     +46.5%      40511 ± 10%  softirqs.CPU43.NET_RX
     22282           +40.7%      31352 ±  2%  softirqs.CPU43.SCHED
     26576 ±  3%     +57.0%      41716 ± 11%  softirqs.CPU44.NET_RX
     22234           +40.8%      31307 ±  2%  softirqs.CPU44.SCHED
     27340 ±  4%     +42.2%      38881 ±  7%  softirqs.CPU45.NET_RX
     22276           +41.1%      31434 ±  2%  softirqs.CPU45.SCHED
     26078 ±  3%     +53.9%      40136 ±  2%  softirqs.CPU46.NET_RX
     22105           +43.9%      31812 ±  5%  softirqs.CPU46.SCHED
     28370 ±  5%     +39.2%      39480 ±  7%  softirqs.CPU47.NET_RX
     22237           +41.1%      31375 ±  2%  softirqs.CPU47.SCHED
     30519 ±  9%     +39.9%      42693 ±  8%  softirqs.CPU48.NET_RX
     22460           +40.5%      31557 ±  2%  softirqs.CPU48.SCHED
     27723 ±  7%     +53.7%      42597 ±  2%  softirqs.CPU49.NET_RX
     22119           +41.1%      31201        softirqs.CPU49.SCHED
     27299 ±  3%     +44.9%      39568 ± 10%  softirqs.CPU5.NET_RX
     22182           +40.0%      31058 ±  4%  softirqs.CPU5.SCHED
     25894 ±  3%     +62.2%      41987 ±  2%  softirqs.CPU50.NET_RX
     22069           +42.8%      31521 ±  2%  softirqs.CPU50.SCHED
     27435 ±  6%     +51.7%      41621 ±  6%  softirqs.CPU51.NET_RX
     22321 ±  2%     +40.4%      31339 ±  2%  softirqs.CPU51.SCHED
     25296 ±  5%     +58.6%      40130 ±  9%  softirqs.CPU52.NET_RX
     22044           +43.4%      31608 ±  3%  softirqs.CPU52.SCHED
     27130 ±  8%     +46.2%      39670 ±  6%  softirqs.CPU53.NET_RX
     22426           +41.6%      31747 ±  2%  softirqs.CPU53.SCHED
     25846 ±  6%     +63.1%      42168 ±  8%  softirqs.CPU54.NET_RX
     22216 ±  2%     +41.9%      31531 ±  2%  softirqs.CPU54.SCHED
     26294 ±  5%     +55.1%      40790 ±  8%  softirqs.CPU55.NET_RX
     22292           +41.3%      31489 ±  3%  softirqs.CPU55.SCHED
     26056 ±  7%     +54.6%      40276 ±  8%  softirqs.CPU56.NET_RX
     22278           +40.8%      31364 ±  2%  softirqs.CPU56.SCHED
     26868 ±  8%     +53.3%      41178 ±  7%  softirqs.CPU57.NET_RX
     22296           +40.9%      31424 ±  2%  softirqs.CPU57.SCHED
     26149 ±  2%     +62.1%      42382 ±  8%  softirqs.CPU58.NET_RX
     22191           +41.6%      31414 ±  2%  softirqs.CPU58.SCHED
     27700 ±  5%     +52.2%      42173 ±  7%  softirqs.CPU59.NET_RX
     22321           +40.4%      31338 ±  3%  softirqs.CPU59.SCHED
     25799 ±  6%     +44.6%      37297 ± 11%  softirqs.CPU6.NET_RX
     22410 ±  2%     +40.0%      31368        softirqs.CPU6.SCHED
     26012 ±  5%     +57.8%      41044 ± 11%  softirqs.CPU60.NET_RX
     35693 ±  2%      +6.5%      38001 ±  5%  softirqs.CPU60.RCU
     22143 ±  2%     +42.5%      31547        softirqs.CPU60.SCHED
     27423 ±  2%     +48.3%      40682 ±  8%  softirqs.CPU61.NET_RX
     22364           +40.4%      31395 ±  2%  softirqs.CPU61.SCHED
     27030 ±  6%     +51.3%      40894 ±  6%  softirqs.CPU62.NET_RX
     22223           +41.7%      31492 ±  2%  softirqs.CPU62.SCHED
     26677 ±  9%     +54.8%      41308 ±  8%  softirqs.CPU63.NET_RX
     22212           +41.7%      31474 ±  2%  softirqs.CPU63.SCHED
     28191           +44.6%      40757 ±  9%  softirqs.CPU64.NET_RX
     22366 ±  2%     +40.8%      31482 ±  2%  softirqs.CPU64.SCHED
     28005 ±  2%     +45.4%      40723 ± 10%  softirqs.CPU65.NET_RX
     22184           +42.2%      31556 ±  2%  softirqs.CPU65.SCHED
     26767 ± 11%     +53.7%      41148 ±  7%  softirqs.CPU66.NET_RX
     22531 ±  3%     +40.4%      31624 ±  3%  softirqs.CPU66.SCHED
     26652 ±  5%     +51.8%      40455 ±  8%  softirqs.CPU67.NET_RX
     22134           +42.4%      31519 ±  2%  softirqs.CPU67.SCHED
     27784 ±  7%     +42.3%      39543 ±  7%  softirqs.CPU68.NET_RX
     22450           +40.5%      31534 ±  2%  softirqs.CPU68.SCHED
     25237 ±  3%     +65.8%      41845 ±  8%  softirqs.CPU69.NET_RX
     21994           +43.4%      31542 ±  2%  softirqs.CPU69.SCHED
     27432 ±  3%     +43.3%      39308 ± 12%  softirqs.CPU7.NET_RX
     22104 ±  3%     +40.2%      30984 ±  2%  softirqs.CPU7.SCHED
     27431 ±  3%     +48.6%      40754 ±  6%  softirqs.CPU70.NET_RX
     22246 ±  2%     +41.3%      31429 ±  2%  softirqs.CPU70.SCHED
     27452 ±  5%     +51.9%      41696 ±  8%  softirqs.CPU71.NET_RX
     22364 ±  2%     +39.4%      31182 ±  3%  softirqs.CPU71.SCHED
     29077 ±  7%     +29.0%      37507 ±  2%  softirqs.CPU72.NET_RX
     22733           +37.3%      31203        softirqs.CPU72.SCHED
     27047           +42.8%      38630 ±  8%  softirqs.CPU73.NET_RX
     22103           +41.5%      31277        softirqs.CPU73.SCHED
     28335 ±  4%     +37.4%      38923 ±  3%  softirqs.CPU74.NET_RX
     22261           +40.6%      31292 ±  2%  softirqs.CPU74.SCHED
     28201 ±  5%     +41.0%      39752 ±  3%  softirqs.CPU75.NET_RX
     22163           +41.2%      31294 ±  2%  softirqs.CPU75.SCHED
     27304 ±  4%     +43.6%      39207 ±  7%  softirqs.CPU76.NET_RX
     22255           +40.7%      31305        softirqs.CPU76.SCHED
     28029 ±  6%     +39.4%      39086 ±  5%  softirqs.CPU77.NET_RX
     22384 ±  2%     +38.8%      31060        softirqs.CPU77.SCHED
     26934 ±  5%     +45.3%      39127 ±  4%  softirqs.CPU78.NET_RX
     22494 ±  2%     +42.1%      31967 ±  4%  softirqs.CPU78.SCHED
     26590 ±  4%     +40.6%      37378 ±  4%  softirqs.CPU79.NET_RX
     22142           +41.8%      31390        softirqs.CPU79.SCHED
     25523 ±  8%     +41.7%      36154 ± 13%  softirqs.CPU8.NET_RX
     21717 ±  3%     +43.3%      31127        softirqs.CPU8.SCHED
     26737 ±  5%     +49.0%      39849 ±  6%  softirqs.CPU80.NET_RX
     22228 ±  2%     +40.3%      31183        softirqs.CPU80.SCHED
     29702 ±  3%     +28.6%      38207 ±  6%  softirqs.CPU81.NET_RX
     22323           +39.4%      31109        softirqs.CPU81.SCHED
     26289 ±  2%     +48.4%      39019 ±  4%  softirqs.CPU82.NET_RX
     22248           +40.3%      31212        softirqs.CPU82.SCHED
     28201 ±  8%     +35.7%      38260 ±  3%  softirqs.CPU83.NET_RX
     22316           +40.0%      31237        softirqs.CPU83.SCHED
     29055 ±  6%     +32.7%      38569 ±  6%  softirqs.CPU84.NET_RX
     22403           +38.6%      31058        softirqs.CPU84.SCHED
     26739 ±  8%     +35.5%      36236        softirqs.CPU85.NET_RX
     22210           +40.3%      31164        softirqs.CPU85.SCHED
     27585 ±  7%     +36.6%      37680 ±  5%  softirqs.CPU86.NET_RX
     22221           +40.7%      31275        softirqs.CPU86.SCHED
     27438 ±  6%     +39.7%      38320 ±  4%  softirqs.CPU87.NET_RX
     22554 ±  4%     +38.9%      31322        softirqs.CPU87.SCHED
     26193 ±  6%     +42.3%      37270 ±  4%  softirqs.CPU88.NET_RX
     22105           +41.1%      31189        softirqs.CPU88.SCHED
     25604 ±  4%     +54.0%      39431 ±  4%  softirqs.CPU89.NET_RX
     22116           +39.6%      30883        softirqs.CPU89.SCHED
     25920 ±  5%     +52.3%      39467 ± 11%  softirqs.CPU9.NET_RX
     21962           +42.1%      31210 ±  2%  softirqs.CPU9.SCHED
     27673 ±  7%     +32.1%      36545 ±  5%  softirqs.CPU90.NET_RX
     22333 ±  2%     +39.3%      31103        softirqs.CPU90.SCHED
     27624 ±  4%     +37.8%      38069 ±  4%  softirqs.CPU91.NET_RX
     22151           +40.2%      31057 ±  2%  softirqs.CPU91.SCHED
     29128 ±  3%     +36.8%      39848 ±  4%  softirqs.CPU92.NET_RX
     22392           +39.8%      31306        softirqs.CPU92.SCHED
     27277 ±  4%     +47.3%      40167 ±  2%  softirqs.CPU93.NET_RX
     22366           +39.5%      31207 ±  2%  softirqs.CPU93.SCHED
     25672 ±  3%     +44.0%      36962 ±  4%  softirqs.CPU94.NET_RX
     22244           +41.2%      31402        softirqs.CPU94.SCHED
     25908 ±  6%     +45.8%      37767 ±  5%  softirqs.CPU95.NET_RX
     33900 ±  3%     +11.0%      37644 ±  7%  softirqs.CPU95.RCU
     21796 ±  4%     +41.1%      30757        softirqs.CPU95.SCHED
     26779 ±  2%     +43.8%      38498 ± 12%  softirqs.CPU96.NET_RX
     22350           +41.0%      31510        softirqs.CPU96.SCHED
     27258 ±  5%     +37.6%      37503 ± 10%  softirqs.CPU97.NET_RX
     22365           +41.7%      31682        softirqs.CPU97.SCHED
     27494 ±  4%     +43.8%      39550 ±  5%  softirqs.CPU98.NET_RX
     22595           +39.6%      31540        softirqs.CPU98.SCHED
     25726 ±  6%     +47.0%      37813 ±  8%  softirqs.CPU99.NET_RX
     22402           +41.1%      31600 ±  2%  softirqs.CPU99.SCHED
   5184556           +46.1%    7573104        softirqs.NET_RX
   4288753           +41.1%    6052766        softirqs.SCHED
     76.91 ±  2%     -76.9        0.00        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.scan_positives.dcache_readdir.iterate_dir
     78.73 ±  2%     -67.2       11.55 ±  8%  perf-profile.calltrace.cycles-pp.dcache_readdir.iterate_dir.__x64_sys_getdents64.do_syscall_64.entry_SYSCALL_64_after_hwframe
     78.74 ±  2%     -67.2       11.56 ±  8%  perf-profile.calltrace.cycles-pp.__x64_sys_getdents64.do_syscall_64.entry_SYSCALL_64_after_hwframe
     78.73 ±  2%     -67.2       11.56 ±  8%  perf-profile.calltrace.cycles-pp.iterate_dir.__x64_sys_getdents64.do_syscall_64.entry_SYSCALL_64_after_hwframe
     77.48 ±  2%     -66.9       10.56 ±  8%  perf-profile.calltrace.cycles-pp.scan_positives.dcache_readdir.iterate_dir.__x64_sys_getdents64.do_syscall_64
     77.19 ±  2%     -66.8       10.41 ±  8%  perf-profile.calltrace.cycles-pp._raw_spin_lock.scan_positives.dcache_readdir.iterate_dir.__x64_sys_getdents64
     85.21 ±  2%     -57.5       27.70 ± 23%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe
     85.28 ±  2%     -57.4       27.84 ± 23%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe
      1.21            -0.3        0.90 ± 11%  perf-profile.calltrace.cycles-pp._raw_spin_lock.dcache_readdir.iterate_dir.__x64_sys_getdents64.do_syscall_64
      0.00            +0.6        0.55 ±  8%  perf-profile.calltrace.cycles-pp.page_counter_uncharge.__memcg_kmem_uncharge.drain_obj_stock.refill_obj_stock.kmem_cache_free
      0.00            +0.6        0.57 ±  8%  perf-profile.calltrace.cycles-pp.__memcg_kmem_uncharge.drain_obj_stock.refill_obj_stock.kmem_cache_free.rcu_do_batch
      0.75 ±  7%      +0.7        1.43 ± 24%  perf-profile.calltrace.cycles-pp.kernel_clone.__do_sys_clone.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_fork
      0.75 ±  7%      +0.7        1.43 ± 23%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__libc_fork
      0.75 ±  7%      +0.7        1.43 ± 23%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_fork
      0.75 ±  7%      +0.7        1.43 ± 23%  perf-profile.calltrace.cycles-pp.__do_sys_clone.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_fork
      0.00            +0.7        0.69 ±  8%  perf-profile.calltrace.cycles-pp.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      0.78 ±  7%      +0.7        1.49 ± 23%  perf-profile.calltrace.cycles-pp.__libc_fork
      0.00            +0.7        0.72 ± 12%  perf-profile.calltrace.cycles-pp.__strcat_chk
      0.00            +0.7        0.73 ±  7%  perf-profile.calltrace.cycles-pp.walk_component.link_path_walk.path_openat.do_filp_open.do_sys_openat2
      0.00            +0.7        0.74 ±  8%  perf-profile.calltrace.cycles-pp.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      0.00            +0.7        0.74 ± 22%  perf-profile.calltrace.cycles-pp.__softirqentry_text_start.asm_call_sysvec_on_stack.do_softirq_own_stack.irq_exit_rcu.sysvec_apic_timer_interrupt
      0.00            +0.7        0.74 ± 22%  perf-profile.calltrace.cycles-pp.asm_call_sysvec_on_stack.do_softirq_own_stack.irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      0.00            +0.7        0.74 ± 22%  perf-profile.calltrace.cycles-pp.do_softirq_own_stack.irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state
      0.00            +0.8        0.76 ±  7%  perf-profile.calltrace.cycles-pp.link_path_walk.path_openat.do_filp_open.do_sys_openat2.do_sys_open
      0.00            +0.8        0.76 ± 21%  perf-profile.calltrace.cycles-pp.irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter
      0.78 ± 10%      +0.8        1.54 ± 23%  perf-profile.calltrace.cycles-pp.free_pgtables.exit_mmap.mmput.begin_new_exec.load_elf_binary
      0.84 ±  6%      +0.8        1.63 ± 21%  perf-profile.calltrace.cycles-pp.__do_sys_clone.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.84 ±  6%      +0.8        1.63 ± 21%  perf-profile.calltrace.cycles-pp.kernel_clone.__do_sys_clone.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +0.8        0.81 ±  8%  perf-profile.calltrace.cycles-pp.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      0.00            +0.8        0.81 ±  8%  perf-profile.calltrace.cycles-pp.exc_page_fault.asm_exc_page_fault
      0.00            +0.8        0.84 ±  8%  perf-profile.calltrace.cycles-pp.asm_exc_page_fault
      0.00            +0.9        0.89 ± 11%  perf-profile.calltrace.cycles-pp.__cna_queued_spin_lock_slowpath._raw_spin_lock.dcache_readdir.iterate_dir.__x64_sys_getdents64
      0.27 ±100%      +0.9        1.20 ± 12%  perf-profile.calltrace.cycles-pp.add_int.add_int
      0.14 ±173%      +1.0        1.09 ± 14%  perf-profile.calltrace.cycles-pp.div_long
      0.92 ±  8%      +1.0        1.90 ± 19%  perf-profile.calltrace.cycles-pp.exit_mmap.mmput.begin_new_exec.load_elf_binary.exec_binprm
      0.92 ±  8%      +1.0        1.90 ± 19%  perf-profile.calltrace.cycles-pp.mmput.begin_new_exec.load_elf_binary.exec_binprm.bprm_execve
      0.94 ±  8%      +1.0        1.95 ± 19%  perf-profile.calltrace.cycles-pp.begin_new_exec.load_elf_binary.exec_binprm.bprm_execve.do_execveat_common
      0.27 ±100%      +1.0        1.28 ± 10%  perf-profile.calltrace.cycles-pp.__strncat_chk
      1.20 ±  8%      +1.0        2.24 ± 23%  perf-profile.calltrace.cycles-pp.exit_mmap.mmput.do_exit.do_group_exit.__x64_sys_exit_group
      1.20 ±  8%      +1.0        2.24 ± 23%  perf-profile.calltrace.cycles-pp.mmput.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      0.14 ±173%      +1.0        1.19 ± 13%  perf-profile.calltrace.cycles-pp.add_long.add_long
      0.27 ±100%      +1.1        1.34 ± 15%  perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry
      1.29 ±  8%      +1.2        2.45 ± 21%  perf-profile.calltrace.cycles-pp.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.29 ±  8%      +1.2        2.45 ± 21%  perf-profile.calltrace.cycles-pp.__x64_sys_exit_group.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.29 ±  8%      +1.2        2.45 ± 21%  perf-profile.calltrace.cycles-pp.do_group_exit.__x64_sys_exit_group.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +1.2        1.21 ± 16%  perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter.do_idle
      0.17 ±173%      +1.2        1.40 ± 10%  perf-profile.calltrace.cycles-pp.do_sys_openat2.do_sys_open.do_syscall_64.entry_SYSCALL_64_after_hwframe.creat64
      0.17 ±173%      +1.2        1.41 ± 10%  perf-profile.calltrace.cycles-pp.do_sys_open.do_syscall_64.entry_SYSCALL_64_after_hwframe.creat64
      0.17 ±173%      +1.2        1.41 ± 10%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.creat64
      1.41 ±  8%      +1.2        2.65 ± 25%  perf-profile.calltrace.cycles-pp.dup_mmap.dup_mm.copy_process.kernel_clone.__do_sys_clone
      0.17 ±173%      +1.2        1.41 ±  9%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.creat64
      0.00            +1.3        1.25 ±  5%  perf-profile.calltrace.cycles-pp.drain_obj_stock.refill_obj_stock.kmem_cache_free.rcu_do_batch.rcu_core
      0.17 ±173%      +1.3        1.42 ± 10%  perf-profile.calltrace.cycles-pp.creat64
      1.42 ±  8%      +1.3        2.68 ± 25%  perf-profile.calltrace.cycles-pp.dup_mm.copy_process.kernel_clone.__do_sys_clone.do_syscall_64
      0.00            +1.3        1.30 ± 28%  perf-profile.calltrace.cycles-pp._raw_spin_lock.lockref_get.d_alloc_cursor.dcache_dir_open.do_dentry_open
      0.00            +1.3        1.30 ± 28%  perf-profile.calltrace.cycles-pp.__cna_queued_spin_lock_slowpath._raw_spin_lock.lockref_get.d_alloc_cursor.dcache_dir_open
      0.00            +1.3        1.30 ± 28%  perf-profile.calltrace.cycles-pp.lockref_get.d_alloc_cursor.dcache_dir_open.do_dentry_open.path_openat
      0.00            +1.3        1.30 ± 28%  perf-profile.calltrace.cycles-pp.dcache_dir_open.do_dentry_open.path_openat.do_filp_open.do_sys_openat2
      0.00            +1.3        1.30 ± 28%  perf-profile.calltrace.cycles-pp.d_alloc_cursor.dcache_dir_open.do_dentry_open.path_openat.do_filp_open
      1.52 ±  7%      +1.4        2.92 ± 23%  perf-profile.calltrace.cycles-pp.copy_process.kernel_clone.__do_sys_clone.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +1.6        1.56 ±  4%  perf-profile.calltrace.cycles-pp.refill_obj_stock.kmem_cache_free.rcu_do_batch.rcu_core.__softirqentry_text_start
      1.17 ±  7%      +1.6        2.73 ± 17%  perf-profile.calltrace.cycles-pp.load_elf_binary.exec_binprm.bprm_execve.do_execveat_common.__x64_sys_execve
      1.17 ±  7%      +1.6        2.75 ± 17%  perf-profile.calltrace.cycles-pp.exec_binprm.bprm_execve.do_execveat_common.__x64_sys_execve.do_syscall_64
      0.61 ±  8%      +1.7        2.28 ± 62%  perf-profile.calltrace.cycles-pp.do_sys_open.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.61 ±  8%      +1.7        2.28 ± 62%  perf-profile.calltrace.cycles-pp.do_sys_openat2.do_sys_open.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +2.0        1.95 ± 23%  perf-profile.calltrace.cycles-pp._raw_spin_lock.lockref_get.do_dentry_open.path_openat.do_filp_open
      0.00            +2.0        1.95 ± 23%  perf-profile.calltrace.cycles-pp.__cna_queued_spin_lock_slowpath._raw_spin_lock.lockref_get.do_dentry_open.path_openat
      0.00            +2.0        1.95 ± 23%  perf-profile.calltrace.cycles-pp.lockref_get.do_dentry_open.path_openat.do_filp_open.do_sys_openat2
      1.51 ± 15%      +2.7        4.24 ± 11%  perf-profile.calltrace.cycles-pp.string_rtns_1
      0.00            +3.4        3.42 ± 16%  perf-profile.calltrace.cycles-pp.do_dentry_open.path_openat.do_filp_open.do_sys_openat2.do_sys_open
      0.00            +3.7        3.74 ±119%  perf-profile.calltrace.cycles-pp.__x64_sys_execve.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +3.7        3.74 ±119%  perf-profile.calltrace.cycles-pp.do_execveat_common.__x64_sys_execve.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.51 ± 59%      +3.8        4.27 ±  2%  perf-profile.calltrace.cycles-pp.kmem_cache_free.rcu_do_batch.rcu_core.__softirqentry_text_start.run_ksoftirqd
      0.68 ± 18%      +3.9        4.55 ±  2%  perf-profile.calltrace.cycles-pp.rcu_do_batch.rcu_core.__softirqentry_text_start.run_ksoftirqd.smpboot_thread_fn
      0.68 ± 17%      +3.9        4.55 ±  2%  perf-profile.calltrace.cycles-pp.run_ksoftirqd.smpboot_thread_fn.kthread.ret_from_fork
      0.68 ± 18%      +3.9        4.55 ±  2%  perf-profile.calltrace.cycles-pp.rcu_core.__softirqentry_text_start.run_ksoftirqd.smpboot_thread_fn.kthread
      0.68 ± 18%      +3.9        4.55 ±  2%  perf-profile.calltrace.cycles-pp.__softirqentry_text_start.run_ksoftirqd.smpboot_thread_fn.kthread.ret_from_fork
      0.69 ± 17%      +3.9        4.58 ±  2%  perf-profile.calltrace.cycles-pp.smpboot_thread_fn.kthread.ret_from_fork
      0.72 ± 17%      +3.9        4.64 ±  2%  perf-profile.calltrace.cycles-pp.kthread.ret_from_fork
      0.72 ± 17%      +3.9        4.66 ±  2%  perf-profile.calltrace.cycles-pp.ret_from_fork
      4.04 ± 12%      +4.0        8.02 ±  9%  perf-profile.calltrace.cycles-pp.intel_idle.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry
      4.60 ± 10%      +4.8        9.44 ±  8%  perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry.start_secondary
      4.66 ± 10%      +4.9        9.56 ±  7%  perf-profile.calltrace.cycles-pp.cpuidle_enter.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      4.87 ±  9%      +5.1       10.01 ±  7%  perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      4.87 ±  9%      +5.1       10.01 ±  7%  perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      4.87 ±  9%      +5.1       10.01 ±  7%  perf-profile.calltrace.cycles-pp.start_secondary.secondary_startup_64_no_verify
      4.90 ±  9%      +5.2       10.07 ±  7%  perf-profile.calltrace.cycles-pp.secondary_startup_64_no_verify
      0.00            +6.5        6.46 ±  9%  perf-profile.calltrace.cycles-pp._raw_spin_lock.lockref_put_or_lock.dput.step_into.path_openat
      0.00            +6.5        6.46 ±  9%  perf-profile.calltrace.cycles-pp.__cna_queued_spin_lock_slowpath._raw_spin_lock.lockref_put_or_lock.dput.step_into
      0.00            +6.5        6.46 ±  9%  perf-profile.calltrace.cycles-pp.dput.step_into.path_openat.do_filp_open.do_open_execat
      0.00            +6.5        6.46 ±  9%  perf-profile.calltrace.cycles-pp.lockref_put_or_lock.dput.step_into.path_openat.do_filp_open
      0.00            +8.2        8.20 ±  9%  perf-profile.calltrace.cycles-pp._raw_spin_lock.lockref_get_not_dead.__legitimize_path.unlazy_walk.complete_walk
      0.00            +8.2        8.20 ±  9%  perf-profile.calltrace.cycles-pp.__legitimize_path.unlazy_walk.complete_walk.path_openat.do_filp_open
      0.00            +8.2        8.20 ±  9%  perf-profile.calltrace.cycles-pp.lockref_get_not_dead.__legitimize_path.unlazy_walk.complete_walk.path_openat
      0.00            +8.2        8.21 ±  8%  perf-profile.calltrace.cycles-pp.unlazy_walk.complete_walk.path_openat.do_filp_open.do_sys_openat2
      0.00            +8.2        8.21 ±  8%  perf-profile.calltrace.cycles-pp.complete_walk.path_openat.do_filp_open.do_sys_openat2.do_sys_open
      0.00           +10.0       10.04 ±  8%  perf-profile.calltrace.cycles-pp.__cna_queued_spin_lock_slowpath._raw_spin_lock.scan_positives.dcache_readdir.iterate_dir
      0.00           +11.5       11.50 ± 22%  perf-profile.calltrace.cycles-pp.do_sys_open.do_syscall_64.entry_SYSCALL_64_after_hwframe.__open64_nocancel
      0.00           +11.5       11.50 ± 22%  perf-profile.calltrace.cycles-pp.do_sys_openat2.do_sys_open.do_syscall_64.entry_SYSCALL_64_after_hwframe.__open64_nocancel
      0.00           +11.5       11.51 ± 22%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__open64_nocancel
      0.00           +11.5       11.51 ± 22%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__open64_nocancel
      0.00           +11.5       11.51 ± 22%  perf-profile.calltrace.cycles-pp.__open64_nocancel
      0.74 ± 39%     +14.3       15.07 ± 10%  perf-profile.calltrace.cycles-pp.path_openat.do_filp_open.do_sys_openat2.do_sys_open.do_syscall_64
      0.74 ± 39%     +14.3       15.07 ± 10%  perf-profile.calltrace.cycles-pp.do_filp_open.do_sys_openat2.do_sys_open.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00           +20.6       20.61 ± 11%  perf-profile.calltrace.cycles-pp._raw_spin_lock.lockref_get_not_dead.__legitimize_path.unlazy_walk.pick_link
      0.00           +20.6       20.61 ± 11%  perf-profile.calltrace.cycles-pp.unlazy_walk.pick_link.step_into.path_openat.do_filp_open
      0.00           +20.6       20.61 ± 11%  perf-profile.calltrace.cycles-pp.__legitimize_path.unlazy_walk.pick_link.step_into.path_openat
      0.00           +20.6       20.61 ± 11%  perf-profile.calltrace.cycles-pp.lockref_get_not_dead.__legitimize_path.unlazy_walk.pick_link.step_into
      0.00           +20.6       20.62 ± 11%  perf-profile.calltrace.cycles-pp.pick_link.step_into.path_openat.do_filp_open.do_open_execat
      1.34 ±  8%     +25.5       26.88 ±  9%  perf-profile.calltrace.cycles-pp.do_execveat_common.__x64_sys_execve.do_syscall_64.entry_SYSCALL_64_after_hwframe.execve
      1.35 ±  8%     +25.5       26.89 ±  9%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.execve
      1.35 ±  8%     +25.5       26.89 ±  9%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.execve
      1.35 ±  8%     +25.5       26.89 ±  9%  perf-profile.calltrace.cycles-pp.__x64_sys_execve.do_syscall_64.entry_SYSCALL_64_after_hwframe.execve
      1.35 ±  8%     +25.5       26.90 ±  9%  perf-profile.calltrace.cycles-pp.execve
      0.00           +27.3       27.33 ± 10%  perf-profile.calltrace.cycles-pp.step_into.path_openat.do_filp_open.do_open_execat.bprm_execve
      0.00           +27.4       27.35 ± 10%  perf-profile.calltrace.cycles-pp.do_filp_open.do_open_execat.bprm_execve.do_execveat_common.__x64_sys_execve
      0.00           +27.4       27.35 ± 10%  perf-profile.calltrace.cycles-pp.path_openat.do_filp_open.do_open_execat.bprm_execve.do_execveat_common
      0.00           +27.4       27.35 ± 10%  perf-profile.calltrace.cycles-pp.do_open_execat.bprm_execve.do_execveat_common.__x64_sys_execve.do_syscall_64
      0.00           +28.8       28.81 ±  8%  perf-profile.calltrace.cycles-pp.__cna_queued_spin_lock_slowpath._raw_spin_lock.lockref_get_not_dead.__legitimize_path.unlazy_walk
      1.27 ±  7%     +29.1       30.41 ±  9%  perf-profile.calltrace.cycles-pp.bprm_execve.do_execveat_common.__x64_sys_execve.do_syscall_64.entry_SYSCALL_64_after_hwframe
     79.09 ±  2%     -79.1        0.00        perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
     78.73 ±  2%     -67.2       11.55 ±  8%  perf-profile.children.cycles-pp.dcache_readdir
     78.74 ±  2%     -67.2       11.56 ±  8%  perf-profile.children.cycles-pp.__x64_sys_getdents64
     78.73 ±  2%     -67.2       11.56 ±  8%  perf-profile.children.cycles-pp.iterate_dir
     77.48 ±  2%     -66.9       10.56 ±  8%  perf-profile.children.cycles-pp.scan_positives
     79.48 ±  2%     -26.5       52.95 ±  6%  perf-profile.children.cycles-pp._raw_spin_lock
     88.80           -18.0       70.85 ±  2%  perf-profile.children.cycles-pp.do_syscall_64
     88.97           -17.8       71.21 ±  2%  perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.60 ±  2%      -0.1        0.46 ± 12%  perf-profile.children.cycles-pp.ksys_lseek
      0.60 ±  2%      -0.1        0.46 ± 12%  perf-profile.children.cycles-pp.dcache_dir_lseek
      0.17            -0.0        0.15 ±  4%  perf-profile.children.cycles-pp.clockevents_program_event
      0.04 ± 58%      +0.0        0.09 ± 13%  perf-profile.children.cycles-pp.update_load_avg
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.new_sync_read
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.__check_object_size
      0.00            +0.1        0.05        perf-profile.children.cycles-pp._cond_resched
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.syscall_return_via_sysret
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.sync_regs
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.__pud_alloc
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.setup_arg_pages
      0.00            +0.1        0.05 ±  8%  perf-profile.children.cycles-pp.d_add
      0.00            +0.1        0.05 ±  8%  perf-profile.children.cycles-pp.process_one_work
      0.00            +0.1        0.05 ±  8%  perf-profile.children.cycles-pp.pagevec_lru_move_fn
      0.03 ±100%      +0.1        0.08 ± 17%  perf-profile.children.cycles-pp.tick_nohz_get_sleep_length
      0.00            +0.1        0.05 ±  9%  perf-profile.children.cycles-pp.__waitpid
      0.00            +0.1        0.06 ±  9%  perf-profile.children.cycles-pp.simple_lookup
      0.00            +0.1        0.06 ±  9%  perf-profile.children.cycles-pp.ip_finish_output2
      0.05            +0.1        0.11 ±  4%  perf-profile.children.cycles-pp.___might_sleep
      0.01 ±173%      +0.1        0.07 ± 21%  perf-profile.children.cycles-pp.tick_nohz_next_event
      0.03 ±100%      +0.1        0.08 ± 10%  perf-profile.children.cycles-pp.aa_get_task_label
      0.00            +0.1        0.06 ±  7%  perf-profile.children.cycles-pp.ip_output
      0.00            +0.1        0.06 ±  7%  perf-profile.children.cycles-pp.try_charge
      0.00            +0.1        0.06 ±  7%  perf-profile.children.cycles-pp.create_elf_tables
      0.00            +0.1        0.06 ±  7%  perf-profile.children.cycles-pp.uncharge_batch
      0.00            +0.1        0.06 ±  7%  perf-profile.children.cycles-pp.filename_create
      0.00            +0.1        0.06 ±  7%  perf-profile.children.cycles-pp.__rb_insert_augmented
      0.06 ±  9%      +0.1        0.11 ±  7%  perf-profile.children.cycles-pp.__mmap
      0.00            +0.1        0.06 ± 14%  perf-profile.children.cycles-pp.read
      0.06 ±  6%      +0.1        0.12 ±  6%  perf-profile.children.cycles-pp.__d_lookup_rcu
      0.07 ±  7%      +0.1        0.12 ±  8%  perf-profile.children.cycles-pp.wake_up_new_task
      0.04 ± 57%      +0.1        0.10 ± 13%  perf-profile.children.cycles-pp.up_write
      0.00            +0.1        0.06        perf-profile.children.cycles-pp.do_truncate
      0.00            +0.1        0.06        perf-profile.children.cycles-pp.__might_sleep
      0.00            +0.1        0.06        perf-profile.children.cycles-pp.lock_page_memcg
      0.00            +0.1        0.06        perf-profile.children.cycles-pp.anon_vma_interval_tree_insert
      0.00            +0.1        0.06        perf-profile.children.cycles-pp.get_arg_page
      0.00            +0.1        0.06        perf-profile.children.cycles-pp.__get_user_pages_remote
      0.00            +0.1        0.06        perf-profile.children.cycles-pp.__get_user_pages
      0.00            +0.1        0.06        perf-profile.children.cycles-pp.alloc_pages_vma
      0.00            +0.1        0.06 ± 11%  perf-profile.children.cycles-pp.inode_permission
      0.00            +0.1        0.06 ± 20%  perf-profile.children.cycles-pp.start_kernel
      0.00            +0.1        0.06 ± 11%  perf-profile.children.cycles-pp.put_task_stack
      0.01 ±173%      +0.1        0.07 ± 11%  perf-profile.children.cycles-pp.link
      0.03 ±100%      +0.1        0.09 ± 12%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      0.00            +0.1        0.06 ± 13%  perf-profile.children.cycles-pp.compar1
      0.00            +0.1        0.06 ±  6%  perf-profile.children.cycles-pp.__pmd_alloc
      0.00            +0.1        0.06 ±  6%  perf-profile.children.cycles-pp.__anon_vma_prepare
      0.00            +0.1        0.06 ±  6%  perf-profile.children.cycles-pp.worker_thread
      0.00            +0.1        0.06 ± 13%  perf-profile.children.cycles-pp.rebalance_domains
      0.06 ±  7%      +0.1        0.12 ±  3%  perf-profile.children.cycles-pp.getname_flags
      0.06 ±  9%      +0.1        0.12        perf-profile.children.cycles-pp.copy_strings
      0.06 ±  9%      +0.1        0.12 ±  5%  perf-profile.children.cycles-pp.pte_alloc_one
      0.00            +0.1        0.07 ±  7%  perf-profile.children.cycles-pp.file_free_rcu
      0.00            +0.1        0.07 ±  7%  perf-profile.children.cycles-pp.mem_cgroup_uncharge_list
      0.00            +0.1        0.07 ±  7%  perf-profile.children.cycles-pp.update_rq_clock
      0.00            +0.1        0.07 ±  7%  perf-profile.children.cycles-pp.do_faccessat
      0.00            +0.1        0.07 ± 13%  perf-profile.children.cycles-pp.udp_sendmsg
      0.01 ±173%      +0.1        0.08 ± 46%  perf-profile.children.cycles-pp.irq_enter_rcu
      0.00            +0.1        0.07 ± 13%  perf-profile.children.cycles-pp.free_pages_and_swap_cache
      0.08            +0.1        0.15 ±  3%  perf-profile.children.cycles-pp.native_irq_return_iret
      0.06 ±  9%      +0.1        0.12 ±  3%  perf-profile.children.cycles-pp.alloc_set_pte
      0.05 ± 60%      +0.1        0.12 ±  7%  perf-profile.children.cycles-pp.security_file_free
      0.05 ± 60%      +0.1        0.12 ±  7%  perf-profile.children.cycles-pp.apparmor_file_free_security
      0.01 ±173%      +0.1        0.08 ±  8%  perf-profile.children.cycles-pp.do_linkat
      0.01 ±173%      +0.1        0.08 ±  8%  perf-profile.children.cycles-pp.__x64_sys_link
      0.00            +0.1        0.07 ±  6%  perf-profile.children.cycles-pp.security_task_kill
      0.00            +0.1        0.07 ±  6%  perf-profile.children.cycles-pp.apparmor_task_kill
      0.00            +0.1        0.07 ±  6%  perf-profile.children.cycles-pp.cfree
      0.00            +0.1        0.07 ±  6%  perf-profile.children.cycles-pp.strnlen_user
      0.00            +0.1        0.07 ±  6%  perf-profile.children.cycles-pp.find_vma
      0.03 ±100%      +0.1        0.10 ±  7%  perf-profile.children.cycles-pp.kill_something_info
      0.03 ±100%      +0.1        0.10 ±  4%  perf-profile.children.cycles-pp.kill_pid_info
      0.00            +0.1        0.07 ± 10%  perf-profile.children.cycles-pp.group_send_sig_info
      0.00            +0.1        0.07        perf-profile.children.cycles-pp.ksys_read
      0.00            +0.1        0.07        perf-profile.children.cycles-pp.vfs_read
      0.00            +0.1        0.07 ± 10%  perf-profile.children.cycles-pp.memcpy_erms
      0.00            +0.1        0.07 ± 17%  perf-profile.children.cycles-pp.try_to_wake_up
      0.04 ± 57%      +0.1        0.11 ± 11%  perf-profile.children.cycles-pp.update_sd_lb_stats
      0.05            +0.1        0.12 ± 12%  perf-profile.children.cycles-pp.schedule
      0.06 ±  9%      +0.1        0.13 ±  3%  perf-profile.children.cycles-pp.copy_pte_range
      0.06 ±  9%      +0.1        0.13 ±  3%  perf-profile.children.cycles-pp.do_wait
      0.00            +0.1        0.07 ±  5%  perf-profile.children.cycles-pp.rcu_cblist_dequeue
      0.04 ± 57%      +0.1        0.11 ± 13%  perf-profile.children.cycles-pp.find_busiest_group
      0.08 ± 15%      +0.1        0.16 ± 12%  perf-profile.children.cycles-pp.update_cfs_group
      0.07 ± 14%      +0.1        0.15 ±  7%  perf-profile.children.cycles-pp.obj_cgroup_charge
      0.07 ±  6%      +0.1        0.14 ±  9%  perf-profile.children.cycles-pp.down_write
      0.06 ±  9%      +0.1        0.13 ±  5%  perf-profile.children.cycles-pp.__do_sys_wait4
      0.06 ±  9%      +0.1        0.13 ±  5%  perf-profile.children.cycles-pp.kernel_wait4
      0.03 ±100%      +0.1        0.11 ± 10%  perf-profile.children.cycles-pp.ima_file_check
      0.03 ±100%      +0.1        0.10 ± 12%  perf-profile.children.cycles-pp.finish_task_switch
      0.00            +0.1        0.08 ±  6%  perf-profile.children.cycles-pp.wait4
      0.00            +0.1        0.08 ±  6%  perf-profile.children.cycles-pp.__dentry_kill
      0.00            +0.1        0.08 ±  6%  perf-profile.children.cycles-pp.mem_cgroup_charge
      0.04 ±100%      +0.1        0.11 ±  7%  perf-profile.children.cycles-pp.security_file_open
      0.04 ±100%      +0.1        0.11 ±  7%  perf-profile.children.cycles-pp.apparmor_file_open
      0.04 ± 57%      +0.1        0.11 ±  9%  perf-profile.children.cycles-pp.newidle_balance
      0.03 ±100%      +0.1        0.11 ±  4%  perf-profile.children.cycles-pp.__x64_sys_kill
      0.01 ±173%      +0.1        0.09 ±  7%  perf-profile.children.cycles-pp.sock_sendmsg
      0.00            +0.1        0.08 ± 16%  perf-profile.children.cycles-pp.__memcg_kmem_uncharge_page
      0.06 ±  9%      +0.1        0.13 ±  6%  perf-profile.children.cycles-pp.wp_page_copy
      0.03 ±100%      +0.1        0.10 ±  4%  perf-profile.children.cycles-pp.__clear_user
      0.00            +0.1        0.08 ±  5%  perf-profile.children.cycles-pp.page_add_file_rmap
      0.00            +0.1        0.08 ±  5%  perf-profile.children.cycles-pp.__get_free_pages
      0.00            +0.1        0.08 ± 10%  perf-profile.children.cycles-pp.__put_anon_vma
      0.03 ±100%      +0.1        0.11 ±  7%  perf-profile.children.cycles-pp.apparmor_task_getsecid
      0.01 ±173%      +0.1        0.09 ±  4%  perf-profile.children.cycles-pp.lockref_put_return
      0.00            +0.1        0.08 ±  8%  perf-profile.children.cycles-pp.filldir64
      0.00            +0.1        0.08 ±  8%  perf-profile.children.cycles-pp.arch_do_signal
      0.01 ±173%      +0.1        0.09 ±  8%  perf-profile.children.cycles-pp.vm_area_alloc
      0.03 ±100%      +0.1        0.11 ±  9%  perf-profile.children.cycles-pp.security_task_getsecid
      0.00            +0.1        0.08 ± 10%  perf-profile.children.cycles-pp.vma_interval_tree_remove
      0.00            +0.1        0.08 ± 10%  perf-profile.children.cycles-pp.down_read
      0.00            +0.1        0.08 ± 10%  perf-profile.children.cycles-pp.schedule_idle
      0.00            +0.1        0.08 ± 17%  perf-profile.children.cycles-pp.put_cred_rcu
      0.04 ± 59%      +0.1        0.13 ±  8%  perf-profile.children.cycles-pp.__lock_parent
      0.01 ±173%      +0.1        0.10 ±  9%  perf-profile.children.cycles-pp.sock_write_iter
      0.06 ±  6%      +0.1        0.15 ±  3%  perf-profile.children.cycles-pp.get_page_from_freelist
      0.06 ±  7%      +0.1        0.14 ±  8%  perf-profile.children.cycles-pp.load_balance
      0.08 ± 14%      +0.1        0.16 ±  4%  perf-profile.children.cycles-pp.apparmor_file_alloc_security
      0.10 ±  8%      +0.1        0.19 ± 11%  perf-profile.children.cycles-pp.vma_interval_tree_insert
      0.04 ± 57%      +0.1        0.12 ±  8%  perf-profile.children.cycles-pp.pick_next_task_fair
      0.00            +0.1        0.08 ±  5%  perf-profile.children.cycles-pp.perf_event_mmap
      0.00            +0.1        0.08 ±  5%  perf-profile.children.cycles-pp.__pte_alloc
      0.07 ±  7%      +0.1        0.15 ±  4%  perf-profile.children.cycles-pp.do_anonymous_page
      0.08 ±  5%      +0.1        0.17 ±  4%  perf-profile.children.cycles-pp._dl_addr
      0.00            +0.1        0.09 ±  4%  perf-profile.children.cycles-pp.__slab_free
      0.00            +0.1        0.09 ±  4%  perf-profile.children.cycles-pp.sched_exec
      0.07 ±  6%      +0.1        0.16 ±  9%  perf-profile.children.cycles-pp.__d_alloc
      0.02 ±173%      +0.1        0.11 ± 10%  perf-profile.children.cycles-pp.unlink
      0.00            +0.1        0.09        perf-profile.children.cycles-pp.strncpy_from_user
      0.00            +0.1        0.09 ±  7%  perf-profile.children.cycles-pp.clear_page_erms
      0.09 ±  9%      +0.1        0.18 ±  3%  perf-profile.children.cycles-pp.find_idlest_group
      0.00            +0.1        0.09 ±  4%  perf-profile.children.cycles-pp.prep_new_page
      0.07 ± 12%      +0.1        0.16 ±  7%  perf-profile.children.cycles-pp.vm_area_dup
      0.09 ±  9%      +0.1        0.18 ± 12%  perf-profile.children.cycles-pp.new_sync_write
      0.07 ± 17%      +0.1        0.17 ± 17%  perf-profile.children.cycles-pp.write
      0.08 ± 19%      +0.1        0.17 ±  6%  perf-profile.children.cycles-pp.__memcg_kmem_charge_page
      0.02 ±173%      +0.1        0.12 ±  3%  perf-profile.children.cycles-pp.do_unlinkat
      0.08 ± 13%      +0.1        0.18 ±  2%  perf-profile.children.cycles-pp.security_file_alloc
      0.03 ±100%      +0.1        0.12 ± 14%  perf-profile.children.cycles-pp.__close
      0.18 ±  9%      +0.1        0.28 ± 14%  perf-profile.children.cycles-pp.task_tick_fair
      0.10 ± 12%      +0.1        0.20 ±  6%  perf-profile.children.cycles-pp.select_task_rq_fair
      0.08 ± 10%      +0.1        0.18 ±  4%  perf-profile.children.cycles-pp.page_remove_rmap
      0.06 ± 16%      +0.1        0.16 ± 14%  perf-profile.children.cycles-pp.__vm_munmap
      0.10 ±  8%      +0.1        0.20 ±  9%  perf-profile.children.cycles-pp.vfs_write
      0.07 ± 26%      +0.1        0.17 ± 14%  perf-profile.children.cycles-pp.kill
      0.07 ±  6%      +0.1        0.17 ±  8%  perf-profile.children.cycles-pp.anon_vma_clone
      0.00            +0.1        0.10 ±  8%  perf-profile.children.cycles-pp.malloc
      0.10 ±  8%      +0.1        0.20 ± 11%  perf-profile.children.cycles-pp.ksys_write
      0.09 ± 14%      +0.1        0.20 ±  2%  perf-profile.children.cycles-pp.copy_page_range
      0.11 ±  9%      +0.1        0.23 ± 13%  perf-profile.children.cycles-pp.__fput
      0.11 ± 16%      +0.1        0.23 ±  7%  perf-profile.children.cycles-pp.page_counter_try_charge
      0.00            +0.1        0.12 ±  3%  perf-profile.children.cycles-pp.cna_order_queue
      0.00            +0.1        0.12 ± 12%  perf-profile.children.cycles-pp.__put_task_struct
      0.11 ± 19%      +0.1        0.24 ±  7%  perf-profile.children.cycles-pp.__memcg_kmem_charge
      0.11 ± 12%      +0.1        0.24 ±  6%  perf-profile.children.cycles-pp.release_pages
      0.27 ±  6%      +0.1        0.41 ±  9%  perf-profile.children.cycles-pp.scheduler_tick
      0.07 ±  7%      +0.1        0.20 ± 15%  perf-profile.children.cycles-pp.__mod_memcg_lruvec_state
      0.03 ±100%      +0.1        0.17 ± 17%  perf-profile.children.cycles-pp.__mod_memcg_state
      0.10 ± 11%      +0.1        0.24 ± 10%  perf-profile.children.cycles-pp.remove_vma
      0.11 ± 12%      +0.1        0.25 ± 10%  perf-profile.children.cycles-pp.__schedule
      0.14 ± 11%      +0.1        0.28 ±  8%  perf-profile.children.cycles-pp.task_work_run
      0.07 ± 12%      +0.2        0.22 ±  7%  perf-profile.children.cycles-pp.__xstat64
      0.11 ± 15%      +0.2        0.27 ± 14%  perf-profile.children.cycles-pp.rwsem_spin_on_owner
      0.08 ± 21%      +0.2        0.24 ± 14%  perf-profile.children.cycles-pp.iterate_supers
      0.10 ± 12%      +0.2        0.26 ±  8%  perf-profile.children.cycles-pp.anon_vma_fork
      0.08 ± 21%      +0.2        0.24 ± 13%  perf-profile.children.cycles-pp.__x64_sys_sync
      0.08 ± 21%      +0.2        0.24 ± 13%  perf-profile.children.cycles-pp.ksys_sync
      0.08 ± 19%      +0.2        0.24 ± 14%  perf-profile.children.cycles-pp.sync
      0.14 ± 12%      +0.2        0.30 ±  6%  perf-profile.children.cycles-pp.tlb_flush_mmu
      0.15 ± 21%      +0.2        0.32 ± 28%  perf-profile.children.cycles-pp.menu_select
      0.44 ±  4%      +0.2        0.61 ±  7%  perf-profile.children.cycles-pp.tick_sched_timer
      0.14 ± 12%      +0.2        0.31 ±  6%  perf-profile.children.cycles-pp.tlb_finish_mmu
      0.15 ±  8%      +0.2        0.32 ±  5%  perf-profile.children.cycles-pp.setlocale
      0.36 ±  5%      +0.2        0.54 ±  7%  perf-profile.children.cycles-pp.update_process_times
      0.36 ±  5%      +0.2        0.54 ±  7%  perf-profile.children.cycles-pp.tick_sched_handle
      0.14 ± 12%      +0.2        0.32 ±  5%  perf-profile.children.cycles-pp.__alloc_pages_nodemask
      0.10 ± 14%      +0.2        0.28 ± 11%  perf-profile.children.cycles-pp.get_obj_cgroup_from_current
      0.16 ± 10%      +0.2        0.34 ±  8%  perf-profile.children.cycles-pp.exit_to_user_mode_prepare
      0.12 ± 12%      +0.2        0.30 ±  7%  perf-profile.children.cycles-pp.unlink_anon_vmas
      0.14 ± 12%      +0.2        0.33 ±  8%  perf-profile.children.cycles-pp.d_alloc
      0.16 ± 10%      +0.2        0.35 ±  7%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      0.53 ±  4%      +0.2        0.74 ±  7%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      0.83 ±  3%      +0.2        1.04 ±  7%  perf-profile.children.cycles-pp.hrtimer_interrupt
      0.12 ± 17%      +0.2        0.33 ± 17%  perf-profile.children.cycles-pp.load_elf_interp
      0.84 ±  3%      +0.2        1.05 ±  7%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      0.21 ± 10%      +0.2        0.46 ±  4%  perf-profile.children.cycles-pp.zap_pte_range
      0.22 ± 10%      +0.3        0.48 ±  4%  perf-profile.children.cycles-pp.unmap_page_range
      0.24 ±  9%      +0.3        0.51 ±  4%  perf-profile.children.cycles-pp.unmap_vmas
      0.15 ± 14%      +0.3        0.42 ± 16%  perf-profile.children.cycles-pp.elf_map
      0.14 ± 11%      +0.3        0.41 ±  8%  perf-profile.children.cycles-pp.mem_rtns_1
      0.25 ± 13%      +0.3        0.53 ±  7%  perf-profile.children.cycles-pp.d_alloc_parallel
      0.27 ± 12%      +0.3        0.56 ±  6%  perf-profile.children.cycles-pp.__lookup_slow
      0.22 ± 12%      +0.3        0.51 ±  6%  perf-profile.children.cycles-pp.alloc_empty_file
      0.22 ± 11%      +0.3        0.51 ±  7%  perf-profile.children.cycles-pp.__alloc_file
      0.18 ± 22%      +0.3        0.48 ± 13%  perf-profile.children.cycles-pp.div_int
      0.11 ± 16%      +0.3        0.41 ±  5%  perf-profile.children.cycles-pp.propagate_protected_usage
      0.13 ± 12%      +0.3        0.44 ±  4%  perf-profile.children.cycles-pp.lookup_fast
      0.21 ± 20%      +0.3        0.53 ± 14%  perf-profile.children.cycles-pp.div_short
      0.35 ±  6%      +0.3        0.68 ± 11%  perf-profile.children.cycles-pp.filemap_map_pages
      0.20 ± 21%      +0.3        0.55 ± 10%  perf-profile.children.cycles-pp.add_short
      0.39 ±  7%      +0.4        0.78 ± 10%  perf-profile.children.cycles-pp.do_fault
      0.28 ±  9%      +0.4        0.67 ±  2%  perf-profile.children.cycles-pp.__do_sys_newstat
      0.28 ±  9%      +0.4        0.68 ±  2%  perf-profile.children.cycles-pp.vfs_statx
      0.27 ±  9%      +0.4        0.68 ±  2%  perf-profile.children.cycles-pp.filename_lookup
      0.26 ± 11%      +0.4        0.67        perf-profile.children.cycles-pp.path_lookupat
      0.25 ± 19%      +0.5        0.72 ± 12%  perf-profile.children.cycles-pp.__strcat_chk
      0.38 ± 12%      +0.6        0.95 ±  9%  perf-profile.children.cycles-pp.kmem_cache_alloc
      0.58 ±  5%      +0.6        1.20 ±  7%  perf-profile.children.cycles-pp.__handle_mm_fault
      0.61 ±  5%      +0.7        1.27 ±  7%  perf-profile.children.cycles-pp.handle_mm_fault
      0.25 ± 14%      +0.7        0.91 ±  9%  perf-profile.children.cycles-pp.__memcg_kmem_uncharge
      0.42 ± 24%      +0.7        1.09 ± 14%  perf-profile.children.cycles-pp.div_long
      0.65 ±  5%      +0.7        1.33 ±  7%  perf-profile.children.cycles-pp.do_user_addr_fault
      0.65 ±  5%      +0.7        1.34 ±  7%  perf-profile.children.cycles-pp.exc_page_fault
      0.52 ± 10%      +0.7        1.22 ±  5%  perf-profile.children.cycles-pp.link_path_walk
      0.78 ±  7%      +0.7        1.50 ± 22%  perf-profile.children.cycles-pp.__libc_fork
      0.67 ±  5%      +0.7        1.41 ±  7%  perf-profile.children.cycles-pp.asm_exc_page_fault
      0.45 ± 18%      +0.7        1.19 ± 13%  perf-profile.children.cycles-pp.add_long
      0.46 ± 19%      +0.7        1.20 ± 12%  perf-profile.children.cycles-pp.add_int
      0.53 ± 10%      +0.8        1.28 ±  5%  perf-profile.children.cycles-pp.walk_component
      0.46 ± 16%      +0.8        1.29 ± 10%  perf-profile.children.cycles-pp.__strncat_chk
      0.11 ± 13%      +1.0        1.07 ± 24%  perf-profile.children.cycles-pp.terminate_walk
      0.54 ±  9%      +1.0        1.50 ± 18%  perf-profile.children.cycles-pp.irq_exit_rcu
      0.53 ±  8%      +1.0        1.51 ± 18%  perf-profile.children.cycles-pp.do_softirq_own_stack
      0.44 ± 34%      +1.0        1.44 ± 10%  perf-profile.children.cycles-pp.creat64
      0.40 ± 12%      +1.0        1.42 ±  9%  perf-profile.children.cycles-pp.page_counter_cancel
      1.15 ±  8%      +1.1        2.21 ± 23%  perf-profile.children.cycles-pp.begin_new_exec
      0.42 ± 13%      +1.1        1.53 ±  9%  perf-profile.children.cycles-pp.page_counter_uncharge
      1.32 ±  3%      +1.1        2.45 ± 13%  perf-profile.children.cycles-pp.asm_call_sysvec_on_stack
      1.30 ±  8%      +1.2        2.46 ± 21%  perf-profile.children.cycles-pp.__x64_sys_exit_group
      1.30 ±  8%      +1.2        2.46 ± 21%  perf-profile.children.cycles-pp.do_group_exit
      1.30 ±  8%      +1.2        2.46 ± 21%  perf-profile.children.cycles-pp.do_exit
      1.41 ±  8%      +1.2        2.65 ± 25%  perf-profile.children.cycles-pp.dup_mmap
      1.43 ±  3%      +1.2        2.68 ± 12%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      1.42 ±  8%      +1.3        2.68 ± 25%  perf-profile.children.cycles-pp.dup_mm
      1.54 ±  5%      +1.3        2.87 ± 11%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
      0.00            +1.4        1.40 ± 18%  perf-profile.children.cycles-pp.dcache_dir_open
      0.00            +1.4        1.40 ± 18%  perf-profile.children.cycles-pp.d_alloc_cursor
      1.52 ±  7%      +1.4        2.92 ± 23%  perf-profile.children.cycles-pp.copy_process
      0.46 ± 12%      +1.4        1.87 ±  7%  perf-profile.children.cycles-pp.drain_obj_stock
      1.58 ±  7%      +1.5        3.06 ± 22%  perf-profile.children.cycles-pp.__do_sys_clone
      1.58 ±  7%      +1.5        3.06 ± 22%  perf-profile.children.cycles-pp.kernel_clone
      1.43 ±  8%      +1.5        2.92 ± 19%  perf-profile.children.cycles-pp.load_elf_binary
      1.43 ±  7%      +1.5        2.94 ± 19%  perf-profile.children.cycles-pp.exec_binprm
      0.55 ± 12%      +1.7        2.29 ±  7%  perf-profile.children.cycles-pp.refill_obj_stock
      2.33 ±  8%      +2.1        4.39 ± 23%  perf-profile.children.cycles-pp.exit_mmap
      2.33 ±  8%      +2.1        4.40 ± 23%  perf-profile.children.cycles-pp.mmput
      1.52 ± 16%      +2.7        4.25 ± 11%  perf-profile.children.cycles-pp.string_rtns_1
      0.00            +3.5        3.47 ± 17%  perf-profile.children.cycles-pp.lockref_get
      0.09 ± 17%      +3.5        3.60 ± 16%  perf-profile.children.cycles-pp.do_dentry_open
      0.68 ± 17%      +3.9        4.55 ±  2%  perf-profile.children.cycles-pp.run_ksoftirqd
      0.69 ± 17%      +3.9        4.58 ±  2%  perf-profile.children.cycles-pp.smpboot_thread_fn
      0.72 ± 17%      +3.9        4.64 ±  2%  perf-profile.children.cycles-pp.kthread
      0.73 ± 17%      +3.9        4.68 ±  2%  perf-profile.children.cycles-pp.ret_from_fork
      4.07 ± 12%      +4.0        8.07 ±  9%  perf-profile.children.cycles-pp.intel_idle
      1.15 ± 13%      +4.8        5.92 ±  5%  perf-profile.children.cycles-pp.rcu_do_batch
      1.15 ± 13%      +4.8        5.93 ±  5%  perf-profile.children.cycles-pp.rcu_core
      1.22 ± 12%      +4.8        6.06 ±  5%  perf-profile.children.cycles-pp.__softirqentry_text_start
      1.26 ± 13%      +4.9        6.13 ±  5%  perf-profile.children.cycles-pp.kmem_cache_free
      4.69 ± 10%      +4.9        9.61 ±  7%  perf-profile.children.cycles-pp.cpuidle_enter_state
      4.69 ± 10%      +4.9        9.62 ±  7%  perf-profile.children.cycles-pp.cpuidle_enter
      4.87 ±  9%      +5.1       10.01 ±  7%  perf-profile.children.cycles-pp.start_secondary
      4.90 ±  9%      +5.2       10.07 ±  7%  perf-profile.children.cycles-pp.secondary_startup_64_no_verify
      4.90 ±  9%      +5.2       10.07 ±  7%  perf-profile.children.cycles-pp.cpu_startup_entry
      4.90 ±  9%      +5.2       10.07 ±  7%  perf-profile.children.cycles-pp.do_idle
      0.27 ±  7%      +7.3        7.56 ±  4%  perf-profile.children.cycles-pp.lockref_put_or_lock
      0.53 ±  6%      +7.7        8.26 ±  4%  perf-profile.children.cycles-pp.dput
      0.00            +8.3        8.31 ±  8%  perf-profile.children.cycles-pp.complete_walk
      0.13 ± 12%     +11.6       11.69 ± 22%  perf-profile.children.cycles-pp.__open64_nocancel
      1.17 ± 16%     +14.2       15.37 ±  9%  perf-profile.children.cycles-pp.do_sys_openat2
      1.17 ± 16%     +14.2       15.37 ±  9%  perf-profile.children.cycles-pp.do_sys_open
      0.06 ±  6%     +20.7       20.76 ± 11%  perf-profile.children.cycles-pp.pick_link
      1.35 ±  8%     +25.6       26.90 ±  9%  perf-profile.children.cycles-pp.execve
      0.10 ±  4%     +27.3       27.38 ± 10%  perf-profile.children.cycles-pp.do_open_execat
      0.20 ±  3%     +27.4       27.64 ± 10%  perf-profile.children.cycles-pp.step_into
      1.57 ±  7%     +28.8       30.40 ±  9%  perf-profile.children.cycles-pp.bprm_execve
      1.66 ±  7%     +29.0       30.62 ±  9%  perf-profile.children.cycles-pp.do_execveat_common
      1.67 ±  7%     +29.0       30.63 ±  9%  perf-profile.children.cycles-pp.__x64_sys_execve
      0.15 ±  8%     +29.4       29.55 ±  8%  perf-profile.children.cycles-pp.lockref_get_not_dead
      0.16 ±  6%     +29.4       29.58 ±  8%  perf-profile.children.cycles-pp.__legitimize_path
      0.17 ±  7%     +29.4       29.59 ±  8%  perf-profile.children.cycles-pp.unlazy_walk
      1.21 ± 15%     +41.4       42.61 ±  6%  perf-profile.children.cycles-pp.do_filp_open
      1.21 ± 15%     +41.4       42.61 ±  6%  perf-profile.children.cycles-pp.path_openat
      0.00           +52.3       52.34 ±  6%  perf-profile.children.cycles-pp.__cna_queued_spin_lock_slowpath
     78.44 ±  2%     -78.4        0.00        perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.syscall_return_via_sysret
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.sync_regs
      0.05            +0.1        0.10 ±  4%  perf-profile.self.cycles-pp.___might_sleep
      0.00            +0.1        0.05 ±  8%  perf-profile.self.cycles-pp.d_alloc_parallel
      0.04 ± 57%      +0.1        0.09 ±  8%  perf-profile.self.cycles-pp.up_write
      0.00            +0.1        0.06 ±  9%  perf-profile.self.cycles-pp.__might_sleep
      0.03 ±100%      +0.1        0.08 ± 10%  perf-profile.self.cycles-pp.aa_get_task_label
      0.00            +0.1        0.06 ±  7%  perf-profile.self.cycles-pp.filldir64
      0.00            +0.1        0.06 ±  7%  perf-profile.self.cycles-pp.lock_page_memcg
      0.00            +0.1        0.06 ±  7%  perf-profile.self.cycles-pp.strnlen_user
      0.00            +0.1        0.06        perf-profile.self.cycles-pp.copy_pte_range
      0.00            +0.1        0.06        perf-profile.self.cycles-pp.anon_vma_interval_tree_insert
      0.00            +0.1        0.06 ± 11%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.06 ± 11%      +0.1        0.12 ±  6%  perf-profile.self.cycles-pp.__d_lookup_rcu
      0.00            +0.1        0.06 ± 13%  perf-profile.self.cycles-pp.compar1
      0.00            +0.1        0.06 ±  6%  perf-profile.self.cycles-pp.file_free_rcu
      0.00            +0.1        0.06 ± 13%  perf-profile.self.cycles-pp.free_pages_and_swap_cache
      0.06 ±  7%      +0.1        0.12 ± 12%  perf-profile.self.cycles-pp.down_write
      0.08            +0.1        0.15 ±  3%  perf-profile.self.cycles-pp.native_irq_return_iret
      0.06 ± 13%      +0.1        0.13 ±  5%  perf-profile.self.cycles-pp.release_pages
      0.00            +0.1        0.07 ± 12%  perf-profile.self.cycles-pp.memcpy_erms
      0.00            +0.1        0.07 ± 16%  perf-profile.self.cycles-pp.__handle_mm_fault
      0.04 ± 59%      +0.1        0.12 ±  7%  perf-profile.self.cycles-pp.apparmor_file_free_security
      0.07 ±  7%      +0.1        0.14 ±  6%  perf-profile.self.cycles-pp.lockref_get_not_dead
      0.00            +0.1        0.07 ±  5%  perf-profile.self.cycles-pp.rcu_cblist_dequeue
      0.08 ± 15%      +0.1        0.16 ± 12%  perf-profile.self.cycles-pp.update_cfs_group
      0.07 ±  7%      +0.1        0.14 ±  5%  perf-profile.self.cycles-pp.page_remove_rmap
      0.00            +0.1        0.08 ± 11%  perf-profile.self.cycles-pp.down_read
      0.08 ± 14%      +0.1        0.15 ±  2%  perf-profile.self.cycles-pp.apparmor_file_alloc_security
      0.00            +0.1        0.08 ±  5%  perf-profile.self.cycles-pp.vma_interval_tree_remove
      0.03 ±100%      +0.1        0.11 ±  7%  perf-profile.self.cycles-pp.apparmor_file_open
      0.01 ±173%      +0.1        0.09 ±  4%  perf-profile.self.cycles-pp.lockref_put_return
      0.10 ± 10%      +0.1        0.18 ± 10%  perf-profile.self.cycles-pp.vma_interval_tree_insert
      0.08 ± 10%      +0.1        0.16 ±  4%  perf-profile.self.cycles-pp.find_idlest_group
      0.00            +0.1        0.08 ±  5%  perf-profile.self.cycles-pp.__slab_free
      0.00            +0.1        0.09 ±  9%  perf-profile.self.cycles-pp.clear_page_erms
      0.08 ±  5%      +0.1        0.17 ±  4%  perf-profile.self.cycles-pp._dl_addr
      0.00            +0.1        0.09 ±  7%  perf-profile.self.cycles-pp.update_sd_lb_stats
      0.09 ± 14%      +0.1        0.19 ±  9%  perf-profile.self.cycles-pp.page_counter_try_charge
      0.00            +0.1        0.10 ±  9%  perf-profile.self.cycles-pp.malloc
      0.11 ±  9%      +0.1        0.23 ±  5%  perf-profile.self.cycles-pp.zap_pte_range
      0.00            +0.1        0.11 ±  4%  perf-profile.self.cycles-pp.cna_order_queue
      0.00            +0.1        0.12 ± 11%  perf-profile.self.cycles-pp.page_counter_uncharge
      0.03 ±100%      +0.1        0.17 ± 17%  perf-profile.self.cycles-pp.__mod_memcg_state
      0.11 ± 12%      +0.1        0.26 ± 14%  perf-profile.self.cycles-pp.rwsem_spin_on_owner
      0.10 ± 14%      +0.2        0.27 ± 10%  perf-profile.self.cycles-pp.get_obj_cgroup_from_current
      0.15 ± 10%      +0.2        0.38 ±  6%  perf-profile.self.cycles-pp.kmem_cache_alloc
      0.26 ±  8%      +0.2        0.49 ± 13%  perf-profile.self.cycles-pp.filemap_map_pages
      0.42            +0.2        0.66        perf-profile.self.cycles-pp._raw_spin_lock
      0.14 ± 11%      +0.3        0.40 ±  8%  perf-profile.self.cycles-pp.mem_rtns_1
      0.18 ± 22%      +0.3        0.47 ± 13%  perf-profile.self.cycles-pp.div_int
      0.11 ± 16%      +0.3        0.40 ±  6%  perf-profile.self.cycles-pp.propagate_protected_usage
      0.09 ± 13%      +0.3        0.40 ±  5%  perf-profile.self.cycles-pp.refill_obj_stock
      0.21 ± 20%      +0.3        0.52 ± 14%  perf-profile.self.cycles-pp.div_short
      0.20 ± 21%      +0.3        0.54 ± 11%  perf-profile.self.cycles-pp.add_short
      0.08 ± 13%      +0.4        0.46 ±  4%  perf-profile.self.cycles-pp.drain_obj_stock
      0.25 ± 19%      +0.4        0.70 ± 11%  perf-profile.self.cycles-pp.__strcat_chk
      0.42 ± 23%      +0.7        1.08 ± 14%  perf-profile.self.cycles-pp.div_long
      0.45 ± 18%      +0.7        1.17 ± 12%  perf-profile.self.cycles-pp.add_long
      0.45 ± 19%      +0.7        1.18 ± 12%  perf-profile.self.cycles-pp.add_int
      0.31 ± 12%      +0.7        1.04 ± 10%  perf-profile.self.cycles-pp.page_counter_cancel
      0.45 ± 17%      +0.8        1.26 ± 10%  perf-profile.self.cycles-pp.__strncat_chk
      1.49 ± 15%      +2.7        4.16 ± 11%  perf-profile.self.cycles-pp.string_rtns_1
      0.66 ± 14%      +3.0        3.62 ±  6%  perf-profile.self.cycles-pp.kmem_cache_free
      4.07 ± 12%      +4.0        8.07 ±  9%  perf-profile.self.cycles-pp.intel_idle
      0.00           +51.6       51.64 ±  6%  perf-profile.self.cycles-pp.__cna_queued_spin_lock_slowpath
      5010 ±  4%     -26.5%       3684 ± 10%  interrupts.CPU0.NMI:Non-maskable_interrupts
      5010 ±  4%     -26.5%       3684 ± 10%  interrupts.CPU0.PMI:Performance_monitoring_interrupts
    886.00 ±  3%     +15.7%       1025 ±  2%  interrupts.CPU1.RES:Rescheduling_interrupts
    539.50 ± 19%     +43.7%     775.25 ± 12%  interrupts.CPU1.TLB:TLB_shootdowns
    839.25 ±  5%     +25.9%       1056 ±  3%  interrupts.CPU10.RES:Rescheduling_interrupts
    440.75 ± 15%     +93.4%     852.50 ± 14%  interrupts.CPU10.TLB:TLB_shootdowns
    852.00 ±  4%     +34.4%       1144 ±  7%  interrupts.CPU100.RES:Rescheduling_interrupts
    441.75 ± 27%     +68.9%     746.00 ± 17%  interrupts.CPU100.TLB:TLB_shootdowns
    811.75 ±  5%     +39.3%       1130 ±  4%  interrupts.CPU101.RES:Rescheduling_interrupts
    424.50 ± 19%     +71.3%     727.25 ± 10%  interrupts.CPU101.TLB:TLB_shootdowns
      5057 ±  3%     -36.3%       3222 ± 32%  interrupts.CPU102.NMI:Non-maskable_interrupts
      5057 ±  3%     -36.3%       3222 ± 32%  interrupts.CPU102.PMI:Performance_monitoring_interrupts
    803.25 ±  4%     +35.9%       1091 ±  7%  interrupts.CPU102.RES:Rescheduling_interrupts
    437.50 ± 23%     +82.9%     800.00 ± 12%  interrupts.CPU102.TLB:TLB_shootdowns
      5014 ±  4%     -36.5%       3184 ± 31%  interrupts.CPU103.NMI:Non-maskable_interrupts
      5014 ±  4%     -36.5%       3184 ± 31%  interrupts.CPU103.PMI:Performance_monitoring_interrupts
    758.25 ±  2%     +50.9%       1144 ±  7%  interrupts.CPU103.RES:Rescheduling_interrupts
    470.00 ± 12%     +73.5%     815.25 ±  9%  interrupts.CPU103.TLB:TLB_shootdowns
    764.25 ±  4%     +37.8%       1053 ±  6%  interrupts.CPU104.RES:Rescheduling_interrupts
    416.00 ± 15%     +84.1%     765.75 ±  9%  interrupts.CPU104.TLB:TLB_shootdowns
    760.00 ±  4%     +46.0%       1109 ±  3%  interrupts.CPU105.RES:Rescheduling_interrupts
    461.50 ±  9%     +60.3%     740.00 ±  5%  interrupts.CPU105.TLB:TLB_shootdowns
    784.75 ±  4%     +40.1%       1099 ±  8%  interrupts.CPU106.RES:Rescheduling_interrupts
    406.50 ± 19%     +87.0%     760.25 ±  8%  interrupts.CPU106.TLB:TLB_shootdowns
      5009 ±  4%     -27.9%       3613 ± 11%  interrupts.CPU107.NMI:Non-maskable_interrupts
      5009 ±  4%     -27.9%       3613 ± 11%  interrupts.CPU107.PMI:Performance_monitoring_interrupts
    777.25 ±  3%     +37.1%       1065 ±  5%  interrupts.CPU107.RES:Rescheduling_interrupts
    424.25 ± 18%    +110.9%     894.75 ± 13%  interrupts.CPU107.TLB:TLB_shootdowns
    796.50 ±  7%     +40.5%       1119 ±  9%  interrupts.CPU108.RES:Rescheduling_interrupts
    433.75 ± 12%     +85.1%     802.75 ± 18%  interrupts.CPU108.TLB:TLB_shootdowns
      5034 ±  3%     -35.8%       3233 ± 32%  interrupts.CPU109.NMI:Non-maskable_interrupts
      5034 ±  3%     -35.8%       3233 ± 32%  interrupts.CPU109.PMI:Performance_monitoring_interrupts
    757.75 ±  4%     +41.9%       1075 ±  8%  interrupts.CPU109.RES:Rescheduling_interrupts
    388.50 ±  5%    +103.0%     788.75 ±  9%  interrupts.CPU109.TLB:TLB_shootdowns
    856.50 ±  4%     +28.4%       1100 ±  5%  interrupts.CPU11.RES:Rescheduling_interrupts
    451.25 ± 11%     +74.7%     788.25 ± 12%  interrupts.CPU11.TLB:TLB_shootdowns
    757.25 ±  5%     +44.7%       1095 ±  6%  interrupts.CPU110.RES:Rescheduling_interrupts
    441.00 ± 16%     +80.3%     795.25 ±  3%  interrupts.CPU110.TLB:TLB_shootdowns
      5035 ±  4%     -28.4%       3606 ± 13%  interrupts.CPU111.NMI:Non-maskable_interrupts
      5035 ±  4%     -28.4%       3606 ± 13%  interrupts.CPU111.PMI:Performance_monitoring_interrupts
    774.50 ±  6%     +43.6%       1112 ±  5%  interrupts.CPU111.RES:Rescheduling_interrupts
    425.50 ± 11%     +77.1%     753.50 ± 11%  interrupts.CPU111.TLB:TLB_shootdowns
      4995 ±  5%     -28.3%       3580 ± 14%  interrupts.CPU112.NMI:Non-maskable_interrupts
      4995 ±  5%     -28.3%       3580 ± 14%  interrupts.CPU112.PMI:Performance_monitoring_interrupts
    762.25 ±  7%     +45.4%       1108 ±  4%  interrupts.CPU112.RES:Rescheduling_interrupts
    415.50 ± 12%     +86.1%     773.25 ± 11%  interrupts.CPU112.TLB:TLB_shootdowns
      5042 ±  3%     -29.3%       3566 ± 16%  interrupts.CPU113.NMI:Non-maskable_interrupts
      5042 ±  3%     -29.3%       3566 ± 16%  interrupts.CPU113.PMI:Performance_monitoring_interrupts
    825.00 ±  2%     +24.0%       1022 ±  8%  interrupts.CPU113.RES:Rescheduling_interrupts
    438.75 ± 11%     +80.2%     790.50 ± 12%  interrupts.CPU113.TLB:TLB_shootdowns
      4966 ±  4%     -29.1%       3520 ± 13%  interrupts.CPU114.NMI:Non-maskable_interrupts
      4966 ±  4%     -29.1%       3520 ± 13%  interrupts.CPU114.PMI:Performance_monitoring_interrupts
    793.75 ±  6%     +42.8%       1133 ±  6%  interrupts.CPU114.RES:Rescheduling_interrupts
    470.75 ± 14%     +65.4%     778.75 ± 12%  interrupts.CPU114.TLB:TLB_shootdowns
      5036 ±  3%     -36.2%       3211 ± 33%  interrupts.CPU115.NMI:Non-maskable_interrupts
      5036 ±  3%     -36.2%       3211 ± 33%  interrupts.CPU115.PMI:Performance_monitoring_interrupts
    768.25 ±  7%     +44.6%       1111 ±  4%  interrupts.CPU115.RES:Rescheduling_interrupts
    411.50 ± 19%     +81.7%     747.50 ±  5%  interrupts.CPU115.TLB:TLB_shootdowns
    748.50           +43.0%       1070 ±  7%  interrupts.CPU116.RES:Rescheduling_interrupts
    484.00 ± 16%     +67.1%     808.75 ± 10%  interrupts.CPU116.TLB:TLB_shootdowns
      5061 ±  4%     -30.9%       3498 ± 16%  interrupts.CPU117.NMI:Non-maskable_interrupts
      5061 ±  4%     -30.9%       3498 ± 16%  interrupts.CPU117.PMI:Performance_monitoring_interrupts
    742.25 ±  4%     +47.2%       1092 ±  7%  interrupts.CPU117.RES:Rescheduling_interrupts
    402.50 ± 18%     +95.8%     788.00 ± 13%  interrupts.CPU117.TLB:TLB_shootdowns
      5032 ±  4%     -36.6%       3191 ± 32%  interrupts.CPU118.NMI:Non-maskable_interrupts
      5032 ±  4%     -36.6%       3191 ± 32%  interrupts.CPU118.PMI:Performance_monitoring_interrupts
    781.75 ±  7%     +42.4%       1113 ±  8%  interrupts.CPU118.RES:Rescheduling_interrupts
    480.25 ± 15%     +62.7%     781.50 ± 14%  interrupts.CPU118.TLB:TLB_shootdowns
    796.75 ±  3%     +35.2%       1077 ±  8%  interrupts.CPU119.RES:Rescheduling_interrupts
    482.25 ± 21%     +52.2%     733.75 ±  2%  interrupts.CPU119.TLB:TLB_shootdowns
      5045 ±  3%     -27.9%       3637 ± 11%  interrupts.CPU12.NMI:Non-maskable_interrupts
      5045 ±  3%     -27.9%       3637 ± 11%  interrupts.CPU12.PMI:Performance_monitoring_interrupts
    818.50 ±  3%     +31.6%       1076 ±  4%  interrupts.CPU12.RES:Rescheduling_interrupts
    451.25 ± 13%     +85.7%     837.75 ± 16%  interrupts.CPU12.TLB:TLB_shootdowns
    762.75 ±  2%     +49.8%       1142 ±  6%  interrupts.CPU120.RES:Rescheduling_interrupts
    406.50 ± 13%     +97.7%     803.50 ±  9%  interrupts.CPU120.TLB:TLB_shootdowns
    743.00 ±  4%     +60.9%       1195 ±  3%  interrupts.CPU121.RES:Rescheduling_interrupts
    442.75 ± 17%     +85.3%     820.25 ±  8%  interrupts.CPU121.TLB:TLB_shootdowns
    736.25 ±  3%     +55.2%       1142 ±  8%  interrupts.CPU122.RES:Rescheduling_interrupts
    430.50 ± 15%     +98.0%     852.50 ± 10%  interrupts.CPU122.TLB:TLB_shootdowns
    732.75 ±  8%     +52.9%       1120 ±  7%  interrupts.CPU123.RES:Rescheduling_interrupts
    452.25 ±  3%     +82.0%     823.00 ± 11%  interrupts.CPU123.TLB:TLB_shootdowns
    764.50 ±  2%     +46.1%       1116 ±  6%  interrupts.CPU124.RES:Rescheduling_interrupts
    440.75 ± 14%     +60.7%     708.25 ± 10%  interrupts.CPU124.TLB:TLB_shootdowns
    726.00 ±  3%     +58.0%       1147 ±  9%  interrupts.CPU125.RES:Rescheduling_interrupts
    395.50 ± 15%    +102.5%     801.00 ±  6%  interrupts.CPU125.TLB:TLB_shootdowns
    717.25 ±  3%     +62.4%       1165 ± 14%  interrupts.CPU126.RES:Rescheduling_interrupts
    400.25 ±  7%    +107.2%     829.25 ±  5%  interrupts.CPU126.TLB:TLB_shootdowns
    712.00 ±  5%     +57.8%       1123 ±  9%  interrupts.CPU127.RES:Rescheduling_interrupts
    453.50 ±  5%     +87.5%     850.25 ±  5%  interrupts.CPU127.TLB:TLB_shootdowns
      5023 ±  5%     -28.5%       3590 ± 12%  interrupts.CPU128.NMI:Non-maskable_interrupts
      5023 ±  5%     -28.5%       3590 ± 12%  interrupts.CPU128.PMI:Performance_monitoring_interrupts
    686.25           +69.7%       1164 ±  5%  interrupts.CPU128.RES:Rescheduling_interrupts
    471.25 ± 14%     +72.6%     813.25 ±  3%  interrupts.CPU128.TLB:TLB_shootdowns
      5049 ±  3%     -27.6%       3653 ± 12%  interrupts.CPU129.NMI:Non-maskable_interrupts
      5049 ±  3%     -27.6%       3653 ± 12%  interrupts.CPU129.PMI:Performance_monitoring_interrupts
    727.00 ±  6%     +56.8%       1140 ± 10%  interrupts.CPU129.RES:Rescheduling_interrupts
    413.75 ±  2%    +141.9%       1001 ± 42%  interrupts.CPU129.TLB:TLB_shootdowns
    863.00 ±  5%     +26.7%       1093 ±  9%  interrupts.CPU13.RES:Rescheduling_interrupts
    438.25 ± 12%     +72.8%     757.50 ± 18%  interrupts.CPU13.TLB:TLB_shootdowns
      5029 ±  4%     -27.4%       3649 ± 14%  interrupts.CPU130.NMI:Non-maskable_interrupts
      5029 ±  4%     -27.4%       3649 ± 14%  interrupts.CPU130.PMI:Performance_monitoring_interrupts
    730.25 ±  3%     +51.0%       1103 ±  5%  interrupts.CPU130.RES:Rescheduling_interrupts
    432.25 ±  5%     +90.2%     822.25 ±  5%  interrupts.CPU130.TLB:TLB_shootdowns
    744.00 ±  6%     +56.4%       1163 ±  7%  interrupts.CPU131.RES:Rescheduling_interrupts
    425.00 ± 16%     +85.6%     788.75 ± 13%  interrupts.CPU131.TLB:TLB_shootdowns
    753.00 ±  5%     +52.7%       1149 ± 10%  interrupts.CPU132.RES:Rescheduling_interrupts
    429.75 ±  7%     +84.1%     791.00 ± 11%  interrupts.CPU132.TLB:TLB_shootdowns
    769.75 ±  3%     +40.6%       1082 ±  4%  interrupts.CPU133.RES:Rescheduling_interrupts
    416.25 ± 18%     +82.9%     761.25 ±  5%  interrupts.CPU133.TLB:TLB_shootdowns
    667.25 ±  7%     +69.2%       1129 ±  6%  interrupts.CPU134.RES:Rescheduling_interrupts
    431.50 ± 12%     +93.3%     834.25 ± 10%  interrupts.CPU134.TLB:TLB_shootdowns
      5086 ±  3%     -28.4%       3642 ± 14%  interrupts.CPU135.NMI:Non-maskable_interrupts
      5086 ±  3%     -28.4%       3642 ± 14%  interrupts.CPU135.PMI:Performance_monitoring_interrupts
    705.50 ±  7%     +63.0%       1150 ±  9%  interrupts.CPU135.RES:Rescheduling_interrupts
    415.75 ± 14%     +90.1%     790.25 ±  8%  interrupts.CPU135.TLB:TLB_shootdowns
      5054 ±  4%     -28.7%       3604 ± 14%  interrupts.CPU136.NMI:Non-maskable_interrupts
      5054 ±  4%     -28.7%       3604 ± 14%  interrupts.CPU136.PMI:Performance_monitoring_interrupts
    745.50 ± 11%     +46.3%       1091 ± 10%  interrupts.CPU136.RES:Rescheduling_interrupts
    435.75 ± 14%     +88.2%     820.00 ± 10%  interrupts.CPU136.TLB:TLB_shootdowns
    746.00 ± 12%     +52.5%       1138 ±  9%  interrupts.CPU137.RES:Rescheduling_interrupts
    429.75 ± 13%     +91.5%     823.00 ± 12%  interrupts.CPU137.TLB:TLB_shootdowns
    754.50 ±  5%     +48.2%       1118 ±  8%  interrupts.CPU138.RES:Rescheduling_interrupts
    433.00 ±  8%     +74.3%     754.75 ± 10%  interrupts.CPU138.TLB:TLB_shootdowns
    669.75 ±  2%     +66.7%       1116 ±  3%  interrupts.CPU139.RES:Rescheduling_interrupts
    419.50 ± 13%     +99.7%     837.75 ±  8%  interrupts.CPU139.TLB:TLB_shootdowns
    884.75           +16.6%       1031 ±  5%  interrupts.CPU14.RES:Rescheduling_interrupts
    471.50 ± 17%     +73.1%     816.25 ± 17%  interrupts.CPU14.TLB:TLB_shootdowns
    761.25 ±  3%     +45.4%       1107 ±  6%  interrupts.CPU140.RES:Rescheduling_interrupts
    470.25 ±  8%     +72.5%     811.25 ± 11%  interrupts.CPU140.TLB:TLB_shootdowns
      5050 ±  4%     -26.8%       3695 ± 13%  interrupts.CPU141.NMI:Non-maskable_interrupts
      5050 ±  4%     -26.8%       3695 ± 13%  interrupts.CPU141.PMI:Performance_monitoring_interrupts
    744.50           +61.9%       1205 ± 18%  interrupts.CPU141.RES:Rescheduling_interrupts
    453.25 ± 16%     +84.1%     834.50 ±  9%  interrupts.CPU141.TLB:TLB_shootdowns
    735.25 ±  5%     +54.6%       1136 ± 10%  interrupts.CPU142.RES:Rescheduling_interrupts
    430.50 ± 11%     +93.2%     831.75 ± 10%  interrupts.CPU142.TLB:TLB_shootdowns
    715.75 ±  2%     +59.3%       1140 ±  4%  interrupts.CPU143.RES:Rescheduling_interrupts
    448.00 ± 15%     +84.5%     826.75 ±  9%  interrupts.CPU143.TLB:TLB_shootdowns
      5018 ±  4%     -26.7%       3679 ± 12%  interrupts.CPU144.NMI:Non-maskable_interrupts
      5018 ±  4%     -26.7%       3679 ± 12%  interrupts.CPU144.PMI:Performance_monitoring_interrupts
    782.25 ±  5%     +56.5%       1224 ± 12%  interrupts.CPU144.RES:Rescheduling_interrupts
    463.00 ± 17%     +89.4%     876.75 ± 10%  interrupts.CPU144.TLB:TLB_shootdowns
      4972 ±  4%     -26.5%       3652 ± 12%  interrupts.CPU145.NMI:Non-maskable_interrupts
      4972 ±  4%     -26.5%       3652 ± 12%  interrupts.CPU145.PMI:Performance_monitoring_interrupts
    757.50 ±  7%     +54.4%       1169 ±  8%  interrupts.CPU145.RES:Rescheduling_interrupts
    408.50 ±  7%    +105.4%     839.25 ± 16%  interrupts.CPU145.TLB:TLB_shootdowns
      5056 ±  3%     -36.0%       3237 ± 31%  interrupts.CPU146.NMI:Non-maskable_interrupts
      5056 ±  3%     -36.0%       3237 ± 31%  interrupts.CPU146.PMI:Performance_monitoring_interrupts
    783.00 ±  9%     +52.3%       1192 ±  7%  interrupts.CPU146.RES:Rescheduling_interrupts
    448.50 ± 15%     +92.6%     864.00 ± 15%  interrupts.CPU146.TLB:TLB_shootdowns
      4964 ±  4%     -27.9%       3577 ± 12%  interrupts.CPU147.NMI:Non-maskable_interrupts
      4964 ±  4%     -27.9%       3577 ± 12%  interrupts.CPU147.PMI:Performance_monitoring_interrupts
    789.00 ±  8%     +51.1%       1192 ±  8%  interrupts.CPU147.RES:Rescheduling_interrupts
    423.50 ± 16%     +94.2%     822.25 ± 11%  interrupts.CPU147.TLB:TLB_shootdowns
      5021 ±  2%     -26.8%       3674 ± 12%  interrupts.CPU148.NMI:Non-maskable_interrupts
      5021 ±  2%     -26.8%       3674 ± 12%  interrupts.CPU148.PMI:Performance_monitoring_interrupts
    718.75 ±  4%     +63.7%       1176 ± 10%  interrupts.CPU148.RES:Rescheduling_interrupts
    424.00 ± 16%     +92.5%     816.00 ± 17%  interrupts.CPU148.TLB:TLB_shootdowns
      4987 ±  2%     -33.7%       3306 ± 32%  interrupts.CPU149.NMI:Non-maskable_interrupts
      4987 ±  2%     -33.7%       3306 ± 32%  interrupts.CPU149.PMI:Performance_monitoring_interrupts
    720.75 ±  6%     +65.3%       1191 ± 11%  interrupts.CPU149.RES:Rescheduling_interrupts
    444.00 ± 24%     +85.3%     822.75 ±  9%  interrupts.CPU149.TLB:TLB_shootdowns
    836.25 ±  3%     +28.8%       1077 ±  5%  interrupts.CPU15.RES:Rescheduling_interrupts
    455.50 ±  4%     +79.1%     815.75 ± 13%  interrupts.CPU15.TLB:TLB_shootdowns
      5038 ±  5%     -27.3%       3663 ± 12%  interrupts.CPU150.NMI:Non-maskable_interrupts
      5038 ±  5%     -27.3%       3663 ± 12%  interrupts.CPU150.PMI:Performance_monitoring_interrupts
    673.00 ±  5%     +64.6%       1107 ± 11%  interrupts.CPU150.RES:Rescheduling_interrupts
    421.00 ± 17%    +101.8%     849.75 ± 12%  interrupts.CPU150.TLB:TLB_shootdowns
    728.75 ± 11%     +62.5%       1184 ±  4%  interrupts.CPU151.RES:Rescheduling_interrupts
    433.75 ± 20%     +86.7%     810.00 ± 15%  interrupts.CPU151.TLB:TLB_shootdowns
    734.75           +64.9%       1211 ±  7%  interrupts.CPU152.RES:Rescheduling_interrupts
    459.25 ± 18%     +82.9%     839.75 ±  8%  interrupts.CPU152.TLB:TLB_shootdowns
    731.25 ±  5%     +65.5%       1210 ±  6%  interrupts.CPU153.RES:Rescheduling_interrupts
    461.75 ±  8%     +88.9%     872.25 ±  2%  interrupts.CPU153.TLB:TLB_shootdowns
    689.50 ± 11%     +68.3%       1160 ±  6%  interrupts.CPU154.RES:Rescheduling_interrupts
    486.50 ± 20%     +72.6%     839.50 ±  9%  interrupts.CPU154.TLB:TLB_shootdowns
    758.25 ±  5%     +53.2%       1161 ±  5%  interrupts.CPU155.RES:Rescheduling_interrupts
    463.25 ± 11%     +70.6%     790.25 ± 17%  interrupts.CPU155.TLB:TLB_shootdowns
    729.50 ±  4%     +60.1%       1168 ±  4%  interrupts.CPU156.RES:Rescheduling_interrupts
    447.50 ± 18%     +73.8%     777.75 ± 13%  interrupts.CPU156.TLB:TLB_shootdowns
    684.75           +68.9%       1156 ±  4%  interrupts.CPU157.RES:Rescheduling_interrupts
    454.75 ± 15%     +82.5%     830.00 ± 12%  interrupts.CPU157.TLB:TLB_shootdowns
      4435 ± 26%     -50.2%       2209 ± 21%  interrupts.CPU158.NMI:Non-maskable_interrupts
      4435 ± 26%     -50.2%       2209 ± 21%  interrupts.CPU158.PMI:Performance_monitoring_interrupts
    742.75 ±  7%     +61.7%       1201 ±  5%  interrupts.CPU158.RES:Rescheduling_interrupts
    429.75 ± 16%     +93.4%     831.25 ± 18%  interrupts.CPU158.TLB:TLB_shootdowns
    756.00 ±  7%     +55.0%       1171 ±  2%  interrupts.CPU159.RES:Rescheduling_interrupts
    417.50 ± 18%    +106.2%     861.00 ± 13%  interrupts.CPU159.TLB:TLB_shootdowns
    833.00 ±  3%     +28.6%       1071 ±  8%  interrupts.CPU16.RES:Rescheduling_interrupts
    444.25 ± 21%     +85.6%     824.50 ± 14%  interrupts.CPU16.TLB:TLB_shootdowns
      4999 ±  2%     -27.1%       3645 ± 12%  interrupts.CPU160.NMI:Non-maskable_interrupts
      4999 ±  2%     -27.1%       3645 ± 12%  interrupts.CPU160.PMI:Performance_monitoring_interrupts
    790.00 ± 13%     +45.4%       1148 ±  7%  interrupts.CPU160.RES:Rescheduling_interrupts
    484.25 ± 20%     +71.8%     831.75 ± 11%  interrupts.CPU160.TLB:TLB_shootdowns
    717.00 ±  2%     +62.1%       1162 ±  4%  interrupts.CPU161.RES:Rescheduling_interrupts
    426.00 ± 10%    +138.4%       1015 ± 41%  interrupts.CPU161.TLB:TLB_shootdowns
      5001 ±  3%     -35.7%       3218 ± 31%  interrupts.CPU162.NMI:Non-maskable_interrupts
      5001 ±  3%     -35.7%       3218 ± 31%  interrupts.CPU162.PMI:Performance_monitoring_interrupts
    751.75 ±  4%     +55.9%       1172 ±  6%  interrupts.CPU162.RES:Rescheduling_interrupts
    431.25 ± 10%     +86.3%     803.25 ± 14%  interrupts.CPU162.TLB:TLB_shootdowns
      3053 ± 12%     +17.5%       3587 ±  7%  interrupts.CPU163.CAL:Function_call_interrupts
      5034 ±  3%     -43.2%       2858 ± 44%  interrupts.CPU163.NMI:Non-maskable_interrupts
      5034 ±  3%     -43.2%       2858 ± 44%  interrupts.CPU163.PMI:Performance_monitoring_interrupts
    697.00 ±  4%     +76.0%       1226 ±  6%  interrupts.CPU163.RES:Rescheduling_interrupts
    398.25 ±  9%    +106.0%     820.50 ±  5%  interrupts.CPU163.TLB:TLB_shootdowns
    765.75 ± 13%     +57.0%       1202 ±  8%  interrupts.CPU164.RES:Rescheduling_interrupts
    446.75 ± 10%     +82.4%     815.00 ±  9%  interrupts.CPU164.TLB:TLB_shootdowns
    684.00 ±  5%     +76.1%       1204 ±  6%  interrupts.CPU165.RES:Rescheduling_interrupts
    433.00 ± 16%     +91.1%     827.50 ±  7%  interrupts.CPU165.TLB:TLB_shootdowns
    806.50 ±  7%     +43.6%       1158 ± 10%  interrupts.CPU166.RES:Rescheduling_interrupts
    441.00 ± 19%     +84.0%     811.25 ±  7%  interrupts.CPU166.TLB:TLB_shootdowns
    711.00 ±  9%     +61.5%       1148 ±  9%  interrupts.CPU167.RES:Rescheduling_interrupts
    437.00 ± 18%     +98.6%     867.75 ± 12%  interrupts.CPU167.TLB:TLB_shootdowns
      5042 ±  3%     -48.0%       2623 ± 24%  interrupts.CPU168.NMI:Non-maskable_interrupts
      5042 ±  3%     -48.0%       2623 ± 24%  interrupts.CPU168.PMI:Performance_monitoring_interrupts
    726.50 ± 10%     +48.7%       1080 ±  2%  interrupts.CPU168.RES:Rescheduling_interrupts
    405.00 ±  8%    +107.2%     839.00 ±  8%  interrupts.CPU168.TLB:TLB_shootdowns
      4998 ±  3%     -28.2%       3589 ± 13%  interrupts.CPU169.NMI:Non-maskable_interrupts
      4998 ±  3%     -28.2%       3589 ± 13%  interrupts.CPU169.PMI:Performance_monitoring_interrupts
    713.50 ±  8%     +51.1%       1078 ±  5%  interrupts.CPU169.RES:Rescheduling_interrupts
    445.00 ± 14%     +98.0%     881.00 ± 10%  interrupts.CPU169.TLB:TLB_shootdowns
    842.50 ±  3%     +26.1%       1062 ± 10%  interrupts.CPU17.RES:Rescheduling_interrupts
    430.00 ± 25%     +73.4%     745.75 ± 10%  interrupts.CPU17.TLB:TLB_shootdowns
      5098 ±  4%     -46.6%       2720 ± 36%  interrupts.CPU170.NMI:Non-maskable_interrupts
      5098 ±  4%     -46.6%       2720 ± 36%  interrupts.CPU170.PMI:Performance_monitoring_interrupts
    751.00 ±  9%     +45.4%       1092 ±  3%  interrupts.CPU170.RES:Rescheduling_interrupts
    479.00 ± 10%     +81.9%     871.50 ± 12%  interrupts.CPU170.TLB:TLB_shootdowns
    701.50 ±  6%     +46.1%       1025        interrupts.CPU171.RES:Rescheduling_interrupts
    431.25 ± 23%     +91.7%     826.75 ± 13%  interrupts.CPU171.TLB:TLB_shootdowns
      4996 ±  3%     -35.8%       3209 ± 32%  interrupts.CPU172.NMI:Non-maskable_interrupts
      4996 ±  3%     -35.8%       3209 ± 32%  interrupts.CPU172.PMI:Performance_monitoring_interrupts
    744.00 ±  6%     +46.3%       1088 ±  3%  interrupts.CPU172.RES:Rescheduling_interrupts
    471.25 ± 12%     +74.4%     822.00 ±  9%  interrupts.CPU172.TLB:TLB_shootdowns
    714.00 ±  6%     +50.1%       1071 ±  3%  interrupts.CPU173.RES:Rescheduling_interrupts
    460.25 ± 10%     +87.4%     862.50 ± 13%  interrupts.CPU173.TLB:TLB_shootdowns
    699.75 ±  8%     +48.8%       1041 ±  6%  interrupts.CPU174.RES:Rescheduling_interrupts
    508.00 ±  9%     +69.9%     863.00 ±  7%  interrupts.CPU174.TLB:TLB_shootdowns
    706.25 ± 12%     +50.7%       1064 ±  2%  interrupts.CPU175.RES:Rescheduling_interrupts
    443.00 ± 13%    +105.2%     909.00 ±  8%  interrupts.CPU175.TLB:TLB_shootdowns
    751.00 ± 12%     +44.8%       1087 ±  3%  interrupts.CPU176.RES:Rescheduling_interrupts
    497.00 ± 26%     +68.9%     839.50 ±  8%  interrupts.CPU176.TLB:TLB_shootdowns
      5077 ±  3%     -27.1%       3700 ± 12%  interrupts.CPU177.NMI:Non-maskable_interrupts
      5077 ±  3%     -27.1%       3700 ± 12%  interrupts.CPU177.PMI:Performance_monitoring_interrupts
    736.75 ±  7%     +45.8%       1074 ±  2%  interrupts.CPU177.RES:Rescheduling_interrupts
    456.00 ± 16%     +94.7%     887.75 ±  5%  interrupts.CPU177.TLB:TLB_shootdowns
    741.50 ± 15%     +48.9%       1104 ±  4%  interrupts.CPU178.RES:Rescheduling_interrupts
    438.00 ± 14%     +90.6%     835.00 ± 13%  interrupts.CPU178.TLB:TLB_shootdowns
    786.50 ±  8%     +37.5%       1081 ±  2%  interrupts.CPU179.RES:Rescheduling_interrupts
    460.25 ± 11%     +78.8%     823.00 ± 10%  interrupts.CPU179.TLB:TLB_shootdowns
    842.00 ±  5%     +27.0%       1069 ±  5%  interrupts.CPU18.RES:Rescheduling_interrupts
    437.50 ±  8%     +79.2%     784.00 ±  8%  interrupts.CPU18.TLB:TLB_shootdowns
    729.50 ±  4%     +41.4%       1031 ±  5%  interrupts.CPU180.RES:Rescheduling_interrupts
    527.00 ± 19%     +54.6%     814.75 ± 13%  interrupts.CPU180.TLB:TLB_shootdowns
    712.50 ±  9%     +53.5%       1094 ±  4%  interrupts.CPU181.RES:Rescheduling_interrupts
    479.25 ± 15%     +85.8%     890.25 ±  5%  interrupts.CPU181.TLB:TLB_shootdowns
    715.25 ±  5%     +54.3%       1103 ±  4%  interrupts.CPU182.RES:Rescheduling_interrupts
    417.50 ± 21%    +101.3%     840.25 ±  6%  interrupts.CPU182.TLB:TLB_shootdowns
      5085 ±  3%     -28.3%       3647 ± 14%  interrupts.CPU183.NMI:Non-maskable_interrupts
      5085 ±  3%     -28.3%       3647 ± 14%  interrupts.CPU183.PMI:Performance_monitoring_interrupts
    728.25 ±  5%     +47.3%       1072 ±  3%  interrupts.CPU183.RES:Rescheduling_interrupts
    519.75 ± 17%     +52.4%     792.00 ±  3%  interrupts.CPU183.TLB:TLB_shootdowns
    751.00 ±  3%     +42.9%       1073 ±  4%  interrupts.CPU184.RES:Rescheduling_interrupts
    488.75 ±  9%     +66.5%     814.00 ± 15%  interrupts.CPU184.TLB:TLB_shootdowns
    725.50 ±  9%     +54.7%       1122        interrupts.CPU185.RES:Rescheduling_interrupts
    449.00 ±  9%     +83.6%     824.25 ± 10%  interrupts.CPU185.TLB:TLB_shootdowns
    727.75 ± 10%     +46.1%       1063 ±  4%  interrupts.CPU186.RES:Rescheduling_interrupts
    453.75 ± 19%     +75.3%     795.50 ± 18%  interrupts.CPU186.TLB:TLB_shootdowns
    680.75 ±  8%     +61.3%       1098 ±  5%  interrupts.CPU187.RES:Rescheduling_interrupts
    378.00 ± 11%    +136.9%     895.50 ± 11%  interrupts.CPU187.TLB:TLB_shootdowns
      4988 ±  3%     -25.4%       3719 ± 13%  interrupts.CPU188.NMI:Non-maskable_interrupts
      4988 ±  3%     -25.4%       3719 ± 13%  interrupts.CPU188.PMI:Performance_monitoring_interrupts
    741.75 ±  5%     +46.5%       1086 ±  3%  interrupts.CPU188.RES:Rescheduling_interrupts
    455.50 ± 21%     +97.0%     897.25 ± 20%  interrupts.CPU188.TLB:TLB_shootdowns
    683.50 ± 10%     +58.6%       1084 ±  5%  interrupts.CPU189.RES:Rescheduling_interrupts
    469.25 ± 15%     +86.0%     872.75 ±  9%  interrupts.CPU189.TLB:TLB_shootdowns
    868.25 ±  5%     +28.4%       1115 ±  6%  interrupts.CPU19.RES:Rescheduling_interrupts
    395.00 ± 32%    +102.8%     801.25 ± 17%  interrupts.CPU19.TLB:TLB_shootdowns
    694.00 ±  3%     +58.5%       1099 ±  3%  interrupts.CPU190.RES:Rescheduling_interrupts
    445.00 ± 14%     +88.1%     837.00 ± 14%  interrupts.CPU190.TLB:TLB_shootdowns
    713.25 ± 10%     +53.0%       1091 ±  4%  interrupts.CPU191.RES:Rescheduling_interrupts
    434.25 ± 17%     +94.3%     843.75 ± 11%  interrupts.CPU191.TLB:TLB_shootdowns
      5058 ±  5%     -38.1%       3131 ± 20%  interrupts.CPU2.NMI:Non-maskable_interrupts
      5058 ±  5%     -38.1%       3131 ± 20%  interrupts.CPU2.PMI:Performance_monitoring_interrupts
    877.00 ±  5%     +24.1%       1088        interrupts.CPU2.RES:Rescheduling_interrupts
    796.25 ±  5%     +38.6%       1103 ±  5%  interrupts.CPU20.RES:Rescheduling_interrupts
    477.25 ± 24%     +72.4%     823.00 ±  8%  interrupts.CPU20.TLB:TLB_shootdowns
      5019 ±  2%     -26.2%       3705 ±  9%  interrupts.CPU21.NMI:Non-maskable_interrupts
      5019 ±  2%     -26.2%       3705 ±  9%  interrupts.CPU21.PMI:Performance_monitoring_interrupts
    895.00 ±  3%     +20.4%       1077 ±  6%  interrupts.CPU21.RES:Rescheduling_interrupts
    447.25 ± 17%     +90.4%     851.50 ±  9%  interrupts.CPU21.TLB:TLB_shootdowns
    839.00 ±  4%     +26.6%       1062 ±  6%  interrupts.CPU22.RES:Rescheduling_interrupts
    423.25 ± 18%     +98.1%     838.50 ± 11%  interrupts.CPU22.TLB:TLB_shootdowns
    804.00 ±  3%     +32.6%       1065 ±  4%  interrupts.CPU23.RES:Rescheduling_interrupts
    418.25 ± 21%     +98.7%     831.00 ± 10%  interrupts.CPU23.TLB:TLB_shootdowns
    888.25 ±  5%     +25.8%       1117 ±  2%  interrupts.CPU24.RES:Rescheduling_interrupts
    606.00 ± 26%     +35.8%     822.75 ± 12%  interrupts.CPU24.TLB:TLB_shootdowns
      5054 ±  4%     -26.5%       3716 ±  9%  interrupts.CPU25.NMI:Non-maskable_interrupts
      5054 ±  4%     -26.5%       3716 ±  9%  interrupts.CPU25.PMI:Performance_monitoring_interrupts
    898.50 ±  5%     +22.3%       1099 ±  8%  interrupts.CPU25.RES:Rescheduling_interrupts
      5064 ±  5%     -36.1%       3238 ± 28%  interrupts.CPU26.NMI:Non-maskable_interrupts
      5064 ±  5%     -36.1%       3238 ± 28%  interrupts.CPU26.PMI:Performance_monitoring_interrupts
    856.50 ±  2%     +30.9%       1121 ±  8%  interrupts.CPU26.RES:Rescheduling_interrupts
    482.00 ±  3%     +86.3%     898.00 ± 10%  interrupts.CPU26.TLB:TLB_shootdowns
    800.25 ±  3%     +41.4%       1131 ± 13%  interrupts.CPU27.RES:Rescheduling_interrupts
    446.50 ± 10%     +78.7%     797.75 ± 16%  interrupts.CPU27.TLB:TLB_shootdowns
    800.75 ±  2%     +31.1%       1050 ±  8%  interrupts.CPU28.RES:Rescheduling_interrupts
    441.75 ±  6%    +120.5%     974.00 ± 32%  interrupts.CPU28.TLB:TLB_shootdowns
      5020 ±  4%     -35.1%       3258 ± 29%  interrupts.CPU29.NMI:Non-maskable_interrupts
      5020 ±  4%     -35.1%       3258 ± 29%  interrupts.CPU29.PMI:Performance_monitoring_interrupts
    863.25 ±  6%     +25.5%       1083 ±  6%  interrupts.CPU29.RES:Rescheduling_interrupts
    517.50 ± 17%     +66.9%     863.50 ± 10%  interrupts.CPU29.TLB:TLB_shootdowns
    858.50 ±  2%     +27.8%       1097 ±  4%  interrupts.CPU3.RES:Rescheduling_interrupts
    460.50 ± 15%     +64.0%     755.00 ±  9%  interrupts.CPU3.TLB:TLB_shootdowns
    815.50 ±  5%     +38.7%       1131 ±  9%  interrupts.CPU30.RES:Rescheduling_interrupts
    419.50 ± 10%    +105.2%     860.75 ±  6%  interrupts.CPU30.TLB:TLB_shootdowns
    792.25 ±  3%     +41.1%       1118 ±  6%  interrupts.CPU31.RES:Rescheduling_interrupts
    515.00 ± 12%     +78.1%     917.00 ±  7%  interrupts.CPU31.TLB:TLB_shootdowns
      5009 ±  5%     -34.7%       3268 ± 29%  interrupts.CPU32.NMI:Non-maskable_interrupts
      5009 ±  5%     -34.7%       3268 ± 29%  interrupts.CPU32.PMI:Performance_monitoring_interrupts
    805.75 ±  2%     +38.8%       1118 ±  4%  interrupts.CPU32.RES:Rescheduling_interrupts
    457.25 ± 11%     +93.2%     883.25 ±  4%  interrupts.CPU32.TLB:TLB_shootdowns
      4965 ±  5%     -33.7%       3290 ± 29%  interrupts.CPU33.NMI:Non-maskable_interrupts
      4965 ±  5%     -33.7%       3290 ± 29%  interrupts.CPU33.PMI:Performance_monitoring_interrupts
    846.75 ±  2%     +29.8%       1099 ±  7%  interrupts.CPU33.RES:Rescheduling_interrupts
    493.75 ± 20%     +66.9%     824.00 ± 10%  interrupts.CPU33.TLB:TLB_shootdowns
    805.25 ±  4%     +42.7%       1149 ±  8%  interrupts.CPU34.RES:Rescheduling_interrupts
    443.25 ± 10%     +81.8%     806.00 ± 12%  interrupts.CPU34.TLB:TLB_shootdowns
      5024 ±  5%     -26.9%       3671 ±  8%  interrupts.CPU35.NMI:Non-maskable_interrupts
      5024 ±  5%     -26.9%       3671 ±  8%  interrupts.CPU35.PMI:Performance_monitoring_interrupts
    834.00 ±  6%     +31.9%       1100 ± 11%  interrupts.CPU35.RES:Rescheduling_interrupts
    405.50 ± 19%    +115.4%     873.25 ±  6%  interrupts.CPU35.TLB:TLB_shootdowns
      5074 ±  4%     -26.8%       3713 ±  9%  interrupts.CPU36.NMI:Non-maskable_interrupts
      5074 ±  4%     -26.8%       3713 ±  9%  interrupts.CPU36.PMI:Performance_monitoring_interrupts
    786.50 ±  7%     +35.5%       1066 ±  7%  interrupts.CPU36.RES:Rescheduling_interrupts
    483.75 ± 16%     +74.7%     845.25 ±  5%  interrupts.CPU36.TLB:TLB_shootdowns
      5021 ±  3%     -35.1%       3261 ± 29%  interrupts.CPU37.NMI:Non-maskable_interrupts
      5021 ±  3%     -35.1%       3261 ± 29%  interrupts.CPU37.PMI:Performance_monitoring_interrupts
    895.50 ±  2%     +25.2%       1121 ±  8%  interrupts.CPU37.RES:Rescheduling_interrupts
    470.50 ±  7%     +70.5%     802.00 ± 18%  interrupts.CPU37.TLB:TLB_shootdowns
      5011 ±  5%     -25.5%       3734 ±  9%  interrupts.CPU38.NMI:Non-maskable_interrupts
      5011 ±  5%     -25.5%       3734 ±  9%  interrupts.CPU38.PMI:Performance_monitoring_interrupts
    841.00 ±  5%     +33.0%       1118 ±  9%  interrupts.CPU38.RES:Rescheduling_interrupts
    402.75 ± 17%    +101.3%     810.75 ±  5%  interrupts.CPU38.TLB:TLB_shootdowns
      5064 ±  5%     -27.4%       3677 ± 10%  interrupts.CPU39.NMI:Non-maskable_interrupts
      5064 ±  5%     -27.4%       3677 ± 10%  interrupts.CPU39.PMI:Performance_monitoring_interrupts
    790.50 ±  7%     +37.9%       1089 ±  8%  interrupts.CPU39.RES:Rescheduling_interrupts
    492.75 ± 16%     +63.7%     806.75 ± 12%  interrupts.CPU39.TLB:TLB_shootdowns
    454.75 ± 13%     +97.4%     897.50 ± 12%  interrupts.CPU4.TLB:TLB_shootdowns
      5053 ±  5%     -34.5%       3310 ± 30%  interrupts.CPU40.NMI:Non-maskable_interrupts
      5053 ±  5%     -34.5%       3310 ± 30%  interrupts.CPU40.PMI:Performance_monitoring_interrupts
    814.75 ±  6%     +30.9%       1066 ±  5%  interrupts.CPU40.RES:Rescheduling_interrupts
    430.50 ± 16%     +95.1%     840.00 ± 13%  interrupts.CPU40.TLB:TLB_shootdowns
      5073 ±  4%     -36.6%       3218 ± 28%  interrupts.CPU41.NMI:Non-maskable_interrupts
      5073 ±  4%     -36.6%       3218 ± 28%  interrupts.CPU41.PMI:Performance_monitoring_interrupts
    807.75 ±  4%     +36.1%       1099 ±  8%  interrupts.CPU41.RES:Rescheduling_interrupts
    477.00 ± 12%     +60.6%     766.25 ± 10%  interrupts.CPU41.TLB:TLB_shootdowns
      5042 ±  4%     -27.2%       3672 ± 10%  interrupts.CPU42.NMI:Non-maskable_interrupts
      5042 ±  4%     -27.2%       3672 ± 10%  interrupts.CPU42.PMI:Performance_monitoring_interrupts
    844.75 ±  5%     +32.4%       1118 ±  7%  interrupts.CPU42.RES:Rescheduling_interrupts
    466.50 ±  9%     +74.7%     814.75 ± 14%  interrupts.CPU42.TLB:TLB_shootdowns
      4997 ±  5%     -34.8%       3258 ± 28%  interrupts.CPU43.NMI:Non-maskable_interrupts
      4997 ±  5%     -34.8%       3258 ± 28%  interrupts.CPU43.PMI:Performance_monitoring_interrupts
    851.50 ±  4%     +31.1%       1116 ±  9%  interrupts.CPU43.RES:Rescheduling_interrupts
    472.25 ± 12%     +76.8%     835.00 ±  5%  interrupts.CPU43.TLB:TLB_shootdowns
      5072 ±  4%     -26.2%       3740 ± 11%  interrupts.CPU44.NMI:Non-maskable_interrupts
      5072 ±  4%     -26.2%       3740 ± 11%  interrupts.CPU44.PMI:Performance_monitoring_interrupts
    825.50 ±  4%     +33.1%       1098 ± 10%  interrupts.CPU44.RES:Rescheduling_interrupts
    436.50 ± 14%     +81.4%     791.75 ±  8%  interrupts.CPU44.TLB:TLB_shootdowns
      4973 ±  3%     -25.6%       3700 ±  9%  interrupts.CPU45.NMI:Non-maskable_interrupts
      4973 ±  3%     -25.6%       3700 ±  9%  interrupts.CPU45.PMI:Performance_monitoring_interrupts
    853.00 ±  4%     +26.9%       1082 ± 10%  interrupts.CPU45.RES:Rescheduling_interrupts
    439.50 ± 10%     +98.5%     872.50 ±  3%  interrupts.CPU45.TLB:TLB_shootdowns
      5060 ±  5%     -46.8%       2693 ± 26%  interrupts.CPU46.NMI:Non-maskable_interrupts
      5060 ±  5%     -46.8%       2693 ± 26%  interrupts.CPU46.PMI:Performance_monitoring_interrupts
    828.25 ±  2%     +29.5%       1072 ± 11%  interrupts.CPU46.RES:Rescheduling_interrupts
    421.75 ± 12%     +92.2%     810.75 ± 10%  interrupts.CPU46.TLB:TLB_shootdowns
      5035 ±  5%     -26.5%       3701 ±  8%  interrupts.CPU47.NMI:Non-maskable_interrupts
      5035 ±  5%     -26.5%       3701 ±  8%  interrupts.CPU47.PMI:Performance_monitoring_interrupts
    866.25 ±  6%     +28.5%       1113 ±  6%  interrupts.CPU47.RES:Rescheduling_interrupts
    459.25 ± 16%     +81.3%     832.50 ±  9%  interrupts.CPU47.TLB:TLB_shootdowns
      5021 ±  4%     -25.6%       3737 ±  9%  interrupts.CPU48.NMI:Non-maskable_interrupts
      5021 ±  4%     -25.6%       3737 ±  9%  interrupts.CPU48.PMI:Performance_monitoring_interrupts
    660.75 ± 11%     +42.8%     943.75 ±  7%  interrupts.CPU48.TLB:TLB_shootdowns
      5043 ±  3%     -36.3%       3214 ± 20%  interrupts.CPU49.NMI:Non-maskable_interrupts
      5043 ±  3%     -36.3%       3214 ± 20%  interrupts.CPU49.PMI:Performance_monitoring_interrupts
    854.25 ±  2%     +36.2%       1163 ± 10%  interrupts.CPU49.RES:Rescheduling_interrupts
    486.00 ± 10%     +74.5%     848.00 ± 15%  interrupts.CPU49.TLB:TLB_shootdowns
    831.25 ±  4%     +26.2%       1048 ±  4%  interrupts.CPU5.RES:Rescheduling_interrupts
    502.75 ± 17%     +58.9%     799.00 ± 13%  interrupts.CPU5.TLB:TLB_shootdowns
    833.25 ±  7%     +42.2%       1185 ±  7%  interrupts.CPU50.RES:Rescheduling_interrupts
    532.50 ± 13%     +78.3%     949.25 ± 13%  interrupts.CPU50.TLB:TLB_shootdowns
      4983 ±  2%     -25.5%       3710 ±  9%  interrupts.CPU51.NMI:Non-maskable_interrupts
      4983 ±  2%     -25.5%       3710 ±  9%  interrupts.CPU51.PMI:Performance_monitoring_interrupts
    881.00 ±  5%     +25.2%       1102 ±  5%  interrupts.CPU51.RES:Rescheduling_interrupts
    505.00 ± 10%     +78.6%     902.00 ± 11%  interrupts.CPU51.TLB:TLB_shootdowns
      5016 ±  3%     -27.0%       3662 ±  9%  interrupts.CPU52.NMI:Non-maskable_interrupts
      5016 ±  3%     -27.0%       3662 ±  9%  interrupts.CPU52.PMI:Performance_monitoring_interrupts
    791.50 ±  2%     +54.0%       1218 ± 14%  interrupts.CPU52.RES:Rescheduling_interrupts
    545.75 ± 16%     +52.2%     830.50 ± 12%  interrupts.CPU52.TLB:TLB_shootdowns
    886.50 ±  4%     +35.8%       1203 ±  6%  interrupts.CPU53.RES:Rescheduling_interrupts
    456.25 ± 19%     +91.8%     875.25 ±  8%  interrupts.CPU53.TLB:TLB_shootdowns
      5016 ±  3%     -27.0%       3660 ±  9%  interrupts.CPU54.NMI:Non-maskable_interrupts
      5016 ±  3%     -27.0%       3660 ±  9%  interrupts.CPU54.PMI:Performance_monitoring_interrupts
    796.25 ±  4%     +41.9%       1130 ±  8%  interrupts.CPU54.RES:Rescheduling_interrupts
    432.00 ±  7%     +94.1%     838.50 ±  7%  interrupts.CPU54.TLB:TLB_shootdowns
      5065 ±  4%     -26.7%       3715 ± 10%  interrupts.CPU55.NMI:Non-maskable_interrupts
      5065 ±  4%     -26.7%       3715 ± 10%  interrupts.CPU55.PMI:Performance_monitoring_interrupts
    857.75           +32.6%       1137 ±  9%  interrupts.CPU55.RES:Rescheduling_interrupts
    502.00 ± 11%     +70.7%     857.00 ± 18%  interrupts.CPU55.TLB:TLB_shootdowns
      4955 ±  5%     -45.9%       2681 ± 23%  interrupts.CPU56.NMI:Non-maskable_interrupts
      4955 ±  5%     -45.9%       2681 ± 23%  interrupts.CPU56.PMI:Performance_monitoring_interrupts
    819.25 ±  3%     +41.0%       1154 ±  8%  interrupts.CPU56.RES:Rescheduling_interrupts
    498.50 ±  9%     +70.5%     849.75 ±  8%  interrupts.CPU56.TLB:TLB_shootdowns
    847.50 ±  6%     +36.3%       1154 ±  6%  interrupts.CPU57.RES:Rescheduling_interrupts
    417.25 ± 18%    +104.0%     851.25 ±  9%  interrupts.CPU57.TLB:TLB_shootdowns
    836.00 ±  4%     +35.7%       1134 ±  6%  interrupts.CPU58.RES:Rescheduling_interrupts
    451.75 ± 18%     +85.1%     836.25 ±  9%  interrupts.CPU58.TLB:TLB_shootdowns
    837.50 ±  7%     +34.7%       1127 ±  8%  interrupts.CPU59.RES:Rescheduling_interrupts
    433.75 ± 23%     +93.6%     839.75 ± 17%  interrupts.CPU59.TLB:TLB_shootdowns
    884.00 ±  5%     +24.3%       1098 ±  6%  interrupts.CPU6.RES:Rescheduling_interrupts
    454.50 ± 12%     +80.4%     820.00 ±  8%  interrupts.CPU6.TLB:TLB_shootdowns
      4902 ±  3%     -24.7%       3694 ± 11%  interrupts.CPU60.NMI:Non-maskable_interrupts
      4902 ±  3%     -24.7%       3694 ± 11%  interrupts.CPU60.PMI:Performance_monitoring_interrupts
    775.25 ±  7%     +48.3%       1150 ± 12%  interrupts.CPU60.RES:Rescheduling_interrupts
    431.75 ± 17%    +101.2%     868.75 ± 21%  interrupts.CPU60.TLB:TLB_shootdowns
      5030 ±  3%     -26.4%       3702 ± 11%  interrupts.CPU61.NMI:Non-maskable_interrupts
      5030 ±  3%     -26.4%       3702 ± 11%  interrupts.CPU61.PMI:Performance_monitoring_interrupts
    833.50 ±  2%     +37.6%       1146 ±  7%  interrupts.CPU61.RES:Rescheduling_interrupts
    429.50 ± 18%     +85.0%     794.50 ± 12%  interrupts.CPU61.TLB:TLB_shootdowns
      5003 ±  3%     -27.5%       3625 ±  9%  interrupts.CPU62.NMI:Non-maskable_interrupts
      5003 ±  3%     -27.5%       3625 ±  9%  interrupts.CPU62.PMI:Performance_monitoring_interrupts
    854.75 ±  3%     +38.6%       1185 ±  5%  interrupts.CPU62.RES:Rescheduling_interrupts
    422.50 ±  7%    +100.1%     845.50        interrupts.CPU62.TLB:TLB_shootdowns
    852.25 ±  8%     +40.7%       1199 ±  5%  interrupts.CPU63.RES:Rescheduling_interrupts
    431.75 ± 16%     +72.6%     745.25 ± 16%  interrupts.CPU63.TLB:TLB_shootdowns
    851.25 ± 10%     +35.3%       1151 ±  7%  interrupts.CPU64.RES:Rescheduling_interrupts
    487.75 ± 18%     +73.9%     848.00 ±  7%  interrupts.CPU64.TLB:TLB_shootdowns
      5028 ±  2%     -38.4%       3096 ± 26%  interrupts.CPU65.NMI:Non-maskable_interrupts
      5028 ±  2%     -38.4%       3096 ± 26%  interrupts.CPU65.PMI:Performance_monitoring_interrupts
    838.25 ±  6%     +37.3%       1151 ±  9%  interrupts.CPU65.RES:Rescheduling_interrupts
    443.75 ± 15%    +101.4%     893.75 ± 13%  interrupts.CPU65.TLB:TLB_shootdowns
    872.00 ±  8%     +33.3%       1162 ±  8%  interrupts.CPU66.RES:Rescheduling_interrupts
    475.75 ± 14%     +72.1%     818.75 ± 13%  interrupts.CPU66.TLB:TLB_shootdowns
      3050 ± 10%     +16.9%       3567 ±  4%  interrupts.CPU67.CAL:Function_call_interrupts
    802.00 ±  5%     +50.8%       1209 ±  8%  interrupts.CPU67.RES:Rescheduling_interrupts
    442.50 ± 24%    +100.3%     886.50 ± 13%  interrupts.CPU67.TLB:TLB_shootdowns
      4987 ±  6%     -27.1%       3637 ± 10%  interrupts.CPU68.NMI:Non-maskable_interrupts
      4987 ±  6%     -27.1%       3637 ± 10%  interrupts.CPU68.PMI:Performance_monitoring_interrupts
    903.25 ± 10%     +28.1%       1157 ±  9%  interrupts.CPU68.RES:Rescheduling_interrupts
    454.75 ± 18%     +92.5%     875.25 ± 15%  interrupts.CPU68.TLB:TLB_shootdowns
    844.00 ±  3%     +34.6%       1136 ±  8%  interrupts.CPU69.RES:Rescheduling_interrupts
    469.50 ±  9%     +91.6%     899.50 ± 18%  interrupts.CPU69.TLB:TLB_shootdowns
    870.50 ±  3%     +29.1%       1123        interrupts.CPU7.RES:Rescheduling_interrupts
    401.00 ± 26%     +97.8%     793.25 ±  5%  interrupts.CPU7.TLB:TLB_shootdowns
    871.25 ± 16%     +27.6%       1111 ±  8%  interrupts.CPU70.RES:Rescheduling_interrupts
    473.00 ± 13%     +84.0%     870.50 ± 10%  interrupts.CPU70.TLB:TLB_shootdowns
    869.25 ±  5%     +29.4%       1125 ± 13%  interrupts.CPU71.RES:Rescheduling_interrupts
    487.50 ± 22%     +79.8%     876.50 ±  6%  interrupts.CPU71.TLB:TLB_shootdowns
      5060 ±  3%     -28.1%       3638 ± 11%  interrupts.CPU72.NMI:Non-maskable_interrupts
      5060 ±  3%     -28.1%       3638 ± 11%  interrupts.CPU72.PMI:Performance_monitoring_interrupts
    894.50 ±  8%     +15.6%       1034 ±  2%  interrupts.CPU72.RES:Rescheduling_interrupts
      2955 ± 11%     +19.5%       3532 ±  4%  interrupts.CPU73.CAL:Function_call_interrupts
      5028 ±  4%     -29.0%       3571 ± 10%  interrupts.CPU73.NMI:Non-maskable_interrupts
      5028 ±  4%     -29.0%       3571 ± 10%  interrupts.CPU73.PMI:Performance_monitoring_interrupts
    845.25           +26.5%       1069 ±  3%  interrupts.CPU73.RES:Rescheduling_interrupts
    563.75 ± 12%     +64.9%     929.75 ±  3%  interrupts.CPU73.TLB:TLB_shootdowns
      5040 ±  2%     -28.4%       3606 ± 11%  interrupts.CPU74.NMI:Non-maskable_interrupts
      5040 ±  2%     -28.4%       3606 ± 11%  interrupts.CPU74.PMI:Performance_monitoring_interrupts
    849.50 ±  6%     +26.8%       1077 ±  2%  interrupts.CPU74.RES:Rescheduling_interrupts
    556.75 ± 10%     +51.2%     841.75 ±  7%  interrupts.CPU74.TLB:TLB_shootdowns
      5034 ±  3%     -46.6%       2689 ± 37%  interrupts.CPU75.NMI:Non-maskable_interrupts
      5034 ±  3%     -46.6%       2689 ± 37%  interrupts.CPU75.PMI:Performance_monitoring_interrupts
    851.75 ±  8%     +21.3%       1033 ±  3%  interrupts.CPU75.RES:Rescheduling_interrupts
    488.50 ± 17%     +89.3%     924.50 ± 11%  interrupts.CPU75.TLB:TLB_shootdowns
    850.25 ±  6%     +25.7%       1068 ±  2%  interrupts.CPU76.RES:Rescheduling_interrupts
    472.50 ± 11%    +100.4%     946.75 ±  9%  interrupts.CPU76.TLB:TLB_shootdowns
    823.00 ±  2%     +26.4%       1040 ±  4%  interrupts.CPU77.RES:Rescheduling_interrupts
    532.50 ± 13%     +65.1%     879.00 ±  9%  interrupts.CPU77.TLB:TLB_shootdowns
    834.25 ±  6%     +26.1%       1052 ±  2%  interrupts.CPU78.RES:Rescheduling_interrupts
    485.00 ± 18%     +68.5%     817.25 ±  7%  interrupts.CPU78.TLB:TLB_shootdowns
      5049 ±  3%     -28.4%       3614 ± 11%  interrupts.CPU79.NMI:Non-maskable_interrupts
      5049 ±  3%     -28.4%       3614 ± 11%  interrupts.CPU79.PMI:Performance_monitoring_interrupts
    836.25 ±  3%     +30.4%       1090 ±  3%  interrupts.CPU79.RES:Rescheduling_interrupts
    483.25 ± 27%     +67.7%     810.50 ±  5%  interrupts.CPU79.TLB:TLB_shootdowns
    869.50 ±  5%     +26.5%       1100 ±  7%  interrupts.CPU8.RES:Rescheduling_interrupts
    395.75 ± 19%    +105.4%     813.00 ± 11%  interrupts.CPU8.TLB:TLB_shootdowns
    821.25 ±  2%     +28.5%       1055 ±  3%  interrupts.CPU80.RES:Rescheduling_interrupts
    478.00 ± 25%     +82.0%     870.00 ±  7%  interrupts.CPU80.TLB:TLB_shootdowns
    838.25 ±  2%     +24.0%       1039 ±  2%  interrupts.CPU81.RES:Rescheduling_interrupts
    474.50 ± 14%     +85.6%     880.50 ± 14%  interrupts.CPU81.TLB:TLB_shootdowns
      5068 ±  4%     -29.8%       3555 ± 11%  interrupts.CPU82.NMI:Non-maskable_interrupts
      5068 ±  4%     -29.8%       3555 ± 11%  interrupts.CPU82.PMI:Performance_monitoring_interrupts
    468.75 ± 16%     +88.2%     882.25 ±  9%  interrupts.CPU82.TLB:TLB_shootdowns
    848.00 ±  4%     +28.4%       1089 ±  3%  interrupts.CPU83.RES:Rescheduling_interrupts
    392.00 ±  8%    +106.2%     808.50 ±  9%  interrupts.CPU83.TLB:TLB_shootdowns
    859.50 ± 11%     +26.0%       1083 ±  3%  interrupts.CPU84.RES:Rescheduling_interrupts
    452.25 ±  7%     +92.3%     869.50 ±  8%  interrupts.CPU84.TLB:TLB_shootdowns
    831.25 ±  5%     +28.9%       1071 ±  5%  interrupts.CPU85.RES:Rescheduling_interrupts
    498.25 ±  9%     +76.1%     877.25 ±  6%  interrupts.CPU85.TLB:TLB_shootdowns
    842.00 ± 10%     +30.9%       1102 ±  3%  interrupts.CPU86.RES:Rescheduling_interrupts
    449.50 ±  9%    +104.9%     921.25 ± 10%  interrupts.CPU86.TLB:TLB_shootdowns
    799.00 ±  6%     +27.9%       1021        interrupts.CPU87.RES:Rescheduling_interrupts
    461.50 ± 13%     +78.4%     823.50 ±  6%  interrupts.CPU87.TLB:TLB_shootdowns
    751.75 ±  4%     +42.4%       1070 ±  3%  interrupts.CPU88.RES:Rescheduling_interrupts
    448.75 ± 12%     +92.9%     865.50 ± 10%  interrupts.CPU88.TLB:TLB_shootdowns
    795.25 ±  5%     +34.2%       1067 ±  2%  interrupts.CPU89.RES:Rescheduling_interrupts
    461.00 ± 11%     +90.6%     878.75 ± 18%  interrupts.CPU89.TLB:TLB_shootdowns
    841.75 ±  5%     +33.7%       1125 ±  7%  interrupts.CPU9.RES:Rescheduling_interrupts
    415.75 ± 15%     +94.8%     809.75 ± 14%  interrupts.CPU9.TLB:TLB_shootdowns
    855.50 ±  4%     +24.8%       1067 ±  2%  interrupts.CPU90.RES:Rescheduling_interrupts
    470.50 ± 11%    +112.9%       1001 ± 29%  interrupts.CPU90.TLB:TLB_shootdowns
      5026 ±  3%     -27.7%       3633 ± 10%  interrupts.CPU91.NMI:Non-maskable_interrupts
      5026 ±  3%     -27.7%       3633 ± 10%  interrupts.CPU91.PMI:Performance_monitoring_interrupts
    783.25 ±  4%     +35.4%       1060 ±  3%  interrupts.CPU91.RES:Rescheduling_interrupts
    468.50 ± 11%     +86.0%     871.50 ±  3%  interrupts.CPU91.TLB:TLB_shootdowns
      5024 ±  3%     -29.6%       3535 ± 12%  interrupts.CPU92.NMI:Non-maskable_interrupts
      5024 ±  3%     -29.6%       3535 ± 12%  interrupts.CPU92.PMI:Performance_monitoring_interrupts
    897.50 ±  6%     +19.3%       1071 ±  2%  interrupts.CPU92.RES:Rescheduling_interrupts
    489.25 ± 26%     +83.8%     899.25 ±  9%  interrupts.CPU92.TLB:TLB_shootdowns
      5026 ±  4%     -26.7%       3685 ± 10%  interrupts.CPU93.NMI:Non-maskable_interrupts
      5026 ±  4%     -26.7%       3685 ± 10%  interrupts.CPU93.PMI:Performance_monitoring_interrupts
    854.00 ±  9%     +26.5%       1080        interrupts.CPU93.RES:Rescheduling_interrupts
    454.00 ±  8%     +76.4%     800.75 ±  7%  interrupts.CPU93.TLB:TLB_shootdowns
      5046 ±  4%     -29.3%       3566 ± 12%  interrupts.CPU94.NMI:Non-maskable_interrupts
      5046 ±  4%     -29.3%       3566 ± 12%  interrupts.CPU94.PMI:Performance_monitoring_interrupts
    779.00 ±  3%     +41.8%       1104 ±  3%  interrupts.CPU94.RES:Rescheduling_interrupts
    438.50 ± 16%    +100.3%     878.50 ±  6%  interrupts.CPU94.TLB:TLB_shootdowns
      5049 ±  3%     -38.2%       3123 ± 25%  interrupts.CPU95.NMI:Non-maskable_interrupts
      5049 ±  3%     -38.2%       3123 ± 25%  interrupts.CPU95.PMI:Performance_monitoring_interrupts
    763.00 ± 12%     +38.7%       1058 ±  3%  interrupts.CPU95.RES:Rescheduling_interrupts
    424.50 ± 17%    +103.4%     863.50 ±  8%  interrupts.CPU95.TLB:TLB_shootdowns
    864.50 ±  7%     +31.5%       1136 ±  5%  interrupts.CPU96.RES:Rescheduling_interrupts
    468.50 ± 13%     +62.4%     761.00 ± 16%  interrupts.CPU96.TLB:TLB_shootdowns
      5044 ±  4%     -28.4%       3614 ± 13%  interrupts.CPU97.NMI:Non-maskable_interrupts
      5044 ±  4%     -28.4%       3614 ± 13%  interrupts.CPU97.PMI:Performance_monitoring_interrupts
    819.00 ±  3%     +35.0%       1106 ±  6%  interrupts.CPU97.RES:Rescheduling_interrupts
    425.00 ± 12%     +95.1%     829.25 ± 11%  interrupts.CPU97.TLB:TLB_shootdowns
    847.25 ±  4%     +34.7%       1141 ±  3%  interrupts.CPU98.RES:Rescheduling_interrupts
    416.50 ± 17%    +102.4%     843.00 ± 11%  interrupts.CPU98.TLB:TLB_shootdowns
      5039 ±  3%     -38.1%       3119 ± 26%  interrupts.CPU99.NMI:Non-maskable_interrupts
      5039 ±  3%     -38.1%       3119 ± 26%  interrupts.CPU99.PMI:Performance_monitoring_interrupts
    808.50 ±  7%     +35.3%       1093 ± 11%  interrupts.CPU99.RES:Rescheduling_interrupts
    423.25 ± 16%     +77.3%     750.25 ± 13%  interrupts.CPU99.TLB:TLB_shootdowns
    871481 ±  7%     -24.9%     654746 ± 13%  interrupts.NMI:Non-maskable_interrupts
    871481 ±  7%     -24.9%     654746 ± 13%  interrupts.PMI:Performance_monitoring_interrupts
    152797           +40.0%     213848 ±  2%  interrupts.RES:Rescheduling_interrupts
     89112 ±  9%     +79.8%     160226 ±  8%  interrupts.TLB:TLB_shootdowns





Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


Thanks,
Oliver Sang


--wRRV7LY7NUeQGEoC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="config-5.10.0-rc3-00004-g0dd6d5b8c0f6"

#
# Automatically generated file; DO NOT EDIT.
# Linux/x86_64 5.10.0-rc3 Kernel Configuration
#
CONFIG_CC_VERSION_TEXT="gcc-9 (Debian 9.3.0-15) 9.3.0"
CONFIG_CC_IS_GCC=y
CONFIG_GCC_VERSION=90300
CONFIG_LD_VERSION=235000000
CONFIG_CLANG_VERSION=0
CONFIG_CC_CAN_LINK=y
CONFIG_CC_CAN_LINK_STATIC=y
CONFIG_CC_HAS_ASM_GOTO=y
CONFIG_CC_HAS_ASM_INLINE=y
CONFIG_IRQ_WORK=y
CONFIG_BUILDTIME_TABLE_SORT=y
CONFIG_THREAD_INFO_IN_TASK=y

#
# General setup
#
CONFIG_INIT_ENV_ARG_LIMIT=32
# CONFIG_COMPILE_TEST is not set
CONFIG_LOCALVERSION=""
CONFIG_LOCALVERSION_AUTO=y
CONFIG_BUILD_SALT=""
CONFIG_HAVE_KERNEL_GZIP=y
CONFIG_HAVE_KERNEL_BZIP2=y
CONFIG_HAVE_KERNEL_LZMA=y
CONFIG_HAVE_KERNEL_XZ=y
CONFIG_HAVE_KERNEL_LZO=y
CONFIG_HAVE_KERNEL_LZ4=y
CONFIG_HAVE_KERNEL_ZSTD=y
CONFIG_KERNEL_GZIP=y
# CONFIG_KERNEL_BZIP2 is not set
# CONFIG_KERNEL_LZMA is not set
# CONFIG_KERNEL_XZ is not set
# CONFIG_KERNEL_LZO is not set
# CONFIG_KERNEL_LZ4 is not set
# CONFIG_KERNEL_ZSTD is not set
CONFIG_DEFAULT_INIT=""
CONFIG_DEFAULT_HOSTNAME="(none)"
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_SYSVIPC_SYSCTL=y
CONFIG_POSIX_MQUEUE=y
CONFIG_POSIX_MQUEUE_SYSCTL=y
# CONFIG_WATCH_QUEUE is not set
CONFIG_CROSS_MEMORY_ATTACH=y
# CONFIG_USELIB is not set
CONFIG_AUDIT=y
CONFIG_HAVE_ARCH_AUDITSYSCALL=y
CONFIG_AUDITSYSCALL=y

#
# IRQ subsystem
#
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_GENERIC_IRQ_SHOW=y
CONFIG_GENERIC_IRQ_EFFECTIVE_AFF_MASK=y
CONFIG_GENERIC_PENDING_IRQ=y
CONFIG_GENERIC_IRQ_MIGRATION=y
CONFIG_GENERIC_IRQ_INJECTION=y
CONFIG_HARDIRQS_SW_RESEND=y
CONFIG_IRQ_DOMAIN=y
CONFIG_IRQ_DOMAIN_HIERARCHY=y
CONFIG_GENERIC_MSI_IRQ=y
CONFIG_GENERIC_MSI_IRQ_DOMAIN=y
CONFIG_IRQ_MSI_IOMMU=y
CONFIG_GENERIC_IRQ_MATRIX_ALLOCATOR=y
CONFIG_GENERIC_IRQ_RESERVATION_MODE=y
CONFIG_IRQ_FORCED_THREADING=y
CONFIG_SPARSE_IRQ=y
# CONFIG_GENERIC_IRQ_DEBUGFS is not set
# end of IRQ subsystem

CONFIG_CLOCKSOURCE_WATCHDOG=y
CONFIG_ARCH_CLOCKSOURCE_INIT=y
CONFIG_CLOCKSOURCE_VALIDATE_LAST_CYCLE=y
CONFIG_GENERIC_TIME_VSYSCALL=y
CONFIG_GENERIC_CLOCKEVENTS=y
CONFIG_GENERIC_CLOCKEVENTS_BROADCAST=y
CONFIG_GENERIC_CLOCKEVENTS_MIN_ADJUST=y
CONFIG_GENERIC_CMOS_UPDATE=y
CONFIG_HAVE_POSIX_CPU_TIMERS_TASK_WORK=y
CONFIG_POSIX_CPU_TIMERS_TASK_WORK=y

#
# Timers subsystem
#
CONFIG_TICK_ONESHOT=y
CONFIG_NO_HZ_COMMON=y
# CONFIG_HZ_PERIODIC is not set
# CONFIG_NO_HZ_IDLE is not set
CONFIG_NO_HZ_FULL=y
CONFIG_CONTEXT_TRACKING=y
# CONFIG_CONTEXT_TRACKING_FORCE is not set
CONFIG_NO_HZ=y
CONFIG_HIGH_RES_TIMERS=y
# end of Timers subsystem

# CONFIG_PREEMPT_NONE is not set
CONFIG_PREEMPT_VOLUNTARY=y
# CONFIG_PREEMPT is not set
CONFIG_PREEMPT_COUNT=y

#
# CPU/Task time and stats accounting
#
CONFIG_VIRT_CPU_ACCOUNTING=y
CONFIG_VIRT_CPU_ACCOUNTING_GEN=y
CONFIG_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_SCHED_AVG_IRQ=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_BSD_PROCESS_ACCT_V3=y
CONFIG_TASKSTATS=y
CONFIG_TASK_DELAY_ACCT=y
CONFIG_TASK_XACCT=y
CONFIG_TASK_IO_ACCOUNTING=y
# CONFIG_PSI is not set
# end of CPU/Task time and stats accounting

CONFIG_CPU_ISOLATION=y

#
# RCU Subsystem
#
CONFIG_TREE_RCU=y
# CONFIG_RCU_EXPERT is not set
CONFIG_SRCU=y
CONFIG_TREE_SRCU=y
CONFIG_TASKS_RCU_GENERIC=y
CONFIG_TASKS_RCU=y
CONFIG_TASKS_RUDE_RCU=y
CONFIG_TASKS_TRACE_RCU=y
CONFIG_RCU_STALL_COMMON=y
CONFIG_RCU_NEED_SEGCBLIST=y
CONFIG_RCU_NOCB_CPU=y
# end of RCU Subsystem

CONFIG_BUILD_BIN2C=y
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
# CONFIG_IKHEADERS is not set
CONFIG_LOG_BUF_SHIFT=20
CONFIG_LOG_CPU_MAX_BUF_SHIFT=12
CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT=13
CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y

#
# Scheduler features
#
# CONFIG_UCLAMP_TASK is not set
# end of Scheduler features

CONFIG_ARCH_SUPPORTS_NUMA_BALANCING=y
CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=y
CONFIG_CC_HAS_INT128=y
CONFIG_ARCH_SUPPORTS_INT128=y
CONFIG_NUMA_BALANCING=y
CONFIG_NUMA_BALANCING_DEFAULT_ENABLED=y
CONFIG_CGROUPS=y
CONFIG_PAGE_COUNTER=y
CONFIG_MEMCG=y
CONFIG_MEMCG_SWAP=y
CONFIG_MEMCG_KMEM=y
CONFIG_BLK_CGROUP=y
CONFIG_CGROUP_WRITEBACK=y
CONFIG_CGROUP_SCHED=y
CONFIG_FAIR_GROUP_SCHED=y
CONFIG_CFS_BANDWIDTH=y
CONFIG_RT_GROUP_SCHED=y
CONFIG_CGROUP_PIDS=y
CONFIG_CGROUP_RDMA=y
CONFIG_CGROUP_FREEZER=y
CONFIG_CGROUP_HUGETLB=y
CONFIG_CPUSETS=y
CONFIG_PROC_PID_CPUSET=y
CONFIG_CGROUP_DEVICE=y
CONFIG_CGROUP_CPUACCT=y
CONFIG_CGROUP_PERF=y
CONFIG_CGROUP_BPF=y
# CONFIG_CGROUP_DEBUG is not set
CONFIG_SOCK_CGROUP_DATA=y
CONFIG_NAMESPACES=y
CONFIG_UTS_NS=y
CONFIG_TIME_NS=y
CONFIG_IPC_NS=y
CONFIG_USER_NS=y
CONFIG_PID_NS=y
CONFIG_NET_NS=y
# CONFIG_CHECKPOINT_RESTORE is not set
CONFIG_SCHED_AUTOGROUP=y
# CONFIG_SYSFS_DEPRECATED is not set
CONFIG_RELAY=y
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_RD_GZIP=y
CONFIG_RD_BZIP2=y
CONFIG_RD_LZMA=y
CONFIG_RD_XZ=y
CONFIG_RD_LZO=y
CONFIG_RD_LZ4=y
CONFIG_RD_ZSTD=y
# CONFIG_BOOT_CONFIG is not set
CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE=y
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
CONFIG_SYSCTL=y
CONFIG_HAVE_UID16=y
CONFIG_SYSCTL_EXCEPTION_TRACE=y
CONFIG_HAVE_PCSPKR_PLATFORM=y
CONFIG_BPF=y
# CONFIG_EXPERT is not set
CONFIG_UID16=y
CONFIG_MULTIUSER=y
CONFIG_SGETMASK_SYSCALL=y
CONFIG_SYSFS_SYSCALL=y
CONFIG_FHANDLE=y
CONFIG_POSIX_TIMERS=y
CONFIG_PRINTK=y
CONFIG_PRINTK_NMI=y
CONFIG_BUG=y
CONFIG_ELF_CORE=y
CONFIG_PCSPKR_PLATFORM=y
CONFIG_BASE_FULL=y
CONFIG_FUTEX=y
CONFIG_FUTEX_PI=y
CONFIG_EPOLL=y
CONFIG_SIGNALFD=y
CONFIG_TIMERFD=y
CONFIG_EVENTFD=y
CONFIG_SHMEM=y
CONFIG_AIO=y
CONFIG_IO_URING=y
CONFIG_ADVISE_SYSCALLS=y
CONFIG_HAVE_ARCH_USERFAULTFD_WP=y
CONFIG_MEMBARRIER=y
CONFIG_KALLSYMS=y
CONFIG_KALLSYMS_ALL=y
CONFIG_KALLSYMS_ABSOLUTE_PERCPU=y
CONFIG_KALLSYMS_BASE_RELATIVE=y
# CONFIG_BPF_LSM is not set
CONFIG_BPF_SYSCALL=y
CONFIG_ARCH_WANT_DEFAULT_BPF_JIT=y
CONFIG_BPF_JIT_ALWAYS_ON=y
CONFIG_BPF_JIT_DEFAULT_ON=y
# CONFIG_BPF_PRELOAD is not set
CONFIG_USERFAULTFD=y
CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=y
CONFIG_RSEQ=y
# CONFIG_EMBEDDED is not set
CONFIG_HAVE_PERF_EVENTS=y

#
# Kernel Performance Events And Counters
#
CONFIG_PERF_EVENTS=y
# CONFIG_DEBUG_PERF_USE_VMALLOC is not set
# end of Kernel Performance Events And Counters

CONFIG_VM_EVENT_COUNTERS=y
CONFIG_SLUB_DEBUG=y
# CONFIG_COMPAT_BRK is not set
# CONFIG_SLAB is not set
CONFIG_SLUB=y
CONFIG_SLAB_MERGE_DEFAULT=y
CONFIG_SLAB_FREELIST_RANDOM=y
# CONFIG_SLAB_FREELIST_HARDENED is not set
CONFIG_SHUFFLE_PAGE_ALLOCATOR=y
CONFIG_SLUB_CPU_PARTIAL=y
CONFIG_SYSTEM_DATA_VERIFICATION=y
CONFIG_PROFILING=y
CONFIG_TRACEPOINTS=y
# end of General setup

CONFIG_64BIT=y
CONFIG_X86_64=y
CONFIG_X86=y
CONFIG_INSTRUCTION_DECODER=y
CONFIG_OUTPUT_FORMAT="elf64-x86-64"
CONFIG_LOCKDEP_SUPPORT=y
CONFIG_STACKTRACE_SUPPORT=y
CONFIG_MMU=y
CONFIG_ARCH_MMAP_RND_BITS_MIN=28
CONFIG_ARCH_MMAP_RND_BITS_MAX=32
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MIN=8
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MAX=16
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_BUG=y
CONFIG_GENERIC_BUG_RELATIVE_POINTERS=y
CONFIG_ARCH_MAY_HAVE_PC_FDC=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_ARCH_HAS_CPU_RELAX=y
CONFIG_ARCH_HAS_CACHE_LINE_SIZE=y
CONFIG_ARCH_HAS_FILTER_PGPROT=y
CONFIG_HAVE_SETUP_PER_CPU_AREA=y
CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=y
CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=y
CONFIG_ARCH_HIBERNATION_POSSIBLE=y
CONFIG_ARCH_SUSPEND_POSSIBLE=y
CONFIG_ARCH_WANT_GENERAL_HUGETLB=y
CONFIG_ZONE_DMA32=y
CONFIG_AUDIT_ARCH=y
CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
CONFIG_HAVE_INTEL_TXT=y
CONFIG_X86_64_SMP=y
CONFIG_ARCH_SUPPORTS_UPROBES=y
CONFIG_FIX_EARLYCON_MEM=y
CONFIG_DYNAMIC_PHYSICAL_MASK=y
CONFIG_PGTABLE_LEVELS=5
CONFIG_CC_HAS_SANE_STACKPROTECTOR=y

#
# Processor type and features
#
CONFIG_ZONE_DMA=y
CONFIG_SMP=y
CONFIG_X86_FEATURE_NAMES=y
CONFIG_X86_X2APIC=y
CONFIG_X86_MPPARSE=y
# CONFIG_GOLDFISH is not set
CONFIG_RETPOLINE=y
CONFIG_X86_CPU_RESCTRL=y
CONFIG_X86_EXTENDED_PLATFORM=y
# CONFIG_X86_NUMACHIP is not set
# CONFIG_X86_VSMP is not set
CONFIG_X86_UV=y
# CONFIG_X86_GOLDFISH is not set
# CONFIG_X86_INTEL_MID is not set
CONFIG_X86_INTEL_LPSS=y
CONFIG_X86_AMD_PLATFORM_DEVICE=y
CONFIG_IOSF_MBI=y
# CONFIG_IOSF_MBI_DEBUG is not set
CONFIG_X86_SUPPORTS_MEMORY_FAILURE=y
# CONFIG_SCHED_OMIT_FRAME_POINTER is not set
CONFIG_HYPERVISOR_GUEST=y
CONFIG_PARAVIRT=y
# CONFIG_PARAVIRT_DEBUG is not set
CONFIG_PARAVIRT_SPINLOCKS=y
CONFIG_X86_HV_CALLBACK_VECTOR=y
CONFIG_XEN=y
# CONFIG_XEN_PV is not set
CONFIG_XEN_PVHVM=y
CONFIG_XEN_PVHVM_SMP=y
CONFIG_XEN_SAVE_RESTORE=y
# CONFIG_XEN_DEBUG_FS is not set
# CONFIG_XEN_PVH is not set
CONFIG_KVM_GUEST=y
CONFIG_ARCH_CPUIDLE_HALTPOLL=y
# CONFIG_PVH is not set
CONFIG_PARAVIRT_TIME_ACCOUNTING=y
CONFIG_PARAVIRT_CLOCK=y
# CONFIG_JAILHOUSE_GUEST is not set
# CONFIG_ACRN_GUEST is not set
# CONFIG_MK8 is not set
# CONFIG_MPSC is not set
# CONFIG_MCORE2 is not set
# CONFIG_MATOM is not set
CONFIG_GENERIC_CPU=y
CONFIG_X86_INTERNODE_CACHE_SHIFT=6
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_X86_TSC=y
CONFIG_X86_CMPXCHG64=y
CONFIG_X86_CMOV=y
CONFIG_X86_MINIMUM_CPU_FAMILY=64
CONFIG_X86_DEBUGCTLMSR=y
CONFIG_IA32_FEAT_CTL=y
CONFIG_X86_VMX_FEATURE_NAMES=y
CONFIG_CPU_SUP_INTEL=y
CONFIG_CPU_SUP_AMD=y
CONFIG_CPU_SUP_HYGON=y
CONFIG_CPU_SUP_CENTAUR=y
CONFIG_CPU_SUP_ZHAOXIN=y
CONFIG_HPET_TIMER=y
CONFIG_HPET_EMULATE_RTC=y
CONFIG_DMI=y
# CONFIG_GART_IOMMU is not set
CONFIG_MAXSMP=y
CONFIG_NR_CPUS_RANGE_BEGIN=8192
CONFIG_NR_CPUS_RANGE_END=8192
CONFIG_NR_CPUS_DEFAULT=8192
CONFIG_NR_CPUS=8192
CONFIG_SCHED_SMT=y
CONFIG_SCHED_MC=y
CONFIG_SCHED_MC_PRIO=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS=y
CONFIG_X86_MCE=y
CONFIG_X86_MCELOG_LEGACY=y
CONFIG_X86_MCE_INTEL=y
CONFIG_X86_MCE_AMD=y
CONFIG_X86_MCE_THRESHOLD=y
CONFIG_X86_MCE_INJECT=m
CONFIG_X86_THERMAL_VECTOR=y

#
# Performance monitoring
#
CONFIG_PERF_EVENTS_INTEL_UNCORE=m
CONFIG_PERF_EVENTS_INTEL_RAPL=m
CONFIG_PERF_EVENTS_INTEL_CSTATE=m
CONFIG_PERF_EVENTS_AMD_POWER=m
# end of Performance monitoring

CONFIG_X86_16BIT=y
CONFIG_X86_ESPFIX64=y
CONFIG_X86_VSYSCALL_EMULATION=y
CONFIG_X86_IOPL_IOPERM=y
CONFIG_I8K=m
CONFIG_MICROCODE=y
CONFIG_MICROCODE_INTEL=y
CONFIG_MICROCODE_AMD=y
CONFIG_MICROCODE_OLD_INTERFACE=y
CONFIG_X86_MSR=y
CONFIG_X86_CPUID=y
CONFIG_X86_5LEVEL=y
CONFIG_X86_DIRECT_GBPAGES=y
# CONFIG_X86_CPA_STATISTICS is not set
CONFIG_AMD_MEM_ENCRYPT=y
# CONFIG_AMD_MEM_ENCRYPT_ACTIVE_BY_DEFAULT is not set
CONFIG_NUMA=y
CONFIG_NUMA_AWARE_SPINLOCKS=y
CONFIG_AMD_NUMA=y
CONFIG_X86_64_ACPI_NUMA=y
CONFIG_NUMA_EMU=y
CONFIG_NODES_SHIFT=10
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_DEFAULT=y
CONFIG_ARCH_SELECT_MEMORY_MODEL=y
# CONFIG_ARCH_MEMORY_PROBE is not set
CONFIG_ARCH_PROC_KCORE_TEXT=y
CONFIG_ILLEGAL_POINTER_VALUE=0xdead000000000000
CONFIG_X86_PMEM_LEGACY_DEVICE=y
CONFIG_X86_PMEM_LEGACY=m
CONFIG_X86_CHECK_BIOS_CORRUPTION=y
# CONFIG_X86_BOOTPARAM_MEMORY_CORRUPTION_CHECK is not set
CONFIG_X86_RESERVE_LOW=64
CONFIG_MTRR=y
CONFIG_MTRR_SANITIZER=y
CONFIG_MTRR_SANITIZER_ENABLE_DEFAULT=1
CONFIG_MTRR_SANITIZER_SPARE_REG_NR_DEFAULT=1
CONFIG_X86_PAT=y
CONFIG_ARCH_USES_PG_UNCACHED=y
CONFIG_ARCH_RANDOM=y
CONFIG_X86_SMAP=y
CONFIG_X86_UMIP=y
CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS=y
CONFIG_X86_INTEL_TSX_MODE_OFF=y
# CONFIG_X86_INTEL_TSX_MODE_ON is not set
# CONFIG_X86_INTEL_TSX_MODE_AUTO is not set
CONFIG_EFI=y
CONFIG_EFI_STUB=y
CONFIG_EFI_MIXED=y
# CONFIG_HZ_100 is not set
# CONFIG_HZ_250 is not set
# CONFIG_HZ_300 is not set
CONFIG_HZ_1000=y
CONFIG_HZ=1000
CONFIG_SCHED_HRTICK=y
CONFIG_KEXEC=y
CONFIG_KEXEC_FILE=y
CONFIG_ARCH_HAS_KEXEC_PURGATORY=y
# CONFIG_KEXEC_SIG is not set
CONFIG_CRASH_DUMP=y
CONFIG_KEXEC_JUMP=y
CONFIG_PHYSICAL_START=0x1000000
CONFIG_RELOCATABLE=y
CONFIG_RANDOMIZE_BASE=y
CONFIG_X86_NEED_RELOCS=y
CONFIG_PHYSICAL_ALIGN=0x200000
CONFIG_DYNAMIC_MEMORY_LAYOUT=y
CONFIG_RANDOMIZE_MEMORY=y
CONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING=0xa
CONFIG_HOTPLUG_CPU=y
CONFIG_BOOTPARAM_HOTPLUG_CPU0=y
# CONFIG_DEBUG_HOTPLUG_CPU0 is not set
# CONFIG_COMPAT_VDSO is not set
CONFIG_LEGACY_VSYSCALL_EMULATE=y
# CONFIG_LEGACY_VSYSCALL_XONLY is not set
# CONFIG_LEGACY_VSYSCALL_NONE is not set
# CONFIG_CMDLINE_BOOL is not set
CONFIG_MODIFY_LDT_SYSCALL=y
CONFIG_HAVE_LIVEPATCH=y
CONFIG_LIVEPATCH=y
# end of Processor type and features

CONFIG_ARCH_HAS_ADD_PAGES=y
CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE=y
CONFIG_USE_PERCPU_NUMA_NODE_ID=y
CONFIG_ARCH_ENABLE_SPLIT_PMD_PTLOCK=y
CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION=y
CONFIG_ARCH_ENABLE_THP_MIGRATION=y

#
# Power management and ACPI options
#
CONFIG_ARCH_HIBERNATION_HEADER=y
CONFIG_SUSPEND=y
CONFIG_SUSPEND_FREEZER=y
CONFIG_HIBERNATE_CALLBACKS=y
CONFIG_HIBERNATION=y
CONFIG_HIBERNATION_SNAPSHOT_DEV=y
CONFIG_PM_STD_PARTITION=""
CONFIG_PM_SLEEP=y
CONFIG_PM_SLEEP_SMP=y
# CONFIG_PM_AUTOSLEEP is not set
# CONFIG_PM_WAKELOCKS is not set
CONFIG_PM=y
CONFIG_PM_DEBUG=y
# CONFIG_PM_ADVANCED_DEBUG is not set
# CONFIG_PM_TEST_SUSPEND is not set
CONFIG_PM_SLEEP_DEBUG=y
# CONFIG_PM_TRACE_RTC is not set
CONFIG_PM_CLK=y
# CONFIG_WQ_POWER_EFFICIENT_DEFAULT is not set
# CONFIG_ENERGY_MODEL is not set
CONFIG_ARCH_SUPPORTS_ACPI=y
CONFIG_ACPI=y
CONFIG_ACPI_LEGACY_TABLES_LOOKUP=y
CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC=y
CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT=y
# CONFIG_ACPI_DEBUGGER is not set
CONFIG_ACPI_SPCR_TABLE=y
CONFIG_ACPI_LPIT=y
CONFIG_ACPI_SLEEP=y
CONFIG_ACPI_REV_OVERRIDE_POSSIBLE=y
CONFIG_ACPI_EC_DEBUGFS=m
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_VIDEO=m
CONFIG_ACPI_FAN=y
CONFIG_ACPI_TAD=m
CONFIG_ACPI_DOCK=y
CONFIG_ACPI_CPU_FREQ_PSS=y
CONFIG_ACPI_PROCESSOR_CSTATE=y
CONFIG_ACPI_PROCESSOR_IDLE=y
CONFIG_ACPI_CPPC_LIB=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_IPMI=m
CONFIG_ACPI_HOTPLUG_CPU=y
CONFIG_ACPI_PROCESSOR_AGGREGATOR=m
CONFIG_ACPI_THERMAL=y
CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
CONFIG_ACPI_TABLE_UPGRADE=y
# CONFIG_ACPI_DEBUG is not set
CONFIG_ACPI_PCI_SLOT=y
CONFIG_ACPI_CONTAINER=y
CONFIG_ACPI_HOTPLUG_MEMORY=y
CONFIG_ACPI_HOTPLUG_IOAPIC=y
CONFIG_ACPI_SBS=m
CONFIG_ACPI_HED=y
# CONFIG_ACPI_CUSTOM_METHOD is not set
CONFIG_ACPI_BGRT=y
CONFIG_ACPI_NFIT=m
# CONFIG_NFIT_SECURITY_DEBUG is not set
CONFIG_ACPI_NUMA=y
# CONFIG_ACPI_HMAT is not set
CONFIG_HAVE_ACPI_APEI=y
CONFIG_HAVE_ACPI_APEI_NMI=y
CONFIG_ACPI_APEI=y
CONFIG_ACPI_APEI_GHES=y
CONFIG_ACPI_APEI_PCIEAER=y
CONFIG_ACPI_APEI_MEMORY_FAILURE=y
CONFIG_ACPI_APEI_EINJ=m
CONFIG_ACPI_APEI_ERST_DEBUG=y
# CONFIG_ACPI_DPTF is not set
CONFIG_ACPI_WATCHDOG=y
CONFIG_ACPI_EXTLOG=m
CONFIG_ACPI_ADXL=y
# CONFIG_ACPI_CONFIGFS is not set
CONFIG_PMIC_OPREGION=y
CONFIG_X86_PM_TIMER=y
CONFIG_SFI=y

#
# CPU Frequency scaling
#
CONFIG_CPU_FREQ=y
CONFIG_CPU_FREQ_GOV_ATTR_SET=y
CONFIG_CPU_FREQ_GOV_COMMON=y
CONFIG_CPU_FREQ_STAT=y
CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE=y
# CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_SCHEDUTIL is not set
CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
CONFIG_CPU_FREQ_GOV_POWERSAVE=y
CONFIG_CPU_FREQ_GOV_USERSPACE=y
CONFIG_CPU_FREQ_GOV_ONDEMAND=y
CONFIG_CPU_FREQ_GOV_CONSERVATIVE=y
CONFIG_CPU_FREQ_GOV_SCHEDUTIL=y

#
# CPU frequency scaling drivers
#
CONFIG_X86_INTEL_PSTATE=y
# CONFIG_X86_PCC_CPUFREQ is not set
CONFIG_X86_ACPI_CPUFREQ=m
CONFIG_X86_ACPI_CPUFREQ_CPB=y
CONFIG_X86_POWERNOW_K8=m
CONFIG_X86_AMD_FREQ_SENSITIVITY=m
# CONFIG_X86_SPEEDSTEP_CENTRINO is not set
CONFIG_X86_P4_CLOCKMOD=m

#
# shared options
#
CONFIG_X86_SPEEDSTEP_LIB=m
# end of CPU Frequency scaling

#
# CPU Idle
#
CONFIG_CPU_IDLE=y
# CONFIG_CPU_IDLE_GOV_LADDER is not set
CONFIG_CPU_IDLE_GOV_MENU=y
# CONFIG_CPU_IDLE_GOV_TEO is not set
# CONFIG_CPU_IDLE_GOV_HALTPOLL is not set
CONFIG_HALTPOLL_CPUIDLE=y
# end of CPU Idle

CONFIG_INTEL_IDLE=y
# end of Power management and ACPI options

#
# Bus options (PCI etc.)
#
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
CONFIG_PCI_XEN=y
CONFIG_MMCONF_FAM10H=y
CONFIG_ISA_DMA_API=y
CONFIG_AMD_NB=y
# CONFIG_X86_SYSFB is not set
# end of Bus options (PCI etc.)

#
# Binary Emulations
#
CONFIG_IA32_EMULATION=y
# CONFIG_X86_X32 is not set
CONFIG_COMPAT_32=y
CONFIG_COMPAT=y
CONFIG_COMPAT_FOR_U64_ALIGNMENT=y
CONFIG_SYSVIPC_COMPAT=y
# end of Binary Emulations

#
# Firmware Drivers
#
CONFIG_EDD=m
# CONFIG_EDD_OFF is not set
CONFIG_FIRMWARE_MEMMAP=y
CONFIG_DMIID=y
CONFIG_DMI_SYSFS=y
CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK=y
# CONFIG_ISCSI_IBFT is not set
CONFIG_FW_CFG_SYSFS=y
# CONFIG_FW_CFG_SYSFS_CMDLINE is not set
# CONFIG_GOOGLE_FIRMWARE is not set

#
# EFI (Extensible Firmware Interface) Support
#
CONFIG_EFI_VARS=y
CONFIG_EFI_ESRT=y
CONFIG_EFI_VARS_PSTORE=y
CONFIG_EFI_VARS_PSTORE_DEFAULT_DISABLE=y
CONFIG_EFI_RUNTIME_MAP=y
# CONFIG_EFI_FAKE_MEMMAP is not set
CONFIG_EFI_RUNTIME_WRAPPERS=y
CONFIG_EFI_GENERIC_STUB_INITRD_CMDLINE_LOADER=y
# CONFIG_EFI_BOOTLOADER_CONTROL is not set
# CONFIG_EFI_CAPSULE_LOADER is not set
# CONFIG_EFI_TEST is not set
CONFIG_APPLE_PROPERTIES=y
# CONFIG_RESET_ATTACK_MITIGATION is not set
# CONFIG_EFI_RCI2_TABLE is not set
# CONFIG_EFI_DISABLE_PCI_DMA is not set
# end of EFI (Extensible Firmware Interface) Support

CONFIG_UEFI_CPER=y
CONFIG_UEFI_CPER_X86=y
CONFIG_EFI_DEV_PATH_PARSER=y
CONFIG_EFI_EARLYCON=y
CONFIG_EFI_CUSTOM_SSDT_OVERLAYS=y

#
# Tegra firmware driver
#
# end of Tegra firmware driver
# end of Firmware Drivers

CONFIG_HAVE_KVM=y
CONFIG_HAVE_KVM_IRQCHIP=y
CONFIG_HAVE_KVM_IRQFD=y
CONFIG_HAVE_KVM_IRQ_ROUTING=y
CONFIG_HAVE_KVM_EVENTFD=y
CONFIG_KVM_MMIO=y
CONFIG_KVM_ASYNC_PF=y
CONFIG_HAVE_KVM_MSI=y
CONFIG_HAVE_KVM_CPU_RELAX_INTERCEPT=y
CONFIG_KVM_VFIO=y
CONFIG_KVM_GENERIC_DIRTYLOG_READ_PROTECT=y
CONFIG_KVM_COMPAT=y
CONFIG_HAVE_KVM_IRQ_BYPASS=y
CONFIG_HAVE_KVM_NO_POLL=y
CONFIG_KVM_XFER_TO_GUEST_WORK=y
CONFIG_VIRTUALIZATION=y
CONFIG_KVM=m
CONFIG_KVM_INTEL=m
# CONFIG_KVM_AMD is not set
CONFIG_KVM_MMU_AUDIT=y
CONFIG_AS_AVX512=y
CONFIG_AS_SHA1_NI=y
CONFIG_AS_SHA256_NI=y
CONFIG_AS_TPAUSE=y

#
# General architecture-dependent options
#
CONFIG_CRASH_CORE=y
CONFIG_KEXEC_CORE=y
CONFIG_HOTPLUG_SMT=y
CONFIG_GENERIC_ENTRY=y
CONFIG_OPROFILE=m
CONFIG_OPROFILE_EVENT_MULTIPLEX=y
CONFIG_HAVE_OPROFILE=y
CONFIG_OPROFILE_NMI_TIMER=y
CONFIG_KPROBES=y
CONFIG_JUMP_LABEL=y
# CONFIG_STATIC_KEYS_SELFTEST is not set
# CONFIG_STATIC_CALL_SELFTEST is not set
CONFIG_OPTPROBES=y
CONFIG_KPROBES_ON_FTRACE=y
CONFIG_UPROBES=y
CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y
CONFIG_ARCH_USE_BUILTIN_BSWAP=y
CONFIG_KRETPROBES=y
CONFIG_USER_RETURN_NOTIFIER=y
CONFIG_HAVE_IOREMAP_PROT=y
CONFIG_HAVE_KPROBES=y
CONFIG_HAVE_KRETPROBES=y
CONFIG_HAVE_OPTPROBES=y
CONFIG_HAVE_KPROBES_ON_FTRACE=y
CONFIG_HAVE_FUNCTION_ERROR_INJECTION=y
CONFIG_HAVE_NMI=y
CONFIG_HAVE_ARCH_TRACEHOOK=y
CONFIG_HAVE_DMA_CONTIGUOUS=y
CONFIG_GENERIC_SMP_IDLE_THREAD=y
CONFIG_ARCH_HAS_FORTIFY_SOURCE=y
CONFIG_ARCH_HAS_SET_MEMORY=y
CONFIG_ARCH_HAS_SET_DIRECT_MAP=y
CONFIG_HAVE_ARCH_THREAD_STRUCT_WHITELIST=y
CONFIG_ARCH_WANTS_DYNAMIC_TASK_STRUCT=y
CONFIG_HAVE_ASM_MODVERSIONS=y
CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=y
CONFIG_HAVE_RSEQ=y
CONFIG_HAVE_FUNCTION_ARG_ACCESS_API=y
CONFIG_HAVE_HW_BREAKPOINT=y
CONFIG_HAVE_MIXED_BREAKPOINTS_REGS=y
CONFIG_HAVE_USER_RETURN_NOTIFIER=y
CONFIG_HAVE_PERF_EVENTS_NMI=y
CONFIG_HAVE_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HAVE_PERF_REGS=y
CONFIG_HAVE_PERF_USER_STACK_DUMP=y
CONFIG_HAVE_ARCH_JUMP_LABEL=y
CONFIG_HAVE_ARCH_JUMP_LABEL_RELATIVE=y
CONFIG_MMU_GATHER_TABLE_FREE=y
CONFIG_MMU_GATHER_RCU_TABLE_FREE=y
CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG=y
CONFIG_HAVE_ALIGNED_STRUCT_PAGE=y
CONFIG_HAVE_CMPXCHG_LOCAL=y
CONFIG_HAVE_CMPXCHG_DOUBLE=y
CONFIG_ARCH_WANT_COMPAT_IPC_PARSE_VERSION=y
CONFIG_ARCH_WANT_OLD_COMPAT_IPC=y
CONFIG_HAVE_ARCH_SECCOMP=y
CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
CONFIG_SECCOMP=y
CONFIG_SECCOMP_FILTER=y
CONFIG_HAVE_ARCH_STACKLEAK=y
CONFIG_HAVE_STACKPROTECTOR=y
CONFIG_STACKPROTECTOR=y
CONFIG_STACKPROTECTOR_STRONG=y
CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES=y
CONFIG_HAVE_CONTEXT_TRACKING=y
CONFIG_HAVE_VIRT_CPU_ACCOUNTING_GEN=y
CONFIG_HAVE_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_MOVE_PMD=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD=y
CONFIG_HAVE_ARCH_HUGE_VMAP=y
CONFIG_ARCH_WANT_HUGE_PMD_SHARE=y
CONFIG_HAVE_ARCH_SOFT_DIRTY=y
CONFIG_HAVE_MOD_ARCH_SPECIFIC=y
CONFIG_MODULES_USE_ELF_RELA=y
CONFIG_ARCH_HAS_ELF_RANDOMIZE=y
CONFIG_HAVE_ARCH_MMAP_RND_BITS=y
CONFIG_HAVE_EXIT_THREAD=y
CONFIG_ARCH_MMAP_RND_BITS=28
CONFIG_HAVE_ARCH_MMAP_RND_COMPAT_BITS=y
CONFIG_ARCH_MMAP_RND_COMPAT_BITS=8
CONFIG_HAVE_ARCH_COMPAT_MMAP_BASES=y
CONFIG_HAVE_STACK_VALIDATION=y
CONFIG_HAVE_RELIABLE_STACKTRACE=y
CONFIG_OLD_SIGSUSPEND3=y
CONFIG_COMPAT_OLD_SIGACTION=y
CONFIG_COMPAT_32BIT_TIME=y
CONFIG_HAVE_ARCH_VMAP_STACK=y
CONFIG_VMAP_STACK=y
CONFIG_ARCH_HAS_STRICT_KERNEL_RWX=y
CONFIG_STRICT_KERNEL_RWX=y
CONFIG_ARCH_HAS_STRICT_MODULE_RWX=y
CONFIG_STRICT_MODULE_RWX=y
CONFIG_HAVE_ARCH_PREL32_RELOCATIONS=y
CONFIG_ARCH_USE_MEMREMAP_PROT=y
# CONFIG_LOCK_EVENT_COUNTS is not set
CONFIG_ARCH_HAS_MEM_ENCRYPT=y
CONFIG_HAVE_STATIC_CALL=y
CONFIG_HAVE_STATIC_CALL_INLINE=y

#
# GCOV-based kernel profiling
#
# CONFIG_GCOV_KERNEL is not set
CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
# end of GCOV-based kernel profiling

CONFIG_HAVE_GCC_PLUGINS=y
# end of General architecture-dependent options

CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=0
CONFIG_MODULE_SIG_FORMAT=y
CONFIG_MODULES=y
CONFIG_MODULE_FORCE_LOAD=y
CONFIG_MODULE_UNLOAD=y
# CONFIG_MODULE_FORCE_UNLOAD is not set
# CONFIG_MODVERSIONS is not set
# CONFIG_MODULE_SRCVERSION_ALL is not set
CONFIG_MODULE_SIG=y
# CONFIG_MODULE_SIG_FORCE is not set
CONFIG_MODULE_SIG_ALL=y
# CONFIG_MODULE_SIG_SHA1 is not set
# CONFIG_MODULE_SIG_SHA224 is not set
CONFIG_MODULE_SIG_SHA256=y
# CONFIG_MODULE_SIG_SHA384 is not set
# CONFIG_MODULE_SIG_SHA512 is not set
CONFIG_MODULE_SIG_HASH="sha256"
# CONFIG_MODULE_COMPRESS is not set
# CONFIG_MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS is not set
# CONFIG_UNUSED_SYMBOLS is not set
# CONFIG_TRIM_UNUSED_KSYMS is not set
CONFIG_MODULES_TREE_LOOKUP=y
CONFIG_BLOCK=y
CONFIG_BLK_SCSI_REQUEST=y
CONFIG_BLK_CGROUP_RWSTAT=y
CONFIG_BLK_DEV_BSG=y
CONFIG_BLK_DEV_BSGLIB=y
CONFIG_BLK_DEV_INTEGRITY=y
CONFIG_BLK_DEV_INTEGRITY_T10=m
CONFIG_BLK_DEV_ZONED=y
CONFIG_BLK_DEV_THROTTLING=y
# CONFIG_BLK_DEV_THROTTLING_LOW is not set
# CONFIG_BLK_CMDLINE_PARSER is not set
CONFIG_BLK_WBT=y
# CONFIG_BLK_CGROUP_IOLATENCY is not set
# CONFIG_BLK_CGROUP_IOCOST is not set
CONFIG_BLK_WBT_MQ=y
CONFIG_BLK_DEBUG_FS=y
CONFIG_BLK_DEBUG_FS_ZONED=y
# CONFIG_BLK_SED_OPAL is not set
# CONFIG_BLK_INLINE_ENCRYPTION is not set

#
# Partition Types
#
CONFIG_PARTITION_ADVANCED=y
# CONFIG_ACORN_PARTITION is not set
# CONFIG_AIX_PARTITION is not set
CONFIG_OSF_PARTITION=y
CONFIG_AMIGA_PARTITION=y
# CONFIG_ATARI_PARTITION is not set
CONFIG_MAC_PARTITION=y
CONFIG_MSDOS_PARTITION=y
CONFIG_BSD_DISKLABEL=y
CONFIG_MINIX_SUBPARTITION=y
CONFIG_SOLARIS_X86_PARTITION=y
CONFIG_UNIXWARE_DISKLABEL=y
# CONFIG_LDM_PARTITION is not set
CONFIG_SGI_PARTITION=y
# CONFIG_ULTRIX_PARTITION is not set
CONFIG_SUN_PARTITION=y
CONFIG_KARMA_PARTITION=y
CONFIG_EFI_PARTITION=y
# CONFIG_SYSV68_PARTITION is not set
# CONFIG_CMDLINE_PARTITION is not set
# end of Partition Types

CONFIG_BLOCK_COMPAT=y
CONFIG_BLK_MQ_PCI=y
CONFIG_BLK_MQ_VIRTIO=y
CONFIG_BLK_MQ_RDMA=y
CONFIG_BLK_PM=y

#
# IO Schedulers
#
CONFIG_MQ_IOSCHED_DEADLINE=y
CONFIG_MQ_IOSCHED_KYBER=y
CONFIG_IOSCHED_BFQ=y
CONFIG_BFQ_GROUP_IOSCHED=y
# CONFIG_BFQ_CGROUP_DEBUG is not set
# end of IO Schedulers

CONFIG_PREEMPT_NOTIFIERS=y
CONFIG_PADATA=y
CONFIG_ASN1=y
CONFIG_INLINE_SPIN_UNLOCK_IRQ=y
CONFIG_INLINE_READ_UNLOCK=y
CONFIG_INLINE_READ_UNLOCK_IRQ=y
CONFIG_INLINE_WRITE_UNLOCK=y
CONFIG_INLINE_WRITE_UNLOCK_IRQ=y
CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=y
CONFIG_MUTEX_SPIN_ON_OWNER=y
CONFIG_RWSEM_SPIN_ON_OWNER=y
CONFIG_LOCK_SPIN_ON_OWNER=y
CONFIG_ARCH_USE_QUEUED_SPINLOCKS=y
CONFIG_QUEUED_SPINLOCKS=y
CONFIG_ARCH_USE_QUEUED_RWLOCKS=y
CONFIG_QUEUED_RWLOCKS=y
CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE=y
CONFIG_ARCH_HAS_SYNC_CORE_BEFORE_USERMODE=y
CONFIG_ARCH_HAS_SYSCALL_WRAPPER=y
CONFIG_FREEZER=y

#
# Executable file formats
#
CONFIG_BINFMT_ELF=y
CONFIG_COMPAT_BINFMT_ELF=y
CONFIG_ELFCORE=y
CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS=y
CONFIG_BINFMT_SCRIPT=y
CONFIG_BINFMT_MISC=m
CONFIG_COREDUMP=y
# end of Executable file formats

#
# Memory Management options
#
CONFIG_SELECT_MEMORY_MODEL=y
CONFIG_SPARSEMEM_MANUAL=y
CONFIG_SPARSEMEM=y
CONFIG_NEED_MULTIPLE_NODES=y
CONFIG_SPARSEMEM_EXTREME=y
CONFIG_SPARSEMEM_VMEMMAP_ENABLE=y
CONFIG_SPARSEMEM_VMEMMAP=y
CONFIG_HAVE_FAST_GUP=y
CONFIG_NUMA_KEEP_MEMINFO=y
CONFIG_MEMORY_ISOLATION=y
CONFIG_HAVE_BOOTMEM_INFO_NODE=y
CONFIG_MEMORY_HOTPLUG=y
CONFIG_MEMORY_HOTPLUG_SPARSE=y
# CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE is not set
CONFIG_MEMORY_HOTREMOVE=y
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_MEMORY_BALLOON=y
CONFIG_BALLOON_COMPACTION=y
CONFIG_COMPACTION=y
CONFIG_PAGE_REPORTING=y
CONFIG_MIGRATION=y
CONFIG_CONTIG_ALLOC=y
CONFIG_PHYS_ADDR_T_64BIT=y
CONFIG_BOUNCE=y
CONFIG_VIRT_TO_BUS=y
CONFIG_MMU_NOTIFIER=y
CONFIG_KSM=y
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
CONFIG_ARCH_SUPPORTS_MEMORY_FAILURE=y
CONFIG_MEMORY_FAILURE=y
CONFIG_HWPOISON_INJECT=m
CONFIG_TRANSPARENT_HUGEPAGE=y
CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS=y
# CONFIG_TRANSPARENT_HUGEPAGE_MADVISE is not set
CONFIG_ARCH_WANTS_THP_SWAP=y
CONFIG_THP_SWAP=y
CONFIG_CLEANCACHE=y
CONFIG_FRONTSWAP=y
CONFIG_CMA=y
# CONFIG_CMA_DEBUG is not set
# CONFIG_CMA_DEBUGFS is not set
CONFIG_CMA_AREAS=19
CONFIG_ZSWAP=y
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_DEFLATE is not set
CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZO=y
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_842 is not set
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZ4 is not set
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZ4HC is not set
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_ZSTD is not set
CONFIG_ZSWAP_COMPRESSOR_DEFAULT="lzo"
CONFIG_ZSWAP_ZPOOL_DEFAULT_ZBUD=y
# CONFIG_ZSWAP_ZPOOL_DEFAULT_Z3FOLD is not set
# CONFIG_ZSWAP_ZPOOL_DEFAULT_ZSMALLOC is not set
CONFIG_ZSWAP_ZPOOL_DEFAULT="zbud"
# CONFIG_ZSWAP_DEFAULT_ON is not set
CONFIG_ZPOOL=y
CONFIG_ZBUD=y
# CONFIG_Z3FOLD is not set
CONFIG_ZSMALLOC=y
# CONFIG_ZSMALLOC_PGTABLE_MAPPING is not set
CONFIG_ZSMALLOC_STAT=y
CONFIG_GENERIC_EARLY_IOREMAP=y
CONFIG_DEFERRED_STRUCT_PAGE_INIT=y
CONFIG_IDLE_PAGE_TRACKING=y
CONFIG_ARCH_HAS_PTE_DEVMAP=y
CONFIG_ZONE_DEVICE=y
CONFIG_DEV_PAGEMAP_OPS=y
CONFIG_HMM_MIRROR=y
CONFIG_DEVICE_PRIVATE=y
CONFIG_VMAP_PFN=y
CONFIG_FRAME_VECTOR=y
CONFIG_ARCH_USES_HIGH_VMA_FLAGS=y
CONFIG_ARCH_HAS_PKEYS=y
# CONFIG_PERCPU_STATS is not set
# CONFIG_GUP_BENCHMARK is not set
# CONFIG_READ_ONLY_THP_FOR_FS is not set
CONFIG_ARCH_HAS_PTE_SPECIAL=y
CONFIG_MAPPING_DIRTY_HELPERS=y
# end of Memory Management options

CONFIG_NET=y
CONFIG_COMPAT_NETLINK_MESSAGES=y
CONFIG_NET_INGRESS=y
CONFIG_NET_EGRESS=y
CONFIG_SKB_EXTENSIONS=y

#
# Networking options
#
CONFIG_PACKET=y
CONFIG_PACKET_DIAG=m
CONFIG_UNIX=y
CONFIG_UNIX_SCM=y
CONFIG_UNIX_DIAG=m
CONFIG_TLS=m
CONFIG_TLS_DEVICE=y
# CONFIG_TLS_TOE is not set
CONFIG_XFRM=y
CONFIG_XFRM_OFFLOAD=y
CONFIG_XFRM_ALGO=y
CONFIG_XFRM_USER=y
# CONFIG_XFRM_USER_COMPAT is not set
# CONFIG_XFRM_INTERFACE is not set
CONFIG_XFRM_SUB_POLICY=y
CONFIG_XFRM_MIGRATE=y
CONFIG_XFRM_STATISTICS=y
CONFIG_XFRM_AH=m
CONFIG_XFRM_ESP=m
CONFIG_XFRM_IPCOMP=m
CONFIG_NET_KEY=m
CONFIG_NET_KEY_MIGRATE=y
# CONFIG_SMC is not set
CONFIG_XDP_SOCKETS=y
# CONFIG_XDP_SOCKETS_DIAG is not set
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IP_ADVANCED_ROUTER=y
CONFIG_IP_FIB_TRIE_STATS=y
CONFIG_IP_MULTIPLE_TABLES=y
CONFIG_IP_ROUTE_MULTIPATH=y
CONFIG_IP_ROUTE_VERBOSE=y
CONFIG_IP_ROUTE_CLASSID=y
CONFIG_IP_PNP=y
CONFIG_IP_PNP_DHCP=y
# CONFIG_IP_PNP_BOOTP is not set
# CONFIG_IP_PNP_RARP is not set
CONFIG_NET_IPIP=m
CONFIG_NET_IPGRE_DEMUX=m
CONFIG_NET_IP_TUNNEL=m
CONFIG_NET_IPGRE=m
CONFIG_NET_IPGRE_BROADCAST=y
CONFIG_IP_MROUTE_COMMON=y
CONFIG_IP_MROUTE=y
CONFIG_IP_MROUTE_MULTIPLE_TABLES=y
CONFIG_IP_PIMSM_V1=y
CONFIG_IP_PIMSM_V2=y
CONFIG_SYN_COOKIES=y
CONFIG_NET_IPVTI=m
CONFIG_NET_UDP_TUNNEL=m
# CONFIG_NET_FOU is not set
# CONFIG_NET_FOU_IP_TUNNELS is not set
CONFIG_INET_AH=m
CONFIG_INET_ESP=m
CONFIG_INET_ESP_OFFLOAD=m
# CONFIG_INET_ESPINTCP is not set
CONFIG_INET_IPCOMP=m
CONFIG_INET_XFRM_TUNNEL=m
CONFIG_INET_TUNNEL=m
CONFIG_INET_DIAG=m
CONFIG_INET_TCP_DIAG=m
CONFIG_INET_UDP_DIAG=m
CONFIG_INET_RAW_DIAG=m
# CONFIG_INET_DIAG_DESTROY is not set
CONFIG_TCP_CONG_ADVANCED=y
CONFIG_TCP_CONG_BIC=m
CONFIG_TCP_CONG_CUBIC=y
CONFIG_TCP_CONG_WESTWOOD=m
CONFIG_TCP_CONG_HTCP=m
CONFIG_TCP_CONG_HSTCP=m
CONFIG_TCP_CONG_HYBLA=m
CONFIG_TCP_CONG_VEGAS=m
CONFIG_TCP_CONG_NV=m
CONFIG_TCP_CONG_SCALABLE=m
CONFIG_TCP_CONG_LP=m
CONFIG_TCP_CONG_VENO=m
CONFIG_TCP_CONG_YEAH=m
CONFIG_TCP_CONG_ILLINOIS=m
CONFIG_TCP_CONG_DCTCP=m
# CONFIG_TCP_CONG_CDG is not set
CONFIG_TCP_CONG_BBR=m
CONFIG_DEFAULT_CUBIC=y
# CONFIG_DEFAULT_RENO is not set
CONFIG_DEFAULT_TCP_CONG="cubic"
CONFIG_TCP_MD5SIG=y
CONFIG_IPV6=y
CONFIG_IPV6_ROUTER_PREF=y
CONFIG_IPV6_ROUTE_INFO=y
CONFIG_IPV6_OPTIMISTIC_DAD=y
CONFIG_INET6_AH=m
CONFIG_INET6_ESP=m
CONFIG_INET6_ESP_OFFLOAD=m
# CONFIG_INET6_ESPINTCP is not set
CONFIG_INET6_IPCOMP=m
CONFIG_IPV6_MIP6=m
# CONFIG_IPV6_ILA is not set
CONFIG_INET6_XFRM_TUNNEL=m
CONFIG_INET6_TUNNEL=m
CONFIG_IPV6_VTI=m
CONFIG_IPV6_SIT=m
CONFIG_IPV6_SIT_6RD=y
CONFIG_IPV6_NDISC_NODETYPE=y
CONFIG_IPV6_TUNNEL=m
CONFIG_IPV6_GRE=m
CONFIG_IPV6_MULTIPLE_TABLES=y
# CONFIG_IPV6_SUBTREES is not set
CONFIG_IPV6_MROUTE=y
CONFIG_IPV6_MROUTE_MULTIPLE_TABLES=y
CONFIG_IPV6_PIMSM_V2=y
# CONFIG_IPV6_SEG6_LWTUNNEL is not set
# CONFIG_IPV6_SEG6_HMAC is not set
# CONFIG_IPV6_RPL_LWTUNNEL is not set
CONFIG_NETLABEL=y
# CONFIG_MPTCP is not set
CONFIG_NETWORK_SECMARK=y
CONFIG_NET_PTP_CLASSIFY=y
CONFIG_NETWORK_PHY_TIMESTAMPING=y
CONFIG_NETFILTER=y
CONFIG_NETFILTER_ADVANCED=y
CONFIG_BRIDGE_NETFILTER=m

#
# Core Netfilter Configuration
#
CONFIG_NETFILTER_INGRESS=y
CONFIG_NETFILTER_NETLINK=m
CONFIG_NETFILTER_FAMILY_BRIDGE=y
CONFIG_NETFILTER_FAMILY_ARP=y
# CONFIG_NETFILTER_NETLINK_ACCT is not set
CONFIG_NETFILTER_NETLINK_QUEUE=m
CONFIG_NETFILTER_NETLINK_LOG=m
CONFIG_NETFILTER_NETLINK_OSF=m
CONFIG_NF_CONNTRACK=m
CONFIG_NF_LOG_COMMON=m
CONFIG_NF_LOG_NETDEV=m
CONFIG_NETFILTER_CONNCOUNT=m
CONFIG_NF_CONNTRACK_MARK=y
CONFIG_NF_CONNTRACK_SECMARK=y
CONFIG_NF_CONNTRACK_ZONES=y
CONFIG_NF_CONNTRACK_PROCFS=y
CONFIG_NF_CONNTRACK_EVENTS=y
CONFIG_NF_CONNTRACK_TIMEOUT=y
CONFIG_NF_CONNTRACK_TIMESTAMP=y
CONFIG_NF_CONNTRACK_LABELS=y
CONFIG_NF_CT_PROTO_DCCP=y
CONFIG_NF_CT_PROTO_GRE=y
CONFIG_NF_CT_PROTO_SCTP=y
CONFIG_NF_CT_PROTO_UDPLITE=y
CONFIG_NF_CONNTRACK_AMANDA=m
CONFIG_NF_CONNTRACK_FTP=m
CONFIG_NF_CONNTRACK_H323=m
CONFIG_NF_CONNTRACK_IRC=m
CONFIG_NF_CONNTRACK_BROADCAST=m
CONFIG_NF_CONNTRACK_NETBIOS_NS=m
CONFIG_NF_CONNTRACK_SNMP=m
CONFIG_NF_CONNTRACK_PPTP=m
CONFIG_NF_CONNTRACK_SANE=m
CONFIG_NF_CONNTRACK_SIP=m
CONFIG_NF_CONNTRACK_TFTP=m
CONFIG_NF_CT_NETLINK=m
CONFIG_NF_CT_NETLINK_TIMEOUT=m
CONFIG_NF_CT_NETLINK_HELPER=m
CONFIG_NETFILTER_NETLINK_GLUE_CT=y
CONFIG_NF_NAT=m
CONFIG_NF_NAT_AMANDA=m
CONFIG_NF_NAT_FTP=m
CONFIG_NF_NAT_IRC=m
CONFIG_NF_NAT_SIP=m
CONFIG_NF_NAT_TFTP=m
CONFIG_NF_NAT_REDIRECT=y
CONFIG_NF_NAT_MASQUERADE=y
CONFIG_NETFILTER_SYNPROXY=m
CONFIG_NF_TABLES=m
CONFIG_NF_TABLES_INET=y
CONFIG_NF_TABLES_NETDEV=y
CONFIG_NFT_NUMGEN=m
CONFIG_NFT_CT=m
CONFIG_NFT_COUNTER=m
CONFIG_NFT_CONNLIMIT=m
CONFIG_NFT_LOG=m
CONFIG_NFT_LIMIT=m
CONFIG_NFT_MASQ=m
CONFIG_NFT_REDIR=m
CONFIG_NFT_NAT=m
# CONFIG_NFT_TUNNEL is not set
CONFIG_NFT_OBJREF=m
CONFIG_NFT_QUEUE=m
CONFIG_NFT_QUOTA=m
CONFIG_NFT_REJECT=m
CONFIG_NFT_REJECT_INET=m
CONFIG_NFT_COMPAT=m
CONFIG_NFT_HASH=m
CONFIG_NFT_FIB=m
CONFIG_NFT_FIB_INET=m
# CONFIG_NFT_XFRM is not set
CONFIG_NFT_SOCKET=m
# CONFIG_NFT_OSF is not set
# CONFIG_NFT_TPROXY is not set
# CONFIG_NFT_SYNPROXY is not set
CONFIG_NF_DUP_NETDEV=m
CONFIG_NFT_DUP_NETDEV=m
CONFIG_NFT_FWD_NETDEV=m
CONFIG_NFT_FIB_NETDEV=m
# CONFIG_NF_FLOW_TABLE is not set
CONFIG_NETFILTER_XTABLES=y

#
# Xtables combined modules
#
CONFIG_NETFILTER_XT_MARK=m
CONFIG_NETFILTER_XT_CONNMARK=m
CONFIG_NETFILTER_XT_SET=m

#
# Xtables targets
#
CONFIG_NETFILTER_XT_TARGET_AUDIT=m
CONFIG_NETFILTER_XT_TARGET_CHECKSUM=m
CONFIG_NETFILTER_XT_TARGET_CLASSIFY=m
CONFIG_NETFILTER_XT_TARGET_CONNMARK=m
CONFIG_NETFILTER_XT_TARGET_CONNSECMARK=m
CONFIG_NETFILTER_XT_TARGET_CT=m
CONFIG_NETFILTER_XT_TARGET_DSCP=m
CONFIG_NETFILTER_XT_TARGET_HL=m
CONFIG_NETFILTER_XT_TARGET_HMARK=m
CONFIG_NETFILTER_XT_TARGET_IDLETIMER=m
# CONFIG_NETFILTER_XT_TARGET_LED is not set
CONFIG_NETFILTER_XT_TARGET_LOG=m
CONFIG_NETFILTER_XT_TARGET_MARK=m
CONFIG_NETFILTER_XT_NAT=m
CONFIG_NETFILTER_XT_TARGET_NETMAP=m
CONFIG_NETFILTER_XT_TARGET_NFLOG=m
CONFIG_NETFILTER_XT_TARGET_NFQUEUE=m
CONFIG_NETFILTER_XT_TARGET_NOTRACK=m
CONFIG_NETFILTER_XT_TARGET_RATEEST=m
CONFIG_NETFILTER_XT_TARGET_REDIRECT=m
CONFIG_NETFILTER_XT_TARGET_MASQUERADE=m
CONFIG_NETFILTER_XT_TARGET_TEE=m
CONFIG_NETFILTER_XT_TARGET_TPROXY=m
CONFIG_NETFILTER_XT_TARGET_TRACE=m
CONFIG_NETFILTER_XT_TARGET_SECMARK=m
CONFIG_NETFILTER_XT_TARGET_TCPMSS=m
CONFIG_NETFILTER_XT_TARGET_TCPOPTSTRIP=m

#
# Xtables matches
#
CONFIG_NETFILTER_XT_MATCH_ADDRTYPE=m
CONFIG_NETFILTER_XT_MATCH_BPF=m
CONFIG_NETFILTER_XT_MATCH_CGROUP=m
CONFIG_NETFILTER_XT_MATCH_CLUSTER=m
CONFIG_NETFILTER_XT_MATCH_COMMENT=m
CONFIG_NETFILTER_XT_MATCH_CONNBYTES=m
CONFIG_NETFILTER_XT_MATCH_CONNLABEL=m
CONFIG_NETFILTER_XT_MATCH_CONNLIMIT=m
CONFIG_NETFILTER_XT_MATCH_CONNMARK=m
CONFIG_NETFILTER_XT_MATCH_CONNTRACK=m
CONFIG_NETFILTER_XT_MATCH_CPU=m
CONFIG_NETFILTER_XT_MATCH_DCCP=m
CONFIG_NETFILTER_XT_MATCH_DEVGROUP=m
CONFIG_NETFILTER_XT_MATCH_DSCP=m
CONFIG_NETFILTER_XT_MATCH_ECN=m
CONFIG_NETFILTER_XT_MATCH_ESP=m
CONFIG_NETFILTER_XT_MATCH_HASHLIMIT=m
CONFIG_NETFILTER_XT_MATCH_HELPER=m
CONFIG_NETFILTER_XT_MATCH_HL=m
# CONFIG_NETFILTER_XT_MATCH_IPCOMP is not set
CONFIG_NETFILTER_XT_MATCH_IPRANGE=m
CONFIG_NETFILTER_XT_MATCH_IPVS=m
# CONFIG_NETFILTER_XT_MATCH_L2TP is not set
CONFIG_NETFILTER_XT_MATCH_LENGTH=m
CONFIG_NETFILTER_XT_MATCH_LIMIT=m
CONFIG_NETFILTER_XT_MATCH_MAC=m
CONFIG_NETFILTER_XT_MATCH_MARK=m
CONFIG_NETFILTER_XT_MATCH_MULTIPORT=m
# CONFIG_NETFILTER_XT_MATCH_NFACCT is not set
CONFIG_NETFILTER_XT_MATCH_OSF=m
CONFIG_NETFILTER_XT_MATCH_OWNER=m
CONFIG_NETFILTER_XT_MATCH_POLICY=m
CONFIG_NETFILTER_XT_MATCH_PHYSDEV=m
CONFIG_NETFILTER_XT_MATCH_PKTTYPE=m
CONFIG_NETFILTER_XT_MATCH_QUOTA=m
CONFIG_NETFILTER_XT_MATCH_RATEEST=m
CONFIG_NETFILTER_XT_MATCH_REALM=m
CONFIG_NETFILTER_XT_MATCH_RECENT=m
CONFIG_NETFILTER_XT_MATCH_SCTP=m
CONFIG_NETFILTER_XT_MATCH_SOCKET=m
CONFIG_NETFILTER_XT_MATCH_STATE=m
CONFIG_NETFILTER_XT_MATCH_STATISTIC=m
CONFIG_NETFILTER_XT_MATCH_STRING=m
CONFIG_NETFILTER_XT_MATCH_TCPMSS=m
# CONFIG_NETFILTER_XT_MATCH_TIME is not set
# CONFIG_NETFILTER_XT_MATCH_U32 is not set
# end of Core Netfilter Configuration

CONFIG_IP_SET=m
CONFIG_IP_SET_MAX=256
CONFIG_IP_SET_BITMAP_IP=m
CONFIG_IP_SET_BITMAP_IPMAC=m
CONFIG_IP_SET_BITMAP_PORT=m
CONFIG_IP_SET_HASH_IP=m
CONFIG_IP_SET_HASH_IPMARK=m
CONFIG_IP_SET_HASH_IPPORT=m
CONFIG_IP_SET_HASH_IPPORTIP=m
CONFIG_IP_SET_HASH_IPPORTNET=m
CONFIG_IP_SET_HASH_IPMAC=m
CONFIG_IP_SET_HASH_MAC=m
CONFIG_IP_SET_HASH_NETPORTNET=m
CONFIG_IP_SET_HASH_NET=m
CONFIG_IP_SET_HASH_NETNET=m
CONFIG_IP_SET_HASH_NETPORT=m
CONFIG_IP_SET_HASH_NETIFACE=m
CONFIG_IP_SET_LIST_SET=m
CONFIG_IP_VS=m
CONFIG_IP_VS_IPV6=y
# CONFIG_IP_VS_DEBUG is not set
CONFIG_IP_VS_TAB_BITS=12

#
# IPVS transport protocol load balancing support
#
CONFIG_IP_VS_PROTO_TCP=y
CONFIG_IP_VS_PROTO_UDP=y
CONFIG_IP_VS_PROTO_AH_ESP=y
CONFIG_IP_VS_PROTO_ESP=y
CONFIG_IP_VS_PROTO_AH=y
CONFIG_IP_VS_PROTO_SCTP=y

#
# IPVS scheduler
#
CONFIG_IP_VS_RR=m
CONFIG_IP_VS_WRR=m
CONFIG_IP_VS_LC=m
CONFIG_IP_VS_WLC=m
CONFIG_IP_VS_FO=m
CONFIG_IP_VS_OVF=m
CONFIG_IP_VS_LBLC=m
CONFIG_IP_VS_LBLCR=m
CONFIG_IP_VS_DH=m
CONFIG_IP_VS_SH=m
# CONFIG_IP_VS_MH is not set
CONFIG_IP_VS_SED=m
CONFIG_IP_VS_NQ=m

#
# IPVS SH scheduler
#
CONFIG_IP_VS_SH_TAB_BITS=8

#
# IPVS MH scheduler
#
CONFIG_IP_VS_MH_TAB_INDEX=12

#
# IPVS application helper
#
CONFIG_IP_VS_FTP=m
CONFIG_IP_VS_NFCT=y
CONFIG_IP_VS_PE_SIP=m

#
# IP: Netfilter Configuration
#
CONFIG_NF_DEFRAG_IPV4=m
CONFIG_NF_SOCKET_IPV4=m
CONFIG_NF_TPROXY_IPV4=m
CONFIG_NF_TABLES_IPV4=y
CONFIG_NFT_REJECT_IPV4=m
CONFIG_NFT_DUP_IPV4=m
CONFIG_NFT_FIB_IPV4=m
CONFIG_NF_TABLES_ARP=y
CONFIG_NF_DUP_IPV4=m
CONFIG_NF_LOG_ARP=m
CONFIG_NF_LOG_IPV4=m
CONFIG_NF_REJECT_IPV4=m
CONFIG_NF_NAT_SNMP_BASIC=m
CONFIG_NF_NAT_PPTP=m
CONFIG_NF_NAT_H323=m
CONFIG_IP_NF_IPTABLES=m
CONFIG_IP_NF_MATCH_AH=m
CONFIG_IP_NF_MATCH_ECN=m
CONFIG_IP_NF_MATCH_RPFILTER=m
CONFIG_IP_NF_MATCH_TTL=m
CONFIG_IP_NF_FILTER=m
CONFIG_IP_NF_TARGET_REJECT=m
CONFIG_IP_NF_TARGET_SYNPROXY=m
CONFIG_IP_NF_NAT=m
CONFIG_IP_NF_TARGET_MASQUERADE=m
CONFIG_IP_NF_TARGET_NETMAP=m
CONFIG_IP_NF_TARGET_REDIRECT=m
CONFIG_IP_NF_MANGLE=m
# CONFIG_IP_NF_TARGET_CLUSTERIP is not set
CONFIG_IP_NF_TARGET_ECN=m
CONFIG_IP_NF_TARGET_TTL=m
CONFIG_IP_NF_RAW=m
CONFIG_IP_NF_SECURITY=m
CONFIG_IP_NF_ARPTABLES=m
CONFIG_IP_NF_ARPFILTER=m
CONFIG_IP_NF_ARP_MANGLE=m
# end of IP: Netfilter Configuration

#
# IPv6: Netfilter Configuration
#
CONFIG_NF_SOCKET_IPV6=m
CONFIG_NF_TPROXY_IPV6=m
CONFIG_NF_TABLES_IPV6=y
CONFIG_NFT_REJECT_IPV6=m
CONFIG_NFT_DUP_IPV6=m
CONFIG_NFT_FIB_IPV6=m
CONFIG_NF_DUP_IPV6=m
CONFIG_NF_REJECT_IPV6=m
CONFIG_NF_LOG_IPV6=m
CONFIG_IP6_NF_IPTABLES=m
CONFIG_IP6_NF_MATCH_AH=m
CONFIG_IP6_NF_MATCH_EUI64=m
CONFIG_IP6_NF_MATCH_FRAG=m
CONFIG_IP6_NF_MATCH_OPTS=m
CONFIG_IP6_NF_MATCH_HL=m
CONFIG_IP6_NF_MATCH_IPV6HEADER=m
CONFIG_IP6_NF_MATCH_MH=m
CONFIG_IP6_NF_MATCH_RPFILTER=m
CONFIG_IP6_NF_MATCH_RT=m
# CONFIG_IP6_NF_MATCH_SRH is not set
# CONFIG_IP6_NF_TARGET_HL is not set
CONFIG_IP6_NF_FILTER=m
CONFIG_IP6_NF_TARGET_REJECT=m
CONFIG_IP6_NF_TARGET_SYNPROXY=m
CONFIG_IP6_NF_MANGLE=m
CONFIG_IP6_NF_RAW=m
CONFIG_IP6_NF_SECURITY=m
CONFIG_IP6_NF_NAT=m
CONFIG_IP6_NF_TARGET_MASQUERADE=m
CONFIG_IP6_NF_TARGET_NPT=m
# end of IPv6: Netfilter Configuration

CONFIG_NF_DEFRAG_IPV6=m
CONFIG_NF_TABLES_BRIDGE=m
# CONFIG_NFT_BRIDGE_META is not set
CONFIG_NFT_BRIDGE_REJECT=m
CONFIG_NF_LOG_BRIDGE=m
# CONFIG_NF_CONNTRACK_BRIDGE is not set
CONFIG_BRIDGE_NF_EBTABLES=m
CONFIG_BRIDGE_EBT_BROUTE=m
CONFIG_BRIDGE_EBT_T_FILTER=m
CONFIG_BRIDGE_EBT_T_NAT=m
CONFIG_BRIDGE_EBT_802_3=m
CONFIG_BRIDGE_EBT_AMONG=m
CONFIG_BRIDGE_EBT_ARP=m
CONFIG_BRIDGE_EBT_IP=m
CONFIG_BRIDGE_EBT_IP6=m
CONFIG_BRIDGE_EBT_LIMIT=m
CONFIG_BRIDGE_EBT_MARK=m
CONFIG_BRIDGE_EBT_PKTTYPE=m
CONFIG_BRIDGE_EBT_STP=m
CONFIG_BRIDGE_EBT_VLAN=m
CONFIG_BRIDGE_EBT_ARPREPLY=m
CONFIG_BRIDGE_EBT_DNAT=m
CONFIG_BRIDGE_EBT_MARK_T=m
CONFIG_BRIDGE_EBT_REDIRECT=m
CONFIG_BRIDGE_EBT_SNAT=m
CONFIG_BRIDGE_EBT_LOG=m
CONFIG_BRIDGE_EBT_NFLOG=m
# CONFIG_BPFILTER is not set
# CONFIG_IP_DCCP is not set
CONFIG_IP_SCTP=m
# CONFIG_SCTP_DBG_OBJCNT is not set
# CONFIG_SCTP_DEFAULT_COOKIE_HMAC_MD5 is not set
CONFIG_SCTP_DEFAULT_COOKIE_HMAC_SHA1=y
# CONFIG_SCTP_DEFAULT_COOKIE_HMAC_NONE is not set
CONFIG_SCTP_COOKIE_HMAC_MD5=y
CONFIG_SCTP_COOKIE_HMAC_SHA1=y
CONFIG_INET_SCTP_DIAG=m
# CONFIG_RDS is not set
CONFIG_TIPC=m
# CONFIG_TIPC_MEDIA_IB is not set
CONFIG_TIPC_MEDIA_UDP=y
CONFIG_TIPC_CRYPTO=y
CONFIG_TIPC_DIAG=m
CONFIG_ATM=m
CONFIG_ATM_CLIP=m
# CONFIG_ATM_CLIP_NO_ICMP is not set
CONFIG_ATM_LANE=m
# CONFIG_ATM_MPOA is not set
CONFIG_ATM_BR2684=m
# CONFIG_ATM_BR2684_IPFILTER is not set
CONFIG_L2TP=m
CONFIG_L2TP_DEBUGFS=m
CONFIG_L2TP_V3=y
CONFIG_L2TP_IP=m
CONFIG_L2TP_ETH=m
CONFIG_STP=m
CONFIG_GARP=m
CONFIG_MRP=m
CONFIG_BRIDGE=m
CONFIG_BRIDGE_IGMP_SNOOPING=y
CONFIG_BRIDGE_VLAN_FILTERING=y
# CONFIG_BRIDGE_MRP is not set
CONFIG_HAVE_NET_DSA=y
# CONFIG_NET_DSA is not set
CONFIG_VLAN_8021Q=m
CONFIG_VLAN_8021Q_GVRP=y
CONFIG_VLAN_8021Q_MVRP=y
# CONFIG_DECNET is not set
CONFIG_LLC=m
# CONFIG_LLC2 is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_PHONET is not set
CONFIG_6LOWPAN=m
# CONFIG_6LOWPAN_DEBUGFS is not set
# CONFIG_6LOWPAN_NHC is not set
CONFIG_IEEE802154=m
# CONFIG_IEEE802154_NL802154_EXPERIMENTAL is not set
CONFIG_IEEE802154_SOCKET=m
CONFIG_IEEE802154_6LOWPAN=m
CONFIG_MAC802154=m
CONFIG_NET_SCHED=y

#
# Queueing/Scheduling
#
CONFIG_NET_SCH_CBQ=m
CONFIG_NET_SCH_HTB=m
CONFIG_NET_SCH_HFSC=m
CONFIG_NET_SCH_ATM=m
CONFIG_NET_SCH_PRIO=m
CONFIG_NET_SCH_MULTIQ=m
CONFIG_NET_SCH_RED=m
CONFIG_NET_SCH_SFB=m
CONFIG_NET_SCH_SFQ=m
CONFIG_NET_SCH_TEQL=m
CONFIG_NET_SCH_TBF=m
# CONFIG_NET_SCH_CBS is not set
# CONFIG_NET_SCH_ETF is not set
# CONFIG_NET_SCH_TAPRIO is not set
CONFIG_NET_SCH_GRED=m
CONFIG_NET_SCH_DSMARK=m
CONFIG_NET_SCH_NETEM=m
CONFIG_NET_SCH_DRR=m
CONFIG_NET_SCH_MQPRIO=m
# CONFIG_NET_SCH_SKBPRIO is not set
CONFIG_NET_SCH_CHOKE=m
CONFIG_NET_SCH_QFQ=m
CONFIG_NET_SCH_CODEL=m
CONFIG_NET_SCH_FQ_CODEL=y
# CONFIG_NET_SCH_CAKE is not set
CONFIG_NET_SCH_FQ=m
CONFIG_NET_SCH_HHF=m
CONFIG_NET_SCH_PIE=m
# CONFIG_NET_SCH_FQ_PIE is not set
CONFIG_NET_SCH_INGRESS=m
CONFIG_NET_SCH_PLUG=m
# CONFIG_NET_SCH_ETS is not set
CONFIG_NET_SCH_DEFAULT=y
# CONFIG_DEFAULT_FQ is not set
# CONFIG_DEFAULT_CODEL is not set
CONFIG_DEFAULT_FQ_CODEL=y
# CONFIG_DEFAULT_SFQ is not set
# CONFIG_DEFAULT_PFIFO_FAST is not set
CONFIG_DEFAULT_NET_SCH="fq_codel"

#
# Classification
#
CONFIG_NET_CLS=y
CONFIG_NET_CLS_BASIC=m
CONFIG_NET_CLS_TCINDEX=m
CONFIG_NET_CLS_ROUTE4=m
CONFIG_NET_CLS_FW=m
CONFIG_NET_CLS_U32=m
CONFIG_CLS_U32_PERF=y
CONFIG_CLS_U32_MARK=y
CONFIG_NET_CLS_RSVP=m
CONFIG_NET_CLS_RSVP6=m
CONFIG_NET_CLS_FLOW=m
CONFIG_NET_CLS_CGROUP=y
CONFIG_NET_CLS_BPF=m
CONFIG_NET_CLS_FLOWER=m
CONFIG_NET_CLS_MATCHALL=m
CONFIG_NET_EMATCH=y
CONFIG_NET_EMATCH_STACK=32
CONFIG_NET_EMATCH_CMP=m
CONFIG_NET_EMATCH_NBYTE=m
CONFIG_NET_EMATCH_U32=m
CONFIG_NET_EMATCH_META=m
CONFIG_NET_EMATCH_TEXT=m
# CONFIG_NET_EMATCH_CANID is not set
CONFIG_NET_EMATCH_IPSET=m
# CONFIG_NET_EMATCH_IPT is not set
CONFIG_NET_CLS_ACT=y
CONFIG_NET_ACT_POLICE=m
CONFIG_NET_ACT_GACT=m
CONFIG_GACT_PROB=y
CONFIG_NET_ACT_MIRRED=m
CONFIG_NET_ACT_SAMPLE=m
# CONFIG_NET_ACT_IPT is not set
CONFIG_NET_ACT_NAT=m
CONFIG_NET_ACT_PEDIT=m
CONFIG_NET_ACT_SIMP=m
CONFIG_NET_ACT_SKBEDIT=m
CONFIG_NET_ACT_CSUM=m
# CONFIG_NET_ACT_MPLS is not set
CONFIG_NET_ACT_VLAN=m
CONFIG_NET_ACT_BPF=m
# CONFIG_NET_ACT_CONNMARK is not set
# CONFIG_NET_ACT_CTINFO is not set
CONFIG_NET_ACT_SKBMOD=m
# CONFIG_NET_ACT_IFE is not set
CONFIG_NET_ACT_TUNNEL_KEY=m
# CONFIG_NET_ACT_GATE is not set
# CONFIG_NET_TC_SKB_EXT is not set
CONFIG_NET_SCH_FIFO=y
CONFIG_DCB=y
CONFIG_DNS_RESOLVER=m
# CONFIG_BATMAN_ADV is not set
CONFIG_OPENVSWITCH=m
CONFIG_OPENVSWITCH_GRE=m
CONFIG_VSOCKETS=m
CONFIG_VSOCKETS_DIAG=m
CONFIG_VSOCKETS_LOOPBACK=m
CONFIG_VMWARE_VMCI_VSOCKETS=m
CONFIG_VIRTIO_VSOCKETS=m
CONFIG_VIRTIO_VSOCKETS_COMMON=m
CONFIG_HYPERV_VSOCKETS=m
CONFIG_NETLINK_DIAG=m
CONFIG_MPLS=y
CONFIG_NET_MPLS_GSO=y
CONFIG_MPLS_ROUTING=m
CONFIG_MPLS_IPTUNNEL=m
CONFIG_NET_NSH=y
# CONFIG_HSR is not set
CONFIG_NET_SWITCHDEV=y
CONFIG_NET_L3_MASTER_DEV=y
# CONFIG_QRTR is not set
# CONFIG_NET_NCSI is not set
CONFIG_RPS=y
CONFIG_RFS_ACCEL=y
CONFIG_XPS=y
CONFIG_CGROUP_NET_PRIO=y
CONFIG_CGROUP_NET_CLASSID=y
CONFIG_NET_RX_BUSY_POLL=y
CONFIG_BQL=y
CONFIG_BPF_JIT=y
CONFIG_BPF_STREAM_PARSER=y
CONFIG_NET_FLOW_LIMIT=y

#
# Network testing
#
CONFIG_NET_PKTGEN=m
CONFIG_NET_DROP_MONITOR=y
# end of Network testing
# end of Networking options

# CONFIG_HAMRADIO is not set
CONFIG_CAN=m
CONFIG_CAN_RAW=m
CONFIG_CAN_BCM=m
CONFIG_CAN_GW=m
# CONFIG_CAN_J1939 is not set
# CONFIG_CAN_ISOTP is not set

#
# CAN Device Drivers
#
CONFIG_CAN_VCAN=m
# CONFIG_CAN_VXCAN is not set
CONFIG_CAN_SLCAN=m
CONFIG_CAN_DEV=m
CONFIG_CAN_CALC_BITTIMING=y
# CONFIG_CAN_KVASER_PCIEFD is not set
CONFIG_CAN_C_CAN=m
CONFIG_CAN_C_CAN_PLATFORM=m
CONFIG_CAN_C_CAN_PCI=m
CONFIG_CAN_CC770=m
# CONFIG_CAN_CC770_ISA is not set
CONFIG_CAN_CC770_PLATFORM=m
# CONFIG_CAN_IFI_CANFD is not set
# CONFIG_CAN_M_CAN is not set
# CONFIG_CAN_PEAK_PCIEFD is not set
CONFIG_CAN_SJA1000=m
CONFIG_CAN_EMS_PCI=m
# CONFIG_CAN_F81601 is not set
CONFIG_CAN_KVASER_PCI=m
CONFIG_CAN_PEAK_PCI=m
CONFIG_CAN_PEAK_PCIEC=y
CONFIG_CAN_PLX_PCI=m
# CONFIG_CAN_SJA1000_ISA is not set
CONFIG_CAN_SJA1000_PLATFORM=m
CONFIG_CAN_SOFTING=m

#
# CAN SPI interfaces
#
# CONFIG_CAN_HI311X is not set
# CONFIG_CAN_MCP251X is not set
# CONFIG_CAN_MCP251XFD is not set
# end of CAN SPI interfaces

#
# CAN USB interfaces
#
# CONFIG_CAN_8DEV_USB is not set
# CONFIG_CAN_EMS_USB is not set
# CONFIG_CAN_ESD_USB2 is not set
# CONFIG_CAN_GS_USB is not set
# CONFIG_CAN_KVASER_USB is not set
# CONFIG_CAN_MCBA_USB is not set
# CONFIG_CAN_PEAK_USB is not set
# CONFIG_CAN_UCAN is not set
# end of CAN USB interfaces

# CONFIG_CAN_DEBUG_DEVICES is not set
# end of CAN Device Drivers

CONFIG_BT=m
CONFIG_BT_BREDR=y
CONFIG_BT_RFCOMM=m
CONFIG_BT_RFCOMM_TTY=y
CONFIG_BT_BNEP=m
CONFIG_BT_BNEP_MC_FILTER=y
CONFIG_BT_BNEP_PROTO_FILTER=y
CONFIG_BT_HIDP=m
CONFIG_BT_HS=y
CONFIG_BT_LE=y
# CONFIG_BT_6LOWPAN is not set
# CONFIG_BT_LEDS is not set
# CONFIG_BT_MSFTEXT is not set
CONFIG_BT_DEBUGFS=y
# CONFIG_BT_SELFTEST is not set

#
# Bluetooth device drivers
#
# CONFIG_BT_HCIBTUSB is not set
# CONFIG_BT_HCIBTSDIO is not set
CONFIG_BT_HCIUART=m
CONFIG_BT_HCIUART_H4=y
CONFIG_BT_HCIUART_BCSP=y
CONFIG_BT_HCIUART_ATH3K=y
# CONFIG_BT_HCIUART_INTEL is not set
# CONFIG_BT_HCIUART_AG6XX is not set
# CONFIG_BT_HCIBCM203X is not set
# CONFIG_BT_HCIBPA10X is not set
# CONFIG_BT_HCIBFUSB is not set
CONFIG_BT_HCIVHCI=m
CONFIG_BT_MRVL=m
# CONFIG_BT_MRVL_SDIO is not set
# CONFIG_BT_MTKSDIO is not set
# end of Bluetooth device drivers

# CONFIG_AF_RXRPC is not set
# CONFIG_AF_KCM is not set
CONFIG_STREAM_PARSER=y
CONFIG_FIB_RULES=y
CONFIG_WIRELESS=y
CONFIG_WEXT_CORE=y
CONFIG_WEXT_PROC=y
CONFIG_CFG80211=m
# CONFIG_NL80211_TESTMODE is not set
# CONFIG_CFG80211_DEVELOPER_WARNINGS is not set
CONFIG_CFG80211_REQUIRE_SIGNED_REGDB=y
CONFIG_CFG80211_USE_KERNEL_REGDB_KEYS=y
CONFIG_CFG80211_DEFAULT_PS=y
# CONFIG_CFG80211_DEBUGFS is not set
CONFIG_CFG80211_CRDA_SUPPORT=y
CONFIG_CFG80211_WEXT=y
CONFIG_MAC80211=m
CONFIG_MAC80211_HAS_RC=y
CONFIG_MAC80211_RC_MINSTREL=y
CONFIG_MAC80211_RC_DEFAULT_MINSTREL=y
CONFIG_MAC80211_RC_DEFAULT="minstrel_ht"
CONFIG_MAC80211_MESH=y
CONFIG_MAC80211_LEDS=y
CONFIG_MAC80211_DEBUGFS=y
# CONFIG_MAC80211_MESSAGE_TRACING is not set
# CONFIG_MAC80211_DEBUG_MENU is not set
CONFIG_MAC80211_STA_HASH_MAX_SIZE=0
# CONFIG_WIMAX is not set
CONFIG_RFKILL=m
CONFIG_RFKILL_LEDS=y
CONFIG_RFKILL_INPUT=y
# CONFIG_RFKILL_GPIO is not set
CONFIG_NET_9P=y
CONFIG_NET_9P_VIRTIO=y
# CONFIG_NET_9P_XEN is not set
# CONFIG_NET_9P_RDMA is not set
# CONFIG_NET_9P_DEBUG is not set
# CONFIG_CAIF is not set
CONFIG_CEPH_LIB=m
# CONFIG_CEPH_LIB_PRETTYDEBUG is not set
CONFIG_CEPH_LIB_USE_DNS_RESOLVER=y
# CONFIG_NFC is not set
CONFIG_PSAMPLE=m
# CONFIG_NET_IFE is not set
CONFIG_LWTUNNEL=y
CONFIG_LWTUNNEL_BPF=y
CONFIG_DST_CACHE=y
CONFIG_GRO_CELLS=y
CONFIG_SOCK_VALIDATE_XMIT=y
CONFIG_NET_SOCK_MSG=y
CONFIG_NET_DEVLINK=y
CONFIG_PAGE_POOL=y
CONFIG_FAILOVER=m
CONFIG_ETHTOOL_NETLINK=y
CONFIG_HAVE_EBPF_JIT=y

#
# Device Drivers
#
CONFIG_HAVE_EISA=y
# CONFIG_EISA is not set
CONFIG_HAVE_PCI=y
CONFIG_PCI=y
CONFIG_PCI_DOMAINS=y
CONFIG_PCIEPORTBUS=y
CONFIG_HOTPLUG_PCI_PCIE=y
CONFIG_PCIEAER=y
CONFIG_PCIEAER_INJECT=m
CONFIG_PCIE_ECRC=y
CONFIG_PCIEASPM=y
CONFIG_PCIEASPM_DEFAULT=y
# CONFIG_PCIEASPM_POWERSAVE is not set
# CONFIG_PCIEASPM_POWER_SUPERSAVE is not set
# CONFIG_PCIEASPM_PERFORMANCE is not set
CONFIG_PCIE_PME=y
CONFIG_PCIE_DPC=y
# CONFIG_PCIE_PTM is not set
# CONFIG_PCIE_BW is not set
# CONFIG_PCIE_EDR is not set
CONFIG_PCI_MSI=y
CONFIG_PCI_MSI_IRQ_DOMAIN=y
CONFIG_PCI_QUIRKS=y
# CONFIG_PCI_DEBUG is not set
# CONFIG_PCI_REALLOC_ENABLE_AUTO is not set
CONFIG_PCI_STUB=y
CONFIG_PCI_PF_STUB=m
# CONFIG_XEN_PCIDEV_FRONTEND is not set
CONFIG_PCI_ATS=y
CONFIG_PCI_LOCKLESS_CONFIG=y
CONFIG_PCI_IOV=y
CONFIG_PCI_PRI=y
CONFIG_PCI_PASID=y
# CONFIG_PCI_P2PDMA is not set
CONFIG_PCI_LABEL=y
CONFIG_PCI_HYPERV=m
CONFIG_HOTPLUG_PCI=y
CONFIG_HOTPLUG_PCI_ACPI=y
CONFIG_HOTPLUG_PCI_ACPI_IBM=m
# CONFIG_HOTPLUG_PCI_CPCI is not set
CONFIG_HOTPLUG_PCI_SHPC=y

#
# PCI controller drivers
#
CONFIG_VMD=y
CONFIG_PCI_HYPERV_INTERFACE=m

#
# DesignWare PCI Core Support
#
# CONFIG_PCIE_DW_PLAT_HOST is not set
# CONFIG_PCI_MESON is not set
# end of DesignWare PCI Core Support

#
# Mobiveil PCIe Core Support
#
# end of Mobiveil PCIe Core Support

#
# Cadence PCIe controllers support
#
# end of Cadence PCIe controllers support
# end of PCI controller drivers

#
# PCI Endpoint
#
# CONFIG_PCI_ENDPOINT is not set
# end of PCI Endpoint

#
# PCI switch controller drivers
#
# CONFIG_PCI_SW_SWITCHTEC is not set
# end of PCI switch controller drivers

# CONFIG_PCCARD is not set
# CONFIG_RAPIDIO is not set

#
# Generic Driver Options
#
# CONFIG_UEVENT_HELPER is not set
CONFIG_DEVTMPFS=y
CONFIG_DEVTMPFS_MOUNT=y
CONFIG_STANDALONE=y
CONFIG_PREVENT_FIRMWARE_BUILD=y

#
# Firmware loader
#
CONFIG_FW_LOADER=y
CONFIG_FW_LOADER_PAGED_BUF=y
CONFIG_EXTRA_FIRMWARE=""
CONFIG_FW_LOADER_USER_HELPER=y
# CONFIG_FW_LOADER_USER_HELPER_FALLBACK is not set
# CONFIG_FW_LOADER_COMPRESS is not set
CONFIG_FW_CACHE=y
# end of Firmware loader

CONFIG_ALLOW_DEV_COREDUMP=y
# CONFIG_DEBUG_DRIVER is not set
# CONFIG_DEBUG_DEVRES is not set
# CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
# CONFIG_PM_QOS_KUNIT_TEST is not set
# CONFIG_TEST_ASYNC_DRIVER_PROBE is not set
CONFIG_KUNIT_DRIVER_PE_TEST=y
CONFIG_SYS_HYPERVISOR=y
CONFIG_GENERIC_CPU_AUTOPROBE=y
CONFIG_GENERIC_CPU_VULNERABILITIES=y
CONFIG_REGMAP=y
CONFIG_REGMAP_I2C=m
CONFIG_REGMAP_SPI=m
CONFIG_DMA_SHARED_BUFFER=y
# CONFIG_DMA_FENCE_TRACE is not set
# end of Generic Driver Options

#
# Bus devices
#
# CONFIG_MHI_BUS is not set
# end of Bus devices

CONFIG_CONNECTOR=y
CONFIG_PROC_EVENTS=y
# CONFIG_GNSS is not set
# CONFIG_MTD is not set
# CONFIG_OF is not set
CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
CONFIG_PARPORT_SERIAL=m
# CONFIG_PARPORT_PC_FIFO is not set
# CONFIG_PARPORT_PC_SUPERIO is not set
# CONFIG_PARPORT_AX88796 is not set
CONFIG_PARPORT_1284=y
CONFIG_PNP=y
# CONFIG_PNP_DEBUG_MESSAGES is not set

#
# Protocols
#
CONFIG_PNPACPI=y
CONFIG_BLK_DEV=y
CONFIG_BLK_DEV_NULL_BLK=m
CONFIG_BLK_DEV_NULL_BLK_FAULT_INJECTION=y
# CONFIG_BLK_DEV_FD is not set
CONFIG_CDROM=m
# CONFIG_PARIDE is not set
# CONFIG_BLK_DEV_PCIESSD_MTIP32XX is not set
# CONFIG_ZRAM is not set
# CONFIG_BLK_DEV_UMEM is not set
CONFIG_BLK_DEV_LOOP=m
CONFIG_BLK_DEV_LOOP_MIN_COUNT=0
# CONFIG_BLK_DEV_CRYPTOLOOP is not set
# CONFIG_BLK_DEV_DRBD is not set
CONFIG_BLK_DEV_NBD=m
# CONFIG_BLK_DEV_SKD is not set
# CONFIG_BLK_DEV_SX8 is not set
CONFIG_BLK_DEV_RAM=m
CONFIG_BLK_DEV_RAM_COUNT=16
CONFIG_BLK_DEV_RAM_SIZE=16384
CONFIG_CDROM_PKTCDVD=m
CONFIG_CDROM_PKTCDVD_BUFFERS=8
# CONFIG_CDROM_PKTCDVD_WCACHE is not set
# CONFIG_ATA_OVER_ETH is not set
CONFIG_XEN_BLKDEV_FRONTEND=m
CONFIG_VIRTIO_BLK=m
CONFIG_BLK_DEV_RBD=m
# CONFIG_BLK_DEV_RSXX is not set

#
# NVME Support
#
CONFIG_NVME_CORE=m
CONFIG_BLK_DEV_NVME=m
CONFIG_NVME_MULTIPATH=y
# CONFIG_NVME_HWMON is not set
CONFIG_NVME_FABRICS=m
# CONFIG_NVME_RDMA is not set
CONFIG_NVME_FC=m
# CONFIG_NVME_TCP is not set
CONFIG_NVME_TARGET=m
# CONFIG_NVME_TARGET_PASSTHRU is not set
CONFIG_NVME_TARGET_LOOP=m
# CONFIG_NVME_TARGET_RDMA is not set
CONFIG_NVME_TARGET_FC=m
CONFIG_NVME_TARGET_FCLOOP=m
# CONFIG_NVME_TARGET_TCP is not set
# end of NVME Support

#
# Misc devices
#
CONFIG_SENSORS_LIS3LV02D=m
# CONFIG_AD525X_DPOT is not set
# CONFIG_DUMMY_IRQ is not set
# CONFIG_IBM_ASM is not set
# CONFIG_PHANTOM is not set
CONFIG_TIFM_CORE=m
CONFIG_TIFM_7XX1=m
# CONFIG_ICS932S401 is not set
CONFIG_ENCLOSURE_SERVICES=m
CONFIG_SGI_XP=m
CONFIG_HP_ILO=m
CONFIG_SGI_GRU=m
# CONFIG_SGI_GRU_DEBUG is not set
CONFIG_APDS9802ALS=m
CONFIG_ISL29003=m
CONFIG_ISL29020=m
CONFIG_SENSORS_TSL2550=m
CONFIG_SENSORS_BH1770=m
CONFIG_SENSORS_APDS990X=m
# CONFIG_HMC6352 is not set
# CONFIG_DS1682 is not set
CONFIG_VMWARE_BALLOON=m
# CONFIG_LATTICE_ECP3_CONFIG is not set
# CONFIG_SRAM is not set
# CONFIG_PCI_ENDPOINT_TEST is not set
# CONFIG_XILINX_SDFEC is not set
CONFIG_MISC_RTSX=m
CONFIG_PVPANIC=y
# CONFIG_C2PORT is not set

#
# EEPROM support
#
# CONFIG_EEPROM_AT24 is not set
# CONFIG_EEPROM_AT25 is not set
CONFIG_EEPROM_LEGACY=m
CONFIG_EEPROM_MAX6875=m
CONFIG_EEPROM_93CX6=m
# CONFIG_EEPROM_93XX46 is not set
# CONFIG_EEPROM_IDT_89HPESX is not set
# CONFIG_EEPROM_EE1004 is not set
# end of EEPROM support

CONFIG_CB710_CORE=m
# CONFIG_CB710_DEBUG is not set
CONFIG_CB710_DEBUG_ASSUMPTIONS=y

#
# Texas Instruments shared transport line discipline
#
# CONFIG_TI_ST is not set
# end of Texas Instruments shared transport line discipline

CONFIG_SENSORS_LIS3_I2C=m
CONFIG_ALTERA_STAPL=m
CONFIG_INTEL_MEI=m
CONFIG_INTEL_MEI_ME=m
# CONFIG_INTEL_MEI_TXE is not set
# CONFIG_INTEL_MEI_VIRTIO is not set
# CONFIG_INTEL_MEI_HDCP is not set
CONFIG_VMWARE_VMCI=m
# CONFIG_GENWQE is not set
# CONFIG_ECHO is not set
# CONFIG_MISC_ALCOR_PCI is not set
CONFIG_MISC_RTSX_PCI=m
# CONFIG_MISC_RTSX_USB is not set
# CONFIG_HABANA_AI is not set
# CONFIG_UACCE is not set
# end of Misc devices

CONFIG_HAVE_IDE=y
# CONFIG_IDE is not set

#
# SCSI device support
#
CONFIG_SCSI_MOD=y
CONFIG_RAID_ATTRS=m
CONFIG_SCSI=y
CONFIG_SCSI_DMA=y
CONFIG_SCSI_NETLINK=y
CONFIG_SCSI_PROC_FS=y

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=m
CONFIG_CHR_DEV_ST=m
CONFIG_BLK_DEV_SR=m
CONFIG_CHR_DEV_SG=m
CONFIG_CHR_DEV_SCH=m
CONFIG_SCSI_ENCLOSURE=m
CONFIG_SCSI_CONSTANTS=y
CONFIG_SCSI_LOGGING=y
CONFIG_SCSI_SCAN_ASYNC=y

#
# SCSI Transports
#
CONFIG_SCSI_SPI_ATTRS=m
CONFIG_SCSI_FC_ATTRS=m
CONFIG_SCSI_ISCSI_ATTRS=m
CONFIG_SCSI_SAS_ATTRS=m
CONFIG_SCSI_SAS_LIBSAS=m
CONFIG_SCSI_SAS_ATA=y
CONFIG_SCSI_SAS_HOST_SMP=y
CONFIG_SCSI_SRP_ATTRS=m
# end of SCSI Transports

CONFIG_SCSI_LOWLEVEL=y
# CONFIG_ISCSI_TCP is not set
# CONFIG_ISCSI_BOOT_SYSFS is not set
# CONFIG_SCSI_CXGB3_ISCSI is not set
# CONFIG_SCSI_CXGB4_ISCSI is not set
# CONFIG_SCSI_BNX2_ISCSI is not set
# CONFIG_BE2ISCSI is not set
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_HPSA is not set
# CONFIG_SCSI_3W_9XXX is not set
# CONFIG_SCSI_3W_SAS is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AACRAID is not set
# CONFIG_SCSI_AIC7XXX is not set
# CONFIG_SCSI_AIC79XX is not set
# CONFIG_SCSI_AIC94XX is not set
# CONFIG_SCSI_MVSAS is not set
# CONFIG_SCSI_MVUMI is not set
# CONFIG_SCSI_DPT_I2O is not set
# CONFIG_SCSI_ADVANSYS is not set
# CONFIG_SCSI_ARCMSR is not set
# CONFIG_SCSI_ESAS2R is not set
# CONFIG_MEGARAID_NEWGEN is not set
# CONFIG_MEGARAID_LEGACY is not set
# CONFIG_MEGARAID_SAS is not set
CONFIG_SCSI_MPT3SAS=m
CONFIG_SCSI_MPT2SAS_MAX_SGE=128
CONFIG_SCSI_MPT3SAS_MAX_SGE=128
# CONFIG_SCSI_MPT2SAS is not set
# CONFIG_SCSI_SMARTPQI is not set
# CONFIG_SCSI_UFSHCD is not set
# CONFIG_SCSI_HPTIOP is not set
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_MYRB is not set
# CONFIG_SCSI_MYRS is not set
# CONFIG_VMWARE_PVSCSI is not set
# CONFIG_XEN_SCSI_FRONTEND is not set
CONFIG_HYPERV_STORAGE=m
# CONFIG_LIBFC is not set
# CONFIG_SCSI_SNIC is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_FDOMAIN_PCI is not set
# CONFIG_SCSI_GDTH is not set
CONFIG_SCSI_ISCI=m
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INITIO is not set
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_PPA is not set
# CONFIG_SCSI_IMM is not set
# CONFIG_SCSI_STEX is not set
# CONFIG_SCSI_SYM53C8XX_2 is not set
# CONFIG_SCSI_IPR is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
# CONFIG_SCSI_QLA_FC is not set
# CONFIG_SCSI_QLA_ISCSI is not set
# CONFIG_SCSI_LPFC is not set
# CONFIG_SCSI_DC395x is not set
# CONFIG_SCSI_AM53C974 is not set
# CONFIG_SCSI_WD719X is not set
CONFIG_SCSI_DEBUG=m
# CONFIG_SCSI_PMCRAID is not set
# CONFIG_SCSI_PM8001 is not set
# CONFIG_SCSI_BFA_FC is not set
# CONFIG_SCSI_VIRTIO is not set
# CONFIG_SCSI_CHELSIO_FCOE is not set
CONFIG_SCSI_DH=y
CONFIG_SCSI_DH_RDAC=y
CONFIG_SCSI_DH_HP_SW=y
CONFIG_SCSI_DH_EMC=y
CONFIG_SCSI_DH_ALUA=y
# end of SCSI device support

CONFIG_ATA=m
CONFIG_SATA_HOST=y
CONFIG_PATA_TIMINGS=y
CONFIG_ATA_VERBOSE_ERROR=y
CONFIG_ATA_FORCE=y
CONFIG_ATA_ACPI=y
# CONFIG_SATA_ZPODD is not set
CONFIG_SATA_PMP=y

#
# Controllers with non-SFF native interface
#
CONFIG_SATA_AHCI=m
CONFIG_SATA_MOBILE_LPM_POLICY=0
CONFIG_SATA_AHCI_PLATFORM=m
# CONFIG_SATA_INIC162X is not set
# CONFIG_SATA_ACARD_AHCI is not set
# CONFIG_SATA_SIL24 is not set
CONFIG_ATA_SFF=y

#
# SFF controllers with custom DMA interface
#
# CONFIG_PDC_ADMA is not set
# CONFIG_SATA_QSTOR is not set
# CONFIG_SATA_SX4 is not set
CONFIG_ATA_BMDMA=y

#
# SATA SFF controllers with BMDMA
#
CONFIG_ATA_PIIX=m
# CONFIG_SATA_DWC is not set
# CONFIG_SATA_MV is not set
# CONFIG_SATA_NV is not set
# CONFIG_SATA_PROMISE is not set
# CONFIG_SATA_SIL is not set
# CONFIG_SATA_SIS is not set
# CONFIG_SATA_SVW is not set
# CONFIG_SATA_ULI is not set
# CONFIG_SATA_VIA is not set
# CONFIG_SATA_VITESSE is not set

#
# PATA SFF controllers with BMDMA
#
# CONFIG_PATA_ALI is not set
# CONFIG_PATA_AMD is not set
# CONFIG_PATA_ARTOP is not set
# CONFIG_PATA_ATIIXP is not set
# CONFIG_PATA_ATP867X is not set
# CONFIG_PATA_CMD64X is not set
# CONFIG_PATA_CYPRESS is not set
# CONFIG_PATA_EFAR is not set
# CONFIG_PATA_HPT366 is not set
# CONFIG_PATA_HPT37X is not set
# CONFIG_PATA_HPT3X2N is not set
# CONFIG_PATA_HPT3X3 is not set
# CONFIG_PATA_IT8213 is not set
# CONFIG_PATA_IT821X is not set
# CONFIG_PATA_JMICRON is not set
# CONFIG_PATA_MARVELL is not set
# CONFIG_PATA_NETCELL is not set
# CONFIG_PATA_NINJA32 is not set
# CONFIG_PATA_NS87415 is not set
# CONFIG_PATA_OLDPIIX is not set
# CONFIG_PATA_OPTIDMA is not set
# CONFIG_PATA_PDC2027X is not set
# CONFIG_PATA_PDC_OLD is not set
# CONFIG_PATA_RADISYS is not set
# CONFIG_PATA_RDC is not set
# CONFIG_PATA_SCH is not set
# CONFIG_PATA_SERVERWORKS is not set
# CONFIG_PATA_SIL680 is not set
# CONFIG_PATA_SIS is not set
# CONFIG_PATA_TOSHIBA is not set
# CONFIG_PATA_TRIFLEX is not set
# CONFIG_PATA_VIA is not set
# CONFIG_PATA_WINBOND is not set

#
# PIO-only SFF controllers
#
# CONFIG_PATA_CMD640_PCI is not set
# CONFIG_PATA_MPIIX is not set
# CONFIG_PATA_NS87410 is not set
# CONFIG_PATA_OPTI is not set
# CONFIG_PATA_RZ1000 is not set

#
# Generic fallback / legacy drivers
#
# CONFIG_PATA_ACPI is not set
CONFIG_ATA_GENERIC=m
# CONFIG_PATA_LEGACY is not set
CONFIG_MD=y
CONFIG_BLK_DEV_MD=y
CONFIG_MD_AUTODETECT=y
CONFIG_MD_LINEAR=m
CONFIG_MD_RAID0=m
CONFIG_MD_RAID1=m
CONFIG_MD_RAID10=m
CONFIG_MD_RAID456=m
CONFIG_MD_MULTIPATH=m
CONFIG_MD_FAULTY=m
CONFIG_MD_CLUSTER=m
# CONFIG_BCACHE is not set
CONFIG_BLK_DEV_DM_BUILTIN=y
CONFIG_BLK_DEV_DM=m
CONFIG_DM_DEBUG=y
CONFIG_DM_BUFIO=m
# CONFIG_DM_DEBUG_BLOCK_MANAGER_LOCKING is not set
CONFIG_DM_BIO_PRISON=m
CONFIG_DM_PERSISTENT_DATA=m
# CONFIG_DM_UNSTRIPED is not set
CONFIG_DM_CRYPT=m
CONFIG_DM_SNAPSHOT=m
CONFIG_DM_THIN_PROVISIONING=m
CONFIG_DM_CACHE=m
CONFIG_DM_CACHE_SMQ=m
CONFIG_DM_WRITECACHE=m
# CONFIG_DM_EBS is not set
CONFIG_DM_ERA=m
# CONFIG_DM_CLONE is not set
CONFIG_DM_MIRROR=m
CONFIG_DM_LOG_USERSPACE=m
CONFIG_DM_RAID=m
CONFIG_DM_ZERO=m
CONFIG_DM_MULTIPATH=m
CONFIG_DM_MULTIPATH_QL=m
CONFIG_DM_MULTIPATH_ST=m
# CONFIG_DM_MULTIPATH_HST is not set
CONFIG_DM_DELAY=m
# CONFIG_DM_DUST is not set
CONFIG_DM_UEVENT=y
CONFIG_DM_FLAKEY=m
CONFIG_DM_VERITY=m
# CONFIG_DM_VERITY_VERIFY_ROOTHASH_SIG is not set
# CONFIG_DM_VERITY_FEC is not set
CONFIG_DM_SWITCH=m
CONFIG_DM_LOG_WRITES=m
CONFIG_DM_INTEGRITY=m
# CONFIG_DM_ZONED is not set
CONFIG_TARGET_CORE=m
CONFIG_TCM_IBLOCK=m
CONFIG_TCM_FILEIO=m
CONFIG_TCM_PSCSI=m
CONFIG_TCM_USER2=m
CONFIG_LOOPBACK_TARGET=m
CONFIG_ISCSI_TARGET=m
# CONFIG_SBP_TARGET is not set
# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support
#
CONFIG_FIREWIRE=m
CONFIG_FIREWIRE_OHCI=m
CONFIG_FIREWIRE_SBP2=m
CONFIG_FIREWIRE_NET=m
# CONFIG_FIREWIRE_NOSY is not set
# end of IEEE 1394 (FireWire) support

CONFIG_MACINTOSH_DRIVERS=y
CONFIG_MAC_EMUMOUSEBTN=y
CONFIG_NETDEVICES=y
CONFIG_MII=m
CONFIG_NET_CORE=y
# CONFIG_BONDING is not set
# CONFIG_DUMMY is not set
# CONFIG_WIREGUARD is not set
# CONFIG_EQUALIZER is not set
# CONFIG_NET_FC is not set
# CONFIG_IFB is not set
# CONFIG_NET_TEAM is not set
# CONFIG_MACVLAN is not set
# CONFIG_IPVLAN is not set
# CONFIG_VXLAN is not set
# CONFIG_GENEVE is not set
# CONFIG_BAREUDP is not set
# CONFIG_GTP is not set
# CONFIG_MACSEC is not set
CONFIG_NETCONSOLE=m
CONFIG_NETCONSOLE_DYNAMIC=y
CONFIG_NETPOLL=y
CONFIG_NET_POLL_CONTROLLER=y
CONFIG_TUN=m
# CONFIG_TUN_VNET_CROSS_LE is not set
CONFIG_VETH=m
# CONFIG_VIRTIO_NET is not set
# CONFIG_NLMON is not set
# CONFIG_NET_VRF is not set
# CONFIG_VSOCKMON is not set
# CONFIG_ARCNET is not set
CONFIG_ATM_DRIVERS=y
# CONFIG_ATM_DUMMY is not set
# CONFIG_ATM_TCP is not set
# CONFIG_ATM_LANAI is not set
# CONFIG_ATM_ENI is not set
# CONFIG_ATM_FIRESTREAM is not set
# CONFIG_ATM_ZATM is not set
# CONFIG_ATM_NICSTAR is not set
# CONFIG_ATM_IDT77252 is not set
# CONFIG_ATM_AMBASSADOR is not set
# CONFIG_ATM_HORIZON is not set
# CONFIG_ATM_IA is not set
# CONFIG_ATM_FORE200E is not set
# CONFIG_ATM_HE is not set
# CONFIG_ATM_SOLOS is not set

#
# Distributed Switch Architecture drivers
#
# end of Distributed Switch Architecture drivers

CONFIG_ETHERNET=y
CONFIG_MDIO=y
CONFIG_NET_VENDOR_3COM=y
# CONFIG_VORTEX is not set
# CONFIG_TYPHOON is not set
CONFIG_NET_VENDOR_ADAPTEC=y
# CONFIG_ADAPTEC_STARFIRE is not set
CONFIG_NET_VENDOR_AGERE=y
# CONFIG_ET131X is not set
CONFIG_NET_VENDOR_ALACRITECH=y
# CONFIG_SLICOSS is not set
CONFIG_NET_VENDOR_ALTEON=y
# CONFIG_ACENIC is not set
# CONFIG_ALTERA_TSE is not set
CONFIG_NET_VENDOR_AMAZON=y
# CONFIG_ENA_ETHERNET is not set
CONFIG_NET_VENDOR_AMD=y
# CONFIG_AMD8111_ETH is not set
# CONFIG_PCNET32 is not set
# CONFIG_AMD_XGBE is not set
CONFIG_NET_VENDOR_AQUANTIA=y
# CONFIG_AQTION is not set
CONFIG_NET_VENDOR_ARC=y
CONFIG_NET_VENDOR_ATHEROS=y
# CONFIG_ATL2 is not set
# CONFIG_ATL1 is not set
# CONFIG_ATL1E is not set
# CONFIG_ATL1C is not set
# CONFIG_ALX is not set
# CONFIG_NET_VENDOR_AURORA is not set
CONFIG_NET_VENDOR_BROADCOM=y
# CONFIG_B44 is not set
# CONFIG_BCMGENET is not set
# CONFIG_BNX2 is not set
# CONFIG_CNIC is not set
# CONFIG_TIGON3 is not set
# CONFIG_BNX2X is not set
# CONFIG_SYSTEMPORT is not set
# CONFIG_BNXT is not set
CONFIG_NET_VENDOR_BROCADE=y
# CONFIG_BNA is not set
CONFIG_NET_VENDOR_CADENCE=y
# CONFIG_MACB is not set
CONFIG_NET_VENDOR_CAVIUM=y
# CONFIG_THUNDER_NIC_PF is not set
# CONFIG_THUNDER_NIC_VF is not set
# CONFIG_THUNDER_NIC_BGX is not set
# CONFIG_THUNDER_NIC_RGX is not set
CONFIG_CAVIUM_PTP=y
# CONFIG_LIQUIDIO is not set
# CONFIG_LIQUIDIO_VF is not set
CONFIG_NET_VENDOR_CHELSIO=y
# CONFIG_CHELSIO_T1 is not set
# CONFIG_CHELSIO_T3 is not set
# CONFIG_CHELSIO_T4 is not set
# CONFIG_CHELSIO_T4VF is not set
CONFIG_NET_VENDOR_CISCO=y
# CONFIG_ENIC is not set
CONFIG_NET_VENDOR_CORTINA=y
# CONFIG_CX_ECAT is not set
# CONFIG_DNET is not set
CONFIG_NET_VENDOR_DEC=y
# CONFIG_NET_TULIP is not set
CONFIG_NET_VENDOR_DLINK=y
# CONFIG_DL2K is not set
# CONFIG_SUNDANCE is not set
CONFIG_NET_VENDOR_EMULEX=y
# CONFIG_BE2NET is not set
CONFIG_NET_VENDOR_EZCHIP=y
CONFIG_NET_VENDOR_GOOGLE=y
# CONFIG_GVE is not set
CONFIG_NET_VENDOR_HUAWEI=y
# CONFIG_HINIC is not set
CONFIG_NET_VENDOR_I825XX=y
CONFIG_NET_VENDOR_INTEL=y
# CONFIG_E100 is not set
CONFIG_E1000=y
CONFIG_E1000E=y
CONFIG_E1000E_HWTS=y
CONFIG_IGB=y
CONFIG_IGB_HWMON=y
# CONFIG_IGBVF is not set
# CONFIG_IXGB is not set
CONFIG_IXGBE=y
CONFIG_IXGBE_HWMON=y
# CONFIG_IXGBE_DCB is not set
CONFIG_IXGBE_IPSEC=y
# CONFIG_IXGBEVF is not set
CONFIG_I40E=y
# CONFIG_I40E_DCB is not set
# CONFIG_I40EVF is not set
# CONFIG_ICE is not set
# CONFIG_FM10K is not set
# CONFIG_IGC is not set
# CONFIG_JME is not set
CONFIG_NET_VENDOR_MARVELL=y
# CONFIG_MVMDIO is not set
# CONFIG_SKGE is not set
# CONFIG_SKY2 is not set
# CONFIG_PRESTERA is not set
CONFIG_NET_VENDOR_MELLANOX=y
# CONFIG_MLX4_EN is not set
# CONFIG_MLX5_CORE is not set
# CONFIG_MLXSW_CORE is not set
# CONFIG_MLXFW is not set
CONFIG_NET_VENDOR_MICREL=y
# CONFIG_KS8842 is not set
# CONFIG_KS8851 is not set
# CONFIG_KS8851_MLL is not set
# CONFIG_KSZ884X_PCI is not set
CONFIG_NET_VENDOR_MICROCHIP=y
# CONFIG_ENC28J60 is not set
# CONFIG_ENCX24J600 is not set
# CONFIG_LAN743X is not set
CONFIG_NET_VENDOR_MICROSEMI=y
CONFIG_NET_VENDOR_MYRI=y
# CONFIG_MYRI10GE is not set
# CONFIG_FEALNX is not set
CONFIG_NET_VENDOR_NATSEMI=y
# CONFIG_NATSEMI is not set
# CONFIG_NS83820 is not set
CONFIG_NET_VENDOR_NETERION=y
# CONFIG_S2IO is not set
# CONFIG_VXGE is not set
CONFIG_NET_VENDOR_NETRONOME=y
# CONFIG_NFP is not set
CONFIG_NET_VENDOR_NI=y
# CONFIG_NI_XGE_MANAGEMENT_ENET is not set
CONFIG_NET_VENDOR_8390=y
# CONFIG_NE2K_PCI is not set
CONFIG_NET_VENDOR_NVIDIA=y
# CONFIG_FORCEDETH is not set
CONFIG_NET_VENDOR_OKI=y
# CONFIG_ETHOC is not set
CONFIG_NET_VENDOR_PACKET_ENGINES=y
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
CONFIG_NET_VENDOR_PENSANDO=y
# CONFIG_IONIC is not set
CONFIG_NET_VENDOR_QLOGIC=y
# CONFIG_QLA3XXX is not set
# CONFIG_QLCNIC is not set
# CONFIG_NETXEN_NIC is not set
# CONFIG_QED is not set
CONFIG_NET_VENDOR_QUALCOMM=y
# CONFIG_QCOM_EMAC is not set
# CONFIG_RMNET is not set
CONFIG_NET_VENDOR_RDC=y
# CONFIG_R6040 is not set
CONFIG_NET_VENDOR_REALTEK=y
# CONFIG_ATP is not set
# CONFIG_8139CP is not set
# CONFIG_8139TOO is not set
CONFIG_R8169=y
CONFIG_NET_VENDOR_RENESAS=y
CONFIG_NET_VENDOR_ROCKER=y
# CONFIG_ROCKER is not set
CONFIG_NET_VENDOR_SAMSUNG=y
# CONFIG_SXGBE_ETH is not set
CONFIG_NET_VENDOR_SEEQ=y
CONFIG_NET_VENDOR_SOLARFLARE=y
# CONFIG_SFC is not set
# CONFIG_SFC_FALCON is not set
CONFIG_NET_VENDOR_SILAN=y
# CONFIG_SC92031 is not set
CONFIG_NET_VENDOR_SIS=y
# CONFIG_SIS900 is not set
# CONFIG_SIS190 is not set
CONFIG_NET_VENDOR_SMSC=y
# CONFIG_EPIC100 is not set
# CONFIG_SMSC911X is not set
# CONFIG_SMSC9420 is not set
CONFIG_NET_VENDOR_SOCIONEXT=y
CONFIG_NET_VENDOR_STMICRO=y
# CONFIG_STMMAC_ETH is not set
CONFIG_NET_VENDOR_SUN=y
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNGEM is not set
# CONFIG_CASSINI is not set
# CONFIG_NIU is not set
CONFIG_NET_VENDOR_SYNOPSYS=y
# CONFIG_DWC_XLGMAC is not set
CONFIG_NET_VENDOR_TEHUTI=y
# CONFIG_TEHUTI is not set
CONFIG_NET_VENDOR_TI=y
# CONFIG_TI_CPSW_PHY_SEL is not set
# CONFIG_TLAN is not set
CONFIG_NET_VENDOR_VIA=y
# CONFIG_VIA_RHINE is not set
# CONFIG_VIA_VELOCITY is not set
CONFIG_NET_VENDOR_WIZNET=y
# CONFIG_WIZNET_W5100 is not set
# CONFIG_WIZNET_W5300 is not set
CONFIG_NET_VENDOR_XILINX=y
# CONFIG_XILINX_AXI_EMAC is not set
# CONFIG_XILINX_LL_TEMAC is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_NET_SB1000 is not set
CONFIG_PHYLIB=y
# CONFIG_LED_TRIGGER_PHY is not set
# CONFIG_FIXED_PHY is not set

#
# MII PHY device drivers
#
# CONFIG_AMD_PHY is not set
# CONFIG_ADIN_PHY is not set
# CONFIG_AQUANTIA_PHY is not set
# CONFIG_AX88796B_PHY is not set
# CONFIG_BROADCOM_PHY is not set
# CONFIG_BCM54140_PHY is not set
# CONFIG_BCM7XXX_PHY is not set
# CONFIG_BCM84881_PHY is not set
# CONFIG_BCM87XX_PHY is not set
# CONFIG_CICADA_PHY is not set
# CONFIG_CORTINA_PHY is not set
# CONFIG_DAVICOM_PHY is not set
# CONFIG_ICPLUS_PHY is not set
# CONFIG_LXT_PHY is not set
# CONFIG_INTEL_XWAY_PHY is not set
# CONFIG_LSI_ET1011C_PHY is not set
# CONFIG_MARVELL_PHY is not set
# CONFIG_MARVELL_10G_PHY is not set
# CONFIG_MICREL_PHY is not set
# CONFIG_MICROCHIP_PHY is not set
# CONFIG_MICROCHIP_T1_PHY is not set
# CONFIG_MICROSEMI_PHY is not set
# CONFIG_NATIONAL_PHY is not set
# CONFIG_NXP_TJA11XX_PHY is not set
# CONFIG_QSEMI_PHY is not set
CONFIG_REALTEK_PHY=y
# CONFIG_RENESAS_PHY is not set
# CONFIG_ROCKCHIP_PHY is not set
# CONFIG_SMSC_PHY is not set
# CONFIG_STE10XP is not set
# CONFIG_TERANETICS_PHY is not set
# CONFIG_DP83822_PHY is not set
# CONFIG_DP83TC811_PHY is not set
# CONFIG_DP83848_PHY is not set
# CONFIG_DP83867_PHY is not set
# CONFIG_DP83869_PHY is not set
# CONFIG_VITESSE_PHY is not set
# CONFIG_XILINX_GMII2RGMII is not set
# CONFIG_MICREL_KS8995MA is not set
CONFIG_MDIO_DEVICE=y
CONFIG_MDIO_BUS=y
CONFIG_MDIO_DEVRES=y
# CONFIG_MDIO_BITBANG is not set
# CONFIG_MDIO_BCM_UNIMAC is not set
# CONFIG_MDIO_MVUSB is not set
# CONFIG_MDIO_MSCC_MIIM is not set
# CONFIG_MDIO_THUNDER is not set

#
# MDIO Multiplexers
#

#
# PCS device drivers
#
# CONFIG_PCS_XPCS is not set
# end of PCS device drivers

# CONFIG_PLIP is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set
CONFIG_USB_NET_DRIVERS=y
# CONFIG_USB_CATC is not set
# CONFIG_USB_KAWETH is not set
# CONFIG_USB_PEGASUS is not set
# CONFIG_USB_RTL8150 is not set
CONFIG_USB_RTL8152=m
# CONFIG_USB_LAN78XX is not set
# CONFIG_USB_USBNET is not set
# CONFIG_USB_HSO is not set
# CONFIG_USB_IPHETH is not set
CONFIG_WLAN=y
CONFIG_WLAN_VENDOR_ADMTEK=y
# CONFIG_ADM8211 is not set
CONFIG_WLAN_VENDOR_ATH=y
# CONFIG_ATH_DEBUG is not set
# CONFIG_ATH5K is not set
# CONFIG_ATH5K_PCI is not set
# CONFIG_ATH9K is not set
# CONFIG_ATH9K_HTC is not set
# CONFIG_CARL9170 is not set
# CONFIG_ATH6KL is not set
# CONFIG_AR5523 is not set
# CONFIG_WIL6210 is not set
# CONFIG_ATH10K is not set
# CONFIG_WCN36XX is not set
# CONFIG_ATH11K is not set
CONFIG_WLAN_VENDOR_ATMEL=y
# CONFIG_ATMEL is not set
# CONFIG_AT76C50X_USB is not set
CONFIG_WLAN_VENDOR_BROADCOM=y
# CONFIG_B43 is not set
# CONFIG_B43LEGACY is not set
# CONFIG_BRCMSMAC is not set
# CONFIG_BRCMFMAC is not set
CONFIG_WLAN_VENDOR_CISCO=y
# CONFIG_AIRO is not set
CONFIG_WLAN_VENDOR_INTEL=y
# CONFIG_IPW2100 is not set
# CONFIG_IPW2200 is not set
# CONFIG_IWL4965 is not set
# CONFIG_IWL3945 is not set
# CONFIG_IWLWIFI is not set
CONFIG_WLAN_VENDOR_INTERSIL=y
# CONFIG_HOSTAP is not set
# CONFIG_HERMES is not set
# CONFIG_P54_COMMON is not set
# CONFIG_PRISM54 is not set
CONFIG_WLAN_VENDOR_MARVELL=y
# CONFIG_LIBERTAS is not set
# CONFIG_LIBERTAS_THINFIRM is not set
# CONFIG_MWIFIEX is not set
# CONFIG_MWL8K is not set
CONFIG_WLAN_VENDOR_MEDIATEK=y
# CONFIG_MT7601U is not set
# CONFIG_MT76x0U is not set
# CONFIG_MT76x0E is not set
# CONFIG_MT76x2E is not set
# CONFIG_MT76x2U is not set
# CONFIG_MT7603E is not set
# CONFIG_MT7615E is not set
# CONFIG_MT7663U is not set
# CONFIG_MT7663S is not set
# CONFIG_MT7915E is not set
CONFIG_WLAN_VENDOR_MICROCHIP=y
# CONFIG_WILC1000_SDIO is not set
# CONFIG_WILC1000_SPI is not set
CONFIG_WLAN_VENDOR_RALINK=y
# CONFIG_RT2X00 is not set
CONFIG_WLAN_VENDOR_REALTEK=y
# CONFIG_RTL8180 is not set
# CONFIG_RTL8187 is not set
CONFIG_RTL_CARDS=m
# CONFIG_RTL8192CE is not set
# CONFIG_RTL8192SE is not set
# CONFIG_RTL8192DE is not set
# CONFIG_RTL8723AE is not set
# CONFIG_RTL8723BE is not set
# CONFIG_RTL8188EE is not set
# CONFIG_RTL8192EE is not set
# CONFIG_RTL8821AE is not set
# CONFIG_RTL8192CU is not set
# CONFIG_RTL8XXXU is not set
# CONFIG_RTW88 is not set
CONFIG_WLAN_VENDOR_RSI=y
# CONFIG_RSI_91X is not set
CONFIG_WLAN_VENDOR_ST=y
# CONFIG_CW1200 is not set
CONFIG_WLAN_VENDOR_TI=y
# CONFIG_WL1251 is not set
# CONFIG_WL12XX is not set
# CONFIG_WL18XX is not set
# CONFIG_WLCORE is not set
CONFIG_WLAN_VENDOR_ZYDAS=y
# CONFIG_USB_ZD1201 is not set
# CONFIG_ZD1211RW is not set
CONFIG_WLAN_VENDOR_QUANTENNA=y
# CONFIG_QTNFMAC_PCIE is not set
CONFIG_MAC80211_HWSIM=m
# CONFIG_USB_NET_RNDIS_WLAN is not set
# CONFIG_VIRT_WIFI is not set

#
# Enable WiMAX (Networking options) to see the WiMAX drivers
#
# CONFIG_WAN is not set
CONFIG_IEEE802154_DRIVERS=m
# CONFIG_IEEE802154_FAKELB is not set
# CONFIG_IEEE802154_AT86RF230 is not set
# CONFIG_IEEE802154_MRF24J40 is not set
# CONFIG_IEEE802154_CC2520 is not set
# CONFIG_IEEE802154_ATUSB is not set
# CONFIG_IEEE802154_ADF7242 is not set
# CONFIG_IEEE802154_CA8210 is not set
# CONFIG_IEEE802154_MCR20A is not set
# CONFIG_IEEE802154_HWSIM is not set
CONFIG_XEN_NETDEV_FRONTEND=y
# CONFIG_VMXNET3 is not set
# CONFIG_FUJITSU_ES is not set
# CONFIG_HYPERV_NET is not set
CONFIG_NETDEVSIM=m
# CONFIG_NET_FAILOVER is not set
# CONFIG_ISDN is not set
# CONFIG_NVM is not set

#
# Input device support
#
CONFIG_INPUT=y
CONFIG_INPUT_LEDS=y
CONFIG_INPUT_FF_MEMLESS=m
CONFIG_INPUT_POLLDEV=m
CONFIG_INPUT_SPARSEKMAP=m
# CONFIG_INPUT_MATRIXKMAP is not set

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
# CONFIG_INPUT_MOUSEDEV_PSAUX is not set
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_INPUT_JOYDEV=m
CONFIG_INPUT_EVDEV=y
# CONFIG_INPUT_EVBUG is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
# CONFIG_KEYBOARD_ADP5588 is not set
# CONFIG_KEYBOARD_ADP5589 is not set
# CONFIG_KEYBOARD_APPLESPI is not set
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_QT1050 is not set
# CONFIG_KEYBOARD_QT1070 is not set
# CONFIG_KEYBOARD_QT2160 is not set
# CONFIG_KEYBOARD_DLINK_DIR685 is not set
# CONFIG_KEYBOARD_LKKBD is not set
# CONFIG_KEYBOARD_GPIO is not set
# CONFIG_KEYBOARD_GPIO_POLLED is not set
# CONFIG_KEYBOARD_TCA6416 is not set
# CONFIG_KEYBOARD_TCA8418 is not set
# CONFIG_KEYBOARD_MATRIX is not set
# CONFIG_KEYBOARD_LM8323 is not set
# CONFIG_KEYBOARD_LM8333 is not set
# CONFIG_KEYBOARD_MAX7359 is not set
# CONFIG_KEYBOARD_MCS is not set
# CONFIG_KEYBOARD_MPR121 is not set
# CONFIG_KEYBOARD_NEWTON is not set
# CONFIG_KEYBOARD_OPENCORES is not set
# CONFIG_KEYBOARD_SAMSUNG is not set
# CONFIG_KEYBOARD_STOWAWAY is not set
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_TM2_TOUCHKEY is not set
# CONFIG_KEYBOARD_XTKBD is not set
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
CONFIG_MOUSE_PS2_ALPS=y
CONFIG_MOUSE_PS2_BYD=y
CONFIG_MOUSE_PS2_LOGIPS2PP=y
CONFIG_MOUSE_PS2_SYNAPTICS=y
CONFIG_MOUSE_PS2_SYNAPTICS_SMBUS=y
CONFIG_MOUSE_PS2_CYPRESS=y
CONFIG_MOUSE_PS2_LIFEBOOK=y
CONFIG_MOUSE_PS2_TRACKPOINT=y
CONFIG_MOUSE_PS2_ELANTECH=y
CONFIG_MOUSE_PS2_ELANTECH_SMBUS=y
CONFIG_MOUSE_PS2_SENTELIC=y
# CONFIG_MOUSE_PS2_TOUCHKIT is not set
CONFIG_MOUSE_PS2_FOCALTECH=y
CONFIG_MOUSE_PS2_VMMOUSE=y
CONFIG_MOUSE_PS2_SMBUS=y
CONFIG_MOUSE_SERIAL=m
# CONFIG_MOUSE_APPLETOUCH is not set
# CONFIG_MOUSE_BCM5974 is not set
CONFIG_MOUSE_CYAPA=m
CONFIG_MOUSE_ELAN_I2C=m
CONFIG_MOUSE_ELAN_I2C_I2C=y
CONFIG_MOUSE_ELAN_I2C_SMBUS=y
CONFIG_MOUSE_VSXXXAA=m
# CONFIG_MOUSE_GPIO is not set
CONFIG_MOUSE_SYNAPTICS_I2C=m
# CONFIG_MOUSE_SYNAPTICS_USB is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TABLET is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
# CONFIG_INPUT_MISC is not set
CONFIG_RMI4_CORE=m
CONFIG_RMI4_I2C=m
CONFIG_RMI4_SPI=m
CONFIG_RMI4_SMB=m
CONFIG_RMI4_F03=y
CONFIG_RMI4_F03_SERIO=m
CONFIG_RMI4_2D_SENSOR=y
CONFIG_RMI4_F11=y
CONFIG_RMI4_F12=y
CONFIG_RMI4_F30=y
CONFIG_RMI4_F34=y
# CONFIG_RMI4_F3A is not set
# CONFIG_RMI4_F54 is not set
CONFIG_RMI4_F55=y

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PARKBD is not set
# CONFIG_SERIO_PCIPS2 is not set
CONFIG_SERIO_LIBPS2=y
CONFIG_SERIO_RAW=m
CONFIG_SERIO_ALTERA_PS2=m
# CONFIG_SERIO_PS2MULT is not set
CONFIG_SERIO_ARC_PS2=m
CONFIG_HYPERV_KEYBOARD=m
# CONFIG_SERIO_GPIO_PS2 is not set
# CONFIG_USERIO is not set
# CONFIG_GAMEPORT is not set
# end of Hardware I/O ports
# end of Input device support

#
# Character devices
#
CONFIG_TTY=y
CONFIG_VT=y
CONFIG_CONSOLE_TRANSLATIONS=y
CONFIG_VT_CONSOLE=y
CONFIG_VT_CONSOLE_SLEEP=y
CONFIG_HW_CONSOLE=y
CONFIG_VT_HW_CONSOLE_BINDING=y
CONFIG_UNIX98_PTYS=y
# CONFIG_LEGACY_PTYS is not set
CONFIG_LDISC_AUTOLOAD=y

#
# Serial drivers
#
CONFIG_SERIAL_EARLYCON=y
CONFIG_SERIAL_8250=y
# CONFIG_SERIAL_8250_DEPRECATED_OPTIONS is not set
CONFIG_SERIAL_8250_PNP=y
# CONFIG_SERIAL_8250_16550A_VARIANTS is not set
# CONFIG_SERIAL_8250_FINTEK is not set
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_DMA=y
CONFIG_SERIAL_8250_PCI=y
CONFIG_SERIAL_8250_EXAR=y
CONFIG_SERIAL_8250_NR_UARTS=64
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
CONFIG_SERIAL_8250_EXTENDED=y
CONFIG_SERIAL_8250_MANY_PORTS=y
CONFIG_SERIAL_8250_SHARE_IRQ=y
# CONFIG_SERIAL_8250_DETECT_IRQ is not set
CONFIG_SERIAL_8250_RSA=y
CONFIG_SERIAL_8250_DWLIB=y
CONFIG_SERIAL_8250_DW=y
# CONFIG_SERIAL_8250_RT288X is not set
CONFIG_SERIAL_8250_LPSS=y
CONFIG_SERIAL_8250_MID=y

#
# Non-8250 serial port support
#
# CONFIG_SERIAL_MAX3100 is not set
# CONFIG_SERIAL_MAX310X is not set
# CONFIG_SERIAL_UARTLITE is not set
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
CONFIG_SERIAL_JSM=m
# CONFIG_SERIAL_LANTIQ is not set
# CONFIG_SERIAL_SCCNXP is not set
# CONFIG_SERIAL_SC16IS7XX is not set
# CONFIG_SERIAL_ALTERA_JTAGUART is not set
# CONFIG_SERIAL_ALTERA_UART is not set
# CONFIG_SERIAL_IFX6X60 is not set
CONFIG_SERIAL_ARC=m
CONFIG_SERIAL_ARC_NR_PORTS=1
# CONFIG_SERIAL_RP2 is not set
# CONFIG_SERIAL_FSL_LPUART is not set
# CONFIG_SERIAL_FSL_LINFLEXUART is not set
# CONFIG_SERIAL_SPRD is not set
# end of Serial drivers

CONFIG_SERIAL_MCTRL_GPIO=y
CONFIG_SERIAL_NONSTANDARD=y
# CONFIG_ROCKETPORT is not set
CONFIG_CYCLADES=m
# CONFIG_CYZ_INTR is not set
# CONFIG_MOXA_INTELLIO is not set
# CONFIG_MOXA_SMARTIO is not set
CONFIG_SYNCLINK=m
CONFIG_SYNCLINKMP=m
CONFIG_SYNCLINK_GT=m
# CONFIG_ISI is not set
CONFIG_N_HDLC=m
CONFIG_N_GSM=m
CONFIG_NOZOMI=m
# CONFIG_NULL_TTY is not set
# CONFIG_TRACE_SINK is not set
CONFIG_HVC_DRIVER=y
CONFIG_HVC_IRQ=y
CONFIG_HVC_XEN=y
CONFIG_HVC_XEN_FRONTEND=y
# CONFIG_SERIAL_DEV_BUS is not set
CONFIG_PRINTER=m
# CONFIG_LP_CONSOLE is not set
CONFIG_PPDEV=m
CONFIG_VIRTIO_CONSOLE=m
CONFIG_IPMI_HANDLER=m
CONFIG_IPMI_DMI_DECODE=y
CONFIG_IPMI_PLAT_DATA=y
CONFIG_IPMI_PANIC_EVENT=y
CONFIG_IPMI_PANIC_STRING=y
CONFIG_IPMI_DEVICE_INTERFACE=m
CONFIG_IPMI_SI=m
CONFIG_IPMI_SSIF=m
CONFIG_IPMI_WATCHDOG=m
CONFIG_IPMI_POWEROFF=m
CONFIG_HW_RANDOM=y
CONFIG_HW_RANDOM_TIMERIOMEM=m
CONFIG_HW_RANDOM_INTEL=m
CONFIG_HW_RANDOM_AMD=m
# CONFIG_HW_RANDOM_BA431 is not set
CONFIG_HW_RANDOM_VIA=m
CONFIG_HW_RANDOM_VIRTIO=y
# CONFIG_HW_RANDOM_XIPHERA is not set
# CONFIG_APPLICOM is not set
# CONFIG_MWAVE is not set
CONFIG_DEVMEM=y
# CONFIG_DEVKMEM is not set
CONFIG_NVRAM=y
CONFIG_RAW_DRIVER=y
CONFIG_MAX_RAW_DEVS=8192
CONFIG_DEVPORT=y
CONFIG_HPET=y
CONFIG_HPET_MMAP=y
# CONFIG_HPET_MMAP_DEFAULT is not set
CONFIG_HANGCHECK_TIMER=m
CONFIG_UV_MMTIMER=m
CONFIG_TCG_TPM=y
CONFIG_HW_RANDOM_TPM=y
CONFIG_TCG_TIS_CORE=y
CONFIG_TCG_TIS=y
# CONFIG_TCG_TIS_SPI is not set
CONFIG_TCG_TIS_I2C_ATMEL=m
CONFIG_TCG_TIS_I2C_INFINEON=m
CONFIG_TCG_TIS_I2C_NUVOTON=m
CONFIG_TCG_NSC=m
CONFIG_TCG_ATMEL=m
CONFIG_TCG_INFINEON=m
# CONFIG_TCG_XEN is not set
CONFIG_TCG_CRB=y
# CONFIG_TCG_VTPM_PROXY is not set
CONFIG_TCG_TIS_ST33ZP24=m
CONFIG_TCG_TIS_ST33ZP24_I2C=m
# CONFIG_TCG_TIS_ST33ZP24_SPI is not set
CONFIG_TELCLOCK=m
# CONFIG_XILLYBUS is not set
# end of Character devices

# CONFIG_RANDOM_TRUST_CPU is not set
# CONFIG_RANDOM_TRUST_BOOTLOADER is not set

#
# I2C support
#
CONFIG_I2C=y
CONFIG_ACPI_I2C_OPREGION=y
CONFIG_I2C_BOARDINFO=y
CONFIG_I2C_COMPAT=y
CONFIG_I2C_CHARDEV=m
CONFIG_I2C_MUX=m

#
# Multiplexer I2C Chip support
#
# CONFIG_I2C_MUX_GPIO is not set
# CONFIG_I2C_MUX_LTC4306 is not set
# CONFIG_I2C_MUX_PCA9541 is not set
# CONFIG_I2C_MUX_PCA954x is not set
# CONFIG_I2C_MUX_REG is not set
CONFIG_I2C_MUX_MLXCPLD=m
# end of Multiplexer I2C Chip support

CONFIG_I2C_HELPER_AUTO=y
CONFIG_I2C_SMBUS=y
CONFIG_I2C_ALGOBIT=y
CONFIG_I2C_ALGOPCA=m

#
# I2C Hardware Bus support
#

#
# PC SMBus host controller drivers
#
# CONFIG_I2C_ALI1535 is not set
# CONFIG_I2C_ALI1563 is not set
# CONFIG_I2C_ALI15X3 is not set
CONFIG_I2C_AMD756=m
CONFIG_I2C_AMD756_S4882=m
CONFIG_I2C_AMD8111=m
# CONFIG_I2C_AMD_MP2 is not set
CONFIG_I2C_I801=y
CONFIG_I2C_ISCH=m
CONFIG_I2C_ISMT=m
CONFIG_I2C_PIIX4=m
CONFIG_I2C_NFORCE2=m
CONFIG_I2C_NFORCE2_S4985=m
# CONFIG_I2C_NVIDIA_GPU is not set
# CONFIG_I2C_SIS5595 is not set
# CONFIG_I2C_SIS630 is not set
CONFIG_I2C_SIS96X=m
CONFIG_I2C_VIA=m
CONFIG_I2C_VIAPRO=m

#
# ACPI drivers
#
CONFIG_I2C_SCMI=m

#
# I2C system bus drivers (mostly embedded / system-on-chip)
#
# CONFIG_I2C_CBUS_GPIO is not set
CONFIG_I2C_DESIGNWARE_CORE=m
# CONFIG_I2C_DESIGNWARE_SLAVE is not set
CONFIG_I2C_DESIGNWARE_PLATFORM=m
CONFIG_I2C_DESIGNWARE_BAYTRAIL=y
# CONFIG_I2C_DESIGNWARE_PCI is not set
# CONFIG_I2C_EMEV2 is not set
# CONFIG_I2C_GPIO is not set
# CONFIG_I2C_OCORES is not set
CONFIG_I2C_PCA_PLATFORM=m
CONFIG_I2C_SIMTEC=m
# CONFIG_I2C_XILINX is not set

#
# External I2C/SMBus adapter drivers
#
# CONFIG_I2C_DIOLAN_U2C is not set
CONFIG_I2C_PARPORT=m
# CONFIG_I2C_ROBOTFUZZ_OSIF is not set
# CONFIG_I2C_TAOS_EVM is not set
# CONFIG_I2C_TINY_USB is not set

#
# Other I2C/SMBus bus drivers
#
CONFIG_I2C_MLXCPLD=m
# end of I2C Hardware Bus support

CONFIG_I2C_STUB=m
# CONFIG_I2C_SLAVE is not set
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# end of I2C support

# CONFIG_I3C is not set
CONFIG_SPI=y
# CONFIG_SPI_DEBUG is not set
CONFIG_SPI_MASTER=y
# CONFIG_SPI_MEM is not set

#
# SPI Master Controller Drivers
#
# CONFIG_SPI_ALTERA is not set
# CONFIG_SPI_AXI_SPI_ENGINE is not set
# CONFIG_SPI_BITBANG is not set
# CONFIG_SPI_BUTTERFLY is not set
# CONFIG_SPI_CADENCE is not set
# CONFIG_SPI_DESIGNWARE is not set
# CONFIG_SPI_NXP_FLEXSPI is not set
# CONFIG_SPI_GPIO is not set
# CONFIG_SPI_LM70_LLP is not set
# CONFIG_SPI_LANTIQ_SSC is not set
# CONFIG_SPI_OC_TINY is not set
# CONFIG_SPI_PXA2XX is not set
# CONFIG_SPI_ROCKCHIP is not set
# CONFIG_SPI_SC18IS602 is not set
# CONFIG_SPI_SIFIVE is not set
# CONFIG_SPI_MXIC is not set
# CONFIG_SPI_XCOMM is not set
# CONFIG_SPI_XILINX is not set
# CONFIG_SPI_ZYNQMP_GQSPI is not set
# CONFIG_SPI_AMD is not set

#
# SPI Multiplexer support
#
# CONFIG_SPI_MUX is not set

#
# SPI Protocol Masters
#
# CONFIG_SPI_SPIDEV is not set
# CONFIG_SPI_LOOPBACK_TEST is not set
# CONFIG_SPI_TLE62X0 is not set
# CONFIG_SPI_SLAVE is not set
CONFIG_SPI_DYNAMIC=y
# CONFIG_SPMI is not set
# CONFIG_HSI is not set
CONFIG_PPS=y
# CONFIG_PPS_DEBUG is not set

#
# PPS clients support
#
# CONFIG_PPS_CLIENT_KTIMER is not set
CONFIG_PPS_CLIENT_LDISC=m
CONFIG_PPS_CLIENT_PARPORT=m
CONFIG_PPS_CLIENT_GPIO=m

#
# PPS generators support
#

#
# PTP clock support
#
CONFIG_PTP_1588_CLOCK=y
# CONFIG_DP83640_PHY is not set
# CONFIG_PTP_1588_CLOCK_INES is not set
CONFIG_PTP_1588_CLOCK_KVM=m
# CONFIG_PTP_1588_CLOCK_IDT82P33 is not set
# CONFIG_PTP_1588_CLOCK_IDTCM is not set
# CONFIG_PTP_1588_CLOCK_VMW is not set
# end of PTP clock support

CONFIG_PINCTRL=y
CONFIG_PINMUX=y
CONFIG_PINCONF=y
CONFIG_GENERIC_PINCONF=y
# CONFIG_DEBUG_PINCTRL is not set
CONFIG_PINCTRL_AMD=m
# CONFIG_PINCTRL_MCP23S08 is not set
# CONFIG_PINCTRL_SX150X is not set
CONFIG_PINCTRL_BAYTRAIL=y
# CONFIG_PINCTRL_CHERRYVIEW is not set
# CONFIG_PINCTRL_LYNXPOINT is not set
CONFIG_PINCTRL_INTEL=y
CONFIG_PINCTRL_BROXTON=m
CONFIG_PINCTRL_CANNONLAKE=m
CONFIG_PINCTRL_CEDARFORK=m
CONFIG_PINCTRL_DENVERTON=m
# CONFIG_PINCTRL_EMMITSBURG is not set
CONFIG_PINCTRL_GEMINILAKE=m
# CONFIG_PINCTRL_ICELAKE is not set
# CONFIG_PINCTRL_JASPERLAKE is not set
CONFIG_PINCTRL_LEWISBURG=m
CONFIG_PINCTRL_SUNRISEPOINT=m
# CONFIG_PINCTRL_TIGERLAKE is not set

#
# Renesas pinctrl drivers
#
# end of Renesas pinctrl drivers

CONFIG_GPIOLIB=y
CONFIG_GPIOLIB_FASTPATH_LIMIT=512
CONFIG_GPIO_ACPI=y
CONFIG_GPIOLIB_IRQCHIP=y
# CONFIG_DEBUG_GPIO is not set
CONFIG_GPIO_SYSFS=y
CONFIG_GPIO_CDEV=y
CONFIG_GPIO_CDEV_V1=y
CONFIG_GPIO_GENERIC=m

#
# Memory mapped GPIO drivers
#
CONFIG_GPIO_AMDPT=m
# CONFIG_GPIO_DWAPB is not set
# CONFIG_GPIO_EXAR is not set
# CONFIG_GPIO_GENERIC_PLATFORM is not set
CONFIG_GPIO_ICH=m
# CONFIG_GPIO_MB86S7X is not set
# CONFIG_GPIO_VX855 is not set
# CONFIG_GPIO_XILINX is not set
# CONFIG_GPIO_AMD_FCH is not set
# end of Memory mapped GPIO drivers

#
# Port-mapped I/O GPIO drivers
#
# CONFIG_GPIO_F7188X is not set
# CONFIG_GPIO_IT87 is not set
# CONFIG_GPIO_SCH is not set
# CONFIG_GPIO_SCH311X is not set
# CONFIG_GPIO_WINBOND is not set
# CONFIG_GPIO_WS16C48 is not set
# end of Port-mapped I/O GPIO drivers

#
# I2C GPIO expanders
#
# CONFIG_GPIO_ADP5588 is not set
# CONFIG_GPIO_MAX7300 is not set
# CONFIG_GPIO_MAX732X is not set
# CONFIG_GPIO_PCA953X is not set
# CONFIG_GPIO_PCA9570 is not set
# CONFIG_GPIO_PCF857X is not set
# CONFIG_GPIO_TPIC2810 is not set
# end of I2C GPIO expanders

#
# MFD GPIO expanders
#
# end of MFD GPIO expanders

#
# PCI GPIO expanders
#
# CONFIG_GPIO_AMD8111 is not set
# CONFIG_GPIO_BT8XX is not set
# CONFIG_GPIO_ML_IOH is not set
# CONFIG_GPIO_PCI_IDIO_16 is not set
# CONFIG_GPIO_PCIE_IDIO_24 is not set
# CONFIG_GPIO_RDC321X is not set
# end of PCI GPIO expanders

#
# SPI GPIO expanders
#
# CONFIG_GPIO_MAX3191X is not set
# CONFIG_GPIO_MAX7301 is not set
# CONFIG_GPIO_MC33880 is not set
# CONFIG_GPIO_PISOSR is not set
# CONFIG_GPIO_XRA1403 is not set
# end of SPI GPIO expanders

#
# USB GPIO expanders
#
# end of USB GPIO expanders

# CONFIG_GPIO_AGGREGATOR is not set
# CONFIG_GPIO_MOCKUP is not set
# CONFIG_W1 is not set
CONFIG_POWER_RESET=y
# CONFIG_POWER_RESET_RESTART is not set
CONFIG_POWER_SUPPLY=y
# CONFIG_POWER_SUPPLY_DEBUG is not set
CONFIG_POWER_SUPPLY_HWMON=y
# CONFIG_PDA_POWER is not set
# CONFIG_TEST_POWER is not set
# CONFIG_CHARGER_ADP5061 is not set
# CONFIG_BATTERY_CW2015 is not set
# CONFIG_BATTERY_DS2780 is not set
# CONFIG_BATTERY_DS2781 is not set
# CONFIG_BATTERY_DS2782 is not set
# CONFIG_BATTERY_SBS is not set
# CONFIG_CHARGER_SBS is not set
# CONFIG_MANAGER_SBS is not set
# CONFIG_BATTERY_BQ27XXX is not set
# CONFIG_BATTERY_MAX17040 is not set
# CONFIG_BATTERY_MAX17042 is not set
# CONFIG_CHARGER_MAX8903 is not set
# CONFIG_CHARGER_LP8727 is not set
# CONFIG_CHARGER_GPIO is not set
# CONFIG_CHARGER_LT3651 is not set
# CONFIG_CHARGER_BQ2415X is not set
# CONFIG_CHARGER_BQ24257 is not set
# CONFIG_CHARGER_BQ24735 is not set
# CONFIG_CHARGER_BQ2515X is not set
# CONFIG_CHARGER_BQ25890 is not set
# CONFIG_CHARGER_BQ25980 is not set
CONFIG_CHARGER_SMB347=m
# CONFIG_BATTERY_GAUGE_LTC2941 is not set
# CONFIG_CHARGER_RT9455 is not set
# CONFIG_CHARGER_BD99954 is not set
CONFIG_HWMON=y
CONFIG_HWMON_VID=m
# CONFIG_HWMON_DEBUG_CHIP is not set

#
# Native drivers
#
CONFIG_SENSORS_ABITUGURU=m
CONFIG_SENSORS_ABITUGURU3=m
# CONFIG_SENSORS_AD7314 is not set
CONFIG_SENSORS_AD7414=m
CONFIG_SENSORS_AD7418=m
CONFIG_SENSORS_ADM1021=m
CONFIG_SENSORS_ADM1025=m
CONFIG_SENSORS_ADM1026=m
CONFIG_SENSORS_ADM1029=m
CONFIG_SENSORS_ADM1031=m
# CONFIG_SENSORS_ADM1177 is not set
CONFIG_SENSORS_ADM9240=m
CONFIG_SENSORS_ADT7X10=m
# CONFIG_SENSORS_ADT7310 is not set
CONFIG_SENSORS_ADT7410=m
CONFIG_SENSORS_ADT7411=m
CONFIG_SENSORS_ADT7462=m
CONFIG_SENSORS_ADT7470=m
CONFIG_SENSORS_ADT7475=m
# CONFIG_SENSORS_AS370 is not set
CONFIG_SENSORS_ASC7621=m
# CONFIG_SENSORS_AXI_FAN_CONTROL is not set
CONFIG_SENSORS_K8TEMP=m
CONFIG_SENSORS_K10TEMP=m
CONFIG_SENSORS_FAM15H_POWER=m
# CONFIG_SENSORS_AMD_ENERGY is not set
CONFIG_SENSORS_APPLESMC=m
CONFIG_SENSORS_ASB100=m
# CONFIG_SENSORS_ASPEED is not set
CONFIG_SENSORS_ATXP1=m
# CONFIG_SENSORS_CORSAIR_CPRO is not set
# CONFIG_SENSORS_DRIVETEMP is not set
CONFIG_SENSORS_DS620=m
CONFIG_SENSORS_DS1621=m
CONFIG_SENSORS_DELL_SMM=m
CONFIG_SENSORS_I5K_AMB=m
CONFIG_SENSORS_F71805F=m
CONFIG_SENSORS_F71882FG=m
CONFIG_SENSORS_F75375S=m
CONFIG_SENSORS_FSCHMD=m
# CONFIG_SENSORS_FTSTEUTATES is not set
CONFIG_SENSORS_GL518SM=m
CONFIG_SENSORS_GL520SM=m
CONFIG_SENSORS_G760A=m
# CONFIG_SENSORS_G762 is not set
# CONFIG_SENSORS_HIH6130 is not set
CONFIG_SENSORS_IBMAEM=m
CONFIG_SENSORS_IBMPEX=m
CONFIG_SENSORS_I5500=m
CONFIG_SENSORS_CORETEMP=m
CONFIG_SENSORS_IT87=m
CONFIG_SENSORS_JC42=m
# CONFIG_SENSORS_POWR1220 is not set
CONFIG_SENSORS_LINEAGE=m
# CONFIG_SENSORS_LTC2945 is not set
# CONFIG_SENSORS_LTC2947_I2C is not set
# CONFIG_SENSORS_LTC2947_SPI is not set
# CONFIG_SENSORS_LTC2990 is not set
CONFIG_SENSORS_LTC4151=m
CONFIG_SENSORS_LTC4215=m
# CONFIG_SENSORS_LTC4222 is not set
CONFIG_SENSORS_LTC4245=m
# CONFIG_SENSORS_LTC4260 is not set
CONFIG_SENSORS_LTC4261=m
# CONFIG_SENSORS_MAX1111 is not set
CONFIG_SENSORS_MAX16065=m
CONFIG_SENSORS_MAX1619=m
CONFIG_SENSORS_MAX1668=m
CONFIG_SENSORS_MAX197=m
# CONFIG_SENSORS_MAX31722 is not set
# CONFIG_SENSORS_MAX31730 is not set
# CONFIG_SENSORS_MAX6621 is not set
CONFIG_SENSORS_MAX6639=m
CONFIG_SENSORS_MAX6642=m
CONFIG_SENSORS_MAX6650=m
CONFIG_SENSORS_MAX6697=m
# CONFIG_SENSORS_MAX31790 is not set
CONFIG_SENSORS_MCP3021=m
# CONFIG_SENSORS_MLXREG_FAN is not set
# CONFIG_SENSORS_TC654 is not set
# CONFIG_SENSORS_MR75203 is not set
# CONFIG_SENSORS_ADCXX is not set
CONFIG_SENSORS_LM63=m
# CONFIG_SENSORS_LM70 is not set
CONFIG_SENSORS_LM73=m
CONFIG_SENSORS_LM75=m
CONFIG_SENSORS_LM77=m
CONFIG_SENSORS_LM78=m
CONFIG_SENSORS_LM80=m
CONFIG_SENSORS_LM83=m
CONFIG_SENSORS_LM85=m
CONFIG_SENSORS_LM87=m
CONFIG_SENSORS_LM90=m
CONFIG_SENSORS_LM92=m
CONFIG_SENSORS_LM93=m
CONFIG_SENSORS_LM95234=m
CONFIG_SENSORS_LM95241=m
CONFIG_SENSORS_LM95245=m
CONFIG_SENSORS_PC87360=m
CONFIG_SENSORS_PC87427=m
CONFIG_SENSORS_NTC_THERMISTOR=m
# CONFIG_SENSORS_NCT6683 is not set
CONFIG_SENSORS_NCT6775=m
# CONFIG_SENSORS_NCT7802 is not set
# CONFIG_SENSORS_NCT7904 is not set
# CONFIG_SENSORS_NPCM7XX is not set
CONFIG_SENSORS_PCF8591=m
CONFIG_PMBUS=m
CONFIG_SENSORS_PMBUS=m
# CONFIG_SENSORS_ADM1266 is not set
CONFIG_SENSORS_ADM1275=m
# CONFIG_SENSORS_BEL_PFE is not set
# CONFIG_SENSORS_IBM_CFFPS is not set
# CONFIG_SENSORS_INSPUR_IPSPS is not set
# CONFIG_SENSORS_IR35221 is not set
# CONFIG_SENSORS_IR38064 is not set
# CONFIG_SENSORS_IRPS5401 is not set
# CONFIG_SENSORS_ISL68137 is not set
CONFIG_SENSORS_LM25066=m
CONFIG_SENSORS_LTC2978=m
# CONFIG_SENSORS_LTC3815 is not set
CONFIG_SENSORS_MAX16064=m
# CONFIG_SENSORS_MAX16601 is not set
# CONFIG_SENSORS_MAX20730 is not set
# CONFIG_SENSORS_MAX20751 is not set
# CONFIG_SENSORS_MAX31785 is not set
CONFIG_SENSORS_MAX34440=m
CONFIG_SENSORS_MAX8688=m
# CONFIG_SENSORS_MP2975 is not set
# CONFIG_SENSORS_PXE1610 is not set
# CONFIG_SENSORS_TPS40422 is not set
# CONFIG_SENSORS_TPS53679 is not set
CONFIG_SENSORS_UCD9000=m
CONFIG_SENSORS_UCD9200=m
# CONFIG_SENSORS_XDPE122 is not set
CONFIG_SENSORS_ZL6100=m
CONFIG_SENSORS_SHT15=m
CONFIG_SENSORS_SHT21=m
# CONFIG_SENSORS_SHT3x is not set
# CONFIG_SENSORS_SHTC1 is not set
CONFIG_SENSORS_SIS5595=m
CONFIG_SENSORS_DME1737=m
CONFIG_SENSORS_EMC1403=m
# CONFIG_SENSORS_EMC2103 is not set
CONFIG_SENSORS_EMC6W201=m
CONFIG_SENSORS_SMSC47M1=m
CONFIG_SENSORS_SMSC47M192=m
CONFIG_SENSORS_SMSC47B397=m
CONFIG_SENSORS_SCH56XX_COMMON=m
CONFIG_SENSORS_SCH5627=m
CONFIG_SENSORS_SCH5636=m
# CONFIG_SENSORS_STTS751 is not set
# CONFIG_SENSORS_SMM665 is not set
# CONFIG_SENSORS_ADC128D818 is not set
CONFIG_SENSORS_ADS7828=m
# CONFIG_SENSORS_ADS7871 is not set
CONFIG_SENSORS_AMC6821=m
CONFIG_SENSORS_INA209=m
CONFIG_SENSORS_INA2XX=m
# CONFIG_SENSORS_INA3221 is not set
# CONFIG_SENSORS_TC74 is not set
CONFIG_SENSORS_THMC50=m
CONFIG_SENSORS_TMP102=m
# CONFIG_SENSORS_TMP103 is not set
# CONFIG_SENSORS_TMP108 is not set
CONFIG_SENSORS_TMP401=m
CONFIG_SENSORS_TMP421=m
# CONFIG_SENSORS_TMP513 is not set
CONFIG_SENSORS_VIA_CPUTEMP=m
CONFIG_SENSORS_VIA686A=m
CONFIG_SENSORS_VT1211=m
CONFIG_SENSORS_VT8231=m
# CONFIG_SENSORS_W83773G is not set
CONFIG_SENSORS_W83781D=m
CONFIG_SENSORS_W83791D=m
CONFIG_SENSORS_W83792D=m
CONFIG_SENSORS_W83793=m
CONFIG_SENSORS_W83795=m
# CONFIG_SENSORS_W83795_FANCTRL is not set
CONFIG_SENSORS_W83L785TS=m
CONFIG_SENSORS_W83L786NG=m
CONFIG_SENSORS_W83627HF=m
CONFIG_SENSORS_W83627EHF=m
# CONFIG_SENSORS_XGENE is not set

#
# ACPI drivers
#
CONFIG_SENSORS_ACPI_POWER=m
CONFIG_SENSORS_ATK0110=m
CONFIG_THERMAL=y
# CONFIG_THERMAL_NETLINK is not set
# CONFIG_THERMAL_STATISTICS is not set
CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
CONFIG_THERMAL_HWMON=y
CONFIG_THERMAL_WRITABLE_TRIPS=y
CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE=y
# CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
# CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
CONFIG_THERMAL_GOV_FAIR_SHARE=y
CONFIG_THERMAL_GOV_STEP_WISE=y
CONFIG_THERMAL_GOV_BANG_BANG=y
CONFIG_THERMAL_GOV_USER_SPACE=y
# CONFIG_THERMAL_EMULATION is not set

#
# Intel thermal drivers
#
CONFIG_INTEL_POWERCLAMP=m
CONFIG_X86_PKG_TEMP_THERMAL=m
CONFIG_INTEL_SOC_DTS_IOSF_CORE=m
# CONFIG_INTEL_SOC_DTS_THERMAL is not set

#
# ACPI INT340X thermal drivers
#
CONFIG_INT340X_THERMAL=m
CONFIG_ACPI_THERMAL_REL=m
# CONFIG_INT3406_THERMAL is not set
CONFIG_PROC_THERMAL_MMIO_RAPL=y
# end of ACPI INT340X thermal drivers

CONFIG_INTEL_PCH_THERMAL=m
# end of Intel thermal drivers

CONFIG_WATCHDOG=y
CONFIG_WATCHDOG_CORE=y
# CONFIG_WATCHDOG_NOWAYOUT is not set
CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED=y
CONFIG_WATCHDOG_OPEN_TIMEOUT=0
CONFIG_WATCHDOG_SYSFS=y

#
# Watchdog Pretimeout Governors
#
# CONFIG_WATCHDOG_PRETIMEOUT_GOV is not set

#
# Watchdog Device Drivers
#
CONFIG_SOFT_WATCHDOG=m
CONFIG_WDAT_WDT=m
# CONFIG_XILINX_WATCHDOG is not set
# CONFIG_ZIIRAVE_WATCHDOG is not set
# CONFIG_MLX_WDT is not set
# CONFIG_CADENCE_WATCHDOG is not set
# CONFIG_DW_WATCHDOG is not set
# CONFIG_MAX63XX_WATCHDOG is not set
# CONFIG_ACQUIRE_WDT is not set
# CONFIG_ADVANTECH_WDT is not set
CONFIG_ALIM1535_WDT=m
CONFIG_ALIM7101_WDT=m
# CONFIG_EBC_C384_WDT is not set
CONFIG_F71808E_WDT=m
CONFIG_SP5100_TCO=m
CONFIG_SBC_FITPC2_WATCHDOG=m
# CONFIG_EUROTECH_WDT is not set
CONFIG_IB700_WDT=m
CONFIG_IBMASR=m
# CONFIG_WAFER_WDT is not set
CONFIG_I6300ESB_WDT=y
CONFIG_IE6XX_WDT=m
CONFIG_ITCO_WDT=y
CONFIG_ITCO_VENDOR_SUPPORT=y
CONFIG_IT8712F_WDT=m
CONFIG_IT87_WDT=m
CONFIG_HP_WATCHDOG=m
CONFIG_HPWDT_NMI_DECODING=y
# CONFIG_SC1200_WDT is not set
# CONFIG_PC87413_WDT is not set
CONFIG_NV_TCO=m
# CONFIG_60XX_WDT is not set
# CONFIG_CPU5_WDT is not set
CONFIG_SMSC_SCH311X_WDT=m
# CONFIG_SMSC37B787_WDT is not set
# CONFIG_TQMX86_WDT is not set
CONFIG_VIA_WDT=m
CONFIG_W83627HF_WDT=m
CONFIG_W83877F_WDT=m
CONFIG_W83977F_WDT=m
CONFIG_MACHZ_WDT=m
# CONFIG_SBC_EPX_C3_WATCHDOG is not set
CONFIG_INTEL_MEI_WDT=m
# CONFIG_NI903X_WDT is not set
# CONFIG_NIC7018_WDT is not set
# CONFIG_MEN_A21_WDT is not set
CONFIG_XEN_WDT=m

#
# PCI-based Watchdog Cards
#
CONFIG_PCIPCWATCHDOG=m
CONFIG_WDTPCI=m

#
# USB-based Watchdog Cards
#
# CONFIG_USBPCWATCHDOG is not set
CONFIG_SSB_POSSIBLE=y
# CONFIG_SSB is not set
CONFIG_BCMA_POSSIBLE=y
CONFIG_BCMA=m
CONFIG_BCMA_HOST_PCI_POSSIBLE=y
CONFIG_BCMA_HOST_PCI=y
# CONFIG_BCMA_HOST_SOC is not set
CONFIG_BCMA_DRIVER_PCI=y
CONFIG_BCMA_DRIVER_GMAC_CMN=y
CONFIG_BCMA_DRIVER_GPIO=y
# CONFIG_BCMA_DEBUG is not set

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=y
# CONFIG_MFD_AS3711 is not set
# CONFIG_PMIC_ADP5520 is not set
# CONFIG_MFD_AAT2870_CORE is not set
# CONFIG_MFD_BCM590XX is not set
# CONFIG_MFD_BD9571MWV is not set
# CONFIG_MFD_AXP20X_I2C is not set
# CONFIG_MFD_MADERA is not set
# CONFIG_PMIC_DA903X is not set
# CONFIG_MFD_DA9052_SPI is not set
# CONFIG_MFD_DA9052_I2C is not set
# CONFIG_MFD_DA9055 is not set
# CONFIG_MFD_DA9062 is not set
# CONFIG_MFD_DA9063 is not set
# CONFIG_MFD_DA9150 is not set
# CONFIG_MFD_DLN2 is not set
# CONFIG_MFD_MC13XXX_SPI is not set
# CONFIG_MFD_MC13XXX_I2C is not set
# CONFIG_MFD_MP2629 is not set
# CONFIG_HTC_PASIC3 is not set
# CONFIG_HTC_I2CPLD is not set
# CONFIG_MFD_INTEL_QUARK_I2C_GPIO is not set
CONFIG_LPC_ICH=y
CONFIG_LPC_SCH=m
# CONFIG_INTEL_SOC_PMIC_CHTDC_TI is not set
CONFIG_MFD_INTEL_LPSS=y
CONFIG_MFD_INTEL_LPSS_ACPI=y
CONFIG_MFD_INTEL_LPSS_PCI=y
# CONFIG_MFD_INTEL_PMC_BXT is not set
# CONFIG_MFD_IQS62X is not set
# CONFIG_MFD_JANZ_CMODIO is not set
# CONFIG_MFD_KEMPLD is not set
# CONFIG_MFD_88PM800 is not set
# CONFIG_MFD_88PM805 is not set
# CONFIG_MFD_88PM860X is not set
# CONFIG_MFD_MAX14577 is not set
# CONFIG_MFD_MAX77693 is not set
# CONFIG_MFD_MAX77843 is not set
# CONFIG_MFD_MAX8907 is not set
# CONFIG_MFD_MAX8925 is not set
# CONFIG_MFD_MAX8997 is not set
# CONFIG_MFD_MAX8998 is not set
# CONFIG_MFD_MT6360 is not set
# CONFIG_MFD_MT6397 is not set
# CONFIG_MFD_MENF21BMC is not set
# CONFIG_EZX_PCAP is not set
# CONFIG_MFD_VIPERBOARD is not set
# CONFIG_MFD_RETU is not set
# CONFIG_MFD_PCF50633 is not set
# CONFIG_MFD_RDC321X is not set
# CONFIG_MFD_RT5033 is not set
# CONFIG_MFD_RC5T583 is not set
# CONFIG_MFD_SEC_CORE is not set
# CONFIG_MFD_SI476X_CORE is not set
# CONFIG_MFD_SL28CPLD is not set
CONFIG_MFD_SM501=m
CONFIG_MFD_SM501_GPIO=y
# CONFIG_MFD_SKY81452 is not set
# CONFIG_ABX500_CORE is not set
# CONFIG_MFD_SYSCON is not set
# CONFIG_MFD_TI_AM335X_TSCADC is not set
# CONFIG_MFD_LP3943 is not set
# CONFIG_MFD_LP8788 is not set
# CONFIG_MFD_TI_LMU is not set
# CONFIG_MFD_PALMAS is not set
# CONFIG_TPS6105X is not set
# CONFIG_TPS65010 is not set
# CONFIG_TPS6507X is not set
# CONFIG_MFD_TPS65086 is not set
# CONFIG_MFD_TPS65090 is not set
# CONFIG_MFD_TI_LP873X is not set
# CONFIG_MFD_TPS6586X is not set
# CONFIG_MFD_TPS65910 is not set
# CONFIG_MFD_TPS65912_I2C is not set
# CONFIG_MFD_TPS65912_SPI is not set
# CONFIG_MFD_TPS80031 is not set
# CONFIG_TWL4030_CORE is not set
# CONFIG_TWL6040_CORE is not set
# CONFIG_MFD_WL1273_CORE is not set
# CONFIG_MFD_LM3533 is not set
# CONFIG_MFD_TQMX86 is not set
CONFIG_MFD_VX855=m
# CONFIG_MFD_ARIZONA_I2C is not set
# CONFIG_MFD_ARIZONA_SPI is not set
# CONFIG_MFD_WM8400 is not set
# CONFIG_MFD_WM831X_I2C is not set
# CONFIG_MFD_WM831X_SPI is not set
# CONFIG_MFD_WM8350_I2C is not set
# CONFIG_MFD_WM8994 is not set
# CONFIG_MFD_INTEL_M10_BMC is not set
# end of Multifunction device drivers

# CONFIG_REGULATOR is not set
CONFIG_RC_CORE=m
CONFIG_RC_MAP=m
CONFIG_LIRC=y
CONFIG_RC_DECODERS=y
CONFIG_IR_NEC_DECODER=m
CONFIG_IR_RC5_DECODER=m
CONFIG_IR_RC6_DECODER=m
CONFIG_IR_JVC_DECODER=m
CONFIG_IR_SONY_DECODER=m
CONFIG_IR_SANYO_DECODER=m
# CONFIG_IR_SHARP_DECODER is not set
CONFIG_IR_MCE_KBD_DECODER=m
# CONFIG_IR_XMP_DECODER is not set
CONFIG_IR_IMON_DECODER=m
# CONFIG_IR_RCMM_DECODER is not set
CONFIG_RC_DEVICES=y
# CONFIG_RC_ATI_REMOTE is not set
CONFIG_IR_ENE=m
# CONFIG_IR_IMON is not set
# CONFIG_IR_IMON_RAW is not set
# CONFIG_IR_MCEUSB is not set
CONFIG_IR_ITE_CIR=m
CONFIG_IR_FINTEK=m
CONFIG_IR_NUVOTON=m
# CONFIG_IR_REDRAT3 is not set
# CONFIG_IR_STREAMZAP is not set
CONFIG_IR_WINBOND_CIR=m
# CONFIG_IR_IGORPLUGUSB is not set
# CONFIG_IR_IGUANA is not set
# CONFIG_IR_TTUSBIR is not set
# CONFIG_RC_LOOPBACK is not set
CONFIG_IR_SERIAL=m
CONFIG_IR_SERIAL_TRANSMITTER=y
CONFIG_IR_SIR=m
# CONFIG_RC_XBOX_DVD is not set
# CONFIG_IR_TOY is not set
CONFIG_MEDIA_CEC_SUPPORT=y
# CONFIG_CEC_CH7322 is not set
# CONFIG_CEC_SECO is not set
# CONFIG_USB_PULSE8_CEC is not set
# CONFIG_USB_RAINSHADOW_CEC is not set
CONFIG_MEDIA_SUPPORT=m
# CONFIG_MEDIA_SUPPORT_FILTER is not set
# CONFIG_MEDIA_SUBDRV_AUTOSELECT is not set

#
# Media device types
#
CONFIG_MEDIA_CAMERA_SUPPORT=y
CONFIG_MEDIA_ANALOG_TV_SUPPORT=y
CONFIG_MEDIA_DIGITAL_TV_SUPPORT=y
CONFIG_MEDIA_RADIO_SUPPORT=y
CONFIG_MEDIA_SDR_SUPPORT=y
CONFIG_MEDIA_PLATFORM_SUPPORT=y
CONFIG_MEDIA_TEST_SUPPORT=y
# end of Media device types

#
# Media core support
#
CONFIG_VIDEO_DEV=m
CONFIG_MEDIA_CONTROLLER=y
CONFIG_DVB_CORE=m
# end of Media core support

#
# Video4Linux options
#
CONFIG_VIDEO_V4L2=m
CONFIG_VIDEO_V4L2_I2C=y
CONFIG_VIDEO_V4L2_SUBDEV_API=y
# CONFIG_VIDEO_ADV_DEBUG is not set
# CONFIG_VIDEO_FIXED_MINOR_RANGES is not set
# end of Video4Linux options

#
# Media controller options
#
# CONFIG_MEDIA_CONTROLLER_DVB is not set
# end of Media controller options

#
# Digital TV options
#
# CONFIG_DVB_MMAP is not set
CONFIG_DVB_NET=y
CONFIG_DVB_MAX_ADAPTERS=16
CONFIG_DVB_DYNAMIC_MINORS=y
# CONFIG_DVB_DEMUX_SECTION_LOSS_LOG is not set
# CONFIG_DVB_ULE_DEBUG is not set
# end of Digital TV options

#
# Media drivers
#
# CONFIG_MEDIA_USB_SUPPORT is not set
# CONFIG_MEDIA_PCI_SUPPORT is not set
CONFIG_RADIO_ADAPTERS=y
# CONFIG_RADIO_SI470X is not set
# CONFIG_RADIO_SI4713 is not set
# CONFIG_USB_MR800 is not set
# CONFIG_USB_DSBR is not set
# CONFIG_RADIO_MAXIRADIO is not set
# CONFIG_RADIO_SHARK is not set
# CONFIG_RADIO_SHARK2 is not set
# CONFIG_USB_KEENE is not set
# CONFIG_USB_RAREMONO is not set
# CONFIG_USB_MA901 is not set
# CONFIG_RADIO_TEA5764 is not set
# CONFIG_RADIO_SAA7706H is not set
# CONFIG_RADIO_TEF6862 is not set
# CONFIG_RADIO_WL1273 is not set
CONFIG_VIDEOBUF2_CORE=m
CONFIG_VIDEOBUF2_V4L2=m
CONFIG_VIDEOBUF2_MEMOPS=m
CONFIG_VIDEOBUF2_VMALLOC=m
# CONFIG_V4L_PLATFORM_DRIVERS is not set
# CONFIG_V4L_MEM2MEM_DRIVERS is not set
# CONFIG_DVB_PLATFORM_DRIVERS is not set
# CONFIG_SDR_PLATFORM_DRIVERS is not set

#
# MMC/SDIO DVB adapters
#
# CONFIG_SMS_SDIO_DRV is not set
# CONFIG_V4L_TEST_DRIVERS is not set
# CONFIG_DVB_TEST_DRIVERS is not set

#
# FireWire (IEEE 1394) Adapters
#
# CONFIG_DVB_FIREDTV is not set
# end of Media drivers

#
# Media ancillary drivers
#
CONFIG_MEDIA_ATTACH=y
CONFIG_VIDEO_IR_I2C=m

#
# Audio decoders, processors and mixers
#
# CONFIG_VIDEO_TVAUDIO is not set
# CONFIG_VIDEO_TDA7432 is not set
# CONFIG_VIDEO_TDA9840 is not set
# CONFIG_VIDEO_TEA6415C is not set
# CONFIG_VIDEO_TEA6420 is not set
# CONFIG_VIDEO_MSP3400 is not set
# CONFIG_VIDEO_CS3308 is not set
# CONFIG_VIDEO_CS5345 is not set
# CONFIG_VIDEO_CS53L32A is not set
# CONFIG_VIDEO_TLV320AIC23B is not set
# CONFIG_VIDEO_UDA1342 is not set
# CONFIG_VIDEO_WM8775 is not set
# CONFIG_VIDEO_WM8739 is not set
# CONFIG_VIDEO_VP27SMPX is not set
# CONFIG_VIDEO_SONY_BTF_MPX is not set
# end of Audio decoders, processors and mixers

#
# RDS decoders
#
# CONFIG_VIDEO_SAA6588 is not set
# end of RDS decoders

#
# Video decoders
#
# CONFIG_VIDEO_ADV7180 is not set
# CONFIG_VIDEO_ADV7183 is not set
# CONFIG_VIDEO_ADV7604 is not set
# CONFIG_VIDEO_ADV7842 is not set
# CONFIG_VIDEO_BT819 is not set
# CONFIG_VIDEO_BT856 is not set
# CONFIG_VIDEO_BT866 is not set
# CONFIG_VIDEO_KS0127 is not set
# CONFIG_VIDEO_ML86V7667 is not set
# CONFIG_VIDEO_SAA7110 is not set
# CONFIG_VIDEO_SAA711X is not set
# CONFIG_VIDEO_TC358743 is not set
# CONFIG_VIDEO_TVP514X is not set
# CONFIG_VIDEO_TVP5150 is not set
# CONFIG_VIDEO_TVP7002 is not set
# CONFIG_VIDEO_TW2804 is not set
# CONFIG_VIDEO_TW9903 is not set
# CONFIG_VIDEO_TW9906 is not set
# CONFIG_VIDEO_TW9910 is not set
# CONFIG_VIDEO_VPX3220 is not set

#
# Video and audio decoders
#
# CONFIG_VIDEO_SAA717X is not set
# CONFIG_VIDEO_CX25840 is not set
# end of Video decoders

#
# Video encoders
#
# CONFIG_VIDEO_SAA7127 is not set
# CONFIG_VIDEO_SAA7185 is not set
# CONFIG_VIDEO_ADV7170 is not set
# CONFIG_VIDEO_ADV7175 is not set
# CONFIG_VIDEO_ADV7343 is not set
# CONFIG_VIDEO_ADV7393 is not set
# CONFIG_VIDEO_ADV7511 is not set
# CONFIG_VIDEO_AD9389B is not set
# CONFIG_VIDEO_AK881X is not set
# CONFIG_VIDEO_THS8200 is not set
# end of Video encoders

#
# Video improvement chips
#
# CONFIG_VIDEO_UPD64031A is not set
# CONFIG_VIDEO_UPD64083 is not set
# end of Video improvement chips

#
# Audio/Video compression chips
#
# CONFIG_VIDEO_SAA6752HS is not set
# end of Audio/Video compression chips

#
# SDR tuner chips
#
# CONFIG_SDR_MAX2175 is not set
# end of SDR tuner chips

#
# Miscellaneous helper chips
#
# CONFIG_VIDEO_THS7303 is not set
# CONFIG_VIDEO_M52790 is not set
# CONFIG_VIDEO_I2C is not set
# CONFIG_VIDEO_ST_MIPID02 is not set
# end of Miscellaneous helper chips

#
# Camera sensor devices
#
# CONFIG_VIDEO_HI556 is not set
# CONFIG_VIDEO_IMX214 is not set
# CONFIG_VIDEO_IMX219 is not set
# CONFIG_VIDEO_IMX258 is not set
# CONFIG_VIDEO_IMX274 is not set
# CONFIG_VIDEO_IMX290 is not set
# CONFIG_VIDEO_IMX319 is not set
# CONFIG_VIDEO_IMX355 is not set
# CONFIG_VIDEO_OV2640 is not set
# CONFIG_VIDEO_OV2659 is not set
# CONFIG_VIDEO_OV2680 is not set
# CONFIG_VIDEO_OV2685 is not set
# CONFIG_VIDEO_OV2740 is not set
# CONFIG_VIDEO_OV5647 is not set
# CONFIG_VIDEO_OV6650 is not set
# CONFIG_VIDEO_OV5670 is not set
# CONFIG_VIDEO_OV5675 is not set
# CONFIG_VIDEO_OV5695 is not set
# CONFIG_VIDEO_OV7251 is not set
# CONFIG_VIDEO_OV772X is not set
# CONFIG_VIDEO_OV7640 is not set
# CONFIG_VIDEO_OV7670 is not set
# CONFIG_VIDEO_OV7740 is not set
# CONFIG_VIDEO_OV8856 is not set
# CONFIG_VIDEO_OV9640 is not set
# CONFIG_VIDEO_OV9650 is not set
# CONFIG_VIDEO_OV13858 is not set
# CONFIG_VIDEO_VS6624 is not set
# CONFIG_VIDEO_MT9M001 is not set
# CONFIG_VIDEO_MT9M032 is not set
# CONFIG_VIDEO_MT9M111 is not set
# CONFIG_VIDEO_MT9P031 is not set
# CONFIG_VIDEO_MT9T001 is not set
# CONFIG_VIDEO_MT9T112 is not set
# CONFIG_VIDEO_MT9V011 is not set
# CONFIG_VIDEO_MT9V032 is not set
# CONFIG_VIDEO_MT9V111 is not set
# CONFIG_VIDEO_SR030PC30 is not set
# CONFIG_VIDEO_NOON010PC30 is not set
# CONFIG_VIDEO_M5MOLS is not set
# CONFIG_VIDEO_RDACM20 is not set
# CONFIG_VIDEO_RJ54N1 is not set
# CONFIG_VIDEO_S5K6AA is not set
# CONFIG_VIDEO_S5K6A3 is not set
# CONFIG_VIDEO_S5K4ECGX is not set
# CONFIG_VIDEO_S5K5BAF is not set
# CONFIG_VIDEO_SMIAPP is not set
# CONFIG_VIDEO_ET8EK8 is not set
# CONFIG_VIDEO_S5C73M3 is not set
# end of Camera sensor devices

#
# Lens drivers
#
# CONFIG_VIDEO_AD5820 is not set
# CONFIG_VIDEO_AK7375 is not set
# CONFIG_VIDEO_DW9714 is not set
# CONFIG_VIDEO_DW9768 is not set
# CONFIG_VIDEO_DW9807_VCM is not set
# end of Lens drivers

#
# Flash devices
#
# CONFIG_VIDEO_ADP1653 is not set
# CONFIG_VIDEO_LM3560 is not set
# CONFIG_VIDEO_LM3646 is not set
# end of Flash devices

#
# SPI helper chips
#
# CONFIG_VIDEO_GS1662 is not set
# end of SPI helper chips

#
# Media SPI Adapters
#
CONFIG_CXD2880_SPI_DRV=m
# end of Media SPI Adapters

CONFIG_MEDIA_TUNER=m

#
# Customize TV tuners
#
CONFIG_MEDIA_TUNER_SIMPLE=m
CONFIG_MEDIA_TUNER_TDA18250=m
CONFIG_MEDIA_TUNER_TDA8290=m
CONFIG_MEDIA_TUNER_TDA827X=m
CONFIG_MEDIA_TUNER_TDA18271=m
CONFIG_MEDIA_TUNER_TDA9887=m
CONFIG_MEDIA_TUNER_TEA5761=m
CONFIG_MEDIA_TUNER_TEA5767=m
CONFIG_MEDIA_TUNER_MSI001=m
CONFIG_MEDIA_TUNER_MT20XX=m
CONFIG_MEDIA_TUNER_MT2060=m
CONFIG_MEDIA_TUNER_MT2063=m
CONFIG_MEDIA_TUNER_MT2266=m
CONFIG_MEDIA_TUNER_MT2131=m
CONFIG_MEDIA_TUNER_QT1010=m
CONFIG_MEDIA_TUNER_XC2028=m
CONFIG_MEDIA_TUNER_XC5000=m
CONFIG_MEDIA_TUNER_XC4000=m
CONFIG_MEDIA_TUNER_MXL5005S=m
CONFIG_MEDIA_TUNER_MXL5007T=m
CONFIG_MEDIA_TUNER_MC44S803=m
CONFIG_MEDIA_TUNER_MAX2165=m
CONFIG_MEDIA_TUNER_TDA18218=m
CONFIG_MEDIA_TUNER_FC0011=m
CONFIG_MEDIA_TUNER_FC0012=m
CONFIG_MEDIA_TUNER_FC0013=m
CONFIG_MEDIA_TUNER_TDA18212=m
CONFIG_MEDIA_TUNER_E4000=m
CONFIG_MEDIA_TUNER_FC2580=m
CONFIG_MEDIA_TUNER_M88RS6000T=m
CONFIG_MEDIA_TUNER_TUA9001=m
CONFIG_MEDIA_TUNER_SI2157=m
CONFIG_MEDIA_TUNER_IT913X=m
CONFIG_MEDIA_TUNER_R820T=m
CONFIG_MEDIA_TUNER_MXL301RF=m
CONFIG_MEDIA_TUNER_QM1D1C0042=m
CONFIG_MEDIA_TUNER_QM1D1B0004=m
# end of Customize TV tuners

#
# Customise DVB Frontends
#

#
# Multistandard (satellite) frontends
#
CONFIG_DVB_STB0899=m
CONFIG_DVB_STB6100=m
CONFIG_DVB_STV090x=m
CONFIG_DVB_STV0910=m
CONFIG_DVB_STV6110x=m
CONFIG_DVB_STV6111=m
CONFIG_DVB_MXL5XX=m
CONFIG_DVB_M88DS3103=m

#
# Multistandard (cable + terrestrial) frontends
#
CONFIG_DVB_DRXK=m
CONFIG_DVB_TDA18271C2DD=m
CONFIG_DVB_SI2165=m
CONFIG_DVB_MN88472=m
CONFIG_DVB_MN88473=m

#
# DVB-S (satellite) frontends
#
CONFIG_DVB_CX24110=m
CONFIG_DVB_CX24123=m
CONFIG_DVB_MT312=m
CONFIG_DVB_ZL10036=m
CONFIG_DVB_ZL10039=m
CONFIG_DVB_S5H1420=m
CONFIG_DVB_STV0288=m
CONFIG_DVB_STB6000=m
CONFIG_DVB_STV0299=m
CONFIG_DVB_STV6110=m
CONFIG_DVB_STV0900=m
CONFIG_DVB_TDA8083=m
CONFIG_DVB_TDA10086=m
CONFIG_DVB_TDA8261=m
CONFIG_DVB_VES1X93=m
CONFIG_DVB_TUNER_ITD1000=m
CONFIG_DVB_TUNER_CX24113=m
CONFIG_DVB_TDA826X=m
CONFIG_DVB_TUA6100=m
CONFIG_DVB_CX24116=m
CONFIG_DVB_CX24117=m
CONFIG_DVB_CX24120=m
CONFIG_DVB_SI21XX=m
CONFIG_DVB_TS2020=m
CONFIG_DVB_DS3000=m
CONFIG_DVB_MB86A16=m
CONFIG_DVB_TDA10071=m

#
# DVB-T (terrestrial) frontends
#
CONFIG_DVB_SP8870=m
CONFIG_DVB_SP887X=m
CONFIG_DVB_CX22700=m
CONFIG_DVB_CX22702=m
CONFIG_DVB_S5H1432=m
CONFIG_DVB_DRXD=m
CONFIG_DVB_L64781=m
CONFIG_DVB_TDA1004X=m
CONFIG_DVB_NXT6000=m
CONFIG_DVB_MT352=m
CONFIG_DVB_ZL10353=m
CONFIG_DVB_DIB3000MB=m
CONFIG_DVB_DIB3000MC=m
CONFIG_DVB_DIB7000M=m
CONFIG_DVB_DIB7000P=m
CONFIG_DVB_DIB9000=m
CONFIG_DVB_TDA10048=m
CONFIG_DVB_AF9013=m
CONFIG_DVB_EC100=m
CONFIG_DVB_STV0367=m
CONFIG_DVB_CXD2820R=m
CONFIG_DVB_CXD2841ER=m
CONFIG_DVB_RTL2830=m
CONFIG_DVB_RTL2832=m
CONFIG_DVB_RTL2832_SDR=m
CONFIG_DVB_SI2168=m
CONFIG_DVB_ZD1301_DEMOD=m
CONFIG_DVB_CXD2880=m

#
# DVB-C (cable) frontends
#
CONFIG_DVB_VES1820=m
CONFIG_DVB_TDA10021=m
CONFIG_DVB_TDA10023=m
CONFIG_DVB_STV0297=m

#
# ATSC (North American/Korean Terrestrial/Cable DTV) frontends
#
CONFIG_DVB_NXT200X=m
CONFIG_DVB_OR51211=m
CONFIG_DVB_OR51132=m
CONFIG_DVB_BCM3510=m
CONFIG_DVB_LGDT330X=m
CONFIG_DVB_LGDT3305=m
CONFIG_DVB_LGDT3306A=m
CONFIG_DVB_LG2160=m
CONFIG_DVB_S5H1409=m
CONFIG_DVB_AU8522=m
CONFIG_DVB_AU8522_DTV=m
CONFIG_DVB_AU8522_V4L=m
CONFIG_DVB_S5H1411=m

#
# ISDB-T (terrestrial) frontends
#
CONFIG_DVB_S921=m
CONFIG_DVB_DIB8000=m
CONFIG_DVB_MB86A20S=m

#
# ISDB-S (satellite) & ISDB-T (terrestrial) frontends
#
CONFIG_DVB_TC90522=m
CONFIG_DVB_MN88443X=m

#
# Digital terrestrial only tuners/PLL
#
CONFIG_DVB_PLL=m
CONFIG_DVB_TUNER_DIB0070=m
CONFIG_DVB_TUNER_DIB0090=m

#
# SEC control devices for DVB-S
#
CONFIG_DVB_DRX39XYJ=m
CONFIG_DVB_LNBH25=m
CONFIG_DVB_LNBH29=m
CONFIG_DVB_LNBP21=m
CONFIG_DVB_LNBP22=m
CONFIG_DVB_ISL6405=m
CONFIG_DVB_ISL6421=m
CONFIG_DVB_ISL6423=m
CONFIG_DVB_A8293=m
CONFIG_DVB_LGS8GL5=m
CONFIG_DVB_LGS8GXX=m
CONFIG_DVB_ATBM8830=m
CONFIG_DVB_TDA665x=m
CONFIG_DVB_IX2505V=m
CONFIG_DVB_M88RS2000=m
CONFIG_DVB_AF9033=m
CONFIG_DVB_HORUS3A=m
CONFIG_DVB_ASCOT2E=m
CONFIG_DVB_HELENE=m

#
# Common Interface (EN50221) controller drivers
#
CONFIG_DVB_CXD2099=m
CONFIG_DVB_SP2=m
# end of Customise DVB Frontends

#
# Tools to develop new frontends
#
# CONFIG_DVB_DUMMY_FE is not set
# end of Media ancillary drivers

#
# Graphics support
#
# CONFIG_AGP is not set
CONFIG_INTEL_GTT=m
CONFIG_VGA_ARB=y
CONFIG_VGA_ARB_MAX_GPUS=64
CONFIG_VGA_SWITCHEROO=y
CONFIG_DRM=m
CONFIG_DRM_MIPI_DSI=y
CONFIG_DRM_DP_AUX_CHARDEV=y
# CONFIG_DRM_DEBUG_SELFTEST is not set
CONFIG_DRM_KMS_HELPER=m
CONFIG_DRM_KMS_FB_HELPER=y
CONFIG_DRM_FBDEV_EMULATION=y
CONFIG_DRM_FBDEV_OVERALLOC=100
CONFIG_DRM_LOAD_EDID_FIRMWARE=y
# CONFIG_DRM_DP_CEC is not set
CONFIG_DRM_TTM=m
CONFIG_DRM_TTM_DMA_PAGE_POOL=y
CONFIG_DRM_VRAM_HELPER=m
CONFIG_DRM_TTM_HELPER=m
CONFIG_DRM_GEM_SHMEM_HELPER=y

#
# I2C encoder or helper chips
#
CONFIG_DRM_I2C_CH7006=m
CONFIG_DRM_I2C_SIL164=m
# CONFIG_DRM_I2C_NXP_TDA998X is not set
# CONFIG_DRM_I2C_NXP_TDA9950 is not set
# end of I2C encoder or helper chips

#
# ARM devices
#
# end of ARM devices

# CONFIG_DRM_RADEON is not set
# CONFIG_DRM_AMDGPU is not set
# CONFIG_DRM_NOUVEAU is not set
CONFIG_DRM_I915=m
CONFIG_DRM_I915_FORCE_PROBE=""
CONFIG_DRM_I915_CAPTURE_ERROR=y
CONFIG_DRM_I915_COMPRESS_ERROR=y
CONFIG_DRM_I915_USERPTR=y
CONFIG_DRM_I915_GVT=y
CONFIG_DRM_I915_GVT_KVMGT=m
CONFIG_DRM_I915_FENCE_TIMEOUT=10000
CONFIG_DRM_I915_USERFAULT_AUTOSUSPEND=250
CONFIG_DRM_I915_HEARTBEAT_INTERVAL=2500
CONFIG_DRM_I915_PREEMPT_TIMEOUT=640
CONFIG_DRM_I915_MAX_REQUEST_BUSYWAIT=8000
CONFIG_DRM_I915_STOP_TIMEOUT=100
CONFIG_DRM_I915_TIMESLICE_DURATION=1
# CONFIG_DRM_VGEM is not set
# CONFIG_DRM_VKMS is not set
CONFIG_DRM_VMWGFX=m
CONFIG_DRM_VMWGFX_FBCON=y
CONFIG_DRM_GMA500=m
CONFIG_DRM_GMA600=y
CONFIG_DRM_GMA3600=y
# CONFIG_DRM_UDL is not set
CONFIG_DRM_AST=m
CONFIG_DRM_MGAG200=m
CONFIG_DRM_QXL=m
CONFIG_DRM_BOCHS=m
CONFIG_DRM_VIRTIO_GPU=m
CONFIG_DRM_PANEL=y

#
# Display Panels
#
# CONFIG_DRM_PANEL_RASPBERRYPI_TOUCHSCREEN is not set
# end of Display Panels

CONFIG_DRM_BRIDGE=y
CONFIG_DRM_PANEL_BRIDGE=y

#
# Display Interface Bridges
#
# CONFIG_DRM_ANALOGIX_ANX78XX is not set
# end of Display Interface Bridges

# CONFIG_DRM_ETNAVIV is not set
CONFIG_DRM_CIRRUS_QEMU=m
# CONFIG_DRM_GM12U320 is not set
# CONFIG_TINYDRM_HX8357D is not set
# CONFIG_TINYDRM_ILI9225 is not set
# CONFIG_TINYDRM_ILI9341 is not set
# CONFIG_TINYDRM_ILI9486 is not set
# CONFIG_TINYDRM_MI0283QT is not set
# CONFIG_TINYDRM_REPAPER is not set
# CONFIG_TINYDRM_ST7586 is not set
# CONFIG_TINYDRM_ST7735R is not set
# CONFIG_DRM_XEN is not set
# CONFIG_DRM_VBOXVIDEO is not set
# CONFIG_DRM_LEGACY is not set
CONFIG_DRM_PANEL_ORIENTATION_QUIRKS=y

#
# Frame buffer Devices
#
CONFIG_FB_CMDLINE=y
CONFIG_FB_NOTIFY=y
CONFIG_FB=y
# CONFIG_FIRMWARE_EDID is not set
CONFIG_FB_BOOT_VESA_SUPPORT=y
CONFIG_FB_CFB_FILLRECT=y
CONFIG_FB_CFB_COPYAREA=y
CONFIG_FB_CFB_IMAGEBLIT=y
CONFIG_FB_SYS_FILLRECT=m
CONFIG_FB_SYS_COPYAREA=m
CONFIG_FB_SYS_IMAGEBLIT=m
# CONFIG_FB_FOREIGN_ENDIAN is not set
CONFIG_FB_SYS_FOPS=m
CONFIG_FB_DEFERRED_IO=y
# CONFIG_FB_MODE_HELPERS is not set
CONFIG_FB_TILEBLITTING=y

#
# Frame buffer hardware drivers
#
# CONFIG_FB_CIRRUS is not set
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CYBER2000 is not set
# CONFIG_FB_ARC is not set
# CONFIG_FB_ASILIANT is not set
# CONFIG_FB_IMSTT is not set
# CONFIG_FB_VGA16 is not set
# CONFIG_FB_UVESA is not set
CONFIG_FB_VESA=y
CONFIG_FB_EFI=y
# CONFIG_FB_N411 is not set
# CONFIG_FB_HGA is not set
# CONFIG_FB_OPENCORES is not set
# CONFIG_FB_S1D13XXX is not set
# CONFIG_FB_NVIDIA is not set
# CONFIG_FB_RIVA is not set
# CONFIG_FB_I740 is not set
# CONFIG_FB_LE80578 is not set
# CONFIG_FB_MATROX is not set
# CONFIG_FB_RADEON is not set
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_ATY is not set
# CONFIG_FB_S3 is not set
# CONFIG_FB_SAVAGE is not set
# CONFIG_FB_SIS is not set
# CONFIG_FB_VIA is not set
# CONFIG_FB_NEOMAGIC is not set
# CONFIG_FB_KYRO is not set
# CONFIG_FB_3DFX is not set
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_VT8623 is not set
# CONFIG_FB_TRIDENT is not set
# CONFIG_FB_ARK is not set
# CONFIG_FB_PM3 is not set
# CONFIG_FB_CARMINE is not set
# CONFIG_FB_SM501 is not set
# CONFIG_FB_SMSCUFX is not set
# CONFIG_FB_UDL is not set
# CONFIG_FB_IBM_GXT4500 is not set
# CONFIG_FB_VIRTUAL is not set
# CONFIG_XEN_FBDEV_FRONTEND is not set
# CONFIG_FB_METRONOME is not set
# CONFIG_FB_MB862XX is not set
CONFIG_FB_HYPERV=m
# CONFIG_FB_SIMPLE is not set
# CONFIG_FB_SM712 is not set
# end of Frame buffer Devices

#
# Backlight & LCD device support
#
CONFIG_LCD_CLASS_DEVICE=m
# CONFIG_LCD_L4F00242T03 is not set
# CONFIG_LCD_LMS283GF05 is not set
# CONFIG_LCD_LTV350QV is not set
# CONFIG_LCD_ILI922X is not set
# CONFIG_LCD_ILI9320 is not set
# CONFIG_LCD_TDO24M is not set
# CONFIG_LCD_VGG2432A4 is not set
CONFIG_LCD_PLATFORM=m
# CONFIG_LCD_AMS369FG06 is not set
# CONFIG_LCD_LMS501KF03 is not set
# CONFIG_LCD_HX8357 is not set
# CONFIG_LCD_OTM3225A is not set
CONFIG_BACKLIGHT_CLASS_DEVICE=y
# CONFIG_BACKLIGHT_KTD253 is not set
# CONFIG_BACKLIGHT_PWM is not set
CONFIG_BACKLIGHT_APPLE=m
# CONFIG_BACKLIGHT_QCOM_WLED is not set
# CONFIG_BACKLIGHT_SAHARA is not set
# CONFIG_BACKLIGHT_ADP8860 is not set
# CONFIG_BACKLIGHT_ADP8870 is not set
# CONFIG_BACKLIGHT_LM3630A is not set
# CONFIG_BACKLIGHT_LM3639 is not set
CONFIG_BACKLIGHT_LP855X=m
# CONFIG_BACKLIGHT_GPIO is not set
# CONFIG_BACKLIGHT_LV5207LP is not set
# CONFIG_BACKLIGHT_BD6107 is not set
# CONFIG_BACKLIGHT_ARCXCNN is not set
# end of Backlight & LCD device support

CONFIG_HDMI=y

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_DUMMY_CONSOLE_COLUMNS=80
CONFIG_DUMMY_CONSOLE_ROWS=25
CONFIG_FRAMEBUFFER_CONSOLE=y
CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY=y
CONFIG_FRAMEBUFFER_CONSOLE_ROTATION=y
# CONFIG_FRAMEBUFFER_CONSOLE_DEFERRED_TAKEOVER is not set
# end of Console display driver support

CONFIG_LOGO=y
# CONFIG_LOGO_LINUX_MONO is not set
# CONFIG_LOGO_LINUX_VGA16 is not set
CONFIG_LOGO_LINUX_CLUT224=y
# end of Graphics support

# CONFIG_SOUND is not set

#
# HID support
#
CONFIG_HID=y
CONFIG_HID_BATTERY_STRENGTH=y
CONFIG_HIDRAW=y
CONFIG_UHID=m
CONFIG_HID_GENERIC=y

#
# Special HID drivers
#
CONFIG_HID_A4TECH=m
# CONFIG_HID_ACCUTOUCH is not set
CONFIG_HID_ACRUX=m
# CONFIG_HID_ACRUX_FF is not set
CONFIG_HID_APPLE=m
# CONFIG_HID_APPLEIR is not set
CONFIG_HID_ASUS=m
CONFIG_HID_AUREAL=m
CONFIG_HID_BELKIN=m
# CONFIG_HID_BETOP_FF is not set
# CONFIG_HID_BIGBEN_FF is not set
CONFIG_HID_CHERRY=m
CONFIG_HID_CHICONY=m
# CONFIG_HID_CORSAIR is not set
# CONFIG_HID_COUGAR is not set
# CONFIG_HID_MACALLY is not set
CONFIG_HID_CMEDIA=m
# CONFIG_HID_CP2112 is not set
# CONFIG_HID_CREATIVE_SB0540 is not set
CONFIG_HID_CYPRESS=m
CONFIG_HID_DRAGONRISE=m
# CONFIG_DRAGONRISE_FF is not set
# CONFIG_HID_EMS_FF is not set
# CONFIG_HID_ELAN is not set
CONFIG_HID_ELECOM=m
# CONFIG_HID_ELO is not set
CONFIG_HID_EZKEY=m
CONFIG_HID_GEMBIRD=m
CONFIG_HID_GFRM=m
# CONFIG_HID_GLORIOUS is not set
# CONFIG_HID_HOLTEK is not set
# CONFIG_HID_VIVALDI is not set
# CONFIG_HID_GT683R is not set
CONFIG_HID_KEYTOUCH=m
CONFIG_HID_KYE=m
# CONFIG_HID_UCLOGIC is not set
CONFIG_HID_WALTOP=m
# CONFIG_HID_VIEWSONIC is not set
CONFIG_HID_GYRATION=m
CONFIG_HID_ICADE=m
CONFIG_HID_ITE=m
CONFIG_HID_JABRA=m
CONFIG_HID_TWINHAN=m
CONFIG_HID_KENSINGTON=m
CONFIG_HID_LCPOWER=m
CONFIG_HID_LED=m
CONFIG_HID_LENOVO=m
CONFIG_HID_LOGITECH=m
CONFIG_HID_LOGITECH_DJ=m
CONFIG_HID_LOGITECH_HIDPP=m
# CONFIG_LOGITECH_FF is not set
# CONFIG_LOGIRUMBLEPAD2_FF is not set
# CONFIG_LOGIG940_FF is not set
# CONFIG_LOGIWHEELS_FF is not set
CONFIG_HID_MAGICMOUSE=y
# CONFIG_HID_MALTRON is not set
# CONFIG_HID_MAYFLASH is not set
# CONFIG_HID_REDRAGON is not set
CONFIG_HID_MICROSOFT=m
CONFIG_HID_MONTEREY=m
CONFIG_HID_MULTITOUCH=m
CONFIG_HID_NTI=m
# CONFIG_HID_NTRIG is not set
CONFIG_HID_ORTEK=m
CONFIG_HID_PANTHERLORD=m
# CONFIG_PANTHERLORD_FF is not set
# CONFIG_HID_PENMOUNT is not set
CONFIG_HID_PETALYNX=m
CONFIG_HID_PICOLCD=m
CONFIG_HID_PICOLCD_FB=y
CONFIG_HID_PICOLCD_BACKLIGHT=y
CONFIG_HID_PICOLCD_LCD=y
CONFIG_HID_PICOLCD_LEDS=y
CONFIG_HID_PICOLCD_CIR=y
CONFIG_HID_PLANTRONICS=m
CONFIG_HID_PRIMAX=m
# CONFIG_HID_RETRODE is not set
# CONFIG_HID_ROCCAT is not set
CONFIG_HID_SAITEK=m
CONFIG_HID_SAMSUNG=m
# CONFIG_HID_SONY is not set
CONFIG_HID_SPEEDLINK=m
# CONFIG_HID_STEAM is not set
CONFIG_HID_STEELSERIES=m
CONFIG_HID_SUNPLUS=m
CONFIG_HID_RMI=m
CONFIG_HID_GREENASIA=m
# CONFIG_GREENASIA_FF is not set
CONFIG_HID_HYPERV_MOUSE=m
CONFIG_HID_SMARTJOYPLUS=m
# CONFIG_SMARTJOYPLUS_FF is not set
CONFIG_HID_TIVO=m
CONFIG_HID_TOPSEED=m
CONFIG_HID_THINGM=m
CONFIG_HID_THRUSTMASTER=m
# CONFIG_THRUSTMASTER_FF is not set
# CONFIG_HID_UDRAW_PS3 is not set
# CONFIG_HID_U2FZERO is not set
# CONFIG_HID_WACOM is not set
CONFIG_HID_WIIMOTE=m
CONFIG_HID_XINMO=m
CONFIG_HID_ZEROPLUS=m
# CONFIG_ZEROPLUS_FF is not set
CONFIG_HID_ZYDACRON=m
CONFIG_HID_SENSOR_HUB=y
CONFIG_HID_SENSOR_CUSTOM_SENSOR=m
CONFIG_HID_ALPS=m
# CONFIG_HID_MCP2221 is not set
# end of Special HID drivers

#
# USB HID support
#
CONFIG_USB_HID=y
# CONFIG_HID_PID is not set
# CONFIG_USB_HIDDEV is not set
# end of USB HID support

#
# I2C HID support
#
CONFIG_I2C_HID=m
# end of I2C HID support

#
# Intel ISH HID support
#
CONFIG_INTEL_ISH_HID=m
# CONFIG_INTEL_ISH_FIRMWARE_DOWNLOADER is not set
# end of Intel ISH HID support
# end of HID support

CONFIG_USB_OHCI_LITTLE_ENDIAN=y
CONFIG_USB_SUPPORT=y
CONFIG_USB_COMMON=y
# CONFIG_USB_LED_TRIG is not set
# CONFIG_USB_ULPI_BUS is not set
# CONFIG_USB_CONN_GPIO is not set
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB=y
CONFIG_USB_PCI=y
CONFIG_USB_ANNOUNCE_NEW_DEVICES=y

#
# Miscellaneous USB options
#
CONFIG_USB_DEFAULT_PERSIST=y
# CONFIG_USB_FEW_INIT_RETRIES is not set
# CONFIG_USB_DYNAMIC_MINORS is not set
# CONFIG_USB_OTG is not set
# CONFIG_USB_OTG_PRODUCTLIST is not set
CONFIG_USB_LEDS_TRIGGER_USBPORT=y
CONFIG_USB_AUTOSUSPEND_DELAY=2
CONFIG_USB_MON=y

#
# USB Host Controller Drivers
#
# CONFIG_USB_C67X00_HCD is not set
CONFIG_USB_XHCI_HCD=y
# CONFIG_USB_XHCI_DBGCAP is not set
CONFIG_USB_XHCI_PCI=y
# CONFIG_USB_XHCI_PCI_RENESAS is not set
# CONFIG_USB_XHCI_PLATFORM is not set
CONFIG_USB_EHCI_HCD=y
CONFIG_USB_EHCI_ROOT_HUB_TT=y
CONFIG_USB_EHCI_TT_NEWSCHED=y
CONFIG_USB_EHCI_PCI=y
# CONFIG_USB_EHCI_FSL is not set
# CONFIG_USB_EHCI_HCD_PLATFORM is not set
# CONFIG_USB_OXU210HP_HCD is not set
# CONFIG_USB_ISP116X_HCD is not set
# CONFIG_USB_FOTG210_HCD is not set
# CONFIG_USB_MAX3421_HCD is not set
CONFIG_USB_OHCI_HCD=y
CONFIG_USB_OHCI_HCD_PCI=y
# CONFIG_USB_OHCI_HCD_PLATFORM is not set
CONFIG_USB_UHCI_HCD=y
# CONFIG_USB_SL811_HCD is not set
# CONFIG_USB_R8A66597_HCD is not set
# CONFIG_USB_HCD_BCMA is not set
# CONFIG_USB_HCD_TEST_MODE is not set

#
# USB Device Class drivers
#
# CONFIG_USB_ACM is not set
# CONFIG_USB_PRINTER is not set
# CONFIG_USB_WDM is not set
# CONFIG_USB_TMC is not set

#
# NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
#

#
# also be needed; see USB_STORAGE Help for more info
#
CONFIG_USB_STORAGE=m
# CONFIG_USB_STORAGE_DEBUG is not set
# CONFIG_USB_STORAGE_REALTEK is not set
# CONFIG_USB_STORAGE_DATAFAB is not set
# CONFIG_USB_STORAGE_FREECOM is not set
# CONFIG_USB_STORAGE_ISD200 is not set
# CONFIG_USB_STORAGE_USBAT is not set
# CONFIG_USB_STORAGE_SDDR09 is not set
# CONFIG_USB_STORAGE_SDDR55 is not set
# CONFIG_USB_STORAGE_JUMPSHOT is not set
# CONFIG_USB_STORAGE_ALAUDA is not set
# CONFIG_USB_STORAGE_ONETOUCH is not set
# CONFIG_USB_STORAGE_KARMA is not set
# CONFIG_USB_STORAGE_CYPRESS_ATACB is not set
# CONFIG_USB_STORAGE_ENE_UB6250 is not set
# CONFIG_USB_UAS is not set

#
# USB Imaging devices
#
# CONFIG_USB_MDC800 is not set
# CONFIG_USB_MICROTEK is not set
# CONFIG_USBIP_CORE is not set
# CONFIG_USB_CDNS3 is not set
# CONFIG_USB_MUSB_HDRC is not set
# CONFIG_USB_DWC3 is not set
# CONFIG_USB_DWC2 is not set
# CONFIG_USB_CHIPIDEA is not set
# CONFIG_USB_ISP1760 is not set

#
# USB port drivers
#
# CONFIG_USB_USS720 is not set
CONFIG_USB_SERIAL=m
CONFIG_USB_SERIAL_GENERIC=y
# CONFIG_USB_SERIAL_SIMPLE is not set
# CONFIG_USB_SERIAL_AIRCABLE is not set
# CONFIG_USB_SERIAL_ARK3116 is not set
# CONFIG_USB_SERIAL_BELKIN is not set
# CONFIG_USB_SERIAL_CH341 is not set
# CONFIG_USB_SERIAL_WHITEHEAT is not set
# CONFIG_USB_SERIAL_DIGI_ACCELEPORT is not set
# CONFIG_USB_SERIAL_CP210X is not set
# CONFIG_USB_SERIAL_CYPRESS_M8 is not set
# CONFIG_USB_SERIAL_EMPEG is not set
# CONFIG_USB_SERIAL_FTDI_SIO is not set
# CONFIG_USB_SERIAL_VISOR is not set
# CONFIG_USB_SERIAL_IPAQ is not set
# CONFIG_USB_SERIAL_IR is not set
# CONFIG_USB_SERIAL_EDGEPORT is not set
# CONFIG_USB_SERIAL_EDGEPORT_TI is not set
# CONFIG_USB_SERIAL_F81232 is not set
# CONFIG_USB_SERIAL_F8153X is not set
# CONFIG_USB_SERIAL_GARMIN is not set
# CONFIG_USB_SERIAL_IPW is not set
# CONFIG_USB_SERIAL_IUU is not set
# CONFIG_USB_SERIAL_KEYSPAN_PDA is not set
# CONFIG_USB_SERIAL_KEYSPAN is not set
# CONFIG_USB_SERIAL_KLSI is not set
# CONFIG_USB_SERIAL_KOBIL_SCT is not set
# CONFIG_USB_SERIAL_MCT_U232 is not set
# CONFIG_USB_SERIAL_METRO is not set
# CONFIG_USB_SERIAL_MOS7720 is not set
# CONFIG_USB_SERIAL_MOS7840 is not set
# CONFIG_USB_SERIAL_MXUPORT is not set
# CONFIG_USB_SERIAL_NAVMAN is not set
# CONFIG_USB_SERIAL_PL2303 is not set
# CONFIG_USB_SERIAL_OTI6858 is not set
# CONFIG_USB_SERIAL_QCAUX is not set
# CONFIG_USB_SERIAL_QUALCOMM is not set
# CONFIG_USB_SERIAL_SPCP8X5 is not set
# CONFIG_USB_SERIAL_SAFE is not set
# CONFIG_USB_SERIAL_SIERRAWIRELESS is not set
# CONFIG_USB_SERIAL_SYMBOL is not set
# CONFIG_USB_SERIAL_TI is not set
# CONFIG_USB_SERIAL_CYBERJACK is not set
# CONFIG_USB_SERIAL_XIRCOM is not set
# CONFIG_USB_SERIAL_OPTION is not set
# CONFIG_USB_SERIAL_OMNINET is not set
# CONFIG_USB_SERIAL_OPTICON is not set
# CONFIG_USB_SERIAL_XSENS_MT is not set
# CONFIG_USB_SERIAL_WISHBONE is not set
# CONFIG_USB_SERIAL_SSU100 is not set
# CONFIG_USB_SERIAL_QT2 is not set
# CONFIG_USB_SERIAL_UPD78F0730 is not set
CONFIG_USB_SERIAL_DEBUG=m

#
# USB Miscellaneous drivers
#
# CONFIG_USB_EMI62 is not set
# CONFIG_USB_EMI26 is not set
# CONFIG_USB_ADUTUX is not set
# CONFIG_USB_SEVSEG is not set
# CONFIG_USB_LEGOTOWER is not set
# CONFIG_USB_LCD is not set
# CONFIG_USB_CYPRESS_CY7C63 is not set
# CONFIG_USB_CYTHERM is not set
# CONFIG_USB_IDMOUSE is not set
# CONFIG_USB_FTDI_ELAN is not set
# CONFIG_USB_APPLEDISPLAY is not set
# CONFIG_APPLE_MFI_FASTCHARGE is not set
# CONFIG_USB_SISUSBVGA is not set
# CONFIG_USB_LD is not set
# CONFIG_USB_TRANCEVIBRATOR is not set
# CONFIG_USB_IOWARRIOR is not set
# CONFIG_USB_TEST is not set
# CONFIG_USB_EHSET_TEST_FIXTURE is not set
# CONFIG_USB_ISIGHTFW is not set
# CONFIG_USB_YUREX is not set
# CONFIG_USB_EZUSB_FX2 is not set
# CONFIG_USB_HUB_USB251XB is not set
# CONFIG_USB_HSIC_USB3503 is not set
# CONFIG_USB_HSIC_USB4604 is not set
# CONFIG_USB_LINK_LAYER_TEST is not set
# CONFIG_USB_CHAOSKEY is not set
# CONFIG_USB_ATM is not set

#
# USB Physical Layer drivers
#
# CONFIG_NOP_USB_XCEIV is not set
# CONFIG_USB_GPIO_VBUS is not set
# CONFIG_USB_ISP1301 is not set
# end of USB Physical Layer drivers

# CONFIG_USB_GADGET is not set
CONFIG_TYPEC=y
# CONFIG_TYPEC_TCPM is not set
CONFIG_TYPEC_UCSI=y
# CONFIG_UCSI_CCG is not set
CONFIG_UCSI_ACPI=y
# CONFIG_TYPEC_TPS6598X is not set
# CONFIG_TYPEC_STUSB160X is not set

#
# USB Type-C Multiplexer/DeMultiplexer Switch support
#
# CONFIG_TYPEC_MUX_PI3USB30532 is not set
# end of USB Type-C Multiplexer/DeMultiplexer Switch support

#
# USB Type-C Alternate Mode drivers
#
# CONFIG_TYPEC_DP_ALTMODE is not set
# end of USB Type-C Alternate Mode drivers

# CONFIG_USB_ROLE_SWITCH is not set
CONFIG_MMC=m
CONFIG_MMC_BLOCK=m
CONFIG_MMC_BLOCK_MINORS=8
CONFIG_SDIO_UART=m
# CONFIG_MMC_TEST is not set

#
# MMC/SD/SDIO Host Controller Drivers
#
# CONFIG_MMC_DEBUG is not set
CONFIG_MMC_SDHCI=m
CONFIG_MMC_SDHCI_IO_ACCESSORS=y
CONFIG_MMC_SDHCI_PCI=m
CONFIG_MMC_RICOH_MMC=y
CONFIG_MMC_SDHCI_ACPI=m
CONFIG_MMC_SDHCI_PLTFM=m
# CONFIG_MMC_SDHCI_F_SDH30 is not set
# CONFIG_MMC_WBSD is not set
# CONFIG_MMC_TIFM_SD is not set
# CONFIG_MMC_SPI is not set
# CONFIG_MMC_CB710 is not set
# CONFIG_MMC_VIA_SDMMC is not set
# CONFIG_MMC_VUB300 is not set
# CONFIG_MMC_USHC is not set
# CONFIG_MMC_USDHI6ROL0 is not set
# CONFIG_MMC_REALTEK_PCI is not set
CONFIG_MMC_CQHCI=m
# CONFIG_MMC_HSQ is not set
# CONFIG_MMC_TOSHIBA_PCI is not set
# CONFIG_MMC_MTK is not set
# CONFIG_MMC_SDHCI_XENON is not set
# CONFIG_MEMSTICK is not set
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y
# CONFIG_LEDS_CLASS_FLASH is not set
# CONFIG_LEDS_CLASS_MULTICOLOR is not set
# CONFIG_LEDS_BRIGHTNESS_HW_CHANGED is not set

#
# LED drivers
#
# CONFIG_LEDS_APU is not set
CONFIG_LEDS_LM3530=m
# CONFIG_LEDS_LM3532 is not set
# CONFIG_LEDS_LM3642 is not set
# CONFIG_LEDS_PCA9532 is not set
# CONFIG_LEDS_GPIO is not set
CONFIG_LEDS_LP3944=m
# CONFIG_LEDS_LP3952 is not set
# CONFIG_LEDS_LP50XX is not set
CONFIG_LEDS_CLEVO_MAIL=m
# CONFIG_LEDS_PCA955X is not set
# CONFIG_LEDS_PCA963X is not set
# CONFIG_LEDS_DAC124S085 is not set
# CONFIG_LEDS_PWM is not set
# CONFIG_LEDS_BD2802 is not set
CONFIG_LEDS_INTEL_SS4200=m
# CONFIG_LEDS_TCA6507 is not set
# CONFIG_LEDS_TLC591XX is not set
# CONFIG_LEDS_LM355x is not set

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
#
CONFIG_LEDS_BLINKM=m
CONFIG_LEDS_MLXCPLD=m
# CONFIG_LEDS_MLXREG is not set
# CONFIG_LEDS_USER is not set
# CONFIG_LEDS_NIC78BX is not set
# CONFIG_LEDS_TI_LMU_COMMON is not set

#
# LED Triggers
#
CONFIG_LEDS_TRIGGERS=y
CONFIG_LEDS_TRIGGER_TIMER=m
CONFIG_LEDS_TRIGGER_ONESHOT=m
# CONFIG_LEDS_TRIGGER_DISK is not set
CONFIG_LEDS_TRIGGER_HEARTBEAT=m
CONFIG_LEDS_TRIGGER_BACKLIGHT=m
# CONFIG_LEDS_TRIGGER_CPU is not set
# CONFIG_LEDS_TRIGGER_ACTIVITY is not set
CONFIG_LEDS_TRIGGER_GPIO=m
CONFIG_LEDS_TRIGGER_DEFAULT_ON=m

#
# iptables trigger is under Netfilter config (LED target)
#
CONFIG_LEDS_TRIGGER_TRANSIENT=m
CONFIG_LEDS_TRIGGER_CAMERA=m
# CONFIG_LEDS_TRIGGER_PANIC is not set
# CONFIG_LEDS_TRIGGER_NETDEV is not set
# CONFIG_LEDS_TRIGGER_PATTERN is not set
CONFIG_LEDS_TRIGGER_AUDIO=m
# CONFIG_ACCESSIBILITY is not set
CONFIG_INFINIBAND=m
CONFIG_INFINIBAND_USER_MAD=m
CONFIG_INFINIBAND_USER_ACCESS=m
CONFIG_INFINIBAND_USER_MEM=y
CONFIG_INFINIBAND_ON_DEMAND_PAGING=y
CONFIG_INFINIBAND_ADDR_TRANS=y
CONFIG_INFINIBAND_ADDR_TRANS_CONFIGFS=y
# CONFIG_INFINIBAND_MTHCA is not set
# CONFIG_INFINIBAND_EFA is not set
# CONFIG_INFINIBAND_I40IW is not set
# CONFIG_MLX4_INFINIBAND is not set
# CONFIG_INFINIBAND_OCRDMA is not set
# CONFIG_INFINIBAND_USNIC is not set
# CONFIG_INFINIBAND_BNXT_RE is not set
# CONFIG_INFINIBAND_RDMAVT is not set
CONFIG_RDMA_RXE=m
CONFIG_RDMA_SIW=m
CONFIG_INFINIBAND_IPOIB=m
# CONFIG_INFINIBAND_IPOIB_CM is not set
CONFIG_INFINIBAND_IPOIB_DEBUG=y
# CONFIG_INFINIBAND_IPOIB_DEBUG_DATA is not set
CONFIG_INFINIBAND_SRP=m
CONFIG_INFINIBAND_SRPT=m
# CONFIG_INFINIBAND_ISER is not set
# CONFIG_INFINIBAND_ISERT is not set
# CONFIG_INFINIBAND_RTRS_CLIENT is not set
# CONFIG_INFINIBAND_RTRS_SERVER is not set
# CONFIG_INFINIBAND_OPA_VNIC is not set
CONFIG_EDAC_ATOMIC_SCRUB=y
CONFIG_EDAC_SUPPORT=y
CONFIG_EDAC=y
CONFIG_EDAC_LEGACY_SYSFS=y
# CONFIG_EDAC_DEBUG is not set
CONFIG_EDAC_DECODE_MCE=m
CONFIG_EDAC_GHES=y
CONFIG_EDAC_AMD64=m
# CONFIG_EDAC_AMD64_ERROR_INJECTION is not set
CONFIG_EDAC_E752X=m
CONFIG_EDAC_I82975X=m
CONFIG_EDAC_I3000=m
CONFIG_EDAC_I3200=m
CONFIG_EDAC_IE31200=m
CONFIG_EDAC_X38=m
CONFIG_EDAC_I5400=m
CONFIG_EDAC_I7CORE=m
CONFIG_EDAC_I5000=m
CONFIG_EDAC_I5100=m
CONFIG_EDAC_I7300=m
CONFIG_EDAC_SBRIDGE=m
CONFIG_EDAC_SKX=m
# CONFIG_EDAC_I10NM is not set
CONFIG_EDAC_PND2=m
CONFIG_RTC_LIB=y
CONFIG_RTC_MC146818_LIB=y
CONFIG_RTC_CLASS=y
CONFIG_RTC_HCTOSYS=y
CONFIG_RTC_HCTOSYS_DEVICE="rtc0"
# CONFIG_RTC_SYSTOHC is not set
# CONFIG_RTC_DEBUG is not set
CONFIG_RTC_NVMEM=y

#
# RTC interfaces
#
CONFIG_RTC_INTF_SYSFS=y
CONFIG_RTC_INTF_PROC=y
CONFIG_RTC_INTF_DEV=y
# CONFIG_RTC_INTF_DEV_UIE_EMUL is not set
# CONFIG_RTC_DRV_TEST is not set

#
# I2C RTC drivers
#
# CONFIG_RTC_DRV_ABB5ZES3 is not set
# CONFIG_RTC_DRV_ABEOZ9 is not set
# CONFIG_RTC_DRV_ABX80X is not set
CONFIG_RTC_DRV_DS1307=m
# CONFIG_RTC_DRV_DS1307_CENTURY is not set
CONFIG_RTC_DRV_DS1374=m
# CONFIG_RTC_DRV_DS1374_WDT is not set
CONFIG_RTC_DRV_DS1672=m
CONFIG_RTC_DRV_MAX6900=m
CONFIG_RTC_DRV_RS5C372=m
CONFIG_RTC_DRV_ISL1208=m
CONFIG_RTC_DRV_ISL12022=m
CONFIG_RTC_DRV_X1205=m
CONFIG_RTC_DRV_PCF8523=m
# CONFIG_RTC_DRV_PCF85063 is not set
# CONFIG_RTC_DRV_PCF85363 is not set
CONFIG_RTC_DRV_PCF8563=m
CONFIG_RTC_DRV_PCF8583=m
CONFIG_RTC_DRV_M41T80=m
CONFIG_RTC_DRV_M41T80_WDT=y
CONFIG_RTC_DRV_BQ32K=m
# CONFIG_RTC_DRV_S35390A is not set
CONFIG_RTC_DRV_FM3130=m
# CONFIG_RTC_DRV_RX8010 is not set
CONFIG_RTC_DRV_RX8581=m
CONFIG_RTC_DRV_RX8025=m
CONFIG_RTC_DRV_EM3027=m
# CONFIG_RTC_DRV_RV3028 is not set
# CONFIG_RTC_DRV_RV3032 is not set
# CONFIG_RTC_DRV_RV8803 is not set
# CONFIG_RTC_DRV_SD3078 is not set

#
# SPI RTC drivers
#
# CONFIG_RTC_DRV_M41T93 is not set
# CONFIG_RTC_DRV_M41T94 is not set
# CONFIG_RTC_DRV_DS1302 is not set
# CONFIG_RTC_DRV_DS1305 is not set
# CONFIG_RTC_DRV_DS1343 is not set
# CONFIG_RTC_DRV_DS1347 is not set
# CONFIG_RTC_DRV_DS1390 is not set
# CONFIG_RTC_DRV_MAX6916 is not set
# CONFIG_RTC_DRV_R9701 is not set
CONFIG_RTC_DRV_RX4581=m
# CONFIG_RTC_DRV_RX6110 is not set
# CONFIG_RTC_DRV_RS5C348 is not set
# CONFIG_RTC_DRV_MAX6902 is not set
# CONFIG_RTC_DRV_PCF2123 is not set
# CONFIG_RTC_DRV_MCP795 is not set
CONFIG_RTC_I2C_AND_SPI=y

#
# SPI and I2C RTC drivers
#
CONFIG_RTC_DRV_DS3232=m
CONFIG_RTC_DRV_DS3232_HWMON=y
# CONFIG_RTC_DRV_PCF2127 is not set
CONFIG_RTC_DRV_RV3029C2=m
# CONFIG_RTC_DRV_RV3029_HWMON is not set

#
# Platform RTC drivers
#
CONFIG_RTC_DRV_CMOS=y
CONFIG_RTC_DRV_DS1286=m
CONFIG_RTC_DRV_DS1511=m
CONFIG_RTC_DRV_DS1553=m
# CONFIG_RTC_DRV_DS1685_FAMILY is not set
CONFIG_RTC_DRV_DS1742=m
CONFIG_RTC_DRV_DS2404=m
CONFIG_RTC_DRV_STK17TA8=m
# CONFIG_RTC_DRV_M48T86 is not set
CONFIG_RTC_DRV_M48T35=m
CONFIG_RTC_DRV_M48T59=m
CONFIG_RTC_DRV_MSM6242=m
CONFIG_RTC_DRV_BQ4802=m
CONFIG_RTC_DRV_RP5C01=m
CONFIG_RTC_DRV_V3020=m

#
# on-CPU RTC drivers
#
# CONFIG_RTC_DRV_FTRTC010 is not set

#
# HID Sensor RTC drivers
#
CONFIG_DMADEVICES=y
# CONFIG_DMADEVICES_DEBUG is not set

#
# DMA Devices
#
CONFIG_DMA_ENGINE=y
CONFIG_DMA_VIRTUAL_CHANNELS=y
CONFIG_DMA_ACPI=y
# CONFIG_ALTERA_MSGDMA is not set
CONFIG_INTEL_IDMA64=m
# CONFIG_INTEL_IDXD is not set
CONFIG_INTEL_IOATDMA=m
# CONFIG_PLX_DMA is not set
# CONFIG_XILINX_ZYNQMP_DPDMA is not set
# CONFIG_QCOM_HIDMA_MGMT is not set
# CONFIG_QCOM_HIDMA is not set
CONFIG_DW_DMAC_CORE=y
CONFIG_DW_DMAC=m
CONFIG_DW_DMAC_PCI=y
# CONFIG_DW_EDMA is not set
# CONFIG_DW_EDMA_PCIE is not set
CONFIG_HSU_DMA=y
# CONFIG_SF_PDMA is not set

#
# DMA Clients
#
CONFIG_ASYNC_TX_DMA=y
CONFIG_DMATEST=m
CONFIG_DMA_ENGINE_RAID=y

#
# DMABUF options
#
CONFIG_SYNC_FILE=y
# CONFIG_SW_SYNC is not set
# CONFIG_UDMABUF is not set
# CONFIG_DMABUF_MOVE_NOTIFY is not set
# CONFIG_DMABUF_SELFTESTS is not set
# CONFIG_DMABUF_HEAPS is not set
# end of DMABUF options

CONFIG_DCA=m
# CONFIG_AUXDISPLAY is not set
# CONFIG_PANEL is not set
CONFIG_UIO=m
CONFIG_UIO_CIF=m
CONFIG_UIO_PDRV_GENIRQ=m
# CONFIG_UIO_DMEM_GENIRQ is not set
CONFIG_UIO_AEC=m
CONFIG_UIO_SERCOS3=m
CONFIG_UIO_PCI_GENERIC=m
# CONFIG_UIO_NETX is not set
# CONFIG_UIO_PRUSS is not set
# CONFIG_UIO_MF624 is not set
CONFIG_UIO_HV_GENERIC=m
CONFIG_VFIO_IOMMU_TYPE1=m
CONFIG_VFIO_VIRQFD=m
CONFIG_VFIO=m
CONFIG_VFIO_NOIOMMU=y
CONFIG_VFIO_PCI=m
# CONFIG_VFIO_PCI_VGA is not set
CONFIG_VFIO_PCI_MMAP=y
CONFIG_VFIO_PCI_INTX=y
# CONFIG_VFIO_PCI_IGD is not set
CONFIG_VFIO_MDEV=m
CONFIG_VFIO_MDEV_DEVICE=m
CONFIG_IRQ_BYPASS_MANAGER=m
# CONFIG_VIRT_DRIVERS is not set
CONFIG_VIRTIO=y
CONFIG_VIRTIO_MENU=y
CONFIG_VIRTIO_PCI=y
CONFIG_VIRTIO_PCI_LEGACY=y
# CONFIG_VIRTIO_PMEM is not set
CONFIG_VIRTIO_BALLOON=m
CONFIG_VIRTIO_MEM=m
CONFIG_VIRTIO_INPUT=m
# CONFIG_VIRTIO_MMIO is not set
CONFIG_VIRTIO_DMA_SHARED_BUFFER=m
# CONFIG_VDPA is not set
CONFIG_VHOST_IOTLB=m
CONFIG_VHOST=m
CONFIG_VHOST_MENU=y
CONFIG_VHOST_NET=m
# CONFIG_VHOST_SCSI is not set
CONFIG_VHOST_VSOCK=m
# CONFIG_VHOST_CROSS_ENDIAN_LEGACY is not set

#
# Microsoft Hyper-V guest support
#
CONFIG_HYPERV=m
CONFIG_HYPERV_TIMER=y
CONFIG_HYPERV_UTILS=m
CONFIG_HYPERV_BALLOON=m
# end of Microsoft Hyper-V guest support

#
# Xen driver support
#
# CONFIG_XEN_BALLOON is not set
CONFIG_XEN_DEV_EVTCHN=m
# CONFIG_XEN_BACKEND is not set
CONFIG_XENFS=m
CONFIG_XEN_COMPAT_XENFS=y
CONFIG_XEN_SYS_HYPERVISOR=y
CONFIG_XEN_XENBUS_FRONTEND=y
# CONFIG_XEN_GNTDEV is not set
# CONFIG_XEN_GRANT_DEV_ALLOC is not set
# CONFIG_XEN_GRANT_DMA_ALLOC is not set
CONFIG_SWIOTLB_XEN=y
# CONFIG_XEN_PVCALLS_FRONTEND is not set
CONFIG_XEN_PRIVCMD=m
CONFIG_XEN_EFI=y
CONFIG_XEN_AUTO_XLATE=y
CONFIG_XEN_ACPI=y
# CONFIG_XEN_UNPOPULATED_ALLOC is not set
# end of Xen driver support

# CONFIG_GREYBUS is not set
# CONFIG_STAGING is not set
CONFIG_X86_PLATFORM_DEVICES=y
CONFIG_ACPI_WMI=m
CONFIG_WMI_BMOF=m
# CONFIG_ALIENWARE_WMI is not set
# CONFIG_HUAWEI_WMI is not set
# CONFIG_INTEL_WMI_SBL_FW_UPDATE is not set
CONFIG_INTEL_WMI_THUNDERBOLT=m
CONFIG_MXM_WMI=m
# CONFIG_PEAQ_WMI is not set
# CONFIG_XIAOMI_WMI is not set
CONFIG_ACERHDF=m
# CONFIG_ACER_WIRELESS is not set
CONFIG_ACER_WMI=m
CONFIG_APPLE_GMUX=m
CONFIG_ASUS_LAPTOP=m
# CONFIG_ASUS_WIRELESS is not set
CONFIG_ASUS_WMI=m
CONFIG_ASUS_NB_WMI=m
CONFIG_EEEPC_LAPTOP=m
CONFIG_EEEPC_WMI=m
CONFIG_DCDBAS=m
CONFIG_DELL_SMBIOS=m
CONFIG_DELL_SMBIOS_WMI=y
# CONFIG_DELL_SMBIOS_SMM is not set
CONFIG_DELL_LAPTOP=m
CONFIG_DELL_RBTN=m
CONFIG_DELL_RBU=m
CONFIG_DELL_SMO8800=m
CONFIG_DELL_WMI=m
CONFIG_DELL_WMI_DESCRIPTOR=m
CONFIG_DELL_WMI_AIO=m
CONFIG_DELL_WMI_LED=m
CONFIG_AMILO_RFKILL=m
CONFIG_FUJITSU_LAPTOP=m
CONFIG_FUJITSU_TABLET=m
# CONFIG_GPD_POCKET_FAN is not set
CONFIG_HP_ACCEL=m
CONFIG_HP_WIRELESS=m
CONFIG_HP_WMI=m
# CONFIG_IBM_RTL is not set
CONFIG_IDEAPAD_LAPTOP=m
CONFIG_SENSORS_HDAPS=m
CONFIG_THINKPAD_ACPI=m
# CONFIG_THINKPAD_ACPI_DEBUGFACILITIES is not set
# CONFIG_THINKPAD_ACPI_DEBUG is not set
# CONFIG_THINKPAD_ACPI_UNSAFE_LEDS is not set
CONFIG_THINKPAD_ACPI_VIDEO=y
CONFIG_THINKPAD_ACPI_HOTKEY_POLL=y
# CONFIG_INTEL_ATOMISP2_PM is not set
CONFIG_INTEL_HID_EVENT=m
# CONFIG_INTEL_INT0002_VGPIO is not set
# CONFIG_INTEL_MENLOW is not set
CONFIG_INTEL_OAKTRAIL=m
CONFIG_INTEL_VBTN=m
# CONFIG_SURFACE3_WMI is not set
# CONFIG_SURFACE_3_POWER_OPREGION is not set
# CONFIG_SURFACE_PRO3_BUTTON is not set
CONFIG_MSI_LAPTOP=m
CONFIG_MSI_WMI=m
# CONFIG_PCENGINES_APU2 is not set
CONFIG_SAMSUNG_LAPTOP=m
CONFIG_SAMSUNG_Q10=m
CONFIG_TOSHIBA_BT_RFKILL=m
# CONFIG_TOSHIBA_HAPS is not set
# CONFIG_TOSHIBA_WMI is not set
CONFIG_ACPI_CMPC=m
CONFIG_COMPAL_LAPTOP=m
# CONFIG_LG_LAPTOP is not set
CONFIG_PANASONIC_LAPTOP=m
CONFIG_SONY_LAPTOP=m
CONFIG_SONYPI_COMPAT=y
# CONFIG_SYSTEM76_ACPI is not set
CONFIG_TOPSTAR_LAPTOP=m
# CONFIG_I2C_MULTI_INSTANTIATE is not set
CONFIG_MLX_PLATFORM=m
CONFIG_INTEL_IPS=m
CONFIG_INTEL_RST=m
# CONFIG_INTEL_SMARTCONNECT is not set

#
# Intel Speed Select Technology interface support
#
# CONFIG_INTEL_SPEED_SELECT_INTERFACE is not set
# end of Intel Speed Select Technology interface support

CONFIG_INTEL_TURBO_MAX_3=y
# CONFIG_INTEL_UNCORE_FREQ_CONTROL is not set
CONFIG_INTEL_PMC_CORE=m
# CONFIG_INTEL_PUNIT_IPC is not set
# CONFIG_INTEL_SCU_PCI is not set
# CONFIG_INTEL_SCU_PLATFORM is not set
CONFIG_PMC_ATOM=y
# CONFIG_CHROME_PLATFORMS is not set
CONFIG_MELLANOX_PLATFORM=y
CONFIG_MLXREG_HOTPLUG=m
# CONFIG_MLXREG_IO is not set
CONFIG_HAVE_CLK=y
CONFIG_CLKDEV_LOOKUP=y
CONFIG_HAVE_CLK_PREPARE=y
CONFIG_COMMON_CLK=y
# CONFIG_COMMON_CLK_MAX9485 is not set
# CONFIG_COMMON_CLK_SI5341 is not set
# CONFIG_COMMON_CLK_SI5351 is not set
# CONFIG_COMMON_CLK_SI544 is not set
# CONFIG_COMMON_CLK_CDCE706 is not set
# CONFIG_COMMON_CLK_CS2000_CP is not set
# CONFIG_COMMON_CLK_PWM is not set
CONFIG_HWSPINLOCK=y

#
# Clock Source drivers
#
CONFIG_CLKEVT_I8253=y
CONFIG_I8253_LOCK=y
CONFIG_CLKBLD_I8253=y
# end of Clock Source drivers

CONFIG_MAILBOX=y
CONFIG_PCC=y
# CONFIG_ALTERA_MBOX is not set
CONFIG_IOMMU_IOVA=y
CONFIG_IOASID=y
CONFIG_IOMMU_API=y
CONFIG_IOMMU_SUPPORT=y

#
# Generic IOMMU Pagetable Support
#
# end of Generic IOMMU Pagetable Support

# CONFIG_IOMMU_DEBUGFS is not set
# CONFIG_IOMMU_DEFAULT_PASSTHROUGH is not set
CONFIG_IOMMU_DMA=y
CONFIG_AMD_IOMMU=y
CONFIG_AMD_IOMMU_V2=m
CONFIG_DMAR_TABLE=y
CONFIG_INTEL_IOMMU=y
# CONFIG_INTEL_IOMMU_SVM is not set
# CONFIG_INTEL_IOMMU_DEFAULT_ON is not set
CONFIG_INTEL_IOMMU_FLOPPY_WA=y
# CONFIG_INTEL_IOMMU_SCALABLE_MODE_DEFAULT_ON is not set
CONFIG_IRQ_REMAP=y
CONFIG_HYPERV_IOMMU=y

#
# Remoteproc drivers
#
# CONFIG_REMOTEPROC is not set
# end of Remoteproc drivers

#
# Rpmsg drivers
#
# CONFIG_RPMSG_QCOM_GLINK_RPM is not set
# CONFIG_RPMSG_VIRTIO is not set
# end of Rpmsg drivers

# CONFIG_SOUNDWIRE is not set

#
# SOC (System On Chip) specific Drivers
#

#
# Amlogic SoC drivers
#
# end of Amlogic SoC drivers

#
# Aspeed SoC drivers
#
# end of Aspeed SoC drivers

#
# Broadcom SoC drivers
#
# end of Broadcom SoC drivers

#
# NXP/Freescale QorIQ SoC drivers
#
# end of NXP/Freescale QorIQ SoC drivers

#
# i.MX SoC drivers
#
# end of i.MX SoC drivers

#
# Qualcomm SoC drivers
#
# end of Qualcomm SoC drivers

# CONFIG_SOC_TI is not set

#
# Xilinx SoC drivers
#
# CONFIG_XILINX_VCU is not set
# end of Xilinx SoC drivers
# end of SOC (System On Chip) specific Drivers

# CONFIG_PM_DEVFREQ is not set
# CONFIG_EXTCON is not set
# CONFIG_MEMORY is not set
# CONFIG_IIO is not set
CONFIG_NTB=m
# CONFIG_NTB_MSI is not set
# CONFIG_NTB_AMD is not set
# CONFIG_NTB_IDT is not set
# CONFIG_NTB_INTEL is not set
# CONFIG_NTB_SWITCHTEC is not set
# CONFIG_NTB_PINGPONG is not set
# CONFIG_NTB_TOOL is not set
# CONFIG_NTB_PERF is not set
# CONFIG_NTB_TRANSPORT is not set
# CONFIG_VME_BUS is not set
CONFIG_PWM=y
CONFIG_PWM_SYSFS=y
# CONFIG_PWM_DEBUG is not set
CONFIG_PWM_LPSS=m
CONFIG_PWM_LPSS_PCI=m
CONFIG_PWM_LPSS_PLATFORM=m
# CONFIG_PWM_PCA9685 is not set

#
# IRQ chip support
#
# end of IRQ chip support

# CONFIG_IPACK_BUS is not set
# CONFIG_RESET_CONTROLLER is not set

#
# PHY Subsystem
#
# CONFIG_GENERIC_PHY is not set
# CONFIG_USB_LGM_PHY is not set
# CONFIG_BCM_KONA_USB2_PHY is not set
# CONFIG_PHY_PXA_28NM_HSIC is not set
# CONFIG_PHY_PXA_28NM_USB2 is not set
# CONFIG_PHY_INTEL_LGM_EMMC is not set
# end of PHY Subsystem

CONFIG_POWERCAP=y
CONFIG_INTEL_RAPL_CORE=m
CONFIG_INTEL_RAPL=m
# CONFIG_IDLE_INJECT is not set
# CONFIG_MCB is not set

#
# Performance monitor support
#
# end of Performance monitor support

CONFIG_RAS=y
# CONFIG_RAS_CEC is not set
# CONFIG_USB4 is not set

#
# Android
#
# CONFIG_ANDROID is not set
# end of Android

CONFIG_LIBNVDIMM=m
CONFIG_BLK_DEV_PMEM=m
CONFIG_ND_BLK=m
CONFIG_ND_CLAIM=y
CONFIG_ND_BTT=m
CONFIG_BTT=y
CONFIG_ND_PFN=m
CONFIG_NVDIMM_PFN=y
CONFIG_NVDIMM_DAX=y
CONFIG_NVDIMM_KEYS=y
CONFIG_DAX_DRIVER=y
CONFIG_DAX=y
CONFIG_DEV_DAX=m
CONFIG_DEV_DAX_PMEM=m
CONFIG_DEV_DAX_KMEM=m
CONFIG_DEV_DAX_PMEM_COMPAT=m
CONFIG_NVMEM=y
CONFIG_NVMEM_SYSFS=y

#
# HW tracing support
#
CONFIG_STM=m
# CONFIG_STM_PROTO_BASIC is not set
# CONFIG_STM_PROTO_SYS_T is not set
CONFIG_STM_DUMMY=m
CONFIG_STM_SOURCE_CONSOLE=m
CONFIG_STM_SOURCE_HEARTBEAT=m
CONFIG_STM_SOURCE_FTRACE=m
CONFIG_INTEL_TH=m
CONFIG_INTEL_TH_PCI=m
CONFIG_INTEL_TH_ACPI=m
CONFIG_INTEL_TH_GTH=m
CONFIG_INTEL_TH_STH=m
CONFIG_INTEL_TH_MSU=m
CONFIG_INTEL_TH_PTI=m
# CONFIG_INTEL_TH_DEBUG is not set
# end of HW tracing support

# CONFIG_FPGA is not set
# CONFIG_TEE is not set
# CONFIG_UNISYS_VISORBUS is not set
# CONFIG_SIOX is not set
# CONFIG_SLIMBUS is not set
# CONFIG_INTERCONNECT is not set
# CONFIG_COUNTER is not set
# CONFIG_MOST is not set
# end of Device Drivers

#
# File systems
#
CONFIG_DCACHE_WORD_ACCESS=y
# CONFIG_VALIDATE_FS_PARSER is not set
CONFIG_FS_IOMAP=y
CONFIG_EXT2_FS=m
# CONFIG_EXT2_FS_XATTR is not set
# CONFIG_EXT3_FS is not set
CONFIG_EXT4_FS=y
CONFIG_EXT4_FS_POSIX_ACL=y
CONFIG_EXT4_FS_SECURITY=y
# CONFIG_EXT4_DEBUG is not set
CONFIG_EXT4_KUNIT_TESTS=m
CONFIG_JBD2=y
# CONFIG_JBD2_DEBUG is not set
CONFIG_FS_MBCACHE=y
# CONFIG_REISERFS_FS is not set
# CONFIG_JFS_FS is not set
CONFIG_XFS_FS=m
CONFIG_XFS_SUPPORT_V4=y
CONFIG_XFS_QUOTA=y
CONFIG_XFS_POSIX_ACL=y
CONFIG_XFS_RT=y
CONFIG_XFS_ONLINE_SCRUB=y
CONFIG_XFS_ONLINE_REPAIR=y
CONFIG_XFS_DEBUG=y
CONFIG_XFS_ASSERT_FATAL=y
CONFIG_GFS2_FS=m
CONFIG_GFS2_FS_LOCKING_DLM=y
CONFIG_OCFS2_FS=m
CONFIG_OCFS2_FS_O2CB=m
CONFIG_OCFS2_FS_USERSPACE_CLUSTER=m
CONFIG_OCFS2_FS_STATS=y
CONFIG_OCFS2_DEBUG_MASKLOG=y
# CONFIG_OCFS2_DEBUG_FS is not set
CONFIG_BTRFS_FS=m
CONFIG_BTRFS_FS_POSIX_ACL=y
# CONFIG_BTRFS_FS_CHECK_INTEGRITY is not set
# CONFIG_BTRFS_FS_RUN_SANITY_TESTS is not set
# CONFIG_BTRFS_DEBUG is not set
# CONFIG_BTRFS_ASSERT is not set
# CONFIG_BTRFS_FS_REF_VERIFY is not set
# CONFIG_NILFS2_FS is not set
CONFIG_F2FS_FS=m
CONFIG_F2FS_STAT_FS=y
CONFIG_F2FS_FS_XATTR=y
CONFIG_F2FS_FS_POSIX_ACL=y
CONFIG_F2FS_FS_SECURITY=y
# CONFIG_F2FS_CHECK_FS is not set
# CONFIG_F2FS_IO_TRACE is not set
# CONFIG_F2FS_FAULT_INJECTION is not set
# CONFIG_F2FS_FS_COMPRESSION is not set
# CONFIG_ZONEFS_FS is not set
CONFIG_FS_DAX=y
CONFIG_FS_DAX_PMD=y
CONFIG_FS_POSIX_ACL=y
CONFIG_EXPORTFS=y
CONFIG_EXPORTFS_BLOCK_OPS=y
CONFIG_FILE_LOCKING=y
CONFIG_MANDATORY_FILE_LOCKING=y
CONFIG_FS_ENCRYPTION=y
CONFIG_FS_ENCRYPTION_ALGS=y
# CONFIG_FS_VERITY is not set
CONFIG_FSNOTIFY=y
CONFIG_DNOTIFY=y
CONFIG_INOTIFY_USER=y
CONFIG_FANOTIFY=y
CONFIG_FANOTIFY_ACCESS_PERMISSIONS=y
CONFIG_QUOTA=y
CONFIG_QUOTA_NETLINK_INTERFACE=y
CONFIG_PRINT_QUOTA_WARNING=y
# CONFIG_QUOTA_DEBUG is not set
CONFIG_QUOTA_TREE=y
# CONFIG_QFMT_V1 is not set
CONFIG_QFMT_V2=y
CONFIG_QUOTACTL=y
CONFIG_AUTOFS4_FS=y
CONFIG_AUTOFS_FS=y
CONFIG_FUSE_FS=m
CONFIG_CUSE=m
# CONFIG_VIRTIO_FS is not set
CONFIG_OVERLAY_FS=m
# CONFIG_OVERLAY_FS_REDIRECT_DIR is not set
# CONFIG_OVERLAY_FS_REDIRECT_ALWAYS_FOLLOW is not set
# CONFIG_OVERLAY_FS_INDEX is not set
# CONFIG_OVERLAY_FS_XINO_AUTO is not set
# CONFIG_OVERLAY_FS_METACOPY is not set

#
# Caches
#
CONFIG_FSCACHE=m
CONFIG_FSCACHE_STATS=y
# CONFIG_FSCACHE_HISTOGRAM is not set
# CONFIG_FSCACHE_DEBUG is not set
# CONFIG_FSCACHE_OBJECT_LIST is not set
CONFIG_CACHEFILES=m
# CONFIG_CACHEFILES_DEBUG is not set
# CONFIG_CACHEFILES_HISTOGRAM is not set
# end of Caches

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_UDF_FS=m
# end of CD-ROM/DVD Filesystems

#
# DOS/FAT/EXFAT/NT Filesystems
#
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
CONFIG_VFAT_FS=m
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="ascii"
# CONFIG_FAT_DEFAULT_UTF8 is not set
# CONFIG_EXFAT_FS is not set
# CONFIG_NTFS_FS is not set
# end of DOS/FAT/EXFAT/NT Filesystems

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_PROC_VMCORE=y
CONFIG_PROC_VMCORE_DEVICE_DUMP=y
CONFIG_PROC_SYSCTL=y
CONFIG_PROC_PAGE_MONITOR=y
CONFIG_PROC_CHILDREN=y
CONFIG_PROC_PID_ARCH_STATUS=y
CONFIG_PROC_CPU_RESCTRL=y
CONFIG_KERNFS=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
CONFIG_TMPFS_POSIX_ACL=y
CONFIG_TMPFS_XATTR=y
# CONFIG_TMPFS_INODE64 is not set
CONFIG_HUGETLBFS=y
CONFIG_HUGETLB_PAGE=y
CONFIG_MEMFD_CREATE=y
CONFIG_ARCH_HAS_GIGANTIC_PAGE=y
CONFIG_CONFIGFS_FS=y
CONFIG_EFIVAR_FS=y
# end of Pseudo filesystems

CONFIG_MISC_FILESYSTEMS=y
# CONFIG_ORANGEFS_FS is not set
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_ECRYPT_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_HFSPLUS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EFS_FS is not set
CONFIG_CRAMFS=m
CONFIG_CRAMFS_BLOCKDEV=y
CONFIG_SQUASHFS=m
# CONFIG_SQUASHFS_FILE_CACHE is not set
CONFIG_SQUASHFS_FILE_DIRECT=y
# CONFIG_SQUASHFS_DECOMP_SINGLE is not set
# CONFIG_SQUASHFS_DECOMP_MULTI is not set
CONFIG_SQUASHFS_DECOMP_MULTI_PERCPU=y
CONFIG_SQUASHFS_XATTR=y
CONFIG_SQUASHFS_ZLIB=y
# CONFIG_SQUASHFS_LZ4 is not set
CONFIG_SQUASHFS_LZO=y
CONFIG_SQUASHFS_XZ=y
# CONFIG_SQUASHFS_ZSTD is not set
# CONFIG_SQUASHFS_4K_DEVBLK_SIZE is not set
# CONFIG_SQUASHFS_EMBEDDED is not set
CONFIG_SQUASHFS_FRAGMENT_CACHE_SIZE=3
# CONFIG_VXFS_FS is not set
CONFIG_MINIX_FS=m
# CONFIG_OMFS_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_QNX6FS_FS is not set
# CONFIG_ROMFS_FS is not set
CONFIG_PSTORE=y
CONFIG_PSTORE_DEFLATE_COMPRESS=y
# CONFIG_PSTORE_LZO_COMPRESS is not set
# CONFIG_PSTORE_LZ4_COMPRESS is not set
# CONFIG_PSTORE_LZ4HC_COMPRESS is not set
# CONFIG_PSTORE_842_COMPRESS is not set
# CONFIG_PSTORE_ZSTD_COMPRESS is not set
CONFIG_PSTORE_COMPRESS=y
CONFIG_PSTORE_DEFLATE_COMPRESS_DEFAULT=y
CONFIG_PSTORE_COMPRESS_DEFAULT="deflate"
# CONFIG_PSTORE_CONSOLE is not set
# CONFIG_PSTORE_PMSG is not set
# CONFIG_PSTORE_FTRACE is not set
CONFIG_PSTORE_RAM=m
# CONFIG_PSTORE_BLK is not set
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set
# CONFIG_EROFS_FS is not set
CONFIG_NETWORK_FILESYSTEMS=y
CONFIG_NFS_FS=y
# CONFIG_NFS_V2 is not set
CONFIG_NFS_V3=y
CONFIG_NFS_V3_ACL=y
CONFIG_NFS_V4=m
# CONFIG_NFS_SWAP is not set
CONFIG_NFS_V4_1=y
CONFIG_NFS_V4_2=y
CONFIG_PNFS_FILE_LAYOUT=m
CONFIG_PNFS_BLOCK=m
CONFIG_PNFS_FLEXFILE_LAYOUT=m
CONFIG_NFS_V4_1_IMPLEMENTATION_ID_DOMAIN="kernel.org"
# CONFIG_NFS_V4_1_MIGRATION is not set
CONFIG_NFS_V4_SECURITY_LABEL=y
CONFIG_ROOT_NFS=y
# CONFIG_NFS_USE_LEGACY_DNS is not set
CONFIG_NFS_USE_KERNEL_DNS=y
CONFIG_NFS_DEBUG=y
CONFIG_NFS_DISABLE_UDP_SUPPORT=y
CONFIG_NFSD=m
CONFIG_NFSD_V2_ACL=y
CONFIG_NFSD_V3=y
CONFIG_NFSD_V3_ACL=y
CONFIG_NFSD_V4=y
CONFIG_NFSD_PNFS=y
# CONFIG_NFSD_BLOCKLAYOUT is not set
CONFIG_NFSD_SCSILAYOUT=y
# CONFIG_NFSD_FLEXFILELAYOUT is not set
# CONFIG_NFSD_V4_2_INTER_SSC is not set
CONFIG_NFSD_V4_SECURITY_LABEL=y
CONFIG_GRACE_PERIOD=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_NFS_ACL_SUPPORT=y
CONFIG_NFS_COMMON=y
CONFIG_SUNRPC=y
CONFIG_SUNRPC_GSS=m
CONFIG_SUNRPC_BACKCHANNEL=y
CONFIG_RPCSEC_GSS_KRB5=m
# CONFIG_SUNRPC_DISABLE_INSECURE_ENCTYPES is not set
CONFIG_SUNRPC_DEBUG=y
CONFIG_SUNRPC_XPRT_RDMA=m
CONFIG_CEPH_FS=m
# CONFIG_CEPH_FSCACHE is not set
CONFIG_CEPH_FS_POSIX_ACL=y
# CONFIG_CEPH_FS_SECURITY_LABEL is not set
CONFIG_CIFS=m
# CONFIG_CIFS_STATS2 is not set
CONFIG_CIFS_ALLOW_INSECURE_LEGACY=y
CONFIG_CIFS_WEAK_PW_HASH=y
CONFIG_CIFS_UPCALL=y
CONFIG_CIFS_XATTR=y
CONFIG_CIFS_POSIX=y
CONFIG_CIFS_DEBUG=y
# CONFIG_CIFS_DEBUG2 is not set
# CONFIG_CIFS_DEBUG_DUMP_KEYS is not set
CONFIG_CIFS_DFS_UPCALL=y
# CONFIG_CIFS_SMB_DIRECT is not set
# CONFIG_CIFS_FSCACHE is not set
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set
# CONFIG_9P_FS is not set
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="utf8"
CONFIG_NLS_CODEPAGE_437=y
CONFIG_NLS_CODEPAGE_737=m
CONFIG_NLS_CODEPAGE_775=m
CONFIG_NLS_CODEPAGE_850=m
CONFIG_NLS_CODEPAGE_852=m
CONFIG_NLS_CODEPAGE_855=m
CONFIG_NLS_CODEPAGE_857=m
CONFIG_NLS_CODEPAGE_860=m
CONFIG_NLS_CODEPAGE_861=m
CONFIG_NLS_CODEPAGE_862=m
CONFIG_NLS_CODEPAGE_863=m
CONFIG_NLS_CODEPAGE_864=m
CONFIG_NLS_CODEPAGE_865=m
CONFIG_NLS_CODEPAGE_866=m
CONFIG_NLS_CODEPAGE_869=m
CONFIG_NLS_CODEPAGE_936=m
CONFIG_NLS_CODEPAGE_950=m
CONFIG_NLS_CODEPAGE_932=m
CONFIG_NLS_CODEPAGE_949=m
CONFIG_NLS_CODEPAGE_874=m
CONFIG_NLS_ISO8859_8=m
CONFIG_NLS_CODEPAGE_1250=m
CONFIG_NLS_CODEPAGE_1251=m
CONFIG_NLS_ASCII=y
CONFIG_NLS_ISO8859_1=m
CONFIG_NLS_ISO8859_2=m
CONFIG_NLS_ISO8859_3=m
CONFIG_NLS_ISO8859_4=m
CONFIG_NLS_ISO8859_5=m
CONFIG_NLS_ISO8859_6=m
CONFIG_NLS_ISO8859_7=m
CONFIG_NLS_ISO8859_9=m
CONFIG_NLS_ISO8859_13=m
CONFIG_NLS_ISO8859_14=m
CONFIG_NLS_ISO8859_15=m
CONFIG_NLS_KOI8_R=m
CONFIG_NLS_KOI8_U=m
CONFIG_NLS_MAC_ROMAN=m
CONFIG_NLS_MAC_CELTIC=m
CONFIG_NLS_MAC_CENTEURO=m
CONFIG_NLS_MAC_CROATIAN=m
CONFIG_NLS_MAC_CYRILLIC=m
CONFIG_NLS_MAC_GAELIC=m
CONFIG_NLS_MAC_GREEK=m
CONFIG_NLS_MAC_ICELAND=m
CONFIG_NLS_MAC_INUIT=m
CONFIG_NLS_MAC_ROMANIAN=m
CONFIG_NLS_MAC_TURKISH=m
CONFIG_NLS_UTF8=m
CONFIG_DLM=m
CONFIG_DLM_DEBUG=y
# CONFIG_UNICODE is not set
CONFIG_IO_WQ=y
# end of File systems

#
# Security options
#
CONFIG_KEYS=y
# CONFIG_KEYS_REQUEST_CACHE is not set
CONFIG_PERSISTENT_KEYRINGS=y
CONFIG_TRUSTED_KEYS=y
CONFIG_ENCRYPTED_KEYS=y
# CONFIG_KEY_DH_OPERATIONS is not set
# CONFIG_SECURITY_DMESG_RESTRICT is not set
CONFIG_SECURITY=y
CONFIG_SECURITY_WRITABLE_HOOKS=y
CONFIG_SECURITYFS=y
CONFIG_SECURITY_NETWORK=y
CONFIG_PAGE_TABLE_ISOLATION=y
# CONFIG_SECURITY_INFINIBAND is not set
CONFIG_SECURITY_NETWORK_XFRM=y
CONFIG_SECURITY_PATH=y
CONFIG_INTEL_TXT=y
CONFIG_LSM_MMAP_MIN_ADDR=65535
CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
CONFIG_HARDENED_USERCOPY=y
CONFIG_HARDENED_USERCOPY_FALLBACK=y
CONFIG_FORTIFY_SOURCE=y
# CONFIG_STATIC_USERMODEHELPER is not set
CONFIG_SECURITY_SELINUX=y
CONFIG_SECURITY_SELINUX_BOOTPARAM=y
CONFIG_SECURITY_SELINUX_DISABLE=y
CONFIG_SECURITY_SELINUX_DEVELOP=y
CONFIG_SECURITY_SELINUX_AVC_STATS=y
CONFIG_SECURITY_SELINUX_CHECKREQPROT_VALUE=1
CONFIG_SECURITY_SELINUX_SIDTAB_HASH_BITS=9
CONFIG_SECURITY_SELINUX_SID2STR_CACHE_SIZE=256
# CONFIG_SECURITY_SMACK is not set
# CONFIG_SECURITY_TOMOYO is not set
CONFIG_SECURITY_APPARMOR=y
CONFIG_SECURITY_APPARMOR_HASH=y
CONFIG_SECURITY_APPARMOR_HASH_DEFAULT=y
# CONFIG_SECURITY_APPARMOR_DEBUG is not set
# CONFIG_SECURITY_APPARMOR_KUNIT_TEST is not set
# CONFIG_SECURITY_LOADPIN is not set
CONFIG_SECURITY_YAMA=y
# CONFIG_SECURITY_SAFESETID is not set
# CONFIG_SECURITY_LOCKDOWN_LSM is not set
CONFIG_INTEGRITY=y
CONFIG_INTEGRITY_SIGNATURE=y
CONFIG_INTEGRITY_ASYMMETRIC_KEYS=y
CONFIG_INTEGRITY_TRUSTED_KEYRING=y
# CONFIG_INTEGRITY_PLATFORM_KEYRING is not set
CONFIG_INTEGRITY_AUDIT=y
CONFIG_IMA=y
CONFIG_IMA_MEASURE_PCR_IDX=10
CONFIG_IMA_LSM_RULES=y
# CONFIG_IMA_TEMPLATE is not set
CONFIG_IMA_NG_TEMPLATE=y
# CONFIG_IMA_SIG_TEMPLATE is not set
CONFIG_IMA_DEFAULT_TEMPLATE="ima-ng"
CONFIG_IMA_DEFAULT_HASH_SHA1=y
# CONFIG_IMA_DEFAULT_HASH_SHA256 is not set
# CONFIG_IMA_DEFAULT_HASH_SHA512 is not set
CONFIG_IMA_DEFAULT_HASH="sha1"
# CONFIG_IMA_WRITE_POLICY is not set
# CONFIG_IMA_READ_POLICY is not set
CONFIG_IMA_APPRAISE=y
# CONFIG_IMA_ARCH_POLICY is not set
# CONFIG_IMA_APPRAISE_BUILD_POLICY is not set
CONFIG_IMA_APPRAISE_BOOTPARAM=y
# CONFIG_IMA_APPRAISE_MODSIG is not set
CONFIG_IMA_TRUSTED_KEYRING=y
# CONFIG_IMA_BLACKLIST_KEYRING is not set
# CONFIG_IMA_LOAD_X509 is not set
CONFIG_IMA_MEASURE_ASYMMETRIC_KEYS=y
CONFIG_IMA_QUEUE_EARLY_BOOT_KEYS=y
# CONFIG_IMA_SECURE_AND_OR_TRUSTED_BOOT is not set
CONFIG_EVM=y
CONFIG_EVM_ATTR_FSUUID=y
# CONFIG_EVM_ADD_XATTRS is not set
# CONFIG_EVM_LOAD_X509 is not set
CONFIG_DEFAULT_SECURITY_SELINUX=y
# CONFIG_DEFAULT_SECURITY_APPARMOR is not set
# CONFIG_DEFAULT_SECURITY_DAC is not set
CONFIG_LSM="lockdown,yama,loadpin,safesetid,integrity,selinux,smack,tomoyo,apparmor,bpf"

#
# Kernel hardening options
#

#
# Memory initialization
#
CONFIG_INIT_STACK_NONE=y
# CONFIG_INIT_ON_ALLOC_DEFAULT_ON is not set
# CONFIG_INIT_ON_FREE_DEFAULT_ON is not set
# end of Memory initialization
# end of Kernel hardening options
# end of Security options

CONFIG_XOR_BLOCKS=m
CONFIG_ASYNC_CORE=m
CONFIG_ASYNC_MEMCPY=m
CONFIG_ASYNC_XOR=m
CONFIG_ASYNC_PQ=m
CONFIG_ASYNC_RAID6_RECOV=m
CONFIG_CRYPTO=y

#
# Crypto core or helper
#
CONFIG_CRYPTO_ALGAPI=y
CONFIG_CRYPTO_ALGAPI2=y
CONFIG_CRYPTO_AEAD=y
CONFIG_CRYPTO_AEAD2=y
CONFIG_CRYPTO_SKCIPHER=y
CONFIG_CRYPTO_SKCIPHER2=y
CONFIG_CRYPTO_HASH=y
CONFIG_CRYPTO_HASH2=y
CONFIG_CRYPTO_RNG=y
CONFIG_CRYPTO_RNG2=y
CONFIG_CRYPTO_RNG_DEFAULT=y
CONFIG_CRYPTO_AKCIPHER2=y
CONFIG_CRYPTO_AKCIPHER=y
CONFIG_CRYPTO_KPP2=y
CONFIG_CRYPTO_KPP=m
CONFIG_CRYPTO_ACOMP2=y
CONFIG_CRYPTO_MANAGER=y
CONFIG_CRYPTO_MANAGER2=y
CONFIG_CRYPTO_USER=m
CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
CONFIG_CRYPTO_GF128MUL=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_NULL2=y
CONFIG_CRYPTO_PCRYPT=m
CONFIG_CRYPTO_CRYPTD=y
CONFIG_CRYPTO_AUTHENC=m
CONFIG_CRYPTO_TEST=m
CONFIG_CRYPTO_SIMD=y
CONFIG_CRYPTO_GLUE_HELPER_X86=y

#
# Public-key cryptography
#
CONFIG_CRYPTO_RSA=y
CONFIG_CRYPTO_DH=m
CONFIG_CRYPTO_ECC=m
CONFIG_CRYPTO_ECDH=m
# CONFIG_CRYPTO_ECRDSA is not set
# CONFIG_CRYPTO_SM2 is not set
# CONFIG_CRYPTO_CURVE25519 is not set
# CONFIG_CRYPTO_CURVE25519_X86 is not set

#
# Authenticated Encryption with Associated Data
#
CONFIG_CRYPTO_CCM=m
CONFIG_CRYPTO_GCM=y
CONFIG_CRYPTO_CHACHA20POLY1305=m
# CONFIG_CRYPTO_AEGIS128 is not set
# CONFIG_CRYPTO_AEGIS128_AESNI_SSE2 is not set
CONFIG_CRYPTO_SEQIV=y
CONFIG_CRYPTO_ECHAINIV=m

#
# Block modes
#
CONFIG_CRYPTO_CBC=y
CONFIG_CRYPTO_CFB=y
CONFIG_CRYPTO_CTR=y
CONFIG_CRYPTO_CTS=y
CONFIG_CRYPTO_ECB=y
CONFIG_CRYPTO_LRW=m
# CONFIG_CRYPTO_OFB is not set
CONFIG_CRYPTO_PCBC=m
CONFIG_CRYPTO_XTS=y
# CONFIG_CRYPTO_KEYWRAP is not set
# CONFIG_CRYPTO_NHPOLY1305_SSE2 is not set
# CONFIG_CRYPTO_NHPOLY1305_AVX2 is not set
# CONFIG_CRYPTO_ADIANTUM is not set
CONFIG_CRYPTO_ESSIV=m

#
# Hash modes
#
CONFIG_CRYPTO_CMAC=m
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_XCBC=m
CONFIG_CRYPTO_VMAC=m

#
# Digest
#
CONFIG_CRYPTO_CRC32C=y
CONFIG_CRYPTO_CRC32C_INTEL=m
CONFIG_CRYPTO_CRC32=m
CONFIG_CRYPTO_CRC32_PCLMUL=m
CONFIG_CRYPTO_XXHASH=m
CONFIG_CRYPTO_BLAKE2B=m
# CONFIG_CRYPTO_BLAKE2S is not set
# CONFIG_CRYPTO_BLAKE2S_X86 is not set
CONFIG_CRYPTO_CRCT10DIF=y
CONFIG_CRYPTO_CRCT10DIF_PCLMUL=m
CONFIG_CRYPTO_GHASH=y
CONFIG_CRYPTO_POLY1305=m
CONFIG_CRYPTO_POLY1305_X86_64=m
CONFIG_CRYPTO_MD4=m
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_MICHAEL_MIC=m
CONFIG_CRYPTO_RMD128=m
CONFIG_CRYPTO_RMD160=m
CONFIG_CRYPTO_RMD256=m
CONFIG_CRYPTO_RMD320=m
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA1_SSSE3=y
CONFIG_CRYPTO_SHA256_SSSE3=y
CONFIG_CRYPTO_SHA512_SSSE3=m
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
CONFIG_CRYPTO_SHA3=m
# CONFIG_CRYPTO_SM3 is not set
# CONFIG_CRYPTO_STREEBOG is not set
CONFIG_CRYPTO_TGR192=m
CONFIG_CRYPTO_WP512=m
CONFIG_CRYPTO_GHASH_CLMUL_NI_INTEL=m

#
# Ciphers
#
CONFIG_CRYPTO_AES=y
# CONFIG_CRYPTO_AES_TI is not set
CONFIG_CRYPTO_AES_NI_INTEL=y
CONFIG_CRYPTO_ANUBIS=m
CONFIG_CRYPTO_ARC4=m
CONFIG_CRYPTO_BLOWFISH=m
CONFIG_CRYPTO_BLOWFISH_COMMON=m
CONFIG_CRYPTO_BLOWFISH_X86_64=m
CONFIG_CRYPTO_CAMELLIA=m
CONFIG_CRYPTO_CAMELLIA_X86_64=m
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX_X86_64=m
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX2_X86_64=m
CONFIG_CRYPTO_CAST_COMMON=m
CONFIG_CRYPTO_CAST5=m
CONFIG_CRYPTO_CAST5_AVX_X86_64=m
CONFIG_CRYPTO_CAST6=m
CONFIG_CRYPTO_CAST6_AVX_X86_64=m
CONFIG_CRYPTO_DES=m
CONFIG_CRYPTO_DES3_EDE_X86_64=m
CONFIG_CRYPTO_FCRYPT=m
CONFIG_CRYPTO_KHAZAD=m
CONFIG_CRYPTO_SALSA20=m
CONFIG_CRYPTO_CHACHA20=m
CONFIG_CRYPTO_CHACHA20_X86_64=m
CONFIG_CRYPTO_SEED=m
CONFIG_CRYPTO_SERPENT=m
CONFIG_CRYPTO_SERPENT_SSE2_X86_64=m
CONFIG_CRYPTO_SERPENT_AVX_X86_64=m
CONFIG_CRYPTO_SERPENT_AVX2_X86_64=m
# CONFIG_CRYPTO_SM4 is not set
CONFIG_CRYPTO_TEA=m
CONFIG_CRYPTO_TWOFISH=m
CONFIG_CRYPTO_TWOFISH_COMMON=m
CONFIG_CRYPTO_TWOFISH_X86_64=m
CONFIG_CRYPTO_TWOFISH_X86_64_3WAY=m
CONFIG_CRYPTO_TWOFISH_AVX_X86_64=m

#
# Compression
#
CONFIG_CRYPTO_DEFLATE=y
CONFIG_CRYPTO_LZO=y
# CONFIG_CRYPTO_842 is not set
# CONFIG_CRYPTO_LZ4 is not set
# CONFIG_CRYPTO_LZ4HC is not set
# CONFIG_CRYPTO_ZSTD is not set

#
# Random Number Generation
#
CONFIG_CRYPTO_ANSI_CPRNG=m
CONFIG_CRYPTO_DRBG_MENU=y
CONFIG_CRYPTO_DRBG_HMAC=y
CONFIG_CRYPTO_DRBG_HASH=y
CONFIG_CRYPTO_DRBG_CTR=y
CONFIG_CRYPTO_DRBG=y
CONFIG_CRYPTO_JITTERENTROPY=y
CONFIG_CRYPTO_USER_API=y
CONFIG_CRYPTO_USER_API_HASH=y
CONFIG_CRYPTO_USER_API_SKCIPHER=y
CONFIG_CRYPTO_USER_API_RNG=y
# CONFIG_CRYPTO_USER_API_RNG_CAVP is not set
CONFIG_CRYPTO_USER_API_AEAD=y
CONFIG_CRYPTO_USER_API_ENABLE_OBSOLETE=y
# CONFIG_CRYPTO_STATS is not set
CONFIG_CRYPTO_HASH_INFO=y

#
# Crypto library routines
#
CONFIG_CRYPTO_LIB_AES=y
CONFIG_CRYPTO_LIB_ARC4=m
# CONFIG_CRYPTO_LIB_BLAKE2S is not set
CONFIG_CRYPTO_ARCH_HAVE_LIB_CHACHA=m
CONFIG_CRYPTO_LIB_CHACHA_GENERIC=m
# CONFIG_CRYPTO_LIB_CHACHA is not set
# CONFIG_CRYPTO_LIB_CURVE25519 is not set
CONFIG_CRYPTO_LIB_DES=m
CONFIG_CRYPTO_LIB_POLY1305_RSIZE=11
CONFIG_CRYPTO_ARCH_HAVE_LIB_POLY1305=m
CONFIG_CRYPTO_LIB_POLY1305_GENERIC=m
# CONFIG_CRYPTO_LIB_POLY1305 is not set
# CONFIG_CRYPTO_LIB_CHACHA20POLY1305 is not set
CONFIG_CRYPTO_LIB_SHA256=y
CONFIG_CRYPTO_HW=y
CONFIG_CRYPTO_DEV_PADLOCK=m
CONFIG_CRYPTO_DEV_PADLOCK_AES=m
CONFIG_CRYPTO_DEV_PADLOCK_SHA=m
# CONFIG_CRYPTO_DEV_ATMEL_ECC is not set
# CONFIG_CRYPTO_DEV_ATMEL_SHA204A is not set
CONFIG_CRYPTO_DEV_CCP=y
CONFIG_CRYPTO_DEV_CCP_DD=m
CONFIG_CRYPTO_DEV_SP_CCP=y
CONFIG_CRYPTO_DEV_CCP_CRYPTO=m
CONFIG_CRYPTO_DEV_SP_PSP=y
# CONFIG_CRYPTO_DEV_CCP_DEBUGFS is not set
CONFIG_CRYPTO_DEV_QAT=m
CONFIG_CRYPTO_DEV_QAT_DH895xCC=m
CONFIG_CRYPTO_DEV_QAT_C3XXX=m
CONFIG_CRYPTO_DEV_QAT_C62X=m
CONFIG_CRYPTO_DEV_QAT_DH895xCCVF=m
CONFIG_CRYPTO_DEV_QAT_C3XXXVF=m
CONFIG_CRYPTO_DEV_QAT_C62XVF=m
CONFIG_CRYPTO_DEV_NITROX=m
CONFIG_CRYPTO_DEV_NITROX_CNN55XX=m
# CONFIG_CRYPTO_DEV_VIRTIO is not set
# CONFIG_CRYPTO_DEV_SAFEXCEL is not set
# CONFIG_CRYPTO_DEV_AMLOGIC_GXL is not set
CONFIG_ASYMMETRIC_KEY_TYPE=y
CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=y
# CONFIG_ASYMMETRIC_TPM_KEY_SUBTYPE is not set
CONFIG_X509_CERTIFICATE_PARSER=y
# CONFIG_PKCS8_PRIVATE_KEY_PARSER is not set
CONFIG_PKCS7_MESSAGE_PARSER=y
# CONFIG_PKCS7_TEST_KEY is not set
CONFIG_SIGNED_PE_FILE_VERIFICATION=y

#
# Certificates for signature checking
#
CONFIG_MODULE_SIG_KEY="certs/signing_key.pem"
CONFIG_SYSTEM_TRUSTED_KEYRING=y
CONFIG_SYSTEM_TRUSTED_KEYS=""
# CONFIG_SYSTEM_EXTRA_CERTIFICATE is not set
# CONFIG_SECONDARY_TRUSTED_KEYRING is not set
CONFIG_SYSTEM_BLACKLIST_KEYRING=y
CONFIG_SYSTEM_BLACKLIST_HASH_LIST=""
# end of Certificates for signature checking

CONFIG_BINARY_PRINTF=y

#
# Library routines
#
CONFIG_RAID6_PQ=m
CONFIG_RAID6_PQ_BENCHMARK=y
# CONFIG_PACKING is not set
CONFIG_BITREVERSE=y
CONFIG_GENERIC_STRNCPY_FROM_USER=y
CONFIG_GENERIC_STRNLEN_USER=y
CONFIG_GENERIC_NET_UTILS=y
CONFIG_GENERIC_FIND_FIRST_BIT=y
CONFIG_CORDIC=m
# CONFIG_PRIME_NUMBERS is not set
CONFIG_RATIONAL=y
CONFIG_GENERIC_PCI_IOMAP=y
CONFIG_GENERIC_IOMAP=y
CONFIG_ARCH_USE_CMPXCHG_LOCKREF=y
CONFIG_ARCH_HAS_FAST_MULTIPLIER=y
CONFIG_ARCH_USE_SYM_ANNOTATIONS=y
CONFIG_CRC_CCITT=y
CONFIG_CRC16=y
CONFIG_CRC_T10DIF=y
CONFIG_CRC_ITU_T=m
CONFIG_CRC32=y
# CONFIG_CRC32_SELFTEST is not set
CONFIG_CRC32_SLICEBY8=y
# CONFIG_CRC32_SLICEBY4 is not set
# CONFIG_CRC32_SARWATE is not set
# CONFIG_CRC32_BIT is not set
# CONFIG_CRC64 is not set
# CONFIG_CRC4 is not set
CONFIG_CRC7=m
CONFIG_LIBCRC32C=m
CONFIG_CRC8=m
CONFIG_XXHASH=y
# CONFIG_RANDOM32_SELFTEST is not set
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_LZO_COMPRESS=y
CONFIG_LZO_DECOMPRESS=y
CONFIG_LZ4_DECOMPRESS=y
CONFIG_ZSTD_COMPRESS=m
CONFIG_ZSTD_DECOMPRESS=y
CONFIG_XZ_DEC=y
CONFIG_XZ_DEC_X86=y
CONFIG_XZ_DEC_POWERPC=y
CONFIG_XZ_DEC_IA64=y
CONFIG_XZ_DEC_ARM=y
CONFIG_XZ_DEC_ARMTHUMB=y
CONFIG_XZ_DEC_SPARC=y
CONFIG_XZ_DEC_BCJ=y
# CONFIG_XZ_DEC_TEST is not set
CONFIG_DECOMPRESS_GZIP=y
CONFIG_DECOMPRESS_BZIP2=y
CONFIG_DECOMPRESS_LZMA=y
CONFIG_DECOMPRESS_XZ=y
CONFIG_DECOMPRESS_LZO=y
CONFIG_DECOMPRESS_LZ4=y
CONFIG_DECOMPRESS_ZSTD=y
CONFIG_GENERIC_ALLOCATOR=y
CONFIG_REED_SOLOMON=m
CONFIG_REED_SOLOMON_ENC8=y
CONFIG_REED_SOLOMON_DEC8=y
CONFIG_TEXTSEARCH=y
CONFIG_TEXTSEARCH_KMP=m
CONFIG_TEXTSEARCH_BM=m
CONFIG_TEXTSEARCH_FSM=m
CONFIG_INTERVAL_TREE=y
CONFIG_XARRAY_MULTI=y
CONFIG_ASSOCIATIVE_ARRAY=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT_MAP=y
CONFIG_HAS_DMA=y
CONFIG_DMA_OPS=y
CONFIG_NEED_SG_DMA_LENGTH=y
CONFIG_NEED_DMA_MAP_STATE=y
CONFIG_ARCH_DMA_ADDR_T_64BIT=y
CONFIG_ARCH_HAS_FORCE_DMA_UNENCRYPTED=y
CONFIG_DMA_VIRT_OPS=y
CONFIG_SWIOTLB=y
CONFIG_DMA_COHERENT_POOL=y
CONFIG_DMA_CMA=y
# CONFIG_DMA_PERNUMA_CMA is not set

#
# Default contiguous memory area size:
#
CONFIG_CMA_SIZE_MBYTES=200
CONFIG_CMA_SIZE_SEL_MBYTES=y
# CONFIG_CMA_SIZE_SEL_PERCENTAGE is not set
# CONFIG_CMA_SIZE_SEL_MIN is not set
# CONFIG_CMA_SIZE_SEL_MAX is not set
CONFIG_CMA_ALIGNMENT=8
# CONFIG_DMA_API_DEBUG is not set
CONFIG_SGL_ALLOC=y
CONFIG_CHECK_SIGNATURE=y
CONFIG_CPUMASK_OFFSTACK=y
CONFIG_CPU_RMAP=y
CONFIG_DQL=y
CONFIG_GLOB=y
# CONFIG_GLOB_SELFTEST is not set
CONFIG_NLATTR=y
CONFIG_CLZ_TAB=y
CONFIG_IRQ_POLL=y
CONFIG_MPILIB=y
CONFIG_SIGNATURE=y
CONFIG_DIMLIB=y
CONFIG_OID_REGISTRY=y
CONFIG_UCS2_STRING=y
CONFIG_HAVE_GENERIC_VDSO=y
CONFIG_GENERIC_GETTIMEOFDAY=y
CONFIG_GENERIC_VDSO_TIME_NS=y
CONFIG_FONT_SUPPORT=y
# CONFIG_FONTS is not set
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y
CONFIG_SG_POOL=y
CONFIG_ARCH_HAS_PMEM_API=y
CONFIG_MEMREGION=y
CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE=y
CONFIG_ARCH_HAS_COPY_MC=y
CONFIG_ARCH_STACKWALK=y
CONFIG_SBITMAP=y
# CONFIG_STRING_SELFTEST is not set
# end of Library routines

#
# Kernel hacking
#

#
# printk and dmesg options
#
CONFIG_PRINTK_TIME=y
# CONFIG_PRINTK_CALLER is not set
CONFIG_CONSOLE_LOGLEVEL_DEFAULT=7
CONFIG_CONSOLE_LOGLEVEL_QUIET=4
CONFIG_MESSAGE_LOGLEVEL_DEFAULT=4
CONFIG_BOOT_PRINTK_DELAY=y
CONFIG_DYNAMIC_DEBUG=y
CONFIG_DYNAMIC_DEBUG_CORE=y
CONFIG_SYMBOLIC_ERRNAME=y
CONFIG_DEBUG_BUGVERBOSE=y
# end of printk and dmesg options

#
# Compile-time checks and compiler options
#
CONFIG_DEBUG_INFO=y
CONFIG_DEBUG_INFO_REDUCED=y
# CONFIG_DEBUG_INFO_COMPRESSED is not set
# CONFIG_DEBUG_INFO_SPLIT is not set
CONFIG_DEBUG_INFO_DWARF4=y
# CONFIG_GDB_SCRIPTS is not set
CONFIG_ENABLE_MUST_CHECK=y
CONFIG_FRAME_WARN=2048
CONFIG_STRIP_ASM_SYMS=y
# CONFIG_READABLE_ASM is not set
# CONFIG_HEADERS_INSTALL is not set
CONFIG_DEBUG_SECTION_MISMATCH=y
CONFIG_SECTION_MISMATCH_WARN_ONLY=y
CONFIG_STACK_VALIDATION=y
# CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
# end of Compile-time checks and compiler options

#
# Generic Kernel Debugging Instruments
#
CONFIG_MAGIC_SYSRQ=y
CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x1
CONFIG_MAGIC_SYSRQ_SERIAL=y
CONFIG_MAGIC_SYSRQ_SERIAL_SEQUENCE=""
CONFIG_DEBUG_FS=y
CONFIG_DEBUG_FS_ALLOW_ALL=y
# CONFIG_DEBUG_FS_DISALLOW_MOUNT is not set
# CONFIG_DEBUG_FS_ALLOW_NONE is not set
CONFIG_HAVE_ARCH_KGDB=y
# CONFIG_KGDB is not set
CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
# CONFIG_UBSAN is not set
CONFIG_HAVE_ARCH_KCSAN=y
# end of Generic Kernel Debugging Instruments

CONFIG_DEBUG_KERNEL=y
CONFIG_DEBUG_MISC=y

#
# Memory Debugging
#
# CONFIG_PAGE_EXTENSION is not set
# CONFIG_DEBUG_PAGEALLOC is not set
# CONFIG_PAGE_OWNER is not set
# CONFIG_PAGE_POISONING is not set
# CONFIG_DEBUG_PAGE_REF is not set
# CONFIG_DEBUG_RODATA_TEST is not set
CONFIG_ARCH_HAS_DEBUG_WX=y
# CONFIG_DEBUG_WX is not set
CONFIG_GENERIC_PTDUMP=y
# CONFIG_PTDUMP_DEBUGFS is not set
# CONFIG_DEBUG_OBJECTS is not set
# CONFIG_SLUB_DEBUG_ON is not set
# CONFIG_SLUB_STATS is not set
CONFIG_HAVE_DEBUG_KMEMLEAK=y
# CONFIG_DEBUG_KMEMLEAK is not set
# CONFIG_DEBUG_STACK_USAGE is not set
# CONFIG_SCHED_STACK_END_CHECK is not set
CONFIG_ARCH_HAS_DEBUG_VM_PGTABLE=y
# CONFIG_DEBUG_VM is not set
# CONFIG_DEBUG_VM_PGTABLE is not set
CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
# CONFIG_DEBUG_VIRTUAL is not set
CONFIG_DEBUG_MEMORY_INIT=y
# CONFIG_DEBUG_PER_CPU_MAPS is not set
CONFIG_HAVE_ARCH_KASAN=y
CONFIG_HAVE_ARCH_KASAN_VMALLOC=y
CONFIG_CC_HAS_KASAN_GENERIC=y
CONFIG_CC_HAS_WORKING_NOSANITIZE_ADDRESS=y
# CONFIG_KASAN is not set
# end of Memory Debugging

CONFIG_DEBUG_SHIRQ=y

#
# Debug Oops, Lockups and Hangs
#
CONFIG_PANIC_ON_OOPS=y
CONFIG_PANIC_ON_OOPS_VALUE=1
CONFIG_PANIC_TIMEOUT=0
CONFIG_LOCKUP_DETECTOR=y
CONFIG_SOFTLOCKUP_DETECTOR=y
# CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC is not set
CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC_VALUE=0
CONFIG_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HARDLOCKUP_CHECK_TIMESTAMP=y
CONFIG_HARDLOCKUP_DETECTOR=y
CONFIG_BOOTPARAM_HARDLOCKUP_PANIC=y
CONFIG_BOOTPARAM_HARDLOCKUP_PANIC_VALUE=1
# CONFIG_DETECT_HUNG_TASK is not set
# CONFIG_WQ_WATCHDOG is not set
# CONFIG_TEST_LOCKUP is not set
# end of Debug Oops, Lockups and Hangs

#
# Scheduler Debugging
#
CONFIG_SCHED_DEBUG=y
CONFIG_SCHED_INFO=y
CONFIG_SCHEDSTATS=y
# end of Scheduler Debugging

# CONFIG_DEBUG_TIMEKEEPING is not set

#
# Lock Debugging (spinlocks, mutexes, etc...)
#
CONFIG_LOCK_DEBUGGING_SUPPORT=y
# CONFIG_PROVE_LOCKING is not set
# CONFIG_LOCK_STAT is not set
# CONFIG_DEBUG_RT_MUTEXES is not set
# CONFIG_DEBUG_SPINLOCK is not set
# CONFIG_DEBUG_MUTEXES is not set
# CONFIG_DEBUG_WW_MUTEX_SLOWPATH is not set
# CONFIG_DEBUG_RWSEMS is not set
# CONFIG_DEBUG_LOCK_ALLOC is not set
CONFIG_DEBUG_ATOMIC_SLEEP=y
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
CONFIG_LOCK_TORTURE_TEST=m
# CONFIG_WW_MUTEX_SELFTEST is not set
# CONFIG_SCF_TORTURE_TEST is not set
# CONFIG_CSD_LOCK_WAIT_DEBUG is not set
# end of Lock Debugging (spinlocks, mutexes, etc...)

CONFIG_STACKTRACE=y
# CONFIG_WARN_ALL_UNSEEDED_RANDOM is not set
# CONFIG_DEBUG_KOBJECT is not set

#
# Debug kernel data structures
#
CONFIG_DEBUG_LIST=y
# CONFIG_DEBUG_PLIST is not set
# CONFIG_DEBUG_SG is not set
# CONFIG_DEBUG_NOTIFIERS is not set
CONFIG_BUG_ON_DATA_CORRUPTION=y
# end of Debug kernel data structures

# CONFIG_DEBUG_CREDENTIALS is not set

#
# RCU Debugging
#
CONFIG_TORTURE_TEST=m
# CONFIG_RCU_SCALE_TEST is not set
CONFIG_RCU_TORTURE_TEST=m
# CONFIG_RCU_REF_SCALE_TEST is not set
CONFIG_RCU_CPU_STALL_TIMEOUT=60
# CONFIG_RCU_TRACE is not set
# CONFIG_RCU_EQS_DEBUG is not set
# end of RCU Debugging

# CONFIG_DEBUG_WQ_FORCE_RR_CPU is not set
# CONFIG_DEBUG_BLOCK_EXT_DEVT is not set
# CONFIG_CPU_HOTPLUG_STATE_CONTROL is not set
CONFIG_LATENCYTOP=y
CONFIG_USER_STACKTRACE_SUPPORT=y
CONFIG_NOP_TRACER=y
CONFIG_HAVE_FUNCTION_TRACER=y
CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
CONFIG_HAVE_DYNAMIC_FTRACE=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=y
CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
CONFIG_HAVE_FENTRY=y
CONFIG_HAVE_C_RECORDMCOUNT=y
CONFIG_TRACER_MAX_TRACE=y
CONFIG_TRACE_CLOCK=y
CONFIG_RING_BUFFER=y
CONFIG_EVENT_TRACING=y
CONFIG_CONTEXT_SWITCH_TRACER=y
CONFIG_RING_BUFFER_ALLOW_SWAP=y
CONFIG_TRACING=y
CONFIG_GENERIC_TRACER=y
CONFIG_TRACING_SUPPORT=y
CONFIG_FTRACE=y
# CONFIG_BOOTTIME_TRACING is not set
CONFIG_FUNCTION_TRACER=y
CONFIG_FUNCTION_GRAPH_TRACER=y
CONFIG_DYNAMIC_FTRACE=y
CONFIG_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=y
CONFIG_FUNCTION_PROFILER=y
CONFIG_STACK_TRACER=y
# CONFIG_IRQSOFF_TRACER is not set
CONFIG_SCHED_TRACER=y
CONFIG_HWLAT_TRACER=y
# CONFIG_MMIOTRACE is not set
CONFIG_FTRACE_SYSCALLS=y
CONFIG_TRACER_SNAPSHOT=y
# CONFIG_TRACER_SNAPSHOT_PER_CPU_SWAP is not set
CONFIG_BRANCH_PROFILE_NONE=y
# CONFIG_PROFILE_ANNOTATED_BRANCHES is not set
CONFIG_BLK_DEV_IO_TRACE=y
CONFIG_KPROBE_EVENTS=y
# CONFIG_KPROBE_EVENTS_ON_NOTRACE is not set
CONFIG_UPROBE_EVENTS=y
CONFIG_BPF_EVENTS=y
CONFIG_DYNAMIC_EVENTS=y
CONFIG_PROBE_EVENTS=y
# CONFIG_BPF_KPROBE_OVERRIDE is not set
CONFIG_FTRACE_MCOUNT_RECORD=y
CONFIG_TRACING_MAP=y
CONFIG_SYNTH_EVENTS=y
CONFIG_HIST_TRIGGERS=y
# CONFIG_TRACE_EVENT_INJECT is not set
# CONFIG_TRACEPOINT_BENCHMARK is not set
CONFIG_RING_BUFFER_BENCHMARK=m
# CONFIG_TRACE_EVAL_MAP_FILE is not set
# CONFIG_FTRACE_STARTUP_TEST is not set
# CONFIG_RING_BUFFER_STARTUP_TEST is not set
# CONFIG_PREEMPTIRQ_DELAY_TEST is not set
# CONFIG_SYNTH_EVENT_GEN_TEST is not set
# CONFIG_KPROBE_EVENT_GEN_TEST is not set
# CONFIG_HIST_TRIGGERS_DEBUG is not set
CONFIG_PROVIDE_OHCI1394_DMA_INIT=y
# CONFIG_SAMPLES is not set
CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y
CONFIG_STRICT_DEVMEM=y
# CONFIG_IO_STRICT_DEVMEM is not set

#
# x86 Debugging
#
CONFIG_TRACE_IRQFLAGS_SUPPORT=y
CONFIG_TRACE_IRQFLAGS_NMI_SUPPORT=y
CONFIG_EARLY_PRINTK_USB=y
CONFIG_X86_VERBOSE_BOOTUP=y
CONFIG_EARLY_PRINTK=y
CONFIG_EARLY_PRINTK_DBGP=y
CONFIG_EARLY_PRINTK_USB_XDBC=y
# CONFIG_EFI_PGT_DUMP is not set
# CONFIG_DEBUG_TLBFLUSH is not set
CONFIG_HAVE_MMIOTRACE_SUPPORT=y
CONFIG_X86_DECODER_SELFTEST=y
CONFIG_IO_DELAY_0X80=y
# CONFIG_IO_DELAY_0XED is not set
# CONFIG_IO_DELAY_UDELAY is not set
# CONFIG_IO_DELAY_NONE is not set
CONFIG_DEBUG_BOOT_PARAMS=y
# CONFIG_CPA_DEBUG is not set
# CONFIG_DEBUG_ENTRY is not set
# CONFIG_DEBUG_NMI_SELFTEST is not set
# CONFIG_X86_DEBUG_FPU is not set
# CONFIG_PUNIT_ATOM_DEBUG is not set
CONFIG_UNWINDER_ORC=y
# CONFIG_UNWINDER_FRAME_POINTER is not set
# end of x86 Debugging

#
# Kernel Testing and Coverage
#
CONFIG_KUNIT=y
# CONFIG_KUNIT_DEBUGFS is not set
CONFIG_KUNIT_TEST=m
CONFIG_KUNIT_EXAMPLE_TEST=m
# CONFIG_KUNIT_ALL_TESTS is not set
# CONFIG_NOTIFIER_ERROR_INJECTION is not set
CONFIG_FUNCTION_ERROR_INJECTION=y
CONFIG_FAULT_INJECTION=y
# CONFIG_FAILSLAB is not set
# CONFIG_FAIL_PAGE_ALLOC is not set
# CONFIG_FAULT_INJECTION_USERCOPY is not set
CONFIG_FAIL_MAKE_REQUEST=y
# CONFIG_FAIL_IO_TIMEOUT is not set
# CONFIG_FAIL_FUTEX is not set
CONFIG_FAULT_INJECTION_DEBUG_FS=y
# CONFIG_FAIL_FUNCTION is not set
# CONFIG_FAIL_MMC_REQUEST is not set
CONFIG_ARCH_HAS_KCOV=y
CONFIG_CC_HAS_SANCOV_TRACE_PC=y
# CONFIG_KCOV is not set
CONFIG_RUNTIME_TESTING_MENU=y
# CONFIG_LKDTM is not set
# CONFIG_TEST_LIST_SORT is not set
# CONFIG_TEST_MIN_HEAP is not set
# CONFIG_TEST_SORT is not set
# CONFIG_KPROBES_SANITY_TEST is not set
# CONFIG_BACKTRACE_SELF_TEST is not set
# CONFIG_RBTREE_TEST is not set
# CONFIG_REED_SOLOMON_TEST is not set
# CONFIG_INTERVAL_TREE_TEST is not set
# CONFIG_PERCPU_TEST is not set
CONFIG_ATOMIC64_SELFTEST=y
# CONFIG_ASYNC_RAID6_TEST is not set
# CONFIG_TEST_HEXDUMP is not set
# CONFIG_TEST_STRING_HELPERS is not set
# CONFIG_TEST_STRSCPY is not set
# CONFIG_TEST_KSTRTOX is not set
# CONFIG_TEST_PRINTF is not set
# CONFIG_TEST_BITMAP is not set
# CONFIG_TEST_UUID is not set
# CONFIG_TEST_XARRAY is not set
# CONFIG_TEST_OVERFLOW is not set
# CONFIG_TEST_RHASHTABLE is not set
# CONFIG_TEST_HASH is not set
# CONFIG_TEST_IDA is not set
# CONFIG_TEST_LKM is not set
# CONFIG_TEST_BITOPS is not set
# CONFIG_TEST_VMALLOC is not set
# CONFIG_TEST_USER_COPY is not set
CONFIG_TEST_BPF=m
# CONFIG_TEST_BLACKHOLE_DEV is not set
# CONFIG_FIND_BIT_BENCHMARK is not set
# CONFIG_TEST_FIRMWARE is not set
# CONFIG_TEST_SYSCTL is not set
# CONFIG_BITFIELD_KUNIT is not set
CONFIG_SYSCTL_KUNIT_TEST=m
CONFIG_LIST_KUNIT_TEST=m
# CONFIG_LINEAR_RANGES_TEST is not set
# CONFIG_BITS_TEST is not set
# CONFIG_TEST_UDELAY is not set
# CONFIG_TEST_STATIC_KEYS is not set
# CONFIG_TEST_KMOD is not set
# CONFIG_TEST_MEMCAT_P is not set
# CONFIG_TEST_LIVEPATCH is not set
# CONFIG_TEST_STACKINIT is not set
# CONFIG_TEST_MEMINIT is not set
# CONFIG_TEST_HMM is not set
# CONFIG_TEST_FREE_PAGES is not set
# CONFIG_TEST_FPU is not set
# CONFIG_MEMTEST is not set
# CONFIG_HYPERV_TESTING is not set
# end of Kernel Testing and Coverage
# end of Kernel hacking

--wRRV7LY7NUeQGEoC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=job-script

#!/bin/sh

export_top_env()
{
	export suite='vm-scalability'
	export testcase='vm-scalability'
	export category='benchmark'
	export runtime=300
	export size=8796093022208
	export job_origin='/lkp-src/allot/cyclic:p1:linux-devel:devel-hourly/lkp-csl-2ap4/vm-scalability.yaml'
	export queue_cmdline_keys='branch
commit
queue_at_least_once'
	export queue='validate'
	export testbox='lkp-csl-2ap4'
	export tbox_group='lkp-csl-2ap4'
	export kconfig='x86_64-rhel-8.3'
	export submit_id='5fb75d0c7d98c9151ca2faf3'
	export job_file='/lkp/jobs/scheduled/lkp-csl-2ap4/vm-scalability-performance-300s-8T-anon-cow-seq-mt-ucode=0x5003003-monitor=6e02c248-debian-10.4-x86_64-20200603.cgz-0dd6d5b8c0f6-20201120-5404-1kxav1r-3.yaml'
	export id='b5147bcd8cb8adaf22d7290b8755c225fd9777c0'
	export queuer_version='/lkp-src'
	export model='Cascade Lake'
	export nr_node=4
	export nr_cpu=192
	export memory='192G'
	export ssd_partitions='/dev/disk/by-id/nvme-INTEL_SSDPECME016T4_CVF87091000G1P6IGN-*-part1'
	export rootfs_partition='LABEL=LKP-ROOTFS'
	export kernel_cmdline_hw='acpi_rsdp=0x67f44014'
	export brand='Intel(R) Xeon(R) Platinum 9242 CPU @ 2.30GHz'
	export timeout='1h'
	export need_kconfig='CONFIG_BLK_DEV_LOOP'
	export commit='0dd6d5b8c0f6f31d8d557485fff4931600ae9848'
	export need_kconfig_hw='CONFIG_IGB=y
CONFIG_BLK_DEV_NVME'
	export ucode='0x5003003'
	export enqueue_time='2020-11-20 14:07:08 +0800'
	export _id='5fb75d0c7d98c9151ca2faf3'
	export _rt='/result/vm-scalability/performance-300s-8T-anon-cow-seq-mt-ucode=0x5003003-monitor=6e02c248/lkp-csl-2ap4/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/0dd6d5b8c0f6f31d8d557485fff4931600ae9848'
	export user='lkp'
	export compiler='gcc-9'
	export head_commit='18f412752047fb0c6874178efc98ae45a42bb79b'
	export base_commit='09162bc32c880a791c6c0668ce0745cf7958f576'
	export branch='linux-review/Alex-Kogan/Add-NUMA-awareness-to-qspinlock/20201118-072506'
	export rootfs='debian-10.4-x86_64-20200603.cgz'
	export monitor_sha='6e02c248'
	export result_root='/result/vm-scalability/performance-300s-8T-anon-cow-seq-mt-ucode=0x5003003-monitor=6e02c248/lkp-csl-2ap4/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/0dd6d5b8c0f6f31d8d557485fff4931600ae9848/3'
	export scheduler_version='/lkp/lkp/.src-20201120-103248'
	export LKP_SERVER='internal-lkp-server'
	export arch='x86_64'
	export max_uptime=3600
	export initrd='/osimage/debian/debian-10.4-x86_64-20200603.cgz'
	export bootloader_append='root=/dev/ram0
user=lkp
job=/lkp/jobs/scheduled/lkp-csl-2ap4/vm-scalability-performance-300s-8T-anon-cow-seq-mt-ucode=0x5003003-monitor=6e02c248-debian-10.4-x86_64-20200603.cgz-0dd6d5b8c0f6-20201120-5404-1kxav1r-3.yaml
ARCH=x86_64
kconfig=x86_64-rhel-8.3
branch=linux-review/Alex-Kogan/Add-NUMA-awareness-to-qspinlock/20201118-072506
commit=0dd6d5b8c0f6f31d8d557485fff4931600ae9848
BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3/gcc-9/0dd6d5b8c0f6f31d8d557485fff4931600ae9848/vmlinuz-5.10.0-rc3-00004-g0dd6d5b8c0f6
acpi_rsdp=0x67f44014
max_uptime=3600
RESULT_ROOT=/result/vm-scalability/performance-300s-8T-anon-cow-seq-mt-ucode=0x5003003-monitor=6e02c248/lkp-csl-2ap4/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/0dd6d5b8c0f6f31d8d557485fff4931600ae9848/3
LKP_SERVER=internal-lkp-server
nokaslr
selinux=0
debug
apic=debug
sysrq_always_enabled
rcupdate.rcu_cpu_stall_timeout=100
net.ifnames=0
printk.devkmsg=on
panic=-1
softlockup_panic=1
nmi_watchdog=panic
oops=panic
load_ramdisk=2
prompt_ramdisk=0
drbd.minor_count=8
systemd.log_level=err
ignore_loglevel
console=tty0
earlyprintk=ttyS0,115200
console=ttyS0,115200
vga=normal
rw'
	export modules_initrd='/pkg/linux/x86_64-rhel-8.3/gcc-9/0dd6d5b8c0f6f31d8d557485fff4931600ae9848/modules.cgz'
	export bm_initrd='/osimage/deps/debian-10.4-x86_64-20200603.cgz/run-ipconfig_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/lkp_20200709.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/rsync-rootfs_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/perf_20200723.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/perf-x86_64-eccc87672492-1_20201111.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/vm-scalability_20201110.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/vm-scalability-x86_64-1.0-0_20201110.cgz,/osimage/pkg/common/vm-scalability-x86_64.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/mpstat_20200714.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/sar-x86_64-34c92ae-1_20200702.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/hw_20200715.cgz'
	export ucode_initrd='/osimage/ucode/intel-ucode-20201117.cgz'
	export lkp_initrd='/osimage/user/lkp/lkp-x86_64.cgz'
	export site='inn'
	export LKP_CGI_PORT=80
	export LKP_CIFS_PORT=139
	export last_kernel='5.10.0-rc4'
	export repeat_to=4
	export schedule_notify_address=
	export queue_at_least_once=1
	export kernel='/pkg/linux/x86_64-rhel-8.3/gcc-9/0dd6d5b8c0f6f31d8d557485fff4931600ae9848/vmlinuz-5.10.0-rc3-00004-g0dd6d5b8c0f6'
	export dequeue_time='2020-11-20 14:08:42 +0800'
	export job_initrd='/lkp/jobs/scheduled/lkp-csl-2ap4/vm-scalability-performance-300s-8T-anon-cow-seq-mt-ucode=0x5003003-monitor=6e02c248-debian-10.4-x86_64-20200603.cgz-0dd6d5b8c0f6-20201120-5404-1kxav1r-3.cgz'

	[ -n "$LKP_SRC" ] ||
	export LKP_SRC=/lkp/${user:-lkp}/src
}

run_job()
{
	echo $$ > $TMP/run-job.pid

	. $LKP_SRC/lib/http.sh
	. $LKP_SRC/lib/job.sh
	. $LKP_SRC/lib/env.sh

	export_top_env

	run_setup $LKP_SRC/setup/cpufreq_governor 'performance'

	run_monitor $LKP_SRC/monitors/no-stdout/wrapper perf-profile
	run_monitor $LKP_SRC/monitors/wrapper kmsg
	run_monitor $LKP_SRC/monitors/no-stdout/wrapper boot-time
	run_monitor $LKP_SRC/monitors/wrapper uptime
	run_monitor $LKP_SRC/monitors/wrapper iostat
	run_monitor $LKP_SRC/monitors/wrapper heartbeat
	run_monitor $LKP_SRC/monitors/wrapper vmstat
	run_monitor $LKP_SRC/monitors/wrapper numa-numastat
	run_monitor $LKP_SRC/monitors/wrapper numa-vmstat
	run_monitor $LKP_SRC/monitors/wrapper numa-meminfo
	run_monitor $LKP_SRC/monitors/wrapper proc-vmstat
	run_monitor $LKP_SRC/monitors/wrapper proc-stat
	run_monitor $LKP_SRC/monitors/wrapper meminfo
	run_monitor $LKP_SRC/monitors/wrapper slabinfo
	run_monitor $LKP_SRC/monitors/wrapper interrupts
	run_monitor $LKP_SRC/monitors/wrapper lock_stat
	run_monitor $LKP_SRC/monitors/wrapper latency_stats
	run_monitor $LKP_SRC/monitors/wrapper softirqs
	run_monitor $LKP_SRC/monitors/one-shot/wrapper bdi_dev_mapping
	run_monitor $LKP_SRC/monitors/wrapper diskstats
	run_monitor $LKP_SRC/monitors/wrapper nfsstat
	run_monitor $LKP_SRC/monitors/wrapper cpuidle
	run_monitor $LKP_SRC/monitors/wrapper cpufreq-stats
	run_monitor $LKP_SRC/monitors/wrapper sched_debug
	run_monitor $LKP_SRC/monitors/wrapper perf-stat
	run_monitor $LKP_SRC/monitors/wrapper mpstat
	run_monitor $LKP_SRC/monitors/wrapper oom-killer
	run_monitor $LKP_SRC/monitors/plain/watchdog

	run_test test='anon-cow-seq-mt' $LKP_SRC/tests/wrapper vm-scalability
}

extract_stats()
{
	export stats_part_begin=
	export stats_part_end=

	$LKP_SRC/stats/wrapper perf-profile
	$LKP_SRC/stats/wrapper vm-scalability
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper boot-time
	$LKP_SRC/stats/wrapper uptime
	$LKP_SRC/stats/wrapper iostat
	$LKP_SRC/stats/wrapper vmstat
	$LKP_SRC/stats/wrapper numa-numastat
	$LKP_SRC/stats/wrapper numa-vmstat
	$LKP_SRC/stats/wrapper numa-meminfo
	$LKP_SRC/stats/wrapper proc-vmstat
	$LKP_SRC/stats/wrapper meminfo
	$LKP_SRC/stats/wrapper slabinfo
	$LKP_SRC/stats/wrapper interrupts
	$LKP_SRC/stats/wrapper lock_stat
	$LKP_SRC/stats/wrapper latency_stats
	$LKP_SRC/stats/wrapper softirqs
	$LKP_SRC/stats/wrapper diskstats
	$LKP_SRC/stats/wrapper nfsstat
	$LKP_SRC/stats/wrapper cpuidle
	$LKP_SRC/stats/wrapper sched_debug
	$LKP_SRC/stats/wrapper perf-stat
	$LKP_SRC/stats/wrapper mpstat

	$LKP_SRC/stats/wrapper time vm-scalability.time
	$LKP_SRC/stats/wrapper dmesg
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper last_state
	$LKP_SRC/stats/wrapper stderr
	$LKP_SRC/stats/wrapper time
}

"$@"

--wRRV7LY7NUeQGEoC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="job.yaml"

---

#! jobs/vm-scalability.yaml
suite: vm-scalability
testcase: vm-scalability
category: benchmark
perf-profile: 
runtime: 300s
size: 8T
vm-scalability:
  test: anon-cow-seq-mt
job_origin: "/lkp-src/allot/cyclic:p1:linux-devel:devel-hourly/lkp-csl-2ap4/vm-scalability.yaml"

#! queue options
queue_cmdline_keys:
- branch
- commit
- queue_at_least_once
queue: bisect
testbox: lkp-csl-2ap4
tbox_group: lkp-csl-2ap4
kconfig: x86_64-rhel-8.3
submit_id: 5fb7520b6792f81311d9e7d0
job_file: "/lkp/jobs/scheduled/lkp-csl-2ap4/vm-scalability-performance-300s-8T-anon-cow-seq-mt-ucode=0x5003003-monitor=6e02c248-debian-10.4-x86_64-20200603.cgz-0dd6d5b8c0f6-20201120-4881-z8bm8q-1.yaml"
id: 8310a89d5b14932910de3e73a787f1814ed3f56d
queuer_version: "/lkp-src"

#! hosts/lkp-csl-2ap4
model: Cascade Lake
nr_node: 4
nr_cpu: 192
memory: 192G
ssd_partitions: "/dev/disk/by-id/nvme-INTEL_SSDPECME016T4_CVF87091000G1P6IGN-*-part1"
rootfs_partition: LABEL=LKP-ROOTFS
kernel_cmdline_hw: acpi_rsdp=0x67f44014
brand: Intel(R) Xeon(R) Platinum 9242 CPU @ 2.30GHz

#! include/category/benchmark
kmsg: 
boot-time: 
uptime: 
iostat: 
heartbeat: 
vmstat: 
numa-numastat: 
numa-vmstat: 
numa-meminfo: 
proc-vmstat: 
proc-stat: 
meminfo: 
slabinfo: 
interrupts: 
lock_stat: 
latency_stats: 
softirqs: 
bdi_dev_mapping: 
diskstats: 
nfsstat: 
cpuidle: 
cpufreq-stats: 
sched_debug: 
perf-stat: 
mpstat: 

#! include/category/ALL
cpufreq_governor: performance

#! include/vm-scalability
timeout: 1h
need_kconfig: CONFIG_BLK_DEV_LOOP

#! include/queue/cyclic
commit: 0dd6d5b8c0f6f31d8d557485fff4931600ae9848

#! include/testbox/lkp-csl-2ap4
need_kconfig_hw:
- CONFIG_IGB=y
- CONFIG_BLK_DEV_NVME
ucode: '0x5003003'
enqueue_time: 2020-11-20 13:20:11.292432387 +08:00
_id: 5fb754306792f81311d9e7d1
_rt: "/result/vm-scalability/performance-300s-8T-anon-cow-seq-mt-ucode=0x5003003-monitor=6e02c248/lkp-csl-2ap4/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/0dd6d5b8c0f6f31d8d557485fff4931600ae9848"

#! schedule options
user: lkp
compiler: gcc-9
head_commit: 18f412752047fb0c6874178efc98ae45a42bb79b
base_commit: '09162bc32c880a791c6c0668ce0745cf7958f576'
branch: linux-devel/devel-hourly-2020111920
rootfs: debian-10.4-x86_64-20200603.cgz
monitor_sha: 6e02c248
result_root: "/result/vm-scalability/performance-300s-8T-anon-cow-seq-mt-ucode=0x5003003-monitor=6e02c248/lkp-csl-2ap4/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/0dd6d5b8c0f6f31d8d557485fff4931600ae9848/0"
scheduler_version: "/lkp/lkp/.src-20201120-103248"
LKP_SERVER: internal-lkp-server
arch: x86_64
max_uptime: 3600
initrd: "/osimage/debian/debian-10.4-x86_64-20200603.cgz"
bootloader_append:
- root=/dev/ram0
- user=lkp
- job=/lkp/jobs/scheduled/lkp-csl-2ap4/vm-scalability-performance-300s-8T-anon-cow-seq-mt-ucode=0x5003003-monitor=6e02c248-debian-10.4-x86_64-20200603.cgz-0dd6d5b8c0f6-20201120-4881-z8bm8q-1.yaml
- ARCH=x86_64
- kconfig=x86_64-rhel-8.3
- branch=linux-devel/devel-hourly-2020111920
- commit=0dd6d5b8c0f6f31d8d557485fff4931600ae9848
- BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3/gcc-9/0dd6d5b8c0f6f31d8d557485fff4931600ae9848/vmlinuz-5.10.0-rc3-00004-g0dd6d5b8c0f6
- acpi_rsdp=0x67f44014
- max_uptime=3600
- RESULT_ROOT=/result/vm-scalability/performance-300s-8T-anon-cow-seq-mt-ucode=0x5003003-monitor=6e02c248/lkp-csl-2ap4/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/0dd6d5b8c0f6f31d8d557485fff4931600ae9848/0
- LKP_SERVER=internal-lkp-server
- nokaslr
- selinux=0
- debug
- apic=debug
- sysrq_always_enabled
- rcupdate.rcu_cpu_stall_timeout=100
- net.ifnames=0
- printk.devkmsg=on
- panic=-1
- softlockup_panic=1
- nmi_watchdog=panic
- oops=panic
- load_ramdisk=2
- prompt_ramdisk=0
- drbd.minor_count=8
- systemd.log_level=err
- ignore_loglevel
- console=tty0
- earlyprintk=ttyS0,115200
- console=ttyS0,115200
- vga=normal
- rw
modules_initrd: "/pkg/linux/x86_64-rhel-8.3/gcc-9/0dd6d5b8c0f6f31d8d557485fff4931600ae9848/modules.cgz"
bm_initrd: "/osimage/deps/debian-10.4-x86_64-20200603.cgz/run-ipconfig_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/lkp_20200709.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/rsync-rootfs_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/perf_20200723.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/perf-x86_64-eccc87672492-1_20201111.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/vm-scalability_20201110.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/vm-scalability-x86_64-1.0-0_20201110.cgz,/osimage/pkg/common/vm-scalability-x86_64.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/mpstat_20200714.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/sar-x86_64-34c92ae-1_20200702.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/hw_20200715.cgz"
ucode_initrd: "/osimage/ucode/intel-ucode-20201117.cgz"
lkp_initrd: "/osimage/user/lkp/lkp-x86_64.cgz"
site: inn

#! /lkp/lkp/.src-20201119-155552/include/site/inn
LKP_CGI_PORT: 80
LKP_CIFS_PORT: 139
oom-killer: 
watchdog: 

#! runtime status
last_kernel: 5.10.0-rc4-wt-ath-07774-g989cd8990fb5
repeat_to: 2
schedule_notify_address: 

#! user overrides
queue_at_least_once: 0
kernel: "/pkg/linux/x86_64-rhel-8.3/gcc-9/0dd6d5b8c0f6f31d8d557485fff4931600ae9848/vmlinuz-5.10.0-rc3-00004-g0dd6d5b8c0f6"
dequeue_time: 2020-11-20 13:31:26.067151228 +08:00

#! /lkp/lkp/.src-20201120-103248/include/site/inn
job_state: finished
loadavg: 126.79 110.95 50.76 1/1295 12066
start_time: '1605850780'
end_time: '1605851082'
version: "/lkp/lkp/.src-20201120-103340:7892b977-dirty:6825b0140"

--wRRV7LY7NUeQGEoC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=reproduce


for cpu_dir in /sys/devices/system/cpu/cpu[0-9]*
do
	online_file="$cpu_dir"/online
	[ -f "$online_file" ] && [ "$(cat "$online_file")" -eq 0 ] && continue

	file="$cpu_dir"/cpufreq/scaling_governor
	[ -f "$file" ] && echo "performance" > "$file"
done

cd /lkp/benchmarks/vm-scalability
 mount -t tmpfs -o size=100% vm-scalability-tmp /tmp/vm-scalability-tmp
 truncate -s 202462584832 /tmp/vm-scalability-tmp/vm-scalability.img
 mkfs.xfs -q /tmp/vm-scalability-tmp/vm-scalability.img
 mount -o loop /tmp/vm-scalability-tmp/vm-scalability.img /tmp/vm-scalability-tmp/vm-scalability
 ./case-anon-cow-seq-mt
 ./usemem --runtime 300 -t 192 --prealloc --prefault 50615646208
 umount /tmp/vm-scalability-tmp/vm-scalability
 rm /tmp/vm-scalability-tmp/vm-scalability.img
 umount /tmp/vm-scalability-tmp

--wRRV7LY7NUeQGEoC--
