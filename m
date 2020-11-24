Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B313D2C1BD2
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 04:04:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728733AbgKXDCN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 22:02:13 -0500
Received: from mga06.intel.com ([134.134.136.31]:25365 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728721AbgKXDCJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 22:02:09 -0500
IronPort-SDR: XXApu5zo6wRQj+A1DmXJeRpydWFxz1Z0LBrABjUUQg123yrHqQ3ZftEQ+aaIQpZsDKeQlc7/xA
 fm+/05/VSLtw==
X-IronPort-AV: E=McAfee;i="6000,8403,9814"; a="233490545"
X-IronPort-AV: E=Sophos;i="5.78,364,1599548400"; 
   d="yaml'?scan'208";a="233490545"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2020 19:01:51 -0800
IronPort-SDR: E7b8K84mJT8YSyV+6hKTZDkb1ZxQrt9PxduTb8eQVwQEZUfPXaLrrWErVGXauog6AdC6QWfH5l
 Na1rawqDWV9w==
X-IronPort-AV: E=Sophos;i="5.78,364,1599548400"; 
   d="yaml'?scan'208";a="546659068"
Received: from xsang-optiplex-9020.sh.intel.com (HELO xsang-OptiPlex-9020) ([10.239.159.140])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2020 19:01:45 -0800
Date:   Tue, 24 Nov 2020 11:15:58 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     Waiman Long <longman@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
        Phil Auld <pauld@redhat.com>, Waiman Long <longman@redhat.com>,
        0day robot <lkp@intel.com>, lkp@lists.01.org,
        ying.huang@intel.com, feng.tang@intel.com, zhengjun.xing@intel.com
Subject: [locking/rwsem]  c9847a7f94:  aim7.jobs-per-min -91.8% regression
Message-ID: <20201124031558.GA7136@xsang-OptiPlex-9020>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="IJpNTDwzlM2Ie8A6"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201121041416.12285-5-longman@redhat.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--IJpNTDwzlM2Ie8A6
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit


Greeting,

FYI, we noticed a -91.8% regression of aim7.jobs-per-min due to commit:


commit: c9847a7f94679e742710574a2a7fee1c30c5ecf0 ("[PATCH v2 4/5] locking/rwsem: Wake up all waiting readers if RWSEM_WAKE_READ_OWNED")
url: https://github.com/0day-ci/linux/commits/Waiman-Long/locking-rwsem-Rework-reader-optimistic-spinning/20201121-122118
base: https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git 932f8c64d38bb08f69c8c26a2216ba0c36c6daa8

in testcase: aim7
on test machine: 96 threads Intel(R) Xeon(R) Platinum 8260L CPU @ 2.40GHz with 128G memory
with following parameters:

	disk: 4BRD_12G
	md: RAID0
	fs: f2fs
	test: sync_disk_rw
	load: 100
	cpufreq_governor: performance
	ucode: 0x4003003

test-description: AIM7 is a traditional UNIX system level benchmark suite which is used to test and measure the performance of multiuser system.
test-url: https://sourceforge.net/projects/aimbench/files/aim-suite7/

In addition to that, the commit also has significant impact on the following tests:

+------------------+-------------------------------------------------------------------+
| testcase: change | unixbench: unixbench.score -1.9% regression                       |
| test machine     | 16 threads Intel(R) Xeon(R) E-2278G CPU @ 3.40GHz with 32G memory |
| test parameters  | cpufreq_governor=performance                                      |
|                  | nr_task=30%                                                       |
|                  | runtime=300s                                                      |
|                  | test=shell8                                                       |
|                  | ucode=0xde                                                        |
+------------------+-------------------------------------------------------------------+
| testcase: change | fio-basic: boot-time.dhcp 1.5% regression                         |
| test machine     | 192 threads Intel(R) Xeon(R) CPU @ 2.20GHz with 192G memory       |
| test parameters  | bs=4k                                                             |
|                  | cpufreq_governor=performance                                      |
|                  | disk=1SSD                                                         |
|                  | fs=xfs                                                            |
|                  | ioengine=sync                                                     |
|                  | nr_task=32                                                        |
|                  | runtime=300s                                                      |
|                  | rw=randwrite                                                      |
|                  | test_size=256g                                                    |
|                  | ucode=0x4003003                                                   |
+------------------+-------------------------------------------------------------------+


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
compiler/cpufreq_governor/disk/fs/kconfig/load/md/rootfs/tbox_group/test/testcase/ucode:
  gcc-9/performance/4BRD_12G/f2fs/x86_64-rhel-8.3/100/RAID0/debian-10.4-x86_64-20200603.cgz/lkp-csl-2sp2/sync_disk_rw/aim7/0x4003003

commit: 
  62d5313500 ("locking/rwsem: Enable reader optimistic lock stealing")
  c9847a7f94 ("locking/rwsem: Wake up all waiting readers if RWSEM_WAKE_READ_OWNED")

62d5313500ac58b6 c9847a7f94679e742710574a2a7 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
      8183           -91.8%     670.67 ±  2%  aim7.jobs-per-min
     73.37         +1120.4%     895.35 ±  2%  aim7.time.elapsed_time
     73.37         +1120.4%     895.35 ±  2%  aim7.time.elapsed_time.max
  87129598            -6.7%   81275468        aim7.time.file_system_outputs
   1448254           +90.4%    2757646        aim7.time.involuntary_context_switches
      9577          +175.6%      26393 ±  6%  aim7.time.minor_page_faults
    595.56          +746.0%       5038 ±  2%  aim7.time.system_time
  24062906           +16.1%   27942139        aim7.time.voluntary_context_switches
     91.22            +2.4%      93.44        iostat.cpu.idle
      8.60           -24.0%       6.54        iostat.cpu.system
    110.50          +744.5%     933.15 ±  2%  uptime.boot
      9659          +765.7%      83622 ±  2%  uptime.idle
      0.80 ±  2%      -0.1        0.67 ±  2%  mpstat.cpu.all.irq%
      0.07 ±  5%      -0.0        0.05 ±  2%  mpstat.cpu.all.soft%
      7.93            -2.1        5.83        mpstat.cpu.all.sys%
      0.17 ±  4%      -0.2        0.02 ±  2%  mpstat.cpu.all.usr%
 1.286e+08 ± 55%   +2555.5%  3.415e+09 ±106%  cpuidle.C1.time
   3750293 ± 73%    +947.8%   39295011 ± 90%  cpuidle.C1.usage
  72870517 ± 49%  +27824.2%  2.035e+10 ±128%  cpuidle.C6.time
    115860 ± 26%  +18644.3%   21717212 ±122%  cpuidle.C6.usage
    132759 ± 12%   +1186.3%    1707686 ±144%  cpuidle.POLL.usage
     91.00            +2.2%      93.00        vmstat.cpu.id
    564823           -92.0%      45042 ±  2%  vmstat.io.bo
      7.25 ± 11%     -31.0%       5.00        vmstat.procs.r
    747964           -89.6%      77847 ±  2%  vmstat.system.cs
    200863            -4.3%     192165        vmstat.system.in
     19990 ±  2%     +23.8%      24746 ±  3%  meminfo.Active
     17246 ±  3%     +25.3%      21611 ±  3%  meminfo.Active(anon)
     59295 ±  7%    +208.0%     182605        meminfo.AnonHugePages
     59070 ±  4%     -29.0%      41922 ±  2%  meminfo.Dirty
     95815           +14.6%     109848        meminfo.Inactive(file)
     27037 ±  2%     +17.4%      31737 ±  2%  meminfo.Shmem
    527416           -92.2%      41368 ±  2%  meminfo.max_used_kB
     26522 ± 64%    +381.1%     127588 ± 30%  numa-meminfo.node0.AnonHugePages
     30316 ±  4%     -30.3%      21143 ±  2%  numa-meminfo.node0.Dirty
     48795           +12.9%      55113 ±  2%  numa-meminfo.node0.Inactive(file)
     10871           -20.9%       8604 ± 11%  numa-meminfo.node0.KernelStack
      6158 ±  4%     -51.1%       3010 ± 49%  numa-meminfo.node0.PageTables
      1865 ± 29%    +428.6%       9858 ± 22%  numa-meminfo.node0.Shmem
     29502 ±  3%     -29.2%      20881        numa-meminfo.node1.Dirty
     47049           +16.3%      54722        numa-meminfo.node1.Inactive(file)
      7877 ±  4%     -33.1%       5268 ±  2%  numa-vmstat.node0.nr_dirty
     12224           +12.7%      13780 ±  2%  numa-vmstat.node0.nr_inactive_file
     10876 ±  2%     -20.9%       8605 ± 11%  numa-vmstat.node0.nr_kernel_stack
      1542 ±  4%     -51.2%     752.25 ± 49%  numa-vmstat.node0.nr_page_table_pages
    466.00 ± 29%    +428.9%       2464 ± 22%  numa-vmstat.node0.nr_shmem
    120.25 ± 10%     -88.4%      14.00 ± 23%  numa-vmstat.node0.nr_writeback
     12225           +12.7%      13780 ±  2%  numa-vmstat.node0.nr_zone_inactive_file
      6324           -14.7%       5396 ±  2%  numa-vmstat.node0.nr_zone_write_pending
   3076324 ±  2%     +24.3%    3823329 ±  3%  numa-vmstat.node0.numa_hit
   3057907 ±  2%     +21.3%    3710333 ±  4%  numa-vmstat.node0.numa_local
   2323931            +9.4%    2541694 ±  3%  numa-vmstat.node1.nr_dirtied
      7621 ±  2%     -31.7%       5208        numa-vmstat.node1.nr_dirty
     11735           +16.6%      13686        numa-vmstat.node1.nr_inactive_file
      4524 ±  3%     -19.9%       3623 ± 17%  numa-vmstat.node1.nr_mapped
    119.50 ±  9%     -89.1%      13.00 ±  5%  numa-vmstat.node1.nr_writeback
   2310921            +9.4%    2527480 ±  3%  numa-vmstat.node1.nr_written
     11735           +16.6%      13686        numa-vmstat.node1.nr_zone_inactive_file
      6241 ±  2%     -14.4%       5341        numa-vmstat.node1.nr_zone_write_pending
   3089061 ±  2%     +14.8%    3545531 ±  5%  numa-vmstat.node1.numa_hit
   2927335 ±  3%     +18.8%    3477808 ±  5%  numa-vmstat.node1.numa_local
    161726 ± 10%     -58.1%      67723 ± 94%  numa-vmstat.node1.numa_other
      3783           +25.9%       4764 ±  2%  slabinfo.dmaengine-unmap-16.active_objs
      3783           +25.9%       4764 ±  2%  slabinfo.dmaengine-unmap-16.num_objs
      1036 ±  5%     +12.6%       1167 ±  4%  slabinfo.ext4_extent_status.active_objs
      1036 ±  5%     +12.6%       1167 ±  4%  slabinfo.ext4_extent_status.num_objs
      4130           +16.8%       4823        slabinfo.ext4_fc_dentry_update.active_objs
      4130           +16.8%       4823        slabinfo.ext4_fc_dentry_update.num_objs
      5187           +16.9%       6062        slabinfo.ext4_io_end.active_objs
      5187           +16.9%       6062        slabinfo.ext4_io_end.num_objs
     10436           +19.0%      12417        slabinfo.ext4_pending_reservation.active_objs
     10436           +19.0%      12417        slabinfo.ext4_pending_reservation.num_objs
     19809           +13.9%      22567        slabinfo.f2fs_free_nid.active_objs
     19809           +13.9%      22567        slabinfo.f2fs_free_nid.num_objs
      2297           +16.4%       2674        slabinfo.f2fs_inode_cache.active_objs
      2297           +16.4%       2674        slabinfo.f2fs_inode_cache.num_objs
      3158           +16.8%       3688        slabinfo.f2fs_xattr_entry-9:0.active_objs
      3158           +16.8%       3688        slabinfo.f2fs_xattr_entry-9:0.num_objs
     31314 ±  4%     +22.9%      38490 ±  2%  slabinfo.filp.active_objs
    983.75 ±  4%     +22.6%       1206 ±  2%  slabinfo.filp.active_slabs
     31497 ±  4%     +22.6%      38610 ±  2%  slabinfo.filp.num_objs
    983.75 ±  4%     +22.6%       1206 ±  2%  slabinfo.filp.num_slabs
      1457 ±  5%      +9.2%       1590 ±  3%  slabinfo.khugepaged_mm_slot.active_objs
      1457 ±  5%      +9.2%       1590 ±  3%  slabinfo.khugepaged_mm_slot.num_objs
    696.00 ±  3%    +109.2%       1456 ± 33%  slabinfo.kmalloc-rcl-128.active_objs
      1115 ±  5%     +18.5%       1322 ±  8%  slabinfo.task_group.active_objs
      1115 ±  5%     +18.5%       1322 ±  8%  slabinfo.task_group.num_objs
      9806           +76.0%      17259        slabinfo.vmap_area.active_objs
    152.75           +93.6%     295.75        slabinfo.vmap_area.active_slabs
      9815           +93.2%      18963        slabinfo.vmap_area.num_objs
    152.75           +93.6%     295.75        slabinfo.vmap_area.num_slabs
      4303 ±  2%     +25.5%       5402 ±  3%  proc-vmstat.nr_active_anon
    686.00           +14.2%     783.25 ± 18%  proc-vmstat.nr_active_file
     58813            -2.0%      57631        proc-vmstat.nr_anon_pages
  10873317            -6.6%   10159153        proc-vmstat.nr_dirtied
     15057 ±  3%     -30.4%      10481 ±  2%  proc-vmstat.nr_dirty
    287777            +1.7%     292579        proc-vmstat.nr_file_pages
     61236            -1.9%      60070        proc-vmstat.nr_inactive_anon
     23951           +14.7%      27464        proc-vmstat.nr_inactive_file
     18130            -8.1%      16669        proc-vmstat.nr_kernel_stack
      7648            -3.7%       7364        proc-vmstat.nr_mapped
      2014 ±  2%     -10.7%       1799 ±  2%  proc-vmstat.nr_page_table_pages
      6751           +17.5%       7933 ±  2%  proc-vmstat.nr_shmem
     32387            +4.9%      33958        proc-vmstat.nr_slab_reclaimable
     48453            +1.6%      49217        proc-vmstat.nr_slab_unreclaimable
    167.75 ±  7%     -89.4%      17.75 ± 16%  proc-vmstat.nr_writeback
  10819249            -6.5%   10112523        proc-vmstat.nr_written
      4303 ±  2%     +25.5%       5402 ±  3%  proc-vmstat.nr_zone_active_anon
    686.00           +14.2%     783.25 ± 18%  proc-vmstat.nr_zone_active_file
     61236            -1.9%      60070        proc-vmstat.nr_zone_inactive_anon
     23951           +14.7%      27464        proc-vmstat.nr_zone_inactive_file
     12619 ±  2%     -14.8%      10750 ±  2%  proc-vmstat.nr_zone_write_pending
      5462 ± 48%    +320.9%      22990 ± 22%  proc-vmstat.numa_hint_faults
      2501 ± 75%    +456.7%      13926 ± 16%  proc-vmstat.numa_hint_faults_local
  11076268            +8.6%   12026224        proc-vmstat.numa_hit
  11045187            +8.6%   11995001        proc-vmstat.numa_local
  11143370            +8.9%   12140200        proc-vmstat.pgalloc_normal
    255571 ±  2%    +903.4%    2564404 ±  2%  proc-vmstat.pgfault
   1738243           +98.5%    3450189        proc-vmstat.pgfree
  43286180            -6.5%   40452677        proc-vmstat.pgpgout
     16566          +940.1%     172308 ±  2%  proc-vmstat.pgreuse
      2604          +849.8%      24740 ±  4%  sched_debug.cfs_rq:/.exec_clock.avg
      4411 ±  2%    +569.2%      29523 ±  2%  sched_debug.cfs_rq:/.exec_clock.max
      2452          +629.8%      17895 ±  5%  sched_debug.cfs_rq:/.exec_clock.min
    276.44 ±  6%    +522.5%       1720 ±  7%  sched_debug.cfs_rq:/.exec_clock.stddev
     35.17 ± 25%     -62.6%      13.14 ±  6%  sched_debug.cfs_rq:/.load_avg.avg
    829.50 ± 24%     -70.5%     244.99 ± 10%  sched_debug.cfs_rq:/.load_avg.max
    128.41 ± 25%     -66.5%      43.06 ±  7%  sched_debug.cfs_rq:/.load_avg.stddev
     38331 ±  2%    +313.4%     158467 ±  3%  sched_debug.cfs_rq:/.min_vruntime.avg
     54684 ±  5%    +237.1%     184348 ±  2%  sched_debug.cfs_rq:/.min_vruntime.max
     31946 ±  2%    +275.9%     120088 ±  4%  sched_debug.cfs_rq:/.min_vruntime.min
      3408 ±  9%    +201.0%      10260 ±  3%  sched_debug.cfs_rq:/.min_vruntime.stddev
      0.15 ± 11%     -43.1%       0.09 ±  5%  sched_debug.cfs_rq:/.nr_running.avg
      0.36 ±  4%     -23.4%       0.28 ±  2%  sched_debug.cfs_rq:/.nr_running.stddev
      0.03 ± 48%   +2800.1%       0.83 ±  5%  sched_debug.cfs_rq:/.nr_spread_over.avg
      1.25 ± 34%    +179.2%       3.49 ± 35%  sched_debug.cfs_rq:/.nr_spread_over.max
      0.17 ± 26%    +229.1%       0.57 ± 20%  sched_debug.cfs_rq:/.nr_spread_over.stddev
    238.12 ±  2%     -66.5%      79.88 ±  2%  sched_debug.cfs_rq:/.runnable_avg.avg
    944.38 ±  7%     -25.8%     700.31 ±  3%  sched_debug.cfs_rq:/.runnable_avg.max
    215.30 ±  8%     -26.5%     158.18 ±  6%  sched_debug.cfs_rq:/.runnable_avg.stddev
    508.65 ±723%   +6944.4%      35831 ± 11%  sched_debug.cfs_rq:/.spread0.avg
     16857 ± 18%    +266.1%      61714 ±  8%  sched_debug.cfs_rq:/.spread0.max
      3407 ±  9%    +201.1%      10261 ±  3%  sched_debug.cfs_rq:/.spread0.stddev
    236.63 ±  2%     -66.4%      79.55 ±  2%  sched_debug.cfs_rq:/.util_avg.avg
    944.38 ±  7%     -25.9%     700.12 ±  3%  sched_debug.cfs_rq:/.util_avg.max
    214.62 ±  7%     -26.4%     158.07 ±  6%  sched_debug.cfs_rq:/.util_avg.stddev
     24.12 ± 16%     -71.7%       6.83 ± 11%  sched_debug.cfs_rq:/.util_est_enqueued.avg
     79.73 ± 13%     -51.1%      39.02 ± 14%  sched_debug.cfs_rq:/.util_est_enqueued.stddev
    480279           -15.3%     406677 ±  2%  sched_debug.cpu.avg_idle.avg
    195746 ±  4%     +67.0%     326826 ±  3%  sched_debug.cpu.avg_idle.stddev
     65779          +593.8%     456360 ±  4%  sched_debug.cpu.clock.avg
     65785          +593.7%     456364 ±  4%  sched_debug.cpu.clock.max
     65773          +593.8%     456355 ±  4%  sched_debug.cpu.clock.min
      3.51 ± 12%     -23.9%       2.67 ±  2%  sched_debug.cpu.clock.stddev
     65382          +593.1%     453170 ±  4%  sched_debug.cpu.clock_task.avg
     65543          +591.9%     453506 ±  4%  sched_debug.cpu.clock_task.max
     60300          +642.6%     447801 ±  4%  sched_debug.cpu.clock_task.min
    598.98 ±  3%     +12.6%     674.28 ±  4%  sched_debug.cpu.clock_task.stddev
      3474          +277.9%      13129 ±  4%  sched_debug.cpu.curr->pid.max
    859.33 ±  6%     +88.6%       1620 ±  2%  sched_debug.cpu.curr->pid.stddev
    714713 ± 11%     -26.3%     526858        sched_debug.cpu.max_idle_balance_cost.max
     24781 ± 39%     -85.9%       3496 ± 27%  sched_debug.cpu.max_idle_balance_cost.stddev
      0.12 ±  7%     -34.1%       0.08 ±  2%  sched_debug.cpu.nr_running.avg
      0.34 ±  5%     -18.9%       0.27        sched_debug.cpu.nr_running.stddev
    232828           +44.6%     336611 ±  3%  sched_debug.cpu.nr_switches.avg
    271544 ±  5%     +43.2%     388935 ±  9%  sched_debug.cpu.nr_switches.max
    214594           +40.2%     300793 ±  2%  sched_debug.cpu.nr_switches.min
      0.47 ±  2%     +94.4%       0.92        sched_debug.cpu.nr_uninterruptible.avg
     36.50 ± 27%   +1017.2%     407.77 ±  3%  sched_debug.cpu.nr_uninterruptible.max
    -18.50          +321.3%     -77.94        sched_debug.cpu.nr_uninterruptible.min
      8.88 ± 11%    +590.1%      61.27 ±  3%  sched_debug.cpu.nr_uninterruptible.stddev
    231916           +44.5%     335202 ±  3%  sched_debug.cpu.sched_count.avg
    265672 ±  4%     +45.7%     386970 ± 10%  sched_debug.cpu.sched_count.max
    214641           +36.0%     291906 ±  3%  sched_debug.cpu.sched_count.min
    101196           +42.6%     144272 ±  3%  sched_debug.cpu.sched_goidle.avg
    106057           +46.5%     155382 ±  3%  sched_debug.cpu.sched_goidle.max
     97637           +28.7%     125626 ±  3%  sched_debug.cpu.sched_goidle.min
      1506 ± 12%    +188.0%       4339 ±  6%  sched_debug.cpu.sched_goidle.stddev
    117938           +43.0%     168603 ±  3%  sched_debug.cpu.ttwu_count.avg
    153830 ±  7%     +47.5%     226894 ± 21%  sched_debug.cpu.ttwu_count.max
     96129 ±  3%     +51.9%     146054 ±  2%  sched_debug.cpu.ttwu_count.min
     14465           +74.2%      25205 ±  3%  sched_debug.cpu.ttwu_local.avg
     27168 ± 16%     +60.3%      43545 ± 32%  sched_debug.cpu.ttwu_local.max
      7181 ±  6%    +184.5%      20433 ±  3%  sched_debug.cpu.ttwu_local.min
     65775          +593.8%     456355 ±  4%  sched_debug.cpu_clk
     65278          +598.3%     455859 ±  4%  sched_debug.ktime
     66120          +590.7%     456712 ±  4%  sched_debug.sched_clk
     11.50           -71.9%       3.23 ±  3%  perf-stat.i.MPKI
 2.791e+09           -40.1%  1.671e+09        perf-stat.i.branch-instructions
      1.46            -1.1        0.40 ±  5%  perf-stat.i.branch-miss-rate%
  32652551 ±  2%     -80.3%    6434530 ±  5%  perf-stat.i.branch-misses
     26.05            -5.9       20.19 ±  2%  perf-stat.i.cache-miss-rate%
  44628231           -89.3%    4769722 ±  2%  perf-stat.i.cache-misses
 1.567e+08           -85.0%   23447881 ±  3%  perf-stat.i.cache-references
    772578           -89.9%      77784 ±  2%  perf-stat.i.context-switches
      2.36           +24.8%       2.94        perf-stat.i.cpi
  3.12e+10           -31.6%  2.135e+10        perf-stat.i.cpu-cycles
      4527 ±  2%     -79.6%     924.77        perf-stat.i.cpu-migrations
      1510 ±  4%    +221.3%       4853        perf-stat.i.cycles-between-cache-misses
      0.10 ±  3%      -0.1        0.01 ± 17%  perf-stat.i.dTLB-load-miss-rate%
   3488578 ±  3%     -94.5%     191633 ± 15%  perf-stat.i.dTLB-load-misses
 3.232e+09           -45.2%   1.77e+09        perf-stat.i.dTLB-loads
      0.01 ± 10%      -0.0        0.00 ± 21%  perf-stat.i.dTLB-store-miss-rate%
    130165 ± 11%     -87.1%      16745 ± 21%  perf-stat.i.dTLB-store-misses
 1.357e+09           -75.3%  3.355e+08        perf-stat.i.dTLB-stores
     38.11            +7.2       45.30        perf-stat.i.iTLB-load-miss-rate%
   6970161           -68.0%    2229042        perf-stat.i.iTLB-load-misses
  12096922           -77.7%    2703576        perf-stat.i.iTLB-loads
 1.278e+10           -43.3%   7.25e+09        perf-stat.i.instructions
      1952           +67.8%       3276        perf-stat.i.instructions-per-iTLB-miss
      0.45           -24.3%       0.34        perf-stat.i.ipc
      1.47 ±  3%     -91.0%       0.13 ±  2%  perf-stat.i.major-faults
      0.32           -31.6%       0.22        perf-stat.i.metric.GHz
      0.29 ±  9%    +386.4%       1.42 ±  2%  perf-stat.i.metric.K/sec
     78.95           -49.8%      39.63        perf-stat.i.metric.M/sec
      3180           -12.1%       2795        perf-stat.i.minor-faults
  19311689           -91.0%    1733499 ±  2%  perf-stat.i.node-load-misses
   1888231 ±  2%     -90.0%     189573 ±  3%  perf-stat.i.node-loads
     88.88            +1.1       90.01        perf-stat.i.node-store-miss-rate%
   6646273           -91.1%     593107 ±  2%  perf-stat.i.node-store-misses
    711946           -90.8%      65302 ±  3%  perf-stat.i.node-stores
      3181           -12.1%       2795        perf-stat.i.page-faults
     12.26           -73.6%       3.23 ±  3%  perf-stat.overall.MPKI
      1.17            -0.8        0.39 ±  5%  perf-stat.overall.branch-miss-rate%
     28.48            -8.1       20.36 ±  3%  perf-stat.overall.cache-miss-rate%
      2.44           +20.6%       2.95        perf-stat.overall.cpi
    699.29          +540.4%       4478        perf-stat.overall.cycles-between-cache-misses
      0.11 ±  3%      -0.1        0.01 ± 15%  perf-stat.overall.dTLB-load-miss-rate%
      0.01 ± 11%      -0.0        0.00 ± 21%  perf-stat.overall.dTLB-store-miss-rate%
     36.56            +8.6       45.19        perf-stat.overall.iTLB-load-miss-rate%
      1833           +77.4%       3252        perf-stat.overall.instructions-per-iTLB-miss
      0.41           -17.1%       0.34        perf-stat.overall.ipc
     91.09            -0.9       90.14        perf-stat.overall.node-load-miss-rate%
 2.752e+09           -39.4%  1.669e+09        perf-stat.ps.branch-instructions
  32218020 ±  2%     -80.0%    6429298 ±  5%  perf-stat.ps.branch-misses
  43997213           -89.2%    4764687 ±  2%  perf-stat.ps.cache-misses
 1.545e+08           -84.8%   23423214 ±  3%  perf-stat.ps.cache-references
    761608           -89.8%      77694 ±  2%  perf-stat.ps.context-switches
     94708            +1.2%      95891        perf-stat.ps.cpu-clock
 3.076e+10           -30.7%  2.133e+10        perf-stat.ps.cpu-cycles
      4463 ±  2%     -79.3%     923.71        perf-stat.ps.cpu-migrations
   3438964 ±  3%     -94.4%     191430 ± 15%  perf-stat.ps.dTLB-load-misses
 3.187e+09           -44.5%  1.768e+09        perf-stat.ps.dTLB-loads
    128359 ± 11%     -87.0%      16732 ± 21%  perf-stat.ps.dTLB-store-misses
 1.338e+09           -75.0%  3.351e+08        perf-stat.ps.dTLB-stores
   6872737           -67.6%    2226542        perf-stat.ps.iTLB-load-misses
  11926601           -77.4%    2700513        perf-stat.ps.iTLB-loads
  1.26e+10           -42.5%  7.242e+09        perf-stat.ps.instructions
      1.45 ±  3%     -90.9%       0.13 ±  2%  perf-stat.ps.major-faults
      3138           -11.0%       2792        perf-stat.ps.minor-faults
  19037965           -90.9%    1731590 ±  2%  perf-stat.ps.node-load-misses
   1861551 ±  2%     -89.8%     189374 ±  3%  perf-stat.ps.node-loads
   6552105           -91.0%     592467 ±  2%  perf-stat.ps.node-store-misses
    701901           -90.7%      65238 ±  3%  perf-stat.ps.node-stores
      3140           -11.1%       2792        perf-stat.ps.page-faults
     94708            +1.2%      95891        perf-stat.ps.task-clock
 9.429e+11          +588.7%  6.493e+12 ±  2%  perf-stat.total.instructions
     18999 ± 13%     +57.9%      30005 ±  8%  softirqs.CPU0.RCU
     13831 ±  2%    +726.1%     114266 ±  3%  softirqs.CPU0.SCHED
     16966 ± 12%     +67.2%      28360 ±  6%  softirqs.CPU1.RCU
     11764 ±  3%    +810.4%     107101 ±  3%  softirqs.CPU1.SCHED
     16148 ± 10%     +74.0%      28092 ±  6%  softirqs.CPU10.RCU
     10989          +868.2%     106397 ±  2%  softirqs.CPU10.SCHED
     16629 ± 12%     +68.1%      27956 ±  5%  softirqs.CPU11.RCU
     10731          +885.4%     105746 ±  3%  softirqs.CPU11.SCHED
     16389 ± 10%     +70.5%      27936 ±  6%  softirqs.CPU12.RCU
     10518 ±  6%    +901.4%     105330 ±  2%  softirqs.CPU12.SCHED
     16638 ± 10%     +66.4%      27680 ±  5%  softirqs.CPU13.RCU
     11381 ±  4%    +829.2%     105752 ±  3%  softirqs.CPU13.SCHED
     16492 ±  9%     +66.8%      27503 ±  5%  softirqs.CPU14.RCU
     10741 ±  3%    +880.2%     105290        softirqs.CPU14.SCHED
     16124 ± 11%     +72.3%      27779 ±  5%  softirqs.CPU15.RCU
     11062 ±  3%    +857.4%     105910 ±  3%  softirqs.CPU15.SCHED
     17351 ± 11%     +69.1%      29335 ±  4%  softirqs.CPU16.RCU
     10926 ±  3%    +867.1%     105672 ±  2%  softirqs.CPU16.SCHED
     17274 ± 12%     +69.8%      29339 ±  6%  softirqs.CPU17.RCU
     10769 ±  6%    +879.9%     105528 ±  2%  softirqs.CPU17.SCHED
     17227 ± 11%     +66.8%      28733 ±  5%  softirqs.CPU18.RCU
     10603 ±  4%    +885.1%     104448 ±  3%  softirqs.CPU18.SCHED
     17647 ± 13%     +57.9%      27873 ±  9%  softirqs.CPU19.RCU
     10793 ±  5%    +898.8%     107796 ±  2%  softirqs.CPU19.SCHED
     16485 ± 11%     +66.2%      27399 ±  6%  softirqs.CPU2.RCU
     11446          +827.2%     106124 ±  3%  softirqs.CPU2.SCHED
     17251 ± 12%     +68.7%      29107 ±  4%  softirqs.CPU20.RCU
     10851 ±  3%    +879.2%     106250 ±  2%  softirqs.CPU20.SCHED
     17240 ± 11%     +69.1%      29156 ±  5%  softirqs.CPU21.RCU
     10901 ±  4%    +866.8%     105391 ±  3%  softirqs.CPU21.SCHED
     17395 ± 10%     +68.7%      29341 ±  5%  softirqs.CPU22.RCU
     10518 ±  4%    +911.4%     106385 ±  2%  softirqs.CPU22.SCHED
     17329 ± 11%     +63.4%      28319 ±  4%  softirqs.CPU23.RCU
     11048 ±  3%    +863.7%     106466 ±  2%  softirqs.CPU23.SCHED
     16739 ± 10%     +78.2%      29836 ±  2%  softirqs.CPU24.RCU
     11455 ±  2%    +833.8%     106975 ±  2%  softirqs.CPU24.SCHED
     16813 ± 10%     +70.1%      28597 ±  5%  softirqs.CPU25.RCU
     10649 ±  5%    +879.6%     104327 ±  4%  softirqs.CPU25.SCHED
     16623 ± 10%     +72.8%      28733 ±  4%  softirqs.CPU26.RCU
     11315 ±  3%    +839.2%     106277 ±  2%  softirqs.CPU26.SCHED
     16949 ± 12%     +69.3%      28702 ±  5%  softirqs.CPU27.RCU
     11293 ±  5%    +839.8%     106131 ±  2%  softirqs.CPU27.SCHED
     16695 ± 10%     +77.6%      29654 ±  7%  softirqs.CPU28.RCU
     11089 ±  4%    +859.8%     106432 ±  3%  softirqs.CPU28.SCHED
     16909 ± 10%     +71.5%      29007 ±  4%  softirqs.CPU29.RCU
     10658 ±  8%    +900.1%     106591 ±  3%  softirqs.CPU29.SCHED
     16636 ± 11%     +68.3%      27993 ±  6%  softirqs.CPU3.RCU
     10732 ±  2%    +895.8%     106874 ±  3%  softirqs.CPU3.SCHED
     16336 ± 15%     +74.8%      28554 ±  5%  softirqs.CPU30.RCU
     11252 ±  2%    +844.4%     106258 ±  2%  softirqs.CPU30.SCHED
     16605 ± 11%     +71.3%      28450 ±  6%  softirqs.CPU31.RCU
     10247 ±  7%    +929.3%     105474 ±  2%  softirqs.CPU31.SCHED
     16370 ± 12%     +74.2%      28514 ±  6%  softirqs.CPU32.RCU
     11236          +824.5%     103880 ±  3%  softirqs.CPU32.SCHED
     16600 ± 12%     +70.8%      28345 ±  4%  softirqs.CPU33.RCU
     10916 ±  4%    +867.7%     105632 ±  2%  softirqs.CPU33.SCHED
     16306 ± 11%     +74.9%      28517 ±  4%  softirqs.CPU34.RCU
     10756          +873.2%     104675 ±  2%  softirqs.CPU34.SCHED
     16582 ± 11%     +73.7%      28807 ±  5%  softirqs.CPU35.RCU
     10909 ±  3%    +856.8%     104377        softirqs.CPU35.SCHED
     16432 ± 11%     +75.1%      28769 ±  4%  softirqs.CPU36.RCU
     11042          +853.3%     105264 ±  3%  softirqs.CPU36.SCHED
     16174 ± 10%     +74.0%      28150 ±  5%  softirqs.CPU37.RCU
     10713 ±  6%    +881.7%     105179 ±  3%  softirqs.CPU37.SCHED
     16838 ± 14%     +65.8%      27916 ±  4%  softirqs.CPU38.RCU
     10650 ±  4%    +877.6%     104119 ±  4%  softirqs.CPU38.SCHED
     16743 ± 13%     +68.4%      28200 ±  4%  softirqs.CPU39.RCU
     10472 ±  4%    +907.0%     105456 ±  3%  softirqs.CPU39.SCHED
     16425 ± 11%     +70.3%      27981 ±  5%  softirqs.CPU4.RCU
     11167 ±  4%    +855.0%     106644 ±  2%  softirqs.CPU4.SCHED
     16614 ± 11%     +75.8%      29205 ±  9%  softirqs.CPU40.RCU
     10426 ± 11%    +917.5%     106090 ±  2%  softirqs.CPU40.SCHED
     16536 ± 11%     +72.2%      28472 ±  4%  softirqs.CPU41.RCU
     10699 ±  6%    +879.9%     104842 ±  2%  softirqs.CPU41.SCHED
     16677 ± 11%     +71.0%      28516 ±  4%  softirqs.CPU42.RCU
     11008 ±  3%    +862.6%     105966 ±  2%  softirqs.CPU42.SCHED
     16425 ± 11%     +71.9%      28226 ±  4%  softirqs.CPU43.RCU
     10999 ±  7%    +855.7%     105115 ±  3%  softirqs.CPU43.SCHED
     16376 ± 10%     +72.2%      28198 ±  5%  softirqs.CPU44.RCU
     10963 ±  4%    +868.0%     106127 ±  2%  softirqs.CPU44.SCHED
     16395 ± 12%     +72.3%      28244 ±  4%  softirqs.CPU45.RCU
     11001 ±  4%    +867.9%     106479 ±  2%  softirqs.CPU45.SCHED
     16714 ± 12%     +70.5%      28497 ±  5%  softirqs.CPU46.RCU
     10764 ±  6%    +887.7%     106321 ±  2%  softirqs.CPU46.SCHED
     16736 ± 10%     +70.5%      28543 ±  5%  softirqs.CPU47.RCU
     10325 ±  6%    +922.8%     105602 ±  3%  softirqs.CPU47.SCHED
     15954 ± 12%     +71.1%      27303 ±  6%  softirqs.CPU48.RCU
     11170 ±  5%    +840.8%     105093 ±  6%  softirqs.CPU48.SCHED
     16687 ± 12%     +68.6%      28141 ±  5%  softirqs.CPU49.RCU
     10685 ±  7%    +886.4%     105398 ±  3%  softirqs.CPU49.SCHED
     16470 ± 11%     +71.0%      28160 ±  6%  softirqs.CPU5.RCU
     11290 ±  2%    +841.9%     106341 ±  3%  softirqs.CPU5.SCHED
     16729 ± 11%     +67.2%      27978 ±  4%  softirqs.CPU50.RCU
     10816 ±  3%    +884.2%     106453        softirqs.CPU50.SCHED
     16795 ± 11%     +67.7%      28164 ±  5%  softirqs.CPU51.RCU
     10392 ±  8%    +926.2%     106647 ±  3%  softirqs.CPU51.SCHED
     16750 ± 11%     +69.1%      28328 ±  4%  softirqs.CPU52.RCU
     11200          +841.9%     105493 ±  2%  softirqs.CPU52.SCHED
     16558 ± 11%     +70.2%      28177 ±  5%  softirqs.CPU53.RCU
     10992          +861.6%     105701 ±  2%  softirqs.CPU53.SCHED
     16690 ± 12%     +69.2%      28239 ±  5%  softirqs.CPU54.RCU
     10530 ±  3%    +904.1%     105736 ±  3%  softirqs.CPU54.SCHED
     16401 ± 11%     +69.2%      27745 ±  5%  softirqs.CPU55.RCU
     10735 ±  5%    +886.7%     105928 ±  5%  softirqs.CPU55.SCHED
     16864 ± 12%     +65.7%      27946 ±  5%  softirqs.CPU56.RCU
     10743 ±  5%    +881.5%     105447 ±  3%  softirqs.CPU56.SCHED
     16641 ± 12%     +66.8%      27764 ±  4%  softirqs.CPU57.RCU
     11072 ±  4%    +846.0%     104747        softirqs.CPU57.SCHED
     16750 ± 13%     +67.2%      28004 ±  5%  softirqs.CPU58.RCU
     11138          +859.2%     106841 ±  3%  softirqs.CPU58.SCHED
     16607 ± 11%     +71.2%      28427 ±  5%  softirqs.CPU59.RCU
     10470 ±  7%    +903.2%     105034 ±  4%  softirqs.CPU59.SCHED
     16705 ± 11%     +67.9%      28053 ±  4%  softirqs.CPU6.RCU
     10945 ±  3%    +873.4%     106545 ±  3%  softirqs.CPU6.SCHED
     16628 ± 12%     +68.8%      28061 ±  5%  softirqs.CPU60.RCU
     10796 ±  6%    +865.5%     104239 ±  4%  softirqs.CPU60.SCHED
     16317 ± 12%     +69.0%      27571 ±  4%  softirqs.CPU61.RCU
     10590 ±  4%    +870.2%     102747 ±  4%  softirqs.CPU61.SCHED
     16490 ± 11%     +67.2%      27573 ±  5%  softirqs.CPU62.RCU
     10796 ±  3%    +863.7%     104046 ±  2%  softirqs.CPU62.SCHED
     16779 ± 12%     +67.4%      28094 ±  4%  softirqs.CPU63.RCU
     10155 ±  6%    +934.3%     105042 ±  2%  softirqs.CPU63.SCHED
     17689 ± 11%     +69.1%      29911 ±  5%  softirqs.CPU64.RCU
     10839 ±  2%    +869.2%     105057 ±  2%  softirqs.CPU64.SCHED
     17856 ± 13%     +66.3%      29699 ±  3%  softirqs.CPU65.RCU
     11017 ±  3%    +871.5%     107027 ±  3%  softirqs.CPU65.SCHED
     17448 ± 12%     +68.0%      29312 ±  6%  softirqs.CPU66.RCU
     11019 ±  4%    +835.9%     103135 ±  4%  softirqs.CPU66.SCHED
     17590 ± 11%     +64.9%      29003 ±  4%  softirqs.CPU67.RCU
     10926 ±  3%    +852.9%     104113        softirqs.CPU67.SCHED
     17726 ± 11%     +67.4%      29668 ±  4%  softirqs.CPU68.RCU
     10924 ±  6%    +879.3%     106977 ±  2%  softirqs.CPU68.SCHED
     17706 ± 11%     +68.0%      29749 ±  2%  softirqs.CPU69.RCU
     10670 ±  3%    +883.7%     104970 ±  4%  softirqs.CPU69.SCHED
     16399 ± 10%     +65.1%      27075 ±  5%  softirqs.CPU7.RCU
     10865 ±  3%    +862.7%     104594 ±  2%  softirqs.CPU7.SCHED
     19786 ± 18%     +49.3%      29547 ±  4%  softirqs.CPU70.RCU
     11268 ±  2%    +845.4%     106529        softirqs.CPU70.SCHED
     17910 ± 14%     +61.3%      28887 ±  4%  softirqs.CPU71.RCU
     10911 ± 13%    +887.3%     107726 ±  5%  softirqs.CPU71.SCHED
     16810 ± 11%     +72.8%      29052 ±  5%  softirqs.CPU72.RCU
     10526 ±  6%    +891.9%     104417 ±  4%  softirqs.CPU72.SCHED
     17107 ±  9%     +70.1%      29094 ±  5%  softirqs.CPU73.RCU
     10228 ± 11%    +931.6%     105515 ±  4%  softirqs.CPU73.SCHED
     16867 ± 11%     +72.2%      29054 ±  5%  softirqs.CPU74.RCU
     10500 ±  4%    +899.3%     104938 ±  3%  softirqs.CPU74.SCHED
     17004 ± 12%     +71.2%      29118 ±  5%  softirqs.CPU75.RCU
     10890 ±  3%    +884.5%     107217 ±  3%  softirqs.CPU75.SCHED
     17071 ± 11%     +70.6%      29124 ±  5%  softirqs.CPU76.RCU
     10506 ± 10%    +914.6%     106603 ±  2%  softirqs.CPU76.SCHED
     16750 ± 11%     +73.8%      29105 ±  4%  softirqs.CPU77.RCU
     11767 ±  8%    +809.8%     107060 ±  2%  softirqs.CPU77.SCHED
     17084 ±  9%     +71.6%      29322 ±  4%  softirqs.CPU78.RCU
     11190 ±  2%    +847.6%     106038 ±  2%  softirqs.CPU78.SCHED
     16991 ± 10%     +70.5%      28977 ±  5%  softirqs.CPU79.RCU
     11043 ±  2%    +842.0%     104023 ±  4%  softirqs.CPU79.SCHED
     16433 ± 12%     +68.0%      27616 ±  6%  softirqs.CPU8.RCU
     11061 ±  2%    +850.1%     105092 ±  3%  softirqs.CPU8.SCHED
     16768 ±  8%     +68.7%      28281 ±  7%  softirqs.CPU80.RCU
     11218 ± 13%    +839.4%     105389 ±  4%  softirqs.CPU80.SCHED
     16210 ± 12%     +71.8%      27856 ±  4%  softirqs.CPU81.RCU
     11673 ±  8%    +795.0%     104478 ±  2%  softirqs.CPU81.SCHED
     16165 ± 12%     +72.2%      27839 ±  4%  softirqs.CPU82.RCU
     11321 ±  2%    +815.5%     103642 ±  3%  softirqs.CPU82.SCHED
     16735 ± 14%     +69.5%      28371 ±  4%  softirqs.CPU83.RCU
     11498 ±  8%    +811.1%     104758        softirqs.CPU83.SCHED
    295.25 ±149%   +7682.5%      22977 ±107%  softirqs.CPU84.NET_RX
     16622 ±  9%     +74.2%      28953 ±  5%  softirqs.CPU84.RCU
     10929          +878.5%     106938 ±  2%  softirqs.CPU84.SCHED
    465.00 ±158%   +6432.6%      30376 ± 93%  softirqs.CPU85.NET_RX
     16210 ± 11%     +75.7%      28481 ±  3%  softirqs.CPU85.RCU
     10620 ±  2%    +887.8%     104915 ±  4%  softirqs.CPU85.SCHED
     16164 ± 10%     +73.2%      27992 ±  4%  softirqs.CPU86.RCU
     10768 ±  4%    +857.1%     103066 ±  2%  softirqs.CPU86.SCHED
     16600 ± 14%     +72.0%      28558 ±  6%  softirqs.CPU87.RCU
     11171 ±  6%    +856.9%     106895 ±  3%  softirqs.CPU87.SCHED
     16697 ±  9%     +68.2%      28089 ±  5%  softirqs.CPU88.RCU
     10092 ±  6%    +931.6%     104110 ±  2%  softirqs.CPU88.SCHED
     16127 ± 12%     +74.2%      28100 ±  5%  softirqs.CPU89.RCU
     11243          +836.0%     105234        softirqs.CPU89.SCHED
     16381 ± 11%     +70.3%      27889 ±  5%  softirqs.CPU9.RCU
     11070 ±  4%    +849.4%     105096 ±  2%  softirqs.CPU9.SCHED
     16516 ± 11%     +72.4%      28475 ±  5%  softirqs.CPU90.RCU
     10508 ±  8%    +913.0%     106449 ±  2%  softirqs.CPU90.SCHED
     16181 ± 12%     +75.8%      28447 ±  4%  softirqs.CPU91.RCU
     10861 ±  4%    +864.6%     104766 ±  2%  softirqs.CPU91.SCHED
     16187 ± 10%     +73.0%      27999 ±  4%  softirqs.CPU92.RCU
     11031 ±  2%    +864.9%     106446 ±  2%  softirqs.CPU92.SCHED
     16126 ± 11%     +75.5%      28303 ±  4%  softirqs.CPU93.RCU
     11021 ±  4%    +860.4%     105857 ±  3%  softirqs.CPU93.SCHED
     16441 ±  9%     +72.7%      28400 ±  5%  softirqs.CPU94.RCU
     11138 ±  2%    +849.8%     105792 ±  2%  softirqs.CPU94.SCHED
     16412 ± 10%     +74.1%      28567 ±  4%  softirqs.CPU95.RCU
     10707 ±  4%    +891.4%     106157 ±  3%  softirqs.CPU95.SCHED
      8088 ± 51%   +1114.4%      98220 ± 24%  softirqs.NET_RX
   1610477 ± 11%     +69.8%    2734242 ±  4%  softirqs.RCU
   1049197          +867.0%   10145511 ±  2%  softirqs.SCHED
     20966 ±  7%    +634.8%     154061        softirqs.TIMER
     56.08           -19.9       36.20        perf-profile.calltrace.cycles-pp.secondary_startup_64_no_verify
     55.51           -19.8       35.76        perf-profile.calltrace.cycles-pp.start_secondary.secondary_startup_64_no_verify
     55.50           -19.7       35.76        perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     55.48           -19.7       35.75        perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     47.51           -19.6       27.95        perf-profile.calltrace.cycles-pp.intel_idle.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry
     49.60           -17.0       32.59        perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry.start_secondary
     49.77           -16.7       33.06        perf-profile.calltrace.cycles-pp.cpuidle_enter.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      6.48            -6.5        0.00        perf-profile.calltrace.cycles-pp.__submit_merged_write_cond.f2fs_fsync_node_pages.f2fs_do_sync_file.f2fs_file_write_iter.new_sync_write
     26.34            -6.2       20.15 ±  5%  perf-profile.calltrace.cycles-pp.f2fs_fsync_node_pages.f2fs_do_sync_file.f2fs_file_write_iter.new_sync_write.vfs_write
      5.05 ±  2%      -5.1        0.00        perf-profile.calltrace.cycles-pp.rwsem_down_read_slowpath.__submit_merged_write_cond.f2fs_fsync_node_pages.f2fs_do_sync_file.f2fs_file_write_iter
     15.46            -2.1       13.36 ±  8%  perf-profile.calltrace.cycles-pp.__write_node_page.f2fs_fsync_node_pages.f2fs_do_sync_file.f2fs_file_write_iter.new_sync_write
      0.41 ± 57%      +0.5        0.91 ±  7%  perf-profile.calltrace.cycles-pp.tick_nohz_get_sleep_length.menu_select.do_idle.cpu_startup_entry.start_secondary
      1.15 ±  4%      +0.6        1.78 ± 12%  perf-profile.calltrace.cycles-pp.menu_select.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      0.14 ±173%      +0.6        0.78 ±  9%  perf-profile.calltrace.cycles-pp.clockevents_program_event.hrtimer_interrupt.__sysvec_apic_timer_interrupt.asm_call_sysvec_on_stack.sysvec_apic_timer_interrupt
      0.65 ±  3%      +0.6        1.29 ±  2%  perf-profile.calltrace.cycles-pp.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.asm_call_sysvec_on_stack.sysvec_apic_timer_interrupt
      0.00            +0.7        0.72 ±  3%  perf-profile.calltrace.cycles-pp.update_process_times.tick_sched_handle.tick_sched_timer.__hrtimer_run_queues.hrtimer_interrupt
      0.00            +0.7        0.73 ±  4%  perf-profile.calltrace.cycles-pp.tick_sched_handle.tick_sched_timer.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt
      0.00            +0.8        0.83 ±  8%  perf-profile.calltrace.cycles-pp.tick_nohz_next_event.tick_nohz_get_sleep_length.menu_select.do_idle.cpu_startup_entry
      0.00            +0.9        0.95 ± 18%  perf-profile.calltrace.cycles-pp.osq_lock.rwsem_optimistic_spin.rwsem_down_read_slowpath.f2fs_get_node_info.__write_node_page
      0.00            +1.0        0.97        perf-profile.calltrace.cycles-pp.tick_sched_timer.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.asm_call_sysvec_on_stack
      1.26 ±  6%      +1.2        2.42 ±  3%  perf-profile.calltrace.cycles-pp.hrtimer_interrupt.__sysvec_apic_timer_interrupt.asm_call_sysvec_on_stack.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      1.29 ±  5%      +1.2        2.46 ±  3%  perf-profile.calltrace.cycles-pp.asm_call_sysvec_on_stack.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter
      1.29 ±  6%      +1.2        2.46 ±  3%  perf-profile.calltrace.cycles-pp.__sysvec_apic_timer_interrupt.asm_call_sysvec_on_stack.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state
      8.04            +1.6        9.69 ± 12%  perf-profile.calltrace.cycles-pp.set_node_addr.__write_node_page.f2fs_fsync_node_pages.f2fs_do_sync_file.f2fs_file_write_iter
      2.04 ±  3%      +1.7        3.78 ±  3%  perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter.do_idle
      7.79            +1.9        9.66 ± 12%  perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.set_node_addr.__write_node_page.f2fs_fsync_node_pages.f2fs_do_sync_file
      2.21 ±  3%      +2.2        4.39 ±  6%  perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry
      7.08            +2.4        9.48 ± 12%  perf-profile.calltrace.cycles-pp.rwsem_optimistic_spin.rwsem_down_write_slowpath.set_node_addr.__write_node_page.f2fs_fsync_node_pages
      0.69            +2.6        3.29 ± 10%  perf-profile.calltrace.cycles-pp.f2fs_get_node_info.__write_node_page.f2fs_fsync_node_pages.f2fs_do_sync_file.f2fs_file_write_iter
      0.00            +2.9        2.92 ± 10%  perf-profile.calltrace.cycles-pp.rwsem_optimistic_spin.rwsem_down_read_slowpath.f2fs_get_node_info.__write_node_page.f2fs_fsync_node_pages
      6.20            +3.0        9.23 ± 13%  perf-profile.calltrace.cycles-pp.osq_lock.rwsem_optimistic_spin.rwsem_down_write_slowpath.set_node_addr.__write_node_page
      0.00            +3.2        3.25 ± 10%  perf-profile.calltrace.cycles-pp.rwsem_down_read_slowpath.f2fs_get_node_info.__write_node_page.f2fs_fsync_node_pages.f2fs_do_sync_file
      0.00            +3.6        3.55 ±  6%  perf-profile.calltrace.cycles-pp.osq_lock.rwsem_optimistic_spin.rwsem_down_read_slowpath.f2fs_need_dentry_mark.f2fs_fsync_node_pages
      1.64 ±  2%      +4.0        5.67 ±  8%  perf-profile.calltrace.cycles-pp.f2fs_need_inode_block_update.f2fs_do_sync_file.f2fs_file_write_iter.new_sync_write.vfs_write
      0.00            +4.4        4.36 ± 11%  perf-profile.calltrace.cycles-pp.osq_lock.rwsem_optimistic_spin.rwsem_down_read_slowpath.f2fs_need_inode_block_update.f2fs_do_sync_file
      1.28            +4.4        5.64 ±  9%  perf-profile.calltrace.cycles-pp.rwsem_down_read_slowpath.f2fs_need_inode_block_update.f2fs_do_sync_file.f2fs_file_write_iter.new_sync_write
      0.00            +5.3        5.27 ±  9%  perf-profile.calltrace.cycles-pp.rwsem_optimistic_spin.rwsem_down_read_slowpath.f2fs_need_inode_block_update.f2fs_do_sync_file.f2fs_file_write_iter
      0.91 ±  3%      +5.4        6.34 ±  3%  perf-profile.calltrace.cycles-pp.f2fs_need_dentry_mark.f2fs_fsync_node_pages.f2fs_do_sync_file.f2fs_file_write_iter.new_sync_write
      0.65 ±  3%      +5.7        6.31 ±  3%  perf-profile.calltrace.cycles-pp.rwsem_down_read_slowpath.f2fs_need_dentry_mark.f2fs_fsync_node_pages.f2fs_do_sync_file.f2fs_file_write_iter
      0.00            +5.9        5.93 ±  3%  perf-profile.calltrace.cycles-pp.rwsem_optimistic_spin.rwsem_down_read_slowpath.f2fs_need_dentry_mark.f2fs_fsync_node_pages.f2fs_do_sync_file
      7.65 ±  2%      +6.9       14.58 ±  6%  perf-profile.calltrace.cycles-pp.file_write_and_wait_range.f2fs_do_sync_file.f2fs_file_write_iter.new_sync_write.vfs_write
      7.61 ±  2%      +7.0       14.57 ±  6%  perf-profile.calltrace.cycles-pp.__filemap_fdatawrite_range.file_write_and_wait_range.f2fs_do_sync_file.f2fs_file_write_iter.new_sync_write
      7.59 ±  2%      +7.0       14.57 ±  6%  perf-profile.calltrace.cycles-pp.do_writepages.__filemap_fdatawrite_range.file_write_and_wait_range.f2fs_do_sync_file.f2fs_file_write_iter
      7.59 ±  2%      +7.0       14.57 ±  6%  perf-profile.calltrace.cycles-pp.f2fs_write_data_pages.do_writepages.__filemap_fdatawrite_range.file_write_and_wait_range.f2fs_do_sync_file
      7.47 ±  2%      +7.1       14.55 ±  6%  perf-profile.calltrace.cycles-pp.f2fs_write_cache_pages.f2fs_write_data_pages.do_writepages.__filemap_fdatawrite_range.file_write_and_wait_range
      4.51 ±  3%      +9.8       14.27 ±  6%  perf-profile.calltrace.cycles-pp.f2fs_write_single_data_page.f2fs_write_cache_pages.f2fs_write_data_pages.do_writepages.__filemap_fdatawrite_range
      4.33 ±  3%      +9.9       14.25 ±  6%  perf-profile.calltrace.cycles-pp.f2fs_do_write_data_page.f2fs_write_single_data_page.f2fs_write_cache_pages.f2fs_write_data_pages.do_writepages
      0.00           +11.8       11.79 ±  8%  perf-profile.calltrace.cycles-pp.osq_lock.rwsem_optimistic_spin.rwsem_down_read_slowpath.f2fs_get_node_info.f2fs_do_write_data_page
      1.10 ±  3%     +12.9       13.99 ±  6%  perf-profile.calltrace.cycles-pp.f2fs_get_node_info.f2fs_do_write_data_page.f2fs_write_single_data_page.f2fs_write_cache_pages.f2fs_write_data_pages
      0.83 ±  4%     +13.1       13.96 ±  6%  perf-profile.calltrace.cycles-pp.rwsem_down_read_slowpath.f2fs_get_node_info.f2fs_do_write_data_page.f2fs_write_single_data_page.f2fs_write_cache_pages
      0.00           +13.6       13.59 ±  7%  perf-profile.calltrace.cycles-pp.rwsem_optimistic_spin.rwsem_down_read_slowpath.f2fs_get_node_info.f2fs_do_write_data_page.f2fs_write_single_data_page
      0.00           +18.4       18.43 ±  5%  perf-profile.calltrace.cycles-pp.osq_lock.rwsem_optimistic_spin.rwsem_down_read_slowpath.f2fs_is_checkpointed_node.f2fs_do_sync_file
      1.54           +19.7       21.27 ±  5%  perf-profile.calltrace.cycles-pp.f2fs_is_checkpointed_node.f2fs_do_sync_file.f2fs_file_write_iter.new_sync_write.vfs_write
      1.09 ±  2%     +20.1       21.22 ±  5%  perf-profile.calltrace.cycles-pp.rwsem_down_read_slowpath.f2fs_is_checkpointed_node.f2fs_do_sync_file.f2fs_file_write_iter.new_sync_write
     41.69           +20.7       62.36        perf-profile.calltrace.cycles-pp.write
      0.00           +20.7       20.70 ±  6%  perf-profile.calltrace.cycles-pp.rwsem_optimistic_spin.rwsem_down_read_slowpath.f2fs_is_checkpointed_node.f2fs_do_sync_file.f2fs_file_write_iter
     41.45           +20.9       62.31        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.write
     41.40           +20.9       62.30        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     41.39           +20.9       62.30        perf-profile.calltrace.cycles-pp.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     41.37           +20.9       62.30        perf-profile.calltrace.cycles-pp.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     41.26           +21.0       62.29        perf-profile.calltrace.cycles-pp.new_sync_write.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
     41.23           +21.0       62.28        perf-profile.calltrace.cycles-pp.f2fs_file_write_iter.new_sync_write.vfs_write.ksys_write.do_syscall_64
     39.59           +22.4       62.03        perf-profile.calltrace.cycles-pp.f2fs_do_sync_file.f2fs_file_write_iter.new_sync_write.vfs_write.ksys_write
     56.08           -19.9       36.20        perf-profile.children.cycles-pp.secondary_startup_64_no_verify
     56.08           -19.9       36.20        perf-profile.children.cycles-pp.cpu_startup_entry
     56.06           -19.9       36.20        perf-profile.children.cycles-pp.do_idle
     55.51           -19.8       35.76        perf-profile.children.cycles-pp.start_secondary
     47.58           -19.3       28.30        perf-profile.children.cycles-pp.intel_idle
     50.28           -16.8       33.45        perf-profile.children.cycles-pp.cpuidle_enter_state
     50.28           -16.8       33.47        perf-profile.children.cycles-pp.cpuidle_enter
      8.94            -8.4        0.54 ± 13%  perf-profile.children.cycles-pp.__submit_merged_write_cond
     26.34            -6.2       20.15 ±  5%  perf-profile.children.cycles-pp.f2fs_fsync_node_pages
      4.92 ±  4%      -4.6        0.32 ± 15%  perf-profile.children.cycles-pp.do_write_page
      4.00            -3.8        0.17 ± 20%  perf-profile.children.cycles-pp.rwsem_wake
      4.47            -3.7        0.75 ± 12%  perf-profile.children.cycles-pp.try_to_wake_up
      4.36            -3.6        0.71 ± 11%  perf-profile.children.cycles-pp.ttwu_do_activate
      4.33            -3.6        0.71 ± 11%  perf-profile.children.cycles-pp.enqueue_task_fair
      4.07            -3.4        0.67 ± 10%  perf-profile.children.cycles-pp.enqueue_entity
      3.73            -3.1        0.62 ± 13%  perf-profile.children.cycles-pp.wake_up_q
      3.10 ±  7%      -3.0        0.12 ± 18%  perf-profile.children.cycles-pp.f2fs_submit_page_write
      3.03            -2.7        0.29 ± 15%  perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
      3.19            -2.7        0.53 ± 12%  perf-profile.children.cycles-pp.__account_scheduler_latency
      2.66 ±  8%      -2.5        0.17 ± 16%  perf-profile.children.cycles-pp.f2fs_do_write_node_page
      2.85            -2.4        0.40 ±  7%  perf-profile.children.cycles-pp.flush_smp_call_function_from_idle
      2.60 ±  5%      -2.4        0.18 ± 15%  perf-profile.children.cycles-pp.f2fs_outplace_write_data
      2.81            -2.4        0.45 ± 13%  perf-profile.children.cycles-pp.submit_bio
      2.81            -2.4        0.45 ± 13%  perf-profile.children.cycles-pp.submit_bio_noacct
      2.67            -2.3        0.36 ±  6%  perf-profile.children.cycles-pp.sched_ttwu_pending
      2.23            -2.2        0.07 ± 15%  perf-profile.children.cycles-pp.pagevec_lookup_range_tag
      2.22            -2.2        0.07 ± 15%  perf-profile.children.cycles-pp.find_get_pages_range_tag
     15.46            -2.1       13.36 ±  8%  perf-profile.children.cycles-pp.__write_node_page
      2.37            -2.0        0.38 ± 12%  perf-profile.children.cycles-pp.stack_trace_save_tsk
      2.19            -2.0        0.24 ± 12%  perf-profile.children.cycles-pp._raw_spin_lock_irq
      2.17            -1.8        0.35 ± 12%  perf-profile.children.cycles-pp.arch_stack_walk
      2.17            -1.8        0.36 ±  6%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      2.45            -1.8        0.69 ±  8%  perf-profile.children.cycles-pp.__schedule
      2.03 ±  2%      -1.7        0.30 ± 11%  perf-profile.children.cycles-pp.__submit_merged_bio
      1.99            -1.7        0.28 ± 14%  perf-profile.children.cycles-pp.brd_submit_bio
      1.68            -1.5        0.18 ± 18%  perf-profile.children.cycles-pp.f2fs_allocate_data_block
      1.60 ±  2%      -1.3        0.30 ± 10%  perf-profile.children.cycles-pp.ret_from_fork
      1.59 ±  2%      -1.3        0.29 ± 12%  perf-profile.children.cycles-pp.kthread
      1.51 ±  2%      -1.3        0.25 ± 12%  perf-profile.children.cycles-pp.unwind_next_frame
      1.41 ±  2%      -1.2        0.22 ± 23%  perf-profile.children.cycles-pp.__generic_file_write_iter
      1.30            -1.1        0.19 ± 16%  perf-profile.children.cycles-pp.brd_do_bvec
      1.30 ±  2%      -1.1        0.22 ± 25%  perf-profile.children.cycles-pp.generic_perform_write
      1.55            -1.0        0.54 ±  5%  perf-profile.children.cycles-pp.schedule
      1.04 ±  2%      -0.9        0.13 ± 14%  perf-profile.children.cycles-pp.issue_flush_thread
      1.09 ±  2%      -0.8        0.24 ± 14%  perf-profile.children.cycles-pp._raw_spin_lock
      0.93 ±  4%      -0.8        0.15 ± 17%  perf-profile.children.cycles-pp.schedule_idle
      0.80 ±  9%      -0.7        0.08 ± 26%  perf-profile.children.cycles-pp.f2fs_space_for_roll_forward
      0.87            -0.7        0.19 ±  9%  perf-profile.children.cycles-pp.f2fs_issue_flush
      0.76 ± 10%      -0.7        0.08 ± 26%  perf-profile.children.cycles-pp.__percpu_counter_sum
      0.74 ±  4%      -0.6        0.09 ± 11%  perf-profile.children.cycles-pp.down_read
      0.76 ±  3%      -0.6        0.11 ±  9%  perf-profile.children.cycles-pp.dequeue_task_fair
      0.70 ±  3%      -0.6        0.10 ±  8%  perf-profile.children.cycles-pp.dequeue_entity
      0.71 ±  2%      -0.6        0.12 ± 22%  perf-profile.children.cycles-pp.f2fs_write_begin
      0.68            -0.6        0.09 ± 11%  perf-profile.children.cycles-pp.brd_insert_page
      0.60            -0.6        0.05 ± 58%  perf-profile.children.cycles-pp.complete
      0.61            -0.5        0.08 ± 13%  perf-profile.children.cycles-pp.f2fs_write_end_io
      0.57            -0.5        0.05 ± 58%  perf-profile.children.cycles-pp.swake_up_locked
      0.66 ±  2%      -0.5        0.15 ± 13%  perf-profile.children.cycles-pp.rwsem_mark_wake
      0.62 ±  4%      -0.5        0.13 ± 11%  perf-profile.children.cycles-pp.md_submit_bio
      0.63            -0.5        0.14 ±  8%  perf-profile.children.cycles-pp.update_load_avg
      0.58            -0.5        0.09 ± 11%  perf-profile.children.cycles-pp.select_task_rq_fair
      0.56 ±  5%      -0.5        0.09 ± 10%  perf-profile.children.cycles-pp.orc_find
      0.59            -0.5        0.13 ± 14%  perf-profile.children.cycles-pp.__submit_flush_wait
      0.56            -0.4        0.12 ± 15%  perf-profile.children.cycles-pp.submit_bio_wait
      0.50 ±  6%      -0.4        0.08 ± 15%  perf-profile.children.cycles-pp.__orc_find
      0.44 ±  3%      -0.4        0.03 ±100%  perf-profile.children.cycles-pp.__set_page_dirty_nobuffers
      0.54 ±  4%      -0.4        0.14 ± 11%  perf-profile.children.cycles-pp.worker_thread
      0.45 ±  3%      -0.4        0.07 ± 17%  perf-profile.children.cycles-pp.__get_node_page
      0.47 ±  3%      -0.4        0.10 ± 12%  perf-profile.children.cycles-pp.md_handle_request
      0.43 ±  2%      -0.4        0.07 ± 21%  perf-profile.children.cycles-pp.update_curr
      0.43 ±  3%      -0.4        0.07 ± 12%  perf-profile.children.cycles-pp.ttwu_queue_wakelist
      0.38            -0.3        0.03 ±100%  perf-profile.children.cycles-pp.__test_set_page_writeback
      0.38 ±  4%      -0.3        0.04 ± 59%  perf-profile.children.cycles-pp.unwind_get_return_address
      0.42 ±  3%      -0.3        0.08 ± 13%  perf-profile.children.cycles-pp.raid0_make_request
      0.39            -0.3        0.06 ± 34%  perf-profile.children.cycles-pp.f2fs_write_end
      0.36 ±  4%      -0.3        0.04 ± 58%  perf-profile.children.cycles-pp.f2fs_is_valid_blkaddr
      0.42 ±  5%      -0.3        0.10 ± 19%  perf-profile.children.cycles-pp.process_one_work
      0.35            -0.3        0.03 ±102%  perf-profile.children.cycles-pp.f2fs_submit_merged_ipu_write
      0.34 ±  6%      -0.3        0.03 ±100%  perf-profile.children.cycles-pp.pagecache_get_page
      0.34 ±  5%      -0.3        0.04 ± 58%  perf-profile.children.cycles-pp.__kernel_text_address
      0.32 ±  2%      -0.3        0.03 ±100%  perf-profile.children.cycles-pp.update_cfs_rq_h_load
      0.34 ±  3%      -0.3        0.04 ± 58%  perf-profile.children.cycles-pp.__lookup_nat_cache
      0.32 ±  2%      -0.3        0.03 ±100%  perf-profile.children.cycles-pp.__list_del_entry_valid
      0.31 ±  6%      -0.3        0.03 ±100%  perf-profile.children.cycles-pp.kernel_text_address
      0.30 ±  5%      -0.3        0.03 ±100%  perf-profile.children.cycles-pp.tick_nohz_idle_exit
      0.31 ±  5%      -0.3        0.04 ± 58%  perf-profile.children.cycles-pp.set_next_entity
      0.31 ±  2%      -0.3        0.06 ± 14%  perf-profile.children.cycles-pp.wait_for_completion
      0.30 ±  2%      -0.3        0.04 ± 59%  perf-profile.children.cycles-pp.__radix_tree_lookup
      0.32 ±  2%      -0.2        0.07 ± 15%  perf-profile.children.cycles-pp.md_flush_request
      0.29 ±  2%      -0.2        0.05 ± 62%  perf-profile.children.cycles-pp.__alloc_pages_nodemask
      0.31 ±  4%      -0.2        0.07 ± 21%  perf-profile.children.cycles-pp.submit_flushes
      0.27 ±  4%      -0.2        0.03 ±102%  perf-profile.children.cycles-pp.get_page_from_freelist
      0.30 ±  2%      -0.2        0.07 ± 12%  perf-profile.children.cycles-pp.queue_work_on
      0.28 ±  2%      -0.2        0.06 ± 14%  perf-profile.children.cycles-pp.schedule_timeout
      0.26 ±  5%      -0.2        0.04 ± 58%  perf-profile.children.cycles-pp.update_ts_time_stats
      0.26 ±  3%      -0.2        0.04 ± 58%  perf-profile.children.cycles-pp.nr_iowait_cpu
      0.58 ±  4%      -0.2        0.38 ±  7%  perf-profile.children.cycles-pp.pick_next_task_fair
      0.27 ±  5%      -0.2        0.07 ± 13%  perf-profile.children.cycles-pp.__queue_work
      0.24 ±  4%      -0.2        0.07 ± 11%  perf-profile.children.cycles-pp.__update_load_avg_cfs_rq
      0.30 ±  3%      -0.2        0.14 ±  6%  perf-profile.children.cycles-pp.update_rq_clock
      0.18 ±  2%      -0.2        0.03 ±100%  perf-profile.children.cycles-pp.__wake_up_common_lock
      0.24 ±  6%      -0.1        0.11 ± 11%  perf-profile.children.cycles-pp._raw_spin_unlock_irqrestore
      1.89            -0.1        1.77 ±  3%  perf-profile.children.cycles-pp.rwsem_spin_on_owner
      0.09            -0.1        0.04 ± 57%  perf-profile.children.cycles-pp._find_next_bit
      0.21 ±  4%      -0.0        0.17 ±  5%  perf-profile.children.cycles-pp.sched_clock
      0.20 ±  6%      -0.0        0.16 ±  6%  perf-profile.children.cycles-pp.native_sched_clock
      0.10 ±  7%      -0.0        0.07        perf-profile.children.cycles-pp.hrtimer_next_event_without
      0.20 ±  7%      -0.0        0.17 ±  4%  perf-profile.children.cycles-pp.sched_clock_cpu
      0.11 ±  4%      -0.0        0.09 ± 15%  perf-profile.children.cycles-pp.get_next_timer_interrupt
      0.06 ± 11%      +0.0        0.08 ±  6%  perf-profile.children.cycles-pp.rcu_sched_clock_irq
      0.07 ± 13%      +0.0        0.11 ± 13%  perf-profile.children.cycles-pp._raw_spin_trylock
      0.00            +0.1        0.06 ±  6%  perf-profile.children.cycles-pp.arch_scale_freq_tick
      0.00            +0.1        0.07 ± 17%  perf-profile.children.cycles-pp.idle_cpu
      0.06 ±  7%      +0.1        0.12 ±  6%  perf-profile.children.cycles-pp.run_rebalance_domains
      0.04 ± 57%      +0.1        0.12 ± 10%  perf-profile.children.cycles-pp.update_blocked_averages
      0.09 ± 13%      +0.1        0.17 ±  6%  perf-profile.children.cycles-pp.lapic_next_deadline
      0.04 ± 58%      +0.1        0.12 ± 21%  perf-profile.children.cycles-pp.tsc_verify_tsc_adjust
      0.04 ± 58%      +0.1        0.12 ± 18%  perf-profile.children.cycles-pp.arch_cpu_idle_enter
      0.05 ±  8%      +0.1        0.14 ±  5%  perf-profile.children.cycles-pp.irqtime_account_irq
      0.00            +0.1        0.09 ±  4%  perf-profile.children.cycles-pp.__intel_pmu_enable_all
      0.09 ±  4%      +0.1        0.20 ±  7%  perf-profile.children.cycles-pp.calc_global_load_tick
      0.09 ±  4%      +0.1        0.21 ±  6%  perf-profile.children.cycles-pp.perf_mux_hrtimer_handler
      0.09 ±  4%      +0.1        0.22 ±  4%  perf-profile.children.cycles-pp.native_irq_return_iret
      0.35 ±  7%      +0.1        0.48 ±  6%  perf-profile.children.cycles-pp.__softirqentry_text_start
      0.36 ±  6%      +0.1        0.49 ±  6%  perf-profile.children.cycles-pp.do_softirq_own_stack
      0.14 ±  3%      +0.1        0.27 ±  9%  perf-profile.children.cycles-pp.rebalance_domains
      0.10 ± 19%      +0.1        0.24 ±  8%  perf-profile.children.cycles-pp.ktime_get_update_offsets_now
      0.16 ±  9%      +0.2        0.31 ±  8%  perf-profile.children.cycles-pp.tick_nohz_irq_exit
      0.16 ± 13%      +0.2        0.33 ±  9%  perf-profile.children.cycles-pp.tick_irq_enter
      0.42 ±  7%      +0.2        0.58 ±  7%  perf-profile.children.cycles-pp.irq_exit_rcu
      0.20 ±  8%      +0.2        0.42 ±  8%  perf-profile.children.cycles-pp.irq_enter_rcu
      0.07 ± 11%      +0.2        0.30 ±  9%  perf-profile.children.cycles-pp.newidle_balance
      0.23 ±  2%      +0.2        0.45 ±  5%  perf-profile.children.cycles-pp.scheduler_tick
      0.08 ± 10%      +0.2        0.33 ±  6%  perf-profile.children.cycles-pp.update_sd_lb_stats
      0.09 ± 12%      +0.2        0.34 ±  6%  perf-profile.children.cycles-pp.find_busiest_group
      0.11 ±  7%      +0.3        0.39 ±  5%  perf-profile.children.cycles-pp.load_balance
      0.16 ± 18%      +0.3        0.48 ±  5%  perf-profile.children.cycles-pp.timekeeping_max_deferment
      0.50 ± 13%      +0.3        0.84 ±  8%  perf-profile.children.cycles-pp.clockevents_program_event
      0.44 ±  5%      +0.4        0.84 ±  4%  perf-profile.children.cycles-pp.tick_sched_handle
      0.52 ±  8%      +0.4        0.92 ±  7%  perf-profile.children.cycles-pp.tick_nohz_get_sleep_length
      0.43 ±  6%      +0.4        0.83 ±  4%  perf-profile.children.cycles-pp.update_process_times
      0.39 ± 11%      +0.4        0.83 ±  8%  perf-profile.children.cycles-pp.tick_nohz_next_event
      0.88 ±  9%      +0.5        1.40 ±  6%  perf-profile.children.cycles-pp.ktime_get
      0.57 ±  4%      +0.5        1.09 ±  2%  perf-profile.children.cycles-pp.tick_sched_timer
      1.16 ±  4%      +0.6        1.81 ± 12%  perf-profile.children.cycles-pp.menu_select
      0.77 ±  4%      +0.7        1.46 ±  2%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      0.00            +0.8        0.78 ± 75%  perf-profile.children.cycles-pp.f2fs_remove_inode_page
      0.00            +0.8        0.78 ± 75%  perf-profile.children.cycles-pp.truncate_node
      1.46 ±  6%      +1.2        2.67 ±  3%  perf-profile.children.cycles-pp.hrtimer_interrupt
      1.48 ±  5%      +1.2        2.70 ±  3%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      1.96 ±  4%      +1.3        3.25 ±  2%  perf-profile.children.cycles-pp.asm_call_sysvec_on_stack
      8.06            +1.7        9.75 ± 12%  perf-profile.children.cycles-pp.set_node_addr
      2.29 ±  3%      +1.8        4.06 ±  3%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      2.50 ±  3%      +2.1        4.58 ±  3%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
      1.64 ±  2%      +4.0        5.67 ±  8%  perf-profile.children.cycles-pp.f2fs_need_inode_block_update
      0.91 ±  3%      +5.4        6.34 ±  3%  perf-profile.children.cycles-pp.f2fs_need_dentry_mark
      7.65 ±  2%      +6.9       14.58 ±  6%  perf-profile.children.cycles-pp.file_write_and_wait_range
      7.61 ±  2%      +7.0       14.57 ±  6%  perf-profile.children.cycles-pp.__filemap_fdatawrite_range
      7.59 ±  2%      +7.0       14.57 ±  6%  perf-profile.children.cycles-pp.do_writepages
      7.59 ±  2%      +7.0       14.57 ±  6%  perf-profile.children.cycles-pp.f2fs_write_data_pages
      7.47 ±  2%      +7.1       14.55 ±  6%  perf-profile.children.cycles-pp.f2fs_write_cache_pages
      4.52 ±  3%      +9.8       14.27 ±  6%  perf-profile.children.cycles-pp.f2fs_write_single_data_page
      4.33 ±  3%      +9.9       14.25 ±  6%  perf-profile.children.cycles-pp.f2fs_do_write_data_page
      1.80           +16.2       18.03 ±  7%  perf-profile.children.cycles-pp.f2fs_get_node_info
      1.54           +19.7       21.27 ±  5%  perf-profile.children.cycles-pp.f2fs_is_checkpointed_node
     41.70           +20.7       62.36        perf-profile.children.cycles-pp.write
     41.57           +20.9       62.48        perf-profile.children.cycles-pp.do_syscall_64
     41.39           +20.9       62.30        perf-profile.children.cycles-pp.ksys_write
     41.37           +20.9       62.30        perf-profile.children.cycles-pp.vfs_write
     41.26           +21.0       62.29        perf-profile.children.cycles-pp.new_sync_write
     41.23           +21.0       62.28        perf-profile.children.cycles-pp.f2fs_file_write_iter
     41.77           +21.6       63.35        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     39.59           +22.4       62.03        perf-profile.children.cycles-pp.f2fs_do_sync_file
     13.89           +35.4       49.30 ±  2%  perf-profile.children.cycles-pp.osq_lock
     10.27           +41.0       51.25        perf-profile.children.cycles-pp.rwsem_down_read_slowpath
     16.38           +43.4       59.78        perf-profile.children.cycles-pp.rwsem_optimistic_spin
     47.58           -19.3       28.30        perf-profile.self.cycles-pp.intel_idle
      3.02            -2.7        0.29 ± 15%  perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
      1.86            -1.8        0.04 ± 58%  perf-profile.self.cycles-pp.find_get_pages_range_tag
      1.14            -0.9        0.26 ±  9%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      1.83            -0.8        0.99 ±  6%  perf-profile.self.cycles-pp.rwsem_spin_on_owner
      1.04 ±  2%      -0.8        0.22 ±  5%  perf-profile.self.cycles-pp._raw_spin_lock
      0.69 ±  4%      -0.6        0.08 ± 13%  perf-profile.self.cycles-pp.down_read
      0.71            -0.6        0.12 ± 13%  perf-profile.self.cycles-pp.unwind_next_frame
      0.59 ±  3%      -0.5        0.10 ± 17%  perf-profile.self.cycles-pp.rwsem_down_read_slowpath
      0.50 ±  6%      -0.4        0.08 ± 15%  perf-profile.self.cycles-pp.__orc_find
      0.42 ±  6%      -0.4        0.06 ± 13%  perf-profile.self.cycles-pp.brd_do_bvec
      0.42 ±  3%      -0.4        0.06 ±  6%  perf-profile.self.cycles-pp.try_to_wake_up
      0.36 ±  4%      -0.3        0.03 ±100%  perf-profile.self.cycles-pp.f2fs_is_valid_blkaddr
      0.40 ±  3%      -0.3        0.07 ± 10%  perf-profile.self.cycles-pp.__schedule
      0.40 ±  7%      -0.3        0.08 ± 10%  perf-profile.self.cycles-pp.__account_scheduler_latency
      0.35 ± 15%      -0.3        0.05 ± 62%  perf-profile.self.cycles-pp.__percpu_counter_sum
      0.32 ±  2%      -0.3        0.03 ±100%  perf-profile.self.cycles-pp.update_cfs_rq_h_load
      0.32 ±  2%      -0.3        0.03 ±100%  perf-profile.self.cycles-pp.__list_del_entry_valid
      0.29 ±  2%      -0.3        0.04 ± 60%  perf-profile.self.cycles-pp.__radix_tree_lookup
      0.26 ±  3%      -0.2        0.04 ± 58%  perf-profile.self.cycles-pp.nr_iowait_cpu
      0.23 ±  3%      -0.2        0.04 ± 58%  perf-profile.self.cycles-pp.update_load_avg
      0.23 ±  6%      -0.2        0.04 ± 57%  perf-profile.self.cycles-pp._raw_spin_lock_irq
      0.24 ±  3%      -0.2        0.07 ± 11%  perf-profile.self.cycles-pp.__update_load_avg_cfs_rq
      0.23 ±  2%      -0.1        0.10 ± 14%  perf-profile.self.cycles-pp.do_idle
      0.18 ±  5%      -0.1        0.07 ±  7%  perf-profile.self.cycles-pp.update_rq_clock
      0.20 ±  2%      -0.1        0.09 ± 15%  perf-profile.self.cycles-pp.rwsem_mark_wake
      0.20            -0.1        0.10 ± 10%  perf-profile.self.cycles-pp._raw_spin_unlock_irqrestore
      0.08 ±  5%      -0.1        0.03 ±100%  perf-profile.self.cycles-pp._find_next_bit
      0.19 ±  5%      -0.0        0.15 ±  7%  perf-profile.self.cycles-pp.native_sched_clock
      0.06 ± 17%      +0.0        0.11 ± 13%  perf-profile.self.cycles-pp._raw_spin_trylock
      0.03 ±100%      +0.1        0.09 ±  4%  perf-profile.self.cycles-pp.tick_sched_timer
      0.00            +0.1        0.06 ± 17%  perf-profile.self.cycles-pp.update_blocked_averages
      0.00            +0.1        0.06 ±  6%  perf-profile.self.cycles-pp.arch_scale_freq_tick
      0.00            +0.1        0.07 ± 17%  perf-profile.self.cycles-pp.idle_cpu
      0.00            +0.1        0.08 ±  6%  perf-profile.self.cycles-pp.irqtime_account_irq
      0.09 ± 13%      +0.1        0.17 ±  6%  perf-profile.self.cycles-pp.lapic_next_deadline
      0.00            +0.1        0.09 ±  4%  perf-profile.self.cycles-pp.__intel_pmu_enable_all
      0.01 ±173%      +0.1        0.11 ± 19%  perf-profile.self.cycles-pp.tsc_verify_tsc_adjust
      0.09 ±  4%      +0.1        0.20 ±  7%  perf-profile.self.cycles-pp.calc_global_load_tick
      0.08 ± 26%      +0.1        0.21 ± 13%  perf-profile.self.cycles-pp.update_process_times
      0.09 ± 17%      +0.1        0.21 ±  6%  perf-profile.self.cycles-pp.ktime_get_update_offsets_now
      0.09 ±  4%      +0.1        0.22 ±  4%  perf-profile.self.cycles-pp.native_irq_return_iret
      0.09 ± 20%      +0.2        0.24 ± 20%  perf-profile.self.cycles-pp.tick_nohz_next_event
      0.06 ± 13%      +0.2        0.24 ±  9%  perf-profile.self.cycles-pp.update_sd_lb_stats
      0.16 ± 18%      +0.3        0.48 ±  5%  perf-profile.self.cycles-pp.timekeeping_max_deferment
      0.76 ± 10%      +0.5        1.26 ±  7%  perf-profile.self.cycles-pp.ktime_get
      0.26 ±  4%      +0.6        0.84 ± 22%  perf-profile.self.cycles-pp.cpuidle_enter_state
      0.67 ±  2%      +8.8        9.43 ±  2%  perf-profile.self.cycles-pp.rwsem_optimistic_spin
     13.81           +35.3       49.11        perf-profile.self.cycles-pp.osq_lock
    250.00 ± 98%  +12777.4%      32193 ±167%  interrupts.75:PCI-MSI.70260737-edge.eth3-TxRx-0
    774.25 ±162%   +1610.6%      13244 ±136%  interrupts.77:PCI-MSI.70260739-edge.eth3-TxRx-2
    552.00 ±158%   +8041.8%      44942 ±105%  interrupts.79:PCI-MSI.70260741-edge.eth3-TxRx-4
    844.50 ±163%   +6985.2%      59834 ± 92%  interrupts.80:PCI-MSI.70260742-edge.eth3-TxRx-5
     96.50 ± 90%   +4080.3%       4034 ±150%  interrupts.81:PCI-MSI.70260743-edge.eth3-TxRx-6
    150.50         +1092.7%       1795 ±  2%  interrupts.9:IO-APIC.9-fasteoi.acpi
    609956            -6.3%     571265        interrupts.CAL:Function_call_interrupts
      6904 ±  4%     -17.1%       5724 ±  6%  interrupts.CPU0.CAL:Function_call_interrupts
    149876         +1092.6%    1787470 ±  3%  interrupts.CPU0.LOC:Local_timer_interrupts
      1581 ± 25%     -63.5%     577.25 ± 23%  interrupts.CPU0.NMI:Non-maskable_interrupts
      1581 ± 25%     -63.5%     577.25 ± 23%  interrupts.CPU0.PMI:Performance_monitoring_interrupts
    537.75 ±  3%     +78.5%     959.75 ±  7%  interrupts.CPU0.RES:Rescheduling_interrupts
    150.50         +1092.7%       1795 ±  2%  interrupts.CPU1.9:IO-APIC.9-fasteoi.acpi
      7196 ±  4%     -22.6%       5570 ±  4%  interrupts.CPU1.CAL:Function_call_interrupts
    150226         +1090.1%    1787842 ±  3%  interrupts.CPU1.LOC:Local_timer_interrupts
      1527 ± 25%     -64.8%     538.00 ± 30%  interrupts.CPU1.NMI:Non-maskable_interrupts
      1527 ± 25%     -64.8%     538.00 ± 30%  interrupts.CPU1.PMI:Performance_monitoring_interrupts
    529.75 ±  3%     +88.7%     999.75 ±  2%  interrupts.CPU1.RES:Rescheduling_interrupts
      6843           -11.7%       6039 ±  4%  interrupts.CPU10.CAL:Function_call_interrupts
    150193         +1090.3%    1787827 ±  3%  interrupts.CPU10.LOC:Local_timer_interrupts
      1773           -50.0%     886.50 ± 42%  interrupts.CPU10.NMI:Non-maskable_interrupts
      1773           -50.0%     886.50 ± 42%  interrupts.CPU10.PMI:Performance_monitoring_interrupts
    517.75 ±  6%     +87.9%     972.75 ± 11%  interrupts.CPU10.RES:Rescheduling_interrupts
    150160         +1090.6%    1787832 ±  3%  interrupts.CPU11.LOC:Local_timer_interrupts
      1774           -59.7%     716.00 ± 27%  interrupts.CPU11.NMI:Non-maskable_interrupts
      1774           -59.7%     716.00 ± 27%  interrupts.CPU11.PMI:Performance_monitoring_interrupts
    515.00 ±  4%     +84.8%     951.50 ±  5%  interrupts.CPU11.RES:Rescheduling_interrupts
      6965           -17.1%       5773 ±  3%  interrupts.CPU12.CAL:Function_call_interrupts
    150211         +1090.1%    1787741 ±  3%  interrupts.CPU12.LOC:Local_timer_interrupts
      1769           -53.4%     824.75 ± 26%  interrupts.CPU12.NMI:Non-maskable_interrupts
      1769           -53.4%     824.75 ± 26%  interrupts.CPU12.PMI:Performance_monitoring_interrupts
    509.00 ±  4%     +99.6%       1015 ±  4%  interrupts.CPU12.RES:Rescheduling_interrupts
      6966           -15.8%       5866 ±  5%  interrupts.CPU13.CAL:Function_call_interrupts
    149890         +1092.7%    1787701 ±  3%  interrupts.CPU13.LOC:Local_timer_interrupts
      1755           -46.8%     933.25 ± 28%  interrupts.CPU13.NMI:Non-maskable_interrupts
      1755           -46.8%     933.25 ± 28%  interrupts.CPU13.PMI:Performance_monitoring_interrupts
    507.75 ±  5%     +99.3%       1011 ±  8%  interrupts.CPU13.RES:Rescheduling_interrupts
      6884 ±  2%     -18.1%       5639 ±  4%  interrupts.CPU14.CAL:Function_call_interrupts
    150173         +1090.5%    1787862 ±  3%  interrupts.CPU14.LOC:Local_timer_interrupts
    510.25 ±  6%     +83.0%     934.00 ±  5%  interrupts.CPU14.RES:Rescheduling_interrupts
      7174 ±  4%     -17.0%       5957 ±  8%  interrupts.CPU15.CAL:Function_call_interrupts
    150282         +1089.6%    1787694 ±  3%  interrupts.CPU15.LOC:Local_timer_interrupts
      1751           -48.6%     899.50 ± 24%  interrupts.CPU15.NMI:Non-maskable_interrupts
      1751           -48.6%     899.50 ± 24%  interrupts.CPU15.PMI:Performance_monitoring_interrupts
    500.75 ±  4%    +100.0%       1001 ±  5%  interrupts.CPU15.RES:Rescheduling_interrupts
      7088 ±  2%     -15.8%       5970 ±  6%  interrupts.CPU16.CAL:Function_call_interrupts
    150253         +1089.8%    1787673 ±  3%  interrupts.CPU16.LOC:Local_timer_interrupts
      1531 ± 24%     -55.3%     684.00 ± 40%  interrupts.CPU16.NMI:Non-maskable_interrupts
      1531 ± 24%     -55.3%     684.00 ± 40%  interrupts.CPU16.PMI:Performance_monitoring_interrupts
    520.75 ±  3%     +72.5%     898.50 ±  4%  interrupts.CPU16.RES:Rescheduling_interrupts
      6974 ±  2%     -15.5%       5896 ±  3%  interrupts.CPU17.CAL:Function_call_interrupts
    150233         +1090.0%    1787724 ±  3%  interrupts.CPU17.LOC:Local_timer_interrupts
      1782           -60.1%     710.25 ± 31%  interrupts.CPU17.NMI:Non-maskable_interrupts
      1782           -60.1%     710.25 ± 31%  interrupts.CPU17.PMI:Performance_monitoring_interrupts
    523.75           +66.5%     872.25 ±  2%  interrupts.CPU17.RES:Rescheduling_interrupts
      6812           -14.4%       5828 ±  4%  interrupts.CPU18.CAL:Function_call_interrupts
    150333         +1089.2%    1787828 ±  3%  interrupts.CPU18.LOC:Local_timer_interrupts
      1549 ± 23%     -47.7%     811.00 ± 20%  interrupts.CPU18.NMI:Non-maskable_interrupts
      1549 ± 23%     -47.7%     811.00 ± 20%  interrupts.CPU18.PMI:Performance_monitoring_interrupts
    518.75 ±  5%     +93.6%       1004 ±  5%  interrupts.CPU18.RES:Rescheduling_interrupts
      6896 ±  2%     -13.8%       5941        interrupts.CPU19.CAL:Function_call_interrupts
    150247         +1090.0%    1787866 ±  3%  interrupts.CPU19.LOC:Local_timer_interrupts
      1534 ± 24%     -43.1%     874.00 ± 20%  interrupts.CPU19.NMI:Non-maskable_interrupts
      1534 ± 24%     -43.1%     874.00 ± 20%  interrupts.CPU19.PMI:Performance_monitoring_interrupts
    515.25 ±  6%    +103.8%       1050 ±  4%  interrupts.CPU19.RES:Rescheduling_interrupts
    150079         +1091.0%    1787408 ±  2%  interrupts.CPU2.LOC:Local_timer_interrupts
      1516 ± 23%     -58.1%     635.25 ± 22%  interrupts.CPU2.NMI:Non-maskable_interrupts
      1516 ± 23%     -58.1%     635.25 ± 22%  interrupts.CPU2.PMI:Performance_monitoring_interrupts
    513.00 ±  4%     +88.9%     969.00 ±  7%  interrupts.CPU2.RES:Rescheduling_interrupts
      6783           -15.1%       5757 ±  5%  interrupts.CPU20.CAL:Function_call_interrupts
    150187         +1090.4%    1787794 ±  3%  interrupts.CPU20.LOC:Local_timer_interrupts
    525.75 ±  6%     +75.5%     922.50 ±  5%  interrupts.CPU20.RES:Rescheduling_interrupts
      6991 ±  3%     -17.8%       5748 ±  4%  interrupts.CPU21.CAL:Function_call_interrupts
    150327         +1089.3%    1787825 ±  3%  interrupts.CPU21.LOC:Local_timer_interrupts
      1766           -68.9%     549.50 ± 34%  interrupts.CPU21.NMI:Non-maskable_interrupts
      1766           -68.9%     549.50 ± 34%  interrupts.CPU21.PMI:Performance_monitoring_interrupts
    540.50 ±  8%     +73.1%     935.50 ±  5%  interrupts.CPU21.RES:Rescheduling_interrupts
      6879 ±  3%     -14.4%       5891 ±  3%  interrupts.CPU22.CAL:Function_call_interrupts
    150278         +1089.6%    1787778 ±  3%  interrupts.CPU22.LOC:Local_timer_interrupts
      1774           -51.4%     861.50 ± 25%  interrupts.CPU22.NMI:Non-maskable_interrupts
      1774           -51.4%     861.50 ± 25%  interrupts.CPU22.PMI:Performance_monitoring_interrupts
    553.25 ± 12%     +59.7%     883.50 ±  7%  interrupts.CPU22.RES:Rescheduling_interrupts
      6914 ±  2%     -12.3%       6062 ±  6%  interrupts.CPU23.CAL:Function_call_interrupts
    150270         +1089.7%    1787808 ±  3%  interrupts.CPU23.LOC:Local_timer_interrupts
      1546 ± 25%     -53.2%     723.00 ± 34%  interrupts.CPU23.NMI:Non-maskable_interrupts
      1546 ± 25%     -53.2%     723.00 ± 34%  interrupts.CPU23.PMI:Performance_monitoring_interrupts
    516.75 ±  6%     +79.2%     926.25 ±  6%  interrupts.CPU23.RES:Rescheduling_interrupts
      5887 ±  4%     +15.2%       6783 ±  7%  interrupts.CPU24.CAL:Function_call_interrupts
    149885         +1093.6%    1789046 ±  2%  interrupts.CPU24.LOC:Local_timer_interrupts
      1799 ±  2%     -61.7%     689.25 ±  9%  interrupts.CPU24.NMI:Non-maskable_interrupts
      1799 ±  2%     -61.7%     689.25 ±  9%  interrupts.CPU24.PMI:Performance_monitoring_interrupts
    569.50 ± 10%     +88.9%       1076 ±  5%  interrupts.CPU24.RES:Rescheduling_interrupts
    149890         +1093.6%    1789026 ±  2%  interrupts.CPU25.LOC:Local_timer_interrupts
      1768           -47.1%     934.75 ± 12%  interrupts.CPU25.NMI:Non-maskable_interrupts
      1768           -47.1%     934.75 ± 12%  interrupts.CPU25.PMI:Performance_monitoring_interrupts
    540.75           +92.3%       1039 ±  8%  interrupts.CPU25.RES:Rescheduling_interrupts
    150160         +1091.4%    1789061 ±  2%  interrupts.CPU26.LOC:Local_timer_interrupts
    537.25 ±  2%     +88.1%       1010 ±  6%  interrupts.CPU26.RES:Rescheduling_interrupts
    150017         +1092.6%    1789042 ±  2%  interrupts.CPU27.LOC:Local_timer_interrupts
      1759           -58.1%     737.25 ±  6%  interrupts.CPU27.NMI:Non-maskable_interrupts
      1759           -58.1%     737.25 ±  6%  interrupts.CPU27.PMI:Performance_monitoring_interrupts
    528.75 ±  5%     +75.1%     925.75 ±  3%  interrupts.CPU27.RES:Rescheduling_interrupts
    149980         +1092.8%    1789024 ±  2%  interrupts.CPU28.LOC:Local_timer_interrupts
    503.25           +88.9%     950.50 ±  2%  interrupts.CPU28.RES:Rescheduling_interrupts
    150157         +1091.3%    1788798 ±  2%  interrupts.CPU29.LOC:Local_timer_interrupts
      1782 ±  2%     -47.6%     934.00 ±  8%  interrupts.CPU29.NMI:Non-maskable_interrupts
      1782 ±  2%     -47.6%     934.00 ±  8%  interrupts.CPU29.PMI:Performance_monitoring_interrupts
    525.00 ±  6%     +77.4%     931.50 ±  6%  interrupts.CPU29.RES:Rescheduling_interrupts
      7140 ±  4%     -18.8%       5798 ±  4%  interrupts.CPU3.CAL:Function_call_interrupts
    149871         +1092.9%    1787743 ±  3%  interrupts.CPU3.LOC:Local_timer_interrupts
      1755           -50.9%     861.75 ± 17%  interrupts.CPU3.NMI:Non-maskable_interrupts
      1755           -50.9%     861.75 ± 17%  interrupts.CPU3.PMI:Performance_monitoring_interrupts
    529.75 ±  4%     +80.9%     958.50 ±  5%  interrupts.CPU3.RES:Rescheduling_interrupts
    149977         +1092.9%    1789016 ±  2%  interrupts.CPU30.LOC:Local_timer_interrupts
      1791           -61.1%     696.25 ± 22%  interrupts.CPU30.NMI:Non-maskable_interrupts
      1791           -61.1%     696.25 ± 22%  interrupts.CPU30.PMI:Performance_monitoring_interrupts
    521.75 ±  5%     +77.8%     927.50 ±  3%  interrupts.CPU30.RES:Rescheduling_interrupts
    150029         +1092.4%    1788968 ±  2%  interrupts.CPU31.LOC:Local_timer_interrupts
      1767           -62.0%     671.75 ± 37%  interrupts.CPU31.NMI:Non-maskable_interrupts
      1767           -62.0%     671.75 ± 37%  interrupts.CPU31.PMI:Performance_monitoring_interrupts
    521.00 ±  2%     +84.7%     962.50 ±  7%  interrupts.CPU31.RES:Rescheduling_interrupts
    150028         +1092.5%    1789067 ±  2%  interrupts.CPU32.LOC:Local_timer_interrupts
    532.50 ±  2%     +96.5%       1046 ±  4%  interrupts.CPU32.RES:Rescheduling_interrupts
    149637         +1095.6%    1789077 ±  2%  interrupts.CPU33.LOC:Local_timer_interrupts
      1763 ±  2%     -64.4%     628.25 ± 37%  interrupts.CPU33.NMI:Non-maskable_interrupts
      1763 ±  2%     -64.4%     628.25 ± 37%  interrupts.CPU33.PMI:Performance_monitoring_interrupts
    499.25 ±  5%     +92.8%     962.75 ± 10%  interrupts.CPU33.RES:Rescheduling_interrupts
    150148         +1091.6%    1789238 ±  2%  interrupts.CPU34.LOC:Local_timer_interrupts
      1323 ± 33%     -54.5%     602.75 ± 46%  interrupts.CPU34.NMI:Non-maskable_interrupts
      1323 ± 33%     -54.5%     602.75 ± 46%  interrupts.CPU34.PMI:Performance_monitoring_interrupts
    498.00 ±  5%     +92.6%     959.00 ±  3%  interrupts.CPU34.RES:Rescheduling_interrupts
    150084         +1091.9%    1788867 ±  2%  interrupts.CPU35.LOC:Local_timer_interrupts
      1544 ± 25%     -57.8%     651.25 ± 43%  interrupts.CPU35.NMI:Non-maskable_interrupts
      1544 ± 25%     -57.8%     651.25 ± 43%  interrupts.CPU35.PMI:Performance_monitoring_interrupts
    511.25 ±  3%     +89.8%     970.25 ±  5%  interrupts.CPU35.RES:Rescheduling_interrupts
    150106         +1091.5%    1788521 ±  2%  interrupts.CPU36.LOC:Local_timer_interrupts
    533.00 ±  3%     +76.4%     940.25 ±  5%  interrupts.CPU36.RES:Rescheduling_interrupts
    150139         +1091.8%    1789312 ±  2%  interrupts.CPU37.LOC:Local_timer_interrupts
    513.25 ±  4%     +91.3%     982.00 ±  5%  interrupts.CPU37.RES:Rescheduling_interrupts
    150102         +1091.9%    1789006 ±  2%  interrupts.CPU38.LOC:Local_timer_interrupts
      1299 ± 32%     -43.1%     739.00 ± 21%  interrupts.CPU38.NMI:Non-maskable_interrupts
      1299 ± 32%     -43.1%     739.00 ± 21%  interrupts.CPU38.PMI:Performance_monitoring_interrupts
    518.75 ±  4%    +107.7%       1077 ±  6%  interrupts.CPU38.RES:Rescheduling_interrupts
    150053         +1092.2%    1788960 ±  2%  interrupts.CPU39.LOC:Local_timer_interrupts
      1525 ± 25%     -53.5%     709.00 ± 26%  interrupts.CPU39.NMI:Non-maskable_interrupts
      1525 ± 25%     -53.5%     709.00 ± 26%  interrupts.CPU39.PMI:Performance_monitoring_interrupts
    526.50 ±  2%     +94.3%       1022 ±  8%  interrupts.CPU39.RES:Rescheduling_interrupts
      7103 ±  2%     -16.3%       5942 ±  3%  interrupts.CPU4.CAL:Function_call_interrupts
    150217         +1090.1%    1787766 ±  3%  interrupts.CPU4.LOC:Local_timer_interrupts
      1536 ± 25%     -49.7%     772.25 ± 20%  interrupts.CPU4.NMI:Non-maskable_interrupts
      1536 ± 25%     -49.7%     772.25 ± 20%  interrupts.CPU4.PMI:Performance_monitoring_interrupts
    495.75 ±  3%     +88.8%     936.00 ±  4%  interrupts.CPU4.RES:Rescheduling_interrupts
    150146         +1091.5%    1788930 ±  2%  interrupts.CPU40.LOC:Local_timer_interrupts
    501.50           +89.0%     947.75 ±  3%  interrupts.CPU40.RES:Rescheduling_interrupts
    150099         +1091.8%    1788854 ±  2%  interrupts.CPU41.LOC:Local_timer_interrupts
    518.00 ±  5%     +87.3%     970.00 ±  4%  interrupts.CPU41.RES:Rescheduling_interrupts
    150159         +1091.3%    1788781 ±  2%  interrupts.CPU42.LOC:Local_timer_interrupts
    536.00 ±  2%     +69.8%     910.25 ±  9%  interrupts.CPU42.RES:Rescheduling_interrupts
      4.75 ±101%   +2936.8%     144.25 ±137%  interrupts.CPU42.TLB:TLB_shootdowns
    149916         +1093.3%    1788909 ±  2%  interrupts.CPU43.LOC:Local_timer_interrupts
    531.25 ±  2%     +80.3%     958.00 ±  2%  interrupts.CPU43.RES:Rescheduling_interrupts
    150126         +1091.7%    1789018 ±  2%  interrupts.CPU44.LOC:Local_timer_interrupts
      1525 ± 24%     -52.2%     729.75 ± 24%  interrupts.CPU44.NMI:Non-maskable_interrupts
      1525 ± 24%     -52.2%     729.75 ± 24%  interrupts.CPU44.PMI:Performance_monitoring_interrupts
    505.00 ±  3%     +81.0%     914.25 ±  4%  interrupts.CPU44.RES:Rescheduling_interrupts
    150108         +1091.8%    1788995 ±  2%  interrupts.CPU45.LOC:Local_timer_interrupts
      1756           -58.0%     738.00 ± 15%  interrupts.CPU45.NMI:Non-maskable_interrupts
      1756           -58.0%     738.00 ± 15%  interrupts.CPU45.PMI:Performance_monitoring_interrupts
    524.50 ±  5%     +74.5%     915.00 ±  2%  interrupts.CPU45.RES:Rescheduling_interrupts
    149970         +1092.9%    1788950 ±  2%  interrupts.CPU46.LOC:Local_timer_interrupts
      1790           -57.7%     757.25 ±  8%  interrupts.CPU46.NMI:Non-maskable_interrupts
      1790           -57.7%     757.25 ±  8%  interrupts.CPU46.PMI:Performance_monitoring_interrupts
    516.00 ±  6%     +84.0%     949.25 ± 11%  interrupts.CPU46.RES:Rescheduling_interrupts
    149906         +1093.4%    1788999 ±  2%  interrupts.CPU47.LOC:Local_timer_interrupts
      1756           -48.8%     898.75 ± 23%  interrupts.CPU47.NMI:Non-maskable_interrupts
      1756           -48.8%     898.75 ± 23%  interrupts.CPU47.PMI:Performance_monitoring_interrupts
    495.75 ±  5%     +83.2%     908.25 ± 12%  interrupts.CPU47.RES:Rescheduling_interrupts
    150137         +1090.7%    1787631 ±  3%  interrupts.CPU48.LOC:Local_timer_interrupts
      1538 ± 25%     -54.2%     704.50 ± 37%  interrupts.CPU48.NMI:Non-maskable_interrupts
      1538 ± 25%     -54.2%     704.50 ± 37%  interrupts.CPU48.PMI:Performance_monitoring_interrupts
    565.25 ±  7%     +86.8%       1056 ±  6%  interrupts.CPU48.RES:Rescheduling_interrupts
      6840 ±  2%     -15.8%       5757 ±  5%  interrupts.CPU49.CAL:Function_call_interrupts
    150165         +1090.5%    1787741 ±  3%  interrupts.CPU49.LOC:Local_timer_interrupts
      1516 ± 24%     -52.5%     720.00 ± 29%  interrupts.CPU49.NMI:Non-maskable_interrupts
      1516 ± 24%     -52.5%     720.00 ± 29%  interrupts.CPU49.PMI:Performance_monitoring_interrupts
    558.75 ±  5%     +86.2%       1040 ±  9%  interrupts.CPU49.RES:Rescheduling_interrupts
    150264         +1089.8%    1787810 ±  3%  interrupts.CPU5.LOC:Local_timer_interrupts
      1751 ±  3%     -62.5%     656.25 ± 30%  interrupts.CPU5.NMI:Non-maskable_interrupts
      1751 ±  3%     -62.5%     656.25 ± 30%  interrupts.CPU5.PMI:Performance_monitoring_interrupts
    505.50 ±  5%     +79.2%     906.00 ±  3%  interrupts.CPU5.RES:Rescheduling_interrupts
      6841 ±  3%     -18.2%       5593 ±  5%  interrupts.CPU50.CAL:Function_call_interrupts
    150244         +1089.9%    1787787 ±  3%  interrupts.CPU50.LOC:Local_timer_interrupts
      1312 ± 34%     -54.4%     599.00 ±  4%  interrupts.CPU50.NMI:Non-maskable_interrupts
      1312 ± 34%     -54.4%     599.00 ±  4%  interrupts.CPU50.PMI:Performance_monitoring_interrupts
    522.50 ±  2%     +77.7%     928.50 ±  4%  interrupts.CPU50.RES:Rescheduling_interrupts
      6771 ±  2%     -16.3%       5669 ±  2%  interrupts.CPU51.CAL:Function_call_interrupts
    150197         +1090.3%    1787760 ±  3%  interrupts.CPU51.LOC:Local_timer_interrupts
    519.75 ±  4%     +74.6%     907.25 ±  3%  interrupts.CPU51.RES:Rescheduling_interrupts
      6920           -18.7%       5624 ±  4%  interrupts.CPU52.CAL:Function_call_interrupts
    150223         +1090.1%    1787770 ±  3%  interrupts.CPU52.LOC:Local_timer_interrupts
    535.50 ±  6%     +59.2%     852.75 ±  4%  interrupts.CPU52.RES:Rescheduling_interrupts
      6938           -16.3%       5804 ±  6%  interrupts.CPU53.CAL:Function_call_interrupts
    150134         +1090.8%    1787795 ±  3%  interrupts.CPU53.LOC:Local_timer_interrupts
    525.75 ±  7%     +75.5%     922.50 ± 10%  interrupts.CPU53.RES:Rescheduling_interrupts
      7038 ±  2%     -17.9%       5779 ±  5%  interrupts.CPU54.CAL:Function_call_interrupts
    150213         +1090.2%    1787848 ±  3%  interrupts.CPU54.LOC:Local_timer_interrupts
      1519 ± 24%     -45.1%     834.75 ± 28%  interrupts.CPU54.NMI:Non-maskable_interrupts
      1519 ± 24%     -45.1%     834.75 ± 28%  interrupts.CPU54.PMI:Performance_monitoring_interrupts
    520.75 ±  5%     +57.3%     819.00 ±  8%  interrupts.CPU54.RES:Rescheduling_interrupts
      6722 ±  2%     -13.0%       5848 ±  6%  interrupts.CPU55.CAL:Function_call_interrupts
    150261         +1089.8%    1787822 ±  3%  interrupts.CPU55.LOC:Local_timer_interrupts
      1523 ± 24%     -53.9%     702.75 ± 35%  interrupts.CPU55.NMI:Non-maskable_interrupts
      1523 ± 24%     -53.9%     702.75 ± 35%  interrupts.CPU55.PMI:Performance_monitoring_interrupts
    541.25 ±  7%     +74.5%     944.25 ± 14%  interrupts.CPU55.RES:Rescheduling_interrupts
    150127         +1090.8%    1787690 ±  3%  interrupts.CPU56.LOC:Local_timer_interrupts
    516.75 ±  4%     +80.0%     930.00 ±  7%  interrupts.CPU56.RES:Rescheduling_interrupts
      6916 ±  2%     -17.1%       5737 ±  6%  interrupts.CPU57.CAL:Function_call_interrupts
    150223         +1090.1%    1787837 ±  3%  interrupts.CPU57.LOC:Local_timer_interrupts
      1528 ± 24%     -45.3%     835.75 ± 29%  interrupts.CPU57.NMI:Non-maskable_interrupts
      1528 ± 24%     -45.3%     835.75 ± 29%  interrupts.CPU57.PMI:Performance_monitoring_interrupts
    573.75 ±  7%     +69.5%     972.50 ±  9%  interrupts.CPU57.RES:Rescheduling_interrupts
      6876 ±  2%     -14.8%       5855 ±  4%  interrupts.CPU58.CAL:Function_call_interrupts
    150314         +1089.4%    1787848 ±  3%  interrupts.CPU58.LOC:Local_timer_interrupts
      1534 ± 24%     -52.6%     727.50 ± 35%  interrupts.CPU58.NMI:Non-maskable_interrupts
      1534 ± 24%     -52.6%     727.50 ± 35%  interrupts.CPU58.PMI:Performance_monitoring_interrupts
    505.00 ±  8%     +68.2%     849.25 ±  4%  interrupts.CPU58.RES:Rescheduling_interrupts
      7000           -15.1%       5941 ±  5%  interrupts.CPU59.CAL:Function_call_interrupts
    150209         +1090.3%    1787892 ±  3%  interrupts.CPU59.LOC:Local_timer_interrupts
      1314 ± 32%     -40.8%     778.00 ± 14%  interrupts.CPU59.NMI:Non-maskable_interrupts
      1314 ± 32%     -40.8%     778.00 ± 14%  interrupts.CPU59.PMI:Performance_monitoring_interrupts
    555.50 ± 12%     +66.2%     923.00 ±  7%  interrupts.CPU59.RES:Rescheduling_interrupts
      6913 ±  3%     -17.0%       5740 ±  4%  interrupts.CPU6.CAL:Function_call_interrupts
    150232         +1090.0%    1787761 ±  3%  interrupts.CPU6.LOC:Local_timer_interrupts
    530.75 ±  6%     +84.4%     978.50 ±  5%  interrupts.CPU6.RES:Rescheduling_interrupts
      6918           -14.8%       5895 ±  6%  interrupts.CPU60.CAL:Function_call_interrupts
    150296         +1089.5%    1787820 ±  3%  interrupts.CPU60.LOC:Local_timer_interrupts
    543.50 ±  5%     +64.0%     891.25 ±  7%  interrupts.CPU60.RES:Rescheduling_interrupts
      6832           -15.7%       5756 ±  4%  interrupts.CPU61.CAL:Function_call_interrupts
    150275         +1089.7%    1787780 ±  3%  interrupts.CPU61.LOC:Local_timer_interrupts
      1736           -50.9%     852.25 ± 16%  interrupts.CPU61.NMI:Non-maskable_interrupts
      1736           -50.9%     852.25 ± 16%  interrupts.CPU61.PMI:Performance_monitoring_interrupts
    561.50 ±  3%     +69.0%     948.75 ± 10%  interrupts.CPU61.RES:Rescheduling_interrupts
    150147         +1090.7%    1787853 ±  3%  interrupts.CPU62.LOC:Local_timer_interrupts
      1523 ± 24%     -59.8%     613.00 ± 32%  interrupts.CPU62.NMI:Non-maskable_interrupts
      1523 ± 24%     -59.8%     613.00 ± 32%  interrupts.CPU62.PMI:Performance_monitoring_interrupts
    513.50 ±  3%     +87.0%     960.25 ± 11%  interrupts.CPU62.RES:Rescheduling_interrupts
      6929 ±  2%     -17.0%       5750 ±  4%  interrupts.CPU63.CAL:Function_call_interrupts
    150307         +1089.5%    1787834 ±  3%  interrupts.CPU63.LOC:Local_timer_interrupts
      1749 ±  2%     -49.4%     884.25 ± 16%  interrupts.CPU63.NMI:Non-maskable_interrupts
      1749 ±  2%     -49.4%     884.25 ± 16%  interrupts.CPU63.PMI:Performance_monitoring_interrupts
    531.50 ±  7%     +65.6%     880.25        interrupts.CPU63.RES:Rescheduling_interrupts
      6986 ±  2%     -17.1%       5788 ±  3%  interrupts.CPU64.CAL:Function_call_interrupts
    150298         +1089.4%    1787593 ±  3%  interrupts.CPU64.LOC:Local_timer_interrupts
      1521 ± 26%     -52.4%     724.75 ± 18%  interrupts.CPU64.NMI:Non-maskable_interrupts
      1521 ± 26%     -52.4%     724.75 ± 18%  interrupts.CPU64.PMI:Performance_monitoring_interrupts
    527.25 ±  3%     +60.2%     844.50 ±  2%  interrupts.CPU64.RES:Rescheduling_interrupts
      7083           -16.8%       5894 ±  5%  interrupts.CPU65.CAL:Function_call_interrupts
    150225         +1090.2%    1787921 ±  3%  interrupts.CPU65.LOC:Local_timer_interrupts
    536.75 ±  4%     +59.3%     855.00 ±  5%  interrupts.CPU65.RES:Rescheduling_interrupts
      6910           -14.1%       5938 ±  4%  interrupts.CPU66.CAL:Function_call_interrupts
    150340         +1089.2%    1787898 ±  3%  interrupts.CPU66.LOC:Local_timer_interrupts
    585.75 ±  2%     +71.5%       1004 ±  9%  interrupts.CPU66.RES:Rescheduling_interrupts
      6851           -15.0%       5823 ±  5%  interrupts.CPU67.CAL:Function_call_interrupts
    150302         +1089.4%    1787748 ±  3%  interrupts.CPU67.LOC:Local_timer_interrupts
      1552 ± 25%     -50.5%     768.00 ± 23%  interrupts.CPU67.NMI:Non-maskable_interrupts
      1552 ± 25%     -50.5%     768.00 ± 23%  interrupts.CPU67.PMI:Performance_monitoring_interrupts
    555.25 ±  3%     +62.0%     899.50 ±  6%  interrupts.CPU67.RES:Rescheduling_interrupts
      6901 ±  2%     -19.6%       5550 ±  4%  interrupts.CPU68.CAL:Function_call_interrupts
    150258         +1089.9%    1787888 ±  3%  interrupts.CPU68.LOC:Local_timer_interrupts
    556.75 ± 10%     +58.7%     883.75 ±  8%  interrupts.CPU68.RES:Rescheduling_interrupts
      6944           -18.0%       5692 ±  9%  interrupts.CPU69.CAL:Function_call_interrupts
    150265         +1089.8%    1787886 ±  3%  interrupts.CPU69.LOC:Local_timer_interrupts
      1540 ± 25%     -54.8%     696.25 ± 30%  interrupts.CPU69.NMI:Non-maskable_interrupts
      1540 ± 25%     -54.8%     696.25 ± 30%  interrupts.CPU69.PMI:Performance_monitoring_interrupts
    553.25 ±  9%     +67.8%     928.25 ±  8%  interrupts.CPU69.RES:Rescheduling_interrupts
      6819           -13.5%       5900 ±  5%  interrupts.CPU7.CAL:Function_call_interrupts
    150231         +1090.0%    1787821 ±  3%  interrupts.CPU7.LOC:Local_timer_interrupts
    518.50 ±  2%    +105.4%       1065 ± 10%  interrupts.CPU7.RES:Rescheduling_interrupts
      6876 ±  2%     -16.4%       5751 ±  5%  interrupts.CPU70.CAL:Function_call_interrupts
    150342         +1089.2%    1787842 ±  3%  interrupts.CPU70.LOC:Local_timer_interrupts
    532.25 ±  6%     +59.7%     849.75 ±  2%  interrupts.CPU70.RES:Rescheduling_interrupts
      6849           -13.8%       5904 ±  4%  interrupts.CPU71.CAL:Function_call_interrupts
    150219         +1090.2%    1787845 ±  3%  interrupts.CPU71.LOC:Local_timer_interrupts
    517.00 ±  7%     +70.7%     882.75 ±  9%  interrupts.CPU71.RES:Rescheduling_interrupts
    149871         +1093.7%    1789000 ±  2%  interrupts.CPU72.LOC:Local_timer_interrupts
      1570 ± 24%     -56.9%     676.50 ± 17%  interrupts.CPU72.NMI:Non-maskable_interrupts
      1570 ± 24%     -56.9%     676.50 ± 17%  interrupts.CPU72.PMI:Performance_monitoring_interrupts
    553.75 ±  3%     +85.5%       1027 ±  7%  interrupts.CPU72.RES:Rescheduling_interrupts
      5738 ±  4%     +18.8%       6818 ± 11%  interrupts.CPU73.CAL:Function_call_interrupts
    150071         +1092.1%    1788977 ±  2%  interrupts.CPU73.LOC:Local_timer_interrupts
    557.25 ±  7%     +92.7%       1073 ± 10%  interrupts.CPU73.RES:Rescheduling_interrupts
    150122         +1091.7%    1789048 ±  2%  interrupts.CPU74.LOC:Local_timer_interrupts
      1544 ± 24%     -41.7%     900.75 ± 24%  interrupts.CPU74.NMI:Non-maskable_interrupts
      1544 ± 24%     -41.7%     900.75 ± 24%  interrupts.CPU74.PMI:Performance_monitoring_interrupts
    524.50 ±  6%     +87.6%     984.00 ± 11%  interrupts.CPU74.RES:Rescheduling_interrupts
    150079         +1092.1%    1789068 ±  2%  interrupts.CPU75.LOC:Local_timer_interrupts
    523.50 ±  2%     +78.7%     935.25 ±  6%  interrupts.CPU75.RES:Rescheduling_interrupts
    150127         +1091.6%    1788984 ±  2%  interrupts.CPU76.LOC:Local_timer_interrupts
      1523 ± 24%     -52.4%     725.50 ±  8%  interrupts.CPU76.NMI:Non-maskable_interrupts
      1523 ± 24%     -52.4%     725.50 ±  8%  interrupts.CPU76.PMI:Performance_monitoring_interrupts
    525.00           +76.5%     926.75 ±  9%  interrupts.CPU76.RES:Rescheduling_interrupts
    150165         +1091.4%    1789008 ±  2%  interrupts.CPU77.LOC:Local_timer_interrupts
      1556 ± 25%     -46.9%     826.50 ± 25%  interrupts.CPU77.NMI:Non-maskable_interrupts
      1556 ± 25%     -46.9%     826.50 ± 25%  interrupts.CPU77.PMI:Performance_monitoring_interrupts
    535.75 ±  3%     +78.3%     955.50 ± 10%  interrupts.CPU77.RES:Rescheduling_interrupts
    149783         +1094.4%    1789010 ±  2%  interrupts.CPU78.LOC:Local_timer_interrupts
      1788           -59.3%     727.50 ±  8%  interrupts.CPU78.NMI:Non-maskable_interrupts
      1788           -59.3%     727.50 ±  8%  interrupts.CPU78.PMI:Performance_monitoring_interrupts
    539.00 ±  7%     +67.3%     901.50 ±  8%  interrupts.CPU78.RES:Rescheduling_interrupts
    150147         +1091.4%    1788924 ±  2%  interrupts.CPU79.LOC:Local_timer_interrupts
      1562 ± 25%     -43.0%     889.75 ± 31%  interrupts.CPU79.NMI:Non-maskable_interrupts
      1562 ± 25%     -43.0%     889.75 ± 31%  interrupts.CPU79.PMI:Performance_monitoring_interrupts
    542.75 ±  9%     +65.5%     898.50 ±  2%  interrupts.CPU79.RES:Rescheduling_interrupts
      6824 ±  2%     -15.1%       5793 ±  4%  interrupts.CPU8.CAL:Function_call_interrupts
    150210         +1090.0%    1787456 ±  3%  interrupts.CPU8.LOC:Local_timer_interrupts
      1741           -56.3%     760.50 ± 19%  interrupts.CPU8.NMI:Non-maskable_interrupts
      1741           -56.3%     760.50 ± 19%  interrupts.CPU8.PMI:Performance_monitoring_interrupts
    506.00 ±  4%     +93.4%     978.75 ±  5%  interrupts.CPU8.RES:Rescheduling_interrupts
    250.00 ± 98%  +12777.4%      32193 ±167%  interrupts.CPU80.75:PCI-MSI.70260737-edge.eth3-TxRx-0
    150009         +1092.6%    1789046 ±  2%  interrupts.CPU80.LOC:Local_timer_interrupts
      1761           -56.8%     760.50 ± 27%  interrupts.CPU80.NMI:Non-maskable_interrupts
      1761           -56.8%     760.50 ± 27%  interrupts.CPU80.PMI:Performance_monitoring_interrupts
    523.25 ±  5%     +81.6%     950.25 ±  5%  interrupts.CPU80.RES:Rescheduling_interrupts
    149572         +1096.1%    1789038 ±  2%  interrupts.CPU81.LOC:Local_timer_interrupts
      1546 ± 24%     -49.7%     777.00 ± 21%  interrupts.CPU81.NMI:Non-maskable_interrupts
      1546 ± 24%     -49.7%     777.00 ± 21%  interrupts.CPU81.PMI:Performance_monitoring_interrupts
    546.75 ± 10%     +64.0%     896.50 ±  6%  interrupts.CPU81.RES:Rescheduling_interrupts
    774.25 ±162%   +1610.6%      13244 ±136%  interrupts.CPU82.77:PCI-MSI.70260739-edge.eth3-TxRx-2
    150143         +1091.7%    1789225 ±  2%  interrupts.CPU82.LOC:Local_timer_interrupts
      1771           -50.5%     876.50 ± 27%  interrupts.CPU82.NMI:Non-maskable_interrupts
      1771           -50.5%     876.50 ± 27%  interrupts.CPU82.PMI:Performance_monitoring_interrupts
    542.50 ±  7%     +70.5%     924.75 ±  7%  interrupts.CPU82.RES:Rescheduling_interrupts
    150013         +1092.5%    1788903 ±  2%  interrupts.CPU83.LOC:Local_timer_interrupts
      1767           -54.8%     798.50 ± 19%  interrupts.CPU83.NMI:Non-maskable_interrupts
      1767           -54.8%     798.50 ± 19%  interrupts.CPU83.PMI:Performance_monitoring_interrupts
    526.75 ±  3%     +68.0%     885.00 ±  8%  interrupts.CPU83.RES:Rescheduling_interrupts
    552.00 ±158%   +8041.8%      44942 ±105%  interrupts.CPU84.79:PCI-MSI.70260741-edge.eth3-TxRx-4
    150082         +1091.7%    1788512 ±  2%  interrupts.CPU84.LOC:Local_timer_interrupts
      1803           -49.1%     917.25 ± 21%  interrupts.CPU84.NMI:Non-maskable_interrupts
      1803           -49.1%     917.25 ± 21%  interrupts.CPU84.PMI:Performance_monitoring_interrupts
    545.75           +71.5%     936.00 ±  4%  interrupts.CPU84.RES:Rescheduling_interrupts
    844.50 ±163%   +6985.2%      59834 ± 92%  interrupts.CPU85.80:PCI-MSI.70260742-edge.eth3-TxRx-5
    150154         +1091.7%    1789379 ±  2%  interrupts.CPU85.LOC:Local_timer_interrupts
      1765 ±  2%     -53.6%     818.75 ± 26%  interrupts.CPU85.NMI:Non-maskable_interrupts
      1765 ±  2%     -53.6%     818.75 ± 26%  interrupts.CPU85.PMI:Performance_monitoring_interrupts
    545.50 ±  3%     +77.2%     966.75 ±  8%  interrupts.CPU85.RES:Rescheduling_interrupts
     96.50 ± 90%   +4080.3%       4034 ±150%  interrupts.CPU86.81:PCI-MSI.70260743-edge.eth3-TxRx-6
    150129         +1091.7%    1789096 ±  2%  interrupts.CPU86.LOC:Local_timer_interrupts
      1751 ±  2%     -52.7%     828.00 ± 17%  interrupts.CPU86.NMI:Non-maskable_interrupts
      1751 ±  2%     -52.7%     828.00 ± 17%  interrupts.CPU86.PMI:Performance_monitoring_interrupts
    560.00 ±  3%     +65.1%     924.50 ±  4%  interrupts.CPU86.RES:Rescheduling_interrupts
    150050         +1092.3%    1789021 ±  2%  interrupts.CPU87.LOC:Local_timer_interrupts
    559.50 ±  6%     +60.3%     896.75 ±  8%  interrupts.CPU87.RES:Rescheduling_interrupts
    150187         +1091.2%    1788981 ±  2%  interrupts.CPU88.LOC:Local_timer_interrupts
      1771 ±  2%     -48.8%     907.00 ± 17%  interrupts.CPU88.NMI:Non-maskable_interrupts
      1771 ±  2%     -48.8%     907.00 ± 17%  interrupts.CPU88.PMI:Performance_monitoring_interrupts
    561.00 ±  3%     +67.9%     942.00 ±  5%  interrupts.CPU88.RES:Rescheduling_interrupts
    150116         +1091.7%    1788958 ±  2%  interrupts.CPU89.LOC:Local_timer_interrupts
      1793           -43.4%       1015 ± 17%  interrupts.CPU89.NMI:Non-maskable_interrupts
      1793           -43.4%       1015 ± 17%  interrupts.CPU89.PMI:Performance_monitoring_interrupts
    521.50 ±  4%     +72.1%     897.50 ±  6%  interrupts.CPU89.RES:Rescheduling_interrupts
    150194         +1090.4%    1787840 ±  3%  interrupts.CPU9.LOC:Local_timer_interrupts
      1522 ± 23%     -47.5%     799.25 ± 17%  interrupts.CPU9.NMI:Non-maskable_interrupts
      1522 ± 23%     -47.5%     799.25 ± 17%  interrupts.CPU9.PMI:Performance_monitoring_interrupts
    498.00 ±  3%    +101.5%       1003 ±  2%  interrupts.CPU9.RES:Rescheduling_interrupts
    150149         +1091.5%    1788993 ±  2%  interrupts.CPU90.LOC:Local_timer_interrupts
      1780           -56.4%     775.75 ± 23%  interrupts.CPU90.NMI:Non-maskable_interrupts
      1780           -56.4%     775.75 ± 23%  interrupts.CPU90.PMI:Performance_monitoring_interrupts
    512.75 ±  3%     +68.9%     866.25 ±  3%  interrupts.CPU90.RES:Rescheduling_interrupts
    149986         +1092.7%    1788910 ±  2%  interrupts.CPU91.LOC:Local_timer_interrupts
    518.25 ±  4%     +69.9%     880.25 ±  6%  interrupts.CPU91.RES:Rescheduling_interrupts
      6.00 ± 61%   +2137.5%     134.25 ±125%  interrupts.CPU91.TLB:TLB_shootdowns
    150056         +1092.2%    1789012 ±  2%  interrupts.CPU92.LOC:Local_timer_interrupts
      1765           -55.4%     788.00 ± 14%  interrupts.CPU92.NMI:Non-maskable_interrupts
      1765           -55.4%     788.00 ± 14%  interrupts.CPU92.PMI:Performance_monitoring_interrupts
    526.50 ±  5%     +65.5%     871.50 ±  9%  interrupts.CPU92.RES:Rescheduling_interrupts
    150123         +1091.7%    1789025 ±  2%  interrupts.CPU93.LOC:Local_timer_interrupts
      1543 ± 24%     -55.3%     689.75 ± 26%  interrupts.CPU93.NMI:Non-maskable_interrupts
      1543 ± 24%     -55.3%     689.75 ± 26%  interrupts.CPU93.PMI:Performance_monitoring_interrupts
    511.25 ±  3%     +70.4%     871.00 ±  4%  interrupts.CPU93.RES:Rescheduling_interrupts
    150075         +1092.1%    1789036 ±  2%  interrupts.CPU94.LOC:Local_timer_interrupts
      1568 ± 25%     -50.4%     777.25 ± 16%  interrupts.CPU94.NMI:Non-maskable_interrupts
      1568 ± 25%     -50.4%     777.25 ± 16%  interrupts.CPU94.PMI:Performance_monitoring_interrupts
    526.25 ±  5%     +66.7%     877.25 ±  4%  interrupts.CPU94.RES:Rescheduling_interrupts
    150146         +1091.5%    1789044 ±  2%  interrupts.CPU95.LOC:Local_timer_interrupts
      1784           -50.6%     880.50 ± 27%  interrupts.CPU95.NMI:Non-maskable_interrupts
      1784           -50.6%     880.50 ± 27%  interrupts.CPU95.PMI:Performance_monitoring_interrupts
    539.25 ±  7%     +53.6%     828.25 ±  4%  interrupts.CPU95.RES:Rescheduling_interrupts
  14412372         +1091.2%  1.717e+08 ±  2%  interrupts.LOC:Local_timer_interrupts
      0.00       +1.9e+104%     192.00        interrupts.MCP:Machine_check_polls
    154111 ±  4%     -51.0%      75504 ±  4%  interrupts.NMI:Non-maskable_interrupts
    154111 ±  4%     -51.0%      75504 ±  4%  interrupts.PMI:Performance_monitoring_interrupts
     50770           +78.2%      90484 ±  2%  interrupts.RES:Rescheduling_interrupts
    721.25 ±  3%    +396.3%       3579 ± 37%  interrupts.TLB:TLB_shootdowns


                                                                                
                                 aim7.jobs-per-min                              
                                                                                
  9000 +--------------------------------------------------------------------+   
       |.+..+.+.+..+.+.+.+..+.+    +.+.+..+.   .+..+.+.+                    |   
  8000 |-+                    :    :        +.+                             |   
  7000 |-O  O O O  O O O O  O : O  : O O  O O O O  O O O  O O O  O O        |   
       |                      :   :                                         |   
  6000 |-+                     :  :                                         |   
  5000 |-+                     :  :                                         |   
       |                       :  :                                         |   
  4000 |-+                     : :                                          |   
  3000 |-+                     : :                                          |   
       |                       : :                                          |   
  2000 |-+                      ::                                          |   
  1000 |-+                      :                                           |   
       |                        :                                    O O  O |   
     0 +--------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                              aim7.time.elapsed_time                            
                                                                                
  1000 +--------------------------------------------------------------------+   
   900 |-+                                                             O    |   
       |                                                             O    O |   
   800 |-+                                                                  |   
   700 |-+                                                                  |   
       |                                                                    |   
   600 |-+                                                                  |   
   500 |-+                                                                  |   
   400 |-+                                                                  |   
       |                                                                    |   
   300 |-+                                                                  |   
   200 |-+                                                                  |   
       |                                                                    |   
   100 |.+..+.+.+..+.+.+.+..+.+.O .+.+.+..+.+.+.+..+.+.+  O O O  O O        |   
     0 +--------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                            aim7.time.elapsed_time.max                          
                                                                                
  1000 +--------------------------------------------------------------------+   
   900 |-+                                                             O    |   
       |                                                             O    O |   
   800 |-+                                                                  |   
   700 |-+                                                                  |   
       |                                                                    |   
   600 |-+                                                                  |   
   500 |-+                                                                  |   
   400 |-+                                                                  |   
       |                                                                    |   
   300 |-+                                                                  |   
   200 |-+                                                                  |   
       |                                                                    |   
   100 |.+..+.+.+..+.+.+.+..+.+.O .+.+.+..+.+.+.+..+.+.+  O O O  O O        |   
     0 +--------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                        aim7.time.involuntary_context_switches                  
                                                                                
    3e+06 +-----------------------------------------------------------------+   
          |                                                          O  O O |   
  2.5e+06 |-O O  O O O O O  O O O O O  O O O O O  O O O O O  O O O O        |   
          |                                                                 |   
          |                                                                 |   
    2e+06 |-+                                                               |   
          |                                                                 |   
  1.5e+06 |-+                                +.+..+.+.+.+                   |   
          |                                 :                               |   
    1e+06 |-+                               :                               |   
          |.+.+..+.+.+.+.+..+.+.+   +..+.+.+                                |   
          |                      :  :                                       |   
   500000 |-+                    : :                                        |   
          |                       ::                                        |   
        0 +-----------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                            aim7.time.file_system_outputs                       
                                                                                
  9e+07 +-------------------------------------------------------------------+   
        | O  O O O O  O O O O  : O : O  O O O  O O O O  O O O O  O O O O  O |   
  8e+07 |-+                    :   :                                        |   
  7e+07 |-+                    :   :                                        |   
        |                       : :                                         |   
  6e+07 |-+                     : :                                         |   
  5e+07 |-+                     : :                                         |   
        |                       : :                                         |   
  4e+07 |-+                     : :                                         |   
  3e+07 |-+                     : :                                         |   
        |                       : :                                         |   
  2e+07 |-+                      :                                          |   
  1e+07 |-+                      :                                          |   
        |                        :                                          |   
      0 +-------------------------------------------------------------------+   
                                                                                
                                                                                
[*] bisect-good sample
[O] bisect-bad  sample

***************************************************************************************************
lkp-cfl-e1: 16 threads Intel(R) Xeon(R) E-2278G CPU @ 3.40GHz with 32G memory
=========================================================================================
compiler/cpufreq_governor/kconfig/nr_task/rootfs/runtime/tbox_group/test/testcase/ucode:
  gcc-9/performance/x86_64-rhel-8.3/30%/debian-10.4-x86_64-20200603.cgz/300s/lkp-cfl-e1/shell8/unixbench/0xde

commit: 
  62d5313500 ("locking/rwsem: Enable reader optimistic lock stealing")
  c9847a7f94 ("locking/rwsem: Wake up all waiting readers if RWSEM_WAKE_READ_OWNED")

62d5313500ac58b6 c9847a7f94679e742710574a2a7 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
     22370            -1.9%      21939        unixbench.score
   1325065            -2.8%    1287341        unixbench.time.involuntary_context_switches
     10030            -0.8%       9950        unixbench.time.maximum_resident_set_size
 1.074e+08            -1.9%  1.054e+08        unixbench.time.minor_page_faults
      1367            -2.2%       1337        unixbench.time.percent_of_cpu_this_job_got
    372.90            -2.6%     363.18        unixbench.time.system_time
    490.82            -1.9%     481.37        unixbench.time.user_time
   3156052           +11.8%    3528615        unixbench.time.voluntary_context_switches
    845598            -1.9%     829330        unixbench.workload
     11.84            +2.0       13.83 ±  4%  mpstat.cpu.all.idle%
     14864 ± 57%     -63.7%       5388 ± 26%  softirqs.NET_RX
     48363           -16.4%      40455 ± 10%  meminfo.AnonHugePages
    217888           -11.7%     192288 ±  4%  meminfo.DirectMap4k
      2185           +12.1%       2449        slabinfo.kmalloc-1k.num_objs
     11354 ±  3%     -16.1%       9521 ±  4%  slabinfo.vmap_area.active_objs
     11526 ±  3%     -14.7%       9835 ±  4%  slabinfo.vmap_area.num_objs
     13.50 ±  3%     +14.8%      15.50 ±  3%  vmstat.cpu.id
     51.00            -2.5%      49.75        vmstat.cpu.sy
     34.00            -2.9%      33.00        vmstat.cpu.us
     23.50 ±  2%      -9.6%      21.25 ±  5%  vmstat.procs.r
    102380           +10.6%     113264        vmstat.system.cs
  33970733 ±  2%     +50.1%   50992679 ±  8%  cpuidle.C1.time
    886295           +46.4%    1297530 ±  6%  cpuidle.C1.usage
     62811 ± 99%    +202.9%     190270 ± 12%  cpuidle.C10.time
     45921 ±  3%     +35.2%      62068 ± 13%  cpuidle.C3.usage
    115402          +124.5%     259071 ±  8%  cpuidle.POLL.time
     10953 ±  3%    +197.5%      32585 ±  7%  cpuidle.POLL.usage
    477.50 ±  3%      +9.5%     522.75        proc-vmstat.nr_active_anon
      5785            +0.9%       5838        proc-vmstat.nr_kernel_stack
    477.50 ±  3%      +9.5%     522.75        proc-vmstat.nr_zone_active_anon
  71809737            -1.1%   71020069        proc-vmstat.numa_hit
  71809737            -1.1%   71020069        proc-vmstat.numa_local
    119599            -3.0%     115977        proc-vmstat.pgactivate
  76761873            -1.9%   75313926        proc-vmstat.pgalloc_normal
 1.077e+08            -1.9%  1.056e+08        proc-vmstat.pgfault
  76755211            -1.9%   75305695        proc-vmstat.pgfree
   5472622            -2.1%    5357159        proc-vmstat.pgreuse
      3627            -4.2%       3475        proc-vmstat.thp_fault_alloc
   1503946            -1.9%    1474994        proc-vmstat.unevictable_pgs_culled
      4767 ± 96%     -89.1%     519.50 ±139%  interrupts.132:IR-PCI-MSI.2097153-edge.eth1-TxRx-0
     22159 ±  2%      -4.0%      21268 ±  3%  interrupts.CAL:Function_call_interrupts
    558.50 ±  2%     +14.4%     639.00 ± 11%  interrupts.CPU0.TLB:TLB_shootdowns
      4767 ± 96%     -89.1%     519.50 ±139%  interrupts.CPU1.132:IR-PCI-MSI.2097153-edge.eth1-TxRx-0
      1363 ±  5%      -9.3%       1237 ±  6%  interrupts.CPU1.CAL:Function_call_interrupts
    559.00           +17.1%     654.50 ±  2%  interrupts.CPU1.TLB:TLB_shootdowns
    535.00 ±  2%     +24.1%     663.75 ±  4%  interrupts.CPU10.TLB:TLB_shootdowns
    576.50           +14.1%     658.00 ±  4%  interrupts.CPU11.TLB:TLB_shootdowns
      1421 ±  5%      -7.1%       1320 ±  4%  interrupts.CPU12.CAL:Function_call_interrupts
    579.00           +20.5%     697.75 ±  3%  interrupts.CPU12.TLB:TLB_shootdowns
    569.50           +21.2%     690.50 ±  6%  interrupts.CPU13.TLB:TLB_shootdowns
    505.00           +32.2%     667.50 ±  6%  interrupts.CPU14.TLB:TLB_shootdowns
      1422 ±  3%      -8.4%       1302 ±  3%  interrupts.CPU15.CAL:Function_call_interrupts
    509.50 ±  6%     +36.2%     694.00 ±  8%  interrupts.CPU15.TLB:TLB_shootdowns
    557.50 ±  2%     +18.9%     662.75 ±  6%  interrupts.CPU2.TLB:TLB_shootdowns
    570.00 ±  2%     +18.9%     678.00 ±  8%  interrupts.CPU3.TLB:TLB_shootdowns
    556.50           +21.4%     675.75 ±  2%  interrupts.CPU4.TLB:TLB_shootdowns
    506.00           +34.7%     681.75 ±  6%  interrupts.CPU5.TLB:TLB_shootdowns
      1363 ±  3%      -6.5%       1274 ±  5%  interrupts.CPU6.CAL:Function_call_interrupts
    534.00 ±  3%     +23.5%     659.50 ±  4%  interrupts.CPU6.TLB:TLB_shootdowns
    559.50           +21.3%     678.50 ±  7%  interrupts.CPU7.TLB:TLB_shootdowns
    563.50 ±  2%     +20.6%     679.75 ±  7%  interrupts.CPU8.TLB:TLB_shootdowns
    514.50 ±  4%     +27.8%     657.75 ±  2%  interrupts.CPU9.TLB:TLB_shootdowns
      8753           +22.7%      10738 ±  4%  interrupts.TLB:TLB_shootdowns
    242.90 ±  8%     +20.9%     293.59 ±  5%  sched_debug.cfs_rq:/.exec_clock.stddev
     12708 ±  2%     +19.8%      15225 ±  8%  sched_debug.cfs_rq:/.min_vruntime.stddev
      1472           +26.0%       1854 ± 12%  sched_debug.cfs_rq:/.runnable_avg.max
    292.07 ±  5%     +28.7%     375.92 ± 13%  sched_debug.cfs_rq:/.runnable_avg.stddev
     12708 ±  2%     +19.8%      15226 ±  8%  sched_debug.cfs_rq:/.spread0.stddev
      1418           +27.0%       1801 ± 12%  sched_debug.cfs_rq:/.util_avg.max
    281.89 ±  7%     +30.6%     368.13 ± 14%  sched_debug.cfs_rq:/.util_avg.stddev
    212080 ± 10%     -15.4%     179338 ± 12%  sched_debug.cpu.avg_idle.avg
     41096 ± 15%     -24.6%      30990 ± 17%  sched_debug.cpu.avg_idle.min
    208687 ±  3%     -15.1%     177102 ± 10%  sched_debug.cpu.avg_idle.stddev
      7605 ± 19%     +92.1%      14611 ±  7%  sched_debug.cpu.curr->pid.max
      2601 ± 37%     +93.0%       5020 ± 20%  sched_debug.cpu.curr->pid.stddev
    203329           +10.7%     225114        sched_debug.cpu.nr_switches.avg
    -82.00          +129.7%    -188.38        sched_debug.cpu.nr_uninterruptible.min
     42.97           +69.8%      72.96 ± 16%  sched_debug.cpu.nr_uninterruptible.stddev
    197540           +11.1%     219447        sched_debug.cpu.sched_count.avg
    200544           +11.3%     223137        sched_debug.cpu.sched_count.max
    187758           +11.0%     208437        sched_debug.cpu.sched_count.min
      3057           +23.1%       3763 ± 10%  sched_debug.cpu.sched_count.stddev
     43758           +28.3%      56141 ±  3%  sched_debug.cpu.sched_goidle.avg
     45063           +27.4%      57397 ±  3%  sched_debug.cpu.sched_goidle.max
     41416           +28.8%      53349 ±  2%  sched_debug.cpu.sched_goidle.min
    860.48           +23.8%       1064 ± 10%  sched_debug.cpu.sched_goidle.stddev
     86423           +13.0%      97665        sched_debug.cpu.ttwu_count.avg
     87940           +13.8%     100103        sched_debug.cpu.ttwu_count.max
     81643           +12.4%      91752 ±  2%  sched_debug.cpu.ttwu_count.min
    611.62 ±  2%     +26.0%     770.48 ± 11%  sched_debug.cpu.ttwu_local.stddev
 1.024e+10            -1.5%  1.008e+10        perf-stat.i.branch-instructions
      4.55            +0.1        4.69        perf-stat.i.cache-miss-rate%
 1.019e+08            -0.9%  1.009e+08        perf-stat.i.cache-misses
 2.485e+09            -1.7%  2.442e+09        perf-stat.i.cache-references
    105828           +10.8%     117262        perf-stat.i.context-switches
 5.631e+10            -1.8%  5.529e+10        perf-stat.i.cpu-cycles
     15839           +15.4%      18271 ±  2%  perf-stat.i.cpu-migrations
 1.276e+10            -1.8%  1.253e+10        perf-stat.i.dTLB-loads
   3739007            -2.7%    3638057        perf-stat.i.dTLB-store-misses
 7.373e+09            -1.9%  7.236e+09        perf-stat.i.dTLB-stores
  10623717            -1.7%   10438031        perf-stat.i.iTLB-load-misses
 4.991e+10            -1.5%  4.914e+10        perf-stat.i.instructions
      3.52            -1.8%       3.46        perf-stat.i.metric.GHz
      0.33 ±  6%     -58.4%       0.14 ± 28%  perf-stat.i.metric.K/sec
      2056            -1.7%       2021        perf-stat.i.metric.M/sec
   1655018            -2.2%    1619167        perf-stat.i.minor-faults
      0.00 ±  2%      +0.0        0.00 ± 15%  perf-stat.i.node-load-miss-rate%
   5452609            -1.0%    5399939        perf-stat.i.node-loads
  33146294            -1.4%   32686027        perf-stat.i.node-stores
   1655623            -2.2%    1619758        perf-stat.i.page-faults
 1.007e+10            -1.5%  9.918e+09        perf-stat.ps.branch-instructions
 1.002e+08            -0.9%   99277053        perf-stat.ps.cache-misses
 2.444e+09            -1.7%  2.403e+09        perf-stat.ps.cache-references
    104069           +10.9%     115371        perf-stat.ps.context-switches
 5.538e+10            -1.8%   5.44e+10        perf-stat.ps.cpu-cycles
     15575           +15.4%      17977 ±  2%  perf-stat.ps.cpu-migrations
 1.254e+10            -1.7%  1.233e+10        perf-stat.ps.dTLB-loads
   3676839            -2.7%    3579226        perf-stat.ps.dTLB-store-misses
 7.251e+09            -1.8%  7.119e+09        perf-stat.ps.dTLB-stores
  10447266            -1.7%   10269385        perf-stat.ps.iTLB-load-misses
 4.909e+10            -1.5%  4.835e+10        perf-stat.ps.instructions
   1627477            -2.1%    1592966        perf-stat.ps.minor-faults
   5362125            -0.9%    5312864        perf-stat.ps.node-loads
  32594979            -1.3%   32157625        perf-stat.ps.node-stores
   1628072            -2.1%    1593547        perf-stat.ps.page-faults
 3.148e+12            -1.5%  3.102e+12        perf-stat.total.instructions
     15.17 ±100%     -15.2        0.00        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.write
     15.17 ±100%     -15.2        0.00        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     15.17 ±100%     -15.2        0.00        perf-profile.calltrace.cycles-pp.write
     15.17 ±100%     -15.2        0.00        perf-profile.calltrace.cycles-pp.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     15.17 ±100%     -15.2        0.00        perf-profile.calltrace.cycles-pp.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     15.17 ±100%     -15.2        0.00        perf-profile.calltrace.cycles-pp.new_sync_write.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
     15.17 ±100%     -15.2        0.00        perf-profile.calltrace.cycles-pp.devkmsg_write.cold.new_sync_write.vfs_write.ksys_write.do_syscall_64
     15.17 ±100%     -15.2        0.00        perf-profile.calltrace.cycles-pp.devkmsg_emit.devkmsg_write.cold.new_sync_write.vfs_write.ksys_write
     15.17 ±100%     -15.2        0.00        perf-profile.calltrace.cycles-pp.vprintk_emit.devkmsg_emit.devkmsg_write.cold.new_sync_write.vfs_write
     15.17 ±100%     -15.2        0.00        perf-profile.calltrace.cycles-pp.console_unlock.vprintk_emit.devkmsg_emit.devkmsg_write.cold.new_sync_write
     24.48 ±100%     -14.2       10.29 ±173%  perf-profile.calltrace.cycles-pp.worker_thread.kthread.ret_from_fork
     24.48 ±100%     -14.2       10.29 ±173%  perf-profile.calltrace.cycles-pp.process_one_work.worker_thread.kthread.ret_from_fork
     24.48 ±100%     -14.2       10.29 ±173%  perf-profile.calltrace.cycles-pp.drm_fb_helper_dirty_work.process_one_work.worker_thread.kthread.ret_from_fork
     24.48 ±100%     -13.9       10.59 ±173%  perf-profile.calltrace.cycles-pp.ret_from_fork
     24.48 ±100%     -13.9       10.59 ±173%  perf-profile.calltrace.cycles-pp.kthread.ret_from_fork
     23.80 ± 99%     -13.8       10.00 ±173%  perf-profile.calltrace.cycles-pp.memcpy_erms.drm_fb_helper_dirty_work.process_one_work.worker_thread.kthread
     13.79 ±100%     -13.8        0.00        perf-profile.calltrace.cycles-pp.serial8250_console_write.console_unlock.vprintk_emit.devkmsg_emit.devkmsg_write.cold
     13.11 ±100%     -13.1        0.00        perf-profile.calltrace.cycles-pp.uart_console_write.serial8250_console_write.console_unlock.vprintk_emit.devkmsg_emit
      8.96 ±100%      -9.0        0.00        perf-profile.calltrace.cycles-pp.wait_for_xmitr.serial8250_console_putchar.uart_console_write.serial8250_console_write.console_unlock
      8.96 ±100%      -9.0        0.00        perf-profile.calltrace.cycles-pp.io_serial_in.wait_for_xmitr.serial8250_console_putchar.uart_console_write.serial8250_console_write
      8.96 ±100%      -9.0        0.00        perf-profile.calltrace.cycles-pp.serial8250_console_putchar.uart_console_write.serial8250_console_write.console_unlock.vprintk_emit
      4.54 ±100%      -4.5        0.00        perf-profile.calltrace.cycles-pp.perf_output_begin.perf_event_mmap_output.perf_iterate_sb.perf_event_mmap.mmap_region
      4.54 ±100%      -4.5        0.00        perf-profile.calltrace.cycles-pp.vma_interval_tree_remove.__vma_adjust.__split_vma.mprotect_fixup.do_mprotect_pkey
      4.54 ±100%      -4.5        0.00        perf-profile.calltrace.cycles-pp.__tsearch
      4.54 ±100%      -4.5        0.00        perf-profile.calltrace.cycles-pp.__dentry_kill.shrink_dentry_list.shrink_dcache_parent.d_invalidate.proc_invalidate_siblings_dcache
      4.54 ±100%      -4.5        0.00        perf-profile.calltrace.cycles-pp.evict.__dentry_kill.shrink_dentry_list.shrink_dcache_parent.d_invalidate
      4.54 ±100%      -4.5        0.00        perf-profile.calltrace.cycles-pp.asm_exc_page_fault
      4.54 ±100%      -4.5        0.00        perf-profile.calltrace.cycles-pp.exc_page_fault.asm_exc_page_fault
      4.54 ±100%      -4.5        0.00        perf-profile.calltrace.cycles-pp.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      4.54 ±100%      -4.5        0.00        perf-profile.calltrace.cycles-pp.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      4.54 ±100%      -4.5        0.00        perf-profile.calltrace.cycles-pp.perf_event_mmap.mmap_region.do_mmap.vm_mmap_pgoff.ksys_mmap_pgoff
      4.54 ±100%      -4.5        0.00        perf-profile.calltrace.cycles-pp.perf_iterate_sb.perf_event_mmap.mmap_region.do_mmap.vm_mmap_pgoff
      4.54 ±100%      -4.5        0.00        perf-profile.calltrace.cycles-pp.perf_event_mmap_output.perf_iterate_sb.perf_event_mmap.mmap_region.do_mmap
      4.54 ±100%      -4.2        0.29 ±173%  perf-profile.calltrace.cycles-pp.__alloc_pages_nodemask.alloc_pages_vma.do_anonymous_page.__handle_mm_fault.handle_mm_fault
      4.54 ±100%      -4.2        0.29 ±173%  perf-profile.calltrace.cycles-pp.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      4.54 ±100%      -4.2        0.29 ±173%  perf-profile.calltrace.cycles-pp.alloc_pages_vma.do_anonymous_page.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
      4.54 ±100%      -4.2        0.29 ±173%  perf-profile.calltrace.cycles-pp.do_anonymous_page.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault
      4.14 ±100%      -4.1        0.00        perf-profile.calltrace.cycles-pp.io_serial_out.uart_console_write.serial8250_console_write.console_unlock.vprintk_emit
      4.54 ±100%      -2.8        1.78 ±173%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.waitid
      4.54 ±100%      -2.8        1.78 ±173%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.waitid
      4.54 ±100%      -2.8        1.78 ±173%  perf-profile.calltrace.cycles-pp.__do_sys_waitid.do_syscall_64.entry_SYSCALL_64_after_hwframe.waitid
      4.54 ±100%      -2.8        1.78 ±173%  perf-profile.calltrace.cycles-pp.shrink_dentry_list.shrink_dcache_parent.d_invalidate.proc_invalidate_siblings_dcache.release_task
      4.54 ±100%      -2.8        1.78 ±173%  perf-profile.calltrace.cycles-pp.kernel_waitid.__do_sys_waitid.do_syscall_64.entry_SYSCALL_64_after_hwframe.waitid
      4.54 ±100%      -2.8        1.78 ±173%  perf-profile.calltrace.cycles-pp.do_wait.kernel_waitid.__do_sys_waitid.do_syscall_64.entry_SYSCALL_64_after_hwframe
      4.54 ±100%      -2.8        1.78 ±173%  perf-profile.calltrace.cycles-pp.d_invalidate.proc_invalidate_siblings_dcache.release_task.wait_task_zombie.do_wait
      4.54 ±100%      -2.8        1.78 ±173%  perf-profile.calltrace.cycles-pp.release_task.wait_task_zombie.do_wait.kernel_waitid.__do_sys_waitid
      4.54 ±100%      -2.8        1.78 ±173%  perf-profile.calltrace.cycles-pp.proc_invalidate_siblings_dcache.release_task.wait_task_zombie.do_wait.kernel_waitid
      4.54 ±100%      -2.8        1.78 ±173%  perf-profile.calltrace.cycles-pp.shrink_dcache_parent.d_invalidate.proc_invalidate_siblings_dcache.release_task.wait_task_zombie
      4.54 ±100%      -2.8        1.78 ±173%  perf-profile.calltrace.cycles-pp.waitid
      4.54 ±100%      -2.8        1.78 ±173%  perf-profile.calltrace.cycles-pp.wait_task_zombie.do_wait.kernel_waitid.__do_sys_waitid.do_syscall_64
      4.54 ±100%      -2.5        2.08 ±173%  perf-profile.calltrace.cycles-pp.__x64_sys_mprotect.do_syscall_64.entry_SYSCALL_64_after_hwframe
      4.54 ±100%      -2.5        2.08 ±173%  perf-profile.calltrace.cycles-pp.do_mprotect_pkey.__x64_sys_mprotect.do_syscall_64.entry_SYSCALL_64_after_hwframe
      4.54 ±100%      -2.5        2.08 ±173%  perf-profile.calltrace.cycles-pp.__split_vma.mprotect_fixup.do_mprotect_pkey.__x64_sys_mprotect.do_syscall_64
      4.54 ±100%      -2.5        2.08 ±173%  perf-profile.calltrace.cycles-pp.__vma_adjust.__split_vma.mprotect_fixup.do_mprotect_pkey.__x64_sys_mprotect
      4.54 ±100%      -2.5        2.08 ±173%  perf-profile.calltrace.cycles-pp.mprotect_fixup.do_mprotect_pkey.__x64_sys_mprotect.do_syscall_64.entry_SYSCALL_64_after_hwframe
      4.54 ±100%      -2.5        2.08 ±173%  perf-profile.calltrace.cycles-pp.setlocale
      0.34 ±100%     +10.4       10.71 ± 57%  perf-profile.calltrace.cycles-pp.__x64_sys_exit_group.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.34 ±100%     +10.4       10.71 ± 57%  perf-profile.calltrace.cycles-pp.do_group_exit.__x64_sys_exit_group.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.34 ±100%     +10.4       10.71 ± 57%  perf-profile.calltrace.cycles-pp.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64.entry_SYSCALL_64_after_hwframe
     15.17 ±100%     -15.2        0.00        perf-profile.children.cycles-pp.write
     15.17 ±100%     -15.2        0.00        perf-profile.children.cycles-pp.ksys_write
     15.17 ±100%     -15.2        0.00        perf-profile.children.cycles-pp.vfs_write
     15.17 ±100%     -15.2        0.00        perf-profile.children.cycles-pp.new_sync_write
     15.17 ±100%     -15.2        0.00        perf-profile.children.cycles-pp.devkmsg_write.cold
     15.17 ±100%     -15.2        0.00        perf-profile.children.cycles-pp.devkmsg_emit
     15.17 ±100%     -15.2        0.00        perf-profile.children.cycles-pp.vprintk_emit
     15.17 ±100%     -15.2        0.00        perf-profile.children.cycles-pp.console_unlock
     24.48 ±100%     -14.2       10.29 ±173%  perf-profile.children.cycles-pp.worker_thread
     24.48 ±100%     -14.2       10.29 ±173%  perf-profile.children.cycles-pp.process_one_work
     24.48 ±100%     -14.2       10.29 ±173%  perf-profile.children.cycles-pp.drm_fb_helper_dirty_work
     24.48 ±100%     -13.9       10.59 ±173%  perf-profile.children.cycles-pp.ret_from_fork
     24.48 ±100%     -13.9       10.59 ±173%  perf-profile.children.cycles-pp.kthread
     24.14 ±100%     -13.8       10.29 ±173%  perf-profile.children.cycles-pp.memcpy_erms
     13.79 ±100%     -13.8        0.00        perf-profile.children.cycles-pp.serial8250_console_write
     13.11 ±100%     -13.1        0.00        perf-profile.children.cycles-pp.uart_console_write
      9.65 ±100%      -9.7        0.00        perf-profile.children.cycles-pp.wait_for_xmitr
      9.65 ±100%      -9.7        0.00        perf-profile.children.cycles-pp.io_serial_in
      8.96 ±100%      -9.0        0.00        perf-profile.children.cycles-pp.serial8250_console_putchar
      4.89 ± 85%      -4.9        0.00        perf-profile.children.cycles-pp.vma_interval_tree_remove
      4.54 ±100%      -4.5        0.00        perf-profile.children.cycles-pp.perf_output_begin
      4.54 ±100%      -4.5        0.00        perf-profile.children.cycles-pp.__tsearch
      4.54 ±100%      -4.5        0.00        perf-profile.children.cycles-pp.__dentry_kill
      4.54 ±100%      -4.5        0.00        perf-profile.children.cycles-pp.evict
      4.54 ±100%      -4.5        0.00        perf-profile.children.cycles-pp.perf_event_mmap
      4.54 ±100%      -4.5        0.00        perf-profile.children.cycles-pp.perf_iterate_sb
      4.54 ±100%      -4.5        0.00        perf-profile.children.cycles-pp.perf_event_mmap_output
      4.54 ±100%      -4.2        0.29 ±173%  perf-profile.children.cycles-pp.__alloc_pages_nodemask
      4.54 ±100%      -4.2        0.29 ±173%  perf-profile.children.cycles-pp.__handle_mm_fault
      4.54 ±100%      -4.2        0.29 ±173%  perf-profile.children.cycles-pp.alloc_pages_vma
      4.54 ±100%      -4.2        0.29 ±173%  perf-profile.children.cycles-pp.asm_exc_page_fault
      4.54 ±100%      -4.2        0.29 ±173%  perf-profile.children.cycles-pp.do_user_addr_fault
      4.54 ±100%      -4.2        0.29 ±173%  perf-profile.children.cycles-pp.do_anonymous_page
      4.54 ±100%      -4.2        0.29 ±173%  perf-profile.children.cycles-pp.exc_page_fault
      4.54 ±100%      -4.2        0.29 ±173%  perf-profile.children.cycles-pp.handle_mm_fault
      4.14 ±100%      -4.1        0.00        perf-profile.children.cycles-pp.io_serial_out
      4.54 ±100%      -2.8        1.78 ±173%  perf-profile.children.cycles-pp.__do_sys_waitid
      4.54 ±100%      -2.8        1.78 ±173%  perf-profile.children.cycles-pp.shrink_dentry_list
      4.54 ±100%      -2.8        1.78 ±173%  perf-profile.children.cycles-pp.kernel_waitid
      4.54 ±100%      -2.8        1.78 ±173%  perf-profile.children.cycles-pp.do_wait
      4.54 ±100%      -2.8        1.78 ±173%  perf-profile.children.cycles-pp.d_invalidate
      4.54 ±100%      -2.8        1.78 ±173%  perf-profile.children.cycles-pp.release_task
      4.54 ±100%      -2.8        1.78 ±173%  perf-profile.children.cycles-pp.proc_invalidate_siblings_dcache
      4.54 ±100%      -2.8        1.78 ±173%  perf-profile.children.cycles-pp.shrink_dcache_parent
      4.54 ±100%      -2.8        1.78 ±173%  perf-profile.children.cycles-pp.waitid
      4.54 ±100%      -2.8        1.78 ±173%  perf-profile.children.cycles-pp.wait_task_zombie
      4.54 ±100%      -2.5        2.08 ±173%  perf-profile.children.cycles-pp.__x64_sys_mprotect
      4.54 ±100%      -2.5        2.08 ±173%  perf-profile.children.cycles-pp.do_mprotect_pkey
      4.54 ±100%      -2.5        2.08 ±173%  perf-profile.children.cycles-pp.__vma_adjust
      4.54 ±100%      -2.5        2.08 ±173%  perf-profile.children.cycles-pp.mprotect_fixup
      4.54 ±100%      -2.5        2.08 ±173%  perf-profile.children.cycles-pp.setlocale
      0.34 ±100%     +10.4       10.71 ± 57%  perf-profile.children.cycles-pp.__x64_sys_exit_group
      0.69 ±100%     +20.4       21.12 ± 82%  perf-profile.children.cycles-pp.do_group_exit
      0.69 ±100%     +20.4       21.12 ± 82%  perf-profile.children.cycles-pp.do_exit
     24.14 ±100%     -14.1       10.00 ±173%  perf-profile.self.cycles-pp.memcpy_erms
      9.65 ±100%      -9.7        0.00        perf-profile.self.cycles-pp.io_serial_in
      4.89 ± 85%      -4.9        0.00        perf-profile.self.cycles-pp.vma_interval_tree_remove
      4.54 ±100%      -4.5        0.00        perf-profile.self.cycles-pp.perf_output_begin
      4.54 ±100%      -4.5        0.00        perf-profile.self.cycles-pp.__tsearch
      4.54 ±100%      -4.5        0.00        perf-profile.self.cycles-pp.setlocale
      4.54 ±100%      -4.5        0.00        perf-profile.self.cycles-pp.evict
      4.54 ±100%      -4.2        0.29 ±173%  perf-profile.self.cycles-pp.__alloc_pages_nodemask
      4.14 ±100%      -4.1        0.00        perf-profile.self.cycles-pp.io_serial_out



***************************************************************************************************
lkp-csl-2ap1: 192 threads Intel(R) Xeon(R) CPU @ 2.20GHz with 192G memory
=========================================================================================
bs/compiler/cpufreq_governor/disk/fs/ioengine/kconfig/nr_task/rootfs/runtime/rw/tbox_group/test_size/testcase/ucode:
  4k/gcc-9/performance/1SSD/xfs/sync/x86_64-rhel-8.3/32/debian-10.4-x86_64-20200603.cgz/300s/randwrite/lkp-csl-2ap1/256g/fio-basic/0x4003003

commit: 
  62d5313500 ("locking/rwsem: Enable reader optimistic lock stealing")
  c9847a7f94 ("locking/rwsem: Wake up all waiting readers if RWSEM_WAKE_READ_OWNED")

62d5313500ac58b6 c9847a7f94679e742710574a2a7 
---------------- --------------------------- 
       fail:runs  %reproduction    fail:runs
           |             |             |    
          0:2           11%           0:4     perf-profile.children.cycles-pp.error_entry
          0:2            8%           0:4     perf-profile.self.cycles-pp.error_entry
         %stddev     %change         %stddev
             \          |                \  
      0.03 ±  4%      +0.0        0.04 ±  5%  fio.latency_100us%
    310.22            +2.2%     316.95 ±  2%  fio.time.system_time
     80.27            -3.3%      77.63        fio.time.user_time
  14149913 ±  7%     -13.0%   12317496 ±  7%  meminfo.DirectMap2M
     20012 ±  5%      -8.9%      18226 ±  2%  meminfo.Writeback
     10114 ±  3%      -7.4%       9369 ±  5%  sched_debug.cpu.ttwu_count.stddev
     23907 ±  5%     -16.1%      20049 ±  6%  sched_debug.cpu.ttwu_local.max
     34.12            +1.5%      34.63        boot-time.boot
     29.29            +1.5%      29.72        boot-time.dhcp
      5692            +1.6%       5785        boot-time.idle
      1273            -2.3%       1244 ±  2%  perf-stat.i.cycles-between-cache-misses
      1253            -1.5%       1234        perf-stat.overall.cycles-between-cache-misses
      1255            -1.3%       1239        perf-stat.overall.instructions-per-iTLB-miss
   2249599 ±  8%    +196.0%    6658444 ± 27%  numa-numastat.node1.numa_foreign
  14201697 ±  4%     -32.4%    9595709 ± 11%  numa-numastat.node2.local_node
   3615071 ± 18%     -33.0%    2422719 ± 27%  numa-numastat.node2.numa_foreign
  14232753 ±  4%     -32.4%    9619099 ± 11%  numa-numastat.node2.numa_hit
   3648742 ± 14%    +111.0%    7698381 ± 17%  numa-numastat.node2.numa_miss
   3679798 ± 14%    +109.8%    7721778 ± 17%  numa-numastat.node2.other_node
    565431 ± 97%     -98.3%       9626 ± 27%  numa-meminfo.node0.Mapped
    562998 ± 98%     -99.0%       5571 ± 71%  numa-meminfo.node0.Shmem
      5781 ±  6%      -7.4%       5353 ±  7%  numa-meminfo.node0.Writeback
      6824 ±  8%    +770.6%      59416 ± 99%  numa-meminfo.node2.AnonPages
      6921 ±  8%   +8832.4%     618210 ± 85%  numa-meminfo.node2.Inactive(anon)
      6229 ±  3%     +17.1%       7294 ±  6%  numa-meminfo.node2.KernelStack
    221.00 ± 26%   +1132.2%       2723 ± 67%  numa-meminfo.node2.PageTables
   7779536 ±  3%      -7.2%    7221783 ±  5%  numa-meminfo.node3.Dirty
    916.00 ±  8%     -16.1%     768.25 ± 12%  proc-vmstat.kswapd_high_wmark_hit_quickly
    302394            -0.9%     299680        proc-vmstat.nr_slab_unreclaimable
  16262663 ±  3%     +25.8%   20453611 ±  9%  proc-vmstat.numa_foreign
  53313089            -7.9%   49075650 ±  3%  proc-vmstat.numa_hit
  53219629            -8.0%   48981929 ±  3%  proc-vmstat.numa_local
  16262663 ±  3%     +25.8%   20453611 ±  9%  proc-vmstat.numa_miss
  16356124 ±  3%     +25.6%   20547332 ±  9%  proc-vmstat.numa_other
      2589 ±  3%      -8.4%       2371 ±  8%  proc-vmstat.pageoutrun
      3178           -10.7%       2837 ±  4%  proc-vmstat.pgactivate
    464640           -16.5%     387918 ±  4%  proc-vmstat.pgalloc_dma32
  28308854            -2.0%   27733269        proc-vmstat.pgfree
    140746 ± 98%     -99.0%       1392 ± 71%  numa-vmstat.node0.nr_shmem
    611995 ±  8%    +329.7%    2629633 ± 30%  numa-vmstat.node1.numa_foreign
      1706 ±  8%    +770.5%      14854 ± 99%  numa-vmstat.node2.nr_anon_pages
      1731 ±  8%   +8828.6%     154553 ± 85%  numa-vmstat.node2.nr_inactive_anon
      6236 ±  3%     +16.9%       7290 ±  6%  numa-vmstat.node2.nr_kernel_stack
     53.50 ± 27%   +1166.4%     677.50 ± 68%  numa-vmstat.node2.nr_page_table_pages
      1276 ± 12%     -18.7%       1037 ± 18%  numa-vmstat.node2.nr_writeback
      1733 ±  8%   +8818.5%     154557 ± 85%  numa-vmstat.node2.nr_zone_inactive_anon
   8117299 ±  7%     -30.7%    5628762 ± 11%  numa-vmstat.node2.numa_hit
   8000798 ±  7%     -31.0%    5519712 ± 11%  numa-vmstat.node2.numa_local
   1945012 ±  3%      -7.2%    1804575 ±  5%  numa-vmstat.node3.nr_dirty
   1945821 ±  3%      -7.2%    1805557 ±  5%  numa-vmstat.node3.nr_zone_write_pending
     21294 ±  6%     -10.7%      19009 ± 10%  softirqs.CPU121.RCU
      8982 ± 60%     -59.2%       3668 ±151%  softirqs.CPU13.NET_RX
     21708            -9.8%      19575 ±  5%  softirqs.CPU160.RCU
     21280 ±  4%      -9.3%      19291 ±  5%  softirqs.CPU168.RCU
     21250 ±  2%     -11.5%      18811 ±  4%  softirqs.CPU169.RCU
     20674 ±  5%      -7.8%      19066 ±  3%  softirqs.CPU170.RCU
     19940 ±  5%      -7.3%      18493 ±  4%  softirqs.CPU172.RCU
     20439 ±  6%      -7.2%      18962 ±  6%  softirqs.CPU173.RCU
     20464 ±  5%      -7.9%      18847 ±  4%  softirqs.CPU174.RCU
     20260 ±  6%      -7.7%      18706 ±  5%  softirqs.CPU175.RCU
     22472 ±  4%     -10.4%      20138 ±  5%  softirqs.CPU176.RCU
     22274 ±  5%      -8.8%      20307 ±  6%  softirqs.CPU177.RCU
     22391 ±  4%      -9.7%      20210 ±  5%  softirqs.CPU178.RCU
     22638 ±  2%     -11.4%      20060 ±  5%  softirqs.CPU179.RCU
     21904 ±  6%      -9.2%      19882 ±  5%  softirqs.CPU180.RCU
     21495 ±  6%      -8.3%      19705 ±  5%  softirqs.CPU181.RCU
     21991 ±  5%      -7.5%      20334 ±  5%  softirqs.CPU183.RCU
     21678 ±  5%      -6.5%      20277 ±  4%  softirqs.CPU185.RCU
     22661 ±  8%     -11.1%      20139 ±  5%  softirqs.CPU187.RCU
     24764           -16.2%      20750 ±  7%  softirqs.CPU24.RCU
     22860 ±  7%      -9.9%      20606 ±  3%  softirqs.CPU64.RCU
      8947 ± 12%    +137.3%      21230 ± 40%  softirqs.CPU7.SCHED
     23032 ±  3%      -9.8%      20770 ±  5%  softirqs.CPU72.RCU
     22208 ±  3%     -10.8%      19814 ±  6%  softirqs.CPU73.RCU
     22009 ±  4%     -11.9%      19390 ±  8%  softirqs.CPU83.RCU
     21939 ±  5%      -7.0%      20400 ±  3%  softirqs.CPU90.RCU
     21959 ±  5%      -7.2%      20371 ±  4%  softirqs.CPU91.RCU
     22777           -11.0%      20263 ±  3%  softirqs.CPU92.RCU
     21811 ±  5%      -6.3%      20446 ±  5%  softirqs.CPU94.RCU
     48.90 ±  2%      -2.7       46.17 ±  2%  perf-profile.calltrace.cycles-pp.cpuidle_enter.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     47.31 ±  2%      -2.6       44.69        perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry.start_secondary
     54.66 ±  4%      -2.4       52.27 ±  2%  perf-profile.calltrace.cycles-pp.secondary_startup_64_no_verify
      2.45 ±  8%      -0.3        2.10 ±  6%  perf-profile.calltrace.cycles-pp.tick_sched_timer.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.asm_call_sysvec_on_stack
      1.67 ±  5%      -0.2        1.50 ±  2%  perf-profile.calltrace.cycles-pp.update_process_times.tick_sched_handle.tick_sched_timer.__hrtimer_run_queues.hrtimer_interrupt
      1.71 ±  5%      -0.2        1.55 ±  3%  perf-profile.calltrace.cycles-pp.tick_sched_handle.tick_sched_timer.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt
      0.91 ±  8%      -0.1        0.82 ±  4%  perf-profile.calltrace.cycles-pp.scheduler_tick.update_process_times.tick_sched_handle.tick_sched_timer.__hrtimer_run_queues
     49.23 ±  2%      -2.6       46.58 ±  2%  perf-profile.children.cycles-pp.cpuidle_enter_state
     49.25 ±  2%      -2.6       46.61 ±  2%  perf-profile.children.cycles-pp.cpuidle_enter
     54.66 ±  4%      -2.4       52.27 ±  2%  perf-profile.children.cycles-pp.secondary_startup_64_no_verify
     54.66 ±  4%      -2.4       52.27 ±  2%  perf-profile.children.cycles-pp.cpu_startup_entry
     54.66 ±  4%      -2.4       52.27 ±  2%  perf-profile.children.cycles-pp.do_idle
      1.73 ±  6%      -0.1        1.58 ±  2%  perf-profile.children.cycles-pp.update_process_times
      1.76 ±  6%      -0.1        1.63 ±  3%  perf-profile.children.cycles-pp.tick_sched_handle
      0.56 ±  5%      -0.1        0.47 ± 13%  perf-profile.children.cycles-pp.lapic_next_deadline
      0.96 ±  8%      -0.1        0.87 ±  4%  perf-profile.children.cycles-pp.scheduler_tick
      0.11 ± 18%      -0.1        0.03 ±105%  perf-profile.children.cycles-pp.put_cpu_partial
      0.20 ± 19%      -0.1        0.13 ± 14%  perf-profile.children.cycles-pp.xfs_btree_lshift
      0.43 ±  8%      -0.0        0.38 ±  4%  perf-profile.children.cycles-pp.irqtime_account_irq
      0.24 ±  4%      -0.0        0.20 ± 11%  perf-profile.children.cycles-pp.rcu_sched_clock_irq
      0.07 ± 20%      -0.0        0.04 ± 58%  perf-profile.children.cycles-pp.timekeeping_advance
      0.06            -0.0        0.03 ±100%  perf-profile.children.cycles-pp.native_apic_mem_write
      0.08 ±  6%      -0.0        0.04 ± 59%  perf-profile.children.cycles-pp.delay_tsc
      0.07            -0.0        0.04 ± 58%  perf-profile.children.cycles-pp.rcu_read_unlock_strict
      0.17 ±  5%      -0.0        0.14 ± 10%  perf-profile.children.cycles-pp._xfs_trans_bjoin
      0.28 ±  5%      -0.0        0.25 ±  7%  perf-profile.children.cycles-pp.calc_global_load_tick
      0.11 ±  4%      -0.0        0.09 ±  7%  perf-profile.children.cycles-pp.xfs_errortag_test
      0.05            +0.0        0.06        perf-profile.children.cycles-pp.menu_reflect
      0.08 ±  5%      +0.0        0.11 ±  9%  perf-profile.children.cycles-pp.xfs_end_bio
      0.06 ± 16%      +0.0        0.09        perf-profile.children.cycles-pp.xfs_iext_insert
      0.16            +0.0        0.19 ±  7%  perf-profile.children.cycles-pp.xfs_trans_log_buf
      0.07 ±  7%      +0.0        0.10 ± 11%  perf-profile.children.cycles-pp.run_local_timers
      0.06 ±  9%      +0.0        0.09 ± 13%  perf-profile.children.cycles-pp.up_read
      0.09            +0.0        0.12 ± 23%  perf-profile.children.cycles-pp.node_dirty_ok
      0.29 ±  6%      +0.0        0.33 ±  2%  perf-profile.children.cycles-pp.xfs_inode_item_format
      0.00            +0.1        0.06 ± 15%  perf-profile.children.cycles-pp.irqentry_exit
      0.23            +0.1        0.29 ±  6%  perf-profile.children.cycles-pp.xfs_btree_insrec
      0.25 ±  4%      +0.1        0.31 ±  6%  perf-profile.children.cycles-pp.xfs_btree_insert
      0.57 ±  6%      +0.1        0.68 ±  5%  perf-profile.children.cycles-pp.kmem_cache_alloc
      0.44 ±  5%      +0.1        0.57 ±  9%  perf-profile.children.cycles-pp.get_page_from_freelist
      0.52 ±  4%      +0.1        0.64 ±  8%  perf-profile.children.cycles-pp.__alloc_pages_nodemask
      0.55 ±  5%      -0.1        0.47 ± 13%  perf-profile.self.cycles-pp.lapic_next_deadline
      0.34 ±  4%      -0.1        0.27 ± 15%  perf-profile.self.cycles-pp.update_process_times
      0.71            -0.1        0.66 ±  4%  perf-profile.self.cycles-pp._raw_spin_unlock_irqrestore
      0.18 ± 13%      -0.0        0.15 ± 10%  perf-profile.self.cycles-pp.blk_attempt_plug_merge
      0.22 ±  6%      -0.0        0.18 ±  8%  perf-profile.self.cycles-pp.rcu_sched_clock_irq
      0.19 ± 15%      -0.0        0.16 ±  8%  perf-profile.self.cycles-pp.arch_scale_freq_tick
      0.16 ±  9%      -0.0        0.13 ±  6%  perf-profile.self.cycles-pp.tick_sched_timer
      0.08 ±  6%      -0.0        0.04 ± 59%  perf-profile.self.cycles-pp.delay_tsc
      0.09 ± 11%      -0.0        0.07 ± 13%  perf-profile.self.cycles-pp._xfs_trans_bjoin
      0.13 ±  7%      -0.0        0.11 ±  6%  perf-profile.self.cycles-pp.rebalance_domains
      0.10 ±  5%      -0.0        0.08 ±  6%  perf-profile.self.cycles-pp.xfs_errortag_test
      0.13            -0.0        0.11 ±  7%  perf-profile.self.cycles-pp.asm_sysvec_apic_timer_interrupt
      0.10            -0.0        0.09 ±  5%  perf-profile.self.cycles-pp.xfs_btree_rec_offset
      0.11 ±  4%      -0.0        0.10 ±  7%  perf-profile.self.cycles-pp._raw_spin_lock_irq
      0.05            +0.0        0.07 ±  7%  perf-profile.self.cycles-pp.blk_attempt_bio_merge
      0.05            +0.0        0.07 ±  7%  perf-profile.self.cycles-pp.xfs_iext_insert
      0.12            +0.0        0.14 ±  3%  perf-profile.self.cycles-pp.xfs_trans_dirty_buf
      0.06 ±  9%      +0.0        0.08 ±  6%  perf-profile.self.cycles-pp.up_read
      0.05            +0.0        0.08 ± 14%  perf-profile.self.cycles-pp.run_local_timers
      0.20 ±  2%      +0.1        0.26 ± 15%  perf-profile.self.cycles-pp.clear_page_dirty_for_io
     17886 ± 60%     -61.2%       6932 ±151%  interrupts.34:PCI-MSI.524292-edge.eth0-TxRx-3
    178.50 ±  7%     -54.3%      81.50 ± 88%  interrupts.CPU101.TLB:TLB_shootdowns
    179.00 ±  7%     -54.1%      82.25 ± 87%  interrupts.CPU103.TLB:TLB_shootdowns
    186.00           -52.3%      88.75 ± 82%  interrupts.CPU104.TLB:TLB_shootdowns
    188.50           -55.2%      84.50 ± 88%  interrupts.CPU105.TLB:TLB_shootdowns
    556.00           -39.6%     336.00 ± 59%  interrupts.CPU106.RES:Rescheduling_interrupts
    222.50 ± 14%     -59.8%      89.50 ± 80%  interrupts.CPU106.TLB:TLB_shootdowns
    179.00 ±  6%     -50.4%      88.75 ± 82%  interrupts.CPU107.TLB:TLB_shootdowns
    680.50 ± 16%     -37.5%     425.25 ± 21%  interrupts.CPU108.NMI:Non-maskable_interrupts
    680.50 ± 16%     -37.5%     425.25 ± 21%  interrupts.CPU108.PMI:Performance_monitoring_interrupts
    107.00 ± 57%     -59.1%      43.75 ±145%  interrupts.CPU11.TLB:TLB_shootdowns
    191.50           -55.1%      86.00 ± 87%  interrupts.CPU110.TLB:TLB_shootdowns
    701.50 ± 62%     -70.1%     209.50 ± 35%  interrupts.CPU111.NMI:Non-maskable_interrupts
    701.50 ± 62%     -70.1%     209.50 ± 35%  interrupts.CPU111.PMI:Performance_monitoring_interrupts
    187.00           -54.4%      85.25 ± 88%  interrupts.CPU111.TLB:TLB_shootdowns
    181.00 ±  4%     -51.1%      88.50 ± 81%  interrupts.CPU112.TLB:TLB_shootdowns
    184.50 ±  2%     -54.9%      83.25 ± 89%  interrupts.CPU114.TLB:TLB_shootdowns
    174.00 ±  9%     -52.6%      82.50 ± 87%  interrupts.CPU116.TLB:TLB_shootdowns
    681.00 ± 37%     -69.6%     207.00 ± 48%  interrupts.CPU117.NMI:Non-maskable_interrupts
    681.00 ± 37%     -69.6%     207.00 ± 48%  interrupts.CPU117.PMI:Performance_monitoring_interrupts
    194.50 ±  9%     -54.8%      88.00 ± 82%  interrupts.CPU117.TLB:TLB_shootdowns
    189.00           -50.4%      93.75 ± 69%  interrupts.CPU118.TLB:TLB_shootdowns
     59.50 ± 88%    +200.0%     178.50 ± 32%  interrupts.CPU121.TLB:TLB_shootdowns
    246.00           -42.9%     140.50 ± 61%  interrupts.CPU124.NMI:Non-maskable_interrupts
    246.00           -42.9%     140.50 ± 61%  interrupts.CPU124.PMI:Performance_monitoring_interrupts
     17886 ± 60%     -61.2%       6932 ±151%  interrupts.CPU13.34:PCI-MSI.524292-edge.eth0-TxRx-3
     96.00 ± 67%     -65.6%      33.00 ±167%  interrupts.CPU13.TLB:TLB_shootdowns
    109.50 ± 15%     -30.1%      76.50 ± 38%  interrupts.CPU136.NMI:Non-maskable_interrupts
    109.50 ± 15%     -30.1%      76.50 ± 38%  interrupts.CPU136.PMI:Performance_monitoring_interrupts
    102.50 ±  7%     -30.5%      71.25 ± 22%  interrupts.CPU137.NMI:Non-maskable_interrupts
    102.50 ±  7%     -30.5%      71.25 ± 22%  interrupts.CPU137.PMI:Performance_monitoring_interrupts
    101.00 ±  6%    +131.2%     233.50 ± 52%  interrupts.CPU143.NMI:Non-maskable_interrupts
    101.00 ±  6%    +131.2%     233.50 ± 52%  interrupts.CPU143.PMI:Performance_monitoring_interrupts
    497.00 ± 47%     -63.4%     181.75 ± 45%  interrupts.CPU144.NMI:Non-maskable_interrupts
    497.00 ± 47%     -63.4%     181.75 ± 45%  interrupts.CPU144.PMI:Performance_monitoring_interrupts
    336.00 ± 18%     -42.8%     192.25 ± 25%  interrupts.CPU145.NMI:Non-maskable_interrupts
    336.00 ± 18%     -42.8%     192.25 ± 25%  interrupts.CPU145.PMI:Performance_monitoring_interrupts
    321.50 ± 22%     -55.5%     143.00 ± 29%  interrupts.CPU147.NMI:Non-maskable_interrupts
    321.50 ± 22%     -55.5%     143.00 ± 29%  interrupts.CPU147.PMI:Performance_monitoring_interrupts
    103.00 ±  6%     +72.1%     177.25 ± 37%  interrupts.CPU149.NMI:Non-maskable_interrupts
    103.00 ±  6%     +72.1%     177.25 ± 37%  interrupts.CPU149.PMI:Performance_monitoring_interrupts
     82.50 ±  3%     +84.8%     152.50 ± 40%  interrupts.CPU149.TLB:TLB_shootdowns
    733.50 ± 32%     -56.9%     316.50 ± 46%  interrupts.CPU15.NMI:Non-maskable_interrupts
    733.50 ± 32%     -56.9%     316.50 ± 46%  interrupts.CPU15.PMI:Performance_monitoring_interrupts
      3.00 ± 33%   +1933.3%      61.00 ± 68%  interrupts.CPU152.RES:Rescheduling_interrupts
    151.50 ± 26%     -40.9%      89.50 ± 26%  interrupts.CPU153.NMI:Non-maskable_interrupts
    151.50 ± 26%     -40.9%      89.50 ± 26%  interrupts.CPU153.PMI:Performance_monitoring_interrupts
    111.50 ±  2%     +67.9%     187.25 ± 27%  interrupts.CPU158.NMI:Non-maskable_interrupts
    111.50 ±  2%     +67.9%     187.25 ± 27%  interrupts.CPU158.PMI:Performance_monitoring_interrupts
     87.50 ± 22%     +92.0%     168.00 ± 31%  interrupts.CPU159.TLB:TLB_shootdowns
    175.50           -59.5%      71.00 ± 57%  interrupts.CPU16.RES:Rescheduling_interrupts
    244.00 ±  7%     -55.0%     109.75 ±  9%  interrupts.CPU160.NMI:Non-maskable_interrupts
    244.00 ±  7%     -55.0%     109.75 ±  9%  interrupts.CPU160.PMI:Performance_monitoring_interrupts
    311.00 ± 24%     -71.1%      90.00 ± 23%  interrupts.CPU163.NMI:Non-maskable_interrupts
    311.00 ± 24%     -71.1%      90.00 ± 23%  interrupts.CPU163.PMI:Performance_monitoring_interrupts
    317.00 ± 23%     -57.3%     135.50 ± 58%  interrupts.CPU164.NMI:Non-maskable_interrupts
    317.00 ± 23%     -57.3%     135.50 ± 58%  interrupts.CPU164.PMI:Performance_monitoring_interrupts
    101.00 ± 80%     -51.5%      49.00 ±145%  interrupts.CPU17.TLB:TLB_shootdowns
    100.50 ± 44%    +233.1%     334.75 ± 29%  interrupts.CPU170.NMI:Non-maskable_interrupts
    100.50 ± 44%    +233.1%     334.75 ± 29%  interrupts.CPU170.PMI:Performance_monitoring_interrupts
     68.00 ± 33%    +126.8%     154.25 ± 30%  interrupts.CPU172.NMI:Non-maskable_interrupts
     68.00 ± 33%    +126.8%     154.25 ± 30%  interrupts.CPU172.PMI:Performance_monitoring_interrupts
    130.00 ± 40%     -65.0%      45.50 ±142%  interrupts.CPU18.TLB:TLB_shootdowns
     79.50 ± 44%    +255.3%     282.50 ± 27%  interrupts.CPU184.NMI:Non-maskable_interrupts
     79.50 ± 44%    +255.3%     282.50 ± 27%  interrupts.CPU184.PMI:Performance_monitoring_interrupts
    714.50 ± 21%     -67.9%     229.50 ± 32%  interrupts.CPU21.NMI:Non-maskable_interrupts
    714.50 ± 21%     -67.9%     229.50 ± 32%  interrupts.CPU21.PMI:Performance_monitoring_interrupts
    159.50 ± 20%     -59.1%      65.25 ± 81%  interrupts.CPU22.TLB:TLB_shootdowns
    118.00 ± 14%     -53.8%      54.50 ± 56%  interrupts.CPU23.RES:Rescheduling_interrupts
    312.00 ± 19%    +109.9%     654.75 ± 28%  interrupts.CPU24.NMI:Non-maskable_interrupts
    312.00 ± 19%    +109.9%     654.75 ± 28%  interrupts.CPU24.PMI:Performance_monitoring_interrupts
     16.50 ± 81%    +943.9%     172.25 ± 51%  interrupts.CPU24.TLB:TLB_shootdowns
    254.50          +143.4%     619.50 ± 45%  interrupts.CPU25.NMI:Non-maskable_interrupts
    254.50          +143.4%     619.50 ± 45%  interrupts.CPU25.PMI:Performance_monitoring_interrupts
    742.00 ± 19%     -41.4%     435.00 ± 56%  interrupts.CPU3.NMI:Non-maskable_interrupts
    742.00 ± 19%     -41.4%     435.00 ± 56%  interrupts.CPU3.PMI:Performance_monitoring_interrupts
     21.00 ± 57%    +409.5%     107.00 ± 61%  interrupts.CPU37.TLB:TLB_shootdowns
    540.00 ± 21%     -46.0%     291.75 ± 43%  interrupts.CPU48.NMI:Non-maskable_interrupts
    540.00 ± 21%     -46.0%     291.75 ± 43%  interrupts.CPU48.PMI:Performance_monitoring_interrupts
    111.00 ± 54%     -65.1%      38.75 ±136%  interrupts.CPU5.TLB:TLB_shootdowns
    103.50 ±  8%    +137.9%     246.25 ± 50%  interrupts.CPU53.NMI:Non-maskable_interrupts
    103.50 ±  8%    +137.9%     246.25 ± 50%  interrupts.CPU53.PMI:Performance_monitoring_interrupts
    123.50 ±  9%     -16.4%     103.25 ±  8%  interrupts.CPU57.NMI:Non-maskable_interrupts
    123.50 ±  9%     -16.4%     103.25 ±  8%  interrupts.CPU57.PMI:Performance_monitoring_interrupts
    105.50 ± 46%     -92.7%       7.75 ± 68%  interrupts.CPU6.TLB:TLB_shootdowns
     82.00 ± 35%    +247.6%     285.00 ± 44%  interrupts.CPU62.NMI:Non-maskable_interrupts
     82.00 ± 35%    +247.6%     285.00 ± 44%  interrupts.CPU62.PMI:Performance_monitoring_interrupts
     29.50 ± 69%    +341.5%     130.25 ± 43%  interrupts.CPU63.TLB:TLB_shootdowns
    379.50 ±  3%     -71.5%     108.25 ±  6%  interrupts.CPU64.NMI:Non-maskable_interrupts
    379.50 ±  3%     -71.5%     108.25 ±  6%  interrupts.CPU64.PMI:Performance_monitoring_interrupts
    342.00 ± 18%     -69.9%     103.00 ±  9%  interrupts.CPU67.NMI:Non-maskable_interrupts
    342.00 ± 18%     -69.9%     103.00 ±  9%  interrupts.CPU67.PMI:Performance_monitoring_interrupts
    105.50 ± 47%     -68.2%      33.50 ± 85%  interrupts.CPU7.TLB:TLB_shootdowns
      7.50 ±  6%    +960.0%      79.50 ±144%  interrupts.CPU72.RES:Rescheduling_interrupts
    148.00 ± 27%    +137.5%     351.50 ± 16%  interrupts.CPU74.NMI:Non-maskable_interrupts
    148.00 ± 27%    +137.5%     351.50 ± 16%  interrupts.CPU74.PMI:Performance_monitoring_interrupts
    407.50 ±  4%     +77.5%     723.50 ± 35%  interrupts.CPU8.NMI:Non-maskable_interrupts
    407.50 ±  4%     +77.5%     723.50 ± 35%  interrupts.CPU8.PMI:Performance_monitoring_interrupts
    151.50 ±  9%     -69.8%      45.75 ±139%  interrupts.CPU8.TLB:TLB_shootdowns
    101.50 ± 12%    +192.4%     296.75 ± 39%  interrupts.CPU88.NMI:Non-maskable_interrupts
    101.50 ± 12%    +192.4%     296.75 ± 39%  interrupts.CPU88.PMI:Performance_monitoring_interrupts
      1.00 ±100%   +3975.0%      40.75 ±150%  interrupts.CPU94.RES:Rescheduling_interrupts
    167.00 ± 16%     -56.7%      72.25 ± 77%  interrupts.CPU96.TLB:TLB_shootdowns
    474.50 ± 62%     -81.1%      89.75 ± 76%  interrupts.CPU97.TLB:TLB_shootdowns
    191.00           -52.7%      90.25 ± 75%  interrupts.CPU98.TLB:TLB_shootdowns





Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


Thanks,
Oliver Sang


--IJpNTDwzlM2Ie8A6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="config-5.10.0-rc3-00005-gc9847a7f9467"

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

--IJpNTDwzlM2Ie8A6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=job-script

#!/bin/sh

export_top_env()
{
	export suite='aim7'
	export testcase='aim7'
	export category='benchmark'
	export job_origin='/lkp-src/allot/cyclic:p1:linux-devel:devel-hourly/lkp-csl-2sp2/aim7-fs-raid.yaml'
	export queue_cmdline_keys='branch
commit
queue_at_least_once'
	export queue='validate'
	export testbox='lkp-csl-2sp2'
	export tbox_group='lkp-csl-2sp2'
	export kconfig='x86_64-rhel-8.3'
	export submit_id='5fb9bc866973a2293f923c5b'
	export job_file='/lkp/jobs/scheduled/lkp-csl-2sp2/aim7-performance-4BRD_12G-f2fs-100-RAID0-sync_disk_rw-ucode=0x4003003-monitor=6e02c248-debian-10.4-x86_64-20200603.cgz-c9847a7f9-20201122-10559-1augofb-3.yaml'
	export id='000db79f232059246640a711806f456f7d3782d9'
	export queuer_version='/lkp-src'
	export model='Cascade Lake'
	export nr_node=2
	export nr_cpu=96
	export memory='128G'
	export nr_hdd_partitions=1
	export nr_ssd_partitions=2
	export ssd_partitions='/dev/nvme0n1 /dev/nvme1n1'
	export hdd_partitions='/dev/disk/by-id/ata-Hitachi_HTS543216L9SA00_090307FB2201VCDY8ZNA-part1'
	export swap_partitions='LABEL=SWAP'
	export rootfs_partition='/dev/disk/by-id/ata-INTEL_SSDSC2BA800G4_BTHV410402FN800OGN-part4'
	export kernel_cmdline_hw='acpi_rsdp=0x68b85014'
	export brand='Intel(R) Xeon(R) Platinum 8260L CPU @ 2.40GHz'
	export timeout='1h'
	export commit='c9847a7f94679e742710574a2a7fee1c30c5ecf0'
	export need_kconfig_hw='CONFIG_IGB=y
CONFIG_SATA_AHCI
CONFIG_BLK_DEV_NVME'
	export ucode='0x4003003'
	export need_kconfig='CONFIG_BLK_DEV_RAM=m
CONFIG_BLK_DEV=y
CONFIG_BLOCK=y
CONFIG_MD_RAID0
CONFIG_F2FS_FS'
	export enqueue_time='2020-11-22 09:19:02 +0800'
	export _id='5fb9bc886973a2293f923c5c'
	export _rt='/result/aim7/performance-4BRD_12G-f2fs-100-RAID0-sync_disk_rw-ucode=0x4003003-monitor=6e02c248/lkp-csl-2sp2/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/c9847a7f94679e742710574a2a7fee1c30c5ecf0'
	export user='lkp'
	export compiler='gcc-9'
	export head_commit='d026633165036431cb53fd5c50f39d2cb7f5e913'
	export base_commit='09162bc32c880a791c6c0668ce0745cf7958f576'
	export branch='linux-review/Waiman-Long/locking-rwsem-Rework-reader-optimistic-spinning/20201121-122118'
	export rootfs='debian-10.4-x86_64-20200603.cgz'
	export monitor_sha='6e02c248'
	export result_root='/result/aim7/performance-4BRD_12G-f2fs-100-RAID0-sync_disk_rw-ucode=0x4003003-monitor=6e02c248/lkp-csl-2sp2/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/c9847a7f94679e742710574a2a7fee1c30c5ecf0/3'
	export scheduler_version='/lkp/lkp/.src-20201120-230606'
	export LKP_SERVER='internal-lkp-server'
	export arch='x86_64'
	export max_uptime=3600
	export initrd='/osimage/debian/debian-10.4-x86_64-20200603.cgz'
	export bootloader_append='root=/dev/ram0
user=lkp
job=/lkp/jobs/scheduled/lkp-csl-2sp2/aim7-performance-4BRD_12G-f2fs-100-RAID0-sync_disk_rw-ucode=0x4003003-monitor=6e02c248-debian-10.4-x86_64-20200603.cgz-c9847a7f9-20201122-10559-1augofb-3.yaml
ARCH=x86_64
kconfig=x86_64-rhel-8.3
branch=linux-review/Waiman-Long/locking-rwsem-Rework-reader-optimistic-spinning/20201121-122118
commit=c9847a7f94679e742710574a2a7fee1c30c5ecf0
BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3/gcc-9/c9847a7f94679e742710574a2a7fee1c30c5ecf0/vmlinuz-5.10.0-rc3-00005-gc9847a7f9467
acpi_rsdp=0x68b85014
max_uptime=3600
RESULT_ROOT=/result/aim7/performance-4BRD_12G-f2fs-100-RAID0-sync_disk_rw-ucode=0x4003003-monitor=6e02c248/lkp-csl-2sp2/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/c9847a7f94679e742710574a2a7fee1c30c5ecf0/3
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
	export modules_initrd='/pkg/linux/x86_64-rhel-8.3/gcc-9/c9847a7f94679e742710574a2a7fee1c30c5ecf0/modules.cgz'
	export bm_initrd='/osimage/deps/debian-10.4-x86_64-20200603.cgz/run-ipconfig_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/lkp_20200709.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/rsync-rootfs_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/perf_20200723.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/perf-x86_64-eccc87672492-1_20201111.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/md_20200714.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/fs_20200714.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/aim7-x86_64-1-1_20201007.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/mpstat_20200714.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/sar-x86_64-34c92ae-1_20200702.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/hw_20200715.cgz'
	export ucode_initrd='/osimage/ucode/intel-ucode-20201117.cgz'
	export lkp_initrd='/osimage/user/lkp/lkp-x86_64.cgz'
	export site='inn'
	export LKP_CGI_PORT=80
	export LKP_CIFS_PORT=139
	export last_kernel='5.10.0-rc4-07335-gd02663316503'
	export repeat_to=4
	export schedule_notify_address=
	export queue_at_least_once=1
	export kernel='/pkg/linux/x86_64-rhel-8.3/gcc-9/c9847a7f94679e742710574a2a7fee1c30c5ecf0/vmlinuz-5.10.0-rc3-00005-gc9847a7f9467'
	export dequeue_time='2020-11-22 11:35:38 +0800'
	export job_initrd='/lkp/jobs/scheduled/lkp-csl-2sp2/aim7-performance-4BRD_12G-f2fs-100-RAID0-sync_disk_rw-ucode=0x4003003-monitor=6e02c248-debian-10.4-x86_64-20200603.cgz-c9847a7f9-20201122-10559-1augofb-3.cgz'

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

	run_setup nr_brd=4 ramdisk_size=12884901888 $LKP_SRC/setup/disk

	run_setup raid_level='raid0' $LKP_SRC/setup/md

	run_setup fs='f2fs' $LKP_SRC/setup/fs

	run_setup $LKP_SRC/setup/cpufreq_governor 'performance'

	run_monitor delay=15 $LKP_SRC/monitors/no-stdout/wrapper perf-profile
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

	run_test test='sync_disk_rw' load=100 $LKP_SRC/tests/wrapper aim7
}

extract_stats()
{
	export stats_part_begin=
	export stats_part_end=

	$LKP_SRC/stats/wrapper perf-profile
	$LKP_SRC/stats/wrapper aim7
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

	$LKP_SRC/stats/wrapper time aim7.time
	$LKP_SRC/stats/wrapper dmesg
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper last_state
	$LKP_SRC/stats/wrapper stderr
	$LKP_SRC/stats/wrapper time
}

"$@"

--IJpNTDwzlM2Ie8A6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="job.yaml"

---

#! jobs/aim7-fs-raid.yaml
suite: aim7
testcase: aim7
category: benchmark
perf-profile:
  delay: 15
disk: 4BRD_12G
md: RAID0
fs: f2fs
aim7:
  test: sync_disk_rw
  load: 100
job_origin: "/lkp-src/allot/cyclic:p1:linux-devel:devel-hourly/lkp-csl-2sp2/aim7-fs-raid.yaml"

#! queue options
queue_cmdline_keys:
- branch
- commit
- queue_at_least_once
queue: bisect
testbox: lkp-csl-2sp2
tbox_group: lkp-csl-2sp2
kconfig: x86_64-rhel-8.3
submit_id: 5fb9b0a46973a227841d1f70
job_file: "/lkp/jobs/scheduled/lkp-csl-2sp2/aim7-performance-4BRD_12G-f2fs-100-RAID0-sync_disk_rw-ucode=0x4003003-monitor=6e02c248-debian-10.4-x86_64-20200603.cgz-c9847a7f9-20201122-10116-xipnz4-1.yaml"
id: db3ebbddb275fec04227a94ec909a1ab87e517c7
queuer_version: "/lkp-src"

#! hosts/lkp-csl-2sp2
model: Cascade Lake
nr_node: 2
nr_cpu: 96
memory: 128G
nr_hdd_partitions: 1
nr_ssd_partitions: 2
ssd_partitions: "/dev/nvme0n1 /dev/nvme1n1"
hdd_partitions: "/dev/disk/by-id/ata-Hitachi_HTS543216L9SA00_090307FB2201VCDY8ZNA-part1"
swap_partitions: LABEL=SWAP
rootfs_partition: "/dev/disk/by-id/ata-INTEL_SSDSC2BA800G4_BTHV410402FN800OGN-part4"
kernel_cmdline_hw: acpi_rsdp=0x68b85014
brand: Intel(R) Xeon(R) Platinum 8260L CPU @ 2.40GHz

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

#! include/aim7
timeout: 1h

#! include/queue/cyclic
commit: c9847a7f94679e742710574a2a7fee1c30c5ecf0

#! include/testbox/lkp-csl-2sp2
need_kconfig_hw:
- CONFIG_IGB=y
- CONFIG_SATA_AHCI
- CONFIG_BLK_DEV_NVME
ucode: '0x4003003'

#! include/disk/nr_brd
need_kconfig:
- CONFIG_BLK_DEV_RAM=m
- CONFIG_BLK_DEV=y
- CONFIG_BLOCK=y
- CONFIG_MD_RAID0
- CONFIG_F2FS_FS

#! include/md/raid_level

#! include/fs/OTHERS
enqueue_time: 2020-11-22 08:28:21.065834020 +08:00
_id: 5fb9b0a76973a227841d1f71
_rt: "/result/aim7/performance-4BRD_12G-f2fs-100-RAID0-sync_disk_rw-ucode=0x4003003-monitor=6e02c248/lkp-csl-2sp2/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/c9847a7f94679e742710574a2a7fee1c30c5ecf0"

#! schedule options
user: lkp
compiler: gcc-9
head_commit: d026633165036431cb53fd5c50f39d2cb7f5e913
base_commit: '09162bc32c880a791c6c0668ce0745cf7958f576'
branch: linux-devel/devel-hourly-2020112115
rootfs: debian-10.4-x86_64-20200603.cgz
monitor_sha: 6e02c248
result_root: "/result/aim7/performance-4BRD_12G-f2fs-100-RAID0-sync_disk_rw-ucode=0x4003003-monitor=6e02c248/lkp-csl-2sp2/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/c9847a7f94679e742710574a2a7fee1c30c5ecf0/0"
scheduler_version: "/lkp/lkp/.src-20201120-230606"
LKP_SERVER: internal-lkp-server
arch: x86_64
max_uptime: 3600
initrd: "/osimage/debian/debian-10.4-x86_64-20200603.cgz"
bootloader_append:
- root=/dev/ram0
- user=lkp
- job=/lkp/jobs/scheduled/lkp-csl-2sp2/aim7-performance-4BRD_12G-f2fs-100-RAID0-sync_disk_rw-ucode=0x4003003-monitor=6e02c248-debian-10.4-x86_64-20200603.cgz-c9847a7f9-20201122-10116-xipnz4-1.yaml
- ARCH=x86_64
- kconfig=x86_64-rhel-8.3
- branch=linux-devel/devel-hourly-2020112115
- commit=c9847a7f94679e742710574a2a7fee1c30c5ecf0
- BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3/gcc-9/c9847a7f94679e742710574a2a7fee1c30c5ecf0/vmlinuz-5.10.0-rc3-00005-gc9847a7f9467
- acpi_rsdp=0x68b85014
- max_uptime=3600
- RESULT_ROOT=/result/aim7/performance-4BRD_12G-f2fs-100-RAID0-sync_disk_rw-ucode=0x4003003-monitor=6e02c248/lkp-csl-2sp2/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/c9847a7f94679e742710574a2a7fee1c30c5ecf0/0
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
modules_initrd: "/pkg/linux/x86_64-rhel-8.3/gcc-9/c9847a7f94679e742710574a2a7fee1c30c5ecf0/modules.cgz"
bm_initrd: "/osimage/deps/debian-10.4-x86_64-20200603.cgz/run-ipconfig_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/lkp_20200709.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/rsync-rootfs_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/perf_20200723.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/perf-x86_64-eccc87672492-1_20201111.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/md_20200714.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/fs_20200714.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/aim7-x86_64-1-1_20201007.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/mpstat_20200714.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/sar-x86_64-34c92ae-1_20200702.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/hw_20200715.cgz"
ucode_initrd: "/osimage/ucode/intel-ucode-20201117.cgz"
lkp_initrd: "/osimage/user/lkp/lkp-x86_64.cgz"
site: inn

#! /lkp/lkp/.src-20201120-230606/include/site/inn
LKP_CGI_PORT: 80
LKP_CIFS_PORT: 139
oom-killer: 
watchdog: 

#! runtime status
last_kernel: 5.10.0-rc4
repeat_to: 2
schedule_notify_address: 

#! user overrides
queue_at_least_once: 0
kernel: "/pkg/linux/x86_64-rhel-8.3/gcc-9/c9847a7f94679e742710574a2a7fee1c30c5ecf0/vmlinuz-5.10.0-rc3-00005-gc9847a7f9467"
dequeue_time: 2020-11-22 08:30:25.355799424 +08:00
job_state: finished
loadavg: 83.23 91.27 60.36 1/736 24758
start_time: '1550139127'
end_time: '1550140012'
version: "/lkp/lkp/.src-20201120-230655:3a1f47e8:44c9c7c85"

--IJpNTDwzlM2Ie8A6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=reproduce

 "modprobe" "-r" "brd"
 "modprobe" "brd" "rd_nr=4" "rd_size=12582912"
 "dmsetup" "remove_all"
 "wipefs" "-a" "--force" "/dev/ram0"
 "wipefs" "-a" "--force" "/dev/ram1"
 "wipefs" "-a" "--force" "/dev/ram2"
 "wipefs" "-a" "--force" "/dev/ram3"
 "mdadm" "-q" "--create" "/dev/md0" "--chunk=256" "--level=raid0" "--raid-devices=4" "--force" "--assume-clean" "/dev/ram0" "/dev/ram1" "/dev/ram2" "/dev/ram3"
wipefs -a --force /dev/md0
mkfs -t f2fs /dev/md0
mkdir -p /fs/md0
mount -t f2fs /dev/md0 /fs/md0

for cpu_dir in /sys/devices/system/cpu/cpu[0-9]*
do
	online_file="$cpu_dir"/online
	[ -f "$online_file" ] && [ "$(cat "$online_file")" -eq 0 ] && continue

	file="$cpu_dir"/cpufreq/scaling_governor
	[ -f "$file" ] && echo "performance" > "$file"
done

echo "500 32000 128 512" > /proc/sys/kernel/sem
cat > workfile <<EOF
FILESIZE: 1M
POOLSIZE: 10M
10 sync_disk_rw
EOF
echo "/fs/md0" > config

	(
		echo lkp-csl-2sp2
		echo sync_disk_rw

		echo 1
		echo 100
		echo 2
		echo 100
		echo 1
	) | ./multitask -t &

--IJpNTDwzlM2Ie8A6--
