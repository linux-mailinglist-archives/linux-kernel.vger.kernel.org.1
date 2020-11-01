Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 586262A1CAB
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Nov 2020 09:26:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726188AbgKAIZw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Nov 2020 03:25:52 -0500
Received: from mga12.intel.com ([192.55.52.136]:36895 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725931AbgKAIZv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Nov 2020 03:25:51 -0500
IronPort-SDR: h+8tmf6IS6vah3RdGrYP4L7dsUuFqXKRnpiZpRAN6swVCqo1mbgLtMfbycevZmehUcgquNwBAu
 bOaNA0xApoFA==
X-IronPort-AV: E=McAfee;i="6000,8403,9791"; a="148059990"
X-IronPort-AV: E=Sophos;i="5.77,440,1596524400"; 
   d="yaml'?scan'208";a="148059990"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2020 01:25:47 -0700
IronPort-SDR: 7iBBCqfVRn9ZL1t5jZoZdDOr+wd5kE+LKZ0CcMPmjMeM3n2Rwl+mkyXPgEpJVRSZhkMWVs3Zv5
 jtJSPoA00V/w==
X-IronPort-AV: E=Sophos;i="5.77,440,1596524400"; 
   d="yaml'?scan'208";a="537604617"
Received: from shao2-debian.sh.intel.com (HELO localhost) ([10.239.13.3])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2020 01:25:42 -0700
Date:   Sun, 1 Nov 2020 16:24:52 +0800
From:   kernel test robot <rong.a.chen@intel.com>
To:     Julia Lawall <Julia.Lawall@inria.fr>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        lkp@lists.01.org, lkp@intel.com, ying.huang@intel.com,
        feng.tang@intel.com, zhengjun.xing@intel.com,
        aubrey.li@linux.intel.com, yu.c.chen@intel.com
Subject: [sched/fair] d8fcb81f1a: netperf.Throughput_tps -16.9% regression
Message-ID: <20201101082452.GC31092@shao2-debian>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="Wn0J+vu9+NMIXK57"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: NeoMutt/20170113 (1.7.2)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Wn0J+vu9+NMIXK57
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Greeting,

FYI, we noticed a -16.9% regression of netperf.Throughput_tps due to commit:


commit: d8fcb81f1acf651a0e50eacecca43d0524984f87 ("sched/fair: Check for idle core in wake_affine")
https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git sched/core


in testcase: netperf
on test machine: 144 threads Intel(R) Xeon(R) Gold 5318H CPU @ 2.50GHz with 128G memory
with following parameters:

	ip: ipv4
	runtime: 300s
	nr_threads: 25%
	cluster: cs-localhost
	test: SCTP_RR
	cpufreq_governor: performance
	ucode: 0x700001c

test-description: Netperf is a benchmark that can be use to measure various aspect of networking performance.
test-url: http://www.netperf.org/netperf/

In addition to that, the commit also has significant impact on the following tests:

+------------------+------------------------------------------------------------------------+
| testcase: change | aim7: aim7.jobs-per-min 8.7% improvement                               |
| test machine     | 144 threads Intel(R) Xeon(R) Gold 5318H CPU @ 2.50GHz with 128G memory |
| test parameters  | cpufreq_governor=performance                                           |
|                  | disk=1BRD_48G                                                          |
|                  | fs=xfs                                                                 |
|                  | load=600                                                               |
|                  | test=sync_disk_rw                                                      |
|                  | ucode=0x700001c                                                        |
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
  cs-localhost/gcc-9/performance/ipv4/x86_64-rhel-8.3/25%/debian-10.4-x86_64-20200603.cgz/300s/lkp-cpl-4sp1/SCTP_RR/netperf/0x700001c

commit: 
  43c31ac0e6 ("sched: Remove relyance on STRUCT_ALIGNMENT")
  d8fcb81f1a ("sched/fair: Check for idle core in wake_affine")

43c31ac0e665d942 d8fcb81f1acf651a0e50eacecca 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
   2021304           -16.9%    1678970 ±  3%  netperf.Throughput_total_tps
     56147           -16.9%      46638 ±  3%  netperf.Throughput_tps
      1465            -5.2%       1389        netperf.time.percent_of_cpu_this_job_got
      4372            -5.0%       4155        netperf.time.system_time
     99.55           -17.0%      82.63 ±  4%  netperf.time.user_time
 6.064e+08           -16.9%  5.037e+08 ±  3%  netperf.time.voluntary_context_switches
 6.064e+08           -16.9%  5.037e+08 ±  3%  netperf.workload
      0.52 ±  2%      -0.1        0.44 ±  4%  mpstat.cpu.all.usr%
    514.75 ± 47%    +248.2%       1792 ± 49%  numa-meminfo.node1.Active
    514.75 ± 47%    +248.2%       1792 ± 49%  numa-meminfo.node1.Active(anon)
    140083 ± 32%     +74.2%     244042 ± 28%  numa-numastat.node1.local_node
    161065 ± 28%     +62.4%     261530 ± 24%  numa-numastat.node1.numa_hit
    128.25 ± 47%    +249.1%     447.75 ± 49%  numa-vmstat.node1.nr_active_anon
    128.25 ± 47%    +249.1%     447.75 ± 49%  numa-vmstat.node1.nr_zone_active_anon
     27622 ±  6%     -23.7%      21068 ± 26%  proc-vmstat.numa_hint_faults
     15390 ± 25%     -32.9%      10329 ±  6%  proc-vmstat.numa_hint_faults_local
      2870 ± 11%     +16.4%       3342 ±  7%  slabinfo.fsnotify_mark_connector.active_objs
      2870 ± 11%     +16.4%       3342 ±  7%  slabinfo.fsnotify_mark_connector.num_objs
     66.00            +1.5%      67.00        vmstat.cpu.id
   7870403           -16.9%    6543135 ±  3%  vmstat.system.cs
 1.178e+09           -15.8%  9.919e+08 ±  3%  cpuidle.C1.usage
 1.967e+08 ±  4%     -35.7%  1.266e+08 ± 11%  cpuidle.POLL.time
  39529805 ±  5%     -42.6%   22687592 ± 15%  cpuidle.POLL.usage
     33571 ± 23%     -40.5%      19979 ± 34%  sched_debug.cfs_rq:/.MIN_vruntime.avg
   1094720 ±  2%     -18.4%     893789 ±  8%  sched_debug.cfs_rq:/.MIN_vruntime.max
    175204 ± 12%     -29.7%     123212 ± 20%  sched_debug.cfs_rq:/.MIN_vruntime.stddev
     33571 ± 23%     -40.5%      19979 ± 34%  sched_debug.cfs_rq:/.max_vruntime.avg
   1094720 ±  2%     -18.4%     893789 ±  8%  sched_debug.cfs_rq:/.max_vruntime.max
    175204 ± 12%     -29.7%     123212 ± 20%  sched_debug.cfs_rq:/.max_vruntime.stddev
    952375           -11.8%     839736 ±  2%  sched_debug.cfs_rq:/.min_vruntime.avg
   1212025           -13.4%    1049842 ±  3%  sched_debug.cfs_rq:/.min_vruntime.max
    126484 ±  4%     -30.2%      88234 ± 18%  sched_debug.cfs_rq:/.min_vruntime.stddev
    126455 ±  4%     -30.2%      88222 ± 18%  sched_debug.cfs_rq:/.spread0.stddev
    188.46 ±  8%     -17.5%     155.42 ±  6%  sched_debug.cfs_rq:/.util_est_enqueued.avg
    428784 ±  4%     -15.7%     361528 ±  7%  sched_debug.cpu.avg_idle.avg
    410059            -9.3%     372101 ±  5%  sched_debug.cpu.avg_idle.stddev
      2101 ±  4%     -20.3%       1674 ± 13%  sched_debug.cpu.clock_task.stddev
   6576722           -17.3%    5441716 ±  3%  sched_debug.cpu.nr_switches.avg
   8614196 ±  2%     -17.4%    7116437 ±  3%  sched_debug.cpu.nr_switches.max
   4809812 ±  2%     -17.2%    3981069 ±  4%  sched_debug.cpu.nr_switches.min
    997524 ±  4%     -32.3%     675800 ± 17%  sched_debug.cpu.nr_switches.stddev
     14.55           -10.5%      13.03 ±  4%  perf-stat.i.MPKI
 2.174e+10           -16.6%  1.814e+10 ±  3%  perf-stat.i.branch-instructions
 3.616e+08           -16.8%   3.01e+08 ±  3%  perf-stat.i.branch-misses
      6.26 ±  7%     +14.3       20.53 ± 17%  perf-stat.i.cache-miss-rate%
  93314796 ±  6%    +147.2%  2.307e+08 ± 10%  perf-stat.i.cache-misses
 1.569e+09           -26.2%  1.158e+09 ±  6%  perf-stat.i.cache-references
   7953259           -16.9%    6606167 ±  3%  perf-stat.i.context-switches
      1.65           +15.5%       1.91 ±  3%  perf-stat.i.cpi
  1.76e+11            -4.0%  1.689e+11        perf-stat.i.cpu-cycles
      1989 ±  7%     -61.6%     764.42 ± 10%  perf-stat.i.cycles-between-cache-misses
    942230 ±  7%     +48.2%    1396336 ±  6%  perf-stat.i.dTLB-load-misses
 3.099e+10           -16.7%  2.581e+10 ±  3%  perf-stat.i.dTLB-loads
 1.867e+10           -16.6%  1.556e+10 ±  3%  perf-stat.i.dTLB-stores
 2.638e+08           -18.1%  2.161e+08 ±  3%  perf-stat.i.iTLB-load-misses
 2.261e+08 ±  2%     -15.0%  1.921e+08 ±  3%  perf-stat.i.iTLB-loads
 1.088e+11           -16.7%  9.066e+10 ±  3%  perf-stat.i.instructions
      0.62           -13.2%       0.53 ±  3%  perf-stat.i.ipc
      1.22            -4.0%       1.17        perf-stat.i.metric.GHz
    508.81           -16.7%     423.92 ±  3%  perf-stat.i.metric.M/sec
  52969510 ±  6%    +148.0%  1.313e+08 ± 12%  perf-stat.i.node-load-misses
  17086736 ±  6%    +157.6%   44016773 ± 10%  perf-stat.i.node-store-misses
     64311 ± 11%     -34.9%      41851 ± 14%  perf-stat.i.node-stores
     14.42           -11.5%      12.76 ±  3%  perf-stat.overall.MPKI
      5.95 ±  7%     +14.2       20.16 ± 17%  perf-stat.overall.cache-miss-rate%
      1.62           +15.3%       1.87 ±  2%  perf-stat.overall.cpi
      1896 ±  7%     -61.0%     740.44 ± 10%  perf-stat.overall.cycles-between-cache-misses
      0.00 ±  7%      +0.0        0.01 ±  5%  perf-stat.overall.dTLB-load-miss-rate%
      0.00 ± 14%      +0.0        0.00 ± 13%  perf-stat.overall.dTLB-store-miss-rate%
    412.39            +1.7%     419.58        perf-stat.overall.instructions-per-iTLB-miss
      0.62           -13.2%       0.54 ±  2%  perf-stat.overall.ipc
 2.166e+10           -16.6%  1.808e+10 ±  3%  perf-stat.ps.branch-instructions
 3.604e+08           -16.8%      3e+08 ±  3%  perf-stat.ps.branch-misses
  92988755 ±  7%    +147.2%  2.299e+08 ± 10%  perf-stat.ps.cache-misses
 1.563e+09           -26.2%  1.154e+09 ±  6%  perf-stat.ps.cache-references
   7926179           -16.9%    6584156 ±  3%  perf-stat.ps.context-switches
 1.754e+11            -4.0%  1.684e+11        perf-stat.ps.cpu-cycles
    939926 ±  7%     +48.1%    1392168 ±  6%  perf-stat.ps.dTLB-load-misses
 3.089e+10           -16.7%  2.572e+10 ±  3%  perf-stat.ps.dTLB-loads
  1.86e+10           -16.6%  1.551e+10 ±  3%  perf-stat.ps.dTLB-stores
 2.629e+08           -18.1%  2.153e+08 ±  3%  perf-stat.ps.iTLB-load-misses
 2.253e+08 ±  2%     -15.0%  1.915e+08 ±  3%  perf-stat.ps.iTLB-loads
 1.084e+11           -16.7%  9.036e+10 ±  3%  perf-stat.ps.instructions
  52782616 ±  6%    +147.9%  1.309e+08 ± 11%  perf-stat.ps.node-load-misses
  17027286 ±  6%    +157.6%   43860947 ± 10%  perf-stat.ps.node-store-misses
     64160 ± 11%     -34.9%      41770 ± 14%  perf-stat.ps.node-stores
 3.318e+13           -16.7%  2.766e+13 ±  3%  perf-stat.total.instructions
   3506997 ±  4%     -16.4%    2933100 ±  6%  softirqs.CPU0.NET_RX
   3903901           -16.8%    3247945 ±  9%  softirqs.CPU1.NET_RX
   4694083 ±  5%     -17.7%    3862507 ±  5%  softirqs.CPU100.NET_RX
   4923774 ±  4%     -21.1%    3886686 ±  9%  softirqs.CPU101.NET_RX
   4869616 ±  4%     -21.7%    3812313 ±  7%  softirqs.CPU102.NET_RX
   4918475           -21.0%    3883466 ±  4%  softirqs.CPU103.NET_RX
   4906196 ±  2%     -18.7%    3988389 ±  8%  softirqs.CPU104.NET_RX
   5016457 ±  3%     -21.6%    3933099 ±  8%  softirqs.CPU105.NET_RX
   4787127 ±  2%     -21.6%    3751065 ±  4%  softirqs.CPU106.NET_RX
   4557257 ±  5%     -15.5%    3853062 ± 10%  softirqs.CPU107.NET_RX
   3989557 ±  5%     -12.8%    3477707 ±  3%  softirqs.CPU108.NET_RX
   4426957 ±  5%     -19.5%    3561527 ±  6%  softirqs.CPU109.NET_RX
   4509964 ±  3%     -21.2%    3555033 ±  7%  softirqs.CPU110.NET_RX
   4650935 ±  4%     -19.0%    3766095        softirqs.CPU111.NET_RX
   4979607 ±  3%     -26.8%    3644489        softirqs.CPU112.NET_RX
   4802807 ±  5%     -18.8%    3902056 ±  3%  softirqs.CPU113.NET_RX
   4600130 ±  4%     -17.7%    3787307 ±  6%  softirqs.CPU114.NET_RX
   4846524 ±  2%     -19.7%    3890526 ±  6%  softirqs.CPU115.NET_RX
   4848325 ±  4%     -18.5%    3949458 ±  4%  softirqs.CPU116.NET_RX
   4841593 ±  4%     -23.3%    3713749 ±  5%  softirqs.CPU117.NET_RX
   4962625 ±  4%     -24.9%    3724765 ±  2%  softirqs.CPU118.NET_RX
   4878386 ±  2%     -21.7%    3821724 ±  2%  softirqs.CPU119.NET_RX
   3671284 ±  2%     -11.9%    3236225 ±  6%  softirqs.CPU12.NET_RX
   4804326 ±  2%     -22.5%    3722890 ±  7%  softirqs.CPU120.NET_RX
   4810032 ±  2%     -20.8%    3810281 ±  4%  softirqs.CPU121.NET_RX
   4674701 ±  2%     -19.9%    3743600        softirqs.CPU122.NET_RX
   4820533 ±  3%     -21.6%    3778337 ±  5%  softirqs.CPU123.NET_RX
   4963991 ±  3%     -25.1%    3718717 ±  3%  softirqs.CPU124.NET_RX
   4757180 ±  4%     -21.5%    3734017 ±  4%  softirqs.CPU125.NET_RX
   4178313 ±  3%     -18.5%    3406188 ±  6%  softirqs.CPU126.NET_RX
   4577315 ±  2%     -22.0%    3569736 ±  9%  softirqs.CPU127.NET_RX
   4518891 ±  4%     -16.9%    3756407 ±  6%  softirqs.CPU128.NET_RX
   4579776           -20.3%    3648330 ±  7%  softirqs.CPU129.NET_RX
   4759539 ±  2%     -21.6%    3731311 ±  5%  softirqs.CPU130.NET_RX
   4803880 ±  3%     -21.9%    3750895 ± 10%  softirqs.CPU131.NET_RX
   4965998 ±  6%     -22.0%    3874282 ± 11%  softirqs.CPU132.NET_RX
   4790232 ±  4%     -19.1%    3876366 ±  7%  softirqs.CPU133.NET_RX
   4990987 ±  5%     -23.6%    3812578 ±  9%  softirqs.CPU134.NET_RX
   4699132 ±  6%     -22.7%    3631829 ± 11%  softirqs.CPU135.NET_RX
   5016814           -24.7%    3776072 ±  9%  softirqs.CPU136.NET_RX
   4924422 ±  2%     -21.9%    3845930 ±  8%  softirqs.CPU137.NET_RX
   4750549 ±  2%     -22.1%    3698942 ± 10%  softirqs.CPU138.NET_RX
   4770625 ±  2%     -19.4%    3844132 ±  7%  softirqs.CPU139.NET_RX
   4744799 ±  2%     -24.6%    3577218 ±  7%  softirqs.CPU140.NET_RX
   4825357 ±  2%     -18.5%    3931362 ± 12%  softirqs.CPU141.NET_RX
   4797723 ±  6%     -24.5%    3620678 ±  7%  softirqs.CPU142.NET_RX
   3969978 ±  2%     -24.0%    3016623 ±  9%  softirqs.CPU143.NET_RX
   3867599 ±  3%     -14.1%    3322296 ±  4%  softirqs.CPU19.NET_RX
   3714385           -13.5%    3213699 ±  7%  softirqs.CPU2.NET_RX
   3515022 ±  3%     -15.3%    2976763 ±  6%  softirqs.CPU25.NET_RX
   3524413           -16.3%    2950764 ±  3%  softirqs.CPU26.NET_RX
   3721828 ±  6%     -16.2%    3118466 ±  6%  softirqs.CPU28.NET_RX
   3664085 ±  3%     -13.4%    3174913 ±  6%  softirqs.CPU29.NET_RX
   3737605 ±  3%     -17.7%    3077711 ±  6%  softirqs.CPU3.NET_RX
   3657333 ±  3%     -15.6%    3088177 ±  8%  softirqs.CPU30.NET_RX
   3519665 ±  2%     -15.1%    2988581 ±  7%  softirqs.CPU32.NET_RX
   3546129 ±  7%     -13.7%    3059612 ±  5%  softirqs.CPU35.NET_RX
   3914634 ±  4%     -17.7%    3220023        softirqs.CPU36.NET_RX
   3889312 ±  4%     -16.7%    3239074 ±  7%  softirqs.CPU37.NET_RX
   3892937 ±  4%     -15.4%    3294655 ±  4%  softirqs.CPU38.NET_RX
   3801244 ±  5%     -17.4%    3140858 ±  4%  softirqs.CPU39.NET_RX
   3637839 ±  7%     -16.3%    3045183 ±  2%  softirqs.CPU41.NET_RX
   3907951           -19.4%    3151345 ±  6%  softirqs.CPU42.NET_RX
   3761489 ±  2%     -17.3%    3109370 ±  4%  softirqs.CPU43.NET_RX
   3723387 ±  2%     -18.1%    3047921 ±  3%  softirqs.CPU44.NET_RX
   3660934           -13.8%    3156447 ±  5%  softirqs.CPU45.NET_RX
   3711314 ±  5%     -13.8%    3199313 ±  5%  softirqs.CPU46.NET_RX
   3688112 ±  2%     -14.7%    3144122 ±  4%  softirqs.CPU47.NET_RX
   3786695 ±  2%     -14.9%    3223894 ±  7%  softirqs.CPU48.NET_RX
   3635194 ±  3%     -15.7%    3066106 ±  4%  softirqs.CPU49.NET_RX
   3703974 ±  7%     -15.3%    3139087 ±  2%  softirqs.CPU50.NET_RX
   3714001 ±  5%     -14.2%    3186517 ±  3%  softirqs.CPU51.NET_RX
   3518991 ±  4%      -9.8%    3175381 ±  4%  softirqs.CPU52.NET_RX
   3520297 ±  4%     -13.1%    3060815 ±  5%  softirqs.CPU53.NET_RX
   3716157 ±  2%     -15.9%    3123436 ±  8%  softirqs.CPU54.NET_RX
   3666897 ±  2%     -15.9%    3083062 ±  9%  softirqs.CPU55.NET_RX
   3864789 ±  3%     -18.5%    3149120 ± 12%  softirqs.CPU56.NET_RX
   3711210           -17.9%    3048231 ±  8%  softirqs.CPU57.NET_RX
   3679783 ±  2%     -17.8%    3025671 ±  7%  softirqs.CPU59.NET_RX
   3637873 ±  4%     -13.3%    3153071 ±  6%  softirqs.CPU6.NET_RX
   3723407 ±  4%     -16.4%    3111734 ± 11%  softirqs.CPU61.NET_RX
   3788311 ±  4%     -13.5%    3278070 ±  7%  softirqs.CPU63.NET_RX
   3601558           -12.7%    3145208 ± 11%  softirqs.CPU64.NET_RX
   3694909           -13.5%    3196495 ±  8%  softirqs.CPU65.NET_RX
   3694166 ±  4%     -14.7%    3152138 ± 10%  softirqs.CPU66.NET_RX
   3695641 ±  4%     -16.2%    3095356 ±  7%  softirqs.CPU67.NET_RX
   3712425 ±  6%     -19.2%    3000879 ±  4%  softirqs.CPU69.NET_RX
   3754021 ±  2%     -13.4%    3249767 ±  9%  softirqs.CPU7.NET_RX
   3994248 ±  3%     -14.3%    3423955 ±  7%  softirqs.CPU71.NET_RX
   4497273 ±  3%      -9.8%    4057857 ±  4%  softirqs.CPU73.NET_RX
   4708310 ±  2%     -14.8%    4012194 ±  5%  softirqs.CPU74.NET_RX
   4681992 ±  4%     -12.7%    4089027        softirqs.CPU75.NET_RX
   4874851 ±  5%     -18.7%    3963093 ±  4%  softirqs.CPU76.NET_RX
   4904138           -18.3%    4006997 ±  4%  softirqs.CPU77.NET_RX
   4973767 ±  2%     -17.1%    4122604 ±  4%  softirqs.CPU78.NET_RX
   4796795           -15.3%    4061543 ±  4%  softirqs.CPU79.NET_RX
   5013123 ±  5%     -21.4%    3938543 ±  3%  softirqs.CPU80.NET_RX
   4943538           -15.8%    4160931 ±  2%  softirqs.CPU81.NET_RX
   4879433           -18.6%    3970630 ±  3%  softirqs.CPU82.NET_RX
   4907139 ±  3%     -19.1%    3971135 ±  2%  softirqs.CPU83.NET_RX
   4779878 ±  2%     -16.3%    4002421        softirqs.CPU84.NET_RX
   4881043 ±  3%     -18.1%    3996600 ±  2%  softirqs.CPU85.NET_RX
   4869262 ±  2%     -17.1%    4036233 ±  6%  softirqs.CPU86.NET_RX
   4907304 ±  5%     -17.7%    4038111 ±  4%  softirqs.CPU87.NET_RX
   4843958           -16.4%    4050836 ±  4%  softirqs.CPU88.NET_RX
   4624455 ±  5%     -15.6%    3902318 ±  5%  softirqs.CPU89.NET_RX
   4233853 ±  6%     -17.3%    3500555 ±  5%  softirqs.CPU90.NET_RX
   4490834           -20.0%    3591973 ± 10%  softirqs.CPU91.NET_RX
   4662654 ±  3%     -21.3%    3671296 ±  6%  softirqs.CPU92.NET_RX
   4781582 ±  3%     -23.5%    3660134 ±  9%  softirqs.CPU93.NET_RX
   4838586 ±  4%     -23.0%    3725348 ±  7%  softirqs.CPU94.NET_RX
   4836798 ±  4%     -22.7%    3738511 ±  4%  softirqs.CPU95.NET_RX
   4998673 ±  6%     -23.3%    3833021 ± 10%  softirqs.CPU96.NET_RX
   4971178           -17.5%    4101849 ±  8%  softirqs.CPU97.NET_RX
   4961621           -19.5%    3996158 ± 10%  softirqs.CPU98.NET_RX
   4882725 ±  3%     -22.1%    3803195 ±  5%  softirqs.CPU99.NET_RX
 6.064e+08           -16.9%  5.037e+08 ±  3%  softirqs.NET_RX
    562373 ±  4%     +87.4%    1053723 ± 10%  interrupts.CAL:Function_call_interrupts
      7019 ±  9%     +28.4%       9011 ±  4%  interrupts.CPU0.CAL:Function_call_interrupts
     11626 ±  2%     -27.8%       8399 ±  8%  interrupts.CPU0.RES:Rescheduling_interrupts
      4874 ±  9%     +50.6%       7341 ± 15%  interrupts.CPU1.CAL:Function_call_interrupts
     11774 ±  4%     -29.6%       8284 ± 11%  interrupts.CPU1.RES:Rescheduling_interrupts
      4306 ±  5%     +56.8%       6753 ± 16%  interrupts.CPU10.CAL:Function_call_interrupts
     11496 ±  5%     -21.0%       9085 ±  8%  interrupts.CPU10.RES:Rescheduling_interrupts
      3162 ± 14%    +131.4%       7318 ± 13%  interrupts.CPU100.CAL:Function_call_interrupts
     15326 ±  6%     -32.1%      10399 ± 14%  interrupts.CPU100.RES:Rescheduling_interrupts
      3355 ±  7%    +113.9%       7177 ± 16%  interrupts.CPU101.CAL:Function_call_interrupts
     15643 ±  4%     -34.9%      10181 ± 20%  interrupts.CPU101.RES:Rescheduling_interrupts
      3179          +130.9%       7340 ± 15%  interrupts.CPU102.CAL:Function_call_interrupts
     15900 ±  3%     -38.2%       9833 ± 14%  interrupts.CPU102.RES:Rescheduling_interrupts
      3126 ± 11%    +138.6%       7460 ± 24%  interrupts.CPU103.CAL:Function_call_interrupts
     16102 ±  3%     -37.0%      10149 ± 18%  interrupts.CPU103.RES:Rescheduling_interrupts
      3261 ±  6%    +124.0%       7306 ±  8%  interrupts.CPU104.CAL:Function_call_interrupts
     16195 ±  4%     -32.7%      10892 ± 18%  interrupts.CPU104.RES:Rescheduling_interrupts
      3402 ± 10%    +125.1%       7659 ± 12%  interrupts.CPU105.CAL:Function_call_interrupts
     16183 ±  5%     -38.8%       9910 ± 19%  interrupts.CPU105.RES:Rescheduling_interrupts
      3684 ± 14%    +100.4%       7381 ± 15%  interrupts.CPU106.CAL:Function_call_interrupts
     15362 ±  4%     -36.6%       9744 ± 15%  interrupts.CPU106.RES:Rescheduling_interrupts
      4022 ±  8%     +78.6%       7181 ± 18%  interrupts.CPU107.CAL:Function_call_interrupts
      4087 ± 26%     +25.9%       5146 ±  3%  interrupts.CPU107.NMI:Non-maskable_interrupts
      4087 ± 26%     +25.9%       5146 ±  3%  interrupts.CPU107.PMI:Performance_monitoring_interrupts
     14902 ±  7%     -29.1%      10571 ± 20%  interrupts.CPU107.RES:Rescheduling_interrupts
      3480 ±  6%     +95.5%       6802 ±  8%  interrupts.CPU108.CAL:Function_call_interrupts
     12731 ±  4%     -24.1%       9667 ±  7%  interrupts.CPU108.RES:Rescheduling_interrupts
      3674 ±  8%    +104.5%       7515 ± 14%  interrupts.CPU109.CAL:Function_call_interrupts
     13686 ±  4%     -37.9%       8492 ±  6%  interrupts.CPU109.RES:Rescheduling_interrupts
      4362 ±  7%     +60.9%       7020 ± 15%  interrupts.CPU11.CAL:Function_call_interrupts
     11724 ±  2%     -25.1%       8785 ±  5%  interrupts.CPU11.RES:Rescheduling_interrupts
      3640 ±  6%     +92.4%       7005 ± 10%  interrupts.CPU110.CAL:Function_call_interrupts
     13753 ±  4%     -38.4%       8467 ±  5%  interrupts.CPU110.RES:Rescheduling_interrupts
      3372          +109.6%       7069 ±  7%  interrupts.CPU111.CAL:Function_call_interrupts
     14581 ±  3%     -35.6%       9388 ±  7%  interrupts.CPU111.RES:Rescheduling_interrupts
      3433 ±  7%    +128.2%       7834 ± 15%  interrupts.CPU112.CAL:Function_call_interrupts
     15284 ±  5%     -44.4%       8503 ±  8%  interrupts.CPU112.RES:Rescheduling_interrupts
      3452 ±  2%    +111.6%       7306 ±  8%  interrupts.CPU113.CAL:Function_call_interrupts
     15148 ±  5%     -37.1%       9533 ±  8%  interrupts.CPU113.RES:Rescheduling_interrupts
      3451 ±  6%    +116.1%       7458 ±  6%  interrupts.CPU114.CAL:Function_call_interrupts
     13784 ±  8%     -33.8%       9126 ±  8%  interrupts.CPU114.RES:Rescheduling_interrupts
      3446 ±  6%    +110.8%       7265 ±  5%  interrupts.CPU115.CAL:Function_call_interrupts
     14748 ±  4%     -36.8%       9318 ± 14%  interrupts.CPU115.RES:Rescheduling_interrupts
      3335 ±  5%    +122.9%       7435 ±  2%  interrupts.CPU116.CAL:Function_call_interrupts
     15556 ±  8%     -36.0%       9953 ±  7%  interrupts.CPU116.RES:Rescheduling_interrupts
      3256 ±  5%    +121.2%       7202 ±  5%  interrupts.CPU117.CAL:Function_call_interrupts
     15523 ±  5%     -39.0%       9468 ± 11%  interrupts.CPU117.RES:Rescheduling_interrupts
      3273 ±  7%    +138.2%       7797 ±  2%  interrupts.CPU118.CAL:Function_call_interrupts
     15447 ±  7%     -42.6%       8864 ±  7%  interrupts.CPU118.RES:Rescheduling_interrupts
      3526 ±  3%    +112.7%       7501 ±  2%  interrupts.CPU119.CAL:Function_call_interrupts
     14871           -37.0%       9364 ±  7%  interrupts.CPU119.RES:Rescheduling_interrupts
      4509 ±  8%     +50.1%       6768 ±  8%  interrupts.CPU12.CAL:Function_call_interrupts
     11536 ±  4%     -24.6%       8698 ±  8%  interrupts.CPU12.RES:Rescheduling_interrupts
      3381 ±  6%    +109.8%       7092 ±  8%  interrupts.CPU120.CAL:Function_call_interrupts
     14941 ±  4%     -38.5%       9184 ± 20%  interrupts.CPU120.RES:Rescheduling_interrupts
      3596 ±  7%    +107.2%       7451 ±  5%  interrupts.CPU121.CAL:Function_call_interrupts
     15041 ±  6%     -38.4%       9264 ±  9%  interrupts.CPU121.RES:Rescheduling_interrupts
      3823 ±  7%     +96.8%       7525 ±  9%  interrupts.CPU122.CAL:Function_call_interrupts
     14368 ±  5%     -37.6%       8972 ± 12%  interrupts.CPU122.RES:Rescheduling_interrupts
      3692 ±  5%     +98.0%       7310 ±  7%  interrupts.CPU123.CAL:Function_call_interrupts
     14744           -39.7%       8896 ± 17%  interrupts.CPU123.RES:Rescheduling_interrupts
      3684          +105.5%       7570 ± 11%  interrupts.CPU124.CAL:Function_call_interrupts
      4377 ± 21%     +19.7%       5240 ±  5%  interrupts.CPU124.NMI:Non-maskable_interrupts
      4377 ± 21%     +19.7%       5240 ±  5%  interrupts.CPU124.PMI:Performance_monitoring_interrupts
     15441 ±  5%     -42.1%       8939 ±  3%  interrupts.CPU124.RES:Rescheduling_interrupts
      3932 ±  8%     +94.2%       7638 ±  8%  interrupts.CPU125.CAL:Function_call_interrupts
     14672 ±  7%     -38.9%       8961 ± 11%  interrupts.CPU125.RES:Rescheduling_interrupts
      4046 ±  3%     +92.8%       7799 ± 27%  interrupts.CPU126.CAL:Function_call_interrupts
     13843 ±  4%     -29.3%       9786 ± 24%  interrupts.CPU126.RES:Rescheduling_interrupts
      3748 ±  5%    +122.0%       8320 ± 21%  interrupts.CPU127.CAL:Function_call_interrupts
     14797 ±  5%     -39.1%       9014 ± 24%  interrupts.CPU127.RES:Rescheduling_interrupts
      3937 ±  8%     +93.5%       7618 ± 26%  interrupts.CPU128.CAL:Function_call_interrupts
     14775 ±  7%     -34.6%       9666 ± 17%  interrupts.CPU128.RES:Rescheduling_interrupts
      3569 ±  5%    +120.9%       7885 ± 23%  interrupts.CPU129.CAL:Function_call_interrupts
     15648 ±  2%     -37.7%       9748 ± 17%  interrupts.CPU129.RES:Rescheduling_interrupts
      4248 ±  3%     +60.3%       6808 ± 14%  interrupts.CPU13.CAL:Function_call_interrupts
     11049 ±  3%     -22.8%       8525 ±  8%  interrupts.CPU13.RES:Rescheduling_interrupts
      3739 ±  4%    +138.1%       8903 ± 28%  interrupts.CPU130.CAL:Function_call_interrupts
     15859 ±  4%     -34.7%      10349 ± 22%  interrupts.CPU130.RES:Rescheduling_interrupts
      3407 ±  9%    +132.8%       7930 ± 19%  interrupts.CPU131.CAL:Function_call_interrupts
     16050 ±  6%     -38.2%       9925 ± 26%  interrupts.CPU131.RES:Rescheduling_interrupts
      3721 ±  3%    +124.7%       8360 ± 26%  interrupts.CPU132.CAL:Function_call_interrupts
     16353 ± 10%     -39.7%       9855 ± 28%  interrupts.CPU132.RES:Rescheduling_interrupts
      3596 ±  5%    +126.5%       8146 ± 26%  interrupts.CPU133.CAL:Function_call_interrupts
     15380 ±  5%     -34.6%      10055 ± 21%  interrupts.CPU133.RES:Rescheduling_interrupts
      3739 ±  5%    +124.4%       8391 ± 29%  interrupts.CPU134.CAL:Function_call_interrupts
     16643 ± 10%     -39.6%      10058 ± 30%  interrupts.CPU134.RES:Rescheduling_interrupts
      3583 ±  5%    +127.1%       8139 ± 16%  interrupts.CPU135.CAL:Function_call_interrupts
     15844 ± 10%     -34.5%      10380 ± 28%  interrupts.CPU135.RES:Rescheduling_interrupts
      3464 ±  5%    +138.6%       8266 ± 24%  interrupts.CPU136.CAL:Function_call_interrupts
     16464 ±  4%     -43.0%       9384 ± 28%  interrupts.CPU136.RES:Rescheduling_interrupts
      3521 ±  6%    +116.2%       7614 ± 15%  interrupts.CPU137.CAL:Function_call_interrupts
     16015 ±  5%     -36.2%      10216 ± 17%  interrupts.CPU137.RES:Rescheduling_interrupts
      3689 ± 13%    +119.2%       8086 ± 30%  interrupts.CPU138.CAL:Function_call_interrupts
     15693 ±  4%     -38.8%       9606 ± 25%  interrupts.CPU138.RES:Rescheduling_interrupts
      3583 ±  5%    +114.6%       7688 ± 25%  interrupts.CPU139.CAL:Function_call_interrupts
      5396 ±  7%     -24.1%       4095 ± 30%  interrupts.CPU139.NMI:Non-maskable_interrupts
      5396 ±  7%     -24.1%       4095 ± 30%  interrupts.CPU139.PMI:Performance_monitoring_interrupts
     15751 ±  3%     -34.5%      10312 ± 19%  interrupts.CPU139.RES:Rescheduling_interrupts
      4157 ±  7%     +65.2%       6870 ± 14%  interrupts.CPU14.CAL:Function_call_interrupts
     11063 ±  3%     -23.8%       8425 ±  5%  interrupts.CPU14.RES:Rescheduling_interrupts
      3675 ±  8%    +115.3%       7912 ± 21%  interrupts.CPU140.CAL:Function_call_interrupts
     15412 ±  5%     -37.8%       9590 ± 20%  interrupts.CPU140.RES:Rescheduling_interrupts
      3590 ± 10%    +115.7%       7743 ± 22%  interrupts.CPU141.CAL:Function_call_interrupts
     15596 ±  4%     -33.8%      10320 ± 27%  interrupts.CPU141.RES:Rescheduling_interrupts
      3738 ±  5%    +109.9%       7846 ± 23%  interrupts.CPU142.CAL:Function_call_interrupts
     15253 ±  4%     -39.8%       9182 ± 21%  interrupts.CPU142.RES:Rescheduling_interrupts
      4063 ±  3%     +86.7%       7584 ± 21%  interrupts.CPU143.CAL:Function_call_interrupts
     13302 ±  2%     -41.4%       7796 ± 22%  interrupts.CPU143.RES:Rescheduling_interrupts
      4300 ±  9%     +59.4%       6853 ± 18%  interrupts.CPU15.CAL:Function_call_interrupts
     11275 ±  4%     -19.2%       9105 ±  4%  interrupts.CPU15.RES:Rescheduling_interrupts
      4241 ± 10%     +66.1%       7043 ± 16%  interrupts.CPU16.CAL:Function_call_interrupts
     10910 ±  4%     -22.9%       8407 ±  7%  interrupts.CPU16.RES:Rescheduling_interrupts
      4154 ±  6%     +65.0%       6854 ± 19%  interrupts.CPU17.CAL:Function_call_interrupts
     11484 ±  2%     -24.2%       8704 ± 13%  interrupts.CPU17.RES:Rescheduling_interrupts
      5547 ± 15%     +49.8%       8309 ± 16%  interrupts.CPU18.CAL:Function_call_interrupts
     11804 ±  5%     -27.2%       8589 ± 20%  interrupts.CPU18.RES:Rescheduling_interrupts
      4505 ±  9%     +71.6%       7732 ± 16%  interrupts.CPU19.CAL:Function_call_interrupts
     12342 ±  5%     -31.5%       8449 ± 16%  interrupts.CPU19.RES:Rescheduling_interrupts
      4629 ±  2%     +60.0%       7409 ±  8%  interrupts.CPU2.CAL:Function_call_interrupts
     11216 ±  3%     -25.1%       8396 ±  8%  interrupts.CPU2.RES:Rescheduling_interrupts
      4244 ± 13%     +64.1%       6967 ± 18%  interrupts.CPU20.CAL:Function_call_interrupts
     11723 ±  4%     -25.2%       8770 ± 16%  interrupts.CPU20.RES:Rescheduling_interrupts
      4046 ±  8%     +74.6%       7062 ± 20%  interrupts.CPU21.CAL:Function_call_interrupts
     11251 ±  4%     -22.8%       8682 ± 17%  interrupts.CPU21.RES:Rescheduling_interrupts
      4104 ±  6%     +69.5%       6959 ± 18%  interrupts.CPU22.CAL:Function_call_interrupts
      3904 ± 11%     +77.3%       6922 ± 17%  interrupts.CPU23.CAL:Function_call_interrupts
     11419 ±  7%     -26.4%       8407 ± 20%  interrupts.CPU23.RES:Rescheduling_interrupts
      3894 ±  6%     +72.7%       6726 ± 19%  interrupts.CPU24.CAL:Function_call_interrupts
     11137 ±  6%     -22.7%       8609 ± 21%  interrupts.CPU24.RES:Rescheduling_interrupts
      3807 ± 12%     +67.6%       6379 ± 11%  interrupts.CPU25.CAL:Function_call_interrupts
     11159 ±  2%     -32.6%       7517 ± 15%  interrupts.CPU25.RES:Rescheduling_interrupts
      3756 ±  9%     +80.0%       6762 ± 15%  interrupts.CPU26.CAL:Function_call_interrupts
     11288 ±  3%     -33.7%       7489 ± 12%  interrupts.CPU26.RES:Rescheduling_interrupts
      3827 ± 10%     +74.5%       6678 ± 21%  interrupts.CPU27.CAL:Function_call_interrupts
     11224 ±  5%     -25.5%       8364 ± 19%  interrupts.CPU27.RES:Rescheduling_interrupts
      3703 ± 13%     +83.1%       6783 ± 14%  interrupts.CPU28.CAL:Function_call_interrupts
     11910 ± 10%     -30.6%       8262 ± 17%  interrupts.CPU28.RES:Rescheduling_interrupts
      3683 ± 10%     +74.4%       6422 ± 19%  interrupts.CPU29.CAL:Function_call_interrupts
     11587 ±  7%     -28.7%       8257 ± 13%  interrupts.CPU29.RES:Rescheduling_interrupts
      4061 ±  2%     +75.6%       7132 ± 13%  interrupts.CPU3.CAL:Function_call_interrupts
     11536 ±  4%     -32.9%       7746 ±  8%  interrupts.CPU3.RES:Rescheduling_interrupts
      3677 ± 10%     +80.3%       6630 ± 17%  interrupts.CPU30.CAL:Function_call_interrupts
     11500 ±  7%     -31.7%       7854 ± 19%  interrupts.CPU30.RES:Rescheduling_interrupts
      3556 ± 10%     +76.3%       6269 ± 16%  interrupts.CPU31.CAL:Function_call_interrupts
     11927 ±  6%     -32.1%       8093 ± 24%  interrupts.CPU31.RES:Rescheduling_interrupts
      3880 ±  7%     +68.0%       6519 ± 19%  interrupts.CPU32.CAL:Function_call_interrupts
     11463 ±  3%     -30.7%       7944 ± 18%  interrupts.CPU32.RES:Rescheduling_interrupts
      3648 ± 15%     +75.9%       6416 ± 18%  interrupts.CPU33.CAL:Function_call_interrupts
     11090 ±  8%     -27.7%       8019 ± 14%  interrupts.CPU33.RES:Rescheduling_interrupts
      3924 ±  8%     +64.2%       6444 ± 19%  interrupts.CPU34.CAL:Function_call_interrupts
     11190 ±  6%     -20.6%       8882 ± 16%  interrupts.CPU34.RES:Rescheduling_interrupts
      3981 ±  3%     +62.6%       6473 ± 19%  interrupts.CPU35.CAL:Function_call_interrupts
     11376 ±  6%     -28.6%       8117 ± 17%  interrupts.CPU35.RES:Rescheduling_interrupts
      5232 ±  3%     +61.3%       8439 ± 10%  interrupts.CPU36.CAL:Function_call_interrupts
     12049 ±  7%     -33.0%       8076 ±  6%  interrupts.CPU36.RES:Rescheduling_interrupts
      4684 ±  6%     +65.4%       7748 ±  4%  interrupts.CPU37.CAL:Function_call_interrupts
     11799 ±  6%     -33.6%       7836 ± 16%  interrupts.CPU37.RES:Rescheduling_interrupts
      4382 ±  6%     +69.0%       7407 ±  4%  interrupts.CPU38.CAL:Function_call_interrupts
     11762 ±  9%     -30.9%       8129 ± 10%  interrupts.CPU38.RES:Rescheduling_interrupts
      4089 ±  4%     +68.1%       6875 ±  9%  interrupts.CPU39.CAL:Function_call_interrupts
      3245 ± 24%     -18.7%       2638 ± 26%  interrupts.CPU39.NMI:Non-maskable_interrupts
      3245 ± 24%     -18.7%       2638 ± 26%  interrupts.CPU39.PMI:Performance_monitoring_interrupts
     11403 ± 10%     -33.2%       7613 ± 13%  interrupts.CPU39.RES:Rescheduling_interrupts
      4297 ±  2%     +69.2%       7271 ± 11%  interrupts.CPU4.CAL:Function_call_interrupts
     11042 ±  3%     -25.6%       8215 ±  4%  interrupts.CPU4.RES:Rescheduling_interrupts
      4186 ±  7%     +67.4%       7006 ±  5%  interrupts.CPU40.CAL:Function_call_interrupts
     10088 ± 11%     -22.3%       7833 ± 14%  interrupts.CPU40.RES:Rescheduling_interrupts
      4142 ±  7%     +66.9%       6912 ±  6%  interrupts.CPU41.CAL:Function_call_interrupts
     11096 ± 12%     -33.0%       7433 ±  7%  interrupts.CPU41.RES:Rescheduling_interrupts
      4022 ±  7%     +71.3%       6892 ±  5%  interrupts.CPU42.CAL:Function_call_interrupts
     11657 ±  4%     -33.5%       7748 ± 11%  interrupts.CPU42.RES:Rescheduling_interrupts
      3999 ±  3%     +70.9%       6835 ±  7%  interrupts.CPU43.CAL:Function_call_interrupts
     11295 ±  4%     -35.0%       7347 ±  5%  interrupts.CPU43.RES:Rescheduling_interrupts
      3961 ±  5%     +62.2%       6425 ±  7%  interrupts.CPU44.CAL:Function_call_interrupts
     11562 ±  3%     -31.4%       7929 ±  7%  interrupts.CPU44.RES:Rescheduling_interrupts
      3980 ±  4%     +77.1%       7049 ± 10%  interrupts.CPU45.CAL:Function_call_interrupts
     11151 ±  4%     -30.3%       7767 ±  3%  interrupts.CPU45.RES:Rescheduling_interrupts
      3852 ±  8%     +71.6%       6609 ±  9%  interrupts.CPU46.CAL:Function_call_interrupts
      2497 ± 29%     +60.0%       3995 ± 29%  interrupts.CPU46.NMI:Non-maskable_interrupts
      2497 ± 29%     +60.0%       3995 ± 29%  interrupts.CPU46.PMI:Performance_monitoring_interrupts
     11205 ±  6%     -29.7%       7875 ± 12%  interrupts.CPU46.RES:Rescheduling_interrupts
      4121 ±  9%     +59.0%       6553 ±  4%  interrupts.CPU47.CAL:Function_call_interrupts
     12440 ± 24%     -38.1%       7695 ±  4%  interrupts.CPU47.RES:Rescheduling_interrupts
      3989 ±  8%     +61.5%       6441 ± 10%  interrupts.CPU48.CAL:Function_call_interrupts
     11188 ±  5%     -31.7%       7641 ± 12%  interrupts.CPU48.RES:Rescheduling_interrupts
      3626 ±  6%     +76.2%       6387 ±  3%  interrupts.CPU49.CAL:Function_call_interrupts
     10995 ±  3%     -30.7%       7616 ± 11%  interrupts.CPU49.RES:Rescheduling_interrupts
      4635 ± 13%     +49.3%       6923 ± 11%  interrupts.CPU5.CAL:Function_call_interrupts
     12111 ± 12%     -31.6%       8288 ±  9%  interrupts.CPU5.RES:Rescheduling_interrupts
      3988 ±  6%     +73.4%       6913 ±  5%  interrupts.CPU50.CAL:Function_call_interrupts
     11280 ± 10%     -31.3%       7749 ±  9%  interrupts.CPU50.RES:Rescheduling_interrupts
      3982 ±  5%     +62.3%       6465 ±  5%  interrupts.CPU51.CAL:Function_call_interrupts
     11049 ±  7%     -28.4%       7911 ±  3%  interrupts.CPU51.RES:Rescheduling_interrupts
      3735 ±  4%     +76.2%       6582 ±  4%  interrupts.CPU52.CAL:Function_call_interrupts
     10603 ±  7%     -25.8%       7866 ±  7%  interrupts.CPU52.RES:Rescheduling_interrupts
      4102 ±  5%     +64.4%       6742 ±  9%  interrupts.CPU53.CAL:Function_call_interrupts
     10902 ±  7%     -31.7%       7447 ±  6%  interrupts.CPU53.RES:Rescheduling_interrupts
      5497 ±  2%     +63.2%       8971 ± 19%  interrupts.CPU54.CAL:Function_call_interrupts
     11852 ±  2%     -32.4%       8016 ± 26%  interrupts.CPU54.RES:Rescheduling_interrupts
      4533 ±  4%     +79.2%       8124 ± 19%  interrupts.CPU55.CAL:Function_call_interrupts
     11745           -35.0%       7628 ± 25%  interrupts.CPU55.RES:Rescheduling_interrupts
      4339 ±  3%     +79.5%       7789 ± 20%  interrupts.CPU56.CAL:Function_call_interrupts
     12506 ±  5%     -35.4%       8078 ± 28%  interrupts.CPU56.RES:Rescheduling_interrupts
      4289 ±  4%     +94.1%       8326 ± 20%  interrupts.CPU57.CAL:Function_call_interrupts
      4142 ±  4%     +76.8%       7322 ± 18%  interrupts.CPU58.CAL:Function_call_interrupts
     11691 ±  3%     -29.4%       8248 ± 23%  interrupts.CPU58.RES:Rescheduling_interrupts
      4133 ±  4%     +92.1%       7942 ± 18%  interrupts.CPU59.CAL:Function_call_interrupts
     12200 ±  3%     -38.0%       7564 ± 23%  interrupts.CPU59.RES:Rescheduling_interrupts
      4275 ±  3%     +62.9%       6963 ± 10%  interrupts.CPU6.CAL:Function_call_interrupts
     10993 ±  5%     -27.6%       7955 ±  5%  interrupts.CPU6.RES:Rescheduling_interrupts
      4085 ±  4%     +90.4%       7777 ± 20%  interrupts.CPU60.CAL:Function_call_interrupts
     11203 ±  8%     -30.2%       7817 ± 20%  interrupts.CPU60.RES:Rescheduling_interrupts
      3990 ±  6%     +91.6%       7643 ± 19%  interrupts.CPU61.CAL:Function_call_interrupts
     11525 ±  4%     -31.7%       7866 ± 24%  interrupts.CPU61.RES:Rescheduling_interrupts
      3831 ±  2%     +91.0%       7318 ± 17%  interrupts.CPU62.CAL:Function_call_interrupts
     11485 ±  4%     -29.1%       8139 ± 22%  interrupts.CPU62.RES:Rescheduling_interrupts
      4099 ±  5%     +83.5%       7523 ± 24%  interrupts.CPU63.CAL:Function_call_interrupts
     12337 ±  4%     -30.3%       8598 ± 22%  interrupts.CPU63.RES:Rescheduling_interrupts
      3889           +84.8%       7188 ± 16%  interrupts.CPU64.CAL:Function_call_interrupts
     11519 ±  2%     -28.3%       8263 ± 23%  interrupts.CPU64.RES:Rescheduling_interrupts
      3644 ±  5%    +100.7%       7314 ± 22%  interrupts.CPU65.CAL:Function_call_interrupts
     12153 ±  3%     -31.2%       8366 ± 20%  interrupts.CPU65.RES:Rescheduling_interrupts
      3899 ±  7%     +95.0%       7601 ± 22%  interrupts.CPU66.CAL:Function_call_interrupts
     12312 ±  4%     -32.5%       8315 ± 24%  interrupts.CPU66.RES:Rescheduling_interrupts
      4040 ±  3%     +78.1%       7198 ± 18%  interrupts.CPU67.CAL:Function_call_interrupts
     11975 ±  6%     -30.0%       8389 ± 18%  interrupts.CPU67.RES:Rescheduling_interrupts
      4118 ±  4%     +88.5%       7762 ± 15%  interrupts.CPU68.CAL:Function_call_interrupts
     12033           -29.9%       8430 ± 21%  interrupts.CPU68.RES:Rescheduling_interrupts
      3759 ±  6%    +100.3%       7532 ± 20%  interrupts.CPU69.CAL:Function_call_interrupts
     12265 ±  6%     -37.8%       7625 ± 15%  interrupts.CPU69.RES:Rescheduling_interrupts
      4275 ±  7%     +55.9%       6665 ±  8%  interrupts.CPU7.CAL:Function_call_interrupts
      4840 ±  8%     -33.5%       3217 ± 34%  interrupts.CPU7.NMI:Non-maskable_interrupts
      4840 ±  8%     -33.5%       3217 ± 34%  interrupts.CPU7.PMI:Performance_monitoring_interrupts
     11313           -28.5%       8084 ± 12%  interrupts.CPU7.RES:Rescheduling_interrupts
      4282 ±  4%     +82.1%       7799 ± 14%  interrupts.CPU70.CAL:Function_call_interrupts
     11818 ± 10%     -31.9%       8053 ± 21%  interrupts.CPU70.RES:Rescheduling_interrupts
      4220           +75.4%       7402 ± 16%  interrupts.CPU71.CAL:Function_call_interrupts
      2792 ± 34%     +63.1%       4555 ±  7%  interrupts.CPU71.NMI:Non-maskable_interrupts
      2792 ± 34%     +63.1%       4555 ±  7%  interrupts.CPU71.PMI:Performance_monitoring_interrupts
     12435 ±  9%     -32.2%       8430 ± 19%  interrupts.CPU71.RES:Rescheduling_interrupts
      4462 ±  8%     +75.3%       7821 ± 22%  interrupts.CPU72.CAL:Function_call_interrupts
      4955 ±  4%     -19.0%       4011 ± 20%  interrupts.CPU72.NMI:Non-maskable_interrupts
      4955 ±  4%     -19.0%       4011 ± 20%  interrupts.CPU72.PMI:Performance_monitoring_interrupts
     13460 ±  6%     -21.9%      10517 ±  3%  interrupts.CPU72.RES:Rescheduling_interrupts
      4037 ±  2%     +90.6%       7697 ± 19%  interrupts.CPU73.CAL:Function_call_interrupts
     13625 ±  6%     -22.9%      10505 ±  5%  interrupts.CPU73.RES:Rescheduling_interrupts
      3982 ±  6%    +102.3%       8054 ± 19%  interrupts.CPU74.CAL:Function_call_interrupts
      4071 ± 25%     +28.7%       5239 ±  4%  interrupts.CPU74.NMI:Non-maskable_interrupts
      4071 ± 25%     +28.7%       5239 ±  4%  interrupts.CPU74.PMI:Performance_monitoring_interrupts
     14272 ±  3%     -28.7%      10176 ±  9%  interrupts.CPU74.RES:Rescheduling_interrupts
      3811 ± 13%    +106.3%       7861 ± 20%  interrupts.CPU75.CAL:Function_call_interrupts
     14574 ±  2%     -29.6%      10260 ±  5%  interrupts.CPU75.RES:Rescheduling_interrupts
      3730 ±  9%    +100.1%       7463 ± 18%  interrupts.CPU76.CAL:Function_call_interrupts
     15610 ±  4%     -34.6%      10213 ±  8%  interrupts.CPU76.RES:Rescheduling_interrupts
      3588 ±  8%    +107.1%       7431 ± 17%  interrupts.CPU77.CAL:Function_call_interrupts
     15243 ±  3%     -30.8%      10548 ±  8%  interrupts.CPU77.RES:Rescheduling_interrupts
      3567 ±  8%    +107.2%       7391 ± 16%  interrupts.CPU78.CAL:Function_call_interrupts
     15536 ±  3%     -31.1%      10698 ±  7%  interrupts.CPU78.RES:Rescheduling_interrupts
     71.75 ± 53%     -59.9%      28.75 ± 55%  interrupts.CPU78.TLB:TLB_shootdowns
      3722 ±  9%    +104.9%       7629 ± 15%  interrupts.CPU79.CAL:Function_call_interrupts
     14641 ±  2%     -29.6%      10309 ±  7%  interrupts.CPU79.RES:Rescheduling_interrupts
      4305 ±  5%     +52.8%       6580 ± 10%  interrupts.CPU8.CAL:Function_call_interrupts
     10673 ±  2%     -15.8%       8985 ±  4%  interrupts.CPU8.RES:Rescheduling_interrupts
      3637 ±  7%    +103.1%       7389 ± 22%  interrupts.CPU80.CAL:Function_call_interrupts
     15435 ±  5%     -34.8%      10060 ±  4%  interrupts.CPU80.RES:Rescheduling_interrupts
      3710 ±  3%     +73.9%       6453 ± 10%  interrupts.CPU81.CAL:Function_call_interrupts
     15193 ±  2%     -28.0%      10941 ±  2%  interrupts.CPU81.RES:Rescheduling_interrupts
      3632 ± 10%     +99.6%       7248 ± 14%  interrupts.CPU82.CAL:Function_call_interrupts
      5312 ± 10%     -39.7%       3203 ± 38%  interrupts.CPU82.NMI:Non-maskable_interrupts
      5312 ± 10%     -39.7%       3203 ± 38%  interrupts.CPU82.PMI:Performance_monitoring_interrupts
     14933           -30.2%      10426 ±  7%  interrupts.CPU82.RES:Rescheduling_interrupts
      3543 ± 10%    +109.7%       7431 ± 18%  interrupts.CPU83.CAL:Function_call_interrupts
     15475 ±  4%     -33.9%      10226 ±  4%  interrupts.CPU83.RES:Rescheduling_interrupts
      3653 ±  6%     +99.0%       7271 ± 19%  interrupts.CPU84.CAL:Function_call_interrupts
     14866           -29.5%      10474 ±  4%  interrupts.CPU84.RES:Rescheduling_interrupts
      3698 ±  9%     +92.0%       7100 ± 20%  interrupts.CPU85.CAL:Function_call_interrupts
     15330 ±  2%     -29.8%      10759 ±  3%  interrupts.CPU85.RES:Rescheduling_interrupts
      3844 ±  8%     +96.8%       7567 ± 21%  interrupts.CPU86.CAL:Function_call_interrupts
     15061 ±  3%     -29.5%      10616 ± 12%  interrupts.CPU86.RES:Rescheduling_interrupts
      3969 ± 15%     +74.8%       6939 ± 13%  interrupts.CPU87.CAL:Function_call_interrupts
     15159 ±  7%     -28.6%      10822 ±  8%  interrupts.CPU87.RES:Rescheduling_interrupts
      3847 ± 10%     +93.7%       7451 ± 19%  interrupts.CPU88.CAL:Function_call_interrupts
     14690 ±  2%     -29.2%      10402 ±  9%  interrupts.CPU88.RES:Rescheduling_interrupts
      3983 ± 13%    +101.4%       8020 ± 20%  interrupts.CPU89.CAL:Function_call_interrupts
     14481 ±  6%     -29.5%      10203 ±  9%  interrupts.CPU89.RES:Rescheduling_interrupts
      4164 ±  9%     +73.2%       7210 ± 26%  interrupts.CPU9.CAL:Function_call_interrupts
     11502 ±  4%     -17.5%       9492 ±  6%  interrupts.CPU9.RES:Rescheduling_interrupts
      3428 ±  6%    +100.1%       6858 ± 18%  interrupts.CPU90.CAL:Function_call_interrupts
     13999 ±  8%     -30.4%       9746 ± 15%  interrupts.CPU90.RES:Rescheduling_interrupts
      3564 ±  4%     +97.2%       7027 ± 16%  interrupts.CPU91.CAL:Function_call_interrupts
     14546 ±  4%     -36.0%       9302 ± 20%  interrupts.CPU91.RES:Rescheduling_interrupts
      3941 ±  6%     +76.0%       6936 ± 19%  interrupts.CPU92.CAL:Function_call_interrupts
     14844 ±  6%     -34.2%       9773 ± 15%  interrupts.CPU92.RES:Rescheduling_interrupts
      3347 ±  7%    +102.9%       6792 ± 20%  interrupts.CPU93.CAL:Function_call_interrupts
     15141 ± 10%     -38.9%       9246 ± 20%  interrupts.CPU93.RES:Rescheduling_interrupts
      3774 ±  8%     +83.4%       6923 ± 18%  interrupts.CPU94.CAL:Function_call_interrupts
     15238 ± 11%     -33.0%      10207 ± 14%  interrupts.CPU94.RES:Rescheduling_interrupts
      3351 ± 10%    +120.4%       7385 ± 20%  interrupts.CPU95.CAL:Function_call_interrupts
     15894 ±  5%     -37.2%       9987 ± 15%  interrupts.CPU95.RES:Rescheduling_interrupts
      3455 ± 12%     +93.2%       6676 ± 16%  interrupts.CPU96.CAL:Function_call_interrupts
     15949 ±  9%     -33.4%      10614 ± 19%  interrupts.CPU96.RES:Rescheduling_interrupts
      3456 ±  6%    +110.1%       7262 ± 19%  interrupts.CPU97.CAL:Function_call_interrupts
      4276 ± 29%     +22.8%       5250 ±  6%  interrupts.CPU97.NMI:Non-maskable_interrupts
      4276 ± 29%     +22.8%       5250 ±  6%  interrupts.CPU97.PMI:Performance_monitoring_interrupts
     16089 ±  3%     -32.7%      10835 ± 16%  interrupts.CPU97.RES:Rescheduling_interrupts
      3709 ± 11%    +104.4%       7580 ± 20%  interrupts.CPU98.CAL:Function_call_interrupts
     17700 ± 20%     -42.5%      10177 ± 19%  interrupts.CPU98.RES:Rescheduling_interrupts
      3477 ± 16%    +114.3%       7451 ± 10%  interrupts.CPU99.CAL:Function_call_interrupts
     17887 ± 20%     -43.7%      10073 ± 10%  interrupts.CPU99.RES:Rescheduling_interrupts
   1922458 ±  3%     -32.5%    1297826 ±  6%  interrupts.RES:Rescheduling_interrupts
      3.06            -0.9        2.18 ±  8%  perf-profile.calltrace.cycles-pp.schedule_idle.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      2.99            -0.9        2.11 ±  8%  perf-profile.calltrace.cycles-pp.__schedule.schedule_idle.do_idle.cpu_startup_entry.start_secondary
      3.25            -0.7        2.55 ±  7%  perf-profile.calltrace.cycles-pp.__schedule.schedule.schedule_timeout.sctp_skb_recv_datagram.sctp_recvmsg
      6.43            -0.6        5.81 ±  2%  perf-profile.calltrace.cycles-pp.skb_release_all.consume_skb.sctp_chunk_put.sctp_outq_sack.sctp_cmd_interpreter
      6.43            -0.6        5.81 ±  2%  perf-profile.calltrace.cycles-pp.skb_release_head_state.skb_release_all.consume_skb.sctp_chunk_put.sctp_outq_sack
      3.62            -0.6        3.05 ±  5%  perf-profile.calltrace.cycles-pp.schedule.schedule_timeout.sctp_skb_recv_datagram.sctp_recvmsg.inet_recvmsg
      3.68            -0.6        3.13 ±  5%  perf-profile.calltrace.cycles-pp.schedule_timeout.sctp_skb_recv_datagram.sctp_recvmsg.inet_recvmsg.____sys_recvmsg
      6.10            -0.5        5.59 ±  2%  perf-profile.calltrace.cycles-pp.sctp_wfree.skb_release_head_state.skb_release_all.consume_skb.sctp_chunk_put
      4.42            -0.5        3.92 ±  3%  perf-profile.calltrace.cycles-pp.try_to_wake_up.autoremove_wake_function.__wake_up_common.__wake_up_common_lock.__sctp_write_space
      4.47            -0.5        3.98 ±  3%  perf-profile.calltrace.cycles-pp.autoremove_wake_function.__wake_up_common.__wake_up_common_lock.__sctp_write_space.sctp_wfree
      1.58            -0.5        1.10 ±  9%  perf-profile.calltrace.cycles-pp.pick_next_task_fair.__schedule.schedule_idle.do_idle.cpu_startup_entry
      5.21            -0.4        4.77 ±  2%  perf-profile.calltrace.cycles-pp.__sctp_write_space.sctp_wfree.skb_release_head_state.skb_release_all.consume_skb
      4.95            -0.4        4.52 ±  2%  perf-profile.calltrace.cycles-pp.__wake_up_common_lock.__sctp_write_space.sctp_wfree.skb_release_head_state.skb_release_all
      1.72            -0.4        1.32 ± 13%  perf-profile.calltrace.cycles-pp.ttwu_do_activate.try_to_wake_up.autoremove_wake_function.__wake_up_common.__wake_up_common_lock
      0.82 ±  2%      -0.4        0.43 ± 58%  perf-profile.calltrace.cycles-pp.poll_idle.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry
      4.56            -0.4        4.17 ±  2%  perf-profile.calltrace.cycles-pp.__wake_up_common.__wake_up_common_lock.__sctp_write_space.sctp_wfree.skb_release_head_state
      1.44 ±  2%      -0.4        1.06 ±  8%  perf-profile.calltrace.cycles-pp.dequeue_entity.dequeue_task_fair.__schedule.schedule.schedule_timeout
      1.15            -0.4        0.79 ±  9%  perf-profile.calltrace.cycles-pp.set_next_entity.pick_next_task_fair.__schedule.schedule_idle.do_idle
      1.72 ±  5%      -0.4        1.35 ±  9%  perf-profile.calltrace.cycles-pp.sctp_ulpq_tail_data.sctp_cmd_interpreter.sctp_do_sm.sctp_assoc_bh_rcv.sctp_rcv
      1.67            -0.4        1.30 ± 13%  perf-profile.calltrace.cycles-pp.enqueue_task_fair.ttwu_do_activate.try_to_wake_up.autoremove_wake_function.__wake_up_common
      1.62 ±  2%      -0.3        1.27 ±  8%  perf-profile.calltrace.cycles-pp.dequeue_task_fair.__schedule.schedule.schedule_timeout.sctp_skb_recv_datagram
      0.90            -0.3        0.57        perf-profile.calltrace.cycles-pp.select_task_rq_fair.try_to_wake_up.autoremove_wake_function.__wake_up_common.__wake_up_common_lock
      1.34            -0.3        1.03 ± 12%  perf-profile.calltrace.cycles-pp.enqueue_entity.enqueue_task_fair.ttwu_do_activate.try_to_wake_up.autoremove_wake_function
      1.19 ±  8%      -0.3        0.89 ± 13%  perf-profile.calltrace.cycles-pp.sctp_ulpevent_make_rcvmsg.sctp_ulpq_tail_data.sctp_cmd_interpreter.sctp_do_sm.sctp_assoc_bh_rcv
      7.35            -0.3        7.05        perf-profile.calltrace.cycles-pp.sctp_chunk_put.sctp_outq_sack.sctp_cmd_interpreter.sctp_do_sm.sctp_assoc_bh_rcv
      5.77            -0.3        5.48 ±  2%  perf-profile.calltrace.cycles-pp.sctp_skb_recv_datagram.sctp_recvmsg.inet_recvmsg.____sys_recvmsg.___sys_recvmsg
      7.06            -0.3        6.78        perf-profile.calltrace.cycles-pp.consume_skb.sctp_chunk_put.sctp_outq_sack.sctp_cmd_interpreter.sctp_do_sm
      0.64 ±  5%      -0.2        0.43 ± 57%  perf-profile.calltrace.cycles-pp.loopback_xmit.dev_hard_start_xmit.__dev_queue_xmit.ip_finish_output2.ip_output
      0.60            -0.2        0.40 ± 57%  perf-profile.calltrace.cycles-pp.sctp_queue_purge_ulpevents.sctp_ulpq_tail_event.do_ulpq_tail_event.sctp_cmd_interpreter.sctp_do_sm
      1.03            -0.2        0.82 ±  8%  perf-profile.calltrace.cycles-pp.__dev_queue_xmit.ip_finish_output2.ip_output.__ip_queue_xmit.sctp_packet_transmit
      1.53            -0.2        1.34 ±  3%  perf-profile.calltrace.cycles-pp.menu_select.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      0.88 ±  2%      -0.1        0.76 ±  5%  perf-profile.calltrace.cycles-pp.do_ulpq_tail_event.sctp_cmd_interpreter.sctp_do_sm.sctp_cmd_interpreter.sctp_do_sm
      0.72 ±  4%      -0.1        0.59 ±  7%  perf-profile.calltrace.cycles-pp.dev_hard_start_xmit.__dev_queue_xmit.ip_finish_output2.ip_output.__ip_queue_xmit
      0.81 ±  4%      -0.1        0.71 ±  4%  perf-profile.calltrace.cycles-pp.sctp_ulpevent_make_sender_dry_event.sctp_sf_do_no_pending_tsn.sctp_do_sm.sctp_cmd_interpreter.sctp_do_sm
      0.76 ±  2%      -0.1        0.66 ±  5%  perf-profile.calltrace.cycles-pp.sctp_ulpq_tail_event.do_ulpq_tail_event.sctp_cmd_interpreter.sctp_do_sm.sctp_cmd_interpreter
      0.83 ±  3%      -0.1        0.74 ±  3%  perf-profile.calltrace.cycles-pp.sctp_sf_do_no_pending_tsn.sctp_do_sm.sctp_cmd_interpreter.sctp_do_sm.sctp_assoc_bh_rcv
      0.64            -0.1        0.55 ±  3%  perf-profile.calltrace.cycles-pp.get_next_timer_interrupt.tick_nohz_next_event.tick_nohz_get_sleep_length.menu_select.do_idle
      0.75            -0.1        0.67 ±  4%  perf-profile.calltrace.cycles-pp.tick_nohz_next_event.tick_nohz_get_sleep_length.menu_select.do_idle.cpu_startup_entry
      0.96            -0.1        0.89 ±  4%  perf-profile.calltrace.cycles-pp.tick_nohz_get_sleep_length.menu_select.do_idle.cpu_startup_entry.start_secondary
      0.99            +0.0        1.04 ±  2%  perf-profile.calltrace.cycles-pp.sctp_packet_pack.sctp_packet_transmit.sctp_outq_flush.sctp_cmd_interpreter.sctp_do_sm
      0.64 ±  2%      +0.1        0.70 ±  3%  perf-profile.calltrace.cycles-pp.sctp_chunk_put.sctp_packet_pack.sctp_packet_transmit.sctp_outq_flush.sctp_cmd_interpreter
      0.80            +0.1        0.88 ±  2%  perf-profile.calltrace.cycles-pp.__skb_datagram_iter.skb_copy_datagram_iter.sctp_recvmsg.inet_recvmsg.____sys_recvmsg
      0.81            +0.1        0.89 ±  2%  perf-profile.calltrace.cycles-pp.skb_copy_datagram_iter.sctp_recvmsg.inet_recvmsg.____sys_recvmsg.___sys_recvmsg
      0.55 ±  2%      +0.1        0.64 ±  2%  perf-profile.calltrace.cycles-pp.sctp_user_addto_chunk.sctp_datamsg_from_user.sctp_sendmsg_to_asoc.sctp_sendmsg.sock_sendmsg
      0.73 ±  2%      +0.1        0.82 ±  4%  perf-profile.calltrace.cycles-pp.__alloc_skb._sctp_make_chunk.sctp_make_datafrag_empty.sctp_datamsg_from_user.sctp_sendmsg_to_asoc
      1.19            +0.1        1.28 ±  2%  perf-profile.calltrace.cycles-pp.sctp_transport_reset_t3_rtx.sctp_outq_flush.sctp_cmd_interpreter.sctp_do_sm.sctp_primitive_SEND
      0.67 ±  4%      +0.1        0.77        perf-profile.calltrace.cycles-pp.sock_kmalloc.____sys_sendmsg.___sys_sendmsg.__sys_sendmsg.do_syscall_64
      1.72 ±  2%      +0.1        1.83        perf-profile.calltrace.cycles-pp.sctp_chunk_put.sctp_ulpevent_free.sctp_recvmsg.inet_recvmsg.____sys_recvmsg
      0.99 ±  2%      +0.1        1.11 ±  3%  perf-profile.calltrace.cycles-pp._sctp_make_chunk.sctp_make_datafrag_empty.sctp_datamsg_from_user.sctp_sendmsg_to_asoc.sctp_sendmsg
      1.28            +0.1        1.40 ±  3%  perf-profile.calltrace.cycles-pp.sctp_make_datafrag_empty.sctp_datamsg_from_user.sctp_sendmsg_to_asoc.sctp_sendmsg.sock_sendmsg
      0.76 ±  2%      +0.1        0.89 ±  4%  perf-profile.calltrace.cycles-pp.__alloc_skb.sctp_packet_transmit.sctp_outq_flush.sctp_cmd_interpreter.sctp_do_sm
      0.55            +0.1        0.69 ±  2%  perf-profile.calltrace.cycles-pp.mod_timer.sctp_cmd_interpreter.sctp_do_sm.sctp_assoc_bh_rcv.sctp_rcv
      0.64            +0.1        0.78 ±  4%  perf-profile.calltrace.cycles-pp._sctp_make_chunk.sctp_make_sack.sctp_packet_append_chunk.sctp_packet_transmit_chunk.sctp_outq_flush
      1.74            +0.1        1.89        perf-profile.calltrace.cycles-pp.sctp_check_transmitted.sctp_outq_sack.sctp_cmd_interpreter.sctp_do_sm.sctp_assoc_bh_rcv
      0.78 ±  2%      +0.2        0.94 ±  4%  perf-profile.calltrace.cycles-pp.mod_timer.sctp_transport_reset_t3_rtx.sctp_outq_flush.sctp_cmd_interpreter.sctp_do_sm
      1.51 ±  2%      +0.2        1.67 ±  2%  perf-profile.calltrace.cycles-pp.sctp_outq_select_transport.sctp_outq_flush.sctp_cmd_interpreter.sctp_do_sm.sctp_primitive_SEND
      0.74            +0.2        0.90 ±  3%  perf-profile.calltrace.cycles-pp.kfree_skb.sctp_recvmsg.inet_recvmsg.____sys_recvmsg.___sys_recvmsg
     11.83            +0.2       12.00        perf-profile.calltrace.cycles-pp.____sys_recvmsg.___sys_recvmsg.__sys_recvmsg.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.57 ±  2%      +0.2        0.74 ±  5%  perf-profile.calltrace.cycles-pp.lock_timer_base.mod_timer.sctp_transport_reset_t3_rtx.sctp_outq_flush.sctp_cmd_interpreter
      0.52 ±  2%      +0.2        0.71 ±  6%  perf-profile.calltrace.cycles-pp.kmem_cache_free.sctp_ulpevent_free.sctp_recvmsg.inet_recvmsg.____sys_recvmsg
      0.66 ±  2%      +0.2        0.86 ±  3%  perf-profile.calltrace.cycles-pp.sctp_chunk_free.sctp_outq_sack.sctp_cmd_interpreter.sctp_do_sm.sctp_assoc_bh_rcv
      0.92 ±  5%      +0.2        1.13 ±  3%  perf-profile.calltrace.cycles-pp.lock_sock_nested.sctp_skb_recv_datagram.sctp_recvmsg.inet_recvmsg.____sys_recvmsg
     11.18            +0.2       11.38        perf-profile.calltrace.cycles-pp.sctp_outq_sack.sctp_cmd_interpreter.sctp_do_sm.sctp_assoc_bh_rcv.sctp_rcv
      0.82 ±  6%      +0.2        1.03 ±  3%  perf-profile.calltrace.cycles-pp._raw_spin_lock_bh.lock_sock_nested.sctp_skb_recv_datagram.sctp_recvmsg.inet_recvmsg
      0.38 ± 57%      +0.2        0.60 ±  3%  perf-profile.calltrace.cycles-pp.__check_object_size.____sys_sendmsg.___sys_sendmsg.__sys_sendmsg.do_syscall_64
      2.60            +0.2        2.82        perf-profile.calltrace.cycles-pp.sctp_datamsg_from_user.sctp_sendmsg_to_asoc.sctp_sendmsg.sock_sendmsg.____sys_sendmsg
     11.36            +0.2       11.60        perf-profile.calltrace.cycles-pp.inet_recvmsg.____sys_recvmsg.___sys_recvmsg.__sys_recvmsg.do_syscall_64
     11.23            +0.3       11.50        perf-profile.calltrace.cycles-pp.sctp_recvmsg.inet_recvmsg.____sys_recvmsg.___sys_recvmsg.__sys_recvmsg
      2.49            +0.3        2.77        perf-profile.calltrace.cycles-pp.sctp_ulpevent_free.sctp_recvmsg.inet_recvmsg.____sys_recvmsg.___sys_recvmsg
      2.81            +0.3        3.12 ±  3%  perf-profile.calltrace.cycles-pp.sctp_packet_transmit_chunk.sctp_outq_flush.sctp_cmd_interpreter.sctp_do_sm.sctp_primitive_SEND
      2.65            +0.3        2.98 ±  3%  perf-profile.calltrace.cycles-pp.sctp_packet_append_chunk.sctp_packet_transmit_chunk.sctp_outq_flush.sctp_cmd_interpreter.sctp_do_sm
      0.12 ±173%      +0.4        0.55        perf-profile.calltrace.cycles-pp.sctp_sf_eat_sack_6_2.sctp_do_sm.sctp_assoc_bh_rcv.sctp_rcv.ip_protocol_deliver_rcu
      1.42            +0.4        1.84 ±  5%  perf-profile.calltrace.cycles-pp.sctp_make_sack.sctp_packet_append_chunk.sctp_packet_transmit_chunk.sctp_outq_flush.sctp_cmd_interpreter
     42.61            +0.4       43.04        perf-profile.calltrace.cycles-pp.__sys_sendmsg.do_syscall_64.entry_SYSCALL_64_after_hwframe
     40.13            +0.4       40.56        perf-profile.calltrace.cycles-pp.sock_sendmsg.____sys_sendmsg.___sys_sendmsg.__sys_sendmsg.do_syscall_64
      0.12 ±173%      +0.4        0.57 ±  5%  perf-profile.calltrace.cycles-pp.prepare_to_wait_exclusive.sctp_skb_recv_datagram.sctp_recvmsg.inet_recvmsg.____sys_recvmsg
     42.40            +0.5       42.86        perf-profile.calltrace.cycles-pp.___sys_sendmsg.__sys_sendmsg.do_syscall_64.entry_SYSCALL_64_after_hwframe
     39.87            +0.5       40.35        perf-profile.calltrace.cycles-pp.sctp_sendmsg.sock_sendmsg.____sys_sendmsg.___sys_sendmsg.__sys_sendmsg
     55.52            +0.5       56.01        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +0.5        0.52 ±  2%  perf-profile.calltrace.cycles-pp.skb_release_head_state.skb_release_all.consume_skb.sctp_chunk_put.sctp_ulpevent_free
     18.25            +0.5       18.78        perf-profile.calltrace.cycles-pp.sctp_do_sm.sctp_primitive_SEND.sctp_sendmsg_to_asoc.sctp_sendmsg.sock_sendmsg
      0.00            +0.5        0.53 ±  2%  perf-profile.calltrace.cycles-pp.skb_release_all.consume_skb.sctp_chunk_put.sctp_ulpevent_free.sctp_recvmsg
     19.24            +0.5       19.77        perf-profile.calltrace.cycles-pp.sctp_cmd_interpreter.sctp_do_sm.sctp_primitive_SEND.sctp_sendmsg_to_asoc.sctp_sendmsg
     41.79            +0.5       42.34        perf-profile.calltrace.cycles-pp.____sys_sendmsg.___sys_sendmsg.__sys_sendmsg.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +0.6        0.58 ±  5%  perf-profile.calltrace.cycles-pp.__slab_free.kmem_cache_free.sctp_ulpevent_free.sctp_recvmsg.inet_recvmsg
      0.00            +0.6        0.59 ±  8%  perf-profile.calltrace.cycles-pp.__slab_free.consume_skb.sctp_chunk_put.sctp_outq_sack.sctp_cmd_interpreter
     39.28            +0.6       39.90        perf-profile.calltrace.cycles-pp.sctp_sendmsg_to_asoc.sctp_sendmsg.sock_sendmsg.____sys_sendmsg.___sys_sendmsg
      0.00            +0.8        0.76 ± 12%  perf-profile.calltrace.cycles-pp.ttwu_queue_wakelist.try_to_wake_up.autoremove_wake_function.__wake_up_common.__wake_up_common_lock
      0.00            +0.8        0.78 ± 14%  perf-profile.calltrace.cycles-pp.sched_ttwu_pending.flush_smp_call_function_from_idle.do_idle.cpu_startup_entry.start_secondary
      0.14 ±173%      +1.2        1.31 ± 13%  perf-profile.calltrace.cycles-pp.flush_smp_call_function_from_idle.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      6.29            -1.6        4.71 ±  7%  perf-profile.children.cycles-pp.__schedule
      3.09            -0.9        2.19 ±  8%  perf-profile.children.cycles-pp.schedule_idle
      3.62            -0.6        3.05 ±  5%  perf-profile.children.cycles-pp.schedule
      7.19            -0.6        6.61 ±  2%  perf-profile.children.cycles-pp.skb_release_all
      7.17            -0.6        6.60 ±  2%  perf-profile.children.cycles-pp.skb_release_head_state
      3.69            -0.6        3.13 ±  5%  perf-profile.children.cycles-pp.schedule_timeout
      6.10            -0.5        5.59 ±  2%  perf-profile.children.cycles-pp.sctp_wfree
      4.47            -0.5        3.98 ±  3%  perf-profile.children.cycles-pp.autoremove_wake_function
      4.43            -0.5        3.93 ±  3%  perf-profile.children.cycles-pp.try_to_wake_up
      1.71            -0.5        1.24 ±  9%  perf-profile.children.cycles-pp.pick_next_task_fair
      5.21            -0.4        4.77 ±  2%  perf-profile.children.cycles-pp.__sctp_write_space
      4.95            -0.4        4.53 ±  2%  perf-profile.children.cycles-pp.__wake_up_common_lock
      4.56            -0.4        4.17 ±  2%  perf-profile.children.cycles-pp.__wake_up_common
      1.45 ±  2%      -0.4        1.07 ±  8%  perf-profile.children.cycles-pp.dequeue_entity
      1.55            -0.4        1.17 ±  9%  perf-profile.children.cycles-pp.update_load_avg
      1.18            -0.4        0.80 ±  9%  perf-profile.children.cycles-pp.set_next_entity
      1.72 ±  5%      -0.4        1.35 ±  9%  perf-profile.children.cycles-pp.sctp_ulpq_tail_data
      1.62 ±  2%      -0.4        1.27 ±  8%  perf-profile.children.cycles-pp.dequeue_task_fair
      0.90            -0.3        0.57        perf-profile.children.cycles-pp.select_task_rq_fair
      1.90            -0.3        1.58 ±  9%  perf-profile.children.cycles-pp.ttwu_do_activate
      8.03            -0.3        7.71        perf-profile.children.cycles-pp.consume_skb
      1.20 ±  8%      -0.3        0.90 ± 13%  perf-profile.children.cycles-pp.sctp_ulpevent_make_rcvmsg
      1.85            -0.3        1.55 ±  9%  perf-profile.children.cycles-pp.enqueue_task_fair
      5.79            -0.3        5.51 ±  2%  perf-profile.children.cycles-pp.sctp_skb_recv_datagram
      0.83 ±  2%      -0.3        0.55 ± 11%  perf-profile.children.cycles-pp.poll_idle
      1.50            -0.3        1.25 ±  8%  perf-profile.children.cycles-pp.enqueue_entity
      0.84            -0.2        0.63 ± 10%  perf-profile.children.cycles-pp.update_rq_clock
      1.04            -0.2        0.83 ±  8%  perf-profile.children.cycles-pp.__dev_queue_xmit
      0.62 ±  3%      -0.2        0.43 ±  6%  perf-profile.children.cycles-pp.update_curr
      1.55            -0.2        1.36 ±  3%  perf-profile.children.cycles-pp.menu_select
      9.98            -0.2        9.80        perf-profile.children.cycles-pp.sctp_chunk_put
      1.12 ±  2%      -0.1        0.98 ±  3%  perf-profile.children.cycles-pp.sctp_ulpq_tail_event
      0.88 ±  2%      -0.1        0.76 ±  5%  perf-profile.children.cycles-pp.do_ulpq_tail_event
      1.01            -0.1        0.89 ±  4%  perf-profile.children.cycles-pp.copy_msghdr_from_user
      0.55            -0.1        0.43 ±  4%  perf-profile.children.cycles-pp.sctp_association_put
      0.72 ±  4%      -0.1        0.60 ±  8%  perf-profile.children.cycles-pp.dev_hard_start_xmit
      0.34 ± 16%      -0.1        0.22 ± 22%  perf-profile.children.cycles-pp.ipv4_dst_check
      0.29 ±  3%      -0.1        0.17 ±  7%  perf-profile.children.cycles-pp.resched_curr
      0.34 ±  3%      -0.1        0.24 ±  9%  perf-profile.children.cycles-pp.__update_load_avg_se
      0.35 ±  2%      -0.1        0.24 ± 10%  perf-profile.children.cycles-pp.pick_next_entity
      0.81 ±  4%      -0.1        0.72 ±  4%  perf-profile.children.cycles-pp.sctp_ulpevent_make_sender_dry_event
      0.23 ± 13%      -0.1        0.14 ± 22%  perf-profile.children.cycles-pp.__ip_finish_output
      0.84 ±  3%      -0.1        0.74 ±  4%  perf-profile.children.cycles-pp.sctp_sf_do_no_pending_tsn
      0.64 ±  5%      -0.1        0.55 ±  8%  perf-profile.children.cycles-pp.loopback_xmit
      0.36 ±  3%      -0.1        0.27 ±  4%  perf-profile.children.cycles-pp.check_preempt_curr
      0.61            -0.1        0.52 ±  6%  perf-profile.children.cycles-pp.sctp_queue_purge_ulpevents
      0.46 ±  3%      -0.1        0.37 ±  4%  perf-profile.children.cycles-pp.sctp_datamsg_put
      0.64            -0.1        0.55 ±  4%  perf-profile.children.cycles-pp.get_next_timer_interrupt
      0.53 ±  2%      -0.1        0.45 ±  2%  perf-profile.children.cycles-pp.sendmsg_copy_msghdr
      0.56            -0.1        0.48 ±  4%  perf-profile.children.cycles-pp.import_iovec
      0.38 ±  3%      -0.1        0.29 ±  3%  perf-profile.children.cycles-pp.ttwu_do_wakeup
      0.53            -0.1        0.45 ±  4%  perf-profile.children.cycles-pp.__import_iovec
      0.42 ±  3%      -0.1        0.35 ±  5%  perf-profile.children.cycles-pp.__switch_to_asm
      0.75            -0.1        0.68 ±  3%  perf-profile.children.cycles-pp.tick_nohz_next_event
      0.69            -0.1        0.62 ±  4%  perf-profile.children.cycles-pp._copy_from_user
      0.54 ±  3%      -0.1        0.47 ±  9%  perf-profile.children.cycles-pp.__update_load_avg_cfs_rq
      0.96            -0.1        0.89 ±  4%  perf-profile.children.cycles-pp.tick_nohz_get_sleep_length
      0.40 ±  2%      -0.1        0.33 ±  4%  perf-profile.children.cycles-pp.iovec_from_user
      0.29 ±  3%      -0.1        0.22 ±  7%  perf-profile.children.cycles-pp._copy_from_iter_full
      0.34 ±  5%      -0.1        0.27 ± 22%  perf-profile.children.cycles-pp.start_kernel
      0.34 ±  5%      -0.1        0.27 ± 11%  perf-profile.children.cycles-pp.__sctp_packet_append_chunk
      0.57            -0.1        0.51 ±  2%  perf-profile.children.cycles-pp._raw_spin_unlock_irqrestore
      0.20 ±  6%      -0.1        0.14 ± 10%  perf-profile.children.cycles-pp.switch_mm_irqs_off
      0.41 ±  3%      -0.1        0.35 ±  3%  perf-profile.children.cycles-pp.sched_clock
      0.43 ±  3%      -0.1        0.38 ±  3%  perf-profile.children.cycles-pp.sched_clock_cpu
      0.41 ±  3%      -0.1        0.35 ±  5%  perf-profile.children.cycles-pp.__next_timer_interrupt
      0.39 ±  3%      -0.1        0.33 ±  3%  perf-profile.children.cycles-pp.native_sched_clock
      0.17 ± 10%      -0.1        0.12 ± 13%  perf-profile.children.cycles-pp.ip_rcv_finish
      0.37            -0.1        0.32 ±  6%  perf-profile.children.cycles-pp.read_tsc
      1.04            -0.1        0.99 ±  2%  perf-profile.children.cycles-pp._raw_spin_lock
      0.40 ±  2%      -0.1        0.35 ±  4%  perf-profile.children.cycles-pp.__switch_to
      0.15 ±  7%      -0.1        0.10 ± 18%  perf-profile.children.cycles-pp.validate_xmit_skb
      0.28 ±  5%      -0.0        0.23 ±  4%  perf-profile.children.cycles-pp.___perf_sw_event
      0.16 ± 13%      -0.0        0.11 ± 14%  perf-profile.children.cycles-pp.ip_rcv_finish_core
      0.22 ±  8%      -0.0        0.17 ±  7%  perf-profile.children.cycles-pp.sock_recvmsg
      0.20 ±  8%      -0.0        0.15 ±  5%  perf-profile.children.cycles-pp.security_socket_recvmsg
      0.22 ±  9%      -0.0        0.17 ±  8%  perf-profile.children.cycles-pp.ipv4_mtu
      0.30 ±  5%      -0.0        0.25        perf-profile.children.cycles-pp.sctp_data_ready
      0.41 ±  4%      -0.0        0.36 ±  4%  perf-profile.children.cycles-pp.sctp_transport_hold
      0.24 ±  5%      -0.0        0.20 ±  5%  perf-profile.children.cycles-pp.__check_heap_object
      0.51 ±  2%      -0.0        0.46 ±  2%  perf-profile.children.cycles-pp.__list_del_entry_valid
      0.17 ±  4%      -0.0        0.13 ± 10%  perf-profile.children.cycles-pp.sctp_outq_tail
      0.23 ±  4%      -0.0        0.19 ±  7%  perf-profile.children.cycles-pp.aa_sk_perm
      0.18 ±  3%      -0.0        0.14 ±  5%  perf-profile.children.cycles-pp.sctp_inq_pop
      0.21 ± 12%      -0.0        0.17 ±  4%  perf-profile.children.cycles-pp.irqtime_account_irq
      0.25 ±  3%      -0.0        0.21 ±  7%  perf-profile.children.cycles-pp.reweight_entity
      0.12 ±  4%      -0.0        0.09 ±  4%  perf-profile.children.cycles-pp.cpuidle_governor_latency_req
      0.09 ± 12%      -0.0        0.05        perf-profile.children.cycles-pp.__cgroup_account_cputime
      0.11 ± 11%      -0.0        0.08 ± 14%  perf-profile.children.cycles-pp.update_min_vruntime
      0.20 ±  6%      -0.0        0.17 ±  4%  perf-profile.children.cycles-pp.release_sock
      0.38 ±  2%      -0.0        0.34 ±  3%  perf-profile.children.cycles-pp.memset_erms
      0.33 ±  3%      -0.0        0.30 ±  2%  perf-profile.children.cycles-pp.sctp_chunk_hold
      0.15 ±  5%      -0.0        0.12 ±  3%  perf-profile.children.cycles-pp.sock_wfree
      0.20 ±  6%      -0.0        0.17 ±  7%  perf-profile.children.cycles-pp.finish_task_switch
      0.19 ±  3%      -0.0        0.16 ±  4%  perf-profile.children.cycles-pp.sock_kfree_s
      0.19 ±  2%      -0.0        0.16 ±  5%  perf-profile.children.cycles-pp.memcpy_erms
      0.26            -0.0        0.23 ±  6%  perf-profile.children.cycles-pp.sockfd_lookup_light
      0.26            -0.0        0.23 ±  4%  perf-profile.children.cycles-pp.__might_fault
      0.18 ±  2%      -0.0        0.15 ±  4%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      0.11 ±  8%      -0.0        0.08 ± 10%  perf-profile.children.cycles-pp.sctp_validate_data
      0.10 ±  8%      -0.0        0.07        perf-profile.children.cycles-pp.put_prev_task_fair
      0.07 ±  7%      -0.0        0.04 ± 57%  perf-profile.children.cycles-pp.sctp_v4_xmit
      0.29            -0.0        0.26 ±  4%  perf-profile.children.cycles-pp.___might_sleep
      0.19 ±  2%      -0.0        0.16 ±  6%  perf-profile.children.cycles-pp._find_next_bit
      0.14 ±  3%      -0.0        0.11 ±  7%  perf-profile.children.cycles-pp._cond_resched
      0.11 ±  3%      -0.0        0.09 ±  4%  perf-profile.children.cycles-pp.sctp_control_set_owner_w
      0.09 ± 24%      -0.0        0.06        perf-profile.children.cycles-pp.sctp_chunk_assign_ssn
      0.21 ±  2%      -0.0        0.18 ±  4%  perf-profile.children.cycles-pp.copy_user_enhanced_fast_string
      0.16            -0.0        0.14 ±  6%  perf-profile.children.cycles-pp.security_socket_sendmsg
      0.14 ±  3%      -0.0        0.11 ±  7%  perf-profile.children.cycles-pp.__wrgsbase_inactive
      0.11 ±  4%      -0.0        0.08 ±  5%  perf-profile.children.cycles-pp.__calc_delta
      0.09 ±  4%      -0.0        0.07 ± 10%  perf-profile.children.cycles-pp.rb_next
      0.38            -0.0        0.35 ±  3%  perf-profile.children.cycles-pp.__copy_msghdr_from_user
      0.16 ±  2%      -0.0        0.14 ±  9%  perf-profile.children.cycles-pp.copy_fpregs_to_fpstate
      0.13 ±  3%      -0.0        0.11 ±  4%  perf-profile.children.cycles-pp.__entry_text_start
      0.24 ±  2%      -0.0        0.23 ±  2%  perf-profile.children.cycles-pp.syscall_return_via_sysret
      0.17 ±  2%      -0.0        0.15 ±  4%  perf-profile.children.cycles-pp.sctp_ulpevent_receive_data
      0.07 ±  5%      -0.0        0.06 ±  9%  perf-profile.children.cycles-pp.rcu_all_qs
      0.08 ± 10%      -0.0        0.06 ± 11%  perf-profile.children.cycles-pp.newidle_balance
      0.07            -0.0        0.05 ±  8%  perf-profile.children.cycles-pp.cpuacct_charge
      0.09 ±  4%      -0.0        0.08 ±  6%  perf-profile.children.cycles-pp.exit_to_user_mode_prepare
      0.09 ±  4%      -0.0        0.08 ±  5%  perf-profile.children.cycles-pp.sctp_ulpevent_init
      0.08            -0.0        0.07 ±  7%  perf-profile.children.cycles-pp.__rdgsbase_inactive
      0.07 ±  7%      -0.0        0.05        perf-profile.children.cycles-pp.kmalloc_slab
      0.10 ±  4%      -0.0        0.09        perf-profile.children.cycles-pp.sk_filter_trim_cap
      0.06            -0.0        0.05        perf-profile.children.cycles-pp.__put_user_nocheck_8
      0.06            -0.0        0.05        perf-profile.children.cycles-pp.syscall_enter_from_user_mode
      0.05            +0.0        0.06 ±  6%  perf-profile.children.cycles-pp.sctp_transport_raise_cwnd
      0.06 ±  6%      +0.0        0.09 ± 13%  perf-profile.children.cycles-pp.__hrtimer_next_event_base
      0.40            +0.0        0.42 ±  2%  perf-profile.children.cycles-pp.copyout
      0.30 ±  2%      +0.0        0.34 ±  4%  perf-profile.children.cycles-pp.internal_add_timer
      0.16 ±  2%      +0.0        0.20 ±  5%  perf-profile.children.cycles-pp.__slab_alloc
      0.32 ±  8%      +0.0        0.36 ±  4%  perf-profile.children.cycles-pp.__ip_local_out
      0.27 ±  4%      +0.0        0.31 ±  4%  perf-profile.children.cycles-pp.enqueue_timer
      0.15 ±  3%      +0.0        0.19 ±  6%  perf-profile.children.cycles-pp.___slab_alloc
      0.53 ±  5%      +0.0        0.58 ±  2%  perf-profile.children.cycles-pp.dst_release
      0.15 ± 10%      +0.0        0.20 ±  5%  perf-profile.children.cycles-pp.__cgroup_bpf_run_filter_skb
      1.00            +0.0        1.05 ±  2%  perf-profile.children.cycles-pp.sctp_packet_pack
      0.28 ±  9%      +0.0        0.33 ±  4%  perf-profile.children.cycles-pp.ip_send_check
      0.07 ± 17%      +0.0        0.12 ± 15%  perf-profile.children.cycles-pp.rcu_eqs_enter
      0.11 ±  7%      +0.1        0.16 ±  8%  perf-profile.children.cycles-pp.ip_finish_output
      0.13 ± 14%      +0.1        0.19 ± 14%  perf-profile.children.cycles-pp.sctp_transport_burst_limited
      0.28 ±  2%      +0.1        0.34 ±  3%  perf-profile.children.cycles-pp.sctp_chunk_abandoned
      0.48 ±  2%      +0.1        0.55        perf-profile.children.cycles-pp.sctp_sf_eat_sack_6_2
      0.65            +0.1        0.71        perf-profile.children.cycles-pp.sctp_user_addto_chunk
      0.28            +0.1        0.35 ±  5%  perf-profile.children.cycles-pp.simple_copy_to_iter
      0.81            +0.1        0.89 ±  2%  perf-profile.children.cycles-pp.skb_copy_datagram_iter
      0.80            +0.1        0.88 ±  2%  perf-profile.children.cycles-pp.__skb_datagram_iter
      0.09 ±  4%      +0.1        0.17 ± 14%  perf-profile.children.cycles-pp.sctp_bind_addr_match
      0.48 ±  4%      +0.1        0.57 ±  4%  perf-profile.children.cycles-pp.prepare_to_wait_exclusive
      0.42 ± 14%      +0.1        0.51 ±  7%  perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
      1.19            +0.1        1.28 ±  2%  perf-profile.children.cycles-pp.sctp_transport_reset_t3_rtx
      0.67 ±  3%      +0.1        0.77        perf-profile.children.cycles-pp.sock_kmalloc
      0.45            +0.1        0.56 ±  5%  perf-profile.children.cycles-pp.skb_set_owner_w
      1.29            +0.1        1.40 ±  3%  perf-profile.children.cycles-pp.sctp_make_datafrag_empty
      0.63 ±  3%      +0.1        0.74 ±  3%  perf-profile.children.cycles-pp.kfree
      0.28 ±  3%      +0.1        0.40 ±  2%  perf-profile.children.cycles-pp.sctp_transport_put
      0.56            +0.1        0.69 ±  3%  perf-profile.children.cycles-pp.sctp_addto_chunk
      0.20 ±  3%      +0.1        0.34 ±  9%  perf-profile.children.cycles-pp.skb_put
      0.89            +0.1        1.03 ±  2%  perf-profile.children.cycles-pp.kfree_skb
      1.75            +0.1        1.90        perf-profile.children.cycles-pp.sctp_check_transmitted
      1.52 ±  2%      +0.2        1.67 ±  2%  perf-profile.children.cycles-pp.sctp_outq_select_transport
      1.19 ±  3%      +0.2        1.35 ±  2%  perf-profile.children.cycles-pp.lock_sock_nested
      0.10 ±  5%      +0.2        0.26 ±  9%  perf-profile.children.cycles-pp.available_idle_cpu
      1.08 ±  5%      +0.2        1.25 ±  3%  perf-profile.children.cycles-pp._raw_spin_lock_bh
     11.83            +0.2       12.00        perf-profile.children.cycles-pp.____sys_recvmsg
      2.18            +0.2        2.35 ±  2%  perf-profile.children.cycles-pp.__alloc_skb
      1.82            +0.2        1.99 ±  2%  perf-profile.children.cycles-pp.lock_timer_base
      0.08 ± 11%      +0.2        0.26 ± 15%  perf-profile.children.cycles-pp.llist_add_batch
      0.61 ±  3%      +0.2        0.80 ±  5%  perf-profile.children.cycles-pp.sctp_chunkify
      0.08 ± 11%      +0.2        0.26 ± 17%  perf-profile.children.cycles-pp.__smp_call_single_queue
      0.11 ± 14%      +0.2        0.30 ± 11%  perf-profile.children.cycles-pp.send_call_function_single_ipi
      0.68 ±  2%      +0.2        0.88 ±  3%  perf-profile.children.cycles-pp.sctp_chunk_free
      0.08 ± 19%      +0.2        0.28 ± 14%  perf-profile.children.cycles-pp.llist_reverse_order
      0.86 ±  2%      +0.2        1.06 ±  4%  perf-profile.children.cycles-pp.__ksize
     11.18            +0.2       11.39        perf-profile.children.cycles-pp.sctp_outq_sack
      2.60            +0.2        2.82        perf-profile.children.cycles-pp.sctp_datamsg_from_user
     11.36            +0.2       11.60        perf-profile.children.cycles-pp.inet_recvmsg
     11.24            +0.3       11.50        perf-profile.children.cycles-pp.sctp_recvmsg
      2.59            +0.3        2.86        perf-profile.children.cycles-pp.sctp_ulpevent_free
      1.65 ±  2%      +0.3        1.92 ±  3%  perf-profile.children.cycles-pp._sctp_make_chunk
      1.10 ±  3%      +0.3        1.37 ±  3%  perf-profile.children.cycles-pp.__check_object_size
      0.11 ± 17%      +0.3        0.38 ± 15%  perf-profile.children.cycles-pp.flush_smp_call_function_queue
      1.35            +0.3        1.64 ±  3%  perf-profile.children.cycles-pp.mod_timer
      2.09            +0.3        2.38 ±  2%  perf-profile.children.cycles-pp.kmem_cache_free
      2.82            +0.3        3.12 ±  3%  perf-profile.children.cycles-pp.sctp_packet_transmit_chunk
      2.61 ±  2%      +0.3        2.92 ±  2%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      2.65            +0.3        2.99 ±  3%  perf-profile.children.cycles-pp.sctp_packet_append_chunk
      1.50            +0.4        1.91 ±  5%  perf-profile.children.cycles-pp.sctp_make_sack
     42.62            +0.4       43.05        perf-profile.children.cycles-pp.__sys_sendmsg
     40.13            +0.4       40.57        perf-profile.children.cycles-pp.sock_sendmsg
      0.34 ± 12%      +0.4        0.79 ± 14%  perf-profile.children.cycles-pp.sched_ttwu_pending
     42.41            +0.5       42.86        perf-profile.children.cycles-pp.___sys_sendmsg
     39.89            +0.5       40.36        perf-profile.children.cycles-pp.sctp_sendmsg
      0.28 ± 12%      +0.5        0.76 ± 12%  perf-profile.children.cycles-pp.ttwu_queue_wakelist
     55.57            +0.5       56.06        perf-profile.children.cycles-pp.do_syscall_64
     41.79            +0.5       42.34        perf-profile.children.cycles-pp.____sys_sendmsg
     39.30            +0.6       39.91        perf-profile.children.cycles-pp.sctp_sendmsg_to_asoc
      1.98 ±  2%      +0.8        2.73 ±  4%  perf-profile.children.cycles-pp.__slab_free
      0.47 ± 13%      +0.9        1.32 ± 13%  perf-profile.children.cycles-pp.flush_smp_call_function_from_idle
      1.37            -0.4        0.94 ±  8%  perf-profile.self.cycles-pp.__schedule
      0.76 ±  4%      -0.3        0.48 ± 11%  perf-profile.self.cycles-pp.poll_idle
      0.65 ±  2%      -0.2        0.46 ± 12%  perf-profile.self.cycles-pp.update_rq_clock
      0.53            -0.2        0.35 ± 11%  perf-profile.self.cycles-pp.set_next_entity
      0.59 ±  3%      -0.2        0.41 ±  6%  perf-profile.self.cycles-pp.do_idle
      0.69 ±  2%      -0.2        0.54 ±  9%  perf-profile.self.cycles-pp.update_load_avg
      0.53 ±  3%      -0.1        0.40 ±  9%  perf-profile.self.cycles-pp.__update_load_avg_cfs_rq
      0.42            -0.1        0.30 ±  6%  perf-profile.self.cycles-pp.select_task_rq_fair
      0.55            -0.1        0.43 ±  4%  perf-profile.self.cycles-pp.sctp_association_put
      0.29 ±  3%      -0.1        0.17 ±  9%  perf-profile.self.cycles-pp.resched_curr
      0.33 ± 14%      -0.1        0.22 ± 20%  perf-profile.self.cycles-pp.ipv4_dst_check
      0.34 ±  2%      -0.1        0.23 ± 10%  perf-profile.self.cycles-pp.pick_next_entity
      0.39 ±  3%      -0.1        0.28 ±  8%  perf-profile.self.cycles-pp.enqueue_entity
      0.33 ±  2%      -0.1        0.23 ±  9%  perf-profile.self.cycles-pp.__update_load_avg_se
      0.63            -0.1        0.53 ± 10%  perf-profile.self.cycles-pp.sctp_association_hold
      0.27 ±  5%      -0.1        0.18 ±  8%  perf-profile.self.cycles-pp.update_curr
      0.43 ±  2%      -0.1        0.34 ±  3%  perf-profile.self.cycles-pp.menu_select
      0.42 ±  3%      -0.1        0.35 ±  5%  perf-profile.self.cycles-pp.__switch_to_asm
      0.53            -0.1        0.46 ±  4%  perf-profile.self.cycles-pp._raw_spin_unlock_irqrestore
      0.31 ±  6%      -0.1        0.24 ±  6%  perf-profile.self.cycles-pp.__softirqentry_text_start
      0.83            -0.1        0.77 ±  2%  perf-profile.self.cycles-pp.sctp_wfree
      0.20 ±  5%      -0.1        0.14 ±  7%  perf-profile.self.cycles-pp.switch_mm_irqs_off
      0.37 ±  4%      -0.1        0.32 ±  4%  perf-profile.self.cycles-pp.native_sched_clock
      0.23 ±  8%      -0.0        0.18 ±  6%  perf-profile.self.cycles-pp.sctp_datamsg_put
      0.16 ± 12%      -0.0        0.11 ± 13%  perf-profile.self.cycles-pp.ip_rcv_finish_core
      0.36            -0.0        0.31 ±  5%  perf-profile.self.cycles-pp.read_tsc
      0.38 ±  2%      -0.0        0.33 ±  4%  perf-profile.self.cycles-pp.__switch_to
      0.25 ±  5%      -0.0        0.21 ±  5%  perf-profile.self.cycles-pp.___perf_sw_event
      0.18 ±  4%      -0.0        0.13 ± 11%  perf-profile.self.cycles-pp.dequeue_entity
      0.21 ±  7%      -0.0        0.17 ± 11%  perf-profile.self.cycles-pp.ipv4_mtu
      0.16 ±  4%      -0.0        0.11 ±  7%  perf-profile.self.cycles-pp.try_to_wake_up
      0.27 ±  7%      -0.0        0.22 ±  4%  perf-profile.self.cycles-pp.sctp_sendmsg
      1.02            -0.0        0.98 ±  2%  perf-profile.self.cycles-pp._raw_spin_lock
      0.40 ±  4%      -0.0        0.36 ±  5%  perf-profile.self.cycles-pp.sctp_transport_hold
      0.23 ±  3%      -0.0        0.19 ± 14%  perf-profile.self.cycles-pp.__sctp_packet_append_chunk
      0.15 ±  7%      -0.0        0.11 ± 10%  perf-profile.self.cycles-pp.sctp_outq_tail
      0.07 ±  7%      -0.0        0.03 ±100%  perf-profile.self.cycles-pp.sctp_v4_xmit
      0.24 ±  2%      -0.0        0.21 ±  5%  perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.24 ±  3%      -0.0        0.20 ±  5%  perf-profile.self.cycles-pp.sctp_do_sm
      0.23 ±  3%      -0.0        0.19 ±  4%  perf-profile.self.cycles-pp.__check_heap_object
      0.29 ±  5%      -0.0        0.25        perf-profile.self.cycles-pp.sctp_data_ready
      0.25 ±  3%      -0.0        0.21 ±  7%  perf-profile.self.cycles-pp.reweight_entity
      0.19 ±  2%      -0.0        0.15 ±  4%  perf-profile.self.cycles-pp.loopback_xmit
      0.18 ±  6%      -0.0        0.14 ±  3%  perf-profile.self.cycles-pp.____sys_sendmsg
      0.11 ±  9%      -0.0        0.07 ± 17%  perf-profile.self.cycles-pp.update_min_vruntime
      0.36 ±  3%      -0.0        0.33 ±  4%  perf-profile.self.cycles-pp.__alloc_skb
      0.49            -0.0        0.45 ±  2%  perf-profile.self.cycles-pp.__list_del_entry_valid
      0.37 ±  2%      -0.0        0.34 ±  3%  perf-profile.self.cycles-pp.memset_erms
      0.19 ±  3%      -0.0        0.16 ±  9%  perf-profile.self.cycles-pp.process_backlog
      0.13 ±  6%      -0.0        0.10 ±  9%  perf-profile.self.cycles-pp.__dev_queue_xmit
      0.18 ±  2%      -0.0        0.15 ±  2%  perf-profile.self.cycles-pp.memcpy_erms
      0.16 ±  4%      -0.0        0.13 ±  9%  perf-profile.self.cycles-pp.__ip_queue_xmit
      0.18 ±  4%      -0.0        0.15 ±  7%  perf-profile.self.cycles-pp.aa_sk_perm
      0.33 ±  3%      -0.0        0.30 ±  2%  perf-profile.self.cycles-pp.sctp_chunk_hold
      0.28 ±  5%      -0.0        0.25 ±  2%  perf-profile.self.cycles-pp.__might_sleep
      0.11 ± 11%      -0.0        0.08 ±  5%  perf-profile.self.cycles-pp.do_ulpq_tail_event
      0.18 ±  2%      -0.0        0.16 ±  6%  perf-profile.self.cycles-pp._find_next_bit
      0.11 ±  6%      -0.0        0.08 ±  5%  perf-profile.self.cycles-pp.ip_local_deliver
      0.28            -0.0        0.26 ±  4%  perf-profile.self.cycles-pp.___might_sleep
      0.20 ±  4%      -0.0        0.17 ±  4%  perf-profile.self.cycles-pp.__next_timer_interrupt
      0.14 ±  5%      -0.0        0.12 ±  3%  perf-profile.self.cycles-pp.sock_wfree
      0.25 ±  4%      -0.0        0.23 ±  2%  perf-profile.self.cycles-pp.kmem_cache_alloc
      0.20 ±  4%      -0.0        0.17 ±  4%  perf-profile.self.cycles-pp.copy_user_enhanced_fast_string
      0.08 ± 19%      -0.0        0.06        perf-profile.self.cycles-pp.prepare_to_wait_exclusive
      0.08 ± 10%      -0.0        0.05 ±  8%  perf-profile.self.cycles-pp.dev_hard_start_xmit
      0.06 ±  6%      -0.0        0.04 ± 57%  perf-profile.self.cycles-pp.__kmalloc_reserve
      0.14 ±  3%      -0.0        0.11 ±  7%  perf-profile.self.cycles-pp.__wrgsbase_inactive
      0.24 ±  2%      -0.0        0.22        perf-profile.self.cycles-pp.syscall_return_via_sysret
      0.16 ±  2%      -0.0        0.14 ±  8%  perf-profile.self.cycles-pp.copy_fpregs_to_fpstate
      0.11 ±  9%      -0.0        0.09 ±  4%  perf-profile.self.cycles-pp.inet_recvmsg
      0.09 ±  7%      -0.0        0.07 ±  6%  perf-profile.self.cycles-pp.__skb_clone
      0.17 ±  2%      -0.0        0.15 ±  7%  perf-profile.self.cycles-pp.sctp_eat_data
      0.08 ±  5%      -0.0        0.06 ±  7%  perf-profile.self.cycles-pp.copy_msghdr_from_user
      0.13 ±  5%      -0.0        0.11        perf-profile.self.cycles-pp.do_syscall_64
      0.13 ±  3%      -0.0        0.11 ±  4%  perf-profile.self.cycles-pp.__entry_text_start
      0.07 ± 22%      -0.0        0.05 ±  8%  perf-profile.self.cycles-pp.sctp_chunk_assign_ssn
      0.09 ±  4%      -0.0        0.07 ± 12%  perf-profile.self.cycles-pp.rb_next
      0.09 ±  4%      -0.0        0.07 ± 12%  perf-profile.self.cycles-pp.sctp_validate_data
      0.11 ±  4%      -0.0        0.09 ±  4%  perf-profile.self.cycles-pp.sctp_packet_pack
      0.10 ±  4%      -0.0        0.08 ±  5%  perf-profile.self.cycles-pp.__calc_delta
      0.10 ±  8%      -0.0        0.08 ±  8%  perf-profile.self.cycles-pp.sctp_inq_pop
      0.07 ± 10%      -0.0        0.05 ±  8%  perf-profile.self.cycles-pp.__genradix_ptr
      0.07            -0.0        0.05 ±  8%  perf-profile.self.cycles-pp.cpuacct_charge
      0.09 ±  4%      -0.0        0.08 ±  6%  perf-profile.self.cycles-pp.sctp_ulpevent_init
      0.15 ±  3%      -0.0        0.13 ±  5%  perf-profile.self.cycles-pp.__import_iovec
      0.13            -0.0        0.11 ±  4%  perf-profile.self.cycles-pp.rcu_idle_exit
      0.13 ±  3%      -0.0        0.11 ±  3%  perf-profile.self.cycles-pp.____sys_recvmsg
      0.09 ±  4%      -0.0        0.08 ±  5%  perf-profile.self.cycles-pp.sctp_ulpevent_receive_data
      0.08            -0.0        0.07 ±  7%  perf-profile.self.cycles-pp.__rdgsbase_inactive
      0.07 ±  5%      -0.0        0.06        perf-profile.self.cycles-pp.___sys_sendmsg
      0.09 ±  5%      -0.0        0.07 ±  5%  perf-profile.self.cycles-pp.__sys_recvmsg
      0.08 ±  5%      -0.0        0.07 ±  5%  perf-profile.self.cycles-pp.__list_add_valid
      0.06            -0.0        0.05        perf-profile.self.cycles-pp.schedule_idle
      0.06            -0.0        0.05        perf-profile.self.cycles-pp.__put_user_nocheck_8
      0.07 ±  6%      +0.0        0.09 ±  5%  perf-profile.self.cycles-pp.schedule_timeout
      0.07 ± 10%      +0.0        0.09 ± 11%  perf-profile.self.cycles-pp.check_preempt_curr
      0.04 ± 58%      +0.0        0.07 ± 12%  perf-profile.self.cycles-pp.__hrtimer_next_event_base
      0.17 ±  4%      +0.0        0.21 ±  5%  perf-profile.self.cycles-pp.sctp_addto_chunk
      0.56 ±  3%      +0.0        0.60 ±  2%  perf-profile.self.cycles-pp.sctp_datamsg_from_user
      0.27 ±  4%      +0.0        0.31 ±  4%  perf-profile.self.cycles-pp.enqueue_timer
      0.15 ±  3%      +0.0        0.19 ±  6%  perf-profile.self.cycles-pp.___slab_alloc
      0.14 ±  8%      +0.0        0.19 ±  7%  perf-profile.self.cycles-pp.__cgroup_bpf_run_filter_skb
      0.47            +0.0        0.52        perf-profile.self.cycles-pp.sctp_assoc_bh_rcv
      0.14 ±  6%      +0.0        0.19 ±  5%  perf-profile.self.cycles-pp.dequeue_task_fair
      0.53 ±  5%      +0.1        0.58 ±  2%  perf-profile.self.cycles-pp.dst_release
      0.28 ± 10%      +0.1        0.33 ±  4%  perf-profile.self.cycles-pp.ip_send_check
      0.28 ±  2%      +0.1        0.33 ±  3%  perf-profile.self.cycles-pp.sctp_chunk_abandoned
      0.13 ± 14%      +0.1        0.19 ± 14%  perf-profile.self.cycles-pp.sctp_transport_burst_limited
      0.52 ±  5%      +0.1        0.57 ±  2%  perf-profile.self.cycles-pp.sctp_outq_flush
      0.46 ±  2%      +0.1        0.52 ±  3%  perf-profile.self.cycles-pp.sctp_rcv
      0.47 ±  3%      +0.1        0.54        perf-profile.self.cycles-pp.sctp_sf_eat_sack_6_2
      0.51            +0.1        0.58        perf-profile.self.cycles-pp.sctp_recvmsg
      0.66 ±  3%      +0.1        0.73 ±  3%  perf-profile.self.cycles-pp._raw_spin_lock_bh
      0.00            +0.1        0.08 ± 17%  perf-profile.self.cycles-pp.rcu_eqs_enter
      0.26 ±  8%      +0.1        0.34 ±  3%  perf-profile.self.cycles-pp.mod_timer
      0.06 ± 13%      +0.1        0.15 ± 15%  perf-profile.self.cycles-pp.sctp_bind_addr_match
      0.09 ± 11%      +0.1        0.18 ± 11%  perf-profile.self.cycles-pp.sctp_hash_cmp
      0.42 ± 13%      +0.1        0.51 ±  6%  perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
      0.00            +0.1        0.11 ± 14%  perf-profile.self.cycles-pp.flush_smp_call_function_queue
      0.09 ±  5%      +0.1        0.19 ±  8%  perf-profile.self.cycles-pp.__wake_up_common
      0.08 ± 24%      +0.1        0.19 ± 14%  perf-profile.self.cycles-pp.ttwu_queue_wakelist
      0.51 ±  6%      +0.1        0.61 ±  7%  perf-profile.self.cycles-pp.sctp_outq_select_transport
      0.45            +0.1        0.56 ±  5%  perf-profile.self.cycles-pp.skb_set_owner_w
      0.54 ±  4%      +0.1        0.66 ±  2%  perf-profile.self.cycles-pp.sock_kmalloc
      0.36 ±  4%      +0.1        0.48 ±  3%  perf-profile.self.cycles-pp.schedule
      0.61 ±  3%      +0.1        0.73 ±  3%  perf-profile.self.cycles-pp.kfree
      0.90 ±  2%      +0.1        1.02 ±  3%  perf-profile.self.cycles-pp.kmem_cache_free
      0.27 ±  3%      +0.1        0.40 ±  2%  perf-profile.self.cycles-pp.sctp_transport_put
      0.15 ±  4%      +0.1        0.28 ±  9%  perf-profile.self.cycles-pp.skb_put
      0.49 ±  3%      +0.1        0.63 ±  5%  perf-profile.self.cycles-pp.sctp_make_sack
      0.52 ±  2%      +0.1        0.66 ±  2%  perf-profile.self.cycles-pp.sctp_cmd_interpreter
      0.75 ±  2%      +0.1        0.89 ±  4%  perf-profile.self.cycles-pp.sctp_sendmsg_to_asoc
      0.60 ±  3%      +0.1        0.74 ±  8%  perf-profile.self.cycles-pp.sctp_packet_config
      0.00            +0.1        0.15 ± 14%  perf-profile.self.cycles-pp.flush_smp_call_function_from_idle
      0.09 ±  4%      +0.2        0.26 ±  9%  perf-profile.self.cycles-pp.available_idle_cpu
      0.15 ±  5%      +0.2        0.33 ± 12%  perf-profile.self.cycles-pp.sctp_chunkify
      0.08 ± 11%      +0.2        0.26 ± 14%  perf-profile.self.cycles-pp.sched_ttwu_pending
      0.08 ± 11%      +0.2        0.26 ± 15%  perf-profile.self.cycles-pp.llist_add_batch
      0.11 ± 14%      +0.2        0.30 ± 11%  perf-profile.self.cycles-pp.send_call_function_single_ipi
      0.85 ±  3%      +0.2        1.05 ±  4%  perf-profile.self.cycles-pp.__ksize
      0.08 ± 15%      +0.2        0.28 ± 14%  perf-profile.self.cycles-pp.llist_reverse_order
      1.15            +0.2        1.35 ±  4%  perf-profile.self.cycles-pp.sctp_outq_sack
      0.54            +0.2        0.75 ±  6%  perf-profile.self.cycles-pp.lock_timer_base
      0.69 ±  4%      +0.3        0.99 ±  5%  perf-profile.self.cycles-pp.__check_object_size
      2.60 ±  2%      +0.3        2.91 ±  2%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      1.97 ±  2%      +0.7        2.71 ±  4%  perf-profile.self.cycles-pp.__slab_free


                                                                                
                               netperf.Throughput_tps                           
                                                                                
  58000 +-------------------------------------------------------------------+   
        |. .+.   .+.   .+.   .+.+.+. .+.   .+. .+.     .+. .+.+. .+.+.     .|   
  56000 |-+   +.+   +.+   +.+       +   +.+   +   +.+.+   +     +     +.+.+ |   
  54000 |-+                                                                 |   
        |                                                                   |   
  52000 |-+                                                                 |   
        |                                                                   |   
  50000 |-+                   O                                             |   
        |       O                           O       O                       |   
  48000 |-+                 O         O       O                             |   
  46000 |-O O     O O O           O     O       O                           |   
        |     O                 O                                           |   
  44000 |-+               O               O       O                         |   
        |               O           O                                       |   
  42000 +-------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                             netperf.Throughput_total_tps                       
                                                                                
   2.1e+06 +----------------------------------------------------------------+   
  2.05e+06 |-+.+          +.           .+       .+           +.            .|   
           |.+  + .+.++. +  +.+.+.+.+.+  + .++.+  + .+.+.+. +  +.++.+.+.+.+ |   
     2e+06 |-+   +      +                 +        +       +                |   
  1.95e+06 |-+                                                              |   
   1.9e+06 |-+                                                              |   
  1.85e+06 |-+                                                              |   
           |                                                                |   
   1.8e+06 |-+                  O                                           |   
  1.75e+06 |-+     O                         O       O                      |   
   1.7e+06 |-+ O              O         O      O                            |   
  1.65e+06 |-O       OO O           O     O      O                          |   
           |     O                O                                         |   
   1.6e+06 |-+              O               O      O                        |   
  1.55e+06 +----------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                                   netperf.workload                             
                                                                                
  6.2e+08 +-----------------------------------------------------------------+   
          |. .+. .+.+.+. + :  .+.+.+. .+. .+.+. .+. .+. .+. : +. .+.+.   .+ |   
    6e+08 |-+   +       +  +.+       +   +     +   +   +   +    +     +.+   |   
  5.8e+08 |-+                                                               |   
          |                                                                 |   
  5.6e+08 |-+                                                               |   
          |                                                                 |   
  5.4e+08 |-+                  O                                            |   
          |       O                          O       O                      |   
  5.2e+08 |-+                          O       O                            |   
    5e+08 |-O O       O      O     O     O       O                          |   
          |     O   O   O        O                                          |   
  4.8e+08 |-+              O                                                |   
          |               O          O     O       O                        |   
  4.6e+08 +-----------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                        netperf.time.voluntary_context_switches                 
                                                                                
  6.2e+08 +-----------------------------------------------------------------+   
          |. .+. .+.+.+. + :  .+.+.+. .+. .+.+. .+. .+. .+. : +. .+.+.   .+ |   
    6e+08 |-+   +       +  +.+       +   +     +   +   +   +    +     +.+   |   
  5.8e+08 |-+                                                               |   
          |                                                                 |   
  5.6e+08 |-+                                                               |   
          |                                                                 |   
  5.4e+08 |-+                  O                                            |   
          |       O                          O       O                      |   
  5.2e+08 |-+                          O       O                            |   
    5e+08 |-O O       O      O     O     O       O                          |   
          |     O   O   O        O                                          |   
  4.8e+08 |-+              O                                                |   
          |               O          O     O       O                        |   
  4.6e+08 +-----------------------------------------------------------------+   
                                                                                
                                                                                
[*] bisect-good sample
[O] bisect-bad  sample

***************************************************************************************************
lkp-cpl-4sp1: 144 threads Intel(R) Xeon(R) Gold 5318H CPU @ 2.50GHz with 128G memory
=========================================================================================
compiler/cpufreq_governor/disk/fs/kconfig/load/rootfs/tbox_group/test/testcase/ucode:
  gcc-9/performance/1BRD_48G/xfs/x86_64-rhel-8.3/600/debian-10.4-x86_64-20200603.cgz/lkp-cpl-4sp1/sync_disk_rw/aim7/0x700001c

commit: 
  43c31ac0e6 ("sched: Remove relyance on STRUCT_ALIGNMENT")
  d8fcb81f1a ("sched/fair: Check for idle core in wake_affine")

43c31ac0e665d942 d8fcb81f1acf651a0e50eacecca 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
     16730            +8.7%      18186        aim7.jobs-per-min
    215.24            -8.0%     198.01        aim7.time.elapsed_time
    215.24            -8.0%     198.01        aim7.time.elapsed_time.max
    415645           -18.4%     339371        aim7.time.involuntary_context_switches
     11320            +6.4%      12045        aim7.time.system_time
     26.31 ±  3%     -13.8%      22.69        aim7.time.user_time
  98673976            -1.7%   96955988        aim7.time.voluntary_context_switches
     92121 ±  6%     +17.4%     108129 ±  2%  numa-meminfo.node3.Shmem
     23274           -13.6%      20116        uptime.idle
     60.91            -9.6%      55.08        iostat.cpu.idle
     38.92           +14.9%      44.74        iostat.cpu.system
     57576 ± 57%     +67.6%      96487 ±  8%  numa-vmstat.node2.numa_other
     23045 ±  6%     +17.2%      27015 ±  2%  numa-vmstat.node3.nr_shmem
      1368 ±  5%     +10.7%       1514 ±  2%  slabinfo.Acpi-Parse.active_objs
      1368 ±  5%     +10.7%       1514 ±  2%  slabinfo.Acpi-Parse.num_objs
 4.763e+08           -16.9%   3.96e+08        cpuidle.C1.time
   9964959           -10.4%    8926876        cpuidle.C1.usage
 1.782e+10 ±  2%     -16.0%  1.497e+10        cpuidle.C1E.time
     60.57            -5.8       54.72        mpstat.cpu.all.idle%
      0.03 ± 17%      +0.0        0.04 ± 18%  mpstat.cpu.all.iowait%
     38.26            +5.8       44.06        mpstat.cpu.all.sys%
     60.25            -9.1%      54.75        vmstat.cpu.id
    666562            +8.6%     723685        vmstat.io.bo
    922669            +6.5%     982373        vmstat.system.cs
    343007            +2.6%     351840        vmstat.system.in
     22809 ±  9%     +16.2%      26494        proc-vmstat.nr_active_anon
      8214 ±  2%      +4.5%       8584        proc-vmstat.nr_mapped
     26184 ±  8%     +15.0%      30102        proc-vmstat.nr_shmem
     31837            -1.6%      31333        proc-vmstat.nr_slab_reclaimable
     22809 ±  9%     +16.2%      26494        proc-vmstat.nr_zone_active_anon
     24065 ±  9%     +20.3%      28943        proc-vmstat.pgactivate
    961935            -5.1%     912855        proc-vmstat.pgfault
     56393            -5.3%      53404 ±  2%  proc-vmstat.pgreuse
   2339777           +31.8%    3084337        sched_debug.cfs_rq:/.MIN_vruntime.max
    357433 ±  9%     +31.6%     470432 ± 10%  sched_debug.cfs_rq:/.MIN_vruntime.stddev
     33632           +15.5%      38830        sched_debug.cfs_rq:/.exec_clock.avg
     36014           +14.7%      41310        sched_debug.cfs_rq:/.exec_clock.max
     33020           +14.8%      37891        sched_debug.cfs_rq:/.exec_clock.min
   2339777           +31.8%    3084338        sched_debug.cfs_rq:/.max_vruntime.max
    357433 ±  9%     +31.6%     470432 ± 10%  sched_debug.cfs_rq:/.max_vruntime.stddev
   2334835           +31.9%    3079941        sched_debug.cfs_rq:/.min_vruntime.avg
   2375898           +31.3%    3119539        sched_debug.cfs_rq:/.min_vruntime.max
   2296497           +31.2%    3012231        sched_debug.cfs_rq:/.min_vruntime.min
      0.31 ±  4%     +16.8%       0.36 ±  9%  sched_debug.cfs_rq:/.nr_running.avg
     68.50 ± 23%     +78.5%     122.25 ± 18%  sched_debug.cfs_rq:/.runnable_avg.min
    -51091           +56.4%     -79921        sched_debug.cfs_rq:/.spread0.min
     57.50 ± 21%     +74.2%     100.19 ± 12%  sched_debug.cfs_rq:/.util_avg.min
    403780 ±  3%     -14.7%     344602 ±  3%  sched_debug.cpu.avg_idle.avg
   1162493 ± 20%     -22.1%     905578 ± 16%  sched_debug.cpu.avg_idle.max
    180815 ±  5%     -24.6%     136296 ±  5%  sched_debug.cpu.avg_idle.stddev
    957.46 ±  3%     +12.9%       1080 ±  7%  sched_debug.cpu.curr->pid.avg
    781.31 ±  5%      +9.8%     858.00 ±  3%  sched_debug.cpu.nr_uninterruptible.max
   -893.88           -53.6%    -414.69        sched_debug.cpu.nr_uninterruptible.min
    299.40 ±  2%     -28.3%     214.56 ±  2%  sched_debug.cpu.nr_uninterruptible.stddev
    263328 ±  3%     +13.0%     297501        sched_debug.cpu.ttwu_count.min
     20829 ±  4%     -10.8%      18586 ±  6%  sched_debug.cpu.ttwu_count.stddev
     12.14           -10.3%      10.89        perf-stat.i.MPKI
  3.69e+09            +6.8%  3.942e+09        perf-stat.i.branch-instructions
      1.32            -0.1        1.26        perf-stat.i.branch-miss-rate%
     37.57            +0.9       38.46        perf-stat.i.cache-miss-rate%
  2.06e+08            -4.8%  1.962e+08        perf-stat.i.cache-references
    930589            +6.5%     991172        perf-stat.i.context-switches
     11.24            +7.7%      12.10        perf-stat.i.cpi
  1.92e+11           +14.7%  2.202e+11        perf-stat.i.cpu-cycles
    126633            -3.4%     122298        perf-stat.i.cpu-migrations
      2417           +16.5%       2816        perf-stat.i.cycles-between-cache-misses
 4.301e+09            +5.0%  4.518e+09        perf-stat.i.dTLB-loads
 1.808e+09            +3.9%  1.878e+09        perf-stat.i.dTLB-stores
   7626982            +6.5%    8125070        perf-stat.i.iTLB-load-misses
  18957579            +4.6%   19826986 ±  2%  perf-stat.i.iTLB-loads
 1.668e+10            +6.0%  1.768e+10        perf-stat.i.instructions
      1.33           +14.7%       1.53        perf-stat.i.metric.GHz
      0.88            +6.7%       0.94        perf-stat.i.metric.K/sec
     69.97            +5.2%      73.65        perf-stat.i.metric.M/sec
      4291            +3.0%       4421        perf-stat.i.minor-faults
  32773873            -4.7%   31227307        perf-stat.i.node-load-misses
   2114926            -8.3%    1938821        perf-stat.i.node-loads
  13875755            +3.5%   14359323        perf-stat.i.node-store-misses
    966868            +5.6%    1020869        perf-stat.i.node-stores
      4292            +3.0%       4423        perf-stat.i.page-faults
     12.35           -10.2%      11.10        perf-stat.overall.MPKI
      1.22            -0.1        1.15        perf-stat.overall.branch-miss-rate%
     38.28            +1.0       39.26        perf-stat.overall.cache-miss-rate%
     11.51            +8.2%      12.46        perf-stat.overall.cpi
      2435           +17.4%       2859        perf-stat.overall.cycles-between-cache-misses
      0.09            -7.6%       0.08        perf-stat.overall.ipc
 3.673e+09            +6.8%  3.923e+09        perf-stat.ps.branch-instructions
 2.051e+08            -4.8%  1.953e+08        perf-stat.ps.cache-references
    926297            +6.5%     986433        perf-stat.ps.context-switches
 1.912e+11           +14.6%  2.192e+11        perf-stat.ps.cpu-cycles
    126043            -3.4%     121706        perf-stat.ps.cpu-migrations
 4.282e+09            +5.0%  4.497e+09        perf-stat.ps.dTLB-loads
   1.8e+09            +3.9%  1.869e+09        perf-stat.ps.dTLB-stores
   7591919            +6.5%    8086053        perf-stat.ps.iTLB-load-misses
  18869445            +4.6%   19731191 ±  2%  perf-stat.ps.iTLB-loads
  1.66e+10            +6.0%   1.76e+10        perf-stat.ps.instructions
      4270            +3.0%       4397        perf-stat.ps.minor-faults
  32623435            -4.7%   31077586        perf-stat.ps.node-load-misses
   2106381            -8.3%    1930815        perf-stat.ps.node-loads
  13811721            +3.5%   14290702        perf-stat.ps.node-store-misses
    962440            +5.6%    1016130        perf-stat.ps.node-stores
      4271            +3.0%       4399        perf-stat.ps.page-faults
 3.586e+12            -2.5%  3.495e+12        perf-stat.total.instructions
     14.00 ±  2%      -2.3       11.74        perf-profile.calltrace.cycles-pp.xlog_wait_on_iclog.__xfs_log_force_lsn.xfs_log_force_lsn.xfs_file_fsync.xfs_file_buffered_aio_write
     13.60 ±  2%      -2.2       11.38        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.remove_wait_queue.xlog_wait_on_iclog.__xfs_log_force_lsn
     13.62 ±  2%      -2.2       11.41        perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.remove_wait_queue.xlog_wait_on_iclog.__xfs_log_force_lsn.xfs_log_force_lsn
     13.66 ±  2%      -2.2       11.45        perf-profile.calltrace.cycles-pp.remove_wait_queue.xlog_wait_on_iclog.__xfs_log_force_lsn.xfs_log_force_lsn.xfs_file_fsync
     25.35 ±  2%      -2.2       23.16 ±  3%  perf-profile.calltrace.cycles-pp.__xfs_log_force_lsn.xfs_log_force_lsn.xfs_file_fsync.xfs_file_buffered_aio_write.new_sync_write
     29.45            -1.8       27.67        perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     29.44            -1.8       27.67        perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     29.45            -1.8       27.67        perf-profile.calltrace.cycles-pp.start_secondary.secondary_startup_64_no_verify
     29.66 ±  2%      -1.8       27.89        perf-profile.calltrace.cycles-pp.secondary_startup_64_no_verify
     27.45            -1.7       25.77        perf-profile.calltrace.cycles-pp.cpuidle_enter.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     27.41            -1.7       25.74        perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry.start_secondary
     26.61            -1.6       25.04        perf-profile.calltrace.cycles-pp.intel_idle.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry
      9.82            -1.4        8.43 ±  2%  perf-profile.calltrace.cycles-pp.remove_wait_queue.xlog_cil_force_lsn.xfs_log_force_lsn.xfs_file_fsync.xfs_file_buffered_aio_write
      9.79            -1.4        8.39 ±  2%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.remove_wait_queue.xlog_cil_force_lsn.xfs_log_force_lsn.xfs_file_fsync
      9.75            -1.4        8.36 ±  2%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.remove_wait_queue.xlog_cil_force_lsn.xfs_log_force_lsn
      3.07 ±  2%      -0.4        2.68 ±  2%  perf-profile.calltrace.cycles-pp.__flush_work.xlog_cil_force_lsn.xfs_log_force_lsn.xfs_file_fsync.xfs_file_buffered_aio_write
      2.17 ±  3%      -0.2        1.99 ±  3%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irq.__flush_work.xlog_cil_force_lsn.xfs_log_force_lsn.xfs_file_fsync
      2.09 ±  3%      -0.2        1.91 ±  3%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irq.__flush_work.xlog_cil_force_lsn.xfs_log_force_lsn
      1.03            -0.1        0.90        perf-profile.calltrace.cycles-pp.xlog_cil_push_work.process_one_work.worker_thread.kthread.ret_from_fork
      0.82            -0.1        0.71 ±  3%  perf-profile.calltrace.cycles-pp.xlog_ioend_work.process_one_work.worker_thread.kthread.ret_from_fork
      0.78 ±  2%      -0.1        0.68 ±  3%  perf-profile.calltrace.cycles-pp.xlog_state_do_callback.xlog_ioend_work.process_one_work.worker_thread.kthread
      0.67 ±  2%      -0.0        0.62 ±  2%  perf-profile.calltrace.cycles-pp.complete.process_one_work.worker_thread.kthread.ret_from_fork
      0.66 ±  2%      -0.0        0.61 ±  2%  perf-profile.calltrace.cycles-pp.swake_up_locked.complete.process_one_work.worker_thread.kthread
      0.62 ±  2%      -0.0        0.58        perf-profile.calltrace.cycles-pp.try_to_wake_up.swake_up_locked.complete.process_one_work.worker_thread
      0.43 ± 57%      +0.2        0.66 ±  5%  perf-profile.calltrace.cycles-pp.xlog_cil_insert_items.xfs_log_commit_cil.__xfs_trans_commit.xfs_iomap_write_unwritten.xfs_end_ioend
      0.26 ±100%      +0.3        0.60 ±  5%  perf-profile.calltrace.cycles-pp._raw_spin_lock.xlog_cil_insert_items.xfs_log_commit_cil.__xfs_trans_commit.xfs_iomap_write_unwritten
      1.74 ±  4%      +0.3        2.09 ±  4%  perf-profile.calltrace.cycles-pp.xlog_cil_insert_items.xfs_log_commit_cil.__xfs_trans_commit.xfs_vn_update_time.file_update_time
      1.51 ±  4%      +0.4        1.86 ±  5%  perf-profile.calltrace.cycles-pp._raw_spin_lock.xlog_cil_insert_items.xfs_log_commit_cil.__xfs_trans_commit.xfs_vn_update_time
      1.61 ± 17%      +0.8        2.42 ±  5%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.xlog_cil_insert_items.xfs_log_commit_cil.__xfs_trans_commit
     61.22            +2.0       63.20        perf-profile.calltrace.cycles-pp.xfs_file_fsync.xfs_file_buffered_aio_write.new_sync_write.vfs_write.ksys_write
     57.83            +2.1       59.92        perf-profile.calltrace.cycles-pp.xfs_log_force_lsn.xfs_file_fsync.xfs_file_buffered_aio_write.new_sync_write.vfs_write
     65.38            +2.2       67.53        perf-profile.calltrace.cycles-pp.write
     65.27            +2.2       67.44        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.write
     65.21            +2.2       67.38        perf-profile.calltrace.cycles-pp.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     65.21            +2.2       67.38        perf-profile.calltrace.cycles-pp.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     65.22            +2.2       67.40        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     65.14            +2.2       67.33        perf-profile.calltrace.cycles-pp.new_sync_write.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
     65.11            +2.2       67.30        perf-profile.calltrace.cycles-pp.xfs_file_buffered_aio_write.new_sync_write.vfs_write.ksys_write.do_syscall_64
     32.47            +4.3       36.76 ±  2%  perf-profile.calltrace.cycles-pp.xlog_cil_force_lsn.xfs_log_force_lsn.xfs_file_fsync.xfs_file_buffered_aio_write.new_sync_write
     19.11            +6.1       25.23 ±  5%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.xlog_cil_force_lsn.xfs_log_force_lsn.xfs_file_fsync
     19.22            +6.1       25.35 ±  5%  perf-profile.calltrace.cycles-pp._raw_spin_lock.xlog_cil_force_lsn.xfs_log_force_lsn.xfs_file_fsync.xfs_file_buffered_aio_write
     24.20            -3.7       20.51        perf-profile.children.cycles-pp.remove_wait_queue
     26.33 ±  2%      -3.6       22.70        perf-profile.children.cycles-pp._raw_spin_lock_irqsave
     14.42 ±  2%      -2.3       12.08        perf-profile.children.cycles-pp.xlog_wait_on_iclog
     26.43 ±  2%      -2.2       24.18 ±  3%  perf-profile.children.cycles-pp.__xfs_log_force_lsn
     29.66 ±  2%      -1.8       27.88        perf-profile.children.cycles-pp.do_idle
     29.45            -1.8       27.67        perf-profile.children.cycles-pp.start_secondary
     29.66 ±  2%      -1.8       27.89        perf-profile.children.cycles-pp.secondary_startup_64_no_verify
     29.66 ±  2%      -1.8       27.89        perf-profile.children.cycles-pp.cpu_startup_entry
     27.65 ±  2%      -1.7       25.96        perf-profile.children.cycles-pp.cpuidle_enter
     27.65 ±  2%      -1.7       25.96        perf-profile.children.cycles-pp.cpuidle_enter_state
     26.80 ±  2%      -1.6       25.24        perf-profile.children.cycles-pp.intel_idle
      3.07 ±  2%      -0.4        2.68 ±  2%  perf-profile.children.cycles-pp.__flush_work
      1.26            -0.3        0.92        perf-profile.children.cycles-pp.__schedule
      1.06            -0.3        0.74        perf-profile.children.cycles-pp.schedule
      0.41 ±  2%      -0.2        0.16 ±  4%  perf-profile.children.cycles-pp.pick_next_task_fair
      0.28 ±  3%      -0.2        0.04 ± 57%  perf-profile.children.cycles-pp.newidle_balance
      0.30 ±  2%      -0.2        0.07 ±  6%  perf-profile.children.cycles-pp.load_balance
      0.61            -0.2        0.41        perf-profile.children.cycles-pp.wait_for_completion
      0.52 ±  2%      -0.2        0.32        perf-profile.children.cycles-pp.schedule_timeout
      2.53 ±  2%      -0.2        2.34 ±  3%  perf-profile.children.cycles-pp._raw_spin_lock_irq
      0.23            -0.2        0.04 ± 57%  perf-profile.children.cycles-pp.find_busiest_group
      0.23            -0.2        0.04 ± 57%  perf-profile.children.cycles-pp.update_sd_lb_stats
      1.80            -0.2        1.63        perf-profile.children.cycles-pp.try_to_wake_up
      0.92            -0.2        0.77 ±  2%  perf-profile.children.cycles-pp.__wake_up_common_lock
      1.03            -0.1        0.90        perf-profile.children.cycles-pp.xlog_cil_push_work
      0.98            -0.1        0.85 ±  2%  perf-profile.children.cycles-pp.__wake_up_common
      0.54 ±  2%      -0.1        0.42 ±  2%  perf-profile.children.cycles-pp.xlog_write
      0.82            -0.1        0.71 ±  3%  perf-profile.children.cycles-pp.xlog_ioend_work
      0.78 ±  2%      -0.1        0.68 ±  3%  perf-profile.children.cycles-pp.xlog_state_do_callback
      0.53 ±  2%      -0.1        0.43 ±  3%  perf-profile.children.cycles-pp.xlog_state_clean_iclog
      1.00            -0.1        0.91        perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
      0.92            -0.1        0.84        perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      0.53 ±  2%      -0.1        0.46        perf-profile.children.cycles-pp.iomap_apply
      0.53 ±  2%      -0.1        0.46        perf-profile.children.cycles-pp.iomap_file_buffered_write
      0.34 ±  4%      -0.1        0.28        perf-profile.children.cycles-pp.select_task_rq_fair
      0.24 ±  4%      -0.1        0.19 ±  2%  perf-profile.children.cycles-pp.xlog_state_get_iclog_space
      0.83 ±  2%      -0.1        0.77        perf-profile.children.cycles-pp.stack_trace_save_tsk
      0.38 ±  2%      -0.1        0.33        perf-profile.children.cycles-pp.update_load_avg
      0.44            -0.1        0.39 ±  2%  perf-profile.children.cycles-pp.iomap_write_actor
      0.67 ±  2%      -0.0        0.63        perf-profile.children.cycles-pp.complete
      0.76            -0.0        0.72        perf-profile.children.cycles-pp.arch_stack_walk
      0.66 ±  2%      -0.0        0.61 ±  2%  perf-profile.children.cycles-pp.swake_up_locked
      0.54 ±  2%      -0.0        0.50        perf-profile.children.cycles-pp.unwind_next_frame
      0.22 ±  3%      -0.0        0.18 ±  2%  perf-profile.children.cycles-pp._raw_spin_unlock_irqrestore
      0.38            -0.0        0.34        perf-profile.children.cycles-pp.dequeue_task_fair
      0.13 ±  3%      -0.0        0.10 ±  4%  perf-profile.children.cycles-pp.update_rq_clock
      0.18 ±  2%      -0.0        0.15 ±  2%  perf-profile.children.cycles-pp.iomap_write_begin
      0.21            -0.0        0.18 ±  2%  perf-profile.children.cycles-pp.update_curr
      0.32            -0.0        0.29        perf-profile.children.cycles-pp.dequeue_entity
      0.26 ±  3%      -0.0        0.23        perf-profile.children.cycles-pp.select_idle_sibling
      0.40            -0.0        0.37        perf-profile.children.cycles-pp.brd_do_bvec
      0.27 ±  3%      -0.0        0.25        perf-profile.children.cycles-pp.schedule_idle
      0.18 ±  2%      -0.0        0.15        perf-profile.children.cycles-pp.irq_exit_rcu
      0.14 ±  3%      -0.0        0.11 ±  3%  perf-profile.children.cycles-pp.grab_cache_page_write_begin
      0.15 ±  4%      -0.0        0.12 ±  4%  perf-profile.children.cycles-pp.xlog_state_release_iclog
      0.11 ±  4%      -0.0        0.09        perf-profile.children.cycles-pp.llist_add_batch
      0.11 ±  7%      -0.0        0.09        perf-profile.children.cycles-pp.set_task_cpu
      0.09            -0.0        0.07 ±  7%  perf-profile.children.cycles-pp.__update_load_avg_cfs_rq
      0.13 ±  3%      -0.0        0.11 ±  4%  perf-profile.children.cycles-pp.pagecache_get_page
      0.11 ±  4%      -0.0        0.10 ±  5%  perf-profile.children.cycles-pp.__smp_call_single_queue
      0.09 ±  7%      -0.0        0.07        perf-profile.children.cycles-pp.migrate_task_rq_fair
      0.14 ±  3%      -0.0        0.12 ±  4%  perf-profile.children.cycles-pp.do_softirq_own_stack
      0.14 ±  3%      -0.0        0.12 ±  4%  perf-profile.children.cycles-pp.__softirqentry_text_start
      0.09 ±  5%      -0.0        0.07 ±  6%  perf-profile.children.cycles-pp.find_get_entry
      0.08            -0.0        0.07 ±  6%  perf-profile.children.cycles-pp.switch_mm_irqs_off
      0.07 ±  7%      -0.0        0.05 ±  8%  perf-profile.children.cycles-pp.irq_enter_rcu
      0.07            -0.0        0.06        perf-profile.children.cycles-pp.xfs_buffered_write_iomap_begin
      0.13 ±  3%      +0.0        0.14        perf-profile.children.cycles-pp.task_tick_fair
      0.06 ±  7%      +0.0        0.07        perf-profile.children.cycles-pp.send_call_function_single_ipi
      0.21            +0.0        0.23 ±  3%  perf-profile.children.cycles-pp.wake_page_function
      0.05 ±  8%      +0.0        0.08 ± 11%  perf-profile.children.cycles-pp.xfs_log_release_iclog
      0.22            +0.0        0.25 ±  3%  perf-profile.children.cycles-pp.wake_up_page_bit
      2.31 ±  4%      +0.5        2.78 ±  4%  perf-profile.children.cycles-pp.xlog_cil_insert_items
     61.22            +2.0       63.20        perf-profile.children.cycles-pp.xfs_file_fsync
     57.83            +2.1       59.92        perf-profile.children.cycles-pp.xfs_log_force_lsn
     65.48            +2.1       67.62        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     65.40            +2.2       67.55        perf-profile.children.cycles-pp.write
     65.35            +2.2       67.51        perf-profile.children.cycles-pp.do_syscall_64
     65.22            +2.2       67.39        perf-profile.children.cycles-pp.ksys_write
     65.21            +2.2       67.38        perf-profile.children.cycles-pp.vfs_write
     65.15            +2.2       67.33        perf-profile.children.cycles-pp.new_sync_write
     65.11            +2.2       67.30        perf-profile.children.cycles-pp.xfs_file_buffered_aio_write
     62.03            +2.5       64.53        perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
     32.47            +4.3       36.76 ±  2%  perf-profile.children.cycles-pp.xlog_cil_force_lsn
     34.39 ±  3%      +6.3       40.69        perf-profile.children.cycles-pp._raw_spin_lock
     26.80 ±  2%      -1.6       25.24        perf-profile.self.cycles-pp.intel_idle
      0.10 ±  4%      -0.0        0.06 ±  6%  perf-profile.self.cycles-pp.update_rq_clock
      0.12            -0.0        0.09 ±  4%  perf-profile.self.cycles-pp.update_curr
      0.09            -0.0        0.06 ±  6%  perf-profile.self.cycles-pp.__update_load_avg_cfs_rq
      0.08 ±  5%      -0.0        0.05        perf-profile.self.cycles-pp.enqueue_task_fair
      0.11 ±  4%      -0.0        0.09        perf-profile.self.cycles-pp.llist_add_batch
      0.33            -0.0        0.30        perf-profile.self.cycles-pp.brd_do_bvec
      0.20 ±  2%      -0.0        0.17 ±  2%  perf-profile.self.cycles-pp.update_load_avg
      0.29            -0.0        0.27 ±  3%  perf-profile.self.cycles-pp.unwind_next_frame
      0.57            -0.0        0.55        perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.07 ±  7%      -0.0        0.05        perf-profile.self.cycles-pp.cpuidle_enter_state
      0.09 ±  4%      -0.0        0.07 ±  5%  perf-profile.self.cycles-pp.enqueue_entity
      0.05            +0.0        0.06        perf-profile.self.cycles-pp.flush_smp_call_function_from_idle
      0.06 ±  9%      +0.0        0.07        perf-profile.self.cycles-pp.send_call_function_single_ipi
     61.64            +2.4       64.07        perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
     30373 ±  4%     -11.6%      26860 ±  2%  softirqs.CPU1.RCU
     30097 ±  4%     -13.9%      25914        softirqs.CPU10.RCU
     30960 ±  4%     -14.2%      26554 ±  2%  softirqs.CPU100.RCU
     30986 ±  4%     -14.4%      26523 ±  2%  softirqs.CPU101.RCU
     31006 ±  4%     -12.2%      27238 ±  3%  softirqs.CPU102.RCU
     30979 ±  4%     -13.8%      26690 ±  2%  softirqs.CPU103.RCU
     31013 ±  4%     -13.8%      26736 ±  2%  softirqs.CPU104.RCU
     30991 ±  4%     -14.4%      26513 ±  2%  softirqs.CPU105.RCU
     30785 ±  4%     -13.8%      26549 ±  2%  softirqs.CPU106.RCU
     30921 ±  4%     -14.1%      26560 ±  2%  softirqs.CPU107.RCU
     28048 ±  4%     -12.4%      24566 ±  3%  softirqs.CPU108.RCU
     28349 ±  4%     -14.3%      24298 ±  2%  softirqs.CPU109.RCU
     30421 ±  3%     -13.4%      26336 ±  2%  softirqs.CPU11.RCU
     28315 ±  4%     -13.7%      24431 ±  3%  softirqs.CPU110.RCU
     28040 ±  4%     -13.7%      24190 ±  2%  softirqs.CPU111.RCU
     31914 ±  8%     -16.5%      26663 ±  2%  softirqs.CPU112.RCU
     30567 ±  4%     -13.6%      26402 ±  2%  softirqs.CPU113.RCU
     30873 ±  4%     -14.0%      26553 ±  2%  softirqs.CPU114.RCU
     30710 ±  3%     -13.7%      26514 ±  2%  softirqs.CPU115.RCU
     30547 ±  3%     -12.5%      26740 ±  2%  softirqs.CPU116.RCU
     30423 ±  4%     -13.9%      26200        softirqs.CPU117.RCU
     30728 ±  4%     -13.2%      26658 ±  3%  softirqs.CPU118.RCU
     30631 ±  4%     -13.4%      26530 ±  2%  softirqs.CPU119.RCU
     30426 ±  4%     -13.8%      26226 ±  3%  softirqs.CPU12.RCU
     30719 ±  3%     -13.0%      26725 ±  2%  softirqs.CPU120.RCU
     30800 ±  3%     -13.4%      26678 ±  2%  softirqs.CPU121.RCU
     30454 ±  3%     -15.1%      25864 ±  4%  softirqs.CPU122.RCU
     30533 ±  4%     -13.5%      26396 ±  2%  softirqs.CPU123.RCU
     30899 ±  4%     -13.5%      26726 ±  2%  softirqs.CPU124.RCU
     30813 ±  4%     -12.9%      26829 ±  2%  softirqs.CPU125.RCU
     26704 ±  5%     -14.6%      22802        softirqs.CPU126.RCU
     26806 ±  4%     -13.4%      23208 ±  2%  softirqs.CPU127.RCU
     28623 ±  4%     -14.5%      24464 ±  2%  softirqs.CPU128.RCU
     28814 ±  4%     -13.3%      24992 ±  4%  softirqs.CPU129.RCU
     31165 ±  5%     -15.7%      26276 ±  2%  softirqs.CPU13.RCU
     29077 ±  5%     -15.0%      24702 ±  2%  softirqs.CPU130.RCU
     28770 ±  5%     -14.5%      24597 ±  2%  softirqs.CPU131.RCU
     28782 ±  5%     -14.5%      24599 ±  2%  softirqs.CPU132.RCU
     28700 ±  4%     -14.4%      24564 ±  2%  softirqs.CPU133.RCU
     28590 ±  6%     -13.7%      24679 ±  2%  softirqs.CPU134.RCU
     28736 ±  4%     -13.9%      24755 ±  3%  softirqs.CPU135.RCU
     28773 ±  4%     -14.7%      24540 ±  2%  softirqs.CPU136.RCU
     28910 ±  4%     -14.6%      24681 ±  2%  softirqs.CPU137.RCU
     29307 ±  2%     -16.0%      24629 ±  3%  softirqs.CPU138.RCU
     28863 ±  5%     -14.2%      24756 ±  2%  softirqs.CPU139.RCU
     30026 ±  3%     -14.0%      25827 ±  2%  softirqs.CPU14.RCU
     28809 ±  4%     -13.6%      24905 ±  2%  softirqs.CPU140.RCU
     28738 ±  5%     -14.6%      24555 ±  2%  softirqs.CPU141.RCU
     28741 ±  5%     -14.4%      24607 ±  2%  softirqs.CPU142.RCU
     29515 ±  5%     -10.5%      26410 ±  7%  softirqs.CPU143.RCU
     30460 ±  5%     -16.0%      25589 ±  2%  softirqs.CPU15.RCU
     27109 ±  4%     -13.5%      23463        softirqs.CPU16.RCU
     26837 ±  4%     -13.0%      23337        softirqs.CPU17.RCU
     31056 ±  3%     -14.6%      26529 ±  2%  softirqs.CPU18.RCU
     30728 ±  4%     -13.8%      26492 ±  2%  softirqs.CPU19.RCU
     30289 ±  4%     -12.0%      26642 ±  3%  softirqs.CPU2.RCU
     30807 ±  3%     -13.2%      26733        softirqs.CPU20.RCU
     30801 ±  4%     -14.2%      26438 ±  2%  softirqs.CPU21.RCU
     30831 ±  4%     -14.5%      26375 ±  2%  softirqs.CPU22.RCU
     31005 ±  4%     -14.6%      26489 ±  2%  softirqs.CPU23.RCU
     30788 ±  4%     -14.1%      26433 ±  2%  softirqs.CPU24.RCU
     30727 ±  4%     -14.0%      26437 ±  2%  softirqs.CPU25.RCU
     30765 ±  4%     -13.8%      26525 ±  2%  softirqs.CPU26.RCU
     30857 ±  4%     -14.1%      26494 ±  2%  softirqs.CPU27.RCU
     30803 ±  3%     -14.3%      26400 ±  2%  softirqs.CPU28.RCU
     30506 ±  4%     -13.9%      26262 ±  2%  softirqs.CPU29.RCU
     30397 ±  4%     -14.5%      25983 ±  2%  softirqs.CPU3.RCU
     30727 ±  4%     -13.8%      26486 ±  2%  softirqs.CPU30.RCU
     30660 ±  4%     -13.1%      26659 ±  2%  softirqs.CPU31.RCU
     28406 ±  3%     -13.9%      24445 ±  2%  softirqs.CPU32.RCU
     28449 ±  4%     -14.1%      24424        softirqs.CPU33.RCU
     28578 ±  4%     -13.8%      24630 ±  2%  softirqs.CPU34.RCU
     28383 ±  4%     -13.0%      24693 ±  3%  softirqs.CPU35.RCU
     30263 ±  4%     -11.8%      26707 ±  2%  softirqs.CPU36.RCU
     30515 ±  3%     -13.0%      26551 ±  2%  softirqs.CPU37.RCU
     30590 ±  3%     -12.6%      26731 ±  2%  softirqs.CPU38.RCU
     30385 ±  3%     -13.4%      26328 ±  2%  softirqs.CPU39.RCU
     30474 ±  4%     -14.2%      26141 ±  2%  softirqs.CPU4.RCU
     30535 ±  4%     -12.6%      26684 ±  4%  softirqs.CPU40.RCU
     30714 ±  3%     -13.5%      26555 ±  2%  softirqs.CPU41.RCU
     30542 ±  4%     -13.3%      26488 ±  2%  softirqs.CPU42.RCU
     30495 ±  3%     -12.7%      26607 ±  2%  softirqs.CPU43.RCU
     29856 ±  4%     -11.9%      26303 ±  2%  softirqs.CPU44.RCU
     30561 ±  3%     -13.4%      26465 ±  2%  softirqs.CPU45.RCU
     30508 ±  3%     -13.3%      26464 ±  2%  softirqs.CPU46.RCU
     30400 ±  4%     -12.7%      26533 ±  2%  softirqs.CPU47.RCU
     30738 ±  2%     -16.6%      25629 ±  2%  softirqs.CPU48.RCU
     29725 ±  4%     -13.9%      25592 ±  2%  softirqs.CPU49.RCU
     29870 ±  4%     -15.7%      25184 ±  4%  softirqs.CPU5.RCU
     29493 ±  4%     -13.6%      25485 ±  2%  softirqs.CPU50.RCU
     29502 ±  4%     -12.8%      25720 ±  2%  softirqs.CPU51.RCU
     29875 ±  4%     -14.0%      25687 ±  2%  softirqs.CPU52.RCU
     29715 ±  4%     -13.3%      25751        softirqs.CPU53.RCU
     29329 ±  4%     -14.1%      25195 ±  2%  softirqs.CPU54.RCU
     29360 ±  5%     -12.4%      25720 ±  5%  softirqs.CPU55.RCU
     29397 ±  5%     -14.4%      25160 ±  2%  softirqs.CPU56.RCU
     29728 ±  4%     -14.5%      25415 ±  3%  softirqs.CPU57.RCU
     29258 ±  5%     -13.4%      25341        softirqs.CPU58.RCU
     29316 ±  5%     -13.3%      25429 ±  2%  softirqs.CPU59.RCU
     30015 ±  4%     -14.3%      25715        softirqs.CPU6.RCU
     29352 ±  5%     -14.2%      25180 ±  2%  softirqs.CPU60.RCU
     29415 ±  5%     -12.9%      25612 ±  3%  softirqs.CPU61.RCU
     29626 ±  4%     -14.7%      25278        softirqs.CPU62.RCU
     29206 ±  5%     -13.8%      25186        softirqs.CPU63.RCU
     29163 ±  5%     -14.0%      25087        softirqs.CPU64.RCU
     29091 ±  4%     -14.3%      24944 ±  2%  softirqs.CPU65.RCU
     29205 ±  5%     -13.5%      25263        softirqs.CPU66.RCU
     29171 ±  4%     -14.0%      25098        softirqs.CPU67.RCU
     29239 ±  4%     -14.5%      25010        softirqs.CPU68.RCU
     29150 ±  5%     -13.9%      25088 ±  2%  softirqs.CPU69.RCU
     30408 ±  4%     -14.5%      26003 ±  2%  softirqs.CPU7.RCU
     29079 ±  4%     -13.8%      25064 ±  2%  softirqs.CPU70.RCU
     29366 ±  5%     -14.7%      25061 ±  2%  softirqs.CPU71.RCU
     30731 ±  4%     -14.9%      26159 ±  2%  softirqs.CPU72.RCU
     31036 ±  5%     -15.3%      26289        softirqs.CPU73.RCU
     31024 ±  4%     -13.9%      26722        softirqs.CPU74.RCU
     30920 ±  4%     -14.3%      26489        softirqs.CPU75.RCU
     30975 ±  3%     -14.7%      26407        softirqs.CPU76.RCU
     30582 ±  4%     -13.2%      26558        softirqs.CPU77.RCU
     30964 ±  5%     -15.4%      26207 ±  2%  softirqs.CPU78.RCU
     30774 ±  4%     -14.7%      26265        softirqs.CPU79.RCU
     30681 ±  4%     -14.9%      26117 ±  2%  softirqs.CPU8.RCU
     30576 ±  4%     -14.3%      26214 ±  2%  softirqs.CPU80.RCU
     30586 ±  4%     -14.0%      26304        softirqs.CPU81.RCU
     30591 ±  4%     -14.3%      26230        softirqs.CPU82.RCU
     30605 ±  4%     -14.2%      26247        softirqs.CPU83.RCU
     30744 ±  4%     -14.8%      26185 ±  2%  softirqs.CPU84.RCU
     30718 ±  4%     -14.2%      26347 ±  2%  softirqs.CPU85.RCU
     31268 ±  6%     -16.3%      26173 ±  2%  softirqs.CPU86.RCU
     30702 ±  4%     -14.6%      26228 ±  2%  softirqs.CPU87.RCU
     30630 ±  5%     -14.2%      26290        softirqs.CPU88.RCU
     30633 ±  4%     -14.5%      26182 ±  2%  softirqs.CPU89.RCU
     30209 ±  3%     -14.9%      25707 ±  2%  softirqs.CPU9.RCU
     29333 ±  5%     -14.0%      25225 ±  2%  softirqs.CPU90.RCU
     29240 ±  4%     -13.8%      25195 ±  2%  softirqs.CPU91.RCU
     29163 ±  4%     -13.6%      25189 ±  2%  softirqs.CPU92.RCU
     29518 ±  4%     -14.9%      25109 ±  2%  softirqs.CPU93.RCU
     29381 ±  4%     -14.4%      25156 ±  2%  softirqs.CPU94.RCU
     29697 ±  5%     -14.9%      25259 ±  2%  softirqs.CPU95.RCU
     30903 ±  4%     -14.2%      26504 ±  2%  softirqs.CPU96.RCU
     30916 ±  4%     -13.9%      26631 ±  2%  softirqs.CPU97.RCU
     30989 ±  4%     -14.1%      26624 ±  2%  softirqs.CPU98.RCU
     31078 ±  4%     -14.1%      26694 ±  2%  softirqs.CPU99.RCU
   4319554 ±  4%     -13.9%    3718338 ±  2%  softirqs.RCU
     36929            -9.7%      33338        softirqs.TIMER
  10794795            +4.3%   11263837        interrupts.CAL:Function_call_interrupts
      4424 ± 24%     +28.8%       5699        interrupts.CPU0.NMI:Non-maskable_interrupts
      4424 ± 24%     +28.8%       5699        interrupts.CPU0.PMI:Performance_monitoring_interrupts
      3370 ±  2%     -18.1%       2759 ±  3%  interrupts.CPU0.RES:Rescheduling_interrupts
      5088           +13.0%       5750        interrupts.CPU1.NMI:Non-maskable_interrupts
      5088           +13.0%       5750        interrupts.CPU1.PMI:Performance_monitoring_interrupts
      3313 ±  3%     -17.2%       2742        interrupts.CPU1.RES:Rescheduling_interrupts
      4406 ± 23%     +30.2%       5738        interrupts.CPU10.NMI:Non-maskable_interrupts
      4406 ± 23%     +30.2%       5738        interrupts.CPU10.PMI:Performance_monitoring_interrupts
      3232 ±  3%     -17.8%       2656 ±  2%  interrupts.CPU10.RES:Rescheduling_interrupts
      3221 ±  4%     -20.2%       2570        interrupts.CPU100.RES:Rescheduling_interrupts
      4412 ± 24%     +29.4%       5708        interrupts.CPU101.NMI:Non-maskable_interrupts
      4412 ± 24%     +29.4%       5708        interrupts.CPU101.PMI:Performance_monitoring_interrupts
      3206           -21.1%       2530 ±  2%  interrupts.CPU101.RES:Rescheduling_interrupts
      4411 ± 24%     +29.3%       5703        interrupts.CPU102.NMI:Non-maskable_interrupts
      4411 ± 24%     +29.3%       5703        interrupts.CPU102.PMI:Performance_monitoring_interrupts
      3116           -17.7%       2565 ±  2%  interrupts.CPU102.RES:Rescheduling_interrupts
      3817 ± 33%     +49.6%       5712        interrupts.CPU103.NMI:Non-maskable_interrupts
      3817 ± 33%     +49.6%       5712        interrupts.CPU103.PMI:Performance_monitoring_interrupts
      3096 ±  2%     -18.8%       2513 ±  2%  interrupts.CPU103.RES:Rescheduling_interrupts
      3799 ± 33%     +49.9%       5695        interrupts.CPU104.NMI:Non-maskable_interrupts
      3799 ± 33%     +49.9%       5695        interrupts.CPU104.PMI:Performance_monitoring_interrupts
      3151 ±  3%     -19.0%       2551 ±  3%  interrupts.CPU104.RES:Rescheduling_interrupts
      3223           -20.0%       2580 ±  3%  interrupts.CPU105.RES:Rescheduling_interrupts
      3187           -19.8%       2558        interrupts.CPU106.RES:Rescheduling_interrupts
      3175 ±  3%     -20.3%       2531 ±  3%  interrupts.CPU107.RES:Rescheduling_interrupts
      3212 ±  2%     -17.9%       2636        interrupts.CPU108.RES:Rescheduling_interrupts
      3228 ±  3%     -19.8%       2590        interrupts.CPU109.RES:Rescheduling_interrupts
      5070           +13.3%       5743        interrupts.CPU11.NMI:Non-maskable_interrupts
      5070           +13.3%       5743        interrupts.CPU11.PMI:Performance_monitoring_interrupts
      3231 ±  3%     -17.8%       2655 ±  2%  interrupts.CPU11.RES:Rescheduling_interrupts
      3191 ±  4%     -18.9%       2588 ±  2%  interrupts.CPU110.RES:Rescheduling_interrupts
      3179 ±  4%     -20.1%       2538 ±  2%  interrupts.CPU111.RES:Rescheduling_interrupts
      3073 ±  3%     -16.2%       2575 ±  2%  interrupts.CPU112.RES:Rescheduling_interrupts
      3222 ±  4%     -19.1%       2607        interrupts.CPU113.RES:Rescheduling_interrupts
      3218 ±  4%     -18.6%       2621        interrupts.CPU114.RES:Rescheduling_interrupts
      3193 ±  3%     -18.9%       2588 ±  2%  interrupts.CPU115.RES:Rescheduling_interrupts
      3219 ±  4%     -20.6%       2556 ±  2%  interrupts.CPU116.RES:Rescheduling_interrupts
      4399 ± 24%     +29.8%       5709        interrupts.CPU117.NMI:Non-maskable_interrupts
      4399 ± 24%     +29.8%       5709        interrupts.CPU117.PMI:Performance_monitoring_interrupts
      3170 ±  4%     -16.8%       2637        interrupts.CPU117.RES:Rescheduling_interrupts
      4382 ± 24%     +30.4%       5714        interrupts.CPU118.NMI:Non-maskable_interrupts
      4382 ± 24%     +30.4%       5714        interrupts.CPU118.PMI:Performance_monitoring_interrupts
      3233 ±  2%     -18.9%       2623        interrupts.CPU118.RES:Rescheduling_interrupts
      4400 ± 24%     +29.5%       5698        interrupts.CPU119.NMI:Non-maskable_interrupts
      4400 ± 24%     +29.5%       5698        interrupts.CPU119.PMI:Performance_monitoring_interrupts
      3216 ±  4%     -19.4%       2592        interrupts.CPU119.RES:Rescheduling_interrupts
      3113           -14.8%       2651        interrupts.CPU12.RES:Rescheduling_interrupts
      4425 ± 24%     +28.7%       5696        interrupts.CPU120.NMI:Non-maskable_interrupts
      4425 ± 24%     +28.7%       5696        interrupts.CPU120.PMI:Performance_monitoring_interrupts
      3103 ±  4%     -18.1%       2540        interrupts.CPU120.RES:Rescheduling_interrupts
      4416 ± 24%     +29.6%       5725        interrupts.CPU121.NMI:Non-maskable_interrupts
      4416 ± 24%     +29.6%       5725        interrupts.CPU121.PMI:Performance_monitoring_interrupts
      3136 ±  2%     -17.0%       2601        interrupts.CPU121.RES:Rescheduling_interrupts
      3169 ±  3%     -17.4%       2618        interrupts.CPU122.RES:Rescheduling_interrupts
      5056           +12.5%       5688        interrupts.CPU123.NMI:Non-maskable_interrupts
      5056           +12.5%       5688        interrupts.CPU123.PMI:Performance_monitoring_interrupts
      3197 ±  4%     -19.7%       2568        interrupts.CPU123.RES:Rescheduling_interrupts
      5057           +13.0%       5714        interrupts.CPU124.NMI:Non-maskable_interrupts
      5057           +13.0%       5714        interrupts.CPU124.PMI:Performance_monitoring_interrupts
      3167 ±  2%     -20.2%       2527        interrupts.CPU124.RES:Rescheduling_interrupts
      5082           +12.5%       5716        interrupts.CPU125.NMI:Non-maskable_interrupts
      5082           +12.5%       5716        interrupts.CPU125.PMI:Performance_monitoring_interrupts
      3153 ±  3%     -17.5%       2602        interrupts.CPU125.RES:Rescheduling_interrupts
      4393 ± 24%     +30.4%       5729        interrupts.CPU126.NMI:Non-maskable_interrupts
      4393 ± 24%     +30.4%       5729        interrupts.CPU126.PMI:Performance_monitoring_interrupts
      3442 ±  2%     -23.4%       2637 ±  2%  interrupts.CPU126.RES:Rescheduling_interrupts
      5040           +13.4%       5714        interrupts.CPU127.NMI:Non-maskable_interrupts
      5040           +13.4%       5714        interrupts.CPU127.PMI:Performance_monitoring_interrupts
      3213 ±  3%     -18.2%       2627 ±  2%  interrupts.CPU127.RES:Rescheduling_interrupts
      5046           +13.0%       5703        interrupts.CPU128.NMI:Non-maskable_interrupts
      5046           +13.0%       5703        interrupts.CPU128.PMI:Performance_monitoring_interrupts
      3309 ±  2%     -20.3%       2636 ±  2%  interrupts.CPU128.RES:Rescheduling_interrupts
      5056           +13.2%       5726        interrupts.CPU129.NMI:Non-maskable_interrupts
      5056           +13.2%       5726        interrupts.CPU129.PMI:Performance_monitoring_interrupts
      3162 ±  3%     -18.9%       2563        interrupts.CPU129.RES:Rescheduling_interrupts
      3116 ±  3%     -17.5%       2571        interrupts.CPU13.RES:Rescheduling_interrupts
      3205 ±  6%     -18.9%       2598 ±  2%  interrupts.CPU130.RES:Rescheduling_interrupts
      5031           +13.4%       5706        interrupts.CPU131.NMI:Non-maskable_interrupts
      5031           +13.4%       5706        interrupts.CPU131.PMI:Performance_monitoring_interrupts
      3240 ±  4%     -20.4%       2580        interrupts.CPU131.RES:Rescheduling_interrupts
      5060           +12.5%       5693        interrupts.CPU132.NMI:Non-maskable_interrupts
      5060           +12.5%       5693        interrupts.CPU132.PMI:Performance_monitoring_interrupts
      3321 ±  3%     -20.8%       2631 ±  2%  interrupts.CPU132.RES:Rescheduling_interrupts
      5034           +13.6%       5720        interrupts.CPU133.NMI:Non-maskable_interrupts
      5034           +13.6%       5720        interrupts.CPU133.PMI:Performance_monitoring_interrupts
      3182           -16.7%       2649 ±  5%  interrupts.CPU133.RES:Rescheduling_interrupts
      3098 ±  3%     -17.4%       2560 ±  2%  interrupts.CPU134.RES:Rescheduling_interrupts
      3316           -21.4%       2605        interrupts.CPU135.RES:Rescheduling_interrupts
      3270           -20.5%       2599        interrupts.CPU136.RES:Rescheduling_interrupts
      4389 ± 24%     +30.4%       5726        interrupts.CPU137.NMI:Non-maskable_interrupts
      4389 ± 24%     +30.4%       5726        interrupts.CPU137.PMI:Performance_monitoring_interrupts
      3159 ±  4%     -18.7%       2570        interrupts.CPU137.RES:Rescheduling_interrupts
      3192           -20.7%       2532        interrupts.CPU138.RES:Rescheduling_interrupts
      5069           +12.9%       5726        interrupts.CPU139.NMI:Non-maskable_interrupts
      5069           +12.9%       5726        interrupts.CPU139.PMI:Performance_monitoring_interrupts
      3152           -18.1%       2582 ±  3%  interrupts.CPU139.RES:Rescheduling_interrupts
      3308 ±  4%     -17.6%       2727 ±  3%  interrupts.CPU14.RES:Rescheduling_interrupts
     90.75 ±121%     -85.4%      13.25 ± 33%  interrupts.CPU14.TLB:TLB_shootdowns
      3364 ±  3%     -20.5%       2673 ±  3%  interrupts.CPU140.RES:Rescheduling_interrupts
      3215 ±  2%     -19.4%       2591        interrupts.CPU141.RES:Rescheduling_interrupts
      3186 ±  3%     -18.7%       2590 ±  2%  interrupts.CPU142.RES:Rescheduling_interrupts
      3128 ±  3%     -18.9%       2537        interrupts.CPU143.RES:Rescheduling_interrupts
      3251           -18.6%       2648 ±  2%  interrupts.CPU15.RES:Rescheduling_interrupts
      3158 ±  2%     -15.9%       2655        interrupts.CPU16.RES:Rescheduling_interrupts
      3211 ±  3%     -17.9%       2636 ±  2%  interrupts.CPU17.RES:Rescheduling_interrupts
      3298 ±  3%     -19.3%       2663        interrupts.CPU18.RES:Rescheduling_interrupts
      3286 ±  3%     -19.4%       2649 ±  3%  interrupts.CPU19.RES:Rescheduling_interrupts
    128.00 ± 21%     -44.3%      71.25 ± 13%  interrupts.CPU19.TLB:TLB_shootdowns
      3182 ±  4%     -16.1%       2670 ±  3%  interrupts.CPU2.RES:Rescheduling_interrupts
      3298 ±  3%     -21.9%       2575 ±  3%  interrupts.CPU20.RES:Rescheduling_interrupts
      4427 ± 24%     +28.9%       5706        interrupts.CPU21.NMI:Non-maskable_interrupts
      4427 ± 24%     +28.9%       5706        interrupts.CPU21.PMI:Performance_monitoring_interrupts
      3181 ±  4%     -19.7%       2554 ±  3%  interrupts.CPU21.RES:Rescheduling_interrupts
      4445 ± 24%     +28.6%       5717        interrupts.CPU22.NMI:Non-maskable_interrupts
      4445 ± 24%     +28.6%       5717        interrupts.CPU22.PMI:Performance_monitoring_interrupts
      3160 ±  4%     -17.9%       2594 ±  2%  interrupts.CPU22.RES:Rescheduling_interrupts
      3783 ± 32%     +50.5%       5692        interrupts.CPU23.NMI:Non-maskable_interrupts
      3783 ± 32%     +50.5%       5692        interrupts.CPU23.PMI:Performance_monitoring_interrupts
      3265 ±  4%     -20.9%       2582 ±  3%  interrupts.CPU23.RES:Rescheduling_interrupts
      5057 ±  2%     +12.8%       5703        interrupts.CPU24.NMI:Non-maskable_interrupts
      5057 ±  2%     +12.8%       5703        interrupts.CPU24.PMI:Performance_monitoring_interrupts
      3233 ±  2%     -18.9%       2621        interrupts.CPU24.RES:Rescheduling_interrupts
      3184 ±  2%     -19.4%       2567 ±  2%  interrupts.CPU25.RES:Rescheduling_interrupts
      3111 ±  3%     -18.4%       2538        interrupts.CPU26.RES:Rescheduling_interrupts
      3225 ±  3%     -18.7%       2622        interrupts.CPU27.RES:Rescheduling_interrupts
      3166 ±  2%     -17.0%       2627        interrupts.CPU28.RES:Rescheduling_interrupts
      3216 ±  3%     -19.3%       2594        interrupts.CPU29.RES:Rescheduling_interrupts
      5058           +13.5%       5741        interrupts.CPU3.NMI:Non-maskable_interrupts
      5058           +13.5%       5741        interrupts.CPU3.PMI:Performance_monitoring_interrupts
      3172           -17.6%       2614 ±  2%  interrupts.CPU3.RES:Rescheduling_interrupts
      3103 ±  3%     -16.8%       2581        interrupts.CPU30.RES:Rescheduling_interrupts
      3137 ± 32%     +58.1%       4962 ± 24%  interrupts.CPU31.NMI:Non-maskable_interrupts
      3137 ± 32%     +58.1%       4962 ± 24%  interrupts.CPU31.PMI:Performance_monitoring_interrupts
      3166 ±  2%     -18.4%       2583        interrupts.CPU31.RES:Rescheduling_interrupts
      3258           -20.5%       2590        interrupts.CPU32.RES:Rescheduling_interrupts
      3138 ± 32%     +35.5%       4252 ± 32%  interrupts.CPU33.NMI:Non-maskable_interrupts
      3138 ± 32%     +35.5%       4252 ± 32%  interrupts.CPU33.PMI:Performance_monitoring_interrupts
      3294           -21.0%       2603 ±  3%  interrupts.CPU33.RES:Rescheduling_interrupts
      3211 ±  2%     -20.6%       2549        interrupts.CPU34.RES:Rescheduling_interrupts
      3801 ± 33%     +49.8%       5693        interrupts.CPU35.NMI:Non-maskable_interrupts
      3801 ± 33%     +49.8%       5693        interrupts.CPU35.PMI:Performance_monitoring_interrupts
      3219 ±  3%     -20.9%       2546        interrupts.CPU35.RES:Rescheduling_interrupts
      3316 ±  2%     -18.1%       2714        interrupts.CPU36.RES:Rescheduling_interrupts
      3259 ±  3%     -18.5%       2656        interrupts.CPU37.RES:Rescheduling_interrupts
      3111 ±  4%     -15.8%       2619 ±  2%  interrupts.CPU38.RES:Rescheduling_interrupts
      3204 ±  3%     -18.5%       2611        interrupts.CPU39.RES:Rescheduling_interrupts
      4427 ± 24%     +29.6%       5737        interrupts.CPU4.NMI:Non-maskable_interrupts
      4427 ± 24%     +29.6%       5737        interrupts.CPU4.PMI:Performance_monitoring_interrupts
      3119 ±  2%     -16.1%       2618 ±  2%  interrupts.CPU4.RES:Rescheduling_interrupts
      3173 ±  4%     -17.9%       2607 ±  2%  interrupts.CPU40.RES:Rescheduling_interrupts
      3173 ±  2%     -17.6%       2615        interrupts.CPU41.RES:Rescheduling_interrupts
      3248 ±  2%     -18.1%       2659        interrupts.CPU42.RES:Rescheduling_interrupts
      3205 ±  3%     -18.7%       2607        interrupts.CPU43.RES:Rescheduling_interrupts
      3096           -15.6%       2613        interrupts.CPU44.RES:Rescheduling_interrupts
      4446 ± 25%     +28.5%       5716        interrupts.CPU45.NMI:Non-maskable_interrupts
      4446 ± 25%     +28.5%       5716        interrupts.CPU45.PMI:Performance_monitoring_interrupts
      3175 ±  4%     -16.7%       2646        interrupts.CPU45.RES:Rescheduling_interrupts
      3275 ±  4%     -18.9%       2655        interrupts.CPU46.RES:Rescheduling_interrupts
      4426 ± 24%     +28.9%       5706        interrupts.CPU47.NMI:Non-maskable_interrupts
      4426 ± 24%     +28.9%       5706        interrupts.CPU47.PMI:Performance_monitoring_interrupts
      3288 ±  2%     -18.9%       2666        interrupts.CPU47.RES:Rescheduling_interrupts
      4462 ± 24%     +27.5%       5689        interrupts.CPU48.NMI:Non-maskable_interrupts
      4462 ± 24%     +27.5%       5689        interrupts.CPU48.PMI:Performance_monitoring_interrupts
      3127 ±  2%     -16.6%       2608        interrupts.CPU48.RES:Rescheduling_interrupts
      4458 ± 24%     +28.8%       5742        interrupts.CPU49.NMI:Non-maskable_interrupts
      4458 ± 24%     +28.8%       5742        interrupts.CPU49.PMI:Performance_monitoring_interrupts
      3086 ±  4%     -15.6%       2606        interrupts.CPU49.RES:Rescheduling_interrupts
     53.50 ± 86%     -71.5%      15.25 ± 35%  interrupts.CPU49.TLB:TLB_shootdowns
      3174 ± 34%     +81.2%       5750        interrupts.CPU5.NMI:Non-maskable_interrupts
      3174 ± 34%     +81.2%       5750        interrupts.CPU5.PMI:Performance_monitoring_interrupts
      3165 ±  3%     -16.4%       2645 ±  3%  interrupts.CPU5.RES:Rescheduling_interrupts
      3244           -18.1%       2657 ±  3%  interrupts.CPU50.RES:Rescheduling_interrupts
      3176           -17.8%       2609        interrupts.CPU51.RES:Rescheduling_interrupts
      3107 ±  3%     -16.5%       2593        interrupts.CPU52.RES:Rescheduling_interrupts
      3091 ±  3%     -14.7%       2638        interrupts.CPU53.RES:Rescheduling_interrupts
      5064           +12.9%       5720        interrupts.CPU54.NMI:Non-maskable_interrupts
      5064           +12.9%       5720        interrupts.CPU54.PMI:Performance_monitoring_interrupts
      3438 ±  3%     -20.7%       2726 ±  2%  interrupts.CPU54.RES:Rescheduling_interrupts
      3424 ±  2%     -20.8%       2713        interrupts.CPU55.RES:Rescheduling_interrupts
      5074           +12.6%       5714        interrupts.CPU56.NMI:Non-maskable_interrupts
      5074           +12.6%       5714        interrupts.CPU56.PMI:Performance_monitoring_interrupts
      3386           -20.5%       2693 ±  2%  interrupts.CPU56.RES:Rescheduling_interrupts
      3220 ±  3%     -17.6%       2655 ±  2%  interrupts.CPU57.RES:Rescheduling_interrupts
      5072           +12.7%       5717        interrupts.CPU58.NMI:Non-maskable_interrupts
      5072           +12.7%       5717        interrupts.CPU58.PMI:Performance_monitoring_interrupts
      3155 ±  2%     -15.9%       2654        interrupts.CPU58.RES:Rescheduling_interrupts
      5051           +12.9%       5700        interrupts.CPU59.NMI:Non-maskable_interrupts
      5051           +12.9%       5700        interrupts.CPU59.PMI:Performance_monitoring_interrupts
      3320 ±  3%     -18.8%       2696 ±  2%  interrupts.CPU59.RES:Rescheduling_interrupts
      4436 ± 23%     +29.5%       5745        interrupts.CPU6.NMI:Non-maskable_interrupts
      4436 ± 23%     +29.5%       5745        interrupts.CPU6.PMI:Performance_monitoring_interrupts
      3227 ±  2%     -17.4%       2665 ±  2%  interrupts.CPU6.RES:Rescheduling_interrupts
      3272 ±  4%     -18.1%       2680 ±  3%  interrupts.CPU60.RES:Rescheduling_interrupts
      3208 ±  2%     -17.3%       2653 ±  3%  interrupts.CPU61.RES:Rescheduling_interrupts
      5050           +12.9%       5704        interrupts.CPU62.NMI:Non-maskable_interrupts
      5050           +12.9%       5704        interrupts.CPU62.PMI:Performance_monitoring_interrupts
      3165 ±  5%     -17.3%       2617 ±  2%  interrupts.CPU62.RES:Rescheduling_interrupts
      3379 ±  3%     -20.4%       2689 ±  4%  interrupts.CPU63.RES:Rescheduling_interrupts
      3310           -20.8%       2620 ±  2%  interrupts.CPU64.RES:Rescheduling_interrupts
      3319           -18.2%       2716        interrupts.CPU65.RES:Rescheduling_interrupts
      3216 ±  3%     -15.4%       2720        interrupts.CPU66.RES:Rescheduling_interrupts
      5085           +12.0%       5698        interrupts.CPU67.NMI:Non-maskable_interrupts
      5085           +12.0%       5698        interrupts.CPU67.PMI:Performance_monitoring_interrupts
      3201 ±  3%     -18.6%       2607        interrupts.CPU67.RES:Rescheduling_interrupts
      5039           +13.4%       5712        interrupts.CPU68.NMI:Non-maskable_interrupts
      5039           +13.4%       5712        interrupts.CPU68.PMI:Performance_monitoring_interrupts
      3450 ±  2%     -20.0%       2759        interrupts.CPU68.RES:Rescheduling_interrupts
      5053           +12.9%       5706        interrupts.CPU69.NMI:Non-maskable_interrupts
      5053           +12.9%       5706        interrupts.CPU69.PMI:Performance_monitoring_interrupts
      3330           -21.1%       2628 ±  3%  interrupts.CPU69.RES:Rescheduling_interrupts
      5063           +13.6%       5753        interrupts.CPU7.NMI:Non-maskable_interrupts
      5063           +13.6%       5753        interrupts.CPU7.PMI:Performance_monitoring_interrupts
      3138 ±  2%     -17.3%       2594        interrupts.CPU7.RES:Rescheduling_interrupts
      5062           +12.5%       5693        interrupts.CPU70.NMI:Non-maskable_interrupts
      5062           +12.5%       5693        interrupts.CPU70.PMI:Performance_monitoring_interrupts
      3228 ±  3%     -18.5%       2632 ±  2%  interrupts.CPU70.RES:Rescheduling_interrupts
      5056           +13.3%       5729        interrupts.CPU71.NMI:Non-maskable_interrupts
      5056           +13.3%       5729        interrupts.CPU71.PMI:Performance_monitoring_interrupts
      3253 ±  2%     -19.1%       2633 ±  3%  interrupts.CPU71.RES:Rescheduling_interrupts
      3187 ±  2%     -17.4%       2631 ±  2%  interrupts.CPU72.RES:Rescheduling_interrupts
    153.25 ±132%     -92.0%      12.25 ± 50%  interrupts.CPU72.TLB:TLB_shootdowns
      4388 ± 24%     +29.9%       5702        interrupts.CPU73.NMI:Non-maskable_interrupts
      4388 ± 24%     +29.9%       5702        interrupts.CPU73.PMI:Performance_monitoring_interrupts
      3283 ±  2%     -19.0%       2660        interrupts.CPU73.RES:Rescheduling_interrupts
      5027           +13.1%       5687        interrupts.CPU74.NMI:Non-maskable_interrupts
      5027           +13.1%       5687        interrupts.CPU74.PMI:Performance_monitoring_interrupts
      3138           -16.4%       2623 ±  2%  interrupts.CPU74.RES:Rescheduling_interrupts
      3108 ±  3%     -16.5%       2595 ±  2%  interrupts.CPU75.RES:Rescheduling_interrupts
      4369 ± 24%     +30.1%       5684        interrupts.CPU76.NMI:Non-maskable_interrupts
      4369 ± 24%     +30.1%       5684        interrupts.CPU76.PMI:Performance_monitoring_interrupts
      3120 ±  2%     -16.2%       2615 ±  2%  interrupts.CPU76.RES:Rescheduling_interrupts
      5026           +13.1%       5686        interrupts.CPU77.NMI:Non-maskable_interrupts
      5026           +13.1%       5686        interrupts.CPU77.PMI:Performance_monitoring_interrupts
      3164 ±  3%     -17.2%       2619 ±  3%  interrupts.CPU77.RES:Rescheduling_interrupts
      5025           +13.3%       5695        interrupts.CPU78.NMI:Non-maskable_interrupts
      5025           +13.3%       5695        interrupts.CPU78.PMI:Performance_monitoring_interrupts
      3307 ±  2%     -20.3%       2635        interrupts.CPU78.RES:Rescheduling_interrupts
      5014           +13.5%       5689        interrupts.CPU79.NMI:Non-maskable_interrupts
      5014           +13.5%       5689        interrupts.CPU79.PMI:Performance_monitoring_interrupts
      3139 ±  4%     -16.7%       2614 ±  2%  interrupts.CPU79.RES:Rescheduling_interrupts
      3177 ±  3%     -17.6%       2617        interrupts.CPU8.RES:Rescheduling_interrupts
      5043           +13.0%       5700        interrupts.CPU80.NMI:Non-maskable_interrupts
      5043           +13.0%       5700        interrupts.CPU80.PMI:Performance_monitoring_interrupts
      3071 ±  3%     -14.7%       2618 ±  2%  interrupts.CPU80.RES:Rescheduling_interrupts
      5033           +12.9%       5683        interrupts.CPU81.NMI:Non-maskable_interrupts
      5033           +12.9%       5683        interrupts.CPU81.PMI:Performance_monitoring_interrupts
      3172 ±  2%     -16.7%       2641        interrupts.CPU81.RES:Rescheduling_interrupts
      3745 ± 33%     +51.8%       5687 ±  2%  interrupts.CPU82.NMI:Non-maskable_interrupts
      3745 ± 33%     +51.8%       5687 ±  2%  interrupts.CPU82.PMI:Performance_monitoring_interrupts
      3178 ±  4%     -18.1%       2603 ±  2%  interrupts.CPU82.RES:Rescheduling_interrupts
      5021           +13.4%       5694        interrupts.CPU83.NMI:Non-maskable_interrupts
      5021           +13.4%       5694        interrupts.CPU83.PMI:Performance_monitoring_interrupts
      3178 ±  4%     -18.9%       2576 ±  2%  interrupts.CPU83.RES:Rescheduling_interrupts
      4383 ± 24%     +29.7%       5686        interrupts.CPU84.NMI:Non-maskable_interrupts
      4383 ± 24%     +29.7%       5686        interrupts.CPU84.PMI:Performance_monitoring_interrupts
      3035 ±  3%     -14.4%       2597 ±  2%  interrupts.CPU84.RES:Rescheduling_interrupts
      4387 ± 24%     +29.6%       5684        interrupts.CPU85.NMI:Non-maskable_interrupts
      4387 ± 24%     +29.6%       5684        interrupts.CPU85.PMI:Performance_monitoring_interrupts
      3033 ±  3%     -15.4%       2567 ±  2%  interrupts.CPU85.RES:Rescheduling_interrupts
      4398 ± 24%     +29.4%       5691        interrupts.CPU86.NMI:Non-maskable_interrupts
      4398 ± 24%     +29.4%       5691        interrupts.CPU86.PMI:Performance_monitoring_interrupts
      3238 ±  2%     -18.3%       2646        interrupts.CPU86.RES:Rescheduling_interrupts
      5003           +13.5%       5680        interrupts.CPU87.NMI:Non-maskable_interrupts
      5003           +13.5%       5680        interrupts.CPU87.PMI:Performance_monitoring_interrupts
      3124           -16.9%       2596        interrupts.CPU87.RES:Rescheduling_interrupts
      3770 ± 33%     +50.9%       5689        interrupts.CPU88.NMI:Non-maskable_interrupts
      3770 ± 33%     +50.9%       5689        interrupts.CPU88.PMI:Performance_monitoring_interrupts
      3095 ±  2%     -16.0%       2600        interrupts.CPU88.RES:Rescheduling_interrupts
      4391 ± 24%     +29.4%       5680        interrupts.CPU89.NMI:Non-maskable_interrupts
      4391 ± 24%     +29.4%       5680        interrupts.CPU89.PMI:Performance_monitoring_interrupts
      3109 ±  2%     -16.7%       2591        interrupts.CPU89.RES:Rescheduling_interrupts
      5067           +13.3%       5740        interrupts.CPU9.NMI:Non-maskable_interrupts
      5067           +13.3%       5740        interrupts.CPU9.PMI:Performance_monitoring_interrupts
      3248 ±  2%     -17.8%       2669        interrupts.CPU9.RES:Rescheduling_interrupts
      3164 ± 35%     +81.0%       5726        interrupts.CPU90.NMI:Non-maskable_interrupts
      3164 ± 35%     +81.0%       5726        interrupts.CPU90.PMI:Performance_monitoring_interrupts
      3300 ±  3%     -22.3%       2566 ±  2%  interrupts.CPU90.RES:Rescheduling_interrupts
      3793 ± 34%     +50.8%       5720        interrupts.CPU91.NMI:Non-maskable_interrupts
      3793 ± 34%     +50.8%       5720        interrupts.CPU91.PMI:Performance_monitoring_interrupts
      3283 ±  2%     -20.5%       2609 ±  2%  interrupts.CPU91.RES:Rescheduling_interrupts
      3784 ± 34%     +50.3%       5687        interrupts.CPU92.NMI:Non-maskable_interrupts
      3784 ± 34%     +50.3%       5687        interrupts.CPU92.PMI:Performance_monitoring_interrupts
      3270 ±  4%     -21.6%       2564        interrupts.CPU92.RES:Rescheduling_interrupts
      3777 ± 33%     +50.6%       5690        interrupts.CPU93.NMI:Non-maskable_interrupts
      3777 ± 33%     +50.6%       5690        interrupts.CPU93.PMI:Performance_monitoring_interrupts
      3191 ±  3%     -19.0%       2584 ±  2%  interrupts.CPU93.RES:Rescheduling_interrupts
      3800 ± 34%     +50.1%       5705        interrupts.CPU94.NMI:Non-maskable_interrupts
      3800 ± 34%     +50.1%       5705        interrupts.CPU94.PMI:Performance_monitoring_interrupts
      3122 ±  3%     -18.4%       2549        interrupts.CPU94.RES:Rescheduling_interrupts
      3796 ± 34%     +50.7%       5722        interrupts.CPU95.NMI:Non-maskable_interrupts
      3796 ± 34%     +50.7%       5722        interrupts.CPU95.PMI:Performance_monitoring_interrupts
      3214           -20.3%       2563 ±  3%  interrupts.CPU95.RES:Rescheduling_interrupts
      3747 ± 34%     +52.8%       5726        interrupts.CPU96.NMI:Non-maskable_interrupts
      3747 ± 34%     +52.8%       5726        interrupts.CPU96.PMI:Performance_monitoring_interrupts
      3236 ±  2%     -21.7%       2534 ±  2%  interrupts.CPU96.RES:Rescheduling_interrupts
      3151 ± 35%     +81.1%       5707        interrupts.CPU97.NMI:Non-maskable_interrupts
      3151 ± 35%     +81.1%       5707        interrupts.CPU97.PMI:Performance_monitoring_interrupts
      3225 ±  2%     -20.4%       2568 ±  3%  interrupts.CPU97.RES:Rescheduling_interrupts
      3756 ± 33%     +51.7%       5697        interrupts.CPU98.NMI:Non-maskable_interrupts
      3756 ± 33%     +51.7%       5697        interrupts.CPU98.PMI:Performance_monitoring_interrupts
      3142 ±  3%     -19.8%       2521 ±  2%  interrupts.CPU98.RES:Rescheduling_interrupts
      3796 ± 34%     +50.8%       5725        interrupts.CPU99.NMI:Non-maskable_interrupts
      3796 ± 34%     +50.8%       5725        interrupts.CPU99.PMI:Performance_monitoring_interrupts
      3324 ±  2%     -23.4%       2545 ±  2%  interrupts.CPU99.RES:Rescheduling_interrupts
    641941 ±  9%     +19.0%     764083        interrupts.NMI:Non-maskable_interrupts
    641941 ±  9%     +19.0%     764083        interrupts.PMI:Performance_monitoring_interrupts
    462083           -18.6%     376342        interrupts.RES:Rescheduling_interrupts





Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


Thanks,
Rong Chen


--Wn0J+vu9+NMIXK57
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="config-5.10.0-rc1-00044-gd8fcb81f1acf"

#
# Automatically generated file; DO NOT EDIT.
# Linux/x86_64 5.10.0-rc1 Kernel Configuration
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
# CONFIG_INTEL_MEI_VIRTIO is not set
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
CONFIG_TUN=m
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
CONFIG_SMSC_PHY=y
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
CONFIG_USB_CATC=y
CONFIG_USB_KAWETH=y
CONFIG_USB_PEGASUS=y
CONFIG_USB_RTL8150=y
CONFIG_USB_RTL8152=m
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
CONFIG_VIRTIO_BALLOON=y
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
# CONFIG_MST_IRQ is not set
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

--Wn0J+vu9+NMIXK57
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
	export runtime=300
	export nr_threads=36
	export cluster='cs-localhost'
	export job_origin='/lkp-src/allot/cyclic:p1:linux-devel:devel-hourly/lkp-cpl-4sp1/netperf-small-threads.yaml'
	export queue_cmdline_keys='branch
commit
queue_at_least_once'
	export queue='validate'
	export testbox='lkp-cpl-4sp1'
	export tbox_group='lkp-cpl-4sp1'
	export kconfig='x86_64-rhel-8.3'
	export submit_id='5f9d1257ab60a6353e5f8501'
	export job_file='/lkp/jobs/scheduled/lkp-cpl-4sp1/netperf-cs-localhost-performance-ipv4-25%-300s-SCTP_RR-ucode=0x700001c-monitor=3472ca3d-debian-10.4-x86_64-20200603.cgz-d8fcb81f-20201031-13630-8cg0gc-3.yaml'
	export id='078e9410d85495b4cb632152eb48c9177f5f6d71'
	export queuer_version='/lkp-src'
	export model='Cooper Lake'
	export nr_node=4
	export nr_cpu=144
	export memory='128G'
	export nr_hdd_partitions=
	export nr_ssd_partitions=2
	export hdd_partitions=
	export ssd_partitions='/dev/disk/by-id/nvme-INTEL_SSDPE2KX040T7_PHLF741401DF4P0IGN-part4
/dev/disk/by-id/nvme-INTEL_SSDPE2KX040T7_PHLF741401DF4P0IGN-part5'
	export swap_partitions=
	export rootfs_partition='/dev/disk/by-id/nvme-INTEL_SSDPE2KX040T7_PHLF741401DF4P0IGN-part3'
	export kernel_cmdline_hw='acpi_rsdp=0x695fd014'
	export brand='Intel(R) Xeon(R) Gold 5318H CPU @ 2.50GHz'
	export commit='d8fcb81f1acf651a0e50eacecca43d0524984f87'
	export need_kconfig_hw='CONFIG_IGB=y
CONFIG_SATA_AHCI'
	export ucode='0x700001c'
	export enqueue_time='2020-10-31 15:29:27 +0800'
	export _id='5f9d125aab60a6353e5f8502'
	export _rt='/result/netperf/cs-localhost-performance-ipv4-25%-300s-SCTP_RR-ucode=0x700001c-monitor=3472ca3d/lkp-cpl-4sp1/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/d8fcb81f1acf651a0e50eacecca43d0524984f87'
	export user='lkp'
	export compiler='gcc-9'
	export head_commit='58cdbc2e9b1a74decce9bc4a65da9324eb2c23ea'
	export base_commit='3650b228f83adda7e5ee532e2b90429c03f7b9ec'
	export branch='tip/sched/core'
	export rootfs='debian-10.4-x86_64-20200603.cgz'
	export monitor_sha='3472ca3d'
	export result_root='/result/netperf/cs-localhost-performance-ipv4-25%-300s-SCTP_RR-ucode=0x700001c-monitor=3472ca3d/lkp-cpl-4sp1/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/d8fcb81f1acf651a0e50eacecca43d0524984f87/3'
	export scheduler_version='/lkp/lkp/.src-20201030-151109'
	export LKP_SERVER='internal-lkp-server'
	export arch='x86_64'
	export max_uptime=3600
	export initrd='/osimage/debian/debian-10.4-x86_64-20200603.cgz'
	export bootloader_append='root=/dev/ram0
user=lkp
job=/lkp/jobs/scheduled/lkp-cpl-4sp1/netperf-cs-localhost-performance-ipv4-25%-300s-SCTP_RR-ucode=0x700001c-monitor=3472ca3d-debian-10.4-x86_64-20200603.cgz-d8fcb81f-20201031-13630-8cg0gc-3.yaml
ARCH=x86_64
kconfig=x86_64-rhel-8.3
branch=tip/sched/core
commit=d8fcb81f1acf651a0e50eacecca43d0524984f87
BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3/gcc-9/d8fcb81f1acf651a0e50eacecca43d0524984f87/vmlinuz-5.10.0-rc1-00044-gd8fcb81f1acf
acpi_rsdp=0x695fd014
max_uptime=3600
RESULT_ROOT=/result/netperf/cs-localhost-performance-ipv4-25%-300s-SCTP_RR-ucode=0x700001c-monitor=3472ca3d/lkp-cpl-4sp1/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/d8fcb81f1acf651a0e50eacecca43d0524984f87/3
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
	export modules_initrd='/pkg/linux/x86_64-rhel-8.3/gcc-9/d8fcb81f1acf651a0e50eacecca43d0524984f87/modules.cgz'
	export bm_initrd='/osimage/deps/debian-10.4-x86_64-20200603.cgz/run-ipconfig_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/lkp_20200709.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/rsync-rootfs_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/netperf_20201007.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/netperf-x86_64-2.7-0_20201007.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/mpstat_20200714.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/perf_20200723.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/perf-x86_64-c85fb28b6f99-1_20201008.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/sar-x86_64-34c92ae-1_20200702.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/hw_20200715.cgz'
	export ucode_initrd='/osimage/ucode/intel-ucode-20200610.cgz'
	export lkp_initrd='/osimage/user/lkp/lkp-x86_64.cgz'
	export site='inn'
	export LKP_CGI_PORT=80
	export LKP_CIFS_PORT=139
	export last_kernel='5.10.0-rc1'
	export repeat_to=4
	export schedule_notify_address=
	export queue_at_least_once=1
	export kernel='/pkg/linux/x86_64-rhel-8.3/gcc-9/d8fcb81f1acf651a0e50eacecca43d0524984f87/vmlinuz-5.10.0-rc1-00044-gd8fcb81f1acf'
	export dequeue_time='2020-10-31 15:44:54 +0800'
	export node_roles='server client'
	export job_initrd='/lkp/jobs/scheduled/lkp-cpl-4sp1/netperf-cs-localhost-performance-ipv4-25%-300s-SCTP_RR-ucode=0x700001c-monitor=3472ca3d-debian-10.4-x86_64-20200603.cgz-d8fcb81f-20201031-13630-8cg0gc-3.cgz'

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
	run_monitor $LKP_SRC/monitors/no-stdout/wrapper perf-profile
	run_monitor $LKP_SRC/monitors/wrapper oom-killer
	run_monitor $LKP_SRC/monitors/plain/watchdog

	if role server
	then
		start_daemon $LKP_SRC/daemon/netserver
	fi

	if role client
	then
		run_test test='SCTP_RR' $LKP_SRC/tests/wrapper netperf
	fi
}

extract_stats()
{
	export stats_part_begin=
	export stats_part_end=

	$LKP_SRC/stats/wrapper netperf
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
	$LKP_SRC/stats/wrapper perf-profile

	$LKP_SRC/stats/wrapper time netperf.time
	$LKP_SRC/stats/wrapper dmesg
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper last_state
	$LKP_SRC/stats/wrapper stderr
	$LKP_SRC/stats/wrapper time
}

"$@"

--Wn0J+vu9+NMIXK57
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
runtime: 300s
nr_threads: 25%
cluster: cs-localhost
if role server:
  netserver: 
if role client:
  netperf:
    test: SCTP_RR
job_origin: "/lkp-src/allot/cyclic:p1:linux-devel:devel-hourly/lkp-cpl-4sp1/netperf-small-threads.yaml"

#! queue options
queue_cmdline_keys:
- branch
- commit
- queue_at_least_once
queue: bisect
testbox: lkp-cpl-4sp1
tbox_group: lkp-cpl-4sp1
kconfig: x86_64-rhel-8.3
submit_id: 5f9ccd99ab60a62ebf421e03
job_file: "/lkp/jobs/scheduled/lkp-cpl-4sp1/netperf-cs-localhost-performance-ipv4-25%-300s-SCTP_RR-ucode=0x700001c-monitor=3472ca3d-debian-10.4-x86_64-20200603.cgz-d8fcb81f-20201031-11967-1cwx43f-0.yaml"
id: e94d80e30bdf541067acaac03a80db235bd48196
queuer_version: "/lkp-src"

#! hosts/lkp-cpl-4sp1
model: Cooper Lake
nr_node: 4
nr_cpu: 144
memory: 128G
nr_hdd_partitions: 
nr_ssd_partitions: 2
hdd_partitions: 
ssd_partitions:
- "/dev/disk/by-id/nvme-INTEL_SSDPE2KX040T7_PHLF741401DF4P0IGN-part4"
- "/dev/disk/by-id/nvme-INTEL_SSDPE2KX040T7_PHLF741401DF4P0IGN-part5"
swap_partitions: 
rootfs_partition: "/dev/disk/by-id/nvme-INTEL_SSDPE2KX040T7_PHLF741401DF4P0IGN-part3"
kernel_cmdline_hw: acpi_rsdp=0x695fd014
brand: Intel(R) Xeon(R) Gold 5318H CPU @ 2.50GHz

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
perf-profile: 

#! include/category/ALL
cpufreq_governor: performance

#! include/queue/cyclic
commit: d8fcb81f1acf651a0e50eacecca43d0524984f87

#! include/testbox/lkp-cpl-4sp1
need_kconfig_hw:
- CONFIG_IGB=y
- CONFIG_SATA_AHCI
ucode: '0x700001c'
enqueue_time: 2020-10-31 10:36:09.641900810 +08:00
_id: 5f9ccd99ab60a62ebf421e03
_rt: "/result/netperf/cs-localhost-performance-ipv4-25%-300s-SCTP_RR-ucode=0x700001c-monitor=3472ca3d/lkp-cpl-4sp1/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/d8fcb81f1acf651a0e50eacecca43d0524984f87"

#! schedule options
user: lkp
compiler: gcc-9
head_commit: 58cdbc2e9b1a74decce9bc4a65da9324eb2c23ea
base_commit: 3650b228f83adda7e5ee532e2b90429c03f7b9ec
branch: linux-devel/devel-hourly-2020102920
rootfs: debian-10.4-x86_64-20200603.cgz
monitor_sha: 3472ca3d
result_root: "/result/netperf/cs-localhost-performance-ipv4-25%-300s-SCTP_RR-ucode=0x700001c-monitor=3472ca3d/lkp-cpl-4sp1/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/d8fcb81f1acf651a0e50eacecca43d0524984f87/0"
scheduler_version: "/lkp/lkp/.src-20201030-151109"
LKP_SERVER: internal-lkp-server
arch: x86_64
max_uptime: 3600
initrd: "/osimage/debian/debian-10.4-x86_64-20200603.cgz"
bootloader_append:
- root=/dev/ram0
- user=lkp
- job=/lkp/jobs/scheduled/lkp-cpl-4sp1/netperf-cs-localhost-performance-ipv4-25%-300s-SCTP_RR-ucode=0x700001c-monitor=3472ca3d-debian-10.4-x86_64-20200603.cgz-d8fcb81f-20201031-11967-1cwx43f-0.yaml
- ARCH=x86_64
- kconfig=x86_64-rhel-8.3
- branch=linux-devel/devel-hourly-2020102920
- commit=d8fcb81f1acf651a0e50eacecca43d0524984f87
- BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3/gcc-9/d8fcb81f1acf651a0e50eacecca43d0524984f87/vmlinuz-5.10.0-rc1-00044-gd8fcb81f1acf
- acpi_rsdp=0x695fd014
- max_uptime=3600
- RESULT_ROOT=/result/netperf/cs-localhost-performance-ipv4-25%-300s-SCTP_RR-ucode=0x700001c-monitor=3472ca3d/lkp-cpl-4sp1/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/d8fcb81f1acf651a0e50eacecca43d0524984f87/0
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
modules_initrd: "/pkg/linux/x86_64-rhel-8.3/gcc-9/d8fcb81f1acf651a0e50eacecca43d0524984f87/modules.cgz"
bm_initrd: "/osimage/deps/debian-10.4-x86_64-20200603.cgz/run-ipconfig_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/lkp_20200709.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/rsync-rootfs_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/netperf_20201007.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/netperf-x86_64-2.7-0_20201007.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/mpstat_20200714.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/perf_20200723.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/perf-x86_64-c85fb28b6f99-1_20201008.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/sar-x86_64-34c92ae-1_20200702.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/hw_20200715.cgz"
ucode_initrd: "/osimage/ucode/intel-ucode-20200610.cgz"
lkp_initrd: "/osimage/user/lkp/lkp-x86_64.cgz"
site: inn

#! /lkp/lkp/.src-20201030-151109/include/site/inn
LKP_CGI_PORT: 80
LKP_CIFS_PORT: 139
oom-killer: 
watchdog: 

#! runtime status
last_kernel: 5.10.0-rc1-00031-gb9c88f752268
repeat_to: 2
schedule_notify_address: 

#! user overrides
queue_at_least_once: 0
kernel: "/pkg/linux/x86_64-rhel-8.3/gcc-9/d8fcb81f1acf651a0e50eacecca43d0524984f87/vmlinuz-5.10.0-rc1-00044-gd8fcb81f1acf"
dequeue_time: 2020-10-31 10:39:32.403649392 +08:00
job_state: finished
loadavg: 36.60 28.41 12.81 1/993 12667
start_time: '1550139125'
end_time: '1550139430'
version: "/lkp/lkp/.src-20201030-151142:e3501b91:90ebc7619"

--Wn0J+vu9+NMIXK57
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
modprobe sctp
netperf -4 -H 127.0.0.1 -t SCTP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t SCTP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t SCTP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t SCTP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t SCTP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t SCTP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t SCTP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t SCTP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t SCTP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t SCTP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t SCTP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t SCTP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t SCTP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t SCTP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t SCTP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t SCTP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t SCTP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t SCTP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t SCTP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t SCTP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t SCTP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t SCTP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t SCTP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t SCTP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t SCTP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t SCTP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t SCTP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t SCTP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t SCTP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t SCTP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t SCTP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t SCTP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t SCTP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t SCTP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t SCTP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t SCTP_RR -c -C -l 300  &
wait

--Wn0J+vu9+NMIXK57--
