Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A5F72F078E
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jan 2021 15:21:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726479AbhAJOSO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jan 2021 09:18:14 -0500
Received: from mga04.intel.com ([192.55.52.120]:2913 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726250AbhAJOSM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jan 2021 09:18:12 -0500
IronPort-SDR: 077rFUMp9ThpOHQ+yyManIz7zM0hAshQRjceyTjydgL1VEvS6vImtAvDfdzi0otkgxDGmLp9FU
 u9ZuaX5QclOg==
X-IronPort-AV: E=McAfee;i="6000,8403,9859"; a="175185755"
X-IronPort-AV: E=Sophos;i="5.79,336,1602572400"; 
   d="yaml'?scan'208";a="175185755"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2021 06:17:22 -0800
IronPort-SDR: mq8PexaqGl+g/+zzn4G58PEc9tSsFq2VxRd+umGqGAps+fZR9ydt/NZCRDczS8HwkaSCU5HiTU
 QMZXJKNDHfYw==
X-IronPort-AV: E=Sophos;i="5.79,336,1602572400"; 
   d="yaml'?scan'208";a="380712047"
Received: from xsang-optiplex-9020.sh.intel.com (HELO xsang-OptiPlex-9020) ([10.239.159.140])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2021 06:17:18 -0800
Date:   Sun, 10 Jan 2021 22:32:47 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Veronika Kabatova <vkabatov@redhat.com>,
        Christoph Hellwig <hch@lst.de>, Tejun Heo <tj@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Bart Van Assche <bvanassche@acm.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com, ying.huang@intel.com, feng.tang@intel.com,
        zhengjun.xing@intel.com
Subject: [percpu_ref]  2b0d3d3e4f:  reaim.jobs_per_min -18.4% regression
Message-ID: <20210110143247.GA6259@xsang-OptiPlex-9020>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="OXfL5xGRrasGEqWY"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: NeoMutt/20170113 (1.7.2)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit


Greeting,

FYI, we noticed a -18.4% regression of reaim.jobs_per_min due to commit:


commit: 2b0d3d3e4fcfb19d10f9a82910b8f0f05c56ee3e ("percpu_ref: reduce memory footprint of percpu_ref in fast path")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master


in testcase: reaim
on test machine: 192 threads Intel(R) Xeon(R) Platinum 9242 CPU @ 2.30GHz with 192G memory
with following parameters:

	runtime: 300s
	nr_task: 100%
	test: short
	cpufreq_governor: performance
	ucode: 0x5002f01

test-description: REAIM is an updated and improved version of AIM 7 benchmark.
test-url: https://sourceforge.net/projects/re-aim-7/

In addition to that, the commit also has significant impact on the following tests:

+------------------+---------------------------------------------------------------------------+
| testcase: change | vm-scalability: vm-scalability.throughput -2.8% regression                |
| test machine     | 192 threads Intel(R) Xeon(R) Platinum 9242 CPU @ 2.30GHz with 192G memory |
| test parameters  | cpufreq_governor=performance                                              |
|                  | runtime=300s                                                              |
|                  | test=lru-file-mmap-read-rand                                              |
|                  | ucode=0x5003003                                                           |
+------------------+---------------------------------------------------------------------------+
| testcase: change | will-it-scale: will-it-scale.per_process_ops 14.5% improvement            |
| test machine     | 144 threads Intel(R) Xeon(R) CPU E7-8890 v3 @ 2.50GHz with 512G memory    |
| test parameters  | cpufreq_governor=performance                                              |
|                  | mode=process                                                              |
|                  | nr_task=50%                                                               |
|                  | test=page_fault2                                                          |
|                  | ucode=0x16                                                                |
+------------------+---------------------------------------------------------------------------+
| testcase: change | will-it-scale: will-it-scale.per_process_ops -13.0% regression            |
| test machine     | 104 threads Skylake with 192G memory                                      |
| test parameters  | cpufreq_governor=performance                                              |
|                  | mode=process                                                              |
|                  | nr_task=50%                                                               |
|                  | test=malloc1                                                              |
|                  | ucode=0x2006906                                                           |
+------------------+---------------------------------------------------------------------------+
| testcase: change | vm-scalability: vm-scalability.throughput -2.3% regression                |
| test machine     | 96 threads Intel(R) Xeon(R) CPU @ 2.30GHz with 128G memory                |
| test parameters  | cpufreq_governor=performance                                              |
|                  | runtime=300s                                                              |
|                  | test=lru-file-mmap-read-rand                                              |
|                  | ucode=0x5002f01                                                           |
+------------------+---------------------------------------------------------------------------+
| testcase: change | fio-basic: fio.read_iops -4.8% regression                                 |
| test machine     | 192 threads Intel(R) Xeon(R) Platinum 9242 CPU @ 2.30GHz with 192G memory |
| test parameters  | bs=4k                                                                     |
|                  | cpufreq_governor=performance                                              |
|                  | disk=2pmem                                                                |
|                  | fs=xfs                                                                    |
|                  | ioengine=libaio                                                           |
|                  | nr_task=50%                                                               |
|                  | runtime=200s                                                              |
|                  | rw=randread                                                               |
|                  | test_size=200G                                                            |
|                  | time_based=tb                                                             |
|                  | ucode=0x5002f01                                                           |
+------------------+---------------------------------------------------------------------------+
| testcase: change | stress-ng: stress-ng.stackmmap.ops_per_sec -45.4% regression              |
| test machine     | 96 threads Intel(R) Xeon(R) Gold 6252 CPU @ 2.10GHz with 256G memory      |
| test parameters  | class=memory                                                              |
|                  | cpufreq_governor=performance                                              |
|                  | disk=1HDD                                                                 |
|                  | nr_threads=100%                                                           |
|                  | testtime=10s                                                              |
|                  | ucode=0x5002f01                                                           |
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
  gcc-9/performance/x86_64-rhel-8.3/100%/debian-10.4-x86_64-20200603.cgz/300s/lkp-csl-2ap3/short/reaim/0x5002f01

commit: 
  cf785af193 ("block: warn if !__GFP_DIRECT_RECLAIM in bio_crypt_set_ctx()")
  2b0d3d3e4f ("percpu_ref: reduce memory footprint of percpu_ref in fast path")

cf785af19319f9fc 2b0d3d3e4fcfb19d10f9a82910b 
---------------- --------------------------- 
       fail:runs  %reproduction    fail:runs
           |             |             |    
          0:4           -3%           0:4     perf-profile.children.cycles-pp.error_entry
          0:4           -3%           0:4     perf-profile.self.cycles-pp.error_entry
         %stddev     %change         %stddev
             \          |                \  
  11528218 ±  4%     -18.4%    9411679 ±  4%  reaim.jobs_per_min
     60042 ±  4%     -18.4%      49019 ±  4%  reaim.jobs_per_min_child
      0.10 ±  5%     +22.4%       0.13 ±  3%  reaim.parent_time
    174625            -2.0%     171063        reaim.time.major_page_faults
 1.513e+10 ±147%     -94.5%  8.371e+08 ± 62%  cpuidle.C6.time
   1016862 ± 55%     -70.9%     296190 ± 10%  cpuidle.POLL.time
    145649 ± 16%     -30.6%     101128 ±  6%  cpuidle.POLL.usage
      1570 ±  4%     +50.8%       2367 ± 32%  numa-vmstat.node1.nr_mapped
    240.50 ± 46%    +150.9%     603.50 ± 34%  numa-vmstat.node2.nr_active_anon
    240.50 ± 46%    +150.9%     603.50 ± 34%  numa-vmstat.node2.nr_zone_active_anon
      6155           +53.8%       9468 ± 32%  numa-meminfo.node1.Mapped
    963.75 ± 46%    +150.6%       2415 ± 34%  numa-meminfo.node2.Active
    963.75 ± 46%    +150.5%       2414 ± 34%  numa-meminfo.node2.Active(anon)
    712842 ± 18%     +24.0%     884148 ± 22%  numa-meminfo.node2.MemUsed
      7.84 ± 10%    +165.6%      20.82 ± 47%  sched_debug.cfs_rq:/.load_avg.avg
     54.83 ± 20%    +266.1%     200.73 ± 70%  sched_debug.cfs_rq:/.load_avg.stddev
      3396 ± 10%     +23.3%       4186 ± 10%  sched_debug.cpu.sched_count.stddev
      1690 ±  9%     +22.6%       2073 ± 10%  sched_debug.cpu.sched_goidle.stddev
      2.95 ± 72%      -1.3        1.65        perf-stat.i.branch-miss-rate%
     22.55 ± 36%      +9.7       32.23 ±  9%  perf-stat.i.cache-miss-rate%
    218409 ±103%     -65.0%      76415 ±  3%  perf-stat.i.dTLB-store-misses
   9803231 ±  8%      +7.7%   10559584        perf-stat.i.iTLB-load-misses
    585.32 ±  9%      -8.5%     535.65 ±  2%  perf-stat.i.instructions-per-iTLB-miss
    578.76            -1.9%     567.72        perf-stat.i.major-faults
     90.03            +1.7       91.72        perf-stat.i.node-load-miss-rate%
   2123315 ± 13%     +42.7%    3029950 ± 12%  perf-stat.i.node-load-misses
    216902 ±  4%     +20.4%     261168 ±  5%  perf-stat.i.node-loads
     82.94 ±  2%      +3.9       86.81        perf-stat.i.node-store-miss-rate%
   1453851 ± 11%     +21.5%    1766524 ±  8%  perf-stat.i.node-store-misses
     23.54 ± 36%     +10.3       33.82 ± 10%  perf-stat.overall.cache-miss-rate%
      0.03 ±107%      -0.0        0.01 ±  2%  perf-stat.overall.dTLB-store-miss-rate%
    595.44 ±  5%      -6.3%     557.82        perf-stat.overall.instructions-per-iTLB-miss
     90.62            +1.4       91.99        perf-stat.overall.node-load-miss-rate%
     92.13            +2.4       94.54        perf-stat.overall.node-store-miss-rate%
    217636 ±103%     -65.1%      75985 ±  3%  perf-stat.ps.dTLB-store-misses
   9768608 ±  8%      +7.5%   10503288        perf-stat.ps.iTLB-load-misses
    576.69            -2.2%     564.02        perf-stat.ps.major-faults
   2116240 ± 13%     +42.4%    3012930 ± 12%  perf-stat.ps.node-load-misses
    216186 ±  4%     +20.3%     259980 ±  5%  perf-stat.ps.node-loads
   1449221 ± 11%     +21.2%    1755769 ±  8%  perf-stat.ps.node-store-misses
    353.75 ± 40%     +56.2%     552.50 ± 12%  interrupts.CPU0.NMI:Non-maskable_interrupts
    353.75 ± 40%     +56.2%     552.50 ± 12%  interrupts.CPU0.PMI:Performance_monitoring_interrupts
      4.75 ± 22%    +794.7%      42.50 ± 97%  interrupts.CPU0.TLB:TLB_shootdowns
    297.25 ± 33%     +67.1%     496.75 ± 10%  interrupts.CPU101.NMI:Non-maskable_interrupts
    297.25 ± 33%     +67.1%     496.75 ± 10%  interrupts.CPU101.PMI:Performance_monitoring_interrupts
    364.50 ± 27%     +37.2%     500.25 ±  5%  interrupts.CPU106.NMI:Non-maskable_interrupts
    364.50 ± 27%     +37.2%     500.25 ±  5%  interrupts.CPU106.PMI:Performance_monitoring_interrupts
    252.75 ± 33%     +68.2%     425.00 ± 22%  interrupts.CPU107.NMI:Non-maskable_interrupts
    252.75 ± 33%     +68.2%     425.00 ± 22%  interrupts.CPU107.PMI:Performance_monitoring_interrupts
    256.75 ± 29%     +85.3%     475.75 ±  9%  interrupts.CPU108.NMI:Non-maskable_interrupts
    256.75 ± 29%     +85.3%     475.75 ±  9%  interrupts.CPU108.PMI:Performance_monitoring_interrupts
      1905 ±  6%     +12.0%       2133 ±  6%  interrupts.CPU11.CAL:Function_call_interrupts
    361.00 ± 30%     +35.0%     487.50 ±  7%  interrupts.CPU11.NMI:Non-maskable_interrupts
    361.00 ± 30%     +35.0%     487.50 ±  7%  interrupts.CPU11.PMI:Performance_monitoring_interrupts
    288.75 ± 40%     +59.3%     460.00 ± 12%  interrupts.CPU115.NMI:Non-maskable_interrupts
    288.75 ± 40%     +59.3%     460.00 ± 12%  interrupts.CPU115.PMI:Performance_monitoring_interrupts
    345.00 ± 30%     +31.4%     453.50 ± 11%  interrupts.CPU116.NMI:Non-maskable_interrupts
    345.00 ± 30%     +31.4%     453.50 ± 11%  interrupts.CPU116.PMI:Performance_monitoring_interrupts
    233.25 ± 29%     +67.7%     391.25 ± 31%  interrupts.CPU123.NMI:Non-maskable_interrupts
    233.25 ± 29%     +67.7%     391.25 ± 31%  interrupts.CPU123.PMI:Performance_monitoring_interrupts
      1898 ±  6%     +10.5%       2097 ±  3%  interrupts.CPU124.CAL:Function_call_interrupts
    181.75 ± 50%    +110.5%     382.50 ± 37%  interrupts.CPU124.NMI:Non-maskable_interrupts
    181.75 ± 50%    +110.5%     382.50 ± 37%  interrupts.CPU124.PMI:Performance_monitoring_interrupts
    220.75 ± 37%     +70.3%     376.00 ± 31%  interrupts.CPU126.NMI:Non-maskable_interrupts
    220.75 ± 37%     +70.3%     376.00 ± 31%  interrupts.CPU126.PMI:Performance_monitoring_interrupts
    208.25 ± 29%    +119.1%     456.25 ± 26%  interrupts.CPU135.NMI:Non-maskable_interrupts
    208.25 ± 29%    +119.1%     456.25 ± 26%  interrupts.CPU135.PMI:Performance_monitoring_interrupts
    245.50 ± 18%     +56.5%     384.25 ± 27%  interrupts.CPU136.NMI:Non-maskable_interrupts
    245.50 ± 18%     +56.5%     384.25 ± 27%  interrupts.CPU136.PMI:Performance_monitoring_interrupts
    210.25 ± 30%     +82.0%     382.75 ± 40%  interrupts.CPU139.NMI:Non-maskable_interrupts
    210.25 ± 30%     +82.0%     382.75 ± 40%  interrupts.CPU139.PMI:Performance_monitoring_interrupts
    353.00 ± 31%     +43.2%     505.50 ± 12%  interrupts.CPU14.NMI:Non-maskable_interrupts
    353.00 ± 31%     +43.2%     505.50 ± 12%  interrupts.CPU14.PMI:Performance_monitoring_interrupts
    212.50 ± 33%     +79.5%     381.50 ± 41%  interrupts.CPU141.NMI:Non-maskable_interrupts
    212.50 ± 33%     +79.5%     381.50 ± 41%  interrupts.CPU141.PMI:Performance_monitoring_interrupts
    212.75 ± 27%     +66.3%     353.75 ± 30%  interrupts.CPU142.NMI:Non-maskable_interrupts
    212.75 ± 27%     +66.3%     353.75 ± 30%  interrupts.CPU142.PMI:Performance_monitoring_interrupts
     42.50 ±105%    +771.8%     370.50 ±142%  interrupts.CPU144.RES:Rescheduling_interrupts
      1904 ±  7%     +11.0%       2114 ± 10%  interrupts.CPU145.CAL:Function_call_interrupts
     34.75 ± 88%    +128.8%      79.50 ± 71%  interrupts.CPU145.RES:Rescheduling_interrupts
    278.50 ± 32%     +70.0%     473.50 ± 22%  interrupts.CPU146.NMI:Non-maskable_interrupts
    278.50 ± 32%     +70.0%     473.50 ± 22%  interrupts.CPU146.PMI:Performance_monitoring_interrupts
      1897 ±  7%     +11.1%       2107 ±  6%  interrupts.CPU152.CAL:Function_call_interrupts
    243.50 ± 34%     +92.3%     468.25 ± 22%  interrupts.CPU158.NMI:Non-maskable_interrupts
    243.50 ± 34%     +92.3%     468.25 ± 22%  interrupts.CPU158.PMI:Performance_monitoring_interrupts
    248.50 ± 34%     +86.9%     464.50 ± 23%  interrupts.CPU159.NMI:Non-maskable_interrupts
    248.50 ± 34%     +86.9%     464.50 ± 23%  interrupts.CPU159.PMI:Performance_monitoring_interrupts
    248.25 ± 36%    +123.3%     554.25 ± 34%  interrupts.CPU160.NMI:Non-maskable_interrupts
    248.25 ± 36%    +123.3%     554.25 ± 34%  interrupts.CPU160.PMI:Performance_monitoring_interrupts
    245.25 ± 34%     +91.3%     469.25 ± 19%  interrupts.CPU161.NMI:Non-maskable_interrupts
    245.25 ± 34%     +91.3%     469.25 ± 19%  interrupts.CPU161.PMI:Performance_monitoring_interrupts
    256.75 ± 36%     +85.5%     476.25 ± 19%  interrupts.CPU162.NMI:Non-maskable_interrupts
    256.75 ± 36%     +85.5%     476.25 ± 19%  interrupts.CPU162.PMI:Performance_monitoring_interrupts
      1880 ±  7%     +10.8%       2084 ±  7%  interrupts.CPU165.CAL:Function_call_interrupts
    127.00 ± 81%     -70.5%      37.50 ± 54%  interrupts.CPU175.RES:Rescheduling_interrupts
    220.25 ±123%     -84.7%      33.75 ± 59%  interrupts.CPU177.RES:Rescheduling_interrupts
     94.00 ± 31%     -66.8%      31.25 ± 79%  interrupts.CPU179.RES:Rescheduling_interrupts
    345.50 ± 26%     +56.9%     542.00 ±  8%  interrupts.CPU2.NMI:Non-maskable_interrupts
    345.50 ± 26%     +56.9%     542.00 ±  8%  interrupts.CPU2.PMI:Performance_monitoring_interrupts
    362.25 ± 31%     +42.3%     515.50 ± 10%  interrupts.CPU22.NMI:Non-maskable_interrupts
    362.25 ± 31%     +42.3%     515.50 ± 10%  interrupts.CPU22.PMI:Performance_monitoring_interrupts
      1897 ±  6%     +16.4%       2207 ±  5%  interrupts.CPU27.CAL:Function_call_interrupts
    207.50 ± 37%     +82.4%     378.50 ± 37%  interrupts.CPU28.NMI:Non-maskable_interrupts
    207.50 ± 37%     +82.4%     378.50 ± 37%  interrupts.CPU28.PMI:Performance_monitoring_interrupts
    344.75 ± 25%     +51.2%     521.25 ±  8%  interrupts.CPU3.NMI:Non-maskable_interrupts
    344.75 ± 25%     +51.2%     521.25 ±  8%  interrupts.CPU3.PMI:Performance_monitoring_interrupts
    194.25 ± 52%     +93.8%     376.50 ± 27%  interrupts.CPU38.NMI:Non-maskable_interrupts
    194.25 ± 52%     +93.8%     376.50 ± 27%  interrupts.CPU38.PMI:Performance_monitoring_interrupts
    209.75 ± 34%    +111.1%     442.75 ± 31%  interrupts.CPU39.NMI:Non-maskable_interrupts
    209.75 ± 34%    +111.1%     442.75 ± 31%  interrupts.CPU39.PMI:Performance_monitoring_interrupts
    240.75 ± 27%     +51.0%     363.50 ± 30%  interrupts.CPU41.NMI:Non-maskable_interrupts
    240.75 ± 27%     +51.0%     363.50 ± 30%  interrupts.CPU41.PMI:Performance_monitoring_interrupts
    207.00 ± 36%     +99.0%     412.00 ± 26%  interrupts.CPU42.NMI:Non-maskable_interrupts
    207.00 ± 36%     +99.0%     412.00 ± 26%  interrupts.CPU42.PMI:Performance_monitoring_interrupts
    224.25 ± 37%     +86.1%     417.25 ± 26%  interrupts.CPU44.NMI:Non-maskable_interrupts
    224.25 ± 37%     +86.1%     417.25 ± 26%  interrupts.CPU44.PMI:Performance_monitoring_interrupts
    275.75 ± 31%     +74.0%     479.75 ± 19%  interrupts.CPU49.NMI:Non-maskable_interrupts
    275.75 ± 31%     +74.0%     479.75 ± 19%  interrupts.CPU49.PMI:Performance_monitoring_interrupts
    301.75 ± 41%     +66.2%     501.50 ±  7%  interrupts.CPU5.NMI:Non-maskable_interrupts
    301.75 ± 41%     +66.2%     501.50 ±  7%  interrupts.CPU5.PMI:Performance_monitoring_interrupts
     41.75 ± 76%    +225.7%     136.00 ± 55%  interrupts.CPU54.RES:Rescheduling_interrupts
      1.50 ± 57%   +3383.3%      52.25 ±133%  interrupts.CPU54.TLB:TLB_shootdowns
     35.75 ± 79%    +138.5%      85.25 ± 78%  interrupts.CPU57.RES:Rescheduling_interrupts
    270.00 ± 32%     +74.1%     470.00 ± 20%  interrupts.CPU61.NMI:Non-maskable_interrupts
    270.00 ± 32%     +74.1%     470.00 ± 20%  interrupts.CPU61.PMI:Performance_monitoring_interrupts
    270.50 ± 31%     +70.0%     459.75 ± 39%  interrupts.CPU64.NMI:Non-maskable_interrupts
    270.50 ± 31%     +70.0%     459.75 ± 39%  interrupts.CPU64.PMI:Performance_monitoring_interrupts
    271.00 ± 32%     +73.8%     471.00 ± 15%  interrupts.CPU65.NMI:Non-maskable_interrupts
    271.00 ± 32%     +73.8%     471.00 ± 15%  interrupts.CPU65.PMI:Performance_monitoring_interrupts
      1881 ±  7%     +14.6%       2156 ±  5%  interrupts.CPU70.CAL:Function_call_interrupts
    266.25 ± 27%     +55.4%     413.75 ± 30%  interrupts.CPU70.NMI:Non-maskable_interrupts
    266.25 ± 27%     +55.4%     413.75 ± 30%  interrupts.CPU70.PMI:Performance_monitoring_interrupts
    312.00 ± 42%     +59.6%     498.00 ±  6%  interrupts.CPU8.NMI:Non-maskable_interrupts
    312.00 ± 42%     +59.6%     498.00 ±  6%  interrupts.CPU8.PMI:Performance_monitoring_interrupts
     95.75 ± 36%     -63.4%      35.00 ± 77%  interrupts.CPU84.RES:Rescheduling_interrupts
    380.25 ± 31%     +40.1%     532.75 ± 14%  interrupts.CPU96.NMI:Non-maskable_interrupts
    380.25 ± 31%     +40.1%     532.75 ± 14%  interrupts.CPU96.PMI:Performance_monitoring_interrupts
    251.75 ± 34%    +103.7%     512.75 ± 10%  interrupts.CPU97.NMI:Non-maskable_interrupts
    251.75 ± 34%    +103.7%     512.75 ± 10%  interrupts.CPU97.PMI:Performance_monitoring_interrupts
    298.50 ± 32%     +88.9%     564.00 ± 11%  interrupts.CPU98.NMI:Non-maskable_interrupts
    298.50 ± 32%     +88.9%     564.00 ± 11%  interrupts.CPU98.PMI:Performance_monitoring_interrupts
    350.50 ± 29%     +45.1%     508.50 ±  7%  interrupts.CPU99.NMI:Non-maskable_interrupts
    350.50 ± 29%     +45.1%     508.50 ±  7%  interrupts.CPU99.PMI:Performance_monitoring_interrupts
     28021 ±  5%     -14.3%      24008 ±  7%  softirqs.CPU0.RCU
     23196 ± 13%     -19.4%      18707 ±  3%  softirqs.CPU100.RCU
     23411 ± 18%     -21.0%      18502 ±  3%  softirqs.CPU101.RCU
     23559 ± 17%     -20.7%      18675 ±  2%  softirqs.CPU102.RCU
     23284 ± 18%     -22.5%      18045        softirqs.CPU104.RCU
     22593 ± 14%     -17.5%      18650 ±  3%  softirqs.CPU105.RCU
     23011 ± 12%     -23.1%      17689 ± 11%  softirqs.CPU106.RCU
     22987 ± 14%     -17.3%      19020 ±  4%  softirqs.CPU107.RCU
     22712 ± 14%     -18.4%      18536 ±  3%  softirqs.CPU108.RCU
     22141 ± 13%     -15.3%      18755 ±  6%  softirqs.CPU109.RCU
     22745 ± 17%     -20.0%      18205 ±  2%  softirqs.CPU110.RCU
     21804 ± 10%     -15.1%      18513 ±  2%  softirqs.CPU111.RCU
     20638 ± 10%     -12.4%      18073        softirqs.CPU112.RCU
     21668 ± 16%     -16.8%      18027 ±  2%  softirqs.CPU113.RCU
     20410 ± 10%     -12.5%      17849        softirqs.CPU114.RCU
     21318 ± 17%     -16.1%      17884        softirqs.CPU115.RCU
     21459 ± 15%     -16.4%      17930 ±  2%  softirqs.CPU117.RCU
     21209 ± 14%     -15.9%      17833        softirqs.CPU118.RCU
     21358 ± 14%     -16.0%      17947        softirqs.CPU119.RCU
     95166 ± 16%     +26.0%     119921 ± 16%  softirqs.CPU124.NET_RX
     21081 ± 15%     -14.5%      18019 ±  2%  softirqs.CPU128.RCU
     21176 ± 14%     -14.9%      18029 ±  3%  softirqs.CPU129.RCU
     21994 ± 17%     -17.7%      18096 ±  3%  softirqs.CPU130.RCU
     22188 ± 19%     -17.8%      18236 ±  3%  softirqs.CPU131.RCU
     21899 ± 21%     -17.8%      18002 ±  2%  softirqs.CPU133.RCU
     21750 ± 19%     -18.2%      17794 ±  2%  softirqs.CPU134.RCU
     21867 ± 17%     -17.0%      18152 ±  4%  softirqs.CPU136.RCU
     22381 ± 16%     -17.7%      18424        softirqs.CPU137.RCU
     21269 ± 13%     -15.6%      17947 ±  2%  softirqs.CPU138.RCU
     22361 ± 18%     -19.0%      18123 ±  3%  softirqs.CPU139.RCU
     21626 ± 19%     -18.6%      17605 ±  3%  softirqs.CPU140.RCU
     21584 ± 18%     -16.7%      17974 ±  3%  softirqs.CPU141.RCU
     21734 ± 17%     -17.6%      17908 ±  3%  softirqs.CPU142.RCU
     21808 ± 18%     -19.7%      17509 ±  8%  softirqs.CPU143.RCU
     21955 ± 14%     -21.6%      17213 ±  7%  softirqs.CPU149.RCU
     22032 ± 12%     -17.3%      18222 ±  6%  softirqs.CPU157.RCU
     21421 ±  8%     -16.0%      18000        softirqs.CPU16.RCU
     20917 ± 11%     -15.7%      17636 ±  5%  softirqs.CPU160.RCU
     22688 ± 16%     -20.9%      17939        softirqs.CPU17.RCU
     20652 ± 15%     -20.6%      16398 ±  3%  softirqs.CPU171.RCU
     21169 ± 16%     -22.2%      16471 ±  3%  softirqs.CPU174.RCU
     20426 ± 14%     -20.0%      16332 ±  4%  softirqs.CPU175.RCU
     21625 ± 17%     -21.5%      16971 ±  2%  softirqs.CPU177.RCU
     21946 ± 19%     -22.2%      17066 ±  3%  softirqs.CPU179.RCU
     21167 ±  9%     -16.0%      17779        softirqs.CPU18.RCU
     21075 ± 13%     -18.9%      17085 ±  2%  softirqs.CPU180.RCU
     21493 ± 15%     -21.5%      16873 ±  2%  softirqs.CPU184.RCU
     21895 ± 21%     -22.9%      16891 ±  3%  softirqs.CPU189.RCU
     22117 ± 15%     -19.8%      17740        softirqs.CPU19.RCU
     22486 ± 15%     -20.8%      17799        softirqs.CPU20.RCU
     22380 ± 14%     -20.2%      17849        softirqs.CPU21.RCU
     22120 ± 13%     -18.8%      17970        softirqs.CPU22.RCU
     22114 ± 13%     -16.6%      18434 ±  3%  softirqs.CPU23.RCU
    100728 ± 13%     +20.6%     121520 ± 16%  softirqs.CPU24.NET_RX
     22219 ± 19%     -18.7%      18069 ±  2%  softirqs.CPU24.RCU
     20735 ± 11%     -13.2%      17990 ±  2%  softirqs.CPU25.RCU
     94892 ± 15%     +26.0%     119557 ± 17%  softirqs.CPU26.NET_RX
     20572 ±  8%     -11.6%      18175 ±  2%  softirqs.CPU26.RCU
     21251 ± 11%     -15.1%      18042 ±  2%  softirqs.CPU27.RCU
     95475 ± 15%     +26.9%     121158 ± 17%  softirqs.CPU28.NET_RX
     21109 ± 11%     -14.6%      18021 ±  2%  softirqs.CPU28.RCU
     20821 ± 11%     -13.9%      17932 ±  2%  softirqs.CPU29.RCU
     94143 ± 15%     +25.8%     118430 ± 18%  softirqs.CPU30.NET_RX
     20844 ±  9%     -12.6%      18209 ±  2%  softirqs.CPU30.RCU
     93752 ± 14%     +27.3%     119326 ± 17%  softirqs.CPU31.NET_RX
     20568 ± 10%     -11.5%      18199        softirqs.CPU31.RCU
     22463 ± 16%     -17.7%      18492 ±  2%  softirqs.CPU32.RCU
     22775 ± 17%     -15.4%      19277 ±  2%  softirqs.CPU34.RCU
     23173 ± 17%     -17.1%      19211 ±  3%  softirqs.CPU35.RCU
     22320 ± 16%     -17.4%      18440 ±  2%  softirqs.CPU38.RCU
     22639 ± 15%     -16.8%      18845 ±  3%  softirqs.CPU41.RCU
     22286 ± 13%     -15.3%      18867 ±  2%  softirqs.CPU42.RCU
     22906 ± 17%     -16.9%      19035 ±  3%  softirqs.CPU43.RCU
     22821 ± 17%     -17.7%      18776 ±  6%  softirqs.CPU44.RCU
     23166 ± 11%     -19.2%      18714 ±  3%  softirqs.CPU48.RCU
     22471 ± 10%     -16.8%      18693 ±  4%  softirqs.CPU49.RCU
     22829 ±  9%     -18.8%      18542 ±  3%  softirqs.CPU50.RCU
     22761 ± 11%     -18.4%      18566 ±  3%  softirqs.CPU51.RCU
     22837 ± 13%     -18.6%      18595 ±  3%  softirqs.CPU52.RCU
     22845 ± 13%     -23.3%      17532 ±  6%  softirqs.CPU53.RCU
     22758 ± 12%     -19.5%      18324 ±  3%  softirqs.CPU54.RCU
     23001 ± 13%     -20.2%      18358 ±  4%  softirqs.CPU55.RCU
     22963 ± 14%     -20.0%      18381 ±  3%  softirqs.CPU56.RCU
     22936 ± 13%     -21.1%      18105 ±  6%  softirqs.CPU57.RCU
     22766 ± 13%     -17.9%      18699 ±  4%  softirqs.CPU58.RCU
     22959 ± 14%     -19.0%      18598 ±  4%  softirqs.CPU59.RCU
     22932 ± 15%     -19.1%      18562 ±  4%  softirqs.CPU60.RCU
     22831 ± 12%     -19.4%      18413 ±  3%  softirqs.CPU61.RCU
     22669 ± 13%     -18.2%      18541 ±  4%  softirqs.CPU62.RCU
     22686 ± 13%     -17.5%      18720 ±  5%  softirqs.CPU63.RCU
     21877 ± 10%     -16.2%      18323 ±  3%  softirqs.CPU64.RCU
     21869 ± 11%     -15.5%      18475 ±  4%  softirqs.CPU66.RCU
     21881 ±  9%     -15.4%      18508 ±  4%  softirqs.CPU67.RCU
     21951 ± 10%     -17.2%      18171 ±  4%  softirqs.CPU69.RCU
     21683 ± 10%     -15.5%      18317 ±  4%  softirqs.CPU70.RCU
     22006 ±  8%     -15.9%      18503 ±  4%  softirqs.CPU71.RCU
     22111 ± 13%     -19.9%      17711 ±  3%  softirqs.CPU72.RCU
     21272 ± 10%     -18.4%      17352 ±  3%  softirqs.CPU74.RCU
     21917 ± 13%     -20.5%      17417 ±  3%  softirqs.CPU75.RCU
     21445 ± 12%     -18.9%      17381 ±  4%  softirqs.CPU76.RCU
     21787 ± 14%     -20.5%      17325 ±  4%  softirqs.CPU77.RCU
     22125 ± 14%     -21.8%      17310 ±  3%  softirqs.CPU78.RCU
     22946 ± 15%     -20.9%      18160 ±  3%  softirqs.CPU80.RCU
     22885 ± 14%     -21.6%      17948 ±  2%  softirqs.CPU81.RCU
     23161 ± 17%     -21.2%      18245 ±  2%  softirqs.CPU82.RCU
     23270 ± 16%     -21.3%      18307 ±  2%  softirqs.CPU83.RCU
     22469 ± 10%     -19.3%      18126 ±  2%  softirqs.CPU84.RCU
     22471 ± 12%     -18.1%      18393 ±  2%  softirqs.CPU86.RCU
     22579 ± 14%     -21.2%      17788 ±  2%  softirqs.CPU87.RCU
     22837 ± 13%     -20.4%      18174 ±  2%  softirqs.CPU88.RCU
     23093 ± 16%     -21.3%      18175 ±  2%  softirqs.CPU89.RCU
     22140 ± 11%     -18.2%      18108 ±  2%  softirqs.CPU90.RCU
     23049 ± 16%     -21.0%      18213 ±  3%  softirqs.CPU91.RCU
     22935 ± 14%     -21.7%      17961 ±  2%  softirqs.CPU92.RCU
     22840 ± 15%     -21.9%      17844 ±  2%  softirqs.CPU93.RCU
     22834 ± 14%     -20.5%      18154 ±  2%  softirqs.CPU94.RCU
     22849 ± 14%     -18.2%      18683 ±  2%  softirqs.CPU95.RCU
     22539 ± 12%     -17.6%      18564 ±  3%  softirqs.CPU96.RCU
     23145 ± 17%     -20.0%      18520 ±  4%  softirqs.CPU97.RCU
     23363 ± 15%     -19.7%      18764 ±  6%  softirqs.CPU98.RCU
     22821 ± 16%     -19.1%      18466 ±  2%  softirqs.CPU99.RCU
   4231487 ± 14%     -17.1%    3506041        softirqs.RCU
      2.41 ± 46%      -1.2        1.19 ± 19%  perf-profile.calltrace.cycles-pp.tick_sched_timer.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.asm_call_on_stack
      2.10 ± 54%      -1.2        0.93 ± 18%  perf-profile.calltrace.cycles-pp.tick_sched_handle.tick_sched_timer.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt
      2.08 ± 53%      -1.1        0.93 ± 17%  perf-profile.calltrace.cycles-pp.update_process_times.tick_sched_handle.tick_sched_timer.__hrtimer_run_queues.hrtimer_interrupt
      0.74 ± 24%      -0.5        0.27 ±100%  perf-profile.calltrace.cycles-pp.worker_thread.kthread.ret_from_fork
      1.47 ± 16%      -0.4        1.03 ± 13%  perf-profile.calltrace.cycles-pp.mul_short.mul_short
      0.70 ± 12%      -0.4        0.28 ±100%  perf-profile.calltrace.cycles-pp.semop
      1.21 ± 17%      -0.4        0.84 ± 16%  perf-profile.calltrace.cycles-pp.mul_long.mul_long
      1.19 ± 16%      -0.4        0.83 ± 13%  perf-profile.calltrace.cycles-pp.mul_int.mul_int
      0.96 ± 18%      -0.3        0.63 ± 20%  perf-profile.calltrace.cycles-pp.ret_from_fork
      0.96 ± 18%      -0.3        0.63 ± 20%  perf-profile.calltrace.cycles-pp.kthread.ret_from_fork
      0.92 ± 18%      -0.3        0.61 ± 15%  perf-profile.calltrace.cycles-pp.random_r
      1.81 ±  6%      +0.2        2.05 ±  5%  perf-profile.calltrace.cycles-pp.do_softirq_own_stack.irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state
      2.02 ±  8%      +0.3        2.27 ±  4%  perf-profile.calltrace.cycles-pp.irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter
      1.79 ±  6%      +0.3        2.05 ±  5%  perf-profile.calltrace.cycles-pp.asm_call_on_stack.do_softirq_own_stack.irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      1.79 ±  6%      +0.3        2.05 ±  5%  perf-profile.calltrace.cycles-pp.__softirqentry_text_start.asm_call_on_stack.do_softirq_own_stack.irq_exit_rcu.sysvec_apic_timer_interrupt
      0.27 ±100%      +0.3        0.60 ±  6%  perf-profile.calltrace.cycles-pp.ip_make_skb.udp_sendmsg.sock_sendmsg.sock_write_iter.new_sync_write
      1.27 ± 19%      +0.5        1.73 ± 14%  perf-profile.calltrace.cycles-pp.do_filp_open.do_sys_openat2.do_sys_open.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.26 ± 19%      +0.5        1.72 ± 14%  perf-profile.calltrace.cycles-pp.path_openat.do_filp_open.do_sys_openat2.do_sys_open.do_syscall_64
      1.37 ± 16%      +0.5        1.84 ± 13%  perf-profile.calltrace.cycles-pp.__open64_nocancel
      1.35 ± 17%      +0.5        1.82 ± 13%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__open64_nocancel
      1.34 ± 17%      +0.5        1.82 ± 13%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__open64_nocancel
      1.33 ± 18%      +0.5        1.81 ± 13%  perf-profile.calltrace.cycles-pp.do_sys_openat2.do_sys_open.do_syscall_64.entry_SYSCALL_64_after_hwframe.__open64_nocancel
      1.34 ± 17%      +0.5        1.81 ± 13%  perf-profile.calltrace.cycles-pp.do_sys_open.do_syscall_64.entry_SYSCALL_64_after_hwframe.__open64_nocancel
      0.44 ± 61%      +0.6        1.01 ± 17%  perf-profile.calltrace.cycles-pp.kmem_cache_free.rcu_do_batch.rcu_core.__softirqentry_text_start.asm_call_on_stack
      0.62 ± 59%      +0.6        1.22 ± 15%  perf-profile.calltrace.cycles-pp.rcu_core.__softirqentry_text_start.asm_call_on_stack.do_softirq_own_stack.irq_exit_rcu
      0.54 ± 59%      +0.6        1.18 ± 16%  perf-profile.calltrace.cycles-pp.rcu_do_batch.rcu_core.__softirqentry_text_start.asm_call_on_stack.do_softirq_own_stack
      0.18 ±173%      +0.7        0.84 ± 20%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__socket
      0.18 ±173%      +0.7        0.84 ± 20%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__socket
      0.18 ±173%      +0.7        0.84 ± 20%  perf-profile.calltrace.cycles-pp.__socket
      0.18 ±173%      +0.7        0.84 ± 20%  perf-profile.calltrace.cycles-pp.__x64_sys_socket.do_syscall_64.entry_SYSCALL_64_after_hwframe.__socket
      0.18 ±173%      +0.7        0.83 ± 19%  perf-profile.calltrace.cycles-pp.__sys_socket.__x64_sys_socket.do_syscall_64.entry_SYSCALL_64_after_hwframe.__socket
      0.52 ± 61%      +0.7        1.23 ± 18%  perf-profile.calltrace.cycles-pp.__alloc_file.alloc_empty_file.path_openat.do_filp_open.do_sys_openat2
      0.52 ± 61%      +0.7        1.23 ± 17%  perf-profile.calltrace.cycles-pp.alloc_empty_file.path_openat.do_filp_open.do_sys_openat2.do_sys_open
      0.31 ±102%      +0.8        1.11 ± 18%  perf-profile.calltrace.cycles-pp.kmem_cache_alloc.__alloc_file.alloc_empty_file.path_openat.do_filp_open
      2.60 ± 28%      +1.1        3.69 ± 10%  perf-profile.calltrace.cycles-pp.kmem_cache_free.skb_free_datagram.unix_dgram_recvmsg.sock_read_iter.new_sync_read
      3.76 ± 29%      +1.5        5.25 ±  9%  perf-profile.calltrace.cycles-pp.kfree.consume_skb.unix_stream_read_generic.unix_stream_recvmsg.sock_read_iter
      2.60 ± 36%      +2.0        4.63 ± 10%  perf-profile.calltrace.cycles-pp.kmem_cache_alloc_node.__alloc_skb.alloc_skb_with_frags.sock_alloc_send_pskb.unix_stream_sendmsg
      2.50 ± 28%      +2.1        4.62 ± 10%  perf-profile.calltrace.cycles-pp.kmem_cache_alloc_node.__alloc_skb.alloc_skb_with_frags.sock_alloc_send_pskb.unix_dgram_sendmsg
      0.00            +2.5        2.45 ± 16%  perf-profile.calltrace.cycles-pp.get_obj_cgroup_from_current.kmem_cache_alloc_node.__alloc_skb.alloc_skb_with_frags.sock_alloc_send_pskb
      7.28 ± 30%      +3.5       10.75 ± 12%  perf-profile.calltrace.cycles-pp.unix_stream_sendmsg.sock_sendmsg.sock_write_iter.new_sync_write.vfs_write
      7.70 ± 28%      +3.6       11.30 ± 12%  perf-profile.calltrace.cycles-pp.unix_dgram_sendmsg.sock_sendmsg.sock_write_iter.new_sync_write.vfs_write
      6.87 ± 31%      +3.6       10.49 ± 12%  perf-profile.calltrace.cycles-pp.sock_alloc_send_pskb.unix_stream_sendmsg.sock_sendmsg.sock_write_iter.new_sync_write
      6.61 ± 31%      +3.6       10.25 ± 12%  perf-profile.calltrace.cycles-pp.__alloc_skb.alloc_skb_with_frags.sock_alloc_send_pskb.unix_stream_sendmsg.sock_sendmsg
      6.81 ± 31%      +3.6       10.45 ± 12%  perf-profile.calltrace.cycles-pp.alloc_skb_with_frags.sock_alloc_send_pskb.unix_stream_sendmsg.sock_sendmsg.sock_write_iter
      7.17 ± 29%      +3.8       10.94 ± 12%  perf-profile.calltrace.cycles-pp.sock_alloc_send_pskb.unix_dgram_sendmsg.sock_sendmsg.sock_write_iter.new_sync_write
      7.12 ± 29%      +3.8       10.90 ± 12%  perf-profile.calltrace.cycles-pp.alloc_skb_with_frags.sock_alloc_send_pskb.unix_dgram_sendmsg.sock_sendmsg.sock_write_iter
      7.12 ± 29%      +3.8       10.90 ± 12%  perf-profile.calltrace.cycles-pp.__alloc_skb.alloc_skb_with_frags.sock_alloc_send_pskb.unix_dgram_sendmsg.sock_sendmsg
     20.83 ± 22%      +6.5       27.36 ±  8%  perf-profile.calltrace.cycles-pp.new_sync_write.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
     19.68 ± 24%      +6.9       26.61 ±  9%  perf-profile.calltrace.cycles-pp.sock_write_iter.new_sync_write.vfs_write.ksys_write.do_syscall_64
     19.46 ± 24%      +7.1       26.52 ±  9%  perf-profile.calltrace.cycles-pp.sock_sendmsg.sock_write_iter.new_sync_write.vfs_write.ksys_write
      3.93 ± 39%      -1.7        2.25 ± 10%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      2.71 ± 42%      -1.2        1.50 ± 13%  perf-profile.children.cycles-pp.tick_sched_timer
      2.38 ± 49%      -1.1        1.23 ± 11%  perf-profile.children.cycles-pp.tick_sched_handle
      2.36 ± 49%      -1.1        1.22 ± 10%  perf-profile.children.cycles-pp.update_process_times
      0.56 ±126%      -0.5        0.10 ± 24%  perf-profile.children.cycles-pp.rcu_sched_clock_irq
      1.47 ± 16%      -0.4        1.03 ± 13%  perf-profile.children.cycles-pp.mul_short
      1.14 ± 21%      -0.4        0.75 ±  9%  perf-profile.children.cycles-pp.scheduler_tick
      1.21 ± 17%      -0.4        0.84 ± 16%  perf-profile.children.cycles-pp.mul_long
      1.19 ± 16%      -0.4        0.83 ± 13%  perf-profile.children.cycles-pp.mul_int
      0.97 ± 17%      -0.3        0.63 ± 20%  perf-profile.children.cycles-pp.ret_from_fork
      0.96 ± 18%      -0.3        0.63 ± 20%  perf-profile.children.cycles-pp.kthread
      1.11 ± 15%      -0.3        0.79 ±  6%  perf-profile.children.cycles-pp._raw_spin_lock
      0.93 ± 18%      -0.3        0.62 ± 15%  perf-profile.children.cycles-pp.random_r
      0.83 ± 18%      -0.3        0.53 ± 12%  perf-profile.children.cycles-pp.console_unlock
      0.86 ± 17%      -0.3        0.58 ±  8%  perf-profile.children.cycles-pp.vprintk_emit
      1.11 ± 13%      -0.3        0.85 ± 10%  perf-profile.children.cycles-pp.security_file_permission
      0.99 ± 15%      -0.3        0.74 ±  8%  perf-profile.children.cycles-pp.common_file_perm
      0.71 ± 26%      -0.2        0.46 ±  6%  perf-profile.children.cycles-pp.memcpy_erms
      0.69 ± 17%      -0.2        0.45 ± 14%  perf-profile.children.cycles-pp.serial8250_console_write
      0.74 ± 24%      -0.2        0.50 ±  8%  perf-profile.children.cycles-pp.worker_thread
      0.66 ± 16%      -0.2        0.43 ± 14%  perf-profile.children.cycles-pp.uart_console_write
      0.69 ± 26%      -0.2        0.45 ±  7%  perf-profile.children.cycles-pp.drm_fb_helper_dirty_work
      0.71 ± 25%      -0.2        0.48 ±  7%  perf-profile.children.cycles-pp.process_one_work
      0.63 ± 15%      -0.2        0.42 ± 14%  perf-profile.children.cycles-pp.wait_for_xmitr
      0.76 ± 13%      -0.2        0.55 ±  9%  perf-profile.children.cycles-pp.semop
      0.59 ± 14%      -0.2        0.40 ± 15%  perf-profile.children.cycles-pp.serial8250_console_putchar
      0.56 ±  6%      -0.2        0.39 ±  8%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      0.39 ± 21%      -0.2        0.24 ± 16%  perf-profile.children.cycles-pp.load_balance
      0.51 ± 15%      -0.1        0.36 ± 14%  perf-profile.children.cycles-pp.io_serial_in
      0.56 ±  6%      -0.1        0.42 ± 21%  perf-profile.children.cycles-pp.do_semtimedop
      0.37 ± 11%      -0.1        0.23 ± 27%  perf-profile.children.cycles-pp.syscall_return_via_sysret
      0.28 ± 31%      -0.1        0.16 ± 17%  perf-profile.children.cycles-pp.update_rq_clock
      0.29 ± 32%      -0.1        0.17 ± 30%  perf-profile.children.cycles-pp.run_local_timers
      0.34 ± 31%      -0.1        0.22 ±  3%  perf-profile.children.cycles-pp._raw_spin_unlock_irqrestore
      0.29 ± 19%      -0.1        0.18 ± 18%  perf-profile.children.cycles-pp.find_busiest_group
      0.26 ± 25%      -0.1        0.15 ± 16%  perf-profile.children.cycles-pp.rcu_idle_exit
      0.59            -0.1        0.49 ±  4%  perf-profile.children.cycles-pp.asm_exc_page_fault
      0.28 ± 18%      -0.1        0.18 ± 16%  perf-profile.children.cycles-pp.update_sd_lb_stats
      0.33 ± 22%      -0.1        0.23 ± 17%  perf-profile.children.cycles-pp.srandom_r
      0.56 ±  3%      -0.1        0.47 ±  5%  perf-profile.children.cycles-pp.exc_page_fault
      0.31 ±  5%      -0.1        0.22 ± 15%  perf-profile.children.cycles-pp.__skb_datagram_iter
      0.56 ±  4%      -0.1        0.47 ±  4%  perf-profile.children.cycles-pp.do_user_addr_fault
      0.48 ±  3%      -0.1        0.39 ±  7%  perf-profile.children.cycles-pp.__handle_mm_fault
      0.51 ±  2%      -0.1        0.42 ±  6%  perf-profile.children.cycles-pp.handle_mm_fault
      0.17 ± 32%      -0.1        0.08 ± 13%  perf-profile.children.cycles-pp.update_irq_load_avg
      0.20 ± 22%      -0.1        0.12 ± 13%  perf-profile.children.cycles-pp.arch_scale_freq_tick
      0.17 ± 37%      -0.1        0.09 ± 21%  perf-profile.children.cycles-pp.rcu_eqs_exit
      0.31 ±  4%      -0.1        0.24 ± 14%  perf-profile.children.cycles-pp.skb_copy_datagram_iter
      0.12 ± 29%      -0.1        0.05 ± 61%  perf-profile.children.cycles-pp.delay_tsc
      0.19 ± 26%      -0.1        0.12 ± 10%  perf-profile.children.cycles-pp.dput
      0.24 ± 21%      -0.1        0.17 ± 13%  perf-profile.children.cycles-pp.newton_raphson
      0.23 ±  8%      -0.1        0.16 ± 13%  perf-profile.children.cycles-pp._copy_to_iter
      0.22 ±  3%      -0.1        0.16 ± 16%  perf-profile.children.cycles-pp.copyout
      0.30 ±  6%      -0.1        0.23 ± 12%  perf-profile.children.cycles-pp.pipe_write
      0.18 ± 12%      -0.1        0.12 ± 15%  perf-profile.children.cycles-pp.__libc_fork
      0.22 ± 21%      -0.1        0.16 ±  9%  perf-profile.children.cycles-pp.security_file_alloc
      0.12 ± 47%      -0.1        0.07 ± 24%  perf-profile.children.cycles-pp.cpuidle_governor_latency_req
      0.20 ± 26%      -0.1        0.15 ±  9%  perf-profile.children.cycles-pp.apparmor_file_alloc_security
      0.15 ± 12%      -0.1        0.10 ±  8%  perf-profile.children.cycles-pp._raw_spin_lock_irq
      0.14 ± 41%      -0.1        0.09 ± 14%  perf-profile.children.cycles-pp.skb_queue_tail
      0.21 ± 20%      -0.0        0.17 ± 10%  perf-profile.children.cycles-pp.irq_work_run_list
      0.15 ± 14%      -0.0        0.11 ± 16%  perf-profile.children.cycles-pp.__do_sys_clone
      0.15 ± 14%      -0.0        0.11 ± 16%  perf-profile.children.cycles-pp._do_fork
      0.13 ± 28%      -0.0        0.08 ± 19%  perf-profile.children.cycles-pp.vt_console_print
      0.08 ± 19%      -0.0        0.03 ±102%  perf-profile.children.cycles-pp.__check_heap_object
      0.24 ±  2%      -0.0        0.19 ±  2%  perf-profile.children.cycles-pp.do_fault
      0.15 ±  7%      -0.0        0.10 ± 24%  perf-profile.children.cycles-pp.copy_user_generic_unrolled
      0.12 ± 29%      -0.0        0.07 ± 22%  perf-profile.children.cycles-pp.fbcon_putcs
      0.12 ± 29%      -0.0        0.07 ± 22%  perf-profile.children.cycles-pp.bit_putcs
      0.18 ±  4%      -0.0        0.13 ±  6%  perf-profile.children.cycles-pp.filemap_map_pages
      0.22 ±  7%      -0.0        0.18 ± 14%  perf-profile.children.cycles-pp.netif_rx
      0.10 ± 24%      -0.0        0.06 ± 20%  perf-profile.children.cycles-pp.sys_imageblit
      0.10 ± 24%      -0.0        0.06 ± 20%  perf-profile.children.cycles-pp.drm_fb_helper_sys_imageblit
      0.11 ±  7%      -0.0        0.07 ± 11%  perf-profile.children.cycles-pp.unix_stream_read_actor
      0.13 ± 11%      -0.0        0.09 ± 20%  perf-profile.children.cycles-pp.unmap_vmas
      0.11 ± 17%      -0.0        0.07 ± 20%  perf-profile.children.cycles-pp.__fget_light
      0.13 ± 14%      -0.0        0.09 ± 15%  perf-profile.children.cycles-pp.copy_process
      0.11 ± 12%      -0.0        0.07 ± 22%  perf-profile.children.cycles-pp._copy_from_iter
      0.21 ±  7%      -0.0        0.18 ± 14%  perf-profile.children.cycles-pp.netif_rx_internal
      0.14 ±  6%      -0.0        0.10 ± 14%  perf-profile.children.cycles-pp.do_wp_page
      0.13 ± 10%      -0.0        0.09 ± 20%  perf-profile.children.cycles-pp.unmap_page_range
      0.11 ± 21%      -0.0        0.07 ± 24%  perf-profile.children.cycles-pp.unix_peer_get
      0.12 ±  8%      -0.0        0.09 ± 16%  perf-profile.children.cycles-pp.zap_pte_range
      0.07 ± 14%      -0.0        0.04 ± 58%  perf-profile.children.cycles-pp.num_rtns_1
      0.09 ± 11%      -0.0        0.06 ± 20%  perf-profile.children.cycles-pp.matrix_rtns
      0.12 ±  3%      -0.0        0.09 ± 12%  perf-profile.children.cycles-pp.wp_page_copy
      0.26 ±  3%      -0.0        0.23 ±  5%  perf-profile.children.cycles-pp.release_sock
      0.09 ± 14%      -0.0        0.07 ±  7%  perf-profile.children.cycles-pp.__x86_indirect_thunk_rax
      0.09 ± 12%      -0.0        0.06 ± 20%  perf-profile.children.cycles-pp.__wake_up_common_lock
      0.08 ±  5%      -0.0        0.07 ±  6%  perf-profile.children.cycles-pp.__inet_lookup_established
      0.08 ±  6%      +0.0        0.09 ±  4%  perf-profile.children.cycles-pp.tcp_connect
      0.10 ± 12%      +0.0        0.13 ±  7%  perf-profile.children.cycles-pp.__cgroup_bpf_run_filter_skb
      0.04 ± 59%      +0.0        0.09 ±  7%  perf-profile.children.cycles-pp.security_sock_rcv_skb
      0.01 ±173%      +0.0        0.06        perf-profile.children.cycles-pp.__tcp_select_window
      0.02 ±173%      +0.1        0.07 ± 20%  perf-profile.children.cycles-pp.__put_anon_vma
      0.03 ±100%      +0.1        0.09 ± 18%  perf-profile.children.cycles-pp.alloc_pipe_info
      0.04 ±103%      +0.1        0.10 ± 23%  perf-profile.children.cycles-pp.rwsem_spin_on_owner
      0.06 ± 66%      +0.1        0.12 ± 13%  perf-profile.children.cycles-pp.accept
      0.09 ± 31%      +0.1        0.16 ±  2%  perf-profile.children.cycles-pp.newseg
      0.10 ± 15%      +0.1        0.16 ±  4%  perf-profile.children.cycles-pp.validate_xmit_skb
      0.00            +0.1        0.07 ±  6%  perf-profile.children.cycles-pp.skb_clone_tx_timestamp
      0.12 ± 41%      +0.1        0.19 ± 21%  perf-profile.children.cycles-pp.shmat
      0.06 ± 63%      +0.1        0.14 ±  3%  perf-profile.children.cycles-pp.__x64_sys_accept
      0.06 ± 63%      +0.1        0.14 ±  3%  perf-profile.children.cycles-pp.__sys_accept4
      0.06 ± 63%      +0.1        0.14 ±  3%  perf-profile.children.cycles-pp.__sys_accept4_file
      0.06 ± 64%      +0.1        0.14 ±  3%  perf-profile.children.cycles-pp.__shmem_file_setup
      0.15 ± 29%      +0.1        0.23 ± 10%  perf-profile.children.cycles-pp.unix_create
      0.15 ± 29%      +0.1        0.23 ±  9%  perf-profile.children.cycles-pp.inet_create
      0.12 ± 36%      +0.1        0.21 ± 20%  perf-profile.children.cycles-pp.unlink_anon_vmas
      0.15 ± 32%      +0.1        0.24 ± 20%  perf-profile.children.cycles-pp.free_pgtables
      0.17 ± 29%      +0.1        0.27 ± 11%  perf-profile.children.cycles-pp.unix_create1
      0.00            +0.1        0.10 ±  7%  perf-profile.children.cycles-pp.netif_skb_features
      0.12 ± 28%      +0.1        0.22 ± 24%  perf-profile.children.cycles-pp.shmget
      0.14 ± 29%      +0.1        0.25 ± 17%  perf-profile.children.cycles-pp.__x64_sys_pipe
      0.14 ± 29%      +0.1        0.25 ± 17%  perf-profile.children.cycles-pp.do_pipe2
      0.14 ± 32%      +0.1        0.25 ± 18%  perf-profile.children.cycles-pp.__do_pipe_flags
      0.15 ± 28%      +0.1        0.26 ± 12%  perf-profile.children.cycles-pp.ipcget
      0.31 ±  4%      +0.1        0.42 ± 10%  perf-profile.children.cycles-pp.__ip_append_data
      0.13 ± 30%      +0.1        0.24 ± 12%  perf-profile.children.cycles-pp.__x64_sys_shmget
      0.14 ± 32%      +0.1        0.25 ± 18%  perf-profile.children.cycles-pp.create_pipe_files
      0.15 ± 35%      +0.1        0.26 ±  8%  perf-profile.children.cycles-pp.remove_vma
      0.55 ±  5%      +0.1        0.67 ±  9%  perf-profile.children.cycles-pp.ip_make_skb
      0.04 ±101%      +0.1        0.18 ± 31%  perf-profile.children.cycles-pp.osq_lock
      0.12 ± 54%      +0.2        0.28 ± 28%  perf-profile.children.cycles-pp.rwsem_down_write_slowpath
      0.10 ± 74%      +0.2        0.28 ± 28%  perf-profile.children.cycles-pp.rwsem_optimistic_spin
      0.29 ± 29%      +0.2        0.47 ± 11%  perf-profile.children.cycles-pp.sk_alloc
      0.27 ± 31%      +0.2        0.46 ± 11%  perf-profile.children.cycles-pp.sk_prot_alloc
      0.29 ± 32%      +0.2        0.49 ±  7%  perf-profile.children.cycles-pp.sock_alloc
      0.26 ± 36%      +0.2        0.47 ±  7%  perf-profile.children.cycles-pp.sock_alloc_inode
      0.19 ± 35%      +0.2        0.42 ± 11%  perf-profile.children.cycles-pp.d_alloc_pseudo
      0.33 ± 34%      +0.2        0.57 ±  6%  perf-profile.children.cycles-pp.alloc_file
      0.21 ± 33%      +0.2        0.45 ±  9%  perf-profile.children.cycles-pp.__d_alloc
      0.34 ± 32%      +0.2        0.59 ±  7%  perf-profile.children.cycles-pp.new_inode_pseudo
      0.33 ± 32%      +0.3        0.58 ±  7%  perf-profile.children.cycles-pp.alloc_inode
      0.49 ± 28%      +0.3        0.75 ±  7%  perf-profile.children.cycles-pp.__sys_socketpair
      0.49 ± 28%      +0.3        0.76 ±  8%  perf-profile.children.cycles-pp.__x64_sys_socketpair
      0.67 ± 27%      +0.3        0.99 ±  7%  perf-profile.children.cycles-pp.__sock_create
      0.50 ± 26%      +0.3        0.84 ± 20%  perf-profile.children.cycles-pp.__socket
      1.13 ± 20%      +0.3        1.48 ±  6%  perf-profile.children.cycles-pp.rcu_core
      0.40 ± 33%      +0.3        0.75 ±  8%  perf-profile.children.cycles-pp.sock_alloc_file
      0.56 ± 30%      +0.4        0.93 ±  8%  perf-profile.children.cycles-pp.__x64_sys_socket
      0.55 ± 30%      +0.4        0.92 ±  8%  perf-profile.children.cycles-pp.__sys_socket
      1.02 ± 24%      +0.4        1.43 ±  5%  perf-profile.children.cycles-pp.rcu_do_batch
      0.48 ± 31%      +0.4        0.92 ±  7%  perf-profile.children.cycles-pp.alloc_file_pseudo
      1.39 ± 16%      +0.5        1.85 ± 13%  perf-profile.children.cycles-pp.__open64_nocancel
      1.44 ± 23%      +0.5        1.96 ±  3%  perf-profile.children.cycles-pp.do_filp_open
      1.44 ± 23%      +0.5        1.96 ±  3%  perf-profile.children.cycles-pp.path_openat
      1.52 ± 21%      +0.5        2.06 ±  2%  perf-profile.children.cycles-pp.do_sys_open
      1.52 ± 21%      +0.5        2.06 ±  2%  perf-profile.children.cycles-pp.do_sys_openat2
      1.01 ± 34%      +0.9        1.93 ±  7%  perf-profile.children.cycles-pp.__alloc_file
      1.02 ± 33%      +0.9        1.94 ±  7%  perf-profile.children.cycles-pp.alloc_empty_file
      1.60 ± 38%      +1.7        3.31 ±  8%  perf-profile.children.cycles-pp.kmem_cache_alloc
      7.28 ± 31%      +2.7        9.93 ±  7%  perf-profile.children.cycles-pp.kmem_cache_free
      7.28 ± 30%      +3.5       10.75 ± 12%  perf-profile.children.cycles-pp.unix_stream_sendmsg
      7.71 ± 28%      +3.6       11.30 ± 12%  perf-profile.children.cycles-pp.unix_dgram_sendmsg
      5.37 ± 35%      +4.0        9.37 ± 10%  perf-profile.children.cycles-pp.kmem_cache_alloc_node
      0.97 ± 59%      +4.2        5.21 ±  7%  perf-profile.children.cycles-pp.get_obj_cgroup_from_current
     21.64 ± 21%      +6.3       27.93 ±  8%  perf-profile.children.cycles-pp.ksys_write
     21.54 ± 21%      +6.3       27.85 ±  8%  perf-profile.children.cycles-pp.vfs_write
     20.84 ± 22%      +6.5       27.36 ±  8%  perf-profile.children.cycles-pp.new_sync_write
     19.69 ± 24%      +6.9       26.62 ±  9%  perf-profile.children.cycles-pp.sock_write_iter
     19.46 ± 24%      +7.1       26.52 ±  9%  perf-profile.children.cycles-pp.sock_sendmsg
     14.05 ± 30%      +7.4       21.48 ± 12%  perf-profile.children.cycles-pp.__alloc_skb
     14.06 ± 30%      +7.5       21.53 ± 12%  perf-profile.children.cycles-pp.alloc_skb_with_frags
     14.21 ± 30%      +7.5       21.68 ± 12%  perf-profile.children.cycles-pp.sock_alloc_send_pskb
     45.93 ± 22%     +12.2       58.11 ±  7%  perf-profile.children.cycles-pp.do_syscall_64
     47.83 ± 21%     +12.2       60.07 ±  7%  perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
      1.45 ± 16%      -0.4        1.02 ± 14%  perf-profile.self.cycles-pp.mul_short
      1.19 ± 17%      -0.4        0.84 ± 15%  perf-profile.self.cycles-pp.mul_long
      1.18 ± 16%      -0.3        0.83 ± 13%  perf-profile.self.cycles-pp.mul_int
      1.08 ± 15%      -0.3        0.78 ±  7%  perf-profile.self.cycles-pp._raw_spin_lock
      0.81 ± 17%      -0.3        0.55 ± 14%  perf-profile.self.cycles-pp.random_r
      0.94 ± 16%      -0.3        0.69 ±  8%  perf-profile.self.cycles-pp.common_file_perm
      0.70 ± 26%      -0.2        0.45 ±  6%  perf-profile.self.cycles-pp.memcpy_erms
      0.55 ±  6%      -0.2        0.38 ±  9%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.51 ± 15%      -0.1        0.36 ± 14%  perf-profile.self.cycles-pp.io_serial_in
      0.23 ± 15%      -0.1        0.09 ±  9%  perf-profile.self.cycles-pp.sock_write_iter
      0.19 ± 39%      -0.1        0.05        perf-profile.self.cycles-pp.udp_sendmsg
      0.37 ± 12%      -0.1        0.23 ± 27%  perf-profile.self.cycles-pp.syscall_return_via_sysret
      0.35 ± 19%      -0.1        0.24 ± 17%  perf-profile.self.cycles-pp.aa_sk_perm
      0.27 ± 33%      -0.1        0.17 ± 29%  perf-profile.self.cycles-pp.run_local_timers
      0.18 ± 16%      -0.1        0.08 ± 10%  perf-profile.self.cycles-pp.new_sync_write
      0.31 ± 23%      -0.1        0.22 ± 16%  perf-profile.self.cycles-pp.srandom_r
      0.17 ± 32%      -0.1        0.08 ± 13%  perf-profile.self.cycles-pp.update_irq_load_avg
      0.21 ± 24%      -0.1        0.13 ± 22%  perf-profile.self.cycles-pp.update_sd_lb_stats
      0.20 ± 22%      -0.1        0.12 ± 13%  perf-profile.self.cycles-pp.arch_scale_freq_tick
      0.13 ± 46%      -0.1        0.06 ± 15%  perf-profile.self.cycles-pp.__hrtimer_run_queues
      0.12 ± 29%      -0.1        0.05 ± 61%  perf-profile.self.cycles-pp.delay_tsc
      0.23 ± 21%      -0.1        0.17 ± 11%  perf-profile.self.cycles-pp.newton_raphson
      0.12 ± 17%      -0.1        0.06 ±  6%  perf-profile.self.cycles-pp.rebalance_domains
      0.14 ± 26%      -0.1        0.09 ± 15%  perf-profile.self.cycles-pp.tsc_verify_tsc_adjust
      0.13 ± 10%      -0.1        0.08 ± 16%  perf-profile.self.cycles-pp.vfs_write
      0.14 ± 15%      -0.0        0.10 ±  8%  perf-profile.self.cycles-pp._raw_spin_lock_irq
      0.07 ± 14%      -0.0        0.03 ±102%  perf-profile.self.cycles-pp.__check_heap_object
      0.13 ± 14%      -0.0        0.09 ± 20%  perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.10 ± 24%      -0.0        0.06 ± 20%  perf-profile.self.cycles-pp.sys_imageblit
      0.15 ± 14%      -0.0        0.12 ± 13%  perf-profile.self.cycles-pp.skb_release_data
      0.09 ± 13%      -0.0        0.05 ± 58%  perf-profile.self.cycles-pp.net_rx_action
      0.07 ± 10%      -0.0        0.04 ± 58%  perf-profile.self.cycles-pp.do_syscall_64
      0.10 ± 10%      -0.0        0.08 ±  8%  perf-profile.self.cycles-pp.filemap_map_pages
      0.10 ± 11%      +0.0        0.12 ±  6%  perf-profile.self.cycles-pp.__cgroup_bpf_run_filter_skb
      0.00            +0.1        0.06 ± 15%  perf-profile.self.cycles-pp.__ip_finish_output
      0.00            +0.1        0.06 ±  7%  perf-profile.self.cycles-pp.__tcp_select_window
      0.01 ±173%      +0.1        0.07 ±  5%  perf-profile.self.cycles-pp.tcp_clean_rtx_queue
      0.04 ±103%      +0.1        0.10 ± 23%  perf-profile.self.cycles-pp.rwsem_spin_on_owner
      0.05 ± 58%      +0.1        0.11 ± 11%  perf-profile.self.cycles-pp.unix_dgram_recvmsg
      0.00            +0.1        0.07 ±  6%  perf-profile.self.cycles-pp.skb_clone_tx_timestamp
      0.00            +0.1        0.08 ±  6%  perf-profile.self.cycles-pp.__ip_append_data
      0.00            +0.1        0.08 ± 11%  perf-profile.self.cycles-pp.netif_skb_features
      0.04 ±103%      +0.1        0.17 ± 31%  perf-profile.self.cycles-pp.osq_lock
      0.27 ± 33%      +0.2        0.42 ± 27%  perf-profile.self.cycles-pp.page_counter_uncharge
      0.12 ± 24%      +0.2        0.30 ± 17%  perf-profile.self.cycles-pp.irqtime_account_irq
      0.86 ± 61%      +0.9        1.73 ±  8%  perf-profile.self.cycles-pp.kmem_cache_alloc
      2.05 ± 66%      +2.0        4.04 ± 12%  perf-profile.self.cycles-pp.__kmalloc_node_track_caller
      2.34 ± 62%      +2.2        4.55 ±  8%  perf-profile.self.cycles-pp.kmem_cache_free
      2.06 ± 57%      +2.4        4.44 ±  8%  perf-profile.self.cycles-pp.kfree
      0.93 ± 63%      +4.2        5.14 ±  7%  perf-profile.self.cycles-pp.get_obj_cgroup_from_current


                                                                                
                                  reaim.jobs_per_min                            
                                                                                
  1.35e+07 +----------------------------------------------------------------+   
   1.3e+07 |-+                                             ::               |   
           |                                              : :               |   
  1.25e+07 |-+                               +   +        :  +   +          |   
   1.2e+07 |-+        +                 +    :+ + +       :  :   ::    .+   |   
           |          :+                :    : +   +.     :   : : +.+.+  :  |   
  1.15e+07 |:+        : +         +    : :  :        +   :    : :        : :|   
   1.1e+07 |:+       :   :   .+  : +   : :  +         :  +    : :         ::|   
  1.05e+07 |-+.   .+.:   :  +  + :  +.+   :+          : :     : :         + |   
           |   +.+   +    :+    +       O +            ::      :            |   
     1e+07 |-+            +   O   O O       O          +       +            |   
   9.5e+06 |-+ O      O O   O   O     O        O                            |   
           | O       O                       O                              |   
     9e+06 |-+   O O                      O                                 |   
   8.5e+06 +----------------------------------------------------------------+   
                                                                                
                                                                                
[*] bisect-good sample
[O] bisect-bad  sample

***************************************************************************************************
lkp-csl-2ap4: 192 threads Intel(R) Xeon(R) Platinum 9242 CPU @ 2.30GHz with 192G memory
=========================================================================================
compiler/cpufreq_governor/kconfig/rootfs/runtime/tbox_group/test/testcase/ucode:
  gcc-9/performance/x86_64-rhel-8.3/debian-10.4-x86_64-20200603.cgz/300s/lkp-csl-2ap4/lru-file-mmap-read-rand/vm-scalability/0x5003003

commit: 
  cf785af193 ("block: warn if !__GFP_DIRECT_RECLAIM in bio_crypt_set_ctx()")
  2b0d3d3e4f ("percpu_ref: reduce memory footprint of percpu_ref in fast path")

cf785af19319f9fc 2b0d3d3e4fcfb19d10f9a82910b 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
      0.10 ±  4%      -7.9%       0.10        vm-scalability.free_time
      8954            -3.5%       8645        vm-scalability.median
   1719804            -2.8%    1671023        vm-scalability.throughput
    373.87            +2.2%     382.04        vm-scalability.time.elapsed_time
    373.87            +2.2%     382.04        vm-scalability.time.elapsed_time.max
  50141867            -2.8%   48740460        vm-scalability.time.major_page_faults
   3281287           -20.4%    2613088 ± 20%  vm-scalability.time.maximum_resident_set_size
    903440            -7.4%     836535        vm-scalability.time.minor_page_faults
     57148            +2.8%      58756        vm-scalability.time.system_time
     37.04 ±  2%     -17.0%      30.74 ±  2%  vm-scalability.time.user_time
    512689           +11.0%     569304 ±  6%  meminfo.Active(anon)
      0.21 ±  5%      +0.0        0.24 ±  4%  mpstat.cpu.all.soft%
  75909996 ±  6%     -11.5%   67201649 ±  3%  numa-numastat.node2.numa_foreign
      9637 ± 10%     -15.6%       8133 ±  3%  numa-meminfo.node0.KernelStack
    240528 ± 26%     +76.2%     423920 ± 24%  numa-meminfo.node3.Shmem
      8929 ±  5%     -18.8%       7248 ±  9%  slabinfo.eventpoll_pwq.active_objs
      8929 ±  5%     -18.8%       7248 ±  9%  slabinfo.eventpoll_pwq.num_objs
     25465 ±  6%   +1123.1%     311459 ±157%  cpuidle.C1.usage
     73758 ±  7%    +546.8%     477088 ±140%  cpuidle.POLL.time
     34434 ±  6%     +55.6%      53583 ± 39%  cpuidle.POLL.usage
      9624 ± 10%     -15.6%       8126 ±  2%  numa-vmstat.node0.nr_kernel_stack
     60560 ± 26%     +76.1%     106647 ± 24%  numa-vmstat.node3.nr_shmem
   3263942 ±  5%      -7.6%    3014749 ±  6%  numa-vmstat.node3.workingset_nodereclaim
     18.00            -5.6%      17.00        vmstat.cpu.id
     81.00            +1.2%      82.00        vmstat.cpu.sy
    760.75           +11.4%     847.25 ±  7%  vmstat.memory.buff
      5806            -2.1%       5684        vmstat.system.cs
     13992 ±  3%      +9.7%      15343 ±  2%  softirqs.CPU157.RCU
     15299 ±  4%      -5.7%      14422 ±  5%  softirqs.CPU16.RCU
     13526 ±  6%      +9.6%      14826 ±  2%  softirqs.CPU165.RCU
     14687 ±  4%      -9.6%      13273        softirqs.CPU38.RCU
     10180 ±  6%      +9.4%      11140 ±  3%  softirqs.CPU8.SCHED
    222.50 ± 19%     -38.9%     136.00 ± 11%  interrupts.CPU120.RES:Rescheduling_interrupts
    341.25 ±  3%     +11.6%     380.75 ± 10%  interrupts.CPU13.RES:Rescheduling_interrupts
    126.25 ± 28%     -42.6%      72.50 ± 27%  interrupts.CPU139.RES:Rescheduling_interrupts
    223.25 ± 56%     -63.3%      82.00 ± 20%  interrupts.CPU173.RES:Rescheduling_interrupts
     72.50 ±  9%     +25.5%      91.00 ± 11%  interrupts.CPU179.RES:Rescheduling_interrupts
     65.25 ± 14%     +36.4%      89.00 ± 20%  interrupts.CPU185.RES:Rescheduling_interrupts
     75.50 ± 17%     +29.8%      98.00 ± 10%  interrupts.CPU189.RES:Rescheduling_interrupts
    106.75 ± 18%    +134.4%     250.25 ± 58%  interrupts.CPU191.RES:Rescheduling_interrupts
    347.50 ±  3%     +26.8%     440.75 ±  7%  interrupts.CPU2.RES:Rescheduling_interrupts
    221.75 ±  7%     -14.1%     190.50        interrupts.CPU64.RES:Rescheduling_interrupts
    225.00 ± 10%     -15.4%     190.25 ±  3%  interrupts.CPU66.RES:Rescheduling_interrupts
    352654            -9.1%     320400        interrupts.CPU67.CAL:Function_call_interrupts
    197.25 ±  5%     -11.9%     173.75 ±  5%  interrupts.CPU67.RES:Rescheduling_interrupts
    206.75 ±  2%     -17.8%     170.00 ±  9%  interrupts.CPU68.RES:Rescheduling_interrupts
    349942            -9.1%     318025 ±  2%  interrupts.CPU70.CAL:Function_call_interrupts
      8333 ±  3%     -36.9%       5255 ± 33%  interrupts.CPU71.NMI:Non-maskable_interrupts
      8333 ±  3%     -36.9%       5255 ± 33%  interrupts.CPU71.PMI:Performance_monitoring_interrupts
    134.50 ± 17%     -25.5%     100.25 ± 13%  interrupts.CPU87.RES:Rescheduling_interrupts
      0.43 ± 44%    +284.6%       1.64 ± 90%  perf-sched.sch_delay.avg.ms.__sched_text_start.__sched_text_start.do_task_dead.do_exit.do_group_exit
      0.22 ± 39%   +4571.0%      10.18 ±115%  perf-sched.sch_delay.avg.ms.__sched_text_start.__sched_text_start.do_wait.kernel_wait4.__do_sys_wait4
      0.24 ± 64%     -57.5%       0.10 ± 37%  perf-sched.sch_delay.avg.ms.__sched_text_start.__sched_text_start.preempt_schedule_common._cond_resched.balance_pgdat
      0.05 ±173%   +1165.8%       0.64 ± 97%  perf-sched.sch_delay.avg.ms.__sched_text_start.__sched_text_start.preempt_schedule_common._cond_resched.do_user_addr_fault
      0.11 ± 52%  +65236.0%      73.50 ± 98%  perf-sched.sch_delay.max.ms.__sched_text_start.__sched_text_start.kswapd.kthread.ret_from_fork
      0.50 ±173%    +547.7%       3.26 ± 96%  perf-sched.sch_delay.max.ms.__sched_text_start.__sched_text_start.preempt_schedule_common._cond_resched.do_user_addr_fault
      0.00 ±173%  +21233.3%       0.16 ±144%  perf-sched.sch_delay.max.ms.__sched_text_start.__sched_text_start.preempt_schedule_common._cond_resched.rmap_walk_file
      3.22 ±  8%     +17.3%       3.78 ±  9%  perf-sched.wait_and_delay.avg.ms.__sched_text_start.__sched_text_start.preempt_schedule_common._cond_resched.__alloc_pages_nodemask
    193.42 ± 26%     -76.3%      45.93 ±173%  perf-sched.wait_and_delay.avg.ms.__sched_text_start.__sched_text_start.preempt_schedule_common._cond_resched.process_one_work
    510.90 ±100%   +1957.9%      10513 ± 63%  perf-sched.wait_and_delay.max.ms.__sched_text_start.__sched_text_start.do_wait.kernel_wait4.__do_sys_wait4
    147.57 ± 18%     +29.4%     190.92 ±  8%  perf-sched.wait_and_delay.max.ms.__sched_text_start.__sched_text_start.preempt_schedule_common._cond_resched.__alloc_pages_slowpath
    202.28 ± 11%    +702.2%       1622 ± 95%  perf-sched.wait_and_delay.max.ms.__sched_text_start.__sched_text_start.preempt_schedule_common._cond_resched.shrink_lruvec
      3.22 ±  8%     +17.3%       3.78 ±  9%  perf-sched.wait_time.avg.ms.__sched_text_start.__sched_text_start.preempt_schedule_common._cond_resched.__alloc_pages_nodemask
      3.54 ±169%    +402.5%      17.78 ± 96%  perf-sched.wait_time.avg.ms.__sched_text_start.__sched_text_start.preempt_schedule_common._cond_resched.__flush_work
      4.75 ±  9%     -34.7%       3.10 ± 21%  perf-sched.wait_time.avg.ms.__sched_text_start.__sched_text_start.preempt_schedule_common._cond_resched.dput
     83.21 ± 33%     -73.2%      22.28 ±139%  perf-sched.wait_time.avg.ms.__sched_text_start.__sched_text_start.preempt_schedule_common._cond_resched.generic_perform_write
    193.17 ± 26%     -54.5%      87.87 ± 64%  perf-sched.wait_time.avg.ms.__sched_text_start.__sched_text_start.preempt_schedule_common._cond_resched.process_one_work
      2.37 ± 49%    +191.0%       6.89 ± 39%  perf-sched.wait_time.avg.ms.__sched_text_start.__sched_text_start.preempt_schedule_common._cond_resched.rmap_walk_file
    147.56 ± 18%     +29.4%     190.92 ±  8%  perf-sched.wait_time.max.ms.__sched_text_start.__sched_text_start.preempt_schedule_common._cond_resched.__alloc_pages_slowpath
      3783 ±  7%     -79.9%     760.99 ±163%  perf-sched.wait_time.max.ms.__sched_text_start.__sched_text_start.preempt_schedule_common._cond_resched.generic_perform_write
     16.11 ± 48%    +459.4%      90.14 ± 70%  perf-sched.wait_time.max.ms.__sched_text_start.__sched_text_start.preempt_schedule_common._cond_resched.rmap_walk_file
    195.61 ± 13%    +474.7%       1124 ± 64%  perf-sched.wait_time.max.ms.__sched_text_start.__sched_text_start.preempt_schedule_common._cond_resched.shrink_lruvec
    112.38 ± 23%     +50.7%     169.39 ± 23%  perf-sched.wait_time.max.ms.__sched_text_start.__sched_text_start.schedule_timeout.kswapd.kthread
    990.53 ±  3%     +48.7%       1472 ± 35%  perf-sched.wait_time.max.ms.__sched_text_start.__sched_text_start.worker_thread.kthread.ret_from_fork
    193180            -2.3%     188669        proc-vmstat.allocstall_movable
      1142 ±  5%     -18.1%     934.75 ±  2%  proc-vmstat.kswapd_low_wmark_hit_quickly
    128456           +11.0%     142606 ±  6%  proc-vmstat.nr_active_anon
    128457           +11.0%     142609 ±  6%  proc-vmstat.nr_zone_active_anon
 2.916e+08            -3.5%  2.814e+08        proc-vmstat.numa_foreign
 1.295e+09            -2.6%  1.262e+09        proc-vmstat.numa_hit
 1.295e+09            -2.6%  1.261e+09        proc-vmstat.numa_local
 2.916e+08            -3.5%  2.814e+08        proc-vmstat.numa_miss
 2.918e+08            -3.5%  2.816e+08        proc-vmstat.numa_other
      3708 ±  2%      -7.3%       3436 ±  2%  proc-vmstat.pageoutrun
 1.577e+09            -2.7%  1.534e+09        proc-vmstat.pgalloc_normal
    734770            -2.4%     717357 ±  2%  proc-vmstat.pgdeactivate
 1.029e+08            -2.7%      1e+08        proc-vmstat.pgfault
 1.593e+09            -2.7%  1.549e+09        proc-vmstat.pgfree
  50090667            -2.8%   48694010        proc-vmstat.pgmajfault
    734770            -2.4%     717357 ±  2%  proc-vmstat.pgrefill
 2.127e+09            -2.3%  2.079e+09        proc-vmstat.pgscan_direct
 2.279e+09            -2.5%  2.221e+09        proc-vmstat.pgscan_file
 1.518e+08 ±  2%      -6.1%  1.425e+08 ±  2%  proc-vmstat.pgscan_kswapd
 1.439e+09            -2.6%  1.402e+09        proc-vmstat.pgsteal_direct
 1.533e+09            -2.8%   1.49e+09        proc-vmstat.pgsteal_file
  94594773 ±  3%      -6.8%   88192320 ±  2%  proc-vmstat.pgsteal_kswapd
  81169135 ±  2%      -8.4%   74310955 ±  2%  proc-vmstat.slabs_scanned
  17896413            -3.8%   17213022        proc-vmstat.workingset_nodereclaim
   4815275            -1.4%    4747661        proc-vmstat.workingset_nodes
 1.515e+08            -3.3%  1.465e+08        proc-vmstat.workingset_refault_file
      4.58           +17.1%       5.37 ± 20%  perf-stat.i.MPKI
 1.328e+10            -1.0%  1.315e+10        perf-stat.i.branch-instructions
 1.085e+08            +3.6%  1.124e+08        perf-stat.i.cache-misses
 2.313e+08            +3.2%  2.387e+08 ±  3%  perf-stat.i.cache-references
      5710            -2.2%       5585        perf-stat.i.context-switches
      7.07            +3.0%       7.29        perf-stat.i.cpi
 4.732e+11            +1.0%  4.781e+11        perf-stat.i.cpu-cycles
      4016            -2.4%       3918        perf-stat.i.cycles-between-cache-misses
 1.516e+10            -1.4%  1.495e+10        perf-stat.i.dTLB-loads
  4.05e+09            -4.3%  3.878e+09        perf-stat.i.dTLB-stores
   7160344            -5.5%    6765423 ±  3%  perf-stat.i.iTLB-load-misses
 5.956e+10            -1.4%  5.875e+10        perf-stat.i.instructions
      8057            +4.3%       8407 ±  2%  perf-stat.i.instructions-per-iTLB-miss
      0.18            -5.1%       0.17        perf-stat.i.ipc
    130812            -4.8%     124567        perf-stat.i.major-faults
    170.49            -1.6%     167.78        perf-stat.i.metric.M/sec
     77.69            +1.5       79.15        perf-stat.i.node-load-miss-rate%
  23966652            +7.7%   25800856        perf-stat.i.node-load-misses
  11624715            -4.0%   11162780        perf-stat.i.node-stores
    137592            -4.7%     131161        perf-stat.i.page-faults
      3.86            +4.5%       4.04 ±  2%  perf-stat.overall.MPKI
      7.97            +2.3%       8.15        perf-stat.overall.cpi
      4408            -2.7%       4289        perf-stat.overall.cycles-between-cache-misses
      8457            +4.3%       8824 ±  3%  perf-stat.overall.instructions-per-iTLB-miss
      0.13            -2.3%       0.12        perf-stat.overall.ipc
     78.50            +1.6       80.11        perf-stat.overall.node-load-miss-rate%
     59.97            +0.8       60.79        perf-stat.overall.node-store-miss-rate%
 1.359e+10            -1.2%  1.343e+10        perf-stat.ps.branch-instructions
 1.101e+08            +3.6%  1.141e+08        perf-stat.ps.cache-misses
 2.353e+08            +2.9%  2.422e+08 ±  2%  perf-stat.ps.cache-references
      5768            -2.1%       5648        perf-stat.ps.context-switches
 1.551e+10            -1.6%  1.527e+10        perf-stat.ps.dTLB-loads
 4.126e+09            -4.3%  3.948e+09        perf-stat.ps.dTLB-stores
   7206955            -5.5%    6810312 ±  3%  perf-stat.ps.iTLB-load-misses
    901608 ±  2%      -9.6%     814873 ±  9%  perf-stat.ps.iTLB-loads
 6.094e+10            -1.5%  6.002e+10        perf-stat.ps.instructions
    133601            -4.8%     127225        perf-stat.ps.major-faults
  24391184            +7.5%   26227147        perf-stat.ps.node-load-misses
  11852943            -3.9%   11392306        perf-stat.ps.node-stores
    140341            -4.7%     133788        perf-stat.ps.page-faults
      4.53 ± 11%      -0.9        3.68 ± 15%  perf-profile.calltrace.cycles-pp.get_page_from_freelist.__alloc_pages_nodemask.page_cache_readahead_unbounded.filemap_fault.__xfs_filemap_fault
      4.40 ± 11%      -0.8        3.56 ± 16%  perf-profile.calltrace.cycles-pp.rmqueue.get_page_from_freelist.__alloc_pages_nodemask.page_cache_readahead_unbounded.filemap_fault
      4.25 ± 12%      -0.8        3.42 ± 17%  perf-profile.calltrace.cycles-pp.rmqueue_bulk.rmqueue.get_page_from_freelist.__alloc_pages_nodemask.page_cache_readahead_unbounded
      3.85 ± 13%      -0.8        3.04 ± 19%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.rmqueue_bulk.rmqueue.get_page_from_freelist
      3.85 ± 13%      -0.8        3.06 ± 19%  perf-profile.calltrace.cycles-pp._raw_spin_lock.rmqueue_bulk.rmqueue.get_page_from_freelist.__alloc_pages_nodemask
      4.44 ±  3%      -0.4        4.09 ±  4%  perf-profile.calltrace.cycles-pp.iomap_readahead_actor.iomap_apply.iomap_readahead.read_pages.page_cache_readahead_unbounded
      4.29 ±  3%      -0.4        3.94 ±  4%  perf-profile.calltrace.cycles-pp.iomap_readpage_actor.iomap_readahead_actor.iomap_apply.iomap_readahead.read_pages
      4.47 ±  3%      -0.3        4.12 ±  4%  perf-profile.calltrace.cycles-pp.read_pages.page_cache_readahead_unbounded.filemap_fault.__xfs_filemap_fault.__do_fault
      4.46 ±  3%      -0.3        4.11 ±  4%  perf-profile.calltrace.cycles-pp.iomap_apply.iomap_readahead.read_pages.page_cache_readahead_unbounded.filemap_fault
      4.47 ±  3%      -0.3        4.12 ±  4%  perf-profile.calltrace.cycles-pp.iomap_readahead.read_pages.page_cache_readahead_unbounded.filemap_fault.__xfs_filemap_fault
      2.32 ±  3%      -0.2        2.12 ±  4%  perf-profile.calltrace.cycles-pp.memset_erms.iomap_readpage_actor.iomap_readahead_actor.iomap_apply.iomap_readahead
      1.83 ±  3%      -0.1        1.68 ±  3%  perf-profile.calltrace.cycles-pp.iomap_set_range_uptodate.iomap_readpage_actor.iomap_readahead_actor.iomap_apply.iomap_readahead
      5.13 ±  9%      -0.9        4.19 ± 13%  perf-profile.children.cycles-pp._raw_spin_lock
      4.74 ± 11%      -0.9        3.89 ± 14%  perf-profile.children.cycles-pp.get_page_from_freelist
      4.59 ± 12%      -0.8        3.75 ± 15%  perf-profile.children.cycles-pp.rmqueue
      4.42 ± 12%      -0.8        3.59 ± 16%  perf-profile.children.cycles-pp.rmqueue_bulk
      4.47 ±  3%      -0.4        4.11 ±  4%  perf-profile.children.cycles-pp.iomap_apply
      4.45 ±  3%      -0.4        4.09 ±  4%  perf-profile.children.cycles-pp.iomap_readahead_actor
      4.47 ±  3%      -0.4        4.12 ±  4%  perf-profile.children.cycles-pp.read_pages
      4.47 ±  3%      -0.4        4.12 ±  4%  perf-profile.children.cycles-pp.iomap_readahead
      4.30 ±  3%      -0.4        3.95 ±  4%  perf-profile.children.cycles-pp.iomap_readpage_actor
      2.35 ±  3%      -0.2        2.15 ±  4%  perf-profile.children.cycles-pp.memset_erms
      0.98 ±  6%      -0.2        0.82 ±  2%  perf-profile.children.cycles-pp.free_unref_page_list
      1.83 ±  3%      -0.1        1.68 ±  3%  perf-profile.children.cycles-pp.iomap_set_range_uptodate
      1.04 ±  2%      -0.1        0.95 ±  2%  perf-profile.children.cycles-pp.__list_del_entry_valid
      0.72            -0.0        0.69 ±  2%  perf-profile.children.cycles-pp.isolate_lru_pages
      0.59 ±  3%      -0.0        0.56        perf-profile.children.cycles-pp.page_referenced
      0.16 ±  2%      -0.0        0.15 ±  2%  perf-profile.children.cycles-pp.down_read
      0.16 ±  2%      -0.0        0.15        perf-profile.children.cycles-pp.xa_load
      0.10 ±  5%      +0.0        0.11        perf-profile.children.cycles-pp.page_remove_rmap
      0.18 ±  4%      +0.0        0.21        perf-profile.children.cycles-pp.unaccount_page_cache_page
      0.00            +0.1        0.06        perf-profile.children.cycles-pp.lru_note_cost
      0.03 ±100%      +0.1        0.09 ±  7%  perf-profile.children.cycles-pp.propagate_protected_usage
      0.14 ±  3%      +0.1        0.24 ±  4%  perf-profile.children.cycles-pp.page_counter_try_charge
      0.23            +0.1        0.34 ±  3%  perf-profile.children.cycles-pp.mem_cgroup_uncharge_list
      0.23 ± 12%      +0.1        0.35 ±  8%  perf-profile.children.cycles-pp.page_counter_cancel
      0.18 ±  2%      +0.1        0.30 ±  2%  perf-profile.children.cycles-pp.uncharge_batch
      0.24 ± 14%      +0.1        0.37 ±  8%  perf-profile.children.cycles-pp.page_counter_uncharge
      0.21 ±  3%      +0.1        0.34 ±  4%  perf-profile.children.cycles-pp.try_charge
      0.61 ±  4%      +0.2        0.77 ±  4%  perf-profile.children.cycles-pp.__mod_memcg_lruvec_state
      0.15 ±  7%      +0.2        0.36 ±  2%  perf-profile.children.cycles-pp.workingset_age_nonresident
      0.28 ±  4%      -0.2        0.09 ±  5%  perf-profile.self.cycles-pp.workingset_eviction
      2.33 ±  3%      -0.2        2.14 ±  4%  perf-profile.self.cycles-pp.memset_erms
      1.81 ±  2%      -0.1        1.66 ±  3%  perf-profile.self.cycles-pp.iomap_set_range_uptodate
      1.03 ±  2%      -0.1        0.95 ±  2%  perf-profile.self.cycles-pp.__list_del_entry_valid
      0.42 ±  3%      -0.0        0.39 ±  2%  perf-profile.self.cycles-pp.xas_create
      0.33            -0.0        0.31 ±  3%  perf-profile.self.cycles-pp.free_pcppages_bulk
      0.14 ±  3%      -0.0        0.12        perf-profile.self.cycles-pp.__pagevec_lru_add_fn
      0.08 ±  5%      +0.0        0.10        perf-profile.self.cycles-pp.try_charge
      0.11 ± 24%      +0.0        0.15 ± 19%  perf-profile.self.cycles-pp.kmem_cache_free
      0.00            +0.1        0.06        perf-profile.self.cycles-pp.lru_note_cost
      0.03 ±100%      +0.1        0.09 ±  4%  perf-profile.self.cycles-pp.propagate_protected_usage
      0.20 ± 12%      +0.1        0.29 ±  8%  perf-profile.self.cycles-pp.page_counter_cancel
      0.12 ±  3%      +0.1        0.21 ±  3%  perf-profile.self.cycles-pp.page_counter_try_charge
      0.21 ±  3%      +0.1        0.33 ±  5%  perf-profile.self.cycles-pp.__mod_memcg_lruvec_state
      0.15 ±  7%      +0.2        0.36 ±  2%  perf-profile.self.cycles-pp.workingset_age_nonresident



***************************************************************************************************
lkp-hsw-4ex1: 144 threads Intel(R) Xeon(R) CPU E7-8890 v3 @ 2.50GHz with 512G memory
=========================================================================================
compiler/cpufreq_governor/kconfig/mode/nr_task/rootfs/tbox_group/test/testcase/ucode:
  gcc-9/performance/x86_64-rhel-8.3/process/50%/debian-10.4-x86_64-20200603.cgz/lkp-hsw-4ex1/page_fault2/will-it-scale/0x16

commit: 
  cf785af193 ("block: warn if !__GFP_DIRECT_RECLAIM in bio_crypt_set_ctx()")
  2b0d3d3e4f ("percpu_ref: reduce memory footprint of percpu_ref in fast path")

cf785af19319f9fc 2b0d3d3e4fcfb19d10f9a82910b 
---------------- --------------------------- 
       fail:runs  %reproduction    fail:runs
           |             |             |    
          4:4            6%           4:4     perf-profile.calltrace.cycles-pp.error_entry.testcase
          4:4            6%           4:4     perf-profile.children.cycles-pp.error_entry
          3:4            5%           3:4     perf-profile.self.cycles-pp.error_entry
         %stddev     %change         %stddev
             \          |                \  
  11917882           +14.5%   13642560        will-it-scale.72.processes
    165525           +14.5%     189479        will-it-scale.per_process_ops
  11917882           +14.5%   13642560        will-it-scale.workload
 5.751e+09 ± 41%     +68.4%  9.683e+09 ± 16%  cpuidle.C1E.time
      5.51            -0.9        4.64        mpstat.cpu.all.usr%
      3075 ±  6%     +23.6%       3801 ± 11%  syscalls.sys_write.med
     52736 ±  3%     +11.3%      58685 ±  3%  slabinfo.filp.active_objs
     52960 ±  3%     +11.2%      58899 ±  3%  slabinfo.filp.num_objs
     10628 ±  6%     +10.5%      11745 ±  6%  slabinfo.pde_opener.active_objs
     10628 ±  6%     +10.5%      11745 ±  6%  slabinfo.pde_opener.num_objs
     37829 ±  4%     -28.9%      26912 ±  9%  numa-meminfo.node1.KReclaimable
      6200 ±  7%     -13.0%       5392 ±  5%  numa-meminfo.node1.KernelStack
     37829 ±  4%     -28.9%      26912 ±  9%  numa-meminfo.node1.SReclaimable
     63426 ±  8%     -25.5%      47269 ± 14%  numa-meminfo.node1.SUnreclaim
    101256 ±  3%     -26.7%      74181 ± 10%  numa-meminfo.node1.Slab
     42587 ±  8%     +20.2%      51174 ± 10%  numa-meminfo.node3.SUnreclaim
     68736 ±  6%     +25.3%      86149 ± 12%  numa-meminfo.node3.Slab
 9.114e+08 ±  2%     +14.4%  1.042e+09        numa-numastat.node0.local_node
 9.114e+08 ±  2%     +14.4%  1.042e+09        numa-numastat.node0.numa_hit
 9.009e+08           +14.0%  1.027e+09        numa-numastat.node1.local_node
 9.009e+08           +14.0%  1.027e+09        numa-numastat.node1.numa_hit
 8.939e+08           +14.6%  1.024e+09        numa-numastat.node2.local_node
 8.939e+08           +14.6%  1.024e+09        numa-numastat.node2.numa_hit
 8.868e+08 ±  3%     +14.9%  1.019e+09        numa-numastat.node3.local_node
 8.868e+08 ±  3%     +14.9%  1.019e+09        numa-numastat.node3.numa_hit
     35598 ±  2%     -59.8%      14317 ±102%  numa-numastat.node3.other_node
   1208645            -1.0%    1196811        proc-vmstat.nr_anon_pages
     32598            +1.2%      32990        proc-vmstat.nr_slab_reclaimable
     53316            +1.5%      54099        proc-vmstat.nr_slab_unreclaimable
      1827 ±125%     -97.2%      50.50 ± 29%  proc-vmstat.numa_hint_faults_local
 3.591e+09           +14.5%   4.11e+09        proc-vmstat.numa_hit
 3.591e+09           +14.5%   4.11e+09        proc-vmstat.numa_local
     11689 ± 17%     -45.3%       6395 ± 48%  proc-vmstat.numa_pages_migrated
     42327 ± 21%     -46.3%      22714 ±  2%  proc-vmstat.numa_pte_updates
 3.593e+09           +14.4%  4.112e+09        proc-vmstat.pgalloc_normal
 3.582e+09           +14.5%    4.1e+09        proc-vmstat.pgfault
  3.59e+09           +14.5%  4.109e+09        proc-vmstat.pgfree
     11689 ± 17%     -45.3%       6395 ± 48%  proc-vmstat.pgmigrate_success
 4.538e+08 ±  3%     +14.4%  5.191e+08        numa-vmstat.node0.numa_hit
 4.538e+08 ±  3%     +14.4%   5.19e+08        numa-vmstat.node0.numa_local
      6198 ±  7%     -13.0%       5394 ±  5%  numa-vmstat.node1.nr_kernel_stack
      9456 ±  4%     -28.9%       6727 ±  9%  numa-vmstat.node1.nr_slab_reclaimable
     15856 ±  8%     -25.5%      11817 ± 14%  numa-vmstat.node1.nr_slab_unreclaimable
 4.489e+08           +13.8%  5.108e+08        numa-vmstat.node1.numa_hit
 4.488e+08           +13.8%  5.107e+08        numa-vmstat.node1.numa_local
 4.452e+08           +14.4%  5.092e+08        numa-vmstat.node2.numa_hit
 4.451e+08           +14.4%  5.091e+08        numa-vmstat.node2.numa_local
     10646 ±  8%     +20.2%      12793 ± 10%  numa-vmstat.node3.nr_slab_unreclaimable
 4.416e+08 ±  3%     +14.8%  5.071e+08        numa-vmstat.node3.numa_hit
 4.415e+08 ±  3%     +14.8%   5.07e+08        numa-vmstat.node3.numa_local
    124943           -17.1%     103615 ± 14%  numa-vmstat.node3.numa_other
    157.96 ± 21%   +3658.8%       5937 ± 47%  sched_debug.cfs_rq:/.exec_clock.min
     47229 ±  3%     -27.2%      34362 ±  9%  sched_debug.cfs_rq:/.exec_clock.stddev
     29466 ± 17%   +1441.3%     454176 ± 46%  sched_debug.cfs_rq:/.min_vruntime.min
   3501079 ±  3%     -27.2%    2548272 ±  9%  sched_debug.cfs_rq:/.min_vruntime.stddev
     12.72 ±  2%     +35.2%      17.19 ±  2%  sched_debug.cfs_rq:/.nr_spread_over.avg
     35.46 ±  8%     +29.6%      45.96 ± 16%  sched_debug.cfs_rq:/.nr_spread_over.max
   3501081 ±  3%     -27.2%    2548274 ±  9%  sched_debug.cfs_rq:/.spread0.stddev
   1325375 ±  6%     -15.7%    1117832 ±  5%  sched_debug.cpu.avg_idle.max
     38786 ± 14%     -25.1%      29035 ± 26%  sched_debug.cpu.nr_switches.max
      4150 ±  8%     -19.5%       3338 ± 11%  sched_debug.cpu.nr_switches.stddev
     35676 ± 16%     -25.6%      26560 ± 28%  sched_debug.cpu.sched_count.max
    604.12 ±  4%     +14.9%     694.00 ±  3%  sched_debug.cpu.sched_count.min
     17716 ± 16%     -26.0%      13114 ± 28%  sched_debug.cpu.sched_goidle.max
     12.21 ± 14%    +133.1%      28.46 ± 27%  sched_debug.cpu.sched_goidle.min
      1885 ± 11%     -19.3%       1522 ± 14%  sched_debug.cpu.sched_goidle.stddev
     18816 ± 10%     -25.8%      13967 ± 17%  sched_debug.cpu.ttwu_count.max
    219.25 ±  4%     +23.8%     271.50 ±  5%  sched_debug.cpu.ttwu_count.min
      1952 ±  3%     -19.1%       1578 ±  9%  sched_debug.cpu.ttwu_count.stddev
    202.42 ±  3%     +18.3%     239.38 ±  4%  sched_debug.cpu.ttwu_local.min
     40818 ±  2%     -31.4%      27986 ± 26%  softirqs.CPU1.SCHED
      9367 ±  9%     -18.4%       7646 ±  4%  softirqs.CPU100.RCU
     12582 ± 46%    +101.2%      25311 ± 18%  softirqs.CPU103.SCHED
     23835 ± 13%     -26.3%      17571 ± 15%  softirqs.CPU11.SCHED
     30004 ± 22%     -35.2%      19452 ± 14%  softirqs.CPU121.SCHED
      9330 ±  4%     -16.0%       7842 ±  7%  softirqs.CPU137.RCU
     10955 ± 10%     -22.2%       8527 ±  6%  softirqs.CPU14.RCU
      9739 ± 10%     -19.4%       7848 ± 15%  softirqs.CPU18.RCU
     10422 ± 10%     -16.5%       8707 ±  6%  softirqs.CPU19.RCU
      9955 ±  6%     -18.4%       8128 ±  2%  softirqs.CPU20.RCU
     10056 ±  6%     -21.7%       7871 ±  3%  softirqs.CPU22.RCU
     12538 ± 51%    +102.1%      25339 ± 19%  softirqs.CPU22.SCHED
     11539 ± 50%    +115.6%      24880 ± 29%  softirqs.CPU24.SCHED
     10011 ±  9%     -21.5%       7858 ±  6%  softirqs.CPU25.RCU
      9823 ±  7%     -14.3%       8416 ±  5%  softirqs.CPU26.RCU
      9736 ±  4%     -16.7%       8114 ±  4%  softirqs.CPU27.RCU
      9971 ±  7%     -16.5%       8326 ±  8%  softirqs.CPU3.RCU
      9735 ±  4%     -12.8%       8484 ±  7%  softirqs.CPU30.RCU
     10286 ±  8%     -18.6%       8370 ±  2%  softirqs.CPU36.RCU
      9144 ±  8%     -10.2%       8209 ±  3%  softirqs.CPU37.RCU
     10268 ±  4%     -17.1%       8513 ±  5%  softirqs.CPU38.RCU
      9510 ±  6%     -14.8%       8100 ±  5%  softirqs.CPU4.RCU
      9648 ± 10%     -16.8%       8026 ±  6%  softirqs.CPU40.RCU
      9861 ±  4%     -13.5%       8525 ±  5%  softirqs.CPU43.RCU
      9851 ± 10%     -18.8%       7996 ±  2%  softirqs.CPU47.RCU
     12163 ± 58%     +90.4%      23154 ± 11%  softirqs.CPU49.SCHED
     10364 ± 11%     -20.8%       8204 ±  5%  softirqs.CPU73.RCU
      3348 ± 14%    +349.4%      15044 ± 43%  softirqs.CPU73.SCHED
     29070 ± 20%     -44.8%      16051 ± 18%  softirqs.CPU94.SCHED
     31270 ± 17%     -42.5%      17981 ± 43%  softirqs.CPU96.SCHED
   1283184 ±  2%      -9.9%    1156401        softirqs.RCU
     33.50 ± 34%    +235.1%     112.25 ± 49%  interrupts.CPU1.RES:Rescheduling_interrupts
      2909 ± 32%    +172.4%       7922 ±  2%  interrupts.CPU12.NMI:Non-maskable_interrupts
      2909 ± 32%    +172.4%       7922 ±  2%  interrupts.CPU12.PMI:Performance_monitoring_interrupts
      3855 ± 63%     +61.9%       6241 ± 31%  interrupts.CPU121.NMI:Non-maskable_interrupts
      3855 ± 63%     +61.9%       6241 ± 31%  interrupts.CPU121.PMI:Performance_monitoring_interrupts
    662.75            +9.0%     722.50 ±  4%  interrupts.CPU123.CAL:Function_call_interrupts
      8.00 ± 42%    +393.8%      39.50 ±113%  interrupts.CPU128.RES:Rescheduling_interrupts
      7.25 ± 17%    +441.4%      39.25 ±111%  interrupts.CPU133.RES:Rescheduling_interrupts
      7378 ± 13%     -49.4%       3735 ± 42%  interrupts.CPU137.NMI:Non-maskable_interrupts
      7378 ± 13%     -49.4%       3735 ± 42%  interrupts.CPU137.PMI:Performance_monitoring_interrupts
      4443 ± 16%     +53.8%       6835 ± 18%  interrupts.CPU14.NMI:Non-maskable_interrupts
      4443 ± 16%     +53.8%       6835 ± 18%  interrupts.CPU14.PMI:Performance_monitoring_interrupts
      2429 ± 44%     +90.4%       4624 ± 38%  interrupts.CPU15.NMI:Non-maskable_interrupts
      2429 ± 44%     +90.4%       4624 ± 38%  interrupts.CPU15.PMI:Performance_monitoring_interrupts
      2309 ± 45%     +69.5%       3913 ± 34%  interrupts.CPU3.NMI:Non-maskable_interrupts
      2309 ± 45%     +69.5%       3913 ± 34%  interrupts.CPU3.PMI:Performance_monitoring_interrupts
      2741 ± 57%     +98.9%       5453 ± 30%  interrupts.CPU37.NMI:Non-maskable_interrupts
      2741 ± 57%     +98.9%       5453 ± 30%  interrupts.CPU37.PMI:Performance_monitoring_interrupts
      2797 ± 32%     +37.2%       3836 ±  7%  interrupts.CPU42.NMI:Non-maskable_interrupts
      2797 ± 32%     +37.2%       3836 ±  7%  interrupts.CPU42.PMI:Performance_monitoring_interrupts
      5760 ± 31%     -45.4%       3143 ± 33%  interrupts.CPU50.NMI:Non-maskable_interrupts
      5760 ± 31%     -45.4%       3143 ± 33%  interrupts.CPU50.PMI:Performance_monitoring_interrupts
    654.50           +43.4%     938.75 ± 21%  interrupts.CPU56.CAL:Function_call_interrupts
    942.75 ± 37%     -30.6%     654.25        interrupts.CPU81.CAL:Function_call_interrupts
    793.50 ± 10%     -17.6%     653.50 ±  3%  interrupts.CPU82.CAL:Function_call_interrupts
      6309 ± 24%     -54.7%       2858 ± 61%  interrupts.CPU84.NMI:Non-maskable_interrupts
      6309 ± 24%     -54.7%       2858 ± 61%  interrupts.CPU84.PMI:Performance_monitoring_interrupts
      5327 ± 30%     -41.7%       3105 ± 17%  interrupts.CPU9.NMI:Non-maskable_interrupts
      5327 ± 30%     -41.7%       3105 ± 17%  interrupts.CPU9.PMI:Performance_monitoring_interrupts
      3778 ± 66%     +66.3%       6284 ± 33%  interrupts.CPU92.NMI:Non-maskable_interrupts
      3778 ± 66%     +66.3%       6284 ± 33%  interrupts.CPU92.PMI:Performance_monitoring_interrupts
    662.25 ±  4%      +8.8%     720.75 ±  8%  interrupts.CPU95.CAL:Function_call_interrupts
     17.28            -7.5%      15.98        perf-stat.i.MPKI
 1.115e+10           +20.2%   1.34e+10        perf-stat.i.branch-instructions
      0.52            -0.0        0.49        perf-stat.i.branch-miss-rate%
  56107202           +13.4%   63617962        perf-stat.i.branch-misses
     35.61            +1.8       37.40        perf-stat.i.cache-miss-rate%
 3.572e+08           +15.6%  4.128e+08        perf-stat.i.cache-misses
 9.999e+08           +10.1%  1.101e+09        perf-stat.i.cache-references
      3.60           -16.1%       3.02        perf-stat.i.cpi
    605.08           -14.0%     520.12        perf-stat.i.cycles-between-cache-misses
 1.761e+10           +18.4%  2.086e+10        perf-stat.i.dTLB-loads
  84716478           +14.0%   96553382        perf-stat.i.dTLB-store-misses
 1.086e+10           +14.2%  1.239e+10        perf-stat.i.dTLB-stores
     91.12            +1.0       92.09        perf-stat.i.iTLB-load-miss-rate%
  35528786           +14.8%   40782994        perf-stat.i.iTLB-load-misses
 5.787e+10           +18.8%  6.877e+10        perf-stat.i.instructions
      1633            +3.8%       1695        perf-stat.i.instructions-per-iTLB-miss
      0.28           +19.1%       0.33        perf-stat.i.ipc
    285.23           +17.5%     335.20        perf-stat.i.metric.M/sec
  11858192           +14.5%   13580221        perf-stat.i.minor-faults
  11851969           +15.4%   13682892        perf-stat.i.node-load-misses
 2.897e+08           +15.4%  3.344e+08        perf-stat.i.node-loads
     16.96            +1.4       18.32        perf-stat.i.node-store-miss-rate%
   9075374           +28.0%   11615910        perf-stat.i.node-store-misses
  44586298           +16.4%   51885017        perf-stat.i.node-stores
  11858196           +14.5%   13580224        perf-stat.i.page-faults
     17.28            -7.4%      16.00        perf-stat.overall.MPKI
      0.50            -0.0        0.47        perf-stat.overall.branch-miss-rate%
     35.72            +1.8       37.51        perf-stat.overall.cache-miss-rate%
      3.60           -16.0%       3.02        perf-stat.overall.cpi
    582.56           -13.6%     503.24        perf-stat.overall.cycles-between-cache-misses
     91.23            +1.0       92.25        perf-stat.overall.iTLB-load-miss-rate%
      1629            +3.5%       1686        perf-stat.overall.instructions-per-iTLB-miss
      0.28           +19.0%       0.33        perf-stat.overall.ipc
     16.91            +1.4       18.29        perf-stat.overall.node-store-miss-rate%
   1462076            +3.9%    1519305        perf-stat.overall.path-length
 1.111e+10           +20.1%  1.335e+10        perf-stat.ps.branch-instructions
  55895802           +13.4%   63379750        perf-stat.ps.branch-misses
  3.56e+08           +15.5%  4.113e+08        perf-stat.ps.cache-misses
 9.965e+08           +10.0%  1.096e+09        perf-stat.ps.cache-references
 1.755e+10           +18.4%  2.078e+10        perf-stat.ps.dTLB-loads
  84430787           +13.9%   96194702        perf-stat.ps.dTLB-store-misses
 1.082e+10           +14.1%  1.235e+10        perf-stat.ps.dTLB-stores
  35410048           +14.8%   40634390        perf-stat.ps.iTLB-load-misses
 5.768e+10           +18.8%  6.852e+10        perf-stat.ps.instructions
  11818655           +14.5%   13530862        perf-stat.ps.minor-faults
  11809592           +15.4%   13631265        perf-stat.ps.node-load-misses
 2.887e+08           +15.4%  3.332e+08        perf-stat.ps.node-loads
   9045541           +28.0%   11574692        perf-stat.ps.node-store-misses
  44438814           +16.3%   51699346        perf-stat.ps.node-stores
  11818659           +14.5%   13530865        perf-stat.ps.page-faults
 1.743e+13           +18.9%  2.073e+13        perf-stat.total.instructions
     11.82 ±  7%      -4.7        7.14 ± 11%  perf-profile.calltrace.cycles-pp.mem_cgroup_charge.do_fault.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
      5.08 ±  7%      -2.3        2.81 ±  9%  perf-profile.calltrace.cycles-pp.get_mem_cgroup_from_mm.mem_cgroup_charge.do_fault.__handle_mm_fault.handle_mm_fault
      1.10 ±  9%      -0.8        0.31 ±100%  perf-profile.calltrace.cycles-pp.mem_cgroup_charge_statistics.mem_cgroup_charge.do_fault.__handle_mm_fault.handle_mm_fault
      1.07 ±  9%      -0.8        0.30 ±100%  perf-profile.calltrace.cycles-pp.__count_memcg_events.mem_cgroup_charge_statistics.mem_cgroup_charge.do_fault.__handle_mm_fault
      1.42 ±  9%      -0.7        0.68 ± 15%  perf-profile.calltrace.cycles-pp.__count_memcg_events.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      1.38 ±  9%      -0.7        0.66 ± 17%  perf-profile.calltrace.cycles-pp.__mod_memcg_state.__mod_memcg_lruvec_state.page_add_new_anon_rmap.alloc_set_pte.finish_fault
      1.69 ±  9%      -0.6        1.11 ± 16%  perf-profile.calltrace.cycles-pp.page_add_new_anon_rmap.alloc_set_pte.finish_fault.do_fault.__handle_mm_fault
      1.51 ±  9%      -0.6        0.94 ± 17%  perf-profile.calltrace.cycles-pp.__mod_memcg_lruvec_state.page_add_new_anon_rmap.alloc_set_pte.finish_fault.do_fault
      0.68 ± 10%      +0.2        0.86 ± 15%  perf-profile.calltrace.cycles-pp.release_pages.tlb_flush_mmu.tlb_finish_mmu.unmap_region.__do_munmap
      0.70 ± 10%      +0.2        0.90 ± 15%  perf-profile.calltrace.cycles-pp.tlb_finish_mmu.unmap_region.__do_munmap.__vm_munmap.__x64_sys_munmap
      0.44 ± 57%      +0.2        0.69 ± 12%  perf-profile.calltrace.cycles-pp._raw_spin_lock.rmqueue_bulk.rmqueue.get_page_from_freelist.__alloc_pages_nodemask
      0.43 ± 57%      +0.2        0.68 ± 11%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.rmqueue_bulk.rmqueue.get_page_from_freelist
      0.00            +0.6        0.64 ± 14%  perf-profile.calltrace.cycles-pp.__mod_memcg_lruvec_state.page_remove_rmap.zap_pte_range.unmap_page_range.unmap_vmas
      0.72 ±  8%      +1.0        1.74 ± 13%  perf-profile.calltrace.cycles-pp.try_charge.mem_cgroup_charge.do_fault.__handle_mm_fault.handle_mm_fault
      0.00            +1.2        1.23 ± 13%  perf-profile.calltrace.cycles-pp.page_counter_try_charge.try_charge.mem_cgroup_charge.do_fault.__handle_mm_fault
      2.25 ± 13%      +1.2        3.49 ± 15%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.release_pages.tlb_flush_mmu.zap_pte_range
      2.27 ± 12%      +1.2        3.51 ± 15%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.release_pages.tlb_flush_mmu.zap_pte_range.unmap_page_range
      5.23 ± 11%      +1.4        6.65 ± 13%  perf-profile.calltrace.cycles-pp.release_pages.tlb_flush_mmu.zap_pte_range.unmap_page_range.unmap_vmas
      5.65 ± 11%      +1.4        7.08 ± 13%  perf-profile.calltrace.cycles-pp.tlb_flush_mmu.zap_pte_range.unmap_page_range.unmap_vmas.unmap_region
      3.75 ± 12%      +1.9        5.61 ± 14%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.pagevec_lru_move_fn.lru_cache_add.alloc_set_pte
      3.79 ± 12%      +1.9        5.67 ± 14%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.pagevec_lru_move_fn.lru_cache_add.alloc_set_pte.finish_fault
      5.58 ± 11%      +1.9        7.48 ± 14%  perf-profile.calltrace.cycles-pp.pagevec_lru_move_fn.lru_cache_add.alloc_set_pte.finish_fault.do_fault
      5.71 ± 11%      +1.9        7.62 ± 14%  perf-profile.calltrace.cycles-pp.lru_cache_add.alloc_set_pte.finish_fault.do_fault.__handle_mm_fault
     11.84 ±  7%      -4.7        7.15 ± 11%  perf-profile.children.cycles-pp.mem_cgroup_charge
      5.09 ±  7%      -2.3        2.82 ±  9%  perf-profile.children.cycles-pp.get_mem_cgroup_from_mm
      2.50 ±  9%      -1.3        1.21 ± 16%  perf-profile.children.cycles-pp.__count_memcg_events
      2.70 ±  9%      -1.1        1.63 ± 13%  perf-profile.children.cycles-pp.native_irq_return_iret
      2.70 ±  9%      -0.9        1.84 ± 14%  perf-profile.children.cycles-pp.__mod_memcg_state
      1.69 ±  9%      -0.6        1.11 ± 16%  perf-profile.children.cycles-pp.page_add_new_anon_rmap
      1.10 ±  9%      -0.6        0.54 ± 17%  perf-profile.children.cycles-pp.mem_cgroup_charge_statistics
      0.52 ± 10%      -0.4        0.14 ± 11%  perf-profile.children.cycles-pp.lock_page_memcg
      0.18 ± 10%      -0.1        0.12 ± 11%  perf-profile.children.cycles-pp.uncharge_page
      0.10 ±  9%      +0.0        0.12 ± 16%  perf-profile.children.cycles-pp.memcg_check_events
      0.05 ±  8%      +0.1        0.10 ± 14%  perf-profile.children.cycles-pp.uncharge_batch
      0.00            +0.1        0.06 ± 14%  perf-profile.children.cycles-pp.page_counter_cancel
      0.00            +0.1        0.06 ± 16%  perf-profile.children.cycles-pp.page_counter_uncharge
      0.00            +0.1        0.10 ± 15%  perf-profile.children.cycles-pp.propagate_protected_usage
      0.71 ± 11%      +0.2        0.90 ± 15%  perf-profile.children.cycles-pp.tlb_finish_mmu
      0.42 ±  8%      +0.8        1.24 ± 13%  perf-profile.children.cycles-pp.page_counter_try_charge
      0.73 ±  8%      +1.0        1.75 ± 13%  perf-profile.children.cycles-pp.try_charge
      6.07 ± 11%      +1.6        7.68 ± 14%  perf-profile.children.cycles-pp.release_pages
      6.35 ± 11%      +1.6        7.98 ± 13%  perf-profile.children.cycles-pp.tlb_flush_mmu
      5.59 ± 11%      +1.9        7.50 ± 14%  perf-profile.children.cycles-pp.pagevec_lru_move_fn
      5.71 ± 11%      +1.9        7.62 ± 14%  perf-profile.children.cycles-pp.lru_cache_add
      6.36 ± 12%      +3.3        9.64 ± 14%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      7.27 ± 12%      +3.5       10.75 ± 14%  perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
      4.82 ±  8%      -2.9        1.95 ±  8%  perf-profile.self.cycles-pp.mem_cgroup_charge
      5.06 ±  7%      -2.3        2.79 ±  9%  perf-profile.self.cycles-pp.get_mem_cgroup_from_mm
      2.50 ±  9%      -1.3        1.21 ± 16%  perf-profile.self.cycles-pp.__count_memcg_events
      2.69 ±  9%      -1.1        1.62 ± 13%  perf-profile.self.cycles-pp.native_irq_return_iret
      2.68 ±  8%      -0.9        1.82 ± 14%  perf-profile.self.cycles-pp.__mod_memcg_state
      0.52 ±  9%      -0.4        0.14 ± 15%  perf-profile.self.cycles-pp.lock_page_memcg
      0.18 ± 10%      -0.1        0.11 ±  9%  perf-profile.self.cycles-pp.uncharge_page
      0.13 ±  9%      +0.1        0.19 ± 12%  perf-profile.self.cycles-pp.shmem_fault
      0.01 ±173%      +0.1        0.07 ± 17%  perf-profile.self.cycles-pp.memcg_check_events
      0.00            +0.1        0.10 ± 18%  perf-profile.self.cycles-pp.propagate_protected_usage
      0.32 ± 10%      +0.2        0.51 ± 14%  perf-profile.self.cycles-pp.try_charge
      0.44 ± 10%      +0.6        1.02 ± 15%  perf-profile.self.cycles-pp.__mod_memcg_lruvec_state
      0.38 ±  9%      +0.8        1.15 ± 13%  perf-profile.self.cycles-pp.page_counter_try_charge
      7.27 ± 12%      +3.5       10.74 ± 14%  perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath



***************************************************************************************************
lkp-skl-fpga01: 104 threads Skylake with 192G memory
=========================================================================================
compiler/cpufreq_governor/kconfig/mode/nr_task/rootfs/tbox_group/test/testcase/ucode:
  gcc-9/performance/x86_64-rhel-8.3/process/50%/debian-10.4-x86_64-20200603.cgz/lkp-skl-fpga01/malloc1/will-it-scale/0x2006906

commit: 
  cf785af193 ("block: warn if !__GFP_DIRECT_RECLAIM in bio_crypt_set_ctx()")
  2b0d3d3e4f ("percpu_ref: reduce memory footprint of percpu_ref in fast path")

cf785af19319f9fc 2b0d3d3e4fcfb19d10f9a82910b 
---------------- --------------------------- 
       fail:runs  %reproduction    fail:runs
           |             |             |    
          0:2           11%           0:3     perf-profile.children.cycles-pp.error_entry
          0:2            5%           0:3     perf-profile.self.cycles-pp.error_entry
         %stddev     %change         %stddev
             \          |                \  
   1217676           -13.0%    1059732 ±  2%  will-it-scale.52.processes
     23416           -13.0%      20379 ±  2%  will-it-scale.per_process_ops
   1217676           -13.0%    1059732 ±  2%  will-it-scale.workload
   2169754 ±  3%     -12.5%    1898524 ±  9%  cpuidle.C1.time
 6.607e+09 ± 66%     -26.6%  4.848e+09 ± 86%  cpuidle.C6.time
     23549 ±  3%      -7.5%      21774 ±  4%  cpuidle.POLL.time
      3974 ±  5%     -11.6%       3512 ±  2%  cpuidle.POLL.usage
 3.646e+08 ± 11%     -15.9%  3.065e+08 ± 10%  numa-numastat.node0.local_node
 3.646e+08 ± 11%     -15.9%  3.065e+08 ± 10%  numa-numastat.node0.numa_hit
     26799 ± 25%     -74.8%       6764 ±140%  numa-numastat.node0.other_node
      6950 ± 95%    +287.9%      26964 ± 34%  numa-numastat.node1.other_node
      1423 ±  2%     -12.8%       1241 ±  9%  slabinfo.Acpi-Parse.active_objs
      1423 ±  2%     -12.8%       1241 ±  9%  slabinfo.Acpi-Parse.num_objs
      4704 ±  4%      -7.9%       4330        slabinfo.skbuff_head_cache.active_objs
      4704 ±  4%      -7.9%       4330        slabinfo.skbuff_head_cache.num_objs
      1195            +1.1%       1208        proc-vmstat.nr_page_table_pages
     15135 ± 52%     -82.6%       2640 ±120%  proc-vmstat.numa_hint_faults
 7.333e+08           -13.1%  6.371e+08 ±  2%  proc-vmstat.numa_hit
 7.332e+08           -13.1%  6.371e+08 ±  2%  proc-vmstat.numa_local
     13562 ± 18%     -81.4%       2518 ±120%  proc-vmstat.numa_pages_migrated
     60036 ± 15%     -80.5%      11696 ± 75%  proc-vmstat.numa_pte_updates
 7.341e+08           -13.1%  6.382e+08 ±  2%  proc-vmstat.pgalloc_normal
 3.676e+08           -13.1%  3.196e+08 ±  2%  proc-vmstat.pgfault
 7.342e+08           -13.1%  6.382e+08 ±  2%  proc-vmstat.pgfree
     13562 ± 18%     -81.4%       2518 ±120%  proc-vmstat.pgmigrate_success
    389.50 ±  2%     +82.5%     711.00 ±  7%  numa-vmstat.node0.nr_active_anon
      3663           +26.2%       4622 ± 12%  numa-vmstat.node0.nr_mapped
    380.00 ±  3%     +91.0%     725.67 ± 10%  numa-vmstat.node0.nr_page_table_pages
    575.00 ± 18%    +290.4%       2244 ± 40%  numa-vmstat.node0.nr_shmem
     10662           +19.0%      12685 ±  2%  numa-vmstat.node0.nr_slab_reclaimable
    389.50 ±  2%     +82.5%     711.00 ±  7%  numa-vmstat.node0.nr_zone_active_anon
 1.821e+08 ± 11%     -15.7%  1.536e+08 ± 10%  numa-vmstat.node0.numa_hit
 1.821e+08 ± 11%     -15.6%  1.536e+08 ± 10%  numa-vmstat.node0.numa_local
     28890 ± 23%     -58.0%      12124 ± 78%  numa-vmstat.node0.numa_other
      5040           -17.8%       4145 ± 13%  numa-vmstat.node1.nr_mapped
    816.50           -41.1%     480.67 ± 14%  numa-vmstat.node1.nr_page_table_pages
     13208           -15.4%      11176        numa-vmstat.node1.nr_slab_reclaimable
      9272 ± 99%     -99.9%      10.84 ±141%  sched_debug.cfs_rq:/.MIN_vruntime.avg
    962811 ± 99%     -99.9%     975.57 ±141%  sched_debug.cfs_rq:/.MIN_vruntime.max
     94016 ± 99%     -99.9%     102.26 ±141%  sched_debug.cfs_rq:/.MIN_vruntime.stddev
      9272 ± 99%     -99.9%      10.84 ±141%  sched_debug.cfs_rq:/.max_vruntime.avg
    962811 ± 99%     -99.9%     975.57 ±141%  sched_debug.cfs_rq:/.max_vruntime.max
     94016 ± 99%     -99.9%     102.26 ±141%  sched_debug.cfs_rq:/.max_vruntime.stddev
      1.22 ± 10%     -14.4%       1.04 ± 19%  sched_debug.cfs_rq:/.nr_spread_over.avg
      2.64 ± 26%     +90.9%       5.04 ±  9%  sched_debug.cfs_rq:/.removed.load_avg.avg
     21.39 ±  8%     +37.2%      29.34        sched_debug.cfs_rq:/.removed.load_avg.stddev
     49.00 ± 10%     -39.2%      29.80 ± 10%  sched_debug.cpu.nr_uninterruptible.max
    -16.00           +54.2%     -24.67        sched_debug.cpu.nr_uninterruptible.min
     11716 ± 10%     -19.2%       9463 ± 11%  sched_debug.cpu.ttwu_local.max
      1687 ±  2%     +74.6%       2946 ±  8%  numa-meminfo.node0.Active
      1559 ±  2%     +82.4%       2844 ±  7%  numa-meminfo.node0.Active(anon)
     42649           +19.0%      50742 ±  2%  numa-meminfo.node0.KReclaimable
     14400           +24.7%      17961 ± 12%  numa-meminfo.node0.Mapped
      1516 ±  3%     +92.0%       2911 ± 10%  numa-meminfo.node0.PageTables
     42649           +19.0%      50742 ±  2%  numa-meminfo.node0.SReclaimable
      2303 ± 18%    +289.9%       8978 ± 40%  numa-meminfo.node0.Shmem
    134586           +11.9%     150653 ±  5%  numa-meminfo.node0.Slab
     52831           -15.4%      44704        numa-meminfo.node1.KReclaimable
     19878           -17.2%      16451 ± 14%  numa-meminfo.node1.Mapped
   1336465            -9.0%    1216509 ±  6%  numa-meminfo.node1.MemUsed
      3275           -41.3%       1922 ± 14%  numa-meminfo.node1.PageTables
     52831           -15.4%      44704        numa-meminfo.node1.SReclaimable
     19450 ± 83%     -83.6%       3182        softirqs.CPU12.SCHED
     32978 ± 12%     -90.5%       3118        softirqs.CPU14.SCHED
      4148 ± 28%    +662.9%      31646 ± 26%  softirqs.CPU15.SCHED
     20248 ± 84%     -84.5%       3133        softirqs.CPU16.SCHED
     20356 ± 83%     -84.9%       3069 ±  3%  softirqs.CPU18.SCHED
     20649 ± 82%     -86.3%       2831 ± 14%  softirqs.CPU26.SCHED
     34769 ±  8%     -84.1%       5520 ± 63%  softirqs.CPU28.SCHED
     18485 ± 82%     -82.7%       3195 ±  3%  softirqs.CPU30.SCHED
      3179 ±  4%   +1097.6%      38070        softirqs.CPU33.SCHED
     20469 ± 84%     -84.7%       3134        softirqs.CPU34.SCHED
     20475 ± 84%     -46.6%      10927 ±100%  softirqs.CPU36.SCHED
     20919 ± 83%     -51.0%      10241 ± 98%  softirqs.CPU38.SCHED
     31296 ± 12%     -89.6%       3241 ±  2%  softirqs.CPU4.SCHED
     20495 ± 84%     -85.1%       3063        softirqs.CPU42.SCHED
     20518 ± 84%     -84.7%       3137 ±  3%  softirqs.CPU44.SCHED
     39351 ±  3%     -67.4%      12843 ± 54%  softirqs.CPU46.SCHED
     20716 ± 83%     -29.5%      14604 ±111%  softirqs.CPU50.SCHED
      9714 ± 39%    +290.2%      37906        softirqs.CPU56.SCHED
     22690 ± 66%     -52.6%      10749 ±100%  softirqs.CPU6.SCHED
     20285 ± 84%     -28.7%      14468 ±111%  softirqs.CPU61.SCHED
     20274 ± 84%     -84.6%       3122 ±  2%  softirqs.CPU65.SCHED
      7772 ± 48%    +386.1%      37781        softirqs.CPU66.SCHED
     36570 ±  2%     -74.0%       9505 ± 90%  softirqs.CPU67.SCHED
      6234 ± 50%    +463.3%      35116 ±  9%  softirqs.CPU80.SCHED
     20516 ± 84%     -75.0%       5126 ± 55%  softirqs.CPU83.SCHED
     38065           -91.7%       3173 ±  3%  softirqs.CPU85.SCHED
     20484 ± 84%     -84.8%       3111 ±  2%  softirqs.CPU89.SCHED
     20571 ± 84%     -84.7%       3152        softirqs.CPU91.SCHED
     20537 ± 84%     -75.9%       4952 ± 53%  softirqs.CPU95.SCHED
      3134          +833.3%      29249 ± 28%  softirqs.CPU98.SCHED
     35999 ±  5%     -35.1%      23348 ± 62%  softirqs.CPU99.SCHED
     18.62           +15.8%      21.56        perf-stat.i.MPKI
 6.176e+09           -12.5%  5.404e+09 ±  2%  perf-stat.i.branch-instructions
      0.48            +0.0        0.48        perf-stat.i.branch-miss-rate%
  29155676           -11.0%   25947096        perf-stat.i.branch-misses
     25.60            +0.9       26.49        perf-stat.i.cache-miss-rate%
 1.349e+08            +4.7%  1.412e+08        perf-stat.i.cache-misses
      5.17           +14.4%       5.91 ±  2%  perf-stat.i.cpi
      1086            -4.5%       1037        perf-stat.i.cycles-between-cache-misses
   4863474           -12.2%    4269936 ±  2%  perf-stat.i.dTLB-load-misses
  7.44e+09           -12.5%  6.512e+09 ±  2%  perf-stat.i.dTLB-loads
   4871891           -13.0%    4239459 ±  2%  perf-stat.i.dTLB-store-misses
 3.183e+09           -12.5%  2.785e+09 ±  2%  perf-stat.i.dTLB-stores
      4.51            +0.1        4.63        perf-stat.i.iTLB-load-miss-rate%
   4946681            -9.4%    4481880 ±  2%  perf-stat.i.iTLB-load-misses
 1.051e+08           -12.0%   92511341        perf-stat.i.iTLB-loads
 2.827e+10           -12.5%  2.474e+10 ±  2%  perf-stat.i.instructions
      5802            -3.2%       5618        perf-stat.i.instructions-per-iTLB-miss
      0.20           -12.5%       0.17 ±  2%  perf-stat.i.ipc
    168.00           -12.0%     147.85 ±  2%  perf-stat.i.metric.M/sec
   1216995           -13.0%    1059028 ±  2%  perf-stat.i.minor-faults
  17897885           +25.6%   22487001        perf-stat.i.node-load-misses
   2058143           +27.6%    2626451 ±  3%  perf-stat.i.node-loads
  17131463            +3.4%   17708330        perf-stat.i.node-store-misses
   1216996           -13.0%    1059029 ±  2%  perf-stat.i.page-faults
     18.62           +15.8%      21.56        perf-stat.overall.MPKI
      0.47            +0.0        0.48        perf-stat.overall.branch-miss-rate%
     25.62            +0.9       26.49 ±  2%  perf-stat.overall.cache-miss-rate%
      5.17           +14.4%       5.92 ±  2%  perf-stat.overall.cpi
      1084            -4.4%       1035        perf-stat.overall.cycles-between-cache-misses
      4.49            +0.1        4.62        perf-stat.overall.iTLB-load-miss-rate%
      5714            -3.4%       5521        perf-stat.overall.instructions-per-iTLB-miss
      0.19           -12.5%       0.17 ±  2%  perf-stat.overall.ipc
 6.154e+09           -12.5%  5.386e+09 ±  2%  perf-stat.ps.branch-instructions
  28990877           -10.9%   25835386        perf-stat.ps.branch-misses
 1.344e+08            +4.7%  1.408e+08        perf-stat.ps.cache-misses
   4846986           -12.2%    4255712 ±  2%  perf-stat.ps.dTLB-load-misses
 7.413e+09           -12.4%   6.49e+09 ±  2%  perf-stat.ps.dTLB-loads
   4855347           -13.0%    4225561 ±  2%  perf-stat.ps.dTLB-store-misses
 3.172e+09           -12.5%  2.776e+09 ±  2%  perf-stat.ps.dTLB-stores
   4929905            -9.4%    4467205 ±  2%  perf-stat.ps.iTLB-load-misses
 1.048e+08           -12.0%   92206666        perf-stat.ps.iTLB-loads
 2.817e+10           -12.5%  2.466e+10 ±  2%  perf-stat.ps.instructions
   1212867           -13.0%    1055544 ±  2%  perf-stat.ps.minor-faults
  17835927           +25.7%   22412778        perf-stat.ps.node-load-misses
   2051127           +27.6%    2617791 ±  3%  perf-stat.ps.node-loads
  17073809            +3.4%   17649933        perf-stat.ps.node-store-misses
   1212867           -13.0%    1055545 ±  2%  perf-stat.ps.page-faults
 8.503e+12           -12.3%  7.458e+12 ±  2%  perf-stat.total.instructions
      8982 ± 66%     -92.0%     719.33 ± 72%  interrupts.38:PCI-MSI.67633153-edge.eth0-TxRx-0
      5376 ± 46%     -40.1%       3220 ± 15%  interrupts.CPU101.NMI:Non-maskable_interrupts
      5376 ± 46%     -40.1%       3220 ± 15%  interrupts.CPU101.PMI:Performance_monitoring_interrupts
      5385 ± 46%     -43.1%       3066 ±  9%  interrupts.CPU11.NMI:Non-maskable_interrupts
      5385 ± 46%     -43.1%       3066 ±  9%  interrupts.CPU11.PMI:Performance_monitoring_interrupts
     79.00 ± 50%     -74.3%      20.33 ± 79%  interrupts.CPU11.RES:Rescheduling_interrupts
      3398 ± 15%     +93.1%       6562 ± 28%  interrupts.CPU12.NMI:Non-maskable_interrupts
      3398 ± 15%     +93.1%       6562 ± 28%  interrupts.CPU12.PMI:Performance_monitoring_interrupts
     68.50 ± 66%     -74.2%      17.67 ± 30%  interrupts.CPU13.RES:Rescheduling_interrupts
      2144 ± 33%    +267.2%       7875        interrupts.CPU14.NMI:Non-maskable_interrupts
      2144 ± 33%    +267.2%       7875        interrupts.CPU14.PMI:Performance_monitoring_interrupts
      5908 ± 33%     -51.0%       2893        interrupts.CPU15.NMI:Non-maskable_interrupts
      5908 ± 33%     -51.0%       2893        interrupts.CPU15.PMI:Performance_monitoring_interrupts
     16.50 ±  3%    +540.4%     105.67 ± 62%  interrupts.CPU18.RES:Rescheduling_interrupts
      8.50 ± 88%    +586.3%      58.33 ± 72%  interrupts.CPU2.RES:Rescheduling_interrupts
     10.00 ± 40%    +930.0%     103.00 ± 64%  interrupts.CPU20.RES:Rescheduling_interrupts
    122.00 ±  5%     -86.9%      16.00 ± 77%  interrupts.CPU21.RES:Rescheduling_interrupts
    510.50 ±  8%     -49.5%     258.00 ±  4%  interrupts.CPU27.CAL:Function_call_interrupts
    476.50 ±  4%      -5.4%     450.67        interrupts.CPU28.CAL:Function_call_interrupts
      2146 ± 33%    +267.0%       7876        interrupts.CPU28.NMI:Non-maskable_interrupts
      2146 ± 33%    +267.0%       7876        interrupts.CPU28.PMI:Performance_monitoring_interrupts
     67.00 ± 76%     -81.1%      12.67 ± 61%  interrupts.CPU29.RES:Rescheduling_interrupts
      8982 ± 66%     -92.0%     719.33 ± 72%  interrupts.CPU30.38:PCI-MSI.67633153-edge.eth0-TxRx-0
      5907 ± 33%     -51.5%       2867        interrupts.CPU33.NMI:Non-maskable_interrupts
      5907 ± 33%     -51.5%       2867        interrupts.CPU33.PMI:Performance_monitoring_interrupts
      1103 ± 59%     -59.3%     449.33        interrupts.CPU34.CAL:Function_call_interrupts
     68.50 ± 63%     -61.6%      26.33 ± 70%  interrupts.CPU35.RES:Rescheduling_interrupts
      3409 ± 15%     -16.0%       2863        interrupts.CPU37.NMI:Non-maskable_interrupts
      3409 ± 15%     -16.0%       2863        interrupts.CPU37.PMI:Performance_monitoring_interrupts
     63.00 ± 76%     -72.5%      17.33 ± 86%  interrupts.CPU37.RES:Rescheduling_interrupts
     10.00 ± 30%    +956.7%     105.67 ± 62%  interrupts.CPU38.RES:Rescheduling_interrupts
      3400 ± 15%     -29.8%       2388 ± 28%  interrupts.CPU39.NMI:Non-maskable_interrupts
      3400 ± 15%     -29.8%       2388 ± 28%  interrupts.CPU39.PMI:Performance_monitoring_interrupts
     67.00 ± 68%     -81.1%      12.67 ±  9%  interrupts.CPU39.RES:Rescheduling_interrupts
      2160 ± 32%    +203.7%       6560 ± 28%  interrupts.CPU4.NMI:Non-maskable_interrupts
      2160 ± 32%    +203.7%       6560 ± 28%  interrupts.CPU4.PMI:Performance_monitoring_interrupts
     13.00          +679.5%     101.33 ± 64%  interrupts.CPU40.RES:Rescheduling_interrupts
     11.00 ± 18%    +830.3%     102.33 ± 64%  interrupts.CPU42.RES:Rescheduling_interrupts
      7.50 ± 60%   +1268.9%     102.67 ± 62%  interrupts.CPU44.RES:Rescheduling_interrupts
      5376 ± 46%     -24.5%       4058 ± 67%  interrupts.CPU5.NMI:Non-maskable_interrupts
      5376 ± 46%     -24.5%       4058 ± 67%  interrupts.CPU5.PMI:Performance_monitoring_interrupts
     13.00 ±  7%    +425.6%      68.33 ±104%  interrupts.CPU50.RES:Rescheduling_interrupts
      7879           -69.7%       2390 ± 28%  interrupts.CPU56.NMI:Non-maskable_interrupts
      7879           -69.7%       2390 ± 28%  interrupts.CPU56.PMI:Performance_monitoring_interrupts
      1.50 ± 33%  +14011.1%     211.67 ±136%  interrupts.CPU56.TLB:TLB_shootdowns
     10.00 ± 80%   +3200.0%     330.00 ± 80%  interrupts.CPU57.RES:Rescheduling_interrupts
      5374 ± 46%     -24.5%       4055 ± 68%  interrupts.CPU58.NMI:Non-maskable_interrupts
      5374 ± 46%     -24.5%       4055 ± 68%  interrupts.CPU58.PMI:Performance_monitoring_interrupts
      8.50 ±100%   +1256.9%     115.33 ± 40%  interrupts.CPU59.RES:Rescheduling_interrupts
      9.50 ±100%   +1380.7%     140.67 ± 18%  interrupts.CPU6.RES:Rescheduling_interrupts
    353.50 ± 99%     -99.2%       2.67 ± 88%  interrupts.CPU60.TLB:TLB_shootdowns
     24.00 ± 29%    +366.7%     112.00 ± 45%  interrupts.CPU61.RES:Rescheduling_interrupts
      3405 ± 15%    +125.2%       7668 ±  3%  interrupts.CPU63.NMI:Non-maskable_interrupts
      3405 ± 15%    +125.2%       7668 ±  3%  interrupts.CPU63.PMI:Performance_monitoring_interrupts
     92.50 ± 23%     -71.2%      26.67 ± 32%  interrupts.CPU64.RES:Rescheduling_interrupts
      3405 ± 15%    +131.2%       7874        interrupts.CPU65.NMI:Non-maskable_interrupts
      3405 ± 15%    +131.2%       7874        interrupts.CPU65.PMI:Performance_monitoring_interrupts
      7878           -69.6%       2393 ± 28%  interrupts.CPU66.NMI:Non-maskable_interrupts
      7878           -69.6%       2393 ± 28%  interrupts.CPU66.PMI:Performance_monitoring_interrupts
     68.00 ± 75%     -73.0%      18.33 ± 68%  interrupts.CPU66.RES:Rescheduling_interrupts
      2857          +175.5%       7873        interrupts.CPU67.NMI:Non-maskable_interrupts
      2857          +175.5%       7873        interrupts.CPU67.PMI:Performance_monitoring_interrupts
    452.00          +129.6%       1038 ± 66%  interrupts.CPU68.CAL:Function_call_interrupts
      5372 ± 46%     -24.5%       4056 ± 68%  interrupts.CPU7.NMI:Non-maskable_interrupts
      5372 ± 46%     -24.5%       4056 ± 68%  interrupts.CPU7.PMI:Performance_monitoring_interrupts
      1.00         +9866.7%      99.67 ±136%  interrupts.CPU7.TLB:TLB_shootdowns
      5371 ± 46%     -64.2%       1921 ± 34%  interrupts.CPU70.NMI:Non-maskable_interrupts
      5371 ± 46%     -64.2%       1921 ± 34%  interrupts.CPU70.PMI:Performance_monitoring_interrupts
    416.50 ± 71%     -81.8%      75.67 ± 71%  interrupts.CPU72.RES:Rescheduling_interrupts
    451.00          +149.4%       1125 ± 65%  interrupts.CPU74.CAL:Function_call_interrupts
     66.50 ± 66%     -81.5%      12.33 ± 45%  interrupts.CPU78.RES:Rescheduling_interrupts
      8.50 ± 29%   +1221.6%     112.33 ± 43%  interrupts.CPU79.RES:Rescheduling_interrupts
      7876           -63.7%       2861        interrupts.CPU80.NMI:Non-maskable_interrupts
      7876           -63.7%       2861        interrupts.CPU80.PMI:Performance_monitoring_interrupts
     61.00 ± 80%     -87.4%       7.67 ± 40%  interrupts.CPU80.RES:Rescheduling_interrupts
     13.00 ± 15%    +674.4%     100.67 ± 58%  interrupts.CPU81.RES:Rescheduling_interrupts
     63.50 ± 77%     -68.5%      20.00 ± 91%  interrupts.CPU82.RES:Rescheduling_interrupts
    926.00 ± 51%     -51.3%     451.33        interrupts.CPU83.CAL:Function_call_interrupts
      2857          +175.7%       7876        interrupts.CPU85.NMI:Non-maskable_interrupts
      2857          +175.7%       7876        interrupts.CPU85.PMI:Performance_monitoring_interrupts
    547.50 ± 16%     -17.3%     452.67        interrupts.CPU87.CAL:Function_call_interrupts
      5396 ± 45%     -19.6%       4339 ± 48%  interrupts.CPU88.NMI:Non-maskable_interrupts
      5396 ± 45%     -19.6%       4339 ± 48%  interrupts.CPU88.PMI:Performance_monitoring_interrupts
    539.00 ± 15%     -16.3%     451.33        interrupts.CPU89.CAL:Function_call_interrupts
     11.50 ±  4%    +705.8%      92.67 ± 64%  interrupts.CPU89.RES:Rescheduling_interrupts
      8.50 ± 17%    +990.2%      92.67 ± 61%  interrupts.CPU91.RES:Rescheduling_interrupts
      5373 ± 46%     -40.0%       3222 ± 15%  interrupts.CPU92.NMI:Non-maskable_interrupts
      5373 ± 46%     -40.0%       3222 ± 15%  interrupts.CPU92.PMI:Performance_monitoring_interrupts
      5383 ± 46%     -55.6%       2390 ± 28%  interrupts.CPU94.NMI:Non-maskable_interrupts
      5383 ± 46%     -55.6%       2390 ± 28%  interrupts.CPU94.PMI:Performance_monitoring_interrupts
     55.00 ± 94%     -93.3%       3.67 ±105%  interrupts.CPU94.RES:Rescheduling_interrupts
     11.00          +733.3%      91.67 ± 64%  interrupts.CPU95.RES:Rescheduling_interrupts
      5366 ± 46%     -55.2%       2402 ± 28%  interrupts.CPU96.NMI:Non-maskable_interrupts
      5366 ± 46%     -55.2%       2402 ± 28%  interrupts.CPU96.PMI:Performance_monitoring_interrupts
     60.00 ± 76%     -84.4%       9.33 ±105%  interrupts.CPU96.RES:Rescheduling_interrupts
     11.50 ±  4%    +700.0%      92.00 ± 63%  interrupts.CPU97.RES:Rescheduling_interrupts
      7875           -43.9%       4417 ± 59%  interrupts.CPU98.NMI:Non-maskable_interrupts
      7875           -43.9%       4417 ± 59%  interrupts.CPU98.PMI:Performance_monitoring_interrupts
      1325 ±  5%     -44.9%     730.67 ± 39%  interrupts.TLB:TLB_shootdowns
     12.26            -1.7       10.55 ±  2%  perf-profile.calltrace.cycles-pp.flush_tlb_mm_range.tlb_flush_mmu.tlb_finish_mmu.unmap_region.__do_munmap
     12.14            -1.7       10.45 ±  2%  perf-profile.calltrace.cycles-pp.flush_tlb_func_common.flush_tlb_mm_range.tlb_flush_mmu.tlb_finish_mmu.unmap_region
     12.03            -1.7       10.34 ±  2%  perf-profile.calltrace.cycles-pp.native_flush_tlb_one_user.flush_tlb_func_common.flush_tlb_mm_range.tlb_flush_mmu.tlb_finish_mmu
      2.77 ±  6%      -0.7        2.02 ± 15%  perf-profile.calltrace.cycles-pp.mem_cgroup_charge.do_anonymous_page.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
      1.77 ± 12%      -0.5        1.27 ± 15%  perf-profile.calltrace.cycles-pp.uncharge_page.mem_cgroup_uncharge_list.release_pages.tlb_flush_mmu.tlb_finish_mmu
      0.88 ±  8%      -0.4        0.46 ± 72%  perf-profile.calltrace.cycles-pp.get_mem_cgroup_from_mm.mem_cgroup_charge.do_anonymous_page.__handle_mm_fault.handle_mm_fault
      0.86 ±  8%      -0.4        0.44 ± 72%  perf-profile.calltrace.cycles-pp.get_mem_cgroup_from_mm.__memcg_kmem_charge_page.__alloc_pages_nodemask.pte_alloc_one.__pte_alloc
      1.92            -0.2        1.74        perf-profile.calltrace.cycles-pp.__mmap
      1.52            -0.1        1.39        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__mmap
      1.94            -0.1        1.81        perf-profile.calltrace.cycles-pp.unmap_vmas.unmap_region.__do_munmap.__vm_munmap.__x64_sys_munmap
      1.83            -0.1        1.73        perf-profile.calltrace.cycles-pp.unmap_page_range.unmap_vmas.unmap_region.__do_munmap.__vm_munmap
      1.21            -0.1        1.12        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__mmap
      1.17            -0.1        1.09        perf-profile.calltrace.cycles-pp.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe.__mmap
      1.17            -0.1        1.10        perf-profile.calltrace.cycles-pp.ksys_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe.__mmap
      0.99            -0.1        0.94        perf-profile.calltrace.cycles-pp.do_mmap.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.83            -0.0        0.79        perf-profile.calltrace.cycles-pp.mmap_region.do_mmap.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64
      0.54            -0.0        0.52        perf-profile.calltrace.cycles-pp.free_pgtables.unmap_region.__do_munmap.__vm_munmap.__x64_sys_munmap
      0.66            +0.0        0.69 ±  3%  perf-profile.calltrace.cycles-pp.kmem_cache_alloc.__anon_vma_prepare.do_anonymous_page.__handle_mm_fault.handle_mm_fault
      0.84            +0.1        0.89        perf-profile.calltrace.cycles-pp.zap_pte_range.unmap_page_range.unmap_vmas.unmap_region.__do_munmap
     11.16 ±  3%      +1.5       12.65        perf-profile.calltrace.cycles-pp.propagate_protected_usage.page_counter_cancel.page_counter_uncharge.uncharge_batch.mem_cgroup_uncharge_list
     31.93            +2.0       33.91        perf-profile.calltrace.cycles-pp.mem_cgroup_uncharge_list.release_pages.tlb_flush_mmu.tlb_finish_mmu.unmap_region
     33.98            +2.2       36.16 ±  2%  perf-profile.calltrace.cycles-pp.release_pages.tlb_flush_mmu.tlb_finish_mmu.unmap_region.__do_munmap
     29.06            +2.3       31.35        perf-profile.calltrace.cycles-pp.page_counter_cancel.page_counter_uncharge.uncharge_batch.mem_cgroup_uncharge_list.release_pages
     29.89            +2.4       32.34        perf-profile.calltrace.cycles-pp.page_counter_uncharge.uncharge_batch.mem_cgroup_uncharge_list.release_pages.tlb_flush_mmu
     30.15            +2.5       32.62        perf-profile.calltrace.cycles-pp.uncharge_batch.mem_cgroup_uncharge_list.release_pages.tlb_flush_mmu.tlb_finish_mmu
      1.73 ±  6%      +2.6        4.32 ±  3%  perf-profile.calltrace.cycles-pp.propagate_protected_usage.page_counter_try_charge.__memcg_kmem_charge.__memcg_kmem_charge_page.__alloc_pages_nodemask
     12.27            -1.7       10.55 ±  2%  perf-profile.children.cycles-pp.flush_tlb_mm_range
     12.16            -1.7       10.46 ±  2%  perf-profile.children.cycles-pp.flush_tlb_func_common
     12.04            -1.7       10.36 ±  2%  perf-profile.children.cycles-pp.native_flush_tlb_one_user
      2.77 ±  6%      -0.7        2.03 ± 15%  perf-profile.children.cycles-pp.mem_cgroup_charge
      1.73 ±  8%      -0.5        1.20 ± 20%  perf-profile.children.cycles-pp.get_mem_cgroup_from_mm
      1.77 ± 12%      -0.5        1.27 ± 15%  perf-profile.children.cycles-pp.uncharge_page
      1.94            -0.2        1.77        perf-profile.children.cycles-pp.__mmap
      1.94            -0.1        1.81        perf-profile.children.cycles-pp.unmap_vmas
      1.89            -0.1        1.77        perf-profile.children.cycles-pp.unmap_page_range
      0.56            -0.1        0.47 ±  2%  perf-profile.children.cycles-pp.___might_sleep
      1.17            -0.1        1.09        perf-profile.children.cycles-pp.vm_mmap_pgoff
      0.35            -0.1        0.27        perf-profile.children.cycles-pp.free_pgd_range
      1.17            -0.1        1.10        perf-profile.children.cycles-pp.ksys_mmap_pgoff
      0.41            -0.1        0.34 ±  2%  perf-profile.children.cycles-pp.syscall_return_via_sysret
      0.84            -0.1        0.77 ±  3%  perf-profile.children.cycles-pp.try_charge
      0.40 ±  2%      -0.1        0.34 ±  2%  perf-profile.children.cycles-pp.entry_SYSCALL_64
      1.00            -0.1        0.94        perf-profile.children.cycles-pp.do_mmap
      0.34            -0.1        0.29        perf-profile.children.cycles-pp.get_page_from_freelist
      0.17 ±  2%      -0.0        0.14 ±  3%  perf-profile.children.cycles-pp.__irqentry_text_end
      0.41 ±  3%      -0.0        0.37 ±  2%  perf-profile.children.cycles-pp.__pagevec_lru_add_fn
      0.24 ±  2%      -0.0        0.21 ±  3%  perf-profile.children.cycles-pp.alloc_pages_vma
      0.34 ±  4%      -0.0        0.31        perf-profile.children.cycles-pp._cond_resched
      0.83            -0.0        0.80        perf-profile.children.cycles-pp.mmap_region
      0.20            -0.0        0.17 ±  2%  perf-profile.children.cycles-pp.perf_event_mmap
      0.13            -0.0        0.10 ±  4%  perf-profile.children.cycles-pp.perf_iterate_sb
      0.20 ±  4%      -0.0        0.17 ±  2%  perf-profile.children.cycles-pp.rcu_all_qs
      0.55 ±  2%      -0.0        0.52        perf-profile.children.cycles-pp.free_pgtables
      0.11            -0.0        0.09 ±  5%  perf-profile.children.cycles-pp.rmqueue
      0.09            -0.0        0.07 ±  7%  perf-profile.children.cycles-pp.mem_cgroup_update_lru_size
      0.16 ±  6%      -0.0        0.14 ±  3%  perf-profile.children.cycles-pp.sync_regs
      0.17            -0.0        0.15        perf-profile.children.cycles-pp.clear_page_erms
      0.10            -0.0        0.08        perf-profile.children.cycles-pp._raw_spin_lock
      0.19            -0.0        0.17        perf-profile.children.cycles-pp.prep_new_page
      0.10 ±  5%      -0.0        0.08 ± 16%  perf-profile.children.cycles-pp.__list_del_entry_valid
      0.52            -0.0        0.50        perf-profile.children.cycles-pp.unlink_anon_vmas
      0.10            -0.0        0.08 ±  5%  perf-profile.children.cycles-pp.__list_add_valid
      0.07            -0.0        0.06 ±  8%  perf-profile.children.cycles-pp.__perf_sw_event
      0.13            -0.0        0.12        perf-profile.children.cycles-pp.free_unref_page_list
      0.07            -0.0        0.06        perf-profile.children.cycles-pp.malloc
      0.07            -0.0        0.06        perf-profile.children.cycles-pp.down_write_killable
      0.09            -0.0        0.08        perf-profile.children.cycles-pp.arch_get_unmapped_area_topdown
      0.08            -0.0        0.07        perf-profile.children.cycles-pp.obj_cgroup_charge
      0.08            -0.0        0.07        perf-profile.children.cycles-pp.find_vma
      0.41            +0.0        0.43        perf-profile.children.cycles-pp.vm_area_alloc
      0.07            +0.0        0.09        perf-profile.children.cycles-pp.mem_cgroup_page_lruvec
      0.14            +0.0        0.16 ±  5%  perf-profile.children.cycles-pp.page_remove_rmap
      0.07 ±  7%      +0.0        0.09 ±  9%  perf-profile.children.cycles-pp.lock_page_memcg
      0.34            +0.0        0.37 ±  5%  perf-profile.children.cycles-pp.remove_vma
      0.33 ±  4%      +0.0        0.38 ±  2%  perf-profile.children.cycles-pp.native_irq_return_iret
      0.09            +0.0        0.13 ±  3%  perf-profile.children.cycles-pp.mem_cgroup_charge_statistics
      0.85            +0.0        0.89 ±  2%  perf-profile.children.cycles-pp.zap_pte_range
      1.05            +0.1        1.10 ±  2%  perf-profile.children.cycles-pp.kmem_cache_alloc
      0.30 ±  3%      +0.1        0.41        perf-profile.children.cycles-pp.__count_memcg_events
      0.61            +0.2        0.78        perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      0.77 ±  5%      +0.2        0.98 ±  3%  perf-profile.children.cycles-pp.__mod_memcg_lruvec_state
      0.58 ±  8%      +0.2        0.83        perf-profile.children.cycles-pp.__mod_memcg_state
     31.94            +2.0       33.92        perf-profile.children.cycles-pp.mem_cgroup_uncharge_list
     34.31            +2.2       36.47 ±  2%  perf-profile.children.cycles-pp.release_pages
     29.09            +2.3       31.39        perf-profile.children.cycles-pp.page_counter_cancel
     29.91            +2.5       32.36        perf-profile.children.cycles-pp.page_counter_uncharge
     30.16            +2.5       32.63        perf-profile.children.cycles-pp.uncharge_batch
     13.37 ±  3%      +3.9       17.26        perf-profile.children.cycles-pp.propagate_protected_usage
     12.02            -1.7       10.34        perf-profile.self.cycles-pp.native_flush_tlb_one_user
      9.63 ±  7%      -1.4        8.27 ±  3%  perf-profile.self.cycles-pp.page_counter_try_charge
      1.73 ±  8%      -0.5        1.20 ± 21%  perf-profile.self.cycles-pp.get_mem_cgroup_from_mm
      1.77 ± 12%      -0.5        1.27 ± 15%  perf-profile.self.cycles-pp.uncharge_page
      1.42 ±  9%      -0.5        0.92 ± 22%  perf-profile.self.cycles-pp.mem_cgroup_charge
      0.56            -0.1        0.46 ±  2%  perf-profile.self.cycles-pp.___might_sleep
      0.33            -0.1        0.25        perf-profile.self.cycles-pp.free_pgd_range
      0.41 ±  2%      -0.1        0.34 ±  2%  perf-profile.self.cycles-pp.syscall_return_via_sysret
      0.55            -0.1        0.48 ±  2%  perf-profile.self.cycles-pp.release_pages
      0.17 ±  2%      -0.1        0.12 ±  6%  perf-profile.self.cycles-pp.try_charge
      0.36 ±  2%      -0.1        0.31        perf-profile.self.cycles-pp.unmap_page_range
      0.35 ±  2%      -0.0        0.30 ±  2%  perf-profile.self.cycles-pp.entry_SYSCALL_64
      0.30            -0.0        0.27 ±  4%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.17 ±  2%      -0.0        0.14 ±  3%  perf-profile.self.cycles-pp.__irqentry_text_end
      0.15 ±  3%      -0.0        0.12 ±  4%  perf-profile.self.cycles-pp.flush_tlb_func_common
      0.14 ±  3%      -0.0        0.11 ±  4%  perf-profile.self.cycles-pp.__pagevec_lru_add_fn
      0.09            -0.0        0.07 ±  7%  perf-profile.self.cycles-pp.mem_cgroup_update_lru_size
      0.17            -0.0        0.15        perf-profile.self.cycles-pp.clear_page_erms
      0.10            -0.0        0.08        perf-profile.self.cycles-pp._raw_spin_lock
      0.15 ±  3%      -0.0        0.13 ±  3%  perf-profile.self.cycles-pp.rcu_all_qs
      0.15 ±  3%      -0.0        0.14 ±  3%  perf-profile.self.cycles-pp.free_pages_and_swap_cache
      0.15 ±  3%      -0.0        0.14 ±  3%  perf-profile.self.cycles-pp.sync_regs
      0.15            -0.0        0.13 ±  3%  perf-profile.self.cycles-pp._cond_resched
      0.08 ±  6%      -0.0        0.06        perf-profile.self.cycles-pp.rmqueue
      0.10 ±  5%      -0.0        0.08        perf-profile.self.cycles-pp.__list_add_valid
      0.07            -0.0        0.06 ±  8%  perf-profile.self.cycles-pp.perf_iterate_sb
      0.07            -0.0        0.06        perf-profile.self.cycles-pp.free_unref_page_list
      0.07            +0.0        0.09        perf-profile.self.cycles-pp.mem_cgroup_page_lruvec
      0.62            +0.0        0.65        perf-profile.self.cycles-pp.zap_pte_range
      0.26            +0.0        0.28 ±  4%  perf-profile.self.cycles-pp.get_obj_cgroup_from_current
      0.06            +0.0        0.09 ±  9%  perf-profile.self.cycles-pp.lock_page_memcg
      0.33 ±  4%      +0.0        0.38 ±  2%  perf-profile.self.cycles-pp.native_irq_return_iret
      0.30 ±  3%      +0.1        0.41        perf-profile.self.cycles-pp.__count_memcg_events
      0.81 ±  2%      +0.2        0.97 ±  7%  perf-profile.self.cycles-pp.page_counter_uncharge
      0.60            +0.2        0.77        perf-profile.self.cycles-pp.syscall_exit_to_user_mode
      0.58 ±  8%      +0.2        0.83        perf-profile.self.cycles-pp.__mod_memcg_state
     17.82 ±  2%      +0.8       18.63 ±  2%  perf-profile.self.cycles-pp.page_counter_cancel
     13.30 ±  3%      +3.9       17.18        perf-profile.self.cycles-pp.propagate_protected_usage



***************************************************************************************************
lkp-csl-2sp4: 96 threads Intel(R) Xeon(R) CPU @ 2.30GHz with 128G memory
=========================================================================================
compiler/cpufreq_governor/ipc/iterations/kconfig/mode/nr_threads/rootfs/tbox_group/testcase/ucode:
  gcc-9/performance/socket/10/x86_64-rhel-8.3/process/50%/debian-10.4-x86_64-20200603.cgz/lkp-csl-2sp4/hackbench/0x4003003

commit: 
  cf785af193 ("block: warn if !__GFP_DIRECT_RECLAIM in bio_crypt_set_ctx()")
  2b0d3d3e4f ("percpu_ref: reduce memory footprint of percpu_ref in fast path")

cf785af19319f9fc 2b0d3d3e4fcfb19d10f9a82910b 
---------------- --------------------------- 
       fail:runs  %reproduction    fail:runs
           |             |             |    
           :2           50%           1:2     last_state.booting
           :2          100%           2:2     last_state.is_incomplete_run



***************************************************************************************************
lkp-csl-2ap4: 192 threads Intel(R) Xeon(R) Platinum 9242 CPU @ 2.30GHz with 192G memory
=========================================================================================
compiler/cpufreq_governor/kconfig/rootfs/runtime/tbox_group/test/testcase/ucode:
  gcc-9/performance/x86_64-rhel-8.3/debian-10.4-x86_64-20200603.cgz/300s/lkp-csl-2ap4/lru-file-mmap-read-rand/vm-scalability/0x5002f01

commit: 
  cf785af193 ("block: warn if !__GFP_DIRECT_RECLAIM in bio_crypt_set_ctx()")
  2b0d3d3e4f ("percpu_ref: reduce memory footprint of percpu_ref in fast path")

cf785af19319f9fc 2b0d3d3e4fcfb19d10f9a82910b 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
      0.11 ±  2%      -8.2%       0.10        vm-scalability.free_time
      8938            -2.9%       8680        vm-scalability.median
   1716509            -2.3%    1676446        vm-scalability.throughput
    376.47            +1.4%     381.66        vm-scalability.time.elapsed_time
    376.47            +1.4%     381.66        vm-scalability.time.elapsed_time.max
    791740            -1.8%     777639        vm-scalability.time.involuntary_context_switches
  50418905            -3.6%   48602585        vm-scalability.time.major_page_faults
   3245026 ±  2%     -11.2%    2881590 ±  4%  vm-scalability.time.maximum_resident_set_size
    915679            -8.4%     838899        vm-scalability.time.minor_page_faults
     57413            +2.2%      58704        vm-scalability.time.system_time
     37.40 ±  4%     -17.1%      31.02        vm-scalability.time.user_time
      5794            -4.6%       5529        vmstat.system.cs
      0.19 ± 10%      +0.0        0.24 ±  3%  mpstat.cpu.all.soft%
      0.09 ±  3%      -0.0        0.08        mpstat.cpu.all.usr%
  79269198 ±  5%      -8.9%   72179734 ±  2%  numa-numastat.node1.numa_miss
  79300987 ±  5%      -9.0%   72199079 ±  2%  numa-numastat.node1.other_node
     13153 ±  3%      -9.9%      11852 ±  4%  softirqs.CPU171.SCHED
     12965 ±  3%      -5.7%      12224 ±  3%  softirqs.CPU179.SCHED
     14643 ±  2%     +13.1%      16568 ±  8%  softirqs.CPU22.RCU
    107963 ± 45%     -53.7%      50030 ± 94%  numa-meminfo.node0.AnonPages
    136276 ± 24%     -59.7%      54912 ± 84%  numa-meminfo.node0.Inactive(anon)
     48958 ± 65%     -60.8%      19202 ± 15%  numa-meminfo.node0.Shmem
     80284 ± 21%    +128.8%     183671 ± 23%  numa-meminfo.node1.AnonPages
     83830 ± 23%    +153.6%     212628 ± 36%  numa-meminfo.node1.Inactive(anon)
   5279876           -15.1%    4482709 ±  9%  numa-meminfo.node2.MemFree
     27015 ± 45%     -53.7%      12509 ± 94%  numa-vmstat.node0.nr_anon_pages
     34088 ± 24%     -59.7%      13726 ± 84%  numa-vmstat.node0.nr_inactive_anon
     12250 ± 65%     -60.7%       4815 ± 15%  numa-vmstat.node0.nr_shmem
     34096 ± 24%     -59.7%      13736 ± 84%  numa-vmstat.node0.nr_zone_inactive_anon
     20114 ± 21%    +128.2%      45909 ± 24%  numa-vmstat.node1.nr_anon_pages
     20998 ± 23%    +153.0%      53130 ± 36%  numa-vmstat.node1.nr_inactive_anon
     21006 ± 23%    +152.9%      53134 ± 36%  numa-vmstat.node1.nr_zone_inactive_anon
     14.25 ± 15%     -33.3%       9.50 ± 24%  numa-vmstat.node1.workingset_restore_file
   1342050 ±  2%     -13.7%    1158149 ±  8%  numa-vmstat.node2.nr_free_pages
    346.25 ±  2%      +7.3%     371.50 ±  2%  numa-vmstat.node2.nr_isolated_file
     58.00 ± 67%    +101.7%     117.00 ± 23%  numa-vmstat.node3.nr_mlock
    904477 ±  9%     -22.9%     697781 ± 17%  sched_debug.cfs_rq:/.load.max
     94786 ± 13%     -21.0%      74893 ± 10%  sched_debug.cfs_rq:/.load.stddev
      7107 ±  5%      -5.8%       6695 ±  5%  sched_debug.cpu.nr_switches.avg
    -17.81           +54.9%     -27.60        sched_debug.cpu.nr_uninterruptible.min
      5854 ±  6%      -7.1%       5436 ±  6%  sched_debug.cpu.sched_count.avg
      4066 ±  8%      -7.7%       3751 ±  6%  sched_debug.cpu.sched_count.min
      2559 ±  6%      -8.1%       2351 ±  6%  sched_debug.cpu.ttwu_count.avg
      1645 ±  9%      -8.3%       1508 ±  7%  sched_debug.cpu.ttwu_count.min
    966.85 ±  8%      -9.1%     879.05 ±  5%  sched_debug.cpu.ttwu_count.stddev
      2188 ±  6%      -8.1%       2010 ±  6%  sched_debug.cpu.ttwu_local.avg
      6675 ± 10%     -14.2%       5729 ± 10%  sched_debug.cpu.ttwu_local.max
      1586 ±  8%      -8.2%       1456 ±  6%  sched_debug.cpu.ttwu_local.min
    716.80 ±  9%     -14.4%     613.47 ±  7%  sched_debug.cpu.ttwu_local.stddev
  66724832            -2.4%   65125700        interrupts.CAL:Function_call_interrupts
    133.50 ± 20%     -30.5%      92.75 ± 33%  interrupts.CPU110.RES:Rescheduling_interrupts
    111.50 ± 11%     -35.0%      72.50 ± 26%  interrupts.CPU164.RES:Rescheduling_interrupts
     98.75 ± 24%     -28.4%      70.75 ± 23%  interrupts.CPU167.RES:Rescheduling_interrupts
     73.75 ± 11%     +52.2%     112.25 ± 17%  interrupts.CPU172.RES:Rescheduling_interrupts
      5275 ± 34%     +60.9%       8485        interrupts.CPU174.NMI:Non-maskable_interrupts
      5275 ± 34%     +60.9%       8485        interrupts.CPU174.PMI:Performance_monitoring_interrupts
    140.75 ± 34%     -46.0%      76.00 ±  8%  interrupts.CPU177.RES:Rescheduling_interrupts
    352.50 ±  3%     +13.8%     401.00 ±  3%  interrupts.CPU25.RES:Rescheduling_interrupts
    345.75           +11.1%     384.00 ±  8%  interrupts.CPU27.RES:Rescheduling_interrupts
    304.75 ±  8%     +11.4%     339.50 ±  7%  interrupts.CPU46.RES:Rescheduling_interrupts
    273.25 ± 11%     -18.1%     223.75 ±  8%  interrupts.CPU61.RES:Rescheduling_interrupts
    258.50 ±  9%     -14.7%     220.50 ± 11%  interrupts.CPU63.RES:Rescheduling_interrupts
    204.75 ±  7%     -16.7%     170.50 ± 13%  interrupts.CPU67.RES:Rescheduling_interrupts
    245.25 ± 16%     -25.7%     182.25 ± 18%  interrupts.CPU68.RES:Rescheduling_interrupts
    203.50 ±  9%     -20.4%     162.00 ±  8%  interrupts.CPU70.RES:Rescheduling_interrupts
    127.00 ± 12%     +17.1%     148.75 ±  5%  interrupts.CPU82.RES:Rescheduling_interrupts
    131.75 ±  5%     +14.2%     150.50 ±  8%  interrupts.CPU83.RES:Rescheduling_interrupts
    193430            -3.1%     187482        proc-vmstat.allocstall_movable
      2914 ±  2%      -9.9%       2627 ±  3%  proc-vmstat.compact_daemon_wake
  12178694 ± 13%     -17.1%   10099416 ± 11%  proc-vmstat.compact_migrate_scanned
    449.75 ±  7%     -15.5%     380.00 ±  4%  proc-vmstat.kswapd_high_wmark_hit_quickly
      1284 ±  6%     -28.6%     917.25        proc-vmstat.kswapd_low_wmark_hit_quickly
   4939422            -5.5%    4668260 ±  2%  proc-vmstat.nr_free_pages
      1394            +3.0%       1435        proc-vmstat.nr_isolated_file
     33973            -2.1%      33262        proc-vmstat.nr_kernel_stack
    268.25 ± 69%     +70.5%     457.50        proc-vmstat.nr_mlock
     16132 ± 24%     -29.8%      11328 ± 32%  proc-vmstat.numa_hint_faults
     10077 ± 22%     -67.5%       3270 ± 70%  proc-vmstat.numa_hint_faults_local
 1.308e+09            -3.3%  1.266e+09        proc-vmstat.numa_hit
 1.308e+09            -3.3%  1.266e+09        proc-vmstat.numa_local
      3836 ±  3%      -9.6%       3468        proc-vmstat.pageoutrun
    789083            -4.6%     752437        proc-vmstat.pgactivate
  10560572            -3.5%   10194445        proc-vmstat.pgalloc_dma32
 1.585e+09            -3.5%  1.529e+09        proc-vmstat.pgalloc_normal
    738463            -3.9%     709594        proc-vmstat.pgdeactivate
 1.031e+08            -3.6%   99444010        proc-vmstat.pgfault
 1.602e+09            -3.6%  1.545e+09        proc-vmstat.pgfree
  50366944            -3.6%   48555761        proc-vmstat.pgmajfault
    738463            -3.9%     709594        proc-vmstat.pgrefill
 2.139e+09            -2.9%  2.078e+09        proc-vmstat.pgscan_direct
 2.291e+09            -3.3%  2.214e+09        proc-vmstat.pgscan_file
 1.515e+08 ±  4%     -10.1%  1.362e+08 ±  3%  proc-vmstat.pgscan_kswapd
 1.447e+09            -3.2%  1.401e+09        proc-vmstat.pgsteal_direct
 1.542e+09            -3.7%  1.485e+09        proc-vmstat.pgsteal_file
  94366150 ±  4%     -10.8%   84151622 ±  2%  proc-vmstat.pgsteal_kswapd
  82472355            -7.9%   75987203        proc-vmstat.slabs_scanned
     97789 ±  3%      -6.1%      91871 ±  2%  proc-vmstat.workingset_activate_file
  17986006            -4.2%   17225500        proc-vmstat.workingset_nodereclaim
   4831818            -1.7%    4750078        proc-vmstat.workingset_nodes
 1.532e+08            -3.8%  1.474e+08        proc-vmstat.workingset_refault_file
 1.325e+10            -1.4%  1.306e+10        perf-stat.i.branch-instructions
 1.084e+08            +2.6%  1.112e+08        perf-stat.i.cache-misses
      5701            -4.6%       5442        perf-stat.i.context-switches
      7.08            +3.1%       7.30        perf-stat.i.cpi
      4036            -2.0%       3955        perf-stat.i.cycles-between-cache-misses
 1.513e+10            -1.8%  1.485e+10        perf-stat.i.dTLB-loads
 4.042e+09            -4.7%  3.851e+09        perf-stat.i.dTLB-stores
   6991250            -7.5%    6465869 ±  8%  perf-stat.i.iTLB-load-misses
   1009631           -15.3%     855188 ± 22%  perf-stat.i.iTLB-loads
 5.943e+10            -1.8%  5.838e+10        perf-stat.i.instructions
      0.18            -4.6%       0.17        perf-stat.i.ipc
    130861            -5.1%     124241        perf-stat.i.major-faults
    170.05            -2.0%     166.70        perf-stat.i.metric.M/sec
      6009            -4.2%       5755        perf-stat.i.minor-faults
     78.56            +1.0       79.53        perf-stat.i.node-load-miss-rate%
  23838801            +6.1%   25290246        perf-stat.i.node-load-misses
   6329763            -2.1%    6194197        perf-stat.i.node-loads
  11697762            -5.1%   11104510        perf-stat.i.node-stores
    136870            -5.0%     129997        perf-stat.i.page-faults
      3.88            +4.0%       4.03        perf-stat.overall.MPKI
      7.98            +2.6%       8.18        perf-stat.overall.cpi
      4410            -1.9%       4327        perf-stat.overall.cycles-between-cache-misses
      0.13            -2.5%       0.12        perf-stat.overall.ipc
     79.26            +1.3       80.52        perf-stat.overall.node-load-miss-rate%
     59.71            +1.0       60.73        perf-stat.overall.node-store-miss-rate%
 1.355e+10            -1.5%  1.335e+10        perf-stat.ps.branch-instructions
 1.099e+08            +2.7%  1.128e+08        perf-stat.ps.cache-misses
      5751            -4.5%       5495        perf-stat.ps.context-switches
 1.547e+10            -1.9%  1.517e+10        perf-stat.ps.dTLB-loads
 4.113e+09            -4.7%  3.919e+09        perf-stat.ps.dTLB-stores
   7030143 ±  2%      -7.5%    6499674 ±  8%  perf-stat.ps.iTLB-load-misses
    905221           -14.8%     770946 ± 21%  perf-stat.ps.iTLB-loads
 6.075e+10            -1.8%  5.963e+10        perf-stat.ps.instructions
    133605            -5.0%     126858        perf-stat.ps.major-faults
      5974            -4.2%       5724        perf-stat.ps.minor-faults
  24223707            +6.1%   25700170        perf-stat.ps.node-load-misses
   6339047            -1.9%    6216984        perf-stat.ps.node-loads
  11918840            -5.0%   11328815        perf-stat.ps.node-stores
    139580            -5.0%     132583        perf-stat.ps.page-faults
      5.98 ± 20%      -1.7        4.23 ± 18%  perf-profile.calltrace.cycles-pp.__remove_mapping.shrink_page_list.shrink_inactive_list.shrink_lruvec.shrink_node
      4.49 ± 26%      -1.7        2.75 ± 28%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.__remove_mapping.shrink_page_list.shrink_inactive_list.shrink_lruvec
      4.42 ± 26%      -1.7        2.70 ± 29%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.__remove_mapping.shrink_page_list.shrink_inactive_list
     15.79 ±  6%      -1.4       14.38 ±  4%  perf-profile.calltrace.cycles-pp.shrink_page_list.shrink_inactive_list.shrink_lruvec.shrink_node.do_try_to_free_pages
      1.79 ± 15%      +0.6        2.37 ± 11%  perf-profile.calltrace.cycles-pp.__add_to_page_cache_locked.add_to_page_cache_lru.page_cache_readahead_unbounded.filemap_fault.__xfs_filemap_fault
      0.64 ± 71%      +0.9        1.56 ± 16%  perf-profile.calltrace.cycles-pp.mem_cgroup_charge.__add_to_page_cache_locked.add_to_page_cache_lru.page_cache_readahead_unbounded.filemap_fault
     36.99 ±  3%      +2.8       39.76 ±  2%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irq.shrink_inactive_list.shrink_lruvec.shrink_node
     36.38 ±  3%      +3.0       39.35 ±  2%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irq.shrink_inactive_list.shrink_lruvec.shrink_node.do_try_to_free_pages
      6.17 ± 20%      -1.8        4.36 ± 18%  perf-profile.children.cycles-pp.__remove_mapping
     16.58 ±  6%      -1.6       14.97 ±  5%  perf-profile.children.cycles-pp.shrink_page_list
     78.11            -0.9       77.22        perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
      4.75 ± 14%      -0.8        3.95 ± 15%  perf-profile.children.cycles-pp._raw_spin_lock
      1.20 ±  7%      -0.3        0.90 ±  9%  perf-profile.children.cycles-pp.free_pcppages_bulk
      0.33 ± 28%      -0.2        0.15 ± 43%  perf-profile.children.cycles-pp.drain_local_pages_wq
      0.33 ± 28%      -0.2        0.15 ± 43%  perf-profile.children.cycles-pp.drain_pages_zone
      0.96            -0.1        0.83 ±  6%  perf-profile.children.cycles-pp.free_unref_page_list
      1.04 ±  2%      -0.1        0.98        perf-profile.children.cycles-pp.__list_del_entry_valid
      0.54            -0.0        0.49 ±  3%  perf-profile.children.cycles-pp.xas_create
      0.61 ±  4%      -0.0        0.57 ±  2%  perf-profile.children.cycles-pp.page_referenced
      0.36 ±  4%      -0.0        0.33        perf-profile.children.cycles-pp.page_referenced_one
      0.09 ±  4%      +0.0        0.11 ±  4%  perf-profile.children.cycles-pp.page_remove_rmap
      0.18 ±  5%      +0.0        0.21 ±  2%  perf-profile.children.cycles-pp.unaccount_page_cache_page
      0.10 ± 17%      +0.0        0.15 ± 12%  perf-profile.children.cycles-pp.refill_obj_stock
      0.09 ± 20%      +0.0        0.14 ± 13%  perf-profile.children.cycles-pp.drain_obj_stock
      0.04 ± 60%      +0.0        0.09 ± 20%  perf-profile.children.cycles-pp.__memcg_kmem_uncharge
      0.16 ± 23%      +0.1        0.22 ± 10%  perf-profile.children.cycles-pp.run_ksoftirqd
      0.00            +0.1        0.06 ±  7%  perf-profile.children.cycles-pp.lru_note_cost
      0.16 ± 23%      +0.1        0.22 ± 11%  perf-profile.children.cycles-pp.smpboot_thread_fn
      0.22 ± 20%      +0.1        0.29 ±  9%  perf-profile.children.cycles-pp.rcu_do_batch
      0.23 ± 21%      +0.1        0.30 ±  9%  perf-profile.children.cycles-pp.__softirqentry_text_start
      0.01 ±173%      +0.1        0.10 ±  7%  perf-profile.children.cycles-pp.propagate_protected_usage
      0.23 ±  4%      +0.1        0.36 ±  3%  perf-profile.children.cycles-pp.mem_cgroup_uncharge_list
      0.19 ±  5%      +0.1        0.32 ±  4%  perf-profile.children.cycles-pp.uncharge_batch
      0.23 ±  3%      +0.1        0.37 ±  7%  perf-profile.children.cycles-pp.page_counter_cancel
      0.23 ±  4%      +0.2        0.38 ±  6%  perf-profile.children.cycles-pp.page_counter_uncharge
      0.14 ± 16%      +0.2        0.30 ±  6%  perf-profile.children.cycles-pp.page_counter_try_charge
      0.30 ± 31%      +0.2        0.48 ± 20%  perf-profile.children.cycles-pp.get_mem_cgroup_from_mm
      0.22 ± 14%      +0.2        0.40 ±  6%  perf-profile.children.cycles-pp.try_charge
      0.16 ±  5%      +0.2        0.37 ±  2%  perf-profile.children.cycles-pp.workingset_age_nonresident
      0.63 ± 12%      +0.2        0.86 ±  3%  perf-profile.children.cycles-pp.__mod_memcg_lruvec_state
      0.99 ± 26%      +0.6        1.56 ± 16%  perf-profile.children.cycles-pp.mem_cgroup_charge
      1.80 ± 15%      +0.6        2.38 ± 10%  perf-profile.children.cycles-pp.__add_to_page_cache_locked
     78.11            -0.9       77.22        perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
      0.28 ± 10%      -0.2        0.08 ±  5%  perf-profile.self.cycles-pp.workingset_eviction
      0.08 ± 10%      +0.0        0.11 ±  7%  perf-profile.self.cycles-pp.try_charge
      0.00            +0.1        0.06 ±  7%  perf-profile.self.cycles-pp.lru_note_cost
      0.01 ±173%      +0.1        0.10 ±  8%  perf-profile.self.cycles-pp.propagate_protected_usage
      0.42 ± 14%      +0.1        0.51 ±  4%  perf-profile.self.cycles-pp.__mod_memcg_state
      0.20 ±  4%      +0.1        0.31 ±  6%  perf-profile.self.cycles-pp.page_counter_cancel
      0.13 ± 15%      +0.1        0.25 ±  4%  perf-profile.self.cycles-pp.page_counter_try_charge
      0.22 ±  7%      +0.1        0.35 ±  3%  perf-profile.self.cycles-pp.__mod_memcg_lruvec_state
      0.30 ± 31%      +0.2        0.48 ± 20%  perf-profile.self.cycles-pp.get_mem_cgroup_from_mm
      0.16 ±  5%      +0.2        0.37 ±  2%  perf-profile.self.cycles-pp.workingset_age_nonresident



***************************************************************************************************
lkp-csl-2sp6: 96 threads Intel(R) Xeon(R) Gold 6252 CPU @ 2.10GHz with 256G memory
=========================================================================================
bs/compiler/cpufreq_governor/disk/fs/ioengine/kconfig/nr_task/rootfs/runtime/rw/tbox_group/test_size/testcase/time_based/ucode:
  4k/gcc-9/performance/2pmem/xfs/libaio/x86_64-rhel-8.3/50%/debian-10.4-x86_64-20200603.cgz/200s/randread/lkp-csl-2sp6/200G/fio-basic/tb/0x5002f01

commit: 
  cf785af193 ("block: warn if !__GFP_DIRECT_RECLAIM in bio_crypt_set_ctx()")
  2b0d3d3e4f ("percpu_ref: reduce memory footprint of percpu_ref in fast path")

cf785af19319f9fc 2b0d3d3e4fcfb19d10f9a82910b 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
      0.10 ± 16%      -0.1        0.03 ±  9%  fio.latency_10ms%
      0.82 ±  2%      +0.1        0.88        fio.latency_20ms%
     17300            -4.8%      16478        fio.read_bw_MBps
    336083            +5.0%     352820        fio.read_clat_mean_us
   6007071           +12.9%    6781430 ±  4%  fio.read_clat_stddev
   4429022            -4.8%    4218471        fio.read_iops
      8889            +5.0%       9332        fio.read_slat_mean_us
    196778            +9.1%     214657        fio.read_slat_stddev
 7.094e+09            -4.7%  6.757e+09        fio.time.file_system_inputs
    328976            -3.6%     317010        fio.time.involuntary_context_switches
    804.97 ±  3%      -9.3%     729.76        fio.time.user_time
 8.868e+08            -4.7%  8.447e+08        fio.workload
      4.13 ±  3%      -9.6%       3.74        iostat.cpu.user
      4.17 ±  3%      -0.4        3.77        mpstat.cpu.all.usr%
      2971 ± 10%     -17.1%       2462 ±  9%  sched_debug.cpu.nr_switches.min
  17366856            -4.9%   16521561        vmstat.io.bi
      5408            -2.5%       5272        vmstat.system.cs
      9848 ±  9%     -19.4%       7940 ± 11%  softirqs.CPU13.RCU
      9560 ± 19%     +44.4%      13810 ± 26%  softirqs.CPU21.SCHED
     10360 ± 15%     +32.6%      13735 ± 12%  softirqs.CPU22.SCHED
      8973 ± 12%     +36.0%      12200 ± 14%  softirqs.CPU42.SCHED
     14698 ± 10%     -23.5%      11244 ± 12%  softirqs.CPU44.SCHED
      2008           +10.1%       2212 ±  3%  slabinfo.PING.active_objs
      2008           +10.1%       2212 ±  3%  slabinfo.PING.num_objs
      4030 ± 15%    -100.0%       0.00        slabinfo.dio.active_objs
      4030 ± 15%    -100.0%       0.00        slabinfo.dio.num_objs
      4273 ±  8%     +11.5%       4766 ±  4%  slabinfo.kmalloc-rcl-64.active_objs
      4273 ±  8%     +11.5%       4766 ±  4%  slabinfo.kmalloc-rcl-64.num_objs
      1987 ± 13%     +30.1%       2585 ±  4%  slabinfo.kmalloc-rcl-96.active_objs
      1987 ± 13%     +30.1%       2585 ±  4%  slabinfo.kmalloc-rcl-96.num_objs
    926.00 ±  4%      +8.9%       1008 ±  5%  slabinfo.kmem_cache_node.active_objs
    262223            -4.7%     249875 ±  2%  proc-vmstat.allocstall_movable
      4446 ±  8%     -12.8%       3878 ± 10%  proc-vmstat.compact_daemon_wake
     12208            -3.6%      11773 ±  3%  proc-vmstat.kswapd_low_wmark_hit_quickly
    320735 ±  7%      -6.5%     299875        proc-vmstat.nr_free_pages
 8.214e+08 ±  2%      -5.1%  7.798e+08 ±  2%  proc-vmstat.numa_hit
 8.214e+08 ±  2%      -5.1%  7.798e+08 ±  2%  proc-vmstat.numa_local
     12234            -3.4%      11817 ±  2%  proc-vmstat.pageoutrun
  32372075            -4.8%   30804742        proc-vmstat.pgalloc_dma32
 8.554e+08            -4.7%  8.149e+08        proc-vmstat.pgalloc_normal
 8.785e+08            -4.8%   8.36e+08        proc-vmstat.pgfree
 3.547e+09            -4.7%  3.379e+09        proc-vmstat.pgpgin
 6.603e+08            -4.7%  6.292e+08 ±  2%  proc-vmstat.pgscan_direct
 7.124e+08            -4.3%  6.818e+08        proc-vmstat.pgscan_file
 6.603e+08            -4.7%  6.292e+08 ±  2%  proc-vmstat.pgsteal_direct
 7.124e+08            -4.3%  6.818e+08        proc-vmstat.pgsteal_file
      0.50 ±173%  +1.3e+05%     638.50 ±169%  interrupts.66:PCI-MSI.31981599-edge.i40e-eth0-TxRx-30
     65651 ±  3%      -3.6%      63316        interrupts.CAL:Function_call_interrupts
    378.75 ±  6%     -22.4%     294.00 ± 19%  interrupts.CPU13.RES:Rescheduling_interrupts
    313.75 ± 14%     -25.0%     235.25 ± 18%  interrupts.CPU2.RES:Rescheduling_interrupts
    690.25 ±  3%      +7.7%     743.25 ±  4%  interrupts.CPU29.CAL:Function_call_interrupts
      4085 ± 13%     +68.1%       6868 ± 12%  interrupts.CPU33.NMI:Non-maskable_interrupts
      4085 ± 13%     +68.1%       6868 ± 12%  interrupts.CPU33.PMI:Performance_monitoring_interrupts
    671.00 ±  3%     +14.8%     770.00 ±  4%  interrupts.CPU34.CAL:Function_call_interrupts
     53.00 ± 52%     +67.0%      88.50 ± 14%  interrupts.CPU41.TLB:TLB_shootdowns
    399.00 ±  5%     -19.1%     322.75 ±  8%  interrupts.CPU42.RES:Rescheduling_interrupts
      4277 ± 36%     +62.0%       6928 ±  6%  interrupts.CPU5.NMI:Non-maskable_interrupts
      4277 ± 36%     +62.0%       6928 ±  6%  interrupts.CPU5.PMI:Performance_monitoring_interrupts
      3663 ± 34%     +60.5%       5879 ± 21%  interrupts.CPU60.NMI:Non-maskable_interrupts
      3663 ± 34%     +60.5%       5879 ± 21%  interrupts.CPU60.PMI:Performance_monitoring_interrupts
    333.75 ± 20%     -29.1%     236.75 ± 12%  interrupts.CPU8.RES:Rescheduling_interrupts
      3167 ± 34%     +76.1%       5578 ± 17%  interrupts.CPU91.NMI:Non-maskable_interrupts
      3167 ± 34%     +76.1%       5578 ± 17%  interrupts.CPU91.PMI:Performance_monitoring_interrupts
      1776 ± 20%    +206.2%       5438 ± 39%  interrupts.CPU93.NMI:Non-maskable_interrupts
      1776 ± 20%    +206.2%       5438 ± 39%  interrupts.CPU93.PMI:Performance_monitoring_interrupts
      5996 ± 15%     +20.0%       7196 ±  4%  interrupts.TLB:TLB_shootdowns
  1.58e+10            -3.9%  1.518e+10        perf-stat.i.branch-instructions
      0.59 ±  3%      -0.0        0.57        perf-stat.i.branch-miss-rate%
  91868813 ±  4%      -7.5%   84974573        perf-stat.i.branch-misses
 7.197e+08 ±  2%      -3.7%  6.931e+08        perf-stat.i.cache-misses
      5406            -2.5%       5271        perf-stat.i.context-switches
      1.68            +4.4%       1.75        perf-stat.i.cpi
    127.32            +2.4%     130.38        perf-stat.i.cpu-migrations
    197.31            +2.6%     202.49        perf-stat.i.cycles-between-cache-misses
 2.079e+10            -4.0%  1.995e+10        perf-stat.i.dTLB-loads
 1.215e+10            -4.7%  1.158e+10        perf-stat.i.dTLB-stores
  79953507 ±  8%     -15.7%   67439011 ±  3%  perf-stat.i.iTLB-load-misses
   5545653 ± 11%     -18.0%    4545198 ±  5%  perf-stat.i.iTLB-loads
 8.065e+10            -4.1%  7.733e+10        perf-stat.i.instructions
      1021 ±  6%     +12.9%       1152 ±  3%  perf-stat.i.instructions-per-iTLB-miss
      0.60            -4.3%       0.57        perf-stat.i.ipc
    520.33            -4.2%     498.65        perf-stat.i.metric.M/sec
 1.111e+08 ±  4%      -6.6%  1.037e+08 ±  3%  perf-stat.i.node-stores
      0.58 ±  3%      -0.0        0.56        perf-stat.overall.branch-miss-rate%
      1.67            +4.6%       1.75        perf-stat.overall.cpi
    187.16 ±  2%      +4.1%     194.90        perf-stat.overall.cycles-between-cache-misses
      1014 ±  6%     +13.2%       1148 ±  3%  perf-stat.overall.instructions-per-iTLB-miss
      0.60            -4.4%       0.57        perf-stat.overall.ipc
 1.572e+10            -4.0%   1.51e+10        perf-stat.ps.branch-instructions
  91415445 ±  4%      -7.5%   84544220        perf-stat.ps.branch-misses
 7.162e+08 ±  2%      -3.7%  6.896e+08        perf-stat.ps.cache-misses
      5377            -2.5%       5243        perf-stat.ps.context-switches
    126.96            +2.4%     129.98        perf-stat.ps.cpu-migrations
 2.069e+10            -4.1%  1.985e+10        perf-stat.ps.dTLB-loads
 1.209e+10            -4.7%  1.152e+10        perf-stat.ps.dTLB-stores
  79559944 ±  8%     -15.7%   67094648 ±  3%  perf-stat.ps.iTLB-load-misses
   5518625 ± 11%     -18.0%    4522626 ±  5%  perf-stat.ps.iTLB-loads
 8.025e+10            -4.1%  7.694e+10        perf-stat.ps.instructions
 1.106e+08 ±  4%      -6.7%  1.032e+08 ±  3%  perf-stat.ps.node-stores
 1.622e+13            -4.1%  1.556e+13        perf-stat.total.instructions
     13.83 ±  3%      -2.0       11.79 ± 11%  perf-profile.calltrace.cycles-pp.read_pages.page_cache_readahead_unbounded.generic_file_buffered_read.xfs_file_buffered_aio_read.xfs_file_read_iter
     13.74 ±  3%      -2.0       11.70 ± 11%  perf-profile.calltrace.cycles-pp.iomap_readahead.read_pages.page_cache_readahead_unbounded.generic_file_buffered_read.xfs_file_buffered_aio_read
     11.37 ±  3%      -1.7        9.62 ± 11%  perf-profile.calltrace.cycles-pp.submit_bio.iomap_readahead.read_pages.page_cache_readahead_unbounded.generic_file_buffered_read
     11.32 ±  3%      -1.7        9.58 ± 11%  perf-profile.calltrace.cycles-pp.submit_bio_noacct.submit_bio.iomap_readahead.read_pages.page_cache_readahead_unbounded
      6.72 ±  2%      -1.0        5.75 ± 11%  perf-profile.calltrace.cycles-pp.shrink_page_list.shrink_inactive_list.shrink_lruvec.shrink_node.do_try_to_free_pages
      3.68 ±  3%      -0.6        3.09 ± 11%  perf-profile.calltrace.cycles-pp.pagecache_get_page.generic_file_buffered_read.xfs_file_buffered_aio_read.xfs_file_read_iter.aio_read
      3.62 ±  3%      -0.6        3.05 ± 11%  perf-profile.calltrace.cycles-pp.find_get_entry.pagecache_get_page.generic_file_buffered_read.xfs_file_buffered_aio_read.xfs_file_read_iter
      3.50 ±  3%      -0.6        2.95 ± 11%  perf-profile.calltrace.cycles-pp.xas_load.find_get_entry.pagecache_get_page.generic_file_buffered_read.xfs_file_buffered_aio_read
      3.96 ±  3%      -0.5        3.50 ±  7%  perf-profile.calltrace.cycles-pp.__add_to_page_cache_locked.add_to_page_cache_lru.page_cache_readahead_unbounded.generic_file_buffered_read.xfs_file_buffered_aio_read
      0.64 ±  4%      -0.4        0.27 ±100%  perf-profile.calltrace.cycles-pp.submit_bio_checks.submit_bio_noacct.submit_bio.iomap_readahead.read_pages
      2.11 ±  4%      -0.3        1.78 ± 11%  perf-profile.calltrace.cycles-pp.xas_store.__delete_from_page_cache.__remove_mapping.shrink_page_list.shrink_inactive_list
      2.04 ±  4%      -0.3        1.72 ± 11%  perf-profile.calltrace.cycles-pp.xas_create.xas_store.__delete_from_page_cache.__remove_mapping.shrink_page_list
      1.35 ±  6%      -0.3        1.08 ± 17%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.__remove_mapping.shrink_page_list.shrink_inactive_list.shrink_lruvec
      1.00 ±  9%      -0.2        0.77 ± 19%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.__remove_mapping.shrink_page_list.shrink_inactive_list
      0.97 ±  6%      -0.2        0.74 ±  7%  perf-profile.calltrace.cycles-pp.workingset_eviction.__remove_mapping.shrink_page_list.shrink_inactive_list.shrink_lruvec
      1.22 ±  2%      -0.2        1.04 ±  9%  perf-profile.calltrace.cycles-pp.do_io_getevents.__x64_sys_io_getevents.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.28 ±  2%      -0.2        1.11 ±  8%  perf-profile.calltrace.cycles-pp.__x64_sys_io_getevents.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.05 ±  4%      -0.2        0.89 ±  9%  perf-profile.calltrace.cycles-pp.copy_page_to_iter.generic_file_buffered_read.xfs_file_buffered_aio_read.xfs_file_read_iter.aio_read
      1.17 ±  3%      -0.1        1.03 ± 10%  perf-profile.calltrace.cycles-pp.iomap_readahead_actor.iomap_apply.iomap_readahead.read_pages.page_cache_readahead_unbounded
      0.90 ±  4%      -0.1        0.76 ± 10%  perf-profile.calltrace.cycles-pp.copyout.copy_page_to_iter.generic_file_buffered_read.xfs_file_buffered_aio_read.xfs_file_read_iter
      0.89 ±  6%      -0.1        0.75 ± 13%  perf-profile.calltrace.cycles-pp.xfs_read_iomap_begin.iomap_apply.iomap_readahead.read_pages.page_cache_readahead_unbounded
      0.88 ±  2%      -0.1        0.74 ±  8%  perf-profile.calltrace.cycles-pp.read_events.do_io_getevents.__x64_sys_io_getevents.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.85 ±  4%      -0.1        0.72 ± 10%  perf-profile.calltrace.cycles-pp.copy_user_enhanced_fast_string.copyout.copy_page_to_iter.generic_file_buffered_read.xfs_file_buffered_aio_read
      0.95 ±  2%      -0.1        0.83 ±  8%  perf-profile.calltrace.cycles-pp.__pagevec_lru_add_fn.pagevec_lru_move_fn.lru_cache_add.add_to_page_cache_lru.page_cache_readahead_unbounded
      0.80 ±  2%      -0.1        0.68 ±  8%  perf-profile.calltrace.cycles-pp.aio_read_events.read_events.do_io_getevents.__x64_sys_io_getevents.do_syscall_64
      0.71            -0.1        0.62 ± 12%  perf-profile.calltrace.cycles-pp.__list_del_entry_valid.rmqueue_bulk.rmqueue.get_page_from_freelist.__alloc_pages_nodemask
      0.00            +0.6        0.60 ±  6%  perf-profile.calltrace.cycles-pp.try_charge.mem_cgroup_charge.__add_to_page_cache_locked.add_to_page_cache_lru.page_cache_readahead_unbounded
     13.84 ±  3%      -2.0       11.79 ± 11%  perf-profile.children.cycles-pp.read_pages
     13.74 ±  3%      -2.0       11.71 ± 11%  perf-profile.children.cycles-pp.iomap_readahead
     11.37 ±  3%      -1.7        9.62 ± 11%  perf-profile.children.cycles-pp.submit_bio
     11.33 ±  3%      -1.7        9.59 ± 11%  perf-profile.children.cycles-pp.submit_bio_noacct
      6.08            -1.0        5.10 ± 11%  perf-profile.children.cycles-pp.__remove_mapping
      7.30            -1.0        6.35 ± 12%  perf-profile.children.cycles-pp.shrink_page_list
      4.07 ±  2%      -0.6        3.42 ± 10%  perf-profile.children.cycles-pp.xas_load
      3.68 ±  3%      -0.6        3.10 ± 11%  perf-profile.children.cycles-pp.pagecache_get_page
      3.63 ±  3%      -0.6        3.06 ± 11%  perf-profile.children.cycles-pp.find_get_entry
      3.97 ±  3%      -0.5        3.51 ±  7%  perf-profile.children.cycles-pp.__add_to_page_cache_locked
      3.11 ±  2%      -0.4        2.66 ±  9%  perf-profile.children.cycles-pp.xas_store
      3.19 ±  3%      -0.4        2.78 ± 10%  perf-profile.children.cycles-pp.__delete_from_page_cache
      2.30 ±  3%      -0.3        1.97 ± 11%  perf-profile.children.cycles-pp.xas_create
      1.98            -0.3        1.71 ± 10%  perf-profile.children.cycles-pp.__list_del_entry_valid
      0.65 ±  3%      -0.2        0.41 ±  7%  perf-profile.children.cycles-pp.mem_cgroup_charge_statistics
      1.04 ±  6%      -0.2        0.82 ±  6%  perf-profile.children.cycles-pp.workingset_eviction
      0.72 ±  2%      -0.2        0.51 ±  6%  perf-profile.children.cycles-pp.__count_memcg_events
      1.23 ±  2%      -0.2        1.05 ±  9%  perf-profile.children.cycles-pp.do_io_getevents
      1.09 ±  4%      -0.2        0.93 ± 10%  perf-profile.children.cycles-pp.copy_user_enhanced_fast_string
      1.28 ±  2%      -0.2        1.11 ±  8%  perf-profile.children.cycles-pp.__x64_sys_io_getevents
      1.06 ±  4%      -0.2        0.90 ±  9%  perf-profile.children.cycles-pp.copy_page_to_iter
      0.84 ±  3%      -0.2        0.68 ±  5%  perf-profile.children.cycles-pp.__mod_memcg_state
      1.11 ±  3%      -0.2        0.96 ±  7%  perf-profile.children.cycles-pp.free_unref_page_list
      1.17 ±  3%      -0.1        1.03 ± 10%  perf-profile.children.cycles-pp.iomap_readahead_actor
      0.64 ±  4%      -0.1        0.50 ± 10%  perf-profile.children.cycles-pp.submit_bio_checks
      0.90 ±  4%      -0.1        0.76 ± 10%  perf-profile.children.cycles-pp.copyout
      0.89 ±  2%      -0.1        0.75 ±  8%  perf-profile.children.cycles-pp.read_events
      0.90 ±  6%      -0.1        0.76 ± 13%  perf-profile.children.cycles-pp.xfs_read_iomap_begin
      0.97 ±  2%      -0.1        0.84 ±  8%  perf-profile.children.cycles-pp.free_pcppages_bulk
      0.96 ±  2%      -0.1        0.84 ±  8%  perf-profile.children.cycles-pp.__pagevec_lru_add_fn
      0.81 ±  2%      -0.1        0.69 ±  8%  perf-profile.children.cycles-pp.aio_read_events
      0.59 ±  5%      -0.1        0.49 ± 10%  perf-profile.children.cycles-pp.lookup_ioctx
      0.42 ±  6%      -0.1        0.32 ± 13%  perf-profile.children.cycles-pp.remove_mapping
      0.54 ±  2%      -0.1        0.47 ±  8%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
      0.42 ±  3%      -0.1        0.35 ±  9%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      0.49 ±  2%      -0.1        0.42 ±  9%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      0.34 ±  3%      -0.1        0.28 ±  7%  perf-profile.children.cycles-pp.__mod_lruvec_state
      0.41 ±  3%      -0.1        0.35 ±  8%  perf-profile.children.cycles-pp.hrtimer_interrupt
      0.44 ±  2%      -0.1        0.39 ±  8%  perf-profile.children.cycles-pp.asm_call_on_stack
      0.30 ±  2%      -0.1        0.24 ±  6%  perf-profile.children.cycles-pp.__mod_node_page_state
      0.25 ±  4%      -0.1        0.20 ± 13%  perf-profile.children.cycles-pp.blk_throtl_bio
      0.25 ±  7%      -0.1        0.20 ± 14%  perf-profile.children.cycles-pp.ktime_get
      0.32 ±  2%      -0.0        0.27 ±  8%  perf-profile.children.cycles-pp.__might_fault
      0.23 ±  6%      -0.0        0.18 ± 10%  perf-profile.children.cycles-pp.pagevec_lookup_entries
      0.23 ±  8%      -0.0        0.18 ± 10%  perf-profile.children.cycles-pp.find_get_entries
      0.33 ±  4%      -0.0        0.28 ±  7%  perf-profile.children.cycles-pp.___might_sleep
      0.25 ±  5%      -0.0        0.20 ± 12%  perf-profile.children.cycles-pp._copy_from_user
      0.35 ±  4%      -0.0        0.31 ± 10%  perf-profile.children.cycles-pp.syscall_return_via_sysret
      0.21 ±  4%      -0.0        0.17 ±  7%  perf-profile.children.cycles-pp.__get_user_4
      0.13 ±  9%      -0.0        0.09 ±  4%  perf-profile.children.cycles-pp.bio_endio
      0.40 ±  4%      -0.0        0.36 ±  7%  perf-profile.children.cycles-pp.workingset_update_node
      0.18 ±  7%      -0.0        0.14 ± 12%  perf-profile.children.cycles-pp.xas_start
      0.28            -0.0        0.24 ±  8%  perf-profile.children.cycles-pp.__might_sleep
      0.21 ±  2%      -0.0        0.17 ±  9%  perf-profile.children.cycles-pp._copy_to_user
      0.26            -0.0        0.23 ±  6%  perf-profile.children.cycles-pp._raw_spin_unlock_irqrestore
      0.14 ±  5%      -0.0        0.11 ± 14%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      0.18 ±  7%      -0.0        0.15 ±  8%  perf-profile.children.cycles-pp.__fget_files
      0.23 ±  3%      -0.0        0.20 ±  7%  perf-profile.children.cycles-pp._cond_resched
      0.13 ±  5%      -0.0        0.10 ± 10%  perf-profile.children.cycles-pp.syscall_enter_from_user_mode
      0.12 ±  4%      -0.0        0.10 ±  8%  perf-profile.children.cycles-pp.mutex_lock
      0.06            -0.0        0.04 ± 57%  perf-profile.children.cycles-pp.mem_cgroup_page_lruvec
      0.16 ±  6%      -0.0        0.14 ±  8%  perf-profile.children.cycles-pp.__check_object_size
      0.11 ±  6%      -0.0        0.09 ±  7%  perf-profile.children.cycles-pp.mark_page_accessed
      0.01 ±173%      +0.1        0.06 ±  6%  perf-profile.children.cycles-pp.lru_note_cost
      0.08 ±  8%      +0.1        0.15 ± 12%  perf-profile.children.cycles-pp.propagate_protected_usage
      0.46 ±  3%      +0.1        0.60 ±  7%  perf-profile.children.cycles-pp.try_charge
      0.27 ±  4%      +0.2        0.42 ±  5%  perf-profile.children.cycles-pp.page_counter_try_charge
      0.44 ±  5%      +0.2        0.61 ±  7%  perf-profile.children.cycles-pp.workingset_age_nonresident
      0.56 ±  2%      +0.2        0.75 ± 11%  perf-profile.children.cycles-pp.page_counter_cancel
      0.73 ±  2%      +0.2        0.92 ± 10%  perf-profile.children.cycles-pp.mem_cgroup_uncharge_list
      0.57 ±  2%      +0.2        0.77 ± 12%  perf-profile.children.cycles-pp.page_counter_uncharge
      0.61 ±  2%      +0.2        0.82 ± 10%  perf-profile.children.cycles-pp.uncharge_batch
      3.85 ±  2%      -0.6        3.25 ± 10%  perf-profile.self.cycles-pp.xas_load
      0.59 ±  9%      -0.4        0.21 ±  6%  perf-profile.self.cycles-pp.workingset_eviction
      2.24 ±  3%      -0.3        1.92 ± 12%  perf-profile.self.cycles-pp.xas_create
      1.97            -0.3        1.71 ± 10%  perf-profile.self.cycles-pp.__list_del_entry_valid
      0.72 ±  2%      -0.2        0.51 ±  6%  perf-profile.self.cycles-pp.__count_memcg_events
      1.09 ±  3%      -0.2        0.92 ± 10%  perf-profile.self.cycles-pp.copy_user_enhanced_fast_string
      0.84 ±  3%      -0.2        0.67 ±  5%  perf-profile.self.cycles-pp.__mod_memcg_state
      0.41 ±  3%      -0.1        0.34 ± 11%  perf-profile.self.cycles-pp.io_submit_one
      0.51 ±  4%      -0.1        0.43 ±  7%  perf-profile.self.cycles-pp.free_pcppages_bulk
      0.41 ±  6%      -0.1        0.34 ± 15%  perf-profile.self.cycles-pp.mem_cgroup_charge
      0.36 ±  2%      -0.1        0.30 ±  9%  perf-profile.self.cycles-pp.__pagevec_lru_add_fn
      0.34 ±  6%      -0.1        0.28 ± 14%  perf-profile.self.cycles-pp.get_page_from_freelist
      0.29 ±  2%      -0.1        0.24 ±  5%  perf-profile.self.cycles-pp.__mod_node_page_state
      0.28 ±  5%      -0.1        0.23 ± 14%  perf-profile.self.cycles-pp.lookup_ioctx
      0.21 ±  3%      -0.0        0.17 ±  7%  perf-profile.self.cycles-pp.__get_user_4
      0.20 ±  3%      -0.0        0.16 ±  8%  perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.31 ±  3%      -0.0        0.27 ±  8%  perf-profile.self.cycles-pp.___might_sleep
      0.18 ±  2%      -0.0        0.14 ±  3%  perf-profile.self.cycles-pp.release_pages
      0.19 ±  5%      -0.0        0.15 ± 11%  perf-profile.self.cycles-pp.find_get_entries
      0.10 ±  8%      -0.0        0.06 ±  7%  perf-profile.self.cycles-pp.bio_endio
      0.26            -0.0        0.22 ±  8%  perf-profile.self.cycles-pp.__might_sleep
      0.21 ±  3%      -0.0        0.17 ± 11%  perf-profile.self.cycles-pp.pmem_submit_bio
      0.23 ±  4%      -0.0        0.19 ±  4%  perf-profile.self.cycles-pp.xas_store
      0.18 ±  7%      -0.0        0.15 ±  7%  perf-profile.self.cycles-pp.__fget_files
      0.15 ±  8%      -0.0        0.12 ±  9%  perf-profile.self.cycles-pp.__alloc_pages_nodemask
      0.17 ±  4%      -0.0        0.13 ± 13%  perf-profile.self.cycles-pp.xas_start
      0.19 ±  2%      -0.0        0.16 ±  4%  perf-profile.self.cycles-pp._raw_spin_lock_irq
      0.14 ±  8%      -0.0        0.10 ± 17%  perf-profile.self.cycles-pp.blk_throtl_bio
      0.19 ± 10%      -0.0        0.16 ±  4%  perf-profile.self.cycles-pp.kmem_cache_free
      0.12 ±  3%      -0.0        0.10 ±  8%  perf-profile.self.cycles-pp.syscall_enter_from_user_mode
      0.14 ±  3%      -0.0        0.11 ± 11%  perf-profile.self.cycles-pp.read_tsc
      0.12 ±  3%      -0.0        0.10 ± 10%  perf-profile.self.cycles-pp.find_get_entry
      0.10 ±  4%      -0.0        0.08 ± 11%  perf-profile.self.cycles-pp.__put_user_4
      0.11 ±  4%      -0.0        0.08 ±  5%  perf-profile.self.cycles-pp.mark_page_accessed
      0.09 ±  9%      -0.0        0.07 ± 12%  perf-profile.self.cycles-pp.aio_read
      0.09 ±  8%      -0.0        0.07 ±  5%  perf-profile.self.cycles-pp.submit_bio_noacct
      0.10 ±  8%      -0.0        0.08 ± 10%  perf-profile.self.cycles-pp.lru_cache_add
      0.10 ±  8%      -0.0        0.08 ±  8%  perf-profile.self.cycles-pp._cond_resched
      0.09 ±  4%      -0.0        0.07 ± 10%  perf-profile.self.cycles-pp.copy_page_to_iter
      0.04 ± 57%      +0.0        0.07 ±  6%  perf-profile.self.cycles-pp.__x64_sys_io_getevents
      0.01 ±173%      +0.1        0.06 ±  6%  perf-profile.self.cycles-pp.lru_note_cost
      0.34 ±  5%      +0.1        0.41 ±  6%  perf-profile.self.cycles-pp.__mod_memcg_lruvec_state
      0.08 ±  5%      +0.1        0.15 ± 12%  perf-profile.self.cycles-pp.propagate_protected_usage
      0.24 ±  4%      +0.1        0.38 ±  6%  perf-profile.self.cycles-pp.page_counter_try_charge
      0.49 ±  2%      +0.1        0.64 ± 11%  perf-profile.self.cycles-pp.page_counter_cancel
      0.44 ±  5%      +0.2        0.61 ±  8%  perf-profile.self.cycles-pp.workingset_age_nonresident





Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


Thanks,
Oliver Sang


--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=job-script

#!/bin/sh

export_top_env()
{
	export suite='reaim'
	export testcase='reaim'
	export category='benchmark'
	export runtime=300
	export nr_task=192
	export job_origin='/lkp-src/allot/cyclic:p1:linux-devel:devel-hourly/lkp-csl-2ap3/reaim-100.yaml'
	export queue_cmdline_keys='branch
commit
queue_at_least_once'
	export queue='validate'
	export testbox='lkp-csl-2ap3'
	export tbox_group='lkp-csl-2ap3'
	export kconfig='x86_64-rhel-8.3'
	export submit_id='5f9bb65d3733c6172f7d9cf7'
	export job_file='/lkp/jobs/scheduled/lkp-csl-2ap3/reaim-performance-100%-300s-short-ucode=0x5002f01-monitor=3472ca3d-debian-10.4-x86_64-20200603.cgz-2b0d3d3e4fcfb19d10f9a82910b8f-20201030-5935-qtny9r-3.yaml'
	export id='a97847964a4a7eaff046d12c32513a7781b2ba14'
	export queuer_version='/lkp-src'
	export model='Cascade Lake'
	export nr_node=4
	export nr_cpu=192
	export memory='192G'
	export ssd_partitions=
	export rootfs_partition='LABEL=LKP-ROOTFS'
	export kernel_cmdline_hw='acpi_rsdp=0x67f44014'
	export brand='Intel(R) Xeon(R) Platinum 9242 CPU @ 2.30GHz'
	export avoid_nfs=1
	export commit='2b0d3d3e4fcfb19d10f9a82910b8f0f05c56ee3e'
	export need_kconfig_hw='CONFIG_IGB=y
CONFIG_BLK_DEV_NVME'
	export ucode='0x5002f01'
	export enqueue_time='2020-10-30 14:44:46 +0800'
	export _id='5f9bb65d3733c6172f7d9cf7'
	export _rt='/result/reaim/performance-100%-300s-short-ucode=0x5002f01-monitor=3472ca3d/lkp-csl-2ap3/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/2b0d3d3e4fcfb19d10f9a82910b8f0f05c56ee3e'
	export user='lkp'
	export compiler='gcc-9'
	export head_commit='58cdbc2e9b1a74decce9bc4a65da9324eb2c23ea'
	export base_commit='3650b228f83adda7e5ee532e2b90429c03f7b9ec'
	export branch='linus/master'
	export rootfs='debian-10.4-x86_64-20200603.cgz'
	export monitor_sha='3472ca3d'
	export result_root='/result/reaim/performance-100%-300s-short-ucode=0x5002f01-monitor=3472ca3d/lkp-csl-2ap3/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/2b0d3d3e4fcfb19d10f9a82910b8f0f05c56ee3e/3'
	export scheduler_version='/lkp/lkp/.src-20201030-141732'
	export LKP_SERVER='internal-lkp-server'
	export arch='x86_64'
	export max_uptime=3600
	export initrd='/osimage/debian/debian-10.4-x86_64-20200603.cgz'
	export bootloader_append='root=/dev/ram0
user=lkp
job=/lkp/jobs/scheduled/lkp-csl-2ap3/reaim-performance-100%-300s-short-ucode=0x5002f01-monitor=3472ca3d-debian-10.4-x86_64-20200603.cgz-2b0d3d3e4fcfb19d10f9a82910b8f-20201030-5935-qtny9r-3.yaml
ARCH=x86_64
kconfig=x86_64-rhel-8.3
branch=linus/master
commit=2b0d3d3e4fcfb19d10f9a82910b8f0f05c56ee3e
BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3/gcc-9/2b0d3d3e4fcfb19d10f9a82910b8f0f05c56ee3e/vmlinuz-5.9.0-rc3-00186-g2b0d3d3e4fcfb
acpi_rsdp=0x67f44014
max_uptime=3600
RESULT_ROOT=/result/reaim/performance-100%-300s-short-ucode=0x5002f01-monitor=3472ca3d/lkp-csl-2ap3/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/2b0d3d3e4fcfb19d10f9a82910b8f0f05c56ee3e/3
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
	export modules_initrd='/pkg/linux/x86_64-rhel-8.3/gcc-9/2b0d3d3e4fcfb19d10f9a82910b8f0f05c56ee3e/modules.cgz'
	export bm_initrd='/osimage/deps/debian-10.4-x86_64-20200603.cgz/run-ipconfig_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/lkp_20200709.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/rsync-rootfs_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/reaim_20201007.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/reaim-x86_64-7.0.1.13-1_20201007.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/mpstat_20200714.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/perf_20200723.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/perf-x86_64-c85fb28b6f99-1_20201008.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/sar-x86_64-34c92ae-1_20200702.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/hw_20200715.cgz'
	export ucode_initrd='/osimage/ucode/intel-ucode-20200610.cgz'
	export lkp_initrd='/osimage/user/lkp/lkp-x86_64.cgz'
	export site='inn'
	export LKP_CGI_PORT=80
	export LKP_CIFS_PORT=139
	export last_kernel='5.10.0-rc1-wt-ath-03501-g58cdbc2e9b1a'
	export repeat_to=4
	export schedule_notify_address=
	export queue_at_least_once=1
	export kernel='/pkg/linux/x86_64-rhel-8.3/gcc-9/2b0d3d3e4fcfb19d10f9a82910b8f0f05c56ee3e/vmlinuz-5.9.0-rc3-00186-g2b0d3d3e4fcfb'
	export dequeue_time='2020-10-30 14:49:01 +0800'
	export job_initrd='/lkp/jobs/scheduled/lkp-csl-2ap3/reaim-performance-100%-300s-short-ucode=0x5002f01-monitor=3472ca3d-debian-10.4-x86_64-20200603.cgz-2b0d3d3e4fcfb19d10f9a82910b8f-20201030-5935-qtny9r-3.cgz'

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

	run_test test='short' $LKP_SRC/tests/wrapper reaim
}

extract_stats()
{
	export stats_part_begin=
	export stats_part_end=

	$LKP_SRC/stats/wrapper reaim
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

	$LKP_SRC/stats/wrapper time reaim.time
	$LKP_SRC/stats/wrapper dmesg
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper last_state
	$LKP_SRC/stats/wrapper stderr
	$LKP_SRC/stats/wrapper time
}

"$@"

--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="job.yaml"

---

#! jobs/reaim-100.yaml
suite: reaim
testcase: reaim
category: benchmark
runtime: 300s
nr_task: 100%
reaim:
  test: short
job_origin: "/lkp-src/allot/cyclic:p1:linux-devel:devel-hourly/lkp-csl-2ap3/reaim-100.yaml"

#! queue options
queue_cmdline_keys:
- branch
- commit
- queue_at_least_once
queue: bisect
testbox: lkp-csl-2ap3
tbox_group: lkp-csl-2ap3
kconfig: x86_64-rhel-8.3
submit_id: 5f9ba9a03733c6165f77a6d4
job_file: "/lkp/jobs/scheduled/lkp-csl-2ap3/reaim-performance-100%-300s-short-ucode=0x5002f01-monitor=3472ca3d-debian-10.4-x86_64-20200603.cgz-2b0d3d3e4fcfb19d10f9a82910b8f-20201030-5727-1j4c7rp-1.yaml"
id: a068c2ae1bcf536575ec4a7726004bb8d39d1701
queuer_version: "/lkp-src"

#! hosts/lkp-csl-2ap3
model: Cascade Lake
nr_node: 4
nr_cpu: 192
memory: 192G
ssd_partitions: 
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

#! include/reaim
avoid_nfs: 1

#! include/queue/cyclic
commit: 2b0d3d3e4fcfb19d10f9a82910b8f0f05c56ee3e

#! include/testbox/lkp-csl-2ap3
need_kconfig_hw:
- CONFIG_IGB=y
- CONFIG_BLK_DEV_NVME
ucode: '0x5002f01'
enqueue_time: 2020-10-30 13:50:25.038486584 +08:00
_id: 5f9ba9a53733c6165f77a6d5
_rt: "/result/reaim/performance-100%-300s-short-ucode=0x5002f01-monitor=3472ca3d/lkp-csl-2ap3/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/2b0d3d3e4fcfb19d10f9a82910b8f0f05c56ee3e"

#! schedule options
user: lkp
compiler: gcc-9
head_commit: 58cdbc2e9b1a74decce9bc4a65da9324eb2c23ea
base_commit: 3650b228f83adda7e5ee532e2b90429c03f7b9ec
branch: linux-devel/devel-hourly-2020102920
rootfs: debian-10.4-x86_64-20200603.cgz
monitor_sha: 3472ca3d
result_root: "/result/reaim/performance-100%-300s-short-ucode=0x5002f01-monitor=3472ca3d/lkp-csl-2ap3/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/2b0d3d3e4fcfb19d10f9a82910b8f0f05c56ee3e/0"
scheduler_version: "/lkp/lkp/.src-20201030-132544"
LKP_SERVER: internal-lkp-server
arch: x86_64
max_uptime: 3600
initrd: "/osimage/debian/debian-10.4-x86_64-20200603.cgz"
bootloader_append:
- root=/dev/ram0
- user=lkp
- job=/lkp/jobs/scheduled/lkp-csl-2ap3/reaim-performance-100%-300s-short-ucode=0x5002f01-monitor=3472ca3d-debian-10.4-x86_64-20200603.cgz-2b0d3d3e4fcfb19d10f9a82910b8f-20201030-5727-1j4c7rp-1.yaml
- ARCH=x86_64
- kconfig=x86_64-rhel-8.3
- branch=linux-devel/devel-hourly-2020102920
- commit=2b0d3d3e4fcfb19d10f9a82910b8f0f05c56ee3e
- BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3/gcc-9/2b0d3d3e4fcfb19d10f9a82910b8f0f05c56ee3e/vmlinuz-5.9.0-rc3-00186-g2b0d3d3e4fcfb
- acpi_rsdp=0x67f44014
- max_uptime=3600
- RESULT_ROOT=/result/reaim/performance-100%-300s-short-ucode=0x5002f01-monitor=3472ca3d/lkp-csl-2ap3/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/2b0d3d3e4fcfb19d10f9a82910b8f0f05c56ee3e/0
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
modules_initrd: "/pkg/linux/x86_64-rhel-8.3/gcc-9/2b0d3d3e4fcfb19d10f9a82910b8f0f05c56ee3e/modules.cgz"
bm_initrd: "/osimage/deps/debian-10.4-x86_64-20200603.cgz/run-ipconfig_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/lkp_20200709.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/rsync-rootfs_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/reaim_20201007.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/reaim-x86_64-7.0.1.13-1_20201007.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/mpstat_20200714.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/perf_20200723.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/perf-x86_64-c85fb28b6f99-1_20201008.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/sar-x86_64-34c92ae-1_20200702.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/hw_20200715.cgz"
ucode_initrd: "/osimage/ucode/intel-ucode-20200610.cgz"
lkp_initrd: "/osimage/user/lkp/lkp-x86_64.cgz"
site: inn

#! /lkp/lkp/.src-20201029-110223/include/site/inn
LKP_CGI_PORT: 80
LKP_CIFS_PORT: 139
oom-killer: 
watchdog: 

#! runtime status
last_kernel: 5.8.0-rc1-00153-g98b769942c698
repeat_to: 2
schedule_notify_address: 

#! user overrides
queue_at_least_once: 0
kernel: "/pkg/linux/x86_64-rhel-8.3/gcc-9/2b0d3d3e4fcfb19d10f9a82910b8f0f05c56ee3e/vmlinuz-5.9.0-rc3-00186-g2b0d3d3e4fcfb"
dequeue_time: 2020-10-30 13:52:39.051679587 +08:00

#! /lkp/lkp/.src-20201030-132544/include/site/inn
job_state: finished
loadavg: 7.96 7.06 3.19 1/1278 42708
start_time: '1604037449'
end_time: '1604037750'
version: "/lkp/lkp/.src-20201030-132618:a3f82b79:90ebc7619"

--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=reproduce


for cpu_dir in /sys/devices/system/cpu/cpu[0-9]*
do
	online_file="$cpu_dir"/online
	[ -f "$online_file" ] && [ "$(cat "$online_file")" -eq 0 ] && continue

	file="$cpu_dir"/cpufreq/scaling_governor
	[ -f "$file" ] && echo "performance" > "$file"
done

cp data/workfile.short .
mkdir -p /fs/shm
umount /fs/shm
mount -t tmpfs tmpfs /fs/shm
echo FILESIZE 10k > reaim.config
echo POOLSIZE 1m >> reaim.config
echo DISKDIR /fs/shm  >> reaim.config
./reaim -s192 -e192 -i192 -fworkfile.short -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s192 -e192 -i192 -fworkfile.short -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s192 -e192 -i192 -fworkfile.short -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s192 -e192 -i192 -fworkfile.short -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s192 -e192 -i192 -fworkfile.short -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s192 -e192 -i192 -fworkfile.short -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s192 -e192 -i192 -fworkfile.short -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s192 -e192 -i192 -fworkfile.short -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s192 -e192 -i192 -fworkfile.short -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s192 -e192 -i192 -fworkfile.short -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s192 -e192 -i192 -fworkfile.short -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s192 -e192 -i192 -fworkfile.short -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s192 -e192 -i192 -fworkfile.short -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s192 -e192 -i192 -fworkfile.short -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s192 -e192 -i192 -fworkfile.short -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s192 -e192 -i192 -fworkfile.short -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s192 -e192 -i192 -fworkfile.short -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s192 -e192 -i192 -fworkfile.short -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s192 -e192 -i192 -fworkfile.short -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s192 -e192 -i192 -fworkfile.short -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s192 -e192 -i192 -fworkfile.short -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s192 -e192 -i192 -fworkfile.short -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s192 -e192 -i192 -fworkfile.short -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s192 -e192 -i192 -fworkfile.short -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s192 -e192 -i192 -fworkfile.short -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s192 -e192 -i192 -fworkfile.short -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s192 -e192 -i192 -fworkfile.short -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s192 -e192 -i192 -fworkfile.short -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s192 -e192 -i192 -fworkfile.short -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s192 -e192 -i192 -fworkfile.short -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s192 -e192 -i192 -fworkfile.short -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s192 -e192 -i192 -fworkfile.short -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s192 -e192 -i192 -fworkfile.short -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s192 -e192 -i192 -fworkfile.short -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s192 -e192 -i192 -fworkfile.short -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s192 -e192 -i192 -fworkfile.short -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s192 -e192 -i192 -fworkfile.short -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s192 -e192 -i192 -fworkfile.short -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s192 -e192 -i192 -fworkfile.short -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s192 -e192 -i192 -fworkfile.short -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s192 -e192 -i192 -fworkfile.short -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s192 -e192 -i192 -fworkfile.short -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s192 -e192 -i192 -fworkfile.short -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s192 -e192 -i192 -fworkfile.short -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s192 -e192 -i192 -fworkfile.short -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s192 -e192 -i192 -fworkfile.short -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s192 -e192 -i192 -fworkfile.short -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s192 -e192 -i192 -fworkfile.short -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s192 -e192 -i192 -fworkfile.short -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s192 -e192 -i192 -fworkfile.short -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s192 -e192 -i192 -fworkfile.short -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s192 -e192 -i192 -fworkfile.short -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s192 -e192 -i192 -fworkfile.short -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s192 -e192 -i192 -fworkfile.short -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s192 -e192 -i192 -fworkfile.short -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s192 -e192 -i192 -fworkfile.short -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s192 -e192 -i192 -fworkfile.short -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s192 -e192 -i192 -fworkfile.short -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s192 -e192 -i192 -fworkfile.short -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s192 -e192 -i192 -fworkfile.short -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s192 -e192 -i192 -fworkfile.short -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s192 -e192 -i192 -fworkfile.short -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s192 -e192 -i192 -fworkfile.short -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s192 -e192 -i192 -fworkfile.short -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s192 -e192 -i192 -fworkfile.short -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s192 -e192 -i192 -fworkfile.short -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s192 -e192 -i192 -fworkfile.short -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s192 -e192 -i192 -fworkfile.short -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s192 -e192 -i192 -fworkfile.short -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s192 -e192 -i192 -fworkfile.short -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s192 -e192 -i192 -fworkfile.short -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s192 -e192 -i192 -fworkfile.short -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s192 -e192 -i192 -fworkfile.short -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s192 -e192 -i192 -fworkfile.short -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s192 -e192 -i192 -fworkfile.short -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s192 -e192 -i192 -fworkfile.short -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s192 -e192 -i192 -fworkfile.short -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s192 -e192 -i192 -fworkfile.short -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s192 -e192 -i192 -fworkfile.short -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s192 -e192 -i192 -fworkfile.short -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s192 -e192 -i192 -fworkfile.short -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s192 -e192 -i192 -fworkfile.short -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s192 -e192 -i192 -fworkfile.short -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s192 -e192 -i192 -fworkfile.short -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s192 -e192 -i192 -fworkfile.short -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s192 -e192 -i192 -fworkfile.short -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s192 -e192 -i192 -fworkfile.short -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s192 -e192 -i192 -fworkfile.short -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s192 -e192 -i192 -fworkfile.short -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s192 -e192 -i192 -fworkfile.short -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s192 -e192 -i192 -fworkfile.short -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s192 -e192 -i192 -fworkfile.short -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s192 -e192 -i192 -fworkfile.short -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s192 -e192 -i192 -fworkfile.short -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s192 -e192 -i192 -fworkfile.short -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s192 -e192 -i192 -fworkfile.short -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s192 -e192 -i192 -fworkfile.short -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s192 -e192 -i192 -fworkfile.short -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s192 -e192 -i192 -fworkfile.short -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s192 -e192 -i192 -fworkfile.short -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s192 -e192 -i192 -fworkfile.short -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s192 -e192 -i192 -fworkfile.short -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s192 -e192 -i192 -fworkfile.short -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s192 -e192 -i192 -fworkfile.short -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s192 -e192 -i192 -fworkfile.short -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s192 -e192 -i192 -fworkfile.short -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s192 -e192 -i192 -fworkfile.short -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s192 -e192 -i192 -fworkfile.short -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s192 -e192 -i192 -fworkfile.short -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s192 -e192 -i192 -fworkfile.short -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s192 -e192 -i192 -fworkfile.short -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s192 -e192 -i192 -fworkfile.short -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s192 -e192 -i192 -fworkfile.short -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s192 -e192 -i192 -fworkfile.short -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s192 -e192 -i192 -fworkfile.short -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s192 -e192 -i192 -fworkfile.short -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s192 -e192 -i192 -fworkfile.short -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s192 -e192 -i192 -fworkfile.short -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s192 -e192 -i192 -fworkfile.short -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s192 -e192 -i192 -fworkfile.short -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s192 -e192 -i192 -fworkfile.short -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s192 -e192 -i192 -fworkfile.short -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s192 -e192 -i192 -fworkfile.short -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s192 -e192 -i192 -fworkfile.short -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s192 -e192 -i192 -fworkfile.short -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s192 -e192 -i192 -fworkfile.short -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s192 -e192 -i192 -fworkfile.short -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s192 -e192 -i192 -fworkfile.short -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s192 -e192 -i192 -fworkfile.short -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s192 -e192 -i192 -fworkfile.short -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s192 -e192 -i192 -fworkfile.short -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s192 -e192 -i192 -fworkfile.short -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s192 -e192 -i192 -fworkfile.short -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s192 -e192 -i192 -fworkfile.short -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s192 -e192 -i192 -fworkfile.short -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s192 -e192 -i192 -fworkfile.short -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s192 -e192 -i192 -fworkfile.short -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s192 -e192 -i192 -fworkfile.short -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s192 -e192 -i192 -fworkfile.short -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100
./reaim -s192 -e192 -i192 -fworkfile.short -r1 -c./reaim.config -l/tmp/lkp/result/reaim_debug -j100

--OXfL5xGRrasGEqWY--
