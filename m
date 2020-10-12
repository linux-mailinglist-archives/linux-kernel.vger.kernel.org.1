Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 096BC28AE9A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 08:57:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbgJLG5W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 02:57:22 -0400
Received: from mga09.intel.com ([134.134.136.24]:19337 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726680AbgJLG5O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 02:57:14 -0400
IronPort-SDR: rsHKpOazkhQCf5ZyLzYWuHG00/gC+q9TZXP5pMdNFrhqgPElR416NgB1teWj+EKpirhJbsehZe
 YYUU2YpNYthA==
X-IronPort-AV: E=McAfee;i="6000,8403,9771"; a="165811205"
X-IronPort-AV: E=Sophos;i="5.77,366,1596524400"; 
   d="scan'208";a="165811205"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2020 23:57:07 -0700
IronPort-SDR: K7EjkQSmVfcLetVSM9pN7yPGwie8tQF1e+rTf1pNItdE9zE0i+JjYyYNuC+qIADyEqRl+tv80p
 J5ZVxRcHbSyQ==
X-IronPort-AV: E=Sophos;i="5.77,366,1596524400"; 
   d="scan'208";a="462996926"
Received: from xingzhen-mobl.ccr.corp.intel.com (HELO [10.238.4.68]) ([10.238.4.68])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2020 23:57:03 -0700
Subject: Re: [LKP] [mm] 5ef64cc898: vm-scalability.throughput -20.6%
 regression
To:     kernel test robot <rong.a.chen@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Michael Larabel <Michael@michaellarabel.com>,
        Matthieu Baerts <matthieu.baerts@tessares.net>,
        Dave Chinner <david@fromorbit.com>,
        Matthew Wilcox <willy@infradead.org>, Chris Mason <clm@fb.com>,
        Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com, zhengjun.xing@intel.com
References: <20200921092355.GI13157@shao2-debian>
From:   Xing Zhengjun <zhengjun.xing@linux.intel.com>
Message-ID: <4376a51f-a0f4-5615-edc9-2105b57f550a@linux.intel.com>
Date:   Mon, 12 Oct 2020 14:57:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20200921092355.GI13157@shao2-debian>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

   Do you have time to look at this? Thanks. I re-test it in v5.9-rc8, 
the regression still existed.


On 9/21/2020 5:23 PM, kernel test robot wrote:
> Greeting,
> 
> FYI, we noticed a -20.6% regression of vm-scalability.throughput due to commit:
> 
> 
> commit: 5ef64cc8987a9211d3f3667331ba3411a94ddc79 ("mm: allow a controlled amount of unfairness in the page lock")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> 
> 
> in testcase: vm-scalability
> on test machine: 16 threads Intel(R) Xeon(R) E-2278G CPU @ 3.40GHz with 32G memory
> with following parameters:
> 
> 	runtime: 300s
> 	size: 2T
> 	test: shm-xread-seq
> 	cpufreq_governor: performance
> 	ucode: 0xd6
> 
> test-description: The motivation behind this suite is to exercise functions and regions of the mm/ of the Linux kernel which are of interest to us.
> test-url: https://git.kernel.org/cgit/linux/kernel/git/wfg/vm-scalability.git/
> 
> In addition to that, the commit also has significant impact on the following tests:
> 
> +------------------+---------------------------------------------------------------------------+
> | testcase: change | unixbench: unixbench.score 5.4% improvement                               |
> | test machine     | 16 threads Intel(R) Xeon(R) E-2278G CPU @ 3.40GHz with 32G memory         |
> | test parameters  | cpufreq_governor=performance                                              |
> |                  | nr_task=30%                                                               |
> |                  | runtime=300s                                                              |
> |                  | test=shell8                                                               |
> |                  | ucode=0xd6                                                                |
> +------------------+---------------------------------------------------------------------------+
> | testcase: change | will-it-scale: will-it-scale.per_thread_ops 688.3% improvement            |
> | test machine     | 192 threads Intel(R) Xeon(R) Platinum 9242 CPU @ 2.30GHz with 192G memory |
> | test parameters  | cpufreq_governor=performance                                              |
> |                  | mode=thread                                                               |
> |                  | nr_task=50%                                                               |
> |                  | test=readseek2                                                            |
> |                  | ucode=0x5002f01                                                           |
> +------------------+---------------------------------------------------------------------------+
> | testcase: change | stress-ng: stress-ng.timerfd.ops_per_sec -3.2% regression                 |
> | test machine     | 96 threads Intel(R) Xeon(R) Gold 6252 CPU @ 2.10GHz with 192G memory      |
> | test parameters  | class=interrupt                                                           |
> |                  | cpufreq_governor=performance                                              |
> |                  | disk=1HDD                                                                 |
> |                  | nr_threads=100%                                                           |
> |                  | testtime=30s                                                              |
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
> compiler/cpufreq_governor/kconfig/rootfs/runtime/size/tbox_group/test/testcase/ucode:
>    gcc-9/performance/x86_64-rhel-8.3/debian-10.4-x86_64-20200603.cgz/300s/2T/lkp-cfl-e1/shm-xread-seq/vm-scalability/0xd6
> 
> commit:
>    5925fa68fe (" perf tools fixes for v5.9: 3rd batch")
>    5ef64cc898 ("mm: allow a controlled amount of unfairness in the page lock")
> 
> 5925fa68fe824465 5ef64cc8987a9211d3f3667331b
> ---------------- ---------------------------
>         fail:runs  %reproduction    fail:runs
>             |             |             |
>            3:4          -34%           1:4     perf-profile.calltrace.cycles-pp.sync_regs.error_entry
>            3:4          -24%           2:4     perf-profile.calltrace.cycles-pp.error_entry
>            5:4          -30%           4:4     perf-profile.children.cycles-pp.error_entry
>            0:4           -4%           0:4     perf-profile.self.cycles-pp.error_entry
>           %stddev     %change         %stddev
>               \          |                \
>      985306           -20.6%     782124        vm-scalability.median
>        5.42 ±  4%      -2.3        3.15 ±  3%  vm-scalability.median_stddev%
>    15764904           -20.6%   12513939        vm-scalability.throughput
>      173.16           +22.0%     211.25        vm-scalability.time.elapsed_time
>      173.16           +22.0%     211.25        vm-scalability.time.elapsed_time.max
>       15477 ±  4%    +129.1%      35465 ±  3%  vm-scalability.time.involuntary_context_switches
>   2.569e+08           +56.2%  4.013e+08        vm-scalability.time.minor_page_faults
>        1283           +12.8%       1447        vm-scalability.time.percent_of_cpu_this_job_got
>      971.71           +87.0%       1816        vm-scalability.time.system_time
>    56042863           -10.0%   50440135        vm-scalability.time.voluntary_context_switches
>      197.11           +19.3%     235.15        uptime.boot
>     1052993           -19.6%     846362        meminfo.Active
>     1052899           -19.6%     846266        meminfo.Active(anon)
>      105575           -17.9%      86662        meminfo.max_used_kB
>       20.13           -12.0        8.10        mpstat.cpu.all.idle%
>        0.61 ±  3%      -0.6        0.01 ±  3%  mpstat.cpu.all.iowait%
>        0.95            +0.6        1.53        mpstat.cpu.all.irq%
>       34.10           +19.4       53.49        mpstat.cpu.all.sys%
>       44.17            -7.4       36.81        mpstat.cpu.all.usr%
>       20.75 ±  2%     -60.2%       8.25 ±  5%  vmstat.cpu.id
>       34.25           +57.7%      54.00        vmstat.cpu.sy
>       43.25           -16.8%      36.00        vmstat.cpu.us
>       11.00           +27.3%      14.00        vmstat.procs.r
>      637460           -26.0%     471762        vmstat.system.cs
>       68148           +88.2%     128254        vmstat.system.in
>    41584830 ±  3%     -86.3%    5680589        cpuidle.C1.time
>     7034552           -52.7%    3328990        cpuidle.C1.usage
>      166290 ± 42%     -52.8%      78434 ± 30%  cpuidle.C10.time
>   1.039e+08           -87.4%   13042277 ±  3%  cpuidle.C1E.time
>     9612513 ±  2%     -96.9%     294433 ±  3%  cpuidle.C1E.usage
>   2.713e+08           -59.5%    1.1e+08        cpuidle.POLL.time
>    48132156           -40.9%   28439987        cpuidle.POLL.usage
>      264158           -19.1%     213736        proc-vmstat.nr_active_anon
>     2482625            -1.7%    2441126        proc-vmstat.nr_file_pages
>     2240838            -1.9%    2199269        proc-vmstat.nr_shmem
>      264158           -19.1%     213736        proc-vmstat.nr_zone_active_anon
>    40104796           +19.0%   47743573        proc-vmstat.numa_hit
>    40104796           +19.0%   47743573        proc-vmstat.numa_local
>    40189131           +19.0%   47826525        proc-vmstat.pgalloc_normal
>   2.572e+08           +56.2%  4.016e+08        proc-vmstat.pgfault
>    39751695           +17.5%   46709736 ±  2%  proc-vmstat.pgfree
>       19586 ±  2%     +25.4%      24554        proc-vmstat.pgreuse
>       12821 ± 11%     +70.1%      21804 ±  7%  softirqs.CPU0.RCU
>       55373           +58.2%      87598        softirqs.CPU0.SCHED
>       13132 ± 12%     +56.6%      20564 ±  2%  softirqs.CPU1.RCU
>       54173 ±  2%     +63.0%      88299        softirqs.CPU1.SCHED
>       12063 ± 11%     +56.0%      18815 ±  8%  softirqs.CPU10.RCU
>       52997 ±  2%     +63.7%      86776        softirqs.CPU10.SCHED
>       11146 ± 12%     +73.5%      19343 ±  6%  softirqs.CPU11.RCU
>       52858           +62.8%      86060        softirqs.CPU11.SCHED
>       12394 ± 20%     +57.9%      19564 ±  6%  softirqs.CPU12.RCU
>       52153           +66.2%      86659        softirqs.CPU12.SCHED
>       11714 ± 11%     +58.9%      18619 ±  9%  softirqs.CPU13.RCU
>       51630           +69.1%      87317        softirqs.CPU13.SCHED
>       11541 ± 15%     +71.1%      19751 ± 10%  softirqs.CPU14.RCU
>       52171 ±  2%     +67.7%      87471        softirqs.CPU14.SCHED
>       12034 ± 13%     +60.5%      19317 ±  8%  softirqs.CPU15.RCU
>       52657           +65.2%      86972        softirqs.CPU15.SCHED
>       11964 ± 13%     +75.0%      20934 ±  6%  softirqs.CPU2.RCU
>       53736           +62.2%      87150        softirqs.CPU2.SCHED
>       11927 ± 11%     +61.5%      19267 ±  9%  softirqs.CPU3.RCU
>       52931 ±  2%     +63.2%      86386        softirqs.CPU3.SCHED
>       12353 ± 15%     +58.0%      19513 ±  6%  softirqs.CPU4.RCU
>       51881           +68.0%      87174        softirqs.CPU4.SCHED
>       11154 ± 16%     +72.4%      19234 ±  6%  softirqs.CPU5.RCU
>       51954           +67.9%      87209        softirqs.CPU5.SCHED
>       11700 ± 12%     +79.5%      21004 ± 11%  softirqs.CPU6.RCU
>       51722           +68.9%      87358        softirqs.CPU6.SCHED
>       11795 ± 11%     +79.5%      21169 ± 13%  softirqs.CPU7.RCU
>       52777           +64.8%      86985        softirqs.CPU7.SCHED
>       11352 ± 16%     +70.3%      19336 ±  7%  softirqs.CPU8.RCU
>       53939           +61.1%      86897        softirqs.CPU8.SCHED
>       13223 ± 21%     +54.5%      20423 ± 10%  softirqs.CPU9.RCU
>       53570 ±  2%     +61.4%      86435        softirqs.CPU9.SCHED
>      192323 ± 12%     +65.7%     318668 ±  7%  softirqs.RCU
>      846531           +64.5%    1392755        softirqs.SCHED
>       13340 ±  3%     +28.3%      17120 ±  3%  softirqs.TIMER
>     5616584          +255.3%   19953996        interrupts.CAL:Function_call_interrupts
>      403342 ±  4%    +225.2%    1311736        interrupts.CPU0.CAL:Function_call_interrupts
>      348468           +21.9%     424744        interrupts.CPU0.LOC:Local_timer_interrupts
>       28665 ±  4%     -21.7%      22431 ±  2%  interrupts.CPU0.RES:Rescheduling_interrupts
>      385359          +233.7%    1285782        interrupts.CPU1.CAL:Function_call_interrupts
>      348549           +21.8%     424706        interrupts.CPU1.LOC:Local_timer_interrupts
>       28794 ±  3%     -17.9%      23633        interrupts.CPU1.RES:Rescheduling_interrupts
>      369509 ±  3%    +240.9%    1259663        interrupts.CPU10.CAL:Function_call_interrupts
>      348480           +21.9%     424783        interrupts.CPU10.LOC:Local_timer_interrupts
>       30068 ±  3%     -18.6%      24464 ±  2%  interrupts.CPU10.RES:Rescheduling_interrupts
>      353201 ±  2%    +246.8%    1225041        interrupts.CPU11.CAL:Function_call_interrupts
>      348488           +21.9%     424702        interrupts.CPU11.LOC:Local_timer_interrupts
>       30935 ±  3%     -22.9%      23861 ±  5%  interrupts.CPU11.RES:Rescheduling_interrupts
>      323460 ±  2%    +276.6%    1218231        interrupts.CPU12.CAL:Function_call_interrupts
>      348410           +21.9%     424849        interrupts.CPU12.LOC:Local_timer_interrupts
>       31301 ±  3%     -24.0%      23799 ±  4%  interrupts.CPU12.RES:Rescheduling_interrupts
>      306249          +291.8%    1199851        interrupts.CPU13.CAL:Function_call_interrupts
>      348436           +21.9%     424721        interrupts.CPU13.LOC:Local_timer_interrupts
>       31048 ±  3%     -19.3%      25040 ±  3%  interrupts.CPU13.RES:Rescheduling_interrupts
>      311947 ±  2%    +291.1%    1220172        interrupts.CPU14.CAL:Function_call_interrupts
>      348554           +21.8%     424574        interrupts.CPU14.LOC:Local_timer_interrupts
>       30893 ±  4%     -18.7%      25116 ±  4%  interrupts.CPU14.RES:Rescheduling_interrupts
>      339980 ±  2%    +259.0%    1220678        interrupts.CPU15.CAL:Function_call_interrupts
>      348418           +21.9%     424803        interrupts.CPU15.LOC:Local_timer_interrupts
>       29624 ±  3%     -16.7%      24674        interrupts.CPU15.RES:Rescheduling_interrupts
>      369199 ±  2%    +241.6%    1261224        interrupts.CPU2.CAL:Function_call_interrupts
>      348518           +21.9%     424863        interrupts.CPU2.LOC:Local_timer_interrupts
>       29702 ±  2%     -21.3%      23377 ±  4%  interrupts.CPU2.RES:Rescheduling_interrupts
>      352942          +253.9%    1249080        interrupts.CPU3.CAL:Function_call_interrupts
>      348266           +21.9%     424684        interrupts.CPU3.LOC:Local_timer_interrupts
>       31038           -25.3%      23178 ±  4%  interrupts.CPU3.RES:Rescheduling_interrupts
>      327561          +272.0%    1218661        interrupts.CPU4.CAL:Function_call_interrupts
>      348447           +21.9%     424700        interrupts.CPU4.LOC:Local_timer_interrupts
>       30527           -22.9%      23534 ±  3%  interrupts.CPU4.RES:Rescheduling_interrupts
>      311428 ±  2%    +286.3%    1202941        interrupts.CPU5.CAL:Function_call_interrupts
>      348533           +21.9%     424787        interrupts.CPU5.LOC:Local_timer_interrupts
>       30825 ±  4%     -13.7%      26600 ±  5%  interrupts.CPU5.RES:Rescheduling_interrupts
>      319963 ±  2%    +287.0%    1238272        interrupts.CPU6.CAL:Function_call_interrupts
>      348246           +22.0%     424716        interrupts.CPU6.LOC:Local_timer_interrupts
>       29411 ±  4%     -20.2%      23471 ±  2%  interrupts.CPU6.RES:Rescheduling_interrupts
>      344529 ±  3%    +263.6%    1252800        interrupts.CPU7.CAL:Function_call_interrupts
>      348501           +21.8%     424469        interrupts.CPU7.LOC:Local_timer_interrupts
>       30725 ±  3%     -20.7%      24366 ±  5%  interrupts.CPU7.RES:Rescheduling_interrupts
>      408919 ±  5%    +219.7%    1307498        interrupts.CPU8.CAL:Function_call_interrupts
>      348306           +22.0%     424854        interrupts.CPU8.LOC:Local_timer_interrupts
>       27910 ±  4%     -19.9%      22361 ±  2%  interrupts.CPU8.RES:Rescheduling_interrupts
>      388993 ±  3%    +229.7%    1282361        interrupts.CPU9.CAL:Function_call_interrupts
>      348529           +21.9%     424872        interrupts.CPU9.LOC:Local_timer_interrupts
>       28499 ±  2%     -13.0%      24791 ±  4%  interrupts.CPU9.RES:Rescheduling_interrupts
>     5575155           +21.9%    6795831        interrupts.LOC:Local_timer_interrupts
>      479969 ±  2%     -19.8%     384701        interrupts.RES:Rescheduling_interrupts
>      239.00 ±  4%     -44.9%     131.75 ± 11%  interrupts.TLB:TLB_shootdowns
>       48085           +69.4%      81451        sched_debug.cfs_rq:/.exec_clock.avg
>       49258           +67.3%      82414        sched_debug.cfs_rq:/.exec_clock.max
>       46356           +73.3%      80327        sched_debug.cfs_rq:/.exec_clock.min
>       80499 ± 81%     -60.4%      31857 ±  3%  sched_debug.cfs_rq:/.load.stddev
>      127.01 ±  9%     -16.2%     106.49 ± 13%  sched_debug.cfs_rq:/.load_avg.avg
>      642.42 ± 23%     -30.5%     446.56 ±  3%  sched_debug.cfs_rq:/.load_avg.max
>      169.53 ± 17%     -29.5%     119.49 ± 12%  sched_debug.cfs_rq:/.load_avg.stddev
>      588910           +87.0%    1101108        sched_debug.cfs_rq:/.min_vruntime.avg
>      606363           +84.1%    1116408        sched_debug.cfs_rq:/.min_vruntime.max
>      561578 ±  2%     +91.7%    1076386        sched_debug.cfs_rq:/.min_vruntime.min
>        0.71 ±  8%     +24.8%       0.89        sched_debug.cfs_rq:/.nr_running.avg
>        0.45 ±  9%     -47.2%       0.24        sched_debug.cfs_rq:/.nr_running.stddev
>        0.73 ± 18%     +59.6%       1.16 ± 11%  sched_debug.cfs_rq:/.nr_spread_over.avg
>        1559 ±  5%      +9.0%       1699 ±  5%  sched_debug.cfs_rq:/.runnable_avg.max
>      381.23 ±  4%     +62.0%     617.48 ±  5%  sched_debug.cfs_rq:/.util_est_enqueued.avg
>        1129 ±  8%     +20.4%       1359 ±  6%  sched_debug.cfs_rq:/.util_est_enqueued.max
>       77869 ±  6%     -37.4%      48731 ±  8%  sched_debug.cpu.avg_idle.avg
>      399988 ± 12%     -30.9%     276240 ± 23%  sched_debug.cpu.avg_idle.max
>       96550 ± 12%     -34.3%      63478 ± 24%  sched_debug.cpu.avg_idle.stddev
>       83560           +35.7%     113424        sched_debug.cpu.clock.avg
>       83561           +35.7%     113425        sched_debug.cpu.clock.max
>       83558           +35.7%     113423        sched_debug.cpu.clock.min
>        0.78 ±  9%     -35.6%       0.50 ±  4%  sched_debug.cpu.clock.stddev
>       82827           +35.1%     111904        sched_debug.cpu.clock_task.avg
>       82999           +35.0%     112089        sched_debug.cpu.clock_task.max
>       82262           +35.2%     111189        sched_debug.cpu.clock_task.min
>        1618 ±  6%     +48.8%       2408 ±  2%  sched_debug.cpu.curr->pid.avg
>        2493           +16.5%       2905        sched_debug.cpu.curr->pid.max
>      985.88 ±  8%     -28.7%     703.01 ± 14%  sched_debug.cpu.curr->pid.stddev
>        0.79 ±  5%     +24.7%       0.98        sched_debug.cpu.nr_running.avg
>        0.54 ± 11%     -19.9%       0.44 ±  3%  sched_debug.cpu.nr_running.stddev
>     2444639           +11.6%    2728125        sched_debug.cpu.nr_switches.avg
>     2466248           +18.3%    2917708        sched_debug.cpu.nr_switches.max
>       13988 ± 27%    +642.0%     103791 ±  3%  sched_debug.cpu.nr_switches.stddev
>        0.21 ± 22%     -75.6%       0.05 ± 76%  sched_debug.cpu.nr_uninterruptible.avg
>     2440164           +11.6%    2723801        sched_debug.cpu.sched_count.avg
>     2457113           +18.4%    2909974        sched_debug.cpu.sched_count.max
>       12769 ± 28%    +704.0%     102671 ±  3%  sched_debug.cpu.sched_count.stddev
>     1219314           +11.5%    1359077        sched_debug.cpu.sched_goidle.avg
>     1227676           +18.3%    1452278        sched_debug.cpu.sched_goidle.max
>        6331 ± 28%    +710.4%      51313 ±  3%  sched_debug.cpu.sched_goidle.stddev
>     1220257           +11.7%    1363456        sched_debug.cpu.ttwu_count.avg
>     1251629           +11.3%    1392991        sched_debug.cpu.ttwu_count.max
>     1196282           +10.0%    1316458        sched_debug.cpu.ttwu_count.min
>       17387 ±  8%     +16.8%      20308 ± 10%  sched_debug.cpu.ttwu_count.stddev
>      790.29 ±  3%    +163.0%       2078 ±  5%  sched_debug.cpu.ttwu_local.avg
>        1612 ± 20%     +87.9%       3028 ±  8%  sched_debug.cpu.ttwu_local.max
>      531.25 ±  6%    +148.4%       1319 ± 18%  sched_debug.cpu.ttwu_local.min
>      283.96 ± 23%     +49.2%     423.75 ± 12%  sched_debug.cpu.ttwu_local.stddev
>       83560           +35.7%     113423        sched_debug.cpu_clk
>       82663           +36.2%     112557        sched_debug.ktime
>       84851           +35.2%     114688        sched_debug.sched_clk
>       32.08            +6.1%      34.03        perf-stat.i.MPKI
>   1.672e+10           -16.1%  1.403e+10        perf-stat.i.branch-instructions
>        0.26            +0.0        0.31        perf-stat.i.branch-miss-rate%
>    33778666            +9.6%   37021638        perf-stat.i.branch-misses
>        1.77 ±  2%      -0.4        1.35        perf-stat.i.cache-miss-rate%
>    20527502 ±  2%     -19.2%   16588407        perf-stat.i.cache-misses
>      649397           -26.3%     478422        perf-stat.i.context-switches
>        1.28           +13.5%       1.46        perf-stat.i.cpi
>   5.822e+10            +5.2%  6.125e+10        perf-stat.i.cpu-cycles
>      209.75 ±  6%     +22.7%     257.35 ±  3%  perf-stat.i.cpu-migrations
>        3159           +21.6%       3843        perf-stat.i.cycles-between-cache-misses
>        0.05 ±  5%      +0.0        0.07 ±  6%  perf-stat.i.dTLB-load-miss-rate%
>     8766755 ±  5%     +14.0%    9996512 ±  5%  perf-stat.i.dTLB-load-misses
>   1.572e+10           -15.2%  1.333e+10        perf-stat.i.dTLB-loads
>        0.05            +0.0        0.07        perf-stat.i.dTLB-store-miss-rate%
>     1534360           +27.2%    1951224        perf-stat.i.dTLB-store-misses
>   3.172e+09           -10.9%  2.826e+09        perf-stat.i.dTLB-stores
>       78.19           +15.6       93.74        perf-stat.i.iTLB-load-miss-rate%
>     6626547           -23.1%    5098140        perf-stat.i.iTLB-load-misses
>     1936185 ±  3%     -84.8%     294324        perf-stat.i.iTLB-loads
>   5.451e+10           -15.1%  4.625e+10        perf-stat.i.instructions
>        0.94           -19.5%       0.76        perf-stat.i.ipc
>        3.64            +5.2%       3.83        perf-stat.i.metric.GHz
>        0.07 ±  8%     -25.7%       0.06 ± 14%  perf-stat.i.metric.K/sec
>        2310           -14.7%       1971        perf-stat.i.metric.M/sec
>     1488490           +27.9%    1903399        perf-stat.i.minor-faults
>      195100 ±  2%     -26.6%     143181        perf-stat.i.node-loads
>    13149630           -18.3%   10746838        perf-stat.i.node-stores
>     1488491           +27.9%    1903399        perf-stat.i.page-faults
>       24.51           +17.8%      28.88        perf-stat.overall.MPKI
>        0.20            +0.1        0.26        perf-stat.overall.branch-miss-rate%
>        1.54 ±  2%      -0.3        1.24        perf-stat.overall.cache-miss-rate%
>        1.07           +24.0%       1.32        perf-stat.overall.cpi
>        2837 ±  2%     +30.1%       3691        perf-stat.overall.cycles-between-cache-misses
>        0.06 ±  5%      +0.0        0.07 ±  5%  perf-stat.overall.dTLB-load-miss-rate%
>        0.05            +0.0        0.07        perf-stat.overall.dTLB-store-miss-rate%
>       77.39           +17.1       94.54        perf-stat.overall.iTLB-load-miss-rate%
>        8229 ±  2%     +10.3%       9073        perf-stat.overall.instructions-per-iTLB-miss
>        0.94           -19.3%       0.76        perf-stat.overall.ipc
>        3984            +3.7%       4129        perf-stat.overall.path-length
>   1.662e+10           -16.0%  1.396e+10        perf-stat.ps.branch-instructions
>    33589028            +9.7%   36852570        perf-stat.ps.branch-misses
>    20412439 ±  2%     -19.1%   16512315        perf-stat.ps.cache-misses
>      645542           -26.3%     476080        perf-stat.ps.context-switches
>   5.788e+10            +5.3%  6.096e+10        perf-stat.ps.cpu-cycles
>      208.60 ±  5%     +23.0%     256.52 ±  3%  perf-stat.ps.cpu-migrations
>     8715455 ±  5%     +14.1%    9947519 ±  5%  perf-stat.ps.dTLB-load-misses
>   1.563e+10           -15.1%  1.327e+10        perf-stat.ps.dTLB-loads
>     1525309           +27.3%    1941693        perf-stat.ps.dTLB-store-misses
>   3.153e+09           -10.8%  2.812e+09        perf-stat.ps.dTLB-stores
>     6587329           -23.0%    5073245        perf-stat.ps.iTLB-load-misses
>     1924701 ±  3%     -84.8%     292898        perf-stat.ps.iTLB-loads
>   5.419e+10           -15.1%  4.603e+10        perf-stat.ps.instructions
>     1479701           +28.0%    1894095        perf-stat.ps.minor-faults
>      194078 ±  2%     -26.5%     142593        perf-stat.ps.node-loads
>    13072694           -18.2%   10694520        perf-stat.ps.node-stores
>     1479702           +28.0%    1894095        perf-stat.ps.page-faults
>   9.416e+12            +3.7%   9.76e+12        perf-stat.total.instructions
>       28.81 ± 37%     -21.6        7.25 ±  2%  perf-profile.calltrace.cycles-pp.secondary_startup_64
>       27.38 ± 37%     -20.6        6.82 ±  2%  perf-profile.calltrace.cycles-pp.start_secondary.secondary_startup_64
>       27.38 ± 37%     -20.6        6.82 ±  2%  perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.secondary_startup_64
>       27.34 ± 37%     -20.5        6.79 ±  2%  perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64
>       23.22 ± 37%     -18.7        4.48 ±  3%  perf-profile.calltrace.cycles-pp.cpuidle_enter.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64
>       23.20 ± 37%     -18.7        4.47 ±  3%  perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry.start_secondary
>       15.78 ± 39%     -12.4        3.42 ±  4%  perf-profile.calltrace.cycles-pp.poll_idle.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry
>        7.97 ± 37%      -7.1        0.87 ± 15%  perf-profile.calltrace.cycles-pp.intel_idle.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry
>        5.85 ± 40%      -5.0        0.82 ± 13%  perf-profile.calltrace.cycles-pp.try_to_wake_up.wake_page_function.__wake_up_common.wake_up_page_bit.do_fault
>        6.11 ± 40%      -4.9        1.19 ± 12%  perf-profile.calltrace.cycles-pp.__wake_up_common.wake_up_page_bit.do_fault.__handle_mm_fault.handle_mm_fault
>        6.02 ± 41%      -4.9        1.12 ± 12%  perf-profile.calltrace.cycles-pp.wake_page_function.__wake_up_common.wake_up_page_bit.do_fault.__handle_mm_fault
>        4.33 ± 40%      -4.0        0.28 ±100%  perf-profile.calltrace.cycles-pp.ttwu_do_activate.try_to_wake_up.wake_page_function.__wake_up_common.wake_up_page_bit
>        4.31 ± 40%      -4.0        0.28 ±100%  perf-profile.calltrace.cycles-pp.enqueue_task_fair.ttwu_do_activate.try_to_wake_up.wake_page_function.__wake_up_common
>        4.14 ± 40%      -3.9        0.27 ±100%  perf-profile.calltrace.cycles-pp.enqueue_entity.enqueue_task_fair.ttwu_do_activate.try_to_wake_up.wake_page_function
>        2.32 ± 42%      -1.6        0.74 ± 12%  perf-profile.calltrace.cycles-pp.schedule.io_schedule.__lock_page.find_lock_entry.shmem_getpage_gfp
>        2.27 ± 42%      -1.5        0.73 ± 12%  perf-profile.calltrace.cycles-pp.__schedule.schedule.io_schedule.__lock_page.find_lock_entry
>        2.37 ± 42%      -1.5        0.89 ± 18%  perf-profile.calltrace.cycles-pp.io_schedule.__lock_page.find_lock_entry.shmem_getpage_gfp.shmem_fault
>        0.28 ±100%      +0.4        0.63 ±  4%  perf-profile.calltrace.cycles-pp.ttwu_do_activate.sched_ttwu_pending.__sysvec_call_function_single.asm_call_on_stack.sysvec_call_function_single
>        0.27 ±100%      +0.4        0.62 ±  4%  perf-profile.calltrace.cycles-pp.enqueue_task_fair.ttwu_do_activate.sched_ttwu_pending.__sysvec_call_function_single.asm_call_on_stack
>        0.30 ±100%      +0.4        0.68 ±  4%  perf-profile.calltrace.cycles-pp.sched_ttwu_pending.__sysvec_call_function_single.asm_call_on_stack.sysvec_call_function_single.asm_sysvec_call_function_single
>        0.32 ±100%      +0.4        0.74 ±  5%  perf-profile.calltrace.cycles-pp.asm_call_on_stack.sysvec_call_function_single.asm_sysvec_call_function_single.finish_task_switch.__schedule
>        0.32 ±100%      +0.4        0.74 ±  5%  perf-profile.calltrace.cycles-pp.__sysvec_call_function_single.asm_call_on_stack.sysvec_call_function_single.asm_sysvec_call_function_single.finish_task_switch
>        0.14 ±173%      +0.5        0.59 ±  4%  perf-profile.calltrace.cycles-pp.enqueue_entity.enqueue_task_fair.ttwu_do_activate.sched_ttwu_pending.__sysvec_call_function_single
>        0.35 ±100%      +0.5        0.81 ±  5%  perf-profile.calltrace.cycles-pp.sysvec_call_function_single.asm_sysvec_call_function_single.finish_task_switch.__schedule.schedule_idle
>        0.40 ±100%      +0.5        0.90 ±  6%  perf-profile.calltrace.cycles-pp.finish_task_switch.__schedule.schedule_idle.do_idle.cpu_startup_entry
>        0.14 ±173%      +0.5        0.65 ±  4%  perf-profile.calltrace.cycles-pp.release_pages.pagevec_lru_move_fn.activate_page.mark_page_accessed.zap_pte_range
>        0.38 ±100%      +0.5        0.89 ±  5%  perf-profile.calltrace.cycles-pp.asm_sysvec_call_function_single.finish_task_switch.__schedule.schedule_idle.do_idle
>        0.18 ±173%      +0.7        0.83 ±  7%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.unlinkat
>        0.18 ±173%      +0.7        0.83 ±  7%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.unlinkat
>        0.18 ±173%      +0.7        0.83 ±  7%  perf-profile.calltrace.cycles-pp.unlinkat
>        0.18 ±173%      +0.7        0.83 ±  7%  perf-profile.calltrace.cycles-pp.do_unlinkat.do_syscall_64.entry_SYSCALL_64_after_hwframe.unlinkat
>        0.18 ±173%      +0.7        0.83 ±  7%  perf-profile.calltrace.cycles-pp.evict.do_unlinkat.do_syscall_64.entry_SYSCALL_64_after_hwframe.unlinkat
>        0.18 ±173%      +0.7        0.83 ±  7%  perf-profile.calltrace.cycles-pp.shmem_evict_inode.evict.do_unlinkat.do_syscall_64.entry_SYSCALL_64_after_hwframe
>        0.18 ±173%      +0.7        0.83 ±  7%  perf-profile.calltrace.cycles-pp.shmem_truncate_range.shmem_evict_inode.evict.do_unlinkat.do_syscall_64
>        0.18 ±173%      +0.7        0.83 ±  7%  perf-profile.calltrace.cycles-pp.shmem_undo_range.shmem_truncate_range.shmem_evict_inode.evict.do_unlinkat
>        0.26 ±173%      +0.9        1.13 ±  5%  perf-profile.calltrace.cycles-pp.__activate_page.pagevec_lru_move_fn.activate_page.mark_page_accessed.zap_pte_range
>        0.28 ±173%      +1.2        1.50 ±  4%  perf-profile.calltrace.cycles-pp.release_pages.tlb_flush_mmu.zap_pte_range.unmap_page_range.unmap_vmas
>        0.37 ±173%      +1.5        1.90 ±  5%  perf-profile.calltrace.cycles-pp.tlb_flush_mmu.zap_pte_range.unmap_page_range.unmap_vmas.exit_mmap
>        0.73 ±173%      +2.2        2.89 ±  3%  perf-profile.calltrace.cycles-pp.page_remove_rmap.zap_pte_range.unmap_page_range.unmap_vmas.exit_mmap
>        0.76 ±173%      +3.0        3.73 ±  3%  perf-profile.calltrace.cycles-pp.workingset_age_nonresident.workingset_activation.mark_page_accessed.zap_pte_range.unmap_page_range
>        0.91 ±173%      +3.4        4.34 ±  3%  perf-profile.calltrace.cycles-pp.workingset_activation.mark_page_accessed.zap_pte_range.unmap_page_range.unmap_vmas
>        0.00            +4.7        4.65 ±  3%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.wake_up_page_bit.do_fault.__handle_mm_fault
>        0.00            +4.8        4.78 ±  3%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.wake_up_page_bit.do_fault.__handle_mm_fault.handle_mm_fault
>        1.56 ±173%      +5.9        7.47 ±  3%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.pagevec_lru_move_fn.activate_page.mark_page_accessed
>        1.57 ±173%      +6.0        7.53 ±  3%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.pagevec_lru_move_fn.activate_page.mark_page_accessed.zap_pte_range
>        0.00            +7.3        7.34 ±  2%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.wake_up_page_bit.filemap_map_pages.do_fault
>        0.00            +7.5        7.46 ±  2%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.wake_up_page_bit.filemap_map_pages.do_fault.__handle_mm_fault
>        2.07 ±173%      +7.7        9.74 ±  3%  perf-profile.calltrace.cycles-pp.pagevec_lru_move_fn.activate_page.mark_page_accessed.zap_pte_range.unmap_page_range
>        0.37 ±100%      +8.2        8.52 ±  2%  perf-profile.calltrace.cycles-pp.wake_up_page_bit.filemap_map_pages.do_fault.__handle_mm_fault.handle_mm_fault
>        2.41 ±173%      +8.7       11.09 ±  3%  perf-profile.calltrace.cycles-pp.activate_page.mark_page_accessed.zap_pte_range.unmap_page_range.unmap_vmas
>       18.70 ± 39%     +11.2       29.95 ±  2%  perf-profile.calltrace.cycles-pp.filemap_map_pages.do_fault.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
>        4.12 ±173%     +14.6       18.74 ±  3%  perf-profile.calltrace.cycles-pp.mark_page_accessed.zap_pte_range.unmap_page_range.unmap_vmas.exit_mmap
>        5.98 ±173%     +20.5       26.51 ±  3%  perf-profile.calltrace.cycles-pp.zap_pte_range.unmap_page_range.unmap_vmas.exit_mmap.mmput
>        6.00 ±173%     +20.6       26.57 ±  3%  perf-profile.calltrace.cycles-pp.unmap_vmas.exit_mmap.mmput.do_exit.do_group_exit
>        6.00 ±173%     +20.6       26.57 ±  3%  perf-profile.calltrace.cycles-pp.unmap_page_range.unmap_vmas.exit_mmap.mmput.do_exit
>        6.00 ±173%     +20.6       26.60 ±  3%  perf-profile.calltrace.cycles-pp.mmput.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
>        6.00 ±173%     +20.6       26.60 ±  3%  perf-profile.calltrace.cycles-pp.exit_mmap.mmput.do_exit.do_group_exit.__x64_sys_exit_group
>        6.00 ±173%     +20.6       26.61 ±  3%  perf-profile.calltrace.cycles-pp.__x64_sys_exit_group.do_syscall_64.entry_SYSCALL_64_after_hwframe
>        6.00 ±173%     +20.6       26.61 ±  3%  perf-profile.calltrace.cycles-pp.do_group_exit.__x64_sys_exit_group.do_syscall_64.entry_SYSCALL_64_after_hwframe
>        6.00 ±173%     +20.6       26.61 ±  3%  perf-profile.calltrace.cycles-pp.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64.entry_SYSCALL_64_after_hwframe
>        6.00 ±173%     +20.6       26.61 ±  3%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe
>        6.00 ±173%     +20.6       26.61 ±  3%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe
>       28.81 ± 37%     -21.6        7.25 ±  2%  perf-profile.children.cycles-pp.secondary_startup_64
>       28.81 ± 37%     -21.6        7.25 ±  2%  perf-profile.children.cycles-pp.cpu_startup_entry
>       28.77 ± 37%     -21.6        7.22 ±  2%  perf-profile.children.cycles-pp.do_idle
>       27.38 ± 37%     -20.6        6.82 ±  2%  perf-profile.children.cycles-pp.start_secondary
>       24.40 ± 37%     -19.6        4.76 ±  3%  perf-profile.children.cycles-pp.cpuidle_enter
>       24.38 ± 37%     -19.6        4.76 ±  3%  perf-profile.children.cycles-pp.cpuidle_enter_state
>       15.86 ± 38%     -12.2        3.63 ±  3%  perf-profile.children.cycles-pp.poll_idle
>        8.17 ± 36%      -7.3        0.92 ± 13%  perf-profile.children.cycles-pp.intel_idle
>        6.35 ± 38%      -4.3        2.06 ±  4%  perf-profile.children.cycles-pp.wake_page_function
>        6.45 ± 38%      -4.3        2.20 ±  4%  perf-profile.children.cycles-pp.__wake_up_common
>        6.17 ± 38%      -4.2        1.95 ±  4%  perf-profile.children.cycles-pp.try_to_wake_up
>        5.04 ± 38%      -3.0        2.06 ±  3%  perf-profile.children.cycles-pp.ttwu_do_activate
>        5.02 ± 38%      -3.0        2.04 ±  3%  perf-profile.children.cycles-pp.enqueue_task_fair
>        4.84 ± 38%      -2.9        1.97 ±  3%  perf-profile.children.cycles-pp.enqueue_entity
>        4.02 ± 38%      -2.4        1.62 ±  3%  perf-profile.children.cycles-pp.__account_scheduler_latency
>        3.40 ± 38%      -2.0        1.36 ±  2%  perf-profile.children.cycles-pp.stack_trace_save_tsk
>        3.17 ± 39%      -1.9        1.27        perf-profile.children.cycles-pp.arch_stack_walk
>        2.06 ± 38%      -1.3        0.79        perf-profile.children.cycles-pp.unwind_next_frame
>        2.40 ± 40%      -1.2        1.17        perf-profile.children.cycles-pp.io_schedule
>        2.36 ± 40%      -1.2        1.15        perf-profile.children.cycles-pp.schedule
>        1.42 ± 52%      -1.0        0.42 ± 15%  perf-profile.children.cycles-pp.start_kernel
>        1.34 ± 38%      -1.0        0.38 ±  4%  perf-profile.children.cycles-pp.menu_select
>        1.22 ± 40%      -0.7        0.57        perf-profile.children.cycles-pp.dequeue_task_fair
>        1.08 ± 41%      -0.6        0.50        perf-profile.children.cycles-pp.dequeue_entity
>        0.95 ± 38%      -0.5        0.40 ±  3%  perf-profile.children.cycles-pp.pick_next_task_fair
>        0.80 ± 37%      -0.4        0.39 ±  2%  perf-profile.children.cycles-pp.update_load_avg
>        0.62 ± 39%      -0.4        0.24 ±  6%  perf-profile.children.cycles-pp.set_next_entity
>        0.50 ± 38%      -0.3        0.16 ±  7%  perf-profile.children.cycles-pp.tick_nohz_get_sleep_length
>        0.48 ± 38%      -0.3        0.21 ±  7%  perf-profile.children.cycles-pp.__orc_find
>        0.49 ± 44%      -0.3        0.22 ±  3%  perf-profile.children.cycles-pp.update_curr
>        0.44 ± 42%      -0.3        0.18 ±  4%  perf-profile.children.cycles-pp.stack_trace_consume_entry_nosched
>        0.36 ± 38%      -0.2        0.13 ±  8%  perf-profile.children.cycles-pp.select_task_rq_fair
>        0.44 ± 39%      -0.2        0.21 ±  6%  perf-profile.children.cycles-pp.unwind_get_return_address
>        0.37 ± 39%      -0.2        0.17 ±  7%  perf-profile.children.cycles-pp.__kernel_text_address
>        0.34 ± 36%      -0.2        0.14 ±  5%  perf-profile.children.cycles-pp.orc_find
>        0.33 ± 40%      -0.2        0.17 ±  3%  perf-profile.children.cycles-pp.update_rq_clock
>        0.26 ± 33%      -0.2        0.09 ± 12%  perf-profile.children.cycles-pp.tick_nohz_next_event
>        0.29 ± 36%      -0.2        0.12 ±  4%  perf-profile.children.cycles-pp.__switch_to_asm
>        0.30 ± 41%      -0.2        0.14 ± 10%  perf-profile.children.cycles-pp.kernel_text_address
>        0.28 ± 35%      -0.1        0.14 ±  9%  perf-profile.children.cycles-pp.sched_clock_cpu
>        0.24 ± 36%      -0.1        0.10 ±  4%  perf-profile.children.cycles-pp.ktime_get
>        0.26 ± 36%      -0.1        0.12 ±  8%  perf-profile.children.cycles-pp.sched_clock
>        0.25 ± 35%      -0.1        0.12 ± 11%  perf-profile.children.cycles-pp.native_sched_clock
>        0.25 ± 41%      -0.1        0.12 ±  5%  perf-profile.children.cycles-pp.__switch_to
>        0.18 ± 35%      -0.1        0.06 ± 11%  perf-profile.children.cycles-pp.tick_nohz_idle_exit
>        0.18 ± 40%      -0.1        0.06 ±  7%  perf-profile.children.cycles-pp.hrtimer_next_event_without
>        0.19 ± 43%      -0.1        0.07        perf-profile.children.cycles-pp.in_sched_functions
>        0.16 ± 42%      -0.1        0.04 ± 60%  perf-profile.children.cycles-pp.update_cfs_rq_h_load
>        0.17 ± 39%      -0.1        0.05 ± 58%  perf-profile.children.cycles-pp.get_next_timer_interrupt
>        0.22 ± 39%      -0.1        0.11 ±  7%  perf-profile.children.cycles-pp.__update_load_avg_se
>        0.18 ± 39%      -0.1        0.07 ± 14%  perf-profile.children.cycles-pp.ttwu_do_wakeup
>        0.16 ± 41%      -0.1        0.07 ±  7%  perf-profile.children.cycles-pp.check_preempt_curr
>        0.11 ± 39%      -0.1        0.03 ±100%  perf-profile.children.cycles-pp.switch_mm_irqs_off
>        0.14 ± 40%      -0.1        0.05 ±  8%  perf-profile.children.cycles-pp.stack_access_ok
>        0.14 ± 40%      -0.1        0.05 ±  9%  perf-profile.children.cycles-pp.__unwind_start
>        0.12 ± 42%      -0.1        0.04 ± 57%  perf-profile.children.cycles-pp.reweight_entity
>        0.15 ± 39%      -0.1        0.07 ± 11%  perf-profile.children.cycles-pp.read_tsc
>        0.15 ± 32%      -0.1        0.08 ± 16%  perf-profile.children.cycles-pp.delayacct_end
>        0.10 ± 39%      -0.1        0.04 ± 58%  perf-profile.children.cycles-pp.account_entity_dequeue
>        0.03 ±100%      +0.0        0.07 ±  7%  perf-profile.children.cycles-pp.native_apic_msr_eoi_write
>        0.01 ±173%      +0.0        0.06 ±  7%  perf-profile.children.cycles-pp.xas_init_marks
>        0.03 ±100%      +0.0        0.07 ± 11%  perf-profile.children.cycles-pp.__unlock_page_memcg
>        0.00            +0.1        0.06 ±  9%  perf-profile.children.cycles-pp.rcu_all_qs
>        0.06 ± 61%      +0.1        0.12 ±  5%  perf-profile.children.cycles-pp.__mod_memcg_state
>        0.07 ± 41%      +0.1        0.13 ± 17%  perf-profile.children.cycles-pp.xas_store
>        0.05 ± 64%      +0.1        0.11 ±  4%  perf-profile.children.cycles-pp.__mod_node_page_state
>        0.02 ±173%      +0.1        0.09        perf-profile.children.cycles-pp.unaccount_page_cache_page
>        0.02 ±173%      +0.1        0.09 ±  7%  perf-profile.children.cycles-pp.__tlb_remove_page_size
>        0.07 ± 68%      +0.1        0.17 ±  9%  perf-profile.children.cycles-pp.__mod_lruvec_state
>        0.07 ± 50%      +0.1        0.18 ± 10%  perf-profile.children.cycles-pp.serial8250_console_write
>        0.02 ±173%      +0.1        0.12 ± 12%  perf-profile.children.cycles-pp.devkmsg_write.cold
>        0.02 ±173%      +0.1        0.12 ± 12%  perf-profile.children.cycles-pp.devkmsg_emit
>        0.03 ±173%      +0.1        0.14 ± 11%  perf-profile.children.cycles-pp.io_serial_in
>        0.04 ±118%      +0.1        0.15 ±  9%  perf-profile.children.cycles-pp.serial8250_console_putchar
>        0.03 ±102%      +0.1        0.14 ± 13%  perf-profile.children.cycles-pp.ksys_write
>        0.03 ±102%      +0.1        0.14 ± 13%  perf-profile.children.cycles-pp.vfs_write
>        0.03 ±102%      +0.1        0.14 ± 13%  perf-profile.children.cycles-pp.new_sync_write
>        0.04 ±118%      +0.1        0.16 ± 11%  perf-profile.children.cycles-pp.wait_for_xmitr
>        0.02 ±173%      +0.1        0.13 ± 11%  perf-profile.children.cycles-pp.write
>        0.05 ±114%      +0.1        0.17 ± 11%  perf-profile.children.cycles-pp.uart_console_write
>        0.04 ±173%      +0.1        0.15 ± 16%  perf-profile.children.cycles-pp.process_one_work
>        0.03 ±173%      +0.1        0.15 ± 16%  perf-profile.children.cycles-pp.drm_fb_helper_dirty_work
>        0.04 ±173%      +0.1        0.16 ± 17%  perf-profile.children.cycles-pp.worker_thread
>        0.03 ±173%      +0.1        0.16 ± 14%  perf-profile.children.cycles-pp.memcpy_erms
>        0.13 ± 37%      +0.1        0.26 ±  4%  perf-profile.children.cycles-pp.__mod_memcg_lruvec_state
>        0.04 ±173%      +0.1        0.16 ± 15%  perf-profile.children.cycles-pp.ret_from_fork
>        0.09 ± 67%      +0.1        0.21 ± 12%  perf-profile.children.cycles-pp.vprintk_emit
>        0.04 ±173%      +0.1        0.16 ± 15%  perf-profile.children.cycles-pp.kthread
>        0.03 ±173%      +0.1        0.16 ±  8%  perf-profile.children.cycles-pp.free_pcppages_bulk
>        0.08 ± 61%      +0.1        0.21 ± 12%  perf-profile.children.cycles-pp.console_unlock
>        0.06 ±129%      +0.2        0.23 ±  6%  perf-profile.children.cycles-pp.free_unref_page_list
>        0.07 ±118%      +0.2        0.26 ±  7%  perf-profile.children.cycles-pp.__delete_from_page_cache
>        0.09 ±127%      +0.2        0.33 ±  8%  perf-profile.children.cycles-pp.__pagevec_release
>        0.10 ±120%      +0.2        0.34 ±  9%  perf-profile.children.cycles-pp.delete_from_page_cache
>        0.06 ±173%      +0.2        0.31 ±  9%  perf-profile.children.cycles-pp.mem_cgroup_page_lruvec
>        0.10 ±120%      +0.3        0.38 ±  7%  perf-profile.children.cycles-pp.truncate_inode_page
>        0.08 ±173%      +0.3        0.39 ±  8%  perf-profile.children.cycles-pp.free_pages_and_swap_cache
>        0.34 ± 51%      +0.3        0.69 ±  5%  perf-profile.children.cycles-pp.lock_page_memcg
>        0.54 ± 46%      +0.4        0.91 ±  3%  perf-profile.children.cycles-pp.sched_ttwu_pending
>        0.25 ± 76%      +0.4        0.62 ±  4%  perf-profile.children.cycles-pp.unlock_page_memcg
>        0.55 ± 43%      +0.4        0.93 ±  3%  perf-profile.children.cycles-pp.find_get_entry
>        0.55 ± 45%      +0.4        0.93 ±  3%  perf-profile.children.cycles-pp.__sysvec_call_function_single
>        0.60 ± 44%      +0.4        1.01 ±  4%  perf-profile.children.cycles-pp.sysvec_call_function_single
>        0.86 ± 35%      +0.4        1.28 ±  3%  perf-profile.children.cycles-pp.asm_call_on_stack
>        0.66 ± 44%      +0.5        1.12 ±  3%  perf-profile.children.cycles-pp.asm_sysvec_call_function_single
>        0.75 ± 30%      +0.5        1.30 ±  4%  perf-profile.children.cycles-pp.PageHuge
>        0.23 ±123%      +0.6        0.83 ±  7%  perf-profile.children.cycles-pp.do_unlinkat
>        0.23 ±123%      +0.6        0.83 ±  7%  perf-profile.children.cycles-pp.evict
>        0.23 ±123%      +0.6        0.83 ±  7%  perf-profile.children.cycles-pp.shmem_evict_inode
>        0.23 ±123%      +0.6        0.83 ±  7%  perf-profile.children.cycles-pp.shmem_truncate_range
>        0.23 ±123%      +0.6        0.83 ±  7%  perf-profile.children.cycles-pp.shmem_undo_range
>        0.18 ±173%      +0.7        0.83 ±  7%  perf-profile.children.cycles-pp.unlinkat
>        0.26 ±173%      +0.9        1.14 ±  5%  perf-profile.children.cycles-pp.__activate_page
>        0.37 ±173%      +1.6        1.93 ±  6%  perf-profile.children.cycles-pp.tlb_flush_mmu
>        0.57 ±147%      +2.0        2.54 ±  4%  perf-profile.children.cycles-pp.release_pages
>        0.74 ±173%      +2.2        2.90 ±  3%  perf-profile.children.cycles-pp.page_remove_rmap
>        0.76 ±173%      +3.0        3.74 ±  3%  perf-profile.children.cycles-pp.workingset_age_nonresident
>        0.91 ±173%      +3.4        4.34 ±  3%  perf-profile.children.cycles-pp.workingset_activation
>        2.37 ±148%      +7.6        9.94 ±  3%  perf-profile.children.cycles-pp.pagevec_lru_move_fn
>        7.14 ± 38%      +7.8       14.90 ±  3%  perf-profile.children.cycles-pp.wake_up_page_bit
>        2.41 ±173%      +8.7       11.09 ±  3%  perf-profile.children.cycles-pp.activate_page
>       18.80 ± 39%     +11.2       30.01 ±  2%  perf-profile.children.cycles-pp.filemap_map_pages
>        4.13 ±173%     +14.6       18.76 ±  3%  perf-profile.children.cycles-pp.mark_page_accessed
>        4.09 ± 52%     +16.8       20.87 ±  3%  perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
>        2.63 ± 93%     +17.4       20.05 ±  3%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
>        6.00 ±173%     +20.6       26.56 ±  3%  perf-profile.children.cycles-pp.zap_pte_range
>        6.00 ±173%     +20.6       26.57 ±  3%  perf-profile.children.cycles-pp.unmap_vmas
>        6.00 ±173%     +20.6       26.57 ±  3%  perf-profile.children.cycles-pp.unmap_page_range
>        6.00 ±173%     +20.6       26.61 ±  3%  perf-profile.children.cycles-pp.mmput
>        6.00 ±173%     +20.6       26.61 ±  3%  perf-profile.children.cycles-pp.exit_mmap
>        6.00 ±173%     +20.6       26.61 ±  3%  perf-profile.children.cycles-pp.__x64_sys_exit_group
>        6.00 ±173%     +20.6       26.61 ±  3%  perf-profile.children.cycles-pp.do_group_exit
>        6.00 ±173%     +20.6       26.61 ±  3%  perf-profile.children.cycles-pp.do_exit
>        6.33 ±168%     +21.3       27.62 ±  3%  perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
>        6.32 ±168%     +21.3       27.62 ±  3%  perf-profile.children.cycles-pp.do_syscall_64
>       15.70 ± 38%     -12.1        3.56 ±  3%  perf-profile.self.cycles-pp.poll_idle
>        8.17 ± 36%      -7.3        0.92 ± 13%  perf-profile.self.cycles-pp.intel_idle
>        1.06 ± 38%      -0.7        0.38 ±  2%  perf-profile.self.cycles-pp.unwind_next_frame
>        0.67 ± 38%      -0.5        0.16 ±  9%  perf-profile.self.cycles-pp.menu_select
>        0.60 ± 41%      -0.3        0.30 ±  5%  perf-profile.self.cycles-pp.__schedule
>        0.48 ± 38%      -0.3        0.21 ±  7%  perf-profile.self.cycles-pp.__orc_find
>        0.40 ± 40%      -0.3        0.13 ±  9%  perf-profile.self.cycles-pp.set_next_entity
>        0.46 ± 38%      -0.3        0.20 ±  4%  perf-profile.self.cycles-pp.__account_scheduler_latency
>        0.38 ± 38%      -0.2        0.16 ±  8%  perf-profile.self.cycles-pp.update_load_avg
>        0.36 ± 38%      -0.2        0.17 ±  2%  perf-profile.self.cycles-pp.try_to_wake_up
>        0.33 ± 37%      -0.2        0.14 ±  7%  perf-profile.self.cycles-pp.orc_find
>        0.33 ± 46%      -0.2        0.15 ± 10%  perf-profile.self.cycles-pp.update_curr
>        0.28 ± 39%      -0.2        0.09 ±  8%  perf-profile.self.cycles-pp.do_idle
>        0.29 ± 36%      -0.2        0.12 ±  4%  perf-profile.self.cycles-pp.__switch_to_asm
>        0.25 ± 42%      -0.1        0.11 ±  6%  perf-profile.self.cycles-pp.stack_trace_consume_entry_nosched
>        0.20 ± 37%      -0.1        0.07 ± 15%  perf-profile.self.cycles-pp.stack_trace_save_tsk
>        0.24 ± 36%      -0.1        0.12 ±  7%  perf-profile.self.cycles-pp.native_sched_clock
>        0.24 ± 39%      -0.1        0.12 ±  7%  perf-profile.self.cycles-pp.__switch_to
>        0.16 ± 42%      -0.1        0.04 ± 60%  perf-profile.self.cycles-pp.update_cfs_rq_h_load
>        0.22 ± 41%      -0.1        0.11 ±  7%  perf-profile.self.cycles-pp.__update_load_avg_se
>        0.20 ± 42%      -0.1        0.09 ±  4%  perf-profile.self.cycles-pp.update_rq_clock
>        0.17 ± 39%      -0.1        0.07        perf-profile.self.cycles-pp.enqueue_task_fair
>        0.16 ± 37%      -0.1        0.06 ±  6%  perf-profile.self.cycles-pp.enqueue_entity
>        0.12 ± 43%      -0.1        0.03 ±100%  perf-profile.self.cycles-pp.__unwind_start
>        0.15 ± 39%      -0.1        0.07 ±  6%  perf-profile.self.cycles-pp.read_tsc
>        0.19 ± 32%      -0.1        0.11 ±  7%  perf-profile.self.cycles-pp.__update_load_avg_cfs_rq
>        0.11 ± 36%      -0.1        0.03 ±100%  perf-profile.self.cycles-pp.switch_mm_irqs_off
>        0.16 ± 38%      -0.1        0.08 ±  8%  perf-profile.self.cycles-pp.update_cfs_group
>        0.13 ± 40%      -0.1        0.05        perf-profile.self.cycles-pp.stack_access_ok
>        0.10 ± 36%      -0.1        0.03 ±100%  perf-profile.self.cycles-pp.account_entity_dequeue
>        0.03 ±100%      +0.0        0.07 ±  7%  perf-profile.self.cycles-pp.native_apic_msr_eoi_write
>        0.03 ±100%      +0.0        0.07 ± 10%  perf-profile.self.cycles-pp.__unlock_page_memcg
>        0.04 ± 59%      +0.0        0.09 ±  4%  perf-profile.self.cycles-pp.__mod_node_page_state
>        0.00            +0.1        0.05        perf-profile.self.cycles-pp.__mod_zone_page_state
>        0.01 ±173%      +0.1        0.07 ± 22%  perf-profile.self.cycles-pp.__mod_lruvec_state
>        0.06 ± 63%      +0.1        0.12 ±  7%  perf-profile.self.cycles-pp.__mod_memcg_state
>        0.02 ±173%      +0.1        0.08 ± 10%  perf-profile.self.cycles-pp.vm_normal_page
>        0.01 ±173%      +0.1        0.08 ±  6%  perf-profile.self.cycles-pp.__tlb_remove_page_size
>        0.02 ±173%      +0.1        0.10 ± 10%  perf-profile.self.cycles-pp.free_pcppages_bulk
>        0.06 ± 71%      +0.1        0.14 ±  9%  perf-profile.self.cycles-pp.__mod_memcg_lruvec_state
>        0.03 ±173%      +0.1        0.14 ± 11%  perf-profile.self.cycles-pp.io_serial_in
>        0.03 ±173%      +0.1        0.15 ± 16%  perf-profile.self.cycles-pp.memcpy_erms
>        0.21 ± 42%      +0.2        0.42 ±  5%  perf-profile.self.cycles-pp.find_lock_entry
>        0.07 ±173%      +0.2        0.30 ±  6%  perf-profile.self.cycles-pp.pagevec_lru_move_fn
>        0.07 ± 64%      +0.2        0.30 ±  2%  perf-profile.self.cycles-pp.wake_up_page_bit
>        0.06 ±173%      +0.2        0.30 ±  9%  perf-profile.self.cycles-pp.mem_cgroup_page_lruvec
>        0.07 ±173%      +0.3        0.36 ±  8%  perf-profile.self.cycles-pp.free_pages_and_swap_cache
>        0.35 ± 43%      +0.3        0.66 ±  3%  perf-profile.self.cycles-pp.find_get_entry
>        0.33 ± 53%      +0.3        0.68 ±  5%  perf-profile.self.cycles-pp.lock_page_memcg
>        0.25 ± 76%      +0.4        0.62 ±  3%  perf-profile.self.cycles-pp.unlock_page_memcg
>        0.16 ±173%      +0.5        0.67 ±  5%  perf-profile.self.cycles-pp.__activate_page
>        0.75 ± 30%      +0.5        1.28 ±  4%  perf-profile.self.cycles-pp.PageHuge
>        0.49 ±150%      +1.7        2.21 ±  4%  perf-profile.self.cycles-pp.release_pages
>        0.57 ±173%      +1.8        2.33 ±  3%  perf-profile.self.cycles-pp.zap_pte_range
>        0.81 ±173%      +2.5        3.32 ±  4%  perf-profile.self.cycles-pp.mark_page_accessed
>        0.76 ±173%      +3.0        3.72 ±  3%  perf-profile.self.cycles-pp.workingset_age_nonresident
>        4.08 ± 52%     +16.8       20.86 ±  3%  perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
> 
> 
>                                                                                  
>                            vm-scalability.time.system_time
>                                                                                  
>    1900 +--------------------------------------------------------------------+
>    1800 |-O  O O  O O O  O O O       O O O  O O O  O O  O O O  O O           |
>         |                       O O                                          |
>    1700 |-+                                                                  |
>    1600 |-+                                                                  |
>         |                                                                    |
>    1500 |-+                                                                  |
>    1400 |-+                                                                  |
>    1300 |-+                                                                  |
>         |                                                                    |
>    1200 |-+                                                                  |
>    1100 |-+                                                                  |
>         |                                                                    |
>    1000 |.+..+.+..+.+.+..+.+.+..+.+..+.+.+..+.+.+..+.+..+.+.+..+.+.+..+.+..+.|
>     900 +--------------------------------------------------------------------+
>                                                                                  
>                                                                                                                                                                  
>                    vm-scalability.time.percent_of_cpu_this_job_got
>                                                                                  
>    1460 +--------------------------------------------------------------------+
>    1440 |-O  O O  O O O  O O O  O O  O O O  O O O  O O  O O O  O O           |
>         |                                                                    |
>    1420 |-+                                                                  |
>    1400 |-+                                                                  |
>         |                                                                    |
>    1380 |-+                                                                  |
>    1360 |-+                                                                  |
>    1340 |-+                                                                  |
>         |                                                                    |
>    1320 |-+                                                                  |
>    1300 |-+                                                                  |
>         |        .+.        .+..        .+..           .+. .+..+.+.  .+.+..+.|
>    1280 |.+..+.+.   +.+..+.+    +.+..+.+    +.+.+..+.+.   +        +.        |
>    1260 +--------------------------------------------------------------------+
>                                                                                  
>                                                                                                                                                                  
>                           vm-scalability.time.elapsed_time
>                                                                                  
>    215 +---------------------------------------------------------------------+
>        | O    O  O O    O    O      O    O O  O O O  O O  O O  O O           |
>    210 |-+  O        O    O    O  O   O                                      |
>    205 |-+                                                                   |
>        |                                                                     |
>    200 |-+                                                                   |
>    195 |-+                                                                   |
>        |                                                                     |
>    190 |-+                                                                   |
>    185 |-+                                                                   |
>        |                                                                     |
>    180 |-+                                                                   |
>    175 |-+         +.                      +..            +          .+.     |
>        |   .+.+.. +  +..+.         .+.+.. +      .+..+. .. +  .+.+.+.   +..+.|
>    170 +---------------------------------------------------------------------+
>                                                                                  
>                                                                                                                                                                  
>                         vm-scalability.time.elapsed_time.max
>                                                                                  
>    215 +---------------------------------------------------------------------+
>        | O    O  O O    O    O      O    O O  O O O  O O  O O  O O           |
>    210 |-+  O        O    O    O  O   O                                      |
>    205 |-+                                                                   |
>        |                                                                     |
>    200 |-+                                                                   |
>    195 |-+                                                                   |
>        |                                                                     |
>    190 |-+                                                                   |
>    185 |-+                                                                   |
>        |                                                                     |
>    180 |-+                                                                   |
>    175 |-+         +.                      +..            +          .+.     |
>        |   .+.+.. +  +..+.         .+.+.. +      .+..+. .. +  .+.+.+.   +..+.|
>    170 +---------------------------------------------------------------------+
>                                                                                  
>                                                                                                                                                                  
>                           vm-scalability.time.minor_page_faults
>                                                                                  
>    4.2e+08 +-----------------------------------------------------------------+
>            |                   O               O    O O  O   O O  O          |
>      4e+08 |-O  O O O O  O O O    O O O  O O O    O        O                 |
>    3.8e+08 |-+                                                               |
>            |                                                                 |
>    3.6e+08 |-+                                                               |
>    3.4e+08 |-+                                                               |
>            |                                                                 |
>    3.2e+08 |-+                                                               |
>      3e+08 |-+                                                               |
>            |                                                                 |
>    2.8e+08 |-+                                                               |
>    2.6e+08 |-+       .+..                   .+.           .+.        .+.     |
>            |.+..+.+.+    +.+.+.+..+.+.+..+.+   +..+.+.+..+   +.+..+.+   +..+.|
>    2.4e+08 +-----------------------------------------------------------------+
>                                                                                  
>                                                                                                                                                                  
>                      vm-scalability.time.voluntary_context_switches
>                                                                                  
>    5.7e+07 +-----------------------------------------------------------------+
>            |          +                      +             +         .+.  .+ |
>    5.6e+07 |-+        :+   +.                :+            :+      .+   +.  +|
>    5.5e+07 |.+   .+  :  + +  +.  .+.    .+  :  +..   .+.. :  +.+..+          |
>            | +..+  + :   +     +.   +.+.  + :     +.+     :                  |
>    5.4e+07 |-+      +                      +             +                   |
>            |                                                                 |
>    5.3e+07 |-+                                                               |
>            |                                                                 |
>    5.2e+07 |-+                                                               |
>    5.1e+07 |-+                                           O                   |
>            |                                   O    O O      O O             |
>      5e+07 |-+                 O                           O      O          |
>            | O    O O O  O O O        O    O O    O                          |
>    4.9e+07 +-----------------------------------------------------------------+
>                                                                                  
>                                                                                                                                                                  
>                    vm-scalability.time.involuntary_context_switches
>                                                                                  
>    45000 +-------------------------------------------------------------------+
>          |      O                                                            |
>    40000 |-+  O                    O                                         |
>          |                                  O    O             O             |
>    35000 |-+      O             O         O           O   O  O   O           |
>          | O         O O O  O O      O O                                     |
>    30000 |-+                                   O   O    O                    |
>          |                                                                   |
>    25000 |-+                                                                 |
>          |                                                                   |
>    20000 |-+     .+..                    .+            .+                    |
>          |.+..+.+     .+.    .+.  .+.+.+.  +    .+.+..+  +  .+.      .+.     |
>    15000 |-+         +   +..+   +.          +..+          +.   +.+..+   +..+.|
>          |                                                                   |
>    10000 +-------------------------------------------------------------------+
>                                                                                  
>                                                                                                                                                                  
>                                 vm-scalability.throughput
>                                                                                  
>    1.65e+07 +----------------------------------------------------------------+
>             |.+.                    .+.          .+.                         |
>     1.6e+07 |-+ +..+.+. .+..+.+.+.+.   +.+.+.. .+   +..+.+. .+..+.+.+.  .+.+.|
>    1.55e+07 |-+        +                      +            +          +.     |
>             |                                                                |
>     1.5e+07 |-+                                                              |
>    1.45e+07 |-+                                                              |
>             |                                                                |
>     1.4e+07 |-+                                                              |
>    1.35e+07 |-+                                                              |
>             |                                                                |
>     1.3e+07 |-+                                                              |
>    1.25e+07 |-O O  O O O O  O O O O  O O O O  O O O O  O   O    O O          |
>             |                                            O   O               |
>     1.2e+07 +----------------------------------------------------------------+
>                                                                                  
>                                                                                                                                                                  
>                                   vm-scalability.median
>                                                                                  
>    1.05e+06 +----------------------------------------------------------------+
>             |                                                                |
>       1e+06 |.+.    .+       .+.+.+..+.   .+..  +.+.    .+   +..             |
>             |   +..+  + .+..+          +.+     +    +..+  + +   +.+.+.  .+.+.|
>             |          +                      +            +          +.     |
>      950000 |-+                                                              |
>             |                                                                |
>      900000 |-+                                                              |
>             |                                                                |
>      850000 |-+                                                              |
>             |                                                                |
>             |                                                                |
>      800000 |-O O  O O O O  O O   O  O O O O  O   O        O    O            |
>             |                   O               O   O  O O   O    O          |
>      750000 +----------------------------------------------------------------+
>                                                                                  
>                                                                                                                                                                  
>                             vm-scalability.median_stddev_
>                                                                                  
>      6 +---------------------------------------------------------------------+
>        | +..         +..+.        +.            +.          +.. .+.  .+      |
>    5.5 |:+  +       +     +..+   +  +          :  +        +   +   +.  :   +.|
>        |:    :   +.+          + +    :   +.+.. :   +   +..+            : ..  |
>      5 |-+   : ..              +     : ..     +     + +                 +    |
>        |      +                       +              +                       |
>    4.5 |-+                                                                   |
>        |                                                                     |
>      4 |-+                                                                   |
>        |                                                                     |
>    3.5 |-+                                           O                       |
>        |    O                              O    O         O      O           |
>      3 |-+       O O O  O O    O  O O O  O    O   O    O    O  O             |
>        | O    O              O                                               |
>    2.5 +---------------------------------------------------------------------+
>                                                                                  
>                                                                                  
> [*] bisect-good sample
> [O] bisect-bad  sample
> 
> ***************************************************************************************************
> lkp-cfl-e1: 16 threads Intel(R) Xeon(R) E-2278G CPU @ 3.40GHz with 32G memory
> =========================================================================================
> compiler/cpufreq_governor/kconfig/nr_task/rootfs/runtime/tbox_group/test/testcase/ucode:
>    gcc-9/performance/x86_64-rhel-8.3/30%/debian-10.4-x86_64-20200603.cgz/300s/lkp-cfl-e1/shell8/unixbench/0xd6
> 
> commit:
>    5925fa68fe (" perf tools fixes for v5.9: 3rd batch")
>    5ef64cc898 ("mm: allow a controlled amount of unfairness in the page lock")
> 
> 5925fa68fe824465 5ef64cc8987a9211d3f3667331b
> ---------------- ---------------------------
>           %stddev     %change         %stddev
>               \          |                \
>       21570            +5.4%      22733        unixbench.score
>     1054019 ±  4%     +25.8%    1325439 ±  3%  unixbench.time.involuntary_context_switches
>      299493 ±  2%     -87.4%      37651 ±  3%  unixbench.time.major_page_faults
>   1.034e+08            +5.6%  1.092e+08        unixbench.time.minor_page_faults
>        1286            +7.3%       1379        unixbench.time.percent_of_cpu_this_job_got
>      334.45           +11.0%     371.24        unixbench.time.system_time
>      477.46            +4.8%     500.52        unixbench.time.user_time
>     3401111            -7.4%    3148880        unixbench.time.voluntary_context_switches
>      815347            +5.4%     859335        unixbench.workload
>        5.09 ±  3%      -5.1        0.00 ±100%  mpstat.cpu.all.iowait%
>        1752 ± 16%     -21.0%       1384 ± 13%  slabinfo.skbuff_head_cache.active_objs
>        1752 ± 16%     -19.2%       1416 ± 11%  slabinfo.skbuff_head_cache.num_objs
>       10037           -16.6%       8374 ±  7%  slabinfo.vmap_area.active_objs
>       10355           -11.8%       9132 ±  6%  slabinfo.vmap_area.num_objs
>       48.00            +5.7%      50.75        vmstat.cpu.sy
>       31.25            +9.6%      34.25        vmstat.cpu.us
>        3.50 ± 24%    -100.0%       0.00        vmstat.procs.b
>       18.75 ±  4%     +17.3%      22.00 ±  3%  vmstat.procs.r
>      111395            -9.5%     100851        vmstat.system.cs
>       36967            +3.2%      38149        vmstat.system.in
>    52268017           -42.8%   29897553 ±  3%  cpuidle.C1.time
>     1117760           -25.5%     833099        cpuidle.C1.usage
>    50982561 ±  2%     -61.2%   19764268 ±  6%  cpuidle.C1E.time
>      769266           -43.4%     435332 ±  3%  cpuidle.C1E.usage
>       74333 ±  3%     -31.2%      51121 ± 16%  cpuidle.C3.usage
>     5602742 ±  4%     -97.7%     129968 ± 28%  cpuidle.POLL.time
>      697760 ±  2%     -98.4%      11332 ± 12%  cpuidle.POLL.usage
>       16352 ±  3%      -8.3%      14993 ±  2%  softirqs.CPU1.SCHED
>       15561           -11.7%      13743        softirqs.CPU10.SCHED
>       15622           -10.2%      14029        softirqs.CPU13.SCHED
>       15418            -8.0%      14188 ±  2%  softirqs.CPU14.SCHED
>       15598            -8.0%      14355 ±  2%  softirqs.CPU15.SCHED
>       15749           -10.1%      14155        softirqs.CPU3.SCHED
>       15847           -10.0%      14262        softirqs.CPU4.SCHED
>      970.25            +2.3%     993.00        proc-vmstat.nr_page_table_pages
>       13460            +5.3%      14177 ±  3%  proc-vmstat.nr_slab_unreclaimable
>    70057163            +4.5%   73199359        proc-vmstat.numa_hit
>    70057163            +4.5%   73199359        proc-vmstat.numa_local
>      100067           +21.2%     121296        proc-vmstat.pgactivate
>    74525416            +4.7%   78002806        proc-vmstat.pgalloc_normal
>   1.041e+08            +5.1%  1.094e+08        proc-vmstat.pgfault
>    74511080            +4.7%   77987815        proc-vmstat.pgfree
>     5126035            +8.5%    5561192        proc-vmstat.pgreuse
>        3425            +7.0%       3664        proc-vmstat.thp_fault_alloc
>     1450159            +5.4%    1528363        proc-vmstat.unevictable_pgs_culled
>       15.80 ±100%    +200.5%      47.50 ± 32%  sched_debug.cfs_rq:/.removed.load_avg.avg
>       61.21 ±100%    +137.4%     145.31 ± 14%  sched_debug.cfs_rq:/.removed.load_avg.stddev
>        1.85 ±130%    +649.4%      13.88 ± 30%  sched_debug.cfs_rq:/.removed.runnable_avg.avg
>       29.62 ±130%    +512.2%     181.38 ± 14%  sched_debug.cfs_rq:/.removed.runnable_avg.max
>        7.17 ±130%    +531.8%      45.30 ± 17%  sched_debug.cfs_rq:/.removed.runnable_avg.stddev
>        1.48 ±170%    +815.3%      13.59 ± 29%  sched_debug.cfs_rq:/.removed.util_avg.avg
>       23.75 ±170%    +649.5%     178.00 ± 13%  sched_debug.cfs_rq:/.removed.util_avg.max
>        5.75 ±170%    +673.5%      44.47 ± 16%  sched_debug.cfs_rq:/.removed.util_avg.stddev
>      124782 ± 12%     +29.5%     161579 ±  9%  sched_debug.cpu.avg_idle.avg
>        5321 ± 44%    +152.1%      13417 ± 11%  sched_debug.cpu.curr->pid.avg
>        7329 ± 36%    +104.2%      14969 ±  8%  sched_debug.cpu.curr->pid.max
>        0.94 ± 16%     +33.3%       1.25 ±  4%  sched_debug.cpu.nr_running.avg
>      213716            -9.1%     194283        sched_debug.cpu.nr_switches.min
>      219.88 ± 16%     -69.1%      67.88 ± 25%  sched_debug.cpu.nr_uninterruptible.max
>     -212.88           -64.7%     -75.25        sched_debug.cpu.nr_uninterruptible.min
>      116.88 ± 11%     -68.1%      37.27 ± 11%  sched_debug.cpu.nr_uninterruptible.stddev
>      215276            -9.2%     195388        sched_debug.cpu.sched_count.avg
>      219021            -9.4%     198334        sched_debug.cpu.sched_count.max
>      212018            -9.6%     191589        sched_debug.cpu.sched_count.min
>       63854           -33.3%      42613 ±  2%  sched_debug.cpu.sched_goidle.avg
>       65292           -33.2%      43641 ±  2%  sched_debug.cpu.sched_goidle.max
>       62644           -33.7%      41522 ±  2%  sched_debug.cpu.sched_goidle.min
>       36980 ±  4%     +15.4%      42667 ±  4%  sched_debug.cpu.ttwu_local.avg
>       37905 ±  2%     +14.8%      43522 ±  2%  sched_debug.cpu.ttwu_local.max
>       36245 ±  5%     +15.1%      41734 ±  5%  sched_debug.cpu.ttwu_local.min
>      479.50 ±122%    +208.1%       1477 ± 66%  interrupts.132:IR-PCI-MSI.2097153-edge.eth1-TxRx-0
>       21616           +25.2%      27062        interrupts.CPU0.RES:Rescheduling_interrupts
>        1431           -65.8%     489.00 ±  4%  interrupts.CPU0.TLB:TLB_shootdowns
>      479.50 ±122%    +208.1%       1477 ± 66%  interrupts.CPU1.132:IR-PCI-MSI.2097153-edge.eth1-TxRx-0
>        1687 ±  7%     -12.9%       1469 ±  4%  interrupts.CPU1.CAL:Function_call_interrupts
>       21784           +23.9%      26998 ±  2%  interrupts.CPU1.RES:Rescheduling_interrupts
>        1399 ±  2%     -64.9%     491.75 ±  7%  interrupts.CPU1.TLB:TLB_shootdowns
>       21969           +22.0%      26811        interrupts.CPU10.RES:Rescheduling_interrupts
>        1388 ±  2%     -64.0%     500.50        interrupts.CPU10.TLB:TLB_shootdowns
>       21807           +24.8%      27212        interrupts.CPU11.RES:Rescheduling_interrupts
>        1367 ±  2%     -64.4%     487.25 ±  5%  interrupts.CPU11.TLB:TLB_shootdowns
>       21738 ±  2%     +26.4%      27485        interrupts.CPU12.RES:Rescheduling_interrupts
>        1376           -62.3%     518.50 ±  9%  interrupts.CPU12.TLB:TLB_shootdowns
>       21766           +25.0%      27217        interrupts.CPU13.RES:Rescheduling_interrupts
>        1425           -65.6%     490.75 ±  9%  interrupts.CPU13.TLB:TLB_shootdowns
>        1557 ±  4%      -9.7%       1406 ±  6%  interrupts.CPU14.CAL:Function_call_interrupts
>       21777           +26.0%      27447        interrupts.CPU14.RES:Rescheduling_interrupts
>        1426 ±  2%     -64.9%     500.25 ±  7%  interrupts.CPU14.TLB:TLB_shootdowns
>       21639 ±  2%     +27.8%      27653        interrupts.CPU15.RES:Rescheduling_interrupts
>        1441 ±  3%     -64.6%     510.75 ±  6%  interrupts.CPU15.TLB:TLB_shootdowns
>       21908           +24.0%      27161        interrupts.CPU2.RES:Rescheduling_interrupts
>        1415           -64.5%     503.00 ±  2%  interrupts.CPU2.TLB:TLB_shootdowns
>       21904           +22.4%      26804        interrupts.CPU3.RES:Rescheduling_interrupts
>        1474           -65.6%     507.25 ±  8%  interrupts.CPU3.TLB:TLB_shootdowns
>       21534 ±  2%     +26.2%      27181        interrupts.CPU4.RES:Rescheduling_interrupts
>        1356           -62.2%     513.00 ±  6%  interrupts.CPU4.TLB:TLB_shootdowns
>       21836           +23.9%      27045        interrupts.CPU5.RES:Rescheduling_interrupts
>        1407 ±  2%     -63.9%     508.50 ±  2%  interrupts.CPU5.TLB:TLB_shootdowns
>       21999           +23.3%      27125        interrupts.CPU6.RES:Rescheduling_interrupts
>        1403 ±  4%     -62.7%     524.00 ±  9%  interrupts.CPU6.TLB:TLB_shootdowns
>        1557 ±  4%     -11.0%       1385 ±  4%  interrupts.CPU7.CAL:Function_call_interrupts
>       21508 ±  2%     +26.1%      27111        interrupts.CPU7.RES:Rescheduling_interrupts
>        1417 ±  5%     -64.1%     509.50 ±  6%  interrupts.CPU7.TLB:TLB_shootdowns
>       21905           +25.2%      27429        interrupts.CPU8.RES:Rescheduling_interrupts
>        1411 ±  2%     -65.4%     488.50 ±  8%  interrupts.CPU8.TLB:TLB_shootdowns
>       21904           +24.7%      27307        interrupts.CPU9.RES:Rescheduling_interrupts
>        1388 ±  2%     -63.7%     503.50        interrupts.CPU9.TLB:TLB_shootdowns
>      348600           +24.8%     435055        interrupts.RES:Rescheduling_interrupts
>       22530           -64.3%       8046 ±  4%  interrupts.TLB:TLB_shootdowns
>       48.16            -1.7%      47.32        perf-stat.i.MPKI
>   9.687e+09            +5.1%  1.019e+10        perf-stat.i.branch-instructions
>   2.126e+08            +4.6%  2.224e+08        perf-stat.i.branch-misses
>        4.44            +0.2        4.60        perf-stat.i.cache-miss-rate%
>    94624278            +7.1%  1.013e+08        perf-stat.i.cache-misses
>   2.382e+09            +3.3%  2.461e+09        perf-stat.i.cache-references
>      114789            -9.1%     104363        perf-stat.i.context-switches
>   5.294e+10            +5.8%  5.601e+10        perf-stat.i.cpu-cycles
>       19853           -22.2%      15448        perf-stat.i.cpu-migrations
>      569.61            -1.9%     558.71        perf-stat.i.cycles-between-cache-misses
>   1.223e+10            +5.1%  1.285e+10        perf-stat.i.dTLB-loads
>     3655243            +4.1%    3805877        perf-stat.i.dTLB-store-misses
>   7.024e+09            +5.1%  7.383e+09        perf-stat.i.dTLB-stores
>    10344903            +3.7%   10732085        perf-stat.i.iTLB-load-misses
>     8031239            +1.9%    8185952        perf-stat.i.iTLB-loads
>   4.759e+10            +5.2%  5.006e+10        perf-stat.i.instructions
>        5236            +1.2%       5299        perf-stat.i.instructions-per-iTLB-miss
>        4684 ±  2%     -87.4%     589.00 ±  3%  perf-stat.i.major-faults
>        3.31            +5.8%       3.50        perf-stat.i.metric.GHz
>        1960            +5.0%       2058        perf-stat.i.metric.M/sec
>     1588100            +5.6%    1677762        perf-stat.i.minor-faults
>     5071078            +8.5%    5500804        perf-stat.i.node-loads
>    31239619            +7.2%   33482613        perf-stat.i.node-stores
>     1592784            +5.4%    1678351        perf-stat.i.page-faults
>       50.05            -1.8%      49.15        perf-stat.overall.MPKI
>        3.97            +0.1        4.12        perf-stat.overall.cache-miss-rate%
>      559.44            -1.2%     552.70        perf-stat.overall.cycles-between-cache-misses
>        4600            +1.4%       4664        perf-stat.overall.instructions-per-iTLB-miss
>   9.533e+09            +5.1%  1.002e+10        perf-stat.ps.branch-instructions
>   2.093e+08            +4.6%  2.189e+08        perf-stat.ps.branch-misses
>    93122368            +7.1%   99714732        perf-stat.ps.cache-misses
>   2.344e+09            +3.3%  2.421e+09        perf-stat.ps.cache-references
>      112962            -9.1%     102685        perf-stat.ps.context-switches
>    5.21e+10            +5.8%  5.511e+10        perf-stat.ps.cpu-cycles
>       19537           -22.2%      15200        perf-stat.ps.cpu-migrations
>   1.203e+10            +5.1%  1.264e+10        perf-stat.ps.dTLB-loads
>     3597096            +4.1%    3744712        perf-stat.ps.dTLB-store-misses
>   6.913e+09            +5.1%  7.264e+09        perf-stat.ps.dTLB-stores
>    10180397            +3.7%   10559643        perf-stat.ps.iTLB-load-misses
>     7903463            +1.9%    8054357        perf-stat.ps.iTLB-loads
>   4.684e+10            +5.2%  4.926e+10        perf-stat.ps.instructions
>        4609 ±  2%     -87.4%     579.53 ±  3%  perf-stat.ps.major-faults
>     1562827            +5.6%    1650780        perf-stat.ps.minor-faults
>     4990492            +8.5%    5412486        perf-stat.ps.node-loads
>    30742642            +7.2%   32944203        perf-stat.ps.node-stores
>     1567436            +5.4%    1651360        perf-stat.ps.page-faults
>   3.004e+12            +5.2%  3.159e+12        perf-stat.total.instructions
>       29.27 ± 57%     -17.3       11.93 ±173%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.write
>       29.27 ± 57%     -17.3       11.93 ±173%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
>       29.27 ± 57%     -17.3       11.93 ±173%  perf-profile.calltrace.cycles-pp.write
>       29.27 ± 57%     -17.3       11.93 ±173%  perf-profile.calltrace.cycles-pp.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
>       29.27 ± 57%     -17.3       11.93 ±173%  perf-profile.calltrace.cycles-pp.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
>       29.27 ± 57%     -17.3       11.93 ±173%  perf-profile.calltrace.cycles-pp.new_sync_write.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
>       29.09 ± 57%     -17.2       11.93 ±173%  perf-profile.calltrace.cycles-pp.devkmsg_write.cold.new_sync_write.vfs_write.ksys_write.do_syscall_64
>       29.09 ± 57%     -17.2       11.93 ±173%  perf-profile.calltrace.cycles-pp.devkmsg_emit.devkmsg_write.cold.new_sync_write.vfs_write.ksys_write
>       29.09 ± 57%     -17.2       11.93 ±173%  perf-profile.calltrace.cycles-pp.vprintk_emit.devkmsg_emit.devkmsg_write.cold.new_sync_write.vfs_write
>       29.09 ± 57%     -17.2       11.93 ±173%  perf-profile.calltrace.cycles-pp.console_unlock.vprintk_emit.devkmsg_emit.devkmsg_write.cold.new_sync_write
>       25.68 ± 57%     -14.9       10.79 ±173%  perf-profile.calltrace.cycles-pp.serial8250_console_write.console_unlock.vprintk_emit.devkmsg_emit.devkmsg_write.cold
>       24.54 ± 57%     -14.0       10.51 ±173%  perf-profile.calltrace.cycles-pp.uart_console_write.serial8250_console_write.console_unlock.vprintk_emit.devkmsg_emit
>       15.00 ± 46%     -11.4        3.59 ±106%  perf-profile.calltrace.cycles-pp.do_group_exit.get_signal.arch_do_signal.exit_to_user_mode_prepare.syscall_exit_to_user_mode
>       15.00 ± 46%     -11.4        3.59 ±106%  perf-profile.calltrace.cycles-pp.do_exit.do_group_exit.get_signal.arch_do_signal.exit_to_user_mode_prepare
>       15.00 ± 46%     -11.4        3.59 ±106%  perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.entry_SYSCALL_64_after_hwframe
>       15.00 ± 46%     -11.4        3.59 ±106%  perf-profile.calltrace.cycles-pp.exit_to_user_mode_prepare.syscall_exit_to_user_mode.entry_SYSCALL_64_after_hwframe
>       15.00 ± 46%     -11.4        3.59 ±106%  perf-profile.calltrace.cycles-pp.arch_do_signal.exit_to_user_mode_prepare.syscall_exit_to_user_mode.entry_SYSCALL_64_after_hwframe
>       15.00 ± 46%     -11.4        3.59 ±106%  perf-profile.calltrace.cycles-pp.get_signal.arch_do_signal.exit_to_user_mode_prepare.syscall_exit_to_user_mode.entry_SYSCALL_64_after_hwframe
>       20.19 ± 58%     -11.1        9.09 ±173%  perf-profile.calltrace.cycles-pp.wait_for_xmitr.serial8250_console_putchar.uart_console_write.serial8250_console_write.console_unlock
>       20.19 ± 58%     -11.1        9.09 ±173%  perf-profile.calltrace.cycles-pp.serial8250_console_putchar.uart_console_write.serial8250_console_write.console_unlock.vprintk_emit
>       13.48 ± 48%     -10.9        2.58 ±109%  perf-profile.calltrace.cycles-pp.perf_release.__fput.task_work_run.do_exit.do_group_exit
>       13.48 ± 48%     -10.9        2.58 ±109%  perf-profile.calltrace.cycles-pp.perf_event_release_kernel.perf_release.__fput.task_work_run.do_exit
>       16.11 ± 40%     -10.4        5.73 ±114%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe
>       13.48 ± 48%      -9.9        3.59 ±106%  perf-profile.calltrace.cycles-pp.task_work_run.do_exit.do_group_exit.get_signal.arch_do_signal
>       13.48 ± 48%      -9.9        3.59 ±106%  perf-profile.calltrace.cycles-pp.__fput.task_work_run.do_exit.do_group_exit.get_signal
>       18.44 ± 58%      -9.6        8.81 ±173%  perf-profile.calltrace.cycles-pp.io_serial_in.wait_for_xmitr.serial8250_console_putchar.uart_console_write.serial8250_console_write
>        4.35 ± 76%      -3.5        0.85 ±173%  perf-profile.calltrace.cycles-pp.io_serial_out.uart_console_write.serial8250_console_write.console_unlock.vprintk_emit
>       47.23 ± 27%     -26.2       21.02 ± 78%  perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
>       29.27 ± 57%     -17.3       11.93 ±173%  perf-profile.children.cycles-pp.write
>       29.27 ± 57%     -17.3       11.93 ±173%  perf-profile.children.cycles-pp.ksys_write
>       29.27 ± 57%     -17.3       11.93 ±173%  perf-profile.children.cycles-pp.vfs_write
>       29.27 ± 57%     -17.3       11.93 ±173%  perf-profile.children.cycles-pp.new_sync_write
>       29.09 ± 57%     -17.2       11.93 ±173%  perf-profile.children.cycles-pp.devkmsg_write.cold
>       29.09 ± 57%     -17.2       11.93 ±173%  perf-profile.children.cycles-pp.devkmsg_emit
>       29.09 ± 57%     -17.2       11.93 ±173%  perf-profile.children.cycles-pp.vprintk_emit
>       29.09 ± 57%     -17.2       11.93 ±173%  perf-profile.children.cycles-pp.console_unlock
>       25.68 ± 57%     -14.9       10.79 ±173%  perf-profile.children.cycles-pp.serial8250_console_write
>       24.54 ± 57%     -14.3       10.23 ±173%  perf-profile.children.cycles-pp.uart_console_write
>       15.19 ± 44%     -11.6        3.59 ±106%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode
>       15.19 ± 44%     -11.6        3.59 ±106%  perf-profile.children.cycles-pp.exit_to_user_mode_prepare
>       15.74 ± 41%     -11.6        4.15 ±112%  perf-profile.children.cycles-pp.do_group_exit
>       15.74 ± 41%     -11.6        4.15 ±112%  perf-profile.children.cycles-pp.do_exit
>       21.15 ± 58%     -11.5        9.66 ±173%  perf-profile.children.cycles-pp.wait_for_xmitr
>       15.00 ± 46%     -11.4        3.59 ±106%  perf-profile.children.cycles-pp.arch_do_signal
>       15.00 ± 46%     -11.4        3.59 ±106%  perf-profile.children.cycles-pp.get_signal
>       20.19 ± 58%     -11.1        9.09 ±173%  perf-profile.children.cycles-pp.serial8250_console_putchar
>       13.48 ± 48%     -10.9        2.58 ±109%  perf-profile.children.cycles-pp.perf_release
>       13.48 ± 48%     -10.9        2.58 ±109%  perf-profile.children.cycles-pp.perf_event_release_kernel
>       19.40 ± 58%     -10.0        9.38 ±173%  perf-profile.children.cycles-pp.io_serial_in
>       13.48 ± 48%      -9.9        3.59 ±106%  perf-profile.children.cycles-pp.task_work_run
>       13.48 ± 48%      -9.9        3.59 ±106%  perf-profile.children.cycles-pp.__fput
>        4.54 ± 79%      -3.4        1.14 ±173%  perf-profile.children.cycles-pp.io_serial_out
>       19.40 ± 58%     -10.0        9.38 ±173%  perf-profile.self.cycles-pp.io_serial_in
>        4.54 ± 79%      -3.4        1.14 ±173%  perf-profile.self.cycles-pp.io_serial_out
> 
> 
> 
> ***************************************************************************************************
> lkp-csl-2ap3: 192 threads Intel(R) Xeon(R) Platinum 9242 CPU @ 2.30GHz with 192G memory
> =========================================================================================
> compiler/cpufreq_governor/kconfig/mode/nr_task/rootfs/tbox_group/test/testcase/ucode:
>    gcc-9/performance/x86_64-rhel-8.3/thread/50%/debian-10.4-x86_64-20200603.cgz/lkp-csl-2ap3/readseek2/will-it-scale/0x5002f01
> 
> commit:
>    5925fa68fe (" perf tools fixes for v5.9: 3rd batch")
>    5ef64cc898 ("mm: allow a controlled amount of unfairness in the page lock")
> 
> 5925fa68fe824465 5ef64cc8987a9211d3f3667331b
> ---------------- ---------------------------
>           %stddev     %change         %stddev
>               \          |                \
>        1266          +688.3%       9979 ±  3%  will-it-scale.per_thread_ops
>      121587          +688.0%     958052 ±  3%  will-it-scale.workload
>       71.50 ±  5%     -28.3%      51.25        vmstat.cpu.id
>       25.00 ± 18%    -100.0%       0.00        vmstat.cpu.wa
>        1.00         +8975.0%      90.75        vmstat.procs.r
>   1.225e+09 ± 41%     -63.7%  4.441e+08 ± 69%  cpuidle.C1.time
>   1.272e+08 ± 18%     -43.3%   72207404 ±  7%  cpuidle.C1E.usage
>    26464356 ± 10%     +69.2%   44765776 ± 10%  cpuidle.POLL.time
>     2008351 ± 16%    +641.3%   14887271 ± 10%  cpuidle.POLL.usage
>        7829 ±  6%   +1248.0%     105533 ±  5%  meminfo.Active
>        7825 ±  6%   +1248.6%     105529 ±  5%  meminfo.Active(anon)
>       36955           +11.8%      41313        meminfo.Mapped
>       27224          +368.3%     127479 ±  4%  meminfo.Shmem
>       31081           -59.8%      12502 ±104%  numa-numastat.node1.other_node
>      220546 ±  7%     -28.7%     157349 ±  3%  numa-numastat.node2.local_node
>      251604 ±  6%     -28.2%     180707 ±  7%  numa-numastat.node2.numa_hit
>        7880 ±170%    +294.3%      31072        numa-numastat.node3.other_node
>       71.78 ±  6%     -20.4       51.40        mpstat.cpu.all.idle%
>       25.99 ± 16%     -26.0        0.03 ±105%  mpstat.cpu.all.iowait%
>        1.53 ±  3%      -1.0        0.52 ±  2%  mpstat.cpu.all.irq%
>        0.11 ±  2%      -0.0        0.07 ±  3%  mpstat.cpu.all.soft%
>        0.53 ±  2%     +47.4       47.91        mpstat.cpu.all.sys%
>        0.05            +0.0        0.09 ± 22%  mpstat.cpu.all.usr%
>        1988 ± 18%     +31.3%       2610 ± 20%  numa-vmstat.node0.nr_mapped
>       77149 ± 37%     -63.9%      27823 ± 25%  numa-vmstat.node0.numa_other
>      179.00 ±130%    +232.8%     595.75 ± 56%  numa-vmstat.node1.nr_active_anon
>      179.00 ±130%    +232.8%     595.75 ± 56%  numa-vmstat.node1.nr_zone_active_anon
>        1260 ± 23%   +1900.9%      25226 ±  5%  numa-vmstat.node3.nr_active_anon
>       71809           +34.9%      96880 ±  3%  numa-vmstat.node3.nr_file_pages
>        1845 ± 34%   +1367.1%      27068 ± 11%  numa-vmstat.node3.nr_shmem
>        9936 ±  9%     -42.1%       5758 ±  4%  numa-vmstat.node3.nr_slab_reclaimable
>        1260 ± 23%   +1900.8%      25225 ±  5%  numa-vmstat.node3.nr_zone_active_anon
>       65717 ± 43%     +87.3%     123087        numa-vmstat.node3.numa_other
>        1181 ± 13%     +28.6%       1520 ±  5%  slabinfo.dmaengine-unmap-16.active_objs
>        1181 ± 13%     +28.6%       1520 ±  5%  slabinfo.dmaengine-unmap-16.num_objs
>        6785 ±  9%     +24.7%       8464 ±  2%  slabinfo.files_cache.active_objs
>        6785 ±  9%     +24.7%       8464 ±  2%  slabinfo.files_cache.num_objs
>        3748 ±  5%     +13.8%       4267 ±  2%  slabinfo.sighand_cache.active_objs
>        3793 ±  5%     +13.4%       4300 ±  2%  slabinfo.sighand_cache.num_objs
>      829.50 ± 14%     +23.8%       1027 ±  5%  slabinfo.skbuff_fclone_cache.active_objs
>      829.50 ± 14%     +23.8%       1027 ±  5%  slabinfo.skbuff_fclone_cache.num_objs
>       25690           -17.0%      21326        slabinfo.vmap_area.active_objs
>       25696           -17.0%      21331        slabinfo.vmap_area.num_objs
>        7835 ± 19%     +30.5%      10227 ± 22%  numa-meminfo.node0.Mapped
>      718.00 ±129%    +232.6%       2387 ± 56%  numa-meminfo.node1.Active
>      718.00 ±129%    +232.1%       2384 ± 56%  numa-meminfo.node1.Active(anon)
>        5038 ± 23%   +1904.1%     100980 ±  5%  numa-meminfo.node3.Active
>        5035 ± 23%   +1905.3%     100980 ±  5%  numa-meminfo.node3.Active(anon)
>      287239           +34.9%     387535 ±  3%  numa-meminfo.node3.FilePages
>       39748 ±  9%     -42.0%      23046 ±  4%  numa-meminfo.node3.KReclaimable
>      789152 ±  4%      +7.8%     850631 ±  6%  numa-meminfo.node3.MemUsed
>       39748 ±  9%     -42.0%      23046 ±  4%  numa-meminfo.node3.SReclaimable
>        7378 ± 34%   +1367.6%     108288 ± 11%  numa-meminfo.node3.Shmem
>      112975 ±  7%     -22.4%      87674 ± 10%  numa-meminfo.node3.Slab
>        1955 ±  6%   +1249.2%      26376 ±  5%  proc-vmstat.nr_active_anon
>      292548            +8.6%     317683        proc-vmstat.nr_file_pages
>        9365           +12.1%      10501        proc-vmstat.nr_mapped
>        6805          +368.3%      31870 ±  4%  proc-vmstat.nr_shmem
>       31824            +1.8%      32389        proc-vmstat.nr_slab_reclaimable
>        1955 ±  6%   +1249.2%      26376 ±  5%  proc-vmstat.nr_zone_active_anon
>        2404 ± 12%    +107.0%       4976 ± 49%  proc-vmstat.numa_hint_faults_local
>      996995            +3.3%    1030379        proc-vmstat.numa_hit
>      903561            +3.7%     936976        proc-vmstat.numa_local
>       92254 ± 13%     +44.3%     133088 ± 10%  proc-vmstat.numa_pte_updates
>        1519 ± 24%   +1609.0%      25963 ±  6%  proc-vmstat.pgactivate
>     1084057            +3.1%    1117729        proc-vmstat.pgalloc_normal
>     1156577            +4.0%    1202453        proc-vmstat.pgfault
>      170.02 ± 57%   +8564.4%      14731 ± 41%  sched_debug.cfs_rq:/.MIN_vruntime.avg
>       16736 ± 45%  +11393.3%    1923555 ± 36%  sched_debug.cfs_rq:/.MIN_vruntime.max
>        1596 ± 49%  +10399.2%     167614 ± 39%  sched_debug.cfs_rq:/.MIN_vruntime.stddev
>        1242 ± 10%   +5367.8%      67950 ±  8%  sched_debug.cfs_rq:/.exec_clock.avg
>        3496 ± 16%   +3299.1%     118860 ±  6%  sched_debug.cfs_rq:/.exec_clock.max
>      307.99 ± 22%   +5682.7%      17809 ± 31%  sched_debug.cfs_rq:/.exec_clock.min
>      443.83 ±  8%   +2973.4%      13640 ±  4%  sched_debug.cfs_rq:/.exec_clock.stddev
>      466502 ± 18%     -85.2%      69202 ±129%  sched_debug.cfs_rq:/.load.max
>       56674 ± 17%     -82.3%      10016 ± 67%  sched_debug.cfs_rq:/.load.stddev
>      553.96 ±  7%     -54.4%     252.48 ± 39%  sched_debug.cfs_rq:/.load_avg.max
>       53.50 ± 10%     -43.5%      30.25 ± 38%  sched_debug.cfs_rq:/.load_avg.stddev
>      170.02 ± 57%   +8564.4%      14731 ± 41%  sched_debug.cfs_rq:/.max_vruntime.avg
>       16736 ± 45%  +11393.3%    1923555 ± 36%  sched_debug.cfs_rq:/.max_vruntime.max
>        1596 ± 49%  +10399.2%     167614 ± 39%  sched_debug.cfs_rq:/.max_vruntime.stddev
>       33466 ± 25%  +17200.5%    5789901 ±  8%  sched_debug.cfs_rq:/.min_vruntime.avg
>       60233 ± 19%  +16685.1%   10110254 ±  6%  sched_debug.cfs_rq:/.min_vruntime.max
>       20331 ± 26%   +7420.2%    1528965 ± 32%  sched_debug.cfs_rq:/.min_vruntime.min
>        4797 ± 11%  +24047.1%    1158377 ±  4%  sched_debug.cfs_rq:/.min_vruntime.stddev
>        0.03 ± 15%   +1586.0%       0.53 ±  6%  sched_debug.cfs_rq:/.nr_running.avg
>        0.17 ±  8%    +155.9%       0.43 ±  2%  sched_debug.cfs_rq:/.nr_running.stddev
>        0.13 ±103%    +263.7%       0.49 ± 18%  sched_debug.cfs_rq:/.nr_spread_over.avg
>        1.13 ± 63%    +237.5%       3.82 ± 15%  sched_debug.cfs_rq:/.nr_spread_over.max
>        0.17 ± 89%    +337.2%       0.76 ± 11%  sched_debug.cfs_rq:/.nr_spread_over.stddev
>       31.86 ± 14%   +1420.5%     484.49 ±  7%  sched_debug.cfs_rq:/.runnable_avg.avg
>      702.53 ±  4%     +33.6%     938.62 ±  5%  sched_debug.cfs_rq:/.runnable_avg.max
>       86.88 ±  7%    +323.3%     367.76 ±  2%  sched_debug.cfs_rq:/.runnable_avg.stddev
>       -1332        -1.7e+05%    2293744 ± 23%  sched_debug.cfs_rq:/.spread0.avg
>       25416 ± 45%  +25922.7%    6614096 ± 10%  sched_debug.cfs_rq:/.spread0.max
>      -14452        +13512.9%   -1967432        sched_debug.cfs_rq:/.spread0.min
>        4799 ± 11%  +24038.1%    1158452 ±  4%  sched_debug.cfs_rq:/.spread0.stddev
>       31.73 ± 14%   +1425.9%     484.20 ±  7%  sched_debug.cfs_rq:/.util_avg.avg
>      702.49 ±  4%     +33.6%     938.58 ±  5%  sched_debug.cfs_rq:/.util_avg.max
>       86.82 ±  7%    +323.6%     367.72 ±  2%  sched_debug.cfs_rq:/.util_avg.stddev
>        3.25 ± 12%  +13255.4%     434.48 ±  6%  sched_debug.cfs_rq:/.util_est_enqueued.avg
>      259.20 ±  5%    +242.9%     888.80        sched_debug.cfs_rq:/.util_est_enqueued.max
>       24.35 ±  6%   +1360.2%     355.60        sched_debug.cfs_rq:/.util_est_enqueued.stddev
>      853642           -37.8%     530714        sched_debug.cpu.avg_idle.avg
>       75902 ± 12%     -80.9%      14497 ± 29%  sched_debug.cpu.avg_idle.min
>      177509 ±  4%    +147.6%     439550        sched_debug.cpu.avg_idle.stddev
>       96.07 ±  9%   +1468.1%       1506 ±  2%  sched_debug.cpu.curr->pid.avg
>      720.78 ±  4%    +132.6%       1676        sched_debug.cpu.curr->pid.stddev
>        0.00 ± 20%    +322.0%       0.00 ± 27%  sched_debug.cpu.next_balance.stddev
>        0.02 ±  8%   +1657.9%       0.41        sched_debug.cpu.nr_running.avg
>        0.15 ±  4%    +207.4%       0.45        sched_debug.cpu.nr_running.stddev
>       49550 ±  6%     -31.8%      33787 ± 10%  sched_debug.cpu.nr_switches.stddev
>        0.40           -94.3%       0.02 ± 42%  sched_debug.cpu.nr_uninterruptible.avg
>       49442 ±  6%     -31.9%      33686 ± 10%  sched_debug.cpu.sched_count.stddev
>       24716 ±  6%     -31.9%      16830 ± 10%  sched_debug.cpu.sched_goidle.stddev
>       24764 ±  6%     -32.3%      16770 ± 10%  sched_debug.cpu.ttwu_count.stddev
>        4432 ± 40%     -60.8%       1735 ± 26%  sched_debug.cpu.ttwu_local.max
>      337.31 ± 35%     -54.2%     154.44 ± 23%  sched_debug.cpu.ttwu_local.stddev
>       17.43           -85.9%       2.46 ±  7%  perf-stat.i.MPKI
>   7.452e+08          +805.2%  6.745e+09        perf-stat.i.branch-instructions
>        1.69            -1.3        0.34 ±  3%  perf-stat.i.branch-miss-rate%
>    13281209           +71.2%   22738819 ±  2%  perf-stat.i.branch-misses
>       13.68 ±  6%     +40.3       54.02 ±  2%  perf-stat.i.cache-miss-rate%
>     8061015 ±  8%    +357.2%   36853851 ±  9%  perf-stat.i.cache-misses
>    59267552 ±  2%     +15.1%   68218277 ±  7%  perf-stat.i.cache-references
>        3.22 ±  2%    +221.8%      10.36        perf-stat.i.cpi
>   1.103e+10 ±  2%   +2512.2%  2.882e+11        perf-stat.i.cpu-cycles
>      223.55           +11.5%     249.23        perf-stat.i.cpu-migrations
>        1409 ±  5%    +459.4%       7886 ± 10%  perf-stat.i.cycles-between-cache-misses
>        0.00 ±  3%      -0.0        0.00 ±  4%  perf-stat.i.dTLB-load-miss-rate%
>       42216 ±  6%    +374.4%     200286 ±  4%  perf-stat.i.dTLB-load-misses
>   9.242e+08          +667.5%  7.093e+09        perf-stat.i.dTLB-loads
>        0.00            -0.0        0.00 ±  3%  perf-stat.i.dTLB-store-miss-rate%
>       13269 ±  2%     +23.8%      16421        perf-stat.i.dTLB-store-misses
>   5.132e+08           +64.4%  8.439e+08 ±  2%  perf-stat.i.dTLB-stores
>       57.39           +14.0       71.43        perf-stat.i.iTLB-load-miss-rate%
>     7475200 ±  2%     +51.8%   11347314 ±  4%  perf-stat.i.iTLB-load-misses
>     5545950           -18.1%    4541031 ±  7%  perf-stat.i.iTLB-loads
>   3.499e+09          +694.7%  2.781e+10        perf-stat.i.instructions
>      470.84          +421.6%       2455 ±  4%  perf-stat.i.instructions-per-iTLB-miss
>        0.31 ±  2%     -68.9%       0.10        perf-stat.i.ipc
>        0.69 ±  3%     +55.3%       1.07 ±  5%  perf-stat.i.major-faults
>        0.06 ±  2%   +2510.5%       1.50        perf-stat.i.metric.GHz
>        0.44 ± 14%    +128.0%       1.01 ±  2%  perf-stat.i.metric.K/sec
>       11.72          +556.3%      76.89        perf-stat.i.metric.M/sec
>        3716            +4.5%       3884        perf-stat.i.minor-faults
>       96.24            +2.0       98.23        perf-stat.i.node-load-miss-rate%
>     1506224 ±  8%    +563.7%    9996147        perf-stat.i.node-load-misses
>       59182 ± 20%    +202.2%     178865 ±  2%  perf-stat.i.node-loads
>       97.87            +1.9       99.75        perf-stat.i.node-store-miss-rate%
>      406316 ±  6%   +1532.3%    6632290        perf-stat.i.node-store-misses
>        9574 ± 16%     +26.7%      12131 ±  8%  perf-stat.i.node-stores
>        3717            +4.5%       3885        perf-stat.i.page-faults
>       16.94           -85.5%       2.45 ±  7%  perf-stat.overall.MPKI
>        1.78            -1.4        0.34 ±  3%  perf-stat.overall.branch-miss-rate%
>       13.59 ±  6%     +40.3       53.94 ±  2%  perf-stat.overall.cache-miss-rate%
>        3.15 ±  2%    +228.8%      10.37        perf-stat.overall.cpi
>        1374 ±  5%    +474.4%       7895 ± 10%  perf-stat.overall.cycles-between-cache-misses
>        0.00 ±  6%      -0.0        0.00 ±  4%  perf-stat.overall.dTLB-load-miss-rate%
>        0.00            -0.0        0.00 ±  3%  perf-stat.overall.dTLB-store-miss-rate%
>       57.40           +14.1       71.46        perf-stat.overall.iTLB-load-miss-rate%
>      468.36 ±  2%    +424.0%       2454 ±  4%  perf-stat.overall.instructions-per-iTLB-miss
>        0.32 ±  2%     -69.6%       0.10        perf-stat.overall.ipc
>       96.24            +2.0       98.24        perf-stat.overall.node-load-miss-rate%
>       97.70            +2.1       99.82        perf-stat.overall.node-store-miss-rate%
>   7.428e+08          +804.5%  6.719e+09        perf-stat.ps.branch-instructions
>    13241794           +70.8%   22612139 ±  2%  perf-stat.ps.branch-misses
>     8035056 ±  8%    +356.9%   36710582 ±  9%  perf-stat.ps.cache-misses
>    59071874 ±  2%     +15.0%   67947551 ±  7%  perf-stat.ps.cache-references
>     1.1e+10 ±  2%   +2510.8%  2.871e+11        perf-stat.ps.cpu-cycles
>      222.96           +11.4%     248.34        perf-stat.ps.cpu-migrations
>       42122 ±  6%    +373.7%     199521 ±  4%  perf-stat.ps.dTLB-load-misses
>   9.212e+08          +667.0%  7.065e+09        perf-stat.ps.dTLB-loads
>       13235 ±  2%     +23.4%      16333        perf-stat.ps.dTLB-store-misses
>   5.116e+08           +64.3%  8.404e+08 ±  2%  perf-stat.ps.dTLB-stores
>     7450273 ±  2%     +51.7%   11304013 ±  4%  perf-stat.ps.iTLB-load-misses
>     5527433           -18.2%    4522978 ±  7%  perf-stat.ps.iTLB-loads
>   3.488e+09          +694.1%   2.77e+10        perf-stat.ps.instructions
>        0.69 ±  3%     +53.2%       1.05 ±  5%  perf-stat.ps.major-faults
>        3705            +4.3%       3862        perf-stat.ps.minor-faults
>     1501438 ±  8%    +563.2%    9958261        perf-stat.ps.node-load-misses
>       59037 ± 20%    +202.0%     178306 ±  2%  perf-stat.ps.node-loads
>      405024 ±  6%   +1531.3%    6607029        perf-stat.ps.node-store-misses
>        9563 ± 16%     +26.0%      12047 ±  8%  perf-stat.ps.node-stores
>        3705            +4.3%       3863        perf-stat.ps.page-faults
>   1.053e+12          +693.1%  8.355e+12        perf-stat.total.instructions
>       89.08           -56.7       32.42 ± 20%  perf-profile.calltrace.cycles-pp.secondary_startup_64
>       88.49           -56.3       32.22 ± 20%  perf-profile.calltrace.cycles-pp.start_secondary.secondary_startup_64
>       88.48           -56.3       32.22 ± 20%  perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.secondary_startup_64
>       88.43           -56.2       32.22 ± 20%  perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64
>       71.64           -39.7       31.95 ± 20%  perf-profile.calltrace.cycles-pp.cpuidle_enter.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64
>       67.10           -35.2       31.95 ± 20%  perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry.start_secondary
>       25.60 ±  4%     -25.6        0.00        perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry
>       14.64 ±  7%     -14.6        0.00        perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter.do_idle
>       45.20           -13.4       31.77 ± 20%  perf-profile.calltrace.cycles-pp.intel_idle.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry
>       12.89 ±  2%     -12.9        0.00        perf-profile.calltrace.cycles-pp.menu_select.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64
>        9.12 ±  6%      -9.1        0.00        perf-profile.calltrace.cycles-pp.asm_call_on_stack.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter
>        9.08 ±  6%      -9.1        0.00        perf-profile.calltrace.cycles-pp.__sysvec_apic_timer_interrupt.asm_call_on_stack.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state
>        8.88 ±  6%      -8.9        0.00        perf-profile.calltrace.cycles-pp.hrtimer_interrupt.__sysvec_apic_timer_interrupt.asm_call_on_stack.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
>        2.17           +25.8       27.93 ± 10%  perf-profile.calltrace.cycles-pp.__lock_page.find_lock_entry.shmem_getpage_gfp.shmem_file_read_iter.new_sync_read
>        2.46           +26.5       28.95 ± 10%  perf-profile.calltrace.cycles-pp.shmem_getpage_gfp.shmem_file_read_iter.new_sync_read.vfs_read.ksys_read
>        2.42           +26.5       28.91 ± 10%  perf-profile.calltrace.cycles-pp.find_lock_entry.shmem_getpage_gfp.shmem_file_read_iter.new_sync_read.vfs_read
>        0.00           +27.4       27.39 ± 10%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irq.__lock_page.find_lock_entry.shmem_getpage_gfp
>        0.00           +27.5       27.48 ± 10%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irq.__lock_page.find_lock_entry.shmem_getpage_gfp.shmem_file_read_iter
>        4.69 ±  4%     +32.8       37.48 ±  9%  perf-profile.calltrace.cycles-pp.wake_up_page_bit.shmem_file_read_iter.new_sync_read.vfs_read.ksys_read
>        0.00           +36.9       36.91 ±  9%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.wake_up_page_bit.shmem_file_read_iter.new_sync_read
>        0.00           +37.0       36.98 ±  9%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.wake_up_page_bit.shmem_file_read_iter.new_sync_read.vfs_read
>        9.25 ±  2%     +58.2       67.42 ±  9%  perf-profile.calltrace.cycles-pp.__libc_read
>        8.75 ±  2%     +58.6       67.37 ±  9%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__libc_read
>        8.61 ±  2%     +58.8       67.36 ±  9%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_read
>        8.53 ±  2%     +58.8       67.35 ±  9%  perf-profile.calltrace.cycles-pp.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_read
>        8.33 ±  2%     +59.0       67.30 ±  9%  perf-profile.calltrace.cycles-pp.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_read
>        8.04 ±  2%     +59.2       67.27 ±  9%  perf-profile.calltrace.cycles-pp.new_sync_read.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
>        7.99 ±  2%     +59.3       67.26 ±  9%  perf-profile.calltrace.cycles-pp.shmem_file_read_iter.new_sync_read.vfs_read.ksys_read.do_syscall_64
>       89.08           -56.7       32.42 ± 20%  perf-profile.children.cycles-pp.secondary_startup_64
>       89.08           -56.7       32.42 ± 20%  perf-profile.children.cycles-pp.cpu_startup_entry
>       89.06           -56.6       32.42 ± 20%  perf-profile.children.cycles-pp.do_idle
>       88.49           -56.3       32.22 ± 20%  perf-profile.children.cycles-pp.start_secondary
>       72.17           -40.0       32.15 ± 20%  perf-profile.children.cycles-pp.cpuidle_enter
>       72.13           -40.0       32.15 ± 20%  perf-profile.children.cycles-pp.cpuidle_enter_state
>       20.61 ±  2%     -20.3        0.29 ± 17%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
>       14.94 ±  7%     -14.7        0.23 ± 19%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
>       45.50           -13.5       31.96 ± 20%  perf-profile.children.cycles-pp.intel_idle
>       12.98 ±  2%     -12.9        0.04 ± 59%  perf-profile.children.cycles-pp.menu_select
>       11.71 ±  6%     -11.5        0.22 ± 17%  perf-profile.children.cycles-pp.asm_call_on_stack
>        9.28 ±  6%      -9.1        0.16 ± 15%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
>        9.08 ±  6%      -8.9        0.16 ± 15%  perf-profile.children.cycles-pp.hrtimer_interrupt
>        4.91 ±  4%      -4.8        0.11 ± 11%  perf-profile.children.cycles-pp.__hrtimer_run_queues
>        4.24 ±  4%      -4.1        0.18 ±  6%  perf-profile.children.cycles-pp.__wake_up_common
>        4.10 ±  4%      -4.0        0.15 ±  5%  perf-profile.children.cycles-pp.wake_page_function
>        3.90 ±  4%      -3.8        0.11 ±  4%  perf-profile.children.cycles-pp.try_to_wake_up
>        3.39 ±  3%      -3.3        0.13 ±  6%  perf-profile.children.cycles-pp.ttwu_do_activate
>        3.36 ±  3%      -3.2        0.13 ±  6%  perf-profile.children.cycles-pp.enqueue_task_fair
>        3.19 ±  3%      -3.1        0.13 ±  5%  perf-profile.children.cycles-pp.enqueue_entity
>        3.09 ±  6%      -3.0        0.08 ± 19%  perf-profile.children.cycles-pp.tick_sched_timer
>        2.83 ±  2%      -2.7        0.14 ±  5%  perf-profile.children.cycles-pp.__schedule
>        2.67 ±  5%      -2.6        0.03 ±105%  perf-profile.children.cycles-pp.irq_exit_rcu
>        2.42 ±  6%      -2.3        0.07 ± 15%  perf-profile.children.cycles-pp.tick_sched_handle
>        2.40 ±  6%      -2.3        0.07 ± 15%  perf-profile.children.cycles-pp.update_process_times
>        2.33 ±  4%      -2.2        0.10 ±  4%  perf-profile.children.cycles-pp.__account_scheduler_latency
>        2.05 ±  5%      -2.0        0.08 ±  5%  perf-profile.children.cycles-pp.stack_trace_save_tsk
>        1.85 ±  4%      -1.8        0.08 ± 10%  perf-profile.children.cycles-pp.arch_stack_walk
>        1.74            -1.6        0.10 ±  4%  perf-profile.children.cycles-pp.schedule
>        1.71            -1.6        0.10 ±  7%  perf-profile.children.cycles-pp.io_schedule
>        1.20 ±  4%      -1.1        0.06 ±  7%  perf-profile.children.cycles-pp.unwind_next_frame
>        1.15 ±  6%      -1.1        0.04 ± 58%  perf-profile.children.cycles-pp.scheduler_tick
>        1.19 ± 18%      -1.1        0.13 ±  6%  perf-profile.children.cycles-pp.flush_smp_call_function_from_idle
>        1.07 ± 18%      -0.9        0.12 ±  6%  perf-profile.children.cycles-pp.sched_ttwu_pending
>        0.65 ± 10%      -0.5        0.14 ± 11%  perf-profile.children.cycles-pp._raw_spin_unlock_irqrestore
>        0.55 ± 17%      -0.5        0.10 ± 16%  perf-profile.children.cycles-pp.poll_idle
>        0.53 ±  7%      -0.4        0.10 ± 10%  perf-profile.children.cycles-pp.__libc_lseek64
>        0.59 ± 29%      -0.4        0.20 ± 20%  perf-profile.children.cycles-pp.start_kernel
>        0.50 ±  2%      -0.4        0.12 ± 10%  perf-profile.children.cycles-pp.copy_page_to_iter
>        0.25 ± 13%      -0.2        0.03 ±100%  perf-profile.children.cycles-pp.ksys_lseek
>        0.30 ±  6%      -0.2        0.09 ±  9%  perf-profile.children.cycles-pp.copy_user_enhanced_fast_string
>        0.29 ±  6%      -0.2        0.09 ±  9%  perf-profile.children.cycles-pp.copyout
>        0.25 ± 26%      -0.2        0.05 ±  8%  perf-profile.children.cycles-pp.__fdget_pos
>        0.00            +0.1        0.14 ± 10%  perf-profile.children.cycles-pp.mark_page_accessed
>        0.07 ± 17%      +0.5        0.54 ± 11%  perf-profile.children.cycles-pp.find_get_entry
>        2.18           +25.8       27.95 ± 10%  perf-profile.children.cycles-pp.__lock_page
>        2.46           +26.5       28.95 ± 10%  perf-profile.children.cycles-pp.shmem_getpage_gfp
>        2.43           +26.5       28.92 ± 10%  perf-profile.children.cycles-pp.find_lock_entry
>        0.23 ± 13%     +27.3       27.49 ± 10%  perf-profile.children.cycles-pp._raw_spin_lock_irq
>        4.69 ±  4%     +32.8       37.48 ±  9%  perf-profile.children.cycles-pp.wake_up_page_bit
>        1.40 ±  5%     +35.6       37.03 ±  9%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
>        9.53 ±  2%     +57.9       67.46 ±  9%  perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
>        9.32 ±  2%     +58.1       67.43 ±  9%  perf-profile.children.cycles-pp.__libc_read
>        9.33 ±  2%     +58.1       67.44 ±  9%  perf-profile.children.cycles-pp.do_syscall_64
>        8.61 ±  2%     +58.7       67.35 ±  9%  perf-profile.children.cycles-pp.ksys_read
>        8.42 ±  2%     +58.9       67.30 ±  9%  perf-profile.children.cycles-pp.vfs_read
>        8.05 ±  2%     +59.2       67.27 ±  9%  perf-profile.children.cycles-pp.new_sync_read
>        7.99 ±  2%     +59.3       67.26 ±  9%  perf-profile.children.cycles-pp.shmem_file_read_iter
>        0.34 ±  7%     +64.0       64.31 ±  9%  perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
>       45.49           -13.5       31.96 ± 20%  perf-profile.self.cycles-pp.intel_idle
>        9.33 ±  5%      -9.3        0.00        perf-profile.self.cycles-pp.menu_select
>        9.05 ± 14%      -9.1        0.00        perf-profile.self.cycles-pp.cpuidle_enter_state
>        1.15 ±  5%      -1.0        0.11 ±  3%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
>        0.49 ± 16%      -0.4        0.10 ± 16%  perf-profile.self.cycles-pp.poll_idle
>        0.29 ±  5%      -0.2        0.09 ±  9%  perf-profile.self.cycles-pp.copy_user_enhanced_fast_string
>        0.00            +0.1        0.14 ± 11%  perf-profile.self.cycles-pp.mark_page_accessed
>        0.00            +0.2        0.18 ± 11%  perf-profile.self.cycles-pp.wake_up_page_bit
>        0.19 ± 14%      +0.3        0.47 ± 12%  perf-profile.self.cycles-pp.shmem_file_read_iter
>        0.01 ±173%      +0.3        0.33 ± 11%  perf-profile.self.cycles-pp.find_lock_entry
>        0.06 ± 14%      +0.5        0.51 ± 11%  perf-profile.self.cycles-pp.find_get_entry
>        0.34 ±  7%     +64.0       64.31 ±  9%  perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
>       40631           +54.3%      62702 ±  5%  softirqs.CPU0.SCHED
>       39633 ±  5%     +94.6%      77112 ±  7%  softirqs.CPU1.SCHED
>       38496          +106.7%      79558 ±  4%  softirqs.CPU10.SCHED
>       38753           +88.1%      72913 ±  7%  softirqs.CPU100.SCHED
>       38787           +84.0%      71383 ± 12%  softirqs.CPU101.SCHED
>       38756           +75.9%      68184 ±  7%  softirqs.CPU102.SCHED
>       38730           +78.4%      69103 ±  6%  softirqs.CPU103.SCHED
>       38745           +75.2%      67870 ±  5%  softirqs.CPU104.SCHED
>       38709           +94.0%      75083 ±  8%  softirqs.CPU105.SCHED
>       38983           +69.0%      65884 ± 10%  softirqs.CPU106.SCHED
>       38712           +73.6%      67205 ±  6%  softirqs.CPU107.SCHED
>       38657           +79.1%      69224 ±  6%  softirqs.CPU108.SCHED
>       38755           +82.1%      70592 ±  9%  softirqs.CPU109.SCHED
>       38376          +103.8%      78211 ±  7%  softirqs.CPU11.SCHED
>       38830           +73.5%      67362 ±  8%  softirqs.CPU110.SCHED
>       38711           +78.9%      69245 ± 12%  softirqs.CPU111.SCHED
>       38752           +74.7%      67717 ±  6%  softirqs.CPU112.SCHED
>       38878           +82.8%      71085 ±  8%  softirqs.CPU113.SCHED
>       38720           +79.7%      69581 ±  9%  softirqs.CPU114.SCHED
>       38626           +74.7%      67473 ±  7%  softirqs.CPU115.SCHED
>       34760 ± 20%    +102.9%      70520 ±  8%  softirqs.CPU116.SCHED
>       38677           +76.2%      68131 ±  7%  softirqs.CPU117.SCHED
>       35465 ± 21%     +91.8%      68005 ±  7%  softirqs.CPU118.SCHED
>       34519 ± 20%    +103.1%      70108 ±  7%  softirqs.CPU119.SCHED
>       38170          +100.7%      76597 ±  9%  softirqs.CPU12.SCHED
>       39018           +83.8%      71712 ±  8%  softirqs.CPU120.SCHED
>       38857           +75.0%      67994 ±  9%  softirqs.CPU121.SCHED
>       38733           +76.0%      68183 ±  8%  softirqs.CPU122.SCHED
>       38784           +78.3%      69142 ±  6%  softirqs.CPU123.SCHED
>       38778           +74.8%      67770 ±  3%  softirqs.CPU124.SCHED
>       39019           +74.5%      68088 ±  6%  softirqs.CPU125.SCHED
>       38781           +74.9%      67826 ±  7%  softirqs.CPU126.SCHED
>       38770           +71.9%      66651 ±  8%  softirqs.CPU127.SCHED
>       38841           +81.5%      70505 ±  8%  softirqs.CPU128.SCHED
>       38690           +75.1%      67746 ±  4%  softirqs.CPU129.SCHED
>       38239 ±  2%     +96.2%      75045 ±  6%  softirqs.CPU13.SCHED
>       38875           +79.2%      69655 ±  8%  softirqs.CPU130.SCHED
>       38866           +73.9%      67575 ±  7%  softirqs.CPU131.SCHED
>       38723           +75.5%      67944 ±  7%  softirqs.CPU132.SCHED
>       38643           +78.7%      69042 ±  9%  softirqs.CPU133.SCHED
>       38669           +78.9%      69174 ±  9%  softirqs.CPU134.SCHED
>       38658           +78.7%      69077 ±  9%  softirqs.CPU135.SCHED
>       38795           +75.0%      67873 ± 12%  softirqs.CPU136.SCHED
>       38817           +70.2%      66079 ±  8%  softirqs.CPU137.SCHED
>       39032           +75.8%      68606 ±  6%  softirqs.CPU138.SCHED
>       38864           +72.8%      67154 ± 10%  softirqs.CPU139.SCHED
>       38779 ±  3%    +102.2%      78423 ±  5%  softirqs.CPU14.SCHED
>       38948           +81.9%      70830 ± 10%  softirqs.CPU140.SCHED
>       38662           +83.5%      70926 ± 12%  softirqs.CPU141.SCHED
>       35132 ± 19%     +98.2%      69627 ±  8%  softirqs.CPU142.SCHED
>       38825           +69.5%      65816 ±  5%  softirqs.CPU143.SCHED
>       35007 ± 20%     +99.3%      69785 ±  8%  softirqs.CPU144.SCHED
>       38938           +76.3%      68648 ± 10%  softirqs.CPU145.SCHED
>       38990           +67.6%      65363 ±  3%  softirqs.CPU146.SCHED
>       39037           +74.1%      67972 ±  2%  softirqs.CPU147.SCHED
>       38810           +76.8%      68600 ±  4%  softirqs.CPU148.SCHED
>       38929           +76.2%      68578 ± 10%  softirqs.CPU149.SCHED
>       38071          +101.6%      76734 ±  6%  softirqs.CPU15.SCHED
>       38904           +81.0%      70427 ± 14%  softirqs.CPU150.SCHED
>       38908           +72.7%      67194 ± 10%  softirqs.CPU151.SCHED
>       38827           +75.7%      68201 ±  8%  softirqs.CPU152.SCHED
>       38848           +70.5%      66256 ±  4%  softirqs.CPU153.SCHED
>       38894           +75.4%      68216 ±  9%  softirqs.CPU154.SCHED
>       38881           +79.8%      69913 ±  4%  softirqs.CPU155.SCHED
>       38886           +73.5%      67482 ±  9%  softirqs.CPU156.SCHED
>       38777           +73.2%      67168 ±  6%  softirqs.CPU157.SCHED
>       38833           +76.4%      68520 ± 10%  softirqs.CPU158.SCHED
>       38874           +71.4%      66620 ±  9%  softirqs.CPU159.SCHED
>       38189          +104.4%      78046 ±  6%  softirqs.CPU16.SCHED
>       38889           +71.9%      66832 ±  7%  softirqs.CPU160.SCHED
>       38982           +80.9%      70533 ±  7%  softirqs.CPU161.SCHED
>       38937           +71.4%      66745 ±  4%  softirqs.CPU162.SCHED
>       34815 ± 20%     +96.1%      68256 ±  6%  softirqs.CPU163.SCHED
>       38870           +72.7%      67148 ±  9%  softirqs.CPU164.SCHED
>       38827           +76.0%      68355 ±  6%  softirqs.CPU165.SCHED
>       38850           +82.1%      70729 ± 10%  softirqs.CPU166.SCHED
>       35197 ± 21%    +100.0%      70389 ± 10%  softirqs.CPU167.SCHED
>       39361 ±  2%     +82.8%      71946 ±  6%  softirqs.CPU168.SCHED
>       38813           +82.6%      70862 ±  7%  softirqs.CPU169.SCHED
>       38121           +95.0%      74331 ±  7%  softirqs.CPU17.SCHED
>       38956           +80.2%      70181 ±  6%  softirqs.CPU170.SCHED
>       38916           +79.7%      69914 ±  6%  softirqs.CPU171.SCHED
>       38859           +76.2%      68479        softirqs.CPU172.SCHED
>       39012           +78.8%      69749 ±  9%  softirqs.CPU173.SCHED
>       38863           +71.7%      66736 ±  4%  softirqs.CPU174.SCHED
>       38841           +81.3%      70431 ±  7%  softirqs.CPU175.SCHED
>       38806           +78.9%      69422 ± 10%  softirqs.CPU176.SCHED
>       38885           +71.6%      66722 ±  6%  softirqs.CPU177.SCHED
>       38896           +79.5%      69803 ±  9%  softirqs.CPU178.SCHED
>       38940           +72.3%      67090 ± 12%  softirqs.CPU179.SCHED
>       37988          +101.2%      76416 ±  6%  softirqs.CPU18.SCHED
>       38844           +74.8%      67888 ±  4%  softirqs.CPU180.SCHED
>       38949           +70.0%      66213 ±  5%  softirqs.CPU181.SCHED
>       39087           +70.4%      66587 ±  5%  softirqs.CPU182.SCHED
>       38848           +70.4%      66185 ±  5%  softirqs.CPU183.SCHED
>       38838           +78.3%      69242 ±  7%  softirqs.CPU184.SCHED
>       38993           +72.7%      67340 ± 10%  softirqs.CPU185.SCHED
>       38797           +67.6%      65035 ±  7%  softirqs.CPU186.SCHED
>       38794           +69.4%      65713 ±  6%  softirqs.CPU187.SCHED
>       38914           +62.2%      63112 ±  6%  softirqs.CPU188.SCHED
>       38898           +71.8%      66822 ±  4%  softirqs.CPU189.SCHED
>       38250          +102.0%      77270 ±  7%  softirqs.CPU19.SCHED
>       38851           +63.0%      63339 ±  4%  softirqs.CPU190.SCHED
>       38794           +23.5%      47899 ±  3%  softirqs.CPU191.SCHED
>       38426           +97.9%      76043 ± 11%  softirqs.CPU2.SCHED
>       38106           +97.4%      75204 ±  5%  softirqs.CPU20.SCHED
>       39713 ±  7%     +95.0%      77425 ± 10%  softirqs.CPU21.SCHED
>       38374          +102.0%      77519 ±  5%  softirqs.CPU22.SCHED
>       38131           +98.3%      75617 ±  6%  softirqs.CPU23.SCHED
>       39241 ±  3%     +83.5%      72016 ±  5%  softirqs.CPU24.SCHED
>       30118 ± 27%    +151.0%      75608 ±  6%  softirqs.CPU25.SCHED
>       38278           +97.2%      75482 ±  6%  softirqs.CPU26.SCHED
>       38217           +96.1%      74939 ±  6%  softirqs.CPU27.SCHED
>       38037           +99.1%      75732 ±  9%  softirqs.CPU28.SCHED
>       38193           +98.2%      75710 ±  6%  softirqs.CPU29.SCHED
>       38287          +102.3%      77439 ±  6%  softirqs.CPU3.SCHED
>       38154           +99.0%      75924 ±  7%  softirqs.CPU30.SCHED
>       38073          +102.0%      76913 ±  6%  softirqs.CPU31.SCHED
>       38084           +92.9%      73483 ±  6%  softirqs.CPU32.SCHED
>       38042           +99.3%      75828 ± 10%  softirqs.CPU33.SCHED
>       38193           +94.2%      74188 ±  5%  softirqs.CPU34.SCHED
>       38243           +98.8%      76013 ±  5%  softirqs.CPU35.SCHED
>       37961           +99.4%      75711 ±  5%  softirqs.CPU36.SCHED
>       38135           +94.9%      74336 ±  6%  softirqs.CPU37.SCHED
>       38335           +94.2%      74461 ±  3%  softirqs.CPU38.SCHED
>       38342           +94.4%      74533 ±  8%  softirqs.CPU39.SCHED
>       37627 ±  2%     +94.6%      73233 ±  6%  softirqs.CPU4.SCHED
>       38084           +98.8%      75711 ±  2%  softirqs.CPU40.SCHED
>       38257          +102.8%      77575 ±  5%  softirqs.CPU41.SCHED
>       37955           +97.2%      74843 ±  9%  softirqs.CPU42.SCHED
>       38071          +100.0%      76133 ±  4%  softirqs.CPU43.SCHED
>       38082           +92.2%      73183 ±  5%  softirqs.CPU44.SCHED
>       38148           +90.7%      72759 ±  7%  softirqs.CPU45.SCHED
>       34308 ± 20%    +115.3%      73863 ±  7%  softirqs.CPU46.SCHED
>       38238          +103.4%      77791 ±  9%  softirqs.CPU47.SCHED
>       38665           +94.8%      75310 ±  5%  softirqs.CPU48.SCHED
>       38415           +99.2%      76524 ±  5%  softirqs.CPU49.SCHED
>       38158           +94.4%      74167 ±  6%  softirqs.CPU5.SCHED
>       38443          +104.8%      78724 ±  7%  softirqs.CPU50.SCHED
>       34425 ± 20%    +125.0%      77470 ± 10%  softirqs.CPU51.SCHED
>       38267           +99.8%      76461 ±  7%  softirqs.CPU52.SCHED
>       38349           +99.2%      76392 ±  4%  softirqs.CPU53.SCHED
>       38403           +94.9%      74848 ±  5%  softirqs.CPU54.SCHED
>       38395          +101.7%      77431 ±  5%  softirqs.CPU55.SCHED
>       38356          +100.3%      76846 ±  5%  softirqs.CPU56.SCHED
>       38445          +105.2%      78902 ± 11%  softirqs.CPU57.SCHED
>       38351          +100.3%      76801 ±  4%  softirqs.CPU58.SCHED
>       38463           +96.3%      75505 ±  9%  softirqs.CPU59.SCHED
>       38189          +102.9%      77480 ±  6%  softirqs.CPU6.SCHED
>       38471          +101.3%      77442 ±  6%  softirqs.CPU60.SCHED
>       38361          +102.9%      77834 ± 10%  softirqs.CPU61.SCHED
>       38143           +98.5%      75709 ±  7%  softirqs.CPU62.SCHED
>       38955 ±  2%    +102.1%      78740 ±  6%  softirqs.CPU63.SCHED
>       38370          +103.9%      78255 ±  6%  softirqs.CPU64.SCHED
>       38401           +94.2%      74557 ±  5%  softirqs.CPU65.SCHED
>       38433          +104.2%      78462 ±  7%  softirqs.CPU66.SCHED
>       38339          +100.5%      76880 ±  6%  softirqs.CPU67.SCHED
>       38398          +103.3%      78048 ±  4%  softirqs.CPU68.SCHED
>       38319          +100.5%      76811 ±  8%  softirqs.CPU69.SCHED
>       34179 ± 21%    +123.9%      76523 ±  7%  softirqs.CPU7.SCHED
>       38552           +93.5%      74604 ±  4%  softirqs.CPU70.SCHED
>       38506           +93.4%      74456 ±  6%  softirqs.CPU71.SCHED
>       38504           +92.3%      74035 ±  5%  softirqs.CPU72.SCHED
>       38134           +96.9%      75089 ±  7%  softirqs.CPU73.SCHED
>       38196           +99.0%      76000 ±  6%  softirqs.CPU74.SCHED
>       38306           +99.1%      76276 ±  6%  softirqs.CPU75.SCHED
>       38705          +100.5%      77595 ± 10%  softirqs.CPU76.SCHED
>       38366           +99.0%      76349 ±  5%  softirqs.CPU77.SCHED
>       38450          +106.6%      79426 ±  8%  softirqs.CPU78.SCHED
>       38155           +98.8%      75834 ±  4%  softirqs.CPU79.SCHED
>       37097 ±  2%    +111.0%      78291 ±  8%  softirqs.CPU8.SCHED
>       38264          +100.0%      76540 ±  3%  softirqs.CPU80.SCHED
>       34260 ± 20%    +130.9%      79108 ±  7%  softirqs.CPU81.SCHED
>       38212           +99.3%      76155 ±  4%  softirqs.CPU82.SCHED
>       38116          +106.6%      78750        softirqs.CPU83.SCHED
>       38164          +104.8%      78146 ±  7%  softirqs.CPU84.SCHED
>       38154          +109.1%      79799 ±  7%  softirqs.CPU85.SCHED
>       38363          +107.0%      79418 ±  9%  softirqs.CPU86.SCHED
>       38224          +108.8%      79830 ±  7%  softirqs.CPU87.SCHED
>       38587           +99.1%      76832 ±  6%  softirqs.CPU88.SCHED
>       38495          +104.7%      78813 ±  3%  softirqs.CPU89.SCHED
>       38367 ±  2%     +83.6%      70426 ±  4%  softirqs.CPU9.SCHED
>       34134 ± 19%    +137.1%      80916 ± 10%  softirqs.CPU90.SCHED
>       38192          +109.9%      80161 ±  7%  softirqs.CPU91.SCHED
>       38336          +116.7%      83080 ±  7%  softirqs.CPU92.SCHED
>       38193          +107.3%      79164 ±  8%  softirqs.CPU93.SCHED
>       27437 ± 12%     -25.5%      20438 ± 13%  softirqs.CPU94.RCU
>       38299          +115.9%      82699 ±  8%  softirqs.CPU94.SCHED
>       18235 ±  4%    +202.2%      55116 ± 33%  softirqs.CPU95.SCHED
>       36482 ± 13%    +135.6%      85946 ±  9%  softirqs.CPU96.SCHED
>       38587           +80.8%      69767 ±  4%  softirqs.CPU97.SCHED
>       38930           +78.6%      69537 ±  4%  softirqs.CPU98.SCHED
>       32564 ± 32%    +111.7%      68941 ±  7%  softirqs.CPU99.SCHED
>     7325109           +89.6%   13891305 ±  6%  softirqs.SCHED
>      236548 ±  4%   +1218.3%    3118323 ±  8%  interrupts.CAL:Function_call_interrupts
>        1429 ± 10%    +585.9%       9804 ± 24%  interrupts.CPU0.CAL:Function_call_interrupts
>      231.75 ± 33%   +2494.9%       6013 ± 13%  interrupts.CPU0.NMI:Non-maskable_interrupts
>      231.75 ± 33%   +2494.9%       6013 ± 13%  interrupts.CPU0.PMI:Performance_monitoring_interrupts
>        6.00 ± 69%   +6658.3%     405.50 ± 23%  interrupts.CPU0.TLB:TLB_shootdowns
>        1364 ± 16%   +1245.8%      18364 ±  4%  interrupts.CPU1.CAL:Function_call_interrupts
>      203.00         +3411.8%       7129 ±  4%  interrupts.CPU1.NMI:Non-maskable_interrupts
>      203.00         +3411.8%       7129 ±  4%  interrupts.CPU1.PMI:Performance_monitoring_interrupts
>        1143 ± 15%     -66.3%     385.25 ±  8%  interrupts.CPU1.RES:Rescheduling_interrupts
>       21.00 ± 83%   +3652.4%     788.00 ±  7%  interrupts.CPU1.TLB:TLB_shootdowns
>        1110 ±  5%   +1759.6%      20646 ± 12%  interrupts.CPU10.CAL:Function_call_interrupts
>      208.00         +2277.9%       4946 ± 29%  interrupts.CPU10.NMI:Non-maskable_interrupts
>      208.00         +2277.9%       4946 ± 29%  interrupts.CPU10.PMI:Performance_monitoring_interrupts
>      830.50 ± 28%     -51.5%     402.50 ± 13%  interrupts.CPU10.RES:Rescheduling_interrupts
>       29.00 ±143%   +2773.3%     833.25 ± 13%  interrupts.CPU10.TLB:TLB_shootdowns
>        1131 ± 18%   +1366.0%      16591 ±  7%  interrupts.CPU100.CAL:Function_call_interrupts
>      204.00 ±  3%   +2103.3%       4494 ± 20%  interrupts.CPU100.NMI:Non-maskable_interrupts
>      204.00 ±  3%   +2103.3%       4494 ± 20%  interrupts.CPU100.PMI:Performance_monitoring_interrupts
>        1286 ±  8%     -74.4%     329.50 ±  9%  interrupts.CPU100.RES:Rescheduling_interrupts
>        9.00 ± 65%   +8488.9%     773.00 ± 14%  interrupts.CPU100.TLB:TLB_shootdowns
>        1189 ± 23%   +1270.2%      16298 ± 12%  interrupts.CPU101.CAL:Function_call_interrupts
>      202.00 ±  3%   +3234.9%       6736 ± 14%  interrupts.CPU101.NMI:Non-maskable_interrupts
>      202.00 ±  3%   +3234.9%       6736 ± 14%  interrupts.CPU101.PMI:Performance_monitoring_interrupts
>        1486 ± 20%     -80.0%     297.50 ± 11%  interrupts.CPU101.RES:Rescheduling_interrupts
>       17.75 ± 97%   +3942.3%     717.50 ± 10%  interrupts.CPU101.TLB:TLB_shootdowns
>        1066 ±  9%   +1193.7%      13800 ±  7%  interrupts.CPU102.CAL:Function_call_interrupts
>      201.75 ±  3%   +2311.2%       4864 ± 29%  interrupts.CPU102.NMI:Non-maskable_interrupts
>      201.75 ±  3%   +2311.2%       4864 ± 29%  interrupts.CPU102.PMI:Performance_monitoring_interrupts
>        1124 ± 17%     -75.4%     276.25 ± 10%  interrupts.CPU102.RES:Rescheduling_interrupts
>        8.00 ± 30%   +7431.2%     602.50 ± 11%  interrupts.CPU102.TLB:TLB_shootdowns
>        1151 ± 12%   +1149.8%      14391 ±  5%  interrupts.CPU103.CAL:Function_call_interrupts
>      180.75 ± 26%   +2754.5%       5159 ± 23%  interrupts.CPU103.NMI:Non-maskable_interrupts
>      180.75 ± 26%   +2754.5%       5159 ± 23%  interrupts.CPU103.PMI:Performance_monitoring_interrupts
>        1452 ±  9%     -79.3%     301.25 ± 16%  interrupts.CPU103.RES:Rescheduling_interrupts
>       22.00 ± 69%   +2867.0%     652.75 ± 17%  interrupts.CPU103.TLB:TLB_shootdowns
>        1373 ± 17%    +954.6%      14487 ±  8%  interrupts.CPU104.CAL:Function_call_interrupts
>      176.00 ± 25%   +2905.3%       5289 ± 23%  interrupts.CPU104.NMI:Non-maskable_interrupts
>      176.00 ± 25%   +2905.3%       5289 ± 23%  interrupts.CPU104.PMI:Performance_monitoring_interrupts
>        1366 ± 24%     -80.1%     271.75 ± 18%  interrupts.CPU104.RES:Rescheduling_interrupts
>        9.25 ± 15%   +6373.0%     598.75 ± 14%  interrupts.CPU104.TLB:TLB_shootdowns
>        1337 ±  8%   +1221.1%      17663 ± 12%  interrupts.CPU105.CAL:Function_call_interrupts
>      205.25         +2922.3%       6203 ± 26%  interrupts.CPU105.NMI:Non-maskable_interrupts
>      205.25         +2922.3%       6203 ± 26%  interrupts.CPU105.PMI:Performance_monitoring_interrupts
>        1466 ± 13%     -77.0%     337.50 ± 11%  interrupts.CPU105.RES:Rescheduling_interrupts
>       29.50 ± 66%   +2657.6%     813.50 ±  9%  interrupts.CPU105.TLB:TLB_shootdowns
>        1314 ± 10%    +937.2%      13633 ± 17%  interrupts.CPU106.CAL:Function_call_interrupts
>      179.00 ± 24%   +2685.2%       4985 ± 31%  interrupts.CPU106.NMI:Non-maskable_interrupts
>      179.00 ± 24%   +2685.2%       4985 ± 31%  interrupts.CPU106.PMI:Performance_monitoring_interrupts
>        1635 ±  9%     -84.8%     248.00 ±  4%  interrupts.CPU106.RES:Rescheduling_interrupts
>       11.25 ± 21%   +5428.9%     622.00 ± 18%  interrupts.CPU106.TLB:TLB_shootdowns
>        1110 ±  6%   +1134.1%      13701 ±  2%  interrupts.CPU107.CAL:Function_call_interrupts
>      174.75 ± 24%   +2917.6%       5273 ± 28%  interrupts.CPU107.NMI:Non-maskable_interrupts
>      174.75 ± 24%   +2917.6%       5273 ± 28%  interrupts.CPU107.PMI:Performance_monitoring_interrupts
>        1395 ± 27%     -82.0%     250.75 ± 16%  interrupts.CPU107.RES:Rescheduling_interrupts
>        8.75 ± 35%   +7760.0%     687.75 ± 19%  interrupts.CPU107.TLB:TLB_shootdowns
>        1461 ±  9%    +997.1%      16036 ± 18%  interrupts.CPU108.CAL:Function_call_interrupts
>      177.25 ± 25%   +3711.1%       6755 ± 15%  interrupts.CPU108.NMI:Non-maskable_interrupts
>      177.25 ± 25%   +3711.1%       6755 ± 15%  interrupts.CPU108.PMI:Performance_monitoring_interrupts
>        1525 ±  9%     -81.6%     280.25 ± 19%  interrupts.CPU108.RES:Rescheduling_interrupts
>       22.00 ± 60%   +2913.6%     663.00 ± 14%  interrupts.CPU108.TLB:TLB_shootdowns
>        1167 ± 10%   +1162.5%      14736 ± 14%  interrupts.CPU109.CAL:Function_call_interrupts
>      151.50 ± 31%   +3887.3%       6040 ± 33%  interrupts.CPU109.NMI:Non-maskable_interrupts
>      151.50 ± 31%   +3887.3%       6040 ± 33%  interrupts.CPU109.PMI:Performance_monitoring_interrupts
>        1331 ± 28%     -76.7%     310.50 ± 14%  interrupts.CPU109.RES:Rescheduling_interrupts
>        8.00 ± 39%   +8687.5%     703.00 ± 14%  interrupts.CPU109.TLB:TLB_shootdowns
>        1125 ± 13%   +1642.3%      19605 ± 14%  interrupts.CPU11.CAL:Function_call_interrupts
>      176.25 ± 23%   +2172.6%       4005 ± 44%  interrupts.CPU11.NMI:Non-maskable_interrupts
>      176.25 ± 23%   +2172.6%       4005 ± 44%  interrupts.CPU11.PMI:Performance_monitoring_interrupts
>        1199 ± 31%     -67.0%     395.50 ± 13%  interrupts.CPU11.RES:Rescheduling_interrupts
>       18.00 ± 74%   +4216.7%     777.00 ± 15%  interrupts.CPU11.TLB:TLB_shootdowns
>        1108 ± 10%   +1073.9%      13009 ±  5%  interrupts.CPU110.CAL:Function_call_interrupts
>      149.50 ± 31%   +2692.1%       4174 ± 41%  interrupts.CPU110.NMI:Non-maskable_interrupts
>      149.50 ± 31%   +2692.1%       4174 ± 41%  interrupts.CPU110.PMI:Performance_monitoring_interrupts
>        1303 ±  9%     -80.7%     251.50 ± 12%  interrupts.CPU110.RES:Rescheduling_interrupts
>       18.25 ± 79%   +3406.8%     640.00 ± 17%  interrupts.CPU110.TLB:TLB_shootdowns
>        1189 ± 21%   +1172.3%      15130 ± 19%  interrupts.CPU111.CAL:Function_call_interrupts
>      147.75 ± 33%   +2802.4%       4288 ± 42%  interrupts.CPU111.NMI:Non-maskable_interrupts
>      147.75 ± 33%   +2802.4%       4288 ± 42%  interrupts.CPU111.PMI:Performance_monitoring_interrupts
>        1547 ± 28%     -82.1%     277.25 ± 21%  interrupts.CPU111.RES:Rescheduling_interrupts
>       28.50 ± 99%   +2150.9%     641.50 ± 29%  interrupts.CPU111.TLB:TLB_shootdowns
>        1135 ± 12%   +1154.3%      14236 ±  8%  interrupts.CPU112.CAL:Function_call_interrupts
>      148.75 ± 32%   +2586.7%       3996 ± 48%  interrupts.CPU112.NMI:Non-maskable_interrupts
>      148.75 ± 32%   +2586.7%       3996 ± 48%  interrupts.CPU112.PMI:Performance_monitoring_interrupts
>        1316 ± 12%     -79.5%     270.00 ± 13%  interrupts.CPU112.RES:Rescheduling_interrupts
>        7.50 ± 46%   +7680.0%     583.50 ± 12%  interrupts.CPU112.TLB:TLB_shootdowns
>        1193 ± 16%   +1226.6%      15833 ± 21%  interrupts.CPU113.CAL:Function_call_interrupts
>      149.75 ± 32%   +4233.9%       6490 ± 10%  interrupts.CPU113.NMI:Non-maskable_interrupts
>      149.75 ± 32%   +4233.9%       6490 ± 10%  interrupts.CPU113.PMI:Performance_monitoring_interrupts
>        1572 ± 33%     -81.0%     298.00 ± 11%  interrupts.CPU113.RES:Rescheduling_interrupts
>        9.75 ± 61%   +7625.6%     753.25 ± 10%  interrupts.CPU113.TLB:TLB_shootdowns
>        1397 ± 15%    +992.7%      15273 ±  9%  interrupts.CPU114.CAL:Function_call_interrupts
>      148.00 ± 32%   +3691.9%       5612 ± 39%  interrupts.CPU114.NMI:Non-maskable_interrupts
>      148.00 ± 32%   +3691.9%       5612 ± 39%  interrupts.CPU114.PMI:Performance_monitoring_interrupts
>        1313 ± 13%     -79.0%     276.00 ±  8%  interrupts.CPU114.RES:Rescheduling_interrupts
>       28.75 ±101%   +2879.1%     856.50 ± 18%  interrupts.CPU114.TLB:TLB_shootdowns
>        1152 ± 11%   +1054.8%      13309 ±  5%  interrupts.CPU115.CAL:Function_call_interrupts
>      176.75 ± 25%   +2775.8%       5083 ± 26%  interrupts.CPU115.NMI:Non-maskable_interrupts
>      176.75 ± 25%   +2775.8%       5083 ± 26%  interrupts.CPU115.PMI:Performance_monitoring_interrupts
>        1278 ± 22%     -78.1%     280.00 ± 12%  interrupts.CPU115.RES:Rescheduling_interrupts
>        8.75 ± 31%   +7614.3%     675.00 ± 11%  interrupts.CPU115.TLB:TLB_shootdowns
>        1427 ± 24%    +934.8%      14774 ± 15%  interrupts.CPU116.CAL:Function_call_interrupts
>      203.00 ±  3%   +2693.3%       5670 ± 25%  interrupts.CPU116.NMI:Non-maskable_interrupts
>      203.00 ±  3%   +2693.3%       5670 ± 25%  interrupts.CPU116.PMI:Performance_monitoring_interrupts
>        1451 ± 35%     -77.1%     331.75 ± 13%  interrupts.CPU116.RES:Rescheduling_interrupts
>       11.50 ± 29%   +4582.6%     538.50 ± 14%  interrupts.CPU116.TLB:TLB_shootdowns
>        1225 ± 16%   +1001.5%      13499 ± 21%  interrupts.CPU117.CAL:Function_call_interrupts
>      176.50 ± 25%   +2546.0%       4670 ± 23%  interrupts.CPU117.NMI:Non-maskable_interrupts
>      176.50 ± 25%   +2546.0%       4670 ± 23%  interrupts.CPU117.PMI:Performance_monitoring_interrupts
>        1317 ± 28%     -78.7%     281.25 ± 30%  interrupts.CPU117.RES:Rescheduling_interrupts
>        8.25 ± 71%   +7412.1%     619.75 ± 30%  interrupts.CPU117.TLB:TLB_shootdowns
>        1216 ± 12%   +1026.3%      13704 ±  6%  interrupts.CPU118.CAL:Function_call_interrupts
>      204.75 ±  4%   +2645.8%       5622 ± 29%  interrupts.CPU118.NMI:Non-maskable_interrupts
>      204.75 ±  4%   +2645.8%       5622 ± 29%  interrupts.CPU118.PMI:Performance_monitoring_interrupts
>        1314 ± 20%     -78.5%     283.00 ±  9%  interrupts.CPU118.RES:Rescheduling_interrupts
>       19.25 ± 81%   +3127.3%     621.25 ± 17%  interrupts.CPU118.TLB:TLB_shootdowns
>        1140 ±  8%   +1211.5%      14961 ±  4%  interrupts.CPU119.CAL:Function_call_interrupts
>      202.75 ±  4%   +2414.2%       5097 ± 29%  interrupts.CPU119.NMI:Non-maskable_interrupts
>      202.75 ±  4%   +2414.2%       5097 ± 29%  interrupts.CPU119.PMI:Performance_monitoring_interrupts
>        1249 ± 11%     -76.3%     296.00 ± 18%  interrupts.CPU119.RES:Rescheduling_interrupts
>       10.00 ± 27%   +6227.5%     632.75 ± 11%  interrupts.CPU119.TLB:TLB_shootdowns
>        1262 ± 10%   +1468.3%      19799 ±  8%  interrupts.CPU12.CAL:Function_call_interrupts
>      207.25 ±  2%   +1845.1%       4031 ± 23%  interrupts.CPU12.NMI:Non-maskable_interrupts
>      207.25 ±  2%   +1845.1%       4031 ± 23%  interrupts.CPU12.PMI:Performance_monitoring_interrupts
>      810.50 ± 27%     -52.0%     389.00 ± 10%  interrupts.CPU12.RES:Rescheduling_interrupts
>       15.75 ± 90%   +5019.0%     806.25 ±  8%  interrupts.CPU12.TLB:TLB_shootdowns
>        1266 ±  4%   +1199.9%      16462 ±  7%  interrupts.CPU120.CAL:Function_call_interrupts
>      203.75 ±  3%   +2367.0%       5026 ± 32%  interrupts.CPU120.NMI:Non-maskable_interrupts
>      203.75 ±  3%   +2367.0%       5026 ± 32%  interrupts.CPU120.PMI:Performance_monitoring_interrupts
>        1049 ± 15%     -66.2%     354.75 ± 17%  interrupts.CPU120.RES:Rescheduling_interrupts
>       18.75 ± 84%   +3682.7%     709.25 ± 12%  interrupts.CPU120.TLB:TLB_shootdowns
>        1206 ± 15%   +1076.3%      14194 ±  7%  interrupts.CPU121.CAL:Function_call_interrupts
>      199.50 ±  4%   +2815.2%       5815 ± 17%  interrupts.CPU121.NMI:Non-maskable_interrupts
>      199.50 ±  4%   +2815.2%       5815 ± 17%  interrupts.CPU121.PMI:Performance_monitoring_interrupts
>        1507 ± 28%     -81.1%     284.50 ± 18%  interrupts.CPU121.RES:Rescheduling_interrupts
>       11.00 ± 22%   +5811.4%     650.25 ± 20%  interrupts.CPU121.TLB:TLB_shootdowns
>        1016 ±  5%   +1261.5%      13839 ±  7%  interrupts.CPU122.CAL:Function_call_interrupts
>      198.75 ±  4%   +3276.7%       6711 ±  4%  interrupts.CPU122.NMI:Non-maskable_interrupts
>      198.75 ±  4%   +3276.7%       6711 ±  4%  interrupts.CPU122.PMI:Performance_monitoring_interrupts
>        1169 ± 30%     -73.5%     310.00 ±  2%  interrupts.CPU122.RES:Rescheduling_interrupts
>       12.50 ± 32%   +5146.0%     655.75 ± 20%  interrupts.CPU122.TLB:TLB_shootdowns
>        1141 ±  5%   +1093.9%      13625 ± 10%  interrupts.CPU123.CAL:Function_call_interrupts
>      178.75 ± 27%   +3893.4%       7138 ± 11%  interrupts.CPU123.NMI:Non-maskable_interrupts
>      178.75 ± 27%   +3893.4%       7138 ± 11%  interrupts.CPU123.PMI:Performance_monitoring_interrupts
>        1197 ± 52%     -73.1%     321.50 ± 16%  interrupts.CPU123.RES:Rescheduling_interrupts
>        8.75 ± 75%   +7505.7%     665.50 ± 24%  interrupts.CPU123.TLB:TLB_shootdowns
>        1079 ±  8%   +1259.3%      14673 ± 12%  interrupts.CPU124.CAL:Function_call_interrupts
>      198.50 ±  4%   +2452.9%       5067 ± 28%  interrupts.CPU124.NMI:Non-maskable_interrupts
>      198.50 ±  4%   +2452.9%       5067 ± 28%  interrupts.CPU124.PMI:Performance_monitoring_interrupts
>        1326 ± 10%     -78.6%     284.25 ± 27%  interrupts.CPU124.RES:Rescheduling_interrupts
>       11.25 ± 14%   +6237.8%     713.00 ± 14%  interrupts.CPU124.TLB:TLB_shootdowns
>        1146 ±  8%   +1212.8%      15051 ±  7%  interrupts.CPU125.CAL:Function_call_interrupts
>      200.50 ±  3%   +2483.8%       5180 ± 28%  interrupts.CPU125.NMI:Non-maskable_interrupts
>      200.50 ±  3%   +2483.8%       5180 ± 28%  interrupts.CPU125.PMI:Performance_monitoring_interrupts
>        1121 ± 12%     -75.7%     272.25 ± 11%  interrupts.CPU125.RES:Rescheduling_interrupts
>        8.00 ± 46%   +8106.2%     656.50 ±  6%  interrupts.CPU125.TLB:TLB_shootdowns
>        1054 ±  6%   +1175.3%      13451 ± 12%  interrupts.CPU126.CAL:Function_call_interrupts
>      196.00 ±  3%   +2189.5%       4487 ± 37%  interrupts.CPU126.NMI:Non-maskable_interrupts
>      196.00 ±  3%   +2189.5%       4487 ± 37%  interrupts.CPU126.PMI:Performance_monitoring_interrupts
>        1300 ±  6%     -77.5%     293.25 ± 13%  interrupts.CPU126.RES:Rescheduling_interrupts
>       10.50 ± 44%   +6485.7%     691.50 ±  8%  interrupts.CPU126.TLB:TLB_shootdowns
>        1201 ± 16%   +1013.0%      13375 ±  7%  interrupts.CPU127.CAL:Function_call_interrupts
>      175.50 ± 25%   +3272.9%       5919 ± 33%  interrupts.CPU127.NMI:Non-maskable_interrupts
>      175.50 ± 25%   +3272.9%       5919 ± 33%  interrupts.CPU127.PMI:Performance_monitoring_interrupts
>        1281 ± 10%     -75.4%     315.75 ± 19%  interrupts.CPU127.RES:Rescheduling_interrupts
>       33.75 ± 81%   +1794.8%     639.50 ±  3%  interrupts.CPU127.TLB:TLB_shootdowns
>        1316 ± 10%    +941.9%      13716 ± 22%  interrupts.CPU128.CAL:Function_call_interrupts
>      171.50 ± 23%   +2881.6%       5113 ± 31%  interrupts.CPU128.NMI:Non-maskable_interrupts
>      171.50 ± 23%   +2881.6%       5113 ± 31%  interrupts.CPU128.PMI:Performance_monitoring_interrupts
>        1202 ±  9%     -73.0%     324.25 ± 13%  interrupts.CPU128.RES:Rescheduling_interrupts
>       14.50 ± 28%   +4265.5%     633.00 ± 22%  interrupts.CPU128.TLB:TLB_shootdowns
>        1198 ± 10%   +1072.9%      14057 ± 19%  interrupts.CPU129.CAL:Function_call_interrupts
>      173.00 ± 25%   +2972.8%       5316 ± 41%  interrupts.CPU129.NMI:Non-maskable_interrupts
>      173.00 ± 25%   +2972.8%       5316 ± 41%  interrupts.CPU129.PMI:Performance_monitoring_interrupts
>        1219 ± 38%     -74.2%     314.75 ± 22%  interrupts.CPU129.RES:Rescheduling_interrupts
>       15.25 ± 43%   +4042.6%     631.75 ± 15%  interrupts.CPU129.TLB:TLB_shootdowns
>        1569 ± 50%    +997.0%      17214 ±  9%  interrupts.CPU13.CAL:Function_call_interrupts
>      204.75 ±  5%   +2106.8%       4518 ± 53%  interrupts.CPU13.NMI:Non-maskable_interrupts
>      204.75 ±  5%   +2106.8%       4518 ± 53%  interrupts.CPU13.PMI:Performance_monitoring_interrupts
>        1204 ± 29%     -71.1%     348.50 ± 27%  interrupts.CPU13.RES:Rescheduling_interrupts
>       16.75 ± 87%   +4329.9%     742.00 ± 14%  interrupts.CPU13.TLB:TLB_shootdowns
>        1000 ±  4%   +1382.7%      14830 ± 12%  interrupts.CPU130.CAL:Function_call_interrupts
>      172.00 ± 24%   +3391.7%       6005 ± 23%  interrupts.CPU130.NMI:Non-maskable_interrupts
>      172.00 ± 24%   +3391.7%       6005 ± 23%  interrupts.CPU130.PMI:Performance_monitoring_interrupts
>        1174 ± 14%     -73.3%     313.25 ± 19%  interrupts.CPU130.RES:Rescheduling_interrupts
>       10.25 ± 32%   +6546.3%     681.25 ±  4%  interrupts.CPU130.TLB:TLB_shootdowns
>        1156 ±  9%   +1093.9%      13804 ± 14%  interrupts.CPU131.CAL:Function_call_interrupts
>      176.00 ± 28%   +2972.2%       5407 ± 28%  interrupts.CPU131.NMI:Non-maskable_interrupts
>      176.00 ± 28%   +2972.2%       5407 ± 28%  interrupts.CPU131.PMI:Performance_monitoring_interrupts
>        1370 ± 22%     -76.7%     319.25 ± 14%  interrupts.CPU131.RES:Rescheduling_interrupts
>       30.00 ± 52%   +1986.7%     626.00 ± 19%  interrupts.CPU131.TLB:TLB_shootdowns
>        1151 ±  9%   +1135.4%      14222 ± 13%  interrupts.CPU132.CAL:Function_call_interrupts
>      168.00 ± 23%   +2673.5%       4659 ± 29%  interrupts.CPU132.NMI:Non-maskable_interrupts
>      168.00 ± 23%   +2673.5%       4659 ± 29%  interrupts.CPU132.PMI:Performance_monitoring_interrupts
>        1643 ± 13%     -79.8%     332.75 ± 16%  interrupts.CPU132.RES:Rescheduling_interrupts
>       14.50 ± 36%   +5208.6%     769.75 ± 11%  interrupts.CPU132.TLB:TLB_shootdowns
>        1150 ±  9%   +1148.8%      14370 ±  9%  interrupts.CPU133.CAL:Function_call_interrupts
>      144.25 ± 34%   +3515.1%       5214 ± 25%  interrupts.CPU133.NMI:Non-maskable_interrupts
>      144.25 ± 34%   +3515.1%       5214 ± 25%  interrupts.CPU133.PMI:Performance_monitoring_interrupts
>        1200 ± 27%     -74.7%     303.50 ± 14%  interrupts.CPU133.RES:Rescheduling_interrupts
>       27.75 ± 77%   +2288.3%     662.75 ± 13%  interrupts.CPU133.TLB:TLB_shootdowns
>        1041 ± 11%   +1120.7%      12707 ±  6%  interrupts.CPU134.CAL:Function_call_interrupts
>      172.75 ± 27%   +2867.6%       5126 ± 25%  interrupts.CPU134.NMI:Non-maskable_interrupts
>      172.75 ± 27%   +2867.6%       5126 ± 25%  interrupts.CPU134.PMI:Performance_monitoring_interrupts
>        1147 ± 32%     -70.3%     340.50 ± 22%  interrupts.CPU134.RES:Rescheduling_interrupts
>        8.50 ± 37%   +8305.9%     714.50 ± 23%  interrupts.CPU134.TLB:TLB_shootdowns
>        1169 ±  8%   +1200.7%      15208 ± 16%  interrupts.CPU135.CAL:Function_call_interrupts
>      171.50 ± 27%   +2944.2%       5220 ± 35%  interrupts.CPU135.NMI:Non-maskable_interrupts
>      171.50 ± 27%   +2944.2%       5220 ± 35%  interrupts.CPU135.PMI:Performance_monitoring_interrupts
>        1110 ± 16%     -68.3%     351.50 ± 21%  interrupts.CPU135.RES:Rescheduling_interrupts
>       12.00 ± 33%   +5641.7%     689.00 ± 21%  interrupts.CPU135.TLB:TLB_shootdowns
>        1118 ±  7%   +1085.7%      13265 ± 12%  interrupts.CPU136.CAL:Function_call_interrupts
>      174.25 ± 27%   +2698.6%       4876 ± 24%  interrupts.CPU136.NMI:Non-maskable_interrupts
>      174.25 ± 27%   +2698.6%       4876 ± 24%  interrupts.CPU136.PMI:Performance_monitoring_interrupts
>        1392 ±  7%     -79.5%     285.25 ± 12%  interrupts.CPU136.RES:Rescheduling_interrupts
>       58.25 ±108%    +987.1%     633.25 ± 17%  interrupts.CPU136.TLB:TLB_shootdowns
>        1250 ± 29%    +980.4%      13513 ± 14%  interrupts.CPU137.CAL:Function_call_interrupts
>      199.25 ±  3%   +2614.4%       5408 ± 24%  interrupts.CPU137.NMI:Non-maskable_interrupts
>      199.25 ±  3%   +2614.4%       5408 ± 24%  interrupts.CPU137.PMI:Performance_monitoring_interrupts
>        1281 ± 10%     -77.5%     288.75 ± 31%  interrupts.CPU137.RES:Rescheduling_interrupts
>       21.75 ± 76%   +2344.8%     531.75 ± 15%  interrupts.CPU137.TLB:TLB_shootdowns
>        1161 ±  9%   +1142.5%      14431 ± 10%  interrupts.CPU138.CAL:Function_call_interrupts
>      204.75 ± 11%   +2804.8%       5947 ± 19%  interrupts.CPU138.NMI:Non-maskable_interrupts
>      204.75 ± 11%   +2804.8%       5947 ± 19%  interrupts.CPU138.PMI:Performance_monitoring_interrupts
>        1324 ± 19%     -75.6%     322.75 ± 23%  interrupts.CPU138.RES:Rescheduling_interrupts
>       12.25 ± 21%   +5142.9%     642.25 ± 11%  interrupts.CPU138.TLB:TLB_shootdowns
>        1089 ± 11%   +1073.7%      12781 ±  9%  interrupts.CPU139.CAL:Function_call_interrupts
>      174.00 ± 24%   +3120.3%       5603 ± 31%  interrupts.CPU139.NMI:Non-maskable_interrupts
>      174.00 ± 24%   +3120.3%       5603 ± 31%  interrupts.CPU139.PMI:Performance_monitoring_interrupts
>        1434 ± 19%     -82.0%     258.00 ±  8%  interrupts.CPU139.RES:Rescheduling_interrupts
>       30.75 ±119%   +2056.9%     663.25 ± 14%  interrupts.CPU139.TLB:TLB_shootdowns
>        1220 ± 14%   +1438.2%      18769 ±  8%  interrupts.CPU14.CAL:Function_call_interrupts
>      206.75 ±  4%   +2813.7%       6024 ± 25%  interrupts.CPU14.NMI:Non-maskable_interrupts
>      206.75 ±  4%   +2813.7%       6024 ± 25%  interrupts.CPU14.PMI:Performance_monitoring_interrupts
>        1255 ± 29%     -67.5%     408.00 ± 23%  interrupts.CPU14.RES:Rescheduling_interrupts
>       11.25 ± 22%   +7417.8%     845.75 ± 11%  interrupts.CPU14.TLB:TLB_shootdowns
>        1172 ±  9%   +1141.5%      14556 ± 10%  interrupts.CPU140.CAL:Function_call_interrupts
>      172.00 ± 23%   +2840.4%       5057 ± 26%  interrupts.CPU140.NMI:Non-maskable_interrupts
>      172.00 ± 23%   +2840.4%       5057 ± 26%  interrupts.CPU140.PMI:Performance_monitoring_interrupts
>        1538 ± 33%     -77.5%     346.00 ± 19%  interrupts.CPU140.RES:Rescheduling_interrupts
>       13.00 ± 56%   +4734.6%     628.50 ± 25%  interrupts.CPU140.TLB:TLB_shootdowns
>        1131 ± 11%   +1224.3%      14981 ±  4%  interrupts.CPU141.CAL:Function_call_interrupts
>      174.00 ± 25%   +3593.5%       6426 ± 16%  interrupts.CPU141.NMI:Non-maskable_interrupts
>      174.00 ± 25%   +3593.5%       6426 ± 16%  interrupts.CPU141.PMI:Performance_monitoring_interrupts
>        1099 ±  4%     -73.7%     289.00 ± 12%  interrupts.CPU141.RES:Rescheduling_interrupts
>       10.25 ± 17%   +6936.6%     721.25 ± 21%  interrupts.CPU141.TLB:TLB_shootdowns
>        1101 ± 13%   +1300.5%      15422 ± 16%  interrupts.CPU142.CAL:Function_call_interrupts
>      171.25 ± 23%   +2942.3%       5210 ± 19%  interrupts.CPU142.NMI:Non-maskable_interrupts
>      171.25 ± 23%   +2942.3%       5210 ± 19%  interrupts.CPU142.PMI:Performance_monitoring_interrupts
>        1238 ±  3%     -75.2%     307.25 ± 19%  interrupts.CPU142.RES:Rescheduling_interrupts
>       13.75 ± 17%   +5021.8%     704.25 ± 21%  interrupts.CPU142.TLB:TLB_shootdowns
>        1014 ± 12%   +1164.9%      12826 ± 14%  interrupts.CPU143.CAL:Function_call_interrupts
>      171.50 ± 24%   +3326.4%       5876 ± 10%  interrupts.CPU143.NMI:Non-maskable_interrupts
>      171.50 ± 24%   +3326.4%       5876 ± 10%  interrupts.CPU143.PMI:Performance_monitoring_interrupts
>        1299 ± 32%     -75.4%     319.00 ± 21%  interrupts.CPU143.RES:Rescheduling_interrupts
>       10.00 ± 37%   +7027.5%     712.75 ± 15%  interrupts.CPU143.TLB:TLB_shootdowns
>        1149 ±  4%   +1225.5%      15239 ± 11%  interrupts.CPU144.CAL:Function_call_interrupts
>      199.00 ± 31%   +2607.5%       5388 ± 38%  interrupts.CPU144.NMI:Non-maskable_interrupts
>      199.00 ± 31%   +2607.5%       5388 ± 38%  interrupts.CPU144.PMI:Performance_monitoring_interrupts
>      901.00 ± 17%     -67.5%     292.75 ±  7%  interrupts.CPU144.RES:Rescheduling_interrupts
>       29.75 ± 64%   +2062.2%     643.25 ± 18%  interrupts.CPU144.TLB:TLB_shootdowns
>        1240 ±  5%   +1016.7%      13849 ±  6%  interrupts.CPU145.CAL:Function_call_interrupts
>      170.25 ± 25%   +3281.4%       5756 ±  7%  interrupts.CPU145.NMI:Non-maskable_interrupts
>      170.25 ± 25%   +3281.4%       5756 ±  7%  interrupts.CPU145.PMI:Performance_monitoring_interrupts
>        1430 ± 17%     -81.6%     263.75 ± 22%  interrupts.CPU145.RES:Rescheduling_interrupts
>       14.75 ± 10%   +4771.2%     718.50 ± 16%  interrupts.CPU145.TLB:TLB_shootdowns
>        1360 ± 33%    +901.6%      13626 ± 13%  interrupts.CPU146.CAL:Function_call_interrupts
>      196.75 ±  2%   +2932.3%       5966 ± 27%  interrupts.CPU146.NMI:Non-maskable_interrupts
>      196.75 ±  2%   +2932.3%       5966 ± 27%  interrupts.CPU146.PMI:Performance_monitoring_interrupts
>        1173 ± 14%     -77.6%     263.00 ± 21%  interrupts.CPU146.RES:Rescheduling_interrupts
>       19.00 ± 82%   +2542.1%     502.00 ± 35%  interrupts.CPU146.TLB:TLB_shootdowns
>        1161 ± 27%   +1038.3%      13224 ± 21%  interrupts.CPU147.CAL:Function_call_interrupts
>      197.25 ±  2%   +2361.7%       4855 ± 39%  interrupts.CPU147.NMI:Non-maskable_interrupts
>      197.25 ±  2%   +2361.7%       4855 ± 39%  interrupts.CPU147.PMI:Performance_monitoring_interrupts
>        1253 ± 27%     -76.8%     291.25 ± 23%  interrupts.CPU147.RES:Rescheduling_interrupts
>       12.25 ± 63%   +4467.3%     559.50 ± 29%  interrupts.CPU147.TLB:TLB_shootdowns
>        1127 ± 13%   +1099.5%      13527 ±  8%  interrupts.CPU148.CAL:Function_call_interrupts
>      200.75 ±  3%   +2706.2%       5633 ± 37%  interrupts.CPU148.NMI:Non-maskable_interrupts
>      200.75 ±  3%   +2706.2%       5633 ± 37%  interrupts.CPU148.PMI:Performance_monitoring_interrupts
>        1375 ± 15%     -79.6%     280.25 ± 12%  interrupts.CPU148.RES:Rescheduling_interrupts
>       16.50 ± 29%   +3775.8%     639.50 ± 10%  interrupts.CPU148.TLB:TLB_shootdowns
>        1132 ± 13%   +1194.9%      14664 ± 19%  interrupts.CPU149.CAL:Function_call_interrupts
>      197.50 ±  2%   +2371.9%       4882 ± 33%  interrupts.CPU149.NMI:Non-maskable_interrupts
>      197.50 ±  2%   +2371.9%       4882 ± 33%  interrupts.CPU149.PMI:Performance_monitoring_interrupts
>        1546 ± 22%     -81.7%     283.50 ± 12%  interrupts.CPU149.RES:Rescheduling_interrupts
>       34.75 ± 42%   +1830.2%     670.75 ± 17%  interrupts.CPU149.TLB:TLB_shootdowns
>        1273 ± 32%   +1440.2%      19606 ± 13%  interrupts.CPU15.CAL:Function_call_interrupts
>      201.00 ±  2%   +2902.0%       6034 ± 26%  interrupts.CPU15.NMI:Non-maskable_interrupts
>      201.00 ±  2%   +2902.0%       6034 ± 26%  interrupts.CPU15.PMI:Performance_monitoring_interrupts
>        7.25 ± 54%  +11358.6%     830.75 ± 21%  interrupts.CPU15.TLB:TLB_shootdowns
>        1135 ± 14%   +1192.5%      14676 ± 21%  interrupts.CPU150.CAL:Function_call_interrupts
>      172.25 ± 25%   +2381.3%       4274 ± 34%  interrupts.CPU150.NMI:Non-maskable_interrupts
>      172.25 ± 25%   +2381.3%       4274 ± 34%  interrupts.CPU150.PMI:Performance_monitoring_interrupts
>        1234 ± 23%     -76.3%     292.00 ± 14%  interrupts.CPU150.RES:Rescheduling_interrupts
>       12.25 ± 38%   +5240.8%     654.25 ± 23%  interrupts.CPU150.TLB:TLB_shootdowns
>        1328 ± 22%    +941.4%      13832 ± 15%  interrupts.CPU151.CAL:Function_call_interrupts
>      171.25 ± 25%   +2801.0%       4968 ± 33%  interrupts.CPU151.NMI:Non-maskable_interrupts
>      171.25 ± 25%   +2801.0%       4968 ± 33%  interrupts.CPU151.PMI:Performance_monitoring_interrupts
>        1492 ± 11%     -82.1%     266.75 ± 15%  interrupts.CPU151.RES:Rescheduling_interrupts
>       18.25 ± 35%   +2826.0%     534.00 ± 30%  interrupts.CPU151.TLB:TLB_shootdowns
>        1203 ±  6%   +1112.1%      14588 ± 18%  interrupts.CPU152.CAL:Function_call_interrupts
>      171.50 ± 25%   +2989.7%       5298 ± 26%  interrupts.CPU152.NMI:Non-maskable_interrupts
>      171.50 ± 25%   +2989.7%       5298 ± 26%  interrupts.CPU152.PMI:Performance_monitoring_interrupts
>        1402 ± 26%     -79.6%     285.50 ± 12%  interrupts.CPU152.RES:Rescheduling_interrupts
>       12.50 ± 47%   +4642.0%     592.75 ± 15%  interrupts.CPU152.TLB:TLB_shootdowns
>        1075 ±  5%   +1003.9%      11870 ± 26%  interrupts.CPU153.CAL:Function_call_interrupts
>      178.50 ± 27%   +3121.7%       5750 ± 17%  interrupts.CPU153.NMI:Non-maskable_interrupts
>      178.50 ± 27%   +3121.7%       5750 ± 17%  interrupts.CPU153.PMI:Performance_monitoring_interrupts
>        1309 ± 26%     -79.7%     265.25 ± 24%  interrupts.CPU153.RES:Rescheduling_interrupts
>       33.00 ±119%   +1569.7%     551.00 ± 32%  interrupts.CPU153.TLB:TLB_shootdowns
>        1275 ± 18%    +953.4%      13433 ± 13%  interrupts.CPU154.CAL:Function_call_interrupts
>      174.25 ± 25%   +3646.2%       6527 ± 22%  interrupts.CPU154.NMI:Non-maskable_interrupts
>      174.25 ± 25%   +3646.2%       6527 ± 22%  interrupts.CPU154.PMI:Performance_monitoring_interrupts
>        1363 ± 24%     -79.2%     283.75 ± 12%  interrupts.CPU154.RES:Rescheduling_interrupts
>       19.75 ± 27%   +2900.0%     592.50 ± 15%  interrupts.CPU154.TLB:TLB_shootdowns
>        1179 ± 10%   +1137.7%      14592 ± 20%  interrupts.CPU155.CAL:Function_call_interrupts
>      172.50 ± 25%   +4136.8%       7308 ± 15%  interrupts.CPU155.NMI:Non-maskable_interrupts
>      172.50 ± 25%   +4136.8%       7308 ± 15%  interrupts.CPU155.PMI:Performance_monitoring_interrupts
>        1368 ± 17%     -78.3%     297.25 ± 18%  interrupts.CPU155.RES:Rescheduling_interrupts
>       17.00 ± 39%   +3847.1%     671.00 ±  8%  interrupts.CPU155.TLB:TLB_shootdowns
>        1130 ± 15%   +1116.7%      13754 ±  8%  interrupts.CPU156.CAL:Function_call_interrupts
>      171.00 ± 23%   +3322.1%       5851 ± 16%  interrupts.CPU156.NMI:Non-maskable_interrupts
>      171.00 ± 23%   +3322.1%       5851 ± 16%  interrupts.CPU156.PMI:Performance_monitoring_interrupts
>        1229 ± 24%     -78.5%     264.25 ± 18%  interrupts.CPU156.RES:Rescheduling_interrupts
>       19.00 ± 69%   +3373.7%     660.00 ± 10%  interrupts.CPU156.TLB:TLB_shootdowns
>        1025 ±  7%   +1280.2%      14154 ± 26%  interrupts.CPU157.CAL:Function_call_interrupts
>      170.50 ± 25%   +3323.3%       5836 ± 12%  interrupts.CPU157.NMI:Non-maskable_interrupts
>      170.50 ± 25%   +3323.3%       5836 ± 12%  interrupts.CPU157.PMI:Performance_monitoring_interrupts
>        1303 ± 12%     -79.6%     265.50 ± 27%  interrupts.CPU157.RES:Rescheduling_interrupts
>       20.50 ±100%   +2854.9%     605.75 ±  5%  interrupts.CPU157.TLB:TLB_shootdowns
>        1248 ± 13%   +1136.5%      15432 ±  6%  interrupts.CPU158.CAL:Function_call_interrupts
>      146.25 ± 35%   +3346.5%       5040 ± 26%  interrupts.CPU158.NMI:Non-maskable_interrupts
>      146.25 ± 35%   +3346.5%       5040 ± 26%  interrupts.CPU158.PMI:Performance_monitoring_interrupts
>        1532 ± 23%     -78.8%     324.75 ± 18%  interrupts.CPU158.RES:Rescheduling_interrupts
>       15.00 ± 37%   +4298.3%     659.75 ± 34%  interrupts.CPU158.TLB:TLB_shootdowns
>        1242 ±  7%    +942.0%      12942 ± 12%  interrupts.CPU159.CAL:Function_call_interrupts
>      148.50 ± 36%   +3184.8%       4878 ± 21%  interrupts.CPU159.NMI:Non-maskable_interrupts
>      148.50 ± 36%   +3184.8%       4878 ± 21%  interrupts.CPU159.PMI:Performance_monitoring_interrupts
>        1268 ± 21%     -79.8%     256.75 ± 20%  interrupts.CPU159.RES:Rescheduling_interrupts
>       32.50 ± 90%   +1569.2%     542.50 ± 16%  interrupts.CPU159.TLB:TLB_shootdowns
>        1106 ±  8%   +1676.8%      19659 ± 12%  interrupts.CPU16.CAL:Function_call_interrupts
>      205.75 ±  3%   +2565.1%       5483 ± 36%  interrupts.CPU16.NMI:Non-maskable_interrupts
>      205.75 ±  3%   +2565.1%       5483 ± 36%  interrupts.CPU16.PMI:Performance_monitoring_interrupts
>        1281 ± 30%     -67.6%     414.50 ± 13%  interrupts.CPU16.RES:Rescheduling_interrupts
>       21.50 ± 55%   +4008.1%     883.25 ±  6%  interrupts.CPU16.TLB:TLB_shootdowns
>        1168 ± 12%   +1036.9%      13284 ± 14%  interrupts.CPU160.CAL:Function_call_interrupts
>      144.25 ± 34%   +4039.7%       5971 ± 30%  interrupts.CPU160.NMI:Non-maskable_interrupts
>      144.25 ± 34%   +4039.7%       5971 ± 30%  interrupts.CPU160.PMI:Performance_monitoring_interrupts
>        1048 ± 27%     -76.3%     249.00 ± 16%  interrupts.CPU160.RES:Rescheduling_interrupts
>       11.00 ± 38%   +6231.8%     696.50 ± 11%  interrupts.CPU160.TLB:TLB_shootdowns
>        1106 ± 14%   +1200.8%      14396 ± 18%  interrupts.CPU161.CAL:Function_call_interrupts
>      147.25 ± 33%   +3577.9%       5415 ± 14%  interrupts.CPU161.NMI:Non-maskable_interrupts
>      147.25 ± 33%   +3577.9%       5415 ± 14%  interrupts.CPU161.PMI:Performance_monitoring_interrupts
>        1495 ± 15%     -80.4%     293.25 ± 17%  interrupts.CPU161.RES:Rescheduling_interrupts
>       18.25 ±  5%   +3780.8%     708.25 ±  8%  interrupts.CPU161.TLB:TLB_shootdowns
>        1217 ± 23%    +998.1%      13369 ± 14%  interrupts.CPU162.CAL:Function_call_interrupts
>      153.25 ± 33%   +3249.8%       5133 ± 37%  interrupts.CPU162.NMI:Non-maskable_interrupts
>      153.25 ± 33%   +3249.8%       5133 ± 37%  interrupts.CPU162.PMI:Performance_monitoring_interrupts
>        1321 ± 29%     -81.0%     251.50 ± 14%  interrupts.CPU162.RES:Rescheduling_interrupts
>       30.50 ± 62%   +1946.7%     624.25 ±  8%  interrupts.CPU162.TLB:TLB_shootdowns
>        1071 ±  4%   +1210.4%      14044 ± 12%  interrupts.CPU163.CAL:Function_call_interrupts
>      146.50 ± 34%   +3657.0%       5504 ± 31%  interrupts.CPU163.NMI:Non-maskable_interrupts
>      146.50 ± 34%   +3657.0%       5504 ± 31%  interrupts.CPU163.PMI:Performance_monitoring_interrupts
>        1582 ± 14%     -82.1%     283.00 ± 11%  interrupts.CPU163.RES:Rescheduling_interrupts
>       11.75 ± 21%   +5280.9%     632.25 ± 14%  interrupts.CPU163.TLB:TLB_shootdowns
>        1089 ± 10%   +1103.2%      13105 ± 10%  interrupts.CPU164.CAL:Function_call_interrupts
>      147.75 ± 36%   +3304.1%       5029 ± 51%  interrupts.CPU164.NMI:Non-maskable_interrupts
>      147.75 ± 36%   +3304.1%       5029 ± 51%  interrupts.CPU164.PMI:Performance_monitoring_interrupts
>        1245 ± 28%     -79.0%     261.25 ± 13%  interrupts.CPU164.RES:Rescheduling_interrupts
>       24.00 ± 80%   +2418.8%     604.50 ± 14%  interrupts.CPU164.TLB:TLB_shootdowns
>        1067 ±  6%   +1151.9%      13361 ± 13%  interrupts.CPU165.CAL:Function_call_interrupts
>      147.50 ± 34%   +4051.4%       6123 ± 28%  interrupts.CPU165.NMI:Non-maskable_interrupts
>      147.50 ± 34%   +4051.4%       6123 ± 28%  interrupts.CPU165.PMI:Performance_monitoring_interrupts
>        1398 ± 30%     -79.5%     286.25 ± 18%  interrupts.CPU165.RES:Rescheduling_interrupts
>       22.00 ± 73%   +2510.2%     574.25 ± 24%  interrupts.CPU165.TLB:TLB_shootdowns
>        1009 ±  8%   +1390.8%      15053 ± 11%  interrupts.CPU166.CAL:Function_call_interrupts
>      152.00 ± 36%   +3428.5%       5363 ± 26%  interrupts.CPU166.NMI:Non-maskable_interrupts
>      152.00 ± 36%   +3428.5%       5363 ± 26%  interrupts.CPU166.PMI:Performance_monitoring_interrupts
>        1299 ± 12%     -76.7%     302.75 ± 12%  interrupts.CPU166.RES:Rescheduling_interrupts
>        9.50 ± 39%   +6428.9%     620.25 ± 13%  interrupts.CPU166.TLB:TLB_shootdowns
>        1049 ± 12%   +1315.0%      14850 ±  8%  interrupts.CPU167.CAL:Function_call_interrupts
>      157.00 ± 40%   +3769.9%       6075 ± 41%  interrupts.CPU167.NMI:Non-maskable_interrupts
>      157.00 ± 40%   +3769.9%       6075 ± 41%  interrupts.CPU167.PMI:Performance_monitoring_interrupts
>        1629 ±  6%     -81.5%     302.00 ± 19%  interrupts.CPU167.RES:Rescheduling_interrupts
>       14.50 ± 25%   +4098.3%     608.75 ± 20%  interrupts.CPU167.TLB:TLB_shootdowns
>        1799 ± 40%    +813.1%      16428 ±  3%  interrupts.CPU168.CAL:Function_call_interrupts
>      181.00 ± 24%   +3204.0%       5980 ± 34%  interrupts.CPU168.NMI:Non-maskable_interrupts
>      181.00 ± 24%   +3204.0%       5980 ± 34%  interrupts.CPU168.PMI:Performance_monitoring_interrupts
>      987.50 ± 10%     -70.2%     294.50 ± 12%  interrupts.CPU168.RES:Rescheduling_interrupts
>       20.75 ± 81%   +3185.5%     681.75 ± 19%  interrupts.CPU168.TLB:TLB_shootdowns
>        1475 ± 21%    +927.6%      15162 ± 10%  interrupts.CPU169.CAL:Function_call_interrupts
>      178.25 ± 22%   +3114.6%       5730 ± 22%  interrupts.CPU169.NMI:Non-maskable_interrupts
>      178.25 ± 22%   +3114.6%       5730 ± 22%  interrupts.CPU169.PMI:Performance_monitoring_interrupts
>        1203 ± 19%     -75.2%     298.00 ± 19%  interrupts.CPU169.RES:Rescheduling_interrupts
>       46.00 ± 95%   +1379.9%     680.75 ± 19%  interrupts.CPU169.TLB:TLB_shootdowns
>        1073 ± 12%   +1504.9%      17232 ± 11%  interrupts.CPU17.CAL:Function_call_interrupts
>      203.75 ±  2%   +1949.0%       4174 ± 15%  interrupts.CPU17.NMI:Non-maskable_interrupts
>      203.75 ±  2%   +1949.0%       4174 ± 15%  interrupts.CPU17.PMI:Performance_monitoring_interrupts
>        1024 ± 30%     -66.9%     339.25 ± 16%  interrupts.CPU17.RES:Rescheduling_interrupts
>       16.75 ±105%   +4129.9%     708.50 ± 12%  interrupts.CPU17.TLB:TLB_shootdowns
>        1363 ± 13%    +986.6%      14813 ± 10%  interrupts.CPU170.CAL:Function_call_interrupts
>      175.50 ± 26%   +3093.4%       5604 ± 28%  interrupts.CPU170.NMI:Non-maskable_interrupts
>      175.50 ± 26%   +3093.4%       5604 ± 28%  interrupts.CPU170.PMI:Performance_monitoring_interrupts
>        1143 ± 37%     -76.2%     272.75 ± 21%  interrupts.CPU170.RES:Rescheduling_interrupts
>       23.25 ±111%   +2730.1%     658.00 ±  8%  interrupts.CPU170.TLB:TLB_shootdowns
>        1430 ±  9%    +994.8%      15658 ±  9%  interrupts.CPU171.CAL:Function_call_interrupts
>      188.50 ± 30%   +2864.6%       5588 ± 24%  interrupts.CPU171.NMI:Non-maskable_interrupts
>      188.50 ± 30%   +2864.6%       5588 ± 24%  interrupts.CPU171.PMI:Performance_monitoring_interrupts
>        1123 ± 33%     -76.3%     266.25 ± 12%  interrupts.CPU171.RES:Rescheduling_interrupts
>       10.25 ± 24%   +6714.6%     698.50 ± 12%  interrupts.CPU171.TLB:TLB_shootdowns
>        1565 ± 49%    +811.5%      14268 ± 15%  interrupts.CPU172.CAL:Function_call_interrupts
>      208.25 ±  5%   +2480.3%       5373 ± 31%  interrupts.CPU172.NMI:Non-maskable_interrupts
>      208.25 ±  5%   +2480.3%       5373 ± 31%  interrupts.CPU172.PMI:Performance_monitoring_interrupts
>       35.25 ±128%   +1641.1%     613.75 ± 11%  interrupts.CPU172.TLB:TLB_shootdowns
>        1228 ± 15%   +1209.1%      16085 ± 12%  interrupts.CPU173.CAL:Function_call_interrupts
>      203.00 ±  4%   +3154.1%       6605 ± 13%  interrupts.CPU173.NMI:Non-maskable_interrupts
>      203.00 ±  4%   +3154.1%       6605 ± 13%  interrupts.CPU173.PMI:Performance_monitoring_interrupts
>        1248 ± 26%     -78.0%     274.50 ± 21%  interrupts.CPU173.RES:Rescheduling_interrupts
>       33.50 ± 62%   +1862.7%     657.50 ± 27%  interrupts.CPU173.TLB:TLB_shootdowns
>        1070 ±  8%   +1239.8%      14338 ± 11%  interrupts.CPU174.CAL:Function_call_interrupts
>      203.50 ±  4%   +2676.9%       5651 ± 18%  interrupts.CPU174.NMI:Non-maskable_interrupts
>      203.50 ±  4%   +2676.9%       5651 ± 18%  interrupts.CPU174.PMI:Performance_monitoring_interrupts
>       19.50 ± 70%   +3064.1%     617.00 ±  9%  interrupts.CPU174.TLB:TLB_shootdowns
>        1468 ± 19%   +1011.8%      16329 ±  3%  interrupts.CPU175.CAL:Function_call_interrupts
>      200.50 ±  3%   +2875.7%       5966 ± 16%  interrupts.CPU175.NMI:Non-maskable_interrupts
>      200.50 ±  3%   +2875.7%       5966 ± 16%  interrupts.CPU175.PMI:Performance_monitoring_interrupts
>        1106 ± 31%     -75.1%     275.25 ±  7%  interrupts.CPU175.RES:Rescheduling_interrupts
>       28.75 ± 60%   +2479.1%     741.50 ± 14%  interrupts.CPU175.TLB:TLB_shootdowns
>        1393 ±  8%    +876.9%      13611 ±  8%  interrupts.CPU176.CAL:Function_call_interrupts
>      200.00 ±  3%   +3190.5%       6581 ± 13%  interrupts.CPU176.NMI:Non-maskable_interrupts
>      200.00 ±  3%   +3190.5%       6581 ± 13%  interrupts.CPU176.PMI:Performance_monitoring_interrupts
>      971.50 ± 11%     -71.1%     280.75 ±  7%  interrupts.CPU176.RES:Rescheduling_interrupts
>       14.00 ± 49%   +5275.0%     752.50 ±  6%  interrupts.CPU176.TLB:TLB_shootdowns
>        1394 ± 12%    +803.9%      12600 ±  6%  interrupts.CPU177.CAL:Function_call_interrupts
>      202.25 ±  2%   +2877.6%       6022 ± 13%  interrupts.CPU177.NMI:Non-maskable_interrupts
>      202.25 ±  2%   +2877.6%       6022 ± 13%  interrupts.CPU177.PMI:Performance_monitoring_interrupts
>        1117 ± 18%     -76.0%     268.00 ± 21%  interrupts.CPU177.RES:Rescheduling_interrupts
>       14.00 ± 26%   +4117.9%     590.50 ± 14%  interrupts.CPU177.TLB:TLB_shootdowns
>        1430 ± 15%    +968.2%      15281 ±  4%  interrupts.CPU178.CAL:Function_call_interrupts
>      207.25 ±  9%   +2723.2%       5851 ± 21%  interrupts.CPU178.NMI:Non-maskable_interrupts
>      207.25 ±  9%   +2723.2%       5851 ± 21%  interrupts.CPU178.PMI:Performance_monitoring_interrupts
>      916.50 ± 21%     -74.1%     237.25 ±  6%  interrupts.CPU178.RES:Rescheduling_interrupts
>       20.50 ± 69%   +2967.1%     628.75 ± 12%  interrupts.CPU178.TLB:TLB_shootdowns
>        1350 ± 12%    +866.1%      13042 ± 16%  interrupts.CPU179.CAL:Function_call_interrupts
>      203.25 ±  3%   +2323.0%       4924 ± 28%  interrupts.CPU179.NMI:Non-maskable_interrupts
>      203.25 ±  3%   +2323.0%       4924 ± 28%  interrupts.CPU179.PMI:Performance_monitoring_interrupts
>        1495 ± 14%     -83.6%     245.75 ± 12%  interrupts.CPU179.RES:Rescheduling_interrupts
>       23.75 ± 76%   +2553.7%     630.25 ± 17%  interrupts.CPU179.TLB:TLB_shootdowns
>        1155 ±  9%   +1583.0%      19451 ± 15%  interrupts.CPU18.CAL:Function_call_interrupts
>      202.50 ±  3%   +2122.7%       4501 ± 44%  interrupts.CPU18.NMI:Non-maskable_interrupts
>      202.50 ±  3%   +2122.7%       4501 ± 44%  interrupts.CPU18.PMI:Performance_monitoring_interrupts
>        1107 ± 20%     -67.0%     365.50 ± 24%  interrupts.CPU18.RES:Rescheduling_interrupts
>        5.50 ± 32%  +14081.8%     780.00 ± 15%  interrupts.CPU18.TLB:TLB_shootdowns
>        1327 ±  4%   +1054.4%      15324 ±  6%  interrupts.CPU180.CAL:Function_call_interrupts
>      179.25 ± 26%   +3402.6%       6278 ± 12%  interrupts.CPU180.NMI:Non-maskable_interrupts
>      179.25 ± 26%   +3402.6%       6278 ± 12%  interrupts.CPU180.PMI:Performance_monitoring_interrupts
>        1134 ± 19%     -78.7%     241.25 ± 21%  interrupts.CPU180.RES:Rescheduling_interrupts
>       19.75 ± 59%   +3427.8%     696.75 ± 11%  interrupts.CPU180.TLB:TLB_shootdowns
>        1279 ±  5%    +947.7%      13403 ±  8%  interrupts.CPU181.CAL:Function_call_interrupts
>      184.50 ± 25%   +3133.9%       5966 ± 15%  interrupts.CPU181.NMI:Non-maskable_interrupts
>      184.50 ± 25%   +3133.9%       5966 ± 15%  interrupts.CPU181.PMI:Performance_monitoring_interrupts
>        1399 ±  8%     -83.7%     228.75 ± 21%  interrupts.CPU181.RES:Rescheduling_interrupts
>       17.25 ± 49%   +3360.9%     597.00 ± 14%  interrupts.CPU181.TLB:TLB_shootdowns
>        1176 ± 11%    +971.9%      12610 ± 12%  interrupts.CPU182.CAL:Function_call_interrupts
>      179.75 ± 27%   +2885.3%       5366 ± 25%  interrupts.CPU182.NMI:Non-maskable_interrupts
>      179.75 ± 27%   +2885.3%       5366 ± 25%  interrupts.CPU182.PMI:Performance_monitoring_interrupts
>      813.25 ± 28%     -70.0%     244.25 ± 24%  interrupts.CPU182.RES:Rescheduling_interrupts
>        9.25 ± 55%   +7583.8%     710.75 ± 18%  interrupts.CPU182.TLB:TLB_shootdowns
>        1458 ± 24%    +788.6%      12958 ± 14%  interrupts.CPU183.CAL:Function_call_interrupts
>      177.00 ± 27%   +3059.6%       5592 ±  8%  interrupts.CPU183.NMI:Non-maskable_interrupts
>      177.00 ± 27%   +3059.6%       5592 ±  8%  interrupts.CPU183.PMI:Performance_monitoring_interrupts
>        1085 ± 28%     -78.8%     229.75 ± 12%  interrupts.CPU183.RES:Rescheduling_interrupts
>       22.00 ± 71%   +2365.9%     542.50 ± 23%  interrupts.CPU183.TLB:TLB_shootdowns
>        1143 ±  6%   +1166.9%      14480 ±  6%  interrupts.CPU184.CAL:Function_call_interrupts
>      178.00 ± 27%   +3791.3%       6926 ± 14%  interrupts.CPU184.NMI:Non-maskable_interrupts
>      178.00 ± 27%   +3791.3%       6926 ± 14%  interrupts.CPU184.PMI:Performance_monitoring_interrupts
>        1061 ± 17%     -73.8%     278.25 ± 19%  interrupts.CPU184.RES:Rescheduling_interrupts
>       11.00 ± 43%   +5834.1%     652.75 ± 26%  interrupts.CPU184.TLB:TLB_shootdowns
>        1274 ± 11%    +969.3%      13628 ±  4%  interrupts.CPU185.CAL:Function_call_interrupts
>      181.75 ± 27%   +3123.4%       5858 ± 34%  interrupts.CPU185.NMI:Non-maskable_interrupts
>      181.75 ± 27%   +3123.4%       5858 ± 34%  interrupts.CPU185.PMI:Performance_monitoring_interrupts
>        1332 ± 19%     -82.9%     227.50 ±  5%  interrupts.CPU185.RES:Rescheduling_interrupts
>       15.00 ± 30%   +3793.3%     584.00 ± 10%  interrupts.CPU185.TLB:TLB_shootdowns
>        1452 ± 24%    +830.7%      13514 ± 13%  interrupts.CPU186.CAL:Function_call_interrupts
>      175.75 ± 26%   +2956.8%       5372 ± 35%  interrupts.CPU186.NMI:Non-maskable_interrupts
>      175.75 ± 26%   +2956.8%       5372 ± 35%  interrupts.CPU186.PMI:Performance_monitoring_interrupts
>        1349 ± 18%     -83.2%     226.75 ± 14%  interrupts.CPU186.RES:Rescheduling_interrupts
>       21.50 ± 44%   +2820.9%     628.00 ± 15%  interrupts.CPU186.TLB:TLB_shootdowns
>        1241 ± 14%    +969.0%      13269 ±  6%  interrupts.CPU187.CAL:Function_call_interrupts
>      177.25 ± 26%   +2643.6%       4863 ± 33%  interrupts.CPU187.NMI:Non-maskable_interrupts
>      177.25 ± 26%   +2643.6%       4863 ± 33%  interrupts.CPU187.PMI:Performance_monitoring_interrupts
>        1196 ± 46%     -79.0%     251.25 ± 23%  interrupts.CPU187.RES:Rescheduling_interrupts
>       21.25 ± 42%   +2525.9%     558.00 ± 23%  interrupts.CPU187.TLB:TLB_shootdowns
>        1401 ± 16%    +720.2%      11493 ± 12%  interrupts.CPU188.CAL:Function_call_interrupts
>      182.50 ± 27%   +2534.8%       4808 ± 31%  interrupts.CPU188.NMI:Non-maskable_interrupts
>      182.50 ± 27%   +2534.8%       4808 ± 31%  interrupts.CPU188.PMI:Performance_monitoring_interrupts
>        1079 ± 23%     -80.9%     206.50 ± 17%  interrupts.CPU188.RES:Rescheduling_interrupts
>       13.75 ± 13%   +3150.9%     447.00 ± 23%  interrupts.CPU188.TLB:TLB_shootdowns
>        1352 ± 11%    +881.9%      13277 ± 16%  interrupts.CPU189.CAL:Function_call_interrupts
>      179.50 ± 26%   +2773.8%       5158 ± 37%  interrupts.CPU189.NMI:Non-maskable_interrupts
>      179.50 ± 26%   +2773.8%       5158 ± 37%  interrupts.CPU189.PMI:Performance_monitoring_interrupts
>        1375 ± 28%     -82.5%     240.25 ± 17%  interrupts.CPU189.RES:Rescheduling_interrupts
>       35.25 ± 48%   +1895.7%     703.50 ± 19%  interrupts.CPU189.TLB:TLB_shootdowns
>        1156 ±  4%   +1495.6%      18453 ± 14%  interrupts.CPU19.CAL:Function_call_interrupts
>      204.50         +2211.9%       4727 ± 23%  interrupts.CPU19.NMI:Non-maskable_interrupts
>      204.50         +2211.9%       4727 ± 23%  interrupts.CPU19.PMI:Performance_monitoring_interrupts
>        1344 ± 21%     -69.5%     410.50 ± 15%  interrupts.CPU19.RES:Rescheduling_interrupts
>       12.25 ± 15%   +6300.0%     784.00 ±  7%  interrupts.CPU19.TLB:TLB_shootdowns
>        1154 ±  6%    +947.2%      12092 ± 11%  interrupts.CPU190.CAL:Function_call_interrupts
>      176.75 ± 26%   +2962.0%       5412 ± 25%  interrupts.CPU190.NMI:Non-maskable_interrupts
>      176.75 ± 26%   +2962.0%       5412 ± 25%  interrupts.CPU190.PMI:Performance_monitoring_interrupts
>        1021 ± 17%     -79.4%     210.25 ± 23%  interrupts.CPU190.RES:Rescheduling_interrupts
>       18.00 ± 25%   +2488.9%     466.00 ± 17%  interrupts.CPU190.TLB:TLB_shootdowns
>        1060 ± 12%    +354.3%       4815 ± 10%  interrupts.CPU191.CAL:Function_call_interrupts
>      183.25 ± 25%   +2279.8%       4361 ± 29%  interrupts.CPU191.NMI:Non-maskable_interrupts
>      183.25 ± 25%   +2279.8%       4361 ± 29%  interrupts.CPU191.PMI:Performance_monitoring_interrupts
>      642.50 ± 26%     -85.0%      96.50 ± 11%  interrupts.CPU191.RES:Rescheduling_interrupts
>        1533 ± 33%   +1016.4%      17117 ±  4%  interrupts.CPU2.CAL:Function_call_interrupts
>      211.75 ±  8%   +3240.4%       7073 ± 16%  interrupts.CPU2.NMI:Non-maskable_interrupts
>      211.75 ±  8%   +3240.4%       7073 ± 16%  interrupts.CPU2.PMI:Performance_monitoring_interrupts
>        1065 ±  7%     -64.9%     374.25 ± 10%  interrupts.CPU2.RES:Rescheduling_interrupts
>        9.75 ± 48%   +8120.5%     801.50 ± 17%  interrupts.CPU2.TLB:TLB_shootdowns
>        1158 ±  9%   +1451.8%      17977 ± 18%  interrupts.CPU20.CAL:Function_call_interrupts
>      206.50 ±  4%   +1652.7%       3619 ± 28%  interrupts.CPU20.NMI:Non-maskable_interrupts
>      206.50 ±  4%   +1652.7%       3619 ± 28%  interrupts.CPU20.PMI:Performance_monitoring_interrupts
>        1099 ± 49%     -65.9%     375.00 ± 16%  interrupts.CPU20.RES:Rescheduling_interrupts
>       20.75 ± 86%   +4350.6%     923.50 ±  7%  interrupts.CPU20.TLB:TLB_shootdowns
>        4622 ±128%    +288.3%      17949 ± 16%  interrupts.CPU21.CAL:Function_call_interrupts
>      175.25 ± 24%   +2803.9%       5089 ± 22%  interrupts.CPU21.NMI:Non-maskable_interrupts
>      175.25 ± 24%   +2803.9%       5089 ± 22%  interrupts.CPU21.PMI:Performance_monitoring_interrupts
>        1170 ± 33%     -65.3%     405.50 ± 16%  interrupts.CPU21.RES:Rescheduling_interrupts
>        9.75 ±  8%   +8459.0%     834.50 ± 23%  interrupts.CPU21.TLB:TLB_shootdowns
>        1130 ±  8%   +1540.3%      18539 ± 19%  interrupts.CPU22.CAL:Function_call_interrupts
>      181.75 ± 26%   +2270.2%       4307 ± 15%  interrupts.CPU22.NMI:Non-maskable_interrupts
>      181.75 ± 26%   +2270.2%       4307 ± 15%  interrupts.CPU22.PMI:Performance_monitoring_interrupts
>        1330 ± 25%     -70.1%     398.00 ± 20%  interrupts.CPU22.RES:Rescheduling_interrupts
>       10.25 ± 54%   +8246.3%     855.50 ± 15%  interrupts.CPU22.TLB:TLB_shootdowns
>        1130 ± 12%   +1531.3%      18446 ± 13%  interrupts.CPU23.CAL:Function_call_interrupts
>      177.50 ± 23%   +2556.3%       4715 ± 31%  interrupts.CPU23.NMI:Non-maskable_interrupts
>      177.50 ± 23%   +2556.3%       4715 ± 31%  interrupts.CPU23.PMI:Performance_monitoring_interrupts
>        1240 ±  6%     -68.6%     389.75 ± 15%  interrupts.CPU23.RES:Rescheduling_interrupts
>       33.00 ± 84%   +2371.2%     815.50 ±  6%  interrupts.CPU23.TLB:TLB_shootdowns
>        1247 ± 11%   +1214.2%      16394 ± 13%  interrupts.CPU24.CAL:Function_call_interrupts
>      180.25 ± 27%   +3176.8%       5906 ± 31%  interrupts.CPU24.NMI:Non-maskable_interrupts
>      180.25 ± 27%   +3176.8%       5906 ± 31%  interrupts.CPU24.PMI:Performance_monitoring_interrupts
>      934.00 ±  6%     -59.9%     374.25 ± 17%  interrupts.CPU24.RES:Rescheduling_interrupts
>       12.50 ± 36%   +6030.0%     766.25 ± 12%  interrupts.CPU24.TLB:TLB_shootdowns
>        1104 ± 13%   +1607.5%      18855 ± 21%  interrupts.CPU25.CAL:Function_call_interrupts
>      199.75 ±  3%   +2961.6%       6115 ± 38%  interrupts.CPU25.NMI:Non-maskable_interrupts
>      199.75 ±  3%   +2961.6%       6115 ± 38%  interrupts.CPU25.PMI:Performance_monitoring_interrupts
>        1100 ± 41%     -59.5%     445.25 ± 14%  interrupts.CPU25.RES:Rescheduling_interrupts
>        9.00 ± 47%   +9119.4%     829.75 ± 13%  interrupts.CPU25.TLB:TLB_shootdowns
>        1463 ± 17%   +1091.0%      17433 ±  4%  interrupts.CPU26.CAL:Function_call_interrupts
>      199.25 ±  4%   +2527.7%       5235 ± 37%  interrupts.CPU26.NMI:Non-maskable_interrupts
>      199.25 ±  4%   +2527.7%       5235 ± 37%  interrupts.CPU26.PMI:Performance_monitoring_interrupts
>        1474 ± 18%     -73.8%     386.25 ± 25%  interrupts.CPU26.RES:Rescheduling_interrupts
>       11.75 ± 38%   +6944.7%     827.75 ± 14%  interrupts.CPU26.TLB:TLB_shootdowns
>        1148 ± 17%   +1236.0%      15346 ±  6%  interrupts.CPU27.CAL:Function_call_interrupts
>      204.50 ±  4%   +2298.5%       4905 ± 40%  interrupts.CPU27.NMI:Non-maskable_interrupts
>      204.50 ±  4%   +2298.5%       4905 ± 40%  interrupts.CPU27.PMI:Performance_monitoring_interrupts
>        1265 ± 31%     -69.6%     384.50 ± 20%  interrupts.CPU27.RES:Rescheduling_interrupts
>       24.00 ± 68%   +3257.3%     805.75 ± 20%  interrupts.CPU27.TLB:TLB_shootdowns
>        1024 ±  5%   +1668.9%      18118 ±  7%  interrupts.CPU28.CAL:Function_call_interrupts
>      198.25 ±  3%   +3294.2%       6729 ± 16%  interrupts.CPU28.NMI:Non-maskable_interrupts
>      198.25 ±  3%   +3294.2%       6729 ± 16%  interrupts.CPU28.PMI:Performance_monitoring_interrupts
>        1301 ±  8%     -69.6%     395.00 ±  6%  interrupts.CPU28.RES:Rescheduling_interrupts
>       32.25 ± 61%   +2263.6%     762.25 ± 11%  interrupts.CPU28.TLB:TLB_shootdowns
>        1072 ±  7%   +1619.3%      18435 ± 11%  interrupts.CPU29.CAL:Function_call_interrupts
>      200.00 ±  3%   +3180.0%       6560 ± 13%  interrupts.CPU29.NMI:Non-maskable_interrupts
>      200.00 ±  3%   +3180.0%       6560 ± 13%  interrupts.CPU29.PMI:Performance_monitoring_interrupts
>        1335 ± 15%     -68.9%     415.75 ± 11%  interrupts.CPU29.RES:Rescheduling_interrupts
>       23.50 ± 56%   +3357.4%     812.50 ±  7%  interrupts.CPU29.TLB:TLB_shootdowns
>        1328 ± 33%   +1287.1%      18424 ± 17%  interrupts.CPU3.CAL:Function_call_interrupts
>      204.00 ±  3%   +3221.1%       6775 ± 15%  interrupts.CPU3.NMI:Non-maskable_interrupts
>      204.00 ±  3%   +3221.1%       6775 ± 15%  interrupts.CPU3.PMI:Performance_monitoring_interrupts
>        1256 ±  9%     -70.6%     369.25 ± 13%  interrupts.CPU3.RES:Rescheduling_interrupts
>       11.75 ± 46%   +6491.5%     774.50 ± 10%  interrupts.CPU3.TLB:TLB_shootdowns
>        1028 ±  3%   +1513.6%      16588 ± 12%  interrupts.CPU30.CAL:Function_call_interrupts
>      194.50 ±  2%   +3653.2%       7300 ± 20%  interrupts.CPU30.NMI:Non-maskable_interrupts
>      194.50 ±  2%   +3653.2%       7300 ± 20%  interrupts.CPU30.PMI:Performance_monitoring_interrupts
>        1336 ± 11%     -67.4%     435.25 ± 23%  interrupts.CPU30.RES:Rescheduling_interrupts
>       40.50 ±122%   +1838.9%     785.25 ±  7%  interrupts.CPU30.TLB:TLB_shootdowns
>        1140 ±  6%   +1545.2%      18768 ±  8%  interrupts.CPU31.CAL:Function_call_interrupts
>      200.25 ±  4%   +2843.4%       5894 ± 32%  interrupts.CPU31.NMI:Non-maskable_interrupts
>      200.25 ±  4%   +2843.4%       5894 ± 32%  interrupts.CPU31.PMI:Performance_monitoring_interrupts
>        1193 ± 27%     -65.4%     413.25 ± 11%  interrupts.CPU31.RES:Rescheduling_interrupts
>       34.50 ± 85%   +2294.9%     826.25 ±  5%  interrupts.CPU31.TLB:TLB_shootdowns
>        1205 ±  9%   +1171.7%      15324 ± 11%  interrupts.CPU32.CAL:Function_call_interrupts
>      197.75 ±  5%   +3269.5%       6663 ± 14%  interrupts.CPU32.NMI:Non-maskable_interrupts
>      197.75 ±  5%   +3269.5%       6663 ± 14%  interrupts.CPU32.PMI:Performance_monitoring_interrupts
>        1052 ± 15%     -63.8%     380.75 ± 14%  interrupts.CPU32.RES:Rescheduling_interrupts
>        7.50 ± 39%  +11026.7%     834.50 ± 17%  interrupts.CPU32.TLB:TLB_shootdowns
>        1199 ± 15%   +1305.8%      16855 ±  6%  interrupts.CPU33.CAL:Function_call_interrupts
>      176.00 ± 26%   +3479.7%       6300 ± 32%  interrupts.CPU33.NMI:Non-maskable_interrupts
>      176.00 ± 26%   +3479.7%       6300 ± 32%  interrupts.CPU33.PMI:Performance_monitoring_interrupts
>        1174 ± 39%     -66.5%     393.25 ± 11%  interrupts.CPU33.RES:Rescheduling_interrupts
>       21.75 ± 89%   +3767.8%     841.25 ± 11%  interrupts.CPU33.TLB:TLB_shootdowns
>        1103 ±  5%   +1436.9%      16955 ± 11%  interrupts.CPU34.CAL:Function_call_interrupts
>      170.75 ± 24%   +3065.3%       5404 ± 23%  interrupts.CPU34.NMI:Non-maskable_interrupts
>      170.75 ± 24%   +3065.3%       5404 ± 23%  interrupts.CPU34.PMI:Performance_monitoring_interrupts
>        1522 ± 14%     -76.6%     355.75 ± 14%  interrupts.CPU34.RES:Rescheduling_interrupts
>       41.50 ±119%   +1819.3%     796.50 ±  4%  interrupts.CPU34.TLB:TLB_shootdowns
>        1107 ± 12%   +1574.7%      18539 ± 15%  interrupts.CPU35.CAL:Function_call_interrupts
>      200.75 ±  6%   +2967.6%       6158 ± 23%  interrupts.CPU35.NMI:Non-maskable_interrupts
>      200.75 ±  6%   +2967.6%       6158 ± 23%  interrupts.CPU35.PMI:Performance_monitoring_interrupts
>        1132 ± 20%     -63.5%     413.00 ±  8%  interrupts.CPU35.RES:Rescheduling_interrupts
>        9.00 ± 30%   +9308.3%     846.75 ± 16%  interrupts.CPU35.TLB:TLB_shootdowns
>        1011 ±  5%   +1621.5%      17417 ±  8%  interrupts.CPU36.CAL:Function_call_interrupts
>      194.75 ±  3%   +3467.9%       6948 ±  7%  interrupts.CPU36.NMI:Non-maskable_interrupts
>      194.75 ±  3%   +3467.9%       6948 ±  7%  interrupts.CPU36.PMI:Performance_monitoring_interrupts
>      983.00 ± 32%     -58.4%     409.25 ± 22%  interrupts.CPU36.RES:Rescheduling_interrupts
>       21.75 ± 75%   +3134.5%     703.50 ± 10%  interrupts.CPU36.TLB:TLB_shootdowns
>        1136 ±  9%   +1481.5%      17970 ± 15%  interrupts.CPU37.CAL:Function_call_interrupts
>      192.75 ±  3%   +3192.0%       6345 ± 12%  interrupts.CPU37.NMI:Non-maskable_interrupts
>      192.75 ±  3%   +3192.0%       6345 ± 12%  interrupts.CPU37.PMI:Performance_monitoring_interrupts
>        1269 ± 40%     -70.2%     379.00 ± 22%  interrupts.CPU37.RES:Rescheduling_interrupts
>       16.50 ± 21%   +5768.2%     968.25 ± 32%  interrupts.CPU37.TLB:TLB_shootdowns
>        1168 ± 11%   +1204.1%      15238 ± 13%  interrupts.CPU38.CAL:Function_call_interrupts
>      195.25 ±  3%   +3163.8%       6372 ± 13%  interrupts.CPU38.NMI:Non-maskable_interrupts
>      195.25 ±  3%   +3163.8%       6372 ± 13%  interrupts.CPU38.PMI:Performance_monitoring_interrupts
>        1412 ± 26%     -71.1%     408.00 ± 21%  interrupts.CPU38.RES:Rescheduling_interrupts
>       27.00 ±104%   +2736.1%     765.75 ± 20%  interrupts.CPU38.TLB:TLB_shootdowns
>        1159 ±  2%   +1433.1%      17769 ± 19%  interrupts.CPU39.CAL:Function_call_interrupts
>      170.50 ± 26%   +3568.5%       6254 ± 25%  interrupts.CPU39.NMI:Non-maskable_interrupts
>      170.50 ± 26%   +3568.5%       6254 ± 25%  interrupts.CPU39.PMI:Performance_monitoring_interrupts
>        1395 ± 22%     -72.4%     385.50 ± 17%  interrupts.CPU39.RES:Rescheduling_interrupts
>       33.00 ± 79%   +2272.0%     782.75 ± 16%  interrupts.CPU39.TLB:TLB_shootdowns
>        1093 ±  8%   +1469.4%      17154 ± 11%  interrupts.CPU4.CAL:Function_call_interrupts
>      205.50 ±  3%   +2958.8%       6285 ± 27%  interrupts.CPU4.NMI:Non-maskable_interrupts
>      205.50 ±  3%   +2958.8%       6285 ± 27%  interrupts.CPU4.PMI:Performance_monitoring_interrupts
>        1344 ± 24%     -73.6%     354.75 ± 11%  interrupts.CPU4.RES:Rescheduling_interrupts
>       21.00 ± 71%   +3188.1%     690.50 ± 14%  interrupts.CPU4.TLB:TLB_shootdowns
>        1058 ±  9%   +1555.4%      17518 ± 16%  interrupts.CPU40.CAL:Function_call_interrupts
>      147.00 ± 34%   +4442.0%       6676 ± 10%  interrupts.CPU40.NMI:Non-maskable_interrupts
>      147.00 ± 34%   +4442.0%       6676 ± 10%  interrupts.CPU40.PMI:Performance_monitoring_interrupts
>        1115 ± 11%     -63.5%     407.75 ± 18%  interrupts.CPU40.RES:Rescheduling_interrupts
>       33.50 ± 74%   +2391.8%     834.75 ± 16%  interrupts.CPU40.TLB:TLB_shootdowns
>        1037 ±  9%   +1763.6%      19334 ±  8%  interrupts.CPU41.CAL:Function_call_interrupts
>      148.00 ± 34%   +4094.8%       6208 ±  6%  interrupts.CPU41.NMI:Non-maskable_interrupts
>      148.00 ± 34%   +4094.8%       6208 ±  6%  interrupts.CPU41.PMI:Performance_monitoring_interrupts
>        1286 ± 16%     -69.1%     397.25 ± 11%  interrupts.CPU41.RES:Rescheduling_interrupts
>        8.00 ± 23%  +11725.0%     946.00 ±  6%  interrupts.CPU41.TLB:TLB_shootdowns
>        1202 ±  7%   +1323.9%      17118 ± 16%  interrupts.CPU42.CAL:Function_call_interrupts
>      170.75 ± 25%   +3722.4%       6526 ± 13%  interrupts.CPU42.NMI:Non-maskable_interrupts
>      170.75 ± 25%   +3722.4%       6526 ± 13%  interrupts.CPU42.PMI:Performance_monitoring_interrupts
>        1201 ± 21%     -68.9%     373.00 ±  8%  interrupts.CPU42.RES:Rescheduling_interrupts
>       27.50 ±115%   +2939.1%     835.75 ±  5%  interrupts.CPU42.TLB:TLB_shootdowns
>        1114 ±  8%   +1456.3%      17337 ± 15%  interrupts.CPU43.CAL:Function_call_interrupts
>      151.00 ± 37%   +4446.0%       6864 ± 11%  interrupts.CPU43.NMI:Non-maskable_interrupts
>      151.00 ± 37%   +4446.0%       6864 ± 11%  interrupts.CPU43.PMI:Performance_monitoring_interrupts
>        1182 ± 22%     -65.1%     412.50 ± 12%  interrupts.CPU43.RES:Rescheduling_interrupts
>       20.50 ± 72%   +3782.9%     796.00 ±  7%  interrupts.CPU43.TLB:TLB_shootdowns
>        1072 ± 13%   +1418.1%      16273 ± 19%  interrupts.CPU44.CAL:Function_call_interrupts
>      147.00 ± 33%   +4449.7%       6688 ± 13%  interrupts.CPU44.NMI:Non-maskable_interrupts
>      147.00 ± 33%   +4449.7%       6688 ± 13%  interrupts.CPU44.PMI:Performance_monitoring_interrupts
>        1036 ± 47%     -62.0%     393.75 ± 23%  interrupts.CPU44.RES:Rescheduling_interrupts
>       19.00 ± 78%   +4377.6%     850.75 ± 16%  interrupts.CPU44.TLB:TLB_shootdowns
>        1324 ± 20%   +1200.4%      17217 ± 25%  interrupts.CPU45.CAL:Function_call_interrupts
>      146.50 ± 34%   +4031.6%       6052 ±  9%  interrupts.CPU45.NMI:Non-maskable_interrupts
>      146.50 ± 34%   +4031.6%       6052 ±  9%  interrupts.CPU45.PMI:Performance_monitoring_interrupts
>        1421 ± 17%     -69.5%     433.50 ± 23%  interrupts.CPU45.RES:Rescheduling_interrupts
>       12.75 ± 32%   +5831.4%     756.25 ± 18%  interrupts.CPU45.TLB:TLB_shootdowns
>        1117 ±  8%   +1500.1%      17885 ±  6%  interrupts.CPU46.CAL:Function_call_interrupts
>      147.00 ± 35%   +4182.7%       6295 ± 26%  interrupts.CPU46.NMI:Non-maskable_interrupts
>      147.00 ± 35%   +4182.7%       6295 ± 26%  interrupts.CPU46.PMI:Performance_monitoring_interrupts
>        1382 ± 19%     -72.6%     378.75 ± 18%  interrupts.CPU46.RES:Rescheduling_interrupts
>       17.25 ± 82%   +4456.5%     786.00 ± 14%  interrupts.CPU46.TLB:TLB_shootdowns
>      991.00 ±  3%   +1739.2%      18226 ± 21%  interrupts.CPU47.CAL:Function_call_interrupts
>      146.50 ± 34%   +4033.8%       6056 ± 38%  interrupts.CPU47.NMI:Non-maskable_interrupts
>      146.50 ± 34%   +4033.8%       6056 ± 38%  interrupts.CPU47.PMI:Performance_monitoring_interrupts
>        1355 ± 27%     -71.1%     392.25 ±  7%  interrupts.CPU47.RES:Rescheduling_interrupts
>        9.75 ± 36%   +7759.0%     766.25 ± 13%  interrupts.CPU47.TLB:TLB_shootdowns
>        1255 ±  4%   +1345.2%      18141 ± 12%  interrupts.CPU48.CAL:Function_call_interrupts
>      185.25 ± 28%   +3158.0%       6035 ± 20%  interrupts.CPU48.NMI:Non-maskable_interrupts
>      185.25 ± 28%   +3158.0%       6035 ± 20%  interrupts.CPU48.PMI:Performance_monitoring_interrupts
>        1187 ±  9%     -63.4%     434.50 ± 11%  interrupts.CPU48.RES:Rescheduling_interrupts
>       10.75 ± 27%   +7479.1%     814.75 ± 14%  interrupts.CPU48.TLB:TLB_shootdowns
>        1049         +1531.7%      17116 ± 14%  interrupts.CPU49.CAL:Function_call_interrupts
>      193.50 ±  3%   +2870.8%       5748 ± 24%  interrupts.CPU49.NMI:Non-maskable_interrupts
>      193.50 ±  3%   +2870.8%       5748 ± 24%  interrupts.CPU49.PMI:Performance_monitoring_interrupts
>        1169 ± 24%     -65.7%     400.75 ± 15%  interrupts.CPU49.RES:Rescheduling_interrupts
>       12.50 ± 41%   +5830.0%     741.25 ± 15%  interrupts.CPU49.TLB:TLB_shootdowns
>        1230 ± 22%   +1391.4%      18352 ± 14%  interrupts.CPU5.CAL:Function_call_interrupts
>      179.00 ± 26%   +2636.3%       4898 ± 21%  interrupts.CPU5.NMI:Non-maskable_interrupts
>      179.00 ± 26%   +2636.3%       4898 ± 21%  interrupts.CPU5.PMI:Performance_monitoring_interrupts
>        1262 ± 25%     -72.4%     349.00 ± 27%  interrupts.CPU5.RES:Rescheduling_interrupts
>        8.50 ± 39%   +8964.7%     770.50 ±  6%  interrupts.CPU5.TLB:TLB_shootdowns
>        1181 ±  2%   +1606.9%      20171 ±  8%  interrupts.CPU50.CAL:Function_call_interrupts
>      195.50 ±  3%   +2789.4%       5648 ± 24%  interrupts.CPU50.NMI:Non-maskable_interrupts
>      195.50 ±  3%   +2789.4%       5648 ± 24%  interrupts.CPU50.PMI:Performance_monitoring_interrupts
>        1315 ± 15%     -68.4%     416.25 ± 14%  interrupts.CPU50.RES:Rescheduling_interrupts
>       25.50 ± 78%   +3609.8%     946.00 ± 19%  interrupts.CPU50.TLB:TLB_shootdowns
>        1153 ± 16%   +1384.8%      17131 ±  4%  interrupts.CPU51.CAL:Function_call_interrupts
>      197.00 ±  2%   +2581.5%       5282 ± 26%  interrupts.CPU51.NMI:Non-maskable_interrupts
>      197.00 ±  2%   +2581.5%       5282 ± 26%  interrupts.CPU51.PMI:Performance_monitoring_interrupts
>        1266 ± 14%     -65.7%     433.75 ±  9%  interrupts.CPU51.RES:Rescheduling_interrupts
>       14.00 ± 39%   +6333.9%     900.75 ± 19%  interrupts.CPU51.TLB:TLB_shootdowns
>        1022 ±  4%   +1549.3%      16868 ± 11%  interrupts.CPU52.CAL:Function_call_interrupts
>      199.75 ±  3%   +2957.8%       6108 ± 27%  interrupts.CPU52.NMI:Non-maskable_interrupts
>      199.75 ±  3%   +2957.8%       6108 ± 27%  interrupts.CPU52.PMI:Performance_monitoring_interrupts
>        1245 ± 30%     -69.1%     385.00 ± 10%  interrupts.CPU52.RES:Rescheduling_interrupts
>       12.00 ± 45%   +6639.6%     808.75 ±  4%  interrupts.CPU52.TLB:TLB_shootdowns
>        1071 ± 10%   +1656.0%      18811 ± 15%  interrupts.CPU53.CAL:Function_call_interrupts
>      198.75 ±  3%   +2980.1%       6121 ± 29%  interrupts.CPU53.NMI:Non-maskable_interrupts
>      198.75 ±  3%   +2980.1%       6121 ± 29%  interrupts.CPU53.PMI:Performance_monitoring_interrupts
>        1074 ± 34%     -63.5%     392.50 ± 13%  interrupts.CPU53.RES:Rescheduling_interrupts
>       15.00 ±105%   +5255.0%     803.25 ± 14%  interrupts.CPU53.TLB:TLB_shootdowns
>        1127 ± 21%   +1410.0%      17017 ± 21%  interrupts.CPU54.CAL:Function_call_interrupts
>      169.50 ± 24%   +3912.4%       6801 ± 27%  interrupts.CPU54.NMI:Non-maskable_interrupts
>      169.50 ± 24%   +3912.4%       6801 ± 27%  interrupts.CPU54.PMI:Performance_monitoring_interrupts
>        1311 ± 26%     -71.2%     377.25 ± 23%  interrupts.CPU54.RES:Rescheduling_interrupts
>       13.00 ± 21%   +6096.2%     805.50 ± 18%  interrupts.CPU54.TLB:TLB_shootdowns
>        1322 ± 31%   +1308.5%      18620 ± 15%  interrupts.CPU55.CAL:Function_call_interrupts
>      147.00 ± 35%   +3924.8%       5916 ± 29%  interrupts.CPU55.NMI:Non-maskable_interrupts
>      147.00 ± 35%   +3924.8%       5916 ± 29%  interrupts.CPU55.PMI:Performance_monitoring_interrupts
>        1107 ± 16%     -65.8%     379.00 ± 19%  interrupts.CPU55.RES:Rescheduling_interrupts
>       24.25 ±114%   +3718.6%     926.00 ± 19%  interrupts.CPU55.TLB:TLB_shootdowns
>        1116 ±  4%   +1521.7%      18110 ± 14%  interrupts.CPU56.CAL:Function_call_interrupts
>      173.25 ± 26%   +3283.4%       5861 ± 39%  interrupts.CPU56.NMI:Non-maskable_interrupts
>      173.25 ± 26%   +3283.4%       5861 ± 39%  interrupts.CPU56.PMI:Performance_monitoring_interrupts
>        1150 ± 23%     -68.1%     366.50 ± 20%  interrupts.CPU56.RES:Rescheduling_interrupts
>       10.50 ± 39%   +8031.0%     853.75 ±  7%  interrupts.CPU56.TLB:TLB_shootdowns
>        1202 ± 21%   +1357.6%      17531 ± 21%  interrupts.CPU57.CAL:Function_call_interrupts
>      188.50 ± 31%   +3120.7%       6071 ± 34%  interrupts.CPU57.NMI:Non-maskable_interrupts
>      188.50 ± 31%   +3120.7%       6071 ± 34%  interrupts.CPU57.PMI:Performance_monitoring_interrupts
>        1343 ± 16%     -70.7%     393.50 ± 10%  interrupts.CPU57.RES:Rescheduling_interrupts
>       12.75 ± 24%   +7007.8%     906.25 ± 19%  interrupts.CPU57.TLB:TLB_shootdowns
>        1054 ±  9%   +1572.7%      17643 ± 15%  interrupts.CPU58.CAL:Function_call_interrupts
>      173.00 ± 26%   +2821.1%       5053 ± 23%  interrupts.CPU58.NMI:Non-maskable_interrupts
>      173.00 ± 26%   +2821.1%       5053 ± 23%  interrupts.CPU58.PMI:Performance_monitoring_interrupts
>        1287 ± 19%     -68.4%     407.00 ± 17%  interrupts.CPU58.RES:Rescheduling_interrupts
>       16.00 ± 98%   +5365.6%     874.50 ± 11%  interrupts.CPU58.TLB:TLB_shootdowns
>        1035 ± 11%   +1525.8%      16831 ± 19%  interrupts.CPU59.CAL:Function_call_interrupts
>      171.25 ± 26%   +2705.4%       4804 ± 56%  interrupts.CPU59.NMI:Non-maskable_interrupts
>      171.25 ± 26%   +2705.4%       4804 ± 56%  interrupts.CPU59.PMI:Performance_monitoring_interrupts
>        1214 ± 30%     -71.0%     352.50 ±  5%  interrupts.CPU59.RES:Rescheduling_interrupts
>       27.50 ±116%   +3414.5%     966.50 ± 27%  interrupts.CPU59.TLB:TLB_shootdowns
>        1158 ± 11%   +1497.6%      18500 ±  7%  interrupts.CPU6.CAL:Function_call_interrupts
>      176.75 ± 25%   +3246.7%       5915 ± 28%  interrupts.CPU6.NMI:Non-maskable_interrupts
>      176.75 ± 25%   +3246.7%       5915 ± 28%  interrupts.CPU6.PMI:Performance_monitoring_interrupts
>        1568 ± 19%     -75.1%     391.00 ± 17%  interrupts.CPU6.RES:Rescheduling_interrupts
>        9.00 ± 40%   +9402.8%     855.25 ±  6%  interrupts.CPU6.TLB:TLB_shootdowns
>        1036 ±  7%   +1762.4%      19294 ± 24%  interrupts.CPU60.CAL:Function_call_interrupts
>      172.25 ± 26%   +3278.2%       5819 ± 27%  interrupts.CPU60.NMI:Non-maskable_interrupts
>      172.25 ± 26%   +3278.2%       5819 ± 27%  interrupts.CPU60.PMI:Performance_monitoring_interrupts
>        1405 ± 24%     -71.3%     404.00 ± 14%  interrupts.CPU60.RES:Rescheduling_interrupts
>       24.75 ± 80%   +3187.9%     813.75 ±  8%  interrupts.CPU60.TLB:TLB_shootdowns
>        1071 ±  7%   +1622.3%      18449 ± 12%  interrupts.CPU61.CAL:Function_call_interrupts
>      170.75 ± 27%   +3293.9%       5795 ± 30%  interrupts.CPU61.NMI:Non-maskable_interrupts
>      170.75 ± 27%   +3293.9%       5795 ± 30%  interrupts.CPU61.PMI:Performance_monitoring_interrupts
>        1413 ± 13%     -71.7%     400.00 ±  5%  interrupts.CPU61.RES:Rescheduling_interrupts
>       13.75 ± 22%   +6080.0%     849.75 ±  4%  interrupts.CPU61.TLB:TLB_shootdowns
>        1145 ± 13%   +1577.6%      19212 ± 26%  interrupts.CPU62.CAL:Function_call_interrupts
>      170.75 ± 27%   +3811.3%       6678 ± 32%  interrupts.CPU62.NMI:Non-maskable_interrupts
>      170.75 ± 27%   +3811.3%       6678 ± 32%  interrupts.CPU62.PMI:Performance_monitoring_interrupts
>        1050 ± 33%     -64.0%     378.25 ± 18%  interrupts.CPU62.RES:Rescheduling_interrupts
>        9.25 ± 59%   +8451.4%     791.00 ± 30%  interrupts.CPU62.TLB:TLB_shootdowns
>        2207 ± 90%    +761.8%      19021 ± 12%  interrupts.CPU63.CAL:Function_call_interrupts
>      172.25 ± 27%   +3726.7%       6591 ± 23%  interrupts.CPU63.NMI:Non-maskable_interrupts
>      172.25 ± 27%   +3726.7%       6591 ± 23%  interrupts.CPU63.PMI:Performance_monitoring_interrupts
>        1324 ± 27%     -70.2%     395.00 ± 18%  interrupts.CPU63.RES:Rescheduling_interrupts
>       22.00 ± 50%   +4025.0%     907.50 ± 10%  interrupts.CPU63.TLB:TLB_shootdowns
>        1163 ±  5%   +1450.6%      18045 ± 10%  interrupts.CPU64.CAL:Function_call_interrupts
>      192.50 ±  2%   +2521.7%       5046 ± 33%  interrupts.CPU64.NMI:Non-maskable_interrupts
>      192.50 ±  2%   +2521.7%       5046 ± 33%  interrupts.CPU64.PMI:Performance_monitoring_interrupts
>        1376 ± 28%     -71.2%     395.75 ± 12%  interrupts.CPU64.RES:Rescheduling_interrupts
>       21.00 ± 27%   +3470.2%     749.75 ±  8%  interrupts.CPU64.TLB:TLB_shootdowns
>        1069 ±  9%   +1462.5%      16710 ± 11%  interrupts.CPU65.CAL:Function_call_interrupts
>      193.00 ±  2%   +3553.5%       7051 ± 13%  interrupts.CPU65.NMI:Non-maskable_interrupts
>      193.00 ±  2%   +3553.5%       7051 ± 13%  interrupts.CPU65.PMI:Performance_monitoring_interrupts
>        1199 ± 24%     -68.8%     374.00 ± 12%  interrupts.CPU65.RES:Rescheduling_interrupts
>       11.75 ± 62%   +6238.3%     744.75 ±  9%  interrupts.CPU65.TLB:TLB_shootdowns
>        1055 ±  7%   +1710.1%      19105 ± 13%  interrupts.CPU66.CAL:Function_call_interrupts
>      204.25 ±  7%   +3271.5%       6886 ± 16%  interrupts.CPU66.NMI:Non-maskable_interrupts
>      204.25 ±  7%   +3271.5%       6886 ± 16%  interrupts.CPU66.PMI:Performance_monitoring_interrupts
>        1186 ± 43%     -65.7%     406.75 ±  5%  interrupts.CPU66.RES:Rescheduling_interrupts
>       17.00 ± 89%   +4783.8%     830.25 ±  8%  interrupts.CPU66.TLB:TLB_shootdowns
>        1190 ± 16%   +1446.7%      18409 ± 12%  interrupts.CPU67.CAL:Function_call_interrupts
>      193.50 ±  3%   +3171.6%       6330 ± 15%  interrupts.CPU67.NMI:Non-maskable_interrupts
>      193.50 ±  3%   +3171.6%       6330 ± 15%  interrupts.CPU67.PMI:Performance_monitoring_interrupts
>        1108 ± 17%     -64.6%     392.00 ± 14%  interrupts.CPU67.RES:Rescheduling_interrupts
>       16.75 ± 68%   +4800.0%     820.75 ± 10%  interrupts.CPU67.TLB:TLB_shootdowns
>        1058 ±  3%   +1616.3%      18158 ± 16%  interrupts.CPU68.CAL:Function_call_interrupts
>      194.75 ±  3%   +3460.2%       6933 ± 13%  interrupts.CPU68.NMI:Non-maskable_interrupts
>      194.75 ±  3%   +3460.2%       6933 ± 13%  interrupts.CPU68.PMI:Performance_monitoring_interrupts
>        1436 ± 22%     -72.7%     392.50 ± 17%  interrupts.CPU68.RES:Rescheduling_interrupts
>       15.50 ± 39%   +5325.8%     841.00 ± 11%  interrupts.CPU68.TLB:TLB_shootdowns
>        1025 ±  7%   +1608.1%      17512 ± 20%  interrupts.CPU69.CAL:Function_call_interrupts
>      193.25 ±  3%   +2644.6%       5304 ± 28%  interrupts.CPU69.NMI:Non-maskable_interrupts
>      193.25 ±  3%   +2644.6%       5304 ± 28%  interrupts.CPU69.PMI:Performance_monitoring_interrupts
>        1345 ± 30%     -72.5%     369.75 ± 15%  interrupts.CPU69.RES:Rescheduling_interrupts
>       20.25 ± 41%   +4295.1%     890.00 ± 15%  interrupts.CPU69.TLB:TLB_shootdowns
>        1217 ± 11%   +1464.7%      19046 ± 14%  interrupts.CPU7.CAL:Function_call_interrupts
>      208.50 ±  6%   +2593.2%       5615 ± 29%  interrupts.CPU7.NMI:Non-maskable_interrupts
>      208.50 ±  6%   +2593.2%       5615 ± 29%  interrupts.CPU7.PMI:Performance_monitoring_interrupts
>        1075 ± 19%     -64.9%     377.00 ±  9%  interrupts.CPU7.RES:Rescheduling_interrupts
>        7.75 ± 27%  +10390.3%     813.00 ± 16%  interrupts.CPU7.TLB:TLB_shootdowns
>        1022 ±  7%   +1610.7%      17483 ±  8%  interrupts.CPU70.CAL:Function_call_interrupts
>      199.25 ±  3%   +3039.6%       6255 ± 16%  interrupts.CPU70.NMI:Non-maskable_interrupts
>      199.25 ±  3%   +3039.6%       6255 ± 16%  interrupts.CPU70.PMI:Performance_monitoring_interrupts
>        1400 ± 10%     -71.7%     396.75 ± 17%  interrupts.CPU70.RES:Rescheduling_interrupts
>        9.75 ± 24%   +8520.5%     840.50 ± 10%  interrupts.CPU70.TLB:TLB_shootdowns
>      946.25 ±  2%   +1795.8%      17939 ± 20%  interrupts.CPU71.CAL:Function_call_interrupts
>      199.50 ±  8%   +2880.2%       5945 ± 28%  interrupts.CPU71.NMI:Non-maskable_interrupts
>      199.50 ±  8%   +2880.2%       5945 ± 28%  interrupts.CPU71.PMI:Performance_monitoring_interrupts
>        1114 ± 24%     -68.6%     350.00 ± 22%  interrupts.CPU71.RES:Rescheduling_interrupts
>       20.75 ±115%   +3991.6%     849.00 ± 14%  interrupts.CPU71.TLB:TLB_shootdowns
>        1275 ±  6%   +1258.0%      17321 ±  5%  interrupts.CPU72.CAL:Function_call_interrupts
>      217.50 ±  9%   +2579.8%       5828 ± 19%  interrupts.CPU72.NMI:Non-maskable_interrupts
>      217.50 ±  9%   +2579.8%       5828 ± 19%  interrupts.CPU72.PMI:Performance_monitoring_interrupts
>      989.25 ±  7%     -62.1%     375.00 ± 17%  interrupts.CPU72.RES:Rescheduling_interrupts
>       12.25 ± 40%   +6334.7%     788.25 ± 18%  interrupts.CPU72.TLB:TLB_shootdowns
>      947.00 ± 14%   +1776.1%      17766 ± 12%  interrupts.CPU73.CAL:Function_call_interrupts
>      210.00 ±  7%   +2687.9%       5854 ± 21%  interrupts.CPU73.NMI:Non-maskable_interrupts
>      210.00 ±  7%   +2687.9%       5854 ± 21%  interrupts.CPU73.PMI:Performance_monitoring_interrupts
>      972.75 ± 14%     -61.3%     376.00 ± 18%  interrupts.CPU73.RES:Rescheduling_interrupts
>       13.00 ± 47%   +5917.3%     782.25 ± 13%  interrupts.CPU73.TLB:TLB_shootdowns
>        1414 ± 15%   +1142.3%      17569 ±  8%  interrupts.CPU74.CAL:Function_call_interrupts
>      199.75 ±  3%   +2971.5%       6135 ± 14%  interrupts.CPU74.NMI:Non-maskable_interrupts
>      199.75 ±  3%   +2971.5%       6135 ± 14%  interrupts.CPU74.PMI:Performance_monitoring_interrupts
>        1032 ± 22%     -64.1%     370.50 ± 12%  interrupts.CPU74.RES:Rescheduling_interrupts
>       12.75 ± 15%   +6227.5%     806.75 ± 10%  interrupts.CPU74.TLB:TLB_shootdowns
>        1299 ±  9%   +1348.1%      18810 ± 13%  interrupts.CPU75.CAL:Function_call_interrupts
>      203.50 ±  3%   +2811.8%       5925 ± 22%  interrupts.CPU75.NMI:Non-maskable_interrupts
>      203.50 ±  3%   +2811.8%       5925 ± 22%  interrupts.CPU75.PMI:Performance_monitoring_interrupts
>        1076 ± 11%     -65.2%     374.00 ± 15%  interrupts.CPU75.RES:Rescheduling_interrupts
>       10.50 ± 39%   +7202.4%     766.75 ± 14%  interrupts.CPU75.TLB:TLB_shootdowns
>        1345 ± 17%   +1239.1%      18014 ± 10%  interrupts.CPU76.CAL:Function_call_interrupts
>      206.50 ±  7%   +2614.3%       5605 ± 24%  interrupts.CPU76.NMI:Non-maskable_interrupts
>      206.50 ±  7%   +2614.3%       5605 ± 24%  interrupts.CPU76.PMI:Performance_monitoring_interrupts
>        1611 ± 33%     -77.8%     357.75 ±  6%  interrupts.CPU76.RES:Rescheduling_interrupts
>       28.25 ± 59%   +2906.2%     849.25 ±  6%  interrupts.CPU76.TLB:TLB_shootdowns
>        1213 ± 13%   +1514.4%      19595 ± 17%  interrupts.CPU77.CAL:Function_call_interrupts
>      201.50 ±  4%   +2808.8%       5861 ± 16%  interrupts.CPU77.NMI:Non-maskable_interrupts
>      201.50 ±  4%   +2808.8%       5861 ± 16%  interrupts.CPU77.PMI:Performance_monitoring_interrupts
>        1088 ± 13%     -67.2%     356.50 ± 21%  interrupts.CPU77.RES:Rescheduling_interrupts
>       20.00 ± 82%   +3843.8%     788.75 ± 21%  interrupts.CPU77.TLB:TLB_shootdowns
>        1274 ± 15%   +1467.5%      19973 ± 15%  interrupts.CPU78.CAL:Function_call_interrupts
>      203.00 ±  6%   +2826.2%       5940 ± 26%  interrupts.CPU78.NMI:Non-maskable_interrupts
>      203.00 ±  6%   +2826.2%       5940 ± 26%  interrupts.CPU78.PMI:Performance_monitoring_interrupts
>        1368 ± 23%     -72.7%     374.00 ± 12%  interrupts.CPU78.RES:Rescheduling_interrupts
>       15.00 ± 35%   +5416.7%     827.50 ±  8%  interrupts.CPU78.TLB:TLB_shootdowns
>        1218 ± 10%   +1509.9%      19608 ± 11%  interrupts.CPU79.CAL:Function_call_interrupts
>      198.00 ±  3%   +2778.9%       5700 ± 34%  interrupts.CPU79.NMI:Non-maskable_interrupts
>      198.00 ±  3%   +2778.9%       5700 ± 34%  interrupts.CPU79.PMI:Performance_monitoring_interrupts
>      994.00 ± 53%     -63.5%     362.50 ± 16%  interrupts.CPU79.RES:Rescheduling_interrupts
>       12.50 ± 37%   +5876.0%     747.00 ± 19%  interrupts.CPU79.TLB:TLB_shootdowns
>        1216 ± 12%   +1528.0%      19804 ±  9%  interrupts.CPU8.CAL:Function_call_interrupts
>      204.25 ±  2%   +2584.2%       5482 ± 23%  interrupts.CPU8.NMI:Non-maskable_interrupts
>      204.25 ±  2%   +2584.2%       5482 ± 23%  interrupts.CPU8.PMI:Performance_monitoring_interrupts
>      908.00 ± 25%     -57.7%     384.50 ± 15%  interrupts.CPU8.RES:Rescheduling_interrupts
>       17.75 ± 98%   +4738.0%     858.75 ±  7%  interrupts.CPU8.TLB:TLB_shootdowns
>        1431 ±  5%   +1096.4%      17127 ± 19%  interrupts.CPU80.CAL:Function_call_interrupts
>      198.50 ±  3%   +2388.4%       4939 ± 36%  interrupts.CPU80.NMI:Non-maskable_interrupts
>      198.50 ±  3%   +2388.4%       4939 ± 36%  interrupts.CPU80.PMI:Performance_monitoring_interrupts
>      990.75 ± 20%     -62.3%     373.25 ± 17%  interrupts.CPU80.RES:Rescheduling_interrupts
>       15.00 ± 12%   +4636.7%     710.50 ±  9%  interrupts.CPU80.TLB:TLB_shootdowns
>        1297 ±  6%   +1303.6%      18211 ± 13%  interrupts.CPU81.CAL:Function_call_interrupts
>      199.75 ±  3%   +2650.4%       5494 ± 30%  interrupts.CPU81.NMI:Non-maskable_interrupts
>      199.75 ±  3%   +2650.4%       5494 ± 30%  interrupts.CPU81.PMI:Performance_monitoring_interrupts
>        1206 ± 21%     -67.1%     397.00 ± 15%  interrupts.CPU81.RES:Rescheduling_interrupts
>        9.00 ± 45%   +9580.6%     871.25 ± 10%  interrupts.CPU81.TLB:TLB_shootdowns
>        1290 ± 16%   +1374.2%      19024 ± 17%  interrupts.CPU82.CAL:Function_call_interrupts
>      213.75 ± 16%   +2576.6%       5721 ± 24%  interrupts.CPU82.NMI:Non-maskable_interrupts
>      213.75 ± 16%   +2576.6%       5721 ± 24%  interrupts.CPU82.PMI:Performance_monitoring_interrupts
>        1347 ± 19%     -73.0%     363.75 ± 19%  interrupts.CPU82.RES:Rescheduling_interrupts
>       16.50 ± 17%   +4842.4%     815.50 ± 13%  interrupts.CPU82.TLB:TLB_shootdowns
>        1438 ± 49%   +1202.3%      18734 ± 11%  interrupts.CPU83.CAL:Function_call_interrupts
>      202.00 ±  2%   +3182.2%       6630 ± 27%  interrupts.CPU83.NMI:Non-maskable_interrupts
>      202.00 ±  2%   +3182.2%       6630 ± 27%  interrupts.CPU83.PMI:Performance_monitoring_interrupts
>      972.00 ± 34%     -56.0%     427.50 ± 28%  interrupts.CPU83.RES:Rescheduling_interrupts
>       10.25 ±  4%   +8290.2%     860.00 ±  9%  interrupts.CPU83.TLB:TLB_shootdowns
>        1247 ±  8%   +1491.5%      19857 ±  3%  interrupts.CPU84.CAL:Function_call_interrupts
>      204.25 ±  6%   +2474.4%       5258 ± 20%  interrupts.CPU84.NMI:Non-maskable_interrupts
>      204.25 ±  6%   +2474.4%       5258 ± 20%  interrupts.CPU84.PMI:Performance_monitoring_interrupts
>        1083 ± 20%     -64.8%     381.00 ± 11%  interrupts.CPU84.RES:Rescheduling_interrupts
>       28.75 ± 70%   +2530.4%     756.25 ±  8%  interrupts.CPU84.TLB:TLB_shootdowns
>        1190 ±  9%   +1535.3%      19468 ± 10%  interrupts.CPU85.CAL:Function_call_interrupts
>      204.25 ±  5%   +2661.3%       5640 ± 21%  interrupts.CPU85.NMI:Non-maskable_interrupts
>      204.25 ±  5%   +2661.3%       5640 ± 21%  interrupts.CPU85.PMI:Performance_monitoring_interrupts
>      879.50 ±  5%     -56.1%     386.25 ± 11%  interrupts.CPU85.RES:Rescheduling_interrupts
>       11.75 ± 38%   +7053.2%     840.50 ± 10%  interrupts.CPU85.TLB:TLB_shootdowns
>        1306 ± 11%   +1246.6%      17593 ± 11%  interrupts.CPU86.CAL:Function_call_interrupts
>      205.50 ±  6%   +2968.5%       6305 ± 20%  interrupts.CPU86.NMI:Non-maskable_interrupts
>      205.50 ±  6%   +2968.5%       6305 ± 20%  interrupts.CPU86.PMI:Performance_monitoring_interrupts
>        1465 ± 22%     -72.2%     406.75 ± 14%  interrupts.CPU86.RES:Rescheduling_interrupts
>       21.00 ± 22%   +3439.3%     743.25 ± 14%  interrupts.CPU86.TLB:TLB_shootdowns
>        1271 ± 16%   +1446.3%      19653 ± 14%  interrupts.CPU87.CAL:Function_call_interrupts
>      170.00 ± 21%   +3408.2%       5964 ± 28%  interrupts.CPU87.NMI:Non-maskable_interrupts
>      170.00 ± 21%   +3408.2%       5964 ± 28%  interrupts.CPU87.PMI:Performance_monitoring_interrupts
>        1211 ± 33%     -66.4%     407.00 ± 15%  interrupts.CPU87.RES:Rescheduling_interrupts
>       36.75 ± 66%   +2429.3%     929.50 ± 15%  interrupts.CPU87.TLB:TLB_shootdowns
>        1240 ±  8%   +1407.9%      18705 ±  8%  interrupts.CPU88.CAL:Function_call_interrupts
>      171.25 ± 22%   +2680.7%       4762 ± 26%  interrupts.CPU88.NMI:Non-maskable_interrupts
>      171.25 ± 22%   +2680.7%       4762 ± 26%  interrupts.CPU88.PMI:Performance_monitoring_interrupts
>        1250 ± 19%     -71.0%     363.00 ± 13%  interrupts.CPU88.RES:Rescheduling_interrupts
>       19.00 ± 59%   +4122.4%     802.25 ± 18%  interrupts.CPU88.TLB:TLB_shootdowns
>        1401 ± 39%   +1330.7%      20051 ± 20%  interrupts.CPU89.CAL:Function_call_interrupts
>      174.50 ± 19%   +2893.8%       5224 ± 34%  interrupts.CPU89.NMI:Non-maskable_interrupts
>      174.50 ± 19%   +2893.8%       5224 ± 34%  interrupts.CPU89.PMI:Performance_monitoring_interrupts
>        1102 ± 28%     -63.8%     399.50 ± 18%  interrupts.CPU89.RES:Rescheduling_interrupts
>       14.50 ± 44%   +6006.9%     885.50 ± 10%  interrupts.CPU89.TLB:TLB_shootdowns
>        1137 ±  6%   +1300.8%      15931 ±  9%  interrupts.CPU9.CAL:Function_call_interrupts
>      209.25         +2083.9%       4569 ± 34%  interrupts.CPU9.NMI:Non-maskable_interrupts
>      209.25         +2083.9%       4569 ± 34%  interrupts.CPU9.PMI:Performance_monitoring_interrupts
>      868.25 ±  9%     -64.5%     308.25 ± 22%  interrupts.CPU9.RES:Rescheduling_interrupts
>       16.25 ± 99%   +3958.5%     659.50 ± 12%  interrupts.CPU9.TLB:TLB_shootdowns
>        1735 ± 24%   +1116.8%      21117 ± 12%  interrupts.CPU90.CAL:Function_call_interrupts
>      172.25 ± 22%   +3146.7%       5592 ± 22%  interrupts.CPU90.NMI:Non-maskable_interrupts
>      172.25 ± 22%   +3146.7%       5592 ± 22%  interrupts.CPU90.PMI:Performance_monitoring_interrupts
>       11.00 ± 51%   +7452.3%     830.75 ± 12%  interrupts.CPU90.TLB:TLB_shootdowns
>        1216 ±  9%   +1593.4%      20592 ±  9%  interrupts.CPU91.CAL:Function_call_interrupts
>      171.50 ± 24%   +2807.9%       4987 ± 37%  interrupts.CPU91.NMI:Non-maskable_interrupts
>      171.50 ± 24%   +2807.9%       4987 ± 37%  interrupts.CPU91.PMI:Performance_monitoring_interrupts
>       10.00 ± 33%   +9285.0%     938.50 ±  3%  interrupts.CPU91.TLB:TLB_shootdowns
>        1601 ± 31%   +1199.7%      20807 ±  5%  interrupts.CPU92.CAL:Function_call_interrupts
>      176.25 ± 22%   +2839.7%       5181 ± 26%  interrupts.CPU92.NMI:Non-maskable_interrupts
>      176.25 ± 22%   +2839.7%       5181 ± 26%  interrupts.CPU92.PMI:Performance_monitoring_interrupts
>      980.00 ± 29%     -53.0%     461.00 ± 16%  interrupts.CPU92.RES:Rescheduling_interrupts
>       27.50 ± 89%   +3560.9%       1006 ± 10%  interrupts.CPU92.TLB:TLB_shootdowns
>        1250 ± 11%   +1394.2%      18678 ± 11%  interrupts.CPU93.CAL:Function_call_interrupts
>      173.00 ± 23%   +3162.4%       5644 ± 41%  interrupts.CPU93.NMI:Non-maskable_interrupts
>      173.00 ± 23%   +3162.4%       5644 ± 41%  interrupts.CPU93.PMI:Performance_monitoring_interrupts
>      860.00 ± 44%     -54.3%     393.00 ±  7%  interrupts.CPU93.RES:Rescheduling_interrupts
>        5.25 ± 47%  +14252.4%     753.50 ± 16%  interrupts.CPU93.TLB:TLB_shootdowns
>        1246 ± 10%   +1684.5%      22235 ± 11%  interrupts.CPU94.CAL:Function_call_interrupts
>      171.25 ± 22%   +2938.8%       5204 ± 34%  interrupts.CPU94.NMI:Non-maskable_interrupts
>      171.25 ± 22%   +2938.8%       5204 ± 34%  interrupts.CPU94.PMI:Performance_monitoring_interrupts
>        1248 ± 28%     -65.6%     429.50 ± 11%  interrupts.CPU94.RES:Rescheduling_interrupts
>       15.50 ± 18%   +6246.8%     983.75 ±  7%  interrupts.CPU94.TLB:TLB_shootdowns
>        1366 ± 11%   +1942.5%      27906 ± 11%  interrupts.CPU95.CAL:Function_call_interrupts
>      178.50 ± 21%   +3917.6%       7171 ± 24%  interrupts.CPU95.NMI:Non-maskable_interrupts
>      178.50 ± 21%   +3917.6%       7171 ± 24%  interrupts.CPU95.PMI:Performance_monitoring_interrupts
>        1552 ± 14%     -65.5%     535.75 ± 12%  interrupts.CPU95.RES:Rescheduling_interrupts
>       24.75 ± 11%   +4877.8%       1232 ±  4%  interrupts.CPU95.TLB:TLB_shootdowns
>        1383 ± 18%   +1511.1%      22285 ±  7%  interrupts.CPU96.CAL:Function_call_interrupts
>      189.75 ± 24%   +2856.4%       5609 ± 22%  interrupts.CPU96.NMI:Non-maskable_interrupts
>      189.75 ± 24%   +2856.4%       5609 ± 22%  interrupts.CPU96.PMI:Performance_monitoring_interrupts
>        2279 ± 13%     -80.7%     439.25 ± 13%  interrupts.CPU96.RES:Rescheduling_interrupts
>       18.25 ± 19%   +5732.9%       1064 ±  8%  interrupts.CPU96.TLB:TLB_shootdowns
>        1344 ± 21%    +988.4%      14633 ± 11%  interrupts.CPU97.CAL:Function_call_interrupts
>      175.25 ± 24%   +2505.1%       4565 ± 24%  interrupts.CPU97.NMI:Non-maskable_interrupts
>      175.25 ± 24%   +2505.1%       4565 ± 24%  interrupts.CPU97.PMI:Performance_monitoring_interrupts
>        1252 ± 35%     -75.2%     311.25 ±  7%  interrupts.CPU97.RES:Rescheduling_interrupts
>       23.25 ±106%   +2841.9%     684.00 ± 11%  interrupts.CPU97.TLB:TLB_shootdowns
>        1460 ± 19%    +897.0%      14556 ± 16%  interrupts.CPU98.CAL:Function_call_interrupts
>      208.00 ±  5%   +2507.9%       5424 ± 33%  interrupts.CPU98.NMI:Non-maskable_interrupts
>      208.00 ±  5%   +2507.9%       5424 ± 33%  interrupts.CPU98.PMI:Performance_monitoring_interrupts
>        1478 ± 21%     -80.3%     291.25 ± 24%  interrupts.CPU98.RES:Rescheduling_interrupts
>       14.00 ± 44%   +4632.1%     662.50 ± 24%  interrupts.CPU98.TLB:TLB_shootdowns
>        1310 ± 32%   +1008.5%      14523 ± 11%  interrupts.CPU99.CAL:Function_call_interrupts
>      203.00 ±  3%   +2390.0%       5054 ± 28%  interrupts.CPU99.NMI:Non-maskable_interrupts
>      203.00 ±  3%   +2390.0%       5054 ± 28%  interrupts.CPU99.PMI:Performance_monitoring_interrupts
>        1333 ± 13%     -77.4%     300.75 ± 17%  interrupts.CPU99.RES:Rescheduling_interrupts
>       15.25 ± 37%   +4483.6%     699.00 ± 12%  interrupts.CPU99.TLB:TLB_shootdowns
>        3.25 ± 13%   +6584.6%     217.25 ±  8%  interrupts.IWI:IRQ_work_interrupts
>       35365 ±  2%   +2967.1%    1084710 ±  7%  interrupts.NMI:Non-maskable_interrupts
>       35365 ±  2%   +2967.1%    1084710 ±  7%  interrupts.PMI:Performance_monitoring_interrupts
>      237203 ±  2%     -72.7%      64704 ± 12%  interrupts.RES:Rescheduling_interrupts
>        3697 ± 12%   +3721.5%     141290        interrupts.TLB:TLB_shootdowns
> 
> 
> 
> ***************************************************************************************************
> lkp-csl-2sp5: 96 threads Intel(R) Xeon(R) Gold 6252 CPU @ 2.10GHz with 192G memory
> =========================================================================================
> class/compiler/cpufreq_governor/disk/kconfig/nr_threads/rootfs/tbox_group/testcase/testtime/ucode:
>    interrupt/gcc-9/performance/1HDD/x86_64-rhel-8.3/100%/debian-10.4-x86_64-20200603.cgz/lkp-csl-2sp5/stress-ng/30s/0x5002f01
> 
> commit:
>    5925fa68fe (" perf tools fixes for v5.9: 3rd batch")
>    5ef64cc898 ("mm: allow a controlled amount of unfairness in the page lock")
> 
> 5925fa68fe824465 5ef64cc8987a9211d3f3667331b
> ---------------- ---------------------------
>         fail:runs  %reproduction    fail:runs
>             |             |             |
>             :4           50%           2:4     kmsg.BTRFS_error(device_sda5):bdev/dev/sda5_errs:wr#,rd#,flush#,corrupt#,gen
>           %stddev     %change         %stddev
>               \          |                \
>     1543392 ±  2%     -62.7%     575755 ± 90%  stress-ng.sigchld.ops
>       51445 ±  2%     -62.7%      19191 ± 90%  stress-ng.sigchld.ops_per_sec
>   2.397e+08 ± 46%     -90.9%   21848257 ±  2%  stress-ng.sigrt.ops
>     7970038 ± 46%     -90.9%     727138 ±  2%  stress-ng.sigrt.ops_per_sec
>        6635            +3.0%       6831        stress-ng.time.percent_of_cpu_this_job_got
>       42339            +4.7%      44340        stress-ng.time.system_time
>        4468 ±  2%     -15.0%       3800 ±  7%  stress-ng.time.user_time
>   1.629e+09            -3.2%  1.576e+09 ±  2%  stress-ng.timerfd.ops
>    54286374            -3.2%   52528279 ±  2%  stress-ng.timerfd.ops_per_sec
>        0.75 ±173%  +33333.3%     250.75 ±149%  interrupts.104:PCI-MSI.31981637-edge.i40e-eth0-TxRx-68
>        0.75 ±173%  +33266.7%     250.25 ±150%  interrupts.CPU68.104:PCI-MSI.31981637-edge.i40e-eth0-TxRx-68
>       15.59 ±  2%      -1.8       13.80 ±  3%  mpstat.cpu.all.idle%
>        3.17 ±  4%      -0.7        2.48 ± 13%  mpstat.cpu.all.iowait%
>       46863 ± 29%     -21.0%      37005 ± 30%  proc-vmstat.nr_kernel_stack
>     6181473 ±  3%     -60.5%    2442698 ± 88%  proc-vmstat.pgreuse
>   6.755e+08 ±  8%     -27.7%  4.883e+08 ± 16%  cpuidle.C1.time
>   1.461e+08 ± 42%     -50.0%   73023084 ±  7%  cpuidle.POLL.time
>    12133129 ± 45%     -87.8%    1477722 ±  8%  cpuidle.POLL.usage
>       15.92 ±  2%     -11.7%      14.06 ±  3%  iostat.cpu.idle
>        3.18 ±  4%     -22.0%       2.48 ± 12%  iostat.cpu.iowait
>       76.37            +3.6%      79.12        iostat.cpu.system
>       15.25 ±  2%     -11.5%      13.50 ±  3%  vmstat.cpu.id
>       76.25            +3.0%      78.50        vmstat.cpu.sy
>      129.50 ± 59%     -96.9%       4.00 ± 25%  vmstat.procs.b
>       77813 ±  2%     -10.5%      69667 ±  7%  softirqs.CPU25.SCHED
>       81392 ±  7%     -15.5%      68815 ±  8%  softirqs.CPU41.SCHED
>       78946 ±  2%     -10.3%      70795 ±  6%  softirqs.CPU76.SCHED
>       78599 ±  2%     -12.4%      68835 ±  8%  softirqs.CPU77.SCHED
>       81487 ±  6%     -14.0%      70042 ±  9%  softirqs.CPU83.SCHED
>       67827 ± 16%     -31.1%      46745 ±  2%  slabinfo.Acpi-State.active_objs
>        1370 ± 17%     -32.8%     920.25 ±  2%  slabinfo.Acpi-State.active_slabs
>       69916 ± 17%     -32.8%      46969 ±  2%  slabinfo.Acpi-State.num_objs
>        1370 ± 17%     -32.8%     920.25 ±  2%  slabinfo.Acpi-State.num_slabs
>      810.00 ±  6%     +17.8%     954.00 ±  3%  slabinfo.kmem_cache_node.active_objs
>      847.50 ±  6%     +17.0%     991.50 ±  3%  slabinfo.kmem_cache_node.num_objs
>        5228           -16.6%       4359 ±  9%  slabinfo.sighand_cache.active_objs
>        5314           -15.0%       4516 ±  8%  slabinfo.sighand_cache.num_objs
>       50134 ± 42%     -70.9%      14578 ± 46%  sched_debug.cfs_rq:/.MIN_vruntime.avg
>     2621056 ± 41%     -46.6%    1399499 ± 46%  sched_debug.cfs_rq:/.MIN_vruntime.max
>      345309 ± 38%     -58.9%     142092 ± 46%  sched_debug.cfs_rq:/.MIN_vruntime.stddev
>       50134 ± 42%     -70.9%      14578 ± 46%  sched_debug.cfs_rq:/.max_vruntime.avg
>     2621056 ± 41%     -46.6%    1399499 ± 46%  sched_debug.cfs_rq:/.max_vruntime.max
>      345309 ± 38%     -58.9%     142092 ± 46%  sched_debug.cfs_rq:/.max_vruntime.stddev
>      139637 ± 19%     +35.2%     188810 ± 14%  sched_debug.cpu.avg_idle.min
>        5696 ± 33%     -57.4%       2425 ± 58%  sched_debug.cpu.max_idle_balance_cost.stddev
>      575.75           -83.2%      96.71 ± 16%  sched_debug.cpu.nr_uninterruptible.max
>     -567.52           -73.4%    -150.73        sched_debug.cpu.nr_uninterruptible.min
>      304.20 ±  8%     -88.5%      35.11 ± 18%  sched_debug.cpu.nr_uninterruptible.stddev
>      286124 ±  3%     -13.0%     248853 ±  9%  sched_debug.cpu.sched_goidle.avg
>      250037 ±  2%     -14.0%     214914 ±  8%  sched_debug.cpu.sched_goidle.min
>   1.051e+08            -6.7%   98127607 ±  4%  perf-stat.i.branch-misses
>    63185666 ±  7%     -16.5%   52728923 ± 15%  perf-stat.i.cache-misses
>   2.133e+11            +3.0%  2.196e+11        perf-stat.i.cpu-cycles
>     5687177 ±  2%      -5.4%    5377921 ±  3%  perf-stat.i.dTLB-store-misses
>   8.732e+09            -4.0%  8.379e+09        perf-stat.i.dTLB-stores
>    73450472            -4.3%   70273743        perf-stat.i.iTLB-load-misses
>        0.26            -5.7%       0.25 ±  2%  perf-stat.i.ipc
>        2.21            +3.0%       2.28        perf-stat.i.metric.GHz
>      532333            -9.8%     480107 ±  6%  perf-stat.i.page-faults
>        5.10 ±  4%     -13.4%       4.42 ± 11%  perf-stat.overall.MPKI
>        0.94            -0.0        0.92        perf-stat.overall.branch-miss-rate%
>       70.77            -6.0       64.73 ±  4%  perf-stat.overall.node-load-miss-rate%
>       83.74            -1.1       82.62        perf-stat.overall.node-store-miss-rate%
>   1.018e+08            -6.6%   95063940 ±  4%  perf-stat.ps.branch-misses
>    71426753 ±  6%     -13.6%   61704660 ± 12%  perf-stat.ps.cache-misses
>   2.156e+11            +2.8%  2.216e+11        perf-stat.ps.cpu-cycles
>   8.315e+09            -4.1%  7.972e+09 ±  2%  perf-stat.ps.dTLB-stores
>    69988088            -4.5%   66854914        perf-stat.ps.iTLB-load-misses
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
