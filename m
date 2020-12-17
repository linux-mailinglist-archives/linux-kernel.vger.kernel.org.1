Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 530B82DCAF8
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 03:25:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727535AbgLQCVr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 21:21:47 -0500
Received: from mga14.intel.com ([192.55.52.115]:23286 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727073AbgLQCVq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 21:21:46 -0500
IronPort-SDR: N9rzZI2H0a8tBWaY6ZuilQ1nfFC9okz7IpQbZLuRgeuGcKJHOCY6m74/RBDszO51s+DhX7d+g9
 Pm0X+7AZ50MQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9837"; a="174407596"
X-IronPort-AV: E=Sophos;i="5.78,425,1599548400"; 
   d="yaml'?scan'208";a="174407596"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2020 18:20:55 -0800
IronPort-SDR: dOIMtvQr6T/wH1LhDoPUztp5DUSmlm6c4Lo86jEKs4X/tqf/fxtScOQSyByAltjNescicu8WOh
 SW+/xiqMAN3A==
X-IronPort-AV: E=Sophos;i="5.78,425,1599548400"; 
   d="yaml'?scan'208";a="560223927"
Received: from xsang-optiplex-9020.sh.intel.com (HELO xsang-OptiPlex-9020) ([10.239.159.140])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2020 18:20:51 -0800
Date:   Thu, 17 Dec 2020 10:34:45 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     Waiman Long <longman@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Davidlohr Bueso <dbueso@suse.de>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com, ying.huang@intel.com, feng.tang@intel.com,
        zhengjun.xing@intel.com
Subject: [locking/rwsem]  2f06f70292:  vm-scalability.throughput 385.1%
 improvement
Message-ID: <20201217023445.GD27932@xsang-OptiPlex-9020>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="ep0oHQY+/Gbo/zt0"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: NeoMutt/20170113 (1.7.2)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ep0oHQY+/Gbo/zt0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit


Greeting,

FYI, we noticed a 385.1% improvement of vm-scalability.throughput due to commit:


commit: 2f06f702925b512a95b95dca3855549c047eef58 ("locking/rwsem: Prevent potential lock starvation")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master


in testcase: vm-scalability
on test machine: 192 threads Intel(R) Xeon(R) Platinum 9242 CPU @ 2.30GHz with 192G memory
with following parameters:

	runtime: 300s
	test: small-allocs-mt
	cpufreq_governor: performance
	ucode: 0x5003003

test-description: The motivation behind this suite is to exercise functions and regions of the mm/ of the Linux kernel which are of interest to us.
test-url: https://git.kernel.org/cgit/linux/kernel/git/wfg/vm-scalability.git/





Details are as below:
-------------------------------------------------------------------------------------------------->


To reproduce:

        git clone https://github.com/intel/lkp-tests.git
        cd lkp-tests
        bin/lkp install job.yaml  # job file is attached in this email
        bin/lkp run     job.yaml

=========================================================================================
compiler/cpufreq_governor/kconfig/rootfs/runtime/tbox_group/test/testcase/ucode:
  gcc-9/performance/x86_64-rhel-8.3/debian-10.4-x86_64-20200603.cgz/300s/lkp-csl-2ap4/small-allocs-mt/vm-scalability/0x5003003

commit: 
  c8fe8b0564 ("locking/rwsem: Pass the current atomic count to rwsem_down_read_slowpath()")
  2f06f70292 ("locking/rwsem: Prevent potential lock starvation")

c8fe8b0564388f41 2f06f702925b512a95b95dca385 
---------------- --------------------------- 
       fail:runs  %reproduction    fail:runs
           |             |             |    
           :4            2%           0:4     perf-profile.children.cycles-pp.error_return
          0:4           29%           1:4     perf-profile.children.cycles-pp.error_entry
           :4            9%           0:4     perf-profile.self.cycles-pp.error_entry
         %stddev     %change         %stddev
             \          |                \  
      1270 ±  2%    +386.1%       6173 ±  3%  vm-scalability.median
    595.12 ±  2%    -584.4       10.74 ± 13%  vm-scalability.stddev%
    244318 ±  2%    +385.1%    1185224 ±  3%  vm-scalability.throughput
    302.47            +2.5%     309.88        vm-scalability.time.elapsed_time
    302.47            +2.5%     309.88        vm-scalability.time.elapsed_time.max
      2794 ± 13%     -29.5%       1969 ±  9%  vm-scalability.time.involuntary_context_switches
  16325540 ±  2%    +384.9%   79166643 ±  3%  vm-scalability.time.minor_page_faults
      1684 ±  6%     -52.0%     809.50 ± 25%  vm-scalability.time.percent_of_cpu_this_job_got
      5064 ±  6%     -55.5%       2255 ± 28%  vm-scalability.time.system_time
     32.75 ±  2%    +676.6%     254.36        vm-scalability.time.user_time
   6129899 ±  2%   +1215.7%   80652041 ±  3%  vm-scalability.time.voluntary_context_switches
  73432051 ±  2%    +385.1%  3.562e+08 ±  3%  vm-scalability.workload
     33.55            -5.7%      31.64 ±  2%  boot-time.boot
      5565            -6.5%       5201 ±  2%  boot-time.idle
  81877350 ± 54%    +124.7%   1.84e+08 ±  4%  cpuidle.C1E.usage
   1274888 ±  9%     -67.6%     413373 ±  3%  cpuidle.POLL.usage
      0.88 ± 10%      +0.5        1.39 ±  2%  mpstat.cpu.all.irq%
      0.08 ±  6%      +0.0        0.10 ±  2%  mpstat.cpu.all.soft%
      8.76 ±  6%      -3.6        5.11 ± 28%  mpstat.cpu.all.sys%
      0.10 ±  2%      +0.5        0.63        mpstat.cpu.all.usr%
     89.75            +3.1%      92.50        vmstat.cpu.id
   1395256           +24.4%    1735292        vmstat.memory.cache
     16.50 ±  3%     -63.6%       6.00 ± 26%  vmstat.procs.r
     42739 ±  2%   +1111.5%     517804 ±  3%  vmstat.system.cs
    378250 ±  3%      +3.5%     391503        vmstat.system.in
    160095 ±  8%    +177.0%     443432 ±  3%  meminfo.Active
    159053 ±  8%    +178.1%     442402 ±  3%  meminfo.Active(anon)
   1273383           +26.7%    1613270        meminfo.Cached
   2228592           +12.1%    2497201        meminfo.Committed_AS
     47452 ±  6%    +163.3%     124931 ±  6%  meminfo.Mapped
   3706975           +33.2%    4939236        meminfo.Memused
     71067 ±  3%    +351.2%     320667 ±  5%  meminfo.PageTables
    459065          +148.7%    1141724 ±  3%  meminfo.SUnreclaim
    274717 ±  5%    +123.7%     614603 ±  3%  meminfo.Shmem
    580430          +117.5%    1262588 ±  2%  meminfo.Slab
     14533           +37.8%      20021        meminfo.max_used_kB
      1819 ± 12%     -21.3%       1433 ±  4%  slabinfo.dmaengine-unmap-16.active_objs
      1819 ± 12%     -21.3%       1433 ±  4%  slabinfo.dmaengine-unmap-16.num_objs
     46889 ±  2%    +171.1%     127126 ±  4%  slabinfo.kmalloc-512.active_objs
    734.75 ±  2%    +171.0%       1991 ±  4%  slabinfo.kmalloc-512.active_slabs
     47056 ±  2%    +170.8%     127447 ±  4%  slabinfo.kmalloc-512.num_objs
    734.75 ±  2%    +171.0%       1991 ±  4%  slabinfo.kmalloc-512.num_slabs
      9979 ±  6%     -12.1%       8772 ±  9%  slabinfo.task_delay_info.active_objs
      9979 ±  6%     -12.1%       8772 ±  9%  slabinfo.task_delay_info.num_objs
    836132 ±  4%    +388.6%    4085102 ±  5%  slabinfo.vm_area_struct.active_objs
     20903 ±  4%    +388.6%     102128 ±  5%  slabinfo.vm_area_struct.active_slabs
    836145 ±  4%    +388.6%    4085150 ±  5%  slabinfo.vm_area_struct.num_objs
     20903 ±  4%    +388.6%     102128 ±  5%  slabinfo.vm_area_struct.num_slabs
      3474 ± 18%     +77.7%       6175 ± 10%  numa-vmstat.node0.nr_mapped
      4736 ± 14%    +344.6%      21057 ± 18%  numa-vmstat.node0.nr_page_table_pages
     34864 ± 13%    +125.8%      78729 ± 18%  numa-vmstat.node0.nr_slab_unreclaimable
      2655 ± 26%    +148.6%       6600 ± 26%  numa-vmstat.node1.nr_mapped
      4416 ±  7%    +373.4%      20907 ± 22%  numa-vmstat.node1.nr_page_table_pages
     25938 ±  8%    +177.8%      72059 ± 15%  numa-vmstat.node1.nr_slab_unreclaimable
     64427           +31.5%      84738 ±  9%  numa-vmstat.node2.nr_file_pages
      2418 ±  7%    +172.1%       6580 ±  9%  numa-vmstat.node2.nr_mapped
      3939 ± 13%    +452.4%      21761 ± 16%  numa-vmstat.node2.nr_page_table_pages
      3903 ± 12%    +487.2%      22923 ± 28%  numa-vmstat.node2.nr_shmem
     24946 ± 12%    +199.3%      74658 ± 11%  numa-vmstat.node2.nr_slab_unreclaimable
    411481 ± 12%     +36.8%     562990 ± 32%  numa-vmstat.node2.numa_local
      3592 ±  6%    +243.4%      12337 ± 18%  numa-vmstat.node3.nr_mapped
      4683 ± 16%    +253.9%      16575 ± 37%  numa-vmstat.node3.nr_page_table_pages
     46224 ± 25%     +69.0%      78102 ± 27%  numa-vmstat.node3.nr_shmem
     39780 ±  8%    +177.3%     110320 ±  3%  proc-vmstat.nr_active_anon
     76433            -6.7%      71321        proc-vmstat.nr_anon_pages
    318685           +26.6%     403466        proc-vmstat.nr_file_pages
    105287            +8.6%     114392        proc-vmstat.nr_inactive_anon
     12065 ±  6%    +162.7%      31701 ±  6%  proc-vmstat.nr_mapped
     17734 ±  4%    +353.2%      80374 ±  5%  proc-vmstat.nr_page_table_pages
     68756 ±  5%    +123.3%     153537 ±  3%  proc-vmstat.nr_shmem
    114763          +148.7%     285464 ±  3%  proc-vmstat.nr_slab_unreclaimable
     39780 ±  8%    +177.3%     110320 ±  3%  proc-vmstat.nr_zone_active_anon
    105287            +8.6%     114392        proc-vmstat.nr_zone_inactive_anon
     19756 ± 20%    +434.5%     105589 ±  6%  proc-vmstat.numa_hint_faults
      8425 ± 79%    +440.0%      45500 ±  7%  proc-vmstat.numa_hint_faults_local
   1462760           +33.6%    1953667        proc-vmstat.numa_hit
   1202814           +40.8%    1693663        proc-vmstat.numa_local
    196698 ±  3%     +98.2%     389913        proc-vmstat.numa_pte_updates
     94418 ±  5%    +160.2%     245708 ±  4%  proc-vmstat.pgactivate
   1605226           +41.5%    2271576        proc-vmstat.pgalloc_normal
  17615093 ±  2%    +358.0%   80681973 ±  3%  proc-vmstat.pgfault
   1601028           +28.4%    2055930 ±  2%  proc-vmstat.pgfree
     13661 ± 17%     +81.6%      24806 ± 11%  numa-meminfo.node0.Mapped
    945549 ± 11%     +29.8%    1227000 ± 14%  numa-meminfo.node0.MemUsed
     18929 ± 15%    +345.6%      84353 ± 18%  numa-meminfo.node0.PageTables
    139433 ± 13%    +125.9%     315020 ± 18%  numa-meminfo.node0.SUnreclaim
    181496 ± 18%     +92.8%     349907 ± 19%  numa-meminfo.node0.Slab
     10633 ± 25%    +149.7%      26547 ± 27%  numa-meminfo.node1.Mapped
    855893 ± 15%     +43.2%    1225970 ± 13%  numa-meminfo.node1.MemUsed
     17645 ±  7%    +374.6%      83749 ± 23%  numa-meminfo.node1.PageTables
    103731 ±  8%    +178.0%     288333 ± 15%  numa-meminfo.node1.SUnreclaim
    132718 ± 14%    +142.4%     321698 ± 14%  numa-meminfo.node1.Slab
    257732           +31.5%     338901 ±  9%  numa-meminfo.node2.FilePages
      9545 ±  6%    +177.8%      26522 ±  9%  numa-meminfo.node2.Mapped
    822556 ±  5%     +42.3%    1170402 ±  8%  numa-meminfo.node2.MemUsed
     15737 ± 13%    +453.8%      87154 ± 16%  numa-meminfo.node2.PageTables
     99753 ± 12%    +199.5%     298733 ± 11%  numa-meminfo.node2.SUnreclaim
     15639 ± 12%    +486.0%      91645 ± 28%  numa-meminfo.node2.Shmem
    117075 ± 11%    +176.9%     324165 ±  8%  numa-meminfo.node2.Slab
     13738 ±  8%    +260.9%      49579 ± 18%  numa-meminfo.node3.Mapped
     18716 ± 16%    +254.4%      66331 ± 37%  numa-meminfo.node3.PageTables
    184851 ± 25%     +68.8%     312075 ± 27%  numa-meminfo.node3.Shmem
      5400 ± 23%     +48.3%       8006 ±  4%  sched_debug.cfs_rq:/.load.avg
    120624 ± 44%    +119.5%     264763 ± 37%  sched_debug.cfs_rq:/.load.max
     20671 ± 18%     +87.1%      38682 ± 16%  sched_debug.cfs_rq:/.load.stddev
     11.26 ±101%     -67.6%       3.65 ± 14%  sched_debug.cfs_rq:/.load_avg.avg
    254570 ± 11%     -73.2%      68331 ± 22%  sched_debug.cfs_rq:/.min_vruntime.avg
    328095 ±  8%     -64.6%     116031 ± 21%  sched_debug.cfs_rq:/.min_vruntime.max
    174260 ± 13%     -72.6%      47761 ± 29%  sched_debug.cfs_rq:/.min_vruntime.min
     30101 ± 26%     -67.4%       9801 ± 56%  sched_debug.cfs_rq:/.min_vruntime.stddev
      0.07 ± 20%     -29.9%       0.05 ± 24%  sched_debug.cfs_rq:/.nr_running.avg
     77.55 ±  9%     -45.8%      42.01 ± 15%  sched_debug.cfs_rq:/.runnable_avg.avg
    777.60 ±  4%      -9.9%     700.54 ±  2%  sched_debug.cfs_rq:/.runnable_avg.max
    151.29           -49.9%      75.85 ±  5%  sched_debug.cfs_rq:/.runnable_avg.stddev
     60350 ± 10%     -98.3%       1050 ±909%  sched_debug.cfs_rq:/.spread0.avg
    133886 ±  6%     -63.6%      48756 ±  9%  sched_debug.cfs_rq:/.spread0.max
     30097 ± 26%     -67.4%       9801 ± 56%  sched_debug.cfs_rq:/.spread0.stddev
     77.51 ±  9%     -45.9%      41.96 ± 15%  sched_debug.cfs_rq:/.util_avg.avg
    777.55 ±  4%     -10.1%     699.00 ±  2%  sched_debug.cfs_rq:/.util_avg.max
    151.24           -49.9%      75.77 ±  5%  sched_debug.cfs_rq:/.util_avg.stddev
     10.02 ± 22%     -67.8%       3.22 ± 24%  sched_debug.cfs_rq:/.util_est_enqueued.avg
    532.40 ± 11%     -49.6%     268.58 ±  9%  sched_debug.cfs_rq:/.util_est_enqueued.max
     57.42 ± 12%     -60.3%      22.78 ±  7%  sched_debug.cfs_rq:/.util_est_enqueued.stddev
    887243           -24.1%     673329 ±  2%  sched_debug.cpu.avg_idle.avg
     17254 ± 67%    +542.7%     110888 ± 24%  sched_debug.cpu.avg_idle.min
    198232 ±  7%     -19.9%     158800 ± 14%  sched_debug.cpu.avg_idle.stddev
      0.00 ± 15%     -25.4%       0.00 ± 10%  sched_debug.cpu.next_balance.stddev
      0.07 ± 16%     -29.0%       0.05 ± 23%  sched_debug.cpu.nr_running.avg
     28419 ±  4%   +1326.2%     405307 ± 11%  sched_debug.cpu.nr_switches.avg
     44802 ±  8%   +1006.0%     495514 ± 19%  sched_debug.cpu.nr_switches.max
     19592 ±  4%   +1273.1%     269028 ± 31%  sched_debug.cpu.nr_switches.min
      4396 ± 34%   +1593.2%      74447 ± 92%  sched_debug.cpu.nr_switches.stddev
      0.01 ±  9%     -26.1%       0.01 ±  5%  perf-sched.sch_delay.avg.ms.devkmsg_read.vfs_read.ksys_read.do_syscall_64
      0.01 ± 11%     +33.3%       0.01 ± 15%  perf-sched.sch_delay.avg.ms.do_nanosleep.hrtimer_nanosleep.__x64_sys_nanosleep.do_syscall_64
      0.01 ± 20%     +40.9%       0.01 ± 10%  perf-sched.sch_delay.avg.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
      0.01 ± 11%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.rwsem_down_read_slowpath.isra.0.do_user_addr_fault.exc_page_fault
      0.01           +70.0%       0.01 ± 10%  perf-sched.sch_delay.avg.ms.rwsem_down_write_slowpath.down_write_killable.vm_mmap_pgoff.ksys_mmap_pgoff
      0.01 ±  9%     +25.7%       0.01 ±  6%  perf-sched.sch_delay.avg.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      0.00 ± 47%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop.0.do_sys_poll
      0.01           +20.0%       0.01        perf-sched.sch_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork
      0.01 ± 20%     -30.2%       0.01 ±  4%  perf-sched.sch_delay.max.ms.devkmsg_read.vfs_read.ksys_read.do_syscall_64
      0.01 ± 16%     +61.3%       0.01 ±  3%  perf-sched.sch_delay.max.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
      7.06 ± 61%    -100.0%       0.00        perf-sched.sch_delay.max.ms.rwsem_down_read_slowpath.isra.0.do_user_addr_fault.exc_page_fault
      4.15 ± 57%     +64.7%       6.83 ± 14%  perf-sched.sch_delay.max.ms.rwsem_down_write_slowpath.down_write_killable.vm_mmap_pgoff.ksys_mmap_pgoff
     12.99 ±  9%     -69.4%       3.97 ±  4%  perf-sched.total_wait_and_delay.average.ms
    446342 ±  9%    +230.9%    1476918 ±  4%  perf-sched.total_wait_and_delay.count.ms
     12.98 ±  9%     -69.5%       3.96 ±  4%  perf-sched.total_wait_time.average.ms
     55.23 ± 55%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.exit_to_user_mode_prepare.syscall_exit_to_user_mode.entry_SYSCALL_64_after_hwframe.[unknown]
      4.98 ± 11%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.rwsem_down_read_slowpath.isra.0.do_user_addr_fault.exc_page_fault
      2.32 ± 10%     -41.2%       1.36 ±  4%  perf-sched.wait_and_delay.avg.ms.rwsem_down_write_slowpath.down_write_killable.vm_mmap_pgoff.ksys_mmap_pgoff
    226.67 ± 48%     -82.8%      39.00 ±  4%  perf-sched.wait_and_delay.avg.ms.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop.0.do_sys_poll
      9.75 ± 15%    -100.0%       0.00        perf-sched.wait_and_delay.count.exit_to_user_mode_prepare.syscall_exit_to_user_mode.entry_SYSCALL_64_after_hwframe.[unknown]
    328127 ± 11%    -100.0%       0.00        perf-sched.wait_and_delay.count.rwsem_down_read_slowpath.isra.0.do_user_addr_fault.exc_page_fault
    105951 ±  8%     +73.4%     183678 ±  4%  perf-sched.wait_and_delay.count.rwsem_down_write_slowpath.down_write_killable.vm_mmap_pgoff.ksys_mmap_pgoff
     93.00 ± 40%    +345.2%     414.00 ±  4%  perf-sched.wait_and_delay.count.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop.0.do_sys_poll
    232.31 ± 24%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.exit_to_user_mode_prepare.syscall_exit_to_user_mode.entry_SYSCALL_64_after_hwframe.[unknown]
    306.39 ± 10%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.rwsem_down_read_slowpath.isra.0.do_user_addr_fault.exc_page_fault
    301.07 ±  8%     -97.7%       6.83 ± 14%  perf-sched.wait_and_delay.max.ms.rwsem_down_write_slowpath.down_write_killable.vm_mmap_pgoff.ksys_mmap_pgoff
      1.36 ±  7%     -13.1%       1.18 ±  3%  perf-sched.wait_time.avg.ms.devkmsg_read.vfs_read.ksys_read.do_syscall_64
      1.37 ±  7%     -13.3%       1.19 ±  3%  perf-sched.wait_time.avg.ms.do_syslog.part.0.kmsg_read.vfs_read
      0.95 ± 20%     +49.4%       1.43 ± 13%  perf-sched.wait_time.avg.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_exc_page_fault.[unknown]
      0.82 ± 30%     +43.6%       1.17 ± 10%  perf-sched.wait_time.avg.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
     55.22 ± 55%     -95.8%       2.32 ± 48%  perf-sched.wait_time.avg.ms.exit_to_user_mode_prepare.syscall_exit_to_user_mode.entry_SYSCALL_64_after_hwframe.[unknown]
      4.98 ± 11%    -100.0%       0.00        perf-sched.wait_time.avg.ms.rwsem_down_read_slowpath.isra.0.do_user_addr_fault.exc_page_fault
      2.31 ± 10%     -41.4%       1.35 ±  4%  perf-sched.wait_time.avg.ms.rwsem_down_write_slowpath.down_write_killable.vm_mmap_pgoff.ksys_mmap_pgoff
    226.67 ± 48%     -82.8%      39.00 ±  4%  perf-sched.wait_time.avg.ms.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop.0.do_sys_poll
      5.20 ± 31%     -57.5%       2.21 ± 20%  perf-sched.wait_time.avg.ms.schedule_timeout.__skb_wait_for_more_packets.unix_dgram_recvmsg.__sys_recvfrom
      6.68 ±  9%     +90.5%      12.72 ± 21%  perf-sched.wait_time.avg.ms.schedule_timeout.rcu_gp_kthread.kthread.ret_from_fork
      2.72 ±  7%     -13.1%       2.36 ±  3%  perf-sched.wait_time.max.ms.devkmsg_read.vfs_read.ksys_read.do_syscall_64
      2.74 ±  7%     -13.3%       2.38 ±  3%  perf-sched.wait_time.max.ms.do_syslog.part.0.kmsg_read.vfs_read
      1.24 ± 10%     +74.7%       2.16 ± 15%  perf-sched.wait_time.max.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
    232.29 ± 24%     -94.6%      12.46 ±133%  perf-sched.wait_time.max.ms.exit_to_user_mode_prepare.syscall_exit_to_user_mode.entry_SYSCALL_64_after_hwframe.[unknown]
    306.38 ± 10%    -100.0%       0.00        perf-sched.wait_time.max.ms.rwsem_down_read_slowpath.isra.0.do_user_addr_fault.exc_page_fault
    301.05 ±  8%     -98.8%       3.60 ±  9%  perf-sched.wait_time.max.ms.rwsem_down_write_slowpath.down_write_killable.vm_mmap_pgoff.ksys_mmap_pgoff
      5.20 ± 31%     -57.5%       2.21 ± 20%  perf-sched.wait_time.max.ms.schedule_timeout.__skb_wait_for_more_packets.unix_dgram_recvmsg.__sys_recvfrom
      2.15 ± 38%    +245.0%       7.41 ±  6%  perf-stat.i.MPKI
 3.902e+09 ±  4%     -40.5%  2.322e+09 ±  4%  perf-stat.i.branch-instructions
      0.30 ± 26%      +0.4        0.73 ±  4%  perf-stat.i.branch-miss-rate%
  11088155 ± 18%     +59.1%   17646179        perf-stat.i.branch-misses
     27.79 ± 23%     +10.4       38.24 ±  3%  perf-stat.i.cache-miss-rate%
   8670461 ±  5%    +178.2%   24123210 ±  8%  perf-stat.i.cache-misses
  34209769 ± 28%     +89.4%   64777142 ±  8%  perf-stat.i.cache-references
     43061 ±  2%   +1116.5%     523820 ±  3%  perf-stat.i.context-switches
      3.55           -25.1%       2.66 ± 14%  perf-stat.i.cpi
 6.388e+10 ±  6%     -63.5%  2.331e+10 ± 18%  perf-stat.i.cpu-cycles
      7612           -87.0%     990.85 ± 20%  perf-stat.i.cycles-between-cache-misses
      0.02 ± 74%      +0.1        0.08 ±  8%  perf-stat.i.dTLB-load-miss-rate%
    630696 ± 62%    +231.7%    2091983 ±  7%  perf-stat.i.dTLB-load-misses
 4.643e+09 ±  5%     -46.6%  2.477e+09 ±  4%  perf-stat.i.dTLB-loads
    107074 ± 44%    +203.1%     324513 ±  3%  perf-stat.i.dTLB-store-misses
 4.165e+08           +96.0%  8.162e+08 ±  2%  perf-stat.i.dTLB-stores
   4198252 ±  7%     +73.2%    7269429 ±  4%  perf-stat.i.iTLB-load-misses
   3667116 ±  5%     +85.4%    6797954 ±  2%  perf-stat.i.iTLB-loads
 1.795e+10 ±  5%     -50.7%  8.845e+09 ±  4%  perf-stat.i.instructions
      4328 ±  2%     -72.0%       1213 ±  6%  perf-stat.i.instructions-per-iTLB-miss
      0.28           +38.5%       0.39 ± 13%  perf-stat.i.ipc
      0.33 ±  6%     -63.5%       0.12 ± 18%  perf-stat.i.metric.GHz
      2.01 ±  2%     -84.7%       0.31 ± 11%  perf-stat.i.metric.K/sec
     46.88 ±  4%     -36.7%      29.70 ±  4%  perf-stat.i.metric.M/sec
     58055 ±  2%    +349.0%     260670 ±  3%  perf-stat.i.minor-faults
     92.97            +2.4       95.41        perf-stat.i.node-load-miss-rate%
   2120153 ±  3%    +365.6%    9871040 ±  3%  perf-stat.i.node-load-misses
    189417 ±  4%    +172.6%     516379 ±  7%  perf-stat.i.node-loads
    753850          +382.9%    3640602 ±  4%  perf-stat.i.node-store-misses
     33427 ± 17%    +129.1%      76567 ± 13%  perf-stat.i.node-stores
     58057 ±  2%    +349.0%     260672 ±  3%  perf-stat.i.page-faults
      1.94 ± 35%    +277.2%       7.33 ±  6%  perf-stat.overall.MPKI
      0.29 ± 24%      +0.5        0.76 ±  4%  perf-stat.overall.branch-miss-rate%
     27.25 ± 24%     +10.0       37.22 ±  3%  perf-stat.overall.cache-miss-rate%
      3.56           -26.3%       2.62 ± 14%  perf-stat.overall.cpi
      7359           -86.7%     976.00 ± 21%  perf-stat.overall.cycles-between-cache-misses
      0.01 ± 69%      +0.1        0.08 ±  8%  perf-stat.overall.dTLB-load-miss-rate%
      4284 ±  2%     -71.5%       1219 ±  6%  perf-stat.overall.instructions-per-iTLB-miss
      0.28           +38.5%       0.39 ± 14%  perf-stat.overall.ipc
     91.79            +3.2       95.02        perf-stat.overall.node-load-miss-rate%
     95.75            +2.2       97.94        perf-stat.overall.node-store-miss-rate%
     74055 ±  5%     -89.6%       7694 ±  3%  perf-stat.overall.path-length
 3.889e+09 ±  4%     -40.6%   2.31e+09 ±  4%  perf-stat.ps.branch-instructions
  11075294 ± 18%     +58.6%   17562399        perf-stat.ps.branch-misses
   8644500 ±  5%    +177.7%   24004988 ±  8%  perf-stat.ps.cache-misses
  34116591 ± 28%     +89.0%   64488065 ±  8%  perf-stat.ps.cache-references
     42910 ±  2%   +1112.9%     520450 ±  3%  perf-stat.ps.context-switches
 6.365e+10 ±  6%     -63.5%  2.321e+10 ± 18%  perf-stat.ps.cpu-cycles
    629001 ± 62%    +230.6%    2079558 ±  7%  perf-stat.ps.dTLB-load-misses
 4.627e+09 ±  5%     -46.7%  2.465e+09 ±  4%  perf-stat.ps.dTLB-loads
    106777 ± 44%    +202.1%     322591 ±  3%  perf-stat.ps.dTLB-store-misses
 4.153e+08           +95.7%  8.126e+08 ±  2%  perf-stat.ps.dTLB-stores
   4183842 ±  7%     +72.9%    7234466 ±  4%  perf-stat.ps.iTLB-load-misses
   3654597 ±  5%     +85.1%    6764775 ±  2%  perf-stat.ps.iTLB-loads
 1.789e+10 ±  5%     -50.8%  8.802e+09 ±  4%  perf-stat.ps.instructions
     57856 ±  2%    +347.7%     259003 ±  3%  perf-stat.ps.minor-faults
   2114573 ±  3%    +364.4%    9820829 ±  3%  perf-stat.ps.node-load-misses
    189140 ±  4%    +172.7%     515878 ±  7%  perf-stat.ps.node-loads
    751475          +381.4%    3617788 ±  4%  perf-stat.ps.node-store-misses
     33331 ± 17%    +128.7%      76237 ± 13%  perf-stat.ps.node-stores
     57857 ±  2%    +347.7%     259004 ±  3%  perf-stat.ps.page-faults
 5.435e+12 ±  5%     -49.6%  2.741e+12 ±  4%  perf-stat.total.instructions
     58.22           -58.2        0.00        perf-profile.calltrace.cycles-pp.rwsem_optimistic_spin.rwsem_down_read_slowpath.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
     54.47           -54.5        0.00        perf-profile.calltrace.cycles-pp.osq_lock.rwsem_optimistic_spin.rwsem_down_read_slowpath.do_user_addr_fault.exc_page_fault
     59.24           -40.5       18.71 ± 30%  perf-profile.calltrace.cycles-pp.rwsem_down_read_slowpath.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.do_access
     59.57           -38.3       21.23 ± 26%  perf-profile.calltrace.cycles-pp.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.do_access
     59.57           -38.3       21.26 ± 26%  perf-profile.calltrace.cycles-pp.exc_page_fault.asm_exc_page_fault.do_access
     59.61           -37.5       22.12 ± 23%  perf-profile.calltrace.cycles-pp.asm_exc_page_fault.do_access
     59.72           -36.4       23.29 ± 22%  perf-profile.calltrace.cycles-pp.do_access
      3.78 ± 10%      -2.2        1.54 ± 13%  perf-profile.calltrace.cycles-pp.osq_lock.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write_killable.vm_mmap_pgoff
      3.92 ± 10%      -2.1        1.86 ± 12%  perf-profile.calltrace.cycles-pp.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write_killable.vm_mmap_pgoff.ksys_mmap_pgoff
      0.68 ±  8%      +0.4        1.04 ± 16%  perf-profile.calltrace.cycles-pp.irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter
      0.13 ±173%      +0.6        0.69 ± 14%  perf-profile.calltrace.cycles-pp.timekeeping_max_deferment.tick_nohz_next_event.tick_nohz_get_sleep_length.menu_select.do_idle
      0.29 ±100%      +0.6        0.86 ± 15%  perf-profile.calltrace.cycles-pp.__softirqentry_text_start.asm_call_sysvec_on_stack.do_softirq_own_stack.irq_exit_rcu.sysvec_apic_timer_interrupt
      0.29 ±100%      +0.6        0.87 ± 15%  perf-profile.calltrace.cycles-pp.do_softirq_own_stack.irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state
      0.29 ±100%      +0.6        0.87 ± 16%  perf-profile.calltrace.cycles-pp.asm_call_sysvec_on_stack.do_softirq_own_stack.irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      0.69 ±  8%      +0.6        1.26 ± 12%  perf-profile.calltrace.cycles-pp.tick_nohz_next_event.tick_nohz_get_sleep_length.menu_select.do_idle.cpu_startup_entry
      0.00            +0.6        0.62 ±  7%  perf-profile.calltrace.cycles-pp.finish_task_switch.__schedule.schedule.rwsem_down_read_slowpath.do_user_addr_fault
      0.00            +0.6        0.63 ± 18%  perf-profile.calltrace.cycles-pp.ttwu_queue_wakelist.try_to_wake_up.wake_up_q.rwsem_wake.vm_mmap_pgoff
      0.00            +0.6        0.64 ± 18%  perf-profile.calltrace.cycles-pp.mmap_region.do_mmap.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64
      0.00            +0.7        0.65 ± 19%  perf-profile.calltrace.cycles-pp.rwsem_mark_wake.rwsem_wake.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64
      0.00            +0.7        0.68 ± 14%  perf-profile.calltrace.cycles-pp.update_cfs_rq_h_load.select_task_rq_fair.try_to_wake_up.wake_up_q.rwsem_wake
      0.00            +0.7        0.69 ± 16%  perf-profile.calltrace.cycles-pp.dequeue_entity.dequeue_task_fair.__schedule.schedule.rwsem_down_read_slowpath
      0.00            +0.7        0.70 ± 16%  perf-profile.calltrace.cycles-pp.irq_enter_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter
      0.65 ± 20%      +0.7        1.36 ± 14%  perf-profile.calltrace.cycles-pp.tick_sched_timer.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.asm_call_sysvec_on_stack
      0.00            +0.7        0.73 ± 12%  perf-profile.calltrace.cycles-pp.enqueue_entity.enqueue_task_fair.ttwu_do_activate.sched_ttwu_pending.flush_smp_call_function_from_idle
      0.00            +0.8        0.76 ± 14%  perf-profile.calltrace.cycles-pp.dequeue_task_fair.__schedule.schedule.rwsem_down_read_slowpath.do_user_addr_fault
      0.75 ±  7%      +0.8        1.55 ± 14%  perf-profile.calltrace.cycles-pp.tick_nohz_get_sleep_length.menu_select.do_idle.cpu_startup_entry.start_secondary
      0.62 ± 13%      +0.8        1.43 ± 19%  perf-profile.calltrace.cycles-pp.clockevents_program_event.hrtimer_interrupt.__sysvec_apic_timer_interrupt.asm_call_sysvec_on_stack.sysvec_apic_timer_interrupt
      0.17 ±173%      +0.8        1.00 ± 14%  perf-profile.calltrace.cycles-pp.update_process_times.tick_sched_handle.tick_sched_timer.__hrtimer_run_queues.hrtimer_interrupt
      0.18 ±173%      +0.9        1.04 ± 14%  perf-profile.calltrace.cycles-pp.tick_sched_handle.tick_sched_timer.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt
      0.00            +0.9        0.87 ± 11%  perf-profile.calltrace.cycles-pp.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      0.16 ±173%      +0.9        1.06 ± 19%  perf-profile.calltrace.cycles-pp.ktime_get.clockevents_program_event.hrtimer_interrupt.__sysvec_apic_timer_interrupt.asm_call_sysvec_on_stack
      0.00            +0.9        0.91 ± 10%  perf-profile.calltrace.cycles-pp.__schedule.schedule_idle.do_idle.cpu_startup_entry.start_secondary
      0.00            +0.9        0.94 ± 10%  perf-profile.calltrace.cycles-pp.schedule_idle.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      0.00            +1.0        0.95 ± 16%  perf-profile.calltrace.cycles-pp.select_task_rq_fair.try_to_wake_up.wake_up_q.rwsem_wake.vm_mmap_pgoff
      0.00            +1.0        0.96 ± 14%  perf-profile.calltrace.cycles-pp.enqueue_task_fair.ttwu_do_activate.sched_ttwu_pending.flush_smp_call_function_from_idle.do_idle
      0.00            +1.0        0.97 ± 14%  perf-profile.calltrace.cycles-pp.ttwu_do_activate.sched_ttwu_pending.flush_smp_call_function_from_idle.do_idle.cpu_startup_entry
      0.00            +1.0        1.02 ±  8%  perf-profile.calltrace.cycles-pp.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.do_access
      0.00            +1.0        1.05 ± 15%  perf-profile.calltrace.cycles-pp.do_mmap.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.93 ± 20%      +1.1        2.02 ± 16%  perf-profile.calltrace.cycles-pp.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.asm_call_sysvec_on_stack.sysvec_apic_timer_interrupt
      0.00            +1.4        1.44 ± 13%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irq.rwsem_down_write_slowpath.down_write_killable.vm_mmap_pgoff
      0.00            +1.4        1.44 ± 16%  perf-profile.calltrace.cycles-pp.sched_ttwu_pending.flush_smp_call_function_from_idle.do_idle.cpu_startup_entry.start_secondary
      0.00            +1.5        1.49 ± 13%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irq.rwsem_down_write_slowpath.down_write_killable.vm_mmap_pgoff.ksys_mmap_pgoff
      0.00            +1.7        1.73 ± 16%  perf-profile.calltrace.cycles-pp.flush_smp_call_function_from_idle.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      0.00            +2.3        2.27 ±  9%  perf-profile.calltrace.cycles-pp.__schedule.schedule.rwsem_down_read_slowpath.do_user_addr_fault.exc_page_fault
      0.00            +2.3        2.29 ±  9%  perf-profile.calltrace.cycles-pp.schedule.rwsem_down_read_slowpath.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      1.81 ± 16%      +2.3        4.15 ± 18%  perf-profile.calltrace.cycles-pp.hrtimer_interrupt.__sysvec_apic_timer_interrupt.asm_call_sysvec_on_stack.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      0.00            +2.4        2.39 ± 16%  perf-profile.calltrace.cycles-pp.try_to_wake_up.wake_up_q.rwsem_wake.vm_mmap_pgoff.ksys_mmap_pgoff
      1.83 ± 16%      +2.4        4.23 ± 18%  perf-profile.calltrace.cycles-pp.__sysvec_apic_timer_interrupt.asm_call_sysvec_on_stack.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state
      1.84 ± 16%      +2.4        4.25 ± 18%  perf-profile.calltrace.cycles-pp.asm_call_sysvec_on_stack.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter
      0.00            +2.4        2.44 ± 16%  perf-profile.calltrace.cycles-pp.wake_up_q.rwsem_wake.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64
      0.00            +3.1        3.10 ± 16%  perf-profile.calltrace.cycles-pp.rwsem_wake.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe
      4.80 ±  5%      +3.1        7.93 ± 17%  perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry
      3.13 ± 12%      +3.4        6.53 ± 17%  perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter.do_idle
      0.00            +4.1        4.11 ± 16%  perf-profile.calltrace.cycles-pp.do_rw_once
      0.00            +8.2        8.21 ±  9%  perf-profile.calltrace.cycles-pp.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe.__mmap
      0.00            +8.3        8.27 ±  9%  perf-profile.calltrace.cycles-pp.ksys_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe.__mmap
      0.00            +8.3        8.28 ±  9%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__mmap
      0.00            +8.3        8.30 ±  9%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__mmap
      0.00            +8.4        8.44 ±  9%  perf-profile.calltrace.cycles-pp.__mmap
      0.13 ±173%     +14.6       14.70 ± 40%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irq.rwsem_down_read_slowpath.do_user_addr_fault.exc_page_fault
      0.27 ±100%     +14.6       14.91 ± 39%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irq.rwsem_down_read_slowpath.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
     24.61 ±  2%     +23.1       47.70 ±  2%  perf-profile.calltrace.cycles-pp.intel_idle.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry
     30.68           +25.9       56.54 ±  4%  perf-profile.calltrace.cycles-pp.cpuidle_enter.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     29.85 ±  2%     +26.0       55.86 ±  4%  perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry.start_secondary
     35.35           +28.6       63.91 ±  5%  perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     35.35           +28.6       63.94 ±  5%  perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     35.35           +28.6       63.94 ±  5%  perf-profile.calltrace.cycles-pp.start_secondary.secondary_startup_64_no_verify
     35.55           +28.8       64.33 ±  5%  perf-profile.calltrace.cycles-pp.secondary_startup_64_no_verify
     62.44           -60.5        1.90 ± 11%  perf-profile.children.cycles-pp.rwsem_optimistic_spin
     58.27           -56.7        1.56 ± 13%  perf-profile.children.cycles-pp.osq_lock
     59.24           -40.5       18.73 ± 30%  perf-profile.children.cycles-pp.rwsem_down_read_slowpath
     59.59           -38.3       21.27 ± 26%  perf-profile.children.cycles-pp.do_user_addr_fault
     59.59           -38.3       21.30 ± 26%  perf-profile.children.cycles-pp.exc_page_fault
     59.64           -37.7       21.98 ± 25%  perf-profile.children.cycles-pp.asm_exc_page_fault
     59.86           -35.0       24.88 ± 20%  perf-profile.children.cycles-pp.do_access
      0.74 ± 10%      -0.6        0.11 ± 12%  perf-profile.children.cycles-pp.rwsem_spin_on_owner
      0.14 ±  8%      -0.1        0.06 ± 14%  perf-profile.children.cycles-pp.task_tick_fair
      0.08 ± 13%      +0.0        0.12 ± 18%  perf-profile.children.cycles-pp.arch_cpu_idle_enter
      0.08 ± 15%      +0.0        0.12 ± 18%  perf-profile.children.cycles-pp.tsc_verify_tsc_adjust
      0.00            +0.1        0.05 ±  8%  perf-profile.children.cycles-pp.trigger_load_balance
      0.01 ±173%      +0.1        0.07 ± 17%  perf-profile.children.cycles-pp.timerqueue_del
      0.00            +0.1        0.06 ± 11%  perf-profile.children.cycles-pp.idle_cpu
      0.00            +0.1        0.06 ± 11%  perf-profile.children.cycles-pp.asm_sysvec_call_function_single
      0.00            +0.1        0.06 ± 13%  perf-profile.children.cycles-pp.copy_fpregs_to_fpstate
      0.00            +0.1        0.06 ± 20%  perf-profile.children.cycles-pp.get_cpu_device
      0.00            +0.1        0.07 ± 17%  perf-profile.children.cycles-pp.select_idle_sibling
      0.06 ± 20%      +0.1        0.13 ± 17%  perf-profile.children.cycles-pp.__intel_pmu_enable_all
      0.00            +0.1        0.07 ± 16%  perf-profile.children.cycles-pp.timerqueue_add
      0.01 ±173%      +0.1        0.08 ± 19%  perf-profile.children.cycles-pp.__remove_hrtimer
      0.00            +0.1        0.07 ± 17%  perf-profile.children.cycles-pp.__wrgsbase_inactive
      0.00            +0.1        0.07 ± 11%  perf-profile.children.cycles-pp.vm_area_alloc
      0.00            +0.1        0.07 ± 26%  perf-profile.children.cycles-pp.wake_q_add
      0.00            +0.1        0.07 ± 20%  perf-profile.children.cycles-pp.enqueue_hrtimer
      0.05 ± 67%      +0.1        0.12 ± 14%  perf-profile.children.cycles-pp.rcu_sched_clock_irq
      0.00            +0.1        0.07 ± 20%  perf-profile.children.cycles-pp.menu_reflect
      0.00            +0.1        0.07 ± 20%  perf-profile.children.cycles-pp.ret_from_fork
      0.00            +0.1        0.07 ± 20%  perf-profile.children.cycles-pp.kthread
      0.00            +0.1        0.08 ± 22%  perf-profile.children.cycles-pp.run_local_timers
      0.00            +0.1        0.08 ± 23%  perf-profile.children.cycles-pp.io_serial_in
      0.00            +0.1        0.08 ± 21%  perf-profile.children.cycles-pp.reweight_entity
      0.00            +0.1        0.08 ± 13%  perf-profile.children.cycles-pp.kmem_cache_alloc
      0.11 ± 20%      +0.1        0.20 ± 19%  perf-profile.children.cycles-pp.update_blocked_averages
      0.12 ± 21%      +0.1        0.21 ± 18%  perf-profile.children.cycles-pp.run_rebalance_domains
      0.00            +0.1        0.09 ± 17%  perf-profile.children.cycles-pp.rcu_core
      0.00            +0.1        0.09 ± 20%  perf-profile.children.cycles-pp.rcu_eqs_enter
      0.00            +0.1        0.09 ± 25%  perf-profile.children.cycles-pp.ttwu_do_wakeup
      0.00            +0.1        0.10 ± 18%  perf-profile.children.cycles-pp.perf_event_mmap
      0.01 ±173%      +0.1        0.11 ± 19%  perf-profile.children.cycles-pp.update_irq_load_avg
      0.00            +0.1        0.10 ± 15%  perf-profile.children.cycles-pp.__perf_sw_event
      0.00            +0.1        0.11 ± 28%  perf-profile.children.cycles-pp.call_cpuidle
      0.03 ±100%      +0.1        0.14 ± 16%  perf-profile.children.cycles-pp.arch_scale_freq_tick
      0.00            +0.1        0.11 ± 26%  perf-profile.children.cycles-pp.rcu_eqs_exit
      0.10 ± 27%      +0.1        0.21 ±  9%  perf-profile.children.cycles-pp.calc_global_load_tick
      0.00            +0.1        0.11 ± 24%  perf-profile.children.cycles-pp.tick_nohz_idle_enter
      0.00            +0.1        0.11 ± 18%  perf-profile.children.cycles-pp.serial8250_console_putchar
      0.00            +0.1        0.12 ± 20%  perf-profile.children.cycles-pp.serial8250_console_write
      0.00            +0.1        0.12 ± 20%  perf-profile.children.cycles-pp.wait_for_xmitr
      0.00            +0.1        0.12 ± 20%  perf-profile.children.cycles-pp.uart_console_write
      0.11 ± 18%      +0.1        0.24 ± 17%  perf-profile.children.cycles-pp.update_sd_lb_stats
      0.34 ±  9%      +0.1        0.47 ± 13%  perf-profile.children.cycles-pp.rebalance_domains
      0.00            +0.1        0.13 ± 18%  perf-profile.children.cycles-pp.asm_sysvec_irq_work
      0.00            +0.1        0.13 ± 18%  perf-profile.children.cycles-pp.sysvec_irq_work
      0.00            +0.1        0.13 ± 18%  perf-profile.children.cycles-pp.__sysvec_irq_work
      0.00            +0.1        0.13 ± 18%  perf-profile.children.cycles-pp.irq_work_run
      0.00            +0.1        0.13 ± 18%  perf-profile.children.cycles-pp.irq_work_single
      0.00            +0.1        0.13 ± 18%  perf-profile.children.cycles-pp.printk
      0.00            +0.1        0.13 ± 18%  perf-profile.children.cycles-pp.vprintk_emit
      0.00            +0.1        0.13 ± 18%  perf-profile.children.cycles-pp.console_unlock
      0.12 ± 18%      +0.1        0.26 ± 18%  perf-profile.children.cycles-pp.find_busiest_group
      0.06 ± 22%      +0.1        0.20 ± 16%  perf-profile.children.cycles-pp.newidle_balance
      0.00            +0.1        0.14 ± 24%  perf-profile.children.cycles-pp.cpuidle_governor_latency_req
      0.01 ±173%      +0.1        0.15 ± 22%  perf-profile.children.cycles-pp.__hrtimer_next_event_base
      0.00            +0.1        0.15 ± 19%  perf-profile.children.cycles-pp.send_call_function_single_ipi
      0.00            +0.1        0.15 ± 19%  perf-profile.children.cycles-pp.irq_work_run_list
      0.00            +0.2        0.16 ± 23%  perf-profile.children.cycles-pp.wake_q_add_safe
      0.00            +0.2        0.16 ± 13%  perf-profile.children.cycles-pp.hrtimer_get_next_event
      0.03 ±102%      +0.2        0.20 ± 17%  perf-profile.children.cycles-pp.rcu_idle_exit
      0.00            +0.2        0.17 ± 21%  perf-profile.children.cycles-pp.___perf_sw_event
      0.06 ± 15%      +0.2        0.23 ± 20%  perf-profile.children.cycles-pp.hrtimer_next_event_without
      0.15 ± 18%      +0.2        0.33 ± 14%  perf-profile.children.cycles-pp.load_balance
      0.00            +0.2        0.18 ± 14%  perf-profile.children.cycles-pp.llist_reverse_order
      0.07 ± 10%      +0.2        0.26 ± 11%  perf-profile.children.cycles-pp.get_next_timer_interrupt
      0.00            +0.2        0.20 ± 51%  perf-profile.children.cycles-pp.find_vma
      0.19 ± 16%      +0.2        0.39 ± 16%  perf-profile.children.cycles-pp.start_kernel
      0.24 ±  8%      +0.2        0.44 ± 21%  perf-profile.children.cycles-pp.tick_nohz_irq_exit
      0.18 ± 12%      +0.2        0.38 ± 21%  perf-profile.children.cycles-pp.perf_mux_hrtimer_handler
      0.00            +0.2        0.20 ± 14%  perf-profile.children.cycles-pp.__update_load_avg_se
      0.39 ± 13%      +0.2        0.60 ±  8%  perf-profile.children.cycles-pp.scheduler_tick
      0.00            +0.2        0.21 ± 19%  perf-profile.children.cycles-pp.sync_regs
      0.00            +0.2        0.21 ± 15%  perf-profile.children.cycles-pp.__switch_to
      0.00            +0.2        0.21 ± 13%  perf-profile.children.cycles-pp.__list_del_entry_valid
      0.01 ±173%      +0.2        0.24 ± 59%  perf-profile.children.cycles-pp.switch_mm_irqs_off
      0.00            +0.2        0.22 ± 15%  perf-profile.children.cycles-pp.__list_add_valid
      0.12 ±  4%      +0.2        0.35 ± 18%  perf-profile.children.cycles-pp.lapic_next_deadline
      0.07 ±  6%      +0.2        0.30 ± 19%  perf-profile.children.cycles-pp._raw_spin_unlock_irqrestore
      0.06 ± 11%      +0.2        0.30 ±  9%  perf-profile.children.cycles-pp.update_cfs_group
      0.00            +0.2        0.24 ± 26%  perf-profile.children.cycles-pp.__switch_to_asm
      0.46 ±  9%      +0.2        0.69 ± 14%  perf-profile.children.cycles-pp.timekeeping_max_deferment
      0.00            +0.2        0.24 ± 14%  perf-profile.children.cycles-pp.cpuacct_charge
      0.00            +0.2        0.25 ± 14%  perf-profile.children.cycles-pp.set_next_entity
      0.00            +0.3        0.26 ± 16%  perf-profile.children.cycles-pp.vma_interval_tree_insert
      0.00            +0.3        0.26 ± 12%  perf-profile.children.cycles-pp.flush_smp_call_function_queue
      0.08 ± 16%      +0.3        0.34 ± 20%  perf-profile.children.cycles-pp.update_rq_clock
      0.00            +0.3        0.26 ± 19%  perf-profile.children.cycles-pp.nr_iowait_cpu
      0.00            +0.3        0.26 ± 19%  perf-profile.children.cycles-pp.update_ts_time_stats
      0.12 ± 13%      +0.3        0.38 ± 19%  perf-profile.children.cycles-pp.read_tsc
      0.09 ± 23%      +0.3        0.36 ± 17%  perf-profile.children.cycles-pp.native_sched_clock
      0.16 ±  6%      +0.3        0.44 ± 22%  perf-profile.children.cycles-pp.ktime_get_update_offsets_now
      0.10 ± 17%      +0.3        0.38 ± 18%  perf-profile.children.cycles-pp.sched_clock
      0.27 ±  9%      +0.3        0.55 ± 16%  perf-profile.children.cycles-pp.tick_irq_enter
      0.03 ±100%      +0.3        0.33 ± 11%  perf-profile.children.cycles-pp.down_read_trylock
      0.04 ± 57%      +0.3        0.34 ± 12%  perf-profile.children.cycles-pp.down_read
      0.00            +0.3        0.31 ± 16%  perf-profile.children.cycles-pp.__update_load_avg_cfs_rq
      0.11 ±  7%      +0.3        0.42 ± 19%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      0.00            +0.3        0.32 ± 19%  perf-profile.children.cycles-pp.llist_add_batch
      0.00            +0.3        0.32 ± 19%  perf-profile.children.cycles-pp.__smp_call_single_queue
      0.10 ± 18%      +0.3        0.42 ± 18%  perf-profile.children.cycles-pp.sched_clock_cpu
      0.04 ± 58%      +0.3        0.38 ± 18%  perf-profile.children.cycles-pp.vma_link
      0.00            +0.3        0.34 ± 19%  perf-profile.children.cycles-pp.tick_nohz_idle_exit
      0.06 ±  7%      +0.3        0.40 ± 11%  perf-profile.children.cycles-pp.up_read
      0.04 ± 58%      +0.4        0.39 ± 13%  perf-profile.children.cycles-pp.arch_get_unmapped_area_topdown
      0.03 ±100%      +0.4        0.38 ± 14%  perf-profile.children.cycles-pp.vm_unmapped_area
      0.00            +0.4        0.36 ± 11%  perf-profile.children.cycles-pp.perf_trace_sched_wakeup_template
      0.55 ± 10%      +0.4        0.91 ± 15%  perf-profile.children.cycles-pp.__softirqentry_text_start
      0.55 ± 11%      +0.4        0.91 ± 15%  perf-profile.children.cycles-pp.do_softirq_own_stack
      0.04 ± 58%      +0.4        0.40 ± 13%  perf-profile.children.cycles-pp.get_unmapped_area
      0.35 ±  6%      +0.4        0.72 ± 16%  perf-profile.children.cycles-pp.irq_enter_rcu
      0.71 ±  8%      +0.4        1.10 ± 16%  perf-profile.children.cycles-pp.irq_exit_rcu
      0.01 ±173%      +0.4        0.41 ± 19%  perf-profile.children.cycles-pp.do_anonymous_page
      0.70 ± 14%      +0.4        1.14 ± 11%  perf-profile.children.cycles-pp.update_process_times
      0.26 ±  4%      +0.5        0.71 ± 16%  perf-profile.children.cycles-pp.native_irq_return_iret
      0.71 ± 16%      +0.5        1.17 ± 10%  perf-profile.children.cycles-pp.tick_sched_handle
      0.07 ± 19%      +0.5        0.53 ± 14%  perf-profile.children.cycles-pp.pick_next_task_fair
      0.10 ± 15%      +0.5        0.64 ± 15%  perf-profile.children.cycles-pp._raw_spin_lock
      0.00            +0.6        0.57 ± 13%  perf-profile.children.cycles-pp.update_curr
      0.08 ± 14%      +0.6        0.65 ± 18%  perf-profile.children.cycles-pp.mmap_region
      0.69 ±  8%      +0.6        1.27 ± 13%  perf-profile.children.cycles-pp.tick_nohz_next_event
      0.86 ± 15%      +0.6        1.50 ± 11%  perf-profile.children.cycles-pp.tick_sched_timer
      0.00            +0.7        0.67 ± 17%  perf-profile.children.cycles-pp.ttwu_queue_wakelist
      0.10 ±  8%      +0.7        0.77 ± 13%  perf-profile.children.cycles-pp.update_load_avg
      0.00            +0.7        0.69 ± 15%  perf-profile.children.cycles-pp.update_cfs_rq_h_load
      0.00            +0.7        0.71 ± 17%  perf-profile.children.cycles-pp.rwsem_mark_wake
      0.00            +0.7        0.73 ±  5%  perf-profile.children.cycles-pp.finish_task_switch
      0.69 ± 14%      +0.8        1.49 ± 18%  perf-profile.children.cycles-pp.clockevents_program_event
      0.10 ± 10%      +0.8        0.91 ± 10%  perf-profile.children.cycles-pp.__handle_mm_fault
      0.76 ±  7%      +0.8        1.57 ± 14%  perf-profile.children.cycles-pp.tick_nohz_get_sleep_length
      0.00            +0.8        0.81 ± 14%  perf-profile.children.cycles-pp.dequeue_entity
      0.01 ±173%      +0.9        0.89 ± 13%  perf-profile.children.cycles-pp.dequeue_task_fair
      0.03 ±102%      +0.9        0.94 ± 10%  perf-profile.children.cycles-pp.schedule_idle
      0.13 ± 10%      +0.9        1.06 ± 15%  perf-profile.children.cycles-pp.do_mmap
      0.01 ±173%      +0.9        0.95 ± 12%  perf-profile.children.cycles-pp.enqueue_entity
      0.12 ± 10%      +0.9        1.06 ±  8%  perf-profile.children.cycles-pp.handle_mm_fault
      0.00            +1.0        0.97 ± 16%  perf-profile.children.cycles-pp.select_task_rq_fair
      1.17 ± 16%      +1.0        2.21 ± 14%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      0.03 ±102%      +1.2        1.21 ± 14%  perf-profile.children.cycles-pp.enqueue_task_fair
      0.03 ±102%      +1.2        1.22 ± 14%  perf-profile.children.cycles-pp.ttwu_do_activate
      1.12 ±  9%      +1.3        2.42 ± 17%  perf-profile.children.cycles-pp.ktime_get
      0.04 ± 60%      +1.4        1.48 ± 16%  perf-profile.children.cycles-pp.sched_ttwu_pending
      0.07 ± 13%      +1.7        1.75 ± 16%  perf-profile.children.cycles-pp.flush_smp_call_function_from_idle
      2.13 ± 14%      +2.3        4.44 ± 16%  perf-profile.children.cycles-pp.hrtimer_interrupt
      2.16 ± 14%      +2.3        4.51 ± 16%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      0.12 ± 12%      +2.4        2.49 ± 15%  perf-profile.children.cycles-pp.try_to_wake_up
      0.12 ± 12%      +2.4        2.54 ± 15%  perf-profile.children.cycles-pp.wake_up_q
      0.17 ± 10%      +2.5        2.69 ±  9%  perf-profile.children.cycles-pp.schedule
      2.73 ± 14%      +2.8        5.57 ± 16%  perf-profile.children.cycles-pp.asm_call_sysvec_on_stack
      0.16 ± 13%      +3.1        3.23 ± 16%  perf-profile.children.cycles-pp.rwsem_wake
      0.29 ±  7%      +3.1        3.36 ± 16%  perf-profile.children.cycles-pp.do_rw_once
      4.39 ±  7%      +3.3        7.70 ± 16%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
      0.22 ± 13%      +3.4        3.59 ±  9%  perf-profile.children.cycles-pp.__schedule
      3.50 ± 11%      +3.4        6.89 ± 16%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      4.27 ±  9%      +4.0        8.22 ±  9%  perf-profile.children.cycles-pp.vm_mmap_pgoff
      4.27 ±  9%      +4.0        8.28 ±  9%  perf-profile.children.cycles-pp.ksys_mmap_pgoff
      4.35 ±  9%      +4.1        8.47 ±  9%  perf-profile.children.cycles-pp.do_syscall_64
      4.35 ±  9%      +4.1        8.49 ±  9%  perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.00            +8.4        8.44 ±  9%  perf-profile.children.cycles-pp.__mmap
      0.44 ± 29%     +15.8       16.25 ± 37%  perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
      0.49 ± 26%     +16.0       16.46 ± 36%  perf-profile.children.cycles-pp._raw_spin_lock_irq
     24.74 ±  2%     +23.2       47.96 ±  2%  perf-profile.children.cycles-pp.intel_idle
     30.83           +26.0       56.88 ±  4%  perf-profile.children.cycles-pp.cpuidle_enter_state
     30.84           +26.1       56.89 ±  4%  perf-profile.children.cycles-pp.cpuidle_enter
     35.35           +28.6       63.94 ±  5%  perf-profile.children.cycles-pp.start_secondary
     35.55           +28.8       64.33 ±  5%  perf-profile.children.cycles-pp.do_idle
     35.55           +28.8       64.33 ±  5%  perf-profile.children.cycles-pp.secondary_startup_64_no_verify
     35.55           +28.8       64.33 ±  5%  perf-profile.children.cycles-pp.cpu_startup_entry
     57.93           -56.4        1.54 ± 13%  perf-profile.self.cycles-pp.osq_lock
      3.66 ± 11%      -3.5        0.19 ± 14%  perf-profile.self.cycles-pp.rwsem_optimistic_spin
      3.60 ± 13%      -1.8        1.79 ± 23%  perf-profile.self.cycles-pp.menu_select
      2.54 ± 20%      -1.3        1.21 ± 21%  perf-profile.self.cycles-pp.cpuidle_enter_state
      0.44 ±  9%      -0.3        0.10 ±  8%  perf-profile.self.cycles-pp.rwsem_spin_on_owner
      0.06 ±  6%      +0.0        0.10 ± 21%  perf-profile.self.cycles-pp.perf_mux_hrtimer_handler
      0.08 ± 12%      +0.0        0.12 ± 21%  perf-profile.self.cycles-pp.tsc_verify_tsc_adjust
      0.00            +0.1        0.06 ± 14%  perf-profile.self.cycles-pp.idle_cpu
      0.00            +0.1        0.06 ± 20%  perf-profile.self.cycles-pp.wake_up_q
      0.00            +0.1        0.06 ± 11%  perf-profile.self.cycles-pp.find_vma
      0.06 ± 13%      +0.1        0.12 ± 18%  perf-profile.self.cycles-pp.tick_sched_timer
      0.00            +0.1        0.06 ± 13%  perf-profile.self.cycles-pp.copy_fpregs_to_fpstate
      0.00            +0.1        0.06 ± 17%  perf-profile.self.cycles-pp.__softirqentry_text_start
      0.00            +0.1        0.06 ± 20%  perf-profile.self.cycles-pp.get_cpu_device
      0.03 ±102%      +0.1        0.10 ± 11%  perf-profile.self.cycles-pp.rcu_sched_clock_irq
      0.12 ± 26%      +0.1        0.19 ± 17%  perf-profile.self.cycles-pp.update_process_times
      0.06 ± 20%      +0.1        0.13 ± 17%  perf-profile.self.cycles-pp.__intel_pmu_enable_all
      0.00            +0.1        0.07 ± 12%  perf-profile.self.cycles-pp.flush_smp_call_function_queue
      0.00            +0.1        0.07 ± 14%  perf-profile.self.cycles-pp.dequeue_entity
      0.00            +0.1        0.07 ± 17%  perf-profile.self.cycles-pp.__wrgsbase_inactive
      0.00            +0.1        0.07 ± 26%  perf-profile.self.cycles-pp.asm_sysvec_apic_timer_interrupt
      0.00            +0.1        0.07 ± 22%  perf-profile.self.cycles-pp.try_to_wake_up
      0.00            +0.1        0.07 ± 26%  perf-profile.self.cycles-pp.wake_q_add
      0.00            +0.1        0.08 ± 16%  perf-profile.self.cycles-pp.hrtimer_interrupt
      0.00            +0.1        0.08 ± 23%  perf-profile.self.cycles-pp.io_serial_in
      0.00            +0.1        0.08 ± 21%  perf-profile.self.cycles-pp.reweight_entity
      0.00            +0.1        0.09 ± 17%  perf-profile.self.cycles-pp.__hrtimer_run_queues
      0.00            +0.1        0.09 ± 12%  perf-profile.self.cycles-pp.rcu_idle_exit
      0.08 ± 19%      +0.1        0.17 ± 18%  perf-profile.self.cycles-pp.update_sd_lb_stats
      0.01 ±173%      +0.1        0.11 ± 16%  perf-profile.self.cycles-pp.update_irq_load_avg
      0.00            +0.1        0.10 ± 13%  perf-profile.self.cycles-pp.set_next_entity
      0.00            +0.1        0.10 ± 27%  perf-profile.self.cycles-pp.call_cpuidle
      0.03 ±100%      +0.1        0.14 ± 16%  perf-profile.self.cycles-pp.arch_scale_freq_tick
      0.10 ± 27%      +0.1        0.21 ±  9%  perf-profile.self.cycles-pp.calc_global_load_tick
      0.15 ± 11%      +0.1        0.27 ± 12%  perf-profile.self.cycles-pp.tick_nohz_next_event
      0.00            +0.1        0.11 ± 21%  perf-profile.self.cycles-pp.enqueue_entity
      0.00            +0.1        0.13 ± 29%  perf-profile.self.cycles-pp.update_rq_clock
      0.00            +0.1        0.13 ± 23%  perf-profile.self.cycles-pp.__hrtimer_next_event_base
      0.00            +0.1        0.15 ± 19%  perf-profile.self.cycles-pp.send_call_function_single_ipi
      0.00            +0.1        0.15 ± 23%  perf-profile.self.cycles-pp.___perf_sw_event
      0.00            +0.2        0.16 ± 23%  perf-profile.self.cycles-pp.wake_q_add_safe
      0.00            +0.2        0.17 ±  6%  perf-profile.self.cycles-pp.rwsem_down_write_slowpath
      0.00            +0.2        0.18 ± 14%  perf-profile.self.cycles-pp.llist_reverse_order
      0.00            +0.2        0.19 ± 13%  perf-profile.self.cycles-pp.ttwu_queue_wakelist
      0.00            +0.2        0.20 ± 16%  perf-profile.self.cycles-pp.__switch_to
      0.00            +0.2        0.20 ± 18%  perf-profile.self.cycles-pp.sched_ttwu_pending
      0.00            +0.2        0.20 ± 13%  perf-profile.self.cycles-pp.update_curr
      0.00            +0.2        0.20 ± 14%  perf-profile.self.cycles-pp.__update_load_avg_se
      0.00            +0.2        0.20 ± 18%  perf-profile.self.cycles-pp.sync_regs
      0.06 ±  6%      +0.2        0.27 ± 18%  perf-profile.self.cycles-pp._raw_spin_unlock_irqrestore
      0.00            +0.2        0.21 ± 19%  perf-profile.self.cycles-pp.select_task_rq_fair
      0.01 ±173%      +0.2        0.22 ± 52%  perf-profile.self.cycles-pp.switch_mm_irqs_off
      0.00            +0.2        0.21 ± 13%  perf-profile.self.cycles-pp.__list_del_entry_valid
      0.00            +0.2        0.22 ± 15%  perf-profile.self.cycles-pp.__list_add_valid
      0.06 ± 11%      +0.2        0.29 ±  7%  perf-profile.self.cycles-pp.update_cfs_group
      0.12 ±  4%      +0.2        0.35 ± 17%  perf-profile.self.cycles-pp.lapic_next_deadline
      0.06 ±  7%      +0.2        0.29 ± 10%  perf-profile.self.cycles-pp.update_load_avg
      0.00            +0.2        0.23 ± 25%  perf-profile.self.cycles-pp.__switch_to_asm
      0.46 ±  9%      +0.2        0.69 ± 14%  perf-profile.self.cycles-pp.timekeeping_max_deferment
      0.15 ±  7%      +0.2        0.39 ± 23%  perf-profile.self.cycles-pp.ktime_get_update_offsets_now
      0.00            +0.2        0.24 ± 14%  perf-profile.self.cycles-pp.cpuacct_charge
      0.06 ±  6%      +0.3        0.32 ±  4%  perf-profile.self.cycles-pp._raw_spin_lock_irq
      0.00            +0.3        0.26 ± 16%  perf-profile.self.cycles-pp.vma_interval_tree_insert
      0.00            +0.3        0.26 ± 18%  perf-profile.self.cycles-pp.nr_iowait_cpu
      0.09 ± 19%      +0.3        0.35 ± 18%  perf-profile.self.cycles-pp.native_sched_clock
      0.00            +0.3        0.26 ± 20%  perf-profile.self.cycles-pp.enqueue_task_fair
      0.11 ± 15%      +0.3        0.38 ± 19%  perf-profile.self.cycles-pp.read_tsc
      0.04 ± 63%      +0.3        0.32 ± 16%  perf-profile.self.cycles-pp.do_idle
      0.10 ± 12%      +0.3        0.38 ± 21%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.00            +0.3        0.28 ± 17%  perf-profile.self.cycles-pp.rwsem_mark_wake
      0.00            +0.3        0.28 ± 13%  perf-profile.self.cycles-pp.perf_trace_sched_wakeup_template
      0.01 ±173%      +0.3        0.31 ± 15%  perf-profile.self.cycles-pp.down_read
      0.00            +0.3        0.30 ± 17%  perf-profile.self.cycles-pp.__update_load_avg_cfs_rq
      0.03 ±100%      +0.3        0.33 ± 11%  perf-profile.self.cycles-pp.down_read_trylock
      0.00            +0.3        0.32 ± 19%  perf-profile.self.cycles-pp.llist_add_batch
      0.05 ±  9%      +0.3        0.40 ± 10%  perf-profile.self.cycles-pp.up_read
      0.03 ±100%      +0.4        0.38 ± 14%  perf-profile.self.cycles-pp.vm_unmapped_area
      0.04 ± 57%      +0.4        0.46 ±  3%  perf-profile.self.cycles-pp.__handle_mm_fault
      0.10 ± 15%      +0.4        0.54 ± 18%  perf-profile.self.cycles-pp._raw_spin_lock
      0.26 ±  4%      +0.5        0.71 ± 16%  perf-profile.self.cycles-pp.native_irq_return_iret
      0.00            +0.7        0.68 ±  4%  perf-profile.self.cycles-pp.finish_task_switch
      0.00            +0.7        0.69 ± 15%  perf-profile.self.cycles-pp.update_cfs_rq_h_load
      0.01 ±173%      +0.7        0.70 ± 10%  perf-profile.self.cycles-pp.__schedule
      0.15 ±  7%      +0.9        1.08 ±  2%  perf-profile.self.cycles-pp.rwsem_down_read_slowpath
      1.02 ±  9%      +1.1        2.08 ± 17%  perf-profile.self.cycles-pp.ktime_get
      0.19 ± 10%      +2.0        2.17 ± 14%  perf-profile.self.cycles-pp.do_rw_once
      0.20 ±  9%      +2.1        2.27 ± 17%  perf-profile.self.cycles-pp.do_access
      0.44 ± 29%     +15.8       16.25 ± 37%  perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
     24.74 ±  2%     +23.2       47.96 ±  2%  perf-profile.self.cycles-pp.intel_idle
     12249 ± 21%    +106.7%      25324 ±  9%  softirqs.CPU0.RCU
      9537 ±  3%    +149.8%      23829 ±  8%  softirqs.CPU1.RCU
     37131           +14.2%      42407 ±  2%  softirqs.CPU1.SCHED
      9016 ±  3%    +163.1%      23716 ±  8%  softirqs.CPU10.RCU
     36655           +14.7%      42035 ±  2%  softirqs.CPU10.SCHED
      9122 ± 10%    +156.8%      23428 ±  9%  softirqs.CPU100.RCU
     36099 ±  4%     +16.5%      42065        softirqs.CPU100.SCHED
      8711 ±  3%    +171.0%      23606 ±  9%  softirqs.CPU101.RCU
     36894           +14.3%      42172        softirqs.CPU101.SCHED
      8920 ±  6%    +165.7%      23700 ±  9%  softirqs.CPU102.RCU
     35214 ±  7%     +19.8%      42173        softirqs.CPU102.SCHED
      8805 ±  3%    +170.3%      23803 ± 10%  softirqs.CPU103.RCU
     36608           +13.4%      41507 ±  3%  softirqs.CPU103.SCHED
      8767 ±  6%    +170.5%      23717 ±  9%  softirqs.CPU104.RCU
     36225           +16.1%      42066 ±  2%  softirqs.CPU104.SCHED
      8738 ±  4%    +166.9%      23321 ±  9%  softirqs.CPU105.RCU
     36793           +13.6%      41794        softirqs.CPU105.SCHED
      8733 ±  3%    +165.3%      23168 ±  9%  softirqs.CPU106.RCU
     36486           +14.9%      41931 ±  2%  softirqs.CPU106.SCHED
      8835 ±  5%    +160.9%      23053 ± 11%  softirqs.CPU107.RCU
      8803 ±  3%    +171.0%      23859 ±  9%  softirqs.CPU108.RCU
     35808 ±  4%     +17.5%      42068 ±  2%  softirqs.CPU108.SCHED
      8794 ±  6%    +168.8%      23638 ±  9%  softirqs.CPU109.RCU
     36432           +14.9%      41845 ±  2%  softirqs.CPU109.SCHED
      8961 ±  3%    +156.7%      23008 ± 10%  softirqs.CPU11.RCU
     36967           +16.2%      42944 ±  3%  softirqs.CPU11.SCHED
      8811 ±  3%    +168.7%      23679 ±  9%  softirqs.CPU110.RCU
     36694           +14.0%      41823        softirqs.CPU110.SCHED
      8740 ±  3%    +168.7%      23482 ±  9%  softirqs.CPU111.RCU
     36615           +14.8%      42039        softirqs.CPU111.SCHED
      8753 ±  4%    +152.6%      22110 ±  9%  softirqs.CPU112.RCU
     34222 ± 10%     +23.1%      42114        softirqs.CPU112.SCHED
      8767 ±  4%    +148.2%      21759 ±  7%  softirqs.CPU113.RCU
     32174 ± 15%     +33.3%      42892 ±  2%  softirqs.CPU113.SCHED
      8833 ±  3%    +151.4%      22207 ±  8%  softirqs.CPU114.RCU
     36688           +14.9%      42170        softirqs.CPU114.SCHED
      8857 ±  6%    +148.4%      22000 ±  8%  softirqs.CPU115.RCU
     36523           +14.3%      41734 ±  2%  softirqs.CPU115.SCHED
      8767 ±  4%    +152.1%      22103 ±  7%  softirqs.CPU116.RCU
     36614           +14.8%      42051        softirqs.CPU116.SCHED
      8928 ±  2%    +147.7%      22120 ±  8%  softirqs.CPU117.RCU
     36080 ±  5%     +12.9%      40746 ±  3%  softirqs.CPU117.SCHED
      8723 ±  4%    +153.7%      22133 ±  9%  softirqs.CPU118.RCU
     36878           +14.5%      42219        softirqs.CPU118.SCHED
      8716 ±  5%    +153.3%      22078 ±  9%  softirqs.CPU119.RCU
     35451 ±  7%     +18.6%      42050 ±  2%  softirqs.CPU119.SCHED
      9006 ±  2%    +159.7%      23386 ±  8%  softirqs.CPU12.RCU
     33337 ± 19%     +24.8%      41589 ±  2%  softirqs.CPU12.SCHED
      9041 ±  8%    +153.7%      22940 ± 10%  softirqs.CPU120.RCU
      8568 ±  4%    +161.3%      22389 ± 11%  softirqs.CPU121.RCU
     36059 ±  3%     +17.1%      42220        softirqs.CPU121.SCHED
      8673 ±  5%    +155.6%      22170 ± 11%  softirqs.CPU122.RCU
     36904           +14.4%      42209        softirqs.CPU122.SCHED
      8604 ±  4%    +164.2%      22734 ± 14%  softirqs.CPU123.RCU
     36973           +11.2%      41121 ±  5%  softirqs.CPU123.SCHED
      8617 ±  3%    +158.4%      22270 ± 10%  softirqs.CPU124.RCU
     36771 ±  2%     +15.1%      42332        softirqs.CPU124.SCHED
      8649 ±  3%    +156.9%      22219 ± 11%  softirqs.CPU125.RCU
     36819           +15.1%      42380        softirqs.CPU125.SCHED
      8699 ±  2%    +156.1%      22279 ± 11%  softirqs.CPU126.RCU
     36230 ±  4%     +16.7%      42282        softirqs.CPU126.SCHED
      8627 ±  4%    +158.5%      22306 ± 11%  softirqs.CPU127.RCU
     36525           +15.7%      42268        softirqs.CPU127.SCHED
      8596 ±  4%    +179.5%      24026 ± 13%  softirqs.CPU128.RCU
     34698 ± 10%     +21.9%      42306        softirqs.CPU128.SCHED
      8694 ±  2%    +174.3%      23852 ± 13%  softirqs.CPU129.RCU
     35418 ±  7%     +18.7%      42037        softirqs.CPU129.SCHED
      9082 ±  2%    +157.1%      23352 ±  9%  softirqs.CPU13.RCU
     35266 ±  8%     +19.0%      41954 ±  2%  softirqs.CPU13.SCHED
      8603 ±  3%    +178.0%      23918 ± 13%  softirqs.CPU130.RCU
      8684 ±  2%    +180.0%      24314 ± 13%  softirqs.CPU131.RCU
     36756 ±  2%     +14.9%      42233        softirqs.CPU131.SCHED
      8720 ±  3%    +177.7%      24218 ± 13%  softirqs.CPU132.RCU
     36747           +14.6%      42095        softirqs.CPU132.SCHED
      8637 ±  2%    +177.4%      23963 ± 13%  softirqs.CPU133.RCU
     36496           +15.2%      42052        softirqs.CPU133.SCHED
      8525 ±  3%    +179.5%      23823 ± 12%  softirqs.CPU134.RCU
     36286 ±  2%     +15.4%      41882        softirqs.CPU134.SCHED
      8753          +171.0%      23723 ± 14%  softirqs.CPU135.RCU
     36807           +16.8%      42989 ±  3%  softirqs.CPU135.SCHED
      8611 ±  3%    +184.7%      24518 ±  9%  softirqs.CPU136.RCU
     36481           +15.5%      42141        softirqs.CPU136.SCHED
      8729 ±  3%    +177.3%      24202 ± 13%  softirqs.CPU137.RCU
     36853           +14.3%      42107        softirqs.CPU137.SCHED
      8613 ±  4%    +184.8%      24528 ± 13%  softirqs.CPU138.RCU
     36764           +15.1%      42317        softirqs.CPU138.SCHED
      8620 ±  3%    +175.8%      23771 ± 11%  softirqs.CPU139.RCU
      9816 ±  6%    +145.6%      24107 ±  9%  softirqs.CPU14.RCU
     36928           +13.9%      42060        softirqs.CPU14.SCHED
      8647 ±  3%    +176.6%      23921 ± 12%  softirqs.CPU140.RCU
     36901           +14.5%      42247        softirqs.CPU140.SCHED
      9132 ±  5%    +162.2%      23946 ± 12%  softirqs.CPU141.RCU
     35892 ±  3%     +17.4%      42128        softirqs.CPU141.SCHED
      8711 ±  3%    +176.4%      24079 ± 13%  softirqs.CPU142.RCU
     36811 ±  2%     +14.9%      42297        softirqs.CPU142.SCHED
      9133 ±  6%    +166.2%      24311 ± 13%  softirqs.CPU143.RCU
     36958           +14.5%      42303        softirqs.CPU143.SCHED
      8390          +195.8%      24816 ± 11%  softirqs.CPU144.RCU
     36622           +16.1%      42520        softirqs.CPU144.SCHED
      8659 ±  5%    +179.2%      24174 ± 11%  softirqs.CPU145.RCU
     36223           +17.1%      42409        softirqs.CPU145.SCHED
      8521          +187.0%      24455 ± 11%  softirqs.CPU146.RCU
     37172           +14.1%      42408        softirqs.CPU146.SCHED
      8447          +189.0%      24413 ± 11%  softirqs.CPU147.RCU
     36910           +15.2%      42503        softirqs.CPU147.SCHED
      8600          +179.6%      24043 ± 11%  softirqs.CPU148.RCU
     36834           +14.9%      42310        softirqs.CPU148.SCHED
      8560 ±  2%    +187.2%      24585 ± 11%  softirqs.CPU149.RCU
     35934 ±  4%     +18.0%      42387        softirqs.CPU149.SCHED
      9415 ± 10%    +151.8%      23709 ± 10%  softirqs.CPU15.RCU
      8420 ±  4%    +189.3%      24357 ± 11%  softirqs.CPU150.RCU
     36758           +15.2%      42343        softirqs.CPU150.SCHED
      8346 ±  2%    +188.6%      24085 ± 11%  softirqs.CPU151.RCU
     36259           +17.0%      42433        softirqs.CPU151.SCHED
      8566 ±  2%    +184.7%      24388 ± 11%  softirqs.CPU152.RCU
     36466 ±  2%     +16.1%      42327        softirqs.CPU152.SCHED
      8444          +186.3%      24173 ± 11%  softirqs.CPU153.RCU
     36825           +14.9%      42299        softirqs.CPU153.SCHED
      8532          +188.1%      24580 ± 11%  softirqs.CPU154.RCU
     36855           +15.0%      42372        softirqs.CPU154.SCHED
      8474          +190.6%      24628 ± 11%  softirqs.CPU155.RCU
     36886           +14.9%      42385        softirqs.CPU155.SCHED
      8364          +186.8%      23987 ± 11%  softirqs.CPU156.RCU
     36681           +15.3%      42298        softirqs.CPU156.SCHED
      8416 ±  2%    +189.3%      24344 ± 11%  softirqs.CPU157.RCU
     35229 ±  4%     +19.5%      42109        softirqs.CPU157.SCHED
      8367          +192.3%      24460 ± 11%  softirqs.CPU158.RCU
     36545           +15.9%      42342        softirqs.CPU158.SCHED
      8496 ±  2%    +188.8%      24535 ± 11%  softirqs.CPU159.RCU
     36626           +15.7%      42377        softirqs.CPU159.SCHED
      9064 ±  3%    +147.9%      22469 ±  9%  softirqs.CPU16.RCU
     36606           +15.3%      42206        softirqs.CPU16.SCHED
      8523          +166.3%      22701 ± 11%  softirqs.CPU160.RCU
     36780           +15.5%      42463        softirqs.CPU160.SCHED
      8654 ±  3%    +163.0%      22758 ± 10%  softirqs.CPU161.RCU
     30196 ± 39%     +40.2%      42339        softirqs.CPU161.SCHED
      8529 ±  3%    +166.4%      22724 ± 12%  softirqs.CPU162.RCU
     36548           +15.8%      42321        softirqs.CPU162.SCHED
      8583 ±  4%    +165.9%      22820 ± 10%  softirqs.CPU163.RCU
     36551           +15.8%      42326        softirqs.CPU163.SCHED
      8736 ±  6%    +161.2%      22818 ± 11%  softirqs.CPU164.RCU
     36843           +15.1%      42416        softirqs.CPU164.SCHED
      8494 ±  3%    +163.7%      22397 ± 10%  softirqs.CPU165.RCU
     36770           +15.2%      42372        softirqs.CPU165.SCHED
      8519          +169.1%      22929 ± 11%  softirqs.CPU166.RCU
     35566 ±  3%     +19.6%      42522        softirqs.CPU166.SCHED
      8477          +174.1%      23237 ± 10%  softirqs.CPU167.RCU
     37004           +14.7%      42430        softirqs.CPU167.SCHED
      8218 ±  2%    +164.5%      21737 ± 14%  softirqs.CPU168.RCU
     36833           +15.6%      42594        softirqs.CPU168.SCHED
      8200          +157.1%      21081 ± 13%  softirqs.CPU169.RCU
     34932 ±  8%     +20.5%      42103        softirqs.CPU169.SCHED
      9054 ±  3%    +140.2%      21746 ±  7%  softirqs.CPU17.RCU
      8072 ±  2%    +160.8%      21050 ± 14%  softirqs.CPU170.RCU
     37041           +13.8%      42139        softirqs.CPU170.SCHED
      8243 ±  3%    +156.1%      21108 ± 14%  softirqs.CPU171.RCU
     36950           +14.1%      42151        softirqs.CPU171.SCHED
      8243 ±  3%    +156.7%      21159 ± 14%  softirqs.CPU172.RCU
     35076 ±  9%     +20.3%      42211        softirqs.CPU172.SCHED
      9350 ± 16%    +127.9%      21310 ± 14%  softirqs.CPU173.RCU
     35579 ±  4%     +18.6%      42200        softirqs.CPU173.SCHED
      8226 ±  2%    +159.9%      21383 ± 14%  softirqs.CPU174.RCU
     36991           +14.2%      42241        softirqs.CPU174.SCHED
      8276 ±  3%    +156.1%      21195 ± 14%  softirqs.CPU175.RCU
     37055           +15.6%      42843 ±  2%  softirqs.CPU175.SCHED
      8476 ±  4%    +166.9%      22622 ± 14%  softirqs.CPU176.RCU
     37290           +12.9%      42095        softirqs.CPU176.SCHED
      8293 ±  2%    +176.4%      22921 ± 14%  softirqs.CPU177.RCU
      8258 ±  3%    +175.5%      22750 ± 14%  softirqs.CPU178.RCU
     35972 ±  3%     +17.4%      42231        softirqs.CPU178.SCHED
      8271 ±  4%    +174.9%      22736 ± 14%  softirqs.CPU179.RCU
     37133           +13.8%      42272        softirqs.CPU179.SCHED
      9148 ±  4%    +145.6%      22469 ±  9%  softirqs.CPU18.RCU
     36457           +14.8%      41845 ±  3%  softirqs.CPU18.SCHED
      8362 ±  6%    +172.8%      22811 ± 14%  softirqs.CPU180.RCU
     35142 ±  8%     +19.7%      42082        softirqs.CPU180.SCHED
      8215 ±  4%    +172.5%      22389 ± 14%  softirqs.CPU181.RCU
     36431           +15.1%      41917        softirqs.CPU181.SCHED
      8191 ±  4%    +175.9%      22599 ± 13%  softirqs.CPU182.RCU
     36842           +14.1%      42033        softirqs.CPU182.SCHED
      8250 ±  2%    +175.9%      22764 ± 14%  softirqs.CPU183.RCU
     37102           +13.7%      42195        softirqs.CPU183.SCHED
      8217 ±  3%    +189.6%      23797 ± 16%  softirqs.CPU184.RCU
     37031           +14.1%      42259        softirqs.CPU184.SCHED
      8280 ±  4%    +173.4%      22640 ± 14%  softirqs.CPU185.RCU
     37074           +13.9%      42226        softirqs.CPU185.SCHED
      8293 ±  5%    +173.4%      22678 ± 14%  softirqs.CPU186.RCU
     36842           +14.1%      42030        softirqs.CPU186.SCHED
      8230 ±  3%    +179.2%      22981 ± 14%  softirqs.CPU187.RCU
     36985           +14.0%      42181        softirqs.CPU187.SCHED
      8192 ±  2%    +177.8%      22754 ± 14%  softirqs.CPU188.RCU
     37167           +13.2%      42086        softirqs.CPU188.SCHED
      8392 ±  4%    +173.5%      22950 ± 14%  softirqs.CPU189.RCU
     32862 ± 20%     +28.0%      42054        softirqs.CPU189.SCHED
      8969 ±  5%    +148.1%      22251 ±  9%  softirqs.CPU19.RCU
     36427           +15.0%      41877        softirqs.CPU19.SCHED
      8352 ±  4%    +175.4%      22999 ± 12%  softirqs.CPU190.RCU
     36488           +15.6%      42184        softirqs.CPU190.SCHED
      8316 ±  2%    +169.9%      22447 ± 13%  softirqs.CPU191.RCU
     36926           +11.6%      41195 ±  2%  softirqs.CPU191.SCHED
      9326 ±  4%    +158.7%      24130 ± 10%  softirqs.CPU2.RCU
     36357 ±  2%     +16.4%      42312        softirqs.CPU2.SCHED
      9089 ±  4%    +144.6%      22228 ±  8%  softirqs.CPU20.RCU
     36405           +15.5%      42065        softirqs.CPU20.SCHED
      9052 ±  4%    +148.4%      22488 ±  9%  softirqs.CPU21.RCU
      9054 ±  3%    +150.7%      22700 ±  8%  softirqs.CPU22.RCU
     36727           +14.6%      42108        softirqs.CPU22.SCHED
      9295 ±  2%    +139.3%      22247 ±  9%  softirqs.CPU23.RCU
     36677           +14.8%      42092        softirqs.CPU23.SCHED
      9037 ±  4%    +155.3%      23069 ± 12%  softirqs.CPU24.RCU
     36766           +16.3%      42763        softirqs.CPU24.SCHED
      8818 ±  3%    +151.5%      22180 ± 10%  softirqs.CPU25.RCU
     35807 ±  3%     +17.8%      42173        softirqs.CPU25.SCHED
      8850 ±  3%    +151.3%      22240 ± 11%  softirqs.CPU26.RCU
     34656 ± 10%     +22.0%      42284        softirqs.CPU26.SCHED
      8951 ±  3%    +151.3%      22494 ± 11%  softirqs.CPU27.RCU
     36709           +15.1%      42243        softirqs.CPU27.SCHED
     10067 ± 17%    +123.4%      22489 ± 10%  softirqs.CPU28.RCU
      8987 ±  3%    +153.3%      22763 ± 11%  softirqs.CPU29.RCU
     36696           +15.4%      42355        softirqs.CPU29.SCHED
      9228 ±  4%    +160.8%      24064 ± 10%  softirqs.CPU3.RCU
     34189 ± 13%     +23.8%      42332        softirqs.CPU3.SCHED
      8811 ±  5%    +156.3%      22583 ± 11%  softirqs.CPU30.RCU
     36454 ±  2%     +15.9%      42258        softirqs.CPU30.SCHED
      8873 ±  4%    +151.6%      22322 ± 11%  softirqs.CPU31.RCU
     36527           +15.7%      42274        softirqs.CPU31.SCHED
      9042 ±  2%    +163.8%      23852 ± 12%  softirqs.CPU32.RCU
     36100           +16.9%      42210        softirqs.CPU32.SCHED
      8908 ±  3%    +165.1%      23615 ± 12%  softirqs.CPU33.RCU
      8954 ±  3%    +170.2%      24195 ± 13%  softirqs.CPU34.RCU
     36214           +16.7%      42251        softirqs.CPU34.SCHED
      9187          +163.4%      24202 ± 13%  softirqs.CPU35.RCU
     36507           +14.6%      41825        softirqs.CPU35.SCHED
      9069 ±  3%    +169.1%      24405 ± 13%  softirqs.CPU36.RCU
     36578           +15.6%      42267        softirqs.CPU36.SCHED
      8963 ±  3%    +171.8%      24358 ± 14%  softirqs.CPU37.RCU
     34994 ±  5%     +20.2%      42079        softirqs.CPU37.SCHED
      8932 ±  3%    +173.5%      24427 ± 10%  softirqs.CPU38.RCU
     36137           +16.4%      42077        softirqs.CPU38.SCHED
      9322 ±  4%    +149.7%      23276 ± 16%  softirqs.CPU39.RCU
     36374           +16.0%      42201        softirqs.CPU39.SCHED
      9144 ±  4%    +162.2%      23977 ±  9%  softirqs.CPU4.RCU
     33161 ± 18%     +26.3%      41892        softirqs.CPU4.SCHED
      8953 ±  3%    +168.3%      24025 ± 12%  softirqs.CPU40.RCU
     36479           +15.6%      42186        softirqs.CPU40.SCHED
      9324 ±  6%    +160.2%      24256 ± 13%  softirqs.CPU41.RCU
     36186 ±  2%     +16.8%      42261        softirqs.CPU41.SCHED
      9020 ±  3%    +170.9%      24436 ± 12%  softirqs.CPU42.RCU
     36433           +16.0%      42255        softirqs.CPU42.SCHED
      8983 ±  3%    +169.8%      24238 ± 13%  softirqs.CPU43.RCU
     36587           +15.3%      42191        softirqs.CPU43.SCHED
      8912 ±  3%    +166.2%      23725 ± 12%  softirqs.CPU44.RCU
     36659           +15.0%      42158        softirqs.CPU44.SCHED
      9058 ±  3%    +162.8%      23801 ± 12%  softirqs.CPU45.RCU
     36559           +15.4%      42181        softirqs.CPU45.SCHED
      8949 ±  3%    +170.7%      24223 ± 13%  softirqs.CPU46.RCU
     36581           +15.6%      42278        softirqs.CPU46.SCHED
      9046 ±  2%    +167.4%      24187 ± 12%  softirqs.CPU47.RCU
     36555           +15.5%      42202        softirqs.CPU47.SCHED
      8875 ±  4%    +183.2%      25133 ± 11%  softirqs.CPU48.RCU
     35927 ±  6%     +18.8%      42694        softirqs.CPU48.SCHED
      8582 ±  2%    +183.1%      24291 ± 10%  softirqs.CPU49.RCU
     36195           +17.0%      42354        softirqs.CPU49.SCHED
      9099 ±  4%    +161.9%      23833 ±  9%  softirqs.CPU5.RCU
     36206 ±  2%     +16.8%      42305        softirqs.CPU5.SCHED
      8808 ±  2%    +177.7%      24457 ± 11%  softirqs.CPU50.RCU
     36560           +15.9%      42388        softirqs.CPU50.SCHED
      8741          +183.6%      24789 ± 11%  softirqs.CPU51.RCU
     36497           +16.2%      42393        softirqs.CPU51.SCHED
      8823 ±  2%    +176.0%      24354 ± 11%  softirqs.CPU52.RCU
     36000 ±  3%     +17.4%      42247        softirqs.CPU52.SCHED
      8957 ±  2%    +175.2%      24648 ± 11%  softirqs.CPU53.RCU
     35929 ±  4%     +17.9%      42373        softirqs.CPU53.SCHED
      8717 ±  3%    +187.8%      25092 ± 12%  softirqs.CPU54.RCU
     37177 ±  2%     +14.7%      42647 ±  2%  softirqs.CPU54.SCHED
      8741 ±  2%    +181.7%      24620 ± 11%  softirqs.CPU55.RCU
     36406           +16.7%      42484        softirqs.CPU55.SCHED
      8681 ±  2%    +183.8%      24638 ± 10%  softirqs.CPU56.RCU
     36449           +15.1%      41936 ±  3%  softirqs.CPU56.SCHED
      8743          +178.3%      24332 ± 10%  softirqs.CPU57.RCU
     35188 ±  5%     +20.6%      42431        softirqs.CPU57.SCHED
      8774 ±  2%    +181.1%      24662 ± 11%  softirqs.CPU58.RCU
     36475           +16.2%      42392        softirqs.CPU58.SCHED
      8791          +183.8%      24946 ± 10%  softirqs.CPU59.RCU
     36478           +16.2%      42395        softirqs.CPU59.SCHED
      9108 ±  5%    +161.4%      23813 ±  9%  softirqs.CPU6.RCU
      8705 ±  2%    +180.7%      24439 ± 10%  softirqs.CPU60.RCU
     36494           +16.2%      42394        softirqs.CPU60.SCHED
      8742 ±  2%    +179.3%      24418 ± 11%  softirqs.CPU61.RCU
     36403           +16.5%      42396        softirqs.CPU61.SCHED
      8688          +184.9%      24751 ±  8%  softirqs.CPU62.RCU
     36392           +16.0%      42223 ±  2%  softirqs.CPU62.SCHED
      8710          +180.2%      24409 ± 11%  softirqs.CPU63.RCU
     34773 ±  7%     +22.0%      42415        softirqs.CPU63.SCHED
      8862          +163.2%      23323 ± 11%  softirqs.CPU64.RCU
     36578           +15.8%      42355        softirqs.CPU64.SCHED
      9147 ±  5%    +152.6%      23101 ± 10%  softirqs.CPU65.RCU
     36135           +17.6%      42486        softirqs.CPU65.SCHED
      8811          +161.9%      23074 ± 11%  softirqs.CPU66.RCU
     36313           +16.8%      42407        softirqs.CPU66.SCHED
      8783 ±  2%    +166.6%      23419 ± 10%  softirqs.CPU67.RCU
     36134 ±  2%     +16.4%      42070 ±  2%  softirqs.CPU67.SCHED
      8767          +175.0%      24108 ±  5%  softirqs.CPU68.RCU
     36375           +16.5%      42365        softirqs.CPU68.SCHED
      8950 ±  5%    +160.0%      23275 ± 10%  softirqs.CPU69.RCU
     36574           +15.8%      42351        softirqs.CPU69.SCHED
      9032 ±  2%    +166.3%      24057 ±  9%  softirqs.CPU7.RCU
     36498           +14.8%      41906 ±  3%  softirqs.CPU7.SCHED
      8756          +163.9%      23105 ± 10%  softirqs.CPU70.RCU
      8870 ±  2%    +159.9%      23055 ± 10%  softirqs.CPU71.RCU
     36239           +17.3%      42518        softirqs.CPU71.SCHED
      8735 ±  4%    +154.4%      22225 ± 12%  softirqs.CPU72.RCU
     37073           +15.6%      42851        softirqs.CPU72.SCHED
      8476 ±  2%    +155.7%      21675 ± 13%  softirqs.CPU73.RCU
     36800           +14.5%      42146        softirqs.CPU73.SCHED
      8601 ±  3%    +151.1%      21597 ± 13%  softirqs.CPU74.RCU
     36993           +14.1%      42194        softirqs.CPU74.SCHED
      8595 ±  3%    +153.1%      21754 ± 14%  softirqs.CPU75.RCU
     36866           +14.5%      42217        softirqs.CPU75.SCHED
      8512 ±  2%    +152.7%      21510 ± 13%  softirqs.CPU76.RCU
     36504           +15.5%      42162        softirqs.CPU76.SCHED
      8445 ±  2%    +154.6%      21503 ± 14%  softirqs.CPU77.RCU
     36953           +14.6%      42356        softirqs.CPU77.SCHED
      8459 ±  3%    +157.3%      21769 ± 14%  softirqs.CPU78.RCU
     36966           +14.3%      42240        softirqs.CPU78.SCHED
      8615 ±  3%    +146.6%      21246 ± 14%  softirqs.CPU79.RCU
     36817           +14.6%      42192        softirqs.CPU79.SCHED
      9188 ±  4%    +160.4%      23927 ±  8%  softirqs.CPU8.RCU
     35750 ±  4%     +17.9%      42132        softirqs.CPU8.SCHED
      8535 ±  2%    +167.3%      22816 ± 14%  softirqs.CPU80.RCU
     36354 ±  2%     +15.8%      42113        softirqs.CPU80.SCHED
      8468 ±  2%    +171.4%      22986 ± 14%  softirqs.CPU81.RCU
     35271 ±  7%     +19.5%      42161        softirqs.CPU81.SCHED
      8583 ±  3%    +166.6%      22881 ± 13%  softirqs.CPU82.RCU
     36810           +14.8%      42275        softirqs.CPU82.SCHED
      8483 ±  3%    +173.7%      23218 ± 14%  softirqs.CPU83.RCU
     36369 ±  2%     +15.9%      42136        softirqs.CPU83.SCHED
      8512 ±  4%    +166.7%      22704 ± 14%  softirqs.CPU84.RCU
     36672           +13.4%      41601 ±  3%  softirqs.CPU84.SCHED
      8411 ±  3%    +170.7%      22771 ± 13%  softirqs.CPU85.RCU
     36325 ±  3%     +15.8%      42054        softirqs.CPU85.SCHED
      8472 ±  2%    +169.8%      22856 ± 13%  softirqs.CPU86.RCU
     33424 ± 16%     +26.1%      42137        softirqs.CPU86.SCHED
      8681 ±  5%    +162.4%      22781 ± 14%  softirqs.CPU87.RCU
     37166           +13.5%      42185        softirqs.CPU87.SCHED
      8827 ±  6%    +158.8%      22846 ± 14%  softirqs.CPU88.RCU
     36737           +15.0%      42244        softirqs.CPU88.SCHED
      8507 ±  3%    +171.0%      23051 ± 14%  softirqs.CPU89.RCU
      8967 ±  4%    +163.3%      23609 ±  9%  softirqs.CPU9.RCU
     36649           +14.0%      41796        softirqs.CPU9.SCHED
      8437 ±  2%    +170.9%      22853 ± 14%  softirqs.CPU90.RCU
     36763           +12.1%      41197 ±  2%  softirqs.CPU90.SCHED
      8454 ±  3%    +172.9%      23067 ± 14%  softirqs.CPU91.RCU
     36976           +14.1%      42200        softirqs.CPU91.SCHED
      8400 ±  3%    +174.3%      23039 ± 13%  softirqs.CPU92.RCU
     36135 ±  3%     +16.6%      42140        softirqs.CPU92.SCHED
      8410 ±  2%    +170.4%      22746 ± 13%  softirqs.CPU93.RCU
     34303 ± 10%     +22.8%      42134        softirqs.CPU93.SCHED
      8852 ±  6%    +159.2%      22944 ± 14%  softirqs.CPU94.RCU
     36636           +15.4%      42262        softirqs.CPU94.SCHED
      8531 ±  2%    +163.9%      22517 ± 12%  softirqs.CPU95.RCU
      8676 ±  4%    +182.5%      24507 ± 14%  softirqs.CPU96.RCU
     36310 ±  5%     +14.4%      41553 ±  2%  softirqs.CPU96.SCHED
      8837 ±  3%    +163.2%      23265 ±  9%  softirqs.CPU97.RCU
     36613           +12.7%      41251        softirqs.CPU97.SCHED
      9017 ±  4%    +166.8%      24056 ± 10%  softirqs.CPU98.RCU
     36646           +14.5%      41963        softirqs.CPU98.SCHED
      8740 ±  3%    +170.7%      23658 ±  9%  softirqs.CPU99.RCU
      9564 ± 46%     -61.0%       3731 ± 24%  softirqs.NET_RX
   1679865 ±  2%    +166.2%    4471848 ± 11%  softirqs.RCU
   6961169           +15.7%    8051724        softirqs.SCHED
     61650           -21.7%      48273 ±  4%  softirqs.TIMER
    694214 ±  2%    +251.0%    2436630 ±  4%  interrupts.CAL:Function_call_interrupts
      3524 ± 11%    +236.6%      11864 ± 18%  interrupts.CPU0.CAL:Function_call_interrupts
    161.75 ± 10%    +343.7%     717.75 ± 12%  interrupts.CPU0.RES:Rescheduling_interrupts
      3930 ± 11%    +235.5%      13186 ±  8%  interrupts.CPU1.CAL:Function_call_interrupts
    976.00 ± 30%     -52.0%     468.50 ± 14%  interrupts.CPU1.NMI:Non-maskable_interrupts
    976.00 ± 30%     -52.0%     468.50 ± 14%  interrupts.CPU1.PMI:Performance_monitoring_interrupts
    148.75 ± 13%    +267.4%     546.50 ± 21%  interrupts.CPU1.RES:Rescheduling_interrupts
      3441 ±  2%    +270.4%      12749 ±  9%  interrupts.CPU10.CAL:Function_call_interrupts
      1117 ± 19%     -58.0%     469.75 ± 14%  interrupts.CPU10.NMI:Non-maskable_interrupts
      1117 ± 19%     -58.0%     469.75 ± 14%  interrupts.CPU10.PMI:Performance_monitoring_interrupts
    123.50 ± 16%    +372.7%     583.75 ± 13%  interrupts.CPU10.RES:Rescheduling_interrupts
    117.25 ± 58%    +141.8%     283.50 ± 15%  interrupts.CPU10.TLB:TLB_shootdowns
      3545 ±  5%    +269.0%      13082 ±  9%  interrupts.CPU100.CAL:Function_call_interrupts
      1175 ± 43%     -59.9%     471.00 ± 16%  interrupts.CPU100.NMI:Non-maskable_interrupts
      1175 ± 43%     -59.9%     471.00 ± 16%  interrupts.CPU100.PMI:Performance_monitoring_interrupts
    128.50 ±  9%    +413.2%     659.50 ± 18%  interrupts.CPU100.RES:Rescheduling_interrupts
      3591 ±  7%    +261.4%      12979 ±  9%  interrupts.CPU101.CAL:Function_call_interrupts
      1025 ± 30%     -60.0%     410.00 ± 25%  interrupts.CPU101.NMI:Non-maskable_interrupts
      1025 ± 30%     -60.0%     410.00 ± 25%  interrupts.CPU101.PMI:Performance_monitoring_interrupts
    126.00 ± 14%    +420.8%     656.25 ± 19%  interrupts.CPU101.RES:Rescheduling_interrupts
    122.00 ± 54%    +142.4%     295.75 ± 10%  interrupts.CPU101.TLB:TLB_shootdowns
      3522 ±  6%    +267.8%      12953 ± 10%  interrupts.CPU102.CAL:Function_call_interrupts
      1179 ± 23%     -59.8%     474.50 ± 15%  interrupts.CPU102.NMI:Non-maskable_interrupts
      1179 ± 23%     -59.8%     474.50 ± 15%  interrupts.CPU102.PMI:Performance_monitoring_interrupts
    114.50 ±  5%   +1108.1%       1383 ± 84%  interrupts.CPU102.RES:Rescheduling_interrupts
      3595 ±  2%    +268.4%      13246 ± 12%  interrupts.CPU103.CAL:Function_call_interrupts
      1203 ± 29%     -67.0%     397.25 ± 24%  interrupts.CPU103.NMI:Non-maskable_interrupts
      1203 ± 29%     -67.0%     397.25 ± 24%  interrupts.CPU103.PMI:Performance_monitoring_interrupts
    133.00 ± 16%    +417.1%     687.75 ± 22%  interrupts.CPU103.RES:Rescheduling_interrupts
      3595 ±  3%    +258.8%      12900 ± 11%  interrupts.CPU104.CAL:Function_call_interrupts
      1014 ± 23%     -52.5%     481.75 ± 15%  interrupts.CPU104.NMI:Non-maskable_interrupts
      1014 ± 23%     -52.5%     481.75 ± 15%  interrupts.CPU104.PMI:Performance_monitoring_interrupts
    122.25 ± 21%    +420.2%     636.00 ± 19%  interrupts.CPU104.RES:Rescheduling_interrupts
      3644 ±  5%    +256.4%      12988 ± 11%  interrupts.CPU105.CAL:Function_call_interrupts
      1185 ± 18%     -60.8%     464.50 ± 14%  interrupts.CPU105.NMI:Non-maskable_interrupts
      1185 ± 18%     -60.8%     464.50 ± 14%  interrupts.CPU105.PMI:Performance_monitoring_interrupts
    134.00 ± 27%    +331.5%     578.25 ± 19%  interrupts.CPU105.RES:Rescheduling_interrupts
      3561 ±  3%    +269.3%      13152 ± 10%  interrupts.CPU106.CAL:Function_call_interrupts
      1209 ± 21%     -71.5%     345.25 ± 34%  interrupts.CPU106.NMI:Non-maskable_interrupts
      1209 ± 21%     -71.5%     345.25 ± 34%  interrupts.CPU106.PMI:Performance_monitoring_interrupts
    128.50 ± 34%    +370.0%     604.00 ± 16%  interrupts.CPU106.RES:Rescheduling_interrupts
    116.00 ± 53%    +166.2%     308.75 ± 12%  interrupts.CPU106.TLB:TLB_shootdowns
      3722 ±  5%    +255.6%      13235 ± 11%  interrupts.CPU107.CAL:Function_call_interrupts
    974.50 ± 23%     -50.5%     482.00 ± 13%  interrupts.CPU107.NMI:Non-maskable_interrupts
    974.50 ± 23%     -50.5%     482.00 ± 13%  interrupts.CPU107.PMI:Performance_monitoring_interrupts
    134.75 ± 10%    +418.9%     699.25 ± 18%  interrupts.CPU107.RES:Rescheduling_interrupts
      3858 ±  8%    +236.2%      12969 ±  7%  interrupts.CPU108.CAL:Function_call_interrupts
      1225 ± 13%     -67.0%     403.75 ± 21%  interrupts.CPU108.NMI:Non-maskable_interrupts
      1225 ± 13%     -67.0%     403.75 ± 21%  interrupts.CPU108.PMI:Performance_monitoring_interrupts
    133.25 ± 23%    +448.6%     731.00 ± 17%  interrupts.CPU108.RES:Rescheduling_interrupts
      4061 ± 16%    +222.0%      13079 ± 12%  interrupts.CPU109.CAL:Function_call_interrupts
      1018 ± 26%     -58.2%     425.75 ± 33%  interrupts.CPU109.NMI:Non-maskable_interrupts
      1018 ± 26%     -58.2%     425.75 ± 33%  interrupts.CPU109.PMI:Performance_monitoring_interrupts
    128.00 ± 21%    +381.2%     616.00 ± 17%  interrupts.CPU109.RES:Rescheduling_interrupts
    135.75 ± 13%     +80.3%     244.75 ± 26%  interrupts.CPU109.TLB:TLB_shootdowns
      3488 ±  3%    +275.7%      13105 ± 10%  interrupts.CPU11.CAL:Function_call_interrupts
    934.50 ± 21%     -53.7%     433.00 ± 33%  interrupts.CPU11.NMI:Non-maskable_interrupts
    934.50 ± 21%     -53.7%     433.00 ± 33%  interrupts.CPU11.PMI:Performance_monitoring_interrupts
    124.50 ± 15%    +398.8%     621.00 ± 14%  interrupts.CPU11.RES:Rescheduling_interrupts
    176.50 ± 40%     +59.2%     281.00 ± 12%  interrupts.CPU11.TLB:TLB_shootdowns
      3576 ±  4%    +260.6%      12899 ± 10%  interrupts.CPU110.CAL:Function_call_interrupts
    953.25 ± 19%     -49.4%     482.00 ± 15%  interrupts.CPU110.NMI:Non-maskable_interrupts
    953.25 ± 19%     -49.4%     482.00 ± 15%  interrupts.CPU110.PMI:Performance_monitoring_interrupts
    173.50 ± 43%    +445.5%     946.50 ± 67%  interrupts.CPU110.RES:Rescheduling_interrupts
    152.25 ± 55%    +104.8%     311.75 ±  9%  interrupts.CPU110.TLB:TLB_shootdowns
      3540          +266.9%      12990 ± 10%  interrupts.CPU111.CAL:Function_call_interrupts
      1165 ± 10%     -63.1%     430.25 ± 32%  interrupts.CPU111.NMI:Non-maskable_interrupts
      1165 ± 10%     -63.1%     430.25 ± 32%  interrupts.CPU111.PMI:Performance_monitoring_interrupts
    122.50 ± 22%    +375.9%     583.00 ± 16%  interrupts.CPU111.RES:Rescheduling_interrupts
      3935 ± 11%    +232.1%      13070 ± 10%  interrupts.CPU112.CAL:Function_call_interrupts
      1054 ± 11%     -65.2%     367.00 ± 35%  interrupts.CPU112.NMI:Non-maskable_interrupts
      1054 ± 11%     -65.2%     367.00 ± 35%  interrupts.CPU112.PMI:Performance_monitoring_interrupts
    145.75 ±  9%    +360.9%     671.75 ± 27%  interrupts.CPU112.RES:Rescheduling_interrupts
      3502 ±  5%    +280.2%      13316 ±  8%  interrupts.CPU113.CAL:Function_call_interrupts
      1085 ± 31%     -55.0%     488.25 ± 15%  interrupts.CPU113.NMI:Non-maskable_interrupts
      1085 ± 31%     -55.0%     488.25 ± 15%  interrupts.CPU113.PMI:Performance_monitoring_interrupts
    138.50 ± 11%    +481.8%     805.75 ± 31%  interrupts.CPU113.RES:Rescheduling_interrupts
    136.50 ± 82%    +115.8%     294.50 ± 25%  interrupts.CPU113.TLB:TLB_shootdowns
      3628 ±  4%    +259.6%      13048 ±  9%  interrupts.CPU114.CAL:Function_call_interrupts
      1108 ± 30%     -56.6%     481.00 ± 14%  interrupts.CPU114.NMI:Non-maskable_interrupts
      1108 ± 30%     -56.6%     481.00 ± 14%  interrupts.CPU114.PMI:Performance_monitoring_interrupts
    129.25 ± 13%    +438.5%     696.00 ± 26%  interrupts.CPU114.RES:Rescheduling_interrupts
      3483 ±  3%    +277.8%      13157 ± 10%  interrupts.CPU115.CAL:Function_call_interrupts
      1167 ± 21%     -59.4%     473.75 ± 13%  interrupts.CPU115.NMI:Non-maskable_interrupts
      1167 ± 21%     -59.4%     473.75 ± 13%  interrupts.CPU115.PMI:Performance_monitoring_interrupts
    129.25 ± 19%    +487.4%     759.25 ± 34%  interrupts.CPU115.RES:Rescheduling_interrupts
     60.25 ± 97%    +354.4%     273.75 ± 16%  interrupts.CPU115.TLB:TLB_shootdowns
      3734 ±  2%    +251.3%      13116 ±  9%  interrupts.CPU116.CAL:Function_call_interrupts
      1186 ± 22%     -60.0%     474.50 ± 12%  interrupts.CPU116.NMI:Non-maskable_interrupts
      1186 ± 22%     -60.0%     474.50 ± 12%  interrupts.CPU116.PMI:Performance_monitoring_interrupts
    146.75 ± 15%    +396.4%     728.50 ± 36%  interrupts.CPU116.RES:Rescheduling_interrupts
      3436 ±  3%    +288.8%      13361 ± 11%  interrupts.CPU117.CAL:Function_call_interrupts
      1100 ± 21%     -58.3%     458.25 ± 10%  interrupts.CPU117.NMI:Non-maskable_interrupts
      1100 ± 21%     -58.3%     458.25 ± 10%  interrupts.CPU117.PMI:Performance_monitoring_interrupts
    130.00 ± 23%    +441.3%     703.75 ± 30%  interrupts.CPU117.RES:Rescheduling_interrupts
      3464 ±  4%    +277.0%      13058 ±  9%  interrupts.CPU118.CAL:Function_call_interrupts
      1037 ± 29%     -54.6%     471.00 ± 12%  interrupts.CPU118.NMI:Non-maskable_interrupts
      1037 ± 29%     -54.6%     471.00 ± 12%  interrupts.CPU118.PMI:Performance_monitoring_interrupts
    173.50 ± 47%   +1228.1%       2304 ± 79%  interrupts.CPU118.RES:Rescheduling_interrupts
      3373          +290.5%      13173 ± 11%  interrupts.CPU119.CAL:Function_call_interrupts
    881.25 ± 24%     -46.6%     470.75 ± 15%  interrupts.CPU119.NMI:Non-maskable_interrupts
    881.25 ± 24%     -46.6%     470.75 ± 15%  interrupts.CPU119.PMI:Performance_monitoring_interrupts
    123.75 ± 21%    +581.8%     843.75 ± 44%  interrupts.CPU119.RES:Rescheduling_interrupts
      3411 ±  7%    +278.2%      12901 ±  9%  interrupts.CPU12.CAL:Function_call_interrupts
      1379 ± 11%     -65.4%     477.75 ± 14%  interrupts.CPU12.NMI:Non-maskable_interrupts
      1379 ± 11%     -65.4%     477.75 ± 14%  interrupts.CPU12.PMI:Performance_monitoring_interrupts
    117.25 ±  6%    +449.7%     644.50 ± 15%  interrupts.CPU12.RES:Rescheduling_interrupts
     86.75 ± 84%    +209.2%     268.25 ± 25%  interrupts.CPU12.TLB:TLB_shootdowns
      3406 ±  3%    +287.2%      13189 ±  7%  interrupts.CPU120.CAL:Function_call_interrupts
    993.50 ± 27%     -52.4%     472.75 ± 20%  interrupts.CPU120.NMI:Non-maskable_interrupts
    993.50 ± 27%     -52.4%     472.75 ± 20%  interrupts.CPU120.PMI:Performance_monitoring_interrupts
    120.50 ± 15%    +437.3%     647.50 ± 30%  interrupts.CPU120.RES:Rescheduling_interrupts
     75.50 ±146%    +475.8%     434.75 ± 55%  interrupts.CPU120.TLB:TLB_shootdowns
      3557 ±  4%    +256.3%      12673 ± 14%  interrupts.CPU121.CAL:Function_call_interrupts
      1003 ± 21%     -61.1%     390.50 ± 27%  interrupts.CPU121.NMI:Non-maskable_interrupts
      1003 ± 21%     -61.1%     390.50 ± 27%  interrupts.CPU121.PMI:Performance_monitoring_interrupts
    119.25 ± 18%    +366.5%     556.25 ± 30%  interrupts.CPU121.RES:Rescheduling_interrupts
      3815 ±  8%    +232.4%      12682 ± 14%  interrupts.CPU122.CAL:Function_call_interrupts
    992.00 ± 13%     -63.4%     362.75 ± 31%  interrupts.CPU122.NMI:Non-maskable_interrupts
    992.00 ± 13%     -63.4%     362.75 ± 31%  interrupts.CPU122.PMI:Performance_monitoring_interrupts
    122.75 ± 24%    +399.8%     613.50 ± 32%  interrupts.CPU122.RES:Rescheduling_interrupts
      3590 ±  7%    +256.0%      12779 ± 13%  interrupts.CPU123.CAL:Function_call_interrupts
    867.00 ± 25%     -60.8%     340.00 ± 43%  interrupts.CPU123.NMI:Non-maskable_interrupts
    867.00 ± 25%     -60.8%     340.00 ± 43%  interrupts.CPU123.PMI:Performance_monitoring_interrupts
    117.50 ± 22%    +408.5%     597.50 ± 30%  interrupts.CPU123.RES:Rescheduling_interrupts
      3632 ±  9%    +254.8%      12886 ± 14%  interrupts.CPU124.CAL:Function_call_interrupts
    790.00 ± 22%     -52.5%     375.00 ± 29%  interrupts.CPU124.NMI:Non-maskable_interrupts
    790.00 ± 22%     -52.5%     375.00 ± 29%  interrupts.CPU124.PMI:Performance_monitoring_interrupts
    130.50 ± 22%    +363.4%     604.75 ± 26%  interrupts.CPU124.RES:Rescheduling_interrupts
      3643 ±  5%    +248.1%      12683 ± 12%  interrupts.CPU125.CAL:Function_call_interrupts
    894.75 ± 30%     -54.1%     410.50 ± 23%  interrupts.CPU125.NMI:Non-maskable_interrupts
    894.75 ± 30%     -54.1%     410.50 ± 23%  interrupts.CPU125.PMI:Performance_monitoring_interrupts
    131.75 ± 22%    +364.9%     612.50 ± 22%  interrupts.CPU125.RES:Rescheduling_interrupts
     93.00 ±109%    +221.2%     298.75 ± 13%  interrupts.CPU125.TLB:TLB_shootdowns
      3371 ±  6%    +273.3%      12586 ± 12%  interrupts.CPU126.CAL:Function_call_interrupts
    908.00 ± 26%     -55.3%     406.00 ± 24%  interrupts.CPU126.NMI:Non-maskable_interrupts
    908.00 ± 26%     -55.3%     406.00 ± 24%  interrupts.CPU126.PMI:Performance_monitoring_interrupts
    152.25 ± 59%    +704.4%       1224 ± 98%  interrupts.CPU126.RES:Rescheduling_interrupts
     74.00 ± 97%    +306.4%     300.75 ± 14%  interrupts.CPU126.TLB:TLB_shootdowns
      3611 ±  3%    +261.5%      13057 ± 10%  interrupts.CPU127.CAL:Function_call_interrupts
    796.00 ± 17%     -51.2%     388.25 ± 29%  interrupts.CPU127.NMI:Non-maskable_interrupts
    796.00 ± 17%     -51.2%     388.25 ± 29%  interrupts.CPU127.PMI:Performance_monitoring_interrupts
    122.00 ± 20%    +346.5%     544.75 ± 34%  interrupts.CPU127.RES:Rescheduling_interrupts
      3532 ±  3%    +270.0%      13070 ± 12%  interrupts.CPU128.CAL:Function_call_interrupts
    902.75 ± 34%     -54.5%     410.50 ± 24%  interrupts.CPU128.NMI:Non-maskable_interrupts
    902.75 ± 34%     -54.5%     410.50 ± 24%  interrupts.CPU128.PMI:Performance_monitoring_interrupts
    115.50 ± 10%    +390.3%     566.25 ± 18%  interrupts.CPU128.RES:Rescheduling_interrupts
    115.50 ± 67%    +167.7%     309.25 ± 20%  interrupts.CPU128.TLB:TLB_shootdowns
      3529 ±  4%    +263.6%      12831 ± 14%  interrupts.CPU129.CAL:Function_call_interrupts
    968.25 ± 19%     -51.8%     466.50 ± 19%  interrupts.CPU129.NMI:Non-maskable_interrupts
    968.25 ± 19%     -51.8%     466.50 ± 19%  interrupts.CPU129.PMI:Performance_monitoring_interrupts
    112.00 ± 16%    +359.6%     514.75 ± 21%  interrupts.CPU129.RES:Rescheduling_interrupts
      3687 ±  3%    +249.5%      12888 ± 12%  interrupts.CPU13.CAL:Function_call_interrupts
    912.50 ± 28%     -46.8%     485.25 ± 15%  interrupts.CPU13.NMI:Non-maskable_interrupts
    912.50 ± 28%     -46.8%     485.25 ± 15%  interrupts.CPU13.PMI:Performance_monitoring_interrupts
    134.25 ±  4%    +356.6%     613.00 ± 15%  interrupts.CPU13.RES:Rescheduling_interrupts
    117.50 ± 79%     +95.5%     229.75 ± 29%  interrupts.CPU13.TLB:TLB_shootdowns
      3600 ±  5%    +256.1%      12820 ± 14%  interrupts.CPU130.CAL:Function_call_interrupts
    872.50 ±  9%     -47.9%     454.50 ± 16%  interrupts.CPU130.NMI:Non-maskable_interrupts
    872.50 ±  9%     -47.9%     454.50 ± 16%  interrupts.CPU130.PMI:Performance_monitoring_interrupts
    105.75 ± 10%    +370.0%     497.00 ± 24%  interrupts.CPU130.RES:Rescheduling_interrupts
     36.00 ±122%    +704.2%     289.50 ± 10%  interrupts.CPU130.TLB:TLB_shootdowns
      3626 ±  3%    +255.1%      12877 ± 12%  interrupts.CPU131.CAL:Function_call_interrupts
    968.00 ± 25%     -50.4%     479.75 ± 17%  interrupts.CPU131.NMI:Non-maskable_interrupts
    968.00 ± 25%     -50.4%     479.75 ± 17%  interrupts.CPU131.PMI:Performance_monitoring_interrupts
    102.75 ±  5%    +364.0%     476.75 ± 25%  interrupts.CPU131.RES:Rescheduling_interrupts
      3481 ±  3%    +262.4%      12616 ± 11%  interrupts.CPU132.CAL:Function_call_interrupts
    856.50 ± 28%     -45.2%     469.00 ± 16%  interrupts.CPU132.NMI:Non-maskable_interrupts
    856.50 ± 28%     -45.2%     469.00 ± 16%  interrupts.CPU132.PMI:Performance_monitoring_interrupts
    116.25 ± 17%    +384.7%     563.50 ± 20%  interrupts.CPU132.RES:Rescheduling_interrupts
      3528          +269.1%      13025 ± 12%  interrupts.CPU133.CAL:Function_call_interrupts
    106.00 ± 17%    +396.0%     525.75 ± 21%  interrupts.CPU133.RES:Rescheduling_interrupts
      3585 ±  3%    +263.1%      13016 ± 13%  interrupts.CPU134.CAL:Function_call_interrupts
    115.50 ±  7%    +319.0%     484.00 ± 22%  interrupts.CPU134.RES:Rescheduling_interrupts
      3377 ±  2%    +281.4%      12880 ± 15%  interrupts.CPU135.CAL:Function_call_interrupts
    780.50 ± 30%     -50.4%     387.00 ± 25%  interrupts.CPU135.NMI:Non-maskable_interrupts
    780.50 ± 30%     -50.4%     387.00 ± 25%  interrupts.CPU135.PMI:Performance_monitoring_interrupts
     97.75 ±  8%    +438.9%     526.75 ± 37%  interrupts.CPU135.RES:Rescheduling_interrupts
      3861 ±  7%    +230.0%      12739 ± 13%  interrupts.CPU136.CAL:Function_call_interrupts
    115.50 ± 15%    +391.8%     568.00 ± 20%  interrupts.CPU136.RES:Rescheduling_interrupts
      3641 ±  5%    +253.5%      12873 ± 12%  interrupts.CPU137.CAL:Function_call_interrupts
    111.50 ± 16%    +474.2%     640.25 ± 15%  interrupts.CPU137.RES:Rescheduling_interrupts
      3680 ±  3%    +250.1%      12886 ±  9%  interrupts.CPU138.CAL:Function_call_interrupts
     97.75 ± 22%    +341.9%     432.00 ± 25%  interrupts.CPU138.RES:Rescheduling_interrupts
      3670 ±  3%    +256.7%      13090 ± 13%  interrupts.CPU139.CAL:Function_call_interrupts
    114.00 ±  5%    +290.8%     445.50 ± 20%  interrupts.CPU139.RES:Rescheduling_interrupts
      3626          +255.9%      12904 ±  9%  interrupts.CPU14.CAL:Function_call_interrupts
    979.00 ± 16%     -57.6%     415.50 ± 24%  interrupts.CPU14.NMI:Non-maskable_interrupts
    979.00 ± 16%     -57.6%     415.50 ± 24%  interrupts.CPU14.PMI:Performance_monitoring_interrupts
    127.00 ± 14%    +351.4%     573.25 ± 22%  interrupts.CPU14.RES:Rescheduling_interrupts
      3458 ±  6%    +274.5%      12951 ± 14%  interrupts.CPU140.CAL:Function_call_interrupts
    105.00 ± 20%    +290.7%     410.25 ± 21%  interrupts.CPU140.RES:Rescheduling_interrupts
     78.25 ± 96%    +228.8%     257.25 ± 18%  interrupts.CPU140.TLB:TLB_shootdowns
      3426 ±  4%    +275.1%      12853 ± 13%  interrupts.CPU141.CAL:Function_call_interrupts
     99.75 ± 10%    +309.3%     408.25 ± 24%  interrupts.CPU141.RES:Rescheduling_interrupts
    140.75 ± 68%    +108.3%     293.25 ±  9%  interrupts.CPU141.TLB:TLB_shootdowns
      3553 ±  5%    +261.8%      12855 ± 12%  interrupts.CPU142.CAL:Function_call_interrupts
    107.00 ± 19%    +268.7%     394.50 ± 29%  interrupts.CPU142.RES:Rescheduling_interrupts
     95.50 ±119%    +244.2%     328.75 ±  8%  interrupts.CPU142.TLB:TLB_shootdowns
      3548          +261.2%      12816 ± 10%  interrupts.CPU143.CAL:Function_call_interrupts
    896.00 ± 39%     -55.4%     399.75 ± 25%  interrupts.CPU143.NMI:Non-maskable_interrupts
    896.00 ± 39%     -55.4%     399.75 ± 25%  interrupts.CPU143.PMI:Performance_monitoring_interrupts
     89.75 ±  7%    +386.6%     436.75 ± 24%  interrupts.CPU143.RES:Rescheduling_interrupts
     82.75 ± 96%    +275.2%     310.50 ± 10%  interrupts.CPU143.TLB:TLB_shootdowns
      3595 ± 11%    +280.8%      13692 ±  7%  interrupts.CPU144.CAL:Function_call_interrupts
    896.25 ± 34%     -46.4%     480.75 ± 13%  interrupts.CPU144.NMI:Non-maskable_interrupts
    896.25 ± 34%     -46.4%     480.75 ± 13%  interrupts.CPU144.PMI:Performance_monitoring_interrupts
    114.50 ± 10%    +346.9%     511.75 ± 18%  interrupts.CPU144.RES:Rescheduling_interrupts
      3585 ± 10%    +258.5%      12851 ±  8%  interrupts.CPU145.CAL:Function_call_interrupts
    926.50 ± 26%     -55.9%     408.75 ± 23%  interrupts.CPU145.NMI:Non-maskable_interrupts
    926.50 ± 26%     -55.9%     408.75 ± 23%  interrupts.CPU145.PMI:Performance_monitoring_interrupts
    100.75 ± 12%    +379.9%     483.50 ± 18%  interrupts.CPU145.RES:Rescheduling_interrupts
      4049 ± 17%    +217.7%      12865 ±  8%  interrupts.CPU146.CAL:Function_call_interrupts
    102.75 ± 10%    +369.3%     482.25 ± 19%  interrupts.CPU146.RES:Rescheduling_interrupts
      3614 ±  6%    +263.4%      13135 ±  8%  interrupts.CPU147.CAL:Function_call_interrupts
    928.50 ± 28%     -56.1%     408.00 ± 22%  interrupts.CPU147.NMI:Non-maskable_interrupts
    928.50 ± 28%     -56.1%     408.00 ± 22%  interrupts.CPU147.PMI:Performance_monitoring_interrupts
     99.50 ± 11%    +372.9%     470.50 ± 19%  interrupts.CPU147.RES:Rescheduling_interrupts
      3432 ±  4%    +271.4%      12748 ±  8%  interrupts.CPU148.CAL:Function_call_interrupts
    954.25 ± 33%     -56.4%     416.00 ± 24%  interrupts.CPU148.NMI:Non-maskable_interrupts
    954.25 ± 33%     -56.4%     416.00 ± 24%  interrupts.CPU148.PMI:Performance_monitoring_interrupts
    103.00 ± 15%    +345.9%     459.25 ± 18%  interrupts.CPU148.RES:Rescheduling_interrupts
      3467 ±  6%    +285.2%      13358 ±  8%  interrupts.CPU149.CAL:Function_call_interrupts
    897.50 ± 31%     -61.8%     342.50 ± 18%  interrupts.CPU149.NMI:Non-maskable_interrupts
    897.50 ± 31%     -61.8%     342.50 ± 18%  interrupts.CPU149.PMI:Performance_monitoring_interrupts
    100.00 ± 10%    +406.0%     506.00 ± 21%  interrupts.CPU149.RES:Rescheduling_interrupts
      3744 ± 15%    +244.6%      12901 ± 11%  interrupts.CPU15.CAL:Function_call_interrupts
    132.75 ±  9%    +325.0%     564.25 ± 23%  interrupts.CPU15.RES:Rescheduling_interrupts
    113.75 ± 55%    +185.7%     325.00 ±  7%  interrupts.CPU15.TLB:TLB_shootdowns
      3291 ±  5%    +295.5%      13016 ±  7%  interrupts.CPU150.CAL:Function_call_interrupts
    888.25 ± 30%     -52.9%     418.00 ± 21%  interrupts.CPU150.NMI:Non-maskable_interrupts
    888.25 ± 30%     -52.9%     418.00 ± 21%  interrupts.CPU150.PMI:Performance_monitoring_interrupts
     98.00 ±  7%    +516.8%     604.50 ± 16%  interrupts.CPU150.RES:Rescheduling_interrupts
    135.25 ± 53%    +119.6%     297.00 ± 12%  interrupts.CPU150.TLB:TLB_shootdowns
      3472 ±  4%    +282.4%      13277 ± 11%  interrupts.CPU151.CAL:Function_call_interrupts
    792.75 ± 20%     -48.5%     408.25 ± 23%  interrupts.CPU151.NMI:Non-maskable_interrupts
    792.75 ± 20%     -48.5%     408.25 ± 23%  interrupts.CPU151.PMI:Performance_monitoring_interrupts
    141.50 ± 44%    +318.6%     592.25 ± 14%  interrupts.CPU151.RES:Rescheduling_interrupts
      3272 ±  3%    +275.1%      12276 ±  8%  interrupts.CPU152.CAL:Function_call_interrupts
    912.25 ± 40%     -54.8%     412.00 ± 25%  interrupts.CPU152.NMI:Non-maskable_interrupts
    912.25 ± 40%     -54.8%     412.00 ± 25%  interrupts.CPU152.PMI:Performance_monitoring_interrupts
     94.25 ±  7%    +361.5%     435.00 ± 24%  interrupts.CPU152.RES:Rescheduling_interrupts
    132.75 ±100%    +154.0%     337.25 ± 21%  interrupts.CPU152.TLB:TLB_shootdowns
      3541 ±  6%    +281.3%      13501 ± 11%  interrupts.CPU153.CAL:Function_call_interrupts
    712.75 ± 15%     -41.9%     414.00 ± 24%  interrupts.CPU153.NMI:Non-maskable_interrupts
    712.75 ± 15%     -41.9%     414.00 ± 24%  interrupts.CPU153.PMI:Performance_monitoring_interrupts
    116.50 ± 34%    +426.8%     613.75 ± 13%  interrupts.CPU153.RES:Rescheduling_interrupts
      3384 ±  3%    +299.0%      13506 ±  8%  interrupts.CPU154.CAL:Function_call_interrupts
    824.75 ± 38%     -49.2%     419.25 ± 23%  interrupts.CPU154.NMI:Non-maskable_interrupts
    824.75 ± 38%     -49.2%     419.25 ± 23%  interrupts.CPU154.PMI:Performance_monitoring_interrupts
    111.50 ± 28%    +480.3%     647.00 ± 17%  interrupts.CPU154.RES:Rescheduling_interrupts
      3412 ±  6%    +287.7%      13229 ±  8%  interrupts.CPU155.CAL:Function_call_interrupts
    614.25 ± 20%     -30.9%     424.75 ± 23%  interrupts.CPU155.NMI:Non-maskable_interrupts
    614.25 ± 20%     -30.9%     424.75 ± 23%  interrupts.CPU155.PMI:Performance_monitoring_interrupts
    112.25 ± 25%    +468.2%     637.75 ± 11%  interrupts.CPU155.RES:Rescheduling_interrupts
      3605 ±  9%    +262.4%      13065 ± 10%  interrupts.CPU156.CAL:Function_call_interrupts
    716.75 ± 37%     -44.4%     398.25 ± 19%  interrupts.CPU156.NMI:Non-maskable_interrupts
    716.75 ± 37%     -44.4%     398.25 ± 19%  interrupts.CPU156.PMI:Performance_monitoring_interrupts
    120.00 ± 17%    +426.2%     631.50 ± 16%  interrupts.CPU156.RES:Rescheduling_interrupts
      3461 ±  4%    +282.6%      13243 ±  8%  interrupts.CPU157.CAL:Function_call_interrupts
    619.25 ± 10%     -33.3%     412.75 ± 22%  interrupts.CPU157.NMI:Non-maskable_interrupts
    619.25 ± 10%     -33.3%     412.75 ± 22%  interrupts.CPU157.PMI:Performance_monitoring_interrupts
    106.75 ± 28%    +315.5%     443.50 ± 13%  interrupts.CPU157.RES:Rescheduling_interrupts
      3445 ±  5%    +281.3%      13136 ± 12%  interrupts.CPU158.CAL:Function_call_interrupts
    790.50 ± 32%     -48.0%     411.00 ± 24%  interrupts.CPU158.NMI:Non-maskable_interrupts
    790.50 ± 32%     -48.0%     411.00 ± 24%  interrupts.CPU158.PMI:Performance_monitoring_interrupts
    143.50 ± 48%    +657.3%       1086 ± 78%  interrupts.CPU158.RES:Rescheduling_interrupts
      3497 ±  2%    +273.3%      13054 ±  9%  interrupts.CPU159.CAL:Function_call_interrupts
      1103 ± 32%     -62.5%     414.00 ± 24%  interrupts.CPU159.NMI:Non-maskable_interrupts
      1103 ± 32%     -62.5%     414.00 ± 24%  interrupts.CPU159.PMI:Performance_monitoring_interrupts
    120.25 ± 30%    +425.8%     632.25 ± 15%  interrupts.CPU159.RES:Rescheduling_interrupts
      3602 ±  4%    +259.2%      12941 ± 10%  interrupts.CPU16.CAL:Function_call_interrupts
      1050 ± 16%     -58.6%     434.75 ± 33%  interrupts.CPU16.NMI:Non-maskable_interrupts
      1050 ± 16%     -58.6%     434.75 ± 33%  interrupts.CPU16.PMI:Performance_monitoring_interrupts
    122.75 ±  7%    +364.6%     570.25 ± 15%  interrupts.CPU16.RES:Rescheduling_interrupts
    156.50 ± 60%     +82.6%     285.75 ±  8%  interrupts.CPU16.TLB:TLB_shootdowns
      3554 ±  8%    +271.8%      13217 ±  8%  interrupts.CPU160.CAL:Function_call_interrupts
    849.00 ± 35%     -43.7%     478.25 ± 13%  interrupts.CPU160.NMI:Non-maskable_interrupts
    849.00 ± 35%     -43.7%     478.25 ± 13%  interrupts.CPU160.PMI:Performance_monitoring_interrupts
     99.25 ± 15%    +514.9%     610.25 ± 12%  interrupts.CPU160.RES:Rescheduling_interrupts
      3671 ± 10%    +256.4%      13084 ±  9%  interrupts.CPU161.CAL:Function_call_interrupts
     99.75 ± 12%    +508.5%     607.00 ± 12%  interrupts.CPU161.RES:Rescheduling_interrupts
      3379 ±  6%    +288.9%      13141 ± 10%  interrupts.CPU162.CAL:Function_call_interrupts
     96.00 ±  5%    +499.5%     575.50 ± 18%  interrupts.CPU162.RES:Rescheduling_interrupts
    110.75 ± 86%    +156.2%     283.75 ± 15%  interrupts.CPU162.TLB:TLB_shootdowns
      3749 ±  5%    +249.1%      13090 ± 10%  interrupts.CPU163.CAL:Function_call_interrupts
    800.25 ± 17%     -39.7%     482.25 ± 15%  interrupts.CPU163.NMI:Non-maskable_interrupts
    800.25 ± 17%     -39.7%     482.25 ± 15%  interrupts.CPU163.PMI:Performance_monitoring_interrupts
    110.50 ±  7%    +445.2%     602.50 ± 16%  interrupts.CPU163.RES:Rescheduling_interrupts
      3497 ±  2%    +284.6%      13449 ± 10%  interrupts.CPU164.CAL:Function_call_interrupts
    103.75 ±  4%    +510.1%     633.00 ± 16%  interrupts.CPU164.RES:Rescheduling_interrupts
      3473 ±  7%    +284.5%      13355 ±  9%  interrupts.CPU165.CAL:Function_call_interrupts
    972.25 ± 36%     -50.6%     480.50 ± 15%  interrupts.CPU165.NMI:Non-maskable_interrupts
    972.25 ± 36%     -50.6%     480.50 ± 15%  interrupts.CPU165.PMI:Performance_monitoring_interrupts
    112.50 ±  9%    +442.4%     610.25 ± 14%  interrupts.CPU165.RES:Rescheduling_interrupts
      3657 ±  5%    +263.9%      13307 ±  7%  interrupts.CPU166.CAL:Function_call_interrupts
      1118 ± 27%     -56.7%     484.25 ± 13%  interrupts.CPU166.NMI:Non-maskable_interrupts
      1118 ± 27%     -56.7%     484.25 ± 13%  interrupts.CPU166.PMI:Performance_monitoring_interrupts
    102.75 ±  5%    +504.1%     620.75 ± 14%  interrupts.CPU166.RES:Rescheduling_interrupts
      3421 ±  2%    +288.4%      13291 ±  8%  interrupts.CPU167.CAL:Function_call_interrupts
      1080 ± 31%     -55.2%     484.00 ± 16%  interrupts.CPU167.NMI:Non-maskable_interrupts
      1080 ± 31%     -55.2%     484.00 ± 16%  interrupts.CPU167.PMI:Performance_monitoring_interrupts
    101.00 ± 14%    +568.3%     675.00 ± 13%  interrupts.CPU167.RES:Rescheduling_interrupts
      3635 ±  6%    +239.2%      12330 ± 19%  interrupts.CPU168.CAL:Function_call_interrupts
      1099 ± 22%     -62.5%     411.75 ± 23%  interrupts.CPU168.NMI:Non-maskable_interrupts
      1099 ± 22%     -62.5%     411.75 ± 23%  interrupts.CPU168.PMI:Performance_monitoring_interrupts
    123.25 ± 22%    +340.4%     542.75 ± 23%  interrupts.CPU168.RES:Rescheduling_interrupts
      3532 ±  5%    +222.2%      11381 ± 21%  interrupts.CPU169.CAL:Function_call_interrupts
    117.00 ± 13%    +268.2%     430.75 ± 23%  interrupts.CPU169.RES:Rescheduling_interrupts
      3558 ±  2%    +271.5%      13220 ± 11%  interrupts.CPU17.CAL:Function_call_interrupts
    879.00 ± 37%     -52.3%     419.00 ± 24%  interrupts.CPU17.NMI:Non-maskable_interrupts
    879.00 ± 37%     -52.3%     419.00 ± 24%  interrupts.CPU17.PMI:Performance_monitoring_interrupts
    125.75 ±  8%    +394.0%     621.25 ± 23%  interrupts.CPU17.RES:Rescheduling_interrupts
    193.25 ± 29%     +54.6%     298.75 ± 10%  interrupts.CPU17.TLB:TLB_shootdowns
      3708 ±  8%    +216.1%      11723 ± 22%  interrupts.CPU170.CAL:Function_call_interrupts
    124.75 ± 13%    +239.1%     423.00 ± 30%  interrupts.CPU170.RES:Rescheduling_interrupts
    171.50 ± 60%     +81.9%     312.00 ± 16%  interrupts.CPU170.TLB:TLB_shootdowns
      3627 ± 11%    +215.2%      11433 ± 21%  interrupts.CPU171.CAL:Function_call_interrupts
    870.25 ± 26%     -46.0%     470.00 ± 19%  interrupts.CPU171.NMI:Non-maskable_interrupts
    870.25 ± 26%     -46.0%     470.00 ± 19%  interrupts.CPU171.PMI:Performance_monitoring_interrupts
    121.75 ± 13%    +254.8%     432.00 ± 28%  interrupts.CPU171.RES:Rescheduling_interrupts
    184.50 ± 28%     +72.2%     317.75 ± 13%  interrupts.CPU171.TLB:TLB_shootdowns
      3585 ±  5%    +225.8%      11679 ± 23%  interrupts.CPU172.CAL:Function_call_interrupts
    970.00 ± 32%     -58.9%     399.00 ± 25%  interrupts.CPU172.NMI:Non-maskable_interrupts
    970.00 ± 32%     -58.9%     399.00 ± 25%  interrupts.CPU172.PMI:Performance_monitoring_interrupts
    110.75 ±  7%    +318.1%     463.00 ± 26%  interrupts.CPU172.RES:Rescheduling_interrupts
      3843 ±  8%    +202.6%      11629 ± 22%  interrupts.CPU173.CAL:Function_call_interrupts
      1008 ± 25%     -59.7%     406.00 ± 27%  interrupts.CPU173.NMI:Non-maskable_interrupts
      1008 ± 25%     -59.7%     406.00 ± 27%  interrupts.CPU173.PMI:Performance_monitoring_interrupts
    135.50 ± 15%    +229.7%     446.75 ± 25%  interrupts.CPU173.RES:Rescheduling_interrupts
      3586 ±  5%    +237.4%      12101 ± 22%  interrupts.CPU174.CAL:Function_call_interrupts
    796.25 ± 24%     -49.5%     402.25 ± 23%  interrupts.CPU174.NMI:Non-maskable_interrupts
    796.25 ± 24%     -49.5%     402.25 ± 23%  interrupts.CPU174.PMI:Performance_monitoring_interrupts
    108.00 ± 22%    +381.7%     520.25 ± 29%  interrupts.CPU174.RES:Rescheduling_interrupts
    129.50 ± 61%    +138.4%     308.75 ± 16%  interrupts.CPU174.TLB:TLB_shootdowns
      3871 ±  8%    +205.7%      11832 ± 22%  interrupts.CPU175.CAL:Function_call_interrupts
    121.00 ± 14%    +298.3%     482.00 ± 24%  interrupts.CPU175.RES:Rescheduling_interrupts
      3790 ±  7%    +216.7%      12003 ± 23%  interrupts.CPU176.CAL:Function_call_interrupts
    897.25 ± 26%     -61.5%     345.75 ± 37%  interrupts.CPU176.NMI:Non-maskable_interrupts
    897.25 ± 26%     -61.5%     345.75 ± 37%  interrupts.CPU176.PMI:Performance_monitoring_interrupts
    137.50 ± 19%    +239.5%     466.75 ± 26%  interrupts.CPU176.RES:Rescheduling_interrupts
      3762 ±  7%    +214.3%      11824 ± 22%  interrupts.CPU177.CAL:Function_call_interrupts
    826.00 ± 22%     -63.8%     299.00 ± 49%  interrupts.CPU177.NMI:Non-maskable_interrupts
    826.00 ± 22%     -63.8%     299.00 ± 49%  interrupts.CPU177.PMI:Performance_monitoring_interrupts
    129.50 ± 20%    +262.0%     468.75 ± 26%  interrupts.CPU177.RES:Rescheduling_interrupts
      3855 ±  7%    +209.2%      11923 ± 22%  interrupts.CPU178.CAL:Function_call_interrupts
    767.50 ± 48%     -59.6%     309.75 ± 47%  interrupts.CPU178.NMI:Non-maskable_interrupts
    767.50 ± 48%     -59.6%     309.75 ± 47%  interrupts.CPU178.PMI:Performance_monitoring_interrupts
    148.50 ± 36%    +226.8%     485.25 ± 27%  interrupts.CPU178.RES:Rescheduling_interrupts
      3510 ±  6%    +250.7%      12310 ± 23%  interrupts.CPU179.CAL:Function_call_interrupts
      1009 ± 38%     -69.8%     304.25 ± 48%  interrupts.CPU179.NMI:Non-maskable_interrupts
      1009 ± 38%     -69.8%     304.25 ± 48%  interrupts.CPU179.PMI:Performance_monitoring_interrupts
    115.00 ± 20%    +330.9%     495.50 ± 25%  interrupts.CPU179.RES:Rescheduling_interrupts
      3528 ±  3%    +275.1%      13235 ± 11%  interrupts.CPU18.CAL:Function_call_interrupts
      1106 ± 18%     -56.3%     484.00 ± 14%  interrupts.CPU18.NMI:Non-maskable_interrupts
      1106 ± 18%     -56.3%     484.00 ± 14%  interrupts.CPU18.PMI:Performance_monitoring_interrupts
    117.00 ± 20%    +419.9%     608.25 ± 20%  interrupts.CPU18.RES:Rescheduling_interrupts
     86.25 ± 83%    +233.0%     287.25 ± 12%  interrupts.CPU18.TLB:TLB_shootdowns
      3629 ±  6%    +225.3%      11806 ± 23%  interrupts.CPU180.CAL:Function_call_interrupts
    123.50 ± 12%    +279.1%     468.25 ± 24%  interrupts.CPU180.RES:Rescheduling_interrupts
      3833 ± 12%    +199.6%      11483 ± 22%  interrupts.CPU181.CAL:Function_call_interrupts
    150.75 ± 14%    +206.6%     462.25 ± 25%  interrupts.CPU181.RES:Rescheduling_interrupts
      3650 ±  7%    +225.6%      11886 ± 21%  interrupts.CPU182.CAL:Function_call_interrupts
    166.25 ± 27%    +169.0%     447.25 ± 27%  interrupts.CPU182.RES:Rescheduling_interrupts
      4067 ± 17%    +190.4%      11810 ± 22%  interrupts.CPU183.CAL:Function_call_interrupts
    938.00 ± 28%     -54.3%     429.00 ± 32%  interrupts.CPU183.NMI:Non-maskable_interrupts
    938.00 ± 28%     -54.3%     429.00 ± 32%  interrupts.CPU183.PMI:Performance_monitoring_interrupts
    128.00 ± 19%    +285.7%     493.75 ± 24%  interrupts.CPU183.RES:Rescheduling_interrupts
    135.75 ± 66%     +96.7%     267.00 ± 12%  interrupts.CPU183.TLB:TLB_shootdowns
      3877 ±  7%    +206.8%      11895 ± 21%  interrupts.CPU184.CAL:Function_call_interrupts
    137.25 ± 15%    +291.6%     537.50 ± 24%  interrupts.CPU184.RES:Rescheduling_interrupts
      3864 ± 10%    +218.7%      12316 ± 23%  interrupts.CPU185.CAL:Function_call_interrupts
      1241 ± 21%     -66.5%     415.50 ± 35%  interrupts.CPU185.NMI:Non-maskable_interrupts
      1241 ± 21%     -66.5%     415.50 ± 35%  interrupts.CPU185.PMI:Performance_monitoring_interrupts
    118.00 ± 20%    +280.5%     449.00 ± 19%  interrupts.CPU185.RES:Rescheduling_interrupts
      3983 ±  8%    +198.0%      11869 ± 22%  interrupts.CPU186.CAL:Function_call_interrupts
    127.25 ± 20%    +252.1%     448.00 ± 23%  interrupts.CPU186.RES:Rescheduling_interrupts
      3736 ±  8%    +217.9%      11875 ± 22%  interrupts.CPU187.CAL:Function_call_interrupts
    116.00 ± 19%    +309.7%     475.25 ± 26%  interrupts.CPU187.RES:Rescheduling_interrupts
    105.50 ± 94%    +203.6%     320.25 ± 13%  interrupts.CPU187.TLB:TLB_shootdowns
      4204 ± 21%    +187.5%      12088 ± 23%  interrupts.CPU188.CAL:Function_call_interrupts
      1119 ± 21%     -57.2%     479.50 ± 15%  interrupts.CPU188.NMI:Non-maskable_interrupts
      1119 ± 21%     -57.2%     479.50 ± 15%  interrupts.CPU188.PMI:Performance_monitoring_interrupts
    132.25 ± 21%    +267.1%     485.50 ± 27%  interrupts.CPU188.RES:Rescheduling_interrupts
      3737 ±  3%    +219.7%      11947 ± 22%  interrupts.CPU189.CAL:Function_call_interrupts
      1084 ± 25%     -56.5%     471.75 ± 15%  interrupts.CPU189.NMI:Non-maskable_interrupts
      1084 ± 25%     -56.5%     471.75 ± 15%  interrupts.CPU189.PMI:Performance_monitoring_interrupts
    116.00 ± 17%    +320.3%     487.50 ± 27%  interrupts.CPU189.RES:Rescheduling_interrupts
      3550 ±  3%    +270.2%      13144 ± 11%  interrupts.CPU19.CAL:Function_call_interrupts
      1112 ± 12%     -57.3%     474.50 ± 13%  interrupts.CPU19.NMI:Non-maskable_interrupts
      1112 ± 12%     -57.3%     474.50 ± 13%  interrupts.CPU19.PMI:Performance_monitoring_interrupts
    129.75 ± 19%    +319.5%     544.25 ± 20%  interrupts.CPU19.RES:Rescheduling_interrupts
      3723 ±  8%    +224.3%      12072 ± 22%  interrupts.CPU190.CAL:Function_call_interrupts
    117.75 ± 18%    +310.0%     482.75 ± 28%  interrupts.CPU190.RES:Rescheduling_interrupts
    158.75 ± 60%     +76.7%     280.50 ± 10%  interrupts.CPU190.TLB:TLB_shootdowns
      3735 ± 10%    +201.3%      11254 ± 21%  interrupts.CPU191.CAL:Function_call_interrupts
    948.00 ± 36%     -50.4%     470.25 ± 14%  interrupts.CPU191.NMI:Non-maskable_interrupts
    948.00 ± 36%     -50.4%     470.25 ± 14%  interrupts.CPU191.PMI:Performance_monitoring_interrupts
    106.75 ± 11%    +336.8%     466.25 ± 22%  interrupts.CPU191.RES:Rescheduling_interrupts
      3551 ±  3%    +276.8%      13382 ±  7%  interrupts.CPU2.CAL:Function_call_interrupts
      1165 ± 20%     -59.7%     469.75 ± 13%  interrupts.CPU2.NMI:Non-maskable_interrupts
      1165 ± 20%     -59.7%     469.75 ± 13%  interrupts.CPU2.PMI:Performance_monitoring_interrupts
    130.25 ±  6%    +342.6%     576.50 ± 15%  interrupts.CPU2.RES:Rescheduling_interrupts
      3588 ±  4%    +259.8%      12909 ± 11%  interrupts.CPU20.CAL:Function_call_interrupts
      1092 ± 23%     -56.8%     471.50 ± 13%  interrupts.CPU20.NMI:Non-maskable_interrupts
      1092 ± 23%     -56.8%     471.50 ± 13%  interrupts.CPU20.PMI:Performance_monitoring_interrupts
    129.00 ± 24%    +349.4%     579.75 ± 17%  interrupts.CPU20.RES:Rescheduling_interrupts
      3647 ± 16%    +252.2%      12847 ± 11%  interrupts.CPU21.CAL:Function_call_interrupts
    960.00 ± 25%     -52.0%     461.00 ± 11%  interrupts.CPU21.NMI:Non-maskable_interrupts
    960.00 ± 25%     -52.0%     461.00 ± 11%  interrupts.CPU21.PMI:Performance_monitoring_interrupts
    122.25 ±  8%    +348.9%     548.75 ± 21%  interrupts.CPU21.RES:Rescheduling_interrupts
      3602          +259.5%      12950 ± 10%  interrupts.CPU22.CAL:Function_call_interrupts
      1074 ± 21%     -56.0%     472.75 ± 11%  interrupts.CPU22.NMI:Non-maskable_interrupts
      1074 ± 21%     -56.0%     472.75 ± 11%  interrupts.CPU22.PMI:Performance_monitoring_interrupts
    129.25 ±  7%    +386.8%     629.25 ± 22%  interrupts.CPU22.RES:Rescheduling_interrupts
     54.25 ± 72%    +320.7%     228.25 ± 37%  interrupts.CPU22.TLB:TLB_shootdowns
      3515 ±  3%    +268.0%      12936 ± 10%  interrupts.CPU23.CAL:Function_call_interrupts
      1099 ± 17%     -63.3%     403.00 ± 20%  interrupts.CPU23.NMI:Non-maskable_interrupts
      1099 ± 17%     -63.3%     403.00 ± 20%  interrupts.CPU23.PMI:Performance_monitoring_interrupts
    120.75 ± 13%    +380.1%     579.75 ± 15%  interrupts.CPU23.RES:Rescheduling_interrupts
      3661 ±  3%    +256.1%      13037 ±  8%  interrupts.CPU24.CAL:Function_call_interrupts
      1189 ±  8%     -65.9%     405.25 ± 27%  interrupts.CPU24.NMI:Non-maskable_interrupts
      1189 ±  8%     -65.9%     405.25 ± 27%  interrupts.CPU24.PMI:Performance_monitoring_interrupts
    140.00 ± 16%    +434.5%     748.25 ± 19%  interrupts.CPU24.RES:Rescheduling_interrupts
      3679 ±  2%    +247.0%      12766 ± 15%  interrupts.CPU25.CAL:Function_call_interrupts
      1086 ± 24%     -64.0%     391.25 ± 27%  interrupts.CPU25.NMI:Non-maskable_interrupts
      1086 ± 24%     -64.0%     391.25 ± 27%  interrupts.CPU25.PMI:Performance_monitoring_interrupts
    118.50 ± 22%    +340.7%     522.25 ± 22%  interrupts.CPU25.RES:Rescheduling_interrupts
      3680 ±  6%    +248.0%      12807 ± 14%  interrupts.CPU26.CAL:Function_call_interrupts
      1243 ± 17%     -70.9%     362.25 ± 30%  interrupts.CPU26.NMI:Non-maskable_interrupts
      1243 ± 17%     -70.9%     362.25 ± 30%  interrupts.CPU26.PMI:Performance_monitoring_interrupts
    126.00 ± 10%    +351.0%     568.25 ± 26%  interrupts.CPU26.RES:Rescheduling_interrupts
    103.75 ± 79%    +189.2%     300.00 ±  8%  interrupts.CPU26.TLB:TLB_shootdowns
      3692 ±  5%    +243.3%      12674 ± 13%  interrupts.CPU27.CAL:Function_call_interrupts
    921.25 ± 21%     -71.2%     265.25 ± 24%  interrupts.CPU27.NMI:Non-maskable_interrupts
    921.25 ± 21%     -71.2%     265.25 ± 24%  interrupts.CPU27.PMI:Performance_monitoring_interrupts
    133.75 ±  2%    +332.3%     578.25 ± 21%  interrupts.CPU27.RES:Rescheduling_interrupts
    100.50 ±102%    +172.4%     273.75 ± 24%  interrupts.CPU27.TLB:TLB_shootdowns
      3552 ±  6%    +275.9%      13355 ± 12%  interrupts.CPU28.CAL:Function_call_interrupts
      1047 ± 21%     -75.9%     252.75 ± 15%  interrupts.CPU28.NMI:Non-maskable_interrupts
      1047 ± 21%     -75.9%     252.75 ± 15%  interrupts.CPU28.PMI:Performance_monitoring_interrupts
    116.75 ± 15%    +366.8%     545.00 ± 22%  interrupts.CPU28.RES:Rescheduling_interrupts
    111.00 ±102%    +183.6%     314.75 ±  9%  interrupts.CPU28.TLB:TLB_shootdowns
      3536 ±  3%    +258.1%      12663 ± 12%  interrupts.CPU29.CAL:Function_call_interrupts
    879.50 ± 32%     -68.5%     276.75 ± 17%  interrupts.CPU29.NMI:Non-maskable_interrupts
    879.50 ± 32%     -68.5%     276.75 ± 17%  interrupts.CPU29.PMI:Performance_monitoring_interrupts
    131.00 ± 20%    +392.6%     645.25 ± 22%  interrupts.CPU29.RES:Rescheduling_interrupts
     38.50 ±167%    +545.5%     248.50 ± 41%  interrupts.CPU29.TLB:TLB_shootdowns
      3513 ±  4%    +285.4%      13541 ±  7%  interrupts.CPU3.CAL:Function_call_interrupts
    124.75 ±  8%    +366.1%     581.50 ± 20%  interrupts.CPU3.RES:Rescheduling_interrupts
     89.75 ± 47%    +153.2%     227.25 ± 17%  interrupts.CPU3.TLB:TLB_shootdowns
      3494 ±  3%    +258.4%      12524 ± 12%  interrupts.CPU30.CAL:Function_call_interrupts
    856.50 ± 14%     -58.7%     353.50 ± 38%  interrupts.CPU30.NMI:Non-maskable_interrupts
    856.50 ± 14%     -58.7%     353.50 ± 38%  interrupts.CPU30.PMI:Performance_monitoring_interrupts
    121.25 ± 12%    +329.5%     520.75 ± 22%  interrupts.CPU30.RES:Rescheduling_interrupts
     86.50 ±119%    +199.4%     259.00 ± 33%  interrupts.CPU30.TLB:TLB_shootdowns
      3761 ±  3%    +238.8%      12741 ± 14%  interrupts.CPU31.CAL:Function_call_interrupts
    898.75 ±  8%     -63.2%     331.00 ± 41%  interrupts.CPU31.NMI:Non-maskable_interrupts
    898.75 ±  8%     -63.2%     331.00 ± 41%  interrupts.CPU31.PMI:Performance_monitoring_interrupts
    132.00 ± 16%    +310.6%     542.00 ± 23%  interrupts.CPU31.RES:Rescheduling_interrupts
      3794 ±  7%    +241.1%      12944 ± 12%  interrupts.CPU32.CAL:Function_call_interrupts
    127.50 ± 20%    +353.3%     578.00 ± 22%  interrupts.CPU32.RES:Rescheduling_interrupts
    158.00 ± 66%     +92.2%     303.75 ± 13%  interrupts.CPU32.TLB:TLB_shootdowns
      3523 ±  5%    +260.0%      12684 ± 13%  interrupts.CPU33.CAL:Function_call_interrupts
    117.50 ±  2%    +326.2%     500.75 ± 26%  interrupts.CPU33.RES:Rescheduling_interrupts
      3621 ±  2%    +255.2%      12865 ± 13%  interrupts.CPU34.CAL:Function_call_interrupts
    839.25 ± 21%     -46.1%     452.00 ± 16%  interrupts.CPU34.NMI:Non-maskable_interrupts
    839.25 ± 21%     -46.1%     452.00 ± 16%  interrupts.CPU34.PMI:Performance_monitoring_interrupts
    122.25 ± 11%    +368.3%     572.50 ± 23%  interrupts.CPU34.RES:Rescheduling_interrupts
    144.50 ± 81%    +134.8%     339.25 ±  2%  interrupts.CPU34.TLB:TLB_shootdowns
      3680 ±  4%    +247.2%      12778 ± 11%  interrupts.CPU35.CAL:Function_call_interrupts
    923.00 ± 26%     -48.7%     473.75 ± 16%  interrupts.CPU35.NMI:Non-maskable_interrupts
    923.00 ± 26%     -48.7%     473.75 ± 16%  interrupts.CPU35.PMI:Performance_monitoring_interrupts
    130.00 ± 12%    +325.0%     552.50 ± 22%  interrupts.CPU35.RES:Rescheduling_interrupts
      3446 ±  2%    +268.4%      12695 ± 11%  interrupts.CPU36.CAL:Function_call_interrupts
    814.00 ± 23%     -51.5%     394.50 ± 22%  interrupts.CPU36.NMI:Non-maskable_interrupts
    814.00 ± 23%     -51.5%     394.50 ± 22%  interrupts.CPU36.PMI:Performance_monitoring_interrupts
    106.50 ± 15%    +410.3%     543.50 ± 19%  interrupts.CPU36.RES:Rescheduling_interrupts
      3700 ±  5%    +247.8%      12871 ± 13%  interrupts.CPU37.CAL:Function_call_interrupts
    717.75 ± 35%     -43.1%     408.75 ± 23%  interrupts.CPU37.NMI:Non-maskable_interrupts
    717.75 ± 35%     -43.1%     408.75 ± 23%  interrupts.CPU37.PMI:Performance_monitoring_interrupts
    117.50 ± 14%    +367.9%     549.75 ± 23%  interrupts.CPU37.RES:Rescheduling_interrupts
      3528          +262.6%      12796 ± 14%  interrupts.CPU38.CAL:Function_call_interrupts
    917.25 ± 50%     -56.1%     403.00 ± 22%  interrupts.CPU38.NMI:Non-maskable_interrupts
    917.25 ± 50%     -56.1%     403.00 ± 22%  interrupts.CPU38.PMI:Performance_monitoring_interrupts
    118.25 ±  9%    +369.1%     554.75 ± 20%  interrupts.CPU38.RES:Rescheduling_interrupts
      3697 ± 10%    +244.9%      12753 ± 14%  interrupts.CPU39.CAL:Function_call_interrupts
    113.75 ± 21%    +368.4%     532.75 ± 19%  interrupts.CPU39.RES:Rescheduling_interrupts
    116.25 ± 78%    +193.5%     341.25 ±  6%  interrupts.CPU39.TLB:TLB_shootdowns
      3487 ±  2%    +274.6%      13062 ± 10%  interrupts.CPU4.CAL:Function_call_interrupts
    122.00 ± 16%    +365.0%     567.25 ± 19%  interrupts.CPU4.RES:Rescheduling_interrupts
      3830 ± 10%    +232.1%      12721 ± 13%  interrupts.CPU40.CAL:Function_call_interrupts
    818.00 ± 33%     -51.3%     398.50 ± 23%  interrupts.CPU40.NMI:Non-maskable_interrupts
    818.00 ± 33%     -51.3%     398.50 ± 23%  interrupts.CPU40.PMI:Performance_monitoring_interrupts
    119.00 ±  4%    +381.5%     573.00 ± 23%  interrupts.CPU40.RES:Rescheduling_interrupts
      3514          +266.3%      12871 ± 12%  interrupts.CPU41.CAL:Function_call_interrupts
      1007 ± 19%     -65.6%     346.50 ± 37%  interrupts.CPU41.NMI:Non-maskable_interrupts
      1007 ± 19%     -65.6%     346.50 ± 37%  interrupts.CPU41.PMI:Performance_monitoring_interrupts
    116.25 ± 10%    +374.0%     551.00 ± 26%  interrupts.CPU41.RES:Rescheduling_interrupts
     62.00 ± 88%    +277.4%     234.00 ± 28%  interrupts.CPU41.TLB:TLB_shootdowns
      3723 ±  6%    +248.5%      12978 ±  9%  interrupts.CPU42.CAL:Function_call_interrupts
    136.00 ± 14%    +295.2%     537.50 ± 20%  interrupts.CPU42.RES:Rescheduling_interrupts
     45.75 ±139%    +440.4%     247.25 ± 15%  interrupts.CPU42.TLB:TLB_shootdowns
      3752 ±  2%    +234.6%      12555 ± 13%  interrupts.CPU43.CAL:Function_call_interrupts
    118.75 ± 21%    +352.2%     537.00 ± 24%  interrupts.CPU43.RES:Rescheduling_interrupts
      3622 ±  3%    +253.6%      12807 ± 12%  interrupts.CPU44.CAL:Function_call_interrupts
      1098 ± 17%     -67.3%     359.50 ± 38%  interrupts.CPU44.NMI:Non-maskable_interrupts
      1098 ± 17%     -67.3%     359.50 ± 38%  interrupts.CPU44.PMI:Performance_monitoring_interrupts
    126.75 ±  6%    +339.3%     556.75 ± 24%  interrupts.CPU44.RES:Rescheduling_interrupts
     76.50 ±153%    +319.3%     320.75 ± 12%  interrupts.CPU44.TLB:TLB_shootdowns
      3651 ±  5%    +245.1%      12601 ± 13%  interrupts.CPU45.CAL:Function_call_interrupts
      1091 ±  7%     -67.8%     351.75 ± 38%  interrupts.CPU45.NMI:Non-maskable_interrupts
      1091 ±  7%     -67.8%     351.75 ± 38%  interrupts.CPU45.PMI:Performance_monitoring_interrupts
    119.50 ± 16%    +350.0%     537.75 ± 19%  interrupts.CPU45.RES:Rescheduling_interrupts
      3481 ±  3%    +264.5%      12690 ± 14%  interrupts.CPU46.CAL:Function_call_interrupts
      1052 ± 24%     -66.3%     354.00 ± 37%  interrupts.CPU46.NMI:Non-maskable_interrupts
      1052 ± 24%     -66.3%     354.00 ± 37%  interrupts.CPU46.PMI:Performance_monitoring_interrupts
    119.25 ± 15%    +351.6%     538.50 ± 23%  interrupts.CPU46.RES:Rescheduling_interrupts
      3616 ±  4%    +248.6%      12606 ± 11%  interrupts.CPU47.CAL:Function_call_interrupts
      1100 ± 22%     -62.0%     418.25 ± 36%  interrupts.CPU47.NMI:Non-maskable_interrupts
      1100 ± 22%     -62.0%     418.25 ± 36%  interrupts.CPU47.PMI:Performance_monitoring_interrupts
    108.00 ± 14%    +408.8%     549.50 ± 17%  interrupts.CPU47.RES:Rescheduling_interrupts
     41.25 ±133%    +570.3%     276.50 ± 22%  interrupts.CPU47.TLB:TLB_shootdowns
      3535 ±  9%    +281.0%      13468 ±  5%  interrupts.CPU48.CAL:Function_call_interrupts
    925.75 ± 24%     -59.8%     371.75 ± 45%  interrupts.CPU48.NMI:Non-maskable_interrupts
    925.75 ± 24%     -59.8%     371.75 ± 45%  interrupts.CPU48.PMI:Performance_monitoring_interrupts
    127.25 ±  8%    +432.2%     677.25 ± 13%  interrupts.CPU48.RES:Rescheduling_interrupts
      3647 ± 13%    +261.5%      13187 ± 10%  interrupts.CPU49.CAL:Function_call_interrupts
    958.00 ± 32%     -51.8%     462.00 ± 16%  interrupts.CPU49.NMI:Non-maskable_interrupts
    958.00 ± 32%     -51.8%     462.00 ± 16%  interrupts.CPU49.PMI:Performance_monitoring_interrupts
    131.50 ± 12%    +379.7%     630.75 ± 15%  interrupts.CPU49.RES:Rescheduling_interrupts
      3779 ±  8%    +245.3%      13049 ±  9%  interrupts.CPU5.CAL:Function_call_interrupts
    113.50 ±  8%    +471.6%     648.75 ± 19%  interrupts.CPU5.RES:Rescheduling_interrupts
    155.00 ± 32%     +60.6%     249.00 ± 15%  interrupts.CPU5.TLB:TLB_shootdowns
      3724 ± 12%    +248.1%      12963 ± 10%  interrupts.CPU50.CAL:Function_call_interrupts
    934.25 ± 23%     -49.7%     470.25 ± 15%  interrupts.CPU50.NMI:Non-maskable_interrupts
    934.25 ± 23%     -49.7%     470.25 ± 15%  interrupts.CPU50.PMI:Performance_monitoring_interrupts
    117.00 ± 10%    +388.2%     571.25 ± 16%  interrupts.CPU50.RES:Rescheduling_interrupts
      3687 ±  9%    +253.9%      13051 ±  8%  interrupts.CPU51.CAL:Function_call_interrupts
    964.00 ± 26%     -50.8%     474.25 ± 17%  interrupts.CPU51.NMI:Non-maskable_interrupts
    964.00 ± 26%     -50.8%     474.25 ± 17%  interrupts.CPU51.PMI:Performance_monitoring_interrupts
    129.00 ± 12%    +357.6%     590.25 ± 12%  interrupts.CPU51.RES:Rescheduling_interrupts
      3725 ±  9%    +246.1%      12891 ±  9%  interrupts.CPU52.CAL:Function_call_interrupts
    903.75 ± 44%     -47.6%     474.00 ± 15%  interrupts.CPU52.NMI:Non-maskable_interrupts
    903.75 ± 44%     -47.6%     474.00 ± 15%  interrupts.CPU52.PMI:Performance_monitoring_interrupts
    110.25 ± 11%    +418.6%     571.75 ± 17%  interrupts.CPU52.RES:Rescheduling_interrupts
    172.50 ± 42%     +63.0%     281.25        interrupts.CPU52.TLB:TLB_shootdowns
      3854 ± 24%    +236.8%      12982 ±  8%  interrupts.CPU53.CAL:Function_call_interrupts
    109.25 ± 13%    +441.4%     591.50 ± 17%  interrupts.CPU53.RES:Rescheduling_interrupts
      3417 ±  3%    +295.9%      13527 ±  8%  interrupts.CPU54.CAL:Function_call_interrupts
    793.00 ± 18%     -40.8%     469.25 ± 16%  interrupts.CPU54.NMI:Non-maskable_interrupts
    793.00 ± 18%     -40.8%     469.25 ± 16%  interrupts.CPU54.PMI:Performance_monitoring_interrupts
    125.25 ± 12%    +421.6%     653.25 ± 12%  interrupts.CPU54.RES:Rescheduling_interrupts
      3512 ±  9%    +278.2%      13281 ± 10%  interrupts.CPU55.CAL:Function_call_interrupts
    776.50 ± 31%     -48.0%     404.00 ± 27%  interrupts.CPU55.NMI:Non-maskable_interrupts
    776.50 ± 31%     -48.0%     404.00 ± 27%  interrupts.CPU55.PMI:Performance_monitoring_interrupts
    119.75 ± 14%    +370.4%     563.25 ± 19%  interrupts.CPU55.RES:Rescheduling_interrupts
    140.00 ± 49%    +106.1%     288.50 ± 17%  interrupts.CPU55.TLB:TLB_shootdowns
      3482 ±  7%    +261.0%      12572 ±  9%  interrupts.CPU56.CAL:Function_call_interrupts
    897.00 ± 22%     -48.0%     466.75 ± 16%  interrupts.CPU56.NMI:Non-maskable_interrupts
    897.00 ± 22%     -48.0%     466.75 ± 16%  interrupts.CPU56.PMI:Performance_monitoring_interrupts
    116.00 ± 19%    +379.5%     556.25 ± 16%  interrupts.CPU56.RES:Rescheduling_interrupts
      3594 ± 10%    +263.4%      13061 ±  9%  interrupts.CPU57.CAL:Function_call_interrupts
    798.25 ±  7%     -40.5%     475.00 ± 17%  interrupts.CPU57.NMI:Non-maskable_interrupts
    798.25 ±  7%     -40.5%     475.00 ± 17%  interrupts.CPU57.PMI:Performance_monitoring_interrupts
    111.00 ±  9%    +444.4%     604.25 ± 12%  interrupts.CPU57.RES:Rescheduling_interrupts
      3498 ±  3%    +276.7%      13176 ±  9%  interrupts.CPU58.CAL:Function_call_interrupts
    858.00 ± 15%     -44.2%     479.00 ± 16%  interrupts.CPU58.NMI:Non-maskable_interrupts
    858.00 ± 15%     -44.2%     479.00 ± 16%  interrupts.CPU58.PMI:Performance_monitoring_interrupts
    101.75 ± 10%    +480.1%     590.25 ± 14%  interrupts.CPU58.RES:Rescheduling_interrupts
    194.00 ± 35%     +54.8%     300.25 ±  8%  interrupts.CPU58.TLB:TLB_shootdowns
      3487 ±  5%    +276.2%      13119 ±  8%  interrupts.CPU59.CAL:Function_call_interrupts
    932.75 ± 31%     -47.3%     491.75 ± 12%  interrupts.CPU59.NMI:Non-maskable_interrupts
    932.75 ± 31%     -47.3%     491.75 ± 12%  interrupts.CPU59.PMI:Performance_monitoring_interrupts
    119.50 ± 10%    +496.7%     713.00 ± 17%  interrupts.CPU59.RES:Rescheduling_interrupts
    136.50 ± 17%     +61.9%     221.00 ± 22%  interrupts.CPU59.TLB:TLB_shootdowns
      3576 ±  3%    +269.4%      13212 ± 10%  interrupts.CPU6.CAL:Function_call_interrupts
      1043 ± 16%     -58.7%     430.75 ± 33%  interrupts.CPU6.NMI:Non-maskable_interrupts
      1043 ± 16%     -58.7%     430.75 ± 33%  interrupts.CPU6.PMI:Performance_monitoring_interrupts
    119.00 ±  9%    +408.4%     605.00 ± 12%  interrupts.CPU6.RES:Rescheduling_interrupts
      3509 ±  5%    +264.8%      12804 ±  8%  interrupts.CPU60.CAL:Function_call_interrupts
      1138 ± 13%     -59.9%     456.75 ± 16%  interrupts.CPU60.NMI:Non-maskable_interrupts
      1138 ± 13%     -59.9%     456.75 ± 16%  interrupts.CPU60.PMI:Performance_monitoring_interrupts
    113.75 ± 11%    +400.2%     569.00 ± 21%  interrupts.CPU60.RES:Rescheduling_interrupts
      3560 ±  5%    +267.5%      13087 ± 10%  interrupts.CPU61.CAL:Function_call_interrupts
    121.50 ±  7%    +386.8%     591.50 ± 16%  interrupts.CPU61.RES:Rescheduling_interrupts
    207.00 ± 30%     +53.6%     318.00 ± 13%  interrupts.CPU61.TLB:TLB_shootdowns
      3470 ±  3%    +278.0%      13117 ± 10%  interrupts.CPU62.CAL:Function_call_interrupts
      1070 ± 28%     -55.2%     479.25 ± 17%  interrupts.CPU62.NMI:Non-maskable_interrupts
      1070 ± 28%     -55.2%     479.25 ± 17%  interrupts.CPU62.PMI:Performance_monitoring_interrupts
    114.00 ±  4%    +389.7%     558.25 ± 15%  interrupts.CPU62.RES:Rescheduling_interrupts
     93.00 ± 65%    +175.0%     255.75 ± 22%  interrupts.CPU62.TLB:TLB_shootdowns
      3594 ±  5%    +270.2%      13306 ±  7%  interrupts.CPU63.CAL:Function_call_interrupts
    996.75 ± 27%     -52.3%     475.00 ± 16%  interrupts.CPU63.NMI:Non-maskable_interrupts
    996.75 ± 27%     -52.3%     475.00 ± 16%  interrupts.CPU63.PMI:Performance_monitoring_interrupts
    106.25 ±  3%    +440.7%     574.50 ± 18%  interrupts.CPU63.RES:Rescheduling_interrupts
    163.25 ± 40%     +72.3%     281.25 ± 24%  interrupts.CPU63.TLB:TLB_shootdowns
      3603 ±  7%    +260.6%      12995 ±  9%  interrupts.CPU64.CAL:Function_call_interrupts
    979.50 ± 24%     -52.2%     467.75 ± 15%  interrupts.CPU64.NMI:Non-maskable_interrupts
    979.50 ± 24%     -52.2%     467.75 ± 15%  interrupts.CPU64.PMI:Performance_monitoring_interrupts
    104.25 ± 10%    +443.6%     566.75 ± 15%  interrupts.CPU64.RES:Rescheduling_interrupts
      3598 ±  7%    +255.8%      12804 ±  9%  interrupts.CPU65.CAL:Function_call_interrupts
    873.50 ± 24%     -44.8%     482.25 ± 13%  interrupts.CPU65.NMI:Non-maskable_interrupts
    873.50 ± 24%     -44.8%     482.25 ± 13%  interrupts.CPU65.PMI:Performance_monitoring_interrupts
    115.50 ±  9%    +451.3%     636.75 ± 17%  interrupts.CPU65.RES:Rescheduling_interrupts
    134.75 ± 36%    +109.5%     282.25 ±  4%  interrupts.CPU65.TLB:TLB_shootdowns
      3546 ±  5%    +264.0%      12910 ± 10%  interrupts.CPU66.CAL:Function_call_interrupts
      1243 ± 13%     -63.1%     459.00 ± 18%  interrupts.CPU66.NMI:Non-maskable_interrupts
      1243 ± 13%     -63.1%     459.00 ± 18%  interrupts.CPU66.PMI:Performance_monitoring_interrupts
    120.00 ±  7%    +371.9%     566.25 ± 12%  interrupts.CPU66.RES:Rescheduling_interrupts
      3368 ±  8%    +287.0%      13036 ±  9%  interrupts.CPU67.CAL:Function_call_interrupts
    109.00 ± 12%    +420.2%     567.00 ± 13%  interrupts.CPU67.RES:Rescheduling_interrupts
    120.50 ± 70%    +124.7%     270.75 ± 16%  interrupts.CPU67.TLB:TLB_shootdowns
      3358 ±  5%    +287.0%      12995 ± 10%  interrupts.CPU68.CAL:Function_call_interrupts
    971.00 ± 27%     -51.2%     474.00 ± 16%  interrupts.CPU68.NMI:Non-maskable_interrupts
    971.00 ± 27%     -51.2%     474.00 ± 16%  interrupts.CPU68.PMI:Performance_monitoring_interrupts
    116.75 ± 15%    +376.2%     556.00 ± 19%  interrupts.CPU68.RES:Rescheduling_interrupts
    111.00 ± 12%    +106.8%     229.50 ± 34%  interrupts.CPU68.TLB:TLB_shootdowns
      3624 ±  7%    +268.5%      13354 ±  9%  interrupts.CPU69.CAL:Function_call_interrupts
    112.75 ± 16%    +382.0%     543.50 ± 14%  interrupts.CPU69.RES:Rescheduling_interrupts
      3480 ±  2%    +269.5%      12861 ± 11%  interrupts.CPU7.CAL:Function_call_interrupts
      1253 ± 14%     -62.7%     468.00 ± 16%  interrupts.CPU7.NMI:Non-maskable_interrupts
      1253 ± 14%     -62.7%     468.00 ± 16%  interrupts.CPU7.PMI:Performance_monitoring_interrupts
    125.00 ± 12%    +348.2%     560.25 ± 19%  interrupts.CPU7.RES:Rescheduling_interrupts
      3442 ±  6%    +281.4%      13129 ±  8%  interrupts.CPU70.CAL:Function_call_interrupts
    110.75 ±  9%    +408.8%     563.50 ± 17%  interrupts.CPU70.RES:Rescheduling_interrupts
    140.75 ± 32%     +88.8%     265.75 ± 21%  interrupts.CPU70.TLB:TLB_shootdowns
      3521 ±  8%    +270.0%      13031 ±  9%  interrupts.CPU71.CAL:Function_call_interrupts
    101.75 ±  8%    +488.5%     598.75 ± 15%  interrupts.CPU71.RES:Rescheduling_interrupts
      3633 ± 10%    +235.3%      12184 ± 20%  interrupts.CPU72.CAL:Function_call_interrupts
      1348 ± 10%     -64.6%     477.75 ± 16%  interrupts.CPU72.NMI:Non-maskable_interrupts
      1348 ± 10%     -64.6%     477.75 ± 16%  interrupts.CPU72.PMI:Performance_monitoring_interrupts
    154.75 ± 21%    +288.0%     600.50 ± 23%  interrupts.CPU72.RES:Rescheduling_interrupts
      3492 ± 10%    +223.2%      11287 ± 22%  interrupts.CPU73.CAL:Function_call_interrupts
    848.00 ± 25%     -44.4%     471.75 ± 16%  interrupts.CPU73.NMI:Non-maskable_interrupts
    848.00 ± 25%     -44.4%     471.75 ± 16%  interrupts.CPU73.PMI:Performance_monitoring_interrupts
    127.75 ±  9%    +228.0%     419.00 ± 20%  interrupts.CPU73.RES:Rescheduling_interrupts
      3799 ±  9%    +201.4%      11451 ± 22%  interrupts.CPU74.CAL:Function_call_interrupts
      1162 ± 12%     -59.4%     471.75 ± 18%  interrupts.CPU74.NMI:Non-maskable_interrupts
      1162 ± 12%     -59.4%     471.75 ± 18%  interrupts.CPU74.PMI:Performance_monitoring_interrupts
    134.25 ± 19%    +210.4%     416.75 ± 25%  interrupts.CPU74.RES:Rescheduling_interrupts
      3599 ± 13%    +218.6%      11467 ± 22%  interrupts.CPU75.CAL:Function_call_interrupts
      1113 ± 17%     -58.0%     467.75 ± 19%  interrupts.CPU75.NMI:Non-maskable_interrupts
      1113 ± 17%     -58.0%     467.75 ± 19%  interrupts.CPU75.PMI:Performance_monitoring_interrupts
    127.50 ± 26%    +240.2%     433.75 ± 25%  interrupts.CPU75.RES:Rescheduling_interrupts
      3698 ± 15%    +211.5%      11518 ± 22%  interrupts.CPU76.CAL:Function_call_interrupts
      1147 ± 18%     -59.5%     465.00 ± 17%  interrupts.CPU76.NMI:Non-maskable_interrupts
      1147 ± 18%     -59.5%     465.00 ± 17%  interrupts.CPU76.PMI:Performance_monitoring_interrupts
    130.25 ± 24%    +250.9%     457.00 ± 26%  interrupts.CPU76.RES:Rescheduling_interrupts
      3557 ±  9%    +247.5%      12361 ± 17%  interrupts.CPU77.CAL:Function_call_interrupts
      1059 ± 23%     -55.8%     468.25 ± 17%  interrupts.CPU77.NMI:Non-maskable_interrupts
      1059 ± 23%     -55.8%     468.25 ± 17%  interrupts.CPU77.PMI:Performance_monitoring_interrupts
    114.75 ± 16%    +272.5%     427.50 ± 26%  interrupts.CPU77.RES:Rescheduling_interrupts
      3790 ± 10%    +212.2%      11833 ± 23%  interrupts.CPU78.CAL:Function_call_interrupts
    942.50 ± 14%     -50.5%     467.00 ± 19%  interrupts.CPU78.NMI:Non-maskable_interrupts
    942.50 ± 14%     -50.5%     467.00 ± 19%  interrupts.CPU78.PMI:Performance_monitoring_interrupts
    144.25 ± 24%    +223.4%     466.50 ± 23%  interrupts.CPU78.RES:Rescheduling_interrupts
      3620 ±  3%    +225.0%      11767 ± 22%  interrupts.CPU79.CAL:Function_call_interrupts
    912.50 ± 16%     -55.8%     403.50 ± 28%  interrupts.CPU79.NMI:Non-maskable_interrupts
    912.50 ± 16%     -55.8%     403.50 ± 28%  interrupts.CPU79.PMI:Performance_monitoring_interrupts
    110.75 ± 20%    +302.7%     446.00 ± 22%  interrupts.CPU79.RES:Rescheduling_interrupts
      3611 ±  5%    +250.3%      12651 ± 10%  interrupts.CPU8.CAL:Function_call_interrupts
    951.50 ±  7%     -54.4%     433.75 ± 33%  interrupts.CPU8.NMI:Non-maskable_interrupts
    951.50 ±  7%     -54.4%     433.75 ± 33%  interrupts.CPU8.PMI:Performance_monitoring_interrupts
    122.25 ± 14%    +386.3%     594.50 ± 15%  interrupts.CPU8.RES:Rescheduling_interrupts
    124.00 ± 75%    +155.4%     316.75 ± 18%  interrupts.CPU8.TLB:TLB_shootdowns
      3868 ±  6%    +197.5%      11507 ± 21%  interrupts.CPU80.CAL:Function_call_interrupts
      1215 ± 10%     -61.7%     464.75 ± 19%  interrupts.CPU80.NMI:Non-maskable_interrupts
      1215 ± 10%     -61.7%     464.75 ± 19%  interrupts.CPU80.PMI:Performance_monitoring_interrupts
    126.00 ± 14%    +229.2%     414.75 ± 25%  interrupts.CPU80.RES:Rescheduling_interrupts
      3596 ±  4%    +223.1%      11617 ± 22%  interrupts.CPU81.CAL:Function_call_interrupts
      1061 ± 23%     -56.7%     459.00 ± 16%  interrupts.CPU81.NMI:Non-maskable_interrupts
      1061 ± 23%     -56.7%     459.00 ± 16%  interrupts.CPU81.PMI:Performance_monitoring_interrupts
    123.25 ±  3%    +280.9%     469.50 ± 25%  interrupts.CPU81.RES:Rescheduling_interrupts
      3815 ±  8%    +211.8%      11895 ± 22%  interrupts.CPU82.CAL:Function_call_interrupts
    130.50 ± 14%    +264.0%     475.00 ± 28%  interrupts.CPU82.RES:Rescheduling_interrupts
      3541 ±  8%    +234.9%      11862 ± 22%  interrupts.CPU83.CAL:Function_call_interrupts
      1100 ±  7%     -57.6%     466.75 ± 17%  interrupts.CPU83.NMI:Non-maskable_interrupts
      1100 ±  7%     -57.6%     466.75 ± 17%  interrupts.CPU83.PMI:Performance_monitoring_interrupts
    123.00 ± 14%    +308.7%     502.75 ± 24%  interrupts.CPU83.RES:Rescheduling_interrupts
      3865 ±  4%    +203.2%      11720 ± 22%  interrupts.CPU84.CAL:Function_call_interrupts
      1199 ± 15%     -60.7%     471.25 ± 13%  interrupts.CPU84.NMI:Non-maskable_interrupts
      1199 ± 15%     -60.7%     471.25 ± 13%  interrupts.CPU84.PMI:Performance_monitoring_interrupts
    144.75 ± 10%    +204.7%     441.00 ± 27%  interrupts.CPU84.RES:Rescheduling_interrupts
      3869 ±  2%    +195.5%      11435 ± 21%  interrupts.CPU85.CAL:Function_call_interrupts
      1019 ± 14%     -53.9%     469.75 ± 19%  interrupts.CPU85.NMI:Non-maskable_interrupts
      1019 ± 14%     -53.9%     469.75 ± 19%  interrupts.CPU85.PMI:Performance_monitoring_interrupts
    127.25 ± 20%    +230.3%     420.25 ± 23%  interrupts.CPU85.RES:Rescheduling_interrupts
      3700 ±  6%    +213.8%      11611 ± 21%  interrupts.CPU86.CAL:Function_call_interrupts
    963.50 ± 25%     -49.7%     485.00 ± 15%  interrupts.CPU86.NMI:Non-maskable_interrupts
    963.50 ± 25%     -49.7%     485.00 ± 15%  interrupts.CPU86.PMI:Performance_monitoring_interrupts
    124.00 ± 25%    +264.3%     451.75 ± 21%  interrupts.CPU86.RES:Rescheduling_interrupts
      3764 ± 11%    +202.7%      11395 ± 22%  interrupts.CPU87.CAL:Function_call_interrupts
    893.50 ± 27%     -46.8%     475.50 ± 13%  interrupts.CPU87.NMI:Non-maskable_interrupts
    893.50 ± 27%     -46.8%     475.50 ± 13%  interrupts.CPU87.PMI:Performance_monitoring_interrupts
    116.25 ± 18%    +266.5%     426.00 ± 28%  interrupts.CPU87.RES:Rescheduling_interrupts
      3632 ±  7%    +231.6%      12045 ± 21%  interrupts.CPU88.CAL:Function_call_interrupts
      1147 ± 20%     -58.6%     474.75 ± 16%  interrupts.CPU88.NMI:Non-maskable_interrupts
      1147 ± 20%     -58.6%     474.75 ± 16%  interrupts.CPU88.PMI:Performance_monitoring_interrupts
    122.00 ± 16%    +274.0%     456.25 ± 25%  interrupts.CPU88.RES:Rescheduling_interrupts
      3739 ±  6%    +215.9%      11811 ± 23%  interrupts.CPU89.CAL:Function_call_interrupts
      1187 ± 28%     -60.7%     466.50 ± 16%  interrupts.CPU89.NMI:Non-maskable_interrupts
      1187 ± 28%     -60.7%     466.50 ± 16%  interrupts.CPU89.PMI:Performance_monitoring_interrupts
    122.00 ± 14%    +260.5%     439.75 ± 23%  interrupts.CPU89.RES:Rescheduling_interrupts
      3541 ±  5%    +256.0%      12606 ± 11%  interrupts.CPU9.CAL:Function_call_interrupts
    826.50 ± 21%     -49.8%     414.75 ± 33%  interrupts.CPU9.NMI:Non-maskable_interrupts
    826.50 ± 21%     -49.8%     414.75 ± 33%  interrupts.CPU9.PMI:Performance_monitoring_interrupts
    119.50 ± 16%    +380.3%     574.00 ± 14%  interrupts.CPU9.RES:Rescheduling_interrupts
      3599 ±  4%    +224.8%      11688 ± 22%  interrupts.CPU90.CAL:Function_call_interrupts
    891.75 ±  7%     -48.3%     461.00 ± 18%  interrupts.CPU90.NMI:Non-maskable_interrupts
    891.75 ±  7%     -48.3%     461.00 ± 18%  interrupts.CPU90.PMI:Performance_monitoring_interrupts
    123.25 ±  3%    +283.8%     473.00 ± 21%  interrupts.CPU90.RES:Rescheduling_interrupts
      3608 ±  3%    +227.5%      11817 ± 22%  interrupts.CPU91.CAL:Function_call_interrupts
    111.75 ± 12%    +294.0%     440.25 ± 22%  interrupts.CPU91.RES:Rescheduling_interrupts
      3545 ±  5%    +232.7%      11795 ± 20%  interrupts.CPU92.CAL:Function_call_interrupts
      1196 ± 15%     -60.2%     476.00 ± 15%  interrupts.CPU92.NMI:Non-maskable_interrupts
      1196 ± 15%     -60.2%     476.00 ± 15%  interrupts.CPU92.PMI:Performance_monitoring_interrupts
    134.25 ±  7%    +236.9%     452.25 ± 27%  interrupts.CPU92.RES:Rescheduling_interrupts
      3651 ± 13%    +217.4%      11589 ± 21%  interrupts.CPU93.CAL:Function_call_interrupts
    114.75 ± 20%    +293.5%     451.50 ± 25%  interrupts.CPU93.RES:Rescheduling_interrupts
      3516 ±  5%    +234.6%      11765 ± 21%  interrupts.CPU94.CAL:Function_call_interrupts
    948.25 ± 25%     -50.2%     472.25 ± 16%  interrupts.CPU94.NMI:Non-maskable_interrupts
    948.25 ± 25%     -50.2%     472.25 ± 16%  interrupts.CPU94.PMI:Performance_monitoring_interrupts
    127.50 ±  8%    +312.7%     526.25 ± 25%  interrupts.CPU94.RES:Rescheduling_interrupts
      4030 ± 13%    +180.7%      11311 ± 21%  interrupts.CPU95.CAL:Function_call_interrupts
      1095 ± 15%     -57.7%     463.50 ± 13%  interrupts.CPU95.NMI:Non-maskable_interrupts
      1095 ± 15%     -57.7%     463.50 ± 13%  interrupts.CPU95.PMI:Performance_monitoring_interrupts
    115.75 ± 10%    +283.2%     443.50 ± 26%  interrupts.CPU95.RES:Rescheduling_interrupts
      3557 ±  5%    +259.3%      12782 ± 11%  interrupts.CPU96.CAL:Function_call_interrupts
    119.75 ± 13%    +371.2%     564.25 ± 18%  interrupts.CPU96.RES:Rescheduling_interrupts
      3490 ±  4%    +287.2%      13515 ± 16%  interrupts.CPU97.CAL:Function_call_interrupts
    943.50 ± 35%     -57.4%     402.25 ± 23%  interrupts.CPU97.NMI:Non-maskable_interrupts
    943.50 ± 35%     -57.4%     402.25 ± 23%  interrupts.CPU97.PMI:Performance_monitoring_interrupts
    130.25 ± 17%    +435.5%     697.50 ± 24%  interrupts.CPU97.RES:Rescheduling_interrupts
      3598 ±  6%    +265.8%      13160 ± 12%  interrupts.CPU98.CAL:Function_call_interrupts
      1166 ± 19%     -60.4%     461.50 ± 14%  interrupts.CPU98.NMI:Non-maskable_interrupts
      1166 ± 19%     -60.4%     461.50 ± 14%  interrupts.CPU98.PMI:Performance_monitoring_interrupts
    111.00 ± 18%    +420.7%     578.00 ± 13%  interrupts.CPU98.RES:Rescheduling_interrupts
    168.50 ± 72%     +81.6%     306.00 ± 15%  interrupts.CPU98.TLB:TLB_shootdowns
      3455 ±  5%    +300.4%      13834 ±  8%  interrupts.CPU99.CAL:Function_call_interrupts
    873.75 ± 28%     -45.8%     473.25 ± 14%  interrupts.CPU99.NMI:Non-maskable_interrupts
    873.75 ± 28%     -45.8%     473.25 ± 14%  interrupts.CPU99.PMI:Performance_monitoring_interrupts
    108.75 ± 17%    +481.8%     632.75 ± 20%  interrupts.CPU99.RES:Rescheduling_interrupts
     90.75 ± 54%    +466.4%     514.00 ±  4%  interrupts.IWI:IRQ_work_interrupts
    185055 ±  9%     -54.5%      84131 ± 14%  interrupts.NMI:Non-maskable_interrupts
    185055 ±  9%     -54.5%      84131 ± 14%  interrupts.PMI:Performance_monitoring_interrupts
     23309 ±  5%    +373.8%     110434 ±  9%  interrupts.RES:Rescheduling_interrupts
     29544 ± 31%     +69.3%      50026 ±  8%  interrupts.TLB:TLB_shootdowns


                                                                                
                           vm-scalability.time.user_time                        
                                                                                
  450 +---------------------------------------------------------------------+   
      |    O                                                                |   
  400 |-+       O  O       O    O    O                                      |   
  350 |-+O    O       O O    O     O                                        |   
      |                                                                     |   
  300 |-+                                                                   |   
  250 |-+                               O O  O O                            |   
      |                                                                     |   
  200 |-+                                                                   |   
  150 |-+                                                                   |   
      |                                                                     |   
  100 |-+                                                                   |   
   50 |-+                                                                   |   
      |..+.+..+.+..+..+.+..+.+..+..+.+..+.+..+.+..+..+.+..+.+..+..+.+..+.+..|   
    0 +---------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                         vm-scalability.time.elapsed_time                       
                                                                                
  325 +---------------------------------------------------------------------+   
      |    O                                                                |   
      |                                                                     |   
  320 |-+                                                                   |   
      |                                                                     |   
      |                                                                     |   
  315 |-+                                                                   |   
      |                         O    O                                      |   
  310 |-+O    O O  O  O O  O O     O    O O  O                              |   
      |                                        O                            |   
      |                                                                     |   
  305 |-+                                                                   |   
      |..+.  .+.+..+..+.    .+..+.. .+..    .+.+..+..+.+..       .+.  .+.   |   
      |    +.           +..+       +    +.+.              +.+..+.   +.   +..|   
  300 +---------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                       vm-scalability.time.elapsed_time.max                     
                                                                                
  325 +---------------------------------------------------------------------+   
      |    O                                                                |   
      |                                                                     |   
  320 |-+                                                                   |   
      |                                                                     |   
      |                                                                     |   
  315 |-+                                                                   |   
      |                         O    O                                      |   
  310 |-+O    O O  O  O O  O O     O    O O  O                              |   
      |                                        O                            |   
      |                                                                     |   
  305 |-+                                                                   |   
      |..+.  .+.+..+..+.    .+..+.. .+..    .+.+..+..+.+..       .+.  .+.   |   
      |    +.           +..+       +    +.+.              +.+..+.   +.   +..|   
  300 +---------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                         vm-scalability.time.minor_page_faults                  
                                                                                
  1.8e+08 +-----------------------------------------------------------------+   
          |    O                                                            |   
  1.6e+08 |-+                                                               |   
  1.4e+08 |-+                     O    O                                    |   
          |                                                                 |   
  1.2e+08 |-+                                                               |   
    1e+08 |-+                                                               |   
          | O    O  O O  O O  O O    O                                      |   
    8e+07 |-+                             O O  O O                          |   
    6e+07 |-+                                                               |   
          |                                                                 |   
    4e+07 |-+                                                               |   
    2e+07 |-+                                                               |   
          |.+..+.+..+.+..+.+..+.+.+..+.+..+.+..+.+..+.+.+..+.+..+.+..+.+..+.|   
        0 +-----------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                    vm-scalability.time.voluntary_context_switches              
                                                                                
  1.8e+08 +-----------------------------------------------------------------+   
          |    O                                                            |   
  1.6e+08 |-+                                                               |   
  1.4e+08 |-+                     O    O                                    |   
          |                                                                 |   
  1.2e+08 |-+                                                               |   
    1e+08 |-+                 O                                             |   
          | O    O  O O  O O    O    O    O                                 |   
    8e+07 |-+                               O  O O                          |   
    6e+07 |-+                                                               |   
          |                                                                 |   
    4e+07 |-+                                                               |   
    2e+07 |-+                                                               |   
          |.+..+.  .+.+..             .+..+.+..                             |   
        0 +-----------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                       perf-sched.total_wait_and_delay.count.ms                 
                                                                                
  3.5e+06 +-----------------------------------------------------------------+   
          |    O                                                            |   
    3e+06 |-+                                                               |   
          |                                                                 |   
  2.5e+06 |-+                                                               |   
          |                                                                 |   
    2e+06 |-+                                                               |   
          |      O  O    O O  O O O  O O                                    |   
  1.5e+06 |-+                             O O    O                          |   
          | O         O                        O                            |   
    1e+06 |-+                                                               |   
          |                                                                 |   
   500000 |.+..+.+..+.+..                                 .+.+..+.+..+.+..+.|   
          |              +.+..+.+.+..+.+..+.+..+.+..+.+.+.                  |   
        0 +-----------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                                                                                
                                                                                
    3e+06 +-----------------------------------------------------------------+   
          |     O                                                           |   
  2.5e+06 |-+                                                               |   
          |                                                                 |   
          |                                                                 |   
    2e+06 |-+                                                               |   
          |                                                                 |   
  1.5e+06 |-+      O O     O  O  O  O  O  O O                               |   
          |                                    O  O     O                   |   
    1e+06 |-+O          O                            O                      |   
          |                                                                 |   
          |                                                                 |   
   500000 |..+..+..+.+..+..                                             .+..|   
          |                +..+..+..+..+..+.+..+..+..+..+..+..+..+.+..+.    |   
        0 +-----------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                                                                                
                                                                                
  600 +---------------------------------------------------------------------+   
      |                      +                                              |   
  500 |-+                    :+                                             |   
      |                     :  +                                            |   
      |                     :   +..                                         |   
  400 |-+                  :                      +..  +..                  |   
      |   .+..         .+..+       +.           ..    +                     |   
  300 |..+     .+..  .+              +..+.+..+.+     +    +.  .+..  +.. .+..|   
      |       +    +.                                       +.     +   +    |   
  200 |-+                                                         +         |   
      |                                                                     |   
      |                                                                     |   
  100 |-+                                                                   |   
      |                                                                     |   
    0 +---------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                                                                                
                                                                                
  600 +---------------------------------------------------------------------+   
      |                      +                                              |   
  500 |-+                    :+                                             |   
      |                     :  +                                            |   
      |                     :   +..                                         |   
  400 |-+                  :                      +..  +..                  |   
      |   .+..         .+..+       +.           ..    +                     |   
  300 |..+     .+..  .+              +..+.+..+.+     +    +.  .+..  +.. .+..|   
      |       +    +.                                       +.     +   +    |   
  200 |-+                                                         +         |   
      |                                                                     |   
      |                                                                     |   
  100 |-+                                                                   |   
      |                                                                     |   
    0 +---------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                               vm-scalability.throughput                        
                                                                                
    3e+06 +-----------------------------------------------------------------+   
          |                                                                 |   
  2.5e+06 |-+  O                                                            |   
          |                                                                 |   
          |                       O    O                                    |   
    2e+06 |-+                                                               |   
          |                                                                 |   
  1.5e+06 |-+                 O                                             |   
          | O    O  O O  O O    O    O    O      O                          |   
    1e+06 |-+                               O  O                            |   
          |                                                                 |   
          |                                                                 |   
   500000 |-+                                                               |   
          |.+..+.+..+.+..+.+..+.+.+..+.+..+.+..+.+..+.+.+..+.+..+.+..+.+..+.|   
        0 +-----------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                              vm-scalability.stddev_                            
                                                                                
  700 +---------------------------------------------------------------------+   
      |                                                                     |   
  600 |-.+                                               .+    +..    .+.+..|   
      |.  +  .+.+..+..+.+..       .+.+..+.  .+.  .+.. .+.  + ..    .+.      |   
  500 |-+  +.              +.+..+.        +.   +.    +      +     +         |   
      |                                                                     |   
  400 |-+                                                                   |   
      |                                                                     |   
  300 |-+                                                                   |   
      |                                                                     |   
  200 |-+                                                                   |   
      |                                                                     |   
  100 |-+                                                                   |   
      |                                                                     |   
    0 +---------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                                vm-scalability.median                           
                                                                                
  14000 +-------------------------------------------------------------------+   
        |    O                                                              |   
  12000 |-+                                                                 |   
        |                        O    O                                     |   
  10000 |-+                                                                 |   
        |                                                                   |   
   8000 |-+                                                                 |   
        |  O    O O  O O  O O  O    O    O                                  |   
   6000 |-+                                O  O O                           |   
        |                                                                   |   
   4000 |-+                                                                 |   
        |                                                                   |   
   2000 |-+                                                                 |   
        |..+.+..+.+..+.+..+.+..+.+..+.+..+.+..+.+..+.+..+.+..+.+..+.+..+.+..|   
      0 +-------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                               vm-scalability.workload                          
                                                                                
  8e+08 +-------------------------------------------------------------------+   
        |    O                                                              |   
  7e+08 |-+                                                                 |   
  6e+08 |-+                      O    O                                     |   
        |                                                                   |   
  5e+08 |-+                                                                 |   
        |                                                                   |   
  4e+08 |-+O    O O  O O  O O  O    O    O                                  |   
        |                                  O  O O                           |   
  3e+08 |-+                                                                 |   
  2e+08 |-+                                                                 |   
        |                                                                   |   
  1e+08 |-+                                                                 |   
        |..+.+..+.+..+.+..+.+..+.+..+.+..+.+..+.+..+.+..+.+..+.+..+.+..+.+..|   
      0 +-------------------------------------------------------------------+   
                                                                                
                                                                                
[*] bisect-good sample
[O] bisect-bad  sample



Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


Thanks,
Oliver Sang


--ep0oHQY+/Gbo/zt0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="config-5.10.0-rc6-00077-g2f06f702925b"

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

--ep0oHQY+/Gbo/zt0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=job-script

#!/bin/sh

export_top_env()
{
	export suite='vm-scalability'
	export testcase='vm-scalability'
	export category='benchmark'
	export runtime=300
	export size=
	export job_origin='/lkp-src/allot/cyclic:p1:linux-devel:devel-hourly/lkp-csl-2ap4/vm-scalability.yaml'
	export queue_cmdline_keys='branch
commit
queue_at_least_once'
	export queue='validate'
	export testbox='lkp-csl-2ap4'
	export tbox_group='lkp-csl-2ap4'
	export kconfig='x86_64-rhel-8.3'
	export submit_id='5fda738c73ccaacc6f72d68e'
	export job_file='/lkp/jobs/scheduled/lkp-csl-2ap4/vm-scalability-performance-300s-small-allocs-mt-ucode=0x5003003-monitor=0fe5055f-debian-10.4-x86_64-20200603.cgz-2f06f702925b512-20201217-52335-190ac6c-3.yaml'
	export id='932a02c7bd77ec6d09215013918beff7b1b49e6b'
	export queuer_version='/lkp-src'
	export model='Cascade Lake'
	export nr_node=4
	export nr_cpu=192
	export memory='192G'
	export ssd_partitions='/dev/disk/by-id/nvme-INTEL_SSDPECME016T4_CVF87091000G1P6IGN-*-part1'
	export rootfs_partition='LABEL=LKP-ROOTFS'
	export kernel_cmdline_hw='acpi_rsdp=0x67f44014'
	export brand='Intel(R) Xeon(R) Platinum 9242 CPU @ 2.30GHz'
	export need_kconfig='CONFIG_BLK_DEV_LOOP'
	export commit='2f06f702925b512a95b95dca3855549c047eef58'
	export need_kconfig_hw='CONFIG_IGB=y
CONFIG_BLK_DEV_NVME'
	export ucode='0x5003003'
	export enqueue_time='2020-12-17 04:52:28 +0800'
	export _id='5fda738e73ccaacc6f72d68f'
	export _rt='/result/vm-scalability/performance-300s-small-allocs-mt-ucode=0x5003003-monitor=0fe5055f/lkp-csl-2ap4/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/2f06f702925b512a95b95dca3855549c047eef58'
	export user='lkp'
	export compiler='gcc-9'
	export head_commit='5a790e0217a4dbbe9c287b7b7f2d3f32d4df0812'
	export base_commit='2c85ebc57b3e1817b6ce1a6b703928e113a90442'
	export branch='linus/master'
	export rootfs='debian-10.4-x86_64-20200603.cgz'
	export monitor_sha='0fe5055f'
	export result_root='/result/vm-scalability/performance-300s-small-allocs-mt-ucode=0x5003003-monitor=0fe5055f/lkp-csl-2ap4/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/2f06f702925b512a95b95dca3855549c047eef58/3'
	export scheduler_version='/lkp/lkp/.src-20201216-155149'
	export LKP_SERVER='internal-lkp-server'
	export arch='x86_64'
	export max_uptime=2100
	export initrd='/osimage/debian/debian-10.4-x86_64-20200603.cgz'
	export bootloader_append='root=/dev/ram0
user=lkp
job=/lkp/jobs/scheduled/lkp-csl-2ap4/vm-scalability-performance-300s-small-allocs-mt-ucode=0x5003003-monitor=0fe5055f-debian-10.4-x86_64-20200603.cgz-2f06f702925b512-20201217-52335-190ac6c-3.yaml
ARCH=x86_64
kconfig=x86_64-rhel-8.3
branch=linus/master
commit=2f06f702925b512a95b95dca3855549c047eef58
BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3/gcc-9/2f06f702925b512a95b95dca3855549c047eef58/vmlinuz-5.10.0-rc6-00077-g2f06f702925b
acpi_rsdp=0x67f44014
max_uptime=2100
RESULT_ROOT=/result/vm-scalability/performance-300s-small-allocs-mt-ucode=0x5003003-monitor=0fe5055f/lkp-csl-2ap4/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/2f06f702925b512a95b95dca3855549c047eef58/3
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
	export modules_initrd='/pkg/linux/x86_64-rhel-8.3/gcc-9/2f06f702925b512a95b95dca3855549c047eef58/modules.cgz'
	export bm_initrd='/osimage/deps/debian-10.4-x86_64-20200603.cgz/run-ipconfig_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/lkp_20201211.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/rsync-rootfs_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/perf_20201126.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/perf-x86_64-fa02fcd94b0c-1_20201126.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/vm-scalability_20201110.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/vm-scalability-x86_64-1.0-0_20201110.cgz,/osimage/pkg/common/vm-scalability-x86_64.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/mpstat_20200714.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/sar-x86_64-34c92ae-1_20200702.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/hw_20200715.cgz'
	export ucode_initrd='/osimage/ucode/intel-ucode-20201117.cgz'
	export lkp_initrd='/osimage/user/lkp/lkp-x86_64.cgz'
	export site='inn'
	export LKP_CGI_PORT=80
	export LKP_CIFS_PORT=139
	export last_kernel='5.10.1-11352-g5a790e0217a4'
	export repeat_to=4
	export schedule_notify_address=
	export queue_at_least_once=1
	export kernel='/pkg/linux/x86_64-rhel-8.3/gcc-9/2f06f702925b512a95b95dca3855549c047eef58/vmlinuz-5.10.0-rc6-00077-g2f06f702925b'
	export dequeue_time='2020-12-17 05:03:15 +0800'
	export job_initrd='/lkp/jobs/scheduled/lkp-csl-2ap4/vm-scalability-performance-300s-small-allocs-mt-ucode=0x5003003-monitor=0fe5055f-debian-10.4-x86_64-20200603.cgz-2f06f702925b512-20201217-52335-190ac6c-3.cgz'

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

	run_test test='small-allocs-mt' $LKP_SRC/tests/wrapper vm-scalability
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

--ep0oHQY+/Gbo/zt0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="job.yaml"

---

#! jobs/vm-scalability.yaml
suite: vm-scalability
testcase: vm-scalability
category: benchmark
perf-profile: 
runtime: 300s
size: 
vm-scalability:
  test: small-allocs-mt
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
submit_id: 5fda587873ccaac954f5b50d
job_file: "/lkp/jobs/scheduled/lkp-csl-2ap4/vm-scalability-performance-300s-small-allocs-mt-ucode=0x5003003-monitor=0fe5055f-debian-10.4-x86_64-20200603.cgz-2f06f702925b512-20201217-51540-9kh8o7-0.yaml"
id: 1716335d754ada21464da501496cabf92590b5bf
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

#! include/vm-scalability
need_kconfig: CONFIG_BLK_DEV_LOOP

#! include/queue/cyclic
commit: 2f06f702925b512a95b95dca3855549c047eef58

#! include/testbox/lkp-csl-2ap4
need_kconfig_hw:
- CONFIG_IGB=y
- CONFIG_BLK_DEV_NVME
ucode: '0x5003003'
enqueue_time: 2020-12-17 02:56:56.240419549 +08:00
_id: 5fda587873ccaac954f5b50d
_rt: "/result/vm-scalability/performance-300s-small-allocs-mt-ucode=0x5003003-monitor=0fe5055f/lkp-csl-2ap4/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/2f06f702925b512a95b95dca3855549c047eef58"

#! schedule options
user: lkp
compiler: gcc-9
head_commit: 5a790e0217a4dbbe9c287b7b7f2d3f32d4df0812
base_commit: 2c85ebc57b3e1817b6ce1a6b703928e113a90442
branch: linux-devel/devel-hourly-2020121614
rootfs: debian-10.4-x86_64-20200603.cgz
monitor_sha: 0fe5055f
result_root: "/result/vm-scalability/performance-300s-small-allocs-mt-ucode=0x5003003-monitor=0fe5055f/lkp-csl-2ap4/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/2f06f702925b512a95b95dca3855549c047eef58/0"
scheduler_version: "/lkp/lkp/.src-20201216-155149"
LKP_SERVER: internal-lkp-server
arch: x86_64
max_uptime: 2100
initrd: "/osimage/debian/debian-10.4-x86_64-20200603.cgz"
bootloader_append:
- root=/dev/ram0
- user=lkp
- job=/lkp/jobs/scheduled/lkp-csl-2ap4/vm-scalability-performance-300s-small-allocs-mt-ucode=0x5003003-monitor=0fe5055f-debian-10.4-x86_64-20200603.cgz-2f06f702925b512-20201217-51540-9kh8o7-0.yaml
- ARCH=x86_64
- kconfig=x86_64-rhel-8.3
- branch=linux-devel/devel-hourly-2020121614
- commit=2f06f702925b512a95b95dca3855549c047eef58
- BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3/gcc-9/2f06f702925b512a95b95dca3855549c047eef58/vmlinuz-5.10.0-rc6-00077-g2f06f702925b
- acpi_rsdp=0x67f44014
- max_uptime=2100
- RESULT_ROOT=/result/vm-scalability/performance-300s-small-allocs-mt-ucode=0x5003003-monitor=0fe5055f/lkp-csl-2ap4/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/2f06f702925b512a95b95dca3855549c047eef58/0
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
modules_initrd: "/pkg/linux/x86_64-rhel-8.3/gcc-9/2f06f702925b512a95b95dca3855549c047eef58/modules.cgz"
bm_initrd: "/osimage/deps/debian-10.4-x86_64-20200603.cgz/run-ipconfig_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/lkp_20201211.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/rsync-rootfs_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/perf_20201126.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/perf-x86_64-fa02fcd94b0c-1_20201126.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/vm-scalability_20201110.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/vm-scalability-x86_64-1.0-0_20201110.cgz,/osimage/pkg/common/vm-scalability-x86_64.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/mpstat_20200714.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/sar-x86_64-34c92ae-1_20200702.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/hw_20200715.cgz"
ucode_initrd: "/osimage/ucode/intel-ucode-20201117.cgz"
lkp_initrd: "/osimage/user/lkp/lkp-x86_64.cgz"
site: inn

#! /lkp/lkp/.src-20201216-155149/include/site/inn
LKP_CGI_PORT: 80
LKP_CIFS_PORT: 139
oom-killer: 
watchdog: 

#! runtime status
last_kernel: 5.10.1-11352-g5a790e0217a4
repeat_to: 2
schedule_notify_address: 

#! user overrides
queue_at_least_once: 0
kernel: "/pkg/linux/x86_64-rhel-8.3/gcc-9/2f06f702925b512a95b95dca3855549c047eef58/vmlinuz-5.10.0-rc6-00077-g2f06f702925b"
dequeue_time: 2020-12-17 03:00:47.552748596 +08:00
job_state: finished
loadavg: 65.06 98.29 49.65 1/1293 13402
start_time: '1608145775'
end_time: '1608146085'
version: "/lkp/lkp/.src-20201216-155222:a579723e:720bd231a"

--ep0oHQY+/Gbo/zt0
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
 truncate -s 202462580736 /tmp/vm-scalability-tmp/vm-scalability.img
 mkfs.xfs -q /tmp/vm-scalability-tmp/vm-scalability.img
 mount -o loop /tmp/vm-scalability-tmp/vm-scalability.img /tmp/vm-scalability-tmp/vm-scalability
 ./case-small-allocs-mt
 ./usemem --runtime 300 -t 192 --readonly --unit 40960 22906492245
 umount /tmp/vm-scalability-tmp/vm-scalability
 rm /tmp/vm-scalability-tmp/vm-scalability.img
 umount /tmp/vm-scalability-tmp

--ep0oHQY+/Gbo/zt0--
