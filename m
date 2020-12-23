Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94FC72E196C
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 08:40:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727245AbgLWHjB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 02:39:01 -0500
Received: from mga05.intel.com ([192.55.52.43]:51853 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726022AbgLWHjA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 02:39:00 -0500
IronPort-SDR: NIKaMq6ud0YXitqtwkEIpb2TXJdswGLOmw28v6Mwg2JXMIZRyVFdsMgRFqQ4YNcZM6UR/csInC
 CadIvckdN4jA==
X-IronPort-AV: E=McAfee;i="6000,8403,9843"; a="260710809"
X-IronPort-AV: E=Sophos;i="5.78,441,1599548400"; 
   d="scan'208";a="260710809"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2020 23:37:12 -0800
IronPort-SDR: Dt4D10myLuzx3k3dlA8JmqeM+SRBsxhVH723AKdR451yF1Pi65t5XI5nS6Q8mn+ZgFe5nL3qEe
 0+4U3PG/Z1vA==
X-IronPort-AV: E=Sophos;i="5.78,441,1599548400"; 
   d="scan'208";a="344936959"
Received: from xingzhen-mobl.ccr.corp.intel.com (HELO [10.238.5.96]) ([10.238.5.96])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2020 23:37:10 -0800
Subject: Re: [LKP] [locking/rwsem] 617f3ef951: unixbench.score -21.2%
 regression
To:     kernel test robot <oliver.sang@intel.com>,
        Waiman Long <longman@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Davidlohr Bueso <dbueso@suse.de>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com, zhengjun.xing@intel.com
References: <20201217013242.GA27932@xsang-OptiPlex-9020>
From:   Xing Zhengjun <zhengjun.xing@linux.intel.com>
Message-ID: <5edd2ba6-9e81-ff31-a086-9e44773a2c23@linux.intel.com>
Date:   Wed, 23 Dec 2020 15:37:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20201217013242.GA27932@xsang-OptiPlex-9020>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Waiman,

    Do you have time to look at this? Thanks.
    As you describe in commit: 617f3ef95177840c77f59c2aec1029d27d5547d6 
("locking/rwsem: Remove reader optimistic spinning"), The patch that 
disables reader optimistic spinning shows reduced performance at lightly 
loaded cases, so for this regression, Is it as expected?

On 12/17/2020 9:33 AM, kernel test robot wrote:
> 
> Greeting,
> 
> FYI, we noticed a -21.2% regression of unixbench.score due to commit:
> 
> 
> commit: 617f3ef95177840c77f59c2aec1029d27d5547d6 ("locking/rwsem: Remove reader optimistic spinning")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> 
> 
> in testcase: unixbench
> on test machine: 16 threads Intel(R) Xeon(R) E-2278G CPU @ 3.40GHz with 32G memory
> with following parameters:
> 
> 	runtime: 300s
> 	nr_task: 30%
> 	test: shell8
> 	cpufreq_governor: performance
> 	ucode: 0xde
> 
> test-description: UnixBench is the original BYTE UNIX benchmark suite aims to test performance of Unix-like system.
> test-url: https://github.com/kdlucas/byte-unixbench
> 
> 
> 
> If you fix the issue, kindly add following tag
> Reported-by: kernel test robot <oliver.sang@intel.com>
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
> compiler/cpufreq_governor/kconfig/nr_task/rootfs/runtime/tbox_group/test/testcase/ucode:
>    gcc-9/performance/x86_64-rhel-8.3/30%/debian-10.4-x86_64-20200603.cgz/300s/lkp-cfl-e1/shell8/unixbench/0xde
> 
> commit:
>    1a728dff85 ("locking/rwsem: Enable reader optimistic lock stealing")
>    617f3ef951 ("locking/rwsem: Remove reader optimistic spinning")
> 
> 1a728dff855a318b 617f3ef95177840c77f59c2aec1
> ---------------- ---------------------------
>         fail:runs  %reproduction    fail:runs
>             |             |             |
>           39:4         -992%            :4     perf-profile.calltrace.cycles-pp.error_entry
>           25:4         -635%            :4     perf-profile.children.cycles-pp.error_entry
>           %stddev     %change         %stddev
>               \          |                \
>       21807 ±  3%     -21.2%      17186        unixbench.score
>     1287072 ±  3%     -38.7%     788414        unixbench.time.involuntary_context_switches
>       37161 ±  4%     +31.3%      48798        unixbench.time.major_page_faults
>   1.047e+08 ±  3%     -21.1%   82610985        unixbench.time.minor_page_faults
>        1341           -27.1%     978.00        unixbench.time.percent_of_cpu_this_job_got
>      370.87           -33.3%     247.55        unixbench.time.system_time
>      490.05           -23.3%     376.03        unixbench.time.user_time
>     3083520 ±  3%     +59.7%    4924900        unixbench.time.voluntary_context_switches
>      824314 ±  3%     -21.2%     649654        unixbench.workload
>        0.03 ± 27%     -51.9%       0.02 ± 59%  perf-sched.sch_delay.avg.ms.schedule_timeout.rcu_gp_kthread.kthread.ret_from_fork
>      385.15 ±  2%     +62.5%     625.72        uptime.idle
>       17.03            -1.8%      16.73        boot-time.boot
>       11.01            -1.6%      10.83        boot-time.dhcp
>      214.12 ±  3%      -3.1%     207.49        boot-time.idle
>       13.72 ±  4%     +23.5       37.24        mpstat.cpu.all.idle%
>        1.06            -0.1        0.94        mpstat.cpu.all.irq%
>       49.32 ±  2%     -11.8       37.53        mpstat.cpu.all.sys%
>       35.24 ±  2%     -11.6       23.68        mpstat.cpu.all.usr%
>       15.50 ±  3%    +145.2%      38.00        vmstat.cpu.id
>       49.00 ±  2%     -22.4%      38.00        vmstat.cpu.sy
>       33.75 ±  2%     -33.3%      22.50 ±  2%  vmstat.cpu.us
>       21.75 ±  3%     -33.3%      14.50 ±  3%  vmstat.procs.r
>       97370 ±  3%     +56.4%     152258        vmstat.system.cs
>       37589            -2.1%      36804        vmstat.system.in
>       11861 ±  9%     -18.0%       9730        slabinfo.filp.active_objs
>       13242 ±  8%     -15.5%      11184        slabinfo.filp.num_objs
>       14731 ±  7%      -9.5%      13325 ±  5%  slabinfo.kmalloc-8.active_objs
>       14731 ±  7%      -9.5%      13325 ±  5%  slabinfo.kmalloc-8.num_objs
>        5545 ±  2%     -13.8%       4780 ±  4%  slabinfo.pid.active_objs
>        5563 ±  2%     -13.8%       4793 ±  4%  slabinfo.pid.num_objs
>        5822 ± 14%     -40.4%       3468 ±  5%  slabinfo.task_delay_info.active_objs
>        5825 ± 14%     -40.5%       3468 ±  5%  slabinfo.task_delay_info.num_objs
>    32104492 ±  3%    +303.3%  1.295e+08 ± 11%  cpuidle.C1.time
>      882330 ±  5%    +131.5%    2042656 ± 10%  cpuidle.C1.usage
>    21965263 ±  3%    +340.5%   96762398 ± 14%  cpuidle.C1E.time
>      442911 ±  2%    +211.3%    1378866 ± 14%  cpuidle.C1E.usage
>     6511399 ±  4%    +606.6%   46010023 ± 13%  cpuidle.C3.time
>       66498 ±  5%    +559.3%     438404 ±  9%  cpuidle.C3.usage
>      101453 ± 18%    +139.9%     243422 ±  7%  cpuidle.C6.usage
>    11612925 ± 66%    +228.1%   38105483 ± 21%  cpuidle.C8.time
>       12182 ± 65%    +220.7%      39070 ± 21%  cpuidle.C8.usage
>      173670 ± 30%    +166.5%     462831 ±  7%  cpuidle.POLL.time
>       17441 ± 18%    +195.6%      51559 ±  6%  cpuidle.POLL.usage
>       59652            +0.6%      60011        proc-vmstat.nr_inactive_anon
>        5840            +1.4%       5922        proc-vmstat.nr_kernel_stack
>        1404            +3.1%       1447        proc-vmstat.nr_page_table_pages
>       13255            -1.7%      13026        proc-vmstat.nr_slab_reclaimable
>       14861            -6.9%      13835 ±  4%  proc-vmstat.nr_slab_unreclaimable
>       59652            +0.6%      60011        proc-vmstat.nr_zone_inactive_anon
>    70705198 ±  3%     -21.1%   55762717        proc-vmstat.numa_hit
>    70705198 ±  3%     -21.1%   55762717        proc-vmstat.numa_local
>      116793 ±  3%     -32.1%      79354        proc-vmstat.pgactivate
>    74803470 ±  3%     -20.7%   59317396        proc-vmstat.pgalloc_normal
>   1.049e+08 ±  3%     -21.1%   82849276        proc-vmstat.pgfault
>    74776100 ±  3%     -20.7%   59288922        proc-vmstat.pgfree
>     5338118 ±  3%     -24.5%    4030373        proc-vmstat.pgreuse
>        3413 ±  2%     -19.6%       2745        proc-vmstat.thp_fault_alloc
>     1466090 ±  3%     -21.2%    1155570        proc-vmstat.unevictable_pgs_culled
>      382612 ± 60%     -66.4%     128559 ±  7%  sched_debug.cfs_rq:/.load.max
>      274.29 ± 53%     -48.2%     142.09 ± 15%  sched_debug.cfs_rq:/.load_avg.avg
>      452211           -25.5%     336912        sched_debug.cfs_rq:/.min_vruntime.avg
>      489002           -22.6%     378258 ±  2%  sched_debug.cfs_rq:/.min_vruntime.max
>      440439           -26.4%     324253        sched_debug.cfs_rq:/.min_vruntime.min
>      210358 ±  8%     -21.6%     164917 ±  9%  sched_debug.cpu.avg_idle.avg
>      666992 ±  9%     -14.4%     571102 ±  3%  sched_debug.cpu.avg_idle.max
>      183734 ±  2%     -10.3%     164859        sched_debug.cpu.avg_idle.stddev
>        0.54 ± 19%     -29.1%       0.38 ± 15%  sched_debug.cpu.clock.stddev
>      199240 ±  3%     +53.0%     304861        sched_debug.cpu.nr_switches.avg
>      215766 ±  3%     +48.7%     320802        sched_debug.cpu.nr_switches.max
>      186135 ±  3%     +55.3%     289040        sched_debug.cpu.nr_switches.min
>       82.12 ± 12%    +247.2%     285.12 ± 11%  sched_debug.cpu.nr_uninterruptible.max
>     -122.88          +312.6%    -507.00        sched_debug.cpu.nr_uninterruptible.min
>       51.87 ± 13%    +263.6%     188.58 ±  8%  sched_debug.cpu.nr_uninterruptible.stddev
>      242600 ±  5%     -33.6%     161055        softirqs.CPU0.RCU
>       15144 ±  2%     +14.4%      17328 ±  3%  softirqs.CPU0.SCHED
>       14371           +13.8%      16354 ±  3%  softirqs.CPU1.SCHED
>       14064 ±  2%     +10.1%      15480        softirqs.CPU10.SCHED
>      241990 ±  4%     -33.1%     161882        softirqs.CPU11.RCU
>       13889           +12.7%      15650        softirqs.CPU11.SCHED
>      239184 ±  7%     -33.4%     159310        softirqs.CPU12.RCU
>       13988 ±  3%     +12.3%      15711        softirqs.CPU13.SCHED
>       13744 ±  2%     +14.1%      15688 ±  2%  softirqs.CPU14.SCHED
>       14104           +12.8%      15912 ±  2%  softirqs.CPU2.SCHED
>      240729 ±  4%     -32.5%     162396        softirqs.CPU3.RCU
>       14143 ±  2%     +13.6%      16064 ±  3%  softirqs.CPU3.SCHED
>      240581 ±  5%     -31.9%     163890        softirqs.CPU4.RCU
>       13936           +10.5%      15402        softirqs.CPU5.SCHED
>       13761 ±  3%     +12.9%      15532        softirqs.CPU6.SCHED
>       14059           +11.8%      15724 ±  2%  softirqs.CPU7.SCHED
>      241270 ±  5%     -34.5%     157931 ±  2%  softirqs.CPU8.RCU
>       13695           +11.8%      15314 ±  2%  softirqs.CPU8.SCHED
>      225021           +12.1%     252248        softirqs.SCHED
>       14.09 ± 73%     -14.1        0.00        perf-profile.calltrace.cycles-pp.do_filp_open.do_sys_openat2.do_sys_open.do_syscall_64.entry_SYSCALL_64_after_hwframe
>       14.09 ± 73%     -14.1        0.00        perf-profile.calltrace.cycles-pp.path_openat.do_filp_open.do_sys_openat2.do_sys_open.do_syscall_64
>       10.52 ± 60%     -10.5        0.00        perf-profile.calltrace.cycles-pp.setlocale
>        9.13 ±104%      -9.1        0.00        perf-profile.calltrace.cycles-pp.free_pgtables.exit_mmap.mmput.do_exit.do_group_exit
>        8.43 ± 62%      -8.4        0.00        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__open64_nocancel.setlocale
>        8.43 ± 62%      -8.4        0.00        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__open64_nocancel.setlocale
>        8.43 ± 62%      -8.4        0.00        perf-profile.calltrace.cycles-pp.do_sys_open.do_syscall_64.entry_SYSCALL_64_after_hwframe.__open64_nocancel.setlocale
>        8.43 ± 62%      -8.4        0.00        perf-profile.calltrace.cycles-pp.do_sys_openat2.do_sys_open.do_syscall_64.entry_SYSCALL_64_after_hwframe.__open64_nocancel
>        8.43 ± 62%      -8.4        0.00        perf-profile.calltrace.cycles-pp.__open64_nocancel.setlocale
>        6.35 ±101%      -6.3        0.00        perf-profile.calltrace.cycles-pp.unlink_file_vma.free_pgtables.exit_mmap.mmput.do_exit
>        4.86 ±102%      -4.9        0.00        perf-profile.calltrace.cycles-pp.terminate_walk.path_openat.do_filp_open.do_sys_openat2.do_sys_open
>        6.35 ±101%      -3.6        2.78 ±173%  perf-profile.calltrace.cycles-pp.exit_mmap.mmput.do_exit.do_group_exit.__x64_sys_exit_group
>        6.35 ±101%      -3.6        2.78 ±173%  perf-profile.calltrace.cycles-pp.mmput.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
>        7.98 ± 60%      -3.0        5.00 ±173%  perf-profile.calltrace.cycles-pp.exit_to_user_mode_prepare.syscall_exit_to_user_mode.entry_SYSCALL_64_after_hwframe
>        7.98 ± 60%      -3.0        5.00 ±173%  perf-profile.calltrace.cycles-pp.arch_do_signal.exit_to_user_mode_prepare.syscall_exit_to_user_mode.entry_SYSCALL_64_after_hwframe
>        7.98 ± 60%      -3.0        5.00 ±173%  perf-profile.calltrace.cycles-pp.do_group_exit.get_signal.arch_do_signal.exit_to_user_mode_prepare.syscall_exit_to_user_mode
>        7.98 ± 60%      -3.0        5.00 ±173%  perf-profile.calltrace.cycles-pp.do_exit.do_group_exit.get_signal.arch_do_signal.exit_to_user_mode_prepare
>        7.98 ± 60%      -3.0        5.00 ±173%  perf-profile.calltrace.cycles-pp.exit_mmap.mmput.do_exit.do_group_exit.get_signal
>        7.98 ± 60%      -3.0        5.00 ±173%  perf-profile.calltrace.cycles-pp.get_signal.arch_do_signal.exit_to_user_mode_prepare.syscall_exit_to_user_mode.entry_SYSCALL_64_after_hwframe
>        7.98 ± 60%      -3.0        5.00 ±173%  perf-profile.calltrace.cycles-pp.mmput.do_exit.do_group_exit.get_signal.arch_do_signal
>        7.98 ± 60%      -3.0        5.00 ±173%  perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.entry_SYSCALL_64_after_hwframe
>        6.35 ±101%      -0.8        5.55 ±173%  perf-profile.calltrace.cycles-pp.__x64_sys_exit_group.do_syscall_64.entry_SYSCALL_64_after_hwframe
>        6.35 ±101%      -0.8        5.55 ±173%  perf-profile.calltrace.cycles-pp.do_group_exit.__x64_sys_exit_group.do_syscall_64.entry_SYSCALL_64_after_hwframe
>        6.35 ±101%      -0.8        5.55 ±173%  perf-profile.calltrace.cycles-pp.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64.entry_SYSCALL_64_after_hwframe
>       14.09 ± 73%     -14.1        0.00        perf-profile.children.cycles-pp.do_filp_open
>       14.09 ± 73%     -14.1        0.00        perf-profile.children.cycles-pp.do_sys_open
>       14.09 ± 73%     -14.1        0.00        perf-profile.children.cycles-pp.do_sys_openat2
>       14.09 ± 73%     -14.1        0.00        perf-profile.children.cycles-pp.path_openat
>       10.52 ± 60%     -10.5        0.00        perf-profile.children.cycles-pp.setlocale
>        9.13 ±104%      -9.1        0.00        perf-profile.children.cycles-pp.free_pgtables
>        8.43 ± 62%      -8.4        0.00        perf-profile.children.cycles-pp.__open64_nocancel
>        6.35 ±101%      -6.3        0.00        perf-profile.children.cycles-pp.sync_regs
>        6.35 ±101%      -6.3        0.00        perf-profile.children.cycles-pp.unlink_file_vma
>        4.86 ±102%      -4.9        0.00        perf-profile.children.cycles-pp.terminate_walk
>        7.98 ± 60%      -3.0        5.00 ±173%  perf-profile.children.cycles-pp.exit_to_user_mode_prepare
>        7.98 ± 60%      -3.0        5.00 ±173%  perf-profile.children.cycles-pp.arch_do_signal
>        7.98 ± 60%      -3.0        5.00 ±173%  perf-profile.children.cycles-pp.get_signal
>        7.98 ± 60%      -3.0        5.00 ±173%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode
>        6.35 ±101%      -0.8        5.55 ±173%  perf-profile.children.cycles-pp.__x64_sys_exit_group
>        5.65 ±106%      -0.7        5.00 ±173%  perf-profile.children.cycles-pp.__mod_memcg_lruvec_state
>        5.65 ±106%      -0.1        5.55 ±173%  perf-profile.children.cycles-pp.handle_mm_fault
>        6.35 ±101%      -6.3        0.00        perf-profile.self.cycles-pp.sync_regs
>       31246 ±  5%    +200.7%      93965        interrupts.CAL:Function_call_interrupts
>        2091 ± 11%    +179.5%       5844        interrupts.CPU0.CAL:Function_call_interrupts
>       26624 ±  2%     -20.9%      21057        interrupts.CPU0.RES:Rescheduling_interrupts
>      500.25 ±  7%    +378.2%       2392        interrupts.CPU0.TLB:TLB_shootdowns
>        1931 ±  4%    +201.7%       5827        interrupts.CPU1.CAL:Function_call_interrupts
>       26939 ±  4%     -22.2%      20957        interrupts.CPU1.RES:Rescheduling_interrupts
>      499.25 ±  5%    +374.8%       2370 ±  4%  interrupts.CPU1.TLB:TLB_shootdowns
>        1967 ±  6%    +195.8%       5820        interrupts.CPU10.CAL:Function_call_interrupts
>       26951 ±  2%     -19.9%      21594        interrupts.CPU10.RES:Rescheduling_interrupts
>      546.25          +336.4%       2384 ±  4%  interrupts.CPU10.TLB:TLB_shootdowns
>        1927 ±  3%    +211.0%       5994        interrupts.CPU11.CAL:Function_call_interrupts
>       26619 ±  2%     -18.7%      21630        interrupts.CPU11.RES:Rescheduling_interrupts
>      514.25 ±  6%    +361.8%       2374 ±  2%  interrupts.CPU11.TLB:TLB_shootdowns
>        1887 ±  9%    +206.9%       5791 ±  4%  interrupts.CPU12.CAL:Function_call_interrupts
>       26377 ±  4%     -19.5%      21237 ±  2%  interrupts.CPU12.RES:Rescheduling_interrupts
>      496.00 ±  3%    +372.8%       2345 ±  2%  interrupts.CPU12.TLB:TLB_shootdowns
>        1912 ±  7%    +208.6%       5899 ±  2%  interrupts.CPU13.CAL:Function_call_interrupts
>       27187 ±  4%     -20.1%      21734 ±  2%  interrupts.CPU13.RES:Rescheduling_interrupts
>      500.50 ±  5%    +380.5%       2405 ±  3%  interrupts.CPU13.TLB:TLB_shootdowns
>        1891 ±  7%    +215.1%       5960 ±  2%  interrupts.CPU14.CAL:Function_call_interrupts
>       26046 ±  4%     -17.0%      21627        interrupts.CPU14.RES:Rescheduling_interrupts
>      506.25 ±  9%    +367.9%       2368 ±  2%  interrupts.CPU14.TLB:TLB_shootdowns
>        1960 ±  4%    +195.8%       5798        interrupts.CPU15.CAL:Function_call_interrupts
>       26567 ±  4%     -19.7%      21342 ±  2%  interrupts.CPU15.RES:Rescheduling_interrupts
>      536.50 ±  3%    +350.6%       2417        interrupts.CPU15.TLB:TLB_shootdowns
>        2001 ±  4%    +190.3%       5811 ±  2%  interrupts.CPU2.CAL:Function_call_interrupts
>       27172 ±  3%     -21.5%      21338        interrupts.CPU2.RES:Rescheduling_interrupts
>      539.00 ±  4%    +332.7%       2332 ±  3%  interrupts.CPU2.TLB:TLB_shootdowns
>        1950 ±  6%    +198.1%       5814        interrupts.CPU3.CAL:Function_call_interrupts
>       26579 ±  2%     -19.2%      21479        interrupts.CPU3.RES:Rescheduling_interrupts
>      504.75 ±  8%    +369.0%       2367 ±  4%  interrupts.CPU3.TLB:TLB_shootdowns
>        1965 ± 10%    +199.8%       5891        interrupts.CPU4.CAL:Function_call_interrupts
>       26811 ±  3%     -19.8%      21512        interrupts.CPU4.RES:Rescheduling_interrupts
>      515.75 ±  5%    +358.1%       2362 ±  2%  interrupts.CPU4.TLB:TLB_shootdowns
>        1935 ±  7%    +206.3%       5926        interrupts.CPU5.CAL:Function_call_interrupts
>       26997 ±  3%     -20.4%      21486        interrupts.CPU5.RES:Rescheduling_interrupts
>      531.25 ±  3%    +348.6%       2383        interrupts.CPU5.TLB:TLB_shootdowns
>        1904 ±  5%    +214.0%       5979        interrupts.CPU6.CAL:Function_call_interrupts
>       26702 ±  4%     -20.1%      21341        interrupts.CPU6.RES:Rescheduling_interrupts
>      505.25 ±  3%    +354.6%       2296 ±  2%  interrupts.CPU6.TLB:TLB_shootdowns
>        1933 ±  4%    +205.3%       5901        interrupts.CPU7.CAL:Function_call_interrupts
>       26505 ±  3%     -19.6%      21302        interrupts.CPU7.RES:Rescheduling_interrupts
>      494.00 ±  4%    +371.1%       2327 ±  3%  interrupts.CPU7.TLB:TLB_shootdowns
>        2003 ±  5%    +190.5%       5818        interrupts.CPU8.CAL:Function_call_interrupts
>       26799 ±  3%     -20.2%      21376 ±  2%  interrupts.CPU8.RES:Rescheduling_interrupts
>      519.00 ±  4%    +364.7%       2411 ±  4%  interrupts.CPU8.TLB:TLB_shootdowns
>        1986 ± 10%    +196.5%       5888 ±  2%  interrupts.CPU9.CAL:Function_call_interrupts
>       26994 ±  3%     -20.6%      21439        interrupts.CPU9.RES:Rescheduling_interrupts
>      526.00 ±  6%    +351.8%       2376        interrupts.CPU9.TLB:TLB_shootdowns
>      427874 ±  3%     -20.0%     342458        interrupts.RES:Rescheduling_interrupts
>        8234 ±  2%    +360.4%      37914 ±  2%  interrupts.TLB:TLB_shootdowns
>       47.20            +6.4%      50.22        perf-stat.i.MPKI
>   9.902e+09 ±  3%     -19.6%  7.965e+09        perf-stat.i.branch-instructions
>        2.24            +0.1        2.32        perf-stat.i.branch-miss-rate%
>   2.143e+08 ±  3%     -16.4%  1.791e+08        perf-stat.i.branch-misses
>    99172014 ±  2%     -15.6%   83714922        perf-stat.i.cache-misses
>   2.363e+09 ±  3%     -14.4%  2.022e+09        perf-stat.i.cache-references
>      101957 ±  3%     +56.1%     159180        perf-stat.i.context-switches
>        1.20 ±  3%      -5.8%       1.13        perf-stat.i.cpi
>   5.571e+10           -23.7%  4.249e+10        perf-stat.i.cpu-cycles
>       15111 ±  3%    +116.2%      32667        perf-stat.i.cpu-migrations
>      610.84 ±  2%     -10.2%     548.56        perf-stat.i.cycles-between-cache-misses
>   1.234e+10 ±  3%     -19.7%  9.908e+09        perf-stat.i.dTLB-loads
>        0.05            +0.0        0.05        perf-stat.i.dTLB-store-miss-rate%
>     3568011 ±  3%     -14.8%    3038208        perf-stat.i.dTLB-store-misses
>   7.127e+09 ±  3%     -19.9%  5.706e+09        perf-stat.i.dTLB-stores
>       57.81            -2.0       55.78        perf-stat.i.iTLB-load-miss-rate%
>    10339942 ±  3%     -16.8%    8603048        perf-stat.i.iTLB-load-misses
>     7643641 ±  3%      -7.7%    7057126        perf-stat.i.iTLB-loads
>   4.833e+10 ±  3%     -19.6%  3.887e+10        perf-stat.i.instructions
>        5183            -1.9%       5085        perf-stat.i.instructions-per-iTLB-miss
>        0.85 ±  4%      +5.6%       0.90        perf-stat.i.ipc
>      577.76 ±  4%     +32.0%     762.53        perf-stat.i.major-faults
>        3.48           -23.7%       2.66        perf-stat.i.metric.GHz
>        0.55 ± 44%     -77.5%       0.12 ± 30%  perf-stat.i.metric.K/sec
>        1986 ±  3%     -19.3%       1602        perf-stat.i.metric.M/sec
>     1599403 ±  3%     -20.7%    1268462        perf-stat.i.minor-faults
>     5321084 ±  3%     -15.9%    4474662        perf-stat.i.node-loads
>    32016465 ±  3%     -17.1%   26551337        perf-stat.i.node-stores
>     1599980 ±  3%     -20.7%    1269225        perf-stat.i.page-faults
>       48.88            +6.4%      52.03        perf-stat.overall.MPKI
>        2.16            +0.1        2.25        perf-stat.overall.branch-miss-rate%
>        4.20            -0.1        4.14        perf-stat.overall.cache-miss-rate%
>        1.15 ±  4%      -5.3%       1.09        perf-stat.overall.cpi
>      562.37 ±  3%      -9.7%     507.65        perf-stat.overall.cycles-between-cache-misses
>        0.05            +0.0        0.05        perf-stat.overall.dTLB-store-miss-rate%
>       57.50            -2.6       54.94        perf-stat.overall.iTLB-load-miss-rate%
>        4674            -3.3%       4518        perf-stat.overall.instructions-per-iTLB-miss
>        0.87 ±  4%      +5.4%       0.91        perf-stat.overall.ipc
>   9.742e+09 ±  3%     -19.6%  7.836e+09        perf-stat.ps.branch-instructions
>   2.108e+08 ±  3%     -16.5%  1.762e+08        perf-stat.ps.branch-misses
>    97569500 ±  2%     -15.6%   82348192        perf-stat.ps.cache-misses
>   2.324e+09 ±  3%     -14.4%  1.989e+09        perf-stat.ps.cache-references
>      100305 ±  3%     +56.1%     156566        perf-stat.ps.context-switches
>   5.481e+10           -23.7%   4.18e+10        perf-stat.ps.cpu-cycles
>       14866 ±  3%    +116.1%      32130        perf-stat.ps.cpu-migrations
>   1.214e+10 ±  3%     -19.7%  9.746e+09        perf-stat.ps.dTLB-loads
>     3510146 ±  3%     -14.9%    2988346        perf-stat.ps.dTLB-store-misses
>   7.012e+09 ±  3%     -20.0%  5.612e+09        perf-stat.ps.dTLB-stores
>    10172369 ±  3%     -16.8%    8461956        perf-stat.ps.iTLB-load-misses
>     7519764 ±  3%      -7.7%    6941264        perf-stat.ps.iTLB-loads
>   4.755e+10 ±  3%     -19.6%  3.823e+10        perf-stat.ps.instructions
>      568.39 ±  4%     +32.0%     750.01        perf-stat.ps.major-faults
>     1573444 ±  3%     -20.7%    1247622        perf-stat.ps.minor-faults
>     5235200 ±  3%     -15.9%    4401366        perf-stat.ps.node-loads
>    31497428 ±  3%     -17.1%   26115335        perf-stat.ps.node-stores
>     1574012 ±  3%     -20.7%    1248372        perf-stat.ps.page-faults
>   3.111e+12 ±  3%     -20.5%  2.473e+12        perf-stat.total.instructions
> 
> 
>                                                                                  
>                               unixbench.time.user_time
>                                                                                  
>    500 +---------------------------------------------------------------------+
>        |.   +..+..+    +..+..+.+..+..+.+..+..+.+..+..+.+..+..+..+.+..+..+.+..|
>    480 |-+                                                                   |
>        |                                                                     |
>    460 |-+                                                                   |
>        |                                                                     |
>    440 |-+                                                                   |
>        |                                                                     |
>    420 |-+                                                                   |
>        |                                                                     |
>    400 |-+                                                                   |
>        |                                                                     |
>    380 |-+                                   O    O  O O                     |
>        |  O O  O  O O  O  O  O O  O  O O  O    O                             |
>    360 +---------------------------------------------------------------------+
>                                                                                  
>                                                                                                                                                                  
>                              unixbench.time.system_time
>                                                                                  
>    380 +---------------------------------------------------------------------+
>        |..+.+..+..+.+..+..+..+.+..+.   +.    +.+..+..+.+..+..+..+.+.    +.+..|
>    360 |-+                                                                   |
>        |                                                                     |
>    340 |-+                                                                   |
>        |                                                                     |
>    320 |-+                                                                   |
>        |                                                                     |
>    300 |-+                                                                   |
>        |                                                                     |
>    280 |-+                                                                   |
>        |                                                                     |
>    260 |-+                                O                                  |
>        |  O O  O  O O  O  O  O O  O  O O     O O  O  O O                     |
>    240 +---------------------------------------------------------------------+
>                                                                                  
>                                                                                                                                                                  
>                      unixbench.time.percent_of_cpu_this_job_got
>                                                                                  
>    1400 +--------------------------------------------------------------------+
>         |..+.+..+..+.+..    .+..  .+.+..+..+.+..+.+..+..+.+..+..+.           |
>    1350 |-+             +..+    +.                                +..+..+.+..|
>    1300 |-+                                                                  |
>         |                                                                    |
>    1250 |-+                                                                  |
>    1200 |-+                                                                  |
>         |                                                                    |
>    1150 |-+                                                                  |
>    1100 |-+                                                                  |
>         |                                                                    |
>    1050 |-+                                                                  |
>    1000 |-+                                                                  |
>         |  O O  O  O O  O  O O  O  O O  O  O O  O O  O  O                    |
>     950 +--------------------------------------------------------------------+
>                                                                                  
>                                                                                                                                                                  
>                             unixbench.time.minor_page_faults
>                                                                                  
>     1.1e+08 +----------------------------------------------------------------+
>             |..+.+..+.+..+.+..+.+..+.+    +    +..+.+..+.+..+.+    +    +..+.|
>    1.05e+08 |-+                       :   ::   :               :   ::   :    |
>             |                          : :  : :                 : :  : :     |
>       1e+08 |-+                        : :  : :                 : :  : :     |
>             |                           +    +                   +    +      |
>     9.5e+07 |-+                                                              |
>             |                                                                |
>       9e+07 |-+                                                              |
>             |                                                                |
>     8.5e+07 |-+                                                              |
>             |  O O  O O  O O  O O    O    O    O  O O  O O                   |
>       8e+07 |-+                                                              |
>             |                                                                |
>     7.5e+07 +----------------------------------------------------------------+
>                                                                                  
>                                                                                                                                                                  
>                         unixbench.time.voluntary_context_switches
>                                                                                  
>      5e+06 +-----------------------------------------------------------------+
>            |  O O  O O  O O  O O    O    O       O                           |
>            |                      O    O                                     |
>    4.5e+06 |-+                              O                                |
>            |                                                                 |
>            |                                                                 |
>      4e+06 |-+                                                               |
>            |                                                                 |
>    3.5e+06 |-+                                                               |
>            |                                                                 |
>            | .+.       .+.+..+.+..+.     +..   +.+..+.+..+.+..     +    +.+..|
>      3e+06 |.+  +..+.+.             +.. +    ..               +. .. + ..     |
>            |                           +    +                   +    +       |
>            |                                                                 |
>    2.5e+06 +-----------------------------------------------------------------+
>                                                                                  
>                                                                                                                                                                  
>                        unixbench.time.involuntary_context_switches
>                                                                                  
>    1.4e+06 +-----------------------------------------------------------------+
>            |..+.+..+.+..+.+..     +.+..  +..   +.+..+.+..+.+..+    +    +    |
>    1.3e+06 |-+                  ..      +    ..                + .. + .. + ..|
>            |                 +.+       +    +                   +    +    +  |
>    1.2e+06 |-+                                                               |
>            |                                                                 |
>    1.1e+06 |-+                                                               |
>            |                                                                 |
>      1e+06 |-+                                                               |
>            |                                                                 |
>     900000 |-+                                                               |
>            |                                                                 |
>     800000 |-+O O  O O  O O    O    O    O     O O  O O  O                   |
>            |                 O    O    O    O                                |
>     700000 +-----------------------------------------------------------------+
>                                                                                  
>                                                                                                                                                                  
>                                     unixbench.score
>                                                                                  
>    23000 +-------------------------------------------------------------------+
>          |..+.+..+.+..+..+.+..+..+.+    +     +.+..+.+..+..+.+     +    +.+..|
>    22000 |-+                        +  : :   :                :   : :  :     |
>    21000 |-+                         + :  :  :                 :  : :  :     |
>          |                            +   : :                  : :   ::      |
>    20000 |-+                               +                    +    +       |
>          |                                                                   |
>    19000 |-+                                                                 |
>          |                                                                   |
>    18000 |-+                                                                 |
>    17000 |-+O    O O  O  O O  O               O O  O O  O                    |
>          |    O                    O    O                                    |
>    16000 |-+                                                                 |
>          |                       O    O    O                                 |
>    15000 +-------------------------------------------------------------------+
>                                                                                  
>                                                                                                                                                                  
>                                   unixbench.workload
>                                                                                  
>    900000 +------------------------------------------------------------------+
>           |                                                                  |
>    850000 |..+.+..+.+..+.+..+..+.+..+    +    +..+.+..+.+..+..+    +    +.+..|
>           |                          :  + +  :                 :  + :  +     |
>    800000 |-+                        : +   + :                 : +  : +      |
>           |                           +     +                   +    +       |
>    750000 |-+                                                                |
>           |                                                                  |
>    700000 |-+                                                                |
>           |                                                                  |
>    650000 |-+O O  O O  O O  O  O    O    O    O  O O  O O                    |
>           |                                                                  |
>    600000 |-+                    O    O     O                                |
>           |                                                                  |
>    550000 +------------------------------------------------------------------+
>                                                                                  
>                                                                                  
> [*] bisect-good sample
> [O] bisect-bad  sample
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
> Oliver Sang
> 
> 
> _______________________________________________
> LKP mailing list -- lkp@lists.01.org
> To unsubscribe send an email to lkp-leave@lists.01.org
> 

-- 
Zhengjun Xing
