Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B729226D0B1
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 03:34:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726315AbgIQBd6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 21:33:58 -0400
Received: from mga03.intel.com ([134.134.136.65]:5221 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726011AbgIQBdt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 21:33:49 -0400
X-Greylist: delayed 359 seconds by postgrey-1.27 at vger.kernel.org; Wed, 16 Sep 2020 21:31:22 EDT
IronPort-SDR: tqjJIeefJWm6rsdvEJW8tAFKnhdNcrsC9vY8iZY1ka9L4jPcHawMRvxcCtuDExVVWFPpltppQq
 1gSRqhOU60YQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9746"; a="159652841"
X-IronPort-AV: E=Sophos;i="5.76,434,1592895600"; 
   d="yaml'?scan'208";a="159652841"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2020 18:30:17 -0700
IronPort-SDR: gEN4tSpgpmSHWmN8SyqFxf/gGMzR+9Ivm/j5T1Y5ARhoSljk63sKawOyAV2qyLhXqYtwJcWNbE
 M87VodXzadzw==
X-IronPort-AV: E=Sophos;i="5.76,434,1592895600"; 
   d="yaml'?scan'208";a="483533275"
Received: from shao2-debian.sh.intel.com (HELO localhost) ([10.239.13.3])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2020 18:30:08 -0700
Date:   Thu, 17 Sep 2020 09:29:23 +0800
From:   kernel test robot <rong.a.chen@intel.com>
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
Subject: [locking/qspinlock] 5df52a74ab: reaim.jobs_per_min 45.7% improvement
Message-ID: <20200917012923.GG28738@shao2-debian>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="3607uds81ZQvwCD0"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200915180535.2975060-4-alex.kogan@oracle.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3607uds81ZQvwCD0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Greeting,

FYI, we noticed a 45.7% improvement of reaim.jobs_per_min due to commit:


commit: 5df52a74ab00917ec2522ab3ec2e91ce33fbf22a ("[PATCH v11 3/5] locking/qspinlock: Introduce CNA into the slow path of qspinlock")
url: https://github.com/0day-ci/linux/commits/Alex-Kogan/Add-NUMA-awareness-to-qspinlock/20200916-023855
base: https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git 1909760f5fc3f123e47b4e24e0ccdc0fc8f3f106

in testcase: reaim
on test machine: 96 threads Intel(R) Xeon(R) Gold 6252 CPU @ 2.10GHz with 192G memory
with following parameters:

	runtime: 300s
	nr_task: 100%
	test: fserver
	cpufreq_governor: performance
	ucode: 0x5002f01

test-description: REAIM is an updated and improved version of AIM 7 benchmark.
test-url: https://sourceforge.net/projects/re-aim-7/





Details are as below:
-------------------------------------------------------------------------------------------------->


To reproduce:

        git clone https://github.com/intel/lkp-tests.git
        cd lkp-tests
        bin/lkp install job.yaml  # job file is attached in this email
        bin/lkp run     job.yaml

=========================================================================================
compiler/cpufreq_governor/kconfig/nr_task/rootfs/runtime/tbox_group/test/testcase/ucode:
  gcc-9/performance/x86_64-rhel-8.3/100%/debian-10.4-x86_64-20200603.cgz/300s/lkp-csl-2sp5/fserver/reaim/0x5002f01

commit: 
  d0615c8da7 ("locking/qspinlock: Refactor the qspinlock slow path")
  5df52a74ab ("locking/qspinlock: Introduce CNA into the slow path of qspinlock")

d0615c8da74dd1dc 5df52a74ab00917ec2522ab3ec2 
---------------- --------------------------- 
       fail:runs  %reproduction    fail:runs
           |             |             |    
          0:4            8%           0:4     perf-profile.children.cycles-pp.error_entry
         %stddev     %change         %stddev
             \          |                \  
     91.05 ±  2%     -56.1%      39.99        reaim.child_systime
     28.81            +3.3%      29.76        reaim.child_utime
    415207           +45.7%     604838        reaim.jobs_per_min
      4325           +45.7%       6300        reaim.jobs_per_min_child
     94.33            -5.5%      89.14        reaim.jti
    429501           +50.1%     644664        reaim.max_jobs_per_min
      1.40           -31.3%       0.96        reaim.parent_time
      5.17          +100.0%      10.34        reaim.std_dev_percent
      0.07           +23.8%       0.08        reaim.std_dev_time
    372486            -6.7%     347381        reaim.time.involuntary_context_switches
     51745 ±  7%    +258.5%     185528        reaim.time.major_page_faults
  84560705           +14.4%   96728177        reaim.time.minor_page_faults
      3497           -33.3%       2332        reaim.time.percent_of_cpu_this_job_got
      8036           -49.7%       4041        reaim.time.system_time
      2543           +18.2%       3006        reaim.time.user_time
   1855222           +27.1%    2357156        reaim.time.voluntary_context_switches
    847200           +14.4%     969600        reaim.workload
      6579           +18.2%       7775        meminfo.PageTables
      1759 ± 15%     +36.2%       2396 ± 10%  numa-meminfo.node0.Active
      1758 ± 15%     +36.2%       2394 ± 10%  numa-meminfo.node0.Active(anon)
   8809518 ±  3%    +268.2%   32435557 ± 13%  cpuidle.C1.time
    179248 ±  2%    +166.5%     477615 ± 20%  cpuidle.C1.usage
    323189 ±  8%    +447.3%    1768876 ± 33%  cpuidle.POLL.time
     67710 ±  2%    +437.6%     364029 ± 38%  cpuidle.POLL.usage
      1617 ±  5%     -10.7%       1444 ±  4%  slabinfo.kmalloc-rcl-512.active_objs
      1617 ±  5%     -10.7%       1444 ±  4%  slabinfo.kmalloc-rcl-512.num_objs
    778.00           +36.1%       1058        slabinfo.names_cache.active_objs
    778.00           +36.2%       1059        slabinfo.names_cache.num_objs
     61.50           +17.9%      72.50        vmstat.cpu.id
      8.00           +25.0%      10.00        vmstat.cpu.us
     36.25           -20.7%      28.75 ±  8%  vmstat.procs.r
     16803           +24.3%      20878        vmstat.system.cs
  30562045           +15.0%   35160790 ±  3%  numa-numastat.node0.local_node
  30588448           +15.0%   35168622 ±  3%  numa-numastat.node0.numa_hit
     26405 ± 30%     -70.3%       7850 ±170%  numa-numastat.node0.other_node
  30667122           +14.3%   35063923 ±  3%  numa-numastat.node1.local_node
  30671972           +14.4%   35087297 ±  3%  numa-numastat.node1.numa_hit
     61.77           +11.0       72.81        mpstat.cpu.all.idle%
      0.02 ± 27%      +0.2        0.21 ±  2%  mpstat.cpu.all.iowait%
      1.34            +0.5        1.82 ± 20%  mpstat.cpu.all.irq%
      0.39 ± 22%      +0.3        0.74 ± 15%  mpstat.cpu.all.soft%
     28.00           -13.7       14.33        mpstat.cpu.all.sys%
      8.49            +1.6       10.10        mpstat.cpu.all.usr%
    436.25 ± 15%     +36.8%     596.75 ±  9%  numa-vmstat.node0.nr_active_anon
    436.25 ± 15%     +36.8%     596.75 ±  9%  numa-vmstat.node0.nr_zone_active_anon
  16036199           +12.9%   18112792 ±  3%  numa-vmstat.node0.numa_hit
  15949972           +13.3%   18074885 ±  3%  numa-vmstat.node0.numa_local
      3770 ± 16%     +20.6%       4545 ± 12%  numa-vmstat.node1.nr_mapped
  15790592           +15.3%   18209998 ±  3%  numa-vmstat.node1.numa_hit
  15696794           +15.1%   18067666 ±  3%  numa-vmstat.node1.numa_local
      1702           +15.8%       1971        proc-vmstat.nr_page_table_pages
     68627            +2.7%      70457        proc-vmstat.nr_slab_unreclaimable
  61208825           +14.8%   70253284        proc-vmstat.numa_hit
  61177558           +14.8%   70222047        proc-vmstat.numa_local
    181604           +12.9%     205093        proc-vmstat.pgactivate
  67358848           +14.4%   77055734        proc-vmstat.pgalloc_normal
  85598468           +14.5%   98050870        proc-vmstat.pgfault
  67307484           +14.4%   77004440        proc-vmstat.pgfree
     20606 ±105%     -99.9%      23.66 ±112%  sched_debug.cfs_rq:/.MIN_vruntime.avg
     52144 ±  8%     -32.2%      35333 ±  8%  sched_debug.cfs_rq:/.exec_clock.avg
     54107 ±  8%     -31.0%      37345 ±  6%  sched_debug.cfs_rq:/.exec_clock.max
     51513 ±  8%     -32.7%      34665 ±  8%  sched_debug.cfs_rq:/.exec_clock.min
      1.52 ± 16%    -100.0%       0.00        sched_debug.cfs_rq:/.load_avg.min
     20606 ±105%     -99.9%      23.66 ±112%  sched_debug.cfs_rq:/.max_vruntime.avg
   4723149 ±  8%     -39.3%    2868680 ±  8%  sched_debug.cfs_rq:/.min_vruntime.avg
   4788797 ±  8%     -38.7%    2937893 ±  8%  sched_debug.cfs_rq:/.min_vruntime.max
   4640255 ±  8%     -39.7%    2799231 ±  9%  sched_debug.cfs_rq:/.min_vruntime.min
      0.38 ± 13%     -83.4%       0.06 ± 21%  sched_debug.cfs_rq:/.nr_running.avg
     51.49 ± 23%     +38.2%      71.18 ± 14%  sched_debug.cfs_rq:/.nr_spread_over.avg
     71.58 ± 20%    +106.7%     147.99 ±  9%  sched_debug.cfs_rq:/.nr_spread_over.max
     33.95 ± 31%     +42.0%      48.21 ± 15%  sched_debug.cfs_rq:/.nr_spread_over.min
      7.77 ± 10%     +92.9%      14.99 ±  8%  sched_debug.cfs_rq:/.nr_spread_over.stddev
    380.26 ± 12%     -80.8%      72.98 ± 13%  sched_debug.cfs_rq:/.runnable_avg.avg
      1019 ± 10%     -32.6%     687.18 ±  3%  sched_debug.cfs_rq:/.runnable_avg.max
    112.78 ± 30%    -100.0%       0.00        sched_debug.cfs_rq:/.runnable_avg.min
    178.28 ± 13%     -30.8%     123.46 ±  6%  sched_debug.cfs_rq:/.runnable_avg.stddev
    375.51 ± 12%     -80.6%      72.92 ± 13%  sched_debug.cfs_rq:/.util_avg.avg
    981.43 ± 11%     -30.0%     687.05 ±  3%  sched_debug.cfs_rq:/.util_avg.max
    108.93 ± 28%    -100.0%       0.00        sched_debug.cfs_rq:/.util_avg.min
    176.90 ± 13%     -30.2%     123.46 ±  6%  sched_debug.cfs_rq:/.util_avg.stddev
    195.49 ± 21%     -96.0%       7.92 ± 20%  sched_debug.cfs_rq:/.util_est_enqueued.avg
    624.00 ± 12%     -69.0%     193.50 ±  7%  sched_debug.cfs_rq:/.util_est_enqueued.max
    131.16 ± 10%     -76.3%      31.03 ±  9%  sched_debug.cfs_rq:/.util_est_enqueued.stddev
    728287 ±  3%     +19.3%     868646        sched_debug.cpu.avg_idle.avg
    132525 ± 37%     -39.3%      80463 ± 23%  sched_debug.cpu.avg_idle.min
     23454 ± 16%     -98.0%     458.25 ±  6%  sched_debug.cpu.curr->pid.avg
     64630 ±  4%     -40.8%      38276 ±  6%  sched_debug.cpu.curr->pid.max
      8848 ± 13%     -55.1%       3975 ±  6%  sched_debug.cpu.curr->pid.stddev
      0.00 ±  3%     -42.4%       0.00 ±  3%  sched_debug.cpu.next_balance.stddev
      0.36 ± 14%     -89.0%       0.04 ±  6%  sched_debug.cpu.nr_running.avg
      1.52 ±  2%     -28.4%       1.09 ±  8%  sched_debug.cpu.nr_running.max
      0.23 ±  7%     -22.4%       0.18 ±  2%  sched_debug.cpu.nr_running.stddev
     22675 ±  8%     +28.8%      29201 ±  8%  sched_debug.cpu.nr_switches.min
     51.03 ± 18%    +180.8%     143.32 ± 12%  sched_debug.cpu.nr_uninterruptible.max
    -37.99          +247.4%    -131.97        sched_debug.cpu.nr_uninterruptible.min
     15.56 ±  6%    +224.0%      50.43 ±  4%  sched_debug.cpu.nr_uninterruptible.stddev
     22023 ±  8%     +30.4%      28725 ±  9%  sched_debug.cpu.sched_count.min
     10166 ±  9%     +30.7%      13282 ±  9%  sched_debug.cpu.sched_goidle.avg
      8656 ±  8%     +38.7%      12009 ±  9%  sched_debug.cpu.sched_goidle.min
      8404 ±  9%     +30.9%      11002 ±  9%  sched_debug.cpu.ttwu_count.avg
      7210 ±  9%     +36.7%       9855 ±  9%  sched_debug.cpu.ttwu_count.min
      7.16          +213.6%      22.44 ± 64%  perf-stat.i.MPKI
  7.47e+09            +2.2%  7.636e+09        perf-stat.i.branch-instructions
      1.13            +1.6        2.70 ± 52%  perf-stat.i.branch-miss-rate%
  63150440           +21.4%   76644167 ±  5%  perf-stat.i.branch-misses
     22.68            -9.8       12.92 ± 39%  perf-stat.i.cache-miss-rate%
  36603035           -35.6%   23563190 ±  4%  perf-stat.i.cache-misses
 1.518e+08           +32.6%  2.013e+08 ± 10%  perf-stat.i.cache-references
     16774           +23.8%      20758        perf-stat.i.context-switches
 1.013e+11           -29.8%  7.113e+10        perf-stat.i.cpu-cycles
      2475           +39.6%       3455        perf-stat.i.cpu-migrations
      0.02 ±  2%      +0.2        0.24 ± 60%  perf-stat.i.dTLB-load-miss-rate%
   1529728 ±  2%     +87.5%    2868746 ± 21%  perf-stat.i.dTLB-load-misses
    742222           +32.9%     986190 ±  8%  perf-stat.i.dTLB-store-misses
 1.981e+09           +13.9%  2.256e+09        perf-stat.i.dTLB-stores
   5778695            +8.2%    6251785 ±  6%  perf-stat.i.iTLB-load-misses
 3.807e+10            +4.9%  3.993e+10        perf-stat.i.instructions
      4905           -19.6%       3946 ±  7%  perf-stat.i.instructions-per-iTLB-miss
      0.40           +11.2%       0.44 ±  5%  perf-stat.i.ipc
    169.87 ±  6%    +256.9%     606.26        perf-stat.i.major-faults
      1.05           -30.1%       0.74        perf-stat.i.metric.GHz
      0.85 ±  5%     +31.9%       1.13 ±  2%  perf-stat.i.metric.K/sec
    164.77            +2.9%     169.61        perf-stat.i.metric.M/sec
    273923           +14.1%     312525        perf-stat.i.minor-faults
     85.23            -7.3       77.88        perf-stat.i.node-load-miss-rate%
   8000980           -35.9%    5131408 ±  2%  perf-stat.i.node-load-misses
   1288912           +11.1%    1432395        perf-stat.i.node-loads
     78.84           -12.5       66.32 ±  5%  perf-stat.i.node-store-miss-rate%
   4499737           -40.8%    2664950        perf-stat.i.node-store-misses
    916780           +30.9%    1200392        perf-stat.i.node-stores
    274093           +14.2%     313131        perf-stat.i.page-faults
      3.99           +26.3%       5.04 ± 10%  perf-stat.overall.MPKI
      0.85            +0.2        1.00 ±  5%  perf-stat.overall.branch-miss-rate%
     24.10           -12.2       11.90 ± 12%  perf-stat.overall.cache-miss-rate%
      2.66           -33.2%       1.77        perf-stat.overall.cpi
      2764 ±  2%      +8.4%       2997 ±  3%  perf-stat.overall.cycles-between-cache-misses
      0.02 ±  2%      +0.0        0.05 ± 21%  perf-stat.overall.dTLB-load-miss-rate%
      0.04            +0.0        0.04 ±  8%  perf-stat.overall.dTLB-store-miss-rate%
      0.38           +49.8%       0.56        perf-stat.overall.ipc
     86.09            -7.9       78.18        perf-stat.overall.node-load-miss-rate%
     83.07           -14.0       69.06        perf-stat.overall.node-store-miss-rate%
  13652177            -8.4%   12500244        perf-stat.overall.path-length
 7.492e+09            +2.3%  7.661e+09        perf-stat.ps.branch-instructions
  63388085           +21.5%   76989977 ±  5%  perf-stat.ps.branch-misses
  36699307           -35.3%   23728211 ±  4%  perf-stat.ps.cache-misses
 1.523e+08           +32.6%  2.018e+08 ± 10%  perf-stat.ps.cache-references
     16842           +24.0%      20893        perf-stat.ps.context-switches
 1.014e+11           -30.0%  7.102e+10        perf-stat.ps.cpu-cycles
      2486           +39.9%       3477        perf-stat.ps.cpu-migrations
   1536862 ±  2%     +86.8%    2871096 ± 21%  perf-stat.ps.dTLB-load-misses
    745080           +32.8%     989404 ±  8%  perf-stat.ps.dTLB-store-misses
 1.988e+09           +14.0%  2.267e+09        perf-stat.ps.dTLB-stores
   5782684            +8.2%    6259566 ±  5%  perf-stat.ps.iTLB-load-misses
 3.816e+10            +4.9%  4.003e+10        perf-stat.ps.instructions
    170.83 ±  7%    +258.5%     612.48        perf-stat.ps.major-faults
    275009           +14.3%     314248        perf-stat.ps.minor-faults
   8024413           -35.5%    5176284 ±  2%  perf-stat.ps.node-load-misses
   1296055           +11.5%    1444510        perf-stat.ps.node-loads
   4513106           -40.4%    2688851        perf-stat.ps.node-store-misses
    919879           +30.9%    1204492        perf-stat.ps.node-stores
    275180           +14.4%     314861        perf-stat.ps.page-faults
 1.157e+13            +4.8%  1.212e+13        perf-stat.total.instructions
     31336 ±  2%     +17.8%      36904 ±  3%  softirqs.CPU0.SCHED
     29353 ±  2%     +23.5%      36240 ±  3%  softirqs.CPU1.SCHED
     43857 ±  3%     +17.2%      51394 ±  5%  softirqs.CPU10.NET_RX
     28679           +21.6%      34866 ±  2%  softirqs.CPU10.SCHED
     44878 ±  4%     +26.2%      56619 ± 16%  softirqs.CPU11.NET_RX
     28839           +24.3%      35853 ±  3%  softirqs.CPU11.SCHED
     43229 ±  4%     +18.9%      51387 ±  6%  softirqs.CPU12.NET_RX
     28677           +22.7%      35178 ±  3%  softirqs.CPU12.SCHED
     45288           +10.5%      50052 ±  2%  softirqs.CPU13.NET_RX
     28682           +21.6%      34879 ±  2%  softirqs.CPU13.SCHED
     42141 ±  3%     +26.9%      53476 ±  4%  softirqs.CPU14.NET_RX
     28729           +22.1%      35080 ±  2%  softirqs.CPU14.SCHED
     44355 ±  3%     +10.8%      49131 ±  5%  softirqs.CPU15.NET_RX
     28634           +22.0%      34933 ±  3%  softirqs.CPU15.SCHED
     44104 ±  5%     +16.3%      51298 ±  6%  softirqs.CPU16.NET_RX
     28485           +22.3%      34825 ±  2%  softirqs.CPU16.SCHED
     28818           +21.2%      34940 ±  3%  softirqs.CPU17.SCHED
     28815           +22.9%      35414 ±  2%  softirqs.CPU18.SCHED
     43178           +20.4%      51986 ±  3%  softirqs.CPU19.NET_RX
     29087 ±  3%     +19.6%      34778 ±  3%  softirqs.CPU19.SCHED
     44717 ±  3%     +14.7%      51297 ±  6%  softirqs.CPU2.NET_RX
     28984           +21.8%      35294 ±  2%  softirqs.CPU2.SCHED
     44356 ±  2%     +15.0%      51025 ±  6%  softirqs.CPU20.NET_RX
     28834           +21.0%      34891 ±  3%  softirqs.CPU20.SCHED
     42907 ±  4%     +20.4%      51662 ±  7%  softirqs.CPU21.NET_RX
     28672           +22.2%      35025 ±  2%  softirqs.CPU21.SCHED
     28683           +21.8%      34945 ±  2%  softirqs.CPU22.SCHED
     29139 ±  2%     +20.3%      35064 ±  3%  softirqs.CPU23.SCHED
     29287 ±  2%     +19.6%      35029 ±  2%  softirqs.CPU24.SCHED
     44726 ±  3%     +17.3%      52482 ±  6%  softirqs.CPU25.NET_RX
     28571           +22.2%      34904 ±  2%  softirqs.CPU25.SCHED
     44972 ±  2%     +10.0%      49481 ±  7%  softirqs.CPU26.NET_RX
     28617           +22.2%      34967 ±  2%  softirqs.CPU26.SCHED
     28721           +22.5%      35183 ±  2%  softirqs.CPU27.SCHED
     45739 ±  2%      +9.9%      50261 ±  6%  softirqs.CPU28.NET_RX
     28797           +22.2%      35189 ±  3%  softirqs.CPU28.SCHED
     45037 ±  4%     +13.5%      51103 ±  7%  softirqs.CPU29.NET_RX
     28942           +21.1%      35049 ±  3%  softirqs.CPU29.SCHED
     43726 ±  5%     +17.9%      51536 ±  6%  softirqs.CPU3.NET_RX
     28660           +22.8%      35208 ±  3%  softirqs.CPU3.SCHED
     43924 ±  4%     +17.9%      51788 ±  6%  softirqs.CPU30.NET_RX
     28605           +22.9%      35160 ±  2%  softirqs.CPU30.SCHED
     44738 ±  2%     +14.0%      51018 ±  8%  softirqs.CPU31.NET_RX
     28525           +23.0%      35080 ±  3%  softirqs.CPU31.SCHED
     44269 ±  3%     +13.8%      50371 ±  6%  softirqs.CPU32.NET_RX
     50617           +11.0%      56186 ±  2%  softirqs.CPU32.RCU
     28729           +21.9%      35015 ±  2%  softirqs.CPU32.SCHED
     28775           +20.9%      34793 ±  2%  softirqs.CPU33.SCHED
     43305 ±  4%     +12.9%      48879 ±  7%  softirqs.CPU34.NET_RX
     28638           +22.2%      34998 ±  2%  softirqs.CPU34.SCHED
     50669 ±  2%     +12.5%      57026 ±  3%  softirqs.CPU35.RCU
     28492           +23.1%      35066 ±  2%  softirqs.CPU35.SCHED
     29276 ±  3%     +19.9%      35096 ±  2%  softirqs.CPU36.SCHED
     28654 ±  2%     +21.7%      34861 ±  3%  softirqs.CPU37.SCHED
     50752 ±  2%      +9.6%      55616 ±  2%  softirqs.CPU38.RCU
     28454           +22.8%      34936 ±  3%  softirqs.CPU38.SCHED
     28487           +22.2%      34801 ±  2%  softirqs.CPU39.SCHED
     28743           +22.8%      35304 ±  2%  softirqs.CPU4.SCHED
     44544 ±  5%     +11.7%      49768 ±  9%  softirqs.CPU40.NET_RX
     28550           +22.1%      34863 ±  3%  softirqs.CPU40.SCHED
     50810 ±  2%     +11.3%      56563 ±  3%  softirqs.CPU41.RCU
     28655           +22.3%      35032 ±  2%  softirqs.CPU41.SCHED
     45170 ±  6%     +13.7%      51352 ±  6%  softirqs.CPU42.NET_RX
     28518           +21.7%      34695 ±  2%  softirqs.CPU42.SCHED
     50807 ±  2%      +8.1%      54934 ±  3%  softirqs.CPU43.RCU
     28578           +22.6%      35036 ±  3%  softirqs.CPU43.SCHED
     44754 ±  3%     +13.5%      50778 ±  4%  softirqs.CPU44.NET_RX
     28636           +23.3%      35295 ±  3%  softirqs.CPU44.SCHED
     28345           +24.2%      35198 ±  2%  softirqs.CPU45.SCHED
     46288 ±  2%      +9.9%      50879 ±  6%  softirqs.CPU46.NET_RX
     52225 ±  6%      +7.1%      55921 ±  3%  softirqs.CPU46.RCU
     28752 ±  2%     +21.8%      35031 ±  3%  softirqs.CPU46.SCHED
     43887 ±  2%     +12.8%      49512 ±  7%  softirqs.CPU47.NET_RX
     50519 ±  2%     +10.7%      55911 ±  2%  softirqs.CPU47.RCU
     28516           +22.6%      34970 ±  3%  softirqs.CPU47.SCHED
     30033 ±  2%     +16.4%      34963 ±  2%  softirqs.CPU48.SCHED
     29484           +19.1%      35124 ±  2%  softirqs.CPU49.SCHED
     28753           +22.0%      35084 ±  2%  softirqs.CPU5.SCHED
     44597 ±  3%     +17.2%      52279 ±  2%  softirqs.CPU50.NET_RX
     29526           +19.1%      35171 ±  2%  softirqs.CPU50.SCHED
     44137           +16.1%      51253 ±  7%  softirqs.CPU51.NET_RX
     29663           +20.3%      35695 ±  2%  softirqs.CPU51.SCHED
     43768 ±  6%     +20.8%      52885 ±  6%  softirqs.CPU52.NET_RX
     29619           +19.9%      35507 ±  2%  softirqs.CPU52.SCHED
     42475 ±  4%     +22.1%      51878 ±  4%  softirqs.CPU53.NET_RX
     30051           +17.3%      35260 ±  2%  softirqs.CPU53.SCHED
     44059 ±  6%     +19.4%      52625 ±  7%  softirqs.CPU54.NET_RX
     29875           +17.4%      35066        softirqs.CPU54.SCHED
     29722           +18.3%      35154 ±  2%  softirqs.CPU55.SCHED
     43623 ±  3%     +15.5%      50389 ±  7%  softirqs.CPU56.NET_RX
     29500           +19.6%      35281 ±  2%  softirqs.CPU56.SCHED
     44928 ±  4%     +18.0%      53029 ±  5%  softirqs.CPU57.NET_RX
     29901 ±  2%     +18.3%      35365 ±  2%  softirqs.CPU57.SCHED
     43523 ±  3%     +20.4%      52386 ±  7%  softirqs.CPU58.NET_RX
     29630           +18.7%      35183 ±  2%  softirqs.CPU58.SCHED
     45144 ±  7%     +16.1%      52427 ± 10%  softirqs.CPU59.NET_RX
     29710 ±  2%     +19.2%      35426 ±  2%  softirqs.CPU59.SCHED
     45594 ±  3%     +14.7%      52301 ±  5%  softirqs.CPU6.NET_RX
     28614           +22.8%      35133 ±  3%  softirqs.CPU6.SCHED
     42332 ±  3%     +16.6%      49358 ±  6%  softirqs.CPU60.NET_RX
     29703           +19.6%      35537 ±  2%  softirqs.CPU60.SCHED
     42869 ±  5%     +22.3%      52443 ±  5%  softirqs.CPU61.NET_RX
     29194           +20.0%      35038 ±  2%  softirqs.CPU61.SCHED
     44402 ±  2%     +15.7%      51393 ±  5%  softirqs.CPU62.NET_RX
     29477           +19.5%      35239 ±  2%  softirqs.CPU62.SCHED
     44743 ±  3%     +15.4%      51633        softirqs.CPU63.NET_RX
     29756           +19.3%      35502 ±  2%  softirqs.CPU63.SCHED
     42981 ±  4%     +31.1%      56370 ± 20%  softirqs.CPU64.NET_RX
     29430           +21.3%      35709 ±  4%  softirqs.CPU64.SCHED
     43089 ±  2%     +17.5%      50634 ±  4%  softirqs.CPU65.NET_RX
     29470           +20.1%      35383 ±  2%  softirqs.CPU65.SCHED
     43585 ±  3%     +22.2%      53263 ±  5%  softirqs.CPU66.NET_RX
     29484           +20.4%      35502 ±  2%  softirqs.CPU66.SCHED
     29669           +18.3%      35097 ±  2%  softirqs.CPU67.SCHED
     43010           +15.8%      49814 ±  7%  softirqs.CPU68.NET_RX
     29500           +19.8%      35330 ±  2%  softirqs.CPU68.SCHED
     45182 ±  3%     +16.9%      52809 ±  7%  softirqs.CPU69.NET_RX
     29786           +18.2%      35212 ±  2%  softirqs.CPU69.SCHED
     45265 ±  2%     +14.1%      51629 ±  6%  softirqs.CPU7.NET_RX
     28447           +22.2%      34751 ±  4%  softirqs.CPU7.SCHED
     29553           +20.4%      35570 ±  2%  softirqs.CPU70.SCHED
     46032 ±  3%     +19.2%      54881 ± 11%  softirqs.CPU71.NET_RX
     29436           +20.0%      35316 ±  2%  softirqs.CPU71.SCHED
     44150 ±  2%     +17.2%      51757 ±  4%  softirqs.CPU72.NET_RX
     29687           +19.2%      35376 ±  2%  softirqs.CPU72.SCHED
     29410 ±  2%     +19.4%      35124        softirqs.CPU73.SCHED
     29595           +19.5%      35368        softirqs.CPU74.SCHED
     29561           +19.4%      35305 ±  2%  softirqs.CPU75.SCHED
     29573           +19.3%      35272 ±  2%  softirqs.CPU76.SCHED
     44691           +14.7%      51277 ±  3%  softirqs.CPU77.NET_RX
     29559           +18.6%      35061 ±  2%  softirqs.CPU77.SCHED
     29539           +19.2%      35197 ±  2%  softirqs.CPU78.SCHED
     43920 ±  4%     +15.7%      50809 ±  2%  softirqs.CPU79.NET_RX
     29344           +20.4%      35319 ±  2%  softirqs.CPU79.SCHED
     43484 ±  4%     +17.9%      51279 ±  7%  softirqs.CPU8.NET_RX
     28525           +21.6%      34681 ±  3%  softirqs.CPU8.SCHED
     29709           +18.7%      35251 ±  2%  softirqs.CPU80.SCHED
     42629 ±  4%     +19.4%      50914 ±  8%  softirqs.CPU81.NET_RX
     29446           +19.5%      35191 ±  2%  softirqs.CPU81.SCHED
     44074 ±  5%     +15.7%      51006 ±  2%  softirqs.CPU82.NET_RX
     49412           +12.1%      55405 ±  2%  softirqs.CPU82.RCU
     29419           +19.5%      35144 ±  2%  softirqs.CPU82.SCHED
     43015 ±  2%     +12.9%      48558 ±  5%  softirqs.CPU83.NET_RX
     29603           +19.6%      35395 ±  2%  softirqs.CPU83.SCHED
     44188 ±  5%     +15.8%      51184 ±  7%  softirqs.CPU84.NET_RX
     29510           +19.5%      35256 ±  2%  softirqs.CPU84.SCHED
     52136 ±  3%      +6.8%      55670 ±  3%  softirqs.CPU85.RCU
     29280           +20.3%      35212 ±  2%  softirqs.CPU85.SCHED
     44289 ±  4%     +14.7%      50805 ±  5%  softirqs.CPU86.NET_RX
     51516 ±  2%     +10.0%      56671 ±  4%  softirqs.CPU86.RCU
     29448           +19.7%      35241 ±  2%  softirqs.CPU86.SCHED
     29478           +18.8%      35030 ±  2%  softirqs.CPU87.SCHED
     51858            +8.5%      56267 ±  4%  softirqs.CPU88.RCU
     29288           +20.6%      35318        softirqs.CPU88.SCHED
     43345 ±  3%     +19.7%      51902 ±  5%  softirqs.CPU89.NET_RX
     29484           +19.6%      35266 ±  2%  softirqs.CPU89.SCHED
     28764           +21.4%      34906 ±  3%  softirqs.CPU9.SCHED
     44081 ±  7%     +24.6%      54920 ±  8%  softirqs.CPU90.NET_RX
     50851 ±  3%      +7.8%      54798        softirqs.CPU90.RCU
     29205           +19.8%      34988 ±  2%  softirqs.CPU90.SCHED
     44736 ±  2%     +16.0%      51898 ±  7%  softirqs.CPU91.NET_RX
     29462           +19.5%      35206 ±  3%  softirqs.CPU91.SCHED
     50818           +10.1%      55938 ±  5%  softirqs.CPU92.RCU
     29824           +17.7%      35115 ±  2%  softirqs.CPU92.SCHED
     50676 ±  2%     +10.4%      55933 ±  4%  softirqs.CPU93.RCU
     29438           +19.4%      35152 ±  2%  softirqs.CPU93.SCHED
     51367            +8.8%      55882 ±  4%  softirqs.CPU94.RCU
     29448           +20.5%      35498 ±  2%  softirqs.CPU94.SCHED
     44130 ±  4%     +15.5%      50963 ±  3%  softirqs.CPU95.NET_RX
     29554           +18.7%      35083        softirqs.CPU95.SCHED
   4295349           +14.4%    4915886        softirqs.NET_RX
   2800171           +20.6%    3377483 ±  2%  softirqs.SCHED
    574.75 ± 13%     +70.4%     979.50 ± 13%  interrupts.CPU0.TLB:TLB_shootdowns
      3102 ±  3%     -20.7%       2460 ±  6%  interrupts.CPU1.NMI:Non-maskable_interrupts
      3102 ±  3%     -20.7%       2460 ±  6%  interrupts.CPU1.PMI:Performance_monitoring_interrupts
    510.75 ± 16%     +66.2%     848.75 ± 13%  interrupts.CPU1.TLB:TLB_shootdowns
    442.50 ±  3%     +87.5%     829.75 ± 13%  interrupts.CPU10.TLB:TLB_shootdowns
      3108 ±  4%     -29.9%       2180 ± 25%  interrupts.CPU11.NMI:Non-maskable_interrupts
      3108 ±  4%     -29.9%       2180 ± 25%  interrupts.CPU11.PMI:Performance_monitoring_interrupts
    462.75 ± 10%     +69.5%     784.25 ± 19%  interrupts.CPU11.TLB:TLB_shootdowns
    463.75 ±  7%     +90.2%     882.25 ± 16%  interrupts.CPU12.TLB:TLB_shootdowns
      3102 ±  3%     -20.6%       2464 ±  7%  interrupts.CPU13.NMI:Non-maskable_interrupts
      3102 ±  3%     -20.6%       2464 ±  7%  interrupts.CPU13.PMI:Performance_monitoring_interrupts
    496.00 ±  7%     +79.5%     890.25 ±  4%  interrupts.CPU13.TLB:TLB_shootdowns
      3142 ±  5%     -30.2%       2194 ± 25%  interrupts.CPU14.NMI:Non-maskable_interrupts
      3142 ±  5%     -30.2%       2194 ± 25%  interrupts.CPU14.PMI:Performance_monitoring_interrupts
    475.00 ±  6%     +73.5%     824.00 ±  9%  interrupts.CPU14.TLB:TLB_shootdowns
      3118 ±  4%     -30.4%       2169 ± 25%  interrupts.CPU15.NMI:Non-maskable_interrupts
      3118 ±  4%     -30.4%       2169 ± 25%  interrupts.CPU15.PMI:Performance_monitoring_interrupts
    466.75 ± 10%     +84.0%     859.00 ± 10%  interrupts.CPU15.TLB:TLB_shootdowns
    446.75 ± 11%     +86.4%     832.75 ± 11%  interrupts.CPU16.TLB:TLB_shootdowns
      3103 ±  3%     -17.9%       2547 ±  7%  interrupts.CPU17.NMI:Non-maskable_interrupts
      3103 ±  3%     -17.9%       2547 ±  7%  interrupts.CPU17.PMI:Performance_monitoring_interrupts
    493.00 ±  8%     +70.1%     838.50 ± 13%  interrupts.CPU17.TLB:TLB_shootdowns
      3097 ±  4%     -29.3%       2191 ± 25%  interrupts.CPU18.NMI:Non-maskable_interrupts
      3097 ±  4%     -29.3%       2191 ± 25%  interrupts.CPU18.PMI:Performance_monitoring_interrupts
    491.75 ± 10%     +78.0%     875.50 ± 13%  interrupts.CPU18.TLB:TLB_shootdowns
      3087 ±  4%     -29.1%       2188 ± 25%  interrupts.CPU19.NMI:Non-maskable_interrupts
      3087 ±  4%     -29.1%       2188 ± 25%  interrupts.CPU19.PMI:Performance_monitoring_interrupts
    468.75 ±  7%     +73.3%     812.50 ± 16%  interrupts.CPU19.TLB:TLB_shootdowns
    496.00 ± 15%     +92.6%     955.25 ± 13%  interrupts.CPU2.TLB:TLB_shootdowns
      3109 ±  3%     -19.9%       2490 ±  5%  interrupts.CPU20.NMI:Non-maskable_interrupts
      3109 ±  3%     -19.9%       2490 ±  5%  interrupts.CPU20.PMI:Performance_monitoring_interrupts
    502.75 ± 11%     +71.4%     861.50 ± 10%  interrupts.CPU20.TLB:TLB_shootdowns
      3091 ±  4%     -19.9%       2477 ±  8%  interrupts.CPU21.NMI:Non-maskable_interrupts
      3091 ±  4%     -19.9%       2477 ±  8%  interrupts.CPU21.PMI:Performance_monitoring_interrupts
    474.25 ±  8%     +82.4%     865.00 ± 12%  interrupts.CPU21.TLB:TLB_shootdowns
      3103 ±  3%     -20.9%       2454 ±  7%  interrupts.CPU22.NMI:Non-maskable_interrupts
      3103 ±  3%     -20.9%       2454 ±  7%  interrupts.CPU22.PMI:Performance_monitoring_interrupts
    455.50 ± 20%     +89.1%     861.50 ± 17%  interrupts.CPU22.TLB:TLB_shootdowns
      3133 ±  3%     -30.9%       2163 ± 29%  interrupts.CPU23.NMI:Non-maskable_interrupts
      3133 ±  3%     -30.9%       2163 ± 29%  interrupts.CPU23.PMI:Performance_monitoring_interrupts
    479.25 ± 12%     +72.4%     826.25 ±  9%  interrupts.CPU23.TLB:TLB_shootdowns
    459.25 ± 12%    +100.9%     922.75 ± 13%  interrupts.CPU24.TLB:TLB_shootdowns
    505.50 ±  5%     +78.2%     900.75 ±  8%  interrupts.CPU25.TLB:TLB_shootdowns
    481.50 ± 14%     +96.3%     945.25 ± 14%  interrupts.CPU26.TLB:TLB_shootdowns
    498.00 ± 13%     +86.7%     930.00 ±  9%  interrupts.CPU27.TLB:TLB_shootdowns
    491.50 ± 10%     +82.6%     897.50 ± 19%  interrupts.CPU28.TLB:TLB_shootdowns
      3140 ±  3%     -39.7%       1894 ± 41%  interrupts.CPU29.NMI:Non-maskable_interrupts
      3140 ±  3%     -39.7%       1894 ± 41%  interrupts.CPU29.PMI:Performance_monitoring_interrupts
    459.00 ± 11%     +98.2%     909.75 ± 14%  interrupts.CPU29.TLB:TLB_shootdowns
      3136 ±  4%     -21.4%       2464 ±  6%  interrupts.CPU3.NMI:Non-maskable_interrupts
      3136 ±  4%     -21.4%       2464 ±  6%  interrupts.CPU3.PMI:Performance_monitoring_interrupts
    537.75 ± 13%     +68.6%     906.50 ± 11%  interrupts.CPU3.TLB:TLB_shootdowns
      3106 ±  3%     -30.3%       2165 ± 27%  interrupts.CPU30.NMI:Non-maskable_interrupts
      3106 ±  3%     -30.3%       2165 ± 27%  interrupts.CPU30.PMI:Performance_monitoring_interrupts
    465.50 ± 15%     +88.4%     877.00 ± 11%  interrupts.CPU30.TLB:TLB_shootdowns
      3096 ±  4%     -39.0%       1887 ± 41%  interrupts.CPU31.NMI:Non-maskable_interrupts
      3096 ±  4%     -39.0%       1887 ± 41%  interrupts.CPU31.PMI:Performance_monitoring_interrupts
    472.00 ± 12%     +83.0%     863.75 ± 10%  interrupts.CPU31.TLB:TLB_shootdowns
      3099 ±  4%     -50.4%       1538 ± 37%  interrupts.CPU32.NMI:Non-maskable_interrupts
      3099 ±  4%     -50.4%       1538 ± 37%  interrupts.CPU32.PMI:Performance_monitoring_interrupts
    470.50 ±  7%     +93.8%     911.75 ±  6%  interrupts.CPU32.TLB:TLB_shootdowns
    537.75 ± 14%     +67.8%     902.25 ± 13%  interrupts.CPU33.TLB:TLB_shootdowns
    444.00 ± 11%    +108.8%     927.25 ± 13%  interrupts.CPU34.TLB:TLB_shootdowns
    499.25 ± 12%     +81.0%     903.75 ± 20%  interrupts.CPU35.TLB:TLB_shootdowns
    487.50 ±  5%     +85.8%     906.00 ± 13%  interrupts.CPU36.TLB:TLB_shootdowns
    458.50 ± 17%     +94.5%     891.75 ± 12%  interrupts.CPU37.TLB:TLB_shootdowns
      1442 ±  4%      -5.9%       1357 ±  5%  interrupts.CPU38.CAL:Function_call_interrupts
    466.00 ± 11%     +98.8%     926.25 ± 13%  interrupts.CPU38.TLB:TLB_shootdowns
    480.75 ± 10%     +75.5%     843.50 ± 13%  interrupts.CPU39.TLB:TLB_shootdowns
    414.75 ±  6%    +115.9%     895.50 ±  5%  interrupts.CPU4.TLB:TLB_shootdowns
      3137 ±  2%     -21.6%       2459 ± 11%  interrupts.CPU40.NMI:Non-maskable_interrupts
      3137 ±  2%     -21.6%       2459 ± 11%  interrupts.CPU40.PMI:Performance_monitoring_interrupts
    486.50 ± 18%     +77.2%     862.00 ± 16%  interrupts.CPU40.TLB:TLB_shootdowns
    484.00 ± 17%     +95.8%     947.75 ± 13%  interrupts.CPU41.TLB:TLB_shootdowns
    453.75 ± 16%     +95.2%     885.50 ± 11%  interrupts.CPU42.TLB:TLB_shootdowns
      3116 ±  3%     -22.1%       2429 ±  7%  interrupts.CPU43.NMI:Non-maskable_interrupts
      3116 ±  3%     -22.1%       2429 ±  7%  interrupts.CPU43.PMI:Performance_monitoring_interrupts
    437.25 ±  9%     +99.8%     873.75 ± 11%  interrupts.CPU43.TLB:TLB_shootdowns
    452.75 ± 16%    +101.3%     911.25 ±  7%  interrupts.CPU44.TLB:TLB_shootdowns
      3180 ±  4%     -24.5%       2402 ±  9%  interrupts.CPU45.NMI:Non-maskable_interrupts
      3180 ±  4%     -24.5%       2402 ±  9%  interrupts.CPU45.PMI:Performance_monitoring_interrupts
    477.50 ± 14%     +88.8%     901.75 ± 11%  interrupts.CPU45.TLB:TLB_shootdowns
      3117 ±  3%     -20.9%       2465 ±  8%  interrupts.CPU46.NMI:Non-maskable_interrupts
      3117 ±  3%     -20.9%       2465 ±  8%  interrupts.CPU46.PMI:Performance_monitoring_interrupts
    493.50 ± 10%     +69.8%     837.75 ±  8%  interrupts.CPU46.TLB:TLB_shootdowns
    478.50 ± 16%     +76.7%     845.50 ±  4%  interrupts.CPU47.TLB:TLB_shootdowns
      3119 ±  3%     -31.3%       2142 ± 26%  interrupts.CPU48.NMI:Non-maskable_interrupts
      3119 ±  3%     -31.3%       2142 ± 26%  interrupts.CPU48.PMI:Performance_monitoring_interrupts
    464.50 ±  7%     +88.8%     876.75 ±  6%  interrupts.CPU48.TLB:TLB_shootdowns
    488.00 ± 11%     +82.2%     889.00 ± 15%  interrupts.CPU49.TLB:TLB_shootdowns
      3121 ±  4%     -19.0%       2527 ±  6%  interrupts.CPU5.NMI:Non-maskable_interrupts
      3121 ±  4%     -19.0%       2527 ±  6%  interrupts.CPU5.PMI:Performance_monitoring_interrupts
    458.00 ± 10%     +98.3%     908.00 ± 13%  interrupts.CPU5.TLB:TLB_shootdowns
      1382 ±  3%      +9.2%       1508 ±  4%  interrupts.CPU50.CAL:Function_call_interrupts
      3114 ±  4%     -21.5%       2445 ±  8%  interrupts.CPU50.NMI:Non-maskable_interrupts
      3114 ±  4%     -21.5%       2445 ±  8%  interrupts.CPU50.PMI:Performance_monitoring_interrupts
    492.00 ± 13%     +74.7%     859.75 ± 11%  interrupts.CPU50.TLB:TLB_shootdowns
      3123 ±  4%     -22.5%       2420 ±  6%  interrupts.CPU51.NMI:Non-maskable_interrupts
      3123 ±  4%     -22.5%       2420 ±  6%  interrupts.CPU51.PMI:Performance_monitoring_interrupts
    479.00 ± 17%     +74.2%     834.50 ±  8%  interrupts.CPU51.TLB:TLB_shootdowns
    458.25 ± 16%     +81.5%     831.50 ±  7%  interrupts.CPU52.TLB:TLB_shootdowns
      3144 ±  5%     -21.7%       2460 ±  8%  interrupts.CPU53.NMI:Non-maskable_interrupts
      3144 ±  5%     -21.7%       2460 ±  8%  interrupts.CPU53.PMI:Performance_monitoring_interrupts
    448.25 ±  8%    +102.2%     906.50 ± 15%  interrupts.CPU53.TLB:TLB_shootdowns
      3120 ±  4%     -30.2%       2177 ± 28%  interrupts.CPU54.NMI:Non-maskable_interrupts
      3120 ±  4%     -30.2%       2177 ± 28%  interrupts.CPU54.PMI:Performance_monitoring_interrupts
    464.00 ± 11%     +75.8%     815.50 ± 15%  interrupts.CPU54.TLB:TLB_shootdowns
      3107 ±  3%     -21.5%       2440 ± 10%  interrupts.CPU55.NMI:Non-maskable_interrupts
      3107 ±  3%     -21.5%       2440 ± 10%  interrupts.CPU55.PMI:Performance_monitoring_interrupts
    475.75 ± 15%     +80.9%     860.50 ±  6%  interrupts.CPU55.TLB:TLB_shootdowns
      3126 ±  4%     -32.1%       2121 ± 28%  interrupts.CPU56.NMI:Non-maskable_interrupts
      3126 ±  4%     -32.1%       2121 ± 28%  interrupts.CPU56.PMI:Performance_monitoring_interrupts
    504.75 ±  3%     +62.7%     821.00 ± 16%  interrupts.CPU56.TLB:TLB_shootdowns
    456.00 ±  6%     +79.9%     820.25 ± 11%  interrupts.CPU57.TLB:TLB_shootdowns
    436.50 ±  5%    +107.5%     905.75 ± 13%  interrupts.CPU58.TLB:TLB_shootdowns
    454.75 ±  9%     +74.9%     795.50 ± 12%  interrupts.CPU59.TLB:TLB_shootdowns
      1314 ±  3%      +8.6%       1426 ±  2%  interrupts.CPU6.CAL:Function_call_interrupts
      3102 ±  4%     -18.4%       2530 ±  8%  interrupts.CPU6.NMI:Non-maskable_interrupts
      3102 ±  4%     -18.4%       2530 ±  8%  interrupts.CPU6.PMI:Performance_monitoring_interrupts
    499.25 ± 13%     +61.0%     804.00 ± 10%  interrupts.CPU6.TLB:TLB_shootdowns
    478.25 ±  6%     +90.4%     910.75 ± 10%  interrupts.CPU60.TLB:TLB_shootdowns
    424.75 ±  7%    +111.9%     900.00 ±  9%  interrupts.CPU61.TLB:TLB_shootdowns
      1691 ±  4%      -8.8%       1542 ±  2%  interrupts.CPU62.RES:Rescheduling_interrupts
    460.75 ± 14%     +86.2%     858.00 ± 15%  interrupts.CPU62.TLB:TLB_shootdowns
    497.25 ± 15%     +69.8%     844.50 ± 16%  interrupts.CPU63.TLB:TLB_shootdowns
    472.75 ± 18%     +66.2%     785.50 ± 11%  interrupts.CPU64.TLB:TLB_shootdowns
    470.25 ±  2%     +69.9%     798.75 ± 11%  interrupts.CPU65.TLB:TLB_shootdowns
    457.00 ±  7%     +85.1%     845.75 ± 12%  interrupts.CPU66.TLB:TLB_shootdowns
      3087 ±  4%     -51.6%       1495 ± 30%  interrupts.CPU67.NMI:Non-maskable_interrupts
      3087 ±  4%     -51.6%       1495 ± 30%  interrupts.CPU67.PMI:Performance_monitoring_interrupts
      1686 ±  5%     -10.2%       1514 ±  2%  interrupts.CPU67.RES:Rescheduling_interrupts
    468.75 ±  7%     +84.0%     862.50 ± 13%  interrupts.CPU67.TLB:TLB_shootdowns
    436.75 ±  8%     +98.7%     868.00 ± 14%  interrupts.CPU68.TLB:TLB_shootdowns
      3092 ±  4%     -29.5%       2181 ± 28%  interrupts.CPU69.NMI:Non-maskable_interrupts
      3092 ±  4%     -29.5%       2181 ± 28%  interrupts.CPU69.PMI:Performance_monitoring_interrupts
    475.00 ± 16%     +76.9%     840.25 ±  9%  interrupts.CPU69.TLB:TLB_shootdowns
      3110 ±  4%     -20.6%       2470 ±  8%  interrupts.CPU7.NMI:Non-maskable_interrupts
      3110 ±  4%     -20.6%       2470 ±  8%  interrupts.CPU7.PMI:Performance_monitoring_interrupts
    480.50 ±  7%     +74.7%     839.25 ±  8%  interrupts.CPU7.TLB:TLB_shootdowns
      3102 ±  3%     -30.9%       2144 ± 28%  interrupts.CPU70.NMI:Non-maskable_interrupts
      3102 ±  3%     -30.9%       2144 ± 28%  interrupts.CPU70.PMI:Performance_monitoring_interrupts
    450.50 ±  7%     +92.7%     868.25 ± 12%  interrupts.CPU70.TLB:TLB_shootdowns
      3140 ±  3%     -40.5%       1868 ± 37%  interrupts.CPU71.NMI:Non-maskable_interrupts
      3140 ±  3%     -40.5%       1868 ± 37%  interrupts.CPU71.PMI:Performance_monitoring_interrupts
    429.50 ±  5%    +100.0%     859.00 ± 13%  interrupts.CPU71.TLB:TLB_shootdowns
    475.25 ± 10%     +91.2%     908.75 ±  4%  interrupts.CPU72.TLB:TLB_shootdowns
      3097 ±  3%     -30.6%       2149 ± 27%  interrupts.CPU73.NMI:Non-maskable_interrupts
      3097 ±  3%     -30.6%       2149 ± 27%  interrupts.CPU73.PMI:Performance_monitoring_interrupts
    480.50 ±  6%     +73.1%     831.75 ±  7%  interrupts.CPU73.TLB:TLB_shootdowns
      1498 ±  6%      -7.7%       1383 ±  2%  interrupts.CPU74.CAL:Function_call_interrupts
      3120 ±  3%     -31.0%       2153 ± 28%  interrupts.CPU74.NMI:Non-maskable_interrupts
      3120 ±  3%     -31.0%       2153 ± 28%  interrupts.CPU74.PMI:Performance_monitoring_interrupts
    483.75 ±  8%     +86.3%     901.00 ± 18%  interrupts.CPU74.TLB:TLB_shootdowns
      3129 ±  3%     -31.8%       2135 ± 27%  interrupts.CPU75.NMI:Non-maskable_interrupts
      3129 ±  3%     -31.8%       2135 ± 27%  interrupts.CPU75.PMI:Performance_monitoring_interrupts
      1619 ±  5%      -8.1%       1487 ±  2%  interrupts.CPU75.RES:Rescheduling_interrupts
    497.00 ± 17%     +70.7%     848.50 ± 10%  interrupts.CPU75.TLB:TLB_shootdowns
      3123 ±  4%     -33.0%       2091 ± 22%  interrupts.CPU76.NMI:Non-maskable_interrupts
      3123 ±  4%     -33.0%       2091 ± 22%  interrupts.CPU76.PMI:Performance_monitoring_interrupts
    486.25 ± 12%     +76.6%     858.50 ±  9%  interrupts.CPU76.TLB:TLB_shootdowns
      3148 ±  2%     -32.7%       2120 ± 20%  interrupts.CPU77.NMI:Non-maskable_interrupts
      3148 ±  2%     -32.7%       2120 ± 20%  interrupts.CPU77.PMI:Performance_monitoring_interrupts
    473.75 ± 13%     +99.6%     945.50 ±  5%  interrupts.CPU77.TLB:TLB_shootdowns
    458.00 ± 13%     +91.4%     876.75 ± 12%  interrupts.CPU78.TLB:TLB_shootdowns
      3096 ±  4%     -32.0%       2105 ± 20%  interrupts.CPU79.NMI:Non-maskable_interrupts
      3096 ±  4%     -32.0%       2105 ± 20%  interrupts.CPU79.PMI:Performance_monitoring_interrupts
    485.75 ±  4%     +91.1%     928.50 ± 12%  interrupts.CPU79.TLB:TLB_shootdowns
      3128 ±  4%     -20.9%       2475 ±  6%  interrupts.CPU8.NMI:Non-maskable_interrupts
      3128 ±  4%     -20.9%       2475 ±  6%  interrupts.CPU8.PMI:Performance_monitoring_interrupts
    471.50 ±  9%     +90.1%     896.25 ±  8%  interrupts.CPU8.TLB:TLB_shootdowns
      3105 ±  3%     -32.9%       2084 ± 21%  interrupts.CPU80.NMI:Non-maskable_interrupts
      3105 ±  3%     -32.9%       2084 ± 21%  interrupts.CPU80.PMI:Performance_monitoring_interrupts
      1640 ±  2%     -10.3%       1472 ±  2%  interrupts.CPU80.RES:Rescheduling_interrupts
    462.00 ±  8%     +87.1%     864.25 ± 11%  interrupts.CPU80.TLB:TLB_shootdowns
      3101 ±  4%     -22.1%       2417 ± 11%  interrupts.CPU81.NMI:Non-maskable_interrupts
      3101 ±  4%     -22.1%       2417 ± 11%  interrupts.CPU81.PMI:Performance_monitoring_interrupts
    460.50 ±  9%     +98.7%     915.00 ± 11%  interrupts.CPU81.TLB:TLB_shootdowns
      3100 ±  3%     -30.0%       2170 ± 29%  interrupts.CPU82.NMI:Non-maskable_interrupts
      3100 ±  3%     -30.0%       2170 ± 29%  interrupts.CPU82.PMI:Performance_monitoring_interrupts
    458.25 ± 14%     +86.3%     853.75 ± 12%  interrupts.CPU82.TLB:TLB_shootdowns
    485.25 ± 13%     +88.5%     914.75 ± 11%  interrupts.CPU83.TLB:TLB_shootdowns
      3096 ±  4%     -31.7%       2114 ± 21%  interrupts.CPU84.NMI:Non-maskable_interrupts
      3096 ±  4%     -31.7%       2114 ± 21%  interrupts.CPU84.PMI:Performance_monitoring_interrupts
    505.25 ± 22%     +78.7%     902.75 ± 18%  interrupts.CPU84.TLB:TLB_shootdowns
      3116 ±  4%     -20.9%       2465 ±  7%  interrupts.CPU85.NMI:Non-maskable_interrupts
      3116 ±  4%     -20.9%       2465 ±  7%  interrupts.CPU85.PMI:Performance_monitoring_interrupts
    480.75 ± 12%     +82.3%     876.25 ±  7%  interrupts.CPU85.TLB:TLB_shootdowns
    496.75 ± 13%     +76.7%     877.75 ± 11%  interrupts.CPU86.TLB:TLB_shootdowns
    459.00 ± 13%     +71.6%     787.50 ± 16%  interrupts.CPU87.TLB:TLB_shootdowns
    446.50 ± 14%    +111.5%     944.50 ± 11%  interrupts.CPU88.TLB:TLB_shootdowns
      3120 ±  3%     -22.3%       2424 ±  9%  interrupts.CPU89.NMI:Non-maskable_interrupts
      3120 ±  3%     -22.3%       2424 ±  9%  interrupts.CPU89.PMI:Performance_monitoring_interrupts
    454.00 ± 12%     +83.8%     834.50 ±  9%  interrupts.CPU89.TLB:TLB_shootdowns
      3162 ±  5%     -19.6%       2541 ±  8%  interrupts.CPU9.NMI:Non-maskable_interrupts
      3162 ±  5%     -19.6%       2541 ±  8%  interrupts.CPU9.PMI:Performance_monitoring_interrupts
    461.75 ± 16%     +85.9%     858.50 ± 15%  interrupts.CPU9.TLB:TLB_shootdowns
    447.25 ±  5%     +90.0%     849.75 ± 13%  interrupts.CPU90.TLB:TLB_shootdowns
    440.75 ±  5%     +94.7%     858.00 ± 17%  interrupts.CPU91.TLB:TLB_shootdowns
      1651 ±  2%     -10.6%       1476 ±  3%  interrupts.CPU92.RES:Rescheduling_interrupts
    471.25 ±  9%     +76.3%     831.00 ±  7%  interrupts.CPU92.TLB:TLB_shootdowns
      3104 ±  3%     -40.5%       1846 ± 41%  interrupts.CPU93.NMI:Non-maskable_interrupts
      3104 ±  3%     -40.5%       1846 ± 41%  interrupts.CPU93.PMI:Performance_monitoring_interrupts
      1647 ±  4%      -8.4%       1508 ±  3%  interrupts.CPU93.RES:Rescheduling_interrupts
    556.25 ± 14%     +60.3%     891.75 ±  2%  interrupts.CPU93.TLB:TLB_shootdowns
      3093 ±  3%     -30.6%       2147 ± 29%  interrupts.CPU94.NMI:Non-maskable_interrupts
      3093 ±  3%     -30.6%       2147 ± 29%  interrupts.CPU94.PMI:Performance_monitoring_interrupts
    438.00 ± 12%    +103.0%     889.25 ± 21%  interrupts.CPU94.TLB:TLB_shootdowns
    276499 ±  2%     -22.2%     215100 ± 11%  interrupts.NMI:Non-maskable_interrupts
    276499 ±  2%     -22.2%     215100 ± 11%  interrupts.PMI:Performance_monitoring_interrupts
     45786 ±  8%    +103.8%      93329 ± 23%  interrupts.TLB:TLB_shootdowns
     64.68 ±  2%     -64.7        0.00        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.scan_positives.dcache_readdir.iterate_dir
     66.88 ±  2%     -52.7       14.20 ±  5%  perf-profile.calltrace.cycles-pp.dcache_readdir.iterate_dir.__x64_sys_getdents64.do_syscall_64.entry_SYSCALL_64_after_hwframe
     66.90 ±  2%     -52.7       14.22 ±  5%  perf-profile.calltrace.cycles-pp.__x64_sys_getdents64.do_syscall_64.entry_SYSCALL_64_after_hwframe
     66.90 ±  2%     -52.7       14.22 ±  5%  perf-profile.calltrace.cycles-pp.iterate_dir.__x64_sys_getdents64.do_syscall_64.entry_SYSCALL_64_after_hwframe
     65.76 ±  2%     -52.1       13.63 ±  5%  perf-profile.calltrace.cycles-pp.scan_positives.dcache_readdir.iterate_dir.__x64_sys_getdents64.do_syscall_64
     65.27 ±  2%     -52.0       13.30 ±  5%  perf-profile.calltrace.cycles-pp._raw_spin_lock.scan_positives.dcache_readdir.iterate_dir.__x64_sys_getdents64
     70.98 ±  2%     -46.2       24.74 ± 13%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe
     71.11 ±  2%     -46.1       24.96 ± 13%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.70 ± 14%      +0.4        1.15 ±  6%  perf-profile.calltrace.cycles-pp.div_short
      0.61 ± 13%      +0.5        1.07 ±  6%  perf-profile.calltrace.cycles-pp.div_int
      0.64 ±  5%      +0.5        1.13 ±  2%  perf-profile.calltrace.cycles-pp.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      0.58 ±  7%      +0.5        1.10 ±  3%  perf-profile.calltrace.cycles-pp.begin_new_exec.load_elf_binary.exec_binprm.bprm_execve.do_execveat_common
      0.68 ±  5%      +0.5        1.20 ±  2%  perf-profile.calltrace.cycles-pp.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      0.00            +0.5        0.54 ±  4%  perf-profile.calltrace.cycles-pp.setlocale
      0.68 ± 12%      +0.6        1.23 ±  8%  perf-profile.calltrace.cycles-pp.add_short.add_short
      0.00            +0.6        0.58        perf-profile.calltrace.cycles-pp.filemap_map_pages.do_fault.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
      0.76 ±  5%      +0.6        1.36 ±  2%  perf-profile.calltrace.cycles-pp.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      0.77 ±  5%      +0.6        1.37 ±  2%  perf-profile.calltrace.cycles-pp.exc_page_fault.asm_exc_page_fault
      0.43 ± 57%      +0.6        1.03 ±  4%  perf-profile.calltrace.cycles-pp.mmput.begin_new_exec.load_elf_binary.exec_binprm.bprm_execve
      0.43 ± 57%      +0.6        1.03 ±  4%  perf-profile.calltrace.cycles-pp.exit_mmap.mmput.begin_new_exec.load_elf_binary.exec_binprm
      0.73 ±  9%      +0.6        1.34 ±  5%  perf-profile.calltrace.cycles-pp.exit_mmap.mmput.do_exit.do_group_exit.__x64_sys_exit_group
      0.43 ± 58%      +0.6        1.05 ±  6%  perf-profile.calltrace.cycles-pp.__do_sys_clone.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.43 ± 58%      +0.6        1.05 ±  6%  perf-profile.calltrace.cycles-pp._do_fork.__do_sys_clone.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.73 ±  9%      +0.6        1.35 ±  6%  perf-profile.calltrace.cycles-pp.mmput.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      0.41 ± 58%      +0.6        1.04 ±  6%  perf-profile.calltrace.cycles-pp.link_path_walk.path_openat.do_filp_open.do_sys_openat2.do_sys_open
      0.79 ±  5%      +0.6        1.42 ±  2%  perf-profile.calltrace.cycles-pp.asm_exc_page_fault
      0.00            +0.6        0.65 ±  4%  perf-profile.calltrace.cycles-pp.path_lookupat.filename_lookup.vfs_statx.__do_sys_newstat.do_syscall_64
      0.27 ±100%      +0.7        0.93 ±  9%  perf-profile.calltrace.cycles-pp.mem_rtns_1
      0.00            +0.7        0.66 ±  3%  perf-profile.calltrace.cycles-pp.filename_lookup.vfs_statx.__do_sys_newstat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +0.7        0.67        perf-profile.calltrace.cycles-pp.do_fault.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault
      0.46 ± 59%      +0.7        1.15 ±  4%  perf-profile.calltrace.cycles-pp.do_sys_openat2.do_sys_open.do_syscall_64.entry_SYSCALL_64_after_hwframe.creat64
      0.46 ± 59%      +0.7        1.15 ±  4%  perf-profile.calltrace.cycles-pp.do_sys_open.do_syscall_64.entry_SYSCALL_64_after_hwframe.creat64
      0.00            +0.7        0.69 ±  8%  perf-profile.calltrace.cycles-pp.refill_obj_stock.kmem_cache_free.rcu_do_batch.rcu_core.__softirqentry_text_start
      0.00            +0.7        0.69 ±  4%  perf-profile.calltrace.cycles-pp.vfs_statx.__do_sys_newstat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.46 ± 59%      +0.7        1.16 ±  4%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.creat64
      0.46 ± 59%      +0.7        1.16 ±  4%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.creat64
      0.00            +0.7        0.70 ±  4%  perf-profile.calltrace.cycles-pp.__do_sys_newstat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.48 ± 59%      +0.7        1.19 ±  5%  perf-profile.calltrace.cycles-pp.creat64
      0.27 ±100%      +0.7        0.99 ±  6%  perf-profile.calltrace.cycles-pp.walk_component.link_path_walk.path_openat.do_filp_open.do_sys_openat2
      0.82 ± 10%      +0.7        1.55 ± 11%  perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry
      0.14 ±173%      +0.7        0.88 ±  8%  perf-profile.calltrace.cycles-pp.__libc_fork
      0.62 ± 12%      +0.8        1.38 ± 14%  perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter.do_idle
      0.90 ±  8%      +0.8        1.65 ±  5%  perf-profile.calltrace.cycles-pp.__x64_sys_exit_group.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.90 ±  8%      +0.8        1.65 ±  5%  perf-profile.calltrace.cycles-pp.do_group_exit.__x64_sys_exit_group.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.90 ±  8%      +0.8        1.65 ±  5%  perf-profile.calltrace.cycles-pp.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +0.8        0.77 ±  9%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__libc_fork
      0.00            +0.8        0.77 ±  9%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_fork
      0.00            +0.8        0.77 ±  9%  perf-profile.calltrace.cycles-pp.__do_sys_clone.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_fork
      0.00            +0.8        0.77 ±  9%  perf-profile.calltrace.cycles-pp._do_fork.__do_sys_clone.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_fork
      0.90 ±  8%      +0.8        1.68 ±  7%  perf-profile.calltrace.cycles-pp.__strcat_chk
      0.15 ±173%      +0.8        0.93 ± 12%  perf-profile.calltrace.cycles-pp.mmap_region.do_mmap.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64
      0.16 ±173%      +0.8        0.97 ± 11%  perf-profile.calltrace.cycles-pp.do_mmap.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.17 ±173%      +0.8        0.99 ± 12%  perf-profile.calltrace.cycles-pp.ksys_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.16 ±173%      +0.8        0.99 ± 12%  perf-profile.calltrace.cycles-pp.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +0.9        0.90 ± 29%  perf-profile.calltrace.cycles-pp.dup_mmap.dup_mm.copy_process._do_fork.__do_sys_clone
      1.04 ±  5%      +0.9        1.97 ±  3%  perf-profile.calltrace.cycles-pp.load_elf_binary.exec_binprm.bprm_execve.do_execveat_common.__x64_sys_execve
      1.04 ±  5%      +0.9        1.99 ±  3%  perf-profile.calltrace.cycles-pp.exec_binprm.bprm_execve.do_execveat_common.__x64_sys_execve.do_syscall_64
      1.41 ± 13%      +1.0        2.42 ±  5%  perf-profile.calltrace.cycles-pp.div_long
      0.00            +1.1        1.05 ± 30%  perf-profile.calltrace.cycles-pp.dup_mm.copy_process._do_fork.__do_sys_clone.do_syscall_64
      1.52 ± 13%      +1.1        2.60 ±  6%  perf-profile.calltrace.cycles-pp.add_long.add_long
      1.52 ± 13%      +1.1        2.63 ±  7%  perf-profile.calltrace.cycles-pp.add_int.add_int
      0.48 ± 59%      +1.3        1.74 ± 24%  perf-profile.calltrace.cycles-pp.kmem_cache_free.rcu_do_batch.rcu_core.__softirqentry_text_start.run_ksoftirqd
      1.65 ±  8%      +1.3        2.99 ±  6%  perf-profile.calltrace.cycles-pp.__strncat_chk
      0.55 ± 58%      +1.4        1.95 ± 22%  perf-profile.calltrace.cycles-pp.rcu_do_batch.rcu_core.__softirqentry_text_start.run_ksoftirqd.smpboot_thread_fn
      0.56 ± 58%      +1.4        1.96 ± 22%  perf-profile.calltrace.cycles-pp.__softirqentry_text_start.run_ksoftirqd.smpboot_thread_fn.kthread.ret_from_fork
      0.56 ± 58%      +1.4        1.96 ± 22%  perf-profile.calltrace.cycles-pp.rcu_core.__softirqentry_text_start.run_ksoftirqd.smpboot_thread_fn.kthread
      0.56 ± 58%      +1.4        1.96 ± 22%  perf-profile.calltrace.cycles-pp.run_ksoftirqd.smpboot_thread_fn.kthread.ret_from_fork
      0.57 ± 58%      +1.4        1.99 ± 21%  perf-profile.calltrace.cycles-pp.smpboot_thread_fn.kthread.ret_from_fork
      0.14 ±173%      +1.5        1.64 ±  7%  perf-profile.calltrace.cycles-pp.copy_process._do_fork.__do_sys_clone.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.63 ± 58%      +1.5        2.13 ± 20%  perf-profile.calltrace.cycles-pp.kthread.ret_from_fork
      0.64 ± 58%      +1.5        2.15 ± 20%  perf-profile.calltrace.cycles-pp.ret_from_fork
      1.00 ± 17%      +2.1        3.09 ± 43%  perf-profile.calltrace.cycles-pp.do_sys_open.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.00 ± 17%      +2.1        3.08 ± 43%  perf-profile.calltrace.cycles-pp.do_sys_openat2.do_sys_open.do_syscall_64.entry_SYSCALL_64_after_hwframe
      5.43 ±  9%      +4.4        9.83 ±  6%  perf-profile.calltrace.cycles-pp.string_rtns_1
      0.00            +5.8        5.81 ±  7%  perf-profile.calltrace.cycles-pp.do_sys_open.do_syscall_64.entry_SYSCALL_64_after_hwframe.__open64_nocancel
      0.00            +5.8        5.81 ±  7%  perf-profile.calltrace.cycles-pp.do_sys_openat2.do_sys_open.do_syscall_64.entry_SYSCALL_64_after_hwframe.__open64_nocancel
      0.00            +5.8        5.81 ±  7%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__open64_nocancel
      0.00            +5.8        5.81 ±  7%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__open64_nocancel
      0.00            +5.8        5.82 ±  7%  perf-profile.calltrace.cycles-pp.__open64_nocancel
      4.44 ± 12%      +5.9       10.34 ±  4%  perf-profile.calltrace.cycles-pp.intel_idle.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry
      5.53 ± 11%      +6.7       12.21 ±  5%  perf-profile.calltrace.cycles-pp.cpuidle_enter.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64
      0.00            +6.7        6.72 ± 13%  perf-profile.calltrace.cycles-pp._raw_spin_lock.lockref_get_not_dead.__legitimize_path.unlazy_walk.complete_walk
      5.33 ± 11%      +6.7       12.05 ±  5%  perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry.start_secondary
      0.00            +6.7        6.72 ± 13%  perf-profile.calltrace.cycles-pp.unlazy_walk.complete_walk.path_openat.do_filp_open.do_sys_openat2
      0.00            +6.7        6.72 ± 13%  perf-profile.calltrace.cycles-pp.__legitimize_path.unlazy_walk.complete_walk.path_openat.do_filp_open
      0.00            +6.7        6.72 ± 13%  perf-profile.calltrace.cycles-pp.lockref_get_not_dead.__legitimize_path.unlazy_walk.complete_walk.path_openat
      0.00            +6.7        6.72 ± 13%  perf-profile.calltrace.cycles-pp.complete_walk.path_openat.do_filp_open.do_sys_openat2.do_sys_open
      6.10 ± 10%      +6.8       12.93 ±  5%  perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64
      6.10 ± 10%      +6.8       12.93 ±  5%  perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.secondary_startup_64
      6.10 ± 10%      +6.8       12.93 ±  5%  perf-profile.calltrace.cycles-pp.start_secondary.secondary_startup_64
      6.17 ± 10%      +6.9       13.07 ±  4%  perf-profile.calltrace.cycles-pp.secondary_startup_64
      1.22 ± 13%      +8.6        9.79 ±  8%  perf-profile.calltrace.cycles-pp.path_openat.do_filp_open.do_sys_openat2.do_sys_open.do_syscall_64
      1.22 ± 13%      +8.6        9.80 ±  8%  perf-profile.calltrace.cycles-pp.do_filp_open.do_sys_openat2.do_sys_open.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00           +12.6       12.57 ±  5%  perf-profile.calltrace.cycles-pp.__cna_queued_spin_lock_slowpath._raw_spin_lock.scan_positives.dcache_readdir.iterate_dir
      1.48 ±  5%     +16.3       17.75 ±  6%  perf-profile.calltrace.cycles-pp.do_execveat_common.__x64_sys_execve.do_syscall_64.entry_SYSCALL_64_after_hwframe.execve
      1.50 ±  5%     +16.3       17.78 ±  6%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.execve
      1.49 ±  5%     +16.3       17.78 ±  6%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.execve
      1.49 ±  5%     +16.3       17.78 ±  6%  perf-profile.calltrace.cycles-pp.__x64_sys_execve.do_syscall_64.entry_SYSCALL_64_after_hwframe.execve
      1.51 ±  5%     +16.3       17.80 ±  6%  perf-profile.calltrace.cycles-pp.execve
      0.00           +16.5       16.49 ±  5%  perf-profile.calltrace.cycles-pp._raw_spin_lock.lockref_get_not_dead.__legitimize_path.unlazy_walk.pick_link
      0.00           +16.5       16.50 ±  5%  perf-profile.calltrace.cycles-pp.unlazy_walk.pick_link.step_into.path_openat.do_filp_open
      0.00           +16.5       16.50 ±  5%  perf-profile.calltrace.cycles-pp.__legitimize_path.unlazy_walk.pick_link.step_into.path_openat
      0.00           +16.5       16.50 ±  5%  perf-profile.calltrace.cycles-pp.lockref_get_not_dead.__legitimize_path.unlazy_walk.pick_link.step_into
      0.00           +16.5       16.50 ±  5%  perf-profile.calltrace.cycles-pp.pick_link.step_into.path_openat.do_filp_open.do_open_execat
      0.00           +16.9       16.87 ±  5%  perf-profile.calltrace.cycles-pp.step_into.path_openat.do_filp_open.do_open_execat.bprm_execve
      0.00           +16.9       16.91 ±  5%  perf-profile.calltrace.cycles-pp.do_filp_open.do_open_execat.bprm_execve.do_execveat_common.__x64_sys_execve
      0.00           +16.9       16.91 ±  5%  perf-profile.calltrace.cycles-pp.path_openat.do_filp_open.do_open_execat.bprm_execve.do_execveat_common
      0.00           +16.9       16.91 ±  5%  perf-profile.calltrace.cycles-pp.do_open_execat.bprm_execve.do_execveat_common.__x64_sys_execve.do_syscall_64
      1.24 ±  6%     +18.0       19.29 ±  4%  perf-profile.calltrace.cycles-pp.bprm_execve.do_execveat_common.__x64_sys_execve.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00           +23.2       23.20 ±  6%  perf-profile.calltrace.cycles-pp.__cna_queued_spin_lock_slowpath._raw_spin_lock.lockref_get_not_dead.__legitimize_path.unlazy_walk
     66.69 ±  2%     -66.7        0.00        perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
     66.88 ±  2%     -52.7       14.20 ±  5%  perf-profile.children.cycles-pp.dcache_readdir
     66.90 ±  2%     -52.7       14.22 ±  5%  perf-profile.children.cycles-pp.__x64_sys_getdents64
     66.90 ±  2%     -52.7       14.22 ±  5%  perf-profile.children.cycles-pp.iterate_dir
     65.76 ±  2%     -52.1       13.63 ±  5%  perf-profile.children.cycles-pp.scan_positives
     67.52 ±  2%     -28.2       39.28 ±  5%  perf-profile.children.cycles-pp._raw_spin_lock
     75.25 ±  2%     -22.2       53.04 ±  3%  perf-profile.children.cycles-pp.do_syscall_64
     75.60 ±  2%     -22.0       53.65 ±  3%  perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.08 ±  5%      +0.0        0.10 ±  7%  perf-profile.children.cycles-pp.update_cfs_group
      0.05            +0.0        0.08 ±  6%  perf-profile.children.cycles-pp.__send_signal
      0.05            +0.0        0.08 ±  5%  perf-profile.children.cycles-pp.__list_del_entry_valid
      0.08 ± 10%      +0.0        0.11 ±  9%  perf-profile.children.cycles-pp.vma_interval_tree_remove
      0.05            +0.0        0.08 ±  5%  perf-profile.children.cycles-pp.__setup_rt_frame
      0.04 ± 57%      +0.0        0.07 ± 15%  perf-profile.children.cycles-pp.restore_sigcontext
      0.04 ± 58%      +0.0        0.08 ± 10%  perf-profile.children.cycles-pp.generic_file_write_iter
      0.06 ± 11%      +0.0        0.10 ± 15%  perf-profile.children.cycles-pp.__x64_sys_rt_sigreturn
      0.04 ± 58%      +0.0        0.08        perf-profile.children.cycles-pp.try_charge
      0.04 ± 57%      +0.0        0.08 ±  6%  perf-profile.children.cycles-pp.rmqueue
      0.07 ± 26%      +0.0        0.11 ±  4%  perf-profile.children.cycles-pp.drm_fb_helper_dirty_work
      0.05 ±  8%      +0.0        0.09 ±  4%  perf-profile.children.cycles-pp._copy_from_user
      0.04 ± 57%      +0.0        0.08 ± 10%  perf-profile.children.cycles-pp.group_send_sig_info
      0.04 ± 57%      +0.0        0.08 ±  5%  perf-profile.children.cycles-pp.__x64_sys_link
      0.04 ± 57%      +0.0        0.08 ±  5%  perf-profile.children.cycles-pp.do_linkat
      0.06 ±  9%      +0.0        0.10 ± 11%  perf-profile.children.cycles-pp.sort_rtns_1
      0.03 ±100%      +0.0        0.07 ±  7%  perf-profile.children.cycles-pp.compar2
      0.03 ±100%      +0.0        0.07 ± 12%  perf-profile.children.cycles-pp.sighandler
      0.07 ±  6%      +0.0        0.11 ±  6%  perf-profile.children.cycles-pp.__check_object_size
      0.05            +0.0        0.09 ±  8%  perf-profile.children.cycles-pp.__local_bh_enable_ip
      0.06 ±  6%      +0.0        0.11 ±  4%  perf-profile.children.cycles-pp.inode_permission
      0.06            +0.0        0.10 ±  8%  perf-profile.children.cycles-pp.entry_SYSCALL_64
      0.16 ±  4%      +0.0        0.20 ±  2%  perf-profile.children.cycles-pp.task_tick_fair
      0.07 ± 10%      +0.0        0.11 ±  4%  perf-profile.children.cycles-pp.alloc_pages_vma
      0.04 ± 57%      +0.0        0.08 ± 27%  perf-profile.children.cycles-pp.rebalance_domains
      0.08 ±  5%      +0.0        0.12 ±  6%  perf-profile.children.cycles-pp.kill_pid_info
      0.07 ±  7%      +0.0        0.11 ±  6%  perf-profile.children.cycles-pp.syscall_return_via_sysret
      0.05            +0.0        0.10 ±  5%  perf-profile.children.cycles-pp.free_pages_and_swap_cache
      0.04 ± 58%      +0.0        0.09 ± 10%  perf-profile.children.cycles-pp.do_notify_parent
      0.05 ±  8%      +0.0        0.10 ± 11%  perf-profile.children.cycles-pp.ima_file_check
      0.05 ±  9%      +0.0        0.10 ±  7%  perf-profile.children.cycles-pp.mem_cgroup_charge
      0.04 ± 57%      +0.0        0.08 ±  5%  perf-profile.children.cycles-pp.copy_page
      0.06 ±  6%      +0.0        0.11 ±  6%  perf-profile.children.cycles-pp.update_load_avg
      0.05 ±  8%      +0.0        0.10 ±  7%  perf-profile.children.cycles-pp.unlock_page
      0.04 ± 57%      +0.0        0.09 ± 17%  perf-profile.children.cycles-pp.mm_init
      0.03 ±100%      +0.0        0.07 ± 15%  perf-profile.children.cycles-pp.copy_user_enhanced_fast_string
      0.03 ±100%      +0.0        0.07 ± 11%  perf-profile.children.cycles-pp.security_task_kill
      0.03 ±100%      +0.0        0.07 ± 11%  perf-profile.children.cycles-pp.apparmor_task_kill
      0.03 ±100%      +0.0        0.07 ±  5%  perf-profile.children.cycles-pp.link
      0.06 ±  7%      +0.0        0.11 ±  8%  perf-profile.children.cycles-pp.security_task_getsecid
      0.07 ±  7%      +0.0        0.11 ±  7%  perf-profile.children.cycles-pp.ip_finish_output2
      0.07 ± 22%      +0.0        0.12 ±  8%  perf-profile.children.cycles-pp.devkmsg_write.cold
      0.07 ± 22%      +0.0        0.12 ±  8%  perf-profile.children.cycles-pp.devkmsg_emit
      0.06 ±  6%      +0.0        0.11 ±  3%  perf-profile.children.cycles-pp.get_arg_page
      0.08 ±  8%      +0.1        0.13 ±  5%  perf-profile.children.cycles-pp.udp_sendmsg
      0.08 ±  5%      +0.1        0.13 ±  6%  perf-profile.children.cycles-pp.kill_something_info
      0.06 ± 11%      +0.1        0.11        perf-profile.children.cycles-pp.finish_task_switch
      0.06 ± 11%      +0.1        0.11 ±  6%  perf-profile.children.cycles-pp.__get_user_pages
      0.07 ± 14%      +0.1        0.12 ± 12%  perf-profile.children.cycles-pp.unlink
      0.04 ± 57%      +0.1        0.09 ±  4%  perf-profile.children.cycles-pp.aa_get_task_label
      0.03 ±100%      +0.1        0.08 ± 10%  perf-profile.children.cycles-pp.__generic_file_write_iter
      0.01 ±173%      +0.1        0.06 ± 13%  perf-profile.children.cycles-pp.wait_task_zombie
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.memmove
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.generic_permission
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.ip_local_deliver
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.arch_get_unmapped_area_topdown
      0.03 ±100%      +0.1        0.08 ±  6%  perf-profile.children.cycles-pp.udp_send_skb
      0.03 ±100%      +0.1        0.08 ±  6%  perf-profile.children.cycles-pp.ip_send_skb
      0.03 ±100%      +0.1        0.08 ±  6%  perf-profile.children.cycles-pp.__slab_alloc
      0.09 ± 28%      +0.1        0.14 ±  8%  perf-profile.children.cycles-pp.propagate_protected_usage
      0.05 ±  9%      +0.1        0.11 ±  8%  perf-profile.children.cycles-pp.apparmor_task_getsecid
      0.07 ±  5%      +0.1        0.12 ±  8%  perf-profile.children.cycles-pp.ip_output
      0.07 ± 10%      +0.1        0.12 ±  6%  perf-profile.children.cycles-pp.simple_lookup
      0.07 ± 12%      +0.1        0.12 ± 10%  perf-profile.children.cycles-pp.sync_regs
      0.06 ± 13%      +0.1        0.11 ±  4%  perf-profile.children.cycles-pp.read
      0.06 ± 11%      +0.1        0.11 ±  3%  perf-profile.children.cycles-pp.__get_user_pages_remote
      0.05 ±  9%      +0.1        0.11 ± 12%  perf-profile.children.cycles-pp.call_rcu
      0.03 ±100%      +0.1        0.08 ±  5%  perf-profile.children.cycles-pp.enqueue_task_fair
      0.09 ±  5%      +0.1        0.14 ±  6%  perf-profile.children.cycles-pp.__x64_sys_kill
      0.07 ± 22%      +0.1        0.13 ±  8%  perf-profile.children.cycles-pp.process_one_work
      0.04 ± 58%      +0.1        0.10 ± 11%  perf-profile.children.cycles-pp.__might_fault
      0.06 ± 13%      +0.1        0.12 ± 13%  perf-profile.children.cycles-pp.rcu_cblist_dequeue
      0.01 ±173%      +0.1        0.07 ±  7%  perf-profile.children.cycles-pp.user_path_at_empty
      0.01 ±173%      +0.1        0.07 ± 13%  perf-profile.children.cycles-pp.get_user_arg_ptr
      0.01 ±173%      +0.1        0.07 ± 17%  perf-profile.children.cycles-pp.perf_iterate_sb
      0.00            +0.1        0.05 ±  8%  perf-profile.children.cycles-pp.tcp_sendmsg
      0.00            +0.1        0.05 ±  8%  perf-profile.children.cycles-pp.pagecache_get_page
      0.00            +0.1        0.05 ±  8%  perf-profile.children.cycles-pp.ip_rcv
      0.00            +0.1        0.05 ±  8%  perf-profile.children.cycles-pp.__wake_up_common
      0.00            +0.1        0.05 ±  8%  perf-profile.children.cycles-pp.do_task_dead
      0.00            +0.1        0.05 ±  8%  perf-profile.children.cycles-pp.mark_page_accessed
      0.07 ± 10%      +0.1        0.12 ±  4%  perf-profile.children.cycles-pp.sched_exec
      0.07 ± 12%      +0.1        0.12 ±  6%  perf-profile.children.cycles-pp.__might_sleep
      0.06 ± 13%      +0.1        0.12 ±  3%  perf-profile.children.cycles-pp.d_add
      0.04 ± 57%      +0.1        0.09 ±  4%  perf-profile.children.cycles-pp.schedule_idle
      0.00            +0.1        0.05 ±  9%  perf-profile.children.cycles-pp.find_get_entry
      0.00            +0.1        0.05 ±  9%  perf-profile.children.cycles-pp.put_cred_rcu
      0.00            +0.1        0.05 ±  9%  perf-profile.children.cycles-pp.__list_add_valid
      0.03 ±100%      +0.1        0.08 ±  8%  perf-profile.children.cycles-pp.__pud_alloc
      0.00            +0.1        0.06 ±  9%  perf-profile.children.cycles-pp.__pagevec_lru_add_fn
      0.00            +0.1        0.06 ±  9%  perf-profile.children.cycles-pp.__vma_link_rb
      0.00            +0.1        0.06 ±  9%  perf-profile.children.cycles-pp.memset_erms
      0.00            +0.1        0.06 ±  9%  perf-profile.children.cycles-pp.read_tsc
      0.08 ± 17%      +0.1        0.14 ±  9%  perf-profile.children.cycles-pp.lockref_put_return
      0.07 ±  6%      +0.1        0.12 ±  4%  perf-profile.children.cycles-pp.wait4
      0.08 ±  6%      +0.1        0.13 ±  6%  perf-profile.children.cycles-pp.do_unlinkat
      0.00            +0.1        0.06 ± 14%  perf-profile.children.cycles-pp.up_read
      0.00            +0.1        0.06 ±  7%  perf-profile.children.cycles-pp.__ip_queue_xmit
      0.00            +0.1        0.06 ±  7%  perf-profile.children.cycles-pp.__netif_receive_skb_one_core
      0.00            +0.1        0.06 ±  7%  perf-profile.children.cycles-pp.put_task_stack
      0.00            +0.1        0.06 ±  7%  perf-profile.children.cycles-pp.common_file_perm
      0.00            +0.1        0.06 ±  7%  perf-profile.children.cycles-pp.alloc_bprm
      0.00            +0.1        0.06 ±  7%  perf-profile.children.cycles-pp.___perf_sw_event
      0.00            +0.1        0.06 ±  7%  perf-profile.children.cycles-pp._raw_spin_lock_irq
      0.03 ±100%      +0.1        0.08 ± 13%  perf-profile.children.cycles-pp.__waitpid
      0.00            +0.1        0.06 ± 14%  perf-profile.children.cycles-pp.native_sched_clock
      0.08 ±  5%      +0.1        0.14 ±  8%  perf-profile.children.cycles-pp.new_sync_read
      0.08 ±  8%      +0.1        0.14 ±  7%  perf-profile.children.cycles-pp.security_file_free
      0.08 ± 14%      +0.1        0.14 ±  6%  perf-profile.children.cycles-pp.apparmor_file_free_security
      0.08 ± 15%      +0.1        0.14 ±  5%  perf-profile.children.cycles-pp.worker_thread
      0.01 ±173%      +0.1        0.07 ± 10%  perf-profile.children.cycles-pp.generic_perform_write
      0.01 ±173%      +0.1        0.07 ± 10%  perf-profile.children.cycles-pp.anon_vma_interval_tree_insert
      0.01 ±173%      +0.1        0.07        perf-profile.children.cycles-pp.setup_arg_pages
      0.01 ±173%      +0.1        0.07 ± 17%  perf-profile.children.cycles-pp.sched_clock_cpu
      0.08 ± 11%      +0.1        0.14 ±  3%  perf-profile.children.cycles-pp.cfree
      0.06 ± 13%      +0.1        0.12 ±  3%  perf-profile.children.cycles-pp.do_truncate
      0.00            +0.1        0.06        perf-profile.children.cycles-pp.process_backlog
      0.00            +0.1        0.06        perf-profile.children.cycles-pp.__x64_sys_munmap
      0.00            +0.1        0.06 ± 11%  perf-profile.children.cycles-pp.__wake_up_common_lock
      0.00            +0.1        0.06        perf-profile.children.cycles-pp.shift_arg_pages
      0.00            +0.1        0.06 ± 11%  perf-profile.children.cycles-pp.sched_clock
      0.04 ± 60%      +0.1        0.10 ±  8%  perf-profile.children.cycles-pp.__pmd_alloc
      0.04 ± 58%      +0.1        0.10 ±  7%  perf-profile.children.cycles-pp.__rb_insert_augmented
      0.03 ±100%      +0.1        0.09 ±  5%  perf-profile.children.cycles-pp.do_softirq
      0.09 ±  5%      +0.1        0.15 ±  7%  perf-profile.children.cycles-pp.ksys_read
      0.08 ±  5%      +0.1        0.14 ±  7%  perf-profile.children.cycles-pp.vfs_read
      0.09 ±  5%      +0.1        0.15 ±  7%  perf-profile.children.cycles-pp.find_vma
      0.08 ± 13%      +0.1        0.14 ± 16%  perf-profile.children.cycles-pp.compar1
      0.01 ±173%      +0.1        0.07 ±  5%  perf-profile.children.cycles-pp.lock_page_memcg
      0.04 ± 59%      +0.1        0.11 ± 21%  perf-profile.children.cycles-pp.get_obj_cgroup_from_current
      0.01 ±173%      +0.1        0.07 ± 11%  perf-profile.children.cycles-pp.vfprintf
      0.04 ± 60%      +0.1        0.10 ±  4%  perf-profile.children.cycles-pp.try_to_wake_up
      0.10 ±  8%      +0.1        0.17 ±  3%  perf-profile.children.cycles-pp.filldir64
      0.10 ±  4%      +0.1        0.16 ±  9%  perf-profile.children.cycles-pp.arch_do_signal
      0.00            +0.1        0.06 ±  6%  perf-profile.children.cycles-pp.inet_recvmsg
      0.00            +0.1        0.06 ±  6%  perf-profile.children.cycles-pp.__memcg_kmem_uncharge_page
      0.00            +0.1        0.06 ±  6%  perf-profile.children.cycles-pp.ttwu_do_activate
      0.00            +0.1        0.06 ±  6%  perf-profile.children.cycles-pp.__legitimize_mnt
      0.00            +0.1        0.06 ± 13%  perf-profile.children.cycles-pp.__put_task_struct
      0.00            +0.1        0.06 ±  6%  perf-profile.children.cycles-pp.mem_cgroup_uncharge_list
      0.08 ± 10%      +0.1        0.15 ±  3%  perf-profile.children.cycles-pp.__get_free_pages
      0.07 ± 11%      +0.1        0.14 ±  6%  perf-profile.children.cycles-pp.up_write
      0.01 ±173%      +0.1        0.08 ± 20%  perf-profile.children.cycles-pp.pgd_alloc
      0.10 ± 14%      +0.1        0.17 ±  5%  perf-profile.children.cycles-pp.memcpy_erms
      0.10 ±  9%      +0.1        0.16 ±  9%  perf-profile.children.cycles-pp.perf_event_mmap
      0.06 ±  7%      +0.1        0.12 ±  6%  perf-profile.children.cycles-pp.security_file_open
      0.06 ±  7%      +0.1        0.12 ±  6%  perf-profile.children.cycles-pp.apparmor_file_open
      0.07 ±  7%      +0.1        0.13 ±  7%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      0.05            +0.1        0.12 ± 13%  perf-profile.children.cycles-pp.update_sd_lb_stats
      0.00            +0.1        0.07 ±  7%  perf-profile.children.cycles-pp.__tcp_transmit_skb
      0.00            +0.1        0.07 ±  7%  perf-profile.children.cycles-pp.net_rx_action
      0.00            +0.1        0.07 ±  7%  perf-profile.children.cycles-pp.flush_tlb_mm_range
      0.00            +0.1        0.07 ±  7%  perf-profile.children.cycles-pp.get_unmapped_area
      0.00            +0.1        0.07 ±  7%  perf-profile.children.cycles-pp._raw_spin_trylock
      0.00            +0.1        0.07 ±  7%  perf-profile.children.cycles-pp._raw_spin_unlock_irqrestore
      0.08 ±  5%      +0.1        0.14 ±  5%  perf-profile.children.cycles-pp.__pte_alloc
      0.04 ± 58%      +0.1        0.11 ±  7%  perf-profile.children.cycles-pp.pagevec_lru_move_fn
      0.05            +0.1        0.12 ± 11%  perf-profile.children.cycles-pp.find_busiest_group
      0.04 ± 57%      +0.1        0.11 ± 13%  perf-profile.children.cycles-pp.vm_area_alloc
      0.07 ± 13%      +0.1        0.13 ±  3%  perf-profile.children.cycles-pp.page_add_file_rmap
      0.01 ±173%      +0.1        0.08 ±  8%  perf-profile.children.cycles-pp.copy_string_kernel
      0.00            +0.1        0.07 ±  6%  perf-profile.children.cycles-pp.copy_user_generic_unrolled
      0.00            +0.1        0.07 ±  6%  perf-profile.children.cycles-pp.notify_change
      0.00            +0.1        0.07 ± 12%  perf-profile.children.cycles-pp.fput_many
      0.10 ± 11%      +0.1        0.17 ±  3%  perf-profile.children.cycles-pp.wake_up_new_task
      0.07 ± 12%      +0.1        0.14 ±  9%  perf-profile.children.cycles-pp.__mod_memcg_state
      0.09 ±  9%      +0.1        0.16 ±  9%  perf-profile.children.cycles-pp.__dentry_kill
      0.03 ±100%      +0.1        0.10 ±  8%  perf-profile.children.cycles-pp.lru_add_drain_cpu
      0.01 ±173%      +0.1        0.08 ± 10%  perf-profile.children.cycles-pp.__libc_calloc
      0.00            +0.1        0.07        perf-profile.children.cycles-pp.enqueue_entity
      0.00            +0.1        0.07 ± 10%  perf-profile.children.cycles-pp.copy_fpstate_to_sigframe
      0.00            +0.1        0.07 ± 14%  perf-profile.children.cycles-pp.update_rq_clock
      0.08 ± 10%      +0.1        0.15 ±  7%  perf-profile.children.cycles-pp.down_read
      0.11 ±  7%      +0.1        0.18 ±  9%  perf-profile.children.cycles-pp.apparmor_file_alloc_security
      0.07 ± 12%      +0.1        0.14 ±  7%  perf-profile.children.cycles-pp.create_elf_tables
      0.03 ±100%      +0.1        0.10 ±  7%  perf-profile.children.cycles-pp.lru_add_drain
      0.00            +0.1        0.07 ±  5%  perf-profile.children.cycles-pp.sock_read_iter
      0.00            +0.1        0.07 ±  5%  perf-profile.children.cycles-pp.__perf_sw_event
      0.00            +0.1        0.07 ± 15%  perf-profile.children.cycles-pp.do_faccessat
      0.07 ± 26%      +0.1        0.15 ±  8%  perf-profile.children.cycles-pp.serial8250_console_write
      0.01 ±173%      +0.1        0.09 ±  9%  perf-profile.children.cycles-pp.time
      0.00            +0.1        0.08 ±  6%  perf-profile.children.cycles-pp.___slab_alloc
      0.05            +0.1        0.13 ± 11%  perf-profile.children.cycles-pp.pick_next_task_fair
      0.00            +0.1        0.08 ± 19%  perf-profile.children.cycles-pp.__anon_vma_prepare
      0.07 ±  7%      +0.1        0.14 ±  7%  perf-profile.children.cycles-pp.__slab_free
      0.09 ±  7%      +0.1        0.17 ±  4%  perf-profile.children.cycles-pp.strnlen_user
      0.07 ± 25%      +0.1        0.14 ± 11%  perf-profile.children.cycles-pp.uart_console_write
      0.11 ±  7%      +0.1        0.19 ± 11%  perf-profile.children.cycles-pp.strncpy_from_user
      0.05 ± 63%      +0.1        0.13 ± 12%  perf-profile.children.cycles-pp.serial8250_console_putchar
      0.04 ±102%      +0.1        0.12 ±  7%  perf-profile.children.cycles-pp.io_serial_in
      0.00            +0.1        0.08 ±  8%  perf-profile.children.cycles-pp.__put_anon_vma
      0.11 ±  6%      +0.1        0.19 ±  5%  perf-profile.children.cycles-pp.sock_sendmsg
      0.00            +0.1        0.08 ±  8%  perf-profile.children.cycles-pp.file_free_rcu
      0.18 ±  4%      +0.1        0.26 ±  7%  perf-profile.children.cycles-pp.native_irq_return_iret
      0.13 ±  8%      +0.1        0.21 ±  3%  perf-profile.children.cycles-pp.wp_page_copy
      0.10 ± 21%      +0.1        0.18 ±  8%  perf-profile.children.cycles-pp.vprintk_emit
      0.08 ± 26%      +0.1        0.17 ±  7%  perf-profile.children.cycles-pp.console_unlock
      0.11 ±  6%      +0.1        0.19 ±  4%  perf-profile.children.cycles-pp.sock_write_iter
      0.11 ±  7%      +0.1        0.20 ±  5%  perf-profile.children.cycles-pp.__mmap
      0.01 ±173%      +0.1        0.10 ± 23%  perf-profile.children.cycles-pp.path_init
      0.10 ± 13%      +0.1        0.18 ±  8%  perf-profile.children.cycles-pp.__vm_munmap
      0.12 ± 10%      +0.1        0.21 ±  7%  perf-profile.children.cycles-pp.__close
      0.10 ±  5%      +0.1        0.18 ± 10%  perf-profile.children.cycles-pp.do_wait
      0.00            +0.1        0.09 ±  9%  perf-profile.children.cycles-pp.__do_fault
      0.00            +0.1        0.09 ± 31%  perf-profile.children.cycles-pp.rcu_sched_clock_irq
      0.05 ± 63%      +0.1        0.14 ± 12%  perf-profile.children.cycles-pp.wait_for_xmitr
      0.10 ± 10%      +0.1        0.19 ±  4%  perf-profile.children.cycles-pp.pte_alloc_one
      0.07 ±  7%      +0.1        0.15 ± 10%  perf-profile.children.cycles-pp.schedule
      0.15 ± 12%      +0.1        0.23 ±  4%  perf-profile.children.cycles-pp.__memcg_kmem_charge_page
      0.14 ±  8%      +0.1        0.23 ±  8%  perf-profile.children.cycles-pp.security_file_alloc
      0.07 ± 11%      +0.1        0.16 ± 26%  perf-profile.children.cycles-pp.__lock_parent
      0.00            +0.1        0.09 ± 26%  perf-profile.children.cycles-pp.lockref_get
      0.10 ±  4%      +0.1        0.19 ±  9%  perf-profile.children.cycles-pp.__do_sys_wait4
      0.10 ±  4%      +0.1        0.19 ±  9%  perf-profile.children.cycles-pp.kernel_wait4
      0.12 ±  3%      +0.1        0.22 ±  3%  perf-profile.children.cycles-pp.copy_pte_range
      0.10 ± 12%      +0.1        0.20 ±  5%  perf-profile.children.cycles-pp.__mod_memcg_lruvec_state
      0.12 ± 13%      +0.1        0.21 ±  3%  perf-profile.children.cycles-pp.__d_lookup_rcu
      0.10 ±  9%      +0.1        0.19 ±  7%  perf-profile.children.cycles-pp.clear_page_erms
      0.14 ± 10%      +0.1        0.24 ±  7%  perf-profile.children.cycles-pp.obj_cgroup_charge
      0.14 ±  7%      +0.1        0.23 ±  2%  perf-profile.children.cycles-pp.find_idlest_group
      0.15 ±  8%      +0.1        0.25 ±  9%  perf-profile.children.cycles-pp.vma_interval_tree_insert
      0.10 ± 14%      +0.1        0.20 ± 11%  perf-profile.children.cycles-pp.__d_alloc
      0.06 ±  6%      +0.1        0.16 ± 15%  perf-profile.children.cycles-pp.load_balance
      0.26 ±  4%      +0.1        0.35 ±  6%  perf-profile.children.cycles-pp.scheduler_tick
      0.11 ±  8%      +0.1        0.21 ±  5%  perf-profile.children.cycles-pp.prep_new_page
      0.11 ± 14%      +0.1        0.21 ±  5%  perf-profile.children.cycles-pp.down_write
      0.01 ±173%      +0.1        0.11 ± 41%  perf-profile.children.cycles-pp.irq_enter_rcu
      0.11 ± 13%      +0.1        0.21 ±  9%  perf-profile.children.cycles-pp.anon_vma_clone
      0.09 ±  5%      +0.1        0.19 ±  4%  perf-profile.children.cycles-pp.__clear_user
      0.15 ±  5%      +0.1        0.25 ±  9%  perf-profile.children.cycles-pp.getname_flags
      0.15 ±  7%      +0.1        0.25        perf-profile.children.cycles-pp.do_wp_page
      0.11 ±  7%      +0.1        0.21 ±  6%  perf-profile.children.cycles-pp.rwsem_spin_on_owner
      0.14 ± 11%      +0.1        0.24 ±  3%  perf-profile.children.cycles-pp.___might_sleep
      0.17 ± 14%      +0.1        0.28 ± 11%  perf-profile.children.cycles-pp.kill
      0.16 ±  7%      +0.1        0.27 ±  2%  perf-profile.children.cycles-pp.select_task_rq_fair
      0.10 ± 12%      +0.1        0.21 ± 10%  perf-profile.children.cycles-pp.vm_area_dup
      0.13 ±  8%      +0.1        0.25 ±  5%  perf-profile.children.cycles-pp.malloc
      0.00            +0.1        0.11 ± 13%  perf-profile.children.cycles-pp.newidle_balance
      0.19 ± 12%      +0.1        0.30 ±  3%  perf-profile.children.cycles-pp.page_counter_try_charge
      0.12 ±  6%      +0.1        0.24 ±  6%  perf-profile.children.cycles-pp.alloc_set_pte
      0.14 ±  8%      +0.1        0.26 ±  4%  perf-profile.children.cycles-pp.do_anonymous_page
      0.16 ±  6%      +0.1        0.28 ±  4%  perf-profile.children.cycles-pp.copy_strings
      0.17 ±  6%      +0.1        0.30 ± 16%  perf-profile.children.cycles-pp.__fput
      0.21 ± 10%      +0.1        0.34 ±  3%  perf-profile.children.cycles-pp.__memcg_kmem_charge
      0.16 ±  7%      +0.1        0.30 ±  2%  perf-profile.children.cycles-pp.get_page_from_freelist
      0.12 ± 13%      +0.1        0.27 ± 10%  perf-profile.children.cycles-pp.remove_vma
      0.12 ±  5%      +0.1        0.26 ± 11%  perf-profile.children.cycles-pp.do_dentry_open
      0.16 ±  9%      +0.1        0.30 ±  4%  perf-profile.children.cycles-pp.page_remove_rmap
      0.19 ±  5%      +0.1        0.34 ±  4%  perf-profile.children.cycles-pp.copy_page_range
      0.15 ± 14%      +0.1        0.30 ±  8%  perf-profile.children.cycles-pp.anon_vma_fork
      0.17 ± 11%      +0.2        0.33 ±  6%  perf-profile.children.cycles-pp.terminate_walk
      0.20 ±  6%      +0.2        0.35 ±  3%  perf-profile.children.cycles-pp.release_pages
      0.22 ± 15%      +0.2        0.38 ±  5%  perf-profile.children.cycles-pp.write
      0.15 ±  7%      +0.2        0.31 ±  8%  perf-profile.children.cycles-pp.__sched_text_start
      0.17 ±  9%      +0.2        0.34 ±  6%  perf-profile.children.cycles-pp.__xstat64
      0.23 ±  3%      +0.2        0.41 ±  2%  perf-profile.children.cycles-pp.new_sync_write
      0.23 ±  6%      +0.2        0.40 ± 14%  perf-profile.children.cycles-pp.task_work_run
      0.18 ±  8%      +0.2        0.36 ±  5%  perf-profile.children.cycles-pp.load_elf_interp
      0.26 ±  3%      +0.2        0.43 ±  3%  perf-profile.children.cycles-pp.ksys_write
      0.25 ±  2%      +0.2        0.43 ±  2%  perf-profile.children.cycles-pp.vfs_write
      0.16 ± 18%      +0.2        0.34 ± 10%  perf-profile.children.cycles-pp.unlink_anon_vmas
      0.21 ±  6%      +0.2        0.40 ±  4%  perf-profile.children.cycles-pp._dl_addr
      0.26 ± 18%      +0.2        0.44 ±  3%  perf-profile.children.cycles-pp.__memcg_kmem_uncharge
      0.17 ± 18%      +0.2        0.36 ± 10%  perf-profile.children.cycles-pp.unmap_region
      0.23 ±  8%      +0.2        0.42 ±  9%  perf-profile.children.cycles-pp.mprotect_fixup
      0.24 ±  6%      +0.2        0.45 ±  2%  perf-profile.children.cycles-pp.tlb_flush_mmu
      0.24 ±  7%      +0.2        0.44 ±  8%  perf-profile.children.cycles-pp.do_mprotect_pkey
      0.23 ± 10%      +0.2        0.43 ±  8%  perf-profile.children.cycles-pp.d_alloc
      0.24 ±  7%      +0.2        0.44 ±  9%  perf-profile.children.cycles-pp.__x64_sys_mprotect
      0.25 ±  5%      +0.2        0.45 ±  2%  perf-profile.children.cycles-pp.tlb_finish_mmu
      0.22 ± 11%      +0.2        0.43 ±  5%  perf-profile.children.cycles-pp.elf_map
      0.36 ±  2%      +0.2        0.57 ± 13%  perf-profile.children.cycles-pp.tick_sched_handle
      0.36 ±  2%      +0.2        0.57 ± 13%  perf-profile.children.cycles-pp.update_process_times
      0.42            +0.2        0.64 ± 11%  perf-profile.children.cycles-pp.tick_sched_timer
      0.00            +0.2        0.23 ±  4%  perf-profile.children.cycles-pp.cna_order_queue
      0.19 ± 19%      +0.2        0.42 ±  6%  perf-profile.children.cycles-pp.__x64_sys_sync
      0.19 ± 19%      +0.2        0.42 ±  6%  perf-profile.children.cycles-pp.ksys_sync
      0.19 ± 18%      +0.2        0.42 ±  6%  perf-profile.children.cycles-pp.sync
      0.18 ± 20%      +0.2        0.41 ±  7%  perf-profile.children.cycles-pp.iterate_supers
      0.34 ±  5%      +0.2        0.57 ±  9%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      0.33 ±  4%      +0.2        0.57 ± 10%  perf-profile.children.cycles-pp.exit_to_user_mode_prepare
      0.31 ±  8%      +0.2        0.55        perf-profile.children.cycles-pp.__alloc_pages_nodemask
      0.26 ± 16%      +0.3        0.51 ±  8%  perf-profile.children.cycles-pp.vma_link
      0.29 ±  6%      +0.3        0.54 ±  4%  perf-profile.children.cycles-pp.setlocale
      0.23 ± 11%      +0.3        0.50 ±  5%  perf-profile.children.cycles-pp.lookup_fast
      0.31 ± 15%      +0.3        0.60 ± 13%  perf-profile.children.cycles-pp.__vma_adjust
      0.34 ± 10%      +0.3        0.64 ±  8%  perf-profile.children.cycles-pp.__alloc_file
      0.54 ±  2%      +0.3        0.84 ± 16%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      0.35 ±  9%      +0.3        0.65 ±  8%  perf-profile.children.cycles-pp.alloc_empty_file
      0.35 ± 14%      +0.3        0.67 ± 12%  perf-profile.children.cycles-pp.__split_vma
      0.47 ±  6%      +0.3        0.80 ±  6%  perf-profile.children.cycles-pp.zap_pte_range
      0.40 ±  7%      +0.3        0.74 ±  6%  perf-profile.children.cycles-pp.d_alloc_parallel
      0.50 ±  7%      +0.4        0.85 ±  6%  perf-profile.children.cycles-pp.unmap_page_range
      0.37 ± 17%      +0.4        0.73 ± 10%  perf-profile.children.cycles-pp.__do_munmap
      0.85 ±  4%      +0.4        1.22 ± 12%  perf-profile.children.cycles-pp.hrtimer_interrupt
      0.53 ±  7%      +0.4        0.90 ±  6%  perf-profile.children.cycles-pp.unmap_vmas
      0.43 ± 18%      +0.4        0.80        perf-profile.children.cycles-pp.page_counter_cancel
      0.45 ±  7%      +0.4        0.82 ±  4%  perf-profile.children.cycles-pp.__lookup_slow
      0.86 ±  4%      +0.4        1.24 ± 12%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      0.44 ± 18%      +0.4        0.82        perf-profile.children.cycles-pp.page_counter_uncharge
      0.37 ± 27%      +0.4        0.77 ± 13%  perf-profile.children.cycles-pp.unlink_file_vma
      0.48 ± 11%      +0.4        0.89 ±  8%  perf-profile.children.cycles-pp.__libc_fork
      0.51 ±  9%      +0.4        0.94 ±  9%  perf-profile.children.cycles-pp.mem_rtns_1
      0.49 ±  9%      +0.4        0.92 ±  3%  perf-profile.children.cycles-pp.path_lookupat
      0.50 ±  8%      +0.4        0.94 ±  3%  perf-profile.children.cycles-pp.filename_lookup
      0.70 ± 14%      +0.4        1.15 ±  6%  perf-profile.children.cycles-pp.div_short
      0.53 ±  8%      +0.5        0.99 ±  3%  perf-profile.children.cycles-pp.__do_sys_newstat
      0.53 ±  8%      +0.5        0.98 ±  4%  perf-profile.children.cycles-pp.vfs_statx
      0.61 ± 13%      +0.5        1.07 ±  6%  perf-profile.children.cycles-pp.div_int
      0.42 ±  2%      +0.5        0.88 ± 10%  perf-profile.children.cycles-pp.lockref_put_or_lock
      0.60 ±  6%      +0.5        1.08 ±  3%  perf-profile.children.cycles-pp.filemap_map_pages
      0.44 ± 20%      +0.5        0.98 ±  5%  perf-profile.children.cycles-pp.drain_obj_stock
      0.68 ± 12%      +0.6        1.23 ±  7%  perf-profile.children.cycles-pp.add_short
      0.61 ± 15%      +0.6        1.18 ± 11%  perf-profile.children.cycles-pp.ksys_mmap_pgoff
      0.55 ± 13%      +0.6        1.13 ± 13%  perf-profile.children.cycles-pp.kmem_cache_alloc
      0.69 ±  6%      +0.6        1.28 ±  3%  perf-profile.children.cycles-pp.do_fault
      0.61 ± 14%      +0.6        1.20 ±  5%  perf-profile.children.cycles-pp.creat64
      0.65 ±  7%      +0.6        1.25 ±  6%  perf-profile.children.cycles-pp.begin_new_exec
      0.63 ± 12%      +0.6        1.23 ±  7%  perf-profile.children.cycles-pp.dup_mmap
      0.57 ± 18%      +0.6        1.19 ±  9%  perf-profile.children.cycles-pp.free_pgtables
      0.66 ± 12%      +0.6        1.29 ±  7%  perf-profile.children.cycles-pp.dup_mm
      0.68 ± 14%      +0.7        1.34 ± 10%  perf-profile.children.cycles-pp.mmap_region
      0.73 ± 13%      +0.7        1.42 ±  9%  perf-profile.children.cycles-pp.do_mmap
      0.77 ± 12%      +0.7        1.48 ±  9%  perf-profile.children.cycles-pp.vm_mmap_pgoff
      0.89 ±  3%      +0.7        1.60 ±  8%  perf-profile.children.cycles-pp.dput
      0.53 ± 20%      +0.7        1.26 ±  6%  perf-profile.children.cycles-pp.refill_obj_stock
      0.55 ± 36%      +0.7        1.29 ± 16%  perf-profile.children.cycles-pp.osq_lock
      0.91 ±  8%      +0.8        1.68 ±  5%  perf-profile.children.cycles-pp.do_exit
      0.91 ±  8%      +0.8        1.69 ±  5%  perf-profile.children.cycles-pp.__x64_sys_exit_group
      0.91 ±  8%      +0.8        1.69 ±  5%  perf-profile.children.cycles-pp.do_group_exit
      0.90 ±  8%      +0.8        1.68 ±  7%  perf-profile.children.cycles-pp.__strcat_chk
      0.43 ± 19%      +0.8        1.22 ± 13%  perf-profile.children.cycles-pp.irq_exit_rcu
      0.85 ± 10%      +0.8        1.64 ±  7%  perf-profile.children.cycles-pp.copy_process
      0.46 ± 18%      +0.8        1.26 ± 13%  perf-profile.children.cycles-pp.do_softirq_own_stack
      0.95 ±  7%      +0.8        1.79 ±  5%  perf-profile.children.cycles-pp.link_path_walk
      0.94 ±  7%      +0.8        1.78 ±  5%  perf-profile.children.cycles-pp.walk_component
      0.96 ± 10%      +0.9        1.82 ±  7%  perf-profile.children.cycles-pp.__do_sys_clone
      0.96 ± 10%      +0.9        1.82 ±  7%  perf-profile.children.cycles-pp._do_fork
      0.69 ± 30%      +0.9        1.56 ± 13%  perf-profile.children.cycles-pp.rwsem_optimistic_spin
      1.08 ±  5%      +0.9        1.97 ±  2%  perf-profile.children.cycles-pp.__handle_mm_fault
      0.71 ± 29%      +0.9        1.59 ± 14%  perf-profile.children.cycles-pp.rwsem_down_write_slowpath
      1.14 ±  5%      +0.9        2.08 ±  2%  perf-profile.children.cycles-pp.handle_mm_fault
      1.24 ±  5%      +1.0        2.25 ±  2%  perf-profile.children.cycles-pp.do_user_addr_fault
      1.41 ± 13%      +1.0        2.42 ±  5%  perf-profile.children.cycles-pp.div_long
      1.25 ±  5%      +1.0        2.26 ±  2%  perf-profile.children.cycles-pp.exc_page_fault
      1.15 ±  8%      +1.1        2.21 ±  5%  perf-profile.children.cycles-pp.load_elf_binary
      1.32 ±  5%      +1.1        2.39 ±  2%  perf-profile.children.cycles-pp.asm_exc_page_fault
      1.16 ±  8%      +1.1        2.24 ±  5%  perf-profile.children.cycles-pp.exec_binprm
      1.52 ± 13%      +1.1        2.60 ±  6%  perf-profile.children.cycles-pp.add_long
      1.52 ± 13%      +1.1        2.63 ±  7%  perf-profile.children.cycles-pp.add_int
      1.22 ±  9%      +1.1        2.33 ±  6%  perf-profile.children.cycles-pp.asm_call_on_stack
      1.34 ±  8%      +1.2        2.52 ±  6%  perf-profile.children.cycles-pp.exit_mmap
      1.34 ±  8%      +1.2        2.53 ±  6%  perf-profile.children.cycles-pp.mmput
      1.65 ±  8%      +1.2        2.89 ±  5%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
      1.40 ±  8%      +1.3        2.66 ±  7%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      0.65 ± 26%      +1.3        1.96 ± 22%  perf-profile.children.cycles-pp.run_ksoftirqd
      0.66 ± 26%      +1.3        1.99 ± 21%  perf-profile.children.cycles-pp.smpboot_thread_fn
      1.65 ±  8%      +1.3        3.00 ±  6%  perf-profile.children.cycles-pp.__strncat_chk
      0.74 ± 24%      +1.4        2.13 ± 20%  perf-profile.children.cycles-pp.kthread
      0.78 ± 23%      +1.4        2.18 ± 20%  perf-profile.children.cycles-pp.ret_from_fork
      0.97 ± 24%      +2.0        2.97 ± 20%  perf-profile.children.cycles-pp.rcu_do_batch
      0.98 ± 25%      +2.0        2.99 ± 20%  perf-profile.children.cycles-pp.rcu_core
      1.10 ± 23%      +2.1        3.22 ± 18%  perf-profile.children.cycles-pp.__softirqentry_text_start
      1.07 ± 25%      +2.1        3.19 ± 21%  perf-profile.children.cycles-pp.kmem_cache_free
      5.45 ±  9%      +4.4        9.88 ±  6%  perf-profile.children.cycles-pp.string_rtns_1
      0.22 ±  5%      +5.9        6.09 ±  7%  perf-profile.children.cycles-pp.__open64_nocancel
      4.49 ± 12%      +6.0       10.45 ±  4%  perf-profile.children.cycles-pp.intel_idle
      5.59 ± 11%      +6.8       12.35 ±  4%  perf-profile.children.cycles-pp.cpuidle_enter_state
      5.59 ± 11%      +6.8       12.35 ±  4%  perf-profile.children.cycles-pp.cpuidle_enter
      6.10 ± 10%      +6.8       12.93 ±  5%  perf-profile.children.cycles-pp.start_secondary
      0.00            +6.9        6.88 ± 12%  perf-profile.children.cycles-pp.complete_walk
      6.17 ± 10%      +6.9       13.07 ±  4%  perf-profile.children.cycles-pp.secondary_startup_64
      6.17 ± 10%      +6.9       13.07 ±  4%  perf-profile.children.cycles-pp.cpu_startup_entry
      6.17 ± 10%      +6.9       13.07 ±  4%  perf-profile.children.cycles-pp.do_idle
      1.79 ±  7%      +8.5       10.31 ±  8%  perf-profile.children.cycles-pp.do_sys_openat2
      1.80 ±  7%      +8.5       10.32 ±  8%  perf-profile.children.cycles-pp.do_sys_open
      1.51 ±  5%     +16.3       17.80 ±  6%  perf-profile.children.cycles-pp.execve
      0.12 ±  6%     +16.4       16.57 ±  5%  perf-profile.children.cycles-pp.pick_link
      0.16 ±  5%     +16.8       16.96 ±  5%  perf-profile.children.cycles-pp.do_open_execat
      0.37 ±  5%     +17.0       17.34 ±  5%  perf-profile.children.cycles-pp.step_into
      1.40 ±  7%     +17.9       19.33 ±  4%  perf-profile.children.cycles-pp.bprm_execve
      1.66 ±  7%     +18.1       19.80 ±  3%  perf-profile.children.cycles-pp.do_execveat_common
      1.68 ±  7%     +18.2       19.83 ±  3%  perf-profile.children.cycles-pp.__x64_sys_execve
      0.26 ±  5%     +23.5       23.73 ±  6%  perf-profile.children.cycles-pp.lockref_get_not_dead
      0.28 ±  7%     +23.5       23.77 ±  6%  perf-profile.children.cycles-pp.__legitimize_path
      0.29 ±  8%     +23.5       23.79 ±  6%  perf-profile.children.cycles-pp.unlazy_walk
      1.80 ±  6%     +25.2       26.99 ±  5%  perf-profile.children.cycles-pp.path_openat
      1.81 ±  6%     +25.2       27.00 ±  5%  perf-profile.children.cycles-pp.do_filp_open
      0.00           +38.1       38.12 ±  5%  perf-profile.children.cycles-pp.__cna_queued_spin_lock_slowpath
     66.22 ±  2%     -66.2        0.00        perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
      0.13 ±  3%      -0.1        0.04 ± 58%  perf-profile.self.cycles-pp.scan_positives
      0.08 ±  5%      +0.0        0.10 ±  7%  perf-profile.self.cycles-pp.update_cfs_group
      0.07 ± 10%      +0.0        0.10 ± 11%  perf-profile.self.cycles-pp.ktime_get_update_offsets_now
      0.08 ± 10%      +0.0        0.11 ±  9%  perf-profile.self.cycles-pp.vma_interval_tree_remove
      0.06 ±  9%      +0.0        0.10 ± 11%  perf-profile.self.cycles-pp.sort_rtns_1
      0.06            +0.0        0.10        perf-profile.self.cycles-pp.copy_pte_range
      0.04 ± 57%      +0.0        0.08 ±  5%  perf-profile.self.cycles-pp.__list_del_entry_valid
      0.05 ±  8%      +0.0        0.10 ±  5%  perf-profile.self.cycles-pp.unlock_page
      0.06 ±  6%      +0.0        0.11 ± 10%  perf-profile.self.cycles-pp.__handle_mm_fault
      0.05 ±  8%      +0.0        0.10 ±  4%  perf-profile.self.cycles-pp.d_alloc_parallel
      0.04 ± 57%      +0.0        0.08 ± 10%  perf-profile.self.cycles-pp.find_vma
      0.05            +0.0        0.10 ± 11%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.06 ± 11%      +0.0        0.11 ±  8%  perf-profile.self.cycles-pp.link_path_walk
      0.04 ± 57%      +0.0        0.08 ±  5%  perf-profile.self.cycles-pp.copy_page
      0.08 ±  5%      +0.0        0.12 ±  4%  perf-profile.self.cycles-pp.filldir64
      0.06 ±  6%      +0.0        0.11 ±  6%  perf-profile.self.cycles-pp.syscall_return_via_sysret
      0.09 ± 26%      +0.0        0.14 ±  8%  perf-profile.self.cycles-pp.propagate_protected_usage
      0.04 ± 58%      +0.0        0.09 ±  7%  perf-profile.self.cycles-pp.__rb_insert_augmented
      0.04 ± 57%      +0.1        0.09 ±  4%  perf-profile.self.cycles-pp.aa_get_task_label
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.handle_mm_fault
      0.04 ± 58%      +0.1        0.09 ± 14%  perf-profile.self.cycles-pp.obj_cgroup_charge
      0.06 ±  7%      +0.1        0.11 ±  7%  perf-profile.self.cycles-pp.__might_sleep
      0.07 ±  7%      +0.1        0.12 ±  7%  perf-profile.self.cycles-pp.sync_regs
      0.06 ± 13%      +0.1        0.12 ± 13%  perf-profile.self.cycles-pp.rcu_cblist_dequeue
      0.01 ±173%      +0.1        0.07 ± 17%  perf-profile.self.cycles-pp.copy_user_enhanced_fast_string
      0.01 ±173%      +0.1        0.07 ±  7%  perf-profile.self.cycles-pp.strncpy_from_user
      0.01 ±173%      +0.1        0.07 ±  7%  perf-profile.self.cycles-pp.compar2
      0.00            +0.1        0.05 ±  8%  perf-profile.self.cycles-pp.mmap_region
      0.00            +0.1        0.05 ±  8%  perf-profile.self.cycles-pp.__mod_memcg_lruvec_state
      0.00            +0.1        0.05 ±  8%  perf-profile.self.cycles-pp.copy_user_generic_unrolled
      0.00            +0.1        0.05 ±  8%  perf-profile.self.cycles-pp.common_file_perm
      0.00            +0.1        0.05 ±  8%  perf-profile.self.cycles-pp.__vma_link_rb
      0.00            +0.1        0.05 ±  8%  perf-profile.self.cycles-pp.memset_erms
      0.00            +0.1        0.05 ±  8%  perf-profile.self.cycles-pp.native_sched_clock
      0.00            +0.1        0.05 ±  8%  perf-profile.self.cycles-pp.__list_add_valid
      0.06 ±  7%      +0.1        0.11 ±  3%  perf-profile.self.cycles-pp.apparmor_file_open
      0.00            +0.1        0.05 ±  9%  perf-profile.self.cycles-pp.up_read
      0.07 ± 14%      +0.1        0.13 ±  5%  perf-profile.self.cycles-pp.apparmor_file_free_security
      0.08 ± 17%      +0.1        0.14 ±  9%  perf-profile.self.cycles-pp.lockref_put_return
      0.04 ± 57%      +0.1        0.09 ±  8%  perf-profile.self.cycles-pp.free_pages_and_swap_cache
      0.04 ± 57%      +0.1        0.10 ± 10%  perf-profile.self.cycles-pp.cfree
      0.07 ± 11%      +0.1        0.13 ±  5%  perf-profile.self.cycles-pp.down_read
      0.00            +0.1        0.06 ±  7%  perf-profile.self.cycles-pp.update_load_avg
      0.00            +0.1        0.06 ±  7%  perf-profile.self.cycles-pp.try_charge
      0.00            +0.1        0.06 ±  7%  perf-profile.self.cycles-pp.inode_permission
      0.08 ± 13%      +0.1        0.14 ± 19%  perf-profile.self.cycles-pp.compar1
      0.01 ±173%      +0.1        0.07 ± 10%  perf-profile.self.cycles-pp.anon_vma_interval_tree_insert
      0.01 ±173%      +0.1        0.07        perf-profile.self.cycles-pp.lock_page_memcg
      0.00            +0.1        0.06        perf-profile.self.cycles-pp.__legitimize_mnt
      0.00            +0.1        0.06 ± 16%  perf-profile.self.cycles-pp.vm_area_dup
      0.07 ± 11%      +0.1        0.14 ±  3%  perf-profile.self.cycles-pp.up_write
      0.08 ± 10%      +0.1        0.14 ±  5%  perf-profile.self.cycles-pp.strnlen_user
      0.00            +0.1        0.07 ±  7%  perf-profile.self.cycles-pp.entry_SYSCALL_64
      0.00            +0.1        0.07 ±  7%  perf-profile.self.cycles-pp._raw_spin_trylock
      0.10 ± 15%      +0.1        0.17 ±  5%  perf-profile.self.cycles-pp.memcpy_erms
      0.03 ±100%      +0.1        0.09 ±  4%  perf-profile.self.cycles-pp.page_add_file_rmap
      0.07 ±  7%      +0.1        0.14 ± 11%  perf-profile.self.cycles-pp.__slab_free
      0.07 ± 12%      +0.1        0.14 ±  9%  perf-profile.self.cycles-pp.__mod_memcg_state
      0.10 ± 10%      +0.1        0.18 ±  8%  perf-profile.self.cycles-pp.apparmor_file_alloc_security
      0.00            +0.1        0.07 ± 15%  perf-profile.self.cycles-pp.file_free_rcu
      0.01 ±173%      +0.1        0.09 ±  9%  perf-profile.self.cycles-pp.__alloc_file
      0.00            +0.1        0.08 ± 20%  perf-profile.self.cycles-pp.alloc_set_pte
      0.09 ± 14%      +0.1        0.17 ±  8%  perf-profile.self.cycles-pp.down_write
      0.00            +0.1        0.08 ± 10%  perf-profile.self.cycles-pp.__libc_calloc
      0.04 ±102%      +0.1        0.12 ±  7%  perf-profile.self.cycles-pp.io_serial_in
      0.12 ±  6%      +0.1        0.20 ±  2%  perf-profile.self.cycles-pp.find_idlest_group
      0.18 ±  4%      +0.1        0.26 ±  7%  perf-profile.self.cycles-pp.native_irq_return_iret
      0.00            +0.1        0.08 ± 27%  perf-profile.self.cycles-pp.rcu_sched_clock_irq
      0.15 ±  8%      +0.1        0.24 ± 10%  perf-profile.self.cycles-pp.vma_interval_tree_insert
      0.00            +0.1        0.09 ±  7%  perf-profile.self.cycles-pp.update_sd_lb_stats
      0.11 ± 14%      +0.1        0.21 ±  5%  perf-profile.self.cycles-pp.__d_lookup_rcu
      0.10 ±  9%      +0.1        0.19 ±  5%  perf-profile.self.cycles-pp.clear_page_erms
      0.11 ±  6%      +0.1        0.20 ±  4%  perf-profile.self.cycles-pp.release_pages
      0.11 ±  7%      +0.1        0.21 ±  6%  perf-profile.self.cycles-pp.rwsem_spin_on_owner
      0.13 ±  9%      +0.1        0.23 ±  4%  perf-profile.self.cycles-pp.___might_sleep
      0.18 ± 10%      +0.1        0.28 ±  4%  perf-profile.self.cycles-pp.page_counter_try_charge
      0.12 ±  5%      +0.1        0.23 ±  6%  perf-profile.self.cycles-pp.malloc
      0.11 ±  9%      +0.1        0.23 ±  4%  perf-profile.self.cycles-pp.lockref_get_not_dead
      0.12 ±  8%      +0.1        0.24 ±  4%  perf-profile.self.cycles-pp.page_remove_rmap
      0.24 ±  6%      +0.1        0.39 ±  5%  perf-profile.self.cycles-pp.zap_pte_range
      0.21 ±  7%      +0.2        0.39 ±  4%  perf-profile.self.cycles-pp._dl_addr
      0.09 ± 26%      +0.2        0.27 ± 12%  perf-profile.self.cycles-pp.refill_obj_stock
      0.06 ± 62%      +0.2        0.26 ± 24%  perf-profile.self.cycles-pp.drain_obj_stock
      0.00            +0.2        0.22 ±  5%  perf-profile.self.cycles-pp.cna_order_queue
      0.41 ±  7%      +0.3        0.70 ±  3%  perf-profile.self.cycles-pp.filemap_map_pages
      0.22 ± 22%      +0.3        0.54 ± 20%  perf-profile.self.cycles-pp.kmem_cache_alloc
      0.35 ± 18%      +0.3        0.68        perf-profile.self.cycles-pp.page_counter_cancel
      0.86 ±  3%      +0.3        1.20 ±  2%  perf-profile.self.cycles-pp._raw_spin_lock
      0.50 ±  9%      +0.4        0.92 ±  8%  perf-profile.self.cycles-pp.mem_rtns_1
      0.69 ± 14%      +0.4        1.14 ±  6%  perf-profile.self.cycles-pp.div_short
      0.61 ± 13%      +0.5        1.06 ±  6%  perf-profile.self.cycles-pp.div_int
      0.67 ± 13%      +0.5        1.22 ±  7%  perf-profile.self.cycles-pp.add_short
      0.54 ± 35%      +0.7        1.23 ± 15%  perf-profile.self.cycles-pp.osq_lock
      0.89 ±  8%      +0.8        1.65 ±  7%  perf-profile.self.cycles-pp.__strcat_chk
      1.40 ± 13%      +1.0        2.38 ±  6%  perf-profile.self.cycles-pp.div_long
      1.51 ± 12%      +1.1        2.56 ±  5%  perf-profile.self.cycles-pp.add_long
      1.50 ± 13%      +1.1        2.60 ±  7%  perf-profile.self.cycles-pp.add_int
      0.43 ± 51%      +1.3        1.69 ± 34%  perf-profile.self.cycles-pp.kmem_cache_free
      1.64 ±  8%      +1.3        2.95 ±  6%  perf-profile.self.cycles-pp.__strncat_chk
      5.38 ±  9%      +4.3        9.70 ±  6%  perf-profile.self.cycles-pp.string_rtns_1
      4.49 ± 12%      +6.0       10.45 ±  4%  perf-profile.self.cycles-pp.intel_idle
      0.00           +37.5       37.52 ±  5%  perf-profile.self.cycles-pp.__cna_queued_spin_lock_slowpath


                                                                                
                               reaim.time.user_time                             
                                                                                
  3100 +--------------------------------------------------------------------+   
       |                                                                    |   
  3000 |-O              O                   O                        O O  O |   
       |              O           O                                         |   
  2900 |-+  O O  O O       O O  O    O O  O   O  O O  O O  O O  O O         |   
       |                                                                    |   
  2800 |-+                                                                  |   
       |                                                                    |   
  2700 |-+                                                                  |   
       |                                                                    |   
  2600 |-+                                             .+..                 |   
       |.+..+.+..+.+..+.+..+.+..+.+.. .+.. .+        .+    +    +.+..+.+    |   
  2500 |-+                           +    +  +  .+.+.       + ..            |   
       |                                      +.             +              |   
  2400 +--------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                              reaim.time.system_time                            
                                                                                
  9000 +--------------------------------------------------------------------+   
  8500 |-+                                                   +..            |   
       |                             +    +. .+..+.         +       .+.+    |   
  8000 |.+..+.+..+.+.. .+..+.+..+. .. + ..  +      +..+.  .+    +.+.        |   
  7500 |-+            +           +    +                +.                  |   
       |                                                                    |   
  7000 |-+                                                                  |   
  6500 |-+                                                                  |   
  6000 |-+                                                                  |   
       |                                                                    |   
  5500 |-+  O                                    O         O                |   
  5000 |-O    O  O O  O O  O O  O O  O O  O O O    O  O O    O  O O         |   
       |                                                                    |   
  4500 |-+                                                                  |   
  4000 +--------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                      reaim.time.percent_of_cpu_this_job_got                    
                                                                                
  3800 +--------------------------------------------------------------------+   
       |                                                     +..            |   
  3600 |-+                          .+.  .+. .+..+.         +       .+.+    |   
  3400 |.+..+.+..+.+..+.+..+.+..+.+.   +.   +      +..+.  .+    +.+.        |   
       |                                                +.                  |   
  3200 |-+                                                                  |   
       |                                                                    |   
  3000 |-+                                                                  |   
       |                                                                    |   
  2800 |-O                                                                  |   
  2600 |-+  O O  O O  O O  O O  O O  O O  O O O  O O  O O  O O  O O         |   
       |                                                                    |   
  2400 |-+                                                                  |   
       |                                                             O O  O |   
  2200 +--------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                            reaim.time.major_page_faults                        
                                                                                
  200000 +------------------------------------------------------------------+   
         |                                                           O O  O |   
  180000 |-+                                                                |   
  160000 |-+                                                                |   
         |                                                                  |   
  140000 |-+                     O                                          |   
         |                     O      O O    O           O        O         |   
  120000 |-+                       O       O   O      O         O           |   
         |             O                          O O      O  O             |   
  100000 |-O    O  O O    O O                                               |   
   80000 |-+  O                                                             |   
         |                                                                  |   
   60000 |.+..      .+.         .+.                                         |   
         |    +.+..+   +..+.+..+   +..+.+..+.+.  .+.+.+..+.+..+.+.+..+.+    |   
   40000 +------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                             reaim.time.minor_page_faults                       
                                                                                
  9.8e+07 +-----------------------------------------------------------------+   
          |             O           O                                O O  O |   
  9.6e+07 |-O  O O O  O    O O O  O   O  O O O  O O O  O O  O O O  O        |   
  9.4e+07 |-+                                                               |   
          |                                                                 |   
  9.2e+07 |-+                                                               |   
    9e+07 |-+                                                               |   
          |                                                                 |   
  8.8e+07 |-+                                                               |   
  8.6e+07 |-+                                            +..                |   
          |.+.. .+.  .+.+..+.+.  .+.+.  .+. .+..        +       +..         |   
  8.4e+07 |-+  +   +.          +.     +.   +     .+.+..+    +  :   +.+.+    |   
  8.2e+07 |-+                                   +            + :            |   
          |                                                   +             |   
    8e+07 +-----------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                                 reaim.parent_time                              
                                                                                
  1.6 +---------------------------------------------------------------------+   
      |                                                                     |   
  1.5 |-+                                                    +              |   
      |                             +..  +..  +..+.         + +             |   
  1.4 |..+.+..+.+..+.       .+.    +    +    +     +..+.  .+   + .+..+.+    |   
      |              +..+.+.   +..+    +    +           +.      +           |   
  1.3 |-+                                                                   |   
      |                                                                     |   
  1.2 |-+                                                                   |   
      |                                                                     |   
  1.1 |-+                                                                   |   
      |                                                                     |   
    1 |-+O O  O O  O    O O  O O    O  O O  O O  O O  O O  O O  O O         |   
      |              O            O                                  O O  O |   
  0.9 +---------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                                reaim.child_systime                             
                                                                                
  110 +---------------------------------------------------------------------+   
      |                                                                     |   
  100 |-+                                     +..           .+..            |   
   90 |-+ .+.. .+..         .+.    .+.. .+.. +   +.  .+    +     .+..+.+    |   
      |..+    +    +.+..+.+.   +..+    +    +      +.  + ..     +           |   
   80 |-+                                               +                   |   
      |                                                                     |   
   70 |-+                                                                   |   
      |                                                                     |   
   60 |-+                                                                   |   
   50 |-+O O  O O  O O  O O  O O    O  O O  O O  O O  O    O O  O           |   
      |                           O                     O         O         |   
   40 |-+                                                            O O  O |   
      |                                                                     |   
   30 +---------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                                 reaim.jobs_per_min                             
                                                                                
  650000 +------------------------------------------------------------------+   
         |                                                                  |   
  600000 |-+           O           O                                 O O  O |   
         |      O  O      O O  O O    O O    O O  O O O  O O  O O O         |   
         | O  O      O                     O                                |   
  550000 |-+                                                                |   
         |                                                                  |   
  500000 |-+                                                                |   
         |                                                                  |   
  450000 |-+                                                                |   
         |            .+..+.      .+.. .+.. .+          .+.                 |   
         |.+..+.+..+.+      +..+.+    +    +  +    .+.+.   +.. .+.+..+.+    |   
  400000 |-+                                   +..+           +             |   
         |                                                                  |   
  350000 +------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                             reaim.jobs_per_min_child                           
                                                                                
  6500 +--------------------------------------------------------------------+   
       |                          O                                  O O  O |   
       |         O    O      O  O             O    O    O    O    O         |   
  6000 |-O  O O    O    O  O         O O  O O    O    O    O    O           |   
       |                                                                    |   
       |                                                                    |   
  5500 |-+                                                                  |   
       |                                                                    |   
  5000 |-+                                                                  |   
       |                                                                    |   
       |                                                                    |   
  4500 |-+           .+.+..      .+..  +..             .+..                 |   
       |.+..+.+..+.+.      +.+..+     +    .+.    .+..+    +    +.+.. .+    |   
       |                             +    +   +..+          + ..     +      |   
  4000 +--------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                               reaim.max_jobs_per_min                           
                                                                                
  700000 +------------------------------------------------------------------+   
         |                                                                  |   
  650000 |-+       O   O           O                O         O      O O  O |   
         |                O    O O      O      O  O      O O      O         |   
  600000 |-O  O O    O      O         O    O O        O         O           |   
         |                                                                  |   
  550000 |-+                                                                |   
         |                                                                  |   
  500000 |-+                                                                |   
         |.                                                                 |   
  450000 |-+..        .+..+.+..   .+.. .+.. .+     .+.  .+.+..  +.          |   
         |    +.+..+.+         +.+    +    +  +  .+   +.       +  +..+.+    |   
  400000 |-+                                   +.             +             |   
         |                                                                  |   
  350000 +------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                                   reaim.workload                               
                                                                                
  980000 +------------------------------------------------------------------+   
         |             O           O                                 O O  O |   
  960000 |-O  O O  O O    O O  O O    O O  O O O  O O O  O O  O O O         |   
  940000 |-+                                                                |   
         |                                                                  |   
  920000 |-+                                                                |   
  900000 |-+                                                                |   
         |                                                                  |   
  880000 |-+                                                                |   
  860000 |-+                                             +                  |   
         |.+.. .+.. .+.+..+.+.. .+.+.. .+.. .+         .. +     +.          |   
  840000 |-+  +    +           +      +    +  +  .+.+.+    +.. :  +..+.+    |   
  820000 |-+                                   +.              :            |   
         |                                                    +             |   
  800000 +------------------------------------------------------------------+   
                                                                                
                                                                                
[*] bisect-good sample
[O] bisect-bad  sample



Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


Thanks,
Rong Chen


--3607uds81ZQvwCD0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="config-5.9.0-rc2-00051-g5df52a74ab0091"

#
# Automatically generated file; DO NOT EDIT.
# Linux/x86_64 5.9.0-rc2 Kernel Configuration
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
CONFIG_KVM_AMD=m
CONFIG_KVM_AMD_SEV=y
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
CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
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
CONFIG_CMA_AREAS=7
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
CONFIG_DEVICE_PRIVATE=y
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
# CONFIG_MPTCP_KUNIT_TESTS is not set
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
CONFIG_VIRTIO_BLK=y
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
# CONFIG_INTEL_MEI_HDCP is not set
CONFIG_VMWARE_VMCI=m

#
# Intel MIC & related support
#
# CONFIG_INTEL_MIC_BUS is not set
# CONFIG_SCIF_BUS is not set
# CONFIG_VOP_BUS is not set
# end of Intel MIC & related support

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
CONFIG_MII=y
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
CONFIG_MDIO_DEVRES=y
# CONFIG_MDIO_BCM_UNIMAC is not set
# CONFIG_MDIO_BITBANG is not set
# CONFIG_MDIO_MSCC_MIIM is not set
# CONFIG_MDIO_MVUSB is not set
# CONFIG_MDIO_THUNDER is not set
# CONFIG_MDIO_XPCS is not set
CONFIG_PHYLIB=y
# CONFIG_LED_TRIGGER_PHY is not set

#
# MII PHY device drivers
#
# CONFIG_ADIN_PHY is not set
# CONFIG_AMD_PHY is not set
# CONFIG_AQUANTIA_PHY is not set
# CONFIG_AX88796B_PHY is not set
# CONFIG_BCM7XXX_PHY is not set
# CONFIG_BCM87XX_PHY is not set
# CONFIG_BROADCOM_PHY is not set
# CONFIG_BCM54140_PHY is not set
# CONFIG_BCM84881_PHY is not set
# CONFIG_CICADA_PHY is not set
# CONFIG_CORTINA_PHY is not set
# CONFIG_DAVICOM_PHY is not set
# CONFIG_DP83822_PHY is not set
# CONFIG_DP83TC811_PHY is not set
# CONFIG_DP83848_PHY is not set
# CONFIG_DP83867_PHY is not set
# CONFIG_DP83869_PHY is not set
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
# CONFIG_HW_RANDOM_BA431 is not set
CONFIG_HW_RANDOM_VIA=m
CONFIG_HW_RANDOM_VIRTIO=y
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
CONFIG_PINCTRL_INTEL=m
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
# CONFIG_POWER_AVS is not set
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
# CONFIG_HID_GLORIOUS is not set
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
CONFIG_VIRTIO_BALLOON=y
CONFIG_VIRTIO_MEM=m
CONFIG_VIRTIO_INPUT=m
# CONFIG_VIRTIO_MMIO is not set
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
# CONFIG_MFD_CROS_EC is not set
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
# CONFIG_BCM_KONA_USB2_PHY is not set
# CONFIG_PHY_PXA_28NM_HSIC is not set
# CONFIG_PHY_PXA_28NM_USB2 is not set
# CONFIG_PHY_INTEL_EMMC is not set
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
# CONFIG_EXT2_FS is not set
# CONFIG_EXT3_FS is not set
CONFIG_EXT4_FS=y
CONFIG_EXT4_USE_FOR_EXT2=y
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
CONFIG_CRYPTO_USER_API_AEAD=y
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
CONFIG_RCU_PERF_TEST=m
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
CONFIG_HAVE_ARCH_KCSAN=y
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
# CONFIG_TEST_BITFIELD is not set
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
# CONFIG_TEST_FPU is not set
# CONFIG_MEMTEST is not set
# CONFIG_HYPERV_TESTING is not set
# end of Kernel Testing and Coverage
# end of Kernel hacking

--3607uds81ZQvwCD0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=job-script

#!/bin/sh

export_top_env()
{
	export suite='reaim'
	export testcase='reaim'
	export category='benchmark'
	export runtime=300
	export nr_task=96
	export job_origin='/lkp-src/allot/cyclic:p1:linux-devel:devel-hourly/lkp-csl-2sp5/reaim-100.yaml'
	export queue_cmdline_keys='branch
commit
queue_at_least_once'
	export queue='validate'
	export testbox='lkp-csl-2sp5'
	export tbox_group='lkp-csl-2sp5'
	export kconfig='x86_64-rhel-8.3'
	export submit_id='5f6255fad6540e4033af1521'
	export job_file='/lkp/jobs/scheduled/lkp-csl-2sp5/reaim-performance-100%-300s-fserver-ucode=0x5002f01-monitor=a122c70f-debian-10.4-x86_64-20200603.cgz-5df52a74ab00917ec2522ab3ec2-20200917-16435-18sax9r-2.yaml'
	export id='ace2ec9df7a2e240725f7b47bfb76c63884f361b'
	export queuer_version='/lkp-src'
	export model='Cascade Lake'
	export nr_node=2
	export nr_cpu=96
	export memory='192G'
	export nr_hdd_partitions=1
	export nr_ssd_partitions=1
	export hdd_partitions='/dev/disk/by-id/ata-ST1000NM0011_Z1N2QGYK-part5'
	export ssd_partitions='/dev/disk/by-id/ata-INTEL_SSDSC2BB800G4_PHWL4204006P800RGN-part1'
	export swap_partitions=
	export rootfs_partition='/dev/disk/by-id/ata-ST1000NM0011_Z1N2QGYK-part3'
	export brand='Intel(R) Xeon(R) Gold 6252 CPU @ 2.10GHz'
	export avoid_nfs=1
	export commit='5df52a74ab00917ec2522ab3ec2e91ce33fbf22a'
	export need_kconfig_hw='CONFIG_I40E=y
CONFIG_SATA_AHCI'
	export ucode='0x5002f01'
	export enqueue_time='2020-09-17 02:14:18 +0800'
	export _id='5f6255fad6540e4033af1521'
	export _rt='/result/reaim/performance-100%-300s-fserver-ucode=0x5002f01-monitor=a122c70f/lkp-csl-2sp5/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/5df52a74ab00917ec2522ab3ec2e91ce33fbf22a'
	export user='lkp'
	export compiler='gcc-9'
	export head_commit='9ebe61f301d1521756a64bd7ea6eb3b9e3c5c21a'
	export base_commit='856deb866d16e29bd65952e0289066f6078af773'
	export branch='linux-review/Alex-Kogan/Add-NUMA-awareness-to-qspinlock/20200916-023855'
	export rootfs='debian-10.4-x86_64-20200603.cgz'
	export monitor_sha='a122c70f'
	export result_root='/result/reaim/performance-100%-300s-fserver-ucode=0x5002f01-monitor=a122c70f/lkp-csl-2sp5/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/5df52a74ab00917ec2522ab3ec2e91ce33fbf22a/3'
	export scheduler_version='/lkp/lkp/.src-20200916-151547'
	export LKP_SERVER='inn'
	export arch='x86_64'
	export max_uptime=1500
	export initrd='/osimage/debian/debian-10.4-x86_64-20200603.cgz'
	export bootloader_append='root=/dev/ram0
user=lkp
job=/lkp/jobs/scheduled/lkp-csl-2sp5/reaim-performance-100%-300s-fserver-ucode=0x5002f01-monitor=a122c70f-debian-10.4-x86_64-20200603.cgz-5df52a74ab00917ec2522ab3ec2-20200917-16435-18sax9r-2.yaml
ARCH=x86_64
kconfig=x86_64-rhel-8.3
branch=linux-review/Alex-Kogan/Add-NUMA-awareness-to-qspinlock/20200916-023855
commit=5df52a74ab00917ec2522ab3ec2e91ce33fbf22a
BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3/gcc-9/5df52a74ab00917ec2522ab3ec2e91ce33fbf22a/vmlinuz-5.9.0-rc2-00051-g5df52a74ab0091
max_uptime=1500
RESULT_ROOT=/result/reaim/performance-100%-300s-fserver-ucode=0x5002f01-monitor=a122c70f/lkp-csl-2sp5/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/5df52a74ab00917ec2522ab3ec2e91ce33fbf22a/3
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
	export modules_initrd='/pkg/linux/x86_64-rhel-8.3/gcc-9/5df52a74ab00917ec2522ab3ec2e91ce33fbf22a/modules.cgz'
	export bm_initrd='/osimage/deps/debian-10.4-x86_64-20200603.cgz/run-ipconfig_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/lkp_20200709.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/rsync-rootfs_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/reaim_20200715.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/reaim-x86_64-7.0.1.13-1_20200715.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/mpstat_20200714.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/perf_20200723.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/perf-x86_64-34d4ddd359db-1_20200909.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/sar-x86_64-34c92ae-1_20200702.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/hw_20200715.cgz'
	export ucode_initrd='/osimage/ucode/intel-ucode-20200610.cgz'
	export lkp_initrd='/osimage/user/lkp/lkp-x86_64.cgz'
	export site='inn'
	export LKP_CGI_PORT=80
	export LKP_CIFS_PORT=139
	export last_kernel='4.20.0'
	export repeat_to=4
	export schedule_notify_address=
	export queue_at_least_once=1
	export kernel='/pkg/linux/x86_64-rhel-8.3/gcc-9/5df52a74ab00917ec2522ab3ec2e91ce33fbf22a/vmlinuz-5.9.0-rc2-00051-g5df52a74ab0091'
	export dequeue_time='2020-09-17 02:24:21 +0800'
	export job_initrd='/lkp/jobs/scheduled/lkp-csl-2sp5/reaim-performance-100%-300s-fserver-ucode=0x5002f01-monitor=a122c70f-debian-10.4-x86_64-20200603.cgz-5df52a74ab00917ec2522ab3ec2-20200917-16435-18sax9r-2.cgz'

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

	run_test test='fserver' $LKP_SRC/tests/wrapper reaim
}

extract_stats()
{
	export stats_part_begin=
	export stats_part_end=

	$LKP_SRC/stats/wrapper reaim
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

	$LKP_SRC/stats/wrapper time reaim.time
	$LKP_SRC/stats/wrapper dmesg
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper last_state
	$LKP_SRC/stats/wrapper stderr
	$LKP_SRC/stats/wrapper time
}

"$@"

--3607uds81ZQvwCD0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="job.yaml"

---

#! jobs/reaim-100.yaml
suite: reaim
testcase: reaim
category: benchmark
runtime: 300s
nr_task: 100%
reaim:
  test: fserver
job_origin: "/lkp-src/allot/cyclic:p1:linux-devel:devel-hourly/lkp-csl-2sp5/reaim-100.yaml"

#! queue options
queue_cmdline_keys:
- branch
- commit
- queue_at_least_once
queue: bisect
testbox: lkp-csl-2sp5
tbox_group: lkp-csl-2sp5
kconfig: x86_64-rhel-8.3
submit_id: 5f623accf6989d30a8bab384
job_file: "/lkp/jobs/scheduled/lkp-csl-2sp5/reaim-performance-100%-300s-fserver-ucode=0x5002f01-monitor=a122c70f-debian-10.4-x86_64-20200603.cgz-5df52a74ab00917ec2522ab3ec2-20200917-12456-1la065k-0.yaml"
id: f68be8f000fb0fa347dce0ada03fb7de586748d8
queuer_version: "/lkp-src"

#! hosts/lkp-csl-2sp5
model: Cascade Lake
nr_node: 2
nr_cpu: 96
memory: 192G
nr_hdd_partitions: 1
nr_ssd_partitions: 1
hdd_partitions: "/dev/disk/by-id/ata-ST1000NM0011_Z1N2QGYK-part5"
ssd_partitions: "/dev/disk/by-id/ata-INTEL_SSDSC2BB800G4_PHWL4204006P800RGN-part1"
swap_partitions: 
rootfs_partition: "/dev/disk/by-id/ata-ST1000NM0011_Z1N2QGYK-part3"
brand: Intel(R) Xeon(R) Gold 6252 CPU @ 2.10GHz

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

#! include/reaim
avoid_nfs: 1

#! include/queue/cyclic
commit: 5df52a74ab00917ec2522ab3ec2e91ce33fbf22a

#! include/testbox/lkp-csl-2sp5
need_kconfig_hw:
- CONFIG_I40E=y
- CONFIG_SATA_AHCI
ucode: '0x5002f01'
enqueue_time: 2020-09-17 00:18:20.980649596 +08:00
_id: 5f623accf6989d30a8bab384
_rt: "/result/reaim/performance-100%-300s-fserver-ucode=0x5002f01-monitor=a122c70f/lkp-csl-2sp5/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/5df52a74ab00917ec2522ab3ec2e91ce33fbf22a"

#! schedule options
user: lkp
compiler: gcc-9
head_commit: 9ebe61f301d1521756a64bd7ea6eb3b9e3c5c21a
base_commit: 856deb866d16e29bd65952e0289066f6078af773
branch: linux-devel/devel-hourly-2020091608
rootfs: debian-10.4-x86_64-20200603.cgz
monitor_sha: a122c70f
result_root: "/result/reaim/performance-100%-300s-fserver-ucode=0x5002f01-monitor=a122c70f/lkp-csl-2sp5/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/5df52a74ab00917ec2522ab3ec2e91ce33fbf22a/0"
scheduler_version: "/lkp/lkp/.src-20200916-151547"
LKP_SERVER: inn
arch: x86_64
max_uptime: 1500
initrd: "/osimage/debian/debian-10.4-x86_64-20200603.cgz"
bootloader_append:
- root=/dev/ram0
- user=lkp
- job=/lkp/jobs/scheduled/lkp-csl-2sp5/reaim-performance-100%-300s-fserver-ucode=0x5002f01-monitor=a122c70f-debian-10.4-x86_64-20200603.cgz-5df52a74ab00917ec2522ab3ec2-20200917-12456-1la065k-0.yaml
- ARCH=x86_64
- kconfig=x86_64-rhel-8.3
- branch=linux-devel/devel-hourly-2020091608
- commit=5df52a74ab00917ec2522ab3ec2e91ce33fbf22a
- BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3/gcc-9/5df52a74ab00917ec2522ab3ec2e91ce33fbf22a/vmlinuz-5.9.0-rc2-00051-g5df52a74ab0091
- max_uptime=1500
- RESULT_ROOT=/result/reaim/performance-100%-300s-fserver-ucode=0x5002f01-monitor=a122c70f/lkp-csl-2sp5/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/5df52a74ab00917ec2522ab3ec2e91ce33fbf22a/0
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
modules_initrd: "/pkg/linux/x86_64-rhel-8.3/gcc-9/5df52a74ab00917ec2522ab3ec2e91ce33fbf22a/modules.cgz"
bm_initrd: "/osimage/deps/debian-10.4-x86_64-20200603.cgz/run-ipconfig_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/lkp_20200709.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/rsync-rootfs_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/reaim_20200715.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/reaim-x86_64-7.0.1.13-1_20200715.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/mpstat_20200714.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/perf_20200723.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/perf-x86_64-34d4ddd359db-1_20200909.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/sar-x86_64-34c92ae-1_20200702.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/hw_20200715.cgz"
ucode_initrd: "/osimage/ucode/intel-ucode-20200610.cgz"
lkp_initrd: "/osimage/user/lkp/lkp-x86_64.cgz"
site: inn

#! /lkp/lkp/.src-20200916-114822/include/site/inn
LKP_CGI_PORT: 80
LKP_CIFS_PORT: 139
oom-killer: 
watchdog: 

#! runtime status
last_kernel: 5.9.0-rc5
repeat_to: 2
schedule_notify_address: 

#! user overrides
queue_at_least_once: 0
kernel: "/pkg/linux/x86_64-rhel-8.3/gcc-9/5df52a74ab00917ec2522ab3ec2e91ce33fbf22a/vmlinuz-5.9.0-rc2-00051-g5df52a74ab0091"
dequeue_time: 2020-09-17 00:45:07.314085506 +08:00

#! /lkp/lkp/.src-20200916-151547/include/site/inn
job_state: finished
loadavg: 24.72 19.17 8.60 1/714 17017
start_time: '1600274756'
end_time: '1600275058'
version: "/lkp/lkp/.src-20200916-151621:6aebec94-dirty:fb24ae09e-dirty"

--3607uds81ZQvwCD0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=reproduce


for cpu_dir in /sys/devices/system/cpu/cpu[0-9]*
do
	online_file="$cpu_dir"/online
	[ -f "$online_file" ] && [ "$(cat "$online_file")" -eq 0 ] && continue

	file="$cpu_dir"/cpufreq/scaling_governor
	[ -f "$file" ] && echo "performance" > "$file"
done

cp data/workfile.fserver .
mkdir -p /fs/shm
umount /fs/shm
mount -t tmpfs tmpfs /fs/shm
echo FILESIZE 10k > reaim.config
echo POOLSIZE 1m >> reaim.config
echo DISKDIR /fs/shm  >> reaim.config
./reaim -s96 -e96 -i96 -fworkfile.fserver -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s96 -e96 -i96 -fworkfile.fserver -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s96 -e96 -i96 -fworkfile.fserver -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s96 -e96 -i96 -fworkfile.fserver -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s96 -e96 -i96 -fworkfile.fserver -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s96 -e96 -i96 -fworkfile.fserver -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s96 -e96 -i96 -fworkfile.fserver -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s96 -e96 -i96 -fworkfile.fserver -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s96 -e96 -i96 -fworkfile.fserver -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s96 -e96 -i96 -fworkfile.fserver -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s96 -e96 -i96 -fworkfile.fserver -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s96 -e96 -i96 -fworkfile.fserver -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s96 -e96 -i96 -fworkfile.fserver -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s96 -e96 -i96 -fworkfile.fserver -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s96 -e96 -i96 -fworkfile.fserver -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s96 -e96 -i96 -fworkfile.fserver -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s96 -e96 -i96 -fworkfile.fserver -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s96 -e96 -i96 -fworkfile.fserver -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s96 -e96 -i96 -fworkfile.fserver -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s96 -e96 -i96 -fworkfile.fserver -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s96 -e96 -i96 -fworkfile.fserver -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s96 -e96 -i96 -fworkfile.fserver -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s96 -e96 -i96 -fworkfile.fserver -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s96 -e96 -i96 -fworkfile.fserver -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s96 -e96 -i96 -fworkfile.fserver -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s96 -e96 -i96 -fworkfile.fserver -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s96 -e96 -i96 -fworkfile.fserver -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s96 -e96 -i96 -fworkfile.fserver -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s96 -e96 -i96 -fworkfile.fserver -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s96 -e96 -i96 -fworkfile.fserver -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s96 -e96 -i96 -fworkfile.fserver -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s96 -e96 -i96 -fworkfile.fserver -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s96 -e96 -i96 -fworkfile.fserver -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s96 -e96 -i96 -fworkfile.fserver -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s96 -e96 -i96 -fworkfile.fserver -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s96 -e96 -i96 -fworkfile.fserver -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s96 -e96 -i96 -fworkfile.fserver -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s96 -e96 -i96 -fworkfile.fserver -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s96 -e96 -i96 -fworkfile.fserver -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s96 -e96 -i96 -fworkfile.fserver -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s96 -e96 -i96 -fworkfile.fserver -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s96 -e96 -i96 -fworkfile.fserver -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s96 -e96 -i96 -fworkfile.fserver -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s96 -e96 -i96 -fworkfile.fserver -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s96 -e96 -i96 -fworkfile.fserver -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s96 -e96 -i96 -fworkfile.fserver -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s96 -e96 -i96 -fworkfile.fserver -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s96 -e96 -i96 -fworkfile.fserver -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s96 -e96 -i96 -fworkfile.fserver -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s96 -e96 -i96 -fworkfile.fserver -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s96 -e96 -i96 -fworkfile.fserver -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s96 -e96 -i96 -fworkfile.fserver -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s96 -e96 -i96 -fworkfile.fserver -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s96 -e96 -i96 -fworkfile.fserver -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s96 -e96 -i96 -fworkfile.fserver -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s96 -e96 -i96 -fworkfile.fserver -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s96 -e96 -i96 -fworkfile.fserver -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s96 -e96 -i96 -fworkfile.fserver -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s96 -e96 -i96 -fworkfile.fserver -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s96 -e96 -i96 -fworkfile.fserver -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s96 -e96 -i96 -fworkfile.fserver -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s96 -e96 -i96 -fworkfile.fserver -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s96 -e96 -i96 -fworkfile.fserver -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s96 -e96 -i96 -fworkfile.fserver -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s96 -e96 -i96 -fworkfile.fserver -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s96 -e96 -i96 -fworkfile.fserver -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s96 -e96 -i96 -fworkfile.fserver -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s96 -e96 -i96 -fworkfile.fserver -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s96 -e96 -i96 -fworkfile.fserver -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s96 -e96 -i96 -fworkfile.fserver -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s96 -e96 -i96 -fworkfile.fserver -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s96 -e96 -i96 -fworkfile.fserver -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s96 -e96 -i96 -fworkfile.fserver -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s96 -e96 -i96 -fworkfile.fserver -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s96 -e96 -i96 -fworkfile.fserver -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s96 -e96 -i96 -fworkfile.fserver -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s96 -e96 -i96 -fworkfile.fserver -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s96 -e96 -i96 -fworkfile.fserver -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s96 -e96 -i96 -fworkfile.fserver -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s96 -e96 -i96 -fworkfile.fserver -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s96 -e96 -i96 -fworkfile.fserver -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s96 -e96 -i96 -fworkfile.fserver -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s96 -e96 -i96 -fworkfile.fserver -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s96 -e96 -i96 -fworkfile.fserver -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s96 -e96 -i96 -fworkfile.fserver -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s96 -e96 -i96 -fworkfile.fserver -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s96 -e96 -i96 -fworkfile.fserver -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s96 -e96 -i96 -fworkfile.fserver -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s96 -e96 -i96 -fworkfile.fserver -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s96 -e96 -i96 -fworkfile.fserver -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s96 -e96 -i96 -fworkfile.fserver -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s96 -e96 -i96 -fworkfile.fserver -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s96 -e96 -i96 -fworkfile.fserver -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s96 -e96 -i96 -fworkfile.fserver -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s96 -e96 -i96 -fworkfile.fserver -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s96 -e96 -i96 -fworkfile.fserver -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s96 -e96 -i96 -fworkfile.fserver -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s96 -e96 -i96 -fworkfile.fserver -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s96 -e96 -i96 -fworkfile.fserver -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s96 -e96 -i96 -fworkfile.fserver -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s96 -e96 -i96 -fworkfile.fserver -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100

--3607uds81ZQvwCD0--
