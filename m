Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77F771A923D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Apr 2020 07:02:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728161AbgDOFBz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Apr 2020 01:01:55 -0400
Received: from mga04.intel.com ([192.55.52.120]:50077 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393183AbgDOFBn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 01:01:43 -0400
IronPort-SDR: TZ5gPTARq+BT5y5F+cmbCZkX9GdgB4L/iiMw+ny+q/Cf3IIAhncbpD3w0wyTqO0b+Bff86xeOX
 CoLDR24lhNhA==
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2020 22:00:53 -0700
IronPort-SDR: cwSEH6TyxJfy15RbM79Yc+bIMr7OzbgUqsLLNpnwraeKvMoNCztcGspLOzfCUjCzaSPlV718xL
 M+FpYA/mNNLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,385,1580803200"; 
   d="yaml'?scan'208";a="242204151"
Received: from shao2-debian.sh.intel.com (HELO localhost) ([10.239.13.3])
  by orsmga007.jf.intel.com with ESMTP; 14 Apr 2020 22:00:50 -0700
Date:   Wed, 15 Apr 2020 13:00:25 +0800
From:   kernel test robot <rong.a.chen@intel.com>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>, lkp@lists.01.org
Subject: [xfs] ef6d7398f5: filebench.sum_bytes_mb/s -47.5% regression
Message-ID: <20200415050024.GR8179@shao2-debian>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="mOKeRhn3B7HglGBY"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mOKeRhn3B7HglGBY
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Greeting,

FYI, we noticed a -47.5% regression of filebench.sum_bytes_mb/s due to commit:


commit: ef6d7398f5c72c4fa030740a7552d00ecbf4abd7 ("xfs: deferred inode inactivation")
https://git.kernel.org/cgit/linux/kernel/git/djwong/xfs-linux.git repair-hard-problems

in testcase: filebench
on test machine: 8 threads Intel(R) Core(TM) i7-4770 CPU @ 3.40GHz with 8G memory
with following parameters:

	disk: 1HDD
	fs: xfs
	test: fileserver.f
	cpufreq_governor: performance
	ucode: 0x27


In addition to that, the commit also has significant impact on the following tests:

+------------------+----------------------------------------------------------------------+
| testcase: change | aim7: aim7.jobs-per-min -23.6% regression                            |
| test machine     | 72 threads Intel(R) Xeon(R) Gold 6139 CPU @ 2.30GHz with 128G memory |
| test parameters  | cpufreq_governor=performance                                         |
|                  | disk=1BRD_48G                                                        |
|                  | fs=xfs                                                               |
|                  | load=3000                                                            |
|                  | test=disk_rr                                                         |
|                  | ucode=0x2000065                                                      |
+------------------+----------------------------------------------------------------------+
| testcase: change | aim7: aim7.jobs-per-min -35.7% regression                            |
| test machine     | 72 threads Intel(R) Xeon(R) Gold 6139 CPU @ 2.30GHz with 128G memory |
| test parameters  | cpufreq_governor=performance                                         |
|                  | disk=1BRD_48G                                                        |
|                  | fs=xfs                                                               |
|                  | load=3000                                                            |
|                  | test=disk_wrt                                                        |
|                  | ucode=0x2000065                                                      |
+------------------+----------------------------------------------------------------------+


If you fix the issue, kindly add following tag
Reported-by: kernel test robot <rong.a.chen@intel.com>


Details are as below:
-------------------------------------------------------------------------------------------------->


To reproduce:

        git clone https://github.com/intel/lkp-tests.git
        cd lkp-tests
        bin/lkp install job.yaml  # job file is attached in this email
        bin/lkp run     job.yaml

=========================================================================================
compiler/cpufreq_governor/disk/fs/kconfig/rootfs/tbox_group/test/testcase/ucode:
  gcc-7/performance/1HDD/xfs/x86_64-rhel-7.6/debian-x86_64-20191114.cgz/lkp-hsw-d01/fileserver.f/filebench/0x27

commit: 
  ad3a8d2d61 ("xfs: pass around xfs_inode_ag_walk iget/irele helper functions")
  ef6d7398f5 ("xfs: deferred inode inactivation")

ad3a8d2d61135b44 ef6d7398f5c72c4fa030740a755 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
    161.43           -47.5%      84.80        filebench.sum_bytes_mb/s
    406381           -46.9%     215630        filebench.sum_operations
      6772           -46.9%       3593        filebench.sum_operations/s
    615.67           -46.9%     326.67        filebench.sum_reads/s
      7.36           +88.0%      13.85        filebench.sum_time_ms/op
      1231           -46.9%     653.67        filebench.sum_writes/s
  12197290           -39.0%    7434264        filebench.time.file_system_outputs
      3339 ± 13%     -30.7%       2314 ±  5%  filebench.time.involuntary_context_switches
     18.00           -44.4%      10.00        filebench.time.percent_of_cpu_this_job_got
     10.45           -46.4%       5.61        filebench.time.system_time
    128533           -61.8%      49072        filebench.time.voluntary_context_switches
    250432           -26.0%     185230        meminfo.Active(file)
      2.38            -0.7        1.68 ± 10%  mpstat.cpu.all.sys%
     35079 ±  7%     -10.4%      31430 ±  2%  softirqs.CPU5.TIMER
     10155           -11.5%       8991        vmstat.io.bo
     33748            -6.9%      31421        vmstat.system.cs
     22.13            +3.6%      22.93        iostat.cpu.iowait
      2.49 ±  3%     -28.0%       1.79 ± 13%  iostat.cpu.system
      1.85            +1.7%       1.88        iostat.sda.avgqu-sz
     97.43            -3.4%      94.11        iostat.sda.w/s
     10254           -11.4%       9089        iostat.sda.wkB/s
     11.45           +18.7%      13.60 ±  9%  iostat.sda.wrqm/s
    629.00 ± 27%     +57.6%     991.00 ± 13%  interrupts.CPU3.RES:Rescheduling_interrupts
     99.67           -20.4%      79.33 ± 22%  interrupts.CPU5.CAL:Function_call_interrupts
    224441           -11.9%     197754 ±  4%  interrupts.CPU5.LOC:Local_timer_interrupts
    632.00 ±  8%     -45.7%     343.33 ± 29%  interrupts.CPU5.RES:Rescheduling_interrupts
     10421          -100.0%       0.00        interrupts.CPU6.19:IR-IO-APIC.19-fasteoi.ata_piix
    203183           +34.5%     273198 ± 10%  interrupts.CPU6.LOC:Local_timer_interrupts
    506.67 ± 14%     -23.1%     389.67 ± 14%  interrupts.CPU6.RES:Rescheduling_interrupts
    612.67 ± 17%     -32.3%     415.00 ± 18%  interrupts.CPU7.RES:Rescheduling_interrupts
    184694            -1.0%     182776        proc-vmstat.nr_active_anon
     62958           -26.4%      46344        proc-vmstat.nr_active_file
    184427            -1.0%     182501        proc-vmstat.nr_anon_pages
   1524685           -39.0%     929317        proc-vmstat.nr_dirtied
    237179            -7.3%     219853        proc-vmstat.nr_dirty
    549481            -1.4%     541699        proc-vmstat.nr_file_pages
     12694            -1.5%      12509        proc-vmstat.nr_inactive_anon
    200961            +4.5%     209929        proc-vmstat.nr_inactive_file
     12998            -1.3%      12827        proc-vmstat.nr_shmem
     15797            +5.0%      16586        proc-vmstat.nr_slab_reclaimable
      9867            +7.5%      10606        proc-vmstat.nr_slab_unreclaimable
    146324           -12.5%     128075        proc-vmstat.nr_written
    184693            -1.0%     182777        proc-vmstat.nr_zone_active_anon
     62960           -26.4%      46331        proc-vmstat.nr_zone_active_file
     12694            -1.5%      12509        proc-vmstat.nr_zone_inactive_anon
    200961            +4.5%     209932        proc-vmstat.nr_zone_inactive_file
    237240            -7.3%     219914        proc-vmstat.nr_zone_write_pending
   1646865           -35.9%    1055668        proc-vmstat.numa_hit
   1646865           -35.9%    1055668        proc-vmstat.numa_local
    312689           -47.8%     163203        proc-vmstat.pgactivate
   1780491           -33.1%    1191519        proc-vmstat.pgalloc_normal
   1458066 ± 11%     -20.1%    1164659        proc-vmstat.pgfree
    655093            -9.2%     594862        proc-vmstat.pgpgout
      1504           -21.6%       1180        sched_debug.cfs_rq:/.exec_clock.avg
      2573           -10.6%       2300        sched_debug.cfs_rq:/.exec_clock.max
    988.77 ±  5%     -28.5%     707.31 ±  9%  sched_debug.cfs_rq:/.exec_clock.min
    557.42 ±  3%      -9.0%     507.07 ±  5%  sched_debug.cfs_rq:/.exec_clock.stddev
      1445 ±135%    -538.7%      -6338        sched_debug.cfs_rq:/.spread0.avg
     12463 ± 21%     -62.6%       4658 ± 65%  sched_debug.cfs_rq:/.spread0.max
     -4954          +170.5%     -13399        sched_debug.cfs_rq:/.spread0.min
    292.58 ± 10%     -21.7%     229.12 ±  3%  sched_debug.cfs_rq:/.util_avg.stddev
    445084 ± 15%     +22.5%     545245 ±  7%  sched_debug.cpu.avg_idle.avg
     29625 ± 24%     +94.4%      57586 ± 16%  sched_debug.cpu.avg_idle.min
    324202 ±  2%     +10.5%     358398 ±  2%  sched_debug.cpu.avg_idle.stddev
      0.00 ± 16%     -55.8%       0.00 ± 59%  sched_debug.cpu.next_balance.stddev
    113960           -28.8%      81153 ±  2%  sched_debug.cpu.nr_switches.min
     22984 ±  5%     +60.3%      36841 ± 13%  sched_debug.cpu.nr_switches.stddev
    191.33           -10.2%     171.83        sched_debug.cpu.nr_uninterruptible.max
    110503           -32.3%      74797 ±  3%  sched_debug.cpu.sched_count.min
     20460 ±  4%     +75.8%      35970 ± 13%  sched_debug.cpu.sched_count.stddev
     53089 ±  2%     -31.4%      36440 ±  4%  sched_debug.cpu.sched_goidle.min
     10362 ±  4%     +75.0%      18138 ± 13%  sched_debug.cpu.sched_goidle.stddev
     56745 ±  2%     -34.0%      37460 ±  4%  sched_debug.cpu.ttwu_count.min
      9660 ±  8%     +83.2%      17701 ± 13%  sched_debug.cpu.ttwu_count.stddev
     79144 ±  2%     +14.2%      90399        sched_debug.cpu.ttwu_local.max
     47940           -31.0%      33087 ±  4%  sched_debug.cpu.ttwu_local.min
      9991 ±  5%     +80.1%      17992 ± 13%  sched_debug.cpu.ttwu_local.stddev
      5547 ±  9%     +30.1%       7214 ±  6%  slabinfo.anon_vma_chain.active_objs
      6073 ±  9%     +21.9%       7401 ±  7%  slabinfo.anon_vma_chain.num_objs
      3807           +12.0%       4265 ±  4%  slabinfo.filp.num_objs
    725.33 ±  8%     -23.5%     554.67 ± 10%  slabinfo.fsnotify_mark_connector.num_objs
      1082 ±  4%     +24.7%       1350 ±  2%  slabinfo.kmalloc-128.active_objs
      1082 ±  4%     +29.8%       1405        slabinfo.kmalloc-128.num_objs
     16221 ±  2%     +13.8%      18455        slabinfo.kmalloc-16.num_objs
      1680           +12.3%       1887        slabinfo.kmalloc-1k.active_objs
      2141           +20.7%       2584        slabinfo.kmalloc-1k.num_objs
      1167           +10.5%       1289        slabinfo.kmalloc-2k.active_objs
      1194           +14.8%       1371        slabinfo.kmalloc-2k.num_objs
    264.00           +60.7%     424.33        slabinfo.kmalloc-4k.active_objs
    280.67           +81.6%     509.67        slabinfo.kmalloc-4k.num_objs
      4536           +32.8%       6024 ±  2%  slabinfo.kmalloc-512.active_objs
      2765 ±  2%     -12.9%       2408        slabinfo.lsm_file_cache.active_objs
      2765 ±  2%     -12.9%       2408        slabinfo.lsm_file_cache.num_objs
    299.67 ±  5%     +94.9%     584.00 ±  4%  slabinfo.xfs_efd_item.active_objs
    299.67 ±  5%    +106.5%     618.67 ±  3%  slabinfo.xfs_efd_item.num_objs
      8578           +30.2%      11172        slabinfo.xfs_ili.active_objs
    409.00           +31.1%     536.33        slabinfo.xfs_ili.active_slabs
      8594           +31.2%      11271        slabinfo.xfs_ili.num_objs
    409.00           +31.1%     536.33        slabinfo.xfs_ili.num_slabs
      8565           +30.7%      11193        slabinfo.xfs_inode.active_objs
      8601           +31.4%      11304        slabinfo.xfs_inode.num_objs


                                                                                
                   filebench.time.percent_of_cpu_this_job_got                   
                                                                                
  20 +----------------------------------------------------------------------+   
  18 |-++.+  +.+   ++   ++.+  +   ++.+.+.++   +  +.++.+.++.+  +.+.+.+  +.+  |   
     |  : :  : :   ::   :  :  :   :       :   :  :         :  :     :  : :  |   
  16 |-+: :  : :   ::   :  :  :   :       :   :  :         :  :     :  : :  |   
  14 |-+: :  : :   ::   :  :  :   :       :   :  :         :  :     :  : :  |   
     |  :  : :  : :  : :    : :: :         : :: :           : :     : :  : :|   
  12 |-+:  : :  : :  : :    : :: :         : :: :           : :     : :  : :|   
  10 |-+:  : :  : :  : :O   : ::O: O      O:O::O:O          : :     : :  : :|   
   8 |-:   ::O O:O: O: :   O:: : :   O O O : : ::           ::       ::   ::|   
     | :   ::   : :  : :    :: : :         : : ::           ::       ::   ::|   
   6 |-:   ::   : :  : :    :: : :         : : ::           ::       ::   ::|   
   4 |-:    :    :    :      :  :           :  :             :       :    : |   
     | :    :    :    :      :  :           :  :             :       :    : |   
   2 |-:    :    :    :      :  :           :  :             :       :    : |   
   0 +----------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                      filebench.time.voluntary_context_switches                 
                                                                                
  140000 +------------------------------------------------------------------+   
         |  +.+  +.+  ++   ++.+  +   .+ .+.++  +   .+. +.++.+  +.++.   +.+  |   
  120000 |-+: :  : :  ::   :  :  :  +  +    :  :  +   +     :  :    +  : :  |   
         |  : :  : :  ::   :  :  :  :       :  :  :         :  :    :  : :  |   
  100000 |-+: :  : :  ::   :  :  :  :       :  :  :         :  :    :  : :  |   
         |  : : :  : :  : :   : : : :        : :: :          : :     : : : :|   
   80000 |-+: : :  : :  : :   : : : :        : :: :          : :     : : : :|   
         |  : : :  : :  : :   : : : :        : :: :          : :     : : : :|   
   60000 |-:   ::   ::  : :    :: : :        :: : :          ::      ::   ::|   
         | :O  ::O O:: O: :O  O:: ::  OO O OO:: ::O          ::      ::   ::|   
   40000 |-:   ::   ::  : :    :: ::         :: ::           ::      ::   ::|   
         | :   :    :    :     :   :          :  :            :       :   : |   
   20000 |-:   :    :    :     :   :          :  :            :       :   : |   
         | :   :    :    :     :   :          :  :            :       :   : |   
       0 +------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                          filebench.time.file_system_outputs                    
                                                                                
  1.4e+07 +-----------------------------------------------------------------+   
          |                                                                 |   
  1.2e+07 |-++.+  ++   ++  +.++   +  ++.++.+.+  +  ++.+.++.++  +.+.++  +.+  |   
          |  : :  ::   ::  :  :   :  :       :  :  :        :  :    :  : :  |   
    1e+07 |-+: :  ::   ::  :  :   :  :       :  :  :        :  :    :  : :  |   
          |  : :  : :  : : :   :  :  :       :  :  :         : :     : : :  |   
    8e+06 |-+: : :  : :  : :   : :: :      O : :: :          : :     : : : :|   
          | O: :O:OO:O: O: :  O:O::O: O OO   :O::O:O         : :     : : : :|   
    6e+06 |-+:  ::  : :  : :   : : ::         :: ::          : :     : :  ::|   
          | :   ::  : :  ::    : : ::         :: ::          ::      ::   ::|   
    4e+06 |-:   ::  : :  ::    : : ::         :: ::          ::      ::   ::|   
          | :   ::   ::   :     :: ::         :: ::           :       :   ::|   
    2e+06 |-:   :    :    :     :  :          :  :            :       :   : |   
          | :   :    :    :     :  :          :  :            :       :   : |   
        0 +-----------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                              filebench.sum_operations                          
                                                                                
  450000 +------------------------------------------------------------------+   
         |        .+       ++.+      .+ .+. +      .+. +. +.+  +.++.   +.+  |   
  400000 |-++.+  + :  ++   :  :  +  +  +   +:  +  +   +  +  :  :    +  : :  |   
  350000 |-+: :  : :  ::   :  :  :  :       :  :  :         :  :    :  : :  |   
         |  : :  : :  ::   :  :  :  :       :  :  :         :  :    :  : :  |   
  300000 |-+: :  : :  : : :   :  :: :        : :: :          : :     : : : :|   
  250000 |-+: : :  : :  : :   : : : :        : :: :          : :     : : : :|   
         | O: : :  :O: O: :O  :O: :O: O    OO:O::O:          : :     : : : :|   
  200000 |-+:  ::O  ::  : :   O:: : :  O O   : :: :          ::      ::   ::|   
  150000 |-:   ::   ::  : :    :: ::         :: ::           ::      ::   ::|   
         | :   ::   ::  : :    :: ::         :: ::           ::      ::   ::|   
  100000 |-:   ::   ::   :     ::  :          :  :            :       :   : |   
   50000 |-:   :    :    :     :   :          :  :            :       :   : |   
         | :   :    :    :     :   :          :  :            :       :   : |   
       0 +------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                            filebench.sum_operations_s                          
                                                                                
  7000 +--------------------------------------------------------------------+   
       |  +.+  + :  +.+  :  :   +  +.++.+.+:  +   ++.+.++.+ :  :    +  : :  |   
  6000 |-+: :  : :  : :  :  :   :  :       :  :   :         :  :    :  : :  |   
       |  : :  : :  : :  :  :   :  :       :  :   :         :  :    :  : :  |   
  5000 |-+: :  :  : : : :    :  :  :        : :   :         : :     : :  :  |   
       |  :  : :  : : : :    : :: :         : :: :          : :     : :  : :|   
  4000 |-+:  : :  : : : :    : :: :         : :: :          : :     : :  : :|   
       | O:  :O: O:O: : :O  O:O::O:  OO O OO:O::O:O          ::     : :   ::|   
  3000 |-:   ::   ::   ::    : : ::         :: : :           ::      ::   ::|   
       | :   ::   ::   ::    : : ::         :: : :           ::      ::   ::|   
  2000 |-:   ::   ::   ::    : : ::         :: : :           ::      ::   ::|   
       | :    :    :   :      :  :           :  :            :       :    : |   
  1000 |-:    :    :   :      :  :           :  :            :       :    : |   
       | :    :    :   :      :  :           :  :            :       :    : |   
     0 +--------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                               filebench.sum_reads_s                            
                                                                                
  700 +---------------------------------------------------------------------+   
      |        .+                                          +     .+.        |   
  600 |-++.+  + :  +.+  +.+.+  +  +.+.++.+.+  +  +.+.++.+.+:   ++   +  +.+  |   
      |  : :  : :  : :  :   :  :  :        :  :  :         :   :    :  : :  |   
  500 |-+: :  : :  : :  :   :  :  :        :  :  :         :   :    :  : :  |   
      |  :  : :  : :  : :   :  :: :        :  :: :          :  :    :  : :  |   
  400 |-+:  : :  : :  : :   : : : :        : : : :          : :     : :  : :|   
      |  :  : :  : :  : :   : : : :      O :O: :O:          : :     : :  : :|   
  300 |-O:  :O: O:O: O: :   O:: :O: O OO    :: : :          : :      ::   ::|   
      | :   ::   ::   ::     :: ::          :: ::           : :      ::   ::|   
  200 |-:   ::   ::   ::     :: ::          :: ::           : :      ::   ::|   
      | :    :    :    :     ::  :          ::  :            ::      ::   ::|   
  100 |-:    :    :    :     :   :          :   :            :       :    : |   
      | :    :    :    :     :   :          :   :            :       :    : |   
    0 +---------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                              filebench.sum_writes_s                            
                                                                                
  1400 +--------------------------------------------------------------------+   
       |        .+                                         .+     +.        |   
  1200 |-++.+  + :  +.+  +.++   +  +.++.+.++  +   ++.+.++.+ :  +.+  +  +.+  |   
       |  : :  : :  : :  :  :   :  :       :  :   :         :  :    :  : :  |   
  1000 |-+: :  : :  : :  :  :   :  :       :  :   :         :  :    :  : :  |   
       |  :  : :  : : :  :   :  :  :        : ::  :         :  :    :  : :  |   
   800 |-+:  : :  : : : :    : :: :         : :: :          : :     : :  : :|   
       |  :  : :  : : : :    : :: :       OO:O::O:O         : :     : :  : :|   
   600 |-O:  :O: O:O: O::O  O:O: ::  OO O   : :: :           ::      ::   ::|   
       | :   ::   ::   ::    : : ::         :: : :           ::      ::   ::|   
   400 |-:   ::   ::   ::    : : ::         :: : :           ::      ::   ::|   
       | :    :    :   ::     :: ::          :  ::           ::      ::   ::|   
   200 |-:    :    :   :      :  :           :  :            :       :    : |   
       | :    :    :   :      :  :           :  :            :       :    : |   
     0 +--------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                             filebench.sum_bytes_mb_s                           
                                                                                
  180 +---------------------------------------------------------------------+   
      |        .+        .+.+             .+               +   ++.+.   +.+  |   
  160 |-++.+  + :  +.+  +   :  +  +.+.++.+ :  +  +.+.++.+.+:   :    +  : :  |   
  140 |-+: :  : :  : :  :   :  :  :        :  :  :         :   :    :  : :  |   
      |  : :  : :  : :  :   :  :  :        :  :  :         :   :    :  : :  |   
  120 |-+:  : :  : :  : :   :  :: :        :  :: :          : :     : :  :  |   
  100 |-+:  : :  : :  : :   : : : :        : : : :          : :     : :  : :|   
      |  :  : : O: :  : :   : : :O: O    O :O: :O:          : :     : :  : :|   
   80 |-O:  :O:  :O: O: :   O:: : :   OO    :: : :          : :      ::   ::|   
   60 |-:   ::   ::   ::     :: ::          :: ::           : :      ::   ::|   
      | :   ::   ::   ::     :: ::          :: ::           : :      ::   ::|   
   40 |-:    :    :    :     ::  :          ::  :            :       :    ::|   
   20 |-:    :    :    :     :   :          :   :            :       :    : |   
      | :    :    :    :     :   :          :   :            :       :    : |   
    0 +---------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                            filebench.sum_time_ms_op                            
                                                                                
  16 +----------------------------------------------------------------------+   
     |      OO             O         O O                                    |   
  14 |-OO      O O  O   O    O  O  O     OO O  O O                          |   
  12 |-+                                                                    |   
     |                                                                      |   
  10 |-+                                                                    |   
     |                                                                      |   
   8 |-+ .+  +.    ++         +   + .+.+.+    +  +. +.+.+                   |   
     |  + :  : +   ::   ++.+  :   :+      +   :  : +     +.+  +.+.+.+  +.+  |   
   6 |-+:  : : :  :  :  :  :  :: :        :  :: :          :  :     :  : : :|   
   4 |-+:  : :  : :  : :    : :: :         : :: :           : :     : :  : :|   
     |  :  ::   : :  : :    :: : :         : : ::           : :      ::   ::|   
   2 |-:   ::   : :  : :    :: : :         : : ::           ::       ::   ::|   
     | :    :    :    :      :  :           :  :             :       :    : |   
   0 +----------------------------------------------------------------------+   
                                                                                
                                                                                
[*] bisect-good sample
[O] bisect-bad  sample

***************************************************************************************************
lkp-skl-2sp7: 72 threads Intel(R) Xeon(R) Gold 6139 CPU @ 2.30GHz with 128G memory
=========================================================================================
compiler/cpufreq_governor/disk/fs/kconfig/load/rootfs/tbox_group/test/testcase/ucode:
  gcc-7/performance/1BRD_48G/xfs/x86_64-rhel-7.6/3000/debian-x86_64-20191114.cgz/lkp-skl-2sp7/disk_rr/aim7/0x2000065

commit: 
  ad3a8d2d61 ("xfs: pass around xfs_inode_ag_walk iget/irele helper functions")
  ef6d7398f5 ("xfs: deferred inode inactivation")

ad3a8d2d61135b44 ef6d7398f5c72c4fa030740a755 
---------------- --------------------------- 
       fail:runs  %reproduction    fail:runs
           |             |             |    
           :4          100%           4:4     kmsg.XFS(ram#):xlog_verify_grant_tail:space>BBTOB(tail_blocks)
           :4           25%           1:4     dmesg.WARNING:at#for_ip_interrupt_entry/0x
           :4           25%           1:4     dmesg.WARNING:at_ip__fsnotify_parent/0x
         %stddev     %change         %stddev
             \          |                \  
    432696           -23.6%     330548 ±  3%  aim7.jobs-per-min
     41.78           +30.9%      54.70 ±  3%  aim7.time.elapsed_time
     41.78           +30.9%      54.70 ±  3%  aim7.time.elapsed_time.max
      2588          +490.9%      15297 ±  6%  aim7.time.involuntary_context_switches
    152861 ±  2%      -4.6%     145889 ±  3%  aim7.time.minor_page_faults
    776.39          +126.1%       1755 ±  5%  aim7.time.system_time
    273.84           +10.1%     301.44        aim7.time.user_time
    917867           -70.4%     271957 ± 28%  aim7.time.voluntary_context_switches
     25.15 ±  2%      -3.9%      24.16        boot-time.boot
      1493 ±  2%      -3.6%       1440        boot-time.idle
      0.68 ±  8%     -11.8%       0.60        boot-time.smp_boot
     66.67           -25.2%      49.87 ±  2%  iostat.cpu.idle
     24.44           +74.2%      42.59 ±  2%  iostat.cpu.system
      8.88           -15.1%       7.54 ±  2%  iostat.cpu.user
     65.45           -17.2       48.28        mpstat.cpu.all.idle%
     25.34           +18.6       43.95 ±  2%  mpstat.cpu.all.sys%
      9.21            -1.4        7.76 ±  2%  mpstat.cpu.all.usr%
 1.067e+08 ± 76%     -98.4%    1710158 ± 68%  cpuidle.C1.time
   1176245 ± 66%     -96.3%      43552 ± 56%  cpuidle.C1.usage
    204678 ± 78%     -73.0%      55335 ± 31%  cpuidle.POLL.time
     15998 ± 48%     -51.3%       7784 ± 27%  cpuidle.POLL.usage
     66.00           -25.0%      49.50 ±  2%  vmstat.cpu.id
      5778 ± 29%   +2045.0%     123936 ± 18%  vmstat.io.bo
     23.33 ±  4%     +60.7%      37.50 ±  4%  vmstat.procs.r
     43070           -70.1%      12880 ± 29%  vmstat.system.cs
     56.06 ± 16%     +45.6%      81.61 ± 13%  sched_debug.cfs_rq:/.load_avg.avg
    196.38 ± 10%     +25.3%     246.11 ±  8%  sched_debug.cfs_rq:/.load_avg.stddev
     14.30 ± 81%    +196.6%      42.41 ± 23%  sched_debug.cfs_rq:/.removed.load_avg.avg
     95.84 ± 73%    +109.6%     200.92 ± 12%  sched_debug.cfs_rq:/.removed.load_avg.stddev
    661.20 ± 81%    +194.5%       1947 ± 24%  sched_debug.cfs_rq:/.removed.runnable_sum.avg
      4431 ± 73%    +108.1%       9223 ± 12%  sched_debug.cfs_rq:/.removed.runnable_sum.stddev
      5.26 ± 71%    +225.1%      17.10 ± 35%  sched_debug.cfs_rq:/.removed.util_avg.avg
     36.94 ± 71%    +122.5%      82.19 ± 23%  sched_debug.cfs_rq:/.removed.util_avg.stddev
     -4300           -64.1%      -1543        sched_debug.cfs_rq:/.spread0.min
    -68.33           -36.7%     -43.25        sched_debug.cpu.nr_uninterruptible.min
      6602 ±  9%     +25.8%       8308 ±  9%  meminfo.Active(file)
   1184206           -38.3%     730422 ± 10%  meminfo.Dirty
   1202985           -11.3%    1067078        meminfo.Inactive
   1182103           -11.4%    1046786        meminfo.Inactive(file)
    107360           +47.4%     158228        meminfo.KReclaimable
   3867414           +45.8%    5636973 ±  2%  meminfo.Memused
    107360           +47.4%     158228        meminfo.SReclaimable
    233615           +10.9%     259004        meminfo.SUnreclaim
     40672           +15.3%      46904 ±  4%  meminfo.Shmem
    340976           +22.4%     417232        meminfo.Slab
    106984           +24.8%     133480 ±  2%  meminfo.max_used_kB
      3416 ±  7%     +18.2%       4038 ±  5%  numa-meminfo.node0.Active(file)
    594307           -38.7%     364272 ±  7%  numa-meminfo.node0.Dirty
    601477           -12.0%     529314        numa-meminfo.node0.Inactive
    593396           -12.3%     520420        numa-meminfo.node0.Inactive(file)
     52763 ± 22%     +47.8%      77977 ± 25%  numa-meminfo.node0.KReclaimable
     52763 ± 22%     +47.8%      77977 ± 25%  numa-meminfo.node0.SReclaimable
      3283 ± 10%     +29.4%       4250 ±  5%  numa-meminfo.node1.Active(file)
    596942           -38.4%     367701 ± 11%  numa-meminfo.node1.Dirty
    608469           -11.3%     540006 ±  2%  numa-meminfo.node1.Inactive
    595628           -11.3%     528594 ±  2%  numa-meminfo.node1.Inactive(file)
     97217 ± 41%     +33.3%     129616 ± 36%  numa-meminfo.node1.SUnreclaim
    151726 ± 30%     +38.3%     209861 ± 32%  numa-meminfo.node1.Slab
    906.67 ±  7%     +18.9%       1078 ±  5%  numa-vmstat.node0.nr_active_file
  14110740           +10.0%   15526999 ±  3%  numa-vmstat.node0.nr_dirtied
    147732           -38.5%      90864 ±  7%  numa-vmstat.node0.nr_dirty
    147430           -12.0%     129743        numa-vmstat.node0.nr_inactive_file
     13197 ± 22%     +47.8%      19502 ± 25%  numa-vmstat.node0.nr_slab_reclaimable
      8881 ± 69%   +3983.4%     362650 ± 22%  numa-vmstat.node0.nr_written
    889.00 ±  8%     +20.5%       1071 ±  4%  numa-vmstat.node0.nr_zone_active_file
    147421           -12.0%     129743        numa-vmstat.node0.nr_zone_inactive_file
    147593           -38.3%      91058 ±  7%  numa-vmstat.node0.nr_zone_write_pending
  14674076           +11.4%   16352027 ±  4%  numa-vmstat.node0.numa_hit
  14515762           +11.8%   16233066 ±  4%  numa-vmstat.node0.numa_local
    876.67 ± 11%     +22.4%       1073 ±  7%  numa-vmstat.node1.nr_active_file
  14106889           +11.4%   15716199        numa-vmstat.node1.nr_dirtied
    148917           -38.5%      91636 ± 11%  numa-vmstat.node1.nr_dirty
    148532           -11.3%     131813 ±  2%  numa-vmstat.node1.nr_inactive_file
     24315 ± 41%     +33.3%      32401 ± 36%  numa-vmstat.node1.nr_slab_unreclaimable
      7671 ± 70%   +4740.4%     371338 ± 20%  numa-vmstat.node1.nr_written
    877.67 ± 11%     +23.0%       1079 ±  6%  numa-vmstat.node1.nr_zone_active_file
    148518           -11.2%     131816 ±  2%  numa-vmstat.node1.nr_zone_inactive_file
    148746           -38.3%      91772 ± 11%  numa-vmstat.node1.nr_zone_write_pending
  14713499           +12.6%   16568708 ±  2%  numa-vmstat.node1.numa_hit
  14690883           +12.4%   16506391        numa-vmstat.node1.numa_local
      1685 ±  3%     +24.0%       2090 ±  6%  proc-vmstat.nr_active_file
     91708            -1.8%      90082        proc-vmstat.nr_anon_pages
    297606           -38.4%     183277 ±  9%  proc-vmstat.nr_dirty
   3205078            -1.5%    3157711        proc-vmstat.nr_dirty_background_threshold
   6417993            -1.5%    6323145        proc-vmstat.nr_dirty_threshold
    582155            -5.7%     548837        proc-vmstat.nr_file_pages
  31953714            -1.4%   31513698        proc-vmstat.nr_free_pages
      5247            -3.3%       5076        proc-vmstat.nr_inactive_anon
    297058           -11.7%     262306        proc-vmstat.nr_inactive_file
     57835            -5.1%      54883        proc-vmstat.nr_kernel_stack
      8427 ±  2%      -5.6%       7958 ±  2%  proc-vmstat.nr_mapped
     10139           +15.5%      11710 ±  4%  proc-vmstat.nr_shmem
     26818           +47.5%      39554        proc-vmstat.nr_slab_reclaimable
     58483           +10.8%      64782        proc-vmstat.nr_slab_unreclaimable
     27205 ± 69%   +6113.5%    1690420 ± 21%  proc-vmstat.nr_written
      1685 ±  3%     +24.0%       2090 ±  6%  proc-vmstat.nr_zone_active_file
      5247            -3.3%       5076        proc-vmstat.nr_zone_inactive_anon
    297058           -11.7%     262306        proc-vmstat.nr_zone_inactive_file
    297220           -38.2%     183675 ±  9%  proc-vmstat.nr_zone_write_pending
  74823426            +2.3%   76515419        proc-vmstat.numa_hit
  74800073            +2.3%   76492064        proc-vmstat.numa_local
  75988469            +2.0%   77504714        proc-vmstat.pgalloc_normal
    297303 ±  3%     +11.0%     330078 ±  2%  proc-vmstat.pgfault
  75678037            +1.2%   76591927        proc-vmstat.pgfree
    256162 ± 29%   +2705.7%    7187122 ± 20%  proc-vmstat.pgpgout
      1800           +16.9%       2104 ±  3%  slabinfo.blkdev_ioc.active_objs
      1800           +16.9%       2104 ±  3%  slabinfo.blkdev_ioc.num_objs
      3729           +71.0%       6375 ± 10%  slabinfo.kmalloc-128.active_objs
      3729           +73.4%       6464 ± 11%  slabinfo.kmalloc-128.num_objs
     27477          +215.6%      86725 ± 23%  slabinfo.kmalloc-16.active_objs
    107.33          +255.9%     382.00 ± 15%  slabinfo.kmalloc-16.active_slabs
     27477          +256.3%      97902 ± 15%  slabinfo.kmalloc-16.num_objs
    107.33          +255.9%     382.00 ± 15%  slabinfo.kmalloc-16.num_slabs
      4809 ±  5%     +19.6%       5751 ±  4%  slabinfo.kmalloc-1k.active_objs
      4920 ±  3%     +23.2%       6060 ±  5%  slabinfo.kmalloc-1k.num_objs
      1206           +17.5%       1417        slabinfo.kmalloc-4k.active_objs
      1221           +17.8%       1437        slabinfo.kmalloc-4k.num_objs
     10022 ±  3%    +332.0%      43300        slabinfo.kmalloc-512.active_objs
    325.67 ±  3%    +384.6%       1578        slabinfo.kmalloc-512.active_slabs
     10430 ±  3%    +384.4%      50523        slabinfo.kmalloc-512.num_objs
    325.67 ±  3%    +384.6%       1578        slabinfo.kmalloc-512.num_slabs
      1397           +18.4%       1654        slabinfo.kmalloc-8k.active_objs
      1407           +22.7%       1727        slabinfo.kmalloc-8k.num_objs
     33546           +25.7%      42184        slabinfo.radix_tree_node.active_objs
    601.33           +28.5%     772.75 ±  2%  slabinfo.radix_tree_node.active_slabs
     33709           +28.4%      43292 ±  2%  slabinfo.radix_tree_node.num_objs
    601.33           +28.5%     772.75 ±  2%  slabinfo.radix_tree_node.num_slabs
      2049           +18.9%       2436        slabinfo.xfs_buf.active_objs
      2049           +18.9%       2436        slabinfo.xfs_buf.num_objs
      3137           +49.0%       4673 ± 11%  slabinfo.xfs_buf_item.active_objs
      3137           +49.2%       4679 ± 11%  slabinfo.xfs_buf_item.num_objs
      1720          +102.3%       3479 ± 13%  slabinfo.xfs_efd_item.active_objs
      1720          +107.5%       3569 ± 14%  slabinfo.xfs_efd_item.num_objs
      3321 ±  5%   +1005.6%      36725 ±  2%  slabinfo.xfs_ili.active_objs
     87.33 ±  5%   +1025.6%     983.00 ±  6%  slabinfo.xfs_ili.active_slabs
      3695 ±  5%   +1017.9%      41307 ±  6%  slabinfo.xfs_ili.num_objs
     87.33 ±  5%   +1025.6%     983.00 ±  6%  slabinfo.xfs_ili.num_slabs
      2779         +1208.7%      36369 ±  2%  slabinfo.xfs_inode.active_objs
    104.67         +1109.1%       1265 ±  5%  slabinfo.xfs_inode.active_slabs
      3362         +1104.6%      40507 ±  5%  slabinfo.xfs_inode.num_objs
    104.67         +1109.1%       1265 ±  5%  slabinfo.xfs_inode.num_slabs
     14255 ±  4%     -19.0%      11547 ±  9%  softirqs.CPU0.SCHED
     21629           +14.9%      24848 ±  5%  softirqs.CPU0.TIMER
      9925 ± 15%     -31.6%       6788 ± 11%  softirqs.CPU1.SCHED
     21647 ±  2%     +17.1%      25348 ± 12%  softirqs.CPU1.TIMER
     20440           +15.8%      23675 ±  4%  softirqs.CPU10.TIMER
     20616           +15.6%      23832 ±  3%  softirqs.CPU11.TIMER
     20573           +17.9%      24249 ±  6%  softirqs.CPU12.TIMER
     21026           +13.0%      23765 ±  4%  softirqs.CPU13.TIMER
     20696           +13.1%      23400 ±  4%  softirqs.CPU14.TIMER
     20772 ±  4%     +26.9%      26361 ± 14%  softirqs.CPU15.TIMER
     20871           +15.5%      24104 ±  4%  softirqs.CPU16.TIMER
     21176 ±  2%     +12.5%      23833 ±  4%  softirqs.CPU17.TIMER
     20950 ±  4%     +17.6%      24628 ±  2%  softirqs.CPU18.TIMER
     21617 ±  9%     +14.9%      24841 ±  2%  softirqs.CPU19.TIMER
     28314 ±  5%     -22.9%      21823 ±  4%  softirqs.CPU20.RCU
     21264           +30.4%      27718 ±  5%  softirqs.CPU21.TIMER
     20974 ±  2%     +17.7%      24694        softirqs.CPU22.TIMER
     20310 ±  4%     +19.3%      24227 ±  5%  softirqs.CPU23.TIMER
     21065 ±  4%     +14.6%      24135 ±  4%  softirqs.CPU24.TIMER
     23495 ±  6%      -9.2%      21331        softirqs.CPU25.RCU
     21487 ±  7%     +11.6%      23988 ±  3%  softirqs.CPU25.TIMER
     20931           +17.4%      24581 ±  5%  softirqs.CPU26.TIMER
     20194           +18.5%      23929 ±  4%  softirqs.CPU27.TIMER
     20797           +30.4%      27129 ±  7%  softirqs.CPU28.TIMER
     20860 ±  3%     +14.3%      23842 ±  4%  softirqs.CPU29.TIMER
     25319 ±  8%     -15.5%      21398 ±  2%  softirqs.CPU3.RCU
      9554 ±  4%     -42.6%       5485 ±  7%  softirqs.CPU3.SCHED
     20236           +22.5%      24790 ±  6%  softirqs.CPU30.TIMER
     20868 ±  2%     +16.6%      24331 ±  4%  softirqs.CPU31.TIMER
     19891           +20.3%      23923 ±  3%  softirqs.CPU32.TIMER
     20094           +19.4%      23996 ±  2%  softirqs.CPU33.TIMER
     20475 ±  2%     +22.4%      25054 ±  8%  softirqs.CPU34.TIMER
     20382           +19.3%      24315 ±  2%  softirqs.CPU35.TIMER
     19879           +21.3%      24116 ±  3%  softirqs.CPU36.TIMER
     19874           +35.7%      26969 ± 22%  softirqs.CPU37.TIMER
     19876 ±  2%     +31.7%      26180 ± 18%  softirqs.CPU38.TIMER
     20143 ±  2%     +17.5%      23659 ±  3%  softirqs.CPU39.TIMER
     21161 ±  3%     +15.8%      24500 ±  7%  softirqs.CPU4.TIMER
      9108 ± 12%     -39.8%       5480 ±  3%  softirqs.CPU40.SCHED
     20063           +18.3%      23727 ±  3%  softirqs.CPU41.TIMER
     20121 ±  2%     +16.5%      23436 ±  4%  softirqs.CPU42.TIMER
     20264           +17.0%      23717 ±  4%  softirqs.CPU44.TIMER
     19914           +17.3%      23363 ±  4%  softirqs.CPU45.TIMER
     24108 ±  8%     -12.2%      21158        softirqs.CPU46.RCU
     19959 ±  2%     +17.3%      23410 ±  4%  softirqs.CPU47.TIMER
     19958           +18.7%      23681 ±  4%  softirqs.CPU48.TIMER
     20171           +15.4%      23281 ±  4%  softirqs.CPU49.TIMER
     20857 ±  2%     +14.9%      23966 ±  5%  softirqs.CPU5.TIMER
     20106           +15.8%      23274 ±  4%  softirqs.CPU51.TIMER
     20253           +13.8%      23049 ±  4%  softirqs.CPU52.TIMER
     20067           +15.8%      23246 ±  4%  softirqs.CPU53.TIMER
     20115           +20.1%      24156 ±  4%  softirqs.CPU54.TIMER
     19698           +22.7%      24167 ±  4%  softirqs.CPU55.TIMER
     19988           +11.5%      22294 ±  7%  softirqs.CPU56.TIMER
     20085           +18.4%      23780 ±  2%  softirqs.CPU57.TIMER
     20216           +16.5%      23550 ±  3%  softirqs.CPU58.TIMER
     20284 ±  3%     +16.5%      23639 ±  3%  softirqs.CPU59.TIMER
     21191           +14.0%      24159 ±  5%  softirqs.CPU6.TIMER
     20451 ±  4%     +14.8%      23476 ±  3%  softirqs.CPU61.TIMER
     19623           +25.0%      24525 ±  4%  softirqs.CPU63.TIMER
     19637 ±  2%     +36.7%      26838 ± 19%  softirqs.CPU64.TIMER
     20372 ±  4%     +14.4%      23310 ±  3%  softirqs.CPU65.TIMER
     19509           +23.2%      24043 ±  4%  softirqs.CPU66.TIMER
     19708           +19.1%      23477 ±  3%  softirqs.CPU67.TIMER
     19343           +22.1%      23616 ±  3%  softirqs.CPU68.TIMER
     19604 ±  2%     +20.8%      23682 ±  3%  softirqs.CPU69.TIMER
     20579           +18.2%      24325 ±  4%  softirqs.CPU7.TIMER
     19444           +26.9%      24667 ±  6%  softirqs.CPU70.TIMER
     19559 ±  2%     +22.0%      23863 ±  4%  softirqs.CPU71.TIMER
     20559           +16.8%      24017 ±  5%  softirqs.CPU8.TIMER
     20290           +15.5%      23444 ±  4%  softirqs.CPU9.TIMER
      4794 ± 81%     -90.5%     456.50 ± 30%  softirqs.NET_RX
    608899           -32.5%     410938        softirqs.SCHED
   1489843           +16.7%    1739375 ±  3%  softirqs.TIMER
     84524 ±  2%     +32.4%     111915 ±  3%  interrupts.CPU0.LOC:Local_timer_interrupts
     84530 ±  2%     +32.3%     111817 ±  3%  interrupts.CPU1.LOC:Local_timer_interrupts
     84479 ±  2%     +32.5%     111893 ±  3%  interrupts.CPU10.LOC:Local_timer_interrupts
    139.67 ± 11%    +121.4%     309.25 ± 40%  interrupts.CPU10.RES:Rescheduling_interrupts
    120.33 ± 95%     -97.7%       2.75 ± 64%  interrupts.CPU10.TLB:TLB_shootdowns
     84496 ±  2%     +32.4%     111898 ±  3%  interrupts.CPU11.LOC:Local_timer_interrupts
    129.67 ±  2%    +133.1%     302.25 ± 37%  interrupts.CPU11.RES:Rescheduling_interrupts
     84501 ±  2%     +32.4%     111890 ±  3%  interrupts.CPU12.LOC:Local_timer_interrupts
      5020 ±  2%     -14.1%       4313 ±  9%  interrupts.CPU12.NMI:Non-maskable_interrupts
      5020 ±  2%     -14.1%       4313 ±  9%  interrupts.CPU12.PMI:Performance_monitoring_interrupts
    135.00 ±  6%     +91.7%     258.75 ± 16%  interrupts.CPU12.RES:Rescheduling_interrupts
     84295 ±  2%     +32.8%     111914 ±  3%  interrupts.CPU13.LOC:Local_timer_interrupts
      4943           -12.4%       4331 ±  7%  interrupts.CPU13.NMI:Non-maskable_interrupts
      4943           -12.4%       4331 ±  7%  interrupts.CPU13.PMI:Performance_monitoring_interrupts
    127.00 ± 10%    +108.3%     264.50 ± 16%  interrupts.CPU13.RES:Rescheduling_interrupts
     84507 ±  2%     +32.4%     111890 ±  3%  interrupts.CPU14.LOC:Local_timer_interrupts
    127.33 ± 18%    +108.1%     265.00 ±  8%  interrupts.CPU14.RES:Rescheduling_interrupts
     84483 ±  2%     +32.4%     111886 ±  3%  interrupts.CPU15.LOC:Local_timer_interrupts
    136.00 ± 12%     +84.9%     251.50 ± 11%  interrupts.CPU15.RES:Rescheduling_interrupts
     84440 ±  2%     +32.5%     111890 ±  3%  interrupts.CPU16.LOC:Local_timer_interrupts
    135.33 ± 16%    +115.0%     291.00 ± 12%  interrupts.CPU16.RES:Rescheduling_interrupts
     84362 ±  2%     +32.6%     111845 ±  3%  interrupts.CPU17.LOC:Local_timer_interrupts
    143.67 ± 13%     +66.7%     239.50 ±  9%  interrupts.CPU17.RES:Rescheduling_interrupts
     83614 ±  3%     +33.9%     111921 ±  3%  interrupts.CPU18.LOC:Local_timer_interrupts
    164.00 ±  9%     +61.3%     264.50 ± 14%  interrupts.CPU18.RES:Rescheduling_interrupts
     83682 ±  3%     +33.8%     111929 ±  3%  interrupts.CPU19.LOC:Local_timer_interrupts
    138.67 ±  8%     +86.4%     258.50 ± 11%  interrupts.CPU19.RES:Rescheduling_interrupts
     84524 ±  2%     +32.3%     111834 ±  3%  interrupts.CPU2.LOC:Local_timer_interrupts
     83761 ±  3%     +33.6%     111910 ±  3%  interrupts.CPU20.LOC:Local_timer_interrupts
    140.33 ± 14%     +89.0%     265.25 ± 16%  interrupts.CPU20.RES:Rescheduling_interrupts
     83713 ±  3%     +33.7%     111909 ±  3%  interrupts.CPU21.LOC:Local_timer_interrupts
    175.67 ±  2%     +77.8%     312.25 ± 29%  interrupts.CPU21.RES:Rescheduling_interrupts
     83765 ±  3%     +33.6%     111918 ±  3%  interrupts.CPU22.LOC:Local_timer_interrupts
      4998 ±  2%     -11.1%       4442 ±  6%  interrupts.CPU22.NMI:Non-maskable_interrupts
      4998 ±  2%     -11.1%       4442 ±  6%  interrupts.CPU22.PMI:Performance_monitoring_interrupts
    156.00 ± 14%     +68.9%     263.50 ± 16%  interrupts.CPU22.RES:Rescheduling_interrupts
     83752 ±  3%     +33.7%     111973 ±  3%  interrupts.CPU23.LOC:Local_timer_interrupts
    143.00 ±  8%     +69.2%     242.00 ±  7%  interrupts.CPU23.RES:Rescheduling_interrupts
     83718 ±  3%     +33.8%     112007 ±  3%  interrupts.CPU24.LOC:Local_timer_interrupts
    183.67 ± 14%     +36.4%     250.50 ±  9%  interrupts.CPU24.RES:Rescheduling_interrupts
     83740 ±  3%     +33.7%     111946 ±  3%  interrupts.CPU25.LOC:Local_timer_interrupts
    150.33 ±  6%     +75.8%     264.25 ±  7%  interrupts.CPU25.RES:Rescheduling_interrupts
     83755 ±  3%     +33.6%     111935 ±  3%  interrupts.CPU26.LOC:Local_timer_interrupts
    146.00 ±  7%     +95.0%     284.75 ± 20%  interrupts.CPU26.RES:Rescheduling_interrupts
     83759 ±  3%     +33.6%     111927 ±  3%  interrupts.CPU27.LOC:Local_timer_interrupts
    137.33 ±  7%     +76.9%     243.00 ± 12%  interrupts.CPU27.RES:Rescheduling_interrupts
     83754 ±  3%     +33.6%     111902 ±  3%  interrupts.CPU28.LOC:Local_timer_interrupts
    154.33 ± 13%     +74.6%     269.50 ± 10%  interrupts.CPU28.RES:Rescheduling_interrupts
     83901 ±  3%     +33.4%     111891 ±  3%  interrupts.CPU29.LOC:Local_timer_interrupts
    142.33 ±  3%     +82.0%     259.00 ± 11%  interrupts.CPU29.RES:Rescheduling_interrupts
     84538 ±  2%     +32.2%     111781 ±  3%  interrupts.CPU3.LOC:Local_timer_interrupts
     83743 ±  3%     +33.5%     111770 ±  3%  interrupts.CPU30.LOC:Local_timer_interrupts
    148.67 ±  7%     +83.3%     272.50 ± 12%  interrupts.CPU30.RES:Rescheduling_interrupts
     83726 ±  3%     +33.7%     111931 ±  3%  interrupts.CPU31.LOC:Local_timer_interrupts
    147.33 ± 11%     +80.7%     266.25 ±  8%  interrupts.CPU31.RES:Rescheduling_interrupts
     83770 ±  3%     +33.6%     111927 ±  3%  interrupts.CPU32.LOC:Local_timer_interrupts
    147.00 ±  9%     +74.0%     255.75 ± 12%  interrupts.CPU32.RES:Rescheduling_interrupts
     84058 ±  3%     +33.1%     111906 ±  3%  interrupts.CPU33.LOC:Local_timer_interrupts
    141.00 ±  7%     +75.5%     247.50 ±  4%  interrupts.CPU33.RES:Rescheduling_interrupts
     83755 ±  3%     +33.6%     111902 ±  3%  interrupts.CPU34.LOC:Local_timer_interrupts
    138.33 ±  5%     +83.3%     253.50 ±  7%  interrupts.CPU34.RES:Rescheduling_interrupts
     83764 ±  3%     +33.6%     111917 ±  3%  interrupts.CPU35.LOC:Local_timer_interrupts
    146.00 ±  9%     +63.9%     239.25 ± 14%  interrupts.CPU35.RES:Rescheduling_interrupts
     84498 ±  2%     +32.4%     111913 ±  3%  interrupts.CPU36.LOC:Local_timer_interrupts
    138.33 ± 13%     +93.4%     267.50 ± 13%  interrupts.CPU36.RES:Rescheduling_interrupts
     84495 ±  2%     +32.4%     111885 ±  3%  interrupts.CPU37.LOC:Local_timer_interrupts
    123.67 ± 12%     +86.0%     230.00 ± 10%  interrupts.CPU37.RES:Rescheduling_interrupts
     84481 ±  2%     +32.3%     111757 ±  3%  interrupts.CPU38.LOC:Local_timer_interrupts
    135.33 ± 28%     +92.5%     260.50 ± 14%  interrupts.CPU38.RES:Rescheduling_interrupts
     84544 ±  2%     +32.3%     111869 ±  3%  interrupts.CPU39.LOC:Local_timer_interrupts
    123.67 ± 18%     +99.5%     246.75 ±  9%  interrupts.CPU39.RES:Rescheduling_interrupts
     84505 ±  2%     +32.4%     111859 ±  3%  interrupts.CPU4.LOC:Local_timer_interrupts
    146.67 ± 11%    +216.5%     464.25 ± 76%  interrupts.CPU4.RES:Rescheduling_interrupts
     84529 ±  2%     +32.4%     111894 ±  3%  interrupts.CPU40.LOC:Local_timer_interrupts
    156.00 ± 22%     +55.3%     242.25 ± 15%  interrupts.CPU40.RES:Rescheduling_interrupts
     84588 ±  2%     +32.3%     111895 ±  3%  interrupts.CPU41.LOC:Local_timer_interrupts
    132.67 ± 12%     +82.0%     241.50 ± 10%  interrupts.CPU41.RES:Rescheduling_interrupts
     84577 ±  2%     +32.3%     111881 ±  3%  interrupts.CPU42.LOC:Local_timer_interrupts
    124.00 ± 10%    +117.5%     269.75 ± 16%  interrupts.CPU42.RES:Rescheduling_interrupts
     84294 ±  2%     +32.8%     111930 ±  3%  interrupts.CPU43.LOC:Local_timer_interrupts
    128.67 ±  7%    +104.0%     262.50 ± 11%  interrupts.CPU43.RES:Rescheduling_interrupts
     84475 ±  2%     +32.5%     111898 ±  3%  interrupts.CPU44.LOC:Local_timer_interrupts
    119.33 ±  5%    +116.6%     258.50 ± 12%  interrupts.CPU44.RES:Rescheduling_interrupts
     84488 ±  2%     +32.4%     111896 ±  3%  interrupts.CPU45.LOC:Local_timer_interrupts
      5041           -23.5%       3856 ± 29%  interrupts.CPU45.NMI:Non-maskable_interrupts
      5041           -23.5%       3856 ± 29%  interrupts.CPU45.PMI:Performance_monitoring_interrupts
    129.00 ±  6%     +88.2%     242.75 ± 14%  interrupts.CPU45.RES:Rescheduling_interrupts
     84509 ±  2%     +32.6%     112060 ±  3%  interrupts.CPU46.LOC:Local_timer_interrupts
    148.33 ± 17%     +69.9%     252.00 ± 16%  interrupts.CPU46.RES:Rescheduling_interrupts
     84501 ±  2%     +32.5%     111927 ±  3%  interrupts.CPU47.LOC:Local_timer_interrupts
    125.33 ± 14%    +102.9%     254.25 ± 14%  interrupts.CPU47.RES:Rescheduling_interrupts
     84498 ±  2%     +32.5%     111931 ±  3%  interrupts.CPU48.LOC:Local_timer_interrupts
      4902           -11.0%       4360 ±  8%  interrupts.CPU48.NMI:Non-maskable_interrupts
      4902           -11.0%       4360 ±  8%  interrupts.CPU48.PMI:Performance_monitoring_interrupts
    122.67 ± 13%     +95.9%     240.25 ±  9%  interrupts.CPU48.RES:Rescheduling_interrupts
     84484 ±  2%     +32.2%     111664 ±  3%  interrupts.CPU49.LOC:Local_timer_interrupts
    128.67 ± 14%     +89.6%     244.00 ± 17%  interrupts.CPU49.RES:Rescheduling_interrupts
     84461 ±  2%     +32.5%     111899 ±  3%  interrupts.CPU5.LOC:Local_timer_interrupts
    151.67 ±  8%     +66.3%     252.25 ± 11%  interrupts.CPU5.RES:Rescheduling_interrupts
     84433 ±  2%     +32.6%     111917 ±  3%  interrupts.CPU50.LOC:Local_timer_interrupts
    129.00 ± 18%     +91.3%     246.75 ± 13%  interrupts.CPU50.RES:Rescheduling_interrupts
     84509 ±  2%     +32.4%     111888 ±  3%  interrupts.CPU51.LOC:Local_timer_interrupts
    133.67 ± 28%     +84.8%     247.00 ± 12%  interrupts.CPU51.RES:Rescheduling_interrupts
     84432 ±  2%     +32.7%     112070 ±  3%  interrupts.CPU52.LOC:Local_timer_interrupts
    117.33 ± 16%    +121.6%     260.00 ± 12%  interrupts.CPU52.RES:Rescheduling_interrupts
     84480 ±  2%     +32.4%     111884 ±  3%  interrupts.CPU53.LOC:Local_timer_interrupts
    124.00 ± 13%     +89.5%     235.00 ± 12%  interrupts.CPU53.RES:Rescheduling_interrupts
     83624 ±  3%     +33.8%     111898 ±  3%  interrupts.CPU54.LOC:Local_timer_interrupts
    122.67 ± 10%    +103.8%     250.00 ±  7%  interrupts.CPU54.RES:Rescheduling_interrupts
     83674 ±  3%     +33.8%     111922 ±  3%  interrupts.CPU55.LOC:Local_timer_interrupts
    130.33 ±  5%     +77.6%     231.50 ±  7%  interrupts.CPU55.RES:Rescheduling_interrupts
     83792 ±  3%     +33.6%     111913 ±  3%  interrupts.CPU56.LOC:Local_timer_interrupts
    122.00 ±  9%     +93.9%     236.50 ± 13%  interrupts.CPU56.RES:Rescheduling_interrupts
     83743 ±  3%     +33.7%     111929 ±  3%  interrupts.CPU57.LOC:Local_timer_interrupts
    141.33 ± 14%     +74.4%     246.50 ± 16%  interrupts.CPU57.RES:Rescheduling_interrupts
     83410 ±  4%     +34.2%     111913 ±  3%  interrupts.CPU58.LOC:Local_timer_interrupts
    128.33 ± 11%     +95.2%     250.50 ± 12%  interrupts.CPU58.RES:Rescheduling_interrupts
     83784 ±  3%     +33.6%     111901 ±  3%  interrupts.CPU59.LOC:Local_timer_interrupts
    123.00 ± 13%    +103.3%     250.00 ± 10%  interrupts.CPU59.RES:Rescheduling_interrupts
     84532 ±  2%     +32.4%     111904 ±  3%  interrupts.CPU6.LOC:Local_timer_interrupts
     83703 ±  3%     +33.7%     111905 ±  3%  interrupts.CPU60.LOC:Local_timer_interrupts
    107.00 ± 12%    +124.1%     239.75 ±  4%  interrupts.CPU60.RES:Rescheduling_interrupts
    111.67 ±128%     -97.5%       2.75 ± 53%  interrupts.CPU60.TLB:TLB_shootdowns
     83745 ±  3%     +33.5%     111824 ±  3%  interrupts.CPU61.LOC:Local_timer_interrupts
      4893 ±  3%     -10.4%       4382 ±  8%  interrupts.CPU61.NMI:Non-maskable_interrupts
      4893 ±  3%     -10.4%       4382 ±  8%  interrupts.CPU61.PMI:Performance_monitoring_interrupts
    117.00 ± 10%    +105.6%     240.50 ±  8%  interrupts.CPU61.RES:Rescheduling_interrupts
     83766 ±  3%     +33.6%     111899 ±  3%  interrupts.CPU62.LOC:Local_timer_interrupts
    118.00 ± 11%    +102.3%     238.75 ±  9%  interrupts.CPU62.RES:Rescheduling_interrupts
     83593 ±  3%     +33.9%     111895 ±  3%  interrupts.CPU63.LOC:Local_timer_interrupts
    108.33 ± 20%    +137.9%     257.75 ±  2%  interrupts.CPU63.RES:Rescheduling_interrupts
     83746 ±  3%     +33.6%     111905 ±  3%  interrupts.CPU64.LOC:Local_timer_interrupts
    112.00 ±  7%    +135.7%     264.00 ± 13%  interrupts.CPU64.RES:Rescheduling_interrupts
     83730 ±  3%     +33.6%     111890 ±  3%  interrupts.CPU65.LOC:Local_timer_interrupts
    109.33 ±  5%    +125.7%     246.75 ±  7%  interrupts.CPU65.RES:Rescheduling_interrupts
     83698 ±  3%     +33.7%     111879 ±  3%  interrupts.CPU66.LOC:Local_timer_interrupts
    135.33 ±  7%     +76.8%     239.25 ±  6%  interrupts.CPU66.RES:Rescheduling_interrupts
     83748 ±  3%     +33.6%     111889 ±  3%  interrupts.CPU67.LOC:Local_timer_interrupts
    125.00 ± 13%    +117.8%     272.25 ±  8%  interrupts.CPU67.RES:Rescheduling_interrupts
     83754 ±  3%     +33.6%     111902 ±  3%  interrupts.CPU68.LOC:Local_timer_interrupts
    114.00 ± 13%    +134.2%     267.00 ± 10%  interrupts.CPU68.RES:Rescheduling_interrupts
     83761 ±  3%     +33.6%     111881 ±  3%  interrupts.CPU69.LOC:Local_timer_interrupts
    120.00 ± 13%    +127.5%     273.00 ± 23%  interrupts.CPU69.RES:Rescheduling_interrupts
     84486 ±  2%     +32.4%     111895 ±  3%  interrupts.CPU7.LOC:Local_timer_interrupts
    138.67 ±  8%     +74.5%     242.00 ± 11%  interrupts.CPU7.RES:Rescheduling_interrupts
     83748 ±  3%     +33.6%     111884 ±  3%  interrupts.CPU70.LOC:Local_timer_interrupts
    129.67 ± 37%    +102.6%     262.75 ± 10%  interrupts.CPU70.RES:Rescheduling_interrupts
     83818 ±  3%     +33.6%     111984 ±  3%  interrupts.CPU71.LOC:Local_timer_interrupts
    151.67 ± 12%     +74.9%     265.25 ± 12%  interrupts.CPU71.RES:Rescheduling_interrupts
     84500 ±  2%     +32.0%     111523 ±  3%  interrupts.CPU8.LOC:Local_timer_interrupts
    135.00 ± 11%    +459.4%     755.25 ±119%  interrupts.CPU8.RES:Rescheduling_interrupts
     84434 ±  2%     +32.4%     111774 ±  3%  interrupts.CPU9.LOC:Local_timer_interrupts
    136.33 ± 12%     +84.3%     251.25 ± 19%  interrupts.CPU9.RES:Rescheduling_interrupts
   6056002 ±  3%     +33.0%    8056230 ±  3%  interrupts.LOC:Local_timer_interrupts
     14039 ±  4%     +62.0%      22738 ±  7%  interrupts.RES:Rescheduling_interrupts
     22.36 ±  4%     -17.3        5.09 ± 14%  perf-profile.calltrace.cycles-pp.secondary_startup_64
     22.09 ±  4%     -17.1        4.99 ± 14%  perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.secondary_startup_64
     22.09 ±  4%     -17.1        4.99 ± 14%  perf-profile.calltrace.cycles-pp.start_secondary.secondary_startup_64
     22.08 ±  4%     -17.1        4.99 ± 14%  perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64
     21.79 ±  4%     -17.0        4.79 ± 15%  perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry.start_secondary
     21.80 ±  4%     -17.0        4.82 ± 15%  perf-profile.calltrace.cycles-pp.cpuidle_enter.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64
     21.42 ±  4%     -16.9        4.47 ± 17%  perf-profile.calltrace.cycles-pp.intel_idle.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry
     34.65           -11.8       22.84 ±  8%  perf-profile.calltrace.cycles-pp.write
     29.53            -9.9       19.66 ±  8%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.write
     29.34            -9.8       19.55 ±  8%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     25.25            -8.4       16.81 ±  8%  perf-profile.calltrace.cycles-pp.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     23.41            -8.4       15.01 ±  7%  perf-profile.calltrace.cycles-pp.read
     24.55            -8.2       16.38 ±  8%  perf-profile.calltrace.cycles-pp.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     22.42            -7.5       14.96 ±  8%  perf-profile.calltrace.cycles-pp.new_sync_write.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
     21.52            -7.2       14.35 ±  8%  perf-profile.calltrace.cycles-pp.xfs_file_buffered_aio_write.new_sync_write.vfs_write.ksys_write.do_syscall_64
     18.70            -6.8       11.89 ±  7%  perf-profile.calltrace.cycles-pp.iomap_file_buffered_write.xfs_file_buffered_aio_write.new_sync_write.vfs_write.ksys_write
     18.58            -6.8       11.81 ±  7%  perf-profile.calltrace.cycles-pp.iomap_apply.iomap_file_buffered_write.xfs_file_buffered_aio_write.new_sync_write.vfs_write
     18.01            -6.4       11.65 ±  7%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.read
     17.81            -6.3       11.52 ±  7%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
     14.71            -5.6        9.16 ±  7%  perf-profile.calltrace.cycles-pp.iomap_write_actor.iomap_apply.iomap_file_buffered_write.xfs_file_buffered_aio_write.new_sync_write
     13.74 ±  2%      -5.0        8.78 ±  7%  perf-profile.calltrace.cycles-pp.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
     13.05 ±  2%      -4.7        8.34 ±  7%  perf-profile.calltrace.cycles-pp.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
     11.14 ±  2%      -4.1        7.03 ±  7%  perf-profile.calltrace.cycles-pp.new_sync_read.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
     10.91 ±  2%      -4.0        6.87 ±  7%  perf-profile.calltrace.cycles-pp.xfs_file_read_iter.new_sync_read.vfs_read.ksys_read.do_syscall_64
     10.75            -3.9        6.84 ±  6%  perf-profile.calltrace.cycles-pp.lseek64
     10.17            -3.8        6.38 ±  7%  perf-profile.calltrace.cycles-pp.xfs_file_buffered_aio_read.xfs_file_read_iter.new_sync_read.vfs_read.ksys_read
      9.30            -3.5        5.79 ±  7%  perf-profile.calltrace.cycles-pp.generic_file_read_iter.xfs_file_buffered_aio_read.xfs_file_read_iter.new_sync_read.vfs_read
      8.02            -3.0        4.99 ±  7%  perf-profile.calltrace.cycles-pp.iomap_write_begin.iomap_write_actor.iomap_apply.iomap_file_buffered_write.xfs_file_buffered_aio_write
      4.33 ±  2%      -2.1        2.19 ±  8%  perf-profile.calltrace.cycles-pp.close
      4.27 ±  2%      -2.1        2.16 ±  9%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.close
      4.27 ±  2%      -2.1        2.16 ±  9%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.close
      4.25 ±  2%      -2.1        2.14 ±  9%  perf-profile.calltrace.cycles-pp.exit_to_usermode_loop.do_syscall_64.entry_SYSCALL_64_after_hwframe.close
      4.24 ±  2%      -2.1        2.14 ±  9%  perf-profile.calltrace.cycles-pp.task_work_run.exit_to_usermode_loop.do_syscall_64.entry_SYSCALL_64_after_hwframe.close
      4.24 ±  2%      -2.1        2.13 ±  9%  perf-profile.calltrace.cycles-pp.__fput.task_work_run.exit_to_usermode_loop.do_syscall_64.entry_SYSCALL_64_after_hwframe
      4.11 ±  2%      -2.1        2.05 ±  9%  perf-profile.calltrace.cycles-pp.dput.__fput.task_work_run.exit_to_usermode_loop.do_syscall_64
      4.09 ±  2%      -2.1        2.04 ±  9%  perf-profile.calltrace.cycles-pp.__dentry_kill.dput.__fput.task_work_run.exit_to_usermode_loop
      5.46            -1.9        3.57 ±  7%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.lseek64
      5.25            -1.8        3.44 ±  7%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.lseek64
      4.74            -1.6        3.18 ±  8%  perf-profile.calltrace.cycles-pp.grab_cache_page_write_begin.iomap_write_begin.iomap_write_actor.iomap_apply.iomap_file_buffered_write
      4.58            -1.5        3.07 ±  8%  perf-profile.calltrace.cycles-pp.pagecache_get_page.grab_cache_page_write_begin.iomap_write_begin.iomap_write_actor.iomap_apply
      3.78            -1.4        2.35 ±  6%  perf-profile.calltrace.cycles-pp.copy_page_to_iter.generic_file_read_iter.xfs_file_buffered_aio_read.xfs_file_read_iter.new_sync_read
      3.36 ±  2%      -1.4        1.97 ±  6%  perf-profile.calltrace.cycles-pp.iomap_write_end.iomap_write_actor.iomap_apply.iomap_file_buffered_write.xfs_file_buffered_aio_write
      3.20            -1.3        1.91 ±  6%  perf-profile.calltrace.cycles-pp.copyout.copy_page_to_iter.generic_file_read_iter.xfs_file_buffered_aio_read.xfs_file_read_iter
      2.17            -1.3        0.90 ±  8%  perf-profile.calltrace.cycles-pp.iomap_set_range_uptodate.iomap_write_begin.iomap_write_actor.iomap_apply.iomap_file_buffered_write
      3.27 ±  2%      -1.3        2.01 ±  9%  perf-profile.calltrace.cycles-pp.evict.__dentry_kill.dput.__fput.task_work_run
      3.10            -1.3        1.85 ±  6%  perf-profile.calltrace.cycles-pp.copy_user_enhanced_fast_string.copyout.copy_page_to_iter.generic_file_read_iter.xfs_file_buffered_aio_read
      3.24 ±  2%      -1.2        2.00 ±  9%  perf-profile.calltrace.cycles-pp.truncate_inode_pages_range.evict.__dentry_kill.dput.__fput
      2.62            -1.0        1.59 ±  6%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64.write
      2.64            -1.0        1.64 ±  5%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64.lseek64
      2.65 ±  2%      -1.0        1.66 ±  6%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64.read
      2.53            -1.0        1.58 ± 10%  perf-profile.calltrace.cycles-pp.mark_page_accessed.generic_file_read_iter.xfs_file_buffered_aio_read.xfs_file_read_iter.new_sync_read
      2.25            -0.9        1.38 ±  7%  perf-profile.calltrace.cycles-pp.syscall_return_via_sysret.lseek64
      2.26            -0.9        1.40 ±  6%  perf-profile.calltrace.cycles-pp.syscall_return_via_sysret.read
      2.23            -0.8        1.40 ±  8%  perf-profile.calltrace.cycles-pp.syscall_return_via_sysret.write
      1.44            -0.8        0.69 ±  6%  perf-profile.calltrace.cycles-pp.iomap_set_range_uptodate.iomap_write_end.iomap_write_actor.iomap_apply.iomap_file_buffered_write
      1.78 ±  3%      -0.7        1.07 ± 11%  perf-profile.calltrace.cycles-pp.__pagevec_release.truncate_inode_pages_range.evict.__dentry_kill.dput
      2.46            -0.7        1.76 ±  9%  perf-profile.calltrace.cycles-pp.xfs_buffered_write_iomap_begin.iomap_apply.iomap_file_buffered_write.xfs_file_buffered_aio_write.new_sync_write
      1.67 ±  3%      -0.7        0.98 ± 11%  perf-profile.calltrace.cycles-pp.release_pages.__pagevec_release.truncate_inode_pages_range.evict.__dentry_kill
      0.96            -0.7        0.28 ±100%  perf-profile.calltrace.cycles-pp.__alloc_pages_nodemask.pagecache_get_page.grab_cache_page_write_begin.iomap_write_begin.iomap_write_actor
      1.48            -0.7        0.81 ±  5%  perf-profile.calltrace.cycles-pp.pagecache_get_page.generic_file_read_iter.xfs_file_buffered_aio_read.xfs_file_read_iter.new_sync_read
      1.39            -0.6        0.75 ±  5%  perf-profile.calltrace.cycles-pp.find_get_entry.pagecache_get_page.generic_file_read_iter.xfs_file_buffered_aio_read.xfs_file_read_iter
      0.88 ±  2%      -0.6        0.28 ±100%  perf-profile.calltrace.cycles-pp.__activate_page.pagevec_lru_move_fn.activate_page.mark_page_accessed.generic_file_read_iter
      1.66            -0.6        1.06 ± 12%  perf-profile.calltrace.cycles-pp.activate_page.mark_page_accessed.generic_file_read_iter.xfs_file_buffered_aio_read.xfs_file_read_iter
      0.85            -0.6        0.27 ±100%  perf-profile.calltrace.cycles-pp.find_get_entry.pagecache_get_page.grab_cache_page_write_begin.iomap_write_begin.iomap_write_actor
      1.58            -0.6        1.01 ± 12%  perf-profile.calltrace.cycles-pp.pagevec_lru_move_fn.activate_page.mark_page_accessed.generic_file_read_iter.xfs_file_buffered_aio_read
      2.24            -0.5        1.70 ±  9%  perf-profile.calltrace.cycles-pp.add_to_page_cache_lru.pagecache_get_page.grab_cache_page_write_begin.iomap_write_begin.iomap_write_actor
      1.73 ±  6%      -0.5        1.20 ± 10%  perf-profile.calltrace.cycles-pp.xfs_file_aio_write_checks.xfs_file_buffered_aio_write.new_sync_write.vfs_write.ksys_write
      1.49            -0.5        1.02 ±  7%  perf-profile.calltrace.cycles-pp.iov_iter_copy_from_user_atomic.iomap_write_actor.iomap_apply.iomap_file_buffered_write.xfs_file_buffered_aio_write
      1.26            -0.5        0.80 ±  8%  perf-profile.calltrace.cycles-pp.ksys_lseek.do_syscall_64.entry_SYSCALL_64_after_hwframe.lseek64
      1.40 ±  3%      -0.4        0.97 ±  7%  perf-profile.calltrace.cycles-pp.iomap_set_page_dirty.iomap_write_end.iomap_write_actor.iomap_apply.iomap_file_buffered_write
      0.82            -0.4        0.42 ± 58%  perf-profile.calltrace.cycles-pp.security_file_permission.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.68 ± 13%      -0.4        0.29 ±100%  perf-profile.calltrace.cycles-pp.file_update_time.xfs_file_aio_write_checks.xfs_file_buffered_aio_write.new_sync_write.vfs_write
      1.31            -0.4        0.93 ± 10%  perf-profile.calltrace.cycles-pp.__lru_cache_add.add_to_page_cache_lru.pagecache_get_page.grab_cache_page_write_begin.iomap_write_begin
      0.80 ±  4%      -0.4        0.42 ± 58%  perf-profile.calltrace.cycles-pp.__set_page_dirty.iomap_set_page_dirty.iomap_write_end.iomap_write_actor.iomap_apply
      1.26            -0.4        0.88 ± 10%  perf-profile.calltrace.cycles-pp.pagevec_lru_move_fn.__lru_cache_add.add_to_page_cache_lru.pagecache_get_page.grab_cache_page_write_begin
      1.20            -0.4        0.83 ±  6%  perf-profile.calltrace.cycles-pp.copyin.iov_iter_copy_from_user_atomic.iomap_write_actor.iomap_apply.iomap_file_buffered_write
      1.02            -0.4        0.67 ±  7%  perf-profile.calltrace.cycles-pp.security_file_permission.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.10            -0.3        0.76 ±  6%  perf-profile.calltrace.cycles-pp.copy_user_enhanced_fast_string.copyin.iov_iter_copy_from_user_atomic.iomap_write_actor.iomap_apply
      0.87            -0.1        0.73 ±  8%  perf-profile.calltrace.cycles-pp.__add_to_page_cache_locked.add_to_page_cache_lru.pagecache_get_page.grab_cache_page_write_begin.iomap_write_begin
      0.69 ±  4%      -0.1        0.61 ±  6%  perf-profile.calltrace.cycles-pp.memset_erms.iomap_write_begin.iomap_write_actor.iomap_apply.iomap_file_buffered_write
      0.65            +0.1        0.77 ±  3%  perf-profile.calltrace.cycles-pp.xfs_generic_create.path_openat.do_filp_open.do_sys_openat2.do_sys_open
      0.64            +0.1        0.76 ±  2%  perf-profile.calltrace.cycles-pp.xfs_create.xfs_generic_create.path_openat.do_filp_open.do_sys_openat2
      0.55            +0.1        0.68 ±  2%  perf-profile.calltrace.cycles-pp.rwsem_spin_on_owner.rwsem_optimistic_spin.rwsem_down_write_slowpath.do_unlinkat.do_syscall_64
      0.00            +0.7        0.69 ±  2%  perf-profile.calltrace.cycles-pp.rwsem_spin_on_owner.rwsem_optimistic_spin.rwsem_down_write_slowpath.path_openat.do_filp_open
      1.82           +21.7       23.51 ±  7%  perf-profile.calltrace.cycles-pp.unlink
      1.80           +21.7       23.50 ±  7%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.unlink
      1.80           +21.7       23.50 ±  7%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.unlink
      1.78           +21.7       23.49 ±  7%  perf-profile.calltrace.cycles-pp.do_unlinkat.do_syscall_64.entry_SYSCALL_64_after_hwframe.unlink
      1.18 ±  2%     +21.8       22.97 ±  7%  perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.do_unlinkat.do_syscall_64.entry_SYSCALL_64_after_hwframe.unlink
      0.77 ±  2%     +21.8       22.56 ±  8%  perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.path_openat.do_filp_open.do_sys_openat2.do_sys_open
      0.00           +21.8       21.80 ±  8%  perf-profile.calltrace.cycles-pp.osq_lock.rwsem_optimistic_spin.rwsem_down_write_slowpath.path_openat.do_filp_open
      1.71           +21.8       23.52 ±  8%  perf-profile.calltrace.cycles-pp.creat
      1.69           +21.8       23.50 ±  8%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.creat
      1.69           +21.8       23.50 ±  8%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.creat
      1.69           +21.8       23.50 ±  8%  perf-profile.calltrace.cycles-pp.do_sys_open.do_syscall_64.entry_SYSCALL_64_after_hwframe.creat
      1.69           +21.8       23.50 ±  8%  perf-profile.calltrace.cycles-pp.do_sys_openat2.do_sys_open.do_syscall_64.entry_SYSCALL_64_after_hwframe.creat
      1.67           +21.8       23.48 ±  8%  perf-profile.calltrace.cycles-pp.do_filp_open.do_sys_openat2.do_sys_open.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.66           +21.8       23.48 ±  8%  perf-profile.calltrace.cycles-pp.path_openat.do_filp_open.do_sys_openat2.do_sys_open.do_syscall_64
      0.64 ±  2%     +21.9       22.51 ±  8%  perf-profile.calltrace.cycles-pp.rwsem_optimistic_spin.rwsem_down_write_slowpath.path_openat.do_filp_open.do_sys_openat2
      1.02           +21.9       22.91 ±  7%  perf-profile.calltrace.cycles-pp.rwsem_optimistic_spin.rwsem_down_write_slowpath.do_unlinkat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00           +22.2       22.21 ±  8%  perf-profile.calltrace.cycles-pp.osq_lock.rwsem_optimistic_spin.rwsem_down_write_slowpath.do_unlinkat.do_syscall_64
     22.36 ±  4%     -17.3        5.09 ± 14%  perf-profile.children.cycles-pp.do_idle
     22.36 ±  4%     -17.3        5.09 ± 14%  perf-profile.children.cycles-pp.secondary_startup_64
     22.36 ±  4%     -17.3        5.09 ± 14%  perf-profile.children.cycles-pp.cpu_startup_entry
     22.08 ±  4%     -17.2        4.92 ± 15%  perf-profile.children.cycles-pp.cpuidle_enter
     22.08 ±  4%     -17.2        4.92 ± 15%  perf-profile.children.cycles-pp.cpuidle_enter_state
     21.68 ±  4%     -17.1        4.57 ± 17%  perf-profile.children.cycles-pp.intel_idle
     22.09 ±  4%     -17.1        4.99 ± 14%  perf-profile.children.cycles-pp.start_secondary
     35.07           -12.0       23.10 ±  8%  perf-profile.children.cycles-pp.write
     23.80            -8.5       15.26 ±  7%  perf-profile.children.cycles-pp.read
     25.27            -8.4       16.83 ±  8%  perf-profile.children.cycles-pp.ksys_write
     24.59            -8.2       16.41 ±  8%  perf-profile.children.cycles-pp.vfs_write
     22.44            -7.5       14.99 ±  8%  perf-profile.children.cycles-pp.new_sync_write
     21.55            -7.2       14.37 ±  8%  perf-profile.children.cycles-pp.xfs_file_buffered_aio_write
     18.71            -6.8       11.90 ±  7%  perf-profile.children.cycles-pp.iomap_file_buffered_write
     18.60            -6.8       11.83 ±  7%  perf-profile.children.cycles-pp.iomap_apply
     14.77            -5.6        9.19 ±  7%  perf-profile.children.cycles-pp.iomap_write_actor
     13.75 ±  2%      -5.0        8.79 ±  7%  perf-profile.children.cycles-pp.ksys_read
     13.07 ±  2%      -4.7        8.36 ±  7%  perf-profile.children.cycles-pp.vfs_read
     11.15 ±  2%      -4.1        7.04 ±  7%  perf-profile.children.cycles-pp.new_sync_read
     11.13            -4.1        7.06 ±  6%  perf-profile.children.cycles-pp.lseek64
     10.92 ±  2%      -4.1        6.87 ±  7%  perf-profile.children.cycles-pp.xfs_file_read_iter
     10.20 ±  2%      -3.8        6.39 ±  7%  perf-profile.children.cycles-pp.xfs_file_buffered_aio_read
      9.33            -3.5        5.80 ±  7%  perf-profile.children.cycles-pp.generic_file_read_iter
      8.05            -3.0        5.01 ±  7%  perf-profile.children.cycles-pp.iomap_write_begin
      7.94            -3.0        4.91 ±  6%  perf-profile.children.cycles-pp.entry_SYSCALL_64
      7.67            -2.9        4.73 ±  7%  perf-profile.children.cycles-pp.syscall_return_via_sysret
      6.10            -2.2        3.90 ±  7%  perf-profile.children.cycles-pp.pagecache_get_page
      4.34 ±  2%      -2.2        2.19 ±  8%  perf-profile.children.cycles-pp.close
      4.24 ±  2%      -2.1        2.14 ±  9%  perf-profile.children.cycles-pp.task_work_run
      4.24 ±  2%      -2.1        2.13 ±  9%  perf-profile.children.cycles-pp.__fput
      4.25 ±  2%      -2.1        2.15 ±  9%  perf-profile.children.cycles-pp.exit_to_usermode_loop
      4.12 ±  2%      -2.1        2.06 ±  9%  perf-profile.children.cycles-pp.dput
      4.09 ±  2%      -2.1        2.04 ±  9%  perf-profile.children.cycles-pp.__dentry_kill
      3.62            -2.0        1.59 ±  7%  perf-profile.children.cycles-pp.iomap_set_range_uptodate
      4.33            -1.6        2.68 ±  6%  perf-profile.children.cycles-pp.copy_user_enhanced_fast_string
      4.76            -1.6        3.20 ±  8%  perf-profile.children.cycles-pp.grab_cache_page_write_begin
      3.81            -1.4        2.36 ±  6%  perf-profile.children.cycles-pp.copy_page_to_iter
      3.37 ±  2%      -1.4        1.98 ±  6%  perf-profile.children.cycles-pp.iomap_write_end
      3.21            -1.3        1.91 ±  6%  perf-profile.children.cycles-pp.copyout
      3.27 ±  2%      -1.3        2.01 ±  9%  perf-profile.children.cycles-pp.evict
      3.25 ±  2%      -1.2        2.00 ±  9%  perf-profile.children.cycles-pp.truncate_inode_pages_range
      2.27            -1.0        1.29 ±  5%  perf-profile.children.cycles-pp.find_get_entry
      2.94            -1.0        1.98 ± 11%  perf-profile.children.cycles-pp.pagevec_lru_move_fn
      2.54            -1.0        1.58 ± 10%  perf-profile.children.cycles-pp.mark_page_accessed
      1.82 ±  3%      -0.7        1.07 ± 10%  perf-profile.children.cycles-pp.release_pages
      2.50            -0.7        1.78 ±  9%  perf-profile.children.cycles-pp.xfs_buffered_write_iomap_begin
      1.78 ±  3%      -0.7        1.07 ± 11%  perf-profile.children.cycles-pp.__pagevec_release
      1.87            -0.6        1.22 ±  8%  perf-profile.children.cycles-pp.security_file_permission
      1.66            -0.6        1.06 ± 12%  perf-profile.children.cycles-pp.activate_page
      1.46 ±  3%      -0.6        0.90 ± 11%  perf-profile.children.cycles-pp.__fdget_pos
      2.25            -0.5        1.70 ±  9%  perf-profile.children.cycles-pp.add_to_page_cache_lru
      1.76 ±  6%      -0.5        1.22 ±  9%  perf-profile.children.cycles-pp.xfs_file_aio_write_checks
      1.57            -0.5        1.04 ±  8%  perf-profile.children.cycles-pp.xfs_ilock
      0.75 ±  4%      -0.5        0.25 ±  7%  perf-profile.children.cycles-pp.__list_del_entry_valid
      1.50            -0.5        1.03 ±  7%  perf-profile.children.cycles-pp.iov_iter_copy_from_user_atomic
      1.28            -0.5        0.81 ±  7%  perf-profile.children.cycles-pp.ksys_lseek
      1.25 ±  2%      -0.5        0.79 ± 11%  perf-profile.children.cycles-pp.common_file_perm
      2.10 ±  2%      -0.5        1.65 ± 14%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      1.17 ±  3%      -0.4        0.72 ± 12%  perf-profile.children.cycles-pp.__fget_light
      1.42 ±  2%      -0.4        0.98 ±  7%  perf-profile.children.cycles-pp.iomap_set_page_dirty
      2.07 ±  6%      -0.4        1.63 ± 14%  perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
      0.97 ±  2%      -0.4        0.54 ±  8%  perf-profile.children.cycles-pp.__alloc_pages_nodemask
      1.06            -0.4        0.65 ±  2%  perf-profile.children.cycles-pp.xas_load
      1.32            -0.4        0.93 ± 10%  perf-profile.children.cycles-pp.__lru_cache_add
      1.22            -0.4        0.84 ±  7%  perf-profile.children.cycles-pp.copyin
      0.80 ±  2%      -0.4        0.41 ±  8%  perf-profile.children.cycles-pp.get_page_from_freelist
      0.92 ±  2%      -0.4        0.54 ±  9%  perf-profile.children.cycles-pp.__activate_page
      0.92            -0.3        0.59 ±  9%  perf-profile.children.cycles-pp.down_write
      0.47            -0.3        0.14 ± 13%  perf-profile.children.cycles-pp.free_unref_page_list
      0.91 ±  2%      -0.3        0.60 ±  8%  perf-profile.children.cycles-pp.xfs_iunlock
      0.94            -0.3        0.66 ±  8%  perf-profile.children.cycles-pp.___might_sleep
      0.81 ±  4%      -0.3        0.54 ±  8%  perf-profile.children.cycles-pp.__set_page_dirty
      0.65            -0.3        0.39 ±  5%  perf-profile.children.cycles-pp.iov_iter_fault_in_readable
      0.53            -0.3        0.28 ± 11%  perf-profile.children.cycles-pp.workingset_activation
      0.53            -0.3        0.28 ±  9%  perf-profile.children.cycles-pp.advance_inactive_age
      0.70 ±  4%      -0.2        0.46 ±  7%  perf-profile.children.cycles-pp.__mod_lruvec_state
      0.59 ±  4%      -0.2        0.35 ±  8%  perf-profile.children.cycles-pp.truncate_cleanup_page
      0.63 ±  4%      -0.2        0.39 ±  8%  perf-profile.children.cycles-pp.xfs_buffered_write_iomap_end
      0.68 ±  2%      -0.2        0.47 ±  7%  perf-profile.children.cycles-pp.fsnotify
      1.11 ±  8%      -0.2        0.90 ± 13%  perf-profile.children.cycles-pp.__xfs_trans_commit
      0.61 ±  7%      -0.2        0.40 ± 11%  perf-profile.children.cycles-pp.account_page_dirtied
      0.59 ±  2%      -0.2        0.38 ±  7%  perf-profile.children.cycles-pp.__pagevec_lru_add_fn
      0.51 ±  5%      -0.2        0.30 ±  8%  perf-profile.children.cycles-pp.__cancel_dirty_page
      1.07 ±  9%      -0.2        0.87 ± 13%  perf-profile.children.cycles-pp.xfs_log_commit_cil
      0.67 ±  8%      -0.2        0.48 ±  9%  perf-profile.children.cycles-pp.touch_atime
      0.42 ±  4%      -0.2        0.24 ±  7%  perf-profile.children.cycles-pp.account_page_cleaned
      0.58            -0.2        0.40 ±  5%  perf-profile.children.cycles-pp.delete_from_page_cache_batch
      0.42 ±  5%      -0.2        0.25 ± 10%  perf-profile.children.cycles-pp.xfs_break_layouts
      0.53 ±  2%      -0.2        0.35 ±  7%  perf-profile.children.cycles-pp.xfs_file_llseek
      0.70 ± 13%      -0.2        0.53 ± 11%  perf-profile.children.cycles-pp.file_update_time
      0.27 ± 18%      -0.2        0.10 ± 38%  perf-profile.children.cycles-pp.start_kernel
      0.22 ±  6%      -0.2        0.05 ± 62%  perf-profile.children.cycles-pp.enqueue_task_fair
      0.22 ±  6%      -0.2        0.05 ± 62%  perf-profile.children.cycles-pp.ttwu_do_activate
      0.22 ±  6%      -0.2        0.05 ± 62%  perf-profile.children.cycles-pp.activate_task
      0.60            -0.2        0.43 ± 10%  perf-profile.children.cycles-pp.xfs_file_write_iter
      0.49            -0.2        0.33 ± 10%  perf-profile.children.cycles-pp.__might_sleep
      0.21 ±  3%      -0.2        0.05 ± 62%  perf-profile.children.cycles-pp.enqueue_entity
      0.89            -0.1        0.74 ±  8%  perf-profile.children.cycles-pp.__add_to_page_cache_locked
      0.22 ±  3%      -0.1        0.08 ± 22%  perf-profile.children.cycles-pp.try_to_wake_up
      0.17 ±  2%      -0.1        0.03 ±100%  perf-profile.children.cycles-pp.__account_scheduler_latency
      0.45 ±  2%      -0.1        0.30 ±  6%  perf-profile.children.cycles-pp._cond_resched
      0.42 ±  3%      -0.1        0.28 ±  9%  perf-profile.children.cycles-pp.up_write
      0.61 ± 13%      -0.1        0.48 ± 13%  perf-profile.children.cycles-pp._raw_spin_lock
      0.46 ±  4%      -0.1        0.34 ±  8%  perf-profile.children.cycles-pp.__sb_start_write
      0.43 ±  3%      -0.1        0.30 ±  7%  perf-profile.children.cycles-pp.__fsnotify_parent
      0.52            -0.1        0.40 ± 10%  perf-profile.children.cycles-pp.xas_store
      0.42 ±  2%      -0.1        0.30 ±  9%  perf-profile.children.cycles-pp.current_time
      0.42 ±  2%      -0.1        0.30 ±  7%  perf-profile.children.cycles-pp.down_read
      0.15 ±  6%      -0.1        0.03 ±100%  perf-profile.children.cycles-pp.stack_trace_save_tsk
      0.31 ±  4%      -0.1        0.19 ±  4%  perf-profile.children.cycles-pp.xas_start
      0.14 ±  6%      -0.1        0.03 ±100%  perf-profile.children.cycles-pp.arch_stack_walk
      0.26 ±  6%      -0.1        0.15 ± 10%  perf-profile.children.cycles-pp.xfs_break_leased_layouts
      0.32 ±  2%      -0.1        0.21 ± 20%  perf-profile.children.cycles-pp.xfs_trans_read_buf_map
      0.18 ±  2%      -0.1        0.08 ± 16%  perf-profile.children.cycles-pp.__sched_text_start
      0.15 ±  3%      -0.1        0.05 ± 62%  perf-profile.children.cycles-pp.xfs_read_agi
      0.25 ±  3%      -0.1        0.15 ± 10%  perf-profile.children.cycles-pp.__mod_node_page_state
      0.36            -0.1        0.26 ±  7%  perf-profile.children.cycles-pp.atime_needs_update
      0.43            -0.1        0.34 ±  7%  perf-profile.children.cycles-pp.__x86_indirect_thunk_rax
      0.15 ±  3%      -0.1        0.06 ± 60%  perf-profile.children.cycles-pp.xfs_buf_item_release
      0.23 ±  2%      -0.1        0.14 ± 20%  perf-profile.children.cycles-pp.xfs_buf_read_map
      0.14            -0.1        0.05 ± 60%  perf-profile.children.cycles-pp.up
      0.23 ±  4%      -0.1        0.14 ± 18%  perf-profile.children.cycles-pp.xfs_buf_get_map
      0.20 ±  2%      -0.1        0.12 ± 21%  perf-profile.children.cycles-pp.xfs_buf_find
      0.14            -0.1        0.05 ± 62%  perf-profile.children.cycles-pp.xfs_buf_unlock
      0.11 ±  4%      -0.1        0.03 ±102%  perf-profile.children.cycles-pp.xfs_inactive_truncate
      0.72 ±  4%      -0.1        0.64 ±  6%  perf-profile.children.cycles-pp.memset_erms
      0.22 ±  3%      -0.1        0.14 ±  5%  perf-profile.children.cycles-pp.unlock_page
      0.22 ±  3%      -0.1        0.14 ±  5%  perf-profile.children.cycles-pp.__x64_sys_write
      0.15 ±  3%      -0.1        0.07 ± 64%  perf-profile.children.cycles-pp.xfs_iunlink_remove
      0.31 ±  8%      -0.1        0.23 ±  9%  perf-profile.children.cycles-pp.percpu_counter_add_batch
      0.14 ±  3%      -0.1        0.06 ± 16%  perf-profile.children.cycles-pp.schedule
      0.23 ±  2%      -0.1        0.16 ±  7%  perf-profile.children.cycles-pp.xfs_bmbt_to_iomap
      0.22            -0.1        0.15 ±  5%  perf-profile.children.cycles-pp.__x64_sys_read
      0.31 ±  6%      -0.1        0.23 ±  9%  perf-profile.children.cycles-pp.__mod_memcg_state
      0.21 ±  2%      -0.1        0.14 ±  8%  perf-profile.children.cycles-pp.__x64_sys_lseek
      0.26            -0.1        0.19 ±  4%  perf-profile.children.cycles-pp.xfs_iext_lookup_extent
      0.21            -0.1        0.14 ± 13%  perf-profile.children.cycles-pp.node_dirty_ok
      0.27 ±  4%      -0.1        0.20 ±  9%  perf-profile.children.cycles-pp.apparmor_file_permission
      0.23            -0.1        0.16 ± 10%  perf-profile.children.cycles-pp.mem_cgroup_commit_charge
      0.23 ±  2%      -0.1        0.16 ±  7%  perf-profile.children.cycles-pp.rcu_all_qs
      0.16            -0.1        0.10 ±  5%  perf-profile.children.cycles-pp.aa_file_perm
      0.20 ±  4%      -0.1        0.14 ±  8%  perf-profile.children.cycles-pp.up_read
      0.19 ±  2%      -0.1        0.12 ± 13%  perf-profile.children.cycles-pp.page_mapping
      0.15 ±  3%      -0.1        0.10 ± 11%  perf-profile.children.cycles-pp.iov_iter_advance
      0.18 ±  2%      -0.1        0.13 ± 11%  perf-profile.children.cycles-pp.timestamp_truncate
      0.08 ± 10%      -0.1        0.03 ±100%  perf-profile.children.cycles-pp.dec_zone_page_state
      0.15 ±  5%      -0.1        0.10 ±  8%  perf-profile.children.cycles-pp.pagevec_lookup_entries
      0.15 ±  5%      -0.1        0.10 ±  8%  perf-profile.children.cycles-pp.find_get_entries
      0.08 ±  6%      -0.1        0.03 ±100%  perf-profile.children.cycles-pp.xfs_get_extsz_hint
      0.08 ±  6%      -0.1        0.03 ±100%  perf-profile.children.cycles-pp.open64
      0.22 ±  3%      -0.0        0.17 ± 11%  perf-profile.children.cycles-pp.generic_write_checks
      0.17            -0.0        0.12 ± 10%  perf-profile.children.cycles-pp.__might_fault
      0.07 ± 17%      -0.0        0.03 ±100%  perf-profile.children.cycles-pp.xfs_log_ticket_ungrant
      0.07            -0.0        0.03 ±100%  perf-profile.children.cycles-pp.__mark_inode_dirty
      0.07            -0.0        0.03 ±100%  perf-profile.children.cycles-pp.kmem_cache_alloc
      0.12 ±  4%      -0.0        0.08 ±  6%  perf-profile.children.cycles-pp.__sb_end_write
      0.17 ±  2%      -0.0        0.13 ± 13%  perf-profile.children.cycles-pp.fpregs_assert_state_consistent
      0.11 ±  4%      -0.0        0.07 ± 11%  perf-profile.children.cycles-pp.__list_add_valid
      0.24 ±  3%      -0.0        0.20 ±  7%  perf-profile.children.cycles-pp.xfs_da3_node_lookup_int
      0.08 ± 10%      -0.0        0.04 ± 58%  perf-profile.children.cycles-pp.times
      0.08 ± 14%      -0.0        0.04 ± 59%  perf-profile.children.cycles-pp.xlog_grant_add_space
      0.10 ±  8%      -0.0        0.06 ±  6%  perf-profile.children.cycles-pp.mem_cgroup_update_lru_size
      0.08 ±  6%      -0.0        0.04 ± 58%  perf-profile.children.cycles-pp.node_page_state
      0.12 ±  4%      -0.0        0.08        perf-profile.children.cycles-pp.rw_verify_area
      0.15            -0.0        0.12 ± 13%  perf-profile.children.cycles-pp.mem_cgroup_charge_statistics
      0.08 ±  6%      -0.0        0.04 ± 58%  perf-profile.children.cycles-pp.alloc_pages_current
      0.09 ±  5%      -0.0        0.06 ± 11%  perf-profile.children.cycles-pp.xfs_free_eofblocks
      0.09 ± 13%      -0.0        0.06 ± 11%  perf-profile.children.cycles-pp.update_load_avg
      0.07 ± 11%      -0.0        0.04 ± 57%  perf-profile.children.cycles-pp.free_unref_page_commit
      0.10 ±  8%      -0.0        0.07 ±  6%  perf-profile.children.cycles-pp.mem_cgroup_uncharge_list
      0.14 ±  3%      -0.0        0.11 ±  8%  perf-profile.children.cycles-pp.workingset_update_node
      0.09 ±  5%      -0.0        0.05 ±  9%  perf-profile.children.cycles-pp.file_modified
      0.11 ±  4%      -0.0        0.08 ±  6%  perf-profile.children.cycles-pp.__xa_set_mark
      0.11 ±  4%      -0.0        0.08 ±  6%  perf-profile.children.cycles-pp.unaccount_page_cache_page
      0.11 ±  7%      -0.0        0.08 ±  8%  perf-profile.children.cycles-pp.xas_init_marks
      0.26 ±  4%      -0.0        0.23 ±  3%  perf-profile.children.cycles-pp.xfs_errortag_test
      0.11 ± 11%      -0.0        0.09 ±  5%  perf-profile.children.cycles-pp.wait_for_stable_page
      0.09 ±  5%      -0.0        0.07 ± 17%  perf-profile.children.cycles-pp.__mod_zone_page_state
      0.10 ±  4%      -0.0        0.07 ± 10%  perf-profile.children.cycles-pp.xfs_release
      0.07 ±  7%      -0.0        0.04 ± 58%  perf-profile.children.cycles-pp.xfs_dir3_leaf_check_int
      0.08 ±  5%      -0.0        0.06 ±  7%  perf-profile.children.cycles-pp.xas_clear_mark
      0.06 ±  7%      -0.0        0.04 ± 57%  perf-profile.children.cycles-pp.xfs_trans_unreserve_and_mod_sb
      0.08            -0.0        0.06 ±  9%  perf-profile.children.cycles-pp.iov_iter_init
      0.13 ±  3%      -0.0        0.11 ±  6%  perf-profile.children.cycles-pp._raw_spin_unlock_irqrestore
      0.12 ±  3%      -0.0        0.10 ±  7%  perf-profile.children.cycles-pp.xfs_da_read_buf
      0.09 ±  9%      -0.0        0.07 ± 10%  perf-profile.children.cycles-pp.xfs_vn_lookup
      0.09 ±  5%      -0.0        0.08 ±  6%  perf-profile.children.cycles-pp.ktime_get_coarse_real_ts64
      0.08 ±  6%      -0.0        0.06 ±  6%  perf-profile.children.cycles-pp.xfs_da3_node_read
      0.02 ±141%      +0.0        0.05 ±  9%  perf-profile.children.cycles-pp.xfs_verify_agino
      0.02 ±141%      +0.0        0.06 ±  7%  perf-profile.children.cycles-pp.xfs_iunlink
      0.12 ±  3%      +0.0        0.17 ± 14%  perf-profile.children.cycles-pp.xfs_buf_item_format
      0.08            +0.0        0.12 ± 17%  perf-profile.children.cycles-pp._raw_spin_lock_irq
      0.05            +0.0        0.10 ± 15%  perf-profile.children.cycles-pp.xfs_inobt_get_maxrecs
      0.11 ±  8%      +0.1        0.20 ± 11%  perf-profile.children.cycles-pp.__xfs_btree_check_sblock
      0.11            +0.1        0.21 ± 13%  perf-profile.children.cycles-pp.xfs_btree_increment
      0.12 ±  4%      +0.1        0.22 ± 11%  perf-profile.children.cycles-pp.xfs_btree_get_rec
      0.06 ±  8%      +0.1        0.17 ± 52%  perf-profile.children.cycles-pp.xfs_difree_finobt
      0.26            +0.1        0.38 ± 17%  perf-profile.children.cycles-pp.xfs_dialloc
      0.65            +0.1        0.77 ±  3%  perf-profile.children.cycles-pp.xfs_generic_create
      0.64            +0.1        0.76 ±  2%  perf-profile.children.cycles-pp.xfs_create
      0.00            +0.1        0.13 ± 39%  perf-profile.children.cycles-pp.brd_do_bvec
      0.00            +0.1        0.13 ± 35%  perf-profile.children.cycles-pp.xfs_inactive_worker
      0.29            +0.1        0.42 ± 15%  perf-profile.children.cycles-pp.xfs_dir_ialloc
      0.28            +0.1        0.42 ± 16%  perf-profile.children.cycles-pp.xfs_ialloc
      0.00            +0.1        0.13 ± 40%  perf-profile.children.cycles-pp.submit_bio
      0.00            +0.1        0.13 ± 40%  perf-profile.children.cycles-pp.generic_make_request
      0.00            +0.1        0.13 ± 40%  perf-profile.children.cycles-pp.brd_make_request
      0.22            +0.1        0.35 ± 18%  perf-profile.children.cycles-pp.xfs_dialloc_ag
      0.20 ±  4%      +0.1        0.34 ±  9%  perf-profile.children.cycles-pp.xfs_inobt_get_rec
      0.16            +0.1        0.31 ± 10%  perf-profile.children.cycles-pp.xfs_btree_check_sblock
      0.00            +0.2        0.16 ± 36%  perf-profile.children.cycles-pp.__writeback_single_inode
      0.00            +0.2        0.16 ± 36%  perf-profile.children.cycles-pp.do_writepages
      0.00            +0.2        0.16 ± 36%  perf-profile.children.cycles-pp.xfs_vm_writepages
      0.00            +0.2        0.16 ± 36%  perf-profile.children.cycles-pp.wb_workfn
      0.00            +0.2        0.16 ± 36%  perf-profile.children.cycles-pp.wb_writeback
      0.00            +0.2        0.16 ± 36%  perf-profile.children.cycles-pp.writeback_sb_inodes
      1.26            +0.2        1.45 ±  2%  perf-profile.children.cycles-pp.rwsem_spin_on_owner
      0.38 ±  2%      +0.2        0.58 ± 10%  perf-profile.children.cycles-pp.xfs_check_agi_freecount
      0.00            +0.4        0.39 ± 25%  perf-profile.children.cycles-pp.process_one_work
      0.00            +0.4        0.39 ± 24%  perf-profile.children.cycles-pp.worker_thread
      0.02 ±141%      +0.4        0.43 ± 23%  perf-profile.children.cycles-pp.ret_from_fork
      0.02 ±141%      +0.4        0.43 ± 23%  perf-profile.children.cycles-pp.kthread
      0.00            +0.6        0.56 ± 32%  perf-profile.children.cycles-pp.xfs_inode_free_blocks
      0.00            +0.7        0.68 ± 21%  perf-profile.children.cycles-pp.xfs_inactive_inode
      0.00            +0.7        0.69 ± 21%  perf-profile.children.cycles-pp.xfs_ici_walk_fns
      0.00            +0.7        0.69 ± 21%  perf-profile.children.cycles-pp.xfs_ici_walk_ag
      1.82           +21.7       23.52 ±  7%  perf-profile.children.cycles-pp.unlink
      1.78           +21.7       23.49 ±  7%  perf-profile.children.cycles-pp.do_unlinkat
      1.75           +21.8       23.54 ±  7%  perf-profile.children.cycles-pp.do_sys_open
      1.75           +21.8       23.54 ±  7%  perf-profile.children.cycles-pp.do_sys_openat2
      1.72           +21.8       23.52 ±  8%  perf-profile.children.cycles-pp.creat
      1.71           +21.8       23.51 ±  7%  perf-profile.children.cycles-pp.path_openat
      1.71           +21.8       23.52 ±  7%  perf-profile.children.cycles-pp.do_filp_open
     60.95           +23.2       84.17        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     60.40           +23.4       83.83        perf-profile.children.cycles-pp.do_syscall_64
      0.57 ±  3%     +43.5       44.04 ±  8%  perf-profile.children.cycles-pp.osq_lock
      1.96           +43.6       45.53 ±  8%  perf-profile.children.cycles-pp.rwsem_down_write_slowpath
      1.67           +43.8       45.43 ±  8%  perf-profile.children.cycles-pp.rwsem_optimistic_spin
     21.68 ±  4%     -17.1        4.57 ± 17%  perf-profile.self.cycles-pp.intel_idle
     11.35            -3.8        7.58 ±  6%  perf-profile.self.cycles-pp.do_syscall_64
      7.65            -2.9        4.72 ±  7%  perf-profile.self.cycles-pp.syscall_return_via_sysret
      7.02            -2.7        4.36 ±  6%  perf-profile.self.cycles-pp.entry_SYSCALL_64
      3.57            -2.0        1.57 ±  7%  perf-profile.self.cycles-pp.iomap_set_range_uptodate
      4.28            -1.6        2.66 ±  6%  perf-profile.self.cycles-pp.copy_user_enhanced_fast_string
      1.30            -0.6        0.71 ±  7%  perf-profile.self.cycles-pp.find_get_entry
      0.74 ±  3%      -0.5        0.25 ±  7%  perf-profile.self.cycles-pp.__list_del_entry_valid
      2.06 ±  5%      -0.4        1.63 ± 14%  perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
      1.13 ±  3%      -0.4        0.70 ± 12%  perf-profile.self.cycles-pp.__fget_light
      1.07 ±  3%      -0.4        0.68 ± 12%  perf-profile.self.cycles-pp.common_file_perm
      0.76 ±  3%      -0.3        0.45 ±  4%  perf-profile.self.cycles-pp.xas_load
      0.91            -0.3        0.64 ±  8%  perf-profile.self.cycles-pp.___might_sleep
      0.64            -0.3        0.38 ±  5%  perf-profile.self.cycles-pp.iov_iter_fault_in_readable
      0.52            -0.3        0.27 ± 11%  perf-profile.self.cycles-pp.advance_inactive_age
      0.71 ±  5%      -0.2        0.46 ±  6%  perf-profile.self.cycles-pp.xfs_file_read_iter
      0.69 ±  2%      -0.2        0.46 ± 10%  perf-profile.self.cycles-pp.iomap_apply
      0.56            -0.2        0.34 ±  5%  perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.70 ±  4%      -0.2        0.49 ±  8%  perf-profile.self.cycles-pp.generic_file_read_iter
      0.67 ±  2%      -0.2        0.46 ±  6%  perf-profile.self.cycles-pp.fsnotify
      0.48 ±  3%      -0.2        0.29 ± 10%  perf-profile.self.cycles-pp.xfs_buffered_write_iomap_end
      0.80            -0.2        0.61 ±  9%  perf-profile.self.cycles-pp.xfs_buffered_write_iomap_begin
      0.49 ±  6%      -0.2        0.30        perf-profile.self.cycles-pp.write
      0.41 ±  2%      -0.2        0.24 ±  9%  perf-profile.self.cycles-pp.__activate_page
      0.52 ±  3%      -0.2        0.35 ± 11%  perf-profile.self.cycles-pp.iomap_write_actor
      0.51 ±  2%      -0.2        0.34 ±  7%  perf-profile.self.cycles-pp.xfs_file_llseek
      0.45 ±  6%      -0.2        0.29 ±  2%  perf-profile.self.cycles-pp.read
      0.41            -0.2        0.25 ±  8%  perf-profile.self.cycles-pp.lseek64
      0.58 ±  2%      -0.2        0.42 ±  9%  perf-profile.self.cycles-pp.xfs_file_write_iter
      0.40            -0.1        0.26 ±  8%  perf-profile.self.cycles-pp.pagecache_get_page
      0.35 ±  2%      -0.1        0.21 ±  3%  perf-profile.self.cycles-pp.release_pages
      0.44            -0.1        0.30 ±  9%  perf-profile.self.cycles-pp.__might_sleep
      0.40            -0.1        0.26 ±  7%  perf-profile.self.cycles-pp.down_write
      0.38 ±  3%      -0.1        0.24 ±  8%  perf-profile.self.cycles-pp.__pagevec_lru_add_fn
      0.34 ±  2%      -0.1        0.20 ±  5%  perf-profile.self.cycles-pp.iomap_write_end
      0.40 ±  2%      -0.1        0.26 ±  9%  perf-profile.self.cycles-pp.up_write
      0.31            -0.1        0.18 ±  7%  perf-profile.self.cycles-pp.__fdget_pos
      0.37 ±  3%      -0.1        0.25 ±  9%  perf-profile.self.cycles-pp.xfs_file_buffered_aio_write
      0.40 ±  4%      -0.1        0.29 ±  7%  perf-profile.self.cycles-pp.__fsnotify_parent
      0.31 ±  3%      -0.1        0.20 ±  7%  perf-profile.self.cycles-pp.xfs_iunlock
      0.32            -0.1        0.21 ±  9%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.34 ±  4%      -0.1        0.23 ±  5%  perf-profile.self.cycles-pp.mark_page_accessed
      0.35 ±  2%      -0.1        0.25 ±  7%  perf-profile.self.cycles-pp.iomap_write_begin
      0.28 ±  4%      -0.1        0.18 ±  6%  perf-profile.self.cycles-pp.__mod_lruvec_state
      0.28 ±  4%      -0.1        0.18 ±  6%  perf-profile.self.cycles-pp.xas_start
      0.22 ±  4%      -0.1        0.12 ±  7%  perf-profile.self.cycles-pp.ksys_lseek
      0.26 ±  3%      -0.1        0.17 ±  5%  perf-profile.self.cycles-pp.vfs_write
      0.26            -0.1        0.17 ±  8%  perf-profile.self.cycles-pp.xfs_ilock
      0.24 ±  6%      -0.1        0.15 ±  8%  perf-profile.self.cycles-pp.xfs_break_leased_layouts
      0.24 ±  3%      -0.1        0.15 ± 11%  perf-profile.self.cycles-pp.__mod_node_page_state
      0.25            -0.1        0.15 ±  8%  perf-profile.self.cycles-pp.get_page_from_freelist
      0.28            -0.1        0.19 ±  9%  perf-profile.self.cycles-pp.iov_iter_copy_from_user_atomic
      0.21 ± 12%      -0.1        0.13 ± 16%  perf-profile.self.cycles-pp.account_page_dirtied
      0.24            -0.1        0.16 ±  7%  perf-profile.self.cycles-pp.security_file_permission
      0.71 ±  4%      -0.1        0.63 ±  5%  perf-profile.self.cycles-pp.memset_erms
      0.23 ±  4%      -0.1        0.15 ±  5%  perf-profile.self.cycles-pp.down_read
      0.36 ±  2%      -0.1        0.28 ±  5%  perf-profile.self.cycles-pp.__x86_indirect_thunk_rax
      0.25 ±  3%      -0.1        0.17 ±  8%  perf-profile.self.cycles-pp.__sb_start_write
      0.19 ±  2%      -0.1        0.12 ±  7%  perf-profile.self.cycles-pp.iomap_set_page_dirty
      0.20 ±  2%      -0.1        0.13 ±  6%  perf-profile.self.cycles-pp.__x64_sys_write
      0.21 ±  3%      -0.1        0.14 ±  8%  perf-profile.self.cycles-pp.unlock_page
      0.20 ±  4%      -0.1        0.12 ±  8%  perf-profile.self.cycles-pp.new_sync_write
      0.22 ±  4%      -0.1        0.14 ±  7%  perf-profile.self.cycles-pp._cond_resched
      0.23 ±  2%      -0.1        0.16 ±  7%  perf-profile.self.cycles-pp.xfs_bmbt_to_iomap
      0.19 ±  4%      -0.1        0.12 ±  7%  perf-profile.self.cycles-pp.ksys_write
      0.16 ± 10%      -0.1        0.09 ±  9%  perf-profile.self.cycles-pp.account_page_cleaned
      0.26            -0.1        0.19 ±  4%  perf-profile.self.cycles-pp.xfs_iext_lookup_extent
      0.22            -0.1        0.15 ±  8%  perf-profile.self.cycles-pp.vfs_read
      0.20 ±  6%      -0.1        0.14 ±  6%  perf-profile.self.cycles-pp.ksys_read
      0.19            -0.1        0.12 ±  8%  perf-profile.self.cycles-pp.__x64_sys_lseek
      0.16            -0.1        0.10 ±  5%  perf-profile.self.cycles-pp.aa_file_perm
      0.30 ±  6%      -0.1        0.23 ± 11%  perf-profile.self.cycles-pp.__mod_memcg_state
      0.26 ±  4%      -0.1        0.19 ±  6%  perf-profile.self.cycles-pp.copy_page_to_iter
      0.24 ±  6%      -0.1        0.18 ±  6%  perf-profile.self.cycles-pp.apparmor_file_permission
      0.20            -0.1        0.14 ±  6%  perf-profile.self.cycles-pp.__x64_sys_read
      0.19 ±  5%      -0.1        0.12 ±  8%  perf-profile.self.cycles-pp.up_read
      0.18 ±  2%      -0.1        0.12 ± 10%  perf-profile.self.cycles-pp.page_mapping
      0.16 ±  2%      -0.1        0.11 ±  4%  perf-profile.self.cycles-pp.xfs_file_aio_write_checks
      0.16 ±  5%      -0.1        0.10 ±  4%  perf-profile.self.cycles-pp.__add_to_page_cache_locked
      0.19 ±  2%      -0.1        0.14 ± 10%  perf-profile.self.cycles-pp.new_sync_read
      0.14 ±  3%      -0.1        0.09 ±  9%  perf-profile.self.cycles-pp.iov_iter_advance
      0.12 ±  3%      -0.1        0.07 ± 10%  perf-profile.self.cycles-pp.xfs_break_layouts
      0.24 ±  9%      -0.0        0.19 ± 11%  perf-profile.self.cycles-pp.percpu_counter_add_batch
      0.08 ±  6%      -0.0        0.03 ±100%  perf-profile.self.cycles-pp.node_page_state
      0.15 ±  6%      -0.0        0.10 ± 14%  perf-profile.self.cycles-pp.current_time
      0.16 ±  2%      -0.0        0.12 ± 12%  perf-profile.self.cycles-pp.timestamp_truncate
      0.16 ±  2%      -0.0        0.12 ± 10%  perf-profile.self.cycles-pp.rcu_all_qs
      0.11 ±  4%      -0.0        0.07 ± 10%  perf-profile.self.cycles-pp.__sb_end_write
      0.20            -0.0        0.16 ± 12%  perf-profile.self.cycles-pp.xas_store
      0.17 ±  5%      -0.0        0.12 ± 11%  perf-profile.self.cycles-pp.fpregs_assert_state_consistent
      0.14            -0.0        0.10 ± 12%  perf-profile.self.cycles-pp.file_update_time
      0.08            -0.0        0.04 ± 58%  perf-profile.self.cycles-pp.delete_from_page_cache_batch
      0.12 ±  6%      -0.0        0.08 ±  8%  perf-profile.self.cycles-pp.find_get_entries
      0.08 ± 12%      -0.0        0.04 ± 57%  perf-profile.self.cycles-pp.__cancel_dirty_page
      0.16 ±  3%      -0.0        0.12 ± 11%  perf-profile.self.cycles-pp.atime_needs_update
      0.10 ±  4%      -0.0        0.07 ±  7%  perf-profile.self.cycles-pp.__list_add_valid
      0.08 ± 14%      -0.0        0.04 ± 59%  perf-profile.self.cycles-pp.xlog_grant_add_space
      0.13            -0.0        0.09 ± 17%  perf-profile.self.cycles-pp.node_dirty_ok
      0.09 ±  9%      -0.0        0.05 ±  8%  perf-profile.self.cycles-pp.xfs_file_buffered_aio_read
      0.13 ±  3%      -0.0        0.09 ±  7%  perf-profile.self.cycles-pp.workingset_update_node
      0.12 ±  4%      -0.0        0.08        perf-profile.self.cycles-pp.rw_verify_area
      0.08 ±  6%      -0.0        0.04 ± 58%  perf-profile.self.cycles-pp.iov_iter_init
      0.09 ±  5%      -0.0        0.06 ± 11%  perf-profile.self.cycles-pp.generic_write_checks
      0.10 ±  4%      -0.0        0.07 ± 14%  perf-profile.self.cycles-pp.iomap_file_buffered_write
      0.09            -0.0        0.06 ±  7%  perf-profile.self.cycles-pp.truncate_inode_pages_range
      0.09 ±  9%      -0.0        0.06 ±  7%  perf-profile.self.cycles-pp.mem_cgroup_update_lru_size
      0.11 ±  7%      -0.0        0.08 ± 10%  perf-profile.self.cycles-pp.wait_for_stable_page
      0.11 ±  7%      -0.0        0.08 ±  5%  perf-profile.self.cycles-pp.__alloc_pages_nodemask
      0.08            -0.0        0.05 ±  8%  perf-profile.self.cycles-pp.activate_page
      0.07 ±  7%      -0.0        0.04 ± 58%  perf-profile.self.cycles-pp.xfs_dir3_leaf_check_int
      0.08 ±  6%      -0.0        0.05 ±  8%  perf-profile.self.cycles-pp.touch_atime
      0.10            -0.0        0.08 ± 10%  perf-profile.self.cycles-pp._raw_spin_unlock_irqrestore
      0.11            -0.0        0.09 ±  9%  perf-profile.self.cycles-pp.xfs_log_commit_cil
      0.08 ±  6%      -0.0        0.06 ±  9%  perf-profile.self.cycles-pp.xas_clear_mark
      0.07 ± 11%      -0.0        0.05 ±  8%  perf-profile.self.cycles-pp.pagevec_lru_move_fn
      0.08            -0.0        0.07 ±  7%  perf-profile.self.cycles-pp.ktime_get_coarse_real_ts64
      0.06            +0.0        0.10 ± 15%  perf-profile.self.cycles-pp.__xfs_btree_check_sblock
      0.03 ± 70%      +0.1        0.09 ± 16%  perf-profile.self.cycles-pp.xfs_inobt_get_maxrecs
      1.25            +0.2        1.43 ±  2%  perf-profile.self.cycles-pp.rwsem_spin_on_owner
      0.57 ±  3%     +43.2       43.75 ±  8%  perf-profile.self.cycles-pp.osq_lock



***************************************************************************************************
lkp-skl-2sp7: 72 threads Intel(R) Xeon(R) Gold 6139 CPU @ 2.30GHz with 128G memory
=========================================================================================
compiler/cpufreq_governor/disk/fs/kconfig/load/rootfs/tbox_group/test/testcase/ucode:
  gcc-7/performance/1BRD_48G/xfs/x86_64-rhel-7.6/3000/debian-x86_64-20191114.cgz/lkp-skl-2sp7/disk_wrt/aim7/0x2000065

commit: 
  ad3a8d2d61 ("xfs: pass around xfs_inode_ag_walk iget/irele helper functions")
  ef6d7398f5 ("xfs: deferred inode inactivation")

ad3a8d2d61135b44 ef6d7398f5c72c4fa030740a755 
---------------- --------------------------- 
       fail:runs  %reproduction    fail:runs
           |             |             |    
           :4           75%           3:4     kmsg.XFS(ram#):xlog_verify_grant_tail:space>BBTOB(tail_blocks)
         %stddev     %change         %stddev
             \          |                \  
    491983           -35.7%     316419        aim7.jobs-per-min
     36.75           +55.2%      57.06        aim7.time.elapsed_time
     36.75           +55.2%      57.06        aim7.time.elapsed_time.max
      1331 ±  3%    +355.2%       6060 ±  2%  aim7.time.involuntary_context_switches
    414.89          +285.4%       1598        aim7.time.system_time
     87.74            +5.9%      92.95        aim7.time.user_time
    911402           -49.8%     457462        aim7.time.voluntary_context_switches
      7764 ±140%    +100.1%      15534 ± 70%  numa-numastat.node0.other_node
  61754017 ±117%     -96.2%    2329702 ±  6%  cpuidle.C1.time
    740827 ±122%     -90.4%      71356 ±  2%  cpuidle.C1.usage
     81.81           -26.5%      60.16        iostat.cpu.idle
     14.75          +153.7%      37.43        iostat.cpu.system
      3.44           -30.1%       2.40        iostat.cpu.user
     81.13           -22.2       58.89        mpstat.cpu.all.idle%
     15.31           +23.3       38.64        mpstat.cpu.all.sys%
      3.56            -1.1        2.46        mpstat.cpu.all.usr%
     13301 ± 19%     -38.7%       8151 ± 12%  sched_debug.cfs_rq:/.min_vruntime.avg
      6502 ± 20%     -37.1%       4087 ± 28%  sched_debug.cfs_rq:/.min_vruntime.min
      1503 ±  9%     -22.3%       1168 ±  9%  sched_debug.cfs_rq:/.util_avg.max
     81.33           -26.2%      60.00        vmstat.cpu.id
      3359 ±  4%    +138.4%       8008 ±  5%  vmstat.io.bo
     12.67 ±  3%    +110.5%      26.67 ±  4%  vmstat.procs.r
     47928           -56.9%      20677        vmstat.system.cs
     40549 ±  5%     +36.7%      55433 ±  9%  meminfo.AnonHugePages
     25798 ±  3%     +12.5%      29012 ±  2%  meminfo.Inactive
      7703 ± 13%     +23.0%       9471 ±  4%  meminfo.Inactive(file)
    102122           +28.0%     130762        meminfo.KReclaimable
    102122           +28.0%     130762        meminfo.SReclaimable
     30222 ±  2%     +49.5%      45191 ±  2%  meminfo.Shmem
    334337           +12.7%     376959        meminfo.Slab
     71061           -31.4%      48748        meminfo.max_used_kB
    143793 ± 20%     +43.1%     205809 ± 16%  numa-meminfo.node0.Active
    143598 ± 20%     +43.3%     205739 ± 16%  numa-meminfo.node0.Active(anon)
    141249 ± 20%     +44.5%     204098 ± 17%  numa-meminfo.node0.AnonPages
      8634 ± 24%     +41.3%      12197 ±  9%  numa-meminfo.node0.Inactive
    232652 ± 12%     -22.8%     179603 ± 18%  numa-meminfo.node1.Active
    232631 ± 12%     -22.9%     179458 ± 18%  numa-meminfo.node1.Active(anon)
    223072 ± 12%     -30.2%     155683 ± 22%  numa-meminfo.node1.AnonPages
     49548 ± 14%     +45.5%      72071 ± 14%  numa-meminfo.node1.KReclaimable
     49548 ± 14%     +45.5%      72071 ± 14%  numa-meminfo.node1.SReclaimable
     22838 ± 14%     +56.9%      35826 ±  8%  numa-meminfo.node1.Shmem
     35894 ± 20%     +43.4%      51458 ± 16%  numa-vmstat.node0.nr_active_anon
     35309 ± 20%     +44.6%      51047 ± 17%  numa-vmstat.node0.nr_anon_pages
  13619965           +15.4%   15716693 ±  2%  numa-vmstat.node0.nr_dirtied
    924.00 ± 18%     +27.5%       1178 ±  8%  numa-vmstat.node0.nr_inactive_file
      1173 ± 50%    +312.3%       4837 ±  7%  numa-vmstat.node0.nr_written
     35894 ± 20%     +43.4%      51458 ± 16%  numa-vmstat.node0.nr_zone_active_anon
    910.00 ± 18%     +29.4%       1177 ±  7%  numa-vmstat.node0.nr_zone_inactive_file
  14144986           +14.9%   16253886 ±  2%  numa-vmstat.node0.numa_hit
  13993881           +15.0%   16095327 ±  2%  numa-vmstat.node0.numa_local
     58134 ± 12%     -22.7%      44948 ± 18%  numa-vmstat.node1.nr_active_anon
     55744 ± 12%     -30.0%      39032 ± 22%  numa-vmstat.node1.nr_anon_pages
  13700941 ±  3%     +14.5%   15682059 ±  2%  numa-vmstat.node1.nr_dirtied
      5709 ± 14%     +56.5%       8933 ±  8%  numa-vmstat.node1.nr_shmem
     12389 ± 14%     +45.3%      18002 ± 14%  numa-vmstat.node1.nr_slab_reclaimable
    944.00 ± 19%    +322.4%       3987 ± 19%  numa-vmstat.node1.nr_written
     58134 ± 12%     -22.7%      44948 ± 18%  numa-vmstat.node1.nr_zone_active_anon
    788.00 ±  5%     -20.6%     625.33 ±  6%  numa-vmstat.node1.nr_zone_write_pending
  14331122 ±  2%     +14.1%   16354286        numa-vmstat.node1.numa_hit
  14301275 ±  2%     +14.2%   16331660        numa-vmstat.node1.numa_local
     94034            +2.5%      96378        proc-vmstat.nr_active_anon
     91054            -1.1%      90051        proc-vmstat.nr_anon_pages
      1671 ± 10%     -10.1%       1502 ±  7%  proc-vmstat.nr_dirty
    284824            +1.5%     288962        proc-vmstat.nr_file_pages
      4523            +8.1%       4888        proc-vmstat.nr_inactive_anon
      1920 ±  8%     +22.9%       2360 ±  2%  proc-vmstat.nr_inactive_file
     56868            -3.6%      54815        proc-vmstat.nr_kernel_stack
      7478            +3.3%       7723        proc-vmstat.nr_mapped
      7555 ±  2%     +49.2%      11273 ±  2%  proc-vmstat.nr_shmem
     25538           +28.0%      32690        proc-vmstat.nr_slab_reclaimable
     58047            +6.1%      61588        proc-vmstat.nr_slab_unreclaimable
      6231 ± 35%    +221.3%      20018 ± 12%  proc-vmstat.nr_written
     94034            +2.5%      96378        proc-vmstat.nr_zone_active_anon
      4523            +8.1%       4888        proc-vmstat.nr_zone_inactive_anon
      1920 ±  8%     +22.9%       2360 ±  2%  proc-vmstat.nr_zone_inactive_file
      1514 ±  4%     -18.6%       1232        proc-vmstat.nr_zone_write_pending
      7133 ±  6%     +27.4%       9085 ±  4%  proc-vmstat.pgactivate
    290989 ±  7%     +16.4%     338831        proc-vmstat.pgfault
    132844 ±  5%    +257.2%     474470 ±  4%  proc-vmstat.pgpgout
      1729 ±  2%     +31.3%       2270        slabinfo.blkdev_ioc.active_objs
      1729 ±  2%     +31.3%       2270        slabinfo.blkdev_ioc.num_objs
      2232           +14.6%       2557        slabinfo.ip6-frags.active_objs
      2232           +14.6%       2557        slabinfo.ip6-frags.num_objs
      3747           +12.9%       4229        slabinfo.kmalloc-128.active_objs
      3747           +12.9%       4229        slabinfo.kmalloc-128.num_objs
     27818          +221.1%      89333 ±  3%  slabinfo.kmalloc-16.active_objs
    108.67          +226.4%     354.67 ±  3%  slabinfo.kmalloc-16.active_slabs
     27818          +226.6%      90860 ±  3%  slabinfo.kmalloc-16.num_objs
    108.67          +226.4%     354.67 ±  3%  slabinfo.kmalloc-16.num_slabs
      1210           +22.5%       1481        slabinfo.kmalloc-4k.active_objs
      1223           +22.3%       1495        slabinfo.kmalloc-4k.num_objs
     10797          +155.1%      27539 ±  2%  slabinfo.kmalloc-512.active_objs
    346.67          +186.7%     994.00 ±  2%  slabinfo.kmalloc-512.active_slabs
     11112          +186.4%      31820 ±  2%  slabinfo.kmalloc-512.num_objs
    346.67          +186.7%     994.00 ±  2%  slabinfo.kmalloc-512.num_slabs
      1376           +18.2%       1627        slabinfo.kmalloc-8k.active_objs
      1387           +20.9%       1677        slabinfo.kmalloc-8k.num_objs
      1781 ±  4%     +11.7%       1989 ±  4%  slabinfo.skbuff_ext_cache.active_objs
      1781 ±  4%     +11.7%       1989 ±  4%  slabinfo.skbuff_ext_cache.num_objs
      1104 ±  6%     -22.7%     853.33 ± 16%  slabinfo.task_group.active_objs
      1104 ±  6%     -22.7%     853.33 ± 16%  slabinfo.task_group.num_objs
      1837           +14.0%       2094        slabinfo.xfs_btree_cur.active_objs
      1837           +14.0%       2094        slabinfo.xfs_btree_cur.num_objs
      1969           +25.1%       2465        slabinfo.xfs_buf.active_objs
      1969           +25.1%       2465        slabinfo.xfs_buf.num_objs
      3002           +24.3%       3731 ±  2%  slabinfo.xfs_buf_item.active_objs
      3002           +24.3%       3731 ±  2%  slabinfo.xfs_buf_item.num_objs
      1687           +15.5%       1949        slabinfo.xfs_da_state.active_objs
      1687           +15.5%       1949        slabinfo.xfs_da_state.num_objs
      1635           +44.6%       2364        slabinfo.xfs_efd_item.active_objs
      1635           +44.6%       2364        slabinfo.xfs_efd_item.num_objs
      3235 ±  3%    +550.4%      21040 ±  2%  slabinfo.xfs_ili.active_objs
     84.33 ±  3%    +591.7%     583.33        slabinfo.xfs_ili.active_slabs
      3560 ±  3%    +589.1%      24535        slabinfo.xfs_ili.num_objs
     84.33 ±  3%    +591.7%     583.33        slabinfo.xfs_ili.num_slabs
      2657          +672.6%      20529 ±  2%  slabinfo.xfs_inode.active_objs
     99.67          +650.8%     748.33        slabinfo.xfs_inode.active_slabs
      3200          +648.6%      23958        slabinfo.xfs_inode.num_objs
     99.67          +650.8%     748.33        slabinfo.xfs_inode.num_slabs
     18576 ± 11%     +19.4%      22188 ±  3%  softirqs.CPU0.RCU
     19982 ±  2%     +32.9%      26561 ±  3%  softirqs.CPU0.TIMER
     18554 ±  8%     +20.7%      22387        softirqs.CPU1.RCU
     19159 ±  4%     +37.4%      26330 ±  2%  softirqs.CPU1.TIMER
     18460 ±  9%     +15.0%      21229 ±  2%  softirqs.CPU10.RCU
     18790           +35.2%      25395        softirqs.CPU10.TIMER
     18773 ±  4%     +11.8%      20981 ±  2%  softirqs.CPU11.RCU
     19915 ±  5%     +27.4%      25376 ±  2%  softirqs.CPU11.TIMER
     18147 ±  8%     +15.7%      20989        softirqs.CPU12.RCU
     19348 ±  2%     +31.3%      25399 ±  2%  softirqs.CPU12.TIMER
     17829 ±  8%     +15.8%      20653 ±  2%  softirqs.CPU13.RCU
     18343           +38.6%      25426 ±  2%  softirqs.CPU13.TIMER
     18589 ±  8%     +14.4%      21262 ±  2%  softirqs.CPU14.RCU
     18532 ±  3%     +36.6%      25307 ±  2%  softirqs.CPU14.TIMER
     18837 ±  6%     +19.8%      22560 ±  6%  softirqs.CPU15.RCU
     19443 ±  9%     +31.8%      25631 ±  2%  softirqs.CPU15.TIMER
     18559 ±  6%     +15.9%      21511        softirqs.CPU16.RCU
     18781 ±  3%     +35.5%      25442 ±  2%  softirqs.CPU16.TIMER
     18244 ±  6%     +20.4%      21963 ±  3%  softirqs.CPU17.RCU
     18726           +34.4%      25175 ±  3%  softirqs.CPU17.TIMER
     18709 ±  8%     +18.2%      22112 ±  2%  softirqs.CPU18.RCU
     19522 ±  3%     +34.8%      26319 ±  3%  softirqs.CPU18.TIMER
     19313 ±  9%     +46.2%      28231 ± 15%  softirqs.CPU19.TIMER
     18352 ±  7%     +21.3%      22266 ±  3%  softirqs.CPU2.RCU
     18736 ±  2%     +44.3%      27030 ±  8%  softirqs.CPU2.TIMER
     18642 ±  6%     +32.1%      24621 ±  5%  softirqs.CPU20.TIMER
     23362 ± 15%     +20.7%      28196 ±  6%  softirqs.CPU21.TIMER
     19243 ± 11%     +17.6%      22627 ±  5%  softirqs.CPU22.RCU
     19539 ±  3%     +40.2%      27389 ±  4%  softirqs.CPU22.TIMER
     18538 ± 11%     +17.2%      21724 ±  3%  softirqs.CPU23.RCU
     18386 ±  4%     +39.6%      25667 ±  2%  softirqs.CPU23.TIMER
     18438 ±  4%     +39.5%      25713        softirqs.CPU24.TIMER
     18171 ±  7%     +15.8%      21038 ±  3%  softirqs.CPU25.RCU
     18493 ±  2%     +37.3%      25394 ±  2%  softirqs.CPU25.TIMER
     18385 ±  8%     +16.7%      21461 ±  3%  softirqs.CPU26.RCU
     18820 ±  2%     +39.1%      26186        softirqs.CPU26.TIMER
     18325 ±  2%     +37.2%      25142        softirqs.CPU27.TIMER
     18303 ± 10%     +14.0%      20868 ±  3%  softirqs.CPU28.RCU
     18206 ±  3%     +39.1%      25329 ±  3%  softirqs.CPU28.TIMER
     18763 ±  8%     +10.5%      20736 ±  3%  softirqs.CPU29.RCU
     18586 ±  2%     +34.3%      24958 ±  2%  softirqs.CPU29.TIMER
     18652 ±  6%     +11.8%      20846        softirqs.CPU3.RCU
     19151 ±  5%     +32.0%      25283 ±  2%  softirqs.CPU3.TIMER
     18503 ±  2%     +36.3%      25223        softirqs.CPU30.TIMER
     18767 ±  9%     +14.4%      21477        softirqs.CPU31.RCU
     18942           +35.7%      25697        softirqs.CPU31.TIMER
     18365 ± 10%     +15.2%      21156        softirqs.CPU32.RCU
     18418 ±  3%     +36.8%      25194        softirqs.CPU32.TIMER
     18489 ±  2%     +37.5%      25420        softirqs.CPU34.TIMER
     17988 ±  9%     +21.8%      21911        softirqs.CPU35.RCU
     18160           +42.4%      25855        softirqs.CPU35.TIMER
     18436 ±  9%     +13.4%      20911        softirqs.CPU36.RCU
     17982           +35.6%      24379 ±  3%  softirqs.CPU36.TIMER
     18270 ± 12%     +21.5%      22198        softirqs.CPU37.RCU
     18591 ±  2%     +60.1%      29769 ± 17%  softirqs.CPU37.TIMER
     19088 ± 13%     +20.2%      22952 ±  3%  softirqs.CPU38.RCU
     18745 ±  5%     +38.8%      26022 ±  6%  softirqs.CPU38.TIMER
     18245 ± 11%     +17.5%      21442 ±  3%  softirqs.CPU39.RCU
     18583 ±  2%     +34.9%      25069 ±  3%  softirqs.CPU39.TIMER
     18404 ±  8%     +14.5%      21064        softirqs.CPU4.RCU
     18751 ±  2%     +34.8%      25285 ±  2%  softirqs.CPU4.TIMER
     18364 ±  9%     +18.2%      21706 ±  2%  softirqs.CPU40.RCU
     18521           +36.9%      25353 ±  5%  softirqs.CPU40.TIMER
     18033 ±  9%     +17.5%      21184        softirqs.CPU41.RCU
     18345           +35.6%      24884 ±  3%  softirqs.CPU41.TIMER
     18680 ±  5%     +12.9%      21087        softirqs.CPU42.RCU
     18811 ±  3%     +32.8%      24974 ±  3%  softirqs.CPU42.TIMER
     18482 ±  9%     +15.9%      21427        softirqs.CPU43.RCU
     17937 ±  2%     +39.4%      25007 ±  4%  softirqs.CPU43.TIMER
     18356 ±  6%     +17.9%      21649 ±  3%  softirqs.CPU44.RCU
     18768           +34.0%      25157 ±  4%  softirqs.CPU44.TIMER
     18256 ±  8%     +15.2%      21026 ±  3%  softirqs.CPU45.RCU
     18248           +35.9%      24802 ±  3%  softirqs.CPU45.TIMER
     17971 ± 10%     +18.4%      21280        softirqs.CPU46.RCU
     18335           +35.6%      24865 ±  3%  softirqs.CPU46.TIMER
     17962 ±  8%     +14.4%      20557 ±  2%  softirqs.CPU47.RCU
     18230 ±  2%     +36.5%      24889 ±  2%  softirqs.CPU47.TIMER
     17621 ±  9%     +20.3%      21191 ±  3%  softirqs.CPU48.RCU
     18469           +35.1%      24954 ±  2%  softirqs.CPU48.TIMER
     17893 ±  9%     +20.8%      21620        softirqs.CPU49.RCU
     18258           +44.9%      26457 ±  5%  softirqs.CPU49.TIMER
     18226 ±  8%     +17.1%      21341 ±  2%  softirqs.CPU5.RCU
     19054 ±  5%     +32.1%      25164 ±  2%  softirqs.CPU5.TIMER
     18341 ±  9%     +15.2%      21129 ±  2%  softirqs.CPU50.RCU
     18540 ±  4%     +33.8%      24813 ±  3%  softirqs.CPU50.TIMER
     17898 ± 11%     +21.6%      21765 ±  5%  softirqs.CPU51.RCU
     17940 ±  2%     +43.5%      25743 ±  2%  softirqs.CPU51.TIMER
     18426 ±  3%     +36.8%      25199 ±  3%  softirqs.CPU52.TIMER
     19024 ±  7%     +35.4%      25760        softirqs.CPU53.TIMER
     18871 ±  2%     +34.3%      25339 ±  2%  softirqs.CPU54.TIMER
     18661 ±  9%     +18.7%      22155 ±  7%  softirqs.CPU55.RCU
     18144           +43.0%      25954 ±  7%  softirqs.CPU55.TIMER
     17744 ±  8%     +20.7%      21418 ±  2%  softirqs.CPU56.RCU
     16517 ±  8%     +50.2%      24801 ±  4%  softirqs.CPU56.TIMER
     18737 ±  8%     +16.9%      21904 ±  5%  softirqs.CPU57.RCU
     18722 ±  5%     +32.8%      24869 ±  6%  softirqs.CPU57.TIMER
     18879 ±  7%     +33.7%      25247        softirqs.CPU58.TIMER
     18047 ± 11%     +20.3%      21719        softirqs.CPU59.RCU
     17831           +41.6%      25255        softirqs.CPU59.TIMER
     17642 ±  9%     +18.4%      20891        softirqs.CPU6.RCU
     18419           +37.4%      25316 ±  3%  softirqs.CPU6.TIMER
     19443 ±  6%     +27.9%      24864        softirqs.CPU60.TIMER
     18129 ±  2%     +37.4%      24910 ±  3%  softirqs.CPU61.TIMER
     17870 ±  8%     +17.2%      20945 ±  3%  softirqs.CPU62.RCU
     17983           +39.8%      25137 ±  2%  softirqs.CPU62.TIMER
     18454 ±  3%     +34.7%      24851 ±  3%  softirqs.CPU63.TIMER
     18627 ±  8%     +11.6%      20789 ±  2%  softirqs.CPU64.RCU
     18557 ±  8%     +12.3%      20831 ±  2%  softirqs.CPU65.RCU
     18139 ±  3%     +56.2%      28335 ± 15%  softirqs.CPU65.TIMER
     17746 ±  9%     +17.6%      20867 ±  3%  softirqs.CPU66.RCU
     17823 ±  2%     +39.5%      24872 ±  2%  softirqs.CPU66.TIMER
     18511 ±  5%     +13.2%      20957        softirqs.CPU67.RCU
     18338 ±  5%     +35.7%      24885 ±  2%  softirqs.CPU67.TIMER
     18296 ±  5%     +16.8%      21376 ±  2%  softirqs.CPU68.RCU
     18003 ±  4%     +39.8%      25166 ±  3%  softirqs.CPU68.TIMER
     17867 ± 11%     +20.8%      21586 ±  4%  softirqs.CPU69.RCU
     17333           +45.9%      25281 ±  4%  softirqs.CPU69.TIMER
     18222 ±  9%     +17.2%      21358        softirqs.CPU7.RCU
     17754 ± 10%     +19.6%      21232 ±  3%  softirqs.CPU70.RCU
     17639           +41.4%      24938 ±  2%  softirqs.CPU70.TIMER
     17966 ±  9%     +17.2%      21053        softirqs.CPU71.RCU
     17626 ±  2%     +40.0%      24682 ±  2%  softirqs.CPU71.TIMER
     18881 ±  2%     +32.6%      25040 ±  2%  softirqs.CPU9.TIMER
   1337363 ±  9%     +15.6%    1545379 ±  2%  softirqs.RCU
   1351267           +36.4%    1842778        softirqs.TIMER
     74781 ±  4%     +56.8%     117224        interrupts.CPU0.LOC:Local_timer_interrupts
      3055 ±  7%     +34.1%       4096 ±  5%  interrupts.CPU0.NMI:Non-maskable_interrupts
      3055 ±  7%     +34.1%       4096 ±  5%  interrupts.CPU0.PMI:Performance_monitoring_interrupts
     74841 ±  4%     +56.6%     117205        interrupts.CPU1.LOC:Local_timer_interrupts
      3048 ±  5%     +35.7%       4135 ±  5%  interrupts.CPU1.NMI:Non-maskable_interrupts
      3048 ±  5%     +35.7%       4135 ±  5%  interrupts.CPU1.PMI:Performance_monitoring_interrupts
     74836 ±  4%     +56.6%     117168        interrupts.CPU10.LOC:Local_timer_interrupts
      2920 ±  6%     +47.2%       4298 ± 10%  interrupts.CPU10.NMI:Non-maskable_interrupts
      2920 ±  6%     +47.2%       4298 ± 10%  interrupts.CPU10.PMI:Performance_monitoring_interrupts
    120.33 ± 12%    +154.3%     306.00 ± 52%  interrupts.CPU10.RES:Rescheduling_interrupts
     74779 ±  4%     +56.8%     117235        interrupts.CPU11.LOC:Local_timer_interrupts
      3126 ± 12%     +32.5%       4143 ±  5%  interrupts.CPU11.NMI:Non-maskable_interrupts
      3126 ± 12%     +32.5%       4143 ±  5%  interrupts.CPU11.PMI:Performance_monitoring_interrupts
    128.00 ± 15%     +38.0%     176.67 ±  7%  interrupts.CPU11.RES:Rescheduling_interrupts
     74772 ±  4%     +56.8%     117208        interrupts.CPU12.LOC:Local_timer_interrupts
    119.33 ± 13%     +49.7%     178.67 ±  5%  interrupts.CPU12.RES:Rescheduling_interrupts
     74603 ±  5%     +57.1%     117210        interrupts.CPU13.LOC:Local_timer_interrupts
      3167 ±  8%     +27.8%       4046 ±  5%  interrupts.CPU13.NMI:Non-maskable_interrupts
      3167 ±  8%     +27.8%       4046 ±  5%  interrupts.CPU13.PMI:Performance_monitoring_interrupts
    103.00 ±  4%     +68.3%     173.33 ±  6%  interrupts.CPU13.RES:Rescheduling_interrupts
     74832 ±  4%     +56.7%     117238        interrupts.CPU14.LOC:Local_timer_interrupts
      3106 ±  9%     +31.2%       4074 ±  6%  interrupts.CPU14.NMI:Non-maskable_interrupts
      3106 ±  9%     +31.2%       4074 ±  6%  interrupts.CPU14.PMI:Performance_monitoring_interrupts
    106.67           +96.6%     209.67 ± 21%  interrupts.CPU14.RES:Rescheduling_interrupts
      1392 ±139%     -99.8%       3.33 ± 56%  interrupts.CPU14.TLB:TLB_shootdowns
     74815 ±  4%     +56.6%     117131        interrupts.CPU15.LOC:Local_timer_interrupts
      2967 ±  5%     +36.3%       4042 ±  6%  interrupts.CPU15.NMI:Non-maskable_interrupts
      2967 ±  5%     +36.3%       4042 ±  6%  interrupts.CPU15.PMI:Performance_monitoring_interrupts
     74720 ±  4%     +56.6%     117025        interrupts.CPU16.LOC:Local_timer_interrupts
      3191 ±  2%     +28.4%       4097 ±  5%  interrupts.CPU16.NMI:Non-maskable_interrupts
      3191 ±  2%     +28.4%       4097 ±  5%  interrupts.CPU16.PMI:Performance_monitoring_interrupts
    136.00 ±  8%     +34.6%     183.00 ± 10%  interrupts.CPU16.RES:Rescheduling_interrupts
     74797 ±  4%     +56.7%     117202        interrupts.CPU17.LOC:Local_timer_interrupts
      2964 ±  6%     +39.1%       4123 ±  5%  interrupts.CPU17.NMI:Non-maskable_interrupts
      2964 ±  6%     +39.1%       4123 ±  5%  interrupts.CPU17.PMI:Performance_monitoring_interrupts
    109.00 ± 26%     +56.9%     171.00 ± 11%  interrupts.CPU17.RES:Rescheduling_interrupts
     74796 ±  5%     +56.7%     117236        interrupts.CPU18.LOC:Local_timer_interrupts
      2440 ± 23%     +69.3%       4132 ±  4%  interrupts.CPU18.NMI:Non-maskable_interrupts
      2440 ± 23%     +69.3%       4132 ±  4%  interrupts.CPU18.PMI:Performance_monitoring_interrupts
    135.33 ± 19%     +34.7%     182.33 ± 14%  interrupts.CPU18.RES:Rescheduling_interrupts
     74597 ±  5%     +57.2%     117242        interrupts.CPU19.LOC:Local_timer_interrupts
      3213 ± 10%     +27.9%       4108 ±  5%  interrupts.CPU19.NMI:Non-maskable_interrupts
      3213 ± 10%     +27.9%       4108 ±  5%  interrupts.CPU19.PMI:Performance_monitoring_interrupts
    130.00 ± 13%     +26.4%     164.33 ± 12%  interrupts.CPU19.RES:Rescheduling_interrupts
     74791 ±  4%     +56.7%     117235        interrupts.CPU2.LOC:Local_timer_interrupts
    119.67 ± 14%    +541.2%     767.33 ± 79%  interrupts.CPU2.RES:Rescheduling_interrupts
     74648 ±  5%     +57.1%     117244        interrupts.CPU20.LOC:Local_timer_interrupts
      3221 ±  6%     +28.0%       4122 ±  5%  interrupts.CPU20.NMI:Non-maskable_interrupts
      3221 ±  6%     +28.0%       4122 ±  5%  interrupts.CPU20.PMI:Performance_monitoring_interrupts
    102.00 ±  5%     +81.4%     185.00 ±  6%  interrupts.CPU20.RES:Rescheduling_interrupts
     74596 ±  5%     +57.2%     117280        interrupts.CPU21.LOC:Local_timer_interrupts
      3207 ±  5%     +29.5%       4154 ±  5%  interrupts.CPU21.NMI:Non-maskable_interrupts
      3207 ±  5%     +29.5%       4154 ±  5%  interrupts.CPU21.PMI:Performance_monitoring_interrupts
    111.00 ± 11%     +65.2%     183.33 ± 13%  interrupts.CPU21.RES:Rescheduling_interrupts
     74663 ±  5%     +57.1%     117277        interrupts.CPU22.LOC:Local_timer_interrupts
      3309 ±  6%     +27.7%       4225 ±  5%  interrupts.CPU22.NMI:Non-maskable_interrupts
      3309 ±  6%     +27.7%       4225 ±  5%  interrupts.CPU22.PMI:Performance_monitoring_interrupts
     74656 ±  5%     +57.1%     117250        interrupts.CPU23.LOC:Local_timer_interrupts
      3138 ±  6%     +31.1%       4116 ±  4%  interrupts.CPU23.NMI:Non-maskable_interrupts
      3138 ±  6%     +31.1%       4116 ±  4%  interrupts.CPU23.PMI:Performance_monitoring_interrupts
    107.67 ±  9%     +62.5%     175.00 ± 13%  interrupts.CPU23.RES:Rescheduling_interrupts
     74646 ±  5%     +57.1%     117264        interrupts.CPU24.LOC:Local_timer_interrupts
      3034 ±  6%     +37.9%       4185        interrupts.CPU24.NMI:Non-maskable_interrupts
      3034 ±  6%     +37.9%       4185        interrupts.CPU24.PMI:Performance_monitoring_interrupts
     96.67 ± 17%     +78.3%     172.33 ±  7%  interrupts.CPU24.RES:Rescheduling_interrupts
     74655 ±  5%     +57.1%     117252        interrupts.CPU25.LOC:Local_timer_interrupts
    123.33 ± 16%     +45.4%     179.33 ± 10%  interrupts.CPU25.RES:Rescheduling_interrupts
     74851 ±  5%     +56.6%     117248        interrupts.CPU26.LOC:Local_timer_interrupts
      3147 ±  6%     +30.0%       4092 ±  7%  interrupts.CPU26.NMI:Non-maskable_interrupts
      3147 ±  6%     +30.0%       4092 ±  7%  interrupts.CPU26.PMI:Performance_monitoring_interrupts
    118.33 ±  7%     +50.7%     178.33 ±  6%  interrupts.CPU26.RES:Rescheduling_interrupts
     74515 ±  4%     +57.4%     117254        interrupts.CPU27.LOC:Local_timer_interrupts
    100.00 ±  4%     +58.3%     158.33 ±  7%  interrupts.CPU27.RES:Rescheduling_interrupts
     74483 ±  4%     +56.9%     116883        interrupts.CPU28.LOC:Local_timer_interrupts
    112.33 ±  5%     +58.2%     177.67 ±  4%  interrupts.CPU28.RES:Rescheduling_interrupts
     74694 ±  5%     +56.9%     117214        interrupts.CPU29.LOC:Local_timer_interrupts
    106.00 ±  5%     +47.5%     156.33 ±  4%  interrupts.CPU29.RES:Rescheduling_interrupts
     74838 ±  4%     +56.6%     117194        interrupts.CPU3.LOC:Local_timer_interrupts
     74661 ±  5%     +57.0%     117232        interrupts.CPU30.LOC:Local_timer_interrupts
    107.67 ±  7%     +65.9%     178.67 ± 14%  interrupts.CPU30.RES:Rescheduling_interrupts
     74643 ±  5%     +57.1%     117237        interrupts.CPU31.LOC:Local_timer_interrupts
    114.33 ±  5%     +52.8%     174.67 ±  7%  interrupts.CPU31.RES:Rescheduling_interrupts
     74660 ±  5%     +57.1%     117255        interrupts.CPU32.LOC:Local_timer_interrupts
     99.33 ± 19%     +68.5%     167.33 ±  7%  interrupts.CPU32.RES:Rescheduling_interrupts
     74659 ±  5%     +57.1%     117267        interrupts.CPU33.LOC:Local_timer_interrupts
    115.33 ±  5%     +30.9%     151.00 ±  3%  interrupts.CPU33.RES:Rescheduling_interrupts
     74546 ±  4%     +57.3%     117253        interrupts.CPU34.LOC:Local_timer_interrupts
     74637 ±  5%     +57.1%     117246        interrupts.CPU35.LOC:Local_timer_interrupts
      2928 ±  4%     +40.0%       4100 ±  7%  interrupts.CPU35.NMI:Non-maskable_interrupts
      2928 ±  4%     +40.0%       4100 ±  7%  interrupts.CPU35.PMI:Performance_monitoring_interrupts
    110.00 ±  3%     +36.7%     150.33 ± 14%  interrupts.CPU35.RES:Rescheduling_interrupts
     74560 ±  4%     +57.2%     117243        interrupts.CPU36.LOC:Local_timer_interrupts
    104.33 ± 19%     +83.4%     191.33 ± 10%  interrupts.CPU36.RES:Rescheduling_interrupts
     74769 ±  4%     +56.8%     117256        interrupts.CPU37.LOC:Local_timer_interrupts
      3171 ±  4%     +29.8%       4116 ±  6%  interrupts.CPU37.NMI:Non-maskable_interrupts
      3171 ±  4%     +29.8%       4116 ±  6%  interrupts.CPU37.PMI:Performance_monitoring_interrupts
    117.67 ± 20%     +46.5%     172.33 ±  9%  interrupts.CPU37.RES:Rescheduling_interrupts
     74761 ±  4%     +56.8%     117242        interrupts.CPU38.LOC:Local_timer_interrupts
      3064 ±  5%     +32.9%       4071 ±  5%  interrupts.CPU38.NMI:Non-maskable_interrupts
      3064 ±  5%     +32.9%       4071 ±  5%  interrupts.CPU38.PMI:Performance_monitoring_interrupts
    105.33 ±  7%     +57.3%     165.67 ±  4%  interrupts.CPU38.RES:Rescheduling_interrupts
     74783 ±  4%     +56.6%     117133        interrupts.CPU39.LOC:Local_timer_interrupts
      3093 ±  2%     +32.1%       4086 ±  6%  interrupts.CPU39.NMI:Non-maskable_interrupts
      3093 ±  2%     +32.1%       4086 ±  6%  interrupts.CPU39.PMI:Performance_monitoring_interrupts
     96.00 ± 10%     +63.2%     156.67 ±  2%  interrupts.CPU39.RES:Rescheduling_interrupts
     74834 ±  4%     +56.6%     117198        interrupts.CPU4.LOC:Local_timer_interrupts
      3063 ±  5%     +33.0%       4074 ±  5%  interrupts.CPU4.NMI:Non-maskable_interrupts
      3063 ±  5%     +33.0%       4074 ±  5%  interrupts.CPU4.PMI:Performance_monitoring_interrupts
    109.00 ± 12%    +374.9%     517.67 ± 91%  interrupts.CPU4.RES:Rescheduling_interrupts
     74794 ±  4%     +56.7%     117210        interrupts.CPU40.LOC:Local_timer_interrupts
      3031 ±  2%     +36.5%       4136 ±  5%  interrupts.CPU40.NMI:Non-maskable_interrupts
      3031 ±  2%     +36.5%       4136 ±  5%  interrupts.CPU40.PMI:Performance_monitoring_interrupts
    100.33 ±  9%     +86.0%     186.67 ±  6%  interrupts.CPU40.RES:Rescheduling_interrupts
     74775 ±  4%     +56.6%     117093        interrupts.CPU41.LOC:Local_timer_interrupts
      3110 ±  6%     +33.3%       4147 ±  6%  interrupts.CPU41.NMI:Non-maskable_interrupts
      3110 ±  6%     +33.3%       4147 ±  6%  interrupts.CPU41.PMI:Performance_monitoring_interrupts
    102.00 ±  7%     +75.2%     178.67 ± 12%  interrupts.CPU41.RES:Rescheduling_interrupts
     74807 ±  4%     +56.7%     117211        interrupts.CPU42.LOC:Local_timer_interrupts
      3187           +30.2%       4150 ±  5%  interrupts.CPU42.NMI:Non-maskable_interrupts
      3187           +30.2%       4150 ±  5%  interrupts.CPU42.PMI:Performance_monitoring_interrupts
    100.00 ± 13%     +75.7%     175.67 ± 14%  interrupts.CPU42.RES:Rescheduling_interrupts
     74794 ±  4%     +56.8%     117244        interrupts.CPU43.LOC:Local_timer_interrupts
     98.67 ± 12%     +87.5%     185.00 ± 11%  interrupts.CPU43.RES:Rescheduling_interrupts
     74795 ±  4%     +56.7%     117236        interrupts.CPU44.LOC:Local_timer_interrupts
      3042 ±  4%     +35.8%       4130 ±  5%  interrupts.CPU44.NMI:Non-maskable_interrupts
      3042 ±  4%     +35.8%       4130 ±  5%  interrupts.CPU44.PMI:Performance_monitoring_interrupts
     99.00 ± 11%     +59.6%     158.00 ±  3%  interrupts.CPU44.RES:Rescheduling_interrupts
     74827 ±  4%     +56.7%     117248        interrupts.CPU45.LOC:Local_timer_interrupts
      3161 ±  3%     +31.8%       4167 ±  3%  interrupts.CPU45.NMI:Non-maskable_interrupts
      3161 ±  3%     +31.8%       4167 ±  3%  interrupts.CPU45.PMI:Performance_monitoring_interrupts
     90.00 ±  5%    +111.5%     190.33        interrupts.CPU45.RES:Rescheduling_interrupts
     74794 ±  4%     +56.8%     117242        interrupts.CPU46.LOC:Local_timer_interrupts
      3004 ±  6%     +40.6%       4226 ±  8%  interrupts.CPU46.NMI:Non-maskable_interrupts
      3004 ±  6%     +40.6%       4226 ±  8%  interrupts.CPU46.PMI:Performance_monitoring_interrupts
    112.33 ±  9%     +50.4%     169.00 ±  6%  interrupts.CPU46.RES:Rescheduling_interrupts
     74808 ±  4%     +56.7%     117230        interrupts.CPU47.LOC:Local_timer_interrupts
      3294 ± 10%     +28.1%       4219 ±  6%  interrupts.CPU47.NMI:Non-maskable_interrupts
      3294 ± 10%     +28.1%       4219 ±  6%  interrupts.CPU47.PMI:Performance_monitoring_interrupts
    107.67 ± 12%     +74.0%     187.33 ± 11%  interrupts.CPU47.RES:Rescheduling_interrupts
     74807 ±  4%     +56.7%     117236        interrupts.CPU48.LOC:Local_timer_interrupts
      3141 ± 12%     +30.8%       4108 ±  4%  interrupts.CPU48.NMI:Non-maskable_interrupts
      3141 ± 12%     +30.8%       4108 ±  4%  interrupts.CPU48.PMI:Performance_monitoring_interrupts
     88.67 ±  8%     +81.2%     160.67 ±  9%  interrupts.CPU48.RES:Rescheduling_interrupts
     74738 ±  4%     +56.8%     117164        interrupts.CPU49.LOC:Local_timer_interrupts
      2649 ± 33%     +55.7%       4126 ±  5%  interrupts.CPU49.NMI:Non-maskable_interrupts
      2649 ± 33%     +55.7%       4126 ±  5%  interrupts.CPU49.PMI:Performance_monitoring_interrupts
    106.00 ±  9%     +53.1%     162.33 ±  2%  interrupts.CPU49.RES:Rescheduling_interrupts
     74811 ±  4%     +56.7%     117229        interrupts.CPU5.LOC:Local_timer_interrupts
      3057 ±  6%     +33.7%       4087 ±  5%  interrupts.CPU5.NMI:Non-maskable_interrupts
      3057 ±  6%     +33.7%       4087 ±  5%  interrupts.CPU5.PMI:Performance_monitoring_interrupts
     74776 ±  4%     +56.8%     117223        interrupts.CPU50.LOC:Local_timer_interrupts
      2609 ± 31%     +54.8%       4040 ±  5%  interrupts.CPU50.NMI:Non-maskable_interrupts
      2609 ± 31%     +54.8%       4040 ±  5%  interrupts.CPU50.PMI:Performance_monitoring_interrupts
     95.00 ± 12%     +69.5%     161.00 ± 13%  interrupts.CPU50.RES:Rescheduling_interrupts
     74791 ±  4%     +56.7%     117230        interrupts.CPU51.LOC:Local_timer_interrupts
      2445 ± 29%     +64.7%       4028 ±  4%  interrupts.CPU51.NMI:Non-maskable_interrupts
      2445 ± 29%     +64.7%       4028 ±  4%  interrupts.CPU51.PMI:Performance_monitoring_interrupts
     95.33 ±  4%     +64.0%     156.33 ±  8%  interrupts.CPU51.RES:Rescheduling_interrupts
     74768 ±  4%     +56.8%     117243        interrupts.CPU52.LOC:Local_timer_interrupts
      3027 ±  7%     +36.1%       4121 ±  5%  interrupts.CPU52.NMI:Non-maskable_interrupts
      3027 ±  7%     +36.1%       4121 ±  5%  interrupts.CPU52.PMI:Performance_monitoring_interrupts
     91.67 ± 12%     +90.2%     174.33 ±  9%  interrupts.CPU52.RES:Rescheduling_interrupts
     74482 ±  4%     +57.1%     117009        interrupts.CPU53.LOC:Local_timer_interrupts
      2511 ± 32%     +63.2%       4100 ±  5%  interrupts.CPU53.NMI:Non-maskable_interrupts
      2511 ± 32%     +63.2%       4100 ±  5%  interrupts.CPU53.PMI:Performance_monitoring_interrupts
    107.33 ± 16%     +51.6%     162.67        interrupts.CPU53.RES:Rescheduling_interrupts
     73.33 ±104%     -88.6%       8.33 ± 29%  interrupts.CPU53.TLB:TLB_shootdowns
     74636 ±  5%     +57.1%     117229        interrupts.CPU54.LOC:Local_timer_interrupts
      2515 ± 31%     +62.8%       4096 ±  4%  interrupts.CPU54.NMI:Non-maskable_interrupts
      2515 ± 31%     +62.8%       4096 ±  4%  interrupts.CPU54.PMI:Performance_monitoring_interrupts
    103.67 ± 12%     +77.2%     183.67 ±  8%  interrupts.CPU54.RES:Rescheduling_interrupts
     74637 ±  5%     +57.3%     117413        interrupts.CPU55.LOC:Local_timer_interrupts
     95.67 ± 11%     +57.8%     151.00 ± 16%  interrupts.CPU55.RES:Rescheduling_interrupts
     74637 ±  5%     +57.1%     117241        interrupts.CPU56.LOC:Local_timer_interrupts
     93.33 ± 10%     +78.9%     167.00 ± 10%  interrupts.CPU56.RES:Rescheduling_interrupts
     74474 ±  5%     +57.2%     117074        interrupts.CPU57.LOC:Local_timer_interrupts
      2938 ±  6%     +39.2%       4091 ±  5%  interrupts.CPU57.NMI:Non-maskable_interrupts
      2938 ±  6%     +39.2%       4091 ±  5%  interrupts.CPU57.PMI:Performance_monitoring_interrupts
    100.67 ±  3%     +76.5%     177.67        interrupts.CPU57.RES:Rescheduling_interrupts
     74631 ±  5%     +57.1%     117209        interrupts.CPU58.LOC:Local_timer_interrupts
    115.00 ± 14%    +156.8%     295.33 ± 50%  interrupts.CPU58.RES:Rescheduling_interrupts
     74639 ±  5%     +57.1%     117222        interrupts.CPU59.LOC:Local_timer_interrupts
    104.00 ± 14%     +76.3%     183.33 ± 12%  interrupts.CPU59.RES:Rescheduling_interrupts
     74818 ±  4%     +56.7%     117230        interrupts.CPU6.LOC:Local_timer_interrupts
      3200           +30.0%       4161 ±  4%  interrupts.CPU6.NMI:Non-maskable_interrupts
      3200           +30.0%       4161 ±  4%  interrupts.CPU6.PMI:Performance_monitoring_interrupts
    169.00 ± 52%    +519.3%       1046 ±103%  interrupts.CPU6.RES:Rescheduling_interrupts
     74628 ±  5%     +57.1%     117229        interrupts.CPU60.LOC:Local_timer_interrupts
     78.67 ± 15%    +261.9%     284.67 ± 63%  interrupts.CPU60.RES:Rescheduling_interrupts
     74611 ±  5%     +57.1%     117226        interrupts.CPU61.LOC:Local_timer_interrupts
     89.00 ± 16%     +94.0%     172.67 ±  5%  interrupts.CPU61.RES:Rescheduling_interrupts
     74643 ±  5%     +57.0%     117211        interrupts.CPU62.LOC:Local_timer_interrupts
     87.67 ±  4%     +83.7%     161.00 ±  8%  interrupts.CPU62.RES:Rescheduling_interrupts
     74640 ±  5%     +57.1%     117245        interrupts.CPU63.LOC:Local_timer_interrupts
     80.33 ±  6%    +123.2%     179.33 ±  5%  interrupts.CPU63.RES:Rescheduling_interrupts
     74661 ±  5%     +57.0%     117227        interrupts.CPU64.LOC:Local_timer_interrupts
     90.33 ±  8%     +86.0%     168.00 ±  5%  interrupts.CPU64.RES:Rescheduling_interrupts
     74639 ±  5%     +57.3%     117395        interrupts.CPU65.LOC:Local_timer_interrupts
     99.33 ± 15%     +94.6%     193.33 ± 30%  interrupts.CPU65.RES:Rescheduling_interrupts
     74611 ±  5%     +57.1%     117206        interrupts.CPU66.LOC:Local_timer_interrupts
     90.33 ±  9%    +108.1%     188.00 ±  6%  interrupts.CPU66.RES:Rescheduling_interrupts
     74631 ±  5%     +57.2%     117290        interrupts.CPU67.LOC:Local_timer_interrupts
      1995 ± 34%    +105.0%       4090 ±  5%  interrupts.CPU67.NMI:Non-maskable_interrupts
      1995 ± 34%    +105.0%       4090 ±  5%  interrupts.CPU67.PMI:Performance_monitoring_interrupts
     96.33 ±  3%     +70.9%     164.67 ±  8%  interrupts.CPU67.RES:Rescheduling_interrupts
     74849 ±  4%     +56.8%     117345        interrupts.CPU68.LOC:Local_timer_interrupts
      2031 ± 32%    +101.7%       4098 ±  4%  interrupts.CPU68.NMI:Non-maskable_interrupts
      2031 ± 32%    +101.7%       4098 ±  4%  interrupts.CPU68.PMI:Performance_monitoring_interrupts
     97.33 ± 18%     +79.8%     175.00 ± 16%  interrupts.CPU68.RES:Rescheduling_interrupts
     74599 ±  5%     +57.2%     117251        interrupts.CPU69.LOC:Local_timer_interrupts
      2038 ± 33%     +99.0%       4056 ±  5%  interrupts.CPU69.NMI:Non-maskable_interrupts
      2038 ± 33%     +99.0%       4056 ±  5%  interrupts.CPU69.PMI:Performance_monitoring_interrupts
     87.00 ± 18%    +134.9%     204.33 ±  2%  interrupts.CPU69.RES:Rescheduling_interrupts
     74784 ±  4%     +56.8%     117225        interrupts.CPU7.LOC:Local_timer_interrupts
      3044 ±  5%     +35.8%       4133 ±  4%  interrupts.CPU7.NMI:Non-maskable_interrupts
      3044 ±  5%     +35.8%       4133 ±  4%  interrupts.CPU7.PMI:Performance_monitoring_interrupts
    103.67 ±  5%     +55.0%     160.67 ±  8%  interrupts.CPU7.RES:Rescheduling_interrupts
     74603 ±  5%     +57.1%     117233        interrupts.CPU70.LOC:Local_timer_interrupts
      2560 ± 36%     +58.1%       4048 ±  3%  interrupts.CPU70.NMI:Non-maskable_interrupts
      2560 ± 36%     +58.1%       4048 ±  3%  interrupts.CPU70.PMI:Performance_monitoring_interrupts
     90.67 ± 19%     +80.9%     164.00        interrupts.CPU70.RES:Rescheduling_interrupts
     74688 ±  5%     +57.0%     117281        interrupts.CPU71.LOC:Local_timer_interrupts
      2005 ± 34%    +101.0%       4030 ±  5%  interrupts.CPU71.NMI:Non-maskable_interrupts
      2005 ± 34%    +101.0%       4030 ±  5%  interrupts.CPU71.PMI:Performance_monitoring_interrupts
     93.33 ± 18%     +99.3%     186.00        interrupts.CPU71.RES:Rescheduling_interrupts
     74829 ±  4%     +56.6%     117177        interrupts.CPU8.LOC:Local_timer_interrupts
      3229 ±  9%     +25.6%       4057 ±  4%  interrupts.CPU8.NMI:Non-maskable_interrupts
      3229 ±  9%     +25.6%       4057 ±  4%  interrupts.CPU8.PMI:Performance_monitoring_interrupts
    136.33 ± 33%     +36.9%     186.67 ± 11%  interrupts.CPU8.RES:Rescheduling_interrupts
     74828 ±  4%     +56.7%     117227        interrupts.CPU9.LOC:Local_timer_interrupts
      3081 ±  5%     +33.7%       4120 ±  6%  interrupts.CPU9.NMI:Non-maskable_interrupts
      3081 ±  5%     +33.7%       4120 ±  6%  interrupts.CPU9.PMI:Performance_monitoring_interrupts
    106.00 ± 17%    +101.6%     213.67 ± 20%  interrupts.CPU9.RES:Rescheduling_interrupts
   5379025 ±  4%     +56.9%    8439938        interrupts.LOC:Local_timer_interrupts
    211613 ±  7%     +31.5%     278168 ±  5%  interrupts.NMI:Non-maskable_interrupts
    211613 ±  7%     +31.5%     278168 ±  5%  interrupts.PMI:Performance_monitoring_interrupts
     11773           +44.7%      17040 ±  2%  interrupts.RES:Rescheduling_interrupts
      3281 ± 62%     -86.7%     436.67 ± 34%  interrupts.TLB:TLB_shootdowns
     55.62 ±  5%     -29.6       26.03        perf-profile.calltrace.cycles-pp.write
     33.31 ± 10%     -26.1        7.20 ±  6%  perf-profile.calltrace.cycles-pp.secondary_startup_64
     32.80 ± 10%     -25.7        7.08 ±  6%  perf-profile.calltrace.cycles-pp.start_secondary.secondary_startup_64
     32.80 ± 10%     -25.7        7.08 ±  6%  perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.secondary_startup_64
     32.79 ± 10%     -25.7        7.08 ±  6%  perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64
     32.29 ± 11%     -25.4        6.88 ±  6%  perf-profile.calltrace.cycles-pp.cpuidle_enter.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64
     32.24 ± 11%     -25.4        6.85 ±  6%  perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry.start_secondary
     31.48 ± 11%     -25.0        6.44 ±  7%  perf-profile.calltrace.cycles-pp.intel_idle.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry
     46.23 ±  5%     -24.0       22.25        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.write
     45.90 ±  5%     -23.8       22.12        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     38.94 ±  5%     -20.1       18.82        perf-profile.calltrace.cycles-pp.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     37.76 ±  5%     -19.5       18.30        perf-profile.calltrace.cycles-pp.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     34.21 ±  5%     -17.5       16.67        perf-profile.calltrace.cycles-pp.new_sync_write.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
     32.68 ±  5%     -16.7       15.99        perf-profile.calltrace.cycles-pp.xfs_file_buffered_aio_write.new_sync_write.vfs_write.ksys_write.do_syscall_64
     28.25 ±  6%     -14.8       13.48 ±  2%  perf-profile.calltrace.cycles-pp.iomap_file_buffered_write.xfs_file_buffered_aio_write.new_sync_write.vfs_write.ksys_write
     28.04 ±  6%     -14.7       13.39 ±  2%  perf-profile.calltrace.cycles-pp.iomap_apply.iomap_file_buffered_write.xfs_file_buffered_aio_write.new_sync_write.vfs_write
     21.53 ±  6%     -11.0       10.51 ±  2%  perf-profile.calltrace.cycles-pp.iomap_write_actor.iomap_apply.iomap_file_buffered_write.xfs_file_buffered_aio_write.new_sync_write
     11.06 ±  6%      -5.4        5.65 ±  2%  perf-profile.calltrace.cycles-pp.iomap_write_begin.iomap_write_actor.iomap_apply.iomap_file_buffered_write.xfs_file_buffered_aio_write
      6.47 ±  6%      -3.3        3.15 ±  3%  perf-profile.calltrace.cycles-pp.grab_cache_page_write_begin.iomap_write_begin.iomap_write_actor.iomap_apply.iomap_file_buffered_write
      4.94 ±  5%      -3.2        1.75 ±  3%  perf-profile.calltrace.cycles-pp.close
      6.23 ±  6%      -3.2        3.05 ±  2%  perf-profile.calltrace.cycles-pp.pagecache_get_page.grab_cache_page_write_begin.iomap_write_begin.iomap_write_actor.iomap_apply
      5.11 ±  5%      -3.2        1.93        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64.write
      4.86 ±  5%      -3.1        1.72 ±  3%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.close
      4.86 ±  5%      -3.1        1.72 ±  3%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.close
      4.83 ±  5%      -3.1        1.71 ±  3%  perf-profile.calltrace.cycles-pp.exit_to_usermode_loop.do_syscall_64.entry_SYSCALL_64_after_hwframe.close
      4.82 ±  5%      -3.1        1.70 ±  3%  perf-profile.calltrace.cycles-pp.__fput.task_work_run.exit_to_usermode_loop.do_syscall_64.entry_SYSCALL_64_after_hwframe
      4.83 ±  5%      -3.1        1.71 ±  3%  perf-profile.calltrace.cycles-pp.task_work_run.exit_to_usermode_loop.do_syscall_64.entry_SYSCALL_64_after_hwframe.close
      4.80 ±  5%      -3.1        1.70 ±  3%  perf-profile.calltrace.cycles-pp.dput.__fput.task_work_run.exit_to_usermode_loop.do_syscall_64
      4.78 ±  4%      -3.1        1.69 ±  3%  perf-profile.calltrace.cycles-pp.__dentry_kill.dput.__fput.task_work_run.exit_to_usermode_loop
      5.18 ±  6%      -2.8        2.37 ±  2%  perf-profile.calltrace.cycles-pp.iomap_write_end.iomap_write_actor.iomap_apply.iomap_file_buffered_write.xfs_file_buffered_aio_write
      4.14 ±  5%      -2.3        1.88 ±  3%  perf-profile.calltrace.cycles-pp.xfs_buffered_write_iomap_begin.iomap_apply.iomap_file_buffered_write.xfs_file_buffered_aio_write.new_sync_write
      3.90 ±  5%      -2.2        1.68 ±  2%  perf-profile.calltrace.cycles-pp.syscall_return_via_sysret.write
      3.61 ±  4%      -1.9        1.66 ±  3%  perf-profile.calltrace.cycles-pp.evict.__dentry_kill.dput.__fput.task_work_run
      3.58 ±  4%      -1.9        1.65 ±  3%  perf-profile.calltrace.cycles-pp.truncate_inode_pages_range.evict.__dentry_kill.dput.__fput
      3.22 ±  6%      -1.8        1.41 ±  2%  perf-profile.calltrace.cycles-pp.iomap_set_range_uptodate.iomap_write_begin.iomap_write_actor.iomap_apply.iomap_file_buffered_write
      2.63 ±  2%      -1.4        1.19 ±  4%  perf-profile.calltrace.cycles-pp.xfs_file_aio_write_checks.xfs_file_buffered_aio_write.new_sync_write.vfs_write.ksys_write
      2.83 ±  6%      -1.3        1.53        perf-profile.calltrace.cycles-pp.add_to_page_cache_lru.pagecache_get_page.grab_cache_page_write_begin.iomap_write_begin.iomap_write_actor
      2.23 ±  4%      -1.2        1.03 ±  4%  perf-profile.calltrace.cycles-pp.iomap_set_page_dirty.iomap_write_end.iomap_write_actor.iomap_apply.iomap_file_buffered_write
      2.23 ±  5%      -1.1        1.10        perf-profile.calltrace.cycles-pp.iov_iter_copy_from_user_atomic.iomap_write_actor.iomap_apply.iomap_file_buffered_write.xfs_file_buffered_aio_write
      2.11 ±  7%      -1.1        0.98        perf-profile.calltrace.cycles-pp.iomap_set_range_uptodate.iomap_write_end.iomap_write_actor.iomap_apply.iomap_file_buffered_write
      1.79 ±  4%      -0.9        0.90        perf-profile.calltrace.cycles-pp.copyin.iov_iter_copy_from_user_atomic.iomap_write_actor.iomap_apply.iomap_file_buffered_write
      1.62 ±  5%      -0.8        0.83        perf-profile.calltrace.cycles-pp.copy_user_enhanced_fast_string.copyin.iov_iter_copy_from_user_atomic.iomap_write_actor.iomap_apply
      1.37 ±  7%      -0.8        0.60 ±  4%  perf-profile.calltrace.cycles-pp.find_get_entry.pagecache_get_page.grab_cache_page_write_begin.iomap_write_begin.iomap_write_actor
      1.35 ±  6%      -0.7        0.61 ±  2%  perf-profile.calltrace.cycles-pp.security_file_permission.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.33 ±  6%      -0.7        0.60 ±  2%  perf-profile.calltrace.cycles-pp.__lru_cache_add.add_to_page_cache_lru.pagecache_get_page.grab_cache_page_write_begin.iomap_write_begin
      1.22 ±  7%      -0.7        0.54 ±  3%  perf-profile.calltrace.cycles-pp.pagevec_lru_move_fn.__lru_cache_add.add_to_page_cache_lru.pagecache_get_page.grab_cache_page_write_begin
      1.19 ±  4%      -0.6        0.56 ±  2%  perf-profile.calltrace.cycles-pp.__pagevec_release.truncate_inode_pages_range.evict.__dentry_kill.dput
      1.16 ±  8%      -0.6        0.54 ±  4%  perf-profile.calltrace.cycles-pp.__alloc_pages_nodemask.pagecache_get_page.grab_cache_page_write_begin.iomap_write_begin.iomap_write_actor
      1.18 ±  4%      -0.6        0.57 ±  6%  perf-profile.calltrace.cycles-pp.__set_page_dirty.iomap_set_page_dirty.iomap_write_end.iomap_write_actor.iomap_apply
      1.15 ±  4%      -0.6        0.54 ±  2%  perf-profile.calltrace.cycles-pp.release_pages.__pagevec_release.truncate_inode_pages_range.evict.__dentry_kill
      1.43 ±  5%      -0.5        0.90        perf-profile.calltrace.cycles-pp.__add_to_page_cache_locked.add_to_page_cache_lru.pagecache_get_page.grab_cache_page_write_begin.iomap_write_begin
      0.80            -0.5        0.34 ± 70%  perf-profile.calltrace.cycles-pp.vfs_unlink.do_unlinkat.do_syscall_64.entry_SYSCALL_64_after_hwframe.unlink
      1.11 ±  2%      -0.2        0.92        perf-profile.calltrace.cycles-pp.xfs_generic_create.path_openat.do_filp_open.do_sys_openat2.do_sys_open
      1.10            -0.2        0.91        perf-profile.calltrace.cycles-pp.xfs_create.xfs_generic_create.path_openat.do_filp_open.do_sys_openat2
      0.85 ±  4%      -0.1        0.74        perf-profile.calltrace.cycles-pp.rwsem_spin_on_owner.rwsem_optimistic_spin.rwsem_down_write_slowpath.do_unlinkat.do_syscall_64
      0.75 ±  5%      -0.1        0.67        perf-profile.calltrace.cycles-pp.rwsem_spin_on_owner.rwsem_optimistic_spin.rwsem_down_write_slowpath.path_openat.do_filp_open
      0.17 ±141%      +0.4        0.55 ±  2%  perf-profile.calltrace.cycles-pp.xfs_dir_ialloc.xfs_create.xfs_generic_create.path_openat.do_filp_open
      0.17 ±141%      +0.4        0.55 ±  2%  perf-profile.calltrace.cycles-pp.xfs_ialloc.xfs_dir_ialloc.xfs_create.xfs_generic_create.path_openat
      0.00            +0.5        0.51        perf-profile.calltrace.cycles-pp.xfs_dialloc.xfs_ialloc.xfs_dir_ialloc.xfs_create.xfs_generic_create
      2.75 ±  3%     +29.1       31.89        perf-profile.calltrace.cycles-pp.unlink
      2.72 ±  4%     +29.2       31.87        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.unlink
      2.72 ±  4%     +29.2       31.87        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.unlink
      2.70 ±  4%     +29.2       31.85        perf-profile.calltrace.cycles-pp.do_unlinkat.do_syscall_64.entry_SYSCALL_64_after_hwframe.unlink
      2.77 ±  5%     +29.5       32.23        perf-profile.calltrace.cycles-pp.creat
      2.74 ±  5%     +29.5       32.21        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.creat
      2.74 ±  5%     +29.5       32.21        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.creat
      2.72 ±  6%     +29.5       32.20        perf-profile.calltrace.cycles-pp.do_sys_openat2.do_sys_open.do_syscall_64.entry_SYSCALL_64_after_hwframe.creat
      2.72 ±  6%     +29.5       32.20        perf-profile.calltrace.cycles-pp.do_sys_open.do_syscall_64.entry_SYSCALL_64_after_hwframe.creat
      2.69 ±  5%     +29.5       32.19        perf-profile.calltrace.cycles-pp.do_filp_open.do_sys_openat2.do_sys_open.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.69 ±  5%     +29.5       32.19        perf-profile.calltrace.cycles-pp.path_openat.do_filp_open.do_sys_openat2.do_sys_open.do_syscall_64
      1.75 ±  6%     +29.6       31.31        perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.do_unlinkat.do_syscall_64.entry_SYSCALL_64_after_hwframe.unlink
      1.45 ±  7%     +29.8       31.24        perf-profile.calltrace.cycles-pp.rwsem_optimistic_spin.rwsem_down_write_slowpath.do_unlinkat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.58 ± 11%     +29.9       30.48        perf-profile.calltrace.cycles-pp.osq_lock.rwsem_optimistic_spin.rwsem_down_write_slowpath.do_unlinkat.do_syscall_64
      1.21 ± 11%     +29.9       31.12        perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.path_openat.do_filp_open.do_sys_openat2.do_sys_open
      0.99 ± 14%     +30.1       31.05        perf-profile.calltrace.cycles-pp.rwsem_optimistic_spin.rwsem_down_write_slowpath.path_openat.do_filp_open.do_sys_openat2
      0.00           +30.4       30.37        perf-profile.calltrace.cycles-pp.osq_lock.rwsem_optimistic_spin.rwsem_down_write_slowpath.path_openat.do_filp_open
     55.78 ±  5%     -29.5       26.33        perf-profile.children.cycles-pp.write
     33.31 ± 10%     -26.1        7.20 ±  6%  perf-profile.children.cycles-pp.do_idle
     33.31 ± 10%     -26.1        7.20 ±  6%  perf-profile.children.cycles-pp.secondary_startup_64
     33.31 ± 10%     -26.1        7.20 ±  6%  perf-profile.children.cycles-pp.cpu_startup_entry
     32.79 ± 11%     -25.8        7.00 ±  6%  perf-profile.children.cycles-pp.cpuidle_enter
     32.79 ± 11%     -25.8        7.00 ±  6%  perf-profile.children.cycles-pp.cpuidle_enter_state
     32.80 ± 10%     -25.7        7.08 ±  6%  perf-profile.children.cycles-pp.start_secondary
     31.79 ± 11%     -25.2        6.56 ±  7%  perf-profile.children.cycles-pp.intel_idle
     38.95 ±  5%     -20.1       18.84        perf-profile.children.cycles-pp.ksys_write
     37.79 ±  5%     -19.5       18.33        perf-profile.children.cycles-pp.vfs_write
     34.23 ±  5%     -17.5       16.69        perf-profile.children.cycles-pp.new_sync_write
     32.72 ±  5%     -16.7       16.01        perf-profile.children.cycles-pp.xfs_file_buffered_aio_write
     28.26 ±  6%     -14.8       13.49 ±  2%  perf-profile.children.cycles-pp.iomap_file_buffered_write
     28.07 ±  6%     -14.7       13.41 ±  2%  perf-profile.children.cycles-pp.iomap_apply
     21.64 ±  6%     -11.1       10.56 ±  2%  perf-profile.children.cycles-pp.iomap_write_actor
     11.09 ±  6%      -5.4        5.67 ±  2%  perf-profile.children.cycles-pp.iomap_write_begin
      6.51 ±  6%      -3.3        3.17 ±  3%  perf-profile.children.cycles-pp.grab_cache_page_write_begin
      6.27 ±  6%      -3.2        3.07 ±  2%  perf-profile.children.cycles-pp.pagecache_get_page
      4.94 ±  5%      -3.2        1.75 ±  3%  perf-profile.children.cycles-pp.close
      4.84 ±  5%      -3.1        1.71 ±  3%  perf-profile.children.cycles-pp.exit_to_usermode_loop
      4.82 ±  5%      -3.1        1.71 ±  3%  perf-profile.children.cycles-pp.__fput
      4.82 ±  4%      -3.1        1.70 ±  3%  perf-profile.children.cycles-pp.dput
      4.83 ±  5%      -3.1        1.71 ±  3%  perf-profile.children.cycles-pp.task_work_run
      4.78 ±  4%      -3.1        1.69 ±  3%  perf-profile.children.cycles-pp.__dentry_kill
      5.33 ±  6%      -2.9        2.39        perf-profile.children.cycles-pp.iomap_set_range_uptodate
      5.21 ±  6%      -2.8        2.39 ±  2%  perf-profile.children.cycles-pp.iomap_write_end
      4.61 ±  5%      -2.7        1.95        perf-profile.children.cycles-pp.entry_SYSCALL_64
      4.46 ±  5%      -2.5        1.92        perf-profile.children.cycles-pp.syscall_return_via_sysret
      4.20 ±  5%      -2.3        1.90 ±  3%  perf-profile.children.cycles-pp.xfs_buffered_write_iomap_begin
      3.61 ±  4%      -1.9        1.66 ±  3%  perf-profile.children.cycles-pp.evict
      3.58 ±  4%      -1.9        1.65 ±  3%  perf-profile.children.cycles-pp.truncate_inode_pages_range
      2.69 ±  2%      -1.5        1.21 ±  4%  perf-profile.children.cycles-pp.xfs_file_aio_write_checks
      2.84 ±  6%      -1.3        1.53        perf-profile.children.cycles-pp.add_to_page_cache_lru
      2.26 ±  4%      -1.2        1.04 ±  4%  perf-profile.children.cycles-pp.iomap_set_page_dirty
      2.25 ±  5%      -1.1        1.11        perf-profile.children.cycles-pp.iov_iter_copy_from_user_atomic
      1.78 ±  4%      -1.0        0.79        perf-profile.children.cycles-pp.xfs_ilock
      1.81 ±  4%      -0.9        0.91        perf-profile.children.cycles-pp.copyin
      1.72 ±  4%      -0.8        0.87        perf-profile.children.cycles-pp.copy_user_enhanced_fast_string
      1.52 ±  4%      -0.8        0.68        perf-profile.children.cycles-pp.down_write
      1.40 ±  7%      -0.8        0.61 ±  4%  perf-profile.children.cycles-pp.find_get_entry
      1.37 ±  6%      -0.7        0.62 ±  2%  perf-profile.children.cycles-pp.security_file_permission
      1.33 ±  6%      -0.7        0.60 ±  2%  perf-profile.children.cycles-pp.__lru_cache_add
      1.14 ±  3%      -0.7        0.43 ±  6%  perf-profile.children.cycles-pp.xfs_buffered_write_iomap_end
      1.26 ±  6%      -0.7        0.56 ±  3%  perf-profile.children.cycles-pp.pagevec_lru_move_fn
      1.27 ±  4%      -0.7        0.60 ±  2%  perf-profile.children.cycles-pp.release_pages
      1.13 ±  5%      -0.7        0.48        perf-profile.children.cycles-pp.iov_iter_fault_in_readable
      1.19 ±  4%      -0.6        0.56 ±  2%  perf-profile.children.cycles-pp.__pagevec_release
      1.17 ±  7%      -0.6        0.55 ±  3%  perf-profile.children.cycles-pp.__alloc_pages_nodemask
      1.18 ±  4%      -0.6        0.57 ±  7%  perf-profile.children.cycles-pp.__set_page_dirty
      1.05 ±  6%      -0.6        0.45 ±  5%  perf-profile.children.cycles-pp.common_file_perm
      1.08 ±  6%      -0.6        0.48 ±  4%  perf-profile.children.cycles-pp.xfs_file_write_iter
      1.28 ±  2%      -0.6        0.71 ±  2%  perf-profile.children.cycles-pp.__xfs_trans_commit
      1.46 ±  5%      -0.5        0.91        perf-profile.children.cycles-pp.__add_to_page_cache_locked
      1.24 ±  2%      -0.5        0.69 ±  2%  perf-profile.children.cycles-pp.xfs_log_commit_cil
      1.00 ±  5%      -0.5        0.46 ±  3%  perf-profile.children.cycles-pp.xfs_iunlock
      2.02 ±  3%      -0.5        1.48        perf-profile.children.cycles-pp.rwsem_spin_on_owner
      0.94 ±  5%      -0.5        0.42 ±  5%  perf-profile.children.cycles-pp.truncate_cleanup_page
      0.99 ±  5%      -0.5        0.49 ±  6%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      0.91 ±  7%      -0.5        0.41 ±  2%  perf-profile.children.cycles-pp.get_page_from_freelist
      0.94 ±  4%      -0.5        0.44 ±  3%  perf-profile.children.cycles-pp.delete_from_page_cache_batch
      0.98 ±  3%      -0.5        0.50        perf-profile.children.cycles-pp.___might_sleep
      0.94 ±  3%      -0.5        0.46 ±  8%  perf-profile.children.cycles-pp.file_update_time
      0.84 ±  5%      -0.5        0.37 ±  2%  perf-profile.children.cycles-pp.__pagevec_lru_add_fn
      0.84 ±  8%      -0.5        0.38 ±  9%  perf-profile.children.cycles-pp.__fdget_pos
      0.84 ±  7%      -0.5        0.38 ±  4%  perf-profile.children.cycles-pp.xas_load
      0.81 ±  5%      -0.5        0.36 ±  4%  perf-profile.children.cycles-pp.__cancel_dirty_page
      0.86 ±  3%      -0.4        0.42 ± 11%  perf-profile.children.cycles-pp.account_page_dirtied
      1.43 ±  6%      -0.4        1.00 ±  5%  perf-profile.children.cycles-pp.apic_timer_interrupt
      0.70 ±  4%      -0.4        0.28 ±  2%  perf-profile.children.cycles-pp.xfs_break_layouts
      1.34 ±  6%      -0.4        0.93 ±  6%  perf-profile.children.cycles-pp.smp_apic_timer_interrupt
      0.72 ±  5%      -0.4        0.33 ±  3%  perf-profile.children.cycles-pp.up_write
      0.67 ±  3%      -0.4        0.28 ±  5%  perf-profile.children.cycles-pp.account_page_cleaned
      0.51 ±  8%      -0.4        0.12 ± 13%  perf-profile.children.cycles-pp.start_kernel
      0.69 ±  4%      -0.4        0.32 ±  6%  perf-profile.children.cycles-pp.__mod_lruvec_state
      0.67 ±  8%      -0.4        0.30 ±  9%  perf-profile.children.cycles-pp.__fget_light
      0.75 ±  4%      -0.4        0.38 ±  4%  perf-profile.children.cycles-pp.__sb_start_write
      1.13 ±  7%      -0.4        0.76 ±  5%  perf-profile.children.cycles-pp.xfs_inactive
      0.68            -0.4        0.32 ±  6%  perf-profile.children.cycles-pp._raw_spin_lock
      0.68 ±  6%      -0.4        0.33 ± 12%  perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
      0.78 ±  4%      -0.3        0.44 ±  4%  perf-profile.children.cycles-pp.xas_store
      0.80            -0.3        0.50        perf-profile.children.cycles-pp.vfs_unlink
      0.79            -0.3        0.50        perf-profile.children.cycles-pp.xfs_vn_unlink
      0.79            -0.3        0.50        perf-profile.children.cycles-pp.xfs_remove
      0.56 ±  4%      -0.3        0.27 ± 10%  perf-profile.children.cycles-pp.percpu_counter_add_batch
      0.48 ±  4%      -0.3        0.20 ±  4%  perf-profile.children.cycles-pp._cond_resched
      0.52 ±  5%      -0.3        0.24        perf-profile.children.cycles-pp.__might_sleep
      0.58 ±  4%      -0.3        0.30 ± 10%  perf-profile.children.cycles-pp.irq_exit
      0.47 ±  8%      -0.3        0.21 ±  4%  perf-profile.children.cycles-pp.fsnotify
      0.48            -0.3        0.21 ±  7%  perf-profile.children.cycles-pp.xfs_trans_read_buf_map
      0.34 ±  4%      -0.3        0.08        perf-profile.children.cycles-pp.ttwu_do_activate
      0.34 ±  4%      -0.3        0.08        perf-profile.children.cycles-pp.activate_task
      0.52 ± 10%      -0.3        0.27 ± 30%  perf-profile.children.cycles-pp.balance_dirty_pages_ratelimited
      0.34 ±  3%      -0.3        0.08        perf-profile.children.cycles-pp.enqueue_task_fair
      0.98 ±  6%      -0.3        0.72 ±  5%  perf-profile.children.cycles-pp.xfs_inactive_ifree
      0.32 ±  3%      -0.2        0.08 ±  6%  perf-profile.children.cycles-pp.enqueue_entity
      0.42 ±  5%      -0.2        0.18 ±  2%  perf-profile.children.cycles-pp.xfs_break_leased_layouts
      0.52 ±  5%      -0.2        0.28 ± 13%  perf-profile.children.cycles-pp.__softirqentry_text_start
      0.31 ±  5%      -0.2        0.09 ±  5%  perf-profile.children.cycles-pp.try_to_wake_up
      0.39 ±  3%      -0.2        0.17 ±  5%  perf-profile.children.cycles-pp.__mod_memcg_state
      0.38 ±  4%      -0.2        0.16 ± 10%  perf-profile.children.cycles-pp.xfs_bmbt_to_iomap
      0.38 ±  7%      -0.2        0.16 ±  7%  perf-profile.children.cycles-pp.unlock_page
      0.38 ±  6%      -0.2        0.16 ±  2%  perf-profile.children.cycles-pp.__x64_sys_write
      0.35 ±  2%      -0.2        0.14 ± 11%  perf-profile.children.cycles-pp.xfs_buf_read_map
      0.39 ±  2%      -0.2        0.19 ± 18%  perf-profile.children.cycles-pp.xfs_vn_update_time
      0.34 ±  2%      -0.2        0.14 ± 11%  perf-profile.children.cycles-pp.xfs_buf_get_map
      0.37 ±  4%      -0.2        0.17 ±  2%  perf-profile.children.cycles-pp.mem_cgroup_commit_charge
      0.26 ±  3%      -0.2        0.07 ±  7%  perf-profile.children.cycles-pp.__account_scheduler_latency
      1.12            -0.2        0.92        perf-profile.children.cycles-pp.xfs_generic_create
      0.39 ±  5%      -0.2        0.21 ±  2%  perf-profile.children.cycles-pp.xfs_iext_lookup_extent
      1.10            -0.2        0.91        perf-profile.children.cycles-pp.xfs_create
      0.32 ±  6%      -0.2        0.14        perf-profile.children.cycles-pp.page_mapping
      0.32 ±  4%      -0.2        0.14        perf-profile.children.cycles-pp.__list_del_entry_valid
      0.43 ±  5%      -0.2        0.25        perf-profile.children.cycles-pp.xfs_errortag_test
      0.35            -0.2        0.17 ±  4%  perf-profile.children.cycles-pp.generic_write_checks
      0.30 ±  2%      -0.2        0.12 ± 13%  perf-profile.children.cycles-pp.xfs_buf_find
      0.32 ±  2%      -0.2        0.14 ±  3%  perf-profile.children.cycles-pp.__mod_node_page_state
      0.22 ±  3%      -0.2        0.05 ±  8%  perf-profile.children.cycles-pp.stack_trace_save_tsk
      0.38 ±  4%      -0.2        0.22 ±  5%  perf-profile.children.cycles-pp.xfs_da3_node_lookup_int
      0.41            -0.2        0.24 ±  5%  perf-profile.children.cycles-pp.xfs_dir_removename
      0.40 ±  2%      -0.2        0.24 ±  3%  perf-profile.children.cycles-pp.__x86_indirect_thunk_rax
      0.33 ±  6%      -0.2        0.16 ±  2%  perf-profile.children.cycles-pp.current_time
      0.26 ±  3%      -0.2        0.10 ±  4%  perf-profile.children.cycles-pp.iov_iter_advance
      0.37 ±  2%      -0.2        0.21 ± 18%  perf-profile.children.cycles-pp.rcu_core
      0.40 ±  2%      -0.2        0.24 ±  5%  perf-profile.children.cycles-pp.xfs_dir2_node_removename
      0.26 ±  3%      -0.2        0.10 ±  4%  perf-profile.children.cycles-pp.__sched_text_start
      0.23 ±  2%      -0.2        0.07 ± 12%  perf-profile.children.cycles-pp.xfs_read_agi
      0.21 ±  2%      -0.2        0.05        perf-profile.children.cycles-pp.arch_stack_walk
      0.29 ±  2%      -0.2        0.14 ±  3%  perf-profile.children.cycles-pp.node_dirty_ok
      0.28 ±  7%      -0.2        0.13 ±  3%  perf-profile.children.cycles-pp.find_get_entries
      0.26 ±  3%      -0.2        0.11 ±  4%  perf-profile.children.cycles-pp.__fsnotify_parent
      0.28 ±  7%      -0.2        0.13        perf-profile.children.cycles-pp.pagevec_lookup_entries
      0.23 ±  3%      -0.1        0.08 ± 14%  perf-profile.children.cycles-pp.xfs_buf_item_release
      0.26 ±  8%      -0.1        0.12 ±  8%  perf-profile.children.cycles-pp.xas_start
      0.28 ±  6%      -0.1        0.15 ±  3%  perf-profile.children.cycles-pp.mem_cgroup_try_charge
      0.25 ±  3%      -0.1        0.11 ±  4%  perf-profile.children.cycles-pp.mem_cgroup_charge_statistics
      0.23 ±  7%      -0.1        0.09 ±  5%  perf-profile.children.cycles-pp.rcu_all_qs
      0.21 ±  3%      -0.1        0.07 ± 17%  perf-profile.children.cycles-pp.xfs_buf_unlock
      0.20 ±  4%      -0.1        0.06 ±  7%  perf-profile.children.cycles-pp.up
      0.25 ±  5%      -0.1        0.12 ±  4%  perf-profile.children.cycles-pp.free_unref_page_list
      0.22 ±  7%      -0.1        0.10 ± 17%  perf-profile.children.cycles-pp.__sb_end_write
      0.20 ±  4%      -0.1        0.09 ± 14%  perf-profile.children.cycles-pp.xfs_iunlink_remove
      0.64 ±  5%      -0.1        0.53 ±  7%  perf-profile.children.cycles-pp.xfs_ifree
      0.20 ±  4%      -0.1        0.09 ± 13%  perf-profile.children.cycles-pp.lock_page_memcg
      0.69 ±  8%      -0.1        0.58 ±  4%  perf-profile.children.cycles-pp.hrtimer_interrupt
      0.21 ±  5%      -0.1        0.11        perf-profile.children.cycles-pp.xfs_dir_createname
      0.23 ± 14%      -0.1        0.13 ± 16%  perf-profile.children.cycles-pp.ktime_get
      0.13 ± 15%      -0.1        0.03 ± 70%  perf-profile.children.cycles-pp.xfs_get_extsz_hint
      0.20 ±  6%      -0.1        0.10 ±  4%  perf-profile.children.cycles-pp.xfs_dir2_node_addname
      0.17 ±  7%      -0.1        0.07 ±  7%  perf-profile.children.cycles-pp.mem_cgroup_uncharge_list
      0.18 ±  9%      -0.1        0.08 ± 24%  perf-profile.children.cycles-pp.wait_for_stable_page
      0.18 ±  2%      -0.1        0.09 ± 10%  perf-profile.children.cycles-pp.xfs_trans_alloc
      0.18 ±  5%      -0.1        0.08        perf-profile.children.cycles-pp.get_mem_cgroup_from_mm
      0.20 ±  8%      -0.1        0.11 ±  7%  perf-profile.children.cycles-pp.workingset_update_node
      0.19 ±  6%      -0.1        0.09 ±  5%  perf-profile.children.cycles-pp.xfs_btree_lookup
      0.18 ±  5%      -0.1        0.08 ±  5%  perf-profile.children.cycles-pp.__xa_set_mark
      0.20 ±  4%      -0.1        0.10 ±  9%  perf-profile.children.cycles-pp.xfs_da_read_buf
      0.20 ±  2%      -0.1        0.11 ±  7%  perf-profile.children.cycles-pp._raw_spin_unlock_irqrestore
      0.22 ±  2%      -0.1        0.14 ±  3%  perf-profile.children.cycles-pp.__xfs_dir3_data_check
      0.21 ±  2%      -0.1        0.12        perf-profile.children.cycles-pp.xfs_dir2_leafn_lookup_for_entry
      0.12 ±  6%      -0.1        0.03 ± 70%  perf-profile.children.cycles-pp.__list_add_valid
      0.16 ±  2%      -0.1        0.08 ±  6%  perf-profile.children.cycles-pp.unaccount_page_cache_page
      0.16 ±  2%      -0.1        0.08 ±  6%  perf-profile.children.cycles-pp.schedule
      0.22 ±  2%      -0.1        0.14 ±  5%  perf-profile.children.cycles-pp.xfs_dir3_data_check
      0.17 ±  4%      -0.1        0.09 ±  5%  perf-profile.children.cycles-pp.xas_init_marks
      0.14 ±  3%      -0.1        0.06        perf-profile.children.cycles-pp.file_modified
      0.20 ± 13%      -0.1        0.11 ±  4%  perf-profile.children.cycles-pp.apparmor_file_permission
      0.18 ±  2%      -0.1        0.10 ±  8%  perf-profile.children.cycles-pp.generic_write_check_limits
      0.15 ±  6%      -0.1        0.07 ±  7%  perf-profile.children.cycles-pp.aa_file_perm
      0.13 ±  9%      -0.1        0.05 ±  8%  perf-profile.children.cycles-pp.__mark_inode_dirty
      0.14 ±  6%      -0.1        0.06 ± 13%  perf-profile.children.cycles-pp.dec_zone_page_state
      0.14 ±  3%      -0.1        0.07 ±  7%  perf-profile.children.cycles-pp.xfs_vn_lookup
      0.20 ± 19%      -0.1        0.12 ± 11%  perf-profile.children.cycles-pp.clockevents_program_event
      0.14 ±  3%      -0.1        0.07 ±  7%  perf-profile.children.cycles-pp.xfs_lookup
      0.13 ± 12%      -0.1        0.06        perf-profile.children.cycles-pp.times
      0.13 ±  3%      -0.1        0.06 ±  7%  perf-profile.children.cycles-pp.xfs_dir_lookup
      0.13 ±  3%      -0.1        0.06 ±  7%  perf-profile.children.cycles-pp.alloc_pages_current
      0.13            -0.1        0.06 ±  7%  perf-profile.children.cycles-pp.xfs_trans_reserve
      0.13 ±  6%      -0.1        0.07 ±  7%  perf-profile.children.cycles-pp.xas_clear_mark
      0.12            -0.1        0.06 ±  8%  perf-profile.children.cycles-pp.xfs_log_reserve
      0.12 ±  4%      -0.1        0.05 ±  8%  perf-profile.children.cycles-pp.xfs_btree_lookup_get_block
      0.12 ± 16%      -0.1        0.06 ±  7%  perf-profile.children.cycles-pp.timestamp_truncate
      0.17 ± 14%      -0.1        0.11 ±  8%  perf-profile.children.cycles-pp.xfs_bmapi_reserve_delalloc
      0.12 ±  3%      -0.1        0.07 ±  7%  perf-profile.children.cycles-pp.xfs_da3_node_read
      0.11 ±  4%      -0.1        0.06 ±  8%  perf-profile.children.cycles-pp.xfs_dir2_node_lookup
      0.11 ±  4%      -0.1        0.05 ±  8%  perf-profile.children.cycles-pp.free_unref_page_commit
      0.11 ±  4%      -0.1        0.06 ±  8%  perf-profile.children.cycles-pp._xfs_trans_bjoin
      0.11 ±  7%      -0.0        0.06 ±  7%  perf-profile.children.cycles-pp.xfs_dir3_leaf_check_int
      0.10 ±  4%      -0.0        0.05 ±  8%  perf-profile.children.cycles-pp.__inc_node_state
      0.12 ±  3%      -0.0        0.08 ± 10%  perf-profile.children.cycles-pp.xfs_dir_ino_validate
      0.11 ±  7%      -0.0        0.07 ±  7%  perf-profile.children.cycles-pp.xfs_inode_item_format
      0.10 ±  8%      -0.0        0.06 ± 13%  perf-profile.children.cycles-pp.update_load_avg
      0.19 ±  4%      -0.0        0.16 ±  5%  perf-profile.children.cycles-pp.xfs_buf_item_format
      0.09 ± 15%      -0.0        0.06 ± 13%  perf-profile.children.cycles-pp.__percpu_counter_sum
      0.09 ±  5%      -0.0        0.06 ±  8%  perf-profile.children.cycles-pp.xfs_verify_ino
      0.06 ±  7%      -0.0        0.03 ± 70%  perf-profile.children.cycles-pp.pick_next_task_fair
      0.11 ±  4%      -0.0        0.08 ±  5%  perf-profile.children.cycles-pp.xfs_agino_range
      0.10 ± 14%      -0.0        0.07 ± 11%  perf-profile.children.cycles-pp.__percpu_counter_compare
      0.08 ±  5%      -0.0        0.06 ±  8%  perf-profile.children.cycles-pp.ktime_get_coarse_real_ts64
      0.13 ± 13%      -0.0        0.10 ±  8%  perf-profile.children.cycles-pp.menu_select
      0.09 ± 10%      +0.0        0.13 ±  9%  perf-profile.children.cycles-pp.xfs_inobt_get_maxrecs
      0.09 ± 14%      +0.1        0.14 ± 18%  perf-profile.children.cycles-pp.task_tick_fair
      0.49 ±  4%      +0.1        0.55 ±  2%  perf-profile.children.cycles-pp.xfs_dir_ialloc
      0.49 ±  4%      +0.1        0.55 ±  2%  perf-profile.children.cycles-pp.xfs_ialloc
      0.15 ± 11%      +0.1        0.21 ±  2%  perf-profile.children.cycles-pp._raw_spin_lock_irq
      0.44 ±  5%      +0.1        0.51        perf-profile.children.cycles-pp.xfs_dialloc
      0.19 ±  6%      +0.1        0.29 ±  9%  perf-profile.children.cycles-pp.__xfs_btree_check_sblock
      0.20 ±  4%      +0.1        0.29 ±  5%  perf-profile.children.cycles-pp.xfs_btree_get_rec
      0.37 ±  5%      +0.1        0.49        perf-profile.children.cycles-pp.xfs_dialloc_ag
      0.33 ±  2%      +0.1        0.46 ±  4%  perf-profile.children.cycles-pp.xfs_inobt_get_rec
      0.17 ±  5%      +0.1        0.32 ±  9%  perf-profile.children.cycles-pp.xfs_btree_increment
      0.26 ±  6%      +0.2        0.44 ±  8%  perf-profile.children.cycles-pp.xfs_btree_check_sblock
      0.63 ±  3%      +0.2        0.83 ±  5%  perf-profile.children.cycles-pp.xfs_check_agi_freecount
      0.00            +0.3        0.28 ± 11%  perf-profile.children.cycles-pp.xfs_inactive_worker
      0.05            +0.3        0.37 ±  8%  perf-profile.children.cycles-pp.process_one_work
      0.05            +0.3        0.37 ±  7%  perf-profile.children.cycles-pp.worker_thread
      0.07 ±  7%      +0.3        0.40 ±  6%  perf-profile.children.cycles-pp.ret_from_fork
      0.07 ±  7%      +0.3        0.40 ±  6%  perf-profile.children.cycles-pp.kthread
      0.00            +0.5        0.51 ± 13%  perf-profile.children.cycles-pp.xfs_inode_free_blocks
      0.00            +0.8        0.77 ±  5%  perf-profile.children.cycles-pp.xfs_inactive_inode
      0.00            +0.8        0.79 ±  6%  perf-profile.children.cycles-pp.xfs_ici_walk_fns
      0.00            +0.8        0.79 ±  6%  perf-profile.children.cycles-pp.xfs_ici_walk_ag
      2.76 ±  3%     +29.1       31.89        perf-profile.children.cycles-pp.unlink
      2.70 ±  4%     +29.2       31.85        perf-profile.children.cycles-pp.do_unlinkat
      2.78 ±  5%     +29.5       32.23        perf-profile.children.cycles-pp.creat
      2.73 ±  5%     +29.5       32.20        perf-profile.children.cycles-pp.do_sys_openat2
      2.73 ±  5%     +29.5       32.21        perf-profile.children.cycles-pp.do_sys_open
      2.69 ±  5%     +29.5       32.19        perf-profile.children.cycles-pp.do_filp_open
      2.69 ±  5%     +29.5       32.19        perf-profile.children.cycles-pp.path_openat
     56.69 ±  5%     +31.5       88.15        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     56.38 ±  5%     +31.6       88.02        perf-profile.children.cycles-pp.do_syscall_64
      2.96 ±  8%     +59.5       62.42        perf-profile.children.cycles-pp.rwsem_down_write_slowpath
      2.44 ± 10%     +59.9       62.29        perf-profile.children.cycles-pp.rwsem_optimistic_spin
      0.74 ± 22%     +60.1       60.88        perf-profile.children.cycles-pp.osq_lock
     31.78 ± 11%     -25.2        6.55 ±  7%  perf-profile.self.cycles-pp.intel_idle
      6.53 ±  6%      -3.4        3.11        perf-profile.self.cycles-pp.do_syscall_64
      5.29 ±  7%      -2.9        2.37        perf-profile.self.cycles-pp.iomap_set_range_uptodate
      4.45 ±  5%      -2.5        1.91        perf-profile.self.cycles-pp.syscall_return_via_sysret
      4.06 ±  5%      -2.3        1.71        perf-profile.self.cycles-pp.entry_SYSCALL_64
      1.70 ±  4%      -0.8        0.86        perf-profile.self.cycles-pp.copy_user_enhanced_fast_string
      1.45 ±  4%      -0.8        0.62 ±  3%  perf-profile.self.cycles-pp.xfs_buffered_write_iomap_begin
      1.10 ±  4%      -0.6        0.46 ±  2%  perf-profile.self.cycles-pp.iov_iter_fault_in_readable
      1.05 ±  6%      -0.6        0.46 ±  5%  perf-profile.self.cycles-pp.xfs_file_write_iter
      1.09 ±  6%      -0.6        0.51        perf-profile.self.cycles-pp.iomap_apply
      0.90 ±  5%      -0.6        0.33 ±  8%  perf-profile.self.cycles-pp.xfs_buffered_write_iomap_end
      2.00 ±  3%      -0.5        1.47        perf-profile.self.cycles-pp.rwsem_spin_on_owner
      0.89 ±  7%      -0.5        0.38 ±  6%  perf-profile.self.cycles-pp.common_file_perm
      0.86 ±  5%      -0.5        0.41        perf-profile.self.cycles-pp.iomap_write_actor
      0.78 ±  4%      -0.5        0.33 ±  3%  perf-profile.self.cycles-pp.write
      0.94 ±  3%      -0.5        0.49 ±  2%  perf-profile.self.cycles-pp.___might_sleep
      0.75 ±  7%      -0.4        0.33 ±  3%  perf-profile.self.cycles-pp.find_get_entry
      0.69 ±  4%      -0.4        0.30        perf-profile.self.cycles-pp.down_write
      0.68 ±  6%      -0.4        0.31 ±  2%  perf-profile.self.cycles-pp.up_write
      0.66 ±  8%      -0.4        0.29 ± 10%  perf-profile.self.cycles-pp.__fget_light
      0.68 ±  6%      -0.4        0.33 ± 12%  perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
      0.59 ±  6%      -0.3        0.26        perf-profile.self.cycles-pp.xas_load
      0.56 ±  7%      -0.3        0.24 ±  3%  perf-profile.self.cycles-pp.iomap_write_end
      0.60 ±  5%      -0.3        0.28 ±  7%  perf-profile.self.cycles-pp.xfs_file_buffered_aio_write
      0.54 ±  7%      -0.3        0.22 ±  4%  perf-profile.self.cycles-pp.__pagevec_lru_add_fn
      0.51 ±  6%      -0.3        0.21 ±  5%  perf-profile.self.cycles-pp.pagecache_get_page
      0.52            -0.3        0.25        perf-profile.self.cycles-pp._raw_spin_lock
      0.47 ±  8%      -0.3        0.21 ±  4%  perf-profile.self.cycles-pp.fsnotify
      0.47 ±  6%      -0.2        0.22        perf-profile.self.cycles-pp.__might_sleep
      0.43 ±  9%      -0.2        0.20 ±  2%  perf-profile.self.cycles-pp.iov_iter_copy_from_user_atomic
      0.45 ±  4%      -0.2        0.22 ±  2%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.47 ± 12%      -0.2        0.24 ± 36%  perf-profile.self.cycles-pp.balance_dirty_pages_ratelimited
      0.45 ±  3%      -0.2        0.22 ± 13%  perf-profile.self.cycles-pp.percpu_counter_add_batch
      0.40 ±  5%      -0.2        0.17 ±  4%  perf-profile.self.cycles-pp.xfs_break_leased_layouts
      0.41 ±  9%      -0.2        0.19 ±  2%  perf-profile.self.cycles-pp.vfs_write
      0.38 ±  4%      -0.2        0.16 ±  7%  perf-profile.self.cycles-pp.xfs_bmbt_to_iomap
      0.51 ±  6%      -0.2        0.30 ±  7%  perf-profile.self.cycles-pp.iomap_write_begin
      0.41 ±  5%      -0.2        0.20 ±  4%  perf-profile.self.cycles-pp.__sb_start_write
      0.36 ±  7%      -0.2        0.16 ±  6%  perf-profile.self.cycles-pp.unlock_page
      0.38 ±  2%      -0.2        0.17 ±  5%  perf-profile.self.cycles-pp.__mod_memcg_state
      0.35 ±  6%      -0.2        0.15 ±  5%  perf-profile.self.cycles-pp.__x64_sys_write
      0.33 ±  6%      -0.2        0.14 ±  3%  perf-profile.self.cycles-pp.ksys_write
      0.35 ± 11%      -0.2        0.16 ±  2%  perf-profile.self.cycles-pp.get_page_from_freelist
      0.33 ±  8%      -0.2        0.15 ±  3%  perf-profile.self.cycles-pp.iomap_set_page_dirty
      0.32 ±  6%      -0.2        0.14        perf-profile.self.cycles-pp.page_mapping
      0.31 ±  7%      -0.2        0.13 ±  3%  perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.31 ±  4%      -0.2        0.13 ±  3%  perf-profile.self.cycles-pp.__list_del_entry_valid
      0.32 ±  9%      -0.2        0.14 ±  3%  perf-profile.self.cycles-pp.new_sync_write
      0.34 ±  3%      -0.2        0.18 ±  2%  perf-profile.self.cycles-pp.release_pages
      0.30 ±  4%      -0.2        0.14 ±  6%  perf-profile.self.cycles-pp.__mod_node_page_state
      0.37 ±  5%      -0.2        0.20 ±  2%  perf-profile.self.cycles-pp.xfs_iext_lookup_extent
      0.28 ±  5%      -0.2        0.12 ±  4%  perf-profile.self.cycles-pp.xfs_ilock
      0.38 ±  3%      -0.2        0.22 ±  2%  perf-profile.self.cycles-pp.xfs_errortag_test
      0.29 ±  7%      -0.2        0.14 ±  3%  perf-profile.self.cycles-pp.xfs_iunlock
      0.26 ±  4%      -0.2        0.11 ±  4%  perf-profile.self.cycles-pp.xfs_file_aio_write_checks
      0.24 ±  3%      -0.1        0.09        perf-profile.self.cycles-pp.iov_iter_advance
      0.35 ±  2%      -0.1        0.21 ±  3%  perf-profile.self.cycles-pp.__x86_indirect_thunk_rax
      0.24 ±  5%      -0.1        0.10        perf-profile.self.cycles-pp._cond_resched
      0.24            -0.1        0.10        perf-profile.self.cycles-pp.__fsnotify_parent
      0.24            -0.1        0.10 ±  8%  perf-profile.self.cycles-pp.account_page_cleaned
      0.32 ±  6%      -0.1        0.18 ±  4%  perf-profile.self.cycles-pp.xas_store
      0.24 ±  8%      -0.1        0.10 ±  4%  perf-profile.self.cycles-pp.find_get_entries
      0.26 ±  8%      -0.1        0.12 ±  3%  perf-profile.self.cycles-pp.__add_to_page_cache_locked
      0.22 ±  5%      -0.1        0.08        perf-profile.self.cycles-pp.xfs_break_layouts
      0.24 ±  7%      -0.1        0.11 ±  8%  perf-profile.self.cycles-pp.xas_start
      0.22 ±  6%      -0.1        0.10 ± 17%  perf-profile.self.cycles-pp.__sb_end_write
      0.22 ±  5%      -0.1        0.11 ±  4%  perf-profile.self.cycles-pp.file_update_time
      0.22 ±  4%      -0.1        0.11 ± 16%  perf-profile.self.cycles-pp.account_page_dirtied
      0.20 ±  4%      -0.1        0.09 ±  5%  perf-profile.self.cycles-pp.node_dirty_ok
      0.20 ±  4%      -0.1        0.09 ± 13%  perf-profile.self.cycles-pp.lock_page_memcg
      0.20 ±  6%      -0.1        0.10 ±  4%  perf-profile.self.cycles-pp.__mod_lruvec_state
      0.17 ±  7%      -0.1        0.07 ± 14%  perf-profile.self.cycles-pp.rcu_all_qs
      0.18 ±  5%      -0.1        0.08        perf-profile.self.cycles-pp.get_mem_cgroup_from_mm
      0.17 ±  4%      -0.1        0.07 ±  6%  perf-profile.self.cycles-pp.iomap_file_buffered_write
      0.20 ± 17%      -0.1        0.10 ± 22%  perf-profile.self.cycles-pp.ktime_get
      0.13 ± 16%      -0.1        0.03 ± 70%  perf-profile.self.cycles-pp.xfs_get_extsz_hint
      0.18 ±  5%      -0.1        0.08 ±  5%  perf-profile.self.cycles-pp.__fdget_pos
      0.16 ± 10%      -0.1        0.07 ± 20%  perf-profile.self.cycles-pp.wait_for_stable_page
      0.12 ± 11%      -0.1        0.03 ± 70%  perf-profile.self.cycles-pp.__mark_inode_dirty
      0.16 ±  2%      -0.1        0.08 ±  6%  perf-profile.self.cycles-pp._raw_spin_unlock_irqrestore
      0.18 ±  2%      -0.1        0.10 ±  8%  perf-profile.self.cycles-pp.generic_write_check_limits
      0.18 ± 12%      -0.1        0.10        perf-profile.self.cycles-pp.apparmor_file_permission
      0.14 ±  3%      -0.1        0.06 ±  7%  perf-profile.self.cycles-pp.aa_file_perm
      0.15            -0.1        0.07        perf-profile.self.cycles-pp.generic_write_checks
      0.18 ±  7%      -0.1        0.10 ±  8%  perf-profile.self.cycles-pp.workingset_update_node
      0.15 ±  3%      -0.1        0.07        perf-profile.self.cycles-pp.truncate_inode_pages_range
      0.11 ±  7%      -0.1        0.03 ± 70%  perf-profile.self.cycles-pp.__list_add_valid
      0.13 ±  6%      -0.1        0.06 ±  8%  perf-profile.self.cycles-pp.current_time
      0.15 ±  5%      -0.1        0.08 ±  5%  perf-profile.self.cycles-pp.xfs_log_commit_cil
      0.13 ± 13%      -0.1        0.06        perf-profile.self.cycles-pp.__cancel_dirty_page
      0.16 ±  8%      -0.1        0.09 ±  5%  perf-profile.self.cycles-pp.__alloc_pages_nodemask
      0.13 ±  6%      -0.1        0.06 ±  7%  perf-profile.self.cycles-pp.security_file_permission
      0.12 ±  8%      -0.1        0.05 ±  8%  perf-profile.self.cycles-pp.dec_zone_page_state
      0.12 ± 11%      -0.1        0.06        perf-profile.self.cycles-pp.delete_from_page_cache_batch
      0.12 ±  6%      -0.1        0.06 ± 13%  perf-profile.self.cycles-pp.xas_clear_mark
      0.09 ± 15%      -0.1        0.03 ± 70%  perf-profile.self.cycles-pp.menu_select
      0.11 ± 19%      -0.1        0.06 ±  8%  perf-profile.self.cycles-pp.timestamp_truncate
      0.10 ±  4%      -0.1        0.05        perf-profile.self.cycles-pp.__lru_cache_add
      0.11 ±  7%      -0.0        0.06 ±  7%  perf-profile.self.cycles-pp.xfs_dir3_leaf_check_int
      0.10 ±  4%      -0.0        0.05 ±  8%  perf-profile.self.cycles-pp.__inc_node_state
      0.07 ±  6%      -0.0        0.03 ± 70%  perf-profile.self.cycles-pp.ktime_get_coarse_real_ts64
      0.08 ±  5%      -0.0        0.05 ±  8%  perf-profile.self.cycles-pp.__xfs_dir3_data_check
      0.15 ±  8%      -0.0        0.12 ±  6%  perf-profile.self.cycles-pp.memcpy_erms
      0.09            -0.0        0.06 ±  7%  perf-profile.self.cycles-pp.xfs_agino_range
      0.08 ± 12%      +0.0        0.12 ± 10%  perf-profile.self.cycles-pp.xfs_inobt_get_maxrecs
      0.10 ±  8%      +0.0        0.15 ±  8%  perf-profile.self.cycles-pp.__xfs_btree_check_sblock
      0.00            +0.1        0.06 ±  7%  perf-profile.self.cycles-pp.xfs_btree_increment
      0.14 ± 12%      +0.1        0.21 ±  2%  perf-profile.self.cycles-pp._raw_spin_lock_irq
      0.00            +0.1        0.08 ± 12%  perf-profile.self.cycles-pp.xfs_btree_check_sblock
      0.74 ± 21%     +59.8       60.51        perf-profile.self.cycles-pp.osq_lock





Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


Thanks,
Rong Chen


--mOKeRhn3B7HglGBY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="config-5.6.0-00207-gef6d7398f5c72"

#
# Automatically generated file; DO NOT EDIT.
# Linux/x86_64 5.6.0 Kernel Configuration
#

#
# Compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
#
CONFIG_CC_IS_GCC=y
CONFIG_GCC_VERSION=70500
CONFIG_CLANG_VERSION=0
CONFIG_CC_CAN_LINK=y
CONFIG_CC_HAS_ASM_GOTO=y
CONFIG_CC_HAS_ASM_INLINE=y
CONFIG_CC_HAS_WARN_MAYBE_UNINITIALIZED=y
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
CONFIG_KERNEL_GZIP=y
# CONFIG_KERNEL_BZIP2 is not set
# CONFIG_KERNEL_LZMA is not set
# CONFIG_KERNEL_XZ is not set
# CONFIG_KERNEL_LZO is not set
# CONFIG_KERNEL_LZ4 is not set
CONFIG_DEFAULT_HOSTNAME="(none)"
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_SYSVIPC_SYSCTL=y
CONFIG_POSIX_MQUEUE=y
CONFIG_POSIX_MQUEUE_SYSCTL=y
CONFIG_CROSS_MEMORY_ATTACH=y
CONFIG_USELIB=y
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
CONFIG_IRQ_DOMAIN=y
CONFIG_IRQ_SIM=y
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
CONFIG_ARCH_CLOCKSOURCE_DATA=y
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
# CONFIG_IRQ_TIME_ACCOUNTING is not set
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
CONFIG_TASKS_RCU=y
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
CONFIG_MEMCG_SWAP_ENABLED=y
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
CONFIG_CHECKPOINT_RESTORE=y
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
# CONFIG_BOOT_CONFIG is not set
CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE=y
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
CONFIG_SYSCTL=y
CONFIG_HAVE_UID16=y
CONFIG_SYSCTL_EXCEPTION_TRACE=y
CONFIG_HAVE_PCSPKR_PLATFORM=y
CONFIG_BPF=y
CONFIG_EXPERT=y
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
CONFIG_MEMBARRIER=y
CONFIG_KALLSYMS=y
CONFIG_KALLSYMS_ALL=y
CONFIG_KALLSYMS_ABSOLUTE_PERCPU=y
CONFIG_KALLSYMS_BASE_RELATIVE=y
CONFIG_BPF_SYSCALL=y
CONFIG_ARCH_WANT_DEFAULT_BPF_JIT=y
CONFIG_BPF_JIT_ALWAYS_ON=y
CONFIG_BPF_JIT_DEFAULT_ON=y
CONFIG_USERFAULTFD=y
CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=y
CONFIG_RSEQ=y
# CONFIG_DEBUG_RSEQ is not set
CONFIG_EMBEDDED=y
CONFIG_HAVE_PERF_EVENTS=y
# CONFIG_PC104 is not set

#
# Kernel Performance Events And Counters
#
CONFIG_PERF_EVENTS=y
# CONFIG_DEBUG_PERF_USE_VMALLOC is not set
# end of Kernel Performance Events And Counters

CONFIG_VM_EVENT_COUNTERS=y
CONFIG_SLUB_DEBUG=y
# CONFIG_SLUB_MEMCG_SYSFS_ON is not set
# CONFIG_COMPAT_BRK is not set
# CONFIG_SLAB is not set
CONFIG_SLUB=y
# CONFIG_SLOB is not set
CONFIG_SLAB_MERGE_DEFAULT=y
# CONFIG_SLAB_FREELIST_RANDOM is not set
# CONFIG_SLAB_FREELIST_HARDENED is not set
# CONFIG_SHUFFLE_PAGE_ALLOCATOR is not set
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
CONFIG_ARCH_DEFCONFIG="arch/x86/configs/x86_64_defconfig"
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
CONFIG_PARAVIRT_XXL=y
# CONFIG_PARAVIRT_DEBUG is not set
CONFIG_PARAVIRT_SPINLOCKS=y
CONFIG_X86_HV_CALLBACK_VECTOR=y
CONFIG_XEN=y
CONFIG_XEN_PV=y
CONFIG_XEN_PV_SMP=y
# CONFIG_XEN_DOM0 is not set
CONFIG_XEN_PVHVM=y
CONFIG_XEN_PVHVM_SMP=y
CONFIG_XEN_512GB=y
CONFIG_XEN_SAVE_RESTORE=y
# CONFIG_XEN_DEBUG_FS is not set
# CONFIG_XEN_PVH is not set
CONFIG_KVM_GUEST=y
CONFIG_ARCH_CPUIDLE_HALTPOLL=y
# CONFIG_PVH is not set
# CONFIG_KVM_DEBUG_FS is not set
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
# CONFIG_PROCESSOR_SELECT is not set
CONFIG_CPU_SUP_INTEL=y
CONFIG_CPU_SUP_AMD=y
CONFIG_CPU_SUP_HYGON=y
CONFIG_CPU_SUP_CENTAUR=y
CONFIG_CPU_SUP_ZHAOXIN=y
CONFIG_HPET_TIMER=y
CONFIG_HPET_EMULATE_RTC=y
CONFIG_DMI=y
CONFIG_GART_IOMMU=y
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
CONFIG_PERF_EVENTS_INTEL_UNCORE=y
CONFIG_PERF_EVENTS_INTEL_RAPL=y
CONFIG_PERF_EVENTS_INTEL_CSTATE=y
# CONFIG_PERF_EVENTS_AMD_POWER is not set
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
CONFIG_NODES_SPAN_OTHER_NODES=y
CONFIG_NUMA_EMU=y
CONFIG_NODES_SHIFT=10
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_DEFAULT=y
CONFIG_ARCH_SELECT_MEMORY_MODEL=y
CONFIG_ARCH_MEMORY_PROBE=y
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
# CONFIG_SUSPEND_SKIP_SYNC is not set
CONFIG_HIBERNATE_CALLBACKS=y
CONFIG_HIBERNATION=y
CONFIG_PM_STD_PARTITION=""
CONFIG_PM_SLEEP=y
CONFIG_PM_SLEEP_SMP=y
# CONFIG_PM_AUTOSLEEP is not set
# CONFIG_PM_WAKELOCKS is not set
CONFIG_PM=y
CONFIG_PM_DEBUG=y
CONFIG_PM_ADVANCED_DEBUG=y
# CONFIG_PM_TEST_SUSPEND is not set
CONFIG_PM_SLEEP_DEBUG=y
# CONFIG_DPM_WATCHDOG is not set
CONFIG_PM_TRACE=y
CONFIG_PM_TRACE_RTC=y
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
# CONFIG_ACPI_PROCFS_POWER is not set
CONFIG_ACPI_REV_OVERRIDE_POSSIBLE=y
CONFIG_ACPI_EC_DEBUGFS=m
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_VIDEO=m
CONFIG_ACPI_FAN=y
# CONFIG_ACPI_TAD is not set
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
CONFIG_ACPI_CUSTOM_METHOD=m
CONFIG_ACPI_BGRT=y
# CONFIG_ACPI_REDUCED_HARDWARE_ONLY is not set
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
# CONFIG_DPTF_POWER is not set
CONFIG_ACPI_WATCHDOG=y
CONFIG_ACPI_EXTLOG=m
CONFIG_ACPI_ADXL=y
# CONFIG_PMIC_OPREGION is not set
# CONFIG_ACPI_CONFIGFS is not set
CONFIG_X86_PM_TIMER=y
CONFIG_SFI=y

#
# CPU Frequency scaling
#
CONFIG_CPU_FREQ=y
CONFIG_CPU_FREQ_GOV_ATTR_SET=y
CONFIG_CPU_FREQ_GOV_COMMON=y
# CONFIG_CPU_FREQ_STAT is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND=y
# CONFIG_CPU_FREQ_DEFAULT_GOV_CONSERVATIVE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_SCHEDUTIL is not set
CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
CONFIG_CPU_FREQ_GOV_POWERSAVE=y
CONFIG_CPU_FREQ_GOV_USERSPACE=y
CONFIG_CPU_FREQ_GOV_ONDEMAND=y
CONFIG_CPU_FREQ_GOV_CONSERVATIVE=y
# CONFIG_CPU_FREQ_GOV_SCHEDUTIL is not set

#
# CPU frequency scaling drivers
#
CONFIG_X86_INTEL_PSTATE=y
CONFIG_X86_PCC_CPUFREQ=m
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
# CONFIG_PCI_CNB20LE_QUIRK is not set
# CONFIG_ISA_BUS is not set
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
CONFIG_ISCSI_IBFT_FIND=y
CONFIG_ISCSI_IBFT=m
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
CONFIG_VIRTUALIZATION=y
CONFIG_KVM=m
CONFIG_KVM_WERROR=y
CONFIG_KVM_INTEL=m
CONFIG_KVM_AMD=m
CONFIG_KVM_AMD_SEV=y
CONFIG_KVM_MMU_AUDIT=y
CONFIG_VHOST_NET=m
# CONFIG_VHOST_SCSI is not set
CONFIG_VHOST_VSOCK=m
CONFIG_VHOST=m
# CONFIG_VHOST_CROSS_ENDIAN_LEGACY is not set

#
# General architecture-dependent options
#
CONFIG_CRASH_CORE=y
CONFIG_KEXEC_CORE=y
CONFIG_HOTPLUG_SMT=y
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
CONFIG_HAVE_CLK=y
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
CONFIG_HAVE_IRQ_EXIT_ON_IRQ_STACK=y
CONFIG_ARCH_HAS_ELF_RANDOMIZE=y
CONFIG_HAVE_ARCH_MMAP_RND_BITS=y
CONFIG_HAVE_EXIT_THREAD=y
CONFIG_ARCH_MMAP_RND_BITS=28
CONFIG_HAVE_ARCH_MMAP_RND_COMPAT_BITS=y
CONFIG_ARCH_MMAP_RND_COMPAT_BITS=8
CONFIG_HAVE_ARCH_COMPAT_MMAP_BASES=y
CONFIG_HAVE_COPY_THREAD_TLS=y
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

CONFIG_PLUGIN_HOSTCC="g++"
CONFIG_HAVE_GCC_PLUGINS=y
CONFIG_GCC_PLUGINS=y
# CONFIG_GCC_PLUGIN_CYC_COMPLEXITY is not set
# CONFIG_GCC_PLUGIN_LATENT_ENTROPY is not set
# CONFIG_GCC_PLUGIN_RANDSTRUCT is not set
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
# CONFIG_BLK_WBT is not set
# CONFIG_BLK_CGROUP_IOLATENCY is not set
# CONFIG_BLK_CGROUP_IOCOST is not set
CONFIG_BLK_DEBUG_FS=y
CONFIG_BLK_DEBUG_FS_ZONED=y
# CONFIG_BLK_SED_OPAL is not set

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
# CONFIG_IOSCHED_BFQ is not set
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
CONFIG_HAVE_MEMBLOCK_NODE_MAP=y
CONFIG_HAVE_FAST_GUP=y
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
CONFIG_TRANSPARENT_HUGE_PAGECACHE=y
CONFIG_CLEANCACHE=y
CONFIG_FRONTSWAP=y
CONFIG_CMA=y
# CONFIG_CMA_DEBUG is not set
# CONFIG_CMA_DEBUGFS is not set
CONFIG_CMA_AREAS=7
CONFIG_MEM_SOFT_DIRTY=y
CONFIG_ZSWAP=y
CONFIG_ZPOOL=y
CONFIG_ZBUD=y
# CONFIG_Z3FOLD is not set
CONFIG_ZSMALLOC=y
# CONFIG_PGTABLE_MAPPING is not set
# CONFIG_ZSMALLOC_STAT is not set
CONFIG_GENERIC_EARLY_IOREMAP=y
CONFIG_DEFERRED_STRUCT_PAGE_INIT=y
CONFIG_IDLE_PAGE_TRACKING=y
CONFIG_ARCH_HAS_PTE_DEVMAP=y
CONFIG_ZONE_DEVICE=y
CONFIG_DEV_PAGEMAP_OPS=y
# CONFIG_DEVICE_PRIVATE is not set
CONFIG_FRAME_VECTOR=y
CONFIG_ARCH_USES_HIGH_VMA_FLAGS=y
CONFIG_ARCH_HAS_PKEYS=y
# CONFIG_PERCPU_STATS is not set
CONFIG_GUP_BENCHMARK=y
# CONFIG_READ_ONLY_THP_FOR_FS is not set
CONFIG_ARCH_HAS_PTE_SPECIAL=y
CONFIG_MAPPING_DIRTY_HELPERS=y
# end of Memory Management options

CONFIG_NET=y
CONFIG_COMPAT_NETLINK_MESSAGES=y
CONFIG_NET_INGRESS=y
CONFIG_NET_EGRESS=y
CONFIG_NET_REDIRECT=y
CONFIG_SKB_EXTENSIONS=y

#
# Networking options
#
CONFIG_PACKET=y
CONFIG_PACKET_DIAG=m
CONFIG_UNIX=y
CONFIG_UNIX_SCM=y
CONFIG_UNIX_DIAG=m
# CONFIG_TLS is not set
CONFIG_XFRM=y
CONFIG_XFRM_ALGO=y
CONFIG_XFRM_USER=y
# CONFIG_XFRM_INTERFACE is not set
CONFIG_XFRM_SUB_POLICY=y
CONFIG_XFRM_MIGRATE=y
CONFIG_XFRM_STATISTICS=y
CONFIG_XFRM_IPCOMP=m
CONFIG_NET_KEY=m
CONFIG_NET_KEY_MIGRATE=y
# CONFIG_SMC is not set
# CONFIG_XDP_SOCKETS is not set
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
CONFIG_NET_FOU=m
CONFIG_NET_FOU_IP_TUNNELS=y
CONFIG_INET_AH=m
CONFIG_INET_ESP=m
# CONFIG_INET_ESP_OFFLOAD is not set
# CONFIG_INET_ESPINTCP is not set
CONFIG_INET_IPCOMP=m
CONFIG_INET_XFRM_TUNNEL=m
CONFIG_INET_TUNNEL=m
CONFIG_INET_DIAG=m
CONFIG_INET_TCP_DIAG=m
CONFIG_INET_UDP_DIAG=m
# CONFIG_INET_RAW_DIAG is not set
# CONFIG_INET_DIAG_DESTROY is not set
CONFIG_TCP_CONG_ADVANCED=y
CONFIG_TCP_CONG_BIC=m
CONFIG_TCP_CONG_CUBIC=y
CONFIG_TCP_CONG_WESTWOOD=m
CONFIG_TCP_CONG_HTCP=m
CONFIG_TCP_CONG_HSTCP=m
CONFIG_TCP_CONG_HYBLA=m
CONFIG_TCP_CONG_VEGAS=m
# CONFIG_TCP_CONG_NV is not set
CONFIG_TCP_CONG_SCALABLE=m
CONFIG_TCP_CONG_LP=m
CONFIG_TCP_CONG_VENO=m
CONFIG_TCP_CONG_YEAH=m
CONFIG_TCP_CONG_ILLINOIS=m
CONFIG_TCP_CONG_DCTCP=m
# CONFIG_TCP_CONG_CDG is not set
# CONFIG_TCP_CONG_BBR is not set
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
# CONFIG_INET6_ESP_OFFLOAD is not set
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
CONFIG_IPV6_FOU=m
CONFIG_IPV6_FOU_TUNNEL=m
CONFIG_IPV6_MULTIPLE_TABLES=y
# CONFIG_IPV6_SUBTREES is not set
CONFIG_IPV6_MROUTE=y
CONFIG_IPV6_MROUTE_MULTIPLE_TABLES=y
CONFIG_IPV6_PIMSM_V2=y
CONFIG_IPV6_SEG6_LWTUNNEL=y
# CONFIG_IPV6_SEG6_HMAC is not set
CONFIG_IPV6_SEG6_BPF=y
CONFIG_NETLABEL=y
CONFIG_MPTCP=y
CONFIG_MPTCP_IPV6=y
# CONFIG_MPTCP_HMAC_TEST is not set
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
CONFIG_NETFILTER_NETLINK_ACCT=m
CONFIG_NETFILTER_NETLINK_QUEUE=m
CONFIG_NETFILTER_NETLINK_LOG=m
CONFIG_NETFILTER_NETLINK_OSF=m
CONFIG_NF_CONNTRACK=m
CONFIG_NF_LOG_COMMON=m
# CONFIG_NF_LOG_NETDEV is not set
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
# CONFIG_NETFILTER_NETLINK_GLUE_CT is not set
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
# CONFIG_NF_TABLES_SET is not set
# CONFIG_NF_TABLES_INET is not set
# CONFIG_NF_TABLES_NETDEV is not set
# CONFIG_NFT_NUMGEN is not set
CONFIG_NFT_CT=m
CONFIG_NFT_COUNTER=m
# CONFIG_NFT_CONNLIMIT is not set
CONFIG_NFT_LOG=m
CONFIG_NFT_LIMIT=m
CONFIG_NFT_MASQ=m
CONFIG_NFT_REDIR=m
# CONFIG_NFT_TUNNEL is not set
# CONFIG_NFT_OBJREF is not set
CONFIG_NFT_QUEUE=m
# CONFIG_NFT_QUOTA is not set
CONFIG_NFT_REJECT=m
CONFIG_NFT_COMPAT=m
CONFIG_NFT_HASH=m
# CONFIG_NFT_XFRM is not set
# CONFIG_NFT_SOCKET is not set
# CONFIG_NFT_OSF is not set
# CONFIG_NFT_TPROXY is not set
# CONFIG_NFT_SYNPROXY is not set
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
CONFIG_NETFILTER_XT_TARGET_LED=m
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
CONFIG_NETFILTER_XT_MATCH_L2TP=m
CONFIG_NETFILTER_XT_MATCH_LENGTH=m
CONFIG_NETFILTER_XT_MATCH_LIMIT=m
CONFIG_NETFILTER_XT_MATCH_MAC=m
CONFIG_NETFILTER_XT_MATCH_MARK=m
CONFIG_NETFILTER_XT_MATCH_MULTIPORT=m
CONFIG_NETFILTER_XT_MATCH_NFACCT=m
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
CONFIG_NETFILTER_XT_MATCH_TIME=m
CONFIG_NETFILTER_XT_MATCH_U32=m
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
# CONFIG_IP_VS_FO is not set
# CONFIG_IP_VS_OVF is not set
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
# CONFIG_NF_TABLES_IPV4 is not set
# CONFIG_NF_TABLES_ARP is not set
CONFIG_NF_DUP_IPV4=m
# CONFIG_NF_LOG_ARP is not set
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
CONFIG_IP_NF_TARGET_CLUSTERIP=m
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
# CONFIG_NF_TABLES_IPV6 is not set
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
CONFIG_IP6_NF_TARGET_HL=m
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
# CONFIG_NF_TABLES_BRIDGE is not set
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
CONFIG_IP_DCCP=m
CONFIG_INET_DCCP_DIAG=m

#
# DCCP CCIDs Configuration
#
# CONFIG_IP_DCCP_CCID2_DEBUG is not set
CONFIG_IP_DCCP_CCID3=y
# CONFIG_IP_DCCP_CCID3_DEBUG is not set
CONFIG_IP_DCCP_TFRC_LIB=y
# end of DCCP CCIDs Configuration

#
# DCCP Kernel Hacking
#
# CONFIG_IP_DCCP_DEBUG is not set
# end of DCCP Kernel Hacking

CONFIG_IP_SCTP=m
# CONFIG_SCTP_DBG_OBJCNT is not set
# CONFIG_SCTP_DEFAULT_COOKIE_HMAC_MD5 is not set
CONFIG_SCTP_DEFAULT_COOKIE_HMAC_SHA1=y
# CONFIG_SCTP_DEFAULT_COOKIE_HMAC_NONE is not set
CONFIG_SCTP_COOKIE_HMAC_MD5=y
CONFIG_SCTP_COOKIE_HMAC_SHA1=y
CONFIG_INET_SCTP_DIAG=m
# CONFIG_RDS is not set
# CONFIG_TIPC is not set
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
CONFIG_6LOWPAN_NHC=m
CONFIG_6LOWPAN_NHC_DEST=m
CONFIG_6LOWPAN_NHC_FRAGMENT=m
CONFIG_6LOWPAN_NHC_HOP=m
CONFIG_6LOWPAN_NHC_IPV6=m
CONFIG_6LOWPAN_NHC_MOBILITY=m
CONFIG_6LOWPAN_NHC_ROUTING=m
CONFIG_6LOWPAN_NHC_UDP=m
# CONFIG_6LOWPAN_GHC_EXT_HDR_HOP is not set
# CONFIG_6LOWPAN_GHC_UDP is not set
# CONFIG_6LOWPAN_GHC_ICMPV6 is not set
# CONFIG_6LOWPAN_GHC_EXT_HDR_DEST is not set
# CONFIG_6LOWPAN_GHC_EXT_HDR_FRAG is not set
# CONFIG_6LOWPAN_GHC_EXT_HDR_ROUTE is not set
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
CONFIG_NET_SCH_FQ_CODEL=m
# CONFIG_NET_SCH_CAKE is not set
CONFIG_NET_SCH_FQ=m
# CONFIG_NET_SCH_HHF is not set
# CONFIG_NET_SCH_PIE is not set
CONFIG_NET_SCH_INGRESS=m
CONFIG_NET_SCH_PLUG=m
# CONFIG_NET_SCH_ETS is not set
# CONFIG_NET_SCH_DEFAULT is not set

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
CONFIG_NET_ACT_IPT=m
CONFIG_NET_ACT_NAT=m
CONFIG_NET_ACT_PEDIT=m
CONFIG_NET_ACT_SIMP=m
CONFIG_NET_ACT_SKBEDIT=m
CONFIG_NET_ACT_CSUM=m
# CONFIG_NET_ACT_MPLS is not set
CONFIG_NET_ACT_VLAN=m
# CONFIG_NET_ACT_BPF is not set
CONFIG_NET_ACT_CONNMARK=m
# CONFIG_NET_ACT_CTINFO is not set
CONFIG_NET_ACT_SKBMOD=m
# CONFIG_NET_ACT_IFE is not set
CONFIG_NET_ACT_TUNNEL_KEY=m
# CONFIG_NET_ACT_CT is not set
# CONFIG_NET_TC_SKB_EXT is not set
CONFIG_NET_SCH_FIFO=y
CONFIG_DCB=y
CONFIG_DNS_RESOLVER=m
# CONFIG_BATMAN_ADV is not set
CONFIG_OPENVSWITCH=m
CONFIG_OPENVSWITCH_GRE=m
CONFIG_OPENVSWITCH_VXLAN=m
CONFIG_OPENVSWITCH_GENEVE=m
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
CONFIG_NET_NSH=m
# CONFIG_HSR is not set
CONFIG_NET_SWITCHDEV=y
CONFIG_NET_L3_MASTER_DEV=y
# CONFIG_NET_NCSI is not set
CONFIG_RPS=y
CONFIG_RFS_ACCEL=y
CONFIG_XPS=y
# CONFIG_CGROUP_NET_PRIO is not set
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
CONFIG_CAN_8DEV_USB=m
CONFIG_CAN_EMS_USB=m
CONFIG_CAN_ESD_USB2=m
# CONFIG_CAN_GS_USB is not set
CONFIG_CAN_KVASER_USB=m
# CONFIG_CAN_MCBA_USB is not set
CONFIG_CAN_PEAK_USB=m
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
CONFIG_BT_CMTP=m
CONFIG_BT_HIDP=m
CONFIG_BT_HS=y
CONFIG_BT_LE=y
# CONFIG_BT_6LOWPAN is not set
# CONFIG_BT_LEDS is not set
# CONFIG_BT_SELFTEST is not set
CONFIG_BT_DEBUGFS=y

#
# Bluetooth device drivers
#
CONFIG_BT_INTEL=m
CONFIG_BT_BCM=m
CONFIG_BT_RTL=m
CONFIG_BT_HCIBTUSB=m
# CONFIG_BT_HCIBTUSB_AUTOSUSPEND is not set
CONFIG_BT_HCIBTUSB_BCM=y
# CONFIG_BT_HCIBTUSB_MTK is not set
CONFIG_BT_HCIBTUSB_RTL=y
CONFIG_BT_HCIBTSDIO=m
CONFIG_BT_HCIUART=m
CONFIG_BT_HCIUART_H4=y
CONFIG_BT_HCIUART_BCSP=y
CONFIG_BT_HCIUART_ATH3K=y
# CONFIG_BT_HCIUART_INTEL is not set
# CONFIG_BT_HCIUART_AG6XX is not set
CONFIG_BT_HCIBCM203X=m
CONFIG_BT_HCIBPA10X=m
CONFIG_BT_HCIBFUSB=m
CONFIG_BT_HCIVHCI=m
CONFIG_BT_MRVL=m
CONFIG_BT_MRVL_SDIO=m
CONFIG_BT_ATH3K=m
# CONFIG_BT_MTKSDIO is not set
# end of Bluetooth device drivers

# CONFIG_AF_RXRPC is not set
# CONFIG_AF_KCM is not set
CONFIG_STREAM_PARSER=y
CONFIG_FIB_RULES=y
CONFIG_WIRELESS=y
CONFIG_WIRELESS_EXT=y
CONFIG_WEXT_CORE=y
CONFIG_WEXT_PROC=y
CONFIG_WEXT_PRIV=y
CONFIG_CFG80211=m
# CONFIG_NL80211_TESTMODE is not set
# CONFIG_CFG80211_DEVELOPER_WARNINGS is not set
# CONFIG_CFG80211_CERTIFICATION_ONUS is not set
CONFIG_CFG80211_REQUIRE_SIGNED_REGDB=y
CONFIG_CFG80211_USE_KERNEL_REGDB_KEYS=y
CONFIG_CFG80211_DEFAULT_PS=y
# CONFIG_CFG80211_DEBUGFS is not set
CONFIG_CFG80211_CRDA_SUPPORT=y
CONFIG_CFG80211_WEXT=y
CONFIG_LIB80211=m
# CONFIG_LIB80211_DEBUG is not set
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
# CONFIG_PCIE_DPC is not set
# CONFIG_PCIE_PTM is not set
# CONFIG_PCIE_BW is not set
CONFIG_PCI_MSI=y
CONFIG_PCI_MSI_IRQ_DOMAIN=y
CONFIG_PCI_QUIRKS=y
# CONFIG_PCI_DEBUG is not set
# CONFIG_PCI_REALLOC_ENABLE_AUTO is not set
CONFIG_PCI_STUB=y
# CONFIG_PCI_PF_STUB is not set
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

CONFIG_PCCARD=y
# CONFIG_PCMCIA is not set
CONFIG_CARDBUS=y

#
# PC-card bridges
#
CONFIG_YENTA=m
CONFIG_YENTA_O2=y
CONFIG_YENTA_RICOH=y
CONFIG_YENTA_TI=y
CONFIG_YENTA_ENE_TUNE=y
CONFIG_YENTA_TOSHIBA=y
# CONFIG_RAPIDIO is not set

#
# Generic Driver Options
#
CONFIG_UEVENT_HELPER=y
CONFIG_UEVENT_HELPER_PATH=""
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

CONFIG_WANT_DEV_COREDUMP=y
CONFIG_ALLOW_DEV_COREDUMP=y
CONFIG_DEV_COREDUMP=y
# CONFIG_DEBUG_DRIVER is not set
# CONFIG_DEBUG_DEVRES is not set
# CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
# CONFIG_TEST_ASYNC_DRIVER_PROBE is not set
CONFIG_SYS_HYPERVISOR=y
CONFIG_GENERIC_CPU_AUTOPROBE=y
CONFIG_GENERIC_CPU_VULNERABILITIES=y
CONFIG_REGMAP=y
CONFIG_REGMAP_I2C=m
CONFIG_REGMAP_SPI=m
CONFIG_REGMAP_IRQ=y
CONFIG_DMA_SHARED_BUFFER=y
# CONFIG_DMA_FENCE_TRACE is not set
# end of Generic Driver Options

#
# Bus devices
#
# end of Bus devices

CONFIG_CONNECTOR=y
CONFIG_PROC_EVENTS=y
# CONFIG_GNSS is not set
CONFIG_MTD=m
# CONFIG_MTD_TESTS is not set

#
# Partition parsers
#
# CONFIG_MTD_AR7_PARTS is not set
# CONFIG_MTD_CMDLINE_PARTS is not set
# CONFIG_MTD_REDBOOT_PARTS is not set
# end of Partition parsers

#
# User Modules And Translation Layers
#
CONFIG_MTD_BLKDEVS=m
CONFIG_MTD_BLOCK=m
# CONFIG_MTD_BLOCK_RO is not set
# CONFIG_FTL is not set
# CONFIG_NFTL is not set
# CONFIG_INFTL is not set
# CONFIG_RFD_FTL is not set
# CONFIG_SSFDC is not set
# CONFIG_SM_FTL is not set
# CONFIG_MTD_OOPS is not set
# CONFIG_MTD_SWAP is not set
# CONFIG_MTD_PARTITIONED_MASTER is not set

#
# RAM/ROM/Flash chip drivers
#
# CONFIG_MTD_CFI is not set
# CONFIG_MTD_JEDECPROBE is not set
CONFIG_MTD_MAP_BANK_WIDTH_1=y
CONFIG_MTD_MAP_BANK_WIDTH_2=y
CONFIG_MTD_MAP_BANK_WIDTH_4=y
CONFIG_MTD_CFI_I1=y
CONFIG_MTD_CFI_I2=y
# CONFIG_MTD_RAM is not set
# CONFIG_MTD_ROM is not set
# CONFIG_MTD_ABSENT is not set
# end of RAM/ROM/Flash chip drivers

#
# Mapping drivers for chip access
#
# CONFIG_MTD_COMPLEX_MAPPINGS is not set
# CONFIG_MTD_INTEL_VR_NOR is not set
# CONFIG_MTD_PLATRAM is not set
# end of Mapping drivers for chip access

#
# Self-contained MTD device drivers
#
# CONFIG_MTD_PMC551 is not set
# CONFIG_MTD_DATAFLASH is not set
# CONFIG_MTD_MCHP23K256 is not set
# CONFIG_MTD_SST25L is not set
# CONFIG_MTD_SLRAM is not set
# CONFIG_MTD_PHRAM is not set
# CONFIG_MTD_MTDRAM is not set
# CONFIG_MTD_BLOCK2MTD is not set

#
# Disk-On-Chip Device Drivers
#
# CONFIG_MTD_DOCG3 is not set
# end of Self-contained MTD device drivers

# CONFIG_MTD_ONENAND is not set
# CONFIG_MTD_RAW_NAND is not set
# CONFIG_MTD_SPI_NAND is not set

#
# LPDDR & LPDDR2 PCM memory drivers
#
# CONFIG_MTD_LPDDR is not set
# end of LPDDR & LPDDR2 PCM memory drivers

# CONFIG_MTD_SPI_NOR is not set
CONFIG_MTD_UBI=m
CONFIG_MTD_UBI_WL_THRESHOLD=4096
CONFIG_MTD_UBI_BEB_LIMIT=20
# CONFIG_MTD_UBI_FASTMAP is not set
# CONFIG_MTD_UBI_GLUEBI is not set
# CONFIG_MTD_UBI_BLOCK is not set
# CONFIG_MTD_HYPERBUS is not set
# CONFIG_OF is not set
CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
CONFIG_PARPORT_SERIAL=m
# CONFIG_PARPORT_PC_FIFO is not set
# CONFIG_PARPORT_PC_SUPERIO is not set
# CONFIG_PARPORT_AX88796 is not set
CONFIG_PARPORT_1284=y
CONFIG_PARPORT_NOT_PC=y
CONFIG_PNP=y
# CONFIG_PNP_DEBUG_MESSAGES is not set

#
# Protocols
#
CONFIG_PNPACPI=y
CONFIG_BLK_DEV=y
CONFIG_BLK_DEV_NULL_BLK=m
CONFIG_BLK_DEV_NULL_BLK_FAULT_INJECTION=y
CONFIG_BLK_DEV_FD=m
CONFIG_CDROM=m
# CONFIG_PARIDE is not set
CONFIG_BLK_DEV_PCIESSD_MTIP32XX=m
# CONFIG_ZRAM is not set
# CONFIG_BLK_DEV_UMEM is not set
CONFIG_BLK_DEV_LOOP=m
CONFIG_BLK_DEV_LOOP_MIN_COUNT=0
# CONFIG_BLK_DEV_CRYPTOLOOP is not set
# CONFIG_BLK_DEV_DRBD is not set
CONFIG_BLK_DEV_NBD=m
# CONFIG_BLK_DEV_SKD is not set
CONFIG_BLK_DEV_SX8=m
CONFIG_BLK_DEV_RAM=m
CONFIG_BLK_DEV_RAM_COUNT=16
CONFIG_BLK_DEV_RAM_SIZE=16384
CONFIG_CDROM_PKTCDVD=m
CONFIG_CDROM_PKTCDVD_BUFFERS=8
# CONFIG_CDROM_PKTCDVD_WCACHE is not set
CONFIG_ATA_OVER_ETH=m
CONFIG_XEN_BLKDEV_FRONTEND=m
CONFIG_VIRTIO_BLK=y
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
CONFIG_PVPANIC=y
# CONFIG_C2PORT is not set

#
# EEPROM support
#
CONFIG_EEPROM_AT24=m
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
# CONFIG_MISC_RTSX_PCI is not set
# CONFIG_MISC_RTSX_USB is not set
# CONFIG_HABANA_AI is not set
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
CONFIG_BLK_DEV_SR_VENDOR=y
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
CONFIG_ISCSI_TCP=m
CONFIG_ISCSI_BOOT_SYSFS=m
CONFIG_SCSI_CXGB3_ISCSI=m
CONFIG_SCSI_CXGB4_ISCSI=m
CONFIG_SCSI_BNX2_ISCSI=m
CONFIG_SCSI_BNX2X_FCOE=m
CONFIG_BE2ISCSI=m
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
CONFIG_SCSI_HPSA=m
CONFIG_SCSI_3W_9XXX=m
CONFIG_SCSI_3W_SAS=m
# CONFIG_SCSI_ACARD is not set
CONFIG_SCSI_AACRAID=m
# CONFIG_SCSI_AIC7XXX is not set
CONFIG_SCSI_AIC79XX=m
CONFIG_AIC79XX_CMDS_PER_DEVICE=4
CONFIG_AIC79XX_RESET_DELAY_MS=15000
# CONFIG_AIC79XX_DEBUG_ENABLE is not set
CONFIG_AIC79XX_DEBUG_MASK=0
# CONFIG_AIC79XX_REG_PRETTY_PRINT is not set
# CONFIG_SCSI_AIC94XX is not set
CONFIG_SCSI_MVSAS=m
# CONFIG_SCSI_MVSAS_DEBUG is not set
CONFIG_SCSI_MVSAS_TASKLET=y
CONFIG_SCSI_MVUMI=m
# CONFIG_SCSI_DPT_I2O is not set
# CONFIG_SCSI_ADVANSYS is not set
CONFIG_SCSI_ARCMSR=m
# CONFIG_SCSI_ESAS2R is not set
# CONFIG_MEGARAID_NEWGEN is not set
# CONFIG_MEGARAID_LEGACY is not set
CONFIG_MEGARAID_SAS=m
CONFIG_SCSI_MPT3SAS=m
CONFIG_SCSI_MPT2SAS_MAX_SGE=128
CONFIG_SCSI_MPT3SAS_MAX_SGE=128
CONFIG_SCSI_MPT2SAS=m
# CONFIG_SCSI_SMARTPQI is not set
CONFIG_SCSI_UFSHCD=m
CONFIG_SCSI_UFSHCD_PCI=m
# CONFIG_SCSI_UFS_DWC_TC_PCI is not set
# CONFIG_SCSI_UFSHCD_PLATFORM is not set
# CONFIG_SCSI_UFS_BSG is not set
CONFIG_SCSI_HPTIOP=m
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_MYRB is not set
# CONFIG_SCSI_MYRS is not set
CONFIG_VMWARE_PVSCSI=m
# CONFIG_XEN_SCSI_FRONTEND is not set
CONFIG_HYPERV_STORAGE=m
CONFIG_LIBFC=m
CONFIG_LIBFCOE=m
CONFIG_FCOE=m
CONFIG_FCOE_FNIC=m
# CONFIG_SCSI_SNIC is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_FDOMAIN_PCI is not set
# CONFIG_SCSI_GDTH is not set
CONFIG_SCSI_ISCI=m
# CONFIG_SCSI_IPS is not set
CONFIG_SCSI_INITIO=m
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_PPA is not set
# CONFIG_SCSI_IMM is not set
CONFIG_SCSI_STEX=m
# CONFIG_SCSI_SYM53C8XX_2 is not set
# CONFIG_SCSI_IPR is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
CONFIG_SCSI_QLA_FC=m
CONFIG_TCM_QLA2XXX=m
# CONFIG_TCM_QLA2XXX_DEBUG is not set
CONFIG_SCSI_QLA_ISCSI=m
# CONFIG_QEDI is not set
# CONFIG_QEDF is not set
# CONFIG_SCSI_LPFC is not set
# CONFIG_SCSI_DC395x is not set
# CONFIG_SCSI_AM53C974 is not set
# CONFIG_SCSI_WD719X is not set
CONFIG_SCSI_DEBUG=m
CONFIG_SCSI_PMCRAID=m
CONFIG_SCSI_PM8001=m
# CONFIG_SCSI_BFA_FC is not set
CONFIG_SCSI_VIRTIO=m
# CONFIG_SCSI_CHELSIO_FCOE is not set
CONFIG_SCSI_DH=y
CONFIG_SCSI_DH_RDAC=y
CONFIG_SCSI_DH_HP_SW=y
CONFIG_SCSI_DH_EMC=y
CONFIG_SCSI_DH_ALUA=y
# end of SCSI device support

CONFIG_ATA=m
CONFIG_ATA_VERBOSE_ERROR=y
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
CONFIG_SATA_ACARD_AHCI=m
CONFIG_SATA_SIL24=m
CONFIG_ATA_SFF=y

#
# SFF controllers with custom DMA interface
#
CONFIG_PDC_ADMA=m
CONFIG_SATA_QSTOR=m
CONFIG_SATA_SX4=m
CONFIG_ATA_BMDMA=y

#
# SATA SFF controllers with BMDMA
#
CONFIG_ATA_PIIX=m
# CONFIG_SATA_DWC is not set
CONFIG_SATA_MV=m
CONFIG_SATA_NV=m
CONFIG_SATA_PROMISE=m
CONFIG_SATA_SIL=m
CONFIG_SATA_SIS=m
CONFIG_SATA_SVW=m
CONFIG_SATA_ULI=m
CONFIG_SATA_VIA=m
CONFIG_SATA_VITESSE=m

#
# PATA SFF controllers with BMDMA
#
CONFIG_PATA_ALI=m
CONFIG_PATA_AMD=m
CONFIG_PATA_ARTOP=m
CONFIG_PATA_ATIIXP=m
CONFIG_PATA_ATP867X=m
CONFIG_PATA_CMD64X=m
# CONFIG_PATA_CYPRESS is not set
# CONFIG_PATA_EFAR is not set
CONFIG_PATA_HPT366=m
CONFIG_PATA_HPT37X=m
CONFIG_PATA_HPT3X2N=m
CONFIG_PATA_HPT3X3=m
# CONFIG_PATA_HPT3X3_DMA is not set
CONFIG_PATA_IT8213=m
CONFIG_PATA_IT821X=m
CONFIG_PATA_JMICRON=m
CONFIG_PATA_MARVELL=m
CONFIG_PATA_NETCELL=m
CONFIG_PATA_NINJA32=m
# CONFIG_PATA_NS87415 is not set
CONFIG_PATA_OLDPIIX=m
# CONFIG_PATA_OPTIDMA is not set
CONFIG_PATA_PDC2027X=m
CONFIG_PATA_PDC_OLD=m
# CONFIG_PATA_RADISYS is not set
CONFIG_PATA_RDC=m
CONFIG_PATA_SCH=m
CONFIG_PATA_SERVERWORKS=m
CONFIG_PATA_SIL680=m
CONFIG_PATA_SIS=m
CONFIG_PATA_TOSHIBA=m
# CONFIG_PATA_TRIFLEX is not set
CONFIG_PATA_VIA=m
# CONFIG_PATA_WINBOND is not set

#
# PIO-only SFF controllers
#
# CONFIG_PATA_CMD640_PCI is not set
# CONFIG_PATA_MPIIX is not set
# CONFIG_PATA_NS87410 is not set
# CONFIG_PATA_OPTI is not set
# CONFIG_PATA_PLATFORM is not set
# CONFIG_PATA_RZ1000 is not set

#
# Generic fallback / legacy drivers
#
CONFIG_PATA_ACPI=m
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
# CONFIG_MD_CLUSTER is not set
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
# CONFIG_DM_WRITECACHE is not set
CONFIG_DM_ERA=m
# CONFIG_DM_CLONE is not set
CONFIG_DM_MIRROR=m
CONFIG_DM_LOG_USERSPACE=m
CONFIG_DM_RAID=m
CONFIG_DM_ZERO=m
CONFIG_DM_MULTIPATH=m
CONFIG_DM_MULTIPATH_QL=m
CONFIG_DM_MULTIPATH_ST=m
CONFIG_DM_DELAY=m
# CONFIG_DM_DUST is not set
CONFIG_DM_UEVENT=y
CONFIG_DM_FLAKEY=m
CONFIG_DM_VERITY=m
# CONFIG_DM_VERITY_VERIFY_ROOTHASH_SIG is not set
# CONFIG_DM_VERITY_FEC is not set
CONFIG_DM_SWITCH=m
CONFIG_DM_LOG_WRITES=m
# CONFIG_DM_INTEGRITY is not set
# CONFIG_DM_ZONED is not set
CONFIG_TARGET_CORE=m
CONFIG_TCM_IBLOCK=m
CONFIG_TCM_FILEIO=m
CONFIG_TCM_PSCSI=m
CONFIG_TCM_USER2=m
CONFIG_LOOPBACK_TARGET=m
CONFIG_TCM_FC=m
CONFIG_ISCSI_TARGET=m
CONFIG_ISCSI_TARGET_CXGB4=m
# CONFIG_SBP_TARGET is not set
CONFIG_FUSION=y
CONFIG_FUSION_SPI=m
# CONFIG_FUSION_FC is not set
CONFIG_FUSION_SAS=m
CONFIG_FUSION_MAX_SGE=128
CONFIG_FUSION_CTL=m
CONFIG_FUSION_LOGGING=y

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
CONFIG_BONDING=m
CONFIG_DUMMY=m
# CONFIG_WIREGUARD is not set
# CONFIG_EQUALIZER is not set
CONFIG_NET_FC=y
CONFIG_IFB=m
CONFIG_NET_TEAM=m
CONFIG_NET_TEAM_MODE_BROADCAST=m
CONFIG_NET_TEAM_MODE_ROUNDROBIN=m
CONFIG_NET_TEAM_MODE_RANDOM=m
CONFIG_NET_TEAM_MODE_ACTIVEBACKUP=m
CONFIG_NET_TEAM_MODE_LOADBALANCE=m
CONFIG_MACVLAN=m
CONFIG_MACVTAP=m
# CONFIG_IPVLAN is not set
CONFIG_VXLAN=m
CONFIG_GENEVE=m
# CONFIG_GTP is not set
CONFIG_MACSEC=y
CONFIG_NETCONSOLE=m
CONFIG_NETCONSOLE_DYNAMIC=y
CONFIG_NETPOLL=y
CONFIG_NET_POLL_CONTROLLER=y
CONFIG_NTB_NETDEV=m
CONFIG_TUN=m
CONFIG_TAP=m
# CONFIG_TUN_VNET_CROSS_LE is not set
CONFIG_VETH=m
CONFIG_VIRTIO_NET=m
CONFIG_NLMON=m
CONFIG_NET_VRF=y
CONFIG_VSOCKMON=m
# CONFIG_ARCNET is not set
# CONFIG_ATM_DRIVERS is not set

#
# Distributed Switch Architecture drivers
#
# end of Distributed Switch Architecture drivers

CONFIG_ETHERNET=y
CONFIG_MDIO=y
# CONFIG_NET_VENDOR_3COM is not set
# CONFIG_NET_VENDOR_ADAPTEC is not set
CONFIG_NET_VENDOR_AGERE=y
# CONFIG_ET131X is not set
CONFIG_NET_VENDOR_ALACRITECH=y
# CONFIG_SLICOSS is not set
# CONFIG_NET_VENDOR_ALTEON is not set
# CONFIG_ALTERA_TSE is not set
CONFIG_NET_VENDOR_AMAZON=y
CONFIG_ENA_ETHERNET=m
CONFIG_NET_VENDOR_AMD=y
CONFIG_AMD8111_ETH=m
CONFIG_PCNET32=m
CONFIG_AMD_XGBE=m
# CONFIG_AMD_XGBE_DCB is not set
CONFIG_AMD_XGBE_HAVE_ECC=y
CONFIG_NET_VENDOR_AQUANTIA=y
CONFIG_AQTION=m
CONFIG_NET_VENDOR_ARC=y
CONFIG_NET_VENDOR_ATHEROS=y
CONFIG_ATL2=m
CONFIG_ATL1=m
CONFIG_ATL1E=m
CONFIG_ATL1C=m
CONFIG_ALX=m
CONFIG_NET_VENDOR_AURORA=y
# CONFIG_AURORA_NB8800 is not set
CONFIG_NET_VENDOR_BROADCOM=y
CONFIG_B44=m
CONFIG_B44_PCI_AUTOSELECT=y
CONFIG_B44_PCICORE_AUTOSELECT=y
CONFIG_B44_PCI=y
# CONFIG_BCMGENET is not set
CONFIG_BNX2=m
CONFIG_CNIC=m
CONFIG_TIGON3=y
CONFIG_TIGON3_HWMON=y
CONFIG_BNX2X=m
CONFIG_BNX2X_SRIOV=y
# CONFIG_SYSTEMPORT is not set
CONFIG_BNXT=m
CONFIG_BNXT_SRIOV=y
CONFIG_BNXT_FLOWER_OFFLOAD=y
CONFIG_BNXT_DCB=y
CONFIG_BNXT_HWMON=y
CONFIG_NET_VENDOR_BROCADE=y
CONFIG_BNA=m
CONFIG_NET_VENDOR_CADENCE=y
CONFIG_MACB=m
CONFIG_MACB_USE_HWSTAMP=y
# CONFIG_MACB_PCI is not set
CONFIG_NET_VENDOR_CAVIUM=y
# CONFIG_THUNDER_NIC_PF is not set
# CONFIG_THUNDER_NIC_VF is not set
# CONFIG_THUNDER_NIC_BGX is not set
# CONFIG_THUNDER_NIC_RGX is not set
CONFIG_CAVIUM_PTP=y
CONFIG_LIQUIDIO=m
CONFIG_LIQUIDIO_VF=m
CONFIG_NET_VENDOR_CHELSIO=y
# CONFIG_CHELSIO_T1 is not set
CONFIG_CHELSIO_T3=m
CONFIG_CHELSIO_T4=m
# CONFIG_CHELSIO_T4_DCB is not set
CONFIG_CHELSIO_T4VF=m
CONFIG_CHELSIO_LIB=m
CONFIG_NET_VENDOR_CISCO=y
CONFIG_ENIC=m
CONFIG_NET_VENDOR_CORTINA=y
# CONFIG_CX_ECAT is not set
CONFIG_DNET=m
CONFIG_NET_VENDOR_DEC=y
CONFIG_NET_TULIP=y
CONFIG_DE2104X=m
CONFIG_DE2104X_DSL=0
CONFIG_TULIP=y
# CONFIG_TULIP_MWI is not set
CONFIG_TULIP_MMIO=y
# CONFIG_TULIP_NAPI is not set
CONFIG_DE4X5=m
CONFIG_WINBOND_840=m
CONFIG_DM9102=m
CONFIG_ULI526X=m
CONFIG_PCMCIA_XIRCOM=m
# CONFIG_NET_VENDOR_DLINK is not set
CONFIG_NET_VENDOR_EMULEX=y
CONFIG_BE2NET=m
CONFIG_BE2NET_HWMON=y
CONFIG_BE2NET_BE2=y
CONFIG_BE2NET_BE3=y
CONFIG_BE2NET_LANCER=y
CONFIG_BE2NET_SKYHAWK=y
CONFIG_NET_VENDOR_EZCHIP=y
CONFIG_NET_VENDOR_GOOGLE=y
# CONFIG_GVE is not set
CONFIG_NET_VENDOR_HUAWEI=y
# CONFIG_HINIC is not set
# CONFIG_NET_VENDOR_I825XX is not set
CONFIG_NET_VENDOR_INTEL=y
# CONFIG_E100 is not set
CONFIG_E1000=y
CONFIG_E1000E=y
CONFIG_E1000E_HWTS=y
CONFIG_IGB=y
CONFIG_IGB_HWMON=y
CONFIG_IGBVF=m
# CONFIG_IXGB is not set
CONFIG_IXGBE=y
CONFIG_IXGBE_HWMON=y
CONFIG_IXGBE_DCB=y
CONFIG_IXGBEVF=m
CONFIG_I40E=y
CONFIG_I40E_DCB=y
CONFIG_IAVF=m
CONFIG_I40EVF=m
# CONFIG_ICE is not set
CONFIG_FM10K=m
# CONFIG_IGC is not set
CONFIG_JME=m
CONFIG_NET_VENDOR_MARVELL=y
CONFIG_MVMDIO=m
CONFIG_SKGE=y
# CONFIG_SKGE_DEBUG is not set
CONFIG_SKGE_GENESIS=y
CONFIG_SKY2=m
# CONFIG_SKY2_DEBUG is not set
CONFIG_NET_VENDOR_MELLANOX=y
CONFIG_MLX4_EN=m
CONFIG_MLX4_EN_DCB=y
CONFIG_MLX4_CORE=m
CONFIG_MLX4_DEBUG=y
CONFIG_MLX4_CORE_GEN2=y
# CONFIG_MLX5_CORE is not set
# CONFIG_MLXSW_CORE is not set
# CONFIG_MLXFW is not set
# CONFIG_NET_VENDOR_MICREL is not set
# CONFIG_NET_VENDOR_MICROCHIP is not set
CONFIG_NET_VENDOR_MICROSEMI=y
# CONFIG_MSCC_OCELOT_SWITCH is not set
CONFIG_NET_VENDOR_MYRI=y
CONFIG_MYRI10GE=m
CONFIG_MYRI10GE_DCA=y
# CONFIG_FEALNX is not set
# CONFIG_NET_VENDOR_NATSEMI is not set
CONFIG_NET_VENDOR_NETERION=y
# CONFIG_S2IO is not set
# CONFIG_VXGE is not set
CONFIG_NET_VENDOR_NETRONOME=y
CONFIG_NFP=m
CONFIG_NFP_APP_FLOWER=y
CONFIG_NFP_APP_ABM_NIC=y
# CONFIG_NFP_DEBUG is not set
CONFIG_NET_VENDOR_NI=y
# CONFIG_NI_XGE_MANAGEMENT_ENET is not set
# CONFIG_NET_VENDOR_NVIDIA is not set
CONFIG_NET_VENDOR_OKI=y
CONFIG_ETHOC=m
CONFIG_NET_VENDOR_PACKET_ENGINES=y
# CONFIG_HAMACHI is not set
CONFIG_YELLOWFIN=m
CONFIG_NET_VENDOR_PENSANDO=y
# CONFIG_IONIC is not set
CONFIG_NET_VENDOR_QLOGIC=y
CONFIG_QLA3XXX=m
CONFIG_QLCNIC=m
CONFIG_QLCNIC_SRIOV=y
CONFIG_QLCNIC_DCB=y
CONFIG_QLCNIC_HWMON=y
CONFIG_NETXEN_NIC=m
CONFIG_QED=m
CONFIG_QED_SRIOV=y
CONFIG_QEDE=m
CONFIG_NET_VENDOR_QUALCOMM=y
# CONFIG_QCOM_EMAC is not set
# CONFIG_RMNET is not set
# CONFIG_NET_VENDOR_RDC is not set
CONFIG_NET_VENDOR_REALTEK=y
# CONFIG_ATP is not set
CONFIG_8139CP=y
CONFIG_8139TOO=y
# CONFIG_8139TOO_PIO is not set
# CONFIG_8139TOO_TUNE_TWISTER is not set
CONFIG_8139TOO_8129=y
# CONFIG_8139_OLD_RX_RESET is not set
CONFIG_R8169=y
CONFIG_NET_VENDOR_RENESAS=y
CONFIG_NET_VENDOR_ROCKER=y
CONFIG_ROCKER=m
CONFIG_NET_VENDOR_SAMSUNG=y
# CONFIG_SXGBE_ETH is not set
# CONFIG_NET_VENDOR_SEEQ is not set
CONFIG_NET_VENDOR_SOLARFLARE=y
CONFIG_SFC=m
CONFIG_SFC_MTD=y
CONFIG_SFC_MCDI_MON=y
CONFIG_SFC_SRIOV=y
CONFIG_SFC_MCDI_LOGGING=y
CONFIG_SFC_FALCON=m
CONFIG_SFC_FALCON_MTD=y
# CONFIG_NET_VENDOR_SILAN is not set
# CONFIG_NET_VENDOR_SIS is not set
CONFIG_NET_VENDOR_SMSC=y
CONFIG_EPIC100=m
# CONFIG_SMSC911X is not set
CONFIG_SMSC9420=m
CONFIG_NET_VENDOR_SOCIONEXT=y
# CONFIG_NET_VENDOR_STMICRO is not set
# CONFIG_NET_VENDOR_SUN is not set
CONFIG_NET_VENDOR_SYNOPSYS=y
# CONFIG_DWC_XLGMAC is not set
# CONFIG_NET_VENDOR_TEHUTI is not set
CONFIG_NET_VENDOR_TI=y
# CONFIG_TI_CPSW_PHY_SEL is not set
CONFIG_TLAN=m
# CONFIG_NET_VENDOR_VIA is not set
# CONFIG_NET_VENDOR_WIZNET is not set
CONFIG_NET_VENDOR_XILINX=y
# CONFIG_XILINX_AXI_EMAC is not set
# CONFIG_XILINX_LL_TEMAC is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_NET_SB1000 is not set
CONFIG_MDIO_DEVICE=y
CONFIG_MDIO_BUS=y
# CONFIG_MDIO_BCM_UNIMAC is not set
CONFIG_MDIO_BITBANG=m
# CONFIG_MDIO_GPIO is not set
# CONFIG_MDIO_MSCC_MIIM is not set
# CONFIG_MDIO_THUNDER is not set
CONFIG_PHYLINK=m
CONFIG_PHYLIB=y
CONFIG_SWPHY=y
# CONFIG_LED_TRIGGER_PHY is not set

#
# MII PHY device drivers
#
# CONFIG_SFP is not set
# CONFIG_ADIN_PHY is not set
CONFIG_AMD_PHY=m
# CONFIG_AQUANTIA_PHY is not set
# CONFIG_AX88796B_PHY is not set
# CONFIG_BCM7XXX_PHY is not set
CONFIG_BCM87XX_PHY=m
CONFIG_BCM_NET_PHYLIB=m
CONFIG_BROADCOM_PHY=m
# CONFIG_BCM84881_PHY is not set
CONFIG_CICADA_PHY=m
# CONFIG_CORTINA_PHY is not set
CONFIG_DAVICOM_PHY=m
# CONFIG_DP83822_PHY is not set
# CONFIG_DP83TC811_PHY is not set
# CONFIG_DP83848_PHY is not set
# CONFIG_DP83867_PHY is not set
# CONFIG_DP83869_PHY is not set
CONFIG_FIXED_PHY=y
CONFIG_ICPLUS_PHY=m
# CONFIG_INTEL_XWAY_PHY is not set
CONFIG_LSI_ET1011C_PHY=m
CONFIG_LXT_PHY=m
CONFIG_MARVELL_PHY=m
# CONFIG_MARVELL_10G_PHY is not set
CONFIG_MICREL_PHY=m
# CONFIG_MICROCHIP_PHY is not set
# CONFIG_MICROCHIP_T1_PHY is not set
# CONFIG_MICROSEMI_PHY is not set
CONFIG_NATIONAL_PHY=m
# CONFIG_NXP_TJA11XX_PHY is not set
CONFIG_QSEMI_PHY=m
CONFIG_REALTEK_PHY=y
# CONFIG_RENESAS_PHY is not set
# CONFIG_ROCKCHIP_PHY is not set
CONFIG_SMSC_PHY=m
CONFIG_STE10XP=m
# CONFIG_TERANETICS_PHY is not set
CONFIG_VITESSE_PHY=m
# CONFIG_XILINX_GMII2RGMII is not set
# CONFIG_MICREL_KS8995MA is not set
# CONFIG_PLIP is not set
CONFIG_PPP=m
CONFIG_PPP_BSDCOMP=m
CONFIG_PPP_DEFLATE=m
CONFIG_PPP_FILTER=y
CONFIG_PPP_MPPE=m
CONFIG_PPP_MULTILINK=y
CONFIG_PPPOATM=m
CONFIG_PPPOE=m
CONFIG_PPTP=m
CONFIG_PPPOL2TP=m
CONFIG_PPP_ASYNC=m
CONFIG_PPP_SYNC_TTY=m
CONFIG_SLIP=m
CONFIG_SLHC=m
CONFIG_SLIP_COMPRESSED=y
CONFIG_SLIP_SMART=y
# CONFIG_SLIP_MODE_SLIP6 is not set
CONFIG_USB_NET_DRIVERS=y
CONFIG_USB_CATC=y
CONFIG_USB_KAWETH=y
CONFIG_USB_PEGASUS=y
CONFIG_USB_RTL8150=y
CONFIG_USB_RTL8152=m
# CONFIG_USB_LAN78XX is not set
CONFIG_USB_USBNET=y
CONFIG_USB_NET_AX8817X=y
CONFIG_USB_NET_AX88179_178A=m
CONFIG_USB_NET_CDCETHER=y
CONFIG_USB_NET_CDC_EEM=y
CONFIG_USB_NET_CDC_NCM=m
CONFIG_USB_NET_HUAWEI_CDC_NCM=m
CONFIG_USB_NET_CDC_MBIM=m
CONFIG_USB_NET_DM9601=y
# CONFIG_USB_NET_SR9700 is not set
# CONFIG_USB_NET_SR9800 is not set
CONFIG_USB_NET_SMSC75XX=y
CONFIG_USB_NET_SMSC95XX=y
CONFIG_USB_NET_GL620A=y
CONFIG_USB_NET_NET1080=y
CONFIG_USB_NET_PLUSB=y
CONFIG_USB_NET_MCS7830=y
CONFIG_USB_NET_RNDIS_HOST=y
CONFIG_USB_NET_CDC_SUBSET_ENABLE=y
CONFIG_USB_NET_CDC_SUBSET=y
CONFIG_USB_ALI_M5632=y
CONFIG_USB_AN2720=y
CONFIG_USB_BELKIN=y
CONFIG_USB_ARMLINUX=y
CONFIG_USB_EPSON2888=y
CONFIG_USB_KC2190=y
CONFIG_USB_NET_ZAURUS=y
CONFIG_USB_NET_CX82310_ETH=m
CONFIG_USB_NET_KALMIA=m
CONFIG_USB_NET_QMI_WWAN=m
CONFIG_USB_HSO=m
CONFIG_USB_NET_INT51X1=y
CONFIG_USB_IPHETH=y
CONFIG_USB_SIERRA_NET=y
CONFIG_USB_VL600=m
# CONFIG_USB_NET_CH9200 is not set
# CONFIG_USB_NET_AQC111 is not set
CONFIG_WLAN=y
# CONFIG_WIRELESS_WDS is not set
CONFIG_WLAN_VENDOR_ADMTEK=y
# CONFIG_ADM8211 is not set
CONFIG_ATH_COMMON=m
CONFIG_WLAN_VENDOR_ATH=y
# CONFIG_ATH_DEBUG is not set
# CONFIG_ATH5K is not set
# CONFIG_ATH5K_PCI is not set
CONFIG_ATH9K_HW=m
CONFIG_ATH9K_COMMON=m
CONFIG_ATH9K_BTCOEX_SUPPORT=y
# CONFIG_ATH9K is not set
CONFIG_ATH9K_HTC=m
# CONFIG_ATH9K_HTC_DEBUGFS is not set
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
CONFIG_IWLEGACY=m
CONFIG_IWL4965=m
CONFIG_IWL3945=m

#
# iwl3945 / iwl4965 Debugging Options
#
CONFIG_IWLEGACY_DEBUG=y
CONFIG_IWLEGACY_DEBUGFS=y
# end of iwl3945 / iwl4965 Debugging Options

CONFIG_IWLWIFI=m
CONFIG_IWLWIFI_LEDS=y
CONFIG_IWLDVM=m
CONFIG_IWLMVM=m
CONFIG_IWLWIFI_OPMODE_MODULAR=y
# CONFIG_IWLWIFI_BCAST_FILTERING is not set

#
# Debugging Options
#
# CONFIG_IWLWIFI_DEBUG is not set
CONFIG_IWLWIFI_DEBUGFS=y
# CONFIG_IWLWIFI_DEVICE_TRACING is not set
# end of Debugging Options

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
CONFIG_WLAN_VENDOR_RALINK=y
# CONFIG_RT2X00 is not set
CONFIG_WLAN_VENDOR_REALTEK=y
# CONFIG_RTL8180 is not set
# CONFIG_RTL8187 is not set
# CONFIG_RTL_CARDS is not set
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
CONFIG_WAN=y
# CONFIG_LANMEDIA is not set
CONFIG_HDLC=m
CONFIG_HDLC_RAW=m
# CONFIG_HDLC_RAW_ETH is not set
CONFIG_HDLC_CISCO=m
CONFIG_HDLC_FR=m
CONFIG_HDLC_PPP=m

#
# X.25/LAPB support is disabled
#
# CONFIG_PCI200SYN is not set
# CONFIG_WANXL is not set
# CONFIG_PC300TOO is not set
# CONFIG_FARSYNC is not set
CONFIG_DLCI=m
CONFIG_DLCI_MAX=8
# CONFIG_SBNI is not set
CONFIG_IEEE802154_DRIVERS=m
CONFIG_IEEE802154_FAKELB=m
# CONFIG_IEEE802154_AT86RF230 is not set
# CONFIG_IEEE802154_MRF24J40 is not set
# CONFIG_IEEE802154_CC2520 is not set
# CONFIG_IEEE802154_ATUSB is not set
# CONFIG_IEEE802154_ADF7242 is not set
# CONFIG_IEEE802154_CA8210 is not set
# CONFIG_IEEE802154_MCR20A is not set
# CONFIG_IEEE802154_HWSIM is not set
CONFIG_XEN_NETDEV_FRONTEND=m
CONFIG_VMXNET3=m
CONFIG_FUJITSU_ES=m
CONFIG_HYPERV_NET=m
CONFIG_NETDEVSIM=m
CONFIG_NET_FAILOVER=m
CONFIG_ISDN=y
CONFIG_ISDN_CAPI=y
CONFIG_CAPI_TRACE=y
CONFIG_ISDN_CAPI_MIDDLEWARE=y
CONFIG_MISDN=m
CONFIG_MISDN_DSP=m
CONFIG_MISDN_L1OIP=m

#
# mISDN hardware drivers
#
CONFIG_MISDN_HFCPCI=m
CONFIG_MISDN_HFCMULTI=m
CONFIG_MISDN_HFCUSB=m
CONFIG_MISDN_AVMFRITZ=m
CONFIG_MISDN_SPEEDFAX=m
CONFIG_MISDN_INFINEON=m
CONFIG_MISDN_W6692=m
CONFIG_MISDN_NETJET=m
CONFIG_MISDN_HDLC=m
CONFIG_MISDN_IPAC=m
CONFIG_MISDN_ISAR=m
CONFIG_NVM=y
# CONFIG_NVM_PBLK is not set

#
# Input device support
#
CONFIG_INPUT=y
CONFIG_INPUT_LEDS=y
CONFIG_INPUT_FF_MEMLESS=y
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
# CONFIG_KEYBOARD_ADC is not set
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
CONFIG_MOUSE_APPLETOUCH=m
CONFIG_MOUSE_BCM5974=m
CONFIG_MOUSE_CYAPA=m
# CONFIG_MOUSE_ELAN_I2C is not set
CONFIG_MOUSE_VSXXXAA=m
# CONFIG_MOUSE_GPIO is not set
CONFIG_MOUSE_SYNAPTICS_I2C=m
CONFIG_MOUSE_SYNAPTICS_USB=m
# CONFIG_INPUT_JOYSTICK is not set
CONFIG_INPUT_TABLET=y
CONFIG_TABLET_USB_ACECAD=m
CONFIG_TABLET_USB_AIPTEK=m
CONFIG_TABLET_USB_GTCO=m
# CONFIG_TABLET_USB_HANWANG is not set
CONFIG_TABLET_USB_KBTAB=m
# CONFIG_TABLET_USB_PEGASUS is not set
# CONFIG_TABLET_SERIAL_WACOM4 is not set
CONFIG_INPUT_TOUCHSCREEN=y
CONFIG_TOUCHSCREEN_PROPERTIES=y
# CONFIG_TOUCHSCREEN_ADS7846 is not set
# CONFIG_TOUCHSCREEN_AD7877 is not set
# CONFIG_TOUCHSCREEN_AD7879 is not set
# CONFIG_TOUCHSCREEN_ADC is not set
# CONFIG_TOUCHSCREEN_ATMEL_MXT is not set
# CONFIG_TOUCHSCREEN_AUO_PIXCIR is not set
# CONFIG_TOUCHSCREEN_BU21013 is not set
# CONFIG_TOUCHSCREEN_BU21029 is not set
# CONFIG_TOUCHSCREEN_CHIPONE_ICN8505 is not set
# CONFIG_TOUCHSCREEN_CY8CTMG110 is not set
# CONFIG_TOUCHSCREEN_CYTTSP_CORE is not set
# CONFIG_TOUCHSCREEN_CYTTSP4_CORE is not set
# CONFIG_TOUCHSCREEN_DYNAPRO is not set
# CONFIG_TOUCHSCREEN_HAMPSHIRE is not set
# CONFIG_TOUCHSCREEN_EETI is not set
# CONFIG_TOUCHSCREEN_EGALAX_SERIAL is not set
# CONFIG_TOUCHSCREEN_EXC3000 is not set
# CONFIG_TOUCHSCREEN_FUJITSU is not set
# CONFIG_TOUCHSCREEN_GOODIX is not set
# CONFIG_TOUCHSCREEN_HIDEEP is not set
# CONFIG_TOUCHSCREEN_ILI210X is not set
# CONFIG_TOUCHSCREEN_S6SY761 is not set
# CONFIG_TOUCHSCREEN_GUNZE is not set
# CONFIG_TOUCHSCREEN_EKTF2127 is not set
# CONFIG_TOUCHSCREEN_ELAN is not set
CONFIG_TOUCHSCREEN_ELO=m
CONFIG_TOUCHSCREEN_WACOM_W8001=m
CONFIG_TOUCHSCREEN_WACOM_I2C=m
# CONFIG_TOUCHSCREEN_MAX11801 is not set
# CONFIG_TOUCHSCREEN_MCS5000 is not set
# CONFIG_TOUCHSCREEN_MMS114 is not set
# CONFIG_TOUCHSCREEN_MELFAS_MIP4 is not set
# CONFIG_TOUCHSCREEN_MTOUCH is not set
# CONFIG_TOUCHSCREEN_INEXIO is not set
# CONFIG_TOUCHSCREEN_MK712 is not set
# CONFIG_TOUCHSCREEN_PENMOUNT is not set
# CONFIG_TOUCHSCREEN_EDT_FT5X06 is not set
# CONFIG_TOUCHSCREEN_TOUCHRIGHT is not set
# CONFIG_TOUCHSCREEN_TOUCHWIN is not set
# CONFIG_TOUCHSCREEN_PIXCIR is not set
# CONFIG_TOUCHSCREEN_WDT87XX_I2C is not set
# CONFIG_TOUCHSCREEN_WM97XX is not set
# CONFIG_TOUCHSCREEN_USB_COMPOSITE is not set
# CONFIG_TOUCHSCREEN_TOUCHIT213 is not set
# CONFIG_TOUCHSCREEN_TSC_SERIO is not set
# CONFIG_TOUCHSCREEN_TSC2004 is not set
# CONFIG_TOUCHSCREEN_TSC2005 is not set
# CONFIG_TOUCHSCREEN_TSC2007 is not set
# CONFIG_TOUCHSCREEN_RM_TS is not set
# CONFIG_TOUCHSCREEN_SILEAD is not set
# CONFIG_TOUCHSCREEN_SIS_I2C is not set
# CONFIG_TOUCHSCREEN_ST1232 is not set
# CONFIG_TOUCHSCREEN_STMFTS is not set
# CONFIG_TOUCHSCREEN_SUR40 is not set
# CONFIG_TOUCHSCREEN_SURFACE3_SPI is not set
# CONFIG_TOUCHSCREEN_SX8654 is not set
# CONFIG_TOUCHSCREEN_TPS6507X is not set
# CONFIG_TOUCHSCREEN_ZET6223 is not set
# CONFIG_TOUCHSCREEN_ZFORCE is not set
# CONFIG_TOUCHSCREEN_ROHM_BU21023 is not set
# CONFIG_TOUCHSCREEN_IQS5XX is not set
CONFIG_INPUT_MISC=y
# CONFIG_INPUT_AD714X is not set
# CONFIG_INPUT_BMA150 is not set
# CONFIG_INPUT_E3X0_BUTTON is not set
# CONFIG_INPUT_MSM_VIBRATOR is not set
CONFIG_INPUT_PCSPKR=m
# CONFIG_INPUT_MMA8450 is not set
CONFIG_INPUT_APANEL=m
CONFIG_INPUT_GP2A=m
# CONFIG_INPUT_GPIO_BEEPER is not set
# CONFIG_INPUT_GPIO_DECODER is not set
# CONFIG_INPUT_GPIO_VIBRA is not set
CONFIG_INPUT_ATLAS_BTNS=m
CONFIG_INPUT_ATI_REMOTE2=m
CONFIG_INPUT_KEYSPAN_REMOTE=m
# CONFIG_INPUT_KXTJ9 is not set
CONFIG_INPUT_POWERMATE=m
CONFIG_INPUT_YEALINK=m
CONFIG_INPUT_CM109=m
CONFIG_INPUT_UINPUT=m
# CONFIG_INPUT_PCF8574 is not set
# CONFIG_INPUT_PWM_BEEPER is not set
# CONFIG_INPUT_PWM_VIBRA is not set
CONFIG_INPUT_GPIO_ROTARY_ENCODER=m
# CONFIG_INPUT_ADXL34X is not set
# CONFIG_INPUT_IMS_PCU is not set
# CONFIG_INPUT_CMA3000 is not set
CONFIG_INPUT_XEN_KBDDEV_FRONTEND=m
# CONFIG_INPUT_IDEAPAD_SLIDEBAR is not set
# CONFIG_INPUT_DRV260X_HAPTICS is not set
# CONFIG_INPUT_DRV2665_HAPTICS is not set
# CONFIG_INPUT_DRV2667_HAPTICS is not set
CONFIG_RMI4_CORE=m
# CONFIG_RMI4_I2C is not set
# CONFIG_RMI4_SPI is not set
CONFIG_RMI4_SMB=m
CONFIG_RMI4_F03=y
CONFIG_RMI4_F03_SERIO=m
CONFIG_RMI4_2D_SENSOR=y
CONFIG_RMI4_F11=y
CONFIG_RMI4_F12=y
CONFIG_RMI4_F30=y
# CONFIG_RMI4_F34 is not set
# CONFIG_RMI4_F54 is not set
# CONFIG_RMI4_F55 is not set

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
CONFIG_SERIAL_NONSTANDARD=y
# CONFIG_ROCKETPORT is not set
CONFIG_CYCLADES=m
# CONFIG_CYZ_INTR is not set
# CONFIG_MOXA_INTELLIO is not set
# CONFIG_MOXA_SMARTIO is not set
CONFIG_SYNCLINK=m
CONFIG_SYNCLINKMP=m
CONFIG_SYNCLINK_GT=m
CONFIG_NOZOMI=m
# CONFIG_ISI is not set
CONFIG_N_HDLC=m
CONFIG_N_GSM=m
# CONFIG_TRACE_SINK is not set
# CONFIG_NULL_TTY is not set
CONFIG_LDISC_AUTOLOAD=y
CONFIG_DEVMEM=y
# CONFIG_DEVKMEM is not set

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
CONFIG_SERIAL_8250_NR_UARTS=32
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
# end of Serial drivers

CONFIG_SERIAL_MCTRL_GPIO=y
# CONFIG_SERIAL_DEV_BUS is not set
# CONFIG_TTY_PRINTK is not set
CONFIG_PRINTER=m
# CONFIG_LP_CONSOLE is not set
CONFIG_PPDEV=m
CONFIG_HVC_DRIVER=y
CONFIG_HVC_IRQ=y
CONFIG_HVC_XEN=y
CONFIG_HVC_XEN_FRONTEND=y
CONFIG_VIRTIO_CONSOLE=y
CONFIG_IPMI_HANDLER=m
CONFIG_IPMI_DMI_DECODE=y
CONFIG_IPMI_PLAT_DATA=y
# CONFIG_IPMI_PANIC_EVENT is not set
CONFIG_IPMI_DEVICE_INTERFACE=m
CONFIG_IPMI_SI=m
CONFIG_IPMI_SSIF=m
CONFIG_IPMI_WATCHDOG=m
CONFIG_IPMI_POWEROFF=m
CONFIG_HW_RANDOM=y
CONFIG_HW_RANDOM_TIMERIOMEM=m
CONFIG_HW_RANDOM_INTEL=m
CONFIG_HW_RANDOM_AMD=m
CONFIG_HW_RANDOM_VIA=m
CONFIG_HW_RANDOM_VIRTIO=y
CONFIG_NVRAM=y
# CONFIG_APPLICOM is not set
# CONFIG_MWAVE is not set
CONFIG_RAW_DRIVER=y
CONFIG_MAX_RAW_DEVS=8192
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
CONFIG_DEVPORT=y
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
# CONFIG_I2C_MUX_MLXCPLD is not set
# end of Multiplexer I2C Chip support

CONFIG_I2C_HELPER_AUTO=y
CONFIG_I2C_SMBUS=m
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
CONFIG_I2C_I801=m
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
CONFIG_I2C_DESIGNWARE_PLATFORM=m
# CONFIG_I2C_DESIGNWARE_SLAVE is not set
# CONFIG_I2C_DESIGNWARE_PCI is not set
# CONFIG_I2C_DESIGNWARE_BAYTRAIL is not set
# CONFIG_I2C_EMEV2 is not set
# CONFIG_I2C_GPIO is not set
# CONFIG_I2C_OCORES is not set
CONFIG_I2C_PCA_PLATFORM=m
CONFIG_I2C_SIMTEC=m
# CONFIG_I2C_XILINX is not set

#
# External I2C/SMBus adapter drivers
#
CONFIG_I2C_DIOLAN_U2C=m
CONFIG_I2C_PARPORT=m
# CONFIG_I2C_ROBOTFUZZ_OSIF is not set
# CONFIG_I2C_TAOS_EVM is not set
CONFIG_I2C_TINY_USB=m
CONFIG_I2C_VIPERBOARD=m

#
# Other I2C/SMBus bus drivers
#
# CONFIG_I2C_MLXCPLD is not set
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
# CONFIG_SPI_OC_TINY is not set
CONFIG_SPI_PXA2XX=m
CONFIG_SPI_PXA2XX_PCI=m
# CONFIG_SPI_ROCKCHIP is not set
# CONFIG_SPI_SC18IS602 is not set
# CONFIG_SPI_SIFIVE is not set
# CONFIG_SPI_MXIC is not set
# CONFIG_SPI_XCOMM is not set
# CONFIG_SPI_XILINX is not set
# CONFIG_SPI_ZYNQMP_GQSPI is not set

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
CONFIG_DP83640_PHY=m
# CONFIG_PTP_1588_CLOCK_INES is not set
CONFIG_PTP_1588_CLOCK_KVM=m
# CONFIG_PTP_1588_CLOCK_IDTCM is not set
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
# CONFIG_PINCTRL_BROXTON is not set
CONFIG_PINCTRL_CANNONLAKE=m
# CONFIG_PINCTRL_CEDARFORK is not set
CONFIG_PINCTRL_DENVERTON=m
CONFIG_PINCTRL_GEMINILAKE=m
# CONFIG_PINCTRL_ICELAKE is not set
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
CONFIG_GPIO_VIPERBOARD=m
# end of USB GPIO expanders

CONFIG_GPIO_MOCKUP=y
# CONFIG_W1 is not set
# CONFIG_POWER_AVS is not set
CONFIG_POWER_RESET=y
# CONFIG_POWER_RESET_RESTART is not set
CONFIG_POWER_SUPPLY=y
# CONFIG_POWER_SUPPLY_DEBUG is not set
CONFIG_POWER_SUPPLY_HWMON=y
# CONFIG_PDA_POWER is not set
# CONFIG_GENERIC_ADC_BATTERY is not set
# CONFIG_TEST_POWER is not set
# CONFIG_CHARGER_ADP5061 is not set
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
CONFIG_SENSORS_K8TEMP=m
CONFIG_SENSORS_K10TEMP=m
CONFIG_SENSORS_FAM15H_POWER=m
CONFIG_SENSORS_APPLESMC=m
CONFIG_SENSORS_ASB100=m
# CONFIG_SENSORS_ASPEED is not set
CONFIG_SENSORS_ATXP1=m
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
# CONFIG_SENSORS_IIO_HWMON is not set
# CONFIG_SENSORS_I5500 is not set
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
# CONFIG_CLOCK_THERMAL is not set
# CONFIG_DEVFREQ_THERMAL is not set
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

# CONFIG_INTEL_PCH_THERMAL is not set
# end of Intel thermal drivers

# CONFIG_GENERIC_ADC_THERMAL is not set
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
CONFIG_USBPCWATCHDOG=m
CONFIG_SSB_POSSIBLE=y
CONFIG_SSB=m
CONFIG_SSB_SPROM=y
CONFIG_SSB_PCIHOST_POSSIBLE=y
CONFIG_SSB_PCIHOST=y
CONFIG_SSB_SDIOHOST_POSSIBLE=y
CONFIG_SSB_SDIOHOST=y
CONFIG_SSB_DRIVER_PCICORE_POSSIBLE=y
CONFIG_SSB_DRIVER_PCICORE=y
CONFIG_SSB_DRIVER_GPIO=y
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
# CONFIG_HTC_PASIC3 is not set
# CONFIG_HTC_I2CPLD is not set
# CONFIG_MFD_INTEL_QUARK_I2C_GPIO is not set
CONFIG_LPC_ICH=m
CONFIG_LPC_SCH=m
# CONFIG_INTEL_SOC_PMIC_CHTDC_TI is not set
CONFIG_MFD_INTEL_LPSS=y
CONFIG_MFD_INTEL_LPSS_ACPI=y
CONFIG_MFD_INTEL_LPSS_PCI=y
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
# CONFIG_MFD_MT6397 is not set
# CONFIG_MFD_MENF21BMC is not set
# CONFIG_EZX_PCAP is not set
CONFIG_MFD_VIPERBOARD=m
# CONFIG_MFD_RETU is not set
# CONFIG_MFD_PCF50633 is not set
# CONFIG_UCB1400_CORE is not set
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
CONFIG_IR_SHARP_DECODER=m
CONFIG_IR_MCE_KBD_DECODER=m
# CONFIG_IR_XMP_DECODER is not set
CONFIG_IR_IMON_DECODER=m
# CONFIG_IR_RCMM_DECODER is not set
CONFIG_RC_DEVICES=y
CONFIG_RC_ATI_REMOTE=m
CONFIG_IR_ENE=m
CONFIG_IR_IMON=m
# CONFIG_IR_IMON_RAW is not set
CONFIG_IR_MCEUSB=m
CONFIG_IR_ITE_CIR=m
CONFIG_IR_FINTEK=m
CONFIG_IR_NUVOTON=m
CONFIG_IR_REDRAT3=m
CONFIG_IR_STREAMZAP=m
CONFIG_IR_WINBOND_CIR=m
# CONFIG_IR_IGORPLUGUSB is not set
CONFIG_IR_IGUANA=m
CONFIG_IR_TTUSBIR=m
CONFIG_RC_LOOPBACK=m
# CONFIG_IR_SERIAL is not set
# CONFIG_IR_SIR is not set
# CONFIG_RC_XBOX_DVD is not set
CONFIG_MEDIA_SUPPORT=m

#
# Multimedia core support
#
CONFIG_MEDIA_CAMERA_SUPPORT=y
CONFIG_MEDIA_ANALOG_TV_SUPPORT=y
CONFIG_MEDIA_DIGITAL_TV_SUPPORT=y
CONFIG_MEDIA_RADIO_SUPPORT=y
# CONFIG_MEDIA_SDR_SUPPORT is not set
# CONFIG_MEDIA_CEC_SUPPORT is not set
CONFIG_MEDIA_CONTROLLER=y
CONFIG_MEDIA_CONTROLLER_DVB=y
CONFIG_VIDEO_DEV=m
# CONFIG_VIDEO_V4L2_SUBDEV_API is not set
CONFIG_VIDEO_V4L2=m
CONFIG_VIDEO_V4L2_I2C=y
# CONFIG_VIDEO_ADV_DEBUG is not set
# CONFIG_VIDEO_FIXED_MINOR_RANGES is not set
CONFIG_VIDEO_TUNER=m
CONFIG_VIDEOBUF_GEN=m
CONFIG_VIDEOBUF_DMA_SG=m
CONFIG_VIDEOBUF_VMALLOC=m
CONFIG_DVB_CORE=m
# CONFIG_DVB_MMAP is not set
CONFIG_DVB_NET=y
CONFIG_TTPCI_EEPROM=m
CONFIG_DVB_MAX_ADAPTERS=8
CONFIG_DVB_DYNAMIC_MINORS=y
# CONFIG_DVB_DEMUX_SECTION_LOSS_LOG is not set
# CONFIG_DVB_ULE_DEBUG is not set

#
# Media drivers
#
CONFIG_MEDIA_USB_SUPPORT=y

#
# Webcam devices
#
CONFIG_USB_VIDEO_CLASS=m
CONFIG_USB_VIDEO_CLASS_INPUT_EVDEV=y
CONFIG_USB_GSPCA=m
CONFIG_USB_M5602=m
CONFIG_USB_STV06XX=m
CONFIG_USB_GL860=m
CONFIG_USB_GSPCA_BENQ=m
CONFIG_USB_GSPCA_CONEX=m
CONFIG_USB_GSPCA_CPIA1=m
# CONFIG_USB_GSPCA_DTCS033 is not set
CONFIG_USB_GSPCA_ETOMS=m
CONFIG_USB_GSPCA_FINEPIX=m
CONFIG_USB_GSPCA_JEILINJ=m
CONFIG_USB_GSPCA_JL2005BCD=m
# CONFIG_USB_GSPCA_KINECT is not set
CONFIG_USB_GSPCA_KONICA=m
CONFIG_USB_GSPCA_MARS=m
CONFIG_USB_GSPCA_MR97310A=m
CONFIG_USB_GSPCA_NW80X=m
CONFIG_USB_GSPCA_OV519=m
CONFIG_USB_GSPCA_OV534=m
CONFIG_USB_GSPCA_OV534_9=m
CONFIG_USB_GSPCA_PAC207=m
CONFIG_USB_GSPCA_PAC7302=m
CONFIG_USB_GSPCA_PAC7311=m
CONFIG_USB_GSPCA_SE401=m
CONFIG_USB_GSPCA_SN9C2028=m
CONFIG_USB_GSPCA_SN9C20X=m
CONFIG_USB_GSPCA_SONIXB=m
CONFIG_USB_GSPCA_SONIXJ=m
CONFIG_USB_GSPCA_SPCA500=m
CONFIG_USB_GSPCA_SPCA501=m
CONFIG_USB_GSPCA_SPCA505=m
CONFIG_USB_GSPCA_SPCA506=m
CONFIG_USB_GSPCA_SPCA508=m
CONFIG_USB_GSPCA_SPCA561=m
CONFIG_USB_GSPCA_SPCA1528=m
CONFIG_USB_GSPCA_SQ905=m
CONFIG_USB_GSPCA_SQ905C=m
CONFIG_USB_GSPCA_SQ930X=m
CONFIG_USB_GSPCA_STK014=m
# CONFIG_USB_GSPCA_STK1135 is not set
CONFIG_USB_GSPCA_STV0680=m
CONFIG_USB_GSPCA_SUNPLUS=m
CONFIG_USB_GSPCA_T613=m
CONFIG_USB_GSPCA_TOPRO=m
# CONFIG_USB_GSPCA_TOUPTEK is not set
CONFIG_USB_GSPCA_TV8532=m
CONFIG_USB_GSPCA_VC032X=m
CONFIG_USB_GSPCA_VICAM=m
CONFIG_USB_GSPCA_XIRLINK_CIT=m
CONFIG_USB_GSPCA_ZC3XX=m
CONFIG_USB_PWC=m
# CONFIG_USB_PWC_DEBUG is not set
CONFIG_USB_PWC_INPUT_EVDEV=y
# CONFIG_VIDEO_CPIA2 is not set
CONFIG_USB_ZR364XX=m
CONFIG_USB_STKWEBCAM=m
CONFIG_USB_S2255=m
# CONFIG_VIDEO_USBTV is not set

#
# Analog TV USB devices
#
CONFIG_VIDEO_PVRUSB2=m
CONFIG_VIDEO_PVRUSB2_SYSFS=y
CONFIG_VIDEO_PVRUSB2_DVB=y
# CONFIG_VIDEO_PVRUSB2_DEBUGIFC is not set
CONFIG_VIDEO_HDPVR=m
CONFIG_VIDEO_USBVISION=m
# CONFIG_VIDEO_STK1160_COMMON is not set
# CONFIG_VIDEO_GO7007 is not set

#
# Analog/digital TV USB devices
#
CONFIG_VIDEO_AU0828=m
CONFIG_VIDEO_AU0828_V4L2=y
# CONFIG_VIDEO_AU0828_RC is not set
CONFIG_VIDEO_CX231XX=m
CONFIG_VIDEO_CX231XX_RC=y
CONFIG_VIDEO_CX231XX_ALSA=m
CONFIG_VIDEO_CX231XX_DVB=m
CONFIG_VIDEO_TM6000=m
CONFIG_VIDEO_TM6000_ALSA=m
CONFIG_VIDEO_TM6000_DVB=m

#
# Digital TV USB devices
#
CONFIG_DVB_USB=m
# CONFIG_DVB_USB_DEBUG is not set
CONFIG_DVB_USB_DIB3000MC=m
CONFIG_DVB_USB_A800=m
CONFIG_DVB_USB_DIBUSB_MB=m
# CONFIG_DVB_USB_DIBUSB_MB_FAULTY is not set
CONFIG_DVB_USB_DIBUSB_MC=m
CONFIG_DVB_USB_DIB0700=m
CONFIG_DVB_USB_UMT_010=m
CONFIG_DVB_USB_CXUSB=m
# CONFIG_DVB_USB_CXUSB_ANALOG is not set
CONFIG_DVB_USB_M920X=m
CONFIG_DVB_USB_DIGITV=m
CONFIG_DVB_USB_VP7045=m
CONFIG_DVB_USB_VP702X=m
CONFIG_DVB_USB_GP8PSK=m
CONFIG_DVB_USB_NOVA_T_USB2=m
CONFIG_DVB_USB_TTUSB2=m
CONFIG_DVB_USB_DTT200U=m
CONFIG_DVB_USB_OPERA1=m
CONFIG_DVB_USB_AF9005=m
CONFIG_DVB_USB_AF9005_REMOTE=m
CONFIG_DVB_USB_PCTV452E=m
CONFIG_DVB_USB_DW2102=m
CONFIG_DVB_USB_CINERGY_T2=m
CONFIG_DVB_USB_DTV5100=m
CONFIG_DVB_USB_AZ6027=m
CONFIG_DVB_USB_TECHNISAT_USB2=m
CONFIG_DVB_USB_V2=m
CONFIG_DVB_USB_AF9015=m
CONFIG_DVB_USB_AF9035=m
CONFIG_DVB_USB_ANYSEE=m
CONFIG_DVB_USB_AU6610=m
CONFIG_DVB_USB_AZ6007=m
CONFIG_DVB_USB_CE6230=m
CONFIG_DVB_USB_EC168=m
CONFIG_DVB_USB_GL861=m
CONFIG_DVB_USB_LME2510=m
CONFIG_DVB_USB_MXL111SF=m
CONFIG_DVB_USB_RTL28XXU=m
# CONFIG_DVB_USB_DVBSKY is not set
# CONFIG_DVB_USB_ZD1301 is not set
CONFIG_DVB_TTUSB_BUDGET=m
CONFIG_DVB_TTUSB_DEC=m
CONFIG_SMS_USB_DRV=m
CONFIG_DVB_B2C2_FLEXCOP_USB=m
# CONFIG_DVB_B2C2_FLEXCOP_USB_DEBUG is not set
# CONFIG_DVB_AS102 is not set

#
# Webcam, TV (analog/digital) USB devices
#
CONFIG_VIDEO_EM28XX=m
# CONFIG_VIDEO_EM28XX_V4L2 is not set
CONFIG_VIDEO_EM28XX_ALSA=m
CONFIG_VIDEO_EM28XX_DVB=m
CONFIG_VIDEO_EM28XX_RC=m
CONFIG_MEDIA_PCI_SUPPORT=y

#
# Media capture support
#
# CONFIG_VIDEO_MEYE is not set
# CONFIG_VIDEO_SOLO6X10 is not set
# CONFIG_VIDEO_TW5864 is not set
# CONFIG_VIDEO_TW68 is not set
# CONFIG_VIDEO_TW686X is not set

#
# Media capture/analog TV support
#
CONFIG_VIDEO_IVTV=m
# CONFIG_VIDEO_IVTV_DEPRECATED_IOCTLS is not set
# CONFIG_VIDEO_IVTV_ALSA is not set
CONFIG_VIDEO_FB_IVTV=m
# CONFIG_VIDEO_FB_IVTV_FORCE_PAT is not set
# CONFIG_VIDEO_HEXIUM_GEMINI is not set
# CONFIG_VIDEO_HEXIUM_ORION is not set
# CONFIG_VIDEO_MXB is not set
# CONFIG_VIDEO_DT3155 is not set

#
# Media capture/analog/hybrid TV support
#
CONFIG_VIDEO_CX18=m
CONFIG_VIDEO_CX18_ALSA=m
CONFIG_VIDEO_CX23885=m
CONFIG_MEDIA_ALTERA_CI=m
# CONFIG_VIDEO_CX25821 is not set
CONFIG_VIDEO_CX88=m
CONFIG_VIDEO_CX88_ALSA=m
CONFIG_VIDEO_CX88_BLACKBIRD=m
CONFIG_VIDEO_CX88_DVB=m
CONFIG_VIDEO_CX88_ENABLE_VP3054=y
CONFIG_VIDEO_CX88_VP3054=m
CONFIG_VIDEO_CX88_MPEG=m
CONFIG_VIDEO_BT848=m
CONFIG_DVB_BT8XX=m
CONFIG_VIDEO_SAA7134=m
CONFIG_VIDEO_SAA7134_ALSA=m
CONFIG_VIDEO_SAA7134_RC=y
CONFIG_VIDEO_SAA7134_DVB=m
CONFIG_VIDEO_SAA7164=m

#
# Media digital TV PCI Adapters
#
CONFIG_DVB_AV7110_IR=y
CONFIG_DVB_AV7110=m
CONFIG_DVB_AV7110_OSD=y
CONFIG_DVB_BUDGET_CORE=m
CONFIG_DVB_BUDGET=m
CONFIG_DVB_BUDGET_CI=m
CONFIG_DVB_BUDGET_AV=m
CONFIG_DVB_BUDGET_PATCH=m
CONFIG_DVB_B2C2_FLEXCOP_PCI=m
# CONFIG_DVB_B2C2_FLEXCOP_PCI_DEBUG is not set
CONFIG_DVB_PLUTO2=m
CONFIG_DVB_DM1105=m
CONFIG_DVB_PT1=m
# CONFIG_DVB_PT3 is not set
CONFIG_MANTIS_CORE=m
CONFIG_DVB_MANTIS=m
CONFIG_DVB_HOPPER=m
CONFIG_DVB_NGENE=m
CONFIG_DVB_DDBRIDGE=m
# CONFIG_DVB_DDBRIDGE_MSIENABLE is not set
# CONFIG_DVB_SMIPCIE is not set
# CONFIG_DVB_NETUP_UNIDVB is not set
# CONFIG_V4L_PLATFORM_DRIVERS is not set
# CONFIG_V4L_MEM2MEM_DRIVERS is not set
# CONFIG_V4L_TEST_DRIVERS is not set
# CONFIG_DVB_PLATFORM_DRIVERS is not set

#
# Supported MMC/SDIO adapters
#
CONFIG_SMS_SDIO_DRV=m
CONFIG_RADIO_ADAPTERS=y
CONFIG_RADIO_TEA575X=m
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

#
# Texas Instruments WL128x FM driver (ST based)
#
# end of Texas Instruments WL128x FM driver (ST based)

#
# Supported FireWire (IEEE 1394) Adapters
#
CONFIG_DVB_FIREDTV=m
CONFIG_DVB_FIREDTV_INPUT=y
CONFIG_MEDIA_COMMON_OPTIONS=y

#
# common driver options
#
CONFIG_VIDEO_CX2341X=m
CONFIG_VIDEO_TVEEPROM=m
CONFIG_CYPRESS_FIRMWARE=m
CONFIG_VIDEOBUF2_CORE=m
CONFIG_VIDEOBUF2_V4L2=m
CONFIG_VIDEOBUF2_MEMOPS=m
CONFIG_VIDEOBUF2_VMALLOC=m
CONFIG_VIDEOBUF2_DMA_SG=m
CONFIG_VIDEOBUF2_DVB=m
CONFIG_DVB_B2C2_FLEXCOP=m
CONFIG_VIDEO_SAA7146=m
CONFIG_VIDEO_SAA7146_VV=m
CONFIG_SMS_SIANO_MDTV=m
CONFIG_SMS_SIANO_RC=y
# CONFIG_SMS_SIANO_DEBUGFS is not set

#
# Media ancillary drivers (tuners, sensors, i2c, spi, frontends)
#
CONFIG_MEDIA_SUBDRV_AUTOSELECT=y
CONFIG_MEDIA_ATTACH=y
CONFIG_VIDEO_IR_I2C=m

#
# I2C Encoders, decoders, sensors and other helper chips
#

#
# Audio decoders, processors and mixers
#
CONFIG_VIDEO_TVAUDIO=m
CONFIG_VIDEO_TDA7432=m
# CONFIG_VIDEO_TDA9840 is not set
# CONFIG_VIDEO_TEA6415C is not set
# CONFIG_VIDEO_TEA6420 is not set
CONFIG_VIDEO_MSP3400=m
CONFIG_VIDEO_CS3308=m
CONFIG_VIDEO_CS5345=m
CONFIG_VIDEO_CS53L32A=m
# CONFIG_VIDEO_TLV320AIC23B is not set
# CONFIG_VIDEO_UDA1342 is not set
CONFIG_VIDEO_WM8775=m
CONFIG_VIDEO_WM8739=m
CONFIG_VIDEO_VP27SMPX=m
# CONFIG_VIDEO_SONY_BTF_MPX is not set

#
# RDS decoders
#
CONFIG_VIDEO_SAA6588=m

#
# Video decoders
#
# CONFIG_VIDEO_ADV7183 is not set
# CONFIG_VIDEO_BT819 is not set
# CONFIG_VIDEO_BT856 is not set
# CONFIG_VIDEO_BT866 is not set
# CONFIG_VIDEO_KS0127 is not set
# CONFIG_VIDEO_ML86V7667 is not set
# CONFIG_VIDEO_SAA7110 is not set
CONFIG_VIDEO_SAA711X=m
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
CONFIG_VIDEO_SAA717X=m
CONFIG_VIDEO_CX25840=m

#
# Video encoders
#
CONFIG_VIDEO_SAA7127=m
# CONFIG_VIDEO_SAA7185 is not set
# CONFIG_VIDEO_ADV7170 is not set
# CONFIG_VIDEO_ADV7175 is not set
# CONFIG_VIDEO_ADV7343 is not set
# CONFIG_VIDEO_ADV7393 is not set
# CONFIG_VIDEO_AK881X is not set
# CONFIG_VIDEO_THS8200 is not set

#
# Camera sensor devices
#
# CONFIG_VIDEO_OV2640 is not set
# CONFIG_VIDEO_OV2659 is not set
# CONFIG_VIDEO_OV2680 is not set
# CONFIG_VIDEO_OV2685 is not set
# CONFIG_VIDEO_OV6650 is not set
# CONFIG_VIDEO_OV5695 is not set
# CONFIG_VIDEO_OV772X is not set
# CONFIG_VIDEO_OV7640 is not set
# CONFIG_VIDEO_OV7670 is not set
# CONFIG_VIDEO_OV7740 is not set
# CONFIG_VIDEO_OV9640 is not set
# CONFIG_VIDEO_VS6624 is not set
# CONFIG_VIDEO_MT9M111 is not set
# CONFIG_VIDEO_MT9T112 is not set
# CONFIG_VIDEO_MT9V011 is not set
# CONFIG_VIDEO_MT9V111 is not set
# CONFIG_VIDEO_SR030PC30 is not set
# CONFIG_VIDEO_RJ54N1 is not set

#
# Lens drivers
#
# CONFIG_VIDEO_AD5820 is not set

#
# Flash devices
#
# CONFIG_VIDEO_ADP1653 is not set
# CONFIG_VIDEO_LM3560 is not set
# CONFIG_VIDEO_LM3646 is not set

#
# Video improvement chips
#
CONFIG_VIDEO_UPD64031A=m
CONFIG_VIDEO_UPD64083=m

#
# Audio/Video compression chips
#
CONFIG_VIDEO_SAA6752HS=m

#
# SDR tuner chips
#

#
# Miscellaneous helper chips
#
# CONFIG_VIDEO_THS7303 is not set
CONFIG_VIDEO_M52790=m
# CONFIG_VIDEO_I2C is not set
# end of I2C Encoders, decoders, sensors and other helper chips

#
# SPI helper chips
#
# end of SPI helper chips

#
# Media SPI Adapters
#
# CONFIG_CXD2880_SPI_DRV is not set
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
# CONFIG_MEDIA_TUNER_MSI001 is not set
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
# CONFIG_MEDIA_TUNER_MXL301RF is not set
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
# CONFIG_DVB_S5H1432 is not set
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
# CONFIG_DVB_DIB9000 is not set
CONFIG_DVB_TDA10048=m
CONFIG_DVB_AF9013=m
CONFIG_DVB_EC100=m
CONFIG_DVB_STV0367=m
CONFIG_DVB_CXD2820R=m
CONFIG_DVB_CXD2841ER=m
CONFIG_DVB_RTL2830=m
CONFIG_DVB_RTL2832=m
CONFIG_DVB_SI2168=m
# CONFIG_DVB_ZD1301_DEMOD is not set
CONFIG_DVB_GP8PSK_FE=m
# CONFIG_DVB_CXD2880 is not set

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
# CONFIG_DVB_MN88443X is not set

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
# CONFIG_DVB_LNBH29 is not set
CONFIG_DVB_LNBP21=m
CONFIG_DVB_LNBP22=m
CONFIG_DVB_ISL6405=m
CONFIG_DVB_ISL6421=m
CONFIG_DVB_ISL6423=m
CONFIG_DVB_A8293=m
# CONFIG_DVB_LGS8GL5 is not set
CONFIG_DVB_LGS8GXX=m
CONFIG_DVB_ATBM8830=m
CONFIG_DVB_TDA665x=m
CONFIG_DVB_IX2505V=m
CONFIG_DVB_M88RS2000=m
CONFIG_DVB_AF9033=m
# CONFIG_DVB_HORUS3A is not set
# CONFIG_DVB_ASCOT2E is not set
# CONFIG_DVB_HELENE is not set

#
# Common Interface (EN50221) controller drivers
#
CONFIG_DVB_CXD2099=m
# CONFIG_DVB_SP2 is not set

#
# Tools to develop new frontends
#
CONFIG_DVB_DUMMY_FE=m
# end of Customise DVB Frontends

#
# Graphics support
#
CONFIG_AGP=y
CONFIG_AGP_AMD64=y
CONFIG_AGP_INTEL=y
CONFIG_AGP_SIS=y
CONFIG_AGP_VIA=y
CONFIG_INTEL_GTT=y
CONFIG_VGA_ARB=y
CONFIG_VGA_ARB_MAX_GPUS=64
CONFIG_VGA_SWITCHEROO=y
CONFIG_DRM=m
CONFIG_DRM_MIPI_DSI=y
CONFIG_DRM_DP_AUX_CHARDEV=y
CONFIG_DRM_EXPORT_FOR_TESTS=y
CONFIG_DRM_DEBUG_SELFTEST=m
CONFIG_DRM_KMS_HELPER=m
CONFIG_DRM_KMS_FB_HELPER=y
# CONFIG_DRM_DEBUG_DP_MST_TOPOLOGY_REFS is not set
CONFIG_DRM_FBDEV_EMULATION=y
CONFIG_DRM_FBDEV_OVERALLOC=100
# CONFIG_DRM_FBDEV_LEAK_PHYS_SMEM is not set
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

#
# ACP (Audio CoProcessor) Configuration
#
# end of ACP (Audio CoProcessor) Configuration

# CONFIG_DRM_NOUVEAU is not set
CONFIG_DRM_I915=m
# CONFIG_DRM_I915_ALPHA_SUPPORT is not set
CONFIG_DRM_I915_FORCE_PROBE=""
CONFIG_DRM_I915_CAPTURE_ERROR=y
CONFIG_DRM_I915_COMPRESS_ERROR=y
CONFIG_DRM_I915_USERPTR=y
CONFIG_DRM_I915_GVT=y
CONFIG_DRM_I915_GVT_KVMGT=m

#
# drm/i915 Debugging
#
# CONFIG_DRM_I915_WERROR is not set
# CONFIG_DRM_I915_DEBUG is not set
# CONFIG_DRM_I915_DEBUG_MMIO is not set
# CONFIG_DRM_I915_SW_FENCE_DEBUG_OBJECTS is not set
# CONFIG_DRM_I915_SW_FENCE_CHECK_DAG is not set
# CONFIG_DRM_I915_DEBUG_GUC is not set
# CONFIG_DRM_I915_SELFTEST is not set
# CONFIG_DRM_I915_LOW_LEVEL_TRACEPOINTS is not set
# CONFIG_DRM_I915_DEBUG_VBLANK_EVADE is not set
# CONFIG_DRM_I915_DEBUG_RUNTIME_PM is not set
# end of drm/i915 Debugging

#
# drm/i915 Profile Guided Optimisation
#
CONFIG_DRM_I915_USERFAULT_AUTOSUSPEND=250
CONFIG_DRM_I915_HEARTBEAT_INTERVAL=2500
CONFIG_DRM_I915_PREEMPT_TIMEOUT=640
CONFIG_DRM_I915_SPIN_REQUEST=5
CONFIG_DRM_I915_STOP_TIMEOUT=100
CONFIG_DRM_I915_TIMESLICE_DURATION=1
# end of drm/i915 Profile Guided Optimisation

CONFIG_DRM_VGEM=m
# CONFIG_DRM_VKMS is not set
CONFIG_DRM_VMWGFX=m
CONFIG_DRM_VMWGFX_FBCON=y
CONFIG_DRM_GMA500=m
CONFIG_DRM_GMA600=y
CONFIG_DRM_GMA3600=y
CONFIG_DRM_UDL=m
CONFIG_DRM_AST=m
CONFIG_DRM_MGAG200=m
CONFIG_DRM_CIRRUS_QEMU=m
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
# CONFIG_DRM_GM12U320 is not set
# CONFIG_TINYDRM_HX8357D is not set
# CONFIG_TINYDRM_ILI9225 is not set
# CONFIG_TINYDRM_ILI9341 is not set
# CONFIG_TINYDRM_MI0283QT is not set
# CONFIG_TINYDRM_REPAPER is not set
# CONFIG_TINYDRM_ST7586 is not set
# CONFIG_TINYDRM_ST7735R is not set
# CONFIG_DRM_XEN is not set
# CONFIG_DRM_VBOXVIDEO is not set
# CONFIG_DRM_LEGACY is not set
CONFIG_DRM_PANEL_ORIENTATION_QUIRKS=y
CONFIG_DRM_LIB_RANDOM=y

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
# CONFIG_FB_INTEL is not set
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

CONFIG_SOUND=m
CONFIG_SOUND_OSS_CORE=y
CONFIG_SOUND_OSS_CORE_PRECLAIM=y
CONFIG_SND=m
CONFIG_SND_TIMER=m
CONFIG_SND_PCM=m
CONFIG_SND_PCM_ELD=y
CONFIG_SND_HWDEP=m
CONFIG_SND_SEQ_DEVICE=m
CONFIG_SND_RAWMIDI=m
CONFIG_SND_COMPRESS_OFFLOAD=m
CONFIG_SND_JACK=y
CONFIG_SND_JACK_INPUT_DEV=y
CONFIG_SND_OSSEMUL=y
# CONFIG_SND_MIXER_OSS is not set
# CONFIG_SND_PCM_OSS is not set
CONFIG_SND_PCM_TIMER=y
CONFIG_SND_HRTIMER=m
CONFIG_SND_DYNAMIC_MINORS=y
CONFIG_SND_MAX_CARDS=32
# CONFIG_SND_SUPPORT_OLD_API is not set
CONFIG_SND_PROC_FS=y
CONFIG_SND_VERBOSE_PROCFS=y
# CONFIG_SND_VERBOSE_PRINTK is not set
# CONFIG_SND_DEBUG is not set
CONFIG_SND_VMASTER=y
CONFIG_SND_DMA_SGBUF=y
CONFIG_SND_SEQUENCER=m
CONFIG_SND_SEQ_DUMMY=m
CONFIG_SND_SEQUENCER_OSS=m
CONFIG_SND_SEQ_HRTIMER_DEFAULT=y
CONFIG_SND_SEQ_MIDI_EVENT=m
CONFIG_SND_SEQ_MIDI=m
CONFIG_SND_SEQ_MIDI_EMUL=m
CONFIG_SND_SEQ_VIRMIDI=m
CONFIG_SND_MPU401_UART=m
CONFIG_SND_OPL3_LIB=m
CONFIG_SND_OPL3_LIB_SEQ=m
CONFIG_SND_VX_LIB=m
CONFIG_SND_AC97_CODEC=m
CONFIG_SND_DRIVERS=y
CONFIG_SND_PCSP=m
CONFIG_SND_DUMMY=m
CONFIG_SND_ALOOP=m
CONFIG_SND_VIRMIDI=m
CONFIG_SND_MTPAV=m
# CONFIG_SND_MTS64 is not set
# CONFIG_SND_SERIAL_U16550 is not set
CONFIG_SND_MPU401=m
# CONFIG_SND_PORTMAN2X4 is not set
CONFIG_SND_AC97_POWER_SAVE=y
CONFIG_SND_AC97_POWER_SAVE_DEFAULT=5
CONFIG_SND_PCI=y
CONFIG_SND_AD1889=m
# CONFIG_SND_ALS300 is not set
# CONFIG_SND_ALS4000 is not set
CONFIG_SND_ALI5451=m
CONFIG_SND_ASIHPI=m
CONFIG_SND_ATIIXP=m
CONFIG_SND_ATIIXP_MODEM=m
CONFIG_SND_AU8810=m
CONFIG_SND_AU8820=m
CONFIG_SND_AU8830=m
# CONFIG_SND_AW2 is not set
# CONFIG_SND_AZT3328 is not set
CONFIG_SND_BT87X=m
# CONFIG_SND_BT87X_OVERCLOCK is not set
CONFIG_SND_CA0106=m
CONFIG_SND_CMIPCI=m
CONFIG_SND_OXYGEN_LIB=m
CONFIG_SND_OXYGEN=m
# CONFIG_SND_CS4281 is not set
CONFIG_SND_CS46XX=m
CONFIG_SND_CS46XX_NEW_DSP=y
CONFIG_SND_CTXFI=m
CONFIG_SND_DARLA20=m
CONFIG_SND_GINA20=m
CONFIG_SND_LAYLA20=m
CONFIG_SND_DARLA24=m
CONFIG_SND_GINA24=m
CONFIG_SND_LAYLA24=m
CONFIG_SND_MONA=m
CONFIG_SND_MIA=m
CONFIG_SND_ECHO3G=m
CONFIG_SND_INDIGO=m
CONFIG_SND_INDIGOIO=m
CONFIG_SND_INDIGODJ=m
CONFIG_SND_INDIGOIOX=m
CONFIG_SND_INDIGODJX=m
CONFIG_SND_EMU10K1=m
CONFIG_SND_EMU10K1_SEQ=m
CONFIG_SND_EMU10K1X=m
CONFIG_SND_ENS1370=m
CONFIG_SND_ENS1371=m
# CONFIG_SND_ES1938 is not set
CONFIG_SND_ES1968=m
CONFIG_SND_ES1968_INPUT=y
CONFIG_SND_ES1968_RADIO=y
# CONFIG_SND_FM801 is not set
CONFIG_SND_HDSP=m
CONFIG_SND_HDSPM=m
CONFIG_SND_ICE1712=m
CONFIG_SND_ICE1724=m
CONFIG_SND_INTEL8X0=m
CONFIG_SND_INTEL8X0M=m
CONFIG_SND_KORG1212=m
CONFIG_SND_LOLA=m
CONFIG_SND_LX6464ES=m
CONFIG_SND_MAESTRO3=m
CONFIG_SND_MAESTRO3_INPUT=y
CONFIG_SND_MIXART=m
# CONFIG_SND_NM256 is not set
CONFIG_SND_PCXHR=m
# CONFIG_SND_RIPTIDE is not set
CONFIG_SND_RME32=m
CONFIG_SND_RME96=m
CONFIG_SND_RME9652=m
# CONFIG_SND_SONICVIBES is not set
CONFIG_SND_TRIDENT=m
CONFIG_SND_VIA82XX=m
CONFIG_SND_VIA82XX_MODEM=m
CONFIG_SND_VIRTUOSO=m
CONFIG_SND_VX222=m
# CONFIG_SND_YMFPCI is not set

#
# HD-Audio
#
CONFIG_SND_HDA=m
CONFIG_SND_HDA_INTEL=m
CONFIG_SND_HDA_HWDEP=y
CONFIG_SND_HDA_RECONFIG=y
CONFIG_SND_HDA_INPUT_BEEP=y
CONFIG_SND_HDA_INPUT_BEEP_MODE=0
CONFIG_SND_HDA_PATCH_LOADER=y
CONFIG_SND_HDA_CODEC_REALTEK=m
CONFIG_SND_HDA_CODEC_ANALOG=m
CONFIG_SND_HDA_CODEC_SIGMATEL=m
CONFIG_SND_HDA_CODEC_VIA=m
CONFIG_SND_HDA_CODEC_HDMI=m
CONFIG_SND_HDA_CODEC_CIRRUS=m
CONFIG_SND_HDA_CODEC_CONEXANT=m
CONFIG_SND_HDA_CODEC_CA0110=m
CONFIG_SND_HDA_CODEC_CA0132=m
CONFIG_SND_HDA_CODEC_CA0132_DSP=y
CONFIG_SND_HDA_CODEC_CMEDIA=m
CONFIG_SND_HDA_CODEC_SI3054=m
CONFIG_SND_HDA_GENERIC=m
CONFIG_SND_HDA_POWER_SAVE_DEFAULT=0
# end of HD-Audio

CONFIG_SND_HDA_CORE=m
CONFIG_SND_HDA_DSP_LOADER=y
CONFIG_SND_HDA_COMPONENT=y
CONFIG_SND_HDA_I915=y
CONFIG_SND_HDA_EXT_CORE=m
CONFIG_SND_HDA_PREALLOC_SIZE=0
CONFIG_SND_INTEL_NHLT=y
CONFIG_SND_INTEL_DSP_CONFIG=m
# CONFIG_SND_SPI is not set
CONFIG_SND_USB=y
CONFIG_SND_USB_AUDIO=m
CONFIG_SND_USB_AUDIO_USE_MEDIA_CONTROLLER=y
CONFIG_SND_USB_UA101=m
CONFIG_SND_USB_USX2Y=m
CONFIG_SND_USB_CAIAQ=m
CONFIG_SND_USB_CAIAQ_INPUT=y
CONFIG_SND_USB_US122L=m
CONFIG_SND_USB_6FIRE=m
CONFIG_SND_USB_HIFACE=m
CONFIG_SND_BCD2000=m
CONFIG_SND_USB_LINE6=m
CONFIG_SND_USB_POD=m
CONFIG_SND_USB_PODHD=m
CONFIG_SND_USB_TONEPORT=m
CONFIG_SND_USB_VARIAX=m
CONFIG_SND_FIREWIRE=y
CONFIG_SND_FIREWIRE_LIB=m
# CONFIG_SND_DICE is not set
# CONFIG_SND_OXFW is not set
CONFIG_SND_ISIGHT=m
# CONFIG_SND_FIREWORKS is not set
# CONFIG_SND_BEBOB is not set
# CONFIG_SND_FIREWIRE_DIGI00X is not set
# CONFIG_SND_FIREWIRE_TASCAM is not set
# CONFIG_SND_FIREWIRE_MOTU is not set
# CONFIG_SND_FIREFACE is not set
CONFIG_SND_SOC=m
CONFIG_SND_SOC_COMPRESS=y
CONFIG_SND_SOC_TOPOLOGY=y
CONFIG_SND_SOC_ACPI=m
# CONFIG_SND_SOC_AMD_ACP is not set
# CONFIG_SND_SOC_AMD_ACP3x is not set
# CONFIG_SND_ATMEL_SOC is not set
# CONFIG_SND_DESIGNWARE_I2S is not set

#
# SoC Audio for Freescale CPUs
#

#
# Common SoC Audio options for Freescale CPUs:
#
# CONFIG_SND_SOC_FSL_ASRC is not set
# CONFIG_SND_SOC_FSL_SAI is not set
# CONFIG_SND_SOC_FSL_AUDMIX is not set
# CONFIG_SND_SOC_FSL_SSI is not set
# CONFIG_SND_SOC_FSL_SPDIF is not set
# CONFIG_SND_SOC_FSL_ESAI is not set
# CONFIG_SND_SOC_FSL_MICFIL is not set
# CONFIG_SND_SOC_IMX_AUDMUX is not set
# end of SoC Audio for Freescale CPUs

# CONFIG_SND_I2S_HI6210_I2S is not set
# CONFIG_SND_SOC_IMG is not set
CONFIG_SND_SOC_INTEL_SST_TOPLEVEL=y
CONFIG_SND_SST_IPC=m
CONFIG_SND_SST_IPC_ACPI=m
CONFIG_SND_SOC_INTEL_SST_ACPI=m
CONFIG_SND_SOC_INTEL_SST=m
CONFIG_SND_SOC_INTEL_SST_FIRMWARE=m
CONFIG_SND_SOC_INTEL_HASWELL=m
CONFIG_SND_SST_ATOM_HIFI2_PLATFORM=m
# CONFIG_SND_SST_ATOM_HIFI2_PLATFORM_PCI is not set
CONFIG_SND_SST_ATOM_HIFI2_PLATFORM_ACPI=m
CONFIG_SND_SOC_INTEL_SKYLAKE=m
CONFIG_SND_SOC_INTEL_SKL=m
CONFIG_SND_SOC_INTEL_APL=m
CONFIG_SND_SOC_INTEL_KBL=m
CONFIG_SND_SOC_INTEL_GLK=m
CONFIG_SND_SOC_INTEL_CNL=m
CONFIG_SND_SOC_INTEL_CFL=m
# CONFIG_SND_SOC_INTEL_CML_H is not set
# CONFIG_SND_SOC_INTEL_CML_LP is not set
CONFIG_SND_SOC_INTEL_SKYLAKE_FAMILY=m
CONFIG_SND_SOC_INTEL_SKYLAKE_SSP_CLK=m
# CONFIG_SND_SOC_INTEL_SKYLAKE_HDAUDIO_CODEC is not set
CONFIG_SND_SOC_INTEL_SKYLAKE_COMMON=m
CONFIG_SND_SOC_ACPI_INTEL_MATCH=m
CONFIG_SND_SOC_INTEL_MACH=y
# CONFIG_SND_SOC_INTEL_USER_FRIENDLY_LONG_NAMES is not set
CONFIG_SND_SOC_INTEL_HASWELL_MACH=m
# CONFIG_SND_SOC_INTEL_BDW_RT5650_MACH is not set
CONFIG_SND_SOC_INTEL_BDW_RT5677_MACH=m
CONFIG_SND_SOC_INTEL_BROADWELL_MACH=m
CONFIG_SND_SOC_INTEL_BYTCR_RT5640_MACH=m
CONFIG_SND_SOC_INTEL_BYTCR_RT5651_MACH=m
CONFIG_SND_SOC_INTEL_CHT_BSW_RT5672_MACH=m
CONFIG_SND_SOC_INTEL_CHT_BSW_RT5645_MACH=m
CONFIG_SND_SOC_INTEL_CHT_BSW_MAX98090_TI_MACH=m
# CONFIG_SND_SOC_INTEL_CHT_BSW_NAU8824_MACH is not set
# CONFIG_SND_SOC_INTEL_BYT_CHT_CX2072X_MACH is not set
CONFIG_SND_SOC_INTEL_BYT_CHT_DA7213_MACH=m
CONFIG_SND_SOC_INTEL_BYT_CHT_ES8316_MACH=m
CONFIG_SND_SOC_INTEL_BYT_CHT_NOCODEC_MACH=m
CONFIG_SND_SOC_INTEL_SKL_RT286_MACH=m
CONFIG_SND_SOC_INTEL_SKL_NAU88L25_SSM4567_MACH=m
CONFIG_SND_SOC_INTEL_SKL_NAU88L25_MAX98357A_MACH=m
CONFIG_SND_SOC_INTEL_DA7219_MAX98357A_GENERIC=m
CONFIG_SND_SOC_INTEL_BXT_DA7219_MAX98357A_COMMON=m
CONFIG_SND_SOC_INTEL_BXT_DA7219_MAX98357A_MACH=m
CONFIG_SND_SOC_INTEL_BXT_RT298_MACH=m
CONFIG_SND_SOC_INTEL_KBL_RT5663_MAX98927_MACH=m
CONFIG_SND_SOC_INTEL_KBL_RT5663_RT5514_MAX98927_MACH=m
# CONFIG_SND_SOC_INTEL_KBL_DA7219_MAX98357A_MACH is not set
# CONFIG_SND_SOC_INTEL_KBL_DA7219_MAX98927_MACH is not set
# CONFIG_SND_SOC_INTEL_KBL_RT5660_MACH is not set
# CONFIG_SND_SOC_MTK_BTCVSD is not set
# CONFIG_SND_SOC_SOF_TOPLEVEL is not set

#
# STMicroelectronics STM32 SOC audio support
#
# end of STMicroelectronics STM32 SOC audio support

# CONFIG_SND_SOC_XILINX_I2S is not set
# CONFIG_SND_SOC_XILINX_AUDIO_FORMATTER is not set
# CONFIG_SND_SOC_XILINX_SPDIF is not set
# CONFIG_SND_SOC_XTFPGA_I2S is not set
# CONFIG_ZX_TDM is not set
CONFIG_SND_SOC_I2C_AND_SPI=m

#
# CODEC drivers
#
# CONFIG_SND_SOC_AC97_CODEC is not set
# CONFIG_SND_SOC_ADAU1701 is not set
# CONFIG_SND_SOC_ADAU1761_I2C is not set
# CONFIG_SND_SOC_ADAU1761_SPI is not set
# CONFIG_SND_SOC_ADAU7002 is not set
# CONFIG_SND_SOC_ADAU7118_HW is not set
# CONFIG_SND_SOC_ADAU7118_I2C is not set
# CONFIG_SND_SOC_AK4104 is not set
# CONFIG_SND_SOC_AK4118 is not set
# CONFIG_SND_SOC_AK4458 is not set
# CONFIG_SND_SOC_AK4554 is not set
# CONFIG_SND_SOC_AK4613 is not set
# CONFIG_SND_SOC_AK4642 is not set
# CONFIG_SND_SOC_AK5386 is not set
# CONFIG_SND_SOC_AK5558 is not set
# CONFIG_SND_SOC_ALC5623 is not set
# CONFIG_SND_SOC_BD28623 is not set
# CONFIG_SND_SOC_BT_SCO is not set
# CONFIG_SND_SOC_CS35L32 is not set
# CONFIG_SND_SOC_CS35L33 is not set
# CONFIG_SND_SOC_CS35L34 is not set
# CONFIG_SND_SOC_CS35L35 is not set
# CONFIG_SND_SOC_CS35L36 is not set
# CONFIG_SND_SOC_CS42L42 is not set
# CONFIG_SND_SOC_CS42L51_I2C is not set
# CONFIG_SND_SOC_CS42L52 is not set
# CONFIG_SND_SOC_CS42L56 is not set
# CONFIG_SND_SOC_CS42L73 is not set
# CONFIG_SND_SOC_CS4265 is not set
# CONFIG_SND_SOC_CS4270 is not set
# CONFIG_SND_SOC_CS4271_I2C is not set
# CONFIG_SND_SOC_CS4271_SPI is not set
# CONFIG_SND_SOC_CS42XX8_I2C is not set
# CONFIG_SND_SOC_CS43130 is not set
# CONFIG_SND_SOC_CS4341 is not set
# CONFIG_SND_SOC_CS4349 is not set
# CONFIG_SND_SOC_CS53L30 is not set
# CONFIG_SND_SOC_CX2072X is not set
CONFIG_SND_SOC_DA7213=m
CONFIG_SND_SOC_DA7219=m
CONFIG_SND_SOC_DMIC=m
# CONFIG_SND_SOC_ES7134 is not set
# CONFIG_SND_SOC_ES7241 is not set
CONFIG_SND_SOC_ES8316=m
# CONFIG_SND_SOC_ES8328_I2C is not set
# CONFIG_SND_SOC_ES8328_SPI is not set
# CONFIG_SND_SOC_GTM601 is not set
CONFIG_SND_SOC_HDAC_HDMI=m
# CONFIG_SND_SOC_INNO_RK3036 is not set
# CONFIG_SND_SOC_MAX98088 is not set
CONFIG_SND_SOC_MAX98090=m
CONFIG_SND_SOC_MAX98357A=m
# CONFIG_SND_SOC_MAX98504 is not set
# CONFIG_SND_SOC_MAX9867 is not set
CONFIG_SND_SOC_MAX98927=m
# CONFIG_SND_SOC_MAX98373 is not set
# CONFIG_SND_SOC_MAX9860 is not set
# CONFIG_SND_SOC_MSM8916_WCD_DIGITAL is not set
# CONFIG_SND_SOC_PCM1681 is not set
# CONFIG_SND_SOC_PCM1789_I2C is not set
# CONFIG_SND_SOC_PCM179X_I2C is not set
# CONFIG_SND_SOC_PCM179X_SPI is not set
# CONFIG_SND_SOC_PCM186X_I2C is not set
# CONFIG_SND_SOC_PCM186X_SPI is not set
# CONFIG_SND_SOC_PCM3060_I2C is not set
# CONFIG_SND_SOC_PCM3060_SPI is not set
# CONFIG_SND_SOC_PCM3168A_I2C is not set
# CONFIG_SND_SOC_PCM3168A_SPI is not set
# CONFIG_SND_SOC_PCM512x_I2C is not set
# CONFIG_SND_SOC_PCM512x_SPI is not set
# CONFIG_SND_SOC_RK3328 is not set
CONFIG_SND_SOC_RL6231=m
CONFIG_SND_SOC_RL6347A=m
CONFIG_SND_SOC_RT286=m
CONFIG_SND_SOC_RT298=m
CONFIG_SND_SOC_RT5514=m
CONFIG_SND_SOC_RT5514_SPI=m
# CONFIG_SND_SOC_RT5616 is not set
# CONFIG_SND_SOC_RT5631 is not set
CONFIG_SND_SOC_RT5640=m
CONFIG_SND_SOC_RT5645=m
CONFIG_SND_SOC_RT5651=m
CONFIG_SND_SOC_RT5663=m
CONFIG_SND_SOC_RT5670=m
CONFIG_SND_SOC_RT5677=m
CONFIG_SND_SOC_RT5677_SPI=m
# CONFIG_SND_SOC_SGTL5000 is not set
# CONFIG_SND_SOC_SIMPLE_AMPLIFIER is not set
# CONFIG_SND_SOC_SIRF_AUDIO_CODEC is not set
# CONFIG_SND_SOC_SPDIF is not set
# CONFIG_SND_SOC_SSM2305 is not set
# CONFIG_SND_SOC_SSM2602_SPI is not set
# CONFIG_SND_SOC_SSM2602_I2C is not set
CONFIG_SND_SOC_SSM4567=m
# CONFIG_SND_SOC_STA32X is not set
# CONFIG_SND_SOC_STA350 is not set
# CONFIG_SND_SOC_STI_SAS is not set
# CONFIG_SND_SOC_TAS2552 is not set
# CONFIG_SND_SOC_TAS2562 is not set
# CONFIG_SND_SOC_TAS2770 is not set
# CONFIG_SND_SOC_TAS5086 is not set
# CONFIG_SND_SOC_TAS571X is not set
# CONFIG_SND_SOC_TAS5720 is not set
# CONFIG_SND_SOC_TAS6424 is not set
# CONFIG_SND_SOC_TDA7419 is not set
# CONFIG_SND_SOC_TFA9879 is not set
# CONFIG_SND_SOC_TLV320AIC23_I2C is not set
# CONFIG_SND_SOC_TLV320AIC23_SPI is not set
# CONFIG_SND_SOC_TLV320AIC31XX is not set
# CONFIG_SND_SOC_TLV320AIC32X4_I2C is not set
# CONFIG_SND_SOC_TLV320AIC32X4_SPI is not set
# CONFIG_SND_SOC_TLV320AIC3X is not set
CONFIG_SND_SOC_TS3A227E=m
# CONFIG_SND_SOC_TSCS42XX is not set
# CONFIG_SND_SOC_TSCS454 is not set
# CONFIG_SND_SOC_UDA1334 is not set
# CONFIG_SND_SOC_WM8510 is not set
# CONFIG_SND_SOC_WM8523 is not set
# CONFIG_SND_SOC_WM8524 is not set
# CONFIG_SND_SOC_WM8580 is not set
# CONFIG_SND_SOC_WM8711 is not set
# CONFIG_SND_SOC_WM8728 is not set
# CONFIG_SND_SOC_WM8731 is not set
# CONFIG_SND_SOC_WM8737 is not set
# CONFIG_SND_SOC_WM8741 is not set
# CONFIG_SND_SOC_WM8750 is not set
# CONFIG_SND_SOC_WM8753 is not set
# CONFIG_SND_SOC_WM8770 is not set
# CONFIG_SND_SOC_WM8776 is not set
# CONFIG_SND_SOC_WM8782 is not set
# CONFIG_SND_SOC_WM8804_I2C is not set
# CONFIG_SND_SOC_WM8804_SPI is not set
# CONFIG_SND_SOC_WM8903 is not set
# CONFIG_SND_SOC_WM8904 is not set
# CONFIG_SND_SOC_WM8960 is not set
# CONFIG_SND_SOC_WM8962 is not set
# CONFIG_SND_SOC_WM8974 is not set
# CONFIG_SND_SOC_WM8978 is not set
# CONFIG_SND_SOC_WM8985 is not set
# CONFIG_SND_SOC_ZX_AUD96P22 is not set
# CONFIG_SND_SOC_MAX9759 is not set
# CONFIG_SND_SOC_MT6351 is not set
# CONFIG_SND_SOC_MT6358 is not set
# CONFIG_SND_SOC_MT6660 is not set
# CONFIG_SND_SOC_NAU8540 is not set
# CONFIG_SND_SOC_NAU8810 is not set
# CONFIG_SND_SOC_NAU8822 is not set
CONFIG_SND_SOC_NAU8824=m
CONFIG_SND_SOC_NAU8825=m
# CONFIG_SND_SOC_TPA6130A2 is not set
# end of CODEC drivers

# CONFIG_SND_SIMPLE_CARD is not set
CONFIG_SND_X86=y
CONFIG_HDMI_LPE_AUDIO=m
CONFIG_SND_SYNTH_EMUX=m
# CONFIG_SND_XEN_FRONTEND is not set
CONFIG_AC97_BUS=m

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
CONFIG_HID_A4TECH=y
# CONFIG_HID_ACCUTOUCH is not set
CONFIG_HID_ACRUX=m
# CONFIG_HID_ACRUX_FF is not set
CONFIG_HID_APPLE=y
CONFIG_HID_APPLEIR=m
# CONFIG_HID_ASUS is not set
CONFIG_HID_AUREAL=m
CONFIG_HID_BELKIN=y
# CONFIG_HID_BETOP_FF is not set
# CONFIG_HID_BIGBEN_FF is not set
CONFIG_HID_CHERRY=y
CONFIG_HID_CHICONY=y
# CONFIG_HID_CORSAIR is not set
# CONFIG_HID_COUGAR is not set
# CONFIG_HID_MACALLY is not set
CONFIG_HID_PRODIKEYS=m
# CONFIG_HID_CMEDIA is not set
# CONFIG_HID_CP2112 is not set
# CONFIG_HID_CREATIVE_SB0540 is not set
CONFIG_HID_CYPRESS=y
CONFIG_HID_DRAGONRISE=m
# CONFIG_DRAGONRISE_FF is not set
# CONFIG_HID_EMS_FF is not set
# CONFIG_HID_ELAN is not set
CONFIG_HID_ELECOM=m
# CONFIG_HID_ELO is not set
CONFIG_HID_EZKEY=y
# CONFIG_HID_GEMBIRD is not set
# CONFIG_HID_GFRM is not set
CONFIG_HID_HOLTEK=m
# CONFIG_HOLTEK_FF is not set
# CONFIG_HID_GT683R is not set
CONFIG_HID_KEYTOUCH=m
CONFIG_HID_KYE=m
CONFIG_HID_UCLOGIC=m
CONFIG_HID_WALTOP=m
# CONFIG_HID_VIEWSONIC is not set
CONFIG_HID_GYRATION=m
CONFIG_HID_ICADE=m
CONFIG_HID_ITE=y
# CONFIG_HID_JABRA is not set
CONFIG_HID_TWINHAN=m
CONFIG_HID_KENSINGTON=y
CONFIG_HID_LCPOWER=m
CONFIG_HID_LED=m
# CONFIG_HID_LENOVO is not set
CONFIG_HID_LOGITECH=y
CONFIG_HID_LOGITECH_DJ=m
CONFIG_HID_LOGITECH_HIDPP=m
# CONFIG_LOGITECH_FF is not set
# CONFIG_LOGIRUMBLEPAD2_FF is not set
# CONFIG_LOGIG940_FF is not set
# CONFIG_LOGIWHEELS_FF is not set
CONFIG_HID_MAGICMOUSE=y
# CONFIG_HID_MALTRON is not set
# CONFIG_HID_MAYFLASH is not set
CONFIG_HID_REDRAGON=y
CONFIG_HID_MICROSOFT=y
CONFIG_HID_MONTEREY=y
CONFIG_HID_MULTITOUCH=m
# CONFIG_HID_NTI is not set
CONFIG_HID_NTRIG=y
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
CONFIG_HID_PLANTRONICS=y
CONFIG_HID_PRIMAX=m
# CONFIG_HID_RETRODE is not set
CONFIG_HID_ROCCAT=m
CONFIG_HID_SAITEK=m
CONFIG_HID_SAMSUNG=m
CONFIG_HID_SONY=m
# CONFIG_SONY_FF is not set
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
CONFIG_HID_WACOM=m
CONFIG_HID_WIIMOTE=m
# CONFIG_HID_XINMO is not set
CONFIG_HID_ZEROPLUS=m
# CONFIG_ZEROPLUS_FF is not set
CONFIG_HID_ZYDACRON=m
CONFIG_HID_SENSOR_HUB=m
CONFIG_HID_SENSOR_CUSTOM_SENSOR=m
CONFIG_HID_ALPS=m
# end of Special HID drivers

#
# USB HID support
#
CONFIG_USB_HID=y
CONFIG_HID_PID=y
CONFIG_USB_HIDDEV=y
# end of USB HID support

#
# I2C HID support
#
CONFIG_I2C_HID=m
# end of I2C HID support

#
# Intel ISH HID support
#
CONFIG_INTEL_ISH_HID=y
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
# CONFIG_USB_OTG_WHITELIST is not set
# CONFIG_USB_OTG_BLACKLIST_HUB is not set
CONFIG_USB_LEDS_TRIGGER_USBPORT=m
CONFIG_USB_AUTOSUSPEND_DELAY=2
CONFIG_USB_MON=y

#
# USB Host Controller Drivers
#
# CONFIG_USB_C67X00_HCD is not set
CONFIG_USB_XHCI_HCD=y
# CONFIG_USB_XHCI_DBGCAP is not set
CONFIG_USB_XHCI_PCI=y
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
# CONFIG_USB_U132_HCD is not set
# CONFIG_USB_SL811_HCD is not set
# CONFIG_USB_R8A66597_HCD is not set
# CONFIG_USB_HCD_BCMA is not set
# CONFIG_USB_HCD_SSB is not set
# CONFIG_USB_HCD_TEST_MODE is not set

#
# USB Device Class drivers
#
CONFIG_USB_ACM=m
CONFIG_USB_PRINTER=m
CONFIG_USB_WDM=m
CONFIG_USB_TMC=m

#
# NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
#

#
# also be needed; see USB_STORAGE Help for more info
#
CONFIG_USB_STORAGE=m
# CONFIG_USB_STORAGE_DEBUG is not set
CONFIG_USB_STORAGE_REALTEK=m
CONFIG_REALTEK_AUTOPM=y
CONFIG_USB_STORAGE_DATAFAB=m
CONFIG_USB_STORAGE_FREECOM=m
CONFIG_USB_STORAGE_ISD200=m
CONFIG_USB_STORAGE_USBAT=m
CONFIG_USB_STORAGE_SDDR09=m
CONFIG_USB_STORAGE_SDDR55=m
CONFIG_USB_STORAGE_JUMPSHOT=m
CONFIG_USB_STORAGE_ALAUDA=m
CONFIG_USB_STORAGE_ONETOUCH=m
CONFIG_USB_STORAGE_KARMA=m
CONFIG_USB_STORAGE_CYPRESS_ATACB=m
CONFIG_USB_STORAGE_ENE_UB6250=m
CONFIG_USB_UAS=m

#
# USB Imaging devices
#
CONFIG_USB_MDC800=m
CONFIG_USB_MICROTEK=m
CONFIG_USBIP_CORE=m
# CONFIG_USBIP_VHCI_HCD is not set
# CONFIG_USBIP_HOST is not set
# CONFIG_USBIP_DEBUG is not set
# CONFIG_USB_CDNS3 is not set
# CONFIG_USB_MUSB_HDRC is not set
# CONFIG_USB_DWC3 is not set
# CONFIG_USB_DWC2 is not set
# CONFIG_USB_CHIPIDEA is not set
# CONFIG_USB_ISP1760 is not set

#
# USB port drivers
#
CONFIG_USB_USS720=m
CONFIG_USB_SERIAL=y
CONFIG_USB_SERIAL_CONSOLE=y
CONFIG_USB_SERIAL_GENERIC=y
# CONFIG_USB_SERIAL_SIMPLE is not set
CONFIG_USB_SERIAL_AIRCABLE=m
CONFIG_USB_SERIAL_ARK3116=m
CONFIG_USB_SERIAL_BELKIN=m
CONFIG_USB_SERIAL_CH341=m
CONFIG_USB_SERIAL_WHITEHEAT=m
CONFIG_USB_SERIAL_DIGI_ACCELEPORT=m
CONFIG_USB_SERIAL_CP210X=m
CONFIG_USB_SERIAL_CYPRESS_M8=m
CONFIG_USB_SERIAL_EMPEG=m
CONFIG_USB_SERIAL_FTDI_SIO=m
CONFIG_USB_SERIAL_VISOR=m
CONFIG_USB_SERIAL_IPAQ=m
CONFIG_USB_SERIAL_IR=m
CONFIG_USB_SERIAL_EDGEPORT=m
CONFIG_USB_SERIAL_EDGEPORT_TI=m
# CONFIG_USB_SERIAL_F81232 is not set
# CONFIG_USB_SERIAL_F8153X is not set
CONFIG_USB_SERIAL_GARMIN=m
CONFIG_USB_SERIAL_IPW=m
CONFIG_USB_SERIAL_IUU=m
CONFIG_USB_SERIAL_KEYSPAN_PDA=m
CONFIG_USB_SERIAL_KEYSPAN=m
CONFIG_USB_SERIAL_KLSI=m
CONFIG_USB_SERIAL_KOBIL_SCT=m
CONFIG_USB_SERIAL_MCT_U232=m
# CONFIG_USB_SERIAL_METRO is not set
CONFIG_USB_SERIAL_MOS7720=m
CONFIG_USB_SERIAL_MOS7715_PARPORT=y
CONFIG_USB_SERIAL_MOS7840=m
# CONFIG_USB_SERIAL_MXUPORT is not set
CONFIG_USB_SERIAL_NAVMAN=m
CONFIG_USB_SERIAL_PL2303=m
CONFIG_USB_SERIAL_OTI6858=m
CONFIG_USB_SERIAL_QCAUX=m
CONFIG_USB_SERIAL_QUALCOMM=m
CONFIG_USB_SERIAL_SPCP8X5=m
CONFIG_USB_SERIAL_SAFE=m
CONFIG_USB_SERIAL_SAFE_PADDED=y
CONFIG_USB_SERIAL_SIERRAWIRELESS=m
CONFIG_USB_SERIAL_SYMBOL=m
# CONFIG_USB_SERIAL_TI is not set
CONFIG_USB_SERIAL_CYBERJACK=m
CONFIG_USB_SERIAL_XIRCOM=m
CONFIG_USB_SERIAL_WWAN=m
CONFIG_USB_SERIAL_OPTION=m
CONFIG_USB_SERIAL_OMNINET=m
CONFIG_USB_SERIAL_OPTICON=m
CONFIG_USB_SERIAL_XSENS_MT=m
# CONFIG_USB_SERIAL_WISHBONE is not set
CONFIG_USB_SERIAL_SSU100=m
CONFIG_USB_SERIAL_QT2=m
# CONFIG_USB_SERIAL_UPD78F0730 is not set
CONFIG_USB_SERIAL_DEBUG=m

#
# USB Miscellaneous drivers
#
CONFIG_USB_EMI62=m
CONFIG_USB_EMI26=m
CONFIG_USB_ADUTUX=m
CONFIG_USB_SEVSEG=m
CONFIG_USB_LEGOTOWER=m
CONFIG_USB_LCD=m
# CONFIG_USB_CYPRESS_CY7C63 is not set
# CONFIG_USB_CYTHERM is not set
CONFIG_USB_IDMOUSE=m
CONFIG_USB_FTDI_ELAN=m
CONFIG_USB_APPLEDISPLAY=m
CONFIG_USB_SISUSBVGA=m
CONFIG_USB_SISUSBVGA_CON=y
CONFIG_USB_LD=m
# CONFIG_USB_TRANCEVIBRATOR is not set
CONFIG_USB_IOWARRIOR=m
# CONFIG_USB_TEST is not set
# CONFIG_USB_EHSET_TEST_FIXTURE is not set
CONFIG_USB_ISIGHTFW=m
# CONFIG_USB_YUREX is not set
CONFIG_USB_EZUSB_FX2=m
# CONFIG_USB_HUB_USB251XB is not set
CONFIG_USB_HSIC_USB3503=m
# CONFIG_USB_HSIC_USB4604 is not set
# CONFIG_USB_LINK_LAYER_TEST is not set
# CONFIG_USB_CHAOSKEY is not set
CONFIG_USB_ATM=m
CONFIG_USB_SPEEDTOUCH=m
CONFIG_USB_CXACRU=m
CONFIG_USB_UEAGLEATM=m
CONFIG_USB_XUSBATM=m

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
CONFIG_MMC_TIFM_SD=m
# CONFIG_MMC_SPI is not set
CONFIG_MMC_CB710=m
CONFIG_MMC_VIA_SDMMC=m
CONFIG_MMC_VUB300=m
CONFIG_MMC_USHC=m
# CONFIG_MMC_USDHI6ROL0 is not set
CONFIG_MMC_CQHCI=m
# CONFIG_MMC_TOSHIBA_PCI is not set
# CONFIG_MMC_MTK is not set
# CONFIG_MMC_SDHCI_XENON is not set
CONFIG_MEMSTICK=m
# CONFIG_MEMSTICK_DEBUG is not set

#
# MemoryStick drivers
#
# CONFIG_MEMSTICK_UNSAFE_RESUME is not set
CONFIG_MSPRO_BLOCK=m
# CONFIG_MS_BLOCK is not set

#
# MemoryStick Host Controller Drivers
#
CONFIG_MEMSTICK_TIFM_MS=m
CONFIG_MEMSTICK_JMICRON_38X=m
CONFIG_MEMSTICK_R592=m
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y
# CONFIG_LEDS_CLASS_FLASH is not set
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
CONFIG_LEDS_LP55XX_COMMON=m
CONFIG_LEDS_LP5521=m
CONFIG_LEDS_LP5523=m
CONFIG_LEDS_LP5562=m
# CONFIG_LEDS_LP8501 is not set
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
# CONFIG_LEDS_MLXCPLD is not set
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
# CONFIG_LEDS_TRIGGER_MTD is not set
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
# CONFIG_INFINIBAND_CXGB4 is not set
# CONFIG_INFINIBAND_EFA is not set
# CONFIG_INFINIBAND_I40IW is not set
# CONFIG_MLX4_INFINIBAND is not set
# CONFIG_INFINIBAND_OCRDMA is not set
# CONFIG_INFINIBAND_VMWARE_PVRDMA is not set
# CONFIG_INFINIBAND_USNIC is not set
# CONFIG_INFINIBAND_BNXT_RE is not set
# CONFIG_INFINIBAND_QEDR is not set
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
CONFIG_RTC_DRV_RV3029_HWMON=y

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
# CONFIG_RTC_DRV_HID_SENSOR_TIME is not set
CONFIG_DMADEVICES=y
# CONFIG_DMADEVICES_DEBUG is not set

#
# DMA Devices
#
CONFIG_DMA_ENGINE=y
CONFIG_DMA_VIRTUAL_CHANNELS=y
CONFIG_DMA_ACPI=y
# CONFIG_ALTERA_MSGDMA is not set
# CONFIG_INTEL_IDMA64 is not set
# CONFIG_INTEL_IDXD is not set
CONFIG_INTEL_IOATDMA=m
# CONFIG_PLX_DMA is not set
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
# CONFIG_DMATEST is not set
CONFIG_DMA_ENGINE_RAID=y

#
# DMABUF options
#
CONFIG_SYNC_FILE=y
CONFIG_SW_SYNC=y
# CONFIG_UDMABUF is not set
# CONFIG_DMABUF_SELFTESTS is not set
# CONFIG_DMABUF_HEAPS is not set
# end of DMABUF options

CONFIG_DCA=m
CONFIG_AUXDISPLAY=y
# CONFIG_HD44780 is not set
CONFIG_KS0108=m
CONFIG_KS0108_PORT=0x378
CONFIG_KS0108_DELAY=2
CONFIG_CFAG12864B=m
CONFIG_CFAG12864B_RATE=20
# CONFIG_IMG_ASCII_LCD is not set
# CONFIG_PARPORT_PANEL is not set
# CONFIG_CHARLCD_BL_OFF is not set
# CONFIG_CHARLCD_BL_ON is not set
CONFIG_CHARLCD_BL_FLASH=y
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
CONFIG_VIRTIO_BALLOON=y
CONFIG_VIRTIO_INPUT=m
# CONFIG_VIRTIO_MMIO is not set

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
CONFIG_XEN_BALLOON=y
# CONFIG_XEN_BALLOON_MEMORY_HOTPLUG is not set
CONFIG_XEN_SCRUB_PAGES_DEFAULT=y
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
CONFIG_XEN_HAVE_PVMMU=y
CONFIG_XEN_EFI=y
CONFIG_XEN_AUTO_XLATE=y
CONFIG_XEN_ACPI=y
CONFIG_XEN_HAVE_VPMU=y
# end of Xen driver support

# CONFIG_GREYBUS is not set
CONFIG_STAGING=y
# CONFIG_PRISM2_USB is not set
# CONFIG_COMEDI is not set
# CONFIG_RTL8192U is not set
CONFIG_RTLLIB=m
CONFIG_RTLLIB_CRYPTO_CCMP=m
CONFIG_RTLLIB_CRYPTO_TKIP=m
CONFIG_RTLLIB_CRYPTO_WEP=m
CONFIG_RTL8192E=m
# CONFIG_RTL8723BS is not set
CONFIG_R8712U=m
# CONFIG_R8188EU is not set
# CONFIG_RTS5208 is not set
# CONFIG_VT6655 is not set
# CONFIG_VT6656 is not set

#
# IIO staging drivers
#

#
# Accelerometers
#
# CONFIG_ADIS16203 is not set
# CONFIG_ADIS16240 is not set
# end of Accelerometers

#
# Analog to digital converters
#
# CONFIG_AD7816 is not set
# CONFIG_AD7192 is not set
# CONFIG_AD7280 is not set
# end of Analog to digital converters

#
# Analog digital bi-direction converters
#
# CONFIG_ADT7316 is not set
# end of Analog digital bi-direction converters

#
# Capacitance to digital converters
#
# CONFIG_AD7150 is not set
# CONFIG_AD7746 is not set
# end of Capacitance to digital converters

#
# Direct Digital Synthesis
#
# CONFIG_AD9832 is not set
# CONFIG_AD9834 is not set
# end of Direct Digital Synthesis

#
# Network Analyzer, Impedance Converters
#
# CONFIG_AD5933 is not set
# end of Network Analyzer, Impedance Converters

#
# Active energy metering IC
#
# CONFIG_ADE7854 is not set
# end of Active energy metering IC

#
# Resolver to digital converters
#
# CONFIG_AD2S1210 is not set
# end of Resolver to digital converters
# end of IIO staging drivers

# CONFIG_FB_SM750 is not set

#
# Speakup console speech
#
# CONFIG_SPEAKUP is not set
# end of Speakup console speech

# CONFIG_STAGING_MEDIA is not set

#
# Android
#
# CONFIG_ASHMEM is not set
CONFIG_ION=y
CONFIG_ION_SYSTEM_HEAP=y
# CONFIG_ION_CMA_HEAP is not set
# end of Android

# CONFIG_LTE_GDM724X is not set
CONFIG_FIREWIRE_SERIAL=m
CONFIG_FWTTY_MAX_TOTAL_PORTS=64
CONFIG_FWTTY_MAX_CARD_PORTS=32
# CONFIG_GS_FPGABOOT is not set
# CONFIG_UNISYSSPAR is not set
# CONFIG_FB_TFT is not set
# CONFIG_WILC1000_SDIO is not set
# CONFIG_WILC1000_SPI is not set
# CONFIG_MOST is not set
# CONFIG_KS7010 is not set
# CONFIG_PI433 is not set

#
# Gasket devices
#
# CONFIG_STAGING_GASKET_FRAMEWORK is not set
# end of Gasket devices

# CONFIG_FIELDBUS_DEV is not set
# CONFIG_KPC2000 is not set
CONFIG_USB_WUSB=m
CONFIG_USB_WUSB_CBAF=m
# CONFIG_USB_WUSB_CBAF_DEBUG is not set
# CONFIG_USB_WHCI_HCD is not set
CONFIG_USB_HWA_HCD=m
CONFIG_UWB=m
CONFIG_UWB_HWA=m
CONFIG_UWB_WHCI=m
CONFIG_UWB_I1480U=m
# CONFIG_STAGING_EXFAT_FS is not set
CONFIG_QLGE=m
# CONFIG_NET_VENDOR_HP is not set
# CONFIG_WFX is not set
CONFIG_X86_PLATFORM_DEVICES=y
CONFIG_ACER_WMI=m
# CONFIG_ACER_WIRELESS is not set
CONFIG_ACERHDF=m
# CONFIG_ALIENWARE_WMI is not set
CONFIG_ASUS_LAPTOP=m
CONFIG_DCDBAS=m
CONFIG_DELL_SMBIOS=m
CONFIG_DELL_SMBIOS_WMI=y
CONFIG_DELL_SMBIOS_SMM=y
CONFIG_DELL_LAPTOP=m
CONFIG_DELL_WMI=m
CONFIG_DELL_WMI_DESCRIPTOR=m
CONFIG_DELL_WMI_AIO=m
# CONFIG_DELL_WMI_LED is not set
CONFIG_DELL_SMO8800=m
CONFIG_DELL_RBTN=m
CONFIG_DELL_RBU=m
CONFIG_FUJITSU_LAPTOP=m
CONFIG_FUJITSU_TABLET=m
CONFIG_AMILO_RFKILL=m
# CONFIG_GPD_POCKET_FAN is not set
CONFIG_HP_ACCEL=m
CONFIG_HP_WIRELESS=m
CONFIG_HP_WMI=m
# CONFIG_LG_LAPTOP is not set
CONFIG_MSI_LAPTOP=m
CONFIG_PANASONIC_LAPTOP=m
CONFIG_COMPAL_LAPTOP=m
CONFIG_SONY_LAPTOP=m
CONFIG_SONYPI_COMPAT=y
CONFIG_IDEAPAD_LAPTOP=m
# CONFIG_SURFACE3_WMI is not set
CONFIG_THINKPAD_ACPI=m
CONFIG_THINKPAD_ACPI_ALSA_SUPPORT=y
# CONFIG_THINKPAD_ACPI_DEBUGFACILITIES is not set
# CONFIG_THINKPAD_ACPI_DEBUG is not set
# CONFIG_THINKPAD_ACPI_UNSAFE_LEDS is not set
CONFIG_THINKPAD_ACPI_VIDEO=y
CONFIG_THINKPAD_ACPI_HOTKEY_POLL=y
CONFIG_SENSORS_HDAPS=m
# CONFIG_INTEL_MENLOW is not set
CONFIG_EEEPC_LAPTOP=m
CONFIG_ASUS_WMI=m
CONFIG_ASUS_NB_WMI=m
CONFIG_EEEPC_WMI=m
# CONFIG_ASUS_WIRELESS is not set
CONFIG_ACPI_WMI=m
CONFIG_WMI_BMOF=m
CONFIG_INTEL_WMI_THUNDERBOLT=m
# CONFIG_XIAOMI_WMI is not set
CONFIG_MSI_WMI=m
# CONFIG_PEAQ_WMI is not set
CONFIG_TOPSTAR_LAPTOP=m
CONFIG_ACPI_TOSHIBA=m
CONFIG_TOSHIBA_BT_RFKILL=m
# CONFIG_TOSHIBA_HAPS is not set
# CONFIG_TOSHIBA_WMI is not set
CONFIG_ACPI_CMPC=m
# CONFIG_INTEL_INT0002_VGPIO is not set
CONFIG_INTEL_HID_EVENT=m
CONFIG_INTEL_VBTN=m
CONFIG_INTEL_IPS=m
CONFIG_INTEL_PMC_CORE=m
# CONFIG_IBM_RTL is not set
CONFIG_SAMSUNG_LAPTOP=m
CONFIG_MXM_WMI=m
CONFIG_INTEL_OAKTRAIL=m
CONFIG_SAMSUNG_Q10=m
CONFIG_APPLE_GMUX=m
# CONFIG_INTEL_RST is not set
# CONFIG_INTEL_SMARTCONNECT is not set
# CONFIG_INTEL_PMC_IPC is not set
# CONFIG_SURFACE_PRO3_BUTTON is not set
# CONFIG_INTEL_PUNIT_IPC is not set
# CONFIG_MLX_PLATFORM is not set
# CONFIG_INTEL_TURBO_MAX_3 is not set
# CONFIG_I2C_MULTI_INSTANTIATE is not set
# CONFIG_INTEL_ATOMISP2_PM is not set
# CONFIG_HUAWEI_WMI is not set
# CONFIG_PCENGINES_APU2 is not set
# CONFIG_INTEL_UNCORE_FREQ_CONTROL is not set

#
# Intel Speed Select Technology interface support
#
# CONFIG_INTEL_SPEED_SELECT_INTERFACE is not set
# end of Intel Speed Select Technology interface support

# CONFIG_SYSTEM76_ACPI is not set
CONFIG_PMC_ATOM=y
# CONFIG_MFD_CROS_EC is not set
# CONFIG_CHROME_PLATFORMS is not set
# CONFIG_MELLANOX_PLATFORM is not set
CONFIG_CLKDEV_LOOKUP=y
CONFIG_HAVE_CLK_PREPARE=y
CONFIG_COMMON_CLK=y

#
# Common Clock Framework
#
# CONFIG_COMMON_CLK_MAX9485 is not set
# CONFIG_COMMON_CLK_SI5341 is not set
# CONFIG_COMMON_CLK_SI5351 is not set
# CONFIG_COMMON_CLK_SI544 is not set
# CONFIG_COMMON_CLK_CDCE706 is not set
# CONFIG_COMMON_CLK_CS2000_CP is not set
# CONFIG_COMMON_CLK_PWM is not set
# end of Common Clock Framework

# CONFIG_HWSPINLOCK is not set

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

CONFIG_PM_DEVFREQ=y

#
# DEVFREQ Governors
#
CONFIG_DEVFREQ_GOV_SIMPLE_ONDEMAND=m
# CONFIG_DEVFREQ_GOV_PERFORMANCE is not set
# CONFIG_DEVFREQ_GOV_POWERSAVE is not set
# CONFIG_DEVFREQ_GOV_USERSPACE is not set
# CONFIG_DEVFREQ_GOV_PASSIVE is not set

#
# DEVFREQ Drivers
#
# CONFIG_PM_DEVFREQ_EVENT is not set
# CONFIG_EXTCON is not set
# CONFIG_MEMORY is not set
CONFIG_IIO=y
CONFIG_IIO_BUFFER=y
CONFIG_IIO_BUFFER_CB=y
# CONFIG_IIO_BUFFER_HW_CONSUMER is not set
CONFIG_IIO_KFIFO_BUF=y
CONFIG_IIO_TRIGGERED_BUFFER=m
# CONFIG_IIO_CONFIGFS is not set
CONFIG_IIO_TRIGGER=y
CONFIG_IIO_CONSUMERS_PER_TRIGGER=2
# CONFIG_IIO_SW_DEVICE is not set
# CONFIG_IIO_SW_TRIGGER is not set

#
# Accelerometers
#
# CONFIG_ADIS16201 is not set
# CONFIG_ADIS16209 is not set
# CONFIG_ADXL345_I2C is not set
# CONFIG_ADXL345_SPI is not set
# CONFIG_ADXL372_SPI is not set
# CONFIG_ADXL372_I2C is not set
# CONFIG_BMA180 is not set
# CONFIG_BMA220 is not set
# CONFIG_BMA400 is not set
# CONFIG_BMC150_ACCEL is not set
# CONFIG_DA280 is not set
# CONFIG_DA311 is not set
# CONFIG_DMARD09 is not set
# CONFIG_DMARD10 is not set
CONFIG_HID_SENSOR_ACCEL_3D=m
# CONFIG_IIO_ST_ACCEL_3AXIS is not set
# CONFIG_KXSD9 is not set
# CONFIG_KXCJK1013 is not set
# CONFIG_MC3230 is not set
# CONFIG_MMA7455_I2C is not set
# CONFIG_MMA7455_SPI is not set
# CONFIG_MMA7660 is not set
# CONFIG_MMA8452 is not set
# CONFIG_MMA9551 is not set
# CONFIG_MMA9553 is not set
# CONFIG_MXC4005 is not set
# CONFIG_MXC6255 is not set
# CONFIG_SCA3000 is not set
# CONFIG_STK8312 is not set
# CONFIG_STK8BA50 is not set
# end of Accelerometers

#
# Analog to digital converters
#
# CONFIG_AD7091R5 is not set
# CONFIG_AD7124 is not set
# CONFIG_AD7266 is not set
# CONFIG_AD7291 is not set
# CONFIG_AD7292 is not set
# CONFIG_AD7298 is not set
# CONFIG_AD7476 is not set
# CONFIG_AD7606_IFACE_PARALLEL is not set
# CONFIG_AD7606_IFACE_SPI is not set
# CONFIG_AD7766 is not set
# CONFIG_AD7768_1 is not set
# CONFIG_AD7780 is not set
# CONFIG_AD7791 is not set
# CONFIG_AD7793 is not set
# CONFIG_AD7887 is not set
# CONFIG_AD7923 is not set
# CONFIG_AD7949 is not set
# CONFIG_AD799X is not set
# CONFIG_HI8435 is not set
# CONFIG_HX711 is not set
# CONFIG_INA2XX_ADC is not set
# CONFIG_LTC2471 is not set
# CONFIG_LTC2485 is not set
# CONFIG_LTC2496 is not set
# CONFIG_LTC2497 is not set
# CONFIG_MAX1027 is not set
# CONFIG_MAX11100 is not set
# CONFIG_MAX1118 is not set
# CONFIG_MAX1363 is not set
# CONFIG_MAX9611 is not set
# CONFIG_MCP320X is not set
# CONFIG_MCP3422 is not set
# CONFIG_MCP3911 is not set
# CONFIG_NAU7802 is not set
# CONFIG_TI_ADC081C is not set
# CONFIG_TI_ADC0832 is not set
# CONFIG_TI_ADC084S021 is not set
# CONFIG_TI_ADC12138 is not set
# CONFIG_TI_ADC108S102 is not set
# CONFIG_TI_ADC128S052 is not set
# CONFIG_TI_ADC161S626 is not set
# CONFIG_TI_ADS1015 is not set
# CONFIG_TI_ADS7950 is not set
# CONFIG_TI_TLC4541 is not set
# CONFIG_VIPERBOARD_ADC is not set
# CONFIG_XILINX_XADC is not set
# end of Analog to digital converters

#
# Analog Front Ends
#
# end of Analog Front Ends

#
# Amplifiers
#
# CONFIG_AD8366 is not set
# end of Amplifiers

#
# Chemical Sensors
#
# CONFIG_ATLAS_PH_SENSOR is not set
# CONFIG_BME680 is not set
# CONFIG_CCS811 is not set
# CONFIG_IAQCORE is not set
# CONFIG_SENSIRION_SGP30 is not set
# CONFIG_SPS30 is not set
# CONFIG_VZ89X is not set
# end of Chemical Sensors

#
# Hid Sensor IIO Common
#
CONFIG_HID_SENSOR_IIO_COMMON=m
CONFIG_HID_SENSOR_IIO_TRIGGER=m
# end of Hid Sensor IIO Common

#
# SSP Sensor Common
#
# CONFIG_IIO_SSP_SENSORHUB is not set
# end of SSP Sensor Common

#
# Digital to analog converters
#
# CONFIG_AD5064 is not set
# CONFIG_AD5360 is not set
# CONFIG_AD5380 is not set
# CONFIG_AD5421 is not set
# CONFIG_AD5446 is not set
# CONFIG_AD5449 is not set
# CONFIG_AD5592R is not set
# CONFIG_AD5593R is not set
# CONFIG_AD5504 is not set
# CONFIG_AD5624R_SPI is not set
# CONFIG_LTC1660 is not set
# CONFIG_LTC2632 is not set
# CONFIG_AD5686_SPI is not set
# CONFIG_AD5696_I2C is not set
# CONFIG_AD5755 is not set
# CONFIG_AD5758 is not set
# CONFIG_AD5761 is not set
# CONFIG_AD5764 is not set
# CONFIG_AD5791 is not set
# CONFIG_AD7303 is not set
# CONFIG_AD8801 is not set
# CONFIG_DS4424 is not set
# CONFIG_M62332 is not set
# CONFIG_MAX517 is not set
# CONFIG_MCP4725 is not set
# CONFIG_MCP4922 is not set
# CONFIG_TI_DAC082S085 is not set
# CONFIG_TI_DAC5571 is not set
# CONFIG_TI_DAC7311 is not set
# CONFIG_TI_DAC7612 is not set
# end of Digital to analog converters

#
# IIO dummy driver
#
# end of IIO dummy driver

#
# Frequency Synthesizers DDS/PLL
#

#
# Clock Generator/Distribution
#
# CONFIG_AD9523 is not set
# end of Clock Generator/Distribution

#
# Phase-Locked Loop (PLL) frequency synthesizers
#
# CONFIG_ADF4350 is not set
# CONFIG_ADF4371 is not set
# end of Phase-Locked Loop (PLL) frequency synthesizers
# end of Frequency Synthesizers DDS/PLL

#
# Digital gyroscope sensors
#
# CONFIG_ADIS16080 is not set
# CONFIG_ADIS16130 is not set
# CONFIG_ADIS16136 is not set
# CONFIG_ADIS16260 is not set
# CONFIG_ADXRS450 is not set
# CONFIG_BMG160 is not set
# CONFIG_FXAS21002C is not set
CONFIG_HID_SENSOR_GYRO_3D=m
# CONFIG_MPU3050_I2C is not set
# CONFIG_IIO_ST_GYRO_3AXIS is not set
# CONFIG_ITG3200 is not set
# end of Digital gyroscope sensors

#
# Health Sensors
#

#
# Heart Rate Monitors
#
# CONFIG_AFE4403 is not set
# CONFIG_AFE4404 is not set
# CONFIG_MAX30100 is not set
# CONFIG_MAX30102 is not set
# end of Heart Rate Monitors
# end of Health Sensors

#
# Humidity sensors
#
# CONFIG_AM2315 is not set
# CONFIG_DHT11 is not set
# CONFIG_HDC100X is not set
# CONFIG_HID_SENSOR_HUMIDITY is not set
# CONFIG_HTS221 is not set
# CONFIG_HTU21 is not set
# CONFIG_SI7005 is not set
# CONFIG_SI7020 is not set
# end of Humidity sensors

#
# Inertial measurement units
#
# CONFIG_ADIS16400 is not set
# CONFIG_ADIS16460 is not set
# CONFIG_ADIS16480 is not set
# CONFIG_BMI160_I2C is not set
# CONFIG_BMI160_SPI is not set
# CONFIG_FXOS8700_I2C is not set
# CONFIG_FXOS8700_SPI is not set
# CONFIG_KMX61 is not set
# CONFIG_INV_MPU6050_I2C is not set
# CONFIG_INV_MPU6050_SPI is not set
# CONFIG_IIO_ST_LSM6DSX is not set
# end of Inertial measurement units

#
# Light sensors
#
# CONFIG_ACPI_ALS is not set
# CONFIG_ADJD_S311 is not set
# CONFIG_ADUX1020 is not set
# CONFIG_AL3320A is not set
# CONFIG_APDS9300 is not set
# CONFIG_APDS9960 is not set
# CONFIG_BH1750 is not set
# CONFIG_BH1780 is not set
# CONFIG_CM32181 is not set
# CONFIG_CM3232 is not set
# CONFIG_CM3323 is not set
# CONFIG_CM36651 is not set
# CONFIG_GP2AP020A00F is not set
# CONFIG_SENSORS_ISL29018 is not set
# CONFIG_SENSORS_ISL29028 is not set
# CONFIG_ISL29125 is not set
CONFIG_HID_SENSOR_ALS=m
CONFIG_HID_SENSOR_PROX=m
# CONFIG_JSA1212 is not set
# CONFIG_RPR0521 is not set
# CONFIG_LTR501 is not set
# CONFIG_LV0104CS is not set
# CONFIG_MAX44000 is not set
# CONFIG_MAX44009 is not set
# CONFIG_NOA1305 is not set
# CONFIG_OPT3001 is not set
# CONFIG_PA12203001 is not set
# CONFIG_SI1133 is not set
# CONFIG_SI1145 is not set
# CONFIG_STK3310 is not set
# CONFIG_ST_UVIS25 is not set
# CONFIG_TCS3414 is not set
# CONFIG_TCS3472 is not set
# CONFIG_SENSORS_TSL2563 is not set
# CONFIG_TSL2583 is not set
# CONFIG_TSL2772 is not set
# CONFIG_TSL4531 is not set
# CONFIG_US5182D is not set
# CONFIG_VCNL4000 is not set
# CONFIG_VCNL4035 is not set
# CONFIG_VEML6030 is not set
# CONFIG_VEML6070 is not set
# CONFIG_VL6180 is not set
# CONFIG_ZOPT2201 is not set
# end of Light sensors

#
# Magnetometer sensors
#
# CONFIG_AK8975 is not set
# CONFIG_AK09911 is not set
# CONFIG_BMC150_MAGN_I2C is not set
# CONFIG_BMC150_MAGN_SPI is not set
# CONFIG_MAG3110 is not set
CONFIG_HID_SENSOR_MAGNETOMETER_3D=m
# CONFIG_MMC35240 is not set
# CONFIG_IIO_ST_MAGN_3AXIS is not set
# CONFIG_SENSORS_HMC5843_I2C is not set
# CONFIG_SENSORS_HMC5843_SPI is not set
# CONFIG_SENSORS_RM3100_I2C is not set
# CONFIG_SENSORS_RM3100_SPI is not set
# end of Magnetometer sensors

#
# Multiplexers
#
# end of Multiplexers

#
# Inclinometer sensors
#
CONFIG_HID_SENSOR_INCLINOMETER_3D=m
CONFIG_HID_SENSOR_DEVICE_ROTATION=m
# end of Inclinometer sensors

#
# Triggers - standalone
#
# CONFIG_IIO_INTERRUPT_TRIGGER is not set
# CONFIG_IIO_SYSFS_TRIGGER is not set
# end of Triggers - standalone

#
# Digital potentiometers
#
# CONFIG_AD5272 is not set
# CONFIG_DS1803 is not set
# CONFIG_MAX5432 is not set
# CONFIG_MAX5481 is not set
# CONFIG_MAX5487 is not set
# CONFIG_MCP4018 is not set
# CONFIG_MCP4131 is not set
# CONFIG_MCP4531 is not set
# CONFIG_MCP41010 is not set
# CONFIG_TPL0102 is not set
# end of Digital potentiometers

#
# Digital potentiostats
#
# CONFIG_LMP91000 is not set
# end of Digital potentiostats

#
# Pressure sensors
#
# CONFIG_ABP060MG is not set
# CONFIG_BMP280 is not set
# CONFIG_DLHL60D is not set
# CONFIG_DPS310 is not set
CONFIG_HID_SENSOR_PRESS=m
# CONFIG_HP03 is not set
# CONFIG_MPL115_I2C is not set
# CONFIG_MPL115_SPI is not set
# CONFIG_MPL3115 is not set
# CONFIG_MS5611 is not set
# CONFIG_MS5637 is not set
# CONFIG_IIO_ST_PRESS is not set
# CONFIG_T5403 is not set
# CONFIG_HP206C is not set
# CONFIG_ZPA2326 is not set
# end of Pressure sensors

#
# Lightning sensors
#
# CONFIG_AS3935 is not set
# end of Lightning sensors

#
# Proximity and distance sensors
#
# CONFIG_ISL29501 is not set
# CONFIG_LIDAR_LITE_V2 is not set
# CONFIG_MB1232 is not set
# CONFIG_PING is not set
# CONFIG_RFD77402 is not set
# CONFIG_SRF04 is not set
# CONFIG_SX9500 is not set
# CONFIG_SRF08 is not set
# CONFIG_VL53L0X_I2C is not set
# end of Proximity and distance sensors

#
# Resolver to digital converters
#
# CONFIG_AD2S90 is not set
# CONFIG_AD2S1200 is not set
# end of Resolver to digital converters

#
# Temperature sensors
#
# CONFIG_LTC2983 is not set
# CONFIG_MAXIM_THERMOCOUPLE is not set
# CONFIG_HID_SENSOR_TEMP is not set
# CONFIG_MLX90614 is not set
# CONFIG_MLX90632 is not set
# CONFIG_TMP006 is not set
# CONFIG_TMP007 is not set
# CONFIG_TSYS01 is not set
# CONFIG_TSYS02D is not set
# CONFIG_MAX31856 is not set
# end of Temperature sensors

CONFIG_NTB=m
# CONFIG_NTB_MSI is not set
CONFIG_NTB_AMD=m
# CONFIG_NTB_IDT is not set
# CONFIG_NTB_INTEL is not set
# CONFIG_NTB_SWITCHTEC is not set
# CONFIG_NTB_PINGPONG is not set
# CONFIG_NTB_TOOL is not set
CONFIG_NTB_PERF=m
CONFIG_NTB_TRANSPORT=m
# CONFIG_VME_BUS is not set
CONFIG_PWM=y
CONFIG_PWM_SYSFS=y
# CONFIG_PWM_LPSS_PCI is not set
# CONFIG_PWM_LPSS_PLATFORM is not set
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
CONFIG_GENERIC_PHY=y
# CONFIG_BCM_KONA_USB2_PHY is not set
# CONFIG_PHY_PXA_28NM_HSIC is not set
# CONFIG_PHY_PXA_28NM_USB2 is not set
# CONFIG_PHY_CPCAP_USB is not set
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
CONFIG_ANDROID=y
# CONFIG_ANDROID_BINDER_IPC is not set
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
# CONFIG_STM is not set
# CONFIG_INTEL_TH is not set
# end of HW tracing support

# CONFIG_FPGA is not set
# CONFIG_TEE is not set
CONFIG_PM_OPP=y
# CONFIG_UNISYS_VISORBUS is not set
# CONFIG_SIOX is not set
# CONFIG_SLIMBUS is not set
# CONFIG_INTERCONNECT is not set
# CONFIG_COUNTER is not set
# end of Device Drivers

#
# File systems
#
CONFIG_DCACHE_WORD_ACCESS=y
# CONFIG_VALIDATE_FS_PARSER is not set
CONFIG_FS_IOMAP=y
# CONFIG_EXT2_FS is not set
# CONFIG_EXT3_FS is not set
CONFIG_EXT4_FS=m
CONFIG_EXT4_USE_FOR_EXT2=y
CONFIG_EXT4_FS_POSIX_ACL=y
CONFIG_EXT4_FS_SECURITY=y
# CONFIG_EXT4_DEBUG is not set
CONFIG_JBD2=m
# CONFIG_JBD2_DEBUG is not set
CONFIG_FS_MBCACHE=m
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
CONFIG_FS_ENCRYPTION_ALGS=m
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
# DOS/FAT/NT Filesystems
#
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
CONFIG_VFAT_FS=m
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="ascii"
# CONFIG_FAT_DEFAULT_UTF8 is not set
# CONFIG_NTFS_FS is not set
# end of DOS/FAT/NT Filesystems

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_PROC_VMCORE=y
# CONFIG_PROC_VMCORE_DEVICE_DUMP is not set
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
# CONFIG_JFFS2_FS is not set
# CONFIG_UBIFS_FS is not set
CONFIG_CRAMFS=m
CONFIG_CRAMFS_BLOCKDEV=y
# CONFIG_CRAMFS_MTD is not set
CONFIG_SQUASHFS=m
CONFIG_SQUASHFS_FILE_CACHE=y
# CONFIG_SQUASHFS_FILE_DIRECT is not set
CONFIG_SQUASHFS_DECOMP_SINGLE=y
# CONFIG_SQUASHFS_DECOMP_MULTI is not set
# CONFIG_SQUASHFS_DECOMP_MULTI_PERCPU is not set
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
CONFIG_PSTORE_CONSOLE=y
CONFIG_PSTORE_PMSG=y
# CONFIG_PSTORE_FTRACE is not set
CONFIG_PSTORE_RAM=m
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
CONFIG_9P_FS=y
CONFIG_9P_FS_POSIX_ACL=y
# CONFIG_9P_FS_SECURITY is not set
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
CONFIG_BIG_KEYS=y
CONFIG_TRUSTED_KEYS=y
CONFIG_ENCRYPTED_KEYS=y
# CONFIG_KEY_DH_OPERATIONS is not set
# CONFIG_SECURITY_DMESG_RESTRICT is not set
CONFIG_SECURITY=y
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
# CONFIG_HARDENED_USERCOPY_PAGESPAN is not set
# CONFIG_FORTIFY_SOURCE is not set
# CONFIG_STATIC_USERMODEHELPER is not set
CONFIG_SECURITY_SELINUX=y
CONFIG_SECURITY_SELINUX_BOOTPARAM=y
# CONFIG_SECURITY_SELINUX_DISABLE is not set
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
CONFIG_EVM=y
CONFIG_EVM_ATTR_FSUUID=y
# CONFIG_EVM_ADD_XATTRS is not set
# CONFIG_EVM_LOAD_X509 is not set
CONFIG_DEFAULT_SECURITY_SELINUX=y
# CONFIG_DEFAULT_SECURITY_APPARMOR is not set
# CONFIG_DEFAULT_SECURITY_DAC is not set
CONFIG_LSM="lockdown,yama,loadpin,safesetid,integrity,selinux,smack,tomoyo,apparmor"

#
# Kernel hardening options
#

#
# Memory initialization
#
CONFIG_INIT_STACK_NONE=y
# CONFIG_GCC_PLUGIN_STRUCTLEAK_USER is not set
# CONFIG_GCC_PLUGIN_STRUCTLEAK_BYREF is not set
# CONFIG_GCC_PLUGIN_STRUCTLEAK_BYREF_ALL is not set
# CONFIG_GCC_PLUGIN_STACKLEAK is not set
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
CONFIG_CRYPTO_CRYPTD=m
CONFIG_CRYPTO_AUTHENC=m
CONFIG_CRYPTO_TEST=m
CONFIG_CRYPTO_SIMD=m
CONFIG_CRYPTO_GLUE_HELPER_X86=m
CONFIG_CRYPTO_ENGINE=m

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
# CONFIG_CRYPTO_CHACHA20POLY1305 is not set
# CONFIG_CRYPTO_AEGIS128 is not set
# CONFIG_CRYPTO_AEGIS128_AESNI_SSE2 is not set
CONFIG_CRYPTO_SEQIV=y
CONFIG_CRYPTO_ECHAINIV=m

#
# Block modes
#
CONFIG_CRYPTO_CBC=y
# CONFIG_CRYPTO_CFB is not set
CONFIG_CRYPTO_CTR=y
CONFIG_CRYPTO_CTS=m
CONFIG_CRYPTO_ECB=y
CONFIG_CRYPTO_LRW=m
# CONFIG_CRYPTO_OFB is not set
CONFIG_CRYPTO_PCBC=m
CONFIG_CRYPTO_XTS=m
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
# CONFIG_CRYPTO_POLY1305 is not set
# CONFIG_CRYPTO_POLY1305_X86_64 is not set
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
CONFIG_CRYPTO_SHA512=m
# CONFIG_CRYPTO_SHA3 is not set
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
CONFIG_CRYPTO_AES_NI_INTEL=m
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
# CONFIG_CRYPTO_DES3_EDE_X86_64 is not set
CONFIG_CRYPTO_FCRYPT=m
CONFIG_CRYPTO_KHAZAD=m
CONFIG_CRYPTO_SALSA20=m
# CONFIG_CRYPTO_CHACHA20 is not set
# CONFIG_CRYPTO_CHACHA20_X86_64 is not set
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
CONFIG_CRYPTO_USER_API_RNG=m
# CONFIG_CRYPTO_USER_API_AEAD is not set
# CONFIG_CRYPTO_STATS is not set
CONFIG_CRYPTO_HASH_INFO=y

#
# Crypto library routines
#
CONFIG_CRYPTO_LIB_AES=y
CONFIG_CRYPTO_LIB_ARC4=m
# CONFIG_CRYPTO_LIB_BLAKE2S is not set
# CONFIG_CRYPTO_LIB_CHACHA is not set
# CONFIG_CRYPTO_LIB_CURVE25519 is not set
CONFIG_CRYPTO_LIB_DES=m
CONFIG_CRYPTO_LIB_POLY1305_RSIZE=11
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
# CONFIG_CRYPTO_DEV_NITROX_CNN55XX is not set
CONFIG_CRYPTO_DEV_CHELSIO=m
CONFIG_CRYPTO_DEV_VIRTIO=m
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
CONFIG_PRIME_NUMBERS=m
CONFIG_RATIONAL=y
CONFIG_GENERIC_PCI_IOMAP=y
CONFIG_GENERIC_IOMAP=y
CONFIG_ARCH_USE_CMPXCHG_LOCKREF=y
CONFIG_ARCH_HAS_FAST_MULTIPLIER=y
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
# CONFIG_CRC7 is not set
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
CONFIG_ZSTD_DECOMPRESS=m
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
CONFIG_GENERIC_ALLOCATOR=y
CONFIG_REED_SOLOMON=m
CONFIG_REED_SOLOMON_ENC8=y
CONFIG_REED_SOLOMON_DEC8=y
CONFIG_TEXTSEARCH=y
CONFIG_TEXTSEARCH_KMP=m
CONFIG_TEXTSEARCH_BM=m
CONFIG_TEXTSEARCH_FSM=m
CONFIG_BTREE=y
CONFIG_INTERVAL_TREE=y
CONFIG_XARRAY_MULTI=y
CONFIG_ASSOCIATIVE_ARRAY=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT_MAP=y
CONFIG_HAS_DMA=y
CONFIG_NEED_SG_DMA_LENGTH=y
CONFIG_NEED_DMA_MAP_STATE=y
CONFIG_ARCH_DMA_ADDR_T_64BIT=y
CONFIG_ARCH_HAS_FORCE_DMA_UNENCRYPTED=y
CONFIG_DMA_VIRT_OPS=y
CONFIG_SWIOTLB=y
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
CONFIG_IOMMU_HELPER=y
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
CONFIG_SYMBOLIC_ERRNAME=y
CONFIG_DEBUG_BUGVERBOSE=y
# end of printk and dmesg options

#
# Compile-time checks and compiler options
#
CONFIG_DEBUG_INFO=y
CONFIG_DEBUG_INFO_REDUCED=y
# CONFIG_DEBUG_INFO_SPLIT is not set
# CONFIG_DEBUG_INFO_DWARF4 is not set
# CONFIG_DEBUG_INFO_BTF is not set
# CONFIG_GDB_SCRIPTS is not set
CONFIG_ENABLE_MUST_CHECK=y
CONFIG_FRAME_WARN=2048
CONFIG_STRIP_ASM_SYMS=y
# CONFIG_READABLE_ASM is not set
# CONFIG_HEADERS_INSTALL is not set
CONFIG_OPTIMIZE_INLINING=y
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
CONFIG_DEBUG_FS=y
CONFIG_HAVE_ARCH_KGDB=y
# CONFIG_KGDB is not set
CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
# CONFIG_UBSAN is not set
CONFIG_UBSAN_ALIGNMENT=y
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
CONFIG_DEBUG_RODATA_TEST=y
CONFIG_GENERIC_PTDUMP=y
# CONFIG_PTDUMP_DEBUGFS is not set
# CONFIG_DEBUG_OBJECTS is not set
# CONFIG_SLUB_DEBUG_ON is not set
# CONFIG_SLUB_STATS is not set
CONFIG_HAVE_DEBUG_KMEMLEAK=y
# CONFIG_DEBUG_KMEMLEAK is not set
# CONFIG_DEBUG_STACK_USAGE is not set
# CONFIG_SCHED_STACK_END_CHECK is not set
# CONFIG_DEBUG_VM is not set
CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
# CONFIG_DEBUG_VIRTUAL is not set
CONFIG_DEBUG_MEMORY_INIT=y
CONFIG_MEMORY_NOTIFIER_ERROR_INJECT=m
# CONFIG_DEBUG_PER_CPU_MAPS is not set
CONFIG_HAVE_ARCH_KASAN=y
CONFIG_HAVE_ARCH_KASAN_VMALLOC=y
CONFIG_CC_HAS_KASAN_GENERIC=y
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
CONFIG_WW_MUTEX_SELFTEST=m
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
# CONFIG_BUG_ON_DATA_CORRUPTION is not set
# end of Debug kernel data structures

# CONFIG_DEBUG_CREDENTIALS is not set

#
# RCU Debugging
#
CONFIG_TORTURE_TEST=m
CONFIG_RCU_PERF_TEST=m
CONFIG_RCU_TORTURE_TEST=m
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
# CONFIG_PREEMPTIRQ_EVENTS is not set
# CONFIG_IRQSOFF_TRACER is not set
CONFIG_SCHED_TRACER=y
CONFIG_HWLAT_TRACER=y
# CONFIG_MMIOTRACE is not set
CONFIG_FTRACE_SYSCALLS=y
CONFIG_TRACER_SNAPSHOT=y
# CONFIG_TRACER_SNAPSHOT_PER_CPU_SWAP is not set
CONFIG_BRANCH_PROFILE_NONE=y
# CONFIG_PROFILE_ANNOTATED_BRANCHES is not set
# CONFIG_PROFILE_ALL_BRANCHES is not set
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
CONFIG_PROVIDE_OHCI1394_DMA_INIT=y
# CONFIG_SAMPLES is not set
CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y
CONFIG_STRICT_DEVMEM=y
# CONFIG_IO_STRICT_DEVMEM is not set

#
# x86 Debugging
#
CONFIG_TRACE_IRQFLAGS_SUPPORT=y
CONFIG_EARLY_PRINTK_USB=y
CONFIG_X86_VERBOSE_BOOTUP=y
CONFIG_EARLY_PRINTK=y
CONFIG_EARLY_PRINTK_DBGP=y
# CONFIG_EARLY_PRINTK_USB_XDBC is not set
# CONFIG_EFI_PGT_DUMP is not set
# CONFIG_DEBUG_WX is not set
CONFIG_DOUBLEFAULT=y
# CONFIG_DEBUG_TLBFLUSH is not set
# CONFIG_IOMMU_DEBUG is not set
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
CONFIG_X86_DEBUG_FPU=y
# CONFIG_PUNIT_ATOM_DEBUG is not set
CONFIG_UNWINDER_ORC=y
# CONFIG_UNWINDER_FRAME_POINTER is not set
# CONFIG_UNWINDER_GUESS is not set
# end of x86 Debugging

#
# Kernel Testing and Coverage
#
# CONFIG_KUNIT is not set
CONFIG_NOTIFIER_ERROR_INJECTION=m
CONFIG_PM_NOTIFIER_ERROR_INJECT=m
# CONFIG_NETDEV_NOTIFIER_ERROR_INJECT is not set
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
CONFIG_TEST_STRSCPY=m
# CONFIG_TEST_KSTRTOX is not set
CONFIG_TEST_PRINTF=m
CONFIG_TEST_BITMAP=m
# CONFIG_TEST_BITFIELD is not set
# CONFIG_TEST_UUID is not set
# CONFIG_TEST_XARRAY is not set
# CONFIG_TEST_OVERFLOW is not set
# CONFIG_TEST_RHASHTABLE is not set
# CONFIG_TEST_HASH is not set
# CONFIG_TEST_IDA is not set
CONFIG_TEST_LKM=m
CONFIG_TEST_VMALLOC=m
CONFIG_TEST_USER_COPY=m
CONFIG_TEST_BPF=m
CONFIG_TEST_BLACKHOLE_DEV=m
# CONFIG_FIND_BIT_BENCHMARK is not set
CONFIG_TEST_FIRMWARE=m
CONFIG_TEST_SYSCTL=m
# CONFIG_TEST_UDELAY is not set
CONFIG_TEST_STATIC_KEYS=m
CONFIG_TEST_KMOD=m
# CONFIG_TEST_MEMCAT_P is not set
CONFIG_TEST_LIVEPATCH=m
# CONFIG_TEST_STACKINIT is not set
# CONFIG_TEST_MEMINIT is not set
# CONFIG_MEMTEST is not set
# CONFIG_HYPERV_TESTING is not set
# end of Kernel Testing and Coverage
# end of Kernel hacking

--mOKeRhn3B7HglGBY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=job-script

#!/bin/sh

export_top_env()
{
	export suite='filebench'
	export testcase='filebench'
	export category='benchmark'
	export job_origin='/lkp/lkp/.src-20200413-085638/allot/cyclic:p2:linux-devel:devel-hourly/lkp-hsw-d01/filebench-part1.yaml'
	export queue_cmdline_keys='branch
commit
queue_at_least_once'
	export queue='validate'
	export testbox='lkp-hsw-d01'
	export tbox_group='lkp-hsw-d01'
	export submit_id='5e958a283f35fd48a32ac101'
	export job_file='/lkp/jobs/scheduled/lkp-hsw-d01/filebench-performance-1HDD-xfs-fileserver.f-ucode=0x27-debian-x86_64-20191114.cgz-ef6d7398f5c72c4fa030740a7552d00ecbf4abd7-20200414-18595-1v574po-3.yaml'
	export id='cb680952c35d60c172975bc16fff09d164bb0a94'
	export queuer_version='/lkp-src'
	export model='Haswell'
	export nr_node=1
	export nr_cpu=8
	export memory='8G'
	export nr_hdd_partitions=1
	export hdd_partitions='/dev/disk/by-id/ata-WDC_WD1002FAEX-00Z3A0_WD-WCATR5433073-part2'
	export swap_partitions=
	export rootfs_partition='/dev/disk/by-id/ata-WDC_WD1002FAEX-00Z3A0_WD-WCATR5433073-part1'
	export brand='Intel(R) Core(TM) i7-4770 CPU @ 3.40GHz'
	export need_kconfig='CONFIG_BLK_DEV_SD
CONFIG_SCSI
CONFIG_BLOCK=y
CONFIG_SATA_AHCI
CONFIG_SATA_AHCI_PLATFORM
CONFIG_ATA
CONFIG_PCI=y
CONFIG_XFS_FS'
	export commit='ef6d7398f5c72c4fa030740a7552d00ecbf4abd7'
	export ucode='0x27'
	export need_kconfig_hw='CONFIG_E1000E=y
CONFIG_ATA_SFF=y
CONFIG_ATA_BMDMA=y
CONFIG_ATA_PIIX'
	export kconfig='x86_64-rhel-7.6'
	export compiler='gcc-7'
	export enqueue_time='2020-04-14 18:02:18 +0800'
	export _id='5e958a2a3f35fd48a32ac102'
	export _rt='/result/filebench/performance-1HDD-xfs-fileserver.f-ucode=0x27/lkp-hsw-d01/debian-x86_64-20191114.cgz/x86_64-rhel-7.6/gcc-7/ef6d7398f5c72c4fa030740a7552d00ecbf4abd7'
	export user='lkp'
	export head_commit='2b8dd3e6f74157a8e65572769f369657d1664b2d'
	export base_commit='8f3d9f354286745c751374f5f1fcafee6b3f3136'
	export branch='linux-devel/devel-hourly-2020041317'
	export rootfs='debian-x86_64-20191114.cgz'
	export result_root='/result/filebench/performance-1HDD-xfs-fileserver.f-ucode=0x27/lkp-hsw-d01/debian-x86_64-20191114.cgz/x86_64-rhel-7.6/gcc-7/ef6d7398f5c72c4fa030740a7552d00ecbf4abd7/3'
	export scheduler_version='/lkp/lkp/.src-20200414-102605'
	export LKP_SERVER='inn'
	export arch='x86_64'
	export max_uptime=1188.06
	export initrd='/osimage/debian/debian-x86_64-20191114.cgz'
	export bootloader_append='root=/dev/ram0
user=lkp
job=/lkp/jobs/scheduled/lkp-hsw-d01/filebench-performance-1HDD-xfs-fileserver.f-ucode=0x27-debian-x86_64-20191114.cgz-ef6d7398f5c72c4fa030740a7552d00ecbf4abd7-20200414-18595-1v574po-3.yaml
ARCH=x86_64
kconfig=x86_64-rhel-7.6
branch=linux-devel/devel-hourly-2020041317
commit=ef6d7398f5c72c4fa030740a7552d00ecbf4abd7
BOOT_IMAGE=/pkg/linux/x86_64-rhel-7.6/gcc-7/ef6d7398f5c72c4fa030740a7552d00ecbf4abd7/vmlinuz-5.6.0-00207-gef6d7398f5c72
max_uptime=1188
RESULT_ROOT=/result/filebench/performance-1HDD-xfs-fileserver.f-ucode=0x27/lkp-hsw-d01/debian-x86_64-20191114.cgz/x86_64-rhel-7.6/gcc-7/ef6d7398f5c72c4fa030740a7552d00ecbf4abd7/3
LKP_SERVER=inn
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
	export modules_initrd='/pkg/linux/x86_64-rhel-7.6/gcc-7/ef6d7398f5c72c4fa030740a7552d00ecbf4abd7/modules.cgz'
	export bm_initrd='/osimage/deps/debian-x86_64-20180403.cgz/run-ipconfig_2018-04-03.cgz,/osimage/deps/debian-x86_64-20180403.cgz/lkp_2019-08-05.cgz,/osimage/deps/debian-x86_64-20180403.cgz/rsync-rootfs_2018-04-03.cgz,/osimage/deps/debian-x86_64-20180403.cgz/fs_2020-01-02.cgz,/osimage/pkg/debian-x86_64-20180403.cgz/filebench-x86_64-a3b9f0b-1_2020-01-02.cgz,/osimage/deps/debian-x86_64-20180403.cgz/mpstat_2020-01-03.cgz,/osimage/deps/debian-x86_64-20180403.cgz/vmstat_2020-01-07.cgz,/osimage/deps/debian-x86_64-20180403.cgz/perf_20200325.cgz,/osimage/pkg/debian-x86_64-20180403.cgz/perf-x86_64-76ccd234269b-1_20200325.cgz,/osimage/pkg/debian-x86_64-20180403.cgz/sar-x86_64-e011d97-1_2020-01-03.cgz,/osimage/deps/debian-x86_64-20180403.cgz/hw_2020-01-02.cgz'
	export lkp_initrd='/osimage/user/lkp/lkp-x86_64.cgz'
	export site='inn'
	export LKP_CGI_PORT=80
	export LKP_CIFS_PORT=139
	export last_kernel='5.7.0-rc1-02604-g2b8dd3e6f74157'
	export repeat_to=4
	export schedule_notify_address=
	export queue_at_least_once=1
	export kernel='/pkg/linux/x86_64-rhel-7.6/gcc-7/ef6d7398f5c72c4fa030740a7552d00ecbf4abd7/vmlinuz-5.6.0-00207-gef6d7398f5c72'
	export dequeue_time='2020-04-14 18:09:40 +0800'
	export job_initrd='/lkp/jobs/scheduled/lkp-hsw-d01/filebench-performance-1HDD-xfs-fileserver.f-ucode=0x27-debian-x86_64-20191114.cgz-ef6d7398f5c72c4fa030740a7552d00ecbf4abd7-20200414-18595-1v574po-3.cgz'

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

	run_setup fs='xfs' $LKP_SRC/setup/fs

	run_setup $LKP_SRC/setup/cpufreq_governor 'performance'

	run_monitor $LKP_SRC/monitors/wrapper kmsg
	run_monitor $LKP_SRC/monitors/no-stdout/wrapper boot-time
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

	run_test test='fileserver.f' $LKP_SRC/tests/wrapper filebench
}

extract_stats()
{
	export stats_part_begin=
	export stats_part_end=

	$LKP_SRC/stats/wrapper filebench
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper boot-time
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

	$LKP_SRC/stats/wrapper time filebench.time
	$LKP_SRC/stats/wrapper dmesg
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper last_state
	$LKP_SRC/stats/wrapper stderr
	$LKP_SRC/stats/wrapper time
}

"$@"

--mOKeRhn3B7HglGBY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="job.yaml"

---

#! jobs/filebench-part1.yaml
suite: filebench
testcase: filebench
category: benchmark
disk: 1HDD
fs: xfs
filebench:
  test: fileserver.f
job_origin: "/lkp/lkp/.src-20200413-085638/allot/cyclic:p2:linux-devel:devel-hourly/lkp-hsw-d01/filebench-part1.yaml"

#! queue options
queue_cmdline_keys:
- branch
- commit
- queue_at_least_once
queue: bisect
testbox: lkp-hsw-d01
tbox_group: lkp-hsw-d01
submit_id: 5e957aa33f35fd47bcb8451b
job_file: "/lkp/jobs/scheduled/lkp-hsw-d01/filebench-performance-1HDD-xfs-fileserver.f-ucode=0x27-debian-x86_64-20191114.cgz-ef6d7398f5c72c4fa030740a7552d00ecbf4abd7-20200414-18364-ejuhi7-0.yaml"
id: 0cde090abe8ab316604a3b4e039f9f183a0c0d89
queuer_version: "/lkp-src"

#! hosts/lkp-hsw-d01
model: Haswell
nr_node: 1
nr_cpu: 8
memory: 8G
nr_hdd_partitions: 1
hdd_partitions: "/dev/disk/by-id/ata-WDC_WD1002FAEX-00Z3A0_WD-WCATR5433073-part2"
swap_partitions: 
rootfs_partition: "/dev/disk/by-id/ata-WDC_WD1002FAEX-00Z3A0_WD-WCATR5433073-part1"
brand: Intel(R) Core(TM) i7-4770 CPU @ 3.40GHz

#! include/category/benchmark
kmsg: 
boot-time: 
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

#! include/disk/nr_hdd
need_kconfig:
- CONFIG_BLK_DEV_SD
- CONFIG_SCSI
- CONFIG_BLOCK=y
- CONFIG_SATA_AHCI
- CONFIG_SATA_AHCI_PLATFORM
- CONFIG_ATA
- CONFIG_PCI=y
- CONFIG_XFS_FS

#! include/queue/cyclic
commit: ef6d7398f5c72c4fa030740a7552d00ecbf4abd7

#! include/testbox/lkp-hsw-d01
ucode: '0x27'
need_kconfig_hw:
- CONFIG_E1000E=y
- CONFIG_ATA_SFF=y
- CONFIG_ATA_BMDMA=y
- CONFIG_ATA_PIIX

#! include/fs/OTHERS

#! default params
kconfig: x86_64-rhel-7.6
compiler: gcc-7
enqueue_time: 2020-04-14 16:56:06.222751443 +08:00
_id: 5e957aa33f35fd47bcb8451b
_rt: "/result/filebench/performance-1HDD-xfs-fileserver.f-ucode=0x27/lkp-hsw-d01/debian-x86_64-20191114.cgz/x86_64-rhel-7.6/gcc-7/ef6d7398f5c72c4fa030740a7552d00ecbf4abd7"

#! schedule options
user: lkp
head_commit: 2b8dd3e6f74157a8e65572769f369657d1664b2d
base_commit: 8f3d9f354286745c751374f5f1fcafee6b3f3136
branch: linux-devel/devel-hourly-2020041317
rootfs: debian-x86_64-20191114.cgz
result_root: "/result/filebench/performance-1HDD-xfs-fileserver.f-ucode=0x27/lkp-hsw-d01/debian-x86_64-20191114.cgz/x86_64-rhel-7.6/gcc-7/ef6d7398f5c72c4fa030740a7552d00ecbf4abd7/0"
scheduler_version: "/lkp/lkp/.src-20200414-102605"
LKP_SERVER: inn
arch: x86_64
max_uptime: 1188.06
initrd: "/osimage/debian/debian-x86_64-20191114.cgz"
bootloader_append:
- root=/dev/ram0
- user=lkp
- job=/lkp/jobs/scheduled/lkp-hsw-d01/filebench-performance-1HDD-xfs-fileserver.f-ucode=0x27-debian-x86_64-20191114.cgz-ef6d7398f5c72c4fa030740a7552d00ecbf4abd7-20200414-18364-ejuhi7-0.yaml
- ARCH=x86_64
- kconfig=x86_64-rhel-7.6
- branch=linux-devel/devel-hourly-2020041317
- commit=ef6d7398f5c72c4fa030740a7552d00ecbf4abd7
- BOOT_IMAGE=/pkg/linux/x86_64-rhel-7.6/gcc-7/ef6d7398f5c72c4fa030740a7552d00ecbf4abd7/vmlinuz-5.6.0-00207-gef6d7398f5c72
- max_uptime=1188
- RESULT_ROOT=/result/filebench/performance-1HDD-xfs-fileserver.f-ucode=0x27/lkp-hsw-d01/debian-x86_64-20191114.cgz/x86_64-rhel-7.6/gcc-7/ef6d7398f5c72c4fa030740a7552d00ecbf4abd7/0
- LKP_SERVER=inn
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
modules_initrd: "/pkg/linux/x86_64-rhel-7.6/gcc-7/ef6d7398f5c72c4fa030740a7552d00ecbf4abd7/modules.cgz"
bm_initrd: "/osimage/deps/debian-x86_64-20180403.cgz/run-ipconfig_2018-04-03.cgz,/osimage/deps/debian-x86_64-20180403.cgz/lkp_2019-08-05.cgz,/osimage/deps/debian-x86_64-20180403.cgz/rsync-rootfs_2018-04-03.cgz,/osimage/deps/debian-x86_64-20180403.cgz/fs_2020-01-02.cgz,/osimage/pkg/debian-x86_64-20180403.cgz/filebench-x86_64-a3b9f0b-1_2020-01-02.cgz,/osimage/deps/debian-x86_64-20180403.cgz/mpstat_2020-01-03.cgz,/osimage/deps/debian-x86_64-20180403.cgz/vmstat_2020-01-07.cgz,/osimage/deps/debian-x86_64-20180403.cgz/perf_20200325.cgz,/osimage/pkg/debian-x86_64-20180403.cgz/perf-x86_64-76ccd234269b-1_20200325.cgz,/osimage/pkg/debian-x86_64-20180403.cgz/sar-x86_64-e011d97-1_2020-01-03.cgz,/osimage/deps/debian-x86_64-20180403.cgz/hw_2020-01-02.cgz"
lkp_initrd: "/osimage/user/lkp/lkp-x86_64.cgz"
site: inn

#! /lkp/lkp/.src-20200413-124813/include/site/inn
LKP_CGI_PORT: 80
LKP_CIFS_PORT: 139
oom-killer: 
watchdog: 

#! runtime status
last_kernel: 4.20.0
repeat_to: 2
schedule_notify_address: 

#! user overrides
queue_at_least_once: 0
kernel: "/pkg/linux/x86_64-rhel-7.6/gcc-7/ef6d7398f5c72c4fa030740a7552d00ecbf4abd7/vmlinuz-5.6.0-00207-gef6d7398f5c72"
dequeue_time: 2020-04-14 17:56:11.832220713 +08:00

#! /lkp/lkp/.src-20200414-102605/include/site/inn
job_state: finished
loadavg: 28.90 9.57 3.37 1/171 2293
start_time: '1586858217'
end_time: '1586858280'
version: "/lkp/lkp/.src-20200414-102639:d3f84cc3:0191a4542"

--mOKeRhn3B7HglGBY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=reproduce

dmsetup remove_all
wipefs -a --force /dev/sda2
mkfs -t xfs -f /dev/sda2
mkdir -p /fs/sda2
modprobe xfs
mount -t xfs -o inode64 /dev/sda2 /fs/sda2

for cpu_dir in /sys/devices/system/cpu/cpu[0-9]*
do
	online_file="$cpu_dir"/online
	[ -f "$online_file" ] && [ "$(cat "$online_file")" -eq 0 ] && continue

	file="$cpu_dir"/cpufreq/scaling_governor
	[ -f "$file" ] && echo "performance" > "$file"
done

filebench -f /lkp/benchmarks/filebench/share/filebench/workloads/fileserver.f

--mOKeRhn3B7HglGBY--
