Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 131132C3BBE
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 10:10:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727847AbgKYJKk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 04:10:40 -0500
Received: from mga09.intel.com ([134.134.136.24]:6902 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727780AbgKYJKg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 04:10:36 -0500
IronPort-SDR: ltGDTdOvk+2cQmVUKTfhl6OsYmBQc5wZryLqHjre76NbLUaMIzsXMnwfEZ2OzH42+6PXgExopM
 O/JbOVoSItrw==
X-IronPort-AV: E=McAfee;i="6000,8403,9815"; a="172252262"
X-IronPort-AV: E=Sophos;i="5.78,368,1599548400"; 
   d="yaml'?scan'208";a="172252262"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2020 01:10:19 -0800
IronPort-SDR: dVtgmSVqRA+pyiJo9sh+gr1KSy8rgTGH9IuxLKzajw+4nY5mA29if1fEZWq3EMiAuBc0pmVsA5
 u05MNziqioKA==
X-IronPort-AV: E=Sophos;i="5.78,368,1599548400"; 
   d="yaml'?scan'208";a="547195298"
Received: from shao2-debian.sh.intel.com (HELO localhost) ([10.239.13.117])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2020 01:10:12 -0800
Date:   Wed, 25 Nov 2020 17:09:23 +0800
From:   kernel test robot <rong.a.chen@intel.com>
To:     Aubrey Li <aubrey.li@linux.intel.com>
Cc:     0day robot <lkp@intel.com>, Mel Gorman <mgorman@suse.de>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Qais Yousef <qais.yousef@arm.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Jiang Biao <benbjiang@gmail.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        ying.huang@intel.com, feng.tang@intel.com, zhengjun.xing@intel.com,
        mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        mgorman@techsingularity.net, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com,
        Aubrey Li <aubrey.li@intel.com>, yu.c.chen@intel.com
Subject: [sched/fair] 8d86968ac3: netperf.Throughput_tps -29.5% regression
Message-ID: <20201125090923.GA3723@shao2-debian>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="90KBcPA0h13nTGdQ"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201116200428.47359-1-aubrey.li@linux.intel.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--90KBcPA0h13nTGdQ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Greeting,

FYI, we noticed a -29.5% regression of netperf.Throughput_tps due to commit:


commit: 8d86968ac36ea5bff487f70b5ffc252a87d44c51 ("[RFC PATCH v4] sched/fair: select idle cpu from idle cpumask for task wakeup")
url: https://github.com/0day-ci/linux/commits/Aubrey-Li/sched-fair-select-idle-cpu-from-idle-cpumask-for-task-wakeup/20201118-115145
base: https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git 09162bc32c880a791c6c0668ce0745cf7958f576

in testcase: netperf
on test machine: 192 threads Intel(R) Xeon(R) Platinum 9242 CPU @ 2.30GHz with 192G memory
with following parameters:

	ip: ipv4
	runtime: 300s
	nr_threads: 50%
	cluster: cs-localhost
	test: UDP_RR
	cpufreq_governor: performance
	ucode: 0x5003003

test-description: Netperf is a benchmark that can be use to measure various aspect of networking performance.
test-url: http://www.netperf.org/netperf/

In addition to that, the commit also has significant impact on the following tests:

+------------------+---------------------------------------------------------------------------+
| testcase: change | hackbench: hackbench.throughput 51.7% improvement                         |
| test machine     | 192 threads Intel(R) Xeon(R) Platinum 9242 CPU @ 2.30GHz with 192G memory |
| test parameters  | cpufreq_governor=performance                                              |
|                  | ipc=pipe                                                                  |
|                  | iterations=4                                                              |
|                  | mode=threads                                                              |
|                  | nr_threads=100%                                                           |
|                  | ucode=0x5003003                                                           |
+------------------+---------------------------------------------------------------------------+


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
  cs-localhost/gcc-9/performance/ipv4/x86_64-rhel-8.3/50%/debian-10.4-x86_64-20200603.cgz/300s/lkp-csl-2ap3/UDP_RR/netperf/0x5003003

commit: 
  v5.10-rc4
  8d86968ac3 ("sched/fair: select idle cpu from idle cpumask for task wakeup")

       v5.10-rc4 8d86968ac36ea5bff487f70b5ff 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
   6435510           -29.5%    4538527 ± 16%  netperf.Throughput_total_tps
     67036           -29.5%      47276 ± 16%  netperf.Throughput_tps
     27542 ±  3%   +1221.7%     364031 ± 40%  netperf.time.involuntary_context_switches
     31127 ±  3%      -8.5%      28478        netperf.time.minor_page_faults
      4543            -5.3%       4303 ±  2%  netperf.time.percent_of_cpu_this_job_got
     12995            -4.0%      12475        netperf.time.system_time
    744.93 ± 37%     -35.2%     482.53 ± 17%  netperf.time.user_time
 1.914e+09           -29.8%  1.343e+09 ± 15%  netperf.time.voluntary_context_switches
 1.931e+09           -29.5%  1.362e+09 ± 16%  netperf.workload
      5295 ±  4%     -12.8%       4619 ±  4%  boot-time.idle
     42.38            +5.2       47.56        mpstat.cpu.all.idle%
     12.50            -1.5       10.96        mpstat.cpu.all.soft%
      2.48 ± 36%      -0.9        1.60 ± 14%  mpstat.cpu.all.usr%
 1.769e+10           -20.6%  1.404e+10 ± 14%  cpuidle.C1.time
 3.239e+09           -53.2%  1.516e+09 ± 10%  cpuidle.C1.usage
 1.573e+09 ±  6%     +68.0%  2.643e+09 ± 24%  cpuidle.POLL.time
 5.111e+08 ±  6%     +71.8%  8.779e+08 ± 24%  cpuidle.POLL.usage
      1119 ± 11%     -21.4%     880.25 ±  8%  slabinfo.file_lock_cache.active_objs
      1119 ± 11%     -21.4%     880.25 ±  8%  slabinfo.file_lock_cache.num_objs
    736.67 ± 11%     +18.7%     874.75 ±  4%  slabinfo.mnt_cache.active_objs
    736.67 ± 11%     +18.7%     874.75 ±  4%  slabinfo.mnt_cache.num_objs
     42.22           +12.5%      47.50        vmstat.cpu.id
     54.44            -7.7%      50.25        vmstat.cpu.sy
  24999287           -29.7%   17577090 ± 15%  vmstat.system.cs
    535220 ±  2%    +104.3%    1093710 ± 11%  vmstat.system.in
    267806            +2.7%     275098        proc-vmstat.nr_file_pages
    232781            +3.3%     240383        proc-vmstat.nr_unevictable
    232781            +3.3%     240383        proc-vmstat.nr_zone_unevictable
   1148875            +1.9%    1170390        proc-vmstat.pgalloc_normal
   1198746            +1.5%    1216673        proc-vmstat.pgfree
     62163            +4.1%      64725        proc-vmstat.pgreuse
      5980 ± 66%    +457.3%      33326 ± 34%  numa-vmstat.node3.nr_anon_pages
     88391 ±  4%      +6.7%      94292 ±  5%  numa-vmstat.node3.nr_file_pages
      8797 ± 46%    +310.1%      36074 ± 30%  numa-vmstat.node3.nr_inactive_anon
    305.22 ± 67%    +133.1%     711.50 ± 47%  numa-vmstat.node3.nr_page_table_pages
     17135 ±  8%     +24.7%      21361 ±  5%  numa-vmstat.node3.nr_slab_unreclaimable
     56546 ±  4%     +10.6%      62560 ±  8%  numa-vmstat.node3.nr_unevictable
      8797 ± 46%    +310.1%      36074 ± 30%  numa-vmstat.node3.nr_zone_inactive_anon
     56546 ±  4%     +10.6%      62560 ±  8%  numa-vmstat.node3.nr_zone_unevictable
    646892 ± 12%     +24.2%     803392 ± 20%  sched_debug.cfs_rq:/.MIN_vruntime.avg
    646892 ± 12%     +24.2%     803392 ± 20%  sched_debug.cfs_rq:/.max_vruntime.avg
   6803725 ±  3%     -12.0%    5985546 ±  4%  sched_debug.cfs_rq:/.min_vruntime.avg
   6416050 ±  4%     -12.1%    5642537 ±  2%  sched_debug.cfs_rq:/.min_vruntime.min
     11.33 ±  4%     +22.8%      13.91 ±  5%  sched_debug.cpu.clock.stddev
  19705568           -30.6%   13666360 ± 14%  sched_debug.cpu.nr_switches.avg
  20297607           -28.4%   14542250 ± 15%  sched_debug.cpu.nr_switches.max
  18265217 ±  5%     -36.4%   11619859 ±  8%  sched_debug.cpu.nr_switches.min
      7420 ±188%   +1090.8%      88360 ± 41%  numa-meminfo.node3.AnonHugePages
     24002 ± 66%    +455.2%     133268 ± 34%  numa-meminfo.node3.AnonPages
    353532 ±  4%      +6.6%     376995 ±  5%  numa-meminfo.node3.FilePages
     35382 ± 46%    +307.6%     144218 ± 30%  numa-meminfo.node3.Inactive
     35382 ± 46%    +307.6%     144218 ± 30%  numa-meminfo.node3.Inactive(anon)
    689494 ±  3%     +25.1%     862864 ±  7%  numa-meminfo.node3.MemUsed
      1222 ± 67%    +133.6%       2855 ± 47%  numa-meminfo.node3.PageTables
     68543 ±  8%     +24.7%      85450 ±  5%  numa-meminfo.node3.SUnreclaim
     90075 ±  9%     +27.7%     115036 ± 10%  numa-meminfo.node3.Slab
    226187 ±  4%     +10.6%     250243 ±  8%  numa-meminfo.node3.Unevictable
     12.18 ±  2%     -44.7%       6.74 ± 14%  perf-stat.i.MPKI
 4.181e+10           -28.3%  2.999e+10 ± 16%  perf-stat.i.branch-instructions
      1.83            +0.0        1.86        perf-stat.i.branch-miss-rate%
 7.593e+08           -27.2%  5.526e+08 ± 15%  perf-stat.i.branch-misses
      2.51 ±  7%     +17.4       19.91 ± 30%  perf-stat.i.cache-miss-rate%
  60330073 ±  9%    +185.8%  1.724e+08 ±  8%  perf-stat.i.cache-misses
 2.531e+09 ±  2%     -61.0%  9.877e+08 ± 30%  perf-stat.i.cache-references
  25244027           -29.8%   17733510 ± 15%  perf-stat.i.context-switches
      2.16           +55.9%       3.37 ± 13%  perf-stat.i.cpi
     34147 ± 44%     -84.0%       5447 ±141%  perf-stat.i.cpu-migrations
      7808 ± 10%     -63.8%       2824 ± 12%  perf-stat.i.cycles-between-cache-misses
      0.01 ±113%      -0.0        0.00 ±  5%  perf-stat.i.dTLB-load-miss-rate%
   5424859 ±121%     -69.4%    1659555 ±  8%  perf-stat.i.dTLB-load-misses
 5.989e+10           -29.0%  4.253e+10 ± 16%  perf-stat.i.dTLB-loads
      0.00 ± 33%      -0.0        0.00 ± 10%  perf-stat.i.dTLB-store-miss-rate%
    336031 ± 17%     -56.3%     146755 ± 22%  perf-stat.i.dTLB-store-misses
 3.664e+10           -29.3%   2.59e+10 ± 15%  perf-stat.i.dTLB-stores
     60.69           +11.0       71.70 ±  2%  perf-stat.i.iTLB-load-miss-rate%
 4.987e+08           -25.2%  3.732e+08 ± 14%  perf-stat.i.iTLB-load-misses
 3.222e+08           -56.0%  1.418e+08 ± 10%  perf-stat.i.iTLB-loads
 2.079e+11           -28.6%  1.484e+11 ± 16%  perf-stat.i.instructions
    427.23            -5.5%     403.56        perf-stat.i.instructions-per-iTLB-miss
      0.46           -33.5%       0.31 ± 12%  perf-stat.i.ipc
      0.51 ± 13%     +72.4%       0.88 ± 22%  perf-stat.i.metric.K/sec
    735.55           -29.5%     518.65 ± 16%  perf-stat.i.metric.M/sec
      3980            +1.4%       4035        perf-stat.i.minor-faults
     93.95 ±  2%      -4.5       89.46 ±  2%  perf-stat.i.node-load-miss-rate%
  10301101 ± 23%    +102.4%   20844338 ±  8%  perf-stat.i.node-load-misses
    620028 ± 18%    +290.3%    2419720 ± 18%  perf-stat.i.node-loads
   6105310 ±  5%     -26.3%    4502292 ± 10%  perf-stat.i.node-store-misses
      3980            +1.4%       4036        perf-stat.i.page-faults
     12.17           -46.2%       6.55 ± 16%  perf-stat.overall.MPKI
      1.82            +0.0        1.84        perf-stat.overall.branch-miss-rate%
      2.38 ±  8%     +16.8       19.23 ± 30%  perf-stat.overall.cache-miss-rate%
      2.16           +51.9%       3.28 ± 12%  perf-stat.overall.cpi
      7499 ±  9%     -62.7%       2800 ± 12%  perf-stat.overall.cycles-between-cache-misses
      0.01 ±123%      -0.0        0.00 ±  9%  perf-stat.overall.dTLB-load-miss-rate%
      0.00 ± 18%      -0.0        0.00 ±  7%  perf-stat.overall.dTLB-store-miss-rate%
     60.75           +11.6       72.35 ±  2%  perf-stat.overall.iTLB-load-miss-rate%
    416.92            -4.8%     396.80        perf-stat.overall.instructions-per-iTLB-miss
      0.46           -33.2%       0.31 ± 12%  perf-stat.overall.ipc
     32566            +1.3%      33004        perf-stat.overall.path-length
 4.167e+10           -28.2%  2.992e+10 ± 16%  perf-stat.ps.branch-instructions
 7.567e+08           -27.1%  5.514e+08 ± 15%  perf-stat.ps.branch-misses
  60126010 ±  9%    +185.6%  1.717e+08 ±  8%  perf-stat.ps.cache-misses
 2.522e+09 ±  2%     -61.0%  9.842e+08 ± 30%  perf-stat.ps.cache-references
  25154040           -29.7%   17694852 ± 15%  perf-stat.ps.context-switches
     34363 ± 44%     -84.2%       5439 ±141%  perf-stat.ps.cpu-migrations
   5439495 ±121%     -69.5%    1661354 ±  8%  perf-stat.ps.dTLB-load-misses
 5.968e+10           -28.9%  4.243e+10 ± 16%  perf-stat.ps.dTLB-loads
    336620 ± 17%     -56.5%     146564 ± 22%  perf-stat.ps.dTLB-store-misses
 3.651e+10           -29.2%  2.584e+10 ± 15%  perf-stat.ps.dTLB-stores
 4.969e+08           -25.1%  3.723e+08 ± 14%  perf-stat.ps.iTLB-load-misses
  3.21e+08           -56.0%  1.412e+08 ± 10%  perf-stat.ps.iTLB-loads
 2.071e+11           -28.5%  1.481e+11 ± 16%  perf-stat.ps.instructions
      3968            +1.4%       4025        perf-stat.ps.minor-faults
  10263866 ± 23%    +102.2%   20752139 ±  8%  perf-stat.ps.node-load-misses
    619050 ± 18%    +289.5%    2411394 ± 18%  perf-stat.ps.node-loads
   6083835 ±  5%     -26.2%    4491466 ± 10%  perf-stat.ps.node-store-misses
      3968            +1.4%       4025        perf-stat.ps.page-faults
 6.287e+13           -28.6%   4.49e+13 ± 16%  perf-stat.total.instructions
   9598062 ±  5%     -30.1%    6706576 ± 16%  softirqs.CPU0.NET_RX
  10058114 ±  2%     -30.8%    6965070 ± 17%  softirqs.CPU1.NET_RX
  10077199 ±  2%     -30.9%    6964205 ± 17%  softirqs.CPU10.NET_RX
  10070125 ±  2%     -31.1%    6943158 ± 18%  softirqs.CPU100.NET_RX
  10031200           -31.0%    6917056 ± 17%  softirqs.CPU101.NET_RX
   9991112           -30.6%    6932680 ± 17%  softirqs.CPU102.NET_RX
  10043320 ±  2%     -27.9%    7244399 ± 22%  softirqs.CPU103.NET_RX
  10121662           -29.8%    7109724 ± 20%  softirqs.CPU104.NET_RX
  10093611           -31.2%    6942165 ± 17%  softirqs.CPU105.NET_RX
  10094809 ±  2%     -31.1%    6955098 ± 17%  softirqs.CPU106.NET_RX
  10046133 ±  3%     -28.7%    7165228 ± 21%  softirqs.CPU107.NET_RX
  10007488 ±  2%     -30.8%    6929771 ± 17%  softirqs.CPU108.NET_RX
  10084499 ±  2%     -29.1%    7152263 ± 21%  softirqs.CPU109.NET_RX
  10035925 ±  2%     -28.8%    7148940 ± 21%  softirqs.CPU11.NET_RX
  10045773           -30.9%    6944080 ± 17%  softirqs.CPU110.NET_RX
  10048867           -30.9%    6939555 ± 16%  softirqs.CPU111.NET_RX
  10039974           -31.4%    6889597 ± 17%  softirqs.CPU112.NET_RX
  10012417           -30.5%    6956726 ± 18%  softirqs.CPU113.NET_RX
  10035866           -29.7%    7052422 ± 20%  softirqs.CPU114.NET_RX
  10064513 ±  2%     -30.7%    6971345 ± 17%  softirqs.CPU115.NET_RX
  10100457 ±  2%     -30.9%    6977884 ± 17%  softirqs.CPU116.NET_RX
  10002844           -30.7%    6927404 ± 17%  softirqs.CPU117.NET_RX
   9984454 ±  2%     -30.6%    6925499 ± 18%  softirqs.CPU119.NET_RX
  10006109           -30.3%    6978624 ± 18%  softirqs.CPU12.NET_RX
   9931485 ±  2%     -26.8%    7265254 ± 15%  softirqs.CPU120.NET_RX
   9985048           -26.6%    7329426 ± 14%  softirqs.CPU121.NET_RX
  10116183 ±  2%     -27.1%    7375060 ± 16%  softirqs.CPU122.NET_RX
  10116005           -27.7%    7311564 ± 16%  softirqs.CPU123.NET_RX
  10133098 ±  2%     -27.5%    7350965 ± 16%  softirqs.CPU124.NET_RX
  10059939           -28.4%    7199505 ± 15%  softirqs.CPU125.NET_RX
  10037180 ±  2%     -27.8%    7245521 ± 15%  softirqs.CPU126.NET_RX
  10042994           -27.2%    7311871 ± 16%  softirqs.CPU127.NET_RX
  10118808           -27.8%    7303465 ± 15%  softirqs.CPU128.NET_RX
  10076652           -26.9%    7370082 ± 16%  softirqs.CPU129.NET_RX
  10033328 ±  2%     -28.7%    7149044 ± 21%  softirqs.CPU13.NET_RX
  10046145           -27.7%    7259028 ± 15%  softirqs.CPU130.NET_RX
   9952067 ±  2%     -26.1%    7351998 ± 17%  softirqs.CPU131.NET_RX
  10040127 ±  2%     -27.0%    7332603 ± 15%  softirqs.CPU132.NET_RX
  10069591 ±  2%     -26.3%    7420834 ± 18%  softirqs.CPU133.NET_RX
  10102760           -27.3%    7348336 ± 16%  softirqs.CPU134.NET_RX
  10090831           -26.9%    7374702 ± 17%  softirqs.CPU135.NET_RX
  10097478           -28.1%    7264904 ± 15%  softirqs.CPU136.NET_RX
  10034687           -27.9%    7230010 ± 15%  softirqs.CPU137.NET_RX
  10029853           -27.8%    7244713 ± 15%  softirqs.CPU138.NET_RX
  10012824 ±  2%     -24.9%    7515913 ± 20%  softirqs.CPU139.NET_RX
  10048533 ±  2%     -30.4%    6996419 ± 17%  softirqs.CPU14.NET_RX
  10100436           -27.1%    7365039 ± 17%  softirqs.CPU140.NET_RX
   9964276           -28.2%    7158208 ± 14%  softirqs.CPU142.NET_RX
   9899363 ±  2%     -27.7%    7153366 ± 14%  softirqs.CPU143.NET_RX
   9877218           -26.3%    7283415 ± 16%  softirqs.CPU144.NET_RX
   9993949           -26.1%    7381228 ± 15%  softirqs.CPU145.NET_RX
  10061416           -26.9%    7351483 ± 15%  softirqs.CPU146.NET_RX
  10109881 ±  2%     -27.3%    7347525 ± 15%  softirqs.CPU147.NET_RX
  10113334 ±  2%     -27.4%    7343130 ± 15%  softirqs.CPU148.NET_RX
  10068577 ±  2%     -27.7%    7283739 ± 15%  softirqs.CPU149.NET_RX
  10053691           -30.9%    6949341 ± 17%  softirqs.CPU15.NET_RX
  10075955 ±  2%     -27.8%    7279008 ± 15%  softirqs.CPU150.NET_RX
  10223408 ±  5%     -28.3%    7328591 ± 15%  softirqs.CPU151.NET_RX
  10106085 ±  2%     -26.9%    7382688 ± 15%  softirqs.CPU152.NET_RX
  10078801 ±  2%     -26.9%    7371962 ± 15%  softirqs.CPU153.NET_RX
  10105167 ±  2%     -27.2%    7360219 ± 15%  softirqs.CPU154.NET_RX
  10018610 ±  2%     -26.9%    7321955 ± 15%  softirqs.CPU155.NET_RX
  10020265 ±  2%     -27.1%    7303252 ± 16%  softirqs.CPU156.NET_RX
  10104966 ±  2%     -27.4%    7335896 ± 15%  softirqs.CPU157.NET_RX
  10078372 ±  2%     -27.0%    7357868 ± 15%  softirqs.CPU158.NET_RX
  10124630 ±  2%     -27.5%    7338490 ± 15%  softirqs.CPU159.NET_RX
  10069101           -31.4%    6907779 ± 17%  softirqs.CPU16.NET_RX
  10074374 ±  2%     -27.1%    7348242 ± 15%  softirqs.CPU160.NET_RX
  10043490 ±  2%     -27.4%    7295676 ± 16%  softirqs.CPU161.NET_RX
  10070364 ±  3%     -27.9%    7265205 ± 15%  softirqs.CPU162.NET_RX
  10062017 ±  3%     -27.2%    7328897 ± 15%  softirqs.CPU163.NET_RX
  10064603           -27.7%    7277705 ± 15%  softirqs.CPU164.NET_RX
  10029210 ±  2%     -27.4%    7279040 ± 15%  softirqs.CPU165.NET_RX
  10035720 ±  3%     -27.5%    7277267 ± 15%  softirqs.CPU166.NET_RX
  10017791 ±  3%     -27.9%    7226422 ± 15%  softirqs.CPU167.NET_RX
   9892425           -32.8%    6650423 ± 15%  softirqs.CPU168.NET_RX
  10045312           -32.3%    6797865 ± 15%  softirqs.CPU169.NET_RX
  10024624           -30.5%    6970483 ± 18%  softirqs.CPU17.NET_RX
  10098246 ±  2%     -32.7%    6799795 ± 15%  softirqs.CPU170.NET_RX
  10091183           -33.0%    6762929 ± 15%  softirqs.CPU171.NET_RX
  10154504 ±  3%     -33.9%    6708947 ± 15%  softirqs.CPU172.NET_RX
  10080207 ±  2%     -33.7%    6684853 ± 14%  softirqs.CPU173.NET_RX
  10020635 ±  2%     -32.6%    6749610 ± 15%  softirqs.CPU174.NET_RX
  10047522           -32.7%    6757495 ± 15%  softirqs.CPU175.NET_RX
  10084647 ±  2%     -32.9%    6768801 ± 15%  softirqs.CPU176.NET_RX
  10072430           -32.9%    6758682 ± 15%  softirqs.CPU177.NET_RX
  10105843 ±  3%     -33.2%    6755418 ± 15%  softirqs.CPU178.NET_RX
   9982514           -32.7%    6720591 ± 14%  softirqs.CPU179.NET_RX
  10039626 ±  2%     -29.5%    7074665 ± 20%  softirqs.CPU18.NET_RX
   9994378           -32.9%    6705741 ± 15%  softirqs.CPU180.NET_RX
  10081700           -33.2%    6730856 ± 14%  softirqs.CPU181.NET_RX
  10046284           -33.0%    6734675 ± 14%  softirqs.CPU182.NET_RX
  10091276 ±  3%     -33.2%    6744658 ± 15%  softirqs.CPU183.NET_RX
   9983550           -32.4%    6750208 ± 15%  softirqs.CPU184.NET_RX
     73219           -12.5%      64037 ±  8%  softirqs.CPU184.SCHED
  10110846 ±  3%     -33.5%    6727803 ± 15%  softirqs.CPU185.NET_RX
  10020237           -32.7%    6738713 ± 15%  softirqs.CPU186.NET_RX
  10060835 ±  3%     -33.1%    6731440 ± 14%  softirqs.CPU187.NET_RX
  10080875 ±  2%     -33.0%    6759013 ± 15%  softirqs.CPU188.NET_RX
  10274947 ±  8%     -34.8%    6694522 ± 14%  softirqs.CPU189.NET_RX
  10025239 ±  2%     -30.5%    6966182 ± 17%  softirqs.CPU19.NET_RX
  10020101 ±  2%     -33.1%    6699231 ± 14%  softirqs.CPU190.NET_RX
   9760427 ±  2%     -34.6%    6382362 ± 14%  softirqs.CPU191.NET_RX
  10072691           -30.7%    6980437 ± 17%  softirqs.CPU2.NET_RX
  10114432 ±  2%     -31.2%    6960177 ± 17%  softirqs.CPU20.NET_RX
  10073217           -30.7%    6976906 ± 18%  softirqs.CPU21.NET_RX
  10048880           -30.0%    7034044 ± 18%  softirqs.CPU23.NET_RX
   9905488           -27.5%    7184688 ± 13%  softirqs.CPU24.NET_RX
  10059912           -27.1%    7338079 ± 14%  softirqs.CPU25.NET_RX
  10073332           -27.5%    7304795 ± 15%  softirqs.CPU26.NET_RX
  10076257           -28.1%    7246655 ± 15%  softirqs.CPU27.NET_RX
  10082942           -26.8%    7379877 ± 17%  softirqs.CPU28.NET_RX
  10050899           -27.7%    7263379 ± 16%  softirqs.CPU29.NET_RX
  10041118           -29.3%    7100348 ± 20%  softirqs.CPU3.NET_RX
  10014284           -28.0%    7209752 ± 14%  softirqs.CPU30.NET_RX
  10064681           -26.6%    7385060 ± 17%  softirqs.CPU31.NET_RX
  10100987           -27.3%    7344170 ± 16%  softirqs.CPU32.NET_RX
  10105051           -26.8%    7393874 ± 16%  softirqs.CPU33.NET_RX
  10090040           -27.9%    7272307 ± 15%  softirqs.CPU34.NET_RX
   9980548 ±  2%     -26.3%    7351830 ± 17%  softirqs.CPU35.NET_RX
  10076549 ±  2%     -26.5%    7405914 ± 16%  softirqs.CPU36.NET_RX
  10126275 ±  2%     -26.1%    7487040 ± 19%  softirqs.CPU37.NET_RX
  10141998 ±  2%     -28.0%    7306017 ± 15%  softirqs.CPU38.NET_RX
  10113154           -27.4%    7345485 ± 16%  softirqs.CPU39.NET_RX
  10111962           -31.7%    6904345 ± 18%  softirqs.CPU4.NET_RX
  10093619           -27.8%    7287927 ± 15%  softirqs.CPU40.NET_RX
  10072397           -27.4%    7314698 ± 16%  softirqs.CPU41.NET_RX
  10067799           -27.2%    7326554 ± 16%  softirqs.CPU42.NET_RX
  10092440 ±  2%     -26.0%    7463769 ± 19%  softirqs.CPU43.NET_RX
  10182592 ±  3%     -27.3%    7404142 ± 17%  softirqs.CPU44.NET_RX
  10064558           -27.5%    7298567 ± 16%  softirqs.CPU46.NET_RX
   9991852           -27.4%    7254731 ± 15%  softirqs.CPU47.NET_RX
   9858553           -26.5%    7242427 ± 15%  softirqs.CPU48.NET_RX
  10002429           -26.6%    7339189 ± 16%  softirqs.CPU49.NET_RX
  10053023           -31.4%    6894942 ± 16%  softirqs.CPU5.NET_RX
  10065927 ±  2%     -27.1%    7342019 ± 15%  softirqs.CPU50.NET_RX
  10082190 ±  2%     -27.2%    7338633 ± 16%  softirqs.CPU51.NET_RX
  10107664 ±  2%     -27.5%    7330395 ± 15%  softirqs.CPU52.NET_RX
  10065018 ±  2%     -27.4%    7311926 ± 15%  softirqs.CPU53.NET_RX
  10012735 ±  2%     -27.3%    7283738 ± 15%  softirqs.CPU54.NET_RX
  10178892 ±  5%     -27.8%    7353844 ± 14%  softirqs.CPU55.NET_RX
  10103580 ±  2%     -26.9%    7384852 ± 15%  softirqs.CPU56.NET_RX
  10073431 ±  2%     -26.9%    7360570 ± 15%  softirqs.CPU57.NET_RX
  10115712 ±  2%     -27.2%    7367915 ± 15%  softirqs.CPU58.NET_RX
  10041211           -26.9%    7336973 ± 15%  softirqs.CPU59.NET_RX
  10015691 ±  2%     -30.7%    6939025 ± 17%  softirqs.CPU6.NET_RX
   9998182 ±  2%     -26.6%    7341640 ± 15%  softirqs.CPU60.NET_RX
  10108059 ±  2%     -27.5%    7330898 ± 15%  softirqs.CPU61.NET_RX
  10082928 ±  2%     -27.1%    7348358 ± 16%  softirqs.CPU62.NET_RX
  10100743 ±  2%     -27.1%    7368320 ± 15%  softirqs.CPU63.NET_RX
  10099783 ±  2%     -27.3%    7346339 ± 16%  softirqs.CPU64.NET_RX
  10022548 ±  2%     -27.0%    7315201 ± 16%  softirqs.CPU65.NET_RX
  10108689 ±  2%     -27.7%    7303707 ± 15%  softirqs.CPU66.NET_RX
  10079291 ±  3%     -27.2%    7333041 ± 16%  softirqs.CPU67.NET_RX
  10059382 ±  2%     -27.3%    7308795 ± 15%  softirqs.CPU68.NET_RX
  10088391 ±  2%     -27.1%    7356629 ± 15%  softirqs.CPU69.NET_RX
  10041514           -28.0%    7225555 ± 21%  softirqs.CPU7.NET_RX
  10046334 ±  3%     -27.1%    7322687 ± 15%  softirqs.CPU70.NET_RX
  10072672 ±  3%     -27.2%    7328357 ± 15%  softirqs.CPU71.NET_RX
   9888770 ±  2%     -33.1%    6611481 ± 15%  softirqs.CPU72.NET_RX
     74577           -13.7%      64379 ±  6%  softirqs.CPU72.SCHED
  10022409           -32.4%    6776525 ± 15%  softirqs.CPU73.NET_RX
  10065888 ±  2%     -32.7%    6773508 ± 15%  softirqs.CPU74.NET_RX
  10062615           -32.9%    6748007 ± 15%  softirqs.CPU75.NET_RX
  10150804 ±  3%     -34.0%    6704414 ± 15%  softirqs.CPU76.NET_RX
  10084714 ±  2%     -33.5%    6702424 ± 14%  softirqs.CPU77.NET_RX
  10029958 ±  2%     -32.7%    6750873 ± 15%  softirqs.CPU78.NET_RX
  10032633           -32.8%    6740672 ± 15%  softirqs.CPU79.NET_RX
  10105216 ±  2%     -29.2%    7154492 ± 20%  softirqs.CPU8.NET_RX
  10065074           -32.6%    6782322 ± 15%  softirqs.CPU80.NET_RX
  10067765           -33.0%    6750045 ± 15%  softirqs.CPU81.NET_RX
  10087190 ±  3%     -32.8%    6778822 ± 15%  softirqs.CPU82.NET_RX
   9995663           -32.9%    6709261 ± 14%  softirqs.CPU83.NET_RX
   9992905           -32.7%    6723146 ± 15%  softirqs.CPU84.NET_RX
  10082270           -33.3%    6726669 ± 14%  softirqs.CPU85.NET_RX
  10065484           -32.8%    6762441 ± 15%  softirqs.CPU86.NET_RX
  10086577 ±  3%     -33.2%    6742547 ± 15%  softirqs.CPU87.NET_RX
  10000647           -32.6%    6735741 ± 15%  softirqs.CPU88.NET_RX
  10114983 ±  3%     -33.4%    6737194 ± 15%  softirqs.CPU89.NET_RX
  10103325           -31.5%    6919292 ± 16%  softirqs.CPU9.NET_RX
  10037273           -32.8%    6748386 ± 15%  softirqs.CPU90.NET_RX
  10091021 ±  3%     -33.3%    6731638 ± 14%  softirqs.CPU91.NET_RX
  10093519 ±  2%     -32.8%    6778222 ± 15%  softirqs.CPU92.NET_RX
  10284999 ±  8%     -34.4%    6745854 ± 15%  softirqs.CPU93.NET_RX
  10043189           -32.6%    6767875 ± 15%  softirqs.CPU94.NET_RX
   9996291 ±  2%     -32.1%    6790144 ± 13%  softirqs.CPU95.NET_RX
   9962894           -30.6%    6915029 ± 16%  softirqs.CPU96.NET_RX
  10092463 ±  2%     -30.7%    6991282 ± 17%  softirqs.CPU97.NET_RX
  10077768           -30.9%    6968609 ± 17%  softirqs.CPU98.NET_RX
  10101239           -29.7%    7096824 ± 20%  softirqs.CPU99.NET_RX
 1.931e+09           -29.3%  1.365e+09 ± 16%  softirqs.NET_RX
      1179 ± 85%    -100.0%       0.00        interrupts.161:PCI-MSI.524289-edge.eth0-TxRx-0
      7636 ±209%    -100.0%       0.00        interrupts.162:PCI-MSI.524290-edge.eth0-TxRx-1
      8411 ±106%    -100.0%       0.00        interrupts.163:PCI-MSI.524291-edge.eth0-TxRx-2
      5919 ±188%    -100.0%       0.00        interrupts.164:PCI-MSI.524292-edge.eth0-TxRx-3
    183711 ± 11%    +463.8%    1035763 ± 20%  interrupts.CPU0.RES:Rescheduling_interrupts
    214569 ± 12%    +394.3%    1060665 ± 19%  interrupts.CPU1.RES:Rescheduling_interrupts
    205359 ± 10%    +417.7%    1063195 ± 19%  interrupts.CPU10.RES:Rescheduling_interrupts
    208516 ±  9%    +411.1%    1065710 ± 20%  interrupts.CPU100.RES:Rescheduling_interrupts
    192211 ±  9%    +448.5%    1054238 ± 19%  interrupts.CPU101.RES:Rescheduling_interrupts
    194848 ±  8%    +442.5%    1057087 ± 19%  interrupts.CPU102.RES:Rescheduling_interrupts
    203159 ± 13%    +411.4%    1038986 ± 17%  interrupts.CPU103.RES:Rescheduling_interrupts
    200256 ± 12%    +423.0%    1047342 ± 18%  interrupts.CPU104.RES:Rescheduling_interrupts
    203041 ± 12%    +421.4%    1058756 ± 19%  interrupts.CPU105.RES:Rescheduling_interrupts
    204183 ± 11%    +419.1%    1059958 ± 19%  interrupts.CPU106.RES:Rescheduling_interrupts
    198487 ± 13%    +418.4%    1029048 ± 17%  interrupts.CPU107.RES:Rescheduling_interrupts
    191276 ± 13%    +452.0%    1055813 ± 19%  interrupts.CPU108.RES:Rescheduling_interrupts
    189509 ± 12%    +447.6%    1037768 ± 18%  interrupts.CPU109.RES:Rescheduling_interrupts
      1179 ± 85%    -100.0%       0.00        interrupts.CPU11.161:PCI-MSI.524289-edge.eth0-TxRx-0
    196785 ±  7%    +424.3%    1031798 ± 18%  interrupts.CPU11.RES:Rescheduling_interrupts
    195563 ± 10%    +445.8%    1067316 ± 19%  interrupts.CPU110.RES:Rescheduling_interrupts
    189590 ± 12%    +463.4%    1068207 ± 19%  interrupts.CPU111.RES:Rescheduling_interrupts
    185652 ± 12%    +468.4%    1055308 ± 19%  interrupts.CPU112.RES:Rescheduling_interrupts
    198201 ± 11%    +434.7%    1059705 ± 19%  interrupts.CPU113.RES:Rescheduling_interrupts
    203866 ± 11%    +409.8%    1039329 ± 19%  interrupts.CPU114.RES:Rescheduling_interrupts
    199363 ± 12%    +431.5%    1059537 ± 19%  interrupts.CPU115.RES:Rescheduling_interrupts
    197784 ± 16%    +433.8%    1055682 ± 18%  interrupts.CPU116.RES:Rescheduling_interrupts
    192092 ± 14%    +449.8%    1056150 ± 19%  interrupts.CPU117.RES:Rescheduling_interrupts
    186504 ± 12%    +445.0%    1016404 ± 18%  interrupts.CPU118.RES:Rescheduling_interrupts
    191109 ± 11%    +446.4%    1044147 ± 19%  interrupts.CPU119.RES:Rescheduling_interrupts
      7636 ±209%    -100.0%       0.00        interrupts.CPU12.162:PCI-MSI.524290-edge.eth0-TxRx-1
    193673 ± 14%    +447.3%    1060022 ± 19%  interrupts.CPU12.RES:Rescheduling_interrupts
    222704 ± 14%    +380.4%    1069979 ± 16%  interrupts.CPU120.RES:Rescheduling_interrupts
    205118 ± 11%    +430.7%    1088584 ± 16%  interrupts.CPU121.RES:Rescheduling_interrupts
    207673 ± 14%    +433.2%    1107299 ± 16%  interrupts.CPU122.RES:Rescheduling_interrupts
    208571 ± 11%    +433.2%    1112049 ± 17%  interrupts.CPU123.RES:Rescheduling_interrupts
    205146 ± 11%    +433.6%    1094593 ± 16%  interrupts.CPU124.RES:Rescheduling_interrupts
    191784 ± 11%    +471.4%    1095924 ± 16%  interrupts.CPU125.RES:Rescheduling_interrupts
    197177 ± 14%    +456.0%    1096391 ± 16%  interrupts.CPU126.RES:Rescheduling_interrupts
    209175 ± 13%    +425.2%    1098671 ± 16%  interrupts.CPU127.RES:Rescheduling_interrupts
    203557 ± 15%    +437.3%    1093722 ± 16%  interrupts.CPU128.RES:Rescheduling_interrupts
    205780 ± 11%    +439.6%    1110462 ± 16%  interrupts.CPU129.RES:Rescheduling_interrupts
      8411 ±106%    -100.0%       0.00        interrupts.CPU13.163:PCI-MSI.524291-edge.eth0-TxRx-2
    192155 ±  9%    +441.5%    1040425 ± 18%  interrupts.CPU13.RES:Rescheduling_interrupts
    200939 ± 12%    +449.7%    1104506 ± 16%  interrupts.CPU130.RES:Rescheduling_interrupts
    199109 ± 12%    +453.6%    1102272 ± 16%  interrupts.CPU131.RES:Rescheduling_interrupts
    205140 ± 11%    +433.3%    1094078 ± 16%  interrupts.CPU132.RES:Rescheduling_interrupts
    207970 ± 13%    +416.5%    1074163 ± 16%  interrupts.CPU133.RES:Rescheduling_interrupts
    207662 ± 11%    +430.1%    1100813 ± 16%  interrupts.CPU134.RES:Rescheduling_interrupts
    208623 ± 13%    +430.4%    1106573 ± 16%  interrupts.CPU135.RES:Rescheduling_interrupts
    210712 ± 14%    +424.0%    1104075 ± 16%  interrupts.CPU136.RES:Rescheduling_interrupts
    202995 ±  9%    +438.6%    1093305 ± 16%  interrupts.CPU137.RES:Rescheduling_interrupts
    208022 ±  9%    +420.2%    1082080 ± 15%  interrupts.CPU138.RES:Rescheduling_interrupts
    206004 ± 14%    +419.2%    1069583 ± 16%  interrupts.CPU139.RES:Rescheduling_interrupts
      5919 ±188%    -100.0%       0.00        interrupts.CPU14.164:PCI-MSI.524292-edge.eth0-TxRx-3
    198316 ±  9%    +438.9%    1068795 ± 19%  interrupts.CPU14.RES:Rescheduling_interrupts
    204581 ± 11%    +434.2%    1092828 ± 16%  interrupts.CPU140.RES:Rescheduling_interrupts
    194734 ± 12%    +413.7%    1000344 ± 22%  interrupts.CPU141.RES:Rescheduling_interrupts
    186037 ± 10%    +481.4%    1081618 ± 16%  interrupts.CPU142.RES:Rescheduling_interrupts
    181293 ± 13%    +494.5%    1077813 ± 16%  interrupts.CPU143.RES:Rescheduling_interrupts
    216600 ± 11%    +404.2%    1092036 ± 18%  interrupts.CPU144.RES:Rescheduling_interrupts
    206558 ±  9%    +436.2%    1107558 ± 18%  interrupts.CPU145.RES:Rescheduling_interrupts
     31410 ±111%     -84.3%       4920 ± 61%  interrupts.CPU146.CAL:Function_call_interrupts
    196111 ± 10%    +469.2%    1116288 ± 18%  interrupts.CPU146.RES:Rescheduling_interrupts
    208249 ± 11%    +435.0%    1114159 ± 19%  interrupts.CPU147.RES:Rescheduling_interrupts
      6010 ± 35%     +42.5%       8563 ±  2%  interrupts.CPU148.NMI:Non-maskable_interrupts
      6010 ± 35%     +42.5%       8563 ±  2%  interrupts.CPU148.PMI:Performance_monitoring_interrupts
    203103 ±  9%    +448.2%    1113470 ± 18%  interrupts.CPU148.RES:Rescheduling_interrupts
      6050 ± 35%     +42.7%       8635        interrupts.CPU149.NMI:Non-maskable_interrupts
      6050 ± 35%     +42.7%       8635        interrupts.CPU149.PMI:Performance_monitoring_interrupts
    198479 ± 14%    +461.8%    1115091 ± 18%  interrupts.CPU149.RES:Rescheduling_interrupts
    200884 ±  9%    +431.2%    1067061 ± 19%  interrupts.CPU15.RES:Rescheduling_interrupts
    201538 ± 13%    +450.0%    1108410 ± 18%  interrupts.CPU150.RES:Rescheduling_interrupts
    198635 ± 16%    +457.0%    1106479 ± 18%  interrupts.CPU151.RES:Rescheduling_interrupts
    206185 ± 10%    +437.5%    1108245 ± 19%  interrupts.CPU152.RES:Rescheduling_interrupts
    190921 ± 13%    +482.8%    1112633 ± 18%  interrupts.CPU153.RES:Rescheduling_interrupts
    199951 ± 16%    +462.7%    1125066 ± 18%  interrupts.CPU154.RES:Rescheduling_interrupts
    198700 ± 14%    +462.5%    1117750 ± 18%  interrupts.CPU155.RES:Rescheduling_interrupts
     33481 ±121%     -81.3%       6272 ± 84%  interrupts.CPU156.CAL:Function_call_interrupts
    206914 ± 12%    +434.6%    1106114 ± 18%  interrupts.CPU156.RES:Rescheduling_interrupts
    205271 ±  9%    +436.3%    1100884 ± 18%  interrupts.CPU157.RES:Rescheduling_interrupts
    205474 ± 12%    +435.3%    1099845 ± 18%  interrupts.CPU158.RES:Rescheduling_interrupts
     36186 ±131%     -85.3%       5325 ± 72%  interrupts.CPU159.CAL:Function_call_interrupts
    204019 ± 16%    +447.2%    1116491 ± 18%  interrupts.CPU159.RES:Rescheduling_interrupts
    191152 ± 11%    +454.9%    1060750 ± 19%  interrupts.CPU16.RES:Rescheduling_interrupts
    190038 ± 11%    +478.0%    1098499 ± 19%  interrupts.CPU160.RES:Rescheduling_interrupts
    191203 ± 14%    +480.4%    1109770 ± 18%  interrupts.CPU161.RES:Rescheduling_interrupts
    200786 ± 14%    +449.3%    1102956 ± 18%  interrupts.CPU162.RES:Rescheduling_interrupts
    201575 ± 14%    +444.8%    1098219 ± 19%  interrupts.CPU163.RES:Rescheduling_interrupts
    191046 ± 11%    +486.5%    1120526 ± 18%  interrupts.CPU164.RES:Rescheduling_interrupts
     33248 ±142%     -83.5%       5476 ± 74%  interrupts.CPU165.CAL:Function_call_interrupts
    189076 ± 10%    +484.3%    1104760 ± 18%  interrupts.CPU165.RES:Rescheduling_interrupts
    185110 ± 13%    +492.9%    1097520 ± 18%  interrupts.CPU166.RES:Rescheduling_interrupts
    179345 ± 10%    +511.2%    1096142 ± 18%  interrupts.CPU167.RES:Rescheduling_interrupts
     15895 ± 94%     -74.5%       4056 ± 40%  interrupts.CPU168.CAL:Function_call_interrupts
    211530 ±  7%    +432.2%    1125757 ± 14%  interrupts.CPU168.RES:Rescheduling_interrupts
     19958 ±122%     -79.8%       4040 ± 40%  interrupts.CPU169.CAL:Function_call_interrupts
    205636 ±  6%    +452.5%    1136234 ± 14%  interrupts.CPU169.RES:Rescheduling_interrupts
    199389 ± 10%    +432.0%    1060789 ± 19%  interrupts.CPU17.RES:Rescheduling_interrupts
     34.44 ±126%     -88.4%       4.00 ± 30%  interrupts.CPU17.TLB:TLB_shootdowns
     30368 ±180%     -86.3%       4166 ± 46%  interrupts.CPU170.CAL:Function_call_interrupts
    203515 ±  6%    +469.4%    1158771 ± 15%  interrupts.CPU170.RES:Rescheduling_interrupts
     21877 ±124%     -80.8%       4192 ± 42%  interrupts.CPU171.CAL:Function_call_interrupts
    211977 ±  6%    +445.4%    1156136 ± 14%  interrupts.CPU171.RES:Rescheduling_interrupts
     19330 ±121%     -76.7%       4496 ± 48%  interrupts.CPU172.CAL:Function_call_interrupts
    213412 ±  5%    +440.0%    1152321 ± 15%  interrupts.CPU172.RES:Rescheduling_interrupts
     21830 ±137%     -80.7%       4207 ± 44%  interrupts.CPU173.CAL:Function_call_interrupts
    203505 ±  8%    +458.3%    1136106 ± 14%  interrupts.CPU173.RES:Rescheduling_interrupts
     21961 ±144%     -80.6%       4249 ± 44%  interrupts.CPU174.CAL:Function_call_interrupts
    201959 ±  9%    +469.7%    1150514 ± 15%  interrupts.CPU174.RES:Rescheduling_interrupts
     25967 ±159%     -83.0%       4412 ± 35%  interrupts.CPU175.CAL:Function_call_interrupts
    205913 ±  7%    +455.6%    1143994 ± 14%  interrupts.CPU175.RES:Rescheduling_interrupts
     20710 ±147%     -79.8%       4179 ± 47%  interrupts.CPU176.CAL:Function_call_interrupts
    187550 ± 10%    +515.4%    1154155 ± 14%  interrupts.CPU176.RES:Rescheduling_interrupts
     15651 ± 96%     -73.7%       4118 ± 43%  interrupts.CPU177.CAL:Function_call_interrupts
    198145 ±  8%    +482.6%    1154405 ± 14%  interrupts.CPU177.RES:Rescheduling_interrupts
     23622 ±154%     -82.4%       4149 ± 41%  interrupts.CPU178.CAL:Function_call_interrupts
    197146 ± 10%    +482.8%    1148911 ± 14%  interrupts.CPU178.RES:Rescheduling_interrupts
     21421 ±123%     -80.6%       4153 ± 46%  interrupts.CPU179.CAL:Function_call_interrupts
    198341 ±  5%    +481.7%    1153821 ± 14%  interrupts.CPU179.RES:Rescheduling_interrupts
    205261 ±  9%    +410.6%    1048028 ± 19%  interrupts.CPU18.RES:Rescheduling_interrupts
     14207 ± 70%     -69.9%       4271 ± 46%  interrupts.CPU180.CAL:Function_call_interrupts
    200931 ±  8%    +470.9%    1147113 ± 14%  interrupts.CPU180.RES:Rescheduling_interrupts
     19819 ±133%     -78.7%       4225 ± 47%  interrupts.CPU181.CAL:Function_call_interrupts
    204375 ±  8%    +458.6%    1141649 ± 14%  interrupts.CPU181.RES:Rescheduling_interrupts
     18339 ±114%     -76.1%       4391 ± 48%  interrupts.CPU182.CAL:Function_call_interrupts
    199187 ±  3%    +473.7%    1142647 ± 14%  interrupts.CPU182.RES:Rescheduling_interrupts
     25537 ±162%     -83.4%       4237 ± 45%  interrupts.CPU183.CAL:Function_call_interrupts
    196201 ± 11%    +491.8%    1161105 ± 14%  interrupts.CPU183.RES:Rescheduling_interrupts
     19636 ±115%     -79.2%       4085 ± 39%  interrupts.CPU184.CAL:Function_call_interrupts
    187489 ±  9%    +514.1%    1151329 ± 14%  interrupts.CPU184.RES:Rescheduling_interrupts
     23677 ±140%     -81.6%       4355 ± 40%  interrupts.CPU185.CAL:Function_call_interrupts
    196721 ±  7%    +487.3%    1155305 ± 15%  interrupts.CPU185.RES:Rescheduling_interrupts
     20054 ±135%     -80.0%       4007 ± 39%  interrupts.CPU186.CAL:Function_call_interrupts
    193472 ±  8%    +494.8%    1150704 ± 14%  interrupts.CPU186.RES:Rescheduling_interrupts
     18953 ±122%     -77.7%       4222 ± 41%  interrupts.CPU187.CAL:Function_call_interrupts
    198988 ±  9%    +481.6%    1157343 ± 14%  interrupts.CPU187.RES:Rescheduling_interrupts
     24557 ±171%     -83.4%       4087 ± 43%  interrupts.CPU188.CAL:Function_call_interrupts
    186299 ±  8%    +520.9%    1156737 ± 14%  interrupts.CPU188.RES:Rescheduling_interrupts
    178562 ±  7%    +539.0%    1141091 ± 15%  interrupts.CPU189.RES:Rescheduling_interrupts
    205716 ± 11%    +420.3%    1070349 ± 19%  interrupts.CPU19.RES:Rescheduling_interrupts
     22098 ±151%     -81.6%       4062 ± 42%  interrupts.CPU190.CAL:Function_call_interrupts
    178637 ± 11%    +541.5%    1145917 ± 14%  interrupts.CPU190.RES:Rescheduling_interrupts
     19427 ±134%     -77.4%       4383 ± 46%  interrupts.CPU191.CAL:Function_call_interrupts
    174493 ±  9%    +509.6%    1063776 ± 15%  interrupts.CPU191.RES:Rescheduling_interrupts
    203036 ±  9%    +428.5%    1073034 ± 19%  interrupts.CPU2.RES:Rescheduling_interrupts
    199252 ±  9%    +433.4%    1062718 ± 19%  interrupts.CPU20.RES:Rescheduling_interrupts
    195878 ±  9%    +442.2%    1062036 ± 19%  interrupts.CPU21.RES:Rescheduling_interrupts
    190273 ±  9%    +439.0%    1025582 ± 18%  interrupts.CPU22.RES:Rescheduling_interrupts
    199754 ±  8%    +427.1%    1052966 ± 19%  interrupts.CPU23.RES:Rescheduling_interrupts
    207185 ±  9%    +414.1%    1065243 ± 16%  interrupts.CPU24.RES:Rescheduling_interrupts
    200476 ±  8%    +442.1%    1086824 ± 16%  interrupts.CPU25.RES:Rescheduling_interrupts
    197385 ± 10%    +461.3%    1107880 ± 16%  interrupts.CPU26.RES:Rescheduling_interrupts
    194339 ±  7%    +459.9%    1088110 ± 15%  interrupts.CPU27.RES:Rescheduling_interrupts
    190029 ± 10%    +475.9%    1094443 ± 16%  interrupts.CPU28.RES:Rescheduling_interrupts
    184345 ±  7%    +491.9%    1091117 ± 16%  interrupts.CPU29.RES:Rescheduling_interrupts
    206712 ±  9%    +406.4%    1046693 ± 18%  interrupts.CPU3.RES:Rescheduling_interrupts
    188400 ±  8%    +480.4%    1093427 ± 16%  interrupts.CPU30.RES:Rescheduling_interrupts
    192929 ±  8%    +466.2%    1092405 ± 16%  interrupts.CPU31.RES:Rescheduling_interrupts
    189482 ± 11%    +477.6%    1094389 ± 16%  interrupts.CPU32.RES:Rescheduling_interrupts
    198521 ± 10%    +457.6%    1107028 ± 16%  interrupts.CPU33.RES:Rescheduling_interrupts
    194475 ± 10%    +468.5%    1105678 ± 16%  interrupts.CPU34.RES:Rescheduling_interrupts
    194196 ± 10%    +472.2%    1111189 ± 16%  interrupts.CPU35.RES:Rescheduling_interrupts
    194721 ±  9%    +461.8%    1094038 ± 16%  interrupts.CPU36.RES:Rescheduling_interrupts
    202194 ± 11%    +410.8%    1032805 ± 16%  interrupts.CPU37.RES:Rescheduling_interrupts
    207136 ±  7%    +433.8%    1105619 ± 16%  interrupts.CPU38.RES:Rescheduling_interrupts
    200302 ±  9%    +453.1%    1107781 ± 16%  interrupts.CPU39.RES:Rescheduling_interrupts
    207930 ±  9%    +407.6%    1055544 ± 20%  interrupts.CPU4.RES:Rescheduling_interrupts
    210776 ± 13%    +425.9%    1108554 ± 16%  interrupts.CPU40.RES:Rescheduling_interrupts
    208079 ± 10%    +430.8%    1104489 ± 16%  interrupts.CPU41.RES:Rescheduling_interrupts
    211581 ± 11%    +411.3%    1081808 ± 16%  interrupts.CPU42.RES:Rescheduling_interrupts
    213523 ± 14%    +404.0%    1076127 ± 16%  interrupts.CPU43.RES:Rescheduling_interrupts
    204667 ± 11%    +429.5%    1083695 ± 16%  interrupts.CPU44.RES:Rescheduling_interrupts
    197804 ± 11%    +410.0%    1008776 ± 21%  interrupts.CPU45.RES:Rescheduling_interrupts
    106.89 ±232%     -97.0%       3.25 ± 88%  interrupts.CPU45.TLB:TLB_shootdowns
    195293 ± 10%    +460.4%    1094418 ± 16%  interrupts.CPU46.RES:Rescheduling_interrupts
    188306 ± 13%    +480.6%    1093235 ± 16%  interrupts.CPU47.RES:Rescheduling_interrupts
     24432 ± 96%     -75.0%       6109 ± 89%  interrupts.CPU48.CAL:Function_call_interrupts
    209339 ±  9%    +416.6%    1081517 ± 18%  interrupts.CPU48.RES:Rescheduling_interrupts
    192152 ±  6%    +473.2%    1101467 ± 18%  interrupts.CPU49.RES:Rescheduling_interrupts
    198907 ± 11%    +428.9%    1051941 ± 19%  interrupts.CPU5.RES:Rescheduling_interrupts
     32746 ±123%     -88.1%       3892 ± 36%  interrupts.CPU50.CAL:Function_call_interrupts
    186397 ±  5%    +499.2%    1116983 ± 18%  interrupts.CPU50.RES:Rescheduling_interrupts
    194978 ± 10%    +468.6%    1108631 ± 19%  interrupts.CPU51.RES:Rescheduling_interrupts
    194279 ±  7%    +472.9%    1113056 ± 18%  interrupts.CPU52.RES:Rescheduling_interrupts
    192472 ± 13%    +478.9%    1114186 ± 18%  interrupts.CPU53.RES:Rescheduling_interrupts
     26810 ± 97%     -78.4%       5794 ± 75%  interrupts.CPU54.CAL:Function_call_interrupts
    202383 ±  8%    +447.1%    1107272 ± 18%  interrupts.CPU54.RES:Rescheduling_interrupts
    193533 ± 10%    +471.7%    1106334 ± 18%  interrupts.CPU55.RES:Rescheduling_interrupts
    204595 ± 12%    +442.0%    1108971 ± 18%  interrupts.CPU56.RES:Rescheduling_interrupts
    189183 ± 10%    +489.1%    1114559 ± 18%  interrupts.CPU57.RES:Rescheduling_interrupts
    198880 ± 10%    +465.4%    1124413 ± 18%  interrupts.CPU58.RES:Rescheduling_interrupts
     31343 ±133%     -82.0%       5649 ± 73%  interrupts.CPU59.CAL:Function_call_interrupts
    189762 ± 12%    +490.6%    1120777 ± 18%  interrupts.CPU59.RES:Rescheduling_interrupts
    196204 ± 11%    +438.6%    1056809 ± 19%  interrupts.CPU6.RES:Rescheduling_interrupts
    200202 ±  8%    +454.7%    1110442 ± 18%  interrupts.CPU60.RES:Rescheduling_interrupts
    201638 ±  8%    +427.7%    1063980 ± 18%  interrupts.CPU61.RES:Rescheduling_interrupts
     36599 ±126%     -85.4%       5350 ± 67%  interrupts.CPU62.CAL:Function_call_interrupts
    208768 ± 10%    +429.1%    1104540 ± 18%  interrupts.CPU62.RES:Rescheduling_interrupts
    203591 ± 14%    +450.5%    1120742 ± 18%  interrupts.CPU63.RES:Rescheduling_interrupts
    195363 ± 10%    +466.2%    1106087 ± 18%  interrupts.CPU64.RES:Rescheduling_interrupts
     30876 ±121%     -82.5%       5414 ± 63%  interrupts.CPU65.CAL:Function_call_interrupts
    199229 ± 11%    +462.8%    1121254 ± 18%  interrupts.CPU65.RES:Rescheduling_interrupts
    203576 ± 10%    +446.2%    1111947 ± 18%  interrupts.CPU66.RES:Rescheduling_interrupts
    202361 ± 14%    +444.5%    1101943 ± 18%  interrupts.CPU67.RES:Rescheduling_interrupts
    201385 ±  9%    +451.1%    1109781 ± 18%  interrupts.CPU68.RES:Rescheduling_interrupts
    200203 ±  9%    +454.9%    1110899 ± 18%  interrupts.CPU69.RES:Rescheduling_interrupts
    202975 ± 11%    +413.2%    1041696 ± 17%  interrupts.CPU7.RES:Rescheduling_interrupts
    193875 ± 10%    +469.1%    1103348 ± 18%  interrupts.CPU70.RES:Rescheduling_interrupts
    192804 ±  9%    +470.0%    1099025 ± 17%  interrupts.CPU71.RES:Rescheduling_interrupts
     17372 ±129%     -76.9%       4007 ± 38%  interrupts.CPU72.CAL:Function_call_interrupts
    192877 ±  8%    +479.8%    1118324 ± 14%  interrupts.CPU72.RES:Rescheduling_interrupts
     18852 ±114%     -79.1%       3934 ± 39%  interrupts.CPU73.CAL:Function_call_interrupts
    194244 ± 10%    +487.1%    1140315 ± 15%  interrupts.CPU73.RES:Rescheduling_interrupts
     18032 ±123%     -77.4%       4070 ± 39%  interrupts.CPU74.CAL:Function_call_interrupts
    189923 ±  5%    +504.9%    1148910 ± 14%  interrupts.CPU74.RES:Rescheduling_interrupts
     15470 ± 95%     -72.6%       4244 ± 42%  interrupts.CPU75.CAL:Function_call_interrupts
    196358 ± 10%    +486.7%    1152130 ± 14%  interrupts.CPU75.RES:Rescheduling_interrupts
    196639 ±  8%    +485.5%    1151330 ± 14%  interrupts.CPU76.RES:Rescheduling_interrupts
     23314 ±153%     -80.2%       4625 ± 46%  interrupts.CPU77.CAL:Function_call_interrupts
    190315 ± 12%    +462.9%    1071223 ± 14%  interrupts.CPU77.RES:Rescheduling_interrupts
     20306 ±138%     -78.1%       4449 ± 41%  interrupts.CPU78.CAL:Function_call_interrupts
    189243 ±  7%    +509.6%    1153632 ± 15%  interrupts.CPU78.RES:Rescheduling_interrupts
     16695 ± 68%     -75.8%       4038 ± 43%  interrupts.CPU79.CAL:Function_call_interrupts
    195625 ±  9%    +478.3%    1131268 ± 16%  interrupts.CPU79.RES:Rescheduling_interrupts
    203243 ± 10%    +415.6%    1047904 ± 18%  interrupts.CPU8.RES:Rescheduling_interrupts
     17266 ± 92%     -76.3%       4100 ± 44%  interrupts.CPU80.CAL:Function_call_interrupts
    184337 ±  7%    +526.6%    1155038 ± 14%  interrupts.CPU80.RES:Rescheduling_interrupts
     14758 ± 74%     -71.4%       4218 ± 45%  interrupts.CPU81.CAL:Function_call_interrupts
    191225 ±  9%    +503.2%    1153553 ± 14%  interrupts.CPU81.RES:Rescheduling_interrupts
     20026 ±131%     -79.1%       4181 ± 36%  interrupts.CPU82.CAL:Function_call_interrupts
    192513 ± 12%    +495.1%    1145557 ± 14%  interrupts.CPU82.RES:Rescheduling_interrupts
     22962 ±116%     -81.2%       4320 ± 47%  interrupts.CPU83.CAL:Function_call_interrupts
    193517 ±  9%    +493.7%    1148867 ± 14%  interrupts.CPU83.RES:Rescheduling_interrupts
    195756 ± 10%    +482.7%    1140633 ± 14%  interrupts.CPU84.RES:Rescheduling_interrupts
     19845 ±131%     -78.5%       4275 ± 45%  interrupts.CPU85.CAL:Function_call_interrupts
    207758 ±  9%    +447.5%    1137462 ± 14%  interrupts.CPU85.RES:Rescheduling_interrupts
    200239 ±  7%    +470.8%    1142950 ± 14%  interrupts.CPU86.RES:Rescheduling_interrupts
     23190 ±151%     -81.9%       4193 ± 43%  interrupts.CPU87.CAL:Function_call_interrupts
    195480 ± 13%    +492.0%    1157158 ± 14%  interrupts.CPU87.RES:Rescheduling_interrupts
     16073 ± 90%     -74.4%       4112 ± 44%  interrupts.CPU88.CAL:Function_call_interrupts
    192317 ± 10%    +499.8%    1153466 ± 14%  interrupts.CPU88.RES:Rescheduling_interrupts
     24243 ±148%     -82.0%       4374 ± 42%  interrupts.CPU89.CAL:Function_call_interrupts
    206645 ±  6%    +460.7%    1158657 ± 15%  interrupts.CPU89.RES:Rescheduling_interrupts
    203441 ±  8%    +420.1%    1058131 ± 19%  interrupts.CPU9.RES:Rescheduling_interrupts
     23141 ±152%     -82.6%       4028 ± 43%  interrupts.CPU90.CAL:Function_call_interrupts
    202101 ±  6%    +465.4%    1142621 ± 14%  interrupts.CPU90.RES:Rescheduling_interrupts
     19906 ±116%     -78.4%       4293 ± 47%  interrupts.CPU91.CAL:Function_call_interrupts
    212157 ±  7%    +440.2%    1146093 ± 14%  interrupts.CPU91.RES:Rescheduling_interrupts
     26218 ±142%     -83.8%       4238 ± 44%  interrupts.CPU92.CAL:Function_call_interrupts
    195027 ±  8%    +493.5%    1157521 ± 14%  interrupts.CPU92.RES:Rescheduling_interrupts
     24463 ±159%     -83.0%       4147 ± 45%  interrupts.CPU93.CAL:Function_call_interrupts
    189365 ±  3%    +506.9%    1149315 ± 15%  interrupts.CPU93.RES:Rescheduling_interrupts
     19381 ±117%     -76.0%       4647 ± 62%  interrupts.CPU94.CAL:Function_call_interrupts
    194038 ±  8%    +494.1%    1152802 ± 14%  interrupts.CPU94.RES:Rescheduling_interrupts
     17859 ±116%     -77.5%       4016 ± 43%  interrupts.CPU95.CAL:Function_call_interrupts
    187560 ±  7%    +479.6%    1087163 ± 16%  interrupts.CPU95.RES:Rescheduling_interrupts
    180972 ± 11%    +473.7%    1038195 ± 19%  interrupts.CPU96.RES:Rescheduling_interrupts
    214277 ±  8%    +395.9%    1062672 ± 19%  interrupts.CPU97.RES:Rescheduling_interrupts
    208440 ± 11%    +415.3%    1074097 ± 19%  interrupts.CPU98.RES:Rescheduling_interrupts
    209626 ±  8%    +403.2%    1054865 ± 18%  interrupts.CPU99.RES:Rescheduling_interrupts
  38124911 ±  6%    +453.2%  2.109e+08 ± 16%  interrupts.RES:Rescheduling_interrupts
     29.66           -17.6       12.08 ± 17%  perf-profile.calltrace.cycles-pp.intel_idle.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry
     34.14            -6.6       27.56 ±  4%  perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry.start_secondary
     34.20            -6.4       27.83 ±  3%  perf-profile.calltrace.cycles-pp.cpuidle_enter.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     52.20            -5.2       47.00        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe
     51.04            -4.8       46.26        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe
     13.92            -3.0       10.93 ±  5%  perf-profile.calltrace.cycles-pp.udp_recvmsg.inet_recvmsg.__sys_recvfrom.__x64_sys_recvfrom.do_syscall_64
     10.27            -2.9        7.40 ±  8%  perf-profile.calltrace.cycles-pp.__skb_recv_udp.udp_recvmsg.inet_recvmsg.__sys_recvfrom.__x64_sys_recvfrom
     14.03            -2.9       11.17 ±  5%  perf-profile.calltrace.cycles-pp.inet_recvmsg.__sys_recvfrom.__x64_sys_recvfrom.do_syscall_64.entry_SYSCALL_64_after_hwframe
     15.56            -2.7       12.82 ±  4%  perf-profile.calltrace.cycles-pp.__x64_sys_recvfrom.do_syscall_64.entry_SYSCALL_64_after_hwframe
     15.44            -2.7       12.72 ±  4%  perf-profile.calltrace.cycles-pp.__sys_recvfrom.__x64_sys_recvfrom.do_syscall_64.entry_SYSCALL_64_after_hwframe
      8.31 ±  2%      -2.7        5.63 ±  9%  perf-profile.calltrace.cycles-pp.__udp_enqueue_schedule_skb.udp_queue_rcv_one_skb.udp_unicast_rcv_skb.__udp4_lib_rcv.ip_protocol_deliver_rcu
      9.38 ±  2%      -2.7        6.70 ±  7%  perf-profile.calltrace.cycles-pp.udp_unicast_rcv_skb.__udp4_lib_rcv.ip_protocol_deliver_rcu.ip_local_deliver_finish.ip_local_deliver
      9.20 ±  2%      -2.6        6.58 ±  7%  perf-profile.calltrace.cycles-pp.udp_queue_rcv_one_skb.udp_unicast_rcv_skb.__udp4_lib_rcv.ip_protocol_deliver_rcu.ip_local_deliver_finish
     10.16 ±  2%      -2.6        7.60 ±  5%  perf-profile.calltrace.cycles-pp.__udp4_lib_rcv.ip_protocol_deliver_rcu.ip_local_deliver_finish.ip_local_deliver.ip_rcv
      7.72 ±  2%      -2.5        5.22 ±  9%  perf-profile.calltrace.cycles-pp.sock_def_readable.__udp_enqueue_schedule_skb.udp_queue_rcv_one_skb.udp_unicast_rcv_skb.__udp4_lib_rcv
     10.36 ±  2%      -2.5        7.86 ±  5%  perf-profile.calltrace.cycles-pp.ip_protocol_deliver_rcu.ip_local_deliver_finish.ip_local_deliver.ip_rcv.__netif_receive_skb_one_core
     10.40 ±  2%      -2.4        7.97 ±  5%  perf-profile.calltrace.cycles-pp.ip_local_deliver_finish.ip_local_deliver.ip_rcv.__netif_receive_skb_one_core.process_backlog
     13.53            -2.4       11.14 ±  2%  perf-profile.calltrace.cycles-pp.__softirqentry_text_start.asm_call_sysvec_on_stack.do_softirq_own_stack.do_softirq.__local_bh_enable_ip
     18.09            -2.4       15.71        perf-profile.calltrace.cycles-pp.ip_output.ip_send_skb.udp_send_skb.udp_sendmsg.sock_sendmsg
     10.51 ±  2%      -2.4        8.16 ±  5%  perf-profile.calltrace.cycles-pp.ip_local_deliver.ip_rcv.__netif_receive_skb_one_core.process_backlog.net_rx_action
     13.77            -2.3       11.43 ±  2%  perf-profile.calltrace.cycles-pp.do_softirq_own_stack.do_softirq.__local_bh_enable_ip.ip_finish_output2.ip_output
     14.10            -2.3       11.75 ±  2%  perf-profile.calltrace.cycles-pp.do_softirq.__local_bh_enable_ip.ip_finish_output2.ip_output.ip_send_skb
     12.60            -2.3       10.25 ±  2%  perf-profile.calltrace.cycles-pp.net_rx_action.__softirqentry_text_start.asm_call_sysvec_on_stack.do_softirq_own_stack.do_softirq
     13.66            -2.3       11.31 ±  2%  perf-profile.calltrace.cycles-pp.asm_call_sysvec_on_stack.do_softirq_own_stack.do_softirq.__local_bh_enable_ip.ip_finish_output2
     14.18            -2.3       11.85 ±  2%  perf-profile.calltrace.cycles-pp.__local_bh_enable_ip.ip_finish_output2.ip_output.ip_send_skb.udp_send_skb
     18.36            -2.3       16.04        perf-profile.calltrace.cycles-pp.ip_send_skb.udp_send_skb.udp_sendmsg.sock_sendmsg.__sys_sendto
     10.98            -2.3        8.66 ±  4%  perf-profile.calltrace.cycles-pp.ip_rcv.__netif_receive_skb_one_core.process_backlog.net_rx_action.__softirqentry_text_start
      7.38 ±  2%      -2.3        5.07 ±  9%  perf-profile.calltrace.cycles-pp.__wake_up_common_lock.sock_def_readable.__udp_enqueue_schedule_skb.udp_queue_rcv_one_skb.udp_unicast_rcv_skb
     18.66            -2.3       16.37        perf-profile.calltrace.cycles-pp.udp_send_skb.udp_sendmsg.sock_sendmsg.__sys_sendto.__x64_sys_sendto
     17.01            -2.2       14.77        perf-profile.calltrace.cycles-pp.ip_finish_output2.ip_output.ip_send_skb.udp_send_skb.udp_sendmsg
     12.17            -2.2        9.93 ±  2%  perf-profile.calltrace.cycles-pp.process_backlog.net_rx_action.__softirqentry_text_start.asm_call_sysvec_on_stack.do_softirq_own_stack
     11.58            -2.2        9.38 ±  2%  perf-profile.calltrace.cycles-pp.__netif_receive_skb_one_core.process_backlog.net_rx_action.__softirqentry_text_start.asm_call_sysvec_on_stack
     34.07 ±  2%      -2.1       32.01        perf-profile.calltrace.cycles-pp.sock_sendmsg.__sys_sendto.__x64_sys_sendto.do_syscall_64.entry_SYSCALL_64_after_hwframe
      6.85 ±  2%      -2.1        4.79 ±  8%  perf-profile.calltrace.cycles-pp.__wake_up_common.__wake_up_common_lock.sock_def_readable.__udp_enqueue_schedule_skb.udp_queue_rcv_one_skb
     35.12 ±  2%      -2.0       33.08        perf-profile.calltrace.cycles-pp.__x64_sys_sendto.do_syscall_64.entry_SYSCALL_64_after_hwframe
      6.58 ±  2%      -2.0        4.54 ±  9%  perf-profile.calltrace.cycles-pp.try_to_wake_up.autoremove_wake_function.__wake_up_common.__wake_up_common_lock.sock_def_readable
      8.38            -2.0        6.36 ±  6%  perf-profile.calltrace.cycles-pp.__skb_wait_for_more_packets.__skb_recv_udp.udp_recvmsg.inet_recvmsg.__sys_recvfrom
     34.97 ±  2%      -2.0       32.97        perf-profile.calltrace.cycles-pp.__sys_sendto.__x64_sys_sendto.do_syscall_64.entry_SYSCALL_64_after_hwframe
      6.67 ±  2%      -2.0        4.68 ±  8%  perf-profile.calltrace.cycles-pp.autoremove_wake_function.__wake_up_common.__wake_up_common_lock.sock_def_readable.__udp_enqueue_schedule_skb
     33.50 ±  2%      -2.0       31.52        perf-profile.calltrace.cycles-pp.udp_sendmsg.sock_sendmsg.__sys_sendto.__x64_sys_sendto.do_syscall_64
      4.70            -1.7        3.02 ± 11%  perf-profile.calltrace.cycles-pp.schedule_idle.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      4.54            -1.7        2.87 ± 12%  perf-profile.calltrace.cycles-pp.__schedule.schedule_idle.do_idle.cpu_startup_entry.start_secondary
      7.19            -1.5        5.70 ±  5%  perf-profile.calltrace.cycles-pp.schedule_timeout.__skb_wait_for_more_packets.__skb_recv_udp.udp_recvmsg.inet_recvmsg
      7.04            -1.5        5.56 ±  5%  perf-profile.calltrace.cycles-pp.schedule.schedule_timeout.__skb_wait_for_more_packets.__skb_recv_udp.udp_recvmsg
      6.59            -1.3        5.32 ±  5%  perf-profile.calltrace.cycles-pp.__schedule.schedule.schedule_timeout.__skb_wait_for_more_packets.__skb_recv_udp
      3.42 ±  2%      -1.2        2.26 ± 10%  perf-profile.calltrace.cycles-pp.enqueue_task_fair.ttwu_do_activate.try_to_wake_up.autoremove_wake_function.__wake_up_common
      3.47 ±  2%      -1.1        2.38 ± 10%  perf-profile.calltrace.cycles-pp.ttwu_do_activate.try_to_wake_up.autoremove_wake_function.__wake_up_common.__wake_up_common_lock
      2.86 ±  2%      -1.0        1.89 ± 11%  perf-profile.calltrace.cycles-pp.enqueue_entity.enqueue_task_fair.ttwu_do_activate.try_to_wake_up.autoremove_wake_function
      2.24            -0.8        1.46 ± 11%  perf-profile.calltrace.cycles-pp.pick_next_task_fair.__schedule.schedule_idle.do_idle.cpu_startup_entry
      3.41            -0.7        2.69 ±  7%  perf-profile.calltrace.cycles-pp.dequeue_task_fair.__schedule.schedule.schedule_timeout.__skb_wait_for_more_packets
      1.64            -0.7        0.97 ± 13%  perf-profile.calltrace.cycles-pp.set_next_entity.pick_next_task_fair.__schedule.schedule_idle.do_idle
      1.01 ±  2%      -0.6        0.44 ± 60%  perf-profile.calltrace.cycles-pp.update_load_avg.enqueue_entity.enqueue_task_fair.ttwu_do_activate.try_to_wake_up
      2.92 ±  2%      -0.6        2.35 ±  6%  perf-profile.calltrace.cycles-pp.dequeue_entity.dequeue_task_fair.__schedule.schedule.schedule_timeout
      0.84            -0.4        0.41 ± 58%  perf-profile.calltrace.cycles-pp.update_load_avg.set_next_entity.pick_next_task_fair.__schedule.schedule_idle
      2.30            -0.4        1.94 ±  2%  perf-profile.calltrace.cycles-pp.sock_alloc_send_pskb.__ip_append_data.ip_make_skb.udp_sendmsg.sock_sendmsg
      1.66            -0.3        1.31 ±  2%  perf-profile.calltrace.cycles-pp.__alloc_skb.alloc_skb_with_frags.sock_alloc_send_pskb.__ip_append_data.ip_make_skb
      0.73            -0.3        0.40 ± 58%  perf-profile.calltrace.cycles-pp._copy_to_iter.udp_recvmsg.inet_recvmsg.__sys_recvfrom.__x64_sys_recvfrom
      3.57            -0.3        3.26        perf-profile.calltrace.cycles-pp.__ip_append_data.ip_make_skb.udp_sendmsg.sock_sendmsg.__sys_sendto
      0.93            -0.3        0.65 ± 10%  perf-profile.calltrace.cycles-pp.update_load_avg.dequeue_entity.dequeue_task_fair.__schedule.schedule
      1.18 ±  2%      -0.2        0.96 ±  4%  perf-profile.calltrace.cycles-pp.update_curr.dequeue_entity.dequeue_task_fair.__schedule.schedule
      0.61 ±  2%      -0.2        0.41 ± 58%  perf-profile.calltrace.cycles-pp.get_next_timer_interrupt.tick_nohz_next_event.tick_nohz_get_sleep_length.menu_select.do_idle
      1.74            -0.2        1.54        perf-profile.calltrace.cycles-pp.alloc_skb_with_frags.sock_alloc_send_pskb.__ip_append_data.ip_make_skb.udp_sendmsg
      0.86            -0.2        0.69 ±  6%  perf-profile.calltrace.cycles-pp.tick_nohz_idle_exit.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      1.63            -0.2        1.47 ±  3%  perf-profile.calltrace.cycles-pp.tick_nohz_get_sleep_length.menu_select.do_idle.cpu_startup_entry.start_secondary
      0.95 ±  2%      -0.2        0.80        perf-profile.calltrace.cycles-pp.select_task_rq_fair.try_to_wake_up.autoremove_wake_function.__wake_up_common.__wake_up_common_lock
      0.96 ±  2%      -0.1        0.81 ±  3%  perf-profile.calltrace.cycles-pp.__consume_stateless_skb.udp_recvmsg.inet_recvmsg.__sys_recvfrom.__x64_sys_recvfrom
      1.10            -0.1        1.01 ±  2%  perf-profile.calltrace.cycles-pp.tick_nohz_next_event.tick_nohz_get_sleep_length.menu_select.do_idle.cpu_startup_entry
      1.46 ±  2%      -0.1        1.37        perf-profile.calltrace.cycles-pp.loopback_xmit.dev_hard_start_xmit.__dev_queue_xmit.ip_finish_output2.ip_output
      0.61 ±  5%      -0.1        0.56 ±  4%  perf-profile.calltrace.cycles-pp.fib_table_lookup.ip_route_output_key_hash_rcu.ip_route_output_key_hash.ip_route_output_flow.udp_sendmsg
      0.52            +0.0        0.56        perf-profile.calltrace.cycles-pp.tick_nohz_idle_enter.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      0.57 ±  2%      +0.1        0.65 ±  4%  perf-profile.calltrace.cycles-pp.__kmalloc_reserve.__alloc_skb.alloc_skb_with_frags.sock_alloc_send_pskb.__ip_append_data
      0.53 ±  3%      +0.2        0.70 ±  8%  perf-profile.calltrace.cycles-pp.netif_rx.loopback_xmit.dev_hard_start_xmit.__dev_queue_xmit.ip_finish_output2
      0.42 ± 53%      +0.3        0.67 ±  8%  perf-profile.calltrace.cycles-pp.netif_rx_internal.netif_rx.loopback_xmit.dev_hard_start_xmit.__dev_queue_xmit
      1.12 ±  2%      +0.3        1.42 ± 14%  perf-profile.calltrace.cycles-pp.ip_route_output_key_hash_rcu.ip_route_output_key_hash.ip_route_output_flow.udp_sendmsg.sock_sendmsg
      1.26 ±  2%      +0.3        1.56 ± 12%  perf-profile.calltrace.cycles-pp.ip_route_output_key_hash.ip_route_output_flow.udp_sendmsg.sock_sendmsg.__sys_sendto
      0.17 ±141%      +0.4        0.54 ±  3%  perf-profile.calltrace.cycles-pp.__udp4_lib_lookup.__udp4_lib_rcv.ip_protocol_deliver_rcu.ip_local_deliver_finish.ip_local_deliver
      1.29 ±  2%      +0.4        1.68 ± 13%  perf-profile.calltrace.cycles-pp.ip_route_output_flow.udp_sendmsg.sock_sendmsg.__sys_sendto.__x64_sys_sendto
      0.00            +0.7        0.75 ±  5%  perf-profile.calltrace.cycles-pp.rcu_dynticks_eqs_enter.rcu_eqs_enter.cpuidle_enter_state.cpuidle_enter.do_idle
      0.00            +0.8        0.82 ±  5%  perf-profile.calltrace.cycles-pp.rcu_eqs_enter.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry
      2.98 ± 10%      +3.8        6.78 ±  5%  perf-profile.calltrace.cycles-pp.poll_idle.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry
     45.24            +5.0       50.29        perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     45.32            +5.1       50.38        perf-profile.calltrace.cycles-pp.start_secondary.secondary_startup_64_no_verify
     45.30            +5.1       50.37        perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     45.57            +5.1       50.67        perf-profile.calltrace.cycles-pp.secondary_startup_64_no_verify
      3.46 ±  6%     +13.5       17.01 ± 13%  perf-profile.calltrace.cycles-pp.menu_select.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     29.83           -17.7       12.17 ± 17%  perf-profile.children.cycles-pp.intel_idle
     34.37            -6.4       27.98 ±  3%  perf-profile.children.cycles-pp.cpuidle_enter_state
     34.39            -6.4       28.01 ±  3%  perf-profile.children.cycles-pp.cpuidle_enter
     52.24            -5.2       47.03        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     51.07            -4.8       46.29        perf-profile.children.cycles-pp.do_syscall_64
     11.30            -3.0        8.31 ±  7%  perf-profile.children.cycles-pp.__schedule
     13.93            -3.0       10.95 ±  5%  perf-profile.children.cycles-pp.udp_recvmsg
     10.29            -2.9        7.44 ±  8%  perf-profile.children.cycles-pp.__skb_recv_udp
     14.03            -2.8       11.19 ±  5%  perf-profile.children.cycles-pp.inet_recvmsg
     15.58            -2.7       12.83 ±  4%  perf-profile.children.cycles-pp.__x64_sys_recvfrom
     15.46            -2.7       12.74 ±  4%  perf-profile.children.cycles-pp.__sys_recvfrom
      8.32 ±  2%      -2.7        5.63 ±  9%  perf-profile.children.cycles-pp.__udp_enqueue_schedule_skb
      9.39 ±  2%      -2.7        6.71 ±  7%  perf-profile.children.cycles-pp.udp_unicast_rcv_skb
      9.22 ±  2%      -2.6        6.61 ±  7%  perf-profile.children.cycles-pp.udp_queue_rcv_one_skb
     10.17 ±  2%      -2.6        7.62 ±  5%  perf-profile.children.cycles-pp.__udp4_lib_rcv
      7.73 ±  2%      -2.5        5.22 ±  9%  perf-profile.children.cycles-pp.sock_def_readable
     10.37 ±  2%      -2.5        7.88 ±  5%  perf-profile.children.cycles-pp.ip_protocol_deliver_rcu
     10.40 ±  2%      -2.4        7.98 ±  5%  perf-profile.children.cycles-pp.ip_local_deliver_finish
     18.11            -2.4       15.71        perf-profile.children.cycles-pp.ip_output
     14.29            -2.4       11.90 ±  2%  perf-profile.children.cycles-pp.asm_call_sysvec_on_stack
     10.52 ±  2%      -2.4        8.16 ±  5%  perf-profile.children.cycles-pp.ip_local_deliver
     13.66            -2.3       11.32 ±  2%  perf-profile.children.cycles-pp.__softirqentry_text_start
     14.11            -2.3       11.77 ±  2%  perf-profile.children.cycles-pp.do_softirq
     18.37            -2.3       16.04        perf-profile.children.cycles-pp.ip_send_skb
     10.99            -2.3        8.68 ±  4%  perf-profile.children.cycles-pp.ip_rcv
      7.38 ±  2%      -2.3        5.07 ±  8%  perf-profile.children.cycles-pp.__wake_up_common_lock
     13.90            -2.3       11.60 ±  2%  perf-profile.children.cycles-pp.do_softirq_own_stack
     12.61            -2.3       10.31 ±  2%  perf-profile.children.cycles-pp.net_rx_action
     14.32            -2.3       12.03 ±  2%  perf-profile.children.cycles-pp.__local_bh_enable_ip
     18.66            -2.3       16.38        perf-profile.children.cycles-pp.udp_send_skb
     17.01            -2.2       14.78        perf-profile.children.cycles-pp.ip_finish_output2
     12.18            -2.2        9.95 ±  2%  perf-profile.children.cycles-pp.process_backlog
     11.59            -2.2        9.38 ±  2%  perf-profile.children.cycles-pp.__netif_receive_skb_one_core
     34.08 ±  2%      -2.1       32.01        perf-profile.children.cycles-pp.sock_sendmsg
      6.85 ±  2%      -2.1        4.79 ±  8%  perf-profile.children.cycles-pp.__wake_up_common
     35.15 ±  2%      -2.1       33.10        perf-profile.children.cycles-pp.__x64_sys_sendto
      6.59 ±  2%      -2.0        4.56 ±  9%  perf-profile.children.cycles-pp.try_to_wake_up
      8.39            -2.0        6.36 ±  6%  perf-profile.children.cycles-pp.__skb_wait_for_more_packets
     34.98 ±  2%      -2.0       32.98        perf-profile.children.cycles-pp.__sys_sendto
     33.54 ±  2%      -2.0       31.54        perf-profile.children.cycles-pp.udp_sendmsg
      6.68 ±  2%      -2.0        4.68 ±  8%  perf-profile.children.cycles-pp.autoremove_wake_function
      4.74            -1.7        3.04 ± 11%  perf-profile.children.cycles-pp.schedule_idle
      7.20            -1.5        5.70 ±  5%  perf-profile.children.cycles-pp.schedule_timeout
      7.05            -1.5        5.57 ±  5%  perf-profile.children.cycles-pp.schedule
      3.43 ±  2%      -1.2        2.27 ± 10%  perf-profile.children.cycles-pp.enqueue_task_fair
      3.47 ±  2%      -1.1        2.38 ± 10%  perf-profile.children.cycles-pp.ttwu_do_activate
      2.88            -1.1        1.80 ± 13%  perf-profile.children.cycles-pp.update_load_avg
      2.89 ±  2%      -1.0        1.92 ± 11%  perf-profile.children.cycles-pp.enqueue_entity
      1.69 ±  2%      -0.8        0.89 ± 21%  perf-profile.children.cycles-pp._raw_spin_lock
      1.59 ±  2%      -0.8        0.81 ± 23%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      3.41            -0.7        2.70 ±  7%  perf-profile.children.cycles-pp.dequeue_task_fair
      1.67            -0.7        1.02 ± 13%  perf-profile.children.cycles-pp.set_next_entity
      1.24 ±  2%      -0.6        0.60 ± 20%  perf-profile.children.cycles-pp.update_rq_clock
      2.46            -0.6        1.85 ±  6%  perf-profile.children.cycles-pp.pick_next_task_fair
      2.93 ±  2%      -0.6        2.37 ±  6%  perf-profile.children.cycles-pp.dequeue_entity
      0.83 ±140%      -0.4        0.39 ±  3%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      0.90 ±  2%      -0.4        0.48 ± 17%  perf-profile.children.cycles-pp.__update_load_avg_cfs_rq
      2.30            -0.4        1.94 ±  2%  perf-profile.children.cycles-pp.sock_alloc_send_pskb
      0.54 ±  2%      -0.3        0.21 ± 35%  perf-profile.children.cycles-pp.udp_rmem_release
      3.57            -0.3        3.26        perf-profile.children.cycles-pp.__ip_append_data
      0.46 ±  2%      -0.3        0.17 ± 27%  perf-profile.children.cycles-pp.__ksize
      0.65 ±  2%      -0.3        0.37 ± 16%  perf-profile.children.cycles-pp.copy_user_generic_unrolled
      0.37            -0.3        0.12 ± 43%  perf-profile.children.cycles-pp.nr_iowait_cpu
      1.66            -0.3        1.41        perf-profile.children.cycles-pp.__alloc_skb
      0.60 ±  3%      -0.3        0.35 ± 11%  perf-profile.children.cycles-pp.select_idle_sibling
      0.38            -0.3        0.13 ± 36%  perf-profile.children.cycles-pp.update_ts_time_stats
      0.58 ±  3%      -0.2        0.33 ± 21%  perf-profile.children.cycles-pp.prepare_to_wait_exclusive
      0.37 ±  2%      -0.2        0.12 ± 32%  perf-profile.children.cycles-pp.cpus_share_cache
      0.65 ±  4%      -0.2        0.41 ± 14%  perf-profile.children.cycles-pp.sock_wfree
      0.36 ±  2%      -0.2        0.12 ± 38%  perf-profile.children.cycles-pp.place_entity
      0.42 ±  3%      -0.2        0.18 ± 29%  perf-profile.children.cycles-pp.sock_def_write_space
      0.49 ±  2%      -0.2        0.26 ± 20%  perf-profile.children.cycles-pp.copyout
      0.74            -0.2        0.52 ±  9%  perf-profile.children.cycles-pp._copy_to_iter
      1.74            -0.2        1.55        perf-profile.children.cycles-pp.alloc_skb_with_frags
      0.37 ±  4%      -0.2        0.18 ± 28%  perf-profile.children.cycles-pp.skb_set_owner_w
      1.26 ±  2%      -0.2        1.08 ±  3%  perf-profile.children.cycles-pp.update_curr
      0.62 ±  2%      -0.2        0.45 ±  9%  perf-profile.children.cycles-pp.__update_load_avg_se
      0.42 ±  3%      -0.2        0.25 ± 10%  perf-profile.children.cycles-pp.skb_release_data
      1.64            -0.2        1.48 ±  3%  perf-profile.children.cycles-pp.tick_nohz_get_sleep_length
      0.47            -0.2        0.31 ±  3%  perf-profile.children.cycles-pp.ip_finish_output
      0.41            -0.2        0.25 ± 12%  perf-profile.children.cycles-pp.pick_next_entity
      0.36 ±  3%      -0.2        0.21 ± 15%  perf-profile.children.cycles-pp.switch_mm_irqs_off
      0.88            -0.1        0.73 ±  5%  perf-profile.children.cycles-pp.tick_nohz_idle_exit
      0.60 ±  2%      -0.1        0.45 ±  4%  perf-profile.children.cycles-pp.__slab_free
      0.95 ±  2%      -0.1        0.81        perf-profile.children.cycles-pp.select_task_rq_fair
      0.96            -0.1        0.82 ±  3%  perf-profile.children.cycles-pp.__consume_stateless_skb
      0.58 ±  2%      -0.1        0.46 ±  2%  perf-profile.children.cycles-pp.hrtimer_interrupt
      0.59            -0.1        0.47 ±  2%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      0.19 ±  2%      -0.1        0.09 ± 21%  perf-profile.children.cycles-pp.__list_del_entry_valid
      1.12            -0.1        1.02 ±  2%  perf-profile.children.cycles-pp.tick_nohz_next_event
      0.68 ±  6%      -0.1        0.59 ±  7%  perf-profile.children.cycles-pp._raw_spin_lock_bh
      1.46 ±  2%      -0.1        1.38 ±  2%  perf-profile.children.cycles-pp.loopback_xmit
      0.56 ±  4%      -0.1        0.48 ±  2%  perf-profile.children.cycles-pp.___perf_sw_event
      0.62 ±  2%      -0.1        0.54 ±  6%  perf-profile.children.cycles-pp.get_next_timer_interrupt
      0.37            -0.1        0.29 ±  9%  perf-profile.children.cycles-pp.reweight_entity
      0.83 ±  2%      -0.1        0.76        perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      0.29 ±  2%      -0.1        0.22 ±  6%  perf-profile.children.cycles-pp.rcu_idle_exit
      0.46 ±  3%      -0.1        0.39 ±  5%  perf-profile.children.cycles-pp.__cgroup_bpf_run_filter_skb
      0.37            -0.1        0.30 ±  3%  perf-profile.children.cycles-pp._copy_from_iter_full
      0.09            -0.1        0.03 ±100%  perf-profile.children.cycles-pp.tick_nohz_tick_stopped
      0.30 ±  2%      -0.1        0.23 ±  8%  perf-profile.children.cycles-pp.resched_curr
      0.10 ± 10%      -0.1        0.04 ± 58%  perf-profile.children.cycles-pp.tick_check_broadcast_expired
      0.16 ±  3%      -0.1        0.10 ± 10%  perf-profile.children.cycles-pp.clockevents_program_event
      0.44 ±  2%      -0.1        0.39 ±  4%  perf-profile.children.cycles-pp.finish_task_switch
      0.29            -0.1        0.23        perf-profile.children.cycles-pp.ip_setup_cork
      0.12 ±  5%      -0.1        0.06 ± 11%  perf-profile.children.cycles-pp.ktime_get_update_offsets_now
      0.61 ±  5%      -0.1        0.56 ±  3%  perf-profile.children.cycles-pp.fib_table_lookup
      0.20 ±  9%      -0.1        0.15 ± 11%  perf-profile.children.cycles-pp.__hrtimer_next_event_base
      0.10 ±  4%      -0.0        0.05        perf-profile.children.cycles-pp.rcu_needs_cpu
      0.18 ±  5%      -0.0        0.13 ± 14%  perf-profile.children.cycles-pp.available_idle_cpu
      0.18 ±  4%      -0.0        0.14 ±  8%  perf-profile.children.cycles-pp.rcu_eqs_exit
      0.07 ±  4%      -0.0        0.03 ±100%  perf-profile.children.cycles-pp.inet_sendmsg
      0.15 ±  4%      -0.0        0.11 ±  7%  perf-profile.children.cycles-pp.nf_hook_slow
      0.17 ±  2%      -0.0        0.13        perf-profile.children.cycles-pp.copyin
      0.11 ±  4%      -0.0        0.07 ± 11%  perf-profile.children.cycles-pp.menu_reflect
      0.13 ±  2%      -0.0        0.10 ±  9%  perf-profile.children.cycles-pp.ip_rcv_finish_core
      0.20 ±  2%      -0.0        0.17 ±  2%  perf-profile.children.cycles-pp.ipv4_pktinfo_prepare
      0.22            -0.0        0.18 ±  6%  perf-profile.children.cycles-pp.tick_sched_timer
      0.29 ±  2%      -0.0        0.26 ±  4%  perf-profile.children.cycles-pp.security_socket_sendmsg
      0.45            -0.0        0.42 ±  3%  perf-profile.children.cycles-pp._raw_spin_unlock_irqrestore
      0.09 ± 12%      -0.0        0.06 ± 14%  perf-profile.children.cycles-pp.tsc_verify_tsc_adjust
      0.10 ± 11%      -0.0        0.07 ± 17%  perf-profile.children.cycles-pp.arch_cpu_idle_enter
      0.45            -0.0        0.42 ±  2%  perf-profile.children.cycles-pp.irqtime_account_irq
      0.22 ±  2%      -0.0        0.19 ±  4%  perf-profile.children.cycles-pp.copy_user_enhanced_fast_string
      0.18 ±  3%      -0.0        0.15 ±  5%  perf-profile.children.cycles-pp.update_min_vruntime
      0.10 ±  7%      -0.0        0.08 ±  6%  perf-profile.children.cycles-pp.rcu_dynticks_eqs_exit
      0.41 ±  2%      -0.0        0.38 ±  3%  perf-profile.children.cycles-pp.__might_fault
      0.24            -0.0        0.22 ±  5%  perf-profile.children.cycles-pp.siphash_3u32
      0.22 ±  3%      -0.0        0.20 ±  3%  perf-profile.children.cycles-pp.__ip_finish_output
      0.09 ±  5%      -0.0        0.07 ± 10%  perf-profile.children.cycles-pp.scheduler_tick
      0.08 ±  5%      +0.0        0.10 ±  8%  perf-profile.children.cycles-pp.update_irq_load_avg
      0.22 ±  4%      +0.0        0.23 ±  2%  perf-profile.children.cycles-pp.security_socket_recvmsg
      0.05            +0.0        0.07 ±  6%  perf-profile.children.cycles-pp.rcu_note_context_switch
      0.15 ±  3%      +0.0        0.17 ±  4%  perf-profile.children.cycles-pp.call_cpuidle
      0.26 ±  2%      +0.0        0.28 ±  2%  perf-profile.children.cycles-pp.move_addr_to_kernel
      0.12 ±  3%      +0.0        0.14 ±  3%  perf-profile.children.cycles-pp.ksoftirqd_running
      0.07 ±  6%      +0.0        0.10 ± 11%  perf-profile.children.cycles-pp.validate_xmit_xfrm
      0.06 ±  7%      +0.0        0.08 ±  8%  perf-profile.children.cycles-pp.__enqueue_entity
      0.12 ±  3%      +0.0        0.15 ±  5%  perf-profile.children.cycles-pp.rcu_read_unlock_strict
      0.12 ±  3%      +0.0        0.15 ±  4%  perf-profile.children.cycles-pp._cond_resched
      0.18 ±  5%      +0.0        0.21 ±  8%  perf-profile.children.cycles-pp.__x86_indirect_thunk_rax
      0.24 ±  4%      +0.0        0.27 ±  4%  perf-profile.children.cycles-pp.sock_recvmsg
      0.10 ±  4%      +0.0        0.13 ±  5%  perf-profile.children.cycles-pp.kmalloc_slab
      0.16 ±  4%      +0.0        0.19 ±  3%  perf-profile.children.cycles-pp.ip_rcv_core
      0.22 ±  2%      +0.0        0.25 ±  5%  perf-profile.children.cycles-pp.exit_to_user_mode_prepare
      0.29            +0.0        0.32 ±  4%  perf-profile.children.cycles-pp.__might_sleep
      0.07 ±  7%      +0.0        0.10 ±  4%  perf-profile.children.cycles-pp._raw_spin_trylock
      0.14 ±  2%      +0.0        0.18 ± 12%  perf-profile.children.cycles-pp.__ip_local_out
      0.09 ±  5%      +0.0        0.12        perf-profile.children.cycles-pp.rebalance_domains
      0.37 ±  2%      +0.0        0.40        perf-profile.children.cycles-pp.__fget_light
      0.10 ±  5%      +0.0        0.14 ±  3%  perf-profile.children.cycles-pp.put_prev_entity
      0.08 ±  6%      +0.0        0.12 ±  9%  perf-profile.children.cycles-pp.security_sock_rcv_skb
      0.17 ±  2%      +0.0        0.20 ±  5%  perf-profile.children.cycles-pp.__entry_text_start
      0.25 ± 17%      +0.0        0.29 ±  4%  perf-profile.children.cycles-pp.start_kernel
      0.07 ± 13%      +0.0        0.11        perf-profile.children.cycles-pp.raw_local_deliver
      0.19 ±  3%      +0.0        0.23        perf-profile.children.cycles-pp.put_prev_task_fair
      0.53            +0.0        0.57        perf-profile.children.cycles-pp.tick_nohz_idle_enter
      0.04 ± 54%      +0.0        0.08 ± 10%  perf-profile.children.cycles-pp.rb_erase
      0.06 ±  5%      +0.0        0.11 ± 10%  perf-profile.children.cycles-pp.check_stack_object
      0.21 ±  3%      +0.0        0.26 ±  4%  perf-profile.children.cycles-pp.__check_heap_object
      0.05 ± 57%      +0.0        0.10 ± 11%  perf-profile.children.cycles-pp.skb_consume_udp
      0.00            +0.1        0.05        perf-profile.children.cycles-pp._raw_spin_unlock_bh
      0.17 ±  6%      +0.1        0.22 ±  3%  perf-profile.children.cycles-pp.cpuidle_governor_latency_req
      0.00            +0.1        0.05 ±  8%  perf-profile.children.cycles-pp.security_sk_classify_flow
      0.00            +0.1        0.05 ±  8%  perf-profile.children.cycles-pp.udp4_hwcsum
      0.54            +0.1        0.59 ±  4%  perf-profile.children.cycles-pp.sockfd_lookup_light
      0.42            +0.1        0.47 ±  4%  perf-profile.children.cycles-pp.syscall_return_via_sysret
      0.48 ±  5%      +0.1        0.54 ±  3%  perf-profile.children.cycles-pp.__udp4_lib_lookup
      0.16 ±  4%      +0.1        0.23 ± 16%  perf-profile.children.cycles-pp.set_next_task_idle
      0.14 ±  4%      +0.1        0.21 ± 18%  perf-profile.children.cycles-pp.__update_idle_core
      0.05 ±  9%      +0.1        0.12 ±  9%  perf-profile.children.cycles-pp.__kfree_skb_flush
      0.38 ±  7%      +0.1        0.44 ±  2%  perf-profile.children.cycles-pp.lock_sock_nested
      0.16 ±  3%      +0.1        0.23 ± 11%  perf-profile.children.cycles-pp.ip_local_out
      0.00            +0.1        0.07 ±  6%  perf-profile.children.cycles-pp.clear_buddies
      0.15 ±  6%      +0.1        0.22 ±  6%  perf-profile.children.cycles-pp.irq_exit_rcu
      0.13 ±  3%      +0.1        0.20 ±  7%  perf-profile.children.cycles-pp.ip4_datagram_release_cb
      0.00            +0.1        0.07 ±  5%  perf-profile.children.cycles-pp.ttwu_queue_wakelist
      0.00            +0.1        0.07 ± 11%  perf-profile.children.cycles-pp.apparmor_socket_sock_rcv_skb
      0.58 ±  2%      +0.1        0.66 ±  4%  perf-profile.children.cycles-pp.__kmalloc_reserve
      0.15 ±  5%      +0.1        0.23 ± 13%  perf-profile.children.cycles-pp.xfrm_lookup_route
      0.23 ±  9%      +0.1        0.31 ±  3%  perf-profile.children.cycles-pp.ktime_get_with_offset
      0.12 ±  5%      +0.1        0.20 ± 13%  perf-profile.children.cycles-pp.xfrm_lookup_with_ifid
      0.14 ±  6%      +0.1        0.24 ± 10%  perf-profile.children.cycles-pp.newidle_balance
      0.27 ±  3%      +0.1        0.37 ± 12%  perf-profile.children.cycles-pp.pick_next_task_idle
      0.15 ±  4%      +0.1        0.25 ±  3%  perf-profile.children.cycles-pp.timekeeping_max_deferment
      0.20 ±  3%      +0.1        0.32 ±  4%  perf-profile.children.cycles-pp.__virt_addr_valid
      0.13 ±  5%      +0.1        0.25 ±  8%  perf-profile.children.cycles-pp.kfree
      0.00            +0.1        0.13 ± 20%  perf-profile.children.cycles-pp.native_irq_return_iret
      0.53 ±  3%      +0.1        0.67 ±  8%  perf-profile.children.cycles-pp.netif_rx_internal
      0.54 ±  3%      +0.2        0.71 ±  7%  perf-profile.children.cycles-pp.netif_rx
      0.26 ±  5%      +0.2        0.44 ±  9%  perf-profile.children.cycles-pp.sk_filter_trim_cap
      0.67            +0.3        0.92 ±  3%  perf-profile.children.cycles-pp.__check_object_size
      1.26 ±  2%      +0.3        1.56 ± 12%  perf-profile.children.cycles-pp.ip_route_output_key_hash
      1.13 ±  2%      +0.3        1.44 ± 14%  perf-profile.children.cycles-pp.ip_route_output_key_hash_rcu
      0.00            +0.4        0.37 ± 26%  perf-profile.children.cycles-pp.asm_sysvec_reschedule_ipi
      1.30            +0.4        1.68 ± 13%  perf-profile.children.cycles-pp.ip_route_output_flow
      0.25 ±  5%      +0.6        0.82 ±  5%  perf-profile.children.cycles-pp.rcu_eqs_enter
      0.17 ± 10%      +0.6        0.76 ±  5%  perf-profile.children.cycles-pp.rcu_dynticks_eqs_enter
      3.00 ± 10%      +3.9        6.88 ±  5%  perf-profile.children.cycles-pp.poll_idle
     45.32            +5.1       50.38        perf-profile.children.cycles-pp.start_secondary
     45.52            +5.1       50.61        perf-profile.children.cycles-pp.do_idle
     45.57            +5.1       50.67        perf-profile.children.cycles-pp.secondary_startup_64_no_verify
     45.57            +5.1       50.67        perf-profile.children.cycles-pp.cpu_startup_entry
      3.49 ±  6%     +13.6       17.12 ± 13%  perf-profile.children.cycles-pp.menu_select
     29.82           -17.7       12.17 ± 17%  perf-profile.self.cycles-pp.intel_idle
      2.30            -1.2        1.15 ± 17%  perf-profile.self.cycles-pp.__schedule
      1.66 ±  2%      -0.8        0.87 ± 21%  perf-profile.self.cycles-pp._raw_spin_lock
      1.58 ±  2%      -0.8        0.80 ± 24%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.95 ±  2%      -0.6        0.30 ± 39%  perf-profile.self.cycles-pp.update_rq_clock
      1.43 ±  2%      -0.5        0.89 ± 14%  perf-profile.self.cycles-pp.update_load_avg
      0.61 ±191%      -0.5        0.14 ±  5%  perf-profile.self.cycles-pp.syscall_exit_to_user_mode
      0.88            -0.4        0.45 ± 19%  perf-profile.self.cycles-pp.__update_load_avg_cfs_rq
      0.74            -0.4        0.36 ± 22%  perf-profile.self.cycles-pp.set_next_entity
      0.53 ±  2%      -0.3        0.20 ± 34%  perf-profile.self.cycles-pp.udp_rmem_release
      0.46 ±  2%      -0.3        0.17 ± 27%  perf-profile.self.cycles-pp.__ksize
      0.85            -0.3        0.57 ±  9%  perf-profile.self.cycles-pp.enqueue_entity
      0.63            -0.3        0.36 ± 16%  perf-profile.self.cycles-pp.copy_user_generic_unrolled
      0.50 ±  2%      -0.3        0.23 ± 23%  perf-profile.self.cycles-pp.__skb_wait_for_more_packets
      0.37            -0.3        0.11 ± 46%  perf-profile.self.cycles-pp.nr_iowait_cpu
      0.36 ±  2%      -0.2        0.12 ± 41%  perf-profile.self.cycles-pp.place_entity
      0.36 ±  3%      -0.2        0.12 ± 33%  perf-profile.self.cycles-pp.cpus_share_cache
      0.41 ±  3%      -0.2        0.18 ± 28%  perf-profile.self.cycles-pp.sock_def_write_space
      0.60 ±  2%      -0.2        0.37 ±  7%  perf-profile.self.cycles-pp.__skb_recv_udp
      0.39 ±  2%      -0.2        0.19 ± 16%  perf-profile.self.cycles-pp.schedule
      0.34 ±  3%      -0.2        0.14 ± 27%  perf-profile.self.cycles-pp.sock_def_readable
      0.37 ±  4%      -0.2        0.18 ± 30%  perf-profile.self.cycles-pp.skb_set_owner_w
      0.77 ±  2%      -0.2        0.58 ±  9%  perf-profile.self.cycles-pp.do_idle
      0.53            -0.2        0.34 ±  8%  perf-profile.self.cycles-pp.enqueue_task_fair
      0.40 ±  2%      -0.2        0.21 ± 15%  perf-profile.self.cycles-pp.pick_next_entity
      0.67 ±  5%      -0.2        0.49 ±  5%  perf-profile.self.cycles-pp.udp_recvmsg
      0.40 ±  3%      -0.2        0.24 ± 10%  perf-profile.self.cycles-pp.skb_release_data
      0.46 ±  2%      -0.2        0.29 ± 15%  perf-profile.self.cycles-pp.dequeue_task_fair
      0.48            -0.2        0.32 ±  7%  perf-profile.self.cycles-pp.__udp_enqueue_schedule_skb
      0.78 ±  3%      -0.2        0.63 ±  6%  perf-profile.self.cycles-pp.update_curr
      0.60 ±  3%      -0.1        0.45 ±  5%  perf-profile.self.cycles-pp.__slab_free
      0.57            -0.1        0.44 ±  8%  perf-profile.self.cycles-pp.__update_load_avg_se
      0.30 ±  4%      -0.1        0.19 ± 11%  perf-profile.self.cycles-pp.switch_mm_irqs_off
      0.18 ±  2%      -0.1        0.08 ± 19%  perf-profile.self.cycles-pp.__list_del_entry_valid
      0.66 ±  7%      -0.1        0.57 ±  7%  perf-profile.self.cycles-pp._raw_spin_lock_bh
      0.21 ±  2%      -0.1        0.13 ±  5%  perf-profile.self.cycles-pp.tick_nohz_next_event
      0.36            -0.1        0.29 ±  9%  perf-profile.self.cycles-pp.reweight_entity
      0.14 ±  5%      -0.1        0.08 ± 20%  perf-profile.self.cycles-pp.__wake_up_common
      0.12 ±  5%      -0.1        0.05 ± 58%  perf-profile.self.cycles-pp.ktime_get_update_offsets_now
      0.52 ±  6%      -0.1        0.45 ±  2%  perf-profile.self.cycles-pp.fib_table_lookup
      0.39 ±  3%      -0.1        0.33 ±  2%  perf-profile.self.cycles-pp.udp_queue_rcv_one_skb
      0.49 ±  4%      -0.1        0.43        perf-profile.self.cycles-pp.___perf_sw_event
      0.42 ±  3%      -0.1        0.36 ±  5%  perf-profile.self.cycles-pp.__cgroup_bpf_run_filter_skb
      0.29 ±  2%      -0.1        0.23 ±  8%  perf-profile.self.cycles-pp.resched_curr
      0.33 ±  2%      -0.1        0.27 ±  6%  perf-profile.self.cycles-pp.finish_task_switch
      0.10 ± 11%      -0.1        0.04 ± 58%  perf-profile.self.cycles-pp.tick_check_broadcast_expired
      0.09 ±  8%      -0.1        0.03 ±100%  perf-profile.self.cycles-pp.nf_hook_slow
      0.11 ± 13%      -0.1        0.05 ±  9%  perf-profile.self.cycles-pp.udp_unicast_rcv_skb
      0.15 ±  3%      -0.1        0.10 ±  5%  perf-profile.self.cycles-pp.ip_setup_cork
      0.17 ±  5%      -0.1        0.12 ± 16%  perf-profile.self.cycles-pp.available_idle_cpu
      0.15 ±  4%      -0.0        0.11 ±  4%  perf-profile.self.cycles-pp.__hrtimer_next_event_base
      0.16 ±  3%      -0.0        0.11 ±  4%  perf-profile.self.cycles-pp.__x64_sys_sendto
      0.09 ±  5%      -0.0        0.05        perf-profile.self.cycles-pp.rcu_needs_cpu
      0.12 ±  4%      -0.0        0.08 ±  6%  perf-profile.self.cycles-pp.ip_finish_output
      0.06 ±  7%      -0.0        0.03 ±100%  perf-profile.self.cycles-pp.tsc_verify_tsc_adjust
      0.29 ±  2%      -0.0        0.25        perf-profile.self.cycles-pp.__kmalloc_node_track_caller
      0.20 ±  2%      -0.0        0.17 ±  5%  perf-profile.self.cycles-pp.copy_user_enhanced_fast_string
      0.13 ±  4%      -0.0        0.09 ±  8%  perf-profile.self.cycles-pp.ip_rcv_finish_core
      0.20 ±  2%      -0.0        0.16 ±  5%  perf-profile.self.cycles-pp.loopback_xmit
      0.18 ±  4%      -0.0        0.15 ±  3%  perf-profile.self.cycles-pp.update_min_vruntime
      0.07 ±  6%      -0.0        0.04 ± 58%  perf-profile.self.cycles-pp.ipv4_pktinfo_prepare
      0.16 ±  3%      -0.0        0.12 ±  6%  perf-profile.self.cycles-pp.__ip_finish_output
      0.11 ±  6%      -0.0        0.08 ±  5%  perf-profile.self.cycles-pp.rcu_idle_exit
      0.10 ±  4%      -0.0        0.08 ±  5%  perf-profile.self.cycles-pp.__might_fault
      0.19 ±  2%      -0.0        0.16 ±  5%  perf-profile.self.cycles-pp.sock_sendmsg
      0.12 ±  2%      -0.0        0.10 ±  4%  perf-profile.self.cycles-pp.__x64_sys_recvfrom
      0.13 ±  3%      -0.0        0.11        perf-profile.self.cycles-pp.__x86_indirect_thunk_rax
      0.10 ±  6%      -0.0        0.08 ±  6%  perf-profile.self.cycles-pp.rcu_dynticks_eqs_exit
      0.12 ±  4%      -0.0        0.10 ±  4%  perf-profile.self.cycles-pp.ip_make_skb
      0.05            +0.0        0.06        perf-profile.self.cycles-pp.sched_clock
      0.05            +0.0        0.06        perf-profile.self.cycles-pp.rcu_all_qs
      0.11 ±  3%      +0.0        0.12 ±  4%  perf-profile.self.cycles-pp.ksoftirqd_running
      0.09 ±  6%      +0.0        0.11 ±  4%  perf-profile.self.cycles-pp.schedule_idle
      0.08 ±  5%      +0.0        0.10 ±  8%  perf-profile.self.cycles-pp.update_irq_load_avg
      0.12 ±  3%      +0.0        0.14 ±  5%  perf-profile.self.cycles-pp.sockfd_lookup_light
      0.09 ±  3%      +0.0        0.11 ±  4%  perf-profile.self.cycles-pp.ip_send_skb
      0.13            +0.0        0.15 ±  4%  perf-profile.self.cycles-pp.ip_protocol_deliver_rcu
      0.34 ±  2%      +0.0        0.36        perf-profile.self.cycles-pp.___might_sleep
      0.07 ±  4%      +0.0        0.09 ±  8%  perf-profile.self.cycles-pp.validate_xmit_xfrm
      0.25            +0.0        0.28 ±  5%  perf-profile.self.cycles-pp.__might_sleep
      0.05 ±  7%      +0.0        0.08 ±  6%  perf-profile.self.cycles-pp.__enqueue_entity
      0.06 ±  5%      +0.0        0.09 ±  4%  perf-profile.self.cycles-pp.cpuidle_governor_latency_req
      0.06 ±  7%      +0.0        0.09 ±  7%  perf-profile.self.cycles-pp.exit_to_user_mode_prepare
      0.10            +0.0        0.13 ±  6%  perf-profile.self.cycles-pp.kmalloc_slab
      0.07 ±  7%      +0.0        0.10 ±  5%  perf-profile.self.cycles-pp._raw_spin_trylock
      0.18 ±  8%      +0.0        0.21 ±  2%  perf-profile.self.cycles-pp.sock_alloc_send_pskb
      0.16 ±  4%      +0.0        0.19 ±  2%  perf-profile.self.cycles-pp.ip_rcv_core
      0.22 ±  3%      +0.0        0.26        perf-profile.self.cycles-pp.__udp4_lib_lookup
      0.02 ±111%      +0.0        0.06 ±  9%  perf-profile.self.cycles-pp.__cgroup_account_cputime
      0.13 ±  3%      +0.0        0.17 ±  5%  perf-profile.self.cycles-pp.prepare_to_wait_exclusive
      0.36            +0.0        0.39        perf-profile.self.cycles-pp.__fget_light
      0.07 ±  4%      +0.0        0.10 ±  8%  perf-profile.self.cycles-pp.ip_generic_getfrag
      0.08 ±  5%      +0.0        0.12 ±  3%  perf-profile.self.cycles-pp.put_prev_entity
      0.05 ± 36%      +0.0        0.08 ± 21%  perf-profile.self.cycles-pp.__ip_local_out
      0.03 ± 70%      +0.0        0.07 ± 10%  perf-profile.self.cycles-pp.__kfree_skb_flush
      0.14 ±  3%      +0.0        0.17 ±  8%  perf-profile.self.cycles-pp.ip_rcv
      0.17 ±  2%      +0.0        0.20 ±  5%  perf-profile.self.cycles-pp.__entry_text_start
      0.21 ±  4%      +0.0        0.25 ±  3%  perf-profile.self.cycles-pp.__check_object_size
      0.06 ± 15%      +0.0        0.10        perf-profile.self.cycles-pp.raw_local_deliver
      0.05 ±  7%      +0.0        0.10 ±  9%  perf-profile.self.cycles-pp.check_stack_object
      0.13 ±  3%      +0.0        0.18 ±  6%  perf-profile.self.cycles-pp.asm_call_sysvec_on_stack
      0.26 ±  2%      +0.0        0.31 ±  5%  perf-profile.self.cycles-pp.ip_output
      0.02 ±142%      +0.0        0.07 ±  6%  perf-profile.self.cycles-pp._copy_to_user
      0.20 ±  3%      +0.0        0.25        perf-profile.self.cycles-pp.__local_bh_enable_ip
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.security_sk_classify_flow
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.udp4_hwcsum
      0.04 ± 73%      +0.1        0.09 ±  8%  perf-profile.self.cycles-pp.skb_consume_udp
      0.00            +0.1        0.05 ±  8%  perf-profile.self.cycles-pp.ip_local_out
      0.37 ±  3%      +0.1        0.42 ±  3%  perf-profile.self.cycles-pp.__ip_make_skb
      0.21 ±  3%      +0.1        0.26 ±  4%  perf-profile.self.cycles-pp.__check_heap_object
      0.00            +0.1        0.05 ±  9%  perf-profile.self.cycles-pp.copyout
      0.07 ±  6%      +0.1        0.13 ± 10%  perf-profile.self.cycles-pp.alloc_skb_with_frags
      0.42 ±  2%      +0.1        0.47 ±  4%  perf-profile.self.cycles-pp.syscall_return_via_sysret
      0.13 ±  6%      +0.1        0.19 ±  9%  perf-profile.self.cycles-pp.newidle_balance
      0.08 ±  5%      +0.1        0.14 ± 15%  perf-profile.self.cycles-pp.pick_next_task_idle
      0.08 ±  6%      +0.1        0.14 ± 13%  perf-profile.self.cycles-pp.select_idle_sibling
      0.01 ±187%      +0.1        0.08 ± 11%  perf-profile.self.cycles-pp.rb_erase
      0.17 ±  2%      +0.1        0.24 ±  6%  perf-profile.self.cycles-pp.__sys_recvfrom
      0.00            +0.1        0.07 ±  7%  perf-profile.self.cycles-pp.apparmor_socket_sock_rcv_skb
      0.11 ±  3%      +0.1        0.18 ±  6%  perf-profile.self.cycles-pp.ip_local_deliver
      0.11 ±  3%      +0.1        0.18 ±  6%  perf-profile.self.cycles-pp.ip4_datagram_release_cb
      0.00            +0.1        0.07        perf-profile.self.cycles-pp.ttwu_queue_wakelist
      0.01 ±282%      +0.1        0.08 ±  5%  perf-profile.self.cycles-pp.ttwu_do_activate
      0.17 ±  8%      +0.1        0.24 ±  5%  perf-profile.self.cycles-pp.ktime_get_with_offset
      0.13 ±  5%      +0.1        0.20 ±  6%  perf-profile.self.cycles-pp.kmem_cache_free
      0.16 ±  4%      +0.1        0.23 ±  9%  perf-profile.self.cycles-pp.__alloc_skb
      0.00            +0.1        0.08 ± 14%  perf-profile.self.cycles-pp.ttwu_do_wakeup
      0.33 ±  3%      +0.1        0.41 ±  8%  perf-profile.self.cycles-pp.select_task_rq_fair
      0.12 ±  4%      +0.1        0.20 ± 13%  perf-profile.self.cycles-pp.xfrm_lookup_with_ifid
      0.24 ±  8%      +0.1        0.33 ± 23%  perf-profile.self.cycles-pp.__dev_queue_xmit
      0.00            +0.1        0.10 ±  4%  perf-profile.self.cycles-pp.ip_local_deliver_finish
      0.14 ±  4%      +0.1        0.24 ±  4%  perf-profile.self.cycles-pp.timekeeping_max_deferment
      0.06 ±  7%      +0.1        0.17 ± 15%  perf-profile.self.cycles-pp.sk_filter_trim_cap
      0.19 ±  3%      +0.1        0.30 ±  4%  perf-profile.self.cycles-pp.__virt_addr_valid
      0.13 ±  5%      +0.1        0.24 ±  9%  perf-profile.self.cycles-pp.kfree
      0.00            +0.1        0.12 ± 23%  perf-profile.self.cycles-pp.ip_route_output_flow
      0.00            +0.1        0.13 ± 20%  perf-profile.self.cycles-pp.native_irq_return_iret
      0.11 ±  7%      +0.1        0.24 ± 11%  perf-profile.self.cycles-pp.pick_next_task_fair
      0.11 ± 10%      +0.1        0.25 ±  9%  perf-profile.self.cycles-pp.inet_recvmsg
      0.50 ±  8%      +0.3        0.84 ± 21%  perf-profile.self.cycles-pp.ip_route_output_key_hash_rcu
      0.17 ± 10%      +0.6        0.76 ±  5%  perf-profile.self.cycles-pp.rcu_dynticks_eqs_enter
      2.83 ± 11%      +3.8        6.58 ±  5%  perf-profile.self.cycles-pp.poll_idle
      0.53 ± 20%      +6.9        7.42 ± 15%  perf-profile.self.cycles-pp.cpuidle_enter_state
      1.60 ± 12%     +13.8       15.36 ± 15%  perf-profile.self.cycles-pp.menu_select


                                                                                
                               netperf.Throughput_tps                           
                                                                                
  70000 +-------------------------------------------------------------------+   
  65000 |-+.++.+.+.+.++   +    +.+    +.+.+    +.+.+.+.++.+.+  +.+.+.+.++.+.|   
        |                                                                   |   
  60000 |-+      O   O             O      O                                 |   
  55000 |-+        O                                                        |   
        |                                                                   |   
  50000 |-+ O                    O      O                                   |   
  45000 |-+                          O      O                               |   
  40000 |-O    O                                                            |   
        |    O        O               O       O                             |   
  35000 |-+                                                                 |   
  30000 |-+               O  O                                              |   
        |                   O  O                                            |   
  25000 |-+             O                                                   |   
  20000 +-------------------------------------------------------------------+   
                                                                                
                                                                                
[*] bisect-good sample
[O] bisect-bad  sample

***************************************************************************************************
lkp-csl-2ap4: 192 threads Intel(R) Xeon(R) Platinum 9242 CPU @ 2.30GHz with 192G memory
=========================================================================================
compiler/cpufreq_governor/ipc/iterations/kconfig/mode/nr_threads/rootfs/tbox_group/testcase/ucode:
  gcc-9/performance/pipe/4/x86_64-rhel-8.3/threads/100%/debian-10.4-x86_64-20200603.cgz/lkp-csl-2ap4/hackbench/0x5003003

commit: 
  v5.10-rc4
  8d86968ac3 ("sched/fair: select idle cpu from idle cpumask for task wakeup")

       v5.10-rc4 8d86968ac36ea5bff487f70b5ff 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
    572871 ±  3%     +51.7%     869183        hackbench.throughput
    164.05 ±  2%     -32.1%     111.38 ±  2%  hackbench.time.elapsed_time
    164.05 ±  2%     -32.1%     111.38 ±  2%  hackbench.time.elapsed_time.max
 1.817e+09 ±  2%     -22.3%  1.411e+09        hackbench.time.involuntary_context_switches
      1323 ± 17%     -42.0%     767.50 ± 18%  hackbench.time.major_page_faults
    513216 ±  8%     -60.3%     203595 ±  7%  hackbench.time.minor_page_faults
     18525            -1.3%      18278        hackbench.time.percent_of_cpu_this_job_got
     28532 ±  2%     -34.9%      18561 ±  2%  hackbench.time.system_time
      1860            -3.3%       1798        hackbench.time.user_time
 2.856e+09 ±  2%     -26.7%  2.094e+09        hackbench.time.voluntary_context_switches
    199.54 ±  2%     -26.2%     147.24 ±  2%  uptime.boot
     89.62            -4.6%      85.50        vmstat.cpu.sy
  27980099           +10.3%   30870803 ±  2%  vmstat.system.cs
   1916677           -24.1%    1453990 ±  2%  vmstat.system.in
  10676879 ± 10%     +17.6%   12555262 ±  6%  cpuidle.C1.usage
   2629890 ± 16%     +51.0%    3971486        cpuidle.C1E.usage
   9177750 ± 11%    +318.5%   38407578 ±  8%  cpuidle.POLL.time
   3649369 ± 11%    +415.0%   18792454 ±  9%  cpuidle.POLL.usage
      2.76 ±  9%      +1.2        4.00 ±  4%  mpstat.cpu.all.idle%
      1.42 ±  2%      +0.2        1.66 ±  2%  mpstat.cpu.all.irq%
      0.04 ±  5%      +0.0        0.06 ±  2%  mpstat.cpu.all.soft%
      5.94 ±  2%      +2.5        8.39 ±  2%  mpstat.cpu.all.usr%
  12617673 ± 21%     +38.4%   17469164 ± 12%  numa-numastat.node0.local_node
  12639382 ± 21%     +38.4%   17492395 ± 12%  numa-numastat.node0.numa_hit
  13323975 ± 15%     +34.4%   17913328 ±  6%  numa-numastat.node3.local_node
  13355052 ± 15%     +34.2%   17928946 ±  6%  numa-numastat.node3.numa_hit
      8731 ±  5%      +6.8%       9327 ±  2%  slabinfo.Acpi-State.active_objs
      8731 ±  5%      +6.8%       9327 ±  2%  slabinfo.Acpi-State.num_objs
     21715           -13.6%      18772 ±  3%  slabinfo.kmalloc-256.active_objs
     21771           -13.3%      18873 ±  2%  slabinfo.kmalloc-256.num_objs
     54258 ± 10%     -92.9%       3853 ± 13%  meminfo.Active
     54258 ± 10%     -92.9%       3853 ± 13%  meminfo.Active(anon)
    135989           -24.6%     102492 ±  7%  meminfo.AnonHugePages
     55308 ±  3%     -41.3%      32484 ±  2%  meminfo.Mapped
      5930 ±  2%      +9.6%       6497 ±  3%  meminfo.PageTables
     82739 ±  8%     -80.8%      15878 ±  6%  meminfo.Shmem
     25620 ±  3%     +42.8%      36576 ±  6%  meminfo.max_used_kB
     11018 ± 16%     -39.4%       6674 ±  4%  numa-meminfo.node0.Mapped
     12131 ± 18%     -43.5%       6851 ±  5%  numa-meminfo.node2.Mapped
     49284 ± 23%     -96.9%       1534 ±104%  numa-meminfo.node3.Active
     49284 ± 23%     -96.9%       1534 ±104%  numa-meminfo.node3.Active(anon)
    294918 ±  4%     -16.1%     247401 ±  8%  numa-meminfo.node3.FilePages
     19066 ± 15%     -56.3%       8326 ± 29%  numa-meminfo.node3.Mapped
     68214 ± 21%     -92.6%       5078 ± 91%  numa-meminfo.node3.Shmem
      2797 ± 15%     -39.3%       1697 ±  7%  numa-vmstat.node0.nr_mapped
      3047 ± 19%     -41.8%       1773 ±  7%  numa-vmstat.node2.nr_mapped
     77617 ± 35%     +43.0%     110999        numa-vmstat.node2.numa_other
     12118 ± 22%     -96.8%     382.00 ±104%  numa-vmstat.node3.nr_active_anon
     73570 ±  3%     -15.9%      61852 ±  8%  numa-vmstat.node3.nr_file_pages
      4888 ± 19%     -57.4%       2082 ± 29%  numa-vmstat.node3.nr_mapped
     16894 ± 20%     -92.5%       1271 ± 91%  numa-vmstat.node3.nr_shmem
     12118 ± 22%     -96.8%     382.00 ±104%  numa-vmstat.node3.nr_zone_active_anon
   7440822 ± 16%     +34.7%   10020536 ±  7%  numa-vmstat.node3.numa_hit
   7333100 ± 17%     +35.7%    9954413 ±  7%  numa-vmstat.node3.numa_local
     13240 ± 11%     -92.7%     960.00 ± 13%  proc-vmstat.nr_active_anon
     82428            +4.4%      86092        proc-vmstat.nr_anon_pages
    253193            -3.4%     244488        proc-vmstat.nr_file_pages
    129244            +1.7%     131385        proc-vmstat.nr_kernel_stack
     13899 ±  2%     -40.7%       8248 ±  2%  proc-vmstat.nr_mapped
      1482 ±  2%     +11.6%       1654 ±  3%  proc-vmstat.nr_page_table_pages
     20307 ±  8%     -80.4%       3974 ±  6%  proc-vmstat.nr_shmem
    232911            +3.3%     240524        proc-vmstat.nr_unevictable
     13240 ± 11%     -92.7%     960.00 ± 13%  proc-vmstat.nr_zone_active_anon
    232911            +3.3%     240524        proc-vmstat.nr_zone_unevictable
    425103 ± 10%     -71.9%     119596 ± 17%  proc-vmstat.numa_hint_faults
    349617 ± 11%     -83.7%      56946 ± 24%  proc-vmstat.numa_hint_faults_local
  55991641 ±  4%     +24.5%   69695914        proc-vmstat.numa_hit
  55898341 ±  4%     +24.5%   69602609        proc-vmstat.numa_local
    523298 ± 10%     -65.7%     179518 ± 26%  proc-vmstat.numa_pte_updates
     55330 ±  7%     -99.2%     459.00 ± 11%  proc-vmstat.pgactivate
  56176549 ±  4%     +24.4%   69873586        proc-vmstat.pgalloc_normal
   1092076 ±  4%     -44.8%     602975 ±  6%  proc-vmstat.pgfault
  56227641 ±  4%     +24.3%   69892824        proc-vmstat.pgfree
     30412 ±  2%     -26.9%      22235 ±  2%  proc-vmstat.pgreuse
      5815 ± 16%     -37.0%       3665 ± 21%  sched_debug.cfs_rq:/.load.avg
  11898206           -53.4%    5543777 ±  2%  sched_debug.cfs_rq:/.min_vruntime.avg
  13497261 ±  2%     -51.6%    6535378 ±  4%  sched_debug.cfs_rq:/.min_vruntime.max
  10447952 ±  2%     -54.8%    4722727 ±  4%  sched_debug.cfs_rq:/.min_vruntime.min
    682890 ± 16%     -43.9%     383185 ± 24%  sched_debug.cfs_rq:/.min_vruntime.stddev
      0.65 ±  8%     -39.0%       0.40 ± 51%  sched_debug.cfs_rq:/.nr_running.avg
    662547 ± 15%     -42.1%     383420 ± 22%  sched_debug.cfs_rq:/.spread0.stddev
    320.13 ± 16%     -52.4%     152.33 ± 52%  sched_debug.cfs_rq:/.util_est_enqueued.avg
    181.35 ±  5%     -19.0%     146.91 ± 20%  sched_debug.cfs_rq:/.util_est_enqueued.stddev
    318910 ±  5%     +77.3%     565341 ±  9%  sched_debug.cpu.avg_idle.avg
    150913 ± 33%    +105.1%     309571 ± 19%  sched_debug.cpu.avg_idle.stddev
     96499           -32.1%      65475        sched_debug.cpu.clock.avg
     97014 ±  2%     -32.2%      65740        sched_debug.cpu.clock.max
     95518           -32.2%      64800        sched_debug.cpu.clock.min
     95508           -32.1%      64822        sched_debug.cpu.clock_task.avg
     96186 ±  2%     -32.2%      65234        sched_debug.cpu.clock_task.max
     86092           -34.9%      56017        sched_debug.cpu.clock_task.min
     18465 ±  6%     -19.4%      14885 ± 11%  sched_debug.cpu.curr->pid.max
   9251180 ±  2%     -46.6%    4937756 ±  4%  sched_debug.cpu.nr_switches.avg
  10542199 ±  3%     -44.8%    5822427 ±  4%  sched_debug.cpu.nr_switches.max
   8110905 ±  2%     -47.2%    4284323 ±  7%  sched_debug.cpu.nr_switches.min
    483044 ± 14%     -42.8%     276136 ± 18%  sched_debug.cpu.nr_switches.stddev
     95500           -32.2%      64757        sched_debug.cpu_clk
     94626           -32.5%      63883        sched_debug.ktime
     95873           -32.1%      65124        sched_debug.sched_clk
     10.23           -38.8%       6.27 ±  3%  perf-stat.i.MPKI
 5.548e+10           +23.0%  6.825e+10 ±  2%  perf-stat.i.branch-instructions
      1.15            -0.1        1.08        perf-stat.i.branch-miss-rate%
 6.022e+08           +11.9%  6.739e+08 ±  2%  perf-stat.i.branch-misses
      4.20 ±  4%     +13.2       17.43 ±  3%  perf-stat.i.cache-miss-rate%
 1.025e+08 ±  5%    +167.5%  2.743e+08 ±  3%  perf-stat.i.cache-misses
 2.568e+09           -35.5%  1.657e+09        perf-stat.i.cache-references
  28334089           +10.1%   31190600 ±  2%  perf-stat.i.context-switches
      2.40 ±  2%     -14.7%       2.05 ±  4%  perf-stat.i.cpi
 5.767e+11            -2.9%  5.599e+11        perf-stat.i.cpu-cycles
   2916124 ±  2%     -45.6%    1584932 ±  6%  perf-stat.i.cpu-migrations
      6909 ±  6%     -64.8%       2435 ±  8%  perf-stat.i.cycles-between-cache-misses
      0.01 ±  9%      -0.0        0.00 ± 12%  perf-stat.i.dTLB-load-miss-rate%
   4382174 ±  4%     -29.0%    3113515 ±  8%  perf-stat.i.dTLB-load-misses
 7.717e+10           +24.7%   9.62e+10 ±  2%  perf-stat.i.dTLB-loads
    375709 ±  2%     -17.2%     311193 ±  3%  perf-stat.i.dTLB-store-misses
 4.567e+10           +26.3%  5.768e+10 ±  2%  perf-stat.i.dTLB-stores
 3.502e+08 ±  3%     +15.1%  4.031e+08 ±  3%  perf-stat.i.iTLB-load-misses
  2.65e+11           +23.0%   3.26e+11 ±  2%  perf-stat.i.instructions
    768.32 ±  2%      +6.3%     816.80        perf-stat.i.instructions-per-iTLB-miss
      0.46           +26.3%       0.58 ±  3%  perf-stat.i.ipc
      3.00            -2.9%       2.91        perf-stat.i.metric.GHz
      0.13 ± 13%    +180.5%       0.36 ± 32%  perf-stat.i.metric.K/sec
    942.12           +23.9%       1167 ±  2%  perf-stat.i.metric.M/sec
      6621 ±  3%     -18.3%       5408 ±  4%  perf-stat.i.minor-faults
     89.09            +4.2       93.26        perf-stat.i.node-load-miss-rate%
  27200395 ±  6%    +105.6%   55915796 ±  2%  perf-stat.i.node-load-misses
     71.21           +12.7       83.89        perf-stat.i.node-store-miss-rate%
  11769833 ±  6%    +142.3%   28519715        perf-stat.i.node-store-misses
   5279062 ±  8%     +16.1%    6131469 ±  2%  perf-stat.i.node-stores
      6631 ±  3%     -18.3%       5417 ±  4%  perf-stat.i.page-faults
      9.61           -48.9%       4.92 ±  2%  perf-stat.overall.MPKI
      1.08            -0.1        0.98        perf-stat.overall.branch-miss-rate%
      4.02 ±  4%     +13.0       17.05 ±  3%  perf-stat.overall.cache-miss-rate%
      2.14 ±  2%     -22.0%       1.67 ±  2%  perf-stat.overall.cpi
      5559 ±  5%     -64.1%       1998 ±  4%  perf-stat.overall.cycles-between-cache-misses
      0.01 ±  5%      -0.0        0.00 ±  9%  perf-stat.overall.dTLB-load-miss-rate%
      0.00 ±  3%      -0.0        0.00 ±  4%  perf-stat.overall.dTLB-store-miss-rate%
    759.51 ±  2%      +6.7%     810.38        perf-stat.overall.instructions-per-iTLB-miss
      0.47 ±  2%     +28.2%       0.60 ±  2%  perf-stat.overall.ipc
     89.21            +3.9       93.11        perf-stat.overall.node-load-miss-rate%
     68.42 ±  2%     +13.5       81.89        perf-stat.overall.node-store-miss-rate%
 5.596e+10           +24.2%  6.952e+10 ±  2%  perf-stat.ps.branch-instructions
 6.034e+08           +12.6%  6.797e+08 ±  2%  perf-stat.ps.branch-misses
 1.034e+08 ±  5%    +169.1%  2.782e+08 ±  3%  perf-stat.ps.cache-misses
 2.569e+09           -36.5%  1.631e+09        perf-stat.ps.cache-references
  28329305           +10.9%   31418770 ±  2%  perf-stat.ps.context-switches
 5.729e+11            -3.1%  5.551e+11        perf-stat.ps.cpu-cycles
   2861035 ±  2%     -48.8%    1463484 ±  6%  perf-stat.ps.cpu-migrations
   4585673 ±  4%     -35.2%    2973169 ±  8%  perf-stat.ps.dTLB-load-misses
 7.786e+10           +25.9%  9.805e+10 ±  2%  perf-stat.ps.dTLB-loads
    375322 ±  2%     -20.6%     298148 ±  3%  perf-stat.ps.dTLB-store-misses
 4.608e+10           +27.6%  5.881e+10 ±  2%  perf-stat.ps.dTLB-stores
 3.522e+08 ±  3%     +16.4%  4.099e+08 ±  3%  perf-stat.ps.iTLB-load-misses
   4616193 ± 10%     -13.2%    4006021 ±  4%  perf-stat.ps.iTLB-loads
 2.673e+11           +24.2%  3.321e+11 ±  2%  perf-stat.ps.instructions
      6403 ±  3%     -21.5%       5027 ±  4%  perf-stat.ps.minor-faults
  27179360 ±  6%    +104.0%   55440463        perf-stat.ps.node-load-misses
  11786339 ±  5%    +142.7%   28603077        perf-stat.ps.node-store-misses
   5443927 ±  8%     +16.2%    6323526        perf-stat.ps.node-stores
      6412 ±  3%     -21.5%       5035 ±  4%  perf-stat.ps.page-faults
 4.418e+13           -15.5%  3.734e+13        perf-stat.total.instructions
      4.76 ± 26%      -2.2        2.51 ± 58%  perf-profile.calltrace.cycles-pp.select_task_rq_fair.try_to_wake_up.autoremove_wake_function.__wake_up_common.__wake_up_common_lock
      3.56 ± 36%      -1.9        1.61 ± 58%  perf-profile.calltrace.cycles-pp.select_idle_sibling.select_task_rq_fair.try_to_wake_up.autoremove_wake_function.__wake_up_common
      0.61 ± 11%      +0.6        1.20 ± 62%  perf-profile.calltrace.cycles-pp.mutex_unlock.pipe_write.new_sync_write.vfs_write.ksys_write
      0.86 ± 41%      +0.6        1.50 ± 36%  perf-profile.calltrace.cycles-pp.__fdget_pos.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.07 ±264%      +1.1        1.13 ± 31%  perf-profile.calltrace.cycles-pp.finish_task_switch.__schedule.schedule.pipe_read.new_sync_read
      0.00            +1.2        1.21 ± 45%  perf-profile.calltrace.cycles-pp.__schedule.schedule_idle.do_idle.cpu_startup_entry.start_secondary
      0.00            +1.2        1.23 ± 46%  perf-profile.calltrace.cycles-pp.schedule_idle.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      0.57 ±102%     +10.4       10.96 ±105%  perf-profile.calltrace.cycles-pp.intel_idle.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry
      0.69 ± 86%     +13.7       14.34 ±115%  perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry.start_secondary
      0.69 ± 86%     +14.2       14.93 ±116%  perf-profile.calltrace.cycles-pp.cpuidle_enter.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      0.97 ± 84%     +18.6       19.53 ±116%  perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      0.97 ± 84%     +18.6       19.53 ±116%  perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      0.97 ± 84%     +18.6       19.53 ±116%  perf-profile.calltrace.cycles-pp.start_secondary.secondary_startup_64_no_verify
      0.97 ± 84%     +18.6       19.60 ±115%  perf-profile.calltrace.cycles-pp.secondary_startup_64_no_verify
      4.91 ± 25%      -2.3        2.66 ± 48%  perf-profile.children.cycles-pp.select_task_rq_fair
      3.72 ± 35%      -2.0        1.75 ± 47%  perf-profile.children.cycles-pp.select_idle_sibling
      1.48 ± 48%      -1.1        0.41 ± 42%  perf-profile.children.cycles-pp.available_idle_cpu
      2.67 ±  7%      -0.9        1.81 ± 45%  perf-profile.children.cycles-pp.update_curr
      1.74 ±  5%      -0.7        0.99 ± 50%  perf-profile.children.cycles-pp.reweight_entity
      0.95 ± 24%      -0.3        0.63 ± 12%  perf-profile.children.cycles-pp.syscall_return_via_sysret
      1.03 ±  5%      -0.3        0.72 ± 28%  perf-profile.children.cycles-pp.__update_load_avg_se
      0.54 ± 12%      -0.3        0.26 ± 63%  perf-profile.children.cycles-pp.__enqueue_entity
      0.62 ±  7%      -0.3        0.36 ± 40%  perf-profile.children.cycles-pp.pick_next_entity
      0.92 ±  5%      -0.2        0.68 ± 30%  perf-profile.children.cycles-pp.__update_load_avg_cfs_rq
      0.62 ±  7%      -0.2        0.38 ± 59%  perf-profile.children.cycles-pp.put_prev_entity
      0.73 ± 20%      -0.2        0.49 ± 15%  perf-profile.children.cycles-pp.___might_sleep
      0.60 ±  4%      -0.2        0.37 ± 49%  perf-profile.children.cycles-pp.___perf_sw_event
      0.94 ±  4%      -0.2        0.71 ± 22%  perf-profile.children.cycles-pp.__switch_to_asm
      0.60 ± 15%      -0.2        0.41 ± 12%  perf-profile.children.cycles-pp.__might_sleep
      0.51 ± 17%      -0.2        0.34 ± 18%  perf-profile.children.cycles-pp.file_update_time
      0.53 ±  7%      -0.2        0.35 ± 45%  perf-profile.children.cycles-pp.copy_fpregs_to_fpstate
      0.43 ± 25%      -0.2        0.27 ± 11%  perf-profile.children.cycles-pp.current_time
      0.41 ±  6%      -0.1        0.26 ± 44%  perf-profile.children.cycles-pp.__calc_delta
      0.26 ± 13%      -0.1        0.13 ± 61%  perf-profile.children.cycles-pp.set_next_buddy
      0.33 ± 28%      -0.1        0.22 ± 13%  perf-profile.children.cycles-pp.__might_fault
      0.24 ±  8%      -0.1        0.13 ± 59%  perf-profile.children.cycles-pp.clear_buddies
      0.17 ± 17%      -0.1        0.07 ± 61%  perf-profile.children.cycles-pp.__cgroup_account_cputime
      0.20 ±  9%      -0.1        0.10 ± 61%  perf-profile.children.cycles-pp.rb_insert_color
      0.32 ± 21%      -0.1        0.23 ± 10%  perf-profile.children.cycles-pp.syscall_enter_from_user_mode
      0.21 ±  7%      -0.1        0.13 ± 58%  perf-profile.children.cycles-pp.__wrgsbase_inactive
      0.15 ±  6%      -0.1        0.08 ± 57%  perf-profile.children.cycles-pp.perf_swevent_event
      0.09 ± 12%      -0.1        0.03 ±100%  perf-profile.children.cycles-pp.cgroup_rstat_updated
      0.14 ± 30%      -0.1        0.08 ± 19%  perf-profile.children.cycles-pp.timestamp_truncate
      0.10 ± 21%      -0.1        0.05 ± 58%  perf-profile.children.cycles-pp.find_next_bit
      0.09 ± 15%      -0.1        0.04 ± 58%  perf-profile.children.cycles-pp.rw_verify_area
      0.12 ± 16%      -0.0        0.08 ± 14%  perf-profile.children.cycles-pp.ktime_get_coarse_real_ts64
      0.27 ±  5%      -0.0        0.23 ±  3%  perf-profile.children.cycles-pp.__list_del_entry_valid
      0.00            +0.1        0.06 ± 26%  perf-profile.children.cycles-pp.kill_fasync
      0.12 ± 13%      +0.1        0.19 ± 18%  perf-profile.children.cycles-pp.ttwu_queue_wakelist
      0.00            +0.1        0.09 ± 27%  perf-profile.children.cycles-pp.llist_add_batch
      0.01 ±173%      +0.1        0.15 ± 47%  perf-profile.children.cycles-pp.flush_smp_call_function_from_idle
      0.34 ±  4%      +0.2        0.55 ± 16%  perf-profile.children.cycles-pp.sched_clock
      0.32 ±  4%      +0.2        0.54 ± 15%  perf-profile.children.cycles-pp.native_sched_clock
      0.37 ±  4%      +0.2        0.61 ± 18%  perf-profile.children.cycles-pp.sched_clock_cpu
      0.03 ± 77%      +0.3        0.31 ±117%  perf-profile.children.cycles-pp.do_softirq_own_stack
      0.03 ± 77%      +0.3        0.31 ±117%  perf-profile.children.cycles-pp.__softirqentry_text_start
      0.07 ±  7%      +0.3        0.39 ±111%  perf-profile.children.cycles-pp.irq_exit_rcu
      0.12 ±  9%      +0.5        0.58 ±124%  perf-profile.children.cycles-pp.ktime_get
      0.32 ± 47%      +0.7        1.02 ± 53%  perf-profile.children.cycles-pp.sched_ttwu_pending
      0.83 ±  9%      +0.9        1.75 ± 16%  perf-profile.children.cycles-pp.finish_task_switch
      0.24 ± 49%      +1.0        1.23 ± 46%  perf-profile.children.cycles-pp.schedule_idle
      0.73 ±  5%      +1.4        2.12 ±101%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      1.08 ± 11%      +1.8        2.83 ± 41%  perf-profile.children.cycles-pp.asm_call_sysvec_on_stack
      0.77 ±  5%      +2.0        2.78 ±112%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
      0.01 ±174%      +2.8        2.80 ±150%  perf-profile.children.cycles-pp.menu_select
      0.67 ± 76%     +10.3       11.01 ±104%  perf-profile.children.cycles-pp.intel_idle
      0.74 ± 75%     +14.2       14.98 ±116%  perf-profile.children.cycles-pp.cpuidle_enter_state
      0.74 ± 75%     +14.2       14.98 ±116%  perf-profile.children.cycles-pp.cpuidle_enter
      1.05 ± 68%     +18.5       19.53 ±116%  perf-profile.children.cycles-pp.start_secondary
      1.06 ± 67%     +18.5       19.60 ±115%  perf-profile.children.cycles-pp.do_idle
      1.06 ± 67%     +18.5       19.60 ±115%  perf-profile.children.cycles-pp.secondary_startup_64_no_verify
      1.06 ± 67%     +18.5       19.60 ±115%  perf-profile.children.cycles-pp.cpu_startup_entry
      1.46 ± 48%      -1.1        0.40 ± 42%  perf-profile.self.cycles-pp.available_idle_cpu
      1.23 ± 34%      -0.7        0.52 ± 52%  perf-profile.self.cycles-pp.select_idle_sibling
      1.28 ±  8%      -0.4        0.86 ± 46%  perf-profile.self.cycles-pp.update_curr
      0.76 ±  6%      -0.4        0.40 ± 34%  perf-profile.self.cycles-pp.reweight_entity
      1.07 ±  7%      -0.3        0.73 ± 18%  perf-profile.self.cycles-pp._raw_spin_lock
      0.95 ± 24%      -0.3        0.63 ± 12%  perf-profile.self.cycles-pp.syscall_return_via_sysret
      1.01 ±  5%      -0.3        0.70 ± 31%  perf-profile.self.cycles-pp.__update_load_avg_se
      0.52 ± 12%      -0.3        0.26 ± 62%  perf-profile.self.cycles-pp.__enqueue_entity
      0.89 ±  6%      -0.2        0.65 ± 29%  perf-profile.self.cycles-pp.__update_load_avg_cfs_rq
      0.71 ± 21%      -0.2        0.48 ± 15%  perf-profile.self.cycles-pp.___might_sleep
      0.93 ±  4%      -0.2        0.71 ± 22%  perf-profile.self.cycles-pp.__switch_to_asm
      0.49 ±  4%      -0.2        0.29 ± 59%  perf-profile.self.cycles-pp.___perf_sw_event
      0.72 ± 19%      -0.2        0.53 ± 10%  perf-profile.self.cycles-pp.common_file_perm
      0.71 ±  3%      -0.2        0.53 ±  6%  perf-profile.self.cycles-pp.update_rq_clock
      0.52 ±  7%      -0.2        0.35 ± 45%  perf-profile.self.cycles-pp.copy_fpregs_to_fpstate
      0.54 ± 14%      -0.2        0.37 ± 11%  perf-profile.self.cycles-pp.__might_sleep
      0.80 ±  3%      -0.2        0.63 ± 24%  perf-profile.self.cycles-pp.__switch_to
      0.58 ±  6%      -0.2        0.42 ± 29%  perf-profile.self.cycles-pp.enqueue_task_fair
      0.43 ±  4%      -0.2        0.27 ± 29%  perf-profile.self.cycles-pp.dequeue_task_fair
      0.62 ± 12%      -0.2        0.47 ± 13%  perf-profile.self.cycles-pp.vfs_read
      0.45 ±  7%      -0.1        0.30 ± 48%  perf-profile.self.cycles-pp.update_min_vruntime
      0.40 ±  6%      -0.1        0.26 ± 44%  perf-profile.self.cycles-pp.__calc_delta
      0.40 ± 16%      -0.1        0.26 ± 20%  perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.25 ± 13%      -0.1        0.12 ± 61%  perf-profile.self.cycles-pp.set_next_buddy
      0.21 ± 46%      -0.1        0.09 ± 59%  perf-profile.self.cycles-pp.cpumask_next_wrap
      0.32 ±  6%      -0.1        0.21 ± 28%  perf-profile.self.cycles-pp.pick_next_entity
      0.20 ±  9%      -0.1        0.10 ± 61%  perf-profile.self.cycles-pp.rb_insert_color
      0.21 ±  9%      -0.1        0.11 ± 59%  perf-profile.self.cycles-pp.clear_buddies
      0.30 ± 21%      -0.1        0.21 ±  9%  perf-profile.self.cycles-pp.syscall_enter_from_user_mode
      0.22 ± 15%      -0.1        0.13 ± 38%  perf-profile.self.cycles-pp.exit_to_user_mode_prepare
      0.31 ± 18%      -0.1        0.22 ± 10%  perf-profile.self.cycles-pp.copy_page_to_iter
      0.21 ±  7%      -0.1        0.13 ± 58%  perf-profile.self.cycles-pp.__wrgsbase_inactive
      0.19 ± 29%      -0.1        0.12 ± 21%  perf-profile.self.cycles-pp.current_time
      0.19 ±  5%      -0.1        0.12 ± 58%  perf-profile.self.cycles-pp.anon_pipe_buf_release
      0.09 ± 20%      -0.1        0.03 ±100%  perf-profile.self.cycles-pp.__cgroup_account_cputime
      0.08 ± 13%      -0.1        0.03 ±100%  perf-profile.self.cycles-pp.cgroup_rstat_updated
      0.12 ± 28%      -0.1        0.07 ± 15%  perf-profile.self.cycles-pp.timestamp_truncate
      0.08 ± 14%      -0.1        0.03 ±100%  perf-profile.self.cycles-pp.rw_verify_area
      0.19 ± 12%      -0.0        0.14 ± 13%  perf-profile.self.cycles-pp.ksys_read
      0.07 ± 11%      -0.0        0.03 ±100%  perf-profile.self.cycles-pp.find_next_bit
      0.10 ± 11%      -0.0        0.05 ± 61%  perf-profile.self.cycles-pp.wakeup_preempt_entity
      0.07 ±  6%      -0.0        0.04 ± 58%  perf-profile.self.cycles-pp.perf_swevent_event
      0.24 ±  4%      -0.0        0.22 ±  3%  perf-profile.self.cycles-pp.__list_del_entry_valid
      0.25 ± 13%      +0.1        0.32 ± 17%  perf-profile.self.cycles-pp.aa_file_perm
      0.01 ±173%      +0.1        0.09 ± 34%  perf-profile.self.cycles-pp.flush_smp_call_function_queue
      0.00            +0.1        0.09 ± 27%  perf-profile.self.cycles-pp.llist_add_batch
      1.58 ±  2%      +0.2        1.75 ±  4%  perf-profile.self.cycles-pp.__schedule
      0.30 ±  4%      +0.2        0.50 ± 13%  perf-profile.self.cycles-pp.native_sched_clock
      0.10 ± 10%      +0.4        0.49 ±125%  perf-profile.self.cycles-pp.ktime_get
      0.08 ± 49%      +0.6        0.63 ±119%  perf-profile.self.cycles-pp.__mutex_lock
      0.30 ± 10%      +0.6        0.88 ± 64%  perf-profile.self.cycles-pp.finish_task_switch
      0.00            +1.8        1.77 ±155%  perf-profile.self.cycles-pp.cpuidle_enter_state
      0.00            +2.4        2.37 ±152%  perf-profile.self.cycles-pp.menu_select
      0.67 ± 76%     +10.3       11.01 ±104%  perf-profile.self.cycles-pp.intel_idle
     31351 ± 12%     -35.9%      20103 ± 13%  softirqs.CPU0.RCU
     30180 ± 12%     -38.9%      18425 ±  7%  softirqs.CPU1.RCU
     29060 ± 10%     -36.6%      18435 ±  7%  softirqs.CPU10.RCU
     28973 ±  9%     -38.5%      17815 ±  8%  softirqs.CPU100.RCU
     28910 ± 10%     -38.4%      17820 ±  8%  softirqs.CPU101.RCU
     28751 ±  9%     -37.9%      17860 ±  9%  softirqs.CPU102.RCU
     28899 ± 10%     -36.5%      18337 ± 10%  softirqs.CPU103.RCU
     28939 ±  9%     -38.3%      17845 ±  8%  softirqs.CPU104.RCU
     28791 ±  9%     -38.0%      17848 ±  8%  softirqs.CPU105.RCU
     28812 ±  9%     -38.4%      17748 ±  8%  softirqs.CPU106.RCU
     28857 ±  9%     -37.6%      18013 ±  9%  softirqs.CPU107.RCU
     29082 ±  9%     -37.7%      18107 ±  9%  softirqs.CPU108.RCU
     28989 ±  9%     -38.1%      17956 ±  8%  softirqs.CPU109.RCU
     29414 ± 10%     -38.6%      18059 ±  7%  softirqs.CPU11.RCU
     28880 ±  9%     -37.7%      18000 ±  8%  softirqs.CPU110.RCU
     28737 ± 10%     -38.1%      17786 ±  8%  softirqs.CPU111.RCU
     29112 ± 10%     -38.6%      17862 ±  8%  softirqs.CPU112.RCU
     29119 ± 10%     -37.6%      18179 ± 10%  softirqs.CPU113.RCU
     29204 ±  9%     -39.2%      17758 ±  8%  softirqs.CPU114.RCU
     29189 ±  9%     -37.8%      18150 ±  6%  softirqs.CPU115.RCU
     29199 ±  9%     -38.8%      17872 ±  8%  softirqs.CPU116.RCU
     29242 ±  9%     -39.1%      17797 ±  8%  softirqs.CPU117.RCU
     29088 ±  9%     -39.0%      17740 ±  8%  softirqs.CPU118.RCU
     29040 ±  9%     -39.2%      17661 ±  8%  softirqs.CPU119.RCU
     28928 ± 10%     -36.8%      18272 ±  8%  softirqs.CPU12.RCU
     29405 ±  7%     -37.2%      18468 ±  8%  softirqs.CPU120.RCU
     29588 ±  7%     -37.2%      18567 ±  8%  softirqs.CPU121.RCU
     29393 ±  7%     -37.4%      18404 ±  8%  softirqs.CPU122.RCU
     29161 ±  7%     -36.5%      18516 ±  8%  softirqs.CPU123.RCU
     29332 ±  7%     -37.0%      18484 ±  8%  softirqs.CPU124.RCU
     29085 ±  7%     -37.1%      18292 ±  8%  softirqs.CPU125.RCU
     29024 ±  7%     -36.5%      18417 ±  9%  softirqs.CPU126.RCU
     29446 ±  8%     -36.8%      18617 ± 10%  softirqs.CPU127.RCU
     28800 ±  6%     -35.3%      18644 ± 11%  softirqs.CPU128.RCU
     28672 ±  7%     -36.0%      18349 ±  7%  softirqs.CPU129.RCU
     29306 ± 10%     -36.4%      18632 ±  8%  softirqs.CPU13.RCU
     29016 ±  6%     -36.4%      18452 ±  7%  softirqs.CPU130.RCU
     28927 ±  6%     -35.1%      18783 ±  8%  softirqs.CPU131.RCU
     29043 ±  7%     -38.5%      17863 ±  9%  softirqs.CPU132.RCU
     28256 ±  5%     -35.5%      18233 ±  7%  softirqs.CPU133.RCU
     28818 ±  7%     -36.5%      18295 ±  7%  softirqs.CPU134.RCU
     28743 ±  7%     -36.1%      18370 ±  7%  softirqs.CPU135.RCU
     29117 ±  8%     -36.3%      18544 ±  7%  softirqs.CPU136.RCU
     29105 ±  7%     -36.3%      18532 ±  7%  softirqs.CPU137.RCU
     29047 ±  6%     -36.4%      18486 ±  7%  softirqs.CPU138.RCU
     28118 ±  6%     -35.6%      18119 ±  8%  softirqs.CPU139.RCU
      5299 ±177%    -100.0%       0.00        softirqs.CPU14.NET_RX
     29229 ± 10%     -36.1%      18664 ±  7%  softirqs.CPU14.RCU
     28377 ±  8%     -35.3%      18348 ±  7%  softirqs.CPU140.RCU
     28864 ±  7%     -36.4%      18364 ±  7%  softirqs.CPU141.RCU
     28917 ±  7%     -36.2%      18446 ±  7%  softirqs.CPU142.RCU
     29133 ±  8%     -36.3%      18551 ±  7%  softirqs.CPU143.RCU
     29522 ±  9%     -37.8%      18359 ±  8%  softirqs.CPU144.RCU
     29215 ±  9%     -37.7%      18214 ±  8%  softirqs.CPU145.RCU
     29271 ±  9%     -37.0%      18427 ±  9%  softirqs.CPU146.RCU
     28811 ± 11%     -36.8%      18212 ±  9%  softirqs.CPU147.RCU
     29274 ±  9%     -36.7%      18544 ±  7%  softirqs.CPU148.RCU
     29473 ±  9%     -37.4%      18448 ±  9%  softirqs.CPU149.RCU
     29260 ±  9%     -37.5%      18273 ±  8%  softirqs.CPU15.RCU
     29410 ±  9%     -37.3%      18431 ±  9%  softirqs.CPU150.RCU
     29043 ±  9%     -37.0%      18283 ±  8%  softirqs.CPU151.RCU
     29434 ±  8%     -37.4%      18416 ±  8%  softirqs.CPU152.RCU
     29298 ±  8%     -37.6%      18279 ±  9%  softirqs.CPU153.RCU
     29359 ±  9%     -37.1%      18455 ±  9%  softirqs.CPU154.RCU
     29440 ±  9%     -37.7%      18346 ±  9%  softirqs.CPU155.RCU
     29069 ±  9%     -37.7%      18107 ±  9%  softirqs.CPU156.RCU
     29242 ±  9%     -37.7%      18215 ±  9%  softirqs.CPU157.RCU
     29731 ±  9%     -38.5%      18270 ±  9%  softirqs.CPU158.RCU
     29309 ±  8%     -37.3%      18369 ±  9%  softirqs.CPU159.RCU
      1869 ±199%    -100.0%       0.00        softirqs.CPU16.NET_RX
     29658 ± 10%     -35.0%      19265 ±  8%  softirqs.CPU16.RCU
     29436 ±  9%     -37.5%      18398 ±  9%  softirqs.CPU160.RCU
     29406 ±  9%     -36.5%      18661 ±  7%  softirqs.CPU161.RCU
     29529 ±  8%     -37.2%      18541 ±  8%  softirqs.CPU162.RCU
     29484 ±  9%     -37.1%      18556 ±  8%  softirqs.CPU163.RCU
     29296 ±  9%     -37.4%      18343 ±  9%  softirqs.CPU164.RCU
     29260 ±  9%     -37.3%      18348 ±  9%  softirqs.CPU165.RCU
     29236 ±  9%     -37.0%      18416 ±  9%  softirqs.CPU166.RCU
     29324 ±  9%     -37.0%      18476 ±  9%  softirqs.CPU167.RCU
     28460 ±  8%     -36.4%      18097 ±  6%  softirqs.CPU168.RCU
     28247 ±  8%     -37.7%      17588 ±  8%  softirqs.CPU169.RCU
     29853 ±  9%     -36.6%      18937 ± 11%  softirqs.CPU17.RCU
     28215 ±  8%     -37.7%      17571 ±  8%  softirqs.CPU170.RCU
     28305 ±  9%     -37.9%      17575 ±  8%  softirqs.CPU171.RCU
     28342 ±  8%     -38.0%      17565 ±  8%  softirqs.CPU172.RCU
     28230 ±  9%     -38.6%      17327 ± 11%  softirqs.CPU173.RCU
     28226 ±  9%     -37.2%      17733 ±  9%  softirqs.CPU174.RCU
     28319 ±  8%     -37.8%      17613 ±  8%  softirqs.CPU175.RCU
     28677 ±  8%     -37.3%      17984 ±  7%  softirqs.CPU176.RCU
     28881 ±  9%     -38.0%      17910 ±  7%  softirqs.CPU177.RCU
     28889 ±  8%     -38.1%      17896 ±  8%  softirqs.CPU178.RCU
     28812 ±  9%     -37.8%      17928 ±  8%  softirqs.CPU179.RCU
     29338 ± 11%     -38.5%      18051 ± 11%  softirqs.CPU18.RCU
     28956 ±  8%     -37.5%      18094 ±  8%  softirqs.CPU180.RCU
     28847 ±  8%     -37.2%      18127 ±  8%  softirqs.CPU181.RCU
     28801 ±  9%     -37.5%      17996 ±  7%  softirqs.CPU182.RCU
     28766 ±  8%     -37.5%      17967 ±  8%  softirqs.CPU183.RCU
     28939 ±  9%     -37.9%      17985 ±  7%  softirqs.CPU184.RCU
     28576 ±  8%     -37.7%      17798 ±  8%  softirqs.CPU185.RCU
     28914 ±  8%     -37.2%      18155 ±  8%  softirqs.CPU186.RCU
     28916 ±  9%     -37.1%      18193 ±  8%  softirqs.CPU187.RCU
     28709 ±  9%     -37.4%      17967 ±  8%  softirqs.CPU188.RCU
     28622 ±  9%     -36.9%      18048 ±  9%  softirqs.CPU189.RCU
     29532 ±  9%     -38.4%      18203 ±  8%  softirqs.CPU19.RCU
     28733 ±  8%     -37.7%      17895 ±  9%  softirqs.CPU190.RCU
     28334 ±  9%     -34.6%      18528 ±  7%  softirqs.CPU191.RCU
     29312 ± 10%     -37.4%      18335 ±  8%  softirqs.CPU2.RCU
     29638 ±  9%     -37.0%      18669 ± 10%  softirqs.CPU20.RCU
     29566 ±  9%     -38.5%      18170 ±  8%  softirqs.CPU21.RCU
     29802 ±  9%     -38.6%      18290 ±  8%  softirqs.CPU22.RCU
     29642 ±  9%     -39.2%      18030 ±  7%  softirqs.CPU23.RCU
     29557 ±  7%     -36.3%      18830 ±  8%  softirqs.CPU24.RCU
     29566 ±  7%     -36.5%      18767 ±  7%  softirqs.CPU25.RCU
     29706 ±  7%     -37.8%      18479 ±  8%  softirqs.CPU26.RCU
     29766 ±  8%     -37.4%      18639 ±  8%  softirqs.CPU27.RCU
     29430 ±  7%     -37.0%      18530 ±  9%  softirqs.CPU28.RCU
     29467 ±  7%     -37.3%      18475 ±  8%  softirqs.CPU29.RCU
     29627 ±  9%     -37.0%      18658 ±  8%  softirqs.CPU3.RCU
     29410 ±  7%     -36.9%      18547 ±  8%  softirqs.CPU30.RCU
     29316 ±  7%     -35.9%      18802 ±  6%  softirqs.CPU31.RCU
     28331 ±  8%     -35.3%      18331 ±  6%  softirqs.CPU32.RCU
     28364 ±  6%     -36.3%      18066 ±  7%  softirqs.CPU33.RCU
     28611 ±  6%     -36.6%      18132 ±  7%  softirqs.CPU34.RCU
     28659 ±  6%     -35.3%      18535 ±  7%  softirqs.CPU35.RCU
     28711 ±  6%     -36.4%      18261 ±  7%  softirqs.CPU36.RCU
     28669 ±  6%     -36.3%      18272 ±  7%  softirqs.CPU37.RCU
     28769 ±  6%     -36.6%      18244 ±  7%  softirqs.CPU38.RCU
     28454 ±  6%     -36.1%      18169 ±  8%  softirqs.CPU39.RCU
     29322 ± 10%     -37.3%      18383 ±  8%  softirqs.CPU4.RCU
     28686 ±  7%     -36.5%      18224 ±  8%  softirqs.CPU40.RCU
     28873 ±  6%     -36.5%      18333 ±  8%  softirqs.CPU41.RCU
     28702 ±  6%     -36.0%      18367 ±  8%  softirqs.CPU42.RCU
     28831 ±  8%     -36.6%      18288 ±  7%  softirqs.CPU43.RCU
     28419 ±  6%     -36.7%      17994 ±  7%  softirqs.CPU44.RCU
     28573 ±  6%     -36.7%      18100 ±  7%  softirqs.CPU45.RCU
     28607 ±  6%     -35.8%      18353 ±  7%  softirqs.CPU46.RCU
     28835 ±  6%     -36.5%      18303 ±  8%  softirqs.CPU47.RCU
     30463 ±  9%     -38.4%      18763 ±  7%  softirqs.CPU48.RCU
     30299 ±  9%     -37.8%      18835 ±  7%  softirqs.CPU49.RCU
     28991 ± 10%     -37.4%      18137 ±  7%  softirqs.CPU5.RCU
     30202 ±  9%     -38.2%      18651 ±  9%  softirqs.CPU50.RCU
     30569 ±  9%     -38.3%      18855 ±  8%  softirqs.CPU51.RCU
     30507 ±  9%     -38.5%      18775 ±  9%  softirqs.CPU52.RCU
     30682 ±  9%     -38.6%      18826 ±  9%  softirqs.CPU53.RCU
     30624 ±  9%     -38.1%      18943 ±  9%  softirqs.CPU54.RCU
     30425 ±  9%     -38.7%      18646 ±  9%  softirqs.CPU55.RCU
     30362 ±  9%     -38.3%      18737 ±  9%  softirqs.CPU56.RCU
     30383 ±  9%     -38.8%      18590 ±  9%  softirqs.CPU57.RCU
     30498 ±  9%     -38.4%      18799 ±  9%  softirqs.CPU58.RCU
     30551 ±  9%     -38.5%      18796 ±  9%  softirqs.CPU59.RCU
     28931 ±  9%     -36.8%      18286 ±  8%  softirqs.CPU6.RCU
     30423 ±  9%     -38.8%      18609 ±  9%  softirqs.CPU60.RCU
     30378 ±  9%     -38.6%      18642 ±  8%  softirqs.CPU61.RCU
     30269 ±  9%     -38.8%      18520 ±  9%  softirqs.CPU62.RCU
     30185 ±  9%     -38.3%      18618 ±  9%  softirqs.CPU63.RCU
     30264 ±  9%     -37.1%      19050 ±  9%  softirqs.CPU64.RCU
     30110 ±  9%     -37.1%      18932 ±  9%  softirqs.CPU65.RCU
     30773 ±  8%     -37.7%      19160 ±  8%  softirqs.CPU66.RCU
     30501 ±  9%     -37.4%      19106 ±  8%  softirqs.CPU67.RCU
     30256 ±  8%     -37.5%      18902 ±  9%  softirqs.CPU68.RCU
     30332 ±  8%     -37.4%      18974 ±  8%  softirqs.CPU69.RCU
     29367 ± 10%     -36.1%      18777 ± 10%  softirqs.CPU7.RCU
     30172 ±  9%     -37.0%      19023 ±  9%  softirqs.CPU70.RCU
     30588 ±  9%     -37.9%      19004 ±  9%  softirqs.CPU71.RCU
     29699 ±  8%     -35.1%      19282 ±  7%  softirqs.CPU72.RCU
     29291 ±  8%     -37.7%      18245 ±  8%  softirqs.CPU73.RCU
     29110 ±  8%     -36.8%      18405 ±  9%  softirqs.CPU74.RCU
     29054 ±  8%     -37.3%      18210 ±  8%  softirqs.CPU75.RCU
     29056 ±  8%     -37.7%      18100 ±  8%  softirqs.CPU76.RCU
     29116 ±  8%     -38.3%      17974 ±  9%  softirqs.CPU77.RCU
     29140 ±  8%     -37.6%      18192 ±  8%  softirqs.CPU78.RCU
     29206 ±  9%     -37.8%      18164 ±  8%  softirqs.CPU79.RCU
     29385 ± 10%     -37.8%      18286 ±  8%  softirqs.CPU8.RCU
     28867 ±  8%     -36.3%      18383 ±  8%  softirqs.CPU80.RCU
     28846 ±  8%     -36.5%      18316 ±  8%  softirqs.CPU81.RCU
     28859 ±  8%     -35.3%      18674 ± 10%  softirqs.CPU82.RCU
     29002 ±  8%     -37.1%      18241 ±  8%  softirqs.CPU83.RCU
     29053 ±  8%     -36.9%      18330 ±  8%  softirqs.CPU84.RCU
     29048 ±  8%     -37.1%      18280 ±  8%  softirqs.CPU85.RCU
     28868 ±  8%     -36.7%      18278 ±  7%  softirqs.CPU86.RCU
     28939 ±  9%     -36.5%      18383 ±  8%  softirqs.CPU87.RCU
     29176 ±  9%     -37.3%      18281 ±  8%  softirqs.CPU88.RCU
     29127 ±  9%     -37.3%      18255 ±  8%  softirqs.CPU89.RCU
     29101 ±  9%     -37.1%      18297 ±  8%  softirqs.CPU9.RCU
     29058 ±  9%     -37.0%      18315 ±  8%  softirqs.CPU90.RCU
     29049 ±  9%     -36.7%      18393 ±  8%  softirqs.CPU91.RCU
     28872 ±  9%     -32.8%      19396 ± 16%  softirqs.CPU92.RCU
     28782 ±  8%     -36.7%      18213 ±  8%  softirqs.CPU93.RCU
     28844 ±  9%     -37.2%      18115 ±  7%  softirqs.CPU94.RCU
     28828 ±  8%     -36.5%      18316 ±  8%  softirqs.CPU95.RCU
     29304 ±  8%     -38.4%      18041 ±  7%  softirqs.CPU96.RCU
     28771 ± 11%     -36.1%      18397 ±  6%  softirqs.CPU97.RCU
     28918 ±  9%     -37.6%      18033 ±  8%  softirqs.CPU98.RCU
     28970 ±  9%     -37.7%      18060 ±  8%  softirqs.CPU99.RCU
   5610692 ±  8%     -37.2%    3520779 ±  8%  softirqs.RCU
     45173 ±  5%     -30.4%      31448 ±  5%  softirqs.TIMER
    972.88 ± 91%    -100.0%       0.00        interrupts.170:PCI-MSI.524289-edge.eth0-TxRx-0
      9984 ±174%    -100.0%       0.00        interrupts.171:PCI-MSI.524290-edge.eth0-TxRx-1
      2684 ±130%    -100.0%       0.00        interrupts.172:PCI-MSI.524291-edge.eth0-TxRx-2
      3306 ±200%    -100.0%       0.00        interrupts.173:PCI-MSI.524292-edge.eth0-TxRx-3
    332.50 ±  2%     -31.7%     227.00 ±  2%  interrupts.9:IO-APIC.9-fasteoi.acpi
  56431209 ±  7%     -50.2%   28124418 ± 10%  interrupts.CAL:Function_call_interrupts
    344969 ± 12%     -39.8%     207676 ± 12%  interrupts.CPU0.CAL:Function_call_interrupts
    327871 ±  4%     -31.0%     226377 ±  2%  interrupts.CPU0.LOC:Local_timer_interrupts
      7410 ± 26%     -67.0%       2446 ± 70%  interrupts.CPU0.NMI:Non-maskable_interrupts
      7410 ± 26%     -67.0%       2446 ± 70%  interrupts.CPU0.PMI:Performance_monitoring_interrupts
   1030244 ± 12%     -57.5%     437927 ± 22%  interrupts.CPU0.RES:Rescheduling_interrupts
    257608 ±  8%     -60.8%     100991 ±  8%  interrupts.CPU0.TLB:TLB_shootdowns
    332.50 ±  2%     -31.7%     227.00 ±  2%  interrupts.CPU1.9:IO-APIC.9-fasteoi.acpi
    333049 ± 12%     -54.9%     150312 ± 19%  interrupts.CPU1.CAL:Function_call_interrupts
    325522 ±  5%     -30.4%     226464 ±  2%  interrupts.CPU1.LOC:Local_timer_interrupts
      7923 ± 19%     -71.8%       2233 ± 82%  interrupts.CPU1.NMI:Non-maskable_interrupts
      7923 ± 19%     -71.8%       2233 ± 82%  interrupts.CPU1.PMI:Performance_monitoring_interrupts
    945769 ± 15%     -45.5%     515869 ± 28%  interrupts.CPU1.RES:Rescheduling_interrupts
    257965 ±  8%     -60.5%     101776 ±  8%  interrupts.CPU1.TLB:TLB_shootdowns
    284308 ± 11%     -47.2%     150090 ± 24%  interrupts.CPU10.CAL:Function_call_interrupts
    328119 ±  4%     -31.0%     226527 ±  2%  interrupts.CPU10.LOC:Local_timer_interrupts
      7408 ± 26%     -67.2%       2430 ± 71%  interrupts.CPU10.NMI:Non-maskable_interrupts
      7408 ± 26%     -67.2%       2430 ± 71%  interrupts.CPU10.PMI:Performance_monitoring_interrupts
   1063093 ± 11%     -55.7%     470654 ± 34%  interrupts.CPU10.RES:Rescheduling_interrupts
    257678 ±  8%     -60.8%     100896 ±  9%  interrupts.CPU10.TLB:TLB_shootdowns
    304328 ± 14%     -53.0%     143085 ±  7%  interrupts.CPU100.CAL:Function_call_interrupts
    327933 ±  4%     -31.0%     226309 ±  2%  interrupts.CPU100.LOC:Local_timer_interrupts
      8399 ±  3%     -71.2%       2422 ± 71%  interrupts.CPU100.NMI:Non-maskable_interrupts
      8399 ±  3%     -71.2%       2422 ± 71%  interrupts.CPU100.PMI:Performance_monitoring_interrupts
    991319 ± 12%     -52.5%     471290 ± 19%  interrupts.CPU100.RES:Rescheduling_interrupts
    257973 ±  8%     -61.2%     100045 ±  9%  interrupts.CPU100.TLB:TLB_shootdowns
    302580 ± 17%     -57.1%     129755 ± 20%  interrupts.CPU101.CAL:Function_call_interrupts
    328146 ±  4%     -31.0%     226467 ±  2%  interrupts.CPU101.LOC:Local_timer_interrupts
      8401 ±  3%     -76.6%       1963 ± 77%  interrupts.CPU101.NMI:Non-maskable_interrupts
      8401 ±  3%     -76.6%       1963 ± 77%  interrupts.CPU101.PMI:Performance_monitoring_interrupts
   1047233 ± 11%     -55.0%     471399 ± 32%  interrupts.CPU101.RES:Rescheduling_interrupts
    258163 ±  8%     -61.9%      98395 ±  9%  interrupts.CPU101.TLB:TLB_shootdowns
    291861 ± 12%     -51.0%     142870 ± 13%  interrupts.CPU102.CAL:Function_call_interrupts
    328185 ±  4%     -31.0%     226512 ±  2%  interrupts.CPU102.LOC:Local_timer_interrupts
      8399 ±  3%     -76.9%       1938 ± 79%  interrupts.CPU102.NMI:Non-maskable_interrupts
      8399 ±  3%     -76.9%       1938 ± 79%  interrupts.CPU102.PMI:Performance_monitoring_interrupts
   1060656 ± 19%     -57.2%     453709 ± 34%  interrupts.CPU102.RES:Rescheduling_interrupts
    258371 ±  8%     -61.3%      99867 ±  9%  interrupts.CPU102.TLB:TLB_shootdowns
    292106 ± 13%     -49.5%     147368 ± 25%  interrupts.CPU103.CAL:Function_call_interrupts
    328054 ±  4%     -31.0%     226485 ±  2%  interrupts.CPU103.LOC:Local_timer_interrupts
      8407 ±  3%     -76.7%       1963 ± 79%  interrupts.CPU103.NMI:Non-maskable_interrupts
      8407 ±  3%     -76.7%       1963 ± 79%  interrupts.CPU103.PMI:Performance_monitoring_interrupts
   1104428 ± 10%     -56.5%     480820 ± 13%  interrupts.CPU103.RES:Rescheduling_interrupts
    258094 ±  8%     -60.9%     100968 ±  8%  interrupts.CPU103.TLB:TLB_shootdowns
    315218 ± 15%     -50.0%     157626 ± 18%  interrupts.CPU104.CAL:Function_call_interrupts
    328253 ±  4%     -31.1%     226257 ±  2%  interrupts.CPU104.LOC:Local_timer_interrupts
      7860 ± 17%     -75.1%       1954 ± 80%  interrupts.CPU104.NMI:Non-maskable_interrupts
      7860 ± 17%     -75.1%       1954 ± 80%  interrupts.CPU104.PMI:Performance_monitoring_interrupts
   1037770 ± 11%     -52.9%     488886 ± 31%  interrupts.CPU104.RES:Rescheduling_interrupts
    258328 ±  8%     -60.8%     101360 ±  9%  interrupts.CPU104.TLB:TLB_shootdowns
    290824 ±  8%     -52.6%     137900 ±  9%  interrupts.CPU105.CAL:Function_call_interrupts
    328279 ±  4%     -31.0%     226465 ±  2%  interrupts.CPU105.LOC:Local_timer_interrupts
      7390 ± 25%     -73.5%       1956 ± 79%  interrupts.CPU105.NMI:Non-maskable_interrupts
      7390 ± 25%     -73.5%       1956 ± 79%  interrupts.CPU105.PMI:Performance_monitoring_interrupts
   1075707 ± 11%     -55.1%     482742 ± 19%  interrupts.CPU105.RES:Rescheduling_interrupts
    257822 ±  8%     -60.5%     101826 ±  9%  interrupts.CPU105.TLB:TLB_shootdowns
    291762 ± 14%     -43.3%     165476 ± 32%  interrupts.CPU106.CAL:Function_call_interrupts
    328104 ±  4%     -31.0%     226496 ±  2%  interrupts.CPU106.LOC:Local_timer_interrupts
      7862 ± 17%     -75.1%       1961 ± 79%  interrupts.CPU106.NMI:Non-maskable_interrupts
      7862 ± 17%     -75.1%       1961 ± 79%  interrupts.CPU106.PMI:Performance_monitoring_interrupts
   1078729 ± 11%     -55.8%     477185 ± 29%  interrupts.CPU106.RES:Rescheduling_interrupts
    258996 ±  8%     -60.7%     101704 ±  9%  interrupts.CPU106.TLB:TLB_shootdowns
    282632 ± 11%     -52.1%     135323 ± 24%  interrupts.CPU107.CAL:Function_call_interrupts
    328282 ±  4%     -31.0%     226465 ±  2%  interrupts.CPU107.LOC:Local_timer_interrupts
      7862 ± 17%     -75.1%       1958 ± 79%  interrupts.CPU107.NMI:Non-maskable_interrupts
      7862 ± 17%     -75.1%       1958 ± 79%  interrupts.CPU107.PMI:Performance_monitoring_interrupts
    995251 ± 13%     -55.8%     439566 ± 18%  interrupts.CPU107.RES:Rescheduling_interrupts
    258320 ±  8%     -60.9%     100912 ±  9%  interrupts.CPU107.TLB:TLB_shootdowns
    309909 ± 13%     -63.1%     114509 ± 18%  interrupts.CPU108.CAL:Function_call_interrupts
    328098 ±  4%     -31.0%     226480 ±  2%  interrupts.CPU108.LOC:Local_timer_interrupts
      7315 ± 23%     -73.2%       1962 ± 79%  interrupts.CPU108.NMI:Non-maskable_interrupts
      7315 ± 23%     -73.2%       1962 ± 79%  interrupts.CPU108.PMI:Performance_monitoring_interrupts
   1071940 ±  5%     -55.5%     477150 ± 31%  interrupts.CPU108.RES:Rescheduling_interrupts
    257943 ±  8%     -60.8%     101233 ± 10%  interrupts.CPU108.TLB:TLB_shootdowns
    272870 ± 10%     -48.9%     139492 ± 16%  interrupts.CPU109.CAL:Function_call_interrupts
    328321 ±  4%     -31.0%     226449 ±  2%  interrupts.CPU109.LOC:Local_timer_interrupts
      7319 ± 23%     -69.3%       2247 ± 82%  interrupts.CPU109.NMI:Non-maskable_interrupts
      7319 ± 23%     -69.3%       2247 ± 82%  interrupts.CPU109.PMI:Performance_monitoring_interrupts
   1008976 ±  8%     -57.2%     431846 ± 21%  interrupts.CPU109.RES:Rescheduling_interrupts
    257919 ±  8%     -61.2%     100009 ±  9%  interrupts.CPU109.TLB:TLB_shootdowns
    281236 ±  9%     -58.3%     117395 ± 15%  interrupts.CPU11.CAL:Function_call_interrupts
    328299 ±  4%     -31.0%     226494 ±  2%  interrupts.CPU11.LOC:Local_timer_interrupts
      7406 ± 26%     -67.2%       2427 ± 71%  interrupts.CPU11.NMI:Non-maskable_interrupts
      7406 ± 26%     -67.2%       2427 ± 71%  interrupts.CPU11.PMI:Performance_monitoring_interrupts
   1024948 ± 10%     -56.2%     448543 ± 18%  interrupts.CPU11.RES:Rescheduling_interrupts
    257784 ±  8%     -60.5%     101796 ± 10%  interrupts.CPU11.TLB:TLB_shootdowns
    308206 ± 23%     -57.9%     129807 ± 21%  interrupts.CPU110.CAL:Function_call_interrupts
    328265 ±  4%     -31.0%     226488 ±  2%  interrupts.CPU110.LOC:Local_timer_interrupts
      8400 ±  3%     -76.6%       1964 ± 78%  interrupts.CPU110.NMI:Non-maskable_interrupts
      8400 ±  3%     -76.6%       1964 ± 78%  interrupts.CPU110.PMI:Performance_monitoring_interrupts
   1077188 ±  8%     -50.1%     537841 ± 23%  interrupts.CPU110.RES:Rescheduling_interrupts
    257714 ±  8%     -61.0%     100514 ±  9%  interrupts.CPU110.TLB:TLB_shootdowns
    307496 ±  9%     -51.9%     148021 ± 23%  interrupts.CPU111.CAL:Function_call_interrupts
    328482 ±  3%     -31.0%     226508 ±  2%  interrupts.CPU111.LOC:Local_timer_interrupts
      7315 ± 23%     -73.3%       1953 ± 79%  interrupts.CPU111.NMI:Non-maskable_interrupts
      7315 ± 23%     -73.3%       1953 ± 79%  interrupts.CPU111.PMI:Performance_monitoring_interrupts
   1044697 ± 10%     -53.1%     490195 ± 28%  interrupts.CPU111.RES:Rescheduling_interrupts
    258148 ±  8%     -61.1%     100485 ±  9%  interrupts.CPU111.TLB:TLB_shootdowns
    281837 ± 17%     -56.7%     121957 ± 16%  interrupts.CPU112.CAL:Function_call_interrupts
    328242 ±  4%     -31.0%     226514 ±  2%  interrupts.CPU112.LOC:Local_timer_interrupts
      8401 ±  3%     -76.8%       1949 ± 79%  interrupts.CPU112.NMI:Non-maskable_interrupts
      8401 ±  3%     -76.8%       1949 ± 79%  interrupts.CPU112.PMI:Performance_monitoring_interrupts
   1066811 ±  7%     -59.8%     428973 ± 24%  interrupts.CPU112.RES:Rescheduling_interrupts
    257987 ±  8%     -60.3%     102322 ± 10%  interrupts.CPU112.TLB:TLB_shootdowns
    266879 ± 13%     -43.5%     150693 ± 20%  interrupts.CPU113.CAL:Function_call_interrupts
    328392 ±  3%     -31.0%     226514 ±  2%  interrupts.CPU113.LOC:Local_timer_interrupts
      7866 ± 17%     -75.2%       1949 ± 79%  interrupts.CPU113.NMI:Non-maskable_interrupts
      7866 ± 17%     -75.2%       1949 ± 79%  interrupts.CPU113.PMI:Performance_monitoring_interrupts
   1010868 ±  8%     -54.0%     464563 ± 33%  interrupts.CPU113.RES:Rescheduling_interrupts
    258696 ±  8%     -61.2%     100352 ±  9%  interrupts.CPU113.TLB:TLB_shootdowns
    272385 ±  9%     -52.1%     130457 ± 14%  interrupts.CPU114.CAL:Function_call_interrupts
    328428 ±  3%     -31.0%     226513 ±  2%  interrupts.CPU114.LOC:Local_timer_interrupts
      7886 ± 18%     -77.7%       1762 ± 92%  interrupts.CPU114.NMI:Non-maskable_interrupts
      7886 ± 18%     -77.7%       1762 ± 92%  interrupts.CPU114.PMI:Performance_monitoring_interrupts
   1033951 ± 13%     -49.6%     521007 ± 34%  interrupts.CPU114.RES:Rescheduling_interrupts
    258084 ±  8%     -61.1%     100346 ±  9%  interrupts.CPU114.TLB:TLB_shootdowns
    279416 ± 11%     -47.7%     146051 ± 12%  interrupts.CPU115.CAL:Function_call_interrupts
    328240 ±  4%     -31.0%     226489 ±  2%  interrupts.CPU115.LOC:Local_timer_interrupts
      8401 ±  3%     -76.7%       1960 ± 78%  interrupts.CPU115.NMI:Non-maskable_interrupts
      8401 ±  3%     -76.7%       1960 ± 78%  interrupts.CPU115.PMI:Performance_monitoring_interrupts
   1024106 ± 11%     -52.4%     487029 ± 28%  interrupts.CPU115.RES:Rescheduling_interrupts
    257987 ±  8%     -60.9%     100800 ±  9%  interrupts.CPU115.TLB:TLB_shootdowns
    287971 ± 12%     -50.9%     141280 ± 24%  interrupts.CPU116.CAL:Function_call_interrupts
    328105 ±  4%     -31.0%     226430 ±  2%  interrupts.CPU116.LOC:Local_timer_interrupts
      8412 ±  3%     -71.1%       2427 ± 70%  interrupts.CPU116.NMI:Non-maskable_interrupts
      8412 ±  3%     -71.1%       2427 ± 70%  interrupts.CPU116.PMI:Performance_monitoring_interrupts
   1047073 ± 14%     -58.4%     435809 ± 26%  interrupts.CPU116.RES:Rescheduling_interrupts
    258022 ±  8%     -61.2%     100225 ±  9%  interrupts.CPU116.TLB:TLB_shootdowns
    285809 ± 11%     -54.7%     129370 ± 20%  interrupts.CPU117.CAL:Function_call_interrupts
    328304 ±  4%     -31.0%     226478 ±  2%  interrupts.CPU117.LOC:Local_timer_interrupts
      8408 ±  3%     -77.7%       1879 ± 71%  interrupts.CPU117.NMI:Non-maskable_interrupts
      8408 ±  3%     -77.7%       1879 ± 71%  interrupts.CPU117.PMI:Performance_monitoring_interrupts
   1054831 ±  9%     -43.7%     594331 ± 27%  interrupts.CPU117.RES:Rescheduling_interrupts
    258157 ±  8%     -61.4%      99627 ±  9%  interrupts.CPU117.TLB:TLB_shootdowns
    294131 ± 10%     -45.4%     160709 ± 38%  interrupts.CPU118.CAL:Function_call_interrupts
    328513 ±  3%     -31.1%     226477 ±  2%  interrupts.CPU118.LOC:Local_timer_interrupts
      7895 ± 18%     -82.1%       1409 ± 59%  interrupts.CPU118.NMI:Non-maskable_interrupts
      7895 ± 18%     -82.1%       1409 ± 59%  interrupts.CPU118.PMI:Performance_monitoring_interrupts
    995055 ± 10%     -53.8%     459356 ± 22%  interrupts.CPU118.RES:Rescheduling_interrupts
    258172 ±  8%     -60.7%     101376 ±  9%  interrupts.CPU118.TLB:TLB_shootdowns
    296482 ± 12%     -55.1%     133134 ± 12%  interrupts.CPU119.CAL:Function_call_interrupts
    328202 ±  4%     -31.0%     226505 ±  2%  interrupts.CPU119.LOC:Local_timer_interrupts
      7321 ± 23%     -80.6%       1419 ± 59%  interrupts.CPU119.NMI:Non-maskable_interrupts
      7321 ± 23%     -80.6%       1419 ± 59%  interrupts.CPU119.PMI:Performance_monitoring_interrupts
   1015954 ± 10%     -57.7%     429505 ± 22%  interrupts.CPU119.RES:Rescheduling_interrupts
    257514 ±  8%     -60.8%     100946 ±  9%  interrupts.CPU119.TLB:TLB_shootdowns
    276018 ± 13%     -47.7%     144494 ± 33%  interrupts.CPU12.CAL:Function_call_interrupts
    328091 ±  4%     -31.0%     226479 ±  2%  interrupts.CPU12.LOC:Local_timer_interrupts
      7915 ± 19%     -69.3%       2429 ± 71%  interrupts.CPU12.NMI:Non-maskable_interrupts
      7915 ± 19%     -69.3%       2429 ± 71%  interrupts.CPU12.PMI:Performance_monitoring_interrupts
   1074262 ±  7%     -55.6%     477000 ± 29%  interrupts.CPU12.RES:Rescheduling_interrupts
    257933 ±  8%     -61.0%     100488 ±  9%  interrupts.CPU12.TLB:TLB_shootdowns
    303497 ±  9%     -42.8%     173624 ± 21%  interrupts.CPU120.CAL:Function_call_interrupts
    329334 ±  3%     -31.2%     226474 ±  2%  interrupts.CPU120.LOC:Local_timer_interrupts
      6308 ± 32%     -77.8%       1398 ± 57%  interrupts.CPU120.NMI:Non-maskable_interrupts
      6308 ± 32%     -77.8%       1398 ± 57%  interrupts.CPU120.PMI:Performance_monitoring_interrupts
    918449 ± 15%     -48.2%     476052 ±  6%  interrupts.CPU120.RES:Rescheduling_interrupts
    257575 ±  8%     -61.6%      98884 ±  9%  interrupts.CPU120.TLB:TLB_shootdowns
    299611 ± 14%     -54.3%     136839 ± 13%  interrupts.CPU121.CAL:Function_call_interrupts
    329228 ±  3%     -31.2%     226470 ±  2%  interrupts.CPU121.LOC:Local_timer_interrupts
      7391 ± 25%     -83.7%       1204 ± 69%  interrupts.CPU121.NMI:Non-maskable_interrupts
      7391 ± 25%     -83.7%       1204 ± 69%  interrupts.CPU121.PMI:Performance_monitoring_interrupts
    952284 ± 14%     -43.3%     539757 ± 18%  interrupts.CPU121.RES:Rescheduling_interrupts
    257840 ±  8%     -61.5%      99327 ±  9%  interrupts.CPU121.TLB:TLB_shootdowns
    322333 ± 12%     -52.2%     154058 ±  9%  interrupts.CPU122.CAL:Function_call_interrupts
    329288 ±  3%     -31.2%     226451 ±  2%  interrupts.CPU122.LOC:Local_timer_interrupts
      7405 ± 25%     -81.1%       1398 ± 55%  interrupts.CPU122.NMI:Non-maskable_interrupts
      7405 ± 25%     -81.1%       1398 ± 55%  interrupts.CPU122.PMI:Performance_monitoring_interrupts
    961796 ± 12%     -51.4%     467163 ± 23%  interrupts.CPU122.RES:Rescheduling_interrupts
    258089 ±  8%     -61.7%      98876 ±  9%  interrupts.CPU122.TLB:TLB_shootdowns
    290729 ±  9%     -44.4%     161595 ±  6%  interrupts.CPU123.CAL:Function_call_interrupts
    329342 ±  3%     -31.3%     226391 ±  2%  interrupts.CPU123.LOC:Local_timer_interrupts
      7889 ± 17%     -82.3%       1394 ± 56%  interrupts.CPU123.NMI:Non-maskable_interrupts
      7889 ± 17%     -82.3%       1394 ± 56%  interrupts.CPU123.PMI:Performance_monitoring_interrupts
    928180 ± 13%     -47.9%     483522 ±  7%  interrupts.CPU123.RES:Rescheduling_interrupts
    257528 ±  8%     -61.6%      98764 ±  8%  interrupts.CPU123.TLB:TLB_shootdowns
    288221 ± 14%     -54.1%     132347 ± 19%  interrupts.CPU124.CAL:Function_call_interrupts
    329450 ±  3%     -31.3%     226332 ±  2%  interrupts.CPU124.LOC:Local_timer_interrupts
      7895 ± 17%     -82.4%       1390 ± 57%  interrupts.CPU124.NMI:Non-maskable_interrupts
      7895 ± 17%     -82.4%       1390 ± 57%  interrupts.CPU124.PMI:Performance_monitoring_interrupts
    925478 ± 10%     -42.9%     528114 ±  8%  interrupts.CPU124.RES:Rescheduling_interrupts
    257802 ±  8%     -61.4%      99431 ±  9%  interrupts.CPU124.TLB:TLB_shootdowns
    294022 ±  9%     -55.1%     131965 ± 12%  interrupts.CPU125.CAL:Function_call_interrupts
    329172 ±  3%     -31.2%     226496 ±  2%  interrupts.CPU125.LOC:Local_timer_interrupts
      7372 ± 24%     -81.1%       1396 ± 57%  interrupts.CPU125.NMI:Non-maskable_interrupts
      7372 ± 24%     -81.1%       1396 ± 57%  interrupts.CPU125.PMI:Performance_monitoring_interrupts
   1026100 ± 18%     -43.7%     577219 ±  8%  interrupts.CPU125.RES:Rescheduling_interrupts
    257902 ±  8%     -61.8%      98549 ±  9%  interrupts.CPU125.TLB:TLB_shootdowns
    284948 ± 11%     -50.9%     139811 ± 14%  interrupts.CPU126.CAL:Function_call_interrupts
    329243 ±  3%     -31.2%     226409 ±  2%  interrupts.CPU126.LOC:Local_timer_interrupts
      7343 ± 23%     -80.8%       1408 ± 55%  interrupts.CPU126.NMI:Non-maskable_interrupts
      7343 ± 23%     -80.8%       1408 ± 55%  interrupts.CPU126.PMI:Performance_monitoring_interrupts
    942100 ± 13%     -39.4%     571182 ± 21%  interrupts.CPU126.RES:Rescheduling_interrupts
    257785 ±  8%     -61.1%     100329 ±  8%  interrupts.CPU126.TLB:TLB_shootdowns
    293825 ±  9%     -47.0%     155800 ± 13%  interrupts.CPU127.CAL:Function_call_interrupts
    329377 ±  3%     -31.2%     226453 ±  2%  interrupts.CPU127.LOC:Local_timer_interrupts
      7393 ± 24%     -74.8%       1861 ± 71%  interrupts.CPU127.NMI:Non-maskable_interrupts
      7393 ± 24%     -74.8%       1861 ± 71%  interrupts.CPU127.PMI:Performance_monitoring_interrupts
    867576 ± 14%     -31.4%     595150 ± 14%  interrupts.CPU127.RES:Rescheduling_interrupts
    257825 ±  8%     -61.5%      99176 ±  9%  interrupts.CPU127.TLB:TLB_shootdowns
    299248 ± 10%     -41.8%     174117 ± 25%  interrupts.CPU128.CAL:Function_call_interrupts
    329354 ±  3%     -31.2%     226463 ±  2%  interrupts.CPU128.LOC:Local_timer_interrupts
      8436 ±  3%     -77.7%       1881 ± 70%  interrupts.CPU128.NMI:Non-maskable_interrupts
      8436 ±  3%     -77.7%       1881 ± 70%  interrupts.CPU128.PMI:Performance_monitoring_interrupts
    954047 ± 14%     -42.6%     547424 ±  4%  interrupts.CPU128.RES:Rescheduling_interrupts
    258038 ±  8%     -61.9%      98213 ± 10%  interrupts.CPU128.TLB:TLB_shootdowns
    311750 ± 14%     -49.0%     158993 ± 12%  interrupts.CPU129.CAL:Function_call_interrupts
    329280 ±  3%     -31.2%     226407 ±  2%  interrupts.CPU129.LOC:Local_timer_interrupts
      7344 ± 23%     -67.3%       2404 ± 69%  interrupts.CPU129.NMI:Non-maskable_interrupts
      7344 ± 23%     -67.3%       2404 ± 69%  interrupts.CPU129.PMI:Performance_monitoring_interrupts
    979000 ± 13%     -43.3%     555050 ± 16%  interrupts.CPU129.RES:Rescheduling_interrupts
    257878 ±  8%     -62.0%      98039 ±  9%  interrupts.CPU129.TLB:TLB_shootdowns
    972.88 ± 91%    -100.0%       0.00        interrupts.CPU13.170:PCI-MSI.524289-edge.eth0-TxRx-0
    272050 ± 11%     -47.0%     144250 ± 17%  interrupts.CPU13.CAL:Function_call_interrupts
    328108 ±  4%     -31.0%     226457 ±  2%  interrupts.CPU13.LOC:Local_timer_interrupts
      7918 ± 19%     -69.1%       2443 ± 70%  interrupts.CPU13.NMI:Non-maskable_interrupts
      7918 ± 19%     -69.1%       2443 ± 70%  interrupts.CPU13.PMI:Performance_monitoring_interrupts
   1049394 ±  6%     -56.8%     453843 ± 17%  interrupts.CPU13.RES:Rescheduling_interrupts
    258048 ±  8%     -61.1%     100309 ±  9%  interrupts.CPU13.TLB:TLB_shootdowns
    286832 ±  9%     -48.9%     146564 ± 12%  interrupts.CPU130.CAL:Function_call_interrupts
    329453 ±  3%     -31.3%     226442 ±  2%  interrupts.CPU130.LOC:Local_timer_interrupts
      7892 ± 17%     -69.6%       2399 ± 70%  interrupts.CPU130.NMI:Non-maskable_interrupts
      7892 ± 17%     -69.6%       2399 ± 70%  interrupts.CPU130.PMI:Performance_monitoring_interrupts
    967627 ± 11%     -44.3%     539211 ±  3%  interrupts.CPU130.RES:Rescheduling_interrupts
    257660 ±  8%     -61.5%      99197 ±  8%  interrupts.CPU130.TLB:TLB_shootdowns
    286497 ± 10%     -47.2%     151321 ± 23%  interrupts.CPU131.CAL:Function_call_interrupts
    329300 ±  3%     -31.2%     226452 ±  2%  interrupts.CPU131.LOC:Local_timer_interrupts
      7894 ± 17%     -69.3%       2421 ± 69%  interrupts.CPU131.NMI:Non-maskable_interrupts
      7894 ± 17%     -69.3%       2421 ± 69%  interrupts.CPU131.PMI:Performance_monitoring_interrupts
   1006471 ± 15%     -53.6%     466521 ±  4%  interrupts.CPU131.RES:Rescheduling_interrupts
    257806 ±  8%     -61.5%      99214 ±  9%  interrupts.CPU131.TLB:TLB_shootdowns
    292173 ±  6%     -51.1%     142808 ± 19%  interrupts.CPU132.CAL:Function_call_interrupts
    329216 ±  3%     -31.2%     226354 ±  2%  interrupts.CPU132.LOC:Local_timer_interrupts
      7391 ± 25%     -67.3%       2413 ± 69%  interrupts.CPU132.NMI:Non-maskable_interrupts
      7391 ± 25%     -67.3%       2413 ± 69%  interrupts.CPU132.PMI:Performance_monitoring_interrupts
   1028667 ± 16%     -51.8%     495816 ± 22%  interrupts.CPU132.RES:Rescheduling_interrupts
    257710 ±  8%     -62.0%      97921 ± 11%  interrupts.CPU132.TLB:TLB_shootdowns
    279891 ± 10%     -40.9%     165537 ±  6%  interrupts.CPU133.CAL:Function_call_interrupts
    329306 ±  3%     -31.2%     226498 ±  2%  interrupts.CPU133.LOC:Local_timer_interrupts
      7936 ± 18%     -69.8%       2396 ± 69%  interrupts.CPU133.NMI:Non-maskable_interrupts
      7936 ± 18%     -69.8%       2396 ± 69%  interrupts.CPU133.PMI:Performance_monitoring_interrupts
    945794 ± 10%     -41.3%     554812 ± 12%  interrupts.CPU133.RES:Rescheduling_interrupts
    257638 ±  8%     -61.8%      98527 ±  9%  interrupts.CPU133.TLB:TLB_shootdowns
    303125 ± 10%     -46.2%     163141 ± 13%  interrupts.CPU134.CAL:Function_call_interrupts
    329315 ±  3%     -31.2%     226406 ±  2%  interrupts.CPU134.LOC:Local_timer_interrupts
      7931 ± 18%     -69.4%       2426 ± 69%  interrupts.CPU134.NMI:Non-maskable_interrupts
      7931 ± 18%     -69.4%       2426 ± 69%  interrupts.CPU134.PMI:Performance_monitoring_interrupts
    954594 ± 14%     -41.8%     555606 ± 18%  interrupts.CPU134.RES:Rescheduling_interrupts
    257276 ±  8%     -61.6%      98830 ±  9%  interrupts.CPU134.TLB:TLB_shootdowns
    315168 ± 10%     -55.0%     141888 ± 13%  interrupts.CPU135.CAL:Function_call_interrupts
    329191 ±  3%     -31.2%     226429 ±  2%  interrupts.CPU135.LOC:Local_timer_interrupts
      7393 ± 25%     -69.9%       2225 ± 80%  interrupts.CPU135.NMI:Non-maskable_interrupts
      7393 ± 25%     -69.9%       2225 ± 80%  interrupts.CPU135.PMI:Performance_monitoring_interrupts
   1014119 ± 16%     -52.4%     482232 ±  9%  interrupts.CPU135.RES:Rescheduling_interrupts
    257609 ±  8%     -60.9%     100686 ±  8%  interrupts.CPU135.TLB:TLB_shootdowns
    283021 ±  7%     -34.8%     184415 ± 21%  interrupts.CPU136.CAL:Function_call_interrupts
    329353 ±  3%     -31.3%     226397 ±  2%  interrupts.CPU136.LOC:Local_timer_interrupts
      7936 ± 18%     -69.5%       2420 ± 70%  interrupts.CPU136.NMI:Non-maskable_interrupts
      7936 ± 18%     -69.5%       2420 ± 70%  interrupts.CPU136.PMI:Performance_monitoring_interrupts
    991124 ± 14%     -53.5%     460731 ± 27%  interrupts.CPU136.RES:Rescheduling_interrupts
    257834 ±  8%     -61.2%      99996 ±  9%  interrupts.CPU136.TLB:TLB_shootdowns
    298832 ± 15%     -50.3%     148585 ± 20%  interrupts.CPU137.CAL:Function_call_interrupts
    329401 ±  3%     -31.3%     226421 ±  2%  interrupts.CPU137.LOC:Local_timer_interrupts
      6845 ± 29%     -64.7%       2416 ± 69%  interrupts.CPU137.NMI:Non-maskable_interrupts
      6845 ± 29%     -64.7%       2416 ± 69%  interrupts.CPU137.PMI:Performance_monitoring_interrupts
    942528 ± 12%     -38.5%     579261 ± 10%  interrupts.CPU137.RES:Rescheduling_interrupts
    257716 ±  8%     -61.7%      98816 ±  9%  interrupts.CPU137.TLB:TLB_shootdowns
    289646 ±  7%     -41.3%     170096 ± 29%  interrupts.CPU138.CAL:Function_call_interrupts
    329286 ±  3%     -31.2%     226458 ±  2%  interrupts.CPU138.LOC:Local_timer_interrupts
      7388 ± 25%     -67.0%       2439 ± 68%  interrupts.CPU138.NMI:Non-maskable_interrupts
      7388 ± 25%     -67.0%       2439 ± 68%  interrupts.CPU138.PMI:Performance_monitoring_interrupts
    978150 ± 16%     -46.2%     526563 ±  8%  interrupts.CPU138.RES:Rescheduling_interrupts
    257657 ±  8%     -61.6%      98903 ±  9%  interrupts.CPU138.TLB:TLB_shootdowns
    289493 ± 13%     -48.8%     148270 ± 22%  interrupts.CPU139.CAL:Function_call_interrupts
    329173 ±  3%     -31.2%     226452 ±  2%  interrupts.CPU139.LOC:Local_timer_interrupts
      7388 ± 25%     -67.3%       2417 ± 70%  interrupts.CPU139.NMI:Non-maskable_interrupts
      7388 ± 25%     -67.3%       2417 ± 70%  interrupts.CPU139.PMI:Performance_monitoring_interrupts
   1027026 ± 14%     -52.0%     493279 ± 12%  interrupts.CPU139.RES:Rescheduling_interrupts
    257290 ±  8%     -61.7%      98435 ±  8%  interrupts.CPU139.TLB:TLB_shootdowns
      9984 ±174%    -100.0%       0.00        interrupts.CPU14.171:PCI-MSI.524290-edge.eth0-TxRx-1
    279501 ± 11%     -54.8%     126381 ± 14%  interrupts.CPU14.CAL:Function_call_interrupts
    328220 ±  4%     -31.0%     226484 ±  2%  interrupts.CPU14.LOC:Local_timer_interrupts
      7856 ± 17%     -69.0%       2433 ± 70%  interrupts.CPU14.NMI:Non-maskable_interrupts
      7856 ± 17%     -69.0%       2433 ± 70%  interrupts.CPU14.PMI:Performance_monitoring_interrupts
   1098244 ± 10%     -52.4%     522697 ± 25%  interrupts.CPU14.RES:Rescheduling_interrupts
    258007 ±  8%     -61.3%      99781 ±  9%  interrupts.CPU14.TLB:TLB_shootdowns
    284830 ± 12%     -42.4%     164177 ± 16%  interrupts.CPU140.CAL:Function_call_interrupts
    329357 ±  3%     -31.2%     226449 ±  2%  interrupts.CPU140.LOC:Local_timer_interrupts
      7348 ± 23%     -67.2%       2410 ± 70%  interrupts.CPU140.NMI:Non-maskable_interrupts
      7348 ± 23%     -67.2%       2410 ± 70%  interrupts.CPU140.PMI:Performance_monitoring_interrupts
    998982 ± 14%     -44.7%     552877 ± 12%  interrupts.CPU140.RES:Rescheduling_interrupts
    257796 ±  8%     -61.5%      99375 ±  9%  interrupts.CPU140.TLB:TLB_shootdowns
    286371 ±  8%     -44.7%     158489 ± 26%  interrupts.CPU141.CAL:Function_call_interrupts
    329315 ±  3%     -31.2%     226449 ±  2%  interrupts.CPU141.LOC:Local_timer_interrupts
      7889 ± 17%     -72.1%       2203 ± 83%  interrupts.CPU141.NMI:Non-maskable_interrupts
      7889 ± 17%     -72.1%       2203 ± 83%  interrupts.CPU141.PMI:Performance_monitoring_interrupts
    990139 ± 16%     -43.3%     561079 ± 14%  interrupts.CPU141.RES:Rescheduling_interrupts
    257859 ±  8%     -61.8%      98627 ±  9%  interrupts.CPU141.TLB:TLB_shootdowns
    282077 ±  8%     -42.9%     161190 ± 16%  interrupts.CPU142.CAL:Function_call_interrupts
    329188 ±  3%     -31.2%     226373 ±  2%  interrupts.CPU142.LOC:Local_timer_interrupts
      7345 ± 23%     -67.5%       2387 ± 71%  interrupts.CPU142.NMI:Non-maskable_interrupts
      7345 ± 23%     -67.5%       2387 ± 71%  interrupts.CPU142.PMI:Performance_monitoring_interrupts
    957095 ± 14%     -43.8%     538050 ± 14%  interrupts.CPU142.RES:Rescheduling_interrupts
    256620 ±  8%     -61.6%      98593 ±  9%  interrupts.CPU142.TLB:TLB_shootdowns
    272670 ±  9%     -47.5%     143237 ± 13%  interrupts.CPU143.CAL:Function_call_interrupts
    329352 ±  3%     -31.2%     226463 ±  2%  interrupts.CPU143.LOC:Local_timer_interrupts
      7893 ± 17%     -72.2%       2192 ± 83%  interrupts.CPU143.NMI:Non-maskable_interrupts
      7893 ± 17%     -72.2%       2192 ± 83%  interrupts.CPU143.PMI:Performance_monitoring_interrupts
   1005022 ± 12%     -48.1%     521140 ±  9%  interrupts.CPU143.RES:Rescheduling_interrupts
    258876 ±  8%     -61.8%      98770 ±  9%  interrupts.CPU143.TLB:TLB_shootdowns
    333694 ± 14%     -52.1%     159821 ± 11%  interrupts.CPU144.CAL:Function_call_interrupts
    329297 ±  3%     -31.2%     226475 ±  2%  interrupts.CPU144.LOC:Local_timer_interrupts
      7885 ± 17%     -71.7%       2228 ± 83%  interrupts.CPU144.NMI:Non-maskable_interrupts
      7885 ± 17%     -71.7%       2228 ± 83%  interrupts.CPU144.PMI:Performance_monitoring_interrupts
    964316 ± 11%     -52.7%     455662 ± 46%  interrupts.CPU144.RES:Rescheduling_interrupts
    257414 ±  8%     -61.2%      99829 ±  9%  interrupts.CPU144.TLB:TLB_shootdowns
    306949 ± 12%     -54.9%     138333 ± 10%  interrupts.CPU145.CAL:Function_call_interrupts
    329353 ±  3%     -31.2%     226504 ±  2%  interrupts.CPU145.LOC:Local_timer_interrupts
      7891 ± 17%     -71.9%       2217 ± 83%  interrupts.CPU145.NMI:Non-maskable_interrupts
      7891 ± 17%     -71.9%       2217 ± 83%  interrupts.CPU145.PMI:Performance_monitoring_interrupts
    986613 ± 10%     -55.5%     439028 ± 26%  interrupts.CPU145.RES:Rescheduling_interrupts
    257503 ±  8%     -61.6%      98923 ±  9%  interrupts.CPU145.TLB:TLB_shootdowns
    291522 ± 10%     -46.6%     155603 ± 27%  interrupts.CPU146.CAL:Function_call_interrupts
    329487 ±  3%     -31.3%     226461 ±  2%  interrupts.CPU146.LOC:Local_timer_interrupts
      7879 ± 17%     -71.7%       2226 ± 83%  interrupts.CPU146.NMI:Non-maskable_interrupts
      7879 ± 17%     -71.7%       2226 ± 83%  interrupts.CPU146.PMI:Performance_monitoring_interrupts
   1056100 ±  5%     -54.3%     483086 ± 21%  interrupts.CPU146.RES:Rescheduling_interrupts
    257402 ±  8%     -61.4%      99328 ±  8%  interrupts.CPU146.TLB:TLB_shootdowns
    310580 ± 10%     -50.9%     152542 ± 18%  interrupts.CPU147.CAL:Function_call_interrupts
    329264 ±  3%     -31.2%     226524 ±  2%  interrupts.CPU147.LOC:Local_timer_interrupts
      7882 ± 17%     -84.6%       1216 ± 70%  interrupts.CPU147.NMI:Non-maskable_interrupts
      7882 ± 17%     -84.6%       1216 ± 70%  interrupts.CPU147.PMI:Performance_monitoring_interrupts
   1024842 ± 11%     -49.8%     513970 ± 36%  interrupts.CPU147.RES:Rescheduling_interrupts
    257282 ±  8%     -61.3%      99621 ±  8%  interrupts.CPU147.TLB:TLB_shootdowns
    296930 ±  7%     -48.6%     152670 ± 20%  interrupts.CPU148.CAL:Function_call_interrupts
    329427 ±  3%     -31.3%     226477 ±  2%  interrupts.CPU148.LOC:Local_timer_interrupts
      7881 ± 17%     -71.8%       2219 ± 83%  interrupts.CPU148.NMI:Non-maskable_interrupts
      7881 ± 17%     -71.8%       2219 ± 83%  interrupts.CPU148.PMI:Performance_monitoring_interrupts
    983707 ± 16%     -60.5%     388783 ± 31%  interrupts.CPU148.RES:Rescheduling_interrupts
    257310 ±  8%     -61.5%      99032 ±  9%  interrupts.CPU148.TLB:TLB_shootdowns
    304935 ±  5%     -53.2%     142577 ± 22%  interrupts.CPU149.CAL:Function_call_interrupts
    329359 ±  3%     -31.2%     226480 ±  2%  interrupts.CPU149.LOC:Local_timer_interrupts
      7878 ± 17%     -71.7%       2226 ± 83%  interrupts.CPU149.NMI:Non-maskable_interrupts
      7878 ± 17%     -71.7%       2226 ± 83%  interrupts.CPU149.PMI:Performance_monitoring_interrupts
    990812 ± 10%     -55.0%     446287 ± 18%  interrupts.CPU149.RES:Rescheduling_interrupts
    257249 ±  8%     -61.6%      98690 ±  8%  interrupts.CPU149.TLB:TLB_shootdowns
      2684 ±130%    -100.0%       0.00        interrupts.CPU15.172:PCI-MSI.524291-edge.eth0-TxRx-2
    291825 ± 15%     -49.9%     146328 ± 13%  interrupts.CPU15.CAL:Function_call_interrupts
    328319 ±  4%     -31.0%     226489 ±  2%  interrupts.CPU15.LOC:Local_timer_interrupts
      7855 ± 17%     -69.1%       2425 ± 71%  interrupts.CPU15.NMI:Non-maskable_interrupts
      7855 ± 17%     -69.1%       2425 ± 71%  interrupts.CPU15.PMI:Performance_monitoring_interrupts
   1052306 ± 10%     -52.6%     498301 ± 29%  interrupts.CPU15.RES:Rescheduling_interrupts
    258202 ±  8%     -61.4%      99681 ±  9%  interrupts.CPU15.TLB:TLB_shootdowns
    289410 ±  8%     -46.9%     153589 ± 24%  interrupts.CPU150.CAL:Function_call_interrupts
    329409 ±  3%     -31.2%     226535 ±  2%  interrupts.CPU150.LOC:Local_timer_interrupts
      7876 ± 17%     -71.8%       2220 ± 83%  interrupts.CPU150.NMI:Non-maskable_interrupts
      7876 ± 17%     -71.8%       2220 ± 83%  interrupts.CPU150.PMI:Performance_monitoring_interrupts
   1006334 ± 10%     -54.7%     455495 ± 26%  interrupts.CPU150.RES:Rescheduling_interrupts
    257079 ±  8%     -61.3%      99585 ±  8%  interrupts.CPU150.TLB:TLB_shootdowns
    293734 ± 11%     -52.5%     139392 ± 19%  interrupts.CPU151.CAL:Function_call_interrupts
    329425 ±  3%     -31.2%     226512 ±  2%  interrupts.CPU151.LOC:Local_timer_interrupts
      7892 ± 17%     -71.8%       2223 ± 83%  interrupts.CPU151.NMI:Non-maskable_interrupts
      7892 ± 17%     -71.8%       2223 ± 83%  interrupts.CPU151.PMI:Performance_monitoring_interrupts
   1081623 ± 11%     -54.9%     487397 ± 30%  interrupts.CPU151.RES:Rescheduling_interrupts
    257625 ±  8%     -61.6%      98925 ±  9%  interrupts.CPU151.TLB:TLB_shootdowns
    295784 ±  7%     -47.6%     154959 ± 14%  interrupts.CPU152.CAL:Function_call_interrupts
    329440 ±  3%     -31.3%     226472 ±  2%  interrupts.CPU152.LOC:Local_timer_interrupts
      7876 ± 17%     -75.4%       1936 ± 79%  interrupts.CPU152.NMI:Non-maskable_interrupts
      7876 ± 17%     -75.4%       1936 ± 79%  interrupts.CPU152.PMI:Performance_monitoring_interrupts
   1006135 ± 10%     -54.5%     457786 ± 26%  interrupts.CPU152.RES:Rescheduling_interrupts
    257236 ±  8%     -61.4%      99257 ±  8%  interrupts.CPU152.TLB:TLB_shootdowns
    296450 ± 10%     -59.1%     121298 ±  7%  interrupts.CPU153.CAL:Function_call_interrupts
    329395 ±  3%     -31.2%     226481 ±  2%  interrupts.CPU153.LOC:Local_timer_interrupts
      8421 ±  3%     -71.5%       2400 ± 72%  interrupts.CPU153.NMI:Non-maskable_interrupts
      8421 ±  3%     -71.5%       2400 ± 72%  interrupts.CPU153.PMI:Performance_monitoring_interrupts
   1061117 ± 14%     -60.9%     415225 ± 36%  interrupts.CPU153.RES:Rescheduling_interrupts
    257379 ±  8%     -61.2%      99953 ±  9%  interrupts.CPU153.TLB:TLB_shootdowns
    293891 ±  6%     -55.7%     130282 ± 16%  interrupts.CPU154.CAL:Function_call_interrupts
    329419 ±  3%     -31.2%     226477 ±  2%  interrupts.CPU154.LOC:Local_timer_interrupts
      8424 ±  3%     -71.5%       2401 ± 72%  interrupts.CPU154.NMI:Non-maskable_interrupts
      8424 ±  3%     -71.5%       2401 ± 72%  interrupts.CPU154.PMI:Performance_monitoring_interrupts
   1073314 ± 10%     -51.3%     523189 ± 25%  interrupts.CPU154.RES:Rescheduling_interrupts
    257474 ±  8%     -61.3%      99694 ±  9%  interrupts.CPU154.TLB:TLB_shootdowns
    306511 ± 11%     -48.3%     158404 ± 30%  interrupts.CPU155.CAL:Function_call_interrupts
    329321 ±  3%     -31.2%     226493 ±  2%  interrupts.CPU155.LOC:Local_timer_interrupts
      8418 ±  3%     -71.2%       2423 ± 71%  interrupts.CPU155.NMI:Non-maskable_interrupts
      8418 ±  3%     -71.2%       2423 ± 71%  interrupts.CPU155.PMI:Performance_monitoring_interrupts
   1027476 ± 16%     -52.6%     486519 ± 22%  interrupts.CPU155.RES:Rescheduling_interrupts
    257029 ±  8%     -61.5%      98896 ±  9%  interrupts.CPU155.TLB:TLB_shootdowns
    289626 ±  8%     -48.5%     149187 ± 14%  interrupts.CPU156.CAL:Function_call_interrupts
    329396 ±  3%     -31.2%     226498 ±  2%  interrupts.CPU156.LOC:Local_timer_interrupts
      8420 ±  3%     -71.4%       2407 ± 71%  interrupts.CPU156.NMI:Non-maskable_interrupts
      8420 ±  3%     -71.4%       2407 ± 71%  interrupts.CPU156.PMI:Performance_monitoring_interrupts
    979138 ± 14%     -50.8%     482044 ± 17%  interrupts.CPU156.RES:Rescheduling_interrupts
    257193 ±  8%     -61.3%      99558 ±  8%  interrupts.CPU156.TLB:TLB_shootdowns
    308705 ±  7%     -48.2%     159907 ± 18%  interrupts.CPU157.CAL:Function_call_interrupts
    329315 ±  3%     -31.2%     226463 ±  2%  interrupts.CPU157.LOC:Local_timer_interrupts
      7911 ± 18%     -69.6%       2407 ± 72%  interrupts.CPU157.NMI:Non-maskable_interrupts
      7911 ± 18%     -69.6%       2407 ± 72%  interrupts.CPU157.PMI:Performance_monitoring_interrupts
   1032768 ± 14%     -51.5%     500819 ± 30%  interrupts.CPU157.RES:Rescheduling_interrupts
    257145 ±  8%     -61.4%      99178 ±  9%  interrupts.CPU157.TLB:TLB_shootdowns
    291081 ±  9%     -45.8%     157839 ± 24%  interrupts.CPU158.CAL:Function_call_interrupts
    329470 ±  3%     -31.3%     226459 ±  2%  interrupts.CPU158.LOC:Local_timer_interrupts
      7877 ± 17%     -69.5%       2404 ± 71%  interrupts.CPU158.NMI:Non-maskable_interrupts
      7877 ± 17%     -69.5%       2404 ± 71%  interrupts.CPU158.PMI:Performance_monitoring_interrupts
    997795 ± 15%     -53.4%     465124 ± 24%  interrupts.CPU158.RES:Rescheduling_interrupts
    257394 ±  8%     -61.8%      98357 ±  9%  interrupts.CPU158.TLB:TLB_shootdowns
    295300 ±  6%     -47.0%     156466 ± 19%  interrupts.CPU159.CAL:Function_call_interrupts
    329477 ±  3%     -31.3%     226464 ±  2%  interrupts.CPU159.LOC:Local_timer_interrupts
      7881 ± 17%     -69.4%       2413 ± 72%  interrupts.CPU159.NMI:Non-maskable_interrupts
      7881 ± 17%     -69.4%       2413 ± 72%  interrupts.CPU159.PMI:Performance_monitoring_interrupts
   1047788 ± 13%     -52.0%     502721 ± 34%  interrupts.CPU159.RES:Rescheduling_interrupts
    257095 ±  8%     -61.4%      99289 ±  9%  interrupts.CPU159.TLB:TLB_shootdowns
      3306 ±200%    -100.0%       0.00        interrupts.CPU16.173:PCI-MSI.524292-edge.eth0-TxRx-3
    270647 ±  9%     -55.2%     121375 ± 10%  interrupts.CPU16.CAL:Function_call_interrupts
    328319 ±  4%     -31.0%     226486 ±  2%  interrupts.CPU16.LOC:Local_timer_interrupts
      7855 ± 17%     -76.0%       1885 ± 70%  interrupts.CPU16.NMI:Non-maskable_interrupts
      7855 ± 17%     -76.0%       1885 ± 70%  interrupts.CPU16.PMI:Performance_monitoring_interrupts
   1058465 ± 12%     -56.8%     456887 ± 22%  interrupts.CPU16.RES:Rescheduling_interrupts
    258524 ±  8%     -61.5%      99449 ±  9%  interrupts.CPU16.TLB:TLB_shootdowns
    320020 ± 11%     -55.6%     141993 ± 13%  interrupts.CPU160.CAL:Function_call_interrupts
    329435 ±  3%     -31.3%     226471 ±  2%  interrupts.CPU160.LOC:Local_timer_interrupts
      7882 ± 17%     -71.8%       2222 ± 83%  interrupts.CPU160.NMI:Non-maskable_interrupts
      7882 ± 17%     -71.8%       2222 ± 83%  interrupts.CPU160.PMI:Performance_monitoring_interrupts
    999170 ±  9%     -53.7%     462173 ± 18%  interrupts.CPU160.RES:Rescheduling_interrupts
    257011 ±  8%     -61.5%      99011 ±  9%  interrupts.CPU160.TLB:TLB_shootdowns
    290965 ±  7%     -53.3%     135949 ± 19%  interrupts.CPU161.CAL:Function_call_interrupts
    329364 ±  3%     -31.2%     226534 ±  2%  interrupts.CPU161.LOC:Local_timer_interrupts
      7870 ± 17%     -71.8%       2221 ± 83%  interrupts.CPU161.NMI:Non-maskable_interrupts
      7870 ± 17%     -71.8%       2221 ± 83%  interrupts.CPU161.PMI:Performance_monitoring_interrupts
   1035236 ± 12%     -54.6%     469741 ± 38%  interrupts.CPU161.RES:Rescheduling_interrupts
    257584 ±  8%     -61.6%      98980 ±  8%  interrupts.CPU161.TLB:TLB_shootdowns
    289576 ± 12%     -47.6%     151710 ± 17%  interrupts.CPU162.CAL:Function_call_interrupts
    329380 ±  3%     -31.2%     226508 ±  2%  interrupts.CPU162.LOC:Local_timer_interrupts
      7881 ± 17%     -71.7%       2231 ± 83%  interrupts.CPU162.NMI:Non-maskable_interrupts
      7881 ± 17%     -71.7%       2231 ± 83%  interrupts.CPU162.PMI:Performance_monitoring_interrupts
   1060995 ± 13%     -55.6%     471084 ± 23%  interrupts.CPU162.RES:Rescheduling_interrupts
    257082 ±  8%     -61.1%      99952 ±  8%  interrupts.CPU162.TLB:TLB_shootdowns
    292754 ± 14%     -40.8%     173417 ± 39%  interrupts.CPU163.CAL:Function_call_interrupts
    329473 ±  3%     -31.3%     226452 ±  2%  interrupts.CPU163.LOC:Local_timer_interrupts
      7869 ± 17%     -77.8%       1747 ± 93%  interrupts.CPU163.NMI:Non-maskable_interrupts
      7869 ± 17%     -77.8%       1747 ± 93%  interrupts.CPU163.PMI:Performance_monitoring_interrupts
   1013247 ±  5%     -59.7%     408037 ± 17%  interrupts.CPU163.RES:Rescheduling_interrupts
    257251 ±  8%     -61.6%      98910 ±  9%  interrupts.CPU163.TLB:TLB_shootdowns
    310402 ±  9%     -53.5%     144203 ± 18%  interrupts.CPU164.CAL:Function_call_interrupts
    329394 ±  3%     -31.2%     226485 ±  2%  interrupts.CPU164.LOC:Local_timer_interrupts
      7868 ± 17%     -71.9%       2211 ± 83%  interrupts.CPU164.NMI:Non-maskable_interrupts
      7868 ± 17%     -71.9%       2211 ± 83%  interrupts.CPU164.PMI:Performance_monitoring_interrupts
    952350 ±  9%     -46.0%     514018 ± 38%  interrupts.CPU164.RES:Rescheduling_interrupts
    257237 ±  8%     -61.5%      99093 ±  9%  interrupts.CPU164.TLB:TLB_shootdowns
    299644 ± 11%     -53.2%     140357 ± 27%  interrupts.CPU165.CAL:Function_call_interrupts
    329336 ±  3%     -31.3%     226285 ±  2%  interrupts.CPU165.LOC:Local_timer_interrupts
      7873 ± 17%     -71.9%       2214 ± 83%  interrupts.CPU165.NMI:Non-maskable_interrupts
      7873 ± 17%     -71.9%       2214 ± 83%  interrupts.CPU165.PMI:Performance_monitoring_interrupts
    992780 ± 12%     -51.8%     478666 ± 24%  interrupts.CPU165.RES:Rescheduling_interrupts
    256840 ±  8%     -61.2%      99550 ±  8%  interrupts.CPU165.TLB:TLB_shootdowns
    300387 ± 15%     -55.5%     133531 ± 17%  interrupts.CPU166.CAL:Function_call_interrupts
    329358 ±  3%     -31.2%     226490 ±  2%  interrupts.CPU166.LOC:Local_timer_interrupts
      7873 ± 17%     -71.9%       2210 ± 83%  interrupts.CPU166.NMI:Non-maskable_interrupts
      7873 ± 17%     -71.9%       2210 ± 83%  interrupts.CPU166.PMI:Performance_monitoring_interrupts
   1061795 ± 13%     -55.7%     470542 ± 30%  interrupts.CPU166.RES:Rescheduling_interrupts
    257476 ±  8%     -61.5%      99027 ±  8%  interrupts.CPU166.TLB:TLB_shootdowns
    296889 ± 10%     -48.7%     152252 ± 18%  interrupts.CPU167.CAL:Function_call_interrupts
    329351 ±  3%     -31.2%     226476 ±  2%  interrupts.CPU167.LOC:Local_timer_interrupts
      7888 ± 17%     -71.9%       2214 ± 83%  interrupts.CPU167.NMI:Non-maskable_interrupts
      7888 ± 17%     -71.9%       2214 ± 83%  interrupts.CPU167.PMI:Performance_monitoring_interrupts
   1049449 ± 11%     -56.9%     452527 ± 27%  interrupts.CPU167.RES:Rescheduling_interrupts
    257447 ±  8%     -61.4%      99269 ±  8%  interrupts.CPU167.TLB:TLB_shootdowns
    312722 ± 10%     -56.4%     136385 ± 10%  interrupts.CPU168.CAL:Function_call_interrupts
    329175 ±  3%     -31.2%     226394 ±  2%  interrupts.CPU168.LOC:Local_timer_interrupts
      8375 ±  4%     -73.5%       2223 ± 82%  interrupts.CPU168.NMI:Non-maskable_interrupts
      8375 ±  4%     -73.5%       2223 ± 82%  interrupts.CPU168.PMI:Performance_monitoring_interrupts
   1024940 ± 12%     -57.2%     438712 ± 11%  interrupts.CPU168.RES:Rescheduling_interrupts
    256700 ±  8%     -61.2%      99632 ±  9%  interrupts.CPU168.TLB:TLB_shootdowns
    319671 ± 13%     -62.6%     119600 ±  8%  interrupts.CPU169.CAL:Function_call_interrupts
    329318 ±  3%     -31.2%     226496 ±  2%  interrupts.CPU169.LOC:Local_timer_interrupts
      7818 ± 17%     -71.8%       2206 ± 83%  interrupts.CPU169.NMI:Non-maskable_interrupts
      7818 ± 17%     -71.8%       2206 ± 83%  interrupts.CPU169.PMI:Performance_monitoring_interrupts
   1095397 ± 15%     -57.0%     471273 ± 21%  interrupts.CPU169.RES:Rescheduling_interrupts
    257355 ±  8%     -61.4%      99445 ±  9%  interrupts.CPU169.TLB:TLB_shootdowns
    273560 ± 10%     -44.1%     153053 ± 17%  interrupts.CPU17.CAL:Function_call_interrupts
    328254 ±  4%     -31.0%     226461 ±  2%  interrupts.CPU17.LOC:Local_timer_interrupts
      7856 ± 17%     -78.6%       1679 ± 84%  interrupts.CPU17.NMI:Non-maskable_interrupts
      7856 ± 17%     -78.6%       1679 ± 84%  interrupts.CPU17.PMI:Performance_monitoring_interrupts
   1018839 ±  5%     -54.4%     464970 ± 26%  interrupts.CPU17.RES:Rescheduling_interrupts
    257926 ±  8%     -60.7%     101414 ±  9%  interrupts.CPU17.TLB:TLB_shootdowns
    308997 ± 11%     -57.8%     130283 ± 16%  interrupts.CPU170.CAL:Function_call_interrupts
    329149 ±  3%     -31.2%     226439 ±  2%  interrupts.CPU170.LOC:Local_timer_interrupts
      7829 ± 17%     -71.8%       2207 ± 83%  interrupts.CPU170.NMI:Non-maskable_interrupts
      7829 ± 17%     -71.8%       2207 ± 83%  interrupts.CPU170.PMI:Performance_monitoring_interrupts
   1096744 ±  9%     -53.9%     506118 ± 16%  interrupts.CPU170.RES:Rescheduling_interrupts
    257144 ±  8%     -61.1%     100109 ±  9%  interrupts.CPU170.TLB:TLB_shootdowns
    296392 ± 10%     -38.6%     182053 ± 11%  interrupts.CPU171.CAL:Function_call_interrupts
    329319 ±  3%     -31.2%     226463 ±  2%  interrupts.CPU171.LOC:Local_timer_interrupts
      8365 ±  4%     -80.1%       1667 ± 86%  interrupts.CPU171.NMI:Non-maskable_interrupts
      8365 ±  4%     -80.1%       1667 ± 86%  interrupts.CPU171.PMI:Performance_monitoring_interrupts
   1069493 ± 11%     -55.6%     474322 ± 21%  interrupts.CPU171.RES:Rescheduling_interrupts
    257448 ±  8%     -61.1%     100102 ±  9%  interrupts.CPU171.TLB:TLB_shootdowns
    294710 ± 14%     -54.4%     134362 ± 15%  interrupts.CPU172.CAL:Function_call_interrupts
    329207 ±  3%     -31.2%     226455 ±  2%  interrupts.CPU172.LOC:Local_timer_interrupts
      8367 ±  4%     -73.5%       2216 ± 82%  interrupts.CPU172.NMI:Non-maskable_interrupts
      8367 ±  4%     -73.5%       2216 ± 82%  interrupts.CPU172.PMI:Performance_monitoring_interrupts
   1063522 ± 10%     -52.1%     509395 ± 15%  interrupts.CPU172.RES:Rescheduling_interrupts
    257163 ±  8%     -61.5%      99015 ±  9%  interrupts.CPU172.TLB:TLB_shootdowns
    282972 ±  5%     -48.8%     144901 ± 15%  interrupts.CPU173.CAL:Function_call_interrupts
    329208 ±  3%     -31.3%     226312 ±  2%  interrupts.CPU173.LOC:Local_timer_interrupts
      7830 ± 17%     -71.8%       2206 ± 83%  interrupts.CPU173.NMI:Non-maskable_interrupts
      7830 ± 17%     -71.8%       2206 ± 83%  interrupts.CPU173.PMI:Performance_monitoring_interrupts
   1135213 ± 16%     -59.7%     457769 ± 22%  interrupts.CPU173.RES:Rescheduling_interrupts
    257312 ±  8%     -61.1%     100176 ± 10%  interrupts.CPU173.TLB:TLB_shootdowns
    297394 ± 13%     -51.2%     145259 ± 12%  interrupts.CPU174.CAL:Function_call_interrupts
    329131 ±  3%     -31.2%     226437 ±  2%  interrupts.CPU174.LOC:Local_timer_interrupts
      8367 ±  4%     -79.2%       1743 ± 91%  interrupts.CPU174.NMI:Non-maskable_interrupts
      8367 ±  4%     -79.2%       1743 ± 91%  interrupts.CPU174.PMI:Performance_monitoring_interrupts
   1153439 ± 14%     -62.7%     430348 ± 12%  interrupts.CPU174.RES:Rescheduling_interrupts
    257250 ±  8%     -61.0%     100223 ±  9%  interrupts.CPU174.TLB:TLB_shootdowns
    286662 ±  9%     -51.7%     138571 ± 12%  interrupts.CPU175.CAL:Function_call_interrupts
    329128 ±  3%     -31.2%     226454 ±  2%  interrupts.CPU175.LOC:Local_timer_interrupts
      8371 ±  4%     -73.6%       2210 ± 83%  interrupts.CPU175.NMI:Non-maskable_interrupts
      8371 ±  4%     -73.6%       2210 ± 83%  interrupts.CPU175.PMI:Performance_monitoring_interrupts
   1097418 ± 11%     -59.5%     444522 ± 20%  interrupts.CPU175.RES:Rescheduling_interrupts
    257248 ±  8%     -60.8%     100896 ±  8%  interrupts.CPU175.TLB:TLB_shootdowns
    293618 ± 14%     -49.2%     149139 ± 24%  interrupts.CPU176.CAL:Function_call_interrupts
    329176 ±  3%     -31.2%     226433 ±  2%  interrupts.CPU176.LOC:Local_timer_interrupts
      7825 ± 17%     -69.6%       2375 ± 72%  interrupts.CPU176.NMI:Non-maskable_interrupts
      7825 ± 17%     -69.6%       2375 ± 72%  interrupts.CPU176.PMI:Performance_monitoring_interrupts
   1146663 ±  9%     -61.0%     446744 ± 14%  interrupts.CPU176.RES:Rescheduling_interrupts
    257793 ±  8%     -61.5%      99369 ±  9%  interrupts.CPU176.TLB:TLB_shootdowns
    287853 ±  9%     -54.2%     131856 ±  5%  interrupts.CPU177.CAL:Function_call_interrupts
    329142 ±  3%     -31.2%     226455 ±  2%  interrupts.CPU177.LOC:Local_timer_interrupts
      8364 ±  4%     -79.3%       1735 ± 93%  interrupts.CPU177.NMI:Non-maskable_interrupts
      8364 ±  4%     -79.3%       1735 ± 93%  interrupts.CPU177.PMI:Performance_monitoring_interrupts
   1101639 ± 10%     -55.6%     489252 ± 23%  interrupts.CPU177.RES:Rescheduling_interrupts
    256796 ±  8%     -61.2%      99752 ±  7%  interrupts.CPU177.TLB:TLB_shootdowns
    283212 ± 11%     -47.1%     149689 ± 18%  interrupts.CPU178.CAL:Function_call_interrupts
    329153 ±  3%     -31.2%     226443 ±  2%  interrupts.CPU178.LOC:Local_timer_interrupts
      7824 ± 17%     -71.8%       2207 ± 83%  interrupts.CPU178.NMI:Non-maskable_interrupts
      7824 ± 17%     -71.8%       2207 ± 83%  interrupts.CPU178.PMI:Performance_monitoring_interrupts
   1043935 ± 10%     -49.7%     525200 ± 21%  interrupts.CPU178.RES:Rescheduling_interrupts
    257173 ±  8%     -61.1%      99923 ±  8%  interrupts.CPU178.TLB:TLB_shootdowns
    297677 ± 13%     -53.0%     139782 ± 18%  interrupts.CPU179.CAL:Function_call_interrupts
    329121 ±  3%     -31.2%     226458 ±  2%  interrupts.CPU179.LOC:Local_timer_interrupts
      8364 ±  4%     -79.1%       1745 ± 92%  interrupts.CPU179.NMI:Non-maskable_interrupts
      8364 ±  4%     -79.1%       1745 ± 92%  interrupts.CPU179.PMI:Performance_monitoring_interrupts
   1115011 ±  8%     -57.8%     470826 ± 28%  interrupts.CPU179.RES:Rescheduling_interrupts
    257108 ±  8%     -61.4%      99154 ±  8%  interrupts.CPU179.TLB:TLB_shootdowns
    273378 ± 12%     -47.4%     143670 ± 16%  interrupts.CPU18.CAL:Function_call_interrupts
    328300 ±  4%     -31.0%     226402 ±  2%  interrupts.CPU18.LOC:Local_timer_interrupts
      8399 ±  3%     -79.9%       1684 ± 84%  interrupts.CPU18.NMI:Non-maskable_interrupts
      8399 ±  3%     -79.9%       1684 ± 84%  interrupts.CPU18.PMI:Performance_monitoring_interrupts
   1010309 ± 15%     -48.8%     517159 ± 26%  interrupts.CPU18.RES:Rescheduling_interrupts
    258131 ±  8%     -61.0%     100640 ±  9%  interrupts.CPU18.TLB:TLB_shootdowns
    289941 ± 10%     -44.7%     160438 ± 14%  interrupts.CPU180.CAL:Function_call_interrupts
    329160 ±  3%     -31.2%     226483 ±  2%  interrupts.CPU180.LOC:Local_timer_interrupts
      8365 ±  4%     -73.6%       2211 ± 83%  interrupts.CPU180.NMI:Non-maskable_interrupts
      8365 ±  4%     -73.6%       2211 ± 83%  interrupts.CPU180.PMI:Performance_monitoring_interrupts
   1133848 ± 15%     -57.9%     477476 ± 26%  interrupts.CPU180.RES:Rescheduling_interrupts
    257103 ±  8%     -61.6%      98725 ±  9%  interrupts.CPU180.TLB:TLB_shootdowns
    290956 ±  8%     -48.2%     150665 ±  6%  interrupts.CPU181.CAL:Function_call_interrupts
    329283 ±  3%     -31.2%     226457 ±  2%  interrupts.CPU181.LOC:Local_timer_interrupts
      7821 ± 17%     -77.7%       1742 ± 93%  interrupts.CPU181.NMI:Non-maskable_interrupts
      7821 ± 17%     -77.7%       1742 ± 93%  interrupts.CPU181.PMI:Performance_monitoring_interrupts
   1062850 ± 13%     -56.4%     463337 ± 13%  interrupts.CPU181.RES:Rescheduling_interrupts
    256985 ±  8%     -61.5%      98889 ±  9%  interrupts.CPU181.TLB:TLB_shootdowns
    278524 ±  8%     -52.2%     133170 ± 16%  interrupts.CPU182.CAL:Function_call_interrupts
    329290 ±  3%     -31.2%     226426 ±  2%  interrupts.CPU182.LOC:Local_timer_interrupts
      8363 ±  4%     -73.6%       2211 ± 82%  interrupts.CPU182.NMI:Non-maskable_interrupts
      8363 ±  4%     -73.6%       2211 ± 82%  interrupts.CPU182.PMI:Performance_monitoring_interrupts
   1094478 ± 14%     -54.0%     503737 ±  7%  interrupts.CPU182.RES:Rescheduling_interrupts
    257187 ±  8%     -61.3%      99443 ±  8%  interrupts.CPU182.TLB:TLB_shootdowns
    306456 ± 16%     -54.3%     139945 ± 32%  interrupts.CPU183.CAL:Function_call_interrupts
    329283 ±  3%     -31.2%     226431 ±  2%  interrupts.CPU183.LOC:Local_timer_interrupts
      8364 ±  4%     -73.8%       2195 ± 84%  interrupts.CPU183.NMI:Non-maskable_interrupts
      8364 ±  4%     -73.8%       2195 ± 84%  interrupts.CPU183.PMI:Performance_monitoring_interrupts
   1096037 ± 11%     -60.2%     435748 ± 27%  interrupts.CPU183.RES:Rescheduling_interrupts
    257472 ±  8%     -61.3%      99566 ±  8%  interrupts.CPU183.TLB:TLB_shootdowns
    297657 ±  9%     -48.4%     153688 ± 48%  interrupts.CPU184.CAL:Function_call_interrupts
    329311 ±  3%     -31.2%     226425 ±  2%  interrupts.CPU184.LOC:Local_timer_interrupts
      7824 ± 17%     -71.9%       2197 ± 84%  interrupts.CPU184.NMI:Non-maskable_interrupts
      7824 ± 17%     -71.9%       2197 ± 84%  interrupts.CPU184.PMI:Performance_monitoring_interrupts
   1101357 ± 11%     -57.9%     463168 ± 12%  interrupts.CPU184.RES:Rescheduling_interrupts
    257297 ±  8%     -60.9%     100533 ±  9%  interrupts.CPU184.TLB:TLB_shootdowns
    289406 ±  7%     -57.8%     122117 ±  4%  interrupts.CPU185.CAL:Function_call_interrupts
    329310 ±  3%     -31.3%     226364 ±  2%  interrupts.CPU185.LOC:Local_timer_interrupts
      8363 ±  4%     -73.7%       2199 ± 84%  interrupts.CPU185.NMI:Non-maskable_interrupts
      8363 ±  4%     -73.7%       2199 ± 84%  interrupts.CPU185.PMI:Performance_monitoring_interrupts
   1115253 ± 12%     -62.2%     421254 ± 14%  interrupts.CPU185.RES:Rescheduling_interrupts
    257474 ±  8%     -61.0%     100401 ±  8%  interrupts.CPU185.TLB:TLB_shootdowns
    291984 ±  9%     -47.2%     154267 ±  7%  interrupts.CPU186.CAL:Function_call_interrupts
    329326 ±  3%     -31.2%     226462 ±  2%  interrupts.CPU186.LOC:Local_timer_interrupts
      7820 ± 17%     -71.8%       2202 ± 83%  interrupts.CPU186.NMI:Non-maskable_interrupts
      7820 ± 17%     -71.8%       2202 ± 83%  interrupts.CPU186.PMI:Performance_monitoring_interrupts
   1116715 ±  9%     -57.0%     480404 ± 23%  interrupts.CPU186.RES:Rescheduling_interrupts
    257850 ±  8%     -61.1%     100362 ±  8%  interrupts.CPU186.TLB:TLB_shootdowns
    299234 ±  8%     -57.1%     128488 ±  8%  interrupts.CPU187.CAL:Function_call_interrupts
    329261 ±  3%     -31.2%     226391 ±  2%  interrupts.CPU187.LOC:Local_timer_interrupts
      7827 ± 17%     -71.8%       2209 ± 82%  interrupts.CPU187.NMI:Non-maskable_interrupts
      7827 ± 17%     -71.8%       2209 ± 82%  interrupts.CPU187.PMI:Performance_monitoring_interrupts
   1118693 ± 12%     -61.2%     433950 ± 27%  interrupts.CPU187.RES:Rescheduling_interrupts
    257264 ±  8%     -61.0%     100388 ±  8%  interrupts.CPU187.TLB:TLB_shootdowns
    288815 ± 14%     -47.9%     150509 ± 15%  interrupts.CPU188.CAL:Function_call_interrupts
    329307 ±  3%     -31.2%     226441 ±  2%  interrupts.CPU188.LOC:Local_timer_interrupts
      7821 ± 17%     -71.8%       2204 ± 83%  interrupts.CPU188.NMI:Non-maskable_interrupts
      7821 ± 17%     -71.8%       2204 ± 83%  interrupts.CPU188.PMI:Performance_monitoring_interrupts
   1143534 ± 11%     -58.1%     479338 ± 12%  interrupts.CPU188.RES:Rescheduling_interrupts
    257672 ±  8%     -61.2%      99883 ±  8%  interrupts.CPU188.TLB:TLB_shootdowns
    304402 ± 15%     -57.2%     130260 ±  6%  interrupts.CPU189.CAL:Function_call_interrupts
    329369 ±  3%     -31.2%     226469 ±  2%  interrupts.CPU189.LOC:Local_timer_interrupts
      7817 ± 17%     -71.7%       2212 ± 82%  interrupts.CPU189.NMI:Non-maskable_interrupts
      7817 ± 17%     -71.7%       2212 ± 82%  interrupts.CPU189.PMI:Performance_monitoring_interrupts
   1149327 ± 10%     -52.5%     545933 ± 15%  interrupts.CPU189.RES:Rescheduling_interrupts
    257257 ±  8%     -60.9%     100556 ±  8%  interrupts.CPU189.TLB:TLB_shootdowns
    281903 ±  9%     -50.9%     138479 ± 14%  interrupts.CPU19.CAL:Function_call_interrupts
    328060 ±  4%     -31.0%     226520 ±  2%  interrupts.CPU19.LOC:Local_timer_interrupts
      7853 ± 17%     -76.0%       1882 ± 71%  interrupts.CPU19.NMI:Non-maskable_interrupts
      7853 ± 17%     -76.0%       1882 ± 71%  interrupts.CPU19.PMI:Performance_monitoring_interrupts
   1007298 ±  8%     -48.4%     519793 ± 31%  interrupts.CPU19.RES:Rescheduling_interrupts
    258189 ±  8%     -61.0%     100654 ±  9%  interrupts.CPU19.TLB:TLB_shootdowns
    300493 ± 14%     -46.6%     160462 ± 15%  interrupts.CPU190.CAL:Function_call_interrupts
    329349 ±  3%     -31.2%     226445 ±  2%  interrupts.CPU190.LOC:Local_timer_interrupts
      7818 ± 17%     -71.7%       2211 ± 82%  interrupts.CPU190.NMI:Non-maskable_interrupts
      7818 ± 17%     -71.7%       2211 ± 82%  interrupts.CPU190.PMI:Performance_monitoring_interrupts
   1128451 ± 12%     -55.4%     503204 ± 13%  interrupts.CPU190.RES:Rescheduling_interrupts
    257252 ±  8%     -61.3%      99642 ±  8%  interrupts.CPU190.TLB:TLB_shootdowns
    302260 ± 20%     -58.5%     125397 ± 11%  interrupts.CPU191.CAL:Function_call_interrupts
    329295 ±  3%     -31.2%     226461 ±  2%  interrupts.CPU191.LOC:Local_timer_interrupts
      7828 ± 17%     -71.8%       2205 ± 83%  interrupts.CPU191.NMI:Non-maskable_interrupts
      7828 ± 17%     -71.8%       2205 ± 83%  interrupts.CPU191.PMI:Performance_monitoring_interrupts
   1027516 ± 10%     -55.1%     461708 ± 23%  interrupts.CPU191.RES:Rescheduling_interrupts
    255962 ±  8%     -61.1%      99477 ±  9%  interrupts.CPU191.TLB:TLB_shootdowns
    338572 ± 12%     -56.5%     147446 ± 22%  interrupts.CPU2.CAL:Function_call_interrupts
    328298 ±  4%     -31.0%     226501 ±  2%  interrupts.CPU2.LOC:Local_timer_interrupts
      7924 ± 19%     -69.5%       2415 ± 71%  interrupts.CPU2.NMI:Non-maskable_interrupts
      7924 ± 19%     -69.5%       2415 ± 71%  interrupts.CPU2.PMI:Performance_monitoring_interrupts
   1044432 ± 15%     -58.6%     432098 ± 20%  interrupts.CPU2.RES:Rescheduling_interrupts
    257579 ±  8%     -60.5%     101798 ±  8%  interrupts.CPU2.TLB:TLB_shootdowns
    277965 ±  7%     -51.7%     134187 ± 19%  interrupts.CPU20.CAL:Function_call_interrupts
    328074 ±  4%     -31.0%     226453 ±  2%  interrupts.CPU20.LOC:Local_timer_interrupts
      7864 ± 17%     -76.1%       1882 ± 70%  interrupts.CPU20.NMI:Non-maskable_interrupts
      7864 ± 17%     -76.1%       1882 ± 70%  interrupts.CPU20.PMI:Performance_monitoring_interrupts
   1042296 ± 16%     -57.9%     438903 ± 16%  interrupts.CPU20.RES:Rescheduling_interrupts
    257729 ±  8%     -61.4%      99553 ±  8%  interrupts.CPU20.TLB:TLB_shootdowns
    297439 ± 11%     -57.5%     126478 ± 16%  interrupts.CPU21.CAL:Function_call_interrupts
    328182 ±  4%     -31.0%     226471 ±  2%  interrupts.CPU21.LOC:Local_timer_interrupts
      8404 ±  3%     -77.6%       1878 ± 71%  interrupts.CPU21.NMI:Non-maskable_interrupts
      8404 ±  3%     -77.6%       1878 ± 71%  interrupts.CPU21.PMI:Performance_monitoring_interrupts
   1049628 ± 10%     -45.4%     572675 ± 26%  interrupts.CPU21.RES:Rescheduling_interrupts
    258195 ±  8%     -61.4%      99641 ±  9%  interrupts.CPU21.TLB:TLB_shootdowns
    287527 ±  9%     -52.7%     136005 ± 24%  interrupts.CPU22.CAL:Function_call_interrupts
    328366 ±  4%     -31.0%     226484 ±  2%  interrupts.CPU22.LOC:Local_timer_interrupts
      7862 ± 17%     -78.6%       1680 ± 85%  interrupts.CPU22.NMI:Non-maskable_interrupts
      7862 ± 17%     -78.6%       1680 ± 85%  interrupts.CPU22.PMI:Performance_monitoring_interrupts
   1025426 ±  9%     -53.2%     479897 ± 26%  interrupts.CPU22.RES:Rescheduling_interrupts
    258008 ±  8%     -61.0%     100740 ±  9%  interrupts.CPU22.TLB:TLB_shootdowns
    293860 ± 11%     -53.9%     135590 ± 16%  interrupts.CPU23.CAL:Function_call_interrupts
    328262 ±  4%     -31.0%     226481 ±  2%  interrupts.CPU23.LOC:Local_timer_interrupts
      7339 ± 24%     -77.1%       1683 ± 85%  interrupts.CPU23.NMI:Non-maskable_interrupts
      7339 ± 24%     -77.1%       1683 ± 85%  interrupts.CPU23.PMI:Performance_monitoring_interrupts
    992607 ± 15%     -54.9%     447403 ± 20%  interrupts.CPU23.RES:Rescheduling_interrupts
    257592 ±  8%     -61.1%     100080 ±  9%  interrupts.CPU23.TLB:TLB_shootdowns
    325403 ± 10%     -43.0%     185384 ± 20%  interrupts.CPU24.CAL:Function_call_interrupts
    329373 ±  3%     -31.2%     226469 ±  2%  interrupts.CPU24.LOC:Local_timer_interrupts
      6884 ± 30%     -71.8%       1943 ± 77%  interrupts.CPU24.NMI:Non-maskable_interrupts
      6884 ± 30%     -71.8%       1943 ± 77%  interrupts.CPU24.PMI:Performance_monitoring_interrupts
    917989 ± 14%     -46.3%     492660 ± 10%  interrupts.CPU24.RES:Rescheduling_interrupts
    257861 ±  8%     -60.7%     101288 ±  8%  interrupts.CPU24.TLB:TLB_shootdowns
    296975 ± 12%     -51.0%     145416 ±  9%  interrupts.CPU25.CAL:Function_call_interrupts
    329350 ±  3%     -31.2%     226475 ±  2%  interrupts.CPU25.LOC:Local_timer_interrupts
      6852 ± 29%     -71.9%       1922 ± 78%  interrupts.CPU25.NMI:Non-maskable_interrupts
      6852 ± 29%     -71.9%       1922 ± 78%  interrupts.CPU25.PMI:Performance_monitoring_interrupts
    947588 ± 15%     -39.6%     572182 ± 14%  interrupts.CPU25.RES:Rescheduling_interrupts
    258058 ±  8%     -61.6%      99016 ±  9%  interrupts.CPU25.TLB:TLB_shootdowns
    317336 ± 17%     -46.7%     169172 ± 19%  interrupts.CPU26.CAL:Function_call_interrupts
    329352 ±  3%     -31.2%     226467 ±  2%  interrupts.CPU26.LOC:Local_timer_interrupts
      7406 ± 25%     -74.0%       1926 ± 77%  interrupts.CPU26.NMI:Non-maskable_interrupts
      7406 ± 25%     -74.0%       1926 ± 77%  interrupts.CPU26.PMI:Performance_monitoring_interrupts
    961402 ± 12%     -49.9%     481353 ± 25%  interrupts.CPU26.RES:Rescheduling_interrupts
    257884 ±  8%     -61.4%      99593 ±  8%  interrupts.CPU26.TLB:TLB_shootdowns
    291767 ± 11%     -55.2%     130639 ± 13%  interrupts.CPU27.CAL:Function_call_interrupts
    329436 ±  3%     -31.3%     226340 ±  2%  interrupts.CPU27.LOC:Local_timer_interrupts
      7887 ± 17%     -75.7%       1914 ± 78%  interrupts.CPU27.NMI:Non-maskable_interrupts
      7887 ± 17%     -75.7%       1914 ± 78%  interrupts.CPU27.PMI:Performance_monitoring_interrupts
    946201 ± 11%     -43.1%     538306 ±  7%  interrupts.CPU27.RES:Rescheduling_interrupts
    257513 ±  8%     -62.5%      96565 ±  6%  interrupts.CPU27.TLB:TLB_shootdowns
    282775 ± 14%     -51.9%     136105 ± 27%  interrupts.CPU28.CAL:Function_call_interrupts
    329443 ±  3%     -31.4%     226089 ±  2%  interrupts.CPU28.LOC:Local_timer_interrupts
      7890 ± 17%     -76.2%       1874 ± 71%  interrupts.CPU28.NMI:Non-maskable_interrupts
      7890 ± 17%     -76.2%       1874 ± 71%  interrupts.CPU28.PMI:Performance_monitoring_interrupts
    950744 ± 11%     -43.5%     537112 ±  9%  interrupts.CPU28.RES:Rescheduling_interrupts
    257641 ±  8%     -61.5%      99244 ± 10%  interrupts.CPU28.TLB:TLB_shootdowns
    278409 ± 11%     -45.9%     150484 ± 25%  interrupts.CPU29.CAL:Function_call_interrupts
    329230 ±  3%     -31.2%     226476 ±  2%  interrupts.CPU29.LOC:Local_timer_interrupts
      7349 ± 23%     -67.4%       2399 ± 71%  interrupts.CPU29.NMI:Non-maskable_interrupts
      7349 ± 23%     -67.4%       2399 ± 71%  interrupts.CPU29.PMI:Performance_monitoring_interrupts
   1000968 ± 16%     -41.1%     589809 ± 11%  interrupts.CPU29.RES:Rescheduling_interrupts
    257552 ±  8%     -61.5%      99039 ±  9%  interrupts.CPU29.TLB:TLB_shootdowns
    316541 ± 12%     -44.9%     174481 ± 25%  interrupts.CPU3.CAL:Function_call_interrupts
    328327 ±  4%     -31.0%     226509 ±  2%  interrupts.CPU3.LOC:Local_timer_interrupts
      6861 ± 31%     -64.6%       2429 ± 71%  interrupts.CPU3.NMI:Non-maskable_interrupts
      6861 ± 31%     -64.6%       2429 ± 71%  interrupts.CPU3.PMI:Performance_monitoring_interrupts
    984816 ±  9%     -56.0%     433664 ± 24%  interrupts.CPU3.RES:Rescheduling_interrupts
    257601 ±  8%     -60.5%     101857 ±  8%  interrupts.CPU3.TLB:TLB_shootdowns
    281084 ±  6%     -54.2%     128694 ±  8%  interrupts.CPU30.CAL:Function_call_interrupts
    329408 ±  3%     -31.3%     226420 ±  2%  interrupts.CPU30.LOC:Local_timer_interrupts
      7888 ± 17%     -77.8%       1747 ± 90%  interrupts.CPU30.NMI:Non-maskable_interrupts
      7888 ± 17%     -77.8%       1747 ± 90%  interrupts.CPU30.PMI:Performance_monitoring_interrupts
    997082 ± 12%     -43.0%     568591 ± 13%  interrupts.CPU30.RES:Rescheduling_interrupts
    257479 ±  8%     -61.4%      99269 ±  8%  interrupts.CPU30.TLB:TLB_shootdowns
    279858 ± 10%     -48.1%     145307 ± 11%  interrupts.CPU31.CAL:Function_call_interrupts
    329413 ±  3%     -31.2%     226476 ±  2%  interrupts.CPU31.LOC:Local_timer_interrupts
      6875 ± 29%     -74.9%       1727 ± 92%  interrupts.CPU31.NMI:Non-maskable_interrupts
      6875 ± 29%     -74.9%       1727 ± 92%  interrupts.CPU31.PMI:Performance_monitoring_interrupts
    257625 ±  8%     -61.7%      98704 ±  9%  interrupts.CPU31.TLB:TLB_shootdowns
    288220 ±  8%     -42.5%     165655 ± 27%  interrupts.CPU32.CAL:Function_call_interrupts
    329427 ±  3%     -31.2%     226504 ±  2%  interrupts.CPU32.LOC:Local_timer_interrupts
      6826 ± 29%     -74.4%       1745 ± 90%  interrupts.CPU32.NMI:Non-maskable_interrupts
      6826 ± 29%     -74.4%       1745 ± 90%  interrupts.CPU32.PMI:Performance_monitoring_interrupts
   1006176 ± 15%     -45.4%     549214 ±  6%  interrupts.CPU32.RES:Rescheduling_interrupts
    257518 ±  8%     -61.4%      99351 ±  8%  interrupts.CPU32.TLB:TLB_shootdowns
    297454 ± 18%     -45.8%     161171 ± 17%  interrupts.CPU33.CAL:Function_call_interrupts
    329361 ±  3%     -31.3%     226426 ±  2%  interrupts.CPU33.LOC:Local_timer_interrupts
      7345 ± 23%     -76.4%       1733 ± 91%  interrupts.CPU33.NMI:Non-maskable_interrupts
      7345 ± 23%     -76.4%       1733 ± 91%  interrupts.CPU33.PMI:Performance_monitoring_interrupts
    989218 ± 16%     -41.0%     583512 ± 16%  interrupts.CPU33.RES:Rescheduling_interrupts
    258002 ±  8%     -61.6%      99027 ±  8%  interrupts.CPU33.TLB:TLB_shootdowns
    290851 ± 15%     -50.3%     144475 ± 11%  interrupts.CPU34.CAL:Function_call_interrupts
    329450 ±  3%     -31.3%     226482 ±  2%  interrupts.CPU34.LOC:Local_timer_interrupts
      7889 ± 17%     -84.7%       1203 ± 69%  interrupts.CPU34.NMI:Non-maskable_interrupts
      7889 ± 17%     -84.7%       1203 ± 69%  interrupts.CPU34.PMI:Performance_monitoring_interrupts
   1003841 ± 10%     -43.2%     570172 ±  5%  interrupts.CPU34.RES:Rescheduling_interrupts
    257792 ±  8%     -61.8%      98381 ±  8%  interrupts.CPU34.TLB:TLB_shootdowns
    294443 ± 12%     -49.0%     150045 ± 26%  interrupts.CPU35.CAL:Function_call_interrupts
    329437 ±  3%     -31.3%     226356 ±  2%  interrupts.CPU35.LOC:Local_timer_interrupts
      7893 ± 17%     -77.8%       1753 ± 89%  interrupts.CPU35.NMI:Non-maskable_interrupts
      7893 ± 17%     -77.8%       1753 ± 89%  interrupts.CPU35.PMI:Performance_monitoring_interrupts
   1036804 ± 13%     -50.2%     516591 ±  7%  interrupts.CPU35.RES:Rescheduling_interrupts
    257543 ±  8%     -61.5%      99160 ±  9%  interrupts.CPU35.TLB:TLB_shootdowns
    295820 ± 13%     -52.9%     139410 ± 21%  interrupts.CPU36.CAL:Function_call_interrupts
    329349 ±  3%     -31.2%     226430 ±  2%  interrupts.CPU36.LOC:Local_timer_interrupts
      6863 ± 30%     -74.5%       1751 ± 90%  interrupts.CPU36.NMI:Non-maskable_interrupts
      6863 ± 30%     -74.5%       1751 ± 90%  interrupts.CPU36.PMI:Performance_monitoring_interrupts
   1071023 ± 15%     -47.8%     558971 ± 16%  interrupts.CPU36.RES:Rescheduling_interrupts
    258012 ±  8%     -63.1%      95251 ± 13%  interrupts.CPU36.TLB:TLB_shootdowns
    277783 ± 16%     -43.6%     156565 ± 11%  interrupts.CPU37.CAL:Function_call_interrupts
    329400 ±  3%     -31.2%     226474 ±  2%  interrupts.CPU37.LOC:Local_timer_interrupts
      7896 ± 17%     -84.8%       1200 ± 70%  interrupts.CPU37.NMI:Non-maskable_interrupts
      7896 ± 17%     -84.8%       1200 ± 70%  interrupts.CPU37.PMI:Performance_monitoring_interrupts
    952802 ± 13%     -38.7%     583980 ± 17%  interrupts.CPU37.RES:Rescheduling_interrupts
    257311 ±  8%     -61.5%      99059 ±  9%  interrupts.CPU37.TLB:TLB_shootdowns
    286325 ± 11%     -48.4%     147670 ± 18%  interrupts.CPU38.CAL:Function_call_interrupts
    329327 ±  3%     -31.2%     226534 ±  2%  interrupts.CPU38.LOC:Local_timer_interrupts
      7910 ± 18%     -77.8%       1752 ± 90%  interrupts.CPU38.NMI:Non-maskable_interrupts
      7910 ± 18%     -77.8%       1752 ± 90%  interrupts.CPU38.PMI:Performance_monitoring_interrupts
    973888 ± 12%     -40.7%     577819 ± 14%  interrupts.CPU38.RES:Rescheduling_interrupts
    256325 ±  9%     -61.2%      99546 ±  8%  interrupts.CPU38.TLB:TLB_shootdowns
    297398 ± 12%     -52.3%     141876 ± 18%  interrupts.CPU39.CAL:Function_call_interrupts
    329263 ±  3%     -31.2%     226451 ±  2%  interrupts.CPU39.LOC:Local_timer_interrupts
      6834 ± 29%     -79.2%       1422 ± 55%  interrupts.CPU39.NMI:Non-maskable_interrupts
      6834 ± 29%     -79.2%       1422 ± 55%  interrupts.CPU39.PMI:Performance_monitoring_interrupts
   1024629 ± 13%     -53.0%     481818 ± 10%  interrupts.CPU39.RES:Rescheduling_interrupts
    257640 ±  8%     -61.8%      98515 ±  9%  interrupts.CPU39.TLB:TLB_shootdowns
    301038 ± 11%     -53.0%     141491 ± 11%  interrupts.CPU4.CAL:Function_call_interrupts
    328002 ±  4%     -31.0%     226275 ±  2%  interrupts.CPU4.LOC:Local_timer_interrupts
      6860 ± 31%     -67.5%       2227 ± 83%  interrupts.CPU4.NMI:Non-maskable_interrupts
      6860 ± 31%     -67.5%       2227 ± 83%  interrupts.CPU4.PMI:Performance_monitoring_interrupts
   1024213 ±  9%     -54.6%     465200 ± 19%  interrupts.CPU4.RES:Rescheduling_interrupts
    258641 ±  8%     -61.3%     100129 ±  9%  interrupts.CPU4.TLB:TLB_shootdowns
    267397 ±  8%     -40.9%     157964 ± 19%  interrupts.CPU40.CAL:Function_call_interrupts
    329392 ±  3%     -31.3%     226382 ±  2%  interrupts.CPU40.LOC:Local_timer_interrupts
      7917 ± 18%     -69.4%       2419 ± 70%  interrupts.CPU40.NMI:Non-maskable_interrupts
      7917 ± 18%     -69.4%       2419 ± 70%  interrupts.CPU40.PMI:Performance_monitoring_interrupts
    970946 ± 12%     -50.4%     481375 ± 19%  interrupts.CPU40.RES:Rescheduling_interrupts
    257705 ±  8%     -61.5%      99200 ±  9%  interrupts.CPU40.TLB:TLB_shootdowns
    286029 ± 11%     -53.9%     131765 ± 12%  interrupts.CPU41.CAL:Function_call_interrupts
    329404 ±  3%     -31.3%     226432 ±  2%  interrupts.CPU41.LOC:Local_timer_interrupts
      7889 ± 17%     -76.1%       1883 ± 69%  interrupts.CPU41.NMI:Non-maskable_interrupts
      7889 ± 17%     -76.1%       1883 ± 69%  interrupts.CPU41.PMI:Performance_monitoring_interrupts
    952892 ± 10%     -36.1%     609302 ±  9%  interrupts.CPU41.RES:Rescheduling_interrupts
    257852 ±  8%     -61.8%      98397 ±  8%  interrupts.CPU41.TLB:TLB_shootdowns
    291135 ±  6%     -53.2%     136354 ± 11%  interrupts.CPU42.CAL:Function_call_interrupts
    329260 ±  3%     -31.2%     226408 ±  2%  interrupts.CPU42.LOC:Local_timer_interrupts
      7887 ± 17%     -76.0%       1889 ± 69%  interrupts.CPU42.NMI:Non-maskable_interrupts
      7887 ± 17%     -76.0%       1889 ± 69%  interrupts.CPU42.PMI:Performance_monitoring_interrupts
    975110 ± 12%     -42.6%     560002 ±  3%  interrupts.CPU42.RES:Rescheduling_interrupts
    257712 ±  8%     -61.8%      98479 ±  9%  interrupts.CPU42.TLB:TLB_shootdowns
    273777 ± 12%     -47.3%     144400 ± 18%  interrupts.CPU43.CAL:Function_call_interrupts
    329270 ±  3%     -31.3%     226347 ±  2%  interrupts.CPU43.LOC:Local_timer_interrupts
      7343 ± 23%     -67.1%       2416 ± 70%  interrupts.CPU43.NMI:Non-maskable_interrupts
      7343 ± 23%     -67.1%       2416 ± 70%  interrupts.CPU43.PMI:Performance_monitoring_interrupts
   1000825 ± 15%     -50.0%     500857 ± 15%  interrupts.CPU43.RES:Rescheduling_interrupts
    257617 ±  8%     -60.6%     101485 ±  8%  interrupts.CPU43.TLB:TLB_shootdowns
    268947 ± 10%     -43.2%     152684 ± 23%  interrupts.CPU44.CAL:Function_call_interrupts
    329293 ±  3%     -31.2%     226471 ±  2%  interrupts.CPU44.LOC:Local_timer_interrupts
      7889 ± 17%     -69.4%       2415 ± 69%  interrupts.CPU44.NMI:Non-maskable_interrupts
      7889 ± 17%     -69.4%       2415 ± 69%  interrupts.CPU44.PMI:Performance_monitoring_interrupts
   1048726 ± 12%     -48.5%     539647 ± 12%  interrupts.CPU44.RES:Rescheduling_interrupts
    257971 ±  8%     -61.7%      98891 ±  9%  interrupts.CPU44.TLB:TLB_shootdowns
    261929 ± 10%     -35.7%     168427 ± 28%  interrupts.CPU45.CAL:Function_call_interrupts
    329304 ±  3%     -31.2%     226467 ±  2%  interrupts.CPU45.LOC:Local_timer_interrupts
      7343 ± 23%     -67.4%       2392 ± 71%  interrupts.CPU45.NMI:Non-maskable_interrupts
      7343 ± 23%     -67.4%       2392 ± 71%  interrupts.CPU45.PMI:Performance_monitoring_interrupts
    981783 ± 13%     -39.7%     591701 ± 11%  interrupts.CPU45.RES:Rescheduling_interrupts
    258214 ±  8%     -61.0%     100609 ±  8%  interrupts.CPU45.TLB:TLB_shootdowns
    275744 ± 13%     -47.3%     145433 ± 10%  interrupts.CPU46.CAL:Function_call_interrupts
    329209 ±  3%     -31.2%     226487 ±  2%  interrupts.CPU46.LOC:Local_timer_interrupts
      8432 ±  3%     -71.6%       2391 ± 71%  interrupts.CPU46.NMI:Non-maskable_interrupts
      8432 ±  3%     -71.6%       2391 ± 71%  interrupts.CPU46.PMI:Performance_monitoring_interrupts
   1001431 ± 14%     -46.5%     535429 ± 12%  interrupts.CPU46.RES:Rescheduling_interrupts
    257389 ±  8%     -61.5%      99138 ±  9%  interrupts.CPU46.TLB:TLB_shootdowns
    270093 ±  8%     -42.6%     154963 ± 10%  interrupts.CPU47.CAL:Function_call_interrupts
    329361 ±  3%     -31.2%     226468 ±  2%  interrupts.CPU47.LOC:Local_timer_interrupts
      7916 ± 18%     -76.6%       1855 ± 71%  interrupts.CPU47.NMI:Non-maskable_interrupts
      7916 ± 18%     -76.6%       1855 ± 71%  interrupts.CPU47.PMI:Performance_monitoring_interrupts
    960885 ± 12%     -40.0%     576882 ± 10%  interrupts.CPU47.RES:Rescheduling_interrupts
    257681 ±  8%     -61.4%      99569 ±  9%  interrupts.CPU47.TLB:TLB_shootdowns
    333803 ± 13%     -47.2%     176387 ± 12%  interrupts.CPU48.CAL:Function_call_interrupts
    329199 ±  3%     -31.2%     226522 ±  2%  interrupts.CPU48.LOC:Local_timer_interrupts
      7427 ± 26%     -67.5%       2415 ± 71%  interrupts.CPU48.NMI:Non-maskable_interrupts
      7427 ± 26%     -67.5%       2415 ± 71%  interrupts.CPU48.PMI:Performance_monitoring_interrupts
    925571 ± 10%     -48.8%     474040 ± 47%  interrupts.CPU48.RES:Rescheduling_interrupts
    257709 ±  8%     -61.4%      99585 ±  8%  interrupts.CPU48.TLB:TLB_shootdowns
    316629 ± 13%     -49.1%     161269 ± 14%  interrupts.CPU49.CAL:Function_call_interrupts
    329413 ±  3%     -31.2%     226514 ±  2%  interrupts.CPU49.LOC:Local_timer_interrupts
      7919 ± 18%     -69.6%       2410 ± 71%  interrupts.CPU49.NMI:Non-maskable_interrupts
      7919 ± 18%     -69.6%       2410 ± 71%  interrupts.CPU49.PMI:Performance_monitoring_interrupts
   1018515 ±  9%     -57.0%     437749 ± 31%  interrupts.CPU49.RES:Rescheduling_interrupts
    257205 ±  8%     -61.1%     100067 ±  9%  interrupts.CPU49.TLB:TLB_shootdowns
    296317 ± 11%     -50.5%     146753 ± 14%  interrupts.CPU5.CAL:Function_call_interrupts
    328304 ±  4%     -31.0%     226500 ±  2%  interrupts.CPU5.LOC:Local_timer_interrupts
      7886 ± 18%     -69.3%       2424 ± 71%  interrupts.CPU5.NMI:Non-maskable_interrupts
      7886 ± 18%     -69.3%       2424 ± 71%  interrupts.CPU5.PMI:Performance_monitoring_interrupts
   1050724 ±  9%     -53.5%     488807 ± 30%  interrupts.CPU5.RES:Rescheduling_interrupts
    258389 ±  8%     -61.2%     100275 ±  9%  interrupts.CPU5.TLB:TLB_shootdowns
    294043 ± 10%     -47.8%     153480 ± 17%  interrupts.CPU50.CAL:Function_call_interrupts
    329467 ±  3%     -31.3%     226298 ±  2%  interrupts.CPU50.LOC:Local_timer_interrupts
      8429 ±  3%     -71.2%       2428 ± 71%  interrupts.CPU50.NMI:Non-maskable_interrupts
      8429 ±  3%     -71.2%       2428 ± 71%  interrupts.CPU50.PMI:Performance_monitoring_interrupts
   1052143 ±  6%     -55.2%     470958 ± 23%  interrupts.CPU50.RES:Rescheduling_interrupts
    257377 ±  8%     -61.1%     100132 ±  8%  interrupts.CPU50.TLB:TLB_shootdowns
    309467 ±  9%     -47.8%     161585 ± 17%  interrupts.CPU51.CAL:Function_call_interrupts
    329355 ±  3%     -31.2%     226545 ±  2%  interrupts.CPU51.LOC:Local_timer_interrupts
      8431 ±  3%     -71.3%       2416 ± 71%  interrupts.CPU51.NMI:Non-maskable_interrupts
      8431 ±  3%     -71.3%       2416 ± 71%  interrupts.CPU51.PMI:Performance_monitoring_interrupts
   1031318 ± 10%     -47.6%     540847 ± 36%  interrupts.CPU51.RES:Rescheduling_interrupts
    256974 ±  8%     -61.1%      99865 ±  8%  interrupts.CPU51.TLB:TLB_shootdowns
    295006 ±  9%     -54.6%     133974 ± 10%  interrupts.CPU52.CAL:Function_call_interrupts
    329391 ±  3%     -31.2%     226512 ±  2%  interrupts.CPU52.LOC:Local_timer_interrupts
      7884 ± 17%     -69.5%       2408 ± 71%  interrupts.CPU52.NMI:Non-maskable_interrupts
      7884 ± 17%     -69.5%       2408 ± 71%  interrupts.CPU52.PMI:Performance_monitoring_interrupts
   1000151 ± 15%     -54.5%     454805 ± 28%  interrupts.CPU52.RES:Rescheduling_interrupts
    256899 ±  8%     -61.4%      99244 ±  9%  interrupts.CPU52.TLB:TLB_shootdowns
    300829 ±  9%     -53.8%     139104 ± 25%  interrupts.CPU53.CAL:Function_call_interrupts
    329397 ±  3%     -31.2%     226488 ±  2%  interrupts.CPU53.LOC:Local_timer_interrupts
      7879 ± 17%     -69.3%       2419 ± 71%  interrupts.CPU53.NMI:Non-maskable_interrupts
      7879 ± 17%     -69.3%       2419 ± 71%  interrupts.CPU53.PMI:Performance_monitoring_interrupts
   1004034 ± 14%     -57.0%     432029 ± 20%  interrupts.CPU53.RES:Rescheduling_interrupts
    257083 ±  8%     -61.4%      99221 ±  8%  interrupts.CPU53.TLB:TLB_shootdowns
    301215 ± 10%     -52.1%     144334 ± 14%  interrupts.CPU54.CAL:Function_call_interrupts
    329443 ±  3%     -31.3%     226479 ±  2%  interrupts.CPU54.LOC:Local_timer_interrupts
      7917 ± 18%     -69.6%       2410 ± 71%  interrupts.CPU54.NMI:Non-maskable_interrupts
      7917 ± 18%     -69.6%       2410 ± 71%  interrupts.CPU54.PMI:Performance_monitoring_interrupts
   1005736 ± 11%     -53.5%     467956 ± 24%  interrupts.CPU54.RES:Rescheduling_interrupts
    257364 ±  8%     -61.4%      99411 ±  9%  interrupts.CPU54.TLB:TLB_shootdowns
    292699 ± 11%     -53.1%     137364 ± 16%  interrupts.CPU55.CAL:Function_call_interrupts
    329296 ±  3%     -31.2%     226486 ±  2%  interrupts.CPU55.LOC:Local_timer_interrupts
      7899 ± 17%     -69.5%       2408 ± 71%  interrupts.CPU55.NMI:Non-maskable_interrupts
      7899 ± 17%     -69.5%       2408 ± 71%  interrupts.CPU55.PMI:Performance_monitoring_interrupts
   1043666 ± 13%     -52.8%     492283 ± 31%  interrupts.CPU55.RES:Rescheduling_interrupts
    257128 ±  8%     -61.5%      98903 ±  8%  interrupts.CPU55.TLB:TLB_shootdowns
    297590 ± 11%     -43.1%     169347 ± 27%  interrupts.CPU56.CAL:Function_call_interrupts
    329367 ±  3%     -31.2%     226493 ±  2%  interrupts.CPU56.LOC:Local_timer_interrupts
      7333 ± 23%     -67.0%       2418 ± 72%  interrupts.CPU56.NMI:Non-maskable_interrupts
      7333 ± 23%     -67.0%       2418 ± 72%  interrupts.CPU56.PMI:Performance_monitoring_interrupts
    988101 ± 11%     -53.2%     462172 ± 32%  interrupts.CPU56.RES:Rescheduling_interrupts
    257398 ±  8%     -61.0%     100483 ±  7%  interrupts.CPU56.TLB:TLB_shootdowns
    285497 ±  8%     -52.6%     135451 ±  8%  interrupts.CPU57.CAL:Function_call_interrupts
    329383 ±  3%     -31.2%     226509 ±  2%  interrupts.CPU57.LOC:Local_timer_interrupts
      7878 ± 17%     -69.4%       2409 ± 71%  interrupts.CPU57.NMI:Non-maskable_interrupts
      7878 ± 17%     -69.4%       2409 ± 71%  interrupts.CPU57.PMI:Performance_monitoring_interrupts
   1046177 ± 13%     -59.4%     424329 ± 29%  interrupts.CPU57.RES:Rescheduling_interrupts
    257193 ±  8%     -61.4%      99168 ±  8%  interrupts.CPU57.TLB:TLB_shootdowns
    284270 ±  8%     -53.0%     133640 ±  8%  interrupts.CPU58.CAL:Function_call_interrupts
    329492 ±  3%     -31.3%     226495 ±  2%  interrupts.CPU58.LOC:Local_timer_interrupts
      8424 ±  3%     -71.4%       2410 ± 72%  interrupts.CPU58.NMI:Non-maskable_interrupts
      8424 ±  3%     -71.4%       2410 ± 72%  interrupts.CPU58.PMI:Performance_monitoring_interrupts
   1066560 ± 13%     -49.6%     537666 ± 25%  interrupts.CPU58.RES:Rescheduling_interrupts
    257266 ±  8%     -61.2%      99768 ±  9%  interrupts.CPU58.TLB:TLB_shootdowns
    287464 ±  9%     -48.0%     149555 ± 10%  interrupts.CPU59.CAL:Function_call_interrupts
    329182 ±  3%     -31.2%     226469 ±  2%  interrupts.CPU59.LOC:Local_timer_interrupts
      7872 ± 17%     -69.2%       2423 ± 71%  interrupts.CPU59.NMI:Non-maskable_interrupts
      7872 ± 17%     -69.2%       2423 ± 71%  interrupts.CPU59.PMI:Performance_monitoring_interrupts
   1016616 ± 17%     -48.6%     522716 ± 21%  interrupts.CPU59.RES:Rescheduling_interrupts
    257464 ±  8%     -61.5%      99009 ±  9%  interrupts.CPU59.TLB:TLB_shootdowns
    304035 ± 22%     -54.3%     139042 ± 16%  interrupts.CPU6.CAL:Function_call_interrupts
    328186 ±  4%     -31.0%     226507 ±  2%  interrupts.CPU6.LOC:Local_timer_interrupts
      7881 ± 18%     -69.4%       2411 ± 72%  interrupts.CPU6.NMI:Non-maskable_interrupts
      7881 ± 18%     -69.4%       2411 ± 72%  interrupts.CPU6.PMI:Performance_monitoring_interrupts
   1075794 ± 15%     -53.2%     503712 ± 29%  interrupts.CPU6.RES:Rescheduling_interrupts
    257714 ±  8%     -60.7%     101232 ±  9%  interrupts.CPU6.TLB:TLB_shootdowns
    282725 ± 10%     -50.1%     141050 ± 16%  interrupts.CPU60.CAL:Function_call_interrupts
    329414 ±  3%     -31.2%     226516 ±  2%  interrupts.CPU60.LOC:Local_timer_interrupts
      7915 ± 18%     -69.5%       2412 ± 71%  interrupts.CPU60.NMI:Non-maskable_interrupts
      7915 ± 18%     -69.5%       2412 ± 71%  interrupts.CPU60.PMI:Performance_monitoring_interrupts
    966735 ± 16%     -49.4%     489326 ± 19%  interrupts.CPU60.RES:Rescheduling_interrupts
    257175 ±  8%     -61.2%      99782 ±  7%  interrupts.CPU60.TLB:TLB_shootdowns
    296081 ±  7%     -46.9%     157345 ± 12%  interrupts.CPU61.CAL:Function_call_interrupts
    329339 ±  3%     -31.2%     226498 ±  2%  interrupts.CPU61.LOC:Local_timer_interrupts
      8418 ±  3%     -71.4%       2410 ± 72%  interrupts.CPU61.NMI:Non-maskable_interrupts
      8418 ±  3%     -71.4%       2410 ± 72%  interrupts.CPU61.PMI:Performance_monitoring_interrupts
   1037288 ± 11%     -47.9%     540345 ± 27%  interrupts.CPU61.RES:Rescheduling_interrupts
    257015 ±  8%     -61.1%      99901 ±  8%  interrupts.CPU61.TLB:TLB_shootdowns
    286040 ±  9%     -36.3%     182157 ± 20%  interrupts.CPU62.CAL:Function_call_interrupts
    329479 ±  3%     -31.3%     226490 ±  2%  interrupts.CPU62.LOC:Local_timer_interrupts
      8422 ±  3%     -71.3%       2416 ± 71%  interrupts.CPU62.NMI:Non-maskable_interrupts
      8422 ±  3%     -71.3%       2416 ± 71%  interrupts.CPU62.PMI:Performance_monitoring_interrupts
   1021421 ± 11%     -54.1%     468444 ± 19%  interrupts.CPU62.RES:Rescheduling_interrupts
    257466 ±  8%     -61.5%      99173 ±  9%  interrupts.CPU62.TLB:TLB_shootdowns
    287996 ± 11%     -44.4%     160138 ± 25%  interrupts.CPU63.CAL:Function_call_interrupts
    329424 ±  3%     -31.3%     226460 ±  2%  interrupts.CPU63.LOC:Local_timer_interrupts
      8422 ±  3%     -71.3%       2420 ± 71%  interrupts.CPU63.NMI:Non-maskable_interrupts
      8422 ±  3%     -71.3%       2420 ± 71%  interrupts.CPU63.PMI:Performance_monitoring_interrupts
   1041051 ±  8%     -48.8%     533367 ± 33%  interrupts.CPU63.RES:Rescheduling_interrupts
    257423 ±  8%     -61.5%      99140 ±  8%  interrupts.CPU63.TLB:TLB_shootdowns
    303408 ± 11%     -58.1%     126986 ±  7%  interrupts.CPU64.CAL:Function_call_interrupts
    329441 ±  3%     -31.2%     226495 ±  2%  interrupts.CPU64.LOC:Local_timer_interrupts
      8427 ±  3%     -71.4%       2413 ± 71%  interrupts.CPU64.NMI:Non-maskable_interrupts
      8427 ±  3%     -71.4%       2413 ± 71%  interrupts.CPU64.PMI:Performance_monitoring_interrupts
   1023620 ± 14%     -52.2%     489259 ± 22%  interrupts.CPU64.RES:Rescheduling_interrupts
    257388 ±  8%     -60.9%     100648 ±  9%  interrupts.CPU64.TLB:TLB_shootdowns
    298638 ±  9%     -59.3%     121396 ± 13%  interrupts.CPU65.CAL:Function_call_interrupts
    329338 ±  3%     -31.2%     226497 ±  2%  interrupts.CPU65.LOC:Local_timer_interrupts
      8415 ±  3%     -71.3%       2417 ± 71%  interrupts.CPU65.NMI:Non-maskable_interrupts
      8415 ±  3%     -71.3%       2417 ± 71%  interrupts.CPU65.PMI:Performance_monitoring_interrupts
   1072871 ± 13%     -54.2%     491802 ± 34%  interrupts.CPU65.RES:Rescheduling_interrupts
    257271 ±  8%     -61.0%     100415 ±  7%  interrupts.CPU65.TLB:TLB_shootdowns
    267627 ± 11%     -47.0%     141834 ±  3%  interrupts.CPU66.CAL:Function_call_interrupts
    329362 ±  3%     -31.2%     226476 ±  2%  interrupts.CPU66.LOC:Local_timer_interrupts
      7909 ± 18%     -69.5%       2410 ± 71%  interrupts.CPU66.NMI:Non-maskable_interrupts
      7909 ± 18%     -69.5%       2410 ± 71%  interrupts.CPU66.PMI:Performance_monitoring_interrupts
   1068255 ± 15%     -55.3%     477200 ± 27%  interrupts.CPU66.RES:Rescheduling_interrupts
    257065 ±  8%     -61.6%      98789 ±  8%  interrupts.CPU66.TLB:TLB_shootdowns
    285488 ±  8%     -42.5%     164131 ± 34%  interrupts.CPU67.CAL:Function_call_interrupts
    329471 ±  3%     -31.3%     226498 ±  2%  interrupts.CPU67.LOC:Local_timer_interrupts
      7907 ± 18%     -69.5%       2413 ± 71%  interrupts.CPU67.NMI:Non-maskable_interrupts
      7907 ± 18%     -69.5%       2413 ± 71%  interrupts.CPU67.PMI:Performance_monitoring_interrupts
   1018171 ±  9%     -57.1%     437172 ± 21%  interrupts.CPU67.RES:Rescheduling_interrupts
    257191 ±  8%     -61.3%      99498 ±  8%  interrupts.CPU67.TLB:TLB_shootdowns
    291580 ±  9%     -44.0%     163268 ± 28%  interrupts.CPU68.CAL:Function_call_interrupts
    329441 ±  3%     -31.2%     226491 ±  2%  interrupts.CPU68.LOC:Local_timer_interrupts
      7872 ± 17%     -69.5%       2400 ± 71%  interrupts.CPU68.NMI:Non-maskable_interrupts
      7872 ± 17%     -69.5%       2400 ± 71%  interrupts.CPU68.PMI:Performance_monitoring_interrupts
    993675 ±  8%     -49.5%     501893 ± 34%  interrupts.CPU68.RES:Rescheduling_interrupts
    256790 ±  8%     -61.3%      99334 ±  9%  interrupts.CPU68.TLB:TLB_shootdowns
    288171 ±  7%     -53.0%     135561 ± 23%  interrupts.CPU69.CAL:Function_call_interrupts
    329245 ±  3%     -31.2%     226517 ±  2%  interrupts.CPU69.LOC:Local_timer_interrupts
      7401 ± 25%     -67.5%       2408 ± 71%  interrupts.CPU69.NMI:Non-maskable_interrupts
      7401 ± 25%     -67.5%       2408 ± 71%  interrupts.CPU69.PMI:Performance_monitoring_interrupts
   1008007 ± 10%     -49.4%     510423 ± 22%  interrupts.CPU69.RES:Rescheduling_interrupts
    257543 ±  8%     -61.5%      99175 ±  9%  interrupts.CPU69.TLB:TLB_shootdowns
    303511 ± 19%     -58.8%     125186 ± 12%  interrupts.CPU7.CAL:Function_call_interrupts
    328114 ±  4%     -31.0%     226525 ±  2%  interrupts.CPU7.LOC:Local_timer_interrupts
      7887 ± 18%     -69.1%       2437 ± 71%  interrupts.CPU7.NMI:Non-maskable_interrupts
      7887 ± 18%     -69.1%       2437 ± 71%  interrupts.CPU7.PMI:Performance_monitoring_interrupts
   1081532 ± 10%     -52.8%     510480 ± 12%  interrupts.CPU7.RES:Rescheduling_interrupts
    257903 ±  8%     -61.0%     100505 ±  9%  interrupts.CPU7.TLB:TLB_shootdowns
    294871 ± 14%     -54.9%     133029 ± 10%  interrupts.CPU70.CAL:Function_call_interrupts
    329243 ±  3%     -31.2%     226504 ±  2%  interrupts.CPU70.LOC:Local_timer_interrupts
      7370 ± 25%     -67.4%       2402 ± 71%  interrupts.CPU70.NMI:Non-maskable_interrupts
      7370 ± 25%     -67.4%       2402 ± 71%  interrupts.CPU70.PMI:Performance_monitoring_interrupts
   1082787 ± 10%     -56.4%     472071 ± 25%  interrupts.CPU70.RES:Rescheduling_interrupts
    257511 ±  8%     -61.4%      99483 ±  9%  interrupts.CPU70.TLB:TLB_shootdowns
    289341 ±  9%     -52.5%     137405 ± 15%  interrupts.CPU71.CAL:Function_call_interrupts
    329291 ±  3%     -31.2%     226506 ±  2%  interrupts.CPU71.LOC:Local_timer_interrupts
      7928 ± 18%     -69.6%       2407 ± 71%  interrupts.CPU71.NMI:Non-maskable_interrupts
      7928 ± 18%     -69.6%       2407 ± 71%  interrupts.CPU71.PMI:Performance_monitoring_interrupts
   1071804 ± 12%     -58.0%     450286 ± 28%  interrupts.CPU71.RES:Rescheduling_interrupts
    257379 ±  8%     -61.4%      99269 ±  8%  interrupts.CPU71.TLB:TLB_shootdowns
    352011 ± 16%     -60.4%     139515 ±  8%  interrupts.CPU72.CAL:Function_call_interrupts
    329306 ±  3%     -31.3%     226378 ±  2%  interrupts.CPU72.LOC:Local_timer_interrupts
      7859 ± 18%     -69.3%       2409 ± 70%  interrupts.CPU72.NMI:Non-maskable_interrupts
      7859 ± 18%     -69.3%       2409 ± 70%  interrupts.CPU72.PMI:Performance_monitoring_interrupts
   1001903 ± 11%     -57.8%     422805 ± 13%  interrupts.CPU72.RES:Rescheduling_interrupts
    257277 ±  8%     -61.3%      99500 ±  9%  interrupts.CPU72.TLB:TLB_shootdowns
    295284 ± 10%     -54.2%     135118 ± 14%  interrupts.CPU73.CAL:Function_call_interrupts
    329333 ±  3%     -31.2%     226514 ±  2%  interrupts.CPU73.LOC:Local_timer_interrupts
      7887 ± 19%     -69.7%       2386 ± 71%  interrupts.CPU73.NMI:Non-maskable_interrupts
      7887 ± 19%     -69.7%       2386 ± 71%  interrupts.CPU73.PMI:Performance_monitoring_interrupts
   1074423 ± 13%     -55.1%     482615 ± 20%  interrupts.CPU73.RES:Rescheduling_interrupts
    257618 ±  8%     -61.4%      99385 ±  8%  interrupts.CPU73.TLB:TLB_shootdowns
    328933 ± 16%     -56.9%     141806 ± 21%  interrupts.CPU74.CAL:Function_call_interrupts
    329258 ±  3%     -31.2%     226518 ±  2%  interrupts.CPU74.LOC:Local_timer_interrupts
      6865 ± 32%     -65.4%       2375 ± 72%  interrupts.CPU74.NMI:Non-maskable_interrupts
      6865 ± 32%     -65.4%       2375 ± 72%  interrupts.CPU74.PMI:Performance_monitoring_interrupts
   1131617 ± 10%     -53.4%     527448 ± 20%  interrupts.CPU74.RES:Rescheduling_interrupts
    257663 ±  8%     -61.5%      99248 ±  8%  interrupts.CPU74.TLB:TLB_shootdowns
    289524 ±  7%     -42.6%     166273 ±  8%  interrupts.CPU75.CAL:Function_call_interrupts
    329410 ±  3%     -31.3%     226455 ±  2%  interrupts.CPU75.LOC:Local_timer_interrupts
      7846 ± 18%     -69.6%       2389 ± 72%  interrupts.CPU75.NMI:Non-maskable_interrupts
      7846 ± 18%     -69.6%       2389 ± 72%  interrupts.CPU75.PMI:Performance_monitoring_interrupts
   1105068 ± 11%     -56.3%     482737 ± 19%  interrupts.CPU75.RES:Rescheduling_interrupts
    257342 ±  8%     -61.0%     100403 ±  8%  interrupts.CPU75.TLB:TLB_shootdowns
    290573 ± 10%     -53.8%     134186 ± 21%  interrupts.CPU76.CAL:Function_call_interrupts
    329278 ±  3%     -31.2%     226464 ±  2%  interrupts.CPU76.LOC:Local_timer_interrupts
      7851 ± 18%     -69.7%       2380 ± 73%  interrupts.CPU76.NMI:Non-maskable_interrupts
      7851 ± 18%     -69.7%       2380 ± 73%  interrupts.CPU76.PMI:Performance_monitoring_interrupts
   1109115 ± 10%     -52.7%     524334 ± 17%  interrupts.CPU76.RES:Rescheduling_interrupts
    257599 ±  8%     -61.4%      99465 ±  8%  interrupts.CPU76.TLB:TLB_shootdowns
    290588 ±  8%     -53.6%     134740 ±  3%  interrupts.CPU77.CAL:Function_call_interrupts
    329325 ±  3%     -31.2%     226419 ±  2%  interrupts.CPU77.LOC:Local_timer_interrupts
      7340 ± 25%     -67.7%       2370 ± 73%  interrupts.CPU77.NMI:Non-maskable_interrupts
      7340 ± 25%     -67.7%       2370 ± 73%  interrupts.CPU77.PMI:Performance_monitoring_interrupts
   1122768 ± 13%     -59.6%     453390 ± 18%  interrupts.CPU77.RES:Rescheduling_interrupts
    257333 ±  8%     -61.3%      99709 ±  9%  interrupts.CPU77.TLB:TLB_shootdowns
    291902 ±  9%     -50.1%     145786 ±  7%  interrupts.CPU78.CAL:Function_call_interrupts
    329296 ±  3%     -31.2%     226480 ±  2%  interrupts.CPU78.LOC:Local_timer_interrupts
      7341 ± 25%     -67.7%       2373 ± 72%  interrupts.CPU78.NMI:Non-maskable_interrupts
      7341 ± 25%     -67.7%       2373 ± 72%  interrupts.CPU78.PMI:Performance_monitoring_interrupts
   1145273 ± 17%     -61.7%     438903 ± 16%  interrupts.CPU78.RES:Rescheduling_interrupts
    257346 ±  8%     -61.3%      99501 ±  8%  interrupts.CPU78.TLB:TLB_shootdowns
    286476 ± 10%     -56.5%     124692 ±  9%  interrupts.CPU79.CAL:Function_call_interrupts
    329250 ±  3%     -31.2%     226469 ±  2%  interrupts.CPU79.LOC:Local_timer_interrupts
      7853 ± 18%     -69.7%       2377 ± 73%  interrupts.CPU79.NMI:Non-maskable_interrupts
      7853 ± 18%     -69.7%       2377 ± 73%  interrupts.CPU79.PMI:Performance_monitoring_interrupts
   1097859 ± 10%     -58.0%     460706 ± 17%  interrupts.CPU79.RES:Rescheduling_interrupts
    257417 ±  8%     -61.2%      99895 ±  8%  interrupts.CPU79.TLB:TLB_shootdowns
    294225 ± 19%     -52.1%     140922 ± 25%  interrupts.CPU8.CAL:Function_call_interrupts
    328318 ±  4%     -31.0%     226418 ±  2%  interrupts.CPU8.LOC:Local_timer_interrupts
      7885 ± 18%     -69.2%       2429 ± 71%  interrupts.CPU8.NMI:Non-maskable_interrupts
      7885 ± 18%     -69.2%       2429 ± 71%  interrupts.CPU8.PMI:Performance_monitoring_interrupts
   1034349 ±  9%     -47.7%     540931 ± 31%  interrupts.CPU8.RES:Rescheduling_interrupts
    258139 ±  8%     -61.5%      99447 ±  9%  interrupts.CPU8.TLB:TLB_shootdowns
    276733 ± 11%     -53.8%     127867 ± 14%  interrupts.CPU80.CAL:Function_call_interrupts
    329272 ±  3%     -31.2%     226498 ±  2%  interrupts.CPU80.LOC:Local_timer_interrupts
      6865 ± 32%     -65.4%       2372 ± 73%  interrupts.CPU80.NMI:Non-maskable_interrupts
      6865 ± 32%     -65.4%       2372 ± 73%  interrupts.CPU80.PMI:Performance_monitoring_interrupts
   1102910 ± 10%     -59.1%     450673 ± 16%  interrupts.CPU80.RES:Rescheduling_interrupts
    257250 ±  8%     -61.6%      98796 ±  8%  interrupts.CPU80.TLB:TLB_shootdowns
    298508 ± 11%     -50.9%     146709 ± 13%  interrupts.CPU81.CAL:Function_call_interrupts
    329151 ±  3%     -31.2%     226486 ±  2%  interrupts.CPU81.LOC:Local_timer_interrupts
      7374 ± 27%     -67.8%       2376 ± 73%  interrupts.CPU81.NMI:Non-maskable_interrupts
      7374 ± 27%     -67.8%       2376 ± 73%  interrupts.CPU81.PMI:Performance_monitoring_interrupts
   1124367 ± 11%     -57.3%     479652 ± 22%  interrupts.CPU81.RES:Rescheduling_interrupts
    257286 ±  8%     -61.2%      99748 ±  8%  interrupts.CPU81.TLB:TLB_shootdowns
    277822 ±  6%     -46.9%     147408 ± 10%  interrupts.CPU82.CAL:Function_call_interrupts
    329142 ±  3%     -31.2%     226542 ±  2%  interrupts.CPU82.LOC:Local_timer_interrupts
      7377 ± 27%     -67.5%       2395 ± 71%  interrupts.CPU82.NMI:Non-maskable_interrupts
      7377 ± 27%     -67.5%       2395 ± 71%  interrupts.CPU82.PMI:Performance_monitoring_interrupts
   1030318 ±  8%     -49.5%     520348 ± 29%  interrupts.CPU82.RES:Rescheduling_interrupts
    257167 ±  8%     -60.8%     100892 ±  7%  interrupts.CPU82.TLB:TLB_shootdowns
    294150 ± 15%     -51.7%     142121 ± 28%  interrupts.CPU83.CAL:Function_call_interrupts
    329272 ±  3%     -31.2%     226497 ±  2%  interrupts.CPU83.LOC:Local_timer_interrupts
      7378 ± 27%     -67.8%       2377 ± 72%  interrupts.CPU83.NMI:Non-maskable_interrupts
      7378 ± 27%     -67.8%       2377 ± 72%  interrupts.CPU83.PMI:Performance_monitoring_interrupts
   1075132 ±  9%     -53.9%     495366 ± 26%  interrupts.CPU83.RES:Rescheduling_interrupts
    257296 ±  8%     -61.5%      99156 ±  8%  interrupts.CPU83.TLB:TLB_shootdowns
    284501 ± 10%     -46.9%     151164 ± 14%  interrupts.CPU84.CAL:Function_call_interrupts
    329202 ±  3%     -31.2%     226484 ±  2%  interrupts.CPU84.LOC:Local_timer_interrupts
      7380 ± 27%     -67.7%       2383 ± 72%  interrupts.CPU84.NMI:Non-maskable_interrupts
      7380 ± 27%     -67.7%       2383 ± 72%  interrupts.CPU84.PMI:Performance_monitoring_interrupts
   1078161 ± 15%     -55.3%     482044 ± 25%  interrupts.CPU84.RES:Rescheduling_interrupts
    257133 ±  8%     -61.2%      99769 ±  8%  interrupts.CPU84.TLB:TLB_shootdowns
    276188 ± 10%     -39.5%     167212 ± 18%  interrupts.CPU85.CAL:Function_call_interrupts
    329199 ±  3%     -31.2%     226439 ±  2%  interrupts.CPU85.LOC:Local_timer_interrupts
      7378 ± 27%     -67.6%       2391 ± 72%  interrupts.CPU85.NMI:Non-maskable_interrupts
      7378 ± 27%     -67.6%       2391 ± 72%  interrupts.CPU85.PMI:Performance_monitoring_interrupts
   1092682 ± 14%     -56.6%     474517 ± 11%  interrupts.CPU85.RES:Rescheduling_interrupts
    256696 ±  8%     -60.4%     101532 ±  8%  interrupts.CPU85.TLB:TLB_shootdowns
    287225 ±  8%     -55.9%     126591 ± 22%  interrupts.CPU86.CAL:Function_call_interrupts
    329214 ±  3%     -31.2%     226373 ±  2%  interrupts.CPU86.LOC:Local_timer_interrupts
      7307 ± 24%     -67.4%       2382 ± 71%  interrupts.CPU86.NMI:Non-maskable_interrupts
      7307 ± 24%     -67.4%       2382 ± 71%  interrupts.CPU86.PMI:Performance_monitoring_interrupts
   1103865 ±  9%     -56.1%     484786 ±  6%  interrupts.CPU86.RES:Rescheduling_interrupts
    257415 ±  8%     -61.3%      99504 ±  8%  interrupts.CPU86.TLB:TLB_shootdowns
    290123 ± 14%     -50.8%     142784 ± 29%  interrupts.CPU87.CAL:Function_call_interrupts
    329335 ±  3%     -31.2%     226531 ±  2%  interrupts.CPU87.LOC:Local_timer_interrupts
      7854 ± 18%     -69.7%       2378 ± 72%  interrupts.CPU87.NMI:Non-maskable_interrupts
      7854 ± 18%     -69.7%       2378 ± 72%  interrupts.CPU87.PMI:Performance_monitoring_interrupts
   1140827 ± 11%     -57.3%     487678 ± 20%  interrupts.CPU87.RES:Rescheduling_interrupts
    257236 ±  8%     -61.0%     100445 ±  9%  interrupts.CPU87.TLB:TLB_shootdowns
    294640 ±  7%     -48.5%     151734 ± 42%  interrupts.CPU88.CAL:Function_call_interrupts
    329190 ±  3%     -31.2%     226451 ±  2%  interrupts.CPU88.LOC:Local_timer_interrupts
      7824 ± 17%     -69.5%       2385 ± 72%  interrupts.CPU88.NMI:Non-maskable_interrupts
      7824 ± 17%     -69.5%       2385 ± 72%  interrupts.CPU88.PMI:Performance_monitoring_interrupts
   1089044 ±  6%     -55.4%     485846 ± 14%  interrupts.CPU88.RES:Rescheduling_interrupts
    257098 ±  8%     -60.8%     100701 ±  8%  interrupts.CPU88.TLB:TLB_shootdowns
    292981 ± 10%     -50.2%     145843 ± 17%  interrupts.CPU89.CAL:Function_call_interrupts
    329288 ±  3%     -31.2%     226464 ±  2%  interrupts.CPU89.LOC:Local_timer_interrupts
      8363 ±  4%     -71.4%       2390 ± 71%  interrupts.CPU89.NMI:Non-maskable_interrupts
      8363 ±  4%     -71.4%       2390 ± 71%  interrupts.CPU89.PMI:Performance_monitoring_interrupts
   1113421 ± 10%     -59.0%     456503 ± 18%  interrupts.CPU89.RES:Rescheduling_interrupts
    257323 ±  8%     -61.2%      99727 ±  8%  interrupts.CPU89.TLB:TLB_shootdowns
    287972 ±  8%     -49.4%     145832 ± 15%  interrupts.CPU9.CAL:Function_call_interrupts
    328322 ±  4%     -31.0%     226489 ±  2%  interrupts.CPU9.LOC:Local_timer_interrupts
      7350 ± 24%     -67.1%       2419 ± 71%  interrupts.CPU9.NMI:Non-maskable_interrupts
      7350 ± 24%     -67.1%       2419 ± 71%  interrupts.CPU9.PMI:Performance_monitoring_interrupts
   1064529 ± 11%     -53.6%     494023 ± 23%  interrupts.CPU9.RES:Rescheduling_interrupts
    257793 ±  8%     -60.9%     100812 ±  9%  interrupts.CPU9.TLB:TLB_shootdowns
    294642 ± 16%     -46.3%     158295 ± 11%  interrupts.CPU90.CAL:Function_call_interrupts
    329237 ±  3%     -31.2%     226507 ±  2%  interrupts.CPU90.LOC:Local_timer_interrupts
      7314 ± 24%     -67.2%       2398 ± 70%  interrupts.CPU90.NMI:Non-maskable_interrupts
      7314 ± 24%     -67.2%       2398 ± 70%  interrupts.CPU90.PMI:Performance_monitoring_interrupts
   1170880 ± 11%     -58.1%     490032 ± 17%  interrupts.CPU90.RES:Rescheduling_interrupts
    257726 ±  8%     -60.7%     101321 ±  8%  interrupts.CPU90.TLB:TLB_shootdowns
    282677 ±  7%     -56.8%     122230 ±  9%  interrupts.CPU91.CAL:Function_call_interrupts
    329228 ±  3%     -31.2%     226480 ±  2%  interrupts.CPU91.LOC:Local_timer_interrupts
      7827 ± 17%     -69.5%       2388 ± 71%  interrupts.CPU91.NMI:Non-maskable_interrupts
      7827 ± 17%     -69.5%       2388 ± 71%  interrupts.CPU91.PMI:Performance_monitoring_interrupts
   1132881 ± 11%     -59.4%     459916 ± 25%  interrupts.CPU91.RES:Rescheduling_interrupts
    257380 ±  8%     -61.2%      99805 ±  8%  interrupts.CPU91.TLB:TLB_shootdowns
    280792 ±  8%     -51.7%     135605 ± 15%  interrupts.CPU92.CAL:Function_call_interrupts
    329306 ±  3%     -31.2%     226497 ±  2%  interrupts.CPU92.LOC:Local_timer_interrupts
      7824 ± 17%     -69.6%       2379 ± 72%  interrupts.CPU92.NMI:Non-maskable_interrupts
      7824 ± 17%     -69.6%       2379 ± 72%  interrupts.CPU92.PMI:Performance_monitoring_interrupts
   1116902 ± 11%     -57.8%     471493 ± 13%  interrupts.CPU92.RES:Rescheduling_interrupts
    257189 ±  8%     -61.2%      99816 ±  8%  interrupts.CPU92.TLB:TLB_shootdowns
    294998 ± 10%     -49.3%     149595 ±  8%  interrupts.CPU93.CAL:Function_call_interrupts
    329320 ±  3%     -31.2%     226475 ±  2%  interrupts.CPU93.LOC:Local_timer_interrupts
      7819 ± 17%     -69.3%       2397 ± 70%  interrupts.CPU93.NMI:Non-maskable_interrupts
      7819 ± 17%     -69.3%       2397 ± 70%  interrupts.CPU93.PMI:Performance_monitoring_interrupts
   1139150 ± 10%     -51.9%     547841 ± 18%  interrupts.CPU93.RES:Rescheduling_interrupts
    257094 ±  8%     -60.9%     100400 ±  9%  interrupts.CPU93.TLB:TLB_shootdowns
    277886 ± 10%     -47.2%     146614 ± 24%  interrupts.CPU94.CAL:Function_call_interrupts
    329231 ±  3%     -31.2%     226472 ±  2%  interrupts.CPU94.LOC:Local_timer_interrupts
      7819 ± 17%     -69.6%       2379 ± 71%  interrupts.CPU94.NMI:Non-maskable_interrupts
      7819 ± 17%     -69.6%       2379 ± 71%  interrupts.CPU94.PMI:Performance_monitoring_interrupts
   1138310 ± 11%     -54.8%     514545 ± 16%  interrupts.CPU94.RES:Rescheduling_interrupts
    257491 ±  8%     -61.1%     100254 ±  8%  interrupts.CPU94.TLB:TLB_shootdowns
    282333 ±  8%     -53.3%     131952 ± 18%  interrupts.CPU95.CAL:Function_call_interrupts
    329304 ±  3%     -31.2%     226485 ±  2%  interrupts.CPU95.LOC:Local_timer_interrupts
      7824 ± 17%     -69.7%       2372 ± 72%  interrupts.CPU95.NMI:Non-maskable_interrupts
      7824 ± 17%     -69.7%       2372 ± 72%  interrupts.CPU95.PMI:Performance_monitoring_interrupts
   1106751 ± 12%     -56.2%     484957 ± 24%  interrupts.CPU95.RES:Rescheduling_interrupts
    257610 ±  8%     -61.0%     100417 ±  8%  interrupts.CPU95.TLB:TLB_shootdowns
    311942 ± 13%     -39.7%     187988 ± 19%  interrupts.CPU96.CAL:Function_call_interrupts
    328191 ±  4%     -31.0%     226456 ±  2%  interrupts.CPU96.LOC:Local_timer_interrupts
      7869 ± 17%     -69.1%       2435 ± 70%  interrupts.CPU96.NMI:Non-maskable_interrupts
      7869 ± 17%     -69.1%       2435 ± 70%  interrupts.CPU96.PMI:Performance_monitoring_interrupts
    945943 ± 14%     -56.2%     414699 ± 18%  interrupts.CPU96.RES:Rescheduling_interrupts
    258163 ±  8%     -61.1%     100538 ±  9%  interrupts.CPU96.TLB:TLB_shootdowns
    316444 ± 12%     -49.2%     160607 ± 20%  interrupts.CPU97.CAL:Function_call_interrupts
    328296 ±  3%     -31.0%     226459 ±  2%  interrupts.CPU97.LOC:Local_timer_interrupts
      8403 ±  3%     -76.7%       1957 ± 78%  interrupts.CPU97.NMI:Non-maskable_interrupts
      8403 ±  3%     -76.7%       1957 ± 78%  interrupts.CPU97.PMI:Performance_monitoring_interrupts
    952147 ± 18%     -48.3%     491918 ± 30%  interrupts.CPU97.RES:Rescheduling_interrupts
    257618 ±  8%     -60.9%     100731 ±  9%  interrupts.CPU97.TLB:TLB_shootdowns
    300845 ±  9%     -55.4%     134094 ± 11%  interrupts.CPU98.CAL:Function_call_interrupts
    327854 ±  4%     -30.9%     226516 ±  2%  interrupts.CPU98.LOC:Local_timer_interrupts
      7892 ± 18%     -75.4%       1941 ± 79%  interrupts.CPU98.NMI:Non-maskable_interrupts
      7892 ± 18%     -75.4%       1941 ± 79%  interrupts.CPU98.PMI:Performance_monitoring_interrupts
   1043756 ± 13%     -59.1%     426407 ± 24%  interrupts.CPU98.RES:Rescheduling_interrupts
    257590 ±  8%     -60.9%     100652 ±  8%  interrupts.CPU98.TLB:TLB_shootdowns
    300265 ±  6%     -47.5%     157738 ± 21%  interrupts.CPU99.CAL:Function_call_interrupts
    328218 ±  4%     -31.0%     226496 ±  2%  interrupts.CPU99.LOC:Local_timer_interrupts
      8407 ±  3%     -76.8%       1949 ± 79%  interrupts.CPU99.NMI:Non-maskable_interrupts
      8407 ±  3%     -76.8%       1949 ± 79%  interrupts.CPU99.PMI:Performance_monitoring_interrupts
   1003079 ±  7%     -57.9%     421849 ± 21%  interrupts.CPU99.RES:Rescheduling_interrupts
    258167 ±  8%     -61.1%     100362 ±  9%  interrupts.CPU99.TLB:TLB_shootdowns
    359.75 ±  3%     -78.0%      79.25 ± 98%  interrupts.IWI:IRQ_work_interrupts
  63173825 ±  3%     -31.2%   43480379 ±  2%  interrupts.LOC:Local_timer_interrupts
   1499268 ±  3%     -72.4%     413311 ± 72%  interrupts.NMI:Non-maskable_interrupts
   1499268 ±  3%     -72.4%     413311 ± 72%  interrupts.PMI:Performance_monitoring_interrupts
 1.986e+08 ±  3%     -52.4%   94474633 ±  4%  interrupts.RES:Rescheduling_interrupts
  49453077 ±  8%     -61.3%   19148289 ±  8%  interrupts.TLB:TLB_shootdowns





Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


Thanks,
Rong Chen


--90KBcPA0h13nTGdQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="config-5.10.0-rc4-00001-g8d86968ac36e"

#
# Automatically generated file; DO NOT EDIT.
# Linux/x86_64 5.10.0-rc4 Kernel Configuration
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

--90KBcPA0h13nTGdQ
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
	export submit_id='5fbd9cd0532077179d080681'
	export job_file='/lkp/jobs/scheduled/lkp-csl-2ap3/netperf-cs-localhost-performance-ipv4-50%-300s-UDP_RR-ucode=0x5003003-monitor=6e02c248-debian-10.4-x86_64-20200603.cgz-8d86968ac-20201125-6045-lbonsp-2.yaml'
	export id='d42e2abb6278f809ddedea1b712d3869d27fc85f'
	export queuer_version='/lkp-src'
	export model='Cascade Lake'
	export nr_node=4
	export nr_cpu=192
	export memory='192G'
	export ssd_partitions=
	export rootfs_partition='LABEL=LKP-ROOTFS'
	export kernel_cmdline_hw='acpi_rsdp=0x67f44014'
	export brand='Intel(R) Xeon(R) Platinum 9242 CPU @ 2.30GHz'
	export commit='8d86968ac36ea5bff487f70b5ffc252a87d44c51'
	export need_kconfig_hw='CONFIG_IGB=y
CONFIG_BLK_DEV_NVME'
	export ucode='0x5003003'
	export enqueue_time='2020-11-25 07:52:49 +0800'
	export _id='5fbd9cd0532077179d080681'
	export _rt='/result/netperf/cs-localhost-performance-ipv4-50%-300s-UDP_RR-ucode=0x5003003-monitor=6e02c248/lkp-csl-2ap3/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/8d86968ac36ea5bff487f70b5ffc252a87d44c51'
	export user='lkp'
	export compiler='gcc-9'
	export head_commit='50ad2a38a1720ff482b5bbdf44066fdcfbc7f977'
	export base_commit='09162bc32c880a791c6c0668ce0745cf7958f576'
	export branch='linux-review/Aubrey-Li/sched-fair-select-idle-cpu-from-idle-cpumask-for-task-wakeup/20201118-115145'
	export rootfs='debian-10.4-x86_64-20200603.cgz'
	export monitor_sha='6e02c248'
	export result_root='/result/netperf/cs-localhost-performance-ipv4-50%-300s-UDP_RR-ucode=0x5003003-monitor=6e02c248/lkp-csl-2ap3/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/8d86968ac36ea5bff487f70b5ffc252a87d44c51/3'
	export scheduler_version='/lkp/lkp/.src-20201124-233336'
	export LKP_SERVER='internal-lkp-server'
	export arch='x86_64'
	export max_uptime=2400
	export initrd='/osimage/debian/debian-10.4-x86_64-20200603.cgz'
	export bootloader_append='root=/dev/ram0
user=lkp
job=/lkp/jobs/scheduled/lkp-csl-2ap3/netperf-cs-localhost-performance-ipv4-50%-300s-UDP_RR-ucode=0x5003003-monitor=6e02c248-debian-10.4-x86_64-20200603.cgz-8d86968ac-20201125-6045-lbonsp-2.yaml
ARCH=x86_64
kconfig=x86_64-rhel-8.3
branch=linux-review/Aubrey-Li/sched-fair-select-idle-cpu-from-idle-cpumask-for-task-wakeup/20201118-115145
commit=8d86968ac36ea5bff487f70b5ffc252a87d44c51
BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3/gcc-9/8d86968ac36ea5bff487f70b5ffc252a87d44c51/vmlinuz-5.10.0-rc4-00001-g8d86968ac36e
acpi_rsdp=0x67f44014
max_uptime=2400
RESULT_ROOT=/result/netperf/cs-localhost-performance-ipv4-50%-300s-UDP_RR-ucode=0x5003003-monitor=6e02c248/lkp-csl-2ap3/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/8d86968ac36ea5bff487f70b5ffc252a87d44c51/3
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
	export modules_initrd='/pkg/linux/x86_64-rhel-8.3/gcc-9/8d86968ac36ea5bff487f70b5ffc252a87d44c51/modules.cgz'
	export bm_initrd='/osimage/deps/debian-10.4-x86_64-20200603.cgz/run-ipconfig_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/lkp_20200709.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/rsync-rootfs_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/netperf_20201111.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/netperf-x86_64-2.7-0_20201111.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/mpstat_20200714.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/perf_20200723.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/perf-x86_64-eccc87672492-1_20201111.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/sar-x86_64-34c92ae-1_20200702.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/hw_20200715.cgz'
	export ucode_initrd='/osimage/ucode/intel-ucode-20201117.cgz'
	export lkp_initrd='/osimage/user/lkp/lkp-x86_64.cgz'
	export site='inn'
	export LKP_CGI_PORT=80
	export LKP_CIFS_PORT=139
	export last_kernel='5.9.0'
	export repeat_to=4
	export bad_samples='59422.855416666665
56052.40270833334
57747.04270833334'
	export schedule_notify_address=
	export queue_at_least_once=1
	export kernel='/pkg/linux/x86_64-rhel-8.3/gcc-9/8d86968ac36ea5bff487f70b5ffc252a87d44c51/vmlinuz-5.10.0-rc4-00001-g8d86968ac36e'
	export dequeue_time='2020-11-25 08:00:20 +0800'
	export node_roles='server client'
	export job_initrd='/lkp/jobs/scheduled/lkp-csl-2ap3/netperf-cs-localhost-performance-ipv4-50%-300s-UDP_RR-ucode=0x5003003-monitor=6e02c248-debian-10.4-x86_64-20200603.cgz-8d86968ac-20201125-6045-lbonsp-2.cgz'

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
		run_test test='UDP_RR' $LKP_SRC/tests/wrapper netperf
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

--90KBcPA0h13nTGdQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="job.yaml"

---
suite: netperf
testcase: netperf
category: benchmark
disable_latency_stats: 1
set_nic_irq_affinity: 1
ip: ipv4
runtime: 300s
nr_threads: 50%
cluster: cs-localhost
if role server:
  netserver: 
if role client:
  netperf:
    test: UDP_RR
job_origin: "/lkp-src/allot/cyclic:p1:linux-devel:devel-hourly/lkp-csl-2ap3/netperf-small-threads.yaml"
queue_cmdline_keys:
- branch
- commit
- queue_at_least_once
queue: bisect
testbox: lkp-csl-2ap3
tbox_group: lkp-csl-2ap3
kconfig: x86_64-rhel-8.3
submit_id: 5fbd95bdb67463197990b9d1
job_file: "/lkp/jobs/scheduled/lkp-csl-2ap3/netperf-cs-localhost-performance-ipv4-50%-300s-UDP_RR-ucode=0x5003003-monitor=6e02c248-debian-10.4-x86_64-20200603.cgz-8d86968ac-20201125-6521-1mttc45-1.yaml"
id: 377510c73ba896d75ae95d3a2c6a863c5c7ee713
queuer_version: "/lkp-src"
model: Cascade Lake
nr_node: 4
nr_cpu: 192
memory: 192G
ssd_partitions: 
rootfs_partition: LABEL=LKP-ROOTFS
kernel_cmdline_hw: acpi_rsdp=0x67f44014
brand: Intel(R) Xeon(R) Platinum 9242 CPU @ 2.30GHz
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
cpufreq_governor: performance
commit: 8d86968ac36ea5bff487f70b5ffc252a87d44c51
need_kconfig_hw:
- CONFIG_IGB=y
- CONFIG_BLK_DEV_NVME
ucode: '0x5003003'
enqueue_time: 2020-11-25 07:22:37.789497855 +08:00
_id: 5fbd95bdb67463197990b9d1
_rt: "/result/netperf/cs-localhost-performance-ipv4-50%-300s-UDP_RR-ucode=0x5003003-monitor=6e02c248/lkp-csl-2ap3/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/8d86968ac36ea5bff487f70b5ffc252a87d44c51"
user: lkp
compiler: gcc-9
head_commit: 50ad2a38a1720ff482b5bbdf44066fdcfbc7f977
base_commit: '09162bc32c880a791c6c0668ce0745cf7958f576'
branch: linux-devel/devel-hourly-2020112219
rootfs: debian-10.4-x86_64-20200603.cgz
monitor_sha: 6e02c248
result_root: "/result/netperf/cs-localhost-performance-ipv4-50%-300s-UDP_RR-ucode=0x5003003-monitor=6e02c248/lkp-csl-2ap3/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/8d86968ac36ea5bff487f70b5ffc252a87d44c51/1"
scheduler_version: "/lkp/lkp/.src-20201124-233336"
LKP_SERVER: internal-lkp-server
arch: x86_64
max_uptime: 2400
initrd: "/osimage/debian/debian-10.4-x86_64-20200603.cgz"
bootloader_append:
- root=/dev/ram0
- user=lkp
- job=/lkp/jobs/scheduled/lkp-csl-2ap3/netperf-cs-localhost-performance-ipv4-50%-300s-UDP_RR-ucode=0x5003003-monitor=6e02c248-debian-10.4-x86_64-20200603.cgz-8d86968ac-20201125-6521-1mttc45-1.yaml
- ARCH=x86_64
- kconfig=x86_64-rhel-8.3
- branch=linux-devel/devel-hourly-2020112219
- commit=8d86968ac36ea5bff487f70b5ffc252a87d44c51
- BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3/gcc-9/8d86968ac36ea5bff487f70b5ffc252a87d44c51/vmlinuz-5.10.0-rc4-00001-g8d86968ac36e
- acpi_rsdp=0x67f44014
- max_uptime=2400
- RESULT_ROOT=/result/netperf/cs-localhost-performance-ipv4-50%-300s-UDP_RR-ucode=0x5003003-monitor=6e02c248/lkp-csl-2ap3/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/8d86968ac36ea5bff487f70b5ffc252a87d44c51/1
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
modules_initrd: "/pkg/linux/x86_64-rhel-8.3/gcc-9/8d86968ac36ea5bff487f70b5ffc252a87d44c51/modules.cgz"
bm_initrd: "/osimage/deps/debian-10.4-x86_64-20200603.cgz/run-ipconfig_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/lkp_20200709.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/rsync-rootfs_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/netperf_20201111.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/netperf-x86_64-2.7-0_20201111.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/mpstat_20200714.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/perf_20200723.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/perf-x86_64-eccc87672492-1_20201111.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/sar-x86_64-34c92ae-1_20200702.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/hw_20200715.cgz"
ucode_initrd: "/osimage/ucode/intel-ucode-20201117.cgz"
lkp_initrd: "/osimage/user/lkp/lkp-x86_64.cgz"
site: inn
LKP_CGI_PORT: 80
LKP_CIFS_PORT: 139
oom-killer: 
watchdog: 
last_kernel: 5.10.0-rc4-00001-g8d86968ac36e
repeat_to: 2
bad_samples:
- 59422.855416666665
- 56052.40270833334
- 57747.04270833334

#! queue options
schedule_notify_address: 

#! user overrides
queue_at_least_once: 0

#! schedule options
kernel: "/pkg/linux/x86_64-rhel-8.3/gcc-9/8d86968ac36ea5bff487f70b5ffc252a87d44c51/vmlinuz-5.10.0-rc4-00001-g8d86968ac36e"
dequeue_time: 2020-11-25 07:26:27.663780163 +08:00

#! /lkp/lkp/.src-20201124-233336/include/site/inn

#! runtime status
job_state: finished
loadavg: 76.05 68.60 31.87 1/1273 13175
start_time: '1606260712'
end_time: '1606261013'
version: "/lkp/lkp/.src-20201124-233437:8bd867b0:c99a2388d"

--90KBcPA0h13nTGdQ
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
netperf -4 -H 127.0.0.1 -t UDP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t UDP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t UDP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t UDP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t UDP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t UDP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t UDP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t UDP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t UDP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t UDP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t UDP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t UDP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t UDP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t UDP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t UDP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t UDP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t UDP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t UDP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t UDP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t UDP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t UDP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t UDP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t UDP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t UDP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t UDP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t UDP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t UDP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t UDP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t UDP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t UDP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t UDP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t UDP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t UDP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t UDP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t UDP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t UDP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t UDP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t UDP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t UDP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t UDP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t UDP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t UDP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t UDP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t UDP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t UDP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t UDP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t UDP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t UDP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t UDP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t UDP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t UDP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t UDP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t UDP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t UDP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t UDP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t UDP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t UDP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t UDP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t UDP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t UDP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t UDP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t UDP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t UDP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t UDP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t UDP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t UDP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t UDP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t UDP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t UDP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t UDP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t UDP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t UDP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t UDP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t UDP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t UDP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t UDP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t UDP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t UDP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t UDP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t UDP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t UDP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t UDP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t UDP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t UDP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t UDP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t UDP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t UDP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t UDP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t UDP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t UDP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t UDP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t UDP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t UDP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t UDP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t UDP_RR -c -C -l 300  &
netperf -4 -H 127.0.0.1 -t UDP_RR -c -C -l 300  &
wait

--90KBcPA0h13nTGdQ--
