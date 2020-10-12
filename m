Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C95DD28AE33
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 08:20:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726342AbgJLGUg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 02:20:36 -0400
Received: from mga09.intel.com ([134.134.136.24]:16386 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725941AbgJLGUg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 02:20:36 -0400
IronPort-SDR: A0nc01uSo53w25xSLwxEuY+y7FKKSul9Eon5IingpximC/8suO1b+ZxLuP6gQ7pm/UHAnxTvE9
 uh8tmx9rjj/A==
X-IronPort-AV: E=McAfee;i="6000,8403,9771"; a="165808380"
X-IronPort-AV: E=Sophos;i="5.77,365,1596524400"; 
   d="scan'208";a="165808380"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2020 23:20:32 -0700
IronPort-SDR: J2c0soJrUW0apnPRGB7Ep16mYInscfW6CX4R+h9yc4MvbDrkXPFiNKxmWPW/h4KErftsGp02IP
 TFL2mXu7g40Q==
X-IronPort-AV: E=Sophos;i="5.77,365,1596524400"; 
   d="scan'208";a="462984594"
Received: from xingzhen-mobl.ccr.corp.intel.com (HELO [10.238.4.68]) ([10.238.4.68])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2020 23:20:28 -0700
Subject: Re: [LKP] [fs] b6509f6a8c: will-it-scale.per_thread_ops -12.6%
 regression
To:     kernel test robot <rong.a.chen@intel.com>,
        Mel Gorman <mgorman@techsingularity.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org
References: <20200706012029.GZ3874@shao2-debian>
From:   Xing Zhengjun <zhengjun.xing@linux.intel.com>
Message-ID: <6b301f34-f8fe-c626-e5e5-9af5c257c5c3@linux.intel.com>
Date:   Mon, 12 Oct 2020 14:20:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20200706012029.GZ3874@shao2-debian>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mel,

    It is a revert commit caused the regression, Do you have a plan to 
fix it? Thanks. I re-test it in v5.9-rc8, the regression still existed.

=========================================================================================
tbox_group/testcase/rootfs/kconfig/compiler/nr_task/mode/test/cpufreq_governor/ucode:
 
lkp-csl-2ap4/will-it-scale/debian-x86_64-20191114.cgz/x86_64-rhel-7.6/gcc-9/100%/thread/eventfd1/performance/0x5002f01

commit:
   v5.8-rc3
   b6509f6a8c4313c068c69785c001451415969e44
   v5.8
   v5.9-rc1
   v5.9-rc8

         v5.8-rc3 b6509f6a8c4313c068c69785c00 
v5.8                    v5.9-rc1                    v5.9-rc8
---------------- --------------------------- --------------------------- 
--------------------------- ---------------------------
          %stddev     %change         %stddev     %change 
%stddev     %change         %stddev     %change         %stddev
              \          |                \          |                \ 
         |                \          |                \
    1652352           -12.6%    1444002 ±  2%     -13.3%    1431865 
       -9.9%    1489323            -9.1%    1502580 
will-it-scale.per_thread_ops
  3.173e+08           -12.6%  2.772e+08 ±  2%     -13.3%  2.749e+08 
       -9.9%   2.86e+08            -9.1%  2.885e+08 
will-it-scale.workload




On 7/6/2020 9:20 AM, kernel test robot wrote:
> Greeting,
> 
> FYI, we noticed a -12.6% regression of will-it-scale.per_thread_ops due to commit:
> 
> 
> commit: b6509f6a8c4313c068c69785c001451415969e44 ("Revert "fs: Do not check if there is a fsnotify watcher on pseudo inodes"")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> 
> in testcase: will-it-scale
> on test machine: 192 threads Intel(R) Xeon(R) Platinum 9242 CPU @ 2.30GHz with 192G memory
> with following parameters:
> 
> 	nr_task: 100%
> 	mode: thread
> 	test: eventfd1
> 	cpufreq_governor: performance
> 	ucode: 0x5002f01
> 
> test-description: Will It Scale takes a testcase and runs it from 1 through to n parallel copies to see if the testcase will scale. It builds both a process and threads based test in order to see any differences between the two.
> test-url: https://github.com/antonblanchard/will-it-scale
> 
> In addition to that, the commit also has significant impact on the following tests:
> 
> +------------------+---------------------------------------------------------------------------+
> | testcase: change | will-it-scale: will-it-scale.per_process_ops -6.4% regression             |
> | test machine     | 192 threads Intel(R) Xeon(R) Platinum 9242 CPU @ 2.30GHz with 192G memory |
> | test parameters  | cpufreq_governor=performance                                              |
> |                  | mode=process                                                              |
> |                  | nr_task=100%                                                              |
> |                  | test=unix1                                                                |
> |                  | ucode=0x5002f01                                                           |
> +------------------+---------------------------------------------------------------------------+
> | testcase: change | will-it-scale: will-it-scale.per_thread_ops -2.3% regression              |
> | test machine     | 192 threads Intel(R) Xeon(R) Platinum 9242 CPU @ 2.30GHz with 192G memory |
> | test parameters  | cpufreq_governor=performance                                              |
> |                  | mode=thread                                                               |
> |                  | nr_task=100%                                                              |
> |                  | test=pipe1                                                                |
> |                  | ucode=0x5002f01                                                           |
> +------------------+---------------------------------------------------------------------------+
> 
> 
> If you fix the issue, kindly add following tag
> Reported-by: kernel test robot <rong.a.chen@intel.com>
> 
> 
> Details are as below:
> -------------------------------------------------------------------------------------------------->
> 
> 
> To reproduce:
> 
>          git clone https://github.com/intel/lkp-tests.git
>          cd lkp-tests
>          bin/lkp install job.yaml  # job file is attached in this email
>          bin/lkp run     job.yaml
> 
> =========================================================================================
> compiler/cpufreq_governor/kconfig/mode/nr_task/rootfs/tbox_group/test/testcase/ucode:
>    gcc-9/performance/x86_64-rhel-7.6/thread/100%/debian-x86_64-20191114.cgz/lkp-csl-2ap4/eventfd1/will-it-scale/0x5002f01
> 
> commit:
>    v5.8-rc3
>    b6509f6a8c ("Revert "fs: Do not check if there is a fsnotify watcher on pseudo inodes"")
> 
>          v5.8-rc3 b6509f6a8c4313c068c69785c00
> ---------------- ---------------------------
>           %stddev     %change         %stddev
>               \          |                \
>     1652352           -12.6%    1444002 ±  2%  will-it-scale.per_thread_ops
>   3.173e+08           -12.6%  2.772e+08 ±  2%  will-it-scale.workload
>       23.95            -3.1       20.90 ±  2%  mpstat.cpu.all.usr%
>       23.00           -12.0%      20.25 ±  4%  vmstat.cpu.us
>      578849 ±  4%      +8.6%     628428 ±  4%  sched_debug.cpu.max_idle_balance_cost.max
>        0.00 ±  9%     -14.4%       0.00 ± 13%  sched_debug.cpu.next_balance.stddev
>        2207 ± 24%     +34.7%       2973 ± 20%  numa-vmstat.node0.nr_mapped
>        6949 ± 22%     +43.7%       9984 ± 10%  numa-vmstat.node0.nr_slab_reclaimable
>        9739 ± 13%     -29.0%       6913 ± 12%  numa-vmstat.node1.nr_slab_reclaimable
>        7247 ± 13%     -28.4%       5190 ± 19%  slabinfo.eventpoll_pwq.active_objs
>        7247 ± 13%     -28.4%       5190 ± 19%  slabinfo.eventpoll_pwq.num_objs
>      960.00 ± 11%     -40.0%     576.00 ± 26%  slabinfo.kmalloc-rcl-128.active_objs
>      960.00 ± 11%     -40.0%     576.00 ± 26%  slabinfo.kmalloc-rcl-128.num_objs
>       27801 ± 22%     +43.7%      39940 ± 10%  numa-meminfo.node0.KReclaimable
>        8718 ± 25%     +35.0%      11773 ± 20%  numa-meminfo.node0.Mapped
>       27801 ± 22%     +43.7%      39940 ± 10%  numa-meminfo.node0.SReclaimable
>       38959 ± 13%     -29.0%      27656 ± 12%  numa-meminfo.node1.KReclaimable
>       38959 ± 13%     -29.0%      27656 ± 12%  numa-meminfo.node1.SReclaimable
>      107406 ±  2%     -13.6%      92844 ±  6%  numa-meminfo.node1.Slab
>        0.00            +1.1        1.09 ± 16%  perf-profile.calltrace.cycles-pp.fsnotify_parent.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
>        0.00            +1.3        1.26 ± 18%  perf-profile.calltrace.cycles-pp.fsnotify_parent.security_file_permission.vfs_read.ksys_read.do_syscall_64
>        0.00            +1.8        1.76 ± 21%  perf-profile.calltrace.cycles-pp.fsnotify.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
>        0.00            +3.7        3.70 ± 20%  perf-profile.calltrace.cycles-pp.fsnotify.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
>        0.00            +3.0        3.02 ± 17%  perf-profile.children.cycles-pp.fsnotify_parent
>        0.00            +5.5        5.55 ± 20%  perf-profile.children.cycles-pp.fsnotify
>        0.00            +2.7        2.66 ± 17%  perf-profile.self.cycles-pp.fsnotify_parent
>        0.00            +5.4        5.35 ± 20%  perf-profile.self.cycles-pp.fsnotify
>       10890 ± 21%     +53.7%      16738 ± 12%  interrupts.CPU168.CAL:Function_call_interrupts
>        4602 ±  5%     +22.7%       5649 ± 13%  interrupts.CPU169.CAL:Function_call_interrupts
>        4920 ± 13%     -21.3%       3874 ±  2%  interrupts.CPU170.CAL:Function_call_interrupts
>      463.80 ± 11%     -25.1%     347.50 ±  4%  interrupts.CPU170.RES:Rescheduling_interrupts
>        3619 ±  2%     +10.2%       3990 ±  9%  interrupts.CPU36.CAL:Function_call_interrupts
>        5768 ± 34%     +43.3%       8267 ±  2%  interrupts.CPU74.NMI:Non-maskable_interrupts
>        5768 ± 34%     +43.3%       8267 ±  2%  interrupts.CPU74.PMI:Performance_monitoring_interrupts
>        5769 ± 34%     +43.3%       8268 ±  2%  interrupts.CPU75.NMI:Non-maskable_interrupts
>        5769 ± 34%     +43.3%       8268 ±  2%  interrupts.CPU75.PMI:Performance_monitoring_interrupts
>        5769 ± 34%     +43.3%       8267 ±  2%  interrupts.CPU76.NMI:Non-maskable_interrupts
>        5769 ± 34%     +43.3%       8267 ±  2%  interrupts.CPU76.PMI:Performance_monitoring_interrupts
>        5768 ± 34%     +43.3%       8268 ±  2%  interrupts.CPU77.NMI:Non-maskable_interrupts
>        5768 ± 34%     +43.3%       8268 ±  2%  interrupts.CPU77.PMI:Performance_monitoring_interrupts
>        3602 ±  2%     +12.9%       4068 ± 13%  interrupts.CPU81.CAL:Function_call_interrupts
>        0.05 ± 32%    +121.5%       0.10 ± 39%  perf-stat.i.MPKI
>        1.06            -0.1        0.94        perf-stat.i.branch-miss-rate%
>   1.107e+09           -13.3%  9.596e+08 ±  2%  perf-stat.i.branch-misses
>      199835           -11.5%     176905 ±  2%  perf-stat.i.dTLB-store-misses
>   9.558e+10            +9.4%  1.046e+11 ±  2%  perf-stat.i.dTLB-stores
>   9.687e+08           -13.8%  8.345e+08 ±  2%  perf-stat.i.iTLB-load-misses
>      535.53           +20.3%     644.34        perf-stat.i.instructions-per-iTLB-miss
>        1.10 ± 12%     +79.6%       1.98 ±  2%  perf-stat.i.metric.K/sec
>        1.05            -0.1        0.92        perf-stat.overall.branch-miss-rate%
>        0.00 ± 13%      -0.0        0.00 ±  4%  perf-stat.overall.dTLB-load-miss-rate%
>        0.00            -0.0        0.00        perf-stat.overall.dTLB-store-miss-rate%
>      528.82           +20.8%     638.59        perf-stat.overall.instructions-per-iTLB-miss
>      487060           +20.3%     586095        perf-stat.overall.path-length
>   1.103e+09           -13.3%  9.564e+08 ±  2%  perf-stat.ps.branch-misses
>      199661           -11.5%     176727 ±  2%  perf-stat.ps.dTLB-store-misses
>   9.525e+10            +9.5%  1.043e+11 ±  2%  perf-stat.ps.dTLB-stores
>    9.67e+08           -13.9%   8.33e+08 ±  3%  perf-stat.ps.iTLB-load-misses
> 
> 
>                                                                                  
>                               will-it-scale.per_thread_ops
>                                                                                  
>     1.7e+06 +----------------------------------------------------------------+
>             |       .+.. .+.+..          .+..        .+                      |
>    1.65e+06 |.+ .+.+    +      +.+.  .+.+    +. .+.+.                        |
>             | +.                   +.          +                             |
>     1.6e+06 |-+                                                              |
>             |                                                                |
>    1.55e+06 |-+                                                              |
>             |                                                                |
>     1.5e+06 |-+                                                              |
>             |                      O    O                           O O O  O |
>    1.45e+06 |-O  O O O  O O    O O    O   O  O O O O  O O O  O O O           |
>             |               O                                                |
>     1.4e+06 |-+                                                              |
>             |                                                                |
>    1.35e+06 +----------------------------------------------------------------+
>                                                                                  
>                                                                                                                                                                  
>                                  will-it-scale.workload
>                                                                                  
>    3.3e+08 +-----------------------------------------------------------------+
>            |                                                                 |
>    3.2e+08 |.+   .+.+..+.+..+.+.+..   .+..+.+.    .+.+                       |
>            | +..+                  +.+        +..+                           |
>    3.1e+08 |-+                                                               |
>            |                                                                 |
>      3e+08 |-+                                                               |
>            |                                                                 |
>    2.9e+08 |-+                                                               |
>            |                                                                 |
>    2.8e+08 |-O  O O    O O    O O  O O O  O O O  O O    O O  O O O  O O O  O |
>            |        O       O                        O                       |
>    2.7e+08 |-+                                                               |
>            |                                                                 |
>    2.6e+08 +-----------------------------------------------------------------+
>                                                                                  
>                                                                                  
> [*] bisect-good sample
> [O] bisect-bad  sample
> 
> ***************************************************************************************************
> lkp-csl-2ap4: 192 threads Intel(R) Xeon(R) Platinum 9242 CPU @ 2.30GHz with 192G memory
> =========================================================================================
> compiler/cpufreq_governor/kconfig/mode/nr_task/rootfs/tbox_group/test/testcase/ucode:
>    gcc-9/performance/x86_64-rhel-7.6/process/100%/debian-x86_64-20191114.cgz/lkp-csl-2ap4/unix1/will-it-scale/0x5002f01
> 
> commit:
>    v5.8-rc3
>    b6509f6a8c ("Revert "fs: Do not check if there is a fsnotify watcher on pseudo inodes"")
> 
>          v5.8-rc3 b6509f6a8c4313c068c69785c00
> ---------------- ---------------------------
>           %stddev     %change         %stddev
>               \          |                \
>      720286            -6.4%     674507        will-it-scale.per_process_ops
>   1.383e+08            -6.4%  1.295e+08        will-it-scale.workload
>       97977            +1.4%      99342        proc-vmstat.nr_anon_pages
>        8.31 ± 41%     +48.5%      12.33 ±  3%  sched_debug.cpu.sched_goidle.min
>        1097 ±  8%     +19.8%       1315 ±  9%  slabinfo.task_group.active_objs
>        1097 ±  8%     +19.8%       1315 ±  9%  slabinfo.task_group.num_objs
>       13194 ± 25%     -29.6%       9295 ± 24%  softirqs.CPU124.RCU
>        9178 ±  8%      -7.8%       8467 ±  4%  softirqs.CPU48.RCU
>        1229 ± 68%    +156.3%       3151 ± 70%  interrupts.CPU0.CAL:Function_call_interrupts
>        8259           -37.6%       5157 ± 34%  interrupts.CPU163.NMI:Non-maskable_interrupts
>        8259           -37.6%       5157 ± 34%  interrupts.CPU163.PMI:Performance_monitoring_interrupts
>       15337 ± 81%    +146.4%      37788 ± 45%  numa-vmstat.node2.nr_active_anon
>       15187 ± 81%    +147.5%      37594 ± 45%  numa-vmstat.node2.nr_anon_pages
>       15337 ± 81%    +146.4%      37788 ± 45%  numa-vmstat.node2.nr_zone_active_anon
>      127540 ±  6%      -8.0%     117311        numa-vmstat.node2.numa_other
>       62308 ± 81%    +144.0%     152033 ± 45%  numa-meminfo.node2.Active
>       61336 ± 81%    +146.7%     151288 ± 45%  numa-meminfo.node2.Active(anon)
>       15647 ±195%    +497.8%      93536 ± 57%  numa-meminfo.node2.AnonHugePages
>       60733 ± 82%    +147.8%     150509 ± 45%  numa-meminfo.node2.AnonPages
>      803985 ±  8%     +10.5%     888495 ±  9%  numa-meminfo.node2.MemUsed
>        1.14            -0.1        1.07        perf-stat.i.branch-miss-rate%
>   1.223e+09            -6.3%  1.146e+09        perf-stat.i.branch-misses
>        0.99            -1.5%       0.98        perf-stat.i.cpi
>   1.619e+11            +1.4%  1.641e+11        perf-stat.i.dTLB-loads
>       1e+11            +4.0%   1.04e+11        perf-stat.i.dTLB-stores
>    1.06e+09            -7.8%  9.779e+08        perf-stat.i.iTLB-load-misses
>   5.531e+11            +1.3%  5.603e+11        perf-stat.i.instructions
>      527.69            +9.7%     578.78        perf-stat.i.instructions-per-iTLB-miss
>        1.01            +1.4%       1.02        perf-stat.i.ipc
>        1931            +1.4%       1958        perf-stat.i.metric.M/sec
>        1.12            -0.1        1.06        perf-stat.overall.branch-miss-rate%
>        0.99            -1.4%       0.97        perf-stat.overall.cpi
>        0.00            -0.0        0.00        perf-stat.overall.dTLB-store-miss-rate%
>      521.71            +9.8%     572.92        perf-stat.overall.instructions-per-iTLB-miss
>        1.01            +1.4%       1.03        perf-stat.overall.ipc
>     1206072            +8.1%    1303735        perf-stat.overall.path-length
>   1.218e+09            -6.3%  1.142e+09        perf-stat.ps.branch-misses
>   1.613e+11            +1.4%  1.635e+11        perf-stat.ps.dTLB-loads
>    9.97e+10            +4.0%  1.036e+11        perf-stat.ps.dTLB-stores
>   1.057e+09            -7.8%  9.747e+08        perf-stat.ps.iTLB-load-misses
>   5.512e+11            +1.3%  5.584e+11        perf-stat.ps.instructions
>   1.668e+14            +1.2%  1.688e+14        perf-stat.total.instructions
>       38.39            -2.2       36.14        perf-profile.calltrace.cycles-pp.new_sync_write.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
>       36.80            -2.1       34.66        perf-profile.calltrace.cycles-pp.sock_write_iter.new_sync_write.vfs_write.ksys_write.do_syscall_64
>       34.46            -2.0       32.44        perf-profile.calltrace.cycles-pp.sock_sendmsg.sock_write_iter.new_sync_write.vfs_write.ksys_write
>       33.29            -1.8       31.47        perf-profile.calltrace.cycles-pp.new_sync_read.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
>       30.96            -1.8       29.19        perf-profile.calltrace.cycles-pp.unix_stream_sendmsg.sock_sendmsg.sock_write_iter.new_sync_write.vfs_write
>       31.72            -1.7       30.05        perf-profile.calltrace.cycles-pp.sock_read_iter.new_sync_read.vfs_read.ksys_read.do_syscall_64
>       25.95            -1.5       24.46        perf-profile.calltrace.cycles-pp.unix_stream_recvmsg.sock_read_iter.new_sync_read.vfs_read.ksys_read
>       53.97            -1.5       52.49        perf-profile.calltrace.cycles-pp.write
>       24.74            -1.4       23.30        perf-profile.calltrace.cycles-pp.unix_stream_read_generic.unix_stream_recvmsg.sock_read_iter.new_sync_read.vfs_read
>       47.12            -1.0       46.10        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.write
>       46.34            -1.0       45.38        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
>       44.29            -0.9       43.43        perf-profile.calltrace.cycles-pp.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
>       42.43            -0.8       41.64        perf-profile.calltrace.cycles-pp.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
>       13.05            -0.8       12.28        perf-profile.calltrace.cycles-pp.sock_alloc_send_pskb.unix_stream_sendmsg.sock_sendmsg.sock_write_iter.new_sync_write
>       11.31            -0.7       10.65        perf-profile.calltrace.cycles-pp.alloc_skb_with_frags.sock_alloc_send_pskb.unix_stream_sendmsg.sock_sendmsg.sock_write_iter
>       10.31            -0.6        9.71        perf-profile.calltrace.cycles-pp.__alloc_skb.alloc_skb_with_frags.sock_alloc_send_pskb.unix_stream_sendmsg.sock_sendmsg
>        8.93            -0.5        8.39        perf-profile.calltrace.cycles-pp.unix_stream_read_actor.unix_stream_read_generic.unix_stream_recvmsg.sock_read_iter.new_sync_read
>        8.64            -0.5        8.14        perf-profile.calltrace.cycles-pp.skb_copy_datagram_iter.unix_stream_read_actor.unix_stream_read_generic.unix_stream_recvmsg.sock_read_iter
>        8.31            -0.5        7.85        perf-profile.calltrace.cycles-pp.__skb_datagram_iter.skb_copy_datagram_iter.unix_stream_read_actor.unix_stream_read_generic.unix_stream_recvmsg
>        7.91            -0.5        7.45        perf-profile.calltrace.cycles-pp.skb_copy_datagram_from_iter.unix_stream_sendmsg.sock_sendmsg.sock_write_iter.new_sync_write
>        6.55            -0.4        6.19        perf-profile.calltrace.cycles-pp.consume_skb.unix_stream_read_generic.unix_stream_recvmsg.sock_read_iter.new_sync_read
>        0.54 ±  2%      -0.3        0.25 ±100%  perf-profile.calltrace.cycles-pp.___might_sleep.__might_fault._copy_from_iter.skb_copy_datagram_from_iter.unix_stream_sendmsg
>        3.81            -0.2        3.58        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64.write
>        3.98            -0.2        3.75        perf-profile.calltrace.cycles-pp.__kmalloc_reserve.__alloc_skb.alloc_skb_with_frags.sock_alloc_send_pskb.unix_stream_sendmsg
>        3.63            -0.2        3.41        perf-profile.calltrace.cycles-pp._copy_from_iter.skb_copy_datagram_from_iter.unix_stream_sendmsg.sock_sendmsg.sock_write_iter
>        3.88            -0.2        3.65        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64.read
>        3.82            -0.2        3.60        perf-profile.calltrace.cycles-pp.skb_release_all.consume_skb.unix_stream_read_generic.unix_stream_recvmsg.sock_read_iter
>        2.87            -0.2        2.66        perf-profile.calltrace.cycles-pp.security_socket_sendmsg.sock_sendmsg.sock_write_iter.new_sync_write.vfs_write
>        3.71            -0.2        3.50        perf-profile.calltrace.cycles-pp.skb_release_head_state.skb_release_all.consume_skb.unix_stream_read_generic.unix_stream_recvmsg
>        3.62            -0.2        3.42        perf-profile.calltrace.cycles-pp._copy_to_iter.__skb_datagram_iter.skb_copy_datagram_iter.unix_stream_read_actor.unix_stream_read_generic
>        3.91            -0.2        3.71        perf-profile.calltrace.cycles-pp.simple_copy_to_iter.__skb_datagram_iter.skb_copy_datagram_iter.unix_stream_read_actor.unix_stream_read_generic
>        2.95            -0.2        2.76        perf-profile.calltrace.cycles-pp.security_socket_recvmsg.sock_recvmsg.sock_read_iter.new_sync_read.vfs_read
>        3.50            -0.2        3.31        perf-profile.calltrace.cycles-pp.__check_object_size.skb_copy_datagram_from_iter.unix_stream_sendmsg.sock_sendmsg.sock_write_iter
>        3.33            -0.2        3.15        perf-profile.calltrace.cycles-pp.__kmalloc_node_track_caller.__kmalloc_reserve.__alloc_skb.alloc_skb_with_frags.sock_alloc_send_pskb
>        3.44            -0.2        3.25        perf-profile.calltrace.cycles-pp.unix_destruct_scm.skb_release_head_state.skb_release_all.consume_skb.unix_stream_read_generic
>        3.09            -0.2        2.91        perf-profile.calltrace.cycles-pp.kmem_cache_alloc_node.__alloc_skb.alloc_skb_with_frags.sock_alloc_send_pskb.unix_stream_sendmsg
>        3.65            -0.2        3.47        perf-profile.calltrace.cycles-pp.__check_object_size.simple_copy_to_iter.__skb_datagram_iter.skb_copy_datagram_iter.unix_stream_read_actor
>        2.38            -0.2        2.21        perf-profile.calltrace.cycles-pp.security_file_permission.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
>        2.08            -0.1        1.94        perf-profile.calltrace.cycles-pp.aa_sk_perm.security_socket_sendmsg.sock_sendmsg.sock_write_iter.new_sync_write
>        2.63            -0.1        2.50        perf-profile.calltrace.cycles-pp.sock_wfree.unix_destruct_scm.skb_release_head_state.skb_release_all.consume_skb
>        3.44            -0.1        3.31        perf-profile.calltrace.cycles-pp.sock_recvmsg.sock_read_iter.new_sync_read.vfs_read.ksys_read
>        1.71            -0.1        1.59        perf-profile.calltrace.cycles-pp.common_file_perm.security_file_permission.vfs_read.ksys_read.do_syscall_64
>        1.69            -0.1        1.58        perf-profile.calltrace.cycles-pp.common_file_perm.security_file_permission.vfs_write.ksys_write.do_syscall_64
>        1.96            -0.1        1.85        perf-profile.calltrace.cycles-pp.aa_sk_perm.security_socket_recvmsg.sock_recvmsg.sock_read_iter.new_sync_read
>        1.44            -0.1        1.34        perf-profile.calltrace.cycles-pp.wait_for_unix_gc.unix_stream_sendmsg.sock_sendmsg.sock_write_iter.new_sync_write
>        1.57            -0.1        1.48        perf-profile.calltrace.cycles-pp.copyin._copy_from_iter.skb_copy_datagram_from_iter.unix_stream_sendmsg.sock_sendmsg
>        1.47            -0.1        1.39        perf-profile.calltrace.cycles-pp.copyout._copy_to_iter.__skb_datagram_iter.skb_copy_datagram_iter.unix_stream_read_actor
>        1.20            -0.1        1.13        perf-profile.calltrace.cycles-pp.sock_def_readable.unix_stream_sendmsg.sock_sendmsg.sock_write_iter.new_sync_write
>        0.70            -0.1        0.63 ±  4%  perf-profile.calltrace.cycles-pp.__might_sleep.kmem_cache_alloc_node.__alloc_skb.alloc_skb_with_frags.sock_alloc_send_pskb
>        1.10 ±  2%      -0.1        1.03 ±  2%  perf-profile.calltrace.cycles-pp.__fdget_pos.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
>        0.98            -0.1        0.91        perf-profile.calltrace.cycles-pp.skb_set_owner_w.sock_alloc_send_pskb.unix_stream_sendmsg.sock_sendmsg.sock_write_iter
>        1.01 ±  2%      -0.1        0.94 ±  3%  perf-profile.calltrace.cycles-pp.__fget_light.__fdget_pos.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
>        1.01            -0.1        0.94        perf-profile.calltrace.cycles-pp.__might_fault._copy_from_iter.skb_copy_datagram_from_iter.unix_stream_sendmsg.sock_sendmsg
>        1.13            -0.1        1.07        perf-profile.calltrace.cycles-pp.unix_write_space.sock_wfree.unix_destruct_scm.skb_release_head_state.skb_release_all
>        1.05            -0.1        0.99 ±  3%  perf-profile.calltrace.cycles-pp.__ksize.__alloc_skb.alloc_skb_with_frags.sock_alloc_send_pskb.unix_stream_sendmsg
>        0.96            -0.1        0.91        perf-profile.calltrace.cycles-pp._raw_spin_unlock_irqrestore.unix_stream_read_generic.unix_stream_recvmsg.sock_read_iter.new_sync_read
>        0.96            -0.1        0.90        perf-profile.calltrace.cycles-pp._raw_spin_unlock_irqrestore.unix_stream_sendmsg.sock_sendmsg.sock_write_iter.new_sync_write
>        0.98            -0.1        0.93        perf-profile.calltrace.cycles-pp.syscall_return_via_sysret.write
>        1.04            -0.1        0.98        perf-profile.calltrace.cycles-pp.skb_unlink.unix_stream_read_generic.unix_stream_recvmsg.sock_read_iter.new_sync_read
>        1.00            -0.1        0.94        perf-profile.calltrace.cycles-pp.syscall_return_via_sysret.read
>        0.80            -0.1        0.75        perf-profile.calltrace.cycles-pp._raw_spin_lock.unix_stream_read_generic.unix_stream_recvmsg.sock_read_iter.new_sync_read
>        1.02            -0.0        0.97        perf-profile.calltrace.cycles-pp.skb_queue_tail.unix_stream_sendmsg.sock_sendmsg.sock_write_iter.new_sync_write
>        0.85            -0.0        0.80        perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.skb_unlink.unix_stream_read_generic.unix_stream_recvmsg.sock_read_iter
>        0.68 ±  2%      -0.0        0.64        perf-profile.calltrace.cycles-pp.__prepare_exit_to_usermode.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
>        0.71            -0.0        0.67        perf-profile.calltrace.cycles-pp.___might_sleep.__kmalloc_node_track_caller.__kmalloc_reserve.__alloc_skb.alloc_skb_with_frags
>        0.70 ±  2%      -0.0        0.66 ±  2%  perf-profile.calltrace.cycles-pp.copy_user_generic_unrolled.copyin._copy_from_iter.skb_copy_datagram_from_iter.unix_stream_sendmsg
>        0.85            -0.0        0.81        perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.skb_queue_tail.unix_stream_sendmsg.sock_sendmsg.sock_write_iter
>        0.56            -0.0        0.52 ±  2%  perf-profile.calltrace.cycles-pp.apparmor_socket_recvmsg.security_socket_recvmsg.sock_recvmsg.sock_read_iter.new_sync_read
>        0.57            -0.0        0.54        perf-profile.calltrace.cycles-pp.___might_sleep.wait_for_unix_gc.unix_stream_sendmsg.sock_sendmsg.sock_write_iter
>        0.68            -0.0        0.64 ±  2%  perf-profile.calltrace.cycles-pp.copy_user_generic_unrolled.copyout._copy_to_iter.__skb_datagram_iter.skb_copy_datagram_iter
>        0.57            -0.0        0.54        perf-profile.calltrace.cycles-pp.__might_sleep.__kmalloc_node_track_caller.__kmalloc_reserve.__alloc_skb.alloc_skb_with_frags
>        1.68            -0.0        1.64        perf-profile.calltrace.cycles-pp.mutex_lock.unix_stream_read_generic.unix_stream_recvmsg.sock_read_iter.new_sync_read
>        0.65            -0.0        0.62        perf-profile.calltrace.cycles-pp.mutex_unlock.unix_stream_read_generic.unix_stream_recvmsg.sock_read_iter.new_sync_read
>        0.00            +0.6        0.57        perf-profile.calltrace.cycles-pp.fsnotify_parent.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
>        0.00            +0.6        0.62        perf-profile.calltrace.cycles-pp.fsnotify_parent.security_file_permission.vfs_read.ksys_read.do_syscall_64
>        0.00            +0.6        0.64        perf-profile.calltrace.cycles-pp.fsnotify_parent.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
>        2.50            +0.7        3.20        perf-profile.calltrace.cycles-pp.security_file_permission.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
>        0.00            +0.9        0.93        perf-profile.calltrace.cycles-pp.fsnotify.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
>       48.49            +1.3       49.77        perf-profile.calltrace.cycles-pp.read
>       41.56            +1.7       43.30        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.read
>       40.78            +1.8       42.56        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
>       38.81            +1.9       40.68        perf-profile.calltrace.cycles-pp.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
>       37.05            +1.9       38.94        perf-profile.calltrace.cycles-pp.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
>        0.00            +1.9        1.90        perf-profile.calltrace.cycles-pp.fsnotify.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
>       38.49            -2.2       36.24        perf-profile.children.cycles-pp.new_sync_write
>       36.86            -2.1       34.71        perf-profile.children.cycles-pp.sock_write_iter
>       34.57            -2.0       32.53        perf-profile.children.cycles-pp.sock_sendmsg
>       33.36            -1.8       31.55        perf-profile.children.cycles-pp.new_sync_read
>       31.28            -1.8       29.50        perf-profile.children.cycles-pp.unix_stream_sendmsg
>       31.77            -1.7       30.10        perf-profile.children.cycles-pp.sock_read_iter
>       26.00            -1.5       24.50        perf-profile.children.cycles-pp.unix_stream_recvmsg
>       54.00            -1.5       52.53        perf-profile.children.cycles-pp.write
>       24.99            -1.5       23.53        perf-profile.children.cycles-pp.unix_stream_read_generic
>       44.34            -0.9       43.48        perf-profile.children.cycles-pp.ksys_write
>       13.14            -0.8       12.36        perf-profile.children.cycles-pp.sock_alloc_send_pskb
>       42.57            -0.7       41.85        perf-profile.children.cycles-pp.vfs_write
>       11.37            -0.7       10.71        perf-profile.children.cycles-pp.alloc_skb_with_frags
>       10.51            -0.6        9.90        perf-profile.children.cycles-pp.__alloc_skb
>        9.00            -0.5        8.46        perf-profile.children.cycles-pp.unix_stream_read_actor
>        8.72            -0.5        8.21        perf-profile.children.cycles-pp.skb_copy_datagram_iter
>        8.00            -0.5        7.53        perf-profile.children.cycles-pp.skb_copy_datagram_from_iter
>        8.38            -0.5        7.91        perf-profile.children.cycles-pp.__skb_datagram_iter
>        7.43            -0.4        7.04        perf-profile.children.cycles-pp.__check_object_size
>        6.57            -0.4        6.21        perf-profile.children.cycles-pp.consume_skb
>        5.14            -0.3        4.83        perf-profile.children.cycles-pp.entry_SYSCALL_64
>        4.60            -0.3        4.32        perf-profile.children.cycles-pp.syscall_return_via_sysret
>        4.16            -0.3        3.89        perf-profile.children.cycles-pp.aa_sk_perm
>        4.22            -0.3        3.96        perf-profile.children.cycles-pp.___might_sleep
>        3.50            -0.2        3.26        perf-profile.children.cycles-pp.common_file_perm
>        4.07            -0.2        3.83        perf-profile.children.cycles-pp.__kmalloc_reserve
>        3.71            -0.2        3.48        perf-profile.children.cycles-pp._copy_from_iter
>        3.85            -0.2        3.63        perf-profile.children.cycles-pp.skb_release_all
>        2.95            -0.2        2.73        perf-profile.children.cycles-pp.__might_sleep
>        2.91            -0.2        2.70        perf-profile.children.cycles-pp.security_socket_sendmsg
>        3.72            -0.2        3.51        perf-profile.children.cycles-pp._copy_to_iter
>        3.76            -0.2        3.55        perf-profile.children.cycles-pp.skb_release_head_state
>        3.01            -0.2        2.81        perf-profile.children.cycles-pp.security_socket_recvmsg
>        3.54            -0.2        3.33        perf-profile.children.cycles-pp.__kmalloc_node_track_caller
>        3.97            -0.2        3.77        perf-profile.children.cycles-pp.simple_copy_to_iter
>        3.28            -0.2        3.09        perf-profile.children.cycles-pp.kmem_cache_alloc_node
>        3.54            -0.2        3.35        perf-profile.children.cycles-pp.unix_destruct_scm
>        2.36 ±  2%      -0.2        2.21 ±  2%  perf-profile.children.cycles-pp.__fdget_pos
>        2.64            -0.1        2.50        perf-profile.children.cycles-pp.sock_wfree
>        3.50            -0.1        3.37        perf-profile.children.cycles-pp.sock_recvmsg
>        2.01 ±  2%      -0.1        1.88 ±  3%  perf-profile.children.cycles-pp.__fget_light
>        2.10 ±  2%      -0.1        1.97 ±  2%  perf-profile.children.cycles-pp.__might_fault
>        1.97            -0.1        1.85        perf-profile.children.cycles-pp._raw_spin_unlock_irqrestore
>        1.54            -0.1        1.44        perf-profile.children.cycles-pp.wait_for_unix_gc
>        1.95            -0.1        1.85        perf-profile.children.cycles-pp._raw_spin_lock_irqsave
>        1.43            -0.1        1.34        perf-profile.children.cycles-pp._cond_resched
>        1.60            -0.1        1.51        perf-profile.children.cycles-pp.copyin
>        1.52            -0.1        1.43        perf-profile.children.cycles-pp.__prepare_exit_to_usermode
>        1.67 ±  3%      -0.1        1.58 ±  2%  perf-profile.children.cycles-pp._raw_spin_lock
>        1.64            -0.1        1.55        perf-profile.children.cycles-pp.copy_user_generic_unrolled
>        1.50            -0.1        1.42        perf-profile.children.cycles-pp.copyout
>        1.21            -0.1        1.13        perf-profile.children.cycles-pp.sock_def_readable
>        0.98            -0.1        0.91        perf-profile.children.cycles-pp.skb_set_owner_w
>        0.95            -0.1        0.89        perf-profile.children.cycles-pp.copy_user_enhanced_fast_string
>        1.05            -0.1        0.99 ±  2%  perf-profile.children.cycles-pp.__ksize
>        0.84            -0.1        0.78 ±  2%  perf-profile.children.cycles-pp.__x86_indirect_thunk_rax
>        1.13            -0.1        1.08        perf-profile.children.cycles-pp.unix_write_space
>        1.05            -0.1        0.99        perf-profile.children.cycles-pp.skb_unlink
>        0.74 ±  2%      -0.1        0.69        perf-profile.children.cycles-pp.apparmor_file_permission
>        1.02            -0.1        0.97        perf-profile.children.cycles-pp.skb_queue_tail
>        1.75            -0.0        1.70        perf-profile.children.cycles-pp.mutex_lock
>        0.56            -0.0        0.52 ±  2%  perf-profile.children.cycles-pp.apparmor_socket_recvmsg
>        0.71            -0.0        0.67        perf-profile.children.cycles-pp.rcu_all_qs
>        0.67            -0.0        0.63        perf-profile.children.cycles-pp.__syscall_return_slowpath
>        0.67            -0.0        0.64        perf-profile.children.cycles-pp.check_stack_object
>        0.44            -0.0        0.41        perf-profile.children.cycles-pp.apparmor_socket_sendmsg
>        0.67            -0.0        0.65        perf-profile.children.cycles-pp.mutex_unlock
>        0.30            -0.0        0.28 ±  2%  perf-profile.children.cycles-pp.put_pid
>        0.23            -0.0        0.21 ±  2%  perf-profile.children.cycles-pp.skb_release_data
>        0.43            +0.0        0.46        perf-profile.children.cycles-pp.apparmor_socket_getpeersec_dgram
>        4.96            +0.6        5.57        perf-profile.children.cycles-pp.security_file_permission
>       88.79            +0.7       89.51        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
>       87.30            +0.8       88.11        perf-profile.children.cycles-pp.do_syscall_64
>       48.55            +1.3       49.85        perf-profile.children.cycles-pp.read
>        0.00            +1.9        1.87        perf-profile.children.cycles-pp.fsnotify_parent
>       38.85            +1.9       40.72        perf-profile.children.cycles-pp.ksys_read
>       37.17            +2.0       39.17        perf-profile.children.cycles-pp.vfs_read
>        0.00            +2.9        2.90        perf-profile.children.cycles-pp.fsnotify
>        4.56            -0.3        4.28        perf-profile.self.cycles-pp.syscall_return_via_sysret
>        4.10            -0.2        3.85        perf-profile.self.cycles-pp.___might_sleep
>        2.96            -0.2        2.75        perf-profile.self.cycles-pp.unix_stream_read_generic
>        2.65            -0.2        2.46        perf-profile.self.cycles-pp.__might_sleep
>        2.94            -0.2        2.75        perf-profile.self.cycles-pp.unix_stream_sendmsg
>        2.85 ±  2%      -0.2        2.67        perf-profile.self.cycles-pp.common_file_perm
>        1.40 ±  4%      -0.2        1.22        perf-profile.self.cycles-pp.new_sync_read
>        2.32            -0.2        2.17        perf-profile.self.cycles-pp.aa_sk_perm
>        2.56            -0.1        2.41        perf-profile.self.cycles-pp.entry_SYSCALL_64
>        1.90 ±  2%      -0.1        1.77 ±  3%  perf-profile.self.cycles-pp.__fget_light
>        2.13            -0.1        2.00        perf-profile.self.cycles-pp.__alloc_skb
>        2.29            -0.1        2.17        perf-profile.self.cycles-pp.sock_write_iter
>        1.93            -0.1        1.81        perf-profile.self.cycles-pp._raw_spin_unlock_irqrestore
>        1.79            -0.1        1.67        perf-profile.self.cycles-pp.write
>        1.83            -0.1        1.72        perf-profile.self.cycles-pp.read
>        1.52            -0.1        1.42        perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
>        1.71            -0.1        1.61        perf-profile.self.cycles-pp.__kmalloc_node_track_caller
>        1.93            -0.1        1.84        perf-profile.self.cycles-pp._raw_spin_lock_irqsave
>        1.60 ±  3%      -0.1        1.52 ±  2%  perf-profile.self.cycles-pp._raw_spin_lock
>        1.81            -0.1        1.73        perf-profile.self.cycles-pp.kmem_cache_alloc_node
>        1.17            -0.1        1.09        perf-profile.self.cycles-pp.sock_def_readable
>        1.55            -0.1        1.47        perf-profile.self.cycles-pp.copy_user_generic_unrolled
>        1.25 ±  2%      -0.1        1.17 ±  2%  perf-profile.self.cycles-pp._copy_to_iter
>        0.61            -0.1        0.54        perf-profile.self.cycles-pp.ksys_write
>        1.44            -0.1        1.37        perf-profile.self.cycles-pp.sock_wfree
>        0.95            -0.1        0.88        perf-profile.self.cycles-pp.skb_set_owner_w
>        1.06            -0.1        0.99 ±  2%  perf-profile.self.cycles-pp._copy_from_iter
>        0.58 ±  5%      -0.1        0.52 ±  5%  perf-profile.self.cycles-pp.aa_file_perm
>        1.04            -0.1        0.97 ±  2%  perf-profile.self.cycles-pp.__ksize
>        1.10            -0.1        1.04        perf-profile.self.cycles-pp.unix_write_space
>        0.68 ±  2%      -0.1        0.62        perf-profile.self.cycles-pp.__skb_datagram_iter
>        0.93            -0.1        0.87        perf-profile.self.cycles-pp.copy_user_enhanced_fast_string
>        0.52            -0.1        0.47        perf-profile.self.cycles-pp.ksys_read
>        0.68 ±  2%      -0.1        0.63 ±  2%  perf-profile.self.cycles-pp.apparmor_file_permission
>        0.83            -0.0        0.78        perf-profile.self.cycles-pp.unix_destruct_scm
>        0.87            -0.0        0.82        perf-profile.self.cycles-pp.consume_skb
>        0.83            -0.0        0.79        perf-profile.self.cycles-pp.sock_alloc_send_pskb
>        0.71            -0.0        0.67        perf-profile.self.cycles-pp._cond_resched
>        0.82            -0.0        0.78        perf-profile.self.cycles-pp.alloc_skb_with_frags
>        0.29 ±  3%      -0.0        0.25        perf-profile.self.cycles-pp.unix_stream_read_actor
>        0.66            -0.0        0.62        perf-profile.self.cycles-pp.skb_copy_datagram_from_iter
>        0.53            -0.0        0.49 ±  2%  perf-profile.self.cycles-pp.apparmor_socket_recvmsg
>        0.64            -0.0        0.60        perf-profile.self.cycles-pp.__syscall_return_slowpath
>        0.60 ±  2%      -0.0        0.56 ±  4%  perf-profile.self.cycles-pp.__might_fault
>        0.50            -0.0        0.46        perf-profile.self.cycles-pp.__kmalloc_reserve
>        0.37            -0.0        0.34        perf-profile.self.cycles-pp.security_socket_recvmsg
>        2.25            -0.0        2.21        perf-profile.self.cycles-pp.sock_read_iter
>        0.54            -0.0        0.51        perf-profile.self.cycles-pp.rcu_all_qs
>        0.37 ±  5%      -0.0        0.34 ±  4%  perf-profile.self.cycles-pp.sock_sendmsg
>        0.43            -0.0        0.40        perf-profile.self.cycles-pp.__x86_indirect_thunk_rax
>        0.98            -0.0        0.95        perf-profile.self.cycles-pp.unix_stream_recvmsg
>        0.35            -0.0        0.32        perf-profile.self.cycles-pp.skb_copy_datagram_iter
>        0.41            -0.0        0.38        perf-profile.self.cycles-pp.apparmor_socket_sendmsg
>        0.56            -0.0        0.54        perf-profile.self.cycles-pp.check_stack_object
>        0.44            -0.0        0.41        perf-profile.self.cycles-pp.wait_for_unix_gc
>        0.29 ±  3%      -0.0        0.26 ±  2%  perf-profile.self.cycles-pp.security_socket_sendmsg
>        0.42            -0.0        0.40        perf-profile.self.cycles-pp.security_socket_getpeersec_dgram
>        0.63            -0.0        0.61        perf-profile.self.cycles-pp.mutex_unlock
>        0.40 ±  2%      -0.0        0.38        perf-profile.self.cycles-pp.__fdget_pos
>        0.31            -0.0        0.29        perf-profile.self.cycles-pp.copyin
>        0.23            -0.0        0.21 ±  2%  perf-profile.self.cycles-pp.skb_release_data
>        0.19            -0.0        0.17 ±  2%  perf-profile.self.cycles-pp.skb_release_head_state
>        0.24            -0.0        0.23        perf-profile.self.cycles-pp.copyout
>        0.21 ±  2%      -0.0        0.19 ±  2%  perf-profile.self.cycles-pp.simple_copy_to_iter
>        0.26            -0.0        0.25        perf-profile.self.cycles-pp.kmalloc_slab
>        0.17 ±  2%      +0.0        0.20 ±  2%  perf-profile.self.cycles-pp.__vfs_read
>        0.40            +0.0        0.43        perf-profile.self.cycles-pp.apparmor_socket_getpeersec_dgram
>        0.73            +0.0        0.77        perf-profile.self.cycles-pp.mutex_lock
>        0.51            +0.1        0.57        perf-profile.self.cycles-pp.sock_recvmsg
>        1.33            +0.2        1.57        perf-profile.self.cycles-pp.vfs_write
>        0.75 ±  6%      +0.4        1.10 ±  3%  perf-profile.self.cycles-pp.security_file_permission
>        0.97            +0.5        1.49 ±  2%  perf-profile.self.cycles-pp.vfs_read
>        0.00            +1.7        1.65        perf-profile.self.cycles-pp.fsnotify_parent
>        0.00            +2.8        2.80        perf-profile.self.cycles-pp.fsnotify
> 
> 
> 
> ***************************************************************************************************
> lkp-csl-2ap4: 192 threads Intel(R) Xeon(R) Platinum 9242 CPU @ 2.30GHz with 192G memory
> =========================================================================================
> compiler/cpufreq_governor/kconfig/mode/nr_task/rootfs/tbox_group/test/testcase/ucode:
>    gcc-9/performance/x86_64-rhel-7.6/thread/100%/debian-x86_64-20191114.cgz/lkp-csl-2ap4/pipe1/will-it-scale/0x5002f01
> 
> commit:
>    v5.8-rc3
>    b6509f6a8c ("Revert "fs: Do not check if there is a fsnotify watcher on pseudo inodes"")
> 
>          v5.8-rc3 b6509f6a8c4313c068c69785c00
> ---------------- ---------------------------
>           %stddev     %change         %stddev
>               \          |                \
>     1045643            -2.3%    1021331        will-it-scale.per_thread_ops
>   2.008e+08            -2.3%  1.961e+08        will-it-scale.workload
>    29490176 ±  3%      -9.8%   26607616 ±  3%  meminfo.DirectMap2M
>      202721 ±  4%     +11.5%     225943 ±  3%  numa-numastat.node2.local_node
>       25892 ± 28%     -75.5%       6341 ± 97%  numa-numastat.node2.other_node
>        1843            +8.9%       2007 ±  5%  numa-vmstat.node2.nr_mapped
>      130681 ±  5%     -14.7%     111436 ±  5%  numa-vmstat.node2.numa_other
>        9801 ±  5%     +16.0%      11370 ±  7%  sched_debug.cpu.ttwu_count.max
>        3052 ± 12%     +23.6%       3771 ± 11%  sched_debug.cpu.ttwu_local.max
>      136156            +1.4%     138002        proc-vmstat.nr_active_anon
>      109009            +1.1%     110229        proc-vmstat.nr_anon_pages
>      136156            +1.4%     138002        proc-vmstat.nr_zone_active_anon
>     1120468            +1.6%    1137854        proc-vmstat.pgalloc_normal
>      337.83 ± 61%     +53.8%     519.75 ± 47%  interrupts.39:PCI-MSI.524290-edge.eth0-TxRx-1
>      337.83 ± 61%     +53.8%     519.75 ± 47%  interrupts.CPU11.39:PCI-MSI.524290-edge.eth0-TxRx-1
>      303.33           +45.7%     442.00 ± 44%  interrupts.CPU148.RES:Rescheduling_interrupts
>        5509 ± 35%     +50.1%       8271        interrupts.CPU155.NMI:Non-maskable_interrupts
>        5509 ± 35%     +50.1%       8271        interrupts.CPU155.PMI:Performance_monitoring_interrupts
>        5509 ± 35%     +50.1%       8271        interrupts.CPU157.NMI:Non-maskable_interrupts
>        5509 ± 35%     +50.1%       8271        interrupts.CPU157.PMI:Performance_monitoring_interrupts
>        5509 ± 35%     +50.1%       8271        interrupts.CPU158.NMI:Non-maskable_interrupts
>        5509 ± 35%     +50.1%       8271        interrupts.CPU158.PMI:Performance_monitoring_interrupts
>       15130 ± 14%     -18.1%      12396 ±  8%  interrupts.CPU168.CAL:Function_call_interrupts
>        4137 ± 15%     +44.3%       5970 ± 26%  interrupts.CPU48.CAL:Function_call_interrupts
>      336.00 ±  6%     +60.0%     537.75 ± 31%  interrupts.CPU48.RES:Rescheduling_interrupts
>        0.75            -0.0        0.73        perf-stat.i.branch-miss-rate%
>   8.192e+08            -2.2%   8.01e+08        perf-stat.i.branch-misses
>        0.98            -1.4%       0.97        perf-stat.i.cpi
>     1.7e+11            +1.5%  1.725e+11        perf-stat.i.dTLB-loads
>   1.055e+11            +2.7%  1.084e+11        perf-stat.i.dTLB-stores
>   7.304e+08            -2.5%  7.123e+08        perf-stat.i.iTLB-load-misses
>     5.6e+11            +1.6%  5.688e+11        perf-stat.i.instructions
>      775.04            +4.2%     807.76        perf-stat.i.instructions-per-iTLB-miss
>        1.02            +1.5%       1.04        perf-stat.i.ipc
>        2015            +1.5%       2046        perf-stat.i.metric.M/sec
>        0.73            -0.0        0.72        perf-stat.overall.branch-miss-rate%
>        0.98            -1.5%       0.96        perf-stat.overall.cpi
>        0.00            -0.0        0.00        perf-stat.overall.dTLB-store-miss-rate%
>      764.55            +4.1%     796.24        perf-stat.overall.instructions-per-iTLB-miss
>        1.02            +1.5%       1.04        perf-stat.overall.ipc
>      841233            +4.0%     874479        perf-stat.overall.path-length
>   8.164e+08            -2.2%  7.983e+08        perf-stat.ps.branch-misses
>   1.695e+11            +1.5%   1.72e+11        perf-stat.ps.dTLB-loads
>   1.052e+11            +2.7%   1.08e+11        perf-stat.ps.dTLB-stores
>   7.301e+08            -2.5%  7.119e+08        perf-stat.ps.iTLB-load-misses
>   5.582e+11            +1.6%  5.668e+11        perf-stat.ps.instructions
>   1.689e+14            +1.5%  1.715e+14        perf-stat.total.instructions
>       50.20            -1.4       48.82        perf-profile.calltrace.cycles-pp.__GI___libc_read
>       40.68            -1.2       39.52        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__GI___libc_read
>       39.53            -1.1       38.39        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__GI___libc_read
>       36.75            -1.1       35.70        perf-profile.calltrace.cycles-pp.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.__GI___libc_read
>       32.27            -0.9       31.36        perf-profile.calltrace.cycles-pp.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.__GI___libc_read
>       24.69            -0.6       24.14        perf-profile.calltrace.cycles-pp.new_sync_write.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
>       22.23            -0.5       21.72        perf-profile.calltrace.cycles-pp.pipe_write.new_sync_write.vfs_write.ksys_write.do_syscall_64
>       21.04            -0.5       20.55        perf-profile.calltrace.cycles-pp.new_sync_read.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
>       18.70            -0.4       18.27        perf-profile.calltrace.cycles-pp.pipe_read.new_sync_read.vfs_read.ksys_read.do_syscall_64
>        6.80            -0.1        6.65        perf-profile.calltrace.cycles-pp.copy_page_from_iter.pipe_write.new_sync_write.vfs_write.ksys_write
>        5.39            -0.1        5.26        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64.__GI___libc_write
>        2.96            -0.1        2.84 ±  2%  perf-profile.calltrace.cycles-pp.fsnotify.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
>        2.27            -0.1        2.15        perf-profile.calltrace.cycles-pp.copyin.copy_page_from_iter.pipe_write.new_sync_write.vfs_write
>        2.42            -0.1        2.31 ±  2%  perf-profile.calltrace.cycles-pp.copyout.copy_page_to_iter.pipe_read.new_sync_read.vfs_read
>        5.38            -0.1        5.28        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64.__GI___libc_read
>        2.61            -0.1        2.52        perf-profile.calltrace.cycles-pp.mutex_lock.pipe_read.new_sync_read.vfs_read.ksys_read
>        3.46            -0.1        3.38        perf-profile.calltrace.cycles-pp.__wake_up_common_lock.pipe_write.new_sync_write.vfs_write.ksys_write
>        2.62            -0.1        2.55        perf-profile.calltrace.cycles-pp.mutex_lock.pipe_write.new_sync_write.vfs_write.ksys_write
>        2.08            -0.1        2.02        perf-profile.calltrace.cycles-pp.__pthread_disable_asynccancel
>        0.99            -0.1        0.94        perf-profile.calltrace.cycles-pp.fput_many.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.__GI___libc_write
>        1.04            -0.0        1.00        perf-profile.calltrace.cycles-pp.__prepare_exit_to_usermode.do_syscall_64.entry_SYSCALL_64_after_hwframe.__GI___libc_write
>        0.97            -0.0        0.93 ±  2%  perf-profile.calltrace.cycles-pp.copy_user_generic_unrolled.copyin.copy_page_from_iter.pipe_write.new_sync_write
>        1.23            -0.0        1.19        perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.__wake_up_common_lock.pipe_write.new_sync_write.vfs_write
>        1.11            -0.0        1.08        perf-profile.calltrace.cycles-pp.copy_user_generic_unrolled.copyout.copy_page_to_iter.pipe_read.new_sync_read
>        1.20            -0.0        1.17        perf-profile.calltrace.cycles-pp._raw_spin_lock_irq.pipe_write.new_sync_write.vfs_write.ksys_write
>        1.01            -0.0        0.98        perf-profile.calltrace.cycles-pp.__prepare_exit_to_usermode.do_syscall_64.entry_SYSCALL_64_after_hwframe.__GI___libc_read
>        0.79            -0.0        0.76        perf-profile.calltrace.cycles-pp.___might_sleep.mutex_lock.pipe_read.new_sync_read.vfs_read
>        1.50            -0.0        1.47        perf-profile.calltrace.cycles-pp.__might_fault.copy_page_from_iter.pipe_write.new_sync_write.vfs_write
>        1.13            -0.0        1.11        perf-profile.calltrace.cycles-pp._raw_spin_lock_irq.pipe_read.new_sync_read.vfs_read.ksys_read
>        0.79            -0.0        0.77        perf-profile.calltrace.cycles-pp.___might_sleep.copy_page_from_iter.pipe_write.new_sync_write.vfs_write
>        0.72            -0.0        0.70        perf-profile.calltrace.cycles-pp.__sb_end_write.pipe_write.new_sync_write.vfs_write.ksys_write
>        0.99            -0.0        0.97        perf-profile.calltrace.cycles-pp.mutex_unlock.pipe_read.new_sync_read.vfs_read.ksys_read
>        0.00            +0.9        0.92        perf-profile.calltrace.cycles-pp.fsnotify_parent.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
>       49.09            +1.4       50.48        perf-profile.calltrace.cycles-pp.__GI___libc_write
>        0.00            +1.5        1.50 ±  5%  perf-profile.calltrace.cycles-pp.fsnotify.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
>       39.33            +1.6       40.95        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__GI___libc_write
>       38.18            +1.7       39.84        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__GI___libc_write
>       35.19            +1.8       37.00        perf-profile.calltrace.cycles-pp.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.__GI___libc_write
>       30.77            +1.8       32.61        perf-profile.calltrace.cycles-pp.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.__GI___libc_write
>       50.18            -1.4       48.80        perf-profile.children.cycles-pp.__GI___libc_read
>       36.87            -1.1       35.81        perf-profile.children.cycles-pp.ksys_read
>       32.66            -0.9       31.73        perf-profile.children.cycles-pp.vfs_read
>       24.84            -0.6       24.29        perf-profile.children.cycles-pp.new_sync_write
>       22.51            -0.5       22.00        perf-profile.children.cycles-pp.pipe_write
>       21.18            -0.5       20.69        perf-profile.children.cycles-pp.new_sync_read
>       18.94            -0.4       18.50        perf-profile.children.cycles-pp.pipe_read
>        5.44            -0.2        5.27        perf-profile.children.cycles-pp.mutex_lock
>        7.06            -0.2        6.90        perf-profile.children.cycles-pp.copy_page_from_iter
>        6.34            -0.2        6.19        perf-profile.children.cycles-pp.syscall_return_via_sysret
>        7.28            -0.1        7.13        perf-profile.children.cycles-pp.entry_SYSCALL_64
>        2.33            -0.1        2.21        perf-profile.children.cycles-pp.copyin
>        7.14            -0.1        7.03        perf-profile.children.cycles-pp.copy_page_to_iter
>        2.48            -0.1        2.36 ±  2%  perf-profile.children.cycles-pp.copyout
>        4.78            -0.1        4.67        perf-profile.children.cycles-pp.___might_sleep
>        2.48            -0.1        2.39        perf-profile.children.cycles-pp.copy_user_generic_unrolled
>        2.23            -0.1        2.14        perf-profile.children.cycles-pp.__prepare_exit_to_usermode
>        3.56            -0.1        3.48        perf-profile.children.cycles-pp.__wake_up_common_lock
>        2.69            -0.1        2.63        perf-profile.children.cycles-pp.__might_sleep
>        2.41            -0.1        2.35        perf-profile.children.cycles-pp._raw_spin_lock_irq
>        2.08            -0.1        2.02        perf-profile.children.cycles-pp.__pthread_disable_asynccancel
>        1.88            -0.1        1.82        perf-profile.children.cycles-pp.fput_many
>        1.40            -0.0        1.35        perf-profile.children.cycles-pp._raw_spin_lock_irqsave
>        0.34            -0.0        0.29        perf-profile.children.cycles-pp.fput
>        1.38            -0.0        1.34        perf-profile.children.cycles-pp.copy_user_enhanced_fast_string
>        0.24 ±  7%      -0.0        0.22        perf-profile.children.cycles-pp.tick_sched_handle
>        0.92            -0.0        0.90        perf-profile.children.cycles-pp.fpregs_assert_state_consistent
>        1.28            -0.0        1.26        perf-profile.children.cycles-pp._raw_spin_unlock_irqrestore
>        0.75            -0.0        0.73        perf-profile.children.cycles-pp.__sb_end_write
>       80.17            +0.5       80.63        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
>       77.95            +0.5       78.47        perf-profile.children.cycles-pp.do_syscall_64
>        1.98            +0.9        2.88        perf-profile.children.cycles-pp.fsnotify_parent
>        3.04            +1.4        4.42 ±  2%  perf-profile.children.cycles-pp.fsnotify
>       49.09            +1.4       50.48        perf-profile.children.cycles-pp.__GI___libc_write
>       35.45            +1.8       37.22        perf-profile.children.cycles-pp.ksys_write
>       30.96            +2.0       32.93        perf-profile.children.cycles-pp.vfs_write
>        6.28            -0.1        6.13        perf-profile.self.cycles-pp.syscall_return_via_sysret
>        4.68            -0.1        4.58        perf-profile.self.cycles-pp.___might_sleep
>        2.35            -0.1        2.26        perf-profile.self.cycles-pp.copy_user_generic_unrolled
>        2.26            -0.1        2.18        perf-profile.self.cycles-pp.mutex_lock
>        2.61            -0.1        2.54        perf-profile.self.cycles-pp.__GI___libc_write
>        3.09            -0.1        3.02        perf-profile.self.cycles-pp.pipe_write
>        2.57            -0.1        2.50        perf-profile.self.cycles-pp.__GI___libc_read
>        2.26            -0.1        2.19        perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
>        3.74            -0.1        3.68        perf-profile.self.cycles-pp.entry_SYSCALL_64
>        0.93            -0.1        0.87        perf-profile.self.cycles-pp.ksys_write
>        1.38            -0.1        1.32        perf-profile.self.cycles-pp.__prepare_exit_to_usermode
>        2.31            -0.1        2.25        perf-profile.self.cycles-pp._raw_spin_lock_irq
>        1.78            -0.1        1.72        perf-profile.self.cycles-pp.fput_many
>        1.99            -0.1        1.94        perf-profile.self.cycles-pp.__pthread_disable_asynccancel
>        2.37            -0.0        2.32        perf-profile.self.cycles-pp.__might_sleep
>        1.14            -0.0        1.10        perf-profile.self.cycles-pp.do_syscall_64
>        1.36            -0.0        1.31        perf-profile.self.cycles-pp._raw_spin_lock_irqsave
>        2.22            -0.0        2.18        perf-profile.self.cycles-pp.__pthread_enable_asynccancel
>        1.87            -0.0        1.83        perf-profile.self.cycles-pp.mutex_unlock
>        1.34            -0.0        1.31        perf-profile.self.cycles-pp.copy_user_enhanced_fast_string
>        0.91            -0.0        0.89        perf-profile.self.cycles-pp.file_update_time
>        0.85            -0.0        0.82        perf-profile.self.cycles-pp.fpregs_assert_state_consistent
>        0.44            -0.0        0.41 ±  2%  perf-profile.self.cycles-pp.touch_atime
>        0.73            -0.0        0.71        perf-profile.self.cycles-pp.__sb_end_write
>        1.23            -0.0        1.21        perf-profile.self.cycles-pp._raw_spin_unlock_irqrestore
>        0.21            -0.0        0.20        perf-profile.self.cycles-pp.kill_fasync
>        2.08 ±  2%      +0.4        2.49 ±  4%  perf-profile.self.cycles-pp.vfs_write
>        1.71            +0.8        2.51        perf-profile.self.cycles-pp.fsnotify_parent
>        2.94            +1.3        4.25 ±  2%  perf-profile.self.cycles-pp.fsnotify
> 
> 
> 
> 
> 
> Disclaimer:
> Results have been estimated based on internal Intel analysis and are provided
> for informational purposes only. Any difference in system hardware or software
> design or configuration may affect actual performance.
> 
> 
> Thanks,
> Rong Chen
> 
> 
> _______________________________________________
> LKP mailing list -- lkp@lists.01.org
> To unsubscribe send an email to lkp-leave@lists.01.org
> 

-- 
Zhengjun Xing
