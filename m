Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 568502E7668
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Dec 2020 07:11:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726350AbgL3GKD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Dec 2020 01:10:03 -0500
Received: from mga02.intel.com ([134.134.136.20]:54004 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726197AbgL3GKC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Dec 2020 01:10:02 -0500
IronPort-SDR: tra6Ca2ov4L8IGCTeLNX+4cW/G/3O9ZLS2f2pU2LPiw+8rBtSbCMEftDNToPDMcfT7r9esaQ62
 lPljhDDuYM/w==
X-IronPort-AV: E=McAfee;i="6000,8403,9849"; a="163636483"
X-IronPort-AV: E=Sophos;i="5.78,460,1599548400"; 
   d="yaml'?scan'208";a="163636483"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2020 22:09:03 -0800
IronPort-SDR: 0ler6CQwCLX7vDfgAzgRT1PsDH9tSCsf/uy9AfPlslwnkXPdKQpjWGWih6loX9WGXi560b/yn7
 puyKT7pbWPTw==
X-IronPort-AV: E=Sophos;i="5.78,460,1599548400"; 
   d="yaml'?scan'208";a="347657460"
Received: from xsang-optiplex-9020.sh.intel.com (HELO xsang-OptiPlex-9020) ([10.239.159.140])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2020 22:08:58 -0800
Date:   Wed, 30 Dec 2020 14:24:12 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     Joonsoo Kim <iamjoonsoo.kim@lge.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Hugh Dickins <hughd@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Michal Hocko <mhocko@kernel.org>,
        Minchan Kim <minchan@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com, ying.huang@intel.com, feng.tang@intel.com,
        zhengjun.xing@intel.com
Subject: [mm/swap]  aae466b005:  vm-scalability.throughput -2.7% regression
Message-ID: <20201230062412.GD22185@xsang-OptiPlex-9020>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="+B+y8wtTXqdUj1xM"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: NeoMutt/20170113 (1.7.2)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--+B+y8wtTXqdUj1xM
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit


Greeting,

FYI, we noticed a -2.7% regression of vm-scalability.throughput due to commit:


commit: aae466b0052e1888edd1d7f473d4310d64936196 ("mm/swap: implement workingset detection for anonymous LRU")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master


in testcase: vm-scalability
on test machine: 192 threads Intel(R) Xeon(R) CPU @ 2.20GHz with 192G memory
with following parameters:

	runtime: 300
	thp_enabled: never
	thp_defrag: always
	nr_task: 32
	nr_ssd: 1
	test: swap-w-rand-mt
	cpufreq_governor: performance
	ucode: 0x4003003

test-description: The motivation behind this suite is to exercise functions and regions of the mm/ of the Linux kernel which are of interest to us.
test-url: https://git.kernel.org/cgit/linux/kernel/git/wfg/vm-scalability.git/

In addition to that, the commit also has significant impact on the following tests:

+------------------+------------------------------------------------------------------------+
| testcase: change | vm-scalability: vm-scalability.throughput 12.8% improvement            |
| test machine     | 96 threads Intel(R) Xeon(R) CPU @ 2.30GHz with 128G memory             |
| test parameters  | cpufreq_governor=performance                                           |
|                  | nr_pmem=2                                                              |
|                  | nr_task=8                                                              |
|                  | priority=1                                                             |
|                  | test=swap-w-seq                                                        |
|                  | thp_defrag=never                                                       |
|                  | thp_enabled=never                                                      |
|                  | ucode=0x4003003                                                        |
+------------------+------------------------------------------------------------------------+
| testcase: change | vm-scalability: vm-scalability.median -1.3% regression                 |
| test machine     | 192 threads Intel(R) Xeon(R) CPU @ 2.20GHz with 192G memory            |
| test parameters  | cpufreq_governor=performance                                           |
|                  | nr_ssd=1                                                               |
|                  | nr_task=32                                                             |
|                  | runtime=300                                                            |
|                  | test=swap-w-rand-mt                                                    |
|                  | thp_defrag=always                                                      |
|                  | thp_enabled=always                                                     |
|                  | ucode=0x4003003                                                        |
+------------------+------------------------------------------------------------------------+
| testcase: change | vm-scalability: vm-scalability.throughput 17.2% improvement            |
| test machine     | 144 threads Intel(R) Xeon(R) CPU E7-8890 v3 @ 2.50GHz with 512G memory |
| test parameters  | cpufreq_governor=performance                                           |
|                  | nr_pmem=4                                                              |
|                  | nr_task=8                                                              |
|                  | priority=1                                                             |
|                  | test=swap-w-seq                                                        |
|                  | thp_defrag=never                                                       |
|                  | thp_enabled=never                                                      |
|                  | ucode=0x16                                                             |
+------------------+------------------------------------------------------------------------+


If you fix the issue, kindly add following tag
Reported-by: kernel test robot <oliver.sang@intel.com>


Details are as below:
-------------------------------------------------------------------------------------------------->


To reproduce:

        git clone https://github.com/intel/lkp-tests.git
        cd lkp-tests
        bin/lkp install job.yaml  # job file is attached in this email
        bin/lkp run     job.yaml

=========================================================================================
compiler/cpufreq_governor/kconfig/nr_ssd/nr_task/rootfs/runtime/tbox_group/test/testcase/thp_defrag/thp_enabled/ucode:
  gcc-9/performance/x86_64-rhel-8.3/1/32/debian-10.4-x86_64-20200603.cgz/300/lkp-csl-2ap1/swap-w-rand-mt/vm-scalability/always/never/0x4003003

commit: 
  3852f6768e ("mm/swapcache: support to handle the shadow entries")
  aae466b005 ("mm/swap: implement workingset detection for anonymous LRU")

3852f6768ede542e aae466b0052e1888edd1d7f473d 
---------------- --------------------------- 
       fail:runs  %reproduction    fail:runs
           |             |             |    
          1:4            5%           1:4     perf-profile.children.cycles-pp.error_entry
          0:4            2%           0:4     perf-profile.self.cycles-pp.error_entry
         %stddev     %change         %stddev
             \          |                \  
      3.97           +33.0%       5.28 ±  2%  vm-scalability.free_time
      6216            -2.4%       6065        vm-scalability.median
    184.21           +57.2      241.41 ±  2%  vm-scalability.stddev%
    198352            -2.7%     193018        vm-scalability.throughput
    368.12            +6.4%     391.63        vm-scalability.time.elapsed_time
    368.12            +6.4%     391.63        vm-scalability.time.elapsed_time.max
     18610 ± 29%     -47.9%       9704 ± 11%  vm-scalability.time.involuntary_context_switches
    320.00 ±  4%      -6.3%     299.75 ±  2%  vm-scalability.time.percent_of_cpu_this_job_got
     11.22            -4.9%      10.67        iostat.cpu.iowait
      0.11            -0.0        0.09        mpstat.cpu.all.soft%
  30334488           -44.9%   16726456        cpuidle.POLL.time
   6991777           -46.0%    3774649 ±  2%  cpuidle.POLL.usage
    164847 ±  2%    +387.8%     804132        slabinfo.radix_tree_node.active_objs
      3155 ±  2%    +372.3%      14905        slabinfo.radix_tree_node.active_slabs
    176738 ±  2%    +372.3%     834722        slabinfo.radix_tree_node.num_objs
      3155 ±  2%    +372.3%      14905        slabinfo.radix_tree_node.num_slabs
    481751 ±  4%     +11.1%     535142 ±  5%  sched_debug.cfs_rq:/.min_vruntime.max
     44029 ± 48%    +720.6%     361329 ± 44%  sched_debug.cfs_rq:/.spread0.max
      0.03 ± 10%     +17.7%       0.03 ± 12%  sched_debug.cpu.nr_running.avg
      0.16 ±  5%      +8.0%       0.17 ±  5%  sched_debug.cpu.nr_running.stddev
      2921 ± 29%     -39.4%       1770 ± 11%  sched_debug.cpu.nr_switches.min
    129531 ± 10%     +33.7%     173189 ± 10%  sched_debug.cpu.nr_switches.stddev
    284476            -5.3%     269500 ±  2%  vmstat.io.bi
    829640            -4.6%     791105        vmstat.io.bo
    689.50 ± 24%     -52.7%     326.00 ± 17%  vmstat.memory.buff
   1695753           +18.6%    2012004 ±  2%  vmstat.memory.cache
  24761938           +21.1%   29998510        vmstat.memory.free
    284470            -5.3%     269494 ±  2%  vmstat.swap.si
    829635            -4.6%     791100        vmstat.swap.so
    147287            -4.9%     140140        vmstat.system.cs
  39473212 ±  2%     -65.6%   13576005 ±  8%  meminfo.Active
  39472833 ±  2%     -65.6%   13575638 ±  8%  meminfo.Active(anon)
     28016 ± 11%     +27.6%      35751 ±  5%  meminfo.CmaFree
 1.295e+08           +15.8%  1.499e+08        meminfo.Inactive
 1.295e+08           +15.8%  1.499e+08        meminfo.Inactive(anon)
    179771          +209.6%     556606        meminfo.KReclaimable
  23750082           +22.5%   29103301        meminfo.MemAvailable
  24371669           +21.2%   29537348        meminfo.MemFree
    268.00 ±  4%    +452.0%       1479 ± 42%  meminfo.Mlocked
    179771          +209.6%     556606        meminfo.SReclaimable
    501211           +76.2%     883374        meminfo.Slab
   2015638 ± 20%     +81.6%    3659798 ± 15%  proc-vmstat.compact_daemon_free_scanned
   2015638 ± 20%     +81.6%    3659798 ± 15%  proc-vmstat.compact_free_scanned
   9901379           -65.8%    3389780 ±  8%  proc-vmstat.nr_active_anon
  41693055            -3.5%   40233791        proc-vmstat.nr_anon_pages
    591382           +22.5%     724480        proc-vmstat.nr_dirty_background_threshold
   1184213           +22.5%    1450733        proc-vmstat.nr_dirty_threshold
      7034 ± 12%     +27.6%       8976 ±  5%  proc-vmstat.nr_free_cma
   6089969           +21.9%    7425242        proc-vmstat.nr_free_pages
  32343769           +15.8%   37442761        proc-vmstat.nr_inactive_anon
    153.50 ± 28%     -63.2%      56.50 ± 26%  proc-vmstat.nr_inactive_file
     11447            -4.9%      10883 ±  2%  proc-vmstat.nr_mapped
     66.75 ±  4%    +453.9%     369.75 ± 42%  proc-vmstat.nr_mlock
    225376            -2.8%     219090        proc-vmstat.nr_page_table_pages
    135218 ±  2%     -10.8%     120652 ±  8%  proc-vmstat.nr_shmem
     44994          +209.1%     139062        proc-vmstat.nr_slab_reclaimable
  47878384            +5.7%   50604735        proc-vmstat.nr_vmscan_write
  77049882            +1.4%   78117892        proc-vmstat.nr_written
   9901589           -65.8%    3390472 ±  8%  proc-vmstat.nr_zone_active_anon
  32344898           +15.8%   37443693        proc-vmstat.nr_zone_inactive_anon
    153.25 ± 28%     -63.1%      56.50 ± 26%  proc-vmstat.nr_zone_inactive_file
    222877 ±173%   +7663.4%   17302906 ±  3%  proc-vmstat.pgdeactivate
 3.082e+08            +1.4%  3.125e+08        proc-vmstat.pgpgout
    222877 ±173%   +7663.4%   17302906 ±  3%  proc-vmstat.pgrefill
  77049882            +1.4%   78117893        proc-vmstat.pswpout
      3950 ±  8%     +27.7%       5043 ±  6%  proc-vmstat.swap_ra_hit
 1.582e+09            -3.1%  1.532e+09        perf-stat.i.branch-instructions
    148737            -4.9%     141447        perf-stat.i.context-switches
 2.114e+09            -3.8%  2.033e+09        perf-stat.i.dTLB-loads
 1.112e+09            -3.8%   1.07e+09        perf-stat.i.dTLB-stores
     58.64            -0.9       57.71        perf-stat.i.iTLB-load-miss-rate%
   8601022 ±  3%      -6.8%    8018116 ±  2%  perf-stat.i.iTLB-load-misses
 7.824e+09            -3.0%  7.588e+09        perf-stat.i.instructions
     71817 ±  2%      -5.3%      68008 ±  2%  perf-stat.i.major-faults
      1.10 ±  2%      -5.9%       1.04 ±  2%  perf-stat.i.metric.K/sec
     25.50            -3.4%      24.62        perf-stat.i.metric.M/sec
    271982            -5.5%     257059        perf-stat.i.minor-faults
     86.69            -2.5       84.16 ±  2%  perf-stat.i.node-load-miss-rate%
   3592897 ±  3%      -7.2%    3335717        perf-stat.i.node-store-misses
    343799            -5.4%     325068        perf-stat.i.page-faults
     87.63            -2.2       85.44        perf-stat.overall.node-load-miss-rate%
     44275            +3.2%      45673        perf-stat.overall.path-length
 1.581e+09            -3.1%  1.532e+09        perf-stat.ps.branch-instructions
    147972            -4.9%     140775 ±  2%  perf-stat.ps.context-switches
 2.112e+09            -3.8%  2.032e+09        perf-stat.ps.dTLB-loads
 1.111e+09            -3.7%  1.069e+09        perf-stat.ps.dTLB-stores
   8576754 ±  3%      -6.7%    8000293 ±  2%  perf-stat.ps.iTLB-load-misses
  7.82e+09            -3.0%  7.587e+09        perf-stat.ps.instructions
     71434 ±  2%      -5.3%      67666 ±  2%  perf-stat.ps.major-faults
    275553            -5.7%     259748        perf-stat.ps.minor-faults
   3597708 ±  3%      -7.1%    3342209 ±  2%  perf-stat.ps.node-store-misses
    346987            -5.6%     327415        perf-stat.ps.page-faults
  2.89e+12            +3.2%  2.982e+12        perf-stat.total.instructions
   2797818 ± 13%     -62.0%    1062303 ± 18%  numa-vmstat.node0.nr_active_anon
   7606015 ±  4%     +18.5%    9015289 ±  3%  numa-vmstat.node0.nr_inactive_anon
      2841 ± 20%     -23.7%       2167 ± 12%  numa-vmstat.node0.nr_mapped
     21.25 ± 17%    +364.7%      98.75 ± 41%  numa-vmstat.node0.nr_mlock
    399.50 ± 58%  +40928.8%     163910 ± 57%  numa-vmstat.node0.nr_page_table_pages
     23030 ± 37%     -49.7%      11581 ± 35%  numa-vmstat.node0.nr_shmem
     10778 ± 18%    +154.0%      27381 ± 28%  numa-vmstat.node0.nr_slab_reclaimable
   2797850 ± 13%     -62.0%    1062427 ± 18%  numa-vmstat.node0.nr_zone_active_anon
   7606315 ±  4%     +18.5%    9015536 ±  3%  numa-vmstat.node0.nr_zone_inactive_anon
   2434112 ±  4%     -70.0%     729671 ±  7%  numa-vmstat.node1.nr_active_anon
   1478062 ±  6%     +24.7%    1842766 ±  4%  numa-vmstat.node1.nr_free_pages
   8286756           +15.8%    9597629        numa-vmstat.node1.nr_inactive_anon
     13.75 ±  6%    +678.2%     107.00 ± 52%  numa-vmstat.node1.nr_mlock
     11056 ±  7%    +265.0%      40351 ± 11%  numa-vmstat.node1.nr_slab_reclaimable
   2434168 ±  4%     -70.0%     729866 ±  7%  numa-vmstat.node1.nr_zone_active_anon
   8287096           +15.8%    9597821        numa-vmstat.node1.nr_zone_inactive_anon
   2143905 ± 13%     -62.8%     797472 ± 24%  numa-vmstat.node2.nr_active_anon
   1494773 ±  5%     +29.0%    1927632 ±  9%  numa-vmstat.node2.nr_free_pages
     16.50 ± 29%    +400.0%      82.50 ± 44%  numa-vmstat.node2.nr_mlock
     11153 ± 14%    +211.9%      34787 ± 26%  numa-vmstat.node2.nr_slab_reclaimable
   2143957 ± 13%     -62.8%     797647 ± 24%  numa-vmstat.node2.nr_zone_active_anon
   2483365 ±  7%     -67.9%     797268 ±  4%  numa-vmstat.node3.nr_active_anon
      7022 ± 12%     +27.8%       8975 ±  5%  numa-vmstat.node3.nr_free_cma
   1480903           +26.7%    1876124        numa-vmstat.node3.nr_free_pages
   8081690 ±  3%     +17.4%    9491688        numa-vmstat.node3.nr_inactive_anon
      8163 ±  8%     -19.9%       6535        numa-vmstat.node3.nr_kernel_stack
     11935 ±  4%    +205.0%      36402 ±  4%  numa-vmstat.node3.nr_slab_reclaimable
     20598 ± 13%     -21.9%      16083 ±  9%  numa-vmstat.node3.nr_slab_unreclaimable
   2483418 ±  7%     -67.9%     797444 ±  4%  numa-vmstat.node3.nr_zone_active_anon
   8081950 ±  3%     +17.4%    9491926        numa-vmstat.node3.nr_zone_inactive_anon
  18061676 ±  9%     +16.2%   20994129 ±  9%  numa-vmstat.node3.numa_hit
  17948663 ±  9%     +16.0%   20828234 ±  9%  numa-vmstat.node3.numa_local
  11235292 ± 14%     -62.1%    4253332 ± 18%  numa-meminfo.node0.Active
  11235045 ± 14%     -62.1%    4253174 ± 18%  numa-meminfo.node0.Active(anon)
  30372185 ±  5%     +18.7%   36043049 ±  3%  numa-meminfo.node0.Inactive
  30372149 ±  5%     +18.7%   36043021 ±  3%  numa-meminfo.node0.Inactive(anon)
     43141 ± 18%    +154.4%     109749 ± 28%  numa-meminfo.node0.KReclaimable
     43141 ± 18%    +154.4%     109749 ± 28%  numa-meminfo.node0.SReclaimable
     92323 ± 37%     -49.7%      46402 ± 35%  numa-meminfo.node0.Shmem
    142930 ± 14%     +51.3%     216266 ± 15%  numa-meminfo.node0.Slab
   9771157 ±  4%     -70.1%    2923440 ±  7%  numa-meminfo.node1.Active
   9771112 ±  4%     -70.1%    2923413 ±  7%  numa-meminfo.node1.Active(anon)
  33103934           +15.9%   38369090        numa-meminfo.node1.Inactive
  33103732           +15.9%   38369003        numa-meminfo.node1.Inactive(anon)
     44315 ±  7%    +264.5%     161527 ± 11%  numa-meminfo.node1.KReclaimable
   5921070 ±  6%     +24.8%    7388272 ±  4%  numa-meminfo.node1.MemFree
     44315 ±  7%    +264.5%     161527 ± 11%  numa-meminfo.node1.SReclaimable
    107817 ±  3%    +121.5%     238839 ±  5%  numa-meminfo.node1.Slab
   8607727 ± 13%     -62.9%    3193249 ± 23%  numa-meminfo.node2.Active
   8607678 ± 13%     -62.9%    3193160 ± 23%  numa-meminfo.node2.Active(anon)
     44678 ± 14%    +212.0%     139381 ± 26%  numa-meminfo.node2.KReclaimable
   5985691 ±  4%     +29.1%    7729464 ±  8%  numa-meminfo.node2.MemFree
     44678 ± 14%    +212.0%     139381 ± 26%  numa-meminfo.node2.SReclaimable
    120407 ± 19%     +81.0%     217905 ± 20%  numa-meminfo.node2.Slab
   9966813 ±  7%     -68.0%    3193310 ±  4%  numa-meminfo.node3.Active
   9966773 ±  7%     -68.0%    3193215 ±  4%  numa-meminfo.node3.Active(anon)
  32288714 ±  3%     +17.5%   37944173        numa-meminfo.node3.Inactive
  32288483 ±  3%     +17.5%   37944122        numa-meminfo.node3.Inactive(anon)
     47843 ±  4%    +204.8%     145824 ±  4%  numa-meminfo.node3.KReclaimable
      8154 ±  8%     -19.9%       6535        numa-meminfo.node3.KernelStack
     12199 ±  5%     +18.9%      14501 ±  7%  numa-meminfo.node3.Mapped
   5928259 ±  2%     +26.9%    7523247 ±  2%  numa-meminfo.node3.MemFree
     47843 ±  4%    +204.8%     145824 ±  4%  numa-meminfo.node3.SReclaimable
     82430 ± 13%     -21.9%      64341 ±  9%  numa-meminfo.node3.SUnreclaim
    130274 ±  8%     +61.3%     210167 ±  3%  numa-meminfo.node3.Slab
      0.01 ± 13%     +45.5%       0.01 ± 15%  perf-sched.sch_delay.avg.ms.__sched_text_start.__sched_text_start.do_syslog.part.0
      0.00 ± 34%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__sched_text_start.__sched_text_start.preempt_schedule_common._cond_resched.do_swap_page
      0.01 ±  6%     +24.0%       0.01 ±  5%  perf-sched.sch_delay.avg.ms.__sched_text_start.__sched_text_start.schedule_timeout.rcu_gp_kthread.kthread
      0.01 ± 13%     +45.5%       0.01 ± 15%  perf-sched.sch_delay.max.ms.__sched_text_start.__sched_text_start.do_syslog.part.0
      0.01 ± 40%     -80.9%       0.00 ± 19%  perf-sched.sch_delay.max.ms.__sched_text_start.__sched_text_start.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt
      0.00 ± 72%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__sched_text_start.__sched_text_start.preempt_schedule_common._cond_resched.do_swap_page
      0.01 ± 20%     +75.0%       0.03 ± 22%  perf-sched.sch_delay.max.ms.__sched_text_start.__sched_text_start.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop
      0.03 ± 25%     +63.0%       0.05 ± 43%  perf-sched.sch_delay.max.ms.__sched_text_start.__sched_text_start.schedule_timeout.rcu_gp_kthread.kthread
      0.82 ±147%     -92.7%       0.06 ± 69%  perf-sched.sch_delay.max.ms.__sched_text_start.__sched_text_start.smpboot_thread_fn.kthread.ret_from_fork
      3.48 ±  2%     -10.3%       3.12 ±  2%  perf-sched.total_wait_and_delay.average.ms
      3.48 ±  2%     -10.3%       3.12 ±  2%  perf-sched.total_wait_time.average.ms
    208.52 ±  3%      +8.8%     226.98 ±  2%  perf-sched.wait_and_delay.avg.ms.__sched_text_start.__sched_text_start.do_task_dead.do_exit.do_group_exit
     74.43 ± 56%     -92.1%       5.90 ±173%  perf-sched.wait_and_delay.avg.ms.__sched_text_start.__sched_text_start.preempt_schedule_common._cond_resched.generic_perform_write
    346.68          +164.3%     916.39 ± 35%  perf-sched.wait_and_delay.avg.ms.__sched_text_start.__sched_text_start.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait
      4.05           +61.0%       6.52 ± 12%  perf-sched.wait_and_delay.avg.ms.__sched_text_start.__sched_text_start.schedule_timeout.rcu_gp_kthread.kthread
    374.36 ± 10%     +98.3%     742.31 ±  2%  perf-sched.wait_and_delay.avg.ms.__sched_text_start.__sched_text_start.smpboot_thread_fn.kthread.ret_from_fork
      3.50 ± 42%     -92.9%       0.25 ±173%  perf-sched.wait_and_delay.count.__sched_text_start.__sched_text_start.preempt_schedule_common._cond_resched.generic_perform_write
      2462           -38.5%       1514 ± 13%  perf-sched.wait_and_delay.count.__sched_text_start.__sched_text_start.schedule_timeout.rcu_gp_kthread.kthread
      5945 ±  8%     -58.0%       2498        perf-sched.wait_and_delay.count.__sched_text_start.__sched_text_start.smpboot_thread_fn.kthread.ret_from_fork
      1918 ± 22%    +132.6%       4463 ± 21%  perf-sched.wait_and_delay.max.ms.__sched_text_start.__sched_text_start.do_task_dead.do_exit.do_group_exit
    142.24 ± 49%     -95.9%       5.90 ±173%  perf-sched.wait_and_delay.max.ms.__sched_text_start.__sched_text_start.preempt_schedule_common._cond_resched.generic_perform_write
      5.03         +5481.4%     280.75 ± 35%  perf-sched.wait_and_delay.max.ms.__sched_text_start.__sched_text_start.schedule_timeout.rcu_gp_kthread.kthread
      7708 ± 12%     -83.5%       1270 ± 34%  perf-sched.wait_and_delay.max.ms.__sched_text_start.__sched_text_start.smpboot_thread_fn.kthread.ret_from_fork
    208.52 ±  3%      +8.8%     226.97 ±  2%  perf-sched.wait_time.avg.ms.__sched_text_start.__sched_text_start.do_task_dead.do_exit.do_group_exit
      0.36 ± 79%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__sched_text_start.__sched_text_start.preempt_schedule_common._cond_resched.do_swap_page
      0.13 ± 31%     -88.8%       0.01 ±173%  perf-sched.wait_time.avg.ms.__sched_text_start.__sched_text_start.preempt_schedule_common._cond_resched.down_read
     74.43 ± 56%     -92.1%       5.90 ±173%  perf-sched.wait_time.avg.ms.__sched_text_start.__sched_text_start.preempt_schedule_common._cond_resched.generic_perform_write
    346.67          +164.3%     916.38 ± 35%  perf-sched.wait_time.avg.ms.__sched_text_start.__sched_text_start.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait
      2.11 ± 17%     +60.0%       3.37 ± 38%  perf-sched.wait_time.avg.ms.__sched_text_start.__sched_text_start.schedule_timeout.__skb_wait_for_more_packets.unix_dgram_recvmsg
      4.04           +61.1%       6.51 ± 12%  perf-sched.wait_time.avg.ms.__sched_text_start.__sched_text_start.schedule_timeout.rcu_gp_kthread.kthread
    374.35 ± 10%     +98.3%     742.30 ±  2%  perf-sched.wait_time.avg.ms.__sched_text_start.__sched_text_start.smpboot_thread_fn.kthread.ret_from_fork
      1918 ± 22%    +132.6%       4463 ± 21%  perf-sched.wait_time.max.ms.__sched_text_start.__sched_text_start.do_task_dead.do_exit.do_group_exit
     31.60 ±130%     -99.1%       0.28 ± 90%  perf-sched.wait_time.max.ms.__sched_text_start.__sched_text_start.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt
      1.33 ± 85%    -100.0%       0.00        perf-sched.wait_time.max.ms.__sched_text_start.__sched_text_start.preempt_schedule_common._cond_resched.do_swap_page
      0.14 ± 26%     -89.5%       0.01 ±173%  perf-sched.wait_time.max.ms.__sched_text_start.__sched_text_start.preempt_schedule_common._cond_resched.down_read
    142.24 ± 49%     -95.9%       5.90 ±173%  perf-sched.wait_time.max.ms.__sched_text_start.__sched_text_start.preempt_schedule_common._cond_resched.generic_perform_write
      2.11 ± 17%     +60.0%       3.37 ± 38%  perf-sched.wait_time.max.ms.__sched_text_start.__sched_text_start.schedule_timeout.__skb_wait_for_more_packets.unix_dgram_recvmsg
      5.01         +5501.3%     280.74 ± 35%  perf-sched.wait_time.max.ms.__sched_text_start.__sched_text_start.schedule_timeout.rcu_gp_kthread.kthread
      7708 ± 12%     -83.5%       1270 ± 34%  perf-sched.wait_time.max.ms.__sched_text_start.__sched_text_start.smpboot_thread_fn.kthread.ret_from_fork
      0.76 ± 20%      +0.2        0.96 ±  3%  perf-profile.calltrace.cycles-pp.mem_cgroup_charge.__read_swap_cache_async.read_swap_cache_async.swapin_readahead.do_swap_page
      0.88 ± 22%      +0.3        1.16 ±  6%  perf-profile.calltrace.cycles-pp.timekeeping_max_deferment.tick_nohz_next_event.tick_nohz_get_sleep_length.menu_select.do_idle
      0.59 ± 59%      +0.3        0.89 ± 12%  perf-profile.calltrace.cycles-pp.ktime_get.tick_irq_enter.irq_enter_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      0.28 ±100%      +0.3        0.62 ±  5%  perf-profile.calltrace.cycles-pp.mem_cgroup_uncharge_swap.mem_cgroup_charge.__read_swap_cache_async.read_swap_cache_async.swapin_readahead
      1.43 ± 20%      +0.4        1.83 ±  4%  perf-profile.calltrace.cycles-pp.tick_nohz_next_event.tick_nohz_get_sleep_length.menu_select.do_idle.cpu_startup_entry
      0.54 ± 59%      +0.4        0.94 ±  8%  perf-profile.calltrace.cycles-pp.xas_load.find_get_entry.pagecache_get_page.lookup_swap_cache.do_swap_page
      0.56 ± 60%      +0.4        0.97 ±  8%  perf-profile.calltrace.cycles-pp.find_get_entry.pagecache_get_page.lookup_swap_cache.do_swap_page.__handle_mm_fault
      0.56 ± 60%      +0.4        0.98 ±  8%  perf-profile.calltrace.cycles-pp.pagecache_get_page.lookup_swap_cache.do_swap_page.__handle_mm_fault.handle_mm_fault
      0.13 ±173%      +0.4        0.55 ±  6%  perf-profile.calltrace.cycles-pp.schedule_idle.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64
      0.64 ± 60%      +0.4        1.09 ±  8%  perf-profile.calltrace.cycles-pp.lookup_swap_cache.do_swap_page.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
      1.56 ± 20%      +0.5        2.07 ±  4%  perf-profile.calltrace.cycles-pp.tick_nohz_get_sleep_length.menu_select.do_idle.cpu_startup_entry.start_secondary
      1.54 ± 34%      +0.6        2.12 ± 11%  perf-profile.calltrace.cycles-pp.__swap_writepage.pageout.shrink_page_list.shrink_inactive_list.shrink_lruvec
      3.38 ±162%      -3.3        0.13 ± 25%  perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
      3.37 ±160%      -3.2        0.15 ±  7%  perf-profile.children.cycles-pp._raw_spin_lock_irq
      0.65 ± 21%      -0.3        0.37 ± 10%  perf-profile.children.cycles-pp.poll_idle
      0.32 ±  4%      -0.2        0.10 ± 22%  perf-profile.children.cycles-pp.rcu_core
      0.23 ± 17%      -0.1        0.10        perf-profile.children.cycles-pp.kmem_cache_free
      0.16 ± 19%      -0.1        0.05 ±  9%  perf-profile.children.cycles-pp.__slab_free
      0.14 ± 23%      -0.1        0.08 ± 29%  perf-profile.children.cycles-pp.find_vma
      0.15 ± 10%      -0.0        0.10 ± 19%  perf-profile.children.cycles-pp.xas_create_range
      0.15 ±  2%      +0.0        0.18 ±  6%  perf-profile.children.cycles-pp.__mod_lruvec_state
      0.09 ± 20%      +0.0        0.12 ± 13%  perf-profile.children.cycles-pp.update_cfs_group
      0.05 ± 58%      +0.0        0.09 ± 10%  perf-profile.children.cycles-pp.io_serial_in
      0.05 ± 59%      +0.0        0.09 ±  4%  perf-profile.children.cycles-pp.rcu_nmi_enter
      0.20 ±  7%      +0.0        0.24 ±  5%  perf-profile.children.cycles-pp.__count_memcg_events
      0.04 ± 60%      +0.0        0.08 ± 19%  perf-profile.children.cycles-pp.percpu_counter_add_batch
      0.03 ±100%      +0.0        0.07 ±  7%  perf-profile.children.cycles-pp.__blk_mq_alloc_request
      0.03 ±102%      +0.0        0.07 ± 14%  perf-profile.children.cycles-pp.__rq_qos_throttle
      0.08 ± 21%      +0.0        0.13 ±  9%  perf-profile.children.cycles-pp.blk_throtl_bio
      0.01 ±173%      +0.0        0.06 ± 13%  perf-profile.children.cycles-pp.wbt_wait
      0.04 ± 58%      +0.1        0.09 ± 15%  perf-profile.children.cycles-pp.account_process_tick
      0.01 ±173%      +0.1        0.06 ± 13%  perf-profile.children.cycles-pp.timerqueue_add
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.blk_mq_get_tag
      0.09 ± 24%      +0.1        0.14 ± 12%  perf-profile.children.cycles-pp.hrtimer_get_next_event
      0.08 ± 29%      +0.1        0.13 ±  9%  perf-profile.children.cycles-pp.__hrtimer_next_event_base
      0.04 ± 58%      +0.1        0.11 ± 12%  perf-profile.children.cycles-pp.workingset_age_nonresident
      0.04 ± 58%      +0.1        0.11 ± 14%  perf-profile.children.cycles-pp.xas_init_marks
      0.28 ±  9%      +0.1        0.35 ±  9%  perf-profile.children.cycles-pp.__mod_memcg_lruvec_state
      0.28 ± 26%      +0.1        0.35 ±  5%  perf-profile.children.cycles-pp.submit_bio_checks
      0.10 ± 31%      +0.1        0.18 ±  4%  perf-profile.children.cycles-pp.__frontswap_load
      0.03 ±100%      +0.1        0.11 ± 17%  perf-profile.children.cycles-pp.xas_clear_mark
      0.31 ± 16%      +0.1        0.39 ±  8%  perf-profile.children.cycles-pp._raw_spin_unlock_irqrestore
      0.14 ± 21%      +0.1        0.23 ± 10%  perf-profile.children.cycles-pp.get_next_timer_interrupt
      0.10 ± 24%      +0.1        0.19 ±  6%  perf-profile.children.cycles-pp.hrtimer_next_event_without
      0.45 ± 19%      +0.1        0.55 ±  6%  perf-profile.children.cycles-pp.schedule_idle
      0.50 ± 22%      +0.1        0.62 ±  7%  perf-profile.children.cycles-pp.end_swap_bio_read
      0.13 ± 24%      +0.2        0.28 ±  8%  perf-profile.children.cycles-pp.cpumask_any_but
      0.38 ± 31%      +0.2        0.54 ± 13%  perf-profile.children.cycles-pp.bio_alloc_bioset
      0.54 ± 22%      +0.2        0.71 ±  6%  perf-profile.children.cycles-pp.mem_cgroup_uncharge_swap
      0.00            +0.2        0.18 ±  9%  perf-profile.children.cycles-pp.workingset_refault
      0.43 ± 20%      +0.2        0.63 ±  5%  perf-profile.children.cycles-pp._find_next_bit
      0.80 ± 24%      +0.2        1.00 ±  7%  perf-profile.children.cycles-pp.blk_mq_submit_bio
      0.88 ± 22%      +0.3        1.16 ±  7%  perf-profile.children.cycles-pp.timekeeping_max_deferment
      1.14 ± 25%      +0.3        1.43 ±  6%  perf-profile.children.cycles-pp.submit_bio
      1.12 ± 25%      +0.3        1.41 ±  6%  perf-profile.children.cycles-pp.submit_bio_noacct
      0.80 ± 29%      +0.3        1.10 ±  9%  perf-profile.children.cycles-pp.xas_load
      0.73 ± 33%      +0.4        1.09 ±  8%  perf-profile.children.cycles-pp.lookup_swap_cache
      0.67 ± 34%      +0.4        1.03 ±  9%  perf-profile.children.cycles-pp.find_get_entry
      0.67 ± 33%      +0.4        1.04 ±  8%  perf-profile.children.cycles-pp.pagecache_get_page
      1.44 ± 21%      +0.4        1.85 ±  4%  perf-profile.children.cycles-pp.tick_nohz_next_event
      1.57 ± 21%      +0.5        2.08 ±  4%  perf-profile.children.cycles-pp.tick_nohz_get_sleep_length
      0.00            +0.5        0.53 ± 12%  perf-profile.children.cycles-pp.shrink_active_list
      1.58 ± 29%      +0.5        2.12 ± 11%  perf-profile.children.cycles-pp.__swap_writepage
      3.38 ±163%      -3.3        0.13 ± 25%  perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
      0.15 ± 21%      -0.1        0.05 ±  9%  perf-profile.self.cycles-pp.__slab_free
      0.12 ± 22%      -0.1        0.05 ± 64%  perf-profile.self.cycles-pp.vmacache_find
      0.18 ±  6%      -0.0        0.14 ±  5%  perf-profile.self.cycles-pp._raw_spin_lock_irq
      0.07 ± 20%      +0.0        0.10 ±  7%  perf-profile.self.cycles-pp.page_counter_try_charge
      0.13 ±  7%      +0.0        0.16 ±  7%  perf-profile.self.cycles-pp.__mod_memcg_lruvec_state
      0.09 ± 20%      +0.0        0.12 ± 13%  perf-profile.self.cycles-pp.update_cfs_group
      0.11 ± 21%      +0.0        0.14 ±  8%  perf-profile.self.cycles-pp.mem_cgroup_id_put_many
      0.05 ± 58%      +0.0        0.09 ± 10%  perf-profile.self.cycles-pp.io_serial_in
      0.04 ± 59%      +0.0        0.08 ± 19%  perf-profile.self.cycles-pp.propagate_protected_usage
      0.20 ±  5%      +0.0        0.23 ±  4%  perf-profile.self.cycles-pp.__count_memcg_events
      0.10 ± 10%      +0.0        0.14 ± 12%  perf-profile.self.cycles-pp.xas_create
      0.04 ± 58%      +0.1        0.09 ± 15%  perf-profile.self.cycles-pp.account_process_tick
      0.01 ±173%      +0.1        0.06 ± 13%  perf-profile.self.cycles-pp.__swap_writepage
      0.06 ± 66%      +0.1        0.11 ±  6%  perf-profile.self.cycles-pp.__hrtimer_next_event_base
      0.04 ± 58%      +0.1        0.10 ± 10%  perf-profile.self.cycles-pp.workingset_age_nonresident
      0.00            +0.1        0.06 ± 11%  perf-profile.self.cycles-pp.workingset_refault
      0.01 ±173%      +0.1        0.08 ± 24%  perf-profile.self.cycles-pp.percpu_counter_add_batch
      0.00            +0.1        0.07 ± 22%  perf-profile.self.cycles-pp.__swap_duplicate
      0.23 ± 22%      +0.1        0.30 ±  9%  perf-profile.self.cycles-pp._raw_spin_unlock_irqrestore
      0.07 ± 62%      +0.1        0.16 ±  4%  perf-profile.self.cycles-pp.__frontswap_load
      0.35 ± 19%      +0.1        0.45 ±  7%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.00            +0.1        0.10 ± 15%  perf-profile.self.cycles-pp.xas_clear_mark
      0.39 ± 20%      +0.2        0.58 ±  6%  perf-profile.self.cycles-pp._find_next_bit
      0.58 ± 27%      +0.2        0.81 ±  9%  perf-profile.self.cycles-pp.xas_load
      0.88 ± 22%      +0.3        1.16 ±  7%  perf-profile.self.cycles-pp.timekeeping_max_deferment
    550.50 ± 37%     -53.4%     256.50 ± 57%  interrupts.CPU0.RES:Rescheduling_interrupts
    471.50 ± 94%     -85.9%      66.25 ± 46%  interrupts.CPU1.RES:Rescheduling_interrupts
    251.25 ± 34%     -75.7%      61.00 ± 35%  interrupts.CPU10.RES:Rescheduling_interrupts
    681.25 ±101%     -81.9%     123.25 ± 33%  interrupts.CPU100.NMI:Non-maskable_interrupts
    681.25 ±101%     -81.9%     123.25 ± 33%  interrupts.CPU100.PMI:Performance_monitoring_interrupts
    256.25 ± 80%     -60.7%     100.75 ± 25%  interrupts.CPU102.NMI:Non-maskable_interrupts
    256.25 ± 80%     -60.7%     100.75 ± 25%  interrupts.CPU102.PMI:Performance_monitoring_interrupts
    240.50 ± 35%     -49.3%     122.00 ± 32%  interrupts.CPU104.NMI:Non-maskable_interrupts
    240.50 ± 35%     -49.3%     122.00 ± 32%  interrupts.CPU104.PMI:Performance_monitoring_interrupts
      1330 ±115%     -86.1%     184.50 ± 53%  interrupts.CPU108.NMI:Non-maskable_interrupts
      1330 ±115%     -86.1%     184.50 ± 53%  interrupts.CPU108.PMI:Performance_monitoring_interrupts
    375.25 ± 51%     -46.4%     201.00 ± 62%  interrupts.CPU11.NMI:Non-maskable_interrupts
    375.25 ± 51%     -46.4%     201.00 ± 62%  interrupts.CPU11.PMI:Performance_monitoring_interrupts
    414.25 ± 37%     -69.2%     127.50 ± 30%  interrupts.CPU111.NMI:Non-maskable_interrupts
    414.25 ± 37%     -69.2%     127.50 ± 30%  interrupts.CPU111.PMI:Performance_monitoring_interrupts
   2112995 ± 11%     -28.8%    1504089 ± 42%  interrupts.CPU114.TLB:TLB_shootdowns
     31.00 ± 36%    +126.6%      70.25 ± 65%  interrupts.CPU118.RES:Rescheduling_interrupts
      1831 ±103%     -86.4%     249.00 ± 83%  interrupts.CPU12.NMI:Non-maskable_interrupts
      1831 ±103%     -86.4%     249.00 ± 83%  interrupts.CPU12.PMI:Performance_monitoring_interrupts
    241.75 ± 72%     -83.5%      40.00 ± 36%  interrupts.CPU12.RES:Rescheduling_interrupts
    106.75 ± 37%     +64.9%     176.00 ± 22%  interrupts.CPU125.RES:Rescheduling_interrupts
    850681 ± 26%     +37.7%    1171518 ± 18%  interrupts.CPU126.CAL:Function_call_interrupts
     99.50 ± 61%     +97.2%     196.25 ± 16%  interrupts.CPU126.RES:Rescheduling_interrupts
    124.50 ± 38%     +89.6%     236.00 ± 22%  interrupts.CPU129.RES:Rescheduling_interrupts
    284.00 ± 65%     -84.6%      43.75 ± 42%  interrupts.CPU13.RES:Rescheduling_interrupts
    988716 ± 18%     +35.6%    1340401 ±  2%  interrupts.CPU131.CAL:Function_call_interrupts
   1052717 ± 14%     +50.1%    1580609 ± 20%  interrupts.CPU133.CAL:Function_call_interrupts
    151.50 ± 56%     +94.2%     294.25 ± 21%  interrupts.CPU135.RES:Rescheduling_interrupts
     55.75 ± 38%     +86.5%     104.00 ± 23%  interrupts.CPU136.RES:Rescheduling_interrupts
     41.75 ± 41%     +91.0%      79.75 ± 33%  interrupts.CPU137.RES:Rescheduling_interrupts
     82031 ± 44%     -77.9%      18146 ± 23%  interrupts.CPU15.CAL:Function_call_interrupts
    470.25 ± 38%     -68.8%     146.50 ± 20%  interrupts.CPU15.NMI:Non-maskable_interrupts
    470.25 ± 38%     -68.8%     146.50 ± 20%  interrupts.CPU15.PMI:Performance_monitoring_interrupts
    478.25 ± 91%     -83.4%      79.50 ± 80%  interrupts.CPU15.RES:Rescheduling_interrupts
     83996 ± 12%     -62.1%      31856 ±109%  interrupts.CPU16.CAL:Function_call_interrupts
    266121 ± 37%     -77.9%      58704 ± 82%  interrupts.CPU16.TLB:TLB_shootdowns
    216830 ± 74%     -90.0%      21706 ± 80%  interrupts.CPU17.CAL:Function_call_interrupts
    155845 ±104%     -91.7%      12939 ±118%  interrupts.CPU18.CAL:Function_call_interrupts
    305444 ± 48%     -81.6%      56176 ±145%  interrupts.CPU18.TLB:TLB_shootdowns
    580700 ± 24%    +100.8%    1165795 ± 11%  interrupts.CPU187.CAL:Function_call_interrupts
   1143784 ± 33%     +56.2%    1786340 ± 17%  interrupts.CPU187.TLB:TLB_shootdowns
    403282 ± 41%     +83.7%     741015 ± 26%  interrupts.CPU189.CAL:Function_call_interrupts
    127301 ± 69%     -75.3%      31438 ±152%  interrupts.CPU19.CAL:Function_call_interrupts
    139476 ± 41%     -85.3%      20557 ± 82%  interrupts.CPU20.CAL:Function_call_interrupts
    241687 ± 55%     -90.2%      23612 ±132%  interrupts.CPU21.CAL:Function_call_interrupts
    390203 ± 56%     -76.1%      93439 ±128%  interrupts.CPU21.TLB:TLB_shootdowns
      1374 ±  3%     -41.8%     800.25 ± 28%  interrupts.CPU24.RES:Rescheduling_interrupts
    291.25 ± 38%     -69.3%      89.50 ± 57%  interrupts.CPU25.RES:Rescheduling_interrupts
    372.50 ± 61%     -90.9%      34.00 ± 16%  interrupts.CPU27.RES:Rescheduling_interrupts
    382.25 ± 17%     -70.5%     112.75 ± 65%  interrupts.CPU29.RES:Rescheduling_interrupts
    109264 ± 20%     -42.8%      62530 ± 35%  interrupts.CPU3.CAL:Function_call_interrupts
    348.75 ± 52%     -58.7%     144.00 ± 21%  interrupts.CPU3.NMI:Non-maskable_interrupts
    348.75 ± 52%     -58.7%     144.00 ± 21%  interrupts.CPU3.PMI:Performance_monitoring_interrupts
    184.25 ± 67%     -69.2%      56.75 ± 39%  interrupts.CPU3.RES:Rescheduling_interrupts
    866.75 ±101%     -74.6%     220.25 ± 51%  interrupts.CPU32.NMI:Non-maskable_interrupts
    866.75 ±101%     -74.6%     220.25 ± 51%  interrupts.CPU32.PMI:Performance_monitoring_interrupts
    386.25 ± 77%     -81.0%      73.50 ± 62%  interrupts.CPU32.RES:Rescheduling_interrupts
    175.75 ± 47%     -84.8%      26.75 ± 38%  interrupts.CPU33.RES:Rescheduling_interrupts
     86801 ± 77%     -78.3%      18806 ± 56%  interrupts.CPU34.CAL:Function_call_interrupts
    290.25 ± 54%     -77.1%      66.50 ± 74%  interrupts.CPU34.RES:Rescheduling_interrupts
    509.25 ± 85%     -72.1%     142.00 ± 19%  interrupts.CPU4.NMI:Non-maskable_interrupts
    509.25 ± 85%     -72.1%     142.00 ± 19%  interrupts.CPU4.PMI:Performance_monitoring_interrupts
    233.75 ± 67%    +103.7%     476.25 ± 20%  interrupts.CPU41.NMI:Non-maskable_interrupts
    233.75 ± 67%    +103.7%     476.25 ± 20%  interrupts.CPU41.PMI:Performance_monitoring_interrupts
    102481 ± 60%     -86.2%      14192 ± 89%  interrupts.CPU42.CAL:Function_call_interrupts
    199657 ± 62%     -70.0%      59900 ±120%  interrupts.CPU42.TLB:TLB_shootdowns
     99111 ± 36%     -64.7%      34962 ±106%  interrupts.CPU44.CAL:Function_call_interrupts
    133788 ± 70%     -76.7%      31187 ± 87%  interrupts.CPU47.CAL:Function_call_interrupts
    255715 ± 45%     -72.7%      69684 ± 87%  interrupts.CPU47.TLB:TLB_shootdowns
    750.25 ± 24%     -51.7%     362.25 ± 74%  interrupts.CPU48.RES:Rescheduling_interrupts
    111872 ± 61%     -68.1%      35692 ± 13%  interrupts.CPU51.CAL:Function_call_interrupts
    248476 ± 54%     -65.9%      84695 ± 57%  interrupts.CPU51.TLB:TLB_shootdowns
    130521 ± 86%     -75.4%      32054 ± 81%  interrupts.CPU53.CAL:Function_call_interrupts
    330056 ± 64%     -76.1%      78788 ±107%  interrupts.CPU53.TLB:TLB_shootdowns
    122572 ± 36%     -73.8%      32077 ± 65%  interrupts.CPU54.CAL:Function_call_interrupts
    223.75 ± 73%     -81.3%      41.75 ± 60%  interrupts.CPU54.RES:Rescheduling_interrupts
    261777 ± 29%     -69.6%      79586 ±101%  interrupts.CPU54.TLB:TLB_shootdowns
     38695 ± 78%     -73.9%      10112 ± 83%  interrupts.CPU59.CAL:Function_call_interrupts
     91774 ± 39%     -75.9%      22107 ± 69%  interrupts.CPU6.CAL:Function_call_interrupts
    337.75 ± 54%     -82.3%      59.75 ± 48%  interrupts.CPU6.RES:Rescheduling_interrupts
     38136 ± 70%     -76.6%       8929 ± 95%  interrupts.CPU62.CAL:Function_call_interrupts
    107221 ± 74%     -82.2%      19106 ±131%  interrupts.CPU62.TLB:TLB_shootdowns
     50363 ± 79%     -85.2%       7477 ± 51%  interrupts.CPU63.CAL:Function_call_interrupts
    107471 ± 89%     -65.0%      37647 ±100%  interrupts.CPU63.TLB:TLB_shootdowns
    196470 ± 27%     -89.8%      20111 ±146%  interrupts.CPU66.CAL:Function_call_interrupts
    251626 ± 28%     -86.9%      33021 ±168%  interrupts.CPU66.TLB:TLB_shootdowns
    244907 ± 51%     -95.9%      10117 ± 95%  interrupts.CPU67.CAL:Function_call_interrupts
    351943 ± 41%     -94.1%      20599 ± 98%  interrupts.CPU67.TLB:TLB_shootdowns
    111121 ± 44%     -92.8%       7951 ± 95%  interrupts.CPU68.CAL:Function_call_interrupts
    169523 ± 45%     -80.0%      33881 ±144%  interrupts.CPU68.TLB:TLB_shootdowns
    128876 ± 44%     -97.2%       3560 ± 35%  interrupts.CPU69.CAL:Function_call_interrupts
    196198 ± 26%     -96.1%       7648 ± 82%  interrupts.CPU69.TLB:TLB_shootdowns
     86918 ± 43%     -78.8%      18404 ±138%  interrupts.CPU70.CAL:Function_call_interrupts
    137071 ± 53%     -69.6%      41713 ±137%  interrupts.CPU70.TLB:TLB_shootdowns
    248192 ± 54%     -99.1%       2141 ± 28%  interrupts.CPU71.CAL:Function_call_interrupts
    351778 ± 50%     -99.4%       2248 ±171%  interrupts.CPU71.TLB:TLB_shootdowns
     72843 ± 39%     -59.9%      29213 ± 73%  interrupts.CPU79.CAL:Function_call_interrupts
    296.25 ± 75%     -95.6%      13.00 ± 39%  interrupts.CPU79.RES:Rescheduling_interrupts
    294.75 ± 44%     -51.8%     142.00 ± 14%  interrupts.CPU8.NMI:Non-maskable_interrupts
    294.75 ± 44%     -51.8%     142.00 ± 14%  interrupts.CPU8.PMI:Performance_monitoring_interrupts
    631.50 ± 60%     -71.2%     181.75 ± 13%  interrupts.CPU82.NMI:Non-maskable_interrupts
    631.50 ± 60%     -71.2%     181.75 ± 13%  interrupts.CPU82.PMI:Performance_monitoring_interrupts
    180.75 ± 53%     -76.1%      43.25 ±118%  interrupts.CPU83.RES:Rescheduling_interrupts
    224.25 ± 45%     -74.6%      57.00 ±126%  interrupts.CPU84.RES:Rescheduling_interrupts
    152.75 ± 76%     -67.1%      50.25 ±110%  interrupts.CPU85.RES:Rescheduling_interrupts
     69834 ± 44%     -89.6%       7248 ± 34%  interrupts.CPU88.CAL:Function_call_interrupts
    175679 ± 56%     -84.4%      27337 ± 52%  interrupts.CPU88.TLB:TLB_shootdowns
     79758 ± 46%     -67.9%      25563 ±130%  interrupts.CPU89.CAL:Function_call_interrupts
    172259 ± 39%     -90.6%      16168 ± 96%  interrupts.CPU91.CAL:Function_call_interrupts
    163998 ± 41%     -87.5%      20465 ±101%  interrupts.CPU92.CAL:Function_call_interrupts
    272932 ± 52%     -79.7%      55479 ±115%  interrupts.CPU92.TLB:TLB_shootdowns
    171203 ± 30%     -88.9%      19071 ±112%  interrupts.CPU93.CAL:Function_call_interrupts
    281620 ± 34%     -85.6%      40571 ± 74%  interrupts.CPU93.TLB:TLB_shootdowns
      1737 ±123%     -92.9%     123.50 ± 17%  interrupts.CPU96.NMI:Non-maskable_interrupts
      1737 ±123%     -92.9%     123.50 ± 17%  interrupts.CPU96.PMI:Performance_monitoring_interrupts
    353.50 ± 48%     -60.5%     139.50 ± 44%  interrupts.CPU97.NMI:Non-maskable_interrupts
    353.50 ± 48%     -60.5%     139.50 ± 44%  interrupts.CPU97.PMI:Performance_monitoring_interrupts
    432.00 ± 42%     -66.6%     144.25 ± 21%  interrupts.CPU99.NMI:Non-maskable_interrupts
    432.00 ± 42%     -66.6%     144.25 ± 21%  interrupts.CPU99.PMI:Performance_monitoring_interrupts
     25708 ±  6%     -20.9%      20326 ±  8%  interrupts.RES:Rescheduling_interrupts
     35428 ± 11%     -32.4%      23935 ± 12%  softirqs.CPU0.RCU
     32512           -32.2%      22047 ±  8%  softirqs.CPU1.RCU
     31237 ±  2%     -31.1%      21518 ±  8%  softirqs.CPU10.RCU
     33358 ±  2%     -34.0%      22013 ±  8%  softirqs.CPU100.RCU
     34383 ±  5%     -34.9%      22384 ±  4%  softirqs.CPU101.RCU
     34539 ±  3%     -36.4%      21956 ±  7%  softirqs.CPU102.RCU
     33724 ±  6%     -35.7%      21681 ±  9%  softirqs.CPU103.RCU
     33883 ±  2%     -36.8%      21411 ±  8%  softirqs.CPU104.RCU
     33349 ±  3%     -34.5%      21843 ±  7%  softirqs.CPU105.RCU
     33947 ±  3%     -35.6%      21869 ±  8%  softirqs.CPU106.RCU
     35088 ±  2%     -37.9%      21804 ±  8%  softirqs.CPU107.RCU
     35392           -37.6%      22077 ±  9%  softirqs.CPU108.RCU
     34530           -36.0%      22086 ±  9%  softirqs.CPU109.RCU
     31070 ±  5%     -30.1%      21721 ±  7%  softirqs.CPU11.RCU
     35908 ±  2%     -40.7%      21300 ±  8%  softirqs.CPU110.RCU
     35501           -38.7%      21779 ±  7%  softirqs.CPU111.RCU
     34344 ±  2%     -42.2%      19837 ±  6%  softirqs.CPU112.RCU
     33845           -41.0%      19980 ±  7%  softirqs.CPU113.RCU
     33862 ±  3%     -39.7%      20433 ±  7%  softirqs.CPU114.RCU
     32765 ±  3%     -39.1%      19942 ±  7%  softirqs.CPU115.RCU
     32934 ±  2%     -38.6%      20224 ±  5%  softirqs.CPU116.RCU
     32819 ±  3%     -39.5%      19865 ±  6%  softirqs.CPU117.RCU
     33093 ±  3%     -39.9%      19885 ±  7%  softirqs.CPU118.RCU
     32575 ±  4%     -38.9%      19898 ±  6%  softirqs.CPU119.RCU
     31681 ±  7%     -31.0%      21852 ±  7%  softirqs.CPU12.RCU
     33330 ±  6%     -41.4%      19546 ±  6%  softirqs.CPU120.RCU
     33723 ±  5%     -43.1%      19200 ±  5%  softirqs.CPU121.RCU
     33744 ±  6%     -42.7%      19336 ±  6%  softirqs.CPU122.RCU
     33521 ±  8%     -41.4%      19648 ±  5%  softirqs.CPU123.RCU
     33386 ±  5%     -40.7%      19799 ±  5%  softirqs.CPU124.RCU
     33788 ±  4%     -43.8%      18979 ±  6%  softirqs.CPU125.RCU
     33692 ±  6%     -41.4%      19756 ±  5%  softirqs.CPU126.RCU
     33196 ±  7%     -41.8%      19309 ±  5%  softirqs.CPU127.RCU
     34241 ±  7%     -42.0%      19853 ±  7%  softirqs.CPU128.RCU
     33830 ±  6%     -42.1%      19600 ±  7%  softirqs.CPU129.RCU
     31799 ±  5%     -31.3%      21860 ±  9%  softirqs.CPU13.RCU
     33276 ±  4%     -41.2%      19566 ±  7%  softirqs.CPU130.RCU
     34680 ±  5%     -42.8%      19829 ±  6%  softirqs.CPU131.RCU
     34512 ±  4%     -42.3%      19913 ±  7%  softirqs.CPU132.RCU
     35534 ±  2%     -44.7%      19654 ±  6%  softirqs.CPU133.RCU
     34896 ±  3%     -43.0%      19889 ±  8%  softirqs.CPU134.RCU
     34745 ±  5%     -42.9%      19831 ±  7%  softirqs.CPU135.RCU
     35559 ±  7%     -44.1%      19890 ±  6%  softirqs.CPU136.RCU
     34349 ±  6%     -41.7%      20009 ±  8%  softirqs.CPU137.RCU
     34036 ±  5%     -41.9%      19771 ±  6%  softirqs.CPU138.RCU
     34760 ±  2%     -42.6%      19946 ±  7%  softirqs.CPU139.RCU
     31258 ±  2%     -31.2%      21499 ±  7%  softirqs.CPU14.RCU
     33466 ±  4%     -40.8%      19814 ±  7%  softirqs.CPU140.RCU
     32509 ±  5%     -40.8%      19246 ±  7%  softirqs.CPU141.RCU
     33244 ±  3%     -35.0%      21617 ±  8%  softirqs.CPU142.RCU
     32706 ±  5%     -38.6%      20067 ±  7%  softirqs.CPU143.RCU
     33261 ±  4%     -37.7%      20717 ±  5%  softirqs.CPU144.RCU
     32254 ±  2%     -37.2%      20271 ±  4%  softirqs.CPU145.RCU
     32274 ±  4%     -38.1%      19985 ±  4%  softirqs.CPU146.RCU
     32816 ±  4%     -37.4%      20532 ±  6%  softirqs.CPU147.RCU
     33441 ±  8%     -38.9%      20441 ±  6%  softirqs.CPU148.RCU
     33248 ±  6%     -40.0%      19953 ±  7%  softirqs.CPU149.RCU
     30279 ±  9%     -27.9%      21839 ±  9%  softirqs.CPU15.RCU
     32601 ±  6%     -38.2%      20155 ±  5%  softirqs.CPU150.RCU
     32860 ±  4%     -37.1%      20673 ±  8%  softirqs.CPU151.RCU
     32643 ±  6%     -37.0%      20569 ±  8%  softirqs.CPU152.RCU
     33337 ±  8%     -39.2%      20261 ±  5%  softirqs.CPU153.RCU
     32641 ±  7%     -37.2%      20493 ±  6%  softirqs.CPU154.RCU
     32548 ±  5%     -36.8%      20580 ±  5%  softirqs.CPU155.RCU
     33385 ±  4%     -38.5%      20531 ±  5%  softirqs.CPU156.RCU
     33250 ±  8%     -39.9%      19972 ±  4%  softirqs.CPU157.RCU
     33614 ±  5%     -39.0%      20507 ±  7%  softirqs.CPU158.RCU
     32542 ±  7%     -37.4%      20365 ±  6%  softirqs.CPU159.RCU
     30962 ±  4%     -33.2%      20694 ±  6%  softirqs.CPU16.RCU
     33130 ±  2%     -40.5%      19714 ±  4%  softirqs.CPU160.RCU
     32930 ±  4%     -39.2%      20029 ±  5%  softirqs.CPU161.RCU
     33810 ±  5%     -39.5%      20452 ±  7%  softirqs.CPU162.RCU
     33694 ±  4%     -39.9%      20249 ±  4%  softirqs.CPU163.RCU
     32579 ±  3%     -38.7%      19955 ±  6%  softirqs.CPU164.RCU
     31732 ±  3%     -36.8%      20067 ±  4%  softirqs.CPU165.RCU
     32614 ±  3%     -37.1%      20502 ±  7%  softirqs.CPU166.RCU
     32179 ±  3%     -37.2%      20218 ±  4%  softirqs.CPU167.RCU
     31673 ±  4%     -40.9%      18722 ±  4%  softirqs.CPU168.RCU
     31132 ±  6%     -39.3%      18899 ±  4%  softirqs.CPU169.RCU
     31814 ±  4%     -34.4%      20885 ±  5%  softirqs.CPU17.RCU
     32315 ±  6%     -44.3%      17995 ±  3%  softirqs.CPU170.RCU
     31903 ±  6%     -42.2%      18436 ±  4%  softirqs.CPU171.RCU
     30810 ±  6%     -39.0%      18786 ±  3%  softirqs.CPU172.RCU
     31117 ±  6%     -40.0%      18661 ±  6%  softirqs.CPU173.RCU
     31954 ±  7%     -41.8%      18597 ±  4%  softirqs.CPU174.RCU
     31720 ±  5%     -41.1%      18696 ±  4%  softirqs.CPU175.RCU
     34100 ± 10%     -41.9%      19817 ±  5%  softirqs.CPU176.RCU
     32522 ±  6%     -41.6%      19004 ±  6%  softirqs.CPU177.RCU
     32041 ±  7%     -41.7%      18685 ±  8%  softirqs.CPU178.RCU
     32337 ±  7%     -41.1%      19031 ±  6%  softirqs.CPU179.RCU
     31987 ±  8%     -34.0%      21115 ±  5%  softirqs.CPU18.RCU
     32733 ±  3%     -40.8%      19385 ±  8%  softirqs.CPU180.RCU
     32337 ±  5%     -40.0%      19418 ±  8%  softirqs.CPU181.RCU
     31730 ±  5%     -40.5%      18894 ±  7%  softirqs.CPU182.RCU
     32190           -41.7%      18778 ±  6%  softirqs.CPU183.RCU
     32604 ±  5%     -41.5%      19066 ±  7%  softirqs.CPU184.RCU
     32316           -41.1%      19049 ±  6%  softirqs.CPU185.RCU
     31497 ±  2%     -41.6%      18383 ±  5%  softirqs.CPU186.RCU
     31844 ±  4%     -40.9%      18828 ±  7%  softirqs.CPU187.RCU
     31207 ±  6%     -37.6%      19479 ±  7%  softirqs.CPU188.RCU
     31677 ±  5%     -40.2%      18932 ±  7%  softirqs.CPU189.RCU
     31643 ±  4%     -34.0%      20898 ±  5%  softirqs.CPU19.RCU
     31618 ±  8%     -38.9%      19308 ±  5%  softirqs.CPU190.RCU
     30165 ±  6%     -34.8%      19667 ±  5%  softirqs.CPU191.RCU
     30591 ±  4%     -28.1%      21993 ±  5%  softirqs.CPU2.RCU
     45537           +10.8%      50453 ±  2%  softirqs.CPU2.SCHED
     31294 ±  5%     -33.7%      20740 ±  5%  softirqs.CPU20.RCU
     32036 ±  3%     -34.9%      20853 ±  5%  softirqs.CPU21.RCU
     31837 ±  3%     -34.8%      20770 ±  6%  softirqs.CPU22.RCU
     31914 ±  2%     -34.8%      20815 ±  6%  softirqs.CPU23.RCU
     32142 ±  4%     -36.9%      20279 ±  6%  softirqs.CPU24.RCU
     30685 ±  5%     -34.5%      20098 ±  6%  softirqs.CPU25.RCU
     30461 ±  5%     -33.3%      20307 ±  5%  softirqs.CPU26.RCU
     29637 ±  9%     -31.0%      20444 ±  6%  softirqs.CPU27.RCU
     30580 ±  5%     -33.5%      20334 ±  5%  softirqs.CPU28.RCU
     30860 ±  5%     -35.7%      19856 ±  9%  softirqs.CPU29.RCU
     30808 ±  4%     -29.4%      21739 ±  9%  softirqs.CPU3.RCU
     30612 ±  5%     -33.8%      20276 ±  5%  softirqs.CPU30.RCU
     30416 ±  5%     -34.4%      19957 ±  6%  softirqs.CPU31.RCU
     32305 ±  8%     -34.3%      21232 ±  7%  softirqs.CPU32.RCU
     32214 ±  5%     -34.5%      21085 ±  6%  softirqs.CPU33.RCU
     31564 ±  4%     -33.1%      21101 ±  7%  softirqs.CPU34.RCU
     32098 ±  6%     -34.2%      21115 ±  7%  softirqs.CPU35.RCU
     31331 ±  4%     -27.0%      22869 ± 13%  softirqs.CPU36.RCU
     31247 ±  5%     -32.2%      21178 ±  7%  softirqs.CPU37.RCU
     32514 ±  8%     -35.0%      21125 ±  6%  softirqs.CPU38.RCU
     31150 ±  4%     -29.4%      21977 ±  8%  softirqs.CPU39.RCU
     30868 ±  4%     -29.4%      21808 ±  7%  softirqs.CPU4.RCU
     31274 ±  5%     -32.2%      21217 ±  6%  softirqs.CPU40.RCU
     31369 ±  6%     -32.9%      21039 ±  7%  softirqs.CPU41.RCU
     31353 ±  5%     -33.6%      20822 ±  6%  softirqs.CPU42.RCU
     32650 ±  5%     -34.9%      21267 ±  7%  softirqs.CPU43.RCU
     31688 ±  4%     -32.6%      21360 ±  5%  softirqs.CPU44.RCU
     31966 ±  7%     -34.1%      21053 ±  7%  softirqs.CPU45.RCU
     31681 ±  5%     -33.4%      21111 ±  7%  softirqs.CPU46.RCU
     31963 ±  5%     -34.3%      20989 ±  7%  softirqs.CPU47.RCU
     32375 ±  6%     -33.5%      21544 ±  6%  softirqs.CPU48.RCU
     31389 ±  5%     -28.6%      22426 ±  9%  softirqs.CPU49.RCU
     31171 ±  4%     -28.6%      22264 ±  7%  softirqs.CPU5.RCU
     32538 ±  6%     -34.2%      21408 ±  4%  softirqs.CPU50.RCU
     31689 ±  5%     -31.9%      21577 ±  7%  softirqs.CPU51.RCU
     31219 ±  7%     -30.8%      21588 ±  6%  softirqs.CPU52.RCU
     31505 ±  5%     -33.2%      21052 ±  6%  softirqs.CPU53.RCU
     31950 ±  6%     -32.7%      21498 ±  5%  softirqs.CPU54.RCU
     31274 ±  5%     -32.4%      21147 ±  5%  softirqs.CPU55.RCU
     31105 ±  5%     -31.4%      21350 ±  7%  softirqs.CPU56.RCU
     31774 ±  5%     -32.9%      21325 ±  4%  softirqs.CPU57.RCU
     30439 ± 10%     -29.3%      21506 ±  6%  softirqs.CPU58.RCU
     31582 ±  5%     -30.5%      21947 ±  5%  softirqs.CPU59.RCU
     31230 ±  4%     -30.4%      21728 ±  7%  softirqs.CPU6.RCU
     31606 ±  5%     -30.5%      21952 ±  4%  softirqs.CPU60.RCU
     31319 ±  6%     -32.7%      21076 ±  5%  softirqs.CPU61.RCU
     31538 ±  7%     -33.1%      21088 ±  6%  softirqs.CPU62.RCU
     31193 ±  5%     -31.1%      21499 ±  7%  softirqs.CPU63.RCU
     32026 ±  3%     -35.3%      20715 ±  5%  softirqs.CPU64.RCU
     32074 ±  3%     -34.6%      20982 ±  5%  softirqs.CPU65.RCU
     33788 ±  6%     -38.3%      20852 ±  5%  softirqs.CPU66.RCU
     32471 ±  5%     -34.9%      21149 ±  5%  softirqs.CPU67.RCU
     32427 ±  6%     -35.7%      20861 ±  6%  softirqs.CPU68.RCU
     32462 ±  4%     -35.2%      21044 ±  6%  softirqs.CPU69.RCU
     31535 ±  4%     -30.6%      21879 ±  7%  softirqs.CPU7.RCU
     43714 ±  5%     +11.5%      48741 ±  2%  softirqs.CPU7.SCHED
     32081 ±  2%     -35.0%      20854 ±  6%  softirqs.CPU70.RCU
     32576 ±  3%     -35.4%      21031 ±  5%  softirqs.CPU71.RCU
     30737 ±  4%     -35.1%      19939 ±  4%  softirqs.CPU72.RCU
     30253 ±  4%     -35.3%      19568 ±  5%  softirqs.CPU73.RCU
     30874 ±  7%     -37.0%      19449 ±  5%  softirqs.CPU74.RCU
     29806 ±  4%     -34.3%      19591 ±  5%  softirqs.CPU75.RCU
     29904 ±  5%     -35.0%      19451 ±  5%  softirqs.CPU76.RCU
     29914 ±  4%     -34.7%      19541 ±  4%  softirqs.CPU77.RCU
     30603 ±  5%     -36.8%      19352 ±  5%  softirqs.CPU78.RCU
     30164 ±  5%     -34.1%      19885 ±  7%  softirqs.CPU79.RCU
     30473 ±  4%     -28.6%      21745 ±  7%  softirqs.CPU8.RCU
     30256 ±  4%     -34.1%      19941 ±  6%  softirqs.CPU80.RCU
     29945 ±  4%     -33.3%      19961 ±  5%  softirqs.CPU81.RCU
     30259 ±  4%     -34.0%      19972 ±  7%  softirqs.CPU82.RCU
     30326 ±  4%     -34.0%      20016 ±  6%  softirqs.CPU83.RCU
     30662 ±  5%     -35.0%      19939 ±  5%  softirqs.CPU84.RCU
     30592 ±  4%     -34.8%      19953 ±  6%  softirqs.CPU85.RCU
     30065 ±  4%     -34.5%      19702 ±  6%  softirqs.CPU86.RCU
     30100 ±  4%     -34.2%      19805 ±  6%  softirqs.CPU87.RCU
     30493 ±  6%     -33.3%      20336 ±  4%  softirqs.CPU88.RCU
     30934 ±  6%     -35.7%      19883 ±  6%  softirqs.CPU89.RCU
     31023 ±  5%     -30.4%      21580 ±  6%  softirqs.CPU9.RCU
     30607 ±  5%     -35.8%      19653 ±  5%  softirqs.CPU90.RCU
     31895 ±  3%     -37.3%      20002 ±  6%  softirqs.CPU91.RCU
     30994 ±  5%     -34.7%      20242 ±  7%  softirqs.CPU92.RCU
     31973 ±  5%     -38.0%      19833 ±  5%  softirqs.CPU93.RCU
     31326 ±  7%     -35.8%      20111 ±  6%  softirqs.CPU94.RCU
     32100 ±  4%     -36.3%      20461 ±  7%  softirqs.CPU95.RCU
     34644 ±  2%     -37.9%      21527 ±  7%  softirqs.CPU96.RCU
     34061 ±  5%     -36.2%      21721 ±  7%  softirqs.CPU97.RCU
     34668 ±  3%     -38.2%      21433 ±  6%  softirqs.CPU98.RCU
     34388 ±  3%     -37.3%      21564 ±  7%  softirqs.CPU99.RCU
   6196758 ±  4%     -36.5%    3932333 ±  6%  softirqs.RCU


                                                                                
                               vm-scalability.median                            
                                                                                
  7000 +--------------------------------------------------------------------+   
       |.+.+.+.+.+.++.+   +.+.+.+.+.+.+.+.++.+.+.+   +.+.+.                 |   
  6000 |-O O O O O OO :   : O O O O O O   OO O O : O : O O +.+.+.+O O O O O |   
       |              :   :                      :   :                      |   
  5000 |-+            :   :                      :   :                      |   
       |               : :                        : :                       |   
  4000 |-+             : :                        : :                       |   
       |               : :                        : :                       |   
  3000 |-+             : :                        : :                       |   
       |               : :                        : :                       |   
  2000 |-+             : :                        : :                       |   
       |                :                          :                        |   
  1000 |-+              :                          :                        |   
       |                :                          :                        |   
     0 +--------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                              vm-scalability.stddev_                            
                                                                                
  4500 +--------------------------------------------------------------------+   
       |                                                          O         |   
  4000 |-+                                                                  |   
  3500 |-+                                                                  |   
       |                                                                    |   
  3000 |-+                                                                  |   
  2500 |-+                                                                  |   
       |                                                                    |   
  2000 |-+                                                                  |   
  1500 |-+                                                                  |   
       |                                                                    |   
  1000 |-+                                                                  |   
   500 |-+                                                                  |   
       | O O O O O OO O   O.+.O O O   O   OO O O O O.+.O O.+.+.+.+  O O O O |   
     0 +--------------------------------------------------------------------+   
                                                                                
                                                                                
[*] bisect-good sample
[O] bisect-bad  sample

***************************************************************************************************
lkp-csl-2sp4: 96 threads Intel(R) Xeon(R) CPU @ 2.30GHz with 128G memory
=========================================================================================
compiler/cpufreq_governor/kconfig/nr_pmem/nr_task/priority/rootfs/tbox_group/test/testcase/thp_defrag/thp_enabled/ucode:
  gcc-9/performance/x86_64-rhel-8.3/2/8/1/debian-10.4-x86_64-20200603.cgz/lkp-csl-2sp4/swap-w-seq/vm-scalability/never/never/0x4003003

commit: 
  3852f6768e ("mm/swapcache: support to handle the shadow entries")
  aae466b005 ("mm/swap: implement workingset detection for anonymous LRU")

3852f6768ede542e aae466b0052e1888edd1d7f473d 
---------------- --------------------------- 
       fail:runs  %reproduction    fail:runs
           |             |             |    
           :3           29%           0:2     perf-profile.calltrace.cycles-pp.sync_regs.error_entry.do_access
           :3           34%           1:2     perf-profile.calltrace.cycles-pp.error_entry.do_access
          1:3           11%           1:2     perf-profile.children.cycles-pp.error_entry
          0:3            1%           0:2     perf-profile.self.cycles-pp.error_entry
         %stddev     %change         %stddev
             \          |                \  
    542839           +18.8%     644645 ±  9%  vm-scalability.median
   4306633           +12.8%    4855863 ±  4%  vm-scalability.throughput
     30.01            -3.1%      29.07        vm-scalability.time.elapsed_time
     30.01            -3.1%      29.07        vm-scalability.time.elapsed_time.max
     36096 ± 27%     -64.0%      12994 ± 41%  vm-scalability.time.involuntary_context_switches
   5106690 ±  5%     +26.8%    6477410 ± 13%  vm-scalability.time.maximum_resident_set_size
      2001 ± 56%     -69.5%     611.00 ± 12%  vm-scalability.time.voluntary_context_switches
      5476 ± 29%    +311.6%      22539 ± 78%  cpuidle.C1.usage
      5283 ± 16%     -36.1%       3375 ±  9%  vmstat.system.cs
     20.69            +3.5%      21.42 ±  2%  boot-time.boot
      1529 ±  3%      +7.5%       1643        boot-time.idle
     89.51            +1.3%      90.68        iostat.cpu.idle
      8.65           -14.6%       7.39 ± 11%  iostat.cpu.system
     36029 ± 14%     +68.2%      60587 ± 30%  meminfo.CmaFree
    697090 ±  5%      +9.4%     762414 ±  2%  meminfo.DirectMap4k
      0.00 ± 10%      +0.0        0.00        mpstat.cpu.all.iowait%
      0.35 ±  5%      -0.3        0.05 ± 18%  mpstat.cpu.all.soft%
 1.813e+08 ±  2%     -41.0%   1.07e+08 ± 17%  perf-node.node-loads
     38.67 ±  2%     -32.8%      26.00 ±  7%  perf-node.node-local-load-ratio
     54.67           -61.6%      21.00 ±  9%  perf-node.node-local-store-ratio
 2.167e+08 ±  4%     -20.8%  1.717e+08 ±  9%  perf-node.node-store-misses
 2.671e+08 ±  2%     -82.3%   47402485 ±  2%  perf-node.node-stores
     22519 ±  3%     -20.3%      17951 ±  9%  numa-meminfo.node0.Active
     22324 ±  3%     -20.6%      17736 ± 10%  numa-meminfo.node0.Active(anon)
     13921 ±  2%     +15.8%      16121 ± 14%  numa-meminfo.node0.Mapped
      5201 ± 20%     +32.3%       6881 ±  3%  numa-meminfo.node1.Active
      5084 ± 20%     +34.0%       6811 ±  3%  numa-meminfo.node1.Active(anon)
     65575 ±  4%     +12.4%      73725 ±  5%  numa-meminfo.node1.KReclaimable
      7093 ±  2%      +7.4%       7615 ±  2%  numa-meminfo.node1.KernelStack
     17090 ±  4%     -13.8%      14733 ±  5%  numa-meminfo.node1.Mapped
     66670 ±  5%     -23.4%      51082 ± 14%  numa-meminfo.node1.PageTables
     65575 ±  4%     +12.4%      73725 ±  5%  numa-meminfo.node1.SReclaimable
   3308500 ± 20%    +140.2%    7945839 ± 36%  numa-numastat.node0.local_node
   1675907 ±  6%    +140.5%    4030944 ±  4%  numa-numastat.node0.numa_foreign
   3318819 ± 20%    +140.3%    7976782 ± 36%  numa-numastat.node0.numa_hit
   5171847 ± 14%     -62.5%    1939771 ± 34%  numa-numastat.node0.numa_miss
   5182188 ± 14%     -62.0%    1970716 ± 34%  numa-numastat.node0.other_node
  15171228           -31.1%   10449562 ± 23%  numa-numastat.node1.local_node
   5171847 ± 14%     -62.5%    1939771 ± 34%  numa-numastat.node1.numa_foreign
  15191898           -31.2%   10449560 ± 23%  numa-numastat.node1.numa_hit
   1675907 ±  6%    +140.5%    4030944 ±  4%  numa-numastat.node1.numa_miss
   1696577 ±  7%    +137.6%    4030962 ±  4%  numa-numastat.node1.other_node
      1430 ±  4%     +14.6%       1640 ±  2%  slabinfo.Acpi-Parse.active_objs
      1430 ±  4%     +14.6%       1640 ±  2%  slabinfo.Acpi-Parse.num_objs
      1495 ±  7%     +28.5%       1921 ±  9%  slabinfo.dmaengine-unmap-16.active_objs
      1495 ±  7%     +28.5%       1921 ±  9%  slabinfo.dmaengine-unmap-16.num_objs
      4330 ±  9%      +8.6%       4704 ±  4%  slabinfo.eventpoll_pwq.active_objs
      4330 ±  9%      +8.6%       4704 ±  4%  slabinfo.eventpoll_pwq.num_objs
    893.33            +5.4%     941.50 ±  4%  slabinfo.filp.active_slabs
     28601            +5.4%      30133 ±  4%  slabinfo.filp.num_objs
    893.33            +5.4%     941.50 ±  4%  slabinfo.filp.num_slabs
    790.00 ± 11%     +16.2%     918.00 ±  6%  slabinfo.kmem_cache_node.active_objs
    828.00 ± 10%     +15.3%     955.00 ±  6%  slabinfo.kmem_cache_node.num_objs
      1983 ±  9%     +16.6%       2312 ± 10%  slabinfo.radix_tree_node.active_slabs
    111093 ±  9%     +16.6%     129533 ± 10%  slabinfo.radix_tree_node.num_objs
      1983 ±  9%     +16.6%       2312 ± 10%  slabinfo.radix_tree_node.num_slabs
      4330 ±  6%     -15.0%       3680        slabinfo.skbuff_head_cache.active_objs
      4330 ±  6%     -15.0%       3680        slabinfo.skbuff_head_cache.num_objs
      5566 ±  3%     -20.5%       4424 ±  9%  numa-vmstat.node0.nr_active_anon
      3524 ±  3%     +15.2%       4061 ± 13%  numa-vmstat.node0.nr_mapped
      5576 ±  2%     -20.7%       4424 ±  9%  numa-vmstat.node0.nr_zone_active_anon
   1054096 ± 10%    +164.4%    2787187 ± 19%  numa-vmstat.node0.numa_foreign
   2769819 ± 18%     +83.1%    5070160 ± 30%  numa-vmstat.node0.numa_hit
   2716892 ± 17%     +83.2%    4977012 ± 32%  numa-vmstat.node0.numa_local
   3395314 ± 14%     -63.4%    1241437 ± 54%  numa-vmstat.node0.numa_miss
   3448253 ± 12%     -61.3%    1334595 ± 55%  numa-vmstat.node0.numa_other
      1265 ± 21%     +34.8%       1706 ±  4%  numa-vmstat.node1.nr_active_anon
      8775 ± 13%     +74.8%      15335 ± 29%  numa-vmstat.node1.nr_free_cma
    103.33 ±  4%     -37.1%      65.00 ± 30%  numa-vmstat.node1.nr_isolated_anon
      7103 ±  2%      +7.3%       7619 ±  2%  numa-vmstat.node1.nr_kernel_stack
     16671 ±  4%     -23.3%      12782 ± 14%  numa-vmstat.node1.nr_page_table_pages
      1276 ± 21%     +33.8%       1707 ±  4%  numa-vmstat.node1.nr_zone_active_anon
   3395812 ± 14%     -63.4%    1241615 ± 54%  numa-vmstat.node1.numa_foreign
   1054335 ± 10%    +164.4%    2787638 ± 19%  numa-vmstat.node1.numa_miss
   1166568 ±  4%    +145.1%    2859690 ± 20%  numa-vmstat.node1.numa_other
     15105 ±  2%     -45.0%       8309 ± 50%  proc-vmstat.allocstall_movable
     30459 ± 49%     -71.7%       8615 ± 48%  proc-vmstat.compact_isolated
      6848 ±  3%     -10.4%       6136 ±  6%  proc-vmstat.nr_active_anon
      9005 ± 14%     +68.2%      15144 ± 30%  proc-vmstat.nr_free_cma
    132.33 ±  5%     -23.7%     101.00 ±  7%  proc-vmstat.nr_isolated_anon
      6868 ±  3%     -10.7%       6136 ±  6%  proc-vmstat.nr_zone_active_anon
      7563 ± 27%     -64.8%       2660 ± 61%  proc-vmstat.numa_hint_faults
  10414558 ±  9%     -19.1%    8428117 ±  2%  proc-vmstat.numa_pte_updates
   1031362           -20.5%     820126        proc-vmstat.pgalloc_dma32
  31078215           -24.0%   23617831        proc-vmstat.pgalloc_normal
  32164957           -23.9%   24479418        proc-vmstat.pgfree
      4152           -23.2%       3188 ±  3%  proc-vmstat.pgmajfault
     17471 ± 45%     -74.5%       4458 ± 49%  proc-vmstat.pgmigrate_success
  46356943 ±  9%     -28.9%   32956826 ± 17%  proc-vmstat.pgscan_anon
  29201063 ± 14%     -28.2%   20954738 ±  2%  proc-vmstat.pgscan_direct
      4248 ±  2%     -21.8%       3321        proc-vmstat.pswpin
     36037            +3.2%      37204        proc-vmstat.slabs_scanned
      0.00        +2.8e+10%     284.55 ± 22%  sched_debug.cfs_rq:/.MIN_vruntime.avg
      0.00        +2.7e+12%      27316 ± 22%  sched_debug.cfs_rq:/.MIN_vruntime.max
      2720 ± 18%    +589.5%      18759 ± 31%  sched_debug.cfs_rq:/.load.avg
     46202 ± 36%   +3321.4%    1580776 ± 32%  sched_debug.cfs_rq:/.load.max
      8163 ± 17%   +1865.3%     160439 ± 32%  sched_debug.cfs_rq:/.load.stddev
    382.50 ±121%     -91.3%      33.40 ± 12%  sched_debug.cfs_rq:/.load_avg.avg
     17337 ±129%     -94.4%     972.00        sched_debug.cfs_rq:/.load_avg.max
      2438 ±128%     -94.4%     136.89 ±  8%  sched_debug.cfs_rq:/.load_avg.stddev
      0.00        +2.8e+10%     284.55 ± 22%  sched_debug.cfs_rq:/.max_vruntime.avg
      0.00        +2.7e+12%      27316 ± 22%  sched_debug.cfs_rq:/.max_vruntime.max
     16104 ± 13%     +54.7%      24908 ± 36%  sched_debug.cfs_rq:/.min_vruntime.avg
      9293 ± 32%     +72.6%      16037 ± 32%  sched_debug.cfs_rq:/.min_vruntime.min
      3035 ±  5%     +38.0%       4189 ± 24%  sched_debug.cfs_rq:/.min_vruntime.stddev
      1.00          +100.0%       2.00        sched_debug.cfs_rq:/.nr_running.max
      0.32 ±  7%     +15.6%       0.37 ±  2%  sched_debug.cfs_rq:/.nr_running.stddev
     20.87 ± 39%     -75.4%       5.12 ±100%  sched_debug.cfs_rq:/.removed.load_avg.avg
    140.08 ± 20%     -64.3%      49.95 ±100%  sched_debug.cfs_rq:/.removed.load_avg.stddev
    355.11 ±  4%     -14.2%     304.76        sched_debug.cfs_rq:/.runnable_avg.stddev
   -759.95         -1050.2%       7221 ± 72%  sched_debug.cfs_rq:/.spread0.avg
     12531 ± 16%     +76.2%      22078 ± 25%  sched_debug.cfs_rq:/.spread0.max
     -7559           -81.2%      -1421        sched_debug.cfs_rq:/.spread0.min
      3045 ±  4%     +38.5%       4219 ± 24%  sched_debug.cfs_rq:/.spread0.stddev
    355.02 ±  4%     -14.1%     304.79        sched_debug.cfs_rq:/.util_avg.stddev
     34.72 ± 12%     -21.4%      27.28 ±  2%  sched_debug.cfs_rq:/.util_est_enqueued.avg
    772814 ±  7%      +5.6%     816403 ±  6%  sched_debug.cpu.avg_idle.avg
   1396289 ± 27%    +314.0%    5781242 ± 71%  sched_debug.cpu.avg_idle.max
      2225 ± 32%    +512.8%      13639 ± 81%  sched_debug.cpu.avg_idle.min
      0.12 ± 11%     +14.7%       0.14 ±  7%  sched_debug.cpu.nr_running.avg
      1.00          +100.0%       2.00        sched_debug.cpu.nr_running.max
      0.32 ±  4%     +15.2%       0.37 ±  2%  sched_debug.cpu.nr_running.stddev
      6.76 ±  9%     +11.6%       7.55 ±  5%  sched_debug.cpu.nr_uninterruptible.stddev
      4.47 ±122%    +308.4%      18.27 ± 78%  sched_debug.cpu.sched_count.avg
    272.67 ±136%    +313.5%       1127 ± 79%  sched_debug.cpu.sched_count.max
     32.56 ±133%    +325.6%     138.57 ± 78%  sched_debug.cpu.sched_count.stddev
      2.26 ±122%    +305.0%       9.15 ± 77%  sched_debug.cpu.sched_goidle.avg
    137.67 ±136%    +310.4%     565.00 ± 79%  sched_debug.cpu.sched_goidle.max
     16.42 ±133%    +322.8%      69.44 ± 78%  sched_debug.cpu.sched_goidle.stddev
      0.98 ± 57%    +796.7%       8.79 ± 68%  sched_debug.cpu.ttwu_count.avg
     51.00 ± 76%    +952.0%     536.50 ± 75%  sched_debug.cpu.ttwu_count.max
      6.18 ± 72%    +971.6%      66.18 ± 73%  sched_debug.cpu.ttwu_count.stddev
      0.08 ± 55%     -80.3%       0.02 ±  6%  sched_debug.cpu.ttwu_local.avg
      0.36 ± 47%     -65.4%       0.13 ±  3%  sched_debug.cpu.ttwu_local.stddev
     17248 ± 18%     -59.1%       7054 ± 50%  softirqs.CPU0.RCU
      9395 ± 25%     -63.7%       3412 ± 34%  softirqs.CPU1.RCU
      9451 ± 17%     -70.5%       2785 ± 27%  softirqs.CPU11.RCU
      8411 ± 33%     -60.8%       3294 ±  2%  softirqs.CPU13.RCU
      8757 ± 18%     -70.4%       2590 ± 27%  softirqs.CPU14.RCU
     15363 ± 11%     -82.6%       2668 ± 23%  softirqs.CPU24.RCU
     14609 ± 20%     -77.0%       3361 ± 26%  softirqs.CPU25.RCU
     11185 ± 21%     -73.8%       2931 ± 31%  softirqs.CPU26.RCU
     11890 ± 31%     -68.1%       3790 ±  5%  softirqs.CPU27.RCU
     11480 ± 29%     -73.2%       3073 ± 17%  softirqs.CPU28.RCU
     10461 ± 33%     -63.2%       3847 ±  6%  softirqs.CPU29.RCU
     13942 ± 32%     -78.2%       3045 ± 25%  softirqs.CPU30.RCU
     12582 ±  3%     -77.0%       2889 ± 38%  softirqs.CPU31.RCU
     12318 ± 24%     -70.8%       3600 ± 10%  softirqs.CPU32.RCU
      9897 ± 10%     -44.1%       5537 ± 37%  softirqs.CPU33.RCU
     10918 ±  9%     -72.4%       3018 ± 21%  softirqs.CPU34.RCU
     14239 ± 33%     -76.2%       3386 ±  4%  softirqs.CPU35.RCU
     11469 ± 23%     -74.6%       2908 ± 28%  softirqs.CPU36.RCU
     12694 ± 50%     -77.9%       2805 ± 26%  softirqs.CPU37.RCU
     13133 ± 19%     -79.1%       2746 ± 27%  softirqs.CPU38.RCU
     12577 ±  7%     -78.8%       2672 ± 30%  softirqs.CPU39.RCU
     12311 ± 14%     -75.6%       3002 ± 34%  softirqs.CPU40.RCU
     11091 ±  3%     -73.5%       2940 ± 31%  softirqs.CPU41.RCU
      9579 ± 25%     -72.0%       2683 ± 37%  softirqs.CPU42.RCU
     10558 ± 14%     -74.3%       2713 ± 37%  softirqs.CPU43.RCU
     10360 ± 37%     -69.2%       3188 ± 30%  softirqs.CPU44.RCU
      9697 ± 20%     -71.5%       2763 ± 24%  softirqs.CPU45.RCU
      8819 ± 39%     -67.4%       2873 ± 24%  softirqs.CPU46.RCU
     10626 ± 29%     -74.2%       2738 ± 21%  softirqs.CPU47.RCU
      7931 ± 24%     -69.7%       2402 ± 25%  softirqs.CPU48.RCU
     11642 ± 23%     -72.4%       3219 ± 43%  softirqs.CPU72.RCU
     10515 ± 28%     -76.8%       2442 ± 28%  softirqs.CPU73.RCU
     13581 ± 60%     -79.1%       2837 ± 42%  softirqs.CPU75.RCU
     14199 ± 53%     -81.4%       2639 ± 33%  softirqs.CPU76.RCU
      8791 ± 31%     -71.5%       2504 ± 30%  softirqs.CPU77.RCU
     13260 ± 32%     -81.8%       2418 ± 32%  softirqs.CPU78.RCU
     13741 ± 24%     -79.4%       2837 ± 24%  softirqs.CPU79.RCU
     11007 ± 25%     -77.6%       2463 ± 32%  softirqs.CPU80.RCU
     10950 ± 33%     -77.2%       2494 ± 33%  softirqs.CPU81.RCU
     10367 ± 30%     -74.8%       2610 ± 23%  softirqs.CPU82.RCU
     12792 ± 18%     -81.6%       2353 ± 34%  softirqs.CPU83.RCU
     11857 ± 32%     -79.2%       2465 ± 37%  softirqs.CPU85.RCU
      9573 ± 38%     -73.9%       2498 ± 30%  softirqs.CPU86.RCU
      8645 ± 18%     -70.6%       2542 ± 34%  softirqs.CPU87.RCU
     10293 ± 27%     -76.5%       2417 ± 33%  softirqs.CPU88.RCU
     10604 ± 29%     -72.7%       2896 ± 22%  softirqs.CPU89.RCU
      8119 ± 24%     -70.8%       2371 ± 31%  softirqs.CPU90.RCU
      9698 ± 25%     -65.8%       3321 ± 48%  softirqs.CPU95.RCU
    862186 ± 10%     -67.6%     279218 ± 27%  softirqs.RCU
      8.23           -23.0%       6.34 ±  8%  perf-stat.i.MPKI
 6.462e+09            -4.4%  6.175e+09        perf-stat.i.branch-instructions
      0.56            +0.0        0.57        perf-stat.i.branch-miss-rate%
  30675041            -2.2%   29993559        perf-stat.i.branch-misses
 1.099e+08 ±  4%     -23.4%   84100899 ±  9%  perf-stat.i.cache-misses
 1.996e+08           -27.2%  1.453e+08 ±  9%  perf-stat.i.cache-references
      5330 ± 18%     -40.5%       3170 ±  9%  perf-stat.i.context-switches
  3.42e+10           -10.1%  3.074e+10 ±  6%  perf-stat.i.cpu-cycles
    274.89           -19.8%     220.40        perf-stat.i.cpu-migrations
    496.32 ±  5%     +25.8%     624.53 ± 16%  perf-stat.i.cycles-between-cache-misses
 6.592e+09            -7.9%  6.069e+09 ±  3%  perf-stat.i.dTLB-loads
      0.13            +0.0        0.16 ± 13%  perf-stat.i.dTLB-store-miss-rate%
 2.832e+09 ±  2%     -13.9%  2.439e+09 ±  7%  perf-stat.i.dTLB-stores
   2194729            -4.3%    2099808 ±  2%  perf-stat.i.iTLB-loads
 2.588e+10            -6.8%  2.413e+10 ±  3%  perf-stat.i.instructions
    104.43           -24.2%      79.16 ± 16%  perf-stat.i.major-faults
      0.36           -10.1%       0.32 ±  6%  perf-stat.i.metric.GHz
    167.95            -7.8%     154.81 ±  3%  perf-stat.i.metric.M/sec
    810491            +2.6%     831441        perf-stat.i.minor-faults
     63.14 ±  3%      +6.8       69.97 ±  5%  perf-stat.i.node-load-miss-rate%
   9153385 ±  7%     +16.6%   10675997 ±  5%  perf-stat.i.node-load-misses
   5449241 ±  5%     -33.6%    3619910 ±  7%  perf-stat.i.node-loads
     48.01           +25.4       73.36 ± 10%  perf-stat.i.node-store-miss-rate%
   8802770 ± 11%     -79.6%    1794154 ± 20%  perf-stat.i.node-stores
    810595            +2.6%     831521        perf-stat.i.page-faults
      7.71           -22.0%       6.01 ±  6%  perf-stat.overall.MPKI
      0.48            +0.0        0.49        perf-stat.overall.branch-miss-rate%
     55.07 ±  3%      +2.8       57.89        perf-stat.overall.cache-miss-rate%
    311.03 ±  2%     +17.7%     365.94 ±  2%  perf-stat.overall.cycles-between-cache-misses
      0.15            +0.0        0.17 ±  5%  perf-stat.overall.dTLB-store-miss-rate%
     62.67 ±  2%     +12.0       74.69        perf-stat.overall.node-load-miss-rate%
     43.92           +36.5       80.41 ±  3%  perf-stat.overall.node-store-miss-rate%
      7132            -9.3%       6468 ±  4%  perf-stat.overall.path-length
 6.258e+09            -4.4%  5.979e+09        perf-stat.ps.branch-instructions
  29818678            -2.7%   29004012        perf-stat.ps.branch-misses
 1.065e+08 ±  4%     -23.5%   81492231 ±  9%  perf-stat.ps.cache-misses
 1.934e+08           -27.2%  1.408e+08 ±  9%  perf-stat.ps.cache-references
      5145 ± 18%     -40.3%       3070 ±  9%  perf-stat.ps.context-switches
  3.31e+10           -10.1%  2.975e+10 ±  6%  perf-stat.ps.cpu-cycles
    266.05           -20.0%     212.96        perf-stat.ps.cpu-migrations
 6.386e+09            -8.0%  5.876e+09 ±  3%  perf-stat.ps.dTLB-loads
 2.743e+09 ±  2%     -13.9%  2.363e+09 ±  7%  perf-stat.ps.dTLB-stores
   2123501            -4.4%    2029324 ±  2%  perf-stat.ps.iTLB-loads
 2.507e+10            -6.8%  2.336e+10 ±  3%  perf-stat.ps.instructions
    101.46           -24.8%      76.33 ± 16%  perf-stat.ps.major-faults
    784848            +2.6%     805278        perf-stat.ps.minor-faults
   8879280 ±  6%     +16.5%   10347043 ±  5%  perf-stat.ps.node-load-misses
   5280243 ±  5%     -33.5%    3511677 ±  7%  perf-stat.ps.node-loads
   8532944 ± 11%     -79.6%    1737146 ± 19%  perf-stat.ps.node-stores
    784950            +2.6%     805354        perf-stat.ps.page-faults
 7.758e+11            -9.3%  7.036e+11 ±  4%  perf-stat.total.instructions
     16.00 ± 19%      -9.7        6.28 ± 37%  perf-profile.calltrace.cycles-pp.shrink_node.do_try_to_free_pages.try_to_free_pages.__alloc_pages_slowpath.__alloc_pages_nodemask
     15.76 ± 19%      -9.5        6.25 ± 37%  perf-profile.calltrace.cycles-pp.shrink_lruvec.shrink_node.do_try_to_free_pages.try_to_free_pages.__alloc_pages_slowpath
     15.72 ± 19%      -9.5        6.24 ± 37%  perf-profile.calltrace.cycles-pp.shrink_inactive_list.shrink_lruvec.shrink_node.do_try_to_free_pages.try_to_free_pages
     11.57 ± 37%      -9.1        2.51 ±100%  perf-profile.calltrace.cycles-pp.__alloc_pages_slowpath.__alloc_pages_nodemask.alloc_pages_vma.do_anonymous_page.__handle_mm_fault
     10.80 ± 40%      -8.5        2.32 ±100%  perf-profile.calltrace.cycles-pp.try_to_free_pages.__alloc_pages_slowpath.__alloc_pages_nodemask.alloc_pages_vma.do_anonymous_page
     10.79 ± 40%      -8.5        2.32 ±100%  perf-profile.calltrace.cycles-pp.do_try_to_free_pages.try_to_free_pages.__alloc_pages_slowpath.__alloc_pages_nodemask.alloc_pages_vma
     11.52 ±  2%      -8.4        3.10 ±100%  perf-profile.calltrace.cycles-pp.ret_from_fork
     11.52 ±  2%      -8.4        3.10 ±100%  perf-profile.calltrace.cycles-pp.kthread.ret_from_fork
     12.38 ± 36%      -7.5        4.88 ± 15%  perf-profile.calltrace.cycles-pp.alloc_pages_vma.do_anonymous_page.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
     12.26 ± 36%      -7.5        4.79 ± 17%  perf-profile.calltrace.cycles-pp.__alloc_pages_nodemask.alloc_pages_vma.do_anonymous_page.__handle_mm_fault.handle_mm_fault
     13.21 ± 15%      -7.1        6.14 ± 36%  perf-profile.calltrace.cycles-pp.shrink_page_list.shrink_inactive_list.shrink_lruvec.shrink_node.do_try_to_free_pages
      8.08 ±  7%      -5.1        2.94 ±100%  perf-profile.calltrace.cycles-pp.kswapd.kthread.ret_from_fork
      8.08 ±  7%      -5.1        2.94 ±100%  perf-profile.calltrace.cycles-pp.balance_pgdat.kswapd.kthread.ret_from_fork
      8.07 ±  7%      -5.1        2.94 ±100%  perf-profile.calltrace.cycles-pp.shrink_node.balance_pgdat.kswapd.kthread.ret_from_fork
      8.05 ±  8%      -5.1        2.93 ±100%  perf-profile.calltrace.cycles-pp.shrink_lruvec.shrink_node.balance_pgdat.kswapd.kthread
      8.04 ±  7%      -5.1        2.93 ±100%  perf-profile.calltrace.cycles-pp.shrink_inactive_list.shrink_lruvec.shrink_node.balance_pgdat.kswapd
      7.51 ±  9%      -4.7        2.77 ±100%  perf-profile.calltrace.cycles-pp.shrink_page_list.shrink_inactive_list.shrink_lruvec.shrink_node.balance_pgdat
      5.02 ±  5%      -2.4        2.62 ± 35%  perf-profile.calltrace.cycles-pp.try_to_unmap_flush_dirty.shrink_page_list.shrink_inactive_list.shrink_lruvec.shrink_node
      5.01 ±  5%      -2.4        2.62 ± 35%  perf-profile.calltrace.cycles-pp.arch_tlbbatch_flush.try_to_unmap_flush_dirty.shrink_page_list.shrink_inactive_list.shrink_lruvec
      4.66 ± 13%      -2.4        2.27 ± 64%  perf-profile.calltrace.cycles-pp.pageout.shrink_page_list.shrink_inactive_list.shrink_lruvec.shrink_node
      4.91 ±  5%      -2.4        2.55 ± 34%  perf-profile.calltrace.cycles-pp.on_each_cpu_cond_mask.arch_tlbbatch_flush.try_to_unmap_flush_dirty.shrink_page_list.shrink_inactive_list
      4.60 ±  4%      -2.1        2.47 ± 33%  perf-profile.calltrace.cycles-pp.smp_call_function_single.on_each_cpu_cond_mask.arch_tlbbatch_flush.try_to_unmap_flush_dirty.shrink_page_list
      3.96 ± 13%      -2.1        1.86 ± 65%  perf-profile.calltrace.cycles-pp.__swap_writepage.pageout.shrink_page_list.shrink_inactive_list.shrink_lruvec
      3.89 ± 13%      -2.1        1.81 ± 65%  perf-profile.calltrace.cycles-pp.bdev_write_page.__swap_writepage.pageout.shrink_page_list.shrink_inactive_list
      3.23 ± 13%      -2.0        1.24 ±100%  perf-profile.calltrace.cycles-pp.__remove_mapping.shrink_page_list.shrink_inactive_list.shrink_lruvec.shrink_node
      3.48 ± 14%      -1.9        1.58 ± 65%  perf-profile.calltrace.cycles-pp.pmem_rw_page.bdev_write_page.__swap_writepage.pageout.shrink_page_list
      2.06 ± 35%      -1.8        0.25 ±100%  perf-profile.calltrace.cycles-pp.page_referenced.shrink_page_list.shrink_inactive_list.shrink_lruvec.shrink_node
      1.94 ± 26%      -1.4        0.57 ±100%  perf-profile.calltrace.cycles-pp.pmem_do_write.pmem_rw_page.bdev_write_page.__swap_writepage.pageout
      1.94 ± 26%      -1.4        0.57 ±100%  perf-profile.calltrace.cycles-pp.write_pmem.pmem_do_write.pmem_rw_page.bdev_write_page.__swap_writepage
      1.86 ± 25%      -1.3        0.55 ±100%  perf-profile.calltrace.cycles-pp.__memcpy_flushcache.write_pmem.pmem_do_write.pmem_rw_page.bdev_write_page
      0.96 ± 34%      -0.7        0.28 ±100%  perf-profile.calltrace.cycles-pp.mem_cgroup_swapout.__remove_mapping.shrink_page_list.shrink_inactive_list.shrink_lruvec
      0.56 ±  8%      +0.3        0.82        perf-profile.calltrace.cycles-pp.tick_nohz_get_sleep_length.menu_select.do_idle.cpu_startup_entry.start_secondary
      0.36 ± 70%      +0.4        0.73 ±  6%  perf-profile.calltrace.cycles-pp.tick_nohz_next_event.tick_nohz_get_sleep_length.menu_select.do_idle.cpu_startup_entry
      1.61 ±  8%      +0.4        2.06 ± 22%  perf-profile.calltrace.cycles-pp.menu_select.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64
      0.68 ± 17%      +0.5        1.21 ± 37%  perf-profile.calltrace.cycles-pp.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.asm_call_on_stack.sysvec_apic_timer_interrupt
      0.20 ±141%      +0.6        0.82 ± 31%  perf-profile.calltrace.cycles-pp.tick_sched_timer.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.asm_call_on_stack
      1.29 ± 15%      +1.1        2.42 ± 45%  perf-profile.calltrace.cycles-pp.hrtimer_interrupt.__sysvec_apic_timer_interrupt.asm_call_on_stack.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      1.31 ± 15%      +1.1        2.46 ± 45%  perf-profile.calltrace.cycles-pp.__sysvec_apic_timer_interrupt.asm_call_on_stack.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state
      1.31 ± 15%      +1.2        2.47 ± 45%  perf-profile.calltrace.cycles-pp.asm_call_on_stack.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter
      0.17 ±141%      +1.3        1.47 ± 15%  perf-profile.calltrace.cycles-pp.clear_shadow_from_swap_cache.swapcache_free_entries.free_swap_slot.__swap_entry_free.free_swap_and_cache
     29.19 ± 21%      +4.7       33.91 ± 23%  perf-profile.calltrace.cycles-pp.intel_idle.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry
     32.27 ± 18%      +7.3       39.52 ± 12%  perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry.start_secondary
     32.59 ± 18%      +7.4       40.00 ± 11%  perf-profile.calltrace.cycles-pp.cpuidle_enter.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64
     34.63 ± 16%      +7.9       42.53 ±  9%  perf-profile.calltrace.cycles-pp.secondary_startup_64
     34.42 ± 16%      +8.0       42.44 ±  9%  perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64
     34.42 ± 16%      +8.0       42.45 ±  9%  perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.secondary_startup_64
     34.42 ± 16%      +8.0       42.45 ±  9%  perf-profile.calltrace.cycles-pp.start_secondary.secondary_startup_64
     25.02 ± 11%     -15.8        9.27 ± 57%  perf-profile.children.cycles-pp.shrink_node
     24.75 ± 11%     -15.5        9.23 ± 57%  perf-profile.children.cycles-pp.shrink_lruvec
     24.71 ± 11%     -15.5        9.23 ± 57%  perf-profile.children.cycles-pp.shrink_inactive_list
     21.26 ±  7%     -12.3        8.96 ± 56%  perf-profile.children.cycles-pp.shrink_page_list
     17.87 ± 19%     -11.3        6.54 ± 39%  perf-profile.children.cycles-pp.__alloc_pages_slowpath
     16.97 ± 20%     -10.6        6.34 ± 38%  perf-profile.children.cycles-pp.try_to_free_pages
     16.95 ± 20%     -10.6        6.34 ± 38%  perf-profile.children.cycles-pp.do_try_to_free_pages
     18.60 ± 19%      -9.8        8.84 ± 10%  perf-profile.children.cycles-pp.__alloc_pages_nodemask
     11.52 ±  2%      -8.2        3.31 ± 87%  perf-profile.children.cycles-pp.kthread
     11.52 ±  2%      -8.2        3.31 ± 87%  perf-profile.children.cycles-pp.ret_from_fork
     12.53 ± 36%      -7.6        4.89 ± 15%  perf-profile.children.cycles-pp.alloc_pages_vma
      8.08 ±  7%      -5.1        2.94 ±100%  perf-profile.children.cycles-pp.kswapd
      8.08 ±  7%      -5.1        2.94 ±100%  perf-profile.children.cycles-pp.balance_pgdat
      5.15 ±  5%      -2.5        2.63 ± 35%  perf-profile.children.cycles-pp.try_to_unmap_flush_dirty
      5.15 ±  5%      -2.5        2.63 ± 35%  perf-profile.children.cycles-pp.arch_tlbbatch_flush
      5.05 ±  5%      -2.5        2.56 ± 34%  perf-profile.children.cycles-pp.on_each_cpu_cond_mask
      4.79 ± 13%      -2.5        2.29 ± 65%  perf-profile.children.cycles-pp.pageout
      3.64 ± 15%      -2.4        1.24 ± 66%  perf-profile.children.cycles-pp.rmap_walk_anon
      4.78 ±  4%      -2.3        2.50 ± 34%  perf-profile.children.cycles-pp.smp_call_function_single
      4.06 ± 14%      -2.2        1.88 ± 65%  perf-profile.children.cycles-pp.__swap_writepage
      3.99 ± 14%      -2.2        1.83 ± 65%  perf-profile.children.cycles-pp.bdev_write_page
      2.92 ± 10%      -2.1        0.84 ± 49%  perf-profile.children.cycles-pp.add_to_swap
      3.56 ± 14%      -2.0        1.59 ± 65%  perf-profile.children.cycles-pp.pmem_rw_page
      2.03 ± 14%      -1.9        0.09 ± 44%  perf-profile.children.cycles-pp.rcu_do_batch
      2.46 ± 59%      -1.9        0.53 ±  6%  perf-profile.children.cycles-pp._raw_spin_lock_irq
      2.08 ± 14%      -1.9        0.21 ± 65%  perf-profile.children.cycles-pp.add_to_swap_cache
      3.33 ± 14%      -1.9        1.47 ± 70%  perf-profile.children.cycles-pp.__remove_mapping
      2.12 ± 42%      -1.8        0.29        perf-profile.children.cycles-pp.worker_thread
      2.08 ± 14%      -1.8        0.27 ± 77%  perf-profile.children.cycles-pp.rcu_core
      2.10 ± 43%      -1.8        0.29        perf-profile.children.cycles-pp.process_one_work
      2.43 ± 25%      -1.8        0.63 ± 68%  perf-profile.children.cycles-pp.page_referenced
      2.42 ± 14%      -1.6        0.82 ± 58%  perf-profile.children.cycles-pp.__softirqentry_text_start
      1.60 ± 14%      -1.6        0.03 ±100%  perf-profile.children.cycles-pp.xas_create_range
      1.59 ± 14%      -1.6        0.04 ±100%  perf-profile.children.cycles-pp.xas_create
      1.64 ± 13%      -1.5        0.10 ± 50%  perf-profile.children.cycles-pp.kmem_cache_free
      1.37 ± 12%      -1.3        0.04 ±100%  perf-profile.children.cycles-pp.__slab_free
      1.28 ± 23%      -1.2        0.04 ±100%  perf-profile.children.cycles-pp.run_ksoftirqd
      1.31 ± 22%      -1.2        0.07 ± 23%  perf-profile.children.cycles-pp.smpboot_thread_fn
      2.13 ± 16%      -1.2        0.96 ± 65%  perf-profile.children.cycles-pp.pmem_do_write
      2.11 ± 16%      -1.2        0.95 ± 65%  perf-profile.children.cycles-pp.write_pmem
      2.09 ± 16%      -1.2        0.94 ± 65%  perf-profile.children.cycles-pp.__memcpy_flushcache
      1.22 ± 27%      -0.9        0.30 ± 80%  perf-profile.children.cycles-pp.page_referenced_one
      1.17 ± 20%      -0.8        0.33 ± 70%  perf-profile.children.cycles-pp.page_vma_mapped_walk
      1.53 ±  7%      -0.8        0.71 ± 67%  perf-profile.children.cycles-pp.try_to_unmap
      1.41 ± 11%      -0.8        0.62 ± 64%  perf-profile.children.cycles-pp.end_page_writeback
      0.87 ± 12%      -0.7        0.18 ± 61%  perf-profile.children.cycles-pp.__delete_from_swap_cache
      0.80 ± 28%      -0.7        0.14 ±100%  perf-profile.children.cycles-pp.isolate_lru_pages
      1.17 ±  9%      -0.6        0.57 ± 66%  perf-profile.children.cycles-pp.try_to_unmap_one
      0.85 ± 21%      -0.6        0.27 ± 47%  perf-profile.children.cycles-pp.page_lock_anon_vma_read
      1.49 ±  6%      -0.5        0.95 ± 34%  perf-profile.children.cycles-pp.asm_sysvec_call_function_single
      0.59 ± 19%      -0.4        0.18 ± 60%  perf-profile.children.cycles-pp.down_read_trylock
      0.46 ± 35%      -0.4        0.06 ±100%  perf-profile.children.cycles-pp.move_pages_to_lru
      1.01 ±  5%      -0.3        0.68 ± 31%  perf-profile.children.cycles-pp.sysvec_call_function_single
      0.93 ±  9%      -0.3        0.60 ± 30%  perf-profile.children.cycles-pp.flush_smp_call_function_queue
      0.34 ± 63%      -0.3        0.03 ±100%  perf-profile.children.cycles-pp.__libc_fork
      0.33 ± 65%      -0.3        0.03 ±100%  perf-profile.children.cycles-pp.__do_sys_clone
      0.33 ± 65%      -0.3        0.03 ±100%  perf-profile.children.cycles-pp._do_fork
      0.33 ± 65%      -0.3        0.03 ±100%  perf-profile.children.cycles-pp.copy_process
      0.91 ±  5%      -0.3        0.62 ± 32%  perf-profile.children.cycles-pp.__sysvec_call_function_single
      0.46 ± 12%      -0.2        0.21 ± 67%  perf-profile.children.cycles-pp.put_swap_page
      0.27 ± 51%      -0.2        0.04 ±100%  perf-profile.children.cycles-pp.smp_call_function_many_cond
      1.05 ± 10%      -0.2        0.83        perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      0.26 ± 35%      -0.2        0.05 ±100%  perf-profile.children.cycles-pp.__isolate_lru_page
      0.60 ± 14%      -0.2        0.41 ±  8%  perf-profile.children.cycles-pp.xas_store
      0.25 ± 61%      -0.2        0.06 ± 16%  perf-profile.children.cycles-pp.__x64_sys_execve
      0.25 ± 61%      -0.2        0.06 ± 16%  perf-profile.children.cycles-pp.execve
      0.25 ± 61%      -0.2        0.06 ± 16%  perf-profile.children.cycles-pp.do_execveat_common
      0.39 ± 15%      -0.2        0.21 ± 31%  perf-profile.children.cycles-pp.flush_tlb_func_common
      0.19 ± 42%      -0.2        0.03 ±100%  perf-profile.children.cycles-pp.shrink_slab
      0.22 ±  7%      -0.1        0.07 ±100%  perf-profile.children.cycles-pp.test_clear_page_writeback
      0.27 ± 26%      -0.1        0.13 ± 23%  perf-profile.children.cycles-pp.up_read
      0.24 ± 22%      -0.1        0.12 ± 39%  perf-profile.children.cycles-pp.native_flush_tlb_local
      0.21 ±  4%      -0.1        0.08 ± 29%  perf-profile.children.cycles-pp.start_kernel
      0.31 ± 13%      -0.1        0.20 ± 12%  perf-profile.children.cycles-pp.propagate_protected_usage
      0.20 ± 14%      -0.1        0.09 ± 22%  perf-profile.children.cycles-pp.page_mapping
      0.50 ±  3%      -0.1        0.41 ±  4%  perf-profile.children.cycles-pp._raw_spin_unlock_irqrestore
      0.11 ± 32%      -0.1        0.03 ±100%  perf-profile.children.cycles-pp.unlock_page
      0.13 ± 12%      -0.1        0.05 ±100%  perf-profile.children.cycles-pp.clear_page_dirty_for_io
      0.11 ± 25%      -0.1        0.04 ±100%  perf-profile.children.cycles-pp.__set_page_dirty_no_writeback
      0.15 ± 28%      -0.1        0.07        perf-profile.children.cycles-pp._find_next_bit
      0.09 ±  9%      -0.1        0.03 ±100%  perf-profile.children.cycles-pp.cpumask_any_but
      0.07 ± 14%      -0.0        0.03 ±100%  perf-profile.children.cycles-pp.inc_node_page_state
      0.08 ± 14%      -0.0        0.06 ±  9%  perf-profile.children.cycles-pp._cond_resched
      0.08 ± 31%      +0.0        0.11 ± 18%  perf-profile.children.cycles-pp.calc_global_load_tick
      0.07 ± 14%      +0.0        0.10 ±  5%  perf-profile.children.cycles-pp.arch_cpu_idle_enter
      0.07 ± 14%      +0.0        0.10 ±  5%  perf-profile.children.cycles-pp.tsc_verify_tsc_adjust
      0.07 ± 18%      +0.0        0.10 ±  5%  perf-profile.children.cycles-pp.__radix_tree_lookup
      0.02 ±141%      +0.0        0.06 ± 16%  perf-profile.children.cycles-pp.do_swap
      0.00            +0.1        0.06 ±  9%  perf-profile.children.cycles-pp.xas_start
      0.02 ±141%      +0.1        0.08 ± 37%  perf-profile.children.cycles-pp.hrtimer_next_event_without
      0.27 ± 12%      +0.1        0.33 ± 15%  perf-profile.children.cycles-pp.scheduler_tick
      0.15 ± 11%      +0.1        0.24 ± 19%  perf-profile.children.cycles-pp.memcpy_erms
      0.15 ± 11%      +0.1        0.24 ± 19%  perf-profile.children.cycles-pp.drm_fb_helper_dirty_work
      0.02 ±141%      +0.1        0.10 ± 42%  perf-profile.children.cycles-pp.rcu_sched_clock_irq
      0.14 ± 17%      +0.1        0.23 ± 43%  perf-profile.children.cycles-pp.perf_mux_hrtimer_handler
      0.30 ±  9%      +0.1        0.41 ± 23%  perf-profile.children.cycles-pp.timekeeping_max_deferment
      0.00            +0.1        0.11 ±  4%  perf-profile.children.cycles-pp.xas_clear_mark
      0.02 ±141%      +0.1        0.15 ±  6%  perf-profile.children.cycles-pp.xas_init_marks
      0.51 ±  8%      +0.2        0.73 ±  6%  perf-profile.children.cycles-pp.tick_nohz_next_event
      0.46 ± 20%      +0.2        0.68 ± 22%  perf-profile.children.cycles-pp.update_process_times
      0.46 ± 20%      +0.2        0.68 ± 22%  perf-profile.children.cycles-pp.tick_sched_handle
      0.56 ±  8%      +0.3        0.83        perf-profile.children.cycles-pp.tick_nohz_get_sleep_length
      0.43 ± 17%      +0.3        0.71 ± 35%  perf-profile.children.cycles-pp.clockevents_program_event
      0.59 ± 17%      +0.3        0.93 ± 32%  perf-profile.children.cycles-pp.tick_sched_timer
      0.08 ± 26%      +0.4        0.51 ± 21%  perf-profile.children.cycles-pp.xas_load
      1.62 ±  8%      +0.5        2.07 ± 22%  perf-profile.children.cycles-pp.menu_select
      0.05 ± 70%      +0.5        0.56 ± 21%  perf-profile.children.cycles-pp.xas_find
      0.82 ± 15%      +0.5        1.35 ± 37%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      0.51 ±  4%      +1.0        1.52 ± 16%  perf-profile.children.cycles-pp.clear_shadow_from_swap_cache
     29.35 ± 21%      +4.6       33.95 ± 23%  perf-profile.children.cycles-pp.intel_idle
     32.79 ± 18%      +7.3       40.07 ± 11%  perf-profile.children.cycles-pp.cpuidle_enter
     32.78 ± 18%      +7.3       40.06 ± 11%  perf-profile.children.cycles-pp.cpuidle_enter_state
     34.63 ± 16%      +7.9       42.53 ±  9%  perf-profile.children.cycles-pp.secondary_startup_64
     34.63 ± 16%      +7.9       42.53 ±  9%  perf-profile.children.cycles-pp.cpu_startup_entry
     34.63 ± 16%      +7.9       42.53 ±  9%  perf-profile.children.cycles-pp.do_idle
     34.42 ± 16%      +8.0       42.45 ±  9%  perf-profile.children.cycles-pp.start_secondary
      4.20 ±  5%      -2.0        2.25 ± 30%  perf-profile.self.cycles-pp.smp_call_function_single
      1.33 ± 12%      -1.3        0.04 ±100%  perf-profile.self.cycles-pp.__slab_free
      1.97 ± 16%      -1.1        0.90 ± 64%  perf-profile.self.cycles-pp.__memcpy_flushcache
      1.10 ± 12%      -0.6        0.50 ± 64%  perf-profile.self.cycles-pp.end_page_writeback
      0.54 ± 15%      -0.4        0.12 ±100%  perf-profile.self.cycles-pp.page_vma_mapped_walk
      0.55 ± 11%      -0.4        0.14 ±100%  perf-profile.self.cycles-pp.shrink_page_list
      0.56 ± 20%      -0.4        0.17 ± 57%  perf-profile.self.cycles-pp.down_read_trylock
      0.28 ± 40%      -0.2        0.04 ±100%  perf-profile.self.cycles-pp.move_pages_to_lru
      0.32 ± 18%      -0.2        0.07 ±100%  perf-profile.self.cycles-pp.page_lock_anon_vma_read
      0.26 ± 35%      -0.2        0.05 ±100%  perf-profile.self.cycles-pp.__isolate_lru_page
      0.25 ± 19%      -0.2        0.06 ±100%  perf-profile.self.cycles-pp.rmap_walk_anon
      0.38 ±  8%      -0.2        0.21 ± 56%  perf-profile.self.cycles-pp.try_to_unmap_one
      0.29 ± 14%      -0.2        0.13 ± 61%  perf-profile.self.cycles-pp.add_to_swap_cache
      0.21 ± 23%      -0.2        0.06 ±100%  perf-profile.self.cycles-pp.page_referenced_one
      0.17 ± 20%      -0.1        0.03 ±100%  perf-profile.self.cycles-pp.xas_create
      0.31 ± 13%      -0.1        0.18 ± 16%  perf-profile.self.cycles-pp.propagate_protected_usage
      0.26 ± 28%      -0.1        0.12 ± 19%  perf-profile.self.cycles-pp.up_read
      0.24 ± 22%      -0.1        0.12 ± 39%  perf-profile.self.cycles-pp.native_flush_tlb_local
      0.16 ± 24%      -0.1        0.04 ±100%  perf-profile.self.cycles-pp.isolate_lru_pages
      0.18 ± 15%      -0.1        0.09 ± 17%  perf-profile.self.cycles-pp.page_mapping
      0.11 ± 36%      -0.1        0.03 ±100%  perf-profile.self.cycles-pp.unlock_page
      0.13 ± 26%      -0.1        0.07 ±  7%  perf-profile.self.cycles-pp._find_next_bit
      0.09 ± 19%      -0.1        0.03 ±100%  perf-profile.self.cycles-pp.pageout
      0.13 ± 12%      -0.0        0.09 ± 17%  perf-profile.self.cycles-pp.flush_tlb_func_common
      0.07 ±  7%      -0.0        0.03 ±100%  perf-profile.self.cycles-pp.test_clear_page_writeback
      0.06 ±  7%      -0.0        0.03 ±100%  perf-profile.self.cycles-pp.inc_node_page_state
      0.16 ± 10%      -0.0        0.12 ±  4%  perf-profile.self.cycles-pp.get_page_from_freelist
      0.06 ± 13%      +0.0        0.08 ±  5%  perf-profile.self.cycles-pp.__radix_tree_lookup
      0.06 ± 19%      +0.0        0.09        perf-profile.self.cycles-pp.tsc_verify_tsc_adjust
      0.08 ± 31%      +0.0        0.11 ± 18%  perf-profile.self.cycles-pp.calc_global_load_tick
      0.34 ±  7%      +0.0        0.38 ±  6%  perf-profile.self.cycles-pp.swap_range_free
      0.02 ±141%      +0.1        0.08 ± 37%  perf-profile.self.cycles-pp.rcu_sched_clock_irq
      0.00            +0.1        0.06 ± 16%  perf-profile.self.cycles-pp.do_swap
      0.09 ± 10%      +0.1        0.15 ± 41%  perf-profile.self.cycles-pp.irqtime_account_irq
      0.00            +0.1        0.08 ±  6%  perf-profile.self.cycles-pp.xas_find
      0.15 ± 11%      +0.1        0.24 ± 19%  perf-profile.self.cycles-pp.memcpy_erms
      0.12 ± 10%      +0.1        0.21 ± 12%  perf-profile.self.cycles-pp.xas_store
      0.15 ±  9%      +0.1        0.24 ±  4%  perf-profile.self.cycles-pp.tick_nohz_next_event
      0.11 ± 14%      +0.1        0.21 ± 21%  perf-profile.self.cycles-pp.clear_shadow_from_swap_cache
      0.30 ± 11%      +0.1        0.41 ± 23%  perf-profile.self.cycles-pp.timekeeping_max_deferment
      0.00            +0.1        0.11 ±  9%  perf-profile.self.cycles-pp.xas_clear_mark
      0.02 ±141%      +0.4        0.45 ± 21%  perf-profile.self.cycles-pp.xas_load
     29.34 ± 21%      +4.6       33.95 ± 23%  perf-profile.self.cycles-pp.intel_idle
      1309 ± 31%     -95.8%      55.00 ± 38%  interrupts.CPU1.NMI:Non-maskable_interrupts
      1309 ± 31%     -95.8%      55.00 ± 38%  interrupts.CPU1.PMI:Performance_monitoring_interrupts
    113374 ± 41%    -100.0%      55.00 ±  7%  interrupts.CPU11.CAL:Function_call_interrupts
    257.33 ± 58%     -74.4%      66.00 ± 46%  interrupts.CPU11.NMI:Non-maskable_interrupts
    257.33 ± 58%     -74.4%      66.00 ± 46%  interrupts.CPU11.PMI:Performance_monitoring_interrupts
    123300 ± 42%    -100.0%       2.00 ±100%  interrupts.CPU11.TLB:TLB_shootdowns
     71595 ± 21%    +346.8%     319882 ± 25%  interrupts.CPU13.CAL:Function_call_interrupts
     39.33 ±112%     +80.5%      71.00 ± 66%  interrupts.CPU13.RES:Rescheduling_interrupts
     79142 ± 23%    +327.8%     338596 ± 25%  interrupts.CPU13.TLB:TLB_shootdowns
    121354 ± 28%     -99.9%      70.50 ± 31%  interrupts.CPU14.CAL:Function_call_interrupts
    282.67 ± 73%    +397.1%       1405 ±  7%  interrupts.CPU14.NMI:Non-maskable_interrupts
    282.67 ± 73%    +397.1%       1405 ±  7%  interrupts.CPU14.PMI:Performance_monitoring_interrupts
    133142 ± 28%    -100.0%       1.00 ±100%  interrupts.CPU14.TLB:TLB_shootdowns
     79518 ± 47%     -99.4%     497.50 ± 90%  interrupts.CPU17.CAL:Function_call_interrupts
     87505 ± 47%     -99.5%     431.50 ±100%  interrupts.CPU17.TLB:TLB_shootdowns
     57594 ± 58%     -99.9%      77.00 ± 49%  interrupts.CPU18.CAL:Function_call_interrupts
     62678 ± 58%    -100.0%       1.50 ± 33%  interrupts.CPU18.TLB:TLB_shootdowns
     83503 ± 32%     -99.9%      95.00 ± 36%  interrupts.CPU19.CAL:Function_call_interrupts
    387.33 ± 75%     -82.3%      68.50 ±  6%  interrupts.CPU19.NMI:Non-maskable_interrupts
    387.33 ± 75%     -82.3%      68.50 ±  6%  interrupts.CPU19.PMI:Performance_monitoring_interrupts
     92869 ± 29%    -100.0%       2.00 ±100%  interrupts.CPU19.TLB:TLB_shootdowns
     76523 ± 29%     -98.8%     934.00 ± 93%  interrupts.CPU2.CAL:Function_call_interrupts
      1128 ± 68%     -89.7%     116.00 ± 65%  interrupts.CPU2.NMI:Non-maskable_interrupts
      1128 ± 68%     -89.7%     116.00 ± 65%  interrupts.CPU2.PMI:Performance_monitoring_interrupts
     84432 ± 28%     -99.3%     550.00 ± 99%  interrupts.CPU2.TLB:TLB_shootdowns
     42900 ± 35%     -99.9%      50.50 ±  4%  interrupts.CPU20.CAL:Function_call_interrupts
     47261 ± 35%    -100.0%       1.00 ±100%  interrupts.CPU20.TLB:TLB_shootdowns
     55343 ±  5%     -99.8%     133.50 ± 64%  interrupts.CPU21.CAL:Function_call_interrupts
    557.33 ± 70%     -83.9%      89.50 ± 19%  interrupts.CPU21.NMI:Non-maskable_interrupts
    557.33 ± 70%     -83.9%      89.50 ± 19%  interrupts.CPU21.PMI:Performance_monitoring_interrupts
     60700 ±  3%    -100.0%       1.50 ±100%  interrupts.CPU21.TLB:TLB_shootdowns
     65151 ± 29%     -99.9%      65.50 ± 31%  interrupts.CPU23.CAL:Function_call_interrupts
      1511 ±132%     -96.6%      51.50 ± 28%  interrupts.CPU23.NMI:Non-maskable_interrupts
      1511 ±132%     -96.6%      51.50 ± 28%  interrupts.CPU23.PMI:Performance_monitoring_interrupts
     71450 ± 26%    -100.0%       2.50 ± 20%  interrupts.CPU23.TLB:TLB_shootdowns
    917.33 ± 65%    +289.9%       3576 ± 39%  interrupts.CPU24.NMI:Non-maskable_interrupts
    917.33 ± 65%    +289.9%       3576 ± 39%  interrupts.CPU24.PMI:Performance_monitoring_interrupts
    304398 ± 14%    +354.3%    1382899 ± 17%  interrupts.CPU25.CAL:Function_call_interrupts
    331035 ± 15%    +351.5%    1494674 ± 15%  interrupts.CPU25.TLB:TLB_shootdowns
    198328 ± 28%    +632.6%    1452903 ±  4%  interrupts.CPU26.CAL:Function_call_interrupts
    494.00 ± 20%    +343.8%       2192 ± 35%  interrupts.CPU26.NMI:Non-maskable_interrupts
    494.00 ± 20%    +343.8%       2192 ± 35%  interrupts.CPU26.PMI:Performance_monitoring_interrupts
    215319 ± 28%    +623.9%    1558705 ±  4%  interrupts.CPU26.TLB:TLB_shootdowns
     58.33 ± 88%     -86.3%       8.00 ± 12%  interrupts.CPU28.RES:Rescheduling_interrupts
    189955 ± 55%     -99.9%     116.50 ± 47%  interrupts.CPU29.CAL:Function_call_interrupts
      1128 ± 49%     -92.0%      90.50 ± 22%  interrupts.CPU29.NMI:Non-maskable_interrupts
      1128 ± 49%     -92.0%      90.50 ± 22%  interrupts.CPU29.PMI:Performance_monitoring_interrupts
    205120 ± 55%    -100.0%       1.00 ±100%  interrupts.CPU29.TLB:TLB_shootdowns
    127609 ± 33%     -96.9%       3959 ± 98%  interrupts.CPU3.CAL:Function_call_interrupts
    139191 ± 32%     -97.2%       3873 ±100%  interrupts.CPU3.TLB:TLB_shootdowns
    281773 ± 58%     -99.8%     476.50 ± 87%  interrupts.CPU30.CAL:Function_call_interrupts
      1645 ± 12%     -94.7%      88.00 ± 20%  interrupts.CPU30.NMI:Non-maskable_interrupts
      1645 ± 12%     -94.7%      88.00 ± 20%  interrupts.CPU30.PMI:Performance_monitoring_interrupts
    105.00 ± 59%     -91.9%       8.50 ± 52%  interrupts.CPU30.RES:Rescheduling_interrupts
    303723 ± 58%     -99.9%     432.00 ± 99%  interrupts.CPU30.TLB:TLB_shootdowns
    236289 ± 46%     -87.7%      29164 ± 99%  interrupts.CPU32.CAL:Function_call_interrupts
    918.67 ± 36%     -90.1%      90.50 ± 14%  interrupts.CPU32.NMI:Non-maskable_interrupts
    918.67 ± 36%     -90.1%      90.50 ± 14%  interrupts.CPU32.PMI:Performance_monitoring_interrupts
    135.00 ± 56%     -97.0%       4.00 ±100%  interrupts.CPU32.RES:Rescheduling_interrupts
    255505 ± 46%     -88.1%      30485 ± 99%  interrupts.CPU32.TLB:TLB_shootdowns
    260418 ± 32%    -100.0%      70.00 ± 30%  interrupts.CPU34.CAL:Function_call_interrupts
      1693 ± 41%     -92.1%     134.00 ± 48%  interrupts.CPU34.NMI:Non-maskable_interrupts
      1693 ± 41%     -92.1%     134.00 ± 48%  interrupts.CPU34.PMI:Performance_monitoring_interrupts
    283853 ± 32%    -100.0%       2.50 ± 20%  interrupts.CPU34.TLB:TLB_shootdowns
    306303          -100.0%      72.00 ± 19%  interrupts.CPU35.CAL:Function_call_interrupts
      1685 ± 23%     -94.3%      96.50 ±  8%  interrupts.CPU35.NMI:Non-maskable_interrupts
      1685 ± 23%     -94.3%      96.50 ±  8%  interrupts.CPU35.PMI:Performance_monitoring_interrupts
    377.33 ± 88%     -97.5%       9.50 ± 89%  interrupts.CPU35.RES:Rescheduling_interrupts
    331951 ±  2%    -100.0%       1.50 ± 33%  interrupts.CPU35.TLB:TLB_shootdowns
      2148 ± 86%     -95.9%      88.50 ± 17%  interrupts.CPU36.NMI:Non-maskable_interrupts
      2148 ± 86%     -95.9%      88.50 ± 17%  interrupts.CPU36.PMI:Performance_monitoring_interrupts
      1007 ± 33%     -93.0%      71.00        interrupts.CPU39.NMI:Non-maskable_interrupts
      1007 ± 33%     -93.0%      71.00        interrupts.CPU39.PMI:Performance_monitoring_interrupts
     89.67 ± 57%     -98.3%       1.50 ± 33%  interrupts.CPU39.RES:Rescheduling_interrupts
    227185 ± 39%    -100.0%      45.00 ±  6%  interrupts.CPU40.CAL:Function_call_interrupts
    297.33 ±105%     -99.8%       0.50 ±100%  interrupts.CPU40.RES:Rescheduling_interrupts
    248670 ± 39%    -100.0%       1.50 ±100%  interrupts.CPU40.TLB:TLB_shootdowns
    281008 ± 24%    -100.0%      52.50 ±  2%  interrupts.CPU41.CAL:Function_call_interrupts
      2233 ± 34%     -96.8%      70.50 ±  2%  interrupts.CPU41.NMI:Non-maskable_interrupts
      2233 ± 34%     -96.8%      70.50 ±  2%  interrupts.CPU41.PMI:Performance_monitoring_interrupts
     78.00 ± 35%     -98.1%       1.50 ±100%  interrupts.CPU41.RES:Rescheduling_interrupts
    304440 ± 24%    -100.0%       4.00 ± 25%  interrupts.CPU41.TLB:TLB_shootdowns
    295913 ± 47%    -100.0%      52.00 ±  5%  interrupts.CPU42.CAL:Function_call_interrupts
      2330 ± 57%     -96.4%      84.50 ± 25%  interrupts.CPU42.NMI:Non-maskable_interrupts
      2330 ± 57%     -96.4%      84.50 ± 25%  interrupts.CPU42.PMI:Performance_monitoring_interrupts
    321984 ± 48%    -100.0%       2.00 ±100%  interrupts.CPU42.TLB:TLB_shootdowns
    168874 ± 32%    -100.0%      75.00 ± 25%  interrupts.CPU43.CAL:Function_call_interrupts
    182538 ± 32%    -100.0%       1.50 ±100%  interrupts.CPU43.TLB:TLB_shootdowns
    212342 ± 41%     -99.9%     107.50 ± 49%  interrupts.CPU44.CAL:Function_call_interrupts
    475.00 ± 32%     -80.6%      92.00 ± 26%  interrupts.CPU44.NMI:Non-maskable_interrupts
    475.00 ± 32%     -80.6%      92.00 ± 26%  interrupts.CPU44.PMI:Performance_monitoring_interrupts
     73.33 ±124%     -97.3%       2.00 ± 50%  interrupts.CPU44.RES:Rescheduling_interrupts
    229440 ± 41%    -100.0%       1.50 ±100%  interrupts.CPU44.TLB:TLB_shootdowns
    239600 ± 62%    -100.0%      52.50 ±  2%  interrupts.CPU45.CAL:Function_call_interrupts
      2233 ± 41%     -95.4%     103.50 ±  8%  interrupts.CPU45.NMI:Non-maskable_interrupts
      2233 ± 41%     -95.4%     103.50 ±  8%  interrupts.CPU45.PMI:Performance_monitoring_interrupts
    259462 ± 62%    -100.0%       9.00 ±100%  interrupts.CPU45.TLB:TLB_shootdowns
    142832 ± 79%    -100.0%      52.50 ±  2%  interrupts.CPU46.CAL:Function_call_interrupts
     88.33 ±104%     -99.4%       0.50 ±100%  interrupts.CPU46.RES:Rescheduling_interrupts
    153950 ± 79%    -100.0%       1.50 ±100%  interrupts.CPU46.TLB:TLB_shootdowns
    223934 ± 51%    -100.0%      51.50 ±  4%  interrupts.CPU47.CAL:Function_call_interrupts
      1107 ±  6%     -89.8%     112.50 ±  4%  interrupts.CPU47.NMI:Non-maskable_interrupts
      1107 ±  6%     -89.8%     112.50 ±  4%  interrupts.CPU47.PMI:Performance_monitoring_interrupts
     59.67 ± 92%     -98.3%       1.00 ±100%  interrupts.CPU47.RES:Rescheduling_interrupts
    242184 ± 51%    -100.0%       1.00 ±100%  interrupts.CPU47.TLB:TLB_shootdowns
      1904 ±  6%     -17.4%       1573 ±  8%  interrupts.CPU48.NMI:Non-maskable_interrupts
      1904 ±  6%     -17.4%       1573 ±  8%  interrupts.CPU48.PMI:Performance_monitoring_interrupts
     54.33 ± 72%     -96.3%       2.00 ±100%  interrupts.CPU48.RES:Rescheduling_interrupts
    615.67 ± 10%     -91.4%      53.00 ± 35%  interrupts.CPU49.NMI:Non-maskable_interrupts
    615.67 ± 10%     -91.4%      53.00 ± 35%  interrupts.CPU49.PMI:Performance_monitoring_interrupts
    801.33 ± 67%     -82.0%     144.00 ± 13%  interrupts.CPU50.NMI:Non-maskable_interrupts
    801.33 ± 67%     -82.0%     144.00 ± 13%  interrupts.CPU50.PMI:Performance_monitoring_interrupts
     45295 ± 20%     -99.4%     271.50 ± 81%  interrupts.CPU51.CAL:Function_call_interrupts
    211.33 ± 77%     -63.3%      77.50 ±  8%  interrupts.CPU51.NMI:Non-maskable_interrupts
    211.33 ± 77%     -63.3%      77.50 ±  8%  interrupts.CPU51.PMI:Performance_monitoring_interrupts
     48928 ± 18%     -99.5%     220.50 ±100%  interrupts.CPU51.TLB:TLB_shootdowns
     47166 ± 20%     -99.9%      54.50 ± 10%  interrupts.CPU52.CAL:Function_call_interrupts
     50380 ± 20%    -100.0%       3.50 ±100%  interrupts.CPU52.TLB:TLB_shootdowns
     35411 ± 35%     -99.8%      61.50 ±  5%  interrupts.CPU54.CAL:Function_call_interrupts
     38542 ± 36%    -100.0%       1.50 ±100%  interrupts.CPU54.TLB:TLB_shootdowns
     18108 ± 37%     -97.4%     469.00 ± 67%  interrupts.CPU55.CAL:Function_call_interrupts
    423.00 ± 61%     -72.9%     114.50 ± 14%  interrupts.CPU55.NMI:Non-maskable_interrupts
    423.00 ± 61%     -72.9%     114.50 ± 14%  interrupts.CPU55.PMI:Performance_monitoring_interrupts
     19986 ± 36%     -98.2%     367.50 ±100%  interrupts.CPU55.TLB:TLB_shootdowns
     95159 ± 59%     -99.9%      69.00 ± 21%  interrupts.CPU56.CAL:Function_call_interrupts
    106645 ± 60%    -100.0%       1.00 ±100%  interrupts.CPU56.TLB:TLB_shootdowns
     30072 ± 48%     -99.3%     215.00 ± 73%  interrupts.CPU57.CAL:Function_call_interrupts
    393.33 ± 98%     -83.0%      67.00 ± 44%  interrupts.CPU57.NMI:Non-maskable_interrupts
    393.33 ± 98%     -83.0%      67.00 ± 44%  interrupts.CPU57.PMI:Performance_monitoring_interrupts
     32538 ± 49%     -99.6%     132.00 ± 97%  interrupts.CPU57.TLB:TLB_shootdowns
     88184 ± 34%     -84.5%      13690 ± 97%  interrupts.CPU58.CAL:Function_call_interrupts
     66.33 ±125%     -97.7%       1.50 ± 33%  interrupts.CPU58.RES:Rescheduling_interrupts
     96406 ± 34%     -85.7%      13817 ± 98%  interrupts.CPU58.TLB:TLB_shootdowns
    150.67 ± 23%     -56.2%      66.00        interrupts.CPU61.NMI:Non-maskable_interrupts
    150.67 ± 23%     -56.2%      66.00        interrupts.CPU61.PMI:Performance_monitoring_interrupts
     59359 ± 14%    +626.9%     431469 ±  6%  interrupts.CPU62.CAL:Function_call_interrupts
    366.33 ± 70%    +522.2%       2279 ± 26%  interrupts.CPU62.NMI:Non-maskable_interrupts
    366.33 ± 70%    +522.2%       2279 ± 26%  interrupts.CPU62.PMI:Performance_monitoring_interrupts
     64879 ± 14%    +602.7%     455931 ±  6%  interrupts.CPU62.TLB:TLB_shootdowns
    151.00 ± 11%     -37.7%      94.00 ±  5%  interrupts.CPU64.NMI:Non-maskable_interrupts
    151.00 ± 11%     -37.7%      94.00 ±  5%  interrupts.CPU64.PMI:Performance_monitoring_interrupts
     13947 ± 64%     -98.9%     147.50 ± 65%  interrupts.CPU66.CAL:Function_call_interrupts
     15318 ± 63%     -99.3%     114.00 ±100%  interrupts.CPU66.TLB:TLB_shootdowns
    786.33 ±112%     -88.7%      89.00 ± 26%  interrupts.CPU67.NMI:Non-maskable_interrupts
    786.33 ±112%     -88.7%      89.00 ± 26%  interrupts.CPU67.PMI:Performance_monitoring_interrupts
     79917 ± 80%     -99.9%      52.50 ±  6%  interrupts.CPU68.CAL:Function_call_interrupts
    212.67 ± 62%     -59.1%      87.00 ± 22%  interrupts.CPU68.NMI:Non-maskable_interrupts
    212.67 ± 62%     -59.1%      87.00 ± 22%  interrupts.CPU68.PMI:Performance_monitoring_interrupts
     53982 ± 65%     -99.9%      58.50 ±  2%  interrupts.CPU69.CAL:Function_call_interrupts
    327.33 ± 41%     -83.7%      53.50 ± 32%  interrupts.CPU69.NMI:Non-maskable_interrupts
    327.33 ± 41%     -83.7%      53.50 ± 32%  interrupts.CPU69.PMI:Performance_monitoring_interrupts
     58974 ± 63%    -100.0%       1.50 ±100%  interrupts.CPU69.TLB:TLB_shootdowns
     27087 ± 30%     -96.1%       1051 ± 83%  interrupts.CPU7.CAL:Function_call_interrupts
    433.67 ± 33%     -71.6%     123.00 ± 21%  interrupts.CPU7.NMI:Non-maskable_interrupts
    433.67 ± 33%     -71.6%     123.00 ± 21%  interrupts.CPU7.PMI:Performance_monitoring_interrupts
     29611 ± 30%     -97.5%     750.00 ±100%  interrupts.CPU7.TLB:TLB_shootdowns
     30032 ± 57%     -99.6%     128.00 ± 57%  interrupts.CPU71.CAL:Function_call_interrupts
     32874 ± 57%     -99.8%      77.50 ± 96%  interrupts.CPU71.TLB:TLB_shootdowns
    225415 ± 25%    -100.0%      67.50 ± 14%  interrupts.CPU72.CAL:Function_call_interrupts
    735.33 ± 34%    +135.9%       1734 ± 23%  interrupts.CPU72.NMI:Non-maskable_interrupts
    735.33 ± 34%    +135.9%       1734 ± 23%  interrupts.CPU72.PMI:Performance_monitoring_interrupts
    243030 ± 25%    -100.0%       0.50 ±100%  interrupts.CPU72.TLB:TLB_shootdowns
    267730 ± 75%     -99.3%       1820 ± 97%  interrupts.CPU75.CAL:Function_call_interrupts
    290980 ± 76%     -99.4%       1770 ±100%  interrupts.CPU75.TLB:TLB_shootdowns
    265672 ± 44%     -90.3%      25882 ± 99%  interrupts.CPU76.CAL:Function_call_interrupts
    971.33 ± 37%     -86.8%     128.50 ± 22%  interrupts.CPU76.NMI:Non-maskable_interrupts
    971.33 ± 37%     -86.8%     128.50 ± 22%  interrupts.CPU76.PMI:Performance_monitoring_interrupts
    288037 ± 44%     -90.5%      27254 ±100%  interrupts.CPU76.TLB:TLB_shootdowns
    259900 ± 63%    -100.0%      64.50 ± 13%  interrupts.CPU77.CAL:Function_call_interrupts
      2126 ± 52%     -95.6%      92.50 ± 21%  interrupts.CPU77.NMI:Non-maskable_interrupts
      2126 ± 52%     -95.6%      92.50 ± 21%  interrupts.CPU77.PMI:Performance_monitoring_interrupts
    280644 ± 63%    -100.0%       1.50 ±100%  interrupts.CPU77.TLB:TLB_shootdowns
    233432 ± 31%    -100.0%      54.00 ±  9%  interrupts.CPU78.CAL:Function_call_interrupts
      2428 ± 50%     -97.0%      73.50 ± 53%  interrupts.CPU78.NMI:Non-maskable_interrupts
      2428 ± 50%     -97.0%      73.50 ± 53%  interrupts.CPU78.PMI:Performance_monitoring_interrupts
    226.00 ±110%     -98.5%       3.50 ± 14%  interrupts.CPU78.RES:Rescheduling_interrupts
    253071 ± 32%    -100.0%       0.50 ±100%  interrupts.CPU78.TLB:TLB_shootdowns
    252321 ± 17%     -99.9%     311.50 ± 62%  interrupts.CPU79.CAL:Function_call_interrupts
      1040 ±  7%     -85.9%     147.00 ± 12%  interrupts.CPU79.NMI:Non-maskable_interrupts
      1040 ±  7%     -85.9%     147.00 ± 12%  interrupts.CPU79.PMI:Performance_monitoring_interrupts
    211.00 ±111%     -94.3%      12.00 ± 83%  interrupts.CPU79.RES:Rescheduling_interrupts
    274447 ± 16%     -99.9%     232.50 ± 98%  interrupts.CPU79.TLB:TLB_shootdowns
    109041 ± 28%     -94.2%       6313 ± 98%  interrupts.CPU8.CAL:Function_call_interrupts
    122228 ± 32%     -94.6%       6592 ± 99%  interrupts.CPU8.TLB:TLB_shootdowns
    261240 ± 44%    -100.0%      53.00 ±  7%  interrupts.CPU80.CAL:Function_call_interrupts
      1136 ± 39%     -94.9%      57.50 ± 42%  interrupts.CPU80.NMI:Non-maskable_interrupts
      1136 ± 39%     -94.9%      57.50 ± 42%  interrupts.CPU80.PMI:Performance_monitoring_interrupts
    317.67 ±125%     -99.7%       1.00 ±100%  interrupts.CPU80.RES:Rescheduling_interrupts
    281152 ± 43%    -100.0%       2.00 ±100%  interrupts.CPU80.TLB:TLB_shootdowns
    273.00 ±130%     -96.5%       9.50 ± 78%  interrupts.CPU81.RES:Rescheduling_interrupts
    190306 ± 52%     -99.9%     106.50 ± 48%  interrupts.CPU82.CAL:Function_call_interrupts
      1698 ± 92%     -94.6%      91.50 ± 23%  interrupts.CPU82.NMI:Non-maskable_interrupts
      1698 ± 92%     -94.6%      91.50 ± 23%  interrupts.CPU82.PMI:Performance_monitoring_interrupts
     58.67 ± 95%     -81.2%      11.00 ±  9%  interrupts.CPU82.RES:Rescheduling_interrupts
    206202 ± 52%    -100.0%       1.50 ±100%  interrupts.CPU82.TLB:TLB_shootdowns
    318334 ± 17%    -100.0%      55.00 ±  7%  interrupts.CPU83.CAL:Function_call_interrupts
      1359 ± 53%     -90.9%     124.00 ± 15%  interrupts.CPU83.NMI:Non-maskable_interrupts
      1359 ± 53%     -90.9%     124.00 ± 15%  interrupts.CPU83.PMI:Performance_monitoring_interrupts
    151.00 ±112%     -96.7%       5.00 ± 60%  interrupts.CPU83.RES:Rescheduling_interrupts
    344952 ± 18%    -100.0%       1.50 ± 33%  interrupts.CPU83.TLB:TLB_shootdowns
      1052 ± 31%     -91.3%      91.50 ± 23%  interrupts.CPU84.NMI:Non-maskable_interrupts
      1052 ± 31%     -91.3%      91.50 ± 23%  interrupts.CPU84.PMI:Performance_monitoring_interrupts
     63.33 ± 76%     -92.9%       4.50 ± 55%  interrupts.CPU84.RES:Rescheduling_interrupts
    259296 ± 45%    -100.0%      70.00 ±  5%  interrupts.CPU85.CAL:Function_call_interrupts
    132.67 ± 76%     -98.1%       2.50 ± 60%  interrupts.CPU85.RES:Rescheduling_interrupts
    281595 ± 46%    -100.0%       1.00 ±100%  interrupts.CPU85.TLB:TLB_shootdowns
    303.33 ±105%     -98.7%       4.00 ±100%  interrupts.CPU86.RES:Rescheduling_interrupts
    173576 ± 25%     -68.9%      53961 ± 93%  interrupts.CPU87.CAL:Function_call_interrupts
      1120 ± 31%     -94.0%      67.00 ± 49%  interrupts.CPU87.NMI:Non-maskable_interrupts
      1120 ± 31%     -94.0%      67.00 ± 49%  interrupts.CPU87.PMI:Performance_monitoring_interrupts
    188725 ± 27%     -69.8%      57018 ± 93%  interrupts.CPU87.TLB:TLB_shootdowns
    197104 ± 41%    -100.0%      52.00 ±  3%  interrupts.CPU88.CAL:Function_call_interrupts
     60.67 ± 92%     -96.7%       2.00        interrupts.CPU88.RES:Rescheduling_interrupts
    214605 ± 42%    -100.0%       2.00 ± 50%  interrupts.CPU88.TLB:TLB_shootdowns
    229259 ± 46%    -100.0%      58.00 ± 12%  interrupts.CPU89.CAL:Function_call_interrupts
      1911 ± 39%     -95.3%      90.50 ± 18%  interrupts.CPU89.NMI:Non-maskable_interrupts
      1911 ± 39%     -95.3%      90.50 ± 18%  interrupts.CPU89.PMI:Performance_monitoring_interrupts
     53.67 ± 95%     -99.1%       0.50 ±100%  interrupts.CPU89.RES:Rescheduling_interrupts
    250104 ± 46%    -100.0%       1.50 ± 33%  interrupts.CPU89.TLB:TLB_shootdowns
     40214 ± 37%     -99.1%     354.00 ± 84%  interrupts.CPU9.CAL:Function_call_interrupts
    387.33 ±112%     -87.5%      48.50 ± 29%  interrupts.CPU9.NMI:Non-maskable_interrupts
    387.33 ±112%     -87.5%      48.50 ± 29%  interrupts.CPU9.PMI:Performance_monitoring_interrupts
    114.33 ±119%     -98.3%       2.00 ±100%  interrupts.CPU9.RES:Rescheduling_interrupts
     43311 ± 38%     -99.6%     169.50 ± 98%  interrupts.CPU9.TLB:TLB_shootdowns
     86000 ± 41%     -99.9%      54.00        interrupts.CPU90.CAL:Function_call_interrupts
      1558 ± 38%     -94.6%      83.50 ± 13%  interrupts.CPU90.NMI:Non-maskable_interrupts
      1558 ± 38%     -94.6%      83.50 ± 13%  interrupts.CPU90.PMI:Performance_monitoring_interrupts
     91513 ± 40%    -100.0%       2.00 ± 50%  interrupts.CPU90.TLB:TLB_shootdowns
    107289 ± 56%     -99.9%      56.00 ± 10%  interrupts.CPU91.CAL:Function_call_interrupts
    695.00 ± 46%     -79.9%     140.00 ± 30%  interrupts.CPU91.NMI:Non-maskable_interrupts
    695.00 ± 46%     -79.9%     140.00 ± 30%  interrupts.CPU91.PMI:Performance_monitoring_interrupts
    116833 ± 56%    -100.0%       2.00 ± 50%  interrupts.CPU91.TLB:TLB_shootdowns
    174141 ± 53%    -100.0%      53.00 ±  5%  interrupts.CPU92.CAL:Function_call_interrupts
    520.33 ± 35%     -82.3%      92.00 ± 10%  interrupts.CPU92.NMI:Non-maskable_interrupts
    520.33 ± 35%     -82.3%      92.00 ± 10%  interrupts.CPU92.PMI:Performance_monitoring_interrupts
    189666 ± 54%    -100.0%       2.50 ± 60%  interrupts.CPU92.TLB:TLB_shootdowns
    110083 ± 63%     -98.3%       1857 ± 96%  interrupts.CPU93.CAL:Function_call_interrupts
      1136 ± 56%     -93.5%      73.50 ±  7%  interrupts.CPU93.NMI:Non-maskable_interrupts
      1136 ± 56%     -93.5%      73.50 ±  7%  interrupts.CPU93.PMI:Performance_monitoring_interrupts
    118874 ± 62%     -98.5%       1797 ± 99%  interrupts.CPU93.TLB:TLB_shootdowns
     58617 ± 40%     -96.9%       1813 ± 96%  interrupts.CPU94.CAL:Function_call_interrupts
     63251 ± 40%     -97.2%       1756 ± 99%  interrupts.CPU94.TLB:TLB_shootdowns
      1872 ± 27%     -95.7%      80.00        interrupts.CPU95.NMI:Non-maskable_interrupts
      1872 ± 27%     -95.7%      80.00        interrupts.CPU95.PMI:Performance_monitoring_interrupts
     83.00 ±103%     -86.1%      11.50 ± 56%  interrupts.CPU95.RES:Rescheduling_interrupts
      7935 ± 72%     -82.2%       1414 ± 10%  interrupts.RES:Rescheduling_interrupts



***************************************************************************************************
lkp-csl-2ap1: 192 threads Intel(R) Xeon(R) CPU @ 2.20GHz with 192G memory
=========================================================================================
compiler/cpufreq_governor/kconfig/nr_ssd/nr_task/rootfs/runtime/tbox_group/test/testcase/thp_defrag/thp_enabled/ucode:
  gcc-9/performance/x86_64-rhel-8.3/1/32/debian-10.4-x86_64-20200603.cgz/300/lkp-csl-2ap1/swap-w-rand-mt/vm-scalability/always/always/0x4003003

commit: 
  3852f6768e ("mm/swapcache: support to handle the shadow entries")
  aae466b005 ("mm/swap: implement workingset detection for anonymous LRU")

3852f6768ede542e aae466b0052e1888edd1d7f473d 
---------------- --------------------------- 
       fail:runs  %reproduction    fail:runs
           |             |             |    
           :2           50%           1:4     dmesg.BUG:kernel_NULL_pointer_dereference,address
           :2           50%           1:4     dmesg.Kernel_panic-not_syncing:Fatal_exception
           :2           50%           1:4     dmesg.Oops:#[##]
           :2           50%           1:4     dmesg.RIP:kobject_del
           :2           50%           1:4     dmesg.RIP:native_smp_send_reschedule
           :2           50%           1:4     dmesg.WARNING:at_arch/x86/kernel/apic/ipi.c:#native_smp_send_reschedule
          0:2           64%           1:4     perf-profile.children.cycles-pp.error_entry
          0:2           16%           0:4     perf-profile.self.cycles-pp.error_entry
         %stddev     %change         %stddev
             \          |                \  
      1.08 ±  5%     +92.8%       2.08 ± 14%  vm-scalability.free_time
      6536            -1.3%       6450        vm-scalability.median
    320.31            +5.2%     337.04        vm-scalability.time.elapsed_time
    320.31            +5.2%     337.04        vm-scalability.time.elapsed_time.max
     86351 ± 12%     -35.3%      55851 ± 25%  vm-scalability.time.involuntary_context_switches
    873.12 ±  4%     -22.2%     679.71 ± 15%  vm-scalability.time.system_time
      3.09            -8.9%       2.81 ±  5%  iostat.cpu.system
  36054075           -46.3%   19366911 ±  6%  cpuidle.POLL.time
   8107090           -45.8%    4394214 ±  7%  cpuidle.POLL.usage
      0.13            -0.0        0.11 ± 10%  mpstat.cpu.all.soft%
      1.76 ±  4%      -0.4        1.39 ± 16%  mpstat.cpu.all.sys%
   3989891 ± 35%    +199.8%   11962962 ±  8%  numa-numastat.node0.local_node
   4021317 ± 34%    +197.8%   11974410 ±  8%  numa-numastat.node0.numa_hit
  11809980 ± 38%     -62.8%    4394489 ± 83%  numa-numastat.node3.local_node
  11835379 ± 38%     -62.7%    4417959 ± 83%  numa-numastat.node3.numa_hit
   1044721           -14.8%     890319 ±  6%  vmstat.io.bo
   1117642           +37.0%    1530674        vmstat.memory.cache
  11365041           +45.4%   16527872 ±  8%  vmstat.memory.free
 1.641e+08           -14.5%  1.403e+08 ±  5%  vmstat.memory.swpd
   1044714           -14.8%     890313 ±  6%  vmstat.swap.so
      1749 ±  5%     -28.7%       1246 ±  6%  perf-stat.i.cpu-migrations
      0.06            +0.1        0.13 ± 15%  perf-stat.i.dTLB-load-miss-rate%
   1136787           +80.8%    2055617 ± 14%  perf-stat.i.dTLB-load-misses
   6103425            -5.0%    5795625 ±  5%  perf-stat.i.iTLB-loads
      0.37            -6.6%       0.35 ±  5%  perf-stat.i.ipc
      1.20            -6.6%       1.12 ±  3%  perf-stat.i.metric.K/sec
   7855002           -16.6%    6547298 ± 16%  perf-stat.i.node-load-misses
      0.05 ±  3%      +0.1        0.10 ± 19%  perf-stat.overall.dTLB-load-miss-rate%
      1751 ±  5%     -28.9%       1245 ±  6%  perf-stat.ps.cpu-migrations
   1129808           +81.1%    2046346 ± 14%  perf-stat.ps.dTLB-load-misses
   6074224            -5.0%    5773002 ±  5%  perf-stat.ps.iTLB-loads
   7853233           -16.8%    6531571 ± 16%  perf-stat.ps.node-load-misses
  74363186 ±  7%     -44.9%   40944206 ±  5%  meminfo.Active
  74362739 ±  7%     -44.9%   40943748 ±  5%  meminfo.Active(anon)
     13818 ±  8%     +67.4%      23128 ± 25%  meminfo.CmaFree
 1.088e+08 ±  4%     +25.7%  1.368e+08        meminfo.Inactive
 1.088e+08 ±  4%     +25.7%  1.368e+08        meminfo.Inactive(anon)
    137327          +296.6%     544704 ±  5%  meminfo.KReclaimable
  10247553 ±  4%     +51.5%   15527799 ±  9%  meminfo.MemAvailable
  10886951 ±  3%     +46.7%   15976591 ±  9%  meminfo.MemFree
    137327          +296.6%     544704 ±  5%  meminfo.SReclaimable
     11874           +54.2%      18312 ± 14%  meminfo.Shmem
    452079           +89.7%     857727 ±  3%  meminfo.Slab
    135711 ±  6%    +108.7%     283289 ± 41%  meminfo.SwapCached
      4123 ± 20%     -51.3%       2007 ± 29%  meminfo.Writeback
     34270 ±  5%      -9.5%      31010 ±  3%  slabinfo.dmaengine-unmap-16.active_objs
    824.00 ±  5%      -9.4%     746.25 ±  3%  slabinfo.dmaengine-unmap-16.active_slabs
     34644 ±  5%      -9.5%      31355 ±  3%  slabinfo.dmaengine-unmap-16.num_objs
    824.00 ±  5%      -9.4%     746.25 ±  3%  slabinfo.dmaengine-unmap-16.num_slabs
    815.00           +32.9%       1082 ±  3%  slabinfo.mnt_cache.active_objs
    815.00           +32.9%       1082 ±  3%  slabinfo.mnt_cache.num_objs
     15050 ±  2%     -10.3%      13502 ±  4%  slabinfo.proc_inode_cache.num_objs
     89702          +771.6%     781844 ±  5%  slabinfo.radix_tree_node.active_objs
      1619          +799.4%      14566 ±  5%  slabinfo.radix_tree_node.active_slabs
     90726          +799.2%     815771 ±  5%  slabinfo.radix_tree_node.num_objs
      1619          +799.4%      14566 ±  5%  slabinfo.radix_tree_node.num_slabs
      7382 ±  2%     +19.8%       8844 ±  5%  slabinfo.shmem_inode_cache.active_objs
      7382 ±  2%     +19.8%       8844 ±  5%  slabinfo.shmem_inode_cache.num_objs
    108.44 ±  5%     -61.6%      41.65 ± 24%  sched_debug.cfs_rq:/.exec_clock.min
     95883 ±  3%     -22.1%      74741 ± 15%  sched_debug.cfs_rq:/.min_vruntime.avg
      6602 ± 59%   +1084.4%      78195 ± 34%  sched_debug.cfs_rq:/.spread0.max
   1562922 ± 16%     -12.8%    1362192 ± 12%  sched_debug.cpu.avg_idle.max
      0.00 ±  5%      -9.0%       0.00 ±  3%  sched_debug.cpu.next_balance.stddev
      3953 ± 34%     -53.7%       1828 ±  8%  sched_debug.cpu.nr_switches.min
    109192 ±  6%     +34.2%     146571 ± 11%  sched_debug.cpu.nr_switches.stddev
     15.54 ±  3%     -10.5%      13.90 ±  4%  sched_debug.cpu.nr_uninterruptible.stddev
      2843 ± 45%     -72.3%     787.31 ± 16%  sched_debug.cpu.sched_count.min
    109111 ±  6%     +34.2%     146397 ± 11%  sched_debug.cpu.sched_count.stddev
      1289 ± 49%     -76.3%     305.32 ± 19%  sched_debug.cpu.sched_goidle.min
     52858 ±  7%     +36.6%      72229 ± 11%  sched_debug.cpu.sched_goidle.stddev
    322.33 ±  5%     -19.7%     258.99 ± 14%  sched_debug.cpu.ttwu_count.min
    271.42           -15.5%     229.38 ± 10%  sched_debug.cpu.ttwu_local.min
     55848 ±  6%     +31.3%      73313 ± 11%  sched_debug.cpu.ttwu_local.stddev
     38086           +16.9%      44526 ±  7%  softirqs.CPU1.SCHED
    364.50 ± 44%   +2507.6%       9504 ± 93%  softirqs.CPU10.NET_RX
     68420           -31.7%      46741 ± 33%  softirqs.CPU152.RCU
     66729 ±  9%     -28.6%      47676 ± 35%  softirqs.CPU158.RCU
     71681 ± 11%     -35.7%      46123 ± 35%  softirqs.CPU160.RCU
     69240 ±  9%     -31.6%      47350 ± 35%  softirqs.CPU161.RCU
     72321 ±  8%     -34.1%      47673 ± 35%  softirqs.CPU162.RCU
     66391 ± 14%     -28.5%      47457 ± 36%  softirqs.CPU165.RCU
     63766 ± 13%     -25.6%      47441 ± 35%  softirqs.CPU166.RCU
     67404 ± 12%     -32.1%      45782 ± 37%  softirqs.CPU169.RCU
     69859 ± 13%     -34.5%      45756 ± 35%  softirqs.CPU170.RCU
     67546 ±  9%     -31.2%      46484 ± 36%  softirqs.CPU171.RCU
     68951 ±  9%     -32.4%      46621 ± 37%  softirqs.CPU173.RCU
     67616 ±  7%     -31.7%      46173 ± 37%  softirqs.CPU174.RCU
     39793           +10.8%      44074 ±  2%  softirqs.CPU176.SCHED
     67016 ± 19%     -27.9%      48329 ± 38%  softirqs.CPU177.RCU
     67339 ± 15%     -28.7%      48008 ± 36%  softirqs.CPU180.RCU
     68397 ± 11%     -29.7%      48092 ± 37%  softirqs.CPU181.RCU
     70026 ± 10%     -30.9%      48411 ± 38%  softirqs.CPU182.RCU
     70803 ±  2%     -34.3%      46509 ± 35%  softirqs.CPU186.RCU
     39877           +10.7%      44144 ±  2%  softirqs.CPU188.SCHED
     36241 ±  4%     +17.8%      42697        softirqs.CPU24.SCHED
     40263           -23.0%      30987 ± 11%  softirqs.CPU38.SCHED
     36666 ±  6%     +19.6%      43839 ±  2%  softirqs.CPU56.SCHED
     36812           +17.3%      43176 ±  3%  softirqs.CPU75.SCHED
      4239 ± 12%    +367.7%      19827 ± 52%  softirqs.NET_RX
    115809 ± 48%   +2278.9%    2754993 ± 26%  proc-vmstat.compact_daemon_migrate_scanned
     11776           -50.7%       5808 ± 22%  proc-vmstat.compact_success
  18598991 ±  7%     -44.9%   10248481 ±  4%  proc-vmstat.nr_active_anon
  45770728            -3.0%   44393376        proc-vmstat.nr_anon_pages
     85912            -8.6%      78555 ±  2%  proc-vmstat.nr_anon_transparent_hugepages
    253989           +49.2%     378960 ±  8%  proc-vmstat.nr_dirty_background_threshold
    508600           +49.2%     758848 ±  8%  proc-vmstat.nr_dirty_threshold
    279185           +13.8%     317589 ±  9%  proc-vmstat.nr_file_pages
      3457 ±  6%     +66.9%       5770 ± 25%  proc-vmstat.nr_free_cma
   2713646           +46.1%    3964193 ±  8%  proc-vmstat.nr_free_pages
  27207952 ±  4%     +25.8%   34220425        proc-vmstat.nr_inactive_anon
     90.50 ± 38%     -42.3%      52.25 ± 71%  proc-vmstat.nr_inactive_file
      3204 ± 10%     -17.1%       2656 ±  9%  proc-vmstat.nr_isolated_anon
      2957           +54.4%       4564 ± 15%  proc-vmstat.nr_shmem
     34261          +297.3%     136110 ±  4%  proc-vmstat.nr_slab_reclaimable
    724.50           -35.8%     465.00 ± 29%  proc-vmstat.nr_writeback
  18599012 ±  7%     -44.9%   10248642 ±  4%  proc-vmstat.nr_zone_active_anon
  27208816 ±  4%     +25.8%   34221203        proc-vmstat.nr_zone_inactive_anon
     90.50 ± 38%     -42.8%      51.75 ± 72%  proc-vmstat.nr_zone_inactive_file
    703.00           -35.7%     452.00 ± 30%  proc-vmstat.nr_zone_write_pending
 3.385e+08           -10.2%  3.038e+08 ±  7%  proc-vmstat.pgpgout
  83774568           -10.9%   74674345 ±  7%  proc-vmstat.pgrotated
 2.043e+08 ±  8%     -26.8%  1.496e+08 ± 12%  proc-vmstat.pgscan_direct
  84560845           -10.4%   75806985 ±  7%  proc-vmstat.pgsteal_anon
  44538776           -22.5%   34526377 ±  3%  proc-vmstat.pgsteal_direct
  84619799           -10.2%   75956512 ±  7%  proc-vmstat.pswpout
    121047 ±  8%     -26.4%      89044 ± 22%  proc-vmstat.slabs_scanned
    615.00 ±  6%     +96.7%       1209 ± 37%  proc-vmstat.swap_ra_hit
    207587           -10.2%     186311 ±  3%  proc-vmstat.thp_fault_alloc
  19001220 ±  6%     -48.3%    9815424 ± 12%  numa-meminfo.node0.Active
  19001053 ±  6%     -48.3%    9815137 ± 12%  numa-meminfo.node0.Active(anon)
  26175277 ±  5%     +29.9%   34004831 ±  4%  numa-meminfo.node0.Inactive
  26175253 ±  5%     +29.9%   34004819 ±  4%  numa-meminfo.node0.Inactive(anon)
     43040 ±  4%    +230.6%     142276 ± 17%  numa-meminfo.node0.KReclaimable
      9504 ±  3%     -18.3%       7765 ±  5%  numa-meminfo.node0.KernelStack
      5901           +23.0%       7256 ± 20%  numa-meminfo.node0.Mapped
   2684201 ±  7%     +53.8%    4128329 ±  6%  numa-meminfo.node0.MemFree
    206184 ±  4%     -27.7%     149049 ± 14%  numa-meminfo.node0.PageTables
     43040 ±  4%    +230.6%     142276 ± 17%  numa-meminfo.node0.SReclaimable
    110348 ±  2%     -18.6%      89858 ±  3%  numa-meminfo.node0.SUnreclaim
      5091 ± 10%     -64.8%       1790 ±116%  numa-meminfo.node0.Shmem
    153389           +51.3%     232135 ± 10%  numa-meminfo.node0.Slab
  18726155 ±  7%     -48.6%    9622670 ± 17%  numa-meminfo.node1.Active
  18725898 ±  7%     -48.6%    9622633 ± 17%  numa-meminfo.node1.Active(anon)
  27336363 ±  4%     +29.3%   35337382 ±  5%  numa-meminfo.node1.Inactive
  27336247 ±  4%     +29.3%   35337252 ±  5%  numa-meminfo.node1.Inactive(anon)
     30936 ±  9%    +410.8%     158013 ± 23%  numa-meminfo.node1.KReclaimable
     30936 ±  9%    +410.8%     158013 ± 23%  numa-meminfo.node1.SReclaimable
    102012 ±  4%    +124.8%     229332 ± 16%  numa-meminfo.node1.Slab
  18780713 ±  8%     -41.5%   10981759 ± 24%  numa-meminfo.node2.Active
  18780699 ±  8%     -41.5%   10981704 ± 24%  numa-meminfo.node2.Active(anon)
    260006           +18.5%     308084 ± 11%  numa-meminfo.node2.FilePages
  27126472 ±  5%     +23.7%   33567811 ±  6%  numa-meminfo.node2.Inactive
  27126417 ±  5%     +23.7%   33567753 ±  6%  numa-meminfo.node2.Inactive(anon)
     31525 ±  5%    +347.0%     140930 ± 22%  numa-meminfo.node2.KReclaimable
   2856577 ±  3%     +43.3%    4094648 ±  9%  numa-meminfo.node2.MemFree
     31525 ±  5%    +347.0%     140930 ± 22%  numa-meminfo.node2.SReclaimable
     94052 ±  2%    +124.9%     211533 ± 13%  numa-meminfo.node2.Slab
      1071 ±  2%     -48.8%     548.25 ± 65%  numa-meminfo.node2.Writeback
  17886451 ±  8%     -41.1%   10536003 ± 19%  numa-meminfo.node3.Active
  17886443 ±  8%     -41.1%   10535924 ± 19%  numa-meminfo.node3.Active(anon)
  28171067 ±  4%     +20.1%   33819890 ±  6%  numa-meminfo.node3.Inactive
  28170898 ±  4%     +20.1%   33819879 ±  6%  numa-meminfo.node3.Inactive(anon)
     31804          +225.7%     103572 ± 21%  numa-meminfo.node3.KReclaimable
     10075 ±  6%     -28.9%       7162 ± 25%  numa-meminfo.node3.Mapped
   2651367 ±  9%     +58.4%    4199157 ± 15%  numa-meminfo.node3.MemFree
     31804          +225.7%     103572 ± 21%  numa-meminfo.node3.SReclaimable
    102638           +80.1%     184817 ±  8%  numa-meminfo.node3.Slab
      1103 ±  2%     -62.4%     415.25 ± 50%  numa-meminfo.node3.Writeback
   4750797 ±  6%     -48.4%    2453627 ± 12%  numa-vmstat.node0.nr_active_anon
    675471 ±  5%     +52.6%    1030659 ±  7%  numa-vmstat.node0.nr_free_pages
   6538855 ±  5%     +30.0%    8502807 ±  4%  numa-vmstat.node0.nr_inactive_anon
      9503 ±  3%     -18.2%       7771 ±  5%  numa-vmstat.node0.nr_kernel_stack
     51494 ±  4%     -27.6%      37274 ± 14%  numa-vmstat.node0.nr_page_table_pages
      1272 ± 11%     -64.8%     448.00 ±116%  numa-vmstat.node0.nr_shmem
     10750 ±  4%    +230.9%      35572 ± 17%  numa-vmstat.node0.nr_slab_reclaimable
     27587 ±  2%     -18.6%      22460 ±  3%  numa-vmstat.node0.nr_slab_unreclaimable
   1543166 ± 20%    +183.1%    4368165 ± 11%  numa-vmstat.node0.nr_vmscan_write
   1542970 ± 20%    +183.1%    4367994 ± 11%  numa-vmstat.node0.nr_written
   4750809 ±  6%     -48.4%    2453693 ± 12%  numa-vmstat.node0.nr_zone_active_anon
   6538943 ±  5%     +30.0%    8502999 ±  4%  numa-vmstat.node0.nr_zone_inactive_anon
    924215 ± 53%    +177.0%    2560038 ± 48%  numa-vmstat.node0.numa_foreign
   2217911 ± 29%    +154.8%    5650919 ±  7%  numa-vmstat.node0.numa_hit
   2155706 ± 31%    +161.5%    5637333 ±  7%  numa-vmstat.node0.numa_local
   4674978 ±  7%     -48.4%    2411058 ± 16%  numa-vmstat.node1.nr_active_anon
     63.50 ± 62%     -85.8%       9.00 ±132%  numa-vmstat.node1.nr_active_file
   6836617 ±  4%     +29.1%    8824282 ±  5%  numa-vmstat.node1.nr_inactive_anon
      7742 ±  9%    +410.4%      39516 ± 23%  numa-vmstat.node1.nr_slab_reclaimable
    250.50 ±  6%     -37.0%     157.75 ± 34%  numa-vmstat.node1.nr_writeback
   4674967 ±  7%     -48.4%    2411093 ± 16%  numa-vmstat.node1.nr_zone_active_anon
     63.50 ± 62%     -85.8%       9.00 ±132%  numa-vmstat.node1.nr_zone_active_file
   6836844 ±  4%     +29.1%    8824484 ±  5%  numa-vmstat.node1.nr_zone_inactive_anon
    244.50 ±  5%     -37.0%     154.00 ± 35%  numa-vmstat.node1.nr_zone_write_pending
    575290 ±  2%     +67.1%     961547 ± 29%  numa-vmstat.node1.numa_foreign
   4700028 ±  8%     -41.6%    2746294 ± 24%  numa-vmstat.node2.nr_active_anon
     65049           +18.2%      76893 ± 11%  numa-vmstat.node2.nr_file_pages
    718878 ±  4%     +42.7%    1025683 ±  8%  numa-vmstat.node2.nr_free_pages
   6772066 ±  5%     +23.9%    8389077 ±  6%  numa-vmstat.node2.nr_inactive_anon
      7859 ±  5%    +348.7%      35266 ± 22%  numa-vmstat.node2.nr_slab_reclaimable
    234.00 ± 10%     -50.6%     115.50 ± 61%  numa-vmstat.node2.nr_writeback
   4700031 ±  8%     -41.6%    2746330 ± 24%  numa-vmstat.node2.nr_zone_active_anon
   6772290 ±  5%     +23.9%    8389269 ±  6%  numa-vmstat.node2.nr_zone_inactive_anon
    226.00 ± 10%     -51.0%     110.75 ± 61%  numa-vmstat.node2.nr_zone_write_pending
   4466820 ±  8%     -41.0%    2635768 ± 19%  numa-vmstat.node3.nr_active_anon
      3487 ±  7%     +66.9%       5820 ± 25%  numa-vmstat.node3.nr_free_cma
    667183 ± 11%     +57.7%    1052209 ± 15%  numa-vmstat.node3.nr_free_pages
   7043232 ±  4%     +20.0%    8450818 ±  6%  numa-vmstat.node3.nr_inactive_anon
      2519 ±  6%     -27.7%       1821 ± 24%  numa-vmstat.node3.nr_mapped
      7951          +225.7%      25892 ± 21%  numa-vmstat.node3.nr_slab_reclaimable
   4244224 ± 37%     -48.6%    2180229 ± 69%  numa-vmstat.node3.nr_vmscan_write
    296.00 ± 17%     -62.2%     111.75 ± 59%  numa-vmstat.node3.nr_writeback
   4243937 ± 37%     -48.6%    2180124 ± 69%  numa-vmstat.node3.nr_written
   4466803 ±  8%     -41.0%    2635791 ± 19%  numa-vmstat.node3.nr_zone_active_anon
   7043545 ±  4%     +20.0%    8450932 ±  6%  numa-vmstat.node3.nr_zone_inactive_anon
    290.50 ± 18%     -62.7%     108.25 ± 60%  numa-vmstat.node3.nr_zone_write_pending
   4851710 ± 38%     -47.5%    2546955 ± 72%  numa-vmstat.node3.numa_hit
   4744738 ± 39%     -48.5%    2442319 ± 76%  numa-vmstat.node3.numa_local
    691.00 ± 47%   +2554.2%      18340 ± 92%  interrupts.31:PCI-MSI.524289-edge.eth0-TxRx-0
    278.50 ± 50%    +165.7%     740.00 ± 48%  interrupts.CPU0.NMI:Non-maskable_interrupts
    278.50 ± 50%    +165.7%     740.00 ± 48%  interrupts.CPU0.PMI:Performance_monitoring_interrupts
    109.00 ± 22%    +597.7%     760.50 ±107%  interrupts.CPU1.NMI:Non-maskable_interrupts
    109.00 ± 22%    +597.7%     760.50 ±107%  interrupts.CPU1.PMI:Performance_monitoring_interrupts
    691.00 ± 47%   +2554.2%      18340 ± 92%  interrupts.CPU10.31:PCI-MSI.524289-edge.eth0-TxRx-0
    143.50 ± 20%    +227.0%     469.25 ± 24%  interrupts.CPU10.NMI:Non-maskable_interrupts
    143.50 ± 20%    +227.0%     469.25 ± 24%  interrupts.CPU10.PMI:Performance_monitoring_interrupts
    107.00 ± 29%     +70.1%     182.00 ± 25%  interrupts.CPU100.NMI:Non-maskable_interrupts
    107.00 ± 29%     +70.1%     182.00 ± 25%  interrupts.CPU100.PMI:Performance_monitoring_interrupts
     76888 ± 54%    +499.7%     461102 ± 57%  interrupts.CPU101.CAL:Function_call_interrupts
     90857 ± 55%    +504.5%     549258 ± 60%  interrupts.CPU101.TLB:TLB_shootdowns
    202.00 ± 50%     -63.0%      74.75 ± 27%  interrupts.CPU102.RES:Rescheduling_interrupts
    287.50 ± 48%     -71.0%      83.25 ± 46%  interrupts.CPU103.RES:Rescheduling_interrupts
    238.00 ± 36%     -51.3%     116.00 ± 52%  interrupts.CPU104.RES:Rescheduling_interrupts
    221.50 ± 25%     -51.2%     108.00 ± 45%  interrupts.CPU105.RES:Rescheduling_interrupts
    151.50 ± 25%    +237.8%     511.75 ± 23%  interrupts.CPU106.NMI:Non-maskable_interrupts
    151.50 ± 25%    +237.8%     511.75 ± 23%  interrupts.CPU106.PMI:Performance_monitoring_interrupts
    277.50 ± 42%     -58.9%     114.00 ± 44%  interrupts.CPU106.RES:Rescheduling_interrupts
    276.50 ± 42%     -58.6%     114.50 ± 30%  interrupts.CPU107.RES:Rescheduling_interrupts
    275.00 ± 28%     -59.2%     112.25 ± 25%  interrupts.CPU108.RES:Rescheduling_interrupts
    290.00 ± 22%     -55.7%     128.50 ± 24%  interrupts.CPU109.RES:Rescheduling_interrupts
    307.50 ± 60%     -74.8%      77.50 ± 13%  interrupts.CPU11.RES:Rescheduling_interrupts
    259.50 ± 17%     -49.0%     132.25 ± 26%  interrupts.CPU110.RES:Rescheduling_interrupts
    282.00 ± 32%     -45.4%     154.00 ± 45%  interrupts.CPU111.RES:Rescheduling_interrupts
     62672 ± 41%    +419.3%     325467 ± 45%  interrupts.CPU112.CAL:Function_call_interrupts
     76545 ± 41%    +394.7%     378647 ± 46%  interrupts.CPU112.TLB:TLB_shootdowns
    218.50 ± 27%    +182.3%     616.75 ± 49%  interrupts.CPU116.NMI:Non-maskable_interrupts
    218.50 ± 27%    +182.3%     616.75 ± 49%  interrupts.CPU116.PMI:Performance_monitoring_interrupts
     66666 ± 26%    +459.0%     372656 ± 70%  interrupts.CPU118.CAL:Function_call_interrupts
     78025 ± 28%    +456.6%     434295 ± 72%  interrupts.CPU118.TLB:TLB_shootdowns
     59429 ± 63%    +297.0%     235937 ± 32%  interrupts.CPU119.CAL:Function_call_interrupts
     68515 ± 64%    +293.8%     269805 ± 34%  interrupts.CPU119.TLB:TLB_shootdowns
    219.50 ± 28%     -48.6%     112.75 ± 41%  interrupts.CPU12.RES:Rescheduling_interrupts
    101.00          +212.1%     315.25 ± 31%  interrupts.CPU124.RES:Rescheduling_interrupts
    110.50 ± 19%    +273.5%     412.75 ± 44%  interrupts.CPU125.RES:Rescheduling_interrupts
     94.50 ±  8%    +256.3%     336.75 ± 84%  interrupts.CPU126.NMI:Non-maskable_interrupts
     94.50 ±  8%    +256.3%     336.75 ± 84%  interrupts.CPU126.PMI:Performance_monitoring_interrupts
    120.00 ± 14%    +271.7%     446.00 ± 30%  interrupts.CPU126.RES:Rescheduling_interrupts
    131.50 ± 23%    +131.2%     304.00 ± 33%  interrupts.CPU127.RES:Rescheduling_interrupts
    133.00 ± 42%    +119.9%     292.50 ± 25%  interrupts.CPU128.RES:Rescheduling_interrupts
    171.50 ± 21%     +62.4%     278.50 ± 24%  interrupts.CPU130.RES:Rescheduling_interrupts
    241.50           +86.4%     450.25 ± 50%  interrupts.CPU132.RES:Rescheduling_interrupts
    251.50 ±  2%     +67.6%     421.50 ± 26%  interrupts.CPU134.RES:Rescheduling_interrupts
    135.50 ± 23%     -41.9%      78.75 ± 22%  interrupts.CPU14.RES:Rescheduling_interrupts
     36.50 ±  6%    +217.1%     115.75 ± 51%  interrupts.CPU141.RES:Rescheduling_interrupts
     16.50 ± 27%   +1084.8%     195.50 ± 80%  interrupts.CPU142.RES:Rescheduling_interrupts
    152.50 ±  4%     +54.6%     235.75 ± 34%  interrupts.CPU144.NMI:Non-maskable_interrupts
    152.50 ±  4%     +54.6%     235.75 ± 34%  interrupts.CPU144.PMI:Performance_monitoring_interrupts
    608.50           -62.2%     230.25 ± 34%  interrupts.CPU145.NMI:Non-maskable_interrupts
    608.50           -62.2%     230.25 ± 34%  interrupts.CPU145.PMI:Performance_monitoring_interrupts
      7770 ± 15%    +307.5%      31664 ±104%  interrupts.CPU15.CAL:Function_call_interrupts
      7746 ± 14%    +451.0%      42681 ± 81%  interrupts.CPU15.TLB:TLB_shootdowns
    179321           +37.6%     246659 ± 14%  interrupts.CPU154.CAL:Function_call_interrupts
    474.50 ±  5%     -26.4%     349.25 ± 24%  interrupts.CPU154.RES:Rescheduling_interrupts
    223397 ±  3%     +27.8%     285599 ± 16%  interrupts.CPU154.TLB:TLB_shootdowns
    158.50 ±  6%    +321.6%     668.25 ±123%  interrupts.CPU165.NMI:Non-maskable_interrupts
    158.50 ±  6%    +321.6%     668.25 ±123%  interrupts.CPU165.PMI:Performance_monitoring_interrupts
    155.00 ±  3%    +730.2%       1286 ± 65%  interrupts.CPU167.NMI:Non-maskable_interrupts
    155.00 ±  3%    +730.2%       1286 ± 65%  interrupts.CPU167.PMI:Performance_monitoring_interrupts
    227937 ± 38%     -72.5%      62775 ±112%  interrupts.CPU169.CAL:Function_call_interrupts
    260271 ± 38%     -70.9%      75774 ±113%  interrupts.CPU169.TLB:TLB_shootdowns
    231108 ± 29%     -75.3%      57057 ± 92%  interrupts.CPU171.CAL:Function_call_interrupts
    352.50 ± 46%     -75.8%      85.25 ±104%  interrupts.CPU171.RES:Rescheduling_interrupts
    263976 ± 31%     -76.1%      62985 ± 93%  interrupts.CPU171.TLB:TLB_shootdowns
    249893 ± 22%     -69.3%      76666 ± 93%  interrupts.CPU173.CAL:Function_call_interrupts
    313.50 ± 25%     -64.0%     112.75 ± 85%  interrupts.CPU173.RES:Rescheduling_interrupts
    295531 ± 25%     -68.0%      94592 ± 95%  interrupts.CPU173.TLB:TLB_shootdowns
    368.00 ± 14%     -60.9%     143.75 ± 75%  interrupts.CPU174.RES:Rescheduling_interrupts
    423.00           -57.3%     180.50 ± 73%  interrupts.CPU175.RES:Rescheduling_interrupts
    550.00           -71.7%     155.50 ± 90%  interrupts.CPU176.RES:Rescheduling_interrupts
    528.50 ±  5%     -67.0%     174.25 ±117%  interrupts.CPU178.RES:Rescheduling_interrupts
    225636 ± 32%     -64.7%      79543 ±105%  interrupts.CPU179.CAL:Function_call_interrupts
    402.00 ± 32%     -49.6%     202.75 ± 34%  interrupts.CPU179.NMI:Non-maskable_interrupts
    402.00 ± 32%     -49.6%     202.75 ± 34%  interrupts.CPU179.PMI:Performance_monitoring_interrupts
    501.50 ±  3%     -64.1%     180.25 ± 98%  interrupts.CPU179.RES:Rescheduling_interrupts
    266959 ± 34%     -65.1%      93250 ±101%  interrupts.CPU179.TLB:TLB_shootdowns
    420.50 ± 12%     -54.6%     191.00 ± 60%  interrupts.CPU180.RES:Rescheduling_interrupts
    460.50           -59.6%     186.25 ± 85%  interrupts.CPU181.RES:Rescheduling_interrupts
    249398 ± 34%     -50.9%     122544 ± 41%  interrupts.CPU182.CAL:Function_call_interrupts
    298945 ± 36%     -51.9%     143906 ± 42%  interrupts.CPU182.TLB:TLB_shootdowns
    484.00 ± 24%     -54.4%     220.50 ±101%  interrupts.CPU183.RES:Rescheduling_interrupts
    228.50 ±  4%     -65.2%      79.50 ± 80%  interrupts.CPU184.RES:Rescheduling_interrupts
    237.50           -32.1%     161.25 ± 40%  interrupts.CPU186.NMI:Non-maskable_interrupts
    237.50           -32.1%     161.25 ± 40%  interrupts.CPU186.PMI:Performance_monitoring_interrupts
    119.50 ± 20%     -51.9%      57.50 ± 59%  interrupts.CPU187.RES:Rescheduling_interrupts
    100.50 ± 11%     -61.4%      38.75 ± 62%  interrupts.CPU188.RES:Rescheduling_interrupts
     25279 ± 55%     -84.0%       4034 ±108%  interrupts.CPU19.CAL:Function_call_interrupts
    154.50 ± 18%    +299.7%     617.50 ± 46%  interrupts.CPU19.NMI:Non-maskable_interrupts
    154.50 ± 18%    +299.7%     617.50 ± 46%  interrupts.CPU19.PMI:Performance_monitoring_interrupts
     27988 ± 59%     -77.4%       6335 ±162%  interrupts.CPU19.TLB:TLB_shootdowns
     78795 ± 17%     -66.5%      26361 ±132%  interrupts.CPU191.CAL:Function_call_interrupts
     89793 ± 17%     -69.3%      27599 ±139%  interrupts.CPU191.TLB:TLB_shootdowns
    136.50 ±  3%    +701.1%       1093 ± 69%  interrupts.CPU2.NMI:Non-maskable_interrupts
    136.50 ±  3%    +701.1%       1093 ± 69%  interrupts.CPU2.PMI:Performance_monitoring_interrupts
    264.00           -62.9%      98.00 ± 42%  interrupts.CPU2.RES:Rescheduling_interrupts
    190.50 ± 16%    +179.0%     531.50 ± 42%  interrupts.CPU20.NMI:Non-maskable_interrupts
    190.50 ± 16%    +179.0%     531.50 ± 42%  interrupts.CPU20.PMI:Performance_monitoring_interrupts
     85184 ± 18%     -81.5%      15741 ±122%  interrupts.CPU22.CAL:Function_call_interrupts
     97815 ± 17%     -78.7%      20803 ±107%  interrupts.CPU22.TLB:TLB_shootdowns
     36354 ± 30%     -80.5%       7107 ±136%  interrupts.CPU23.CAL:Function_call_interrupts
     41265 ± 31%     -83.2%       6931 ±168%  interrupts.CPU23.TLB:TLB_shootdowns
    187656 ± 14%     -61.3%      72695 ± 97%  interrupts.CPU24.CAL:Function_call_interrupts
    105763 ± 67%     -89.0%      11633 ± 79%  interrupts.CPU25.CAL:Function_call_interrupts
    118461 ± 60%     -78.6%      25319 ±100%  interrupts.CPU25.TLB:TLB_shootdowns
     12080 ± 13%     -56.8%       5220 ± 55%  interrupts.CPU26.CAL:Function_call_interrupts
    235.50 ± 28%     -72.0%      66.00 ± 35%  interrupts.CPU27.RES:Rescheduling_interrupts
     35432 ±  7%     -84.5%       5502 ±117%  interrupts.CPU28.CAL:Function_call_interrupts
    392.00 ±  5%     -74.4%     100.50 ± 75%  interrupts.CPU28.RES:Rescheduling_interrupts
     46283 ± 10%     -81.3%       8648 ±153%  interrupts.CPU28.TLB:TLB_shootdowns
    222.00           -70.4%      65.75 ± 48%  interrupts.CPU3.RES:Rescheduling_interrupts
    253.00 ±  3%     -71.3%      72.50 ± 14%  interrupts.CPU35.RES:Rescheduling_interrupts
      7384 ± 74%     -84.1%       1177 ± 21%  interrupts.CPU39.CAL:Function_call_interrupts
     12116 ± 94%     -99.5%      66.50 ± 80%  interrupts.CPU39.TLB:TLB_shootdowns
      9942 ± 22%     -71.4%       2839 ± 77%  interrupts.CPU4.CAL:Function_call_interrupts
    261.00 ±  6%     -79.6%      53.25 ± 17%  interrupts.CPU4.RES:Rescheduling_interrupts
     10765 ± 26%     -66.5%       3606 ±138%  interrupts.CPU4.TLB:TLB_shootdowns
     25523 ± 92%     -89.8%       2615 ± 88%  interrupts.CPU40.CAL:Function_call_interrupts
    113.00 ± 32%     +80.3%     203.75 ± 25%  interrupts.CPU44.NMI:Non-maskable_interrupts
    113.00 ± 32%     +80.3%     203.75 ± 25%  interrupts.CPU44.PMI:Performance_monitoring_interrupts
      8.50 ± 17%   +1120.6%     103.75 ±100%  interrupts.CPU45.RES:Rescheduling_interrupts
    541.50 ± 55%     -84.2%      85.50 ± 57%  interrupts.CPU49.RES:Rescheduling_interrupts
    150.00 ± 49%     -68.2%      47.75 ± 47%  interrupts.CPU5.RES:Rescheduling_interrupts
    327.00 ± 22%     -83.6%      53.75 ± 17%  interrupts.CPU50.RES:Rescheduling_interrupts
    145.00          +118.3%     316.50 ± 72%  interrupts.CPU51.NMI:Non-maskable_interrupts
    145.00          +118.3%     316.50 ± 72%  interrupts.CPU51.PMI:Performance_monitoring_interrupts
    165.50 ±  5%     -72.2%      46.00 ± 19%  interrupts.CPU51.RES:Rescheduling_interrupts
    108.00 ± 32%    +147.7%     267.50 ± 61%  interrupts.CPU52.NMI:Non-maskable_interrupts
    108.00 ± 32%    +147.7%     267.50 ± 61%  interrupts.CPU52.PMI:Performance_monitoring_interrupts
    251.00 ± 46%     -59.5%     101.75 ± 73%  interrupts.CPU52.RES:Rescheduling_interrupts
    146.00          +165.9%     388.25 ± 46%  interrupts.CPU53.NMI:Non-maskable_interrupts
    146.00          +165.9%     388.25 ± 46%  interrupts.CPU53.PMI:Performance_monitoring_interrupts
    160.00 ±  9%    +100.2%     320.25 ± 58%  interrupts.CPU54.NMI:Non-maskable_interrupts
    160.00 ±  9%    +100.2%     320.25 ± 58%  interrupts.CPU54.PMI:Performance_monitoring_interrupts
    132.50 ±  4%    +298.9%     528.50 ± 63%  interrupts.CPU55.NMI:Non-maskable_interrupts
    132.50 ±  4%    +298.9%     528.50 ± 63%  interrupts.CPU55.PMI:Performance_monitoring_interrupts
     25836 ± 36%     -94.7%       1374 ± 26%  interrupts.CPU56.CAL:Function_call_interrupts
    321.00 ± 33%     -86.6%      43.00 ±  7%  interrupts.CPU56.RES:Rescheduling_interrupts
     38679 ± 28%     -99.4%     243.00 ± 73%  interrupts.CPU56.TLB:TLB_shootdowns
     21567 ± 14%     -91.2%       1907 ± 61%  interrupts.CPU57.CAL:Function_call_interrupts
    121.50 ± 18%    +180.5%     340.75 ± 52%  interrupts.CPU57.NMI:Non-maskable_interrupts
    121.50 ± 18%    +180.5%     340.75 ± 52%  interrupts.CPU57.PMI:Performance_monitoring_interrupts
    272.00 ± 35%     -81.2%      51.00 ± 28%  interrupts.CPU57.RES:Rescheduling_interrupts
     41527 ± 15%     -97.9%     862.25 ±136%  interrupts.CPU57.TLB:TLB_shootdowns
    248.00 ± 45%     -74.6%      63.00 ± 46%  interrupts.CPU58.RES:Rescheduling_interrupts
    258.00 ± 25%     -58.9%     106.00 ± 94%  interrupts.CPU59.RES:Rescheduling_interrupts
    465.00 ±  2%     -91.7%      38.75 ± 39%  interrupts.CPU6.RES:Rescheduling_interrupts
    101.50 ± 27%     -53.9%      46.75 ± 13%  interrupts.CPU60.RES:Rescheduling_interrupts
    186.00 ± 44%     -66.7%      62.00 ± 29%  interrupts.CPU61.RES:Rescheduling_interrupts
      6410 ± 70%     -68.3%       2030 ± 48%  interrupts.CPU62.CAL:Function_call_interrupts
    174.50 ± 58%     -65.0%      61.00 ± 24%  interrupts.CPU62.RES:Rescheduling_interrupts
      6054 ± 86%     -86.4%     821.00 ±146%  interrupts.CPU62.TLB:TLB_shootdowns
     41658 ± 55%     -71.7%      11775 ±150%  interrupts.CPU64.CAL:Function_call_interrupts
     47312 ± 55%     -75.0%      11834 ±168%  interrupts.CPU64.TLB:TLB_shootdowns
     18320 ± 37%     -91.5%       1556 ± 15%  interrupts.CPU7.CAL:Function_call_interrupts
    273.50 ± 39%     -83.5%      45.00 ± 58%  interrupts.CPU7.RES:Rescheduling_interrupts
     20101 ± 38%     -97.5%     504.75 ± 36%  interrupts.CPU7.TLB:TLB_shootdowns
     45476 ±  7%     -67.5%      14783 ±122%  interrupts.CPU70.CAL:Function_call_interrupts
    152.50           +43.9%     219.50 ± 22%  interrupts.CPU70.NMI:Non-maskable_interrupts
    152.50           +43.9%     219.50 ± 22%  interrupts.CPU70.PMI:Performance_monitoring_interrupts
     56380           -65.3%      19561 ±109%  interrupts.CPU70.TLB:TLB_shootdowns
    148.50 ±  4%    +744.3%       1253 ± 53%  interrupts.CPU71.NMI:Non-maskable_interrupts
    148.50 ±  4%    +744.3%       1253 ± 53%  interrupts.CPU71.PMI:Performance_monitoring_interrupts
     63152 ± 21%     -87.8%       7723 ± 78%  interrupts.CPU73.CAL:Function_call_interrupts
    531.50 ± 51%     -69.0%     164.50 ± 58%  interrupts.CPU73.RES:Rescheduling_interrupts
     83608 ± 24%     -79.0%      17535 ±100%  interrupts.CPU73.TLB:TLB_shootdowns
     21856 ± 49%     -83.4%       3629 ±103%  interrupts.CPU74.CAL:Function_call_interrupts
    311.50 ± 17%     -63.6%     113.50 ± 92%  interrupts.CPU74.RES:Rescheduling_interrupts
     32415 ± 40%     -78.9%       6828 ±163%  interrupts.CPU74.TLB:TLB_shootdowns
    663.00 ± 39%     -83.4%     110.25 ±102%  interrupts.CPU75.RES:Rescheduling_interrupts
    245.50 ± 40%     -73.3%      65.50 ± 90%  interrupts.CPU76.RES:Rescheduling_interrupts
     34156 ±  4%     -75.5%       8365 ±111%  interrupts.CPU76.TLB:TLB_shootdowns
    193.00 ± 43%     -52.6%      91.50 ± 96%  interrupts.CPU77.RES:Rescheduling_interrupts
    209.00 ± 28%     -83.9%      33.75 ± 25%  interrupts.CPU78.RES:Rescheduling_interrupts
     21964 ± 25%     -72.9%       5954 ±168%  interrupts.CPU78.TLB:TLB_shootdowns
     14935 ± 19%     -90.6%       1408 ± 31%  interrupts.CPU79.CAL:Function_call_interrupts
    310.50 ±  3%     -87.4%      39.00 ± 82%  interrupts.CPU79.RES:Rescheduling_interrupts
     18945           -98.6%     259.75 ±108%  interrupts.CPU79.TLB:TLB_shootdowns
    217.00           -67.1%      71.50 ± 80%  interrupts.CPU8.RES:Rescheduling_interrupts
    224.00 ± 51%     -75.0%      56.00 ±107%  interrupts.CPU82.RES:Rescheduling_interrupts
     14294 ±  4%     -75.3%       3527 ± 85%  interrupts.CPU83.CAL:Function_call_interrupts
    309.50 ± 23%     -49.3%     157.00 ± 55%  interrupts.CPU83.NMI:Non-maskable_interrupts
    309.50 ± 23%     -49.3%     157.00 ± 55%  interrupts.CPU83.PMI:Performance_monitoring_interrupts
    251.50 ± 30%     -68.4%      79.50 ± 79%  interrupts.CPU83.RES:Rescheduling_interrupts
     20072 ± 30%     -63.1%       7408 ±128%  interrupts.CPU83.TLB:TLB_shootdowns
     14272 ± 22%     -91.2%       1260 ± 32%  interrupts.CPU84.CAL:Function_call_interrupts
    294.00 ±  3%     -83.2%      49.25 ± 64%  interrupts.CPU84.RES:Rescheduling_interrupts
     23916 ± 51%     -99.4%     132.75 ±166%  interrupts.CPU84.TLB:TLB_shootdowns
    155.00 ± 37%     -52.7%      73.25 ±110%  interrupts.CPU85.RES:Rescheduling_interrupts
     13973 ±  9%     -91.1%       1250 ± 22%  interrupts.CPU86.CAL:Function_call_interrupts
    265.50 ± 29%     -84.2%      42.00 ± 40%  interrupts.CPU86.RES:Rescheduling_interrupts
     14770 ±  9%     -99.6%      61.00 ±158%  interrupts.CPU86.TLB:TLB_shootdowns
     26510 ± 18%     -57.5%      11270 ± 84%  interrupts.CPU88.CAL:Function_call_interrupts
     95.50 ± 24%     -38.0%      59.25 ± 32%  interrupts.CPU9.RES:Rescheduling_interrupts
    243.00 ± 10%     -39.6%     146.75 ± 28%  interrupts.CPU90.NMI:Non-maskable_interrupts
    243.00 ± 10%     -39.6%     146.75 ± 28%  interrupts.CPU90.PMI:Performance_monitoring_interrupts
     81359 ± 69%     -59.5%      32911 ±143%  interrupts.CPU91.CAL:Function_call_interrupts
     92043 ± 69%     -51.6%      44544 ±140%  interrupts.CPU91.TLB:TLB_shootdowns
    115461 ± 55%     -60.2%      45972 ±134%  interrupts.CPU92.CAL:Function_call_interrupts
     91135 ±  7%    +316.9%     379964 ± 45%  interrupts.CPU98.CAL:Function_call_interrupts
    105442 ±  8%    +337.6%     461433 ± 50%  interrupts.CPU98.TLB:TLB_shootdowns
     42028 ±  2%     +77.2%      74484 ± 12%  interrupts.NMI:Non-maskable_interrupts
     42028 ±  2%     +77.2%      74484 ± 12%  interrupts.PMI:Performance_monitoring_interrupts
     38859 ± 12%     -30.2%      27136 ± 13%  interrupts.RES:Rescheduling_interrupts
     10.69 ± 12%     -10.4        0.28 ±173%  perf-profile.calltrace.cycles-pp.do_huge_pmd_anonymous_page.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault
     22.09 ±  4%      -8.5       13.55 ± 15%  perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry
     65.03            -8.0       57.01 ±  9%  perf-profile.calltrace.cycles-pp.cpuidle_enter.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64
     63.55            -7.9       55.69 ± 10%  perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry.start_secondary
      7.80            -7.6        0.20 ±173%  perf-profile.calltrace.cycles-pp.clear_huge_page.do_huge_pmd_anonymous_page.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
      7.57            -7.4        0.20 ±173%  perf-profile.calltrace.cycles-pp.clear_subpage.clear_huge_page.do_huge_pmd_anonymous_page.__handle_mm_fault.handle_mm_fault
     17.22 ±  4%      -7.1       10.15 ± 18%  perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter.do_idle
      6.31            -6.1        0.16 ±173%  perf-profile.calltrace.cycles-pp.clear_page_erms.clear_subpage.clear_huge_page.do_huge_pmd_anonymous_page.__handle_mm_fault
     15.23 ±  3%      -5.3        9.95 ± 12%  perf-profile.calltrace.cycles-pp.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
     15.24 ±  3%      -5.2       10.05 ± 12%  perf-profile.calltrace.cycles-pp.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.do_access
     15.31 ±  3%      -4.3       11.00 ± 13%  perf-profile.calltrace.cycles-pp.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.do_access
     15.32 ±  3%      -4.3       11.06 ± 13%  perf-profile.calltrace.cycles-pp.exc_page_fault.asm_exc_page_fault.do_access
      9.97 ±  3%      -4.2        5.81 ± 18%  perf-profile.calltrace.cycles-pp.__sysvec_apic_timer_interrupt.asm_call_on_stack.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state
      9.98 ±  3%      -4.2        5.83 ± 18%  perf-profile.calltrace.cycles-pp.asm_call_on_stack.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter
      9.84 ±  3%      -4.1        5.73 ± 18%  perf-profile.calltrace.cycles-pp.hrtimer_interrupt.__sysvec_apic_timer_interrupt.asm_call_on_stack.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      4.39            -3.4        0.96 ± 10%  perf-profile.calltrace.cycles-pp.try_to_unmap_one.rmap_walk_anon.try_to_unmap.shrink_page_list.shrink_inactive_list
      4.42            -3.4        1.02 ± 10%  perf-profile.calltrace.cycles-pp.rmap_walk_anon.try_to_unmap.shrink_page_list.shrink_inactive_list.shrink_lruvec
      4.42            -3.4        1.02 ± 10%  perf-profile.calltrace.cycles-pp.try_to_unmap.shrink_page_list.shrink_inactive_list.shrink_lruvec.shrink_node
     15.46 ±  3%      -2.8       12.63 ± 14%  perf-profile.calltrace.cycles-pp.asm_exc_page_fault.do_access
      5.47 ±  4%      -2.5        2.97 ± 20%  perf-profile.calltrace.cycles-pp.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.asm_call_on_stack.sysvec_apic_timer_interrupt
      4.19 ±  5%      -2.0        2.18 ± 18%  perf-profile.calltrace.cycles-pp.tick_sched_timer.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.asm_call_on_stack
      3.91 ±  5%      -1.9        2.00 ± 23%  perf-profile.calltrace.cycles-pp.irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter
      3.38 ±  2%      -1.8        1.62 ± 21%  perf-profile.calltrace.cycles-pp.tick_sched_handle.tick_sched_timer.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt
      3.35 ±  2%      -1.8        1.60 ± 21%  perf-profile.calltrace.cycles-pp.update_process_times.tick_sched_handle.tick_sched_timer.__hrtimer_run_queues.hrtimer_interrupt
      3.20 ±  7%      -1.6        1.64 ± 25%  perf-profile.calltrace.cycles-pp.do_softirq_own_stack.irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state
      3.19 ±  7%      -1.6        1.63 ± 25%  perf-profile.calltrace.cycles-pp.asm_call_on_stack.do_softirq_own_stack.irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      3.17 ±  7%      -1.5        1.63 ± 25%  perf-profile.calltrace.cycles-pp.__softirqentry_text_start.asm_call_on_stack.do_softirq_own_stack.irq_exit_rcu.sysvec_apic_timer_interrupt
      2.09 ±  5%      -1.3        0.75 ± 16%  perf-profile.calltrace.cycles-pp.scheduler_tick.update_process_times.tick_sched_handle.tick_sched_timer.__hrtimer_run_queues
      2.98            -1.2        1.81 ± 14%  perf-profile.calltrace.cycles-pp.clockevents_program_event.hrtimer_interrupt.__sysvec_apic_timer_interrupt.asm_call_on_stack.sysvec_apic_timer_interrupt
      3.02 ±  4%      -0.9        2.15 ±  7%  perf-profile.calltrace.cycles-pp.tick_nohz_get_sleep_length.menu_select.do_idle.cpu_startup_entry.start_secondary
      2.29 ±  3%      -0.8        1.44 ± 14%  perf-profile.calltrace.cycles-pp.ktime_get.clockevents_program_event.hrtimer_interrupt.__sysvec_apic_timer_interrupt.asm_call_on_stack
      2.68 ±  5%      -0.8        1.88 ±  7%  perf-profile.calltrace.cycles-pp.tick_nohz_next_event.tick_nohz_get_sleep_length.menu_select.do_idle.cpu_startup_entry
      1.48 ± 12%      -0.5        0.97 ± 10%  perf-profile.calltrace.cycles-pp.ktime_get.tick_nohz_irq_exit.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state
      1.52 ± 11%      -0.5        1.02 ± 11%  perf-profile.calltrace.cycles-pp.tick_nohz_irq_exit.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter
      1.32 ± 12%      -0.4        0.88 ± 15%  perf-profile.calltrace.cycles-pp.rebalance_domains.__softirqentry_text_start.asm_call_on_stack.do_softirq_own_stack.irq_exit_rcu
      1.52 ±  4%      -0.4        1.11 ± 18%  perf-profile.calltrace.cycles-pp.irq_enter_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter
      1.55 ±  9%      -0.4        1.14 ±  7%  perf-profile.calltrace.cycles-pp.timekeeping_max_deferment.tick_nohz_next_event.tick_nohz_get_sleep_length.menu_select.do_idle
      1.37 ±  7%      -0.4        0.96 ± 17%  perf-profile.calltrace.cycles-pp.tick_irq_enter.irq_enter_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state
      0.77 ± 16%      -0.3        0.45 ± 58%  perf-profile.calltrace.cycles-pp._raw_spin_trylock.rebalance_domains.__softirqentry_text_start.asm_call_on_stack.do_softirq_own_stack
      0.90 ± 11%      -0.2        0.66 ± 20%  perf-profile.calltrace.cycles-pp.ktime_get_update_offsets_now.hrtimer_interrupt.__sysvec_apic_timer_interrupt.asm_call_on_stack.sysvec_apic_timer_interrupt
      1.03 ± 15%      -0.2        0.81 ± 17%  perf-profile.calltrace.cycles-pp.ktime_get.tick_irq_enter.irq_enter_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      0.00            +0.6        0.63 ± 16%  perf-profile.calltrace.cycles-pp.page_referenced.shrink_active_list.shrink_lruvec.shrink_node.balance_pgdat
      0.00            +0.7        0.70 ± 28%  perf-profile.calltrace.cycles-pp.__swap_writepage.pageout.shrink_page_list.shrink_inactive_list.shrink_lruvec
      0.31 ±100%      +0.7        1.03 ± 18%  perf-profile.calltrace.cycles-pp.__sched_text_start.schedule.io_schedule.swap_readpage.read_swap_cache_async
      0.00            +0.7        0.72 ± 17%  perf-profile.calltrace.cycles-pp.mem_cgroup_uncharge_swap.mem_cgroup_charge.__read_swap_cache_async.read_swap_cache_async.swapin_readahead
      0.31 ±100%      +0.7        1.04 ± 18%  perf-profile.calltrace.cycles-pp.schedule.io_schedule.swap_readpage.read_swap_cache_async.swapin_readahead
      0.31 ±100%      +0.7        1.04 ± 19%  perf-profile.calltrace.cycles-pp.io_schedule.swap_readpage.read_swap_cache_async.swapin_readahead.do_swap_page
      1.59 ±  8%      +0.7        2.32 ± 16%  perf-profile.calltrace.cycles-pp.__read_swap_cache_async.read_swap_cache_async.swapin_readahead.do_swap_page.__handle_mm_fault
      0.00            +0.8        0.75 ± 19%  perf-profile.calltrace.cycles-pp.submit_bio_noacct.submit_bio.swap_readpage.read_swap_cache_async.swapin_readahead
      0.00            +0.8        0.76 ± 19%  perf-profile.calltrace.cycles-pp.submit_bio.swap_readpage.read_swap_cache_async.swapin_readahead.do_swap_page
      0.00            +0.8        0.77 ± 27%  perf-profile.calltrace.cycles-pp.arch_stack_walk.stack_trace_save_tsk.__account_scheduler_latency.enqueue_entity.enqueue_task_fair
      0.00            +0.8        0.77 ± 10%  perf-profile.calltrace.cycles-pp.shrink_active_list.shrink_lruvec.shrink_node.balance_pgdat.kswapd
      0.00            +0.8        0.82 ± 27%  perf-profile.calltrace.cycles-pp.stack_trace_save_tsk.__account_scheduler_latency.enqueue_entity.enqueue_task_fair.ttwu_do_activate
      0.00            +0.9        0.91 ± 33%  perf-profile.calltrace.cycles-pp.pageout.shrink_page_list.shrink_inactive_list.shrink_lruvec.shrink_node
      0.00            +0.9        0.93 ± 25%  perf-profile.calltrace.cycles-pp.page_vma_mapped_walk.page_referenced_one.rmap_walk_anon.page_referenced.shrink_page_list
      0.00            +1.0        1.04 ± 11%  perf-profile.calltrace.cycles-pp.xas_load.find_get_entry.pagecache_get_page.lookup_swap_cache.do_swap_page
      0.00            +1.1        1.06 ± 11%  perf-profile.calltrace.cycles-pp.find_get_entry.pagecache_get_page.lookup_swap_cache.do_swap_page.__handle_mm_fault
      0.00            +1.1        1.06 ± 11%  perf-profile.calltrace.cycles-pp.pagecache_get_page.lookup_swap_cache.do_swap_page.__handle_mm_fault.handle_mm_fault
      0.00            +1.1        1.11 ± 17%  perf-profile.calltrace.cycles-pp.mem_cgroup_charge.__read_swap_cache_async.read_swap_cache_async.swapin_readahead.do_swap_page
      1.57 ±  9%      +1.1        2.71 ± 22%  perf-profile.calltrace.cycles-pp.nvme_irq.__handle_irq_event_percpu.handle_irq_event_percpu.handle_irq_event.handle_edge_irq
      0.00            +1.1        1.15 ± 12%  perf-profile.calltrace.cycles-pp.lookup_swap_cache.do_swap_page.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
      1.58 ±  9%      +1.1        2.73 ± 22%  perf-profile.calltrace.cycles-pp.__handle_irq_event_percpu.handle_irq_event_percpu.handle_irq_event.handle_edge_irq.asm_call_on_stack
      1.61 ± 10%      +1.2        2.81 ± 22%  perf-profile.calltrace.cycles-pp.handle_irq_event_percpu.handle_irq_event.handle_edge_irq.asm_call_on_stack.common_interrupt
      0.00            +1.3        1.26 ± 16%  perf-profile.calltrace.cycles-pp.page_referenced_one.rmap_walk_anon.page_referenced.shrink_page_list.shrink_inactive_list
      1.64 ± 10%      +1.3        2.92 ± 22%  perf-profile.calltrace.cycles-pp.handle_irq_event.handle_edge_irq.asm_call_on_stack.common_interrupt.asm_common_interrupt
      1.67 ± 10%      +1.3        3.00 ± 22%  perf-profile.calltrace.cycles-pp.handle_edge_irq.asm_call_on_stack.common_interrupt.asm_common_interrupt.cpuidle_enter_state
      1.67 ± 10%      +1.3        3.00 ± 22%  perf-profile.calltrace.cycles-pp.asm_call_on_stack.common_interrupt.asm_common_interrupt.cpuidle_enter_state.cpuidle_enter
      0.00            +1.4        1.36 ± 25%  perf-profile.calltrace.cycles-pp.__account_scheduler_latency.enqueue_entity.enqueue_task_fair.ttwu_do_activate.try_to_wake_up
      0.00            +1.4        1.38 ± 18%  perf-profile.calltrace.cycles-pp.rmap_walk_anon.page_referenced.shrink_page_list.shrink_inactive_list.shrink_lruvec
      1.76 ± 10%      +1.4        3.15 ± 22%  perf-profile.calltrace.cycles-pp.common_interrupt.asm_common_interrupt.cpuidle_enter_state.cpuidle_enter.do_idle
      1.77 ± 10%      +1.4        3.18 ± 22%  perf-profile.calltrace.cycles-pp.asm_common_interrupt.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry
      0.00            +1.7        1.65 ± 24%  perf-profile.calltrace.cycles-pp.enqueue_entity.enqueue_task_fair.ttwu_do_activate.try_to_wake_up.end_swap_bio_read
      0.00            +1.7        1.71 ± 24%  perf-profile.calltrace.cycles-pp.ttwu_do_activate.try_to_wake_up.end_swap_bio_read.blk_update_request.blk_mq_end_request
      0.00            +1.7        1.71 ± 24%  perf-profile.calltrace.cycles-pp.enqueue_task_fair.ttwu_do_activate.try_to_wake_up.end_swap_bio_read.blk_update_request
      0.80 ± 12%      +1.7        2.52 ± 17%  perf-profile.calltrace.cycles-pp.swap_readpage.read_swap_cache_async.swapin_readahead.do_swap_page.__handle_mm_fault
      0.00            +1.7        1.75 ± 13%  perf-profile.calltrace.cycles-pp.page_referenced.shrink_page_list.shrink_inactive_list.shrink_lruvec.shrink_node
      0.25 ±100%      +1.8        2.01 ± 24%  perf-profile.calltrace.cycles-pp.try_to_wake_up.end_swap_bio_read.blk_update_request.blk_mq_end_request.nvme_irq
      0.27 ±100%      +1.9        2.12 ± 24%  perf-profile.calltrace.cycles-pp.end_swap_bio_read.blk_update_request.blk_mq_end_request.nvme_irq.__handle_irq_event_percpu
      0.33 ±100%      +2.0        2.29 ± 23%  perf-profile.calltrace.cycles-pp.blk_update_request.blk_mq_end_request.nvme_irq.__handle_irq_event_percpu.handle_irq_event_percpu
      0.00            +2.0        2.01 ± 38%  perf-profile.calltrace.cycles-pp.smp_call_function_many_cond.on_each_cpu_cond_mask.arch_tlbbatch_flush.try_to_unmap_flush_dirty.shrink_page_list
      0.35 ±100%      +2.0        2.38 ± 23%  perf-profile.calltrace.cycles-pp.blk_mq_end_request.nvme_irq.__handle_irq_event_percpu.handle_irq_event_percpu.handle_irq_event
      0.00            +2.0        2.04 ± 38%  perf-profile.calltrace.cycles-pp.on_each_cpu_cond_mask.arch_tlbbatch_flush.try_to_unmap_flush_dirty.shrink_page_list.shrink_inactive_list
      0.00            +2.1        2.07 ± 38%  perf-profile.calltrace.cycles-pp.try_to_unmap_flush_dirty.shrink_page_list.shrink_inactive_list.shrink_lruvec.shrink_node
      0.00            +2.1        2.07 ± 38%  perf-profile.calltrace.cycles-pp.arch_tlbbatch_flush.try_to_unmap_flush_dirty.shrink_page_list.shrink_inactive_list.shrink_lruvec
      2.40            +2.5        4.86 ± 16%  perf-profile.calltrace.cycles-pp.read_swap_cache_async.swapin_readahead.do_swap_page.__handle_mm_fault.handle_mm_fault
      2.41            +2.5        4.88 ± 16%  perf-profile.calltrace.cycles-pp.swapin_readahead.do_swap_page.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
      4.04            +3.0        7.02 ± 21%  perf-profile.calltrace.cycles-pp.shrink_page_list.shrink_inactive_list.shrink_lruvec.shrink_node.balance_pgdat
      4.11            +3.4        7.48 ± 21%  perf-profile.calltrace.cycles-pp.shrink_inactive_list.shrink_lruvec.shrink_node.balance_pgdat.kswapd
      4.12            +4.1        8.26 ± 19%  perf-profile.calltrace.cycles-pp.shrink_lruvec.shrink_node.balance_pgdat.kswapd.kthread
      4.13            +4.2        8.32 ± 19%  perf-profile.calltrace.cycles-pp.shrink_node.balance_pgdat.kswapd.kthread.ret_from_fork
      4.13            +4.2        8.33 ± 19%  perf-profile.calltrace.cycles-pp.balance_pgdat.kswapd.kthread.ret_from_fork
      4.13            +4.2        8.34 ± 19%  perf-profile.calltrace.cycles-pp.kswapd.kthread.ret_from_fork
      2.71            +4.9        7.56 ± 15%  perf-profile.calltrace.cycles-pp.do_swap_page.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault
     10.69 ± 12%     -10.3        0.41 ±114%  perf-profile.children.cycles-pp.do_huge_pmd_anonymous_page
     20.17 ±  4%      -7.9       12.24 ± 15%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
     65.62            -7.7       57.92 ±  9%  perf-profile.children.cycles-pp.cpuidle_enter
     65.59            -7.7       57.89 ±  9%  perf-profile.children.cycles-pp.cpuidle_enter_state
      7.83            -7.5        0.32 ±106%  perf-profile.children.cycles-pp.clear_huge_page
      7.61            -7.3        0.32 ±106%  perf-profile.children.cycles-pp.clear_subpage
     17.52 ±  4%      -7.1       10.39 ± 17%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      6.51            -6.0        0.55 ± 51%  perf-profile.children.cycles-pp.clear_page_erms
      5.58 ±  8%      -5.5        0.08 ±173%  perf-profile.children.cycles-pp.__alloc_pages_slowpath
     15.35 ±  3%      -5.3       10.01 ± 12%  perf-profile.children.cycles-pp.__handle_mm_fault
     15.37 ±  3%      -5.3       10.10 ± 12%  perf-profile.children.cycles-pp.handle_mm_fault
      5.75 ±  8%      -5.0        0.73 ± 29%  perf-profile.children.cycles-pp.__alloc_pages_nodemask
     15.44 ±  3%      -4.4       11.06 ± 13%  perf-profile.children.cycles-pp.do_user_addr_fault
     15.45 ±  3%      -4.3       11.12 ± 13%  perf-profile.children.cycles-pp.exc_page_fault
     10.16 ±  3%      -4.2        5.99 ± 17%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      5.14            -4.1        1.00 ± 13%  perf-profile.children.cycles-pp.try_to_unmap_one
     10.03 ±  3%      -4.1        5.90 ± 17%  perf-profile.children.cycles-pp.hrtimer_interrupt
     15.46 ±  2%      -4.1       11.36 ± 16%  perf-profile.children.cycles-pp.asm_call_on_stack
      5.15            -4.1        1.06 ± 13%  perf-profile.children.cycles-pp.try_to_unmap
     15.60 ±  3%      -3.6       12.01 ± 14%  perf-profile.children.cycles-pp.asm_exc_page_fault
      5.50            -2.7        2.79 ± 10%  perf-profile.children.cycles-pp.rmap_walk_anon
      5.60 ±  4%      -2.5        3.07 ± 19%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      2.67            -2.3        0.34 ±  9%  perf-profile.children.cycles-pp.load_balance
      2.53            -2.3        0.27 ±  8%  perf-profile.children.cycles-pp.find_busiest_group
      2.50 ±  2%      -2.2        0.26 ±  8%  perf-profile.children.cycles-pp.update_sd_lb_stats
      2.35            -2.2        0.11 ±  4%  perf-profile.children.cycles-pp.newidle_balance
      2.42            -2.2        0.23 ±  9%  perf-profile.children.cycles-pp.pick_next_task_fair
      2.08 ±  4%      -2.0        0.04 ± 59%  perf-profile.children.cycles-pp.worker_thread
      4.28 ±  5%      -2.0        2.26 ± 16%  perf-profile.children.cycles-pp.tick_sched_timer
      4.00 ±  4%      -1.9        2.12 ± 21%  perf-profile.children.cycles-pp.irq_exit_rcu
      3.46 ±  3%      -1.8        1.68 ± 20%  perf-profile.children.cycles-pp.tick_sched_handle
      3.44 ±  3%      -1.8        1.67 ± 20%  perf-profile.children.cycles-pp.update_process_times
      2.45 ±  5%      -1.7        0.74 ± 29%  perf-profile.children.cycles-pp.alloc_pages_vma
      2.77            -1.7        1.08 ± 18%  perf-profile.children.cycles-pp.schedule
      5.62 ±  9%      -1.7        3.94 ± 13%  perf-profile.children.cycles-pp.ktime_get
      3.26 ±  7%      -1.6        1.66 ± 24%  perf-profile.children.cycles-pp.__softirqentry_text_start
      3.26 ±  7%      -1.6        1.67 ± 24%  perf-profile.children.cycles-pp.do_softirq_own_stack
      3.07            -1.5        1.56 ± 15%  perf-profile.children.cycles-pp.__sched_text_start
      2.15 ±  4%      -1.4        0.80 ± 13%  perf-profile.children.cycles-pp.scheduler_tick
      3.03            -1.2        1.86 ± 13%  perf-profile.children.cycles-pp.clockevents_program_event
      3.04 ±  4%      -0.9        2.17 ±  7%  perf-profile.children.cycles-pp.tick_nohz_get_sleep_length
      2.71 ±  5%      -0.8        1.89 ±  7%  perf-profile.children.cycles-pp.tick_nohz_next_event
      0.83 ±  8%      -0.8        0.06 ± 22%  perf-profile.children.cycles-pp.__rq_qos_throttle
      0.81 ± 10%      -0.7        0.09 ±  5%  perf-profile.children.cycles-pp.idle_cpu
      0.72 ±  2%      -0.7        0.04 ±110%  perf-profile.children.cycles-pp.__rq_qos_done
      0.72            -0.7        0.04 ±110%  perf-profile.children.cycles-pp.wbt_done
      0.73            -0.7        0.08 ± 51%  perf-profile.children.cycles-pp.blk_mq_free_request
      0.88 ±  5%      -0.6        0.27 ± 67%  perf-profile.children.cycles-pp.rcu_core
      0.72 ±  6%      -0.6        0.14 ± 14%  perf-profile.children.cycles-pp.swap_duplicate
      0.72 ±  6%      -0.5        0.19 ± 13%  perf-profile.children.cycles-pp.__swap_duplicate
      1.86            -0.5        1.33 ± 13%  perf-profile.children.cycles-pp._raw_spin_lock
      1.54 ± 11%      -0.5        1.02 ± 11%  perf-profile.children.cycles-pp.tick_nohz_irq_exit
      1.18 ±  4%      -0.5        0.70 ± 28%  perf-profile.children.cycles-pp.__swap_writepage
      1.34 ± 12%      -0.4        0.90 ± 14%  perf-profile.children.cycles-pp.rebalance_domains
      1.45 ±  6%      -0.4        1.03 ± 17%  perf-profile.children.cycles-pp.tick_irq_enter
      1.56 ±  9%      -0.4        1.15 ±  7%  perf-profile.children.cycles-pp.timekeeping_max_deferment
      1.62 ±  3%      -0.4        1.23 ± 17%  perf-profile.children.cycles-pp.irq_enter_rcu
      1.23 ±  2%      -0.4        0.84 ± 16%  perf-profile.children.cycles-pp.blk_mq_submit_bio
      0.42 ±  4%      -0.3        0.10 ± 15%  perf-profile.children.cycles-pp.blk_flush_plug_list
      0.42 ±  4%      -0.3        0.10 ± 15%  perf-profile.children.cycles-pp.blk_mq_flush_plug_list
      0.42 ±  6%      -0.3        0.10 ± 15%  perf-profile.children.cycles-pp.blk_mq_sched_insert_requests
      0.90 ± 16%      -0.3        0.59 ± 17%  perf-profile.children.cycles-pp._raw_spin_trylock
      0.66 ±  7%      -0.3        0.36 ± 13%  perf-profile.children.cycles-pp.lapic_next_deadline
      0.73            -0.3        0.44 ± 26%  perf-profile.children.cycles-pp.perf_mux_hrtimer_handler
      0.95            -0.3        0.70 ± 18%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      0.92            -0.2        0.67 ± 16%  perf-profile.children.cycles-pp.irqtime_account_irq
      0.48 ± 16%      -0.2        0.23 ± 16%  perf-profile.children.cycles-pp.do_syscall_64
      0.49 ± 16%      -0.2        0.25 ± 20%  perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.92 ±  9%      -0.2        0.68 ± 19%  perf-profile.children.cycles-pp.ktime_get_update_offsets_now
      0.32 ±  4%      -0.2        0.08 ± 15%  perf-profile.children.cycles-pp.page_remove_rmap
      0.52 ±  8%      -0.2        0.29 ± 14%  perf-profile.children.cycles-pp.calc_global_load_tick
      0.36            -0.2        0.15 ± 61%  perf-profile.children.cycles-pp.note_gp_changes
      0.48 ±  5%      -0.2        0.27 ± 24%  perf-profile.children.cycles-pp.update_rq_clock
      0.47 ±  4%      -0.2        0.25 ± 49%  perf-profile.children.cycles-pp.rcu_sched_clock_irq
      0.23 ±  2%      -0.2        0.03 ±100%  perf-profile.children.cycles-pp.nvme_pci_complete_rq
      0.30 ± 20%      -0.2        0.10 ± 24%  perf-profile.children.cycles-pp.update_ts_time_stats
      0.28 ± 17%      -0.2        0.09 ± 17%  perf-profile.children.cycles-pp.nr_iowait_cpu
      0.67 ±  6%      -0.2        0.48 ± 15%  perf-profile.children.cycles-pp.sched_clock_cpu
      0.70 ±  2%      -0.2        0.52 ± 19%  perf-profile.children.cycles-pp.poll_idle
      0.32 ± 10%      -0.2        0.16 ± 14%  perf-profile.children.cycles-pp.update_blocked_averages
      0.28 ±  3%      -0.2        0.11 ±  4%  perf-profile.children.cycles-pp.nvme_map_data
      0.22 ±  6%      -0.2        0.06        perf-profile.children.cycles-pp.cpumask_next_and
      0.59 ± 10%      -0.2        0.43 ± 15%  perf-profile.children.cycles-pp.sched_clock
      0.29            -0.2        0.13 ± 25%  perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
      0.34 ±  4%      -0.1        0.20 ± 32%  perf-profile.children.cycles-pp.__intel_pmu_enable_all
      0.35 ±  8%      -0.1        0.20 ±  5%  perf-profile.children.cycles-pp.arch_cpu_idle_enter
      0.55 ±  9%      -0.1        0.41 ± 15%  perf-profile.children.cycles-pp.native_sched_clock
      0.34 ± 10%      -0.1        0.20 ±  5%  perf-profile.children.cycles-pp.tsc_verify_tsc_adjust
      0.31 ± 12%      -0.1        0.17 ± 16%  perf-profile.children.cycles-pp.run_rebalance_domains
      0.26 ±  9%      -0.1        0.14 ± 19%  perf-profile.children.cycles-pp.irq_work_run_list
      0.25 ± 12%      -0.1        0.13 ± 21%  perf-profile.children.cycles-pp.asm_sysvec_irq_work
      0.25 ± 12%      -0.1        0.13 ± 21%  perf-profile.children.cycles-pp.sysvec_irq_work
      0.25 ± 12%      -0.1        0.13 ± 21%  perf-profile.children.cycles-pp.__sysvec_irq_work
      0.25 ± 12%      -0.1        0.13 ± 21%  perf-profile.children.cycles-pp.irq_work_run
      0.25 ± 12%      -0.1        0.13 ± 21%  perf-profile.children.cycles-pp.irq_work_single
      0.25 ± 12%      -0.1        0.13 ± 21%  perf-profile.children.cycles-pp.printk
      0.25 ± 12%      -0.1        0.13 ± 21%  perf-profile.children.cycles-pp.vprintk_emit
      0.25 ± 12%      -0.1        0.13 ± 21%  perf-profile.children.cycles-pp.console_unlock
      0.23 ± 11%      -0.1        0.11 ± 19%  perf-profile.children.cycles-pp.uart_console_write
      0.23 ± 11%      -0.1        0.11 ± 19%  perf-profile.children.cycles-pp.serial8250_console_putchar
      0.23 ± 13%      -0.1        0.12 ± 21%  perf-profile.children.cycles-pp.serial8250_console_write
      0.23 ± 11%      -0.1        0.12 ± 19%  perf-profile.children.cycles-pp.wait_for_xmitr
      0.14 ± 49%      -0.1        0.05 ± 62%  perf-profile.children.cycles-pp.ksys_read
      0.16 ± 12%      -0.1        0.07 ± 12%  perf-profile.children.cycles-pp.___might_sleep
      0.36 ±  4%      -0.1        0.27 ± 10%  perf-profile.children.cycles-pp.nvme_queue_rq
      0.13 ± 46%      -0.1        0.04 ± 59%  perf-profile.children.cycles-pp.vfs_read
      0.15 ± 20%      -0.1        0.07 ± 58%  perf-profile.children.cycles-pp.io_serial_in
      0.22 ±  6%      -0.1        0.14 ± 16%  perf-profile.children.cycles-pp.rcu_idle_exit
      0.18 ± 27%      -0.1        0.10 ± 31%  perf-profile.children.cycles-pp.cpumask_any_but
      0.22 ±  4%      -0.1        0.15 ± 20%  perf-profile.children.cycles-pp.arch_scale_freq_tick
      0.10            -0.1        0.03 ±100%  perf-profile.children.cycles-pp.select_task_rq_fair
      0.15 ± 10%      -0.1        0.08 ± 17%  perf-profile.children.cycles-pp.rcu_dynticks_eqs_exit
      0.20            -0.1        0.14 ± 15%  perf-profile.children.cycles-pp.hrtimer_get_next_event
      0.08            -0.1        0.03 ±100%  perf-profile.children.cycles-pp.do_execveat_common
      0.08            -0.1        0.03 ±100%  perf-profile.children.cycles-pp.execve
      0.08            -0.1        0.03 ±100%  perf-profile.children.cycles-pp.__x64_sys_execve
      0.13 ±  7%      -0.1        0.08 ± 15%  perf-profile.children.cycles-pp.rcu_eqs_exit
      0.15 ±  3%      -0.0        0.11 ± 23%  perf-profile.children.cycles-pp.rcu_dynticks_eqs_enter
      0.12            -0.0        0.08 ± 16%  perf-profile.children.cycles-pp.call_cpuidle
      0.17 ± 15%      -0.0        0.12 ± 25%  perf-profile.children.cycles-pp.update_irq_load_avg
      0.12 ± 13%      -0.0        0.08 ± 24%  perf-profile.children.cycles-pp.rcu_eqs_enter
      0.08 ± 12%      -0.0        0.04 ± 60%  perf-profile.children.cycles-pp._cond_resched
      0.11 ±  4%      -0.0        0.07 ± 20%  perf-profile.children.cycles-pp.account_process_tick
      0.10            -0.0        0.07 ±  7%  perf-profile.children.cycles-pp.__x86_indirect_thunk_rax
      0.16 ± 18%      -0.0        0.13 ± 20%  perf-profile.children.cycles-pp.irqentry_enter
      0.14 ± 18%      -0.0        0.10 ± 28%  perf-profile.children.cycles-pp.rcu_nmi_enter
      0.07            -0.0        0.04 ± 58%  perf-profile.children.cycles-pp.get_cpu_device
      0.12 ±  4%      -0.0        0.10 ± 19%  perf-profile.children.cycles-pp.__update_load_avg_cfs_rq
      0.06            +0.0        0.09 ± 24%  perf-profile.children.cycles-pp.set_next_entity
      0.00            +0.1        0.05 ±  8%  perf-profile.children.cycles-pp.bio_associate_blkg
      0.00            +0.1        0.06 ± 14%  perf-profile.children.cycles-pp.blk_mq_get_tag
      0.00            +0.1        0.06 ± 11%  perf-profile.children.cycles-pp.blk_mq_start_request
      0.09 ± 17%      +0.1        0.15 ± 16%  perf-profile.children.cycles-pp.__mod_lruvec_state
      0.10 ± 10%      +0.1        0.16 ± 21%  perf-profile.children.cycles-pp.xas_init_marks
      0.00            +0.1        0.07 ± 39%  perf-profile.children.cycles-pp.scan_swap_map_slots
      0.00            +0.1        0.07 ± 12%  perf-profile.children.cycles-pp.__blk_mq_alloc_request
      0.00            +0.1        0.07 ± 33%  perf-profile.children.cycles-pp.bio_init
      0.14 ±  3%      +0.1        0.21 ± 24%  perf-profile.children.cycles-pp.rmqueue
      0.10 ±  5%      +0.1        0.17 ± 15%  perf-profile.children.cycles-pp.switch_mm_irqs_off
      0.00            +0.1        0.07 ± 34%  perf-profile.children.cycles-pp.__isolate_lru_page
      0.00            +0.1        0.07 ± 15%  perf-profile.children.cycles-pp.__perf_sw_event
      0.00            +0.1        0.07 ± 17%  perf-profile.children.cycles-pp.blk_throtl_bio
      0.00            +0.1        0.07 ± 42%  perf-profile.children.cycles-pp.map_swap_entry
      0.00            +0.1        0.08 ± 14%  perf-profile.children.cycles-pp.unlock_page
      0.03 ±100%      +0.1        0.11 ± 19%  perf-profile.children.cycles-pp.__switch_to
      0.00            +0.1        0.08 ± 23%  perf-profile.children.cycles-pp.get_swap_device
      0.08 ± 12%      +0.1        0.16 ± 28%  perf-profile.children.cycles-pp.__orc_find
      0.00            +0.1        0.08 ± 41%  perf-profile.children.cycles-pp.get_swap_pages
      0.00            +0.1        0.08 ± 34%  perf-profile.children.cycles-pp.page_mapping
      0.06            +0.1        0.14 ± 26%  perf-profile.children.cycles-pp.__list_del_entry_valid
      0.07 ± 20%      +0.1        0.16 ± 21%  perf-profile.children.cycles-pp.xas_clear_mark
      0.00            +0.1        0.09 ± 25%  perf-profile.children.cycles-pp.pagevec_move_tail
      0.00            +0.1        0.09 ± 26%  perf-profile.children.cycles-pp.swap_range_free
      0.00            +0.1        0.09 ± 27%  perf-profile.children.cycles-pp.xas_find
      0.03 ±100%      +0.1        0.12 ± 18%  perf-profile.children.cycles-pp.update_cfs_group
      0.00            +0.1        0.09 ± 31%  perf-profile.children.cycles-pp.free_unref_page_list
      0.00            +0.1        0.10 ± 55%  perf-profile.children.cycles-pp.mem_cgroup_charge_statistics
      0.00            +0.1        0.10 ± 37%  perf-profile.children.cycles-pp.blk_attempt_plug_merge
      0.00            +0.1        0.10 ± 19%  perf-profile.children.cycles-pp.___perf_sw_event
      0.09 ± 22%      +0.1        0.19 ± 13%  perf-profile.children.cycles-pp.__mod_node_page_state
      0.00            +0.1        0.10 ± 30%  perf-profile.children.cycles-pp.kernel_text_address
      0.03 ±100%      +0.1        0.13 ± 28%  perf-profile.children.cycles-pp.__kernel_text_address
      0.00            +0.1        0.11 ± 25%  perf-profile.children.cycles-pp.rmqueue_bulk
      0.00            +0.1        0.11 ± 23%  perf-profile.children.cycles-pp.page_lock_anon_vma_read
      0.00            +0.1        0.11 ± 30%  perf-profile.children.cycles-pp.rotate_reclaimable_page
      0.00            +0.1        0.11 ± 15%  perf-profile.children.cycles-pp.do_page_add_anon_rmap
      0.15 ± 10%      +0.1        0.27 ± 20%  perf-profile.children.cycles-pp.dequeue_entity
      0.06 ±  9%      +0.1        0.18 ± 23%  perf-profile.children.cycles-pp.__mod_memcg_state
      0.03 ±100%      +0.1        0.15 ± 28%  perf-profile.children.cycles-pp.unwind_get_return_address
      0.17 ±  5%      +0.1        0.30 ± 20%  perf-profile.children.cycles-pp.dequeue_task_fair
      0.00            +0.1        0.13 ± 49%  perf-profile.children.cycles-pp.page_swapcount
      0.17 ± 29%      +0.1        0.31 ± 11%  perf-profile.children.cycles-pp.__blk_mq_try_issue_directly
      0.10 ±  5%      +0.1        0.23 ± 31%  perf-profile.children.cycles-pp.tlb_is_not_lazy
      0.00            +0.1        0.14 ± 35%  perf-profile.children.cycles-pp.cgroup_throttle_swaprate
      0.12 ±  4%      +0.1        0.27 ± 20%  perf-profile.children.cycles-pp.__mod_memcg_lruvec_state
      0.00            +0.1        0.15 ± 56%  perf-profile.children.cycles-pp.swap_writepage
      0.00            +0.2        0.15 ± 15%  perf-profile.children.cycles-pp.workingset_refault
      0.06 ± 16%      +0.2        0.22 ± 32%  perf-profile.children.cycles-pp.cpumask_next
      0.00            +0.2        0.16 ± 30%  perf-profile.children.cycles-pp.__count_memcg_events
      0.03 ±100%      +0.2        0.19 ± 18%  perf-profile.children.cycles-pp.__pagevec_lru_add_fn
      0.09            +0.2        0.25 ± 21%  perf-profile.children.cycles-pp.__irqentry_text_start
      0.00            +0.2        0.16 ± 35%  perf-profile.children.cycles-pp.get_mem_cgroup_from_mm
      0.00            +0.2        0.16 ± 19%  perf-profile.children.cycles-pp.bio_alloc_bioset
      0.00            +0.2        0.17 ± 37%  perf-profile.children.cycles-pp.put_swap_page
      0.05            +0.2        0.22 ± 20%  perf-profile.children.cycles-pp.xas_start
      0.03 ±100%      +0.2        0.21 ± 15%  perf-profile.children.cycles-pp.swap_cgroup_record
      0.00            +0.2        0.18 ± 17%  perf-profile.children.cycles-pp.clear_shadow_from_swap_cache
      0.31            +0.2        0.50 ±  9%  perf-profile.children.cycles-pp.schedule_idle
      0.05            +0.2        0.24 ± 56%  perf-profile.children.cycles-pp.llist_add_batch
      0.05            +0.2        0.24 ± 19%  perf-profile.children.cycles-pp.submit_bio_checks
      0.00            +0.2        0.20 ± 33%  perf-profile.children.cycles-pp.end_swap_bio_write
      0.00            +0.2        0.20 ± 33%  perf-profile.children.cycles-pp.end_page_writeback
      0.03 ±100%      +0.2        0.22 ± 22%  perf-profile.children.cycles-pp.move_pages_to_lru
      0.03 ±100%      +0.2        0.22 ± 16%  perf-profile.children.cycles-pp.blk_mq_try_issue_directly
      0.31 ±  6%      +0.2        0.51 ± 27%  perf-profile.children.cycles-pp.unwind_next_frame
      0.00            +0.2        0.20 ± 17%  perf-profile.children.cycles-pp.__frontswap_load
      0.00            +0.2        0.20 ± 44%  perf-profile.children.cycles-pp.get_swap_page
      0.00            +0.2        0.20 ± 18%  perf-profile.children.cycles-pp.mem_cgroup_id_put_many
      0.00            +0.2        0.20 ± 71%  perf-profile.children.cycles-pp.default_send_IPI_mask_sequence_phys
      0.04 ±100%      +0.2        0.24 ± 38%  perf-profile.children.cycles-pp.try_charge
      0.00            +0.2        0.21 ± 43%  perf-profile.children.cycles-pp.mem_cgroup_swapout
      0.06 ±  9%      +0.2        0.27 ± 26%  perf-profile.children.cycles-pp.isolate_lru_pages
      0.32 ±  6%      +0.2        0.53 ± 32%  perf-profile.children.cycles-pp.flush_tlb_mm_range
      0.11 ± 23%      +0.2        0.32 ± 15%  perf-profile.children.cycles-pp.finish_task_switch
      0.10 ± 15%      +0.2        0.31 ± 44%  perf-profile.children.cycles-pp.prep_new_page
      0.00            +0.2        0.22 ± 26%  perf-profile.children.cycles-pp.up_read
      0.00            +0.2        0.23 ± 47%  perf-profile.children.cycles-pp._swap_info_get
      0.03 ±100%      +0.2        0.26 ± 10%  perf-profile.children.cycles-pp.__swp_swapcount
      0.00            +0.2        0.25 ± 17%  perf-profile.children.cycles-pp.lookup_swap_cgroup_id
      0.00            +0.2        0.25 ± 18%  perf-profile.children.cycles-pp.sync_regs
      0.24 ±  2%      +0.3        0.50 ± 26%  perf-profile.children.cycles-pp.pmdp_clear_flush_young
      0.07 ± 14%      +0.3        0.34 ± 20%  perf-profile.children.cycles-pp.pagevec_lru_move_fn
      0.31 ±  3%      +0.3        0.59 ± 34%  perf-profile.children.cycles-pp.get_page_from_freelist
      0.25 ±  4%      +0.3        0.53 ± 14%  perf-profile.children.cycles-pp.add_to_swap_cache
      0.21 ±  2%      +0.3        0.49 ± 40%  perf-profile.children.cycles-pp.add_to_swap
      0.30 ±  4%      +0.3        0.60 ± 10%  perf-profile.children.cycles-pp.total_mapcount
      0.50 ±  8%      +0.3        0.83 ± 27%  perf-profile.children.cycles-pp.stack_trace_save_tsk
      0.00            +0.3        0.34 ± 31%  perf-profile.children.cycles-pp.down_read_trylock
      0.00            +0.3        0.34 ± 22%  perf-profile.children.cycles-pp.get_swap_bio
      0.45 ±  8%      +0.3        0.80 ± 27%  perf-profile.children.cycles-pp.arch_stack_walk
      0.04 ±100%      +0.4        0.39 ± 30%  perf-profile.children.cycles-pp.lru_cache_add
      0.10 ± 30%      +0.4        0.46 ± 21%  perf-profile.children.cycles-pp.delete_from_swap_cache
      0.07 ±  7%      +0.4        0.43 ± 15%  perf-profile.children.cycles-pp.swapcache_free_entries
      0.07 ± 14%      +0.4        0.45 ± 16%  perf-profile.children.cycles-pp.free_swap_slot
      0.08 ± 12%      +0.4        0.47 ± 18%  perf-profile.children.cycles-pp.page_counter_cancel
      0.08 ±  6%      +0.4        0.47 ± 16%  perf-profile.children.cycles-pp.__swap_entry_free
      0.08 ± 12%      +0.4        0.48 ± 18%  perf-profile.children.cycles-pp.page_counter_uncharge
      0.11 ± 27%      +0.4        0.53 ± 19%  perf-profile.children.cycles-pp.reuse_swap_page
      0.12 ±  8%      +0.7        0.79 ± 16%  perf-profile.children.cycles-pp.mem_cgroup_uncharge_swap
      0.68 ±  2%      +0.7        1.38 ± 25%  perf-profile.children.cycles-pp.__account_scheduler_latency
      1.02 ±  5%      +0.7        1.74 ± 24%  perf-profile.children.cycles-pp.ttwu_do_activate
      1.60 ±  8%      +0.7        2.33 ± 15%  perf-profile.children.cycles-pp.__read_swap_cache_async
      1.00 ±  6%      +0.7        1.74 ± 24%  perf-profile.children.cycles-pp.enqueue_task_fair
      0.03 ±100%      +0.7        0.77 ± 10%  perf-profile.children.cycles-pp.shrink_active_list
      0.92 ±  5%      +0.8        1.69 ± 24%  perf-profile.children.cycles-pp.enqueue_entity
      1.21 ±  5%      +0.8        2.05 ± 25%  perf-profile.children.cycles-pp.try_to_wake_up
      0.23 ±  2%      +0.9        1.12 ± 19%  perf-profile.children.cycles-pp.page_vma_mapped_walk
      0.14 ±  3%      +0.9        1.03 ± 66%  perf-profile.children.cycles-pp.flush_smp_call_function_queue
      0.12 ±  4%      +0.9        1.05 ± 65%  perf-profile.children.cycles-pp.__sysvec_call_function
      0.15 ±  6%      +1.0        1.13 ± 64%  perf-profile.children.cycles-pp.sysvec_call_function
      0.03 ±100%      +1.1        1.12 ± 12%  perf-profile.children.cycles-pp.find_get_entry
      0.03 ±100%      +1.1        1.13 ± 12%  perf-profile.children.cycles-pp.pagecache_get_page
      0.03 ±100%      +1.1        1.15 ± 12%  perf-profile.children.cycles-pp.lookup_swap_cache
      0.10 ±  5%      +1.2        1.26 ± 13%  perf-profile.children.cycles-pp.xas_load
      1.65 ±  8%      +1.3        2.91 ± 20%  perf-profile.children.cycles-pp.nvme_irq
      0.33 ±  7%      +1.3        1.60 ±  9%  perf-profile.children.cycles-pp.page_referenced_one
      1.66 ±  8%      +1.3        2.94 ± 20%  perf-profile.children.cycles-pp.__handle_irq_event_percpu
      1.69 ±  9%      +1.3        3.01 ± 20%  perf-profile.children.cycles-pp.handle_irq_event_percpu
      0.25 ±  8%      +1.4        1.62 ± 21%  perf-profile.children.cycles-pp.mem_cgroup_charge
      1.71 ± 10%      +1.4        3.13 ± 20%  perf-profile.children.cycles-pp.handle_irq_event
      1.75 ± 10%      +1.5        3.21 ± 20%  perf-profile.children.cycles-pp.handle_edge_irq
      1.84 ± 10%      +1.5        3.36 ± 20%  perf-profile.children.cycles-pp.common_interrupt
      1.85 ± 10%      +1.6        3.40 ± 20%  perf-profile.children.cycles-pp.asm_common_interrupt
      0.50 ± 26%      +1.6        2.09 ± 38%  perf-profile.children.cycles-pp.arch_tlbbatch_flush
      0.43 ± 25%      +1.7        2.14 ± 24%  perf-profile.children.cycles-pp.end_swap_bio_read
      0.80 ± 11%      +1.7        2.53 ± 17%  perf-profile.children.cycles-pp.swap_readpage
      0.65 ±  6%      +1.7        2.38 ±  6%  perf-profile.children.cycles-pp.page_referenced
      0.81 ± 12%      +1.8        2.58 ± 35%  perf-profile.children.cycles-pp.on_each_cpu_cond_mask
      0.79 ± 11%      +1.8        2.56 ± 35%  perf-profile.children.cycles-pp.smp_call_function_many_cond
      0.17 ± 19%      +1.9        2.08 ± 38%  perf-profile.children.cycles-pp.try_to_unmap_flush_dirty
      0.54 ± 24%      +1.9        2.45 ± 21%  perf-profile.children.cycles-pp.blk_update_request
      0.59 ± 22%      +2.0        2.56 ± 21%  perf-profile.children.cycles-pp.blk_mq_end_request
      2.40            +2.5        4.86 ± 16%  perf-profile.children.cycles-pp.read_swap_cache_async
      2.41            +2.5        4.88 ± 16%  perf-profile.children.cycles-pp.swapin_readahead
      4.13            +4.2        8.33 ± 19%  perf-profile.children.cycles-pp.balance_pgdat
      4.13            +4.2        8.34 ± 19%  perf-profile.children.cycles-pp.kswapd
      2.71            +4.9        7.57 ± 15%  perf-profile.children.cycles-pp.do_swap_page
      6.35            -5.8        0.52 ± 52%  perf-profile.self.cycles-pp.clear_page_erms
      3.35            -2.9        0.45 ±  8%  perf-profile.self.cycles-pp.try_to_unmap_one
      5.09 ± 10%      -1.6        3.51 ± 12%  perf-profile.self.cycles-pp.ktime_get
      1.71 ±  3%      -1.5        0.18 ± 14%  perf-profile.self.cycles-pp.update_sd_lb_stats
      1.15            -1.1        0.04 ±104%  perf-profile.self.cycles-pp.clear_subpage
      0.81 ± 10%      -0.7        0.08 ± 10%  perf-profile.self.cycles-pp.idle_cpu
      1.83            -0.6        1.26 ± 13%  perf-profile.self.cycles-pp._raw_spin_lock
      1.55 ±  9%      -0.4        1.15 ±  7%  perf-profile.self.cycles-pp.timekeeping_max_deferment
      0.79            -0.3        0.45 ± 12%  perf-profile.self.cycles-pp.tick_nohz_next_event
      0.65 ±  7%      -0.3        0.36 ± 13%  perf-profile.self.cycles-pp.lapic_next_deadline
      0.85 ± 12%      -0.3        0.59 ± 17%  perf-profile.self.cycles-pp._raw_spin_trylock
      0.51 ±  9%      -0.2        0.29 ± 14%  perf-profile.self.cycles-pp.calc_global_load_tick
      0.83 ± 10%      -0.2        0.62 ± 20%  perf-profile.self.cycles-pp.ktime_get_update_offsets_now
      0.66            -0.2        0.46 ± 20%  perf-profile.self.cycles-pp.irqtime_account_irq
      0.28 ± 20%      -0.2        0.09 ± 17%  perf-profile.self.cycles-pp.nr_iowait_cpu
      0.26 ± 21%      -0.2        0.07 ± 12%  perf-profile.self.cycles-pp.update_rq_clock
      0.33 ±  7%      -0.2        0.15 ± 44%  perf-profile.self.cycles-pp.__softirqentry_text_start
      0.39 ±  2%      -0.2        0.21 ± 50%  perf-profile.self.cycles-pp.rcu_sched_clock_irq
      0.64            -0.2        0.48 ± 18%  perf-profile.self.cycles-pp.poll_idle
      0.29            -0.2        0.13 ± 25%  perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
      0.34 ±  4%      -0.1        0.20 ± 32%  perf-profile.self.cycles-pp.__intel_pmu_enable_all
      0.53 ± 10%      -0.1        0.39 ± 17%  perf-profile.self.cycles-pp.native_sched_clock
      0.33 ± 10%      -0.1        0.20 ±  5%  perf-profile.self.cycles-pp.tsc_verify_tsc_adjust
      0.21 ± 16%      -0.1        0.08 ±  8%  perf-profile.self.cycles-pp.xas_store
      0.19 ±  5%      -0.1        0.07 ±105%  perf-profile.self.cycles-pp.note_gp_changes
      0.34 ± 15%      -0.1        0.26 ± 17%  perf-profile.self.cycles-pp._find_next_bit
      0.15 ± 20%      -0.1        0.07 ± 58%  perf-profile.self.cycles-pp.io_serial_in
      0.15 ± 10%      -0.1        0.07 ± 17%  perf-profile.self.cycles-pp.___might_sleep
      0.22 ±  6%      -0.1        0.15 ± 20%  perf-profile.self.cycles-pp.arch_scale_freq_tick
      0.15 ± 10%      -0.1        0.08 ±  8%  perf-profile.self.cycles-pp.asm_sysvec_apic_timer_interrupt
      0.15 ±  3%      -0.1        0.08 ± 30%  perf-profile.self.cycles-pp.hrtimer_interrupt
      0.15 ± 10%      -0.1        0.09 ± 25%  perf-profile.self.cycles-pp.rebalance_domains
      0.14 ± 14%      -0.1        0.08 ± 17%  perf-profile.self.cycles-pp.rcu_dynticks_eqs_exit
      0.12 ± 21%      -0.1        0.05 ±  9%  perf-profile.self.cycles-pp.update_blocked_averages
      0.09            -0.1        0.03 ±102%  perf-profile.self.cycles-pp.load_balance
      0.09            -0.0        0.04 ± 63%  perf-profile.self.cycles-pp.rmqueue
      0.12            -0.0        0.08 ± 16%  perf-profile.self.cycles-pp.call_cpuidle
      0.09            -0.0        0.05 ± 62%  perf-profile.self.cycles-pp.rcu_idle_exit
      0.15            -0.0        0.11 ± 20%  perf-profile.self.cycles-pp.rcu_dynticks_eqs_enter
      0.17 ± 15%      -0.0        0.12 ± 25%  perf-profile.self.cycles-pp.update_irq_load_avg
      0.11 ±  4%      -0.0        0.07 ± 20%  perf-profile.self.cycles-pp.account_process_tick
      0.12 ± 13%      -0.0        0.08 ± 17%  perf-profile.self.cycles-pp.__hrtimer_run_queues
      0.12 ±  4%      -0.0        0.10 ± 17%  perf-profile.self.cycles-pp.__update_load_avg_cfs_rq
      0.07 ±  7%      -0.0        0.04 ± 57%  perf-profile.self.cycles-pp.get_cpu_device
      0.21 ±  2%      -0.0        0.18 ±  5%  perf-profile.self.cycles-pp.tick_sched_timer
      0.06 ±  9%      +0.0        0.09 ± 15%  perf-profile.self.cycles-pp.xas_create
      0.07 ±  7%      +0.1        0.12 ± 23%  perf-profile.self.cycles-pp.__delete_from_swap_cache
      0.07 ±  7%      +0.1        0.12 ± 17%  perf-profile.self.cycles-pp.switch_mm_irqs_off
      0.07 ± 14%      +0.1        0.13 ± 21%  perf-profile.self.cycles-pp.__mod_memcg_lruvec_state
      0.00            +0.1        0.07 ±  6%  perf-profile.self.cycles-pp.__blk_queue_split
      0.00            +0.1        0.07 ± 34%  perf-profile.self.cycles-pp.__isolate_lru_page
      0.00            +0.1        0.07 ± 10%  perf-profile.self.cycles-pp.do_page_add_anon_rmap
      0.00            +0.1        0.07 ± 26%  perf-profile.self.cycles-pp.get_swap_device
      0.00            +0.1        0.07 ± 17%  perf-profile.self.cycles-pp.unlock_page
      0.00            +0.1        0.07 ± 27%  perf-profile.self.cycles-pp.isolate_lru_pages
      0.00            +0.1        0.08 ± 34%  perf-profile.self.cycles-pp.page_mapping
      0.06            +0.1        0.14 ± 27%  perf-profile.self.cycles-pp.__list_del_entry_valid
      0.03 ±100%      +0.1        0.10 ± 18%  perf-profile.self.cycles-pp.__switch_to
      0.00            +0.1        0.08 ± 24%  perf-profile.self.cycles-pp.swap_cgroup_record
      0.00            +0.1        0.08 ± 19%  perf-profile.self.cycles-pp.___perf_sw_event
      0.08 ± 12%      +0.1        0.16 ± 28%  perf-profile.self.cycles-pp.__orc_find
      0.00            +0.1        0.08 ± 21%  perf-profile.self.cycles-pp.__pagevec_lru_add_fn
      0.00            +0.1        0.08 ± 10%  perf-profile.self.cycles-pp.__swp_swapcount
      0.07 ± 14%      +0.1        0.16 ± 21%  perf-profile.self.cycles-pp.xas_clear_mark
      0.03 ±100%      +0.1        0.12 ± 17%  perf-profile.self.cycles-pp.update_cfs_group
      0.00            +0.1        0.09 ± 46%  perf-profile.self.cycles-pp.get_swap_page
      0.09 ± 22%      +0.1        0.18 ± 13%  perf-profile.self.cycles-pp.__mod_node_page_state
      0.00            +0.1        0.10 ± 33%  perf-profile.self.cycles-pp.move_pages_to_lru
      0.06 ±  9%      +0.1        0.16 ± 21%  perf-profile.self.cycles-pp.nvme_irq
      0.00            +0.1        0.11 ± 32%  perf-profile.self.cycles-pp.do_swap_page
      0.06 ±  9%      +0.1        0.17 ± 21%  perf-profile.self.cycles-pp.__mod_memcg_state
      0.00            +0.1        0.13 ± 49%  perf-profile.self.cycles-pp.lru_cache_add
      0.09 ± 11%      +0.1        0.22 ± 28%  perf-profile.self.cycles-pp.tlb_is_not_lazy
      0.00            +0.1        0.13 ± 33%  perf-profile.self.cycles-pp.cgroup_throttle_swaprate
      0.03 ±100%      +0.1        0.16 ± 41%  perf-profile.self.cycles-pp.try_charge
      0.00            +0.1        0.15 ± 40%  perf-profile.self.cycles-pp.mem_cgroup_charge
      0.00            +0.1        0.15 ± 30%  perf-profile.self.cycles-pp.shrink_page_list
      0.00            +0.2        0.15 ± 34%  perf-profile.self.cycles-pp.get_mem_cgroup_from_mm
      0.12 ± 12%      +0.2        0.28 ± 10%  perf-profile.self.cycles-pp.__sched_text_start
      0.00            +0.2        0.16 ± 30%  perf-profile.self.cycles-pp.__count_memcg_events
      0.03 ±100%      +0.2        0.20 ± 22%  perf-profile.self.cycles-pp.xas_start
      0.00            +0.2        0.19 ± 16%  perf-profile.self.cycles-pp.__frontswap_load
      0.00            +0.2        0.19 ± 17%  perf-profile.self.cycles-pp.mem_cgroup_id_put_many
      0.00            +0.2        0.21 ± 28%  perf-profile.self.cycles-pp.up_read
      0.03 ±100%      +0.2        0.23 ± 57%  perf-profile.self.cycles-pp.llist_add_batch
      0.10 ± 15%      +0.2        0.31 ± 25%  perf-profile.self.cycles-pp.__account_scheduler_latency
      0.00            +0.2        0.22 ± 47%  perf-profile.self.cycles-pp._swap_info_get
      0.00            +0.2        0.24 ± 18%  perf-profile.self.cycles-pp.lookup_swap_cgroup_id
      0.00            +0.2        0.24 ± 18%  perf-profile.self.cycles-pp.sync_regs
      0.04 ±100%      +0.3        0.29 ± 17%  perf-profile.self.cycles-pp.__handle_mm_fault
      0.08 ±  6%      +0.3        0.33 ± 16%  perf-profile.self.cycles-pp.add_to_swap_cache
      0.00            +0.3        0.26 ± 22%  perf-profile.self.cycles-pp.finish_task_switch
      0.30 ±  3%      +0.3        0.58 ± 10%  perf-profile.self.cycles-pp.total_mapcount
      0.03 ±100%      +0.3        0.31 ± 15%  perf-profile.self.cycles-pp.swap_readpage
      0.00            +0.3        0.32 ± 31%  perf-profile.self.cycles-pp.down_read_trylock
      0.07 ± 20%      +0.3        0.41 ± 19%  perf-profile.self.cycles-pp.page_counter_cancel
      0.14 ± 11%      +0.8        0.97 ± 16%  perf-profile.self.cycles-pp.page_vma_mapped_walk
      0.03 ±100%      +1.0        1.00 ± 13%  perf-profile.self.cycles-pp.xas_load
      0.58 ± 19%      +1.0        1.62 ± 33%  perf-profile.self.cycles-pp.smp_call_function_many_cond
      0.18 ±  2%      +3.6        3.79 ± 82%  perf-profile.self.cycles-pp.do_access



***************************************************************************************************
lkp-hsw-4ex1: 144 threads Intel(R) Xeon(R) CPU E7-8890 v3 @ 2.50GHz with 512G memory
=========================================================================================
compiler/cpufreq_governor/kconfig/nr_pmem/nr_task/priority/rootfs/tbox_group/test/testcase/thp_defrag/thp_enabled/ucode:
  gcc-9/performance/x86_64-rhel-8.3/4/8/1/debian-10.4-x86_64-20200603.cgz/lkp-hsw-4ex1/swap-w-seq/vm-scalability/never/never/0x16

commit: 
  3852f6768e ("mm/swapcache: support to handle the shadow entries")
  aae466b005 ("mm/swap: implement workingset detection for anonymous LRU")

3852f6768ede542e aae466b0052e1888edd1d7f473d 
---------------- --------------------------- 
       fail:runs  %reproduction    fail:runs
           |             |             |    
          2:4            1%           2:4     perf-profile.children.cycles-pp.error_entry
          1:4            2%           2:4     perf-profile.self.cycles-pp.error_entry
         %stddev     %change         %stddev
             \          |                \  
     23.24 ±  3%      +8.6%      25.25        vm-scalability.free_time
    451459 ±  2%     +17.6%     531040 ±  2%  vm-scalability.median
   3613724 ±  2%     +17.2%    4233483 ±  2%  vm-scalability.throughput
    147.90 ±  2%     -11.1%     131.45 ±  2%  vm-scalability.time.elapsed_time
    147.90 ±  2%     -11.1%     131.45 ±  2%  vm-scalability.time.elapsed_time.max
    126092           -40.2%      75396 ±  5%  vm-scalability.time.involuntary_context_switches
    709.75            +3.4%     733.75        vm-scalability.time.percent_of_cpu_this_job_got
    858.01 ±  6%     -12.7%     748.79 ±  3%  vm-scalability.time.system_time
      2555 ± 11%     -86.5%     345.25 ± 19%  vm-scalability.time.voluntary_context_switches
      0.96 ± 22%     +23.2%       1.18 ±  2%  iostat.cpu.user
      0.46 ±  2%      -0.4        0.08 ±  6%  mpstat.cpu.all.soft%
  19058794 ± 73%     -51.3%    9284205 ±108%  numa-numastat.node2.numa_foreign
   1166704           +28.5%    1499626        vmstat.memory.cache
   2470874 ±  2%     +12.5%    2779610 ±  2%  vmstat.swap.so
      5097           -25.6%       3792 ±  3%  vmstat.system.cs
    775916 ±  6%     +15.8%     898759        vmstat.system.in
  3.27e+09 ±  3%      -9.3%  2.964e+09 ±  2%  perf-node.node-load-misses
 1.755e+09 ±  4%     -16.1%  1.473e+09 ±  9%  perf-node.node-loads
     40.00 ±  4%     -62.5%      15.00        perf-node.node-local-store-ratio
 2.337e+09 ±  2%     -39.6%  1.412e+09 ±  2%  perf-node.node-store-misses
 1.594e+09 ±  3%     -83.9%  2.563e+08 ±  2%  perf-node.node-stores
  11725373           +15.5%   13547085 ±  6%  meminfo.DirectMap2M
    179916          +187.0%     516441        meminfo.KReclaimable
   1116912 ±  5%     +19.9%    1339332 ±  4%  meminfo.MemAvailable
    179916          +187.0%     516441        meminfo.SReclaimable
    413707           +80.4%     746239        meminfo.Slab
    218196 ±  2%     +12.4%     245320 ±  2%  meminfo.max_used_kB
     11422 ± 11%    +182.9%      32315 ± 25%  numa-vmstat.node0.nr_slab_reclaimable
     30123           +11.0%      33440 ±  4%  numa-vmstat.node1.nr_page_table_pages
     11318 ± 10%    +187.6%      32549 ± 15%  numa-vmstat.node1.nr_slab_reclaimable
  14498502           +11.0%   16097678 ±  4%  numa-vmstat.node1.nr_vmscan_write
  14498504           +11.0%   16097680 ±  4%  numa-vmstat.node1.nr_written
      2099 ± 74%     -67.5%     681.25 ± 58%  numa-vmstat.node2.nr_active_anon
     11274 ± 13%    +172.3%      30698 ± 11%  numa-vmstat.node2.nr_slab_reclaimable
      2101 ± 74%     -67.6%     681.50 ± 58%  numa-vmstat.node2.nr_zone_active_anon
  11491764 ± 72%     -54.4%    5245129 ±107%  numa-vmstat.node2.numa_foreign
     10784 ±  7%    +210.9%      33532 ±  6%  numa-vmstat.node3.nr_slab_reclaimable
      6117 ±  6%     -15.4%       5175 ±  2%  slabinfo.files_cache.active_objs
      6124 ±  5%     -15.5%       5175 ±  2%  slabinfo.files_cache.num_objs
      1269 ±  3%     +21.3%       1539 ±  5%  slabinfo.khugepaged_mm_slot.active_objs
      1269 ±  3%     +21.3%       1539 ±  5%  slabinfo.khugepaged_mm_slot.num_objs
     12779 ±  3%     -15.2%      10839 ±  4%  slabinfo.pde_opener.active_objs
     12779 ±  3%     -15.2%      10839 ±  4%  slabinfo.pde_opener.num_objs
    166610 ±  2%    +352.8%     754410        slabinfo.radix_tree_node.active_objs
      3337 ±  3%    +318.4%      13961        slabinfo.radix_tree_node.active_slabs
    167671 ±  2%    +366.3%     781839        slabinfo.radix_tree_node.num_objs
      3337 ±  3%    +318.4%      13961        slabinfo.radix_tree_node.num_slabs
      3109 ±  4%     -10.4%       2785        slabinfo.sighand_cache.active_objs
      3131 ±  4%     -10.4%       2807 ±  2%  slabinfo.sighand_cache.num_objs
      8020 ±  4%     -12.5%       7021 ±  2%  slabinfo.task_delay_info.active_objs
      8020 ±  4%     -12.5%       7021 ±  2%  slabinfo.task_delay_info.num_objs
     45388 ± 11%    +184.5%     129110 ± 25%  numa-meminfo.node0.KReclaimable
     45388 ± 11%    +184.5%     129110 ± 25%  numa-meminfo.node0.SReclaimable
    114445 ± 14%     +74.5%     199762 ± 18%  numa-meminfo.node0.Slab
     45359 ±  9%    +187.0%     130162 ± 15%  numa-meminfo.node1.KReclaimable
    120458           +11.0%     133695 ±  4%  numa-meminfo.node1.PageTables
     45359 ±  9%    +187.0%     130162 ± 15%  numa-meminfo.node1.SReclaimable
    109895 ± 16%     +71.3%     188201 ± 13%  numa-meminfo.node1.Slab
      8457 ± 73%     -67.5%       2751 ± 59%  numa-meminfo.node2.Active
      8389 ± 74%     -67.5%       2726 ± 58%  numa-meminfo.node2.Active(anon)
     45582 ± 13%    +169.3%     122741 ± 11%  numa-meminfo.node2.KReclaimable
     45582 ± 13%    +169.3%     122741 ± 11%  numa-meminfo.node2.SReclaimable
     97401 ± 13%     +73.7%     169199 ±  6%  numa-meminfo.node2.Slab
     43179 ±  6%    +210.4%     134010 ±  6%  numa-meminfo.node3.KReclaimable
     43179 ±  6%    +210.4%     134010 ±  6%  numa-meminfo.node3.SReclaimable
     91559 ±  9%    +106.1%     188662 ±  8%  numa-meminfo.node3.Slab
  20729509 ± 16%  -7.8e+06    12912354 ± 25%  syscalls.sys_close.noise.100%
  28960042 ± 11%  -8.2e+06    20719899 ± 14%  syscalls.sys_close.noise.2%
  27766391 ± 11%  -8.4e+06    19401559 ± 15%  syscalls.sys_close.noise.25%
  28908895 ± 11%  -8.2e+06    20661833 ± 14%  syscalls.sys_close.noise.5%
  25426814 ± 13%  -8.5e+06    16899949 ± 18%  syscalls.sys_close.noise.50%
  22869034 ± 14%    -8e+06    14822779 ± 21%  syscalls.sys_close.noise.75%
  32447789 ± 25%     -69.7%    9828013 ± 98%  syscalls.sys_openat.max
 1.654e+09 ± 39%  -1.4e+09   2.337e+08 ± 39%  syscalls.sys_openat.noise.100%
 1.706e+09 ± 38%  -1.4e+09   2.834e+08 ± 32%  syscalls.sys_openat.noise.2%
 1.693e+09 ± 38%  -1.4e+09   2.712e+08 ± 34%  syscalls.sys_openat.noise.25%
 1.706e+09 ± 38%  -1.4e+09   2.829e+08 ± 32%  syscalls.sys_openat.noise.5%
 1.678e+09 ± 38%  -1.4e+09   2.548e+08 ± 36%  syscalls.sys_openat.noise.50%
 1.667e+09 ± 39%  -1.4e+09   2.438e+08 ± 38%  syscalls.sys_openat.noise.75%
      1174 ± 22%     +53.6%       1803 ±  5%  syscalls.sys_write.med
 5.911e+08 ± 64%    +2e+09   2.555e+09 ±  2%  syscalls.sys_write.noise.100%
 6.002e+08 ± 63%    +2e+09    2.56e+09 ±  2%  syscalls.sys_write.noise.2%
 5.985e+08 ± 64%    +2e+09   2.559e+09 ±  2%  syscalls.sys_write.noise.25%
 6.002e+08 ± 63%    +2e+09    2.56e+09 ±  2%  syscalls.sys_write.noise.5%
 5.953e+08 ± 64%    +2e+09   2.558e+09 ±  2%  syscalls.sys_write.noise.50%
  5.93e+08 ± 64%    +2e+09   2.557e+09 ±  2%  syscalls.sys_write.noise.75%
     52505 ±  2%      +8.7%      57048 ±  4%  proc-vmstat.allocstall_movable
   1329701 ± 53%     -76.6%     311376 ± 84%  proc-vmstat.compact_daemon_migrate_scanned
      3092 ±104%     -98.4%      48.75 ± 73%  proc-vmstat.compact_daemon_wake
     91.25 ± 12%     -83.0%      15.50 ± 39%  proc-vmstat.compact_fail
   1470217 ± 46%     -68.7%     459729 ± 57%  proc-vmstat.compact_migrate_scanned
     97.50 ± 13%     -81.3%      18.25 ± 32%  proc-vmstat.compact_stall
      3161 ± 98%     -96.3%     117.50 ± 72%  proc-vmstat.kswapd_low_wmark_hit_quickly
   5191554            -2.4%    5065321        proc-vmstat.nr_anon_pages
   5184927            -2.4%    5059469        proc-vmstat.nr_inactive_anon
    187.75 ±  4%      -9.1%     170.75        proc-vmstat.nr_isolated_anon
    111810            +1.6%     113619        proc-vmstat.nr_page_table_pages
     44657          +188.9%     129025        proc-vmstat.nr_slab_reclaimable
     58446            -1.7%      57450        proc-vmstat.nr_slab_unreclaimable
   5183621            -2.4%    5059220        proc-vmstat.nr_zone_inactive_anon
  56750562 ± 10%     -26.1%   41935745 ± 19%  proc-vmstat.numa_pte_updates
   1625054 ±  9%    -100.0%       0.00        proc-vmstat.pgalloc_dma
   8718205 ±  6%     -40.3%    5207463 ± 26%  proc-vmstat.pgalloc_dma32
 1.346e+08           -30.0%   94227189        proc-vmstat.pgalloc_normal
 1.451e+08           -31.4%   99498336        proc-vmstat.pgfree
     63642 ±  3%      -7.3%      59028 ±  5%  proc-vmstat.slabs_scanned
    456.00 ±127%    +223.0%       1473 ± 21%  proc-vmstat.swap_ra
    345.00 ±165%    +286.0%       1331 ± 20%  proc-vmstat.swap_ra_hit
    621120 ±  3%     -12.0%     546816 ±  2%  proc-vmstat.unevictable_pgs_scanned
  5.92e+09 ±  3%      +6.5%  6.304e+09        perf-stat.i.branch-instructions
  61633368 ±  2%     -24.6%   46490910        perf-stat.i.cache-misses
      5041           -26.5%       3706 ±  3%  perf-stat.i.context-switches
    388.19           -23.9%     295.51        perf-stat.i.cpu-migrations
    809.81 ±  8%     +21.0%     980.06 ±  7%  perf-stat.i.cycles-between-cache-misses
 6.351e+09            +6.7%  6.776e+09 ±  2%  perf-stat.i.dTLB-loads
      0.15 ±  5%      +0.0        0.18 ±  5%  perf-stat.i.dTLB-store-miss-rate%
 3.606e+09 ±  3%      -7.4%  3.339e+09 ±  2%  perf-stat.i.dTLB-stores
   6823772 ±  5%     +14.2%    7794812 ±  8%  perf-stat.i.iTLB-load-misses
   2.4e+10 ±  3%      +4.7%  2.513e+10        perf-stat.i.instructions
    112.11            +3.1%     115.57        perf-stat.i.metric.M/sec
    666516 ±  2%     +12.5%     749805 ±  2%  perf-stat.i.minor-faults
     61.38 ±  2%     +20.6       82.01        perf-stat.i.node-store-miss-rate%
  15267649 ±  4%     -25.5%   11374283 ± 10%  perf-stat.i.node-store-misses
  10435945 ±  6%     -79.8%    2104898 ± 10%  perf-stat.i.node-stores
    666572 ±  2%     +12.5%     749872 ±  2%  perf-stat.i.page-faults
    659.86 ±  6%     +28.5%     848.20 ±  6%  perf-stat.overall.cycles-between-cache-misses
      0.16 ±  3%      +0.0        0.20 ±  3%  perf-stat.overall.dTLB-store-miss-rate%
     59.26 ±  2%     +25.0       84.28        perf-stat.overall.node-store-miss-rate%
      8026            -6.9%       7474        perf-stat.overall.path-length
 5.902e+09 ±  3%      +6.3%  6.274e+09        perf-stat.ps.branch-instructions
  61374057 ±  2%     -24.7%   46230779        perf-stat.ps.cache-misses
      5019           -26.6%       3682 ±  3%  perf-stat.ps.context-switches
    386.19           -24.1%     293.29        perf-stat.ps.cpu-migrations
 6.332e+09            +6.5%  6.744e+09 ±  2%  perf-stat.ps.dTLB-loads
 3.595e+09 ±  3%      -7.6%  3.323e+09 ±  2%  perf-stat.ps.dTLB-stores
   6808353 ±  5%     +14.1%    7769606 ±  8%  perf-stat.ps.iTLB-load-misses
 2.392e+10 ±  2%      +4.6%  2.502e+10        perf-stat.ps.instructions
    666070 ±  2%     +12.2%     747635 ±  2%  perf-stat.ps.minor-faults
  15144045 ±  4%     -25.7%   11246617 ± 10%  perf-stat.ps.node-store-misses
  10417852 ±  6%     -79.9%    2096205 ± 10%  perf-stat.ps.node-stores
    666126 ±  2%     +12.2%     747701 ±  2%  perf-stat.ps.page-faults
 3.555e+12            -6.8%  3.311e+12        perf-stat.total.instructions
     12185 ±  8%    +182.0%      34361 ±  8%  sched_debug.cfs_rq:/.exec_clock.max
      1188 ± 14%     -98.8%      13.90 ± 53%  sched_debug.cfs_rq:/.exec_clock.min
      2713 ± 12%    +171.7%       7373 ±  8%  sched_debug.cfs_rq:/.exec_clock.stddev
    158216 ± 20%     -27.7%     114407 ± 17%  sched_debug.cfs_rq:/.load.stddev
     43.24 ± 15%     -23.4%      33.11 ± 19%  sched_debug.cfs_rq:/.load_avg.avg
      1022 ±  3%     -28.2%     733.92 ±  3%  sched_debug.cfs_rq:/.load_avg.max
    170.08 ±  8%     -25.7%     126.42 ±  9%  sched_debug.cfs_rq:/.load_avg.stddev
    119278 ± 11%    +110.4%     250918 ±  6%  sched_debug.cfs_rq:/.min_vruntime.max
     23859 ± 13%    +115.1%      51319 ± 14%  sched_debug.cfs_rq:/.min_vruntime.stddev
      0.06 ± 48%     -42.5%       0.04 ± 11%  sched_debug.cfs_rq:/.nr_spread_over.avg
      0.23 ± 26%     -32.0%       0.16 ±  8%  sched_debug.cfs_rq:/.nr_spread_over.stddev
    -50753          +175.6%    -139895        sched_debug.cfs_rq:/.spread0.avg
    -83164          +122.8%    -185253        sched_debug.cfs_rq:/.spread0.min
     23868 ± 13%    +115.0%      51318 ± 14%  sched_debug.cfs_rq:/.spread0.stddev
    140364 ± 14%     +23.7%     173587 ±  4%  sched_debug.cpu.avg_idle.stddev
    678.88 ±  4%     +20.0%     814.72 ±  5%  sched_debug.cpu.clock_task.stddev
      0.00 ± 26%    +566.5%       0.00 ± 91%  sched_debug.cpu.next_balance.stddev
      3913           -17.4%       3233 ±  2%  sched_debug.cpu.nr_switches.avg
     14639 ± 12%     +55.0%      22684 ± 19%  sched_debug.cpu.nr_switches.max
      1791 ±  8%     -37.4%       1121 ±  7%  sched_debug.cpu.nr_switches.min
      2060 ±  8%     +27.8%       2633 ±  6%  sched_debug.cpu.nr_switches.stddev
      2394 ±  2%     -28.3%       1716 ±  5%  sched_debug.cpu.sched_count.avg
     10139 ± 24%     +79.3%      18179 ± 24%  sched_debug.cpu.sched_count.max
    961.92 ± 11%     -54.9%     434.25        sched_debug.cpu.sched_count.min
      1375 ± 14%     +47.3%       2025 ± 10%  sched_debug.cpu.sched_count.stddev
    626.15 ±  4%     -19.1%     506.24 ±  5%  sched_debug.cpu.sched_goidle.avg
      4252 ± 25%    +109.7%       8919 ± 24%  sched_debug.cpu.sched_goidle.max
    277.58 ± 11%     -63.6%     101.00 ±  4%  sched_debug.cpu.sched_goidle.min
    554.97 ±  9%     +71.0%     949.07 ± 11%  sched_debug.cpu.sched_goidle.stddev
      1105 ±  2%     -30.2%     771.36 ±  4%  sched_debug.cpu.ttwu_count.avg
      4824 ± 23%     +89.2%       9126 ± 21%  sched_debug.cpu.ttwu_count.max
    364.25 ± 13%     -61.1%     141.83        sched_debug.cpu.ttwu_count.min
    727.66 ±  8%     +44.9%       1054 ±  8%  sched_debug.cpu.ttwu_count.stddev
    754.79           -25.7%     560.55 ±  5%  sched_debug.cpu.ttwu_local.avg
      1844 ±  5%     +94.2%       3581 ± 25%  sched_debug.cpu.ttwu_local.max
    281.33 ± 10%     -50.5%     139.25        sched_debug.cpu.ttwu_local.min
    338.12 ± 10%     +70.6%     576.68 ±  5%  sched_debug.cpu.ttwu_local.stddev
      4.68 ±  4%      -4.0        0.73 ± 44%  perf-profile.calltrace.cycles-pp.add_to_swap_cache.add_to_swap.shrink_page_list.shrink_inactive_list.shrink_lruvec
      6.00 ±  4%      -3.2        2.75 ± 13%  perf-profile.calltrace.cycles-pp.add_to_swap.shrink_page_list.shrink_inactive_list.shrink_lruvec.shrink_node
      1.82 ± 15%      -1.5        0.28 ±100%  perf-profile.calltrace.cycles-pp.prep_new_page.get_page_from_freelist.__alloc_pages_nodemask.alloc_pages_vma.do_anonymous_page
      1.74 ±  5%      -1.4        0.29 ±100%  perf-profile.calltrace.cycles-pp.__delete_from_swap_cache.__remove_mapping.shrink_page_list.shrink_inactive_list.shrink_lruvec
      2.55 ± 11%      -1.4        1.16 ± 12%  perf-profile.calltrace.cycles-pp.get_page_from_freelist.__alloc_pages_nodemask.alloc_pages_vma.do_anonymous_page.__handle_mm_fault
      1.44 ± 15%      -1.0        0.47 ±106%  perf-profile.calltrace.cycles-pp.do_softirq_own_stack.irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state
      1.43 ± 16%      -1.0        0.47 ±106%  perf-profile.calltrace.cycles-pp.__softirqentry_text_start.asm_call_on_stack.do_softirq_own_stack.irq_exit_rcu.sysvec_apic_timer_interrupt
      1.43 ± 16%      -1.0        0.47 ±106%  perf-profile.calltrace.cycles-pp.asm_call_on_stack.do_softirq_own_stack.irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      1.55 ± 16%      -0.8        0.70 ± 68%  perf-profile.calltrace.cycles-pp.irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter
      2.10 ± 15%      -0.5        1.61 ± 12%  perf-profile.calltrace.cycles-pp.mem_cgroup_charge.do_anonymous_page.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
      2.12 ±  8%      +0.4        2.52 ± 10%  perf-profile.calltrace.cycles-pp.end_page_writeback.pmem_rw_page.bdev_write_page.__swap_writepage.pageout
      2.13 ±  5%      +0.4        2.58 ± 11%  perf-profile.calltrace.cycles-pp.try_to_unmap_one.rmap_walk_anon.try_to_unmap.shrink_page_list.shrink_inactive_list
      0.95 ± 26%      +0.5        1.47 ± 13%  perf-profile.calltrace.cycles-pp.swap_writepage.pageout.shrink_page_list.shrink_inactive_list.shrink_lruvec
      1.28 ±  4%      +0.5        1.81 ± 14%  perf-profile.calltrace.cycles-pp.page_counter_uncharge.mem_cgroup_swapout.__remove_mapping.shrink_page_list.shrink_inactive_list
      1.27 ±  4%      +0.5        1.80 ± 14%  perf-profile.calltrace.cycles-pp.page_counter_cancel.page_counter_uncharge.mem_cgroup_swapout.__remove_mapping.shrink_page_list
      0.54 ± 71%      +0.9        1.41 ± 10%  perf-profile.calltrace.cycles-pp.__test_set_page_writeback.bdev_write_page.__swap_writepage.pageout.shrink_page_list
      2.52 ±  5%      +0.9        3.44 ± 14%  perf-profile.calltrace.cycles-pp.mem_cgroup_swapout.__remove_mapping.shrink_page_list.shrink_inactive_list.shrink_lruvec
      5.49 ±  4%      -4.8        0.69 ± 44%  perf-profile.children.cycles-pp.__softirqentry_text_start
      4.76 ±  4%      -3.7        1.09 ± 12%  perf-profile.children.cycles-pp.add_to_swap_cache
      3.74 ±  5%      -3.6        0.16 ± 19%  perf-profile.children.cycles-pp.xas_create_range
      3.74 ±  5%      -3.5        0.27 ± 15%  perf-profile.children.cycles-pp.xas_create
      6.06 ±  4%      -3.3        2.77 ± 13%  perf-profile.children.cycles-pp.add_to_swap
      2.32 ± 11%      -1.6        0.70 ± 44%  perf-profile.children.cycles-pp.do_softirq_own_stack
      2.61 ± 11%      -1.6        1.04 ± 35%  perf-profile.children.cycles-pp.irq_exit_rcu
      5.20 ± 11%      -1.5        3.68 ± 11%  perf-profile.children.cycles-pp.get_page_from_freelist
      3.78 ± 14%      -1.3        2.45 ± 12%  perf-profile.children.cycles-pp.prep_new_page
      3.61 ± 14%      -1.3        2.32 ± 12%  perf-profile.children.cycles-pp.clear_page_erms
      1.21 ±  7%      -1.0        0.21 ± 20%  perf-profile.children.cycles-pp.xas_store
      1.75 ±  5%      -0.9        0.86 ± 13%  perf-profile.children.cycles-pp.__delete_from_swap_cache
      2.17 ± 14%      -0.5        1.63 ± 12%  perf-profile.children.cycles-pp.mem_cgroup_charge
      0.61 ± 17%      -0.5        0.15 ± 25%  perf-profile.children.cycles-pp.worker_thread
      0.58 ± 19%      -0.4        0.13 ± 24%  perf-profile.children.cycles-pp.process_one_work
      0.82 ±  7%      -0.3        0.56 ± 10%  perf-profile.children.cycles-pp.rmqueue
      0.75 ± 13%      -0.2        0.52 ±  8%  perf-profile.children.cycles-pp.mem_cgroup_charge_statistics
      0.55 ±  6%      -0.2        0.37 ± 11%  perf-profile.children.cycles-pp.free_pcppages_bulk
      0.77 ± 13%      -0.2        0.59 ±  5%  perf-profile.children.cycles-pp.__count_memcg_events
      0.19 ± 30%      -0.1        0.04 ± 58%  perf-profile.children.cycles-pp.__libc_fork
      0.48 ± 13%      -0.1        0.34 ± 13%  perf-profile.children.cycles-pp.try_charge
      0.36 ± 13%      -0.1        0.23 ± 14%  perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.34 ± 12%      -0.1        0.22 ± 13%  perf-profile.children.cycles-pp.do_syscall_64
      0.15 ± 22%      -0.1        0.03 ±100%  perf-profile.children.cycles-pp.__do_sys_clone
      0.15 ± 22%      -0.1        0.03 ±100%  perf-profile.children.cycles-pp._do_fork
      0.21 ±  7%      -0.1        0.11 ± 23%  perf-profile.children.cycles-pp.drm_fb_helper_dirty_work
      0.35 ±  5%      -0.1        0.27 ± 13%  perf-profile.children.cycles-pp.rmqueue_bulk
      0.15 ± 14%      -0.1        0.09 ± 23%  perf-profile.children.cycles-pp.drm_atomic_helper_dirtyfb
      0.15 ± 14%      -0.1        0.09 ± 23%  perf-profile.children.cycles-pp.memcpy_toio
      0.15 ± 14%      -0.1        0.09 ± 23%  perf-profile.children.cycles-pp.drm_atomic_helper_commit
      0.15 ± 14%      -0.1        0.09 ± 23%  perf-profile.children.cycles-pp.commit_tail
      0.15 ± 14%      -0.1        0.09 ± 23%  perf-profile.children.cycles-pp.drm_atomic_helper_commit_tail
      0.15 ± 14%      -0.1        0.09 ± 23%  perf-profile.children.cycles-pp.drm_atomic_helper_commit_planes
      0.15 ± 14%      -0.1        0.09 ± 23%  perf-profile.children.cycles-pp.mgag200_simple_display_pipe_update
      0.15 ± 14%      -0.1        0.09 ± 23%  perf-profile.children.cycles-pp.mgag200_handle_damage
      0.15 ± 14%      -0.1        0.09 ± 23%  perf-profile.children.cycles-pp.drm_fb_memcpy_dstclip
      0.10 ±  8%      -0.0        0.06 ± 14%  perf-profile.children.cycles-pp.schedule
      0.08 ± 19%      +0.0        0.11 ± 12%  perf-profile.children.cycles-pp.get_next_timer_interrupt
      0.14 ±  3%      +0.0        0.17 ± 10%  perf-profile.children.cycles-pp.default_send_IPI_single_phys
      0.12 ±  3%      +0.0        0.16 ±  9%  perf-profile.children.cycles-pp.scan_swap_map_try_ssd_cluster
      0.10 ± 11%      +0.0        0.14 ±  3%  perf-profile.children.cycles-pp.inc_node_page_state
      0.03 ±102%      +0.0        0.08 ±  6%  perf-profile.children.cycles-pp.arch_cpu_idle_enter
      0.03 ±102%      +0.0        0.08 ±  6%  perf-profile.children.cycles-pp.tsc_verify_tsc_adjust
      0.13 ± 11%      +0.0        0.18 ± 14%  perf-profile.children.cycles-pp.cpumask_any_but
      0.23 ±  8%      +0.1        0.29 ± 10%  perf-profile.children.cycles-pp.scan_swap_map_slots
      0.15 ± 12%      +0.1        0.23 ±  7%  perf-profile.children.cycles-pp.lock_page_memcg
      0.31 ±  5%      +0.1        0.39 ±  8%  perf-profile.children.cycles-pp.test_clear_page_writeback
      0.29 ±  6%      +0.1        0.38 ± 11%  perf-profile.children.cycles-pp.get_swap_pages
      0.37 ±  7%      +0.1        0.46 ± 16%  perf-profile.children.cycles-pp.llist_reverse_order
      0.39 ±  8%      +0.1        0.52 ± 11%  perf-profile.children.cycles-pp.tlb_is_not_lazy
      0.35 ±  8%      +0.1        0.48 ± 14%  perf-profile.children.cycles-pp.zswap_frontswap_store
      0.45 ±  2%      +0.2        0.63 ± 14%  perf-profile.children.cycles-pp.page_swapcount
      0.49 ±  3%      +0.2        0.67 ± 14%  perf-profile.children.cycles-pp.try_to_free_swap
      0.82 ±  4%      +0.2        1.01 ± 11%  perf-profile.children.cycles-pp.put_swap_page
      0.55 ±  9%      +0.2        0.79 ± 14%  perf-profile.children.cycles-pp.__frontswap_store
      0.81 ±  6%      +0.3        1.07 ± 13%  perf-profile.children.cycles-pp.get_swap_page
      0.62 ±  7%      +0.3        0.89 ± 17%  perf-profile.children.cycles-pp.page_swap_info
      0.58 ±  8%      +0.3        0.85 ± 17%  perf-profile.children.cycles-pp.swap_set_page_dirty
      2.18 ±  8%      +0.4        2.56 ± 10%  perf-profile.children.cycles-pp.end_page_writeback
      1.05 ±  3%      +0.4        1.45 ± 11%  perf-profile.children.cycles-pp._swap_info_get
      1.04 ±  5%      +0.4        1.44 ± 11%  perf-profile.children.cycles-pp.__test_set_page_writeback
      1.07 ±  6%      +0.4        1.48 ± 13%  perf-profile.children.cycles-pp.swap_writepage
      2.17 ±  5%      +0.4        2.61 ± 11%  perf-profile.children.cycles-pp.try_to_unmap_one
      2.23 ±  5%      +0.5        2.71 ± 15%  perf-profile.children.cycles-pp.__sysvec_call_function_single
      2.52 ±  6%      +0.5        3.05 ± 15%  perf-profile.children.cycles-pp.sysvec_call_function_single
      1.30 ±  4%      +0.5        1.83 ± 14%  perf-profile.children.cycles-pp.page_counter_uncharge
      1.29 ±  4%      +0.5        1.82 ± 14%  perf-profile.children.cycles-pp.page_counter_cancel
      2.56 ±  5%      +0.9        3.46 ± 14%  perf-profile.children.cycles-pp.mem_cgroup_swapout
      3.38 ± 13%      -1.2        2.17 ± 12%  perf-profile.self.cycles-pp.clear_page_erms
      0.77 ± 13%      -0.2        0.59 ±  5%  perf-profile.self.cycles-pp.__count_memcg_events
      0.22 ±  8%      -0.1        0.08 ± 15%  perf-profile.self.cycles-pp.xas_store
      0.32 ± 15%      -0.1        0.18 ± 12%  perf-profile.self.cycles-pp.try_charge
      0.34 ±  9%      -0.1        0.22 ±  9%  perf-profile.self.cycles-pp.mem_cgroup_charge
      0.35 ±  7%      -0.1        0.24 ± 17%  perf-profile.self.cycles-pp.xas_create
      0.11 ± 10%      -0.1        0.04 ± 58%  perf-profile.self.cycles-pp.smp_call_function_many_cond
      0.18 ±  4%      -0.0        0.13 ± 16%  perf-profile.self.cycles-pp.rmqueue_bulk
      0.13 ± 13%      -0.0        0.09 ± 13%  perf-profile.self.cycles-pp.rmqueue
      0.12 ± 15%      -0.0        0.08 ± 14%  perf-profile.self.cycles-pp.page_remove_rmap
      0.15 ± 15%      -0.0        0.12 ± 21%  perf-profile.self.cycles-pp.prep_new_page
      0.09 ± 13%      +0.0        0.12 ±  3%  perf-profile.self.cycles-pp.inc_node_page_state
      0.05 ± 58%      +0.0        0.08 ±  8%  perf-profile.self.cycles-pp.scan_swap_map_slots
      0.01 ±173%      +0.0        0.05 ±  9%  perf-profile.self.cycles-pp.dec_zone_page_state
      0.01 ±173%      +0.0        0.05 ±  9%  perf-profile.self.cycles-pp.mutex_unlock
      0.01 ±173%      +0.0        0.06 ± 20%  perf-profile.self.cycles-pp.irqtime_account_process_tick
      0.13 ± 11%      +0.1        0.19 ± 16%  perf-profile.self.cycles-pp.mem_cgroup_swapout
      0.08 ± 15%      +0.1        0.15 ± 14%  perf-profile.self.cycles-pp.arch_tlbbatch_flush
      0.15 ± 11%      +0.1        0.21 ± 10%  perf-profile.self.cycles-pp.lock_page_memcg
      0.37 ±  7%      +0.1        0.46 ± 16%  perf-profile.self.cycles-pp.llist_reverse_order
      0.18 ± 15%      +0.1        0.28 ± 13%  perf-profile.self.cycles-pp.__frontswap_store
      0.57            +0.1        0.67 ± 11%  perf-profile.self.cycles-pp.__delete_from_swap_cache
      0.60 ±  5%      +0.1        0.70 ± 12%  perf-profile.self.cycles-pp.add_to_swap_cache
      0.33 ±  7%      +0.1        0.45 ± 13%  perf-profile.self.cycles-pp.zswap_frontswap_store
      0.45 ±  2%      +0.1        0.57 ± 14%  perf-profile.self.cycles-pp.flush_tlb_func_common
      0.38 ±  7%      +0.1        0.52 ± 13%  perf-profile.self.cycles-pp.get_swap_page
      0.74 ±  3%      +0.2        0.91 ± 10%  perf-profile.self.cycles-pp.try_to_unmap_one
      0.57 ±  9%      +0.2        0.81 ± 16%  perf-profile.self.cycles-pp.page_swap_info
      0.72 ±  3%      +0.3        1.03 ± 11%  perf-profile.self.cycles-pp.__test_set_page_writeback
      1.68 ±  6%      +0.3        2.00 ±  9%  perf-profile.self.cycles-pp.end_page_writeback
      0.98 ±  3%      +0.4        1.35 ± 12%  perf-profile.self.cycles-pp._swap_info_get
      1.22 ±  5%      +0.5        1.75 ± 14%  perf-profile.self.cycles-pp.page_counter_cancel
     52345 ± 17%     -84.0%       8384 ± 41%  softirqs.CPU0.RCU
     19063 ±  7%     -20.7%      15125 ±  6%  softirqs.CPU0.SCHED
     36466 ± 32%     -86.4%       4972 ± 11%  softirqs.CPU1.RCU
     36608 ± 40%     -87.4%       4628 ± 19%  softirqs.CPU10.RCU
     26212 ± 19%     -86.4%       3553 ±  2%  softirqs.CPU100.RCU
     27448 ± 17%     -86.5%       3706 ±  6%  softirqs.CPU101.RCU
     27842 ± 29%     -87.2%       3562 ±  4%  softirqs.CPU102.RCU
     26457 ± 29%     -87.1%       3409 ±  4%  softirqs.CPU103.RCU
     27085 ± 19%     -86.7%       3602 ±  6%  softirqs.CPU104.RCU
     27395 ± 20%     -86.8%       3611 ±  8%  softirqs.CPU105.RCU
     25853 ± 23%     -86.6%       3457 ±  5%  softirqs.CPU106.RCU
     27375 ± 24%     -86.5%       3696 ±  6%  softirqs.CPU107.RCU
     41902 ± 27%     -90.1%       4168 ± 47%  softirqs.CPU108.RCU
     18997 ±  7%     -15.2%      16115 ±  3%  softirqs.CPU108.SCHED
     35065 ± 28%     -91.6%       2936 ± 11%  softirqs.CPU109.RCU
     35638 ± 34%     -85.2%       5271 ± 41%  softirqs.CPU11.RCU
     34068 ± 26%     -91.6%       2847 ± 12%  softirqs.CPU110.RCU
     19277 ±  6%     -18.1%      15790 ±  9%  softirqs.CPU110.SCHED
     34270 ± 24%     -89.9%       3470 ± 31%  softirqs.CPU111.RCU
     34839 ± 33%     -90.4%       3339 ±  3%  softirqs.CPU112.RCU
     38104 ± 27%     -91.3%       3308 ±  5%  softirqs.CPU113.RCU
     32552 ± 31%     -90.9%       2966 ±  8%  softirqs.CPU114.RCU
     33623 ± 26%     -90.2%       3303 ±  7%  softirqs.CPU115.RCU
     35550 ± 27%     -90.4%       3417 ±  8%  softirqs.CPU116.RCU
     33356 ± 27%     -89.8%       3415 ±  5%  softirqs.CPU117.RCU
     33993 ± 32%     -90.0%       3405 ± 12%  softirqs.CPU118.RCU
     36253 ± 26%     -90.3%       3519 ±  3%  softirqs.CPU119.RCU
     34824 ± 31%     -87.1%       4494 ±  9%  softirqs.CPU12.RCU
     32768 ± 39%     -88.8%       3661 ± 11%  softirqs.CPU120.RCU
     36094 ± 23%     -90.6%       3401 ±  3%  softirqs.CPU121.RCU
     34497 ± 31%     -89.0%       3807 ± 12%  softirqs.CPU122.RCU
     36262 ± 25%     -88.4%       4193 ± 32%  softirqs.CPU123.RCU
     34252 ± 25%     -90.1%       3394 ±  5%  softirqs.CPU124.RCU
     36674 ± 21%     -88.3%       4301 ± 25%  softirqs.CPU125.RCU
     27951 ±  7%     -88.9%       3101 ± 10%  softirqs.CPU126.RCU
     18871 ±  7%     -14.7%      16104 ±  3%  softirqs.CPU126.SCHED
     23136 ± 14%     -88.8%       2600 ±  4%  softirqs.CPU127.RCU
     19431 ±  5%     -22.5%      15053 ± 14%  softirqs.CPU127.SCHED
     27391 ±  5%     -88.3%       3205        softirqs.CPU128.RCU
     25272 ± 14%     -86.9%       3319 ±  4%  softirqs.CPU129.RCU
     35293 ± 39%     -88.5%       4050 ± 11%  softirqs.CPU13.RCU
     26272 ± 10%     -88.4%       3041 ± 10%  softirqs.CPU130.RCU
     25115 ±  5%     -86.9%       3291 ±  3%  softirqs.CPU131.RCU
     23529 ±  6%     -86.9%       3071 ± 10%  softirqs.CPU132.RCU
     27781 ± 13%     -86.5%       3755 ± 15%  softirqs.CPU133.RCU
     26065 ± 16%     -87.4%       3289 ± 10%  softirqs.CPU134.RCU
     23998 ± 10%     -86.3%       3277 ±  3%  softirqs.CPU135.RCU
     26249 ± 18%     -87.3%       3328 ±  5%  softirqs.CPU136.RCU
     21876 ± 13%     -82.2%       3887 ± 14%  softirqs.CPU137.RCU
     22414 ± 10%     -82.1%       4001 ± 18%  softirqs.CPU138.RCU
     24824 ±  5%     -85.5%       3595 ±  9%  softirqs.CPU139.RCU
     34692 ± 44%     -88.7%       3921 ±  6%  softirqs.CPU14.RCU
     22513 ± 12%     -84.8%       3418 ±  7%  softirqs.CPU140.RCU
     23522 ±  5%     -85.0%       3517 ±  7%  softirqs.CPU141.RCU
     22534 ± 11%     -84.6%       3469 ±  8%  softirqs.CPU142.RCU
     25471 ± 22%     -84.8%       3869 ± 18%  softirqs.CPU143.RCU
     33424 ± 43%     -87.6%       4133 ±  9%  softirqs.CPU15.RCU
     32536 ± 25%     -89.7%       3340 ±  4%  softirqs.CPU16.RCU
     31138 ± 29%     -88.7%       3526 ±  7%  softirqs.CPU17.RCU
     51275 ± 11%     -92.3%       3956 ± 11%  softirqs.CPU18.RCU
     16486 ±  6%     -21.1%      13010 ± 12%  softirqs.CPU18.SCHED
     37422 ± 27%     -86.3%       5144 ± 42%  softirqs.CPU19.RCU
     18953 ±  6%     -29.2%      13419 ± 20%  softirqs.CPU19.SCHED
     38774 ± 41%     -88.8%       4336 ± 11%  softirqs.CPU2.RCU
     19636 ±  2%     -19.1%      15894 ±  7%  softirqs.CPU2.SCHED
     37496 ± 28%     -90.0%       3733 ±  8%  softirqs.CPU20.RCU
     19096 ±  5%     -19.5%      15372 ± 19%  softirqs.CPU20.SCHED
     36543 ± 22%     -89.9%       3688 ±  5%  softirqs.CPU21.RCU
     33600 ± 22%     -88.2%       3950 ± 16%  softirqs.CPU22.RCU
     38695 ± 21%     -90.1%       3830 ±  4%  softirqs.CPU23.RCU
     35007 ± 22%     -89.8%       3559 ±  7%  softirqs.CPU24.RCU
     19064 ±  4%     -12.9%      16604 ±  8%  softirqs.CPU24.SCHED
     37485 ± 21%     -90.1%       3728 ±  6%  softirqs.CPU25.RCU
     33627 ± 28%     -88.8%       3763 ±  7%  softirqs.CPU26.RCU
     36026 ± 24%     -89.4%       3829 ±  3%  softirqs.CPU27.RCU
     34690 ± 29%     -88.4%       4028 ±  5%  softirqs.CPU28.RCU
     36943 ± 24%     -89.5%       3882 ±  3%  softirqs.CPU29.RCU
     38484 ± 41%     -85.7%       5499 ± 39%  softirqs.CPU3.RCU
     34943 ± 26%     -89.3%       3743 ±  3%  softirqs.CPU30.RCU
     34022 ± 31%     -88.5%       3927 ±  5%  softirqs.CPU31.RCU
     34577 ± 26%     -90.2%       3392 ±  7%  softirqs.CPU32.RCU
     34324 ± 39%     -90.2%       3379 ±  4%  softirqs.CPU33.RCU
     32528 ± 21%     -89.1%       3560 ± 11%  softirqs.CPU34.RCU
     35054 ± 38%     -86.3%       4802 ± 28%  softirqs.CPU35.RCU
     55830 ± 22%     -91.4%       4827 ± 19%  softirqs.CPU36.RCU
     18131 ±  5%     -32.8%      12178 ± 16%  softirqs.CPU36.SCHED
     44535 ± 25%     -91.5%       3800 ±  6%  softirqs.CPU37.RCU
     18780 ±  6%     -17.0%      15579 ± 12%  softirqs.CPU37.SCHED
     46422 ± 32%     -90.5%       4423 ± 17%  softirqs.CPU38.RCU
     18645 ±  6%     -27.3%      13557 ± 20%  softirqs.CPU38.SCHED
     43345 ± 22%     -88.7%       4918 ± 36%  softirqs.CPU39.RCU
     32960 ± 30%     -88.1%       3917 ±  4%  softirqs.CPU4.RCU
     44490 ± 29%     -91.7%       3685 ±  2%  softirqs.CPU40.RCU
     46120 ± 29%     -91.8%       3798 ±  2%  softirqs.CPU41.RCU
     42257 ± 32%     -91.6%       3551 ±  4%  softirqs.CPU42.RCU
     46039 ± 20%     -90.9%       4188 ± 21%  softirqs.CPU43.RCU
     44088 ± 29%     -91.8%       3604        softirqs.CPU44.RCU
     41672 ± 31%     -91.2%       3647        softirqs.CPU45.RCU
     44499 ± 25%     -91.9%       3597 ±  8%  softirqs.CPU46.RCU
     47826 ± 27%     -92.4%       3616        softirqs.CPU47.RCU
     40295 ± 41%     -91.3%       3518        softirqs.CPU48.RCU
     41600 ± 24%     -91.6%       3497        softirqs.CPU49.RCU
     36523 ± 32%     -88.8%       4102 ±  6%  softirqs.CPU5.RCU
     43678 ± 34%     -92.3%       3347 ±  4%  softirqs.CPU50.RCU
     44579 ± 28%     -90.7%       4125 ± 15%  softirqs.CPU51.RCU
     43503 ± 28%     -92.2%       3396 ±  3%  softirqs.CPU52.RCU
     44468 ± 18%     -90.5%       4219 ± 33%  softirqs.CPU53.RCU
     49302 ±  5%     -90.4%       4747 ± 22%  softirqs.CPU54.RCU
     16826 ±  6%     -23.7%      12844 ± 10%  softirqs.CPU54.SCHED
     34574 ± 13%     -87.8%       4220 ± 18%  softirqs.CPU55.RCU
     18223 ±  8%     -35.1%      11830 ± 25%  softirqs.CPU55.SCHED
     34444 ± 10%     -88.1%       4102 ± 21%  softirqs.CPU56.RCU
     29792 ± 13%     -87.5%       3728 ± 11%  softirqs.CPU57.RCU
     29979 ± 15%     -86.7%       3997 ± 16%  softirqs.CPU58.RCU
     29522 ± 13%     -87.5%       3687 ±  8%  softirqs.CPU59.RCU
     34227 ± 39%     -88.9%       3815 ±  6%  softirqs.CPU6.RCU
     19618 ±  4%     -10.2%      17615 ±  4%  softirqs.CPU6.SCHED
     29331 ± 13%     -88.2%       3454 ±  8%  softirqs.CPU60.RCU
     30844 ± 15%     -88.5%       3555 ±  4%  softirqs.CPU61.RCU
     30676 ± 16%     -87.1%       3947 ± 18%  softirqs.CPU62.RCU
     31209 ± 20%     -89.1%       3399 ±  8%  softirqs.CPU63.RCU
     32203 ± 16%     -89.0%       3550 ± 12%  softirqs.CPU64.RCU
     26618 ± 18%     -86.7%       3543 ±  4%  softirqs.CPU65.RCU
     28476 ± 20%     -86.5%       3856 ± 11%  softirqs.CPU66.RCU
     29713 ± 12%     -87.1%       3842 ± 14%  softirqs.CPU67.RCU
     28361 ± 25%     -87.2%       3628 ±  6%  softirqs.CPU68.RCU
     30363 ± 18%     -87.3%       3850 ±  9%  softirqs.CPU69.RCU
     40268 ± 49%     -90.1%       3997 ±  6%  softirqs.CPU7.RCU
     29067 ± 11%     -83.9%       4679 ± 38%  softirqs.CPU70.RCU
     30143 ± 14%     -87.5%       3758 ±  4%  softirqs.CPU71.RCU
     33102 ± 37%     -90.7%       3088 ±  6%  softirqs.CPU72.RCU
     29408 ± 29%     -88.2%       3474 ±  5%  softirqs.CPU73.RCU
     19427           -18.5%      15841 ± 10%  softirqs.CPU73.SCHED
     31208 ± 34%     -89.4%       3312        softirqs.CPU74.RCU
     19059 ±  2%     -12.2%      16733 ±  7%  softirqs.CPU74.SCHED
     29231 ± 42%     -88.2%       3446 ±  2%  softirqs.CPU75.RCU
     27628 ± 26%     -86.2%       3814 ± 21%  softirqs.CPU76.RCU
     26377 ± 27%     -87.0%       3428 ±  2%  softirqs.CPU77.RCU
     26349 ± 50%     -86.3%       3622 ± 18%  softirqs.CPU78.RCU
     30531 ± 48%     -88.9%       3389 ±  7%  softirqs.CPU79.RCU
     35512 ± 42%     -88.0%       4272 ±  4%  softirqs.CPU8.RCU
     25522 ± 36%     -86.9%       3339 ± 16%  softirqs.CPU80.RCU
     27427 ± 48%     -86.2%       3784 ± 16%  softirqs.CPU81.RCU
     25383 ± 40%     -82.8%       4368 ± 33%  softirqs.CPU82.RCU
     26528 ± 40%     -84.2%       4180 ± 15%  softirqs.CPU83.RCU
     26637 ± 33%     -85.5%       3849 ±  9%  softirqs.CPU84.RCU
     27814 ± 30%     -86.6%       3735 ±  8%  softirqs.CPU85.RCU
     27615 ± 39%     -82.7%       4764 ± 19%  softirqs.CPU86.RCU
     27935 ± 40%     -85.1%       4154 ± 14%  softirqs.CPU87.RCU
     27323 ± 26%     -84.0%       4380 ± 15%  softirqs.CPU88.RCU
     26788 ± 28%     -85.9%       3788 ±  2%  softirqs.CPU89.RCU
     34530 ± 43%     -88.9%       3845 ± 11%  softirqs.CPU9.RCU
     34234 ± 12%     -90.2%       3338        softirqs.CPU90.RCU
     19353 ±  3%     -24.2%      14671 ±  2%  softirqs.CPU90.SCHED
     27937 ± 28%     -85.9%       3926 ± 15%  softirqs.CPU91.RCU
     19542 ±  6%     -15.2%      16566 ±  3%  softirqs.CPU91.SCHED
     28497 ± 22%     -87.9%       3441 ± 14%  softirqs.CPU92.RCU
     28320 ± 18%     -89.1%       3074 ±  4%  softirqs.CPU93.RCU
     26306 ± 11%     -85.4%       3840 ± 27%  softirqs.CPU94.RCU
     19738 ±  4%     -12.9%      17184 ±  9%  softirqs.CPU94.SCHED
     26514 ±  8%     -87.0%       3439 ± 23%  softirqs.CPU95.RCU
     25298 ± 14%     -86.9%       3318 ± 10%  softirqs.CPU96.RCU
     19776 ±  3%     -13.9%      17031 ±  6%  softirqs.CPU96.SCHED
     27549 ± 12%     -87.5%       3438 ±  6%  softirqs.CPU97.RCU
     28550 ± 25%     -88.7%       3235 ±  9%  softirqs.CPU98.RCU
     26684 ± 19%     -87.0%       3473 ±  6%  softirqs.CPU99.RCU
   4756845 ±  5%     -88.5%     544700        softirqs.RCU
     30919 ±  3%     -13.8%      26641 ±  2%  softirqs.TIMER
    145.50 ±  2%     -56.0%      64.00 ±100%  interrupts.175:PCI-MSI.512000-edge.ahci[0000:00:1f.2]
    112.25 ±  3%      -8.7%     102.50 ±  4%  interrupts.45:PCI-MSI.1572864-edge.eth0-TxRx-0
  78296627            +5.0%   82208891        interrupts.CAL:Function_call_interrupts
    112.25 ±  3%      -8.7%     102.50 ±  4%  interrupts.CPU0.45:PCI-MSI.1572864-edge.eth0-TxRx-0
   1231976 ± 21%    +185.1%    3511906 ± 22%  interrupts.CPU0.CAL:Function_call_interrupts
   1343291 ± 20%    +181.1%    3775855 ± 22%  interrupts.CPU0.TLB:TLB_shootdowns
    608271 ± 75%     -99.3%       4379 ±170%  interrupts.CPU10.CAL:Function_call_interrupts
    457.50 ± 61%     -79.9%      91.75 ± 38%  interrupts.CPU10.NMI:Non-maskable_interrupts
    457.50 ± 61%     -79.9%      91.75 ± 38%  interrupts.CPU10.PMI:Performance_monitoring_interrupts
     89.00 ± 59%     -89.9%       9.00 ± 79%  interrupts.CPU10.RES:Rescheduling_interrupts
    657079 ± 75%     -99.3%       4336 ±173%  interrupts.CPU10.TLB:TLB_shootdowns
    411365 ± 29%     -99.7%       1267 ± 64%  interrupts.CPU100.CAL:Function_call_interrupts
    444274 ± 30%     -99.7%       1249 ± 69%  interrupts.CPU100.TLB:TLB_shootdowns
    659.50 ± 68%     -74.6%     167.50 ± 22%  interrupts.CPU102.NMI:Non-maskable_interrupts
    659.50 ± 68%     -74.6%     167.50 ± 22%  interrupts.CPU102.PMI:Performance_monitoring_interrupts
    302129 ± 60%     -99.9%     166.75 ± 59%  interrupts.CPU103.CAL:Function_call_interrupts
    323.75 ± 53%     -56.4%     141.00 ± 34%  interrupts.CPU103.NMI:Non-maskable_interrupts
    323.75 ± 53%     -56.4%     141.00 ± 34%  interrupts.CPU103.PMI:Performance_monitoring_interrupts
    327333 ± 60%    -100.0%      32.50 ±166%  interrupts.CPU103.TLB:TLB_shootdowns
    312284 ± 48%     -53.9%     144043 ± 50%  interrupts.CPU104.CAL:Function_call_interrupts
    338648 ± 48%     -54.3%     154674 ± 50%  interrupts.CPU104.TLB:TLB_shootdowns
    115.50 ± 72%     -81.0%      22.00 ± 19%  interrupts.CPU108.RES:Rescheduling_interrupts
    626496 ± 83%     -90.8%      57927 ±172%  interrupts.CPU11.CAL:Function_call_interrupts
     78.00 ± 60%     -73.1%      21.00 ± 86%  interrupts.CPU11.RES:Rescheduling_interrupts
    679997 ± 83%     -90.5%      64580 ±173%  interrupts.CPU11.TLB:TLB_shootdowns
     81.25 ± 51%     -80.3%      16.00 ± 11%  interrupts.CPU111.RES:Rescheduling_interrupts
     87.50 ± 71%     -89.7%       9.00 ± 40%  interrupts.CPU112.RES:Rescheduling_interrupts
    645406 ± 66%     -89.8%      66133 ±103%  interrupts.CPU113.CAL:Function_call_interrupts
    103.50 ± 48%     -89.6%      10.75 ± 47%  interrupts.CPU113.RES:Rescheduling_interrupts
    698561 ± 66%     -89.8%      71091 ±104%  interrupts.CPU113.TLB:TLB_shootdowns
     78.00 ± 68%     -86.2%      10.75 ± 41%  interrupts.CPU114.RES:Rescheduling_interrupts
      1141 ± 56%     -72.3%     316.50 ±106%  interrupts.CPU115.NMI:Non-maskable_interrupts
      1141 ± 56%     -72.3%     316.50 ±106%  interrupts.CPU115.PMI:Performance_monitoring_interrupts
     91.00 ± 62%     -90.1%       9.00 ± 26%  interrupts.CPU115.RES:Rescheduling_interrupts
    757124 ± 58%     -60.1%     302332 ±132%  interrupts.CPU116.CAL:Function_call_interrupts
     98.25 ± 46%     -88.0%      11.75 ± 63%  interrupts.CPU116.RES:Rescheduling_interrupts
    823491 ± 58%     -60.9%     322256 ±132%  interrupts.CPU116.TLB:TLB_shootdowns
    628006 ± 76%     -73.8%     164708 ±146%  interrupts.CPU117.CAL:Function_call_interrupts
    987.50 ± 49%     -85.9%     139.25 ± 30%  interrupts.CPU117.NMI:Non-maskable_interrupts
    987.50 ± 49%     -85.9%     139.25 ± 30%  interrupts.CPU117.PMI:Performance_monitoring_interrupts
    109.25 ± 69%     -93.1%       7.50 ± 52%  interrupts.CPU117.RES:Rescheduling_interrupts
    681610 ± 76%     -74.4%     174707 ±146%  interrupts.CPU117.TLB:TLB_shootdowns
    104.00 ± 55%     -87.7%      12.75 ± 78%  interrupts.CPU119.RES:Rescheduling_interrupts
    471.25 ± 54%     -80.9%      90.00 ± 38%  interrupts.CPU12.NMI:Non-maskable_interrupts
    471.25 ± 54%     -80.9%      90.00 ± 38%  interrupts.CPU12.PMI:Performance_monitoring_interrupts
     58.25 ± 79%     -76.4%      13.75 ± 88%  interrupts.CPU12.RES:Rescheduling_interrupts
    878.50 ± 72%     -88.3%     103.00 ± 43%  interrupts.CPU120.NMI:Non-maskable_interrupts
    878.50 ± 72%     -88.3%     103.00 ± 43%  interrupts.CPU120.PMI:Performance_monitoring_interrupts
     64.00 ± 77%     -85.5%       9.25 ± 68%  interrupts.CPU120.RES:Rescheduling_interrupts
    868.50 ± 54%     -84.1%     138.50 ± 45%  interrupts.CPU121.NMI:Non-maskable_interrupts
    868.50 ± 54%     -84.1%     138.50 ± 45%  interrupts.CPU121.PMI:Performance_monitoring_interrupts
    597802 ± 74%     -99.8%       1291 ±164%  interrupts.CPU122.CAL:Function_call_interrupts
    804.25 ± 83%     -85.9%     113.25 ± 65%  interrupts.CPU122.NMI:Non-maskable_interrupts
    804.25 ± 83%     -85.9%     113.25 ± 65%  interrupts.CPU122.PMI:Performance_monitoring_interrupts
     95.50 ± 48%     -92.7%       7.00 ± 56%  interrupts.CPU122.RES:Rescheduling_interrupts
    649164 ± 75%     -99.8%       1290 ±173%  interrupts.CPU122.TLB:TLB_shootdowns
    114.50 ± 54%     -93.7%       7.25 ± 48%  interrupts.CPU123.RES:Rescheduling_interrupts
    629610 ± 63%     -69.6%     191537 ±168%  interrupts.CPU124.CAL:Function_call_interrupts
      1011 ± 58%     -86.9%     132.50 ± 45%  interrupts.CPU124.NMI:Non-maskable_interrupts
      1011 ± 58%     -86.9%     132.50 ± 45%  interrupts.CPU124.PMI:Performance_monitoring_interrupts
     70.25 ± 70%     -85.4%      10.25 ± 44%  interrupts.CPU124.RES:Rescheduling_interrupts
    683705 ± 63%     -69.7%     206886 ±168%  interrupts.CPU124.TLB:TLB_shootdowns
    739662 ± 49%     -82.9%     126387 ±117%  interrupts.CPU125.CAL:Function_call_interrupts
    968.50 ± 63%     -84.4%     151.00 ± 27%  interrupts.CPU125.NMI:Non-maskable_interrupts
    968.50 ± 63%     -84.4%     151.00 ± 27%  interrupts.CPU125.PMI:Performance_monitoring_interrupts
     66.25 ± 66%     -72.8%      18.00 ± 97%  interrupts.CPU125.RES:Rescheduling_interrupts
    804430 ± 50%     -83.3%     134653 ±118%  interrupts.CPU125.TLB:TLB_shootdowns
    501165 ± 14%    +221.8%    1612759 ± 13%  interrupts.CPU126.CAL:Function_call_interrupts
    545091 ± 14%    +217.3%    1729798 ± 13%  interrupts.CPU126.TLB:TLB_shootdowns
    303.75 ± 35%   +1609.7%       5193 ± 40%  interrupts.CPU127.NMI:Non-maskable_interrupts
    303.75 ± 35%   +1609.7%       5193 ± 40%  interrupts.CPU127.PMI:Performance_monitoring_interrupts
     81.00 ± 59%     -78.1%      17.75 ± 68%  interrupts.CPU13.RES:Rescheduling_interrupts
    221283 ± 18%     -61.8%      84423 ± 90%  interrupts.CPU132.CAL:Function_call_interrupts
    240847 ± 18%     -62.5%      90210 ± 89%  interrupts.CPU132.TLB:TLB_shootdowns
    228853 ± 19%     -64.6%      81121 ±115%  interrupts.CPU135.CAL:Function_call_interrupts
    514.00 ± 87%     -74.7%     130.25 ± 15%  interrupts.CPU135.NMI:Non-maskable_interrupts
    514.00 ± 87%     -74.7%     130.25 ± 15%  interrupts.CPU135.PMI:Performance_monitoring_interrupts
    250600 ± 19%     -65.4%      86702 ±116%  interrupts.CPU135.TLB:TLB_shootdowns
    319279 ± 47%     -92.1%      25144 ±150%  interrupts.CPU136.CAL:Function_call_interrupts
    343.25 ± 76%     -63.6%     125.00 ± 25%  interrupts.CPU136.NMI:Non-maskable_interrupts
    343.25 ± 76%     -63.6%     125.00 ± 25%  interrupts.CPU136.PMI:Performance_monitoring_interrupts
    349192 ± 47%     -92.4%      26548 ±150%  interrupts.CPU136.TLB:TLB_shootdowns
    270185 ± 37%     -78.4%      58300 ±172%  interrupts.CPU139.CAL:Function_call_interrupts
    378.00 ± 56%     -71.6%     107.25 ± 27%  interrupts.CPU139.NMI:Non-maskable_interrupts
    378.00 ± 56%     -71.6%     107.25 ± 27%  interrupts.CPU139.PMI:Performance_monitoring_interrupts
    293913 ± 37%     -78.9%      62022 ±173%  interrupts.CPU139.TLB:TLB_shootdowns
     78.00 ± 63%     -76.3%      18.50 ±111%  interrupts.CPU14.RES:Rescheduling_interrupts
    162067 ± 56%     -81.2%      30462 ±165%  interrupts.CPU140.CAL:Function_call_interrupts
    175459 ± 56%     -82.0%      31590 ±166%  interrupts.CPU140.TLB:TLB_shootdowns
    253.25 ± 32%     -50.4%     125.50 ± 35%  interrupts.CPU143.NMI:Non-maskable_interrupts
    253.25 ± 32%     -50.4%     125.50 ± 35%  interrupts.CPU143.PMI:Performance_monitoring_interrupts
     66.75 ± 72%     -82.4%      11.75 ± 49%  interrupts.CPU15.RES:Rescheduling_interrupts
    508268 ± 63%    -100.0%      79.25 ± 22%  interrupts.CPU16.CAL:Function_call_interrupts
      1082 ± 98%     -93.1%      75.25 ± 11%  interrupts.CPU16.NMI:Non-maskable_interrupts
      1082 ± 98%     -93.1%      75.25 ± 11%  interrupts.CPU16.PMI:Performance_monitoring_interrupts
     58.50 ± 46%     -86.3%       8.00 ± 81%  interrupts.CPU16.RES:Rescheduling_interrupts
    549265 ± 63%    -100.0%       4.00 ±133%  interrupts.CPU16.TLB:TLB_shootdowns
     52.25 ± 65%     -66.5%      17.50 ± 57%  interrupts.CPU17.RES:Rescheduling_interrupts
   1258584 ± 15%    +208.1%    3878023 ± 32%  interrupts.CPU18.CAL:Function_call_interrupts
   1369478 ± 15%    +204.9%    4175783 ± 31%  interrupts.CPU18.TLB:TLB_shootdowns
    629511 ± 88%    +241.1%    2147207 ± 76%  interrupts.CPU2.CAL:Function_call_interrupts
    678734 ± 89%    +237.7%    2292112 ± 75%  interrupts.CPU2.TLB:TLB_shootdowns
    620.75 ± 72%     -82.7%     107.50 ± 33%  interrupts.CPU21.NMI:Non-maskable_interrupts
    620.75 ± 72%     -82.7%     107.50 ± 33%  interrupts.CPU21.PMI:Performance_monitoring_interrupts
     50.50 ± 71%     -71.8%      14.25 ± 84%  interrupts.CPU21.RES:Rescheduling_interrupts
     63.75 ± 43%     -78.8%      13.50 ± 99%  interrupts.CPU22.RES:Rescheduling_interrupts
     66.75 ± 50%     -80.5%      13.00 ± 88%  interrupts.CPU23.RES:Rescheduling_interrupts
     54.25 ± 62%     -77.0%      12.50 ± 17%  interrupts.CPU25.RES:Rescheduling_interrupts
    323.25 ± 93%     -74.2%      83.25 ±  8%  interrupts.CPU28.NMI:Non-maskable_interrupts
    323.25 ± 93%     -74.2%      83.25 ±  8%  interrupts.CPU28.PMI:Performance_monitoring_interrupts
     71.75 ± 37%     -83.6%      11.75 ±109%  interrupts.CPU29.RES:Rescheduling_interrupts
    657.25 ± 54%     -83.5%     108.50 ± 30%  interrupts.CPU3.NMI:Non-maskable_interrupts
    657.25 ± 54%     -83.5%     108.50 ± 30%  interrupts.CPU3.PMI:Performance_monitoring_interrupts
     81.75 ± 86%     -78.0%      18.00 ± 42%  interrupts.CPU3.RES:Rescheduling_interrupts
    846.25 ± 65%     -88.7%      96.00 ± 15%  interrupts.CPU30.NMI:Non-maskable_interrupts
    846.25 ± 65%     -88.7%      96.00 ± 15%  interrupts.CPU30.PMI:Performance_monitoring_interrupts
     54.50 ± 54%     -85.3%       8.00 ± 49%  interrupts.CPU30.RES:Rescheduling_interrupts
    545049 ± 65%     -98.4%       8859 ±171%  interrupts.CPU31.CAL:Function_call_interrupts
    612.00 ± 63%     -84.8%      92.75 ± 14%  interrupts.CPU31.NMI:Non-maskable_interrupts
    612.00 ± 63%     -84.8%      92.75 ± 14%  interrupts.CPU31.PMI:Performance_monitoring_interrupts
     49.75 ± 83%     -78.4%      10.75 ± 54%  interrupts.CPU31.RES:Rescheduling_interrupts
    593689 ± 65%     -98.4%       9350 ±173%  interrupts.CPU31.TLB:TLB_shootdowns
     67.75 ± 84%     -85.6%       9.75 ± 42%  interrupts.CPU33.RES:Rescheduling_interrupts
    138.75 ± 65%     -78.7%      29.50 ± 25%  interrupts.CPU36.RES:Rescheduling_interrupts
    133.75 ± 81%     -84.1%      21.25 ± 49%  interrupts.CPU37.RES:Rescheduling_interrupts
    108.75 ± 54%     -82.3%      19.25 ± 45%  interrupts.CPU38.RES:Rescheduling_interrupts
    112.50 ± 75%     -93.8%       7.00 ± 42%  interrupts.CPU40.RES:Rescheduling_interrupts
    117.75 ± 69%     -89.0%      13.00 ± 44%  interrupts.CPU41.RES:Rescheduling_interrupts
    889287 ± 63%     -69.2%     273776 ±142%  interrupts.CPU42.CAL:Function_call_interrupts
    917.25 ± 65%     -84.8%     139.25 ± 48%  interrupts.CPU42.NMI:Non-maskable_interrupts
    917.25 ± 65%     -84.8%     139.25 ± 48%  interrupts.CPU42.PMI:Performance_monitoring_interrupts
    110.75 ± 72%     -91.0%      10.00 ± 50%  interrupts.CPU42.RES:Rescheduling_interrupts
    970285 ± 63%     -69.8%     292582 ±142%  interrupts.CPU42.TLB:TLB_shootdowns
    945929 ± 47%     -54.3%     432248 ±109%  interrupts.CPU43.CAL:Function_call_interrupts
      1431 ± 84%     -74.5%     365.50 ±134%  interrupts.CPU43.NMI:Non-maskable_interrupts
      1431 ± 84%     -74.5%     365.50 ±134%  interrupts.CPU43.PMI:Performance_monitoring_interrupts
     91.25 ± 46%     -93.7%       5.75 ± 44%  interrupts.CPU43.RES:Rescheduling_interrupts
   1030879 ± 47%     -54.7%     467326 ±108%  interrupts.CPU43.TLB:TLB_shootdowns
    120.25 ± 47%     -93.6%       7.75 ± 23%  interrupts.CPU44.RES:Rescheduling_interrupts
    869076 ± 61%     -79.1%     182037 ±126%  interrupts.CPU45.CAL:Function_call_interrupts
      1007 ± 52%     -88.8%     113.00 ± 61%  interrupts.CPU45.NMI:Non-maskable_interrupts
      1007 ± 52%     -88.8%     113.00 ± 61%  interrupts.CPU45.PMI:Performance_monitoring_interrupts
    119.00 ± 65%     -88.4%      13.75 ± 37%  interrupts.CPU45.RES:Rescheduling_interrupts
    945574 ± 61%     -79.6%     192547 ±127%  interrupts.CPU45.TLB:TLB_shootdowns
    121.00 ± 36%     -87.6%      15.00 ± 48%  interrupts.CPU46.RES:Rescheduling_interrupts
     96.50 ± 69%     -85.8%      13.75 ±116%  interrupts.CPU47.RES:Rescheduling_interrupts
     91.25 ± 70%     -91.2%       8.00 ± 31%  interrupts.CPU48.RES:Rescheduling_interrupts
    113.00 ± 73%     -93.1%       7.75 ±108%  interrupts.CPU49.RES:Rescheduling_interrupts
    471.25 ± 60%     -81.3%      88.25 ± 22%  interrupts.CPU5.NMI:Non-maskable_interrupts
    471.25 ± 60%     -81.3%      88.25 ± 22%  interrupts.CPU5.PMI:Performance_monitoring_interrupts
     72.25 ± 54%     -60.2%      28.75 ± 87%  interrupts.CPU5.RES:Rescheduling_interrupts
    959091 ± 62%     -94.9%      48533 ±172%  interrupts.CPU50.CAL:Function_call_interrupts
    137.75 ± 80%     -95.5%       6.25 ±  6%  interrupts.CPU50.RES:Rescheduling_interrupts
   1039830 ± 62%     -95.0%      52192 ±173%  interrupts.CPU50.TLB:TLB_shootdowns
      1333 ± 57%     -88.1%     158.50 ± 30%  interrupts.CPU51.NMI:Non-maskable_interrupts
      1333 ± 57%     -88.1%     158.50 ± 30%  interrupts.CPU51.PMI:Performance_monitoring_interrupts
    121.25 ± 51%     -89.5%      12.75 ± 45%  interrupts.CPU51.RES:Rescheduling_interrupts
    939728 ± 55%     -87.8%     114957 ±173%  interrupts.CPU52.CAL:Function_call_interrupts
    103.25 ± 63%     -94.2%       6.00 ± 39%  interrupts.CPU52.RES:Rescheduling_interrupts
   1020727 ± 55%     -88.1%     121660 ±173%  interrupts.CPU52.TLB:TLB_shootdowns
   1039918 ± 36%     -89.8%     106181 ±122%  interrupts.CPU53.CAL:Function_call_interrupts
      1284 ± 78%     -91.1%     114.00 ± 52%  interrupts.CPU53.NMI:Non-maskable_interrupts
      1284 ± 78%     -91.1%     114.00 ± 52%  interrupts.CPU53.PMI:Performance_monitoring_interrupts
    104.00 ± 68%     -94.7%       5.50 ± 27%  interrupts.CPU53.RES:Rescheduling_interrupts
   1134197 ± 36%     -90.1%     112045 ±121%  interrupts.CPU53.TLB:TLB_shootdowns
   1168628 ±  8%    +182.2%    3297943 ± 17%  interrupts.CPU54.CAL:Function_call_interrupts
    963.25 ± 47%    +350.1%       4336 ± 34%  interrupts.CPU54.NMI:Non-maskable_interrupts
    963.25 ± 47%    +350.1%       4336 ± 34%  interrupts.CPU54.PMI:Performance_monitoring_interrupts
     80.75 ± 40%     -48.3%      41.75 ± 25%  interrupts.CPU54.RES:Rescheduling_interrupts
   1275853 ±  8%    +177.1%    3535200 ± 18%  interrupts.CPU54.TLB:TLB_shootdowns
    392.25 ± 34%   +1015.9%       4377 ± 29%  interrupts.CPU55.NMI:Non-maskable_interrupts
    392.25 ± 34%   +1015.9%       4377 ± 29%  interrupts.CPU55.PMI:Performance_monitoring_interrupts
     84.75 ± 68%     -72.6%      23.25 ± 94%  interrupts.CPU6.RES:Rescheduling_interrupts
    707.00 ± 42%     -77.1%     162.25 ± 30%  interrupts.CPU61.NMI:Non-maskable_interrupts
    707.00 ± 42%     -77.1%     162.25 ± 30%  interrupts.CPU61.PMI:Performance_monitoring_interrupts
    405740 ± 55%     -76.0%      97283 ±115%  interrupts.CPU63.CAL:Function_call_interrupts
    684.50 ± 70%     -77.1%     157.00 ± 37%  interrupts.CPU63.NMI:Non-maskable_interrupts
    684.50 ± 70%     -77.1%     157.00 ± 37%  interrupts.CPU63.PMI:Performance_monitoring_interrupts
    440306 ± 55%     -76.6%     102844 ±115%  interrupts.CPU63.TLB:TLB_shootdowns
    315353 ± 24%     -62.0%     119836 ±106%  interrupts.CPU65.CAL:Function_call_interrupts
    340082 ± 24%     -62.6%     127245 ±106%  interrupts.CPU65.TLB:TLB_shootdowns
    356445 ± 33%     -88.5%      41068 ± 70%  interrupts.CPU66.CAL:Function_call_interrupts
    387163 ± 33%     -88.6%      44312 ± 71%  interrupts.CPU66.TLB:TLB_shootdowns
    390653 ± 33%     -91.5%      33124 ±172%  interrupts.CPU67.CAL:Function_call_interrupts
    461.25 ± 50%     -72.1%     128.75 ± 43%  interrupts.CPU67.NMI:Non-maskable_interrupts
    461.25 ± 50%     -72.1%     128.75 ± 43%  interrupts.CPU67.PMI:Performance_monitoring_interrupts
    424248 ± 33%     -91.6%      35682 ±173%  interrupts.CPU67.TLB:TLB_shootdowns
    362929 ± 57%     -67.3%     118702 ±125%  interrupts.CPU68.CAL:Function_call_interrupts
    393487 ± 57%     -68.0%     125761 ±125%  interrupts.CPU68.TLB:TLB_shootdowns
    396812 ± 29%     -91.7%      32913 ±168%  interrupts.CPU71.CAL:Function_call_interrupts
    407.00 ± 48%     -71.3%     117.00 ± 35%  interrupts.CPU71.NMI:Non-maskable_interrupts
    407.00 ± 48%     -71.3%     117.00 ± 35%  interrupts.CPU71.PMI:Performance_monitoring_interrupts
    432737 ± 29%     -91.1%      38455 ±169%  interrupts.CPU71.TLB:TLB_shootdowns
    617468 ± 68%    +224.7%    2004642 ± 58%  interrupts.CPU72.CAL:Function_call_interrupts
    670964 ± 68%    +220.4%    2149931 ± 58%  interrupts.CPU72.TLB:TLB_shootdowns
     62.50 ± 63%     -72.0%      17.50 ± 37%  interrupts.CPU75.RES:Rescheduling_interrupts
     58.50 ± 67%     -68.4%      18.50 ± 84%  interrupts.CPU77.RES:Rescheduling_interrupts
    584390 ± 73%     -92.3%      45050 ±111%  interrupts.CPU8.CAL:Function_call_interrupts
    498.50 ± 43%     -82.6%      86.50 ± 18%  interrupts.CPU8.NMI:Non-maskable_interrupts
    498.50 ± 43%     -82.6%      86.50 ± 18%  interrupts.CPU8.PMI:Performance_monitoring_interrupts
     71.25 ± 62%     -94.0%       4.25 ± 67%  interrupts.CPU8.RES:Rescheduling_interrupts
    634390 ± 73%     -92.5%      47709 ±111%  interrupts.CPU8.TLB:TLB_shootdowns
    305172 ±104%     -98.9%       3263 ±136%  interrupts.CPU80.CAL:Function_call_interrupts
    332295 ±104%     -99.0%       3256 ±144%  interrupts.CPU80.TLB:TLB_shootdowns
    306939 ± 97%    -100.0%      77.25 ± 23%  interrupts.CPU82.CAL:Function_call_interrupts
     45.50 ± 79%     -80.2%       9.00 ± 53%  interrupts.CPU82.RES:Rescheduling_interrupts
    332644 ± 98%    -100.0%       0.75 ±110%  interrupts.CPU82.TLB:TLB_shootdowns
    626.25 ± 82%     -78.1%     137.25 ± 44%  interrupts.CPU84.NMI:Non-maskable_interrupts
    626.25 ± 82%     -78.1%     137.25 ± 44%  interrupts.CPU84.PMI:Performance_monitoring_interrupts
    145.50 ±  2%     -56.0%      64.00 ±100%  interrupts.CPU87.175:PCI-MSI.512000-edge.ahci[0000:00:1f.2]
    330258 ±115%    -100.0%     114.75 ± 59%  interrupts.CPU88.CAL:Function_call_interrupts
    936.25 ±104%     -85.1%     139.50 ± 58%  interrupts.CPU88.NMI:Non-maskable_interrupts
    936.25 ±104%     -85.1%     139.50 ± 58%  interrupts.CPU88.PMI:Performance_monitoring_interrupts
    360088 ±116%    -100.0%      41.50 ±164%  interrupts.CPU88.TLB:TLB_shootdowns
     84.75 ± 77%     -69.0%      26.25 ± 97%  interrupts.CPU9.RES:Rescheduling_interrupts
    673363 ± 17%    +226.0%    2195380 ± 32%  interrupts.CPU90.CAL:Function_call_interrupts
    732427 ± 17%    +223.3%    2367615 ± 32%  interrupts.CPU90.TLB:TLB_shootdowns
      8947 ± 18%     -71.3%       2570 ± 19%  interrupts.RES:Rescheduling_interrupts





Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


Thanks,
Oliver Sang


--+B+y8wtTXqdUj1xM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="config-5.8.0-12310-gaae466b0052e18"

#
# Automatically generated file; DO NOT EDIT.
# Linux/x86_64 5.8.0 Kernel Configuration
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
# CONFIG_USB_CATC is not set
# CONFIG_USB_KAWETH is not set
# CONFIG_USB_PEGASUS is not set
# CONFIG_USB_RTL8150 is not set
CONFIG_USB_RTL8152=m
# CONFIG_USB_LAN78XX is not set
CONFIG_USB_USBNET=y
CONFIG_USB_NET_AX8817X=m
CONFIG_USB_NET_AX88179_178A=m
# CONFIG_USB_NET_CDCETHER is not set
# CONFIG_USB_NET_CDC_EEM is not set
# CONFIG_USB_NET_CDC_NCM is not set
# CONFIG_USB_NET_HUAWEI_CDC_NCM is not set
# CONFIG_USB_NET_CDC_MBIM is not set
# CONFIG_USB_NET_DM9601 is not set
# CONFIG_USB_NET_SR9700 is not set
# CONFIG_USB_NET_SR9800 is not set
# CONFIG_USB_NET_SMSC75XX is not set
# CONFIG_USB_NET_SMSC95XX is not set
# CONFIG_USB_NET_GL620A is not set
# CONFIG_USB_NET_NET1080 is not set
# CONFIG_USB_NET_PLUSB is not set
# CONFIG_USB_NET_MCS7830 is not set
# CONFIG_USB_NET_RNDIS_HOST is not set
# CONFIG_USB_NET_CDC_SUBSET is not set
# CONFIG_USB_NET_ZAURUS is not set
# CONFIG_USB_NET_CX82310_ETH is not set
# CONFIG_USB_NET_KALMIA is not set
# CONFIG_USB_NET_QMI_WWAN is not set
# CONFIG_USB_HSO is not set
# CONFIG_USB_NET_INT51X1 is not set
# CONFIG_USB_IPHETH is not set
# CONFIG_USB_SIERRA_NET is not set
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
# CONFIG_BACKLIGHT_GENERIC is not set
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
CONFIG_VIRTIO_BALLOON=m
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
CONFIG_EXT2_FS=m
CONFIG_EXT2_FS_XATTR=y
CONFIG_EXT2_FS_POSIX_ACL=y
CONFIG_EXT2_FS_SECURITY=y
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
# CONFIG_RCU_PERF_TEST is not set
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

--+B+y8wtTXqdUj1xM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=job-script

#!/bin/sh

export_top_env()
{
	export suite='vm-scalability'
	export testcase='vm-scalability'
	export category='benchmark'
	export runtime=300
	export nr_task=32
	export job_origin='/lkp-src/allot/cyclic:p1:linux-devel:devel-hourly/lkp-csl-2ap1/vm-scalability-swap-1ssd.yaml'
	export queue_cmdline_keys='branch
commit
queue_at_least_once'
	export schedule_notify_address=
	export queue='validate'
	export testbox='lkp-csl-2ap1'
	export tbox_group='lkp-csl-2ap1'
	export kconfig='x86_64-rhel-8.3'
	export submit_id='5feb8baa0421912750503ed0'
	export job_file='/lkp/jobs/scheduled/lkp-csl-2ap1/vm-scalability-performance-1-32-300-swap-w-rand-mt-always-never-ucode=0x4003003-monitor=0fe5055f-debian-10.4-x86_64-20200603.cgz-20201230-10064-1ae2w72-2.yaml'
	export id='8f0b583ea63ee1c248ecefaabd7c807aa47a87f6'
	export queuer_version='/lkp-src'
	export model='Cascade Lake'
	export nr_node=4
	export nr_cpu=192
	export memory='192G'
	export nr_ssd_partitions=1
	export ssd_partitions='/dev/disk/by-id/nvme-INTEL_SSDPE2KX040T7_PHLF738001A24P0IGN-part4'
	export rootfs_partition='/dev/disk/by-id/nvme-INTEL_SSDPE2KX040T7_PHLF738001A24P0IGN-part3'
	export kernel_cmdline_hw='acpi_rsdp=0x68005014'
	export brand='Intel(R) Xeon(R) CPU @ 2.20GHz'
	export need_kconfig='CONFIG_BLK_DEV_SD
CONFIG_SCSI
CONFIG_BLOCK=y
CONFIG_SATA_AHCI
CONFIG_SATA_AHCI_PLATFORM
CONFIG_ATA
CONFIG_PCI=y
CONFIG_SWAP
CONFIG_MMU
CONFIG_BLOCK
CONFIG_BLK_DEV_LOOP'
	export timeout='1h'
	export commit='aae466b0052e1888edd1d7f473d4310d64936196'
	export need_kconfig_hw='CONFIG_IGB=y
CONFIG_BLK_DEV_NVME'
	export ucode='0x4003003'
	export enqueue_time='2020-12-30 04:03:54 +0800'
	export _id='5feb8baa0421912750503ed0'
	export _rt='/result/vm-scalability/performance-1-32-300-swap-w-rand-mt-always-never-ucode=0x4003003-monitor=0fe5055f/lkp-csl-2ap1/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/aae466b0052e1888edd1d7f473d4310d64936196'
	export user='lkp'
	export compiler='gcc-9'
	export head_commit='2e0d055cc5da8e4a20e3942bad34c042bf15776f'
	export base_commit='2c85ebc57b3e1817b6ce1a6b703928e113a90442'
	export branch='linus/master'
	export rootfs='debian-10.4-x86_64-20200603.cgz'
	export monitor_sha='0fe5055f'
	export result_root='/result/vm-scalability/performance-1-32-300-swap-w-rand-mt-always-never-ucode=0x4003003-monitor=0fe5055f/lkp-csl-2ap1/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/aae466b0052e1888edd1d7f473d4310d64936196/3'
	export scheduler_version='/lkp/lkp/.src-20201229-084757'
	export LKP_SERVER='internal-lkp-server'
	export arch='x86_64'
	export max_uptime=3600
	export initrd='/osimage/debian/debian-10.4-x86_64-20200603.cgz'
	export bootloader_append='root=/dev/ram0
user=lkp
job=/lkp/jobs/scheduled/lkp-csl-2ap1/vm-scalability-performance-1-32-300-swap-w-rand-mt-always-never-ucode=0x4003003-monitor=0fe5055f-debian-10.4-x86_64-20200603.cgz-20201230-10064-1ae2w72-2.yaml
ARCH=x86_64
kconfig=x86_64-rhel-8.3
branch=linus/master
commit=aae466b0052e1888edd1d7f473d4310d64936196
BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3/gcc-9/aae466b0052e1888edd1d7f473d4310d64936196/vmlinuz-5.8.0-12310-gaae466b0052e18
acpi_rsdp=0x68005014
max_uptime=3600
RESULT_ROOT=/result/vm-scalability/performance-1-32-300-swap-w-rand-mt-always-never-ucode=0x4003003-monitor=0fe5055f/lkp-csl-2ap1/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/aae466b0052e1888edd1d7f473d4310d64936196/3
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
	export modules_initrd='/pkg/linux/x86_64-rhel-8.3/gcc-9/aae466b0052e1888edd1d7f473d4310d64936196/modules.cgz'
	export bm_initrd='/osimage/deps/debian-10.4-x86_64-20200603.cgz/run-ipconfig_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/lkp_20201211.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/rsync-rootfs_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/perf_20201126.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/perf-x86_64-fa02fcd94b0c-1_20201126.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/vm-scalability_20201110.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/vm-scalability-x86_64-1.0-0_20201110.cgz,/osimage/pkg/common/vm-scalability-x86_64.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/mpstat_20200714.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/sar-x86_64-34c92ae-1_20200702.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/hw_20200715.cgz'
	export ucode_initrd='/osimage/ucode/intel-ucode-20201117.cgz'
	export lkp_initrd='/osimage/user/lkp/lkp-x86_64.cgz'
	export site='inn'
	export LKP_CGI_PORT=80
	export LKP_CIFS_PORT=139
	export last_kernel='5.10.0-wt-gb5689c251dfc'
	export repeat_to=4
	export queue_at_least_once=1
	export kernel='/pkg/linux/x86_64-rhel-8.3/gcc-9/aae466b0052e1888edd1d7f473d4310d64936196/vmlinuz-5.8.0-12310-gaae466b0052e18'
	export dequeue_time='2020-12-30 04:15:43 +0800'
	export job_initrd='/lkp/jobs/scheduled/lkp-csl-2ap1/vm-scalability-performance-1-32-300-swap-w-rand-mt-always-never-ucode=0x4003003-monitor=0fe5055f-debian-10.4-x86_64-20200603.cgz-20201230-10064-1ae2w72-2.cgz'

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

	run_setup thp_enabled='never' thp_defrag='always' $LKP_SRC/setup/transparent_hugepage

	run_setup nr_ssd=1 $LKP_SRC/setup/disk

	run_setup $LKP_SRC/setup/swap

	run_setup $LKP_SRC/setup/cpufreq_governor 'performance'

	run_monitor delay=90 $LKP_SRC/monitors/no-stdout/wrapper perf-profile
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
	run_monitor $LKP_SRC/monitors/wrapper perf-sched
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

	run_test test='swap-w-rand-mt' $LKP_SRC/tests/wrapper vm-scalability
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
	$LKP_SRC/stats/wrapper perf-sched
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

--+B+y8wtTXqdUj1xM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="job.yaml"

---

#! jobs/vm-scalability-swap-1ssd.yaml
suite: vm-scalability
testcase: vm-scalability
category: benchmark
runtime: 300
transparent_hugepage:
  thp_enabled: never
  thp_defrag: always
nr_task: 32
disk:
  nr_ssd: 1
swap: 
perf-profile:
  delay: 90
vm-scalability:
  test: swap-w-rand-mt
job_origin: "/lkp-src/allot/cyclic:p1:linux-devel:devel-hourly/lkp-csl-2ap1/vm-scalability-swap-1ssd.yaml"

#! queue options
queue_cmdline_keys:
- branch
- commit
- queue_at_least_once
schedule_notify_address: 
queue: bisect
testbox: lkp-csl-2ap1
tbox_group: lkp-csl-2ap1
kconfig: x86_64-rhel-8.3
submit_id: 5feb817c0421912641d26a04
job_file: "/lkp/jobs/scheduled/lkp-csl-2ap1/vm-scalability-performance-1-32-300-swap-w-rand-mt-always-never-ucode=0x4003003-monitor=0fe5055f-debian-10.4-x86_64-20200603.cgz-20201230-9793-1k53j9z-0.yaml"
id: 72b9f0454ac7ba05e1ede9bfd6d4aa8b1283fbf3
queuer_version: "/lkp-src"

#! hosts/lkp-csl-2ap1
model: Cascade Lake
nr_node: 4
nr_cpu: 192
memory: 192G
nr_ssd_partitions: 1
ssd_partitions: "/dev/disk/by-id/nvme-INTEL_SSDPE2KX040T7_PHLF738001A24P0IGN-part4"
rootfs_partition: "/dev/disk/by-id/nvme-INTEL_SSDPE2KX040T7_PHLF738001A24P0IGN-part3"
kernel_cmdline_hw: acpi_rsdp=0x68005014
brand: Intel(R) Xeon(R) CPU @ 2.20GHz

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
perf-sched: 
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

#! include/disk/nr_ssd
need_kconfig:
- CONFIG_BLK_DEV_SD
- CONFIG_SCSI
- CONFIG_BLOCK=y
- CONFIG_SATA_AHCI
- CONFIG_SATA_AHCI_PLATFORM
- CONFIG_ATA
- CONFIG_PCI=y
- CONFIG_SWAP
- CONFIG_MMU
- CONFIG_BLOCK
- CONFIG_BLK_DEV_LOOP

#! include/swap

#! include/vm-scalability
timeout: 1h

#! include/queue/cyclic
commit: aae466b0052e1888edd1d7f473d4310d64936196

#! include/testbox/lkp-csl-2ap1
need_kconfig_hw:
- CONFIG_IGB=y
- CONFIG_BLK_DEV_NVME
ucode: '0x4003003'
enqueue_time: 2020-12-30 03:20:29.030622604 +08:00
_id: 5feb817c0421912641d26a04
_rt: "/result/vm-scalability/performance-1-32-300-swap-w-rand-mt-always-never-ucode=0x4003003-monitor=0fe5055f/lkp-csl-2ap1/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/aae466b0052e1888edd1d7f473d4310d64936196"

#! schedule options
user: lkp
compiler: gcc-9
head_commit: 2e0d055cc5da8e4a20e3942bad34c042bf15776f
base_commit: 2c85ebc57b3e1817b6ce1a6b703928e113a90442
branch: linus/master
rootfs: debian-10.4-x86_64-20200603.cgz
monitor_sha: 0fe5055f
result_root: "/result/vm-scalability/performance-1-32-300-swap-w-rand-mt-always-never-ucode=0x4003003-monitor=0fe5055f/lkp-csl-2ap1/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/aae466b0052e1888edd1d7f473d4310d64936196/0"
scheduler_version: "/lkp/lkp/.src-20201229-084757"
LKP_SERVER: internal-lkp-server
arch: x86_64
max_uptime: 3600
initrd: "/osimage/debian/debian-10.4-x86_64-20200603.cgz"
bootloader_append:
- root=/dev/ram0
- user=lkp
- job=/lkp/jobs/scheduled/lkp-csl-2ap1/vm-scalability-performance-1-32-300-swap-w-rand-mt-always-never-ucode=0x4003003-monitor=0fe5055f-debian-10.4-x86_64-20200603.cgz-20201230-9793-1k53j9z-0.yaml
- ARCH=x86_64
- kconfig=x86_64-rhel-8.3
- branch=linus/master
- commit=aae466b0052e1888edd1d7f473d4310d64936196
- BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3/gcc-9/aae466b0052e1888edd1d7f473d4310d64936196/vmlinuz-5.8.0-12310-gaae466b0052e18
- acpi_rsdp=0x68005014
- max_uptime=3600
- RESULT_ROOT=/result/vm-scalability/performance-1-32-300-swap-w-rand-mt-always-never-ucode=0x4003003-monitor=0fe5055f/lkp-csl-2ap1/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/aae466b0052e1888edd1d7f473d4310d64936196/0
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
modules_initrd: "/pkg/linux/x86_64-rhel-8.3/gcc-9/aae466b0052e1888edd1d7f473d4310d64936196/modules.cgz"
bm_initrd: "/osimage/deps/debian-10.4-x86_64-20200603.cgz/run-ipconfig_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/lkp_20201211.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/rsync-rootfs_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/perf_20201126.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/perf-x86_64-fa02fcd94b0c-1_20201126.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/vm-scalability_20201110.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/vm-scalability-x86_64-1.0-0_20201110.cgz,/osimage/pkg/common/vm-scalability-x86_64.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/mpstat_20200714.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/sar-x86_64-34c92ae-1_20200702.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/hw_20200715.cgz"
ucode_initrd: "/osimage/ucode/intel-ucode-20201117.cgz"
lkp_initrd: "/osimage/user/lkp/lkp-x86_64.cgz"
site: inn

#! /lkp/lkp/.src-20201213-191426/include/site/inn
LKP_CGI_PORT: 80
LKP_CIFS_PORT: 139
oom-killer: 
watchdog: 

#! runtime status
last_kernel: 5.8.0-01842-g62975d27d647a4

#! /lkp/lkp/.src-20201229-084757/include/site/inn
repeat_to: 2

#! user overrides
queue_at_least_once: 0
kernel: "/pkg/linux/x86_64-rhel-8.3/gcc-9/aae466b0052e1888edd1d7f473d4310d64936196/vmlinuz-5.8.0-12310-gaae466b0052e18"
dequeue_time: 2020-12-30 03:25:33.518847774 +08:00
job_state: finished
loadavg: 10.01 17.99 9.81 1/1481 15856
start_time: '1609269344'
end_time: '1609269737'
version: "/lkp/lkp/.src-20201229-084834:8bd2a8ae:dc3ef4498"

--+B+y8wtTXqdUj1xM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=reproduce

echo 'never' > /sys/kernel/mm/transparent_hugepage/enabled
echo 'always' > /sys/kernel/mm/transparent_hugepage/defrag
swapoff -a
mkswap /dev/nvme0n1p4
swapon /dev/nvme0n1p4

for cpu_dir in /sys/devices/system/cpu/cpu[0-9]*
do
	online_file="$cpu_dir"/online
	[ -f "$online_file" ] && [ "$(cat "$online_file")" -eq 0 ] && continue

	file="$cpu_dir"/cpufreq/scaling_governor
	[ -f "$file" ] && echo "performance" > "$file"
done

cd /lkp/benchmarks/vm-scalability
 mount -t tmpfs -o size=100% vm-scalability-tmp /tmp/vm-scalability-tmp
 truncate -s 202472075264 /tmp/vm-scalability-tmp/vm-scalability.img
 mkfs.xfs -q /tmp/vm-scalability-tmp/vm-scalability.img
 mount -o loop /tmp/vm-scalability-tmp/vm-scalability.img /tmp/vm-scalability-tmp/vm-scalability
 ./case-swap-w-rand-mt
 ./usemem --runtime 300 -t 32 --random 16326193536
 umount /tmp/vm-scalability-tmp/vm-scalability
 rm /tmp/vm-scalability-tmp/vm-scalability.img
 umount /tmp/vm-scalability-tmp

--+B+y8wtTXqdUj1xM--
