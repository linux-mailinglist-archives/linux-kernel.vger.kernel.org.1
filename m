Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47BD92E34E3
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Dec 2020 09:02:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726455AbgL1ICH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Dec 2020 03:02:07 -0500
Received: from mga14.intel.com ([192.55.52.115]:22537 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726282AbgL1ICF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Dec 2020 03:02:05 -0500
IronPort-SDR: EEo3ppHnp8dsLF7+96zH7zazLo4f/efkVJzeL67VnLlROVhMTg9ONMclaOaTL5CSBZ5QJDrJ8S
 IxzsY/sk/3kw==
X-IronPort-AV: E=McAfee;i="6000,8403,9847"; a="175581804"
X-IronPort-AV: E=Sophos;i="5.78,454,1599548400"; 
   d="yaml'?scan'208";a="175581804"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2020 00:01:02 -0800
IronPort-SDR: O5QjOgsNQ24V9RBQT0267/iwHKzMlttBPH8I5zjiT8mGtP99o4Ux4WmWwjXWCXLnBVHQH0g2p4
 AJtXGvfo9c1A==
X-IronPort-AV: E=Sophos;i="5.78,454,1599548400"; 
   d="yaml'?scan'208";a="375540587"
Received: from xsang-optiplex-9020.sh.intel.com (HELO xsang-OptiPlex-9020) ([10.239.159.140])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2020 00:00:53 -0800
Date:   Mon, 28 Dec 2020 16:16:01 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     Alex Kogan <alex.kogan@oracle.com>
Cc:     0day robot <lkp@intel.com>,
        Steve Sistare <steven.sistare@oracle.com>,
        Waiman Long <longman@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        ying.huang@intel.com, feng.tang@intel.com, zhengjun.xing@intel.com,
        linux@armlinux.org.uk, peterz@infradead.org, mingo@redhat.com,
        will.deacon@arm.com, arnd@arndb.de, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, tglx@linutronix.de,
        bp@alien8.de, hpa@zytor.com, x86@kernel.org, guohanjun@huawei.com,
        jglauber@marvell.com, daniel.m.jordan@oracle.com,
        alex.kogan@oracle.com, dave.dice@oracle.com
Subject: [locking/qspinlock]  0e8d8f4f12:  stress-ng.zero.ops_per_sec -9.7%
 regression
Message-ID: <20201228081601.GA31221@xsang-OptiPlex-9020>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="Dxnq1zWXvFF0Q93v"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201223054455.1990884-4-alex.kogan@oracle.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Dxnq1zWXvFF0Q93v
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit


Greeting,

FYI, we noticed a -9.7% regression of stress-ng.zero.ops_per_sec due to commit:


commit: 0e8d8f4f1214cfbac219d6917b5f6460f818bb7c ("[PATCH v13 3/6] locking/qspinlock: Introduce CNA into the slow path of qspinlock")
url: https://github.com/0day-ci/linux/commits/Alex-Kogan/Add-NUMA-awareness-to-qspinlock/20201223-135025
base: https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git cb262935a166bdef0ccfe6e2adffa00c0f2d038a

in testcase: stress-ng
on test machine: 48 threads Intel(R) Xeon(R) CPU E5-2697 v2 @ 2.70GHz with 112G memory
with following parameters:

	nr_threads: 100%
	disk: 1HDD
	testtime: 30s
	class: device
	cpufreq_governor: performance
	ucode: 0x42e


In addition to that, the commit also has significant impact on the following tests:

+------------------+---------------------------------------------------------------------------+
| testcase: change | fsmark: fsmark.files_per_sec 213.9% improvement                           |
| test machine     | 192 threads Intel(R) Xeon(R) Platinum 9242 CPU @ 2.30GHz with 192G memory |
| test parameters  | cpufreq_governor=performance                                              |
|                  | disk=1BRD_48G                                                             |
|                  | filesize=4M                                                               |
|                  | fs=btrfs                                                                  |
|                  | iterations=1x                                                             |
|                  | nr_threads=64t                                                            |
|                  | sync_method=NoSync                                                        |
|                  | test_size=24G                                                             |
|                  | ucode=0x5003003                                                           |
+------------------+---------------------------------------------------------------------------+
| testcase: change | reaim: reaim.jobs_per_min 96.1% improvement                               |
| test machine     | 192 threads Intel(R) Xeon(R) Platinum 9242 CPU @ 2.30GHz with 192G memory |
| test parameters  | cpufreq_governor=performance                                              |
|                  | nr_task=100%                                                              |
|                  | runtime=300s                                                              |
|                  | test=new_fserver                                                          |
|                  | ucode=0x5003003                                                           |
+------------------+---------------------------------------------------------------------------+


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
class/compiler/cpufreq_governor/disk/kconfig/nr_threads/rootfs/tbox_group/testcase/testtime/ucode:
  device/gcc-9/performance/1HDD/x86_64-rhel-8.3/100%/debian-10.4-x86_64-20200603.cgz/lkp-ivb-2ep1/stress-ng/30s/0x42e

commit: 
  cb45bab007 ("locking/qspinlock: Refactor the qspinlock slow path")
  0e8d8f4f12 ("locking/qspinlock: Introduce CNA into the slow path of qspinlock")

cb45bab007ff0cfc 0e8d8f4f1214cfbac219d6917b5 
---------------- --------------------------- 
       fail:runs  %reproduction    fail:runs
           |             |             |    
           :4           25%           1:4     last_state.is_incomplete_run
           :4           25%           1:4     dmesg.Kernel_panic-not_syncing:softlockup:hung_tasks
           :4           25%           1:4     dmesg.RIP:smp_call_function_many_cond
           :4           25%           1:4     dmesg.RIP:smp_call_function_single
         %stddev     %change         %stddev
             \          |                \  
    481980 ±  9%     -12.0%     424197 ±  5%  stress-ng.time.involuntary_context_switches
 1.198e+08            -4.0%   1.15e+08        stress-ng.time.minor_page_faults
    689.06            -4.9%     655.29        stress-ng.time.user_time
  10626516            -9.7%    9598124        stress-ng.zero.ops
    354216            -9.7%     319937        stress-ng.zero.ops_per_sec
     12871           +19.8%      15424 ± 12%  meminfo.max_used_kB
     29.00            +4.6%      30.33        vmstat.cpu.id
     29.66            +3.7%      30.75 ±  2%  iostat.cpu.idle
      8.21            -7.6%       7.59 ±  2%  iostat.cpu.user
     67636 ± 12%     -21.3%      53263 ± 14%  sched_debug.cpu.nr_switches.max
     70.29 ± 16%     -22.1%      54.73 ± 14%  sched_debug.cpu.nr_uninterruptible.stddev
      7841 ± 58%    +418.8%      40676 ±  2%  numa-meminfo.node0.Active
      6226 ± 71%    +542.5%      40001        numa-meminfo.node0.Active(anon)
     15043 ± 32%    +271.6%      55899        numa-meminfo.node0.Shmem
     77673 ±  3%     -50.0%      38874 ±  9%  numa-meminfo.node1.Active
     77439 ±  3%     -51.0%      37925 ±  8%  numa-meminfo.node1.Active(anon)
    233.75 ±157%    +306.0%     949.00 ± 66%  numa-meminfo.node1.Active(file)
    575517 ±  4%      -8.8%     525050 ±  3%  numa-meminfo.node1.FilePages
     87936 ±  4%     -53.1%      41275 ±  9%  numa-meminfo.node1.Shmem
      2097 ±  5%     +26.8%       2660 ± 21%  slabinfo.dmaengine-unmap-16.active_objs
      2097 ±  5%     +26.8%       2660 ± 21%  slabinfo.dmaengine-unmap-16.num_objs
     40336 ±  6%    +102.0%      81465 ± 50%  slabinfo.filp.active_objs
    657.00 ±  6%     +98.0%       1301 ± 49%  slabinfo.filp.active_slabs
     42081 ±  6%     +97.9%      83296 ± 49%  slabinfo.filp.num_objs
    657.00 ±  6%     +98.0%       1301 ± 49%  slabinfo.filp.num_slabs
     13106 ±  3%     +12.6%      14752 ±  3%  slabinfo.shmem_inode_cache.active_objs
     13224 ±  3%     +12.5%      14873 ±  3%  slabinfo.shmem_inode_cache.num_objs
      1557 ± 71%    +545.2%      10045 ±  2%  numa-vmstat.node0.nr_active_anon
    117.50 ± 57%     -97.4%       3.00 ± 47%  numa-vmstat.node0.nr_mlock
      3761 ± 32%    +273.2%      14037        numa-vmstat.node0.nr_shmem
      1557 ± 71%    +545.2%      10045 ±  2%  numa-vmstat.node0.nr_zone_active_anon
     19391 ±  3%     -50.8%       9533 ±  7%  numa-vmstat.node1.nr_active_anon
     58.25 ±157%    +301.1%     233.67 ± 67%  numa-vmstat.node1.nr_active_file
    143875 ±  3%      -8.7%     131291 ±  3%  numa-vmstat.node1.nr_file_pages
     21981 ±  4%     -52.9%      10346 ±  8%  numa-vmstat.node1.nr_shmem
     19391 ±  3%     -50.8%       9533 ±  7%  numa-vmstat.node1.nr_zone_active_anon
     58.25 ±157%    +301.1%     233.67 ± 67%  numa-vmstat.node1.nr_zone_active_file
    110768 ±  3%     -10.6%      99008 ±  4%  softirqs.CPU0.RCU
    108763 ±  3%     -10.1%      97774 ±  4%  softirqs.CPU1.RCU
    104199 ±  3%      -9.5%      94314 ±  4%  softirqs.CPU12.RCU
    106156 ±  5%     -11.6%      93873 ±  4%  softirqs.CPU13.RCU
    107231 ±  4%     -11.3%      95088 ±  6%  softirqs.CPU14.RCU
    105547 ±  5%     -10.5%      94461 ±  4%  softirqs.CPU15.RCU
    104326 ±  5%      -7.4%      96653 ±  4%  softirqs.CPU22.RCU
    108301 ±  3%      -9.9%      97571 ±  3%  softirqs.CPU25.RCU
    109423 ±  3%     -10.9%      97448 ±  3%  softirqs.CPU26.RCU
    109554 ±  4%      -7.2%     101691 ±  3%  softirqs.CPU31.RCU
    108410 ±  4%     -11.2%      96233 ±  3%  softirqs.CPU37.RCU
    107189 ±  4%      -9.8%      96642 ±  4%  softirqs.CPU38.RCU
    108943 ±  4%     -10.9%      97052 ±  4%  softirqs.CPU39.RCU
      3348 ± 37%    +214.8%      10541 ± 51%  softirqs.NET_RX
     20942 ±  2%      -6.2%      19637 ±  4%  proc-vmstat.nr_active_anon
     67173 ±  4%      -3.7%      64699        proc-vmstat.nr_anon_pages
     10595            -1.7%      10418        proc-vmstat.nr_mapped
     25771 ±  2%      -5.1%      24461 ±  3%  proc-vmstat.nr_shmem
     38683            +5.7%      40878 ±  3%  proc-vmstat.nr_slab_unreclaimable
     20942 ±  2%      -6.2%      19637 ±  4%  proc-vmstat.nr_zone_active_anon
     21010 ± 11%     -23.8%      16020 ± 11%  proc-vmstat.numa_hint_faults
     16666 ± 11%     -28.6%      11904 ±  7%  proc-vmstat.numa_hint_faults_local
     69020 ±  3%      -3.7%      66499        proc-vmstat.numa_other
  21276729            -9.4%   19266740        proc-vmstat.pgactivate
     45217            +4.0%      47044        proc-vmstat.pgalloc_dma32
 1.065e+08            -2.8%  1.035e+08        proc-vmstat.pgalloc_normal
    610.50 ± 10%     +83.9%       1123 ± 28%  proc-vmstat.pgdeactivate
 1.209e+08            -4.1%  1.159e+08        proc-vmstat.pgfault
 1.064e+08            -2.7%  1.035e+08        proc-vmstat.pgfree
      5.50 ± 20%  +71439.4%       3934 ±141%  proc-vmstat.pgmigrate_fail
      3540 ± 29%    +139.9%       8494 ±  7%  proc-vmstat.pgrotated
  10600738            -9.5%    9598142        proc-vmstat.unevictable_pgs_mlocked
  10600295            -9.5%    9598142        proc-vmstat.unevictable_pgs_munlocked
      0.05 ± 97%     -59.4%       0.02 ±  2%  perf-sched.sch_delay.max.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      0.03 ±  6%  +29749.0%       9.03 ± 71%  perf-sched.sch_delay.max.ms.schedule_timeout.rcu_gp_kthread.kthread.ret_from_fork
     20.46 ±  3%      -8.9%      18.64 ±  4%  perf-sched.sch_delay.max.ms.wait_for_partner.fifo_open.do_dentry_open.path_openat
      7526 ± 15%     -25.7%       5592 ±  5%  perf-sched.total_wait_and_delay.max.ms
      7526 ± 15%     -25.7%       5592 ±  5%  perf-sched.total_wait_time.max.ms
      9.67 ±168%     -97.6%       0.24 ± 30%  perf-sched.wait_and_delay.avg.ms.preempt_schedule_common._cond_resched.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
    343.12 ±139%    +236.4%       1154 ± 14%  perf-sched.wait_and_delay.avg.ms.preempt_schedule_common._cond_resched.generic_perform_write.__generic_file_write_iter.generic_file_write_iter
      1.39 ±173%  +26107.3%     364.94        perf-sched.wait_and_delay.avg.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      5.59 ±  6%     -20.2%       4.46 ±  6%  perf-sched.wait_and_delay.avg.ms.schedule_timeout.rcu_gp_kthread.kthread.ret_from_fork
      1770 ±  6%     +26.3%       2236 ±  7%  perf-sched.wait_and_delay.count.schedule_timeout.rcu_gp_kthread.kthread.ret_from_fork
     18.50 ± 51%    +272.3%      68.88 ± 22%  perf-sched.wait_and_delay.max.ms.preempt_schedule_common._cond_resched.remove_vma.__do_munmap.__vm_munmap
     20.79 ± 26%    +217.3%      65.97 ±  9%  perf-sched.wait_and_delay.max.ms.preempt_schedule_common._cond_resched.unmap_vmas.unmap_region.__do_munmap
    242.02 ± 18%     -60.5%      95.68 ± 51%  perf-sched.wait_and_delay.max.ms.schedule_timeout.rcu_gp_kthread.kthread.ret_from_fork
      0.12 ± 32%    +266.9%       0.43 ± 78%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.__alloc_pages_nodemask.alloc_pages_vma.do_anonymous_page
      1971 ±123%     -99.4%      11.34 ± 10%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.__alloc_pages_nodemask.alloc_pages_vma.shmem_alloc_page
      9.67 ±168%     -97.6%       0.24 ± 30%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
    348.74 ±136%    +231.0%       1154 ± 14%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.generic_perform_write.__generic_file_write_iter.generic_file_write_iter
      5.86 ±  4%   +1071.7%      68.64 ± 19%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.khugepaged.kthread.ret_from_fork
     38.63 ± 52%    +843.9%     364.62        perf-sched.wait_time.avg.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      5.57 ±  6%     -20.3%       4.44 ±  6%  perf-sched.wait_time.avg.ms.schedule_timeout.rcu_gp_kthread.kthread.ret_from_fork
      1.57 ± 14%    +683.9%      12.28 ±100%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.__alloc_pages_nodemask.alloc_pages_vma.do_anonymous_page
      2468 ±103%     -99.5%      11.34 ± 10%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.__alloc_pages_nodemask.alloc_pages_vma.shmem_alloc_page
      3.91 ± 14%     -41.4%       2.29 ±  6%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.down_read.__x64_sys_msync.do_syscall_64
      7.68 ± 17%   +1121.8%      93.81 ± 13%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.khugepaged.kthread.ret_from_fork
     18.50 ± 51%    +272.3%      68.88 ± 22%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.remove_vma.__do_munmap.__vm_munmap
     20.79 ± 26%    +217.3%      65.97 ±  9%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.unmap_vmas.unmap_region.__do_munmap
    242.00 ± 18%     -62.5%      90.66 ± 61%  perf-sched.wait_time.max.ms.schedule_timeout.rcu_gp_kthread.kthread.ret_from_fork
  47358339 ±  7%     -10.5%   42382902 ±  2%  perf-stat.i.branch-misses
  19845519 ±  2%      -8.5%   18156709 ±  3%  perf-stat.i.cache-misses
  1.72e+08            -5.7%  1.621e+08        perf-stat.i.cache-references
    725.90 ±  5%     -13.2%     630.12 ±  5%  perf-stat.i.cpu-migrations
  3.09e+09            -4.3%  2.957e+09        perf-stat.i.dTLB-stores
  19570792            -6.2%   18352176        perf-stat.i.iTLB-load-misses
     19871 ±  4%      +9.8%      21819 ±  3%  perf-stat.i.instructions-per-iTLB-miss
    382.70            -3.0%     371.36 ±  2%  perf-stat.i.metric.M/sec
   7111839 ±  4%     -11.4%    6302363 ±  2%  perf-stat.i.node-load-misses
   8853002 ±  4%      -9.6%    8004893        perf-stat.i.node-loads
   6500622            -7.9%    5986359 ±  4%  perf-stat.i.node-store-misses
   8596412            -6.5%    8036645 ±  3%  perf-stat.i.node-stores
      5.60 ±  2%      -3.9%       5.38        perf-stat.overall.MPKI
      0.63 ±  7%      -0.1        0.57        perf-stat.overall.branch-miss-rate%
      5180 ±  2%      +9.2%       5659 ±  3%  perf-stat.overall.cycles-between-cache-misses
      1575            +4.8%       1651 ±  3%  perf-stat.overall.instructions-per-iTLB-miss
     44.52            -0.5       43.98        perf-stat.overall.node-load-miss-rate%
     43.02            -0.4       42.61        perf-stat.overall.node-store-miss-rate%
  47096030 ±  7%     -11.4%   41713545 ±  3%  perf-stat.ps.branch-misses
  19690067 ±  2%      -9.4%   17836765 ±  3%  perf-stat.ps.cache-misses
   1.7e+08 ±  2%      -6.9%  1.582e+08 ±  2%  perf-stat.ps.cache-references
 1.019e+11            -1.1%  1.008e+11        perf-stat.ps.cpu-cycles
    748.16 ±  5%     -11.3%     663.37 ±  5%  perf-stat.ps.cpu-migrations
 3.052e+09            -5.5%  2.885e+09 ±  2%  perf-stat.ps.dTLB-stores
  19264658            -7.6%   17802646 ±  2%  perf-stat.ps.iTLB-load-misses
   7041022 ±  4%     -12.4%    6164936        perf-stat.ps.node-load-misses
   8774703 ±  4%     -10.5%    7851024        perf-stat.ps.node-loads
   6428583            -9.0%    5851692 ±  4%  perf-stat.ps.node-store-misses
   8513354            -7.5%    7878662 ±  4%  perf-stat.ps.node-stores
    793.75 ±  6%     -16.3%     664.33 ± 12%  interrupts.22:IO-APIC.22-fasteoi.ehci_hcd:usb1
     10846 ± 12%     -22.7%       8387 ±  8%  interrupts.CPU0.CAL:Function_call_interrupts
      4222 ± 14%     -49.6%       2128 ± 43%  interrupts.CPU1.NMI:Non-maskable_interrupts
      4222 ± 14%     -49.6%       2128 ± 43%  interrupts.CPU1.PMI:Performance_monitoring_interrupts
      3219 ± 28%     -21.0%       2544 ± 29%  interrupts.CPU10.NMI:Non-maskable_interrupts
      3219 ± 28%     -21.0%       2544 ± 29%  interrupts.CPU10.PMI:Performance_monitoring_interrupts
     12387 ±  8%     -10.7%      11065 ± 10%  interrupts.CPU10.TLB:TLB_shootdowns
      3883 ± 23%     -35.3%       2511 ± 43%  interrupts.CPU11.NMI:Non-maskable_interrupts
      3883 ± 23%     -35.3%       2511 ± 43%  interrupts.CPU11.PMI:Performance_monitoring_interrupts
     11453 ± 37%     -34.1%       7553 ± 14%  interrupts.CPU12.CAL:Function_call_interrupts
      2074 ±126%     -77.6%     464.00 ±  9%  interrupts.CPU12.RES:Rescheduling_interrupts
     13347 ± 59%     -45.5%       7274 ± 10%  interrupts.CPU12.TLB:TLB_shootdowns
     11138 ± 23%     -31.3%       7657 ± 13%  interrupts.CPU13.CAL:Function_call_interrupts
      3399 ± 34%     -29.1%       2410 ± 50%  interrupts.CPU15.NMI:Non-maskable_interrupts
      3399 ± 34%     -29.1%       2410 ± 50%  interrupts.CPU15.PMI:Performance_monitoring_interrupts
      3318 ± 29%     -25.3%       2479 ± 34%  interrupts.CPU16.NMI:Non-maskable_interrupts
      3318 ± 29%     -25.3%       2479 ± 34%  interrupts.CPU16.PMI:Performance_monitoring_interrupts
      4574 ± 17%     -58.7%       1890 ± 29%  interrupts.CPU20.NMI:Non-maskable_interrupts
      4574 ± 17%     -58.7%       1890 ± 29%  interrupts.CPU20.PMI:Performance_monitoring_interrupts
      2768 ± 37%     -44.7%       1531 ± 30%  interrupts.CPU22.NMI:Non-maskable_interrupts
      2768 ± 37%     -44.7%       1531 ± 30%  interrupts.CPU22.PMI:Performance_monitoring_interrupts
    516.00 ± 23%     -18.9%     418.33 ±  5%  interrupts.CPU22.RES:Rescheduling_interrupts
      3326 ± 27%     -28.2%       2387 ± 34%  interrupts.CPU23.NMI:Non-maskable_interrupts
      3326 ± 27%     -28.2%       2387 ± 34%  interrupts.CPU23.PMI:Performance_monitoring_interrupts
      3850 ± 20%     -39.2%       2340 ± 50%  interrupts.CPU25.NMI:Non-maskable_interrupts
      3850 ± 20%     -39.2%       2340 ± 50%  interrupts.CPU25.PMI:Performance_monitoring_interrupts
    859.25 ± 48%     -46.0%     464.33 ±  5%  interrupts.CPU25.RES:Rescheduling_interrupts
     13154 ± 35%     -25.2%       9841 ± 14%  interrupts.CPU25.TLB:TLB_shootdowns
      3711 ± 23%     -45.6%       2018 ± 45%  interrupts.CPU26.NMI:Non-maskable_interrupts
      3711 ± 23%     -45.6%       2018 ± 45%  interrupts.CPU26.PMI:Performance_monitoring_interrupts
      4507 ±  4%     -43.3%       2556 ± 40%  interrupts.CPU27.NMI:Non-maskable_interrupts
      4507 ±  4%     -43.3%       2556 ± 40%  interrupts.CPU27.PMI:Performance_monitoring_interrupts
     11363 ±  9%     -14.9%       9671 ±  8%  interrupts.CPU27.TLB:TLB_shootdowns
      4430 ±  5%     -51.0%       2172 ± 43%  interrupts.CPU28.NMI:Non-maskable_interrupts
      4430 ±  5%     -51.0%       2172 ± 43%  interrupts.CPU28.PMI:Performance_monitoring_interrupts
      9512 ±  3%     -16.7%       7921 ±  8%  interrupts.CPU29.CAL:Function_call_interrupts
      3914 ± 14%     -59.0%       1606 ± 27%  interrupts.CPU29.NMI:Non-maskable_interrupts
      3914 ± 14%     -59.0%       1606 ± 27%  interrupts.CPU29.PMI:Performance_monitoring_interrupts
    998.00 ± 77%     -55.5%     444.00 ±  2%  interrupts.CPU29.RES:Rescheduling_interrupts
     11508 ± 12%     -22.8%       8881 ± 10%  interrupts.CPU29.TLB:TLB_shootdowns
      3287 ± 22%     -36.6%       2082 ± 43%  interrupts.CPU30.NMI:Non-maskable_interrupts
      3287 ± 22%     -36.6%       2082 ± 43%  interrupts.CPU30.PMI:Performance_monitoring_interrupts
    571.75 ± 12%     -21.0%     451.67 ± 10%  interrupts.CPU30.RES:Rescheduling_interrupts
     10554 ± 20%     -26.5%       7757 ±  6%  interrupts.CPU31.CAL:Function_call_interrupts
      3521 ± 21%     -47.8%       1838 ±  9%  interrupts.CPU31.NMI:Non-maskable_interrupts
      3521 ± 21%     -47.8%       1838 ±  9%  interrupts.CPU31.PMI:Performance_monitoring_interrupts
    604.00 ± 20%     -26.0%     447.00 ± 14%  interrupts.CPU31.RES:Rescheduling_interrupts
      3946 ± 21%     -51.9%       1898 ±  6%  interrupts.CPU32.NMI:Non-maskable_interrupts
      3946 ± 21%     -51.9%       1898 ±  6%  interrupts.CPU32.PMI:Performance_monitoring_interrupts
      2221 ± 74%     -74.2%     573.00 ± 13%  interrupts.CPU32.RES:Rescheduling_interrupts
      2969 ± 22%     -40.2%       1774 ± 11%  interrupts.CPU33.NMI:Non-maskable_interrupts
      2969 ± 22%     -40.2%       1774 ± 11%  interrupts.CPU33.PMI:Performance_monitoring_interrupts
     13653 ± 16%     -40.8%       8079 ±  6%  interrupts.CPU34.CAL:Function_call_interrupts
      3074 ± 20%     -41.7%       1791 ± 18%  interrupts.CPU34.NMI:Non-maskable_interrupts
      3074 ± 20%     -41.7%       1791 ± 18%  interrupts.CPU34.PMI:Performance_monitoring_interrupts
     18328 ± 31%     -48.1%       9519 ±  7%  interrupts.CPU34.TLB:TLB_shootdowns
     11937 ± 21%     -36.1%       7623 ± 15%  interrupts.CPU35.CAL:Function_call_interrupts
      3503 ± 30%     -36.4%       2229 ± 12%  interrupts.CPU35.NMI:Non-maskable_interrupts
      3503 ± 30%     -36.4%       2229 ± 12%  interrupts.CPU35.PMI:Performance_monitoring_interrupts
     16203 ± 41%     -47.9%       8444 ± 15%  interrupts.CPU35.TLB:TLB_shootdowns
      4311 ± 20%     -43.4%       2440 ± 50%  interrupts.CPU37.NMI:Non-maskable_interrupts
      4311 ± 20%     -43.4%       2440 ± 50%  interrupts.CPU37.PMI:Performance_monitoring_interrupts
      1028 ± 98%     -60.6%     404.67 ±  5%  interrupts.CPU37.RES:Rescheduling_interrupts
     11376 ± 22%     -35.6%       7324 ±  2%  interrupts.CPU37.TLB:TLB_shootdowns
      3390 ± 35%     -35.8%       2177 ± 50%  interrupts.CPU38.NMI:Non-maskable_interrupts
      3390 ± 35%     -35.8%       2177 ± 50%  interrupts.CPU38.PMI:Performance_monitoring_interrupts
      2077 ±133%     -80.7%     401.33 ± 12%  interrupts.CPU38.RES:Rescheduling_interrupts
      3760 ± 19%     -54.3%       1716 ± 66%  interrupts.CPU39.NMI:Non-maskable_interrupts
      3760 ± 19%     -54.3%       1716 ± 66%  interrupts.CPU39.PMI:Performance_monitoring_interrupts
      3338 ± 68%     -85.1%     496.67 ± 17%  interrupts.CPU4.RES:Rescheduling_interrupts
      3731 ± 27%     -45.6%       2030 ± 38%  interrupts.CPU40.NMI:Non-maskable_interrupts
      3731 ± 27%     -45.6%       2030 ± 38%  interrupts.CPU40.PMI:Performance_monitoring_interrupts
      4265 ±  5%     -43.5%       2409 ± 45%  interrupts.CPU42.NMI:Non-maskable_interrupts
      4265 ±  5%     -43.5%       2409 ± 45%  interrupts.CPU42.PMI:Performance_monitoring_interrupts
      3425 ± 18%     -41.4%       2007 ± 51%  interrupts.CPU43.NMI:Non-maskable_interrupts
      3425 ± 18%     -41.4%       2007 ± 51%  interrupts.CPU43.PMI:Performance_monitoring_interrupts
    627.00 ± 46%     -43.4%     354.67 ±  2%  interrupts.CPU43.RES:Rescheduling_interrupts
      4679 ± 13%     -71.6%       1331 ± 21%  interrupts.CPU44.NMI:Non-maskable_interrupts
      4679 ± 13%     -71.6%       1331 ± 21%  interrupts.CPU44.PMI:Performance_monitoring_interrupts
    494.50 ± 18%     -25.8%     367.00 ± 15%  interrupts.CPU44.RES:Rescheduling_interrupts
      3975 ± 18%     -43.4%       2249 ± 46%  interrupts.CPU45.NMI:Non-maskable_interrupts
      3975 ± 18%     -43.4%       2249 ± 46%  interrupts.CPU45.PMI:Performance_monitoring_interrupts
      8711 ±  9%     -11.6%       7705        interrupts.CPU46.CAL:Function_call_interrupts
      3650 ± 22%     -44.9%       2010 ± 55%  interrupts.CPU46.NMI:Non-maskable_interrupts
      3650 ± 22%     -44.9%       2010 ± 55%  interrupts.CPU46.PMI:Performance_monitoring_interrupts
    440.75 ±  9%     -16.7%     367.00 ±  7%  interrupts.CPU46.RES:Rescheduling_interrupts
      7891 ± 10%     -25.7%       5860 ± 11%  interrupts.CPU47.CAL:Function_call_interrupts
    793.00 ± 40%     -50.6%     392.00 ±  3%  interrupts.CPU47.RES:Rescheduling_interrupts
      2663 ± 23%     -21.6%       2087 ±  7%  interrupts.CPU5.NMI:Non-maskable_interrupts
      2663 ± 23%     -21.6%       2087 ±  7%  interrupts.CPU5.PMI:Performance_monitoring_interrupts
     12129 ± 30%     -32.7%       8164 ±  2%  interrupts.CPU7.CAL:Function_call_interrupts
     14622 ± 38%     -33.7%       9701 ±  6%  interrupts.CPU7.TLB:TLB_shootdowns
    793.75 ±  6%     -16.3%     664.33 ± 12%  interrupts.CPU8.22:IO-APIC.22-fasteoi.ehci_hcd:usb1
      2516 ±  7%     +26.7%       3188 ± 15%  interrupts.CPU8.NMI:Non-maskable_interrupts
      2516 ±  7%     +26.7%       3188 ± 15%  interrupts.CPU8.PMI:Performance_monitoring_interrupts
      1784 ± 54%     -58.8%     735.00 ±  4%  interrupts.CPU8.RES:Rescheduling_interrupts
    656.75 ± 18%     +51.0%     992.00 ± 20%  interrupts.CPU9.RES:Rescheduling_interrupts
    168231 ±  7%     -33.4%     112034 ± 19%  interrupts.NMI:Non-maskable_interrupts
    168231 ±  7%     -33.4%     112034 ± 19%  interrupts.PMI:Performance_monitoring_interrupts
      7.01 ± 14%      -3.4        3.60 ± 50%  perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.entry_SYSCALL_64_after_hwframe
      4.21 ± 21%      -1.9        2.29 ± 63%  perf-profile.calltrace.cycles-pp.exit_to_user_mode_prepare.syscall_exit_to_user_mode.entry_SYSCALL_64_after_hwframe
      2.84 ± 12%      -1.9        0.96 ± 39%  perf-profile.calltrace.cycles-pp.ksys_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe
      4.06 ± 21%      -1.8        2.23 ± 65%  perf-profile.calltrace.cycles-pp.task_work_run.exit_to_user_mode_prepare.syscall_exit_to_user_mode.entry_SYSCALL_64_after_hwframe
      2.64 ± 13%      -1.8        0.87 ± 40%  perf-profile.calltrace.cycles-pp.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe
      3.84 ± 22%      -1.7        2.13 ± 67%  perf-profile.calltrace.cycles-pp.__fput.task_work_run.exit_to_user_mode_prepare.syscall_exit_to_user_mode.entry_SYSCALL_64_after_hwframe
      1.49 ±  7%      -0.9        0.54 ± 70%  perf-profile.calltrace.cycles-pp.alloc_empty_file.path_openat.do_filp_open.do_sys_openat2.do_sys_open
      1.46 ±  8%      -0.9        0.53 ± 70%  perf-profile.calltrace.cycles-pp.__alloc_file.alloc_empty_file.path_openat.do_filp_open.do_sys_openat2
      1.28 ±  5%      -0.8        0.51 ± 71%  perf-profile.calltrace.cycles-pp.syscall_return_via_sysret
      1.06 ±  6%      -0.6        0.42 ± 71%  perf-profile.calltrace.cycles-pp.__entry_text_start
      0.77 ± 13%      +0.3        1.05 ± 11%  perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter.do_idle
      0.82 ± 12%      +0.3        1.12 ± 11%  perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry
      1.23 ± 13%      +0.4        1.68 ± 18%  perf-profile.calltrace.cycles-pp.wait_for_xmitr.serial8250_console_putchar.uart_console_write.serial8250_console_write.console_unlock
      1.23 ± 13%      +0.4        1.68 ± 18%  perf-profile.calltrace.cycles-pp.serial8250_console_putchar.uart_console_write.serial8250_console_write.console_unlock.vprintk_emit
      1.82 ± 13%      +0.6        2.39 ± 17%  perf-profile.calltrace.cycles-pp.create_basic_memory_bitmaps.snapshot_open.misc_open.chrdev_open.do_dentry_open
      0.00            +0.6        0.61 ± 12%  perf-profile.calltrace.cycles-pp.__sysvec_apic_timer_interrupt.asm_call_sysvec_on_stack.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state
      0.00            +0.6        0.62 ± 12%  perf-profile.calltrace.cycles-pp.asm_call_sysvec_on_stack.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter
      4.96 ±  7%      +1.7        6.69 ± 19%  perf-profile.calltrace.cycles-pp.mutex_spin_on_owner.__mutex_lock.misc_open.chrdev_open.do_dentry_open
      7.19 ± 14%      -3.4        3.78 ± 45%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      3.03 ± 53%      -2.8        0.24 ± 21%  perf-profile.children.cycles-pp.link_path_walk
      4.28 ± 21%      -1.9        2.35 ± 61%  perf-profile.children.cycles-pp.exit_to_user_mode_prepare
      2.85 ± 12%      -1.9        0.96 ± 40%  perf-profile.children.cycles-pp.ksys_mmap_pgoff
      4.26 ± 21%      -1.9        2.38 ± 62%  perf-profile.children.cycles-pp.task_work_run
      2.65 ± 13%      -1.8        0.88 ± 40%  perf-profile.children.cycles-pp.vm_mmap_pgoff
      4.04 ± 22%      -1.8        2.27 ± 64%  perf-profile.children.cycles-pp.__fput
      1.69 ± 54%      -1.6        0.13 ± 22%  perf-profile.children.cycles-pp.inode_permission
      1.47 ± 51%      -1.3        0.16 ±  3%  perf-profile.children.cycles-pp.walk_component
      1.33 ± 54%      -1.2        0.11 ± 14%  perf-profile.children.cycles-pp.lookup_fast
      1.49 ± 27%      -1.1        0.36 ± 28%  perf-profile.children.cycles-pp._raw_spin_lock
      1.49 ± 31%      -1.1        0.40 ± 48%  perf-profile.children.cycles-pp.rwsem_down_write_slowpath
      1.51 ± 21%      -1.1        0.44 ± 53%  perf-profile.children.cycles-pp.down_write_killable
      0.91 ± 62%      -0.9        0.04 ± 71%  perf-profile.children.cycles-pp.hidraw_release
      1.58 ±  8%      -0.8        0.73 ± 24%  perf-profile.children.cycles-pp.alloc_empty_file
      1.55 ±  9%      -0.8        0.72 ± 24%  perf-profile.children.cycles-pp.__alloc_file
      1.49 ±  5%      -0.7        0.74 ± 28%  perf-profile.children.cycles-pp.syscall_return_via_sysret
      1.26 ±  6%      -0.6        0.63 ± 27%  perf-profile.children.cycles-pp.__entry_text_start
      1.12 ±  9%      -0.6        0.55 ± 24%  perf-profile.children.cycles-pp.kmem_cache_alloc
      0.87 ± 18%      -0.6        0.31 ± 34%  perf-profile.children.cycles-pp.do_mmap
      0.63 ±  7%      -0.4        0.22 ± 25%  perf-profile.children.cycles-pp.dput
      0.55 ± 17%      -0.4        0.15 ± 34%  perf-profile.children.cycles-pp.security_file_open
      0.53 ± 19%      -0.4        0.14 ± 36%  perf-profile.children.cycles-pp.apparmor_file_open
      0.52 ± 32%      -0.4        0.14 ± 55%  perf-profile.children.cycles-pp.rwsem_spin_on_owner
      0.48 ± 22%      -0.4        0.12 ± 13%  perf-profile.children.cycles-pp.ima_file_check
      0.65 ±  7%      -0.4        0.29 ± 35%  perf-profile.children.cycles-pp.__x64_sys_select
      0.47 ± 23%      -0.4        0.11 ± 14%  perf-profile.children.cycles-pp.security_task_getsecid
      0.64 ±  7%      -0.4        0.29 ± 35%  perf-profile.children.cycles-pp.kern_select
      0.62 ± 13%      -0.3        0.27 ± 36%  perf-profile.children.cycles-pp.__x64_sys_exit_group
      0.62 ± 12%      -0.3        0.28 ± 33%  perf-profile.children.cycles-pp.do_group_exit
      0.62 ± 12%      -0.3        0.28 ± 33%  perf-profile.children.cycles-pp.do_exit
      0.45 ± 24%      -0.3        0.11 ± 19%  perf-profile.children.cycles-pp.apparmor_task_getsecid
      0.49 ± 65%      -0.3        0.16 ± 83%  perf-profile.children.cycles-pp.__x64_sys_munmap
      0.49 ± 64%      -0.3        0.16 ± 83%  perf-profile.children.cycles-pp.__vm_munmap
      0.48 ±  5%      -0.3        0.16 ± 34%  perf-profile.children.cycles-pp.lockref_put_or_lock
      0.51 ±  9%      -0.3        0.19 ± 15%  perf-profile.children.cycles-pp.security_file_alloc
      0.51 ±  7%      -0.3        0.20 ± 38%  perf-profile.children.cycles-pp.__x64_sys_close
      0.59 ± 12%      -0.3        0.30 ± 13%  perf-profile.children.cycles-pp.__do_sys_clone
      0.59 ± 12%      -0.3        0.30 ± 13%  perf-profile.children.cycles-pp.kernel_clone
      0.41 ± 11%      -0.3        0.13 ± 18%  perf-profile.children.cycles-pp.apparmor_file_alloc_security
      0.57 ± 12%      -0.3        0.29 ± 12%  perf-profile.children.cycles-pp.copy_process
      0.51 ±  8%      -0.3        0.23 ± 38%  perf-profile.children.cycles-pp.core_sys_select
      0.43 ± 14%      -0.3        0.17 ± 14%  perf-profile.children.cycles-pp.mmput
      0.43 ± 14%      -0.3        0.17 ± 14%  perf-profile.children.cycles-pp.exit_mmap
      0.45 ±  8%      -0.3        0.19 ± 35%  perf-profile.children.cycles-pp.get_unmapped_area
      0.40 ± 17%      -0.3        0.14 ± 20%  perf-profile.children.cycles-pp.__do_sys_newfstat
      0.50 ± 13%      -0.2        0.26 ± 12%  perf-profile.children.cycles-pp.dup_mm
      0.71 ±  9%      -0.2        0.48 ± 11%  perf-profile.children.cycles-pp.do_softirq_own_stack
      0.75 ± 10%      -0.2        0.52 ± 11%  perf-profile.children.cycles-pp.irq_exit_rcu
      0.49 ± 12%      -0.2        0.26 ± 12%  perf-profile.children.cycles-pp.dup_mmap
      0.41 ±  9%      -0.2        0.19 ± 36%  perf-profile.children.cycles-pp.__fget_files
      0.28 ± 52%      -0.2        0.06 ± 75%  perf-profile.children.cycles-pp.mmap_region
      0.35 ±  5%      -0.2        0.14 ± 34%  perf-profile.children.cycles-pp.security_mmap_file
      0.39 ±  7%      -0.2        0.18 ± 15%  perf-profile.children.cycles-pp.getname_flags
      0.32 ±  7%      -0.2        0.12 ± 35%  perf-profile.children.cycles-pp.complete_walk
      0.32 ±  7%      -0.2        0.12 ± 31%  perf-profile.children.cycles-pp.unlazy_walk
      0.29 ± 22%      -0.2        0.09 ± 27%  perf-profile.children.cycles-pp.vfs_fstat
      0.30 ± 17%      -0.2        0.10 ± 12%  perf-profile.children.cycles-pp.security_file_free
      0.28 ± 21%      -0.2        0.08 ± 14%  perf-profile.children.cycles-pp.aa_get_task_label
      0.29 ± 17%      -0.2        0.09 ± 14%  perf-profile.children.cycles-pp.apparmor_file_free_security
      0.25 ± 32%      -0.2        0.06 ± 13%  perf-profile.children.cycles-pp.step_into
      0.36 ± 10%      -0.2        0.17 ± 39%  perf-profile.children.cycles-pp.do_select
      0.33 ±  7%      -0.2        0.14 ± 34%  perf-profile.children.cycles-pp.arch_get_unmapped_area_topdown
      0.29 ±  7%      -0.2        0.10 ± 31%  perf-profile.children.cycles-pp.__legitimize_path
      0.36 ± 17%      -0.2        0.17 ±  7%  perf-profile.children.cycles-pp.__schedule
      0.29 ±  8%      -0.2        0.11 ± 40%  perf-profile.children.cycles-pp.terminate_walk
      0.34 ±  8%      -0.2        0.17 ± 34%  perf-profile.children.cycles-pp.__fget_light
      0.25 ± 25%      -0.2        0.08 ± 24%  perf-profile.children.cycles-pp.may_open
      0.25 ± 18%      -0.2        0.08 ± 35%  perf-profile.children.cycles-pp.mutex_lock
      0.35 ±  7%      -0.2        0.18 ± 50%  perf-profile.children.cycles-pp.__alloc_pages_nodemask
      0.39 ± 13%      -0.2        0.22 ± 24%  perf-profile.children.cycles-pp.ksys_lseek
      0.25 ± 58%      -0.2        0.09 ± 84%  perf-profile.children.cycles-pp.__do_munmap
      0.22 ±  8%      -0.2        0.06 ± 71%  perf-profile.children.cycles-pp.lockref_get_not_dead
      0.21 ± 17%      -0.2        0.06 ± 75%  perf-profile.children.cycles-pp.cdev_put
      0.25 ± 10%      -0.2        0.10 ± 38%  perf-profile.children.cycles-pp.__close_fd
      0.24 ± 10%      -0.1        0.10 ± 38%  perf-profile.children.cycles-pp.pick_file
      0.37 ± 10%      -0.1        0.23 ± 12%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      0.27 ±  9%      -0.1        0.13 ± 33%  perf-profile.children.cycles-pp.__alloc_fd
      0.21 ± 23%      -0.1        0.07 ± 20%  perf-profile.children.cycles-pp.free_pgtables
      0.27 ± 20%      -0.1        0.13 ±  9%  perf-profile.children.cycles-pp.schedule
      0.26 ±  7%      -0.1        0.12 ± 18%  perf-profile.children.cycles-pp.strncpy_from_user
      0.23 ± 10%      -0.1        0.09 ± 39%  perf-profile.children.cycles-pp.filp_close
      0.20 ± 11%      -0.1        0.07 ± 71%  perf-profile.children.cycles-pp.vm_unmapped_area
      0.25 ±  4%      -0.1        0.12 ± 29%  perf-profile.children.cycles-pp.entry_SYSCALL_64_safe_stack
      0.17 ± 16%      -0.1        0.04 ± 76%  perf-profile.children.cycles-pp.kobject_put
      0.19 ± 19%      -0.1        0.06 ± 29%  perf-profile.children.cycles-pp.copy_page_range
      0.22 ± 11%      -0.1        0.10 ± 14%  perf-profile.children.cycles-pp.try_to_wake_up
      0.21 ±  9%      -0.1        0.08 ± 34%  perf-profile.children.cycles-pp.common_file_perm
      0.22 ± 10%      -0.1        0.10 ± 32%  perf-profile.children.cycles-pp.fput_many
      0.29 ± 21%      -0.1        0.17 ± 47%  perf-profile.children.cycles-pp.drm_release
      0.29 ± 21%      -0.1        0.17 ± 47%  perf-profile.children.cycles-pp.drm_client_dev_restore
      0.29 ± 21%      -0.1        0.17 ± 47%  perf-profile.children.cycles-pp.drm_fbdev_client_restore
      0.29 ± 21%      -0.1        0.17 ± 47%  perf-profile.children.cycles-pp.__drm_fb_helper_restore_fbdev_mode_unlocked
      0.29 ± 21%      -0.1        0.17 ± 47%  perf-profile.children.cycles-pp.drm_client_modeset_commit
      0.29 ± 21%      -0.1        0.17 ± 47%  perf-profile.children.cycles-pp.drm_client_modeset_commit_locked
      0.29 ± 21%      -0.1        0.17 ± 47%  perf-profile.children.cycles-pp.drm_client_modeset_commit_atomic
      0.28 ±  4%      -0.1        0.16 ± 48%  perf-profile.children.cycles-pp.get_page_from_freelist
      0.20 ± 15%      -0.1        0.08 ± 30%  perf-profile.children.cycles-pp.unmap_vmas
      0.16 ± 21%      -0.1        0.04 ± 76%  perf-profile.children.cycles-pp.copy_pte_range
      0.18 ±  9%      -0.1        0.07 ± 71%  perf-profile.children.cycles-pp.__x64_sys_fcntl
      0.22 ±  7%      -0.1        0.10 ± 36%  perf-profile.children.cycles-pp.__x64_sys_poll
      0.22 ±  7%      -0.1        0.10 ±  9%  perf-profile.children.cycles-pp.__check_object_size
      0.18 ± 12%      -0.1        0.07 ± 25%  perf-profile.children.cycles-pp.unmap_page_range
      0.20 ±  8%      -0.1        0.09 ± 33%  perf-profile.children.cycles-pp.do_sys_poll
      0.15 ±  7%      -0.1        0.05 ± 72%  perf-profile.children.cycles-pp.__might_sleep
      0.15 ±  8%      -0.1        0.05 ± 78%  perf-profile.children.cycles-pp.obj_cgroup_charge
      0.15 ±  9%      -0.1        0.06 ± 16%  perf-profile.children.cycles-pp.zap_pte_range
      0.17 ± 20%      -0.1        0.07 ± 72%  perf-profile.children.cycles-pp.__slab_alloc
      0.16 ± 22%      -0.1        0.07 ± 72%  perf-profile.children.cycles-pp.___slab_alloc
      0.14 ± 19%      -0.1        0.04 ± 71%  perf-profile.children.cycles-pp.unlink_anon_vmas
      0.17 ± 38%      -0.1        0.07 ± 74%  perf-profile.children.cycles-pp.block_ioctl
      0.16 ±  9%      -0.1        0.07 ± 20%  perf-profile.children.cycles-pp.anon_vma_fork
      0.18 ±  5%      -0.1        0.09 ± 18%  perf-profile.children.cycles-pp.___might_sleep
      0.14 ± 32%      -0.1        0.05 ± 81%  perf-profile.children.cycles-pp.drm_stub_open
      0.14 ± 32%      -0.1        0.05 ± 81%  perf-profile.children.cycles-pp.drm_open
      0.14 ± 32%      -0.1        0.05 ± 81%  perf-profile.children.cycles-pp.drm_master_open
      0.16 ±  9%      -0.1        0.07 ± 23%  perf-profile.children.cycles-pp.get_obj_cgroup_from_current
      0.16 ± 38%      -0.1        0.07 ± 74%  perf-profile.children.cycles-pp.blkdev_ioctl
      0.12 ± 12%      -0.1        0.04 ± 71%  perf-profile.children.cycles-pp._cond_resched
      0.12 ±  8%      -0.1        0.04 ± 73%  perf-profile.children.cycles-pp.memset_erms
      0.14 ± 25%      -0.1        0.06 ± 72%  perf-profile.children.cycles-pp.allocate_slab
      0.12 ± 13%      -0.1        0.04 ± 71%  perf-profile.children.cycles-pp.call_rcu
      0.17 ± 25%      -0.1        0.09 ± 50%  perf-profile.children.cycles-pp.path_lookupat
      0.17 ± 30%      -0.1        0.10 ± 61%  perf-profile.children.cycles-pp.__fxstat64
      0.11 ± 12%      -0.1        0.03 ± 70%  perf-profile.children.cycles-pp.anon_vma_clone
      0.11 ± 10%      -0.1        0.03 ± 70%  perf-profile.children.cycles-pp.__mod_memcg_lruvec_state
      0.15 ± 16%      -0.1        0.08 ± 10%  perf-profile.children.cycles-pp.pick_next_task_fair
      0.14 ±  6%      -0.1        0.07 ± 11%  perf-profile.children.cycles-pp.syscall_enter_from_user_mode
      0.10 ± 12%      -0.1        0.03 ± 70%  perf-profile.children.cycles-pp.cp_new_stat
      0.13 ± 10%      -0.1        0.06 ± 19%  perf-profile.children.cycles-pp.__d_lookup_rcu
      0.10 ± 15%      -0.1        0.04 ± 73%  perf-profile.children.cycles-pp.generic_permission
      0.14 ±  9%      -0.1        0.08 ± 20%  perf-profile.children.cycles-pp.__x86_retpoline_rax
      0.08 ±  5%      -0.1        0.03 ± 70%  perf-profile.children.cycles-pp.ktime_get_ts64
      0.09 ±  4%      -0.1        0.04 ± 71%  perf-profile.children.cycles-pp.__might_fault
      0.07 ± 17%      -0.0        0.03 ± 70%  perf-profile.children.cycles-pp.schedule_timeout
      0.11 ±  9%      -0.0        0.08 ± 12%  perf-profile.children.cycles-pp.update_load_avg
      0.09 ±  8%      -0.0        0.06 ±  8%  perf-profile.children.cycles-pp.newidle_balance
      0.10 ± 14%      -0.0        0.07 ±  7%  perf-profile.children.cycles-pp.task_tick_fair
      0.06 ± 15%      +0.0        0.08 ± 16%  perf-profile.children.cycles-pp.tick_irq_enter
      0.04 ± 57%      +0.0        0.06        perf-profile.children.cycles-pp.sched_clock_cpu
      0.08 ± 13%      +0.0        0.11 ±  4%  perf-profile.children.cycles-pp.irq_enter_rcu
      0.07 ±  5%      +0.0        0.12 ± 24%  perf-profile.children.cycles-pp.clockevents_program_event
      0.01 ±173%      +0.1        0.07 ± 18%  perf-profile.children.cycles-pp.rebalance_domains
      0.09 ±  4%      +0.1        0.15 ± 26%  perf-profile.children.cycles-pp.ktime_get
      0.16 ±  9%      +0.1        0.23 ±  7%  perf-profile.children.cycles-pp.menu_select
      0.21 ± 11%      +0.1        0.28 ± 16%  perf-profile.children.cycles-pp.io_serial_out
      0.15 ± 20%      +0.1        0.23 ±  6%  perf-profile.children.cycles-pp.delay_tsc
      1.83 ± 14%      +0.5        2.38 ± 12%  perf-profile.children.cycles-pp.serial8250_console_putchar
      1.85 ± 14%      +0.6        2.40 ± 12%  perf-profile.children.cycles-pp.wait_for_xmitr
      1.99 ± 15%      +0.6        2.56 ± 16%  perf-profile.children.cycles-pp.__dynamic_pr_debug
      1.82 ± 13%      +0.6        2.39 ± 17%  perf-profile.children.cycles-pp.create_basic_memory_bitmaps
      2.13 ± 13%      +0.6        2.74 ± 13%  perf-profile.children.cycles-pp.console_unlock
      2.03 ± 13%      +0.6        2.65 ± 12%  perf-profile.children.cycles-pp.uart_console_write
      2.17 ± 15%      +0.6        2.79 ± 14%  perf-profile.children.cycles-pp.printk
      2.17 ± 15%      +0.6        2.79 ± 14%  perf-profile.children.cycles-pp.vprintk_emit
      2.05 ± 13%      +0.6        2.67 ± 12%  perf-profile.children.cycles-pp.serial8250_console_write
      0.00            +3.7        3.73 ± 66%  perf-profile.children.cycles-pp.__cna_queued_spin_lock_slowpath
      2.92 ±  6%      -1.5        1.44 ± 22%  perf-profile.self.cycles-pp.syscall_exit_to_user_mode
      1.48 ±  5%      -0.7        0.74 ± 28%  perf-profile.self.cycles-pp.syscall_return_via_sysret
      1.25 ±  6%      -0.6        0.62 ± 28%  perf-profile.self.cycles-pp.__entry_text_start
      0.52 ± 18%      -0.4        0.13 ± 34%  perf-profile.self.cycles-pp.apparmor_file_open
      0.50 ± 32%      -0.4        0.13 ± 54%  perf-profile.self.cycles-pp.rwsem_spin_on_owner
      0.44 ±  5%      -0.3        0.13 ± 36%  perf-profile.self.cycles-pp.lockref_put_or_lock
      0.38 ± 12%      -0.3        0.12 ± 18%  perf-profile.self.cycles-pp.apparmor_file_alloc_security
      0.52 ±  4%      -0.3        0.27 ± 25%  perf-profile.self.cycles-pp._raw_spin_lock
      0.28 ± 22%      -0.2        0.05 ± 72%  perf-profile.self.cycles-pp.aa_get_task_label
      0.45 ±  7%      -0.2        0.24 ± 20%  perf-profile.self.cycles-pp.kmem_cache_alloc
      0.39 ± 10%      -0.2        0.19 ± 36%  perf-profile.self.cycles-pp.__fget_files
      0.28 ± 19%      -0.2        0.08 ± 11%  perf-profile.self.cycles-pp.apparmor_file_free_security
      0.30 ±  8%      -0.2        0.11 ± 36%  perf-profile.self.cycles-pp.do_dentry_open
      0.21 ± 21%      -0.2        0.04 ± 76%  perf-profile.self.cycles-pp.mutex_lock
      0.20 ±  3%      -0.1        0.06 ± 71%  perf-profile.self.cycles-pp.lockref_get_not_dead
      0.20 ± 11%      -0.1        0.06 ± 73%  perf-profile.self.cycles-pp.vm_unmapped_area
      0.18 ±  8%      -0.1        0.06 ± 73%  perf-profile.self.cycles-pp.common_file_perm
      0.17 ± 14%      -0.1        0.04 ± 76%  perf-profile.self.cycles-pp.kobject_put
      0.27 ± 15%      -0.1        0.15 ± 25%  perf-profile.self.cycles-pp.__alloc_file
      0.16 ± 39%      -0.1        0.05 ± 78%  perf-profile.self.cycles-pp.rwsem_down_write_slowpath
      0.16 ± 11%      -0.1        0.05 ± 77%  perf-profile.self.cycles-pp.fput_many
      0.14 ±  7%      -0.1        0.04 ± 71%  perf-profile.self.cycles-pp.__might_sleep
      0.18 ±  5%      -0.1        0.09 ± 30%  perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.14 ± 11%      -0.1        0.04 ± 71%  perf-profile.self.cycles-pp.do_sys_openat2
      0.15 ±  5%      -0.1        0.06 ± 73%  perf-profile.self.cycles-pp.__fput
      0.20 ±  5%      -0.1        0.11 ± 31%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.13 ± 14%      -0.1        0.04 ± 70%  perf-profile.self.cycles-pp.link_path_walk
      0.18 ±  8%      -0.1        0.09 ± 18%  perf-profile.self.cycles-pp.___might_sleep
      0.13 ± 14%      -0.1        0.04 ± 71%  perf-profile.self.cycles-pp.get_obj_cgroup_from_current
      0.12 ±  6%      -0.1        0.04 ± 73%  perf-profile.self.cycles-pp.do_mmap
      0.12 ± 10%      -0.1        0.05 ± 71%  perf-profile.self.cycles-pp.__x86_retpoline_rax
      0.12 ± 24%      -0.1        0.05 ± 72%  perf-profile.self.cycles-pp.allocate_slab
      0.12 ±  8%      -0.1        0.06 ± 19%  perf-profile.self.cycles-pp.__d_lookup_rcu
      0.10 ± 13%      -0.1        0.04 ± 71%  perf-profile.self.cycles-pp.generic_permission
      0.09 ±  8%      -0.1        0.04 ± 71%  perf-profile.self.cycles-pp.entry_SYSCALL_64_safe_stack
      0.10 ±  4%      -0.0        0.05 ±  8%  perf-profile.self.cycles-pp.syscall_enter_from_user_mode
      0.07 ± 17%      +0.0        0.11 ±  8%  perf-profile.self.cycles-pp.cpuidle_enter_state
      0.10 ±  9%      +0.0        0.14 ± 10%  perf-profile.self.cycles-pp.menu_select
      0.03 ±100%      +0.1        0.09 ± 36%  perf-profile.self.cycles-pp.ktime_get
      0.15 ± 20%      +0.1        0.23 ±  6%  perf-profile.self.cycles-pp.delay_tsc
      0.20 ± 16%      +0.1        0.28 ± 16%  perf-profile.self.cycles-pp.io_serial_out
      0.00            +3.7        3.73 ± 66%  perf-profile.self.cycles-pp.__cna_queued_spin_lock_slowpath


                                                                                
                             stress-ng.zero.ops_per_sec                         
                                                                                
  400000 +------------------------------------------------------------------+   
         |.+.. .+..                     .+..+.  .+.+..       +..            |   
  350000 |-+  +    +    +.+..+.+.. .+..+    O +. O O  +.+..O+O  +.+..+.+..+.|   
         | O       : O  : O    O  +    O O                 +      O  O O    |   
  300000 |-+       :    :    O                                              |   
  250000 |-+        :  :                                                    |   
         |          :  :                                                    |   
  200000 |-+        :  :                                                    |   
         |          :  :                                                    |   
  150000 |-+        : :                                                     |   
  100000 |-+        : :                                                     |   
         |           ::                                                     |   
   50000 |-+         ::                                                     |   
         |           :                                                      |   
       0 +------------------------------------------------------------------+   
                                                                                
                                                                                
[*] bisect-good sample
[O] bisect-bad  sample

***************************************************************************************************
lkp-csl-2ap2: 192 threads Intel(R) Xeon(R) Platinum 9242 CPU @ 2.30GHz with 192G memory
=========================================================================================
compiler/cpufreq_governor/disk/filesize/fs/iterations/kconfig/nr_threads/rootfs/sync_method/tbox_group/test_size/testcase/ucode:
  gcc-9/performance/1BRD_48G/4M/btrfs/1x/x86_64-rhel-8.3/64t/debian-10.4-x86_64-20200603.cgz/NoSync/lkp-csl-2ap2/24G/fsmark/0x5003003

commit: 
  cb45bab007 ("locking/qspinlock: Refactor the qspinlock slow path")
  0e8d8f4f12 ("locking/qspinlock: Introduce CNA into the slow path of qspinlock")

cb45bab007ff0cfc 0e8d8f4f1214cfbac219d6917b5 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
      1180 ±  2%    +213.9%       3706 ± 11%  fsmark.files_per_sec
    773.00 ±  4%     -30.2%     539.75 ±  7%  fsmark.time.percent_of_cpu_this_job_got
    137.19 ±  3%     -28.5%      98.13 ±  8%  fsmark.time.system_time
     48917 ±  4%      -9.0%      44537 ±  8%  meminfo.AnonHugePages
      4.83 ±  4%      -1.0        3.83 ±  5%  mpstat.cpu.all.sys%
     93.48            +1.1%      94.51        iostat.cpu.idle
      5.76 ±  2%     -16.9%       4.79 ±  6%  iostat.cpu.system
     93.00            +1.1%      94.00        vmstat.cpu.id
     20606 ±  5%     +97.4%      40682 ± 34%  vmstat.system.cs
   4237881 ± 29%    +321.3%   17854499 ±106%  cpuidle.C1.time
     44169 ± 32%    +396.5%     219318 ±113%  cpuidle.C1.usage
     72208 ±  6%    +191.8%     210719 ± 39%  cpuidle.POLL.time
     36708 ±  9%    +306.0%     149034 ± 48%  cpuidle.POLL.usage
      2157 ±  2%     +13.8%       2454 ±  6%  slabinfo.biovec-max.active_objs
      2271 ±  2%     +12.8%       2561 ±  5%  slabinfo.biovec-max.num_objs
      6624           +13.4%       7512 ±  5%  slabinfo.btrfs_delayed_node.active_objs
      6768           +12.1%       7589 ±  5%  slabinfo.btrfs_delayed_node.num_objs
     47815 ± 86%     -89.2%       5149 ±  6%  sched_debug.cfs_rq:/.load.stddev
    142.69 ± 15%     +66.8%     237.99 ± 13%  sched_debug.cfs_rq:/.load_avg.avg
      1598 ± 30%     +92.4%       3075 ± 20%  sched_debug.cfs_rq:/.load_avg.max
    383.38 ± 21%     +90.4%     730.10 ± 13%  sched_debug.cfs_rq:/.load_avg.stddev
     37712 ± 16%     -27.1%      27508 ± 16%  sched_debug.cfs_rq:/.min_vruntime.avg
     58.89 ± 49%     +57.8%      92.96 ±  5%  sched_debug.cfs_rq:/.util_est_enqueued.stddev
      1901 ±  4%      -8.3%       1743 ±  3%  proc-vmstat.nr_active_anon
   5055884            +3.2%    5219972        proc-vmstat.nr_file_pages
   4788961 ±  2%      +3.4%    4953360        proc-vmstat.nr_inactive_file
     36576 ±  2%      -4.1%      35069        proc-vmstat.nr_kernel_stack
      9756            -1.6%       9601        proc-vmstat.nr_mapped
      5205 ±  2%      -5.1%       4939        proc-vmstat.nr_shmem
      1901 ±  4%      -8.3%       1743 ±  3%  proc-vmstat.nr_zone_active_anon
   4788961 ±  2%      +3.4%    4953360        proc-vmstat.nr_zone_inactive_file
      4864 ±  5%      -8.2%       4465        proc-vmstat.pgactivate
 2.507e+09            -8.7%   2.29e+09        perf-stat.i.branch-instructions
  71942409            -5.3%   68125925 ±  2%  perf-stat.i.cache-misses
 4.372e+10           -18.5%  3.565e+10 ±  3%  perf-stat.i.cpu-cycles
 1.231e+10            -7.5%  1.138e+10        perf-stat.i.instructions
      2515 ±  8%     -11.4%       2228 ±  5%  perf-stat.i.instructions-per-iTLB-miss
      0.23           -17.3%       0.19 ±  3%  perf-stat.i.metric.GHz
      0.71 ± 19%     +37.6%       0.97 ± 17%  perf-stat.i.metric.K/sec
     35.43            -6.2%      33.24 ±  2%  perf-stat.i.metric.M/sec
      3.58            -8.5%       3.28        perf-stat.overall.cpi
    612.62            -9.0%     557.36 ±  3%  perf-stat.overall.cycles-between-cache-misses
      2610 ±  6%     -11.9%       2299 ±  4%  perf-stat.overall.instructions-per-iTLB-miss
      0.28            +9.3%       0.31        perf-stat.overall.ipc
  2.39e+09 ±  2%      -6.3%  2.239e+09        perf-stat.ps.branch-instructions
  68534728 ±  2%      -4.6%   65359103 ±  2%  perf-stat.ps.cache-misses
 4.199e+10 ±  2%     -13.3%  3.641e+10        perf-stat.ps.cpu-cycles
 1.173e+10 ±  2%      -5.3%  1.112e+10        perf-stat.ps.instructions
    226946 ± 18%     +44.8%     328685 ± 19%  numa-meminfo.node0.AnonPages
    249710 ± 18%     +41.9%     354296 ± 20%  numa-meminfo.node0.AnonPages.max
    233745 ± 17%     +42.0%     331984 ± 20%  numa-meminfo.node0.Inactive(anon)
      8680 ± 73%    +135.9%      20474 ± 28%  numa-meminfo.node0.PageTables
    250653 ±  2%      +6.8%     267784 ±  5%  numa-meminfo.node0.Unevictable
   2890241 ±  9%     -58.3%    1206212 ± 10%  numa-meminfo.node0.Writeback
    338312 ± 83%    +111.9%     716979 ± 64%  numa-meminfo.node1.Dirty
      8444 ± 82%    +169.8%      22785 ± 37%  numa-meminfo.node2.AnonHugePages
    236489 ± 16%    +142.5%     573382 ± 36%  numa-meminfo.node2.Dirty
   2484617 ± 13%    +117.6%    5406277 ± 50%  numa-meminfo.node2.FilePages
   2459002 ± 19%    +115.1%    5290461 ± 51%  numa-meminfo.node2.Inactive
   2216704 ± 16%    +131.7%    5135596 ± 53%  numa-meminfo.node2.Inactive(file)
    871702 ± 16%     +52.8%    1331684 ±  6%  numa-meminfo.node2.Writeback
      3888 ± 16%     -24.5%       2937 ±  6%  numa-meminfo.node3.Active(anon)
     57796 ± 19%     -49.7%      29078 ± 34%  numa-meminfo.node3.KReclaimable
     57796 ± 19%     -49.7%      29078 ± 34%  numa-meminfo.node3.SReclaimable
    130240 ±  7%     -30.1%      91037 ± 15%  numa-meminfo.node3.Slab
     56616 ± 18%     +45.2%      82199 ± 19%  numa-vmstat.node0.nr_anon_pages
     58314 ± 17%     +42.4%      83024 ± 20%  numa-vmstat.node0.nr_inactive_anon
      2172 ± 73%    +135.7%       5122 ± 28%  numa-vmstat.node0.nr_page_table_pages
     62662 ±  2%      +6.8%      66945 ±  5%  numa-vmstat.node0.nr_unevictable
    738434 ±  9%     -59.3%     300391 ± 10%  numa-vmstat.node0.nr_writeback
     58312 ± 17%     +42.4%      83023 ± 20%  numa-vmstat.node0.nr_zone_inactive_anon
     62662 ±  2%      +6.8%      66945 ±  5%  numa-vmstat.node0.nr_zone_unevictable
    926442 ±  6%     -53.1%     434282 ± 12%  numa-vmstat.node0.nr_zone_write_pending
     84324 ± 81%    +112.0%     178764 ± 64%  numa-vmstat.node1.nr_dirty
    427046 ± 84%     +74.8%     746464 ± 46%  numa-vmstat.node1.nr_zone_write_pending
    627042 ± 18%    +129.0%    1435752 ± 55%  numa-vmstat.node2.nr_dirtied
     59963 ± 18%    +137.8%     142585 ± 36%  numa-vmstat.node2.nr_dirty
    634106 ± 15%    +112.1%    1345185 ± 50%  numa-vmstat.node2.nr_file_pages
    567086 ± 17%    +125.3%    1277507 ± 53%  numa-vmstat.node2.nr_inactive_file
    223407 ± 17%     +48.3%     331299 ±  7%  numa-vmstat.node2.nr_writeback
    567087 ± 17%    +125.3%    1277515 ± 53%  numa-vmstat.node2.nr_zone_inactive_file
    283372 ± 17%     +67.2%     473906 ±  8%  numa-vmstat.node2.nr_zone_write_pending
    922.00 ± 19%     -20.0%     737.25 ±  6%  numa-vmstat.node3.nr_active_anon
     14591 ± 20%     -50.1%       7276 ± 35%  numa-vmstat.node3.nr_slab_reclaimable
    922.00 ± 19%     -20.0%     737.25 ±  6%  numa-vmstat.node3.nr_zone_active_anon
    141466 ± 17%    +523.4%     881964 ± 85%  numa-vmstat.node3.numa_other
    282981 ± 14%     +46.6%     414731 ± 12%  interrupts.CAL:Function_call_interrupts
    770.00 ± 51%     -56.5%     335.00 ± 59%  interrupts.CPU0.NMI:Non-maskable_interrupts
    770.00 ± 51%     -56.5%     335.00 ± 59%  interrupts.CPU0.PMI:Performance_monitoring_interrupts
    346.25 ± 15%     -46.7%     184.50 ± 23%  interrupts.CPU110.NMI:Non-maskable_interrupts
    346.25 ± 15%     -46.7%     184.50 ± 23%  interrupts.CPU110.PMI:Performance_monitoring_interrupts
      1359 ± 14%     +31.7%       1789 ± 17%  interrupts.CPU128.CAL:Function_call_interrupts
      1378 ± 14%   +2294.9%      33020 ±164%  interrupts.CPU153.CAL:Function_call_interrupts
    214.50 ± 34%     +91.7%     411.25 ± 39%  interrupts.CPU16.NMI:Non-maskable_interrupts
    214.50 ± 34%     +91.7%     411.25 ± 39%  interrupts.CPU16.PMI:Performance_monitoring_interrupts
    403.50 ± 35%     -40.3%     241.00 ±  8%  interrupts.CPU169.NMI:Non-maskable_interrupts
    403.50 ± 35%     -40.3%     241.00 ±  8%  interrupts.CPU169.PMI:Performance_monitoring_interrupts
    439.00 ± 50%     -51.5%     212.75 ± 22%  interrupts.CPU170.NMI:Non-maskable_interrupts
    439.00 ± 50%     -51.5%     212.75 ± 22%  interrupts.CPU170.PMI:Performance_monitoring_interrupts
      1062 ±116%     -77.3%     240.75 ± 23%  interrupts.CPU174.NMI:Non-maskable_interrupts
      1062 ±116%     -77.3%     240.75 ± 23%  interrupts.CPU174.PMI:Performance_monitoring_interrupts
    291.25 ± 31%     -34.2%     191.75 ± 30%  interrupts.CPU2.NMI:Non-maskable_interrupts
    291.25 ± 31%     -34.2%     191.75 ± 30%  interrupts.CPU2.PMI:Performance_monitoring_interrupts
    342.00 ± 43%     -58.3%     142.75 ± 16%  interrupts.CPU22.NMI:Non-maskable_interrupts
    342.00 ± 43%     -58.3%     142.75 ± 16%  interrupts.CPU22.PMI:Performance_monitoring_interrupts
    241.25 ± 22%     -42.6%     138.50 ± 22%  interrupts.CPU23.NMI:Non-maskable_interrupts
    241.25 ± 22%     -42.6%     138.50 ± 22%  interrupts.CPU23.PMI:Performance_monitoring_interrupts
      1365 ± 14%     +49.5%       2041 ± 24%  interrupts.CPU35.CAL:Function_call_interrupts
    222.00 ± 94%    +175.1%     610.75 ± 51%  interrupts.CPU63.NMI:Non-maskable_interrupts
    222.00 ± 94%    +175.1%     610.75 ± 51%  interrupts.CPU63.PMI:Performance_monitoring_interrupts
    146.75 ± 39%    +104.6%     300.25 ± 32%  interrupts.CPU64.NMI:Non-maskable_interrupts
    146.75 ± 39%    +104.6%     300.25 ± 32%  interrupts.CPU64.PMI:Performance_monitoring_interrupts
    557.00 ± 88%     -61.3%     215.75 ± 21%  interrupts.CPU74.NMI:Non-maskable_interrupts
    557.00 ± 88%     -61.3%     215.75 ± 21%  interrupts.CPU74.PMI:Performance_monitoring_interrupts
    319.25 ± 22%     -43.9%     179.25 ± 36%  interrupts.CPU75.NMI:Non-maskable_interrupts
    319.25 ± 22%     -43.9%     179.25 ± 36%  interrupts.CPU75.PMI:Performance_monitoring_interrupts
      1343 ± 15%     +23.0%       1652 ±  4%  interrupts.CPU80.CAL:Function_call_interrupts
      1095 ± 66%     -76.5%     257.00 ± 17%  interrupts.CPU96.NMI:Non-maskable_interrupts
      1095 ± 66%     -76.5%     257.00 ± 17%  interrupts.CPU96.PMI:Performance_monitoring_interrupts
    817.25 ± 12%     +62.6%       1329 ± 17%  interrupts.RES:Rescheduling_interrupts
     12.39 ± 23%      -8.2        4.22 ±  6%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe
     12.35 ± 24%      -8.1        4.21 ±  6%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe
     12.12 ± 24%      -8.0        4.08 ±  6%  perf-profile.calltrace.cycles-pp.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
     12.11 ± 24%      -8.0        4.07 ±  6%  perf-profile.calltrace.cycles-pp.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
     12.10 ± 24%      -8.0        4.06 ±  6%  perf-profile.calltrace.cycles-pp.btrfs_file_write_iter.new_sync_write.vfs_write.ksys_write.do_syscall_64
     12.07 ± 24%      -8.0        4.04 ±  6%  perf-profile.calltrace.cycles-pp.btrfs_buffered_write.btrfs_file_write_iter.new_sync_write.vfs_write.ksys_write
     12.28 ± 24%      -7.5        4.83 ±  5%  perf-profile.calltrace.cycles-pp.new_sync_write.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
      6.07 ± 31%      -6.1        0.00        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.__reserve_bytes.btrfs_reserve_metadata_bytes.btrfs_delalloc_reserve_metadata
      6.36 ± 30%      -4.8        1.55 ± 11%  perf-profile.calltrace.cycles-pp.btrfs_delalloc_reserve_metadata.btrfs_buffered_write.btrfs_file_write_iter.new_sync_write.vfs_write
      6.31 ± 30%      -4.8        1.51 ± 12%  perf-profile.calltrace.cycles-pp.__reserve_bytes.btrfs_reserve_metadata_bytes.btrfs_delalloc_reserve_metadata.btrfs_buffered_write.btrfs_file_write_iter
      6.31 ± 30%      -4.8        1.51 ± 12%  perf-profile.calltrace.cycles-pp.btrfs_reserve_metadata_bytes.btrfs_delalloc_reserve_metadata.btrfs_buffered_write.btrfs_file_write_iter.new_sync_write
      6.13 ± 31%      -4.8        1.38 ± 14%  perf-profile.calltrace.cycles-pp._raw_spin_lock.__reserve_bytes.btrfs_reserve_metadata_bytes.btrfs_delalloc_reserve_metadata.btrfs_buffered_write
      4.39 ± 18%      -3.2        1.21 ± 15%  perf-profile.calltrace.cycles-pp.btrfs_inode_rsv_release.btrfs_buffered_write.btrfs_file_write_iter.new_sync_write.vfs_write
      4.38 ± 18%      -3.2        1.20 ± 15%  perf-profile.calltrace.cycles-pp.btrfs_block_rsv_release.btrfs_inode_rsv_release.btrfs_buffered_write.btrfs_file_write_iter.new_sync_write
      4.21 ± 19%      -3.1        1.09 ± 20%  perf-profile.calltrace.cycles-pp._raw_spin_lock.btrfs_block_rsv_release.btrfs_inode_rsv_release.btrfs_buffered_write.btrfs_file_write_iter
      0.13 ±173%      +0.5        0.63 ±  6%  perf-profile.calltrace.cycles-pp.tick_nohz_irq_exit.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter
      4.51 ±  6%      +0.5        5.04 ±  3%  perf-profile.calltrace.cycles-pp.asm_call_sysvec_on_stack.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter
      4.48 ±  5%      +0.5        5.02 ±  3%  perf-profile.calltrace.cycles-pp.__sysvec_apic_timer_interrupt.asm_call_sysvec_on_stack.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state
      4.37 ±  6%      +0.6        4.93 ±  3%  perf-profile.calltrace.cycles-pp.hrtimer_interrupt.__sysvec_apic_timer_interrupt.asm_call_sysvec_on_stack.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      0.18 ±173%      +0.6        0.75 ± 27%  perf-profile.calltrace.cycles-pp.console_unlock.vprintk_emit.devkmsg_emit.devkmsg_write.cold.new_sync_write
      0.18 ±173%      +0.6        0.76 ± 27%  perf-profile.calltrace.cycles-pp.vprintk_emit.devkmsg_emit.devkmsg_write.cold.new_sync_write.vfs_write
      0.18 ±173%      +0.6        0.76 ± 27%  perf-profile.calltrace.cycles-pp.devkmsg_write.cold.new_sync_write.vfs_write.ksys_write.do_syscall_64
      0.18 ±173%      +0.6        0.76 ± 27%  perf-profile.calltrace.cycles-pp.devkmsg_emit.devkmsg_write.cold.new_sync_write.vfs_write.ksys_write
      0.18 ±173%      +0.6        0.77 ± 27%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.write
      0.18 ±173%      +0.6        0.77 ± 27%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
      0.18 ±173%      +0.6        0.77 ± 27%  perf-profile.calltrace.cycles-pp.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
      0.18 ±173%      +0.6        0.77 ± 27%  perf-profile.calltrace.cycles-pp.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
      0.18 ±173%      +0.6        0.77 ± 27%  perf-profile.calltrace.cycles-pp.write
      0.00            +0.6        0.62 ±  7%  perf-profile.calltrace.cycles-pp.ktime_get.tick_nohz_irq_exit.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state
      0.00            +1.1        1.06 ± 21%  perf-profile.calltrace.cycles-pp.__cna_queued_spin_lock_slowpath._raw_spin_lock.btrfs_block_rsv_release.btrfs_inode_rsv_release.btrfs_buffered_write
      7.48 ±  5%      +1.2        8.68 ±  2%  perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter.do_idle
      0.00            +1.3        1.33 ± 15%  perf-profile.calltrace.cycles-pp.__cna_queued_spin_lock_slowpath._raw_spin_lock.__reserve_bytes.btrfs_reserve_metadata_bytes.btrfs_delalloc_reserve_metadata
     11.79 ±  8%      +2.8       14.63 ±  8%  perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry
      9.11 ± 14%      +4.4       13.51 ± 18%  perf-profile.calltrace.cycles-pp.menu_select.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     10.58 ± 26%     -10.6        0.00        perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
     12.10 ± 24%      -8.0        4.06 ±  6%  perf-profile.children.cycles-pp.btrfs_file_write_iter
     12.07 ± 24%      -8.0        4.04 ±  6%  perf-profile.children.cycles-pp.btrfs_buffered_write
     14.00 ± 18%      -7.9        6.09 ±  7%  perf-profile.children.cycles-pp._raw_spin_lock
     12.64 ± 23%      -7.8        4.85 ±  5%  perf-profile.children.cycles-pp.ksys_write
     12.62 ± 24%      -7.8        4.83 ±  5%  perf-profile.children.cycles-pp.new_sync_write
     12.63 ± 23%      -7.8        4.85 ±  5%  perf-profile.children.cycles-pp.vfs_write
     13.17 ± 23%      -7.6        5.60 ±  6%  perf-profile.children.cycles-pp.do_syscall_64
     13.24 ± 23%      -7.3        5.92 ±  6%  perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
      6.38 ± 30%      -4.8        1.55 ± 12%  perf-profile.children.cycles-pp.__reserve_bytes
      6.33 ± 30%      -4.8        1.52 ± 12%  perf-profile.children.cycles-pp.btrfs_reserve_metadata_bytes
      6.36 ± 30%      -4.8        1.55 ± 11%  perf-profile.children.cycles-pp.btrfs_delalloc_reserve_metadata
      4.49 ± 18%      -3.3        1.23 ± 15%  perf-profile.children.cycles-pp.btrfs_block_rsv_release
      4.39 ± 18%      -3.2        1.21 ± 15%  perf-profile.children.cycles-pp.btrfs_inode_rsv_release
      0.16 ± 77%      -0.1        0.06 ±  7%  perf-profile.children.cycles-pp.do_filp_open
      0.16 ± 77%      -0.1        0.06 ±  7%  perf-profile.children.cycles-pp.path_openat
      0.16 ± 75%      -0.1        0.06 ±  6%  perf-profile.children.cycles-pp.do_sys_open
      0.16 ± 75%      -0.1        0.06 ±  6%  perf-profile.children.cycles-pp.do_sys_openat2
      0.21 ± 32%      -0.1        0.13 ± 29%  perf-profile.children.cycles-pp.rcu_sched_clock_irq
      0.22 ±  9%      -0.1        0.16 ±  6%  perf-profile.children.cycles-pp.update_blocked_averages
      0.10 ± 29%      -0.0        0.05 ± 70%  perf-profile.children.cycles-pp.update_ts_time_stats
      0.07 ± 12%      -0.0        0.04 ± 58%  perf-profile.children.cycles-pp.__pagevec_lru_add_fn
      0.16 ±  9%      +0.0        0.20 ± 12%  perf-profile.children.cycles-pp.brd_lookup_page
      0.13 ± 11%      +0.0        0.17 ± 18%  perf-profile.children.cycles-pp.__radix_tree_lookup
      0.14 ±  7%      +0.1        0.20 ±  9%  perf-profile.children.cycles-pp.__intel_pmu_enable_all
      0.48 ±  8%      +0.1        0.62 ±  8%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      0.51 ± 29%      +0.3        0.77 ± 27%  perf-profile.children.cycles-pp.write
      0.39 ± 32%      +0.3        0.65 ±  6%  perf-profile.children.cycles-pp.tick_nohz_irq_exit
      0.50 ± 30%      +0.3        0.76 ± 27%  perf-profile.children.cycles-pp.devkmsg_write.cold
      0.50 ± 30%      +0.3        0.76 ± 27%  perf-profile.children.cycles-pp.devkmsg_emit
      0.03 ±173%      +0.3        0.29 ±108%  perf-profile.children.cycles-pp.osq_lock
      0.03 ±173%      +0.3        0.29 ±107%  perf-profile.children.cycles-pp.__mutex_lock
      0.11 ±130%      +0.3        0.45 ± 68%  perf-profile.children.cycles-pp.__do_sys_finit_module
      0.11 ±130%      +0.3        0.45 ± 68%  perf-profile.children.cycles-pp.load_module
      0.11 ±130%      +0.3        0.45 ± 67%  perf-profile.children.cycles-pp.syscall
      0.14 ± 88%      +0.4        0.54 ± 53%  perf-profile.children.cycles-pp.wb_workfn
      0.14 ± 88%      +0.4        0.54 ± 53%  perf-profile.children.cycles-pp.wb_writeback
      0.14 ± 88%      +0.4        0.54 ± 53%  perf-profile.children.cycles-pp.writeback_sb_inodes
      0.12 ±105%      +0.4        0.53 ± 54%  perf-profile.children.cycles-pp.__writeback_single_inode
      4.76 ±  5%      +0.5        5.21 ±  3%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      4.65 ±  5%      +0.5        5.13 ±  2%  perf-profile.children.cycles-pp.hrtimer_interrupt
      6.15 ±  5%      +0.5        6.65 ±  2%  perf-profile.children.cycles-pp.asm_call_sysvec_on_stack
      2.06 ± 28%      +1.0        3.05 ±  9%  perf-profile.children.cycles-pp.ktime_get
      7.80 ±  4%      +1.1        8.94 ±  2%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
     10.10 ±  6%      +2.0       12.05 ±  6%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
      0.00            +2.6        2.56 ± 19%  perf-profile.children.cycles-pp.__cna_queued_spin_lock_slowpath
      9.16 ± 14%      +4.4       13.57 ± 18%  perf-profile.children.cycles-pp.menu_select
     10.50 ± 26%     -10.5        0.00        perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
      0.18 ± 30%      -0.1        0.11 ± 27%  perf-profile.self.cycles-pp.rcu_sched_clock_irq
      0.10 ± 11%      +0.0        0.13 ± 10%  perf-profile.self.cycles-pp.__extent_writepage
      0.14 ±  7%      +0.1        0.20 ±  9%  perf-profile.self.cycles-pp.__intel_pmu_enable_all
      0.08 ± 10%      +0.1        0.16 ± 22%  perf-profile.self.cycles-pp.end_page_writeback
      0.03 ±173%      +0.2        0.28 ±105%  perf-profile.self.cycles-pp.osq_lock
      1.77 ± 32%      +1.0        2.75 ± 10%  perf-profile.self.cycles-pp.ktime_get
      0.00            +2.5        2.51 ± 19%  perf-profile.self.cycles-pp.__cna_queued_spin_lock_slowpath
      7.68 ± 15%      +4.1       11.79 ± 21%  perf-profile.self.cycles-pp.menu_select



***************************************************************************************************
lkp-csl-2ap3: 192 threads Intel(R) Xeon(R) Platinum 9242 CPU @ 2.30GHz with 192G memory
=========================================================================================
compiler/cpufreq_governor/kconfig/nr_task/rootfs/runtime/tbox_group/test/testcase/ucode:
  gcc-9/performance/x86_64-rhel-8.3/100%/debian-10.4-x86_64-20200603.cgz/300s/lkp-csl-2ap3/new_fserver/reaim/0x5003003

commit: 
  cb45bab007 ("locking/qspinlock: Refactor the qspinlock slow path")
  0e8d8f4f12 ("locking/qspinlock: Introduce CNA into the slow path of qspinlock")

cb45bab007ff0cfc 0e8d8f4f1214cfbac219d6917b5 
---------------- --------------------------- 
       fail:runs  %reproduction    fail:runs
           |             |             |    
          1:4          -25%            :4     last_state.is_incomplete_run
          1:4          -25%            :4     last_state.wget_initrd
           :4            8%           0:4     perf-profile.children.cycles-pp.error_entry
         %stddev     %change         %stddev
             \          |                \  
    556.93           -64.1%     200.03        reaim.child_systime
     49.95            +3.6%      51.77        reaim.child_utime
    318145           +96.1%     623983        reaim.jobs_per_min
      1657           +96.1%       3249        reaim.jobs_per_min_child
     92.26            -7.8%      85.11        reaim.jti
    327019          +100.4%     655467        reaim.max_jobs_per_min
      3.55           -49.0%       1.81        reaim.parent_time
      7.19 ±  2%    +100.0%      14.38 ±  4%  reaim.std_dev_percent
      0.24 ±  2%      -7.3%       0.22 ±  2%  reaim.std_dev_time
    462973           +17.9%     545826        reaim.time.involuntary_context_switches
     38288           +98.5%      75996 ±  2%  reaim.time.major_page_faults
 1.041e+08           +44.8%  1.509e+08        reaim.time.minor_page_faults
     10863           -39.7%       6549        reaim.time.percent_of_cpu_this_job_got
     30257           -47.9%      15754        reaim.time.system_time
      2714           +50.2%       4077        reaim.time.user_time
   3000456 ±  2%     +38.9%    4167220 ±  2%  reaim.time.voluntary_context_switches
   1043200           +44.9%    1512000        reaim.workload
     29843           +40.0%      41767        uptime.idle
  20127118 ± 12%     +48.7%   29930674 ±  4%  cpuidle.C1.time
    284217 ±  9%     +66.1%     472177 ±  2%  cpuidle.C1.usage
    308815 ± 13%     +26.0%     389201 ± 16%  cpuidle.POLL.usage
     41.44           +20.8       62.28        mpstat.cpu.all.idle%
      0.69            +1.3        1.98 ±  2%  mpstat.cpu.all.soft%
     51.88           -24.6       27.26        mpstat.cpu.all.sys%
      4.60            +2.3        6.91        mpstat.cpu.all.usr%
     41.33           +50.0%      62.00        vmstat.cpu.id
     53.00           -43.4%      30.00        vmstat.cpu.sy
    110.00           -25.9%      81.50 ±  2%  vmstat.procs.r
     25559 ±  2%     +46.2%      37370        vmstat.system.cs
    269427 ±  4%     -12.8%     234969        meminfo.Active
    269427 ±  4%     -12.8%     234969        meminfo.Active(anon)
     32953            +9.7%      36144 ±  2%  meminfo.KernelStack
     19202           +63.2%      31338        meminfo.PageTables
    483410           +11.8%     540459        meminfo.SUnreclaim
    304770 ±  4%     -12.8%     265628        meminfo.Shmem
    620741           +10.5%     685878        meminfo.Slab
  18788579           +43.8%   27017272 ±  4%  numa-numastat.node0.local_node
  18827783           +43.8%   27074532 ±  4%  numa-numastat.node0.numa_hit
  19046024           +45.8%   27771991 ±  2%  numa-numastat.node1.local_node
  19126483           +45.6%   27844754 ±  2%  numa-numastat.node1.numa_hit
  18849870           +44.4%   27228340 ±  2%  numa-numastat.node2.local_node
  18926181           +44.1%   27271719 ±  2%  numa-numastat.node2.numa_hit
  18622314           +46.2%   27216882 ±  3%  numa-numastat.node3.local_node
  18686267           +46.1%   27303516 ±  3%  numa-numastat.node3.numa_hit
     42977 ± 81%     -79.9%       8629 ± 59%  numa-meminfo.node0.Active
     42977 ± 81%     -79.9%       8629 ± 59%  numa-meminfo.node0.Active(anon)
      7040           +24.4%       8759 ±  8%  numa-meminfo.node1.KernelStack
      2790 ± 11%    +140.4%       6708 ± 26%  numa-meminfo.node1.PageTables
    103698           +19.3%     123717 ±  9%  numa-meminfo.node1.SUnreclaim
    129487 ±  2%     +18.0%     152790 ±  7%  numa-meminfo.node1.Slab
     32541 ± 26%     +46.6%      47695 ± 24%  numa-meminfo.node2.KReclaimable
     32541 ± 26%     +46.6%      47695 ± 24%  numa-meminfo.node2.SReclaimable
    150472 ± 20%     +21.5%     182840 ± 15%  numa-meminfo.node2.Slab
    167884 ± 33%     +71.3%     287506 ± 45%  numa-meminfo.node3.AnonPages.max
      2974 ± 11%    +145.0%       7288 ± 28%  numa-meminfo.node3.PageTables
    109568 ±  4%     +13.7%     124544 ± 12%  numa-meminfo.node3.SUnreclaim
     10666 ± 81%     -79.8%       2152 ± 59%  numa-vmstat.node0.nr_active_anon
     10665 ± 81%     -79.8%       2152 ± 59%  numa-vmstat.node0.nr_zone_active_anon
   9854862           +41.8%   13975810 ±  2%  numa-vmstat.node0.numa_hit
   9773079           +41.9%   13870000 ±  2%  numa-vmstat.node0.numa_local
      7029           +25.1%       8796 ±  8%  numa-vmstat.node1.nr_kernel_stack
    678.67 ±  8%    +152.6%       1714 ± 26%  numa-vmstat.node1.nr_page_table_pages
     25872           +20.1%      31062 ±  9%  numa-vmstat.node1.nr_slab_unreclaimable
   9970820           +42.6%   14214395        numa-vmstat.node1.numa_hit
   9810384           +43.4%   14063434        numa-vmstat.node1.numa_local
      8132 ± 26%     +46.4%      11904 ± 24%  numa-vmstat.node2.nr_slab_reclaimable
   9969168           +43.4%   14294976 ±  2%  numa-vmstat.node2.numa_hit
   9812426           +44.6%   14186949 ±  3%  numa-vmstat.node2.numa_local
    726.67 ± 12%    +158.7%       1879 ± 26%  numa-vmstat.node3.nr_page_table_pages
     27327 ±  4%     +13.9%      31114 ± 12%  numa-vmstat.node3.nr_slab_unreclaimable
   9719726           +44.0%   13991557 ±  2%  numa-vmstat.node3.numa_hit
   9615461           +44.1%   13853485 ±  2%  numa-vmstat.node3.numa_local
    104269 ± 49%     +32.4%     138078 ± 20%  numa-vmstat.node3.numa_other
     67226 ±  4%     -12.4%      58905        proc-vmstat.nr_active_anon
    316527            -3.1%     306823        proc-vmstat.nr_file_pages
     92663            -2.9%      89935        proc-vmstat.nr_inactive_anon
     33012            +9.3%      36075 ±  2%  proc-vmstat.nr_kernel_stack
      4865           +59.3%       7749 ±  4%  proc-vmstat.nr_page_table_pages
     76214 ±  4%     -12.7%      66510        proc-vmstat.nr_shmem
     34346            +5.8%      36334        proc-vmstat.nr_slab_reclaimable
    120937           +11.5%     134852        proc-vmstat.nr_slab_unreclaimable
     67226 ±  4%     -12.4%      58905        proc-vmstat.nr_zone_active_anon
     92663            -2.9%      89935        proc-vmstat.nr_zone_inactive_anon
    152011 ±  9%     -72.0%      42500 ± 30%  proc-vmstat.numa_hint_faults
  75604538           +44.9%  1.095e+08        proc-vmstat.numa_hit
  75344552           +45.0%  1.093e+08        proc-vmstat.numa_local
    129725 ± 13%     -78.5%      27855 ± 33%  proc-vmstat.numa_pages_migrated
    440421 ±  8%     -27.0%     321634 ± 22%  proc-vmstat.numa_pte_updates
    187992 ±  4%      +5.4%     198156        proc-vmstat.pgactivate
  83223343           +45.7%  1.213e+08        proc-vmstat.pgalloc_normal
 1.056e+08           +44.3%  1.524e+08        proc-vmstat.pgfault
  83115624           +45.8%  1.212e+08        proc-vmstat.pgfree
    129725 ± 13%     -78.5%      27855 ± 33%  proc-vmstat.pgmigrate_success
  10628125           +46.1%   15525117        proc-vmstat.pgreuse
     13330 ± 54%    +717.2%     108933 ± 77%  sched_debug.cfs_rq:/.MIN_vruntime.avg
    184231 ± 54%    +190.7%     535537 ± 48%  sched_debug.cfs_rq:/.MIN_vruntime.stddev
      6040 ±  6%    +338.5%      26486 ± 51%  sched_debug.cfs_rq:/.load.avg
    284313 ± 37%    +159.7%     738429 ± 14%  sched_debug.cfs_rq:/.load.max
      1180 ± 35%    -100.0%       0.00        sched_debug.cfs_rq:/.load.min
     22088 ± 35%    +398.6%     110141 ± 30%  sched_debug.cfs_rq:/.load.stddev
     13330 ± 54%    +717.2%     108933 ± 77%  sched_debug.cfs_rq:/.max_vruntime.avg
    184231 ± 54%    +190.7%     535537 ± 48%  sched_debug.cfs_rq:/.max_vruntime.stddev
  16468615           -51.1%    8045534 ± 11%  sched_debug.cfs_rq:/.min_vruntime.avg
  16715699           -50.1%    8341867 ± 11%  sched_debug.cfs_rq:/.min_vruntime.max
  15817769           -51.3%    7697369 ± 11%  sched_debug.cfs_rq:/.min_vruntime.min
      0.71 ± 11%     -47.8%       0.37 ± 14%  sched_debug.cfs_rq:/.nr_running.avg
      1.17           +19.3%       1.39 ±  4%  sched_debug.cfs_rq:/.nr_running.max
      0.22 ± 35%    -100.0%       0.00        sched_debug.cfs_rq:/.nr_running.min
      0.14 ± 18%     +74.2%       0.25 ±  6%  sched_debug.cfs_rq:/.nr_running.stddev
    694.83 ± 15%     -51.9%     334.48 ± 20%  sched_debug.cfs_rq:/.runnable_avg.avg
    110.72 ± 51%     -90.4%      10.63 ±114%  sched_debug.cfs_rq:/.runnable_avg.min
    155.35 ± 11%     +42.5%     221.31 ±  9%  sched_debug.cfs_rq:/.runnable_avg.stddev
     64422 ± 94%    +295.3%     254650 ± 19%  sched_debug.cfs_rq:/.spread0.avg
    311765 ± 14%     +76.7%     550961 ± 14%  sched_debug.cfs_rq:/.spread0.max
   -587893           -84.1%     -93210        sched_debug.cfs_rq:/.spread0.min
    685.90 ± 14%     -56.7%     297.04 ± 23%  sched_debug.cfs_rq:/.util_avg.avg
    100.39 ± 59%     -90.9%       9.12 ±125%  sched_debug.cfs_rq:/.util_avg.min
    153.19 ± 12%     +28.3%     196.53 ± 12%  sched_debug.cfs_rq:/.util_avg.stddev
    398.32 ± 19%     -79.6%      81.24 ± 25%  sched_debug.cfs_rq:/.util_est_enqueued.avg
    932.06 ±  8%     -26.5%     684.67 ± 16%  sched_debug.cfs_rq:/.util_est_enqueued.max
      0.28 ± 28%    -100.0%       0.00        sched_debug.cfs_rq:/.util_est_enqueued.min
    186.70 ± 17%     -31.0%     128.84 ± 18%  sched_debug.cfs_rq:/.util_est_enqueued.stddev
     42223 ± 22%     +72.6%      72869 ± 21%  sched_debug.cpu.avg_idle.min
    513534 ± 67%     -58.1%     214959 ±  3%  sched_debug.cpu.avg_idle.stddev
     69440 ± 18%     -53.1%      32566 ± 23%  sched_debug.cpu.curr->pid.avg
    465.44 ± 54%    -100.0%       0.00        sched_debug.cpu.curr->pid.min
      0.71 ± 11%     -40.6%       0.42 ±  9%  sched_debug.cpu.nr_running.avg
      0.22 ± 35%    -100.0%       0.00        sched_debug.cpu.nr_running.min
      0.18 ± 10%     +68.8%       0.31 ±  5%  sched_debug.cpu.nr_running.stddev
     21723 ±  2%     +35.3%      29395 ±  9%  sched_debug.cpu.nr_switches.avg
     37415 ± 16%     +23.6%      46248 ±  5%  sched_debug.cpu.nr_switches.max
     17608           +44.3%      25417 ± 10%  sched_debug.cpu.nr_switches.min
    161.39 ± 12%     +47.1%     237.34 ± 18%  sched_debug.cpu.nr_uninterruptible.max
    -54.78           +48.6%     -81.42        sched_debug.cpu.nr_uninterruptible.min
     24.07 ±  4%     +58.5%      38.15 ± 11%  sched_debug.cpu.nr_uninterruptible.stddev
     11566           +11.1%      12849        slabinfo.Acpi-State.active_objs
     11566           +11.1%      12849        slabinfo.Acpi-State.num_objs
    240075           +13.6%     272838        slabinfo.dentry.active_objs
      5793           +13.6%       6580        slabinfo.dentry.active_slabs
    243365           +13.6%     276386        slabinfo.dentry.num_objs
      5793           +13.6%       6580        slabinfo.dentry.num_slabs
    955.00 ±  9%     +16.4%       1112 ±  7%  slabinfo.file_lock_cache.active_objs
    955.00 ±  9%     +16.4%       1112 ±  7%  slabinfo.file_lock_cache.num_objs
     14271           +14.7%      16366        slabinfo.files_cache.active_objs
     14271           +14.7%      16366        slabinfo.files_cache.num_objs
    145916           +52.7%     222770 ±  2%  slabinfo.filp.active_objs
      2300           +53.0%       3519 ±  2%  slabinfo.filp.active_slabs
    147261           +53.0%     225274 ±  2%  slabinfo.filp.num_objs
      2300           +53.0%       3519 ±  2%  slabinfo.filp.num_slabs
      1319 ± 14%     +26.2%       1664 ±  8%  slabinfo.khugepaged_mm_slot.active_objs
      1319 ± 14%     +26.2%       1664 ±  8%  slabinfo.khugepaged_mm_slot.num_objs
      1037           +19.6%       1240        slabinfo.kmalloc-512.active_slabs
     66437           +19.5%      79424        slabinfo.kmalloc-512.num_objs
      1037           +19.6%       1240        slabinfo.kmalloc-512.num_slabs
    114959            +9.0%     125273        slabinfo.kmalloc-8.active_objs
      4536 ±  5%      +7.2%       4862 ±  3%  slabinfo.kmalloc-rcl-64.active_objs
      4536 ±  5%      +7.2%       4862 ±  3%  slabinfo.kmalloc-rcl-64.num_objs
     10920           +18.9%      12978        slabinfo.mm_struct.active_objs
     10920           +18.9%      12979        slabinfo.mm_struct.num_objs
      1104 ±  5%     -16.9%     917.00 ± 10%  slabinfo.mnt_cache.active_objs
      1104 ±  5%     -16.9%     917.00 ± 10%  slabinfo.mnt_cache.num_objs
      1551           +14.3%       1773 ±  2%  slabinfo.names_cache.active_objs
      1551           +14.3%       1773 ±  2%  slabinfo.names_cache.num_objs
     35694 ±  2%     +49.3%      53295 ±  4%  slabinfo.pid.active_objs
    557.00 ±  2%     +49.4%     832.25 ±  4%  slabinfo.pid.active_slabs
     35694 ±  2%     +49.3%      53295 ±  4%  slabinfo.pid.num_objs
    557.00 ±  2%     +49.4%     832.25 ±  4%  slabinfo.pid.num_slabs
      8786           +20.2%      10558        slabinfo.sighand_cache.active_objs
    590.00           +20.3%     709.75        slabinfo.sighand_cache.active_slabs
      8858           +20.3%      10654        slabinfo.sighand_cache.num_objs
    590.00           +20.3%     709.75        slabinfo.sighand_cache.num_slabs
      8502           +11.6%       9489 ±  2%  slabinfo.sock_inode_cache.active_objs
      8502           +11.6%       9489 ±  2%  slabinfo.sock_inode_cache.num_objs
     39805 ±  2%     +45.4%      57892 ±  2%  slabinfo.task_delay_info.active_objs
    780.00 ±  2%     +45.5%       1135 ±  2%  slabinfo.task_delay_info.active_slabs
     39805 ±  2%     +45.5%      57905 ±  2%  slabinfo.task_delay_info.num_objs
    780.00 ±  2%     +45.5%       1135 ±  2%  slabinfo.task_delay_info.num_slabs
      3088           +29.3%       3992 ±  2%  slabinfo.task_struct.active_objs
      3098           +29.3%       4005 ±  2%  slabinfo.task_struct.active_slabs
      3098           +29.3%       4005 ±  2%  slabinfo.task_struct.num_objs
      3098           +29.3%       4005 ±  2%  slabinfo.task_struct.num_slabs
 1.353e+10           +11.8%  1.513e+10        perf-stat.i.branch-instructions
  84012986 ±  5%     +46.6%  1.232e+08 ±  6%  perf-stat.i.branch-misses
     31.81 ± 12%     -10.8       21.01 ± 21%  perf-stat.i.cache-miss-rate%
  68723351 ±  2%     -10.6%   61409511 ±  4%  perf-stat.i.cache-misses
 2.121e+08 ± 10%     +57.2%  3.333e+08 ±  8%  perf-stat.i.cache-references
     25583 ±  2%     +51.4%      38727        perf-stat.i.context-switches
      5.21 ±  3%     -25.2%       3.90 ±  5%  perf-stat.i.cpi
    192200            +7.5%     206633        perf-stat.i.cpu-clock
  3.37e+11           -28.3%  2.415e+11        perf-stat.i.cpu-cycles
      3432           +61.5%       5541 ±  3%  perf-stat.i.cpu-migrations
      4302           -29.4%       3039 ±  8%  perf-stat.i.cycles-between-cache-misses
   2726072 ± 23%     +52.3%    4151327 ± 26%  perf-stat.i.dTLB-load-misses
 1.215e+10            +6.3%  1.292e+10        perf-stat.i.dTLB-loads
    941111 ± 11%     +46.9%    1382681 ± 11%  perf-stat.i.dTLB-store-misses
 2.493e+09           +48.4%  3.701e+09        perf-stat.i.dTLB-stores
     71.80 ±  4%      -6.7       65.13        perf-stat.i.iTLB-load-miss-rate%
   8355924 ±  6%     +47.0%   12280660 ±  7%  perf-stat.i.iTLB-load-misses
   3268044 ± 18%     +65.6%    5412376 ±  8%  perf-stat.i.iTLB-loads
 6.464e+10           +19.2%  7.704e+10        perf-stat.i.instructions
      6911 ±  3%     -32.1%       4691 ±  6%  perf-stat.i.instructions-per-iTLB-miss
      0.23           +28.9%       0.30        perf-stat.i.ipc
    124.96          +101.4%     251.73 ±  2%  perf-stat.i.major-faults
      1.76           -41.2%       1.03        perf-stat.i.metric.GHz
      0.56 ±  8%     +32.5%       0.75 ±  7%  perf-stat.i.metric.K/sec
    332691           +49.2%     496370        perf-stat.i.minor-faults
     91.27            -4.0       87.22        perf-stat.i.node-load-miss-rate%
  18748059           -13.0%   16311904 ±  3%  perf-stat.i.node-load-misses
   1587953           +50.0%    2382313        perf-stat.i.node-loads
     86.40            -8.3       78.07 ±  2%  perf-stat.i.node-store-miss-rate%
   9547999           -19.9%    7644037 ±  2%  perf-stat.i.node-store-misses
   1064509           +92.2%    2045699 ±  2%  perf-stat.i.node-stores
    332816           +49.2%     496622        perf-stat.i.page-faults
    192200            +7.5%     206633        perf-stat.i.task-clock
      3.25 ±  9%     +36.0%       4.42 ±  7%  perf-stat.overall.MPKI
      0.62 ±  5%      +0.2        0.83 ±  5%  perf-stat.overall.branch-miss-rate%
     32.96 ± 10%     -13.4       19.58 ± 11%  perf-stat.overall.cache-miss-rate%
      5.25           -42.4%       3.02        perf-stat.overall.cpi
      4953           -28.7%       3533 ±  4%  perf-stat.overall.cycles-between-cache-misses
      0.02 ± 23%      +0.0        0.03 ± 24%  perf-stat.overall.dTLB-load-miss-rate%
     72.34 ±  3%      -3.1       69.29        perf-stat.overall.iTLB-load-miss-rate%
      7868 ±  6%     -20.0%       6292 ±  7%  perf-stat.overall.instructions-per-iTLB-miss
      0.19           +73.5%       0.33        perf-stat.overall.ipc
     92.20            -4.8       87.37        perf-stat.overall.node-load-miss-rate%
     90.00            -9.8       80.24        perf-stat.overall.node-store-miss-rate%
  19255954           -23.1%   14811673        perf-stat.overall.path-length
 1.382e+10            +5.2%  1.454e+10        perf-stat.ps.branch-instructions
  85147082 ±  5%     +42.1%   1.21e+08 ±  5%  perf-stat.ps.branch-misses
  69832184 ±  2%      -9.6%   63144472 ±  4%  perf-stat.ps.cache-misses
 2.141e+08 ±  9%     +52.0%  3.254e+08 ±  8%  perf-stat.ps.cache-references
     25647 ±  2%     +46.2%      37498        perf-stat.ps.context-switches
 3.458e+11           -35.6%  2.227e+11        perf-stat.ps.cpu-cycles
      3456           +55.5%       5375 ±  4%  perf-stat.ps.cpu-migrations
   2731148 ± 22%     +50.7%    4114660 ± 24%  perf-stat.ps.dTLB-load-misses
    951612 ± 11%     +42.4%    1354727 ± 10%  perf-stat.ps.dTLB-store-misses
 2.534e+09           +43.0%  3.624e+09        perf-stat.ps.dTLB-stores
   8410006 ±  6%     +39.9%   11763281 ±  6%  perf-stat.ps.iTLB-load-misses
   3251030 ± 17%     +60.5%    5218236 ±  7%  perf-stat.ps.iTLB-loads
 6.591e+10           +11.7%  7.364e+10        perf-stat.ps.instructions
    127.07           +97.9%     251.44 ±  2%  perf-stat.ps.major-faults
    338752           +44.5%     489644        perf-stat.ps.minor-faults
  19070733           -11.1%   16952678 ±  4%  perf-stat.ps.node-load-misses
   1613838           +51.7%    2448074        perf-stat.ps.node-loads
   9716997           -18.4%    7933032 ±  2%  perf-stat.ps.node-store-misses
   1079544           +80.8%    1952245        perf-stat.ps.node-stores
    338879           +44.6%     489896        perf-stat.ps.page-faults
 2.009e+13           +11.5%  2.239e+13        perf-stat.total.instructions
      0.04 ± 54%    +278.3%       0.14 ± 41%  perf-sched.sch_delay.avg.ms.d_alloc_parallel.__lookup_slow.walk_component.link_path_walk.part
      0.11 ±123%    +813.3%       1.04 ±120%  perf-sched.sch_delay.avg.ms.d_alloc_parallel.__lookup_slow.walk_component.path_lookupat.isra
      0.03 ±  9%    +210.5%       0.10 ± 21%  perf-sched.sch_delay.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      0.17 ± 89%    +210.6%       0.52 ± 59%  perf-sched.sch_delay.avg.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      0.05 ± 34%   +1883.2%       0.91 ± 48%  perf-sched.sch_delay.avg.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
      0.12 ± 45%    +772.8%       1.04 ± 65%  perf-sched.sch_delay.avg.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_call_function_single.[unknown]
      0.09 ±  9%   +1004.3%       0.97 ± 90%  perf-sched.sch_delay.avg.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown]
      0.06 ± 28%    +390.8%       0.29 ± 41%  perf-sched.sch_delay.avg.ms.exit_to_user_mode_prepare.syscall_exit_to_user_mode.entry_SYSCALL_64_after_hwframe.[unknown]
      0.63 ±  7%     +80.2%       1.13 ± 21%  perf-sched.sch_delay.avg.ms.exit_to_user_mode_prepare.syscall_exit_to_user_mode.ret_from_fork.[unknown]
      0.07 ± 16%    +113.1%       0.14 ± 21%  perf-sched.sch_delay.avg.ms.io_schedule.__lock_page_killable.filemap_fault.__do_fault
      0.01 ±  7%    +196.2%       0.02 ± 65%  perf-sched.sch_delay.avg.ms.pipe_read.new_sync_read.vfs_read.ksys_read
      0.04 ± 45%    +742.5%       0.35 ± 83%  perf-sched.sch_delay.avg.ms.preempt_schedule_common._cond_resched.__alloc_pages_nodemask.alloc_pages_vma.wp_page_copy
      0.07 ± 78%     -84.3%       0.01 ±142%  perf-sched.sch_delay.avg.ms.preempt_schedule_common._cond_resched.__alloc_pages_nodemask.allocate_slab.___slab_alloc
      0.04 ± 79%   +2194.9%       0.89 ±164%  perf-sched.sch_delay.avg.ms.preempt_schedule_common._cond_resched.__alloc_pages_nodemask.pte_alloc_one.__pte_alloc
      0.07 ± 19%     -86.5%       0.01 ± 59%  perf-sched.sch_delay.avg.ms.preempt_schedule_common._cond_resched.__anon_vma_prepare.do_fault.__handle_mm_fault
      0.25 ±105%     -98.2%       0.00 ±137%  perf-sched.sch_delay.avg.ms.preempt_schedule_common._cond_resched.copy_page_to_iter.generic_file_buffered_read.new_sync_read
      0.40 ±  6%     +91.2%       0.77 ±  5%  perf-sched.sch_delay.avg.ms.preempt_schedule_common._cond_resched.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      0.08 ±100%     -92.6%       0.01 ± 94%  perf-sched.sch_delay.avg.ms.preempt_schedule_common._cond_resched.down_write.__anon_vma_prepare.do_anonymous_page
      0.03 ± 79%    +277.4%       0.12 ± 73%  perf-sched.sch_delay.avg.ms.preempt_schedule_common._cond_resched.down_write.__vma_adjust.__split_vma
      0.01 ± 16%  +1.5e+05%       8.25 ±103%  perf-sched.sch_delay.avg.ms.preempt_schedule_common._cond_resched.down_write.do_truncate.path_openat
      0.04 ± 19%    +318.9%       0.16 ± 44%  perf-sched.sch_delay.avg.ms.preempt_schedule_common._cond_resched.down_write.unlink_anon_vmas.free_pgtables
      0.04 ±  7%   +1180.0%       0.51 ±145%  perf-sched.sch_delay.avg.ms.preempt_schedule_common._cond_resched.down_write.unlink_file_vma.free_pgtables
      0.00 ± 10%     -89.3%       0.00 ±173%  perf-sched.sch_delay.avg.ms.preempt_schedule_common._cond_resched.down_write_killable.__vm_munmap.__x64_sys_munmap
      0.07 ± 54%    +242.3%       0.26 ± 62%  perf-sched.sch_delay.avg.ms.preempt_schedule_common._cond_resched.down_write_killable.vm_mmap_pgoff.elf_map
      0.03 ± 11%     -87.8%       0.00 ± 13%  perf-sched.sch_delay.avg.ms.preempt_schedule_common._cond_resched.down_write_killable.vm_mmap_pgoff.ksys_mmap_pgoff
      0.01 ± 49%  +1.3e+05%       8.04 ±152%  perf-sched.sch_delay.avg.ms.preempt_schedule_common._cond_resched.dput.do_unlinkat.do_syscall_64
      0.10 ±127%  +16890.4%      16.82 ±163%  perf-sched.sch_delay.avg.ms.preempt_schedule_common._cond_resched.dput.done_path_create.do_linkat
      0.13 ± 18%    +459.3%       0.71 ± 18%  perf-sched.sch_delay.avg.ms.preempt_schedule_common._cond_resched.dput.path_openat.do_filp_open
      0.44 ±118%    +204.8%       1.33 ± 94%  perf-sched.sch_delay.avg.ms.preempt_schedule_common._cond_resched.dput.scan_positives.dcache_readdir
      0.01 ± 36%   +3156.9%       0.43 ± 63%  perf-sched.sch_delay.avg.ms.preempt_schedule_common._cond_resched.dput.step_into.path_openat
      0.07 ± 21%    +554.5%       0.46 ± 93%  perf-sched.sch_delay.avg.ms.preempt_schedule_common._cond_resched.dput.terminate_walk.path_openat
      0.00 ±141%  +19625.0%       0.07 ±150%  perf-sched.sch_delay.avg.ms.preempt_schedule_common._cond_resched.generic_file_buffered_read.__kernel_read.load_elf_binary
      0.08 ±134%    +686.6%       0.66 ± 59%  perf-sched.sch_delay.avg.ms.preempt_schedule_common._cond_resched.kmem_cache_alloc.__d_alloc.d_alloc_cursor
      0.04 ± 37%    +648.3%       0.33 ± 28%  perf-sched.sch_delay.avg.ms.preempt_schedule_common._cond_resched.kmem_cache_alloc.security_file_alloc.__alloc_file
      0.21 ± 61%     -77.6%       0.05 ±139%  perf-sched.sch_delay.avg.ms.preempt_schedule_common._cond_resched.kmem_cache_alloc.vm_area_alloc.__install_special_mapping
      0.30 ± 97%     -99.2%       0.00 ± 34%  perf-sched.sch_delay.avg.ms.preempt_schedule_common._cond_resched.kmem_cache_alloc.vm_area_alloc.do_brk_flags
      3.67 ±140%    -100.0%       0.00 ±173%  perf-sched.sch_delay.avg.ms.preempt_schedule_common._cond_resched.kmem_cache_alloc_node_trace.__get_vm_area_node.__vmalloc_node_range
      0.05 ± 51%     +75.6%       0.09 ± 30%  perf-sched.sch_delay.avg.ms.preempt_schedule_common._cond_resched.kmem_cache_alloc_trace.perf_event_mmap.mmap_region
      0.19 ± 85%     -93.9%       0.01 ±148%  perf-sched.sch_delay.avg.ms.preempt_schedule_common._cond_resched.kmem_cache_alloc_trace.perf_event_mmap.mprotect_fixup
      0.01 ± 66%  +89763.4%       8.39 ±106%  perf-sched.sch_delay.avg.ms.preempt_schedule_common._cond_resched.mnt_want_write.path_openat.do_filp_open
      0.01 ±108%    +903.8%       0.13 ±129%  perf-sched.sch_delay.avg.ms.preempt_schedule_common._cond_resched.mutex_lock.futex_exec_release.exec_mm_release
      0.03 ± 53%     -67.5%       0.01 ± 83%  perf-sched.sch_delay.avg.ms.preempt_schedule_common._cond_resched.mutex_lock.futex_exit_release.exit_mm_release
      0.11 ±125%   +1883.9%       2.25 ± 40%  perf-sched.sch_delay.avg.ms.preempt_schedule_common._cond_resched.smpboot_thread_fn.kthread.ret_from_fork
      0.01 ± 70%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.preempt_schedule_common._cond_resched.stop_one_cpu.migrate_task_to.task_numa_migrate
      0.30 ±  3%    +308.2%       1.22 ± 26%  perf-sched.sch_delay.avg.ms.preempt_schedule_common._cond_resched.stop_one_cpu.sched_exec.bprm_execve
      0.08 ± 68%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.preempt_schedule_common._cond_resched.wait_for_completion.stop_two_cpus.migrate_swap
      0.01 ±103%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.rwsem_down_read_slowpath.page_lock_anon_vma_read.rmap_walk_anon.try_to_unmap
      0.01 ±106%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.rwsem_down_read_slowpath.rmap_walk_anon.remove_migration_ptes.migrate_pages
      0.01 ± 49%   +1115.0%       0.14 ±143%  perf-sched.sch_delay.avg.ms.rwsem_down_write_slowpath.__vma_adjust.__split_vma.__do_munmap
      0.03 ± 52%     -89.4%       0.00 ±107%  perf-sched.sch_delay.avg.ms.rwsem_down_write_slowpath.anon_vma_clone.anon_vma_fork.dup_mmap
      0.02 ± 54%   +1681.5%       0.39 ± 70%  perf-sched.sch_delay.avg.ms.rwsem_down_write_slowpath.do_unlinkat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.01 ± 80%    +507.1%       0.09 ± 45%  perf-sched.sch_delay.avg.ms.rwsem_down_write_slowpath.dup_mmap.dup_mm.copy_process
      0.02 ± 24%   +1250.0%       0.26 ± 68%  perf-sched.sch_delay.avg.ms.rwsem_down_write_slowpath.filename_create.do_linkat.__x64_sys_link
      0.07 ± 65%     -87.3%       0.01 ± 75%  perf-sched.sch_delay.avg.ms.rwsem_down_write_slowpath.unlink_anon_vmas.free_pgtables.exit_mmap
      0.02 ± 20%    +232.6%       0.05 ± 33%  perf-sched.sch_delay.avg.ms.rwsem_down_write_slowpath.unlink_file_vma.free_pgtables.exit_mmap
      0.01 ± 27%    +363.9%       0.04 ± 43%  perf-sched.sch_delay.avg.ms.rwsem_down_write_slowpath.vma_link.mmap_region.do_mmap
      0.19 ± 68%     -95.1%       0.01 ± 13%  perf-sched.sch_delay.avg.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      0.04 ± 18%   +5366.5%       1.93 ± 40%  perf-sched.sch_delay.avg.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
      0.04 ± 39%    +464.8%       0.24 ± 60%  perf-sched.sch_delay.avg.ms.schedule_timeout.rcu_gp_kthread.kthread.ret_from_fork
      0.00 ±141%  +48300.0%       0.97 ±170%  perf-sched.sch_delay.avg.ms.schedule_timeout.wait_for_completion.__flush_work.lru_add_drain_all
      0.20 ±  7%   +1238.1%       2.63 ± 31%  perf-sched.sch_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork
      0.12 ± 27%     -74.7%       0.03 ±149%  perf-sched.sch_delay.avg.ms.wait_for_partner.fifo_open.do_dentry_open.path_openat
      0.01 ±  7%   +9784.2%       1.25 ± 18%  perf-sched.sch_delay.avg.ms.worker_thread.kthread.ret_from_fork
      5.01 ± 31%    +324.7%      21.26 ± 36%  perf-sched.sch_delay.max.ms.d_alloc_parallel.__lookup_slow.walk_component.link_path_walk.part
      3.59 ±132%   +1076.4%      42.25 ± 96%  perf-sched.sch_delay.max.ms.d_alloc_parallel.__lookup_slow.walk_component.path_lookupat.isra
     16.19 ±  7%   +1397.5%     242.51 ± 30%  perf-sched.sch_delay.max.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      9.13 ± 27%   +2518.1%     238.94 ± 62%  perf-sched.sch_delay.max.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
     10.04 ± 65%   +1971.0%     207.85 ± 63%  perf-sched.sch_delay.max.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_call_function_single.[unknown]
      9.21 ± 61%   +2000.8%     193.58 ± 63%  perf-sched.sch_delay.max.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown]
     11.01 ± 18%    +799.2%      99.02 ± 86%  perf-sched.sch_delay.max.ms.exit_to_user_mode_prepare.syscall_exit_to_user_mode.entry_SYSCALL_64_after_hwframe.[unknown]
     14.73 ± 13%    +265.9%      53.91 ± 26%  perf-sched.sch_delay.max.ms.exit_to_user_mode_prepare.syscall_exit_to_user_mode.ret_from_fork.[unknown]
     10.65 ± 44%    +151.1%      26.76 ± 19%  perf-sched.sch_delay.max.ms.io_schedule.__lock_page_killable.filemap_fault.__do_fault
      1.21 ± 24%   +2921.4%      36.62 ±124%  perf-sched.sch_delay.max.ms.pipe_read.new_sync_read.vfs_read.ksys_read
      0.53 ± 55%   +1359.3%       7.76 ±113%  perf-sched.sch_delay.max.ms.preempt_schedule_common._cond_resched.__alloc_pages_nodemask.alloc_pages_vma.wp_page_copy
      0.30 ± 92%     -90.7%       0.03 ±155%  perf-sched.sch_delay.max.ms.preempt_schedule_common._cond_resched.__alloc_pages_nodemask.allocate_slab.___slab_alloc
      0.37 ± 69%   +3449.8%      13.07 ±162%  perf-sched.sch_delay.max.ms.preempt_schedule_common._cond_resched.__alloc_pages_nodemask.pte_alloc_one.__pte_alloc
      0.48 ± 37%     -89.3%       0.05 ±102%  perf-sched.sch_delay.max.ms.preempt_schedule_common._cond_resched.__anon_vma_prepare.do_fault.__handle_mm_fault
      0.55 ± 93%     -95.3%       0.03 ±153%  perf-sched.sch_delay.max.ms.preempt_schedule_common._cond_resched.__kmalloc_node.memcg_alloc_page_obj_cgroups.kmem_cache_alloc_node
      0.97 ± 13%    +591.3%       6.72 ±119%  perf-sched.sch_delay.max.ms.preempt_schedule_common._cond_resched.change_p4d_range.change_protection.mprotect_fixup
      0.31 ±106%     -98.6%       0.00 ±137%  perf-sched.sch_delay.max.ms.preempt_schedule_common._cond_resched.copy_page_to_iter.generic_file_buffered_read.new_sync_read
     11.49 ±  5%     +87.8%      21.57 ± 31%  perf-sched.sch_delay.max.ms.preempt_schedule_common._cond_resched.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      0.32 ±102%     -96.0%       0.01 ± 79%  perf-sched.sch_delay.max.ms.preempt_schedule_common._cond_resched.down_write.__anon_vma_prepare.do_anonymous_page
      1.05 ± 98%    +478.9%       6.10 ± 82%  perf-sched.sch_delay.max.ms.preempt_schedule_common._cond_resched.down_write.__vma_adjust.__split_vma
      0.02 ±  5%  +1.4e+06%     217.29 ±104%  perf-sched.sch_delay.max.ms.preempt_schedule_common._cond_resched.down_write.do_truncate.path_openat
      1.95 ± 26%    +682.5%      15.25 ± 64%  perf-sched.sch_delay.max.ms.preempt_schedule_common._cond_resched.down_write.unlink_anon_vmas.free_pgtables
      0.93 ± 14%   +9721.3%      91.57 ±158%  perf-sched.sch_delay.max.ms.preempt_schedule_common._cond_resched.down_write.unlink_file_vma.free_pgtables
      0.00 ± 10%     -78.6%       0.00 ±173%  perf-sched.sch_delay.max.ms.preempt_schedule_common._cond_resched.down_write_killable.__vm_munmap.__x64_sys_munmap
      0.24 ± 43%     -96.7%       0.01 ± 72%  perf-sched.sch_delay.max.ms.preempt_schedule_common._cond_resched.down_write_killable.vm_mmap_pgoff.ksys_mmap_pgoff
      0.01 ± 28%  +8.3e+05%     113.60 ±164%  perf-sched.sch_delay.max.ms.preempt_schedule_common._cond_resched.dput.do_unlinkat.do_syscall_64
      0.21 ±108%  +34647.0%      72.97 ±145%  perf-sched.sch_delay.max.ms.preempt_schedule_common._cond_resched.dput.done_path_create.do_linkat
      3.03 ± 39%   +1407.5%      45.73 ± 29%  perf-sched.sch_delay.max.ms.preempt_schedule_common._cond_resched.dput.path_openat.do_filp_open
      1.22 ± 39%   +4068.4%      50.91 ± 79%  perf-sched.sch_delay.max.ms.preempt_schedule_common._cond_resched.dput.step_into.path_openat
      3.38 ± 60%   +3700.6%     128.54 ±127%  perf-sched.sch_delay.max.ms.preempt_schedule_common._cond_resched.dput.terminate_walk.path_openat
      0.88 ± 46%    +299.6%       3.50 ± 55%  perf-sched.sch_delay.max.ms.preempt_schedule_common._cond_resched.exit_mmap.mmput.begin_new_exec
      0.00 ±141%  +22250.0%       0.30 ±167%  perf-sched.sch_delay.max.ms.preempt_schedule_common._cond_resched.generic_file_buffered_read.__kernel_read.load_elf_binary
      0.57 ±139%  +12527.6%      71.47 ± 89%  perf-sched.sch_delay.max.ms.preempt_schedule_common._cond_resched.kmem_cache_alloc.__d_alloc.d_alloc_cursor
      0.00 ±141%   +1525.0%       0.03 ±144%  perf-sched.sch_delay.max.ms.preempt_schedule_common._cond_resched.kmem_cache_alloc.__delayacct_tsk_init.copy_process
      1.73 ± 43%    +863.5%      16.71 ± 50%  perf-sched.sch_delay.max.ms.preempt_schedule_common._cond_resched.kmem_cache_alloc.security_file_alloc.__alloc_file
      3.67 ±140%    -100.0%       0.00 ±173%  perf-sched.sch_delay.max.ms.preempt_schedule_common._cond_resched.kmem_cache_alloc_node_trace.__get_vm_area_node.__vmalloc_node_range
      3.19 ± 52%    +345.8%      14.24 ± 84%  perf-sched.sch_delay.max.ms.preempt_schedule_common._cond_resched.kmem_cache_alloc_trace.perf_event_mmap.mmap_region
      1.01 ± 99%     -91.8%       0.08 ±167%  perf-sched.sch_delay.max.ms.preempt_schedule_common._cond_resched.kmem_cache_alloc_trace.perf_event_mmap.mprotect_fixup
      0.11 ± 85%  +1.7e+05%     187.38 ± 84%  perf-sched.sch_delay.max.ms.preempt_schedule_common._cond_resched.mnt_want_write.path_openat.do_filp_open
      0.05 ±130%    +602.6%       0.36 ±142%  perf-sched.sch_delay.max.ms.preempt_schedule_common._cond_resched.mutex_lock.futex_exec_release.exec_mm_release
      0.52 ±136%  +10794.6%      57.09 ± 72%  perf-sched.sch_delay.max.ms.preempt_schedule_common._cond_resched.smpboot_thread_fn.kthread.ret_from_fork
      0.06 ± 92%    -100.0%       0.00        perf-sched.sch_delay.max.ms.preempt_schedule_common._cond_resched.stop_one_cpu.migrate_task_to.task_numa_migrate
     28.50 ± 12%    +645.4%     212.48 ± 39%  perf-sched.sch_delay.max.ms.preempt_schedule_common._cond_resched.stop_one_cpu.sched_exec.bprm_execve
      1.20 ± 76%    -100.0%       0.00        perf-sched.sch_delay.max.ms.preempt_schedule_common._cond_resched.wait_for_completion.stop_two_cpus.migrate_swap
      0.18 ±130%    -100.0%       0.00        perf-sched.sch_delay.max.ms.rwsem_down_read_slowpath.page_lock_anon_vma_read.rmap_walk_anon.try_to_unmap
      0.20 ±132%    -100.0%       0.00        perf-sched.sch_delay.max.ms.rwsem_down_read_slowpath.rmap_walk_anon.remove_migration_ptes.migrate_pages
      1.33 ±103%     -96.9%       0.04 ±173%  perf-sched.sch_delay.max.ms.rwsem_down_write_slowpath.__put_anon_vma.unlink_anon_vmas.free_pgtables
      1.53 ± 79%   +6359.8%      98.51 ±148%  perf-sched.sch_delay.max.ms.rwsem_down_write_slowpath.__vma_adjust.__split_vma.__do_munmap
      2.57 ± 63%    +676.1%      19.92 ± 49%  perf-sched.sch_delay.max.ms.rwsem_down_write_slowpath.__vma_adjust.__split_vma.mprotect_fixup
      0.78 ± 76%     -99.2%       0.01 ±138%  perf-sched.sch_delay.max.ms.rwsem_down_write_slowpath.anon_vma_clone.anon_vma_fork.dup_mmap
      0.19 ± 94%     -97.6%       0.00 ±100%  perf-sched.sch_delay.max.ms.rwsem_down_write_slowpath.anon_vma_fork.dup_mmap.dup_mm
      5.70 ± 45%   +1878.3%     112.68 ± 89%  perf-sched.sch_delay.max.ms.rwsem_down_write_slowpath.do_unlinkat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      3.68 ±111%   +1530.5%      60.07 ± 26%  perf-sched.sch_delay.max.ms.rwsem_down_write_slowpath.dup_mmap.dup_mm.copy_process
      6.33 ± 17%   +2353.2%     155.41 ±105%  perf-sched.sch_delay.max.ms.rwsem_down_write_slowpath.filename_create.do_linkat.__x64_sys_link
      2.23 ± 66%     -98.3%       0.04 ± 65%  perf-sched.sch_delay.max.ms.rwsem_down_write_slowpath.unlink_anon_vmas.free_pgtables.exit_mmap
      6.50 ± 41%    +643.0%      48.28 ± 78%  perf-sched.sch_delay.max.ms.rwsem_down_write_slowpath.unlink_file_vma.free_pgtables.exit_mmap
      2.45 ± 43%   +1688.6%      43.80 ± 88%  perf-sched.sch_delay.max.ms.rwsem_down_write_slowpath.vma_link.mmap_region.do_mmap
      9.31 ± 80%     -99.6%       0.04 ± 54%  perf-sched.sch_delay.max.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      0.52 ± 65%  +15185.6%      79.99 ± 38%  perf-sched.sch_delay.max.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
     16.34 ± 98%    +385.7%      79.39 ± 79%  perf-sched.sch_delay.max.ms.schedule_timeout.rcu_gp_kthread.kthread.ret_from_fork
      0.00 ±141%  +72153.1%       1.93 ±171%  perf-sched.sch_delay.max.ms.schedule_timeout.wait_for_completion.__flush_work.lru_add_drain_all
     10.28 ± 58%   +2363.0%     253.08 ± 17%  perf-sched.sch_delay.max.ms.smpboot_thread_fn.kthread.ret_from_fork
      8.41 ± 37%   +3406.7%     295.08 ± 29%  perf-sched.sch_delay.max.ms.worker_thread.kthread.ret_from_fork
      0.12 ± 74%    +358.2%       0.54 ± 29%  perf-sched.total_sch_delay.average.ms
     39.70 ±  3%     -15.2%      33.67 ±  3%  perf-sched.total_wait_and_delay.average.ms
    157875 ±  3%     +29.4%     204320 ±  3%  perf-sched.total_wait_and_delay.count.ms
      5585           +14.5%       6395 ±  3%  perf-sched.total_wait_and_delay.max.ms
     39.58 ±  3%     -16.3%      33.13 ±  3%  perf-sched.total_wait_time.average.ms
      5585           +14.5%       6395 ±  3%  perf-sched.total_wait_time.max.ms
      6.67 ±  2%     +90.8%      12.72 ± 10%  perf-sched.wait_and_delay.avg.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      6.25 ± 22%    +706.2%      50.40 ± 54%  perf-sched.wait_and_delay.avg.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
      6.09 ± 15%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.exit_to_user_mode_prepare.syscall_exit_to_user_mode.entry_SYSCALL_64_after_hwframe.[unknown]
     38.34 ± 13%     +47.7%      56.61 ± 33%  perf-sched.wait_and_delay.avg.ms.pipe_read.new_sync_read.vfs_read.ksys_read
      5.09           +14.7%       5.83 ±  3%  perf-sched.wait_and_delay.avg.ms.preempt_schedule_common._cond_resched.stop_one_cpu.__set_cpus_allowed_ptr.sched_setaffinity
      0.33 ±  3%    +330.6%       1.42 ± 24%  perf-sched.wait_and_delay.avg.ms.preempt_schedule_common._cond_resched.stop_one_cpu.sched_exec.bprm_execve
      1.33 ± 20%    +419.5%       6.93 ±  7%  perf-sched.wait_and_delay.avg.ms.rwsem_down_write_slowpath.do_unlinkat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.60 ± 70%    +168.1%       1.61 ± 18%  perf-sched.wait_and_delay.avg.ms.rwsem_down_write_slowpath.dup_mmap.dup_mm.copy_process
      3.71 ± 11%     +29.9%       4.82 ± 12%  perf-sched.wait_and_delay.avg.ms.rwsem_down_write_slowpath.path_openat.do_filp_open.do_sys_openat2
      0.04 ±141%    +440.1%       0.24 ± 12%  perf-sched.wait_and_delay.avg.ms.rwsem_down_write_slowpath.unlink_file_vma.free_pgtables.unmap_region
      0.06 ±141%    +604.1%       0.41 ± 20%  perf-sched.wait_and_delay.avg.ms.rwsem_down_write_slowpath.vma_link.mmap_region.do_mmap
    251.31 ±  7%     -36.4%     159.76 ± 18%  perf-sched.wait_and_delay.avg.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
     87.92 ± 14%     +50.7%     132.47 ± 22%  perf-sched.wait_and_delay.avg.ms.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop.0.do_sys_poll
    384.15           -32.3%     260.23 ± 10%  perf-sched.wait_and_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork
    142.29           -30.8%      98.47 ±  6%  perf-sched.wait_and_delay.avg.ms.worker_thread.kthread.ret_from_fork
     35.67 ± 11%     +58.4%      56.50        perf-sched.wait_and_delay.count.devkmsg_read.vfs_read.ksys_read.do_syscall_64
     14.67 ±  8%     +19.3%      17.50 ±  4%  perf-sched.wait_and_delay.count.do_nanosleep.hrtimer_nanosleep.__x64_sys_nanosleep.do_syscall_64
     35.67 ±  9%     +58.4%      56.50        perf-sched.wait_and_delay.count.do_syslog.part.0.kmsg_read.vfs_read
     39991           +28.3%      51295 ±  4%  perf-sched.wait_and_delay.count.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
     41076           +26.8%      52088 ±  4%  perf-sched.wait_and_delay.count.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
    914.67 ±  2%     +68.3%       1539 ±  6%  perf-sched.wait_and_delay.count.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
    122.33 ±141%    +401.1%     613.00 ± 22%  perf-sched.wait_and_delay.count.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown]
      1649 ±  8%    -100.0%       0.00        perf-sched.wait_and_delay.count.exit_to_user_mode_prepare.syscall_exit_to_user_mode.entry_SYSCALL_64_after_hwframe.[unknown]
      4728 ± 13%     -91.3%     412.00 ±100%  perf-sched.wait_and_delay.count.preempt_schedule_common._cond_resched.dput.scan_positives.dcache_readdir
      4.67 ± 44%   +1325.0%      66.50 ± 51%  perf-sched.wait_and_delay.count.preempt_schedule_common._cond_resched.smpboot_thread_fn.kthread.ret_from_fork
      1987 ±  4%     -13.4%       1720 ±  4%  perf-sched.wait_and_delay.count.preempt_schedule_common._cond_resched.stop_one_cpu.__set_cpus_allowed_ptr.sched_setaffinity
      3064 ±  8%     +76.6%       5412 ± 13%  perf-sched.wait_and_delay.count.preempt_schedule_common._cond_resched.stop_one_cpu.sched_exec.bprm_execve
      2046 ±  7%     +68.3%       3443 ± 15%  perf-sched.wait_and_delay.count.rwsem_down_read_slowpath.walk_component.path_lookupat.isra.0
    896.33 ±  5%     +81.3%       1625 ± 12%  perf-sched.wait_and_delay.count.rwsem_down_write_slowpath.do_unlinkat.do_syscall_64.entry_SYSCALL_64_after_hwframe
    776.00 ± 75%    +292.9%       3049 ± 44%  perf-sched.wait_and_delay.count.rwsem_down_write_slowpath.dup_mmap.dup_mm.copy_process
      1649 ± 32%    +198.7%       4926 ± 45%  perf-sched.wait_and_delay.count.rwsem_down_write_slowpath.unlink_file_vma.free_pgtables.exit_mmap
    354.67 ±141%    +482.9%       2067 ± 36%  perf-sched.wait_and_delay.count.rwsem_down_write_slowpath.unlink_file_vma.free_pgtables.unmap_region
    350.00 ±141%    +496.1%       2086 ± 33%  perf-sched.wait_and_delay.count.rwsem_down_write_slowpath.vma_link.mmap_region.do_mmap
     13.00 ± 21%     +61.5%      21.00        perf-sched.wait_and_delay.count.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop.0.do_select
    163.67 ±  3%     -35.2%     106.00 ± 25%  perf-sched.wait_and_delay.count.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop.0.do_sys_poll
      1762 ±  4%     -17.5%       1454 ± 12%  perf-sched.wait_and_delay.count.schedule_timeout.rcu_gp_kthread.kthread.ret_from_fork
      9129 ±  2%     +43.1%      13062 ±  9%  perf-sched.wait_and_delay.count.smpboot_thread_fn.kthread.ret_from_fork
     12642           +52.2%      19242 ±  3%  perf-sched.wait_and_delay.count.worker_thread.kthread.ret_from_fork
      5512           -30.9%       3811        perf-sched.wait_and_delay.max.ms.devkmsg_read.vfs_read.ksys_read.do_syscall_64
      5512           -30.9%       3811        perf-sched.wait_and_delay.max.ms.do_syslog.part.0.kmsg_read.vfs_read
    340.62 ±141%    +203.4%       1033        perf-sched.wait_and_delay.max.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown]
      5496          -100.0%       0.00        perf-sched.wait_and_delay.max.ms.exit_to_user_mode_prepare.syscall_exit_to_user_mode.entry_SYSCALL_64_after_hwframe.[unknown]
      5580           -30.1%       3899        perf-sched.wait_and_delay.max.ms.pipe_read.new_sync_read.vfs_read.ksys_read
      1495 ± 31%    +114.1%       3203 ±  4%  perf-sched.wait_and_delay.max.ms.preempt_schedule_common._cond_resched.smpboot_thread_fn.kthread.ret_from_fork
     28.50 ± 12%    +645.4%     212.48 ± 39%  perf-sched.wait_and_delay.max.ms.preempt_schedule_common._cond_resched.stop_one_cpu.sched_exec.bprm_execve
     20.64 ± 78%   +2946.5%     628.69 ± 62%  perf-sched.wait_and_delay.max.ms.rwsem_down_write_slowpath.dup_mmap.dup_mm.copy_process
     20.38 ± 28%    +299.0%      81.32 ± 53%  perf-sched.wait_and_delay.max.ms.rwsem_down_write_slowpath.unlink_file_vma.free_pgtables.exit_mmap
      3.90 ±141%    +526.7%      24.46 ± 34%  perf-sched.wait_and_delay.max.ms.rwsem_down_write_slowpath.unlink_file_vma.free_pgtables.unmap_region
      3.78 ±141%   +1570.8%      63.11 ± 45%  perf-sched.wait_and_delay.max.ms.rwsem_down_write_slowpath.vma_link.mmap_region.do_mmap
      5176           -31.0%       3569        perf-sched.wait_and_delay.max.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      5585           -30.2%       3899        perf-sched.wait_and_delay.max.ms.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop.0.do_select
    505.28           +31.3%     663.68 ±  9%  perf-sched.wait_and_delay.max.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
      4817 ± 15%     -31.2%       3315 ±  3%  perf-sched.wait_and_delay.max.ms.smpboot_thread_fn.kthread.ret_from_fork
      1791           -16.1%       1502 ±  3%  perf-sched.wait_and_delay.max.ms.worker_thread.kthread.ret_from_fork
      0.08 ± 39%    +460.9%       0.43 ± 27%  perf-sched.wait_time.avg.ms.d_alloc_parallel.__lookup_slow.walk_component.link_path_walk.part
      0.17 ± 92%    +182.7%       0.48 ± 59%  perf-sched.wait_time.avg.ms.d_alloc_parallel.__lookup_slow.walk_component.path_lookupat.isra
      6.50 ±  3%     +87.7%      12.20 ±  8%  perf-sched.wait_time.avg.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      0.59 ±123%    +129.1%       1.35 ± 86%  perf-sched.wait_time.avg.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_exc_page_fault.[unknown]
      6.21 ± 22%    +697.5%      49.49 ± 55%  perf-sched.wait_time.avg.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
      8.60 ± 95%    +175.7%      23.70 ± 34%  perf-sched.wait_time.avg.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_call_function_single.[unknown]
      6.03 ± 15%    +354.9%      27.43 ± 13%  perf-sched.wait_time.avg.ms.exit_to_user_mode_prepare.syscall_exit_to_user_mode.entry_SYSCALL_64_after_hwframe.[unknown]
      0.00 ± 88%  +24178.6%       1.13 ±156%  perf-sched.wait_time.avg.ms.io_schedule.__lock_page.__do_fault.do_fault
     38.33 ± 13%     +47.6%      56.59 ± 33%  perf-sched.wait_time.avg.ms.pipe_read.new_sync_read.vfs_read.ksys_read
      0.53 ±120%     -98.4%       0.01 ±102%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.__alloc_pages_nodemask.__pmd_alloc.__handle_mm_fault
      0.01 ±115%   +6617.2%       0.36 ±168%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.__kmalloc.load_elf_phdrs.load_elf_binary
      0.42 ± 44%    +593.4%       2.89 ± 57%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.__kmalloc.security_task_alloc.copy_process
      0.08 ± 57%    +614.6%       0.60 ± 48%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.__put_anon_vma.unlink_anon_vmas.free_pgtables
      0.27 ±140%    +525.8%       1.67 ± 86%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.cgroup_can_fork.copy_process.kernel_clone
      0.05 ± 25%    +978.8%       0.50 ± 50%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.change_p4d_range.change_protection.mprotect_fixup
      0.53 ± 73%    +685.8%       4.14 ± 66%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.copy_pte_range.copy_page_range.dup_mmap
      0.02 ±123%   +6830.4%       1.59 ±103%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.down_read.path_openat.do_filp_open
      0.06 ± 29%    +796.1%       0.51 ± 93%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.down_read.walk_component.link_path_walk
      0.01 ±141%   +2254.2%       0.14 ±161%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.down_read_killable.create_elf_tables.isra
      0.01 ± 97%   +9626.4%       1.13 ± 62%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.down_write.__anon_vma_prepare.do_fault
      0.02 ± 87%   +4118.8%       0.79 ± 55%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.down_write.__vma_adjust.shift_arg_pages
      1.50 ± 68%   +1104.7%      18.05 ±100%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.down_write.anon_vma_fork.dup_mmap
      2.02 ± 13%    +454.8%      11.23 ± 69%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.down_write.do_truncate.path_openat
      1.78 ± 66%    +587.5%      12.24 ± 99%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.down_write.dup_mmap.dup_mm
      0.86 ± 39%     +37.3%       1.18 ± 11%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.down_write.unlink_file_vma.free_pgtables
      0.01 ±141%   +3608.3%       0.22 ± 85%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.down_write_killable.__vm_munmap.elf_map
      0.01 ±135%    +539.5%       0.08 ± 83%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.down_write_killable.vm_brk_flags.load_elf_interp
      0.04 ± 21%    +251.3%       0.14 ± 50%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.down_write_killable.vm_mmap_pgoff.elf_map
      0.25 ± 70%   +1512.8%       4.09 ±132%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.dput.__fput.task_work_run
      0.18 ±139%   +1040.9%       2.06 ± 93%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.dput.dcache_dir_close.__fput
      0.32 ± 75%   +3385.1%      11.30 ±101%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.dput.do_unlinkat.do_syscall_64
      9.06 ± 10%    +226.6%      29.60 ± 20%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.dput.scan_positives.dcache_readdir
      2.19 ±119%    +216.9%       6.95 ± 21%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.dput.step_into.path_openat
      0.16 ± 19%   +1845.7%       3.15 ± 29%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.dput.terminate_walk.path_openat
      0.03 ± 70%   +2914.6%       0.82 ± 63%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.exit_mmap.mmput.begin_new_exec
      0.97 ± 23%    +131.5%       2.24 ± 56%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.exit_mmap.mmput.do_exit
      0.01 ±126%    +319.3%       0.06 ± 53%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.kmem_cache_alloc.__anon_vma_prepare.do_anonymous_page
      0.04 ± 15%   +2327.3%       0.89 ± 54%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.kmem_cache_alloc.__d_alloc.d_alloc
      0.62 ± 70%   +3428.4%      21.95 ± 35%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.kmem_cache_alloc.__d_alloc.d_alloc_cursor
      0.29 ± 72%   +1816.0%       5.56 ± 89%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.kmem_cache_alloc.copy_fs_struct.copy_process
      0.05 ±119%   +1698.6%       0.95 ± 91%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.kmem_cache_alloc.getname_flags.do_sys_openat2
      0.18 ± 72%    +533.7%       1.16 ± 31%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.kmem_cache_alloc.getname_flags.user_path_at_empty
      0.41 ± 34%    +890.7%       4.09 ± 49%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.kmem_cache_alloc.prepare_creds.copy_creds
      3.70 ± 18%     +55.5%       5.76 ± 42%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.kmem_cache_alloc.vm_area_dup.dup_mmap
     10.64 ±105%    +189.5%      30.81 ± 66%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.mnt_want_write.path_openat.do_filp_open
      0.10 ± 68%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.mutex_lock_killable.begin_new_exec.load_elf_binary
      0.05 ± 97%   +1166.8%       0.58 ± 67%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.remove_vma.__do_munmap.__vm_munmap
      5.09           +14.7%       5.83 ±  3%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.stop_one_cpu.__set_cpus_allowed_ptr.sched_setaffinity
      2.90 ± 20%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.stop_one_cpu.migrate_task_to.task_numa_migrate
      0.03 ±  5%    +539.8%       0.20 ± 26%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.stop_one_cpu.sched_exec.bprm_execve
      2.38 ± 18%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.wait_for_completion.stop_two_cpus.migrate_swap
      0.23 ±  2%     +87.1%       0.44 ± 35%  perf-sched.wait_time.avg.ms.preempt_schedule_common._cond_resched.zap_pte_range.unmap_page_range.unmap_vmas
      2.62 ± 44%    -100.0%       0.00        perf-sched.wait_time.avg.ms.rwsem_down_read_slowpath.page_lock_anon_vma_read.rmap_walk_anon.try_to_unmap
      2.41 ± 41%    -100.0%       0.00        perf-sched.wait_time.avg.ms.rwsem_down_read_slowpath.rmap_walk_anon.remove_migration_ptes.migrate_pages
      0.17 ±  4%     +96.1%       0.34 ± 48%  perf-sched.wait_time.avg.ms.rwsem_down_write_slowpath.__vma_adjust.__split_vma.mprotect_fixup
      1.31 ± 21%    +398.6%       6.54 ±  7%  perf-sched.wait_time.avg.ms.rwsem_down_write_slowpath.do_unlinkat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.93 ±  7%     +64.0%       1.53 ± 16%  perf-sched.wait_time.avg.ms.rwsem_down_write_slowpath.dup_mmap.dup_mm.copy_process
      0.17 ± 14%     +31.3%       0.22 ± 13%  perf-sched.wait_time.avg.ms.rwsem_down_write_slowpath.unlink_file_vma.free_pgtables.unmap_region
      0.20 ± 15%     +83.9%       0.37 ± 25%  perf-sched.wait_time.avg.ms.rwsem_down_write_slowpath.vma_link.mmap_region.do_mmap
    251.12 ±  7%     -36.4%     159.75 ± 18%  perf-sched.wait_time.avg.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
     87.92 ± 14%     +50.6%     132.37 ± 23%  perf-sched.wait_time.avg.ms.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop.0.do_sys_poll
    383.96           -32.9%     257.59 ±  9%  perf-sched.wait_time.avg.ms.smpboot_thread_fn.kthread.ret_from_fork
    142.28           -31.7%      97.22 ±  6%  perf-sched.wait_time.avg.ms.worker_thread.kthread.ret_from_fork
      8.16 ± 46%    +383.8%      39.47 ± 75%  perf-sched.wait_time.max.ms.d_alloc_parallel.__lookup_slow.walk_component.link_path_walk.part
      5512           -30.9%       3811        perf-sched.wait_time.max.ms.devkmsg_read.vfs_read.ksys_read.do_syscall_64
      5512           -30.9%       3811        perf-sched.wait_time.max.ms.do_syslog.part.0.kmsg_read.vfs_read
      5496           -30.6%       3813        perf-sched.wait_time.max.ms.exit_to_user_mode_prepare.syscall_exit_to_user_mode.entry_SYSCALL_64_after_hwframe.[unknown]
      0.07 ±107%  +29156.2%      21.16 ±159%  perf-sched.wait_time.max.ms.io_schedule.__lock_page.__do_fault.do_fault
      5580           -30.1%       3899        perf-sched.wait_time.max.ms.pipe_read.new_sync_read.vfs_read.ksys_read
      4.62 ± 40%    +343.5%      20.48 ± 14%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.__kmalloc.security_task_alloc.copy_process
      2.87 ± 85%    +498.7%      17.16 ± 34%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.__put_anon_vma.unlink_anon_vmas.free_pgtables
      1.03 ±140%    +525.1%       6.42 ± 54%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.cgroup_can_fork.copy_process.kernel_clone
      0.85 ± 22%   +2220.1%      19.71 ± 82%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.change_p4d_range.change_protection.mprotect_fixup
      7.98 ± 62%    +586.9%      54.83 ±100%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.copy_pte_range.copy_page_range.dup_mmap
      0.42 ± 73%    +476.2%       2.44 ± 95%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.copy_strings.isra.0
      0.18 ±131%   +4103.5%       7.45 ± 88%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.down_read.path_openat.do_filp_open
      2.68 ± 50%   +1905.1%      53.65 ±123%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.down_read.walk_component.link_path_walk
      0.04 ±141%   +3772.9%       1.39 ±166%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.down_read_killable.create_elf_tables.isra
      0.03 ±122%  +22698.3%       6.76 ± 88%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.down_write.__anon_vma_prepare.do_fault
      0.25 ±103%   +3843.4%       9.87 ± 62%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.down_write.__vma_adjust.shift_arg_pages
     23.74 ± 13%   +1153.9%     297.72 ±136%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.down_write.anon_vma_clone.anon_vma_fork
      8.46 ± 76%   +3275.9%     285.49 ±146%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.down_write.anon_vma_fork.dup_mmap
      8.55 ± 14%   +2664.7%     236.39 ± 90%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.down_write.do_truncate.path_openat
      0.02 ±141%   +3120.9%       0.78 ± 90%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.down_write_killable.__vm_munmap.elf_map
      0.63 ± 47%    +456.1%       3.51 ± 76%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.down_write_killable.vm_mmap_pgoff.elf_map
      0.36 ±139%    +758.2%       3.10 ± 66%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.dput.dcache_dir_close.__fput
      1.91 ± 89%   +6827.3%     132.20 ±137%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.dput.do_unlinkat.do_syscall_64
    336.18 ±140%     +73.0%     581.60 ± 78%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.dput.done_path_create.do_linkat
    341.13 ±137%    +196.8%       1012        perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.dput.step_into.path_openat
      9.64 ± 52%   +4704.9%     463.29 ± 72%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.dput.terminate_walk.path_openat
      0.94 ± 71%   +1718.2%      17.05 ± 33%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.exit_mmap.mmput.begin_new_exec
      6.94 ± 41%    +683.1%      54.36 ±113%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.exit_mmap.mmput.do_exit
      0.07 ±119%    +888.4%       0.65 ± 80%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.kmem_cache_alloc.__anon_vma_prepare.do_anonymous_page
      0.42 ± 51%   +3060.9%      13.37 ± 71%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.kmem_cache_alloc.__d_alloc.d_alloc
      1.61 ± 71%  +29984.9%     484.07 ± 65%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.kmem_cache_alloc.__d_alloc.d_alloc_cursor
      1.01 ± 76%    +779.3%       8.90 ± 68%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.kmem_cache_alloc.copy_fs_struct.copy_process
      1.25 ± 73%    +327.5%       5.36 ± 28%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.kmem_cache_alloc.getname_flags.user_path_at_empty
     23.94 ± 16%    +259.0%      85.92 ± 53%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.kmem_cache_alloc.vm_area_dup.dup_mmap
      6.01 ± 27%     +52.0%       9.13 ± 24%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.kmem_cache_alloc_trace.perf_event_mmap.mmap_region
      0.27 ± 77%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.mutex_lock_killable.begin_new_exec.load_elf_binary
      0.41 ± 97%   +1470.1%       6.36 ± 97%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.remove_vma.__do_munmap.__vm_munmap
      2.81 ± 79%    +146.3%       6.92 ± 44%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.remove_vma.__do_munmap.mmap_region
      7.51 ± 23%    +226.7%      24.54 ± 98%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.remove_vma.exit_mmap.mmput
      7.36 ±116%    +497.6%      44.00 ± 94%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.shmem_undo_range.shmem_truncate_range.shmem_evict_inode
      1495 ± 31%    +114.1%       3203 ±  4%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.smpboot_thread_fn.kthread.ret_from_fork
      9.21 ± 22%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.stop_one_cpu.migrate_task_to.task_numa_migrate
     12.64 ±  2%    +300.8%      50.66 ± 43%  perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.stop_one_cpu.sched_exec.bprm_execve
      7.61 ± 29%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_common._cond_resched.wait_for_completion.stop_two_cpus.migrate_swap
     20.69 ± 50%    -100.0%       0.00        perf-sched.wait_time.max.ms.rwsem_down_read_slowpath.page_lock_anon_vma_read.rmap_walk_anon.try_to_unmap
     19.13 ± 36%    -100.0%       0.00        perf-sched.wait_time.max.ms.rwsem_down_read_slowpath.rmap_walk_anon.remove_migration_ptes.migrate_pages
      2.03 ± 55%     -96.2%       0.08 ±151%  perf-sched.wait_time.max.ms.rwsem_down_write_slowpath.__put_anon_vma.unlink_anon_vmas.free_pgtables
      7.53 ± 25%    +397.1%      37.43 ± 76%  perf-sched.wait_time.max.ms.rwsem_down_write_slowpath.__vma_adjust.__split_vma.mprotect_fixup
     31.44 ± 23%   +1888.2%     625.17 ± 62%  perf-sched.wait_time.max.ms.rwsem_down_write_slowpath.dup_mmap.dup_mm.copy_process
      2.32 ± 99%     -88.3%       0.27 ± 87%  perf-sched.wait_time.max.ms.rwsem_down_write_slowpath.unlink_anon_vmas.free_pgtables.exit_mmap
     20.37 ± 28%    +184.7%      57.99 ± 80%  perf-sched.wait_time.max.ms.rwsem_down_write_slowpath.unlink_file_vma.free_pgtables.exit_mmap
     11.76 ± 17%    +170.3%      31.80 ± 43%  perf-sched.wait_time.max.ms.rwsem_down_write_slowpath.vma_link.mmap_region.do_mmap
      5176           -31.0%       3569        perf-sched.wait_time.max.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      5585           -30.2%       3899        perf-sched.wait_time.max.ms.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop.0.do_select
    505.14           +15.5%     583.69 ±  5%  perf-sched.wait_time.max.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
      4816 ± 15%     -31.5%       3297 ±  3%  perf-sched.wait_time.max.ms.smpboot_thread_fn.kthread.ret_from_fork
      1791           -20.7%       1420 ±  3%  perf-sched.wait_time.max.ms.worker_thread.kthread.ret_from_fork
     29455 ±  2%     +33.9%      39449 ±  7%  softirqs.CPU0.NET_RX
     25470           +32.0%      33628        softirqs.CPU0.SCHED
     26529 ± 11%     +43.7%      38110 ±  9%  softirqs.CPU1.NET_RX
     22797 ±  3%     +43.8%      32782 ±  3%  softirqs.CPU1.SCHED
     28371 ±  3%     +54.2%      43762 ± 13%  softirqs.CPU10.NET_RX
     22629 ±  2%     +43.4%      32439 ±  2%  softirqs.CPU10.SCHED
     27171 ±  4%     +38.4%      37593 ±  9%  softirqs.CPU100.NET_RX
     23180 ±  2%     +39.1%      32248        softirqs.CPU100.SCHED
     28196 ±  2%     +34.4%      37895 ±  5%  softirqs.CPU101.NET_RX
     23100           +40.7%      32511 ±  2%  softirqs.CPU101.SCHED
     27883 ±  3%     +43.5%      40015 ± 11%  softirqs.CPU102.NET_RX
     22937 ±  2%     +41.4%      32444 ±  2%  softirqs.CPU102.SCHED
     28037           +40.7%      39461 ±  7%  softirqs.CPU103.NET_RX
     23000 ±  2%     +41.0%      32435 ±  2%  softirqs.CPU103.SCHED
     28345           +34.9%      38229 ±  9%  softirqs.CPU104.NET_RX
     22314 ±  3%     +45.3%      32417 ±  2%  softirqs.CPU104.SCHED
     27097 ±  2%     +40.7%      38114 ±  3%  softirqs.CPU105.NET_RX
     22615 ±  2%     +42.8%      32294 ±  2%  softirqs.CPU105.SCHED
     26463 ±  3%     +50.9%      39943 ± 12%  softirqs.CPU106.NET_RX
     22730 ±  2%     +42.2%      32319 ±  2%  softirqs.CPU106.SCHED
     27957 ±  2%     +29.0%      36058 ±  6%  softirqs.CPU107.NET_RX
     22901 ±  2%     +41.3%      32362 ±  2%  softirqs.CPU107.SCHED
     29320 ±  8%     +33.4%      39101 ± 10%  softirqs.CPU108.NET_RX
     22873 ±  2%     +41.2%      32301 ±  2%  softirqs.CPU108.SCHED
     29106 ±  2%     +31.5%      38266 ±  3%  softirqs.CPU109.NET_RX
     22591 ±  2%     +43.1%      32336        softirqs.CPU109.SCHED
     28741 ±  5%     +34.6%      38676 ±  6%  softirqs.CPU11.NET_RX
     22399 ±  3%     +44.5%      32364 ±  2%  softirqs.CPU11.SCHED
     26804 ±  5%     +41.8%      38006 ±  5%  softirqs.CPU110.NET_RX
     22766 ±  2%     +43.3%      32619 ±  2%  softirqs.CPU110.SCHED
     25623 ±  7%     +45.9%      37393 ±  9%  softirqs.CPU111.NET_RX
     22586 ±  2%     +43.4%      32391 ±  2%  softirqs.CPU111.SCHED
     28020 ±  6%     +31.8%      36917 ±  7%  softirqs.CPU112.NET_RX
     22741           +42.2%      32349 ±  2%  softirqs.CPU112.SCHED
     28310 ±  7%     +35.1%      38234 ± 12%  softirqs.CPU113.NET_RX
     22884 ±  2%     +42.4%      32577 ±  2%  softirqs.CPU113.SCHED
     25668 ±  5%     +45.9%      37457 ±  7%  softirqs.CPU114.NET_RX
     22706 ±  3%     +41.7%      32178        softirqs.CPU114.SCHED
     28637 ±  5%     +37.6%      39418 ±  6%  softirqs.CPU115.NET_RX
     22796           +41.0%      32139        softirqs.CPU115.SCHED
     26953 ±  7%     +42.1%      38291 ±  7%  softirqs.CPU116.NET_RX
     22646           +42.1%      32171 ±  2%  softirqs.CPU116.SCHED
     28477 ±  8%     +35.4%      38544 ±  3%  softirqs.CPU117.NET_RX
     22866 ±  2%     +40.8%      32189 ±  2%  softirqs.CPU117.SCHED
     27445 ±  7%     +40.9%      38675 ± 11%  softirqs.CPU118.NET_RX
     22902           +41.4%      32386 ±  2%  softirqs.CPU118.SCHED
     26884 ±  4%     +38.3%      37182 ±  6%  softirqs.CPU119.NET_RX
     22721 ±  2%     +42.0%      32265 ±  2%  softirqs.CPU119.SCHED
     28376 ±  9%     +36.6%      38767 ±  9%  softirqs.CPU12.NET_RX
     22706 ±  3%     +40.4%      31877 ±  2%  softirqs.CPU12.SCHED
     27315 ±  7%     +45.1%      39644 ±  4%  softirqs.CPU120.NET_RX
     23157 ±  2%     +38.9%      32175        softirqs.CPU120.SCHED
     26387 ±  5%     +51.6%      40015 ±  4%  softirqs.CPU121.NET_RX
     22856           +38.5%      31646        softirqs.CPU121.SCHED
     25176 ±  7%     +67.6%      42194 ±  4%  softirqs.CPU122.NET_RX
     22775           +40.3%      31962        softirqs.CPU122.SCHED
     25636 ±  5%     +60.8%      41225 ±  7%  softirqs.CPU123.NET_RX
     23322           +37.7%      32124        softirqs.CPU123.SCHED
     29777 ±  2%     +37.4%      40911 ±  3%  softirqs.CPU124.NET_RX
     23141 ±  2%     +38.7%      32098        softirqs.CPU124.SCHED
     25720 ±  7%     +53.0%      39356 ±  4%  softirqs.CPU125.NET_RX
     23140 ±  3%     +38.7%      32104        softirqs.CPU125.SCHED
     27106 ±  2%     +44.7%      39214 ±  2%  softirqs.CPU126.NET_RX
     33141 ±  3%     +11.4%      36924 ±  7%  softirqs.CPU126.RCU
     23154 ±  2%     +38.6%      32083        softirqs.CPU126.SCHED
     25748 ±  4%     +53.8%      39601 ±  8%  softirqs.CPU127.NET_RX
     23011 ±  2%     +39.4%      32068        softirqs.CPU127.SCHED
     28647 ± 11%     +42.1%      40718        softirqs.CPU128.NET_RX
     34186 ±  3%     +11.6%      38137 ±  7%  softirqs.CPU128.RCU
     23173 ±  2%     +38.2%      32016        softirqs.CPU128.SCHED
     27101 ±  3%     +48.6%      40259 ±  5%  softirqs.CPU129.NET_RX
     22818           +40.4%      32045        softirqs.CPU129.SCHED
     31534 ± 12%     +25.9%      39696 ± 10%  softirqs.CPU13.NET_RX
     22674 ±  2%     +41.6%      32108 ±  2%  softirqs.CPU13.SCHED
     27452           +48.9%      40871 ±  2%  softirqs.CPU130.NET_RX
     23203           +37.1%      31807 ±  2%  softirqs.CPU130.SCHED
     26896 ±  3%     +51.9%      40860 ±  4%  softirqs.CPU131.NET_RX
     23148 ±  2%     +37.4%      31814        softirqs.CPU131.SCHED
     28393 ±  3%     +41.2%      40084 ±  7%  softirqs.CPU132.NET_RX
     23200           +36.7%      31706        softirqs.CPU132.SCHED
     26482 ±  3%     +54.4%      40891 ±  3%  softirqs.CPU133.NET_RX
     22970           +41.0%      32382 ±  2%  softirqs.CPU133.SCHED
     26774 ±  7%     +44.7%      38735 ±  5%  softirqs.CPU134.NET_RX
     33646           +10.7%      37240 ±  7%  softirqs.CPU134.RCU
     23088 ±  2%     +38.6%      32008        softirqs.CPU134.SCHED
     26666           +54.1%      41081 ±  7%  softirqs.CPU135.NET_RX
     33456 ±  4%     +14.0%      38141 ±  8%  softirqs.CPU135.RCU
     22804           +40.0%      31925        softirqs.CPU135.SCHED
     26562 ±  5%     +55.4%      41276 ±  7%  softirqs.CPU136.NET_RX
     23134 ±  3%     +38.9%      32141        softirqs.CPU136.SCHED
     25297 ±  4%     +62.9%      41210 ±  6%  softirqs.CPU137.NET_RX
     22846 ±  2%     +39.9%      31955        softirqs.CPU137.SCHED
     26519 ±  6%     +51.6%      40192 ±  4%  softirqs.CPU138.NET_RX
     22478 ±  2%     +41.7%      31858        softirqs.CPU138.SCHED
     26079 ±  9%     +62.0%      42258 ±  2%  softirqs.CPU139.NET_RX
     22994 ±  3%     +39.2%      32007        softirqs.CPU139.SCHED
     26936 ±  2%     +43.0%      38512 ±  9%  softirqs.CPU14.NET_RX
     22604 ±  3%     +42.3%      32166 ±  3%  softirqs.CPU14.SCHED
     27625 ±  9%     +44.2%      39847 ±  5%  softirqs.CPU140.NET_RX
     33066 ±  5%     +14.6%      37895 ±  8%  softirqs.CPU140.RCU
     22609           +41.6%      32006        softirqs.CPU140.SCHED
     26460 ±  5%     +58.1%      41826 ±  5%  softirqs.CPU141.NET_RX
     34319 ±  4%      +9.6%      37601 ±  8%  softirqs.CPU141.RCU
     22848 ±  2%     +39.5%      31868        softirqs.CPU141.SCHED
     27385 ±  8%     +52.1%      41645 ±  6%  softirqs.CPU142.NET_RX
     22881 ±  2%     +40.0%      32033        softirqs.CPU142.SCHED
     27724 ±  3%     +46.8%      40700 ±  5%  softirqs.CPU143.NET_RX
     34109 ±  4%     +10.8%      37789 ±  8%  softirqs.CPU143.RCU
     23092 ±  2%     +39.1%      32110        softirqs.CPU143.SCHED
     28902 ±  8%     +30.5%      37711        softirqs.CPU144.NET_RX
     34885 ±  7%      +8.2%      37745 ±  7%  softirqs.CPU144.RCU
     22671           +40.8%      31929        softirqs.CPU144.SCHED
     29181 ± 10%     +43.3%      41814 ±  7%  softirqs.CPU145.NET_RX
     22655           +38.5%      31371 ±  2%  softirqs.CPU145.SCHED
     28250 ±  7%     +33.9%      37815 ±  5%  softirqs.CPU146.NET_RX
     22502           +42.7%      32115        softirqs.CPU146.SCHED
     26352 ±  5%     +44.3%      38033 ±  4%  softirqs.CPU147.NET_RX
     34098            +9.1%      37212 ±  5%  softirqs.CPU147.RCU
     22712           +39.8%      31759        softirqs.CPU147.SCHED
     26457 ±  5%     +47.7%      39077 ±  2%  softirqs.CPU148.NET_RX
     34771           +10.8%      38542 ±  5%  softirqs.CPU148.RCU
     22626           +41.1%      31925        softirqs.CPU148.SCHED
     27813 ±  3%     +38.2%      38431 ±  3%  softirqs.CPU149.NET_RX
     34785 ±  3%      +9.4%      38071 ±  6%  softirqs.CPU149.RCU
     22830           +39.5%      31857        softirqs.CPU149.SCHED
     27674           +35.0%      37356 ± 10%  softirqs.CPU15.NET_RX
     22708 ±  3%     +40.8%      31984 ±  2%  softirqs.CPU15.SCHED
     28914 ±  4%     +38.6%      40073 ±  5%  softirqs.CPU150.NET_RX
     22867           +40.2%      32054        softirqs.CPU150.SCHED
     26654           +46.9%      39145 ±  4%  softirqs.CPU151.NET_RX
     35269 ±  5%      +7.1%      37772 ±  5%  softirqs.CPU151.RCU
     22567           +41.7%      31987        softirqs.CPU151.SCHED
     27340 ±  3%     +35.5%      37050 ±  7%  softirqs.CPU152.NET_RX
     22561           +41.1%      31833        softirqs.CPU152.SCHED
     25682 ±  4%     +52.9%      39264 ±  3%  softirqs.CPU153.NET_RX
     33854 ±  3%     +13.6%      38450 ±  5%  softirqs.CPU153.RCU
     22484           +42.2%      31972        softirqs.CPU153.SCHED
     27824 ±  6%     +45.0%      40343        softirqs.CPU154.NET_RX
     34996 ±  2%      +9.1%      38165 ±  5%  softirqs.CPU154.RCU
     22409           +41.5%      31717        softirqs.CPU154.SCHED
     26948 ±  6%     +51.9%      40940 ±  3%  softirqs.CPU155.NET_RX
     35069           +10.6%      38779 ±  5%  softirqs.CPU155.RCU
     22696           +42.2%      32266        softirqs.CPU155.SCHED
     26787 ±  3%     +45.7%      39032 ±  4%  softirqs.CPU156.NET_RX
     22583           +41.3%      31902        softirqs.CPU156.SCHED
     26065 ±  2%     +47.8%      38529 ±  4%  softirqs.CPU157.NET_RX
     22442           +42.0%      31866        softirqs.CPU157.SCHED
     27310 ±  3%     +42.2%      38826 ±  8%  softirqs.CPU158.NET_RX
     22593           +40.5%      31752        softirqs.CPU158.SCHED
     26411 ±  4%     +47.7%      39018        softirqs.CPU159.NET_RX
     22535           +42.5%      32103        softirqs.CPU159.SCHED
     28586 ±  3%     +30.9%      37421 ±  8%  softirqs.CPU16.NET_RX
     22668 ±  3%     +45.0%      32879 ±  3%  softirqs.CPU16.SCHED
     27341 ±  2%     +39.4%      38105 ±  2%  softirqs.CPU160.NET_RX
     22494           +41.5%      31829        softirqs.CPU160.SCHED
     26309           +47.7%      38870 ±  6%  softirqs.CPU161.NET_RX
     22652           +41.1%      31964        softirqs.CPU161.SCHED
     28102 ±  3%     +35.3%      38031 ±  3%  softirqs.CPU162.NET_RX
     34995 ±  4%      +6.5%      37255 ±  7%  softirqs.CPU162.RCU
     22800           +40.4%      32000        softirqs.CPU162.SCHED
     24958 ±  5%     +53.9%      38412 ±  7%  softirqs.CPU163.NET_RX
     22582           +42.1%      32079        softirqs.CPU163.SCHED
     27327 ±  2%     +36.9%      37415 ±  4%  softirqs.CPU164.NET_RX
     22516           +43.0%      32204        softirqs.CPU164.SCHED
     27456 ±  5%     +46.4%      40188 ±  4%  softirqs.CPU165.NET_RX
     22509           +42.6%      32104        softirqs.CPU165.SCHED
     26840 ±  3%     +42.0%      38118 ±  5%  softirqs.CPU166.NET_RX
     22847           +40.1%      32002        softirqs.CPU166.SCHED
     28288 ±  2%     +45.7%      41208 ±  8%  softirqs.CPU167.NET_RX
     22656           +43.6%      32529 ±  2%  softirqs.CPU167.SCHED
     27845           +40.0%      38982 ±  5%  softirqs.CPU168.NET_RX
     22861           +39.9%      31984        softirqs.CPU168.SCHED
     26590 ±  8%     +55.4%      41316 ±  5%  softirqs.CPU169.NET_RX
     22774           +40.5%      31990        softirqs.CPU169.SCHED
     27965 ±  4%     +34.4%      37581 ±  6%  softirqs.CPU17.NET_RX
     22416           +43.0%      32064 ±  3%  softirqs.CPU17.SCHED
     29095 ±  2%     +43.8%      41848 ±  4%  softirqs.CPU170.NET_RX
     22753           +41.9%      32295        softirqs.CPU170.SCHED
     25289           +56.3%      39538 ±  4%  softirqs.CPU171.NET_RX
     33179 ±  2%      +7.3%      35615 ±  7%  softirqs.CPU171.RCU
     22899           +40.5%      32171        softirqs.CPU171.SCHED
     25293 ±  3%     +60.0%      40480 ±  7%  softirqs.CPU172.NET_RX
     22584           +42.6%      32196        softirqs.CPU172.SCHED
     27200 ±  5%     +50.1%      40831 ±  4%  softirqs.CPU173.NET_RX
     22804           +41.1%      32183        softirqs.CPU173.SCHED
     27779 ±  3%     +49.3%      41464 ±  7%  softirqs.CPU174.NET_RX
     22569           +42.0%      32056        softirqs.CPU174.SCHED
     26980 ±  6%     +49.2%      40261 ±  5%  softirqs.CPU175.NET_RX
     22818           +41.2%      32220        softirqs.CPU175.SCHED
     27496 ±  6%     +48.8%      40909 ±  9%  softirqs.CPU176.NET_RX
     22818           +40.9%      32139        softirqs.CPU176.SCHED
     27197           +42.7%      38817 ±  8%  softirqs.CPU177.NET_RX
     22770           +40.4%      31976        softirqs.CPU177.SCHED
     27688 ±  2%     +45.6%      40318 ±  8%  softirqs.CPU178.NET_RX
     22820           +39.9%      31937        softirqs.CPU178.SCHED
     26078 ±  4%     +51.3%      39444 ±  5%  softirqs.CPU179.NET_RX
     22716           +40.5%      31912        softirqs.CPU179.SCHED
     27755 ±  2%     +41.2%      39191 ±  8%  softirqs.CPU18.NET_RX
     22621 ±  2%     +41.0%      31900        softirqs.CPU18.SCHED
     28019 ±  5%     +40.3%      39303 ±  9%  softirqs.CPU180.NET_RX
     22549           +41.3%      31869        softirqs.CPU180.SCHED
     27487 ± 10%     +46.9%      40381 ±  7%  softirqs.CPU181.NET_RX
     22776           +40.2%      31943        softirqs.CPU181.SCHED
     26432 ±  2%     +55.0%      40971 ±  7%  softirqs.CPU182.NET_RX
     22815           +40.7%      32105        softirqs.CPU182.SCHED
     27997 ±  4%     +46.5%      41010 ±  4%  softirqs.CPU183.NET_RX
     22875           +39.9%      32004        softirqs.CPU183.SCHED
     24478 ± 14%     +67.2%      40939 ± 10%  softirqs.CPU184.NET_RX
     22192 ±  3%     +45.0%      32177        softirqs.CPU184.SCHED
     27366           +40.4%      38417 ±  8%  softirqs.CPU185.NET_RX
     22879           +40.4%      32119        softirqs.CPU185.SCHED
     28955 ±  4%     +36.2%      39443 ±  6%  softirqs.CPU186.NET_RX
     22929           +39.2%      31913        softirqs.CPU186.SCHED
     26140 ±  5%     +50.3%      39290 ±  8%  softirqs.CPU187.NET_RX
     23163           +38.6%      32110        softirqs.CPU187.SCHED
     26199           +56.2%      40920 ± 11%  softirqs.CPU188.NET_RX
     22814           +41.5%      32276        softirqs.CPU188.SCHED
     27178 ±  5%     +49.7%      40699 ±  3%  softirqs.CPU189.NET_RX
     22673           +41.5%      32083        softirqs.CPU189.SCHED
     27438 ±  7%     +38.7%      38069 ±  5%  softirqs.CPU19.NET_RX
     22583 ±  3%     +42.0%      32066 ±  2%  softirqs.CPU19.SCHED
     26118 ±  9%     +42.6%      37257 ±  8%  softirqs.CPU190.NET_RX
     22621           +41.6%      32022        softirqs.CPU190.SCHED
     25609 ±  5%     +52.5%      39055 ±  9%  softirqs.CPU191.NET_RX
     22510           +40.5%      31618        softirqs.CPU191.SCHED
     28410 ±  5%     +34.1%      38091 ±  5%  softirqs.CPU2.NET_RX
     22190           +43.9%      31937 ±  2%  softirqs.CPU2.SCHED
     28923 ± 10%     +37.5%      39780 ±  9%  softirqs.CPU20.NET_RX
     22749 ±  4%     +41.2%      32113 ±  2%  softirqs.CPU20.SCHED
     27078 ±  3%     +38.2%      37429 ±  8%  softirqs.CPU21.NET_RX
     22477 ±  3%     +42.5%      32029 ±  2%  softirqs.CPU21.SCHED
     26006 ±  9%     +49.7%      38922 ± 11%  softirqs.CPU22.NET_RX
     22743 ±  3%     +41.2%      32108 ±  2%  softirqs.CPU22.SCHED
     28691 ±  2%     +39.6%      40046 ±  5%  softirqs.CPU23.NET_RX
     22668 ±  3%     +41.1%      31976 ±  2%  softirqs.CPU23.SCHED
     32698 ±  4%     +27.5%      41704 ±  3%  softirqs.CPU24.NET_RX
     23538           +34.9%      31764        softirqs.CPU24.SCHED
     27793           +44.1%      40038 ±  9%  softirqs.CPU25.NET_RX
     22892 ±  2%     +38.0%      31602        softirqs.CPU25.SCHED
     30671 ±  3%     +36.4%      41822 ±  7%  softirqs.CPU26.NET_RX
     23207 ±  2%     +36.8%      31744        softirqs.CPU26.SCHED
     26281 ±  6%     +57.6%      41417 ±  3%  softirqs.CPU27.NET_RX
     22758 ±  2%     +40.4%      31952        softirqs.CPU27.SCHED
     26713 ±  5%     +54.6%      41300 ±  4%  softirqs.CPU28.NET_RX
     33769 ±  2%     +11.3%      37593 ±  7%  softirqs.CPU28.RCU
     22857 ±  3%     +38.2%      31586        softirqs.CPU28.SCHED
     27219 ±  3%     +53.1%      41664 ±  8%  softirqs.CPU29.NET_RX
     22988 ±  3%     +38.2%      31775        softirqs.CPU29.SCHED
     26571 ±  5%     +51.2%      40171 ±  8%  softirqs.CPU3.NET_RX
     23000 ±  3%     +38.9%      31946 ±  3%  softirqs.CPU3.SCHED
     26856 ±  4%     +57.9%      42396 ±  2%  softirqs.CPU30.NET_RX
     22915 ±  3%     +38.0%      31629        softirqs.CPU30.SCHED
     28747 ±  6%     +42.3%      40898 ±  9%  softirqs.CPU31.NET_RX
     22863 ±  2%     +39.4%      31864        softirqs.CPU31.SCHED
     26418 ±  4%     +56.0%      41211 ±  4%  softirqs.CPU32.NET_RX
     22861 ±  3%     +38.3%      31613        softirqs.CPU32.SCHED
     27379 ± 13%     +52.0%      41619 ±  3%  softirqs.CPU33.NET_RX
     22743           +38.7%      31538        softirqs.CPU33.SCHED
     27331 ±  6%     +47.9%      40432 ±  7%  softirqs.CPU34.NET_RX
     23071 ±  2%     +37.5%      31730        softirqs.CPU34.SCHED
     27997 ±  9%     +49.7%      41922 ±  4%  softirqs.CPU35.NET_RX
     34868 ±  3%     +10.6%      38580 ±  7%  softirqs.CPU35.RCU
     23029 ±  3%     +37.4%      31635        softirqs.CPU35.SCHED
     26763 ±  4%     +59.4%      42657 ±  6%  softirqs.CPU36.NET_RX
     22829           +38.7%      31657        softirqs.CPU36.SCHED
     27252           +48.6%      40489 ±  3%  softirqs.CPU37.NET_RX
     22546 ±  2%     +40.2%      31603        softirqs.CPU37.SCHED
     26072 ±  9%     +67.4%      43643 ±  7%  softirqs.CPU38.NET_RX
     22711 ±  4%     +39.6%      31710        softirqs.CPU38.SCHED
     27579 ±  3%     +57.8%      43518 ±  5%  softirqs.CPU39.NET_RX
     22705 ±  2%     +39.2%      31596        softirqs.CPU39.SCHED
     28570 ±  3%     +30.7%      37345 ±  7%  softirqs.CPU4.NET_RX
     22763 ±  3%     +41.4%      32189 ±  3%  softirqs.CPU4.SCHED
     26544 ±  5%     +52.0%      40348 ±  5%  softirqs.CPU40.NET_RX
     22746 ±  3%     +39.5%      31726        softirqs.CPU40.SCHED
     28165 ±  5%     +47.1%      41432 ±  3%  softirqs.CPU41.NET_RX
     22791 ±  3%     +38.8%      31624        softirqs.CPU41.SCHED
     28718 ±  6%     +43.4%      41176 ±  8%  softirqs.CPU42.NET_RX
     22603           +39.3%      31493        softirqs.CPU42.SCHED
     27257 ±  4%     +54.4%      42085 ±  4%  softirqs.CPU43.NET_RX
     22763 ±  3%     +39.4%      31742        softirqs.CPU43.SCHED
     26604 ±  3%     +58.0%      42041 ±  5%  softirqs.CPU44.NET_RX
     33772 ±  5%     +13.2%      38218 ±  7%  softirqs.CPU44.RCU
     22764 ±  2%     +39.6%      31790        softirqs.CPU44.SCHED
     26786 ±  4%     +54.4%      41361 ±  6%  softirqs.CPU45.NET_RX
     34271 ±  3%     +10.2%      37764 ±  8%  softirqs.CPU45.RCU
     22813 ±  3%     +38.4%      31565        softirqs.CPU45.SCHED
     28082 ±  5%     +43.0%      40154 ±  7%  softirqs.CPU46.NET_RX
     34703 ±  4%      +9.0%      37818 ±  6%  softirqs.CPU46.RCU
     22800 ±  4%     +39.4%      31785        softirqs.CPU46.SCHED
     28229 ±  2%     +49.3%      42156 ±  6%  softirqs.CPU47.NET_RX
     35007 ±  3%      +9.5%      38323 ±  7%  softirqs.CPU47.RCU
     22878 ±  2%     +38.2%      31613        softirqs.CPU47.SCHED
     29087 ±  4%     +39.9%      40686 ±  3%  softirqs.CPU48.NET_RX
     22510           +40.5%      31621        softirqs.CPU48.SCHED
     27833 ±  5%     +47.3%      40991 ±  6%  softirqs.CPU49.NET_RX
     22119           +42.7%      31572        softirqs.CPU49.SCHED
     28242           +35.9%      38374 ±  6%  softirqs.CPU5.NET_RX
     22636 ±  3%     +42.1%      32161 ±  2%  softirqs.CPU5.SCHED
     28615 ±  4%     +37.2%      39250 ±  5%  softirqs.CPU50.NET_RX
     34409           +12.2%      38623 ±  5%  softirqs.CPU50.RCU
     22248           +41.5%      31482        softirqs.CPU50.SCHED
     28739 ±  5%     +40.6%      40405        softirqs.CPU51.NET_RX
     22458 ±  2%     +41.1%      31679        softirqs.CPU51.SCHED
     28428 ±  6%     +34.7%      38284        softirqs.CPU52.NET_RX
     22308           +41.7%      31601        softirqs.CPU52.SCHED
     29032 ±  6%     +33.6%      38786 ±  7%  softirqs.CPU53.NET_RX
     34502 ±  5%     +10.0%      37943 ±  8%  softirqs.CPU53.RCU
     22408           +40.7%      31526        softirqs.CPU53.SCHED
     27640 ±  7%     +42.5%      39380 ±  2%  softirqs.CPU54.NET_RX
     22473           +40.7%      31609        softirqs.CPU54.SCHED
     26943 ±  9%     +42.4%      38374 ±  4%  softirqs.CPU55.NET_RX
     22289 ±  2%     +42.7%      31800        softirqs.CPU55.SCHED
     27400 ±  4%     +40.2%      38409 ±  5%  softirqs.CPU56.NET_RX
     22354           +40.0%      31300        softirqs.CPU56.SCHED
     26999 ±  2%     +46.5%      39554 ±  6%  softirqs.CPU57.NET_RX
     34130 ±  3%     +12.9%      38546 ±  7%  softirqs.CPU57.RCU
     22383           +41.0%      31569        softirqs.CPU57.SCHED
     26684 ±  3%     +50.6%      40177 ±  3%  softirqs.CPU58.NET_RX
     34403 ±  3%     +11.9%      38510 ±  7%  softirqs.CPU58.RCU
     21983           +44.1%      31667        softirqs.CPU58.SCHED
     28353           +41.2%      40037 ±  5%  softirqs.CPU59.NET_RX
     22456           +40.7%      31589        softirqs.CPU59.SCHED
     27801 ± 10%     +34.5%      37398 ±  5%  softirqs.CPU6.NET_RX
     22604 ±  3%     +41.8%      32058 ±  2%  softirqs.CPU6.SCHED
     26348 ±  3%     +55.7%      41023        softirqs.CPU60.NET_RX
     22333           +41.1%      31517        softirqs.CPU60.SCHED
     27592 ±  8%     +43.0%      39449 ±  4%  softirqs.CPU61.NET_RX
     22340           +40.8%      31449        softirqs.CPU61.SCHED
     27991 ±  6%     +39.9%      39173 ±  6%  softirqs.CPU62.NET_RX
     22336           +41.0%      31505        softirqs.CPU62.SCHED
     27979 ±  6%     +42.4%      39848 ±  6%  softirqs.CPU63.NET_RX
     22455           +40.7%      31595        softirqs.CPU63.SCHED
     27343 ±  4%     +47.1%      40224 ±  7%  softirqs.CPU64.NET_RX
     22264           +42.4%      31709        softirqs.CPU64.SCHED
     30930 ± 12%     +24.7%      38565 ±  3%  softirqs.CPU65.NET_RX
     22563           +39.9%      31572        softirqs.CPU65.SCHED
     27228 ±  3%     +40.3%      38207 ±  5%  softirqs.CPU66.NET_RX
     33624 ±  2%     +10.9%      37300 ±  6%  softirqs.CPU66.RCU
     22263           +42.0%      31615        softirqs.CPU66.SCHED
     26629 ±  7%     +45.8%      38826 ±  3%  softirqs.CPU67.NET_RX
     22267           +42.1%      31644        softirqs.CPU67.SCHED
     27039 ±  7%     +46.4%      39598 ±  3%  softirqs.CPU68.NET_RX
     22376           +41.0%      31552        softirqs.CPU68.SCHED
     26835 ±  4%     +41.3%      37921 ±  4%  softirqs.CPU69.NET_RX
     22292           +42.2%      31695        softirqs.CPU69.SCHED
     28526 ±  9%     +36.6%      38980 ±  9%  softirqs.CPU7.NET_RX
     22556 ±  3%     +42.0%      32026 ±  3%  softirqs.CPU7.SCHED
     27716 ±  6%     +44.2%      39956 ±  5%  softirqs.CPU70.NET_RX
     22376           +40.4%      31421        softirqs.CPU70.SCHED
     25987 ±  2%     +54.0%      40017 ±  5%  softirqs.CPU71.NET_RX
     22256           +42.9%      31803        softirqs.CPU71.SCHED
     30271 ±  2%     +31.6%      39836 ±  8%  softirqs.CPU72.NET_RX
     22864           +39.9%      31988        softirqs.CPU72.SCHED
     28646 ±  7%     +40.8%      40326 ±  6%  softirqs.CPU73.NET_RX
     22434           +41.4%      31715        softirqs.CPU73.SCHED
     27673 ±  4%     +44.6%      40027 ±  5%  softirqs.CPU74.NET_RX
     22454           +41.1%      31688        softirqs.CPU74.SCHED
     26780 ±  5%     +50.1%      40207 ±  5%  softirqs.CPU75.NET_RX
     22613           +40.8%      31840        softirqs.CPU75.SCHED
     28051           +45.5%      40826 ±  5%  softirqs.CPU76.NET_RX
     22608           +41.0%      31879        softirqs.CPU76.SCHED
     26339 ±  5%     +49.7%      39425 ± 10%  softirqs.CPU77.NET_RX
     22329           +43.4%      32019        softirqs.CPU77.SCHED
     28822           +38.8%      40011 ±  6%  softirqs.CPU78.NET_RX
     22588           +41.2%      31903        softirqs.CPU78.SCHED
     26965 ±  4%     +50.8%      40656 ±  8%  softirqs.CPU79.NET_RX
     22337           +41.9%      31701        softirqs.CPU79.SCHED
     28854 ±  2%     +36.0%      39243 ±  7%  softirqs.CPU8.NET_RX
     33868 ±  2%      +8.2%      36644 ±  4%  softirqs.CPU8.RCU
     22572 ±  2%     +41.6%      31966 ±  3%  softirqs.CPU8.SCHED
     25294 ±  3%     +62.3%      41046 ±  9%  softirqs.CPU80.NET_RX
     22560           +41.6%      31949        softirqs.CPU80.SCHED
     27226 ±  6%     +44.2%      39272 ±  5%  softirqs.CPU81.NET_RX
     22433           +41.8%      31802        softirqs.CPU81.SCHED
     28179 ±  2%     +45.8%      41089 ±  6%  softirqs.CPU82.NET_RX
     22503           +41.1%      31742        softirqs.CPU82.SCHED
     25370 ±  6%     +65.5%      41993 ±  3%  softirqs.CPU83.NET_RX
     33224 ±  3%      +9.5%      36387 ±  5%  softirqs.CPU83.RCU
     22482           +43.4%      32239        softirqs.CPU83.SCHED
     29150 ±  4%     +41.9%      41357 ±  6%  softirqs.CPU84.NET_RX
     22540           +40.3%      31629        softirqs.CPU84.SCHED
     27566 ±  7%     +45.2%      40032 ±  6%  softirqs.CPU85.NET_RX
     22614           +40.5%      31779        softirqs.CPU85.SCHED
     26616 ±  3%     +48.0%      39392 ±  8%  softirqs.CPU86.NET_RX
     22503           +41.8%      31899        softirqs.CPU86.SCHED
     27217           +54.7%      42097 ±  4%  softirqs.CPU87.NET_RX
     32656           +11.1%      36286 ±  8%  softirqs.CPU87.RCU
     22383           +41.8%      31744        softirqs.CPU87.SCHED
     29444 ±  5%     +35.2%      39821 ±  6%  softirqs.CPU88.NET_RX
     22560 ±  2%     +41.3%      31887        softirqs.CPU88.SCHED
     26383 ±  3%     +49.4%      39403 ±  5%  softirqs.CPU89.NET_RX
     22647           +41.2%      31984        softirqs.CPU89.SCHED
     27413           +45.5%      39873 ±  3%  softirqs.CPU9.NET_RX
     22436 ±  3%     +43.3%      32154 ±  2%  softirqs.CPU9.SCHED
     28117 ±  4%     +39.1%      39110 ±  5%  softirqs.CPU90.NET_RX
     22524           +41.6%      31903        softirqs.CPU90.SCHED
     28805 ±  3%     +43.1%      41207 ±  2%  softirqs.CPU91.NET_RX
     22981           +38.0%      31714        softirqs.CPU91.SCHED
     27920 ±  9%     +46.1%      40778 ±  7%  softirqs.CPU92.NET_RX
     33255 ±  4%      +8.9%      36199 ±  7%  softirqs.CPU92.RCU
     22467           +42.2%      31955        softirqs.CPU92.SCHED
     26935 ±  5%     +49.3%      40211 ±  6%  softirqs.CPU93.NET_RX
     22407           +42.4%      31898        softirqs.CPU93.SCHED
     25585 ±  6%     +63.7%      41880 ±  5%  softirqs.CPU94.NET_RX
     33095 ±  4%     +10.4%      36528 ±  9%  softirqs.CPU94.RCU
     22417           +41.7%      31761        softirqs.CPU94.SCHED
     27659 ±  6%     +43.3%      39639 ±  6%  softirqs.CPU95.NET_RX
     21998           +42.6%      31361        softirqs.CPU95.SCHED
     26582 ±  2%     +43.4%      38128 ±  8%  softirqs.CPU96.NET_RX
     22170 ±  3%     +45.7%      32297        softirqs.CPU96.SCHED
     27522 ±  5%     +39.4%      38353 ±  9%  softirqs.CPU97.NET_RX
     22468 ±  3%     +43.4%      32209 ±  2%  softirqs.CPU97.SCHED
     27117 ± 12%     +39.8%      37902 ± 10%  softirqs.CPU98.NET_RX
     22600           +43.2%      32361 ±  2%  softirqs.CPU98.SCHED
     26557 ±  2%     +43.7%      38161 ±  7%  softirqs.CPU99.NET_RX
     23003           +41.6%      32565        softirqs.CPU99.SCHED
   5270210           +44.9%    7635912        softirqs.NET_RX
   4357512           +40.8%    6136169        softirqs.SCHED
     80.01           -80.0        0.00        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.scan_positives.dcache_readdir.iterate_dir
     81.90           -68.9       13.02 ±  5%  perf-profile.calltrace.cycles-pp.dcache_readdir.iterate_dir.__x64_sys_getdents64.do_syscall_64.entry_SYSCALL_64_after_hwframe
     81.91           -68.9       13.03 ±  5%  perf-profile.calltrace.cycles-pp.__x64_sys_getdents64.do_syscall_64.entry_SYSCALL_64_after_hwframe
     81.90           -68.9       13.03 ±  5%  perf-profile.calltrace.cycles-pp.iterate_dir.__x64_sys_getdents64.do_syscall_64.entry_SYSCALL_64_after_hwframe
     80.60           -68.8       11.80 ±  5%  perf-profile.calltrace.cycles-pp.scan_positives.dcache_readdir.iterate_dir.__x64_sys_getdents64.do_syscall_64
     80.30           -68.7       11.63 ±  5%  perf-profile.calltrace.cycles-pp._raw_spin_lock.scan_positives.dcache_readdir.iterate_dir.__x64_sys_getdents64
     85.88           -51.1       34.79 ± 13%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe
     85.98           -50.8       35.15 ± 13%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.37 ± 70%      +0.4        0.80 ±  4%  perf-profile.calltrace.cycles-pp.do_sys_openat2.do_sys_open.do_syscall_64.entry_SYSCALL_64_after_hwframe.creat64
      0.37 ± 70%      +0.4        0.81 ±  4%  perf-profile.calltrace.cycles-pp.do_sys_open.do_syscall_64.entry_SYSCALL_64_after_hwframe.creat64
      0.37 ± 70%      +0.4        0.81 ±  4%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.creat64
      0.39 ± 70%      +0.4        0.82 ±  3%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.creat64
      0.39 ± 70%      +0.4        0.84 ±  3%  perf-profile.calltrace.cycles-pp.creat64
      0.37 ± 70%      +0.6        0.93 ± 10%  perf-profile.calltrace.cycles-pp.div_long
      0.00            +0.6        0.62 ± 10%  perf-profile.calltrace.cycles-pp.kmem_cache_free.rcu_do_batch.rcu_core.__softirqentry_text_start.asm_call_sysvec_on_stack
      0.00            +0.6        0.62 ± 10%  perf-profile.calltrace.cycles-pp.__strcat_chk
      0.39 ± 70%      +0.7        1.04 ±  9%  perf-profile.calltrace.cycles-pp.add_int.add_int
      0.38 ± 70%      +0.7        1.04 ±  8%  perf-profile.calltrace.cycles-pp.add_long.add_long
      0.00            +0.7        0.68 ±  9%  perf-profile.calltrace.cycles-pp.rcu_do_batch.rcu_core.__softirqentry_text_start.asm_call_sysvec_on_stack.do_softirq_own_stack
      0.00            +0.7        0.69 ±  9%  perf-profile.calltrace.cycles-pp.rcu_core.__softirqentry_text_start.asm_call_sysvec_on_stack.do_softirq_own_stack.irq_exit_rcu
      0.00            +0.7        0.73 ±  3%  perf-profile.calltrace.cycles-pp.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      0.00            +0.8        0.76 ±  9%  perf-profile.calltrace.cycles-pp.__softirqentry_text_start.asm_call_sysvec_on_stack.do_softirq_own_stack.irq_exit_rcu.sysvec_apic_timer_interrupt
      0.00            +0.8        0.76 ±  9%  perf-profile.calltrace.cycles-pp.asm_call_sysvec_on_stack.do_softirq_own_stack.irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      0.00            +0.8        0.76 ±  9%  perf-profile.calltrace.cycles-pp.do_softirq_own_stack.irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state
      0.36 ± 70%      +0.8        1.12 ± 11%  perf-profile.calltrace.cycles-pp.__strncat_chk
      0.00            +0.8        0.77 ±  3%  perf-profile.calltrace.cycles-pp.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      0.00            +0.8        0.77 ±  9%  perf-profile.calltrace.cycles-pp.irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter
      0.00            +0.8        0.79 ± 23%  perf-profile.calltrace.cycles-pp.osq_lock.rwsem_down_write_slowpath.__vma_adjust.__split_vma.__do_munmap
      0.00            +0.8        0.81 ± 23%  perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.__vma_adjust.__split_vma.__do_munmap.mmap_region
      0.00            +0.8        0.81 ± 22%  perf-profile.calltrace.cycles-pp.osq_lock.rwsem_down_write_slowpath.__vma_adjust.__split_vma.mprotect_fixup
      0.00            +0.8        0.82 ±  3%  perf-profile.calltrace.cycles-pp.walk_component.link_path_walk.path_openat.do_filp_open.do_sys_openat2
      0.00            +0.8        0.84 ± 21%  perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.__vma_adjust.__split_vma.mprotect_fixup.do_mprotect_pkey
      0.00            +0.8        0.85 ±  3%  perf-profile.calltrace.cycles-pp.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      0.00            +0.9        0.85 ±  3%  perf-profile.calltrace.cycles-pp.link_path_walk.path_openat.do_filp_open.do_sys_openat2.do_sys_open
      0.00            +0.9        0.86 ±  3%  perf-profile.calltrace.cycles-pp.exc_page_fault.asm_exc_page_fault
      0.00            +0.9        0.86 ± 22%  perf-profile.calltrace.cycles-pp.__vma_adjust.__split_vma.__do_munmap.mmap_region.do_mmap
      0.18 ±141%      +0.9        1.04 ± 24%  perf-profile.calltrace.cycles-pp.osq_lock.rwsem_down_write_slowpath.unlink_file_vma.free_pgtables.unmap_region
      0.17 ±141%      +0.9        1.03 ± 22%  perf-profile.calltrace.cycles-pp.osq_lock.rwsem_down_write_slowpath.vma_link.mmap_region.do_mmap
      0.00            +0.9        0.88 ± 24%  perf-profile.calltrace.cycles-pp.unlink_file_vma.free_pgtables.exit_mmap.mmput.begin_new_exec
      0.00            +0.9        0.88 ± 21%  perf-profile.calltrace.cycles-pp.__split_vma.__do_munmap.mmap_region.do_mmap.vm_mmap_pgoff
      0.18 ±141%      +0.9        1.07 ± 23%  perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.unlink_file_vma.free_pgtables.unmap_region.__do_munmap
      0.17 ±141%      +0.9        1.06 ± 21%  perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.vma_link.mmap_region.do_mmap.vm_mmap_pgoff
      0.18 ±141%      +0.9        1.08 ± 23%  perf-profile.calltrace.cycles-pp.unlink_file_vma.free_pgtables.unmap_region.__do_munmap.mmap_region
      0.19 ±141%      +0.9        1.09 ± 23%  perf-profile.calltrace.cycles-pp.free_pgtables.unmap_region.__do_munmap.mmap_region.do_mmap
      0.19 ±141%      +0.9        1.12 ± 23%  perf-profile.calltrace.cycles-pp.unmap_region.__do_munmap.mmap_region.do_mmap.vm_mmap_pgoff
      0.00            +0.9        0.93 ±  4%  perf-profile.calltrace.cycles-pp.asm_exc_page_fault
      0.17 ±141%      +0.9        1.10 ± 19%  perf-profile.calltrace.cycles-pp.free_pgtables.exit_mmap.mmput.begin_new_exec.load_elf_binary
      0.18 ±141%      +0.9        1.12 ± 20%  perf-profile.calltrace.cycles-pp.vma_link.mmap_region.do_mmap.vm_mmap_pgoff.ksys_mmap_pgoff
      0.00            +0.9        0.94 ± 19%  perf-profile.calltrace.cycles-pp.__vma_adjust.__split_vma.mprotect_fixup.do_mprotect_pkey.__x64_sys_mprotect
      0.00            +1.0        0.98 ± 18%  perf-profile.calltrace.cycles-pp.__split_vma.mprotect_fixup.do_mprotect_pkey.__x64_sys_mprotect.do_syscall_64
      0.00            +1.0        1.02 ± 18%  perf-profile.calltrace.cycles-pp.mprotect_fixup.do_mprotect_pkey.__x64_sys_mprotect.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.20 ±141%      +1.0        1.22 ± 24%  perf-profile.calltrace.cycles-pp.unlink_file_vma.free_pgtables.exit_mmap.mmput.do_exit
      0.00            +1.0        1.03 ± 18%  perf-profile.calltrace.cycles-pp.__x64_sys_mprotect.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +1.0        1.03 ± 18%  perf-profile.calltrace.cycles-pp.do_mprotect_pkey.__x64_sys_mprotect.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.39 ± 72%      +1.1        1.45 ± 11%  perf-profile.calltrace.cycles-pp.__do_sys_clone.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.39 ± 72%      +1.1        1.45 ± 11%  perf-profile.calltrace.cycles-pp.kernel_clone.__do_sys_clone.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +1.1        1.06 ± 26%  perf-profile.calltrace.cycles-pp._raw_spin_lock.lockref_get.d_alloc_cursor.dcache_dir_open.do_dentry_open
      0.00            +1.1        1.06 ± 26%  perf-profile.calltrace.cycles-pp.__cna_queued_spin_lock_slowpath._raw_spin_lock.lockref_get.d_alloc_cursor.dcache_dir_open
      0.00            +1.1        1.06 ± 26%  perf-profile.calltrace.cycles-pp.lockref_get.d_alloc_cursor.dcache_dir_open.do_dentry_open.path_openat
      0.00            +1.1        1.06 ± 26%  perf-profile.calltrace.cycles-pp.dcache_dir_open.do_dentry_open.path_openat.do_filp_open.do_sys_openat2
      0.00            +1.1        1.06 ± 26%  perf-profile.calltrace.cycles-pp.d_alloc_cursor.dcache_dir_open.do_dentry_open.path_openat.do_filp_open
      0.20 ±141%      +1.1        1.27 ± 14%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__libc_fork
      0.20 ±141%      +1.1        1.27 ± 14%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_fork
      0.20 ±141%      +1.1        1.27 ± 14%  perf-profile.calltrace.cycles-pp.__do_sys_clone.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_fork
      0.19 ±141%      +1.1        1.27 ± 14%  perf-profile.calltrace.cycles-pp.kernel_clone.__do_sys_clone.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_fork
      0.21 ±141%      +1.1        1.33 ± 22%  perf-profile.calltrace.cycles-pp.free_pgtables.exit_mmap.mmput.do_exit.do_group_exit
      0.00            +1.1        1.12 ± 11%  perf-profile.calltrace.cycles-pp.__cna_queued_spin_lock_slowpath._raw_spin_lock.dcache_readdir.iterate_dir.__x64_sys_getdents64
      0.60 ±  6%      +1.1        1.73 ± 24%  perf-profile.calltrace.cycles-pp.exit_mmap.mmput.begin_new_exec.load_elf_binary.exec_binprm
      0.20 ±141%      +1.1        1.33 ± 13%  perf-profile.calltrace.cycles-pp.__libc_fork
      0.60 ±  6%      +1.1        1.73 ± 24%  perf-profile.calltrace.cycles-pp.mmput.begin_new_exec.load_elf_binary.exec_binprm.bprm_execve
      0.17 ±141%      +1.1        1.32 ± 16%  perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry
      0.00            +1.1        1.15 ± 18%  perf-profile.calltrace.cycles-pp.drain_obj_stock.refill_obj_stock.kmem_cache_free.rcu_do_batch.rcu_core
      0.62 ±  6%      +1.2        1.78 ± 23%  perf-profile.calltrace.cycles-pp.begin_new_exec.load_elf_binary.exec_binprm.bprm_execve.do_execveat_common
      0.00            +1.2        1.18 ± 21%  perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter.do_idle
      0.80 ± 20%      +1.2        2.03 ± 22%  perf-profile.calltrace.cycles-pp.__do_munmap.mmap_region.do_mmap.vm_mmap_pgoff.ksys_mmap_pgoff
      0.73 ± 17%      +1.2        1.98 ± 14%  perf-profile.calltrace.cycles-pp.exit_mmap.mmput.do_exit.do_group_exit.__x64_sys_exit_group
      0.73 ± 17%      +1.2        1.98 ± 14%  perf-profile.calltrace.cycles-pp.mmput.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      0.00            +1.3        1.28 ± 18%  perf-profile.calltrace.cycles-pp._raw_spin_lock.lockref_get.do_dentry_open.path_openat.do_filp_open
      0.00            +1.3        1.28 ± 18%  perf-profile.calltrace.cycles-pp.__cna_queued_spin_lock_slowpath._raw_spin_lock.lockref_get.do_dentry_open.path_openat
      0.00            +1.3        1.29 ± 18%  perf-profile.calltrace.cycles-pp.lockref_get.do_dentry_open.path_openat.do_filp_open.do_sys_openat2
      0.00            +1.4        1.36 ± 39%  perf-profile.calltrace.cycles-pp.osq_lock.rwsem_down_write_slowpath.dup_mmap.dup_mm.copy_process
      0.81 ± 16%      +1.4        2.20 ± 13%  perf-profile.calltrace.cycles-pp.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.81 ± 16%      +1.4        2.21 ± 13%  perf-profile.calltrace.cycles-pp.__x64_sys_exit_group.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.81 ± 16%      +1.4        2.21 ± 13%  perf-profile.calltrace.cycles-pp.do_group_exit.__x64_sys_exit_group.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +1.4        1.41 ± 38%  perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.dup_mmap.dup_mm.copy_process.kernel_clone
      0.00            +1.4        1.41 ± 17%  perf-profile.calltrace.cycles-pp.refill_obj_stock.kmem_cache_free.rcu_do_batch.rcu_core.__softirqentry_text_start
      0.18 ±141%      +1.7        1.92 ± 26%  perf-profile.calltrace.cycles-pp.osq_lock.rwsem_down_write_slowpath.unlink_file_vma.free_pgtables.exit_mmap
      0.19 ±141%      +1.8        2.01 ± 25%  perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.unlink_file_vma.free_pgtables.exit_mmap.mmput
      0.83 ±  5%      +1.8        2.65 ± 14%  perf-profile.calltrace.cycles-pp.load_elf_binary.exec_binprm.bprm_execve.do_execveat_common.__x64_sys_execve
      0.83 ±  4%      +1.8        2.67 ± 13%  perf-profile.calltrace.cycles-pp.exec_binprm.bprm_execve.do_execveat_common.__x64_sys_execve.do_syscall_64
      0.36 ±141%      +2.0        2.32 ± 15%  perf-profile.calltrace.cycles-pp.dup_mm.copy_process.kernel_clone.__do_sys_clone.do_syscall_64
      1.24 ± 20%      +2.0        3.23 ± 21%  perf-profile.calltrace.cycles-pp.mmap_region.do_mmap.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64
      1.25 ± 20%      +2.0        3.23 ± 21%  perf-profile.calltrace.cycles-pp.do_mmap.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.26 ± 20%      +2.0        3.25 ± 21%  perf-profile.calltrace.cycles-pp.ksys_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.26 ± 20%      +2.0        3.25 ± 21%  perf-profile.calltrace.cycles-pp.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.68 ± 14%      +2.0        3.72 ± 10%  perf-profile.calltrace.cycles-pp.string_rtns_1
      0.19 ±141%      +2.1        2.29 ± 15%  perf-profile.calltrace.cycles-pp.dup_mmap.dup_mm.copy_process.kernel_clone.__do_sys_clone
      0.39 ±141%      +2.2        2.58 ± 13%  perf-profile.calltrace.cycles-pp.copy_process.kernel_clone.__do_sys_clone.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +2.6        2.62 ±  6%  perf-profile.calltrace.cycles-pp.do_dentry_open.path_openat.do_filp_open.do_sys_openat2.do_sys_open
      0.40 ± 70%      +3.1        3.52 ± 15%  perf-profile.calltrace.cycles-pp.kmem_cache_free.rcu_do_batch.rcu_core.__softirqentry_text_start.run_ksoftirqd
      0.61 ± 11%      +3.2        3.79 ± 15%  perf-profile.calltrace.cycles-pp.rcu_do_batch.rcu_core.__softirqentry_text_start.run_ksoftirqd.smpboot_thread_fn
      0.61 ± 11%      +3.2        3.79 ± 15%  perf-profile.calltrace.cycles-pp.rcu_core.__softirqentry_text_start.run_ksoftirqd.smpboot_thread_fn.kthread
      0.61 ± 11%      +3.2        3.79 ± 15%  perf-profile.calltrace.cycles-pp.__softirqentry_text_start.run_ksoftirqd.smpboot_thread_fn.kthread.ret_from_fork
      0.61 ± 11%      +3.2        3.79 ± 15%  perf-profile.calltrace.cycles-pp.run_ksoftirqd.smpboot_thread_fn.kthread.ret_from_fork
      0.61 ± 12%      +3.2        3.82 ± 15%  perf-profile.calltrace.cycles-pp.smpboot_thread_fn.kthread.ret_from_fork
      0.65 ± 11%      +3.2        3.88 ± 15%  perf-profile.calltrace.cycles-pp.kthread.ret_from_fork
      0.65 ± 11%      +3.2        3.89 ± 15%  perf-profile.calltrace.cycles-pp.ret_from_fork
      0.22 ±141%      +4.1        4.27 ± 28%  perf-profile.calltrace.cycles-pp.do_sys_openat2.do_sys_open.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.22 ±141%      +4.1        4.28 ± 28%  perf-profile.calltrace.cycles-pp.do_sys_open.do_syscall_64.entry_SYSCALL_64_after_hwframe
      3.30 ± 10%      +6.1        9.36 ± 10%  perf-profile.calltrace.cycles-pp.intel_idle.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry
      0.00            +6.2        6.21 ±  3%  perf-profile.calltrace.cycles-pp._raw_spin_lock.lockref_get_not_dead.__legitimize_path.unlazy_walk.complete_walk
      0.00            +6.2        6.22 ±  3%  perf-profile.calltrace.cycles-pp.lockref_get_not_dead.__legitimize_path.unlazy_walk.complete_walk.path_openat
      0.00            +6.2        6.22 ±  3%  perf-profile.calltrace.cycles-pp.unlazy_walk.complete_walk.path_openat.do_filp_open.do_sys_openat2
      0.00            +6.2        6.22 ±  3%  perf-profile.calltrace.cycles-pp.__legitimize_path.unlazy_walk.complete_walk.path_openat.do_filp_open
      0.00            +6.2        6.22 ±  3%  perf-profile.calltrace.cycles-pp.complete_walk.path_openat.do_filp_open.do_sys_openat2.do_sys_open
      0.00            +6.5        6.47 ±  7%  perf-profile.calltrace.cycles-pp._raw_spin_lock.lockref_put_or_lock.dput.step_into.path_openat
      0.00            +6.5        6.47 ±  7%  perf-profile.calltrace.cycles-pp.__cna_queued_spin_lock_slowpath._raw_spin_lock.lockref_put_or_lock.dput.step_into
      0.00            +6.5        6.47 ±  7%  perf-profile.calltrace.cycles-pp.dput.step_into.path_openat.do_filp_open.do_open_execat
      0.00            +6.5        6.47 ±  7%  perf-profile.calltrace.cycles-pp.lockref_put_or_lock.dput.step_into.path_openat.do_filp_open
      0.00            +7.0        6.99 ± 19%  perf-profile.calltrace.cycles-pp.do_sys_open.do_syscall_64.entry_SYSCALL_64_after_hwframe.__open64_nocancel
      0.00            +7.0        6.99 ± 19%  perf-profile.calltrace.cycles-pp.do_sys_openat2.do_sys_open.do_syscall_64.entry_SYSCALL_64_after_hwframe.__open64_nocancel
      0.00            +7.0        6.99 ± 18%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__open64_nocancel
      0.00            +7.0        7.00 ± 18%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__open64_nocancel
      0.00            +7.0        7.00 ± 18%  perf-profile.calltrace.cycles-pp.__open64_nocancel
      3.79 ± 10%      +7.0       10.82 ±  8%  perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry.start_secondary
      3.86 ±  9%      +7.1       10.96 ±  8%  perf-profile.calltrace.cycles-pp.cpuidle_enter.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      4.17 ±  6%      +7.4       11.59 ±  8%  perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      4.17 ±  6%      +7.4       11.59 ±  8%  perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      4.17 ±  6%      +7.4       11.59 ±  8%  perf-profile.calltrace.cycles-pp.start_secondary.secondary_startup_64_no_verify
      4.20 ±  6%      +7.4       11.63 ±  8%  perf-profile.calltrace.cycles-pp.secondary_startup_64_no_verify
      0.00            +8.6        8.58 ± 38%  perf-profile.calltrace.cycles-pp.do_execveat_common.__x64_sys_execve.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +8.6        8.59 ± 38%  perf-profile.calltrace.cycles-pp.__x64_sys_execve.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00           +11.2       11.23 ±  5%  perf-profile.calltrace.cycles-pp.__cna_queued_spin_lock_slowpath._raw_spin_lock.scan_positives.dcache_readdir.iterate_dir
      0.56 ±  7%     +11.4       11.95 ±  2%  perf-profile.calltrace.cycles-pp.path_openat.do_filp_open.do_sys_openat2.do_sys_open.do_syscall_64
      0.56 ±  7%     +11.4       11.96 ±  2%  perf-profile.calltrace.cycles-pp.do_filp_open.do_sys_openat2.do_sys_open.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00           +24.2       24.23 ±  4%  perf-profile.calltrace.cycles-pp._raw_spin_lock.lockref_get_not_dead.__legitimize_path.unlazy_walk.pick_link
      0.00           +24.2       24.25 ±  4%  perf-profile.calltrace.cycles-pp.unlazy_walk.pick_link.step_into.path_openat.do_filp_open
      0.00           +24.2       24.25 ±  4%  perf-profile.calltrace.cycles-pp.__legitimize_path.unlazy_walk.pick_link.step_into.path_openat
      0.00           +24.2       24.25 ±  4%  perf-profile.calltrace.cycles-pp.lockref_get_not_dead.__legitimize_path.unlazy_walk.pick_link.step_into
      0.00           +24.2       24.25 ±  4%  perf-profile.calltrace.cycles-pp.pick_link.step_into.path_openat.do_filp_open.do_open_execat
      1.02 ±  4%     +24.4       25.41 ±  8%  perf-profile.calltrace.cycles-pp.do_execveat_common.__x64_sys_execve.do_syscall_64.entry_SYSCALL_64_after_hwframe.execve
      1.02 ±  4%     +24.4       25.42 ±  8%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.execve
      1.02 ±  4%     +24.4       25.42 ±  8%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.execve
      1.02 ±  4%     +24.4       25.42 ±  8%  perf-profile.calltrace.cycles-pp.__x64_sys_execve.do_syscall_64.entry_SYSCALL_64_after_hwframe.execve
      1.03 ±  4%     +24.4       25.43 ±  8%  perf-profile.calltrace.cycles-pp.execve
      0.00           +30.4       30.45 ±  3%  perf-profile.calltrace.cycles-pp.__cna_queued_spin_lock_slowpath._raw_spin_lock.lockref_get_not_dead.__legitimize_path.unlazy_walk
      0.00           +30.8       30.82 ±  3%  perf-profile.calltrace.cycles-pp.step_into.path_openat.do_filp_open.do_open_execat.bprm_execve
      0.00           +30.8       30.84 ±  3%  perf-profile.calltrace.cycles-pp.do_filp_open.do_open_execat.bprm_execve.do_execveat_common.__x64_sys_execve
      0.00           +30.8       30.84 ±  3%  perf-profile.calltrace.cycles-pp.path_openat.do_filp_open.do_open_execat.bprm_execve.do_execveat_common
      0.00           +30.8       30.84 ±  3%  perf-profile.calltrace.cycles-pp.do_open_execat.bprm_execve.do_execveat_common.__x64_sys_execve.do_syscall_64
      0.95 ±  4%     +32.8       33.76 ±  3%  perf-profile.calltrace.cycles-pp.bprm_execve.do_execveat_common.__x64_sys_execve.do_syscall_64.entry_SYSCALL_64_after_hwframe
     82.33           -82.3        0.00        perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
     81.90           -68.9       13.02 ±  5%  perf-profile.children.cycles-pp.dcache_readdir
     81.91           -68.9       13.03 ±  5%  perf-profile.children.cycles-pp.__x64_sys_getdents64
     81.90           -68.9       13.03 ±  5%  perf-profile.children.cycles-pp.iterate_dir
     80.60           -68.8       11.80 ±  5%  perf-profile.children.cycles-pp.scan_positives
     82.71           -27.9       54.83 ±  2%  perf-profile.children.cycles-pp._raw_spin_lock
     89.05           -18.0       71.08        perf-profile.children.cycles-pp.do_syscall_64
     89.35           -17.5       71.82        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.54 ± 22%      -0.2        0.32 ± 20%  perf-profile.children.cycles-pp.llseek
      0.62            -0.2        0.45 ±  9%  perf-profile.children.cycles-pp.ksys_lseek
      0.62            -0.2        0.45 ±  9%  perf-profile.children.cycles-pp.dcache_dir_lseek
      0.06 ±  8%      +0.0        0.09 ± 21%  perf-profile.children.cycles-pp.ktime_get_update_offsets_now
      0.06 ± 13%      +0.0        0.10 ± 15%  perf-profile.children.cycles-pp.update_load_avg
      0.16 ±  8%      +0.0        0.21 ± 17%  perf-profile.children.cycles-pp.ktime_get
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.copy_page
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.copy_string_kernel
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.time
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.__x64_sys_rt_sigreturn
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.perf_iterate_sb
      0.00            +0.1        0.05        perf-profile.children.cycles-pp._raw_spin_trylock
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.irqtime_account_irq
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.unlock_page
      0.00            +0.1        0.05 ±  8%  perf-profile.children.cycles-pp.common_file_perm
      0.00            +0.1        0.05 ±  8%  perf-profile.children.cycles-pp.shift_arg_pages
      0.00            +0.1        0.05 ±  8%  perf-profile.children.cycles-pp.__list_del_entry_valid
      0.00            +0.1        0.05 ±  8%  perf-profile.children.cycles-pp.__check_object_size
      0.00            +0.1        0.05 ±  8%  perf-profile.children.cycles-pp.compar1
      0.00            +0.1        0.05 ±  8%  perf-profile.children.cycles-pp.lru_add_drain_cpu
      0.00            +0.1        0.05 ±  8%  perf-profile.children.cycles-pp.do_faccessat
      0.00            +0.1        0.05 ±  8%  perf-profile.children.cycles-pp.call_rcu
      0.00            +0.1        0.05 ±  8%  perf-profile.children.cycles-pp.rebalance_domains
      0.00            +0.1        0.05 ±  9%  perf-profile.children.cycles-pp.__pud_alloc
      0.00            +0.1        0.05 ±  9%  perf-profile.children.cycles-pp.do_task_dead
      0.00            +0.1        0.06 ±  9%  perf-profile.children.cycles-pp.new_sync_read
      0.00            +0.1        0.06 ±  9%  perf-profile.children.cycles-pp.ip_finish_output2
      0.00            +0.1        0.06 ±  9%  perf-profile.children.cycles-pp.sync_regs
      0.00            +0.1        0.06 ±  9%  perf-profile.children.cycles-pp.d_add
      0.00            +0.1        0.06 ±  9%  perf-profile.children.cycles-pp.lru_add_drain
      0.00            +0.1        0.06 ±  7%  perf-profile.children.cycles-pp._cond_resched
      0.00            +0.1        0.06 ±  7%  perf-profile.children.cycles-pp.cfree
      0.00            +0.1        0.06 ±  7%  perf-profile.children.cycles-pp.update_rq_clock
      0.00            +0.1        0.06 ±  7%  perf-profile.children.cycles-pp.pagevec_lru_move_fn
      0.00            +0.1        0.06 ±  7%  perf-profile.children.cycles-pp.__rb_insert_augmented
      0.00            +0.1        0.06 ±  7%  perf-profile.children.cycles-pp.kfree
      0.00            +0.1        0.06 ±  7%  perf-profile.children.cycles-pp.security_cred_free
      0.00            +0.1        0.06 ± 14%  perf-profile.children.cycles-pp.worker_thread
      0.00            +0.1        0.06 ± 11%  perf-profile.children.cycles-pp.read
      0.00            +0.1        0.06        perf-profile.children.cycles-pp.anon_vma_interval_tree_insert
      0.00            +0.1        0.06        perf-profile.children.cycles-pp.__might_sleep
      0.00            +0.1        0.06        perf-profile.children.cycles-pp.simple_lookup
      0.00            +0.1        0.06        perf-profile.children.cycles-pp.create_elf_tables
      0.00            +0.1        0.06        perf-profile.children.cycles-pp.setup_arg_pages
      0.02 ±141%      +0.1        0.08 ± 54%  perf-profile.children.cycles-pp.irq_enter_rcu
      0.00            +0.1        0.06 ±  6%  perf-profile.children.cycles-pp.alloc_pages_vma
      0.00            +0.1        0.06 ±  6%  perf-profile.children.cycles-pp.page_add_file_rmap
      0.00            +0.1        0.06 ± 17%  perf-profile.children.cycles-pp.memcpy_erms
      0.00            +0.1        0.07 ± 17%  perf-profile.children.cycles-pp.do_linkat
      0.00            +0.1        0.07 ± 17%  perf-profile.children.cycles-pp.__x64_sys_link
      0.00            +0.1        0.07 ±  7%  perf-profile.children.cycles-pp.inode_permission
      0.00            +0.1        0.07 ±  7%  perf-profile.children.cycles-pp.ip_output
      0.00            +0.1        0.07 ± 23%  perf-profile.children.cycles-pp.tick_nohz_next_event
      0.05 ± 70%      +0.1        0.12 ± 10%  perf-profile.children.cycles-pp.__close
      0.00            +0.1        0.07 ± 12%  perf-profile.children.cycles-pp.try_charge
      0.00            +0.1        0.07 ±  6%  perf-profile.children.cycles-pp.do_truncate
      0.00            +0.1        0.07 ± 12%  perf-profile.children.cycles-pp.udp_sendmsg
      0.00            +0.1        0.07 ± 12%  perf-profile.children.cycles-pp.put_task_stack
      0.00            +0.1        0.07 ± 12%  perf-profile.children.cycles-pp.free_pages_and_swap_cache
      0.02 ±141%      +0.1        0.08 ±  5%  perf-profile.children.cycles-pp.unlink
      0.07 ± 12%      +0.1        0.14 ± 15%  perf-profile.children.cycles-pp.write
      0.06            +0.1        0.13        perf-profile.children.cycles-pp.wake_up_new_task
      0.06 ± 13%      +0.1        0.13 ±  5%  perf-profile.children.cycles-pp.__d_lookup_rcu
      0.00            +0.1        0.07 ± 10%  perf-profile.children.cycles-pp.uncharge_batch
      0.00            +0.1        0.07        perf-profile.children.cycles-pp.group_send_sig_info
      0.00            +0.1        0.07        perf-profile.children.cycles-pp.__get_user_pages
      0.00            +0.1        0.07        perf-profile.children.cycles-pp.strnlen_user
      0.00            +0.1        0.07        perf-profile.children.cycles-pp.security_task_kill
      0.00            +0.1        0.07        perf-profile.children.cycles-pp.apparmor_task_kill
      0.00            +0.1        0.07 ± 10%  perf-profile.children.cycles-pp.__pmd_alloc
      0.05 ±  8%      +0.1        0.12 ±  4%  perf-profile.children.cycles-pp.apparmor_file_open
      0.09 ± 24%      +0.1        0.16 ±  6%  perf-profile.children.cycles-pp.kill
      0.05            +0.1        0.12 ±  3%  perf-profile.children.cycles-pp.security_file_free
      0.05            +0.1        0.12 ±  3%  perf-profile.children.cycles-pp.apparmor_file_free_security
      0.00            +0.1        0.07 ±  5%  perf-profile.children.cycles-pp.__anon_vma_prepare
      0.00            +0.1        0.07 ±  5%  perf-profile.children.cycles-pp.find_vma
      0.00            +0.1        0.07 ±  5%  perf-profile.children.cycles-pp.get_arg_page
      0.00            +0.1        0.07 ±  5%  perf-profile.children.cycles-pp.__get_user_pages_remote
      0.00            +0.1        0.07 ±  5%  perf-profile.children.cycles-pp.mem_cgroup_charge
      0.00            +0.1        0.07 ±  5%  perf-profile.children.cycles-pp.try_to_wake_up
      0.00            +0.1        0.07 ±  5%  perf-profile.children.cycles-pp.rcu_sched_clock_irq
      0.00            +0.1        0.07 ± 22%  perf-profile.children.cycles-pp.file_free_rcu
      0.05 ±  8%      +0.1        0.13 ±  6%  perf-profile.children.cycles-pp.security_file_open
      0.05 ±  8%      +0.1        0.13 ±  3%  perf-profile.children.cycles-pp.getname_flags
      0.03 ± 70%      +0.1        0.11 ±  4%  perf-profile.children.cycles-pp.kill_pid_info
      0.07            +0.1        0.15 ±  3%  perf-profile.children.cycles-pp.native_irq_return_iret
      0.00            +0.1        0.08 ±  6%  perf-profile.children.cycles-pp.vfs_read
      0.00            +0.1        0.08 ±  6%  perf-profile.children.cycles-pp.__mod_memcg_state
      0.00            +0.1        0.08 ±  6%  perf-profile.children.cycles-pp.mem_cgroup_uncharge_list
      0.03 ± 70%      +0.1        0.11        perf-profile.children.cycles-pp.kill_something_info
      0.00            +0.1        0.08 ±  5%  perf-profile.children.cycles-pp.ksys_read
      0.00            +0.1        0.08 ± 10%  perf-profile.children.cycles-pp.rcu_cblist_dequeue
      0.00            +0.1        0.08 ±  8%  perf-profile.children.cycles-pp.vma_interval_tree_remove
      0.04 ± 71%      +0.1        0.12 ±  3%  perf-profile.children.cycles-pp.__x64_sys_kill
      0.00            +0.1        0.08 ± 10%  perf-profile.children.cycles-pp.filldir64
      0.00            +0.1        0.08 ± 10%  perf-profile.children.cycles-pp.put_cred_rcu
      0.00            +0.1        0.08 ± 26%  perf-profile.children.cycles-pp.tick_nohz_get_sleep_length
      0.00            +0.1        0.08 ± 13%  perf-profile.children.cycles-pp.__slab_free
      0.02 ±141%      +0.1        0.10        perf-profile.children.cycles-pp.up_write
      0.05 ±  8%      +0.1        0.14 ±  3%  perf-profile.children.cycles-pp.copy_pte_range
      0.00            +0.1        0.08 ±  5%  perf-profile.children.cycles-pp.clear_page_erms
      0.06 ±  8%      +0.1        0.14 ±  5%  perf-profile.children.cycles-pp.down_write
      0.02 ±141%      +0.1        0.10 ± 10%  perf-profile.children.cycles-pp.malloc
      0.00            +0.1        0.09 ±  4%  perf-profile.children.cycles-pp.wait4
      0.00            +0.1        0.09 ±  4%  perf-profile.children.cycles-pp.down_read
      0.00            +0.1        0.09 ±  4%  perf-profile.children.cycles-pp.__get_free_pages
      0.00            +0.1        0.09 ±  4%  perf-profile.children.cycles-pp.__put_anon_vma
      0.00            +0.1        0.09 ±  4%  perf-profile.children.cycles-pp.arch_do_signal
      0.00            +0.1        0.09 ±  4%  perf-profile.children.cycles-pp.__dentry_kill
      0.02 ±141%      +0.1        0.11 ±  4%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      0.00            +0.1        0.09        perf-profile.children.cycles-pp.strncpy_from_user
      0.00            +0.1        0.09 ±  7%  perf-profile.children.cycles-pp.aa_get_task_label
      0.00            +0.1        0.09 ±  7%  perf-profile.children.cycles-pp.schedule_idle
      0.00            +0.1        0.09 ± 17%  perf-profile.children.cycles-pp.rwsem_wake
      0.02 ±141%      +0.1        0.11 ±  4%  perf-profile.children.cycles-pp.___might_sleep
      0.03 ± 70%      +0.1        0.12 ±  4%  perf-profile.children.cycles-pp.copy_strings
      0.09 ± 13%      +0.1        0.19 ± 14%  perf-profile.children.cycles-pp.update_cfs_group
      0.08 ± 10%      +0.1        0.17 ± 11%  perf-profile.children.cycles-pp.new_sync_write
      0.00            +0.1        0.09 ±  4%  perf-profile.children.cycles-pp.sched_exec
      0.02 ±141%      +0.1        0.11        perf-profile.children.cycles-pp.alloc_set_pte
      0.05 ±  8%      +0.1        0.15 ±  2%  perf-profile.children.cycles-pp.get_page_from_freelist
      0.00            +0.1        0.10 ±  5%  perf-profile.children.cycles-pp.prep_new_page
      0.00            +0.1        0.10 ±  9%  perf-profile.children.cycles-pp.__pte_alloc
      0.04 ± 71%      +0.1        0.13 ±  6%  perf-profile.children.cycles-pp.__mmap
      0.00            +0.1        0.10 ±  8%  perf-profile.children.cycles-pp.sock_sendmsg
      0.00            +0.1        0.10 ±  4%  perf-profile.children.cycles-pp.perf_event_mmap
      0.00            +0.1        0.10 ±  8%  perf-profile.children.cycles-pp.__memcg_kmem_uncharge_page
      0.00            +0.1        0.10 ± 45%  perf-profile.children.cycles-pp.dcache_dir_close
      0.00            +0.1        0.10 ±  7%  perf-profile.children.cycles-pp.sock_write_iter
      0.00            +0.1        0.10 ±  7%  perf-profile.children.cycles-pp.lockref_put_return
      0.09 ± 10%      +0.1        0.19 ±  9%  perf-profile.children.cycles-pp.ksys_write
      0.02 ±141%      +0.1        0.12 ±  3%  perf-profile.children.cycles-pp.apparmor_task_getsecid
      0.08 ±  5%      +0.1        0.19 ±  9%  perf-profile.children.cycles-pp.vfs_write
      0.00            +0.1        0.11 ± 10%  perf-profile.children.cycles-pp.do_unlinkat
      0.08 ± 10%      +0.1        0.19 ±  2%  perf-profile.children.cycles-pp.find_idlest_group
      0.00            +0.1        0.11 ± 33%  perf-profile.children.cycles-pp.__close_nocancel
      0.00            +0.1        0.11 ±  4%  perf-profile.children.cycles-pp.vm_area_alloc
      0.06 ± 16%      +0.1        0.16 ±  5%  perf-profile.children.cycles-pp.do_anonymous_page
      0.02 ±141%      +0.1        0.12 ±  4%  perf-profile.children.cycles-pp.security_task_getsecid
      0.08 ± 14%      +0.1        0.19 ±  6%  perf-profile.children.cycles-pp.__xstat64
      0.00            +0.1        0.11        perf-profile.children.cycles-pp.__mod_memcg_lruvec_state
      0.06 ± 16%      +0.1        0.17 ±  4%  perf-profile.children.cycles-pp.obj_cgroup_charge
      0.07            +0.1        0.18 ±  5%  perf-profile.children.cycles-pp.apparmor_file_alloc_security
      0.00            +0.1        0.11 ±  3%  perf-profile.children.cycles-pp.__clear_user
      0.20 ± 12%      +0.1        0.31 ± 15%  perf-profile.children.cycles-pp.task_tick_fair
      0.02 ±141%      +0.1        0.13 ±  5%  perf-profile.children.cycles-pp.find_busiest_group
      0.02 ±141%      +0.1        0.13 ±  5%  perf-profile.children.cycles-pp.update_sd_lb_stats
      0.00            +0.1        0.11 ±  4%  perf-profile.children.cycles-pp.ima_file_check
      0.08 ± 10%      +0.1        0.20 ±  4%  perf-profile.children.cycles-pp.vma_interval_tree_insert
      0.07 ± 14%      +0.1        0.18 ±  4%  perf-profile.children.cycles-pp.page_remove_rmap
      0.02 ±141%      +0.1        0.14 ±  3%  perf-profile.children.cycles-pp.wp_page_copy
      0.02 ±141%      +0.1        0.14 ±  6%  perf-profile.children.cycles-pp.pte_alloc_one
      0.03 ± 70%      +0.1        0.15 ±  2%  perf-profile.children.cycles-pp.schedule
      0.07 ± 11%      +0.1        0.19        perf-profile.children.cycles-pp._dl_addr
      0.00            +0.1        0.12 ±  8%  perf-profile.children.cycles-pp.finish_task_switch
      0.00            +0.1        0.12 ± 13%  perf-profile.children.cycles-pp.__put_task_struct
      0.08            +0.1        0.20 ±  5%  perf-profile.children.cycles-pp.security_file_alloc
      0.09 ±  9%      +0.1        0.21 ±  2%  perf-profile.children.cycles-pp.select_task_rq_fair
      0.04 ± 71%      +0.1        0.16 ±  5%  perf-profile.children.cycles-pp.load_balance
      0.05 ±  8%      +0.1        0.18 ±  4%  perf-profile.children.cycles-pp.vm_area_dup
      0.04 ± 71%      +0.1        0.17 ±  2%  perf-profile.children.cycles-pp.__d_alloc
      0.02 ±141%      +0.1        0.15 ±  7%  perf-profile.children.cycles-pp.do_wait
      0.02 ±141%      +0.1        0.15 ±  5%  perf-profile.children.cycles-pp.pick_next_task_fair
      0.06 ± 16%      +0.1        0.19 ±  3%  perf-profile.children.cycles-pp.anon_vma_clone
      0.02 ±141%      +0.1        0.15 ±  8%  perf-profile.children.cycles-pp.__do_sys_wait4
      0.02 ±141%      +0.1        0.15 ±  8%  perf-profile.children.cycles-pp.kernel_wait4
      0.05 ±  8%      +0.1        0.19 ±  2%  perf-profile.children.cycles-pp.__vm_munmap
      0.28 ± 13%      +0.1        0.42 ± 12%  perf-profile.children.cycles-pp.scheduler_tick
      0.00            +0.1        0.14 ±  3%  perf-profile.children.cycles-pp.cna_order_queue
      0.08 ± 12%      +0.1        0.22 ±  5%  perf-profile.children.cycles-pp.copy_page_range
      0.06 ± 19%      +0.1        0.21 ±  7%  perf-profile.children.cycles-pp.__memcg_kmem_charge_page
      0.00            +0.1        0.15 ±  5%  perf-profile.children.cycles-pp.newidle_balance
      0.05 ±  8%      +0.2        0.21 ± 19%  perf-profile.children.cycles-pp.__lock_parent
      0.08 ± 14%      +0.2        0.26 ±  4%  perf-profile.children.cycles-pp.rwsem_spin_on_owner
      0.09 ± 15%      +0.2        0.28 ±  4%  perf-profile.children.cycles-pp.release_pages
      0.09 ± 19%      +0.2        0.28 ±  5%  perf-profile.children.cycles-pp.page_counter_try_charge
      0.21 ± 21%      +0.2        0.41 ± 10%  perf-profile.children.cycles-pp.div_int
      0.39 ± 14%      +0.2        0.58 ± 10%  perf-profile.children.cycles-pp.update_process_times
      0.39 ± 14%      +0.2        0.59 ± 10%  perf-profile.children.cycles-pp.tick_sched_handle
      0.09 ± 20%      +0.2        0.29 ±  3%  perf-profile.children.cycles-pp.__memcg_kmem_charge
      0.08 ± 17%      +0.2        0.28 ±  3%  perf-profile.children.cycles-pp.anon_vma_fork
      0.16 ± 12%      +0.2        0.36 ± 10%  perf-profile.children.cycles-pp.mem_rtns_1
      0.25 ± 20%      +0.2        0.46 ± 10%  perf-profile.children.cycles-pp.div_short
      0.07 ± 25%      +0.2        0.28 ±  4%  perf-profile.children.cycles-pp.remove_vma
      0.43 ± 14%      +0.2        0.64 ± 10%  perf-profile.children.cycles-pp.tick_sched_timer
      0.14 ±  3%      +0.2        0.36 ±  5%  perf-profile.children.cycles-pp.setlocale
      0.09 ±  9%      +0.2        0.31        perf-profile.children.cycles-pp.__schedule
      0.11 ± 12%      +0.2        0.33 ±  4%  perf-profile.children.cycles-pp.tlb_flush_mmu
      0.11 ± 16%      +0.2        0.34 ±  5%  perf-profile.children.cycles-pp.tlb_finish_mmu
      0.10 ±  4%      +0.2        0.33 ± 11%  perf-profile.children.cycles-pp.__fput
      0.11 ± 11%      +0.2        0.35 ±  4%  perf-profile.children.cycles-pp.__alloc_pages_nodemask
      0.52 ± 14%      +0.2        0.76 ± 12%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      0.22 ± 19%      +0.2        0.46 ± 11%  perf-profile.children.cycles-pp.add_short
      0.13 ± 10%      +0.3        0.38 ±  5%  perf-profile.children.cycles-pp.lookup_fast
      0.09 ± 15%      +0.3        0.35        perf-profile.children.cycles-pp.unlink_anon_vmas
      0.09 ± 19%      +0.3        0.34 ±  4%  perf-profile.children.cycles-pp.get_obj_cgroup_from_current
      0.12 ±  3%      +0.3        0.38 ± 10%  perf-profile.children.cycles-pp.task_work_run
      0.09 ± 20%      +0.3        0.35        perf-profile.children.cycles-pp.iterate_supers
      0.09 ± 20%      +0.3        0.36 ±  2%  perf-profile.children.cycles-pp.__x64_sys_sync
      0.09 ± 20%      +0.3        0.36 ±  2%  perf-profile.children.cycles-pp.ksys_sync
      0.12 ± 11%      +0.3        0.39 ±  2%  perf-profile.children.cycles-pp.d_alloc
      0.09 ± 20%      +0.3        0.36 ±  2%  perf-profile.children.cycles-pp.sync
      0.75 ± 12%      +0.3        1.03 ± 11%  perf-profile.children.cycles-pp.hrtimer_interrupt
      0.75 ± 12%      +0.3        1.04 ± 12%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      0.15 ±  3%      +0.3        0.45 ±  8%  perf-profile.children.cycles-pp.exit_to_user_mode_prepare
      0.09 ± 20%      +0.3        0.39 ±  3%  perf-profile.children.cycles-pp.load_elf_interp
      0.19 ± 12%      +0.3        0.49 ±  3%  perf-profile.children.cycles-pp.zap_pte_range
      0.20 ± 11%      +0.3        0.51 ±  3%  perf-profile.children.cycles-pp.unmap_page_range
      0.52 ± 19%      +0.3        0.84 ±  3%  perf-profile.children.cycles-pp.creat64
      0.21 ±  8%      +0.3        0.54 ±  3%  perf-profile.children.cycles-pp.unmap_vmas
      0.09 ± 24%      +0.3        0.42 ± 11%  perf-profile.children.cycles-pp.propagate_protected_usage
      0.28 ± 14%      +0.3        0.62 ± 10%  perf-profile.children.cycles-pp.__strcat_chk
      0.25 ±  7%      +0.3        0.59 ±  4%  perf-profile.children.cycles-pp.path_lookupat
      0.25 ±  8%      +0.4        0.60 ±  4%  perf-profile.children.cycles-pp.filename_lookup
      0.26 ±  8%      +0.4        0.62 ±  4%  perf-profile.children.cycles-pp.__do_sys_newstat
      0.19 ± 11%      +0.4        0.56 ±  4%  perf-profile.children.cycles-pp.__alloc_file
      0.19 ±  9%      +0.4        0.56 ±  3%  perf-profile.children.cycles-pp.alloc_empty_file
      0.26 ±  8%      +0.4        0.63 ±  4%  perf-profile.children.cycles-pp.vfs_statx
      0.12 ± 15%      +0.4        0.49 ±  2%  perf-profile.children.cycles-pp.elf_map
      0.22 ± 11%      +0.4        0.60 ±  2%  perf-profile.children.cycles-pp.d_alloc_parallel
      0.29 ±  8%      +0.4        0.68 ±  3%  perf-profile.children.cycles-pp.filemap_map_pages
      0.24 ±  9%      +0.4        0.63 ±  2%  perf-profile.children.cycles-pp.__lookup_slow
      0.30 ± 32%      +0.4        0.73 ± 41%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      0.49 ± 20%      +0.4        0.93 ± 10%  perf-profile.children.cycles-pp.div_long
      0.32 ± 10%      +0.5        0.78 ±  3%  perf-profile.children.cycles-pp.do_fault
      0.52 ± 17%      +0.5        1.04 ±  9%  perf-profile.children.cycles-pp.add_int
      0.51 ± 18%      +0.5        1.04 ±  8%  perf-profile.children.cycles-pp.add_long
      0.50 ± 14%      +0.6        1.12 ± 11%  perf-profile.children.cycles-pp.__strncat_chk
      0.12 ± 14%      +0.6        0.74 ± 10%  perf-profile.children.cycles-pp.terminate_walk
      0.39 ± 19%      +0.6        1.02 ± 18%  perf-profile.children.cycles-pp.mprotect_fixup
      0.39 ± 18%      +0.6        1.03 ± 18%  perf-profile.children.cycles-pp.__x64_sys_mprotect
      0.39 ± 18%      +0.6        1.03 ± 18%  perf-profile.children.cycles-pp.do_mprotect_pkey
      0.21 ± 23%      +0.7        0.90 ± 13%  perf-profile.children.cycles-pp.__memcg_kmem_uncharge
      0.46 ± 21%      +0.7        1.20 ± 21%  perf-profile.children.cycles-pp.unmap_region
      0.30 ± 17%      +0.7        1.04 ±  3%  perf-profile.children.cycles-pp.kmem_cache_alloc
      0.48 ±  9%      +0.8        1.23 ±  3%  perf-profile.children.cycles-pp.__handle_mm_fault
      0.50 ± 10%      +0.8        1.30 ±  3%  perf-profile.children.cycles-pp.handle_mm_fault
      0.53 ±  9%      +0.8        1.37 ±  3%  perf-profile.children.cycles-pp.do_user_addr_fault
      0.47 ±  9%      +0.8        1.30 ±  2%  perf-profile.children.cycles-pp.link_path_walk
      0.54 ±  8%      +0.8        1.38 ±  3%  perf-profile.children.cycles-pp.exc_page_fault
      0.48 ±  9%      +0.9        1.33 ±  3%  perf-profile.children.cycles-pp.walk_component
      0.49 ± 18%      +0.9        1.34 ± 13%  perf-profile.children.cycles-pp.__libc_fork
      0.50 ± 20%      +0.9        1.41 ± 16%  perf-profile.children.cycles-pp.vma_link
      0.59 ±  4%      +0.9        1.51 ±  4%  perf-profile.children.cycles-pp.asm_exc_page_fault
      0.34 ± 22%      +1.1        1.43 ± 12%  perf-profile.children.cycles-pp.page_counter_cancel
      0.72 ± 19%      +1.2        1.88 ± 19%  perf-profile.children.cycles-pp.__vma_adjust
      0.36 ± 22%      +1.2        1.54 ± 12%  perf-profile.children.cycles-pp.page_counter_uncharge
      0.74 ± 19%      +1.2        1.94 ± 19%  perf-profile.children.cycles-pp.__split_vma
      0.37 ± 21%      +1.2        1.59 ±  5%  perf-profile.children.cycles-pp.irq_exit_rcu
      0.36 ± 22%      +1.2        1.59 ±  5%  perf-profile.children.cycles-pp.do_softirq_own_stack
      0.00            +1.2        1.23 ± 19%  perf-profile.children.cycles-pp.dcache_dir_open
      0.00            +1.2        1.23 ± 19%  perf-profile.children.cycles-pp.d_alloc_cursor
      0.69 ± 15%      +1.3        1.96 ± 14%  perf-profile.children.cycles-pp.begin_new_exec
      0.85 ± 20%      +1.4        2.21 ± 20%  perf-profile.children.cycles-pp.__do_munmap
      0.81 ± 16%      +1.4        2.22 ± 13%  perf-profile.children.cycles-pp.__x64_sys_exit_group
      0.81 ± 16%      +1.4        2.22 ± 13%  perf-profile.children.cycles-pp.do_group_exit
      0.81 ± 16%      +1.4        2.22 ± 13%  perf-profile.children.cycles-pp.do_exit
      1.09 ± 16%      +1.4        2.50 ±  8%  perf-profile.children.cycles-pp.asm_call_sysvec_on_stack
      0.84 ± 20%      +1.4        2.29 ± 15%  perf-profile.children.cycles-pp.dup_mmap
      0.39 ± 20%      +1.5        1.84 ± 12%  perf-profile.children.cycles-pp.drain_obj_stock
      0.85 ± 20%      +1.5        2.32 ± 15%  perf-profile.children.cycles-pp.dup_mm
      1.18 ± 15%      +1.6        2.74 ±  8%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      0.94 ± 18%      +1.6        2.58 ± 13%  perf-profile.children.cycles-pp.copy_process
      1.29 ± 11%      +1.6        2.94 ±  7%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
      1.00 ± 18%      +1.7        2.72 ± 13%  perf-profile.children.cycles-pp.__do_sys_clone
      1.00 ± 18%      +1.7        2.72 ± 13%  perf-profile.children.cycles-pp.kernel_clone
      0.47 ± 18%      +1.8        2.25 ± 12%  perf-profile.children.cycles-pp.refill_obj_stock
      0.92 ± 14%      +1.9        2.78 ± 10%  perf-profile.children.cycles-pp.load_elf_binary
      0.93 ± 14%      +1.9        2.79 ± 10%  perf-profile.children.cycles-pp.exec_binprm
      1.68 ± 14%      +2.1        3.74 ± 10%  perf-profile.children.cycles-pp.string_rtns_1
      1.30 ± 20%      +2.1        3.37 ± 20%  perf-profile.children.cycles-pp.ksys_mmap_pgoff
      1.35 ± 19%      +2.2        3.51 ± 24%  perf-profile.children.cycles-pp.unlink_file_vma
      1.36 ± 20%      +2.3        3.63 ± 18%  perf-profile.children.cycles-pp.mmap_region
      1.37 ± 20%      +2.3        3.67 ± 18%  perf-profile.children.cycles-pp.do_mmap
      1.39 ± 20%      +2.3        3.72 ± 18%  perf-profile.children.cycles-pp.vm_mmap_pgoff
      1.46 ± 19%      +2.5        3.92 ± 21%  perf-profile.children.cycles-pp.free_pgtables
      1.40 ± 16%      +2.5        3.88 ± 14%  perf-profile.children.cycles-pp.exit_mmap
      1.40 ± 16%      +2.5        3.89 ± 14%  perf-profile.children.cycles-pp.mmput
      0.00            +2.7        2.65 ±  9%  perf-profile.children.cycles-pp.lockref_get
      0.08 ±  5%      +2.7        2.80 ±  8%  perf-profile.children.cycles-pp.do_dentry_open
      0.61 ± 11%      +3.2        3.79 ± 15%  perf-profile.children.cycles-pp.run_ksoftirqd
      0.61 ± 12%      +3.2        3.82 ± 15%  perf-profile.children.cycles-pp.smpboot_thread_fn
      0.65 ± 11%      +3.2        3.88 ± 15%  perf-profile.children.cycles-pp.kthread
      0.66 ± 11%      +3.3        3.92 ± 15%  perf-profile.children.cycles-pp.ret_from_fork
      0.91 ± 14%      +4.3        5.25 ± 12%  perf-profile.children.cycles-pp.rcu_do_batch
      0.92 ± 13%      +4.3        5.25 ± 12%  perf-profile.children.cycles-pp.rcu_core
      0.97 ± 13%      +4.4        5.38 ± 12%  perf-profile.children.cycles-pp.__softirqentry_text_start
      0.99 ± 14%      +4.5        5.52 ± 10%  perf-profile.children.cycles-pp.kmem_cache_free
      3.02 ± 19%      +4.7        7.76 ± 23%  perf-profile.children.cycles-pp.osq_lock
      3.15 ± 19%      +5.0        8.16 ± 22%  perf-profile.children.cycles-pp.rwsem_down_write_slowpath
      3.33 ± 10%      +6.1        9.38 ± 10%  perf-profile.children.cycles-pp.intel_idle
      0.00            +6.4        6.37 ±  2%  perf-profile.children.cycles-pp.complete_walk
      0.13 ±  3%      +7.1        7.19 ± 18%  perf-profile.children.cycles-pp.__open64_nocancel
      3.89 ±  9%      +7.1       10.99 ±  8%  perf-profile.children.cycles-pp.cpuidle_enter_state
      3.89 ±  9%      +7.1       11.00 ±  8%  perf-profile.children.cycles-pp.cpuidle_enter
      0.28 ±  3%      +7.2        7.48 ±  6%  perf-profile.children.cycles-pp.lockref_put_or_lock
      4.17 ±  6%      +7.4       11.59 ±  8%  perf-profile.children.cycles-pp.start_secondary
      4.20 ±  6%      +7.4       11.63 ±  8%  perf-profile.children.cycles-pp.secondary_startup_64_no_verify
      4.20 ±  6%      +7.4       11.63 ±  8%  perf-profile.children.cycles-pp.cpu_startup_entry
      4.20 ±  6%      +7.4       11.63 ±  8%  perf-profile.children.cycles-pp.do_idle
      0.54 ±  4%      +7.5        8.04 ±  6%  perf-profile.children.cycles-pp.dput
      1.12 ±  2%     +11.1       12.26 ±  2%  perf-profile.children.cycles-pp.do_sys_open
      1.12 ±  2%     +11.1       12.25 ±  2%  perf-profile.children.cycles-pp.do_sys_openat2
      0.06 ± 14%     +24.2       24.28 ±  4%  perf-profile.children.cycles-pp.pick_link
      1.03 ±  4%     +24.4       25.43 ±  8%  perf-profile.children.cycles-pp.execve
      0.17 ± 10%     +30.8       30.92 ±  3%  perf-profile.children.cycles-pp.lockref_get_not_dead
      0.10 ±  8%     +30.8       30.87 ±  3%  perf-profile.children.cycles-pp.do_open_execat
      0.18 ±  9%     +30.8       30.95 ±  3%  perf-profile.children.cycles-pp.__legitimize_path
      0.18 ± 12%     +30.8       30.96 ±  3%  perf-profile.children.cycles-pp.unlazy_walk
      0.20 ± 10%     +31.0       31.15 ±  3%  perf-profile.children.cycles-pp.step_into
      1.05 ± 14%     +32.7       33.76 ±  3%  perf-profile.children.cycles-pp.bprm_execve
      1.14 ± 13%     +32.9       33.99 ±  3%  perf-profile.children.cycles-pp.do_execveat_common
      1.15 ± 13%     +32.9       34.01 ±  3%  perf-profile.children.cycles-pp.__x64_sys_execve
      1.16 ±  3%     +41.8       42.98 ±  2%  perf-profile.children.cycles-pp.path_openat
      1.17 ±  3%     +41.8       42.98 ±  2%  perf-profile.children.cycles-pp.do_filp_open
      0.00           +54.2       54.20 ±  2%  perf-profile.children.cycles-pp.__cna_queued_spin_lock_slowpath
     81.68           -81.7        0.00        perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
      0.05 ±  8%      +0.0        0.08 ± 21%  perf-profile.self.cycles-pp.ktime_get_update_offsets_now
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.link_path_walk
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.apparmor_task_getsecid
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.page_add_file_rmap
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.common_file_perm
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.__list_del_entry_valid
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.copy_page
      0.00            +0.1        0.05        perf-profile.self.cycles-pp._raw_spin_trylock
      0.00            +0.1        0.05 ±  8%  perf-profile.self.cycles-pp.__rb_insert_augmented
      0.00            +0.1        0.05 ±  8%  perf-profile.self.cycles-pp.compar1
      0.00            +0.1        0.06 ±  9%  perf-profile.self.cycles-pp.__might_sleep
      0.00            +0.1        0.06 ±  9%  perf-profile.self.cycles-pp.sync_regs
      0.00            +0.1        0.06 ± 14%  perf-profile.self.cycles-pp.__alloc_file
      0.00            +0.1        0.06 ±  7%  perf-profile.self.cycles-pp.kfree
      0.00            +0.1        0.06        perf-profile.self.cycles-pp.strnlen_user
      0.00            +0.1        0.06        perf-profile.self.cycles-pp.anon_vma_interval_tree_insert
      0.00            +0.1        0.06 ± 11%  perf-profile.self.cycles-pp.memcpy_erms
      0.00            +0.1        0.06 ±  6%  perf-profile.self.cycles-pp.free_pages_and_swap_cache
      0.00            +0.1        0.07 ±  7%  perf-profile.self.cycles-pp.filldir64
      0.00            +0.1        0.07 ±  7%  perf-profile.self.cycles-pp.rcu_sched_clock_irq
      0.06 ± 16%      +0.1        0.12 ±  3%  perf-profile.self.cycles-pp.__d_lookup_rcu
      0.00            +0.1        0.07 ±  6%  perf-profile.self.cycles-pp.copy_pte_range
      0.00            +0.1        0.07 ±  6%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.00            +0.1        0.07 ± 19%  perf-profile.self.cycles-pp.file_free_rcu
      0.00            +0.1        0.07 ± 10%  perf-profile.self.cycles-pp.rwsem_down_write_slowpath
      0.05 ±  8%      +0.1        0.12 ±  4%  perf-profile.self.cycles-pp.apparmor_file_open
      0.05            +0.1        0.12 ±  3%  perf-profile.self.cycles-pp.apparmor_file_free_security
      0.00            +0.1        0.07 ±  5%  perf-profile.self.cycles-pp.vma_interval_tree_remove
      0.07            +0.1        0.15 ±  3%  perf-profile.self.cycles-pp.native_irq_return_iret
      0.00            +0.1        0.08 ±  6%  perf-profile.self.cycles-pp.__mod_memcg_state
      0.00            +0.1        0.08 ± 11%  perf-profile.self.cycles-pp.rcu_cblist_dequeue
      0.00            +0.1        0.08 ± 14%  perf-profile.self.cycles-pp.__handle_mm_fault
      0.00            +0.1        0.08 ±  5%  perf-profile.self.cycles-pp.down_read
      0.02 ±141%      +0.1        0.10 ±  5%  perf-profile.self.cycles-pp.up_write
      0.00            +0.1        0.08 ± 13%  perf-profile.self.cycles-pp.__slab_free
      0.06 ±  8%      +0.1        0.14 ±  8%  perf-profile.self.cycles-pp.lockref_get_not_dead
      0.00            +0.1        0.08 ±  5%  perf-profile.self.cycles-pp.clear_page_erms
      0.03 ± 70%      +0.1        0.12 ±  6%  perf-profile.self.cycles-pp.down_write
      0.00            +0.1        0.09 ±  7%  perf-profile.self.cycles-pp.malloc
      0.00            +0.1        0.09 ±  7%  perf-profile.self.cycles-pp.aa_get_task_label
      0.02 ±141%      +0.1        0.11 ±  4%  perf-profile.self.cycles-pp.___might_sleep
      0.09 ± 13%      +0.1        0.19 ± 14%  perf-profile.self.cycles-pp.update_cfs_group
      0.06 ± 13%      +0.1        0.15 ±  5%  perf-profile.self.cycles-pp.page_remove_rmap
      0.07 ± 11%      +0.1        0.17 ±  2%  perf-profile.self.cycles-pp.find_idlest_group
      0.00            +0.1        0.10 ±  4%  perf-profile.self.cycles-pp.lockref_put_return
      0.07 ±  7%      +0.1        0.17 ±  6%  perf-profile.self.cycles-pp.apparmor_file_alloc_security
      0.00            +0.1        0.11 ±  7%  perf-profile.self.cycles-pp.update_sd_lb_stats
      0.08 ± 10%      +0.1        0.19 ±  3%  perf-profile.self.cycles-pp.vma_interval_tree_insert
      0.04 ± 71%      +0.1        0.15 ±  5%  perf-profile.self.cycles-pp.release_pages
      0.00            +0.1        0.12 ± 13%  perf-profile.self.cycles-pp.page_counter_uncharge
      0.07 ± 11%      +0.1        0.19 ±  2%  perf-profile.self.cycles-pp._dl_addr
      0.00            +0.1        0.13 ±  3%  perf-profile.self.cycles-pp.cna_order_queue
      0.10 ±  8%      +0.1        0.25 ±  2%  perf-profile.self.cycles-pp.zap_pte_range
      0.08 ± 22%      +0.2        0.23 ±  4%  perf-profile.self.cycles-pp.page_counter_try_charge
      0.08 ± 14%      +0.2        0.25 ±  2%  perf-profile.self.cycles-pp.rwsem_spin_on_owner
      0.21 ± 20%      +0.2        0.40 ± 11%  perf-profile.self.cycles-pp.div_int
      0.15 ±  9%      +0.2        0.35 ± 11%  perf-profile.self.cycles-pp.mem_rtns_1
      0.25 ± 22%      +0.2        0.45 ± 11%  perf-profile.self.cycles-pp.div_short
      0.22 ± 19%      +0.2        0.45 ± 10%  perf-profile.self.cycles-pp.add_short
      0.08 ± 27%      +0.2        0.32 ±  4%  perf-profile.self.cycles-pp.get_obj_cgroup_from_current
      0.42 ±  2%      +0.3        0.69 ±  2%  perf-profile.self.cycles-pp._raw_spin_lock
      0.22 ±  9%      +0.3        0.49 ±  2%  perf-profile.self.cycles-pp.filemap_map_pages
      0.11 ± 19%      +0.3        0.41 ±  3%  perf-profile.self.cycles-pp.kmem_cache_alloc
      0.07 ±  6%      +0.3        0.40 ± 10%  perf-profile.self.cycles-pp.refill_obj_stock
      0.28 ± 14%      +0.3        0.60 ± 11%  perf-profile.self.cycles-pp.__strcat_chk
      0.09 ± 24%      +0.3        0.42 ± 11%  perf-profile.self.cycles-pp.propagate_protected_usage
      0.07 ± 11%      +0.4        0.46 ± 10%  perf-profile.self.cycles-pp.drain_obj_stock
      0.49 ± 19%      +0.4        0.92 ± 10%  perf-profile.self.cycles-pp.div_long
      0.51 ± 17%      +0.5        1.01 ±  8%  perf-profile.self.cycles-pp.add_long
      0.51 ± 17%      +0.5        1.02 ±  9%  perf-profile.self.cycles-pp.add_int
      0.49 ± 14%      +0.6        1.10 ± 11%  perf-profile.self.cycles-pp.__strncat_chk
      0.26 ± 21%      +0.8        1.04 ± 12%  perf-profile.self.cycles-pp.page_counter_cancel
      1.66 ± 14%      +2.0        3.65 ± 10%  perf-profile.self.cycles-pp.string_rtns_1
      0.49 ± 13%      +2.6        3.11 ±  9%  perf-profile.self.cycles-pp.kmem_cache_free
      2.93 ± 19%      +4.6        7.50 ± 22%  perf-profile.self.cycles-pp.osq_lock
      3.33 ± 10%      +6.0        9.38 ± 10%  perf-profile.self.cycles-pp.intel_idle
      0.00           +53.4       53.38 ±  2%  perf-profile.self.cycles-pp.__cna_queued_spin_lock_slowpath
      1579 ± 53%    +572.8%      10624 ± 82%  interrupts.31:PCI-MSI.524289-edge.eth0-TxRx-0
      1203 ±112%     +61.3%       1940 ± 68%  interrupts.32:PCI-MSI.524290-edge.eth0-TxRx-1
      8340 ± 68%     -76.0%       2003 ± 74%  interrupts.34:PCI-MSI.524292-edge.eth0-TxRx-3
    775419 ±  5%     +21.9%     944875 ±  2%  interrupts.CAL:Function_call_interrupts
      5146 ±  4%     -51.2%       2512 ± 34%  interrupts.CPU0.NMI:Non-maskable_interrupts
      5146 ±  4%     -51.2%       2512 ± 34%  interrupts.CPU0.PMI:Performance_monitoring_interrupts
      1113 ±  8%     +13.1%       1259 ±  4%  interrupts.CPU0.RES:Rescheduling_interrupts
    643.67 ±  4%     +53.6%     988.50 ±  7%  interrupts.CPU0.TLB:TLB_shootdowns
      4043 ±  7%     +33.6%       5400 ±  5%  interrupts.CPU1.CAL:Function_call_interrupts
      5177 ±  3%     -41.7%       3020 ± 36%  interrupts.CPU1.NMI:Non-maskable_interrupts
      5177 ±  3%     -41.7%       3020 ± 36%  interrupts.CPU1.PMI:Performance_monitoring_interrupts
    735.33 ±  5%     +48.3%       1090 ±  8%  interrupts.CPU1.RES:Rescheduling_interrupts
    562.00 ± 12%     +47.5%     829.00 ±  6%  interrupts.CPU1.TLB:TLB_shootdowns
      1579 ± 53%    +572.8%      10624 ± 82%  interrupts.CPU10.31:PCI-MSI.524289-edge.eth0-TxRx-0
      3821 ±  7%     +28.3%       4903 ±  6%  interrupts.CPU10.CAL:Function_call_interrupts
      5187 ±  4%     -23.5%       3968 ±  5%  interrupts.CPU10.NMI:Non-maskable_interrupts
      5187 ±  4%     -23.5%       3968 ±  5%  interrupts.CPU10.PMI:Performance_monitoring_interrupts
    738.67 ±  5%     +48.7%       1098 ±  4%  interrupts.CPU10.RES:Rescheduling_interrupts
    522.00 ± 33%     +72.4%     900.00 ± 10%  interrupts.CPU10.TLB:TLB_shootdowns
      3934 ±  9%     +24.9%       4913 ±  6%  interrupts.CPU100.CAL:Function_call_interrupts
      5204 ±  3%     -24.7%       3916 ±  8%  interrupts.CPU100.NMI:Non-maskable_interrupts
      5204 ±  3%     -24.7%       3916 ±  8%  interrupts.CPU100.PMI:Performance_monitoring_interrupts
    743.67 ±  7%     +61.4%       1200 ±  9%  interrupts.CPU100.RES:Rescheduling_interrupts
    474.00 ± 14%     +91.8%     909.00 ± 12%  interrupts.CPU100.TLB:TLB_shootdowns
      3945 ±  4%     +24.3%       4901 ±  4%  interrupts.CPU101.CAL:Function_call_interrupts
      5197 ±  3%     -36.2%       3313 ± 26%  interrupts.CPU101.NMI:Non-maskable_interrupts
      5197 ±  3%     -36.2%       3313 ± 26%  interrupts.CPU101.PMI:Performance_monitoring_interrupts
    720.33 ±  5%     +60.8%       1158 ±  7%  interrupts.CPU101.RES:Rescheduling_interrupts
    496.67 ±  7%     +82.6%     906.75 ± 15%  interrupts.CPU101.TLB:TLB_shootdowns
      3918 ±  5%     +22.8%       4810 ±  6%  interrupts.CPU102.CAL:Function_call_interrupts
      5186 ±  4%     -25.2%       3879 ± 10%  interrupts.CPU102.NMI:Non-maskable_interrupts
      5186 ±  4%     -25.2%       3879 ± 10%  interrupts.CPU102.PMI:Performance_monitoring_interrupts
    699.33 ±  3%     +61.8%       1131 ±  7%  interrupts.CPU102.RES:Rescheduling_interrupts
    406.33 ±  7%    +108.2%     846.00 ± 12%  interrupts.CPU102.TLB:TLB_shootdowns
      3882 ±  5%     +26.2%       4897 ±  4%  interrupts.CPU103.CAL:Function_call_interrupts
      5224 ±  3%     -34.9%       3399 ± 26%  interrupts.CPU103.NMI:Non-maskable_interrupts
      5224 ±  3%     -34.9%       3399 ± 26%  interrupts.CPU103.PMI:Performance_monitoring_interrupts
    658.33 ±  4%     +73.4%       1141 ±  5%  interrupts.CPU103.RES:Rescheduling_interrupts
    449.00 ± 16%     +89.6%     851.50 ±  8%  interrupts.CPU103.TLB:TLB_shootdowns
      3881 ±  3%     +23.9%       4807 ±  3%  interrupts.CPU104.CAL:Function_call_interrupts
      5212 ±  3%     -26.6%       3826 ±  8%  interrupts.CPU104.NMI:Non-maskable_interrupts
      5212 ±  3%     -26.6%       3826 ±  8%  interrupts.CPU104.PMI:Performance_monitoring_interrupts
    637.67 ±  7%     +73.6%       1106 ±  9%  interrupts.CPU104.RES:Rescheduling_interrupts
    423.33 ±  7%     +90.1%     804.75 ± 14%  interrupts.CPU104.TLB:TLB_shootdowns
      3845           +20.2%       4623        interrupts.CPU105.CAL:Function_call_interrupts
    661.33 ±  8%     +68.5%       1114 ±  2%  interrupts.CPU105.RES:Rescheduling_interrupts
    467.33 ± 17%     +87.6%     876.50 ± 21%  interrupts.CPU105.TLB:TLB_shootdowns
      3959 ±  4%     +18.2%       4679        interrupts.CPU106.CAL:Function_call_interrupts
      5251 ±  3%     -25.6%       3905 ± 10%  interrupts.CPU106.NMI:Non-maskable_interrupts
      5251 ±  3%     -25.6%       3905 ± 10%  interrupts.CPU106.PMI:Performance_monitoring_interrupts
    721.33 ±  5%     +59.2%       1148 ±  8%  interrupts.CPU106.RES:Rescheduling_interrupts
    419.00 ± 15%    +150.8%       1050 ± 30%  interrupts.CPU106.TLB:TLB_shootdowns
      3930 ±  5%     +18.9%       4674 ±  4%  interrupts.CPU107.CAL:Function_call_interrupts
      5177 ±  5%     -34.4%       3398 ± 26%  interrupts.CPU107.NMI:Non-maskable_interrupts
      5177 ±  5%     -34.4%       3398 ± 26%  interrupts.CPU107.PMI:Performance_monitoring_interrupts
    665.33 ±  5%     +75.8%       1169 ±  4%  interrupts.CPU107.RES:Rescheduling_interrupts
    445.00 ± 18%     +83.9%     818.50 ± 13%  interrupts.CPU107.TLB:TLB_shootdowns
      3915 ±  8%     +20.9%       4735 ±  3%  interrupts.CPU108.CAL:Function_call_interrupts
      5255 ±  3%     -36.2%       3350 ± 25%  interrupts.CPU108.NMI:Non-maskable_interrupts
      5255 ±  3%     -36.2%       3350 ± 25%  interrupts.CPU108.PMI:Performance_monitoring_interrupts
    684.33 ±  7%     +67.5%       1146 ±  7%  interrupts.CPU108.RES:Rescheduling_interrupts
    509.00 ± 11%     +66.4%     846.75 ±  6%  interrupts.CPU108.TLB:TLB_shootdowns
      3965 ±  3%     +19.8%       4749 ±  4%  interrupts.CPU109.CAL:Function_call_interrupts
      5207 ±  3%     -42.8%       2976 ± 38%  interrupts.CPU109.NMI:Non-maskable_interrupts
      5207 ±  3%     -42.8%       2976 ± 38%  interrupts.CPU109.PMI:Performance_monitoring_interrupts
    701.00 ±  4%     +55.2%       1087 ±  5%  interrupts.CPU109.RES:Rescheduling_interrupts
    510.33 ± 11%     +71.9%     877.25 ±  6%  interrupts.CPU109.TLB:TLB_shootdowns
      1203 ±112%     +61.3%       1940 ± 68%  interrupts.CPU11.32:PCI-MSI.524290-edge.eth0-TxRx-1
      3794 ±  5%     +31.8%       4999 ±  4%  interrupts.CPU11.CAL:Function_call_interrupts
    734.33 ±  6%     +51.7%       1114 ±  3%  interrupts.CPU11.RES:Rescheduling_interrupts
    458.67 ± 14%    +100.9%     921.50 ± 10%  interrupts.CPU11.TLB:TLB_shootdowns
      3949 ±  5%     +27.3%       5029 ±  4%  interrupts.CPU110.CAL:Function_call_interrupts
      5230 ±  3%     -35.3%       3385 ± 24%  interrupts.CPU110.NMI:Non-maskable_interrupts
      5230 ±  3%     -35.3%       3385 ± 24%  interrupts.CPU110.PMI:Performance_monitoring_interrupts
    670.67 ±  6%     +74.5%       1170 ±  7%  interrupts.CPU110.RES:Rescheduling_interrupts
    442.00 ±  8%     +88.5%     833.00 ± 18%  interrupts.CPU110.TLB:TLB_shootdowns
      3865 ±  4%     +24.2%       4802 ±  4%  interrupts.CPU111.CAL:Function_call_interrupts
      5230 ±  3%     -36.3%       3330 ± 25%  interrupts.CPU111.NMI:Non-maskable_interrupts
      5230 ±  3%     -36.3%       3330 ± 25%  interrupts.CPU111.PMI:Performance_monitoring_interrupts
    634.00 ±  9%     +85.7%       1177 ± 10%  interrupts.CPU111.RES:Rescheduling_interrupts
    441.33 ± 13%     +96.4%     866.75 ± 14%  interrupts.CPU111.TLB:TLB_shootdowns
      3873 ±  5%     +24.7%       4829 ±  2%  interrupts.CPU112.CAL:Function_call_interrupts
      5121 ±  4%     -35.0%       3326 ± 24%  interrupts.CPU112.NMI:Non-maskable_interrupts
      5121 ±  4%     -35.0%       3326 ± 24%  interrupts.CPU112.PMI:Performance_monitoring_interrupts
    669.00 ±  2%     +72.3%       1152 ±  7%  interrupts.CPU112.RES:Rescheduling_interrupts
    430.00 ±  2%    +111.9%     911.00 ± 15%  interrupts.CPU112.TLB:TLB_shootdowns
      3921 ±  6%     +24.6%       4885 ±  3%  interrupts.CPU113.CAL:Function_call_interrupts
    672.33 ±  8%     +70.0%       1142 ±  7%  interrupts.CPU113.RES:Rescheduling_interrupts
    431.33 ±  9%     +98.2%     855.00 ± 11%  interrupts.CPU113.TLB:TLB_shootdowns
      3779 ±  7%     +27.7%       4827 ±  4%  interrupts.CPU114.CAL:Function_call_interrupts
    641.00 ± 13%     +79.3%       1149 ±  4%  interrupts.CPU114.RES:Rescheduling_interrupts
    504.00 ± 10%     +77.2%     893.25 ± 20%  interrupts.CPU114.TLB:TLB_shootdowns
      3904 ±  6%     +20.2%       4693        interrupts.CPU115.CAL:Function_call_interrupts
    651.67 ±  3%     +78.9%       1165 ±  2%  interrupts.CPU115.RES:Rescheduling_interrupts
    501.67 ± 29%     +69.9%     852.50 ±  4%  interrupts.CPU115.TLB:TLB_shootdowns
      3818 ±  3%     +23.2%       4703        interrupts.CPU116.CAL:Function_call_interrupts
    630.67 ±  7%     +81.6%       1145 ±  6%  interrupts.CPU116.RES:Rescheduling_interrupts
    439.67 ± 14%     +98.7%     873.50 ± 15%  interrupts.CPU116.TLB:TLB_shootdowns
      4154 ±  4%     +13.8%       4728        interrupts.CPU117.CAL:Function_call_interrupts
    650.67 ±  8%     +70.7%       1110 ±  6%  interrupts.CPU117.RES:Rescheduling_interrupts
    502.33 ± 12%     +77.0%     889.00 ± 10%  interrupts.CPU117.TLB:TLB_shootdowns
      3947 ±  5%     +21.6%       4798 ±  5%  interrupts.CPU118.CAL:Function_call_interrupts
    659.33           +71.4%       1130 ±  4%  interrupts.CPU118.RES:Rescheduling_interrupts
    464.67 ± 11%     +84.5%     857.25 ±  9%  interrupts.CPU118.TLB:TLB_shootdowns
      4065 ±  4%     +19.6%       4860 ±  5%  interrupts.CPU119.CAL:Function_call_interrupts
    614.00 ±  8%     +82.9%       1123 ±  4%  interrupts.CPU119.RES:Rescheduling_interrupts
    480.33 ±  8%     +74.6%     838.50 ±  8%  interrupts.CPU119.TLB:TLB_shootdowns
      4011 ±  3%     +20.9%       4848 ±  7%  interrupts.CPU12.CAL:Function_call_interrupts
    769.33 ±  2%     +44.1%       1108 ±  8%  interrupts.CPU12.RES:Rescheduling_interrupts
    502.00 ±  4%     +96.4%     986.00 ± 12%  interrupts.CPU12.TLB:TLB_shootdowns
      4091 ±  4%     +22.3%       5003 ±  3%  interrupts.CPU120.CAL:Function_call_interrupts
    717.33 ±  9%     +64.2%       1177 ±  6%  interrupts.CPU120.RES:Rescheduling_interrupts
    459.67 ± 14%    +103.1%     933.50 ± 15%  interrupts.CPU120.TLB:TLB_shootdowns
      3923 ±  4%     +25.2%       4913 ±  3%  interrupts.CPU121.CAL:Function_call_interrupts
    617.33 ±  3%     +89.4%       1169 ±  4%  interrupts.CPU121.RES:Rescheduling_interrupts
    401.67 ± 22%    +195.5%       1186 ± 39%  interrupts.CPU121.TLB:TLB_shootdowns
      3867 ±  4%     +34.9%       5218 ±  4%  interrupts.CPU122.CAL:Function_call_interrupts
    596.67 ±  8%    +100.9%       1198 ±  5%  interrupts.CPU122.RES:Rescheduling_interrupts
    450.00 ± 16%    +109.0%     940.50 ±  6%  interrupts.CPU122.TLB:TLB_shootdowns
      4031 ±  8%     +23.2%       4967 ±  3%  interrupts.CPU123.CAL:Function_call_interrupts
    628.00 ±  4%     +94.1%       1218 ±  7%  interrupts.CPU123.RES:Rescheduling_interrupts
    474.67 ± 13%     +96.1%     931.00 ± 12%  interrupts.CPU123.TLB:TLB_shootdowns
      4232 ±  4%     +20.3%       5090 ±  3%  interrupts.CPU124.CAL:Function_call_interrupts
    639.00           +82.9%       1168 ±  7%  interrupts.CPU124.RES:Rescheduling_interrupts
    463.33 ± 17%    +110.1%     973.25 ± 11%  interrupts.CPU124.TLB:TLB_shootdowns
      3972           +21.5%       4826 ±  3%  interrupts.CPU125.CAL:Function_call_interrupts
    658.67 ±  8%     +78.4%       1175 ±  4%  interrupts.CPU125.RES:Rescheduling_interrupts
    480.00 ± 13%     +96.0%     940.75 ± 23%  interrupts.CPU125.TLB:TLB_shootdowns
      4093 ±  3%     +20.8%       4947 ±  4%  interrupts.CPU126.CAL:Function_call_interrupts
    672.67 ±  5%     +75.9%       1183 ±  2%  interrupts.CPU126.RES:Rescheduling_interrupts
    498.00 ± 10%     +90.0%     946.25 ± 11%  interrupts.CPU126.TLB:TLB_shootdowns
      4111 ±  5%     +20.8%       4965 ±  5%  interrupts.CPU127.CAL:Function_call_interrupts
    613.67 ±  2%     +95.2%       1198 ±  5%  interrupts.CPU127.RES:Rescheduling_interrupts
    451.67 ± 21%    +109.8%     947.50 ± 14%  interrupts.CPU127.TLB:TLB_shootdowns
      4066           +20.3%       4891 ±  3%  interrupts.CPU128.CAL:Function_call_interrupts
      5200 ±  2%     -23.3%       3986 ±  9%  interrupts.CPU128.NMI:Non-maskable_interrupts
      5200 ±  2%     -23.3%       3986 ±  9%  interrupts.CPU128.PMI:Performance_monitoring_interrupts
    663.33 ±  4%     +74.6%       1158 ±  6%  interrupts.CPU128.RES:Rescheduling_interrupts
    472.33 ± 17%    +102.4%     956.00 ±  8%  interrupts.CPU128.TLB:TLB_shootdowns
      4075 ±  8%     +20.3%       4900        interrupts.CPU129.CAL:Function_call_interrupts
    640.33 ±  2%     +73.2%       1108 ±  8%  interrupts.CPU129.RES:Rescheduling_interrupts
    445.33 ± 19%    +113.4%     950.25 ± 11%  interrupts.CPU129.TLB:TLB_shootdowns
      8340 ± 68%     -76.0%       2003 ± 74%  interrupts.CPU13.34:PCI-MSI.524292-edge.eth0-TxRx-3
      4049 ±  7%     +20.6%       4885 ±  2%  interrupts.CPU13.CAL:Function_call_interrupts
      5130 ±  3%     -24.2%       3886 ±  5%  interrupts.CPU13.NMI:Non-maskable_interrupts
      5130 ±  3%     -24.2%       3886 ±  5%  interrupts.CPU13.PMI:Performance_monitoring_interrupts
    724.00 ±  5%     +57.8%       1142 ±  5%  interrupts.CPU13.RES:Rescheduling_interrupts
    532.67 ± 23%     +70.5%     908.25 ± 12%  interrupts.CPU13.TLB:TLB_shootdowns
      3881 ±  6%     +30.0%       5044 ±  4%  interrupts.CPU130.CAL:Function_call_interrupts
    621.33 ± 10%     +89.4%       1176 ±  8%  interrupts.CPU130.RES:Rescheduling_interrupts
    516.33 ± 16%     +92.9%     996.25 ± 15%  interrupts.CPU130.TLB:TLB_shootdowns
      4035 ±  2%     +22.0%       4923 ±  3%  interrupts.CPU131.CAL:Function_call_interrupts
    661.67 ±  7%     +69.5%       1121 ±  4%  interrupts.CPU131.RES:Rescheduling_interrupts
    425.67 ± 11%    +116.8%     922.75 ± 15%  interrupts.CPU131.TLB:TLB_shootdowns
      4345 ±  3%     +13.3%       4924 ±  5%  interrupts.CPU132.CAL:Function_call_interrupts
    694.00           +68.9%       1172 ±  5%  interrupts.CPU132.RES:Rescheduling_interrupts
    476.00 ± 11%     +94.5%     926.00 ± 13%  interrupts.CPU132.TLB:TLB_shootdowns
      4091 ±  7%     +22.7%       5018 ±  4%  interrupts.CPU133.CAL:Function_call_interrupts
    663.67 ±  6%     +68.6%       1119 ±  4%  interrupts.CPU133.RES:Rescheduling_interrupts
    534.33 ±  9%     +78.7%     954.75 ± 13%  interrupts.CPU133.TLB:TLB_shootdowns
      3856 ±  7%     +26.7%       4886 ±  3%  interrupts.CPU134.CAL:Function_call_interrupts
      5199 ±  2%     -34.5%       3406 ± 24%  interrupts.CPU134.NMI:Non-maskable_interrupts
      5199 ±  2%     -34.5%       3406 ± 24%  interrupts.CPU134.PMI:Performance_monitoring_interrupts
    667.00 ± 13%     +74.7%       1165 ±  6%  interrupts.CPU134.RES:Rescheduling_interrupts
    447.33 ±  9%    +116.7%     969.25 ±  3%  interrupts.CPU134.TLB:TLB_shootdowns
      4120 ± 11%     +18.6%       4886 ±  3%  interrupts.CPU135.CAL:Function_call_interrupts
      5233 ±  3%     -24.8%       3934 ±  9%  interrupts.CPU135.NMI:Non-maskable_interrupts
      5233 ±  3%     -24.8%       3934 ±  9%  interrupts.CPU135.PMI:Performance_monitoring_interrupts
    643.67 ±  5%     +81.8%       1170 ±  7%  interrupts.CPU135.RES:Rescheduling_interrupts
    490.00 ± 17%     +88.4%     923.00 ± 18%  interrupts.CPU135.TLB:TLB_shootdowns
      4092 ±  3%     +22.8%       5026 ±  3%  interrupts.CPU136.CAL:Function_call_interrupts
      5225 ±  3%     -34.3%       3430 ± 26%  interrupts.CPU136.NMI:Non-maskable_interrupts
      5225 ±  3%     -34.3%       3430 ± 26%  interrupts.CPU136.PMI:Performance_monitoring_interrupts
    673.33 ±  4%     +80.6%       1216 ±  4%  interrupts.CPU136.RES:Rescheduling_interrupts
    488.00 ±  8%     +87.9%     916.75 ± 13%  interrupts.CPU136.TLB:TLB_shootdowns
      4234 ±  9%     +16.3%       4925 ±  4%  interrupts.CPU137.CAL:Function_call_interrupts
      5217 ±  4%     -34.5%       3418 ± 24%  interrupts.CPU137.NMI:Non-maskable_interrupts
      5217 ±  4%     -34.5%       3418 ± 24%  interrupts.CPU137.PMI:Performance_monitoring_interrupts
    625.33 ± 14%     +87.5%       1172 ±  6%  interrupts.CPU137.RES:Rescheduling_interrupts
    441.67 ± 10%    +115.5%     951.75 ± 13%  interrupts.CPU137.TLB:TLB_shootdowns
      3987 ±  6%     +23.1%       4907 ±  2%  interrupts.CPU138.CAL:Function_call_interrupts
      5218 ±  3%     -42.7%       2992 ± 38%  interrupts.CPU138.NMI:Non-maskable_interrupts
      5218 ±  3%     -42.7%       2992 ± 38%  interrupts.CPU138.PMI:Performance_monitoring_interrupts
    672.33 ±  3%     +76.5%       1186 ±  4%  interrupts.CPU138.RES:Rescheduling_interrupts
    439.67 ±  8%    +113.4%     938.25 ± 11%  interrupts.CPU138.TLB:TLB_shootdowns
      4040 ±  7%     +23.1%       4973 ±  4%  interrupts.CPU139.CAL:Function_call_interrupts
    635.33 ±  3%     +85.3%       1177 ±  7%  interrupts.CPU139.RES:Rescheduling_interrupts
    425.33 ± 17%    +110.7%     896.00 ± 10%  interrupts.CPU139.TLB:TLB_shootdowns
      3920 ±  2%     +21.7%       4771 ±  2%  interrupts.CPU14.CAL:Function_call_interrupts
      5123 ±  4%     -43.3%       2903 ± 30%  interrupts.CPU14.NMI:Non-maskable_interrupts
      5123 ±  4%     -43.3%       2903 ± 30%  interrupts.CPU14.PMI:Performance_monitoring_interrupts
    725.00 ± 12%     +56.2%       1132 ±  6%  interrupts.CPU14.RES:Rescheduling_interrupts
    402.00 ±  6%    +110.0%     844.25 ± 10%  interrupts.CPU14.TLB:TLB_shootdowns
      4006 ± 11%     +19.8%       4800 ±  3%  interrupts.CPU140.CAL:Function_call_interrupts
      5230 ±  3%     -24.8%       3932 ± 10%  interrupts.CPU140.NMI:Non-maskable_interrupts
      5230 ±  3%     -24.8%       3932 ± 10%  interrupts.CPU140.PMI:Performance_monitoring_interrupts
    578.33 ±  3%    +102.5%       1171 ±  5%  interrupts.CPU140.RES:Rescheduling_interrupts
    506.00 ±  5%     +90.3%     963.00 ± 11%  interrupts.CPU140.TLB:TLB_shootdowns
      4080 ±  6%     +25.8%       5131 ±  7%  interrupts.CPU141.CAL:Function_call_interrupts
      5148 ±  4%     -33.6%       3418 ± 25%  interrupts.CPU141.NMI:Non-maskable_interrupts
      5148 ±  4%     -33.6%       3418 ± 25%  interrupts.CPU141.PMI:Performance_monitoring_interrupts
    695.00 ±  3%     +74.7%       1214 ±  7%  interrupts.CPU141.RES:Rescheduling_interrupts
    503.33 ± 23%    +150.9%       1263 ± 44%  interrupts.CPU141.TLB:TLB_shootdowns
      4155 ±  8%     +16.6%       4843 ±  4%  interrupts.CPU142.CAL:Function_call_interrupts
    638.00 ±  6%     +82.1%       1161 ±  6%  interrupts.CPU142.RES:Rescheduling_interrupts
    509.33 ±  8%     +89.0%     962.50 ± 14%  interrupts.CPU142.TLB:TLB_shootdowns
      4018 ±  6%     +24.3%       4993        interrupts.CPU143.CAL:Function_call_interrupts
    643.67 ±  2%     +86.6%       1201 ±  8%  interrupts.CPU143.RES:Rescheduling_interrupts
    553.67 ±  7%     +83.0%       1013 ± 10%  interrupts.CPU143.TLB:TLB_shootdowns
      3990 ±  5%     +25.0%       4989 ±  4%  interrupts.CPU144.CAL:Function_call_interrupts
    654.00 ± 10%     +78.0%       1164 ±  4%  interrupts.CPU144.RES:Rescheduling_interrupts
    415.33 ±  4%    +124.9%     934.25 ±  9%  interrupts.CPU144.TLB:TLB_shootdowns
      3875 ±  3%     +30.5%       5056 ±  6%  interrupts.CPU145.CAL:Function_call_interrupts
    647.00 ± 13%     +79.9%       1163 ±  4%  interrupts.CPU145.RES:Rescheduling_interrupts
    445.67 ± 16%    +112.7%     947.75 ± 12%  interrupts.CPU145.TLB:TLB_shootdowns
      3891 ±  7%     +24.8%       4857 ±  5%  interrupts.CPU146.CAL:Function_call_interrupts
    635.00 ±  6%     +80.7%       1147 ±  5%  interrupts.CPU146.RES:Rescheduling_interrupts
    438.67 ± 11%    +127.1%     996.25 ± 10%  interrupts.CPU146.TLB:TLB_shootdowns
      3899 ±  7%     +28.0%       4990 ±  4%  interrupts.CPU147.CAL:Function_call_interrupts
      5189 ±  3%     -24.6%       3915 ± 10%  interrupts.CPU147.NMI:Non-maskable_interrupts
      5189 ±  3%     -24.6%       3915 ± 10%  interrupts.CPU147.PMI:Performance_monitoring_interrupts
    643.33           +80.3%       1160 ±  2%  interrupts.CPU147.RES:Rescheduling_interrupts
    430.00 ± 16%    +116.9%     932.50 ± 17%  interrupts.CPU147.TLB:TLB_shootdowns
      4129 ± 12%     +18.4%       4889        interrupts.CPU148.CAL:Function_call_interrupts
      5219 ±  3%     -24.7%       3932 ±  9%  interrupts.CPU148.NMI:Non-maskable_interrupts
      5219 ±  3%     -24.7%       3932 ±  9%  interrupts.CPU148.PMI:Performance_monitoring_interrupts
    588.33 ±  7%     +93.6%       1139 ±  5%  interrupts.CPU148.RES:Rescheduling_interrupts
    501.00 ± 16%     +78.7%     895.25 ±  8%  interrupts.CPU148.TLB:TLB_shootdowns
      4186 ±  9%     +18.3%       4953 ±  3%  interrupts.CPU149.CAL:Function_call_interrupts
      5185 ±  4%     -32.3%       3509 ± 31%  interrupts.CPU149.NMI:Non-maskable_interrupts
      5185 ±  4%     -32.3%       3509 ± 31%  interrupts.CPU149.PMI:Performance_monitoring_interrupts
    638.67           +70.9%       1091 ±  2%  interrupts.CPU149.RES:Rescheduling_interrupts
    558.33 ± 15%     +71.8%     959.25 ±  7%  interrupts.CPU149.TLB:TLB_shootdowns
      3912 ±  6%     +21.4%       4750 ±  4%  interrupts.CPU15.CAL:Function_call_interrupts
      5197 ±  3%     -22.8%       4013 ±  4%  interrupts.CPU15.NMI:Non-maskable_interrupts
      5197 ±  3%     -22.8%       4013 ±  4%  interrupts.CPU15.PMI:Performance_monitoring_interrupts
    776.33 ±  7%     +39.1%       1080 ±  6%  interrupts.CPU15.RES:Rescheduling_interrupts
    473.00 ± 12%     +98.5%     938.75 ± 11%  interrupts.CPU15.TLB:TLB_shootdowns
      4178 ±  9%     +18.1%       4936 ±  4%  interrupts.CPU150.CAL:Function_call_interrupts
      5192 ±  4%     -25.4%       3873 ± 10%  interrupts.CPU150.NMI:Non-maskable_interrupts
      5192 ±  4%     -25.4%       3873 ± 10%  interrupts.CPU150.PMI:Performance_monitoring_interrupts
    678.67 ±  8%     +64.3%       1115 ±  5%  interrupts.CPU150.RES:Rescheduling_interrupts
    513.33 ± 28%     +73.6%     891.00 ± 21%  interrupts.CPU150.TLB:TLB_shootdowns
      4052 ±  6%     +21.9%       4939 ±  3%  interrupts.CPU151.CAL:Function_call_interrupts
      5260 ±  3%     -25.8%       3903 ± 10%  interrupts.CPU151.NMI:Non-maskable_interrupts
      5260 ±  3%     -25.8%       3903 ± 10%  interrupts.CPU151.PMI:Performance_monitoring_interrupts
    623.33 ±  3%     +86.9%       1164 ±  4%  interrupts.CPU151.RES:Rescheduling_interrupts
    484.67 ± 11%     +98.0%     959.50 ±  8%  interrupts.CPU151.TLB:TLB_shootdowns
      3982 ±  8%     +25.1%       4982 ±  4%  interrupts.CPU152.CAL:Function_call_interrupts
      5183 ±  2%     -32.9%       3475 ± 26%  interrupts.CPU152.NMI:Non-maskable_interrupts
      5183 ±  2%     -32.9%       3475 ± 26%  interrupts.CPU152.PMI:Performance_monitoring_interrupts
    623.33 ±  5%     +79.5%       1119 ±  2%  interrupts.CPU152.RES:Rescheduling_interrupts
    494.00 ± 14%     +89.7%     937.25 ±  9%  interrupts.CPU152.TLB:TLB_shootdowns
      4109 ±  6%     +24.9%       5131 ± 10%  interrupts.CPU153.CAL:Function_call_interrupts
      5179 ±  4%     -31.7%       3536 ± 31%  interrupts.CPU153.NMI:Non-maskable_interrupts
      5179 ±  4%     -31.7%       3536 ± 31%  interrupts.CPU153.PMI:Performance_monitoring_interrupts
    614.67 ±  3%     +94.8%       1197 ±  9%  interrupts.CPU153.RES:Rescheduling_interrupts
    486.00 ± 19%     +83.9%     893.75 ± 13%  interrupts.CPU153.TLB:TLB_shootdowns
      4161 ±  5%     +16.5%       4846 ±  2%  interrupts.CPU154.CAL:Function_call_interrupts
    635.33 ±  3%     +74.6%       1109 ±  3%  interrupts.CPU154.RES:Rescheduling_interrupts
    490.67 ± 21%     +87.4%     919.50 ±  8%  interrupts.CPU154.TLB:TLB_shootdowns
      3946 ±  8%     +28.2%       5057 ±  2%  interrupts.CPU155.CAL:Function_call_interrupts
    631.33 ±  9%     +78.6%       1127 ±  3%  interrupts.CPU155.RES:Rescheduling_interrupts
    489.33 ± 17%    +107.9%       1017 ± 11%  interrupts.CPU155.TLB:TLB_shootdowns
      4028 ±  5%     +21.3%       4887 ±  4%  interrupts.CPU156.CAL:Function_call_interrupts
    627.33 ±  2%     +82.2%       1142 ±  2%  interrupts.CPU156.RES:Rescheduling_interrupts
    452.33 ± 14%    +113.0%     963.25 ± 15%  interrupts.CPU156.TLB:TLB_shootdowns
      3893 ±  8%     +28.2%       4993 ±  4%  interrupts.CPU157.CAL:Function_call_interrupts
    637.33           +80.4%       1149 ±  4%  interrupts.CPU157.RES:Rescheduling_interrupts
    451.67 ± 20%    +105.6%     928.50 ± 11%  interrupts.CPU157.TLB:TLB_shootdowns
      4155 ±  9%     +19.6%       4971 ±  4%  interrupts.CPU158.CAL:Function_call_interrupts
    628.33 ±  6%     +75.8%       1104 ±  2%  interrupts.CPU158.RES:Rescheduling_interrupts
    468.33 ± 11%    +103.4%     952.50 ± 11%  interrupts.CPU158.TLB:TLB_shootdowns
      3965 ±  8%     +23.8%       4910 ±  5%  interrupts.CPU159.CAL:Function_call_interrupts
    597.33 ±  4%     +95.2%       1166 ±  2%  interrupts.CPU159.RES:Rescheduling_interrupts
    436.00 ± 12%    +121.7%     966.50 ± 11%  interrupts.CPU159.TLB:TLB_shootdowns
      3811 ±  3%     +28.3%       4890 ±  6%  interrupts.CPU16.CAL:Function_call_interrupts
      5211 ±  3%     -24.1%       3953 ±  5%  interrupts.CPU16.NMI:Non-maskable_interrupts
      5211 ±  3%     -24.1%       3953 ±  5%  interrupts.CPU16.PMI:Performance_monitoring_interrupts
    726.67 ±  6%     +55.9%       1132 ±  7%  interrupts.CPU16.RES:Rescheduling_interrupts
    505.67 ± 13%     +75.1%     885.50 ± 12%  interrupts.CPU16.TLB:TLB_shootdowns
      3965 ±  8%     +24.8%       4948 ±  6%  interrupts.CPU160.CAL:Function_call_interrupts
    636.67 ±  4%     +74.8%       1113 ±  2%  interrupts.CPU160.RES:Rescheduling_interrupts
    516.67 ± 17%     +88.3%     973.00 ± 14%  interrupts.CPU160.TLB:TLB_shootdowns
      4054 ±  8%     +24.2%       5036 ±  4%  interrupts.CPU161.CAL:Function_call_interrupts
    601.00 ±  6%     +89.6%       1139 ±  3%  interrupts.CPU161.RES:Rescheduling_interrupts
    514.33 ± 13%     +81.9%     935.50 ± 12%  interrupts.CPU161.TLB:TLB_shootdowns
      4039 ± 11%     +19.7%       4836 ±  3%  interrupts.CPU162.CAL:Function_call_interrupts
    643.33 ±  7%     +67.2%       1075        interrupts.CPU162.RES:Rescheduling_interrupts
    469.33 ± 18%    +107.1%     972.00 ±  8%  interrupts.CPU162.TLB:TLB_shootdowns
      4022 ±  7%     +20.9%       4864 ±  3%  interrupts.CPU163.CAL:Function_call_interrupts
    609.33 ±  3%     +92.5%       1172        interrupts.CPU163.RES:Rescheduling_interrupts
    431.00 ± 18%    +146.3%       1061 ±  6%  interrupts.CPU163.TLB:TLB_shootdowns
      4036           +20.7%       4869 ±  4%  interrupts.CPU164.CAL:Function_call_interrupts
    613.00 ±  4%     +86.4%       1142 ±  6%  interrupts.CPU164.RES:Rescheduling_interrupts
    492.33 ± 19%     +87.9%     925.25 ± 10%  interrupts.CPU164.TLB:TLB_shootdowns
      3957 ±  3%     +23.4%       4883 ±  4%  interrupts.CPU165.CAL:Function_call_interrupts
      4307 ± 27%     -42.1%       2492 ± 41%  interrupts.CPU165.NMI:Non-maskable_interrupts
      4307 ± 27%     -42.1%       2492 ± 41%  interrupts.CPU165.PMI:Performance_monitoring_interrupts
    583.00 ± 10%     +88.9%       1101 ±  3%  interrupts.CPU165.RES:Rescheduling_interrupts
    449.00 ± 22%    +108.7%     937.25 ± 13%  interrupts.CPU165.TLB:TLB_shootdowns
      4219 ±  5%     +16.9%       4932 ±  4%  interrupts.CPU166.CAL:Function_call_interrupts
    624.33 ±  4%     +76.9%       1104 ±  5%  interrupts.CPU166.RES:Rescheduling_interrupts
    484.33 ± 17%    +100.6%     971.50 ± 17%  interrupts.CPU166.TLB:TLB_shootdowns
      4064 ± 10%     +21.0%       4918 ±  3%  interrupts.CPU167.CAL:Function_call_interrupts
    616.67 ±  6%     +83.5%       1131 ±  4%  interrupts.CPU167.RES:Rescheduling_interrupts
    452.00 ± 12%     +95.7%     884.50 ±  8%  interrupts.CPU167.TLB:TLB_shootdowns
      4087 ±  6%     +19.4%       4879 ±  6%  interrupts.CPU168.CAL:Function_call_interrupts
    649.67           +69.1%       1098 ±  4%  interrupts.CPU168.RES:Rescheduling_interrupts
    478.33 ±  6%     +92.4%     920.50 ± 12%  interrupts.CPU168.TLB:TLB_shootdowns
      3753 ±  7%     +20.6%       4524 ±  4%  interrupts.CPU169.CAL:Function_call_interrupts
    585.67           +81.9%       1065 ±  2%  interrupts.CPU169.RES:Rescheduling_interrupts
    459.00 ±  4%    +104.2%     937.50 ±  3%  interrupts.CPU169.TLB:TLB_shootdowns
      3764 ±  5%     +28.6%       4841 ±  3%  interrupts.CPU17.CAL:Function_call_interrupts
      5198 ±  3%     -43.0%       2964 ± 35%  interrupts.CPU17.NMI:Non-maskable_interrupts
      5198 ±  3%     -43.0%       2964 ± 35%  interrupts.CPU17.PMI:Performance_monitoring_interrupts
    729.33 ±  5%     +52.1%       1109 ±  7%  interrupts.CPU17.RES:Rescheduling_interrupts
    450.67 ± 10%    +104.4%     921.25 ±  7%  interrupts.CPU17.TLB:TLB_shootdowns
      4099 ±  8%     +24.8%       5118 ±  5%  interrupts.CPU170.CAL:Function_call_interrupts
    590.67 ±  7%     +91.4%       1130        interrupts.CPU170.RES:Rescheduling_interrupts
    552.33 ± 17%     +75.9%     971.75 ± 10%  interrupts.CPU170.TLB:TLB_shootdowns
      4023 ±  8%     +19.5%       4808        interrupts.CPU171.CAL:Function_call_interrupts
    594.67 ±  7%     +82.6%       1085 ±  5%  interrupts.CPU171.RES:Rescheduling_interrupts
    468.33 ± 13%     +94.0%     908.75 ±  7%  interrupts.CPU171.TLB:TLB_shootdowns
      3917 ±  9%     +25.0%       4895 ±  5%  interrupts.CPU172.CAL:Function_call_interrupts
      5248 ±  3%     -25.4%       3915 ± 10%  interrupts.CPU172.NMI:Non-maskable_interrupts
      5248 ±  3%     -25.4%       3915 ± 10%  interrupts.CPU172.PMI:Performance_monitoring_interrupts
    543.00 ±  3%    +103.6%       1105 ±  5%  interrupts.CPU172.RES:Rescheduling_interrupts
    468.67 ± 15%     +94.0%     909.25 ± 17%  interrupts.CPU172.TLB:TLB_shootdowns
      4057 ±  6%     +22.6%       4975 ±  2%  interrupts.CPU173.CAL:Function_call_interrupts
      5158 ±  5%     -31.7%       3521 ± 31%  interrupts.CPU173.NMI:Non-maskable_interrupts
      5158 ±  5%     -31.7%       3521 ± 31%  interrupts.CPU173.PMI:Performance_monitoring_interrupts
    597.67 ±  5%     +87.9%       1123 ±  3%  interrupts.CPU173.RES:Rescheduling_interrupts
    498.67 ± 19%    +133.2%       1163 ± 26%  interrupts.CPU173.TLB:TLB_shootdowns
      3833 ±  8%     +26.8%       4859 ±  3%  interrupts.CPU174.CAL:Function_call_interrupts
      5208 ±  4%     -24.7%       3920 ± 11%  interrupts.CPU174.NMI:Non-maskable_interrupts
      5208 ±  4%     -24.7%       3920 ± 11%  interrupts.CPU174.PMI:Performance_monitoring_interrupts
    570.67 ±  2%     +91.1%       1090 ±  7%  interrupts.CPU174.RES:Rescheduling_interrupts
    470.00 ± 19%    +108.3%     979.00 ± 12%  interrupts.CPU174.TLB:TLB_shootdowns
      4117 ±  7%     +17.7%       4845 ±  3%  interrupts.CPU175.CAL:Function_call_interrupts
      5202 ±  4%     -25.1%       3896 ±  8%  interrupts.CPU175.NMI:Non-maskable_interrupts
      5202 ±  4%     -25.1%       3896 ±  8%  interrupts.CPU175.PMI:Performance_monitoring_interrupts
    638.33 ±  3%     +70.8%       1090 ±  5%  interrupts.CPU175.RES:Rescheduling_interrupts
    463.00 ± 17%    +104.4%     946.50 ±  8%  interrupts.CPU175.TLB:TLB_shootdowns
      4021 ±  4%     +16.9%       4699 ±  2%  interrupts.CPU176.CAL:Function_call_interrupts
    608.67 ±  6%     +79.4%       1091 ±  6%  interrupts.CPU176.RES:Rescheduling_interrupts
    477.33 ± 10%     +97.2%     941.50 ±  7%  interrupts.CPU176.TLB:TLB_shootdowns
      4071 ±  7%     +15.5%       4702        interrupts.CPU177.CAL:Function_call_interrupts
    596.33 ±  4%     +82.2%       1086        interrupts.CPU177.RES:Rescheduling_interrupts
    435.00 ±  5%    +114.7%     934.00 ± 14%  interrupts.CPU177.TLB:TLB_shootdowns
      4130 ±  7%     +16.6%       4815 ±  4%  interrupts.CPU178.CAL:Function_call_interrupts
    633.33 ±  4%     +64.1%       1039 ±  4%  interrupts.CPU178.RES:Rescheduling_interrupts
    478.67 ± 15%     +95.2%     934.50 ± 19%  interrupts.CPU178.TLB:TLB_shootdowns
      3821 ±  4%     +26.8%       4846 ±  3%  interrupts.CPU179.CAL:Function_call_interrupts
    594.67           +76.6%       1050 ±  4%  interrupts.CPU179.RES:Rescheduling_interrupts
    479.00 ±  7%     +96.5%     941.00 ±  6%  interrupts.CPU179.TLB:TLB_shootdowns
      4196 ±  4%     +16.5%       4890 ±  5%  interrupts.CPU18.CAL:Function_call_interrupts
    728.33           +51.1%       1100 ±  3%  interrupts.CPU18.RES:Rescheduling_interrupts
    506.00 ± 11%     +71.7%     868.75 ±  6%  interrupts.CPU18.TLB:TLB_shootdowns
      3950 ±  6%     +23.3%       4870 ±  2%  interrupts.CPU180.CAL:Function_call_interrupts
    606.33 ±  8%     +72.5%       1045 ±  2%  interrupts.CPU180.RES:Rescheduling_interrupts
    498.00 ±  5%     +72.3%     858.00 ± 17%  interrupts.CPU180.TLB:TLB_shootdowns
      4113 ± 11%     +18.3%       4864 ±  5%  interrupts.CPU181.CAL:Function_call_interrupts
    620.33 ±  4%     +73.7%       1077 ±  5%  interrupts.CPU181.RES:Rescheduling_interrupts
    483.33 ±  5%     +90.3%     919.75 ± 11%  interrupts.CPU181.TLB:TLB_shootdowns
      4070 ±  8%     +17.0%       4761 ±  2%  interrupts.CPU182.CAL:Function_call_interrupts
    588.00 ±  7%     +82.8%       1075 ±  3%  interrupts.CPU182.RES:Rescheduling_interrupts
    480.00 ± 17%    +124.7%       1078 ± 10%  interrupts.CPU182.TLB:TLB_shootdowns
      4198 ±  7%     +15.9%       4868 ±  2%  interrupts.CPU183.CAL:Function_call_interrupts
    681.33 ±  6%     +59.5%       1087 ±  6%  interrupts.CPU183.RES:Rescheduling_interrupts
    509.33 ± 16%     +78.5%     909.00 ± 15%  interrupts.CPU183.TLB:TLB_shootdowns
      3955 ±  2%     +25.7%       4970 ±  3%  interrupts.CPU184.CAL:Function_call_interrupts
    565.00 ±  6%     +93.8%       1095 ±  6%  interrupts.CPU184.RES:Rescheduling_interrupts
    443.67 ± 14%    +107.0%     918.25 ±  9%  interrupts.CPU184.TLB:TLB_shootdowns
      4105 ±  6%     +16.5%       4781 ±  5%  interrupts.CPU185.CAL:Function_call_interrupts
    546.67 ±  5%    +105.8%       1125 ±  7%  interrupts.CPU185.RES:Rescheduling_interrupts
    505.00 ± 18%     +86.8%     943.50 ±  8%  interrupts.CPU185.TLB:TLB_shootdowns
      4067 ±  6%     +19.9%       4878 ±  3%  interrupts.CPU186.CAL:Function_call_interrupts
    604.67 ±  6%     +71.2%       1035 ±  7%  interrupts.CPU186.RES:Rescheduling_interrupts
    486.67 ± 12%     +89.7%     923.25 ±  8%  interrupts.CPU186.TLB:TLB_shootdowns
    588.00 ±  6%     +77.9%       1046 ±  5%  interrupts.CPU187.RES:Rescheduling_interrupts
    499.67 ± 15%     +86.2%     930.50 ± 15%  interrupts.CPU187.TLB:TLB_shootdowns
      4186 ±  5%     +17.1%       4901 ±  5%  interrupts.CPU188.CAL:Function_call_interrupts
    616.33 ±  2%     +77.1%       1091 ±  4%  interrupts.CPU188.RES:Rescheduling_interrupts
    461.33 ±  9%    +102.1%     932.25 ± 15%  interrupts.CPU188.TLB:TLB_shootdowns
      3980 ±  6%     +21.8%       4849 ±  2%  interrupts.CPU189.CAL:Function_call_interrupts
    594.33           +87.8%       1116 ±  3%  interrupts.CPU189.RES:Rescheduling_interrupts
    431.33 ± 10%    +126.0%     974.75 ±  5%  interrupts.CPU189.TLB:TLB_shootdowns
      3937 ±  5%     +21.2%       4772 ±  5%  interrupts.CPU19.CAL:Function_call_interrupts
      5173 ±  3%     -31.9%       3525 ± 25%  interrupts.CPU19.NMI:Non-maskable_interrupts
      5173 ±  3%     -31.9%       3525 ± 25%  interrupts.CPU19.PMI:Performance_monitoring_interrupts
    722.67 ±  9%     +48.1%       1070 ±  2%  interrupts.CPU19.RES:Rescheduling_interrupts
    479.67 ± 18%     +95.3%     937.00 ±  9%  interrupts.CPU19.TLB:TLB_shootdowns
      3905 ±  5%     +25.2%       4890 ±  5%  interrupts.CPU190.CAL:Function_call_interrupts
      5230 ±  2%     -24.7%       3937 ± 10%  interrupts.CPU190.NMI:Non-maskable_interrupts
      5230 ±  2%     -24.7%       3937 ± 10%  interrupts.CPU190.PMI:Performance_monitoring_interrupts
    580.33 ±  3%     +84.6%       1071 ±  2%  interrupts.CPU190.RES:Rescheduling_interrupts
    454.33 ± 12%    +111.7%     961.75 ± 14%  interrupts.CPU190.TLB:TLB_shootdowns
      3985 ±  4%     +23.4%       4918 ±  4%  interrupts.CPU191.CAL:Function_call_interrupts
      5184 ±  4%     -34.0%       3422 ± 24%  interrupts.CPU191.NMI:Non-maskable_interrupts
      5184 ±  4%     -34.0%       3422 ± 24%  interrupts.CPU191.PMI:Performance_monitoring_interrupts
    589.67 ±  2%     +91.5%       1129 ±  7%  interrupts.CPU191.RES:Rescheduling_interrupts
    498.67 ± 25%    +102.2%       1008 ± 14%  interrupts.CPU191.TLB:TLB_shootdowns
      3847 ±  6%     +29.1%       4965 ±  8%  interrupts.CPU2.CAL:Function_call_interrupts
      5162 ±  3%     -23.5%       3948 ±  5%  interrupts.CPU2.NMI:Non-maskable_interrupts
      5162 ±  3%     -23.5%       3948 ±  5%  interrupts.CPU2.PMI:Performance_monitoring_interrupts
    691.33 ±  3%     +59.0%       1099 ±  7%  interrupts.CPU2.RES:Rescheduling_interrupts
    486.67 ±  6%     +83.7%     894.25 ± 13%  interrupts.CPU2.TLB:TLB_shootdowns
      4000 ±  3%     +19.6%       4786 ±  5%  interrupts.CPU20.CAL:Function_call_interrupts
      5181 ±  2%     -42.1%       2999 ± 32%  interrupts.CPU20.NMI:Non-maskable_interrupts
      5181 ±  2%     -42.1%       2999 ± 32%  interrupts.CPU20.PMI:Performance_monitoring_interrupts
    774.00 ± 11%     +45.8%       1128 ±  5%  interrupts.CPU20.RES:Rescheduling_interrupts
    458.33 ± 11%    +111.7%     970.25 ± 12%  interrupts.CPU20.TLB:TLB_shootdowns
      4143 ±  4%     +13.1%       4684 ±  3%  interrupts.CPU21.CAL:Function_call_interrupts
    814.67 ± 19%     +35.1%       1100 ±  6%  interrupts.CPU21.RES:Rescheduling_interrupts
    453.67 ± 12%     +97.1%     894.25 ± 13%  interrupts.CPU21.TLB:TLB_shootdowns
      3936           +26.2%       4968 ±  4%  interrupts.CPU22.CAL:Function_call_interrupts
      5194 ±  2%     -22.7%       4017 ±  5%  interrupts.CPU22.NMI:Non-maskable_interrupts
      5194 ±  2%     -22.7%       4017 ±  5%  interrupts.CPU22.PMI:Performance_monitoring_interrupts
    754.67 ± 11%     +45.8%       1100 ±  7%  interrupts.CPU22.RES:Rescheduling_interrupts
    467.67 ± 14%    +100.0%     935.25 ± 17%  interrupts.CPU22.TLB:TLB_shootdowns
      4046 ±  4%     +17.6%       4758 ±  2%  interrupts.CPU23.CAL:Function_call_interrupts
    716.67 ±  2%     +45.6%       1043 ±  5%  interrupts.CPU23.RES:Rescheduling_interrupts
    416.33 ±  7%    +108.4%     867.50 ± 12%  interrupts.CPU23.TLB:TLB_shootdowns
      4323 ±  6%     +17.2%       5066 ±  5%  interrupts.CPU24.CAL:Function_call_interrupts
      5170 ±  3%     -22.1%       4027 ±  6%  interrupts.CPU24.NMI:Non-maskable_interrupts
      5170 ±  3%     -22.1%       4027 ±  6%  interrupts.CPU24.PMI:Performance_monitoring_interrupts
    876.33 ±  4%     +33.1%       1166 ±  6%  interrupts.CPU24.RES:Rescheduling_interrupts
    678.33 ± 16%     +50.4%       1020 ±  9%  interrupts.CPU24.TLB:TLB_shootdowns
      4259 ±  7%     +18.1%       5027 ±  2%  interrupts.CPU25.CAL:Function_call_interrupts
      5240 ±  3%     -23.8%       3993 ±  8%  interrupts.CPU25.NMI:Non-maskable_interrupts
      5240 ±  3%     -23.8%       3993 ±  8%  interrupts.CPU25.PMI:Performance_monitoring_interrupts
    791.67 ±  3%     +44.3%       1142 ±  7%  interrupts.CPU25.RES:Rescheduling_interrupts
    594.00 ± 22%     +62.4%     964.75 ± 15%  interrupts.CPU25.TLB:TLB_shootdowns
      4234 ± 13%     +20.7%       5111 ±  3%  interrupts.CPU26.CAL:Function_call_interrupts
    821.33 ±  3%     +41.4%       1161 ±  6%  interrupts.CPU26.RES:Rescheduling_interrupts
    528.00 ±  5%     +96.6%       1038 ± 18%  interrupts.CPU26.TLB:TLB_shootdowns
      4202 ±  4%     +21.4%       5101 ±  4%  interrupts.CPU27.CAL:Function_call_interrupts
      5218 ±  2%     -22.5%       4045 ±  8%  interrupts.CPU27.NMI:Non-maskable_interrupts
      5218 ±  2%     -22.5%       4045 ±  8%  interrupts.CPU27.PMI:Performance_monitoring_interrupts
    720.00 ±  5%     +58.6%       1142 ±  5%  interrupts.CPU27.RES:Rescheduling_interrupts
    502.67 ± 16%     +89.7%     953.50 ± 12%  interrupts.CPU27.TLB:TLB_shootdowns
      4162 ± 14%     +18.2%       4921 ±  5%  interrupts.CPU28.CAL:Function_call_interrupts
      5157 ±  2%     -23.4%       3951 ±  7%  interrupts.CPU28.NMI:Non-maskable_interrupts
      5157 ±  2%     -23.4%       3951 ±  7%  interrupts.CPU28.PMI:Performance_monitoring_interrupts
    755.33 ±  3%     +47.4%       1113 ±  5%  interrupts.CPU28.RES:Rescheduling_interrupts
    497.00 ± 10%     +91.9%     953.50 ±  3%  interrupts.CPU28.TLB:TLB_shootdowns
      4088 ±  5%     +24.1%       5072 ±  6%  interrupts.CPU29.CAL:Function_call_interrupts
      5188 ±  3%     -22.5%       4021 ±  6%  interrupts.CPU29.NMI:Non-maskable_interrupts
      5188 ±  3%     -22.5%       4021 ±  6%  interrupts.CPU29.PMI:Performance_monitoring_interrupts
    719.33 ±  6%     +57.0%       1129 ±  6%  interrupts.CPU29.RES:Rescheduling_interrupts
    464.33 ±  2%    +131.1%       1073 ± 26%  interrupts.CPU29.TLB:TLB_shootdowns
      3770           +25.7%       4739 ±  5%  interrupts.CPU3.CAL:Function_call_interrupts
    746.33 ±  6%     +50.2%       1120 ± 11%  interrupts.CPU3.RES:Rescheduling_interrupts
    511.67 ± 14%     +74.5%     892.75 ±  6%  interrupts.CPU3.TLB:TLB_shootdowns
      4203 ±  7%     +18.9%       4998 ±  3%  interrupts.CPU30.CAL:Function_call_interrupts
      5183 ±  3%     -41.1%       3055 ± 37%  interrupts.CPU30.NMI:Non-maskable_interrupts
      5183 ±  3%     -41.1%       3055 ± 37%  interrupts.CPU30.PMI:Performance_monitoring_interrupts
    749.33 ±  5%     +52.9%       1146 ±  6%  interrupts.CPU30.RES:Rescheduling_interrupts
    469.33 ± 17%    +108.5%     978.75 ±  8%  interrupts.CPU30.TLB:TLB_shootdowns
      4133 ±  5%     +20.3%       4971 ±  2%  interrupts.CPU31.CAL:Function_call_interrupts
      5174 ±  3%     -31.7%       3536 ± 26%  interrupts.CPU31.NMI:Non-maskable_interrupts
      5174 ±  3%     -31.7%       3536 ± 26%  interrupts.CPU31.PMI:Performance_monitoring_interrupts
    777.33 ±  5%     +53.8%       1195 ±  5%  interrupts.CPU31.RES:Rescheduling_interrupts
    496.00 ±  9%     +96.7%     975.75 ± 16%  interrupts.CPU31.TLB:TLB_shootdowns
      4107 ±  7%     +18.1%       4849 ±  2%  interrupts.CPU32.CAL:Function_call_interrupts
      5163 ±  3%     -21.8%       4038 ±  7%  interrupts.CPU32.NMI:Non-maskable_interrupts
      5163 ±  3%     -21.8%       4038 ±  7%  interrupts.CPU32.PMI:Performance_monitoring_interrupts
    711.67           +52.9%       1088 ±  5%  interrupts.CPU32.RES:Rescheduling_interrupts
    489.33 ± 18%    +115.7%       1055 ± 11%  interrupts.CPU32.TLB:TLB_shootdowns
      4170 ±  4%     +17.4%       4897 ±  2%  interrupts.CPU33.CAL:Function_call_interrupts
      5215 ±  3%     -33.3%       3480 ± 25%  interrupts.CPU33.NMI:Non-maskable_interrupts
      5215 ±  3%     -33.3%       3480 ± 25%  interrupts.CPU33.PMI:Performance_monitoring_interrupts
    785.33 ±  7%     +46.2%       1148 ±  4%  interrupts.CPU33.RES:Rescheduling_interrupts
    547.67 ± 13%     +71.6%     939.75 ± 11%  interrupts.CPU33.TLB:TLB_shootdowns
      4302 ±  6%     +16.0%       4992 ±  4%  interrupts.CPU34.CAL:Function_call_interrupts
      5214 ±  3%     -22.7%       4031 ±  6%  interrupts.CPU34.NMI:Non-maskable_interrupts
      5214 ±  3%     -22.7%       4031 ±  6%  interrupts.CPU34.PMI:Performance_monitoring_interrupts
    787.33 ±  4%     +41.4%       1113 ±  4%  interrupts.CPU34.RES:Rescheduling_interrupts
    590.33 ±  2%     +60.2%     945.50 ± 11%  interrupts.CPU34.TLB:TLB_shootdowns
      4044 ± 11%     +22.9%       4969 ±  4%  interrupts.CPU35.CAL:Function_call_interrupts
      5220 ±  3%     -32.6%       3520 ± 25%  interrupts.CPU35.NMI:Non-maskable_interrupts
      5220 ±  3%     -32.6%       3520 ± 25%  interrupts.CPU35.PMI:Performance_monitoring_interrupts
    735.67 ±  4%     +56.9%       1154 ±  9%  interrupts.CPU35.RES:Rescheduling_interrupts
    485.00 ± 12%    +101.3%     976.50 ± 11%  interrupts.CPU35.TLB:TLB_shootdowns
      4291 ±  8%     +14.9%       4930 ±  5%  interrupts.CPU36.CAL:Function_call_interrupts
    782.67 ±  4%     +51.0%       1182 ±  4%  interrupts.CPU36.RES:Rescheduling_interrupts
    491.00 ± 16%     +84.3%     904.75 ± 16%  interrupts.CPU36.TLB:TLB_shootdowns
      3949 ±  5%     +24.1%       4898 ±  4%  interrupts.CPU37.CAL:Function_call_interrupts
    723.67 ±  3%     +54.0%       1114 ±  7%  interrupts.CPU37.RES:Rescheduling_interrupts
    490.00 ±  9%    +111.4%       1036 ±  8%  interrupts.CPU37.TLB:TLB_shootdowns
      5218 ±  2%     -23.3%       4000 ±  7%  interrupts.CPU38.NMI:Non-maskable_interrupts
      5218 ±  2%     -23.3%       4000 ±  7%  interrupts.CPU38.PMI:Performance_monitoring_interrupts
    797.67 ± 10%     +40.3%       1119 ±  6%  interrupts.CPU38.RES:Rescheduling_interrupts
    500.33 ± 16%     +89.6%     948.50 ± 12%  interrupts.CPU38.TLB:TLB_shootdowns
      3987 ±  5%     +26.0%       5023 ±  5%  interrupts.CPU39.CAL:Function_call_interrupts
    772.00           +47.0%       1134 ±  6%  interrupts.CPU39.RES:Rescheduling_interrupts
    483.00 ± 10%    +102.2%     976.75 ± 17%  interrupts.CPU39.TLB:TLB_shootdowns
      3933 ±  6%     +38.0%       5428 ± 14%  interrupts.CPU4.CAL:Function_call_interrupts
      5183 ±  4%     -43.3%       2939 ± 31%  interrupts.CPU4.NMI:Non-maskable_interrupts
      5183 ±  4%     -43.3%       2939 ± 31%  interrupts.CPU4.PMI:Performance_monitoring_interrupts
    799.33 ±  5%     +35.5%       1083 ±  4%  interrupts.CPU4.RES:Rescheduling_interrupts
    489.67 ± 14%    +100.9%     983.50 ± 11%  interrupts.CPU4.TLB:TLB_shootdowns
      4034 ±  6%     +23.7%       4991        interrupts.CPU40.CAL:Function_call_interrupts
      5212 ±  2%     -24.0%       3963 ±  7%  interrupts.CPU40.NMI:Non-maskable_interrupts
      5212 ±  2%     -24.0%       3963 ±  7%  interrupts.CPU40.PMI:Performance_monitoring_interrupts
    745.67 ±  5%     +53.6%       1145 ±  6%  interrupts.CPU40.RES:Rescheduling_interrupts
    407.67 ± 11%    +140.6%     981.00 ± 13%  interrupts.CPU40.TLB:TLB_shootdowns
      4029 ±  3%     +25.1%       5040 ±  4%  interrupts.CPU41.CAL:Function_call_interrupts
      5237 ±  2%     -24.0%       3980 ±  7%  interrupts.CPU41.NMI:Non-maskable_interrupts
      5237 ±  2%     -24.0%       3980 ±  7%  interrupts.CPU41.PMI:Performance_monitoring_interrupts
    764.00 ± 11%     +49.6%       1143 ± 10%  interrupts.CPU41.RES:Rescheduling_interrupts
    480.33 ± 15%    +102.8%     974.00 ± 14%  interrupts.CPU41.TLB:TLB_shootdowns
      4158 ±  9%     +19.1%       4950 ±  5%  interrupts.CPU42.CAL:Function_call_interrupts
      5205 ±  2%     -23.9%       3963 ±  7%  interrupts.CPU42.NMI:Non-maskable_interrupts
      5205 ±  2%     -23.9%       3963 ±  7%  interrupts.CPU42.PMI:Performance_monitoring_interrupts
    777.00           +48.0%       1150 ±  7%  interrupts.CPU42.RES:Rescheduling_interrupts
    494.67 ±  7%     +85.4%     917.25 ±  6%  interrupts.CPU42.TLB:TLB_shootdowns
      4145 ±  5%     +20.0%       4974 ±  2%  interrupts.CPU43.CAL:Function_call_interrupts
      5199 ±  3%     -23.6%       3971 ±  6%  interrupts.CPU43.NMI:Non-maskable_interrupts
      5199 ±  3%     -23.6%       3971 ±  6%  interrupts.CPU43.PMI:Performance_monitoring_interrupts
    734.00 ±  4%     +54.8%       1136 ±  3%  interrupts.CPU43.RES:Rescheduling_interrupts
    479.33 ± 21%    +116.7%       1038 ± 12%  interrupts.CPU43.TLB:TLB_shootdowns
      4038 ±  6%     +20.5%       4867 ±  2%  interrupts.CPU44.CAL:Function_call_interrupts
      5236 ±  3%     -34.3%       3438 ± 24%  interrupts.CPU44.NMI:Non-maskable_interrupts
      5236 ±  3%     -34.3%       3438 ± 24%  interrupts.CPU44.PMI:Performance_monitoring_interrupts
    721.67           +57.3%       1135 ±  6%  interrupts.CPU44.RES:Rescheduling_interrupts
    486.67 ± 12%     +94.9%     948.50 ± 11%  interrupts.CPU44.TLB:TLB_shootdowns
      4089 ±  7%     +19.7%       4895 ±  4%  interrupts.CPU45.CAL:Function_call_interrupts
    744.67 ±  4%     +45.4%       1083 ±  2%  interrupts.CPU45.RES:Rescheduling_interrupts
    450.33 ± 17%    +114.5%     966.00 ± 19%  interrupts.CPU45.TLB:TLB_shootdowns
      3816 ±  5%     +30.8%       4991 ±  5%  interrupts.CPU46.CAL:Function_call_interrupts
      5219 ±  3%     -32.9%       3502 ± 23%  interrupts.CPU46.NMI:Non-maskable_interrupts
      5219 ±  3%     -32.9%       3502 ± 23%  interrupts.CPU46.PMI:Performance_monitoring_interrupts
    740.33 ±  8%     +61.8%       1197 ±  5%  interrupts.CPU46.RES:Rescheduling_interrupts
    455.00 ±  6%    +107.6%     944.75 ± 15%  interrupts.CPU46.TLB:TLB_shootdowns
      3989 ±  2%     +24.0%       4947 ±  2%  interrupts.CPU47.CAL:Function_call_interrupts
      5204 ±  3%     -32.6%       3506 ± 24%  interrupts.CPU47.NMI:Non-maskable_interrupts
      5204 ±  3%     -32.6%       3506 ± 24%  interrupts.CPU47.PMI:Performance_monitoring_interrupts
    741.67 ±  4%     +53.1%       1135 ± 12%  interrupts.CPU47.RES:Rescheduling_interrupts
    437.33 ± 17%    +120.8%     965.75 ± 16%  interrupts.CPU47.TLB:TLB_shootdowns
      4165 ±  2%     +22.3%       5095 ±  3%  interrupts.CPU48.CAL:Function_call_interrupts
      5176 ±  4%     -21.7%       4053 ±  8%  interrupts.CPU48.NMI:Non-maskable_interrupts
      5176 ±  4%     -21.7%       4053 ±  8%  interrupts.CPU48.PMI:Performance_monitoring_interrupts
    835.00 ±  2%     +29.0%       1077 ±  2%  interrupts.CPU48.RES:Rescheduling_interrupts
    594.67 ± 17%     +62.2%     964.50 ±  5%  interrupts.CPU48.TLB:TLB_shootdowns
      4171 ±  9%     +18.7%       4950 ±  6%  interrupts.CPU49.CAL:Function_call_interrupts
      5186 ±  4%     -33.4%       3452 ± 24%  interrupts.CPU49.NMI:Non-maskable_interrupts
      5186 ±  4%     -33.4%       3452 ± 24%  interrupts.CPU49.PMI:Performance_monitoring_interrupts
    710.67 ±  4%     +55.6%       1105 ±  4%  interrupts.CPU49.RES:Rescheduling_interrupts
    553.67 ±  5%     +74.0%     963.25 ± 10%  interrupts.CPU49.TLB:TLB_shootdowns
      4064 ±  6%     +21.6%       4944 ±  5%  interrupts.CPU5.CAL:Function_call_interrupts
    772.33 ±  2%     +45.7%       1125 ±  4%  interrupts.CPU5.RES:Rescheduling_interrupts
    491.00 ± 14%     +95.2%     958.50 ± 10%  interrupts.CPU5.TLB:TLB_shootdowns
      3929 ±  4%     +26.4%       4966 ±  2%  interrupts.CPU50.CAL:Function_call_interrupts
      5201 ±  4%     -22.9%       4011 ±  7%  interrupts.CPU50.NMI:Non-maskable_interrupts
      5201 ±  4%     -22.9%       4011 ±  7%  interrupts.CPU50.PMI:Performance_monitoring_interrupts
    747.00 ±  4%     +40.6%       1050 ±  3%  interrupts.CPU50.RES:Rescheduling_interrupts
    482.33 ± 17%    +103.1%     979.75 ± 12%  interrupts.CPU50.TLB:TLB_shootdowns
      4192 ±  4%     +20.3%       5043 ±  4%  interrupts.CPU51.CAL:Function_call_interrupts
      5249 ±  3%     -24.0%       3987 ±  7%  interrupts.CPU51.NMI:Non-maskable_interrupts
      5249 ±  3%     -24.0%       3987 ±  7%  interrupts.CPU51.PMI:Performance_monitoring_interrupts
    780.33 ±  7%     +54.9%       1209 ±  9%  interrupts.CPU51.RES:Rescheduling_interrupts
    504.00 ± 11%     +95.9%     987.50 ±  9%  interrupts.CPU51.TLB:TLB_shootdowns
      4084 ±  4%     +21.8%       4972 ±  4%  interrupts.CPU52.CAL:Function_call_interrupts
      5208 ±  4%     -23.1%       4006 ± 11%  interrupts.CPU52.NMI:Non-maskable_interrupts
      5208 ±  4%     -23.1%       4006 ± 11%  interrupts.CPU52.PMI:Performance_monitoring_interrupts
    724.33 ±  3%     +48.6%       1076 ±  4%  interrupts.CPU52.RES:Rescheduling_interrupts
    536.00 ± 13%     +91.7%       1027 ±  7%  interrupts.CPU52.TLB:TLB_shootdowns
      5184 ±  3%     -24.1%       3933 ± 10%  interrupts.CPU53.NMI:Non-maskable_interrupts
      5184 ±  3%     -24.1%       3933 ± 10%  interrupts.CPU53.PMI:Performance_monitoring_interrupts
    722.67 ±  4%     +49.1%       1077 ±  5%  interrupts.CPU53.RES:Rescheduling_interrupts
    447.33 ± 20%    +118.6%     978.00 ± 11%  interrupts.CPU53.TLB:TLB_shootdowns
      4057 ±  3%     +25.0%       5073 ±  5%  interrupts.CPU54.CAL:Function_call_interrupts
      5172 ±  4%     -32.6%       3487 ± 24%  interrupts.CPU54.NMI:Non-maskable_interrupts
      5172 ±  4%     -32.6%       3487 ± 24%  interrupts.CPU54.PMI:Performance_monitoring_interrupts
    722.67           +50.7%       1088 ±  7%  interrupts.CPU54.RES:Rescheduling_interrupts
    491.33 ± 14%    +382.4%       2370 ±102%  interrupts.CPU54.TLB:TLB_shootdowns
      4092 ±  5%     +17.9%       4825        interrupts.CPU55.CAL:Function_call_interrupts
    755.67 ± 10%     +49.2%       1127 ±  4%  interrupts.CPU55.RES:Rescheduling_interrupts
    445.67          +117.2%     968.00 ± 11%  interrupts.CPU55.TLB:TLB_shootdowns
      4116 ±  4%     +20.0%       4940 ±  5%  interrupts.CPU56.CAL:Function_call_interrupts
      5144 ±  5%     -33.4%       3427 ± 23%  interrupts.CPU56.NMI:Non-maskable_interrupts
      5144 ±  5%     -33.4%       3427 ± 23%  interrupts.CPU56.PMI:Performance_monitoring_interrupts
    707.67           +55.5%       1100        interrupts.CPU56.RES:Rescheduling_interrupts
    448.00 ± 16%    +120.1%     986.00 ± 13%  interrupts.CPU56.TLB:TLB_shootdowns
      3861           +26.2%       4871 ±  3%  interrupts.CPU57.CAL:Function_call_interrupts
      5187 ±  3%     -33.0%       3474 ± 25%  interrupts.CPU57.NMI:Non-maskable_interrupts
      5187 ±  3%     -33.0%       3474 ± 25%  interrupts.CPU57.PMI:Performance_monitoring_interrupts
    703.00 ±  3%     +55.6%       1094 ±  4%  interrupts.CPU57.RES:Rescheduling_interrupts
    495.67 ± 19%    +106.5%       1023 ±  8%  interrupts.CPU57.TLB:TLB_shootdowns
      4003 ±  6%     +25.3%       5016 ±  4%  interrupts.CPU58.CAL:Function_call_interrupts
      5267           -32.7%       3543 ± 30%  interrupts.CPU58.NMI:Non-maskable_interrupts
      5267           -32.7%       3543 ± 30%  interrupts.CPU58.PMI:Performance_monitoring_interrupts
    692.00           +61.0%       1114        interrupts.CPU58.RES:Rescheduling_interrupts
    467.67 ± 16%    +109.8%     981.25 ±  9%  interrupts.CPU58.TLB:TLB_shootdowns
      4147 ±  7%     +21.2%       5024 ±  4%  interrupts.CPU59.CAL:Function_call_interrupts
      5175 ±  3%     -33.9%       3419 ± 24%  interrupts.CPU59.NMI:Non-maskable_interrupts
      5175 ±  3%     -33.9%       3419 ± 24%  interrupts.CPU59.PMI:Performance_monitoring_interrupts
    765.00 ±  2%     +40.8%       1077 ±  5%  interrupts.CPU59.RES:Rescheduling_interrupts
    477.67 ± 23%     +97.7%     944.25 ±  9%  interrupts.CPU59.TLB:TLB_shootdowns
      4121 ±  7%     +19.7%       4932 ±  4%  interrupts.CPU6.CAL:Function_call_interrupts
      5158 ±  4%     -31.8%       3518 ± 25%  interrupts.CPU6.NMI:Non-maskable_interrupts
      5158 ±  4%     -31.8%       3518 ± 25%  interrupts.CPU6.PMI:Performance_monitoring_interrupts
    735.33 ± 10%     +48.5%       1091 ±  5%  interrupts.CPU6.RES:Rescheduling_interrupts
    535.33 ± 13%     +72.5%     923.25 ± 14%  interrupts.CPU6.TLB:TLB_shootdowns
      4122 ±  4%     +32.7%       5471 ± 18%  interrupts.CPU60.CAL:Function_call_interrupts
    746.67 ±  4%     +48.7%       1110 ±  4%  interrupts.CPU60.RES:Rescheduling_interrupts
    496.00 ± 23%     +92.2%     953.25 ± 13%  interrupts.CPU60.TLB:TLB_shootdowns
      4022 ±  4%     +33.7%       5376 ± 14%  interrupts.CPU61.CAL:Function_call_interrupts
      5190 ±  4%     -34.9%       3378 ± 24%  interrupts.CPU61.NMI:Non-maskable_interrupts
      5190 ±  4%     -34.9%       3378 ± 24%  interrupts.CPU61.PMI:Performance_monitoring_interrupts
    734.33 ±  4%     +48.2%       1088 ±  2%  interrupts.CPU61.RES:Rescheduling_interrupts
    484.67 ± 15%    +109.0%       1013 ±  9%  interrupts.CPU61.TLB:TLB_shootdowns
      3917 ±  5%     +26.4%       4953 ±  3%  interrupts.CPU62.CAL:Function_call_interrupts
      5189 ±  4%     -32.8%       3489 ± 25%  interrupts.CPU62.NMI:Non-maskable_interrupts
      5189 ±  4%     -32.8%       3489 ± 25%  interrupts.CPU62.PMI:Performance_monitoring_interrupts
    778.00 ±  3%     +42.6%       1109 ±  2%  interrupts.CPU62.RES:Rescheduling_interrupts
    486.33 ± 23%    +110.0%       1021 ± 17%  interrupts.CPU62.TLB:TLB_shootdowns
      4163 ±  8%     +20.8%       5029        interrupts.CPU63.CAL:Function_call_interrupts
      5231 ±  2%     -34.6%       3419 ± 24%  interrupts.CPU63.NMI:Non-maskable_interrupts
      5231 ±  2%     -34.6%       3419 ± 24%  interrupts.CPU63.PMI:Performance_monitoring_interrupts
    775.67 ±  6%     +39.5%       1082        interrupts.CPU63.RES:Rescheduling_interrupts
    491.00 ± 22%     +95.8%     961.25 ± 16%  interrupts.CPU63.TLB:TLB_shootdowns
      4016 ±  2%     +24.2%       4990 ±  3%  interrupts.CPU64.CAL:Function_call_interrupts
      5129 ±  5%     -42.0%       2973 ± 36%  interrupts.CPU64.NMI:Non-maskable_interrupts
      5129 ±  5%     -42.0%       2973 ± 36%  interrupts.CPU64.PMI:Performance_monitoring_interrupts
    757.67 ±  4%     +47.7%       1119 ±  3%  interrupts.CPU64.RES:Rescheduling_interrupts
    453.67 ± 11%    +119.8%     997.00 ± 11%  interrupts.CPU64.TLB:TLB_shootdowns
      3854 ±  2%     +26.3%       4868 ±  7%  interrupts.CPU65.CAL:Function_call_interrupts
    767.33 ±  7%     +37.7%       1056 ±  3%  interrupts.CPU65.RES:Rescheduling_interrupts
    519.67 ± 14%     +85.3%     962.75 ± 13%  interrupts.CPU65.TLB:TLB_shootdowns
      3915 ±  8%     +24.8%       4888 ±  3%  interrupts.CPU66.CAL:Function_call_interrupts
      5199 ±  3%     -34.4%       3409 ± 25%  interrupts.CPU66.NMI:Non-maskable_interrupts
      5199 ±  3%     -34.4%       3409 ± 25%  interrupts.CPU66.PMI:Performance_monitoring_interrupts
    712.67 ±  3%     +56.9%       1118 ±  6%  interrupts.CPU66.RES:Rescheduling_interrupts
    431.67 ± 30%    +138.8%       1030 ± 14%  interrupts.CPU66.TLB:TLB_shootdowns
      4026 ±  9%     +21.0%       4870 ±  3%  interrupts.CPU67.CAL:Function_call_interrupts
      5157 ±  5%     -23.4%       3950 ±  9%  interrupts.CPU67.NMI:Non-maskable_interrupts
      5157 ±  5%     -23.4%       3950 ±  9%  interrupts.CPU67.PMI:Performance_monitoring_interrupts
    671.00           +56.9%       1053 ±  2%  interrupts.CPU67.RES:Rescheduling_interrupts
    489.67 ± 16%     +99.6%     977.50 ± 12%  interrupts.CPU67.TLB:TLB_shootdowns
      4034 ±  4%     +22.0%       4921 ±  2%  interrupts.CPU68.CAL:Function_call_interrupts
      5175 ±  4%     -31.2%       3561 ± 30%  interrupts.CPU68.NMI:Non-maskable_interrupts
      5175 ±  4%     -31.2%       3561 ± 30%  interrupts.CPU68.PMI:Performance_monitoring_interrupts
    709.00 ±  4%     +56.2%       1107 ±  3%  interrupts.CPU68.RES:Rescheduling_interrupts
    493.00 ± 15%     +95.8%     965.25 ± 12%  interrupts.CPU68.TLB:TLB_shootdowns
      4014 ± 10%     +24.6%       5001 ±  2%  interrupts.CPU69.CAL:Function_call_interrupts
      5152 ±  4%     -32.5%       3476 ± 25%  interrupts.CPU69.NMI:Non-maskable_interrupts
      5152 ±  4%     -32.5%       3476 ± 25%  interrupts.CPU69.PMI:Performance_monitoring_interrupts
    717.33 ±  3%     +50.3%       1078 ±  7%  interrupts.CPU69.RES:Rescheduling_interrupts
    434.67 ± 26%    +123.0%     969.25 ±  8%  interrupts.CPU69.TLB:TLB_shootdowns
      3972 ±  8%     +23.1%       4892        interrupts.CPU7.CAL:Function_call_interrupts
    776.67 ±  5%     +40.6%       1091 ±  4%  interrupts.CPU7.RES:Rescheduling_interrupts
    467.33 ± 11%    +102.8%     947.75 ± 16%  interrupts.CPU7.TLB:TLB_shootdowns
      4068 ± 11%     +26.2%       5134        interrupts.CPU70.CAL:Function_call_interrupts
      5188 ±  4%     -42.6%       2975 ± 37%  interrupts.CPU70.NMI:Non-maskable_interrupts
      5188 ±  4%     -42.6%       2975 ± 37%  interrupts.CPU70.PMI:Performance_monitoring_interrupts
    718.00 ±  4%     +54.3%       1107 ±  2%  interrupts.CPU70.RES:Rescheduling_interrupts
    494.00 ± 11%    +104.5%       1010 ±  6%  interrupts.CPU70.TLB:TLB_shootdowns
      3920 ±  4%     +29.5%       5078 ±  4%  interrupts.CPU71.CAL:Function_call_interrupts
      5112 ±  4%     -23.3%       3920 ± 11%  interrupts.CPU71.NMI:Non-maskable_interrupts
      5112 ±  4%     -23.3%       3920 ± 11%  interrupts.CPU71.PMI:Performance_monitoring_interrupts
    667.67           +64.9%       1101 ±  5%  interrupts.CPU71.RES:Rescheduling_interrupts
    473.00 ± 13%    +103.8%     963.75 ± 13%  interrupts.CPU71.TLB:TLB_shootdowns
      3913 ±  3%     +26.8%       4963 ±  2%  interrupts.CPU72.CAL:Function_call_interrupts
      5206 ±  3%     -24.5%       3932 ± 10%  interrupts.CPU72.NMI:Non-maskable_interrupts
      5206 ±  3%     -24.5%       3932 ± 10%  interrupts.CPU72.PMI:Performance_monitoring_interrupts
    811.67 ±  3%     +33.3%       1081 ±  4%  interrupts.CPU72.RES:Rescheduling_interrupts
      3939 ±  3%     +26.0%       4962 ±  6%  interrupts.CPU73.CAL:Function_call_interrupts
      5184 ±  2%     -34.3%       3408 ± 25%  interrupts.CPU73.NMI:Non-maskable_interrupts
      5184 ±  2%     -34.3%       3408 ± 25%  interrupts.CPU73.PMI:Performance_monitoring_interrupts
    763.00 ±  4%     +40.6%       1072 ±  4%  interrupts.CPU73.RES:Rescheduling_interrupts
    570.00 ±  5%     +97.1%       1123 ± 25%  interrupts.CPU73.TLB:TLB_shootdowns
      4069 ±  6%     +21.7%       4954 ±  3%  interrupts.CPU74.CAL:Function_call_interrupts
      5223 ±  3%     -23.9%       3972 ± 10%  interrupts.CPU74.NMI:Non-maskable_interrupts
      5223 ±  3%     -23.9%       3972 ± 10%  interrupts.CPU74.PMI:Performance_monitoring_interrupts
    715.33           +53.9%       1101 ±  5%  interrupts.CPU74.RES:Rescheduling_interrupts
    526.00 ± 14%     +90.9%       1004 ± 11%  interrupts.CPU74.TLB:TLB_shootdowns
      4034 ± 10%     +21.5%       4900 ±  4%  interrupts.CPU75.CAL:Function_call_interrupts
      5241 ±  2%     -42.9%       2995 ± 37%  interrupts.CPU75.NMI:Non-maskable_interrupts
      5241 ±  2%     -42.9%       2995 ± 37%  interrupts.CPU75.PMI:Performance_monitoring_interrupts
    712.00 ±  2%     +49.6%       1065 ±  6%  interrupts.CPU75.RES:Rescheduling_interrupts
      4203 ±  8%     +18.8%       4995 ±  5%  interrupts.CPU76.CAL:Function_call_interrupts
      5216 ±  2%     -32.4%       3525 ± 31%  interrupts.CPU76.NMI:Non-maskable_interrupts
      5216 ±  2%     -32.4%       3525 ± 31%  interrupts.CPU76.PMI:Performance_monitoring_interrupts
    719.00 ±  2%     +44.5%       1039 ±  5%  interrupts.CPU76.RES:Rescheduling_interrupts
    488.00 ± 10%     +87.1%     913.25 ±  9%  interrupts.CPU76.TLB:TLB_shootdowns
      3955 ±  7%     +23.9%       4901 ±  3%  interrupts.CPU77.CAL:Function_call_interrupts
      5224 ±  3%     -24.5%       3944 ± 11%  interrupts.CPU77.NMI:Non-maskable_interrupts
      5224 ±  3%     -24.5%       3944 ± 11%  interrupts.CPU77.PMI:Performance_monitoring_interrupts
    703.67 ±  8%     +50.9%       1062 ±  3%  interrupts.CPU77.RES:Rescheduling_interrupts
    466.67 ±  7%    +125.8%       1053 ± 13%  interrupts.CPU77.TLB:TLB_shootdowns
      4189 ±  6%     +15.8%       4852 ±  6%  interrupts.CPU78.CAL:Function_call_interrupts
      5190 ±  4%     -33.4%       3455 ± 24%  interrupts.CPU78.NMI:Non-maskable_interrupts
      5190 ±  4%     -33.4%       3455 ± 24%  interrupts.CPU78.PMI:Performance_monitoring_interrupts
    706.00           +49.5%       1055 ±  4%  interrupts.CPU78.RES:Rescheduling_interrupts
    442.67 ±  8%    +135.9%       1044 ± 15%  interrupts.CPU78.TLB:TLB_shootdowns
      3902 ±  3%     +24.7%       4865 ±  3%  interrupts.CPU79.CAL:Function_call_interrupts
      5225 ±  3%     -35.1%       3390 ± 24%  interrupts.CPU79.NMI:Non-maskable_interrupts
      5225 ±  3%     -35.1%       3390 ± 24%  interrupts.CPU79.PMI:Performance_monitoring_interrupts
    704.67 ±  4%     +58.3%       1115 ±  7%  interrupts.CPU79.RES:Rescheduling_interrupts
    444.00 ± 13%    +111.1%     937.25 ± 11%  interrupts.CPU79.TLB:TLB_shootdowns
      4089 ±  4%     +19.8%       4898        interrupts.CPU8.CAL:Function_call_interrupts
      5181 ±  4%     -22.3%       4024 ±  5%  interrupts.CPU8.NMI:Non-maskable_interrupts
      5181 ±  4%     -22.3%       4024 ±  5%  interrupts.CPU8.PMI:Performance_monitoring_interrupts
    785.33 ±  4%     +41.3%       1110 ±  6%  interrupts.CPU8.RES:Rescheduling_interrupts
    480.00 ±  9%     +94.0%     931.00 ± 17%  interrupts.CPU8.TLB:TLB_shootdowns
      4093 ±  6%     +22.6%       5018 ±  4%  interrupts.CPU80.CAL:Function_call_interrupts
    721.33 ±  5%     +44.9%       1045 ±  2%  interrupts.CPU80.RES:Rescheduling_interrupts
    485.33 ± 10%    +101.9%     980.00 ±  6%  interrupts.CPU80.TLB:TLB_shootdowns
      4059 ±  9%     +19.3%       4843 ±  4%  interrupts.CPU81.CAL:Function_call_interrupts
      5243 ±  3%     -25.7%       3894 ± 10%  interrupts.CPU81.NMI:Non-maskable_interrupts
      5243 ±  3%     -25.7%       3894 ± 10%  interrupts.CPU81.PMI:Performance_monitoring_interrupts
    689.67 ±  7%     +53.0%       1055 ±  7%  interrupts.CPU81.RES:Rescheduling_interrupts
    553.67 ± 16%     +87.9%       1040 ± 13%  interrupts.CPU81.TLB:TLB_shootdowns
      3950 ±  8%     +23.1%       4863 ±  6%  interrupts.CPU82.CAL:Function_call_interrupts
      5207 ±  3%     -33.8%       3447 ± 25%  interrupts.CPU82.NMI:Non-maskable_interrupts
      5207 ±  3%     -33.8%       3447 ± 25%  interrupts.CPU82.PMI:Performance_monitoring_interrupts
    723.33           +45.0%       1048 ±  2%  interrupts.CPU82.RES:Rescheduling_interrupts
    424.67 ± 12%    +143.4%       1033 ± 11%  interrupts.CPU82.TLB:TLB_shootdowns
      4227 ±  9%     +20.3%       5085 ±  6%  interrupts.CPU83.CAL:Function_call_interrupts
      5224 ±  3%     -42.6%       2998 ± 38%  interrupts.CPU83.NMI:Non-maskable_interrupts
      5224 ±  3%     -42.6%       2998 ± 38%  interrupts.CPU83.PMI:Performance_monitoring_interrupts
    690.00 ±  7%     +57.2%       1084 ±  3%  interrupts.CPU83.RES:Rescheduling_interrupts
    437.33 ±  9%    +170.6%       1183 ± 19%  interrupts.CPU83.TLB:TLB_shootdowns
      4122 ± 10%     +19.3%       4918 ±  3%  interrupts.CPU84.CAL:Function_call_interrupts
      5236 ±  3%     -44.5%       2906 ± 29%  interrupts.CPU84.NMI:Non-maskable_interrupts
      5236 ±  3%     -44.5%       2906 ± 29%  interrupts.CPU84.PMI:Performance_monitoring_interrupts
    714.00 ±  2%     +49.4%       1066 ±  4%  interrupts.CPU84.RES:Rescheduling_interrupts
    460.00 ± 17%    +124.9%       1034 ± 11%  interrupts.CPU84.TLB:TLB_shootdowns
      4072 ±  5%     +19.5%       4864 ±  4%  interrupts.CPU85.CAL:Function_call_interrupts
      5256 ±  3%     -24.5%       3967 ±  9%  interrupts.CPU85.NMI:Non-maskable_interrupts
      5256 ±  3%     -24.5%       3967 ±  9%  interrupts.CPU85.PMI:Performance_monitoring_interrupts
    696.67 ±  5%     +53.2%       1067 ±  5%  interrupts.CPU85.RES:Rescheduling_interrupts
    445.67 ± 13%    +112.0%     945.00 ±  2%  interrupts.CPU85.TLB:TLB_shootdowns
      4091 ±  3%     +21.3%       4964 ±  4%  interrupts.CPU86.CAL:Function_call_interrupts
    699.33 ±  5%     +56.4%       1093 ±  4%  interrupts.CPU86.RES:Rescheduling_interrupts
    466.00 ± 14%    +126.0%       1053 ±  4%  interrupts.CPU86.TLB:TLB_shootdowns
      4003 ±  8%     +25.3%       5015 ±  4%  interrupts.CPU87.CAL:Function_call_interrupts
    687.00 ±  3%     +54.1%       1058 ±  5%  interrupts.CPU87.RES:Rescheduling_interrupts
    474.33 ± 18%    +116.1%       1025 ±  9%  interrupts.CPU87.TLB:TLB_shootdowns
      4087 ±  8%     +21.9%       4982 ±  3%  interrupts.CPU88.CAL:Function_call_interrupts
    695.67           +48.5%       1033 ±  2%  interrupts.CPU88.RES:Rescheduling_interrupts
    482.00 ± 12%    +114.2%       1032 ±  7%  interrupts.CPU88.TLB:TLB_shootdowns
      3940 ±  8%     +25.5%       4944 ±  5%  interrupts.CPU89.CAL:Function_call_interrupts
      5209 ±  3%     -25.2%       3895 ± 10%  interrupts.CPU89.NMI:Non-maskable_interrupts
      5209 ±  3%     -25.2%       3895 ± 10%  interrupts.CPU89.PMI:Performance_monitoring_interrupts
    695.67 ±  4%     +51.6%       1054 ±  4%  interrupts.CPU89.RES:Rescheduling_interrupts
    434.00 ± 15%    +131.6%       1005 ±  9%  interrupts.CPU89.TLB:TLB_shootdowns
      3991 ±  2%     +18.5%       4728 ±  3%  interrupts.CPU9.CAL:Function_call_interrupts
      5149 ±  5%     -33.6%       3418 ± 25%  interrupts.CPU9.NMI:Non-maskable_interrupts
      5149 ±  5%     -33.6%       3418 ± 25%  interrupts.CPU9.PMI:Performance_monitoring_interrupts
    704.67 ±  7%     +56.2%       1100 ±  4%  interrupts.CPU9.RES:Rescheduling_interrupts
    433.67 ±  8%    +107.6%     900.25 ± 12%  interrupts.CPU9.TLB:TLB_shootdowns
      4145 ±  6%     +17.4%       4868 ±  6%  interrupts.CPU90.CAL:Function_call_interrupts
      5217 ±  3%     -42.9%       2977 ± 40%  interrupts.CPU90.NMI:Non-maskable_interrupts
      5217 ±  3%     -42.9%       2977 ± 40%  interrupts.CPU90.PMI:Performance_monitoring_interrupts
    672.33 ±  4%     +61.4%       1085 ±  2%  interrupts.CPU90.RES:Rescheduling_interrupts
    491.33 ± 14%     +90.1%     934.00 ±  9%  interrupts.CPU90.TLB:TLB_shootdowns
      4304 ±  7%     +17.4%       5051 ±  3%  interrupts.CPU91.CAL:Function_call_interrupts
    799.00 ±  4%     +34.7%       1076 ±  3%  interrupts.CPU91.RES:Rescheduling_interrupts
    458.33 ± 13%    +112.6%     974.50 ±  3%  interrupts.CPU91.TLB:TLB_shootdowns
      3978 ±  4%     +21.1%       4816 ±  3%  interrupts.CPU92.CAL:Function_call_interrupts
      5190 ±  4%     -54.3%       2371 ± 21%  interrupts.CPU92.NMI:Non-maskable_interrupts
      5190 ±  4%     -54.3%       2371 ± 21%  interrupts.CPU92.PMI:Performance_monitoring_interrupts
    648.00           +66.6%       1079 ±  4%  interrupts.CPU92.RES:Rescheduling_interrupts
    470.67 ± 14%     +99.7%     940.00 ± 17%  interrupts.CPU92.TLB:TLB_shootdowns
      3937 ±  6%     +23.5%       4863 ±  5%  interrupts.CPU93.CAL:Function_call_interrupts
      5221 ±  3%     -35.6%       3365 ± 23%  interrupts.CPU93.NMI:Non-maskable_interrupts
      5221 ±  3%     -35.6%       3365 ± 23%  interrupts.CPU93.PMI:Performance_monitoring_interrupts
    677.67 ±  6%     +53.6%       1041 ±  5%  interrupts.CPU93.RES:Rescheduling_interrupts
    481.00 ±  4%    +123.9%       1077 ±  4%  interrupts.CPU93.TLB:TLB_shootdowns
      4005 ±  5%     +22.8%       4919 ±  6%  interrupts.CPU94.CAL:Function_call_interrupts
    648.00 ±  2%     +61.7%       1047 ±  6%  interrupts.CPU94.RES:Rescheduling_interrupts
    469.67 ±  9%    +103.2%     954.25 ± 17%  interrupts.CPU94.TLB:TLB_shootdowns
      4039 ±  2%     +26.0%       5088 ±  5%  interrupts.CPU95.CAL:Function_call_interrupts
    664.00 ±  8%     +65.4%       1098 ±  8%  interrupts.CPU95.RES:Rescheduling_interrupts
    458.00 ± 18%    +119.0%       1003 ±  8%  interrupts.CPU95.TLB:TLB_shootdowns
      3941 ±  2%     +20.5%       4750 ±  3%  interrupts.CPU96.CAL:Function_call_interrupts
      5213 ±  5%     -26.6%       3824 ±  9%  interrupts.CPU96.NMI:Non-maskable_interrupts
      5213 ±  5%     -26.6%       3824 ±  9%  interrupts.CPU96.PMI:Performance_monitoring_interrupts
    707.67 ±  4%     +69.0%       1196 ±  4%  interrupts.CPU96.RES:Rescheduling_interrupts
    453.00 ±  5%    +111.2%     956.75 ±  9%  interrupts.CPU96.TLB:TLB_shootdowns
      3892 ±  3%     +29.5%       5041 ±  8%  interrupts.CPU97.CAL:Function_call_interrupts
      5166 ±  4%     -25.1%       3867 ±  9%  interrupts.CPU97.NMI:Non-maskable_interrupts
      5166 ±  4%     -25.1%       3867 ±  9%  interrupts.CPU97.PMI:Performance_monitoring_interrupts
    755.67 ±  8%     +55.6%       1175 ±  5%  interrupts.CPU97.RES:Rescheduling_interrupts
    487.00 ± 10%     +86.1%     906.25 ±  8%  interrupts.CPU97.TLB:TLB_shootdowns
      3869 ±  3%     +23.6%       4782        interrupts.CPU98.CAL:Function_call_interrupts
      5178 ±  5%     -34.9%       3369 ± 24%  interrupts.CPU98.NMI:Non-maskable_interrupts
      5178 ±  5%     -34.9%       3369 ± 24%  interrupts.CPU98.PMI:Performance_monitoring_interrupts
    687.33 ±  5%     +68.1%       1155 ±  4%  interrupts.CPU98.RES:Rescheduling_interrupts
    389.00 ± 13%    +121.1%     860.25 ±  8%  interrupts.CPU98.TLB:TLB_shootdowns
      4000           +21.9%       4876 ±  6%  interrupts.CPU99.CAL:Function_call_interrupts
    719.67           +67.0%       1202 ±  2%  interrupts.CPU99.RES:Rescheduling_interrupts
    463.00 ±  8%     +76.1%     815.50 ± 10%  interrupts.CPU99.TLB:TLB_shootdowns
    913220 ±  2%     -24.1%     693121 ±  9%  interrupts.NMI:Non-maskable_interrupts
    913220 ±  2%     -24.1%     693121 ±  9%  interrupts.PMI:Performance_monitoring_interrupts
    132379           +62.4%     215045        interrupts.RES:Rescheduling_interrupts
     94465 ± 13%     +95.5%     184704 ±  9%  interrupts.TLB:TLB_shootdowns





Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


Thanks,
Oliver Sang


--Dxnq1zWXvFF0Q93v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="config-5.10.0-rc6-00085-g0e8d8f4f1214"

#
# Automatically generated file; DO NOT EDIT.
# Linux/x86_64 5.10.0-rc6 Kernel Configuration
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
CONFIG_USB_RTL8152=y
# CONFIG_USB_LAN78XX is not set
CONFIG_USB_USBNET=y
CONFIG_USB_NET_AX8817X=y
CONFIG_USB_NET_AX88179_178A=y
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
CONFIG_INFINIBAND_VIRT_DMA=y
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
CONFIG_RCU_SCALE_TEST=m
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

--Dxnq1zWXvFF0Q93v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=job-script

#!/bin/sh

export_top_env()
{
	export suite='stress-ng'
	export testcase='stress-ng'
	export category='benchmark'
	export nr_threads=48
	export testtime=30
	export job_origin='/lkp-src/allot/cyclic:p1:linux-devel:devel-hourly/lkp-ivb-2ep1/stress-ng-part1.yaml'
	export queue_cmdline_keys='branch
commit
queue_at_least_once'
	export queue='validate'
	export testbox='lkp-ivb-2ep1'
	export tbox_group='lkp-ivb-2ep1'
	export kconfig='x86_64-rhel-8.3'
	export submit_id='5fe8e1a54f3e5c3356cc5dfb'
	export job_file='/lkp/jobs/scheduled/lkp-ivb-2ep1/stress-ng-device-performance-1HDD-100%-30s-ucode=0x42e-monitor=0fe5055f-debian-10.4-x86_64-20200603.cgz-0e8d8f4f1214cfbac219d691-20201228-13142-x4jq1k-3.yaml'
	export id='6b108d18e2d2519611514e9c63ef99dc6b880351'
	export queuer_version='/lkp-src'
	export model='Ivy Bridge-EP'
	export nr_node=2
	export nr_cpu=48
	export memory='112G'
	export nr_ssd_partitions=1
	export nr_hdd_partitions=4
	export hdd_partitions='/dev/disk/by-id/ata-WDC_WD1003FBYZ-010FB0_WD-WCAW36795753-part*'
	export ssd_partitions='/dev/disk/by-id/ata-INTEL_SSDSC2BB800G4_PHWL42040057800RGN-part2'
	export rootfs_partition='/dev/disk/by-id/ata-INTEL_SSDSC2BB800G4_PHWL42040057800RGN-part1'
	export brand='Intel(R) Xeon(R) CPU E5-2697 v2 @ 2.70GHz'
	export need_kconfig='CONFIG_BLK_DEV_SD
CONFIG_SCSI
CONFIG_BLOCK=y
CONFIG_SATA_AHCI
CONFIG_SATA_AHCI_PLATFORM
CONFIG_ATA
CONFIG_PCI=y
CONFIG_SECURITY_APPARMOR=y'
	export commit='0e8d8f4f1214cfbac219d6917b5f6460f818bb7c'
	export ucode='0x42e'
	export need_kconfig_hw='CONFIG_IGB=y
CONFIG_SCSI_SAS_LIBSAS
CONFIG_SCSI_ISCI
CONFIG_ATA_PIIX
CONFIG_SCSI_SAS_ATA=y'
	export enqueue_time='2020-12-28 03:33:57 +0800'
	export _id='5fe8e1aa4f3e5c3356cc5dfc'
	export _rt='/result/stress-ng/device-performance-1HDD-100%-30s-ucode=0x42e-monitor=0fe5055f/lkp-ivb-2ep1/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/0e8d8f4f1214cfbac219d6917b5f6460f818bb7c'
	export user='lkp'
	export compiler='gcc-9'
	export LKP_SERVER='internal-lkp-server'
	export head_commit='6e9477dc6064f0f50f4e5d8058d68217fa3f67de'
	export base_commit='2c85ebc57b3e1817b6ce1a6b703928e113a90442'
	export branch='linux-review/Alex-Kogan/Add-NUMA-awareness-to-qspinlock/20201223-135025'
	export rootfs='debian-10.4-x86_64-20200603.cgz'
	export monitor_sha='0fe5055f'
	export result_root='/result/stress-ng/device-performance-1HDD-100%-30s-ucode=0x42e-monitor=0fe5055f/lkp-ivb-2ep1/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/0e8d8f4f1214cfbac219d6917b5f6460f818bb7c/3'
	export scheduler_version='/lkp/lkp/.src-20201225-151409'
	export arch='x86_64'
	export max_uptime=2100
	export initrd='/osimage/debian/debian-10.4-x86_64-20200603.cgz'
	export bootloader_append='root=/dev/ram0
user=lkp
job=/lkp/jobs/scheduled/lkp-ivb-2ep1/stress-ng-device-performance-1HDD-100%-30s-ucode=0x42e-monitor=0fe5055f-debian-10.4-x86_64-20200603.cgz-0e8d8f4f1214cfbac219d691-20201228-13142-x4jq1k-3.yaml
ARCH=x86_64
kconfig=x86_64-rhel-8.3
branch=linux-review/Alex-Kogan/Add-NUMA-awareness-to-qspinlock/20201223-135025
commit=0e8d8f4f1214cfbac219d6917b5f6460f818bb7c
BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3/gcc-9/0e8d8f4f1214cfbac219d6917b5f6460f818bb7c/vmlinuz-5.10.0-rc6-00085-g0e8d8f4f1214
max_uptime=2100
RESULT_ROOT=/result/stress-ng/device-performance-1HDD-100%-30s-ucode=0x42e-monitor=0fe5055f/lkp-ivb-2ep1/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/0e8d8f4f1214cfbac219d6917b5f6460f818bb7c/3
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
	export modules_initrd='/pkg/linux/x86_64-rhel-8.3/gcc-9/0e8d8f4f1214cfbac219d6917b5f6460f818bb7c/modules.cgz'
	export bm_initrd='/osimage/deps/debian-10.4-x86_64-20200603.cgz/run-ipconfig_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/lkp_20201211.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/rsync-rootfs_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/stress-ng_20201110.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/stress-ng-x86_64-0.11-06_20201110.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/mpstat_20200714.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/perf_20201126.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/perf-x86_64-fa02fcd94b0c-1_20201126.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/sar-x86_64-34c92ae-1_20200702.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/hw_20200715.cgz'
	export ucode_initrd='/osimage/ucode/intel-ucode-20201117.cgz'
	export lkp_initrd='/osimage/user/lkp/lkp-x86_64.cgz'
	export site='inn'
	export LKP_CGI_PORT=80
	export LKP_CIFS_PORT=139
	export last_kernel='4.20.0'
	export repeat_to=4
	export bad_samples='329752.82
314843.25
313453.2'
	export queue_at_least_once=1
	export kernel='/pkg/linux/x86_64-rhel-8.3/gcc-9/0e8d8f4f1214cfbac219d6917b5f6460f818bb7c/vmlinuz-5.10.0-rc6-00085-g0e8d8f4f1214'
	export dequeue_time='2020-12-28 03:39:46 +0800'
	export job_initrd='/lkp/jobs/scheduled/lkp-ivb-2ep1/stress-ng-device-performance-1HDD-100%-30s-ucode=0x42e-monitor=0fe5055f-debian-10.4-x86_64-20200603.cgz-0e8d8f4f1214cfbac219d691-20201228-13142-x4jq1k-3.cgz'

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

	run_setup nr_hdd=1 $LKP_SRC/setup/disk

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
	run_monitor $LKP_SRC/monitors/wrapper oom-killer
	run_monitor $LKP_SRC/monitors/plain/watchdog

	run_test class='device' $LKP_SRC/tests/wrapper stress-ng
}

extract_stats()
{
	export stats_part_begin=
	export stats_part_end=

	$LKP_SRC/stats/wrapper stress-ng
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

	$LKP_SRC/stats/wrapper time stress-ng.time
	$LKP_SRC/stats/wrapper dmesg
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper last_state
	$LKP_SRC/stats/wrapper stderr
	$LKP_SRC/stats/wrapper time
}

"$@"

--Dxnq1zWXvFF0Q93v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="job.yaml"

---
suite: stress-ng
testcase: stress-ng
category: benchmark
nr_threads: 100%
disk: 1HDD
testtime: 30s
stress-ng:
  class: device
job_origin: "/lkp-src/allot/cyclic:p1:linux-devel:devel-hourly/lkp-ivb-2ep1/stress-ng-part1.yaml"
queue_cmdline_keys:
- branch
- commit
- queue_at_least_once
queue: bisect
testbox: lkp-ivb-2ep1
tbox_group: lkp-ivb-2ep1
kconfig: x86_64-rhel-8.3
submit_id: 5fe8dc304f3e5c329f15c296
job_file: "/lkp/jobs/scheduled/lkp-ivb-2ep1/stress-ng-device-performance-1HDD-100%-30s-ucode=0x42e-monitor=0fe5055f-debian-10.4-x86_64-20200603.cgz-0e8d8f4f1214cfbac219d691-20201228-12959-11mj2l4-1.yaml"
id: f395b60774d22ec31d72c8d12235540c32c6c9c9
queuer_version: "/lkp-src"
model: Ivy Bridge-EP
nr_node: 2
nr_cpu: 48
memory: 112G
nr_ssd_partitions: 1
nr_hdd_partitions: 4
hdd_partitions: "/dev/disk/by-id/ata-WDC_WD1003FBYZ-010FB0_WD-WCAW36795753-part*"
ssd_partitions: "/dev/disk/by-id/ata-INTEL_SSDSC2BB800G4_PHWL42040057800RGN-part2"
rootfs_partition: "/dev/disk/by-id/ata-INTEL_SSDSC2BB800G4_PHWL42040057800RGN-part1"
brand: Intel(R) Xeon(R) CPU E5-2697 v2 @ 2.70GHz
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
cpufreq_governor: performance
need_kconfig:
- CONFIG_BLK_DEV_SD
- CONFIG_SCSI
- CONFIG_BLOCK=y
- CONFIG_SATA_AHCI
- CONFIG_SATA_AHCI_PLATFORM
- CONFIG_ATA
- CONFIG_PCI=y
- CONFIG_SECURITY_APPARMOR=y
commit: 0e8d8f4f1214cfbac219d6917b5f6460f818bb7c
ucode: '0x42e'
need_kconfig_hw:
- CONFIG_IGB=y
- CONFIG_SCSI_SAS_LIBSAS
- CONFIG_SCSI_ISCI
- CONFIG_ATA_PIIX
- CONFIG_SCSI_SAS_ATA=y
enqueue_time: 2020-12-28 03:10:40.530973638 +08:00
_id: 5fe8dc354f3e5c329f15c297
_rt: "/result/stress-ng/device-performance-1HDD-100%-30s-ucode=0x42e-monitor=0fe5055f/lkp-ivb-2ep1/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/0e8d8f4f1214cfbac219d6917b5f6460f818bb7c"
user: lkp
compiler: gcc-9
LKP_SERVER: internal-lkp-server
head_commit: 6e9477dc6064f0f50f4e5d8058d68217fa3f67de
base_commit: 2c85ebc57b3e1817b6ce1a6b703928e113a90442
branch: linux-devel/devel-hourly-2020122500
rootfs: debian-10.4-x86_64-20200603.cgz
monitor_sha: 0fe5055f
result_root: "/result/stress-ng/device-performance-1HDD-100%-30s-ucode=0x42e-monitor=0fe5055f/lkp-ivb-2ep1/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/0e8d8f4f1214cfbac219d6917b5f6460f818bb7c/0"
scheduler_version: "/lkp/lkp/.src-20201225-151409"
arch: x86_64
max_uptime: 2100
initrd: "/osimage/debian/debian-10.4-x86_64-20200603.cgz"
bootloader_append:
- root=/dev/ram0
- user=lkp
- job=/lkp/jobs/scheduled/lkp-ivb-2ep1/stress-ng-device-performance-1HDD-100%-30s-ucode=0x42e-monitor=0fe5055f-debian-10.4-x86_64-20200603.cgz-0e8d8f4f1214cfbac219d691-20201228-12959-11mj2l4-1.yaml
- ARCH=x86_64
- kconfig=x86_64-rhel-8.3
- branch=linux-devel/devel-hourly-2020122500
- commit=0e8d8f4f1214cfbac219d6917b5f6460f818bb7c
- BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3/gcc-9/0e8d8f4f1214cfbac219d6917b5f6460f818bb7c/vmlinuz-5.10.0-rc6-00085-g0e8d8f4f1214
- max_uptime=2100
- RESULT_ROOT=/result/stress-ng/device-performance-1HDD-100%-30s-ucode=0x42e-monitor=0fe5055f/lkp-ivb-2ep1/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/0e8d8f4f1214cfbac219d6917b5f6460f818bb7c/0
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
modules_initrd: "/pkg/linux/x86_64-rhel-8.3/gcc-9/0e8d8f4f1214cfbac219d6917b5f6460f818bb7c/modules.cgz"
bm_initrd: "/osimage/deps/debian-10.4-x86_64-20200603.cgz/run-ipconfig_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/lkp_20201211.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/rsync-rootfs_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/stress-ng_20201110.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/stress-ng-x86_64-0.11-06_20201110.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/mpstat_20200714.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/perf_20201126.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/perf-x86_64-fa02fcd94b0c-1_20201126.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/sar-x86_64-34c92ae-1_20200702.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/hw_20200715.cgz"
ucode_initrd: "/osimage/ucode/intel-ucode-20201117.cgz"
lkp_initrd: "/osimage/user/lkp/lkp-x86_64.cgz"
site: inn
LKP_CGI_PORT: 80
LKP_CIFS_PORT: 139
oom-killer: 
watchdog: 
last_kernel: 5.9.0
repeat_to: 2
bad_samples:
- 329752.82
- 314843.25
- 313453.2

#! queue options

#! user overrides
queue_at_least_once: 0

#! schedule options
kernel: "/pkg/linux/x86_64-rhel-8.3/gcc-9/0e8d8f4f1214cfbac219d6917b5f6460f818bb7c/vmlinuz-5.10.0-rc6-00085-g0e8d8f4f1214"
dequeue_time: 2020-12-28 03:13:31.658525688 +08:00

#! /lkp/lkp/.src-20201225-151409/include/site/inn

#! runtime status
job_state: finished
loadavg: 38.59 32.07 13.95 1/539 19753
start_time: '1609096359'
end_time: '1609096543'
version: "/lkp/lkp/.src-20201225-151440:04492474:3e57f6440"

--Dxnq1zWXvFF0Q93v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=reproduce


for cpu_dir in /sys/devices/system/cpu/cpu[0-9]*
do
	online_file="$cpu_dir"/online
	[ -f "$online_file" ] && [ "$(cat "$online_file")" -eq 0 ] && continue

	file="$cpu_dir"/cpufreq/scaling_governor
	[ -f "$file" ] && echo "performance" > "$file"
done

 "stress-ng" "--timeout" "30" "--times" "--verify" "--metrics-brief" "--sequential" "48" "--class" "device" "--exclude" "spawn,exec,swap"

--Dxnq1zWXvFF0Q93v--
