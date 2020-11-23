Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 837672C0F15
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 16:40:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389749AbgKWPjh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 10:39:37 -0500
Received: from mga01.intel.com ([192.55.52.88]:8526 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729249AbgKWPjf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 10:39:35 -0500
IronPort-SDR: VL6LmPY7big2KN0iem6xsCjDFY18SVExDrTYE01C1F0fT+TjCdkqbz404p00LatQtRt5BAhcd5
 eoTbOIWIwsCw==
X-IronPort-AV: E=McAfee;i="6000,8403,9813"; a="189902480"
X-IronPort-AV: E=Sophos;i="5.78,363,1599548400"; 
   d="yaml'?scan'208";a="189902480"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2020 07:39:19 -0800
IronPort-SDR: YMuFw14hAuPlBUOd+e7mjNx4YQECIMrka2kJwBGE/KUrCgbA2H/hrXDo0XVuTR29Zx6Dr+Uhj5
 XzOVS+UCU2SA==
X-IronPort-AV: E=Sophos;i="5.78,363,1599548400"; 
   d="yaml'?scan'208";a="546459302"
Received: from xsang-optiplex-9020.sh.intel.com (HELO xsang-OptiPlex-9020) ([10.239.159.140])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2020 07:39:14 -0800
Date:   Mon, 23 Nov 2020 23:53:27 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     Waiman Long <longman@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
        Phil Auld <pauld@redhat.com>, Waiman Long <longman@redhat.com>,
        0day robot <lkp@intel.com>, lkp@lists.01.org,
        ying.huang@intel.com, feng.tang@intel.com, zhengjun.xing@intel.com
Subject: [locking/rwsem]  10a59003d2:  unixbench.score -25.5% regression
Message-ID: <20201123155327.GA26172@xsang-OptiPlex-9020>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="u3/rZRmxL6MmkK24"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201121041416.12285-6-longman@redhat.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--u3/rZRmxL6MmkK24
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit



Greeting,

FYI, we noticed a -25.5% regression of unixbench.score due to commit:


commit: 10a59003d29fbfa855b2ef4f3534fee9bdf4e575 ("[PATCH v2 5/5] locking/rwsem: Remove reader optimistic spinning")
url: https://github.com/0day-ci/linux/commits/Waiman-Long/locking-rwsem-Rework-reader-optimistic-spinning/20201121-122118
base: https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git 932f8c64d38bb08f69c8c26a2216ba0c36c6daa8

in testcase: unixbench
on test machine: 16 threads Intel(R) Xeon(R) E-2278G CPU @ 3.40GHz with 32G memory
with following parameters:

	runtime: 300s
	nr_task: 30%
	test: shell8
	cpufreq_governor: performance
	ucode: 0xde

test-description: UnixBench is the original BYTE UNIX benchmark suite aims to test performance of Unix-like system.
test-url: https://github.com/kdlucas/byte-unixbench

In addition to that, the commit also has significant impact on the following tests:

+------------------+---------------------------------------------------------------------------+
| testcase: change | fio-basic: fio.write_iops -29.9% regression                               |
| test machine     | 192 threads Intel(R) Xeon(R) CPU @ 2.20GHz with 192G memory               |
| test parameters  | bs=4k                                                                     |
|                  | cpufreq_governor=performance                                              |
|                  | disk=1SSD                                                                 |
|                  | fs=xfs                                                                    |
|                  | ioengine=sync                                                             |
|                  | nr_task=32                                                                |
|                  | runtime=300s                                                              |
|                  | rw=randwrite                                                              |
|                  | test_size=256g                                                            |
|                  | ucode=0x4003003                                                           |
+------------------+---------------------------------------------------------------------------+
| testcase: change | aim7: aim7.jobs-per-min 952.6% improvement                                |
| test machine     | 96 threads Intel(R) Xeon(R) Platinum 8260L CPU @ 2.40GHz with 128G memory |
| test parameters  | cpufreq_governor=performance                                              |
|                  | disk=4BRD_12G                                                             |
|                  | fs=f2fs                                                                   |
|                  | load=100                                                                  |
|                  | md=RAID0                                                                  |
|                  | test=sync_disk_rw                                                         |
|                  | ucode=0x4003003                                                           |
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
compiler/cpufreq_governor/kconfig/nr_task/rootfs/runtime/tbox_group/test/testcase/ucode:
  gcc-9/performance/x86_64-rhel-8.3/30%/debian-10.4-x86_64-20200603.cgz/300s/lkp-cfl-e1/shell8/unixbench/0xde

commit: 
  c9847a7f94 ("locking/rwsem: Wake up all waiting readers if RWSEM_WAKE_READ_OWNED")
  10a59003d2 ("locking/rwsem: Remove reader optimistic spinning")

c9847a7f94679e74 10a59003d29fbfa855b2ef4f353 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
     21939           -25.5%      16346        unixbench.score
   1287341           -46.8%     684642 ±  2%  unixbench.time.involuntary_context_switches
     37785 ±  2%      +7.6%      40661        unixbench.time.major_page_faults
 1.054e+08           -25.4%   78563350        unixbench.time.minor_page_faults
      1337           -30.1%     934.50        unixbench.time.percent_of_cpu_this_job_got
    363.18           -36.6%     230.42        unixbench.time.system_time
    481.37           -25.2%     360.16        unixbench.time.user_time
   3528615           +89.5%    6688263        unixbench.time.voluntary_context_switches
    829330           -25.5%     617908        unixbench.workload
     40455 ± 10%     +18.6%      47991 ±  3%  meminfo.AnonHugePages
    373.42 ±  3%     +73.7%     648.78        uptime.idle
      4.16 ± 86%      -4.2        0.00        perf-profile.calltrace.cycles-pp.free_pgtables.exit_mmap.mmput.do_exit.do_group_exit
      6.25 ±110%      -6.2        0.00        perf-profile.children.cycles-pp.dput
      5.95 ± 97%      -5.9        0.00        perf-profile.children.cycles-pp.free_pgtables
     11058 ±  3%     -18.9%       8972 ±  6%  slabinfo.filp.active_objs
     12400 ±  2%     -16.6%      10346 ±  6%  slabinfo.filp.num_objs
      5364 ±  3%     -39.6%       3238 ± 16%  slabinfo.task_delay_info.active_objs
      5364 ±  3%     -39.6%       3238 ± 16%  slabinfo.task_delay_info.num_objs
     13.83 ±  4%     +26.6       40.40        mpstat.cpu.all.idle%
      1.06            -0.1        0.91        mpstat.cpu.all.irq%
      0.54            +0.1        0.69 ±  7%  mpstat.cpu.all.soft%
     50.14           -14.5       35.61        mpstat.cpu.all.sys%
     34.43           -12.0       22.39        mpstat.cpu.all.usr%
     15.50 ±  3%    +167.7%      41.50        vmstat.cpu.id
     49.75           -28.1%      35.75        vmstat.cpu.sy
     33.00           -35.6%      21.25 ±  2%  vmstat.cpu.us
     21.25 ±  5%     -35.3%      13.75 ± 12%  vmstat.procs.r
    113264           +82.8%     206990        vmstat.system.cs
     37223           -14.8%      31718 ± 20%  vmstat.system.in
  50992679 ±  8%    +329.6%   2.19e+08 ±  3%  cpuidle.C1.time
   1297530 ±  6%    +230.7%    4290676 ±  5%  cpuidle.C1.usage
    190270 ± 12%     -41.6%     111170 ± 18%  cpuidle.C10.time
  21241624 ±  6%    +186.1%   60774649 ± 10%  cpuidle.C1E.time
    458079 ±  6%    +119.6%    1005897 ±  9%  cpuidle.C1E.usage
   4577780 ± 17%    +595.5%   31836464 ± 12%  cpuidle.C3.time
     62068 ± 13%    +527.9%     389751 ± 11%  cpuidle.C3.usage
  31244183 ± 25%     +68.9%   52781560 ± 11%  cpuidle.C6.time
     50282 ± 17%    +325.2%     213780 ± 13%  cpuidle.C6.usage
    259071 ±  8%    +509.9%    1580003 ±  8%  cpuidle.POLL.time
     32585 ±  7%    +633.5%     239029 ±  7%  cpuidle.POLL.usage
    522.75            +9.7%     573.25 ±  3%  proc-vmstat.nr_active_anon
      5838            +3.4%       6034        proc-vmstat.nr_kernel_stack
      1416            +5.5%       1494        proc-vmstat.nr_page_table_pages
     13041            -1.0%      12911        proc-vmstat.nr_slab_reclaimable
    522.75            +9.7%     573.25 ±  3%  proc-vmstat.nr_zone_active_anon
  71020069           -24.7%   53452045        proc-vmstat.numa_hit
  71020069           -24.7%   53452045        proc-vmstat.numa_local
    115977           -39.0%      70793        proc-vmstat.pgactivate
  75313926           -24.8%   56608462        proc-vmstat.pgalloc_normal
 1.056e+08           -25.4%   78785247        proc-vmstat.pgfault
  75305695           -24.8%   56602456        proc-vmstat.pgfree
   5357159           -28.6%    3826576        proc-vmstat.pgreuse
      3475           -24.0%       2641        proc-vmstat.thp_fault_alloc
   1474994           -25.5%    1099150        proc-vmstat.unevictable_pgs_culled
    250788           -41.8%     146078 ±  3%  softirqs.CPU0.RCU
    248710           -39.9%     149519        softirqs.CPU1.RCU
    248300           -52.5%     118065 ± 41%  softirqs.CPU10.RCU
    246447 ±  2%     -39.2%     149847        softirqs.CPU11.RCU
    250321           -52.0%     120263 ± 43%  softirqs.CPU12.RCU
    247140 ±  2%     -39.3%     150089        softirqs.CPU13.RCU
     13849 ±  2%     +10.4%      15286        softirqs.CPU13.SCHED
    250080           -50.5%     123681 ± 36%  softirqs.CPU14.RCU
    248790           -38.6%     152862 ±  2%  softirqs.CPU15.RCU
    247174           -39.6%     149226        softirqs.CPU2.RCU
    248590           -39.3%     150877        softirqs.CPU3.RCU
    250818           -39.8%     150890 ±  2%  softirqs.CPU4.RCU
    246772 ±  2%     -39.1%     150263        softirqs.CPU5.RCU
    248637           -39.0%     151575        softirqs.CPU6.RCU
    249756           -40.1%     149525 ±  3%  softirqs.CPU7.RCU
    248263           -42.8%     142057 ±  2%  softirqs.CPU8.RCU
    242793 ±  2%     -38.8%     148663        softirqs.CPU9.RCU
   3973390           -42.0%    2303491 ±  5%  softirqs.RCU
     25441           -29.8%      17865        sched_debug.cfs_rq:/.exec_clock.avg
     26174           -29.0%      18583        sched_debug.cfs_rq:/.exec_clock.max
     25149           -30.4%      17493        sched_debug.cfs_rq:/.exec_clock.min
    293.59 ±  5%     +13.5%     333.29 ± 14%  sched_debug.cfs_rq:/.exec_clock.stddev
    188.59 ± 19%     -29.2%     133.54 ± 12%  sched_debug.cfs_rq:/.load_avg.avg
     26.12 ± 23%     -48.8%      13.38 ± 50%  sched_debug.cfs_rq:/.load_avg.min
    443268           -28.2%     318361        sched_debug.cfs_rq:/.min_vruntime.avg
    489789           -21.5%     384542 ±  4%  sched_debug.cfs_rq:/.min_vruntime.max
    431839           -29.6%     304066        sched_debug.cfs_rq:/.min_vruntime.min
      0.38 ± 22%     +31.7%       0.51 ±  6%  sched_debug.cfs_rq:/.nr_running.stddev
      1.92 ± 14%     -30.1%       1.34 ± 12%  sched_debug.cfs_rq:/.nr_spread_over.avg
    905.09 ±  3%      +9.9%     994.48 ±  4%  sched_debug.cfs_rq:/.runnable_avg.avg
    870.48 ±  4%      +8.5%     944.88 ±  3%  sched_debug.cfs_rq:/.util_avg.avg
     91.52 ± 17%     +58.8%     145.33 ± 23%  sched_debug.cfs_rq:/.util_est_enqueued.avg
     30990 ± 17%     -34.1%      20422 ± 12%  sched_debug.cpu.avg_idle.min
     11558 ± 25%     -53.5%       5376 ± 38%  sched_debug.cpu.curr->pid.avg
      0.00 ±  4%     -26.3%       0.00 ± 19%  sched_debug.cpu.next_balance.stddev
      1.10 ±  7%     -27.0%       0.80 ± 19%  sched_debug.cpu.nr_running.avg
    225114           +80.9%     407331        sched_debug.cpu.nr_switches.avg
    239349           +79.5%     429598        sched_debug.cpu.nr_switches.max
    210368           +82.6%     384043        sched_debug.cpu.nr_switches.min
      6933 ±  8%     +47.7%      10240 ±  7%  sched_debug.cpu.nr_switches.stddev
      0.20 ±182%    +276.9%       0.77 ± 16%  sched_debug.cpu.nr_uninterruptible.avg
    105.88 ± 13%    +193.6%     310.88 ± 15%  sched_debug.cpu.nr_uninterruptible.max
   -188.38          +222.9%    -608.25        sched_debug.cpu.nr_uninterruptible.min
     72.96 ± 16%    +191.3%     212.52 ±  7%  sched_debug.cpu.nr_uninterruptible.stddev
    219447           +83.3%     402333        sched_debug.cpu.sched_count.avg
    223137           +83.2%     408852        sched_debug.cpu.sched_count.max
    208437           +82.8%     381062        sched_debug.cpu.sched_count.min
      3763 ± 10%     +75.0%       6584 ± 23%  sched_debug.cpu.sched_count.stddev
     56141 ±  3%    +199.1%     167917        sched_debug.cpu.sched_goidle.avg
     57397 ±  3%    +197.7%     170892        sched_debug.cpu.sched_goidle.max
     53349 ±  2%    +197.8%     158895        sched_debug.cpu.sched_goidle.min
      1064 ± 10%    +161.3%       2782 ± 22%  sched_debug.cpu.sched_goidle.stddev
     97665           +98.5%     193817        sched_debug.cpu.ttwu_count.avg
    100103           +97.6%     197827        sched_debug.cpu.ttwu_count.max
     91752 ±  2%    +100.6%     184037        sched_debug.cpu.ttwu_count.min
      2014 ± 18%     +66.4%       3351 ± 16%  sched_debug.cpu.ttwu_count.stddev
     42150           -25.4%      31431        sched_debug.cpu.ttwu_local.avg
     42994           -25.0%      32238        sched_debug.cpu.ttwu_local.max
     39998           -26.4%      29443 ±  3%  sched_debug.cpu.ttwu_local.min
    519.50 ±139%   +1032.1%       5881 ± 75%  interrupts.132:IR-PCI-MSI.2097153-edge.eth1-TxRx-0
      1078 ±159%     -95.8%      45.75 ± 10%  interrupts.134:IR-PCI-MSI.2097155-edge.eth1-TxRx-2
     21268 ±  3%    +143.8%      51854 ±  2%  interrupts.CAL:Function_call_interrupts
      1603 ± 15%     +93.9%       3109 ±  5%  interrupts.CPU0.CAL:Function_call_interrupts
     26260           -37.4%      16446 ±  3%  interrupts.CPU0.RES:Rescheduling_interrupts
    639.00 ± 11%    +240.8%       2177 ±  5%  interrupts.CPU0.TLB:TLB_shootdowns
    519.50 ±139%   +1032.1%       5881 ± 75%  interrupts.CPU1.132:IR-PCI-MSI.2097153-edge.eth1-TxRx-0
      1237 ±  6%    +155.9%       3166 ±  5%  interrupts.CPU1.CAL:Function_call_interrupts
     26527           -36.2%      16918        interrupts.CPU1.RES:Rescheduling_interrupts
    654.50 ±  2%    +241.6%       2235 ±  2%  interrupts.CPU1.TLB:TLB_shootdowns
      1267 ±  8%    +154.5%       3225 ±  5%  interrupts.CPU10.CAL:Function_call_interrupts
     26382           -35.7%      16965 ±  2%  interrupts.CPU10.RES:Rescheduling_interrupts
    663.75 ±  4%    +238.0%       2243 ±  2%  interrupts.CPU10.TLB:TLB_shootdowns
      1434 ± 13%    +128.8%       3280 ±  3%  interrupts.CPU11.CAL:Function_call_interrupts
     26307           -34.8%      17142        interrupts.CPU11.RES:Rescheduling_interrupts
    658.00 ±  4%    +236.8%       2216 ±  2%  interrupts.CPU11.TLB:TLB_shootdowns
      1320 ±  4%    +143.8%       3218 ±  2%  interrupts.CPU12.CAL:Function_call_interrupts
     26594           -35.4%      17171        interrupts.CPU12.RES:Rescheduling_interrupts
    697.75 ±  3%    +217.7%       2217        interrupts.CPU12.TLB:TLB_shootdowns
      1332 ±  3%    +153.4%       3375 ± 13%  interrupts.CPU13.CAL:Function_call_interrupts
     26096 ±  2%     -34.8%      17024        interrupts.CPU13.RES:Rescheduling_interrupts
    690.50 ±  6%    +220.1%       2210 ±  3%  interrupts.CPU13.TLB:TLB_shootdowns
      1335 ±  6%    +144.0%       3258 ±  3%  interrupts.CPU14.CAL:Function_call_interrupts
     26453           -34.7%      17268        interrupts.CPU14.RES:Rescheduling_interrupts
    667.50 ±  6%    +234.4%       2232        interrupts.CPU14.TLB:TLB_shootdowns
      1302 ±  3%    +146.2%       3205 ±  5%  interrupts.CPU15.CAL:Function_call_interrupts
     26159           -35.1%      16980        interrupts.CPU15.RES:Rescheduling_interrupts
    694.00 ±  8%    +226.7%       2267 ±  4%  interrupts.CPU15.TLB:TLB_shootdowns
      1283 ±  5%    +142.8%       3114 ±  3%  interrupts.CPU2.CAL:Function_call_interrupts
     25846           -35.0%      16792 ±  2%  interrupts.CPU2.RES:Rescheduling_interrupts
    662.75 ±  6%    +233.2%       2208        interrupts.CPU2.TLB:TLB_shootdowns
      1078 ±159%     -95.8%      45.75 ± 10%  interrupts.CPU3.134:IR-PCI-MSI.2097155-edge.eth1-TxRx-2
      1330 ±  6%    +178.9%       3710 ± 11%  interrupts.CPU3.CAL:Function_call_interrupts
     26346           -35.9%      16877        interrupts.CPU3.RES:Rescheduling_interrupts
    678.00 ±  8%    +224.9%       2202 ±  2%  interrupts.CPU3.TLB:TLB_shootdowns
      1300 ±  3%    +144.9%       3183        interrupts.CPU4.CAL:Function_call_interrupts
     26432           -37.2%      16586        interrupts.CPU4.RES:Rescheduling_interrupts
    675.75 ±  2%    +223.3%       2184 ±  2%  interrupts.CPU4.TLB:TLB_shootdowns
      1261          +150.0%       3153 ±  4%  interrupts.CPU5.CAL:Function_call_interrupts
     26321           -36.1%      16814        interrupts.CPU5.RES:Rescheduling_interrupts
    681.75 ±  6%    +223.0%       2201 ±  2%  interrupts.CPU5.TLB:TLB_shootdowns
      1274 ±  5%    +149.3%       3176 ±  4%  interrupts.CPU6.CAL:Function_call_interrupts
     26106           -34.9%      17005        interrupts.CPU6.RES:Rescheduling_interrupts
    659.50 ±  4%    +234.6%       2207        interrupts.CPU6.TLB:TLB_shootdowns
      1293 ±  2%    +150.7%       3241 ±  3%  interrupts.CPU7.CAL:Function_call_interrupts
     26066           -36.8%      16468 ±  2%  interrupts.CPU7.RES:Rescheduling_interrupts
    678.50 ±  7%    +228.1%       2226 ±  4%  interrupts.CPU7.TLB:TLB_shootdowns
      1354 ± 12%    +132.3%       3145 ±  5%  interrupts.CPU8.CAL:Function_call_interrupts
     26259           -37.1%      16509        interrupts.CPU8.RES:Rescheduling_interrupts
    679.75 ±  7%    +221.8%       2187 ±  2%  interrupts.CPU8.TLB:TLB_shootdowns
      1338 ± 12%    +145.8%       3289 ±  2%  interrupts.CPU9.CAL:Function_call_interrupts
     25685 ±  2%     -33.4%      17114        interrupts.CPU9.RES:Rescheduling_interrupts
    657.75 ±  2%    +244.5%       2266 ±  3%  interrupts.CPU9.TLB:TLB_shootdowns
    419844           -35.7%     270085        interrupts.RES:Rescheduling_interrupts
     10738 ±  4%    +230.4%      35483        interrupts.TLB:TLB_shootdowns
     48.03            +6.7%      51.27        perf-stat.i.MPKI
 1.008e+10           -23.2%  7.737e+09        perf-stat.i.branch-instructions
      2.27            +0.0        2.30        perf-stat.i.branch-miss-rate%
 2.205e+08           -21.7%  1.726e+08        perf-stat.i.branch-misses
      4.69            +0.2        4.89        perf-stat.i.cache-miss-rate%
 1.009e+08           -13.0%   87791224        perf-stat.i.cache-misses
 2.442e+09           -18.2%  1.997e+09        perf-stat.i.cache-references
    117262           +83.3%     214963        perf-stat.i.context-switches
      1.17            -3.4%       1.13        perf-stat.i.cpi
 5.529e+10           -26.1%  4.088e+10        perf-stat.i.cpu-cycles
     18271 ±  2%    +149.1%      45523        perf-stat.i.cpu-migrations
    593.84           -12.8%     517.54 ±  2%  perf-stat.i.cycles-between-cache-misses
      0.06 ±  2%      +0.0        0.08 ±  3%  perf-stat.i.dTLB-load-miss-rate%
 1.253e+10           -23.5%  9.585e+09        perf-stat.i.dTLB-loads
      0.05            +0.0        0.05        perf-stat.i.dTLB-store-miss-rate%
   3638057           -19.1%    2941687        perf-stat.i.dTLB-store-misses
 7.236e+09           -23.7%   5.52e+09        perf-stat.i.dTLB-stores
     57.59            -3.4       54.19        perf-stat.i.iTLB-load-miss-rate%
  10438031           -19.4%    8408188        perf-stat.i.iTLB-load-misses
   7925579            -6.8%    7388686        perf-stat.i.iTLB-loads
 4.914e+10           -23.4%  3.763e+10        perf-stat.i.instructions
      5390            -4.2%       5162        perf-stat.i.instructions-per-iTLB-miss
      0.88            +3.5%       0.91        perf-stat.i.ipc
    591.27 ±  2%      +7.6%     636.05        perf-stat.i.major-faults
      3.46           -26.1%       2.55        perf-stat.i.metric.GHz
      2021           -23.1%       1555        perf-stat.i.metric.M/sec
   1619167           -25.4%    1207381        perf-stat.i.minor-faults
      0.00 ± 15%      +0.0        0.01 ±115%  perf-stat.i.node-load-miss-rate%
     47.02 ± 19%    +455.1%     260.98 ±117%  perf-stat.i.node-load-misses
   5399939            -9.5%    4887416        perf-stat.i.node-loads
     46.42 ± 20%    +472.0%     265.53 ±117%  perf-stat.i.node-store-misses
  32686027           -14.7%   27888853        perf-stat.i.node-stores
   1619758           -25.4%    1208017        perf-stat.i.page-faults
     49.70            +6.8%      53.06        perf-stat.overall.MPKI
      2.19            +0.0        2.23        perf-stat.overall.branch-miss-rate%
      4.13            +0.3        4.40        perf-stat.overall.cache-miss-rate%
      1.13            -3.4%       1.09        perf-stat.overall.cpi
    547.96           -15.0%     465.71        perf-stat.overall.cycles-between-cache-misses
      0.06 ±  2%      +0.0        0.08 ±  3%  perf-stat.overall.dTLB-load-miss-rate%
      0.05            +0.0        0.05        perf-stat.overall.dTLB-store-miss-rate%
     56.84            -3.6       53.23        perf-stat.overall.iTLB-load-miss-rate%
      4708            -4.9%       4475        perf-stat.overall.instructions-per-iTLB-miss
      0.89            +3.6%       0.92        perf-stat.overall.ipc
      0.00 ± 19%      +0.0        0.01 ±117%  perf-stat.overall.node-load-miss-rate%
      0.00 ± 19%      +0.0        0.00 ±117%  perf-stat.overall.node-store-miss-rate%
   3739839            +3.3%    3861837        perf-stat.overall.path-length
 9.918e+09           -23.3%  7.611e+09        perf-stat.ps.branch-instructions
  2.17e+08           -21.8%  1.698e+08        perf-stat.ps.branch-misses
  99277053           -13.0%   86352292        perf-stat.ps.cache-misses
 2.403e+09           -18.3%  1.964e+09        perf-stat.ps.cache-references
    115371           +83.3%     211429        perf-stat.ps.context-switches
  5.44e+10           -26.1%  4.021e+10        perf-stat.ps.cpu-cycles
     17977 ±  2%    +149.1%      44774        perf-stat.ps.cpu-migrations
 1.233e+10           -23.5%  9.428e+09        perf-stat.ps.dTLB-loads
   3579226           -19.2%    2893270        perf-stat.ps.dTLB-store-misses
 7.119e+09           -23.7%  5.429e+09        perf-stat.ps.dTLB-stores
  10269385           -19.5%    8270074        perf-stat.ps.iTLB-load-misses
   7797424            -6.8%    7267132        perf-stat.ps.iTLB-loads
 4.835e+10           -23.4%  3.702e+10        perf-stat.ps.instructions
    581.70 ±  2%      +7.5%     625.60        perf-stat.ps.major-faults
   1592966           -25.5%    1187499        perf-stat.ps.minor-faults
     46.26 ± 19%    +454.5%     256.51 ±117%  perf-stat.ps.node-load-misses
   5312864            -9.5%    4807129        perf-stat.ps.node-loads
     45.67 ± 20%    +471.5%     260.99 ±117%  perf-stat.ps.node-store-misses
  32157625           -14.7%   27429683        perf-stat.ps.node-stores
   1593547           -25.4%    1188124        perf-stat.ps.page-faults
 3.102e+12           -23.1%  2.386e+12        perf-stat.total.instructions


                                                                                
                             unixbench.time.user_time                           
                                                                                
  500 +---------------------------------------------------------------------+   
  480 |..+    +..+.+.    +.              +.   +..+..+.+..+..+..+.+..+       |   
      |                                                                     |   
  460 |-+                                                                   |   
  440 |-+                                                                   |   
      |                                                                     |   
  420 |-+                                                                   |   
  400 |-+                                                                   |   
  380 |-+                                                                   |   
      |                                                                     |   
  360 |-+          O  O  O  O O  O  O O  O  O O  O  O O  O  O  O O  O  O O  |   
  340 |-+                                                                   |   
      |    O                                                                |   
  320 |-+O    O  O                                                          |   
  300 +---------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                            unixbench.time.system_time                          
                                                                                
  380 +---------------------------------------------------------------------+   
      |       +.            +.+..+.   +.    +    +..+.+..+..  .+.+..+       |   
  360 |-+                                                   +.              |   
  340 |-+                                                                   |   
      |                                                                     |   
  320 |-+                                                                   |   
  300 |-+                                                                   |   
      |                                                                     |   
  280 |-+                                                                   |   
  260 |-+                                                                   |   
      |                                                                     |   
  240 |-+             O  O       O                                          |   
  220 |-+          O        O O     O O  O  O O  O  O O  O  O  O O  O  O O  |   
      |                                                                     |   
  200 +---------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                    unixbench.time.percent_of_cpu_this_job_got                  
                                                                                
  1400 +--------------------------------------------------------------------+   
       |..+.+..+..+.+..+..+.+..+..+.+..+..+.+..+.+..+..+.+..  .+.+..+       |   
  1300 |-+                                                  +.              |   
       |                                                                    |   
       |                                                                    |   
  1200 |-+                                                                  |   
       |                                                                    |   
  1100 |-+                                                                  |   
       |                                                                    |   
  1000 |-+                                                                  |   
       |                                                                    |   
       |            O  O  O O  O  O O  O  O O  O O  O  O O  O  O O  O  O O  |   
   900 |-+                                                                  |   
       |  O O  O  O                                                         |   
   800 +--------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                           unixbench.time.minor_page_faults                     
                                                                                
   1.1e+08 +----------------------------------------------------------------+   
           |..+.+..+.+..+    +    +.+..+.+..+.+..+.+..+.+..+.+..+.+..+      |   
  1.05e+08 |-+                                                              |   
     1e+08 |-+                                                              |   
           |                                                                |   
   9.5e+07 |-+                                                              |   
     9e+07 |-+                                                              |   
           |                                                                |   
   8.5e+07 |-+                                                              |   
     8e+07 |-+                                                              |   
           |            O O  O O  O O  O O  O O  O O  O O  O O  O O  O O  O |   
   7.5e+07 |-+                                                              |   
     7e+07 |-+O O  O                                                        |   
           |         O                                                      |   
   6.5e+07 +----------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                       unixbench.time.voluntary_context_switches                
                                                                                
    7e+06 +-----------------------------------------------------------------+   
          |            O O  O O  O O  O O  O  O O  O O  O O  O O  O O  O O  |   
  6.5e+06 |-+                                                               |   
    6e+06 |-+                                                               |   
          |  O O  O O                                                       |   
  5.5e+06 |-+                                                               |   
          |                                                                 |   
    5e+06 |-+                                                               |   
          |                                                                 |   
  4.5e+06 |-+                                                               |   
    4e+06 |-+                                                               |   
          |                                                                 |   
  3.5e+06 |-+                                               .+.+..+.+       |   
          |                     .+.    .+..  .+.  .+.+..+.+.                |   
    3e+06 +-----------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                      unixbench.time.involuntary_context_switches               
                                                                                
  1.4e+06 +-----------------------------------------------------------------+   
          |  +.+..+.+..+.+..+.+..+.+.   +..  .+.    .+..+.+..               |   
  1.3e+06 |..                              +.   +..+         +.+..+.+       |   
          |                                                                 |   
  1.2e+06 |-+                                                               |   
  1.1e+06 |-+                                                               |   
          |                                                                 |   
    1e+06 |-+                                                               |   
          |                                                                 |   
   900000 |-+                                                               |   
   800000 |-+                                                               |   
          |  O O  O                                                         |   
   700000 |-+       O  O    O O  O O  O    O         O  O O         O       |   
          |              O              O     O O  O         O O  O    O O  |   
   600000 +-----------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                                   unixbench.score                              
                                                                                
  23000 +-------------------------------------------------------------------+   
        |..+.+..+.+..+..+.+..+..+.+..+.+..+..+.+..+.+..+..+.                |   
  22000 |-+                                                 +..+..+.+       |   
  21000 |-+                                                                 |   
        |                                                                   |   
  20000 |-+                                                                 |   
  19000 |-+                                                                 |   
        |                                                                   |   
  18000 |-+                                                                 |   
  17000 |-+                                                                 |   
        |            O       O  O O  O    O  O O    O  O  O O  O  O O  O O  |   
  16000 |-+             O O            O          O                         |   
  15000 |-+                                                                 |   
        |  O O  O O                                                         |   
  14000 +-------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                                 unixbench.workload                             
                                                                                
  900000 +------------------------------------------------------------------+   
         |                        .+.                                       |   
  850000 |..+.+..+.+..+.+..+..+.+.   +..+..+.+..+.+..+.+..+.. .+..+.        |   
         |                                                   +      +       |   
  800000 |-+                                                                |   
  750000 |-+                                                                |   
         |                                                                  |   
  700000 |-+                                                                |   
         |                                                                  |   
  650000 |-+                                                                |   
  600000 |-+          O O  O  O O  O O  O  O O  O O  O O  O  O O  O O  O O  |   
         |                                                                  |   
  550000 |-+O O  O O                                                        |   
         |                                                                  |   
  500000 +------------------------------------------------------------------+   
                                                                                
                                                                                
[*] bisect-good sample
[O] bisect-bad  sample

***************************************************************************************************
lkp-csl-2ap1: 192 threads Intel(R) Xeon(R) CPU @ 2.20GHz with 192G memory
=========================================================================================
bs/compiler/cpufreq_governor/disk/fs/ioengine/kconfig/nr_task/rootfs/runtime/rw/tbox_group/test_size/testcase/ucode:
  4k/gcc-9/performance/1SSD/xfs/sync/x86_64-rhel-8.3/32/debian-10.4-x86_64-20200603.cgz/300s/randwrite/lkp-csl-2ap1/256g/fio-basic/0x4003003

commit: 
  c9847a7f94 ("locking/rwsem: Wake up all waiting readers if RWSEM_WAKE_READ_OWNED")
  10a59003d2 ("locking/rwsem: Remove reader optimistic spinning")

c9847a7f94679e74 10a59003d29fbfa855b2ef4f353 
---------------- --------------------------- 
       fail:runs  %reproduction    fail:runs
           |             |             |    
           :4           25%           1:4     kmsg.ACPI_Error
         %stddev     %change         %stddev
             \          |                \  
      0.04 ±  5%      +0.1        0.10 ±  6%  fio.latency_100us%
     33.62 ±  7%      +3.6       37.18 ±  3%  fio.latency_10us%
      0.01            +0.0        0.05 ±  6%  fio.latency_250us%
      0.14 ±  9%      -0.1        0.03 ± 61%  fio.latency_2us%
     59.95 ±  3%      -4.3       55.60 ±  2%  fio.latency_4us%
      0.34 ±  2%      +0.1        0.46        fio.latency_50ms%
    256.52           +17.5%     301.42        fio.time.elapsed_time
    256.52           +17.5%     301.42        fio.time.elapsed_time.max
 5.369e+08           -17.5%   4.43e+08        fio.time.file_system_outputs
      1384 ± 13%    +410.5%       7064 ± 21%  fio.time.involuntary_context_switches
    153.25           -23.5%     117.25 ±  3%  fio.time.percent_of_cpu_this_job_got
    316.95 ±  2%     -10.8%     282.66 ±  3%  fio.time.system_time
     77.63            -6.9%      72.27 ±  3%  fio.time.user_time
    631893 ±  7%    +225.6%    2057309 ±  4%  fio.time.voluntary_context_switches
  67108864           -17.5%   55373247        fio.workload
      1027           -29.9%     720.93        fio.write_bw_MBps
     20288 ±  5%     +19.2%      24192 ±  4%  fio.write_clat_99%_us
    117541           +46.9%     172624        fio.write_clat_mean_us
   1928136           +27.7%    2462685        fio.write_clat_stddev
    263161           -29.9%     184558        fio.write_iops
     14.11            +6.5%      15.03        iostat.cpu.iowait
      2.94           -16.2%       2.46        iostat.cpu.system
      1.51            -0.5        1.00        mpstat.cpu.all.sys%
      0.15            -0.0        0.12 ±  3%  mpstat.cpu.all.usr%
    297.78           +14.8%     342.00        uptime.boot
     47592           +14.2%      54341        uptime.idle
  13822886 ± 16%     -35.1%    8966774 ± 32%  numa-numastat.node1.local_node
  13838524 ± 16%     -35.0%    8997869 ± 32%  numa-numastat.node1.numa_hit
   2422719 ± 27%     -52.3%    1155068 ± 43%  numa-numastat.node2.numa_foreign
   6968721 ± 52%    +189.4%   20169562 ±  5%  cpuidle.C1.usage
 3.139e+10 ± 51%     +74.9%  5.488e+10        cpuidle.C1E.time
  76223737 ± 30%     +59.5%  1.216e+08        cpuidle.C1E.usage
  15993891 ± 63%    +148.7%   39780679 ±  4%  cpuidle.POLL.time
   2432485 ± 11%    +461.8%   13666817 ±  5%  cpuidle.POLL.usage
    929962           -32.4%     628917        vmstat.io.bo
 1.387e+08           -13.0%  1.206e+08        vmstat.memory.cache
  56328701           +32.2%   74444784        vmstat.memory.free
     11079 ±  2%   +2404.1%     277436        vmstat.system.cs
    526522            -3.1%     509959        vmstat.system.in
      8306            +9.6%       9105        meminfo.Active(anon)
 1.378e+08           -13.0%  1.198e+08        meminfo.Cached
  1.37e+08           -13.1%   1.19e+08        meminfo.Inactive
 1.356e+08           -13.3%  1.176e+08        meminfo.Inactive(file)
  56492602           +32.0%   74549292        meminfo.MemFree
 1.412e+08           -12.8%  1.232e+08        meminfo.Memused
     18226 ±  2%     -87.4%       2302 ± 24%  meminfo.Writeback
    763436           -16.4%     638161        meminfo.max_used_kB
  11511284 ±  6%     +48.5%   17092100 ± 28%  numa-meminfo.node0.MemFree
  37643579           -14.8%   32062762 ± 15%  numa-meminfo.node0.MemUsed
      5353 ±  7%     -87.6%     664.50 ± 30%  numa-meminfo.node0.Writeback
  37095792 ±  2%     -11.0%   33024787 ±  4%  numa-meminfo.node1.FilePages
  36877519 ±  2%     -10.9%   32843351 ±  4%  numa-meminfo.node1.Inactive
  36551402 ±  3%     -11.1%   32491409 ±  6%  numa-meminfo.node1.Inactive(file)
  12041430 ±  7%     +32.7%   15975564 ± 10%  numa-meminfo.node1.MemFree
  37493024 ±  2%     -10.5%   33558891 ±  4%  numa-meminfo.node1.MemUsed
      5475 ±  8%     -87.5%     686.25 ± 16%  numa-meminfo.node1.Writeback
  34723911 ±  5%     -17.0%   28828495 ± 11%  numa-meminfo.node2.FilePages
  34527637 ±  5%     -17.2%   28599325 ± 12%  numa-meminfo.node2.Inactive
  33909426 ±  4%     -16.6%   28295544 ± 11%  numa-meminfo.node2.Inactive(file)
  14433625 ± 12%     +36.9%   19759122 ± 18%  numa-meminfo.node2.MemFree
      2723 ± 67%     -49.6%       1373 ±118%  numa-meminfo.node2.PageTables
      4375 ± 11%     -85.0%     657.75 ± 11%  numa-meminfo.node2.Writeback
      3900 ± 29%     -84.2%     615.50 ± 37%  numa-meminfo.node3.Writeback
  10098273 ±  3%     -20.8%    7998683 ± 18%  numa-vmstat.node0.nr_dirtied
   2877523 ±  6%     +48.4%    4270350 ± 28%  numa-vmstat.node0.nr_free_pages
      1360 ± 11%     -86.5%     183.00 ± 23%  numa-vmstat.node0.nr_writeback
   8070468 ±  2%     -26.8%    5909623 ± 21%  numa-vmstat.node0.nr_written
  10724541 ±  5%     -21.4%    8433227 ±  7%  numa-vmstat.node1.nr_dirtied
   9274641 ±  2%     -11.0%    8258905 ±  4%  numa-vmstat.node1.nr_file_pages
   3009682 ±  7%     +32.6%    3991208 ± 10%  numa-vmstat.node1.nr_free_pages
   9138561 ±  3%     -11.1%    8125800 ±  6%  numa-vmstat.node1.nr_inactive_file
      1398 ±  8%     -85.1%     208.50 ± 22%  numa-vmstat.node1.nr_writeback
   8489928 ±  6%     -25.6%    6312338 ±  8%  numa-vmstat.node1.nr_written
   9138656 ±  3%     -11.1%    8125844 ±  6%  numa-vmstat.node1.nr_zone_inactive_file
   9486707 ±  6%     -24.2%    7193218 ± 12%  numa-vmstat.node2.nr_dirtied
   8682169 ±  5%     -17.0%    7210434 ± 11%  numa-vmstat.node2.nr_file_pages
   3607260 ± 12%     +36.9%    4936622 ± 18%  numa-vmstat.node2.nr_free_pages
   8478548 ±  4%     -16.5%    7077427 ± 11%  numa-vmstat.node2.nr_inactive_file
    677.50 ± 68%     -49.7%     341.00 ±119%  numa-vmstat.node2.nr_page_table_pages
      1037 ± 18%     -85.2%     153.00 ± 11%  numa-vmstat.node2.nr_writeback
   7392605 ±  7%     -30.2%    5158591 ± 15%  numa-vmstat.node2.nr_written
   8478605 ±  4%     -16.5%    7077446 ± 11%  numa-vmstat.node2.nr_zone_inactive_file
    951.75 ± 32%     -83.7%     154.75 ± 21%  numa-vmstat.node3.nr_writeback
      2423 ±  4%     -12.6%       2116 ±  3%  slabinfo.Acpi-Parse.active_objs
      2423 ±  4%     -12.6%       2116 ±  3%  slabinfo.Acpi-Parse.num_objs
      4105 ±  4%     -67.3%       1343 ±  3%  slabinfo.biovec-max.active_objs
    522.75 ±  4%     -67.0%     172.25 ±  4%  slabinfo.biovec-max.active_slabs
      4184 ±  4%     -67.0%       1380 ±  4%  slabinfo.biovec-max.num_objs
    522.75 ±  4%     -67.0%     172.25 ±  4%  slabinfo.biovec-max.num_slabs
      4329 ±  6%     +20.2%       5203 ±  5%  slabinfo.ip6-frags.active_objs
      4329 ±  6%     +20.2%       5203 ±  5%  slabinfo.ip6-frags.num_objs
     21021 ±  4%     -25.6%      15642        slabinfo.kmalloc-128.active_objs
     21433 ±  4%     -26.0%      15861        slabinfo.kmalloc-128.num_objs
     16475 ±  4%     -28.5%      11778        slabinfo.kmalloc-4k.active_objs
      2258 ±  4%     -28.8%       1608        slabinfo.kmalloc-4k.active_slabs
     18069 ±  4%     -28.8%      12871        slabinfo.kmalloc-4k.num_objs
      2258 ±  4%     -28.8%       1608        slabinfo.kmalloc-4k.num_slabs
      6140           -11.7%       5419        slabinfo.kmalloc-8k.active_slabs
     24564           -11.7%      21680        slabinfo.kmalloc-8k.num_objs
      6140           -11.7%       5419        slabinfo.kmalloc-8k.num_slabs
     27805 ±  4%     -16.3%      23275 ±  4%  slabinfo.numa_policy.active_objs
    470.00 ±  3%     -19.6%     377.75 ±  5%  slabinfo.numa_policy.active_slabs
     29169 ±  3%     -19.6%      23440 ±  4%  slabinfo.numa_policy.num_objs
    470.00 ±  3%     -19.6%     377.75 ±  5%  slabinfo.numa_policy.num_slabs
     20269 ±  4%     -27.1%      14776 ±  3%  slabinfo.pool_workqueue.active_objs
     20699 ±  4%     -27.9%      14916 ±  3%  slabinfo.pool_workqueue.num_objs
     16526           +13.9%      18824 ±  7%  slabinfo.proc_inode_cache.active_objs
     17590           +13.3%      19925 ±  6%  slabinfo.proc_inode_cache.num_objs
      3233 ±  9%     -82.7%     559.50 ± 10%  slabinfo.xfs_efd_item.active_objs
      3369 ±  9%     -83.2%     567.00 ± 10%  slabinfo.xfs_efd_item.num_objs
      3276 ±  8%     -82.7%     567.50 ± 10%  slabinfo.xfs_efi_item.active_objs
      3411 ±  8%     -83.1%     575.50 ± 10%  slabinfo.xfs_efi_item.num_objs
    183556 ± 15%     -40.0%     110053 ± 24%  proc-vmstat.compact_daemon_free_scanned
      1164 ± 17%     -56.0%     512.00 ± 38%  proc-vmstat.compact_daemon_wake
    178173 ± 14%     -36.5%     113212 ± 16%  proc-vmstat.compact_isolated
    768.25 ± 12%     -43.2%     436.25 ± 15%  proc-vmstat.kswapd_high_wmark_hit_quickly
      1242 ± 18%     -55.8%     548.75 ± 25%  proc-vmstat.kswapd_low_wmark_hit_quickly
      2073            +9.6%       2272        proc-vmstat.nr_active_anon
  67108825           -17.5%   55358412        proc-vmstat.nr_dirtied
  34429046           -13.1%   29922129        proc-vmstat.nr_file_pages
  14133405           +32.0%   18660812        proc-vmstat.nr_free_pages
  33887409           -13.3%   29379656        proc-vmstat.nr_inactive_file
    299680            -7.2%     277963        proc-vmstat.nr_slab_unreclaimable
      4828 ±  4%     -88.7%     546.75 ±  5%  proc-vmstat.nr_writeback
  59368449           -20.8%   47001378        proc-vmstat.nr_written
      2073            +9.6%       2272        proc-vmstat.nr_zone_active_anon
  33887718           -13.3%   29379826        proc-vmstat.nr_zone_inactive_file
  20453611 ±  9%     -18.6%   16639765 ± 10%  proc-vmstat.numa_foreign
  49075650 ±  3%     -16.2%   41121350 ±  5%  proc-vmstat.numa_hit
  48981929 ±  3%     -16.2%   41027625 ±  5%  proc-vmstat.numa_local
  20453611 ±  9%     -18.6%   16639765 ± 10%  proc-vmstat.numa_miss
  20547332 ±  9%     -18.6%   16733490 ± 10%  proc-vmstat.numa_other
      2371 ±  8%     -51.0%       1161 ±  8%  proc-vmstat.pageoutrun
  75679865           -15.3%   64118824        proc-vmstat.pgalloc_normal
   1556864           +10.8%    1724803        proc-vmstat.pgfault
  27733269           -38.9%   16947822 ±  3%  proc-vmstat.pgfree
     90755 ± 13%     -35.4%      58642 ± 15%  proc-vmstat.pgmigrate_success
 2.404e+08           -20.7%  1.906e+08        proc-vmstat.pgpgout
     56870           +16.6%      66312        proc-vmstat.pgreuse
  19170054           -56.4%    8359591        proc-vmstat.pgscan_file
  19170054           -56.4%    8359591        proc-vmstat.pgscan_kswapd
  19170022           -56.4%    8359567        proc-vmstat.pgsteal_file
  19170022           -56.4%    8359567        proc-vmstat.pgsteal_kswapd
    166406 ±  8%     -45.0%      91531 ± 33%  proc-vmstat.slabs_scanned
     45.86 ± 34%    +181.8%     129.26 ± 13%  sched_debug.cfs_rq:/.load_avg.avg
      2084 ± 61%    +101.1%       4192 ± 17%  sched_debug.cfs_rq:/.load_avg.max
    228.76 ± 54%    +113.4%     488.17 ± 15%  sched_debug.cfs_rq:/.load_avg.stddev
      0.05 ±  8%     -24.0%       0.04 ± 14%  sched_debug.cfs_rq:/.nr_running.avg
      0.22 ±  3%     -10.7%       0.19 ±  8%  sched_debug.cfs_rq:/.nr_running.stddev
     59.93 ±  3%     -26.4%      44.09 ±  9%  sched_debug.cfs_rq:/.runnable_avg.avg
    967.61 ±  9%     -27.3%     703.21 ±  3%  sched_debug.cfs_rq:/.runnable_avg.max
    151.63 ±  7%     -24.6%     114.37 ±  7%  sched_debug.cfs_rq:/.runnable_avg.stddev
     17842 ± 96%    +169.4%      48067 ± 34%  sched_debug.cfs_rq:/.spread0.max
     59.77 ±  3%     -28.2%      42.91 ±  9%  sched_debug.cfs_rq:/.util_avg.avg
    966.71 ±  9%     -28.5%     691.08 ±  2%  sched_debug.cfs_rq:/.util_avg.max
    151.34 ±  7%     -27.8%     109.22 ±  6%  sched_debug.cfs_rq:/.util_avg.stddev
     13.27 ± 13%     -58.4%       5.52 ± 27%  sched_debug.cfs_rq:/.util_est_enqueued.avg
    768.17 ±  9%     -49.2%     389.92 ± 20%  sched_debug.cfs_rq:/.util_est_enqueued.max
     88.39 ±  9%     -54.0%      40.68 ± 22%  sched_debug.cfs_rq:/.util_est_enqueued.stddev
     39884 ± 51%     -86.8%       5276 ± 39%  sched_debug.cpu.avg_idle.min
    197646 ± 12%     +52.6%     301694 ±  5%  sched_debug.cpu.avg_idle.stddev
    145476 ± 10%     +30.6%     189963        sched_debug.cpu.clock.avg
    145491 ± 10%     +30.6%     189978        sched_debug.cpu.clock.max
    145461 ± 10%     +30.6%     189950        sched_debug.cpu.clock.min
    143795 ± 10%     +30.5%     187634        sched_debug.cpu.clock_task.avg
    144737 ± 10%     +30.4%     188805        sched_debug.cpu.clock_task.max
    136580 ± 10%     +32.0%     180288        sched_debug.cpu.clock_task.min
      7064 ±  7%     +20.3%       8499        sched_debug.cpu.curr->pid.max
      0.00 ± 49%     -43.7%       0.00 ±  4%  sched_debug.cpu.next_balance.stddev
      0.03 ±  2%     -15.5%       0.03 ± 11%  sched_debug.cpu.nr_running.avg
      9449 ±  7%   +2186.6%     216066        sched_debug.cpu.nr_switches.avg
     48468 ± 16%   +3290.8%    1643455 ±  3%  sched_debug.cpu.nr_switches.max
      1144 ± 14%     +28.6%       1471 ±  3%  sched_debug.cpu.nr_switches.min
      9828 ±  8%   +4156.6%     418353        sched_debug.cpu.nr_switches.stddev
    -28.69          +314.2%    -118.83        sched_debug.cpu.nr_uninterruptible.min
     16.51 ±  2%     +84.0%      30.38 ±  9%  sched_debug.cpu.nr_uninterruptible.stddev
      7861 ±  9%   +2639.8%     215396        sched_debug.cpu.sched_count.avg
     45309 ± 16%   +3537.5%    1648138 ±  3%  sched_debug.cpu.sched_count.max
    405.62 ± 14%     +39.8%     567.08        sched_debug.cpu.sched_count.min
      9538 ±  9%   +4305.9%     420274        sched_debug.cpu.sched_count.stddev
      3194 ±  9%   +2430.1%      80819        sched_debug.cpu.sched_goidle.avg
     22591 ± 16%   +2931.8%     684944 ±  2%  sched_debug.cpu.sched_goidle.max
    150.03 ± 13%     +38.5%     207.79        sched_debug.cpu.sched_goidle.min
      4250 ± 10%   +3787.0%     165209        sched_debug.cpu.sched_goidle.stddev
      4451 ±  8%   +2675.1%     123520        sched_debug.cpu.ttwu_count.avg
     52506 ±  8%   +2032.0%    1119423 ±  4%  sched_debug.cpu.ttwu_count.max
    141.88 ± 14%     +40.3%     199.08        sched_debug.cpu.ttwu_count.min
      9369 ±  5%   +2656.8%     258303        sched_debug.cpu.ttwu_count.stddev
      2233 ± 10%   +1279.5%      30807        sched_debug.cpu.ttwu_local.avg
     20049 ±  6%   +1200.9%     260826 ±  3%  sched_debug.cpu.ttwu_local.max
    139.15 ± 14%     +41.1%     196.33        sched_debug.cpu.ttwu_local.min
      3680 ±  5%   +1596.4%      62439        sched_debug.cpu.ttwu_local.stddev
    145462 ± 10%     +30.6%     189951        sched_debug.cpu_clk
    144588 ± 10%     +30.8%     189077        sched_debug.ktime
    145825 ± 10%     +30.5%     190314        sched_debug.sched_clk
 2.167e+09           -14.5%  1.852e+09        perf-stat.i.branch-instructions
     31.58 ± 12%      -7.0       24.62        perf-stat.i.cache-miss-rate%
  14614329 ±  2%     -13.8%   12595505        perf-stat.i.cache-misses
     11124 ±  2%   +2404.3%     278598        perf-stat.i.context-switches
      1.64            +8.0%       1.77 ±  2%  perf-stat.i.cpi
 1.802e+10 ±  2%      -9.8%  1.625e+10 ±  2%  perf-stat.i.cpu-cycles
    253.44         +2786.6%       7315 ±  7%  perf-stat.i.cpu-migrations
      1244 ±  2%      +3.5%       1288 ±  2%  perf-stat.i.cycles-between-cache-misses
      0.07 ± 26%      -0.0        0.04 ± 28%  perf-stat.i.dTLB-load-miss-rate%
   2046807 ± 26%     -53.7%     948333 ± 28%  perf-stat.i.dTLB-load-misses
 2.887e+09           -16.4%  2.414e+09        perf-stat.i.dTLB-loads
      0.01 ± 37%      -0.0        0.00 ± 20%  perf-stat.i.dTLB-store-miss-rate%
    115412 ± 37%     -55.6%      51255 ± 20%  perf-stat.i.dTLB-store-misses
 1.449e+09           -11.7%  1.278e+09        perf-stat.i.dTLB-stores
     61.58           -11.5       50.07        perf-stat.i.iTLB-load-miss-rate%
   5301708 ±  4%     +65.5%    8775440        perf-stat.i.iTLB-loads
 1.076e+10           -16.4%  8.998e+09        perf-stat.i.instructions
      1262           -19.3%       1017        perf-stat.i.instructions-per-iTLB-miss
      0.62            -7.9%       0.57 ±  2%  perf-stat.i.ipc
      1094           -15.2%     928.13        perf-stat.i.major-faults
      0.09 ±  2%      -9.8%       0.08 ±  2%  perf-stat.i.metric.GHz
     34.19           -14.5%      29.22        perf-stat.i.metric.M/sec
     70.32 ±  4%      +8.1       78.39 ±  2%  perf-stat.i.node-load-miss-rate%
   1712035 ±  8%     -36.8%    1081998 ±  7%  perf-stat.i.node-loads
     59.44 ± 10%     +11.1       70.55 ±  2%  perf-stat.i.node-store-miss-rate%
    549390 ± 17%     -35.2%     355933 ±  5%  perf-stat.i.node-stores
      4832            -3.6%       4656        perf-stat.i.page-faults
      1.68            +7.8%       1.81 ±  2%  perf-stat.overall.cpi
      1234            +4.6%       1290 ±  2%  perf-stat.overall.cycles-between-cache-misses
      0.07 ± 26%      -0.0        0.04 ± 28%  perf-stat.overall.dTLB-load-miss-rate%
      0.01 ± 37%      -0.0        0.00 ± 20%  perf-stat.overall.dTLB-store-miss-rate%
     62.13           -11.7       50.40        perf-stat.overall.iTLB-load-miss-rate%
      1239           -18.5%       1009        perf-stat.overall.instructions-per-iTLB-miss
      0.60            -7.2%       0.55 ±  2%  perf-stat.overall.ipc
     68.97 ±  4%      +8.1       77.07 ±  2%  perf-stat.overall.node-load-miss-rate%
     41110           +19.2%      49006        perf-stat.overall.path-length
 2.159e+09           -14.5%  1.847e+09        perf-stat.ps.branch-instructions
  14564018 ±  2%     -13.7%   12562224        perf-stat.ps.cache-misses
     11076 ±  2%   +2406.2%     277608        perf-stat.ps.context-switches
 1.797e+10 ±  2%      -9.8%  1.621e+10 ±  2%  perf-stat.ps.cpu-cycles
    252.44         +2787.8%       7289 ±  7%  perf-stat.ps.cpu-migrations
   2038697 ± 26%     -53.6%     945188 ± 28%  perf-stat.ps.dTLB-load-misses
 2.877e+09           -16.3%  2.407e+09        perf-stat.ps.dTLB-loads
    115024 ± 37%     -55.5%      51145 ± 20%  perf-stat.ps.dTLB-store-misses
 1.443e+09           -11.7%  1.275e+09        perf-stat.ps.dTLB-stores
   5280755 ±  4%     +65.6%    8745507        perf-stat.ps.iTLB-loads
 1.072e+10           -16.3%  8.973e+09        perf-stat.ps.instructions
      1094           -14.9%     931.28        perf-stat.ps.major-faults
   1707854 ±  8%     -36.7%    1080972 ±  7%  perf-stat.ps.node-loads
    548040 ± 17%     -35.1%     355596 ±  5%  perf-stat.ps.node-stores
      4818            -3.5%       4647        perf-stat.ps.page-faults
 2.759e+12            -1.6%  2.713e+12        perf-stat.total.instructions
    516.00           +17.4%     606.00        interrupts.9:IO-APIC.9-fasteoi.acpi
    241214 ± 20%    +386.1%    1172555        interrupts.CAL:Function_call_interrupts
      1173 ± 16%   +1030.0%      13255 ± 81%  interrupts.CPU0.CAL:Function_call_interrupts
    514234           +17.7%     605443        interrupts.CPU0.LOC:Local_timer_interrupts
    516.00           +17.4%     606.00        interrupts.CPU1.9:IO-APIC.9-fasteoi.acpi
    512723           +18.1%     605278        interrupts.CPU1.LOC:Local_timer_interrupts
      1416 ± 28%   +1078.1%      16682 ± 84%  interrupts.CPU10.CAL:Function_call_interrupts
    511935           +18.3%     605746        interrupts.CPU10.LOC:Local_timer_interrupts
      1143 ± 20%    +874.2%      11139 ± 83%  interrupts.CPU100.CAL:Function_call_interrupts
    510002           +18.8%     605836        interrupts.CPU100.LOC:Local_timer_interrupts
      1137 ± 20%    +863.0%      10952 ± 74%  interrupts.CPU101.CAL:Function_call_interrupts
    510758           +18.5%     605423        interrupts.CPU101.LOC:Local_timer_interrupts
      1112 ± 20%    +799.2%      10001 ± 82%  interrupts.CPU102.CAL:Function_call_interrupts
    513218           +18.0%     605498        interrupts.CPU102.LOC:Local_timer_interrupts
      1144 ± 20%    +760.0%       9840 ± 71%  interrupts.CPU103.CAL:Function_call_interrupts
    513340           +17.9%     605423        interrupts.CPU103.LOC:Local_timer_interrupts
      1139 ± 18%    +647.4%       8518 ± 75%  interrupts.CPU104.CAL:Function_call_interrupts
    511907           +18.3%     605394        interrupts.CPU104.LOC:Local_timer_interrupts
      1128 ± 20%    +638.4%       8330 ± 55%  interrupts.CPU105.CAL:Function_call_interrupts
    510862           +18.5%     605403        interrupts.CPU105.LOC:Local_timer_interrupts
      1136 ± 21%    +501.6%       6833 ± 54%  interrupts.CPU106.CAL:Function_call_interrupts
    510908           +18.5%     605427        interrupts.CPU106.LOC:Local_timer_interrupts
      1188 ± 21%    +566.4%       7919 ± 59%  interrupts.CPU107.CAL:Function_call_interrupts
    513539           +17.9%     605427        interrupts.CPU107.LOC:Local_timer_interrupts
      1233 ± 23%    +553.6%       8064 ± 63%  interrupts.CPU108.CAL:Function_call_interrupts
    514204           +17.7%     605443        interrupts.CPU108.LOC:Local_timer_interrupts
      1154 ± 18%    +470.9%       6592 ± 74%  interrupts.CPU109.CAL:Function_call_interrupts
    511674           +18.3%     605335        interrupts.CPU109.LOC:Local_timer_interrupts
      1318 ± 22%   +1264.3%      17984 ± 87%  interrupts.CPU11.CAL:Function_call_interrupts
    514818           +17.6%     605440        interrupts.CPU11.LOC:Local_timer_interrupts
      1130 ± 19%    +519.4%       7001 ± 59%  interrupts.CPU110.CAL:Function_call_interrupts
    510713           +18.6%     605450        interrupts.CPU110.LOC:Local_timer_interrupts
      1140 ± 17%    +493.6%       6767 ± 54%  interrupts.CPU111.CAL:Function_call_interrupts
    509610           +18.8%     605511        interrupts.CPU111.LOC:Local_timer_interrupts
      1192 ± 21%    +337.7%       5217 ± 51%  interrupts.CPU112.CAL:Function_call_interrupts
    511076           +18.6%     605947        interrupts.CPU112.LOC:Local_timer_interrupts
     37.00 ± 64%  +12832.4%       4785 ± 95%  interrupts.CPU112.RES:Rescheduling_interrupts
      1131 ± 16%    +322.9%       4784 ± 48%  interrupts.CPU113.CAL:Function_call_interrupts
    509857           +18.9%     606431        interrupts.CPU113.LOC:Local_timer_interrupts
     41.00 ± 57%  +11022.6%       4560 ± 96%  interrupts.CPU113.RES:Rescheduling_interrupts
      1174 ± 24%    +328.4%       5029 ± 45%  interrupts.CPU114.CAL:Function_call_interrupts
    509860           +18.8%     605586        interrupts.CPU114.LOC:Local_timer_interrupts
     46.75 ± 63%   +9096.8%       4299 ± 97%  interrupts.CPU114.RES:Rescheduling_interrupts
      1183 ± 21%    +290.9%       4626 ± 43%  interrupts.CPU115.CAL:Function_call_interrupts
    511295           +18.5%     605739        interrupts.CPU115.LOC:Local_timer_interrupts
     35.75 ± 63%  +10950.3%       3950 ± 94%  interrupts.CPU115.RES:Rescheduling_interrupts
      1195 ± 24%    +275.5%       4489 ± 59%  interrupts.CPU116.CAL:Function_call_interrupts
    509693           +19.1%     607228        interrupts.CPU116.LOC:Local_timer_interrupts
      1208 ± 20%    +290.3%       4716 ± 42%  interrupts.CPU117.CAL:Function_call_interrupts
    510905           +18.5%     605473        interrupts.CPU117.LOC:Local_timer_interrupts
      1136 ± 22%    +338.7%       4986 ± 48%  interrupts.CPU118.CAL:Function_call_interrupts
    509923           +18.7%     605494        interrupts.CPU118.LOC:Local_timer_interrupts
     33.75 ± 74%  +12737.0%       4332 ± 98%  interrupts.CPU118.RES:Rescheduling_interrupts
      1153 ± 20%    +365.1%       5366 ± 45%  interrupts.CPU119.CAL:Function_call_interrupts
    511178           +18.5%     605596        interrupts.CPU119.LOC:Local_timer_interrupts
      1274 ± 22%   +1407.0%      19210 ± 86%  interrupts.CPU12.CAL:Function_call_interrupts
    514753           +17.6%     605484        interrupts.CPU12.LOC:Local_timer_interrupts
    513843           +17.8%     605343        interrupts.CPU120.LOC:Local_timer_interrupts
    515081           +17.5%     605238        interrupts.CPU121.LOC:Local_timer_interrupts
    515027           +17.5%     605302        interrupts.CPU122.LOC:Local_timer_interrupts
    514802           +17.6%     605242        interrupts.CPU123.LOC:Local_timer_interrupts
    513728           +17.8%     605344        interrupts.CPU124.LOC:Local_timer_interrupts
    514733           +17.6%     605280        interrupts.CPU125.LOC:Local_timer_interrupts
    513881           +17.8%     605350        interrupts.CPU126.LOC:Local_timer_interrupts
    513886           +17.8%     605117        interrupts.CPU127.LOC:Local_timer_interrupts
    513632           +17.8%     605303        interrupts.CPU128.LOC:Local_timer_interrupts
    206.75 ± 34%     -45.5%     112.75 ± 34%  interrupts.CPU128.NMI:Non-maskable_interrupts
    206.75 ± 34%     -45.5%     112.75 ± 34%  interrupts.CPU128.PMI:Performance_monitoring_interrupts
    513642           +17.8%     605091        interrupts.CPU129.LOC:Local_timer_interrupts
      1196 ± 19%   +1408.7%      18047 ± 83%  interrupts.CPU13.CAL:Function_call_interrupts
    512136           +18.2%     605406        interrupts.CPU13.LOC:Local_timer_interrupts
    513792           +17.8%     605254        interrupts.CPU130.LOC:Local_timer_interrupts
    513659           +17.8%     605248        interrupts.CPU131.LOC:Local_timer_interrupts
    513651           +17.8%     605254        interrupts.CPU132.LOC:Local_timer_interrupts
    514585           +17.6%     605369        interrupts.CPU133.LOC:Local_timer_interrupts
    513797           +17.9%     605557        interrupts.CPU134.LOC:Local_timer_interrupts
    513767           +17.8%     605135        interrupts.CPU135.LOC:Local_timer_interrupts
    514328           +17.7%     605254        interrupts.CPU136.LOC:Local_timer_interrupts
      1177 ± 22%     +94.6%       2290 ± 30%  interrupts.CPU137.CAL:Function_call_interrupts
    513855           +17.9%     605641        interrupts.CPU137.LOC:Local_timer_interrupts
      3.00 ± 81%   +7733.3%     235.00 ±168%  interrupts.CPU137.RES:Rescheduling_interrupts
    513480           +17.9%     605256        interrupts.CPU138.LOC:Local_timer_interrupts
    513887           +17.8%     605283        interrupts.CPU139.LOC:Local_timer_interrupts
      1196 ± 18%   +1461.2%      18672 ± 88%  interrupts.CPU14.CAL:Function_call_interrupts
    511309           +18.4%     605432        interrupts.CPU14.LOC:Local_timer_interrupts
    513628           +17.8%     605234        interrupts.CPU140.LOC:Local_timer_interrupts
    513663           +17.8%     605266        interrupts.CPU141.LOC:Local_timer_interrupts
    513516           +17.9%     605500        interrupts.CPU142.LOC:Local_timer_interrupts
    514605           +17.7%     605624        interrupts.CPU143.LOC:Local_timer_interrupts
    514859           +17.6%     605583        interrupts.CPU144.LOC:Local_timer_interrupts
      1208 ± 23%    +802.6%      10905 ± 82%  interrupts.CPU145.CAL:Function_call_interrupts
    513118           +18.0%     605359        interrupts.CPU145.LOC:Local_timer_interrupts
    515103           +17.5%     605500        interrupts.CPU146.LOC:Local_timer_interrupts
    512407           +18.1%     605372        interrupts.CPU147.LOC:Local_timer_interrupts
    513393           +17.9%     605483        interrupts.CPU148.LOC:Local_timer_interrupts
    514296           +17.7%     605316        interrupts.CPU149.LOC:Local_timer_interrupts
      1216 ± 20%   +1147.0%      15166 ± 90%  interrupts.CPU15.CAL:Function_call_interrupts
    510385           +18.6%     605419        interrupts.CPU15.LOC:Local_timer_interrupts
    511128           +18.4%     605408        interrupts.CPU150.LOC:Local_timer_interrupts
    511504           +18.3%     605269        interrupts.CPU151.LOC:Local_timer_interrupts
    114.25 ± 11%    +339.4%     502.00 ± 77%  interrupts.CPU151.NMI:Non-maskable_interrupts
    114.25 ± 11%    +339.4%     502.00 ± 77%  interrupts.CPU151.PMI:Performance_monitoring_interrupts
    511130           +18.4%     605391        interrupts.CPU152.LOC:Local_timer_interrupts
    510699           +18.5%     605383        interrupts.CPU153.LOC:Local_timer_interrupts
    511113           +18.5%     605428        interrupts.CPU154.LOC:Local_timer_interrupts
     17.75 ±143%    +1e+06%     180613 ±101%  interrupts.CPU154.RES:Rescheduling_interrupts
    511706           +18.3%     605328        interrupts.CPU155.LOC:Local_timer_interrupts
    512493           +18.1%     605464        interrupts.CPU156.LOC:Local_timer_interrupts
    511511           +18.3%     605357        interrupts.CPU157.LOC:Local_timer_interrupts
      1182 ± 19%    +449.2%       6496 ± 81%  interrupts.CPU158.CAL:Function_call_interrupts
    512833           +18.0%     605345        interrupts.CPU158.LOC:Local_timer_interrupts
      1164 ± 20%    +406.7%       5899 ± 78%  interrupts.CPU159.CAL:Function_call_interrupts
    511132           +18.4%     605336        interrupts.CPU159.LOC:Local_timer_interrupts
    513120           +18.1%     605836        interrupts.CPU16.LOC:Local_timer_interrupts
      1186 ± 19%    +295.6%       4694 ± 68%  interrupts.CPU160.CAL:Function_call_interrupts
    511530           +18.3%     605359        interrupts.CPU160.LOC:Local_timer_interrupts
    510929           +18.6%     605714        interrupts.CPU161.LOC:Local_timer_interrupts
    510784           +18.6%     605596        interrupts.CPU162.LOC:Local_timer_interrupts
    511100           +18.5%     605424        interrupts.CPU163.LOC:Local_timer_interrupts
      1.25 ±103%  +3.4e+05%       4219 ±104%  interrupts.CPU163.RES:Rescheduling_interrupts
      1173 ± 18%    +279.7%       4453 ± 62%  interrupts.CPU164.CAL:Function_call_interrupts
    510706           +18.5%     605389        interrupts.CPU164.LOC:Local_timer_interrupts
      1.75 ± 24%  +2.7e+05%       4804 ± 99%  interrupts.CPU164.RES:Rescheduling_interrupts
      1214 ± 23%    +249.3%       4241 ± 67%  interrupts.CPU165.CAL:Function_call_interrupts
    510738           +18.6%     605932        interrupts.CPU165.LOC:Local_timer_interrupts
     91.00 ± 23%    +178.0%     253.00 ± 54%  interrupts.CPU165.NMI:Non-maskable_interrupts
     91.00 ± 23%    +178.0%     253.00 ± 54%  interrupts.CPU165.PMI:Performance_monitoring_interrupts
      6.75 ± 63%  +69411.1%       4692 ±102%  interrupts.CPU165.RES:Rescheduling_interrupts
      1209 ± 18%    +218.9%       3856 ± 62%  interrupts.CPU166.CAL:Function_call_interrupts
    510778           +18.6%     605622        interrupts.CPU166.LOC:Local_timer_interrupts
     90.00 ± 24%    +114.2%     192.75 ± 35%  interrupts.CPU166.NMI:Non-maskable_interrupts
     90.00 ± 24%    +114.2%     192.75 ± 35%  interrupts.CPU166.PMI:Performance_monitoring_interrupts
      1177 ± 18%    +309.5%       4820 ± 52%  interrupts.CPU167.CAL:Function_call_interrupts
    511077           +18.5%     605666        interrupts.CPU167.LOC:Local_timer_interrupts
     90.25 ± 24%    +216.3%     285.50 ± 19%  interrupts.CPU167.NMI:Non-maskable_interrupts
     90.25 ± 24%    +216.3%     285.50 ± 19%  interrupts.CPU167.PMI:Performance_monitoring_interrupts
      2.25 ± 72%    +2e+05%       4486 ± 99%  interrupts.CPU167.RES:Rescheduling_interrupts
      1262 ± 25%     +54.7%       1953 ± 27%  interrupts.CPU168.CAL:Function_call_interrupts
    516016           +17.3%     605276        interrupts.CPU168.LOC:Local_timer_interrupts
    515960           +17.3%     605469        interrupts.CPU169.LOC:Local_timer_interrupts
    434.75 ± 59%     -62.9%     161.50 ± 30%  interrupts.CPU169.NMI:Non-maskable_interrupts
    434.75 ± 59%     -62.9%     161.50 ± 30%  interrupts.CPU169.PMI:Performance_monitoring_interrupts
      1104 ± 22%    +528.0%       6934 ± 62%  interrupts.CPU17.CAL:Function_call_interrupts
    510328           +18.7%     605554        interrupts.CPU17.LOC:Local_timer_interrupts
      1246 ± 34%     +68.1%       2095 ± 39%  interrupts.CPU170.CAL:Function_call_interrupts
    516201           +17.3%     605483        interrupts.CPU170.LOC:Local_timer_interrupts
    334.75 ± 29%     -36.1%     213.75 ± 21%  interrupts.CPU170.NMI:Non-maskable_interrupts
    334.75 ± 29%     -36.1%     213.75 ± 21%  interrupts.CPU170.PMI:Performance_monitoring_interrupts
    516089           +17.3%     605414        interrupts.CPU171.LOC:Local_timer_interrupts
    340.00 ± 42%     -56.5%     148.00 ± 21%  interrupts.CPU171.NMI:Non-maskable_interrupts
    340.00 ± 42%     -56.5%     148.00 ± 21%  interrupts.CPU171.PMI:Performance_monitoring_interrupts
    515928           +17.4%     605456        interrupts.CPU172.LOC:Local_timer_interrupts
    515944           +17.3%     605313        interrupts.CPU173.LOC:Local_timer_interrupts
    515836           +17.4%     605365        interrupts.CPU174.LOC:Local_timer_interrupts
    304.25 ±100%     -62.9%     113.00 ±  8%  interrupts.CPU174.NMI:Non-maskable_interrupts
    304.25 ±100%     -62.9%     113.00 ±  8%  interrupts.CPU174.PMI:Performance_monitoring_interrupts
    515935           +17.3%     605235        interrupts.CPU175.LOC:Local_timer_interrupts
    515566           +17.4%     605490        interrupts.CPU176.LOC:Local_timer_interrupts
    515944           +17.3%     605365        interrupts.CPU177.LOC:Local_timer_interrupts
    515917           +17.4%     605465        interrupts.CPU178.LOC:Local_timer_interrupts
    515918           +17.3%     605298        interrupts.CPU179.LOC:Local_timer_interrupts
      1125 ± 21%    +455.4%       6248 ± 71%  interrupts.CPU18.CAL:Function_call_interrupts
    510435           +18.6%     605489        interrupts.CPU18.LOC:Local_timer_interrupts
    515832           +17.4%     605421        interrupts.CPU180.LOC:Local_timer_interrupts
    515886           +17.3%     605369        interrupts.CPU181.LOC:Local_timer_interrupts
    515913           +17.3%     605307        interrupts.CPU182.LOC:Local_timer_interrupts
    515907           +17.3%     605391        interrupts.CPU183.LOC:Local_timer_interrupts
    515873           +17.3%     605289        interrupts.CPU184.LOC:Local_timer_interrupts
    516177           +17.3%     605345        interrupts.CPU185.LOC:Local_timer_interrupts
      1321 ±  9%     +56.9%       2073 ± 33%  interrupts.CPU186.CAL:Function_call_interrupts
    515709           +17.4%     605398        interrupts.CPU186.LOC:Local_timer_interrupts
      1161 ± 19%     +25.2%       1453 ±  8%  interrupts.CPU187.CAL:Function_call_interrupts
    515995           +17.3%     605284        interrupts.CPU187.LOC:Local_timer_interrupts
    515996           +17.3%     605298        interrupts.CPU188.LOC:Local_timer_interrupts
    515899           +17.3%     605298        interrupts.CPU189.LOC:Local_timer_interrupts
    510586           +18.6%     605784        interrupts.CPU19.LOC:Local_timer_interrupts
    515909           +17.3%     605357        interrupts.CPU190.LOC:Local_timer_interrupts
      1248 ± 29%     +34.1%       1674 ±  7%  interrupts.CPU191.CAL:Function_call_interrupts
    515902           +17.3%     605378        interrupts.CPU191.LOC:Local_timer_interrupts
      1299 ± 21%   +1166.8%      16458 ± 80%  interrupts.CPU2.CAL:Function_call_interrupts
    511817           +18.3%     605535        interrupts.CPU2.LOC:Local_timer_interrupts
      1134 ± 20%    +419.2%       5891 ± 72%  interrupts.CPU20.CAL:Function_call_interrupts
    509831           +18.8%     605434        interrupts.CPU20.LOC:Local_timer_interrupts
      1134 ± 22%    +413.0%       5817 ± 69%  interrupts.CPU21.CAL:Function_call_interrupts
    510416           +18.7%     605698        interrupts.CPU21.LOC:Local_timer_interrupts
      1114 ± 23%    +413.3%       5720 ± 77%  interrupts.CPU22.CAL:Function_call_interrupts
    509905           +18.7%     605450        interrupts.CPU22.LOC:Local_timer_interrupts
      1176 ± 19%    +455.9%       6540 ± 77%  interrupts.CPU23.CAL:Function_call_interrupts
    510208           +18.8%     606161        interrupts.CPU23.LOC:Local_timer_interrupts
      1535 ± 10%     +78.2%       2735 ± 16%  interrupts.CPU24.CAL:Function_call_interrupts
    513859           +17.9%     605713        interrupts.CPU24.LOC:Local_timer_interrupts
    654.75 ± 28%     -71.4%     187.25 ±  7%  interrupts.CPU24.NMI:Non-maskable_interrupts
    654.75 ± 28%     -71.4%     187.25 ±  7%  interrupts.CPU24.PMI:Performance_monitoring_interrupts
      1368 ± 14%    +114.9%       2939 ± 32%  interrupts.CPU25.CAL:Function_call_interrupts
    515715           +17.5%     605936        interrupts.CPU25.LOC:Local_timer_interrupts
    619.50 ± 45%     -58.3%     258.50 ± 41%  interrupts.CPU25.NMI:Non-maskable_interrupts
    619.50 ± 45%     -58.3%     258.50 ± 41%  interrupts.CPU25.PMI:Performance_monitoring_interrupts
    515285           +17.5%     605484        interrupts.CPU26.LOC:Local_timer_interrupts
    514892           +17.6%     605366        interrupts.CPU27.LOC:Local_timer_interrupts
      1157 ± 23%     +66.9%       1931 ± 25%  interrupts.CPU28.CAL:Function_call_interrupts
    513790           +17.8%     605384        interrupts.CPU28.LOC:Local_timer_interrupts
    514833           +17.6%     605296        interrupts.CPU29.LOC:Local_timer_interrupts
      1215 ± 21%   +1322.8%      17287 ± 86%  interrupts.CPU3.CAL:Function_call_interrupts
    510059           +18.7%     605325        interrupts.CPU3.LOC:Local_timer_interrupts
    513997           +17.8%     605397        interrupts.CPU30.LOC:Local_timer_interrupts
    513960           +17.8%     605444        interrupts.CPU31.LOC:Local_timer_interrupts
    513717           +17.9%     605420        interrupts.CPU32.LOC:Local_timer_interrupts
      1289 ± 19%     +49.0%       1920 ± 13%  interrupts.CPU33.CAL:Function_call_interrupts
    513745           +17.9%     605929        interrupts.CPU33.LOC:Local_timer_interrupts
      1152 ± 17%     +91.7%       2208 ± 43%  interrupts.CPU34.CAL:Function_call_interrupts
    513887           +17.9%     605779        interrupts.CPU34.LOC:Local_timer_interrupts
      1135 ± 24%     +53.6%       1744 ± 28%  interrupts.CPU35.CAL:Function_call_interrupts
    513694           +17.8%     605333        interrupts.CPU35.LOC:Local_timer_interrupts
    513746           +18.0%     606055        interrupts.CPU36.LOC:Local_timer_interrupts
    514657           +17.6%     605387        interrupts.CPU37.LOC:Local_timer_interrupts
    513887           +17.8%     605533        interrupts.CPU38.LOC:Local_timer_interrupts
    513874           +17.8%     605393        interrupts.CPU39.LOC:Local_timer_interrupts
      1186 ± 19%   +1467.5%      18598 ± 87%  interrupts.CPU4.CAL:Function_call_interrupts
    510575           +18.6%     605409        interrupts.CPU4.LOC:Local_timer_interrupts
    514437           +17.7%     605399        interrupts.CPU40.LOC:Local_timer_interrupts
    513922           +17.8%     605488        interrupts.CPU41.LOC:Local_timer_interrupts
    513643           +17.9%     605362        interrupts.CPU42.LOC:Local_timer_interrupts
    514155           +17.8%     605708        interrupts.CPU43.LOC:Local_timer_interrupts
      1097 ± 24%     +91.0%       2096 ± 32%  interrupts.CPU44.CAL:Function_call_interrupts
    513654           +18.0%     606048        interrupts.CPU44.LOC:Local_timer_interrupts
    513702           +17.9%     605573        interrupts.CPU45.LOC:Local_timer_interrupts
    513557           +17.9%     605360        interrupts.CPU46.LOC:Local_timer_interrupts
    514556           +17.7%     605738        interrupts.CPU47.LOC:Local_timer_interrupts
      1699 ± 36%    +759.3%      14598 ± 79%  interrupts.CPU48.CAL:Function_call_interrupts
    514869           +17.6%     605464        interrupts.CPU48.LOC:Local_timer_interrupts
      1343 ± 14%   +1160.3%      16932 ± 86%  interrupts.CPU49.CAL:Function_call_interrupts
    513305           +18.0%     605464        interrupts.CPU49.LOC:Local_timer_interrupts
      1227 ± 19%   +1401.3%      18432 ± 89%  interrupts.CPU5.CAL:Function_call_interrupts
    510871           +18.5%     605627        interrupts.CPU5.LOC:Local_timer_interrupts
    515088           +17.5%     605376        interrupts.CPU50.LOC:Local_timer_interrupts
      1204 ± 17%   +1405.3%      18127 ± 92%  interrupts.CPU51.CAL:Function_call_interrupts
    512351           +18.2%     605549        interrupts.CPU51.LOC:Local_timer_interrupts
    513855           +17.8%     605391        interrupts.CPU52.LOC:Local_timer_interrupts
    514932           +17.6%     605560        interrupts.CPU53.LOC:Local_timer_interrupts
    511184           +18.5%     605528        interrupts.CPU54.LOC:Local_timer_interrupts
      1153 ± 16%   +1670.5%      20423 ± 93%  interrupts.CPU55.CAL:Function_call_interrupts
    511641           +18.3%     605473        interrupts.CPU55.LOC:Local_timer_interrupts
    511233           +18.5%     605581        interrupts.CPU56.LOC:Local_timer_interrupts
    107.75 ± 11%    +300.2%     431.25 ± 60%  interrupts.CPU56.NMI:Non-maskable_interrupts
    107.75 ± 11%    +300.2%     431.25 ± 60%  interrupts.CPU56.PMI:Performance_monitoring_interrupts
     61.50 ±164%  +11461.4%       7110 ± 99%  interrupts.CPU56.RES:Rescheduling_interrupts
      1107 ± 23%   +1664.4%      19541 ± 91%  interrupts.CPU57.CAL:Function_call_interrupts
    510795           +18.6%     605563        interrupts.CPU57.LOC:Local_timer_interrupts
      3.25 ± 50%  +2.2e+05%       7281 ± 99%  interrupts.CPU57.RES:Rescheduling_interrupts
      1119 ± 23%   +1660.7%      19710 ± 91%  interrupts.CPU58.CAL:Function_call_interrupts
    511234           +18.5%     605882        interrupts.CPU58.LOC:Local_timer_interrupts
      5.25 ± 51%  +1.4e+05%       7342 ±100%  interrupts.CPU58.RES:Rescheduling_interrupts
      1117 ± 21%   +1541.4%      18342 ± 92%  interrupts.CPU59.CAL:Function_call_interrupts
    511755           +18.4%     605662        interrupts.CPU59.LOC:Local_timer_interrupts
      1283 ± 23%   +1341.6%      18502 ± 80%  interrupts.CPU6.CAL:Function_call_interrupts
    513323           +18.0%     605537        interrupts.CPU6.LOC:Local_timer_interrupts
    512545           +18.1%     605561        interrupts.CPU60.LOC:Local_timer_interrupts
      1135 ± 18%   +1505.6%      18228 ± 93%  interrupts.CPU61.CAL:Function_call_interrupts
    511576           +18.3%     605425        interrupts.CPU61.LOC:Local_timer_interrupts
      1414 ± 25%   +1110.5%      17119 ± 91%  interrupts.CPU62.CAL:Function_call_interrupts
    512827           +18.1%     605436        interrupts.CPU62.LOC:Local_timer_interrupts
      1126 ± 21%   +1188.2%      14514 ± 90%  interrupts.CPU63.CAL:Function_call_interrupts
    511174           +18.5%     605588        interrupts.CPU63.LOC:Local_timer_interrupts
      1130 ± 22%    +294.1%       4456 ± 71%  interrupts.CPU64.CAL:Function_call_interrupts
    511557           +18.4%     605728        interrupts.CPU64.LOC:Local_timer_interrupts
    510978           +18.6%     605824        interrupts.CPU65.LOC:Local_timer_interrupts
    510755           +18.6%     605917        interrupts.CPU66.LOC:Local_timer_interrupts
      2.25 ±101%  +2.8e+05%       6412 ±100%  interrupts.CPU66.RES:Rescheduling_interrupts
    511092           +18.5%     605580        interrupts.CPU67.LOC:Local_timer_interrupts
      1147 ± 18%    +389.3%       5613 ± 68%  interrupts.CPU68.CAL:Function_call_interrupts
    510789           +18.5%     605511        interrupts.CPU68.LOC:Local_timer_interrupts
      2.75 ±107%  +2.5e+05%       6913 ±100%  interrupts.CPU68.RES:Rescheduling_interrupts
    510770           +18.6%     605649        interrupts.CPU69.LOC:Local_timer_interrupts
      1271 ± 21%   +1246.2%      17116 ± 87%  interrupts.CPU7.CAL:Function_call_interrupts
    513454           +17.9%     605531        interrupts.CPU7.LOC:Local_timer_interrupts
    516.25 ± 44%     -55.2%     231.25 ± 42%  interrupts.CPU7.NMI:Non-maskable_interrupts
    516.25 ± 44%     -55.2%     231.25 ± 42%  interrupts.CPU7.PMI:Performance_monitoring_interrupts
    510835           +18.6%     606082        interrupts.CPU70.LOC:Local_timer_interrupts
      1120 ± 21%    +392.4%       5518 ± 61%  interrupts.CPU71.CAL:Function_call_interrupts
    511083           +18.5%     605658        interrupts.CPU71.LOC:Local_timer_interrupts
      2.25 ± 96%  +2.7e+05%       6041 ±100%  interrupts.CPU71.RES:Rescheduling_interrupts
      1325 ± 26%    +142.0%       3207 ± 11%  interrupts.CPU72.CAL:Function_call_interrupts
    515998           +17.3%     605229        interrupts.CPU72.LOC:Local_timer_interrupts
      1280 ± 24%     +69.5%       2171 ± 16%  interrupts.CPU73.CAL:Function_call_interrupts
    516149           +17.3%     605586        interrupts.CPU73.LOC:Local_timer_interrupts
    498.50 ± 49%     -60.9%     194.75 ± 40%  interrupts.CPU73.NMI:Non-maskable_interrupts
    498.50 ± 49%     -60.9%     194.75 ± 40%  interrupts.CPU73.PMI:Performance_monitoring_interrupts
      1383 ± 39%     +63.0%       2255 ± 23%  interrupts.CPU74.CAL:Function_call_interrupts
    516376           +17.2%     605343        interrupts.CPU74.LOC:Local_timer_interrupts
    516271           +17.3%     605661        interrupts.CPU75.LOC:Local_timer_interrupts
    516310           +17.3%     605650        interrupts.CPU76.LOC:Local_timer_interrupts
    516172           +17.3%     605330        interrupts.CPU77.LOC:Local_timer_interrupts
    515955           +17.4%     605572        interrupts.CPU78.LOC:Local_timer_interrupts
    515907           +17.4%     605833        interrupts.CPU79.LOC:Local_timer_interrupts
      1220 ± 17%   +1376.1%      18019 ± 87%  interrupts.CPU8.CAL:Function_call_interrupts
    512148           +18.3%     605670        interrupts.CPU8.LOC:Local_timer_interrupts
    515903           +17.3%     605409        interrupts.CPU80.LOC:Local_timer_interrupts
    515934           +17.3%     605309        interrupts.CPU81.LOC:Local_timer_interrupts
    515929           +17.5%     606412        interrupts.CPU82.LOC:Local_timer_interrupts
    516037           +17.4%     606044        interrupts.CPU83.LOC:Local_timer_interrupts
    515996           +17.4%     605807        interrupts.CPU84.LOC:Local_timer_interrupts
    515950           +17.4%     605519        interrupts.CPU85.LOC:Local_timer_interrupts
    516261           +17.3%     605483        interrupts.CPU86.LOC:Local_timer_interrupts
    516222           +17.3%     605533        interrupts.CPU87.LOC:Local_timer_interrupts
    516245           +17.3%     605439        interrupts.CPU88.LOC:Local_timer_interrupts
    516333           +17.4%     606092        interrupts.CPU89.LOC:Local_timer_interrupts
    313.50 ± 39%     -69.5%      95.75 ± 25%  interrupts.CPU89.NMI:Non-maskable_interrupts
    313.50 ± 39%     -69.5%      95.75 ± 25%  interrupts.CPU89.PMI:Performance_monitoring_interrupts
    511049           +18.5%     605658        interrupts.CPU9.LOC:Local_timer_interrupts
    516502           +17.2%     605354        interrupts.CPU90.LOC:Local_timer_interrupts
    516464           +17.3%     605747        interrupts.CPU91.LOC:Local_timer_interrupts
    516253           +17.4%     606137        interrupts.CPU92.LOC:Local_timer_interrupts
    516158           +17.3%     605298        interrupts.CPU93.LOC:Local_timer_interrupts
    515995           +17.4%     605674        interrupts.CPU94.LOC:Local_timer_interrupts
    516304           +17.2%     605311        interrupts.CPU95.LOC:Local_timer_interrupts
    513802           +17.8%     605397        interrupts.CPU96.LOC:Local_timer_interrupts
    512011           +18.2%     605447        interrupts.CPU97.LOC:Local_timer_interrupts
    511607           +18.3%     605448        interrupts.CPU98.LOC:Local_timer_interrupts
    509867           +18.7%     605442        interrupts.CPU99.LOC:Local_timer_interrupts
  98572095           +17.9%  1.163e+08        interrupts.LOC:Local_timer_interrupts
      0.00       +1.9e+104%     192.00        interrupts.MCP:Machine_check_polls
     18832 ±  4%  +28724.8%    5428424 ±  3%  interrupts.RES:Rescheduling_interrupts
     24593 ± 14%    +103.8%      50109 ±  2%  softirqs.CPU0.RCU
     20767 ±  7%    +119.9%      45671 ±  5%  softirqs.CPU1.RCU
     21282 ± 46%     +60.4%      34135 ± 18%  softirqs.CPU1.SCHED
     21727 ±  7%    +115.9%      46904 ±  7%  softirqs.CPU10.RCU
     19127 ± 15%    +133.1%      44585 ±  4%  softirqs.CPU100.RCU
     32966 ±  4%     +15.6%      38122 ±  6%  softirqs.CPU100.SCHED
     19577 ± 15%    +131.0%      45223 ±  2%  softirqs.CPU101.RCU
     27027 ± 31%     +48.0%      40011 ±  2%  softirqs.CPU101.SCHED
     20058 ± 13%    +121.1%      44343 ±  4%  softirqs.CPU102.RCU
     19259 ± 13%    +132.0%      44674 ±  3%  softirqs.CPU103.RCU
     19621 ± 14%    +130.5%      45232 ±  3%  softirqs.CPU104.RCU
     18948 ± 17%    +137.8%      45063 ±  3%  softirqs.CPU105.RCU
     33071 ±  4%     +16.4%      38506 ±  6%  softirqs.CPU105.SCHED
     19429 ± 16%    +127.5%      44201 ±  2%  softirqs.CPU106.RCU
     29852 ± 20%     +29.3%      38611 ±  5%  softirqs.CPU106.SCHED
     19791 ± 12%    +131.1%      45743        softirqs.CPU107.RCU
     32969 ±  4%     +18.2%      38982 ±  6%  softirqs.CPU107.SCHED
     19517 ± 16%    +132.4%      45355        softirqs.CPU108.RCU
     32768 ±  5%     +15.5%      37857 ±  8%  softirqs.CPU108.SCHED
     19232 ± 15%    +132.6%      44727 ±  3%  softirqs.CPU109.RCU
     32108 ±  7%     +24.0%      39802        softirqs.CPU109.SCHED
     21436 ±  9%    +124.3%      48089 ±  7%  softirqs.CPU11.RCU
     19168 ± 16%    +136.7%      45370 ±  4%  softirqs.CPU110.RCU
     32633 ±  5%     +22.0%      39828 ±  2%  softirqs.CPU110.SCHED
     19226 ± 16%    +131.4%      44486 ±  3%  softirqs.CPU111.RCU
     31876 ±  9%     +22.5%      39037 ±  7%  softirqs.CPU111.SCHED
     18752 ±  9%    +125.1%      42214 ±  5%  softirqs.CPU112.RCU
     33139 ±  4%     +19.3%      39537 ±  3%  softirqs.CPU112.SCHED
     18571 ± 11%    +126.2%      42004 ±  3%  softirqs.CPU113.RCU
     33130 ±  4%     +20.6%      39943 ±  2%  softirqs.CPU113.SCHED
     18861 ± 13%    +124.8%      42409 ±  5%  softirqs.CPU114.RCU
     32611 ±  6%     +21.7%      39691 ±  2%  softirqs.CPU114.SCHED
     18161 ± 14%    +125.1%      40883 ±  4%  softirqs.CPU115.RCU
     32644 ±  5%     +20.1%      39212 ±  2%  softirqs.CPU115.SCHED
     18222 ± 14%    +131.3%      42152 ±  4%  softirqs.CPU116.RCU
     33025 ±  4%     +20.9%      39938        softirqs.CPU116.SCHED
     18640 ± 10%    +125.3%      41999 ±  4%  softirqs.CPU117.RCU
     33222 ±  4%     +18.9%      39496 ±  3%  softirqs.CPU117.SCHED
     18294 ± 13%    +130.0%      42068 ±  3%  softirqs.CPU118.RCU
     33096 ±  4%     +19.3%      39468 ±  3%  softirqs.CPU118.SCHED
     18313 ± 11%    +134.4%      42927 ±  5%  softirqs.CPU119.RCU
     21114 ±  6%    +127.6%      48057 ±  9%  softirqs.CPU12.RCU
     19537 ±  8%    +128.5%      44642 ±  5%  softirqs.CPU120.RCU
     19009 ± 10%    +128.4%      43409 ±  6%  softirqs.CPU121.RCU
     30437 ± 20%     +33.8%      40736 ±  3%  softirqs.CPU121.SCHED
     18764 ± 10%    +127.0%      42605 ±  6%  softirqs.CPU122.RCU
     34261 ±  2%     +18.2%      40503 ±  3%  softirqs.CPU122.SCHED
     19388 ± 10%    +123.6%      43346 ±  5%  softirqs.CPU123.RCU
     34412 ±  2%     +18.0%      40608 ±  3%  softirqs.CPU123.SCHED
     18814 ±  9%    +131.7%      43588 ±  7%  softirqs.CPU124.RCU
     34324 ±  2%     +18.7%      40736 ±  3%  softirqs.CPU124.SCHED
     18457 ± 11%    +129.0%      42271 ±  5%  softirqs.CPU125.RCU
     34462 ±  2%     +18.4%      40809 ±  3%  softirqs.CPU125.SCHED
     18867 ±  9%    +126.5%      42733 ±  7%  softirqs.CPU126.RCU
     34378 ±  2%     +18.2%      40624 ±  3%  softirqs.CPU126.SCHED
     18279 ± 10%    +133.8%      42730 ±  6%  softirqs.CPU127.RCU
     34155 ±  3%     +18.4%      40435 ±  3%  softirqs.CPU127.SCHED
     21170 ± 12%    +120.8%      46755 ±  8%  softirqs.CPU128.RCU
     34108 ±  3%     +18.6%      40454 ±  3%  softirqs.CPU128.SCHED
     21281 ±  9%    +121.3%      47090 ±  8%  softirqs.CPU129.RCU
     34169 ±  2%     +18.4%      40450 ±  3%  softirqs.CPU129.SCHED
     21165 ±  7%    +130.3%      48734 ±  7%  softirqs.CPU13.RCU
     21353 ± 10%    +121.3%      47265 ±  7%  softirqs.CPU130.RCU
     34224 ±  2%     +17.9%      40342 ±  3%  softirqs.CPU130.SCHED
     20225 ± 20%    +138.3%      48201 ±  7%  softirqs.CPU131.RCU
     35035 ±  2%     +15.7%      40553 ±  3%  softirqs.CPU131.SCHED
     21975 ±  8%    +119.0%      48118 ±  7%  softirqs.CPU132.RCU
     34274 ±  2%     +18.4%      40576 ±  3%  softirqs.CPU132.SCHED
     21462 ± 10%    +123.6%      47991 ±  8%  softirqs.CPU133.RCU
     34187 ±  2%     +18.6%      40544 ±  3%  softirqs.CPU133.SCHED
     21054 ±  9%    +123.3%      47021 ±  9%  softirqs.CPU134.RCU
     34105 ±  2%     +18.4%      40375 ±  3%  softirqs.CPU134.SCHED
     21711 ±  9%    +117.8%      47297 ±  7%  softirqs.CPU135.RCU
     30667 ± 20%     +32.0%      40488 ±  3%  softirqs.CPU135.SCHED
     21637 ± 10%    +121.7%      47963 ±  7%  softirqs.CPU136.RCU
     34521 ±  3%     +18.0%      40725 ±  3%  softirqs.CPU136.SCHED
     21523 ± 12%    +124.0%      48201 ±  6%  softirqs.CPU137.RCU
     34201 ±  2%     +18.8%      40631 ±  3%  softirqs.CPU137.SCHED
     21772 ± 11%    +117.1%      47279 ±  7%  softirqs.CPU138.RCU
     34240 ±  2%     +18.0%      40419 ±  3%  softirqs.CPU138.SCHED
     21384 ± 11%    +120.6%      47169 ±  8%  softirqs.CPU139.RCU
     34207 ±  2%     +18.5%      40519 ±  3%  softirqs.CPU139.SCHED
     21089 ±  8%    +132.6%      49060 ±  7%  softirqs.CPU14.RCU
     21446 ± 12%    +117.5%      46641 ±  7%  softirqs.CPU140.RCU
     34283 ±  2%     +17.9%      40413 ±  3%  softirqs.CPU140.SCHED
     21394 ± 11%    +122.1%      47526 ±  7%  softirqs.CPU141.RCU
     34262 ±  2%     +18.2%      40484 ±  3%  softirqs.CPU141.SCHED
     21510 ± 12%    +122.5%      47856 ±  7%  softirqs.CPU142.RCU
     34272 ±  2%     +18.4%      40571 ±  3%  softirqs.CPU142.SCHED
     21794 ± 11%    +119.3%      47806 ±  7%  softirqs.CPU143.RCU
     34379 ±  2%     +17.7%      40464 ±  3%  softirqs.CPU143.SCHED
     22081 ±  8%    +107.0%      45701 ± 12%  softirqs.CPU144.RCU
     21204 ±  7%    +112.7%      45101 ± 11%  softirqs.CPU145.RCU
     21354 ±  8%    +111.7%      45201 ± 11%  softirqs.CPU146.RCU
     34494 ±  3%     +12.4%      38783 ±  3%  softirqs.CPU146.SCHED
     22014 ± 11%    +106.0%      45348 ± 11%  softirqs.CPU147.RCU
     21731 ±  8%    +110.1%      45650 ± 12%  softirqs.CPU148.RCU
     21498 ±  9%    +111.3%      45427 ± 11%  softirqs.CPU149.RCU
     22409 ±  5%    +116.3%      48480 ±  9%  softirqs.CPU15.RCU
     14902 ± 81%     +93.8%      28882 ± 39%  softirqs.CPU15.SCHED
     21817 ±  9%    +109.0%      45604 ± 11%  softirqs.CPU150.RCU
     21296 ± 10%    +111.0%      44935 ± 10%  softirqs.CPU151.RCU
     21265 ± 10%    +110.4%      44740 ± 10%  softirqs.CPU152.RCU
     21349 ± 10%    +110.1%      44847 ± 12%  softirqs.CPU153.RCU
     21748 ± 10%    +109.3%      45530 ± 11%  softirqs.CPU154.RCU
     21913 ±  9%    +106.8%      45320 ± 11%  softirqs.CPU155.RCU
     22080 ±  9%    +106.3%      45544 ± 11%  softirqs.CPU156.RCU
     21072 ±  9%    +111.5%      44572 ± 11%  softirqs.CPU157.RCU
     34333 ±  2%     +11.0%      38100 ±  5%  softirqs.CPU157.SCHED
     20975 ±  9%    +108.3%      43687 ± 11%  softirqs.CPU158.RCU
     34232 ±  2%     +11.5%      38183 ±  4%  softirqs.CPU158.SCHED
     20796 ± 13%    +114.4%      44584 ± 11%  softirqs.CPU159.RCU
     34381 ±  3%     +14.5%      39356 ±  2%  softirqs.CPU159.SCHED
     19673 ±  4%    +122.2%      43719 ±  4%  softirqs.CPU16.RCU
     19575 ±  5%    +109.4%      40996 ± 13%  softirqs.CPU160.RCU
     34469 ±  2%     +14.7%      39527 ±  2%  softirqs.CPU160.SCHED
     20128 ±  6%    +106.8%      41620 ± 12%  softirqs.CPU161.RCU
     34494 ±  2%     +14.2%      39401 ±  2%  softirqs.CPU161.SCHED
     20309 ±  6%    +106.9%      42026 ± 12%  softirqs.CPU162.RCU
     34472 ±  2%     +12.9%      38928 ±  3%  softirqs.CPU162.SCHED
     20127 ±  5%    +110.0%      42274 ± 14%  softirqs.CPU163.RCU
     34424 ±  2%     +12.9%      38880 ±  4%  softirqs.CPU163.SCHED
     20556 ±  8%    +105.5%      42253 ± 13%  softirqs.CPU164.RCU
     34389 ±  3%     +15.5%      39725 ±  2%  softirqs.CPU164.SCHED
     20009 ±  6%    +106.5%      41325 ± 13%  softirqs.CPU165.RCU
     34500 ±  2%     +14.1%      39380 ±  3%  softirqs.CPU165.SCHED
     20229 ±  6%    +108.4%      42151 ± 11%  softirqs.CPU166.RCU
     34465 ±  2%     +14.5%      39463 ±  2%  softirqs.CPU166.SCHED
     20114 ±  6%    +107.4%      41721 ± 13%  softirqs.CPU167.RCU
     34473 ±  2%     +14.3%      39391 ±  2%  softirqs.CPU167.SCHED
     19291 ±  5%    +118.3%      42117 ±  9%  softirqs.CPU168.RCU
     18811 ±  4%    +116.9%      40810 ±  9%  softirqs.CPU169.RCU
     33446 ±  3%     +21.1%      40487 ±  2%  softirqs.CPU169.SCHED
     19397 ±  9%    +126.7%      43977 ±  3%  softirqs.CPU17.RCU
     29414 ± 18%     +34.8%      39648 ±  2%  softirqs.CPU17.SCHED
     19066 ±  3%    +117.2%      41415 ±  8%  softirqs.CPU170.RCU
     19220 ±  3%    +115.5%      41424 ±  6%  softirqs.CPU171.RCU
     18493 ±  4%    +118.4%      40385 ±  8%  softirqs.CPU172.RCU
     33551 ±  2%     +20.4%      40412 ±  2%  softirqs.CPU172.SCHED
     18962 ±  6%    +117.2%      41185 ± 10%  softirqs.CPU173.RCU
     33688 ±  2%     +20.6%      40620 ±  2%  softirqs.CPU173.SCHED
     18847 ±  4%    +117.1%      40924 ±  8%  softirqs.CPU174.RCU
     32749 ±  7%     +24.3%      40700 ±  2%  softirqs.CPU174.SCHED
     18706 ±  5%    +119.4%      41049 ±  8%  softirqs.CPU175.RCU
     33451 ±  3%     +21.6%      40667 ±  2%  softirqs.CPU175.SCHED
     20138 ±  5%    +121.5%      44614 ±  5%  softirqs.CPU176.RCU
     33630 ±  2%     +21.1%      40714 ±  3%  softirqs.CPU176.SCHED
     20307 ±  6%    +124.4%      45565 ±  5%  softirqs.CPU177.RCU
     20210 ±  5%    +121.3%      44725 ±  5%  softirqs.CPU178.RCU
     33463 ±  3%     +21.1%      40524 ±  3%  softirqs.CPU178.SCHED
     20060 ±  5%    +123.6%      44863 ±  5%  softirqs.CPU179.RCU
     33449 ±  3%     +21.4%      40607 ±  2%  softirqs.CPU179.SCHED
     19239 ± 11%    +130.5%      44347 ±  4%  softirqs.CPU18.RCU
     32081 ±  6%     +23.7%      39687        softirqs.CPU18.SCHED
     19882 ±  5%    +122.4%      44224 ±  6%  softirqs.CPU180.RCU
     33050 ±  4%     +21.6%      40189 ±  3%  softirqs.CPU180.SCHED
     19705 ±  5%    +123.3%      44010 ±  6%  softirqs.CPU181.RCU
     32993 ±  4%     +21.8%      40173 ±  3%  softirqs.CPU181.SCHED
     20406 ±  6%    +118.9%      44661 ±  5%  softirqs.CPU182.RCU
     33538 ±  4%     +20.6%      40448 ±  2%  softirqs.CPU182.SCHED
     20334 ±  5%    +120.9%      44912 ±  5%  softirqs.CPU183.RCU
     33533 ±  3%     +20.7%      40474 ±  2%  softirqs.CPU183.SCHED
     20526 ±  6%    +119.7%      45086 ±  5%  softirqs.CPU184.RCU
     33453 ±  3%     +21.3%      40581 ±  2%  softirqs.CPU184.SCHED
     20277 ±  4%    +126.0%      45818 ±  8%  softirqs.CPU185.RCU
     33871 ±  2%     +19.6%      40513 ±  2%  softirqs.CPU185.SCHED
     20432 ±  3%    +108.4%      42581 ± 14%  softirqs.CPU186.RCU
     33469 ±  3%     +23.6%      41373        softirqs.CPU186.SCHED
     20139 ±  5%    +123.8%      45066 ±  5%  softirqs.CPU187.RCU
     33367 ±  3%     +21.1%      40417 ±  3%  softirqs.CPU187.SCHED
     20437 ±  4%    +117.8%      44508 ±  5%  softirqs.CPU188.RCU
     28880 ± 29%     +39.2%      40207 ±  4%  softirqs.CPU188.SCHED
     20088 ±  5%    +123.2%      44842 ±  7%  softirqs.CPU189.RCU
     33280 ±  3%     +21.7%      40511 ±  3%  softirqs.CPU189.SCHED
     18485 ± 12%    +125.9%      41754 ±  5%  softirqs.CPU19.RCU
     33600 ±  5%     +16.6%      39178 ±  2%  softirqs.CPU19.SCHED
     20316 ±  5%    +120.0%      44689 ±  6%  softirqs.CPU190.RCU
     33252 ±  4%     +21.5%      40406 ±  3%  softirqs.CPU190.SCHED
     20199 ±  4%    +122.6%      44967 ±  5%  softirqs.CPU191.RCU
     33567 ±  2%     +17.2%      39326 ±  5%  softirqs.CPU191.SCHED
     21749 ±  9%    +122.2%      48331 ±  6%  softirqs.CPU2.RCU
     20410 ± 47%     +64.2%      33512 ± 20%  softirqs.CPU2.SCHED
     19165 ± 10%    +126.1%      43335 ±  4%  softirqs.CPU20.RCU
     33501 ±  4%     +17.5%      39351 ±  2%  softirqs.CPU20.SCHED
     18974 ±  9%    +130.0%      43644 ±  3%  softirqs.CPU21.RCU
     33673 ±  3%     +17.3%      39510 ±  2%  softirqs.CPU21.SCHED
     19311 ± 11%    +123.9%      43243 ±  4%  softirqs.CPU22.RCU
     32454 ±  7%     +21.2%      39319 ±  2%  softirqs.CPU22.SCHED
     20205 ± 12%    +114.6%      43369 ±  4%  softirqs.CPU23.RCU
     32717 ±  5%     +21.1%      39623        softirqs.CPU23.SCHED
     20750 ±  7%    +119.6%      45563 ±  5%  softirqs.CPU24.RCU
     20136 ± 12%    +118.9%      44076 ±  6%  softirqs.CPU25.RCU
     30631 ± 16%     +31.3%      40231 ±  3%  softirqs.CPU25.SCHED
     19508 ± 10%    +123.3%      43554 ±  5%  softirqs.CPU26.RCU
     33343 ±  2%     +21.8%      40603 ±  3%  softirqs.CPU26.SCHED
     19461 ± 10%    +123.0%      43398 ±  4%  softirqs.CPU27.RCU
     34046 ±  3%     +18.4%      40309 ±  3%  softirqs.CPU27.SCHED
     19034 ± 11%    +128.3%      43462 ±  5%  softirqs.CPU28.RCU
     33842 ±  3%     +19.6%      40485 ±  2%  softirqs.CPU28.SCHED
     19568 ±  9%    +120.8%      43207 ±  5%  softirqs.CPU29.RCU
     34076 ±  3%     +17.9%      40180 ±  3%  softirqs.CPU29.SCHED
     22102 ±  7%    +121.1%      48876 ±  6%  softirqs.CPU3.RCU
     11352 ±  4%    +179.4%      31715 ± 28%  softirqs.CPU3.SCHED
     19397 ± 11%    +121.7%      43004 ±  5%  softirqs.CPU30.RCU
     34011 ±  3%     +18.1%      40155 ±  3%  softirqs.CPU30.SCHED
     19813 ± 10%    +116.7%      42936 ±  5%  softirqs.CPU31.RCU
     28877 ± 28%     +38.9%      40106 ±  3%  softirqs.CPU31.SCHED
     22985 ±  7%    +113.7%      49109 ±  7%  softirqs.CPU32.RCU
     33988 ±  3%     +17.8%      40039 ±  3%  softirqs.CPU32.SCHED
     22657 ±  9%    +112.3%      48097 ±  8%  softirqs.CPU33.RCU
     33971 ±  3%     +18.3%      40201 ±  3%  softirqs.CPU33.SCHED
     22744 ±  8%    +116.9%      49325 ±  6%  softirqs.CPU34.RCU
     33842 ±  3%     +18.6%      40153 ±  3%  softirqs.CPU34.SCHED
     22016 ± 12%    +127.9%      50172 ±  7%  softirqs.CPU35.RCU
     33824 ±  3%     +19.0%      40256 ±  3%  softirqs.CPU35.SCHED
     22803 ±  9%    +117.7%      49644 ±  7%  softirqs.CPU36.RCU
     33848 ±  3%     +18.7%      40192 ±  3%  softirqs.CPU36.SCHED
     22024 ±  7%    +123.5%      49219 ±  7%  softirqs.CPU37.RCU
     33798 ±  3%     +14.8%      38789 ±  5%  softirqs.CPU37.SCHED
     22554 ±  6%    +118.9%      49362 ±  8%  softirqs.CPU38.RCU
     33803 ±  3%     +18.6%      40075 ±  3%  softirqs.CPU38.SCHED
     22068 ± 10%    +121.3%      48832 ±  7%  softirqs.CPU39.RCU
     22089 ±  6%    +119.8%      48551 ±  7%  softirqs.CPU4.RCU
     22095 ±  6%    +123.8%      49458 ±  6%  softirqs.CPU40.RCU
     33886 ±  3%     +18.7%      40212 ±  3%  softirqs.CPU40.SCHED
     22898 ±  9%    +117.3%      49761 ±  6%  softirqs.CPU41.RCU
     33889 ±  3%     +18.4%      40126 ±  3%  softirqs.CPU41.SCHED
     22668 ±  8%    +118.9%      49630 ±  7%  softirqs.CPU42.RCU
     33918 ±  3%     +18.4%      40156 ±  3%  softirqs.CPU42.SCHED
     22911 ±  9%    +116.9%      49699 ±  8%  softirqs.CPU43.RCU
     28225 ± 32%     +41.9%      40046 ±  3%  softirqs.CPU43.SCHED
     21873 ±  9%    +124.1%      49008 ±  7%  softirqs.CPU44.RCU
     33829 ±  3%     +19.0%      40251 ±  3%  softirqs.CPU44.SCHED
     22436 ±  7%    +117.4%      48777 ±  8%  softirqs.CPU45.RCU
     33869 ±  3%     +18.3%      40071 ±  3%  softirqs.CPU45.SCHED
     22360 ± 10%    +119.4%      49066 ±  7%  softirqs.CPU46.RCU
     33855 ±  3%     +18.6%      40139 ±  3%  softirqs.CPU46.SCHED
     22573 ±  8%    +119.2%      49487 ±  8%  softirqs.CPU47.RCU
     33944 ±  3%     +18.7%      40308 ±  3%  softirqs.CPU47.SCHED
     23683 ±  8%    +107.2%      49070 ± 10%  softirqs.CPU48.RCU
     22691 ±  8%    +112.6%      48236 ±  9%  softirqs.CPU49.RCU
     21696 ±  7%    +123.7%      48539 ±  7%  softirqs.CPU5.RCU
     22538 ±  9%    +115.6%      48603 ±  8%  softirqs.CPU50.RCU
     22540 ±  9%    +117.4%      48995 ±  8%  softirqs.CPU51.RCU
     22994 ± 12%    +113.7%      49148 ±  8%  softirqs.CPU52.RCU
     22465 ±  8%    +121.5%      49768 ±  7%  softirqs.CPU53.RCU
     22513 ±  9%    +120.3%      49589 ±  8%  softirqs.CPU54.RCU
     22411 ± 10%    +120.3%      49378 ±  9%  softirqs.CPU55.RCU
     21931 ± 10%    +124.4%      49215 ±  7%  softirqs.CPU56.RCU
     22160 ± 10%    +120.3%      48823 ±  9%  softirqs.CPU57.RCU
     22106 ±  8%    +123.4%      49379 ±  7%  softirqs.CPU58.RCU
     21863 ±  9%    +126.7%      49571 ±  8%  softirqs.CPU59.RCU
     21951 ±  7%    +108.2%      45699 ± 10%  softirqs.CPU6.RCU
     22433 ± 10%    +121.4%      49674 ±  8%  softirqs.CPU60.RCU
     21930 ±  8%    +122.4%      48767 ±  7%  softirqs.CPU61.RCU
     22191 ±  9%    +118.4%      48457 ±  7%  softirqs.CPU62.RCU
     20572 ± 19%    +137.3%      48814 ±  7%  softirqs.CPU63.RCU
     20606 ±  3%    +106.0%      42440 ± 14%  softirqs.CPU64.RCU
     34281 ±  3%     +15.6%      39616 ±  4%  softirqs.CPU64.SCHED
     20639 ±  6%    +108.0%      42919 ± 11%  softirqs.CPU65.RCU
     34090 ±  3%     +13.8%      38778 ±  2%  softirqs.CPU65.SCHED
     20711 ±  5%    +107.9%      43068 ± 12%  softirqs.CPU66.RCU
     34059 ±  3%     +13.5%      38643 ±  3%  softirqs.CPU66.SCHED
     20714 ±  6%    +108.8%      43250 ± 12%  softirqs.CPU67.RCU
     33981 ±  3%     +14.3%      38855 ±  3%  softirqs.CPU67.SCHED
     21132 ±  6%    +104.5%      43216 ± 13%  softirqs.CPU68.RCU
     34152 ±  3%     +13.9%      38908 ±  3%  softirqs.CPU68.SCHED
     20870 ±  6%    +105.5%      42895 ± 12%  softirqs.CPU69.RCU
     34035 ±  3%     +13.6%      38649 ±  3%  softirqs.CPU69.SCHED
     22131 ± 11%    +118.0%      48247 ±  6%  softirqs.CPU7.RCU
     20514 ±  6%    +110.1%      43090 ± 11%  softirqs.CPU70.RCU
     34016 ±  3%     +14.5%      38957 ±  2%  softirqs.CPU70.SCHED
     20526 ±  5%    +102.7%      41599 ± 15%  softirqs.CPU71.RCU
     32989 ±  7%     +21.2%      39982 ±  4%  softirqs.CPU71.SCHED
     20770 ±  5%    +119.3%      45551 ±  8%  softirqs.CPU72.RCU
     19814 ±  6%    +118.6%      43309 ±  7%  softirqs.CPU73.RCU
     20012 ±  4%    +112.5%      42519 ±  7%  softirqs.CPU74.RCU
     29526 ± 24%     +36.3%      40247 ±  3%  softirqs.CPU74.SCHED
     19752 ±  6%    +113.7%      42217 ±  8%  softirqs.CPU75.RCU
     28565 ± 30%     +40.8%      40210 ±  3%  softirqs.CPU75.SCHED
     19667 ±  3%    +112.2%      41740 ±  8%  softirqs.CPU76.RCU
     27517 ± 38%     +44.8%      39842 ±  3%  softirqs.CPU76.SCHED
     19604 ±  4%    +112.2%      41597 ±  8%  softirqs.CPU77.RCU
     27223 ± 40%     +46.7%      39935 ±  3%  softirqs.CPU77.SCHED
     20148          +107.4%      41792 ±  8%  softirqs.CPU78.RCU
     28971 ± 27%     +37.9%      39960 ±  3%  softirqs.CPU78.SCHED
     19633 ±  5%    +113.1%      41846 ±  8%  softirqs.CPU79.RCU
     29302 ± 25%     +36.4%      39968 ±  3%  softirqs.CPU79.SCHED
     21966 ±  9%    +123.5%      49088 ±  7%  softirqs.CPU8.RCU
     20793 ±  6%    +116.5%      45026 ±  4%  softirqs.CPU80.RCU
     27598 ± 37%     +44.6%      39897 ±  3%  softirqs.CPU80.SCHED
     20668 ±  5%    +120.7%      45615 ±  5%  softirqs.CPU81.RCU
     29054 ± 26%     +37.3%      39903 ±  3%  softirqs.CPU81.SCHED
     20726 ±  5%    +119.1%      45421 ±  5%  softirqs.CPU82.RCU
     28499 ± 30%     +40.2%      39960 ±  3%  softirqs.CPU82.SCHED
     19390 ±  8%    +134.3%      45429 ±  4%  softirqs.CPU83.RCU
     30213 ± 19%     +32.5%      40043 ±  2%  softirqs.CPU83.SCHED
     20393 ±  4%    +122.6%      45388 ±  5%  softirqs.CPU84.RCU
     30765 ± 14%     +28.9%      39667 ±  3%  softirqs.CPU84.SCHED
     20725 ±  2%    +118.5%      45293 ±  5%  softirqs.CPU85.RCU
     27760 ± 35%     +43.3%      39776 ±  3%  softirqs.CPU85.SCHED
     20580 ±  5%    +121.4%      45554 ±  5%  softirqs.CPU86.RCU
     20718 ±  5%    +118.7%      45301 ±  5%  softirqs.CPU87.RCU
     26915 ± 42%     +48.6%      40003 ±  3%  softirqs.CPU87.SCHED
     20763 ±  4%    +120.2%      45728 ±  5%  softirqs.CPU88.RCU
     30810 ± 15%     +29.3%      39842 ±  3%  softirqs.CPU88.SCHED
     21289 ±  2%    +111.8%      45082 ±  4%  softirqs.CPU89.RCU
     33487 ±  2%     +19.0%      39835 ±  3%  softirqs.CPU89.SCHED
     21579 ±  9%    +123.8%      48300 ±  8%  softirqs.CPU9.RCU
     20400 ±  3%    +120.9%      45058 ±  5%  softirqs.CPU90.RCU
     20371 ±  4%    +126.7%      46184 ±  4%  softirqs.CPU91.RCU
     32988 ±  3%     +21.4%      40061 ±  3%  softirqs.CPU91.SCHED
     20263 ±  3%    +122.6%      45097 ±  4%  softirqs.CPU92.RCU
     33192 ±  3%     +20.0%      39828 ±  4%  softirqs.CPU92.SCHED
     20239 ±  5%    +123.1%      45150 ±  4%  softirqs.CPU93.RCU
     32978 ±  3%     +21.0%      39900 ±  3%  softirqs.CPU93.SCHED
     20446 ±  5%    +131.9%      47421 ±  8%  softirqs.CPU94.RCU
     33136 ±  4%     +20.8%      40016 ±  3%  softirqs.CPU94.SCHED
     20498 ±  5%    +126.6%      46446 ±  4%  softirqs.CPU95.RCU
     19594 ± 16%    +130.5%      45172 ±  3%  softirqs.CPU96.RCU
     18967 ± 11%    +130.5%      43724 ±  4%  softirqs.CPU97.RCU
     33298 ±  6%     +14.7%      38208 ±  5%  softirqs.CPU97.SCHED
     19122 ± 17%    +132.9%      44527 ±  3%  softirqs.CPU98.RCU
     19392 ± 17%    +131.6%      44907 ±  4%  softirqs.CPU99.RCU
     32791 ±  4%     +20.8%      39609 ±  3%  softirqs.CPU99.SCHED
     15568 ± 14%    +109.9%      32681 ± 45%  softirqs.NET_RX
   3963598 ±  7%    +119.8%    8713905 ±  6%  softirqs.RCU
   6125987 ±  2%     +17.3%    7186965 ±  2%  softirqs.SCHED
    167016 ±  2%     +12.5%     187925        softirqs.TIMER
     31.37 ±  5%      -7.9       23.48 ±  2%  perf-profile.calltrace.cycles-pp.ret_from_fork
     31.37 ±  5%      -7.9       23.48 ±  2%  perf-profile.calltrace.cycles-pp.kthread.ret_from_fork
      7.60 ±  6%      -7.6        0.00        perf-profile.calltrace.cycles-pp.rwsem_optimistic_spin.rwsem_down_read_slowpath.xfs_map_blocks.iomap_writepage_map.write_cache_pages
     14.20 ±  7%      -7.6        6.64 ±  3%  perf-profile.calltrace.cycles-pp.wb_workfn.process_one_work.worker_thread.kthread.ret_from_fork
     14.20 ±  7%      -7.6        6.64 ±  3%  perf-profile.calltrace.cycles-pp.wb_writeback.wb_workfn.process_one_work.worker_thread.kthread
     14.20 ±  7%      -7.6        6.64 ±  3%  perf-profile.calltrace.cycles-pp.__writeback_inodes_wb.wb_writeback.wb_workfn.process_one_work.worker_thread
     14.20 ±  7%      -7.6        6.64 ±  3%  perf-profile.calltrace.cycles-pp.writeback_sb_inodes.__writeback_inodes_wb.wb_writeback.wb_workfn.process_one_work
     14.20 ±  7%      -7.6        6.64 ±  3%  perf-profile.calltrace.cycles-pp.__writeback_single_inode.writeback_sb_inodes.__writeback_inodes_wb.wb_writeback.wb_workfn
     14.20 ±  7%      -7.6        6.64 ±  3%  perf-profile.calltrace.cycles-pp.do_writepages.__writeback_single_inode.writeback_sb_inodes.__writeback_inodes_wb.wb_writeback
     14.20 ±  7%      -7.6        6.64 ±  3%  perf-profile.calltrace.cycles-pp.xfs_vm_writepages.do_writepages.__writeback_single_inode.writeback_sb_inodes.__writeback_inodes_wb
     14.20 ±  7%      -7.6        6.64 ±  3%  perf-profile.calltrace.cycles-pp.iomap_writepages.xfs_vm_writepages.do_writepages.__writeback_single_inode.writeback_sb_inodes
     14.19 ±  7%      -7.5        6.64 ±  3%  perf-profile.calltrace.cycles-pp.write_cache_pages.iomap_writepages.xfs_vm_writepages.do_writepages.__writeback_single_inode
      7.23 ±  7%      -7.2        0.00        perf-profile.calltrace.cycles-pp.rwsem_spin_on_owner.rwsem_optimistic_spin.rwsem_down_read_slowpath.xfs_map_blocks.iomap_writepage_map
     12.80 ±  7%      -7.2        5.57 ±  3%  perf-profile.calltrace.cycles-pp.iomap_writepage_map.write_cache_pages.iomap_writepages.xfs_vm_writepages.do_writepages
     29.14 ±  4%      -6.6       22.56 ±  2%  perf-profile.calltrace.cycles-pp.process_one_work.worker_thread.kthread.ret_from_fork
     29.16 ±  4%      -5.9       23.28 ±  2%  perf-profile.calltrace.cycles-pp.worker_thread.kthread.ret_from_fork
      8.69 ±  6%      -5.5        3.17 ±  3%  perf-profile.calltrace.cycles-pp.xfs_map_blocks.iomap_writepage_map.write_cache_pages.iomap_writepages.xfs_vm_writepages
      7.74 ±  6%      -5.4        2.38 ±  3%  perf-profile.calltrace.cycles-pp.rwsem_down_read_slowpath.xfs_map_blocks.iomap_writepage_map.write_cache_pages.iomap_writepages
     13.59 ± 11%      -5.0        8.57 ±  8%  perf-profile.calltrace.cycles-pp.new_sync_write.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
     13.47 ± 11%      -5.0        8.49 ±  8%  perf-profile.calltrace.cycles-pp.xfs_file_buffered_aio_write.new_sync_write.vfs_write.ksys_write.do_syscall_64
     12.95 ± 11%      -4.8        8.16 ±  8%  perf-profile.calltrace.cycles-pp.iomap_file_buffered_write.xfs_file_buffered_aio_write.new_sync_write.vfs_write.ksys_write
     12.93 ± 11%      -4.8        8.14 ±  8%  perf-profile.calltrace.cycles-pp.iomap_apply.iomap_file_buffered_write.xfs_file_buffered_aio_write.new_sync_write.vfs_write
      9.88 ± 12%      -3.8        6.08 ±  8%  perf-profile.calltrace.cycles-pp.iomap_write_actor.iomap_apply.iomap_file_buffered_write.xfs_file_buffered_aio_write.new_sync_write
      4.27 ±  8%      -1.6        2.70 ± 12%  perf-profile.calltrace.cycles-pp.iomap_write_begin.iomap_write_actor.iomap_apply.iomap_file_buffered_write.xfs_file_buffered_aio_write
      4.14 ±  8%      -1.5        2.60 ± 12%  perf-profile.calltrace.cycles-pp.grab_cache_page_write_begin.iomap_write_begin.iomap_write_actor.iomap_apply.iomap_file_buffered_write
      4.12 ±  8%      -1.5        2.58 ± 12%  perf-profile.calltrace.cycles-pp.pagecache_get_page.grab_cache_page_write_begin.iomap_write_begin.iomap_write_actor.iomap_apply
      7.25 ±  3%      -1.3        5.90        perf-profile.calltrace.cycles-pp.xfs_bmapi_write.xfs_iomap_write_unwritten.xfs_end_ioend.xfs_end_io.process_one_work
      2.47 ± 23%      -1.2        1.30 ±  4%  perf-profile.calltrace.cycles-pp.iov_iter_copy_from_user_atomic.iomap_write_actor.iomap_apply.iomap_file_buffered_write.xfs_file_buffered_aio_write
      2.25 ±  7%      -1.1        1.10 ±  3%  perf-profile.calltrace.cycles-pp.iomap_submit_ioend.iomap_writepage_map.write_cache_pages.iomap_writepages.xfs_vm_writepages
      2.22 ±  7%      -1.1        1.08 ±  3%  perf-profile.calltrace.cycles-pp.submit_bio.iomap_submit_ioend.iomap_writepage_map.write_cache_pages.iomap_writepages
      2.19 ±  7%      -1.1        1.05 ±  4%  perf-profile.calltrace.cycles-pp.submit_bio_noacct.submit_bio.iomap_submit_ioend.iomap_writepage_map.write_cache_pages
      2.38 ± 25%      -1.1        1.25 ±  4%  perf-profile.calltrace.cycles-pp.copyin.iov_iter_copy_from_user_atomic.iomap_write_actor.iomap_apply.iomap_file_buffered_write
      2.63 ± 11%      -1.1        1.50 ± 10%  perf-profile.calltrace.cycles-pp.iomap_write_end.iomap_write_actor.iomap_apply.iomap_file_buffered_write.xfs_file_buffered_aio_write
      2.35 ± 25%      -1.1        1.23 ±  4%  perf-profile.calltrace.cycles-pp.copy_user_enhanced_fast_string.copyin.iov_iter_copy_from_user_atomic.iomap_write_actor.iomap_apply
      1.83 ±  7%      -1.0        0.80 ±  4%  perf-profile.calltrace.cycles-pp.blk_mq_submit_bio.submit_bio_noacct.submit_bio.iomap_submit_ioend.iomap_writepage_map
      6.06 ±  2%      -1.0        5.07        perf-profile.calltrace.cycles-pp.xfs_bmapi_convert_unwritten.xfs_bmapi_write.xfs_iomap_write_unwritten.xfs_end_ioend.xfs_end_io
      2.90 ± 10%      -0.9        1.97 ±  9%  perf-profile.calltrace.cycles-pp.xfs_buffered_write_iomap_begin.iomap_apply.iomap_file_buffered_write.xfs_file_buffered_aio_write.new_sync_write
      5.79 ±  2%      -0.9        4.87 ±  2%  perf-profile.calltrace.cycles-pp.xfs_bmap_add_extent_unwritten_real.xfs_bmapi_convert_unwritten.xfs_bmapi_write.xfs_iomap_write_unwritten.xfs_end_ioend
      2.24 ± 11%      -0.9        1.33 ± 10%  perf-profile.calltrace.cycles-pp.xfs_iext_lookup_extent.xfs_buffered_write_iomap_begin.iomap_apply.iomap_file_buffered_write.xfs_file_buffered_aio_write
      2.13 ±  8%      -0.9        1.26 ±  6%  perf-profile.calltrace.cycles-pp.iomap_finish_ioends.xfs_end_ioend.xfs_end_io.process_one_work.worker_thread
      2.10 ±  8%      -0.9        1.24 ±  6%  perf-profile.calltrace.cycles-pp.iomap_finish_ioend.iomap_finish_ioends.xfs_end_ioend.xfs_end_io.process_one_work
      3.60 ±  2%      -0.7        2.88        perf-profile.calltrace.cycles-pp.__xfs_trans_commit.xfs_iomap_write_unwritten.xfs_end_ioend.xfs_end_io.process_one_work
      3.46 ±  2%      -0.7        2.75        perf-profile.calltrace.cycles-pp.xfs_log_commit_cil.__xfs_trans_commit.xfs_iomap_write_unwritten.xfs_end_ioend.xfs_end_io
      1.74 ±  5%      -0.7        1.04 ± 12%  perf-profile.calltrace.cycles-pp.add_to_page_cache_lru.pagecache_get_page.grab_cache_page_write_begin.iomap_write_begin.iomap_write_actor
      1.02 ±  8%      -0.6        0.46 ± 58%  perf-profile.calltrace.cycles-pp.__set_page_dirty.iomap_set_page_dirty.iomap_write_end.iomap_write_actor.iomap_apply
      1.28 ± 18%      -0.6        0.72 ± 12%  perf-profile.calltrace.cycles-pp.iomap_set_range_uptodate.iomap_write_end.iomap_write_actor.iomap_apply.iomap_file_buffered_write
      1.71 ± 12%      -0.5        1.18 ± 14%  perf-profile.calltrace.cycles-pp.find_get_entry.pagecache_get_page.grab_cache_page_write_begin.iomap_write_begin.iomap_write_actor
      1.26 ±  9%      -0.5        0.72 ± 10%  perf-profile.calltrace.cycles-pp.iomap_set_page_dirty.iomap_write_end.iomap_write_actor.iomap_apply.iomap_file_buffered_write
      1.69 ± 12%      -0.5        1.16 ± 14%  perf-profile.calltrace.cycles-pp.xas_load.find_get_entry.pagecache_get_page.grab_cache_page_write_begin.iomap_write_begin
      1.24 ±  5%      -0.5        0.75 ± 13%  perf-profile.calltrace.cycles-pp.__add_to_page_cache_locked.add_to_page_cache_lru.pagecache_get_page.grab_cache_page_write_begin.iomap_write_begin
      1.80 ±  3%      -0.5        1.32 ±  3%  perf-profile.calltrace.cycles-pp.xlog_cil_insert_items.xfs_log_commit_cil.__xfs_trans_commit.xfs_iomap_write_unwritten.xfs_end_ioend
      1.22 ±  9%      -0.5        0.74 ±  8%  perf-profile.calltrace.cycles-pp.end_page_writeback.iomap_finish_ioend.iomap_finish_ioends.xfs_end_ioend.xfs_end_io
      2.74 ±  3%      -0.5        2.27 ±  2%  perf-profile.calltrace.cycles-pp.xfs_btree_lookup.xfs_bmap_add_extent_unwritten_real.xfs_bmapi_convert_unwritten.xfs_bmapi_write.xfs_iomap_write_unwritten
      1.19 ±  8%      -0.5        0.72 ±  8%  perf-profile.calltrace.cycles-pp.test_clear_page_writeback.end_page_writeback.iomap_finish_ioend.iomap_finish_ioends.xfs_end_ioend
      1.55 ±  6%      -0.4        1.18 ±  2%  perf-profile.calltrace.cycles-pp.xfs_btree_lookup_get_block.xfs_btree_lookup.xfs_bmap_add_extent_unwritten_real.xfs_bmapi_convert_unwritten.xfs_bmapi_write
      1.01 ± 10%      -0.4        0.66 ±  6%  perf-profile.calltrace.cycles-pp.__test_set_page_writeback.iomap_writepage_map.write_cache_pages.iomap_writepages.xfs_vm_writepages
      0.72 ±  8%      -0.3        0.39 ± 58%  perf-profile.calltrace.cycles-pp.xfs_buf_find.xfs_buf_get_map.xfs_buf_read_map.xfs_trans_read_buf_map.xfs_btree_read_buf_block
      1.19 ±  4%      -0.3        0.86 ±  4%  perf-profile.calltrace.cycles-pp.xfs_buf_item_format.xlog_cil_insert_items.xfs_log_commit_cil.__xfs_trans_commit.xfs_iomap_write_unwritten
      1.25 ±  8%      -0.3        0.92 ±  3%  perf-profile.calltrace.cycles-pp.xfs_btree_read_buf_block.xfs_btree_lookup_get_block.xfs_btree_lookup.xfs_bmap_add_extent_unwritten_real.xfs_bmapi_convert_unwritten
      1.06 ±  9%      -0.3        0.78 ±  4%  perf-profile.calltrace.cycles-pp.xfs_trans_read_buf_map.xfs_btree_read_buf_block.xfs_btree_lookup_get_block.xfs_btree_lookup.xfs_bmap_add_extent_unwritten_real
      0.83 ±  9%      -0.2        0.59 ±  4%  perf-profile.calltrace.cycles-pp.xfs_buf_read_map.xfs_trans_read_buf_map.xfs_btree_read_buf_block.xfs_btree_lookup_get_block.xfs_btree_lookup
      0.77 ±  8%      -0.2        0.55 ±  5%  perf-profile.calltrace.cycles-pp.xfs_buf_get_map.xfs_buf_read_map.xfs_trans_read_buf_map.xfs_btree_read_buf_block.xfs_btree_lookup_get_block
      0.72 ±  5%      -0.2        0.54 ±  4%  perf-profile.calltrace.cycles-pp.xfs_trans_alloc.xfs_iomap_write_unwritten.xfs_end_ioend.xfs_end_io.process_one_work
      0.84 ±  3%      -0.2        0.68 ±  2%  perf-profile.calltrace.cycles-pp.xfs_buf_item_size.xfs_log_commit_cil.__xfs_trans_commit.xfs_iomap_write_unwritten.xfs_end_ioend
      0.77 ±  4%      -0.1        0.62 ±  2%  perf-profile.calltrace.cycles-pp.xfs_buf_item_size_segment.xfs_buf_item_size.xfs_log_commit_cil.__xfs_trans_commit.xfs_iomap_write_unwritten
      0.70 ±  9%      +0.1        0.79 ±  4%  perf-profile.calltrace.cycles-pp.rebalance_domains.__softirqentry_text_start.asm_call_sysvec_on_stack.do_softirq_own_stack.irq_exit_rcu
      1.18 ±  7%      +0.3        1.51 ±  4%  perf-profile.calltrace.cycles-pp.do_softirq_own_stack.irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state
      1.17 ±  7%      +0.3        1.51 ±  4%  perf-profile.calltrace.cycles-pp.asm_call_sysvec_on_stack.do_softirq_own_stack.irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      1.17 ±  7%      +0.3        1.51 ±  4%  perf-profile.calltrace.cycles-pp.__softirqentry_text_start.asm_call_sysvec_on_stack.do_softirq_own_stack.irq_exit_rcu.sysvec_apic_timer_interrupt
      0.82 ±  4%      +0.4        1.17 ±  6%  perf-profile.calltrace.cycles-pp.scheduler_tick.update_process_times.tick_sched_handle.tick_sched_timer.__hrtimer_run_queues
      1.40 ±  6%      +0.5        1.91 ±  4%  perf-profile.calltrace.cycles-pp.irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter
      0.00            +0.5        0.53 ±  4%  perf-profile.calltrace.cycles-pp.xfs_btree_make_block_unfull.xfs_btree_insrec.xfs_btree_insert.xfs_bmap_add_extent_unwritten_real.xfs_bmapi_convert_unwritten
      0.00            +0.5        0.53 ±  2%  perf-profile.calltrace.cycles-pp.__blk_mq_run_hw_queue.process_one_work.worker_thread.kthread.ret_from_fork
      1.55 ±  3%      +0.5        2.09 ±  6%  perf-profile.calltrace.cycles-pp.tick_sched_handle.tick_sched_timer.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt
      1.50 ±  2%      +0.5        2.04 ±  6%  perf-profile.calltrace.cycles-pp.update_process_times.tick_sched_handle.tick_sched_timer.__hrtimer_run_queues.hrtimer_interrupt
      0.00            +0.6        0.59 ±  7%  perf-profile.calltrace.cycles-pp.schedule.worker_thread.kthread.ret_from_fork
      2.10 ±  6%      +0.6        2.71 ±  8%  perf-profile.calltrace.cycles-pp.tick_sched_timer.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.asm_call_sysvec_on_stack
      0.00            +0.6        0.65 ±  5%  perf-profile.calltrace.cycles-pp.__schedule.schedule_idle.do_idle.cpu_startup_entry.start_secondary
      0.00            +0.7        0.65 ±  4%  perf-profile.calltrace.cycles-pp.__schedule.schedule.rwsem_down_read_slowpath.xfs_map_blocks.iomap_writepage_map
      0.00            +0.7        0.67 ±  3%  perf-profile.calltrace.cycles-pp.schedule_idle.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      3.14 ±  5%      +0.7        3.85 ±  5%  perf-profile.calltrace.cycles-pp.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.asm_call_sysvec_on_stack.sysvec_apic_timer_interrupt
      0.00            +0.8        0.75 ±  4%  perf-profile.calltrace.cycles-pp.enqueue_entity.enqueue_task_fair.ttwu_do_activate.try_to_wake_up.__queue_work
      0.00            +0.8        0.80 ±  3%  perf-profile.calltrace.cycles-pp.unwind_next_frame.arch_stack_walk.stack_trace_save_tsk.__account_scheduler_latency.enqueue_entity
      0.00            +0.8        0.81 ±  4%  perf-profile.calltrace.cycles-pp.enqueue_task_fair.ttwu_do_activate.try_to_wake_up.__queue_work.mod_delayed_work_on
      0.00            +0.8        0.83 ±  3%  perf-profile.calltrace.cycles-pp.ttwu_do_activate.try_to_wake_up.__queue_work.mod_delayed_work_on.kblockd_mod_delayed_work_on
      0.00            +1.0        0.96 ± 10%  perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.xfs_ilock.xfs_iomap_write_unwritten.xfs_end_ioend.xfs_end_io
      0.00            +1.1        1.05 ±  4%  perf-profile.calltrace.cycles-pp.xfs_btree_insrec.xfs_btree_insert.xfs_bmap_add_extent_unwritten_real.xfs_bmapi_convert_unwritten.xfs_bmapi_write
      0.00            +1.1        1.08 ±  3%  perf-profile.calltrace.cycles-pp.try_to_wake_up.__queue_work.mod_delayed_work_on.kblockd_mod_delayed_work_on.blk_mq_sched_insert_requests
      0.00            +1.1        1.11 ±  4%  perf-profile.calltrace.cycles-pp.xfs_btree_insert.xfs_bmap_add_extent_unwritten_real.xfs_bmapi_convert_unwritten.xfs_bmapi_write.xfs_iomap_write_unwritten
      0.00            +1.1        1.11 ± 10%  perf-profile.calltrace.cycles-pp.xfs_ilock.xfs_iomap_write_unwritten.xfs_end_ioend.xfs_end_io.process_one_work
      0.00            +1.2        1.16 ±  4%  perf-profile.calltrace.cycles-pp.__queue_work.mod_delayed_work_on.kblockd_mod_delayed_work_on.blk_mq_sched_insert_requests.blk_mq_flush_plug_list
     12.23 ±  2%      +1.2       13.40        perf-profile.calltrace.cycles-pp.xfs_iomap_write_unwritten.xfs_end_ioend.xfs_end_io.process_one_work.worker_thread
      0.00            +1.2        1.18 ±  4%  perf-profile.calltrace.cycles-pp.arch_stack_walk.stack_trace_save_tsk.__account_scheduler_latency.enqueue_entity.enqueue_task_fair
      0.00            +1.3        1.26 ±  4%  perf-profile.calltrace.cycles-pp.mod_delayed_work_on.kblockd_mod_delayed_work_on.blk_mq_sched_insert_requests.blk_mq_flush_plug_list.blk_flush_plug_list
      0.00            +1.3        1.27 ±  4%  perf-profile.calltrace.cycles-pp.kblockd_mod_delayed_work_on.blk_mq_sched_insert_requests.blk_mq_flush_plug_list.blk_flush_plug_list.schedule
      0.00            +1.4        1.35 ±  4%  perf-profile.calltrace.cycles-pp.blk_mq_sched_insert_requests.blk_mq_flush_plug_list.blk_flush_plug_list.schedule.rwsem_down_read_slowpath
      0.00            +1.4        1.37 ±  4%  perf-profile.calltrace.cycles-pp.blk_mq_flush_plug_list.blk_flush_plug_list.schedule.rwsem_down_read_slowpath.xfs_map_blocks
      0.00            +1.4        1.38 ±  4%  perf-profile.calltrace.cycles-pp.blk_flush_plug_list.schedule.rwsem_down_read_slowpath.xfs_map_blocks.iomap_writepage_map
      0.00            +1.4        1.43 ± 18%  perf-profile.calltrace.cycles-pp.stack_trace_save_tsk.__account_scheduler_latency.enqueue_entity.enqueue_task_fair.ttwu_do_activate
      0.00            +1.6        1.59 ±  4%  perf-profile.calltrace.cycles-pp.enqueue_entity.enqueue_task_fair.ttwu_do_activate.try_to_wake_up.wake_up_q
      0.00            +1.6        1.64 ±  4%  perf-profile.calltrace.cycles-pp.enqueue_task_fair.ttwu_do_activate.try_to_wake_up.wake_up_q.rwsem_wake
      0.00            +1.6        1.65 ±  4%  perf-profile.calltrace.cycles-pp.ttwu_do_activate.try_to_wake_up.wake_up_q.rwsem_wake.xfs_iunlock
      4.93 ± 10%      +1.7        6.67 ±  5%  perf-profile.calltrace.cycles-pp.menu_select.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      0.00            +2.0        1.97 ±  4%  perf-profile.calltrace.cycles-pp.__account_scheduler_latency.enqueue_entity.enqueue_task_fair.ttwu_do_activate.try_to_wake_up
      0.00            +2.1        2.08 ±  3%  perf-profile.calltrace.cycles-pp.schedule.rwsem_down_read_slowpath.xfs_map_blocks.iomap_writepage_map.write_cache_pages
      0.00            +2.1        2.12 ±  8%  perf-profile.calltrace.cycles-pp.poll_idle.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry
      0.00            +2.4        2.40 ±  2%  perf-profile.calltrace.cycles-pp.try_to_wake_up.wake_up_q.rwsem_wake.xfs_iunlock.xfs_iomap_write_unwritten
      0.00            +2.4        2.44 ±  2%  perf-profile.calltrace.cycles-pp.wake_up_q.rwsem_wake.xfs_iunlock.xfs_iomap_write_unwritten.xfs_end_ioend
      0.00            +2.7        2.73 ±  3%  perf-profile.calltrace.cycles-pp.rwsem_wake.xfs_iunlock.xfs_iomap_write_unwritten.xfs_end_ioend.xfs_end_io
      0.00            +2.8        2.80 ±  3%  perf-profile.calltrace.cycles-pp.xfs_iunlock.xfs_iomap_write_unwritten.xfs_end_ioend.xfs_end_io.process_one_work
     30.62 ±  6%      +4.1       34.76 ±  2%  perf-profile.calltrace.cycles-pp.intel_idle.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry
     13.75 ±  7%      +4.3       18.07 ±  7%  perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry
     44.69            +9.2       53.92        perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry.start_secondary
     46.17 ±  2%     +10.1       56.24        perf-profile.calltrace.cycles-pp.cpuidle_enter.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     51.80 ±  2%     +13.1       64.85        perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     51.82 ±  2%     +13.1       64.89        perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     51.82 ±  2%     +13.1       64.89        perf-profile.calltrace.cycles-pp.start_secondary.secondary_startup_64_no_verify
     52.27 ±  2%     +13.2       65.45        perf-profile.calltrace.cycles-pp.secondary_startup_64_no_verify
      8.01 ±  6%      -8.0        0.00        perf-profile.children.cycles-pp.rwsem_optimistic_spin
     31.37 ±  5%      -7.9       23.48 ±  2%  perf-profile.children.cycles-pp.kthread
     31.37 ±  5%      -7.9       23.48 ±  2%  perf-profile.children.cycles-pp.ret_from_fork
     14.20 ±  7%      -7.6        6.64 ±  3%  perf-profile.children.cycles-pp.wb_workfn
     14.20 ±  7%      -7.6        6.64 ±  3%  perf-profile.children.cycles-pp.wb_writeback
     14.20 ±  7%      -7.6        6.64 ±  3%  perf-profile.children.cycles-pp.__writeback_inodes_wb
     14.20 ±  7%      -7.6        6.64 ±  3%  perf-profile.children.cycles-pp.writeback_sb_inodes
     14.20 ±  7%      -7.6        6.64 ±  3%  perf-profile.children.cycles-pp.__writeback_single_inode
     14.20 ±  7%      -7.6        6.64 ±  3%  perf-profile.children.cycles-pp.do_writepages
     14.20 ±  7%      -7.6        6.64 ±  3%  perf-profile.children.cycles-pp.xfs_vm_writepages
     14.20 ±  7%      -7.6        6.64 ±  3%  perf-profile.children.cycles-pp.iomap_writepages
     14.20 ±  7%      -7.6        6.64 ±  3%  perf-profile.children.cycles-pp.write_cache_pages
     12.81 ±  7%      -7.2        5.58 ±  3%  perf-profile.children.cycles-pp.iomap_writepage_map
      7.42 ±  6%      -7.1        0.35 ± 10%  perf-profile.children.cycles-pp.rwsem_spin_on_owner
     29.14 ±  4%      -6.6       22.57 ±  2%  perf-profile.children.cycles-pp.process_one_work
     29.16 ±  4%      -5.9       23.29 ±  2%  perf-profile.children.cycles-pp.worker_thread
      8.70 ±  6%      -5.5        3.17 ±  4%  perf-profile.children.cycles-pp.xfs_map_blocks
      7.75 ±  6%      -5.4        2.38 ±  3%  perf-profile.children.cycles-pp.rwsem_down_read_slowpath
     14.73 ± 10%      -5.2        9.48 ±  7%  perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     14.62 ± 10%      -5.2        9.40 ±  7%  perf-profile.children.cycles-pp.do_syscall_64
     13.96 ± 11%      -5.2        8.81 ±  8%  perf-profile.children.cycles-pp.ksys_write
     13.88 ± 10%      -5.1        8.76 ±  8%  perf-profile.children.cycles-pp.vfs_write
     13.61 ± 11%      -5.0        8.59 ±  8%  perf-profile.children.cycles-pp.new_sync_write
     13.48 ± 11%      -5.0        8.49 ±  8%  perf-profile.children.cycles-pp.xfs_file_buffered_aio_write
     12.95 ± 11%      -4.8        8.16 ±  8%  perf-profile.children.cycles-pp.iomap_file_buffered_write
     12.93 ± 11%      -4.8        8.14 ±  8%  perf-profile.children.cycles-pp.iomap_apply
      9.88 ± 12%      -3.8        6.09 ±  8%  perf-profile.children.cycles-pp.iomap_write_actor
      4.28 ±  8%      -1.6        2.70 ± 12%  perf-profile.children.cycles-pp.iomap_write_begin
      4.15 ±  8%      -1.5        2.60 ± 12%  perf-profile.children.cycles-pp.grab_cache_page_write_begin
      4.12 ±  8%      -1.5        2.59 ± 12%  perf-profile.children.cycles-pp.pagecache_get_page
      7.27 ±  3%      -1.4        5.91        perf-profile.children.cycles-pp.xfs_bmapi_write
      1.38 ± 41%      -1.2        0.19 ± 22%  perf-profile.children.cycles-pp.xas_store
      2.47 ± 23%      -1.2        1.30 ±  4%  perf-profile.children.cycles-pp.iov_iter_copy_from_user_atomic
      2.25 ±  7%      -1.1        1.10 ±  3%  perf-profile.children.cycles-pp.iomap_submit_ioend
      2.23 ±  7%      -1.1        1.08 ±  3%  perf-profile.children.cycles-pp.submit_bio
      2.20 ±  7%      -1.1        1.06 ±  4%  perf-profile.children.cycles-pp.submit_bio_noacct
      2.64 ± 11%      -1.1        1.50 ± 10%  perf-profile.children.cycles-pp.iomap_write_end
      2.38 ± 25%      -1.1        1.25 ±  4%  perf-profile.children.cycles-pp.copyin
      2.37 ± 25%      -1.1        1.24 ±  4%  perf-profile.children.cycles-pp.copy_user_enhanced_fast_string
      2.90 ±  9%      -1.1        1.79 ±  7%  perf-profile.children.cycles-pp.xfs_iext_lookup_extent
      1.84 ±  7%      -1.0        0.81 ±  4%  perf-profile.children.cycles-pp.blk_mq_submit_bio
      6.07 ±  2%      -1.0        5.07        perf-profile.children.cycles-pp.xfs_bmapi_convert_unwritten
      2.90 ± 10%      -0.9        1.97 ±  9%  perf-profile.children.cycles-pp.xfs_buffered_write_iomap_begin
      5.80 ±  2%      -0.9        4.88 ±  2%  perf-profile.children.cycles-pp.xfs_bmap_add_extent_unwritten_real
      2.13 ±  8%      -0.9        1.26 ±  6%  perf-profile.children.cycles-pp.iomap_finish_ioends
      2.11 ±  8%      -0.9        1.25 ±  6%  perf-profile.children.cycles-pp.iomap_finish_ioend
      3.65 ±  2%      -0.8        2.90        perf-profile.children.cycles-pp.__xfs_trans_commit
      3.51 ±  2%      -0.7        2.78        perf-profile.children.cycles-pp.xfs_log_commit_cil
      2.14 ±  9%      -0.7        1.44 ± 14%  perf-profile.children.cycles-pp.xas_load
      1.74 ±  5%      -0.7        1.04 ± 12%  perf-profile.children.cycles-pp.add_to_page_cache_lru
      0.85 ±  4%      -0.7        0.18 ± 10%  perf-profile.children.cycles-pp.xfs_btree_delete
      0.84 ±  4%      -0.7        0.17 ± 11%  perf-profile.children.cycles-pp.xfs_btree_delrec
      1.28 ± 19%      -0.6        0.72 ± 12%  perf-profile.children.cycles-pp.iomap_set_range_uptodate
      1.72 ± 12%      -0.5        1.18 ± 14%  perf-profile.children.cycles-pp.find_get_entry
      1.26 ±  9%      -0.5        0.72 ± 10%  perf-profile.children.cycles-pp.iomap_set_page_dirty
      0.61 ±  8%      -0.5        0.10 ± 10%  perf-profile.children.cycles-pp.blk_mq_try_issue_list_directly
      1.83 ±  3%      -0.5        1.33 ±  3%  perf-profile.children.cycles-pp.xlog_cil_insert_items
      0.60 ±  8%      -0.5        0.10 ± 10%  perf-profile.children.cycles-pp.blk_mq_request_issue_directly
      1.37 ±  6%      -0.5        0.89 ±  5%  perf-profile.children.cycles-pp.xfs_buf_read_map
      1.24 ±  5%      -0.5        0.76 ± 14%  perf-profile.children.cycles-pp.__add_to_page_cache_locked
      0.58 ±  7%      -0.5        0.10 ±  8%  perf-profile.children.cycles-pp.__blk_mq_try_issue_directly
      1.22 ±  9%      -0.5        0.74 ±  8%  perf-profile.children.cycles-pp.end_page_writeback
      1.21 ±  9%      -0.5        0.74 ±  8%  perf-profile.children.cycles-pp.test_clear_page_writeback
      2.78 ±  3%      -0.4        2.33 ±  2%  perf-profile.children.cycles-pp.xfs_btree_lookup
      1.02 ±  8%      -0.4        0.58 ± 12%  perf-profile.children.cycles-pp.__set_page_dirty
      1.56 ±  5%      -0.4        1.20 ±  2%  perf-profile.children.cycles-pp.xfs_btree_lookup_get_block
      1.14 ±  6%      -0.4        0.77 ±  5%  perf-profile.children.cycles-pp.xfs_buf_get_map
      1.07 ±  7%      -0.4        0.72 ±  5%  perf-profile.children.cycles-pp.xfs_buf_find
      1.03 ± 10%      -0.4        0.68 ±  6%  perf-profile.children.cycles-pp.__test_set_page_writeback
      0.44 ±  5%      -0.3        0.10 ± 19%  perf-profile.children.cycles-pp.blk_attempt_plug_merge
      1.24 ±  4%      -0.3        0.90 ±  4%  perf-profile.children.cycles-pp.xfs_buf_item_format
      0.57 ±  3%      -0.3        0.23 ± 11%  perf-profile.children.cycles-pp.xfs_btree_readahead_lblock
      0.56 ±  3%      -0.3        0.23 ± 11%  perf-profile.children.cycles-pp.xfs_btree_reada_bufl
      0.54 ±  4%      -0.3        0.22 ± 12%  perf-profile.children.cycles-pp.xfs_buf_readahead_map
      0.64 ±  8%      -0.3        0.35 ± 12%  perf-profile.children.cycles-pp.__alloc_pages_nodemask
      0.33 ± 40%      -0.3        0.04 ± 59%  perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
      0.47            -0.3        0.19 ±  7%  perf-profile.children.cycles-pp.xfs_btree_decrement
      0.34 ± 10%      -0.3        0.08 ± 14%  perf-profile.children.cycles-pp.osq_lock
      0.57 ±  9%      -0.3        0.32 ± 12%  perf-profile.children.cycles-pp.get_page_from_freelist
      0.57 ±  7%      -0.2        0.32 ± 17%  perf-profile.children.cycles-pp.__xa_set_mark
      0.52 ±  9%      -0.2        0.29 ± 19%  perf-profile.children.cycles-pp.xas_set_mark
      0.46 ±  9%      -0.2        0.25 ±  7%  perf-profile.children.cycles-pp.__mod_memcg_lruvec_state
      0.48 ±  7%      -0.2        0.27 ± 10%  perf-profile.children.cycles-pp.lru_cache_add
      0.74 ±  4%      -0.2        0.55 ±  4%  perf-profile.children.cycles-pp.xfs_trans_alloc
      0.66 ±  2%      -0.2        0.46 ±  6%  perf-profile.children.cycles-pp.xfs_next_bit
      1.32 ±  8%      -0.2        1.13 ±  3%  perf-profile.children.cycles-pp.xfs_btree_read_buf_block
      0.26 ±  7%      -0.2        0.08 ± 10%  perf-profile.children.cycles-pp.xfs_iext_remove
      0.55 ± 14%      -0.2        0.38 ±  6%  perf-profile.children.cycles-pp.clear_page_dirty_for_io
      1.14 ±  9%      -0.2        0.96 ±  4%  perf-profile.children.cycles-pp.xfs_trans_read_buf_map
      0.41 ±  7%      -0.2        0.24 ±  7%  perf-profile.children.cycles-pp.pagevec_lru_move_fn
      0.83 ±  4%      -0.2        0.66 ±  2%  perf-profile.children.cycles-pp.xfs_buf_item_size_segment
      0.85 ±  4%      -0.2        0.68 ±  2%  perf-profile.children.cycles-pp.xfs_buf_item_size
      0.37 ±  8%      -0.2        0.21 ± 12%  perf-profile.children.cycles-pp.rmqueue
      0.50 ±  5%      -0.2        0.34 ±  5%  perf-profile.children.cycles-pp.kmem_cache_free
      0.59 ±  7%      -0.2        0.43 ±  8%  perf-profile.children.cycles-pp.find_get_pages_range_tag
      0.41 ±  4%      -0.2        0.26 ± 11%  perf-profile.children.cycles-pp.mem_cgroup_charge
      0.59 ±  7%      -0.2        0.44 ±  8%  perf-profile.children.cycles-pp.pagevec_lookup_range_tag
      0.24 ±  5%      -0.1        0.09 ±  7%  perf-profile.children.cycles-pp.xfs_btree_increment
      0.48 ±  8%      -0.1        0.34 ±  8%  perf-profile.children.cycles-pp.__irqentry_text_start
      0.52 ±  5%      -0.1        0.38 ±  5%  perf-profile.children.cycles-pp.xfs_trans_reserve
      0.33 ±  4%      -0.1        0.19 ±  5%  perf-profile.children.cycles-pp.__pagevec_lru_add_fn
      0.68 ±  5%      -0.1        0.54 ±  7%  perf-profile.children.cycles-pp.kmem_cache_alloc
      0.32 ± 18%      -0.1        0.18 ± 17%  perf-profile.children.cycles-pp.account_page_dirtied
      0.31 ±  8%      -0.1        0.18 ±  8%  perf-profile.children.cycles-pp.down_write
      0.43 ±  9%      -0.1        0.30 ±  9%  perf-profile.children.cycles-pp.mempool_alloc
      0.27 ±  8%      -0.1        0.15 ± 18%  perf-profile.children.cycles-pp.workingset_update_node
      0.31 ± 11%      -0.1        0.20 ±  7%  perf-profile.children.cycles-pp.xfs_file_aio_write_checks
      0.25 ± 17%      -0.1        0.15 ± 15%  perf-profile.children.cycles-pp.__mod_memcg_state
      0.22 ±  7%      -0.1        0.11 ± 14%  perf-profile.children.cycles-pp.rmqueue_bulk
      0.55 ±  6%      -0.1        0.45 ±  3%  perf-profile.children.cycles-pp.memcpy_erms
      0.41 ±  4%      -0.1        0.31 ±  6%  perf-profile.children.cycles-pp.xfs_log_reserve
      0.30 ±  7%      -0.1        0.20 ±  6%  perf-profile.children.cycles-pp.bio_free
      0.42 ± 11%      -0.1        0.32 ±  6%  perf-profile.children.cycles-pp.bio_alloc_bioset
      0.33 ±  2%      -0.1        0.23 ±  6%  perf-profile.children.cycles-pp.xfs_inode_item_format
      0.25 ± 15%      -0.1        0.15 ±  4%  perf-profile.children.cycles-pp.xfs_btree_del_cursor
      0.25 ±  7%      -0.1        0.15 ± 19%  perf-profile.children.cycles-pp.xfs_buf_trylock
      0.31 ± 21%      -0.1        0.21 ±  9%  perf-profile.children.cycles-pp.submit_bio_checks
      0.22 ±  7%      -0.1        0.12 ±  6%  perf-profile.children.cycles-pp.__might_sleep
      0.22 ± 13%      -0.1        0.12 ±  6%  perf-profile.children.cycles-pp.__list_del_entry_valid
      0.20 ± 12%      -0.1        0.10 ± 12%  perf-profile.children.cycles-pp.list_sort
      0.24 ±  8%      -0.1        0.15 ± 21%  perf-profile.children.cycles-pp.down_trylock
      0.25 ± 15%      -0.1        0.17 ±  9%  perf-profile.children.cycles-pp.__mod_lruvec_state
      0.23 ± 10%      -0.1        0.15 ± 12%  perf-profile.children.cycles-pp.__slab_free
      0.29 ±  9%      -0.1        0.21 ±  6%  perf-profile.children.cycles-pp.xfs_bmapi_finish
      0.25 ±  7%      -0.1        0.17 ± 16%  perf-profile.children.cycles-pp.xfs_buf_unlock
      0.25 ±  6%      -0.1        0.17 ± 11%  perf-profile.children.cycles-pp.xfs_buf_rele
      0.11 ±  4%      -0.1        0.04 ± 57%  perf-profile.children.cycles-pp.unlock_page
      0.35 ±  8%      -0.1        0.28 ±  4%  perf-profile.children.cycles-pp.xfs_buf_offset
      0.19 ± 11%      -0.1        0.11 ± 20%  perf-profile.children.cycles-pp.__xa_clear_mark
      0.28 ± 10%      -0.1        0.21 ±  4%  perf-profile.children.cycles-pp.xfs_trans_log_inode
      0.12 ± 23%      -0.1        0.05 ± 64%  perf-profile.children.cycles-pp.node_dirty_ok
      0.20 ± 16%      -0.1        0.12 ± 12%  perf-profile.children.cycles-pp.up_write
      0.17 ± 15%      -0.1        0.10 ± 11%  perf-profile.children.cycles-pp.xfs_trans_brelse
      0.23 ± 14%      -0.1        0.16 ± 13%  perf-profile.children.cycles-pp.bvec_alloc
      0.22 ± 18%      -0.1        0.15 ± 14%  perf-profile.children.cycles-pp.xfs_bmbt_to_iomap
      0.18 ±  5%      -0.1        0.12 ± 22%  perf-profile.children.cycles-pp.syscall_return_via_sysret
      0.24 ±  8%      -0.1        0.17 ± 19%  perf-profile.children.cycles-pp.arch_cpu_idle_enter
      0.23 ±  7%      -0.1        0.17 ± 20%  perf-profile.children.cycles-pp.tsc_verify_tsc_adjust
      0.16 ± 28%      -0.1        0.09 ±  8%  perf-profile.children.cycles-pp.___slab_alloc
      0.15 ±  5%      -0.1        0.08 ± 21%  perf-profile.children.cycles-pp.page_mapping
      0.20 ± 19%      -0.1        0.14 ± 10%  perf-profile.children.cycles-pp.__mod_node_page_state
      0.18 ± 18%      -0.1        0.12 ±  3%  perf-profile.children.cycles-pp.xfs_perag_get
      0.16 ±  5%      -0.1        0.10 ±  7%  perf-profile.children.cycles-pp.memset_erms
      0.17 ±  6%      -0.1        0.11 ± 14%  perf-profile.children.cycles-pp.nvme_pci_complete_rq
      0.14 ± 21%      -0.1        0.08 ± 10%  perf-profile.children.cycles-pp.xfs_trans_ijoin
      0.08 ± 13%      -0.1        0.03 ±100%  perf-profile.children.cycles-pp.xfs_iext_update_node
      0.21 ± 15%      -0.1        0.15 ±  9%  perf-profile.children.cycles-pp.xfs_bmbt_init_cursor
      0.12 ±  6%      -0.1        0.07 ±  7%  perf-profile.children.cycles-pp.get_mem_cgroup_from_mm
      0.21 ± 11%      -0.1        0.15 ±  4%  perf-profile.children.cycles-pp.xlog_ticket_alloc
      0.10 ± 15%      -0.1        0.04 ± 57%  perf-profile.children.cycles-pp.xas_start
      0.08 ± 19%      -0.1        0.03 ±100%  perf-profile.children.cycles-pp.xfs_vn_update_time
      0.28 ±  6%      -0.1        0.23 ±  5%  perf-profile.children.cycles-pp.nvme_map_data
      0.16 ± 12%      -0.1        0.10 ± 25%  perf-profile.children.cycles-pp.try_charge
      0.08 ± 19%      -0.1        0.03 ±100%  perf-profile.children.cycles-pp.xfs_file_write_iter
      0.08 ± 14%      -0.1        0.03 ±100%  perf-profile.children.cycles-pp.xfs_break_layouts
      0.07 ± 15%      -0.0        0.03 ±100%  perf-profile.children.cycles-pp.xfs_inode_item_format_data_fork
      0.14 ± 10%      -0.0        0.10 ±  9%  perf-profile.children.cycles-pp.dec_zone_page_state
      0.14 ± 13%      -0.0        0.10 ± 11%  perf-profile.children.cycles-pp.__blk_queue_split
      0.13 ± 12%      -0.0        0.09 ±  4%  perf-profile.children.cycles-pp.file_update_time
      0.12 ±  5%      -0.0        0.08 ± 16%  perf-profile.children.cycles-pp.up
      0.07 ±  7%      -0.0        0.03 ±100%  perf-profile.children.cycles-pp.kfree
      0.07 ±  7%      -0.0        0.03 ±100%  perf-profile.children.cycles-pp.xfs_isilocked
      0.10 ± 17%      -0.0        0.06 ±  7%  perf-profile.children.cycles-pp.xfs_mod_fdblocks
      0.24 ±  5%      -0.0        0.20 ±  8%  perf-profile.children.cycles-pp.xfs_verify_agbno
      0.09 ±  7%      -0.0        0.06 ± 58%  perf-profile.children.cycles-pp.xfs_trans_del_item
      0.10 ± 11%      -0.0        0.06 ± 16%  perf-profile.children.cycles-pp.xa_get_order
      0.09 ±  9%      -0.0        0.06 ± 15%  perf-profile.children.cycles-pp._atomic_dec_and_lock
      0.10 ± 19%      -0.0        0.07 ± 29%  perf-profile.children.cycles-pp.blk_mq_rq_ctx_init
      0.19 ±  7%      -0.0        0.16 ±  8%  perf-profile.children.cycles-pp.xfs_trans_log_buf
      0.10 ±  8%      -0.0        0.07 ± 11%  perf-profile.children.cycles-pp.__sb_start_write
      0.31            -0.0        0.28 ±  3%  perf-profile.children.cycles-pp.__xfs_btree_check_lblock
      0.09 ±  9%      -0.0        0.06 ± 11%  perf-profile.children.cycles-pp.xfs_log_ticket_ungrant
      0.15 ±  5%      -0.0        0.12 ±  8%  perf-profile.children.cycles-pp.xfs_trans_dirty_buf
      0.09 ±  8%      -0.0        0.07 ± 13%  perf-profile.children.cycles-pp.blk_throtl_bio
      0.07 ±  6%      -0.0        0.05        perf-profile.children.cycles-pp.xfs_iext_update_extent
      0.06 ± 11%      +0.0        0.08 ±  5%  perf-profile.children.cycles-pp.__list_add_valid
      0.06 ± 16%      +0.0        0.08        perf-profile.children.cycles-pp.rb_insert_color
      0.11 ±  9%      +0.0        0.14 ±  8%  perf-profile.children.cycles-pp.xfs_end_bio
      0.09 ±  7%      +0.0        0.12 ±  9%  perf-profile.children.cycles-pp.blk_mq_start_request
      0.09 ±  7%      +0.0        0.12 ± 10%  perf-profile.children.cycles-pp.rcu_eqs_enter
      0.23 ±  6%      +0.0        0.27 ±  4%  perf-profile.children.cycles-pp.hrtimer_next_event_without
      0.08 ± 19%      +0.0        0.12 ±  8%  perf-profile.children.cycles-pp._find_next_bit
      0.03 ±100%      +0.0        0.07 ±  6%  perf-profile.children.cycles-pp.xfs_btree_update_keys
      0.01 ±173%      +0.0        0.06 ±  9%  perf-profile.children.cycles-pp.rb_erase
      0.04 ± 58%      +0.0        0.09 ±  7%  perf-profile.children.cycles-pp.rcu_dynticks_eqs_exit
      0.11 ±  7%      +0.1        0.17 ±  7%  perf-profile.children.cycles-pp.cpuidle_governor_latency_req
      0.08 ± 17%      +0.1        0.14 ± 11%  perf-profile.children.cycles-pp.call_cpuidle
      0.06 ± 60%      +0.1        0.12 ± 13%  perf-profile.children.cycles-pp.cpumask_next_and
      0.00            +0.1        0.07 ±  6%  perf-profile.children.cycles-pp.blk_mq_flush_busy_ctxs
      0.00            +0.1        0.07 ± 10%  perf-profile.children.cycles-pp.update_cfs_rq_h_load
      0.00            +0.1        0.07 ± 10%  perf-profile.children.cycles-pp.ttwu_queue_wakelist
      0.00            +0.1        0.07 ±  5%  perf-profile.children.cycles-pp.__xfs_btree_split
      0.00            +0.1        0.07 ± 17%  perf-profile.children.cycles-pp.asm_sysvec_reschedule_ipi
      0.16 ±  7%      +0.1        0.23 ± 15%  perf-profile.children.cycles-pp.hrtimer_get_next_event
      0.00            +0.1        0.08 ±  6%  perf-profile.children.cycles-pp.check_preempt_wakeup
      0.00            +0.1        0.08 ± 14%  perf-profile.children.cycles-pp.__wrgsbase_inactive
      0.00            +0.1        0.08 ± 10%  perf-profile.children.cycles-pp.tick_nohz_idle_enter
      0.00            +0.1        0.08 ± 13%  perf-profile.children.cycles-pp.stack_access_ok
      0.00            +0.1        0.08 ± 13%  perf-profile.children.cycles-pp.wq_worker_running
      0.00            +0.1        0.08 ± 13%  perf-profile.children.cycles-pp.resched_curr
      0.09            +0.1        0.17 ±  4%  perf-profile.children.cycles-pp.xfs_iext_insert
      0.12 ±  7%      +0.1        0.20 ± 10%  perf-profile.children.cycles-pp._cond_resched
      0.71 ±  9%      +0.1        0.80 ±  4%  perf-profile.children.cycles-pp.rebalance_domains
      0.11 ± 15%      +0.1        0.20 ±  4%  perf-profile.children.cycles-pp.rcu_eqs_exit
      0.00            +0.1        0.10 ±  9%  perf-profile.children.cycles-pp.in_sched_functions
      0.00            +0.1        0.10 ±  4%  perf-profile.children.cycles-pp.xfs_btree_split_worker
      0.28 ± 11%      +0.1        0.38 ±  9%  perf-profile.children.cycles-pp._raw_spin_trylock
      0.00            +0.1        0.10 ± 10%  perf-profile.children.cycles-pp.__update_load_avg_se
      0.00            +0.1        0.10 ± 12%  perf-profile.children.cycles-pp.__sysvec_call_function_single
      0.00            +0.1        0.10 ± 21%  perf-profile.children.cycles-pp.__module_text_address
      0.00            +0.1        0.10 ± 10%  perf-profile.children.cycles-pp.__unwind_start
      0.00            +0.1        0.10 ± 14%  perf-profile.children.cycles-pp.preempt_schedule_common
      0.00            +0.1        0.10 ±  8%  perf-profile.children.cycles-pp.sysvec_call_function_single
      0.00            +0.1        0.11 ± 19%  perf-profile.children.cycles-pp.is_module_text_address
      0.00            +0.1        0.11 ±  7%  perf-profile.children.cycles-pp.tick_nohz_idle_exit
      0.21 ±  5%      +0.1        0.32 ±  4%  perf-profile.children.cycles-pp.rcu_idle_exit
      0.26 ±  7%      +0.1        0.37 ±  7%  perf-profile.children.cycles-pp.get_next_timer_interrupt
      0.00            +0.1        0.12 ± 27%  perf-profile.children.cycles-pp.rcu_gp_kthread
      0.00            +0.1        0.12 ±  6%  perf-profile.children.cycles-pp.asm_sysvec_call_function_single
      0.00            +0.1        0.12 ±  8%  perf-profile.children.cycles-pp.___perf_sw_event
      0.00            +0.1        0.14 ± 15%  perf-profile.children.cycles-pp.__module_address
      0.00            +0.1        0.15 ±  5%  perf-profile.children.cycles-pp.__update_load_avg_cfs_rq
      0.55 ±  5%      +0.2        0.70 ±  2%  perf-profile.children.cycles-pp.sched_clock_cpu
      0.47 ±  6%      +0.2        0.65 ±  4%  perf-profile.children.cycles-pp.native_sched_clock
      0.20 ± 18%      +0.2        0.37 ±  2%  perf-profile.children.cycles-pp.balance_dirty_pages_ratelimited
      0.00            +0.2        0.17 ± 10%  perf-profile.children.cycles-pp.xfs_btree_rshift
      0.00            +0.2        0.18 ± 11%  perf-profile.children.cycles-pp.flush_smp_call_function_from_idle
      0.00            +0.2        0.18 ±  8%  perf-profile.children.cycles-pp.update_curr
      0.20 ± 11%      +0.2        0.38 ± 12%  perf-profile.children.cycles-pp.rcu_sched_clock_irq
      0.00            +0.2        0.18 ± 10%  perf-profile.children.cycles-pp.kernel_text_address
      0.50 ±  6%      +0.2        0.68 ±  3%  perf-profile.children.cycles-pp.sched_clock
      0.05 ± 59%      +0.2        0.24 ± 11%  perf-profile.children.cycles-pp.rcu_core
      0.00            +0.2        0.19        perf-profile.children.cycles-pp.check_preempt_curr
      0.13 ±  9%      +0.2        0.33 ±  3%  perf-profile.children.cycles-pp.balance_dirty_pages
      0.00            +0.2        0.20 ± 10%  perf-profile.children.cycles-pp.note_gp_changes
      0.13 ± 14%      +0.2        0.33 ±  4%  perf-profile.children.cycles-pp.xfs_btree_lshift
      0.00            +0.2        0.21 ±  8%  perf-profile.children.cycles-pp.select_task_rq_fair
      0.11 ± 13%      +0.2        0.32 ± 11%  perf-profile.children.cycles-pp._raw_spin_lock_irq
      0.09 ± 20%      +0.2        0.30 ±  7%  perf-profile.children.cycles-pp.nr_iowait_cpu
      0.00            +0.2        0.21 ±  2%  perf-profile.children.cycles-pp.stack_trace_consume_entry_nosched
      0.00            +0.2        0.21 ±  6%  perf-profile.children.cycles-pp.ttwu_do_wakeup
      0.09 ± 21%      +0.2        0.30 ±  9%  perf-profile.children.cycles-pp.update_ts_time_stats
      0.00            +0.2        0.22 ± 11%  perf-profile.children.cycles-pp.finish_task_switch
      0.00            +0.2        0.22 ± 10%  perf-profile.children.cycles-pp.__kernel_text_address
      0.00            +0.2        0.23 ±  9%  perf-profile.children.cycles-pp.__switch_to_asm
      0.00            +0.2        0.24 ±  5%  perf-profile.children.cycles-pp.sched_ttwu_pending
      0.00            +0.2        0.24 ±  5%  perf-profile.children.cycles-pp.set_next_entity
      0.03 ±102%      +0.2        0.28 ±  2%  perf-profile.children.cycles-pp.io_schedule_timeout
      0.00            +0.2        0.25 ± 11%  perf-profile.children.cycles-pp.__switch_to
      0.00            +0.3        0.26 ±  6%  perf-profile.children.cycles-pp.rwsem_mark_wake
      0.00            +0.3        0.27 ±  5%  perf-profile.children.cycles-pp.unwind_get_return_address
      0.08 ± 20%      +0.3        0.36 ±  8%  perf-profile.children.cycles-pp.schedule_timeout
      0.13 ± 22%      +0.3        0.42 ±  7%  perf-profile.children.cycles-pp.idle_cpu
      0.00            +0.3        0.33        perf-profile.children.cycles-pp.dequeue_entity
      0.27 ±  7%      +0.3        0.61 ±  8%  perf-profile.children.cycles-pp.update_rq_clock
      0.00            +0.3        0.34 ±  3%  perf-profile.children.cycles-pp.update_load_avg
      0.87 ±  4%      +0.3        1.21 ±  6%  perf-profile.children.cycles-pp.scheduler_tick
      0.00            +0.4        0.35 ± 10%  perf-profile.children.cycles-pp.orc_find
      1.20 ±  6%      +0.4        1.56 ±  3%  perf-profile.children.cycles-pp.do_softirq_own_stack
      0.00            +0.4        0.36 ± 11%  perf-profile.children.cycles-pp.__orc_find
      1.19 ±  6%      +0.4        1.56 ±  3%  perf-profile.children.cycles-pp.__softirqentry_text_start
      0.00            +0.4        0.38 ±  2%  perf-profile.children.cycles-pp.dequeue_task_fair
      0.00            +0.4        0.43 ±  5%  perf-profile.children.cycles-pp.blk_mq_dispatch_rq_list
      0.00            +0.5        0.51 ±  2%  perf-profile.children.cycles-pp.__blk_mq_sched_dispatch_requests
      0.00            +0.5        0.52 ±  3%  perf-profile.children.cycles-pp.blk_mq_sched_dispatch_requests
      1.63 ±  3%      +0.5        2.15 ±  6%  perf-profile.children.cycles-pp.tick_sched_handle
      0.31 ± 18%      +0.5        0.83 ±  2%  perf-profile.children.cycles-pp.update_sd_lb_stats
      0.32 ± 17%      +0.5        0.85 ±  3%  perf-profile.children.cycles-pp.find_busiest_group
      0.00            +0.5        0.53 ±  4%  perf-profile.children.cycles-pp.xfs_btree_make_block_unfull
      0.00            +0.5        0.53 ±  2%  perf-profile.children.cycles-pp.__blk_mq_run_hw_queue
      1.58 ±  2%      +0.5        2.12 ±  6%  perf-profile.children.cycles-pp.update_process_times
      1.50 ±  6%      +0.5        2.03 ±  4%  perf-profile.children.cycles-pp.irq_exit_rcu
      0.42 ± 14%      +0.5        0.96 ±  2%  perf-profile.children.cycles-pp.load_balance
      0.10 ± 16%      +0.6        0.67 ±  2%  perf-profile.children.cycles-pp.newidle_balance
      2.19 ±  6%      +0.6        2.79 ±  8%  perf-profile.children.cycles-pp.tick_sched_timer
      0.00            +0.7        0.68 ±  4%  perf-profile.children.cycles-pp.schedule_idle
      3.26 ±  6%      +0.7        3.96 ±  5%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      0.29 ±  6%      +0.8        1.06 ±  3%  perf-profile.children.cycles-pp.xfs_btree_insrec
      0.31 ±  6%      +0.8        1.12 ±  4%  perf-profile.children.cycles-pp.xfs_btree_insert
      0.80 ± 12%      +0.8        1.62 ±  7%  perf-profile.children.cycles-pp.xfs_ilock
      0.61 ±  8%      +0.8        1.45 ±  3%  perf-profile.children.cycles-pp.blk_mq_sched_insert_requests
      0.62 ±  8%      +0.9        1.47 ±  4%  perf-profile.children.cycles-pp.blk_mq_flush_plug_list
      0.62 ±  9%      +0.9        1.48 ±  3%  perf-profile.children.cycles-pp.blk_flush_plug_list
      0.09 ± 23%      +0.9        1.04 ±  3%  perf-profile.children.cycles-pp.pick_next_task_fair
      0.44 ± 17%      +1.0        1.41 ±  7%  perf-profile.children.cycles-pp.rwsem_down_write_slowpath
     12.25 ±  2%      +1.2       13.41        perf-profile.children.cycles-pp.xfs_iomap_write_unwritten
      0.00            +1.2        1.19 ±  5%  perf-profile.children.cycles-pp.unwind_next_frame
      0.00            +1.2        1.22 ±  3%  perf-profile.children.cycles-pp.__queue_work
      0.00            +1.3        1.27 ±  4%  perf-profile.children.cycles-pp.mod_delayed_work_on
      0.00            +1.3        1.27 ±  4%  perf-profile.children.cycles-pp.kblockd_mod_delayed_work_on
      0.42 ± 10%      +1.7        2.16 ±  9%  perf-profile.children.cycles-pp.poll_idle
      4.96 ± 11%      +1.8        6.72 ±  5%  perf-profile.children.cycles-pp.menu_select
      0.01 ±173%      +1.8        1.84 ±  3%  perf-profile.children.cycles-pp.arch_stack_walk
      0.01 ±173%      +2.0        2.00 ±  3%  perf-profile.children.cycles-pp.stack_trace_save_tsk
      0.03 ±100%      +2.2        2.22 ±  4%  perf-profile.children.cycles-pp.__account_scheduler_latency
      0.15 ± 14%      +2.4        2.50 ±  2%  perf-profile.children.cycles-pp.__schedule
      0.00            +2.5        2.48 ±  2%  perf-profile.children.cycles-pp.wake_up_q
      0.06 ± 13%      +2.6        2.67 ±  3%  perf-profile.children.cycles-pp.enqueue_entity
      0.07 ± 14%      +2.7        2.78 ±  3%  perf-profile.children.cycles-pp.enqueue_task_fair
      0.30 ±  8%      +2.7        3.03 ±  3%  perf-profile.children.cycles-pp.xfs_iunlock
      0.07 ± 14%      +2.7        2.81 ±  3%  perf-profile.children.cycles-pp.ttwu_do_activate
      0.00            +2.8        2.79 ±  3%  perf-profile.children.cycles-pp.rwsem_wake
      0.12 ± 13%      +3.1        3.20 ±  3%  perf-profile.children.cycles-pp.schedule
     12.03 ±  7%      +3.4       15.39 ±  8%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
      0.10 ± 13%      +3.6        3.67 ±  2%  perf-profile.children.cycles-pp.try_to_wake_up
     30.81 ±  6%      +4.0       34.84 ±  2%  perf-profile.children.cycles-pp.intel_idle
     46.58 ±  2%     +10.1       56.71        perf-profile.children.cycles-pp.cpuidle_enter_state
     46.61 ±  2%     +10.1       56.75        perf-profile.children.cycles-pp.cpuidle_enter
     51.82 ±  2%     +13.1       64.89        perf-profile.children.cycles-pp.start_secondary
     52.27 ±  2%     +13.2       65.44        perf-profile.children.cycles-pp.do_idle
     52.27 ±  2%     +13.2       65.45        perf-profile.children.cycles-pp.secondary_startup_64_no_verify
     52.27 ±  2%     +13.2       65.45        perf-profile.children.cycles-pp.cpu_startup_entry
      7.25 ±  7%      -7.0        0.28 ±  6%  perf-profile.self.cycles-pp.rwsem_spin_on_owner
      2.36 ± 25%      -1.1        1.23 ±  4%  perf-profile.self.cycles-pp.copy_user_enhanced_fast_string
      2.85 ±  9%      -1.1        1.74 ±  7%  perf-profile.self.cycles-pp.xfs_iext_lookup_extent
      2.04 ±  9%      -0.6        1.40 ± 13%  perf-profile.self.cycles-pp.xas_load
      1.27 ± 19%      -0.6        0.72 ± 12%  perf-profile.self.cycles-pp.iomap_set_range_uptodate
      0.33 ± 40%      -0.3        0.04 ± 59%  perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
      0.34 ± 11%      -0.3        0.08 ± 11%  perf-profile.self.cycles-pp.osq_lock
      0.45 ± 16%      -0.2        0.22 ± 14%  perf-profile.self.cycles-pp.iomap_finish_ioend
      0.52 ±  9%      -0.2        0.29 ± 19%  perf-profile.self.cycles-pp.xas_set_mark
      0.58 ±  3%      -0.2        0.42 ±  5%  perf-profile.self.cycles-pp.xfs_next_bit
      0.49 ±  6%      -0.1        0.34 ±  7%  perf-profile.self.cycles-pp.find_get_pages_range_tag
      0.16 ±  5%      -0.1        0.03 ±100%  perf-profile.self.cycles-pp.xfs_iext_remove
      0.38 ±  8%      -0.1        0.24 ±  4%  perf-profile.self.cycles-pp.xfs_buf_find
      0.15 ± 10%      -0.1        0.03 ±100%  perf-profile.self.cycles-pp.blk_attempt_plug_merge
      0.26 ±  9%      -0.1        0.15 ± 18%  perf-profile.self.cycles-pp.workingset_update_node
      0.26 ± 15%      -0.1        0.15 ±  5%  perf-profile.self.cycles-pp.clear_page_dirty_for_io
      0.42 ±  4%      -0.1        0.32 ±  8%  perf-profile.self.cycles-pp.xfs_buf_item_format
      0.22            -0.1        0.11 ±  7%  perf-profile.self.cycles-pp.__mod_memcg_lruvec_state
      0.24 ± 16%      -0.1        0.14 ± 15%  perf-profile.self.cycles-pp.__mod_memcg_state
      0.22 ±  9%      -0.1        0.12 ± 13%  perf-profile.self.cycles-pp.down_write
      0.23 ± 16%      -0.1        0.13 ±  6%  perf-profile.self.cycles-pp.test_clear_page_writeback
      0.20 ± 12%      -0.1        0.11 ±  4%  perf-profile.self.cycles-pp.__list_del_entry_valid
      0.31 ±  9%      -0.1        0.23 ± 17%  perf-profile.self.cycles-pp.__test_set_page_writeback
      0.51 ±  6%      -0.1        0.43 ±  4%  perf-profile.self.cycles-pp.memcpy_erms
      0.22 ± 12%      -0.1        0.14 ± 15%  perf-profile.self.cycles-pp.__slab_free
      0.10 ± 22%      -0.1        0.03 ±100%  perf-profile.self.cycles-pp.unlock_page
      0.19 ± 15%      -0.1        0.12 ± 15%  perf-profile.self.cycles-pp.up_write
      0.18 ±  5%      -0.1        0.11 ± 21%  perf-profile.self.cycles-pp.syscall_return_via_sysret
      0.22 ±  9%      -0.1        0.15 ± 21%  perf-profile.self.cycles-pp.tsc_verify_tsc_adjust
      0.17 ± 11%      -0.1        0.10 ± 19%  perf-profile.self.cycles-pp.__add_to_page_cache_locked
      0.31 ±  6%      -0.1        0.24 ±  3%  perf-profile.self.cycles-pp.xfs_buf_item_size_segment
      0.16 ±  7%      -0.1        0.09 ± 11%  perf-profile.self.cycles-pp.rmqueue_bulk
      0.20 ± 18%      -0.1        0.14 ± 11%  perf-profile.self.cycles-pp.__mod_node_page_state
      0.16 ±  5%      -0.1        0.10 ± 13%  perf-profile.self.cycles-pp.__pagevec_lru_add_fn
      0.23 ±  7%      -0.1        0.17 ±  8%  perf-profile.self.cycles-pp.kmem_cache_free
      0.28 ±  6%      -0.1        0.22 ±  5%  perf-profile.self.cycles-pp.xfs_buf_offset
      0.18 ± 16%      -0.1        0.12 ± 20%  perf-profile.self.cycles-pp.xfs_bmbt_to_iomap
      0.16 ± 15%      -0.1        0.11 ±  7%  perf-profile.self.cycles-pp.__might_sleep
      0.14 ± 10%      -0.1        0.08 ± 21%  perf-profile.self.cycles-pp.page_mapping
      0.15 ± 16%      -0.1        0.10 ± 15%  perf-profile.self.cycles-pp.down_read
      0.08 ± 26%      -0.1        0.03 ±100%  perf-profile.self.cycles-pp.account_page_dirtied
      0.28 ±  4%      -0.1        0.22 ±  4%  perf-profile.self.cycles-pp.kmem_cache_alloc
      0.14 ±  5%      -0.1        0.09 ±  4%  perf-profile.self.cycles-pp.memset_erms
      0.08 ± 19%      -0.1        0.03 ±100%  perf-profile.self.cycles-pp.xfs_file_write_iter
      0.09 ± 15%      -0.1        0.04 ± 58%  perf-profile.self.cycles-pp.xas_start
      0.12 ±  3%      -0.1        0.07 ±  7%  perf-profile.self.cycles-pp.get_mem_cgroup_from_mm
      0.21 ±  6%      -0.1        0.16 ±  7%  perf-profile.self.cycles-pp.xfs_inode_item_format
      0.11 ± 17%      -0.1        0.06 ± 11%  perf-profile.self.cycles-pp.iomap_apply
      0.12 ±  9%      -0.0        0.07 ±  6%  perf-profile.self.cycles-pp.list_sort
      0.07 ± 17%      -0.0        0.03 ±100%  perf-profile.self.cycles-pp.iomap_write_end
      0.10 ± 15%      -0.0        0.05 ± 58%  perf-profile.self.cycles-pp.iov_iter_copy_from_user_atomic
      0.07 ± 15%      -0.0        0.03 ±100%  perf-profile.self.cycles-pp.xfs_file_llseek
      0.07 ± 24%      -0.0        0.03 ±100%  perf-profile.self.cycles-pp.xfs_file_buffered_aio_write
      0.07 ± 17%      -0.0        0.03 ±100%  perf-profile.self.cycles-pp.__entry_text_start
      0.16 ± 12%      -0.0        0.11 ± 14%  perf-profile.self.cycles-pp.xfs_trans_log_inode
      0.07 ±  6%      -0.0        0.03 ±100%  perf-profile.self.cycles-pp.try_charge
      0.12 ± 15%      -0.0        0.08 ±  8%  perf-profile.self.cycles-pp.__get_user_nocheck_1
      0.08 ±  5%      -0.0        0.04 ± 58%  perf-profile.self.cycles-pp.xfs_log_ticket_ungrant
      0.18 ±  6%      -0.0        0.14 ± 15%  perf-profile.self.cycles-pp.xfs_bmap_add_extent_unwritten_real
      0.09 ± 11%      -0.0        0.06 ± 14%  perf-profile.self.cycles-pp.rmqueue
      0.12 ± 14%      -0.0        0.08 ±  8%  perf-profile.self.cycles-pp.__blk_queue_split
      0.14 ± 12%      -0.0        0.11 ±  4%  perf-profile.self.cycles-pp.xfs_btree_lookup_get_block
      0.12 ± 13%      -0.0        0.09 ±  4%  perf-profile.self.cycles-pp.xfs_buffered_write_iomap_begin
      0.19 ±  5%      -0.0        0.16 ±  2%  perf-profile.self.cycles-pp.iomap_writepage_map
      0.10 ± 14%      -0.0        0.07 ± 10%  perf-profile.self.cycles-pp.iomap_write_actor
      0.08 ± 13%      -0.0        0.05 ±  8%  perf-profile.self.cycles-pp._atomic_dec_and_lock
      0.10 ± 14%      -0.0        0.07 ±  5%  perf-profile.self.cycles-pp.xfs_perag_get
      0.07 ±  7%      -0.0        0.04 ± 57%  perf-profile.self.cycles-pp.xfs_buf_get_map
      0.11 ±  7%      -0.0        0.09 ± 10%  perf-profile.self.cycles-pp.dec_zone_page_state
      0.07 ±  7%      -0.0        0.04 ± 58%  perf-profile.self.cycles-pp.xfs_perag_put
      0.08 ±  6%      -0.0        0.06 ± 11%  perf-profile.self.cycles-pp.xfs_errortag_test
      0.16 ±  8%      +0.0        0.18 ± 11%  perf-profile.self.cycles-pp.arch_scale_freq_tick
      0.04 ± 58%      +0.0        0.07 ± 10%  perf-profile.self.cycles-pp.__list_add_valid
      0.05 ± 60%      +0.0        0.08        perf-profile.self.cycles-pp.rb_insert_color
      0.08 ± 14%      +0.0        0.11 ± 14%  perf-profile.self.cycles-pp._find_next_bit
      0.07 ±  7%      +0.0        0.10 ±  4%  perf-profile.self.cycles-pp.xfs_iext_insert
      0.14 ± 22%      +0.0        0.18 ±  7%  perf-profile.self.cycles-pp.perf_mux_hrtimer_handler
      0.14 ± 16%      +0.0        0.19 ±  6%  perf-profile.self.cycles-pp.rwsem_down_read_slowpath
      0.01 ±173%      +0.0        0.06 ± 14%  perf-profile.self.cycles-pp.scheduler_tick
      0.04 ± 58%      +0.0        0.09 ±  9%  perf-profile.self.cycles-pp.rcu_dynticks_eqs_exit
      0.08 ± 17%      +0.1        0.13 ±  9%  perf-profile.self.cycles-pp.call_cpuidle
      0.01 ±173%      +0.1        0.07 ± 17%  perf-profile.self.cycles-pp.cpuidle_governor_latency_req
      0.00            +0.1        0.06 ± 14%  perf-profile.self.cycles-pp.in_sched_functions
      0.07 ± 13%      +0.1        0.12 ±  6%  perf-profile.self.cycles-pp.__softirqentry_text_start
      0.04 ± 57%      +0.1        0.10 ± 10%  perf-profile.self.cycles-pp.rcu_eqs_exit
      0.00            +0.1        0.06 ± 11%  perf-profile.self.cycles-pp.kernel_text_address
      0.00            +0.1        0.07 ± 13%  perf-profile.self.cycles-pp.schedule
      0.00            +0.1        0.07 ±  6%  perf-profile.self.cycles-pp.xfs_btree_insrec
      0.00            +0.1        0.07 ± 10%  perf-profile.self.cycles-pp.update_cfs_rq_h_load
      0.00            +0.1        0.07 ± 17%  perf-profile.self.cycles-pp.pick_next_task_fair
      0.00            +0.1        0.07 ±  5%  perf-profile.self.cycles-pp.finish_task_switch
      0.00            +0.1        0.07 ± 11%  perf-profile.self.cycles-pp.arch_stack_walk
      0.00            +0.1        0.07 ± 14%  perf-profile.self.cycles-pp.stack_access_ok
      0.00            +0.1        0.08 ± 14%  perf-profile.self.cycles-pp.__wrgsbase_inactive
      0.00            +0.1        0.08 ± 14%  perf-profile.self.cycles-pp.note_gp_changes
      0.00            +0.1        0.08 ± 10%  perf-profile.self.cycles-pp.__unwind_start
      0.00            +0.1        0.08 ± 14%  perf-profile.self.cycles-pp.dequeue_entity
      0.00            +0.1        0.08 ± 15%  perf-profile.self.cycles-pp.select_task_rq_fair
      0.00            +0.1        0.08 ± 13%  perf-profile.self.cycles-pp.resched_curr
      0.00            +0.1        0.09 ±  4%  perf-profile.self.cycles-pp.__account_scheduler_latency
      0.00            +0.1        0.10 ± 15%  perf-profile.self.cycles-pp.update_curr
      0.00            +0.1        0.10 ± 13%  perf-profile.self.cycles-pp.__update_load_avg_se
      0.28 ± 10%      +0.1        0.38 ±  9%  perf-profile.self.cycles-pp._raw_spin_trylock
      0.00            +0.1        0.10 ± 12%  perf-profile.self.cycles-pp.___perf_sw_event
      0.00            +0.1        0.11 ± 17%  perf-profile.self.cycles-pp.enqueue_task_fair
      0.00            +0.1        0.11 ±  3%  perf-profile.self.cycles-pp.stack_trace_consume_entry_nosched
      0.00            +0.1        0.12 ±  4%  perf-profile.self.cycles-pp.update_load_avg
      0.00            +0.1        0.14 ± 15%  perf-profile.self.cycles-pp.__module_address
      0.00            +0.1        0.14 ±  7%  perf-profile.self.cycles-pp.stack_trace_save_tsk
      0.00            +0.1        0.14 ± 14%  perf-profile.self.cycles-pp.set_next_entity
      0.00            +0.1        0.14 ±  9%  perf-profile.self.cycles-pp.__update_load_avg_cfs_rq
      0.18 ±  8%      +0.2        0.33 ± 13%  perf-profile.self.cycles-pp.rcu_sched_clock_irq
      0.00            +0.2        0.16 ± 13%  perf-profile.self.cycles-pp.try_to_wake_up
      0.00            +0.2        0.16 ±  4%  perf-profile.self.cycles-pp.orc_find
      0.46 ±  6%      +0.2        0.62 ±  4%  perf-profile.self.cycles-pp.native_sched_clock
      1.02 ±  6%      +0.2        1.20 ±  7%  perf-profile.self.cycles-pp._raw_spin_lock
      0.20 ±  4%      +0.2        0.38 ±  5%  perf-profile.self.cycles-pp.do_idle
      0.00            +0.2        0.19 ±  8%  perf-profile.self.cycles-pp.enqueue_entity
      0.00            +0.2        0.21 ±  5%  perf-profile.self.cycles-pp.rwsem_mark_wake
      0.09 ± 24%      +0.2        0.30 ±  6%  perf-profile.self.cycles-pp.nr_iowait_cpu
      0.10 ±  7%      +0.2        0.32 ± 11%  perf-profile.self.cycles-pp._raw_spin_lock_irq
      0.00            +0.2        0.23 ± 10%  perf-profile.self.cycles-pp.__switch_to
      0.00            +0.2        0.23 ±  9%  perf-profile.self.cycles-pp.__switch_to_asm
      0.06 ± 17%      +0.3        0.32 ± 11%  perf-profile.self.cycles-pp.update_rq_clock
      0.12 ± 21%      +0.3        0.41 ±  6%  perf-profile.self.cycles-pp.idle_cpu
      0.00            +0.3        0.33 ±  7%  perf-profile.self.cycles-pp.__schedule
      0.21 ± 19%      +0.4        0.57 ±  2%  perf-profile.self.cycles-pp.update_sd_lb_stats
      0.00            +0.4        0.36 ± 11%  perf-profile.self.cycles-pp.__orc_find
      0.00            +0.5        0.51 ±  4%  perf-profile.self.cycles-pp.unwind_next_frame
      0.00            +0.9        0.90 ± 10%  perf-profile.self.cycles-pp.rwsem_down_write_slowpath
      2.50 ± 23%      +1.6        4.11 ±  6%  perf-profile.self.cycles-pp.menu_select
      0.34 ± 12%      +1.7        2.02 ±  9%  perf-profile.self.cycles-pp.poll_idle
      3.77 ± 21%      +1.8        5.52 ±  8%  perf-profile.self.cycles-pp.cpuidle_enter_state
     30.80 ±  6%      +4.0       34.84 ±  2%  perf-profile.self.cycles-pp.intel_idle



Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


Thanks,
Oliver Sang


--u3/rZRmxL6MmkK24
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="config-5.10.0-rc3-00006-g10a59003d29f"

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

--u3/rZRmxL6MmkK24
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=job-script

#!/bin/sh

export_top_env()
{
	export suite='unixbench'
	export testcase='unixbench'
	export category='benchmark'
	export runtime=300
	export nr_task=4
	export job_origin='/lkp-src/allot/cyclic:p1:linux-devel:devel-hourly/lkp-cfl-e1/unixbench.yaml'
	export queue_cmdline_keys='branch
commit
queue_at_least_once'
	export queue='validate'
	export testbox='lkp-cfl-e1'
	export tbox_group='lkp-cfl-e1'
	export kconfig='x86_64-rhel-8.3'
	export submit_id='5fb9b854451f834099366221'
	export job_file='/lkp/jobs/scheduled/lkp-cfl-e1/unixbench-performance-30%-300s-shell8-ucode=0xde-monitor=6e02c248-debian-10.4-x86_64-20200603.cgz-10a59003d29fbfa855b2ef4f3534fe-20201122-16537-2gce0o-2.yaml'
	export id='48c969848311564027959781a18fef14c3339069'
	export queuer_version='/lkp-src'
	export model='Coffee Lake'
	export nr_node=1
	export nr_cpu=16
	export memory='32G'
	export nr_hdd_partitions=1
	export hdd_partitions='/dev/disk/by-id/ata-WDC_WD20EZRX-00D8PB0_WD-WCC4M5CEX6NU-part2'
	export swap_partitions='LABEL=SWAP'
	export rootfs_partition='/dev/disk/by-id/ata-WDC_WD20EZRX-00D8PB0_WD-WCC4M5CEX6NU-part1'
	export brand='Intel(R) Xeon(R) E-2278G CPU @ 3.40GHz'
	export commit='10a59003d29fbfa855b2ef4f3534fee9bdf4e575'
	export ucode='0xde'
	export need_kconfig_hw='CONFIG_IGB=y
CONFIG_SATA_AHCI'
	export enqueue_time='2020-11-22 09:01:08 +0800'
	export _id='5fb9b854451f834099366221'
	export _rt='/result/unixbench/performance-30%-300s-shell8-ucode=0xde-monitor=6e02c248/lkp-cfl-e1/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/10a59003d29fbfa855b2ef4f3534fee9bdf4e575'
	export user='lkp'
	export compiler='gcc-9'
	export head_commit='d026633165036431cb53fd5c50f39d2cb7f5e913'
	export base_commit='09162bc32c880a791c6c0668ce0745cf7958f576'
	export branch='linux-review/Waiman-Long/locking-rwsem-Rework-reader-optimistic-spinning/20201121-122118'
	export rootfs='debian-10.4-x86_64-20200603.cgz'
	export monitor_sha='6e02c248'
	export result_root='/result/unixbench/performance-30%-300s-shell8-ucode=0xde-monitor=6e02c248/lkp-cfl-e1/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/10a59003d29fbfa855b2ef4f3534fee9bdf4e575/3'
	export scheduler_version='/lkp/lkp/.src-20201120-230606'
	export LKP_SERVER='internal-lkp-server'
	export arch='x86_64'
	export max_uptime=3600
	export initrd='/osimage/debian/debian-10.4-x86_64-20200603.cgz'
	export bootloader_append='root=/dev/ram0
user=lkp
job=/lkp/jobs/scheduled/lkp-cfl-e1/unixbench-performance-30%-300s-shell8-ucode=0xde-monitor=6e02c248-debian-10.4-x86_64-20200603.cgz-10a59003d29fbfa855b2ef4f3534fe-20201122-16537-2gce0o-2.yaml
ARCH=x86_64
kconfig=x86_64-rhel-8.3
branch=linux-review/Waiman-Long/locking-rwsem-Rework-reader-optimistic-spinning/20201121-122118
commit=10a59003d29fbfa855b2ef4f3534fee9bdf4e575
BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3/gcc-9/10a59003d29fbfa855b2ef4f3534fee9bdf4e575/vmlinuz-5.10.0-rc3-00006-g10a59003d29f
max_uptime=3600
RESULT_ROOT=/result/unixbench/performance-30%-300s-shell8-ucode=0xde-monitor=6e02c248/lkp-cfl-e1/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/10a59003d29fbfa855b2ef4f3534fee9bdf4e575/3
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
	export modules_initrd='/pkg/linux/x86_64-rhel-8.3/gcc-9/10a59003d29fbfa855b2ef4f3534fee9bdf4e575/modules.cgz'
	export bm_initrd='/osimage/deps/debian-10.4-x86_64-20200603.cgz/run-ipconfig_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/lkp_20200709.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/rsync-rootfs_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/unixbench_20201007.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/unixbench-x86_64-070030e-1_20201007.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/mpstat_20200714.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/perf_20200723.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/perf-x86_64-eccc87672492-1_20201111.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/sar-x86_64-34c92ae-1_20200702.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/hw_20200715.cgz'
	export ucode_initrd='/osimage/ucode/intel-ucode-20201117.cgz'
	export lkp_initrd='/osimage/user/lkp/lkp-x86_64.cgz'
	export site='inn'
	export LKP_CGI_PORT=80
	export LKP_CIFS_PORT=139
	export last_kernel='5.10.0-rc4-07335-gd02663316503'
	export repeat_to=4
	export schedule_notify_address=
	export queue_at_least_once=1
	export kernel='/pkg/linux/x86_64-rhel-8.3/gcc-9/10a59003d29fbfa855b2ef4f3534fee9bdf4e575/vmlinuz-5.10.0-rc3-00006-g10a59003d29f'
	export dequeue_time='2020-11-22 09:10:04 +0800'
	export job_initrd='/lkp/jobs/scheduled/lkp-cfl-e1/unixbench-performance-30%-300s-shell8-ucode=0xde-monitor=6e02c248-debian-10.4-x86_64-20200603.cgz-10a59003d29fbfa855b2ef4f3534fe-20201122-16537-2gce0o-2.cgz'

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

	run_test test='shell8' $LKP_SRC/tests/wrapper unixbench
}

extract_stats()
{
	export stats_part_begin=
	export stats_part_end=

	$LKP_SRC/stats/wrapper unixbench
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

	$LKP_SRC/stats/wrapper time unixbench.time
	$LKP_SRC/stats/wrapper dmesg
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper last_state
	$LKP_SRC/stats/wrapper stderr
	$LKP_SRC/stats/wrapper time
}

"$@"

--u3/rZRmxL6MmkK24
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="job.yaml"

---

#! jobs/unixbench.yaml
suite: unixbench
testcase: unixbench
category: benchmark
runtime: 300s
nr_task: 30%
unixbench:
  test: shell8
job_origin: "/lkp-src/allot/cyclic:p1:linux-devel:devel-hourly/lkp-cfl-e1/unixbench.yaml"

#! queue options
queue_cmdline_keys:
- branch
- commit
- queue_at_least_once
queue: bisect
testbox: lkp-cfl-e1
tbox_group: lkp-cfl-e1
kconfig: x86_64-rhel-8.3
submit_id: 5fb9a9fd451f833cb64bba0a
job_file: "/lkp/jobs/scheduled/lkp-cfl-e1/unixbench-performance-30%-300s-shell8-ucode=0xde-monitor=6e02c248-debian-10.4-x86_64-20200603.cgz-10a59003d29fbfa855b2ef4f3534fe-20201122-15542-1jor0xb-1.yaml"
id: 0c2aa8035dc3c9ecbbec24181476b6a7cf5888cb
queuer_version: "/lkp-src"

#! hosts/lkp-cfl-e1
model: Coffee Lake
nr_node: 1
nr_cpu: 16
memory: 32G
nr_hdd_partitions: 1
hdd_partitions: "/dev/disk/by-id/ata-WDC_WD20EZRX-00D8PB0_WD-WCC4M5CEX6NU-part2"
swap_partitions: LABEL=SWAP
rootfs_partition: "/dev/disk/by-id/ata-WDC_WD20EZRX-00D8PB0_WD-WCC4M5CEX6NU-part1"
brand: Intel(R) Xeon(R) E-2278G CPU @ 3.40GHz

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
commit: 10a59003d29fbfa855b2ef4f3534fee9bdf4e575

#! include/testbox/lkp-cfl-e1
ucode: '0xde'
need_kconfig_hw:
- CONFIG_IGB=y
- CONFIG_SATA_AHCI
enqueue_time: 2020-11-22 07:59:57.965899438 +08:00
_id: 5fb9aa00451f833cb64bba0b
_rt: "/result/unixbench/performance-30%-300s-shell8-ucode=0xde-monitor=6e02c248/lkp-cfl-e1/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/10a59003d29fbfa855b2ef4f3534fee9bdf4e575"

#! schedule options
user: lkp
compiler: gcc-9
head_commit: d026633165036431cb53fd5c50f39d2cb7f5e913
base_commit: '09162bc32c880a791c6c0668ce0745cf7958f576'
branch: linux-devel/devel-hourly-2020112115
rootfs: debian-10.4-x86_64-20200603.cgz
monitor_sha: 6e02c248
result_root: "/result/unixbench/performance-30%-300s-shell8-ucode=0xde-monitor=6e02c248/lkp-cfl-e1/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/10a59003d29fbfa855b2ef4f3534fee9bdf4e575/0"
scheduler_version: "/lkp/lkp/.src-20201120-230606"
LKP_SERVER: internal-lkp-server
arch: x86_64
max_uptime: 3600
initrd: "/osimage/debian/debian-10.4-x86_64-20200603.cgz"
bootloader_append:
- root=/dev/ram0
- user=lkp
- job=/lkp/jobs/scheduled/lkp-cfl-e1/unixbench-performance-30%-300s-shell8-ucode=0xde-monitor=6e02c248-debian-10.4-x86_64-20200603.cgz-10a59003d29fbfa855b2ef4f3534fe-20201122-15542-1jor0xb-1.yaml
- ARCH=x86_64
- kconfig=x86_64-rhel-8.3
- branch=linux-devel/devel-hourly-2020112115
- commit=10a59003d29fbfa855b2ef4f3534fee9bdf4e575
- BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3/gcc-9/10a59003d29fbfa855b2ef4f3534fee9bdf4e575/vmlinuz-5.10.0-rc3-00006-g10a59003d29f
- max_uptime=3600
- RESULT_ROOT=/result/unixbench/performance-30%-300s-shell8-ucode=0xde-monitor=6e02c248/lkp-cfl-e1/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/10a59003d29fbfa855b2ef4f3534fee9bdf4e575/0
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
modules_initrd: "/pkg/linux/x86_64-rhel-8.3/gcc-9/10a59003d29fbfa855b2ef4f3534fee9bdf4e575/modules.cgz"
bm_initrd: "/osimage/deps/debian-10.4-x86_64-20200603.cgz/run-ipconfig_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/lkp_20200709.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/rsync-rootfs_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/unixbench_20201007.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/unixbench-x86_64-070030e-1_20201007.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/mpstat_20200714.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/perf_20200723.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/perf-x86_64-eccc87672492-1_20201111.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/sar-x86_64-34c92ae-1_20200702.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/hw_20200715.cgz"
ucode_initrd: "/osimage/ucode/intel-ucode-20201117.cgz"
lkp_initrd: "/osimage/user/lkp/lkp-x86_64.cgz"
site: inn

#! /lkp/lkp/.src-20201120-230606/include/site/inn
LKP_CGI_PORT: 80
LKP_CIFS_PORT: 139
oom-killer: 
watchdog: 

#! runtime status
last_kernel: 5.10.0-rc4-07765-gf3fdd0e40026
repeat_to: 2
schedule_notify_address: 

#! user overrides
queue_at_least_once: 0
kernel: "/pkg/linux/x86_64-rhel-8.3/gcc-9/10a59003d29fbfa855b2ef4f3534fee9bdf4e575/vmlinuz-5.10.0-rc3-00006-g10a59003d29f"
dequeue_time: 2020-11-22 08:03:00.010728468 +08:00
job_state: finished
loadavg: 18.48 6.02 2.12 1/230 8223
start_time: '1606003185'
end_time: '1606003248'
version: "/lkp/lkp/.src-20201120-230655:3a1f47e8:44c9c7c85"

--u3/rZRmxL6MmkK24
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=reproduce


for cpu_dir in /sys/devices/system/cpu/cpu[0-9]*
do
	online_file="$cpu_dir"/online
	[ -f "$online_file" ] && [ "$(cat "$online_file")" -eq 0 ] && continue

	file="$cpu_dir"/cpufreq/scaling_governor
	[ -f "$file" ] && echo "performance" > "$file"
done

 "./Run" "shell8" "-c" "4" "-i" "1"

--u3/rZRmxL6MmkK24--
