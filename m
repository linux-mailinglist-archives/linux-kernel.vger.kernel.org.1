Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CBEF282AEA
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Oct 2020 15:28:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726200AbgJDN2Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Oct 2020 09:28:16 -0400
Received: from mga02.intel.com ([134.134.136.20]:11245 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726073AbgJDN2Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Oct 2020 09:28:16 -0400
IronPort-SDR: orM2IaWX0bzX42EZ6om3cGyNll200tt+zptK3ewISQ2w7k/5bHykvUXzP4Cwnv+K7vCTY2lUeT
 NZdTsDyHhuPQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9763"; a="150914035"
X-IronPort-AV: E=Sophos;i="5.77,335,1596524400"; 
   d="yaml'?scan'208";a="150914035"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2020 06:28:08 -0700
IronPort-SDR: N4WwNLy4ZYWGAcXIJF3DKtvn+Yimo0dV5KzRNAyOnMrniPlEd6H0JABQZ7fCqkLaXGoUAZOqE1
 u2lf6q+eVFoQ==
X-IronPort-AV: E=Sophos;i="5.77,335,1596524400"; 
   d="yaml'?scan'208";a="459156227"
Received: from shao2-debian.sh.intel.com (HELO localhost) ([10.239.13.3])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2020 06:28:02 -0700
Date:   Sun, 4 Oct 2020 21:27:16 +0800
From:   kernel test robot <rong.a.chen@intel.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Ingo Molnar <mingo@kernel.org>, Rik van Riel <riel@surriel.com>,
        Ben Segall <bsegall@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>, Mike Galbraith <efault@gmx.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com, ying.huang@intel.com, feng.tang@intel.com,
        zhengjun.xing@intel.com, aubrey.li@linux.intel.com,
        yu.c.chen@intel.com
Subject: [sched/fair] fcf0553db6: netperf.Throughput_Mbps -30.8% regression
Message-ID: <20201004132716.GS393@shao2-debian>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="rW45g2D1DgwV0HVw"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: NeoMutt/20170113 (1.7.2)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rW45g2D1DgwV0HVw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Greeting,

FYI, we noticed a -30.8% regression of netperf.Throughput_Mbps due to commit:


commit: fcf0553db6f4c79387864f6e4ab4a891601f395e ("sched/fair: Remove meaningless imbalance calculation")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master


in testcase: netperf
on test machine: 192 threads Intel(R) Xeon(R) Platinum 9242 CPU @ 2.30GHz with 192G memory
with following parameters:

	ip: ipv4
	runtime: 900s
	nr_threads: 50%
	cluster: cs-localhost
	test: TCP_STREAM
	cpufreq_governor: performance
	ucode: 0x5002f01

test-description: Netperf is a benchmark that can be use to measure various aspect of networking performance.
test-url: http://www.netperf.org/netperf/

In addition to that, the commit also has significant impact on the following tests:

+------------------+------------------------------------------------------------------------+
| testcase: change | vm-scalability: vm-scalability.throughput 1.5% improvement             |
| test machine     | 144 threads Intel(R) Xeon(R) CPU E7-8890 v3 @ 2.50GHz with 512G memory |
| test parameters  | cpufreq_governor=performance                                           |
|                  | runtime=300s                                                           |
|                  | size=8T                                                                |
|                  | test=anon-w-seq                                                        |
|                  | ucode=0x16                                                             |
+------------------+------------------------------------------------------------------------+


If you fix the issue, kindly add following tag
Reported-by: kernel test robot <rong.a.chen@intel.com>


Details are as below:
-------------------------------------------------------------------------------------------------->


To reproduce:

        git clone https://github.com/intel/lkp-tests.git
        cd lkp-tests
        bin/lkp install job.yaml  # job file is attached in this email
        bin/lkp run     job.yaml

=========================================================================================
cluster/compiler/cpufreq_governor/ip/kconfig/nr_threads/rootfs/runtime/tbox_group/test/testcase/ucode:
  cs-localhost/gcc-9/performance/ipv4/x86_64-rhel-8.3/50%/debian-10.4-x86_64-20200603.cgz/900s/lkp-csl-2ap3/TCP_STREAM/netperf/0x5002f01

commit: 
  a349834703 ("sched/fair: Rename sg_lb_stats::sum_nr_running to sum_h_nr_running")
  fcf0553db6 ("sched/fair: Remove meaningless imbalance calculation")

a349834703010183 fcf0553db6f4c79387864f6e4ab 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
      3242 ±  9%     -30.8%       2243 ±  5%  netperf.Throughput_Mbps
    311318 ±  9%     -30.8%     215389 ±  5%  netperf.Throughput_total_Mbps
   1481632 ± 44%    +121.8%    3286883 ± 29%  netperf.time.involuntary_context_switches
     43693 ±  3%     -23.1%      33615 ±  2%  netperf.time.minor_page_faults
 2.138e+09 ±  9%     -30.8%  1.479e+09 ±  5%  netperf.workload
   1042132 ±  8%     +13.6%    1183437 ±  8%  meminfo.DirectMap4k
    148685 ±  3%      +8.0%     160562 ±  3%  numa-meminfo.node3.Shmem
     24.60 ±  4%     -52.8%      11.60 ± 22%  vmstat.cpu.id
     74.40           +16.9%      87.00 ±  2%  vmstat.cpu.sy
    143.80           +17.0%     168.20 ±  2%  vmstat.procs.r
   1085464 ± 17%     -75.7%     263351 ± 30%  vmstat.system.cs
     24.75 ±  3%     -12.8       11.94 ± 21%  mpstat.cpu.all.idle%
      1.18 ±  5%      +0.2        1.41 ±  3%  mpstat.cpu.all.irq%
      1.56 ±  8%      -0.7        0.87 ± 12%  mpstat.cpu.all.soft%
     72.26           +13.3       85.59 ±  3%  mpstat.cpu.all.sys%
      0.26 ± 10%      -0.1        0.19 ±  9%  mpstat.cpu.all.usr%
 3.401e+09 ± 44%     -91.1%  3.012e+08 ± 32%  cpuidle.C1.time
 1.436e+08 ± 65%     -89.6%   14954139 ± 34%  cpuidle.C1.usage
 3.536e+10 ±  5%     -45.3%  1.932e+10 ± 24%  cpuidle.C1E.time
 4.126e+08 ±  7%     -66.1%  1.399e+08 ± 31%  cpuidle.C1E.usage
 5.227e+08 ±138%     -85.7%   74659149 ± 22%  cpuidle.POLL.time
   4914892 ± 99%     -86.6%     657190 ± 25%  cpuidle.POLL.usage
    332.80 ± 20%     -38.5%     204.80 ±  7%  slabinfo.biovec-64.active_objs
    332.80 ± 20%     -38.5%     204.80 ±  7%  slabinfo.biovec-64.num_objs
     47399 ±  2%     +12.9%      53505 ±  3%  slabinfo.skbuff_fclone_cache.active_objs
    743.80 ±  2%     +12.8%     838.80 ±  3%  slabinfo.skbuff_fclone_cache.active_slabs
     47625 ±  2%     +12.8%      53730 ±  3%  slabinfo.skbuff_fclone_cache.num_objs
    743.80 ±  2%     +12.8%     838.80 ±  3%  slabinfo.skbuff_fclone_cache.num_slabs
 2.361e+08 ±  5%     -20.7%  1.872e+08 ±  5%  numa-numastat.node0.local_node
 2.361e+08 ±  5%     -20.7%  1.872e+08 ±  5%  numa-numastat.node0.numa_hit
 2.767e+08 ± 13%     -34.5%  1.812e+08 ±  3%  numa-numastat.node1.local_node
 2.767e+08 ± 13%     -34.5%  1.812e+08 ±  3%  numa-numastat.node1.numa_hit
 2.555e+08 ±  8%     -29.6%  1.798e+08 ±  3%  numa-numastat.node2.local_node
 2.555e+08 ±  8%     -29.6%  1.799e+08 ±  3%  numa-numastat.node2.numa_hit
 3.029e+08 ± 40%     -35.6%  1.952e+08 ±  9%  numa-numastat.node3.local_node
 3.029e+08 ± 40%     -35.6%  1.952e+08 ±  9%  numa-numastat.node3.numa_hit
 1.197e+08 ±  7%     -19.7%   96054758 ±  5%  numa-vmstat.node0.numa_hit
 1.196e+08 ±  7%     -19.8%   95968475 ±  5%  numa-vmstat.node0.numa_local
 1.418e+08 ± 17%     -35.8%   90977174 ±  4%  numa-vmstat.node1.numa_hit
 1.418e+08 ± 17%     -35.9%   90926215 ±  4%  numa-vmstat.node1.numa_local
 1.252e+08 ±  6%     -28.4%   89645786 ±  5%  numa-vmstat.node2.numa_hit
  1.25e+08 ±  6%     -28.4%   89551187 ±  5%  numa-vmstat.node2.numa_local
 1.487e+08 ± 38%     -34.0%   98073664 ±  9%  numa-vmstat.node3.numa_hit
 1.486e+08 ± 38%     -34.1%   97983383 ±  9%  numa-vmstat.node3.numa_local
    125155            +2.2%     127953        proc-vmstat.nr_active_anon
    264519            +1.2%     267816        proc-vmstat.nr_file_pages
      6252 ±  2%      +6.3%       6647 ±  2%  proc-vmstat.nr_inactive_anon
     10301 ±  2%      +2.3%      10542        proc-vmstat.nr_mapped
     43102            +7.7%      46401 ±  3%  proc-vmstat.nr_shmem
    125155            +2.2%     127953        proc-vmstat.nr_zone_active_anon
      6252 ±  2%      +6.3%       6647 ±  2%  proc-vmstat.nr_zone_inactive_anon
    213957 ± 11%     -82.5%      37345 ± 20%  proc-vmstat.numa_hint_faults
    178876 ± 10%     -88.9%      19891 ± 40%  proc-vmstat.numa_hint_faults_local
 1.071e+09 ±  9%     -30.6%   7.43e+08 ±  5%  proc-vmstat.numa_hit
 1.071e+09 ±  9%     -30.6%  7.429e+08 ±  5%  proc-vmstat.numa_local
    237444 ± 15%     -72.4%      65597 ± 25%  proc-vmstat.numa_pte_updates
     40514 ±  3%     +31.5%      53282 ±  7%  proc-vmstat.pgactivate
 8.553e+09 ±  9%     -30.7%  5.929e+09 ±  5%  proc-vmstat.pgalloc_normal
   3599397            -5.3%    3407537        proc-vmstat.pgfault
 8.553e+09 ±  9%     -30.7%  5.929e+09 ±  5%  proc-vmstat.pgfree
    657361 ± 12%     -54.2%     301036 ± 26%  sched_debug.cfs_rq:/.MIN_vruntime.avg
   5121779 ±  9%     -34.6%    3348814 ± 20%  sched_debug.cfs_rq:/.MIN_vruntime.stddev
     73.53 ± 29%     +45.6%     107.09 ± 30%  sched_debug.cfs_rq:/.load_avg.max
    657361 ± 12%     -54.2%     301036 ± 26%  sched_debug.cfs_rq:/.max_vruntime.avg
   5121779 ±  9%     -34.6%    3348814 ± 20%  sched_debug.cfs_rq:/.max_vruntime.stddev
  50650339 ±  3%     +47.8%   74859779 ±  6%  sched_debug.cfs_rq:/.min_vruntime.avg
  62450655 ±  2%     +33.7%   83491916 ±  4%  sched_debug.cfs_rq:/.min_vruntime.max
  36914060 ±  5%     +61.8%   59739601 ± 13%  sched_debug.cfs_rq:/.min_vruntime.min
      0.73           +15.9%       0.84 ±  2%  sched_debug.cfs_rq:/.nr_running.avg
      0.40           -27.8%       0.29 ±  9%  sched_debug.cfs_rq:/.nr_running.stddev
   -994538          -957.6%    8528746 ± 32%  sched_debug.cfs_rq:/.spread0.avg
  10807042 ± 22%     +58.8%   17160375 ± 19%  sched_debug.cfs_rq:/.spread0.max
 -14731891           -55.3%   -6592382        sched_debug.cfs_rq:/.spread0.min
    741.02           +16.5%     862.98 ±  2%  sched_debug.cfs_rq:/.util_avg.avg
      0.57 ± 82%   +4756.2%      27.44 ± 38%  sched_debug.cfs_rq:/.util_avg.min
    367.90 ±  2%     -29.3%     260.00 ± 10%  sched_debug.cfs_rq:/.util_avg.stddev
    642383           +21.0%     777315 ±  3%  sched_debug.cpu.avg_idle.avg
    412048           -20.4%     328111 ±  5%  sched_debug.cpu.avg_idle.stddev
      2319 ± 32%     -31.8%       1582 ± 15%  sched_debug.cpu.clock_task.stddev
      2673           +17.7%       3147 ±  2%  sched_debug.cpu.curr->pid.avg
      1885           -16.0%       1583 ±  2%  sched_debug.cpu.curr->pid.stddev
      0.72           +16.5%       0.84 ±  2%  sched_debug.cpu.nr_running.avg
      0.41           -27.7%       0.30 ±  8%  sched_debug.cpu.nr_running.stddev
   2491773 ± 18%     -76.8%     578096 ± 29%  sched_debug.cpu.nr_switches.avg
   6795283 ± 36%     -74.9%    1707607 ± 36%  sched_debug.cpu.nr_switches.max
    478409 ± 15%     -96.4%      17371 ±105%  sched_debug.cpu.nr_switches.min
   1299648 ± 48%     -73.8%     340921 ± 32%  sched_debug.cpu.nr_switches.stddev
     27.38 ±  3%     -25.7%      20.35 ±  5%  perf-stat.i.MPKI
 9.812e+09 ±  4%      -5.5%  9.272e+09        perf-stat.i.branch-instructions
      0.81 ±  6%      -0.4        0.46 ± 10%  perf-stat.i.branch-miss-rate%
  80638412 ± 11%     -47.7%   42189389 ±  9%  perf-stat.i.branch-misses
     40.15 ±  8%     +20.5       60.60 ±  5%  perf-stat.i.cache-miss-rate%
 4.562e+08            +5.2%  4.798e+08        perf-stat.i.cache-misses
 1.207e+09 ±  9%     -33.2%  8.064e+08 ±  5%  perf-stat.i.cache-references
   1096573 ± 17%     -75.8%     265735 ± 29%  perf-stat.i.context-switches
     10.52 ±  5%     +25.7%      13.22 ±  2%  perf-stat.i.cpi
 4.508e+11           +15.6%   5.21e+11 ±  2%  perf-stat.i.cpu-cycles
     13047 ±  7%     -81.6%       2396 ± 23%  perf-stat.i.cpu-migrations
    992.80           +13.6%       1128 ±  5%  perf-stat.i.cycles-between-cache-misses
      0.02 ± 14%      -0.0        0.02 ±  9%  perf-stat.i.dTLB-load-miss-rate%
   2798302 ± 12%     -31.0%    1930060 ±  9%  perf-stat.i.dTLB-load-misses
 1.179e+10 ±  5%     -12.2%  1.036e+10        perf-stat.i.dTLB-loads
      0.13 ± 15%      +0.1        0.19 ± 15%  perf-stat.i.dTLB-store-miss-rate%
   4296580 ±  7%     -17.8%    3530350 ± 14%  perf-stat.i.dTLB-store-misses
  3.57e+09 ± 11%     -46.7%  1.901e+09 ±  8%  perf-stat.i.dTLB-stores
     78.03            +8.8       86.79 ±  2%  perf-stat.i.iTLB-load-miss-rate%
  51762078 ± 12%     -54.6%   23480553 ± 12%  perf-stat.i.iTLB-load-misses
  15349414 ± 16%     -74.0%    3985887 ± 27%  perf-stat.i.iTLB-loads
 4.351e+10 ±  4%      -9.3%  3.947e+10        perf-stat.i.instructions
    935.21 ±  8%     +90.8%       1784 ± 11%  perf-stat.i.instructions-per-iTLB-miss
      0.10 ±  5%     -21.5%       0.08 ±  2%  perf-stat.i.ipc
      2.35           +15.6%       2.71 ±  2%  perf-stat.i.metric.GHz
      0.12 ±  5%    +148.4%       0.31 ± 37%  perf-stat.i.metric.K/sec
    139.00 ±  5%     -15.2%     117.90        perf-stat.i.metric.M/sec
      3921            -5.5%       3706        perf-stat.i.minor-faults
     82.40           -30.1       52.35 ±  8%  perf-stat.i.node-load-miss-rate%
 1.602e+08 ±  2%     -30.0%  1.122e+08 ±  6%  perf-stat.i.node-load-misses
  34641208 ±  8%    +202.8%  1.049e+08 ± 10%  perf-stat.i.node-loads
     95.43            -8.8       86.63        perf-stat.i.node-store-miss-rate%
  95463384 ±  3%     -24.8%   71816176 ±  6%  perf-stat.i.node-store-misses
   4504280 ±  4%    +136.0%   10631682 ±  8%  perf-stat.i.node-stores
      3921            -5.5%       3706        perf-stat.i.page-faults
     27.61 ±  4%     -26.1%      20.40 ±  5%  perf-stat.overall.MPKI
      0.82 ±  7%      -0.4        0.45 ± 10%  perf-stat.overall.branch-miss-rate%
     38.34 ±  9%     +21.5       59.81 ±  5%  perf-stat.overall.cache-miss-rate%
     10.42 ±  5%     +26.7%      13.21 ±  2%  perf-stat.overall.cpi
    989.04            +9.8%       1085 ±  2%  perf-stat.overall.cycles-between-cache-misses
      0.02 ± 14%      -0.0        0.02 ±  9%  perf-stat.overall.dTLB-load-miss-rate%
      0.12 ± 16%      +0.1        0.19 ± 15%  perf-stat.overall.dTLB-store-miss-rate%
     77.26            +8.6       85.86 ±  2%  perf-stat.overall.iTLB-load-miss-rate%
    853.07 ±  7%    +100.6%       1711 ± 12%  perf-stat.overall.instructions-per-iTLB-miss
      0.10 ±  5%     -21.3%       0.08 ±  2%  perf-stat.overall.ipc
     82.05           -30.3       51.72 ±  8%  perf-stat.overall.node-load-miss-rate%
     95.46            -8.4       87.03        perf-stat.overall.node-store-miss-rate%
     18379 ±  4%     +31.1%      24093 ±  5%  perf-stat.overall.path-length
 9.785e+09 ±  4%      -5.4%  9.259e+09        perf-stat.ps.branch-instructions
  79985971 ± 11%     -47.5%   41978792 ±  9%  perf-stat.ps.branch-misses
  4.56e+08            +5.2%  4.795e+08        perf-stat.ps.cache-misses
   1.2e+09 ±  9%     -33.0%  8.039e+08 ±  5%  perf-stat.ps.cache-references
   1084462 ± 17%     -75.8%     262972 ± 30%  perf-stat.ps.context-switches
 4.509e+11           +15.5%  5.206e+11 ±  2%  perf-stat.ps.cpu-cycles
     12921 ±  8%     -81.6%       2375 ± 25%  perf-stat.ps.cpu-migrations
   2775208 ± 11%     -30.8%    1921057 ±  9%  perf-stat.ps.dTLB-load-misses
 1.175e+10 ±  5%     -12.0%  1.034e+10        perf-stat.ps.dTLB-loads
 3.542e+09 ± 11%     -46.5%  1.894e+09 ±  8%  perf-stat.ps.dTLB-stores
  51329779 ± 12%     -54.5%   23375015 ± 12%  perf-stat.ps.iTLB-load-misses
  15181049 ± 16%     -74.1%    3937533 ± 27%  perf-stat.ps.iTLB-loads
 4.337e+10 ±  4%      -9.1%  3.941e+10        perf-stat.ps.instructions
      3905            -5.5%       3690        perf-stat.ps.minor-faults
 1.598e+08 ±  2%     -29.9%  1.121e+08 ±  6%  perf-stat.ps.node-load-misses
  34957327 ±  8%    +200.2%  1.049e+08 ± 10%  perf-stat.ps.node-loads
  95360155 ±  3%     -24.7%   71759787 ±  6%  perf-stat.ps.node-store-misses
   4532465 ±  4%    +134.6%   10630923 ±  8%  perf-stat.ps.node-stores
      3905            -5.5%       3690        perf-stat.ps.page-faults
 3.911e+13 ±  4%      -9.1%  3.554e+13        perf-stat.total.instructions
     20018 ± 25%     -65.9%       6832 ± 32%  interrupts.CPU10.RES:Rescheduling_interrupts
      6930 ± 22%     +20.4%       8344 ±  3%  interrupts.CPU100.NMI:Non-maskable_interrupts
      6930 ± 22%     +20.4%       8344 ±  3%  interrupts.CPU100.PMI:Performance_monitoring_interrupts
     26175 ± 14%     -67.9%       8402 ± 48%  interrupts.CPU100.RES:Rescheduling_interrupts
     26256 ± 18%     -69.9%       7911 ± 26%  interrupts.CPU101.RES:Rescheduling_interrupts
     23953 ± 16%     -64.2%       8581 ± 24%  interrupts.CPU102.RES:Rescheduling_interrupts
     22838 ± 15%     -52.8%      10770 ± 55%  interrupts.CPU103.RES:Rescheduling_interrupts
     22692 ±  9%     -63.1%       8375 ± 60%  interrupts.CPU104.RES:Rescheduling_interrupts
     22355 ± 16%     -76.8%       5197 ± 73%  interrupts.CPU105.RES:Rescheduling_interrupts
     18887 ± 17%     -74.0%       4919 ± 27%  interrupts.CPU107.RES:Rescheduling_interrupts
     17905 ± 15%     -71.2%       5158 ± 70%  interrupts.CPU108.RES:Rescheduling_interrupts
     17658 ± 19%     -80.4%       3468 ± 65%  interrupts.CPU109.RES:Rescheduling_interrupts
     16137 ± 10%     -53.2%       7549 ± 47%  interrupts.CPU11.RES:Rescheduling_interrupts
     18899 ± 11%     -65.1%       6597 ± 32%  interrupts.CPU110.RES:Rescheduling_interrupts
      6906 ± 23%     +23.3%       8515        interrupts.CPU111.NMI:Non-maskable_interrupts
      6906 ± 23%     +23.3%       8515        interrupts.CPU111.PMI:Performance_monitoring_interrupts
     18144 ± 12%     -66.2%       6134 ± 82%  interrupts.CPU111.RES:Rescheduling_interrupts
     15208 ± 12%     -70.4%       4509 ± 65%  interrupts.CPU112.RES:Rescheduling_interrupts
     19107 ± 17%     -62.4%       7181 ± 63%  interrupts.CPU113.RES:Rescheduling_interrupts
     17575 ±  9%     -56.2%       7690 ± 69%  interrupts.CPU114.RES:Rescheduling_interrupts
     17096 ±  8%     -65.5%       5889 ± 85%  interrupts.CPU115.RES:Rescheduling_interrupts
     15285 ± 19%     -57.1%       6556 ± 26%  interrupts.CPU116.RES:Rescheduling_interrupts
     16701 ± 17%     -76.0%       4009 ± 42%  interrupts.CPU117.RES:Rescheduling_interrupts
     14198 ± 18%     -78.7%       3029 ± 43%  interrupts.CPU118.RES:Rescheduling_interrupts
     12635 ±  6%     -59.9%       5071 ± 42%  interrupts.CPU119.RES:Rescheduling_interrupts
    111.20 ± 39%     -66.0%      37.80 ± 54%  interrupts.CPU119.TLB:TLB_shootdowns
     21097 ± 21%     -67.3%       6890 ± 47%  interrupts.CPU12.RES:Rescheduling_interrupts
     38899 ± 13%     -77.7%       8664 ± 36%  interrupts.CPU120.RES:Rescheduling_interrupts
     35324 ± 16%     -78.9%       7468 ± 53%  interrupts.CPU121.RES:Rescheduling_interrupts
     30246 ± 15%     -77.3%       6857 ± 36%  interrupts.CPU122.RES:Rescheduling_interrupts
     29316 ± 15%     -76.0%       7025 ± 58%  interrupts.CPU123.RES:Rescheduling_interrupts
     26502 ± 17%     -63.4%       9695 ± 38%  interrupts.CPU124.RES:Rescheduling_interrupts
     25454 ± 13%     -65.1%       8892 ± 58%  interrupts.CPU125.RES:Rescheduling_interrupts
     25998 ± 28%     -76.8%       6034 ± 30%  interrupts.CPU126.RES:Rescheduling_interrupts
     27086 ± 15%     -70.2%       8084 ± 45%  interrupts.CPU127.RES:Rescheduling_interrupts
     21401 ± 19%     -72.4%       5899 ± 39%  interrupts.CPU128.RES:Rescheduling_interrupts
     23975 ± 18%     -71.6%       6800 ± 68%  interrupts.CPU129.RES:Rescheduling_interrupts
     19847 ± 17%     -65.9%       6763 ± 65%  interrupts.CPU13.RES:Rescheduling_interrupts
     20441 ± 23%     -66.6%       6836 ± 45%  interrupts.CPU130.RES:Rescheduling_interrupts
     20268 ± 28%     -67.9%       6508 ± 39%  interrupts.CPU131.RES:Rescheduling_interrupts
     19568 ± 17%     -77.4%       4420 ± 58%  interrupts.CPU132.RES:Rescheduling_interrupts
     18921 ± 22%     -63.0%       6991 ± 19%  interrupts.CPU133.RES:Rescheduling_interrupts
     19231 ± 18%     -70.1%       5746 ± 50%  interrupts.CPU134.RES:Rescheduling_interrupts
      5876 ± 27%     +43.5%       8430 ±  2%  interrupts.CPU135.NMI:Non-maskable_interrupts
      5876 ± 27%     +43.5%       8430 ±  2%  interrupts.CPU135.PMI:Performance_monitoring_interrupts
     18139 ± 15%     -64.8%       6388 ± 60%  interrupts.CPU135.RES:Rescheduling_interrupts
     17565 ± 22%     -68.7%       5505 ± 47%  interrupts.CPU136.RES:Rescheduling_interrupts
     18447 ± 14%     -80.5%       3592 ± 78%  interrupts.CPU137.RES:Rescheduling_interrupts
     15921 ± 28%     -62.6%       5948 ± 53%  interrupts.CPU138.RES:Rescheduling_interrupts
     15194 ± 24%     -60.3%       6029 ± 33%  interrupts.CPU139.RES:Rescheduling_interrupts
     19339 ± 21%     -70.7%       5667 ± 21%  interrupts.CPU14.RES:Rescheduling_interrupts
      6659 ± 25%     +23.0%       8190 ±  5%  interrupts.CPU140.NMI:Non-maskable_interrupts
      6659 ± 25%     +23.0%       8190 ±  5%  interrupts.CPU140.PMI:Performance_monitoring_interrupts
     15306 ± 19%     -62.2%       5782 ± 49%  interrupts.CPU140.RES:Rescheduling_interrupts
     14340 ± 11%     -72.7%       3913 ± 38%  interrupts.CPU141.RES:Rescheduling_interrupts
     10236 ± 26%     -60.4%       4056 ± 60%  interrupts.CPU142.RES:Rescheduling_interrupts
      9089 ±  9%     -44.5%       5045 ± 41%  interrupts.CPU143.RES:Rescheduling_interrupts
     36285 ± 13%     -82.8%       6248 ± 73%  interrupts.CPU144.RES:Rescheduling_interrupts
     35513 ± 12%     -75.3%       8776 ± 42%  interrupts.CPU145.RES:Rescheduling_interrupts
     31846 ± 10%     -81.0%       6036 ± 38%  interrupts.CPU146.RES:Rescheduling_interrupts
     27606 ± 15%     -81.5%       5099 ± 61%  interrupts.CPU147.RES:Rescheduling_interrupts
     28526 ± 17%     -77.8%       6335 ± 54%  interrupts.CPU148.RES:Rescheduling_interrupts
      5629 ± 35%     +43.8%       8093 ±  5%  interrupts.CPU149.NMI:Non-maskable_interrupts
      5629 ± 35%     +43.8%       8093 ±  5%  interrupts.CPU149.PMI:Performance_monitoring_interrupts
     23694 ±  9%     -65.5%       8176 ± 52%  interrupts.CPU149.RES:Rescheduling_interrupts
     17594 ± 23%     -60.3%       6977 ± 57%  interrupts.CPU15.RES:Rescheduling_interrupts
     25905 ± 15%     -73.6%       6827 ± 59%  interrupts.CPU150.RES:Rescheduling_interrupts
     24007 ± 17%     -83.4%       3992 ± 35%  interrupts.CPU151.RES:Rescheduling_interrupts
     26038 ± 21%     -69.0%       8076 ± 66%  interrupts.CPU152.RES:Rescheduling_interrupts
     22935 ±  7%     -66.6%       7668 ± 32%  interrupts.CPU153.RES:Rescheduling_interrupts
     62.60 ± 45%     -65.2%      21.80 ± 47%  interrupts.CPU153.TLB:TLB_shootdowns
     22072 ± 14%     -79.7%       4472 ± 57%  interrupts.CPU154.RES:Rescheduling_interrupts
     21397 ± 16%     -71.6%       6070 ± 41%  interrupts.CPU155.RES:Rescheduling_interrupts
     19854 ± 21%     -65.7%       6815 ± 72%  interrupts.CPU156.RES:Rescheduling_interrupts
     21814 ± 21%     -71.5%       6218 ± 95%  interrupts.CPU157.RES:Rescheduling_interrupts
     22265 ± 24%     -75.8%       5390 ± 46%  interrupts.CPU158.RES:Rescheduling_interrupts
     21240 ± 20%     -58.8%       8747 ± 52%  interrupts.CPU159.RES:Rescheduling_interrupts
     17437 ± 21%     -63.7%       6334 ± 29%  interrupts.CPU16.RES:Rescheduling_interrupts
     65.60 ± 56%     -67.1%      21.60 ± 67%  interrupts.CPU16.TLB:TLB_shootdowns
     17052 ±  9%     -62.5%       6396 ± 27%  interrupts.CPU160.RES:Rescheduling_interrupts
     15195 ±  6%     -72.1%       4245 ± 61%  interrupts.CPU161.RES:Rescheduling_interrupts
     14960 ± 24%     -55.0%       6730 ± 55%  interrupts.CPU162.RES:Rescheduling_interrupts
     17994 ± 16%     -64.3%       6426 ± 68%  interrupts.CPU163.RES:Rescheduling_interrupts
     14710 ± 13%     -58.7%       6076 ± 43%  interrupts.CPU164.RES:Rescheduling_interrupts
     11712 ± 14%     -48.4%       6041 ± 56%  interrupts.CPU165.RES:Rescheduling_interrupts
     11431 ± 14%     -42.6%       6562 ± 27%  interrupts.CPU167.RES:Rescheduling_interrupts
     37298 ±  7%     -76.3%       8847 ± 19%  interrupts.CPU168.RES:Rescheduling_interrupts
     35906 ± 10%     -68.3%      11386 ± 70%  interrupts.CPU169.RES:Rescheduling_interrupts
     16528 ± 34%     -65.4%       5723 ± 52%  interrupts.CPU17.RES:Rescheduling_interrupts
     33673 ± 15%     -76.9%       7761 ± 73%  interrupts.CPU170.RES:Rescheduling_interrupts
     65.40 ± 38%     -55.0%      29.40 ± 67%  interrupts.CPU170.TLB:TLB_shootdowns
     29357 ± 15%     -69.6%       8935 ± 39%  interrupts.CPU171.RES:Rescheduling_interrupts
     28550 ± 27%     -67.3%       9324 ± 78%  interrupts.CPU172.RES:Rescheduling_interrupts
     23625 ± 21%     -79.5%       4850 ± 71%  interrupts.CPU173.RES:Rescheduling_interrupts
     24733 ± 10%     -70.5%       7294 ± 74%  interrupts.CPU174.RES:Rescheduling_interrupts
     25344 ± 14%     -74.7%       6408 ± 68%  interrupts.CPU175.RES:Rescheduling_interrupts
     20908 ± 29%     -66.4%       7021 ± 45%  interrupts.CPU177.RES:Rescheduling_interrupts
     21900 ± 27%     -71.7%       6199 ± 75%  interrupts.CPU178.RES:Rescheduling_interrupts
     20672 ± 15%     -60.3%       8201 ± 57%  interrupts.CPU179.RES:Rescheduling_interrupts
     19053 ± 20%     -64.5%       6769 ± 39%  interrupts.CPU18.RES:Rescheduling_interrupts
     24900 ± 26%     -70.4%       7361 ± 71%  interrupts.CPU180.RES:Rescheduling_interrupts
     23027 ± 18%     -63.1%       8499 ± 59%  interrupts.CPU181.RES:Rescheduling_interrupts
     19105 ± 25%     -66.5%       6409 ± 46%  interrupts.CPU183.RES:Rescheduling_interrupts
     18049 ±  6%     -77.8%       4015 ± 59%  interrupts.CPU184.RES:Rescheduling_interrupts
     17829 ± 34%     -79.1%       3731 ± 97%  interrupts.CPU185.RES:Rescheduling_interrupts
     17896 ± 21%     -56.7%       7741 ± 64%  interrupts.CPU187.RES:Rescheduling_interrupts
     19615 ± 25%     -68.4%       6205 ± 45%  interrupts.CPU188.RES:Rescheduling_interrupts
      5762 ± 37%     +20.6%       6948 ± 28%  interrupts.CPU189.NMI:Non-maskable_interrupts
      5762 ± 37%     +20.6%       6948 ± 28%  interrupts.CPU189.PMI:Performance_monitoring_interrupts
     18061 ± 16%     -65.4%       6251 ± 53%  interrupts.CPU19.RES:Rescheduling_interrupts
     20448 ± 24%     -68.6%       6426 ± 41%  interrupts.CPU20.RES:Rescheduling_interrupts
     60.60 ± 57%     -74.6%      15.40 ± 68%  interrupts.CPU20.TLB:TLB_shootdowns
     18718 ± 26%     -77.9%       4146 ± 35%  interrupts.CPU21.RES:Rescheduling_interrupts
     19195 ± 24%     -72.9%       5208 ± 33%  interrupts.CPU22.RES:Rescheduling_interrupts
     18435 ± 24%     -59.7%       7435 ± 30%  interrupts.CPU23.RES:Rescheduling_interrupts
     12421 ± 21%     -61.9%       4733 ± 29%  interrupts.CPU25.RES:Rescheduling_interrupts
     14604 ± 24%     -54.6%       6631 ± 34%  interrupts.CPU28.RES:Rescheduling_interrupts
     16075 ± 26%     -61.1%       6249 ± 38%  interrupts.CPU29.RES:Rescheduling_interrupts
    903.60           +13.5%       1026 ±  9%  interrupts.CPU31.CAL:Function_call_interrupts
     17567 ± 29%     -62.3%       6617 ± 46%  interrupts.CPU32.RES:Rescheduling_interrupts
     15244 ± 21%     -68.5%       4809 ± 50%  interrupts.CPU33.RES:Rescheduling_interrupts
     16526 ± 16%     -63.8%       5988 ± 71%  interrupts.CPU35.RES:Rescheduling_interrupts
     19889 ±  6%     -75.0%       4966 ± 51%  interrupts.CPU36.RES:Rescheduling_interrupts
     19404 ± 22%     -66.2%       6563 ± 32%  interrupts.CPU37.RES:Rescheduling_interrupts
     19446 ± 11%     -62.8%       7240 ± 60%  interrupts.CPU38.RES:Rescheduling_interrupts
     19790 ± 25%     -63.1%       7297 ± 21%  interrupts.CPU39.RES:Rescheduling_interrupts
      8407 ±  4%     -22.2%       6541 ± 29%  interrupts.CPU4.NMI:Non-maskable_interrupts
      8407 ±  4%     -22.2%       6541 ± 29%  interrupts.CPU4.PMI:Performance_monitoring_interrupts
     21624 ± 20%     -60.7%       8506 ± 59%  interrupts.CPU40.RES:Rescheduling_interrupts
     19575 ± 15%     -72.3%       5430 ± 35%  interrupts.CPU41.RES:Rescheduling_interrupts
     22512 ± 21%     -76.1%       5370 ± 65%  interrupts.CPU42.RES:Rescheduling_interrupts
     20342 ± 11%     -78.7%       4337 ± 27%  interrupts.CPU43.RES:Rescheduling_interrupts
     71.00 ± 77%     -66.5%      23.80 ± 53%  interrupts.CPU43.TLB:TLB_shootdowns
     22717 ± 16%     -80.8%       4363 ± 42%  interrupts.CPU44.RES:Rescheduling_interrupts
     22427 ± 25%     -87.0%       2919 ± 29%  interrupts.CPU45.RES:Rescheduling_interrupts
     25129 ± 26%     -75.6%       6131 ± 35%  interrupts.CPU46.RES:Rescheduling_interrupts
     25311 ± 27%     -69.7%       7679 ± 46%  interrupts.CPU47.RES:Rescheduling_interrupts
     12818 ± 23%     -45.9%       6933 ± 36%  interrupts.CPU5.RES:Rescheduling_interrupts
     12087 ± 43%     -56.6%       5248 ± 43%  interrupts.CPU50.RES:Rescheduling_interrupts
     15964 ± 15%     -66.9%       5290 ± 59%  interrupts.CPU51.RES:Rescheduling_interrupts
     12712 ± 16%     -51.1%       6220 ± 56%  interrupts.CPU52.RES:Rescheduling_interrupts
     12931 ±  8%     -48.8%       6621 ± 52%  interrupts.CPU53.RES:Rescheduling_interrupts
     15241 ± 29%     -46.6%       8135 ± 61%  interrupts.CPU54.RES:Rescheduling_interrupts
     18851 ± 10%     -75.1%       4691 ± 68%  interrupts.CPU55.RES:Rescheduling_interrupts
     16114 ± 20%     -72.6%       4418 ± 49%  interrupts.CPU56.RES:Rescheduling_interrupts
     14867 ± 36%     -46.9%       7901 ± 54%  interrupts.CPU57.RES:Rescheduling_interrupts
     18445 ± 19%     -60.3%       7329 ± 57%  interrupts.CPU60.RES:Rescheduling_interrupts
     16799 ± 19%     -56.2%       7353 ± 56%  interrupts.CPU61.RES:Rescheduling_interrupts
     16466 ±  9%     -49.0%       8398 ± 41%  interrupts.CPU63.RES:Rescheduling_interrupts
     19173 ±  7%     -51.3%       9329 ± 22%  interrupts.CPU64.RES:Rescheduling_interrupts
     19019 ± 15%     -65.0%       6662 ± 70%  interrupts.CPU65.RES:Rescheduling_interrupts
     24865 ± 14%     -70.3%       7383 ± 31%  interrupts.CPU66.RES:Rescheduling_interrupts
     20350 ± 29%     -52.0%       9765 ± 17%  interrupts.CPU67.RES:Rescheduling_interrupts
     21037 ± 25%     -67.7%       6793 ± 55%  interrupts.CPU68.RES:Rescheduling_interrupts
     25286 ± 17%     -70.7%       7398 ± 46%  interrupts.CPU69.RES:Rescheduling_interrupts
     17345 ± 17%     -58.4%       7218 ± 40%  interrupts.CPU7.RES:Rescheduling_interrupts
     23913 ± 12%     -67.2%       7844 ± 39%  interrupts.CPU70.RES:Rescheduling_interrupts
     22159 ± 29%     -72.9%       5997 ± 42%  interrupts.CPU71.RES:Rescheduling_interrupts
     16007 ± 38%     -54.6%       7270 ± 33%  interrupts.CPU75.RES:Rescheduling_interrupts
     16100 ± 29%     -62.5%       6037 ± 61%  interrupts.CPU76.RES:Rescheduling_interrupts
     17691 ± 13%     -71.8%       4992 ± 66%  interrupts.CPU77.RES:Rescheduling_interrupts
     19181 ± 29%     -55.9%       8452 ± 34%  interrupts.CPU78.RES:Rescheduling_interrupts
     16480 ± 42%     -66.8%       5468 ± 41%  interrupts.CPU79.RES:Rescheduling_interrupts
     14797 ± 21%     -38.0%       9169 ± 15%  interrupts.CPU8.RES:Rescheduling_interrupts
     16987 ± 18%     -55.3%       7601 ± 76%  interrupts.CPU80.RES:Rescheduling_interrupts
     20522 ± 15%     -58.5%       8522 ± 32%  interrupts.CPU81.RES:Rescheduling_interrupts
     18750 ± 24%     -71.3%       5386 ± 91%  interrupts.CPU82.RES:Rescheduling_interrupts
     21485 ± 34%     -70.6%       6317 ±102%  interrupts.CPU83.RES:Rescheduling_interrupts
     15390 ± 19%     -57.3%       6576 ± 66%  interrupts.CPU84.RES:Rescheduling_interrupts
     16251 ± 35%     -60.0%       6503 ±  9%  interrupts.CPU85.RES:Rescheduling_interrupts
     22661 ± 20%     -61.2%       8781 ± 43%  interrupts.CPU86.RES:Rescheduling_interrupts
     21182 ± 37%     -72.1%       5915 ± 34%  interrupts.CPU87.RES:Rescheduling_interrupts
     20482 ± 27%     -66.2%       6913 ± 55%  interrupts.CPU88.RES:Rescheduling_interrupts
     22303 ± 18%     -74.8%       5616 ± 97%  interrupts.CPU89.RES:Rescheduling_interrupts
     22674 ± 39%     -72.3%       6285 ± 45%  interrupts.CPU90.RES:Rescheduling_interrupts
     22527 ± 38%     -66.7%       7509 ± 78%  interrupts.CPU91.RES:Rescheduling_interrupts
     24202 ± 41%     -77.5%       5449 ± 75%  interrupts.CPU93.RES:Rescheduling_interrupts
     24056 ± 26%     -62.5%       9013 ± 50%  interrupts.CPU94.RES:Rescheduling_interrupts
     25980 ± 26%     -59.7%      10460 ± 31%  interrupts.CPU96.RES:Rescheduling_interrupts
     33285 ± 20%     -78.3%       7213 ± 45%  interrupts.CPU97.RES:Rescheduling_interrupts
     88.00 ± 53%     -77.5%      19.80 ± 63%  interrupts.CPU97.TLB:TLB_shootdowns
     30452 ± 14%     -66.5%      10214 ± 57%  interrupts.CPU98.RES:Rescheduling_interrupts
     27805 ±  7%     -67.8%       8944 ± 60%  interrupts.CPU99.RES:Rescheduling_interrupts
   3779530 ±  8%     -64.4%    1345454 ± 26%  interrupts.RES:Rescheduling_interrupts
     23.08           -16.2        6.89 ± 45%  perf-profile.calltrace.cycles-pp.secondary_startup_64
     22.99           -16.1        6.85 ± 45%  perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.secondary_startup_64
     22.99           -16.1        6.85 ± 45%  perf-profile.calltrace.cycles-pp.start_secondary.secondary_startup_64
     22.98           -16.1        6.85 ± 45%  perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64
     22.44           -15.7        6.73 ± 45%  perf-profile.calltrace.cycles-pp.cpuidle_enter.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64
     22.43           -15.7        6.73 ± 45%  perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry.start_secondary
     21.98           -15.4        6.62 ± 45%  perf-profile.calltrace.cycles-pp.intel_idle.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry
     14.81 ±  3%      -8.9        5.95 ± 34%  perf-profile.calltrace.cycles-pp.release_sock.tcp_sendmsg.sock_sendmsg.__sys_sendto.__x64_sys_sendto
     14.74 ±  3%      -8.9        5.89 ± 35%  perf-profile.calltrace.cycles-pp.__release_sock.release_sock.tcp_sendmsg.sock_sendmsg.__sys_sendto
     14.11 ±  3%      -8.4        5.72 ± 34%  perf-profile.calltrace.cycles-pp.tcp_v4_do_rcv.__release_sock.release_sock.tcp_sendmsg.sock_sendmsg
     14.09 ±  3%      -8.4        5.71 ± 34%  perf-profile.calltrace.cycles-pp.tcp_rcv_established.tcp_v4_do_rcv.__release_sock.release_sock.tcp_sendmsg
     12.73 ±  3%      -8.2        4.55 ± 43%  perf-profile.calltrace.cycles-pp.tcp_ack.tcp_rcv_established.tcp_v4_do_rcv.__release_sock.release_sock
     12.68 ±  3%      -8.2        4.51 ± 43%  perf-profile.calltrace.cycles-pp.tcp_clean_rtx_queue.tcp_ack.tcp_rcv_established.tcp_v4_do_rcv.__release_sock
     12.37 ±  4%      -8.1        4.25 ± 46%  perf-profile.calltrace.cycles-pp.skb_release_data.__kfree_skb.tcp_clean_rtx_queue.tcp_ack.tcp_rcv_established
     12.42 ±  4%      -8.1        4.30 ± 46%  perf-profile.calltrace.cycles-pp.__kfree_skb.tcp_clean_rtx_queue.tcp_ack.tcp_rcv_established.tcp_v4_do_rcv
     11.93 ±  4%      -8.0        3.95 ± 49%  perf-profile.calltrace.cycles-pp.__free_pages_ok.skb_release_data.__kfree_skb.tcp_clean_rtx_queue.tcp_ack
     11.79 ±  4%      -7.9        3.90 ± 49%  perf-profile.calltrace.cycles-pp.free_one_page.__free_pages_ok.skb_release_data.__kfree_skb.tcp_clean_rtx_queue
     51.48            -1.5       50.03        perf-profile.calltrace.cycles-pp.__x64_sys_sendto.do_syscall_64.entry_SYSCALL_64_after_hwframe
     51.47            -1.5       50.02        perf-profile.calltrace.cycles-pp.__sys_sendto.__x64_sys_sendto.do_syscall_64.entry_SYSCALL_64_after_hwframe
     51.38            -1.4       49.95        perf-profile.calltrace.cycles-pp.sock_sendmsg.__sys_sendto.__x64_sys_sendto.do_syscall_64.entry_SYSCALL_64_after_hwframe
     51.33            -1.4       49.90        perf-profile.calltrace.cycles-pp.tcp_sendmsg.sock_sendmsg.__sys_sendto.__x64_sys_sendto.do_syscall_64
      1.75 ±  5%      -0.6        1.17 ±  6%  perf-profile.calltrace.cycles-pp.__tcp_push_pending_frames.tcp_rcv_established.tcp_v4_do_rcv.__release_sock.release_sock
      1.75 ±  5%      -0.6        1.17 ±  5%  perf-profile.calltrace.cycles-pp.tcp_write_xmit.__tcp_push_pending_frames.tcp_rcv_established.tcp_v4_do_rcv.__release_sock
      1.29 ±  8%      -0.6        0.71 ± 10%  perf-profile.calltrace.cycles-pp.__ip_queue_xmit.__tcp_transmit_skb.tcp_write_xmit.__tcp_push_pending_frames.tcp_rcv_established
      1.54 ±  6%      -0.6        0.97 ±  6%  perf-profile.calltrace.cycles-pp.__tcp_transmit_skb.tcp_write_xmit.__tcp_push_pending_frames.tcp_rcv_established.tcp_v4_do_rcv
      7.37 ±  3%      -0.6        6.81        perf-profile.calltrace.cycles-pp._copy_from_iter_full.tcp_sendmsg_locked.tcp_sendmsg.sock_sendmsg.__sys_sendto
      7.11 ±  2%      -0.5        6.57        perf-profile.calltrace.cycles-pp.copy_user_enhanced_fast_string.copyin._copy_from_iter_full.tcp_sendmsg_locked.tcp_sendmsg
      7.22 ±  3%      -0.5        6.68        perf-profile.calltrace.cycles-pp.copyin._copy_from_iter_full.tcp_sendmsg_locked.tcp_sendmsg.sock_sendmsg
      0.00            +0.5        0.52 ±  3%  perf-profile.calltrace.cycles-pp.release_sock.tcp_recvmsg.inet_recvmsg.__sys_recvfrom.__x64_sys_recvfrom
      8.04 ±  2%      +1.0        9.09 ±  2%  perf-profile.calltrace.cycles-pp.copy_user_enhanced_fast_string.copyout._copy_to_iter.__skb_datagram_iter.skb_copy_datagram_iter
      8.23 ±  2%      +1.1        9.35 ±  2%  perf-profile.calltrace.cycles-pp._copy_to_iter.__skb_datagram_iter.skb_copy_datagram_iter.tcp_recvmsg.inet_recvmsg
      8.63 ±  2%      +1.1        9.76 ±  2%  perf-profile.calltrace.cycles-pp.skb_copy_datagram_iter.tcp_recvmsg.inet_recvmsg.__sys_recvfrom.__x64_sys_recvfrom
      8.62 ±  2%      +1.1        9.75 ±  2%  perf-profile.calltrace.cycles-pp.__skb_datagram_iter.skb_copy_datagram_iter.tcp_recvmsg.inet_recvmsg.__sys_recvfrom
      8.19 ±  2%      +1.1        9.32 ±  2%  perf-profile.calltrace.cycles-pp.copyout._copy_to_iter.__skb_datagram_iter.skb_copy_datagram_iter.tcp_recvmsg
     36.28            +7.5       43.79 ±  4%  perf-profile.calltrace.cycles-pp.tcp_sendmsg_locked.tcp_sendmsg.sock_sendmsg.__sys_sendto.__x64_sys_sendto
     24.55            +8.2       32.71 ±  5%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.rmqueue.get_page_from_freelist.__alloc_pages_nodemask
     24.99            +8.2       33.18 ±  5%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.rmqueue.get_page_from_freelist.__alloc_pages_nodemask.skb_page_frag_refill
     26.00            +8.2       34.25 ±  5%  perf-profile.calltrace.cycles-pp.rmqueue.get_page_from_freelist.__alloc_pages_nodemask.skb_page_frag_refill.sk_page_frag_refill
     26.80            +8.3       35.14 ±  5%  perf-profile.calltrace.cycles-pp.__alloc_pages_nodemask.skb_page_frag_refill.sk_page_frag_refill.tcp_sendmsg_locked.tcp_sendmsg
     26.89            +8.3       35.23 ±  5%  perf-profile.calltrace.cycles-pp.sk_page_frag_refill.tcp_sendmsg_locked.tcp_sendmsg.sock_sendmsg.__sys_sendto
     26.73            +8.3       35.07 ±  5%  perf-profile.calltrace.cycles-pp.get_page_from_freelist.__alloc_pages_nodemask.skb_page_frag_refill.sk_page_frag_refill.tcp_sendmsg_locked
     26.91            +8.3       35.25 ±  5%  perf-profile.calltrace.cycles-pp.skb_page_frag_refill.sk_page_frag_refill.tcp_sendmsg_locked.tcp_sendmsg.sock_sendmsg
     24.02            +8.8       32.85 ±  5%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.free_one_page.__free_pages_ok.skb_release_data
     24.44            +8.9       33.32 ±  5%  perf-profile.calltrace.cycles-pp._raw_spin_lock.free_one_page.__free_pages_ok.skb_release_data.__kfree_skb
     76.53           +16.3       92.79 ±  3%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe
     76.51           +16.3       92.78 ±  3%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe
     13.05 ±  3%     +16.7       29.76 ± 11%  perf-profile.calltrace.cycles-pp.free_one_page.__free_pages_ok.skb_release_data.__kfree_skb.tcp_recvmsg
     13.42 ±  3%     +17.0       30.47 ± 11%  perf-profile.calltrace.cycles-pp.__free_pages_ok.skb_release_data.__kfree_skb.tcp_recvmsg.inet_recvmsg
     13.93 ±  3%     +17.3       31.25 ± 11%  perf-profile.calltrace.cycles-pp.skb_release_data.__kfree_skb.tcp_recvmsg.inet_recvmsg.__sys_recvfrom
     14.12 ±  3%     +17.4       31.48 ± 11%  perf-profile.calltrace.cycles-pp.__kfree_skb.tcp_recvmsg.inet_recvmsg.__sys_recvfrom.__x64_sys_recvfrom
     24.95 ±  2%     +17.7       42.70 ±  7%  perf-profile.calltrace.cycles-pp.__x64_sys_recvfrom.do_syscall_64.entry_SYSCALL_64_after_hwframe
     24.95 ±  2%     +17.7       42.70 ±  7%  perf-profile.calltrace.cycles-pp.__sys_recvfrom.__x64_sys_recvfrom.do_syscall_64.entry_SYSCALL_64_after_hwframe
     24.89 ±  2%     +17.8       42.68 ±  7%  perf-profile.calltrace.cycles-pp.inet_recvmsg.__sys_recvfrom.__x64_sys_recvfrom.do_syscall_64.entry_SYSCALL_64_after_hwframe
     24.89 ±  2%     +17.8       42.67 ±  7%  perf-profile.calltrace.cycles-pp.tcp_recvmsg.inet_recvmsg.__sys_recvfrom.__x64_sys_recvfrom.do_syscall_64
     23.08           -16.2        6.89 ± 45%  perf-profile.children.cycles-pp.secondary_startup_64
     23.08           -16.2        6.89 ± 45%  perf-profile.children.cycles-pp.cpu_startup_entry
     23.07           -16.2        6.89 ± 45%  perf-profile.children.cycles-pp.do_idle
     22.99           -16.1        6.85 ± 45%  perf-profile.children.cycles-pp.start_secondary
     22.53           -15.8        6.77 ± 44%  perf-profile.children.cycles-pp.cpuidle_enter
     22.53           -15.8        6.77 ± 44%  perf-profile.children.cycles-pp.cpuidle_enter_state
     22.07           -15.4        6.66 ± 44%  perf-profile.children.cycles-pp.intel_idle
     15.38 ±  3%      -8.9        6.48 ± 32%  perf-profile.children.cycles-pp.tcp_rcv_established
     15.42 ±  3%      -8.9        6.52 ± 32%  perf-profile.children.cycles-pp.tcp_v4_do_rcv
     15.17 ±  3%      -8.7        6.48 ± 31%  perf-profile.children.cycles-pp.release_sock
     15.06 ±  3%      -8.7        6.38 ± 32%  perf-profile.children.cycles-pp.__release_sock
     12.87 ±  3%      -8.3        4.62 ± 43%  perf-profile.children.cycles-pp.tcp_ack
     12.81 ±  3%      -8.2        4.57 ± 43%  perf-profile.children.cycles-pp.tcp_clean_rtx_queue
     51.48            -1.5       50.03        perf-profile.children.cycles-pp.__x64_sys_sendto
     51.47            -1.5       50.02        perf-profile.children.cycles-pp.__sys_sendto
     51.38            -1.4       49.95        perf-profile.children.cycles-pp.sock_sendmsg
     51.33            -1.4       49.90        perf-profile.children.cycles-pp.tcp_sendmsg
      2.82 ±  7%      -1.2        1.64 ± 12%  perf-profile.children.cycles-pp.__tcp_transmit_skb
      2.35 ±  8%      -1.1        1.27 ± 14%  perf-profile.children.cycles-pp.__ip_queue_xmit
      2.03 ± 10%      -1.1        0.97 ± 19%  perf-profile.children.cycles-pp.ip_output
      1.95 ± 10%      -1.0        0.93 ± 19%  perf-profile.children.cycles-pp.ip_finish_output2
      1.69 ± 10%      -0.9        0.79 ± 21%  perf-profile.children.cycles-pp.__local_bh_enable_ip
      1.66 ± 10%      -0.9        0.78 ± 21%  perf-profile.children.cycles-pp.do_softirq
      1.69 ± 10%      -0.9        0.81 ± 20%  perf-profile.children.cycles-pp.__softirqentry_text_start
      1.64 ± 10%      -0.9        0.77 ± 21%  perf-profile.children.cycles-pp.do_softirq_own_stack
      2.39 ±  5%      -0.9        1.53 ±  8%  perf-profile.children.cycles-pp.tcp_write_xmit
      1.57 ± 10%      -0.8        0.73 ± 21%  perf-profile.children.cycles-pp.net_rx_action
      1.54 ± 10%      -0.8        0.71 ± 22%  perf-profile.children.cycles-pp.process_backlog
      1.49 ± 10%      -0.8        0.70 ± 22%  perf-profile.children.cycles-pp.__netif_receive_skb_one_core
      1.45 ± 10%      -0.8        0.67 ± 22%  perf-profile.children.cycles-pp.ip_rcv
      1.41 ± 10%      -0.8        0.65 ± 23%  perf-profile.children.cycles-pp.ip_local_deliver
      1.40 ± 10%      -0.8        0.65 ± 23%  perf-profile.children.cycles-pp.ip_local_deliver_finish
      1.39 ± 10%      -0.8        0.64 ± 23%  perf-profile.children.cycles-pp.ip_protocol_deliver_rcu
      1.37 ± 10%      -0.7        0.63 ± 23%  perf-profile.children.cycles-pp.tcp_v4_rcv
      2.03 ±  4%      -0.6        1.42 ±  5%  perf-profile.children.cycles-pp.__tcp_push_pending_frames
      7.38 ±  3%      -0.6        6.82        perf-profile.children.cycles-pp._copy_from_iter_full
      7.25 ±  3%      -0.5        6.72        perf-profile.children.cycles-pp.copyin
      0.69 ± 12%      -0.5        0.19 ± 43%  perf-profile.children.cycles-pp.sock_def_readable
      0.67 ± 12%      -0.5        0.18 ± 44%  perf-profile.children.cycles-pp.__wake_up_common_lock
      0.66 ± 17%      -0.5        0.18 ± 31%  perf-profile.children.cycles-pp.__schedule
      0.64 ± 12%      -0.5        0.18 ± 44%  perf-profile.children.cycles-pp.__wake_up_common
      0.63 ± 11%      -0.5        0.17 ± 43%  perf-profile.children.cycles-pp.try_to_wake_up
      0.51 ± 17%      -0.4        0.10 ± 47%  perf-profile.children.cycles-pp.sk_wait_data
      0.46 ± 16%      -0.3        0.13 ± 29%  perf-profile.children.cycles-pp.wait_woken
      0.43 ± 16%      -0.3        0.13 ± 26%  perf-profile.children.cycles-pp.schedule_timeout
      0.43 ± 17%      -0.3        0.13 ± 25%  perf-profile.children.cycles-pp.schedule
      0.34 ± 12%      -0.3        0.08 ± 67%  perf-profile.children.cycles-pp.ttwu_do_activate
      0.34 ± 13%      -0.3        0.08 ± 67%  perf-profile.children.cycles-pp.activate_task
      0.34 ± 13%      -0.3        0.08 ± 65%  perf-profile.children.cycles-pp.enqueue_task_fair
      0.27 ± 14%      -0.2        0.05 ± 90%  perf-profile.children.cycles-pp.enqueue_entity
      0.20 ±  9%      -0.1        0.07 ± 34%  perf-profile.children.cycles-pp.lock_sock_nested
      0.24 ±  6%      -0.1        0.14 ± 19%  perf-profile.children.cycles-pp._raw_spin_lock_bh
      0.23 ±  8%      -0.1        0.13 ± 11%  perf-profile.children.cycles-pp.__dev_queue_xmit
      0.18 ± 15%      -0.1        0.09 ± 18%  perf-profile.children.cycles-pp.pick_next_task_fair
      0.23 ± 12%      -0.1        0.14 ± 12%  perf-profile.children.cycles-pp.update_load_avg
      0.17 ± 27%      -0.1        0.08 ± 20%  perf-profile.children.cycles-pp.update_cfs_group
      0.33 ±  2%      -0.1        0.24 ±  6%  perf-profile.children.cycles-pp.__list_del_entry_valid
      0.12 ±  6%      -0.1        0.04 ± 83%  perf-profile.children.cycles-pp.__switch_to
      0.15 ±  5%      -0.1        0.08 ± 12%  perf-profile.children.cycles-pp.dev_hard_start_xmit
      0.11 ± 12%      -0.1        0.05 ± 52%  perf-profile.children.cycles-pp.update_rq_clock
      0.13 ±  8%      -0.1        0.07 ± 10%  perf-profile.children.cycles-pp.loopback_xmit
      0.08 ± 10%      -0.0        0.03 ± 82%  perf-profile.children.cycles-pp.__update_load_avg_cfs_rq
      0.11 ± 16%      -0.0        0.06 ±  7%  perf-profile.children.cycles-pp.update_curr
      0.07            -0.0        0.03 ± 81%  perf-profile.children.cycles-pp.__ksize
      0.35            -0.0        0.31 ±  4%  perf-profile.children.cycles-pp.__free_one_page
      0.12 ± 10%      -0.0        0.09 ± 11%  perf-profile.children.cycles-pp.__inet_lookup_established
      0.10 ±  4%      -0.0        0.07 ± 12%  perf-profile.children.cycles-pp.skb_release_all
      0.10 ±  7%      -0.0        0.07 ±  7%  perf-profile.children.cycles-pp.__list_add_valid
      0.09 ±  8%      -0.0        0.06 ± 14%  perf-profile.children.cycles-pp.__tcp_send_ack
      0.10 ±  6%      -0.0        0.07 ± 12%  perf-profile.children.cycles-pp.skb_release_head_state
      0.06 ±  6%      -0.0        0.04 ± 50%  perf-profile.children.cycles-pp.tcp_event_new_data_sent
      0.06 ±  6%      -0.0        0.04 ± 50%  perf-profile.children.cycles-pp.sockfd_lookup_light
      0.07 ±  5%      -0.0        0.05 ±  7%  perf-profile.children.cycles-pp.tcp_current_mss
      0.09 ±  5%      -0.0        0.08 ±  6%  perf-profile.children.cycles-pp.__skb_clone
      0.07 ± 11%      -0.0        0.05 ±  7%  perf-profile.children.cycles-pp.tcp_send_mss
      0.08 ±  4%      -0.0        0.07 ±  7%  perf-profile.children.cycles-pp.sk_reset_timer
      0.08            -0.0        0.07 ±  7%  perf-profile.children.cycles-pp.mod_timer
      0.09            +0.0        0.11 ±  4%  perf-profile.children.cycles-pp.kmem_cache_free
      0.19            +0.0        0.21 ±  3%  perf-profile.children.cycles-pp.__slab_free
      0.09 ±  5%      +0.0        0.11 ±  4%  perf-profile.children.cycles-pp.__mod_zone_page_state
      0.11 ±  6%      +0.0        0.13 ±  4%  perf-profile.children.cycles-pp.prep_new_page
      0.27            +0.0        0.30 ±  3%  perf-profile.children.cycles-pp.simple_copy_to_iter
      0.08 ± 20%      +0.0        0.11 ± 10%  perf-profile.children.cycles-pp.ksys_write
      0.08 ± 22%      +0.0        0.11 ±  8%  perf-profile.children.cycles-pp.vfs_write
      0.08 ± 22%      +0.0        0.11 ±  8%  perf-profile.children.cycles-pp.__libc_write
      0.08 ± 19%      +0.0        0.11 ±  6%  perf-profile.children.cycles-pp.generic_file_write_iter
      0.08 ± 19%      +0.0        0.11 ±  6%  perf-profile.children.cycles-pp.__generic_file_write_iter
      0.08 ± 19%      +0.0        0.11 ±  6%  perf-profile.children.cycles-pp.generic_perform_write
      0.08 ± 19%      +0.0        0.11 ±  8%  perf-profile.children.cycles-pp.new_sync_write
      0.12 ±  4%      +0.0        0.15 ±  5%  perf-profile.children.cycles-pp.skb_clone
      0.11 ±  4%      +0.0        0.15 ±  8%  perf-profile.children.cycles-pp.__kmalloc_reserve
      0.11 ±  3%      +0.0        0.15 ±  7%  perf-profile.children.cycles-pp.__kmalloc_node_track_caller
      0.36 ±  3%      +0.0        0.41 ±  5%  perf-profile.children.cycles-pp.sk_stream_alloc_skb
      0.06 ±  6%      +0.1        0.12 ± 13%  perf-profile.children.cycles-pp.alloc_slab_page
      0.06 ±  7%      +0.1        0.13 ± 11%  perf-profile.children.cycles-pp.new_slab
      0.06 ±  7%      +0.1        0.13 ± 11%  perf-profile.children.cycles-pp.allocate_slab
      0.16 ±  2%      +0.1        0.23 ±  3%  perf-profile.children.cycles-pp.skb_try_coalesce
      0.09 ±  4%      +0.1        0.16 ±  9%  perf-profile.children.cycles-pp.___slab_alloc
      0.06            +0.1        0.13 ± 10%  perf-profile.children.cycles-pp.put_cpu_partial
      0.17 ±  2%      +0.1        0.24 ±  2%  perf-profile.children.cycles-pp.tcp_try_coalesce
      0.06 ±  8%      +0.1        0.13 ±  9%  perf-profile.children.cycles-pp.unfreeze_partials
      0.22 ±  2%      +0.1        0.29 ±  2%  perf-profile.children.cycles-pp.tcp_queue_rcv
      0.04 ± 51%      +0.1        0.13 ± 14%  perf-profile.children.cycles-pp.native_irq_return_iret
      0.20 ± 20%      +0.1        0.34 ±  9%  perf-profile.children.cycles-pp.task_tick_fair
      0.75 ±  9%      +0.2        0.90 ±  6%  perf-profile.children.cycles-pp.smp_apic_timer_interrupt
      0.26 ± 19%      +0.2        0.42 ±  7%  perf-profile.children.cycles-pp.scheduler_tick
      0.33 ± 12%      +0.2        0.49 ±  7%  perf-profile.children.cycles-pp.update_process_times
      0.36 ± 12%      +0.2        0.53 ±  6%  perf-profile.children.cycles-pp.tick_sched_timer
      0.33 ± 12%      +0.2        0.50 ±  7%  perf-profile.children.cycles-pp.tick_sched_handle
      0.45 ±  8%      +0.2        0.64 ±  7%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      0.62 ± 10%      +0.2        0.81 ±  6%  perf-profile.children.cycles-pp.hrtimer_interrupt
      1.04 ± 12%      +0.4        1.43 ±  4%  perf-profile.children.cycles-pp.apic_timer_interrupt
     15.41 ±  2%      +0.6       16.01        perf-profile.children.cycles-pp.copy_user_enhanced_fast_string
      8.23 ±  2%      +1.1        9.35 ±  2%  perf-profile.children.cycles-pp._copy_to_iter
      8.63 ±  2%      +1.1        9.76 ±  2%  perf-profile.children.cycles-pp.skb_copy_datagram_iter
      8.19 ±  2%      +1.1        9.32 ±  2%  perf-profile.children.cycles-pp.copyout
      8.62 ±  2%      +1.1        9.75 ±  2%  perf-profile.children.cycles-pp.__skb_datagram_iter
     36.35            +7.5       43.87 ±  4%  perf-profile.children.cycles-pp.tcp_sendmsg_locked
     25.15            +8.2       33.34 ±  5%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
     26.91            +8.3       35.25 ±  5%  perf-profile.children.cycles-pp.skb_page_frag_refill
     26.93            +8.3       35.27 ±  5%  perf-profile.children.cycles-pp.sk_page_frag_refill
     26.13            +8.4       34.51 ±  5%  perf-profile.children.cycles-pp.rmqueue
     26.82            +8.4       35.26 ±  5%  perf-profile.children.cycles-pp.get_page_from_freelist
     26.89            +8.4       35.33 ±  5%  perf-profile.children.cycles-pp.__alloc_pages_nodemask
     24.99            +8.8       33.83 ±  4%  perf-profile.children.cycles-pp.free_one_page
     24.77            +8.8       33.61 ±  4%  perf-profile.children.cycles-pp._raw_spin_lock
     26.43            +9.1       35.56 ±  4%  perf-profile.children.cycles-pp.skb_release_data
     25.55            +9.1       34.69 ±  4%  perf-profile.children.cycles-pp.__free_pages_ok
     26.76            +9.2       35.91 ±  4%  perf-profile.children.cycles-pp.__kfree_skb
     76.67           +16.3       92.96 ±  3%  perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     76.65           +16.3       92.95 ±  3%  perf-profile.children.cycles-pp.do_syscall_64
     48.94           +17.0       65.94 ±  5%  perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
     24.96 ±  2%     +17.7       42.70 ±  7%  perf-profile.children.cycles-pp.__x64_sys_recvfrom
     24.95 ±  2%     +17.7       42.70 ±  7%  perf-profile.children.cycles-pp.__sys_recvfrom
     24.89 ±  2%     +17.8       42.68 ±  7%  perf-profile.children.cycles-pp.inet_recvmsg
     24.89 ±  2%     +17.8       42.67 ±  7%  perf-profile.children.cycles-pp.tcp_recvmsg
     22.07           -15.4        6.66 ± 44%  perf-profile.self.cycles-pp.intel_idle
      0.17 ± 27%      -0.1        0.08 ± 20%  perf-profile.self.cycles-pp.update_cfs_group
      0.33 ±  2%      -0.1        0.24 ±  6%  perf-profile.self.cycles-pp.__list_del_entry_valid
      0.21 ±  3%      -0.1        0.13 ± 12%  perf-profile.self.cycles-pp.__tcp_transmit_skb
      0.11 ±  8%      -0.1        0.04 ± 83%  perf-profile.self.cycles-pp.__switch_to
      0.13 ±  5%      -0.1        0.08 ± 14%  perf-profile.self.cycles-pp.tcp_recvmsg
      0.08 ± 10%      -0.0        0.03 ± 82%  perf-profile.self.cycles-pp.__update_load_avg_cfs_rq
      0.07 ±  5%      -0.0        0.03 ± 81%  perf-profile.self.cycles-pp.__ksize
      0.13 ±  3%      -0.0        0.10 ±  7%  perf-profile.self.cycles-pp.tcp_clean_rtx_queue
      0.21 ±  2%      -0.0        0.18 ±  6%  perf-profile.self.cycles-pp.__free_one_page
      0.11 ± 13%      -0.0        0.08 ±  9%  perf-profile.self.cycles-pp.__inet_lookup_established
      0.10 ±  8%      -0.0        0.07 ±  7%  perf-profile.self.cycles-pp.__list_add_valid
      0.08 ±  9%      -0.0        0.06 ± 14%  perf-profile.self.cycles-pp.tcp_v4_rcv
      0.11 ±  9%      -0.0        0.09 ±  8%  perf-profile.self.cycles-pp._raw_spin_lock_bh
      0.08 ±  4%      -0.0        0.06 ±  7%  perf-profile.self.cycles-pp.__skb_clone
      0.16 ±  3%      -0.0        0.14 ±  6%  perf-profile.self.cycles-pp.__ip_queue_xmit
      0.12 ±  3%      -0.0        0.10 ±  4%  perf-profile.self.cycles-pp.__alloc_skb
      0.19            +0.0        0.21 ±  3%  perf-profile.self.cycles-pp.__slab_free
      0.11 ±  6%      +0.0        0.13 ±  5%  perf-profile.self.cycles-pp.prep_new_page
      0.09 ±  5%      +0.0        0.11 ±  4%  perf-profile.self.cycles-pp.__mod_zone_page_state
      0.27            +0.0        0.30 ±  3%  perf-profile.self.cycles-pp.__check_object_size
      0.11 ±  4%      +0.0        0.15 ±  5%  perf-profile.self.cycles-pp.skb_clone
      0.90            +0.0        0.94 ±  3%  perf-profile.self.cycles-pp.skb_release_data
      0.00            +0.1        0.07 ± 17%  perf-profile.self.cycles-pp.task_tick_fair
      0.16 ±  2%      +0.1        0.23 ±  2%  perf-profile.self.cycles-pp.skb_try_coalesce
      0.04 ± 51%      +0.1        0.13 ± 14%  perf-profile.self.cycles-pp.native_irq_return_iret
      0.33 ±  5%      +0.1        0.46 ±  5%  perf-profile.self.cycles-pp.__free_pages_ok
     15.30 ±  2%      +0.6       15.89        perf-profile.self.cycles-pp.copy_user_enhanced_fast_string
     48.94           +17.0       65.94 ±  5%  perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
   2411060 ± 11%     -17.0%    2001744 ±  6%  softirqs.CPU0.NET_RX
   2718610 ± 11%     -37.5%    1698432 ±  8%  softirqs.CPU10.NET_RX
   2668197 ±  9%     -36.9%    1683516 ± 17%  softirqs.CPU100.NET_RX
     55543 ±  7%     -50.3%      27591 ± 36%  softirqs.CPU100.SCHED
   2531285 ±  9%     -38.1%    1565973 ± 12%  softirqs.CPU101.NET_RX
     58736 ± 13%     -55.5%      26130 ± 13%  softirqs.CPU101.SCHED
   2418334 ± 13%     -27.0%    1765607 ± 15%  softirqs.CPU102.NET_RX
     53198 ± 15%     -50.3%      26416 ± 20%  softirqs.CPU102.SCHED
   2606464 ±  9%     -32.2%    1766378 ± 10%  softirqs.CPU103.NET_RX
     12406 ±  4%      -7.9%      11428 ±  2%  softirqs.CPU103.RCU
     51062 ±  9%     -41.0%      30107 ± 35%  softirqs.CPU103.SCHED
   2493152 ±  9%     -41.8%    1450692 ± 20%  softirqs.CPU104.NET_RX
     53419 ± 11%     -48.2%      27660 ± 47%  softirqs.CPU104.SCHED
   2480381 ±  9%     -48.6%    1273839 ± 40%  softirqs.CPU105.NET_RX
     12399 ±  4%     -10.0%      11163 ±  3%  softirqs.CPU105.RCU
     53177 ± 12%     -64.1%      19113 ± 53%  softirqs.CPU105.SCHED
   2568408 ± 10%     -34.3%    1687652 ± 20%  softirqs.CPU106.NET_RX
   2449975 ± 10%     -39.4%    1483795 ± 15%  softirqs.CPU107.NET_RX
     48717 ± 12%     -61.8%      18588 ± 16%  softirqs.CPU107.SCHED
   2465363 ± 11%     -49.6%    1241743 ± 40%  softirqs.CPU108.NET_RX
     12381 ±  5%      -9.2%      11237 ±  3%  softirqs.CPU108.RCU
     46096 ± 11%     -58.0%      19358 ± 52%  softirqs.CPU108.SCHED
   2273723 ±  7%     -47.0%    1205867 ± 28%  softirqs.CPU109.NET_RX
     12299 ±  4%      -9.0%      11198 ±  2%  softirqs.CPU109.RCU
     48456 ± 18%     -67.7%      15656 ± 39%  softirqs.CPU109.SCHED
   2665035 ±  8%     -39.7%    1607028 ± 11%  softirqs.CPU11.NET_RX
   2402488 ±  8%     -46.9%    1274744 ± 22%  softirqs.CPU110.NET_RX
     48708 ± 10%     -55.3%      21768 ± 23%  softirqs.CPU110.SCHED
   2294041 ±  9%     -40.9%    1355094 ± 23%  softirqs.CPU111.NET_RX
     49685 ± 11%     -57.8%      20983 ± 43%  softirqs.CPU111.SCHED
   2359170 ±  9%     -35.3%    1526656 ± 17%  softirqs.CPU112.NET_RX
     12723 ±  3%      -9.4%      11526 ±  3%  softirqs.CPU112.RCU
     46602 ± 12%     -58.6%      19273 ± 42%  softirqs.CPU112.SCHED
   2340351 ±  8%     -35.8%    1501914 ± 20%  softirqs.CPU113.NET_RX
     50881 ± 11%     -52.5%      24187 ± 49%  softirqs.CPU113.SCHED
   2256188 ± 10%     -32.8%    1515043 ± 24%  softirqs.CPU114.NET_RX
     12786 ±  3%     -10.6%      11428 ±  2%  softirqs.CPU114.RCU
     47771 ±  7%     -47.1%      25263 ± 50%  softirqs.CPU114.SCHED
   2270439 ±  7%     -43.9%    1274147 ± 25%  softirqs.CPU115.NET_RX
     47755 ±  8%     -60.1%      19048 ± 50%  softirqs.CPU115.SCHED
   2301318 ± 10%     -29.8%    1614857 ± 18%  softirqs.CPU116.NET_RX
     44792 ± 17%     -50.2%      22306 ± 20%  softirqs.CPU116.SCHED
   2148563 ± 11%     -52.7%    1016630 ± 27%  softirqs.CPU117.NET_RX
     12487 ±  2%      -9.3%      11322 ±  2%  softirqs.CPU117.RCU
     46927 ± 10%     -65.7%      16097 ± 30%  softirqs.CPU117.SCHED
   2051462 ±  7%     -36.9%    1293612 ± 36%  softirqs.CPU118.NET_RX
     42919 ± 10%     -64.4%      15274 ± 29%  softirqs.CPU118.SCHED
   2051750 ±  8%     -32.4%    1386457 ± 22%  softirqs.CPU119.NET_RX
     39861 ±  6%     -50.3%      19821 ± 23%  softirqs.CPU119.SCHED
   2863159 ± 10%     -48.2%    1484251 ± 13%  softirqs.CPU12.NET_RX
     35633 ± 14%     -40.8%      21081 ± 31%  softirqs.CPU12.SCHED
   3570263 ± 17%     -54.2%    1635090 ±  6%  softirqs.CPU120.NET_RX
     64626 ±  8%     -58.7%      26662 ± 26%  softirqs.CPU120.SCHED
   3702963 ± 17%     -59.9%    1484709 ± 17%  softirqs.CPU121.NET_RX
     64426 ±  9%     -61.3%      24913 ± 37%  softirqs.CPU121.SCHED
   3530917 ± 17%     -54.1%    1622018 ± 11%  softirqs.CPU122.NET_RX
     59735 ± 10%     -58.8%      24608 ± 26%  softirqs.CPU122.SCHED
   3562489 ± 20%     -60.7%    1398515 ± 22%  softirqs.CPU123.NET_RX
     62125 ±  7%     -61.1%      24139 ± 35%  softirqs.CPU123.SCHED
   3394123 ± 16%     -50.6%    1678076 ± 16%  softirqs.CPU124.NET_RX
     59949 ±  9%     -48.9%      30638 ± 18%  softirqs.CPU124.SCHED
   3315251 ± 18%     -52.8%    1563380 ± 20%  softirqs.CPU125.NET_RX
     57125 ±  8%     -45.2%      31315 ± 42%  softirqs.CPU125.SCHED
   3336327 ± 17%     -58.0%    1402064 ± 20%  softirqs.CPU126.NET_RX
     60326 ± 12%     -59.2%      24601 ± 21%  softirqs.CPU126.SCHED
   3355759 ± 20%     -56.1%    1471860 ± 24%  softirqs.CPU127.NET_RX
     60251 ±  8%     -53.4%      28094 ± 34%  softirqs.CPU127.SCHED
   3067020 ± 12%     -58.0%    1288984 ± 24%  softirqs.CPU128.NET_RX
     56485 ± 16%     -59.8%      22700 ± 26%  softirqs.CPU128.SCHED
   3137842 ± 15%     -57.0%    1349344 ± 33%  softirqs.CPU129.NET_RX
     59946 ± 10%     -60.5%      23697 ± 48%  softirqs.CPU129.SCHED
   2857070 ±  8%     -45.3%    1562616 ± 20%  softirqs.CPU13.NET_RX
   3019596 ± 23%     -58.6%    1249743 ± 19%  softirqs.CPU130.NET_RX
     55289 ± 14%     -50.3%      27497 ± 40%  softirqs.CPU130.SCHED
   3156549 ± 22%     -59.9%    1265006 ± 21%  softirqs.CPU131.NET_RX
     55181 ± 12%     -56.0%      24264 ± 30%  softirqs.CPU131.SCHED
   3040632 ± 24%     -58.8%    1252943 ± 29%  softirqs.CPU132.NET_RX
     53604 ±  9%     -64.8%      18845 ± 37%  softirqs.CPU132.SCHED
   2941914 ± 19%     -48.4%    1519254 ± 15%  softirqs.CPU133.NET_RX
     51831 ± 12%     -52.8%      24441 ± 11%  softirqs.CPU133.SCHED
   3004762 ± 16%     -50.0%    1501441 ± 28%  softirqs.CPU134.NET_RX
     53490 ±  8%     -58.3%      22283 ± 32%  softirqs.CPU134.SCHED
   3036502 ± 16%     -61.9%    1155804 ± 23%  softirqs.CPU135.NET_RX
     53052 ±  7%     -55.5%      23632 ± 38%  softirqs.CPU135.SCHED
   3058234 ± 15%     -48.1%    1587797 ± 22%  softirqs.CPU136.NET_RX
     52750 ± 13%     -55.9%      23276 ± 26%  softirqs.CPU136.SCHED
   2834945 ± 21%     -57.8%    1195389 ± 30%  softirqs.CPU137.NET_RX
     53108 ±  5%     -67.9%      17056 ± 50%  softirqs.CPU137.SCHED
   2664120 ± 22%     -46.5%    1424697 ± 38%  softirqs.CPU138.NET_RX
     46323 ± 19%     -54.5%      21075 ± 39%  softirqs.CPU138.SCHED
   2610691 ± 23%     -49.8%    1310524 ± 17%  softirqs.CPU139.NET_RX
     47434 ± 10%     -54.0%      21820 ± 20%  softirqs.CPU139.SCHED
   2806472 ± 11%     -49.1%    1428968 ± 15%  softirqs.CPU14.NET_RX
     32233 ± 11%     -38.8%      19727 ± 11%  softirqs.CPU14.SCHED
   2505133 ± 12%     -44.3%    1396093 ± 15%  softirqs.CPU140.NET_RX
     45572 ±  9%     -51.9%      21928 ± 19%  softirqs.CPU140.SCHED
   2393157 ± 12%     -52.9%    1127286 ± 28%  softirqs.CPU141.NET_RX
     44422 ±  7%     -58.4%      18491 ± 28%  softirqs.CPU141.SCHED
   2020765 ± 13%     -41.5%    1182979 ± 30%  softirqs.CPU142.NET_RX
     36011 ± 18%     -49.0%      18360 ± 36%  softirqs.CPU142.SCHED
   2104843 ±  7%     -35.5%    1357127 ± 24%  softirqs.CPU143.NET_RX
   3276208 ± 14%     -62.9%    1215092 ± 24%  softirqs.CPU144.NET_RX
     62909 ± 12%     -67.4%      20530 ± 50%  softirqs.CPU144.SCHED
   3287089 ± 11%     -49.0%    1677726 ±  7%  softirqs.CPU145.NET_RX
     61959 ±  5%     -53.3%      28959 ± 29%  softirqs.CPU145.SCHED
   3078579 ± 10%     -54.6%    1397375 ± 17%  softirqs.CPU146.NET_RX
     59372 ±  7%     -60.6%      23390 ± 27%  softirqs.CPU146.SCHED
   3099385 ± 16%     -56.2%    1356855 ± 32%  softirqs.CPU147.NET_RX
     55073 ±  8%     -62.1%      20887 ± 42%  softirqs.CPU147.SCHED
   3058536 ± 14%     -57.4%    1303914 ± 19%  softirqs.CPU148.NET_RX
     57666 ± 11%     -59.4%      23388 ± 36%  softirqs.CPU148.SCHED
   2797210 ± 15%     -44.9%    1541878 ± 14%  softirqs.CPU149.NET_RX
     54769 ±  5%     -48.0%      28475 ± 36%  softirqs.CPU149.SCHED
   2753938 ± 13%     -46.4%    1476205 ± 26%  softirqs.CPU15.NET_RX
   2773837 ±  8%     -49.8%    1392482 ± 25%  softirqs.CPU150.NET_RX
     56481 ± 11%     -57.9%      23792 ± 43%  softirqs.CPU150.SCHED
   2913248 ± 12%     -57.9%    1227126 ± 20%  softirqs.CPU151.NET_RX
     54119 ±  6%     -67.3%      17686 ± 18%  softirqs.CPU151.SCHED
   2962237 ± 14%     -55.4%    1322170 ± 23%  softirqs.CPU152.NET_RX
     57848 ± 12%     -55.2%      25899 ± 46%  softirqs.CPU152.SCHED
   2824322 ±  8%     -49.7%    1421240 ± 16%  softirqs.CPU153.NET_RX
     57214 ±  5%     -55.0%      25730 ± 23%  softirqs.CPU153.SCHED
   3017257 ± 14%     -59.8%    1212020 ± 31%  softirqs.CPU154.NET_RX
     54493 ± 10%     -65.8%      18622 ± 37%  softirqs.CPU154.SCHED
   2808497 ± 10%     -53.7%    1299347 ± 32%  softirqs.CPU155.NET_RX
     55357 ±  9%     -58.1%      23189 ± 31%  softirqs.CPU155.SCHED
   2864825 ± 15%     -47.3%    1510474 ± 23%  softirqs.CPU156.NET_RX
     52853 ± 13%     -52.1%      25309 ± 48%  softirqs.CPU156.SCHED
   2822646 ± 14%     -54.4%    1287032 ± 26%  softirqs.CPU157.NET_RX
     55730 ± 10%     -60.7%      21925 ± 62%  softirqs.CPU157.SCHED
   2509321 ±  9%     -41.5%    1467265 ± 33%  softirqs.CPU158.NET_RX
     55135 ± 11%     -64.5%      19590 ± 29%  softirqs.CPU158.SCHED
   2638967 ± 14%     -40.1%    1580103 ± 16%  softirqs.CPU159.NET_RX
     56293 ±  8%     -49.9%      28192 ± 31%  softirqs.CPU159.SCHED
   2695457 ± 15%     -48.0%    1401454 ± 13%  softirqs.CPU16.NET_RX
     31877 ± 14%     -31.0%      21980 ± 23%  softirqs.CPU16.SCHED
   2330445 ±  8%     -42.0%    1352543 ± 13%  softirqs.CPU160.NET_RX
     50654 ±  8%     -53.1%      23760 ± 15%  softirqs.CPU160.SCHED
   2659502 ± 12%     -48.1%    1380199 ± 22%  softirqs.CPU161.NET_RX
     47876 ±  6%     -58.2%      20010 ± 39%  softirqs.CPU161.SCHED
   2477864 ± 11%     -37.5%    1549170 ± 15%  softirqs.CPU162.NET_RX
     45515 ± 17%     -45.6%      24752 ± 36%  softirqs.CPU162.SCHED
   2382583 ±  6%     -30.8%    1649222 ± 18%  softirqs.CPU163.NET_RX
     50905 ± 11%     -50.0%      25461 ± 39%  softirqs.CPU163.SCHED
     45620 ± 11%     -50.7%      22490 ± 25%  softirqs.CPU164.SCHED
   2003025 ± 16%     -38.9%    1224234 ± 21%  softirqs.CPU165.NET_RX
     38487 ± 12%     -45.7%      20897 ± 33%  softirqs.CPU165.SCHED
   2029079 ± 20%     -36.7%    1283536 ± 11%  softirqs.CPU167.NET_RX
     37271 ± 11%     -36.3%      23745 ± 18%  softirqs.CPU167.SCHED
   3788471 ± 46%     -58.0%    1592793 ± 13%  softirqs.CPU168.NET_RX
     64500 ±  9%     -58.1%      27032 ± 14%  softirqs.CPU168.SCHED
   4160271 ± 58%     -59.3%    1693815 ± 21%  softirqs.CPU169.NET_RX
     65543 ± 12%     -54.3%      29953 ± 44%  softirqs.CPU169.SCHED
   2704755 ±  9%     -39.3%    1640754 ± 16%  softirqs.CPU17.NET_RX
   4010274 ± 54%     -61.1%    1561586 ± 35%  softirqs.CPU170.NET_RX
     65461 ± 15%     -64.6%      23155 ± 40%  softirqs.CPU170.SCHED
   4005888 ± 56%     -53.5%    1863617 ± 17%  softirqs.CPU171.NET_RX
     61007 ±  8%     -52.1%      29231 ± 18%  softirqs.CPU171.SCHED
   3794731 ± 58%     -56.2%    1663773 ± 29%  softirqs.CPU172.NET_RX
     60746 ± 20%     -53.5%      28242 ± 51%  softirqs.CPU172.SCHED
   3830799 ± 53%     -63.3%    1404468 ± 39%  softirqs.CPU173.NET_RX
     54674 ± 20%     -65.0%      19126 ± 49%  softirqs.CPU173.SCHED
   3538477 ± 42%     -52.8%    1668621 ± 15%  softirqs.CPU174.NET_RX
     55423 ±  9%     -55.9%      24447 ± 50%  softirqs.CPU174.SCHED
     57534 ±  7%     -60.0%      22985 ± 45%  softirqs.CPU175.SCHED
   3887126 ± 65%     -55.5%    1727897 ± 27%  softirqs.CPU176.NET_RX
     57205 ± 18%     -44.7%      31630 ± 36%  softirqs.CPU176.SCHED
   3714857 ± 57%     -49.2%    1887234 ± 22%  softirqs.CPU177.NET_RX
     53869 ± 20%     -52.6%      25530 ± 32%  softirqs.CPU177.SCHED
   3795497 ± 55%     -63.1%    1401327 ± 35%  softirqs.CPU178.NET_RX
     11681 ±  2%      -8.1%      10736 ±  4%  softirqs.CPU178.RCU
     55747 ± 19%     -60.3%      22144 ± 45%  softirqs.CPU178.SCHED
   3395540 ± 44%     -54.3%    1552463 ± 33%  softirqs.CPU179.NET_RX
     52609 ± 15%     -48.1%      27319 ± 42%  softirqs.CPU179.SCHED
   2752010 ± 11%     -40.6%    1634235 ± 22%  softirqs.CPU18.NET_RX
     33098 ± 14%     -32.8%      22230 ± 32%  softirqs.CPU18.SCHED
   3390488 ± 47%     -60.0%    1356411 ± 38%  softirqs.CPU180.NET_RX
     61426 ± 14%     -58.8%      25303 ± 52%  softirqs.CPU180.SCHED
     58005 ± 13%     -52.8%      27403 ± 42%  softirqs.CPU181.SCHED
   3456590 ± 52%     -49.9%    1732729 ± 17%  softirqs.CPU182.NET_RX
   3186026 ± 47%     -58.2%    1332986 ± 20%  softirqs.CPU183.NET_RX
     53111 ± 13%     -52.3%      25319 ± 37%  softirqs.CPU183.SCHED
     49775 ±  5%     -63.8%      18007 ± 40%  softirqs.CPU184.SCHED
   3305651 ± 51%     -63.5%    1205891 ± 49%  softirqs.CPU185.NET_RX
     11475            -8.2%      10528        softirqs.CPU185.RCU
     48770 ± 14%     -66.5%      16357 ± 57%  softirqs.CPU185.SCHED
   3150235 ± 44%     -48.0%    1638477 ± 13%  softirqs.CPU186.NET_RX
     48194 ± 19%     -40.9%      28494 ± 28%  softirqs.CPU186.SCHED
   2753794 ± 35%     -55.6%    1223044 ± 28%  softirqs.CPU187.NET_RX
     48711 ± 12%     -52.0%      23387 ± 46%  softirqs.CPU187.SCHED
     53989 ± 16%     -60.2%      21466 ± 31%  softirqs.CPU188.SCHED
   2384076 ± 28%     -40.8%    1412505 ± 19%  softirqs.CPU189.NET_RX
     42698 ± 22%     -46.4%      22902 ± 44%  softirqs.CPU189.SCHED
   2686332 ±  8%     -46.4%    1441162 ± 36%  softirqs.CPU19.NET_RX
     32263 ± 13%     -38.1%      19986 ± 36%  softirqs.CPU19.SCHED
   2573552 ± 32%     -35.3%    1664384 ± 20%  softirqs.CPU190.NET_RX
   2641313 ± 36%     -30.6%    1833708 ±  8%  softirqs.CPU191.NET_RX
   2504611 ±  8%     -41.0%    1477849 ± 18%  softirqs.CPU2.NET_RX
   2845833 ±  9%     -41.6%    1663141 ± 14%  softirqs.CPU20.NET_RX
     36451 ± 18%     -45.1%      20023 ± 31%  softirqs.CPU20.SCHED
   2659091 ±  9%     -49.7%    1337253 ± 18%  softirqs.CPU21.NET_RX
     34403 ± 16%     -55.6%      15274 ± 24%  softirqs.CPU21.SCHED
   2743681 ±  9%     -46.0%    1480961 ± 26%  softirqs.CPU22.NET_RX
     36228 ± 16%     -47.7%      18943 ± 26%  softirqs.CPU22.SCHED
   2679441 ± 12%     -39.4%    1625081 ± 11%  softirqs.CPU23.NET_RX
     35508 ± 19%     -25.9%      26299 ± 19%  softirqs.CPU23.SCHED
   3079975 ± 21%     -43.4%    1742003 ±  6%  softirqs.CPU24.NET_RX
   3147505 ± 25%     -55.7%    1394293 ± 16%  softirqs.CPU25.NET_RX
     27604 ± 11%     -34.8%      17997 ± 25%  softirqs.CPU25.SCHED
   3142164 ± 19%     -44.0%    1759559 ±  9%  softirqs.CPU26.NET_RX
   3139990 ± 25%     -55.5%    1397428 ± 25%  softirqs.CPU27.NET_RX
   3423302 ± 24%     -52.3%    1633571 ± 21%  softirqs.CPU28.NET_RX
   3183269 ± 18%     -48.2%    1648689 ± 22%  softirqs.CPU29.NET_RX
     32549 ± 18%     -30.2%      22733 ± 22%  softirqs.CPU29.SCHED
   2360622 ±  7%     -36.9%    1490348 ± 28%  softirqs.CPU3.NET_RX
   3341152 ± 14%     -55.1%    1500296 ± 14%  softirqs.CPU30.NET_RX
     29104 ± 21%     -22.7%      22486 ±  8%  softirqs.CPU30.SCHED
   3265019 ± 15%     -49.5%    1649112 ± 21%  softirqs.CPU31.NET_RX
   3477261 ± 11%     -60.8%    1364031 ± 19%  softirqs.CPU32.NET_RX
   3477803 ± 15%     -59.0%    1426551 ± 25%  softirqs.CPU33.NET_RX
     28698 ± 13%     -38.2%      17743 ± 31%  softirqs.CPU33.SCHED
   3454786 ± 21%     -55.8%    1527719 ± 30%  softirqs.CPU34.NET_RX
   3187114 ± 17%     -59.1%    1303766 ± 30%  softirqs.CPU35.NET_RX
     32320 ±  8%     -36.3%      20591 ± 44%  softirqs.CPU35.SCHED
   3826701 ± 17%     -68.9%    1189508 ± 19%  softirqs.CPU36.NET_RX
     35974 ±  5%     -46.3%      19331 ± 34%  softirqs.CPU36.SCHED
   3493579 ± 17%     -56.6%    1516418 ± 15%  softirqs.CPU37.NET_RX
     33361 ± 13%     -30.8%      23072 ± 22%  softirqs.CPU37.SCHED
   3520932 ± 16%     -59.7%    1418104 ± 36%  softirqs.CPU38.NET_RX
     35750 ±  5%     -36.2%      22801 ± 38%  softirqs.CPU38.SCHED
   3565998 ± 12%     -61.2%    1385115 ± 18%  softirqs.CPU39.NET_RX
   2482668 ±  9%     -40.3%    1482219 ± 19%  softirqs.CPU4.NET_RX
   3626850 ± 21%     -60.4%    1437274 ± 27%  softirqs.CPU40.NET_RX
   3214798 ± 13%     -56.9%    1384251 ± 22%  softirqs.CPU41.NET_RX
     35949 ± 11%     -38.8%      21996 ± 30%  softirqs.CPU41.SCHED
   3589512 ± 16%     -60.8%    1406472 ± 36%  softirqs.CPU42.NET_RX
     39104 ± 19%     -47.8%      20421 ± 41%  softirqs.CPU42.SCHED
   3501848 ± 16%     -58.4%    1455130 ± 21%  softirqs.CPU43.NET_RX
     38844 ±  9%     -54.1%      17814 ± 17%  softirqs.CPU43.SCHED
   3638528 ± 21%     -65.0%    1272753 ± 25%  softirqs.CPU44.NET_RX
     41268 ± 12%     -52.8%      19458 ± 31%  softirqs.CPU44.SCHED
   3459596 ± 16%     -68.4%    1092443 ± 17%  softirqs.CPU45.NET_RX
     40479 ± 17%     -63.4%      14820 ± 15%  softirqs.CPU45.SCHED
   3411025 ± 20%     -54.3%    1558432 ± 16%  softirqs.CPU46.NET_RX
     44947 ± 20%     -47.7%      23520 ± 19%  softirqs.CPU46.SCHED
   3482646 ± 16%     -55.4%    1552959 ± 18%  softirqs.CPU47.NET_RX
     45972 ± 17%     -41.2%      27049 ± 28%  softirqs.CPU47.SCHED
   2523850 ± 15%     -48.7%    1293986 ± 33%  softirqs.CPU48.NET_RX
   2552666 ± 11%     -35.1%    1655564 ± 14%  softirqs.CPU49.NET_RX
   2571090 ± 10%     -40.1%    1539608 ± 14%  softirqs.CPU5.NET_RX
   2581711 ± 13%     -51.6%    1250613 ± 19%  softirqs.CPU50.NET_RX
   2884667 ± 11%     -47.1%    1525563 ± 31%  softirqs.CPU51.NET_RX
   3079250 ± 12%     -52.2%    1473165 ± 11%  softirqs.CPU52.NET_RX
   2840747 ± 21%     -44.5%    1576170 ±  8%  softirqs.CPU53.NET_RX
   2921278 ± 14%     -52.0%    1401696 ± 16%  softirqs.CPU54.NET_RX
   3169937 ± 17%     -60.8%    1241156 ± 25%  softirqs.CPU55.NET_RX
     36307 ±  8%     -52.5%      17262 ± 38%  softirqs.CPU55.SCHED
   3056456 ±  6%     -53.4%    1422908 ± 25%  softirqs.CPU56.NET_RX
     31795 ± 10%     -44.7%      17568 ± 29%  softirqs.CPU56.SCHED
   3141468 ± 13%     -52.7%    1487422 ±  9%  softirqs.CPU57.NET_RX
   3221467 ±  8%     -56.5%    1402480 ± 25%  softirqs.CPU58.NET_RX
   3502440 ± 14%     -60.5%    1385062 ± 27%  softirqs.CPU59.NET_RX
   2633501 ±  8%     -37.2%    1653750 ± 21%  softirqs.CPU6.NET_RX
   3262285 ± 10%     -55.1%    1463693 ± 26%  softirqs.CPU60.NET_RX
   3039300 ±  5%     -51.3%    1479816 ± 22%  softirqs.CPU61.NET_RX
   2817826 ± 17%     -51.1%    1376685 ± 25%  softirqs.CPU62.NET_RX
   3057336 ± 13%     -50.4%    1516165 ± 18%  softirqs.CPU63.NET_RX
   3067351 ± 11%     -53.7%    1421032 ± 20%  softirqs.CPU64.NET_RX
     34915 ±  7%     -22.2%      27175 ± 15%  softirqs.CPU64.SCHED
   3255527 ± 11%     -58.0%    1368668 ± 25%  softirqs.CPU65.NET_RX
   3245829 ± 14%     -50.6%    1602539 ± 15%  softirqs.CPU66.NET_RX
     43367 ± 10%     -40.4%      25864 ± 25%  softirqs.CPU66.SCHED
   3054422 ± 17%     -45.0%    1681270 ± 14%  softirqs.CPU67.NET_RX
   3024427 ± 10%     -55.6%    1343967 ± 17%  softirqs.CPU68.NET_RX
   3359067 ± 14%     -60.1%    1340486 ± 20%  softirqs.CPU69.NET_RX
     45511 ± 11%     -44.8%      25131 ± 31%  softirqs.CPU69.SCHED
   2581762 ± 12%     -30.1%    1804333 ± 13%  softirqs.CPU7.NET_RX
   3185973 ± 12%     -56.5%    1384547 ±  8%  softirqs.CPU70.NET_RX
     44949 ±  6%     -42.2%      25997 ± 29%  softirqs.CPU70.SCHED
   3100967 ± 12%     -55.4%    1384032 ± 13%  softirqs.CPU71.NET_RX
     42515 ± 18%     -49.1%      21654 ± 28%  softirqs.CPU71.SCHED
   3332116 ± 63%     -50.5%    1649135 ± 22%  softirqs.CPU72.NET_RX
   3459284 ± 55%     -46.1%    1865592 ± 16%  softirqs.CPU73.NET_RX
   3593017 ± 41%     -54.6%    1630199 ± 31%  softirqs.CPU74.NET_RX
   3908371 ± 64%     -52.2%    1866996 ± 17%  softirqs.CPU75.NET_RX
   3424152 ± 38%     -58.6%    1416916 ± 28%  softirqs.CPU76.NET_RX
   3523798 ± 49%     -68.5%    1110373 ± 34%  softirqs.CPU77.NET_RX
   3782170 ± 56%     -59.1%    1547780 ± 22%  softirqs.CPU78.NET_RX
   3831396 ± 58%     -60.5%    1511650 ± 40%  softirqs.CPU79.NET_RX
   2544287 ± 15%     -32.8%    1709146 ± 14%  softirqs.CPU8.NET_RX
   3777653 ± 52%     -57.6%    1603569 ± 40%  softirqs.CPU80.NET_RX
   4121863 ± 60%     -58.1%    1727891 ± 23%  softirqs.CPU81.NET_RX
     38262 ± 10%     -27.5%      27747 ± 17%  softirqs.CPU81.SCHED
   4008537 ± 53%     -67.8%    1291794 ± 23%  softirqs.CPU82.NET_RX
   3925610 ± 57%     -60.9%    1533230 ± 40%  softirqs.CPU83.NET_RX
   3675683 ± 56%     -59.6%    1483266 ± 39%  softirqs.CPU84.NET_RX
   4013276 ± 59%     -51.5%    1946438 ± 19%  softirqs.CPU85.NET_RX
   3980480 ± 59%     -57.3%    1697784 ± 13%  softirqs.CPU86.NET_RX
   3903322 ± 48%     -61.2%    1516172 ± 27%  softirqs.CPU87.NET_RX
     39408 ± 36%     -44.2%      21980 ± 21%  softirqs.CPU87.SCHED
   3820578 ± 42%     -68.5%    1204526 ± 47%  softirqs.CPU89.NET_RX
     41951 ± 21%     -54.5%      19089 ± 62%  softirqs.CPU89.SCHED
   2771428 ±  7%     -39.0%    1690687 ± 19%  softirqs.CPU9.NET_RX
   3937814 ± 53%     -58.8%    1623879 ± 35%  softirqs.CPU90.NET_RX
   4063598 ± 54%     -66.5%    1359492 ± 28%  softirqs.CPU91.NET_RX
     41868 ± 33%     -46.8%      22255 ± 44%  softirqs.CPU91.SCHED
   3610446 ± 40%     -55.8%    1597481 ± 47%  softirqs.CPU92.NET_RX
   4116107 ± 52%     -65.1%    1434570 ± 33%  softirqs.CPU93.NET_RX
     48062 ± 36%     -57.8%      20260 ± 47%  softirqs.CPU93.SCHED
   3649362 ± 39%     -53.6%    1692783 ± 13%  softirqs.CPU94.NET_RX
     46932 ± 22%     -40.0%      28178 ± 34%  softirqs.CPU94.SCHED
   3674896 ± 48%     -53.8%    1695998 ± 19%  softirqs.CPU95.NET_RX
   2906346 ± 10%     -36.3%    1850842 ± 12%  softirqs.CPU96.NET_RX
     47371 ± 17%     -34.1%      31198 ± 25%  softirqs.CPU96.SCHED
   2823944 ±  6%     -46.6%    1506891 ± 27%  softirqs.CPU97.NET_RX
     12566            -8.4%      11511 ±  2%  softirqs.CPU97.RCU
     58287 ± 16%     -60.5%      23031 ± 34%  softirqs.CPU97.SCHED
   2778341 ±  8%     -41.0%    1640505 ± 21%  softirqs.CPU98.NET_RX
     12108 ±  4%      -5.9%      11391 ±  3%  softirqs.CPU98.RCU
     57815 ± 13%     -49.7%      29081 ± 43%  softirqs.CPU98.SCHED
   2754057 ±  9%     -43.6%    1553858 ± 22%  softirqs.CPU99.NET_RX
     55507 ±  4%     -52.1%      26578 ± 38%  softirqs.CPU99.SCHED
 5.877e+08 ± 12%     -51.4%  2.859e+08 ± 10%  softirqs.NET_RX
   8311241 ±  4%     -44.9%    4578168 ± 15%  softirqs.SCHED


                                                                                
                              netperf.Throughput_Mbps                           
                                                                                
  4000 +--------------------------------------------------------------------+   
  3800 |-+                                                .+...             |   
       |                                              ....     ...          |   
  3600 |-+                                         ...            ..        |   
  3400 |-+                                      ...                 ..      |   
       |                                    ....                      ...   |   
  3200 |................+.................+.                             .. |   
  3000 |-+                                                                 .|   
  2800 |-+                                                                  |   
       |                                                                    |   
  2600 |-+                                                                  |   
  2400 |-+                                                                  |   
       |                                                                    |   
  2200 |-+              O                 O                O                |   
  2000 +--------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                           netperf.time.minor_page_faults                       
                                                                                
  48000 +-------------------------------------------------------------------+   
        |........                                                           |   
  46000 |-+      ......                                                     |   
  44000 |-+            ..                                                 ..|   
        |                +................                          ......  |   
  42000 |-+                               +................   ......        |   
        |                                                  +..              |   
  40000 |-+                                                                 |   
        |                                                                   |   
  38000 |-+                                                                 |   
  36000 |-+                                                                 |   
        |                                                                   |   
  34000 |-+              O                                                  |   
        |                                 O                O                |   
  32000 +-------------------------------------------------------------------+   
                                                                                
                                                                                
[*] bisect-good sample
[O] bisect-bad  sample

***************************************************************************************************
lkp-hsw-4ex1: 144 threads Intel(R) Xeon(R) CPU E7-8890 v3 @ 2.50GHz with 512G memory
=========================================================================================
compiler/cpufreq_governor/kconfig/rootfs/runtime/size/tbox_group/test/testcase/ucode:
  gcc-9/performance/x86_64-rhel-8.3/debian-10.4-x86_64-20200603.cgz/300s/8T/lkp-hsw-4ex1/anon-w-seq/vm-scalability/0x16

commit: 
  a349834703 ("sched/fair: Rename sg_lb_stats::sum_nr_running to sum_h_nr_running")
  fcf0553db6 ("sched/fair: Remove meaningless imbalance calculation")

a349834703010183 fcf0553db6f4c79387864f6e4ab 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
    595857            +4.6%     623549        vm-scalability.median
      8.22 ±  7%      -3.2        5.01 ±  5%  vm-scalability.median_stddev%
  88608356            +1.5%   89976003        vm-scalability.throughput
    498624 ±  2%      -9.5%     451343        vm-scalability.time.involuntary_context_switches
      9335            -1.3%       9212        vm-scalability.time.percent_of_cpu_this_job_got
  12408855 ±  9%     -17.1%   10291775 ±  8%  meminfo.DirectMap2M
     20311 ± 40%     +60.3%      32564 ± 16%  numa-numastat.node0.other_node
      1759 ±  8%     +62.0%       2850 ±  6%  syscalls.sys_read.med
      6827 ±  2%      -2.8%       6636        vmstat.system.cs
     12092 ± 18%     -43.8%       6792 ± 30%  numa-vmstat.node0.nr_slab_reclaimable
      6233 ± 26%     +29.4%       8069 ± 23%  numa-vmstat.node3.nr_slab_reclaimable
     14990 ± 12%     +45.0%      21732 ± 18%  numa-vmstat.node3.nr_slab_unreclaimable
     48371 ± 18%     -43.8%      27169 ± 30%  numa-meminfo.node0.KReclaimable
     48371 ± 18%     -43.8%      27169 ± 30%  numa-meminfo.node0.SReclaimable
    167341 ± 16%     -32.6%     112749 ± 31%  numa-meminfo.node0.Slab
     24931 ± 26%     +29.5%      32277 ± 23%  numa-meminfo.node3.KReclaimable
     24931 ± 26%     +29.5%      32277 ± 23%  numa-meminfo.node3.SReclaimable
     59961 ± 12%     +45.0%      86933 ± 18%  numa-meminfo.node3.SUnreclaim
     84893 ± 15%     +40.4%     119211 ± 13%  numa-meminfo.node3.Slab
      4627 ±  9%     +25.4%       5802 ±  4%  slabinfo.eventpoll_pwq.active_objs
      4627 ±  9%     +25.4%       5802 ±  4%  slabinfo.eventpoll_pwq.num_objs
      2190 ± 14%     +26.1%       2762 ±  4%  slabinfo.kmem_cache.active_objs
      2190 ± 14%     +26.1%       2762 ±  4%  slabinfo.kmem_cache.num_objs
      5823 ± 12%     +22.2%       7118 ±  4%  slabinfo.kmem_cache_node.active_objs
      9665 ±  5%     +10.3%      10663 ±  3%  slabinfo.shmem_inode_cache.active_objs
      9775 ±  5%     +10.1%      10762 ±  3%  slabinfo.shmem_inode_cache.num_objs
    322.79            -7.9%     297.22        perf-stat.i.cpu-migrations
     21.89 ±  3%      -1.2       20.69        perf-stat.i.node-load-miss-rate%
  13112232 ±  3%      +3.4%   13562841        perf-stat.i.node-loads
     21.44 ±  2%      -1.1       20.29        perf-stat.overall.node-load-miss-rate%
      3160            +1.9%       3219        perf-stat.overall.path-length
      6748 ±  2%      -2.6%       6570        perf-stat.ps.context-switches
    319.09            -8.2%     292.97        perf-stat.ps.cpu-migrations
  12905267 ±  3%      +3.4%   13345546        perf-stat.ps.node-loads
     12193 ±  5%      +8.6%      13239 ±  4%  softirqs.CPU105.RCU
     12791 ±  6%     +12.4%      14382 ±  7%  softirqs.CPU22.RCU
     12781 ±  5%     +12.3%      14351 ±  4%  softirqs.CPU28.RCU
     12870 ±  4%      +9.0%      14033 ±  7%  softirqs.CPU31.RCU
     11451 ±  5%     +11.7%      12785 ±  4%  softirqs.CPU90.RCU
     11449 ±  6%      +9.1%      12497 ±  6%  softirqs.CPU91.RCU
     11486 ±  6%      +8.9%      12510        softirqs.CPU93.RCU
     12197 ±  5%     +10.4%      13462 ±  5%  softirqs.CPU97.RCU
      3899 ±100%     -78.7%     830.89 ± 67%  sched_debug.cfs_rq:/.load_avg.max
    386.54 ± 91%     -76.1%      92.43 ± 61%  sched_debug.cfs_rq:/.load_avg.stddev
    747.05 ±  7%     -26.9%     546.12 ± 31%  sched_debug.cfs_rq:/.runnable_load_avg.max
   -203275          +540.7%   -1302453        sched_debug.cfs_rq:/.spread0.avg
      1142 ±  5%      +9.6%       1251 ±  6%  sched_debug.cfs_rq:/.util_avg.max
      1.00 ±163%   +2117.5%      22.17 ±100%  sched_debug.cfs_rq:/.util_avg.min
    212.47 ± 14%     -16.9%     176.57 ±  4%  sched_debug.cfs_rq:/.util_est_enqueued.stddev
      0.00 ±  7%    +226.7%       0.00 ± 18%  sched_debug.cpu.next_balance.stddev
      2.48 ± 20%     -24.6%       1.87 ± 11%  sched_debug.cpu.nr_running.max
      0.64 ± 29%     -49.1%       0.33 ± 11%  sched_debug.cpu.nr_running.stddev
    137.50 ± 54%    +194.2%     404.50 ± 78%  interrupts.CPU109.RES:Rescheduling_interrupts
    822.50 ± 22%     -39.4%     498.75 ± 49%  interrupts.CPU114.CAL:Function_call_interrupts
    126.00 ± 72%    +161.1%     329.00 ± 48%  interrupts.CPU117.RES:Rescheduling_interrupts
    153.00 ± 69%    +121.6%     339.00 ± 51%  interrupts.CPU119.RES:Rescheduling_interrupts
    162.75 ± 83%    +170.8%     440.75 ± 36%  interrupts.CPU121.RES:Rescheduling_interrupts
    798.00 ± 30%     -45.0%     438.75 ± 28%  interrupts.CPU126.CAL:Function_call_interrupts
      3831 ± 37%     -96.4%     138.50 ±106%  interrupts.CPU128.NMI:Non-maskable_interrupts
      3831 ± 37%     -96.4%     138.50 ±106%  interrupts.CPU128.PMI:Performance_monitoring_interrupts
    218.25 ± 44%     -51.7%     105.50 ±  4%  interrupts.CPU128.RES:Rescheduling_interrupts
    453.00 ± 74%     -74.3%     116.50 ± 26%  interrupts.CPU130.RES:Rescheduling_interrupts
      2382 ± 15%     -96.6%      80.75 ±133%  interrupts.CPU138.NMI:Non-maskable_interrupts
      2382 ± 15%     -96.6%      80.75 ±133%  interrupts.CPU138.PMI:Performance_monitoring_interrupts
    557.25 ±155%    +341.2%       2458 ± 79%  interrupts.CPU14.NMI:Non-maskable_interrupts
    557.25 ±155%    +341.2%       2458 ± 79%  interrupts.CPU14.PMI:Performance_monitoring_interrupts
    782.00 ± 31%     -37.0%     492.50 ± 50%  interrupts.CPU17.CAL:Function_call_interrupts
    779.75 ± 31%     -36.8%     492.50 ± 50%  interrupts.CPU18.CAL:Function_call_interrupts
    782.25 ± 31%     -37.2%     491.00 ± 49%  interrupts.CPU20.CAL:Function_call_interrupts
      5855 ± 20%     -75.7%       1420 ±106%  interrupts.CPU23.NMI:Non-maskable_interrupts
      5855 ± 20%     -75.7%       1420 ±106%  interrupts.CPU23.PMI:Performance_monitoring_interrupts
    785.00 ± 30%     -38.0%     487.00 ± 51%  interrupts.CPU3.CAL:Function_call_interrupts
      1266 ±166%    +241.5%       4325 ± 38%  interrupts.CPU34.NMI:Non-maskable_interrupts
      1266 ±166%    +241.5%       4325 ± 38%  interrupts.CPU34.PMI:Performance_monitoring_interrupts
    784.00 ± 30%     -37.0%     493.75 ± 49%  interrupts.CPU36.CAL:Function_call_interrupts
    783.25 ± 31%     -37.6%     489.00 ± 51%  interrupts.CPU37.CAL:Function_call_interrupts
    325.75 ± 11%     +80.6%     588.25 ± 45%  interrupts.CPU37.RES:Rescheduling_interrupts
    782.00 ± 31%     -37.0%     492.50 ± 50%  interrupts.CPU39.CAL:Function_call_interrupts
    781.50 ± 31%     -38.0%     484.50 ± 52%  interrupts.CPU41.CAL:Function_call_interrupts
    292.50 ± 21%     +59.2%     465.75 ± 26%  interrupts.CPU43.RES:Rescheduling_interrupts
    233.00 ± 12%     +59.4%     371.50 ± 20%  interrupts.CPU48.RES:Rescheduling_interrupts
    883.00 ±160%     -97.1%      25.25 ±150%  interrupts.CPU50.NMI:Non-maskable_interrupts
    883.00 ±160%     -97.1%      25.25 ±150%  interrupts.CPU50.PMI:Performance_monitoring_interrupts
    265.25 ± 28%     +69.8%     450.50 ± 27%  interrupts.CPU50.RES:Rescheduling_interrupts
    249.75 ± 19%     +40.8%     351.75 ± 11%  interrupts.CPU51.RES:Rescheduling_interrupts
    785.50 ± 30%     -37.2%     493.00 ± 49%  interrupts.CPU53.CAL:Function_call_interrupts
      1.75 ±116%  +1.2e+05%       2020 ±108%  interrupts.CPU53.NMI:Non-maskable_interrupts
      1.75 ±116%  +1.2e+05%       2020 ±108%  interrupts.CPU53.PMI:Performance_monitoring_interrupts
    826.75 ± 79%    +429.5%       4377 ± 27%  interrupts.CPU56.NMI:Non-maskable_interrupts
    826.75 ± 79%    +429.5%       4377 ± 27%  interrupts.CPU56.PMI:Performance_monitoring_interrupts
    782.50 ± 31%     -37.6%     488.00 ± 51%  interrupts.CPU57.CAL:Function_call_interrupts
     32.25 ±164%    -100.0%       0.00        interrupts.CPU57.TLB:TLB_shootdowns
    782.50 ± 31%     -36.9%     494.00 ± 50%  interrupts.CPU6.CAL:Function_call_interrupts
    781.00 ± 31%     -36.8%     493.50 ± 50%  interrupts.CPU61.CAL:Function_call_interrupts
    658.75 ±169%    +429.9%       3490 ± 43%  interrupts.CPU61.NMI:Non-maskable_interrupts
    658.75 ±169%    +429.9%       3490 ± 43%  interrupts.CPU61.PMI:Performance_monitoring_interrupts
    405.75 ± 20%     -35.6%     261.50 ± 17%  interrupts.CPU62.RES:Rescheduling_interrupts
    781.75 ± 31%     -36.8%     494.00 ± 50%  interrupts.CPU65.CAL:Function_call_interrupts
    782.50 ± 31%     -37.0%     492.75 ± 50%  interrupts.CPU66.CAL:Function_call_interrupts
    838.25 ±121%    +513.8%       5145 ± 30%  interrupts.CPU66.NMI:Non-maskable_interrupts
    838.25 ±121%    +513.8%       5145 ± 30%  interrupts.CPU66.PMI:Performance_monitoring_interrupts
    782.00 ± 31%     -37.1%     492.25 ± 50%  interrupts.CPU67.CAL:Function_call_interrupts
    782.25 ± 31%     -37.0%     492.75 ± 49%  interrupts.CPU69.CAL:Function_call_interrupts
    780.00 ± 31%     -37.3%     489.25 ± 49%  interrupts.CPU71.CAL:Function_call_interrupts
    784.25 ± 31%     -38.0%     486.50 ± 51%  interrupts.CPU75.CAL:Function_call_interrupts
    783.25 ± 31%     -36.9%     494.25 ± 50%  interrupts.CPU77.CAL:Function_call_interrupts
    822.00 ± 33%     -39.9%     494.25 ± 50%  interrupts.CPU83.CAL:Function_call_interrupts
    789.75 ± 29%     -37.1%     496.50 ± 49%  interrupts.CPU90.CAL:Function_call_interrupts
      5966 ± 15%     -53.5%       2777 ± 62%  interrupts.CPU94.NMI:Non-maskable_interrupts
      5966 ± 15%     -53.5%       2777 ± 62%  interrupts.CPU94.PMI:Performance_monitoring_interrupts
     46379 ±  9%     -10.1%      41674 ±  4%  interrupts.RES:Rescheduling_interrupts
     68.78           -10.0       58.75 ±  8%  perf-profile.calltrace.cycles-pp.do_access
     30.04 ±  4%      -4.3       25.69 ±  9%  perf-profile.calltrace.cycles-pp.do_page_fault.page_fault.do_access
     30.06 ±  4%      -4.3       25.71 ±  9%  perf-profile.calltrace.cycles-pp.page_fault.do_access
     30.00 ±  4%      -4.3       25.66 ±  9%  perf-profile.calltrace.cycles-pp.do_user_addr_fault.do_page_fault.page_fault.do_access
     29.93 ±  4%      -4.3       25.59 ±  9%  perf-profile.calltrace.cycles-pp.handle_mm_fault.do_user_addr_fault.do_page_fault.page_fault.do_access
     26.63 ±  2%      -2.7       23.88 ±  6%  perf-profile.calltrace.cycles-pp.do_rw_once
      0.57 ±  5%      -0.3        0.27 ±100%  perf-profile.calltrace.cycles-pp.rmqueue.get_page_from_freelist.__alloc_pages_nodemask.alloc_pages_vma.do_huge_pmd_anonymous_page
      0.63 ±  6%      -0.2        0.43 ± 58%  perf-profile.calltrace.cycles-pp.__alloc_pages_nodemask.alloc_pages_vma.do_huge_pmd_anonymous_page.__handle_mm_fault.handle_mm_fault
      0.63 ±  6%      -0.2        0.43 ± 58%  perf-profile.calltrace.cycles-pp.alloc_pages_vma.do_huge_pmd_anonymous_page.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
      0.62 ±  5%      -0.2        0.42 ± 58%  perf-profile.calltrace.cycles-pp.get_page_from_freelist.__alloc_pages_nodemask.alloc_pages_vma.do_huge_pmd_anonymous_page.__handle_mm_fault
     28.25 ±  5%      +6.6       34.88 ±  6%  perf-profile.calltrace.cycles-pp.clear_page_erms.clear_subpage.clear_huge_page.do_huge_pmd_anonymous_page.__handle_mm_fault
     29.30 ±  5%      +6.7       36.03 ±  6%  perf-profile.calltrace.cycles-pp.clear_subpage.clear_huge_page.do_huge_pmd_anonymous_page.__handle_mm_fault.handle_mm_fault
     30.21 ±  5%      +7.0       37.23 ±  6%  perf-profile.calltrace.cycles-pp.clear_huge_page.do_huge_pmd_anonymous_page.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
     31.31 ±  5%      +7.3       38.61 ±  6%  perf-profile.calltrace.cycles-pp.do_huge_pmd_anonymous_page.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.do_page_fault
     31.39 ±  5%      +7.3       38.70 ±  6%  perf-profile.calltrace.cycles-pp.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.do_page_fault.page_fault
      1.50 ±106%     +11.7       13.17 ± 35%  perf-profile.calltrace.cycles-pp.handle_mm_fault.do_user_addr_fault.do_page_fault.page_fault
      1.50 ±106%     +11.7       13.20 ± 35%  perf-profile.calltrace.cycles-pp.do_user_addr_fault.do_page_fault.page_fault
      1.51 ±106%     +11.7       13.21 ± 35%  perf-profile.calltrace.cycles-pp.page_fault
      1.50 ±106%     +11.7       13.21 ± 35%  perf-profile.calltrace.cycles-pp.do_page_fault.page_fault
     65.44            -9.4       56.04 ±  8%  perf-profile.children.cycles-pp.do_access
     30.08            -3.4       26.70 ±  7%  perf-profile.children.cycles-pp.do_rw_once
      0.06 ± 11%      +0.0        0.08 ± 10%  perf-profile.children.cycles-pp.pagevec_lru_move_fn
      0.14 ±  6%      +0.0        0.16 ±  6%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      0.13 ± 10%      +0.0        0.16 ±  9%  perf-profile.children.cycles-pp.pte_alloc_one
      0.12 ± 12%      +0.0        0.15 ±  8%  perf-profile.children.cycles-pp.prep_new_page
      0.12 ± 10%      +0.0        0.16 ± 20%  perf-profile.children.cycles-pp.perf_mux_hrtimer_handler
      0.12 ±  9%      +0.0        0.15 ± 10%  perf-profile.children.cycles-pp.prepare_exit_to_usermode
      0.14 ±  8%      +0.0        0.19 ±  9%  perf-profile.children.cycles-pp.swapgs_restore_regs_and_return_to_usermode
      0.00            +0.1        0.05 ±  8%  perf-profile.children.cycles-pp.irq_work_interrupt
      0.00            +0.1        0.05 ±  8%  perf-profile.children.cycles-pp.smp_irq_work_interrupt
      0.00            +0.1        0.05 ±  8%  perf-profile.children.cycles-pp.irq_work_run
      0.00            +0.1        0.05 ±  8%  perf-profile.children.cycles-pp.printk
      0.00            +0.1        0.06 ± 11%  perf-profile.children.cycles-pp.irq_work_run_list
      0.00            +0.1        0.07 ± 31%  perf-profile.children.cycles-pp.__intel_pmu_enable_all
      0.35 ±  3%      +0.1        0.43 ±  7%  perf-profile.children.cycles-pp._cond_resched
      0.38 ±  6%      +0.1        0.48 ±  6%  perf-profile.children.cycles-pp.___might_sleep
      0.46 ±  8%      +0.1        0.60 ± 13%  perf-profile.children.cycles-pp.scheduler_tick
      0.66 ±  8%      +0.2        0.81 ±  8%  perf-profile.children.cycles-pp.rmqueue
      0.70 ±  8%      +0.2        0.87 ±  8%  perf-profile.children.cycles-pp.alloc_pages_vma
      0.79 ±  9%      +0.2        0.97 ±  8%  perf-profile.children.cycles-pp.get_page_from_freelist
      0.83 ±  8%      +0.2        1.03 ±  7%  perf-profile.children.cycles-pp.__alloc_pages_nodemask
      1.09 ±  6%      +0.3        1.38 ± 11%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      2.11 ±  3%      +0.5        2.63 ± 12%  perf-profile.children.cycles-pp.apic_timer_interrupt
     28.56 ±  5%      +6.6       35.18 ±  6%  perf-profile.children.cycles-pp.clear_page_erms
     29.39 ±  5%      +6.8       36.14 ±  6%  perf-profile.children.cycles-pp.clear_subpage
     30.34 ±  5%      +7.0       37.30 ±  6%  perf-profile.children.cycles-pp.clear_huge_page
     31.39 ±  5%      +7.2       38.61 ±  6%  perf-profile.children.cycles-pp.do_huge_pmd_anonymous_page
     31.47 ±  5%      +7.2       38.72 ±  6%  perf-profile.children.cycles-pp.__handle_mm_fault
     31.52 ±  5%      +7.3       38.77 ±  6%  perf-profile.children.cycles-pp.handle_mm_fault
     31.60 ±  5%      +7.3       38.87 ±  6%  perf-profile.children.cycles-pp.do_user_addr_fault
     31.67 ±  5%      +7.3       38.95 ±  6%  perf-profile.children.cycles-pp.page_fault
     31.63 ±  5%      +7.3       38.91 ±  6%  perf-profile.children.cycles-pp.do_page_fault
     29.16 ±  4%      -4.1       25.05 ±  7%  perf-profile.self.cycles-pp.do_access
     27.38            -3.1       24.28 ±  7%  perf-profile.self.cycles-pp.do_rw_once
      0.05 ±  8%      +0.0        0.07 ± 12%  perf-profile.self.cycles-pp.prep_new_page
      0.09 ±  9%      +0.0        0.12 ± 11%  perf-profile.self.cycles-pp.prepare_exit_to_usermode
      0.00            +0.1        0.05 ±  8%  perf-profile.self.cycles-pp.do_huge_pmd_anonymous_page
      0.00            +0.1        0.07 ± 31%  perf-profile.self.cycles-pp.__intel_pmu_enable_all
      0.28 ±  3%      +0.1        0.35 ±  7%  perf-profile.self.cycles-pp._cond_resched
      0.35 ±  4%      +0.1        0.43 ±  6%  perf-profile.self.cycles-pp.___might_sleep
      0.48 ±  8%      +0.1        0.60 ±  9%  perf-profile.self.cycles-pp.rmqueue
      0.88 ±  4%      +0.2        1.11 ±  3%  perf-profile.self.cycles-pp.clear_subpage
     28.18 ±  5%      +6.4       34.57 ±  6%  perf-profile.self.cycles-pp.clear_page_erms





Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


Thanks,
Rong Chen


--rW45g2D1DgwV0HVw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="config-5.4.0-rc1-00009-gfcf0553db6f4c"

#
# Automatically generated file; DO NOT EDIT.
# Linux/x86_64 5.4.0-rc1 Kernel Configuration
#

#
# Compiler: gcc-9 (Debian 9.3.0-15) 9.3.0
#
CONFIG_CC_IS_GCC=y
CONFIG_GCC_VERSION=90300
CONFIG_CLANG_VERSION=0
CONFIG_CC_CAN_LINK=y
CONFIG_CC_HAS_ASM_GOTO=y
CONFIG_CC_HAS_ASM_INLINE=y
CONFIG_CC_HAS_WARN_MAYBE_UNINITIALIZED=y
CONFIG_IRQ_WORK=y
CONFIG_BUILDTIME_EXTABLE_SORT=y
CONFIG_THREAD_INFO_IN_TASK=y

#
# General setup
#
CONFIG_INIT_ENV_ARG_LIMIT=32
# CONFIG_COMPILE_TEST is not set
# CONFIG_HEADER_TEST is not set
CONFIG_LOCALVERSION=""
CONFIG_LOCALVERSION_AUTO=y
CONFIG_BUILD_SALT=""
CONFIG_HAVE_KERNEL_GZIP=y
CONFIG_HAVE_KERNEL_BZIP2=y
CONFIG_HAVE_KERNEL_LZMA=y
CONFIG_HAVE_KERNEL_XZ=y
CONFIG_HAVE_KERNEL_LZO=y
CONFIG_HAVE_KERNEL_LZ4=y
CONFIG_KERNEL_GZIP=y
# CONFIG_KERNEL_BZIP2 is not set
# CONFIG_KERNEL_LZMA is not set
# CONFIG_KERNEL_XZ is not set
# CONFIG_KERNEL_LZO is not set
# CONFIG_KERNEL_LZ4 is not set
CONFIG_DEFAULT_HOSTNAME="(none)"
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_SYSVIPC_SYSCTL=y
CONFIG_POSIX_MQUEUE=y
CONFIG_POSIX_MQUEUE_SYSCTL=y
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
CONFIG_IRQ_DOMAIN=y
CONFIG_IRQ_DOMAIN_HIERARCHY=y
CONFIG_GENERIC_MSI_IRQ=y
CONFIG_GENERIC_MSI_IRQ_DOMAIN=y
CONFIG_GENERIC_IRQ_MATRIX_ALLOCATOR=y
CONFIG_GENERIC_IRQ_RESERVATION_MODE=y
CONFIG_IRQ_FORCED_THREADING=y
CONFIG_SPARSE_IRQ=y
# CONFIG_GENERIC_IRQ_DEBUGFS is not set
# end of IRQ subsystem

CONFIG_CLOCKSOURCE_WATCHDOG=y
CONFIG_ARCH_CLOCKSOURCE_DATA=y
CONFIG_ARCH_CLOCKSOURCE_INIT=y
CONFIG_CLOCKSOURCE_VALIDATE_LAST_CYCLE=y
CONFIG_GENERIC_TIME_VSYSCALL=y
CONFIG_GENERIC_CLOCKEVENTS=y
CONFIG_GENERIC_CLOCKEVENTS_BROADCAST=y
CONFIG_GENERIC_CLOCKEVENTS_MIN_ADJUST=y
CONFIG_GENERIC_CMOS_UPDATE=y

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
CONFIG_TASKS_RCU=y
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
# end of Scheduler features

CONFIG_ARCH_SUPPORTS_NUMA_BALANCING=y
CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=y
CONFIG_ARCH_SUPPORTS_INT128=y
CONFIG_NUMA_BALANCING=y
CONFIG_NUMA_BALANCING_DEFAULT_ENABLED=y
CONFIG_CGROUPS=y
CONFIG_PAGE_COUNTER=y
CONFIG_MEMCG=y
CONFIG_MEMCG_SWAP=y
CONFIG_MEMCG_SWAP_ENABLED=y
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
CONFIG_MEMBARRIER=y
CONFIG_KALLSYMS=y
CONFIG_KALLSYMS_ALL=y
CONFIG_KALLSYMS_ABSOLUTE_PERCPU=y
CONFIG_KALLSYMS_BASE_RELATIVE=y
CONFIG_BPF_SYSCALL=y
CONFIG_BPF_JIT_ALWAYS_ON=y
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
CONFIG_ARCH_DEFCONFIG="arch/x86/configs/x86_64_defconfig"
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
# CONFIG_KVM_DEBUG_FS is not set
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
CONFIG_CPU_SUP_INTEL=y
CONFIG_CPU_SUP_AMD=y
CONFIG_CPU_SUP_HYGON=y
CONFIG_CPU_SUP_CENTAUR=y
CONFIG_CPU_SUP_ZHAOXIN=y
CONFIG_HPET_TIMER=y
CONFIG_HPET_EMULATE_RTC=y
CONFIG_DMI=y
# CONFIG_GART_IOMMU is not set
# CONFIG_CALGARY_IOMMU is not set
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
CONFIG_AMD_NUMA=y
CONFIG_X86_64_ACPI_NUMA=y
CONFIG_NODES_SPAN_OTHER_NODES=y
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
CONFIG_X86_INTEL_UMIP=y
# CONFIG_X86_INTEL_MPX is not set
CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS=y
CONFIG_EFI=y
CONFIG_EFI_STUB=y
CONFIG_EFI_MIXED=y
CONFIG_SECCOMP=y
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
# CONFIG_ACPI_PROCFS_POWER is not set
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
CONFIG_ACPI_NUMA=y
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
# CONFIG_ACPI_HMAT is not set
CONFIG_HAVE_ACPI_APEI=y
CONFIG_HAVE_ACPI_APEI_NMI=y
CONFIG_ACPI_APEI=y
CONFIG_ACPI_APEI_GHES=y
CONFIG_ACPI_APEI_PCIEAER=y
CONFIG_ACPI_APEI_MEMORY_FAILURE=y
CONFIG_ACPI_APEI_EINJ=m
CONFIG_ACPI_APEI_ERST_DEBUG=y
CONFIG_DPTF_POWER=m
CONFIG_ACPI_WATCHDOG=y
CONFIG_ACPI_EXTLOG=m
CONFIG_ACPI_ADXL=y
CONFIG_PMIC_OPREGION=y
# CONFIG_ACPI_CONFIGFS is not set
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
# CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_CONSERVATIVE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_SCHEDUTIL is not set
CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
CONFIG_CPU_FREQ_GOV_POWERSAVE=y
CONFIG_CPU_FREQ_GOV_USERSPACE=y
CONFIG_CPU_FREQ_GOV_ONDEMAND=y
CONFIG_CPU_FREQ_GOV_CONSERVATIVE=y
# CONFIG_CPU_FREQ_GOV_SCHEDUTIL is not set

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

CONFIG_X86_DEV_DMA_OPS=y

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
# CONFIG_EFI_BOOTLOADER_CONTROL is not set
# CONFIG_EFI_CAPSULE_LOADER is not set
# CONFIG_EFI_TEST is not set
CONFIG_APPLE_PROPERTIES=y
# CONFIG_RESET_ATTACK_MITIGATION is not set
# CONFIG_EFI_RCI2_TABLE is not set
# end of EFI (Extensible Firmware Interface) Support

CONFIG_UEFI_CPER=y
CONFIG_UEFI_CPER_X86=y
CONFIG_EFI_DEV_PATH_PARSER=y
CONFIG_EFI_EARLYCON=y

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
CONFIG_VIRTUALIZATION=y
CONFIG_KVM=m
CONFIG_KVM_INTEL=m
CONFIG_KVM_AMD=m
CONFIG_KVM_AMD_SEV=y
CONFIG_KVM_MMU_AUDIT=y
CONFIG_VHOST_NET=m
# CONFIG_VHOST_SCSI is not set
CONFIG_VHOST_VSOCK=m
CONFIG_VHOST=m
# CONFIG_VHOST_CROSS_ENDIAN_LEGACY is not set

#
# General architecture-dependent options
#
CONFIG_CRASH_CORE=y
CONFIG_KEXEC_CORE=y
CONFIG_HOTPLUG_SMT=y
CONFIG_OPROFILE=m
CONFIG_OPROFILE_EVENT_MULTIPLEX=y
CONFIG_HAVE_OPROFILE=y
CONFIG_OPROFILE_NMI_TIMER=y
CONFIG_KPROBES=y
CONFIG_JUMP_LABEL=y
# CONFIG_STATIC_KEYS_SELFTEST is not set
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
CONFIG_HAVE_CLK=y
CONFIG_HAVE_HW_BREAKPOINT=y
CONFIG_HAVE_MIXED_BREAKPOINTS_REGS=y
CONFIG_HAVE_USER_RETURN_NOTIFIER=y
CONFIG_HAVE_PERF_EVENTS_NMI=y
CONFIG_HAVE_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HAVE_PERF_REGS=y
CONFIG_HAVE_PERF_USER_STACK_DUMP=y
CONFIG_HAVE_ARCH_JUMP_LABEL=y
CONFIG_HAVE_ARCH_JUMP_LABEL_RELATIVE=y
CONFIG_HAVE_RCU_TABLE_FREE=y
CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG=y
CONFIG_HAVE_ALIGNED_STRUCT_PAGE=y
CONFIG_HAVE_CMPXCHG_LOCAL=y
CONFIG_HAVE_CMPXCHG_DOUBLE=y
CONFIG_ARCH_WANT_COMPAT_IPC_PARSE_VERSION=y
CONFIG_ARCH_WANT_OLD_COMPAT_IPC=y
CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
CONFIG_SECCOMP_FILTER=y
CONFIG_HAVE_ARCH_STACKLEAK=y
CONFIG_HAVE_STACKPROTECTOR=y
CONFIG_CC_HAS_STACKPROTECTOR_NONE=y
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
CONFIG_HAVE_IRQ_EXIT_ON_IRQ_STACK=y
CONFIG_ARCH_HAS_ELF_RANDOMIZE=y
CONFIG_HAVE_ARCH_MMAP_RND_BITS=y
CONFIG_HAVE_EXIT_THREAD=y
CONFIG_ARCH_MMAP_RND_BITS=28
CONFIG_HAVE_ARCH_MMAP_RND_COMPAT_BITS=y
CONFIG_ARCH_MMAP_RND_COMPAT_BITS=8
CONFIG_HAVE_ARCH_COMPAT_MMAP_BASES=y
CONFIG_HAVE_COPY_THREAD_TLS=y
CONFIG_HAVE_STACK_VALIDATION=y
CONFIG_HAVE_RELIABLE_STACKTRACE=y
CONFIG_OLD_SIGSUSPEND3=y
CONFIG_COMPAT_OLD_SIGACTION=y
CONFIG_64BIT_TIME=y
CONFIG_COMPAT_32BIT_TIME=y
CONFIG_HAVE_ARCH_VMAP_STACK=y
CONFIG_VMAP_STACK=y
CONFIG_ARCH_HAS_STRICT_KERNEL_RWX=y
CONFIG_STRICT_KERNEL_RWX=y
CONFIG_ARCH_HAS_STRICT_MODULE_RWX=y
CONFIG_STRICT_MODULE_RWX=y
CONFIG_ARCH_HAS_REFCOUNT=y
# CONFIG_REFCOUNT_FULL is not set
CONFIG_HAVE_ARCH_PREL32_RELOCATIONS=y
CONFIG_ARCH_USE_MEMREMAP_PROT=y
# CONFIG_LOCK_EVENT_COUNTS is not set
CONFIG_ARCH_HAS_MEM_ENCRYPT=y

#
# GCOV-based kernel profiling
#
# CONFIG_GCOV_KERNEL is not set
CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
# end of GCOV-based kernel profiling

CONFIG_PLUGIN_HOSTCC=""
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
CONFIG_BLK_DEV_BSG=y
CONFIG_BLK_DEV_BSGLIB=y
CONFIG_BLK_DEV_INTEGRITY=y
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
CONFIG_HAVE_MEMORY_PRESENT=y
CONFIG_SPARSEMEM_EXTREME=y
CONFIG_SPARSEMEM_VMEMMAP_ENABLE=y
CONFIG_SPARSEMEM_VMEMMAP=y
CONFIG_HAVE_MEMBLOCK_NODE_MAP=y
CONFIG_HAVE_FAST_GUP=y
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
CONFIG_TRANSPARENT_HUGE_PAGECACHE=y
CONFIG_CLEANCACHE=y
CONFIG_FRONTSWAP=y
CONFIG_CMA=y
# CONFIG_CMA_DEBUG is not set
# CONFIG_CMA_DEBUGFS is not set
CONFIG_CMA_AREAS=7
CONFIG_ZSWAP=y
CONFIG_ZPOOL=y
CONFIG_ZBUD=y
# CONFIG_Z3FOLD is not set
CONFIG_ZSMALLOC=y
# CONFIG_PGTABLE_MAPPING is not set
CONFIG_ZSMALLOC_STAT=y
CONFIG_GENERIC_EARLY_IOREMAP=y
CONFIG_DEFERRED_STRUCT_PAGE_INIT=y
CONFIG_IDLE_PAGE_TRACKING=y
CONFIG_ARCH_HAS_PTE_DEVMAP=y
CONFIG_ZONE_DEVICE=y
CONFIG_DEV_PAGEMAP_OPS=y
CONFIG_DEVICE_PRIVATE=y
CONFIG_ARCH_USES_HIGH_VMA_FLAGS=y
CONFIG_ARCH_HAS_PKEYS=y
# CONFIG_PERCPU_STATS is not set
# CONFIG_GUP_BENCHMARK is not set
# CONFIG_READ_ONLY_THP_FOR_FS is not set
CONFIG_ARCH_HAS_PTE_SPECIAL=y
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
CONFIG_XFRM=y
CONFIG_XFRM_OFFLOAD=y
CONFIG_XFRM_ALGO=y
CONFIG_XFRM_USER=y
# CONFIG_XFRM_INTERFACE is not set
CONFIG_XFRM_SUB_POLICY=y
CONFIG_XFRM_MIGRATE=y
CONFIG_XFRM_STATISTICS=y
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
CONFIG_NETLABEL=y
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
CONFIG_NF_TABLES_SET=m
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
CONFIG_NET_SCH_INGRESS=m
CONFIG_NET_SCH_PLUG=m
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
# CONFIG_NET_ACT_CT is not set
# CONFIG_NET_TC_SKB_EXT is not set
CONFIG_NET_SCH_FIFO=y
CONFIG_DCB=y
CONFIG_DNS_RESOLVER=m
# CONFIG_BATMAN_ADV is not set
CONFIG_OPENVSWITCH=m
CONFIG_OPENVSWITCH_GRE=m
CONFIG_VSOCKETS=m
CONFIG_VSOCKETS_DIAG=m
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
# CONFIG_BT_SELFTEST is not set
CONFIG_BT_DEBUGFS=y

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
CONFIG_FAILOVER=m
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
# CONFIG_PCIEASPM_DEBUG is not set
CONFIG_PCIEASPM_DEFAULT=y
# CONFIG_PCIEASPM_POWERSAVE is not set
# CONFIG_PCIEASPM_POWER_SUPERSAVE is not set
# CONFIG_PCIEASPM_PERFORMANCE is not set
CONFIG_PCIE_PME=y
CONFIG_PCIE_DPC=y
# CONFIG_PCIE_PTM is not set
# CONFIG_PCIE_BW is not set
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

#
# Cadence PCIe controllers support
#
# end of Cadence PCIe controllers support

CONFIG_VMD=y
CONFIG_PCI_HYPERV_INTERFACE=m

#
# DesignWare PCI Core Support
#
# CONFIG_PCIE_DW_PLAT_HOST is not set
# CONFIG_PCI_MESON is not set
# end of DesignWare PCI Core Support
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
# end of Firmware loader

CONFIG_ALLOW_DEV_COREDUMP=y
# CONFIG_DEBUG_DRIVER is not set
# CONFIG_DEBUG_DEVRES is not set
# CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
# CONFIG_TEST_ASYNC_DRIVER_PROBE is not set
CONFIG_SYS_HYPERVISOR=y
CONFIG_GENERIC_CPU_AUTOPROBE=y
CONFIG_GENERIC_CPU_VULNERABILITIES=y
CONFIG_REGMAP=y
CONFIG_REGMAP_I2C=y
CONFIG_REGMAP_SPI=y
CONFIG_DMA_SHARED_BUFFER=y
# CONFIG_DMA_FENCE_TRACE is not set
# end of Generic Driver Options

#
# Bus devices
#
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
CONFIG_VIRTIO_BLK=y
# CONFIG_VIRTIO_BLK_SCSI is not set
CONFIG_BLK_DEV_RBD=m
# CONFIG_BLK_DEV_RSXX is not set

#
# NVME Support
#
CONFIG_NVME_CORE=m
CONFIG_BLK_DEV_NVME=m
CONFIG_NVME_MULTIPATH=y
CONFIG_NVME_FABRICS=m
# CONFIG_NVME_RDMA is not set
CONFIG_NVME_FC=m
# CONFIG_NVME_TCP is not set
CONFIG_NVME_TARGET=m
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
# CONFIG_INTEL_MEI_HDCP is not set
CONFIG_VMWARE_VMCI=m

#
# Intel MIC & related support
#

#
# Intel MIC Bus Driver
#
# CONFIG_INTEL_MIC_BUS is not set

#
# SCIF Bus Driver
#
# CONFIG_SCIF_BUS is not set

#
# VOP Bus Driver
#
# CONFIG_VOP_BUS is not set

#
# Intel MIC Host Driver
#

#
# Intel MIC Card Driver
#

#
# SCIF Driver
#

#
# Intel MIC Coprocessor State Management (COSM) Drivers
#

#
# VOP Driver
#
# end of Intel MIC & related support

# CONFIG_GENWQE is not set
# CONFIG_ECHO is not set
# CONFIG_MISC_ALCOR_PCI is not set
CONFIG_MISC_RTSX_PCI=m
# CONFIG_MISC_RTSX_USB is not set
# CONFIG_HABANA_AI is not set
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
CONFIG_BLK_DEV_SR_VENDOR=y
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
# CONFIG_SCSI_SAS_ATA is not set
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
# CONFIG_SCSI_ISCI is not set
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
CONFIG_ATA_VERBOSE_ERROR=y
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
CONFIG_DM_ERA=m
# CONFIG_DM_CLONE is not set
CONFIG_DM_MIRROR=m
CONFIG_DM_LOG_USERSPACE=m
CONFIG_DM_RAID=m
CONFIG_DM_ZERO=m
CONFIG_DM_MULTIPATH=m
CONFIG_DM_MULTIPATH_QL=m
CONFIG_DM_MULTIPATH_ST=m
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
CONFIG_MII=y
CONFIG_NET_CORE=y
# CONFIG_BONDING is not set
# CONFIG_DUMMY is not set
# CONFIG_EQUALIZER is not set
# CONFIG_NET_FC is not set
# CONFIG_IFB is not set
# CONFIG_NET_TEAM is not set
# CONFIG_MACVLAN is not set
# CONFIG_IPVLAN is not set
# CONFIG_VXLAN is not set
# CONFIG_GENEVE is not set
# CONFIG_GTP is not set
# CONFIG_MACSEC is not set
CONFIG_NETCONSOLE=m
CONFIG_NETCONSOLE_DYNAMIC=y
CONFIG_NETPOLL=y
CONFIG_NET_POLL_CONTROLLER=y
# CONFIG_TUN is not set
# CONFIG_TUN_VNET_CROSS_LE is not set
CONFIG_VETH=m
CONFIG_VIRTIO_NET=m
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
# CAIF transport drivers
#

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
CONFIG_TIGON3=y
CONFIG_TIGON3_HWMON=y
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
CONFIG_NET_VENDOR_HP=y
# CONFIG_HP100 is not set
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
CONFIG_SKGE=y
# CONFIG_SKGE_DEBUG is not set
# CONFIG_SKGE_GENESIS is not set
# CONFIG_SKY2 is not set
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
# CONFIG_MSCC_OCELOT_SWITCH is not set
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
CONFIG_YELLOWFIN=m
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
CONFIG_8139CP=y
CONFIG_8139TOO=y
CONFIG_8139TOO_PIO=y
# CONFIG_8139TOO_TUNE_TWISTER is not set
# CONFIG_8139TOO_8129 is not set
# CONFIG_8139_OLD_RX_RESET is not set
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
CONFIG_MDIO_DEVICE=y
CONFIG_MDIO_BUS=y
# CONFIG_MDIO_BCM_UNIMAC is not set
# CONFIG_MDIO_BITBANG is not set
# CONFIG_MDIO_MSCC_MIIM is not set
# CONFIG_MDIO_THUNDER is not set
CONFIG_PHYLIB=y
# CONFIG_LED_TRIGGER_PHY is not set

#
# MII PHY device drivers
#
# CONFIG_ADIN_PHY is not set
# CONFIG_AMD_PHY is not set
# CONFIG_AQUANTIA_PHY is not set
# CONFIG_AX88796B_PHY is not set
# CONFIG_AT803X_PHY is not set
# CONFIG_BCM7XXX_PHY is not set
# CONFIG_BCM87XX_PHY is not set
# CONFIG_BROADCOM_PHY is not set
# CONFIG_CICADA_PHY is not set
# CONFIG_CORTINA_PHY is not set
# CONFIG_DAVICOM_PHY is not set
# CONFIG_DP83822_PHY is not set
# CONFIG_DP83TC811_PHY is not set
# CONFIG_DP83848_PHY is not set
# CONFIG_DP83867_PHY is not set
# CONFIG_FIXED_PHY is not set
# CONFIG_ICPLUS_PHY is not set
# CONFIG_INTEL_XWAY_PHY is not set
# CONFIG_LSI_ET1011C_PHY is not set
# CONFIG_LXT_PHY is not set
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
# CONFIG_VITESSE_PHY is not set
# CONFIG_XILINX_GMII2RGMII is not set
# CONFIG_MICREL_KS8995MA is not set
# CONFIG_PLIP is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set
CONFIG_USB_NET_DRIVERS=y
CONFIG_USB_CATC=y
CONFIG_USB_KAWETH=y
CONFIG_USB_PEGASUS=y
CONFIG_USB_RTL8150=y
# CONFIG_USB_RTL8152 is not set
# CONFIG_USB_LAN78XX is not set
CONFIG_USB_USBNET=y
CONFIG_USB_NET_AX8817X=y
CONFIG_USB_NET_AX88179_178A=y
CONFIG_USB_NET_CDCETHER=y
CONFIG_USB_NET_CDC_EEM=y
CONFIG_USB_NET_CDC_NCM=y
# CONFIG_USB_NET_HUAWEI_CDC_NCM is not set
# CONFIG_USB_NET_CDC_MBIM is not set
CONFIG_USB_NET_DM9601=y
# CONFIG_USB_NET_SR9700 is not set
# CONFIG_USB_NET_SR9800 is not set
CONFIG_USB_NET_SMSC75XX=y
CONFIG_USB_NET_SMSC95XX=y
CONFIG_USB_NET_GL620A=y
CONFIG_USB_NET_NET1080=y
CONFIG_USB_NET_PLUSB=y
CONFIG_USB_NET_MCS7830=y
CONFIG_USB_NET_RNDIS_HOST=y
CONFIG_USB_NET_CDC_SUBSET_ENABLE=y
CONFIG_USB_NET_CDC_SUBSET=y
# CONFIG_USB_ALI_M5632 is not set
# CONFIG_USB_AN2720 is not set
CONFIG_USB_BELKIN=y
CONFIG_USB_ARMLINUX=y
# CONFIG_USB_EPSON2888 is not set
# CONFIG_USB_KC2190 is not set
CONFIG_USB_NET_ZAURUS=y
# CONFIG_USB_NET_CX82310_ETH is not set
# CONFIG_USB_NET_KALMIA is not set
# CONFIG_USB_NET_QMI_WWAN is not set
# CONFIG_USB_HSO is not set
CONFIG_USB_NET_INT51X1=y
CONFIG_USB_IPHETH=y
CONFIG_USB_SIERRA_NET=y
# CONFIG_USB_VL600 is not set
# CONFIG_USB_NET_CH9200 is not set
# CONFIG_USB_NET_AQC111 is not set
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
# CONFIG_THUNDERBOLT_NET is not set
# CONFIG_HYPERV_NET is not set
CONFIG_NETDEVSIM=m
CONFIG_NET_FAILOVER=m
# CONFIG_ISDN is not set
CONFIG_NVM=y
# CONFIG_NVM_PBLK is not set

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
CONFIG_SERIAL_NONSTANDARD=y
# CONFIG_ROCKETPORT is not set
CONFIG_CYCLADES=m
# CONFIG_CYZ_INTR is not set
# CONFIG_MOXA_INTELLIO is not set
# CONFIG_MOXA_SMARTIO is not set
CONFIG_SYNCLINK=m
CONFIG_SYNCLINKMP=m
CONFIG_SYNCLINK_GT=m
CONFIG_NOZOMI=m
# CONFIG_ISI is not set
CONFIG_N_HDLC=m
CONFIG_N_GSM=m
# CONFIG_TRACE_SINK is not set
# CONFIG_NULL_TTY is not set
CONFIG_LDISC_AUTOLOAD=y
CONFIG_DEVMEM=y
# CONFIG_DEVKMEM is not set

#
# Serial drivers
#
CONFIG_SERIAL_EARLYCON=y
CONFIG_SERIAL_8250=y
# CONFIG_SERIAL_8250_DEPRECATED_OPTIONS is not set
CONFIG_SERIAL_8250_PNP=y
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
# end of Serial drivers

CONFIG_SERIAL_MCTRL_GPIO=y
# CONFIG_SERIAL_DEV_BUS is not set
CONFIG_PRINTER=m
# CONFIG_LP_CONSOLE is not set
CONFIG_PPDEV=m
CONFIG_HVC_DRIVER=y
CONFIG_HVC_IRQ=y
CONFIG_HVC_XEN=y
CONFIG_HVC_XEN_FRONTEND=y
CONFIG_VIRTIO_CONSOLE=y
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
CONFIG_HW_RANDOM_VIA=m
CONFIG_HW_RANDOM_VIRTIO=y
CONFIG_NVRAM=y
# CONFIG_APPLICOM is not set
# CONFIG_MWAVE is not set
CONFIG_RAW_DRIVER=y
CONFIG_MAX_RAW_DEVS=8192
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
CONFIG_DEVPORT=y
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
CONFIG_I2C_DESIGNWARE_PLATFORM=m
# CONFIG_I2C_DESIGNWARE_SLAVE is not set
# CONFIG_I2C_DESIGNWARE_PCI is not set
CONFIG_I2C_DESIGNWARE_BAYTRAIL=y
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
CONFIG_I2C_PARPORT_LIGHT=m
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
# CONFIG_SPI_OC_TINY is not set
# CONFIG_SPI_PXA2XX is not set
# CONFIG_SPI_ROCKCHIP is not set
# CONFIG_SPI_SC18IS602 is not set
# CONFIG_SPI_SIFIVE is not set
# CONFIG_SPI_MXIC is not set
# CONFIG_SPI_XCOMM is not set
# CONFIG_SPI_XILINX is not set
# CONFIG_SPI_ZYNQMP_GQSPI is not set

#
# SPI Protocol Masters
#
# CONFIG_SPI_SPIDEV is not set
# CONFIG_SPI_LOOPBACK_TEST is not set
# CONFIG_SPI_TLE62X0 is not set
# CONFIG_SPI_SLAVE is not set
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
CONFIG_PTP_1588_CLOCK_KVM=m
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
CONFIG_PINCTRL_INTEL=m
CONFIG_PINCTRL_BROXTON=m
CONFIG_PINCTRL_CANNONLAKE=m
CONFIG_PINCTRL_CEDARFORK=m
CONFIG_PINCTRL_DENVERTON=m
CONFIG_PINCTRL_GEMINILAKE=m
# CONFIG_PINCTRL_ICELAKE is not set
CONFIG_PINCTRL_LEWISBURG=m
CONFIG_PINCTRL_SUNRISEPOINT=m
CONFIG_GPIOLIB=y
CONFIG_GPIOLIB_FASTPATH_LIMIT=512
CONFIG_GPIO_ACPI=y
CONFIG_GPIOLIB_IRQCHIP=y
# CONFIG_DEBUG_GPIO is not set
CONFIG_GPIO_SYSFS=y
CONFIG_GPIO_GENERIC=m

#
# Memory mapped GPIO drivers
#
CONFIG_GPIO_AMDPT=m
# CONFIG_GPIO_DWAPB is not set
# CONFIG_GPIO_EXAR is not set
# CONFIG_GPIO_GENERIC_PLATFORM is not set
CONFIG_GPIO_ICH=m
# CONFIG_GPIO_LYNXPOINT is not set
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

# CONFIG_GPIO_MOCKUP is not set
# CONFIG_W1 is not set
# CONFIG_POWER_AVS is not set
CONFIG_POWER_RESET=y
# CONFIG_POWER_RESET_RESTART is not set
CONFIG_POWER_SUPPLY=y
# CONFIG_POWER_SUPPLY_DEBUG is not set
CONFIG_POWER_SUPPLY_HWMON=y
# CONFIG_PDA_POWER is not set
# CONFIG_TEST_POWER is not set
# CONFIG_CHARGER_ADP5061 is not set
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
# CONFIG_CHARGER_BQ25890 is not set
CONFIG_CHARGER_SMB347=m
# CONFIG_BATTERY_GAUGE_LTC2941 is not set
# CONFIG_CHARGER_RT9455 is not set
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
CONFIG_SENSORS_K8TEMP=m
CONFIG_SENSORS_K10TEMP=m
CONFIG_SENSORS_FAM15H_POWER=m
CONFIG_SENSORS_APPLESMC=m
CONFIG_SENSORS_ASB100=m
# CONFIG_SENSORS_ASPEED is not set
CONFIG_SENSORS_ATXP1=m
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
# CONFIG_SENSORS_MAX6621 is not set
CONFIG_SENSORS_MAX6639=m
CONFIG_SENSORS_MAX6642=m
CONFIG_SENSORS_MAX6650=m
CONFIG_SENSORS_MAX6697=m
# CONFIG_SENSORS_MAX31790 is not set
CONFIG_SENSORS_MCP3021=m
# CONFIG_SENSORS_MLXREG_FAN is not set
# CONFIG_SENSORS_TC654 is not set
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
CONFIG_SENSORS_ADM1275=m
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
# CONFIG_SENSORS_MAX20751 is not set
# CONFIG_SENSORS_MAX31785 is not set
CONFIG_SENSORS_MAX34440=m
CONFIG_SENSORS_MAX8688=m
# CONFIG_SENSORS_PXE1610 is not set
# CONFIG_SENSORS_TPS40422 is not set
# CONFIG_SENSORS_TPS53679 is not set
CONFIG_SENSORS_UCD9000=m
CONFIG_SENSORS_UCD9200=m
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
# CONFIG_THERMAL_STATISTICS is not set
CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
CONFIG_THERMAL_HWMON=y
CONFIG_THERMAL_WRITABLE_TRIPS=y
CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE=y
# CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
# CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
# CONFIG_THERMAL_DEFAULT_GOV_POWER_ALLOCATOR is not set
CONFIG_THERMAL_GOV_FAIR_SHARE=y
CONFIG_THERMAL_GOV_STEP_WISE=y
CONFIG_THERMAL_GOV_BANG_BANG=y
CONFIG_THERMAL_GOV_USER_SPACE=y
# CONFIG_THERMAL_GOV_POWER_ALLOCATOR is not set
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
# CONFIG_HTC_PASIC3 is not set
# CONFIG_HTC_I2CPLD is not set
# CONFIG_MFD_INTEL_QUARK_I2C_GPIO is not set
CONFIG_LPC_ICH=y
CONFIG_LPC_SCH=m
# CONFIG_INTEL_SOC_PMIC_CHTDC_TI is not set
CONFIG_MFD_INTEL_LPSS=y
CONFIG_MFD_INTEL_LPSS_ACPI=y
CONFIG_MFD_INTEL_LPSS_PCI=y
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
CONFIG_MFD_SM501=m
CONFIG_MFD_SM501_GPIO=y
# CONFIG_MFD_SKY81452 is not set
# CONFIG_MFD_SMSC is not set
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
CONFIG_MEDIA_SUPPORT=m

#
# Multimedia core support
#
# CONFIG_MEDIA_CAMERA_SUPPORT is not set
# CONFIG_MEDIA_ANALOG_TV_SUPPORT is not set
# CONFIG_MEDIA_DIGITAL_TV_SUPPORT is not set
# CONFIG_MEDIA_RADIO_SUPPORT is not set
# CONFIG_MEDIA_SDR_SUPPORT is not set
# CONFIG_MEDIA_CEC_SUPPORT is not set
# CONFIG_VIDEO_ADV_DEBUG is not set
# CONFIG_VIDEO_FIXED_MINOR_RANGES is not set

#
# Media drivers
#
# CONFIG_MEDIA_USB_SUPPORT is not set
# CONFIG_MEDIA_PCI_SUPPORT is not set

#
# Supported MMC/SDIO adapters
#
# CONFIG_CYPRESS_FIRMWARE is not set

#
# Media ancillary drivers (tuners, sensors, i2c, spi, frontends)
#

#
# Media SPI Adapters
#
# end of Media SPI Adapters

#
# Customise DVB Frontends
#

#
# Tools to develop new frontends
#
# end of Customise DVB Frontends

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
CONFIG_DRM_VRAM_HELPER=m
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

#
# ACP (Audio CoProcessor) Configuration
#
# end of ACP (Audio CoProcessor) Configuration

# CONFIG_DRM_NOUVEAU is not set
CONFIG_DRM_I915=m
# CONFIG_DRM_I915_ALPHA_SUPPORT is not set
CONFIG_DRM_I915_FORCE_PROBE=""
CONFIG_DRM_I915_CAPTURE_ERROR=y
CONFIG_DRM_I915_COMPRESS_ERROR=y
CONFIG_DRM_I915_USERPTR=y
CONFIG_DRM_I915_GVT=y
CONFIG_DRM_I915_GVT_KVMGT=m
CONFIG_DRM_I915_USERFAULT_AUTOSUSPEND=250
CONFIG_DRM_I915_SPIN_REQUEST=5
CONFIG_DRM_VGEM=m
# CONFIG_DRM_VKMS is not set
CONFIG_DRM_VMWGFX=m
CONFIG_DRM_VMWGFX_FBCON=y
CONFIG_DRM_GMA500=m
CONFIG_DRM_GMA600=y
CONFIG_DRM_GMA3600=y
# CONFIG_DRM_UDL is not set
CONFIG_DRM_AST=m
CONFIG_DRM_MGAG200=m
CONFIG_DRM_CIRRUS_QEMU=m
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
# CONFIG_DRM_GM12U320 is not set
# CONFIG_TINYDRM_HX8357D is not set
# CONFIG_TINYDRM_ILI9225 is not set
# CONFIG_TINYDRM_ILI9341 is not set
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
# CONFIG_BACKLIGHT_GENERIC is not set
# CONFIG_BACKLIGHT_PWM is not set
CONFIG_BACKLIGHT_APPLE=m
# CONFIG_BACKLIGHT_PM8941_WLED is not set
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
CONFIG_VGACON_SOFT_SCROLLBACK=y
CONFIG_VGACON_SOFT_SCROLLBACK_SIZE=64
# CONFIG_VGACON_SOFT_SCROLLBACK_PERSISTENT_ENABLE_BY_DEFAULT is not set
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
# CONFIG_HID_HOLTEK is not set
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
# CONFIG_USB_DYNAMIC_MINORS is not set
# CONFIG_USB_OTG is not set
# CONFIG_USB_OTG_WHITELIST is not set
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
# CONFIG_USB_RIO500 is not set
# CONFIG_USB_LEGOTOWER is not set
# CONFIG_USB_LCD is not set
# CONFIG_USB_CYPRESS_CY7C63 is not set
# CONFIG_USB_CYTHERM is not set
# CONFIG_USB_IDMOUSE is not set
# CONFIG_USB_FTDI_ELAN is not set
# CONFIG_USB_APPLEDISPLAY is not set
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
# CONFIG_MMC_TOSHIBA_PCI is not set
# CONFIG_MMC_MTK is not set
# CONFIG_MMC_SDHCI_XENON is not set
# CONFIG_MEMSTICK is not set
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y
# CONFIG_LEDS_CLASS_FLASH is not set
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
CONFIG_LEDS_LP55XX_COMMON=m
CONFIG_LEDS_LP5521=m
CONFIG_LEDS_LP5523=m
CONFIG_LEDS_LP5562=m
# CONFIG_LEDS_LP8501 is not set
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
# CONFIG_INFINIBAND_EXP_LEGACY_VERBS_NEW_UAPI is not set
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
CONFIG_INTEL_IOATDMA=m
# CONFIG_QCOM_HIDMA_MGMT is not set
# CONFIG_QCOM_HIDMA is not set
CONFIG_DW_DMAC_CORE=y
CONFIG_DW_DMAC=m
CONFIG_DW_DMAC_PCI=y
# CONFIG_DW_EDMA is not set
# CONFIG_DW_EDMA_PCIE is not set
CONFIG_HSU_DMA=y

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
# CONFIG_DMABUF_SELFTESTS is not set
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
CONFIG_VIRTIO_BALLOON=y
CONFIG_VIRTIO_INPUT=m
# CONFIG_VIRTIO_MMIO is not set

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
# end of Xen driver support

# CONFIG_GREYBUS is not set
# CONFIG_STAGING is not set
CONFIG_X86_PLATFORM_DEVICES=y
CONFIG_ACER_WMI=m
# CONFIG_ACER_WIRELESS is not set
CONFIG_ACERHDF=m
# CONFIG_ALIENWARE_WMI is not set
CONFIG_ASUS_LAPTOP=m
CONFIG_DCDBAS=m
CONFIG_DELL_SMBIOS=m
CONFIG_DELL_SMBIOS_WMI=y
# CONFIG_DELL_SMBIOS_SMM is not set
CONFIG_DELL_LAPTOP=m
CONFIG_DELL_WMI=m
CONFIG_DELL_WMI_DESCRIPTOR=m
CONFIG_DELL_WMI_AIO=m
CONFIG_DELL_WMI_LED=m
CONFIG_DELL_SMO8800=m
CONFIG_DELL_RBTN=m
CONFIG_DELL_RBU=m
CONFIG_FUJITSU_LAPTOP=m
CONFIG_FUJITSU_TABLET=m
CONFIG_AMILO_RFKILL=m
# CONFIG_GPD_POCKET_FAN is not set
CONFIG_HP_ACCEL=m
CONFIG_HP_WIRELESS=m
CONFIG_HP_WMI=m
# CONFIG_LG_LAPTOP is not set
CONFIG_MSI_LAPTOP=m
CONFIG_PANASONIC_LAPTOP=m
CONFIG_COMPAL_LAPTOP=m
CONFIG_SONY_LAPTOP=m
CONFIG_SONYPI_COMPAT=y
CONFIG_IDEAPAD_LAPTOP=m
# CONFIG_SURFACE3_WMI is not set
CONFIG_THINKPAD_ACPI=m
# CONFIG_THINKPAD_ACPI_DEBUGFACILITIES is not set
# CONFIG_THINKPAD_ACPI_DEBUG is not set
# CONFIG_THINKPAD_ACPI_UNSAFE_LEDS is not set
CONFIG_THINKPAD_ACPI_VIDEO=y
CONFIG_THINKPAD_ACPI_HOTKEY_POLL=y
CONFIG_SENSORS_HDAPS=m
# CONFIG_INTEL_MENLOW is not set
CONFIG_EEEPC_LAPTOP=m
CONFIG_ASUS_WMI=m
CONFIG_ASUS_NB_WMI=m
CONFIG_EEEPC_WMI=m
# CONFIG_ASUS_WIRELESS is not set
CONFIG_ACPI_WMI=m
CONFIG_WMI_BMOF=m
CONFIG_INTEL_WMI_THUNDERBOLT=m
# CONFIG_XIAOMI_WMI is not set
CONFIG_MSI_WMI=m
# CONFIG_PEAQ_WMI is not set
CONFIG_TOPSTAR_LAPTOP=m
CONFIG_TOSHIBA_BT_RFKILL=m
# CONFIG_TOSHIBA_HAPS is not set
# CONFIG_TOSHIBA_WMI is not set
CONFIG_ACPI_CMPC=m
# CONFIG_INTEL_INT0002_VGPIO is not set
CONFIG_INTEL_HID_EVENT=m
CONFIG_INTEL_VBTN=m
CONFIG_INTEL_IPS=m
CONFIG_INTEL_PMC_CORE=m
# CONFIG_IBM_RTL is not set
CONFIG_SAMSUNG_LAPTOP=m
CONFIG_MXM_WMI=m
CONFIG_INTEL_OAKTRAIL=m
CONFIG_SAMSUNG_Q10=m
CONFIG_APPLE_GMUX=m
CONFIG_INTEL_RST=m
# CONFIG_INTEL_SMARTCONNECT is not set
# CONFIG_INTEL_PMC_IPC is not set
# CONFIG_SURFACE_PRO3_BUTTON is not set
# CONFIG_INTEL_PUNIT_IPC is not set
CONFIG_MLX_PLATFORM=m
CONFIG_INTEL_TURBO_MAX_3=y
# CONFIG_I2C_MULTI_INSTANTIATE is not set
# CONFIG_INTEL_ATOMISP2_PM is not set
# CONFIG_HUAWEI_WMI is not set
# CONFIG_PCENGINES_APU2 is not set

#
# Intel Speed Select Technology interface support
#
# CONFIG_INTEL_SPEED_SELECT_INTERFACE is not set
# end of Intel Speed Select Technology interface support

CONFIG_PMC_ATOM=y
# CONFIG_MFD_CROS_EC is not set
# CONFIG_CHROME_PLATFORMS is not set
CONFIG_MELLANOX_PLATFORM=y
CONFIG_MLXREG_HOTPLUG=m
# CONFIG_MLXREG_IO is not set
CONFIG_CLKDEV_LOOKUP=y
CONFIG_HAVE_CLK_PREPARE=y
CONFIG_COMMON_CLK=y

#
# Common Clock Framework
#
# CONFIG_COMMON_CLK_MAX9485 is not set
# CONFIG_COMMON_CLK_SI5341 is not set
# CONFIG_COMMON_CLK_SI5351 is not set
# CONFIG_COMMON_CLK_SI544 is not set
# CONFIG_COMMON_CLK_CDCE706 is not set
# CONFIG_COMMON_CLK_CS2000_CP is not set
# CONFIG_COMMON_CLK_PWM is not set
# end of Common Clock Framework

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
CONFIG_IOMMU_API=y
CONFIG_IOMMU_SUPPORT=y

#
# Generic IOMMU Pagetable Support
#
# end of Generic IOMMU Pagetable Support

# CONFIG_IOMMU_DEBUGFS is not set
# CONFIG_IOMMU_DEFAULT_PASSTHROUGH is not set
CONFIG_AMD_IOMMU=y
CONFIG_AMD_IOMMU_V2=m
CONFIG_DMAR_TABLE=y
CONFIG_INTEL_IOMMU=y
# CONFIG_INTEL_IOMMU_SVM is not set
# CONFIG_INTEL_IOMMU_DEFAULT_ON is not set
CONFIG_INTEL_IOMMU_FLOPPY_WA=y
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
# CONFIG_BCM_KONA_USB2_PHY is not set
# CONFIG_PHY_PXA_28NM_HSIC is not set
# CONFIG_PHY_PXA_28NM_USB2 is not set
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
CONFIG_THUNDERBOLT=y

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
# CONFIG_UNISYS_VISORBUS is not set
# CONFIG_SIOX is not set
# CONFIG_SLIMBUS is not set
# CONFIG_INTERCONNECT is not set
# CONFIG_COUNTER is not set
# end of Device Drivers

#
# File systems
#
CONFIG_DCACHE_WORD_ACCESS=y
# CONFIG_VALIDATE_FS_PARSER is not set
CONFIG_FS_IOMAP=y
# CONFIG_EXT2_FS is not set
# CONFIG_EXT3_FS is not set
CONFIG_EXT4_FS=y
CONFIG_EXT4_USE_FOR_EXT2=y
CONFIG_EXT4_FS_POSIX_ACL=y
CONFIG_EXT4_FS_SECURITY=y
# CONFIG_EXT4_DEBUG is not set
CONFIG_JBD2=y
# CONFIG_JBD2_DEBUG is not set
CONFIG_FS_MBCACHE=y
# CONFIG_REISERFS_FS is not set
# CONFIG_JFS_FS is not set
CONFIG_XFS_FS=m
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
CONFIG_FS_DAX=y
CONFIG_FS_DAX_PMD=y
CONFIG_FS_POSIX_ACL=y
CONFIG_EXPORTFS=y
CONFIG_EXPORTFS_BLOCK_OPS=y
CONFIG_FILE_LOCKING=y
CONFIG_MANDATORY_FILE_LOCKING=y
CONFIG_FS_ENCRYPTION=y
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
CONFIG_QUOTACTL_COMPAT=y
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
# DOS/FAT/NT Filesystems
#
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
CONFIG_VFAT_FS=m
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="ascii"
# CONFIG_FAT_DEFAULT_UTF8 is not set
# CONFIG_NTFS_FS is not set
# end of DOS/FAT/NT Filesystems

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
CONFIG_KERNFS=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
CONFIG_TMPFS_POSIX_ACL=y
CONFIG_TMPFS_XATTR=y
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
CONFIG_NFSD=m
CONFIG_NFSD_V2_ACL=y
CONFIG_NFSD_V3=y
CONFIG_NFSD_V3_ACL=y
CONFIG_NFSD_V4=y
CONFIG_NFSD_PNFS=y
# CONFIG_NFSD_BLOCKLAYOUT is not set
CONFIG_NFSD_SCSILAYOUT=y
# CONFIG_NFSD_FLEXFILELAYOUT is not set
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
CONFIG_9P_FS=y
CONFIG_9P_FS_POSIX_ACL=y
# CONFIG_9P_FS_SECURITY is not set
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
# end of File systems

#
# Security options
#
CONFIG_KEYS=y
CONFIG_KEYS_COMPAT=y
# CONFIG_KEYS_REQUEST_CACHE is not set
CONFIG_PERSISTENT_KEYRINGS=y
CONFIG_BIG_KEYS=y
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
# CONFIG_SECURITY_SMACK is not set
# CONFIG_SECURITY_TOMOYO is not set
CONFIG_SECURITY_APPARMOR=y
CONFIG_SECURITY_APPARMOR_HASH=y
CONFIG_SECURITY_APPARMOR_HASH_DEFAULT=y
# CONFIG_SECURITY_APPARMOR_DEBUG is not set
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
CONFIG_EVM=y
CONFIG_EVM_ATTR_FSUUID=y
# CONFIG_EVM_ADD_XATTRS is not set
# CONFIG_EVM_LOAD_X509 is not set
CONFIG_DEFAULT_SECURITY_SELINUX=y
# CONFIG_DEFAULT_SECURITY_APPARMOR is not set
# CONFIG_DEFAULT_SECURITY_DAC is not set
CONFIG_LSM="lockdown,yama,loadpin,safesetid,integrity,selinux,smack,tomoyo,apparmor"

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
CONFIG_CRYPTO_BLKCIPHER=y
CONFIG_CRYPTO_BLKCIPHER2=y
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
# CONFIG_CRYPTO_XXHASH is not set
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
CONFIG_CRYPTO_LIB_SHA256=y
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
CONFIG_CRYPTO_LIB_AES=y
CONFIG_CRYPTO_AES=y
# CONFIG_CRYPTO_AES_TI is not set
CONFIG_CRYPTO_AES_NI_INTEL=y
CONFIG_CRYPTO_ANUBIS=m
CONFIG_CRYPTO_LIB_ARC4=m
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
CONFIG_CRYPTO_LIB_DES=m
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
CONFIG_CRYPTO_USER_API_AEAD=y
# CONFIG_CRYPTO_STATS is not set
CONFIG_CRYPTO_HASH_INFO=y
CONFIG_CRYPTO_HW=y
CONFIG_CRYPTO_DEV_PADLOCK=m
CONFIG_CRYPTO_DEV_PADLOCK_AES=m
CONFIG_CRYPTO_DEV_PADLOCK_SHA=m
# CONFIG_CRYPTO_DEV_ATMEL_ECC is not set
# CONFIG_CRYPTO_DEV_ATMEL_SHA204A is not set
CONFIG_CRYPTO_DEV_CCP=y
CONFIG_CRYPTO_DEV_CCP_DD=y
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
CONFIG_RATIONAL=y
CONFIG_GENERIC_PCI_IOMAP=y
CONFIG_GENERIC_IOMAP=y
CONFIG_ARCH_USE_CMPXCHG_LOCKREF=y
CONFIG_ARCH_HAS_FAST_MULTIPLIER=y
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
CONFIG_ZSTD_DECOMPRESS=m
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
CONFIG_NEED_SG_DMA_LENGTH=y
CONFIG_NEED_DMA_MAP_STATE=y
CONFIG_ARCH_DMA_ADDR_T_64BIT=y
CONFIG_ARCH_HAS_FORCE_DMA_UNENCRYPTED=y
CONFIG_DMA_VIRT_OPS=y
CONFIG_SWIOTLB=y
CONFIG_DMA_CMA=y

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
CONFIG_FONT_SUPPORT=y
# CONFIG_FONTS is not set
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y
CONFIG_SG_POOL=y
CONFIG_ARCH_HAS_PMEM_API=y
CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE=y
CONFIG_ARCH_HAS_UACCESS_MCSAFE=y
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
# end of printk and dmesg options

#
# Compile-time checks and compiler options
#
CONFIG_DEBUG_INFO=y
CONFIG_DEBUG_INFO_REDUCED=y
# CONFIG_DEBUG_INFO_SPLIT is not set
CONFIG_DEBUG_INFO_DWARF4=y
# CONFIG_DEBUG_INFO_BTF is not set
# CONFIG_GDB_SCRIPTS is not set
CONFIG_ENABLE_MUST_CHECK=y
CONFIG_FRAME_WARN=2048
CONFIG_STRIP_ASM_SYMS=y
# CONFIG_READABLE_ASM is not set
CONFIG_DEBUG_FS=y
# CONFIG_HEADERS_INSTALL is not set
CONFIG_OPTIMIZE_INLINING=y
CONFIG_DEBUG_SECTION_MISMATCH=y
CONFIG_SECTION_MISMATCH_WARN_ONLY=y
CONFIG_STACK_VALIDATION=y
# CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
# end of Compile-time checks and compiler options

CONFIG_MAGIC_SYSRQ=y
CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x1
CONFIG_MAGIC_SYSRQ_SERIAL=y
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
# CONFIG_DEBUG_OBJECTS is not set
# CONFIG_SLUB_DEBUG_ON is not set
# CONFIG_SLUB_STATS is not set
CONFIG_HAVE_DEBUG_KMEMLEAK=y
# CONFIG_DEBUG_KMEMLEAK is not set
# CONFIG_DEBUG_STACK_USAGE is not set
# CONFIG_DEBUG_VM is not set
CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
# CONFIG_DEBUG_VIRTUAL is not set
CONFIG_DEBUG_MEMORY_INIT=y
# CONFIG_DEBUG_PER_CPU_MAPS is not set
CONFIG_HAVE_ARCH_KASAN=y
CONFIG_CC_HAS_KASAN_GENERIC=y
# CONFIG_KASAN is not set
CONFIG_KASAN_STACK=1
# end of Memory Debugging

CONFIG_ARCH_HAS_KCOV=y
CONFIG_CC_HAS_SANCOV_TRACE_PC=y
# CONFIG_KCOV is not set
CONFIG_DEBUG_SHIRQ=y

#
# Debug Lockups and Hangs
#
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
# end of Debug Lockups and Hangs

CONFIG_PANIC_ON_OOPS=y
CONFIG_PANIC_ON_OOPS_VALUE=1
CONFIG_PANIC_TIMEOUT=0
CONFIG_SCHED_DEBUG=y
CONFIG_SCHED_INFO=y
CONFIG_SCHEDSTATS=y
# CONFIG_SCHED_STACK_END_CHECK is not set
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
# end of Lock Debugging (spinlocks, mutexes, etc...)

CONFIG_STACKTRACE=y
# CONFIG_WARN_ALL_UNSEEDED_RANDOM is not set
# CONFIG_DEBUG_KOBJECT is not set
CONFIG_DEBUG_BUGVERBOSE=y
CONFIG_DEBUG_LIST=y
# CONFIG_DEBUG_PLIST is not set
# CONFIG_DEBUG_SG is not set
# CONFIG_DEBUG_NOTIFIERS is not set
# CONFIG_DEBUG_CREDENTIALS is not set

#
# RCU Debugging
#
CONFIG_TORTURE_TEST=m
CONFIG_RCU_PERF_TEST=m
CONFIG_RCU_TORTURE_TEST=m
CONFIG_RCU_CPU_STALL_TIMEOUT=60
# CONFIG_RCU_TRACE is not set
# CONFIG_RCU_EQS_DEBUG is not set
# end of RCU Debugging

# CONFIG_DEBUG_WQ_FORCE_RR_CPU is not set
# CONFIG_DEBUG_BLOCK_EXT_DEVT is not set
# CONFIG_CPU_HOTPLUG_STATE_CONTROL is not set
# CONFIG_NOTIFIER_ERROR_INJECTION is not set
CONFIG_FUNCTION_ERROR_INJECTION=y
CONFIG_FAULT_INJECTION=y
# CONFIG_FAILSLAB is not set
# CONFIG_FAIL_PAGE_ALLOC is not set
CONFIG_FAIL_MAKE_REQUEST=y
# CONFIG_FAIL_IO_TIMEOUT is not set
# CONFIG_FAIL_FUTEX is not set
CONFIG_FAULT_INJECTION_DEBUG_FS=y
# CONFIG_FAIL_FUNCTION is not set
# CONFIG_FAIL_MMC_REQUEST is not set
CONFIG_LATENCYTOP=y
CONFIG_USER_STACKTRACE_SUPPORT=y
CONFIG_NOP_TRACER=y
CONFIG_HAVE_FUNCTION_TRACER=y
CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
CONFIG_HAVE_DYNAMIC_FTRACE=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=y
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
CONFIG_FUNCTION_TRACER=y
CONFIG_FUNCTION_GRAPH_TRACER=y
# CONFIG_PREEMPTIRQ_EVENTS is not set
# CONFIG_IRQSOFF_TRACER is not set
CONFIG_SCHED_TRACER=y
CONFIG_HWLAT_TRACER=y
CONFIG_FTRACE_SYSCALLS=y
CONFIG_TRACER_SNAPSHOT=y
# CONFIG_TRACER_SNAPSHOT_PER_CPU_SWAP is not set
CONFIG_BRANCH_PROFILE_NONE=y
# CONFIG_PROFILE_ANNOTATED_BRANCHES is not set
CONFIG_STACK_TRACER=y
CONFIG_BLK_DEV_IO_TRACE=y
CONFIG_KPROBE_EVENTS=y
# CONFIG_KPROBE_EVENTS_ON_NOTRACE is not set
CONFIG_UPROBE_EVENTS=y
CONFIG_BPF_EVENTS=y
CONFIG_DYNAMIC_EVENTS=y
CONFIG_PROBE_EVENTS=y
CONFIG_DYNAMIC_FTRACE=y
CONFIG_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_FUNCTION_PROFILER=y
# CONFIG_BPF_KPROBE_OVERRIDE is not set
CONFIG_FTRACE_MCOUNT_RECORD=y
# CONFIG_FTRACE_STARTUP_TEST is not set
# CONFIG_MMIOTRACE is not set
CONFIG_TRACING_MAP=y
CONFIG_HIST_TRIGGERS=y
# CONFIG_TRACEPOINT_BENCHMARK is not set
CONFIG_RING_BUFFER_BENCHMARK=m
# CONFIG_RING_BUFFER_STARTUP_TEST is not set
# CONFIG_PREEMPTIRQ_DELAY_TEST is not set
# CONFIG_TRACE_EVAL_MAP_FILE is not set
CONFIG_PROVIDE_OHCI1394_DMA_INIT=y
CONFIG_RUNTIME_TESTING_MENU=y
# CONFIG_LKDTM is not set
# CONFIG_TEST_LIST_SORT is not set
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
# CONFIG_TEST_BITFIELD is not set
# CONFIG_TEST_UUID is not set
# CONFIG_TEST_XARRAY is not set
# CONFIG_TEST_OVERFLOW is not set
# CONFIG_TEST_RHASHTABLE is not set
# CONFIG_TEST_HASH is not set
# CONFIG_TEST_IDA is not set
# CONFIG_TEST_LKM is not set
# CONFIG_TEST_VMALLOC is not set
# CONFIG_TEST_USER_COPY is not set
CONFIG_TEST_BPF=m
# CONFIG_TEST_BLACKHOLE_DEV is not set
# CONFIG_FIND_BIT_BENCHMARK is not set
# CONFIG_TEST_FIRMWARE is not set
# CONFIG_TEST_SYSCTL is not set
# CONFIG_TEST_UDELAY is not set
# CONFIG_TEST_STATIC_KEYS is not set
# CONFIG_TEST_KMOD is not set
# CONFIG_TEST_MEMCAT_P is not set
# CONFIG_TEST_LIVEPATCH is not set
# CONFIG_TEST_STACKINIT is not set
# CONFIG_TEST_MEMINIT is not set
# CONFIG_MEMTEST is not set
CONFIG_BUG_ON_DATA_CORRUPTION=y
# CONFIG_SAMPLES is not set
CONFIG_HAVE_ARCH_KGDB=y
# CONFIG_KGDB is not set
CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
# CONFIG_UBSAN is not set
CONFIG_UBSAN_ALIGNMENT=y
CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y
CONFIG_STRICT_DEVMEM=y
# CONFIG_IO_STRICT_DEVMEM is not set
CONFIG_TRACE_IRQFLAGS_SUPPORT=y
CONFIG_EARLY_PRINTK_USB=y
CONFIG_X86_VERBOSE_BOOTUP=y
CONFIG_EARLY_PRINTK=y
CONFIG_EARLY_PRINTK_DBGP=y
CONFIG_EARLY_PRINTK_USB_XDBC=y
# CONFIG_X86_PTDUMP is not set
# CONFIG_EFI_PGT_DUMP is not set
# CONFIG_DEBUG_WX is not set
CONFIG_DOUBLEFAULT=y
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
# end of Kernel hacking

--rW45g2D1DgwV0HVw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=job-script

#!/bin/sh

export_top_env()
{
	export suite='netperf'
	export testcase='netperf'
	export category='benchmark'
	export disable_latency_stats=1
	export set_nic_irq_affinity=1
	export ip='ipv4'
	export runtime=900
	export nr_threads=96
	export cluster='cs-localhost'
	export job_origin='/lkp-src/allot/cyclic:p1:linux-devel:devel-hourly/lkp-csl-2ap3/netperf-small-threads.yaml'
	export queue_cmdline_keys='branch
commit
queue_at_least_once'
	export queue='validate'
	export testbox='lkp-csl-2ap3'
	export tbox_group='lkp-csl-2ap3'
	export kconfig='x86_64-rhel-8.3'
	export submit_id='5f455caf10fff713a00173da'
	export job_file='/lkp/jobs/scheduled/lkp-csl-2ap3/netperf-cs-localhost-performance-ipv4-50%-900s-TCP_STREAM-ucode=0x5002f01-monitor=e907e467-debian-10.4-x86_64-20200603.cgz-fcf05-20200826-5024-1ralzfq-2.yaml'
	export id='f8bde235c6b6409d1ccb4216b62154b067daf37b'
	export queuer_version='/lkp-src'
	export model='Cascade Lake'
	export nr_node=4
	export nr_cpu=192
	export memory='192G'
	export ssd_partitions=
	export rootfs_partition='LABEL=LKP-ROOTFS'
	export kernel_cmdline_hw='acpi_rsdp=0x67f44014'
	export brand='Intel(R) Xeon(R) Platinum 9242 CPU @ 2.30GHz'
	export commit='fcf0553db6f4c79387864f6e4ab4a891601f395e'
	export need_kconfig_hw='CONFIG_IGB=y
CONFIG_BLK_DEV_NVME'
	export ucode='0x5002f01'
	export enqueue_time='2020-08-26 02:47:11 +0800'
	export _id='5f455caf10fff713a00173da'
	export _rt='/result/netperf/cs-localhost-performance-ipv4-50%-900s-TCP_STREAM-ucode=0x5002f01-monitor=e907e467/lkp-csl-2ap3/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/fcf0553db6f4c79387864f6e4ab4a891601f395e'
	export user='lkp'
	export compiler='gcc-9'
	export head_commit='fdde3c8b901df4c7d62fcd4cdd9a66114758889a'
	export base_commit='bfdd5aaa54b0a44d9df550fe4c9db7e1470a11b8'
	export branch='linus/master'
	export rootfs='debian-10.4-x86_64-20200603.cgz'
	export monitor_sha='e907e467'
	export result_root='/result/netperf/cs-localhost-performance-ipv4-50%-900s-TCP_STREAM-ucode=0x5002f01-monitor=e907e467/lkp-csl-2ap3/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/fcf0553db6f4c79387864f6e4ab4a891601f395e/3'
	export scheduler_version='/lkp/lkp/.src-20200825-094435'
	export LKP_SERVER='inn'
	export arch='x86_64'
	export max_uptime=3300
	export initrd='/osimage/debian/debian-10.4-x86_64-20200603.cgz'
	export bootloader_append='root=/dev/ram0
user=lkp
job=/lkp/jobs/scheduled/lkp-csl-2ap3/netperf-cs-localhost-performance-ipv4-50%-900s-TCP_STREAM-ucode=0x5002f01-monitor=e907e467-debian-10.4-x86_64-20200603.cgz-fcf05-20200826-5024-1ralzfq-2.yaml
ARCH=x86_64
kconfig=x86_64-rhel-8.3
branch=linus/master
commit=fcf0553db6f4c79387864f6e4ab4a891601f395e
BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3/gcc-9/fcf0553db6f4c79387864f6e4ab4a891601f395e/vmlinuz-5.4.0-rc1-00009-gfcf0553db6f4c
acpi_rsdp=0x67f44014
max_uptime=3300
RESULT_ROOT=/result/netperf/cs-localhost-performance-ipv4-50%-900s-TCP_STREAM-ucode=0x5002f01-monitor=e907e467/lkp-csl-2ap3/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/fcf0553db6f4c79387864f6e4ab4a891601f395e/3
LKP_SERVER=inn
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
	export modules_initrd='/pkg/linux/x86_64-rhel-8.3/gcc-9/fcf0553db6f4c79387864f6e4ab4a891601f395e/modules.cgz'
	export bm_initrd='/osimage/deps/debian-10.4-x86_64-20200603.cgz/run-ipconfig_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/lkp_20200709.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/rsync-rootfs_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/netperf_20200610.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/netperf-x86_64-2.7-0_20200610.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/mpstat_20200714.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/perf_20200723.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/perf-x86_64-d15be546031c-1_20200723.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/sar-x86_64-34c92ae-1_20200702.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/hw_20200715.cgz'
	export ucode_initrd='/osimage/ucode/intel-ucode-20200610.cgz'
	export lkp_initrd='/osimage/user/lkp/lkp-x86_64.cgz'
	export site='inn'
	export LKP_CGI_PORT=80
	export LKP_CIFS_PORT=139
	export last_kernel='5.9.0-rc2-intel-next-01035-g61f74c3f355f7'
	export repeat_to=4
	export schedule_notify_address=
	export queue_at_least_once=1
	export kernel='/pkg/linux/x86_64-rhel-8.3/gcc-9/fcf0553db6f4c79387864f6e4ab4a891601f395e/vmlinuz-5.4.0-rc1-00009-gfcf0553db6f4c'
	export dequeue_time='2020-08-26 03:12:16 +0800'
	export node_roles='server client'
	export job_initrd='/lkp/jobs/scheduled/lkp-csl-2ap3/netperf-cs-localhost-performance-ipv4-50%-900s-TCP_STREAM-ucode=0x5002f01-monitor=e907e467-debian-10.4-x86_64-20200603.cgz-fcf05-20200826-5024-1ralzfq-2.cgz'

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

	run_monitor $LKP_SRC/monitors/wrapper kmsg
	run_monitor $LKP_SRC/monitors/no-stdout/wrapper boot-time
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
	run_monitor $LKP_SRC/monitors/no-stdout/wrapper perf-profile
	run_monitor $LKP_SRC/monitors/wrapper oom-killer
	run_monitor $LKP_SRC/monitors/plain/watchdog

	if role server
	then
		start_daemon $LKP_SRC/daemon/netserver
	fi

	if role client
	then
		run_test test='TCP_STREAM' $LKP_SRC/tests/wrapper netperf
	fi
}

extract_stats()
{
	export stats_part_begin=
	export stats_part_end=

	$LKP_SRC/stats/wrapper netperf
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper boot-time
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
	$LKP_SRC/stats/wrapper perf-profile

	$LKP_SRC/stats/wrapper time netperf.time
	$LKP_SRC/stats/wrapper dmesg
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper last_state
	$LKP_SRC/stats/wrapper stderr
	$LKP_SRC/stats/wrapper time
}

"$@"

--rW45g2D1DgwV0HVw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="job.yaml"

---

#! jobs/netperf-small-threads.yaml
suite: netperf
testcase: netperf
category: benchmark

# upto 90% CPU cycles may be used by latency stats
disable_latency_stats: 1
set_nic_irq_affinity: 1
ip: ipv4
runtime: 900s
nr_threads: 50%
cluster: cs-localhost
if role server:
  netserver: 
if role client:
  netperf:
    test: TCP_STREAM
job_origin: "/lkp-src/allot/cyclic:p1:linux-devel:devel-hourly/lkp-csl-2ap3/netperf-small-threads.yaml"

#! queue options
queue_cmdline_keys:
- branch
- commit
- queue_at_least_once
queue: bisect
testbox: lkp-csl-2ap3
tbox_group: lkp-csl-2ap3
kconfig: x86_64-rhel-8.3
submit_id: 5f45284510fff71168c37886
job_file: "/lkp/jobs/scheduled/lkp-csl-2ap3/netperf-cs-localhost-performance-ipv4-50%-900s-TCP_STREAM-ucode=0x5002f01-monitor=e907e467-debian-10.4-x86_64-20200603.cgz-fcf05-20200825-4456-vzbhuw-1.yaml"
id: 889314a173afdb5036c6e43804b702b0a6399915
queuer_version: "/lkp-src"

#! hosts/lkp-csl-2ap3
model: Cascade Lake
nr_node: 4
nr_cpu: 192
memory: 192G
ssd_partitions: 
rootfs_partition: LABEL=LKP-ROOTFS
kernel_cmdline_hw: acpi_rsdp=0x67f44014
brand: Intel(R) Xeon(R) Platinum 9242 CPU @ 2.30GHz

#! include/category/benchmark
kmsg: 
boot-time: 
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
perf-profile: 

#! include/category/ALL
cpufreq_governor: performance

#! include/queue/cyclic
commit: fcf0553db6f4c79387864f6e4ab4a891601f395e

#! include/testbox/lkp-csl-2ap3
need_kconfig_hw:
- CONFIG_IGB=y
- CONFIG_BLK_DEV_NVME
ucode: '0x5002f01'
enqueue_time: 2020-08-25 23:03:34.036588255 +08:00
_id: 5f45284c10fff71168c37887
_rt: "/result/netperf/cs-localhost-performance-ipv4-50%-900s-TCP_STREAM-ucode=0x5002f01-monitor=e907e467/lkp-csl-2ap3/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/fcf0553db6f4c79387864f6e4ab4a891601f395e"

#! schedule options
user: lkp
compiler: gcc-9
head_commit: fdde3c8b901df4c7d62fcd4cdd9a66114758889a
base_commit: bfdd5aaa54b0a44d9df550fe4c9db7e1470a11b8
branch: linus/master
rootfs: debian-10.4-x86_64-20200603.cgz
monitor_sha: e907e467
result_root: "/result/netperf/cs-localhost-performance-ipv4-50%-900s-TCP_STREAM-ucode=0x5002f01-monitor=e907e467/lkp-csl-2ap3/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/fcf0553db6f4c79387864f6e4ab4a891601f395e/0"
scheduler_version: "/lkp/lkp/.src-20200825-094435"
LKP_SERVER: inn
arch: x86_64
max_uptime: 3300
initrd: "/osimage/debian/debian-10.4-x86_64-20200603.cgz"
bootloader_append:
- root=/dev/ram0
- user=lkp
- job=/lkp/jobs/scheduled/lkp-csl-2ap3/netperf-cs-localhost-performance-ipv4-50%-900s-TCP_STREAM-ucode=0x5002f01-monitor=e907e467-debian-10.4-x86_64-20200603.cgz-fcf05-20200825-4456-vzbhuw-1.yaml
- ARCH=x86_64
- kconfig=x86_64-rhel-8.3
- branch=linus/master
- commit=fcf0553db6f4c79387864f6e4ab4a891601f395e
- BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3/gcc-9/fcf0553db6f4c79387864f6e4ab4a891601f395e/vmlinuz-5.4.0-rc1-00009-gfcf0553db6f4c
- acpi_rsdp=0x67f44014
- max_uptime=3300
- RESULT_ROOT=/result/netperf/cs-localhost-performance-ipv4-50%-900s-TCP_STREAM-ucode=0x5002f01-monitor=e907e467/lkp-csl-2ap3/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/fcf0553db6f4c79387864f6e4ab4a891601f395e/0
- LKP_SERVER=inn
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
modules_initrd: "/pkg/linux/x86_64-rhel-8.3/gcc-9/fcf0553db6f4c79387864f6e4ab4a891601f395e/modules.cgz"
bm_initrd: "/osimage/deps/debian-10.4-x86_64-20200603.cgz/run-ipconfig_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/lkp_20200709.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/rsync-rootfs_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/netperf_20200610.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/netperf-x86_64-2.7-0_20200610.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/mpstat_20200714.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/perf_20200723.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/perf-x86_64-d15be546031c-1_20200723.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/sar-x86_64-34c92ae-1_20200702.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/hw_20200715.cgz"
ucode_initrd: "/osimage/ucode/intel-ucode-20200610.cgz"
lkp_initrd: "/osimage/user/lkp/lkp-x86_64.cgz"
site: inn

#! /lkp/lkp/.src-20200819-145558/include/site/inn
LKP_CGI_PORT: 80
LKP_CIFS_PORT: 139
oom-killer: 
watchdog: 

#! runtime status
last_kernel: 5.7.0-14726-g08bf1a27c4c35

#! /lkp/lkp/.src-20200824-114328/include/site/inn
repeat_to: 2
schedule_notify_address: 

#! user overrides
queue_at_least_once: 0
kernel: "/pkg/linux/x86_64-rhel-8.3/gcc-9/fcf0553db6f4c79387864f6e4ab4a891601f395e/vmlinuz-5.4.0-rc1-00009-gfcf0553db6f4c"
dequeue_time: 2020-08-25 23:08:10.692959507 +08:00

#! /lkp/lkp/.src-20200825-094435/include/site/inn
job_state: finished
loadavg: 111.28 143.88 99.74 1/1297 30987
start_time: '1598368153'
end_time: '1598369054'
version: "/lkp/lkp/.src-20200825-094529:6d33ee60:377b1af1c"

--rW45g2D1DgwV0HVw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=reproduce


for cpu_dir in /sys/devices/system/cpu/cpu[0-9]*
do
	online_file="$cpu_dir"/online
	[ -f "$online_file" ] && [ "$(cat "$online_file")" -eq 0 ] && continue

	file="$cpu_dir"/cpufreq/scaling_governor
	[ -f "$file" ] && echo "performance" > "$file"
done

netserver -4 -D
netperf -4 -H 127.0.0.1 -t TCP_STREAM -c -C -l 900  &
netperf -4 -H 127.0.0.1 -t TCP_STREAM -c -C -l 900  &
netperf -4 -H 127.0.0.1 -t TCP_STREAM -c -C -l 900  &
netperf -4 -H 127.0.0.1 -t TCP_STREAM -c -C -l 900  &
netperf -4 -H 127.0.0.1 -t TCP_STREAM -c -C -l 900  &
netperf -4 -H 127.0.0.1 -t TCP_STREAM -c -C -l 900  &
netperf -4 -H 127.0.0.1 -t TCP_STREAM -c -C -l 900  &
netperf -4 -H 127.0.0.1 -t TCP_STREAM -c -C -l 900  &
netperf -4 -H 127.0.0.1 -t TCP_STREAM -c -C -l 900  &
netperf -4 -H 127.0.0.1 -t TCP_STREAM -c -C -l 900  &
netperf -4 -H 127.0.0.1 -t TCP_STREAM -c -C -l 900  &
netperf -4 -H 127.0.0.1 -t TCP_STREAM -c -C -l 900  &
netperf -4 -H 127.0.0.1 -t TCP_STREAM -c -C -l 900  &
netperf -4 -H 127.0.0.1 -t TCP_STREAM -c -C -l 900  &
netperf -4 -H 127.0.0.1 -t TCP_STREAM -c -C -l 900  &
netperf -4 -H 127.0.0.1 -t TCP_STREAM -c -C -l 900  &
netperf -4 -H 127.0.0.1 -t TCP_STREAM -c -C -l 900  &
netperf -4 -H 127.0.0.1 -t TCP_STREAM -c -C -l 900  &
netperf -4 -H 127.0.0.1 -t TCP_STREAM -c -C -l 900  &
netperf -4 -H 127.0.0.1 -t TCP_STREAM -c -C -l 900  &
netperf -4 -H 127.0.0.1 -t TCP_STREAM -c -C -l 900  &
netperf -4 -H 127.0.0.1 -t TCP_STREAM -c -C -l 900  &
netperf -4 -H 127.0.0.1 -t TCP_STREAM -c -C -l 900  &
netperf -4 -H 127.0.0.1 -t TCP_STREAM -c -C -l 900  &
netperf -4 -H 127.0.0.1 -t TCP_STREAM -c -C -l 900  &
netperf -4 -H 127.0.0.1 -t TCP_STREAM -c -C -l 900  &
netperf -4 -H 127.0.0.1 -t TCP_STREAM -c -C -l 900  &
netperf -4 -H 127.0.0.1 -t TCP_STREAM -c -C -l 900  &
netperf -4 -H 127.0.0.1 -t TCP_STREAM -c -C -l 900  &
netperf -4 -H 127.0.0.1 -t TCP_STREAM -c -C -l 900  &
netperf -4 -H 127.0.0.1 -t TCP_STREAM -c -C -l 900  &
netperf -4 -H 127.0.0.1 -t TCP_STREAM -c -C -l 900  &
netperf -4 -H 127.0.0.1 -t TCP_STREAM -c -C -l 900  &
netperf -4 -H 127.0.0.1 -t TCP_STREAM -c -C -l 900  &
netperf -4 -H 127.0.0.1 -t TCP_STREAM -c -C -l 900  &
netperf -4 -H 127.0.0.1 -t TCP_STREAM -c -C -l 900  &
netperf -4 -H 127.0.0.1 -t TCP_STREAM -c -C -l 900  &
netperf -4 -H 127.0.0.1 -t TCP_STREAM -c -C -l 900  &
netperf -4 -H 127.0.0.1 -t TCP_STREAM -c -C -l 900  &
netperf -4 -H 127.0.0.1 -t TCP_STREAM -c -C -l 900  &
netperf -4 -H 127.0.0.1 -t TCP_STREAM -c -C -l 900  &
netperf -4 -H 127.0.0.1 -t TCP_STREAM -c -C -l 900  &
netperf -4 -H 127.0.0.1 -t TCP_STREAM -c -C -l 900  &
netperf -4 -H 127.0.0.1 -t TCP_STREAM -c -C -l 900  &
netperf -4 -H 127.0.0.1 -t TCP_STREAM -c -C -l 900  &
netperf -4 -H 127.0.0.1 -t TCP_STREAM -c -C -l 900  &
netperf -4 -H 127.0.0.1 -t TCP_STREAM -c -C -l 900  &
netperf -4 -H 127.0.0.1 -t TCP_STREAM -c -C -l 900  &
netperf -4 -H 127.0.0.1 -t TCP_STREAM -c -C -l 900  &
netperf -4 -H 127.0.0.1 -t TCP_STREAM -c -C -l 900  &
netperf -4 -H 127.0.0.1 -t TCP_STREAM -c -C -l 900  &
netperf -4 -H 127.0.0.1 -t TCP_STREAM -c -C -l 900  &
netperf -4 -H 127.0.0.1 -t TCP_STREAM -c -C -l 900  &
netperf -4 -H 127.0.0.1 -t TCP_STREAM -c -C -l 900  &
netperf -4 -H 127.0.0.1 -t TCP_STREAM -c -C -l 900  &
netperf -4 -H 127.0.0.1 -t TCP_STREAM -c -C -l 900  &
netperf -4 -H 127.0.0.1 -t TCP_STREAM -c -C -l 900  &
netperf -4 -H 127.0.0.1 -t TCP_STREAM -c -C -l 900  &
netperf -4 -H 127.0.0.1 -t TCP_STREAM -c -C -l 900  &
netperf -4 -H 127.0.0.1 -t TCP_STREAM -c -C -l 900  &
netperf -4 -H 127.0.0.1 -t TCP_STREAM -c -C -l 900  &
netperf -4 -H 127.0.0.1 -t TCP_STREAM -c -C -l 900  &
netperf -4 -H 127.0.0.1 -t TCP_STREAM -c -C -l 900  &
netperf -4 -H 127.0.0.1 -t TCP_STREAM -c -C -l 900  &
netperf -4 -H 127.0.0.1 -t TCP_STREAM -c -C -l 900  &
netperf -4 -H 127.0.0.1 -t TCP_STREAM -c -C -l 900  &
netperf -4 -H 127.0.0.1 -t TCP_STREAM -c -C -l 900  &
netperf -4 -H 127.0.0.1 -t TCP_STREAM -c -C -l 900  &
netperf -4 -H 127.0.0.1 -t TCP_STREAM -c -C -l 900  &
netperf -4 -H 127.0.0.1 -t TCP_STREAM -c -C -l 900  &
netperf -4 -H 127.0.0.1 -t TCP_STREAM -c -C -l 900  &
netperf -4 -H 127.0.0.1 -t TCP_STREAM -c -C -l 900  &
netperf -4 -H 127.0.0.1 -t TCP_STREAM -c -C -l 900  &
netperf -4 -H 127.0.0.1 -t TCP_STREAM -c -C -l 900  &
netperf -4 -H 127.0.0.1 -t TCP_STREAM -c -C -l 900  &
netperf -4 -H 127.0.0.1 -t TCP_STREAM -c -C -l 900  &
netperf -4 -H 127.0.0.1 -t TCP_STREAM -c -C -l 900  &
netperf -4 -H 127.0.0.1 -t TCP_STREAM -c -C -l 900  &
netperf -4 -H 127.0.0.1 -t TCP_STREAM -c -C -l 900  &
netperf -4 -H 127.0.0.1 -t TCP_STREAM -c -C -l 900  &
netperf -4 -H 127.0.0.1 -t TCP_STREAM -c -C -l 900  &
netperf -4 -H 127.0.0.1 -t TCP_STREAM -c -C -l 900  &
netperf -4 -H 127.0.0.1 -t TCP_STREAM -c -C -l 900  &
netperf -4 -H 127.0.0.1 -t TCP_STREAM -c -C -l 900  &
netperf -4 -H 127.0.0.1 -t TCP_STREAM -c -C -l 900  &
netperf -4 -H 127.0.0.1 -t TCP_STREAM -c -C -l 900  &
netperf -4 -H 127.0.0.1 -t TCP_STREAM -c -C -l 900  &
netperf -4 -H 127.0.0.1 -t TCP_STREAM -c -C -l 900  &
netperf -4 -H 127.0.0.1 -t TCP_STREAM -c -C -l 900  &
netperf -4 -H 127.0.0.1 -t TCP_STREAM -c -C -l 900  &
netperf -4 -H 127.0.0.1 -t TCP_STREAM -c -C -l 900  &
netperf -4 -H 127.0.0.1 -t TCP_STREAM -c -C -l 900  &
netperf -4 -H 127.0.0.1 -t TCP_STREAM -c -C -l 900  &
netperf -4 -H 127.0.0.1 -t TCP_STREAM -c -C -l 900  &
netperf -4 -H 127.0.0.1 -t TCP_STREAM -c -C -l 900  &
netperf -4 -H 127.0.0.1 -t TCP_STREAM -c -C -l 900  &
wait

--rW45g2D1DgwV0HVw--
