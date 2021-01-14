Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F5F72F5885
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 04:02:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728657AbhANCht (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 21:37:49 -0500
Received: from mga02.intel.com ([134.134.136.20]:63336 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726953AbhANChn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 21:37:43 -0500
IronPort-SDR: JMBuCPCe4vsyQl5jkIzu/5NdAbxdWeoqZXM2FgCadACA/aFjs1gdVAtMfSXUEkIZkzvRqLF6vD
 C31dCgVk4WxQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9863"; a="165387114"
X-IronPort-AV: E=Sophos;i="5.79,345,1602572400"; 
   d="yaml'?scan'208";a="165387114"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2021 18:36:33 -0800
IronPort-SDR: /24teML4sqhWNw3Hxj2GWgcnSWJ9yuA7qRZpz9196qjTl0en7bMxX+eKz+k1ZC2elmeb+mJHBL
 5yvUp5PVGsiA==
X-IronPort-AV: E=Sophos;i="5.79,346,1602572400"; 
   d="yaml'?scan'208";a="382098735"
Received: from xsang-optiplex-9020.sh.intel.com (HELO xsang-OptiPlex-9020) ([10.239.159.140])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2021 18:36:24 -0800
Date:   Thu, 14 Jan 2021 10:51:51 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     Roman Gushchin <guro@fb.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Shakeel Butt <shakeelb@google.com>,
        Christoph Lameter <cl@linux.com>,
        Michal Hocko <mhocko@kernel.org>, Tejun Heo <tj@kernel.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com, ying.huang@intel.com, feng.tang@intel.com,
        zhengjun.xing@intel.com
Subject: [mm]  10befea91b:  hackbench.throughput -62.4% regression
Message-ID: <20210114025151.GA22932@xsang-OptiPlex-9020>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="dc+cDN39EJAMEtIO"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: NeoMutt/20170113 (1.7.2)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--dc+cDN39EJAMEtIO
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit


Greeting,

FYI, we noticed a -62.4% regression of hackbench.throughput due to commit:


commit: 10befea91b61c4e2c2d1df06a2e978d182fcf792 ("mm: memcg/slab: use a single set of kmem_caches for all allocations")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

please be noted the comparison is upon commit:
commit: 286e04b8ed7a04279ae277f0f024430246ea5eec ("mm: memcg/slab: allocate obj_cgroups for non-root slab pages")

since kernel test robot ran into kernel panic upon commits between these two commits:
15999eef7f25e2 mm: memcg/slab: remove redundant check in memcg_accumulate_slabinfo()
c7094406fcb7cd mm: memcg/slab: deprecate slab_root_caches
272911a4ad18c4 mm: memcg/slab: remove memcg_kmem_get_cache()
d797b7d05405c5 mm: memcg/slab: simplify memcg cache creation
9855609bde03e2 mm: memcg/slab: use a single set of kmem_caches for all accounted allocations
0f876e4dc55db5 mm: memcg/slab: move memcg_kmem_bypass() to memcontrol.h
4330a26bc4527f mm: memcg/slab: deprecate memory.kmem.slabinfo
f2fe7b09a52bc8 mm: memcg/slab: charge individual slab objects instead of pages
964d4bd370d559 mm: memcg/slab: save obj_cgroup for non-root slab objects


in testcase: hackbench
on test machine: 96 threads Intel(R) Xeon(R) Gold 6252 CPU @ 2.10GHz with 512G memory
with following parameters:

	nr_threads: 100%
	iterations: 4
	mode: process
	ipc: socket
	cpufreq_governor: performance
	ucode: 0x5003003

test-description: Hackbench is both a benchmark and a stress test for the Linux kernel scheduler.
test-url: https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/sched/cfs-scheduler/hackbench.c



If you fix the issue, kindly add following tag
Reported-by: kernel test robot <oliver.sang@intel.com>


Details are as below:


To reproduce:

        git clone https://github.com/intel/lkp-tests.git
        cd lkp-tests
        bin/lkp install job.yaml  # job file is attached in this email
        bin/lkp run     job.yaml


=========================================================================================
compiler/cpufreq_governor/ipc/iterations/kconfig/mode/nr_threads/rootfs/tbox_group/testcase/ucode:
  gcc-9/performance/socket/4/x86_64-rhel-8.3/process/100%/debian-10.4-x86_64-20200603.cgz/lkp-csl-2sp7/hackbench/0x5003003

commit: 
  286e04b8ed7a04279ae277f0f024430246ea5eec
  10befea91b61c4e2c2d1df06a2e978d182fcf792

286e04b8ed7a0427 10befea91b61c4e2c2d1df06a2e 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
    192062 ±  9%     -62.4%      72220 ± 16%  hackbench.throughput
    265.19 ±  6%    +142.8%     643.99 ± 15%  hackbench.time.elapsed_time
    265.19 ±  6%    +142.8%     643.99 ± 15%  hackbench.time.elapsed_time.max
  1.07e+09 ± 16%     -75.8%  2.584e+08 ± 15%  hackbench.time.involuntary_context_switches
      2527            -0.3%       2519        hackbench.time.maximum_resident_set_size
    655081            +8.3%     709713 ±  2%  hackbench.time.minor_page_faults
      4096            +0.0%       4096        hackbench.time.page_size
      9315            +0.7%       9376        hackbench.time.percent_of_cpu_this_job_got
     21937 ±  3%    +161.9%      57445 ± 15%  hackbench.time.system_time
      2769 ± 46%      +6.9%       2960 ±112%  hackbench.time.user_time
 1.766e+09 ± 13%     -65.2%  6.137e+08 ± 11%  hackbench.time.voluntary_context_switches
    465.70            -2.4%     454.39 ±  2%  pmeter.Average_Active_Power
    291.07 ±  5%    +130.0%     669.53 ± 14%  uptime.boot
      2236 ±  4%     +22.1%       2731 ±  5%  uptime.idle
     23.11 ±  2%      -2.3%      22.57 ±  4%  boot-time.boot
     16.84 ±  2%      -2.6%      16.40 ±  5%  boot-time.dhcp
      1724 ±  4%      -1.0%       1706 ±  4%  boot-time.idle
      0.97 ± 11%      -4.8%       0.92 ± 10%  boot-time.smp_boot
      1.37 ± 11%      -0.1        1.23 ± 15%  mpstat.cpu.all.idle%
      0.06 ±  6%      -0.0        0.03 ± 21%  mpstat.cpu.all.iowait%
      1.80 ±  6%      -0.7        1.13 ±  6%  mpstat.cpu.all.irq%
      0.03 ± 20%      -0.0        0.03 ±  6%  mpstat.cpu.all.soft%
     86.33 ±  5%      +6.4       92.77 ±  5%  mpstat.cpu.all.sys%
     10.41 ± 42%      -5.6        4.82 ±107%  mpstat.cpu.all.usr%
  56354572 ± 34%    +583.5%  3.852e+08 ±  8%  cpuidle.C1.time
   4115457 ± 47%    +569.3%   27543925 ±  6%  cpuidle.C1.usage
 2.087e+08 ± 39%     +19.8%    2.5e+08 ± 46%  cpuidle.C1E.time
   1295802 ±  7%     +99.1%    2579571 ±  9%  cpuidle.C1E.usage
 1.241e+08 ± 65%      -1.8%  1.218e+08 ± 77%  cpuidle.C6.time
    196169 ± 58%      +3.5%     203054 ± 69%  cpuidle.C6.usage
  10968076 ± 16%      +2.8%   11277027 ± 21%  cpuidle.POLL.time
   3752481 ± 12%     -10.3%    3365008 ± 22%  cpuidle.POLL.usage
      0.00          -100.0%       0.00        numa-numastat.node0.interleave_hit
   1315155 ± 19%     +23.0%    1617901 ± 26%  numa-numastat.node0.local_node
   1372818 ± 18%     +19.4%    1639154 ± 25%  numa-numastat.node0.numa_hit
     57667 ± 57%     -63.1%      21260 ±135%  numa-numastat.node0.other_node
      0.00          -100.0%       0.00        numa-numastat.node1.interleave_hit
   1801045 ± 21%     -35.1%    1168396 ± 30%  numa-numastat.node1.local_node
   1830008 ± 20%     -32.6%    1233799 ± 28%  numa-numastat.node1.numa_hit
     28971 ±113%    +125.8%      65415 ± 43%  numa-numastat.node1.other_node
    265.19 ±  6%    +142.8%     643.99 ± 15%  time.elapsed_time
    265.19 ±  6%    +142.8%     643.99 ± 15%  time.elapsed_time.max
  1.07e+09 ± 16%     -75.8%  2.584e+08 ± 15%  time.involuntary_context_switches
      2527            -0.3%       2519        time.maximum_resident_set_size
    655081            +8.3%     709713 ±  2%  time.minor_page_faults
      4096            +0.0%       4096        time.page_size
      9315            +0.7%       9376        time.percent_of_cpu_this_job_got
     21937 ±  3%    +161.9%      57445 ± 15%  time.system_time
      2769 ± 46%      +6.9%       2960 ±112%  time.user_time
 1.766e+09 ± 13%     -65.2%  6.137e+08 ± 11%  time.voluntary_context_switches
      1.50 ± 33%     -23.8%       1.14 ± 30%  vmstat.cpu.id
     86.83 ±  4%      +7.4%      93.29 ±  5%  vmstat.cpu.sy
      9.50 ± 47%     -56.4%       4.14 ±120%  vmstat.cpu.us
      0.00          -100.0%       0.00        vmstat.cpu.wa
      0.00          -100.0%       0.00        vmstat.io.bi
      0.00          -100.0%       0.00        vmstat.io.bo
   1731758 ± 19%    +110.0%    3637196 ±  8%  vmstat.memory.cache
  5.24e+08            -0.3%  5.223e+08        vmstat.memory.free
     38.50 ± 21%     -55.5%      17.14 ± 25%  vmstat.procs.b
      2077 ±  3%     -24.6%       1566 ±  6%  vmstat.procs.r
  10680106 ± 18%     -86.6%    1433241 ± 20%  vmstat.system.cs
    883472 ± 10%     -55.6%     392398 ±  8%  vmstat.system.in
    625826 ± 14%    +240.0%    2128057 ±  6%  meminfo.Active
    625826 ± 14%    +240.0%    2128057 ±  6%  meminfo.Active(anon)
    156100 ±  3%     +30.6%     203827 ±  4%  meminfo.AnonHugePages
    388789 ±  2%      +3.9%     403991 ±  2%  meminfo.AnonPages
   1605922 ± 19%    +120.0%    3532840 ±  9%  meminfo.Cached
    200976            +0.0%     200976        meminfo.CmaFree
    204800            +0.0%     204800        meminfo.CmaTotal
  2.64e+08            +0.0%   2.64e+08        meminfo.CommitLimit
   3105927 ± 10%     +61.1%    5002570 ±  7%  meminfo.Committed_AS
 5.058e+08            -0.3%  5.042e+08        meminfo.DirectMap1G
  32164522 ± 13%      +4.8%   33701888 ± 14%  meminfo.DirectMap2M
    716228 ±  4%      +1.5%     726760 ±  3%  meminfo.DirectMap4k
      2048            +0.0%       2048        meminfo.Hugepagesize
    419724 ± 94%    +104.8%     859691 ± 40%  meminfo.Inactive
    419724 ± 94%    +104.8%     859691 ± 40%  meminfo.Inactive(anon)
    123452            -6.7%     115233        meminfo.KReclaimable
     72689            +1.9%      74103        meminfo.KernelStack
    310549 ± 28%    +110.5%     653588 ± 36%  meminfo.Mapped
 5.218e+08            -0.3%  5.201e+08        meminfo.MemAvailable
  5.24e+08            -0.3%  5.223e+08        meminfo.MemFree
  5.28e+08            +0.0%   5.28e+08        meminfo.MemTotal
   4070523 ±  8%     +42.2%    5786629 ±  6%  meminfo.Memused
    817.00 ±100%     +72.1%       1406 ± 29%  meminfo.Mlocked
     90700 ±  4%      +2.6%      93096 ±  2%  meminfo.PageTables
     46966            -3.5%      45309        meminfo.Percpu
    123452            -6.7%     115233        meminfo.SReclaimable
    432306 ±  2%      +3.3%     446646        meminfo.SUnreclaim
    657436 ± 48%    +293.1%    2584404 ± 12%  meminfo.Shmem
    555758 ±  2%      +1.1%     561880        meminfo.Slab
    948603            +0.0%     948639        meminfo.Unevictable
 3.436e+10            +0.0%  3.436e+10        meminfo.VmallocTotal
    300530            +0.4%     301653        meminfo.VmallocUsed
     25712 ±  9%     -50.3%      12785 ± 19%  meminfo.max_used_kB
    150954 ± 54%    +701.3%    1209664 ± 37%  numa-meminfo.node0.Active
    150954 ± 54%    +701.3%    1209664 ± 37%  numa-meminfo.node0.Active(anon)
     59761 ± 77%     +78.6%     106762 ± 44%  numa-meminfo.node0.AnonHugePages
    148848 ± 54%     +55.6%     231565 ± 20%  numa-meminfo.node0.AnonPages
    212630 ± 39%     +66.0%     352882 ± 15%  numa-meminfo.node0.AnonPages.max
    477539 ±  3%    +322.2%    2016352 ± 40%  numa-meminfo.node0.FilePages
      1078 ± 38%  +51673.6%     558465 ± 78%  numa-meminfo.node0.Inactive
      1078 ± 38%  +51673.6%     558465 ± 78%  numa-meminfo.node0.Inactive(anon)
     53722 ± 32%     +22.6%      65857 ± 17%  numa-meminfo.node0.KReclaimable
     30933 ± 70%     +61.5%      49956 ± 33%  numa-meminfo.node0.KernelStack
     87106 ± 25%    +315.0%     361464 ± 75%  numa-meminfo.node0.Mapped
 2.622e+08            -0.6%  2.605e+08        numa-meminfo.node0.MemFree
 2.638e+08            +0.0%  2.638e+08        numa-meminfo.node0.MemTotal
   1621522 ± 20%    +103.8%    3303908 ± 28%  numa-meminfo.node0.MemUsed
    428.83 ±102%     +78.1%     763.86 ± 26%  numa-meminfo.node0.Mlocked
     36368 ± 90%     +83.5%      66738 ± 36%  numa-meminfo.node0.PageTables
     53722 ± 32%     +22.6%      65857 ± 17%  numa-meminfo.node0.SReclaimable
    199639 ± 35%     +32.6%     264691 ± 18%  numa-meminfo.node0.SUnreclaim
      3536 ± 68%  +43354.4%    1536764 ± 52%  numa-meminfo.node0.Shmem
    253362 ± 34%     +30.5%     330549 ± 16%  numa-meminfo.node0.Slab
    474082 ±  3%      +1.2%     479749 ±  3%  numa-meminfo.node0.Unevictable
    474111 ± 24%     +94.4%     921679 ± 53%  numa-meminfo.node1.Active
    474111 ± 24%     +94.4%     921679 ± 53%  numa-meminfo.node1.Active(anon)
     96277 ± 46%      +1.2%      97463 ± 46%  numa-meminfo.node1.AnonHugePages
    239485 ± 32%     -28.0%     172398 ± 27%  numa-meminfo.node1.AnonPages
    344076 ± 22%     -21.0%     271685 ± 26%  numa-meminfo.node1.AnonPages.max
   1125118 ± 28%     +35.1%    1519520 ± 46%  numa-meminfo.node1.FilePages
    415713 ± 93%     -27.6%     300949 ± 74%  numa-meminfo.node1.Inactive
    415713 ± 93%     -27.6%     300949 ± 74%  numa-meminfo.node1.Inactive(anon)
     69745 ± 25%     -29.2%      49398 ± 25%  numa-meminfo.node1.KReclaimable
     41510 ± 52%     -41.9%      24103 ± 68%  numa-meminfo.node1.KernelStack
    222816 ± 29%     +31.4%     292683 ± 42%  numa-meminfo.node1.Mapped
 2.618e+08            -0.0%  2.617e+08        numa-meminfo.node1.MemFree
 2.642e+08            +0.0%  2.642e+08        numa-meminfo.node1.MemTotal
   2444267 ± 21%      +1.7%    2484927 ± 33%  numa-meminfo.node1.MemUsed
    388.33 ±101%     +65.5%     642.71 ± 38%  numa-meminfo.node1.Mlocked
     53891 ± 64%     -51.2%      26291 ± 93%  numa-meminfo.node1.PageTables
     69745 ± 25%     -29.2%      49398 ± 25%  numa-meminfo.node1.SReclaimable
    232076 ± 32%     -21.6%     181943 ± 27%  numa-meminfo.node1.SUnreclaim
    650635 ± 47%     +61.5%    1050672 ± 65%  numa-meminfo.node1.Shmem
    301822 ± 30%     -23.4%     231343 ± 24%  numa-meminfo.node1.Slab
    474520 ±  3%      -1.2%     468889 ±  3%  numa-meminfo.node1.Unevictable
     37645 ± 54%    +702.4%     302069 ± 37%  numa-vmstat.node0.nr_active_anon
     37120 ± 54%     +56.0%      57913 ± 20%  numa-vmstat.node0.nr_anon_pages
     28.67 ± 78%     +79.9%      51.57 ± 44%  numa-vmstat.node0.nr_anon_transparent_hugepages
    119387 ±  3%    +322.4%     504241 ± 40%  numa-vmstat.node0.nr_file_pages
  65556196            -0.6%   65134810        numa-vmstat.node0.nr_free_pages
    269.67 ± 38%  +51867.1%     140137 ± 79%  numa-vmstat.node0.nr_inactive_anon
      0.00          -100.0%       0.00        numa-vmstat.node0.nr_isolated_anon
     30786 ± 70%     +62.4%      49982 ± 32%  numa-vmstat.node0.nr_kernel_stack
     21982 ± 25%    +309.8%      90079 ± 76%  numa-vmstat.node0.nr_mapped
    107.83 ±102%     +76.3%     190.14 ± 26%  numa-vmstat.node0.nr_mlock
      9032 ± 90%     +84.8%      16690 ± 36%  numa-vmstat.node0.nr_page_table_pages
    886.67 ± 68%  +43247.1%     384344 ± 52%  numa-vmstat.node0.nr_shmem
     13435 ± 32%     +22.5%      16463 ± 17%  numa-vmstat.node0.nr_slab_reclaimable
     49870 ± 35%     +32.7%      66158 ± 18%  numa-vmstat.node0.nr_slab_unreclaimable
    118520 ±  3%      +1.2%     119936 ±  3%  numa-vmstat.node0.nr_unevictable
     37645 ± 54%    +702.4%     302069 ± 37%  numa-vmstat.node0.nr_zone_active_anon
    269.67 ± 38%  +51867.0%     140137 ± 79%  numa-vmstat.node0.nr_zone_inactive_anon
    118520 ±  3%      +1.2%     119936 ±  3%  numa-vmstat.node0.nr_zone_unevictable
   1387604 ± 20%     +26.6%    1756689 ± 24%  numa-vmstat.node0.numa_hit
    145345            -0.0%     145323        numa-vmstat.node0.numa_interleave
   1269412 ± 23%     +33.8%    1698072 ± 23%  numa-vmstat.node0.numa_local
    118191 ± 40%     -50.4%      58616 ± 88%  numa-vmstat.node0.numa_other
    119516 ± 24%     +92.4%     229993 ± 53%  numa-vmstat.node1.nr_active_anon
     59910 ± 32%     -28.1%      43084 ± 27%  numa-vmstat.node1.nr_anon_pages
     46.67 ± 47%      +0.7%      47.00 ± 46%  numa-vmstat.node1.nr_anon_transparent_hugepages
    283023 ± 28%     +34.2%     379709 ± 46%  numa-vmstat.node1.nr_file_pages
     50244            +0.0%      50244        numa-vmstat.node1.nr_free_cma
  65437553            -0.0%   65429170        numa-vmstat.node1.nr_free_pages
    104724 ± 93%     -27.9%      75478 ± 75%  numa-vmstat.node1.nr_inactive_anon
      0.00       +1.4e+101%       0.14 ±244%  numa-vmstat.node1.nr_isolated_anon
     41510 ± 52%     -42.0%      24057 ± 68%  numa-vmstat.node1.nr_kernel_stack
     56138 ± 29%     +30.4%      73193 ± 42%  numa-vmstat.node1.nr_mapped
     97.83 ±101%     +63.7%     160.14 ± 38%  numa-vmstat.node1.nr_mlock
     13486 ± 64%     -51.4%       6559 ± 93%  numa-vmstat.node1.nr_page_table_pages
    164402 ± 47%     +59.7%     262498 ± 65%  numa-vmstat.node1.nr_shmem
     17454 ± 25%     -29.2%      12351 ± 25%  numa-vmstat.node1.nr_slab_reclaimable
     58073 ± 32%     -21.7%      45453 ± 27%  numa-vmstat.node1.nr_slab_unreclaimable
    118629 ±  3%      -1.2%     117221 ±  3%  numa-vmstat.node1.nr_unevictable
    119516 ± 24%     +92.4%     229993 ± 53%  numa-vmstat.node1.nr_zone_active_anon
    104724 ± 93%     -27.9%      75478 ± 75%  numa-vmstat.node1.nr_zone_inactive_anon
    118629 ±  3%      -1.2%     117221 ±  3%  numa-vmstat.node1.nr_zone_unevictable
   1680766 ± 16%     -18.0%    1377731 ± 28%  numa-vmstat.node1.numa_hit
    145332            -0.0%     145328        numa-vmstat.node1.numa_interleave
   1562901 ± 17%     -23.3%    1199323 ± 29%  numa-vmstat.node1.numa_local
    117865 ± 40%     +51.4%     178407 ± 29%  numa-vmstat.node1.numa_other
      0.00          -100.0%       0.00        proc-vmstat.compact_isolated
    156441 ± 14%    +240.5%     532665 ±  6%  proc-vmstat.nr_active_anon
     97198 ±  2%      +3.9%     100972 ±  2%  proc-vmstat.nr_anon_pages
     75.50 ±  3%     +31.1%      99.00 ±  4%  proc-vmstat.nr_anon_transparent_hugepages
  13025555            -0.3%   12982666        proc-vmstat.nr_dirty_background_threshold
  26082959            -0.3%   25997076        proc-vmstat.nr_dirty_threshold
    401530 ± 19%    +120.2%     884037 ±  8%  proc-vmstat.nr_file_pages
     50244            +0.0%      50244        proc-vmstat.nr_free_cma
  1.31e+08            -0.3%  1.306e+08        proc-vmstat.nr_free_pages
    105004 ± 94%    +104.8%     215083 ± 39%  proc-vmstat.nr_inactive_anon
      0.67 ±165%     -78.6%       0.14 ±244%  proc-vmstat.nr_isolated_anon
     72667            +1.9%      74075        proc-vmstat.nr_kernel_stack
     77772 ± 28%    +110.0%     163358 ± 35%  proc-vmstat.nr_mapped
    204.33 ±100%     +72.1%     351.57 ± 29%  proc-vmstat.nr_mlock
     22669 ±  4%      +2.6%      23266 ±  2%  proc-vmstat.nr_page_table_pages
    164408 ± 48%    +293.5%     646928 ± 12%  proc-vmstat.nr_shmem
     30868            -6.7%      28812        proc-vmstat.nr_slab_reclaimable
    108091 ±  2%      +3.3%     111667        proc-vmstat.nr_slab_unreclaimable
    237150            +0.0%     237159        proc-vmstat.nr_unevictable
    156441 ± 14%    +240.5%     532665 ±  6%  proc-vmstat.nr_zone_active_anon
    105004 ± 94%    +104.8%     215083 ± 39%  proc-vmstat.nr_zone_inactive_anon
    237150            +0.0%     237159        proc-vmstat.nr_zone_unevictable
    144040 ± 28%    +141.7%     348208 ±  7%  proc-vmstat.numa_hint_faults
     55109 ± 43%    +207.2%     169272 ± 10%  proc-vmstat.numa_hint_faults_local
   3220477 ± 12%     -10.0%    2897925 ±  3%  proc-vmstat.numa_hit
    209.00 ± 19%    +168.8%     561.86 ± 38%  proc-vmstat.numa_huge_pte_updates
      0.00          -100.0%       0.00        proc-vmstat.numa_interleave
   3133830 ± 13%     -10.3%    2811237 ±  3%  proc-vmstat.numa_local
     86646            +0.0%      86688        proc-vmstat.numa_other
     66591 ± 12%     +89.7%     126324 ±  9%  proc-vmstat.numa_pages_migrated
    379412 ± 13%    +106.5%     783327 ± 15%  proc-vmstat.numa_pte_updates
    186531 ± 38%    +313.0%     770405 ± 13%  proc-vmstat.pgactivate
      0.00          -100.0%       0.00        proc-vmstat.pgalloc_dma
      0.00          -100.0%       0.00        proc-vmstat.pgalloc_dma32
   6779860 ± 20%     -49.5%    3425027 ±  3%  proc-vmstat.pgalloc_normal
   1475383 ±  4%     +81.6%    2678959 ±  7%  proc-vmstat.pgfault
   6471817 ± 22%     -59.1%    2647493 ±  4%  proc-vmstat.pgfree
     66591 ± 12%     +89.7%     126324 ±  9%  proc-vmstat.pgmigrate_success
      0.00          -100.0%       0.00        proc-vmstat.pgpgin
      0.00          -100.0%       0.00        proc-vmstat.pgpgout
    105.67 ± 17%     +50.3%     158.86        proc-vmstat.thp_collapse_alloc
      0.00       +2.9e+101%       0.29 ±158%  proc-vmstat.thp_deferred_split_page
     12.00            +1.2%      12.14 ±  2%  proc-vmstat.thp_fault_alloc
      0.00       +2.9e+101%       0.29 ±158%  proc-vmstat.thp_split_pmd
      0.00          -100.0%       0.00        proc-vmstat.thp_zero_page_alloc
     59.33 ± 71%     +71.2%     101.57        proc-vmstat.unevictable_pgs_culled
    293.00 ±100%    +100.0%     586.00        proc-vmstat.unevictable_pgs_mlocked
     10.01           +58.8%      15.89 ±  2%  perf-stat.i.MPKI
 2.783e+10 ±  9%     -67.9%  8.931e+09 ± 15%  perf-stat.i.branch-instructions
      1.42            -0.1        1.27        perf-stat.i.branch-miss-rate%
 3.851e+08 ±  9%     -70.4%   1.14e+08 ± 14%  perf-stat.i.branch-misses
      8.67 ±  6%     +15.4       24.11        perf-stat.i.cache-miss-rate%
  1.15e+08 ±  9%     +57.9%  1.816e+08 ± 17%  perf-stat.i.cache-misses
 1.361e+09 ±  9%     -44.8%   7.52e+08 ± 17%  perf-stat.i.cache-references
  10813035 ± 17%     -86.0%    1515085 ± 19%  perf-stat.i.context-switches
      1.82 ± 10%    +217.3%       5.78 ± 14%  perf-stat.i.cpi
     96026            +0.2%      96173        perf-stat.i.cpu-clock
 2.474e+11            +6.7%   2.64e+11        perf-stat.i.cpu-cycles
    520764 ± 13%     -71.1%     150289 ± 20%  perf-stat.i.cpu-migrations
      3064 ± 10%     -50.4%       1521 ± 17%  perf-stat.i.cycles-between-cache-misses
      0.16 ± 22%      +0.0        0.17 ± 22%  perf-stat.i.dTLB-load-miss-rate%
  64485057 ± 23%     -62.5%   24156755 ± 29%  perf-stat.i.dTLB-load-misses
 4.007e+10 ±  9%     -65.2%  1.396e+10 ± 15%  perf-stat.i.dTLB-loads
      0.02 ± 36%      +0.0        0.05 ± 14%  perf-stat.i.dTLB-store-miss-rate%
   5051026 ± 31%      -9.2%    4587608 ± 23%  perf-stat.i.dTLB-store-misses
 2.448e+10 ±  9%     -65.1%  8.534e+09 ± 15%  perf-stat.i.dTLB-stores
     74.47 ±  2%     +13.3       87.80        perf-stat.i.iTLB-load-miss-rate%
 2.427e+08 ±  7%     -68.5%   76361655 ± 15%  perf-stat.i.iTLB-load-misses
  84952796 ± 14%     -85.7%   12165654 ± 18%  perf-stat.i.iTLB-loads
 1.396e+11 ±  9%     -65.9%  4.761e+10 ± 15%  perf-stat.i.instructions
    589.30 ±  2%      +8.2%     637.40        perf-stat.i.instructions-per-iTLB-miss
      0.57 ± 10%     -67.8%       0.18 ± 15%  perf-stat.i.ipc
      2.58            +6.5%       2.75        perf-stat.i.metric.GHz
      0.09 ±  7%    +563.5%       0.59 ± 10%  perf-stat.i.metric.K/sec
    978.11 ±  9%     -65.7%     335.44 ± 15%  perf-stat.i.metric.M/sec
      5395 ±  3%     -17.5%       4451 ±  6%  perf-stat.i.minor-faults
     68.08 ±  6%      -5.4       62.65        perf-stat.i.node-load-miss-rate%
  35412696 ± 17%     -17.3%   29277987 ± 16%  perf-stat.i.node-load-misses
  10785299 ± 19%     +41.9%   15302466 ± 16%  perf-stat.i.node-loads
     69.00 ±  8%      -2.2       66.81 ±  2%  perf-stat.i.node-store-miss-rate%
  14783449 ± 17%     +45.9%   21573137 ± 18%  perf-stat.i.node-store-misses
   4741913 ± 43%    +111.5%   10030729 ± 16%  perf-stat.i.node-stores
      5396 ±  3%     -17.5%       4452 ±  6%  perf-stat.i.page-faults
     96026            +0.2%      96173        perf-stat.i.task-clock
      9.75           +61.6%      15.76 ±  2%  perf-stat.overall.MPKI
      1.38            -0.1        1.27        perf-stat.overall.branch-miss-rate%
      8.47 ±  6%     +15.7       24.19        perf-stat.overall.cache-miss-rate%
      1.79 ± 10%    +219.6%       5.72 ± 14%  perf-stat.overall.cpi
      2174 ± 11%     -30.6%       1509 ± 17%  perf-stat.overall.cycles-between-cache-misses
      0.16 ± 22%      +0.0        0.17 ± 22%  perf-stat.overall.dTLB-load-miss-rate%
      0.02 ± 37%      +0.0        0.05 ± 13%  perf-stat.overall.dTLB-store-miss-rate%
     74.26 ±  2%     +12.5       86.78        perf-stat.overall.iTLB-load-miss-rate%
    574.40 ±  2%      +8.8%     625.19        perf-stat.overall.instructions-per-iTLB-miss
      0.57 ± 10%     -68.3%       0.18 ± 16%  perf-stat.overall.ipc
     75.94 ±  7%     -11.3       64.62 ±  2%  perf-stat.overall.node-load-miss-rate%
     75.16 ± 14%      -7.8       67.34 ±  3%  perf-stat.overall.node-store-miss-rate%
 2.773e+10 ±  9%     -68.1%  8.847e+09 ± 15%  perf-stat.ps.branch-instructions
 3.834e+08 ±  9%     -70.7%  1.123e+08 ± 15%  perf-stat.ps.branch-misses
 1.147e+08 ±  9%     +57.5%  1.805e+08 ± 18%  perf-stat.ps.cache-misses
 1.357e+09 ±  9%     -45.0%  7.458e+08 ± 17%  perf-stat.ps.cache-references
  10743734 ± 18%     -86.7%    1431992 ± 20%  perf-stat.ps.context-switches
     95634            +0.2%      95845        perf-stat.ps.cpu-clock
 2.465e+11            +7.0%  2.637e+11        perf-stat.ps.cpu-cycles
    515367 ± 14%     -73.1%     138611 ± 22%  perf-stat.ps.cpu-migrations
  64242182 ± 23%     -62.9%   23821658 ± 29%  perf-stat.ps.dTLB-load-misses
 3.993e+10 ±  9%     -65.3%  1.384e+10 ± 15%  perf-stat.ps.dTLB-loads
   5069354 ± 31%      -9.1%    4606401 ± 23%  perf-stat.ps.dTLB-store-misses
 2.439e+10 ±  9%     -65.3%  8.461e+09 ± 15%  perf-stat.ps.dTLB-stores
 2.418e+08 ±  7%     -68.8%   75519987 ± 16%  perf-stat.ps.iTLB-load-misses
  84401166 ± 14%     -86.4%   11509680 ± 19%  perf-stat.ps.iTLB-loads
 1.391e+11 ±  9%     -66.1%  4.719e+10 ± 15%  perf-stat.ps.instructions
      5290 ±  3%     -22.9%       4081 ±  8%  perf-stat.ps.minor-faults
  35146656 ± 17%     -19.4%   28321222 ± 17%  perf-stat.ps.node-load-misses
  10880282 ± 19%     +42.0%   15452395 ± 15%  perf-stat.ps.node-loads
  14622074 ± 18%     +44.5%   21126988 ± 19%  perf-stat.ps.node-store-misses
   4819476 ± 44%    +110.9%   10165556 ± 15%  perf-stat.ps.node-stores
      5290 ±  3%     -22.9%       4081 ±  8%  perf-stat.ps.page-faults
     95634            +0.2%      95845        perf-stat.ps.task-clock
 3.689e+13 ±  5%     -19.4%  2.974e+13        perf-stat.total.instructions
     11961 ±184%    +178.1%      33259 ±107%  sched_debug.cfs_rq:/.MIN_vruntime.avg
   1148172 ±184%    +121.9%    2547565 ±111%  sched_debug.cfs_rq:/.MIN_vruntime.max
      0.00            +0.0%       0.00        sched_debug.cfs_rq:/.MIN_vruntime.min
    116580 ±184%    +144.0%     284416 ±107%  sched_debug.cfs_rq:/.MIN_vruntime.stddev
     10571 ±  2%     +25.3%      13247 ±  2%  sched_debug.cfs_rq:/.load.avg
     27317 ± 15%     +48.7%      40610 ± 69%  sched_debug.cfs_rq:/.load.max
      2984 ± 26%     -32.1%       2025 ± 26%  sched_debug.cfs_rq:/.load.min
      4824 ± 16%     +36.4%       6578 ± 43%  sched_debug.cfs_rq:/.load.stddev
     55.45 ±141%     -35.7%      35.66 ±137%  sched_debug.cfs_rq:/.load_avg.avg
      1780 ±195%     -50.0%     890.89 ±212%  sched_debug.cfs_rq:/.load_avg.max
      2.77 ± 16%      +4.2%       2.88 ± 17%  sched_debug.cfs_rq:/.load_avg.min
    266.90 ±188%     -47.4%     140.42 ±209%  sched_debug.cfs_rq:/.load_avg.stddev
     11961 ±184%    +178.1%      33259 ±107%  sched_debug.cfs_rq:/.max_vruntime.avg
   1148172 ±184%    +121.9%    2547565 ±111%  sched_debug.cfs_rq:/.max_vruntime.max
      0.00            +0.0%       0.00        sched_debug.cfs_rq:/.max_vruntime.min
    116580 ±184%    +144.0%     284416 ±107%  sched_debug.cfs_rq:/.max_vruntime.stddev
  11718836          +131.0%   27068040 ± 17%  sched_debug.cfs_rq:/.min_vruntime.avg
  13002693 ±  2%    +124.0%   29130561 ± 17%  sched_debug.cfs_rq:/.min_vruntime.max
  10815027 ±  2%    +137.5%   25687586 ± 18%  sched_debug.cfs_rq:/.min_vruntime.min
    448721 ±  5%     +67.8%     752852 ± 20%  sched_debug.cfs_rq:/.min_vruntime.stddev
      0.82           +11.1%       0.92        sched_debug.cfs_rq:/.nr_running.avg
      1.00            +1.1%       1.01 ±  2%  sched_debug.cfs_rq:/.nr_running.max
      0.43 ± 41%     +15.4%       0.50 ± 16%  sched_debug.cfs_rq:/.nr_running.min
      0.12 ± 17%     -28.8%       0.08 ± 14%  sched_debug.cfs_rq:/.nr_running.stddev
      4.13 ± 74%     -60.2%       1.64 ± 72%  sched_debug.cfs_rq:/.removed.load_avg.avg
    167.73 ± 44%     -62.7%      62.57 ± 65%  sched_debug.cfs_rq:/.removed.load_avg.max
     24.92 ± 52%     -61.0%       9.72 ± 65%  sched_debug.cfs_rq:/.removed.load_avg.stddev
      1.31 ± 76%     -51.3%       0.64 ± 84%  sched_debug.cfs_rq:/.removed.runnable_avg.avg
     60.40 ± 58%     -55.5%      26.89 ± 67%  sched_debug.cfs_rq:/.removed.runnable_avg.max
      8.06 ± 62%     -52.3%       3.85 ± 74%  sched_debug.cfs_rq:/.removed.runnable_avg.stddev
      1.31 ± 76%     -51.3%       0.64 ± 84%  sched_debug.cfs_rq:/.removed.util_avg.avg
     60.40 ± 58%     -55.5%      26.89 ± 67%  sched_debug.cfs_rq:/.removed.util_avg.max
      8.06 ± 62%     -52.3%       3.85 ± 74%  sched_debug.cfs_rq:/.removed.util_avg.stddev
     14869 ± 29%      -8.1%      13667 ± 12%  sched_debug.cfs_rq:/.runnable_avg.avg
     23961 ± 24%      -0.4%      23870 ± 13%  sched_debug.cfs_rq:/.runnable_avg.max
      6632 ± 39%     -29.0%       4707 ± 17%  sched_debug.cfs_rq:/.runnable_avg.min
      3491 ± 19%      +7.8%       3763 ± 16%  sched_debug.cfs_rq:/.runnable_avg.stddev
   -239290          +338.0%   -1048047        sched_debug.cfs_rq:/.spread0.avg
    981216 ± 25%      +3.3%    1013511 ± 64%  sched_debug.cfs_rq:/.spread0.max
  -1094334          +122.0%   -2429556        sched_debug.cfs_rq:/.spread0.min
    421345 ±  6%     +77.9%     749575 ± 20%  sched_debug.cfs_rq:/.spread0.stddev
    861.24 ±  2%      +0.8%     867.73 ±  2%  sched_debug.cfs_rq:/.util_avg.avg
      1365 ±  3%      +0.8%       1376        sched_debug.cfs_rq:/.util_avg.max
    500.17 ± 11%     -12.4%     438.10 ±  6%  sched_debug.cfs_rq:/.util_avg.min
    169.30 ±  5%      +7.5%     182.04 ±  2%  sched_debug.cfs_rq:/.util_avg.stddev
    587.53 ± 19%      +5.5%     619.56 ± 12%  sched_debug.cfs_rq:/.util_est_enqueued.avg
      1400 ±  3%     +11.8%       1565 ± 10%  sched_debug.cfs_rq:/.util_est_enqueued.max
     76.13 ± 79%     -89.9%       7.69 ± 34%  sched_debug.cfs_rq:/.util_est_enqueued.min
    252.11 ±  9%     +44.7%     364.78 ±  9%  sched_debug.cfs_rq:/.util_est_enqueued.stddev
    162735 ±  7%     -20.7%     129029 ±  6%  sched_debug.cpu.avg_idle.avg
   1219459 ± 61%     -21.9%     951885 ± 17%  sched_debug.cpu.avg_idle.max
      2699 ± 62%     +64.6%       4441 ± 27%  sched_debug.cpu.avg_idle.min
    157169 ± 38%     +15.2%     181112 ± 12%  sched_debug.cpu.avg_idle.stddev
    150301 ±  2%    +122.0%     333595 ± 15%  sched_debug.cpu.clock.avg
    151607 ±  2%    +120.3%     333954 ± 15%  sched_debug.cpu.clock.max
    148940          +123.7%     333217 ± 15%  sched_debug.cpu.clock.min
    785.72 ± 49%     -72.0%     220.25 ± 47%  sched_debug.cpu.clock.stddev
    147823 ±  2%    +123.1%     329799 ± 15%  sched_debug.cpu.clock_task.avg
    149458 ±  2%    +121.1%     330452 ± 15%  sched_debug.cpu.clock_task.max
    141552          +129.5%     324852 ± 15%  sched_debug.cpu.clock_task.min
      1169 ± 26%     -42.5%     672.20 ± 14%  sched_debug.cpu.clock_task.stddev
      9747           +44.8%      14111 ±  7%  sched_debug.cpu.curr->pid.avg
     12186           +43.4%      17481 ±  6%  sched_debug.cpu.curr->pid.max
      7074 ± 17%     -27.5%       5129 ± 38%  sched_debug.cpu.curr->pid.min
      1088 ±  8%     +53.2%       1667 ± 11%  sched_debug.cpu.curr->pid.stddev
    515929 ±  4%      -1.8%     506717 ±  2%  sched_debug.cpu.max_idle_balance_cost.avg
   1035825 ± 64%     -21.5%     812805 ± 58%  sched_debug.cpu.max_idle_balance_cost.max
    500000            +0.0%     500000        sched_debug.cpu.max_idle_balance_cost.min
     85246 ±129%     -56.5%      37078 ±148%  sched_debug.cpu.max_idle_balance_cost.stddev
      4294            +0.0%       4294        sched_debug.cpu.next_balance.avg
      4294            +0.0%       4294        sched_debug.cpu.next_balance.max
      4294            +0.0%       4294        sched_debug.cpu.next_balance.min
      0.00 ± 49%     -71.1%       0.00 ± 44%  sched_debug.cpu.next_balance.stddev
     14.80 ± 28%      -1.5%      14.58 ± 11%  sched_debug.cpu.nr_running.avg
     31.33 ± 23%      +9.6%      34.34 ±  9%  sched_debug.cpu.nr_running.max
      2.70 ± 79%     -81.1%       0.51 ± 20%  sched_debug.cpu.nr_running.min
      5.98 ± 22%     +44.7%       8.65 ±  9%  sched_debug.cpu.nr_running.stddev
  14059970 ± 16%     -65.7%    4823900 ± 11%  sched_debug.cpu.nr_switches.avg
  16629166 ± 12%     -60.9%    6507772 ± 10%  sched_debug.cpu.nr_switches.max
  12240624 ± 19%     -70.4%    3617537 ± 14%  sched_debug.cpu.nr_switches.min
    871104 ±  5%     -23.2%     669004 ± 26%  sched_debug.cpu.nr_switches.stddev
      0.01 ±202%     -80.3%       0.00 ±345%  sched_debug.cpu.nr_uninterruptible.avg
     77.47 ± 15%      +7.2%      83.08 ± 21%  sched_debug.cpu.nr_uninterruptible.max
   -105.57            +8.7%    -114.78        sched_debug.cpu.nr_uninterruptible.min
     35.51 ± 13%     +11.7%      39.68 ± 18%  sched_debug.cpu.nr_uninterruptible.stddev
    148911          +123.8%     333207 ± 15%  sched_debug.cpu_clk
    996147            +0.0%     996147        sched_debug.dl_rq:.dl_bw->bw.avg
    996147            +0.0%     996147        sched_debug.dl_rq:.dl_bw->bw.max
    996147            +0.0%     996147        sched_debug.dl_rq:.dl_bw->bw.min
 4.295e+09            +0.0%  4.295e+09        sched_debug.jiffies
    148349          +124.2%     332673 ± 15%  sched_debug.ktime
    950.00            +0.0%     950.00        sched_debug.rt_rq:/.rt_runtime.avg
    970.00            +1.7%     986.23        sched_debug.rt_rq:/.rt_runtime.max
    946.04            -0.3%     942.83        sched_debug.rt_rq:/.rt_runtime.min
      2.23           +81.1%       4.04 ±  5%  sched_debug.rt_rq:/.rt_runtime.stddev
      0.00        +6.3e+98%       0.00 ±244%  sched_debug.rt_rq:/.rt_time.avg
      0.00       +3.3e+100%       0.03 ±244%  sched_debug.rt_rq:/.rt_time.max
      0.00        +3.3e+99%       0.00 ±244%  sched_debug.rt_rq:/.rt_time.stddev
    149293          +123.7%     333907 ± 15%  sched_debug.sched_clk
      1.00            +0.0%       1.00        sched_debug.sched_clock_stable()
   4156219            +0.0%    4156219        sched_debug.sysctl_sched.sysctl_sched_features
     24.00            +0.0%      24.00        sched_debug.sysctl_sched.sysctl_sched_latency
      3.00            +0.0%       3.00        sched_debug.sysctl_sched.sysctl_sched_min_granularity
      1.00            +0.0%       1.00        sched_debug.sysctl_sched.sysctl_sched_tunable_scaling
      4.00            +0.0%       4.00        sched_debug.sysctl_sched.sysctl_sched_wakeup_granularity
    194402            -0.0%     194395        slabinfo.Acpi-Operand.active_objs
      3470            -0.0%       3470        slabinfo.Acpi-Operand.active_slabs
    194402            -0.0%     194396        slabinfo.Acpi-Operand.num_objs
      3470            -0.0%       3470        slabinfo.Acpi-Operand.num_slabs
      1399 ±  9%      -6.8%       1303 ±  8%  slabinfo.Acpi-Parse.active_objs
     19.17 ±  9%      -6.8%      17.86 ±  8%  slabinfo.Acpi-Parse.active_slabs
      1399 ±  9%      -6.8%       1303 ±  8%  slabinfo.Acpi-Parse.num_objs
     19.17 ±  9%      -6.8%      17.86 ±  8%  slabinfo.Acpi-Parse.num_slabs
      4980            -0.2%       4969        slabinfo.Acpi-State.active_objs
     97.17            -0.5%      96.71        slabinfo.Acpi-State.active_slabs
      4980            -0.2%       4969        slabinfo.Acpi-State.num_objs
     97.17            -0.5%      96.71        slabinfo.Acpi-State.num_slabs
     11774 ±  2%     -10.0%      10599 ±  5%  slabinfo.PING.active_objs
    368.67 ±  2%      -9.8%     332.43 ±  5%  slabinfo.PING.active_slabs
     11810 ±  2%      -9.8%      10652 ±  5%  slabinfo.PING.num_objs
    368.67 ±  2%      -9.8%     332.43 ±  5%  slabinfo.PING.num_slabs
    192.00            +0.0%     192.00        slabinfo.RAW.active_objs
      6.00            +0.0%       6.00        slabinfo.RAW.active_slabs
    192.00            +0.0%     192.00        slabinfo.RAW.num_objs
      6.00            +0.0%       6.00        slabinfo.RAW.num_slabs
    104.00            +3.6%     107.71 ±  8%  slabinfo.RAWv6.active_objs
      4.00            +3.6%       4.14 ±  8%  slabinfo.RAWv6.active_slabs
    104.00            +3.6%     107.71 ±  8%  slabinfo.RAWv6.num_objs
      4.00            +3.6%       4.14 ±  8%  slabinfo.RAWv6.num_slabs
     55.83            -0.2%      55.71        slabinfo.TCP.active_objs
      3.83 ±  9%      -3.1%       3.71 ± 12%  slabinfo.TCP.active_slabs
     55.83            -0.2%      55.71        slabinfo.TCP.num_objs
      3.83 ±  9%      -3.1%       3.71 ± 12%  slabinfo.TCP.num_slabs
     26.00            +0.0%      26.00        slabinfo.TCPv6.active_objs
      2.00            +0.0%       2.00        slabinfo.TCPv6.active_slabs
     26.00            +0.0%      26.00        slabinfo.TCPv6.num_objs
      2.00            +0.0%       2.00        slabinfo.TCPv6.num_slabs
    131.83 ± 12%     +18.9%     156.71 ±  9%  slabinfo.UDPv6.active_objs
      5.17 ± 13%     +16.1%       6.00 ±  8%  slabinfo.UDPv6.active_slabs
    131.83 ± 12%     +18.9%     156.71 ±  9%  slabinfo.UDPv6.num_objs
      5.17 ± 13%     +16.1%       6.00 ±  8%  slabinfo.UDPv6.num_slabs
    140624           -11.4%     124525        slabinfo.anon_vma.active_objs
      3060           -11.4%       2710        slabinfo.anon_vma.active_slabs
    140822           -11.4%     124704        slabinfo.anon_vma.num_objs
      3060           -11.4%       2710        slabinfo.anon_vma.num_slabs
    259591           -14.6%     221676        slabinfo.anon_vma_chain.active_objs
      4063           -14.6%       3470        slabinfo.anon_vma_chain.active_slabs
    260086           -14.6%     222167        slabinfo.anon_vma_chain.num_objs
      4063           -14.6%       3470        slabinfo.anon_vma_chain.num_slabs
    318.50 ±  8%     -10.8%     284.14 ± 12%  slabinfo.bdev_cache.active_objs
      8.17 ±  8%     -10.8%       7.29 ± 12%  slabinfo.bdev_cache.active_slabs
    318.50 ±  8%     -10.8%     284.14 ± 12%  slabinfo.bdev_cache.num_objs
      8.17 ±  8%     -10.8%       7.29 ± 12%  slabinfo.bdev_cache.num_slabs
     88.00 ± 13%      +6.5%      93.71 ± 21%  slabinfo.biovec-128.active_objs
      5.50 ± 13%      +6.5%       5.86 ± 21%  slabinfo.biovec-128.active_slabs
     88.00 ± 13%      +6.5%      93.71 ± 21%  slabinfo.biovec-128.num_objs
      5.50 ± 13%      +6.5%       5.86 ± 21%  slabinfo.biovec-128.num_slabs
    256.00 ±  7%      +0.0%     256.00 ± 13%  slabinfo.biovec-64.active_objs
      8.00 ±  7%      +0.0%       8.00 ± 13%  slabinfo.biovec-64.active_slabs
    256.00 ±  7%      +0.0%     256.00 ± 13%  slabinfo.biovec-64.num_objs
      8.00 ±  7%      +0.0%       8.00 ± 13%  slabinfo.biovec-64.num_slabs
     82.67 ±  4%      -3.2%      80.00 ±  7%  slabinfo.biovec-max.active_objs
     10.33 ±  4%      -3.2%      10.00 ±  7%  slabinfo.biovec-max.active_slabs
     82.67 ±  4%      -3.2%      80.00 ±  7%  slabinfo.biovec-max.num_objs
     10.33 ±  4%      -3.2%      10.00 ±  7%  slabinfo.biovec-max.num_slabs
    351.00 ±  6%      +1.6%     356.57 ±  3%  slabinfo.blkdev_ioc.active_objs
      9.00 ±  6%      +1.6%       9.14 ±  3%  slabinfo.blkdev_ioc.active_slabs
    351.00 ±  6%      +1.6%     356.57 ±  3%  slabinfo.blkdev_ioc.num_objs
      9.00 ±  6%      +1.6%       9.14 ±  3%  slabinfo.blkdev_ioc.num_slabs
    149.50 ±  9%     -29.2%     105.86 ± 16%  slabinfo.buffer_head.active_objs
      3.83 ±  9%     -29.2%       2.71 ± 16%  slabinfo.buffer_head.active_slabs
    149.50 ±  9%     -29.2%     105.86 ± 16%  slabinfo.buffer_head.num_objs
      3.83 ±  9%     -29.2%       2.71 ± 16%  slabinfo.buffer_head.num_slabs
     21791 ±  3%     -33.2%      14552        slabinfo.cred_jar.active_objs
    520.50 ±  2%     -33.4%     346.43        slabinfo.cred_jar.active_slabs
     21880 ±  2%     -33.4%      14568        slabinfo.cred_jar.num_objs
    520.50 ±  2%     -33.4%     346.43        slabinfo.cred_jar.num_slabs
     42.00            +0.0%      42.00        slabinfo.dax_cache.active_objs
      1.00            +0.0%       1.00        slabinfo.dax_cache.active_slabs
     42.00            +0.0%      42.00        slabinfo.dax_cache.num_objs
      1.00            +0.0%       1.00        slabinfo.dax_cache.num_slabs
    158171           -14.1%     135891        slabinfo.dentry.active_objs
      3842           -15.2%       3259        slabinfo.dentry.active_slabs
    161390           -15.2%     136927        slabinfo.dentry.num_objs
      3842           -15.2%       3259        slabinfo.dentry.num_slabs
     30.00            +0.0%      30.00        slabinfo.dmaengine-unmap-128.active_objs
      1.00            +0.0%       1.00        slabinfo.dmaengine-unmap-128.active_slabs
     30.00            +0.0%      30.00        slabinfo.dmaengine-unmap-128.num_objs
      1.00            +0.0%       1.00        slabinfo.dmaengine-unmap-128.num_slabs
      1610 ±  7%      +5.4%       1697 ±  7%  slabinfo.dmaengine-unmap-16.active_objs
     38.00 ±  7%      +5.6%      40.14 ±  6%  slabinfo.dmaengine-unmap-16.active_slabs
      1610 ±  7%      +5.4%       1697 ±  7%  slabinfo.dmaengine-unmap-16.num_objs
     38.00 ±  7%      +5.6%      40.14 ±  6%  slabinfo.dmaengine-unmap-16.num_slabs
     15.00            +0.0%      15.00        slabinfo.dmaengine-unmap-256.active_objs
      1.00            +0.0%       1.00        slabinfo.dmaengine-unmap-256.active_slabs
     15.00            +0.0%      15.00        slabinfo.dmaengine-unmap-256.num_objs
      1.00            +0.0%       1.00        slabinfo.dmaengine-unmap-256.num_slabs
      6102 ±  8%     -23.0%       4697 ± 12%  slabinfo.eventpoll_pwq.active_objs
    108.50 ±  8%     -23.2%      83.29 ± 12%  slabinfo.eventpoll_pwq.active_slabs
      6102 ±  8%     -23.0%       4697 ± 12%  slabinfo.eventpoll_pwq.num_objs
    108.50 ±  8%     -23.2%      83.29 ± 12%  slabinfo.eventpoll_pwq.num_slabs
    869.33 ± 10%      +7.1%     930.71 ± 12%  slabinfo.file_lock_cache.active_objs
     23.17 ± 11%      +6.1%      24.57 ± 12%  slabinfo.file_lock_cache.active_slabs
    869.33 ± 10%      +7.1%     930.71 ± 12%  slabinfo.file_lock_cache.num_objs
     23.17 ± 11%      +6.1%      24.57 ± 12%  slabinfo.file_lock_cache.num_slabs
     15485           -11.2%      13748        slabinfo.files_cache.active_objs
    336.33           -11.1%     299.00        slabinfo.files_cache.active_slabs
     15485           -11.1%      13774        slabinfo.files_cache.num_objs
    336.33           -11.1%     299.00        slabinfo.files_cache.num_slabs
     60752 ±  2%     -41.8%      35341 ±  3%  slabinfo.filp.active_objs
      1915 ±  2%     -42.1%       1108 ±  3%  slabinfo.filp.active_slabs
     61296 ±  2%     -42.1%      35475 ±  3%  slabinfo.filp.num_objs
      1915 ±  2%     -42.1%       1108 ±  3%  slabinfo.filp.num_slabs
      2831 ±  6%      -6.9%       2636 ± 14%  slabinfo.fsnotify_mark_connector.active_objs
     22.00 ±  7%      -9.7%      19.86 ± 14%  slabinfo.fsnotify_mark_connector.active_slabs
      2831 ±  6%      -6.9%       2636 ± 14%  slabinfo.fsnotify_mark_connector.num_objs
     22.00 ±  7%      -9.7%      19.86 ± 14%  slabinfo.fsnotify_mark_connector.num_slabs
     32257            -0.4%      32117        slabinfo.ftrace_event_field.active_objs
    379.50            -0.4%     377.86        slabinfo.ftrace_event_field.active_slabs
     32257            -0.4%      32117        slabinfo.ftrace_event_field.num_objs
    379.50            -0.4%     377.86        slabinfo.ftrace_event_field.num_slabs
    104.00            -7.1%      96.57 ± 18%  slabinfo.hugetlbfs_inode_cache.active_objs
      2.00            -7.1%       1.86 ± 18%  slabinfo.hugetlbfs_inode_cache.active_slabs
    104.00            -7.1%      96.57 ± 18%  slabinfo.hugetlbfs_inode_cache.num_objs
      2.00            -7.1%       1.86 ± 18%  slabinfo.hugetlbfs_inode_cache.num_slabs
     73951            -9.1%      67199        slabinfo.inode_cache.active_objs
      1375            -9.3%       1247        slabinfo.inode_cache.active_slabs
     74288            -9.3%      67375        slabinfo.inode_cache.num_objs
      1375            -9.3%       1247        slabinfo.inode_cache.num_slabs
     44.00            +0.0%      44.00        slabinfo.ip6-frags.active_objs
      1.00            +0.0%       1.00        slabinfo.ip6-frags.active_slabs
     44.00            +0.0%      44.00        slabinfo.ip6-frags.num_objs
      1.00            +0.0%       1.00        slabinfo.ip6-frags.num_slabs
     86613            -0.6%      86067        slabinfo.kernfs_node_cache.active_objs
      2706            -0.6%       2689        slabinfo.kernfs_node_cache.active_slabs
     86613            -0.6%      86067        slabinfo.kernfs_node_cache.num_objs
      2706            -0.6%       2689        slabinfo.kernfs_node_cache.num_slabs
      1281 ±  9%      +8.3%       1387 ± 11%  slabinfo.khugepaged_mm_slot.active_objs
     34.83 ±  9%      +7.9%      37.57 ± 11%  slabinfo.khugepaged_mm_slot.active_slabs
      1281 ±  9%      +8.3%       1387 ± 11%  slabinfo.khugepaged_mm_slot.num_objs
     34.83 ±  9%      +7.9%      37.57 ± 11%  slabinfo.khugepaged_mm_slot.num_slabs
      7240 ±  4%     +33.4%       9662 ±  3%  slabinfo.kmalloc-128.active_objs
    230.33 ±  3%     +31.2%     302.14 ±  3%  slabinfo.kmalloc-128.active_slabs
      7384 ±  3%     +31.2%       9684 ±  3%  slabinfo.kmalloc-128.num_objs
    230.33 ±  3%     +31.2%     302.14 ±  3%  slabinfo.kmalloc-128.num_slabs
     45161            +0.6%      45435        slabinfo.kmalloc-16.active_objs
    175.83            +0.7%     177.14        slabinfo.kmalloc-16.active_slabs
     45161            +0.6%      45435        slabinfo.kmalloc-16.num_objs
    175.83            +0.7%     177.14        slabinfo.kmalloc-16.num_slabs
      9813           -43.4%       5550        slabinfo.kmalloc-192.active_objs
    233.83           -43.5%     132.14        slabinfo.kmalloc-192.active_slabs
      9839           -43.4%       5567        slabinfo.kmalloc-192.num_objs
    233.83           -43.5%     132.14        slabinfo.kmalloc-192.num_slabs
      9771           -36.5%       6207 ±  3%  slabinfo.kmalloc-1k.active_objs
    308.00           -36.1%     196.71 ±  2%  slabinfo.kmalloc-1k.active_slabs
      9865           -36.1%       6305 ±  2%  slabinfo.kmalloc-1k.num_objs
    308.00           -36.1%     196.71 ±  2%  slabinfo.kmalloc-1k.num_slabs
      5881          +229.9%      19403 ±  3%  slabinfo.kmalloc-256.active_objs
    183.17          +247.0%     635.57 ±  3%  slabinfo.kmalloc-256.active_slabs
      5881          +246.0%      20348 ±  3%  slabinfo.kmalloc-256.num_objs
    183.17          +247.0%     635.57 ±  3%  slabinfo.kmalloc-256.num_slabs
      8384 ±  4%      -9.9%       7553 ±  2%  slabinfo.kmalloc-2k.active_objs
    527.67 ±  4%      -9.8%     475.71 ±  2%  slabinfo.kmalloc-2k.active_slabs
      8448 ±  4%      -9.8%       7622 ±  2%  slabinfo.kmalloc-2k.num_objs
    527.67 ±  4%      -9.8%     475.71 ±  2%  slabinfo.kmalloc-2k.num_slabs
    104708           -15.2%      88752        slabinfo.kmalloc-32.active_objs
    817.67           -15.1%     693.86        slabinfo.kmalloc-32.active_slabs
    104746           -15.1%      88907        slabinfo.kmalloc-32.num_objs
    817.67           -15.1%     693.86        slabinfo.kmalloc-32.num_slabs
      3861           -51.2%       1885        slabinfo.kmalloc-4k.active_objs
    484.33           -50.8%     238.14        slabinfo.kmalloc-4k.active_slabs
      3879           -50.8%       1908        slabinfo.kmalloc-4k.num_objs
    484.33           -50.8%     238.14        slabinfo.kmalloc-4k.num_slabs
     63738 ± 12%     +93.8%     123543        slabinfo.kmalloc-512.active_objs
      2210 ± 15%    +120.3%       4868        slabinfo.kmalloc-512.active_slabs
     70746 ± 15%    +120.2%     155794        slabinfo.kmalloc-512.num_objs
      2210 ± 15%    +120.3%       4868        slabinfo.kmalloc-512.num_slabs
     62818            -9.2%      57027        slabinfo.kmalloc-64.active_objs
    981.33            -9.1%     892.00        slabinfo.kmalloc-64.active_slabs
     62831            -9.1%      57117        slabinfo.kmalloc-64.num_objs
    981.33            -9.1%     892.00        slabinfo.kmalloc-64.num_slabs
    202798 ±  2%     -63.9%      73196        slabinfo.kmalloc-8.active_objs
    395.50 ±  2%     -63.7%     143.71        slabinfo.kmalloc-8.active_slabs
    202798 ±  2%     -63.6%      73855        slabinfo.kmalloc-8.num_objs
    395.50 ±  2%     -63.7%     143.71        slabinfo.kmalloc-8.num_slabs
    840.50            -7.3%     779.14        slabinfo.kmalloc-8k.active_objs
    212.67            -5.5%     201.00        slabinfo.kmalloc-8k.active_slabs
    852.17            -5.5%     805.14        slabinfo.kmalloc-8k.num_objs
    212.67            -5.5%     201.00        slabinfo.kmalloc-8k.num_slabs
      8421 ±  3%      -9.2%       7650 ±  2%  slabinfo.kmalloc-96.active_objs
    202.33 ±  3%      -9.0%     184.14        slabinfo.kmalloc-96.active_slabs
      8516 ±  3%      -8.9%       7756        slabinfo.kmalloc-96.num_objs
    202.33 ±  3%      -9.0%     184.14        slabinfo.kmalloc-96.num_slabs
    570.67 ± 20%      -9.5%     516.57 ± 18%  slabinfo.kmalloc-rcl-128.active_objs
     17.83 ± 20%      -9.5%      16.14 ± 18%  slabinfo.kmalloc-rcl-128.active_slabs
    570.67 ± 20%      -9.5%     516.57 ± 18%  slabinfo.kmalloc-rcl-128.num_objs
     17.83 ± 20%      -9.5%      16.14 ± 18%  slabinfo.kmalloc-rcl-128.num_slabs
     42.00            +0.0%      42.00        slabinfo.kmalloc-rcl-192.active_objs
      1.00            +0.0%       1.00        slabinfo.kmalloc-rcl-192.active_slabs
     42.00            +0.0%      42.00        slabinfo.kmalloc-rcl-192.num_objs
      1.00            +0.0%       1.00        slabinfo.kmalloc-rcl-192.num_slabs
      0.00       +1.4e+105%       1429 ±  4%  slabinfo.kmalloc-rcl-512.active_objs
      0.00       +4.4e+103%      44.29 ±  4%  slabinfo.kmalloc-rcl-512.active_slabs
      0.00       +1.4e+105%       1429 ±  4%  slabinfo.kmalloc-rcl-512.num_objs
      0.00       +4.4e+103%      44.29 ±  4%  slabinfo.kmalloc-rcl-512.num_slabs
      5923 ±  5%     -30.3%       4127 ±  9%  slabinfo.kmalloc-rcl-64.active_objs
     92.00 ±  5%     -30.4%      64.00 ±  9%  slabinfo.kmalloc-rcl-64.active_slabs
      5923 ±  5%     -30.3%       4127 ±  9%  slabinfo.kmalloc-rcl-64.num_objs
     92.00 ±  5%     -30.4%      64.00 ±  9%  slabinfo.kmalloc-rcl-64.num_slabs
      2226 ± 10%     -17.4%       1838 ± 11%  slabinfo.kmalloc-rcl-96.active_objs
     52.67 ± 10%     -17.3%      43.57 ± 11%  slabinfo.kmalloc-rcl-96.active_slabs
      2226 ± 10%     -17.4%       1838 ± 11%  slabinfo.kmalloc-rcl-96.num_objs
     52.67 ± 10%     -17.3%      43.57 ± 11%  slabinfo.kmalloc-rcl-96.num_slabs
      2374 ±  4%     -82.7%     411.43 ± 10%  slabinfo.kmem_cache.active_objs
     65.67 ±  4%     -80.4%      12.86 ± 10%  slabinfo.kmem_cache.active_slabs
      2374 ±  4%     -82.7%     411.43 ± 10%  slabinfo.kmem_cache.num_objs
     65.67 ±  4%     -80.4%      12.86 ± 10%  slabinfo.kmem_cache.num_slabs
      4815 ±  4%     -81.8%     877.71 ± 10%  slabinfo.kmem_cache_node.active_objs
     75.50 ±  5%     -81.1%      14.29 ±  9%  slabinfo.kmem_cache_node.active_slabs
      4859 ±  5%     -81.2%     914.29 ±  9%  slabinfo.kmem_cache_node.num_objs
     75.50 ±  5%     -81.1%      14.29 ±  9%  slabinfo.kmem_cache_node.num_slabs
     27272            +1.2%      27608        slabinfo.lsm_file_cache.active_objs
    160.00            +1.2%     161.86        slabinfo.lsm_file_cache.active_slabs
     27272            +1.2%      27608        slabinfo.lsm_file_cache.num_objs
    160.00            +1.2%     161.86        slabinfo.lsm_file_cache.num_slabs
     15050           -23.8%      11474 ±  2%  slabinfo.mm_struct.active_objs
    502.17           -23.4%     384.57 ±  2%  slabinfo.mm_struct.active_slabs
     15086           -23.5%      11547 ±  2%  slabinfo.mm_struct.num_objs
    502.17           -23.4%     384.57 ±  2%  slabinfo.mm_struct.num_slabs
    976.50 ±  9%     -13.5%     844.43 ± 11%  slabinfo.mnt_cache.active_objs
     18.17 ±  9%     -12.7%      15.86 ±  9%  slabinfo.mnt_cache.active_slabs
    976.50 ±  9%     -13.5%     844.43 ± 11%  slabinfo.mnt_cache.num_objs
     18.17 ±  9%     -12.7%      15.86 ±  9%  slabinfo.mnt_cache.num_slabs
     34.00            +0.0%      34.00        slabinfo.mqueue_inode_cache.active_objs
      1.00            +0.0%       1.00        slabinfo.mqueue_inode_cache.active_slabs
     34.00            +0.0%      34.00        slabinfo.mqueue_inode_cache.num_objs
      1.00            +0.0%       1.00        slabinfo.mqueue_inode_cache.num_slabs
    769.00            -0.1%     768.00        slabinfo.names_cache.active_objs
     96.00            +0.0%      96.00        slabinfo.names_cache.active_slabs
    769.00            -0.1%     768.00        slabinfo.names_cache.num_objs
     96.00            +0.0%      96.00        slabinfo.names_cache.num_slabs
     36.00            +0.0%      36.00        slabinfo.nfs_read_data.active_objs
      1.00            +0.0%       1.00        slabinfo.nfs_read_data.active_slabs
     36.00            +0.0%      36.00        slabinfo.nfs_read_data.num_objs
      1.00            +0.0%       1.00        slabinfo.nfs_read_data.num_slabs
    124.00            +0.0%     124.00        slabinfo.numa_policy.active_objs
      2.00            +0.0%       2.00        slabinfo.numa_policy.active_slabs
    124.00            +0.0%     124.00        slabinfo.numa_policy.num_objs
      2.00            +0.0%       2.00        slabinfo.numa_policy.num_slabs
     16360 ±  8%     -41.2%       9617        slabinfo.pde_opener.active_objs
    159.83 ±  8%     -41.2%      94.00        slabinfo.pde_opener.active_slabs
     16360 ±  8%     -41.2%       9617        slabinfo.pde_opener.num_objs
    159.83 ±  8%     -41.2%      94.00        slabinfo.pde_opener.num_slabs
     15237 ±  3%     -11.7%      13458 ±  2%  slabinfo.pid.active_objs
    477.83 ±  3%     -12.0%     420.71        slabinfo.pid.active_slabs
     15308 ±  3%     -12.0%      13478        slabinfo.pid.num_objs
    477.83 ±  3%     -12.0%     420.71        slabinfo.pid.num_slabs
      1534 ±  6%     -12.5%       1342 ±  6%  slabinfo.pool_workqueue.active_objs
     48.33 ±  5%     -13.1%      42.00 ±  6%  slabinfo.pool_workqueue.active_slabs
      1552 ±  6%     -12.6%       1356 ±  6%  slabinfo.pool_workqueue.num_objs
     48.33 ±  5%     -13.1%      42.00 ±  6%  slabinfo.pool_workqueue.num_slabs
      2989            -1.6%       2940        slabinfo.proc_dir_entry.active_objs
     71.17            -1.6%      70.00        slabinfo.proc_dir_entry.active_slabs
      2989            -1.6%       2940        slabinfo.proc_dir_entry.num_objs
     71.17            -1.6%      70.00        slabinfo.proc_dir_entry.num_slabs
     34841 ±  4%      -5.7%      32862 ±  8%  slabinfo.proc_inode_cache.active_objs
    737.00 ±  4%      -5.2%     698.86 ±  8%  slabinfo.proc_inode_cache.active_slabs
     35397 ±  4%      -5.2%      33572 ±  8%  slabinfo.proc_inode_cache.num_objs
    737.00 ±  4%      -5.2%     698.86 ±  8%  slabinfo.proc_inode_cache.num_slabs
     21046 ±  5%     +23.5%      25987 ±  4%  slabinfo.radix_tree_node.active_objs
    375.33 ±  5%     +23.5%     463.57 ±  4%  slabinfo.radix_tree_node.active_slabs
     21046 ±  5%     +23.5%      25987 ±  4%  slabinfo.radix_tree_node.num_objs
    375.33 ±  5%     +23.5%     463.57 ±  4%  slabinfo.radix_tree_node.num_slabs
     30.00            +0.0%      30.00        slabinfo.request_queue.active_objs
      2.00            +0.0%       2.00        slabinfo.request_queue.active_slabs
     30.00            +0.0%      30.00        slabinfo.request_queue.num_objs
      2.00            +0.0%       2.00        slabinfo.request_queue.num_slabs
     85.00 ± 28%     -40.0%      51.00        slabinfo.rpc_inode_cache.active_objs
      1.67 ± 28%     -40.0%       1.00        slabinfo.rpc_inode_cache.active_slabs
     85.00 ± 28%     -40.0%      51.00        slabinfo.rpc_inode_cache.num_objs
      1.67 ± 28%     -40.0%       1.00        slabinfo.rpc_inode_cache.num_slabs
    640.00            +0.0%     640.00        slabinfo.scsi_sense_cache.active_objs
     20.00            +0.0%      20.00        slabinfo.scsi_sense_cache.active_slabs
    640.00            +0.0%     640.00        slabinfo.scsi_sense_cache.num_objs
     20.00            +0.0%      20.00        slabinfo.scsi_sense_cache.num_slabs
     10398 ±  2%     -68.6%       3264        slabinfo.seq_file.active_objs
    305.33 ±  2%     -68.6%      96.00        slabinfo.seq_file.active_slabs
     10398 ±  2%     -68.6%       3264        slabinfo.seq_file.num_objs
    305.33 ±  2%     -68.6%      96.00        slabinfo.seq_file.num_slabs
      8720 ±  2%     -40.9%       5155 ±  4%  slabinfo.shmem_inode_cache.active_objs
    191.17 ±  2%     -41.6%     111.57 ±  4%  slabinfo.shmem_inode_cache.active_slabs
      8810 ±  2%     -41.5%       5155 ±  4%  slabinfo.shmem_inode_cache.num_objs
    191.17 ±  2%     -41.6%     111.57 ±  4%  slabinfo.shmem_inode_cache.num_slabs
      7933            +5.6%       8380 ±  3%  slabinfo.sighand_cache.active_objs
    538.83            +4.4%     562.43 ±  3%  slabinfo.sighand_cache.active_slabs
      8087            +4.4%       8443 ±  3%  slabinfo.sighand_cache.num_objs
    538.83            +4.4%     562.43 ±  3%  slabinfo.sighand_cache.num_slabs
     10280 ±  2%      +1.8%      10465 ±  4%  slabinfo.signal_cache.active_objs
    370.50 ±  2%      +1.6%     376.57 ±  4%  slabinfo.signal_cache.active_slabs
     10388 ±  2%      +1.6%      10559 ±  4%  slabinfo.signal_cache.num_objs
    370.50 ±  2%      +1.6%     376.57 ±  4%  slabinfo.signal_cache.num_slabs
    266.50 ±  8%      +6.2%     283.14 ± 17%  slabinfo.skbuff_fclone_cache.active_objs
      8.17 ±  8%      +5.0%       8.57 ± 18%  slabinfo.skbuff_fclone_cache.active_slabs
    266.50 ±  8%      +6.2%     283.14 ± 17%  slabinfo.skbuff_fclone_cache.num_objs
      8.17 ±  8%      +5.0%       8.57 ± 18%  slabinfo.skbuff_fclone_cache.num_slabs
     58140 ± 13%     +77.2%     102996        slabinfo.skbuff_head_cache.active_objs
      2035 ± 16%    +105.6%       4185        slabinfo.skbuff_head_cache.active_slabs
     65146 ± 16%    +105.6%     133944        slabinfo.skbuff_head_cache.num_objs
      2035 ± 16%    +105.6%       4185        slabinfo.skbuff_head_cache.num_slabs
     14440 ±  2%     -13.3%      12522        slabinfo.sock_inode_cache.active_objs
    369.83 ±  2%     -13.2%     320.86        slabinfo.sock_inode_cache.active_slabs
     14440 ±  2%     -13.2%      12531        slabinfo.sock_inode_cache.num_objs
    369.83 ±  2%     -13.2%     320.86        slabinfo.sock_inode_cache.num_slabs
     16222 ±  5%      -5.0%      15409        slabinfo.task_delay_info.active_objs
    319.17 ±  5%      -5.5%     301.71        slabinfo.task_delay_info.active_slabs
     16302 ±  5%      -5.5%      15409        slabinfo.task_delay_info.num_objs
    319.17 ±  5%      -5.5%     301.71        slabinfo.task_delay_info.num_slabs
      1275 ±  8%      -4.4%       1219 ±  6%  slabinfo.task_group.active_objs
     30.00 ±  8%      -4.3%      28.71 ±  6%  slabinfo.task_group.active_slabs
      1275 ±  8%      -4.4%       1219 ±  6%  slabinfo.task_group.num_objs
     30.00 ±  8%      -4.3%      28.71 ±  6%  slabinfo.task_group.num_slabs
      4888            -0.3%       4872        slabinfo.task_struct.active_objs
      4915            -0.7%       4878        slabinfo.task_struct.active_slabs
      4915            -0.7%       4878        slabinfo.task_struct.num_objs
      4915            -0.7%       4878        slabinfo.task_struct.num_slabs
     75.17 ±  8%     +42.4%     107.00 ±  4%  slabinfo.taskstats.active_objs
      1.00          +100.0%       2.00        slabinfo.taskstats.active_slabs
     75.17 ±  8%     +42.4%     107.00 ±  4%  slabinfo.taskstats.num_objs
      1.00          +100.0%       2.00        slabinfo.taskstats.num_slabs
      3207            -2.1%       3141 ±  3%  slabinfo.trace_event_file.active_objs
     69.50 ±  2%      -2.6%      67.71 ±  3%  slabinfo.trace_event_file.active_slabs
      3207            -2.1%       3141 ±  3%  slabinfo.trace_event_file.num_objs
     69.50 ±  2%      -2.6%      67.71 ±  3%  slabinfo.trace_event_file.num_slabs
     33.00            +0.0%      33.00        slabinfo.tw_sock_TCP.active_objs
      1.00            +0.0%       1.00        slabinfo.tw_sock_TCP.active_slabs
     33.00            +0.0%      33.00        slabinfo.tw_sock_TCP.num_objs
      1.00            +0.0%       1.00        slabinfo.tw_sock_TCP.num_slabs
    227230           -18.9%     184278        slabinfo.vm_area_struct.active_objs
      5689           -18.9%       4614        slabinfo.vm_area_struct.active_slabs
    227587           -18.9%     184599        slabinfo.vm_area_struct.num_objs
      5689           -18.9%       4614        slabinfo.vm_area_struct.num_slabs
     23104            +6.3%      24565        slabinfo.vmap_area.active_objs
    362.50            +7.0%     387.71        slabinfo.vmap_area.active_slabs
     23227            +7.0%      24856        slabinfo.vmap_area.num_objs
    362.50            +7.0%     387.71        slabinfo.vmap_area.num_slabs
     72.00            +0.0%      72.00        slabinfo.xfs_btree_cur.active_objs
      2.00            +0.0%       2.00        slabinfo.xfs_btree_cur.active_slabs
     72.00            +0.0%      72.00        slabinfo.xfs_btree_cur.num_objs
      2.00            +0.0%       2.00        slabinfo.xfs_btree_cur.num_slabs
    203.00 ±  7%      +0.5%     204.00 ±  7%  slabinfo.xfs_buf.active_objs
      4.83 ±  7%      +0.5%       4.86 ±  7%  slabinfo.xfs_buf.active_slabs
    203.00 ±  7%      +0.5%     204.00 ±  7%  slabinfo.xfs_buf.num_objs
      4.83 ±  7%      +0.5%       4.86 ±  7%  slabinfo.xfs_buf.num_slabs
     40.00 ± 70%     +50.0%      60.00        slabinfo.xfs_buf_item.active_objs
      0.67 ± 70%     +50.0%       1.00        slabinfo.xfs_buf_item.active_slabs
     40.00 ± 70%     +50.0%      60.00        slabinfo.xfs_buf_item.num_objs
      0.67 ± 70%     +50.0%       1.00        slabinfo.xfs_buf_item.num_slabs
     24.67 ± 70%     +50.0%      37.00        slabinfo.xfs_efi_item.active_objs
      0.67 ± 70%     +50.0%       1.00        slabinfo.xfs_efi_item.active_slabs
     24.67 ± 70%     +50.0%      37.00        slabinfo.xfs_efi_item.num_objs
      0.67 ± 70%     +50.0%       1.00        slabinfo.xfs_efi_item.num_slabs
    122.67 ±  9%     -21.7%      96.00        slabinfo.xfs_inode.active_objs
      3.83 ±  9%     -21.7%       3.00        slabinfo.xfs_inode.active_slabs
    122.67 ±  9%     -21.7%      96.00        slabinfo.xfs_inode.num_objs
      3.83 ±  9%     -21.7%       3.00        slabinfo.xfs_inode.num_slabs
    434.00 ±  9%     +10.1%     477.86 ±  3%  softirqs.BLOCK
      0.00       +8.3e+102%       8.29 ± 88%  softirqs.CPU0.BLOCK
      1.00            +0.0%       1.00        softirqs.CPU0.HI
      0.83 ± 82%    +414.3%       4.29 ±103%  softirqs.CPU0.NET_RX
      0.17 ±223%  +11557.1%      19.43 ±156%  softirqs.CPU0.NET_TX
     46545 ± 14%     +88.6%      87801 ± 16%  softirqs.CPU0.RCU
      6382 ± 15%    +172.4%      17385 ±  6%  softirqs.CPU0.SCHED
    105.33            +0.5%     105.86        softirqs.CPU0.TASKLET
      1697 ± 30%     +98.3%       3366 ± 22%  softirqs.CPU0.TIMER
      0.17 ±223%   +1785.7%       3.14 ±143%  softirqs.CPU1.BLOCK
      1.17 ±115%     +34.7%       1.57 ±112%  softirqs.CPU1.NET_RX
      0.17 ±223%     -14.3%       0.14 ±244%  softirqs.CPU1.NET_TX
     44862 ± 14%     +93.9%      86970 ± 15%  softirqs.CPU1.RCU
      5142 ± 18%    +209.7%      15923 ±  6%  softirqs.CPU1.SCHED
      0.17 ±223%     -14.3%       0.14 ±244%  softirqs.CPU1.TASKLET
    698.33 ± 59%     +25.2%     874.43 ± 19%  softirqs.CPU1.TIMER
      0.00       +1.7e+102%       1.71 ±244%  softirqs.CPU10.BLOCK
      1.33 ± 35%      -3.6%       1.29 ± 35%  softirqs.CPU10.HI
      8.67 ±213%    +343.4%      38.43 ±236%  softirqs.CPU10.NET_RX
      0.50 ±152%     -71.4%       0.14 ±244%  softirqs.CPU10.NET_TX
     45097 ± 13%     +92.9%      86975 ± 16%  softirqs.CPU10.RCU
      4458 ± 17%    +235.6%      14961 ±  6%  softirqs.CPU10.SCHED
     38.00 ± 10%      -3.8%      36.57        softirqs.CPU10.TASKLET
    415.67 ± 30%     +77.9%     739.57 ± 29%  softirqs.CPU10.TIMER
      6.33 ±155%    -100.0%       0.00        softirqs.CPU11.BLOCK
      1.00 ±141%    +257.1%       3.57 ±171%  softirqs.CPU11.NET_RX
      0.17 ±223%     -14.3%       0.14 ±244%  softirqs.CPU11.NET_TX
     45742 ± 13%     +93.2%      88361 ± 14%  softirqs.CPU11.RCU
      4610 ± 17%    +226.2%      15038 ±  6%  softirqs.CPU11.SCHED
      0.00          -100.0%       0.00        softirqs.CPU11.TASKLET
    502.67 ± 19%     +56.3%     785.86 ± 15%  softirqs.CPU11.TIMER
     14.67 ± 86%     -53.2%       6.86 ±183%  softirqs.CPU12.BLOCK
      1.17 ±151%    -100.0%       0.00        softirqs.CPU12.NET_RX
      0.17 ±223%    -100.0%       0.00        softirqs.CPU12.NET_TX
     44876 ± 13%     +94.1%      87115 ± 14%  softirqs.CPU12.RCU
      4523 ± 19%    +232.4%      15038 ±  6%  softirqs.CPU12.SCHED
      2.00           +64.3%       3.29 ± 95%  softirqs.CPU12.TASKLET
    337.67 ± 21%    +149.5%     842.57 ± 37%  softirqs.CPU12.TIMER
      4.33 ±223%     -96.7%       0.14 ±244%  softirqs.CPU13.BLOCK
      5.50 ±184%   +2409.1%     138.00 ±240%  softirqs.CPU13.NET_RX
      0.33 ±141%    +157.1%       0.86 ± 40%  softirqs.CPU13.NET_TX
     44437 ± 13%     +95.9%      87064 ± 15%  softirqs.CPU13.RCU
      4538 ± 17%    +228.6%      14914 ±  6%  softirqs.CPU13.SCHED
      2.17 ± 17%      -7.7%       2.00        softirqs.CPU13.TASKLET
    367.50 ± 15%    +110.5%     773.57 ± 27%  softirqs.CPU13.TIMER
      4.00 ±223%    -100.0%       0.00        softirqs.CPU14.BLOCK
      7.67 ±145%   +6872.7%     534.57 ±244%  softirqs.CPU14.NET_RX
      0.17 ±223%    +157.1%       0.43 ±115%  softirqs.CPU14.NET_TX
     44779 ± 13%     +95.0%      87300 ± 14%  softirqs.CPU14.RCU
      4569 ± 19%    +227.8%      14978 ±  6%  softirqs.CPU14.SCHED
      1.83 ± 48%      -6.5%       1.71 ± 40%  softirqs.CPU14.TASKLET
    407.00 ±  9%    +103.4%     827.71 ± 25%  softirqs.CPU14.TIMER
      1.00 ±223%    +128.6%       2.29 ±244%  softirqs.CPU15.BLOCK
    728.17 ±222%     -99.7%       2.29 ± 92%  softirqs.CPU15.NET_RX
      0.33 ±141%    +114.3%       0.71 ± 63%  softirqs.CPU15.NET_TX
     44824 ± 12%     +95.0%      87405 ± 15%  softirqs.CPU15.RCU
      4520 ± 17%    +231.8%      14996 ±  5%  softirqs.CPU15.SCHED
      1.67 ± 44%     +20.0%       2.00        softirqs.CPU15.TASKLET
    629.83 ± 46%     +16.2%     731.71 ± 19%  softirqs.CPU15.TIMER
     93.17 ±219%     -78.8%      19.71 ±141%  softirqs.CPU16.NET_RX
      0.33 ±223%     -14.3%       0.29 ±158%  softirqs.CPU16.NET_TX
     47238 ± 13%     +94.8%      92040 ± 15%  softirqs.CPU16.RCU
      4465 ± 21%    +235.0%      14960 ±  7%  softirqs.CPU16.SCHED
      2.17 ± 17%      +5.5%       2.29 ± 19%  softirqs.CPU16.TASKLET
    565.33 ± 24%     +67.5%     947.00 ± 17%  softirqs.CPU16.TIMER
      0.00         +2e+102%       2.00 ±207%  softirqs.CPU17.BLOCK
    197.50 ±221%     -99.1%       1.86 ±126%  softirqs.CPU17.NET_RX
      0.83 ± 82%     -31.4%       0.57 ±127%  softirqs.CPU17.NET_TX
     46993 ± 13%    +100.2%      94081 ± 14%  softirqs.CPU17.RCU
      4508 ± 18%    +231.2%      14932 ±  7%  softirqs.CPU17.SCHED
      2.67 ± 41%     -14.3%       2.29 ± 72%  softirqs.CPU17.TASKLET
    523.17 ± 18%    +111.6%       1106 ± 15%  softirqs.CPU17.TIMER
      0.33 ±223%    -100.0%       0.00        softirqs.CPU18.BLOCK
      0.33 ±141%     +71.4%       0.57 ± 86%  softirqs.CPU18.NET_RX
      0.17 ±223%     +71.4%       0.29 ±158%  softirqs.CPU18.NET_TX
     47649 ± 13%     +97.8%      94264 ± 15%  softirqs.CPU18.RCU
      4596 ± 19%    +229.9%      15164 ±  8%  softirqs.CPU18.SCHED
      4.17 ±160%     -65.7%       1.43 ± 63%  softirqs.CPU18.TASKLET
    535.00 ± 21%    +131.8%       1240 ± 40%  softirqs.CPU18.TIMER
      3.33 ±145%    -100.0%       0.00        softirqs.CPU19.BLOCK
      1976 ±223%     -99.9%       1.71 ±175%  softirqs.CPU19.NET_RX
      0.00       +1.4e+101%       0.14 ±244%  softirqs.CPU19.NET_TX
     47312 ± 13%     +99.9%      94562 ± 14%  softirqs.CPU19.RCU
      4324 ± 23%    +246.3%      14974 ±  6%  softirqs.CPU19.SCHED
      7.17 ±173%     -72.1%       2.00        softirqs.CPU19.TASKLET
    556.17 ± 32%     +95.6%       1087 ± 16%  softirqs.CPU19.TIMER
      1.17 ±223%    -100.0%       0.00        softirqs.CPU2.BLOCK
     94.33 ±217%    +376.7%     449.71 ±159%  softirqs.CPU2.NET_RX
      5.17 ±215%     -88.9%       0.57 ±127%  softirqs.CPU2.NET_TX
     44987 ± 12%     +93.8%      87198 ± 15%  softirqs.CPU2.RCU
      5014 ± 14%    +201.2%      15100 ±  6%  softirqs.CPU2.SCHED
      0.00          -100.0%       0.00        softirqs.CPU2.TASKLET
    640.17 ± 56%     +24.2%     794.86 ± 25%  softirqs.CPU2.TIMER
      1.33 ±223%    +285.7%       5.14 ±244%  softirqs.CPU20.BLOCK
      0.00         +2e+104%     203.29 ±226%  softirqs.CPU20.NET_RX
      0.00       +1.4e+101%       0.14 ±244%  softirqs.CPU20.NET_TX
     47160 ± 13%    +100.5%      94560 ± 14%  softirqs.CPU20.RCU
      4510 ± 18%    +229.8%      14874 ±  7%  softirqs.CPU20.SCHED
      1.67 ± 44%    +157.1%       4.29 ±179%  softirqs.CPU20.TASKLET
    509.67 ± 18%    +108.3%       1061 ± 12%  softirqs.CPU20.TIMER
    134.67 ± 84%     +45.5%     196.00 ± 54%  softirqs.CPU21.BLOCK
      1.50 ±142%     +33.3%       2.00 ±138%  softirqs.CPU21.NET_RX
      0.17 ±223%    +157.1%       0.43 ±115%  softirqs.CPU21.NET_TX
     46978 ± 13%    +100.2%      94029 ± 14%  softirqs.CPU21.RCU
      4454 ± 22%    +236.2%      14976 ±  6%  softirqs.CPU21.SCHED
      0.50 ±152%    -100.0%       0.00        softirqs.CPU21.TASKLET
    516.17 ± 18%     +99.2%       1028 ± 14%  softirqs.CPU21.TIMER
     40.67 ±142%     -11.8%      35.86 ±235%  softirqs.CPU22.BLOCK
      2.33 ±149%   +4859.2%     115.71 ±189%  softirqs.CPU22.NET_RX
      0.00       +2.9e+101%       0.29 ±158%  softirqs.CPU22.NET_TX
     47149 ± 13%     +99.6%      94106 ± 14%  softirqs.CPU22.RCU
      4421 ± 19%    +241.5%      15097 ±  7%  softirqs.CPU22.SCHED
      0.00       +2.6e+102%       2.57 ±244%  softirqs.CPU22.TASKLET
    523.17 ± 17%    +137.0%       1239 ± 33%  softirqs.CPU22.TIMER
      0.00       +2.6e+102%       2.57 ±214%  softirqs.CPU23.BLOCK
      3.00 ± 98%  +45671.4%       1373 ±244%  softirqs.CPU23.NET_RX
      0.33 ±141%     -14.3%       0.29 ±158%  softirqs.CPU23.NET_TX
     47223 ± 13%     +99.7%      94283 ± 14%  softirqs.CPU23.RCU
      4609 ± 21%    +222.0%      14843 ±  5%  softirqs.CPU23.SCHED
      5.67 ±223%     -84.9%       0.86 ±201%  softirqs.CPU23.TASKLET
    482.50 ± 19%    +142.6%       1170 ± 22%  softirqs.CPU23.TIMER
      0.33 ±223%   +3585.7%      12.29 ±244%  softirqs.CPU24.BLOCK
      6.00 ±171%     -11.9%       5.29 ±173%  softirqs.CPU24.NET_RX
      0.17 ±223%     -14.3%       0.14 ±244%  softirqs.CPU24.NET_TX
     47048 ± 14%     +96.9%      92632 ± 15%  softirqs.CPU24.RCU
      4714 ± 21%    +229.4%      15528 ±  9%  softirqs.CPU24.SCHED
      0.33 ±223%    -100.0%       0.00        softirqs.CPU24.TASKLET
    485.33 ± 24%    +176.2%       1340 ± 39%  softirqs.CPU24.TIMER
      2.83 ±126%   +8476.5%     243.00 ±244%  softirqs.CPU25.NET_RX
      0.50 ±152%    -100.0%       0.00        softirqs.CPU25.NET_TX
     47017 ± 15%     +95.8%      92043 ± 15%  softirqs.CPU25.RCU
      4704 ± 22%    +237.3%      15869 ±  8%  softirqs.CPU25.SCHED
      1.33 ±192%     -89.3%       0.14 ±244%  softirqs.CPU25.TASKLET
    525.50 ± 15%    +124.1%       1177 ± 37%  softirqs.CPU25.TIMER
     14.33 ±217%     -23.3%      11.00 ±159%  softirqs.CPU26.BLOCK
      1.00 ±182%     +14.3%       1.14 ±211%  softirqs.CPU26.NET_RX
      0.33 ±141%     -57.1%       0.14 ±244%  softirqs.CPU26.NET_TX
     47895 ± 13%     +92.4%      92150 ± 15%  softirqs.CPU26.RCU
      4802 ± 21%    +231.3%      15909 ±  8%  softirqs.CPU26.SCHED
      1.33 ± 70%     +60.7%       2.14 ± 16%  softirqs.CPU26.TASKLET
    798.00 ± 44%     +20.9%     965.14 ± 17%  softirqs.CPU26.TIMER
      0.00         +1e+103%      10.29 ±244%  softirqs.CPU27.BLOCK
      2.67 ±141%    +280.4%      10.14 ±202%  softirqs.CPU27.NET_RX
      8.67 ±141%     -96.7%       0.29 ±158%  softirqs.CPU27.NET_TX
     47058 ± 15%     +95.9%      92186 ± 15%  softirqs.CPU27.RCU
      4625 ± 24%    +236.8%      15577 ±  7%  softirqs.CPU27.SCHED
      5.17 ±155%     -64.1%       1.86 ± 44%  softirqs.CPU27.TASKLET
    510.67 ± 28%     +96.6%       1004 ± 18%  softirqs.CPU27.TIMER
      5.50 ±223%     -22.1%       4.29 ±226%  softirqs.CPU28.BLOCK
     93.00 ±221%     -70.4%      27.57 ±158%  softirqs.CPU28.NET_RX
      0.00         +1e+103%      10.29 ±237%  softirqs.CPU28.NET_TX
     46599 ± 15%     +96.8%      91729 ± 15%  softirqs.CPU28.RCU
      4644 ± 22%    +235.4%      15577 ±  8%  softirqs.CPU28.SCHED
      3.00 ±107%     -42.9%       1.71 ± 67%  softirqs.CPU28.TASKLET
    516.67 ± 28%     +77.8%     918.86 ± 23%  softirqs.CPU28.TIMER
      0.17 ±223%    +500.0%       1.00 ±244%  softirqs.CPU29.BLOCK
     47.50 ±169%     -94.3%       2.71 ±128%  softirqs.CPU29.NET_RX
      0.17 ±223%   +4614.3%       7.86 ±239%  softirqs.CPU29.NET_TX
     44895 ± 16%    +105.7%      92369 ± 15%  softirqs.CPU29.RCU
      4554 ± 23%    +244.9%      15711 ±  8%  softirqs.CPU29.SCHED
      2.00            -7.1%       1.86 ± 44%  softirqs.CPU29.TASKLET
    520.67 ± 27%    +117.7%       1133 ± 38%  softirqs.CPU29.TIMER
      1.50 ±195%     +33.3%       2.00 ±244%  softirqs.CPU3.BLOCK
      0.17 ±223%  +77042.9%     128.57 ±243%  softirqs.CPU3.NET_RX
      0.17 ±223%     -14.3%       0.14 ±244%  softirqs.CPU3.NET_TX
     44981 ± 13%     +95.0%      87725 ± 14%  softirqs.CPU3.RCU
      4615 ± 18%    +232.7%      15356 ±  7%  softirqs.CPU3.SCHED
      0.00       +1.7e+102%       1.71 ±244%  softirqs.CPU3.TASKLET
    419.17 ± 29%    +111.3%     885.86 ± 28%  softirqs.CPU3.TIMER
      2452 ±223%    -100.0%       0.71 ±244%  softirqs.CPU30.NET_RX
      0.17 ±223%     -14.3%       0.14 ±244%  softirqs.CPU30.NET_TX
     46441 ± 15%     +95.9%      90972 ± 15%  softirqs.CPU30.RCU
      4662 ± 23%    +229.0%      15338 ±  8%  softirqs.CPU30.SCHED
      2.00            +0.0%       2.00        softirqs.CPU30.TASKLET
    526.67 ± 21%     +73.7%     914.71 ± 20%  softirqs.CPU30.TIMER
      0.00       +2.4e+102%       2.43 ±158%  softirqs.CPU31.BLOCK
    158.50 ±223%     +76.9%     280.43 ±244%  softirqs.CPU31.NET_RX
     46270 ± 15%     +98.2%      91721 ± 15%  softirqs.CPU31.RCU
      4581 ± 22%    +240.0%      15576 ±  7%  softirqs.CPU31.SCHED
      2.00            +0.0%       2.00        softirqs.CPU31.TASKLET
    508.33 ± 34%     +93.0%     980.86 ± 18%  softirqs.CPU31.TIMER
      0.17 ±223%   +2642.9%       4.57 ±168%  softirqs.CPU32.BLOCK
      0.83 ±223%    -100.0%       0.00        softirqs.CPU32.NET_RX
      0.17 ±223%    -100.0%       0.00        softirqs.CPU32.NET_TX
     43804 ± 13%    +101.0%      88055 ± 14%  softirqs.CPU32.RCU
      4776 ± 22%    +228.2%      15677 ±  7%  softirqs.CPU32.SCHED
      2.00            +0.0%       2.00        softirqs.CPU32.TASKLET
    391.33 ± 12%    +102.8%     793.57 ± 16%  softirqs.CPU32.TIMER
      5.00 ±206%     -22.9%       3.86 ±244%  softirqs.CPU33.BLOCK
      0.00       +5.6e+104%     556.00 ±244%  softirqs.CPU33.NET_RX
      0.00       +1.4e+101%       0.14 ±244%  softirqs.CPU33.NET_TX
     43659 ± 13%    +101.1%      87804 ± 14%  softirqs.CPU33.RCU
      4597 ± 22%    +240.9%      15671 ±  8%  softirqs.CPU33.SCHED
      1.83 ± 20%     +16.9%       2.14 ± 16%  softirqs.CPU33.TASKLET
    373.83 ± 14%    +133.3%     872.00 ± 33%  softirqs.CPU33.TIMER
      0.00       +3.6e+102%       3.57 ±244%  softirqs.CPU34.BLOCK
      0.00       +2.9e+101%       0.29 ±244%  softirqs.CPU34.NET_RX
     44227 ± 13%     +99.6%      88269 ± 14%  softirqs.CPU34.RCU
      4520 ± 22%    +251.3%      15880 ±  8%  softirqs.CPU34.SCHED
      2.67 ±160%     -62.5%       1.00 ±119%  softirqs.CPU34.TASKLET
    381.00 ± 16%    +110.2%     801.00 ± 19%  softirqs.CPU34.TIMER
      0.00         +1e+103%      10.29 ±244%  softirqs.CPU35.BLOCK
     97.67 ±222%     -96.3%       3.57 ±211%  softirqs.CPU35.NET_RX
      0.00          -100.0%       0.00        softirqs.CPU35.NET_TX
     44669 ± 13%     +98.7%      88736 ± 15%  softirqs.CPU35.RCU
      4574 ± 20%    +239.7%      15539 ±  8%  softirqs.CPU35.SCHED
      0.67 ±141%     -14.3%       0.57 ±158%  softirqs.CPU35.TASKLET
    447.17 ± 12%     +83.6%     821.00 ± 13%  softirqs.CPU35.TIMER
      0.00       +2.9e+101%       0.29 ±244%  softirqs.CPU36.BLOCK
     79.00 ±221%    +922.2%     807.57 ±244%  softirqs.CPU36.NET_RX
      0.17 ±223%     -14.3%       0.14 ±244%  softirqs.CPU36.NET_TX
     44404 ± 13%     +96.4%      87216 ± 12%  softirqs.CPU36.RCU
      4595 ± 20%    +240.1%      15627 ±  7%  softirqs.CPU36.SCHED
      0.33 ±223%    -100.0%       0.00        softirqs.CPU36.TASKLET
    394.67 ± 22%    +125.5%     889.86 ± 14%  softirqs.CPU36.TIMER
      4.83 ±223%     +41.9%       6.86 ±233%  softirqs.CPU37.BLOCK
      0.17 ±223%     +71.4%       0.29 ±244%  softirqs.CPU37.NET_RX
      0.00          -100.0%       0.00        softirqs.CPU37.NET_TX
     44142 ± 13%    +100.3%      88436 ± 14%  softirqs.CPU37.RCU
      4738 ± 20%    +231.5%      15709 ±  8%  softirqs.CPU37.SCHED
      0.67 ±223%     +71.4%       1.14 ±244%  softirqs.CPU37.TASKLET
    369.50 ± 18%    +111.3%     780.71 ± 14%  softirqs.CPU37.TIMER
     10.00 ±141%    -100.0%       0.00        softirqs.CPU38.BLOCK
      2.00 ±223%     -50.0%       1.00 ±141%  softirqs.CPU38.NET_RX
      0.33 ±223%     -57.1%       0.14 ±244%  softirqs.CPU38.NET_TX
     44067 ± 13%     +99.8%      88040 ± 14%  softirqs.CPU38.RCU
      4705 ± 19%    +230.4%      15549 ±  8%  softirqs.CPU38.SCHED
      0.00       +3.1e+102%       3.14 ±134%  softirqs.CPU38.TASKLET
    358.50 ± 24%    +118.5%     783.43 ± 19%  softirqs.CPU38.TIMER
      0.17 ±223%    -100.0%       0.00        softirqs.CPU39.BLOCK
     10.17 ±223%    -100.0%       0.00        softirqs.CPU39.NET_RX
      0.17 ±223%    -100.0%       0.00        softirqs.CPU39.NET_TX
     44257 ± 12%     +99.3%      88192 ± 14%  softirqs.CPU39.RCU
      4715 ± 18%    +230.7%      15592 ±  8%  softirqs.CPU39.SCHED
      0.17 ±223%   +1614.3%       2.86 ±244%  softirqs.CPU39.TASKLET
    402.17 ± 15%     +94.6%     782.57 ± 23%  softirqs.CPU39.TIMER
      6.83 ± 95%     -87.5%       0.86 ±244%  softirqs.CPU4.BLOCK
     18.67 ±105%     -12.0%      16.43 ±203%  softirqs.CPU4.NET_RX
      0.50 ±152%     +14.3%       0.57 ± 86%  softirqs.CPU4.NET_TX
     45329 ± 12%     +91.4%      86779 ± 14%  softirqs.CPU4.RCU
      4791 ± 13%    +211.6%      14927 ±  7%  softirqs.CPU4.SCHED
      5.50 ±215%     -94.8%       0.29 ±158%  softirqs.CPU4.TASKLET
    597.50 ± 81%     +43.4%     856.86 ± 21%  softirqs.CPU4.TIMER
      0.17 ±223%   +1014.3%       1.86 ±244%  softirqs.CPU40.BLOCK
      0.33 ±141%  +2.3e+05%     761.71 ±176%  softirqs.CPU40.NET_RX
      0.00       +1.4e+101%       0.14 ±244%  softirqs.CPU40.NET_TX
     45433 ± 15%     +95.4%      88757 ± 14%  softirqs.CPU40.RCU
      4810 ± 23%    +227.4%      15750 ±  8%  softirqs.CPU40.SCHED
    770.33 ± 64%     +25.0%     962.71 ± 25%  softirqs.CPU40.TIMER
      5.50 ±223%    -100.0%       0.00        softirqs.CPU41.BLOCK
      0.67 ±223%   +6328.6%      42.86 ±127%  softirqs.CPU41.NET_RX
      0.17 ±223%     +71.4%       0.29 ±158%  softirqs.CPU41.NET_TX
     44266 ± 13%    +100.2%      88633 ± 14%  softirqs.CPU41.RCU
      4646 ± 21%    +235.0%      15566 ±  9%  softirqs.CPU41.SCHED
      1.33 ±223%     -89.3%       0.14 ±244%  softirqs.CPU41.TASKLET
    381.50 ±  9%    +105.7%     784.57 ± 15%  softirqs.CPU41.TIMER
      7.83 ±223%      -1.5%       7.71 ±234%  softirqs.CPU42.BLOCK
      0.33 ±223%     -57.1%       0.14 ±244%  softirqs.CPU42.NET_RX
      0.00          -100.0%       0.00        softirqs.CPU42.NET_TX
     43602 ± 13%    +101.9%      88038 ± 14%  softirqs.CPU42.RCU
      4644 ± 16%    +237.3%      15664 ±  8%  softirqs.CPU42.SCHED
      0.17 ±223%   +2642.9%       4.57 ±244%  softirqs.CPU42.TASKLET
    436.17 ± 17%    +112.6%     927.43 ± 39%  softirqs.CPU42.TIMER
     12.50 ±144%     -98.9%       0.14 ±244%  softirqs.CPU43.BLOCK
     35.50 ±222%     -98.0%       0.71 ±193%  softirqs.CPU43.NET_RX
      0.33 ±141%    -100.0%       0.00        softirqs.CPU43.NET_TX
     44395 ± 14%     +99.6%      88606 ± 14%  softirqs.CPU43.RCU
      4785 ± 19%    +224.8%      15543 ± 10%  softirqs.CPU43.SCHED
      0.00       +1.4e+101%       0.14 ±244%  softirqs.CPU43.TASKLET
    461.83 ± 22%     +69.7%     783.71 ± 18%  softirqs.CPU43.TIMER
      0.00       +1.3e+103%      13.29 ±244%  softirqs.CPU44.BLOCK
      0.00       +5.7e+101%       0.57 ±244%  softirqs.CPU44.NET_RX
      0.00          -100.0%       0.00        softirqs.CPU44.NET_TX
     43427 ± 14%    +102.7%      88017 ± 15%  softirqs.CPU44.RCU
      4674 ± 21%    +233.9%      15607 ±  8%  softirqs.CPU44.SCHED
    371.17 ±  9%    +122.5%     825.71 ± 19%  softirqs.CPU44.TIMER
      0.17 ±223%     +71.4%       0.29 ±244%  softirqs.CPU45.BLOCK
      0.33 ±223%    -100.0%       0.00        softirqs.CPU45.NET_RX
      0.00          -100.0%       0.00        softirqs.CPU45.NET_TX
     43688 ± 14%    +101.6%      88075 ± 15%  softirqs.CPU45.RCU
      4636 ± 19%    +239.1%      15722 ±  8%  softirqs.CPU45.SCHED
      0.50 ±223%    +842.9%       4.71 ±244%  softirqs.CPU45.TASKLET
    432.67 ± 12%     +83.8%     795.29 ± 15%  softirqs.CPU45.TIMER
     95.33 ±223%   +3452.5%       3386 ±244%  softirqs.CPU46.NET_RX
     43544 ± 12%    +102.6%      88235 ± 14%  softirqs.CPU46.RCU
      4523 ± 21%    +243.6%      15543 ±  8%  softirqs.CPU46.SCHED
      0.50 ±223%    +385.7%       2.43 ±244%  softirqs.CPU46.TASKLET
    408.33 ± 18%    +108.6%     851.71 ± 24%  softirqs.CPU46.TIMER
      0.00       +1.3e+103%      12.57 ±155%  softirqs.CPU47.BLOCK
     51.33 ±217%    +325.2%     218.29 ±244%  softirqs.CPU47.NET_RX
      0.33 ±223%    -100.0%       0.00        softirqs.CPU47.NET_TX
     44190 ± 13%     +99.8%      88284 ± 14%  softirqs.CPU47.RCU
      4613 ± 25%    +235.2%      15467 ±  9%  softirqs.CPU47.SCHED
    414.33 ± 14%     +98.7%     823.14 ± 12%  softirqs.CPU47.TIMER
      0.00       +4.9e+102%       4.86 ±120%  softirqs.CPU48.BLOCK
      2.00 ±180%   +2021.4%      42.43 ±236%  softirqs.CPU48.NET_RX
      0.33 ±141%     -14.3%       0.29 ±158%  softirqs.CPU48.NET_TX
     45042 ± 13%     +93.3%      87055 ± 14%  softirqs.CPU48.RCU
      4578 ± 19%    +229.1%      15067 ±  6%  softirqs.CPU48.SCHED
      0.17 ±223%     -14.3%       0.14 ±244%  softirqs.CPU48.TASKLET
    610.67 ± 67%     +58.6%     968.57 ± 29%  softirqs.CPU48.TIMER
      2.67 ±223%    +135.7%       6.29 ±166%  softirqs.CPU49.BLOCK
      1.00 ±141%    +842.9%       9.43 ±227%  softirqs.CPU49.NET_RX
      0.00       +1.4e+101%       0.14 ±244%  softirqs.CPU49.NET_TX
     43588 ± 16%     +99.4%      86926 ± 15%  softirqs.CPU49.RCU
      4558 ± 19%    +229.0%      14996 ±  7%  softirqs.CPU49.SCHED
    491.00 ± 43%     +55.9%     765.57 ± 19%  softirqs.CPU49.TIMER
      2.33 ±223%      -2.0%       2.29 ±158%  softirqs.CPU5.BLOCK
      1.83 ±152%  +38533.8%     708.29 ±179%  softirqs.CPU5.NET_RX
      0.50 ±100%   +3300.0%      17.00 ±157%  softirqs.CPU5.NET_TX
     45437 ± 13%     +93.7%      88027 ± 14%  softirqs.CPU5.RCU
      4538 ± 18%    +231.5%      15045 ±  5%  softirqs.CPU5.SCHED
      0.00          -100.0%       0.00        softirqs.CPU5.TASKLET
    420.67 ± 26%     +92.5%     809.86 ± 25%  softirqs.CPU5.TIMER
      2.00 ±223%     -14.3%       1.71 ±244%  softirqs.CPU50.BLOCK
      3546 ±223%    -100.0%       1.43 ±139%  softirqs.CPU50.NET_RX
      4.67 ±204%     -96.9%       0.14 ±244%  softirqs.CPU50.NET_TX
     45817 ± 14%     +91.1%      87547 ± 15%  softirqs.CPU50.RCU
      4810 ± 26%    +214.2%      15116 ±  7%  softirqs.CPU50.SCHED
      0.17 ±223%    -100.0%       0.00        softirqs.CPU50.TASKLET
    513.33 ± 33%     +59.0%     816.00 ± 20%  softirqs.CPU50.TIMER
      0.50 ±100%  +18985.7%      95.43 ±241%  softirqs.CPU51.NET_RX
      0.17 ±223%    -100.0%       0.00        softirqs.CPU51.NET_TX
     44811 ± 13%     +94.4%      87134 ± 15%  softirqs.CPU51.RCU
      4471 ± 20%    +238.9%      15152 ±  7%  softirqs.CPU51.SCHED
      0.00          -100.0%       0.00        softirqs.CPU51.TASKLET
    385.17 ± 15%    +110.3%     810.00 ± 27%  softirqs.CPU51.TIMER
      2.33 ±223%     -51.0%       1.14 ±244%  softirqs.CPU52.BLOCK
      0.67 ±111%   +1892.9%      13.29 ±235%  softirqs.CPU52.NET_RX
      0.17 ±223%     +71.4%       0.29 ±244%  softirqs.CPU52.NET_TX
     45428 ± 13%     +88.6%      85669 ± 15%  softirqs.CPU52.RCU
      4554 ± 18%    +229.1%      14989 ±  6%  softirqs.CPU52.SCHED
      0.00       +1.7e+102%       1.71 ±222%  softirqs.CPU52.TASKLET
    421.33 ± 20%     +69.7%     715.00 ± 22%  softirqs.CPU52.TIMER
      7.33 ±179%     -84.4%       1.14 ±244%  softirqs.CPU53.BLOCK
      2.67 ±174%     -89.3%       0.29 ±158%  softirqs.CPU53.NET_RX
      0.67 ±111%     -78.6%       0.14 ±244%  softirqs.CPU53.NET_TX
     45571 ± 13%     +93.4%      88149 ± 15%  softirqs.CPU53.RCU
      4463 ± 18%    +234.1%      14912 ±  4%  softirqs.CPU53.SCHED
      6.50 ±223%     -91.2%       0.57 ±244%  softirqs.CPU53.TASKLET
    455.67 ± 21%     +67.0%     761.14 ± 14%  softirqs.CPU53.TIMER
      1.33 ±223%    -100.0%       0.00        softirqs.CPU54.BLOCK
      2.33 ±149%     -81.6%       0.43 ±115%  softirqs.CPU54.NET_RX
      0.33 ±223%     -14.3%       0.29 ±158%  softirqs.CPU54.NET_TX
     45447 ± 14%     +93.5%      87934 ± 15%  softirqs.CPU54.RCU
      4630 ± 19%    +224.0%      15004 ±  6%  softirqs.CPU54.SCHED
      0.00          -100.0%       0.00        softirqs.CPU54.TASKLET
    433.00 ± 21%     +76.8%     765.71 ± 18%  softirqs.CPU54.TIMER
      4.67 ±223%    -100.0%       0.00        softirqs.CPU55.BLOCK
      1.17 ±187%     -26.5%       0.86 ±131%  softirqs.CPU55.NET_RX
      0.17 ±223%     -14.3%       0.14 ±244%  softirqs.CPU55.NET_TX
     44837 ± 13%     +93.4%      86729 ± 15%  softirqs.CPU55.RCU
      4534 ± 17%    +234.1%      15148 ±  6%  softirqs.CPU55.SCHED
      0.00          -100.0%       0.00        softirqs.CPU55.TASKLET
    432.83 ± 27%     +75.9%     761.29 ± 19%  softirqs.CPU55.TIMER
      0.00       +6.3e+102%       6.29 ±197%  softirqs.CPU56.BLOCK
    161.33 ±222%     -93.3%      10.86 ±237%  softirqs.CPU56.NET_RX
      0.33 ±141%     -14.3%       0.29 ±158%  softirqs.CPU56.NET_TX
     44968 ± 13%     +94.8%      87589 ± 15%  softirqs.CPU56.RCU
      4468 ± 20%    +238.6%      15132 ±  6%  softirqs.CPU56.SCHED
      0.00       +8.6e+101%       0.86 ±169%  softirqs.CPU56.TASKLET
    461.00 ± 23%     +65.9%     764.71 ± 19%  softirqs.CPU56.TIMER
      2.67 ±141%     +92.9%       5.14 ±244%  softirqs.CPU57.BLOCK
      2.67 ±175%    +280.4%      10.14 ±205%  softirqs.CPU57.NET_RX
      0.17 ±223%    -100.0%       0.00        softirqs.CPU57.NET_TX
     45120 ± 13%     +94.1%      87586 ± 15%  softirqs.CPU57.RCU
      4410 ± 19%    +239.2%      14959 ±  6%  softirqs.CPU57.SCHED
      0.33 ±223%     -57.1%       0.14 ±244%  softirqs.CPU57.TASKLET
    423.17 ± 19%     +72.2%     728.86 ± 19%  softirqs.CPU57.TIMER
      1.33 ±223%     -78.6%       0.29 ±244%  softirqs.CPU58.BLOCK
      0.67 ±111%  +16228.6%     108.86 ±206%  softirqs.CPU58.NET_RX
      0.33 ±141%     +71.4%       0.57 ±127%  softirqs.CPU58.NET_TX
     45536 ± 13%     +91.2%      87064 ± 16%  softirqs.CPU58.RCU
      4646 ± 19%    +221.8%      14953 ±  6%  softirqs.CPU58.SCHED
      0.00       +1.4e+101%       0.14 ±244%  softirqs.CPU58.TASKLET
    677.00 ± 60%     +19.2%     807.29 ± 14%  softirqs.CPU58.TIMER
      2.83 ±223%     -89.9%       0.29 ±158%  softirqs.CPU59.BLOCK
      0.33 ±141%   +4057.1%      13.86 ±230%  softirqs.CPU59.NET_RX
      0.17 ±223%     -14.3%       0.14 ±244%  softirqs.CPU59.NET_TX
     45710 ± 13%     +93.4%      88400 ± 15%  softirqs.CPU59.RCU
      4490 ± 18%    +237.7%      15163 ±  4%  softirqs.CPU59.SCHED
      0.17 ±223%     -14.3%       0.14 ±244%  softirqs.CPU59.TASKLET
    482.67 ± 17%     +92.9%     931.29 ± 43%  softirqs.CPU59.TIMER
      6.00 ±223%     -61.9%       2.29 ±244%  softirqs.CPU6.BLOCK
     15.83 ±143%     -91.0%       1.43 ± 90%  softirqs.CPU6.NET_RX
      0.50 ±152%     -42.9%       0.29 ±158%  softirqs.CPU6.NET_TX
     45425 ± 13%     +94.0%      88137 ± 15%  softirqs.CPU6.RCU
      4491 ± 18%    +238.3%      15194 ±  8%  softirqs.CPU6.SCHED
      0.00       +1.4e+101%       0.14 ±244%  softirqs.CPU6.TASKLET
    388.50 ± 23%    +159.5%       1008 ± 39%  softirqs.CPU6.TIMER
      1.67 ±175%     -82.9%       0.29 ±244%  softirqs.CPU60.BLOCK
     37.33 ±209%     -88.5%       4.29 ±207%  softirqs.CPU60.NET_RX
      0.67 ±141%     -35.7%       0.43 ±115%  softirqs.CPU60.NET_TX
     44609 ± 13%     +94.2%      86635 ± 15%  softirqs.CPU60.RCU
      4570 ± 22%    +231.1%      15134 ±  6%  softirqs.CPU60.SCHED
      0.00       +7.1e+101%       0.71 ±162%  softirqs.CPU60.TASKLET
    389.17 ± 13%     +85.9%     723.57 ± 25%  softirqs.CPU60.TIMER
      0.67 ±111%     +92.9%       1.29 ± 99%  softirqs.CPU61.NET_RX
      0.17 ±223%     +71.4%       0.29 ±158%  softirqs.CPU61.NET_TX
     44695 ± 13%     +95.0%      87134 ± 14%  softirqs.CPU61.RCU
      4430 ± 20%    +235.2%      14847 ±  7%  softirqs.CPU61.SCHED
      0.00       +3.6e+102%       3.57 ±244%  softirqs.CPU61.TASKLET
    391.33 ± 10%     +96.9%     770.71 ± 21%  softirqs.CPU61.TIMER
      0.00       +1.4e+101%       0.14 ±244%  softirqs.CPU62.BLOCK
      0.50 ±152%     +42.9%       0.71 ±144%  softirqs.CPU62.NET_RX
      0.00       +2.9e+101%       0.29 ±158%  softirqs.CPU62.NET_TX
     45019 ± 13%     +93.7%      87223 ± 15%  softirqs.CPU62.RCU
      4567 ± 18%    +229.4%      15044 ±  7%  softirqs.CPU62.SCHED
      0.00          -100.0%       0.00        softirqs.CPU62.TASKLET
    446.33 ± 24%     +73.6%     774.86 ± 20%  softirqs.CPU62.TIMER
      1.33 ±223%     -14.3%       1.14 ±244%  softirqs.CPU63.BLOCK
      0.50 ±100%  +21871.4%     109.86 ±243%  softirqs.CPU63.NET_RX
      0.17 ±223%     +71.4%       0.29 ±158%  softirqs.CPU63.NET_TX
     45198 ± 13%     +93.5%      87445 ± 15%  softirqs.CPU63.RCU
      4548 ± 19%    +230.3%      15022 ±  7%  softirqs.CPU63.SCHED
      1.67 ±157%     -91.4%       0.14 ±244%  softirqs.CPU63.TASKLET
    434.83 ± 20%     +96.8%     855.57 ± 30%  softirqs.CPU63.TIMER
      0.17 ±223%    -100.0%       0.00        softirqs.CPU64.BLOCK
      0.83 ± 82%     +54.3%       1.29 ±107%  softirqs.CPU64.NET_RX
      0.50 ±100%     -14.3%       0.43 ±169%  softirqs.CPU64.NET_TX
     46957 ± 13%     +98.5%      93206 ± 14%  softirqs.CPU64.RCU
      4560 ± 19%    +230.0%      15048 ±  7%  softirqs.CPU64.SCHED
      0.00       +4.3e+101%       0.43 ±244%  softirqs.CPU64.TASKLET
    609.00 ± 22%     +76.1%       1072 ± 17%  softirqs.CPU64.TIMER
      0.50 ±152%    -100.0%       0.00        softirqs.CPU65.BLOCK
      6.67 ±203%  +18178.6%       1218 ±244%  softirqs.CPU65.NET_RX
      0.17 ±223%    +157.1%       0.43 ±115%  softirqs.CPU65.NET_TX
     47219 ± 13%     +99.3%      94116 ± 14%  softirqs.CPU65.RCU
      4520 ± 16%    +228.0%      14824 ±  7%  softirqs.CPU65.SCHED
      1.33 ±147%    -100.0%       0.00        softirqs.CPU65.TASKLET
    507.00 ± 22%    +115.1%       1090 ± 12%  softirqs.CPU65.TIMER
      0.00         +8e+102%       8.00 ±190%  softirqs.CPU66.BLOCK
      0.33 ±141%    +371.4%       1.57 ±131%  softirqs.CPU66.NET_RX
      0.00       +4.3e+101%       0.43 ±115%  softirqs.CPU66.NET_TX
     46720 ± 12%     +95.4%      91280 ± 16%  softirqs.CPU66.RCU
      4538 ± 21%    +230.9%      15017 ±  6%  softirqs.CPU66.SCHED
      0.00          -100.0%       0.00        softirqs.CPU66.TASKLET
    497.83 ± 21%     +95.6%     973.86 ± 21%  softirqs.CPU66.TIMER
      0.00       +5.1e+102%       5.14 ±244%  softirqs.CPU67.BLOCK
     13.17 ±193%     -98.9%       0.14 ±244%  softirqs.CPU67.NET_RX
      0.17 ±223%     -14.3%       0.14 ±244%  softirqs.CPU67.NET_TX
     46614 ± 13%    +100.1%      93289 ± 14%  softirqs.CPU67.RCU
      4455 ± 20%    +236.1%      14973 ±  7%  softirqs.CPU67.SCHED
      0.00       +1.3e+102%       1.29 ±244%  softirqs.CPU67.TASKLET
    477.17 ± 14%    +128.0%       1088 ± 18%  softirqs.CPU67.TIMER
      1.33 ±223%     +60.7%       2.14 ±226%  softirqs.CPU68.BLOCK
    591.67 ±178%     -97.2%      16.71 ±199%  softirqs.CPU68.NET_RX
      0.50 ±152%     -42.9%       0.29 ±158%  softirqs.CPU68.NET_TX
     46596 ± 13%    +100.8%      93542 ± 13%  softirqs.CPU68.RCU
      4590 ± 18%    +230.6%      15173 ±  7%  softirqs.CPU68.SCHED
      0.00       +5.4e+102%       5.43 ±223%  softirqs.CPU68.TASKLET
    500.67 ± 25%    +107.0%       1036 ± 12%  softirqs.CPU68.TIMER
      0.00         +2e+102%       2.00 ±244%  softirqs.CPU69.BLOCK
      7.83 ±200%     -56.2%       3.43 ±154%  softirqs.CPU69.NET_RX
      4.50 ±213%    -100.0%       0.00        softirqs.CPU69.NET_TX
     46622 ± 13%    +100.4%      93414 ± 14%  softirqs.CPU69.RCU
      4440 ± 23%    +237.6%      14991 ±  5%  softirqs.CPU69.SCHED
      0.00       +1.7e+102%       1.71 ±244%  softirqs.CPU69.TASKLET
    470.83 ± 24%    +114.7%       1010 ± 10%  softirqs.CPU69.TIMER
      0.00       +1.1e+102%       1.14 ±244%  softirqs.CPU7.BLOCK
      0.17 ±223%  +23214.3%      38.86 ±143%  softirqs.CPU7.NET_RX
      0.00          -100.0%       0.00        softirqs.CPU7.NET_TX
     44802 ± 13%     +93.9%      86875 ± 15%  softirqs.CPU7.RCU
      4678 ± 22%    +223.4%      15127 ±  6%  softirqs.CPU7.SCHED
      0.00       +4.3e+101%       0.43 ±244%  softirqs.CPU7.TASKLET
    537.00 ± 83%     +34.5%     722.00 ± 24%  softirqs.CPU7.TIMER
      2.17 ±203%     -20.9%       1.71 ±244%  softirqs.CPU70.BLOCK
      4.00 ±101%     -57.1%       1.71 ±115%  softirqs.CPU70.NET_RX
      0.50 ±152%     -14.3%       0.43 ±115%  softirqs.CPU70.NET_TX
     47038 ± 12%     +99.5%      93847 ± 14%  softirqs.CPU70.RCU
      4612 ± 21%    +223.2%      14909 ±  7%  softirqs.CPU70.SCHED
      0.00       +2.4e+102%       2.43 ±199%  softirqs.CPU70.TASKLET
    489.17 ± 21%    +119.0%       1071 ± 12%  softirqs.CPU70.TIMER
      3.50 ±152%     -91.8%       0.29 ±244%  softirqs.CPU71.BLOCK
     22.50 ±219%     -94.9%       1.14 ±143%  softirqs.CPU71.NET_RX
      0.33 ±141%     -14.3%       0.29 ±158%  softirqs.CPU71.NET_TX
     46892 ± 13%     +99.7%      93627 ± 14%  softirqs.CPU71.RCU
      4526 ± 19%    +231.5%      15007 ±  5%  softirqs.CPU71.SCHED
      1.50 ±223%    +166.7%       4.00 ±173%  softirqs.CPU71.TASKLET
    459.33 ± 25%    +125.9%       1037 ± 15%  softirqs.CPU71.TIMER
      4.67 ±223%    -100.0%       0.00        softirqs.CPU72.BLOCK
      0.00       +9.2e+103%      92.29 ±234%  softirqs.CPU72.NET_RX
      0.00          -100.0%       0.00        softirqs.CPU72.NET_TX
     46358 ± 15%     +97.3%      91487 ± 15%  softirqs.CPU72.RCU
      4700 ± 19%    +232.7%      15638 ±  8%  softirqs.CPU72.SCHED
    463.50 ± 24%    +106.4%     956.86 ± 18%  softirqs.CPU72.TIMER
      5.33 ±207%    -100.0%       0.00        softirqs.CPU73.BLOCK
      0.00       +3.8e+104%     380.86 ±244%  softirqs.CPU73.NET_RX
      0.00       +1.4e+101%       0.14 ±244%  softirqs.CPU73.NET_TX
     46066 ± 15%     +98.1%      91276 ± 16%  softirqs.CPU73.RCU
      4550 ± 24%    +244.5%      15675 ±  8%  softirqs.CPU73.SCHED
      0.00         +1e+102%       1.00 ±207%  softirqs.CPU73.TASKLET
    496.83 ± 19%    +107.7%       1031 ± 32%  softirqs.CPU73.TIMER
      0.83 ±223%  +93311.4%     778.43 ±157%  softirqs.CPU74.NET_RX
      0.17 ±223%   +4185.7%       7.14 ±244%  softirqs.CPU74.NET_TX
     46385 ± 14%     +97.5%      91600 ± 15%  softirqs.CPU74.RCU
      4665 ± 22%    +240.2%      15871 ±  8%  softirqs.CPU74.SCHED
    602.83 ± 28%     +71.8%       1035 ± 19%  softirqs.CPU74.TIMER
     10.17 ±206%     -98.6%       0.14 ±244%  softirqs.CPU75.NET_RX
      0.00          -100.0%       0.00        softirqs.CPU75.NET_TX
     46302 ± 15%     +97.9%      91613 ± 15%  softirqs.CPU75.RCU
      4637 ± 22%    +234.7%      15523 ±  8%  softirqs.CPU75.SCHED
      0.00       +1.4e+102%       1.43 ±217%  softirqs.CPU75.TASKLET
    564.83 ± 35%     +71.8%     970.43 ± 17%  softirqs.CPU75.TIMER
      0.00       +6.4e+102%       6.43 ±232%  softirqs.CPU76.BLOCK
     49.00 ±223%     -92.7%       3.57 ±193%  softirqs.CPU76.NET_RX
      0.00       +1.4e+101%       0.14 ±244%  softirqs.CPU76.NET_TX
     46275 ± 13%     +98.3%      91780 ± 15%  softirqs.CPU76.RCU
      4677 ± 19%    +237.9%      15806 ±  8%  softirqs.CPU76.SCHED
      0.00       +5.7e+101%       0.57 ±183%  softirqs.CPU76.TASKLET
    489.33 ± 22%     +87.6%     917.86 ± 21%  softirqs.CPU76.TIMER
      0.83 ±223%  +14677.1%     123.14 ±244%  softirqs.CPU77.NET_RX
      0.17 ±223%    -100.0%       0.00        softirqs.CPU77.NET_TX
     45140 ± 17%    +103.3%      91784 ± 15%  softirqs.CPU77.RCU
      4617 ± 22%    +243.5%      15859 ±  8%  softirqs.CPU77.SCHED
      0.00       +1.4e+101%       0.14 ±244%  softirqs.CPU77.TASKLET
    555.17 ± 42%     +77.4%     984.71 ± 18%  softirqs.CPU77.TIMER
      0.00       +6.3e+102%       6.29 ±232%  softirqs.CPU78.BLOCK
      0.83 ±223%     -14.3%       0.71 ±244%  softirqs.CPU78.NET_RX
      0.33 ±223%     -14.3%       0.29 ±244%  softirqs.CPU78.NET_TX
     46418 ± 14%     +95.4%      90702 ± 16%  softirqs.CPU78.RCU
      4896 ± 22%    +214.0%      15371 ±  8%  softirqs.CPU78.SCHED
      0.00       +1.4e+101%       0.14 ±244%  softirqs.CPU78.TASKLET
    604.67 ± 19%     +45.1%     877.14 ± 30%  softirqs.CPU78.TIMER
      0.00         +2e+104%     195.29 ±234%  softirqs.CPU79.NET_RX
      0.00       +1.4e+101%       0.14 ±244%  softirqs.CPU79.NET_TX
     46352 ± 14%     +97.7%      91647 ± 15%  softirqs.CPU79.RCU
      4737 ± 21%    +234.2%      15830 ±  8%  softirqs.CPU79.SCHED
      1.67 ±197%     +62.9%       2.71 ±244%  softirqs.CPU79.TASKLET
    504.50 ± 19%     +86.5%     941.00 ± 17%  softirqs.CPU79.TIMER
    265.67 ±193%     -99.6%       1.00 ± 92%  softirqs.CPU8.NET_RX
      0.17 ±223%     +71.4%       0.29 ±158%  softirqs.CPU8.NET_TX
     44743 ± 13%     +94.8%      87149 ± 14%  softirqs.CPU8.RCU
      4434 ± 17%    +238.5%      15007 ±  6%  softirqs.CPU8.SCHED
    388.00 ± 36%     +95.1%     757.00 ± 21%  softirqs.CPU8.TIMER
      4.67 ±223%    -100.0%       0.00        softirqs.CPU80.BLOCK
      0.00       +2.9e+102%       2.86 ±244%  softirqs.CPU80.NET_RX
     45074 ± 14%     +96.3%      88493 ± 15%  softirqs.CPU80.RCU
      4806 ± 20%    +229.6%      15841 ±  7%  softirqs.CPU80.SCHED
      0.00       +1.4e+101%       0.14 ±244%  softirqs.CPU80.TASKLET
    440.33 ± 14%     +76.0%     774.86 ± 12%  softirqs.CPU80.TIMER
      7.00 ±223%    -100.0%       0.00        softirqs.CPU81.BLOCK
      0.00       +2.1e+103%      21.29 ±243%  softirqs.CPU81.NET_RX
      0.00          -100.0%       0.00        softirqs.CPU81.NET_TX
     44705 ± 13%     +96.9%      88017 ± 14%  softirqs.CPU81.RCU
      4822 ± 20%    +226.0%      15719 ±  7%  softirqs.CPU81.SCHED
      8.50 ±223%    -100.0%       0.00        softirqs.CPU81.TASKLET
    441.17 ± 17%     +79.8%     793.00 ± 15%  softirqs.CPU81.TIMER
      0.33 ±223%   +2900.0%      10.00 ±240%  softirqs.CPU82.BLOCK
      6.83 ±223%   +1150.2%      85.43 ±185%  softirqs.CPU82.NET_RX
      0.17 ±223%     -14.3%       0.14 ±244%  softirqs.CPU82.NET_TX
     44480 ± 14%     +98.1%      88109 ± 14%  softirqs.CPU82.RCU
      4792 ± 21%    +230.3%      15828 ±  8%  softirqs.CPU82.SCHED
      0.17 ±223%    +328.6%       0.71 ±244%  softirqs.CPU82.TASKLET
    470.67 ± 13%     +67.8%     789.71 ± 14%  softirqs.CPU82.TIMER
      0.00       +4.3e+102%       4.29 ±226%  softirqs.CPU83.BLOCK
    280.50 ±151%    +634.7%       2060 ±225%  softirqs.CPU83.NET_RX
      0.33 ±141%     -57.1%       0.14 ±244%  softirqs.CPU83.NET_TX
     45009 ± 13%     +95.2%      87873 ± 14%  softirqs.CPU83.RCU
      4620 ± 20%    +238.5%      15641 ±  9%  softirqs.CPU83.SCHED
      0.00         +5e+102%       5.00 ±220%  softirqs.CPU83.TASKLET
    467.67 ± 17%    +183.3%       1324 ±101%  softirqs.CPU83.TIMER
      0.17 ±223%    -100.0%       0.00        softirqs.CPU84.NET_RX
     45128 ± 13%     +93.3%      87214 ± 12%  softirqs.CPU84.RCU
      4669 ± 21%    +236.7%      15723 ±  8%  softirqs.CPU84.SCHED
      0.00          -100.0%       0.00        softirqs.CPU84.TASKLET
    380.50 ± 16%    +104.8%     779.29 ± 16%  softirqs.CPU84.TIMER
     24.50 ±142%    -100.0%       0.00        softirqs.CPU85.BLOCK
      0.17 ±223%     +71.4%       0.29 ±158%  softirqs.CPU85.NET_RX
      0.17 ±223%    -100.0%       0.00        softirqs.CPU85.NET_TX
     45121 ± 13%     +97.0%      88889 ± 14%  softirqs.CPU85.RCU
      4955 ± 21%    +218.4%      15780 ±  8%  softirqs.CPU85.SCHED
      0.00       +1.4e+101%       0.14 ±244%  softirqs.CPU85.TASKLET
    386.83 ± 13%    +114.5%     829.57 ± 15%  softirqs.CPU85.TIMER
      2.00 ±223%    +107.1%       4.14 ±225%  softirqs.CPU86.BLOCK
      0.00       +2.7e+102%       2.71 ±216%  softirqs.CPU86.NET_RX
      0.00          -100.0%       0.00        softirqs.CPU86.NET_TX
     44767 ± 14%     +97.7%      88499 ± 14%  softirqs.CPU86.RCU
      4632 ± 21%    +236.2%      15575 ±  7%  softirqs.CPU86.SCHED
      0.17 ±223%     +71.4%       0.29 ±244%  softirqs.CPU86.TASKLET
    405.67 ± 16%     +96.2%     796.00 ± 17%  softirqs.CPU86.TIMER
      9.00 ±223%     -96.8%       0.29 ±244%  softirqs.CPU87.BLOCK
      3.33 ±223%     -82.9%       0.57 ±244%  softirqs.CPU87.NET_RX
      0.00       +1.4e+101%       0.14 ±244%  softirqs.CPU87.NET_TX
     44967 ± 14%     +97.6%      88856 ± 15%  softirqs.CPU87.RCU
      4682 ± 20%    +237.7%      15810 ±  8%  softirqs.CPU87.SCHED
      2.00 ±223%     -92.9%       0.14 ±244%  softirqs.CPU87.TASKLET
    501.17 ± 12%     +62.9%     816.57 ± 23%  softirqs.CPU87.TIMER
      0.00       +6.3e+102%       6.29 ±244%  softirqs.CPU88.BLOCK
      1.33 ±223%    +210.7%       4.14 ±198%  softirqs.CPU88.NET_RX
      0.17 ±223%    -100.0%       0.00        softirqs.CPU88.NET_TX
     44994 ± 14%     +96.2%      88271 ± 14%  softirqs.CPU88.RCU
      4583 ± 19%    +247.7%      15936 ±  8%  softirqs.CPU88.SCHED
      0.00       +5.7e+101%       0.57 ±244%  softirqs.CPU88.TASKLET
    459.50 ± 18%     +79.8%     826.00 ± 21%  softirqs.CPU88.TIMER
      4.83 ±223%    -100.0%       0.00        softirqs.CPU89.BLOCK
      0.00       +1.4e+102%       1.43 ±162%  softirqs.CPU89.NET_RX
      0.00       +1.4e+101%       0.14 ±244%  softirqs.CPU89.NET_TX
     44642 ± 13%     +97.6%      88196 ± 14%  softirqs.CPU89.RCU
      4572 ± 20%    +241.7%      15622 ±  8%  softirqs.CPU89.SCHED
    385.67 ± 17%     +99.8%     770.57 ± 13%  softirqs.CPU89.TIMER
      0.00       +4.9e+102%       4.86 ±170%  softirqs.CPU9.BLOCK
     10.33 ±181%     -83.4%       1.71 ±222%  softirqs.CPU9.NET_RX
      0.00       +2.9e+101%       0.29 ±244%  softirqs.CPU9.NET_TX
     44964 ± 13%     +93.9%      87191 ± 14%  softirqs.CPU9.RCU
      4616 ± 18%    +224.1%      14961 ±  5%  softirqs.CPU9.SCHED
      0.00       +1.4e+101%       0.14 ±244%  softirqs.CPU9.TASKLET
    429.17 ± 43%     +74.2%     747.57 ± 19%  softirqs.CPU9.TIMER
      0.00       +3.9e+102%       3.86 ±244%  softirqs.CPU90.BLOCK
      0.00          -100.0%       0.00        softirqs.CPU90.NET_RX
     44386 ± 13%     +97.0%      87446 ± 15%  softirqs.CPU90.RCU
      4846 ± 21%    +220.9%      15553 ±  8%  softirqs.CPU90.SCHED
    372.50 ± 17%    +109.7%     781.29 ± 10%  softirqs.CPU90.TIMER
      5.00 ±223%    -100.0%       0.00        softirqs.CPU91.BLOCK
      5.50 ±223%     -89.6%       0.57 ±183%  softirqs.CPU91.NET_RX
      0.17 ±223%    -100.0%       0.00        softirqs.CPU91.NET_TX
     44899 ± 14%     +98.3%      89018 ± 14%  softirqs.CPU91.RCU
      4846 ± 20%    +224.3%      15716 ±  8%  softirqs.CPU91.SCHED
      0.00       +1.4e+101%       0.14 ±244%  softirqs.CPU91.TASKLET
    450.50 ±  5%     +80.7%     813.86 ± 16%  softirqs.CPU91.TIMER
      4.17 ±223%    -100.0%       0.00        softirqs.CPU92.BLOCK
      3.33 ±223%   +3594.3%     123.14 ±219%  softirqs.CPU92.NET_RX
      0.00       +5.7e+101%       0.57 ±127%  softirqs.CPU92.NET_TX
     43861 ± 18%    +101.6%      88422 ± 14%  softirqs.CPU92.RCU
      4787 ± 23%    +227.7%      15685 ±  7%  softirqs.CPU92.SCHED
      0.50 ±223%    -100.0%       0.00        softirqs.CPU92.TASKLET
    398.00 ± 24%    +106.7%     822.57 ± 18%  softirqs.CPU92.TIMER
      1.00 ±182%  +10528.6%     106.29 ±234%  softirqs.CPU93.NET_RX
      0.50 ±152%    -100.0%       0.00        softirqs.CPU93.NET_TX
     44550 ± 14%     +97.6%      88043 ± 15%  softirqs.CPU93.RCU
      4737 ± 18%    +235.2%      15882 ±  7%  softirqs.CPU93.SCHED
      0.17 ±223%    -100.0%       0.00        softirqs.CPU93.TASKLET
    473.83 ± 18%     +68.6%     799.00 ± 13%  softirqs.CPU93.TIMER
     17.50 ±143%     -75.5%       4.29 ±244%  softirqs.CPU94.BLOCK
     44048 ±  9%     +99.9%      88059 ± 14%  softirqs.CPU94.RCU
      4875 ± 20%    +223.2%      15758 ±  7%  softirqs.CPU94.SCHED
      1.17 ±187%    -100.0%       0.00        softirqs.CPU94.TASKLET
    561.00 ± 65%     +35.5%     760.29 ± 12%  softirqs.CPU94.TIMER
     11.83 ±182%    -100.0%       0.00        softirqs.CPU95.BLOCK
      4.33 ±223%    -100.0%       0.00        softirqs.CPU95.NET_TX
     44252 ± 13%     +97.5%      87409 ± 14%  softirqs.CPU95.RCU
      4698 ± 25%    +233.3%      15656 ± 10%  softirqs.CPU95.SCHED
      0.00          -100.0%       0.00        softirqs.CPU95.TASKLET
    497.50 ± 21%     +61.1%     801.29 ± 16%  softirqs.CPU95.TIMER
      2.33 ± 20%      -2.0%       2.29 ± 19%  softirqs.HI
     11352 ± 64%     +39.2%      15804 ± 56%  softirqs.NET_RX
     47.67 ±  3%     +77.4%      84.57 ±  9%  softirqs.NET_TX
   4358826 ± 13%     +96.9%    8582496 ± 14%  softirqs.RCU
    446072 ± 19%    +231.1%    1476904 ±  7%  softirqs.SCHED
    236.33            +5.0%     248.14        softirqs.TASKLET
     47129 ± 10%     +87.2%      88240 ± 12%  softirqs.TIMER
     88.86 ± 10%     -61.1       27.75 ±158%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe
     78.20 ± 13%     -51.2       26.98 ±158%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe
     40.81 ± 12%     -28.1       12.73 ±158%  perf-profile.calltrace.cycles-pp.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
     40.13 ± 11%     -27.5       12.63 ±158%  perf-profile.calltrace.cycles-pp.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
     36.56 ± 16%     -22.4       14.15 ±158%  perf-profile.calltrace.cycles-pp.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
     35.80 ± 16%     -21.8       14.05 ±158%  perf-profile.calltrace.cycles-pp.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
     18.21 ± 14%     -14.4        3.85 ± 89%  perf-profile.calltrace.cycles-pp.sock_def_readable.unix_stream_sendmsg.sock_sendmsg.sock_write_iter.new_sync_write
     17.34 ± 14%     -14.2        3.16 ±105%  perf-profile.calltrace.cycles-pp.__wake_up_common_lock.sock_def_readable.unix_stream_sendmsg.sock_sendmsg.sock_write_iter
     15.79 ± 11%     -12.9        2.91 ±106%  perf-profile.calltrace.cycles-pp.__wake_up_common.__wake_up_common_lock.sock_def_readable.unix_stream_sendmsg.sock_sendmsg
     15.52 ± 11%     -12.7        2.85 ±106%  perf-profile.calltrace.cycles-pp.autoremove_wake_function.__wake_up_common.__wake_up_common_lock.sock_def_readable.unix_stream_sendmsg
     15.33 ± 11%     -12.5        2.82 ±106%  perf-profile.calltrace.cycles-pp.try_to_wake_up.autoremove_wake_function.__wake_up_common.__wake_up_common_lock.sock_def_readable
     11.95 ±  9%      -9.8        2.13 ±112%  perf-profile.calltrace.cycles-pp.schedule_timeout.unix_stream_read_generic.unix_stream_recvmsg.sock_read_iter.new_sync_read
     11.60 ±  9%      -9.5        2.08 ±112%  perf-profile.calltrace.cycles-pp.schedule.schedule_timeout.unix_stream_read_generic.unix_stream_recvmsg.sock_read_iter
     11.41 ±  9%      -9.4        2.05 ±112%  perf-profile.calltrace.cycles-pp.__schedule.schedule.schedule_timeout.unix_stream_read_generic.unix_stream_recvmsg
      9.90 ± 35%      -9.2        0.68 ±210%  perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.entry_SYSCALL_64_after_hwframe
      5.58 ± 17%      -4.9        0.65 ±212%  perf-profile.calltrace.cycles-pp.exit_to_user_mode_prepare.syscall_exit_to_user_mode.entry_SYSCALL_64_after_hwframe
      5.49 ± 14%      -4.6        0.88 ±101%  perf-profile.calltrace.cycles-pp.ttwu_do_activate.try_to_wake_up.autoremove_wake_function.__wake_up_common.__wake_up_common_lock
      5.36 ± 14%      -4.5        0.85 ±100%  perf-profile.calltrace.cycles-pp.enqueue_task_fair.ttwu_do_activate.try_to_wake_up.autoremove_wake_function.__wake_up_common
      4.92 ± 10%      -4.5        0.43 ±244%  perf-profile.calltrace.cycles-pp.dequeue_task_fair.__schedule.schedule.schedule_timeout.unix_stream_read_generic
      4.35 ± 17%      -3.9        0.49 ±244%  perf-profile.calltrace.cycles-pp.select_task_rq_fair.try_to_wake_up.autoremove_wake_function.__wake_up_common.__wake_up_common_lock
      3.84 ± 54%      -3.7        0.10 ±244%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.get_partial_node.___slab_alloc.__slab_alloc
      3.65 ± 17%      -3.3        0.38 ±244%  perf-profile.calltrace.cycles-pp.schedule.exit_to_user_mode_prepare.syscall_exit_to_user_mode.entry_SYSCALL_64_after_hwframe
      3.63 ± 14%      -3.3        0.37 ±244%  perf-profile.calltrace.cycles-pp.__schedule.schedule.exit_to_user_mode_prepare.syscall_exit_to_user_mode.entry_SYSCALL_64_after_hwframe
      3.17 ± 18%      -2.8        0.33 ±244%  perf-profile.calltrace.cycles-pp.select_idle_sibling.select_task_rq_fair.try_to_wake_up.autoremove_wake_function.__wake_up_common
      4.88 ±  8%      -2.7        2.19 ± 11%  perf-profile.calltrace.cycles-pp.unix_stream_read_actor.unix_stream_read_generic.unix_stream_recvmsg.sock_read_iter.new_sync_read
      4.84 ±  8%      -2.7        2.17 ± 10%  perf-profile.calltrace.cycles-pp.skb_copy_datagram_iter.unix_stream_read_actor.unix_stream_read_generic.unix_stream_recvmsg.sock_read_iter
      4.77 ±  8%      -2.6        2.15 ± 11%  perf-profile.calltrace.cycles-pp.__skb_datagram_iter.skb_copy_datagram_iter.unix_stream_read_actor.unix_stream_read_generic.unix_stream_recvmsg
      3.03 ± 48%      -2.5        0.57 ± 78%  perf-profile.calltrace.cycles-pp.__slab_alloc.__kmalloc_node_track_caller.__kmalloc_reserve.__alloc_skb.alloc_skb_with_frags
      2.66 ± 13%      -2.4        0.22 ±244%  perf-profile.calltrace.cycles-pp.enqueue_entity.enqueue_task_fair.ttwu_do_activate.try_to_wake_up.autoremove_wake_function
      2.89 ± 54%      -2.4        0.49 ± 99%  perf-profile.calltrace.cycles-pp.___slab_alloc.__slab_alloc.__kmalloc_node_track_caller.__kmalloc_reserve.__alloc_skb
      2.83 ± 44%      -2.3        0.49 ± 68%  perf-profile.calltrace.cycles-pp.___slab_alloc.__slab_alloc.kmem_cache_alloc_node.__alloc_skb.alloc_skb_with_frags
      2.89 ± 43%      -2.3        0.57 ± 48%  perf-profile.calltrace.cycles-pp.__slab_alloc.kmem_cache_alloc_node.__alloc_skb.alloc_skb_with_frags.sock_alloc_send_pskb
      2.43 ± 56%      -2.2        0.24 ±163%  perf-profile.calltrace.cycles-pp.get_partial_node.___slab_alloc.__slab_alloc.__kmalloc_node_track_caller.__kmalloc_reserve
      2.27 ± 52%      -2.1        0.17 ±158%  perf-profile.calltrace.cycles-pp.get_partial_node.___slab_alloc.__slab_alloc.kmem_cache_alloc_node.__alloc_skb
      2.09 ± 56%      -2.0        0.12 ±244%  perf-profile.calltrace.cycles-pp._raw_spin_lock.get_partial_node.___slab_alloc.__slab_alloc.__kmalloc_node_track_caller
      1.94 ± 52%      -1.9        0.00        perf-profile.calltrace.cycles-pp._raw_spin_lock.get_partial_node.___slab_alloc.__slab_alloc.kmem_cache_alloc_node
      2.04 ±  9%      -1.8        0.20 ±244%  perf-profile.calltrace.cycles-pp.dequeue_entity.dequeue_task_fair.__schedule.schedule.schedule_timeout
      1.60 ± 17%      -1.5        0.10 ±244%  perf-profile.calltrace.cycles-pp._raw_spin_lock.try_to_wake_up.autoremove_wake_function.__wake_up_common.__wake_up_common_lock
      1.52 ± 16%      -1.4        0.16 ±244%  perf-profile.calltrace.cycles-pp.switch_fpu_return.exit_to_user_mode_prepare.syscall_exit_to_user_mode.entry_SYSCALL_64_after_hwframe
      2.25 ± 23%      -1.3        0.91 ± 19%  perf-profile.calltrace.cycles-pp.skb_copy_datagram_from_iter.unix_stream_sendmsg.sock_sendmsg.sock_write_iter.new_sync_write
      2.50 ±  6%      -1.3        1.21 ± 10%  perf-profile.calltrace.cycles-pp._copy_to_iter.__skb_datagram_iter.skb_copy_datagram_iter.unix_stream_read_actor.unix_stream_read_generic
      1.39 ± 12%      -1.3        0.12 ±244%  perf-profile.calltrace.cycles-pp.pick_next_task_fair.__schedule.schedule.schedule_timeout.unix_stream_read_generic
      1.36 ± 18%      -1.2        0.12 ±244%  perf-profile.calltrace.cycles-pp.pick_next_task_fair.__schedule.schedule.exit_to_user_mode_prepare.syscall_exit_to_user_mode
      1.24 ± 21%      -1.2        0.00        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.try_to_wake_up.autoremove_wake_function.__wake_up_common
      1.34 ± 14%      -1.2        0.16 ±244%  perf-profile.calltrace.cycles-pp.switch_mm_irqs_off.__schedule.schedule.schedule_timeout.unix_stream_read_generic
      1.18 ± 53%      -1.2        0.00        perf-profile.calltrace.cycles-pp.put_cpu_partial.consume_skb.unix_stream_read_generic.unix_stream_recvmsg.sock_read_iter
      1.30 ± 22%      -1.1        0.15 ±244%  perf-profile.calltrace.cycles-pp.available_idle_cpu.select_idle_sibling.select_task_rq_fair.try_to_wake_up.autoremove_wake_function
      1.13 ± 53%      -1.1        0.00        perf-profile.calltrace.cycles-pp.unfreeze_partials.put_cpu_partial.consume_skb.unix_stream_read_generic.unix_stream_recvmsg
      1.11 ± 52%      -1.1        0.00        perf-profile.calltrace.cycles-pp.put_cpu_partial.kmem_cache_free.unix_stream_read_generic.unix_stream_recvmsg.sock_read_iter
      1.97 ± 22%      -1.1        0.88 ± 11%  perf-profile.calltrace.cycles-pp.simple_copy_to_iter.__skb_datagram_iter.skb_copy_datagram_iter.unix_stream_read_actor.unix_stream_read_generic
      1.07 ± 52%      -1.1        0.00        perf-profile.calltrace.cycles-pp.unfreeze_partials.put_cpu_partial.kmem_cache_free.unix_stream_read_generic.unix_stream_recvmsg
      1.91 ± 21%      -1.0        0.86 ± 11%  perf-profile.calltrace.cycles-pp.__check_object_size.simple_copy_to_iter.__skb_datagram_iter.skb_copy_datagram_iter.unix_stream_read_actor
      1.22 ± 23%      -1.0        0.26 ±115%  perf-profile.calltrace.cycles-pp._copy_from_iter.skb_copy_datagram_from_iter.unix_stream_sendmsg.sock_sendmsg.sock_write_iter
      1.02 ± 14%      -0.9        0.11 ±244%  perf-profile.calltrace.cycles-pp.update_curr.dequeue_entity.dequeue_task_fair.__schedule.schedule
      0.91 ± 54%      -0.9        0.00        perf-profile.calltrace.cycles-pp._raw_spin_lock.unfreeze_partials.put_cpu_partial.consume_skb.unix_stream_read_generic
      1.06 ± 13%      -0.9        0.15 ±244%  perf-profile.calltrace.cycles-pp.prepare_to_wait.unix_stream_read_generic.unix_stream_recvmsg.sock_read_iter.new_sync_read
      0.90 ± 23%      -0.9        0.00        perf-profile.calltrace.cycles-pp.security_file_permission.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.99 ± 14%      -0.9        0.10 ±244%  perf-profile.calltrace.cycles-pp.__switch_to_asm
      0.87 ± 22%      -0.9        0.00        perf-profile.calltrace.cycles-pp.__check_object_size.skb_copy_datagram_from_iter.unix_stream_sendmsg.sock_sendmsg.sock_write_iter
      0.92 ±  9%      -0.8        0.07 ±244%  perf-profile.calltrace.cycles-pp.update_curr.enqueue_entity.enqueue_task_fair.ttwu_do_activate.try_to_wake_up
      0.84 ± 52%      -0.8        0.00        perf-profile.calltrace.cycles-pp._raw_spin_lock.unfreeze_partials.put_cpu_partial.kmem_cache_free.unix_stream_read_generic
      0.82 ± 10%      -0.8        0.00        perf-profile.calltrace.cycles-pp.reweight_entity.enqueue_task_fair.ttwu_do_activate.try_to_wake_up.autoremove_wake_function
      0.81 ± 52%      -0.8        0.00        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.unfreeze_partials.put_cpu_partial.kmem_cache_free
      0.80 ± 13%      -0.8        0.00        perf-profile.calltrace.cycles-pp.reweight_entity.dequeue_task_fair.__schedule.schedule.schedule_timeout
      1.87 ± 13%      -0.8        1.07 ± 11%  perf-profile.calltrace.cycles-pp.skb_set_owner_w.sock_alloc_send_pskb.unix_stream_sendmsg.sock_sendmsg.sock_write_iter
      0.79 ± 71%      -0.8        0.00        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.unfreeze_partials.put_cpu_partial.consume_skb
      1.79 ± 18%      -0.8        1.03 ±  6%  perf-profile.calltrace.cycles-pp.copyout._copy_to_iter.__skb_datagram_iter.skb_copy_datagram_iter.unix_stream_read_actor
      0.76 ±119%      -0.8        0.00        perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.__wake_up_common_lock.sock_def_readable.unix_stream_sendmsg.sock_sendmsg
      0.87 ± 14%      -0.8        0.11 ±244%  perf-profile.calltrace.cycles-pp.perf_trace_sched_wakeup_template.try_to_wake_up.autoremove_wake_function.__wake_up_common.__wake_up_common_lock
      0.84 ± 19%      -0.7        0.10 ±244%  perf-profile.calltrace.cycles-pp.switch_mm_irqs_off.__schedule.schedule.exit_to_user_mode_prepare.syscall_exit_to_user_mode
      0.71 ± 47%      -0.7        0.00        perf-profile.calltrace.cycles-pp.sock_recvmsg.sock_read_iter.new_sync_read.vfs_read.ksys_read
      0.71 ± 10%      -0.7        0.00        perf-profile.calltrace.cycles-pp.update_load_avg.dequeue_entity.dequeue_task_fair.__schedule.schedule
      1.68 ± 18%      -0.7        0.98 ±  6%  perf-profile.calltrace.cycles-pp.copy_user_enhanced_fast_string.copyout._copy_to_iter.__skb_datagram_iter.skb_copy_datagram_iter
      0.70 ± 19%      -0.7        0.00        perf-profile.calltrace.cycles-pp.update_load_avg.enqueue_entity.enqueue_task_fair.ttwu_do_activate.try_to_wake_up
      0.68 ± 61%      -0.7        0.00        perf-profile.calltrace.cycles-pp.update_cfs_group.dequeue_task_fair.__schedule.schedule.schedule_timeout
      0.67 ± 47%      -0.7        0.00        perf-profile.calltrace.cycles-pp.copyin._copy_from_iter.skb_copy_datagram_from_iter.unix_stream_sendmsg.sock_sendmsg
      0.66 ± 11%      -0.7        0.00        perf-profile.calltrace.cycles-pp.ttwu_do_wakeup.try_to_wake_up.autoremove_wake_function.__wake_up_common.__wake_up_common_lock
      1.77 ± 20%      -0.7        1.11 ± 22%  perf-profile.calltrace.cycles-pp._raw_spin_lock.unix_stream_sendmsg.sock_sendmsg.sock_write_iter.new_sync_write
      0.64 ± 47%      -0.6        0.00        perf-profile.calltrace.cycles-pp.security_socket_recvmsg.sock_recvmsg.sock_read_iter.new_sync_read.vfs_read
      0.63 ± 47%      -0.6        0.00        perf-profile.calltrace.cycles-pp.security_socket_sendmsg.sock_sendmsg.sock_write_iter.new_sync_write.vfs_write
      0.63 ±  9%      -0.6        0.00        perf-profile.calltrace.cycles-pp.set_next_entity.pick_next_task_fair.__schedule.schedule.schedule_timeout
      0.62 ± 10%      -0.6        0.00        perf-profile.calltrace.cycles-pp.check_preempt_curr.ttwu_do_wakeup.try_to_wake_up.autoremove_wake_function.__wake_up_common
      2.00 ± 11%      -0.6        1.38 ± 16%  perf-profile.calltrace.cycles-pp.skb_release_all.consume_skb.unix_stream_read_generic.unix_stream_recvmsg.sock_read_iter
      0.62 ± 48%      -0.6        0.00        perf-profile.calltrace.cycles-pp.load_new_mm_cr3.switch_mm_irqs_off.__schedule.schedule.schedule_timeout
      0.61 ± 47%      -0.6        0.00        perf-profile.calltrace.cycles-pp.security_file_permission.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.61 ± 82%      -0.6        0.00        perf-profile.calltrace.cycles-pp.update_cfs_group.enqueue_task_fair.ttwu_do_activate.try_to_wake_up.autoremove_wake_function
      1.98 ± 11%      -0.6        1.37 ± 16%  perf-profile.calltrace.cycles-pp.skb_release_head_state.skb_release_all.consume_skb.unix_stream_read_generic.unix_stream_recvmsg
      0.78 ± 14%      -0.6        0.18 ±159%  perf-profile.calltrace.cycles-pp.mutex_lock.unix_stream_read_generic.unix_stream_recvmsg.sock_read_iter.new_sync_read
      0.59 ± 48%      -0.6        0.00        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64
      1.22 ± 19%      -0.6        0.64 ± 14%  perf-profile.calltrace.cycles-pp.__slab_free.consume_skb.unix_stream_read_generic.unix_stream_recvmsg.sock_read_iter
      1.91 ± 11%      -0.6        1.35 ± 16%  perf-profile.calltrace.cycles-pp.unix_destruct_scm.skb_release_head_state.skb_release_all.consume_skb.unix_stream_read_generic
      0.54 ±146%      -0.5        0.00        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.__wake_up_common_lock.sock_def_readable.unix_stream_sendmsg
      0.47 ± 71%      -0.5        0.00        perf-profile.calltrace.cycles-pp.copy_user_enhanced_fast_string.copyin._copy_from_iter.skb_copy_datagram_from_iter.unix_stream_sendmsg
      0.46 ± 71%      -0.5        0.00        perf-profile.calltrace.cycles-pp._raw_spin_unlock_irqrestore.unix_stream_read_generic.unix_stream_recvmsg.sock_read_iter.new_sync_read
      0.44 ± 71%      -0.4        0.00        perf-profile.calltrace.cycles-pp.memcg_kmem_get_cache.kmem_cache_alloc_node.__alloc_skb.alloc_skb_with_frags.sock_alloc_send_pskb
      0.44 ± 71%      -0.4        0.00        perf-profile.calltrace.cycles-pp.common_file_perm.security_file_permission.vfs_read.ksys_read.do_syscall_64
      0.41 ± 71%      -0.4        0.00        perf-profile.calltrace.cycles-pp._raw_spin_lock.__schedule.schedule.schedule_timeout.unix_stream_read_generic
      0.40 ± 71%      -0.4        0.00        perf-profile.calltrace.cycles-pp.common_file_perm.security_file_permission.vfs_write.ksys_write.do_syscall_64
      0.39 ± 71%      -0.4        0.00        perf-profile.calltrace.cycles-pp.copy_fpregs_to_fpstate
      0.39 ± 70%      -0.4        0.00        perf-profile.calltrace.cycles-pp.__fdget_pos.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.38 ± 71%      -0.4        0.00        perf-profile.calltrace.cycles-pp.__fdget_pos.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.37 ± 70%      -0.4        0.00        perf-profile.calltrace.cycles-pp.__fget_light.__fdget_pos.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.32 ±100%      -0.3        0.00        perf-profile.calltrace.cycles-pp.fsnotify.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.40 ± 73%      -0.3        0.08 ±244%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.prepare_to_wait.unix_stream_read_generic.unix_stream_recvmsg.sock_read_iter
      0.31 ±100%      -0.3        0.00        perf-profile.calltrace.cycles-pp.aa_sk_perm.security_socket_recvmsg.sock_recvmsg.sock_read_iter.new_sync_read
      0.30 ±100%      -0.3        0.00        perf-profile.calltrace.cycles-pp.aa_sk_perm.security_socket_sendmsg.sock_sendmsg.sock_write_iter.new_sync_write
      0.30 ±100%      -0.3        0.00        perf-profile.calltrace.cycles-pp.update_load_avg.dequeue_task_fair.__schedule.schedule.schedule_timeout
      0.29 ±100%      -0.3        0.00        perf-profile.calltrace.cycles-pp.syscall_return_via_sysret
      0.28 ±100%      -0.3        0.00        perf-profile.calltrace.cycles-pp.load_new_mm_cr3.switch_mm_irqs_off.__schedule.schedule.exit_to_user_mode_prepare
      0.28 ±100%      -0.3        0.00        perf-profile.calltrace.cycles-pp.put_prev_entity.pick_next_task_fair.__schedule.schedule.exit_to_user_mode_prepare
      1.54 ± 19%      -0.3        1.26 ± 16%  perf-profile.calltrace.cycles-pp.sock_wfree.unix_destruct_scm.skb_release_head_state.skb_release_all.consume_skb
      0.28 ±100%      -0.3        0.00        perf-profile.calltrace.cycles-pp.__ksize.__alloc_skb.alloc_skb_with_frags.sock_alloc_send_pskb.unix_stream_sendmsg
      0.28 ±100%      -0.3        0.00        perf-profile.calltrace.cycles-pp.update_curr.reweight_entity.enqueue_task_fair.ttwu_do_activate.try_to_wake_up
      0.27 ±100%      -0.3        0.00        perf-profile.calltrace.cycles-pp.update_curr.reweight_entity.dequeue_task_fair.__schedule.schedule
      0.21 ±141%      -0.2        0.00        perf-profile.calltrace.cycles-pp.set_task_cpu.try_to_wake_up.autoremove_wake_function.__wake_up_common.__wake_up_common_lock
      0.19 ±141%      -0.2        0.00        perf-profile.calltrace.cycles-pp.check_preempt_wakeup.check_preempt_curr.ttwu_do_wakeup.try_to_wake_up.autoremove_wake_function
      0.19 ±141%      -0.2        0.00        perf-profile.calltrace.cycles-pp.__fget_light.__fdget_pos.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.18 ±223%      -0.2        0.00        perf-profile.calltrace.cycles-pp.finish_task_switch.__schedule.schedule.schedule_timeout.unix_stream_read_generic
      0.18 ±141%      -0.2        0.00        perf-profile.calltrace.cycles-pp.memcg_kmem_get_cache.__kmalloc_node_track_caller.__kmalloc_reserve.__alloc_skb.alloc_skb_with_frags
      0.17 ±141%      -0.2        0.00        perf-profile.calltrace.cycles-pp.update_load_avg.enqueue_task_fair.ttwu_do_activate.try_to_wake_up.autoremove_wake_function
      0.15 ±223%      -0.1        0.00        perf-profile.calltrace.cycles-pp.asm_sysvec_call_function_single.finish_task_switch.__schedule.schedule.schedule_timeout
      0.14 ±223%      -0.1        0.00        perf-profile.calltrace.cycles-pp.sysvec_call_function_single.asm_sysvec_call_function_single.finish_task_switch.__schedule.schedule
      0.13 ±223%      -0.1        0.00        perf-profile.calltrace.cycles-pp.asm_call_on_stack.sysvec_call_function_single.asm_sysvec_call_function_single.finish_task_switch.__schedule
      0.13 ±223%      -0.1        0.00        perf-profile.calltrace.cycles-pp.__sysvec_call_function_single.asm_call_on_stack.sysvec_call_function_single.asm_sysvec_call_function_single.finish_task_switch
      0.13 ±223%      -0.1        0.00        perf-profile.calltrace.cycles-pp.exit_to_user_mode_prepare.syscall_exit_to_user_mode.entry_SYSCALL_64_after_hwframe.__libc_write
      0.11 ±223%      -0.1        0.00        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.unix_stream_sendmsg.sock_sendmsg.sock_write_iter
      0.11 ±223%      -0.1        0.00        perf-profile.calltrace.cycles-pp.schedule.exit_to_user_mode_prepare.syscall_exit_to_user_mode.entry_SYSCALL_64_after_hwframe.__libc_write
      0.10 ±223%      -0.1        0.00        perf-profile.calltrace.cycles-pp.sched_ttwu_pending.__sysvec_call_function_single.asm_call_on_stack.sysvec_call_function_single.asm_sysvec_call_function_single
      0.10 ±223%      -0.1        0.00        perf-profile.calltrace.cycles-pp.skb_release_data.consume_skb.unix_stream_read_generic.unix_stream_recvmsg.sock_read_iter
      0.09 ±223%      -0.1        0.00        perf-profile.calltrace.cycles-pp.update_cfs_rq_h_load.select_task_rq_fair.try_to_wake_up.autoremove_wake_function.__wake_up_common
      0.09 ±223%      -0.1        0.00        perf-profile.calltrace.cycles-pp.update_rq_clock.try_to_wake_up.autoremove_wake_function.__wake_up_common.__wake_up_common_lock
      0.09 ±223%      -0.1        0.00        perf-profile.calltrace.cycles-pp.update_rq_clock.__schedule.schedule.schedule_timeout.unix_stream_read_generic
      0.36 ± 70%      -0.1        0.28 ±118%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.skb_unlink.unix_stream_read_generic.unix_stream_recvmsg.sock_read_iter
      0.89 ± 16%      -0.1        0.82 ± 32%  perf-profile.calltrace.cycles-pp.skb_queue_tail.unix_stream_sendmsg.sock_sendmsg.sock_write_iter.new_sync_write
      0.83 ± 17%      -0.0        0.79 ± 32%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.skb_queue_tail.unix_stream_sendmsg.sock_sendmsg.sock_write_iter
      0.81 ± 19%      -0.0        0.79 ± 31%  perf-profile.calltrace.cycles-pp.__slab_free.kmem_cache_free.unix_stream_read_generic.unix_stream_recvmsg.sock_read_iter
      1.14 ± 19%      -0.0        1.13 ± 25%  perf-profile.calltrace.cycles-pp._raw_spin_lock.unix_stream_read_generic.unix_stream_recvmsg.sock_read_iter.new_sync_read
      0.51 ± 46%      +0.0        0.53 ± 46%  perf-profile.calltrace.cycles-pp.skb_unlink.unix_stream_read_generic.unix_stream_recvmsg.sock_read_iter.new_sync_read
      0.69 ±148%      +0.1        0.80 ± 57%  perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.secondary_startup_64
      0.69 ±148%      +0.1        0.80 ± 57%  perf-profile.calltrace.cycles-pp.start_secondary.secondary_startup_64
      0.56 ±150%      +0.1        0.68 ± 57%  perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry.start_secondary
      0.68 ±148%      +0.1        0.80 ± 57%  perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64
      0.56 ±150%      +0.1        0.68 ± 57%  perf-profile.calltrace.cycles-pp.cpuidle_enter.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64
      0.69 ±148%      +0.1        0.82 ± 57%  perf-profile.calltrace.cycles-pp.secondary_startup_64
      0.45 ±153%      +0.2        0.62 ± 50%  perf-profile.calltrace.cycles-pp.intel_idle.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry
      0.00            +0.3        0.31 ±115%  perf-profile.calltrace.cycles-pp.__mod_memcg_state.__mod_memcg_lruvec_state.__kmalloc_node_track_caller.__kmalloc_reserve.__alloc_skb
      0.00            +0.3        0.31 ±115%  perf-profile.calltrace.cycles-pp.__mod_memcg_state.__mod_memcg_lruvec_state.kmem_cache_free.unix_stream_read_generic.unix_stream_recvmsg
      0.00            +0.3        0.33 ±115%  perf-profile.calltrace.cycles-pp.__mod_memcg_lruvec_state.__kmalloc_node_track_caller.__kmalloc_reserve.__alloc_skb.alloc_skb_with_frags
      0.00            +0.3        0.33 ±115%  perf-profile.calltrace.cycles-pp.__mod_memcg_lruvec_state.kmem_cache_free.unix_stream_read_generic.unix_stream_recvmsg.sock_read_iter
      0.00            +0.3        0.34 ±117%  perf-profile.calltrace.cycles-pp.get_obj_cgroup_from_current.__kmalloc_node_track_caller.__kmalloc_reserve.__alloc_skb.alloc_skb_with_frags
      0.00            +0.4        0.41 ±116%  perf-profile.calltrace.cycles-pp.__mod_memcg_state.__mod_memcg_lruvec_state.kmem_cache_alloc_node.__alloc_skb.alloc_skb_with_frags
      0.00            +0.4        0.41 ±115%  perf-profile.calltrace.cycles-pp.__mod_memcg_state.__mod_memcg_lruvec_state.kfree.consume_skb.unix_stream_read_generic
      0.00            +0.4        0.42 ± 93%  perf-profile.calltrace.cycles-pp.mutex_unlock.unix_stream_read_generic.unix_stream_recvmsg.sock_read_iter.new_sync_read
      0.00            +0.4        0.43 ±115%  perf-profile.calltrace.cycles-pp.__mod_memcg_lruvec_state.kfree.consume_skb.unix_stream_read_generic.unix_stream_recvmsg
      0.00            +0.4        0.43 ±116%  perf-profile.calltrace.cycles-pp.__mod_memcg_lruvec_state.kmem_cache_alloc_node.__alloc_skb.alloc_skb_with_frags.sock_alloc_send_pskb
      0.00            +0.5        0.52 ±117%  perf-profile.calltrace.cycles-pp.propagate_protected_usage.page_counter_try_charge.__memcg_kmem_charge.obj_cgroup_charge.kmem_cache_alloc_node
      0.00            +0.8        0.78 ±118%  perf-profile.calltrace.cycles-pp.propagate_protected_usage.page_counter_cancel.page_counter_uncharge.drain_obj_stock.refill_obj_stock
      0.00            +0.9        0.87 ±120%  perf-profile.calltrace.cycles-pp.propagate_protected_usage.page_counter_cancel.page_counter_uncharge.__memcg_kmem_uncharge.drain_obj_stock
     40.78 ±  4%      +0.9       41.71 ±  6%  perf-profile.calltrace.cycles-pp.new_sync_write.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
     40.35 ±  4%      +1.2       41.51 ±  6%  perf-profile.calltrace.cycles-pp.sock_write_iter.new_sync_write.vfs_write.ksys_write.do_syscall_64
      0.00            +1.3        1.29 ± 74%  perf-profile.calltrace.cycles-pp.propagate_protected_usage.page_counter_try_charge.__memcg_kmem_charge.obj_cgroup_charge.__kmalloc_node_track_caller
      0.48 ±152%      +1.3        1.81 ±158%  perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.entry_SYSCALL_64_after_hwframe.__libc_write
      0.39 ±144%      +1.3        1.72 ±159%  perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.entry_SYSCALL_64_after_hwframe.__libc_read
     39.70 ±  4%      +1.6       41.29 ±  6%  perf-profile.calltrace.cycles-pp.sock_sendmsg.sock_write_iter.new_sync_write.vfs_write.ksys_write
      0.00            +1.7        1.66 ± 34%  perf-profile.calltrace.cycles-pp.get_obj_cgroup_from_current.kmem_cache_alloc_node.__alloc_skb.alloc_skb_with_frags.sock_alloc_send_pskb
      0.00            +2.0        2.04 ± 21%  perf-profile.calltrace.cycles-pp.page_counter_cancel.page_counter_uncharge.drain_obj_stock.refill_obj_stock.kmem_cache_free
      0.00            +2.0        2.05 ± 21%  perf-profile.calltrace.cycles-pp.page_counter_uncharge.drain_obj_stock.refill_obj_stock.kmem_cache_free.unix_stream_read_generic
     38.80 ±  4%      +2.2       40.97 ±  7%  perf-profile.calltrace.cycles-pp.unix_stream_sendmsg.sock_sendmsg.sock_write_iter.new_sync_write.vfs_write
      0.00            +2.4        2.44 ± 22%  perf-profile.calltrace.cycles-pp.page_counter_cancel.page_counter_uncharge.drain_obj_stock.refill_obj_stock.kfree
      0.00            +2.4        2.45 ± 22%  perf-profile.calltrace.cycles-pp.page_counter_uncharge.drain_obj_stock.refill_obj_stock.kfree.consume_skb
      0.00            +2.7        2.74 ± 61%  perf-profile.calltrace.cycles-pp.page_counter_try_charge.__memcg_kmem_charge.obj_cgroup_charge.kmem_cache_alloc_node.__alloc_skb
      0.00            +2.8        2.82 ± 60%  perf-profile.calltrace.cycles-pp.__memcg_kmem_charge.obj_cgroup_charge.kmem_cache_alloc_node.__alloc_skb.alloc_skb_with_frags
      0.00            +3.3        3.30 ± 51%  perf-profile.calltrace.cycles-pp.page_counter_uncharge.__memcg_kmem_uncharge.drain_obj_stock.refill_obj_stock.kmem_cache_free
      0.00            +3.3        3.32 ± 51%  perf-profile.calltrace.cycles-pp.__memcg_kmem_uncharge.drain_obj_stock.refill_obj_stock.kmem_cache_free.unix_stream_read_generic
      0.00            +3.6        3.59 ± 42%  perf-profile.calltrace.cycles-pp.obj_cgroup_charge.kmem_cache_alloc_node.__alloc_skb.alloc_skb_with_frags.sock_alloc_send_pskb
      0.00            +4.0        3.99 ± 52%  perf-profile.calltrace.cycles-pp.page_counter_uncharge.__memcg_kmem_uncharge.drain_obj_stock.refill_obj_stock.kfree
      0.00            +4.0        4.01 ± 52%  perf-profile.calltrace.cycles-pp.__memcg_kmem_uncharge.drain_obj_stock.refill_obj_stock.kfree.consume_skb
      0.00            +5.3        5.28 ± 62%  perf-profile.calltrace.cycles-pp.page_counter_try_charge.__memcg_kmem_charge.obj_cgroup_charge.__kmalloc_node_track_caller.__kmalloc_reserve
      0.00            +5.4        5.44 ± 61%  perf-profile.calltrace.cycles-pp.__memcg_kmem_charge.obj_cgroup_charge.__kmalloc_node_track_caller.__kmalloc_reserve.__alloc_skb
      0.00            +6.7        6.66 ± 44%  perf-profile.calltrace.cycles-pp.obj_cgroup_charge.__kmalloc_node_track_caller.__kmalloc_reserve.__alloc_skb.alloc_skb_with_frags
      0.00            +7.0        7.01 ± 51%  perf-profile.calltrace.cycles-pp.page_counter_cancel.page_counter_uncharge.__memcg_kmem_uncharge.drain_obj_stock.refill_obj_stock
      0.00            +7.0        7.03 ± 24%  perf-profile.calltrace.cycles-pp.drain_obj_stock.refill_obj_stock.kmem_cache_free.unix_stream_read_generic.unix_stream_recvmsg
      0.00            +8.5        8.46 ± 24%  perf-profile.calltrace.cycles-pp.drain_obj_stock.refill_obj_stock.kfree.consume_skb.unix_stream_read_generic
      0.00            +8.6        8.65 ± 19%  perf-profile.calltrace.cycles-pp.refill_obj_stock.kmem_cache_free.unix_stream_read_generic.unix_stream_recvmsg.sock_read_iter
      0.00            +9.9        9.87 ± 20%  perf-profile.calltrace.cycles-pp.refill_obj_stock.kfree.consume_skb.unix_stream_read_generic.unix_stream_recvmsg
      4.32 ± 31%     +10.3       14.63 ± 17%  perf-profile.calltrace.cycles-pp.kmem_cache_alloc_node.__alloc_skb.alloc_skb_with_frags.sock_alloc_send_pskb.unix_stream_sendmsg
      4.57 ± 35%     +12.1       16.64 ± 13%  perf-profile.calltrace.cycles-pp.__kmalloc_reserve.__alloc_skb.alloc_skb_with_frags.sock_alloc_send_pskb.unix_stream_sendmsg
      4.43 ± 35%     +12.2       16.59 ± 13%  perf-profile.calltrace.cycles-pp.__kmalloc_node_track_caller.__kmalloc_reserve.__alloc_skb.alloc_skb_with_frags.sock_alloc_send_pskb
     35.59 ±  7%     +13.1       48.68 ±  6%  perf-profile.calltrace.cycles-pp.new_sync_read.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
     35.00 ±  7%     +13.5       48.51 ±  6%  perf-profile.calltrace.cycles-pp.sock_read_iter.new_sync_read.vfs_read.ksys_read.do_syscall_64
     33.43 ±  7%     +14.6       47.99 ±  6%  perf-profile.calltrace.cycles-pp.unix_stream_recvmsg.sock_read_iter.new_sync_read.vfs_read.ksys_read
     33.10 ±  7%     +14.8       47.88 ±  6%  perf-profile.calltrace.cycles-pp.unix_stream_read_generic.unix_stream_recvmsg.sock_read_iter.new_sync_read.vfs_read
      2.95 ± 24%     +15.2       18.14 ± 17%  perf-profile.calltrace.cycles-pp.kmem_cache_free.unix_stream_read_generic.unix_stream_recvmsg.sock_read_iter.new_sync_read
      5.77 ± 13%     +15.4       21.21 ± 12%  perf-profile.calltrace.cycles-pp.consume_skb.unix_stream_read_generic.unix_stream_recvmsg.sock_read_iter.new_sync_read
      0.00           +18.4       18.42 ± 16%  perf-profile.calltrace.cycles-pp.kfree.consume_skb.unix_stream_read_generic.unix_stream_recvmsg.sock_read_iter
     12.79 ± 20%     +20.3       33.12 ± 13%  perf-profile.calltrace.cycles-pp.sock_alloc_send_pskb.unix_stream_sendmsg.sock_sendmsg.sock_write_iter.new_sync_write
     10.38 ± 28%     +21.3       31.68 ± 14%  perf-profile.calltrace.cycles-pp.alloc_skb_with_frags.sock_alloc_send_pskb.unix_stream_sendmsg.sock_sendmsg.sock_write_iter
     10.24 ± 28%     +21.4       31.61 ± 14%  perf-profile.calltrace.cycles-pp.__alloc_skb.alloc_skb_with_frags.sock_alloc_send_pskb.unix_stream_sendmsg.sock_sendmsg
      2.52 ±148%     +27.2       29.76 ± 63%  perf-profile.calltrace.cycles-pp.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_write
      2.56 ±148%     +27.4       29.95 ± 63%  perf-profile.calltrace.cycles-pp.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_write
      2.58 ±148%     +27.4       30.03 ± 63%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_write
      3.09 ±149%     +28.9       32.02 ± 63%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__libc_write
      3.21 ±149%     +29.2       32.39 ± 63%  perf-profile.calltrace.cycles-pp.__libc_write
      2.14 ±149%     +33.3       35.41 ± 63%  perf-profile.calltrace.cycles-pp.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_read
      2.18 ±149%     +33.4       35.56 ± 63%  perf-profile.calltrace.cycles-pp.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_read
      2.21 ±149%     +33.4       35.64 ± 63%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_read
      2.62 ±148%     +34.9       37.55 ± 63%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__libc_read
      2.78 ±149%     +35.2       38.01 ± 63%  perf-profile.calltrace.cycles-pp.__libc_read
     18.22 ± 14%     -14.4        3.85 ± 89%  perf-profile.children.cycles-pp.sock_def_readable
     17.42 ± 14%     -14.1        3.29 ±100%  perf-profile.children.cycles-pp.__wake_up_common_lock
     15.86 ± 11%     -12.8        3.04 ±101%  perf-profile.children.cycles-pp.__wake_up_common
     15.57 ±  8%     -12.7        2.84 ±110%  perf-profile.children.cycles-pp.schedule
     15.59 ± 11%     -12.6        2.97 ±101%  perf-profile.children.cycles-pp.autoremove_wake_function
     15.50 ±  8%     -12.6        2.93 ±105%  perf-profile.children.cycles-pp.__schedule
     15.40 ± 11%     -12.5        2.93 ±101%  perf-profile.children.cycles-pp.try_to_wake_up
     12.03 ±  8%      -9.8        2.27 ±104%  perf-profile.children.cycles-pp.schedule_timeout
     11.67 ± 16%      -8.2        3.44 ± 36%  perf-profile.children.cycles-pp._raw_spin_lock
      8.64 ± 10%      -7.6        0.99 ± 72%  perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
     10.80 ± 37%      -6.3        4.48 ±115%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      6.09 ± 13%      -5.0        1.13 ±103%  perf-profile.children.cycles-pp.ttwu_do_activate
      5.96 ± 13%      -4.9        1.10 ±103%  perf-profile.children.cycles-pp.enqueue_task_fair
      6.14 ± 39%      -4.8        1.34 ± 34%  perf-profile.children.cycles-pp.__slab_alloc
      5.86 ± 12%      -4.8        1.09 ±110%  perf-profile.children.cycles-pp.exit_to_user_mode_prepare
      6.00 ± 39%      -4.7        1.31 ± 35%  perf-profile.children.cycles-pp.___slab_alloc
      4.99 ± 10%      -4.1        0.84 ±106%  perf-profile.children.cycles-pp.dequeue_task_fair
      4.94 ± 43%      -4.1        0.85 ± 45%  perf-profile.children.cycles-pp.get_partial_node
      4.40 ± 16%      -3.5        0.91 ±114%  perf-profile.children.cycles-pp.select_task_rq_fair
      3.52 ±  9%      -2.9        0.66 ± 98%  perf-profile.children.cycles-pp.update_curr
      3.49 ± 12%      -2.8        0.69 ± 96%  perf-profile.children.cycles-pp.update_load_avg
      4.89 ±  8%      -2.7        2.19 ± 11%  perf-profile.children.cycles-pp.unix_stream_read_actor
      4.85 ±  8%      -2.7        2.18 ± 11%  perf-profile.children.cycles-pp.skb_copy_datagram_iter
      4.77 ±  8%      -2.6        2.15 ± 10%  perf-profile.children.cycles-pp.__skb_datagram_iter
      3.24 ± 16%      -2.6        0.62 ±111%  perf-profile.children.cycles-pp.select_idle_sibling
      3.08 ± 10%      -2.5        0.53 ±100%  perf-profile.children.cycles-pp.pick_next_task_fair
      3.04 ± 11%      -2.4        0.64 ± 91%  perf-profile.children.cycles-pp.enqueue_entity
      2.44 ± 41%      -2.1        0.34 ± 65%  perf-profile.children.cycles-pp.put_cpu_partial
      2.32 ± 41%      -2.0        0.31 ± 69%  perf-profile.children.cycles-pp.unfreeze_partials
      3.92 ± 33%      -2.0        1.95 ± 41%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      3.04 ± 11%      -1.8        1.23 ± 13%  perf-profile.children.cycles-pp.__check_object_size
      2.31 ± 10%      -1.8        0.51 ±106%  perf-profile.children.cycles-pp.switch_mm_irqs_off
      2.19 ±  9%      -1.8        0.42 ± 99%  perf-profile.children.cycles-pp.dequeue_entity
      2.42 ± 14%      -1.5        0.92 ± 19%  perf-profile.children.cycles-pp.skb_copy_datagram_from_iter
      1.77 ±  9%      -1.5        0.28 ±107%  perf-profile.children.cycles-pp.reweight_entity
      1.73 ± 45%      -1.4        0.28 ± 86%  perf-profile.children.cycles-pp.update_cfs_group
      2.61 ±  7%      -1.3        1.29 ±  8%  perf-profile.children.cycles-pp.copy_user_enhanced_fast_string
      2.52 ±  6%      -1.3        1.22 ± 11%  perf-profile.children.cycles-pp._copy_to_iter
      1.59 ± 11%      -1.3        0.30 ±111%  perf-profile.children.cycles-pp.switch_fpu_return
      1.49 ± 14%      -1.3        0.21 ±129%  perf-profile.children.cycles-pp.load_new_mm_cr3
      2.12 ± 10%      -1.2        0.89 ± 11%  perf-profile.children.cycles-pp.simple_copy_to_iter
      1.50 ±  8%      -1.1        0.37 ± 66%  perf-profile.children.cycles-pp._raw_spin_unlock_irqrestore
      1.72 ± 13%      -1.1        0.59 ± 19%  perf-profile.children.cycles-pp.security_file_permission
      1.39 ± 20%      -1.1        0.29 ±116%  perf-profile.children.cycles-pp.available_idle_cpu
      1.07 ± 14%      -1.1        0.00        perf-profile.children.cycles-pp.memcg_kmem_get_cache
      1.95 ±  7%      -0.9        1.03 ±  6%  perf-profile.children.cycles-pp.copyout
      1.07 ± 11%      -0.9        0.19 ±114%  perf-profile.children.cycles-pp.__switch_to_asm
      1.95 ± 11%      -0.9        1.08 ± 11%  perf-profile.children.cycles-pp.skb_set_owner_w
      1.27 ± 22%      -0.9        0.40 ± 77%  perf-profile.children.cycles-pp.prepare_to_wait
      1.04 ±  8%      -0.8        0.19 ± 93%  perf-profile.children.cycles-pp.set_next_entity
      1.13 ± 90%      -0.8        0.31 ±244%  perf-profile.children.cycles-pp.asm_sysvec_call_function_single
      1.33 ± 14%      -0.8        0.51 ± 18%  perf-profile.children.cycles-pp._copy_from_iter
      1.00 ± 10%      -0.8        0.20 ± 96%  perf-profile.children.cycles-pp.update_rq_clock
      1.20 ± 11%      -0.8        0.42 ± 21%  perf-profile.children.cycles-pp.common_file_perm
      2.21 ±  8%      -0.8        1.44 ± 24%  perf-profile.children.cycles-pp.__slab_free
      1.23 ± 15%      -0.8        0.47 ± 15%  perf-profile.children.cycles-pp.syscall_return_via_sysret
      1.02 ± 91%      -0.7        0.28 ±244%  perf-profile.children.cycles-pp.sysvec_call_function_single
      1.11 ± 13%      -0.7        0.38 ± 18%  perf-profile.children.cycles-pp.aa_sk_perm
      1.12 ± 10%      -0.7        0.40 ± 27%  perf-profile.children.cycles-pp.__fdget_pos
      0.99 ± 91%      -0.7        0.27 ±244%  perf-profile.children.cycles-pp.__sysvec_call_function_single
      0.93 ± 12%      -0.7        0.21 ±114%  perf-profile.children.cycles-pp.perf_trace_sched_wakeup_template
     43.40 ±  4%      -0.7       42.69 ±  6%  perf-profile.children.cycles-pp.ksys_write
      0.90 ± 13%      -0.7        0.19 ±109%  perf-profile.children.cycles-pp.__update_load_avg_cfs_rq
      2.09 ±  7%      -0.7        1.39 ± 16%  perf-profile.children.cycles-pp.skb_release_all
      1.06 ± 13%      -0.7        0.36 ± 24%  perf-profile.children.cycles-pp.___might_sleep
      1.51 ± 56%      -0.7        0.82 ± 77%  perf-profile.children.cycles-pp.asm_call_on_stack
      2.07 ±  7%      -0.7        1.38 ± 16%  perf-profile.children.cycles-pp.skb_release_head_state
      1.01 ± 10%      -0.7        0.35 ± 29%  perf-profile.children.cycles-pp.__fget_light
      2.01 ±  8%      -0.7        1.36 ± 16%  perf-profile.children.cycles-pp.unix_destruct_scm
      0.80 ±  7%      -0.6        0.16 ± 83%  perf-profile.children.cycles-pp.__update_load_avg_se
      0.72 ± 50%      -0.6        0.11 ±206%  perf-profile.children.cycles-pp.finish_task_switch
      0.76 ± 12%      -0.6        0.15 ±106%  perf-profile.children.cycles-pp.__switch_to
      0.75 ±  9%      -0.6        0.15 ± 98%  perf-profile.children.cycles-pp.ttwu_do_wakeup
      0.80 ± 90%      -0.6        0.21 ±244%  perf-profile.children.cycles-pp.sched_ttwu_pending
      0.64 ± 15%      -0.6        0.06 ±211%  perf-profile.children.cycles-pp.pick_next_entity
      0.85 ± 17%      -0.6        0.28 ± 17%  perf-profile.children.cycles-pp.fsnotify
      0.69 ±  9%      -0.6        0.13 ± 96%  perf-profile.children.cycles-pp.check_preempt_curr
      0.85 ± 15%      -0.6        0.29 ± 21%  perf-profile.children.cycles-pp.sock_recvmsg
      0.67 ± 21%      -0.5        0.13 ±139%  perf-profile.children.cycles-pp.cpuacct_charge
      0.62 ± 10%      -0.5        0.10 ±130%  perf-profile.children.cycles-pp.account_entity_dequeue
      0.59 ± 15%      -0.5        0.07 ±159%  perf-profile.children.cycles-pp.put_prev_entity
      0.63 ± 12%      -0.5        0.11 ± 93%  perf-profile.children.cycles-pp.__enqueue_entity
      0.77 ± 15%      -0.5        0.26 ± 20%  perf-profile.children.cycles-pp.security_socket_recvmsg
      0.54 ± 15%      -0.5        0.04 ±244%  perf-profile.children.cycles-pp.copy_fpregs_to_fpstate
      0.55 ±  5%      -0.5        0.05 ± 71%  perf-profile.children.cycles-pp.__ksize
      0.81 ± 13%      -0.5        0.31 ± 16%  perf-profile.children.cycles-pp.copyin
      0.75 ± 12%      -0.5        0.27 ± 17%  perf-profile.children.cycles-pp.security_socket_sendmsg
      0.69 ± 12%      -0.5        0.23 ± 21%  perf-profile.children.cycles-pp.__virt_addr_valid
      0.85 ±  6%      -0.5        0.39 ± 43%  perf-profile.children.cycles-pp.mutex_lock
      0.54 ± 10%      -0.4        0.09 ±104%  perf-profile.children.cycles-pp.check_preempt_wakeup
      1.69 ± 10%      -0.4        1.26 ± 16%  perf-profile.children.cycles-pp.sock_wfree
      0.70 ± 14%      -0.4        0.29 ± 14%  perf-profile.children.cycles-pp.__check_heap_object
      0.45 ± 10%      -0.4        0.05 ±207%  perf-profile.children.cycles-pp.___perf_sw_event
      0.47 ±  9%      -0.4        0.08 ±112%  perf-profile.children.cycles-pp.update_min_vruntime
      0.45 ± 12%      -0.4        0.06 ±173%  perf-profile.children.cycles-pp.sched_clock_cpu
      0.48 ±  7%      -0.4        0.11 ± 60%  perf-profile.children.cycles-pp.__list_del_entry_valid
      0.61 ± 14%      -0.4        0.25 ± 14%  perf-profile.children.cycles-pp.__might_sleep
      0.42 ± 12%      -0.4        0.06 ±169%  perf-profile.children.cycles-pp.sched_clock
      0.44 ± 14%      -0.4        0.08 ± 93%  perf-profile.children.cycles-pp.__calc_delta
      0.40 ± 12%      -0.3        0.05 ±197%  perf-profile.children.cycles-pp.native_sched_clock
      0.50 ± 12%      -0.3        0.16 ± 25%  perf-profile.children.cycles-pp.fsnotify_parent
      0.51 ±  9%      -0.3        0.18 ± 27%  perf-profile.children.cycles-pp.__might_fault
      0.76 ± 13%      -0.3        0.44 ± 22%  perf-profile.children.cycles-pp.entry_SYSCALL_64
      0.37 ± 11%      -0.3        0.05 ±207%  perf-profile.children.cycles-pp.perf_tp_event
      0.33 ± 11%      -0.3        0.03 ±244%  perf-profile.children.cycles-pp.account_entity_enqueue
      0.36 ± 73%      -0.3        0.06 ±212%  perf-profile.children.cycles-pp.set_task_cpu
      0.49 ±  9%      -0.3        0.19 ± 21%  perf-profile.children.cycles-pp._cond_resched
     42.70 ±  4%      -0.3       42.40 ±  6%  perf-profile.children.cycles-pp.vfs_write
      0.33 ± 16%      -0.3        0.03 ±188%  perf-profile.children.cycles-pp.cpumask_next_wrap
      0.38 ± 27%      -0.3        0.11 ±109%  perf-profile.children.cycles-pp.update_cfs_rq_h_load
      0.31 ± 31%      -0.3        0.05 ±244%  perf-profile.children.cycles-pp.cpus_share_cache
      0.28 ± 14%      -0.3        0.02 ±244%  perf-profile.children.cycles-pp.clear_buddies
      0.27 ± 14%      -0.2        0.02 ±244%  perf-profile.children.cycles-pp._find_next_bit
      0.35 ±  9%      -0.2        0.11 ± 18%  perf-profile.children.cycles-pp.syscall_enter_from_user_mode
      0.24 ± 12%      -0.2        0.03 ±190%  perf-profile.children.cycles-pp.perf_trace_sched_stat_runtime
      0.22 ± 14%      -0.2        0.01 ±244%  perf-profile.children.cycles-pp.set_next_buddy
      0.37 ± 16%      -0.2        0.17 ± 14%  perf-profile.children.cycles-pp.wait_for_unix_gc
      0.22 ± 16%      -0.2        0.02 ±244%  perf-profile.children.cycles-pp.__wrgsbase_inactive
      0.22 ± 21%      -0.2        0.02 ±244%  perf-profile.children.cycles-pp.perf_trace_sched_switch
      0.22 ± 12%      -0.2        0.04 ±162%  perf-profile.children.cycles-pp.finish_wait
      0.25 ± 15%      -0.2        0.08 ± 24%  perf-profile.children.cycles-pp.__x86_indirect_thunk_rax
      0.22 ± 55%      -0.2        0.04 ±244%  perf-profile.children.cycles-pp.ttwu_queue_wakelist
      0.19 ±  9%      -0.2        0.02 ±244%  perf-profile.children.cycles-pp.rb_erase
      0.20 ± 55%      -0.2        0.04 ±244%  perf-profile.children.cycles-pp.migrate_task_rq_fair
      0.99 ± 16%      -0.2        0.83 ± 32%  perf-profile.children.cycles-pp.skb_queue_tail
      0.17 ± 12%      -0.2        0.01 ±244%  perf-profile.children.cycles-pp.cpumask_next
      0.16 ±  7%      -0.1        0.01 ±244%  perf-profile.children.cycles-pp.__list_add_valid
      0.24 ± 13%      -0.1        0.10 ± 18%  perf-profile.children.cycles-pp.security_socket_getpeersec_dgram
      0.49 ± 13%      -0.1        0.35 ±  7%  perf-profile.children.cycles-pp.skb_release_data
      0.19 ± 90%      -0.1        0.05 ±244%  perf-profile.children.cycles-pp.flush_smp_call_function_queue
      0.15 ± 12%      -0.1        0.02 ±244%  perf-profile.children.cycles-pp.resched_curr
      0.15 ± 15%      -0.1        0.02 ±244%  perf-profile.children.cycles-pp.rb_insert_color
      0.13 ± 19%      -0.1        0.00        perf-profile.children.cycles-pp.memcg_kmem_put_cache
      0.14 ± 17%      -0.1        0.01 ±244%  perf-profile.children.cycles-pp.__cgroup_account_cputime
      0.14 ± 21%      -0.1        0.01 ±244%  perf-profile.children.cycles-pp.perf_trace_buf_alloc
      0.19 ± 18%      -0.1        0.07 ± 19%  perf-profile.children.cycles-pp.rcu_all_qs
      0.14 ± 20%      -0.1        0.02 ±115%  perf-profile.children.cycles-pp.apparmor_file_permission
      0.22 ± 14%      -0.1        0.10 ± 12%  perf-profile.children.cycles-pp.aa_file_perm
      0.13 ± 17%      -0.1        0.01 ±244%  perf-profile.children.cycles-pp.__rdgsbase_inactive
      0.13 ± 31%      -0.1        0.02 ±244%  perf-profile.children.cycles-pp.native_irq_return_iret
      0.19 ± 46%      -0.1        0.08 ± 19%  perf-profile.children.cycles-pp.asm_sysvec_reschedule_ipi
      0.10 ± 16%      -0.1        0.01 ±244%  perf-profile.children.cycles-pp.apparmor_socket_recvmsg
      0.44 ±  7%      -0.1        0.34 ± 15%  perf-profile.children.cycles-pp.unix_write_space
      0.11 ± 22%      -0.1        0.01 ±244%  perf-profile.children.cycles-pp.wakeup_preempt_entity
      0.68 ±  5%      -0.1        0.59 ±  8%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      0.14 ± 12%      -0.1        0.04 ± 65%  perf-profile.children.cycles-pp.check_stack_object
      0.10 ±  8%      -0.1        0.01 ±244%  perf-profile.children.cycles-pp.rb_next
      0.09 ± 17%      -0.1        0.00        perf-profile.children.cycles-pp.kmalloc_slab
      0.10 ± 19%      -0.1        0.01 ±244%  perf-profile.children.cycles-pp.__x64_sys_write
      0.60 ±  4%      -0.1        0.51 ±  8%  perf-profile.children.cycles-pp.hrtimer_interrupt
      0.61 ±  4%      -0.1        0.52 ±  8%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      0.09 ± 20%      -0.1        0.00        perf-profile.children.cycles-pp.__x64_sys_read
      0.09 ± 14%      -0.1        0.00        perf-profile.children.cycles-pp.put_pid
      0.09 ± 15%      -0.1        0.01 ±244%  perf-profile.children.cycles-pp.apparmor_socket_sendmsg
      0.75 ±  5%      -0.1        0.67 ±  8%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
      0.13 ± 12%      -0.1        0.04 ± 63%  perf-profile.children.cycles-pp.apparmor_socket_getpeersec_dgram
      0.08 ± 15%      -0.1        0.00        perf-profile.children.cycles-pp.iov_iter_init
      0.09 ± 14%      -0.1        0.01 ±244%  perf-profile.children.cycles-pp.place_entity
      0.07 ±  6%      -0.1        0.00        perf-profile.children.cycles-pp.maybe_add_creds
      0.08 ± 17%      -0.1        0.01 ±244%  perf-profile.children.cycles-pp.unix_scm_to_skb
      0.09 ± 21%      -0.1        0.01 ±244%  perf-profile.children.cycles-pp.get_xsave_addr
      0.11 ± 32%      -0.1        0.04 ± 71%  perf-profile.children.cycles-pp.preempt_schedule_common
      0.07 ±  8%      -0.1        0.00        perf-profile.children.cycles-pp.tracing_generic_entry_update
      0.07 ± 20%      -0.1        0.00        perf-profile.children.cycles-pp.check_cfs_rq_runtime
      0.07 ± 12%      -0.1        0.01 ±244%  perf-profile.children.cycles-pp.switch_ldt
      0.07 ± 14%      -0.1        0.00        perf-profile.children.cycles-pp.rw_verify_area
      0.09 ± 94%      -0.1        0.03 ±244%  perf-profile.children.cycles-pp.__smp_call_single_queue
      0.09 ± 94%      -0.1        0.03 ±244%  perf-profile.children.cycles-pp.llist_add_batch
      0.15 ± 12%      -0.1        0.10 ± 18%  perf-profile.children.cycles-pp.ktime_get
      0.09 ±141%      -0.1        0.04 ±244%  perf-profile.children.cycles-pp.poll_idle
      0.08 ± 98%      -0.1        0.02 ±244%  perf-profile.children.cycles-pp.llist_reverse_order
      0.06 ± 13%      -0.1        0.00        perf-profile.children.cycles-pp.find_next_bit
      0.06 ± 47%      -0.1        0.00        perf-profile.children.cycles-pp.perf_swevent_get_recursion_context
      0.05 ± 47%      -0.0        0.00        perf-profile.children.cycles-pp.should_failslab
      0.05 ± 46%      -0.0        0.00        perf-profile.children.cycles-pp.rcu_note_context_switch
      0.14 ± 13%      -0.0        0.09 ± 22%  perf-profile.children.cycles-pp.clockevents_program_event
      0.05 ±145%      -0.0        0.01 ±244%  perf-profile.children.cycles-pp.handle_mm_fault
      0.05 ±145%      -0.0        0.01 ±244%  perf-profile.children.cycles-pp.__handle_mm_fault
      0.05 ±144%      -0.0        0.02 ±161%  perf-profile.children.cycles-pp.asm_exc_page_fault
      0.05 ±103%      -0.0        0.01 ±244%  perf-profile.children.cycles-pp.remove_entity_load_avg
      0.09 ±  8%      -0.0        0.05 ±  6%  perf-profile.children.cycles-pp.ktime_get_update_offsets_now
      0.03 ± 70%      -0.0        0.00        perf-profile.children.cycles-pp.cgroup_rstat_updated
      0.63 ±  7%      -0.0        0.60 ± 21%  perf-profile.children.cycles-pp.skb_unlink
      0.05 ±144%      -0.0        0.02 ±161%  perf-profile.children.cycles-pp.exc_page_fault
      0.05 ±143%      -0.0        0.02 ±161%  perf-profile.children.cycles-pp.do_user_addr_fault
      0.04 ±108%      -0.0        0.02 ±159%  perf-profile.children.cycles-pp.irqentry_exit_to_user_mode
      0.03 ±100%      -0.0        0.00        perf-profile.children.cycles-pp.default_send_IPI_single_phys
      0.03 ±152%      -0.0        0.00        perf-profile.children.cycles-pp.migrate_misplaced_page
      0.03 ±152%      -0.0        0.00        perf-profile.children.cycles-pp.migrate_pages
      0.03 ±152%      -0.0        0.00        perf-profile.children.cycles-pp.rmap_walk_anon
      0.02 ±144%      -0.0        0.00        perf-profile.children.cycles-pp.__do_sys_wait4
      0.02 ±144%      -0.0        0.00        perf-profile.children.cycles-pp.kernel_wait4
      0.02 ±144%      -0.0        0.00        perf-profile.children.cycles-pp.do_wait
      0.07 ± 18%      -0.0        0.05 ±  8%  perf-profile.children.cycles-pp.irq_exit_rcu
      0.02 ±141%      -0.0        0.00        perf-profile.children.cycles-pp.__x64_sys_exit_group
      0.02 ±141%      -0.0        0.00        perf-profile.children.cycles-pp.do_group_exit
      0.02 ±141%      -0.0        0.00        perf-profile.children.cycles-pp.do_exit
      0.02 ±141%      -0.0        0.00        perf-profile.children.cycles-pp.skb_put
      0.03 ±143%      -0.0        0.01 ±244%  perf-profile.children.cycles-pp.menu_select
      0.29 ±  9%      -0.0        0.28 ±  9%  perf-profile.children.cycles-pp.tick_sched_timer
      0.35 ±  7%      -0.0        0.34 ±  9%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      0.02 ±144%      -0.0        0.01 ±244%  perf-profile.children.cycles-pp.do_softirq_own_stack
      0.01 ±223%      -0.0        0.00        perf-profile.children.cycles-pp.page_vma_mapped_walk
      0.01 ±223%      -0.0        0.00        perf-profile.children.cycles-pp.remove_migration_ptes
      0.01 ±223%      -0.0        0.00        perf-profile.children.cycles-pp.allocate_slab
      0.01 ±223%      -0.0        0.00        perf-profile.children.cycles-pp.update_irq_load_avg
      0.01 ±223%      -0.0        0.00        perf-profile.children.cycles-pp.wait_consider_task
      0.01 ±223%      -0.0        0.00        perf-profile.children.cycles-pp.flush_smp_call_function_from_idle
      0.01 ±223%      -0.0        0.00        perf-profile.children.cycles-pp.remove_migration_pte
      0.02 ±144%      -0.0        0.01 ±158%  perf-profile.children.cycles-pp.__softirqentry_text_start
      0.01 ±223%      -0.0        0.01 ±244%  perf-profile.children.cycles-pp.irqtime_account_irq
      0.25 ± 11%      +0.0        0.25 ± 10%  perf-profile.children.cycles-pp.tick_sched_handle
      0.25 ± 12%      +0.0        0.25 ± 10%  perf-profile.children.cycles-pp.update_process_times
      0.06 ±143%      +0.0        0.07 ± 48%  perf-profile.children.cycles-pp.schedule_idle
      0.19 ± 14%      +0.0        0.21 ± 11%  perf-profile.children.cycles-pp.scheduler_tick
      0.15 ± 18%      +0.0        0.17 ± 13%  perf-profile.children.cycles-pp.task_tick_fair
      0.00            +0.0        0.04 ± 66%  perf-profile.children.cycles-pp.mem_cgroup_from_task
      0.00            +0.0        0.05 ± 93%  perf-profile.children.cycles-pp.perf_session__deliver_event
      0.00            +0.1        0.05 ± 93%  perf-profile.children.cycles-pp.perf_session__process_user_event
      0.00            +0.1        0.05 ± 93%  perf-profile.children.cycles-pp.__ordered_events__flush
      0.08 ±144%      +0.1        0.15 ± 53%  perf-profile.children.cycles-pp.queue_event
      0.08 ±144%      +0.1        0.15 ± 53%  perf-profile.children.cycles-pp.ordered_events__queue
      0.10 ±129%      +0.1        0.20 ± 49%  perf-profile.children.cycles-pp.process_simple
      0.10 ±130%      +0.1        0.21 ± 49%  perf-profile.children.cycles-pp.cmd_record
      0.10 ±130%      +0.1        0.21 ± 49%  perf-profile.children.cycles-pp.record__finish_output
      0.10 ±130%      +0.1        0.21 ± 49%  perf-profile.children.cycles-pp.perf_session__process_events
      0.69 ±148%      +0.1        0.80 ± 57%  perf-profile.children.cycles-pp.start_secondary
      0.56 ±149%      +0.1        0.69 ± 57%  perf-profile.children.cycles-pp.cpuidle_enter_state
      0.56 ±149%      +0.1        0.69 ± 57%  perf-profile.children.cycles-pp.cpuidle_enter
      0.69 ±148%      +0.1        0.82 ± 57%  perf-profile.children.cycles-pp.secondary_startup_64
      0.69 ±148%      +0.1        0.82 ± 57%  perf-profile.children.cycles-pp.cpu_startup_entry
      0.69 ±148%      +0.1        0.82 ± 57%  perf-profile.children.cycles-pp.do_idle
      0.45 ±153%      +0.2        0.63 ± 49%  perf-profile.children.cycles-pp.intel_idle
      0.00            +0.2        0.23 ± 38%  perf-profile.children.cycles-pp.try_charge
      0.35 ± 12%      +0.3        0.60 ± 36%  perf-profile.children.cycles-pp.mutex_unlock
     40.81 ±  4%      +0.9       41.72 ±  6%  perf-profile.children.cycles-pp.new_sync_write
     40.37 ±  4%      +1.1       41.51 ±  6%  perf-profile.children.cycles-pp.sock_write_iter
     39.73 ±  4%      +1.6       41.30 ±  6%  perf-profile.children.cycles-pp.sock_sendmsg
     38.88 ±  4%      +2.1       40.99 ±  7%  perf-profile.children.cycles-pp.unix_stream_sendmsg
      0.00            +2.2        2.24 ± 35%  perf-profile.children.cycles-pp.get_obj_cgroup_from_current
      0.00            +2.4        2.35 ± 37%  perf-profile.children.cycles-pp.__mod_memcg_state
      0.00            +2.5        2.53 ± 36%  perf-profile.children.cycles-pp.__mod_memcg_lruvec_state
     94.64            +2.8       97.41        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.00            +4.5        4.55 ± 59%  perf-profile.children.cycles-pp.propagate_protected_usage
      0.00            +7.4        7.37 ± 51%  perf-profile.children.cycles-pp.__memcg_kmem_uncharge
      0.00            +8.2        8.20 ± 61%  perf-profile.children.cycles-pp.page_counter_try_charge
      0.00            +8.3        8.27 ± 61%  perf-profile.children.cycles-pp.__memcg_kmem_charge
     83.04 ±  5%      +9.7       92.72 ±  5%  perf-profile.children.cycles-pp.do_syscall_64
      4.46 ± 29%     +10.2       14.66 ± 17%  perf-profile.children.cycles-pp.kmem_cache_alloc_node
      0.00           +10.3       10.25 ± 43%  perf-profile.children.cycles-pp.obj_cgroup_charge
     38.78 ±  7%     +11.0       49.73 ±  5%  perf-profile.children.cycles-pp.ksys_read
     37.97 ±  7%     +11.5       49.48 ±  5%  perf-profile.children.cycles-pp.vfs_read
      0.00           +11.5       11.55 ± 38%  perf-profile.children.cycles-pp.page_counter_cancel
      0.00           +11.8       11.84 ± 39%  perf-profile.children.cycles-pp.page_counter_uncharge
      4.67 ± 33%     +12.0       16.64 ± 13%  perf-profile.children.cycles-pp.__kmalloc_reserve
      4.58 ± 33%     +12.0       16.62 ± 13%  perf-profile.children.cycles-pp.__kmalloc_node_track_caller
     35.61 ±  7%     +13.1       48.69 ±  6%  perf-profile.children.cycles-pp.new_sync_read
     35.01 ±  7%     +13.5       48.51 ±  6%  perf-profile.children.cycles-pp.sock_read_iter
     33.44 ±  7%     +14.6       47.99 ±  6%  perf-profile.children.cycles-pp.unix_stream_recvmsg
     33.17 ±  7%     +14.7       47.91 ±  6%  perf-profile.children.cycles-pp.unix_stream_read_generic
      3.04 ± 21%     +15.1       18.17 ± 17%  perf-profile.children.cycles-pp.kmem_cache_free
      5.78 ± 13%     +15.4       21.22 ± 12%  perf-profile.children.cycles-pp.consume_skb
      0.00           +15.6       15.59 ± 24%  perf-profile.children.cycles-pp.drain_obj_stock
      0.28 ± 10%     +18.2       18.44 ± 16%  perf-profile.children.cycles-pp.kfree
      0.00           +18.7       18.69 ± 19%  perf-profile.children.cycles-pp.refill_obj_stock
     12.80 ± 20%     +20.3       33.13 ± 13%  perf-profile.children.cycles-pp.sock_alloc_send_pskb
     10.40 ± 28%     +21.3       31.68 ± 14%  perf-profile.children.cycles-pp.alloc_skb_with_frags
     10.27 ± 28%     +21.4       31.62 ± 14%  perf-profile.children.cycles-pp.__alloc_skb
      3.24 ±149%     +29.2       32.49 ± 63%  perf-profile.children.cycles-pp.__libc_write
      2.81 ±149%     +35.3       38.11 ± 63%  perf-profile.children.cycles-pp.__libc_read
      8.62 ± 10%      -7.6        0.99 ± 72%  perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
      4.98 ± 95%      -1.6        3.40 ±155%  perf-profile.self.cycles-pp.syscall_exit_to_user_mode
      1.72 ± 45%      -1.4        0.28 ± 86%  perf-profile.self.cycles-pp.update_cfs_group
      1.86 ±  9%      -1.4        0.43 ± 90%  perf-profile.self.cycles-pp.__schedule
      1.70 ± 19%      -1.4        0.31 ± 94%  perf-profile.self.cycles-pp.update_load_avg
      1.59 ± 11%      -1.3        0.29 ± 86%  perf-profile.self.cycles-pp.update_curr
      3.90 ± 10%      -1.3        2.62 ± 25%  perf-profile.self.cycles-pp._raw_spin_lock
      2.55 ±  8%      -1.3        1.27 ±  7%  perf-profile.self.cycles-pp.copy_user_enhanced_fast_string
      1.48 ± 14%      -1.3        0.21 ±130%  perf-profile.self.cycles-pp.load_new_mm_cr3
      2.23 ±  7%      -1.3        0.96 ± 36%  perf-profile.self.cycles-pp.unix_stream_read_generic
      1.57 ± 11%      -1.3        0.29 ±112%  perf-profile.self.cycles-pp.switch_fpu_return
      2.96 ± 13%      -1.2        1.75 ± 41%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      1.38 ± 20%      -1.1        0.29 ±116%  perf-profile.self.cycles-pp.available_idle_cpu
      1.01 ± 14%      -1.0        0.00        perf-profile.self.cycles-pp.memcg_kmem_get_cache
      1.07 ± 11%      -0.9        0.19 ±113%  perf-profile.self.cycles-pp.__switch_to_asm
      1.57 ±  9%      -0.9        0.70 ± 20%  perf-profile.self.cycles-pp.unix_stream_sendmsg
      1.92 ± 11%      -0.9        1.07 ± 11%  perf-profile.self.cycles-pp.skb_set_owner_w
      1.16 ±  8%      -0.9        0.30 ± 45%  perf-profile.self.cycles-pp._raw_spin_unlock_irqrestore
      1.50 ± 11%      -0.8        0.66 ±  9%  perf-profile.self.cycles-pp.__check_object_size
      0.97 ± 16%      -0.8        0.18 ± 96%  perf-profile.self.cycles-pp.select_idle_sibling
      1.23 ± 15%      -0.8        0.47 ± 15%  perf-profile.self.cycles-pp.syscall_return_via_sysret
      2.15 ±  9%      -0.7        1.42 ± 24%  perf-profile.self.cycles-pp.__slab_free
      1.03 ± 13%      -0.7        0.35 ± 23%  perf-profile.self.cycles-pp.___might_sleep
      0.87 ± 13%      -0.7        0.19 ±106%  perf-profile.self.cycles-pp.__update_load_avg_cfs_rq
      0.97 ± 11%      -0.6        0.32 ± 24%  perf-profile.self.cycles-pp.common_file_perm
      0.97 ±  9%      -0.6        0.33 ± 29%  perf-profile.self.cycles-pp.__fget_light
      0.78 ±  7%      -0.6        0.16 ± 83%  perf-profile.self.cycles-pp.__update_load_avg_se
      0.76 ± 17%      -0.6        0.17 ±122%  perf-profile.self.cycles-pp.select_task_rq_fair
      0.80 ±  9%      -0.6        0.21 ± 38%  perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      1.03 ± 23%      -0.6        0.46 ± 15%  perf-profile.self.cycles-pp.___slab_alloc
      0.83 ± 17%      -0.6        0.27 ± 16%  perf-profile.self.cycles-pp.fsnotify
      0.67 ± 21%      -0.5        0.13 ±139%  perf-profile.self.cycles-pp.cpuacct_charge
      0.67 ± 13%      -0.5        0.14 ± 94%  perf-profile.self.cycles-pp.update_rq_clock
      0.66 ± 14%      -0.5        0.13 ±116%  perf-profile.self.cycles-pp.try_to_wake_up
      0.65 ± 14%      -0.5        0.13 ± 99%  perf-profile.self.cycles-pp.__switch_to
      0.62 ± 12%      -0.5        0.11 ± 91%  perf-profile.self.cycles-pp.__enqueue_entity
      0.79 ±  6%      -0.5        0.29 ± 91%  perf-profile.self.cycles-pp.switch_mm_irqs_off
      0.54 ±  5%      -0.5        0.04 ±115%  perf-profile.self.cycles-pp.__ksize
      0.54 ± 16%      -0.5        0.04 ±244%  perf-profile.self.cycles-pp.copy_fpregs_to_fpstate
      0.71 ± 14%      -0.5        0.22 ± 23%  perf-profile.self.cycles-pp.sock_read_iter
      0.55 ± 14%      -0.5        0.10 ±116%  perf-profile.self.cycles-pp.enqueue_task_fair
      0.51 ± 12%      -0.5        0.06 ±211%  perf-profile.self.cycles-pp.account_entity_dequeue
      0.66 ±  8%      -0.4        0.21 ± 42%  perf-profile.self.cycles-pp.vfs_read
      0.72 ± 15%      -0.4        0.27 ± 14%  perf-profile.self.cycles-pp.entry_SYSCALL_64
      0.66 ± 12%      -0.4        0.22 ± 19%  perf-profile.self.cycles-pp.__virt_addr_valid
      0.55 ±  8%      -0.4        0.12 ± 80%  perf-profile.self.cycles-pp.pick_next_task_fair
      0.64 ± 16%      -0.4        0.22 ± 16%  perf-profile.self.cycles-pp.aa_sk_perm
      0.63 ± 13%      -0.4        0.21 ± 19%  perf-profile.self.cycles-pp.sock_write_iter
      0.68 ± 14%      -0.4        0.28 ± 13%  perf-profile.self.cycles-pp.__check_heap_object
      0.46 ±  9%      -0.4        0.07 ±127%  perf-profile.self.cycles-pp.update_min_vruntime
      0.53 ±  8%      -0.4        0.16 ± 38%  perf-profile.self.cycles-pp.new_sync_read
      0.51 ± 10%      -0.4        0.14 ± 95%  perf-profile.self.cycles-pp.prepare_to_wait
      0.40 ± 10%      -0.4        0.04 ±244%  perf-profile.self.cycles-pp.___perf_sw_event
      0.59 ± 10%      -0.4        0.24 ± 11%  perf-profile.self.cycles-pp.vfs_write
      0.55 ± 15%      -0.4        0.20 ± 21%  perf-profile.self.cycles-pp.__might_sleep
      0.43 ± 13%      -0.4        0.08 ± 93%  perf-profile.self.cycles-pp.__calc_delta
      0.54 ± 39%      -0.3        0.20 ± 16%  perf-profile.self.cycles-pp.get_partial_node
      0.44 ±  7%      -0.3        0.10 ± 55%  perf-profile.self.cycles-pp.__list_del_entry_valid
      0.39 ± 11%      -0.3        0.05 ±196%  perf-profile.self.cycles-pp.native_sched_clock
      0.58 ± 16%      -0.3        0.25 ± 27%  perf-profile.self.cycles-pp.__alloc_skb
      0.38 ± 14%      -0.3        0.05 ±206%  perf-profile.self.cycles-pp.dequeue_task_fair
      0.47 ± 14%      -0.3        0.16 ± 32%  perf-profile.self.cycles-pp.exit_to_user_mode_prepare
      0.44 ± 39%      -0.3        0.13 ± 20%  perf-profile.self.cycles-pp.unfreeze_partials
      0.47 ± 11%      -0.3        0.16 ± 23%  perf-profile.self.cycles-pp.fsnotify_parent
      0.34 ± 13%      -0.3        0.03 ±244%  perf-profile.self.cycles-pp.reweight_entity
      0.39 ± 19%      -0.3        0.09 ±131%  perf-profile.self.cycles-pp.perf_trace_sched_wakeup_template
      1.18 ± 12%      -0.3        0.89 ± 15%  perf-profile.self.cycles-pp.sock_wfree
      0.38 ± 27%      -0.3        0.11 ±111%  perf-profile.self.cycles-pp.update_cfs_rq_h_load
      0.29 ± 14%      -0.3        0.03 ±244%  perf-profile.self.cycles-pp.account_entity_enqueue
      0.30 ± 31%      -0.3        0.05 ±244%  perf-profile.self.cycles-pp.cpus_share_cache
      0.27 ± 15%      -0.2        0.02 ±244%  perf-profile.self.cycles-pp.enqueue_entity
      0.27 ± 15%      -0.2        0.02 ±244%  perf-profile.self.cycles-pp.clear_buddies
      0.27 ± 14%      -0.2        0.02 ±244%  perf-profile.self.cycles-pp._find_next_bit
      0.28 ± 15%      -0.2        0.04 ±244%  perf-profile.self.cycles-pp.perf_tp_event
      0.27 ± 13%      -0.2        0.02 ±244%  perf-profile.self.cycles-pp.pick_next_entity
      0.27 ±  8%      -0.2        0.03 ±244%  perf-profile.self.cycles-pp.schedule_timeout
      0.53 ±  9%      -0.2        0.29 ± 49%  perf-profile.self.cycles-pp.mutex_lock
      0.27 ± 20%      -0.2        0.03 ±244%  perf-profile.self.cycles-pp.__wake_up_common
      0.33 ± 11%      -0.2        0.10 ± 31%  perf-profile.self.cycles-pp._copy_to_iter
      0.32 ± 11%      -0.2        0.11 ± 12%  perf-profile.self.cycles-pp.syscall_enter_from_user_mode
      0.39 ± 15%      -0.2        0.17 ± 10%  perf-profile.self.cycles-pp.new_sync_write
      0.23 ± 13%      -0.2        0.02 ±244%  perf-profile.self.cycles-pp.perf_trace_sched_stat_runtime
      0.23 ± 13%      -0.2        0.02 ±244%  perf-profile.self.cycles-pp.check_preempt_wakeup
      0.22 ± 13%      -0.2        0.02 ±244%  perf-profile.self.cycles-pp.schedule
      0.30 ±  6%      -0.2        0.09 ± 20%  perf-profile.self.cycles-pp.unix_destruct_scm
      0.23 ± 20%      -0.2        0.02 ±244%  perf-profile.self.cycles-pp.finish_task_switch
      0.22 ± 11%      -0.2        0.02 ±244%  perf-profile.self.cycles-pp.set_next_entity
      0.21 ± 13%      -0.2        0.01 ±244%  perf-profile.self.cycles-pp.set_next_buddy
      0.22 ± 16%      -0.2        0.02 ±244%  perf-profile.self.cycles-pp.__wrgsbase_inactive
      0.21 ± 21%      -0.2        0.02 ±244%  perf-profile.self.cycles-pp.perf_trace_sched_switch
      0.23 ± 13%      -0.2        0.04 ± 94%  perf-profile.self.cycles-pp.do_syscall_64
      0.23 ± 13%      -0.2        0.05 ± 91%  perf-profile.self.cycles-pp.ksys_read
      0.25 ± 16%      -0.2        0.08 ± 29%  perf-profile.self.cycles-pp.unix_stream_recvmsg
      0.85 ± 15%      -0.2        0.67 ± 33%  perf-profile.self.cycles-pp.sock_def_readable
      0.26 ± 16%      -0.2        0.09 ± 18%  perf-profile.self.cycles-pp.security_file_permission
      0.18 ±  9%      -0.2        0.02 ±244%  perf-profile.self.cycles-pp.rb_erase
      0.27 ± 16%      -0.2        0.11 ± 23%  perf-profile.self.cycles-pp._copy_from_iter
      0.36 ± 10%      -0.1        0.22 ± 21%  perf-profile.self.cycles-pp.unix_write_space
      0.15 ± 16%      -0.1        0.01 ±244%  perf-profile.self.cycles-pp.cpumask_next_wrap
      0.15 ±  7%      -0.1        0.01 ±244%  perf-profile.self.cycles-pp.__list_add_valid
      0.15 ± 13%      -0.1        0.02 ±244%  perf-profile.self.cycles-pp.check_preempt_curr
      0.17 ±  7%      -0.1        0.04 ±109%  perf-profile.self.cycles-pp.__might_fault
      0.15 ± 12%      -0.1        0.02 ±244%  perf-profile.self.cycles-pp.resched_curr
      0.15 ± 16%      -0.1        0.02 ±244%  perf-profile.self.cycles-pp.rb_insert_color
      0.13 ± 18%      -0.1        0.00        perf-profile.self.cycles-pp.apparmor_file_permission
      0.16 ± 15%      -0.1        0.03 ± 90%  perf-profile.self.cycles-pp.__x86_indirect_thunk_rax
      0.47 ± 11%      -0.1        0.34 ±  8%  perf-profile.self.cycles-pp.skb_release_data
      0.12 ± 18%      -0.1        0.00        perf-profile.self.cycles-pp.memcg_kmem_put_cache
      0.18 ± 14%      -0.1        0.06 ± 18%  perf-profile.self.cycles-pp._cond_resched
      0.13 ± 19%      -0.1        0.01 ±244%  perf-profile.self.cycles-pp.put_prev_entity
      0.13 ±126%      -0.1        0.01 ±244%  perf-profile.self.cycles-pp.set_task_cpu
      0.12 ± 17%      -0.1        0.01 ±244%  perf-profile.self.cycles-pp.__rdgsbase_inactive
      0.13 ± 31%      -0.1        0.02 ±244%  perf-profile.self.cycles-pp.native_irq_return_iret
      0.33 ±  7%      -0.1        0.21 ± 25%  perf-profile.self.cycles-pp.consume_skb
      0.20 ± 15%      -0.1        0.10 ± 10%  perf-profile.self.cycles-pp.aa_file_perm
      0.12 ± 15%      -0.1        0.02 ±244%  perf-profile.self.cycles-pp.ttwu_do_activate
      0.12 ± 18%      -0.1        0.02 ±115%  perf-profile.self.cycles-pp.__skb_datagram_iter
      0.11 ± 12%      -0.1        0.01 ±244%  perf-profile.self.cycles-pp.security_socket_getpeersec_dgram
      0.12 ± 56%      -0.1        0.02 ±244%  perf-profile.self.cycles-pp.migrate_task_rq_fair
      0.14 ± 18%      -0.1        0.04 ± 65%  perf-profile.self.cycles-pp.rcu_all_qs
      0.15 ± 15%      -0.1        0.05 ± 67%  perf-profile.self.cycles-pp.skb_copy_datagram_from_iter
      0.17 ± 11%      -0.1        0.07 ± 12%  perf-profile.self.cycles-pp.ksys_write
      0.09 ± 17%      -0.1        0.00        perf-profile.self.cycles-pp.apparmor_socket_recvmsg
      0.09 ± 27%      -0.1        0.00        perf-profile.self.cycles-pp.__slab_alloc
      0.09 ± 14%      -0.1        0.00        perf-profile.self.cycles-pp.sock_sendmsg
      0.10 ± 10%      -0.1        0.01 ±244%  perf-profile.self.cycles-pp.rb_next
      0.09 ± 15%      -0.1        0.00        perf-profile.self.cycles-pp.__kmalloc_reserve
      0.10 ± 22%      -0.1        0.01 ±244%  perf-profile.self.cycles-pp.wakeup_preempt_entity
      0.10 ± 16%      -0.1        0.01 ±244%  perf-profile.self.cycles-pp.security_socket_recvmsg
      0.20 ±  8%      -0.1        0.11 ± 16%  perf-profile.self.cycles-pp.sock_alloc_send_pskb
      0.12 ± 13%      -0.1        0.03 ± 87%  perf-profile.self.cycles-pp.check_stack_object
      0.09 ± 27%      -0.1        0.00        perf-profile.self.cycles-pp.__cgroup_account_cputime
      0.09 ± 15%      -0.1        0.00        perf-profile.self.cycles-pp.kmalloc_slab
      0.09 ± 11%      -0.1        0.00        perf-profile.self.cycles-pp.dequeue_entity
      0.09 ± 18%      -0.1        0.01 ±244%  perf-profile.self.cycles-pp.__x64_sys_write
      0.08 ± 14%      -0.1        0.00        perf-profile.self.cycles-pp.apparmor_socket_sendmsg
      0.09 ± 18%      -0.1        0.01 ±244%  perf-profile.self.cycles-pp.sock_recvmsg
      0.08 ± 19%      -0.1        0.00        perf-profile.self.cycles-pp.__x64_sys_read
      0.09 ± 17%      -0.1        0.01 ±244%  perf-profile.self.cycles-pp.ttwu_queue_wakelist
      0.09 ± 12%      -0.1        0.01 ±244%  perf-profile.self.cycles-pp.copyin
      0.08 ± 13%      -0.1        0.00        perf-profile.self.cycles-pp.skb_copy_datagram_iter
      0.12 ± 17%      -0.1        0.05 ± 43%  perf-profile.self.cycles-pp.__fdget_pos
      0.07 ± 18%      -0.1        0.00        perf-profile.self.cycles-pp.iov_iter_init
      0.12 ± 13%      -0.1        0.04 ± 64%  perf-profile.self.cycles-pp.apparmor_socket_getpeersec_dgram
      0.11 ± 99%      -0.1        0.03 ±244%  perf-profile.self.cycles-pp.flush_smp_call_function_queue
      0.08 ± 14%      -0.1        0.01 ±244%  perf-profile.self.cycles-pp.autoremove_wake_function
      0.08 ± 19%      -0.1        0.01 ±244%  perf-profile.self.cycles-pp.perf_trace_buf_alloc
      0.08 ± 10%      -0.1        0.01 ±244%  perf-profile.self.cycles-pp.place_entity
      0.07 ± 18%      -0.1        0.00        perf-profile.self.cycles-pp.unix_scm_to_skb
      0.07 ± 48%      -0.1        0.00        perf-profile.self.cycles-pp.put_cpu_partial
      0.13 ± 16%      -0.1        0.06 ± 44%  perf-profile.self.cycles-pp.alloc_skb_with_frags
      0.07 ±  8%      -0.1        0.00        perf-profile.self.cycles-pp.__wake_up_common_lock
      0.07 ±  8%      -0.1        0.00        perf-profile.self.cycles-pp.tracing_generic_entry_update
      0.10 ± 11%      -0.1        0.03 ± 87%  perf-profile.self.cycles-pp.security_socket_sendmsg
      0.08 ± 23%      -0.1        0.01 ±244%  perf-profile.self.cycles-pp.get_xsave_addr
      0.07 ± 14%      -0.1        0.00        perf-profile.self.cycles-pp.rw_verify_area
      0.07 ± 12%      -0.1        0.01 ±244%  perf-profile.self.cycles-pp.switch_ldt
      0.06 ±  7%      -0.1        0.00        perf-profile.self.cycles-pp.maybe_add_creds
      0.09 ± 94%      -0.1        0.03 ±244%  perf-profile.self.cycles-pp.llist_add_batch
      0.06 ± 15%      -0.1        0.00        perf-profile.self.cycles-pp.put_pid
      0.14 ± 14%      -0.1        0.09 ± 20%  perf-profile.self.cycles-pp.ktime_get
      0.09 ±141%      -0.1        0.04 ±244%  perf-profile.self.cycles-pp.poll_idle
      0.05 ± 49%      -0.1        0.00        perf-profile.self.cycles-pp.perf_swevent_get_recursion_context
      0.07 ±117%      -0.1        0.02 ±244%  perf-profile.self.cycles-pp.sched_ttwu_pending
      0.08 ±  7%      -0.1        0.03 ± 87%  perf-profile.self.cycles-pp.ktime_get_update_offsets_now
      0.05 ±  8%      -0.0        0.01 ±244%  perf-profile.self.cycles-pp.skb_queue_tail
      0.12 ± 16%      -0.0        0.08 ± 48%  perf-profile.self.cycles-pp.wait_for_unix_gc
      0.07 ±121%      -0.0        0.02 ±244%  perf-profile.self.cycles-pp.llist_reverse_order
      0.05 ± 48%      -0.0        0.01 ±244%  perf-profile.self.cycles-pp.ttwu_do_wakeup
      0.04 ± 71%      -0.0        0.00        perf-profile.self.cycles-pp.copyout
      0.03 ± 70%      -0.0        0.00        perf-profile.self.cycles-pp.cgroup_rstat_updated
      0.03 ±100%      -0.0        0.00        perf-profile.self.cycles-pp.skb_release_head_state
      0.03 ±100%      -0.0        0.00        perf-profile.self.cycles-pp.check_cfs_rq_runtime
      0.03 ± 99%      -0.0        0.00        perf-profile.self.cycles-pp.finish_wait
      0.02 ±141%      -0.0        0.00        perf-profile.self.cycles-pp.simple_copy_to_iter
      0.02 ±141%      -0.0        0.00        perf-profile.self.cycles-pp.skb_put
      0.09 ± 20%      -0.0        0.08 ± 25%  perf-profile.self.cycles-pp.skb_unlink
      0.01 ±223%      -0.0        0.00        perf-profile.self.cycles-pp.wait_consider_task
      0.01 ±223%      -0.0        0.00        perf-profile.self.cycles-pp.menu_select
      0.01 ±223%      -0.0        0.00        perf-profile.self.cycles-pp.page_vma_mapped_walk
      0.01 ±223%      -0.0        0.00        perf-profile.self.cycles-pp.update_irq_load_avg
      0.00            +0.0        0.04 ± 67%  perf-profile.self.cycles-pp.mem_cgroup_from_task
      0.00            +0.1        0.06 ± 23%  perf-profile.self.cycles-pp.try_charge
      0.08 ±143%      +0.1        0.14 ± 54%  perf-profile.self.cycles-pp.queue_event
      0.04 ±142%      +0.1        0.14 ± 66%  perf-profile.self.cycles-pp.__libc_write
      0.06 ±150%      +0.1        0.18 ± 68%  perf-profile.self.cycles-pp.__libc_read
      0.00            +0.2        0.17 ± 19%  perf-profile.self.cycles-pp.__mod_memcg_lruvec_state
      0.45 ±153%      +0.2        0.63 ± 49%  perf-profile.self.cycles-pp.intel_idle
      0.34 ± 12%      +0.3        0.59 ± 36%  perf-profile.self.cycles-pp.mutex_unlock
      0.00            +0.3        0.29 ± 64%  perf-profile.self.cycles-pp.page_counter_uncharge
      0.00            +1.9        1.85 ± 37%  perf-profile.self.cycles-pp.obj_cgroup_charge
      0.00            +2.2        2.16 ± 36%  perf-profile.self.cycles-pp.get_obj_cgroup_from_current
      0.00            +2.4        2.35 ± 37%  perf-profile.self.cycles-pp.__mod_memcg_state
      0.00            +2.9        2.94 ± 26%  perf-profile.self.cycles-pp.refill_obj_stock
      0.00            +3.7        3.75 ± 40%  perf-profile.self.cycles-pp.drain_obj_stock
      0.00            +4.5        4.52 ± 59%  perf-profile.self.cycles-pp.propagate_protected_usage
      0.00            +6.0        6.05 ± 60%  perf-profile.self.cycles-pp.page_counter_try_charge
      0.95 ± 12%      +7.0        7.91 ± 49%  perf-profile.self.cycles-pp.kmem_cache_free
      0.56 ± 14%      +7.3        7.91 ± 58%  perf-profile.self.cycles-pp.__kmalloc_node_track_caller
      0.52 ± 15%      +7.4        7.91 ± 59%  perf-profile.self.cycles-pp.kmem_cache_alloc_node
      0.27 ± 10%      +7.5        7.77 ± 48%  perf-profile.self.cycles-pp.kfree
      0.00            +9.1        9.11 ± 34%  perf-profile.self.cycles-pp.page_counter_cancel
      0.15 ±223%  +1.9e+05%     288.08 ±243%  perf-sched.sch_delay.avg.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      0.11 ±158%    +861.7%       1.05 ±200%  perf-sched.sch_delay.avg.ms.devkmsg_read.vfs_read.ksys_read.do_syscall_64
      0.00 ±223%  +9.8e+06%     228.07 ±201%  perf-sched.sch_delay.avg.ms.do_nanosleep.hrtimer_nanosleep.__x64_sys_nanosleep.do_syscall_64
      0.02 ± 14%     -27.7%       0.01 ±102%  perf-sched.sch_delay.avg.ms.do_syslog.part.0.kmsg_read.vfs_read
      0.55 ±182%   +8254.1%      46.18 ± 45%  perf-sched.sch_delay.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      0.03 ±140%  +1.6e+05%      52.22 ± 43%  perf-sched.sch_delay.avg.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      1.73 ±142%     -19.2%       1.40 ± 26%  perf-sched.sch_delay.avg.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_exc_page_fault.[unknown]
     38.07 ±114%     -44.0%      21.31 ± 36%  perf-sched.sch_delay.avg.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
      0.35 ±121%   +1178.7%       4.47 ±143%  perf-sched.sch_delay.avg.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_call_function_single.[unknown]
      1.89 ±118%    +335.9%       8.22 ± 44%  perf-sched.sch_delay.avg.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown]
      2.72 ±107%     +23.2%       3.35 ± 15%  perf-sched.sch_delay.avg.ms.exit_to_user_mode_prepare.syscall_exit_to_user_mode.entry_SYSCALL_64_after_hwframe.[unknown]
      0.73 ±223%   +1038.4%       8.27 ±142%  perf-sched.sch_delay.avg.ms.exit_to_user_mode_prepare.syscall_exit_to_user_mode.ret_from_fork.[unknown]
      0.00       +7.8e+102%       7.80 ±244%  perf-sched.sch_delay.avg.ms.io_schedule.__lock_page_killable.filemap_fault.__do_fault
      0.02 ± 64%  +84116.7%      20.21 ± 42%  perf-sched.sch_delay.avg.ms.pipe_read.new_sync_read.vfs_read.ksys_read
      0.05 ±223%   +1372.3%       0.76 ±105%  perf-sched.sch_delay.avg.ms.pipe_wait.wait_for_partner.fifo_open.do_dentry_open
      0.00       +1.2e+102%       1.24 ±244%  perf-sched.sch_delay.avg.ms.preempt_schedule_common._cond_resched.__alloc_pages_nodemask.__get_free_pages.pgd_alloc
      0.00       +2.3e+101%       0.23 ±196%  perf-sched.sch_delay.avg.ms.preempt_schedule_common._cond_resched.__alloc_pages_nodemask.__pmd_alloc.__handle_mm_fault
      0.00        +8.6e+98%       0.00 ±244%  perf-sched.sch_delay.avg.ms.preempt_schedule_common._cond_resched.__alloc_pages_nodemask.alloc_pages_vma.do_anonymous_page
      0.00       +4.8e+102%       4.81 ±108%  perf-sched.sch_delay.avg.ms.preempt_schedule_common._cond_resched.__alloc_pages_nodemask.alloc_pages_vma.wp_page_copy
      0.00       +3.8e+101%       0.38 ±244%  perf-sched.sch_delay.avg.ms.preempt_schedule_common._cond_resched.__alloc_pages_nodemask.pte_alloc_one.__pte_alloc
      0.00       +2.1e+101%       0.21 ±244%  perf-sched.sch_delay.avg.ms.preempt_schedule_common._cond_resched.__anon_vma_prepare.do_anonymous_page.__handle_mm_fault
      0.00        +1.7e+99%       0.00 ±244%  perf-sched.sch_delay.avg.ms.preempt_schedule_common._cond_resched.__anon_vma_prepare.do_fault.__handle_mm_fault
      0.00       +1.4e+101%       0.14 ±244%  perf-sched.sch_delay.avg.ms.preempt_schedule_common._cond_resched.__flush_work.lru_add_drain_all.khugepaged
      0.00       +4.3e+101%       0.43 ±244%  perf-sched.sch_delay.avg.ms.preempt_schedule_common._cond_resched.__get_user_pages.__get_user_pages_remote.get_arg_page
      0.00         +4e+101%       0.40 ±244%  perf-sched.sch_delay.avg.ms.preempt_schedule_common._cond_resched.__kmalloc.load_elf_phdrs.load_elf_binary
      8.84 ±127%     -34.3%       5.81 ± 30%  perf-sched.sch_delay.avg.ms.preempt_schedule_common._cond_resched.__kmalloc_node_track_caller.__kmalloc_reserve.isra
      0.00         +6e+101%       0.60 ±120%  perf-sched.sch_delay.avg.ms.preempt_schedule_common._cond_resched.__put_anon_vma.unlink_anon_vmas.free_pgtables
     24.19 ± 91%     -85.1%       3.60 ± 17%  perf-sched.sch_delay.avg.ms.preempt_schedule_common._cond_resched.aa_sk_perm.security_socket_recvmsg.sock_recvmsg
     24.22 ±106%     -70.5%       7.14 ± 27%  perf-sched.sch_delay.avg.ms.preempt_schedule_common._cond_resched.aa_sk_perm.security_socket_sendmsg.sock_sendmsg
      0.00       +5.2e+102%       5.22 ±244%  perf-sched.sch_delay.avg.ms.preempt_schedule_common._cond_resched.apparmor_file_alloc_security.security_file_alloc.__alloc_file
      0.00       +1.9e+101%       0.19 ±244%  perf-sched.sch_delay.avg.ms.preempt_schedule_common._cond_resched.change_p4d_range.change_protection.change_prot_numa
      0.00        +1.6e+99%       0.00 ±244%  perf-sched.sch_delay.avg.ms.preempt_schedule_common._cond_resched.change_p4d_range.change_protection.mprotect_fixup
      0.00        +1.3e+99%       0.00 ±244%  perf-sched.sch_delay.avg.ms.preempt_schedule_common._cond_resched.copy_page_range.dup_mmap.dup_mm
      0.00       +2.4e+102%       2.36 ±163%  perf-sched.sch_delay.avg.ms.preempt_schedule_common._cond_resched.copy_page_to_iter.pipe_read.new_sync_read
      0.00        +2.9e+99%       0.00 ±115%  perf-sched.sch_delay.avg.ms.preempt_schedule_common._cond_resched.copy_pte_range.copy_page_range.dup_mmap
      0.00       +2.9e+101%       0.29 ±223%  perf-sched.sch_delay.avg.ms.preempt_schedule_common._cond_resched.copy_strings.isra.0
      0.00       +1.2e+102%       1.20 ±234%  perf-sched.sch_delay.avg.ms.preempt_schedule_common._cond_resched.count.isra.0
      1.66 ±223%     -66.8%       0.55 ±123%  perf-sched.sch_delay.avg.ms.preempt_schedule_common._cond_resched.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      0.00        +5.7e+98%       0.00 ±244%  perf-sched.sch_delay.avg.ms.preempt_schedule_common._cond_resched.down_read.acct_collect.do_exit
      0.00        +9.6e+99%       0.01 ±216%  perf-sched.sch_delay.avg.ms.preempt_schedule_common._cond_resched.down_read.rmap_walk_anon.remove_migration_ptes
      0.00       +1.3e+102%       1.30 ±244%  perf-sched.sch_delay.avg.ms.preempt_schedule_common._cond_resched.down_read.walk_component.path_lookupat
      0.00         +8e+100%       0.08 ±244%  perf-sched.sch_delay.avg.ms.preempt_schedule_common._cond_resched.down_write.__vma_adjust.shift_arg_pages
      0.00        +1.3e+99%       0.00 ±244%  perf-sched.sch_delay.avg.ms.preempt_schedule_common._cond_resched.down_write.anon_vma_clone.anon_vma_fork
      0.00        +3.3e+99%       0.00 ±163%  perf-sched.sch_delay.avg.ms.preempt_schedule_common._cond_resched.down_write.anon_vma_fork.dup_mmap
      0.00       +1.6e+104%     162.73 ±244%  perf-sched.sch_delay.avg.ms.preempt_schedule_common._cond_resched.down_write.dup_mmap.dup_mm
      0.00        +2.6e+99%       0.00 ±149%  perf-sched.sch_delay.avg.ms.preempt_schedule_common._cond_resched.down_write.unlink_anon_vmas.free_pgtables
      0.00        +4.6e+99%       0.00 ±244%  perf-sched.sch_delay.avg.ms.preempt_schedule_common._cond_resched.down_write.unlink_file_vma.free_pgtables
      0.00       +1.9e+101%       0.19 ±244%  perf-sched.sch_delay.avg.ms.preempt_schedule_common._cond_resched.down_write.vma_link.mmap_region
      0.00       +5.6e+101%       0.56 ±244%  perf-sched.sch_delay.avg.ms.preempt_schedule_common._cond_resched.down_write_killable.map_vdso.load_elf_binary
      0.00         +3e+100%       0.03 ±244%  perf-sched.sch_delay.avg.ms.preempt_schedule_common._cond_resched.down_write_killable.setup_arg_pages.load_elf_binary
      0.00        +4.3e+98%       0.00 ±244%  perf-sched.sch_delay.avg.ms.preempt_schedule_common._cond_resched.down_write_killable.vm_mmap_pgoff.elf_map
      0.00       +8.4e+100%       0.08 ±244%  perf-sched.sch_delay.avg.ms.preempt_schedule_common._cond_resched.dput.path_openat.do_filp_open
      0.00       +2.1e+100%       0.02 ±244%  perf-sched.sch_delay.avg.ms.preempt_schedule_common._cond_resched.dput.path_put.free_fs_struct
      0.00       +3.2e+101%       0.32 ±244%  perf-sched.sch_delay.avg.ms.preempt_schedule_common._cond_resched.dput.step_into.walk_component
      0.00        +8.7e+99%       0.01 ±244%  perf-sched.sch_delay.avg.ms.preempt_schedule_common._cond_resched.dput.terminate_walk.path_lookupat
      0.00       +3.9e+101%       0.39 ±244%  perf-sched.sch_delay.avg.ms.preempt_schedule_common._cond_resched.dput.terminate_walk.path_openat
      0.00       +9.1e+100%       0.09 ±144%  perf-sched.sch_delay.avg.ms.preempt_schedule_common._cond_resched.exit_mmap.mmput.begin_new_exec
      0.00        +5.7e+98%       0.00 ±244%  perf-sched.sch_delay.avg.ms.preempt_schedule_common._cond_resched.exit_mmap.mmput.do_exit
      0.00       +3.9e+102%       3.92 ±153%  perf-sched.sch_delay.avg.ms.preempt_schedule_common._cond_resched.generic_file_buffered_read.new_sync_read.__kernel_read
      0.16 ±223%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.preempt_schedule_common._cond_resched.khugepaged.kthread.ret_from_fork
      0.00       +6.4e+100%       0.06 ±244%  perf-sched.sch_delay.avg.ms.preempt_schedule_common._cond_resched.kmem_cache_alloc.__alloc_file.alloc_empty_file
      0.00        +1.3e+99%       0.00 ±244%  perf-sched.sch_delay.avg.ms.preempt_schedule_common._cond_resched.kmem_cache_alloc.copy_process._do_fork
      0.00 ±223%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.preempt_schedule_common._cond_resched.kmem_cache_alloc.dup_fd.copy_process
      1.75 ±223%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.preempt_schedule_common._cond_resched.kmem_cache_alloc.mm_alloc.alloc_bprm
      0.00       +1.6e+102%       1.56 ±244%  perf-sched.sch_delay.avg.ms.preempt_schedule_common._cond_resched.kmem_cache_alloc.prepare_creds.copy_creds
      0.00       +3.6e+101%       0.36 ±170%  perf-sched.sch_delay.avg.ms.preempt_schedule_common._cond_resched.kmem_cache_alloc.security_file_alloc.__alloc_file
      0.00         +5e+102%       4.96 ±232%  perf-sched.sch_delay.avg.ms.preempt_schedule_common._cond_resched.kmem_cache_alloc.vm_area_alloc.alloc_bprm
      4.15 ±109%    +121.3%       9.19 ± 23%  perf-sched.sch_delay.avg.ms.preempt_schedule_common._cond_resched.kmem_cache_alloc_node.__alloc_skb.alloc_skb_with_frags
      0.00        +2.6e+99%       0.00 ±244%  perf-sched.sch_delay.avg.ms.preempt_schedule_common._cond_resched.kmem_cache_alloc_trace.i40e_clean_adminq_subtask.i40e_service_task
      0.00       +6.8e+102%       6.76 ±244%  perf-sched.sch_delay.avg.ms.preempt_schedule_common._cond_resched.migrate_pages.migrate_misplaced_page.__handle_mm_fault
      0.00       +2.1e+101%       0.21 ±244%  perf-sched.sch_delay.avg.ms.preempt_schedule_common._cond_resched.mmput.begin_new_exec.load_elf_binary
      0.00         +1e+103%      10.06 ±162%  perf-sched.sch_delay.avg.ms.preempt_schedule_common._cond_resched.mutex_lock.futex_exec_release.exec_mm_release
      0.00         +2e+103%      19.93 ±244%  perf-sched.sch_delay.avg.ms.preempt_schedule_common._cond_resched.mutex_lock.perf_event_exit_task.do_exit
     13.54 ±182%     -74.4%       3.46 ± 23%  perf-sched.sch_delay.avg.ms.preempt_schedule_common._cond_resched.mutex_lock.unix_stream_read_generic.unix_stream_recvmsg
      0.00        +7.1e+98%       0.00 ±244%  perf-sched.sch_delay.avg.ms.preempt_schedule_common._cond_resched.pipe_read.new_sync_read.vfs_read
      0.00       +3.8e+103%      37.68 ±244%  perf-sched.sch_delay.avg.ms.preempt_schedule_common._cond_resched.put_files_struct.do_exit.do_group_exit
      0.00       +2.5e+100%       0.02 ±244%  perf-sched.sch_delay.avg.ms.preempt_schedule_common._cond_resched.remove_vma.exit_mmap.mmput
     12.10 ±214%     -75.2%       3.00 ± 78%  perf-sched.sch_delay.avg.ms.preempt_schedule_common._cond_resched.rmap_walk_anon.remove_migration_ptes.migrate_pages
      0.27 ±166%   +1343.6%       3.94 ±176%  perf-sched.sch_delay.avg.ms.preempt_schedule_common._cond_resched.rmap_walk_anon.try_to_unmap.migrate_pages
      0.00 ±165%   +1228.6%       0.01 ±138%  perf-sched.sch_delay.avg.ms.preempt_schedule_common._cond_resched.stop_one_cpu.__set_cpus_allowed_ptr.sched_setaffinity
      0.00         +4e+103%      40.30 ±100%  perf-sched.sch_delay.avg.ms.preempt_schedule_common._cond_resched.stop_one_cpu.migrate_task_to.task_numa_migrate
      6.93 ±150%     +35.5%       9.40 ± 32%  perf-sched.sch_delay.avg.ms.preempt_schedule_common._cond_resched.stop_one_cpu.sched_exec.bprm_execve
      0.78 ±221%    +297.1%       3.08 ± 53%  perf-sched.sch_delay.avg.ms.preempt_schedule_common._cond_resched.unix_stream_read_generic.unix_stream_recvmsg.sock_read_iter
      0.00       +1.2e+102%       1.20 ±242%  perf-sched.sch_delay.avg.ms.preempt_schedule_common._cond_resched.unmap_page_range.unmap_vmas.exit_mmap
      0.00       +1.2e+100%       0.01 ±244%  perf-sched.sch_delay.avg.ms.preempt_schedule_common._cond_resched.unmap_vmas.exit_mmap.mmput
      0.00       +1.7e+102%       1.67 ±240%  perf-sched.sch_delay.avg.ms.preempt_schedule_common._cond_resched.unmap_vmas.unmap_region.__do_munmap
      0.00 ±223%  +6.4e+05%      21.24 ±102%  perf-sched.sch_delay.avg.ms.preempt_schedule_common._cond_resched.wait_for_completion.stop_two_cpus.migrate_swap
      2.06 ±203%    +130.4%       4.75 ± 26%  perf-sched.sch_delay.avg.ms.preempt_schedule_common._cond_resched.wait_for_unix_gc.unix_stream_sendmsg.sock_sendmsg
      0.00 ±223%  +65055.1%       0.76 ±144%  perf-sched.sch_delay.avg.ms.preempt_schedule_common._cond_resched.wp_page_copy.do_wp_page.__handle_mm_fault
      4.55 ±223%     -97.8%       0.10 ±181%  perf-sched.sch_delay.avg.ms.preempt_schedule_common._cond_resched.zap_pte_range.unmap_page_range.unmap_vmas
    290.80 ±218%     -96.8%       9.40 ± 71%  perf-sched.sch_delay.avg.ms.rcu_gp_kthread.kthread.ret_from_fork
      1.52 ±200%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.rwsem_down_read_slowpath.page_lock_anon_vma_read.rmap_walk_anon.try_to_unmap
    695.82 ±223%     -99.8%       1.45 ±244%  perf-sched.sch_delay.avg.ms.rwsem_down_read_slowpath.rmap_walk_anon.remove_migration_ptes.migrate_pages
      0.00       +3.5e+101%       0.35 ±244%  perf-sched.sch_delay.avg.ms.rwsem_down_write_slowpath.__put_anon_vma.unlink_anon_vmas.free_pgtables
      0.00       +2.9e+102%       2.92 ±231%  perf-sched.sch_delay.avg.ms.rwsem_down_write_slowpath.unlink_anon_vmas.free_pgtables.exit_mmap
      0.02 ± 34%    +517.6%       0.13 ±189%  perf-sched.sch_delay.avg.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      0.03 ± 77%   +1362.6%       0.49 ±237%  perf-sched.sch_delay.avg.ms.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop.0.do_select
      0.08 ±216%  +84555.2%      65.75 ±159%  perf-sched.sch_delay.avg.ms.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop.0.do_sys_poll
     87.60 ± 91%     -94.4%       4.95 ± 14%  perf-sched.sch_delay.avg.ms.schedule_timeout.rcu_gp_kthread.kthread.ret_from_fork
     55.30 ± 63%     -56.9%      23.83 ± 25%  perf-sched.sch_delay.avg.ms.schedule_timeout.sock_alloc_send_pskb.unix_stream_sendmsg.sock_sendmsg
     11.58 ± 15%     -73.7%       3.04 ± 16%  perf-sched.sch_delay.avg.ms.schedule_timeout.unix_stream_read_generic.unix_stream_recvmsg.sock_read_iter
      0.01 ±  7%  +60614.3%       4.86 ± 58%  perf-sched.sch_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork
    129.95 ±222%     +94.7%     253.01 ± 50%  perf-sched.sch_delay.avg.ms.worker_thread.kthread.ret_from_fork
      0.15 ±223%  +3.7e+05%     579.91 ±241%  perf-sched.sch_delay.max.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      0.11 ±158%    +861.7%       1.05 ±200%  perf-sched.sch_delay.max.ms.devkmsg_read.vfs_read.ksys_read.do_syscall_64
      0.00 ±223%  +1.9e+07%     718.64 ±192%  perf-sched.sch_delay.max.ms.do_nanosleep.hrtimer_nanosleep.__x64_sys_nanosleep.do_syscall_64
      0.02 ± 14%     -27.7%       0.01 ±102%  perf-sched.sch_delay.max.ms.do_syslog.part.0.kmsg_read.vfs_read
      3.33 ±142%  +33803.7%       1127 ±  9%  perf-sched.sch_delay.max.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      0.41 ±192%  +6.6e+05%       2709 ± 46%  perf-sched.sch_delay.max.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
     15.89 ±141%    +517.0%      98.02 ± 30%  perf-sched.sch_delay.max.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_exc_page_fault.[unknown]
      3660 ±117%     -46.8%       1946 ± 57%  perf-sched.sch_delay.max.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
      6.07 ±124%   +8295.4%     509.42 ±139%  perf-sched.sch_delay.max.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_call_function_single.[unknown]
      1458 ±218%     +34.0%       1954 ± 51%  perf-sched.sch_delay.max.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown]
     13722 ± 14%     -79.2%       2852 ± 40%  perf-sched.sch_delay.max.ms.exit_to_user_mode_prepare.syscall_exit_to_user_mode.entry_SYSCALL_64_after_hwframe.[unknown]
      1.65 ±223%   +1882.4%      32.79 ±141%  perf-sched.sch_delay.max.ms.exit_to_user_mode_prepare.syscall_exit_to_user_mode.ret_from_fork.[unknown]
      0.00       +7.8e+102%       7.80 ±244%  perf-sched.sch_delay.max.ms.io_schedule.__lock_page_killable.filemap_fault.__do_fault
      0.22 ± 91%  +1.8e+06%       3977 ± 21%  perf-sched.sch_delay.max.ms.pipe_read.new_sync_read.vfs_read.ksys_read
      0.52 ±223%   +2720.2%      14.61 ±114%  perf-sched.sch_delay.max.ms.pipe_wait.wait_for_partner.fifo_open.do_dentry_open
      0.00       +2.5e+102%       2.48 ±244%  perf-sched.sch_delay.max.ms.preempt_schedule_common._cond_resched.__alloc_pages_nodemask.__get_free_pages.pgd_alloc
      0.00       +2.1e+102%       2.14 ±192%  perf-sched.sch_delay.max.ms.preempt_schedule_common._cond_resched.__alloc_pages_nodemask.__pmd_alloc.__handle_mm_fault
      0.00       +1.2e+100%       0.01 ±244%  perf-sched.sch_delay.max.ms.preempt_schedule_common._cond_resched.__alloc_pages_nodemask.alloc_pages_vma.do_anonymous_page
      0.00       +4.9e+103%      49.27 ±109%  perf-sched.sch_delay.max.ms.preempt_schedule_common._cond_resched.__alloc_pages_nodemask.alloc_pages_vma.wp_page_copy
      0.00       +5.7e+102%       5.74 ±244%  perf-sched.sch_delay.max.ms.preempt_schedule_common._cond_resched.__alloc_pages_nodemask.pte_alloc_one.__pte_alloc
      0.00       +1.1e+102%       1.07 ±244%  perf-sched.sch_delay.max.ms.preempt_schedule_common._cond_resched.__anon_vma_prepare.do_anonymous_page.__handle_mm_fault
      0.00        +6.7e+99%       0.01 ±244%  perf-sched.sch_delay.max.ms.preempt_schedule_common._cond_resched.__anon_vma_prepare.do_fault.__handle_mm_fault
      0.00       +1.4e+101%       0.14 ±244%  perf-sched.sch_delay.max.ms.preempt_schedule_common._cond_resched.__flush_work.lru_add_drain_all.khugepaged
      0.00       +4.3e+102%       4.26 ±244%  perf-sched.sch_delay.max.ms.preempt_schedule_common._cond_resched.__get_user_pages.__get_user_pages_remote.get_arg_page
      0.00         +4e+102%       4.00 ±244%  perf-sched.sch_delay.max.ms.preempt_schedule_common._cond_resched.__kmalloc.load_elf_phdrs.load_elf_binary
      4596 ±118%     -43.8%       2583 ± 35%  perf-sched.sch_delay.max.ms.preempt_schedule_common._cond_resched.__kmalloc_node_track_caller.__kmalloc_reserve.isra
      0.00       +1.8e+103%      17.72 ±115%  perf-sched.sch_delay.max.ms.preempt_schedule_common._cond_resched.__put_anon_vma.unlink_anon_vmas.free_pgtables
      4829 ± 81%     -69.8%       1459 ± 64%  perf-sched.sch_delay.max.ms.preempt_schedule_common._cond_resched.aa_sk_perm.security_socket_recvmsg.sock_recvmsg
      6976 ± 74%     -76.4%       1645 ± 27%  perf-sched.sch_delay.max.ms.preempt_schedule_common._cond_resched.aa_sk_perm.security_socket_sendmsg.sock_sendmsg
      0.00       +5.2e+102%       5.22 ±244%  perf-sched.sch_delay.max.ms.preempt_schedule_common._cond_resched.apparmor_file_alloc_security.security_file_alloc.__alloc_file
      0.00       +2.4e+102%       2.37 ±244%  perf-sched.sch_delay.max.ms.preempt_schedule_common._cond_resched.change_p4d_range.change_protection.change_prot_numa
      0.00          +6e+99%       0.01 ±244%  perf-sched.sch_delay.max.ms.preempt_schedule_common._cond_resched.change_p4d_range.change_protection.mprotect_fixup
      0.00        +1.3e+99%       0.00 ±244%  perf-sched.sch_delay.max.ms.preempt_schedule_common._cond_resched.copy_page_range.dup_mmap.dup_mm
      0.00       +2.4e+102%       2.36 ±163%  perf-sched.sch_delay.max.ms.preempt_schedule_common._cond_resched.copy_page_to_iter.pipe_read.new_sync_read
      0.00        +2.9e+99%       0.00 ±115%  perf-sched.sch_delay.max.ms.preempt_schedule_common._cond_resched.copy_pte_range.copy_page_range.dup_mmap
      0.00       +7.3e+102%       7.33 ±230%  perf-sched.sch_delay.max.ms.preempt_schedule_common._cond_resched.copy_strings.isra.0
      0.00         +7e+102%       7.04 ±239%  perf-sched.sch_delay.max.ms.preempt_schedule_common._cond_resched.count.isra.0
     13.32 ±223%    +153.2%      33.72 ±125%  perf-sched.sch_delay.max.ms.preempt_schedule_common._cond_resched.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      0.00        +1.1e+99%       0.00 ±244%  perf-sched.sch_delay.max.ms.preempt_schedule_common._cond_resched.down_read.acct_collect.do_exit
      0.00       +2.4e+100%       0.02 ±176%  perf-sched.sch_delay.max.ms.preempt_schedule_common._cond_resched.down_read.rmap_walk_anon.remove_migration_ptes
      0.00       +3.9e+102%       3.89 ±244%  perf-sched.sch_delay.max.ms.preempt_schedule_common._cond_resched.down_read.walk_component.path_lookupat
      0.00       +1.3e+102%       1.28 ±244%  perf-sched.sch_delay.max.ms.preempt_schedule_common._cond_resched.down_write.__vma_adjust.shift_arg_pages
      0.00        +1.3e+99%       0.00 ±244%  perf-sched.sch_delay.max.ms.preempt_schedule_common._cond_resched.down_write.anon_vma_clone.anon_vma_fork
      0.00        +3.3e+99%       0.00 ±163%  perf-sched.sch_delay.max.ms.preempt_schedule_common._cond_resched.down_write.anon_vma_fork.dup_mmap
      0.00       +1.6e+104%     162.73 ±244%  perf-sched.sch_delay.max.ms.preempt_schedule_common._cond_resched.down_write.dup_mmap.dup_mm
      0.00       +3.7e+100%       0.04 ±146%  perf-sched.sch_delay.max.ms.preempt_schedule_common._cond_resched.down_write.unlink_anon_vmas.free_pgtables
      0.00       +2.9e+101%       0.29 ±244%  perf-sched.sch_delay.max.ms.preempt_schedule_common._cond_resched.down_write.unlink_file_vma.free_pgtables
      0.00       +7.2e+102%       7.21 ±244%  perf-sched.sch_delay.max.ms.preempt_schedule_common._cond_resched.down_write.vma_link.mmap_region
      0.00       +2.8e+102%       2.82 ±244%  perf-sched.sch_delay.max.ms.preempt_schedule_common._cond_resched.down_write_killable.map_vdso.load_elf_binary
      0.00       +4.3e+101%       0.43 ±244%  perf-sched.sch_delay.max.ms.preempt_schedule_common._cond_resched.down_write_killable.setup_arg_pages.load_elf_binary
      0.00        +5.3e+99%       0.01 ±244%  perf-sched.sch_delay.max.ms.preempt_schedule_common._cond_resched.down_write_killable.vm_mmap_pgoff.elf_map
      0.00       +5.9e+101%       0.59 ±244%  perf-sched.sch_delay.max.ms.preempt_schedule_common._cond_resched.dput.path_openat.do_filp_open
      0.00       +4.1e+100%       0.04 ±244%  perf-sched.sch_delay.max.ms.preempt_schedule_common._cond_resched.dput.path_put.free_fs_struct
      0.00       +9.3e+102%       9.27 ±244%  perf-sched.sch_delay.max.ms.preempt_schedule_common._cond_resched.dput.step_into.walk_component
      0.00        +8.7e+99%       0.01 ±244%  perf-sched.sch_delay.max.ms.preempt_schedule_common._cond_resched.dput.terminate_walk.path_lookupat
      0.00       +5.5e+102%       5.46 ±244%  perf-sched.sch_delay.max.ms.preempt_schedule_common._cond_resched.dput.terminate_walk.path_openat
      0.00       +3.4e+102%       3.41 ±155%  perf-sched.sch_delay.max.ms.preempt_schedule_common._cond_resched.exit_mmap.mmput.begin_new_exec
      0.00       +1.5e+100%       0.02 ±244%  perf-sched.sch_delay.max.ms.preempt_schedule_common._cond_resched.exit_mmap.mmput.do_exit
      0.00       +4.7e+103%      47.32 ±143%  perf-sched.sch_delay.max.ms.preempt_schedule_common._cond_resched.generic_file_buffered_read.new_sync_read.__kernel_read
      0.16 ±223%    -100.0%       0.00        perf-sched.sch_delay.max.ms.preempt_schedule_common._cond_resched.khugepaged.kthread.ret_from_fork
      0.00         +1e+102%       1.02 ±244%  perf-sched.sch_delay.max.ms.preempt_schedule_common._cond_resched.kmem_cache_alloc.__alloc_file.alloc_empty_file
      0.00        +1.3e+99%       0.00 ±244%  perf-sched.sch_delay.max.ms.preempt_schedule_common._cond_resched.kmem_cache_alloc.copy_process._do_fork
      0.00 ±223%    -100.0%       0.00        perf-sched.sch_delay.max.ms.preempt_schedule_common._cond_resched.kmem_cache_alloc.dup_fd.copy_process
      1.75 ±223%    -100.0%       0.00        perf-sched.sch_delay.max.ms.preempt_schedule_common._cond_resched.kmem_cache_alloc.mm_alloc.alloc_bprm
      0.00       +1.6e+102%       1.56 ±244%  perf-sched.sch_delay.max.ms.preempt_schedule_common._cond_resched.kmem_cache_alloc.prepare_creds.copy_creds
      0.00       +2.9e+103%      28.50 ±199%  perf-sched.sch_delay.max.ms.preempt_schedule_common._cond_resched.kmem_cache_alloc.security_file_alloc.__alloc_file
      0.00       +2.1e+103%      21.47 ±221%  perf-sched.sch_delay.max.ms.preempt_schedule_common._cond_resched.kmem_cache_alloc.vm_area_alloc.alloc_bprm
      3224 ±142%     -41.5%       1887 ± 42%  perf-sched.sch_delay.max.ms.preempt_schedule_common._cond_resched.kmem_cache_alloc_node.__alloc_skb.alloc_skb_with_frags
      0.00        +2.6e+99%       0.00 ±244%  perf-sched.sch_delay.max.ms.preempt_schedule_common._cond_resched.kmem_cache_alloc_trace.i40e_clean_adminq_subtask.i40e_service_task
      0.00       +6.8e+102%       6.76 ±244%  perf-sched.sch_delay.max.ms.preempt_schedule_common._cond_resched.migrate_pages.migrate_misplaced_page.__handle_mm_fault
      0.00       +4.2e+101%       0.42 ±244%  perf-sched.sch_delay.max.ms.preempt_schedule_common._cond_resched.mmput.begin_new_exec.load_elf_binary
      0.00       +3.9e+103%      38.92 ±158%  perf-sched.sch_delay.max.ms.preempt_schedule_common._cond_resched.mutex_lock.futex_exec_release.exec_mm_release
      0.00         +2e+103%      19.93 ±244%  perf-sched.sch_delay.max.ms.preempt_schedule_common._cond_resched.mutex_lock.perf_event_exit_task.do_exit
      1328 ±144%     -27.8%     958.72 ± 32%  perf-sched.sch_delay.max.ms.preempt_schedule_common._cond_resched.mutex_lock.unix_stream_read_generic.unix_stream_recvmsg
      0.00        +7.1e+98%       0.00 ±244%  perf-sched.sch_delay.max.ms.preempt_schedule_common._cond_resched.pipe_read.new_sync_read.vfs_read
      0.00       +1.5e+104%     150.73 ±244%  perf-sched.sch_delay.max.ms.preempt_schedule_common._cond_resched.put_files_struct.do_exit.do_group_exit
      0.00         +6e+101%       0.60 ±244%  perf-sched.sch_delay.max.ms.preempt_schedule_common._cond_resched.remove_vma.exit_mmap.mmput
      1023 ±222%     -90.3%      99.18 ±105%  perf-sched.sch_delay.max.ms.preempt_schedule_common._cond_resched.rmap_walk_anon.remove_migration_ptes.migrate_pages
      3.27 ±142%    +368.9%      15.32 ± 95%  perf-sched.sch_delay.max.ms.preempt_schedule_common._cond_resched.rmap_walk_anon.try_to_unmap.migrate_pages
      0.10 ±150%   +2407.8%       2.38 ±151%  perf-sched.sch_delay.max.ms.preempt_schedule_common._cond_resched.stop_one_cpu.__set_cpus_allowed_ptr.sched_setaffinity
      0.00       +1.9e+104%     185.52 ±108%  perf-sched.sch_delay.max.ms.preempt_schedule_common._cond_resched.stop_one_cpu.migrate_task_to.task_numa_migrate
     34.88 ±141%    +279.8%     132.44 ± 35%  perf-sched.sch_delay.max.ms.preempt_schedule_common._cond_resched.stop_one_cpu.sched_exec.bprm_execve
      1.57 ±217%   +6527.1%     104.06 ± 67%  perf-sched.sch_delay.max.ms.preempt_schedule_common._cond_resched.unix_stream_read_generic.unix_stream_recvmsg.sock_read_iter
      0.00       +1.1e+103%      10.83 ±241%  perf-sched.sch_delay.max.ms.preempt_schedule_common._cond_resched.unmap_page_range.unmap_vmas.exit_mmap
      0.00       +6.9e+100%       0.07 ±244%  perf-sched.sch_delay.max.ms.preempt_schedule_common._cond_resched.unmap_vmas.exit_mmap.mmput
      0.00       +2.8e+103%      28.39 ±241%  perf-sched.sch_delay.max.ms.preempt_schedule_common._cond_resched.unmap_vmas.unmap_region.__do_munmap
      0.00 ±223%  +4.8e+06%     161.29 ±101%  perf-sched.sch_delay.max.ms.preempt_schedule_common._cond_resched.wait_for_completion.stop_two_cpus.migrate_swap
      1440 ±221%     -19.4%       1161 ± 68%  perf-sched.sch_delay.max.ms.preempt_schedule_common._cond_resched.wait_for_unix_gc.unix_stream_sendmsg.sock_sendmsg
      0.01 ±223%  +91254.7%      13.25 ±129%  perf-sched.sch_delay.max.ms.preempt_schedule_common._cond_resched.wp_page_copy.do_wp_page.__handle_mm_fault
      4.55 ±223%      -9.2%       4.13 ±178%  perf-sched.sch_delay.max.ms.preempt_schedule_common._cond_resched.zap_pte_range.unmap_page_range.unmap_vmas
      1126 ±218%     -79.1%     235.73 ± 73%  perf-sched.sch_delay.max.ms.rcu_gp_kthread.kthread.ret_from_fork
      1.65 ±183%    -100.0%       0.00        perf-sched.sch_delay.max.ms.rwsem_down_read_slowpath.page_lock_anon_vma_read.rmap_walk_anon.try_to_unmap
      1391 ±223%     -99.9%       1.45 ±244%  perf-sched.sch_delay.max.ms.rwsem_down_read_slowpath.rmap_walk_anon.remove_migration_ptes.migrate_pages
      0.00       +3.5e+101%       0.35 ±244%  perf-sched.sch_delay.max.ms.rwsem_down_write_slowpath.__put_anon_vma.unlink_anon_vmas.free_pgtables
      0.00       +3.1e+102%       3.06 ±220%  perf-sched.sch_delay.max.ms.rwsem_down_write_slowpath.unlink_anon_vmas.free_pgtables.exit_mmap
      0.02 ± 33%   +5481.7%       1.16 ±226%  perf-sched.sch_delay.max.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      0.05 ± 84%    +930.6%       0.51 ±234%  perf-sched.sch_delay.max.ms.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop.0.do_select
      0.45 ±222%  +1.9e+05%     866.79 ±156%  perf-sched.sch_delay.max.ms.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop.0.do_sys_poll
      2751 ± 74%     -79.3%     570.30 ± 38%  perf-sched.sch_delay.max.ms.schedule_timeout.rcu_gp_kthread.kthread.ret_from_fork
     10579 ± 44%     -70.6%       3111 ± 40%  perf-sched.sch_delay.max.ms.schedule_timeout.sock_alloc_send_pskb.unix_stream_sendmsg.sock_sendmsg
     13678 ± 15%     -81.0%       2603 ± 44%  perf-sched.sch_delay.max.ms.schedule_timeout.unix_stream_read_generic.unix_stream_recvmsg.sock_read_iter
      0.02 ± 28%    +7e+06%       1268 ± 70%  perf-sched.sch_delay.max.ms.smpboot_thread_fn.kthread.ret_from_fork
      2680 ±223%    +146.5%       6608 ± 20%  perf-sched.sch_delay.max.ms.worker_thread.kthread.ret_from_fork
      8.83 ±  9%     -47.5%       4.63 ± 16%  perf-sched.total_sch_delay.average.ms
     14149 ± 14%     -53.3%       6608 ± 20%  perf-sched.total_sch_delay.max.ms
     34.79 ±  9%     -47.9%      18.12 ± 15%  perf-sched.total_wait_and_delay.average.ms
   1206311 ± 41%    +158.4%    3117388 ± 13%  perf-sched.total_wait_and_delay.count.ms
     28489 ± 15%     -51.4%      13844 ± 12%  perf-sched.total_wait_and_delay.max.ms
     25.96 ± 10%     -48.1%      13.48 ± 15%  perf-sched.total_wait_time.average.ms
     14700 ± 19%     -35.6%       9470 ±  9%  perf-sched.total_wait_time.max.ms
      0.00       +2.4e+105%       2432 ± 66%  perf-sched.wait_and_delay.avg.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
    278.27 ±223%    +449.8%       1529 ± 83%  perf-sched.wait_and_delay.avg.ms.do_nanosleep.hrtimer_nanosleep.__x64_sys_nanosleep.do_syscall_64
     93.48 ±186%     +57.2%     147.00 ± 38%  perf-sched.wait_and_delay.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
    631.80 ±223%     -64.4%     225.22 ± 34%  perf-sched.wait_and_delay.avg.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
    166.75 ± 56%     -39.9%     100.29 ± 31%  perf-sched.wait_and_delay.avg.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
      0.00       +5.9e+102%       5.91 ±244%  perf-sched.wait_and_delay.avg.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_call_function_single.[unknown]
     45.07 ±124%     -37.7%      28.08 ± 42%  perf-sched.wait_and_delay.avg.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown]
     20.05 ± 40%     -34.2%      13.19 ± 15%  perf-sched.wait_and_delay.avg.ms.exit_to_user_mode_prepare.syscall_exit_to_user_mode.entry_SYSCALL_64_after_hwframe.[unknown]
      0.00       +5.1e+102%       5.13 ±244%  perf-sched.wait_and_delay.avg.ms.exit_to_user_mode_prepare.syscall_exit_to_user_mode.ret_from_fork.[unknown]
      0.00       +7.8e+102%       7.80 ±244%  perf-sched.wait_and_delay.avg.ms.io_schedule.__lock_page_killable.filemap_fault.__do_fault
     44.41 ±223%    +182.3%     125.34 ± 26%  perf-sched.wait_and_delay.avg.ms.pipe_read.new_sync_read.vfs_read.ksys_read
      0.00       +7.7e+102%       7.71 ±244%  perf-sched.wait_and_delay.avg.ms.preempt_schedule_common._cond_resched.__do_fault.do_fault.__handle_mm_fault
    100.55 ± 33%     -74.1%      26.07 ± 27%  perf-sched.wait_and_delay.avg.ms.preempt_schedule_common._cond_resched.__kmalloc_node_track_caller.__kmalloc_reserve.isra
     65.08 ± 76%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.preempt_schedule_common._cond_resched.aa_sk_perm.security_socket_recvmsg.sock_recvmsg
    133.45 ± 98%     -75.6%      32.53 ± 20%  perf-sched.wait_and_delay.avg.ms.preempt_schedule_common._cond_resched.aa_sk_perm.security_socket_sendmsg.sock_sendmsg
      0.00       +5.2e+102%       5.22 ±244%  perf-sched.wait_and_delay.avg.ms.preempt_schedule_common._cond_resched.apparmor_file_alloc_security.security_file_alloc.__alloc_file
      0.00       +2.7e+102%       2.70 ±244%  perf-sched.wait_and_delay.avg.ms.preempt_schedule_common._cond_resched.change_p4d_range.change_protection.change_prot_numa
      0.00       +1.1e+103%      11.23 ±244%  perf-sched.wait_and_delay.avg.ms.preempt_schedule_common._cond_resched.copy_page_range.dup_mmap.dup_mm
      0.00       +2.3e+103%      23.14 ±211%  perf-sched.wait_and_delay.avg.ms.preempt_schedule_common._cond_resched.copy_page_to_iter.pipe_read.new_sync_read
      0.00       +1.5e+104%     154.74 ±244%  perf-sched.wait_and_delay.avg.ms.preempt_schedule_common._cond_resched.copy_pte_range.copy_page_range.dup_mmap
      0.00         +3e+104%     298.68 ±158%  perf-sched.wait_and_delay.avg.ms.preempt_schedule_common._cond_resched.down_write.anon_vma_clone.anon_vma_fork
      0.00       +1.5e+104%     151.53 ±244%  perf-sched.wait_and_delay.avg.ms.preempt_schedule_common._cond_resched.down_write.anon_vma_fork.dup_mmap
      0.00       +4.7e+104%     471.23 ±244%  perf-sched.wait_and_delay.avg.ms.preempt_schedule_common._cond_resched.down_write.dup_mmap.dup_mm
      0.00       +7.2e+102%       7.23 ±244%  perf-sched.wait_and_delay.avg.ms.preempt_schedule_common._cond_resched.down_write.expand_downwards.find_extend_vma
      0.00       +2.8e+102%       2.77 ±244%  perf-sched.wait_and_delay.avg.ms.preempt_schedule_common._cond_resched.generic_file_buffered_read.new_sync_read.__kernel_read
      0.00       +1.2e+103%      12.49 ±244%  perf-sched.wait_and_delay.avg.ms.preempt_schedule_common._cond_resched.kmem_cache_alloc.copy_process._do_fork
      0.00       +4.2e+102%       4.20 ±244%  perf-sched.wait_and_delay.avg.ms.preempt_schedule_common._cond_resched.kmem_cache_alloc.prepare_creds.copy_creds
      0.00       +4.7e+102%       4.74 ±244%  perf-sched.wait_and_delay.avg.ms.preempt_schedule_common._cond_resched.kmem_cache_alloc.vm_area_alloc.alloc_bprm
     79.10 ± 41%     -49.8%      39.70 ± 21%  perf-sched.wait_and_delay.avg.ms.preempt_schedule_common._cond_resched.kmem_cache_alloc_node.__alloc_skb.alloc_skb_with_frags
      0.00       +5.9e+102%       5.86 ±244%  perf-sched.wait_and_delay.avg.ms.preempt_schedule_common._cond_resched.kmem_cache_alloc_trace.i40e_clean_adminq_subtask.i40e_service_task
      0.00       +1.5e+103%      14.56 ±244%  perf-sched.wait_and_delay.avg.ms.preempt_schedule_common._cond_resched.migrate_pages.migrate_misplaced_page.__handle_mm_fault
      0.00       +1.4e+103%      13.65 ±123%  perf-sched.wait_and_delay.avg.ms.preempt_schedule_common._cond_resched.mutex_lock.futex_exec_release.exec_mm_release
      0.00         +2e+103%      19.93 ±244%  perf-sched.wait_and_delay.avg.ms.preempt_schedule_common._cond_resched.mutex_lock.perf_event_exit_task.do_exit
     79.39 ± 81%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.preempt_schedule_common._cond_resched.mutex_lock.unix_stream_read_generic.unix_stream_recvmsg
      0.00       +2.7e+102%       2.70 ±244%  perf-sched.wait_and_delay.avg.ms.preempt_schedule_common._cond_resched.mutex_lock_interruptible.devkmsg_read.vfs_read
      0.00       +3.8e+103%      37.70 ±244%  perf-sched.wait_and_delay.avg.ms.preempt_schedule_common._cond_resched.put_files_struct.do_exit.do_group_exit
     30.71 ±168%     -83.7%       5.00 ±158%  perf-sched.wait_and_delay.avg.ms.preempt_schedule_common._cond_resched.rmap_walk_anon.remove_migration_ptes.migrate_pages
      0.00       +9.6e+102%       9.63 ±244%  perf-sched.wait_and_delay.avg.ms.preempt_schedule_common._cond_resched.rmap_walk_anon.try_to_unmap.migrate_pages
    100.76 ± 13%     -72.6%      27.63 ± 21%  perf-sched.wait_and_delay.avg.ms.preempt_schedule_common._cond_resched.stop_one_cpu.__set_cpus_allowed_ptr.sched_setaffinity
      0.00       +1.3e+104%     129.00 ± 92%  perf-sched.wait_and_delay.avg.ms.preempt_schedule_common._cond_resched.stop_one_cpu.migrate_task_to.task_numa_migrate
      0.00       +2.2e+102%       2.24 ±244%  perf-sched.wait_and_delay.avg.ms.preempt_schedule_common._cond_resched.stop_one_cpu.sched_exec.bprm_execve
      0.00         +6e+102%       6.02 ±160%  perf-sched.wait_and_delay.avg.ms.preempt_schedule_common._cond_resched.unix_stream_read_generic.unix_stream_recvmsg.sock_read_iter
      0.00       +9.6e+103%      96.24 ± 57%  perf-sched.wait_and_delay.avg.ms.preempt_schedule_common._cond_resched.wait_for_completion.stop_two_cpus.migrate_swap
     56.72 ±157%     -60.9%      22.20 ± 20%  perf-sched.wait_and_delay.avg.ms.preempt_schedule_common._cond_resched.wait_for_unix_gc.unix_stream_sendmsg.sock_sendmsg
      0.00       +5.3e+102%       5.25 ±244%  perf-sched.wait_and_delay.avg.ms.preempt_schedule_common._cond_resched.wp_page_copy.do_wp_page.__handle_mm_fault
    619.59 ±213%     -96.1%      24.28 ± 83%  perf-sched.wait_and_delay.avg.ms.rcu_gp_kthread.kthread.ret_from_fork
      1391 ±223%     -99.2%      11.51 ±244%  perf-sched.wait_and_delay.avg.ms.rwsem_down_read_slowpath.rmap_walk_anon.remove_migration_ptes.migrate_pages
      0.00       +7.8e+102%       7.81 ±244%  perf-sched.wait_and_delay.avg.ms.rwsem_down_write_slowpath.unlink_anon_vmas.free_pgtables.exit_mmap
     24.32 ±223%   +2500.4%     632.41 ± 67%  perf-sched.wait_and_delay.avg.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
    306.33 ±223%    +312.8%       1264 ± 13%  perf-sched.wait_and_delay.avg.ms.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop.0.do_sys_poll
      0.00       +4.6e+102%       4.58 ±244%  perf-sched.wait_and_delay.avg.ms.schedule_preempt_disabled.__mutex_lock.isra.0.pipe_write
    274.31 ± 69%     -96.4%       9.93 ± 87%  perf-sched.wait_and_delay.avg.ms.schedule_timeout.rcu_gp_kthread.kthread.ret_from_fork
    207.71 ± 54%     -53.9%      95.67 ± 24%  perf-sched.wait_and_delay.avg.ms.schedule_timeout.sock_alloc_send_pskb.unix_stream_sendmsg.sock_sendmsg
     40.57 ± 17%     -73.0%      10.95 ± 16%  perf-sched.wait_and_delay.avg.ms.schedule_timeout.unix_stream_read_generic.unix_stream_recvmsg.sock_read_iter
      0.00         +1e+103%      10.34 ±244%  perf-sched.wait_and_delay.avg.ms.schedule_timeout.wait_for_completion.stop_one_cpu.__set_cpus_allowed_ptr
      1016 ± 23%     +45.3%       1477 ± 24%  perf-sched.wait_and_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork
    673.69 ±151%    +144.7%       1648 ± 14%  perf-sched.wait_and_delay.avg.ms.worker_thread.kthread.ret_from_fork
      0.00       +4.3e+102%       4.29 ± 29%  perf-sched.wait_and_delay.count.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      0.50 ±223%    +642.9%       3.71 ± 18%  perf-sched.wait_and_delay.count.do_nanosleep.hrtimer_nanosleep.__x64_sys_nanosleep.do_syscall_64
      7.00 ±199%   +1224.5%      92.71 ± 15%  perf-sched.wait_and_delay.count.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      0.33 ±223%  +30285.7%     101.29 ± 12%  perf-sched.wait_and_delay.count.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
    352.67 ±163%    +419.8%       1833 ±112%  perf-sched.wait_and_delay.count.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
      0.00       +1.9e+103%      19.14 ±244%  perf-sched.wait_and_delay.count.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_call_function_single.[unknown]
     63.17 ±136%  +16487.0%      10477 ±111%  perf-sched.wait_and_delay.count.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown]
    363782 ± 11%     +66.4%     605427 ± 14%  perf-sched.wait_and_delay.count.exit_to_user_mode_prepare.syscall_exit_to_user_mode.entry_SYSCALL_64_after_hwframe.[unknown]
      0.00       +5.7e+101%       0.57 ±244%  perf-sched.wait_and_delay.count.exit_to_user_mode_prepare.syscall_exit_to_user_mode.ret_from_fork.[unknown]
      0.00       +1.4e+101%       0.14 ±244%  perf-sched.wait_and_delay.count.io_schedule.__lock_page_killable.filemap_fault.__do_fault
     42.17 ±223%   +2860.4%       1248 ± 28%  perf-sched.wait_and_delay.count.pipe_read.new_sync_read.vfs_read.ksys_read
      0.00       +1.4e+102%       1.43 ±244%  perf-sched.wait_and_delay.count.preempt_schedule_common._cond_resched.__do_fault.do_fault.__handle_mm_fault
      1021 ±103%   +5227.4%      54437 ± 19%  perf-sched.wait_and_delay.count.preempt_schedule_common._cond_resched.__kmalloc_node_track_caller.__kmalloc_reserve.isra
      3865 ±210%    -100.0%       0.00        perf-sched.wait_and_delay.count.preempt_schedule_common._cond_resched.aa_sk_perm.security_socket_recvmsg.sock_recvmsg
      1238 ±145%    +284.7%       4765 ± 25%  perf-sched.wait_and_delay.count.preempt_schedule_common._cond_resched.aa_sk_perm.security_socket_sendmsg.sock_sendmsg
      0.00       +1.4e+101%       0.14 ±244%  perf-sched.wait_and_delay.count.preempt_schedule_common._cond_resched.apparmor_file_alloc_security.security_file_alloc.__alloc_file
      0.00       +2.9e+101%       0.29 ±244%  perf-sched.wait_and_delay.count.preempt_schedule_common._cond_resched.change_p4d_range.change_protection.change_prot_numa
      0.00       +2.9e+101%       0.29 ±244%  perf-sched.wait_and_delay.count.preempt_schedule_common._cond_resched.copy_page_range.dup_mmap.dup_mm
      0.00       +2.9e+101%       0.29 ±158%  perf-sched.wait_and_delay.count.preempt_schedule_common._cond_resched.copy_page_to_iter.pipe_read.new_sync_read
      0.00       +1.4e+101%       0.14 ±244%  perf-sched.wait_and_delay.count.preempt_schedule_common._cond_resched.copy_pte_range.copy_page_range.dup_mmap
      0.00       +2.9e+101%       0.29 ±158%  perf-sched.wait_and_delay.count.preempt_schedule_common._cond_resched.down_write.anon_vma_clone.anon_vma_fork
      0.00       +1.4e+101%       0.14 ±244%  perf-sched.wait_and_delay.count.preempt_schedule_common._cond_resched.down_write.anon_vma_fork.dup_mmap
      0.00       +1.4e+101%       0.14 ±244%  perf-sched.wait_and_delay.count.preempt_schedule_common._cond_resched.down_write.dup_mmap.dup_mm
      0.00       +1.4e+101%       0.14 ±244%  perf-sched.wait_and_delay.count.preempt_schedule_common._cond_resched.down_write.expand_downwards.find_extend_vma
      0.00         +2e+102%       2.00 ±244%  perf-sched.wait_and_delay.count.preempt_schedule_common._cond_resched.generic_file_buffered_read.new_sync_read.__kernel_read
      0.00       +1.4e+101%       0.14 ±244%  perf-sched.wait_and_delay.count.preempt_schedule_common._cond_resched.kmem_cache_alloc.copy_process._do_fork
      0.00       +1.4e+101%       0.14 ±244%  perf-sched.wait_and_delay.count.preempt_schedule_common._cond_resched.kmem_cache_alloc.prepare_creds.copy_creds
      0.00       +1.1e+102%       1.14 ±244%  perf-sched.wait_and_delay.count.preempt_schedule_common._cond_resched.kmem_cache_alloc.vm_area_alloc.alloc_bprm
      1205 ±151%    +310.4%       4949 ± 22%  perf-sched.wait_and_delay.count.preempt_schedule_common._cond_resched.kmem_cache_alloc_node.__alloc_skb.alloc_skb_with_frags
      0.00       +1.4e+101%       0.14 ±244%  perf-sched.wait_and_delay.count.preempt_schedule_common._cond_resched.kmem_cache_alloc_trace.i40e_clean_adminq_subtask.i40e_service_task
      0.00       +1.4e+101%       0.14 ±244%  perf-sched.wait_and_delay.count.preempt_schedule_common._cond_resched.migrate_pages.migrate_misplaced_page.__handle_mm_fault
      0.00       +1.9e+102%       1.86 ±120%  perf-sched.wait_and_delay.count.preempt_schedule_common._cond_resched.mutex_lock.futex_exec_release.exec_mm_release
      0.00       +1.4e+101%       0.14 ±244%  perf-sched.wait_and_delay.count.preempt_schedule_common._cond_resched.mutex_lock.perf_event_exit_task.do_exit
     52.50 ± 94%    -100.0%       0.00        perf-sched.wait_and_delay.count.preempt_schedule_common._cond_resched.mutex_lock.unix_stream_read_generic.unix_stream_recvmsg
      0.00       +1.4e+101%       0.14 ±244%  perf-sched.wait_and_delay.count.preempt_schedule_common._cond_resched.mutex_lock_interruptible.devkmsg_read.vfs_read
      0.00       +5.7e+101%       0.57 ±244%  perf-sched.wait_and_delay.count.preempt_schedule_common._cond_resched.put_files_struct.do_exit.do_group_exit
     28.67 ±196%     -50.2%      14.29 ±158%  perf-sched.wait_and_delay.count.preempt_schedule_common._cond_resched.rmap_walk_anon.remove_migration_ptes.migrate_pages
      0.00       +2.9e+101%       0.29 ±244%  perf-sched.wait_and_delay.count.preempt_schedule_common._cond_resched.rmap_walk_anon.try_to_unmap.migrate_pages
    129.50 ± 40%    +188.6%     373.71 ± 24%  perf-sched.wait_and_delay.count.preempt_schedule_common._cond_resched.stop_one_cpu.__set_cpus_allowed_ptr.sched_setaffinity
      0.00       +1.2e+103%      11.57 ± 72%  perf-sched.wait_and_delay.count.preempt_schedule_common._cond_resched.stop_one_cpu.migrate_task_to.task_numa_migrate
      0.00       +5.6e+102%       5.57 ±244%  perf-sched.wait_and_delay.count.preempt_schedule_common._cond_resched.stop_one_cpu.sched_exec.bprm_execve
      0.00       +3.1e+103%      31.14 ±176%  perf-sched.wait_and_delay.count.preempt_schedule_common._cond_resched.unix_stream_read_generic.unix_stream_recvmsg.sock_read_iter
      0.00       +2.1e+103%      20.86 ± 57%  perf-sched.wait_and_delay.count.preempt_schedule_common._cond_resched.wait_for_completion.stop_two_cpus.migrate_swap
     37.83 ±141%   +2968.7%       1161 ± 16%  perf-sched.wait_and_delay.count.preempt_schedule_common._cond_resched.wait_for_unix_gc.unix_stream_sendmsg.sock_sendmsg
      0.00       +4.4e+102%       4.43 ±244%  perf-sched.wait_and_delay.count.preempt_schedule_common._cond_resched.wp_page_copy.do_wp_page.__handle_mm_fault
      2.17 ±104%   +1409.9%      32.71 ± 64%  perf-sched.wait_and_delay.count.rcu_gp_kthread.kthread.ret_from_fork
      0.33 ±223%     -57.1%       0.14 ±244%  perf-sched.wait_and_delay.count.rwsem_down_read_slowpath.rmap_walk_anon.remove_migration_ptes.migrate_pages
      0.00       +1.4e+101%       0.14 ±244%  perf-sched.wait_and_delay.count.rwsem_down_write_slowpath.unlink_anon_vmas.free_pgtables.exit_mmap
      0.33 ±223%   +2257.1%       7.86 ± 69%  perf-sched.wait_and_delay.count.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      1.00 ±223%   +1200.0%      13.00 ± 24%  perf-sched.wait_and_delay.count.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop.0.do_sys_poll
      0.00       +1.4e+101%       0.14 ±244%  perf-sched.wait_and_delay.count.schedule_preempt_disabled.__mutex_lock.isra.0.pipe_write
    119.50 ±146%    +286.8%     462.29 ± 87%  perf-sched.wait_and_delay.count.schedule_timeout.rcu_gp_kthread.kthread.ret_from_fork
     50185 ±203%    +346.7%     224180 ± 28%  perf-sched.wait_and_delay.count.schedule_timeout.sock_alloc_send_pskb.unix_stream_sendmsg.sock_sendmsg
    781334 ± 44%    +180.7%    2192815 ± 13%  perf-sched.wait_and_delay.count.schedule_timeout.unix_stream_read_generic.unix_stream_recvmsg.sock_read_iter
      0.00       +1.4e+101%       0.14 ±244%  perf-sched.wait_and_delay.count.schedule_timeout.wait_for_completion.stop_one_cpu.__set_cpus_allowed_ptr
    143.33 ± 47%    +310.9%     589.00 ± 23%  perf-sched.wait_and_delay.count.smpboot_thread_fn.kthread.ret_from_fork
     38.00 ±209%    +954.9%     400.86 ± 14%  perf-sched.wait_and_delay.count.worker_thread.kthread.ret_from_fork
      0.00       +5.9e+105%       5870 ± 51%  perf-sched.wait_and_delay.max.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
    834.81 ±223%    +363.1%       3866 ± 97%  perf-sched.wait_and_delay.max.ms.do_nanosleep.hrtimer_nanosleep.__x64_sys_nanosleep.do_syscall_64
    488.38 ±150%    +186.4%       1398 ± 46%  perf-sched.wait_and_delay.max.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      1263 ±223%    +374.0%       5989 ± 29%  perf-sched.wait_and_delay.max.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
     11002 ± 63%     -62.1%       4174 ± 61%  perf-sched.wait_and_delay.max.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
      0.00       +6.3e+104%     625.51 ±244%  perf-sched.wait_and_delay.max.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_call_function_single.[unknown]
      2652 ±109%     +52.9%       4054 ± 50%  perf-sched.wait_and_delay.max.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown]
     27463 ± 14%     -78.7%       5842 ± 39%  perf-sched.wait_and_delay.max.ms.exit_to_user_mode_prepare.syscall_exit_to_user_mode.entry_SYSCALL_64_after_hwframe.[unknown]
      0.00         +2e+103%      19.96 ±244%  perf-sched.wait_and_delay.max.ms.exit_to_user_mode_prepare.syscall_exit_to_user_mode.ret_from_fork.[unknown]
      0.00       +7.8e+102%       7.80 ±244%  perf-sched.wait_and_delay.max.ms.io_schedule.__lock_page_killable.filemap_fault.__do_fault
      2875 ±223%    +223.9%       9312 ± 14%  perf-sched.wait_and_delay.max.ms.pipe_read.new_sync_read.vfs_read.ksys_read
      0.00       +7.2e+103%      71.60 ±244%  perf-sched.wait_and_delay.max.ms.preempt_schedule_common._cond_resched.__do_fault.do_fault.__handle_mm_fault
     15294 ± 42%     -65.2%       5327 ± 36%  perf-sched.wait_and_delay.max.ms.preempt_schedule_common._cond_resched.__kmalloc_node_track_caller.__kmalloc_reserve.isra
     10354 ± 70%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.preempt_schedule_common._cond_resched.aa_sk_perm.security_socket_recvmsg.sock_recvmsg
     13849 ± 64%     -75.2%       3440 ± 23%  perf-sched.wait_and_delay.max.ms.preempt_schedule_common._cond_resched.aa_sk_perm.security_socket_sendmsg.sock_sendmsg
      0.00       +5.2e+102%       5.22 ±244%  perf-sched.wait_and_delay.max.ms.preempt_schedule_common._cond_resched.apparmor_file_alloc_security.security_file_alloc.__alloc_file
      0.00       +5.4e+102%       5.39 ±244%  perf-sched.wait_and_delay.max.ms.preempt_schedule_common._cond_resched.change_p4d_range.change_protection.change_prot_numa
      0.00       +1.6e+103%      15.84 ±244%  perf-sched.wait_and_delay.max.ms.preempt_schedule_common._cond_resched.copy_page_range.dup_mmap.dup_mm
      0.00       +2.3e+103%      23.14 ±211%  perf-sched.wait_and_delay.max.ms.preempt_schedule_common._cond_resched.copy_page_to_iter.pipe_read.new_sync_read
      0.00       +1.5e+104%     154.74 ±244%  perf-sched.wait_and_delay.max.ms.preempt_schedule_common._cond_resched.copy_pte_range.copy_page_range.dup_mmap
      0.00         +3e+104%     298.68 ±158%  perf-sched.wait_and_delay.max.ms.preempt_schedule_common._cond_resched.down_write.anon_vma_clone.anon_vma_fork
      0.00       +1.5e+104%     151.53 ±244%  perf-sched.wait_and_delay.max.ms.preempt_schedule_common._cond_resched.down_write.anon_vma_fork.dup_mmap
      0.00       +4.7e+104%     471.23 ±244%  perf-sched.wait_and_delay.max.ms.preempt_schedule_common._cond_resched.down_write.dup_mmap.dup_mm
      0.00       +7.2e+102%       7.23 ±244%  perf-sched.wait_and_delay.max.ms.preempt_schedule_common._cond_resched.down_write.expand_downwards.find_extend_vma
      0.00       +1.8e+103%      18.17 ±244%  perf-sched.wait_and_delay.max.ms.preempt_schedule_common._cond_resched.generic_file_buffered_read.new_sync_read.__kernel_read
      0.00       +1.2e+103%      12.49 ±244%  perf-sched.wait_and_delay.max.ms.preempt_schedule_common._cond_resched.kmem_cache_alloc.copy_process._do_fork
      0.00       +4.2e+102%       4.20 ±244%  perf-sched.wait_and_delay.max.ms.preempt_schedule_common._cond_resched.kmem_cache_alloc.prepare_creds.copy_creds
      0.00         +2e+103%      19.65 ±244%  perf-sched.wait_and_delay.max.ms.preempt_schedule_common._cond_resched.kmem_cache_alloc.vm_area_alloc.alloc_bprm
     13634 ± 43%     -70.3%       4046 ± 43%  perf-sched.wait_and_delay.max.ms.preempt_schedule_common._cond_resched.kmem_cache_alloc_node.__alloc_skb.alloc_skb_with_frags
      0.00       +5.9e+102%       5.86 ±244%  perf-sched.wait_and_delay.max.ms.preempt_schedule_common._cond_resched.kmem_cache_alloc_trace.i40e_clean_adminq_subtask.i40e_service_task
      0.00       +1.5e+103%      14.56 ±244%  perf-sched.wait_and_delay.max.ms.preempt_schedule_common._cond_resched.migrate_pages.migrate_misplaced_page.__handle_mm_fault
      0.00       +4.9e+103%      48.94 ±122%  perf-sched.wait_and_delay.max.ms.preempt_schedule_common._cond_resched.mutex_lock.futex_exec_release.exec_mm_release
      0.00         +2e+103%      19.93 ±244%  perf-sched.wait_and_delay.max.ms.preempt_schedule_common._cond_resched.mutex_lock.perf_event_exit_task.do_exit
      4416 ± 81%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.preempt_schedule_common._cond_resched.mutex_lock.unix_stream_read_generic.unix_stream_recvmsg
      0.00       +2.7e+102%       2.70 ±244%  perf-sched.wait_and_delay.max.ms.preempt_schedule_common._cond_resched.mutex_lock_interruptible.devkmsg_read.vfs_read
      0.00       +1.5e+104%     150.73 ±244%  perf-sched.wait_and_delay.max.ms.preempt_schedule_common._cond_resched.put_files_struct.do_exit.do_group_exit
      2175 ±207%     -94.6%     116.77 ±161%  perf-sched.wait_and_delay.max.ms.preempt_schedule_common._cond_resched.rmap_walk_anon.remove_migration_ptes.migrate_pages
      0.00       +1.1e+103%      10.54 ±244%  perf-sched.wait_and_delay.max.ms.preempt_schedule_common._cond_resched.rmap_walk_anon.try_to_unmap.migrate_pages
      3356 ± 20%     -55.8%       1483 ± 21%  perf-sched.wait_and_delay.max.ms.preempt_schedule_common._cond_resched.stop_one_cpu.__set_cpus_allowed_ptr.sched_setaffinity
      0.00         +5e+104%     496.77 ±106%  perf-sched.wait_and_delay.max.ms.preempt_schedule_common._cond_resched.stop_one_cpu.migrate_task_to.task_numa_migrate
      0.00       +2.7e+103%      26.51 ±244%  perf-sched.wait_and_delay.max.ms.preempt_schedule_common._cond_resched.stop_one_cpu.sched_exec.bprm_execve
      0.00       +1.9e+104%     194.49 ±161%  perf-sched.wait_and_delay.max.ms.preempt_schedule_common._cond_resched.unix_stream_read_generic.unix_stream_recvmsg.sock_read_iter
      0.00       +6.5e+104%     649.33 ± 64%  perf-sched.wait_and_delay.max.ms.preempt_schedule_common._cond_resched.wait_for_completion.stop_two_cpus.migrate_swap
      3766 ±141%     -26.3%       2777 ± 55%  perf-sched.wait_and_delay.max.ms.preempt_schedule_common._cond_resched.wait_for_unix_gc.unix_stream_sendmsg.sock_sendmsg
      0.00       +1.5e+104%     149.08 ±244%  perf-sched.wait_and_delay.max.ms.preempt_schedule_common._cond_resched.wp_page_copy.do_wp_page.__handle_mm_fault
      2404 ±213%     -81.2%     451.29 ± 87%  perf-sched.wait_and_delay.max.ms.rcu_gp_kthread.kthread.ret_from_fork
      2783 ±223%     -99.6%      11.51 ±244%  perf-sched.wait_and_delay.max.ms.rwsem_down_read_slowpath.rmap_walk_anon.remove_migration_ptes.migrate_pages
      0.00       +7.8e+102%       7.81 ±244%  perf-sched.wait_and_delay.max.ms.rwsem_down_write_slowpath.unlink_anon_vmas.free_pgtables.exit_mmap
     48.64 ±223%   +3277.6%       1642 ± 68%  perf-sched.wait_and_delay.max.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      1336 ±223%    +307.9%       5449 ± 27%  perf-sched.wait_and_delay.max.ms.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop.0.do_sys_poll
      0.00       +4.6e+102%       4.58 ±244%  perf-sched.wait_and_delay.max.ms.schedule_preempt_disabled.__mutex_lock.isra.0.pipe_write
      6832 ± 56%     -88.4%     794.98 ± 99%  perf-sched.wait_and_delay.max.ms.schedule_timeout.rcu_gp_kthread.kthread.ret_from_fork
     22053 ± 39%     -71.0%       6385 ± 38%  perf-sched.wait_and_delay.max.ms.schedule_timeout.sock_alloc_send_pskb.unix_stream_sendmsg.sock_sendmsg
     27383 ± 15%     -80.6%       5307 ± 42%  perf-sched.wait_and_delay.max.ms.schedule_timeout.unix_stream_read_generic.unix_stream_recvmsg.sock_read_iter
      0.00         +1e+103%      10.34 ±244%  perf-sched.wait_and_delay.max.ms.schedule_timeout.wait_for_completion.stop_one_cpu.__set_cpus_allowed_ptr
     13875 ± 17%     -33.5%       9231 ± 15%  perf-sched.wait_and_delay.max.ms.smpboot_thread_fn.kthread.ret_from_fork
      8744 ±154%     +54.8%      13537 ± 16%  perf-sched.wait_and_delay.max.ms.worker_thread.kthread.ret_from_fork
      0.00       +2.1e+105%       2144 ± 48%  perf-sched.wait_time.avg.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
    278.27 ±223%    +367.8%       1301 ± 66%  perf-sched.wait_time.avg.ms.do_nanosleep.hrtimer_nanosleep.__x64_sys_nanosleep.do_syscall_64
     92.95 ±186%      +8.5%     100.81 ± 49%  perf-sched.wait_time.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
    636.80 ±221%     -72.8%     173.00 ± 39%  perf-sched.wait_time.avg.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      0.31 ±166%    +622.7%       2.26 ±155%  perf-sched.wait_time.avg.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_exc_page_fault.[unknown]
    130.41 ± 65%     -39.4%      78.98 ± 30%  perf-sched.wait_time.avg.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
      0.76 ±106%   +1019.0%       8.46 ± 77%  perf-sched.wait_time.avg.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_call_function_single.[unknown]
     53.73 ± 90%     -63.0%      19.87 ± 41%  perf-sched.wait_time.avg.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown]
     17.34 ± 30%     -43.2%       9.84 ± 15%  perf-sched.wait_time.avg.ms.exit_to_user_mode_prepare.syscall_exit_to_user_mode.entry_SYSCALL_64_after_hwframe.[unknown]
      0.00 ±223%    +290.5%       0.01 ±115%  perf-sched.wait_time.avg.ms.exit_to_user_mode_prepare.syscall_exit_to_user_mode.ret_from_fork.[unknown]
     49.24 ±197%    +113.5%     105.13 ± 26%  perf-sched.wait_time.avg.ms.pipe_read.new_sync_read.vfs_read.ksys_read
      0.95 ±186%    +287.8%       3.70 ± 64%  perf-sched.wait_time.avg.ms.pipe_wait.wait_for_partner.fifo_open.do_dentry_open
      0.00        +6.4e+99%       0.01 ±158%  perf-sched.wait_time.avg.ms.pipe_write.new_sync_write.vfs_write.ksys_write
      0.00       +3.9e+100%       0.04 ± 82%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.__alloc_pages_nodemask.__get_free_pages.__pud_alloc
      0.01 ±223%    +548.3%       0.06 ±130%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.__alloc_pages_nodemask.__get_free_pages.pgd_alloc
      0.00       +1.5e+100%       0.02 ±126%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.__alloc_pages_nodemask.__get_free_pages.proc_pid_readlink
      0.00       +1.3e+101%       0.13 ±115%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.__alloc_pages_nodemask.__pmd_alloc.__handle_mm_fault
      0.00       +7.2e+101%       0.72 ±229%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.__alloc_pages_nodemask.__pmd_alloc.move_page_tables
      0.00       +2.7e+101%       0.27 ±209%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.__alloc_pages_nodemask.alloc_pages_vma.do_anonymous_page
      0.00 ±223%   +1623.3%       0.05 ±190%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.__alloc_pages_nodemask.alloc_pages_vma.do_fault
      5.70 ±125%     -23.2%       4.38 ± 62%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.__alloc_pages_nodemask.alloc_pages_vma.shmem_alloc_page
      0.02 ±115%   +4431.9%       0.83 ±237%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.__alloc_pages_nodemask.alloc_pages_vma.wp_page_copy
      0.00       +7.6e+101%       0.76 ±242%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.__alloc_pages_nodemask.pte_alloc_one.__do_fault
      0.09 ±213%    +171.9%       0.26 ±152%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.__alloc_pages_nodemask.pte_alloc_one.__pte_alloc
      0.00       +3.5e+100%       0.03 ±232%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.__alloc_pages_nodemask.pte_alloc_one.do_fault
      0.03 ±175%   +1265.9%       0.39 ±216%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.__anon_vma_prepare.do_anonymous_page.__handle_mm_fault
      0.00       +1.3e+102%       1.26 ±238%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.__anon_vma_prepare.do_fault.__handle_mm_fault
      0.34 ±193%   +3325.3%      11.62 ±153%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.__do_fault.do_fault.__handle_mm_fault
      0.05 ±223%     -11.5%       0.04 ± 75%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.__fput.task_work_run.exit_to_user_mode_prepare
      0.05 ±190%    +840.7%       0.43 ±221%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.__get_user_pages.__get_user_pages_remote.get_arg_page
      0.00          +2e+99%       0.00 ±244%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.__kmalloc.alloc_pipe_info.create_pipe_files
      0.01 ±100%     -60.9%       0.00 ±173%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.__kmalloc.inotify_handle_event.fsnotify
      0.00         +4e+100%       0.04 ± 74%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.__kmalloc.load_elf_binary.exec_binprm
      0.02 ±171%   +3548.7%       0.58 ±218%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.__kmalloc.load_elf_phdrs.load_elf_binary
      0.01 ±223%    +702.6%       0.04 ± 65%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.__kmalloc.security_prepare_creds.prepare_creds
      0.00 ±223%    +514.3%       0.01 ±244%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.__kmalloc_node.alloc_cpumask_var_node.sched_setaffinity
      0.00        +1.9e+99%       0.00 ±244%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.__kmalloc_node.memcg_alloc_page_obj_cgroups.kmem_cache_alloc
      0.00       +1.5e+100%       0.01 ±141%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.__kmalloc_node.seq_read.vfs_read
     91.71 ± 30%     -77.9%      20.26 ± 26%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.__kmalloc_node_track_caller.__kmalloc_reserve.isra
      0.03 ±200%   +2370.1%       0.70 ±166%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.__put_anon_vma.unlink_anon_vmas.free_pgtables
      0.00       +1.4e+100%       0.01 ± 78%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.__sb_start_write.mnt_want_write.filename_create
      0.00        +8.3e+99%       0.01 ±158%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.__sb_start_write.vfs_write.ksys_write
      0.00 ±223%   +1365.3%       0.05 ± 60%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.__split_huge_pud.__handle_mm_fault.handle_mm_fault
     44.59 ± 55%     -77.2%      10.16 ± 18%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.aa_sk_perm.security_socket_recvmsg.sock_recvmsg
    112.90 ± 90%     -77.5%      25.39 ± 19%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.aa_sk_perm.security_socket_sendmsg.sock_sendmsg
      0.00 ±223%   +1066.7%       0.03 ±106%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.apparmor_file_alloc_security.security_file_alloc.__alloc_file
      1.16 ±191%    +363.2%       5.35 ±139%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.change_p4d_range.change_protection.change_prot_numa
      0.03 ±161%    +106.8%       0.06 ± 59%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.change_p4d_range.change_protection.mprotect_fixup
      0.00       +2.1e+100%       0.02 ± 74%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.copy_page_from_iter.pipe_write.new_sync_write
      0.00       +1.1e+103%      11.23 ±244%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.copy_page_range.dup_mmap.dup_mm
      0.00         +1e+100%       0.01 ± 93%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.copy_page_to_iter.generic_file_buffered_read.new_sync_read
      0.00       +2.1e+103%      20.80 ±225%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.copy_page_to_iter.pipe_read.new_sync_read
      0.00       +1.6e+104%     155.63 ±243%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.copy_pte_range.copy_page_range.dup_mmap
      0.02 ±109%    +453.3%       0.09 ±127%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.copy_strings.isra.0
      0.08 ±187%   +1477.7%       1.24 ±233%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.count.isra.0
      2.93 ±129%     +10.4%       3.23 ±103%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      0.01 ±223%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.down_read.__do_sys_newuname.do_syscall_64
      0.00        +9.7e+99%       0.01 ±151%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.down_read.acct_collect.do_exit
      0.00       +1.7e+100%       0.02 ±212%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.down_read.do_exit.do_group_exit
      0.02 ±223%   +8547.3%       2.00 ±235%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.down_read.path_openat.do_filp_open
      0.36 ±219%    +293.7%       1.40 ±228%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.down_read.rmap_walk_anon.remove_migration_ptes
      0.11 ±172%     -45.5%       0.06 ± 32%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.down_read.walk_component.link_path_walk
      0.01 ±176%   +1767.2%       0.16 ±163%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.down_read.walk_component.path_lookupat
      0.00       +2.3e+100%       0.02 ±171%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.down_read_killable.m_start.seq_read
      0.00       +4.8e+100%       0.05 ± 69%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.down_write.__anon_vma_prepare.do_anonymous_page
      0.00       +4.2e+100%       0.04 ± 90%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.down_write.__anon_vma_prepare.do_fault
      0.00        +7.6e+99%       0.01 ±244%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.down_write.__anon_vma_prepare.wp_page_copy
      0.01 ±157%   +8253.7%       0.52 ±219%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.down_write.__vma_adjust.__split_vma
      0.00       +7.4e+100%       0.07 ± 56%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.down_write.__vma_adjust.shift_arg_pages
      0.00       +4.9e+100%       0.05 ± 87%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.down_write.__vma_adjust.vma_merge
      0.02 ±223%   +7126.0%       1.31 ±229%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.down_write.anon_vma_clone.__split_vma
      0.00         +3e+104%     298.67 ±158%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.down_write.anon_vma_clone.anon_vma_fork
      0.00       +1.5e+104%     153.29 ±241%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.down_write.anon_vma_fork.dup_mmap
      0.00       +3.1e+104%     308.50 ±244%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.down_write.dup_mmap.dup_mm
      0.00       +7.2e+102%       7.24 ±244%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.down_write.expand_downwards.find_extend_vma
      0.00          +5e+99%       0.01 ±244%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.down_write.expand_downwards.setup_arg_pages
      0.00        +6.1e+99%       0.01 ±167%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.down_write.generic_file_write_iter.new_sync_write
      0.03 ±199%   +3085.8%       0.85 ±169%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.down_write.unlink_anon_vmas.free_pgtables
      1.12 ±209%     -63.3%       0.41 ± 82%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.down_write.unlink_file_vma.free_pgtables
      0.00 ±223%  +15500.0%       0.31 ±157%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.down_write.vma_link.mmap_region
      0.00          +9e+99%       0.01 ±145%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.down_write_killable.__vm_munmap.__x64_sys_munmap
      0.00       +4.8e+100%       0.05 ±165%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.down_write_killable.__vm_munmap.elf_map
      0.00       +7.6e+101%       0.76 ±244%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.down_write_killable.__x64_sys_brk.do_syscall_64
      0.00         +3e+100%       0.03 ±106%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.down_write_killable.alloc_bprm.do_execveat_common
      0.00 ±223%    +640.3%       0.01 ±119%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.down_write_killable.do_mprotect_pkey.__x64_sys_mprotect
      3.32 ±223%     -95.5%       0.15 ±165%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.down_write_killable.map_vdso.load_elf_binary
      0.02 ±142%   +2729.5%       0.45 ±190%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.down_write_killable.setup_arg_pages.load_elf_binary
      0.00       +2.2e+101%       0.22 ±183%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.down_write_killable.vm_brk_flags.load_elf_interp
      0.00       +1.6e+100%       0.02 ±116%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.down_write_killable.vm_brk_flags.set_brk
      0.01 ±119%    +791.9%       0.12 ± 79%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.down_write_killable.vm_mmap_pgoff.elf_map
      0.00 ±223%   +2138.7%       0.06 ± 69%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.down_write_killable.vm_mmap_pgoff.ksys_mmap_pgoff
      0.57 ±171%    +242.7%       1.96 ± 85%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.dput.__fput.task_work_run
      0.00       +1.4e+100%       0.01 ±244%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.dput.filename_create.do_mkdirat
      0.00 ±223%  +25001.1%       0.54 ±184%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.dput.nd_jump_root.pick_link
      0.09 ±210%   +1030.3%       0.99 ±229%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.dput.path_openat.do_filp_open
      0.00       +1.3e+100%       0.01 ± 76%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.dput.path_put.free_fs_struct
      0.00       +1.8e+100%       0.02 ±187%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.dput.path_put.proc_pid_readlink
      0.00        +6.7e+99%       0.01 ±166%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.dput.path_put.set_fs_pwd
      0.00 ±223%   +1001.1%       0.02 ±130%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.dput.path_put.vfs_statx
      0.00 ±223%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.dput.step_into.handle_dots
      0.00 ±223%   +2284.4%       0.04 ± 74%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.dput.step_into.path_openat
      0.09 ±159%    +350.4%       0.40 ±104%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.dput.step_into.walk_component
      0.00        +4.6e+99%       0.00 ±158%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.dput.terminate_walk.path_lookupat
      0.05 ±140%   +1420.2%       0.73 ±146%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.dput.terminate_walk.path_openat
      0.00       +5.3e+100%       0.05 ±143%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.dput.walk_component.link_path_walk
      0.00       +2.4e+101%       0.24 ±102%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.exit_mmap.mmput.begin_new_exec
      0.09 ±215%    +270.5%       0.33 ±205%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.exit_mmap.mmput.do_exit
      0.00       +1.5e+100%       0.01 ± 98%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.exit_signals.do_exit.do_group_exit
      0.00          +7e+99%       0.01 ±163%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.find_lock_entry.shmem_getpage_gfp.shmem_write_begin
      0.00 ±141%  +36334.9%       1.64 ±216%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.generic_file_buffered_read.new_sync_read.__kernel_read
      4.61 ±202%     -26.0%       3.41 ± 30%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.generic_perform_write.__generic_file_write_iter.generic_file_write_iter
      0.00       +8.4e+101%       0.84 ±158%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.khugepaged.kthread.ret_from_fork
      0.05 ±170%   +2355.3%       1.24 ±234%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.kmem_cache_alloc.__alloc_file.alloc_empty_file
      0.00 ±223%  +26985.7%       0.77 ±226%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.kmem_cache_alloc.__anon_vma_prepare.do_anonymous_page
      0.00       +6.1e+100%       0.06 ± 71%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.kmem_cache_alloc.__anon_vma_prepare.do_fault
      0.00       +1.4e+100%       0.01 ± 88%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.kmem_cache_alloc.__anon_vma_prepare.wp_page_copy
      0.00 ±223%  +25837.1%       0.43 ±214%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.kmem_cache_alloc.__d_alloc.d_alloc
      0.00       +2.5e+100%       0.03 ±135%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.kmem_cache_alloc.__d_alloc.d_alloc_cursor
      0.00        +1.9e+99%       0.00 ±244%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.kmem_cache_alloc.__delayacct_tsk_init.copy_process
      0.00       +1.2e+103%      12.49 ±244%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.kmem_cache_alloc.copy_process._do_fork
      0.00       +1.1e+100%       0.01 ±157%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.kmem_cache_alloc.getname_flags.__x64_sys_execve
      0.00        +2.7e+99%       0.00 ±244%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.kmem_cache_alloc.getname_flags.do_mkdirat
      0.01 ±154%    +625.4%       0.05 ±100%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.kmem_cache_alloc.getname_flags.do_sys_openat2
      0.00       +9.7e+101%       0.97 ±194%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.kmem_cache_alloc.getname_flags.user_path_at_empty
      0.00       +1.6e+102%       1.56 ±243%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.kmem_cache_alloc.getname_kernel.open_exec
      0.00        +4.7e+99%       0.00 ±166%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.kmem_cache_alloc.mm_alloc.alloc_bprm
      0.00       +2.6e+102%       2.64 ±244%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.kmem_cache_alloc.prepare_creds.copy_creds
      0.00          +4e+99%       0.00 ±166%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.kmem_cache_alloc.prepare_creds.do_faccessat
      0.00       +4.8e+100%       0.05 ±190%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.kmem_cache_alloc.prepare_creds.prepare_exec_creds
      0.00       +2.7e+102%       2.73 ±212%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.kmem_cache_alloc.proc_alloc_inode.alloc_inode
      0.02 ±193%   +2326.3%       0.61 ±115%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.kmem_cache_alloc.security_file_alloc.__alloc_file
      0.00        +3.3e+99%       0.00 ±244%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.kmem_cache_alloc.seq_open.__seq_open_private
      0.00        +3.3e+99%       0.00 ±244%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.kmem_cache_alloc.seq_open.kernfs_fop_open
      0.00        +2.7e+99%       0.00 ±244%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.kmem_cache_alloc.seq_open.proc_reg_open
      0.00        +3.9e+99%       0.00 ±244%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.kmem_cache_alloc.seq_open.single_open
      0.04 ±223%   +1201.0%       0.51 ±228%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.kmem_cache_alloc.vm_area_alloc.__install_special_mapping
      0.00 ±223%   +1271.4%       0.03 ± 38%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.kmem_cache_alloc.vm_area_alloc.alloc_bprm
      0.00       +2.8e+101%       0.28 ±196%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.kmem_cache_alloc.vm_area_alloc.do_brk_flags
      0.10 ±177%   +1195.9%       1.25 ±182%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.kmem_cache_alloc.vm_area_alloc.mmap_region
      0.00 ±141%  +41917.1%       1.75 ±208%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.kmem_cache_alloc.vm_area_dup.__split_vma
     74.95 ± 46%     -59.3%      30.52 ± 21%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.kmem_cache_alloc_node.__alloc_skb.alloc_skb_with_frags
      0.00       +1.4e+100%       0.01 ± 55%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.kmem_cache_alloc_trace.alloc_bprm.do_execveat_common
      0.00        +2.4e+99%       0.00 ±244%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.kmem_cache_alloc_trace.alloc_pipe_info.create_pipe_files
      0.00       +6.6e+100%       0.07 ±222%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.kmem_cache_alloc_trace.disk_seqf_start.seq_read
      0.00       +5.9e+102%       5.85 ±244%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.kmem_cache_alloc_trace.i40e_clean_adminq_subtask.i40e_service_task
      0.00       +1.1e+101%       0.11 ±172%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.kmem_cache_alloc_trace.load_elf_binary.exec_binprm
      0.03 ±162%     +27.7%       0.04 ± 41%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.kmem_cache_alloc_trace.perf_event_mmap.mmap_region
      0.00 ±223%   +1082.9%       0.02 ±190%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.kmem_cache_alloc_trace.perf_event_mmap.mprotect_fixup
      0.00        +9.3e+99%       0.01 ±244%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.kmem_cache_alloc_trace.vmstat_start.seq_read
      0.00        +3.1e+99%       0.00 ±244%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.migrate_page_copy.migrate_misplaced_transhuge_page.do_huge_pmd_numa_page
      0.00       +7.9e+102%       7.90 ±241%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.migrate_pages.migrate_misplaced_page.__handle_mm_fault
      0.00       +6.6e+101%       0.66 ±214%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.mmput.begin_new_exec.load_elf_binary
      0.00         +2e+100%       0.02 ±125%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.mmput.do_exit.do_group_exit
      0.00       +1.8e+100%       0.02 ± 70%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.mmput.m_stop.seq_read
      0.00       +2.2e+100%       0.02 ±179%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.move_page_tables.shift_arg_pages.setup_arg_pages
      0.00        +5.7e+99%       0.01 ±244%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.mutex_lock.__fdget_pos.ksys_write
      0.00 ±223%   +3594.3%       0.06 ±244%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.mutex_lock.__perf_event_read_value.perf_read
      0.09 ±223%     -88.5%       0.01 ±134%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.mutex_lock.fifo_open.do_dentry_open
      0.28 ±223%   +1469.1%       4.45 ±179%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.mutex_lock.futex_exec_release.exec_mm_release
      0.02 ±223%     +47.5%       0.03 ±192%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.mutex_lock.futex_exit_release.exit_mm_release
      0.00        +3.3e+99%       0.00 ±244%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.mutex_lock.kernfs_dop_revalidate.lookup_fast
      0.00        +9.9e+99%       0.01 ±132%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.mutex_lock.kernfs_fop_open.do_dentry_open
      0.00          +4e+99%       0.00 ±244%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.mutex_lock.kernfs_iop_getattr.vfs_statx_fd
      0.00        +4.3e+99%       0.00 ±169%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.mutex_lock.kernfs_iop_permission.inode_permission
      0.00        +1.1e+99%       0.00 ±244%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.mutex_lock.kernfs_put_open_node.isra
      0.00       +2.9e+100%       0.03 ± 95%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.mutex_lock.kernfs_seq_start.seq_read
      0.01 ±223%  +13262.0%       1.63 ±156%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.mutex_lock.perf_event_ctx_lock_nested.isra
      0.04 ±223%     -28.1%       0.03 ±244%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.mutex_lock.perf_event_for_each_child._perf_ioctl
      0.69 ±223%     -97.3%       0.02 ±206%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.mutex_lock.perf_read.vfs_read
      0.00 ±150%   +1606.8%       0.07 ±125%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.mutex_lock.pipe_write.new_sync_write
      0.00       +1.4e+100%       0.01 ±166%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.mutex_lock.slab_start.seq_read
     72.70 ± 71%     -87.0%       9.48 ± 18%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.mutex_lock.unix_stream_read_generic.unix_stream_recvmsg
      0.00       +1.8e+101%       0.18 ±236%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.mutex_lock.uprobe_clear_state.mmput
      0.00       +1.2e+100%       0.01 ± 90%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.mutex_lock_interruptible.bprm_execve.do_execveat_common
      0.00       +2.8e+102%       2.75 ±239%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.mutex_lock_interruptible.devkmsg_read.vfs_read
      0.00        +5.3e+99%       0.01 ±162%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.mutex_lock_killable.begin_new_exec.load_elf_binary
      0.00        +3.1e+99%       0.00 ±244%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.mutex_lock_killable.mm_access.proc_mem_open
      0.00         +1e+100%       0.01 ±244%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.pick_link.step_into.path_openat
      0.00        +1.4e+99%       0.00 ±244%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.pipe_read.new_sync_read.vfs_read
      0.05 ±223%     +11.7%       0.06 ± 93%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.put_files_struct.do_exit.do_group_exit
      0.00 ±223%  +13281.7%       0.56 ±179%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.remove_vma.__do_munmap.__vm_munmap
      0.00       +4.8e+100%       0.05 ±137%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.remove_vma.__do_munmap.mmap_region
      0.04 ±159%   +4744.3%       1.95 ±200%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.remove_vma.exit_mmap.mmput
     19.82 ±139%     -53.1%       9.29 ± 53%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.rmap_walk_anon.remove_migration_ptes.migrate_pages
      0.42 ±158%   +1975.5%       8.76 ±182%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.rmap_walk_anon.try_to_unmap.migrate_pages
      0.00        +2.3e+99%       0.00 ±244%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.shrink_dentry_list.shrink_dcache_parent.d_invalidate
    100.76 ± 13%     -72.6%      27.62 ± 21%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.stop_one_cpu.__set_cpus_allowed_ptr.sched_setaffinity
      0.00       +9.1e+103%      91.42 ± 84%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.stop_one_cpu.migrate_task_to.task_numa_migrate
      0.01 ±133%   +7335.3%       0.63 ±115%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.stop_one_cpu.sched_exec.bprm_execve
      0.00         +3e+100%       0.03 ±185%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.switch_task_namespaces.do_exit.do_group_exit
      0.00       +1.9e+100%       0.02 ±216%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.task_numa_work.task_work_run.exit_to_user_mode_prepare
      0.06 ±223%     -45.7%       0.03 ±122%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.task_work_run.do_exit.do_group_exit
      0.00       +6.9e+100%       0.07 ±114%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.task_work_run.exit_to_user_mode_prepare.syscall_exit_to_user_mode
      0.00 ±141%    +467.3%       0.02 ±170%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.try_to_unmap_one.rmap_walk_anon.try_to_unmap
      2.48 ±162%    +380.1%      11.90 ± 48%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.unix_stream_read_generic.unix_stream_recvmsg.sock_read_iter
      0.01 ±151%   +1722.6%       0.12 ±113%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.unmap_page_range.unmap_vmas.exit_mmap
      0.00       +8.1e+100%       0.08 ±157%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.unmap_page_range.unmap_vmas.unmap_region
      0.04 ±171%     +18.6%       0.05 ± 92%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.unmap_vmas.exit_mmap.mmput
      0.06 ±205%    +586.9%       0.42 ±208%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.unmap_vmas.unmap_region.__do_munmap
      0.00       +7.5e+103%      75.00 ± 57%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.wait_for_completion.stop_two_cpus.migrate_swap
     62.99 ±136%     -72.3%      17.46 ± 21%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.wait_for_unix_gc.unix_stream_sendmsg.sock_sendmsg
      0.03 ±166%  +17537.4%       4.85 ±242%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.wp_page_copy.do_wp_page.__handle_mm_fault
      1.12 ±175%     -48.4%       0.58 ±135%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.zap_pte_range.unmap_page_range.unmap_vmas
    332.72 ±206%     -94.5%      18.34 ± 55%  perf-sched.wait_time.avg.ms.rcu_gp_kthread.kthread.ret_from_fork
      2.74 ±204%    -100.0%       0.00        perf-sched.wait_time.avg.ms.rwsem_down_read_slowpath.page_lock_anon_vma_read.rmap_walk_anon.try_to_unmap
    695.98 ±223%     -98.6%      10.05 ±244%  perf-sched.wait_time.avg.ms.rwsem_down_read_slowpath.rmap_walk_anon.remove_migration_ptes.migrate_pages
      0.00       +7.6e+101%       0.76 ±244%  perf-sched.wait_time.avg.ms.rwsem_down_write_slowpath.__put_anon_vma.unlink_anon_vmas.free_pgtables
      0.00       +6.2e+102%       6.19 ±196%  perf-sched.wait_time.avg.ms.rwsem_down_write_slowpath.unlink_anon_vmas.free_pgtables.exit_mmap
     24.32 ±223%   +2500.2%     632.30 ± 67%  perf-sched.wait_time.avg.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
    306.31 ±223%    +291.4%       1198 ± 13%  perf-sched.wait_time.avg.ms.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop.0.do_sys_poll
      0.00        +5.7e+98%       0.00 ±244%  perf-sched.wait_time.avg.ms.schedule_preempt_disabled.__mutex_lock.isra.0.pipe_read
      0.00       +4.6e+102%       4.59 ±244%  perf-sched.wait_time.avg.ms.schedule_preempt_disabled.__mutex_lock.isra.0.pipe_write
      0.52 ±223%    +160.8%       1.35 ±153%  perf-sched.wait_time.avg.ms.schedule_timeout.khugepaged.kthread.ret_from_fork
    186.70 ± 61%     -93.5%      12.16 ± 12%  perf-sched.wait_time.avg.ms.schedule_timeout.rcu_gp_kthread.kthread.ret_from_fork
    152.41 ± 53%     -52.9%      71.84 ± 24%  perf-sched.wait_time.avg.ms.schedule_timeout.sock_alloc_send_pskb.unix_stream_sendmsg.sock_sendmsg
     28.99 ± 18%     -72.7%       7.91 ± 15%  perf-sched.wait_time.avg.ms.schedule_timeout.unix_stream_read_generic.unix_stream_recvmsg.sock_read_iter
      0.00          +1e+99%       0.00 ±244%  perf-sched.wait_time.avg.ms.schedule_timeout.wait_for_completion.__flush_work.lru_add_drain_all
      0.00         +1e+103%      10.34 ±244%  perf-sched.wait_time.avg.ms.schedule_timeout.wait_for_completion.stop_one_cpu.__set_cpus_allowed_ptr
      0.00          +5e+99%       0.01 ±244%  perf-sched.wait_time.avg.ms.schedule_timeout.wait_for_completion.stop_two_cpus.migrate_swap
      1016 ± 23%     +44.8%       1472 ± 25%  perf-sched.wait_time.avg.ms.smpboot_thread_fn.kthread.ret_from_fork
    544.76 ±143%    +156.1%       1395 ± 10%  perf-sched.wait_time.avg.ms.worker_thread.kthread.ret_from_fork
      0.00       +5.3e+105%       5297 ± 37%  perf-sched.wait_time.max.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
    834.80 ±223%    +277.1%       3147 ± 78%  perf-sched.wait_time.max.ms.do_nanosleep.hrtimer_nanosleep.__x64_sys_nanosleep.do_syscall_64
    486.54 ±150%    +174.2%       1334 ± 51%  perf-sched.wait_time.max.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      1295 ±217%    +196.3%       3836 ± 32%  perf-sched.wait_time.max.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      5.34 ±139%   +4987.6%     271.83 ±175%  perf-sched.wait_time.max.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_exc_page_fault.[unknown]
      7603 ± 61%     -70.0%       2278 ± 64%  perf-sched.wait_time.max.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
     10.12 ±115%   +8266.9%     846.69 ± 89%  perf-sched.wait_time.max.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_call_function_single.[unknown]
      4694 ± 55%     -54.6%       2130 ± 48%  perf-sched.wait_time.max.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown]
     14487 ± 16%     -78.9%       3060 ± 38%  perf-sched.wait_time.max.ms.exit_to_user_mode_prepare.syscall_exit_to_user_mode.entry_SYSCALL_64_after_hwframe.[unknown]
      0.01 ±223%    +299.2%       0.05 ±106%  perf-sched.wait_time.max.ms.exit_to_user_mode_prepare.syscall_exit_to_user_mode.ret_from_fork.[unknown]
      2911 ±220%    +141.0%       7018 ± 14%  perf-sched.wait_time.max.ms.pipe_read.new_sync_read.vfs_read.ksys_read
      3.50 ±149%   +1689.6%      62.65 ± 69%  perf-sched.wait_time.max.ms.pipe_wait.wait_for_partner.fifo_open.do_dentry_open
      0.00        +6.4e+99%       0.01 ±158%  perf-sched.wait_time.max.ms.pipe_write.new_sync_write.vfs_write.ksys_write
      0.00       +4.6e+100%       0.05 ±100%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.__alloc_pages_nodemask.__get_free_pages.__pud_alloc
      0.02 ±223%   +1948.7%       0.31 ±185%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.__alloc_pages_nodemask.__get_free_pages.pgd_alloc
      0.00       +1.9e+100%       0.02 ±133%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.__alloc_pages_nodemask.__get_free_pages.proc_pid_readlink
      0.00       +4.8e+101%       0.48 ±130%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.__alloc_pages_nodemask.__pmd_alloc.__handle_mm_fault
      0.00       +7.7e+101%       0.77 ±212%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.__alloc_pages_nodemask.__pmd_alloc.move_page_tables
      0.00       +8.1e+101%       0.81 ±203%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.__alloc_pages_nodemask.alloc_pages_vma.do_anonymous_page
      0.00 ±223%   +1682.0%       0.06 ±183%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.__alloc_pages_nodemask.alloc_pages_vma.do_fault
     27.36 ± 62%   +1377.0%     404.18 ± 75%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.__alloc_pages_nodemask.alloc_pages_vma.shmem_alloc_page
      0.02 ±114%  +96407.3%      17.85 ±243%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.__alloc_pages_nodemask.alloc_pages_vma.wp_page_copy
      0.00       +2.3e+102%       2.26 ±243%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.__alloc_pages_nodemask.pte_alloc_one.__do_fault
      0.10 ±209%   +2579.9%       2.56 ±158%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.__alloc_pages_nodemask.pte_alloc_one.__pte_alloc
      0.00       +3.5e+100%       0.04 ±230%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.__alloc_pages_nodemask.pte_alloc_one.do_fault
      0.03 ±173%  +11104.3%       3.23 ±232%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.__anon_vma_prepare.do_anonymous_page.__handle_mm_fault
      0.00       +6.2e+102%       6.18 ±242%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.__anon_vma_prepare.do_fault.__handle_mm_fault
      2.43 ±207%   +4509.8%     112.09 ±148%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.__do_fault.do_fault.__handle_mm_fault
      0.05 ±223%      +5.8%       0.05 ± 76%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.__fput.task_work_run.exit_to_user_mode_prepare
      0.05 ±181%  +11522.6%       5.58 ±238%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.__get_user_pages.__get_user_pages_remote.get_arg_page
      0.00          +2e+99%       0.00 ±244%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.__kmalloc.alloc_pipe_info.create_pipe_files
      0.02 ±100%     -60.6%       0.01 ±173%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.__kmalloc.inotify_handle_event.fsnotify
      0.00       +5.4e+100%       0.05 ± 92%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.__kmalloc.load_elf_binary.exec_binprm
      0.02 ±149%  +19261.1%       3.74 ±234%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.__kmalloc.load_elf_phdrs.load_elf_binary
      0.01 ±223%   +2715.6%       0.15 ±119%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.__kmalloc.security_prepare_creds.prepare_creds
      0.00 ±223%    +514.3%       0.01 ±244%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.__kmalloc_node.alloc_cpumask_var_node.sched_setaffinity
      0.00        +1.9e+99%       0.00 ±244%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.__kmalloc_node.memcg_alloc_page_obj_cgroups.kmem_cache_alloc
      0.00       +1.5e+100%       0.01 ±141%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.__kmalloc_node.seq_read.vfs_read
     11508 ± 11%     -75.2%       2858 ± 34%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.__kmalloc_node_track_caller.__kmalloc_reserve.isra
      0.03 ±200%  +44138.7%      12.53 ±166%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.__put_anon_vma.unlink_anon_vmas.free_pgtables
      0.00       +1.6e+100%       0.02 ± 94%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.__sb_start_write.mnt_want_write.filename_create
      0.00        +8.3e+99%       0.01 ±158%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.__sb_start_write.vfs_write.ksys_write
      0.00 ±223%   +3210.2%       0.12 ± 77%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.__split_huge_pud.__handle_mm_fault.handle_mm_fault
      6557 ± 55%     -72.8%       1783 ± 51%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.aa_sk_perm.security_socket_recvmsg.sock_recvmsg
      9591 ± 44%     -76.9%       2217 ± 36%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.aa_sk_perm.security_socket_sendmsg.sock_sendmsg
      0.01 ±223%   +2062.9%       0.11 ±133%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.apparmor_file_alloc_security.security_file_alloc.__alloc_file
      2.91 ±188%    +477.7%      16.80 ± 89%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.change_p4d_range.change_protection.change_prot_numa
      0.03 ±160%    +330.6%       0.12 ± 99%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.change_p4d_range.change_protection.mprotect_fixup
      0.00       +3.6e+100%       0.04 ±124%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.copy_page_from_iter.pipe_write.new_sync_write
      0.00       +1.6e+103%      15.84 ±244%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.copy_page_range.dup_mmap.dup_mm
      0.00         +1e+100%       0.01 ± 93%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.copy_page_to_iter.generic_file_buffered_read.new_sync_read
      0.00       +2.1e+103%      20.80 ±225%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.copy_page_to_iter.pipe_read.new_sync_read
      0.00       +1.6e+104%     155.63 ±243%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.copy_pte_range.copy_page_range.dup_mmap
      0.03 ±140%   +3334.7%       1.04 ±189%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.copy_strings.isra.0
      0.08 ±187%  +12006.0%       9.48 ±240%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.count.isra.0
     24.34 ±119%   +1388.8%     362.39 ±181%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      0.01 ±223%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.down_read.__do_sys_newuname.do_syscall_64
      0.00         +1e+100%       0.01 ±148%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.down_read.acct_collect.do_exit
      0.00       +3.6e+100%       0.04 ±229%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.down_read.do_exit.do_group_exit
      0.02 ±223%  +17049.6%       3.97 ±237%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.down_read.path_openat.do_filp_open
      0.36 ±219%   +1084.0%       4.22 ±227%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.down_read.rmap_walk_anon.remove_migration_ptes
      0.11 ±171%    +136.1%       0.27 ± 64%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.down_read.walk_component.link_path_walk
      0.01 ±193%   +2623.2%       0.38 ±129%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.down_read.walk_component.path_lookupat
      0.00       +3.7e+100%       0.04 ±198%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.down_read_killable.m_start.seq_read
      0.00       +1.4e+101%       0.14 ± 92%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.down_write.__anon_vma_prepare.do_anonymous_page
      0.00       +7.7e+100%       0.08 ±114%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.down_write.__anon_vma_prepare.do_fault
      0.00        +7.6e+99%       0.01 ±244%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.down_write.__anon_vma_prepare.wp_page_copy
      0.01 ±173%  +35011.5%       3.04 ±220%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.down_write.__vma_adjust.__split_vma
      0.00       +2.9e+101%       0.29 ± 78%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.down_write.__vma_adjust.shift_arg_pages
      0.00       +9.2e+100%       0.09 ±111%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.down_write.__vma_adjust.vma_merge
      0.02 ±223%  +28711.0%       5.23 ±230%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.down_write.anon_vma_clone.__split_vma
      0.00         +3e+104%     298.67 ±158%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.down_write.anon_vma_clone.anon_vma_fork
      0.00       +1.5e+104%     153.29 ±241%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.down_write.anon_vma_fork.dup_mmap
      0.00       +3.1e+104%     308.50 ±244%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.down_write.dup_mmap.dup_mm
      0.00       +7.2e+102%       7.24 ±244%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.down_write.expand_downwards.find_extend_vma
      0.00          +5e+99%       0.01 ±244%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.down_write.expand_downwards.setup_arg_pages
      0.00        +6.1e+99%       0.01 ±167%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.down_write.generic_file_write_iter.new_sync_write
      0.06 ±210%  +16435.8%      10.64 ±146%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.down_write.unlink_anon_vmas.free_pgtables
      1.15 ±203%   +1134.9%      14.25 ± 94%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.down_write.unlink_file_vma.free_pgtables
      0.00 ±223%  +2.7e+05%       5.47 ±202%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.down_write.vma_link.mmap_region
      0.00        +9.3e+99%       0.01 ±142%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.down_write_killable.__vm_munmap.__x64_sys_munmap
      0.00       +4.9e+100%       0.05 ±160%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.down_write_killable.__vm_munmap.elf_map
      0.00       +1.5e+102%       1.48 ±244%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.down_write_killable.__x64_sys_brk.do_syscall_64
      0.00       +3.3e+100%       0.03 ±104%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.down_write_killable.alloc_bprm.do_execveat_common
      0.00 ±223%    +640.3%       0.01 ±119%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.down_write_killable.do_mprotect_pkey.__x64_sys_mprotect
      3.32 ±223%     -77.5%       0.75 ±196%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.down_write_killable.map_vdso.load_elf_binary
      0.02 ±150%  +22923.0%       5.68 ±211%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.down_write_killable.setup_arg_pages.load_elf_binary
      0.00       +2.8e+101%       0.28 ±139%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.down_write_killable.vm_brk_flags.load_elf_interp
      0.00       +1.7e+100%       0.02 ±114%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.down_write_killable.vm_brk_flags.set_brk
      0.02 ±131%   +3823.9%       0.80 ± 96%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.down_write_killable.vm_mmap_pgoff.elf_map
      0.01 ±223%   +2140.2%       0.14 ± 86%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.down_write_killable.vm_mmap_pgoff.ksys_mmap_pgoff
      2.82 ±202%   +1135.9%      34.89 ± 79%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.dput.__fput.task_work_run
      0.00       +1.4e+100%       0.01 ±244%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.dput.filename_create.do_mkdirat
      0.00 ±223%  +1.5e+05%       3.23 ±218%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.dput.nd_jump_root.pick_link
      0.09 ±207%   +5428.3%       4.89 ±231%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.dput.path_openat.do_filp_open
      0.00       +1.5e+100%       0.01 ± 74%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.dput.path_put.free_fs_struct
      0.00         +2e+100%       0.02 ±191%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.dput.path_put.proc_pid_readlink
      0.00        +6.7e+99%       0.01 ±166%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.dput.path_put.set_fs_pwd
      0.00 ±223%   +1165.9%       0.03 ±118%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.dput.path_put.vfs_statx
      0.00 ±223%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.dput.step_into.handle_dots
      0.00 ±223%   +6383.1%       0.12 ±113%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.dput.step_into.path_openat
      0.40 ±201%   +4111.6%      17.02 ± 99%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.dput.step_into.walk_component
      0.00        +4.6e+99%       0.00 ±158%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.dput.terminate_walk.path_lookupat
      0.10 ±122%  +11670.3%      11.32 ±158%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.dput.terminate_walk.path_openat
      0.00       +5.7e+100%       0.06 ±133%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.dput.walk_component.link_path_walk
      0.00         +9e+102%       9.03 ±111%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.exit_mmap.mmput.begin_new_exec
      0.09 ±215%  +10248.4%       9.19 ±237%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.exit_mmap.mmput.do_exit
      0.00       +1.5e+100%       0.01 ± 98%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.exit_signals.do_exit.do_group_exit
      0.00          +7e+99%       0.01 ±163%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.find_lock_entry.shmem_getpage_gfp.shmem_write_begin
      0.01 ±159%  +2.3e+05%      17.32 ±222%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.generic_file_buffered_read.new_sync_read.__kernel_read
     30.10 ±119%   +2867.9%     893.25 ± 50%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.generic_perform_write.__generic_file_write_iter.generic_file_write_iter
      0.00       +1.3e+102%       1.29 ±170%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.khugepaged.kthread.ret_from_fork
      0.12 ±158%  +11125.9%      13.06 ±241%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.kmem_cache_alloc.__alloc_file.alloc_empty_file
      0.00 ±223%  +1.6e+05%       4.59 ±234%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.kmem_cache_alloc.__anon_vma_prepare.do_anonymous_page
      0.00       +1.2e+101%       0.12 ± 66%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.kmem_cache_alloc.__anon_vma_prepare.do_fault
      0.00       +1.4e+100%       0.01 ± 88%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.kmem_cache_alloc.__anon_vma_prepare.wp_page_copy
      0.00 ±223%  +27662.9%       0.46 ±197%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.kmem_cache_alloc.__d_alloc.d_alloc
      0.00       +2.6e+100%       0.03 ±128%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.kmem_cache_alloc.__d_alloc.d_alloc_cursor
      0.00        +1.9e+99%       0.00 ±244%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.kmem_cache_alloc.__delayacct_tsk_init.copy_process
      0.00       +1.2e+103%      12.49 ±244%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.kmem_cache_alloc.copy_process._do_fork
      0.00       +1.1e+100%       0.01 ±157%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.kmem_cache_alloc.getname_flags.__x64_sys_execve
      0.00        +2.7e+99%       0.00 ±244%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.kmem_cache_alloc.getname_flags.do_mkdirat
      0.01 ±150%   +1030.2%       0.08 ± 99%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.kmem_cache_alloc.getname_flags.do_sys_openat2
      0.00       +6.8e+102%       6.78 ±219%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.kmem_cache_alloc.getname_flags.user_path_at_empty
      0.00       +1.6e+102%       1.56 ±243%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.kmem_cache_alloc.getname_kernel.open_exec
      0.00        +4.7e+99%       0.00 ±166%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.kmem_cache_alloc.mm_alloc.alloc_bprm
      0.00       +2.6e+102%       2.64 ±244%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.kmem_cache_alloc.prepare_creds.copy_creds
      0.00        +5.1e+99%       0.01 ±178%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.kmem_cache_alloc.prepare_creds.do_faccessat
      0.00       +4.9e+100%       0.05 ±186%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.kmem_cache_alloc.prepare_creds.prepare_exec_creds
      0.00       +7.9e+102%       7.86 ±222%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.kmem_cache_alloc.proc_alloc_inode.alloc_inode
      0.04 ±192%  +41668.0%      18.73 ± 66%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.kmem_cache_alloc.security_file_alloc.__alloc_file
      0.00        +3.3e+99%       0.00 ±244%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.kmem_cache_alloc.seq_open.__seq_open_private
      0.00        +3.3e+99%       0.00 ±244%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.kmem_cache_alloc.seq_open.kernfs_fop_open
      0.00        +2.7e+99%       0.00 ±244%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.kmem_cache_alloc.seq_open.proc_reg_open
      0.00        +3.9e+99%       0.00 ±244%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.kmem_cache_alloc.seq_open.single_open
      0.04 ±223%   +2454.7%       1.00 ±228%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.kmem_cache_alloc.vm_area_alloc.__install_special_mapping
      0.00 ±223%   +4326.5%       0.10 ± 53%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.kmem_cache_alloc.vm_area_alloc.alloc_bprm
      0.00       +7.3e+101%       0.73 ±225%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.kmem_cache_alloc.vm_area_alloc.do_brk_flags
      0.12 ±180%   +6340.7%       7.63 ±147%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.kmem_cache_alloc.vm_area_alloc.mmap_region
      0.00 ±141%    +2e+05%       8.60 ±212%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.kmem_cache_alloc.vm_area_dup.__split_vma
     11503 ± 19%     -78.8%       2441 ± 40%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.kmem_cache_alloc_node.__alloc_skb.alloc_skb_with_frags
      0.00       +1.9e+100%       0.02 ± 94%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.kmem_cache_alloc_trace.alloc_bprm.do_execveat_common
      0.00        +2.4e+99%       0.00 ±244%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.kmem_cache_alloc_trace.alloc_pipe_info.create_pipe_files
      0.00       +6.6e+100%       0.07 ±222%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.kmem_cache_alloc_trace.disk_seqf_start.seq_read
      0.00       +5.9e+102%       5.85 ±244%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.kmem_cache_alloc_trace.i40e_clean_adminq_subtask.i40e_service_task
      0.00       +1.3e+101%       0.13 ±148%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.kmem_cache_alloc_trace.load_elf_binary.exec_binprm
      0.06 ±138%    +255.7%       0.22 ±107%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.kmem_cache_alloc_trace.perf_event_mmap.mmap_region
      0.00 ±223%   +1082.9%       0.02 ±190%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.kmem_cache_alloc_trace.perf_event_mmap.mprotect_fixup
      0.00       +1.6e+100%       0.02 ±244%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.kmem_cache_alloc_trace.vmstat_start.seq_read
      0.00        +3.7e+99%       0.00 ±244%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.migrate_page_copy.migrate_misplaced_transhuge_page.do_huge_pmd_numa_page
      0.00       +7.9e+102%       7.90 ±241%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.migrate_pages.migrate_misplaced_page.__handle_mm_fault
      0.00       +6.6e+101%       0.66 ±214%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.mmput.begin_new_exec.load_elf_binary
      0.00       +2.4e+100%       0.02 ±135%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.mmput.do_exit.do_group_exit
      0.00       +2.4e+100%       0.02 ± 86%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.mmput.m_stop.seq_read
      0.00       +3.5e+100%       0.04 ±203%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.move_page_tables.shift_arg_pages.setup_arg_pages
      0.00        +5.7e+99%       0.01 ±244%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.mutex_lock.__fdget_pos.ksys_write
      0.00 ±223%   +3594.3%       0.06 ±244%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.mutex_lock.__perf_event_read_value.perf_read
      0.09 ±223%     -88.5%       0.01 ±134%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.mutex_lock.fifo_open.do_dentry_open
      0.28 ±223%   +4911.7%      14.20 ±168%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.mutex_lock.futex_exec_release.exec_mm_release
      0.02 ±223%     +62.6%       0.04 ±176%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.mutex_lock.futex_exit_release.exit_mm_release
      0.00        +3.3e+99%       0.00 ±244%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.mutex_lock.kernfs_dop_revalidate.lookup_fast
      0.00        +9.9e+99%       0.01 ±132%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.mutex_lock.kernfs_fop_open.do_dentry_open
      0.00          +4e+99%       0.00 ±244%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.mutex_lock.kernfs_iop_getattr.vfs_statx_fd
      0.00        +4.3e+99%       0.00 ±169%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.mutex_lock.kernfs_iop_permission.inode_permission
      0.00        +1.1e+99%       0.00 ±244%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.mutex_lock.kernfs_put_open_node.isra
      0.00       +4.1e+100%       0.04 ±113%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.mutex_lock.kernfs_seq_start.seq_read
      0.02 ±223%  +13785.1%       3.38 ±148%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.mutex_lock.perf_event_ctx_lock_nested.isra
      0.04 ±223%     -28.1%       0.03 ±244%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.mutex_lock.perf_event_for_each_child._perf_ioctl
      0.69 ±223%     -96.5%       0.02 ±214%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.mutex_lock.perf_read.vfs_read
      0.00 ±150%   +2546.0%       0.10 ±143%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.mutex_lock.pipe_write.new_sync_write
      0.00       +2.2e+100%       0.02 ±167%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.mutex_lock.slab_start.seq_read
      4260 ± 48%     -63.4%       1557 ± 66%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.mutex_lock.unix_stream_read_generic.unix_stream_recvmsg
      0.00       +1.8e+101%       0.18 ±236%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.mutex_lock.uprobe_clear_state.mmput
      0.00       +1.2e+100%       0.01 ± 90%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.mutex_lock_interruptible.bprm_execve.do_execveat_common
      0.00       +2.8e+102%       2.76 ±238%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.mutex_lock_interruptible.devkmsg_read.vfs_read
      0.00        +7.4e+99%       0.01 ±165%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.mutex_lock_killable.begin_new_exec.load_elf_binary
      0.00        +3.1e+99%       0.00 ±244%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.mutex_lock_killable.mm_access.proc_mem_open
      0.00         +1e+100%       0.01 ±244%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.pick_link.step_into.path_openat
      0.00        +1.4e+99%       0.00 ±244%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.pipe_read.new_sync_read.vfs_read
      0.05 ±223%    +265.1%       0.20 ±107%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.put_files_struct.do_exit.do_group_exit
      0.00 ±223%  +64940.0%       2.71 ±221%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.remove_vma.__do_munmap.__vm_munmap
      0.00       +9.5e+100%       0.09 ±136%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.remove_vma.__do_munmap.mmap_region
      0.08 ±189%  +43147.4%      35.75 ±214%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.remove_vma.exit_mmap.mmput
      1158 ±193%     -87.0%     150.64 ± 85%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.rmap_walk_anon.remove_migration_ptes.migrate_pages
      4.52 ±137%    +555.1%      29.63 ± 96%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.rmap_walk_anon.try_to_unmap.migrate_pages
      0.00        +2.3e+99%       0.00 ±244%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.shrink_dentry_list.shrink_dcache_parent.d_invalidate
      3356 ± 20%     -55.8%       1483 ± 21%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.stop_one_cpu.__set_cpus_allowed_ptr.sched_setaffinity
      0.00       +3.4e+104%     338.37 ± 96%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.stop_one_cpu.migrate_task_to.task_numa_migrate
      0.09 ±198%  +23559.5%      21.29 ±117%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.stop_one_cpu.sched_exec.bprm_execve
      0.00         +3e+100%       0.03 ±180%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.switch_task_namespaces.do_exit.do_group_exit
      0.00       +3.3e+100%       0.03 ±228%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.task_numa_work.task_work_run.exit_to_user_mode_prepare
      0.06 ±223%     -10.9%       0.06 ±152%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.task_work_run.do_exit.do_group_exit
      0.00         +2e+101%       0.20 ±141%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.task_work_run.exit_to_user_mode_prepare.syscall_exit_to_user_mode
      0.00 ±141%    +471.4%       0.02 ±168%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.try_to_unmap_one.rmap_walk_anon.try_to_unmap
      9.95 ±149%   +3602.1%     368.35 ± 69%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.unix_stream_read_generic.unix_stream_recvmsg.sock_read_iter
      0.01 ±147%   +7292.9%       0.49 ±125%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.unmap_page_range.unmap_vmas.exit_mmap
      0.00       +1.3e+101%       0.13 ±158%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.unmap_page_range.unmap_vmas.unmap_region
      0.08 ±175%     +88.2%       0.16 ±124%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.unmap_vmas.exit_mmap.mmput
      0.09 ±207%   +6811.4%       6.43 ±231%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.unmap_vmas.unmap_region.__do_munmap
      0.00       +5.2e+104%     522.91 ± 74%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.wait_for_completion.stop_two_cpus.migrate_swap
      5730 ± 84%     -68.2%       1820 ± 46%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.wait_for_unix_gc.unix_stream_sendmsg.sock_sendmsg
      0.08 ±142%  +1.9e+05%     149.46 ±244%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.wp_page_copy.do_wp_page.__handle_mm_fault
      8.84 ±140%     +74.2%      15.40 ±115%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.zap_pte_range.unmap_page_range.unmap_vmas
      1296 ±204%     -77.4%     293.28 ± 53%  perf-sched.wait_time.max.ms.rcu_gp_kthread.kthread.ret_from_fork
      2.86 ±195%    -100.0%       0.00        perf-sched.wait_time.max.ms.rwsem_down_read_slowpath.page_lock_anon_vma_read.rmap_walk_anon.try_to_unmap
      1391 ±223%     -99.3%      10.05 ±244%  perf-sched.wait_time.max.ms.rwsem_down_read_slowpath.rmap_walk_anon.remove_migration_ptes.migrate_pages
      0.00       +7.6e+101%       0.76 ±244%  perf-sched.wait_time.max.ms.rwsem_down_write_slowpath.__put_anon_vma.unlink_anon_vmas.free_pgtables
      0.00       +7.3e+102%       7.32 ±172%  perf-sched.wait_time.max.ms.rwsem_down_write_slowpath.unlink_anon_vmas.free_pgtables.exit_mmap
     48.64 ±223%   +3277.8%       1642 ± 68%  perf-sched.wait_time.max.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      1336 ±223%    +243.4%       4588 ± 25%  perf-sched.wait_time.max.ms.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop.0.do_sys_poll
      0.00        +5.7e+98%       0.00 ±244%  perf-sched.wait_time.max.ms.schedule_preempt_disabled.__mutex_lock.isra.0.pipe_read
      0.00       +4.6e+102%       4.59 ±244%  perf-sched.wait_time.max.ms.schedule_preempt_disabled.__mutex_lock.isra.0.pipe_write
      0.52 ±223%    +160.8%       1.35 ±153%  perf-sched.wait_time.max.ms.schedule_timeout.khugepaged.kthread.ret_from_fork
      4277 ± 56%     -84.8%     651.39 ± 35%  perf-sched.wait_time.max.ms.schedule_timeout.rcu_gp_kthread.kthread.ret_from_fork
     11924 ± 29%     -72.0%       3342 ± 36%  perf-sched.wait_time.max.ms.schedule_timeout.sock_alloc_send_pskb.unix_stream_sendmsg.sock_sendmsg
     13909 ± 15%     -79.9%       2800 ± 42%  perf-sched.wait_time.max.ms.schedule_timeout.unix_stream_read_generic.unix_stream_recvmsg.sock_read_iter
      0.00          +1e+99%       0.00 ±244%  perf-sched.wait_time.max.ms.schedule_timeout.wait_for_completion.__flush_work.lru_add_drain_all
      0.00         +1e+103%      10.34 ±244%  perf-sched.wait_time.max.ms.schedule_timeout.wait_for_completion.stop_one_cpu.__set_cpus_allowed_ptr
      0.00          +5e+99%       0.01 ±244%  perf-sched.wait_time.max.ms.schedule_timeout.wait_for_completion.stop_two_cpus.migrate_swap
     13875 ± 17%     -33.5%       9231 ± 15%  perf-sched.wait_time.max.ms.smpboot_thread_fn.kthread.ret_from_fork
      6079 ±141%     +34.0%       8145 ± 13%  perf-sched.wait_time.max.ms.worker_thread.kthread.ret_from_fork
      0.00          -100.0%       0.00        interrupts.0:IO-APIC.2-edge.timer
      0.33 ±223%    +371.4%       1.57 ±197%  interrupts.100:PCI-MSI.31981633-edge.i40e-eth0-TxRx-64
     12.00 ±223%  +20201.2%       2436 ±244%  interrupts.101:PCI-MSI.31981634-edge.i40e-eth0-TxRx-65
      0.67 ±141%    +285.7%       2.57 ±163%  interrupts.102:PCI-MSI.31981635-edge.i40e-eth0-TxRx-66
     25.50 ±203%    -100.0%       0.00        interrupts.103:PCI-MSI.31981636-edge.i40e-eth0-TxRx-67
      1156 ±177%     -97.2%      32.71 ±198%  interrupts.104:PCI-MSI.31981637-edge.i40e-eth0-TxRx-68
     11.00 ±223%     -40.3%       6.57 ±152%  interrupts.105:PCI-MSI.31981638-edge.i40e-eth0-TxRx-69
      7.67 ± 92%     -73.9%       2.00 ±158%  interrupts.106:PCI-MSI.31981639-edge.i40e-eth0-TxRx-70
     44.50 ±221%     -96.1%       1.71 ±222%  interrupts.107:PCI-MSI.31981640-edge.i40e-eth0-TxRx-71
      0.00       +1.7e+104%     169.57 ±233%  interrupts.108:PCI-MSI.31981641-edge.i40e-eth0-TxRx-72
      0.00       +7.6e+104%     762.14 ±244%  interrupts.109:PCI-MSI.31981642-edge.i40e-eth0-TxRx-73
      2.00 ±223%  +77642.9%       1554 ±158%  interrupts.110:PCI-MSI.31981643-edge.i40e-eth0-TxRx-74
     19.50 ±203%     -99.3%       0.14 ±244%  interrupts.111:PCI-MSI.31981644-edge.i40e-eth0-TxRx-75
     97.67 ±223%     -92.4%       7.43 ±191%  interrupts.112:PCI-MSI.31981645-edge.i40e-eth0-TxRx-76
      1.83 ±223%  +13014.3%     240.43 ±244%  interrupts.113:PCI-MSI.31981646-edge.i40e-eth0-TxRx-77
      0.00       +1.4e+101%       0.14 ±244%  interrupts.114:PCI-MSI.31981647-edge.i40e-eth0-TxRx-78
      0.33 ±141%  +1.1e+05%     382.71 ±233%  interrupts.115:PCI-MSI.31981648-edge.i40e-eth0-TxRx-79
      0.00       +6.1e+102%       6.14 ±231%  interrupts.116:PCI-MSI.31981649-edge.i40e-eth0-TxRx-80
      0.00       +4.2e+103%      42.14 ±240%  interrupts.117:PCI-MSI.31981650-edge.i40e-eth0-TxRx-81
     13.17 ±223%   +1196.6%     170.71 ±186%  interrupts.118:PCI-MSI.31981651-edge.i40e-eth0-TxRx-82
    552.00 ±152%    +645.5%       4115 ±225%  interrupts.119:PCI-MSI.31981652-edge.i40e-eth0-TxRx-83
      0.00       +2.9e+101%       0.29 ±244%  interrupts.120:PCI-MSI.31981653-edge.i40e-eth0-TxRx-84
      0.33 ±223%     +71.4%       0.57 ±244%  interrupts.121:PCI-MSI.31981654-edge.i40e-eth0-TxRx-85
      0.00       +5.9e+102%       5.86 ±198%  interrupts.122:PCI-MSI.31981655-edge.i40e-eth0-TxRx-86
      6.67 ±210%     -67.9%       2.14 ±154%  interrupts.123:PCI-MSI.31981656-edge.i40e-eth0-TxRx-87
      0.00       +8.3e+102%       8.29 ±202%  interrupts.124:PCI-MSI.31981657-edge.i40e-eth0-TxRx-88
      0.00       +3.1e+102%       3.14 ±161%  interrupts.125:PCI-MSI.31981658-edge.i40e-eth0-TxRx-89
      0.17 ±223%     +71.4%       0.29 ±244%  interrupts.126:PCI-MSI.31981659-edge.i40e-eth0-TxRx-90
     11.33 ±223%     -88.7%       1.29 ±169%  interrupts.127:PCI-MSI.31981660-edge.i40e-eth0-TxRx-91
      6.83 ±223%   +3405.9%     239.57 ±219%  interrupts.128:PCI-MSI.31981661-edge.i40e-eth0-TxRx-92
      0.17 ±223%  +1.3e+05%     213.00 ±233%  interrupts.129:PCI-MSI.31981662-edge.i40e-eth0-TxRx-93
      0.00          -100.0%       0.00        interrupts.293:PCI-MSI.327680-edge.xhci_hcd
      0.00          -100.0%       0.00        interrupts.295:PCI-MSI.65536-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.297:PCI-MSI.67584-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.298:PCI-MSI.69632-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.299:PCI-MSI.69632-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.299:PCI-MSI.71680-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.300:PCI-MSI.71680-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.300:PCI-MSI.73728-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.301:PCI-MSI.73728-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.301:PCI-MSI.75776-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.302:PCI-MSI.75776-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.302:PCI-MSI.77824-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.303:PCI-MSI.77824-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.303:PCI-MSI.79872-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.304:PCI-MSI.79872-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.305:PCI-MSI.67174400-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.306:PCI-MSI.67174400-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.307:PCI-MSI.376832-edge.ahci[0000:00:17.0]
      0.00          -100.0%       0.00        interrupts.307:PCI-MSI.67176448-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.308:PCI-MSI.67176448-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.308:PCI-MSI.67178496-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.309:PCI-MSI.67176448-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.309:PCI-MSI.67178496-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.310:PCI-MSI.67178496-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.310:PCI-MSI.67180544-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.311:PCI-MSI.67180544-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.311:PCI-MSI.67182592-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.312:PCI-MSI.67182592-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.312:PCI-MSI.67184640-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.313:PCI-MSI.376832-edge.ahci[0000:00:17.0]
      0.00          -100.0%       0.00        interrupts.313:PCI-MSI.67184640-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.313:PCI-MSI.67186688-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.314:PCI-MSI.67186688-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.314:PCI-MSI.67188736-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.315:PCI-MSI.376832-edge.ahci[0000:00:17.0]
      0.00          -100.0%       0.00        interrupts.315:PCI-MSI.67188736-edge.ioat-msix
      0.00       +4.1e+102%       4.14 ±122%  interrupts.36:PCI-MSI.31981569-edge.i40e-eth0-TxRx-0
      1.50 ±223%     +52.4%       2.29 ±145%  interrupts.37:PCI-MSI.31981570-edge.i40e-eth0-TxRx-1
    185.83 ±222%    +382.9%     897.43 ±159%  interrupts.38:PCI-MSI.31981571-edge.i40e-eth0-TxRx-2
      0.00       +2.6e+104%     257.00 ±243%  interrupts.39:PCI-MSI.31981572-edge.i40e-eth0-TxRx-3
      0.00          -100.0%       0.00        interrupts.3:IO-APIC.3-edge
     32.67 ±118%      -1.2%      32.29 ±205%  interrupts.40:PCI-MSI.31981573-edge.i40e-eth0-TxRx-4
      0.00       +1.4e+105%       1406 ±179%  interrupts.41:PCI-MSI.31981574-edge.i40e-eth0-TxRx-5
     27.67 ±151%     -94.3%       1.57 ±197%  interrupts.42:PCI-MSI.31981575-edge.i40e-eth0-TxRx-6
      0.00       +7.7e+103%      77.00 ±142%  interrupts.43:PCI-MSI.31981576-edge.i40e-eth0-TxRx-7
    523.33 ±193%     -99.8%       1.29 ±159%  interrupts.44:PCI-MSI.31981577-edge.i40e-eth0-TxRx-8
     20.33 ±176%    -100.0%       0.00        interrupts.45:PCI-MSI.31981578-edge.i40e-eth0-TxRx-9
     15.83 ±218%    +380.9%      76.14 ±238%  interrupts.46:PCI-MSI.31981579-edge.i40e-eth0-TxRx-10
      1.83 ±179%    +305.2%       7.43 ±175%  interrupts.47:PCI-MSI.31981580-edge.i40e-eth0-TxRx-11
      1.67 ±223%     -91.4%       0.14 ±244%  interrupts.48:PCI-MSI.31981581-edge.i40e-eth0-TxRx-12
     10.33 ±182%   +2442.4%     262.71 ±243%  interrupts.49:PCI-MSI.31981582-edge.i40e-eth0-TxRx-13
      0.00       +3.7e+103%      36.57 ± 63%  interrupts.4:IO-APIC.4-edge.ttyS0
     14.67 ±158%   +7186.7%       1068 ±244%  interrupts.50:PCI-MSI.31981583-edge.i40e-eth0-TxRx-14
      1333 ±222%     -99.8%       3.14 ±118%  interrupts.51:PCI-MSI.31981584-edge.i40e-eth0-TxRx-15
    183.17 ±223%     -78.8%      38.86 ±144%  interrupts.52:PCI-MSI.31981585-edge.i40e-eth0-TxRx-16
    391.83 ±222%     -99.2%       3.00 ±130%  interrupts.53:PCI-MSI.31981586-edge.i40e-eth0-TxRx-17
      0.00       +5.7e+101%       0.57 ±158%  interrupts.54:PCI-MSI.31981587-edge.i40e-eth0-TxRx-18
      3950 ±223%    -100.0%       1.14 ±127%  interrupts.55:PCI-MSI.31981588-edge.i40e-eth0-TxRx-19
      0.00       +4.1e+104%     405.86 ±227%  interrupts.56:PCI-MSI.31981589-edge.i40e-eth0-TxRx-20
      2.00 ±182%    -100.0%       0.00        interrupts.57:PCI-MSI.31981590-edge.i40e-eth0-TxRx-21
      3.50 ±223%   +6467.3%     229.86 ±190%  interrupts.58:PCI-MSI.31981591-edge.i40e-eth0-TxRx-22
      5.17 ±121%  +53001.4%       2743 ±244%  interrupts.59:PCI-MSI.31981592-edge.i40e-eth0-TxRx-23
      9.00 ±223%     +27.0%      11.43 ±159%  interrupts.60:PCI-MSI.31981593-edge.i40e-eth0-TxRx-24
      1.83 ±179%  +26440.3%     486.57 ±244%  interrupts.61:PCI-MSI.31981594-edge.i40e-eth0-TxRx-25
      1.00 ±223%    +171.4%       2.71 ±191%  interrupts.62:PCI-MSI.31981595-edge.i40e-eth0-TxRx-26
      1.67 ±107%    +988.6%      18.14 ±233%  interrupts.63:PCI-MSI.31981596-edge.i40e-eth0-TxRx-27
    186.17 ±221%     -72.1%      51.86 ±160%  interrupts.64:PCI-MSI.31981597-edge.i40e-eth0-TxRx-28
     95.33 ±169%     -97.6%       2.29 ±111%  interrupts.65:PCI-MSI.31981598-edge.i40e-eth0-TxRx-29
      4905 ±223%    -100.0%       1.71 ±222%  interrupts.66:PCI-MSI.31981599-edge.i40e-eth0-TxRx-30
    317.17 ±223%     +76.9%     561.14 ±244%  interrupts.67:PCI-MSI.31981600-edge.i40e-eth0-TxRx-31
      2.00 ±160%     -85.7%       0.29 ±244%  interrupts.68:PCI-MSI.31981601-edge.i40e-eth0-TxRx-32
      0.00       +1.1e+105%       1109 ±244%  interrupts.69:PCI-MSI.31981602-edge.i40e-eth0-TxRx-33
      0.00       +1.1e+102%       1.14 ±127%  interrupts.70:PCI-MSI.31981603-edge.i40e-eth0-TxRx-34
    192.83 ±222%     -96.1%       7.43 ±212%  interrupts.71:PCI-MSI.31981604-edge.i40e-eth0-TxRx-35
    151.33 ±220%    +968.2%       1616 ±244%  interrupts.72:PCI-MSI.31981605-edge.i40e-eth0-TxRx-36
      0.00       +8.6e+101%       0.86 ±244%  interrupts.73:PCI-MSI.31981606-edge.i40e-eth0-TxRx-37
      0.83 ±223%    +260.0%       3.00 ±116%  interrupts.74:PCI-MSI.31981607-edge.i40e-eth0-TxRx-38
     20.17 ±219%     -97.2%       0.57 ±158%  interrupts.75:PCI-MSI.31981608-edge.i40e-eth0-TxRx-39
      0.00       +1.5e+105%       1507 ±175%  interrupts.76:PCI-MSI.31981609-edge.i40e-eth0-TxRx-40
      1.50 ±223%   +5538.1%      84.57 ±127%  interrupts.77:PCI-MSI.31981610-edge.i40e-eth0-TxRx-41
      1.00 ±223%     -57.1%       0.43 ±244%  interrupts.78:PCI-MSI.31981611-edge.i40e-eth0-TxRx-42
     66.00 ±220%     -97.2%       1.86 ±187%  interrupts.79:PCI-MSI.31981612-edge.i40e-eth0-TxRx-43
      0.33 ±223%    +285.7%       1.29 ±244%  interrupts.80:PCI-MSI.31981613-edge.i40e-eth0-TxRx-44
      1.33 ±165%     -78.6%       0.29 ±244%  interrupts.81:PCI-MSI.31981614-edge.i40e-eth0-TxRx-45
    180.33 ±223%   +3655.7%       6772 ±244%  interrupts.82:PCI-MSI.31981615-edge.i40e-eth0-TxRx-46
     96.00 ±221%    +355.4%     437.14 ±244%  interrupts.83:PCI-MSI.31981616-edge.i40e-eth0-TxRx-47
      3.33 ±172%   +2415.7%      83.86 ±240%  interrupts.84:PCI-MSI.31981617-edge.i40e-eth0-TxRx-48
      0.00         +2e+103%      19.86 ±214%  interrupts.85:PCI-MSI.31981618-edge.i40e-eth0-TxRx-49
      6705 ±223%    -100.0%       2.29 ±177%  interrupts.86:PCI-MSI.31981619-edge.i40e-eth0-TxRx-50
      0.33 ±223%  +57242.9%     191.14 ±241%  interrupts.87:PCI-MSI.31981620-edge.i40e-eth0-TxRx-51
      0.00       +2.4e+103%      24.00 ±244%  interrupts.88:PCI-MSI.31981621-edge.i40e-eth0-TxRx-52
      4.00 ±223%    -100.0%       0.00        interrupts.89:PCI-MSI.31981622-edge.i40e-eth0-TxRx-53
      0.00          -100.0%       0.00        interrupts.8:IO-APIC.8-edge.rtc0
      3.67 ±223%    -100.0%       0.00        interrupts.90:PCI-MSI.31981623-edge.i40e-eth0-TxRx-54
      2.17 ±223%     -86.8%       0.29 ±244%  interrupts.91:PCI-MSI.31981624-edge.i40e-eth0-TxRx-55
    321.33 ±223%     -93.6%      20.43 ±240%  interrupts.92:PCI-MSI.31981625-edge.i40e-eth0-TxRx-56
      4.33 ±203%    +364.8%      20.14 ±207%  interrupts.93:PCI-MSI.31981626-edge.i40e-eth0-TxRx-57
      0.00       +2.2e+104%     216.00 ±208%  interrupts.94:PCI-MSI.31981627-edge.i40e-eth0-TxRx-58
      0.00       +2.6e+103%      25.86 ±241%  interrupts.95:PCI-MSI.31981628-edge.i40e-eth0-TxRx-59
     73.00 ±213%     -88.8%       8.14 ±230%  interrupts.96:PCI-MSI.31981629-edge.i40e-eth0-TxRx-60
      0.67 ±223%    +178.6%       1.86 ±163%  interrupts.97:PCI-MSI.31981630-edge.i40e-eth0-TxRx-61
      0.17 ±223%    +757.1%       1.43 ±193%  interrupts.98:PCI-MSI.31981631-edge.i40e-eth0-TxRx-62
      0.67 ±223%  +32192.9%     215.29 ±244%  interrupts.99:PCI-MSI.31981632-edge.i40e-eth0-TxRx-63
    531.33 ±  5%    +143.3%       1292 ± 15%  interrupts.9:IO-APIC.9-fasteoi.acpi
  62356277 ± 17%     -31.1%   42978924 ± 23%  interrupts.CAL:Function_call_interrupts
      0.00          -100.0%       0.00        interrupts.CPU0.0:IO-APIC.2-edge.timer
      0.50 ±100%     -14.3%       0.43 ±115%  interrupts.CPU0.119:PCI-MSI.31981652-edge.i40e-eth0-TxRx-83
      0.00       +3.9e+102%       3.86 ±125%  interrupts.CPU0.36:PCI-MSI.31981569-edge.i40e-eth0-TxRx-0
      0.00       +2.9e+101%       0.29 ±158%  interrupts.CPU0.71:PCI-MSI.31981604-edge.i40e-eth0-TxRx-35
    622301 ± 20%     -22.9%     479757 ± 52%  interrupts.CPU0.CAL:Function_call_interrupts
      6.33 ± 46%    +154.9%      16.14 ± 13%  interrupts.CPU0.IWI:IRQ_work_interrupts
    533903 ±  6%    +142.0%    1291996 ± 15%  interrupts.CPU0.LOC:Local_timer_interrupts
      0.00       +1.6e+102%       1.57 ± 31%  interrupts.CPU0.MCP:Machine_check_polls
      5891 ± 28%     +31.9%       7769        interrupts.CPU0.NMI:Non-maskable_interrupts
      5891 ± 28%     +31.9%       7769        interrupts.CPU0.PMI:Performance_monitoring_interrupts
   1283181 ± 11%     -34.7%     838537 ± 13%  interrupts.CPU0.RES:Rescheduling_interrupts
      0.00          -100.0%       0.00        interrupts.CPU0.RTR:APIC_ICR_read_retries
     96.17 ±126%     +13.6%     109.29 ± 94%  interrupts.CPU0.TLB:TLB_shootdowns
      0.00       +1.4e+101%       0.14 ±244%  interrupts.CPU1.120:PCI-MSI.31981653-edge.i40e-eth0-TxRx-84
      1.33 ±223%     +50.0%       2.00 ±153%  interrupts.CPU1.37:PCI-MSI.31981570-edge.i40e-eth0-TxRx-1
      0.17 ±223%    +414.3%       0.86 ± 40%  interrupts.CPU1.72:PCI-MSI.31981605-edge.i40e-eth0-TxRx-36
    531.33 ±  5%    +143.3%       1292 ± 15%  interrupts.CPU1.9:IO-APIC.9-fasteoi.acpi
    671995 ± 24%     -50.2%     334711 ± 37%  interrupts.CPU1.CAL:Function_call_interrupts
      5.50 ± 54%    +196.1%      16.29 ± 14%  interrupts.CPU1.IWI:IRQ_work_interrupts
    533816 ±  6%    +142.0%    1292015 ± 15%  interrupts.CPU1.LOC:Local_timer_interrupts
      0.00       +1.6e+102%       1.57 ± 31%  interrupts.CPU1.MCP:Machine_check_polls
      5278 ± 34%     +47.2%       7769        interrupts.CPU1.NMI:Non-maskable_interrupts
      5278 ± 34%     +47.2%       7769        interrupts.CPU1.PMI:Performance_monitoring_interrupts
   1366933 ±  6%     -41.5%     799605 ± 14%  interrupts.CPU1.RES:Rescheduling_interrupts
     15.33 ± 92%     +78.9%      27.43 ± 98%  interrupts.CPU1.TLB:TLB_shootdowns
      0.17 ±223%     +71.4%       0.29 ±158%  interrupts.CPU10.129:PCI-MSI.31981662-edge.i40e-eth0-TxRx-93
      0.00          -100.0%       0.00        interrupts.CPU10.293:PCI-MSI.327680-edge.xhci_hcd
     15.67 ±220%    +386.0%      76.14 ±238%  interrupts.CPU10.46:PCI-MSI.31981579-edge.i40e-eth0-TxRx-10
      0.33 ±141%     -57.1%       0.14 ±244%  interrupts.CPU10.81:PCI-MSI.31981614-edge.i40e-eth0-TxRx-45
    660134 ± 24%     -50.3%     328400 ± 35%  interrupts.CPU10.CAL:Function_call_interrupts
      6.00 ± 45%    +166.7%      16.00 ± 12%  interrupts.CPU10.IWI:IRQ_work_interrupts
    533839 ±  6%    +142.0%    1292014 ± 15%  interrupts.CPU10.LOC:Local_timer_interrupts
      0.00       +1.6e+102%       1.57 ± 31%  interrupts.CPU10.MCP:Machine_check_polls
      6438 ± 20%     +12.0%       7207 ± 18%  interrupts.CPU10.NMI:Non-maskable_interrupts
      6438 ± 20%     +12.0%       7207 ± 18%  interrupts.CPU10.PMI:Performance_monitoring_interrupts
   1278397 ± 16%     -37.2%     802632 ± 13%  interrupts.CPU10.RES:Rescheduling_interrupts
      9.00 ±127%    +131.7%      20.86 ± 97%  interrupts.CPU10.TLB:TLB_shootdowns
      1.50 ±195%    +376.2%       7.14 ±177%  interrupts.CPU11.47:PCI-MSI.31981580-edge.i40e-eth0-TxRx-11
      0.00       +3.7e+103%      36.57 ± 63%  interrupts.CPU11.4:IO-APIC.4-edge.ttyS0
      0.00          -100.0%       0.00        interrupts.CPU11.82:PCI-MSI.31981615-edge.i40e-eth0-TxRx-46
      0.00          -100.0%       0.00        interrupts.CPU11.8:IO-APIC.8-edge.rtc0
    662199 ± 15%     -48.6%     340111 ± 31%  interrupts.CPU11.CAL:Function_call_interrupts
      6.33 ± 40%    +154.9%      16.14 ± 13%  interrupts.CPU11.IWI:IRQ_work_interrupts
    533825 ±  6%    +142.0%    1292065 ± 15%  interrupts.CPU11.LOC:Local_timer_interrupts
      0.00       +1.6e+102%       1.57 ± 31%  interrupts.CPU11.MCP:Machine_check_polls
      7021           +10.7%       7769        interrupts.CPU11.NMI:Non-maskable_interrupts
      7021           +10.7%       7769        interrupts.CPU11.PMI:Performance_monitoring_interrupts
   1256553 ±  6%     -36.7%     795582 ± 13%  interrupts.CPU11.RES:Rescheduling_interrupts
     11.67 ±135%     +94.7%      22.71 ±104%  interrupts.CPU11.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU12.295:PCI-MSI.65536-edge.ioat-msix
      1.50 ±223%    -100.0%       0.00        interrupts.CPU12.48:PCI-MSI.31981581-edge.i40e-eth0-TxRx-12
      0.00       +2.9e+101%       0.29 ±158%  interrupts.CPU12.83:PCI-MSI.31981616-edge.i40e-eth0-TxRx-47
    648029 ± 38%     -49.8%     325419 ± 33%  interrupts.CPU12.CAL:Function_call_interrupts
      6.17 ± 42%    +159.5%      16.00 ± 13%  interrupts.CPU12.IWI:IRQ_work_interrupts
    533894 ±  6%    +142.0%    1292006 ± 15%  interrupts.CPU12.LOC:Local_timer_interrupts
      0.00       +1.6e+102%       1.57 ± 31%  interrupts.CPU12.MCP:Machine_check_polls
      7013            +2.8%       7207 ± 18%  interrupts.CPU12.NMI:Non-maskable_interrupts
      7013            +2.8%       7207 ± 18%  interrupts.CPU12.PMI:Performance_monitoring_interrupts
   1284085 ±  9%     -37.0%     809469 ± 15%  interrupts.CPU12.RES:Rescheduling_interrupts
     12.83 ±153%     +24.7%      16.00 ±113%  interrupts.CPU12.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU13.297:PCI-MSI.67584-edge.ioat-msix
      0.00       +2.9e+101%       0.29 ±158%  interrupts.CPU13.36:PCI-MSI.31981569-edge.i40e-eth0-TxRx-0
     10.00 ±189%   +2525.7%     262.57 ±243%  interrupts.CPU13.49:PCI-MSI.31981582-edge.i40e-eth0-TxRx-13
      0.17 ±223%    +157.1%       0.43 ±115%  interrupts.CPU13.84:PCI-MSI.31981617-edge.i40e-eth0-TxRx-48
    582002 ± 24%     -32.2%     394409 ± 38%  interrupts.CPU13.CAL:Function_call_interrupts
      6.33 ± 47%    +154.9%      16.14 ± 13%  interrupts.CPU13.IWI:IRQ_work_interrupts
    533832 ±  6%    +142.0%    1292055 ± 15%  interrupts.CPU13.LOC:Local_timer_interrupts
      0.00       +1.6e+102%       1.57 ± 31%  interrupts.CPU13.MCP:Machine_check_polls
      7019           +10.7%       7771        interrupts.CPU13.NMI:Non-maskable_interrupts
      7019           +10.7%       7771        interrupts.CPU13.PMI:Performance_monitoring_interrupts
   1233899 ± 13%     -33.3%     822666 ± 13%  interrupts.CPU13.RES:Rescheduling_interrupts
     18.67 ±184%     -43.4%      10.57 ± 86%  interrupts.CPU13.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU14.298:PCI-MSI.69632-edge.ioat-msix
      0.17 ±223%     +71.4%       0.29 ±158%  interrupts.CPU14.37:PCI-MSI.31981570-edge.i40e-eth0-TxRx-1
     14.50 ±157%   +7266.5%       1068 ±244%  interrupts.CPU14.50:PCI-MSI.31981583-edge.i40e-eth0-TxRx-14
      0.00       +7.1e+101%       0.71 ± 63%  interrupts.CPU14.85:PCI-MSI.31981618-edge.i40e-eth0-TxRx-49
    557479 ± 39%     -30.0%     390003 ± 33%  interrupts.CPU14.CAL:Function_call_interrupts
      5.83 ± 47%    +174.3%      16.00 ± 13%  interrupts.CPU14.IWI:IRQ_work_interrupts
    533855 ±  6%    +142.0%    1292068 ± 15%  interrupts.CPU14.LOC:Local_timer_interrupts
      0.00       +1.6e+102%       1.57 ± 31%  interrupts.CPU14.MCP:Machine_check_polls
      5855 ± 28%     +23.1%       7209 ± 18%  interrupts.CPU14.NMI:Non-maskable_interrupts
      5855 ± 28%     +23.1%       7209 ± 18%  interrupts.CPU14.PMI:Performance_monitoring_interrupts
   1302542 ± 15%     -37.3%     816247 ± 14%  interrupts.CPU14.RES:Rescheduling_interrupts
      3.67 ±139%    +402.6%      18.43 ± 85%  interrupts.CPU14.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU15.298:PCI-MSI.69632-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU15.299:PCI-MSI.69632-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU15.299:PCI-MSI.71680-edge.ioat-msix
      0.17 ±223%    +242.9%       0.57 ± 86%  interrupts.CPU15.38:PCI-MSI.31981571-edge.i40e-eth0-TxRx-2
      1333 ±222%     -99.8%       2.86 ±118%  interrupts.CPU15.51:PCI-MSI.31981584-edge.i40e-eth0-TxRx-15
      0.17 ±223%     +71.4%       0.29 ±158%  interrupts.CPU15.86:PCI-MSI.31981619-edge.i40e-eth0-TxRx-50
    567786 ± 17%     -32.1%     385513 ± 42%  interrupts.CPU15.CAL:Function_call_interrupts
      5.83 ± 47%    +171.8%      15.86 ± 13%  interrupts.CPU15.IWI:IRQ_work_interrupts
    533749 ±  6%    +142.1%    1291988 ± 15%  interrupts.CPU15.LOC:Local_timer_interrupts
      0.00       +1.6e+102%       1.57 ± 31%  interrupts.CPU15.MCP:Machine_check_polls
      5842 ± 28%     +14.0%       6663 ± 26%  interrupts.CPU15.NMI:Non-maskable_interrupts
      5842 ± 28%     +14.0%       6663 ± 26%  interrupts.CPU15.PMI:Performance_monitoring_interrupts
   1293773 ± 13%     -37.3%     811820 ± 14%  interrupts.CPU15.RES:Rescheduling_interrupts
      2.83 ±100%    +263.0%      10.29 ±104%  interrupts.CPU15.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU16.299:PCI-MSI.71680-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU16.300:PCI-MSI.71680-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU16.300:PCI-MSI.73728-edge.ioat-msix
      0.00       +5.7e+101%       0.57 ± 86%  interrupts.CPU16.39:PCI-MSI.31981572-edge.i40e-eth0-TxRx-3
    183.17 ±223%     -78.9%      38.57 ±145%  interrupts.CPU16.52:PCI-MSI.31981585-edge.i40e-eth0-TxRx-16
      0.17 ±223%    +242.9%       0.57 ± 86%  interrupts.CPU16.87:PCI-MSI.31981620-edge.i40e-eth0-TxRx-51
    629194 ± 35%     -42.1%     364107 ± 33%  interrupts.CPU16.CAL:Function_call_interrupts
      6.00 ± 45%    +178.6%      16.71 ± 11%  interrupts.CPU16.IWI:IRQ_work_interrupts
    533895 ±  6%    +142.0%    1291992 ± 15%  interrupts.CPU16.LOC:Local_timer_interrupts
      0.00       +1.6e+102%       1.57 ± 31%  interrupts.CPU16.MCP:Machine_check_polls
      6432 ± 20%     +21.0%       7780        interrupts.CPU16.NMI:Non-maskable_interrupts
      6432 ± 20%     +21.0%       7780        interrupts.CPU16.PMI:Performance_monitoring_interrupts
   1243344 ±  9%     -35.3%     804984 ± 13%  interrupts.CPU16.RES:Rescheduling_interrupts
      1.50 ± 63%    +538.1%       9.57 ±125%  interrupts.CPU16.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU17.300:PCI-MSI.73728-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU17.301:PCI-MSI.73728-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU17.301:PCI-MSI.75776-edge.ioat-msix
      0.33 ±141%     -14.3%       0.29 ±158%  interrupts.CPU17.40:PCI-MSI.31981573-edge.i40e-eth0-TxRx-4
    391.67 ±222%     -99.3%       2.71 ±137%  interrupts.CPU17.53:PCI-MSI.31981586-edge.i40e-eth0-TxRx-17
      0.00          -100.0%       0.00        interrupts.CPU17.88:PCI-MSI.31981621-edge.i40e-eth0-TxRx-52
    593738 ± 15%     -38.6%     364363 ± 29%  interrupts.CPU17.CAL:Function_call_interrupts
      6.17 ± 42%    +161.8%      16.14 ± 13%  interrupts.CPU17.IWI:IRQ_work_interrupts
    533825 ±  6%    +142.0%    1292064 ± 15%  interrupts.CPU17.LOC:Local_timer_interrupts
      0.00       +1.6e+102%       1.57 ± 31%  interrupts.CPU17.MCP:Machine_check_polls
      7011           +10.8%       7767        interrupts.CPU17.NMI:Non-maskable_interrupts
      7011           +10.8%       7767        interrupts.CPU17.PMI:Performance_monitoring_interrupts
   1278843 ±  9%     -36.9%     807299 ± 15%  interrupts.CPU17.RES:Rescheduling_interrupts
      2.00 ± 95%    +185.7%       5.71 ± 66%  interrupts.CPU17.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU18.301:PCI-MSI.75776-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU18.302:PCI-MSI.75776-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU18.302:PCI-MSI.77824-edge.ioat-msix
      0.00       +1.4e+101%       0.14 ±244%  interrupts.CPU18.41:PCI-MSI.31981574-edge.i40e-eth0-TxRx-5
      0.00       +2.9e+101%       0.29 ±158%  interrupts.CPU18.54:PCI-MSI.31981587-edge.i40e-eth0-TxRx-18
      0.00          -100.0%       0.00        interrupts.CPU18.89:PCI-MSI.31981622-edge.i40e-eth0-TxRx-53
    547462 ± 26%     -29.1%     388351 ± 32%  interrupts.CPU18.CAL:Function_call_interrupts
      6.00 ± 45%    +166.7%      16.00 ± 12%  interrupts.CPU18.IWI:IRQ_work_interrupts
    533806 ±  6%    +142.0%    1292045 ± 15%  interrupts.CPU18.LOC:Local_timer_interrupts
      0.00       +1.6e+102%       1.57 ± 31%  interrupts.CPU18.MCP:Machine_check_polls
      6424 ± 20%     +12.2%       7207 ± 18%  interrupts.CPU18.NMI:Non-maskable_interrupts
      6424 ± 20%     +12.2%       7207 ± 18%  interrupts.CPU18.PMI:Performance_monitoring_interrupts
   1199528 ± 10%     -32.9%     805421 ± 13%  interrupts.CPU18.RES:Rescheduling_interrupts
     59.33 ±213%     -89.4%       6.29 ±118%  interrupts.CPU18.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU19.302:PCI-MSI.77824-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU19.303:PCI-MSI.77824-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU19.303:PCI-MSI.79872-edge.ioat-msix
      0.17 ±223%     +71.4%       0.29 ±158%  interrupts.CPU19.42:PCI-MSI.31981575-edge.i40e-eth0-TxRx-6
      3949 ±223%    -100.0%       0.86 ±131%  interrupts.CPU19.55:PCI-MSI.31981588-edge.i40e-eth0-TxRx-19
      0.17 ±223%    -100.0%       0.00        interrupts.CPU19.90:PCI-MSI.31981623-edge.i40e-eth0-TxRx-54
    626245 ± 32%     -39.4%     379607 ± 45%  interrupts.CPU19.CAL:Function_call_interrupts
      6.33 ± 40%    +154.9%      16.14 ± 13%  interrupts.CPU19.IWI:IRQ_work_interrupts
    534017 ±  6%    +141.9%    1292023 ± 15%  interrupts.CPU19.LOC:Local_timer_interrupts
      0.00       +1.6e+102%       1.57 ± 31%  interrupts.CPU19.MCP:Machine_check_polls
      7030           +10.5%       7768        interrupts.CPU19.NMI:Non-maskable_interrupts
      7030           +10.5%       7768        interrupts.CPU19.PMI:Performance_monitoring_interrupts
   1156948 ± 11%     -28.9%     823062 ± 13%  interrupts.CPU19.RES:Rescheduling_interrupts
      2.83 ±102%    +167.2%       7.57 ± 95%  interrupts.CPU19.TLB:TLB_shootdowns
      0.00       +1.4e+101%       0.14 ±244%  interrupts.CPU2.121:PCI-MSI.31981654-edge.i40e-eth0-TxRx-85
    185.67 ±222%    +383.0%     896.86 ±159%  interrupts.CPU2.38:PCI-MSI.31981571-edge.i40e-eth0-TxRx-2
      0.00       +1.4e+101%       0.14 ±244%  interrupts.CPU2.73:PCI-MSI.31981606-edge.i40e-eth0-TxRx-37
    676534 ± 23%     -47.2%     357517 ± 30%  interrupts.CPU2.CAL:Function_call_interrupts
      5.50 ± 53%    +209.1%      17.00 ± 14%  interrupts.CPU2.IWI:IRQ_work_interrupts
    533935 ±  6%    +142.0%    1292063 ± 15%  interrupts.CPU2.LOC:Local_timer_interrupts
      0.00       +1.6e+102%       1.57 ± 31%  interrupts.CPU2.MCP:Machine_check_polls
      6473 ± 20%     +20.6%       7808        interrupts.CPU2.NMI:Non-maskable_interrupts
      6473 ± 20%     +20.6%       7808        interrupts.CPU2.PMI:Performance_monitoring_interrupts
   1210252 ±  5%     -33.2%     808133 ± 11%  interrupts.CPU2.RES:Rescheduling_interrupts
     19.17 ± 89%     +23.0%      23.57 ± 82%  interrupts.CPU2.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU20.303:PCI-MSI.77824-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU20.303:PCI-MSI.79872-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU20.304:PCI-MSI.79872-edge.ioat-msix
      0.00       +1.4e+101%       0.14 ±244%  interrupts.CPU20.43:PCI-MSI.31981576-edge.i40e-eth0-TxRx-7
      0.00       +4.1e+104%     405.43 ±227%  interrupts.CPU20.56:PCI-MSI.31981589-edge.i40e-eth0-TxRx-20
      0.17 ±223%     -14.3%       0.14 ±244%  interrupts.CPU20.91:PCI-MSI.31981624-edge.i40e-eth0-TxRx-55
    580262 ± 23%     -32.4%     392368 ± 33%  interrupts.CPU20.CAL:Function_call_interrupts
      5.83 ± 47%    +176.7%      16.14 ± 13%  interrupts.CPU20.IWI:IRQ_work_interrupts
    533817 ±  6%    +142.0%    1292093 ± 15%  interrupts.CPU20.LOC:Local_timer_interrupts
      0.00       +1.6e+102%       1.57 ± 31%  interrupts.CPU20.MCP:Machine_check_polls
      5852 ± 28%     +32.7%       7767        interrupts.CPU20.NMI:Non-maskable_interrupts
      5852 ± 28%     +32.7%       7767        interrupts.CPU20.PMI:Performance_monitoring_interrupts
   1259936 ± 10%     -33.9%     832960 ± 13%  interrupts.CPU20.RES:Rescheduling_interrupts
      4.17 ± 96%     +13.1%       4.71 ± 79%  interrupts.CPU20.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU21.304:PCI-MSI.79872-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU21.307:PCI-MSI.376832-edge.ahci[0000:00:17.0]
      0.00          -100.0%       0.00        interrupts.CPU21.313:PCI-MSI.376832-edge.ahci[0000:00:17.0]
      0.00          -100.0%       0.00        interrupts.CPU21.315:PCI-MSI.376832-edge.ahci[0000:00:17.0]
      0.33 ±141%     -57.1%       0.14 ±244%  interrupts.CPU21.44:PCI-MSI.31981577-edge.i40e-eth0-TxRx-8
      1.67 ±197%    -100.0%       0.00        interrupts.CPU21.57:PCI-MSI.31981590-edge.i40e-eth0-TxRx-21
      0.17 ±223%     -14.3%       0.14 ±244%  interrupts.CPU21.92:PCI-MSI.31981625-edge.i40e-eth0-TxRx-56
    622597 ± 21%     -41.8%     362482 ± 25%  interrupts.CPU21.CAL:Function_call_interrupts
      6.17 ± 49%    +161.8%      16.14 ± 13%  interrupts.CPU21.IWI:IRQ_work_interrupts
    533798 ±  6%    +142.0%    1292043 ± 15%  interrupts.CPU21.LOC:Local_timer_interrupts
      0.00       +1.6e+102%       1.57 ± 31%  interrupts.CPU21.MCP:Machine_check_polls
      6423 ± 20%     +20.9%       7767        interrupts.CPU21.NMI:Non-maskable_interrupts
      6423 ± 20%     +20.9%       7767        interrupts.CPU21.PMI:Performance_monitoring_interrupts
   1257623 ±  8%     -35.1%     815944 ± 14%  interrupts.CPU21.RES:Rescheduling_interrupts
      3.50 ± 88%    +128.6%       8.00 ± 99%  interrupts.CPU21.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU22.315:PCI-MSI.376832-edge.ahci[0000:00:17.0]
      0.00          -100.0%       0.00        interrupts.CPU22.3:IO-APIC.3-edge
      0.33 ±141%    -100.0%       0.00        interrupts.CPU22.45:PCI-MSI.31981578-edge.i40e-eth0-TxRx-9
      3.50 ±223%   +6455.1%     229.43 ±190%  interrupts.CPU22.58:PCI-MSI.31981591-edge.i40e-eth0-TxRx-22
      0.17 ±223%    +157.1%       0.43 ±115%  interrupts.CPU22.93:PCI-MSI.31981626-edge.i40e-eth0-TxRx-57
    589971 ± 24%     -31.4%     404554 ± 44%  interrupts.CPU22.CAL:Function_call_interrupts
      6.17 ± 42%    +166.4%      16.43 ± 12%  interrupts.CPU22.IWI:IRQ_work_interrupts
    533844 ±  6%    +142.0%    1291998 ± 15%  interrupts.CPU22.LOC:Local_timer_interrupts
      0.00       +1.6e+102%       1.57 ± 31%  interrupts.CPU22.MCP:Machine_check_polls
      7027           +10.6%       7773        interrupts.CPU22.NMI:Non-maskable_interrupts
      7027           +10.6%       7773        interrupts.CPU22.PMI:Performance_monitoring_interrupts
   1247346 ±  7%     -33.6%     827683 ± 16%  interrupts.CPU22.RES:Rescheduling_interrupts
      7.83 ±101%     -30.7%       5.43 ± 89%  interrupts.CPU22.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU23.3:IO-APIC.3-edge
      0.17 ±223%    -100.0%       0.00        interrupts.CPU23.46:PCI-MSI.31981579-edge.i40e-eth0-TxRx-10
      4.67 ±127%  +58687.8%       2743 ±244%  interrupts.CPU23.59:PCI-MSI.31981592-edge.i40e-eth0-TxRx-23
      0.00       +5.7e+101%       0.57 ± 86%  interrupts.CPU23.94:PCI-MSI.31981627-edge.i40e-eth0-TxRx-58
    601667 ± 36%     -42.6%     345280 ± 32%  interrupts.CPU23.CAL:Function_call_interrupts
      6.17 ± 42%    +161.8%      16.14 ± 13%  interrupts.CPU23.IWI:IRQ_work_interrupts
    533936 ±  6%    +142.0%    1292001 ± 15%  interrupts.CPU23.LOC:Local_timer_interrupts
      0.00       +1.6e+102%       1.57 ± 31%  interrupts.CPU23.MCP:Machine_check_polls
      7012           +10.8%       7771        interrupts.CPU23.NMI:Non-maskable_interrupts
      7012           +10.8%       7771        interrupts.CPU23.PMI:Performance_monitoring_interrupts
   1194338 ± 11%     -33.2%     798317 ± 13%  interrupts.CPU23.RES:Rescheduling_interrupts
      5.33 ± 85%     -27.7%       3.86 ± 94%  interrupts.CPU23.TLB:TLB_shootdowns
      9.00 ±223%     +22.2%      11.00 ±166%  interrupts.CPU24.60:PCI-MSI.31981593-edge.i40e-eth0-TxRx-24
    693190 ± 19%      -2.6%     675224 ± 29%  interrupts.CPU24.CAL:Function_call_interrupts
      6.17 ± 49%    +159.5%      16.00 ± 13%  interrupts.CPU24.IWI:IRQ_work_interrupts
    533739 ±  6%    +142.0%    1291888 ± 15%  interrupts.CPU24.LOC:Local_timer_interrupts
      0.00       +1.6e+102%       1.57 ± 31%  interrupts.CPU24.MCP:Machine_check_polls
      6675 ± 20%      +8.2%       7223 ± 18%  interrupts.CPU24.NMI:Non-maskable_interrupts
      6675 ± 20%      +8.2%       7223 ± 18%  interrupts.CPU24.PMI:Performance_monitoring_interrupts
   1224547 ±  9%     -29.3%     865430 ± 10%  interrupts.CPU24.RES:Rescheduling_interrupts
     34.83 ± 97%    +145.7%      85.57 ±105%  interrupts.CPU24.TLB:TLB_shootdowns
      1.50 ±195%  +32319.0%     486.29 ±244%  interrupts.CPU25.61:PCI-MSI.31981594-edge.i40e-eth0-TxRx-25
    658867 ± 12%     -12.8%     574491 ± 31%  interrupts.CPU25.CAL:Function_call_interrupts
      6.33 ± 47%    +150.4%      15.86 ± 15%  interrupts.CPU25.IWI:IRQ_work_interrupts
    533878 ±  6%    +142.0%    1291790 ± 15%  interrupts.CPU25.LOC:Local_timer_interrupts
      0.00       +1.6e+102%       1.57 ± 31%  interrupts.CPU25.MCP:Machine_check_polls
      7278            -8.4%       6664 ± 26%  interrupts.CPU25.NMI:Non-maskable_interrupts
      7278            -8.4%       6664 ± 26%  interrupts.CPU25.PMI:Performance_monitoring_interrupts
   1265056 ±  9%     -27.3%     919591 ± 12%  interrupts.CPU25.RES:Rescheduling_interrupts
     45.50 ±116%      -5.5%      43.00 ±104%  interrupts.CPU25.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU26.305:PCI-MSI.67174400-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU26.306:PCI-MSI.67174400-edge.ioat-msix
      1.00 ±223%    +142.9%       2.43 ±199%  interrupts.CPU26.62:PCI-MSI.31981595-edge.i40e-eth0-TxRx-26
    718908 ± 31%     -31.3%     494109 ± 28%  interrupts.CPU26.CAL:Function_call_interrupts
      6.83 ± 59%    +132.1%      15.86 ± 14%  interrupts.CPU26.IWI:IRQ_work_interrupts
    533812 ±  6%    +142.0%    1291887 ± 15%  interrupts.CPU26.LOC:Local_timer_interrupts
      0.00       +1.6e+102%       1.57 ± 31%  interrupts.CPU26.MCP:Machine_check_polls
      7293            -8.6%       6663 ± 26%  interrupts.CPU26.NMI:Non-maskable_interrupts
      7293            -8.6%       6663 ± 26%  interrupts.CPU26.PMI:Performance_monitoring_interrupts
   1338471 ± 11%     -29.8%     939558 ± 10%  interrupts.CPU26.RES:Rescheduling_interrupts
      7.83 ±118%    +239.2%      26.57 ±144%  interrupts.CPU26.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU27.307:PCI-MSI.67176448-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU27.308:PCI-MSI.67176448-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU27.309:PCI-MSI.67176448-edge.ioat-msix
      1.50 ±120%   +1090.5%      17.86 ±235%  interrupts.CPU27.63:PCI-MSI.31981596-edge.i40e-eth0-TxRx-27
    694162 ± 34%     -32.8%     466581 ± 35%  interrupts.CPU27.CAL:Function_call_interrupts
      6.17 ± 42%    +161.8%      16.14 ± 13%  interrupts.CPU27.IWI:IRQ_work_interrupts
    533927 ±  6%    +142.0%    1291857 ± 15%  interrupts.CPU27.LOC:Local_timer_interrupts
      0.00       +1.6e+102%       1.57 ± 31%  interrupts.CPU27.MCP:Machine_check_polls
      7282            +6.9%       7787        interrupts.CPU27.NMI:Non-maskable_interrupts
      7282            +6.9%       7787        interrupts.CPU27.PMI:Performance_monitoring_interrupts
   1393978 ± 10%     -35.4%     900599 ± 11%  interrupts.CPU27.RES:Rescheduling_interrupts
      5.33 ±117%    +339.3%      23.43 ±114%  interrupts.CPU27.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU28.306:PCI-MSI.67174400-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU28.308:PCI-MSI.67178496-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU28.309:PCI-MSI.67178496-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU28.310:PCI-MSI.67178496-edge.ioat-msix
    185.83 ±221%     -72.2%      51.71 ±161%  interrupts.CPU28.64:PCI-MSI.31981597-edge.i40e-eth0-TxRx-28
    620285 ± 17%     -24.5%     468491 ± 24%  interrupts.CPU28.CAL:Function_call_interrupts
      6.17 ± 49%    +159.5%      16.00 ± 13%  interrupts.CPU28.IWI:IRQ_work_interrupts
    533859 ±  6%    +142.0%    1291874 ± 15%  interrupts.CPU28.LOC:Local_timer_interrupts
      0.00       +1.6e+102%       1.57 ± 31%  interrupts.CPU28.MCP:Machine_check_polls
      6665 ± 20%      +8.4%       7224 ± 18%  interrupts.CPU28.NMI:Non-maskable_interrupts
      6665 ± 20%      +8.4%       7224 ± 18%  interrupts.CPU28.PMI:Performance_monitoring_interrupts
   1370870 ± 13%     -35.2%     888777 ±  9%  interrupts.CPU28.RES:Rescheduling_interrupts
      7.67 ±115%    +309.9%      31.43 ±133%  interrupts.CPU28.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU29.306:PCI-MSI.67174400-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU29.308:PCI-MSI.67176448-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU29.309:PCI-MSI.67176448-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU29.310:PCI-MSI.67180544-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU29.311:PCI-MSI.67180544-edge.ioat-msix
     94.83 ±170%     -98.0%       1.86 ±126%  interrupts.CPU29.65:PCI-MSI.31981598-edge.i40e-eth0-TxRx-29
    618061 ± 21%     -22.6%     478558 ± 26%  interrupts.CPU29.CAL:Function_call_interrupts
      6.33 ± 47%    +154.9%      16.14 ± 13%  interrupts.CPU29.IWI:IRQ_work_interrupts
    533833 ±  6%    +142.0%    1291823 ± 15%  interrupts.CPU29.LOC:Local_timer_interrupts
      0.00       +1.6e+102%       1.57 ± 31%  interrupts.CPU29.MCP:Machine_check_polls
      7275            +7.0%       7784        interrupts.CPU29.NMI:Non-maskable_interrupts
      7275            +7.0%       7784        interrupts.CPU29.PMI:Performance_monitoring_interrupts
   1395204 ±  9%     -32.7%     938501 ±  9%  interrupts.CPU29.RES:Rescheduling_interrupts
      8.33 ±161%    +237.7%      28.14 ± 85%  interrupts.CPU29.TLB:TLB_shootdowns
      0.00       +1.4e+101%       0.14 ±244%  interrupts.CPU3.122:PCI-MSI.31981655-edge.i40e-eth0-TxRx-86
      0.00       +2.6e+104%     256.43 ±243%  interrupts.CPU3.39:PCI-MSI.31981572-edge.i40e-eth0-TxRx-3
      0.00       +5.7e+101%       0.57 ± 86%  interrupts.CPU3.74:PCI-MSI.31981607-edge.i40e-eth0-TxRx-38
    616277 ± 30%     -40.2%     368283 ± 27%  interrupts.CPU3.CAL:Function_call_interrupts
      5.67 ± 50%    +184.9%      16.14 ± 11%  interrupts.CPU3.IWI:IRQ_work_interrupts
    533871 ±  6%    +142.0%    1291921 ± 15%  interrupts.CPU3.LOC:Local_timer_interrupts
      0.00       +1.6e+102%       1.57 ± 31%  interrupts.CPU3.MCP:Machine_check_polls
      6488 ± 20%     +11.4%       7227 ± 19%  interrupts.CPU3.NMI:Non-maskable_interrupts
      6488 ± 20%     +11.4%       7227 ± 19%  interrupts.CPU3.PMI:Performance_monitoring_interrupts
   1312856 ±  7%     -37.8%     816845 ± 12%  interrupts.CPU3.RES:Rescheduling_interrupts
     16.33 ±106%     +34.7%      22.00 ±108%  interrupts.CPU3.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU30.308:PCI-MSI.67176448-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU30.309:PCI-MSI.67178496-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU30.310:PCI-MSI.67178496-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU30.311:PCI-MSI.67182592-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU30.312:PCI-MSI.67182592-edge.ioat-msix
      4904 ±223%    -100.0%       1.43 ±244%  interrupts.CPU30.66:PCI-MSI.31981599-edge.i40e-eth0-TxRx-30
    645392 ± 15%      -7.6%     596331 ± 38%  interrupts.CPU30.CAL:Function_call_interrupts
      6.17 ± 49%    +164.1%      16.29 ± 14%  interrupts.CPU30.IWI:IRQ_work_interrupts
    533818 ±  6%    +142.0%    1291910 ± 15%  interrupts.CPU30.LOC:Local_timer_interrupts
      0.00       +1.6e+102%       1.57 ± 31%  interrupts.CPU30.MCP:Machine_check_polls
      6676 ± 20%     +16.7%       7789        interrupts.CPU30.NMI:Non-maskable_interrupts
      6676 ± 20%     +16.7%       7789        interrupts.CPU30.PMI:Performance_monitoring_interrupts
   1357123 ± 10%     -32.4%     917852 ±  9%  interrupts.CPU30.RES:Rescheduling_interrupts
     10.67 ±102%    +154.5%      27.14 ± 94%  interrupts.CPU30.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU31.309:PCI-MSI.67178496-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU31.310:PCI-MSI.67180544-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU31.311:PCI-MSI.67180544-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU31.312:PCI-MSI.67184640-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU31.313:PCI-MSI.67184640-edge.ioat-msix
    317.17 ±223%     +76.8%     560.86 ±244%  interrupts.CPU31.67:PCI-MSI.31981600-edge.i40e-eth0-TxRx-31
    697355 ± 24%     -29.7%     490054 ± 21%  interrupts.CPU31.CAL:Function_call_interrupts
      6.33 ± 47%    +152.6%      16.00 ± 13%  interrupts.CPU31.IWI:IRQ_work_interrupts
    533831 ±  6%    +142.0%    1291905 ± 15%  interrupts.CPU31.LOC:Local_timer_interrupts
      0.00       +1.6e+102%       1.57 ± 31%  interrupts.CPU31.MCP:Machine_check_polls
      7322            -1.3%       7224 ± 18%  interrupts.CPU31.NMI:Non-maskable_interrupts
      7322            -1.3%       7224 ± 18%  interrupts.CPU31.PMI:Performance_monitoring_interrupts
   1297695 ± 10%     -29.8%     910518 ±  8%  interrupts.CPU31.RES:Rescheduling_interrupts
      4.67 ± 92%    +524.5%      29.14 ±114%  interrupts.CPU31.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU32.310:PCI-MSI.67180544-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU32.311:PCI-MSI.67182592-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU32.312:PCI-MSI.67182592-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU32.313:PCI-MSI.67186688-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU32.314:PCI-MSI.67186688-edge.ioat-msix
      1.67 ±197%     -91.4%       0.14 ±244%  interrupts.CPU32.68:PCI-MSI.31981601-edge.i40e-eth0-TxRx-32
    692491 ± 25%     -29.8%     486256 ± 29%  interrupts.CPU32.CAL:Function_call_interrupts
      6.17 ± 42%    +157.1%      15.86 ± 13%  interrupts.CPU32.IWI:IRQ_work_interrupts
    533799 ±  6%    +142.0%    1291945 ± 15%  interrupts.CPU32.LOC:Local_timer_interrupts
      0.00       +1.6e+102%       1.57 ± 31%  interrupts.CPU32.MCP:Machine_check_polls
      6691 ± 20%      -0.1%       6681 ± 26%  interrupts.CPU32.NMI:Non-maskable_interrupts
      6691 ± 20%      -0.1%       6681 ± 26%  interrupts.CPU32.PMI:Performance_monitoring_interrupts
   1397351 ±  9%     -33.2%     933095 ±  9%  interrupts.CPU32.RES:Rescheduling_interrupts
      4.33 ±104%    +536.3%      27.57 ±109%  interrupts.CPU32.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU33.311:PCI-MSI.67182592-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU33.312:PCI-MSI.67184640-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU33.313:PCI-MSI.67184640-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU33.314:PCI-MSI.67188736-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU33.315:PCI-MSI.67188736-edge.ioat-msix
      0.00       +1.1e+105%       1109 ±244%  interrupts.CPU33.69:PCI-MSI.31981602-edge.i40e-eth0-TxRx-33
    616769 ± 22%     -12.5%     539781 ± 42%  interrupts.CPU33.CAL:Function_call_interrupts
      6.67 ± 43%    +137.9%      15.86 ± 13%  interrupts.CPU33.IWI:IRQ_work_interrupts
    533865 ±  6%    +142.0%    1291948 ± 15%  interrupts.CPU33.LOC:Local_timer_interrupts
      0.00       +1.6e+102%       1.57 ± 31%  interrupts.CPU33.MCP:Machine_check_polls
      7284            -8.3%       6681 ± 26%  interrupts.CPU33.NMI:Non-maskable_interrupts
      7284            -8.3%       6681 ± 26%  interrupts.CPU33.PMI:Performance_monitoring_interrupts
   1267883 ±  8%     -27.0%     925053 ±  8%  interrupts.CPU33.RES:Rescheduling_interrupts
      3.17 ±128%    +644.4%      23.57 ± 59%  interrupts.CPU33.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU34.312:PCI-MSI.67184640-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU34.313:PCI-MSI.67186688-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU34.314:PCI-MSI.67186688-edge.ioat-msix
      0.00       +8.6e+101%       0.86 ±158%  interrupts.CPU34.70:PCI-MSI.31981603-edge.i40e-eth0-TxRx-34
    631941 ± 18%     -25.3%     472135 ± 27%  interrupts.CPU34.CAL:Function_call_interrupts
      6.33 ± 47%    +154.9%      16.14 ± 13%  interrupts.CPU34.IWI:IRQ_work_interrupts
    533712 ±  6%    +142.1%    1291920 ± 15%  interrupts.CPU34.LOC:Local_timer_interrupts
      0.00       +1.6e+102%       1.57 ± 31%  interrupts.CPU34.MCP:Machine_check_polls
      7288            +6.8%       7785        interrupts.CPU34.NMI:Non-maskable_interrupts
      7288            +6.8%       7785        interrupts.CPU34.PMI:Performance_monitoring_interrupts
   1335049 ± 15%     -32.7%     899139 ± 11%  interrupts.CPU34.RES:Rescheduling_interrupts
      5.67 ±169%    +310.9%      23.29 ± 71%  interrupts.CPU34.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU35.313:PCI-MSI.67186688-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU35.314:PCI-MSI.67188736-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU35.315:PCI-MSI.67188736-edge.ioat-msix
    192.83 ±222%     -96.3%       7.14 ±216%  interrupts.CPU35.71:PCI-MSI.31981604-edge.i40e-eth0-TxRx-35
    531508 ±  4%     -14.8%     452849 ± 31%  interrupts.CPU35.CAL:Function_call_interrupts
      6.33 ± 47%    +152.6%      16.00 ± 13%  interrupts.CPU35.IWI:IRQ_work_interrupts
    533827 ±  6%    +142.0%    1291864 ± 15%  interrupts.CPU35.LOC:Local_timer_interrupts
      0.00       +1.6e+102%       1.57 ± 31%  interrupts.CPU35.MCP:Machine_check_polls
      7358            -1.8%       7224 ± 18%  interrupts.CPU35.NMI:Non-maskable_interrupts
      7358            -1.8%       7224 ± 18%  interrupts.CPU35.PMI:Performance_monitoring_interrupts
   1324953 ±  7%     -32.5%     894151 ±  9%  interrupts.CPU35.RES:Rescheduling_interrupts
      6.50 ±122%    +240.7%      22.14 ± 64%  interrupts.CPU35.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU36.314:PCI-MSI.67188736-edge.ioat-msix
    151.17 ±221%    +968.8%       1615 ±244%  interrupts.CPU36.72:PCI-MSI.31981605-edge.i40e-eth0-TxRx-36
    707323 ± 24%     -30.0%     494905 ± 35%  interrupts.CPU36.CAL:Function_call_interrupts
      6.33 ± 47%    +152.6%      16.00 ± 12%  interrupts.CPU36.IWI:IRQ_work_interrupts
    533846 ±  6%    +142.0%    1291802 ± 15%  interrupts.CPU36.LOC:Local_timer_interrupts
      0.00       +1.6e+102%       1.57 ± 31%  interrupts.CPU36.MCP:Machine_check_polls
      7291            -0.7%       7241 ± 19%  interrupts.CPU36.NMI:Non-maskable_interrupts
      7291            -0.7%       7241 ± 19%  interrupts.CPU36.PMI:Performance_monitoring_interrupts
   1274668 ± 14%     -29.6%     897832 ± 10%  interrupts.CPU36.RES:Rescheduling_interrupts
      5.00 ±101%    +320.0%      21.00 ± 58%  interrupts.CPU36.TLB:TLB_shootdowns
      0.00       +7.1e+101%       0.71 ±244%  interrupts.CPU37.73:PCI-MSI.31981606-edge.i40e-eth0-TxRx-37
    593316 ± 27%     -26.3%     437156 ± 25%  interrupts.CPU37.CAL:Function_call_interrupts
      6.17 ± 49%    +161.8%      16.14 ± 14%  interrupts.CPU37.IWI:IRQ_work_interrupts
    533754 ±  6%    +142.0%    1291718 ± 15%  interrupts.CPU37.LOC:Local_timer_interrupts
      0.00       +1.6e+102%       1.57 ± 31%  interrupts.CPU37.MCP:Machine_check_polls
      6672 ± 20%      +0.3%       6691 ± 27%  interrupts.CPU37.NMI:Non-maskable_interrupts
      6672 ± 20%      +0.3%       6691 ± 27%  interrupts.CPU37.PMI:Performance_monitoring_interrupts
   1315851 ± 14%     -31.0%     907404 ±  8%  interrupts.CPU37.RES:Rescheduling_interrupts
      7.00 ±122%    +206.1%      21.43 ± 59%  interrupts.CPU37.TLB:TLB_shootdowns
      0.83 ±223%    +191.4%       2.43 ±129%  interrupts.CPU38.74:PCI-MSI.31981607-edge.i40e-eth0-TxRx-38
    699663 ± 21%     -19.3%     564968 ± 31%  interrupts.CPU38.CAL:Function_call_interrupts
      6.17 ± 42%    +157.1%      15.86 ± 14%  interrupts.CPU38.IWI:IRQ_work_interrupts
    533825 ±  6%    +142.0%    1291895 ± 15%  interrupts.CPU38.LOC:Local_timer_interrupts
      0.00       +1.6e+102%       1.57 ± 31%  interrupts.CPU38.MCP:Machine_check_polls
      6670 ± 20%      -8.4%       6111 ± 31%  interrupts.CPU38.NMI:Non-maskable_interrupts
      6670 ± 20%      -8.4%       6111 ± 31%  interrupts.CPU38.PMI:Performance_monitoring_interrupts
   1365085 ± 10%     -32.5%     921095 ±  9%  interrupts.CPU38.RES:Rescheduling_interrupts
      7.67 ± 65%     +34.2%      10.29 ± 75%  interrupts.CPU38.TLB:TLB_shootdowns
     20.00 ±221%     -98.6%       0.29 ±158%  interrupts.CPU39.75:PCI-MSI.31981608-edge.i40e-eth0-TxRx-39
    763943 ± 25%     -40.1%     457974 ± 27%  interrupts.CPU39.CAL:Function_call_interrupts
      6.17 ± 42%    +159.5%      16.00 ± 14%  interrupts.CPU39.IWI:IRQ_work_interrupts
    533735 ±  6%    +142.0%    1291841 ± 15%  interrupts.CPU39.LOC:Local_timer_interrupts
      0.00       +1.6e+102%       1.57 ± 31%  interrupts.CPU39.MCP:Machine_check_polls
      6673 ± 20%      +8.2%       7222 ± 18%  interrupts.CPU39.NMI:Non-maskable_interrupts
      6673 ± 20%      +8.2%       7222 ± 18%  interrupts.CPU39.PMI:Performance_monitoring_interrupts
   1296584 ±  7%     -29.6%     912210 ±  8%  interrupts.CPU39.RES:Rescheduling_interrupts
      7.50 ± 79%      -2.9%       7.29 ± 76%  interrupts.CPU39.TLB:TLB_shootdowns
      0.17 ±223%    +242.9%       0.57 ± 86%  interrupts.CPU4.123:PCI-MSI.31981656-edge.i40e-eth0-TxRx-87
     32.33 ±120%      -1.0%      32.00 ±207%  interrupts.CPU4.40:PCI-MSI.31981573-edge.i40e-eth0-TxRx-4
      0.17 ±223%     +71.4%       0.29 ±158%  interrupts.CPU4.75:PCI-MSI.31981608-edge.i40e-eth0-TxRx-39
    531637 ± 24%     -33.0%     356308 ± 32%  interrupts.CPU4.CAL:Function_call_interrupts
      6.33 ± 45%    +159.4%      16.43 ± 12%  interrupts.CPU4.IWI:IRQ_work_interrupts
    533976 ±  6%    +142.0%    1292061 ± 15%  interrupts.CPU4.LOC:Local_timer_interrupts
      0.00       +1.6e+102%       1.57 ± 31%  interrupts.CPU4.MCP:Machine_check_polls
      7038            +2.7%       7231 ± 19%  interrupts.CPU4.NMI:Non-maskable_interrupts
      7038            +2.7%       7231 ± 19%  interrupts.CPU4.PMI:Performance_monitoring_interrupts
   1253893 ±  9%     -35.1%     813842 ± 13%  interrupts.CPU4.RES:Rescheduling_interrupts
      9.00 ±101%    +219.0%      28.71 ±116%  interrupts.CPU4.TLB:TLB_shootdowns
      0.00       +1.5e+105%       1507 ±175%  interrupts.CPU40.76:PCI-MSI.31981609-edge.i40e-eth0-TxRx-40
    664174 ± 17%     -31.7%     453688 ± 22%  interrupts.CPU40.CAL:Function_call_interrupts
      6.33 ± 47%    +150.4%      15.86 ± 11%  interrupts.CPU40.IWI:IRQ_work_interrupts
    533770 ±  6%    +142.0%    1291857 ± 15%  interrupts.CPU40.LOC:Local_timer_interrupts
      0.00       +1.6e+102%       1.57 ± 31%  interrupts.CPU40.MCP:Machine_check_polls
      7274            -8.1%       6685 ± 26%  interrupts.CPU40.NMI:Non-maskable_interrupts
      7274            -8.1%       6685 ± 26%  interrupts.CPU40.PMI:Performance_monitoring_interrupts
   1281027 ±  7%     -29.4%     904820 ±  8%  interrupts.CPU40.RES:Rescheduling_interrupts
      4.17 ±108%    +242.9%      14.29 ± 68%  interrupts.CPU40.TLB:TLB_shootdowns
      1.33 ±223%   +6210.7%      84.14 ±128%  interrupts.CPU41.77:PCI-MSI.31981610-edge.i40e-eth0-TxRx-41
    588271 ± 20%     -17.3%     486465 ± 32%  interrupts.CPU41.CAL:Function_call_interrupts
      6.33 ± 47%    +159.4%      16.43 ± 13%  interrupts.CPU41.IWI:IRQ_work_interrupts
    533871 ±  6%    +142.0%    1291889 ± 15%  interrupts.CPU41.LOC:Local_timer_interrupts
      0.00       +1.6e+102%       1.57 ± 31%  interrupts.CPU41.MCP:Machine_check_polls
      6665 ± 19%      +8.5%       7230 ± 18%  interrupts.CPU41.NMI:Non-maskable_interrupts
      6665 ± 19%      +8.5%       7230 ± 18%  interrupts.CPU41.PMI:Performance_monitoring_interrupts
   1351815 ± 11%     -32.1%     917448 ±  8%  interrupts.CPU41.RES:Rescheduling_interrupts
      1.17 ± 58%    +536.7%       7.43 ± 63%  interrupts.CPU41.TLB:TLB_shootdowns
      0.83 ±223%     -65.7%       0.29 ±244%  interrupts.CPU42.78:PCI-MSI.31981611-edge.i40e-eth0-TxRx-42
    730027 ± 19%     -37.7%     454776 ± 29%  interrupts.CPU42.CAL:Function_call_interrupts
      6.33 ± 47%    +152.6%      16.00 ± 13%  interrupts.CPU42.IWI:IRQ_work_interrupts
    533854 ±  6%    +142.0%    1291966 ± 15%  interrupts.CPU42.LOC:Local_timer_interrupts
      0.00       +1.6e+102%       1.57 ± 31%  interrupts.CPU42.MCP:Machine_check_polls
      7272            -0.7%       7223 ± 18%  interrupts.CPU42.NMI:Non-maskable_interrupts
      7272            -0.7%       7223 ± 18%  interrupts.CPU42.PMI:Performance_monitoring_interrupts
   1404683 ±  5%     -35.0%     912839 ±  9%  interrupts.CPU42.RES:Rescheduling_interrupts
      2.33 ±112%     -26.5%       1.71 ± 74%  interrupts.CPU42.TLB:TLB_shootdowns
     65.83 ±221%     -97.6%       1.57 ±197%  interrupts.CPU43.79:PCI-MSI.31981612-edge.i40e-eth0-TxRx-43
    644715 ± 21%     -18.2%     527410 ± 37%  interrupts.CPU43.CAL:Function_call_interrupts
      6.33 ± 47%    +154.9%      16.14 ± 13%  interrupts.CPU43.IWI:IRQ_work_interrupts
    533755 ±  6%    +142.0%    1291826 ± 15%  interrupts.CPU43.LOC:Local_timer_interrupts
      0.00       +1.6e+102%       1.57 ± 31%  interrupts.CPU43.MCP:Machine_check_polls
      7286            +7.3%       7817        interrupts.CPU43.NMI:Non-maskable_interrupts
      7286            +7.3%       7817        interrupts.CPU43.PMI:Performance_monitoring_interrupts
   1326369 ± 15%     -30.7%     919440 ± 10%  interrupts.CPU43.RES:Rescheduling_interrupts
      1.83 ± 73%    +305.2%       7.43 ± 55%  interrupts.CPU43.TLB:TLB_shootdowns
      0.17 ±223%    +585.7%       1.14 ±244%  interrupts.CPU44.80:PCI-MSI.31981613-edge.i40e-eth0-TxRx-44
    754957 ± 13%     -36.2%     481787 ± 21%  interrupts.CPU44.CAL:Function_call_interrupts
      6.17 ± 49%    +159.5%      16.00 ± 13%  interrupts.CPU44.IWI:IRQ_work_interrupts
    533750 ±  6%    +142.0%    1291891 ± 15%  interrupts.CPU44.LOC:Local_timer_interrupts
      0.00       +1.6e+102%       1.57 ± 31%  interrupts.CPU44.MCP:Machine_check_polls
      6683 ± 20%      +8.1%       7224 ± 18%  interrupts.CPU44.NMI:Non-maskable_interrupts
      6683 ± 20%      +8.1%       7224 ± 18%  interrupts.CPU44.PMI:Performance_monitoring_interrupts
   1300187 ± 11%     -28.6%     928106 ± 11%  interrupts.CPU44.RES:Rescheduling_interrupts
      2.50 ± 38%    +271.4%       9.29 ±133%  interrupts.CPU44.TLB:TLB_shootdowns
      1.00 ±182%     -85.7%       0.14 ±244%  interrupts.CPU45.81:PCI-MSI.31981614-edge.i40e-eth0-TxRx-45
    732325 ± 30%     -39.3%     444779 ± 32%  interrupts.CPU45.CAL:Function_call_interrupts
      6.17 ± 42%    +159.5%      16.00 ± 14%  interrupts.CPU45.IWI:IRQ_work_interrupts
    533893 ±  6%    +142.0%    1291930 ± 15%  interrupts.CPU45.LOC:Local_timer_interrupts
      0.00       +1.6e+102%       1.57 ± 31%  interrupts.CPU45.MCP:Machine_check_polls
      6678 ± 20%      +8.1%       7222 ± 18%  interrupts.CPU45.NMI:Non-maskable_interrupts
      6678 ± 20%      +8.1%       7222 ± 18%  interrupts.CPU45.PMI:Performance_monitoring_interrupts
   1342619 ± 12%     -32.4%     907320 ± 11%  interrupts.CPU45.RES:Rescheduling_interrupts
      3.17 ± 90%    +107.5%       6.57 ± 73%  interrupts.CPU45.TLB:TLB_shootdowns
    180.33 ±223%   +3655.7%       6772 ±244%  interrupts.CPU46.82:PCI-MSI.31981615-edge.i40e-eth0-TxRx-46
    675094 ± 12%     -31.3%     463705 ± 33%  interrupts.CPU46.CAL:Function_call_interrupts
      6.33 ± 47%    +154.9%      16.14 ± 13%  interrupts.CPU46.IWI:IRQ_work_interrupts
    533775 ±  6%    +142.0%    1291962 ± 15%  interrupts.CPU46.LOC:Local_timer_interrupts
      0.00       +1.6e+102%       1.57 ± 31%  interrupts.CPU46.MCP:Machine_check_polls
      7279            +6.9%       7781        interrupts.CPU46.NMI:Non-maskable_interrupts
      7279            +6.9%       7781        interrupts.CPU46.PMI:Performance_monitoring_interrupts
   1289563 ±  7%     -29.5%     908781 ± 10%  interrupts.CPU46.RES:Rescheduling_interrupts
      5.17 ±108%      -0.5%       5.14 ± 75%  interrupts.CPU46.TLB:TLB_shootdowns
     96.00 ±221%    +355.1%     436.86 ±244%  interrupts.CPU47.83:PCI-MSI.31981616-edge.i40e-eth0-TxRx-47
    672449 ± 21%     -24.1%     510354 ± 31%  interrupts.CPU47.CAL:Function_call_interrupts
      6.17 ± 42%    +161.8%      16.14 ± 13%  interrupts.CPU47.IWI:IRQ_work_interrupts
    533880 ±  6%    +142.0%    1291844 ± 15%  interrupts.CPU47.LOC:Local_timer_interrupts
      0.00       +1.6e+102%       1.57 ± 31%  interrupts.CPU47.MCP:Machine_check_polls
      7291            +6.7%       7783        interrupts.CPU47.NMI:Non-maskable_interrupts
      7291            +6.7%       7783        interrupts.CPU47.PMI:Performance_monitoring_interrupts
   1304458 ± 11%     -29.3%     922884 ±  8%  interrupts.CPU47.RES:Rescheduling_interrupts
      3.00 ± 60%    +138.1%       7.14 ± 50%  interrupts.CPU47.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU48.3:IO-APIC.3-edge
      0.33 ±141%     -14.3%       0.29 ±158%  interrupts.CPU48.47:PCI-MSI.31981580-edge.i40e-eth0-TxRx-11
      3.17 ±182%   +2534.6%      83.43 ±241%  interrupts.CPU48.84:PCI-MSI.31981617-edge.i40e-eth0-TxRx-48
      0.00       +1.4e+101%       0.14 ±244%  interrupts.CPU48.95:PCI-MSI.31981628-edge.i40e-eth0-TxRx-59
    583930 ± 21%     -26.6%     428572 ± 48%  interrupts.CPU48.CAL:Function_call_interrupts
      6.33 ± 47%    +154.9%      16.14 ± 13%  interrupts.CPU48.IWI:IRQ_work_interrupts
    533860 ±  6%    +142.0%    1291999 ± 15%  interrupts.CPU48.LOC:Local_timer_interrupts
      0.00       +1.6e+102%       1.57 ± 31%  interrupts.CPU48.MCP:Machine_check_polls
      7019           +10.7%       7770        interrupts.CPU48.NMI:Non-maskable_interrupts
      7019           +10.7%       7770        interrupts.CPU48.PMI:Performance_monitoring_interrupts
   1156332 ±  6%     -29.2%     818950 ± 15%  interrupts.CPU48.RES:Rescheduling_interrupts
      2.83 ±134%    +313.4%      11.71 ± 67%  interrupts.CPU48.TLB:TLB_shootdowns
      0.17 ±223%     -14.3%       0.14 ±244%  interrupts.CPU49.48:PCI-MSI.31981581-edge.i40e-eth0-TxRx-12
      0.00       +1.9e+103%      19.14 ±221%  interrupts.CPU49.85:PCI-MSI.31981618-edge.i40e-eth0-TxRx-49
      0.33 ±141%     +28.6%       0.43 ±115%  interrupts.CPU49.96:PCI-MSI.31981629-edge.i40e-eth0-TxRx-60
    664881 ± 19%     -44.8%     367178 ± 36%  interrupts.CPU49.CAL:Function_call_interrupts
      6.17 ± 49%    +157.1%      15.86 ± 12%  interrupts.CPU49.IWI:IRQ_work_interrupts
    533855 ±  6%    +142.0%    1292004 ± 15%  interrupts.CPU49.LOC:Local_timer_interrupts
      0.00       +1.6e+102%       1.57 ± 31%  interrupts.CPU49.MCP:Machine_check_polls
      6424 ± 20%      +3.7%       6663 ± 26%  interrupts.CPU49.NMI:Non-maskable_interrupts
      6424 ± 20%      +3.7%       6663 ± 26%  interrupts.CPU49.PMI:Performance_monitoring_interrupts
   1317305 ± 11%     -39.5%     797527 ± 14%  interrupts.CPU49.RES:Rescheduling_interrupts
      3.83 ±131%     +34.2%       5.14 ± 93%  interrupts.CPU49.TLB:TLB_shootdowns
      0.00       +1.4e+101%       0.14 ±244%  interrupts.CPU5.124:PCI-MSI.31981657-edge.i40e-eth0-TxRx-88
      0.00       +1.4e+105%       1406 ±179%  interrupts.CPU5.41:PCI-MSI.31981574-edge.i40e-eth0-TxRx-5
      0.00          -100.0%       0.00        interrupts.CPU5.76:PCI-MSI.31981609-edge.i40e-eth0-TxRx-40
    582125 ± 36%     -41.3%     341677 ± 22%  interrupts.CPU5.CAL:Function_call_interrupts
      6.50 ± 39%    +144.0%      15.86 ± 12%  interrupts.CPU5.IWI:IRQ_work_interrupts
    533892 ±  6%    +142.0%    1292056 ± 15%  interrupts.CPU5.LOC:Local_timer_interrupts
      0.00       +1.6e+102%       1.57 ± 31%  interrupts.CPU5.MCP:Machine_check_polls
      7025            -5.4%       6648 ± 26%  interrupts.CPU5.NMI:Non-maskable_interrupts
      7025            -5.4%       6648 ± 26%  interrupts.CPU5.PMI:Performance_monitoring_interrupts
   1213290 ± 11%     -33.2%     810410 ± 11%  interrupts.CPU5.RES:Rescheduling_interrupts
      6.33 ±141%    +236.1%      21.29 ±101%  interrupts.CPU5.TLB:TLB_shootdowns
      0.33 ±141%     -57.1%       0.14 ±244%  interrupts.CPU50.49:PCI-MSI.31981582-edge.i40e-eth0-TxRx-13
      6704 ±223%    -100.0%       2.00 ±187%  interrupts.CPU50.86:PCI-MSI.31981619-edge.i40e-eth0-TxRx-50
      0.00       +2.9e+101%       0.29 ±158%  interrupts.CPU50.97:PCI-MSI.31981630-edge.i40e-eth0-TxRx-61
    658582 ± 28%     -45.8%     356981 ± 33%  interrupts.CPU50.CAL:Function_call_interrupts
      6.33 ± 47%    +154.9%      16.14 ± 13%  interrupts.CPU50.IWI:IRQ_work_interrupts
    533876 ±  6%    +142.0%    1292029 ± 15%  interrupts.CPU50.LOC:Local_timer_interrupts
      0.00       +1.6e+102%       1.57 ± 31%  interrupts.CPU50.MCP:Machine_check_polls
      7028           +10.7%       7780        interrupts.CPU50.NMI:Non-maskable_interrupts
      7028           +10.7%       7780        interrupts.CPU50.PMI:Performance_monitoring_interrupts
   1253216 ± 13%     -35.0%     814374 ± 12%  interrupts.CPU50.RES:Rescheduling_interrupts
      5.83 ±108%     -55.9%       2.57 ± 94%  interrupts.CPU50.TLB:TLB_shootdowns
      0.17 ±223%    +242.9%       0.57 ± 86%  interrupts.CPU51.50:PCI-MSI.31981583-edge.i40e-eth0-TxRx-14
      0.17 ±223%  +1.1e+05%     190.57 ±241%  interrupts.CPU51.87:PCI-MSI.31981620-edge.i40e-eth0-TxRx-51
      0.17 ±223%     +71.4%       0.29 ±158%  interrupts.CPU51.98:PCI-MSI.31981631-edge.i40e-eth0-TxRx-62
    702111 ± 45%     -41.9%     408118 ± 30%  interrupts.CPU51.CAL:Function_call_interrupts
      6.33 ± 47%    +152.6%      16.00 ± 13%  interrupts.CPU51.IWI:IRQ_work_interrupts
    533865 ±  6%    +142.0%    1292040 ± 15%  interrupts.CPU51.LOC:Local_timer_interrupts
      0.00       +1.6e+102%       1.57 ± 31%  interrupts.CPU51.MCP:Machine_check_polls
      7029            +2.6%       7210 ± 18%  interrupts.CPU51.NMI:Non-maskable_interrupts
      7029            +2.6%       7210 ± 18%  interrupts.CPU51.PMI:Performance_monitoring_interrupts
   1244029 ±  8%     -32.7%     837123 ± 11%  interrupts.CPU51.RES:Rescheduling_interrupts
      3.17 ± 88%     -14.3%       2.71 ± 72%  interrupts.CPU51.TLB:TLB_shootdowns
      0.00       +2.9e+101%       0.29 ±158%  interrupts.CPU52.51:PCI-MSI.31981584-edge.i40e-eth0-TxRx-15
      0.00       +2.4e+103%      24.00 ±244%  interrupts.CPU52.88:PCI-MSI.31981621-edge.i40e-eth0-TxRx-52
      0.17 ±223%    -100.0%       0.00        interrupts.CPU52.99:PCI-MSI.31981632-edge.i40e-eth0-TxRx-63
    573703 ± 18%     -34.5%     375810 ± 27%  interrupts.CPU52.CAL:Function_call_interrupts
      6.33 ± 47%    +154.9%      16.14 ± 13%  interrupts.CPU52.IWI:IRQ_work_interrupts
    533871 ±  6%    +142.0%    1292058 ± 15%  interrupts.CPU52.LOC:Local_timer_interrupts
      0.00       +1.6e+102%       1.57 ± 31%  interrupts.CPU52.MCP:Machine_check_polls
      7017           +10.7%       7768        interrupts.CPU52.NMI:Non-maskable_interrupts
      7017           +10.7%       7768        interrupts.CPU52.PMI:Performance_monitoring_interrupts
   1198356 ±  7%     -31.6%     820036 ± 13%  interrupts.CPU52.RES:Rescheduling_interrupts
      1.67 ± 66%    +217.1%       5.29 ± 81%  interrupts.CPU52.TLB:TLB_shootdowns
      0.17 ±223%     +71.4%       0.29 ±158%  interrupts.CPU53.100:PCI-MSI.31981633-edge.i40e-eth0-TxRx-64
      0.00       +2.9e+101%       0.29 ±158%  interrupts.CPU53.52:PCI-MSI.31981585-edge.i40e-eth0-TxRx-16
      4.00 ±223%    -100.0%       0.00        interrupts.CPU53.89:PCI-MSI.31981622-edge.i40e-eth0-TxRx-53
    575805 ± 33%     -39.3%     349451 ± 22%  interrupts.CPU53.CAL:Function_call_interrupts
      6.33 ± 47%    +154.9%      16.14 ± 13%  interrupts.CPU53.IWI:IRQ_work_interrupts
    533989 ±  6%    +141.9%    1291927 ± 15%  interrupts.CPU53.LOC:Local_timer_interrupts
      0.00       +1.6e+102%       1.57 ± 31%  interrupts.CPU53.MCP:Machine_check_polls
      7021           +10.7%       7770        interrupts.CPU53.NMI:Non-maskable_interrupts
      7021           +10.7%       7770        interrupts.CPU53.PMI:Performance_monitoring_interrupts
   1179664 ±  9%     -31.2%     811377 ± 11%  interrupts.CPU53.RES:Rescheduling_interrupts
      1.83 ± 48%    +196.1%       5.43 ± 91%  interrupts.CPU53.TLB:TLB_shootdowns
      0.00       +2.9e+101%       0.29 ±158%  interrupts.CPU54.101:PCI-MSI.31981634-edge.i40e-eth0-TxRx-65
      0.17 ±223%     +71.4%       0.29 ±158%  interrupts.CPU54.53:PCI-MSI.31981586-edge.i40e-eth0-TxRx-17
      3.50 ±223%    -100.0%       0.00        interrupts.CPU54.90:PCI-MSI.31981623-edge.i40e-eth0-TxRx-54
    542379 ± 31%     -25.1%     406220 ± 50%  interrupts.CPU54.CAL:Function_call_interrupts
      6.17 ± 49%    +157.1%      15.86 ± 15%  interrupts.CPU54.IWI:IRQ_work_interrupts
    533851 ±  6%    +142.0%    1292056 ± 15%  interrupts.CPU54.LOC:Local_timer_interrupts
      0.00       +1.6e+102%       1.57 ± 31%  interrupts.CPU54.MCP:Machine_check_polls
      6428 ± 20%      +3.4%       6649 ± 26%  interrupts.CPU54.NMI:Non-maskable_interrupts
      6428 ± 20%      +3.4%       6649 ± 26%  interrupts.CPU54.PMI:Performance_monitoring_interrupts
   1145325 ±  4%     -29.3%     810148 ± 16%  interrupts.CPU54.RES:Rescheduling_interrupts
      3.17 ±141%     +75.9%       5.57 ± 55%  interrupts.CPU54.TLB:TLB_shootdowns
      0.33 ±141%     -14.3%       0.29 ±158%  interrupts.CPU55.102:PCI-MSI.31981635-edge.i40e-eth0-TxRx-66
      0.00       +2.9e+101%       0.29 ±158%  interrupts.CPU55.54:PCI-MSI.31981587-edge.i40e-eth0-TxRx-18
      2.00 ±223%     -92.9%       0.14 ±244%  interrupts.CPU55.91:PCI-MSI.31981624-edge.i40e-eth0-TxRx-55
    631336 ± 16%     -42.9%     360440 ± 36%  interrupts.CPU55.CAL:Function_call_interrupts
      6.33 ± 47%    +152.6%      16.00 ± 13%  interrupts.CPU55.IWI:IRQ_work_interrupts
    533889 ±  6%    +142.0%    1291998 ± 15%  interrupts.CPU55.LOC:Local_timer_interrupts
      0.00       +1.6e+102%       1.57 ± 31%  interrupts.CPU55.MCP:Machine_check_polls
      7026            +2.6%       7209 ± 18%  interrupts.CPU55.NMI:Non-maskable_interrupts
      7026            +2.6%       7209 ± 18%  interrupts.CPU55.PMI:Performance_monitoring_interrupts
   1227998 ± 11%     -33.8%     812365 ± 15%  interrupts.CPU55.RES:Rescheduling_interrupts
      3.67 ±118%     +40.3%       5.14 ± 80%  interrupts.CPU55.TLB:TLB_shootdowns
      0.17 ±223%    -100.0%       0.00        interrupts.CPU56.103:PCI-MSI.31981636-edge.i40e-eth0-TxRx-67
      0.33 ±141%     -14.3%       0.29 ±158%  interrupts.CPU56.55:PCI-MSI.31981588-edge.i40e-eth0-TxRx-19
    321.17 ±223%     -93.7%      20.29 ±242%  interrupts.CPU56.92:PCI-MSI.31981625-edge.i40e-eth0-TxRx-56
    651596 ± 26%     -42.2%     376748 ± 36%  interrupts.CPU56.CAL:Function_call_interrupts
      6.33 ± 54%    +152.6%      16.00 ± 13%  interrupts.CPU56.IWI:IRQ_work_interrupts
    533679 ±  6%    +142.1%    1291970 ± 15%  interrupts.CPU56.LOC:Local_timer_interrupts
      0.00       +1.6e+102%       1.57 ± 31%  interrupts.CPU56.MCP:Machine_check_polls
      6424 ± 20%     +12.2%       7210 ± 18%  interrupts.CPU56.NMI:Non-maskable_interrupts
      6424 ± 20%     +12.2%       7210 ± 18%  interrupts.CPU56.PMI:Performance_monitoring_interrupts
   1248768 ±  8%     -34.6%     816385 ± 12%  interrupts.CPU56.RES:Rescheduling_interrupts
      1.67 ± 74%    +302.9%       6.71 ± 57%  interrupts.CPU56.TLB:TLB_shootdowns
      0.00       +4.3e+101%       0.43 ±115%  interrupts.CPU57.104:PCI-MSI.31981637-edge.i40e-eth0-TxRx-68
      0.00       +4.3e+101%       0.43 ±115%  interrupts.CPU57.56:PCI-MSI.31981589-edge.i40e-eth0-TxRx-20
      4.17 ±213%    +373.1%      19.71 ±210%  interrupts.CPU57.93:PCI-MSI.31981626-edge.i40e-eth0-TxRx-57
    651345 ± 26%     -39.3%     395299 ± 44%  interrupts.CPU57.CAL:Function_call_interrupts
      6.33 ± 47%    +154.9%      16.14 ± 13%  interrupts.CPU57.IWI:IRQ_work_interrupts
    533872 ±  6%    +142.0%    1292023 ± 15%  interrupts.CPU57.LOC:Local_timer_interrupts
      0.00       +1.6e+102%       1.57 ± 31%  interrupts.CPU57.MCP:Machine_check_polls
      7028           +10.6%       7770        interrupts.CPU57.NMI:Non-maskable_interrupts
      7028           +10.6%       7770        interrupts.CPU57.PMI:Performance_monitoring_interrupts
   1252095 ±  9%     -33.4%     833984 ± 14%  interrupts.CPU57.RES:Rescheduling_interrupts
      3.33 ±132%      +7.1%       3.57 ±110%  interrupts.CPU57.TLB:TLB_shootdowns
      0.00       +2.9e+101%       0.29 ±158%  interrupts.CPU58.105:PCI-MSI.31981638-edge.i40e-eth0-TxRx-69
      0.33 ±141%    -100.0%       0.00        interrupts.CPU58.57:PCI-MSI.31981590-edge.i40e-eth0-TxRx-21
      0.00       +2.2e+104%     215.43 ±208%  interrupts.CPU58.94:PCI-MSI.31981627-edge.i40e-eth0-TxRx-58
    738401 ± 27%     -50.0%     369291 ± 36%  interrupts.CPU58.CAL:Function_call_interrupts
      6.33 ± 47%    +152.6%      16.00 ± 13%  interrupts.CPU58.IWI:IRQ_work_interrupts
    533885 ±  6%    +142.0%    1292009 ± 15%  interrupts.CPU58.LOC:Local_timer_interrupts
      0.00       +1.6e+102%       1.57 ± 31%  interrupts.CPU58.MCP:Machine_check_polls
      7017            +2.7%       7209 ± 18%  interrupts.CPU58.NMI:Non-maskable_interrupts
      7017            +2.7%       7209 ± 18%  interrupts.CPU58.PMI:Performance_monitoring_interrupts
   1175190 ± 14%     -31.7%     802477 ± 13%  interrupts.CPU58.RES:Rescheduling_interrupts
      2.50 ± 38%    +340.0%      11.00 ± 87%  interrupts.CPU58.TLB:TLB_shootdowns
      0.50 ±100%     -71.4%       0.14 ±244%  interrupts.CPU59.106:PCI-MSI.31981639-edge.i40e-eth0-TxRx-70
      0.00       +4.3e+101%       0.43 ±115%  interrupts.CPU59.58:PCI-MSI.31981591-edge.i40e-eth0-TxRx-22
      0.00       +2.6e+103%      25.71 ±243%  interrupts.CPU59.95:PCI-MSI.31981628-edge.i40e-eth0-TxRx-59
    675714 ±  9%     -46.5%     361386 ± 31%  interrupts.CPU59.CAL:Function_call_interrupts
      6.33 ± 47%    +154.9%      16.14 ± 13%  interrupts.CPU59.IWI:IRQ_work_interrupts
    533843 ±  6%    +142.0%    1292051 ± 15%  interrupts.CPU59.LOC:Local_timer_interrupts
      0.00       +1.6e+102%       1.57 ± 31%  interrupts.CPU59.MCP:Machine_check_polls
      7018           +10.7%       7769        interrupts.CPU59.NMI:Non-maskable_interrupts
      7018           +10.7%       7769        interrupts.CPU59.PMI:Performance_monitoring_interrupts
   1145223 ±  5%     -30.0%     801647 ± 14%  interrupts.CPU59.RES:Rescheduling_interrupts
      2.33 ±101%     +28.6%       3.00 ± 90%  interrupts.CPU59.TLB:TLB_shootdowns
      0.00       +1.4e+101%       0.14 ±244%  interrupts.CPU6.125:PCI-MSI.31981658-edge.i40e-eth0-TxRx-89
     27.50 ±152%     -95.3%       1.29 ±214%  interrupts.CPU6.42:PCI-MSI.31981575-edge.i40e-eth0-TxRx-6
      0.17 ±223%    +157.1%       0.43 ±115%  interrupts.CPU6.77:PCI-MSI.31981610-edge.i40e-eth0-TxRx-41
    598384 ± 38%     -38.8%     365983 ± 43%  interrupts.CPU6.CAL:Function_call_interrupts
      6.33 ± 47%    +150.4%      15.86 ± 11%  interrupts.CPU6.IWI:IRQ_work_interrupts
    533844 ±  6%    +142.0%    1291996 ± 15%  interrupts.CPU6.LOC:Local_timer_interrupts
      0.00       +1.6e+102%       1.57 ± 31%  interrupts.CPU6.MCP:Machine_check_polls
      6443 ± 20%      +3.4%       6662 ± 26%  interrupts.CPU6.NMI:Non-maskable_interrupts
      6443 ± 20%      +3.4%       6662 ± 26%  interrupts.CPU6.PMI:Performance_monitoring_interrupts
   1260008 ± 15%     -35.6%     811974 ± 14%  interrupts.CPU6.RES:Rescheduling_interrupts
      4.50 ±100%    +414.3%      23.14 ± 95%  interrupts.CPU6.TLB:TLB_shootdowns
      0.17 ±223%     +71.4%       0.29 ±158%  interrupts.CPU60.107:PCI-MSI.31981640-edge.i40e-eth0-TxRx-71
      0.50 ±100%     -71.4%       0.14 ±244%  interrupts.CPU60.59:PCI-MSI.31981592-edge.i40e-eth0-TxRx-23
     72.67 ±214%     -89.4%       7.71 ±239%  interrupts.CPU60.96:PCI-MSI.31981629-edge.i40e-eth0-TxRx-60
    650876 ± 31%     -46.6%     347321 ± 40%  interrupts.CPU60.CAL:Function_call_interrupts
      6.33 ± 47%    +154.9%      16.14 ± 13%  interrupts.CPU60.IWI:IRQ_work_interrupts
    533946 ±  6%    +142.0%    1291973 ± 15%  interrupts.CPU60.LOC:Local_timer_interrupts
      0.00       +1.6e+102%       1.57 ± 31%  interrupts.CPU60.MCP:Machine_check_polls
      7020           +10.7%       7768        interrupts.CPU60.NMI:Non-maskable_interrupts
      7020           +10.7%       7768        interrupts.CPU60.PMI:Performance_monitoring_interrupts
   1205503 ± 14%     -32.9%     809340 ± 16%  interrupts.CPU60.RES:Rescheduling_interrupts
      1.67 ± 89%    +131.4%       3.86 ±131%  interrupts.CPU60.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU61.108:PCI-MSI.31981641-edge.i40e-eth0-TxRx-72
      0.00       +4.3e+101%       0.43 ±115%  interrupts.CPU61.60:PCI-MSI.31981593-edge.i40e-eth0-TxRx-24
      0.67 ±223%    +135.7%       1.57 ±172%  interrupts.CPU61.97:PCI-MSI.31981630-edge.i40e-eth0-TxRx-61
    613806 ± 27%     -35.0%     398776 ± 35%  interrupts.CPU61.CAL:Function_call_interrupts
      6.33 ± 47%    +152.6%      16.00 ± 12%  interrupts.CPU61.IWI:IRQ_work_interrupts
    533669 ±  6%    +142.1%    1292206 ± 15%  interrupts.CPU61.LOC:Local_timer_interrupts
      0.00       +1.6e+102%       1.57 ± 31%  interrupts.CPU61.MCP:Machine_check_polls
      7021            +2.7%       7208 ± 18%  interrupts.CPU61.NMI:Non-maskable_interrupts
      7021            +2.7%       7208 ± 18%  interrupts.CPU61.PMI:Performance_monitoring_interrupts
   1138915 ±  8%     -28.7%     811659 ± 12%  interrupts.CPU61.RES:Rescheduling_interrupts
      2.00 ± 76%     +78.6%       3.57 ± 41%  interrupts.CPU61.TLB:TLB_shootdowns
      0.00       +1.4e+101%       0.14 ±244%  interrupts.CPU62.109:PCI-MSI.31981642-edge.i40e-eth0-TxRx-73
      0.33 ±141%     -14.3%       0.29 ±158%  interrupts.CPU62.61:PCI-MSI.31981594-edge.i40e-eth0-TxRx-25
      0.00       +1.1e+102%       1.14 ±211%  interrupts.CPU62.98:PCI-MSI.31981631-edge.i40e-eth0-TxRx-62
    585522 ± 23%     -29.9%     410509 ± 30%  interrupts.CPU62.CAL:Function_call_interrupts
      6.33 ± 47%    +152.6%      16.00 ± 12%  interrupts.CPU62.IWI:IRQ_work_interrupts
    533895 ±  6%    +142.0%    1292022 ± 15%  interrupts.CPU62.LOC:Local_timer_interrupts
      0.00       +1.6e+102%       1.57 ± 31%  interrupts.CPU62.MCP:Machine_check_polls
      7024            +2.6%       7209 ± 18%  interrupts.CPU62.NMI:Non-maskable_interrupts
      7024            +2.6%       7209 ± 18%  interrupts.CPU62.PMI:Performance_monitoring_interrupts
   1226948 ±  7%     -33.6%     814924 ± 14%  interrupts.CPU62.RES:Rescheduling_interrupts
      1.33 ± 70%    +200.0%       4.00 ± 66%  interrupts.CPU62.TLB:TLB_shootdowns
      0.17 ±223%     -14.3%       0.14 ±244%  interrupts.CPU63.110:PCI-MSI.31981643-edge.i40e-eth0-TxRx-74
      0.00       +2.9e+101%       0.29 ±158%  interrupts.CPU63.62:PCI-MSI.31981595-edge.i40e-eth0-TxRx-26
      0.50 ±223%  +42957.1%     215.29 ±244%  interrupts.CPU63.99:PCI-MSI.31981632-edge.i40e-eth0-TxRx-63
    670915 ± 20%     -40.3%     400717 ± 47%  interrupts.CPU63.CAL:Function_call_interrupts
      6.33 ± 47%    +152.6%      16.00 ± 12%  interrupts.CPU63.IWI:IRQ_work_interrupts
    533904 ±  6%    +142.0%    1292005 ± 15%  interrupts.CPU63.LOC:Local_timer_interrupts
      0.00       +1.6e+102%       1.57 ± 31%  interrupts.CPU63.MCP:Machine_check_polls
      7023            -5.1%       6666 ± 26%  interrupts.CPU63.NMI:Non-maskable_interrupts
      7023            -5.1%       6666 ± 26%  interrupts.CPU63.PMI:Performance_monitoring_interrupts
   1181385 ±  7%     -30.5%     821606 ± 14%  interrupts.CPU63.RES:Rescheduling_interrupts
      1.33 ± 70%    +435.7%       7.14 ±165%  interrupts.CPU63.TLB:TLB_shootdowns
      0.17 ±223%    +671.4%       1.29 ±214%  interrupts.CPU64.100:PCI-MSI.31981633-edge.i40e-eth0-TxRx-64
      0.17 ±223%     -14.3%       0.14 ±244%  interrupts.CPU64.111:PCI-MSI.31981644-edge.i40e-eth0-TxRx-75
      0.17 ±223%     +71.4%       0.29 ±158%  interrupts.CPU64.63:PCI-MSI.31981596-edge.i40e-eth0-TxRx-27
    645957 ± 31%     -40.5%     384530 ± 32%  interrupts.CPU64.CAL:Function_call_interrupts
      6.33 ± 47%    +148.1%      15.71 ± 14%  interrupts.CPU64.IWI:IRQ_work_interrupts
    533878 ±  6%    +142.0%    1292047 ± 15%  interrupts.CPU64.LOC:Local_timer_interrupts
      0.00       +1.6e+102%       1.57 ± 31%  interrupts.CPU64.MCP:Machine_check_polls
      7026           -21.0%       5547 ± 34%  interrupts.CPU64.NMI:Non-maskable_interrupts
      7026           -21.0%       5547 ± 34%  interrupts.CPU64.PMI:Performance_monitoring_interrupts
   1187500 ±  8%     -31.1%     818704 ± 13%  interrupts.CPU64.RES:Rescheduling_interrupts
      1.33 ± 93%    +307.1%       5.43 ± 47%  interrupts.CPU64.TLB:TLB_shootdowns
     12.00 ±223%  +20198.8%       2435 ±244%  interrupts.CPU65.101:PCI-MSI.31981634-edge.i40e-eth0-TxRx-65
      0.00       +1.4e+101%       0.14 ±244%  interrupts.CPU65.112:PCI-MSI.31981645-edge.i40e-eth0-TxRx-76
      0.33 ±141%     -57.1%       0.14 ±244%  interrupts.CPU65.64:PCI-MSI.31981597-edge.i40e-eth0-TxRx-28
    597894 ± 12%     -29.0%     424458 ± 29%  interrupts.CPU65.CAL:Function_call_interrupts
      6.33 ± 47%    +148.1%      15.71 ± 15%  interrupts.CPU65.IWI:IRQ_work_interrupts
    533880 ±  6%    +142.0%    1292004 ± 15%  interrupts.CPU65.LOC:Local_timer_interrupts
      0.00       +1.6e+102%       1.57 ± 31%  interrupts.CPU65.MCP:Machine_check_polls
      7034           -13.2%       6104 ± 31%  interrupts.CPU65.NMI:Non-maskable_interrupts
      7034           -13.2%       6104 ± 31%  interrupts.CPU65.PMI:Performance_monitoring_interrupts
   1147931 ±  8%     -28.9%     816199 ± 16%  interrupts.CPU65.RES:Rescheduling_interrupts
      7.83 ± 73%     -76.3%       1.86 ± 97%  interrupts.CPU65.TLB:TLB_shootdowns
      0.33 ±141%    +585.7%       2.29 ±164%  interrupts.CPU66.102:PCI-MSI.31981635-edge.i40e-eth0-TxRx-66
      0.17 ±223%    -100.0%       0.00        interrupts.CPU66.113:PCI-MSI.31981646-edge.i40e-eth0-TxRx-77
      0.50 ±100%     -14.3%       0.43 ±115%  interrupts.CPU66.65:PCI-MSI.31981598-edge.i40e-eth0-TxRx-29
    557466 ± 24%     -31.8%     380456 ± 30%  interrupts.CPU66.CAL:Function_call_interrupts
      6.17 ± 49%    +157.1%      15.86 ± 14%  interrupts.CPU66.IWI:IRQ_work_interrupts
    533852 ±  6%    +142.0%    1292031 ± 15%  interrupts.CPU66.LOC:Local_timer_interrupts
      0.00       +1.6e+102%       1.57 ± 31%  interrupts.CPU66.MCP:Machine_check_polls
      6447 ± 20%      +3.4%       6664 ± 26%  interrupts.CPU66.NMI:Non-maskable_interrupts
      6447 ± 20%      +3.4%       6664 ± 26%  interrupts.CPU66.PMI:Performance_monitoring_interrupts
   1213255 ±  9%     -32.8%     815868 ± 13%  interrupts.CPU66.RES:Rescheduling_interrupts
      5.17 ± 90%     -41.9%       3.00 ±106%  interrupts.CPU66.TLB:TLB_shootdowns
     25.33 ±203%    -100.0%       0.00        interrupts.CPU67.103:PCI-MSI.31981636-edge.i40e-eth0-TxRx-67
      0.00       +1.4e+101%       0.14 ±244%  interrupts.CPU67.114:PCI-MSI.31981647-edge.i40e-eth0-TxRx-78
      0.17 ±223%     +71.4%       0.29 ±158%  interrupts.CPU67.66:PCI-MSI.31981599-edge.i40e-eth0-TxRx-30
    713344 ± 32%     -44.0%     399634 ± 33%  interrupts.CPU67.CAL:Function_call_interrupts
      6.00 ± 52%    +166.7%      16.00 ± 12%  interrupts.CPU67.IWI:IRQ_work_interrupts
    533922 ±  6%    +142.0%    1292054 ± 15%  interrupts.CPU67.LOC:Local_timer_interrupts
      0.00       +1.6e+102%       1.57 ± 31%  interrupts.CPU67.MCP:Machine_check_polls
      5876 ± 29%     +22.9%       7224 ± 19%  interrupts.CPU67.NMI:Non-maskable_interrupts
      5876 ± 29%     +22.9%       7224 ± 19%  interrupts.CPU67.PMI:Performance_monitoring_interrupts
   1130887 ± 12%     -29.2%     800299 ± 14%  interrupts.CPU67.RES:Rescheduling_interrupts
      7.00 ± 94%     -42.9%       4.00 ± 69%  interrupts.CPU67.TLB:TLB_shootdowns
      1156 ±177%     -97.2%      32.29 ±201%  interrupts.CPU68.104:PCI-MSI.31981637-edge.i40e-eth0-TxRx-68
      0.17 ±223%     -14.3%       0.14 ±244%  interrupts.CPU68.115:PCI-MSI.31981648-edge.i40e-eth0-TxRx-79
      0.00       +2.9e+101%       0.29 ±158%  interrupts.CPU68.67:PCI-MSI.31981600-edge.i40e-eth0-TxRx-31
    630960 ± 27%     -35.0%     410123 ± 27%  interrupts.CPU68.CAL:Function_call_interrupts
      6.33 ± 47%    +150.4%      15.86 ± 13%  interrupts.CPU68.IWI:IRQ_work_interrupts
    533912 ±  6%    +142.0%    1292113 ± 15%  interrupts.CPU68.LOC:Local_timer_interrupts
      0.00       +1.6e+102%       1.57 ± 31%  interrupts.CPU68.MCP:Machine_check_polls
      7034            -5.3%       6664 ± 26%  interrupts.CPU68.NMI:Non-maskable_interrupts
      7034            -5.3%       6664 ± 26%  interrupts.CPU68.PMI:Performance_monitoring_interrupts
   1217859 ±  7%     -31.6%     832957 ± 11%  interrupts.CPU68.RES:Rescheduling_interrupts
      6.67 ± 83%     -67.9%       2.14 ± 52%  interrupts.CPU68.TLB:TLB_shootdowns
     11.00 ±223%     -42.9%       6.29 ±157%  interrupts.CPU69.105:PCI-MSI.31981638-edge.i40e-eth0-TxRx-69
      0.00       +1.4e+101%       0.14 ±244%  interrupts.CPU69.116:PCI-MSI.31981649-edge.i40e-eth0-TxRx-80
      0.33 ±141%     -57.1%       0.14 ±244%  interrupts.CPU69.68:PCI-MSI.31981601-edge.i40e-eth0-TxRx-32
    633239 ± 27%     -40.0%     379951 ± 33%  interrupts.CPU69.CAL:Function_call_interrupts
      6.33 ± 47%    +152.6%      16.00 ± 13%  interrupts.CPU69.IWI:IRQ_work_interrupts
    533886 ±  6%    +142.0%    1292024 ± 15%  interrupts.CPU69.LOC:Local_timer_interrupts
      0.00       +1.6e+102%       1.57 ± 31%  interrupts.CPU69.MCP:Machine_check_polls
      7030            +2.6%       7213 ± 18%  interrupts.CPU69.NMI:Non-maskable_interrupts
      7030            +2.6%       7213 ± 18%  interrupts.CPU69.PMI:Performance_monitoring_interrupts
   1185620 ±  8%     -31.5%     811889 ± 14%  interrupts.CPU69.RES:Rescheduling_interrupts
      1.83 ± 73%    +149.4%       4.57 ± 70%  interrupts.CPU69.TLB:TLB_shootdowns
      0.17 ±223%     -14.3%       0.14 ±244%  interrupts.CPU7.126:PCI-MSI.31981659-edge.i40e-eth0-TxRx-90
      0.00       +7.7e+103%      76.86 ±143%  interrupts.CPU7.43:PCI-MSI.31981576-edge.i40e-eth0-TxRx-7
      0.17 ±223%     -14.3%       0.14 ±244%  interrupts.CPU7.78:PCI-MSI.31981611-edge.i40e-eth0-TxRx-42
    649545 ± 24%     -45.1%     356455 ± 33%  interrupts.CPU7.CAL:Function_call_interrupts
      6.17 ± 43%    +161.8%      16.14 ± 13%  interrupts.CPU7.IWI:IRQ_work_interrupts
    533880 ±  6%    +142.0%    1292009 ± 15%  interrupts.CPU7.LOC:Local_timer_interrupts
      0.00       +1.6e+102%       1.57 ± 31%  interrupts.CPU7.MCP:Machine_check_polls
      6429 ± 20%     +20.9%       7771        interrupts.CPU7.NMI:Non-maskable_interrupts
      6429 ± 20%     +20.9%       7771        interrupts.CPU7.PMI:Performance_monitoring_interrupts
   1297213 ±  8%     -37.8%     807012 ± 14%  interrupts.CPU7.RES:Rescheduling_interrupts
      3.50 ±115%    +414.3%      18.00 ± 97%  interrupts.CPU7.TLB:TLB_shootdowns
      7.17 ± 98%     -74.1%       1.86 ±158%  interrupts.CPU70.106:PCI-MSI.31981639-edge.i40e-eth0-TxRx-70
      0.00       +2.9e+101%       0.29 ±158%  interrupts.CPU70.117:PCI-MSI.31981650-edge.i40e-eth0-TxRx-81
      0.00       +2.9e+101%       0.29 ±158%  interrupts.CPU70.69:PCI-MSI.31981602-edge.i40e-eth0-TxRx-33
    640471 ± 22%     -29.8%     449697 ± 54%  interrupts.CPU70.CAL:Function_call_interrupts
      6.17 ± 49%    +157.1%      15.86 ± 14%  interrupts.CPU70.IWI:IRQ_work_interrupts
    533826 ±  6%    +142.0%    1292099 ± 15%  interrupts.CPU70.LOC:Local_timer_interrupts
      0.00       +1.6e+102%       1.57 ± 31%  interrupts.CPU70.MCP:Machine_check_polls
      6442 ± 20%      +3.2%       6650 ± 26%  interrupts.CPU70.NMI:Non-maskable_interrupts
      6442 ± 20%      +3.2%       6650 ± 26%  interrupts.CPU70.PMI:Performance_monitoring_interrupts
   1196812 ± 12%     -30.9%     826636 ± 13%  interrupts.CPU70.RES:Rescheduling_interrupts
      2.83 ±117%     +21.0%       3.43 ± 65%  interrupts.CPU70.TLB:TLB_shootdowns
     44.33 ±222%     -96.8%       1.43 ±244%  interrupts.CPU71.107:PCI-MSI.31981640-edge.i40e-eth0-TxRx-71
      0.00       +1.4e+101%       0.14 ±244%  interrupts.CPU71.118:PCI-MSI.31981651-edge.i40e-eth0-TxRx-82
      0.00       +2.9e+101%       0.29 ±158%  interrupts.CPU71.70:PCI-MSI.31981603-edge.i40e-eth0-TxRx-34
    604082 ± 38%     -36.1%     385710 ± 36%  interrupts.CPU71.CAL:Function_call_interrupts
      6.33 ± 47%    +143.6%      15.43 ± 12%  interrupts.CPU71.IWI:IRQ_work_interrupts
    533904 ±  6%    +142.0%    1292083 ± 15%  interrupts.CPU71.LOC:Local_timer_interrupts
      0.00       +1.6e+102%       1.57 ± 31%  interrupts.CPU71.MCP:Machine_check_polls
      7018           -28.8%       4998 ± 35%  interrupts.CPU71.NMI:Non-maskable_interrupts
      7018           -28.8%       4998 ± 35%  interrupts.CPU71.PMI:Performance_monitoring_interrupts
   1162878 ±  5%     -30.1%     812412 ± 14%  interrupts.CPU71.RES:Rescheduling_interrupts
      6.50 ± 93%     -58.2%       2.71 ± 37%  interrupts.CPU71.TLB:TLB_shootdowns
      0.00       +1.7e+104%     169.57 ±233%  interrupts.CPU72.108:PCI-MSI.31981641-edge.i40e-eth0-TxRx-72
    731417 ± 32%      -9.8%     660087 ± 39%  interrupts.CPU72.CAL:Function_call_interrupts
      6.00 ± 45%    +161.9%      15.71 ± 13%  interrupts.CPU72.IWI:IRQ_work_interrupts
    533717 ±  6%    +142.1%    1291870 ± 15%  interrupts.CPU72.LOC:Local_timer_interrupts
      0.00       +1.6e+102%       1.57 ± 31%  interrupts.CPU72.MCP:Machine_check_polls
      6076 ± 28%      +0.6%       6111 ± 31%  interrupts.CPU72.NMI:Non-maskable_interrupts
      6076 ± 28%      +0.6%       6111 ± 31%  interrupts.CPU72.PMI:Performance_monitoring_interrupts
   1162980 ± 12%     -24.5%     878050 ±  9%  interrupts.CPU72.RES:Rescheduling_interrupts
      2.00 ± 64%    +207.1%       6.14 ± 79%  interrupts.CPU72.TLB:TLB_shootdowns
      0.00       +7.6e+104%     762.00 ±244%  interrupts.CPU73.109:PCI-MSI.31981642-edge.i40e-eth0-TxRx-73
    716805 ± 16%     -14.5%     612620 ± 30%  interrupts.CPU73.CAL:Function_call_interrupts
      6.17 ± 49%    +152.5%      15.57 ± 13%  interrupts.CPU73.IWI:IRQ_work_interrupts
    533842 ±  6%    +142.0%    1291880 ± 15%  interrupts.CPU73.LOC:Local_timer_interrupts
      0.00       +1.6e+102%       1.57 ± 31%  interrupts.CPU73.MCP:Machine_check_polls
      6680 ± 20%     -16.9%       5551 ± 34%  interrupts.CPU73.NMI:Non-maskable_interrupts
      6680 ± 20%     -16.9%       5551 ± 34%  interrupts.CPU73.PMI:Performance_monitoring_interrupts
   1236922 ±  9%     -24.3%     935972 ± 10%  interrupts.CPU73.RES:Rescheduling_interrupts
      1.00 ±152%   +1242.9%      13.43 ±109%  interrupts.CPU73.TLB:TLB_shootdowns
      1.83 ±223%  +84702.6%       1554 ±158%  interrupts.CPU74.110:PCI-MSI.31981643-edge.i40e-eth0-TxRx-74
    771931 ± 25%     -32.8%     518928 ± 29%  interrupts.CPU74.CAL:Function_call_interrupts
      6.17 ± 49%    +154.8%      15.71 ± 12%  interrupts.CPU74.IWI:IRQ_work_interrupts
    533806 ±  6%    +142.0%    1291883 ± 15%  interrupts.CPU74.LOC:Local_timer_interrupts
      0.00       +1.6e+102%       1.57 ± 31%  interrupts.CPU74.MCP:Machine_check_polls
      6067 ± 28%      +1.0%       6128 ± 32%  interrupts.CPU74.NMI:Non-maskable_interrupts
      6067 ± 28%      +1.0%       6128 ± 32%  interrupts.CPU74.PMI:Performance_monitoring_interrupts
   1239165 ±  8%     -24.7%     932931 ± 11%  interrupts.CPU74.RES:Rescheduling_interrupts
      1.17 ±115%    +242.9%       4.00 ± 89%  interrupts.CPU74.TLB:TLB_shootdowns
     19.33 ±205%    -100.0%       0.00        interrupts.CPU75.111:PCI-MSI.31981644-edge.i40e-eth0-TxRx-75
    657134 ± 24%     -19.9%     526068 ± 34%  interrupts.CPU75.CAL:Function_call_interrupts
      6.17 ± 49%    +154.8%      15.71 ± 14%  interrupts.CPU75.IWI:IRQ_work_interrupts
    533870 ±  6%    +142.0%    1291887 ± 15%  interrupts.CPU75.LOC:Local_timer_interrupts
      0.00       +1.6e+102%       1.57 ± 31%  interrupts.CPU75.MCP:Machine_check_polls
      6684 ± 20%      -8.6%       6111 ± 31%  interrupts.CPU75.NMI:Non-maskable_interrupts
      6684 ± 20%      -8.6%       6111 ± 31%  interrupts.CPU75.PMI:Performance_monitoring_interrupts
   1224218 ± 12%     -25.7%     909621 ± 10%  interrupts.CPU75.RES:Rescheduling_interrupts
      1.50 ±113%    +442.9%       8.14 ±101%  interrupts.CPU75.TLB:TLB_shootdowns
     97.67 ±223%     -92.5%       7.29 ±194%  interrupts.CPU76.112:PCI-MSI.31981645-edge.i40e-eth0-TxRx-76
    576608 ± 11%     -11.0%     513409 ± 22%  interrupts.CPU76.CAL:Function_call_interrupts
      6.33 ± 54%    +148.1%      15.71 ± 15%  interrupts.CPU76.IWI:IRQ_work_interrupts
    533836 ±  6%    +142.0%    1291893 ± 15%  interrupts.CPU76.LOC:Local_timer_interrupts
      0.00       +1.6e+102%       1.57 ± 31%  interrupts.CPU76.MCP:Machine_check_polls
      6684 ± 20%      -8.4%       6123 ± 31%  interrupts.CPU76.NMI:Non-maskable_interrupts
      6684 ± 20%      -8.4%       6123 ± 31%  interrupts.CPU76.PMI:Performance_monitoring_interrupts
   1171805 ± 14%     -21.3%     922286 ±  8%  interrupts.CPU76.RES:Rescheduling_interrupts
      3.67 ± 94%     +63.6%       6.00 ± 90%  interrupts.CPU76.TLB:TLB_shootdowns
      1.67 ±223%  +14325.7%     240.43 ±244%  interrupts.CPU77.113:PCI-MSI.31981646-edge.i40e-eth0-TxRx-77
    592814 ± 16%     -16.0%     497841 ± 28%  interrupts.CPU77.CAL:Function_call_interrupts
      6.50 ± 51%    +146.2%      16.00 ± 13%  interrupts.CPU77.IWI:IRQ_work_interrupts
    533779 ±  6%    +142.0%    1291827 ± 15%  interrupts.CPU77.LOC:Local_timer_interrupts
      0.00       +1.6e+102%       1.57 ± 31%  interrupts.CPU77.MCP:Machine_check_polls
      7283            -0.8%       7226 ± 18%  interrupts.CPU77.NMI:Non-maskable_interrupts
      7283            -0.8%       7226 ± 18%  interrupts.CPU77.PMI:Performance_monitoring_interrupts
   1276221 ± 13%     -27.8%     921734 ±  8%  interrupts.CPU77.RES:Rescheduling_interrupts
      5.67 ± 95%      +0.8%       5.71 ± 50%  interrupts.CPU77.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU78.114:PCI-MSI.31981647-edge.i40e-eth0-TxRx-78
    676799 ± 12%     -14.9%     576038 ± 37%  interrupts.CPU78.CAL:Function_call_interrupts
      6.17 ± 49%    +150.2%      15.43 ± 12%  interrupts.CPU78.IWI:IRQ_work_interrupts
    533702 ±  6%    +142.1%    1291956 ± 15%  interrupts.CPU78.LOC:Local_timer_interrupts
      0.00       +1.6e+102%       1.57 ± 31%  interrupts.CPU78.MCP:Machine_check_polls
      6681 ± 20%     -25.1%       5007 ± 35%  interrupts.CPU78.NMI:Non-maskable_interrupts
      6681 ± 20%     -25.1%       5007 ± 35%  interrupts.CPU78.PMI:Performance_monitoring_interrupts
   1315660 ±  5%     -29.2%     931787 ±  9%  interrupts.CPU78.RES:Rescheduling_interrupts
      4.67 ± 77%     +99.0%       9.29 ± 88%  interrupts.CPU78.TLB:TLB_shootdowns
      0.17 ±223%  +2.3e+05%     382.57 ±233%  interrupts.CPU79.115:PCI-MSI.31981648-edge.i40e-eth0-TxRx-79
    678436 ± 28%     -23.9%     516366 ± 25%  interrupts.CPU79.CAL:Function_call_interrupts
      6.50 ± 51%    +144.0%      15.86 ± 15%  interrupts.CPU79.IWI:IRQ_work_interrupts
    533837 ±  6%    +142.0%    1291917 ± 15%  interrupts.CPU79.LOC:Local_timer_interrupts
      0.00       +1.6e+102%       1.57 ± 31%  interrupts.CPU79.MCP:Machine_check_polls
      7305           -16.1%       6126 ± 31%  interrupts.CPU79.NMI:Non-maskable_interrupts
      7305           -16.1%       6126 ± 31%  interrupts.CPU79.PMI:Performance_monitoring_interrupts
   1248750 ± 11%     -25.7%     928388 ±  8%  interrupts.CPU79.RES:Rescheduling_interrupts
      3.00 ±150%     +47.6%       4.43 ±131%  interrupts.CPU79.TLB:TLB_shootdowns
      0.17 ±223%    -100.0%       0.00        interrupts.CPU8.127:PCI-MSI.31981660-edge.i40e-eth0-TxRx-91
    523.00 ±193%     -99.8%       1.14 ±164%  interrupts.CPU8.44:PCI-MSI.31981577-edge.i40e-eth0-TxRx-8
      0.17 ±223%     +71.4%       0.29 ±158%  interrupts.CPU8.79:PCI-MSI.31981612-edge.i40e-eth0-TxRx-43
    588775 ± 26%     -36.3%     374994 ± 30%  interrupts.CPU8.CAL:Function_call_interrupts
      6.17 ± 49%    +159.5%      16.00 ± 13%  interrupts.CPU8.IWI:IRQ_work_interrupts
    533881 ±  6%    +142.0%    1292039 ± 15%  interrupts.CPU8.LOC:Local_timer_interrupts
      0.00       +1.6e+102%       1.57 ± 31%  interrupts.CPU8.MCP:Machine_check_polls
      6432 ± 20%     +12.1%       7210 ± 18%  interrupts.CPU8.NMI:Non-maskable_interrupts
      6432 ± 20%     +12.1%       7210 ± 18%  interrupts.CPU8.PMI:Performance_monitoring_interrupts
   1262842 ±  9%     -35.3%     817023 ± 13%  interrupts.CPU8.RES:Rescheduling_interrupts
      4.50 ±126%    +385.7%      21.86 ± 90%  interrupts.CPU8.TLB:TLB_shootdowns
      0.00         +6e+102%       6.00 ±238%  interrupts.CPU80.116:PCI-MSI.31981649-edge.i40e-eth0-TxRx-80
    655256 ± 32%     -13.4%     567317 ± 30%  interrupts.CPU80.CAL:Function_call_interrupts
      6.50 ± 51%    +144.0%      15.86 ± 13%  interrupts.CPU80.IWI:IRQ_work_interrupts
    533825 ±  6%    +142.0%    1291939 ± 15%  interrupts.CPU80.LOC:Local_timer_interrupts
      0.00       +1.6e+102%       1.57 ± 31%  interrupts.CPU80.MCP:Machine_check_polls
      7306            -8.7%       6673 ± 26%  interrupts.CPU80.NMI:Non-maskable_interrupts
      7306            -8.7%       6673 ± 26%  interrupts.CPU80.PMI:Performance_monitoring_interrupts
   1244225 ± 10%     -26.5%     914920 ±  9%  interrupts.CPU80.RES:Rescheduling_interrupts
      4.83 ± 72%      -8.4%       4.43 ± 94%  interrupts.CPU80.TLB:TLB_shootdowns
      0.00       +4.2e+103%      41.86 ±242%  interrupts.CPU81.117:PCI-MSI.31981650-edge.i40e-eth0-TxRx-81
    652038 ± 11%     -14.3%     558497 ± 37%  interrupts.CPU81.CAL:Function_call_interrupts
      6.50 ± 51%    +144.0%      15.86 ± 14%  interrupts.CPU81.IWI:IRQ_work_interrupts
    533957 ±  6%    +142.0%    1291924 ± 15%  interrupts.CPU81.LOC:Local_timer_interrupts
      0.00       +1.6e+102%       1.57 ± 31%  interrupts.CPU81.MCP:Machine_check_polls
      7287            -8.3%       6684 ± 26%  interrupts.CPU81.NMI:Non-maskable_interrupts
      7287            -8.3%       6684 ± 26%  interrupts.CPU81.PMI:Performance_monitoring_interrupts
   1312896 ±  9%     -28.0%     945501 ±  9%  interrupts.CPU81.RES:Rescheduling_interrupts
      4.50 ± 83%     +27.0%       5.71 ± 94%  interrupts.CPU81.TLB:TLB_shootdowns
     13.17 ±223%   +1195.5%     170.57 ±186%  interrupts.CPU82.118:PCI-MSI.31981651-edge.i40e-eth0-TxRx-82
    696255 ± 19%     -33.4%     463472 ± 24%  interrupts.CPU82.CAL:Function_call_interrupts
      6.33 ± 47%    +152.6%      16.00 ± 12%  interrupts.CPU82.IWI:IRQ_work_interrupts
    533743 ±  6%    +142.0%    1291883 ± 15%  interrupts.CPU82.LOC:Local_timer_interrupts
      0.00       +1.6e+102%       1.57 ± 31%  interrupts.CPU82.MCP:Machine_check_polls
      7295            -0.9%       7232 ± 18%  interrupts.CPU82.NMI:Non-maskable_interrupts
      7295            -0.9%       7232 ± 18%  interrupts.CPU82.PMI:Performance_monitoring_interrupts
   1271024 ± 12%     -28.8%     905109 ± 10%  interrupts.CPU82.RES:Rescheduling_interrupts
      4.67 ±114%      +7.1%       5.00 ± 77%  interrupts.CPU82.TLB:TLB_shootdowns
    551.50 ±152%    +646.1%       4115 ±225%  interrupts.CPU83.119:PCI-MSI.31981652-edge.i40e-eth0-TxRx-83
    569075 ± 10%      -5.0%     540766 ± 30%  interrupts.CPU83.CAL:Function_call_interrupts
      6.50 ± 51%    +146.2%      16.00 ± 14%  interrupts.CPU83.IWI:IRQ_work_interrupts
    533843 ±  6%    +142.0%    1291896 ± 15%  interrupts.CPU83.LOC:Local_timer_interrupts
      0.00       +1.6e+102%       1.57 ± 31%  interrupts.CPU83.MCP:Machine_check_polls
      7353            -1.7%       7227 ± 18%  interrupts.CPU83.NMI:Non-maskable_interrupts
      7353            -1.7%       7227 ± 18%  interrupts.CPU83.PMI:Performance_monitoring_interrupts
   1276166 ±  9%     -27.8%     921601 ± 10%  interrupts.CPU83.RES:Rescheduling_interrupts
      1.67 ± 66%    +328.6%       7.14 ± 71%  interrupts.CPU83.TLB:TLB_shootdowns
      0.00       +1.4e+101%       0.14 ±244%  interrupts.CPU84.120:PCI-MSI.31981653-edge.i40e-eth0-TxRx-84
    676539 ± 29%     -19.0%     548180 ± 31%  interrupts.CPU84.CAL:Function_call_interrupts
      6.17 ± 49%    +159.5%      16.00 ± 13%  interrupts.CPU84.IWI:IRQ_work_interrupts
    533874 ±  6%    +142.0%    1291815 ± 15%  interrupts.CPU84.LOC:Local_timer_interrupts
      0.00       +1.6e+102%       1.57 ± 31%  interrupts.CPU84.MCP:Machine_check_polls
      6101 ± 28%     +18.5%       7227 ± 18%  interrupts.CPU84.NMI:Non-maskable_interrupts
      6101 ± 28%     +18.5%       7227 ± 18%  interrupts.CPU84.PMI:Performance_monitoring_interrupts
   1241773 ± 10%     -25.7%     923051 ± 10%  interrupts.CPU84.RES:Rescheduling_interrupts
      2.17 ± 67%    +117.6%       4.71 ±114%  interrupts.CPU84.TLB:TLB_shootdowns
      0.33 ±223%     +28.6%       0.43 ±244%  interrupts.CPU85.121:PCI-MSI.31981654-edge.i40e-eth0-TxRx-85
    578033 ± 13%     -20.5%     459312 ± 30%  interrupts.CPU85.CAL:Function_call_interrupts
      6.33 ± 54%    +154.9%      16.14 ± 13%  interrupts.CPU85.IWI:IRQ_work_interrupts
    533777 ±  6%    +142.0%    1291919 ± 15%  interrupts.CPU85.LOC:Local_timer_interrupts
      0.00       +1.6e+102%       1.57 ± 31%  interrupts.CPU85.MCP:Machine_check_polls
      6689 ± 20%     +16.4%       7785        interrupts.CPU85.NMI:Non-maskable_interrupts
      6689 ± 20%     +16.4%       7785        interrupts.CPU85.PMI:Performance_monitoring_interrupts
   1270270 ± 13%     -29.3%     898640 ±  8%  interrupts.CPU85.RES:Rescheduling_interrupts
      1.50 ± 83%    +566.7%      10.00 ± 80%  interrupts.CPU85.TLB:TLB_shootdowns
      0.00       +5.7e+102%       5.71 ±204%  interrupts.CPU86.122:PCI-MSI.31981655-edge.i40e-eth0-TxRx-86
    712838 ± 24%     -14.6%     608558 ± 32%  interrupts.CPU86.CAL:Function_call_interrupts
      6.50 ± 51%    +146.2%      16.00 ± 14%  interrupts.CPU86.IWI:IRQ_work_interrupts
    533807 ±  6%    +142.0%    1291918 ± 15%  interrupts.CPU86.LOC:Local_timer_interrupts
      0.00       +1.6e+102%       1.57 ± 31%  interrupts.CPU86.MCP:Machine_check_polls
      7292            -0.9%       7226 ± 18%  interrupts.CPU86.NMI:Non-maskable_interrupts
      7292            -0.9%       7226 ± 18%  interrupts.CPU86.PMI:Performance_monitoring_interrupts
   1264833 ± 15%     -26.8%     925543 ±  8%  interrupts.CPU86.RES:Rescheduling_interrupts
      2.83 ±102%    +232.8%       9.43 ± 87%  interrupts.CPU86.TLB:TLB_shootdowns
      6.50 ±216%     -75.8%       1.57 ±194%  interrupts.CPU87.123:PCI-MSI.31981656-edge.i40e-eth0-TxRx-87
    846925 ± 27%     -40.4%     504973 ± 22%  interrupts.CPU87.CAL:Function_call_interrupts
      6.50 ± 51%    +144.0%      15.86 ± 13%  interrupts.CPU87.IWI:IRQ_work_interrupts
    533794 ±  6%    +142.0%    1291913 ± 15%  interrupts.CPU87.LOC:Local_timer_interrupts
      0.00       +1.6e+102%       1.57 ± 31%  interrupts.CPU87.MCP:Machine_check_polls
      7293            -8.6%       6667 ± 26%  interrupts.CPU87.NMI:Non-maskable_interrupts
      7293            -8.6%       6667 ± 26%  interrupts.CPU87.PMI:Performance_monitoring_interrupts
   1209681 ±  9%     -22.9%     932490 ±  7%  interrupts.CPU87.RES:Rescheduling_interrupts
      4.17 ± 77%    +184.6%      11.86 ±117%  interrupts.CPU87.TLB:TLB_shootdowns
      0.00       +8.1e+102%       8.14 ±206%  interrupts.CPU88.124:PCI-MSI.31981657-edge.i40e-eth0-TxRx-88
    757873 ±  8%     -36.5%     481542 ± 23%  interrupts.CPU88.CAL:Function_call_interrupts
      6.50 ± 51%    +141.8%      15.71 ± 12%  interrupts.CPU88.IWI:IRQ_work_interrupts
    533778 ±  6%    +142.0%    1291846 ± 15%  interrupts.CPU88.LOC:Local_timer_interrupts
      0.00       +1.6e+102%       1.57 ± 31%  interrupts.CPU88.MCP:Machine_check_polls
      7285           -15.9%       6123 ± 31%  interrupts.CPU88.NMI:Non-maskable_interrupts
      7285           -15.9%       6123 ± 31%  interrupts.CPU88.PMI:Performance_monitoring_interrupts
   1251334 ± 10%     -26.7%     916636 ±  8%  interrupts.CPU88.RES:Rescheduling_interrupts
      5.00 ±116%     +25.7%       6.29 ±104%  interrupts.CPU88.TLB:TLB_shootdowns
      0.00         +3e+102%       3.00 ±164%  interrupts.CPU89.125:PCI-MSI.31981658-edge.i40e-eth0-TxRx-89
    642833 ± 14%     -22.3%     499261 ± 37%  interrupts.CPU89.CAL:Function_call_interrupts
      6.50 ± 51%    +146.2%      16.00 ± 12%  interrupts.CPU89.IWI:IRQ_work_interrupts
    533763 ±  6%    +142.0%    1291854 ± 15%  interrupts.CPU89.LOC:Local_timer_interrupts
      0.00       +1.6e+102%       1.57 ± 31%  interrupts.CPU89.MCP:Machine_check_polls
      7282            -8.4%       6673 ± 26%  interrupts.CPU89.NMI:Non-maskable_interrupts
      7282            -8.4%       6673 ± 26%  interrupts.CPU89.PMI:Performance_monitoring_interrupts
   1253741 ± 14%     -26.6%     919715 ±  9%  interrupts.CPU89.RES:Rescheduling_interrupts
     95.17 ±216%     -94.9%       4.86 ± 94%  interrupts.CPU89.TLB:TLB_shootdowns
      0.17 ±223%     -14.3%       0.14 ±244%  interrupts.CPU9.128:PCI-MSI.31981661-edge.i40e-eth0-TxRx-92
     20.00 ±180%    -100.0%       0.00        interrupts.CPU9.45:PCI-MSI.31981578-edge.i40e-eth0-TxRx-9
      0.17 ±223%     -14.3%       0.14 ±244%  interrupts.CPU9.80:PCI-MSI.31981613-edge.i40e-eth0-TxRx-44
    599018 ± 26%     -40.5%     356664 ± 34%  interrupts.CPU9.CAL:Function_call_interrupts
      6.00 ± 45%    +166.7%      16.00 ± 13%  interrupts.CPU9.IWI:IRQ_work_interrupts
    533831 ±  6%    +142.0%    1292029 ± 15%  interrupts.CPU9.LOC:Local_timer_interrupts
      0.00       +1.6e+102%       1.57 ± 31%  interrupts.CPU9.MCP:Machine_check_polls
      6446 ± 20%     +11.8%       7209 ± 18%  interrupts.CPU9.NMI:Non-maskable_interrupts
      6446 ± 20%     +11.8%       7209 ± 18%  interrupts.CPU9.PMI:Performance_monitoring_interrupts
   1245711 ± 10%     -34.5%     815619 ± 14%  interrupts.CPU9.RES:Rescheduling_interrupts
      7.33 ±108%    +328.6%      31.43 ±112%  interrupts.CPU9.TLB:TLB_shootdowns
      0.00       +1.4e+101%       0.14 ±244%  interrupts.CPU90.126:PCI-MSI.31981659-edge.i40e-eth0-TxRx-90
    734686 ± 22%     -35.7%     472512 ± 29%  interrupts.CPU90.CAL:Function_call_interrupts
      6.50 ± 51%    +146.2%      16.00 ± 12%  interrupts.CPU90.IWI:IRQ_work_interrupts
    533788 ±  6%    +142.0%    1291894 ± 15%  interrupts.CPU90.LOC:Local_timer_interrupts
      0.00       +1.6e+102%       1.57 ± 31%  interrupts.CPU90.MCP:Machine_check_polls
      7296            -1.0%       7225 ± 18%  interrupts.CPU90.NMI:Non-maskable_interrupts
      7296            -1.0%       7225 ± 18%  interrupts.CPU90.PMI:Performance_monitoring_interrupts
   1303074 ±  6%     -30.0%     912724 ±  9%  interrupts.CPU90.RES:Rescheduling_interrupts
      2.83 ±146%    +116.8%       6.14 ± 63%  interrupts.CPU90.TLB:TLB_shootdowns
     11.17 ±223%     -88.5%       1.29 ±169%  interrupts.CPU91.127:PCI-MSI.31981660-edge.i40e-eth0-TxRx-91
    644941 ± 20%      -8.3%     591540 ± 37%  interrupts.CPU91.CAL:Function_call_interrupts
      6.50 ± 51%    +146.2%      16.00 ± 11%  interrupts.CPU91.IWI:IRQ_work_interrupts
    533831 ±  6%    +142.0%    1291963 ± 15%  interrupts.CPU91.LOC:Local_timer_interrupts
      0.00       +1.6e+102%       1.57 ± 31%  interrupts.CPU91.MCP:Machine_check_polls
      7293            -8.3%       6685 ± 26%  interrupts.CPU91.NMI:Non-maskable_interrupts
      7293            -8.3%       6685 ± 26%  interrupts.CPU91.PMI:Performance_monitoring_interrupts
   1283436 ± 11%     -28.2%     921466 ±  8%  interrupts.CPU91.RES:Rescheduling_interrupts
      2.33 ± 31%    +108.2%       4.86 ± 96%  interrupts.CPU91.TLB:TLB_shootdowns
      6.67 ±223%   +3491.4%     239.43 ±219%  interrupts.CPU92.128:PCI-MSI.31981661-edge.i40e-eth0-TxRx-92
    833269 ± 20%     -35.6%     536815 ± 17%  interrupts.CPU92.CAL:Function_call_interrupts
      6.33 ± 54%    +152.6%      16.00 ± 12%  interrupts.CPU92.IWI:IRQ_work_interrupts
    533774 ±  6%    +142.0%    1291884 ± 15%  interrupts.CPU92.LOC:Local_timer_interrupts
      0.00       +1.6e+102%       1.57 ± 31%  interrupts.CPU92.MCP:Machine_check_polls
      6699 ± 20%      +7.9%       7226 ± 18%  interrupts.CPU92.NMI:Non-maskable_interrupts
      6699 ± 20%      +7.9%       7226 ± 18%  interrupts.CPU92.PMI:Performance_monitoring_interrupts
   1174427 ± 15%     -19.8%     942377 ± 11%  interrupts.CPU92.RES:Rescheduling_interrupts
      2.67 ± 55%    +296.4%      10.57 ±116%  interrupts.CPU92.TLB:TLB_shootdowns
      0.00       +2.1e+104%     212.71 ±233%  interrupts.CPU93.129:PCI-MSI.31981662-edge.i40e-eth0-TxRx-93
    749977 ± 16%     -33.3%     500055 ± 30%  interrupts.CPU93.CAL:Function_call_interrupts
      6.33 ± 47%    +150.4%      15.86 ± 13%  interrupts.CPU93.IWI:IRQ_work_interrupts
    533836 ±  6%    +142.0%    1291908 ± 15%  interrupts.CPU93.LOC:Local_timer_interrupts
      0.00       +1.6e+102%       1.57 ± 31%  interrupts.CPU93.MCP:Machine_check_polls
      6708 ± 20%      -0.6%       6666 ± 26%  interrupts.CPU93.NMI:Non-maskable_interrupts
      6708 ± 20%      -0.6%       6666 ± 26%  interrupts.CPU93.PMI:Performance_monitoring_interrupts
   1293987 ± 11%     -27.5%     937947 ± 11%  interrupts.CPU93.RES:Rescheduling_interrupts
      2.33 ± 40%     +95.9%       4.57 ± 97%  interrupts.CPU93.TLB:TLB_shootdowns
    671258 ± 15%     -26.3%     494998 ± 36%  interrupts.CPU94.CAL:Function_call_interrupts
      6.50 ± 51%    +141.8%      15.71 ± 12%  interrupts.CPU94.IWI:IRQ_work_interrupts
    533797 ±  6%    +142.0%    1291947 ± 15%  interrupts.CPU94.LOC:Local_timer_interrupts
      0.00       +1.6e+102%       1.57 ± 31%  interrupts.CPU94.MCP:Machine_check_polls
      7286           -16.1%       6112 ± 31%  interrupts.CPU94.NMI:Non-maskable_interrupts
      7286           -16.1%       6112 ± 31%  interrupts.CPU94.PMI:Performance_monitoring_interrupts
   1278981 ± 12%     -28.0%     921275 ±  9%  interrupts.CPU94.RES:Rescheduling_interrupts
      2.50 ± 38%    +105.7%       5.14 ± 79%  interrupts.CPU94.TLB:TLB_shootdowns
    687641 ± 22%     -16.8%     572211 ± 26%  interrupts.CPU95.CAL:Function_call_interrupts
      6.17 ± 42%    +159.5%      16.00 ± 14%  interrupts.CPU95.IWI:IRQ_work_interrupts
    533802 ±  6%    +142.0%    1291840 ± 15%  interrupts.CPU95.LOC:Local_timer_interrupts
      0.00       +1.6e+102%       1.57 ± 31%  interrupts.CPU95.MCP:Machine_check_polls
      7298            -1.0%       7226 ± 18%  interrupts.CPU95.NMI:Non-maskable_interrupts
      7298            -1.0%       7226 ± 18%  interrupts.CPU95.PMI:Performance_monitoring_interrupts
   1333286 ± 11%     -31.1%     918997 ±  9%  interrupts.CPU95.RES:Rescheduling_interrupts
     12.83 ± 39%     +19.1%      15.29 ± 87%  interrupts.CPU95.TLB:TLB_shootdowns
    600.50 ± 47%    +155.9%       1536 ± 13%  interrupts.IWI:IRQ_work_interrupts
  51248597 ±  6%    +142.0%   1.24e+08 ± 15%  interrupts.LOC:Local_timer_interrupts
      0.00       +1.5e+104%     150.86 ± 31%  interrupts.MCP:Machine_check_polls
    656893 ±  2%      +3.4%     679460 ±  3%  interrupts.NMI:Non-maskable_interrupts
    656893 ±  2%      +3.4%     679460 ±  3%  interrupts.PMI:Performance_monitoring_interrupts
 1.209e+08 ±  7%     -31.3%   83093213 ± 10%  interrupts.RES:Rescheduling_interrupts
      0.00          -100.0%       0.00        interrupts.RTR:APIC_ICR_read_retries
    778.33 ± 38%     +63.6%       1273 ± 41%  interrupts.TLB:TLB_shootdowns




Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


Thanks,
Oliver Sang


--dc+cDN39EJAMEtIO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=reproduce


for cpu_dir in /sys/devices/system/cpu/cpu[0-9]*
do
	online_file="$cpu_dir"/online
	[ -f "$online_file" ] && [ "$(cat "$online_file")" -eq 0 ] && continue

	file="$cpu_dir"/cpufreq/scaling_governor
	[ -f "$file" ] && echo "performance" > "$file"
done

 "/usr/bin/hackbench" "-g" "96" "--process" "-l" "30000" "-s" "100"
 "/usr/bin/hackbench" "-g" "96" "--process" "-l" "30000" "-s" "100"
 "/usr/bin/hackbench" "-g" "96" "--process" "-l" "30000" "-s" "100"
 "/usr/bin/hackbench" "-g" "96" "--process" "-l" "30000" "-s" "100"

--dc+cDN39EJAMEtIO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="config-5.8.0-09691-g10befea91b61c4"

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
CONFIG_HAVE_MEMORY_PRESENT=y
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
CONFIG_MEDIA_CEC_SUPPORT=y
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
CONFIG_KASAN_STACK=1
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

--dc+cDN39EJAMEtIO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=job-script

#!/bin/sh

export_top_env()
{
	export suite='hackbench'
	export testcase='hackbench'
	export category='benchmark'
	export disable_latency_stats=1
	export nr_threads=96
	export iterations=4
	export job_origin='hackbench-100.yaml'
	export queue_cmdline_keys=
	export queue='vip'
	export testbox='lkp-csl-2sp7'
	export tbox_group='lkp-csl-2sp7'
	export branch='linus/master'
	export commit='10befea91b61c4e2c2d1df06a2e978d182fcf792'
	export kconfig='x86_64-rhel-8.3'
	export submit_id='5fe542c80b9a93a13a597522'
	export job_file='/lkp/jobs/scheduled/lkp-csl-2sp7/hackbench-performance-socket-4-process-100%-ucode=0x5003003-monitor=0fe5055f-debian-10.4-x86_64-20200603.cgz-10befea91b61c4e2c2d-20201225-41274-1krqfs5-0.yaml'
	export id='f3e4dd6fe4c09e159394b2adea0ab067ce543345'
	export queuer_version='/lkp/zxing/.src-20201223-092008'
	export model='Cascade Lake'
	export nr_node=2
	export nr_cpu=96
	export memory='512G'
	export nr_hdd_partitions=1
	export nr_ssd_partitions=1
	export hdd_partitions='/dev/disk/by-id/ata-ST1000NM0055-1V410C_ZBS1K5E0-part1'
	export ssd_partitions='/dev/disk/by-id/ata-INTEL_SSDSC2BB800G4_PHWL4204000G800RGN-part1'
	export swap_partitions=
	export rootfs_partition='/dev/disk/by-id/ata-ST1000NM0055-1V410C_ZBS1K5E0-part2'
	export brand='Intel(R) Xeon(R) Gold 6252 CPU @ 2.10GHz'
	export ucode='0x5003003'
	export need_kconfig_hw='CONFIG_I40E=y
CONFIG_SATA_AHCI'
	export rootfs='debian-10.4-x86_64-20200603.cgz'
	export monitor_sha='0fe5055f'
	export enqueue_time='2020-12-25 09:39:20 +0800'
	export compiler='gcc-9'
	export _id='5fe542c80b9a93a13a597522'
	export _rt='/result/hackbench/performance-socket-4-process-100%-ucode=0x5003003-monitor=0fe5055f/lkp-csl-2sp7/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/10befea91b61c4e2c2d1df06a2e978d182fcf792'
	export user='lkp'
	export LKP_SERVER='internal-lkp-server'
	export kernel='/pkg/linux/x86_64-rhel-8.3/gcc-9/10befea91b61c4e2c2d1df06a2e978d182fcf792/vmlinuz-5.8.0-09691-g10befea91b61c4'
	export result_root='/result/hackbench/performance-socket-4-process-100%-ucode=0x5003003-monitor=0fe5055f/lkp-csl-2sp7/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/10befea91b61c4e2c2d1df06a2e978d182fcf792/0'
	export dequeue_time='2020-12-25 11:28:25 +0800'
	export scheduler_version='/lkp/lkp/.src-20201224-092605'
	export arch='x86_64'
	export max_uptime=2100
	export initrd='/osimage/debian/debian-10.4-x86_64-20200603.cgz'
	export bootloader_append='root=/dev/ram0
user=lkp
job=/lkp/jobs/scheduled/lkp-csl-2sp7/hackbench-performance-socket-4-process-100%-ucode=0x5003003-monitor=0fe5055f-debian-10.4-x86_64-20200603.cgz-10befea91b61c4e2c2d-20201225-41274-1krqfs5-0.yaml
ARCH=x86_64
kconfig=x86_64-rhel-8.3
branch=linus/master
commit=10befea91b61c4e2c2d1df06a2e978d182fcf792
BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3/gcc-9/10befea91b61c4e2c2d1df06a2e978d182fcf792/vmlinuz-5.8.0-09691-g10befea91b61c4
max_uptime=2100
RESULT_ROOT=/result/hackbench/performance-socket-4-process-100%-ucode=0x5003003-monitor=0fe5055f/lkp-csl-2sp7/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/10befea91b61c4e2c2d1df06a2e978d182fcf792/0
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
	export modules_initrd='/pkg/linux/x86_64-rhel-8.3/gcc-9/10befea91b61c4e2c2d1df06a2e978d182fcf792/modules.cgz'
	export bm_initrd='/osimage/deps/debian-10.4-x86_64-20200603.cgz/run-ipconfig_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/lkp_20201211.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/rsync-rootfs_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/hackbench_20200715.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/hackbench-x86_64-1.9-1_20201027.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/mpstat_20200714.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/perf_20201126.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/perf-x86_64-fa02fcd94b0c-1_20201126.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/sar-x86_64-34c92ae-1_20200702.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/hw_20200715.cgz'
	export ucode_initrd='/osimage/ucode/intel-ucode-20201117.cgz'
	export lkp_initrd='/osimage/user/lkp/lkp-x86_64.cgz'
	export site='inn'
	export LKP_CGI_PORT=80
	export LKP_CIFS_PORT=139
	export job_initrd='/lkp/jobs/scheduled/lkp-csl-2sp7/hackbench-performance-socket-4-process-100%-ucode=0x5003003-monitor=0fe5055f-debian-10.4-x86_64-20200603.cgz-10befea91b61c4e2c2d-20201225-41274-1krqfs5-0.cgz'

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
	run_monitor $LKP_SRC/monitors/no-stdout/wrapper perf-profile
	run_monitor pmeter_server='lkp-nhm-dp1' pmeter_device='yokogawa-wt310' $LKP_SRC/monitors/wrapper pmeter
	run_monitor $LKP_SRC/monitors/wrapper oom-killer
	run_monitor $LKP_SRC/monitors/plain/watchdog

	run_test mode='process' ipc='socket' $LKP_SRC/tests/wrapper hackbench
}

extract_stats()
{
	export stats_part_begin=
	export stats_part_end=

	$LKP_SRC/stats/wrapper hackbench
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
	$LKP_SRC/stats/wrapper perf-profile
	$LKP_SRC/stats/wrapper pmeter

	$LKP_SRC/stats/wrapper time hackbench.time
	$LKP_SRC/stats/wrapper dmesg
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper last_state
	$LKP_SRC/stats/wrapper stderr
	$LKP_SRC/stats/wrapper time
}

"$@"

--dc+cDN39EJAMEtIO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="job.yaml"

---

#! hackbench-100.yaml
suite: hackbench
testcase: hackbench
category: benchmark
disable_latency_stats: 1
nr_threads: 100%
iterations: 4
hackbench:
  mode: process
  ipc: socket
job_origin: hackbench-100.yaml

#! queue options
queue_cmdline_keys: []
queue: vip
testbox: lkp-csl-2sp7
tbox_group: lkp-csl-2sp7
branch: linus/master
commit: 10befea91b61c4e2c2d1df06a2e978d182fcf792
kconfig: x86_64-rhel-8.3
submit_id: 5fe542c80b9a93a13a597522
job_file: "/lkp/jobs/scheduled/lkp-csl-2sp7/hackbench-performance-socket-4-process-100%-ucode=0x5003003-monitor=0fe5055f-debian-10.4-x86_64-20200603.cgz-10befea91b61c4e2c2d-20201225-41274-1krqfs5-0.yaml"
id: f3e4dd6fe4c09e159394b2adea0ab067ce543345
queuer_version: "/lkp/zxing/.src-20201223-092008"

#! hosts/lkp-csl-2sp7
model: Cascade Lake
nr_node: 2
nr_cpu: 96
memory: 512G
nr_hdd_partitions: 1
nr_ssd_partitions: 1
hdd_partitions: "/dev/disk/by-id/ata-ST1000NM0055-1V410C_ZBS1K5E0-part1"
ssd_partitions: "/dev/disk/by-id/ata-INTEL_SSDSC2BB800G4_PHWL4204000G800RGN-part1"
swap_partitions: 
rootfs_partition: "/dev/disk/by-id/ata-ST1000NM0055-1V410C_ZBS1K5E0-part2"
brand: Intel(R) Xeon(R) Gold 6252 CPU @ 2.10GHz

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
perf-profile: 

#! include/category/ALL
cpufreq_governor: performance

#! include/testbox/lkp-csl-2sp7
ucode: '0x5003003'
need_kconfig_hw:
- CONFIG_I40E=y
- CONFIG_SATA_AHCI
pmeter:
  pmeter_server: lkp-nhm-dp1
  pmeter_device: yokogawa-wt310
rootfs: debian-10.4-x86_64-20200603.cgz
monitor_sha: 0fe5055f
enqueue_time: 2020-12-25 09:39:20.581032912 +08:00
compiler: gcc-9
_id: 5fe542c80b9a93a13a597522
_rt: "/result/hackbench/performance-socket-4-process-100%-ucode=0x5003003-monitor=0fe5055f/lkp-csl-2sp7/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/10befea91b61c4e2c2d1df06a2e978d182fcf792"

#! schedule options
user: lkp
LKP_SERVER: internal-lkp-server
kernel: "/pkg/linux/x86_64-rhel-8.3/gcc-9/10befea91b61c4e2c2d1df06a2e978d182fcf792/vmlinuz-5.8.0-09691-g10befea91b61c4"
result_root: "/result/hackbench/performance-socket-4-process-100%-ucode=0x5003003-monitor=0fe5055f/lkp-csl-2sp7/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/10befea91b61c4e2c2d1df06a2e978d182fcf792/0"
dequeue_time: 2020-12-25 11:28:25.766650012 +08:00
scheduler_version: "/lkp/lkp/.src-20201224-092605"
arch: x86_64
max_uptime: 2100
initrd: "/osimage/debian/debian-10.4-x86_64-20200603.cgz"
bootloader_append:
- root=/dev/ram0
- user=lkp
- job=/lkp/jobs/scheduled/lkp-csl-2sp7/hackbench-performance-socket-4-process-100%-ucode=0x5003003-monitor=0fe5055f-debian-10.4-x86_64-20200603.cgz-10befea91b61c4e2c2d-20201225-41274-1krqfs5-0.yaml
- ARCH=x86_64
- kconfig=x86_64-rhel-8.3
- branch=linus/master
- commit=10befea91b61c4e2c2d1df06a2e978d182fcf792
- BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3/gcc-9/10befea91b61c4e2c2d1df06a2e978d182fcf792/vmlinuz-5.8.0-09691-g10befea91b61c4
- max_uptime=2100
- RESULT_ROOT=/result/hackbench/performance-socket-4-process-100%-ucode=0x5003003-monitor=0fe5055f/lkp-csl-2sp7/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/10befea91b61c4e2c2d1df06a2e978d182fcf792/0
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
modules_initrd: "/pkg/linux/x86_64-rhel-8.3/gcc-9/10befea91b61c4e2c2d1df06a2e978d182fcf792/modules.cgz"
bm_initrd: "/osimage/deps/debian-10.4-x86_64-20200603.cgz/run-ipconfig_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/lkp_20201211.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/rsync-rootfs_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/hackbench_20200715.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/hackbench-x86_64-1.9-1_20201027.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/mpstat_20200714.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/perf_20201126.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/perf-x86_64-fa02fcd94b0c-1_20201126.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/sar-x86_64-34c92ae-1_20200702.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/hw_20200715.cgz"
ucode_initrd: "/osimage/ucode/intel-ucode-20201117.cgz"
lkp_initrd: "/osimage/user/lkp/lkp-x86_64.cgz"
site: inn

#! /lkp/lkp/.src-20201224-092605/include/site/inn
LKP_CGI_PORT: 80
LKP_CIFS_PORT: 139
oom-killer: 
watchdog: 

#! runtime status
job_state: finished
last_kernel: 5.8.0-09691-g10befea91b61c4
loadavg: 650.43 1226.71 819.92 1/707 32864
start_time: '1608866337'
end_time: '1608867052'
version: "/lkp/lkp/.src-20201224-092638:04492474:85b1a3dae"

--dc+cDN39EJAMEtIO--
