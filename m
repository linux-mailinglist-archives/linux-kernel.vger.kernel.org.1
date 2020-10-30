Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D41C129FE57
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 08:18:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725974AbgJ3HSX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 03:18:23 -0400
Received: from mga09.intel.com ([134.134.136.24]:17240 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725790AbgJ3HSW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 03:18:22 -0400
IronPort-SDR: JQgejqLU++m0mOnDR7U5x7um4fDWJR+LlM8RNXKFnEhP99EI1YpB26ZAPOlBpN9y+LrbIeNVni
 w4f3GKT7WmLA==
X-IronPort-AV: E=McAfee;i="6000,8403,9789"; a="168700658"
X-IronPort-AV: E=Sophos;i="5.77,432,1596524400"; 
   d="yaml'?scan'208";a="168700658"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2020 00:18:10 -0700
IronPort-SDR: dJNpZWKiRW5onrkMxi/F6QaJuW7FH63MSRFsl4V/TEaFm7fDT3nAJBCy4PHjuAadPQg/4hV6A0
 kP2JVVusAKMA==
X-IronPort-AV: E=Sophos;i="5.77,432,1596524400"; 
   d="yaml'?scan'208";a="536974142"
Received: from shao2-debian.sh.intel.com (HELO localhost) ([10.239.13.3])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2020 00:18:04 -0700
Date:   Fri, 30 Oct 2020 15:17:15 +0800
From:   kernel test robot <rong.a.chen@intel.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Huang Ying <ying.huang@intel.com>,
        Hugh Dickins <hughd@google.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Matthew Auld <matthew.auld@intel.com>,
        William Kucharski <william.kucharski@oracle.com>,
        Qian Cai <cai@redhat.com>, LKML <linux-kernel@vger.kernel.org>,
        lkp@lists.01.org, lkp@intel.com, feng.tang@intel.com,
        zhengjun.xing@intel.com
Subject: [mm] e6e88712e4: stress-ng.tmpfs.ops_per_sec -69.7% regression
Message-ID: <20201030071715.GV31092@shao2-debian>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="gMqNd2jlyJQcupG/"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: NeoMutt/20170113 (1.7.2)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gMqNd2jlyJQcupG/
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Greeting,

FYI, we noticed a -100.0% regression of stress-ng.tmpfs.ops_per_sec due to commit:


commit: e6e88712e43b7942df451508aafc2f083266f56b ("mm: optimise madvise WILLNEED")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master


in testcase: stress-ng
on test machine: 96 threads Intel(R) Xeon(R) Gold 6252 CPU @ 2.10GHz with 192G memory
with following parameters:

	nr_threads: 100%
	disk: 1HDD
	testtime: 100s
	class: memory
	cpufreq_governor: performance
	ucode: 0x5002f01




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
class/compiler/cpufreq_governor/disk/kconfig/nr_threads/rootfs/tbox_group/testcase/testtime/ucode:
  memory/gcc-9/performance/1HDD/x86_64-rhel-8.3/100%/debian-10.4-x86_64-20200603.cgz/lkp-csl-2sp3/stress-ng/100s/0x400002c

commit: 
  f5df8635c5a3c912919c91be64aa198554b0f9ed
  e6e88712e43b7942df451508aafc2f083266f56b

f5df8635c5a3c912 e6e88712e43b7942df451508aaf 
---------------- --------------------------- 
       fail:runs  %reproduction    fail:runs
           |             |             |    
        423:5        51243%        2986:5     dmesg.timestamp:last
           :5           40%           2:5     last_state.exit_fail
           :5           40%           2:5     last_state.is_incomplete_run
           :5            0%            :5     last_state.running
           :5           40%           2:5     last_state.soft_timeout
           :5           40%           2:5     last_state.test.stress-ng.exit_code.143
          3:5           40%           5:5     kmsg.EDAC_skx:Can't_find_size_for_NVDIMM_ADR=#/SMBIOS=
          1:5          -20%            :5     kmsg.ioatdma#:#:#:Errors
          1:5          -20%            :5     kmsg.ioatdma#:#:#:ioat_timer_event:Channel_halted(#)
         69:5          836%         111:5     kmsg.timestamp:EDAC_skx:Can't_find_size_for_NVDIMM_ADR=#/SMBIOS=
         23:5         -473%            :5     kmsg.timestamp:ioatdma#:#:#:Errors
         23:5         -472%            :5     kmsg.timestamp:ioatdma#:#:#:ioat_timer_event:Channel_halted(#)
        423:5        69754%        3911:5     kmsg.timestamp:last
          5:5          -40%           3:5     stderr.Aborted
          5:5          -40%           3:5     stderr.Events_disabled
          5:5          -40%           3:5     stderr.Events_enabled
          5:5          -40%           3:5     stderr.[perf_record:Woken_up#times_to_write_data]
          5:5          -40%           3:5     stderr.has_stderr
          1:5            0%           1:5     stderr.ls:cannot_access'%perf_data':No_such_file_or_directory
          1:5          -20%            :5     stderr.malloc():corrupted_top_size
          4:5          -20%           3:5     stderr.malloc():invalid_size(unsorted)
          0:5            0%           0:5     perf-profile.children.cycles-pp.error_entry
           :5            3%           0:5     perf-profile.self.cycles-pp.error_entry
         %stddev     %change         %stddev
             \          |                \  
    108.08            -1.0%     107.00        stress-ng.time.elapsed_time
    108.08            -1.0%     107.00        stress-ng.time.elapsed_time.max
     26521 ± 20%     +76.4%      46780 ±  3%  stress-ng.time.involuntary_context_switches
   3248307 ± 20%     +54.5%    5019072 ± 19%  stress-ng.time.major_page_faults
    675875            -0.1%     675470        stress-ng.time.maximum_resident_set_size
  92279190 ± 12%     -47.3%   48660512        stress-ng.time.minor_page_faults
      4096            +0.0%       4096        stress-ng.time.page_size
      3951 ±  8%     +88.7%       7453 ±  2%  stress-ng.time.percent_of_cpu_this_job_got
      3370 ±  9%    +117.9%       7343        stress-ng.time.system_time
    900.24 ±  7%     -29.7%     632.56 ±  2%  stress-ng.time.user_time
      1343           -16.1%       1127 ±  2%  stress-ng.time.voluntary_context_switches
      1198 ±  4%     -69.7%     362.67        stress-ng.tmpfs.ops
     11.62 ±  4%     -69.7%       3.52        stress-ng.tmpfs.ops_per_sec
    138.01            -1.0%     136.69        uptime.boot
      2795 ±  2%      -1.2%       2760        uptime.idle
     27.54 ±  2%      -0.2%      27.48 ±  2%  boot-time.boot
     20.59            -0.4%      20.50        boot-time.dhcp
      2209 ±  2%      +0.1%       2212 ±  2%  boot-time.idle
      0.95 ± 11%      -9.6%       0.86        boot-time.smp_boot
      6.15 ±  2%      +1.6%       6.25 ±  9%  iostat.cpu.idle
      0.01 ± 59%     -15.0%       0.01 ±100%  iostat.cpu.iowait
     74.40           +15.8%      86.14        iostat.cpu.system
     19.44 ±  5%     -60.9%       7.61        iostat.cpu.user
      4.53 ±  3%      +0.1        4.58 ± 12%  mpstat.cpu.all.idle%
      0.00 ± 80%      -0.0        0.00 ±141%  mpstat.cpu.all.iowait%
      0.22 ±  3%      +0.4        0.65 ±  4%  mpstat.cpu.all.irq%
      0.01 ± 10%      +0.0        0.02 ± 15%  mpstat.cpu.all.soft%
     75.45           +11.6       87.00        mpstat.cpu.all.sys%
     19.79 ±  5%     -12.0        7.74        mpstat.cpu.all.usr%
   1884655 ±137%     -80.5%     367657 ± 16%  cpuidle.C1.time
      5320 ±146%     -77.2%       1211 ±  8%  cpuidle.C1.usage
   3346442 ± 25%     -38.8%    2047933 ± 18%  cpuidle.C1E.time
      8085 ± 26%     -40.9%       4775 ± 15%  cpuidle.C1E.usage
 4.879e+08 ±  4%      -2.7%  4.747e+08 ±  5%  cpuidle.C6.time
    184919 ± 13%     -24.0%     140448 ± 18%  cpuidle.C6.usage
    782.80 ± 70%     -70.6%     230.33 ± 38%  cpuidle.POLL.time
    207.60 ±120%     -78.3%      45.00 ± 35%  cpuidle.POLL.usage
      0.00          -100.0%       0.00        numa-numastat.node0.interleave_hit
   8845248            -7.2%    8207045        numa-numastat.node0.local_node
   8872518            -7.2%    8235955        numa-numastat.node0.numa_hit
     27274 ± 39%      +6.0%      28909 ± 70%  numa-numastat.node0.other_node
      0.00          -100.0%       0.00        numa-numastat.node1.interleave_hit
   8857958            +0.3%    8880677        numa-numastat.node1.local_node
   8874087            +0.2%    8895138        numa-numastat.node1.numa_hit
     16133 ± 66%     -10.3%      14467 ±141%  numa-numastat.node1.other_node
    108.08            -1.0%     107.00        time.elapsed_time
    108.08            -1.0%     107.00        time.elapsed_time.max
     26521 ± 20%     +76.4%      46780 ±  3%  time.involuntary_context_switches
   3248307 ± 20%     +54.5%    5019072 ± 19%  time.major_page_faults
    675875            -0.1%     675470        time.maximum_resident_set_size
  92279190 ± 12%     -47.3%   48660512        time.minor_page_faults
      4096            +0.0%       4096        time.page_size
      3951 ±  8%     +88.7%       7453 ±  2%  time.percent_of_cpu_this_job_got
      3370 ±  9%    +117.9%       7343        time.system_time
    900.24 ±  7%     -29.7%     632.56 ±  2%  time.user_time
      1343           -16.1%       1127 ±  2%  time.voluntary_context_switches
      6.00            -5.6%       5.67 ±  8%  vmstat.cpu.id
     73.80           +16.1%      85.67        vmstat.cpu.sy
     19.20 ±  6%     -63.5%       7.00        vmstat.cpu.us
      0.00          -100.0%       0.00        vmstat.cpu.wa
      0.40 ±200%    -100.0%       0.00        vmstat.io.bi
      2.60 ±200%    -100.0%       0.00        vmstat.io.bo
      4.40 ± 18%      -9.1%       4.00        vmstat.memory.buff
  61205822            -0.0%   61180200        vmstat.memory.cache
  68665018            -0.4%   68399944        vmstat.memory.free
      0.00          -100.0%       0.00        vmstat.procs.b
     90.00            +0.4%      90.33        vmstat.procs.r
      1577 ±  6%     -19.5%       1269        vmstat.system.cs
    155950            +4.9%     163607        vmstat.system.in
  31436258           +22.8%   38613269        meminfo.Active
  31436086           +22.8%   38613201        meminfo.Active(anon)
    170.60 ±107%     -60.3%      67.67 ± 33%  meminfo.Active(file)
    128020 ±  4%      +2.5%     131201 ±  3%  meminfo.AnonHugePages
    540756 ± 11%     -10.6%     483387 ±  7%  meminfo.AnonPages
      4.40 ± 18%      -9.1%       4.00        meminfo.Buffers
  61444796            +0.0%   61468357        meminfo.Cached
    194552            +0.0%     194552        meminfo.CmaFree
    204800            +0.0%     204800        meminfo.CmaTotal
  65845924            +0.0%   65845928        meminfo.CommitLimit
  69965026            -0.1%   69896024        meminfo.Committed_AS
 6.465e+08            -0.1%  6.459e+08        meminfo.DirectMap1G
  17274148 ±  7%     -11.0%   15370246 ±  6%  meminfo.DirectMap2M
    677172 ±  5%      +6.2%     719273 ±  2%  meminfo.DirectMap4k
     64.80 ±  9%      -2.8%      63.00        meminfo.Dirty
      2048            +0.0%       2048        meminfo.Hugepagesize
   7211066 ±  4%    +132.7%   16783208 ±  6%  meminfo.Inactive
   7210669 ±  4%    +132.8%   16782845 ±  6%  meminfo.Inactive(anon)
    396.00 ± 14%      -8.4%     362.67        meminfo.Inactive(file)
    224508            -0.6%     223245        meminfo.KReclaimable
     21529 ±  5%      -5.2%      20401 ±  3%  meminfo.KernelStack
  29107501           -47.5%   15281310        meminfo.Mapped
  67689626            -0.5%   67372180        meminfo.MemAvailable
  68195737            -0.5%   67878993        meminfo.MemFree
 1.317e+08            +0.0%  1.317e+08        meminfo.MemTotal
  63496115            +0.5%   63812865        meminfo.Memused
  22381531           -75.0%    5600796 ±  6%  meminfo.Mlocked
    111504 ±  3%      +6.3%     118584 ±  2%  meminfo.PageTables
     54026            +0.2%      54144        meminfo.Percpu
    224508            -0.6%     223245        meminfo.SReclaimable
    532214           +66.6%     886463        meminfo.SUnreclaim
  60492516            +0.0%   60516229        meminfo.Shmem
    756723           +46.6%    1109709        meminfo.Slab
  23332949           -71.9%    6552476 ±  5%  meminfo.Unevictable
 3.436e+10            +0.0%  3.436e+10        meminfo.VmallocTotal
    158453 ±  4%      -5.2%     150267        meminfo.VmallocUsed
      0.40 ±200%    -100.0%       0.00        meminfo.Writeback
    640913            +1.9%     653134        meminfo.max_used_kB
  15828901 ±  3%     +18.5%   18751296 ±  2%  numa-meminfo.node0.Active
  15828849 ±  3%     +18.5%   18751235 ±  2%  numa-meminfo.node0.Active(anon)
     50.20 ± 43%     +21.5%      61.00 ± 32%  numa-meminfo.node0.Active(file)
     89342 ± 38%     -20.1%      71395 ± 10%  numa-meminfo.node0.AnonHugePages
    299668 ± 23%     -26.8%     219240 ± 10%  numa-meminfo.node0.AnonPages
     24.60 ±109%     -10.6%      22.00 ±135%  numa-meminfo.node0.Dirty
  30889346            -3.8%   29724751        numa-meminfo.node0.FilePages
   3683538 ±  4%    +116.6%    7980276 ±  4%  numa-meminfo.node0.Inactive
   3683361 ±  4%    +116.7%    7980053 ±  4%  numa-meminfo.node0.Inactive(anon)
    176.60 ± 56%     +25.9%     222.33 ± 44%  numa-meminfo.node0.Inactive(file)
    113695 ±  3%      -6.2%     106650 ±  7%  numa-meminfo.node0.KReclaimable
     10287 ± 10%      -3.7%       9908 ±  5%  numa-meminfo.node0.KernelStack
  14627069           -50.7%    7217504 ±  2%  numa-meminfo.node0.Mapped
  33718745            +3.2%   34799393        numa-meminfo.node0.MemFree
  65676039            +0.0%   65676044        numa-meminfo.node0.MemTotal
  31957292            -3.4%   30876649        numa-meminfo.node0.MemUsed
  11196527           -75.7%    2725929 ±  7%  numa-meminfo.node0.Mlocked
     52778 ±  5%     +11.3%      58763 ±  4%  numa-meminfo.node0.PageTables
    113695 ±  3%      -6.2%     106650 ±  7%  numa-meminfo.node0.SReclaimable
    275746 ±  2%     +63.0%     449434 ±  2%  numa-meminfo.node0.SUnreclaim
  30411486            -3.9%   29239402        numa-meminfo.node0.Shmem
    389441           +42.8%     556084 ±  3%  numa-meminfo.node0.Slab
  11674021           -72.5%    3210988 ±  6%  numa-meminfo.node0.Unevictable
      0.00          -100.0%       0.00        numa-meminfo.node0.Writeback
  15637726 ±  2%     +25.7%   19663292 ±  3%  numa-meminfo.node1.Active
  15637606 ±  2%     +25.7%   19663285 ±  3%  numa-meminfo.node1.Active(anon)
    119.40 ±165%     -94.7%       6.33 ±141%  numa-meminfo.node1.Active(file)
     38463 ± 89%     +56.1%      60028 ± 15%  numa-meminfo.node1.AnonHugePages
    241882 ± 37%      +9.2%     264113 ± 16%  numa-meminfo.node1.AnonPages
     39.80 ± 74%      +3.9%      41.33 ± 70%  numa-meminfo.node1.Dirty
  30632669            +2.7%   31455689        numa-meminfo.node1.FilePages
   3559463 ±  6%    +145.7%    8746082 ± 14%  numa-meminfo.node1.Inactive
   3559243 ±  6%    +145.7%    8745941 ± 14%  numa-meminfo.node1.Inactive(anon)
    219.00 ± 67%     -36.1%     140.00 ± 70%  numa-meminfo.node1.Inactive(file)
    111003 ±  3%      +4.7%     116206 ±  6%  numa-meminfo.node1.KReclaimable
     11250 ± 10%      -6.8%      10489 ±  7%  numa-meminfo.node1.KernelStack
  14533234           -45.2%    7961730        numa-meminfo.node1.Mapped
  34398511            -3.0%   33370337        numa-meminfo.node1.MemFree
  66015814            +0.0%   66015816        numa-meminfo.node1.MemTotal
  31617302            +3.3%   32645477        numa-meminfo.node1.MemUsed
  11200859 ±  3%     -74.6%    2842334 ±  5%  numa-meminfo.node1.Mlocked
     58771 ±  7%      +2.0%      59920 ±  7%  numa-meminfo.node1.PageTables
    111003 ±  3%      +4.7%     116206 ±  6%  numa-meminfo.node1.SReclaimable
    256870 ±  3%     +69.3%     434794 ±  2%  numa-meminfo.node1.SUnreclaim
  30158245            +2.8%   30988908        numa-meminfo.node1.Shmem
    367874 ±  2%     +49.8%     551001 ±  3%  numa-meminfo.node1.Slab
  11674780 ±  3%     -71.7%    3308958 ±  5%  numa-meminfo.node1.Unevictable
      0.00          -100.0%       0.00        numa-meminfo.node1.Writeback
      0.00          -100.0%       0.00        proc-vmstat.compact_isolated
   7857318           +22.1%    9591743        proc-vmstat.nr_active_anon
     42.00 ±109%     -60.3%      16.67 ± 32%  proc-vmstat.nr_active_file
    135135 ± 11%     -10.7%     120681 ±  7%  proc-vmstat.nr_anon_pages
     62.00 ±  4%      +2.7%      63.67 ±  2%  proc-vmstat.nr_anon_transparent_hugepages
    130.40 ±108%     -54.0%      60.00        proc-vmstat.nr_dirtied
     15.80 ± 10%      -5.1%      15.00        proc-vmstat.nr_dirty
   1687530            -0.0%    1687077        proc-vmstat.nr_dirty_background_threshold
   3379188            -0.0%    3378279        proc-vmstat.nr_dirty_threshold
  15355708            -0.4%   15287398        proc-vmstat.nr_file_pages
     48638            +0.0%      48638        proc-vmstat.nr_free_cma
  17054619            -0.0%   17050200        proc-vmstat.nr_free_pages
   1801446 ±  4%    +132.2%    4183033 ±  6%  proc-vmstat.nr_inactive_anon
     98.60 ± 14%      -8.4%      90.33        proc-vmstat.nr_inactive_file
      1.60 ± 93%     -16.7%       1.33 ± 93%  proc-vmstat.nr_isolated_anon
     21527 ±  5%      -5.3%      20390 ±  3%  proc-vmstat.nr_kernel_stack
   7271413           -47.7%    3802076        proc-vmstat.nr_mapped
   5592797           -75.1%    1394593 ±  6%  proc-vmstat.nr_mlock
     27791 ±  3%      +6.4%      29565        proc-vmstat.nr_page_table_pages
  15117636            -0.5%   15049364        proc-vmstat.nr_shmem
     56092            -0.7%      55693        proc-vmstat.nr_slab_reclaimable
    132917           +66.4%     221176        proc-vmstat.nr_slab_unreclaimable
   5830654           -72.0%    1632513 ±  5%  proc-vmstat.nr_unevictable
      0.00          -100.0%       0.00        proc-vmstat.nr_writeback
    131.20 ±111%     -55.8%      58.00        proc-vmstat.nr_written
   7857318           +22.1%    9591743        proc-vmstat.nr_zone_active_anon
     42.00 ±109%     -60.3%      16.67 ± 32%  proc-vmstat.nr_zone_active_file
   1801446 ±  4%    +132.2%    4183033 ±  6%  proc-vmstat.nr_zone_inactive_anon
     98.60 ± 14%      -8.4%      90.33        proc-vmstat.nr_zone_inactive_file
   5830654           -72.0%    1632514 ±  5%  proc-vmstat.nr_zone_unevictable
     15.80 ± 10%      -5.1%      15.00        proc-vmstat.nr_zone_write_pending
     39731 ± 10%     -11.9%      34987 ± 27%  proc-vmstat.numa_hint_faults
     19700 ± 21%     -16.7%      16403 ± 25%  proc-vmstat.numa_hint_faults_local
  17783159            -3.4%   17169908        proc-vmstat.numa_hit
     49.00 ± 67%     -32.0%      33.33 ± 35%  proc-vmstat.numa_huge_pte_updates
      0.00          -100.0%       0.00        proc-vmstat.numa_interleave
  17739740            -3.5%   17126412        proc-vmstat.numa_local
     43418            +0.2%      43496        proc-vmstat.numa_other
     12833 ± 52%      +5.3%      13507 ± 57%  proc-vmstat.numa_pages_migrated
     84737 ± 25%     -17.3%      70054 ± 26%  proc-vmstat.numa_pte_updates
  76644797 ±  2%     -61.7%   29321914 ±  3%  proc-vmstat.pgactivate
      0.00          -100.0%       0.00        proc-vmstat.pgalloc_dma
      0.00          -100.0%       0.00        proc-vmstat.pgalloc_dma32
  18033237            -3.1%   17472724        proc-vmstat.pgalloc_normal
  2.22e+08 ±  5%     -67.1%   72960039        proc-vmstat.pgfault
  15578043 ± 12%     +11.1%   17305293        proc-vmstat.pgfree
      0.00          -100.0%       0.00        proc-vmstat.pgmigrate_fail
     12833 ± 52%      +5.3%      13507 ± 57%  proc-vmstat.pgmigrate_success
     54.40 ±200%    -100.0%       0.00        proc-vmstat.pgpgin
    292.80 ±200%    -100.0%       0.00        proc-vmstat.pgpgout
     25419            -0.1%      25390        proc-vmstat.pgreuse
     75.20 ± 19%     +10.8%      83.33 ±  2%  proc-vmstat.thp_collapse_alloc
      0.00          -100.0%       0.00        proc-vmstat.thp_deferred_split_page
     12.20 ±  3%      +1.1%      12.33 ±  3%  proc-vmstat.thp_fault_alloc
      0.40 ±122%    -100.0%       0.00        proc-vmstat.thp_split_pmd
      0.40 ±122%    -100.0%       0.00        proc-vmstat.thp_zero_page_alloc
      0.00          -100.0%       0.00        proc-vmstat.unevictable_pgs_cleared
  68994933 ±  2%     -70.0%   20699812 ±  5%  proc-vmstat.unevictable_pgs_culled
  68995131 ±  2%     -70.0%   20699799 ±  5%  proc-vmstat.unevictable_pgs_mlocked
  68930376 ±  2%     -70.0%   20699799 ±  5%  proc-vmstat.unevictable_pgs_munlocked
  68930350 ±  2%     -70.0%   20699796 ±  5%  proc-vmstat.unevictable_pgs_rescued
      0.00          -100.0%       0.00        proc-vmstat.unevictable_pgs_stranded
   3953745 ±  3%     +18.6%    4688080 ±  2%  numa-vmstat.node0.nr_active_anon
     12.00 ± 45%     +25.0%      15.00 ± 32%  numa-vmstat.node0.nr_active_file
     74811 ± 23%     -26.7%      54818 ± 10%  numa-vmstat.node0.nr_anon_pages
     43.40 ± 39%     -20.1%      34.67 ± 10%  numa-vmstat.node0.nr_anon_transparent_hugepages
     23.80 ± 89%     -18.8%      19.33 ±130%  numa-vmstat.node0.nr_dirtied
      5.80 ±115%      -8.0%       5.33 ±141%  numa-vmstat.node0.nr_dirty
   7712748            -3.6%    7433505        numa-vmstat.node0.nr_file_pages
   8439381            +3.1%    8697737        numa-vmstat.node0.nr_free_pages
    918878 ±  4%    +117.3%    1997170 ±  5%  numa-vmstat.node0.nr_inactive_anon
     43.80 ± 56%     +25.6%      55.00 ± 45%  numa-vmstat.node0.nr_inactive_file
      0.60 ±133%    -100.0%       0.00        numa-vmstat.node0.nr_isolated_anon
     10288 ± 10%      -3.6%       9914 ±  5%  numa-vmstat.node0.nr_kernel_stack
   3649858           -50.6%    1804283 ±  2%  numa-vmstat.node0.nr_mapped
   2794854 ±  2%     -75.6%     681416 ±  8%  numa-vmstat.node0.nr_mlock
     13160 ±  5%     +11.4%      14659 ±  3%  numa-vmstat.node0.nr_page_table_pages
   7593283            -3.7%    7312167        numa-vmstat.node0.nr_shmem
     28406 ±  3%      -6.2%      26640 ±  7%  numa-vmstat.node0.nr_slab_reclaimable
     68914 ±  2%     +62.7%     112147 ±  2%  numa-vmstat.node0.nr_slab_unreclaimable
   2914224           -72.5%     802680 ±  6%  numa-vmstat.node0.nr_unevictable
      0.00          -100.0%       0.00        numa-vmstat.node0.nr_writeback
     17.60 ± 84%     -22.3%      13.67 ±131%  numa-vmstat.node0.nr_written
   3953751 ±  3%     +18.6%    4688076 ±  2%  numa-vmstat.node0.nr_zone_active_anon
     12.00 ± 45%     +25.0%      15.00 ± 32%  numa-vmstat.node0.nr_zone_active_file
    918874 ±  4%    +117.3%    1997165 ±  5%  numa-vmstat.node0.nr_zone_inactive_anon
     43.80 ± 56%     +25.6%      55.00 ± 45%  numa-vmstat.node0.nr_zone_inactive_file
   2914222           -72.5%     802680 ±  6%  numa-vmstat.node0.nr_zone_unevictable
      5.80 ±115%      -8.0%       5.33 ±141%  numa-vmstat.node0.nr_zone_write_pending
   8839477            -5.7%    8338471        numa-vmstat.node0.numa_hit
    133233            -0.2%     132979        numa-vmstat.node0.numa_interleave
   8808766            -6.6%    8228382        numa-vmstat.node0.numa_local
     30715 ± 34%    +258.4%     110094 ± 43%  numa-vmstat.node0.numa_other
   3905459 ±  2%     +25.7%    4908210 ±  4%  numa-vmstat.node1.nr_active_anon
     29.40 ±167%     -95.5%       1.33 ±141%  numa-vmstat.node1.nr_active_file
     60260 ± 37%      +9.5%      65963 ± 16%  numa-vmstat.node1.nr_anon_pages
     18.40 ± 90%     +55.8%      28.67 ± 15%  numa-vmstat.node1.nr_anon_transparent_hugepages
     84.80 ±134%     -57.9%      35.67 ± 70%  numa-vmstat.node1.nr_dirtied
      9.80 ± 74%      +5.4%      10.33 ± 70%  numa-vmstat.node1.nr_dirty
   7647606            +2.7%    7857218        numa-vmstat.node1.nr_file_pages
     48638            +0.0%      48638        numa-vmstat.node1.nr_free_cma
   8610467            -3.0%    8349486        numa-vmstat.node1.nr_free_pages
    885382 ±  6%    +146.9%    2185669 ± 13%  numa-vmstat.node1.nr_inactive_anon
     54.60 ± 67%     -36.5%      34.67 ± 70%  numa-vmstat.node1.nr_inactive_file
      0.20 ±200%    +566.7%       1.33 ± 93%  numa-vmstat.node1.nr_isolated_anon
     11243 ± 10%      -6.7%      10492 ±  7%  numa-vmstat.node1.nr_kernel_stack
   3625916 ±  2%     -45.1%    1992150        numa-vmstat.node1.nr_mapped
   2797793 ±  3%     -74.5%     712259 ±  6%  numa-vmstat.node1.nr_mlock
     14674 ±  7%      +2.1%      14987 ±  7%  numa-vmstat.node1.nr_page_table_pages
   7529001            +2.8%    7740522        numa-vmstat.node1.nr_shmem
     27707 ±  3%      +4.7%      29012 ±  7%  numa-vmstat.node1.nr_slab_reclaimable
     64142 ±  3%     +69.3%     108600 ±  3%  numa-vmstat.node1.nr_slab_unreclaimable
   2916280 ±  3%     -71.6%     828916 ±  5%  numa-vmstat.node1.nr_unevictable
      0.00          -100.0%       0.00        numa-vmstat.node1.nr_writeback
     74.60 ±146%     -66.0%      25.33 ± 70%  numa-vmstat.node1.nr_written
   3905452 ±  2%     +25.7%    4908206 ±  4%  numa-vmstat.node1.nr_zone_active_anon
     29.40 ±167%     -95.5%       1.33 ±141%  numa-vmstat.node1.nr_zone_active_file
    885383 ±  6%    +146.9%    2185666 ± 13%  numa-vmstat.node1.nr_zone_inactive_anon
     54.60 ± 67%     -36.5%      34.67 ± 70%  numa-vmstat.node1.nr_zone_inactive_file
   2916278 ±  3%     -71.6%     828916 ±  5%  numa-vmstat.node1.nr_zone_unevictable
      9.80 ± 74%      +2.0%      10.00 ± 71%  numa-vmstat.node1.nr_zone_write_pending
   8722862            +2.1%    8902016        numa-vmstat.node1.numa_hit
    132992            +0.2%     133258        numa-vmstat.node1.numa_interleave
   8570505            +3.0%    8829040        numa-vmstat.node1.numa_local
    152360 ±  7%     -52.1%      72980 ± 65%  numa-vmstat.node1.numa_other
     30.21 ±199%  +65423.6%      19792 ±141%  sched_debug.cfs_rq:/.MIN_vruntime.avg
      2839 ±199%  +33533.7%     955010 ±140%  sched_debug.cfs_rq:/.MIN_vruntime.max
      0.00            +0.0%       0.00        sched_debug.cfs_rq:/.MIN_vruntime.min
    291.30 ±200%  +46532.9%     135843 ±140%  sched_debug.cfs_rq:/.MIN_vruntime.stddev
     28461            -0.5%      28325        sched_debug.cfs_rq:/.exec_clock.avg
     29902            -0.8%      29650        sched_debug.cfs_rq:/.exec_clock.max
     27325            -5.8%      25738        sched_debug.cfs_rq:/.exec_clock.min
    248.42 ± 21%     +37.2%     340.72 ±  4%  sched_debug.cfs_rq:/.exec_clock.stddev
     12605 ± 23%     +53.9%      19396 ± 30%  sched_debug.cfs_rq:/.load.avg
    571429 ± 48%     +44.6%     826542 ± 39%  sched_debug.cfs_rq:/.load.max
      5363            -1.6%       5277        sched_debug.cfs_rq:/.load.min
     58046 ± 48%     +62.5%      94341 ± 42%  sched_debug.cfs_rq:/.load.stddev
     26.42 ± 25%     -17.8%      21.71 ± 24%  sched_debug.cfs_rq:/.load_avg.avg
    640.10 ± 48%     -24.0%     486.50 ± 21%  sched_debug.cfs_rq:/.load_avg.max
      4.90 ±  4%      +2.0%       5.00        sched_debug.cfs_rq:/.load_avg.min
     87.17 ± 36%     -26.0%      64.51 ± 34%  sched_debug.cfs_rq:/.load_avg.stddev
     30.21 ±199%  +65423.6%      19792 ±141%  sched_debug.cfs_rq:/.max_vruntime.avg
      2839 ±199%  +33533.7%     955010 ±140%  sched_debug.cfs_rq:/.max_vruntime.max
      0.00            +0.0%       0.00        sched_debug.cfs_rq:/.max_vruntime.min
    291.30 ±200%  +46532.9%     135843 ±140%  sched_debug.cfs_rq:/.max_vruntime.stddev
   2903124            -0.8%    2881055        sched_debug.cfs_rq:/.min_vruntime.avg
   2940930            -0.6%    2924526        sched_debug.cfs_rq:/.min_vruntime.max
   2759231 ±  2%      -5.6%    2605100        sched_debug.cfs_rq:/.min_vruntime.min
     32148 ± 19%     +50.4%      48341 ±  2%  sched_debug.cfs_rq:/.min_vruntime.stddev
      0.55            +4.5%       0.58 ±  4%  sched_debug.cfs_rq:/.nr_running.avg
      1.10 ± 18%     +21.2%       1.33 ± 17%  sched_debug.cfs_rq:/.nr_running.max
      0.50            +0.0%       0.50        sched_debug.cfs_rq:/.nr_running.min
      0.15 ±  7%     +30.9%       0.20 ± 26%  sched_debug.cfs_rq:/.nr_running.stddev
      2.34 ± 17%   +1142.8%      29.11 ± 11%  sched_debug.cfs_rq:/.nr_spread_over.avg
     56.20 ± 52%    +743.4%     474.00 ± 31%  sched_debug.cfs_rq:/.nr_spread_over.max
      0.00       +3.2e+102%       3.17 ± 19%  sched_debug.cfs_rq:/.nr_spread_over.min
      7.55 ± 32%    +809.9%      68.66 ± 23%  sched_debug.cfs_rq:/.nr_spread_over.stddev
      4.09 ±143%     -56.0%       1.80 ±141%  sched_debug.cfs_rq:/.removed.load_avg.avg
    202.30 ±122%     -15.6%     170.67 ±141%  sched_debug.cfs_rq:/.removed.load_avg.max
     27.21 ±128%     -36.0%      17.42 ±141%  sched_debug.cfs_rq:/.removed.load_avg.stddev
      1.37 ±126%     -31.7%       0.94 ±141%  sched_debug.cfs_rq:/.removed.runnable_avg.avg
     84.00 ±128%      +6.0%      89.00 ±141%  sched_debug.cfs_rq:/.removed.runnable_avg.max
     10.08 ±122%      -9.9%       9.08 ±141%  sched_debug.cfs_rq:/.removed.runnable_avg.stddev
      1.37 ±126%     -31.7%       0.94 ±141%  sched_debug.cfs_rq:/.removed.util_avg.avg
     84.00 ±128%      +6.0%      89.00 ±141%  sched_debug.cfs_rq:/.removed.util_avg.max
     10.08 ±122%      -9.9%       9.08 ±141%  sched_debug.cfs_rq:/.removed.util_avg.stddev
    645.49 ±  3%      -0.2%     644.45 ±  4%  sched_debug.cfs_rq:/.runnable_avg.avg
      1167 ±  5%     +11.3%       1299 ± 12%  sched_debug.cfs_rq:/.runnable_avg.max
    466.90 ± 17%      +9.3%     510.50        sched_debug.cfs_rq:/.runnable_avg.min
    158.78 ±  7%      +6.9%     169.72 ± 14%  sched_debug.cfs_rq:/.runnable_avg.stddev
    103207 ± 23%     +10.6%     114183 ± 87%  sched_debug.cfs_rq:/.spread0.avg
    141212 ± 16%     +10.8%     156503 ± 62%  sched_debug.cfs_rq:/.spread0.max
    -40257          +304.7%    -162912        sched_debug.cfs_rq:/.spread0.min
     32026 ± 19%     +50.6%      48217 ±  2%  sched_debug.cfs_rq:/.spread0.stddev
    642.25 ±  3%      -0.4%     639.71 ±  4%  sched_debug.cfs_rq:/.util_avg.avg
      1024           +15.0%       1177 ± 10%  sched_debug.cfs_rq:/.util_avg.max
    421.20 ± 30%     +15.1%     484.67 ±  3%  sched_debug.cfs_rq:/.util_avg.min
    150.86 ±  4%      +4.4%     157.44 ± 13%  sched_debug.cfs_rq:/.util_avg.stddev
    347.03 ±  9%     -66.6%     116.03 ±  4%  sched_debug.cfs_rq:/.util_est_enqueued.avg
      1039 ±  2%      -1.2%       1026        sched_debug.cfs_rq:/.util_est_enqueued.max
      0.50            +0.0%       0.50        sched_debug.cfs_rq:/.util_est_enqueued.min
    319.62 ±  4%     -17.5%     263.67        sched_debug.cfs_rq:/.util_est_enqueued.stddev
   1809157 ± 27%     -11.0%    1610896 ± 33%  sched_debug.cpu.avg_idle.avg
   7946220 ± 54%     -43.9%    4457187 ± 46%  sched_debug.cpu.avg_idle.max
    329579 ± 38%     -25.7%     244834 ± 47%  sched_debug.cpu.avg_idle.min
   1115761 ± 44%     -32.3%     754920 ± 54%  sched_debug.cpu.avg_idle.stddev
     59017            -0.5%      58751        sched_debug.cpu.clock.avg
     59030            -0.4%      58768        sched_debug.cpu.clock.max
     59007            -0.5%      58734        sched_debug.cpu.clock.min
      7.41 ± 29%     +55.1%      11.49 ± 13%  sched_debug.cpu.clock.stddev
     58776            -0.7%      58377        sched_debug.cpu.clock_task.avg
     58933            -0.7%      58548        sched_debug.cpu.clock_task.max
     53421            -0.9%      52926        sched_debug.cpu.clock_task.min
    637.28 ±  3%      +2.8%     655.18 ±  6%  sched_debug.cpu.clock_task.stddev
      1537            +1.6%       1562 ±  2%  sched_debug.cpu.curr->pid.avg
      3292 ±  8%      -3.1%       3189 ± 10%  sched_debug.cpu.curr->pid.max
      1324 ±  5%      +0.2%       1326 ±  5%  sched_debug.cpu.curr->pid.min
    395.47 ±  7%      +8.2%     427.88 ± 10%  sched_debug.cpu.curr->pid.stddev
    976324 ± 31%     -16.9%     811504 ± 33%  sched_debug.cpu.max_idle_balance_cost.avg
   3211116 ± 47%     -12.6%    2806818 ± 73%  sched_debug.cpu.max_idle_balance_cost.max
    500000            +0.0%     500000        sched_debug.cpu.max_idle_balance_cost.min
    453858 ± 49%     -31.1%     312847 ± 70%  sched_debug.cpu.max_idle_balance_cost.stddev
      4294            -0.0%       4294        sched_debug.cpu.next_balance.avg
      4294            -0.0%       4294        sched_debug.cpu.next_balance.max
      4294            -0.0%       4294        sched_debug.cpu.next_balance.min
      0.00 ± 16%     +33.0%       0.00 ± 39%  sched_debug.cpu.next_balance.stddev
      0.56            +4.4%       0.59 ±  5%  sched_debug.cpu.nr_running.avg
      1.60 ± 12%      +4.2%       1.67 ± 14%  sched_debug.cpu.nr_running.max
      0.50            +0.0%       0.50        sched_debug.cpu.nr_running.min
      0.22 ±  7%     +15.6%       0.25 ± 19%  sched_debug.cpu.nr_running.stddev
      2009 ±  4%      +3.1%       2072 ±  2%  sched_debug.cpu.nr_switches.avg
     11032 ± 14%     -25.7%       8200 ± 12%  sched_debug.cpu.nr_switches.max
    720.60 ±  9%      +1.4%     730.50 ± 13%  sched_debug.cpu.nr_switches.min
      1541 ± 11%      -9.1%       1400 ±  3%  sched_debug.cpu.nr_switches.stddev
      0.02 ± 35%     -11.8%       0.02 ± 27%  sched_debug.cpu.nr_uninterruptible.avg
     31.30 ± 23%      +1.7%      31.83 ±  8%  sched_debug.cpu.nr_uninterruptible.max
    -14.00           +50.0%     -21.00        sched_debug.cpu.nr_uninterruptible.min
      7.09 ±  9%     +10.9%       7.87 ±  9%  sched_debug.cpu.nr_uninterruptible.stddev
    641.59 ± 10%     -15.8%     540.26 ±  5%  sched_debug.cpu.sched_count.avg
      4502 ± 28%      -0.5%       4479        sched_debug.cpu.sched_count.max
    200.40 ± 35%     -35.5%     129.33 ±  4%  sched_debug.cpu.sched_count.min
    617.03 ± 20%     +13.6%     700.98 ±  4%  sched_debug.cpu.sched_count.stddev
     67.06 ± 28%     -24.9%      50.36 ±  8%  sched_debug.cpu.sched_goidle.avg
      1491 ± 24%     -12.9%       1299 ± 19%  sched_debug.cpu.sched_goidle.max
      4.30 ± 85%     -38.0%       2.67 ± 38%  sched_debug.cpu.sched_goidle.min
    180.00 ± 16%      -8.8%     164.19 ± 15%  sched_debug.cpu.sched_goidle.stddev
    285.21 ± 14%     -23.4%     218.37 ±  5%  sched_debug.cpu.ttwu_count.avg
      2022 ± 39%      +9.9%       2221 ± 20%  sched_debug.cpu.ttwu_count.max
     57.00 ±  8%     -24.9%      42.83 ±  4%  sched_debug.cpu.ttwu_count.min
    297.42 ± 30%     +10.5%     328.53 ±  9%  sched_debug.cpu.ttwu_count.stddev
    163.51 ±  6%      -5.0%     155.34 ±  2%  sched_debug.cpu.ttwu_local.avg
    903.60 ± 68%     +65.7%       1496 ±  8%  sched_debug.cpu.ttwu_local.max
     46.60 ±  6%     -20.2%      37.17        sched_debug.cpu.ttwu_local.min
    127.35 ± 45%     +91.4%     243.79 ±  7%  sched_debug.cpu.ttwu_local.stddev
     59006            -0.5%      58734        sched_debug.cpu_clk
    996147            +0.0%     996147        sched_debug.dl_rq:.dl_bw->bw.avg
    996147            +0.0%     996147        sched_debug.dl_rq:.dl_bw->bw.max
    996147            +0.0%     996147        sched_debug.dl_rq:.dl_bw->bw.min
 4.295e+09            -0.0%  4.295e+09        sched_debug.jiffies
     58510            -0.5%      58239        sched_debug.ktime
    950.00            +0.0%     950.00        sched_debug.rt_rq:/.rt_runtime.avg
    950.00            +0.0%     950.00        sched_debug.rt_rq:/.rt_runtime.max
    950.00            +0.0%     950.00        sched_debug.rt_rq:/.rt_runtime.min
     59366            -0.6%      59028        sched_debug.sched_clk
      1.00            +0.0%       1.00        sched_debug.sched_clock_stable()
   4139835            +0.0%    4139835        sched_debug.sysctl_sched.sysctl_sched_features
     24.00            +0.0%      24.00        sched_debug.sysctl_sched.sysctl_sched_latency
      3.00            +0.0%       3.00        sched_debug.sysctl_sched.sysctl_sched_min_granularity
      1.00            +0.0%       1.00        sched_debug.sysctl_sched.sysctl_sched_tunable_scaling
      4.00            +0.0%       4.00        sched_debug.sysctl_sched.sysctl_sched_wakeup_granularity
      0.00          -100.0%       0.00        latency_stats.avg.path_openat.do_filp_open.do_sys_openat2.do_sys_open.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00          -100.0%       0.00        latency_stats.avg.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      0.00          -100.0%       0.00        latency_stats.avg.stop_two_cpus.migrate_swap.task_numa_migrate.task_numa_fault.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      0.00          -100.0%       0.00        latency_stats.avg.cgroup_kn_lock_live.cgroup_procs_write.cgroup_file_write.kernfs_fop_write.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00          -100.0%       0.00        latency_stats.avg.d_alloc_parallel.__lookup_slow.walk_component.link_path_walk.path_lookupat.filename_lookup.vfs_statx.__do_sys_newstat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00          -100.0%       0.00        latency_stats.avg.page_lock_anon_vma_read.rmap_walk_anon.try_to_unmap.migrate_pages.migrate_misplaced_page.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      0.00          -100.0%       0.00        latency_stats.avg.rwsem_down_write_slowpath.anon_vma_fork.dup_mmap.dup_mm.copy_process._do_fork.__do_sys_clone.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00          -100.0%       0.00        latency_stats.avg.rwsem_down_write_slowpath.anon_vma_clone.anon_vma_fork.dup_mmap.dup_mm.copy_process._do_fork.__do_sys_clone.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00          -100.0%       0.00        latency_stats.avg.rwsem_down_write_slowpath.dup_mmap.dup_mm.copy_process._do_fork.__do_sys_clone.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00          -100.0%       0.00        latency_stats.avg.rwsem_down_write_slowpath.vma_link.mmap_region.do_mmap.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00          -100.0%       0.00        latency_stats.avg.rwsem_down_write_slowpath.unlink_file_vma.free_pgtables.exit_mmap.mmput.begin_new_exec.load_elf_binary.exec_binprm.bprm_execve.do_execveat_common.__x64_sys_execve.do_syscall_64
      0.00          -100.0%       0.00        latency_stats.avg.pipe_release.__fput.task_work_run.exit_to_user_mode_prepare.syscall_exit_to_user_mode.entry_SYSCALL_64_after_hwframe
      0.00          -100.0%       0.00        latency_stats.avg.percpu_rwsem_wait.__percpu_down_read.cgroup_can_fork.copy_process._do_fork.__do_sys_clone.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00          -100.0%       0.00        latency_stats.avg.wb_wait_for_completion.sync_inodes_sb.iterate_supers.ksys_sync.__do_sys_sync.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00          -100.0%       0.00        latency_stats.avg.wait_on_page_bit.__filemap_fdatawait_range.filemap_fdatawait_keep_errors.sync_inodes_sb.iterate_supers.ksys_sync.__do_sys_sync.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00          -100.0%       0.00        latency_stats.avg.sync_inodes_sb.iterate_supers.ksys_sync.__do_sys_sync.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00          -100.0%       0.00        latency_stats.avg.put_and_wait_on_page_locked.do_swap_page.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      0.00          -100.0%       0.00        latency_stats.avg.stop_one_cpu.__set_cpus_allowed_ptr.sched_setaffinity.__x64_sys_sched_setaffinity.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00          -100.0%       0.00        latency_stats.avg.stop_one_cpu.sched_exec.bprm_execve.do_execveat_common.__x64_sys_execve.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00          -100.0%       0.00        latency_stats.avg.rpc_wait_bit_killable.__rpc_execute.rpc_run_task.rpc_call_sync.nfs3_rpc_wrapper.nfs3_proc_access.nfs_do_access.nfs_permission.inode_permission.link_path_walk.path_openat.do_filp_open
      0.00          -100.0%       0.00        latency_stats.avg.rpc_wait_bit_killable.__rpc_execute.rpc_run_task.rpc_call_sync.nfs3_rpc_wrapper.nfs3_proc_lookup.nfs_lookup.path_openat.do_filp_open.do_sys_openat2.do_sys_open.do_syscall_64
      0.00          -100.0%       0.00        latency_stats.avg.rpc_wait_bit_killable.__rpc_execute.rpc_run_task.rpc_call_sync.nfs3_get_acl.get_acl.posix_acl_create.nfs3_proc_create.nfs_create.path_openat.do_filp_open.do_sys_openat2
      0.00          -100.0%       0.00        latency_stats.avg.rpc_wait_bit_killable.__rpc_execute.rpc_run_task.rpc_call_sync.nfs3_rpc_wrapper.nfs3_do_create.nfs3_proc_create.nfs_create.path_openat.do_filp_open.do_sys_openat2.do_sys_open
      0.00          -100.0%       0.00        latency_stats.avg.rpc_wait_bit_killable.__rpc_execute.rpc_run_task.rpc_call_sync.nfs3_rpc_wrapper.nfs3_proc_setattr.nfs_setattr.notify_change.vfs_utimes.do_utimes.__x64_sys_utimensat.do_syscall_64
      0.00          -100.0%       0.00        latency_stats.avg.wait_on_page_bit.__filemap_fdatawait_range.filemap_write_and_wait_range.nfs_wb_all.nfs_file_flush.filp_close.do_dup2.__x64_sys_dup2.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00          -100.0%       0.00        latency_stats.avg.rpc_wait_bit_killable.__rpc_execute.rpc_run_task.rpc_call_sync.nfs3_rpc_wrapper.nfs3_proc_getattr.__nfs_revalidate_inode.nfs_lookup_verify_inode.nfs_do_lookup_revalidate.__nfs_lookup_revalidate.path_openat.do_filp_open
      0.00          -100.0%       0.00        latency_stats.avg.rpc_wait_bit_killable.__rpc_execute.rpc_run_task.rpc_call_sync.nfs3_rpc_wrapper.nfs3_proc_access.nfs_do_access.nfs_permission.inode_permission.may_open.path_openat.do_filp_open
      0.00          -100.0%       0.00        latency_stats.avg.rpc_wait_bit_killable.__rpc_execute.rpc_run_task.rpc_call_sync.nfs3_rpc_wrapper.nfs3_proc_getattr.__nfs_revalidate_inode.nfs_lookup_verify_inode.nfs_do_lookup_revalidate.__nfs_lookup_revalidate.lookup_fast.path_openat
      0.00          -100.0%       0.00        latency_stats.avg.cgroup_kn_lock_live.__cgroup1_procs_write.cgroup_file_write.kernfs_fop_write.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00          -100.0%       0.00        latency_stats.avg.stop_two_cpus.migrate_swap.task_numa_migrate.task_numa_fault.do_huge_pmd_numa_page.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      0.00          -100.0%       0.00        latency_stats.avg.rwsem_down_write_slowpath.__vma_adjust.__split_vma.__do_munmap.__vm_munmap.elf_map.load_elf_interp.load_elf_binary.exec_binprm.bprm_execve.do_execveat_common.__x64_sys_execve
      0.00          -100.0%       0.00        latency_stats.avg.rwsem_down_write_slowpath.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00          -100.0%       0.00        latency_stats.avg.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.copy_user_generic_unrolled._copy_from_user.__x64_sys_rt_sigprocmask.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00          -100.0%       0.00        latency_stats.avg.rwsem_down_write_slowpath.do_mprotect_pkey.__x64_sys_mprotect.do_syscall_64.entry_SYSCALL_64_after_hwframe
     79.40 ±200%    -100.0%       0.00        latency_stats.avg.kernfs_iop_permission.inode_permission.link_path_walk.path_openat.do_filp_open.do_sys_openat2.do_sys_open.do_syscall_64.entry_SYSCALL_64_after_hwframe
      6.60 ± 97%    -100.0%       0.00        latency_stats.avg.d_alloc_parallel.__lookup_slow.walk_component.link_path_walk.path_openat.do_filp_open.do_sys_openat2.do_sys_open.do_syscall_64.entry_SYSCALL_64_after_hwframe
      4843 ±122%    -100.0%       0.00        latency_stats.avg.rwsem_down_write_slowpath.__vm_munmap.__x64_sys_munmap.do_syscall_64.entry_SYSCALL_64_after_hwframe
     16.60 ±200%    -100.0%       0.00        latency_stats.avg.rwsem_down_write_slowpath.do_madvise.__x64_sys_madvise.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.80 ±123%    -100.0%       0.00        latency_stats.avg.d_alloc_parallel.__lookup_slow.walk_component.path_lookupat.filename_lookup.vfs_statx.__do_sys_newstat.do_syscall_64.entry_SYSCALL_64_after_hwframe
    154.80 ±120%    -100.0%       0.00        latency_stats.avg.resolve_symbol.load_module.__do_sys_finit_module.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.80 ±200%    -100.0%       0.00        latency_stats.avg.d_alloc_parallel.__lookup_slow.walk_component.path_lookupat.filename_lookup.do_faccessat.do_syscall_64.entry_SYSCALL_64_after_hwframe
    321.00 ±122%    -100.0%       0.00        latency_stats.avg.poll_schedule_timeout.do_sys_poll.__x64_sys_ppoll.do_syscall_64.entry_SYSCALL_64_after_hwframe
     25.00 ±200%    -100.0%       0.00        latency_stats.avg.rwsem_down_write_slowpath.__vma_adjust.__split_vma.mprotect_fixup.do_mprotect_pkey.__x64_sys_mprotect.do_syscall_64.entry_SYSCALL_64_after_hwframe
     54.80 ±200%    -100.0%       0.00        latency_stats.avg.rwsem_down_write_slowpath.__vma_adjust.__split_vma.__do_munmap.mmap_region.do_mmap.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe
    171.20 ±200%    -100.0%       0.00        latency_stats.avg.rmap_walk_anon.remove_migration_ptes.migrate_pages.migrate_misplaced_page.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      4831 ±121%     -97.6%     116.00 ±134%  latency_stats.avg.do_exit.do_group_exit.get_signal.arch_do_signal.exit_to_user_mode_prepare.syscall_exit_to_user_mode.entry_SYSCALL_64_after_hwframe
      2179 ±185%     -95.2%     103.67 ±141%  latency_stats.avg.load_module.__do_sys_finit_module.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1163 ±100%     -87.5%     145.33 ±  2%  latency_stats.avg.rpc_wait_bit_killable.__rpc_execute.rpc_run_task.rpc_call_sync.nfs3_rpc_wrapper.nfs3_proc_lookup.nfs_lookup.__lookup_slow.walk_component.path_lookupat.filename_lookup.vfs_statx
      1034 ±187%     -81.6%     190.00 ±134%  latency_stats.avg.finished_loading.load_module.__do_sys_finit_module.do_syscall_64.entry_SYSCALL_64_after_hwframe
    844.20 ± 90%     -68.5%     266.33 ± 44%  latency_stats.avg.poll_schedule_timeout.do_select.core_sys_select.kern_select.__x64_sys_select.do_syscall_64.entry_SYSCALL_64_after_hwframe
    140.40 ±128%     -61.8%      53.67 ±141%  latency_stats.avg.rpc_wait_bit_killable.__rpc_execute.rpc_run_task.rpc_call_sync.nfs3_rpc_wrapper.nfs3_proc_access.nfs_do_access.nfs_permission.inode_permission.link_path_walk.path_lookupat.filename_lookup
    175267 ± 81%     -52.5%      83199 ±141%  latency_stats.avg.blk_execute_rq.__scsi_execute.ioctl_internal_command.scsi_set_medium_removal.cdrom_release.[cdrom].sr_block_release.[sr_mod].__blkdev_put.blkdev_close.__fput.task_work_run.exit_to_user_mode_prepare.syscall_exit_to_user_mode
    205883 ± 55%     -35.0%     133812 ± 88%  latency_stats.avg.max
    496.40 ± 24%     -34.5%     325.00 ±  6%  latency_stats.avg.hrtimer_nanosleep.__x64_sys_nanosleep.do_syscall_64.entry_SYSCALL_64_after_hwframe
     82676 ± 69%     -29.4%      58389 ± 76%  latency_stats.avg.mm_access.proc_mem_open.proc_maps_open.do_dentry_open.path_openat.do_filp_open.do_sys_openat2.do_sys_open.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2373 ±  5%     -13.2%       2059 ±  4%  latency_stats.avg.devkmsg_read.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2251 ± 11%      -9.0%       2048 ±  6%  latency_stats.avg.do_syslog.kmsg_read.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
    212.20 ± 14%      -6.7%     198.00 ± 15%  latency_stats.avg.wait_woken.__inet_stream_connect.inet_stream_connect.__sys_connect.__x64_sys_connect.do_syscall_64.entry_SYSCALL_64_after_hwframe
    540.60 ± 14%      -2.3%     528.00 ±  2%  latency_stats.avg.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64.entry_SYSCALL_64_after_hwframe
     59.60 ± 12%     +14.1%      68.00 ± 10%  latency_stats.avg.pipe_read.new_sync_read.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
    392.20 ± 47%     +17.9%     462.33 ± 95%  latency_stats.avg.rpc_wait_bit_killable.__rpc_execute.rpc_run_task.rpc_call_sync.nfs3_rpc_wrapper.nfs3_proc_getattr.__nfs_revalidate_inode.nfs_access_get_cached.nfs_do_access.nfs_permission.inode_permission.link_path_walk
    551.00 ± 82%     +44.2%     794.67 ± 26%  latency_stats.avg.ep_poll.do_epoll_wait.__x64_sys_epoll_wait.do_syscall_64.entry_SYSCALL_64_after_hwframe
    721.80 ±147%     +77.3%       1280 ±141%  latency_stats.avg.blk_execute_rq.sg_io.scsi_cmd_ioctl.cdrom_ioctl.[cdrom].sr_block_ioctl.[sr_mod].blkdev_ioctl.block_ioctl.__x64_sys_ioctl.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2269 ±200%     +81.3%       4114 ±141%  latency_stats.avg.msleep.cpuinfo_open.do_dentry_open.path_openat.do_filp_open.do_sys_openat2.do_sys_open.do_syscall_64.entry_SYSCALL_64_after_hwframe
    743.80 ± 75%     +84.5%       1372 ± 14%  latency_stats.avg.poll_schedule_timeout.do_sys_poll.__x64_sys_poll.do_syscall_64.entry_SYSCALL_64_after_hwframe
     40213 ±198%     +89.7%      76285 ±141%  latency_stats.avg.do_init_module.load_module.__do_sys_finit_module.do_syscall_64.entry_SYSCALL_64_after_hwframe
    207.20 ±149%    +112.2%     439.67 ±141%  latency_stats.avg.rpc_wait_bit_killable.__rpc_execute.rpc_run_task.rpc_call_sync.nfs3_rpc_wrapper.nfs3_proc_lookup.nfs_lookup_revalidate_dentry.nfs_do_lookup_revalidate.__nfs_lookup_revalidate.lookup_fast.walk_component.link_path_walk
    975.40 ± 50%    +122.1%       2166 ± 67%  latency_stats.avg.wait_for_partner.fifo_open.do_dentry_open.path_openat.do_filp_open.do_sys_openat2.do_sys_open.do_syscall_64.entry_SYSCALL_64_after_hwframe
    843.00 ± 70%    +151.1%       2116 ± 47%  latency_stats.avg.pipe_write.new_sync_write.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
     78.20 ± 27%    +397.4%     389.00 ±141%  latency_stats.avg.do_coredump.get_signal.arch_do_signal.exit_to_user_mode_prepare.syscall_exit_to_user_mode.entry_SYSCALL_64_after_hwframe
     16588 ±187%    +426.3%      87301 ±139%  latency_stats.avg.m_start.seq_read.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
     24.00 ±108%    +812.5%     219.00 ± 78%  latency_stats.avg.futex_wait_queue_me.futex_wait.do_futex.__x64_sys_futex.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.20 ±200%  +1.2e+05%     240.33 ±140%  latency_stats.avg.d_alloc_parallel.path_openat.do_filp_open.do_sys_openat2.do_sys_open.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00       +3.3e+101%       0.33 ±141%  latency_stats.avg.d_alloc_parallel.__lookup_slow.walk_component.path_lookupat.filename_lookup.user_statfs.__do_sys_statfs.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00       +4.8e+103%      48.00 ± 72%  latency_stats.avg.devtmpfs_submit_req.devtmpfs_create_node.device_add.devm_create_dev_dax.__dax_pmem_probe.[dax_pmem_core].dax_pmem_compat_probe.[dax_pmem_compat].nvdimm_bus_probe.[libnvdimm].really_probe.driver_probe_device.device_driver_attach.__driver_attach.bus_for_each_dev
      0.00       +1.8e+105%       1781 ±141%  latency_stats.avg.blk_execute_rq.__scsi_execute.sr_do_ioctl.[sr_mod].sr_packet.[sr_mod].cdrom_get_media_event.[cdrom].sr_drive_status.[sr_mod].cdrom_ioctl.[cdrom].sr_block_ioctl.[sr_mod].blkdev_ioctl.block_ioctl.__x64_sys_ioctl.do_syscall_64
      0.00       +1.9e+105%       1940 ±141%  latency_stats.avg.blk_execute_rq.__scsi_execute.sr_check_events.[sr_mod].cdrom_check_events.[cdrom].sr_block_check_events.[sr_mod].disk_check_events.bdev_check_media_change.sr_block_open.[sr_mod].__blkdev_get.blkdev_get.do_dentry_open.path_openat
      0.00       +9.7e+106%      96869 ±141%  latency_stats.avg.blk_execute_rq.__scsi_execute.scsi_test_unit_ready.sr_check_events.[sr_mod].cdrom_check_events.[cdrom].sr_block_check_events.[sr_mod].disk_check_events.bdev_check_media_change.sr_block_open.[sr_mod].__blkdev_get.blkdev_get.do_dentry_open
      0.00          -100.0%       0.00        latency_stats.hits.path_openat.do_filp_open.do_sys_openat2.do_sys_open.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00          -100.0%       0.00        latency_stats.hits.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      0.00          -100.0%       0.00        latency_stats.hits.stop_two_cpus.migrate_swap.task_numa_migrate.task_numa_fault.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      0.00          -100.0%       0.00        latency_stats.hits.cgroup_kn_lock_live.cgroup_procs_write.cgroup_file_write.kernfs_fop_write.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00          -100.0%       0.00        latency_stats.hits.d_alloc_parallel.__lookup_slow.walk_component.link_path_walk.path_lookupat.filename_lookup.vfs_statx.__do_sys_newstat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00          -100.0%       0.00        latency_stats.hits.page_lock_anon_vma_read.rmap_walk_anon.try_to_unmap.migrate_pages.migrate_misplaced_page.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      0.00          -100.0%       0.00        latency_stats.hits.rwsem_down_write_slowpath.anon_vma_fork.dup_mmap.dup_mm.copy_process._do_fork.__do_sys_clone.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00          -100.0%       0.00        latency_stats.hits.rwsem_down_write_slowpath.anon_vma_clone.anon_vma_fork.dup_mmap.dup_mm.copy_process._do_fork.__do_sys_clone.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00          -100.0%       0.00        latency_stats.hits.rwsem_down_write_slowpath.dup_mmap.dup_mm.copy_process._do_fork.__do_sys_clone.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00          -100.0%       0.00        latency_stats.hits.rwsem_down_write_slowpath.vma_link.mmap_region.do_mmap.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00          -100.0%       0.00        latency_stats.hits.rwsem_down_write_slowpath.unlink_file_vma.free_pgtables.exit_mmap.mmput.begin_new_exec.load_elf_binary.exec_binprm.bprm_execve.do_execveat_common.__x64_sys_execve.do_syscall_64
      0.00          -100.0%       0.00        latency_stats.hits.pipe_release.__fput.task_work_run.exit_to_user_mode_prepare.syscall_exit_to_user_mode.entry_SYSCALL_64_after_hwframe
      0.00          -100.0%       0.00        latency_stats.hits.percpu_rwsem_wait.__percpu_down_read.cgroup_can_fork.copy_process._do_fork.__do_sys_clone.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00          -100.0%       0.00        latency_stats.hits.wb_wait_for_completion.sync_inodes_sb.iterate_supers.ksys_sync.__do_sys_sync.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00          -100.0%       0.00        latency_stats.hits.wait_on_page_bit.__filemap_fdatawait_range.filemap_fdatawait_keep_errors.sync_inodes_sb.iterate_supers.ksys_sync.__do_sys_sync.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00          -100.0%       0.00        latency_stats.hits.sync_inodes_sb.iterate_supers.ksys_sync.__do_sys_sync.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00          -100.0%       0.00        latency_stats.hits.put_and_wait_on_page_locked.do_swap_page.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      0.00          -100.0%       0.00        latency_stats.hits.stop_one_cpu.__set_cpus_allowed_ptr.sched_setaffinity.__x64_sys_sched_setaffinity.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00          -100.0%       0.00        latency_stats.hits.stop_one_cpu.sched_exec.bprm_execve.do_execveat_common.__x64_sys_execve.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00          -100.0%       0.00        latency_stats.hits.rpc_wait_bit_killable.__rpc_execute.rpc_run_task.rpc_call_sync.nfs3_rpc_wrapper.nfs3_proc_access.nfs_do_access.nfs_permission.inode_permission.link_path_walk.path_openat.do_filp_open
      0.00          -100.0%       0.00        latency_stats.hits.rpc_wait_bit_killable.__rpc_execute.rpc_run_task.rpc_call_sync.nfs3_rpc_wrapper.nfs3_proc_lookup.nfs_lookup.path_openat.do_filp_open.do_sys_openat2.do_sys_open.do_syscall_64
      0.00          -100.0%       0.00        latency_stats.hits.rpc_wait_bit_killable.__rpc_execute.rpc_run_task.rpc_call_sync.nfs3_get_acl.get_acl.posix_acl_create.nfs3_proc_create.nfs_create.path_openat.do_filp_open.do_sys_openat2
      0.00          -100.0%       0.00        latency_stats.hits.rpc_wait_bit_killable.__rpc_execute.rpc_run_task.rpc_call_sync.nfs3_rpc_wrapper.nfs3_do_create.nfs3_proc_create.nfs_create.path_openat.do_filp_open.do_sys_openat2.do_sys_open
      0.00          -100.0%       0.00        latency_stats.hits.rpc_wait_bit_killable.__rpc_execute.rpc_run_task.rpc_call_sync.nfs3_rpc_wrapper.nfs3_proc_setattr.nfs_setattr.notify_change.vfs_utimes.do_utimes.__x64_sys_utimensat.do_syscall_64
      0.00          -100.0%       0.00        latency_stats.hits.wait_on_page_bit.__filemap_fdatawait_range.filemap_write_and_wait_range.nfs_wb_all.nfs_file_flush.filp_close.do_dup2.__x64_sys_dup2.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00          -100.0%       0.00        latency_stats.hits.rpc_wait_bit_killable.__rpc_execute.rpc_run_task.rpc_call_sync.nfs3_rpc_wrapper.nfs3_proc_getattr.__nfs_revalidate_inode.nfs_lookup_verify_inode.nfs_do_lookup_revalidate.__nfs_lookup_revalidate.path_openat.do_filp_open
      0.00          -100.0%       0.00        latency_stats.hits.rpc_wait_bit_killable.__rpc_execute.rpc_run_task.rpc_call_sync.nfs3_rpc_wrapper.nfs3_proc_access.nfs_do_access.nfs_permission.inode_permission.may_open.path_openat.do_filp_open
      0.00          -100.0%       0.00        latency_stats.hits.rpc_wait_bit_killable.__rpc_execute.rpc_run_task.rpc_call_sync.nfs3_rpc_wrapper.nfs3_proc_getattr.__nfs_revalidate_inode.nfs_lookup_verify_inode.nfs_do_lookup_revalidate.__nfs_lookup_revalidate.lookup_fast.path_openat
      0.00          -100.0%       0.00        latency_stats.hits.cgroup_kn_lock_live.__cgroup1_procs_write.cgroup_file_write.kernfs_fop_write.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00          -100.0%       0.00        latency_stats.hits.stop_two_cpus.migrate_swap.task_numa_migrate.task_numa_fault.do_huge_pmd_numa_page.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      0.00          -100.0%       0.00        latency_stats.hits.rwsem_down_write_slowpath.__vma_adjust.__split_vma.__do_munmap.__vm_munmap.elf_map.load_elf_interp.load_elf_binary.exec_binprm.bprm_execve.do_execveat_common.__x64_sys_execve
      0.00          -100.0%       0.00        latency_stats.hits.rwsem_down_write_slowpath.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00          -100.0%       0.00        latency_stats.hits.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.copy_user_generic_unrolled._copy_from_user.__x64_sys_rt_sigprocmask.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00          -100.0%       0.00        latency_stats.hits.rwsem_down_write_slowpath.do_mprotect_pkey.__x64_sys_mprotect.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.20 ±200%    -100.0%       0.00        latency_stats.hits.kernfs_iop_permission.inode_permission.link_path_walk.path_openat.do_filp_open.do_sys_openat2.do_sys_open.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.80 ± 93%    -100.0%       0.00        latency_stats.hits.d_alloc_parallel.__lookup_slow.walk_component.link_path_walk.path_openat.do_filp_open.do_sys_openat2.do_sys_open.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.40 ±122%    -100.0%       0.00        latency_stats.hits.rwsem_down_write_slowpath.__vm_munmap.__x64_sys_munmap.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.20 ±200%    -100.0%       0.00        latency_stats.hits.rwsem_down_write_slowpath.do_madvise.__x64_sys_madvise.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.40 ±122%    -100.0%       0.00        latency_stats.hits.d_alloc_parallel.__lookup_slow.walk_component.path_lookupat.filename_lookup.vfs_statx.__do_sys_newstat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.80 ± 93%    -100.0%       0.00        latency_stats.hits.resolve_symbol.load_module.__do_sys_finit_module.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.80 ±200%    -100.0%       0.00        latency_stats.hits.d_alloc_parallel.__lookup_slow.walk_component.path_lookupat.filename_lookup.do_faccessat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.80 ±122%    -100.0%       0.00        latency_stats.hits.poll_schedule_timeout.do_sys_poll.__x64_sys_ppoll.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.20 ±200%    -100.0%       0.00        latency_stats.hits.rwsem_down_write_slowpath.__vma_adjust.__split_vma.mprotect_fixup.do_mprotect_pkey.__x64_sys_mprotect.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.40 ±200%    -100.0%       0.00        latency_stats.hits.rwsem_down_write_slowpath.__vma_adjust.__split_vma.__do_munmap.mmap_region.do_mmap.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.20 ±200%    -100.0%       0.00        latency_stats.hits.rmap_walk_anon.remove_migration_ptes.migrate_pages.migrate_misplaced_page.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
     27.20 ±127%     -93.9%       1.67 ± 28%  latency_stats.hits.futex_wait_queue_me.futex_wait.do_futex.__x64_sys_futex.do_syscall_64.entry_SYSCALL_64_after_hwframe
    115.60 ± 66%     -92.2%       9.00 ± 72%  latency_stats.hits.finished_loading.load_module.__do_sys_finit_module.do_syscall_64.entry_SYSCALL_64_after_hwframe
     12.20 ± 75%     -91.8%       1.00 ±141%  latency_stats.hits.load_module.__do_sys_finit_module.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.00           -66.7%       0.33 ±141%  latency_stats.hits.do_coredump.get_signal.arch_do_signal.exit_to_user_mode_prepare.syscall_exit_to_user_mode.entry_SYSCALL_64_after_hwframe
      1133 ±  2%     -50.2%     564.67 ±  4%  latency_stats.hits.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64.entry_SYSCALL_64_after_hwframe
     51.60 ± 63%     -49.0%      26.33 ± 24%  latency_stats.hits.poll_schedule_timeout.do_select.core_sys_select.kern_select.__x64_sys_select.do_syscall_64.entry_SYSCALL_64_after_hwframe
    499.60 ± 36%     -46.0%     269.67 ± 30%  latency_stats.hits.ep_poll.do_epoll_wait.__x64_sys_epoll_wait.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.20 ±200%     -44.4%       0.67 ± 70%  latency_stats.hits.d_alloc_parallel.path_openat.do_filp_open.do_sys_openat2.do_sys_open.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.60 ± 81%     -44.4%       0.33 ±141%  latency_stats.hits.blk_execute_rq.__scsi_execute.ioctl_internal_command.scsi_set_medium_removal.cdrom_release.[cdrom].sr_block_release.[sr_mod].__blkdev_put.blkdev_close.__fput.task_work_run.exit_to_user_mode_prepare.syscall_exit_to_user_mode
     16557 ± 11%     -42.7%       9493 ±  3%  latency_stats.hits.pipe_read.new_sync_read.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
     16557 ± 11%     -42.7%       9493 ±  3%  latency_stats.hits.max
     19.60 ± 74%     -35.4%      12.67 ± 40%  latency_stats.hits.poll_schedule_timeout.do_sys_poll.__x64_sys_poll.do_syscall_64.entry_SYSCALL_64_after_hwframe
    201.00 ±  2%     -32.7%     135.33 ±  2%  latency_stats.hits.hrtimer_nanosleep.__x64_sys_nanosleep.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.40 ±122%     -16.7%       0.33 ±141%  latency_stats.hits.rpc_wait_bit_killable.__rpc_execute.rpc_run_task.rpc_call_sync.nfs3_rpc_wrapper.nfs3_proc_access.nfs_do_access.nfs_permission.inode_permission.link_path_walk.path_lookupat.filename_lookup
      0.40 ±122%     -16.7%       0.33 ±141%  latency_stats.hits.rpc_wait_bit_killable.__rpc_execute.rpc_run_task.rpc_call_sync.nfs3_rpc_wrapper.nfs3_proc_lookup.nfs_lookup_revalidate_dentry.nfs_do_lookup_revalidate.__nfs_lookup_revalidate.lookup_fast.walk_component.link_path_walk
      0.80 ± 50%     -16.7%       0.67 ± 70%  latency_stats.hits.mm_access.proc_mem_open.proc_maps_open.do_dentry_open.path_openat.do_filp_open.do_sys_openat2.do_sys_open.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.40 ±122%     -16.7%       0.33 ±141%  latency_stats.hits.do_init_module.load_module.__do_sys_finit_module.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.00            +0.0%       1.00        latency_stats.hits.do_exit.do_group_exit.get_signal.arch_do_signal.exit_to_user_mode_prepare.syscall_exit_to_user_mode.entry_SYSCALL_64_after_hwframe
      1.00            +0.0%       1.00        latency_stats.hits.rpc_wait_bit_killable.__rpc_execute.rpc_run_task.rpc_call_sync.nfs3_rpc_wrapper.nfs3_proc_lookup.nfs_lookup.__lookup_slow.walk_component.path_lookupat.filename_lookup.vfs_statx
      1.00            +0.0%       1.00        latency_stats.hits.wait_woken.__inet_stream_connect.inet_stream_connect.__sys_connect.__x64_sys_connect.do_syscall_64.entry_SYSCALL_64_after_hwframe
      8.60 ±  5%      +0.8%       8.67 ±  5%  latency_stats.hits.rpc_wait_bit_killable.__rpc_execute.rpc_run_task.rpc_call_sync.nfs3_rpc_wrapper.nfs3_proc_getattr.__nfs_revalidate_inode.nfs_access_get_cached.nfs_do_access.nfs_permission.inode_permission.link_path_walk
      0.80 ± 50%     +25.0%       1.00        latency_stats.hits.wait_for_partner.fifo_open.do_dentry_open.path_openat.do_filp_open.do_sys_openat2.do_sys_open.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.20 ± 81%     +38.9%       1.67 ±141%  latency_stats.hits.blk_execute_rq.sg_io.scsi_cmd_ioctl.cdrom_ioctl.[cdrom].sr_block_ioctl.[sr_mod].blkdev_ioctl.block_ioctl.__x64_sys_ioctl.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.00 ± 70%     +50.0%       3.00 ± 47%  latency_stats.hits.pipe_write.new_sync_write.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.20 ±200%     +66.7%       0.33 ±141%  latency_stats.hits.msleep.cpuinfo_open.do_dentry_open.path_openat.do_filp_open.do_sys_openat2.do_sys_open.do_syscall_64.entry_SYSCALL_64_after_hwframe
     22.60 ± 90%    +100.6%      45.33 ± 52%  latency_stats.hits.do_syslog.kmsg_read.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
     22.60 ± 81%    +103.5%      46.00 ± 49%  latency_stats.hits.devkmsg_read.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.60 ±133%    +233.3%       2.00 ± 40%  latency_stats.hits.m_start.seq_read.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00       +3.3e+101%       0.33 ±141%  latency_stats.hits.blk_execute_rq.__scsi_execute.sr_do_ioctl.[sr_mod].sr_packet.[sr_mod].cdrom_get_media_event.[cdrom].sr_drive_status.[sr_mod].cdrom_ioctl.[cdrom].sr_block_ioctl.[sr_mod].blkdev_ioctl.block_ioctl.__x64_sys_ioctl.do_syscall_64
      0.00       +3.3e+101%       0.33 ±141%  latency_stats.hits.blk_execute_rq.__scsi_execute.sr_check_events.[sr_mod].cdrom_check_events.[cdrom].sr_block_check_events.[sr_mod].disk_check_events.bdev_check_media_change.sr_block_open.[sr_mod].__blkdev_get.blkdev_get.do_dentry_open.path_openat
      0.00       +3.3e+101%       0.33 ±141%  latency_stats.hits.blk_execute_rq.__scsi_execute.scsi_test_unit_ready.sr_check_events.[sr_mod].cdrom_check_events.[cdrom].sr_block_check_events.[sr_mod].disk_check_events.bdev_check_media_change.sr_block_open.[sr_mod].__blkdev_get.blkdev_get.do_dentry_open
      0.00       +3.3e+101%       0.33 ±141%  latency_stats.hits.d_alloc_parallel.__lookup_slow.walk_component.path_lookupat.filename_lookup.user_statfs.__do_sys_statfs.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00       +6.7e+101%       0.67 ± 70%  latency_stats.hits.devtmpfs_submit_req.devtmpfs_create_node.device_add.devm_create_dev_dax.__dax_pmem_probe.[dax_pmem_core].dax_pmem_compat_probe.[dax_pmem_compat].nvdimm_bus_probe.[libnvdimm].really_probe.driver_probe_device.device_driver_attach.__driver_attach.bus_for_each_dev
      0.00          -100.0%       0.00        latency_stats.max.path_openat.do_filp_open.do_sys_openat2.do_sys_open.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00          -100.0%       0.00        latency_stats.max.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      0.00          -100.0%       0.00        latency_stats.max.stop_two_cpus.migrate_swap.task_numa_migrate.task_numa_fault.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      0.00          -100.0%       0.00        latency_stats.max.cgroup_kn_lock_live.cgroup_procs_write.cgroup_file_write.kernfs_fop_write.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00          -100.0%       0.00        latency_stats.max.d_alloc_parallel.__lookup_slow.walk_component.link_path_walk.path_lookupat.filename_lookup.vfs_statx.__do_sys_newstat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00          -100.0%       0.00        latency_stats.max.page_lock_anon_vma_read.rmap_walk_anon.try_to_unmap.migrate_pages.migrate_misplaced_page.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      0.00          -100.0%       0.00        latency_stats.max.rwsem_down_write_slowpath.anon_vma_fork.dup_mmap.dup_mm.copy_process._do_fork.__do_sys_clone.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00          -100.0%       0.00        latency_stats.max.rwsem_down_write_slowpath.anon_vma_clone.anon_vma_fork.dup_mmap.dup_mm.copy_process._do_fork.__do_sys_clone.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00          -100.0%       0.00        latency_stats.max.rwsem_down_write_slowpath.dup_mmap.dup_mm.copy_process._do_fork.__do_sys_clone.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00          -100.0%       0.00        latency_stats.max.rwsem_down_write_slowpath.vma_link.mmap_region.do_mmap.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00          -100.0%       0.00        latency_stats.max.rwsem_down_write_slowpath.unlink_file_vma.free_pgtables.exit_mmap.mmput.begin_new_exec.load_elf_binary.exec_binprm.bprm_execve.do_execveat_common.__x64_sys_execve.do_syscall_64
      0.00          -100.0%       0.00        latency_stats.max.pipe_release.__fput.task_work_run.exit_to_user_mode_prepare.syscall_exit_to_user_mode.entry_SYSCALL_64_after_hwframe
      0.00          -100.0%       0.00        latency_stats.max.percpu_rwsem_wait.__percpu_down_read.cgroup_can_fork.copy_process._do_fork.__do_sys_clone.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00          -100.0%       0.00        latency_stats.max.wb_wait_for_completion.sync_inodes_sb.iterate_supers.ksys_sync.__do_sys_sync.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00          -100.0%       0.00        latency_stats.max.wait_on_page_bit.__filemap_fdatawait_range.filemap_fdatawait_keep_errors.sync_inodes_sb.iterate_supers.ksys_sync.__do_sys_sync.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00          -100.0%       0.00        latency_stats.max.sync_inodes_sb.iterate_supers.ksys_sync.__do_sys_sync.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00          -100.0%       0.00        latency_stats.max.put_and_wait_on_page_locked.do_swap_page.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      0.00          -100.0%       0.00        latency_stats.max.stop_one_cpu.__set_cpus_allowed_ptr.sched_setaffinity.__x64_sys_sched_setaffinity.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00          -100.0%       0.00        latency_stats.max.stop_one_cpu.sched_exec.bprm_execve.do_execveat_common.__x64_sys_execve.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00          -100.0%       0.00        latency_stats.max.rpc_wait_bit_killable.__rpc_execute.rpc_run_task.rpc_call_sync.nfs3_rpc_wrapper.nfs3_proc_access.nfs_do_access.nfs_permission.inode_permission.link_path_walk.path_openat.do_filp_open
      0.00          -100.0%       0.00        latency_stats.max.rpc_wait_bit_killable.__rpc_execute.rpc_run_task.rpc_call_sync.nfs3_rpc_wrapper.nfs3_proc_lookup.nfs_lookup.path_openat.do_filp_open.do_sys_openat2.do_sys_open.do_syscall_64
      0.00          -100.0%       0.00        latency_stats.max.rpc_wait_bit_killable.__rpc_execute.rpc_run_task.rpc_call_sync.nfs3_get_acl.get_acl.posix_acl_create.nfs3_proc_create.nfs_create.path_openat.do_filp_open.do_sys_openat2
      0.00          -100.0%       0.00        latency_stats.max.rpc_wait_bit_killable.__rpc_execute.rpc_run_task.rpc_call_sync.nfs3_rpc_wrapper.nfs3_do_create.nfs3_proc_create.nfs_create.path_openat.do_filp_open.do_sys_openat2.do_sys_open
      0.00          -100.0%       0.00        latency_stats.max.rpc_wait_bit_killable.__rpc_execute.rpc_run_task.rpc_call_sync.nfs3_rpc_wrapper.nfs3_proc_setattr.nfs_setattr.notify_change.vfs_utimes.do_utimes.__x64_sys_utimensat.do_syscall_64
      0.00          -100.0%       0.00        latency_stats.max.wait_on_page_bit.__filemap_fdatawait_range.filemap_write_and_wait_range.nfs_wb_all.nfs_file_flush.filp_close.do_dup2.__x64_sys_dup2.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00          -100.0%       0.00        latency_stats.max.rpc_wait_bit_killable.__rpc_execute.rpc_run_task.rpc_call_sync.nfs3_rpc_wrapper.nfs3_proc_getattr.__nfs_revalidate_inode.nfs_lookup_verify_inode.nfs_do_lookup_revalidate.__nfs_lookup_revalidate.path_openat.do_filp_open
      0.00          -100.0%       0.00        latency_stats.max.rpc_wait_bit_killable.__rpc_execute.rpc_run_task.rpc_call_sync.nfs3_rpc_wrapper.nfs3_proc_access.nfs_do_access.nfs_permission.inode_permission.may_open.path_openat.do_filp_open
      0.00          -100.0%       0.00        latency_stats.max.rpc_wait_bit_killable.__rpc_execute.rpc_run_task.rpc_call_sync.nfs3_rpc_wrapper.nfs3_proc_getattr.__nfs_revalidate_inode.nfs_lookup_verify_inode.nfs_do_lookup_revalidate.__nfs_lookup_revalidate.lookup_fast.path_openat
      0.00          -100.0%       0.00        latency_stats.max.cgroup_kn_lock_live.__cgroup1_procs_write.cgroup_file_write.kernfs_fop_write.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00          -100.0%       0.00        latency_stats.max.stop_two_cpus.migrate_swap.task_numa_migrate.task_numa_fault.do_huge_pmd_numa_page.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      0.00          -100.0%       0.00        latency_stats.max.rwsem_down_write_slowpath.__vma_adjust.__split_vma.__do_munmap.__vm_munmap.elf_map.load_elf_interp.load_elf_binary.exec_binprm.bprm_execve.do_execveat_common.__x64_sys_execve
      0.00          -100.0%       0.00        latency_stats.max.rwsem_down_write_slowpath.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00          -100.0%       0.00        latency_stats.max.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.copy_user_generic_unrolled._copy_from_user.__x64_sys_rt_sigprocmask.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00          -100.0%       0.00        latency_stats.max.rwsem_down_write_slowpath.do_mprotect_pkey.__x64_sys_mprotect.do_syscall_64.entry_SYSCALL_64_after_hwframe
     79.40 ±200%    -100.0%       0.00        latency_stats.max.kernfs_iop_permission.inode_permission.link_path_walk.path_openat.do_filp_open.do_sys_openat2.do_sys_open.do_syscall_64.entry_SYSCALL_64_after_hwframe
      7.80 ± 95%    -100.0%       0.00        latency_stats.max.d_alloc_parallel.__lookup_slow.walk_component.link_path_walk.path_openat.do_filp_open.do_sys_openat2.do_sys_open.do_syscall_64.entry_SYSCALL_64_after_hwframe
      4843 ±122%    -100.0%       0.00        latency_stats.max.rwsem_down_write_slowpath.__vm_munmap.__x64_sys_munmap.do_syscall_64.entry_SYSCALL_64_after_hwframe
     16.60 ±200%    -100.0%       0.00        latency_stats.max.rwsem_down_write_slowpath.do_madvise.__x64_sys_madvise.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.80 ±123%    -100.0%       0.00        latency_stats.max.d_alloc_parallel.__lookup_slow.walk_component.path_lookupat.filename_lookup.vfs_statx.__do_sys_newstat.do_syscall_64.entry_SYSCALL_64_after_hwframe
    227.20 ±129%    -100.0%       0.00        latency_stats.max.resolve_symbol.load_module.__do_sys_finit_module.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.40 ±200%    -100.0%       0.00        latency_stats.max.d_alloc_parallel.__lookup_slow.walk_component.path_lookupat.filename_lookup.do_faccessat.do_syscall_64.entry_SYSCALL_64_after_hwframe
    615.60 ±122%    -100.0%       0.00        latency_stats.max.poll_schedule_timeout.do_sys_poll.__x64_sys_ppoll.do_syscall_64.entry_SYSCALL_64_after_hwframe
     25.00 ±200%    -100.0%       0.00        latency_stats.max.rwsem_down_write_slowpath.__vma_adjust.__split_vma.mprotect_fixup.do_mprotect_pkey.__x64_sys_mprotect.do_syscall_64.entry_SYSCALL_64_after_hwframe
     75.80 ±200%    -100.0%       0.00        latency_stats.max.rwsem_down_write_slowpath.__vma_adjust.__split_vma.__do_munmap.mmap_region.do_mmap.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe
    171.20 ±200%    -100.0%       0.00        latency_stats.max.rmap_walk_anon.remove_migration_ptes.migrate_pages.migrate_misplaced_page.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      4831 ±121%     -97.6%     116.00 ±134%  latency_stats.max.do_exit.do_group_exit.get_signal.arch_do_signal.exit_to_user_mode_prepare.syscall_exit_to_user_mode.entry_SYSCALL_64_after_hwframe
      4210 ±182%     -94.5%     233.00 ±141%  latency_stats.max.load_module.__do_sys_finit_module.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1163 ±100%     -87.5%     145.33 ±  2%  latency_stats.max.rpc_wait_bit_killable.__rpc_execute.rpc_run_task.rpc_call_sync.nfs3_rpc_wrapper.nfs3_proc_lookup.nfs_lookup.__lookup_slow.walk_component.path_lookupat.filename_lookup.vfs_statx
      6357 ±147%     -85.5%     924.00 ±136%  latency_stats.max.finished_loading.load_module.__do_sys_finit_module.do_syscall_64.entry_SYSCALL_64_after_hwframe
    140.40 ±128%     -61.8%      53.67 ±141%  latency_stats.max.rpc_wait_bit_killable.__rpc_execute.rpc_run_task.rpc_call_sync.nfs3_rpc_wrapper.nfs3_proc_access.nfs_do_access.nfs_permission.inode_permission.link_path_walk.path_lookupat.filename_lookup
    175267 ± 81%     -52.5%      83199 ±141%  latency_stats.max.blk_execute_rq.__scsi_execute.ioctl_internal_command.scsi_set_medium_removal.cdrom_release.[cdrom].sr_block_release.[sr_mod].__blkdev_put.blkdev_close.__fput.task_work_run.exit_to_user_mode_prepare.syscall_exit_to_user_mode
    205883 ± 55%     -34.5%     134756 ± 87%  latency_stats.max.max
     82676 ± 69%     -29.4%      58389 ± 76%  latency_stats.max.mm_access.proc_mem_open.proc_maps_open.do_dentry_open.path_openat.do_filp_open.do_sys_openat2.do_sys_open.do_syscall_64.entry_SYSCALL_64_after_hwframe
    212.20 ± 14%      -6.7%     198.00 ± 15%  latency_stats.max.wait_woken.__inet_stream_connect.inet_stream_connect.__sys_connect.__x64_sys_connect.do_syscall_64.entry_SYSCALL_64_after_hwframe
      4915            -1.2%       4856 ±  2%  latency_stats.max.pipe_read.new_sync_read.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
      4807 ±  2%      -0.2%       4796        latency_stats.max.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64.entry_SYSCALL_64_after_hwframe
      4806 ±  3%      +2.8%       4943        latency_stats.max.ep_poll.do_epoll_wait.__x64_sys_epoll_wait.do_syscall_64.entry_SYSCALL_64_after_hwframe
      3021 ± 30%      +9.4%       3305 ± 27%  latency_stats.max.hrtimer_nanosleep.__x64_sys_nanosleep.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2567 ± 62%     +12.7%       2892 ± 36%  latency_stats.max.poll_schedule_timeout.do_select.core_sys_select.kern_select.__x64_sys_select.do_syscall_64.entry_SYSCALL_64_after_hwframe
      3939 ± 27%     +15.2%       4539 ± 12%  latency_stats.max.do_syslog.kmsg_read.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
      4186 ± 14%     +16.3%       4870 ±  2%  latency_stats.max.devkmsg_read.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
      3327 ± 26%     +19.4%       3971 ± 14%  latency_stats.max.poll_schedule_timeout.do_sys_poll.__x64_sys_poll.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1259 ±163%     +53.8%       1937 ±141%  latency_stats.max.blk_execute_rq.sg_io.scsi_cmd_ioctl.cdrom_ioctl.[cdrom].sr_block_ioctl.[sr_mod].blkdev_ioctl.block_ioctl.__x64_sys_ioctl.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1946 ± 76%     +56.3%       3043 ±129%  latency_stats.max.rpc_wait_bit_killable.__rpc_execute.rpc_run_task.rpc_call_sync.nfs3_rpc_wrapper.nfs3_proc_getattr.__nfs_revalidate_inode.nfs_access_get_cached.nfs_do_access.nfs_permission.inode_permission.link_path_walk
      1985 ± 91%     +68.8%       3350 ±  5%  latency_stats.max.pipe_write.new_sync_write.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2269 ±200%     +81.3%       4114 ±141%  latency_stats.max.msleep.cpuinfo_open.do_dentry_open.path_openat.do_filp_open.do_sys_openat2.do_sys_open.do_syscall_64.entry_SYSCALL_64_after_hwframe
     40213 ±198%     +89.7%      76285 ±141%  latency_stats.max.do_init_module.load_module.__do_sys_finit_module.do_syscall_64.entry_SYSCALL_64_after_hwframe
    207.20 ±149%    +112.2%     439.67 ±141%  latency_stats.max.rpc_wait_bit_killable.__rpc_execute.rpc_run_task.rpc_call_sync.nfs3_rpc_wrapper.nfs3_proc_lookup.nfs_lookup_revalidate_dentry.nfs_do_lookup_revalidate.__nfs_lookup_revalidate.lookup_fast.walk_component.link_path_walk
    975.40 ± 50%    +122.1%       2166 ± 67%  latency_stats.max.wait_for_partner.fifo_open.do_dentry_open.path_openat.do_filp_open.do_sys_openat2.do_sys_open.do_syscall_64.entry_SYSCALL_64_after_hwframe
    151.60 ±125%    +142.5%     367.67 ± 96%  latency_stats.max.futex_wait_queue_me.futex_wait.do_futex.__x64_sys_futex.do_syscall_64.entry_SYSCALL_64_after_hwframe
     78.20 ± 27%    +397.4%     389.00 ±141%  latency_stats.max.do_coredump.get_signal.arch_do_signal.exit_to_user_mode_prepare.syscall_exit_to_user_mode.entry_SYSCALL_64_after_hwframe
     16850 ±183%    +423.6%      88237 ±137%  latency_stats.max.m_start.seq_read.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.40 ±200%  +59983.3%     240.33 ±140%  latency_stats.max.d_alloc_parallel.path_openat.do_filp_open.do_sys_openat2.do_sys_open.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00       +3.3e+101%       0.33 ±141%  latency_stats.max.d_alloc_parallel.__lookup_slow.walk_component.path_lookupat.filename_lookup.user_statfs.__do_sys_statfs.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00       +4.8e+103%      48.00 ± 72%  latency_stats.max.devtmpfs_submit_req.devtmpfs_create_node.device_add.devm_create_dev_dax.__dax_pmem_probe.[dax_pmem_core].dax_pmem_compat_probe.[dax_pmem_compat].nvdimm_bus_probe.[libnvdimm].really_probe.driver_probe_device.device_driver_attach.__driver_attach.bus_for_each_dev
      0.00       +1.8e+105%       1781 ±141%  latency_stats.max.blk_execute_rq.__scsi_execute.sr_do_ioctl.[sr_mod].sr_packet.[sr_mod].cdrom_get_media_event.[cdrom].sr_drive_status.[sr_mod].cdrom_ioctl.[cdrom].sr_block_ioctl.[sr_mod].blkdev_ioctl.block_ioctl.__x64_sys_ioctl.do_syscall_64
      0.00       +1.9e+105%       1940 ±141%  latency_stats.max.blk_execute_rq.__scsi_execute.sr_check_events.[sr_mod].cdrom_check_events.[cdrom].sr_block_check_events.[sr_mod].disk_check_events.bdev_check_media_change.sr_block_open.[sr_mod].__blkdev_get.blkdev_get.do_dentry_open.path_openat
      0.00       +9.7e+106%      96869 ±141%  latency_stats.max.blk_execute_rq.__scsi_execute.scsi_test_unit_ready.sr_check_events.[sr_mod].cdrom_check_events.[cdrom].sr_block_check_events.[sr_mod].disk_check_events.bdev_check_media_change.sr_block_open.[sr_mod].__blkdev_get.blkdev_get.do_dentry_open
      0.00          -100.0%       0.00        latency_stats.sum.path_openat.do_filp_open.do_sys_openat2.do_sys_open.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00          -100.0%       0.00        latency_stats.sum.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      0.00          -100.0%       0.00        latency_stats.sum.stop_two_cpus.migrate_swap.task_numa_migrate.task_numa_fault.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      0.00          -100.0%       0.00        latency_stats.sum.cgroup_kn_lock_live.cgroup_procs_write.cgroup_file_write.kernfs_fop_write.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00          -100.0%       0.00        latency_stats.sum.d_alloc_parallel.__lookup_slow.walk_component.link_path_walk.path_lookupat.filename_lookup.vfs_statx.__do_sys_newstat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00          -100.0%       0.00        latency_stats.sum.page_lock_anon_vma_read.rmap_walk_anon.try_to_unmap.migrate_pages.migrate_misplaced_page.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      0.00          -100.0%       0.00        latency_stats.sum.rwsem_down_write_slowpath.anon_vma_fork.dup_mmap.dup_mm.copy_process._do_fork.__do_sys_clone.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00          -100.0%       0.00        latency_stats.sum.rwsem_down_write_slowpath.anon_vma_clone.anon_vma_fork.dup_mmap.dup_mm.copy_process._do_fork.__do_sys_clone.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00          -100.0%       0.00        latency_stats.sum.rwsem_down_write_slowpath.dup_mmap.dup_mm.copy_process._do_fork.__do_sys_clone.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00          -100.0%       0.00        latency_stats.sum.rwsem_down_write_slowpath.vma_link.mmap_region.do_mmap.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00          -100.0%       0.00        latency_stats.sum.rwsem_down_write_slowpath.unlink_file_vma.free_pgtables.exit_mmap.mmput.begin_new_exec.load_elf_binary.exec_binprm.bprm_execve.do_execveat_common.__x64_sys_execve.do_syscall_64
      0.00          -100.0%       0.00        latency_stats.sum.pipe_release.__fput.task_work_run.exit_to_user_mode_prepare.syscall_exit_to_user_mode.entry_SYSCALL_64_after_hwframe
      0.00          -100.0%       0.00        latency_stats.sum.percpu_rwsem_wait.__percpu_down_read.cgroup_can_fork.copy_process._do_fork.__do_sys_clone.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00          -100.0%       0.00        latency_stats.sum.wb_wait_for_completion.sync_inodes_sb.iterate_supers.ksys_sync.__do_sys_sync.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00          -100.0%       0.00        latency_stats.sum.wait_on_page_bit.__filemap_fdatawait_range.filemap_fdatawait_keep_errors.sync_inodes_sb.iterate_supers.ksys_sync.__do_sys_sync.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00          -100.0%       0.00        latency_stats.sum.sync_inodes_sb.iterate_supers.ksys_sync.__do_sys_sync.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00          -100.0%       0.00        latency_stats.sum.put_and_wait_on_page_locked.do_swap_page.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      0.00          -100.0%       0.00        latency_stats.sum.stop_one_cpu.__set_cpus_allowed_ptr.sched_setaffinity.__x64_sys_sched_setaffinity.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00          -100.0%       0.00        latency_stats.sum.stop_one_cpu.sched_exec.bprm_execve.do_execveat_common.__x64_sys_execve.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00          -100.0%       0.00        latency_stats.sum.rpc_wait_bit_killable.__rpc_execute.rpc_run_task.rpc_call_sync.nfs3_rpc_wrapper.nfs3_proc_access.nfs_do_access.nfs_permission.inode_permission.link_path_walk.path_openat.do_filp_open
      0.00          -100.0%       0.00        latency_stats.sum.rpc_wait_bit_killable.__rpc_execute.rpc_run_task.rpc_call_sync.nfs3_rpc_wrapper.nfs3_proc_lookup.nfs_lookup.path_openat.do_filp_open.do_sys_openat2.do_sys_open.do_syscall_64
      0.00          -100.0%       0.00        latency_stats.sum.rpc_wait_bit_killable.__rpc_execute.rpc_run_task.rpc_call_sync.nfs3_get_acl.get_acl.posix_acl_create.nfs3_proc_create.nfs_create.path_openat.do_filp_open.do_sys_openat2
      0.00          -100.0%       0.00        latency_stats.sum.rpc_wait_bit_killable.__rpc_execute.rpc_run_task.rpc_call_sync.nfs3_rpc_wrapper.nfs3_do_create.nfs3_proc_create.nfs_create.path_openat.do_filp_open.do_sys_openat2.do_sys_open
      0.00          -100.0%       0.00        latency_stats.sum.rpc_wait_bit_killable.__rpc_execute.rpc_run_task.rpc_call_sync.nfs3_rpc_wrapper.nfs3_proc_setattr.nfs_setattr.notify_change.vfs_utimes.do_utimes.__x64_sys_utimensat.do_syscall_64
      0.00          -100.0%       0.00        latency_stats.sum.wait_on_page_bit.__filemap_fdatawait_range.filemap_write_and_wait_range.nfs_wb_all.nfs_file_flush.filp_close.do_dup2.__x64_sys_dup2.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00          -100.0%       0.00        latency_stats.sum.rpc_wait_bit_killable.__rpc_execute.rpc_run_task.rpc_call_sync.nfs3_rpc_wrapper.nfs3_proc_getattr.__nfs_revalidate_inode.nfs_lookup_verify_inode.nfs_do_lookup_revalidate.__nfs_lookup_revalidate.path_openat.do_filp_open
      0.00          -100.0%       0.00        latency_stats.sum.rpc_wait_bit_killable.__rpc_execute.rpc_run_task.rpc_call_sync.nfs3_rpc_wrapper.nfs3_proc_access.nfs_do_access.nfs_permission.inode_permission.may_open.path_openat.do_filp_open
      0.00          -100.0%       0.00        latency_stats.sum.rpc_wait_bit_killable.__rpc_execute.rpc_run_task.rpc_call_sync.nfs3_rpc_wrapper.nfs3_proc_getattr.__nfs_revalidate_inode.nfs_lookup_verify_inode.nfs_do_lookup_revalidate.__nfs_lookup_revalidate.lookup_fast.path_openat
      0.00          -100.0%       0.00        latency_stats.sum.cgroup_kn_lock_live.__cgroup1_procs_write.cgroup_file_write.kernfs_fop_write.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00          -100.0%       0.00        latency_stats.sum.stop_two_cpus.migrate_swap.task_numa_migrate.task_numa_fault.do_huge_pmd_numa_page.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      0.00          -100.0%       0.00        latency_stats.sum.rwsem_down_write_slowpath.__vma_adjust.__split_vma.__do_munmap.__vm_munmap.elf_map.load_elf_interp.load_elf_binary.exec_binprm.bprm_execve.do_execveat_common.__x64_sys_execve
      0.00          -100.0%       0.00        latency_stats.sum.rwsem_down_write_slowpath.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00          -100.0%       0.00        latency_stats.sum.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.copy_user_generic_unrolled._copy_from_user.__x64_sys_rt_sigprocmask.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00          -100.0%       0.00        latency_stats.sum.rwsem_down_write_slowpath.do_mprotect_pkey.__x64_sys_mprotect.do_syscall_64.entry_SYSCALL_64_after_hwframe
     79.40 ±200%    -100.0%       0.00        latency_stats.sum.kernfs_iop_permission.inode_permission.link_path_walk.path_openat.do_filp_open.do_sys_openat2.do_sys_open.do_syscall_64.entry_SYSCALL_64_after_hwframe
      8.60 ± 98%    -100.0%       0.00        latency_stats.sum.d_alloc_parallel.__lookup_slow.walk_component.link_path_walk.path_openat.do_filp_open.do_sys_openat2.do_sys_open.do_syscall_64.entry_SYSCALL_64_after_hwframe
      4843 ±122%    -100.0%       0.00        latency_stats.sum.rwsem_down_write_slowpath.__vm_munmap.__x64_sys_munmap.do_syscall_64.entry_SYSCALL_64_after_hwframe
     16.60 ±200%    -100.0%       0.00        latency_stats.sum.rwsem_down_write_slowpath.do_madvise.__x64_sys_madvise.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.80 ±123%    -100.0%       0.00        latency_stats.sum.d_alloc_parallel.__lookup_slow.walk_component.path_lookupat.filename_lookup.vfs_statx.__do_sys_newstat.do_syscall_64.entry_SYSCALL_64_after_hwframe
    228.20 ±129%    -100.0%       0.00        latency_stats.sum.resolve_symbol.load_module.__do_sys_finit_module.do_syscall_64.entry_SYSCALL_64_after_hwframe
      3.20 ±200%    -100.0%       0.00        latency_stats.sum.d_alloc_parallel.__lookup_slow.walk_component.path_lookupat.filename_lookup.do_faccessat.do_syscall_64.entry_SYSCALL_64_after_hwframe
    642.20 ±122%    -100.0%       0.00        latency_stats.sum.poll_schedule_timeout.do_sys_poll.__x64_sys_ppoll.do_syscall_64.entry_SYSCALL_64_after_hwframe
     25.00 ±200%    -100.0%       0.00        latency_stats.sum.rwsem_down_write_slowpath.__vma_adjust.__split_vma.mprotect_fixup.do_mprotect_pkey.__x64_sys_mprotect.do_syscall_64.entry_SYSCALL_64_after_hwframe
    109.80 ±200%    -100.0%       0.00        latency_stats.sum.rwsem_down_write_slowpath.__vma_adjust.__split_vma.__do_munmap.mmap_region.do_mmap.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe
    171.20 ±200%    -100.0%       0.00        latency_stats.sum.rmap_walk_anon.remove_migration_ptes.migrate_pages.migrate_misplaced_page.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
     58893 ±193%     -99.5%     311.33 ±141%  latency_stats.sum.load_module.__do_sys_finit_module.do_syscall_64.entry_SYSCALL_64_after_hwframe
    192025 ±190%     -98.8%       2303 ±132%  latency_stats.sum.finished_loading.load_module.__do_sys_finit_module.do_syscall_64.entry_SYSCALL_64_after_hwframe
      4831 ±121%     -97.6%     116.00 ±134%  latency_stats.sum.do_exit.do_group_exit.get_signal.arch_do_signal.exit_to_user_mode_prepare.syscall_exit_to_user_mode.entry_SYSCALL_64_after_hwframe
     67961 ±114%     -88.8%       7587 ± 65%  latency_stats.sum.poll_schedule_timeout.do_select.core_sys_select.kern_select.__x64_sys_select.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1163 ±100%     -87.5%     145.33 ±  2%  latency_stats.sum.rpc_wait_bit_killable.__rpc_execute.rpc_run_task.rpc_call_sync.nfs3_rpc_wrapper.nfs3_proc_lookup.nfs_lookup.__lookup_slow.walk_component.path_lookupat.filename_lookup.vfs_statx
    140.40 ±128%     -61.8%      53.67 ±141%  latency_stats.sum.rpc_wait_bit_killable.__rpc_execute.rpc_run_task.rpc_call_sync.nfs3_rpc_wrapper.nfs3_proc_access.nfs_do_access.nfs_permission.inode_permission.link_path_walk.path_lookupat.filename_lookup
     99229 ± 22%     -55.6%      44099 ±  8%  latency_stats.sum.hrtimer_nanosleep.__x64_sys_nanosleep.do_syscall_64.entry_SYSCALL_64_after_hwframe
    175267 ± 81%     -52.5%      83199 ±141%  latency_stats.sum.blk_execute_rq.__scsi_execute.ioctl_internal_command.scsi_set_medium_removal.cdrom_release.[cdrom].sr_block_release.[sr_mod].__blkdev_put.blkdev_close.__fput.task_work_run.exit_to_user_mode_prepare.syscall_exit_to_user_mode
    615300 ± 16%     -51.5%     298615 ±  6%  latency_stats.sum.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64.entry_SYSCALL_64_after_hwframe
    760.80 ± 91%     -42.6%     437.00 ± 79%  latency_stats.sum.futex_wait_queue_me.futex_wait.do_futex.__x64_sys_futex.do_syscall_64.entry_SYSCALL_64_after_hwframe
    987092 ±  6%     -34.4%     647610 ± 10%  latency_stats.sum.pipe_read.new_sync_read.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
    987092 ±  6%     -34.4%     647610 ± 10%  latency_stats.sum.max
     82676 ± 69%     -29.4%      58389 ± 76%  latency_stats.sum.mm_access.proc_mem_open.proc_maps_open.do_dentry_open.path_openat.do_filp_open.do_sys_openat2.do_sys_open.do_syscall_64.entry_SYSCALL_64_after_hwframe
    212.20 ± 14%      -6.7%     198.00 ± 15%  latency_stats.sum.wait_woken.__inet_stream_connect.inet_stream_connect.__sys_connect.__x64_sys_connect.do_syscall_64.entry_SYSCALL_64_after_hwframe
    194779 ± 11%      +1.8%     198252 ± 14%  latency_stats.sum.ep_poll.do_epoll_wait.__x64_sys_epoll_wait.do_syscall_64.entry_SYSCALL_64_after_hwframe
      3347 ± 45%     +22.9%       4115 ± 97%  latency_stats.sum.rpc_wait_bit_killable.__rpc_execute.rpc_run_task.rpc_call_sync.nfs3_rpc_wrapper.nfs3_proc_getattr.__nfs_revalidate_inode.nfs_access_get_cached.nfs_do_access.nfs_permission.inode_permission.link_path_walk
     10592 ± 76%     +55.2%      16437 ± 25%  latency_stats.sum.poll_schedule_timeout.do_sys_poll.__x64_sys_poll.do_syscall_64.entry_SYSCALL_64_after_hwframe
     53629 ± 82%     +80.1%      96602 ± 51%  latency_stats.sum.devkmsg_read.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2269 ±200%     +81.3%       4114 ±141%  latency_stats.sum.msleep.cpuinfo_open.do_dentry_open.path_openat.do_filp_open.do_sys_openat2.do_sys_open.do_syscall_64.entry_SYSCALL_64_after_hwframe
     50787 ± 89%     +89.0%      95979 ± 54%  latency_stats.sum.do_syslog.kmsg_read.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
     40213 ±198%     +89.7%      76285 ±141%  latency_stats.sum.do_init_module.load_module.__do_sys_finit_module.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2518 ± 95%     +96.5%       4948 ± 24%  latency_stats.sum.pipe_write.new_sync_write.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
    207.20 ±149%    +112.2%     439.67 ±141%  latency_stats.sum.rpc_wait_bit_killable.__rpc_execute.rpc_run_task.rpc_call_sync.nfs3_rpc_wrapper.nfs3_proc_lookup.nfs_lookup_revalidate_dentry.nfs_do_lookup_revalidate.__nfs_lookup_revalidate.lookup_fast.walk_component.link_path_walk
    975.40 ± 50%    +122.1%       2166 ± 67%  latency_stats.sum.wait_for_partner.fifo_open.do_dentry_open.path_openat.do_filp_open.do_sys_openat2.do_sys_open.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1444 ±147%    +343.2%       6400 ±141%  latency_stats.sum.blk_execute_rq.sg_io.scsi_cmd_ioctl.cdrom_ioctl.[cdrom].sr_block_ioctl.[sr_mod].blkdev_ioctl.block_ioctl.__x64_sys_ioctl.do_syscall_64.entry_SYSCALL_64_after_hwframe
     78.20 ± 27%    +397.4%     389.00 ±141%  latency_stats.sum.do_coredump.get_signal.arch_do_signal.exit_to_user_mode_prepare.syscall_exit_to_user_mode.entry_SYSCALL_64_after_hwframe
     17462 ±176%    +901.8%     174939 ±139%  latency_stats.sum.m_start.seq_read.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.20 ±200%  +10824.2%     240.33 ±140%  latency_stats.sum.d_alloc_parallel.path_openat.do_filp_open.do_sys_openat2.do_sys_open.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00       +3.3e+101%       0.33 ±141%  latency_stats.sum.d_alloc_parallel.__lookup_slow.walk_component.path_lookupat.filename_lookup.user_statfs.__do_sys_statfs.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00       +4.8e+103%      48.00 ± 72%  latency_stats.sum.devtmpfs_submit_req.devtmpfs_create_node.device_add.devm_create_dev_dax.__dax_pmem_probe.[dax_pmem_core].dax_pmem_compat_probe.[dax_pmem_compat].nvdimm_bus_probe.[libnvdimm].really_probe.driver_probe_device.device_driver_attach.__driver_attach.bus_for_each_dev
      0.00       +1.8e+105%       1781 ±141%  latency_stats.sum.blk_execute_rq.__scsi_execute.sr_do_ioctl.[sr_mod].sr_packet.[sr_mod].cdrom_get_media_event.[cdrom].sr_drive_status.[sr_mod].cdrom_ioctl.[cdrom].sr_block_ioctl.[sr_mod].blkdev_ioctl.block_ioctl.__x64_sys_ioctl.do_syscall_64
      0.00       +1.9e+105%       1940 ±141%  latency_stats.sum.blk_execute_rq.__scsi_execute.sr_check_events.[sr_mod].cdrom_check_events.[cdrom].sr_block_check_events.[sr_mod].disk_check_events.bdev_check_media_change.sr_block_open.[sr_mod].__blkdev_get.blkdev_get.do_dentry_open.path_openat
      0.00       +9.7e+106%      96869 ±141%  latency_stats.sum.blk_execute_rq.__scsi_execute.scsi_test_unit_ready.sr_check_events.[sr_mod].cdrom_check_events.[cdrom].sr_block_check_events.[sr_mod].disk_check_events.bdev_check_media_change.sr_block_open.[sr_mod].__blkdev_get.blkdev_get.do_dentry_open
    199651            +0.2%     200132        slabinfo.Acpi-Operand.active_objs
      3564            +0.2%       3573        slabinfo.Acpi-Operand.active_slabs
    199651            +0.2%     200132        slabinfo.Acpi-Operand.num_objs
      3564            +0.2%       3573        slabinfo.Acpi-Operand.num_slabs
      2216 ±  8%      +6.1%       2351 ±  7%  slabinfo.Acpi-Parse.active_objs
     29.60 ±  7%      +7.0%      31.67 ±  5%  slabinfo.Acpi-Parse.active_slabs
      2216 ±  8%      +6.1%       2351 ±  7%  slabinfo.Acpi-Parse.num_objs
     29.60 ±  7%      +7.0%      31.67 ±  5%  slabinfo.Acpi-Parse.num_slabs
      4978            +0.3%       4995        slabinfo.Acpi-State.active_objs
     97.00            +0.3%      97.33        slabinfo.Acpi-State.active_slabs
      4978            +0.3%       4995        slabinfo.Acpi-State.num_objs
     97.00            +0.3%      97.33        slabinfo.Acpi-State.num_slabs
      2108 ±  4%      -0.9%       2089 ±  2%  slabinfo.PING.active_objs
     65.20 ±  4%      -0.3%      65.00 ±  2%  slabinfo.PING.active_slabs
      2108 ±  4%      -0.9%       2089 ±  2%  slabinfo.PING.num_objs
     65.20 ±  4%      -0.3%      65.00 ±  2%  slabinfo.PING.num_slabs
    192.00            +0.0%     192.00        slabinfo.RAW.active_objs
      6.00            +0.0%       6.00        slabinfo.RAW.active_slabs
    192.00            +0.0%     192.00        slabinfo.RAW.num_objs
      6.00            +0.0%       6.00        slabinfo.RAW.num_slabs
    109.20 ±  9%      +3.2%     112.67 ± 10%  slabinfo.RAWv6.active_objs
      4.20 ±  9%      +3.2%       4.33 ± 10%  slabinfo.RAWv6.active_slabs
    109.20 ±  9%      +3.2%     112.67 ± 10%  slabinfo.RAWv6.num_objs
      4.20 ±  9%      +3.2%       4.33 ± 10%  slabinfo.RAWv6.num_slabs
     86.80 ±  6%      +2.2%      88.67 ±  7%  slabinfo.TCP.active_objs
      6.20 ±  6%      +2.2%       6.33 ±  7%  slabinfo.TCP.active_slabs
     86.80 ±  6%      +2.2%      88.67 ±  7%  slabinfo.TCP.num_objs
      6.20 ±  6%      +2.2%       6.33 ±  7%  slabinfo.TCP.num_slabs
     52.00            -8.3%      47.67 ± 12%  slabinfo.TCPv6.active_objs
      4.00            -8.3%       3.67 ± 12%  slabinfo.TCPv6.active_slabs
     52.00            -8.3%      47.67 ± 12%  slabinfo.TCPv6.num_objs
      4.00            -8.3%       3.67 ± 12%  slabinfo.TCPv6.num_slabs
    164.00 ±  8%      -7.9%     151.00 ± 12%  slabinfo.UDPv6.active_objs
      6.60 ±  7%      -9.1%       6.00 ± 13%  slabinfo.UDPv6.active_slabs
    164.00 ±  8%      -7.9%     151.00 ± 12%  slabinfo.UDPv6.num_objs
      6.60 ±  7%      -9.1%       6.00 ± 13%  slabinfo.UDPv6.num_slabs
     30935            -2.3%      30211 ±  2%  slabinfo.anon_vma.active_objs
    672.20            -2.2%     657.33 ±  2%  slabinfo.anon_vma.active_slabs
     30941            -2.2%      30260 ±  2%  slabinfo.anon_vma.num_objs
    672.20            -2.2%     657.33 ±  2%  slabinfo.anon_vma.num_slabs
     69942            -2.2%      68395        slabinfo.anon_vma_chain.active_objs
      1093            -2.0%       1071        slabinfo.anon_vma_chain.active_slabs
     69980            -2.0%      68572        slabinfo.anon_vma_chain.num_objs
      1093            -2.0%       1071        slabinfo.anon_vma_chain.num_slabs
    631.80 ± 13%      +2.9%     650.00 ±  5%  slabinfo.bdev_cache.active_objs
     16.20 ± 13%      +2.9%      16.67 ±  5%  slabinfo.bdev_cache.active_slabs
    631.80 ± 13%      +2.9%     650.00 ±  5%  slabinfo.bdev_cache.num_objs
     16.20 ± 13%      +2.9%      16.67 ±  5%  slabinfo.bdev_cache.num_slabs
    223.00 ± 17%     -17.9%     183.00 ±  3%  slabinfo.biovec-128.active_objs
     13.40 ± 19%     -20.4%      10.67 ±  4%  slabinfo.biovec-128.active_slabs
    223.00 ± 17%     -17.9%     183.00 ±  3%  slabinfo.biovec-128.num_objs
     13.40 ± 19%     -20.4%      10.67 ±  4%  slabinfo.biovec-128.num_slabs
    358.40 ± 19%      -7.7%     330.67 ±  9%  slabinfo.biovec-64.active_objs
     11.20 ± 19%      -7.7%      10.33 ±  9%  slabinfo.biovec-64.active_slabs
    358.40 ± 19%      -7.7%     330.67 ±  9%  slabinfo.biovec-64.num_objs
     11.20 ± 19%      -7.7%      10.33 ±  9%  slabinfo.biovec-64.num_slabs
    152.20 ±  9%      -1.9%     149.33 ±  6%  slabinfo.biovec-max.active_objs
     19.00 ±  8%      -1.8%      18.67 ±  6%  slabinfo.biovec-max.active_slabs
    152.20 ±  9%      -1.9%     149.33 ±  6%  slabinfo.biovec-max.num_objs
     19.00 ±  8%      -1.8%      18.67 ±  6%  slabinfo.biovec-max.num_slabs
    549.40 ± 12%      -7.7%     507.00 ±  6%  slabinfo.blkdev_ioc.active_objs
     14.00 ± 11%      -7.1%      13.00 ±  6%  slabinfo.blkdev_ioc.active_slabs
    549.40 ± 12%      -7.7%     507.00 ±  6%  slabinfo.blkdev_ioc.num_objs
     14.00 ± 11%      -7.1%      13.00 ±  6%  slabinfo.blkdev_ioc.num_slabs
     20.80 ±200%    -100.0%       0.00        slabinfo.btrfs_delayed_node.active_objs
      0.40 ±200%    -100.0%       0.00        slabinfo.btrfs_delayed_node.active_slabs
     20.80 ±200%    -100.0%       0.00        slabinfo.btrfs_delayed_node.num_objs
      0.40 ±200%    -100.0%       0.00        slabinfo.btrfs_delayed_node.num_slabs
    138.40 ± 48%     -19.1%     112.00        slabinfo.btrfs_inode.active_objs
      4.80 ± 44%     -16.7%       4.00        slabinfo.btrfs_inode.active_slabs
    138.40 ± 48%     -19.1%     112.00        slabinfo.btrfs_inode.num_objs
      4.80 ± 44%     -16.7%       4.00        slabinfo.btrfs_inode.num_slabs
     17.40 ±200%    -100.0%       0.00        slabinfo.btrfs_ordered_extent.active_objs
      0.40 ±200%    -100.0%       0.00        slabinfo.btrfs_ordered_extent.active_slabs
     17.40 ±200%    -100.0%       0.00        slabinfo.btrfs_ordered_extent.num_objs
      0.40 ±200%    -100.0%       0.00        slabinfo.btrfs_ordered_extent.num_slabs
    565.00 ± 12%     -12.6%     494.00 ±  3%  slabinfo.buffer_head.active_objs
     14.40 ± 11%     -12.0%      12.67 ±  3%  slabinfo.buffer_head.active_slabs
    565.00 ± 12%     -12.6%     494.00 ±  3%  slabinfo.buffer_head.num_objs
     14.40 ± 11%     -12.0%      12.67 ±  3%  slabinfo.buffer_head.num_slabs
      5631            -1.0%       5577        slabinfo.cred_jar.active_objs
    133.40            -0.8%     132.33        slabinfo.cred_jar.active_slabs
      5631            -1.0%       5577        slabinfo.cred_jar.num_objs
    133.40            -0.8%     132.33        slabinfo.cred_jar.num_slabs
    126.00            -0.5%     125.33        slabinfo.dax_cache.active_objs
      3.00           -22.2%       2.33 ± 20%  slabinfo.dax_cache.active_slabs
    126.00            -0.5%     125.33        slabinfo.dax_cache.num_objs
      3.00           -22.2%       2.33 ± 20%  slabinfo.dax_cache.num_slabs
    117579 ±  2%      +0.3%     117936        slabinfo.dentry.active_objs
      2830 ±  2%      +0.1%       2833        slabinfo.dentry.active_slabs
    118902 ±  2%      +0.1%     119026        slabinfo.dentry.num_objs
      2830 ±  2%      +0.1%       2833        slabinfo.dentry.num_slabs
     32.00            +0.0%      32.00        slabinfo.dma-kmalloc-512.active_objs
      1.00            +0.0%       1.00        slabinfo.dma-kmalloc-512.active_slabs
     32.00            +0.0%      32.00        slabinfo.dma-kmalloc-512.num_objs
      1.00            +0.0%       1.00        slabinfo.dma-kmalloc-512.num_slabs
     30.00            +0.0%      30.00        slabinfo.dmaengine-unmap-128.active_objs
      1.00            +0.0%       1.00        slabinfo.dmaengine-unmap-128.active_slabs
     30.00            +0.0%      30.00        slabinfo.dmaengine-unmap-128.num_objs
      1.00            +0.0%       1.00        slabinfo.dmaengine-unmap-128.num_slabs
      1676 ± 10%      +9.7%       1839 ± 17%  slabinfo.dmaengine-unmap-16.active_objs
     39.60 ± 10%     +10.3%      43.67 ± 16%  slabinfo.dmaengine-unmap-16.active_slabs
      1676 ± 10%      +9.7%       1839 ± 17%  slabinfo.dmaengine-unmap-16.num_objs
     39.60 ± 10%     +10.3%      43.67 ± 16%  slabinfo.dmaengine-unmap-16.num_slabs
     15.00            +0.0%      15.00        slabinfo.dmaengine-unmap-256.active_objs
      1.00            +0.0%       1.00        slabinfo.dmaengine-unmap-256.active_slabs
     15.00            +0.0%      15.00        slabinfo.dmaengine-unmap-256.num_objs
      1.00            +0.0%       1.00        slabinfo.dmaengine-unmap-256.num_slabs
      4550 ±  8%      +3.5%       4707 ±  2%  slabinfo.eventpoll_pwq.active_objs
     81.20 ±  8%      +3.4%      84.00 ±  2%  slabinfo.eventpoll_pwq.active_slabs
      4550 ±  8%      +3.5%       4707 ±  2%  slabinfo.eventpoll_pwq.num_objs
     81.20 ±  8%      +3.4%      84.00 ±  2%  slabinfo.eventpoll_pwq.num_slabs
      1115 ± 14%      +8.2%       1207 ± 11%  slabinfo.file_lock_cache.active_objs
     29.60 ± 14%      +8.1%      32.00 ± 13%  slabinfo.file_lock_cache.active_slabs
      1115 ± 14%      +8.2%       1207 ± 11%  slabinfo.file_lock_cache.num_objs
     29.60 ± 14%      +8.1%      32.00 ± 13%  slabinfo.file_lock_cache.num_slabs
      4698            +1.6%       4772        slabinfo.files_cache.active_objs
    101.60            +1.7%     103.33        slabinfo.files_cache.active_slabs
      4698            +1.6%       4772        slabinfo.files_cache.num_objs
    101.60            +1.7%     103.33        slabinfo.files_cache.num_slabs
     28716 ±  3%      +5.0%      30138        slabinfo.filp.active_objs
    926.20 ±  4%      +3.9%     962.67        slabinfo.filp.active_slabs
     29652 ±  4%      +3.9%      30817        slabinfo.filp.num_objs
    926.20 ±  4%      +3.9%     962.67        slabinfo.filp.num_slabs
      3120 ± 15%      -7.0%       2901 ±  5%  slabinfo.fsnotify_mark_connector.active_objs
     24.20 ± 15%      -6.3%      22.67 ±  5%  slabinfo.fsnotify_mark_connector.active_slabs
      3120 ± 15%      -7.0%       2901 ±  5%  slabinfo.fsnotify_mark_connector.num_objs
     24.20 ± 15%      -6.3%      22.67 ±  5%  slabinfo.fsnotify_mark_connector.num_slabs
     31892            +0.9%      32178        slabinfo.ftrace_event_field.active_objs
    375.20            +0.7%     378.00        slabinfo.ftrace_event_field.active_slabs
     31892            +0.9%      32178        slabinfo.ftrace_event_field.num_objs
    375.20            +0.7%     378.00        slabinfo.ftrace_event_field.num_slabs
    104.00            +0.0%     104.00        slabinfo.hugetlbfs_inode_cache.active_objs
      2.00            +0.0%       2.00        slabinfo.hugetlbfs_inode_cache.active_slabs
    104.00            +0.0%     104.00        slabinfo.hugetlbfs_inode_cache.num_objs
      2.00            +0.0%       2.00        slabinfo.hugetlbfs_inode_cache.num_slabs
     66863            -0.4%      66623        slabinfo.inode_cache.active_objs
      1242            -0.3%       1238        slabinfo.inode_cache.active_slabs
     67098            -0.3%      66875        slabinfo.inode_cache.num_objs
      1242            -0.3%       1238        slabinfo.inode_cache.num_slabs
     87083            -0.2%      86908        slabinfo.kernfs_node_cache.active_objs
      2720            -0.2%       2715        slabinfo.kernfs_node_cache.active_slabs
     87083            -0.2%      86908        slabinfo.kernfs_node_cache.num_objs
      2720            -0.2%       2715        slabinfo.kernfs_node_cache.num_slabs
      2743 ± 17%     +22.3%       3354        slabinfo.khugepaged_mm_slot.active_objs
     75.60 ± 17%     +22.6%      92.67        slabinfo.khugepaged_mm_slot.active_slabs
      2743 ± 17%     +22.3%       3354        slabinfo.khugepaged_mm_slot.num_objs
     75.60 ± 17%     +22.6%      92.67        slabinfo.khugepaged_mm_slot.num_slabs
      4956            -0.3%       4940 ±  2%  slabinfo.kmalloc-128.active_objs
    156.80 ±  2%      -0.5%     156.00        slabinfo.kmalloc-128.active_slabs
      5019 ±  2%      -0.3%       5002        slabinfo.kmalloc-128.num_objs
    156.80 ±  2%      -0.5%     156.00        slabinfo.kmalloc-128.num_slabs
     35368            +0.5%      35535        slabinfo.kmalloc-16.active_objs
    139.00            +1.4%     141.00        slabinfo.kmalloc-16.active_slabs
     35632            +1.3%      36096        slabinfo.kmalloc-16.num_objs
    139.00            +1.4%     141.00        slabinfo.kmalloc-16.num_slabs
      6036            -0.2%       6026        slabinfo.kmalloc-192.active_objs
    146.80            -0.3%     146.33        slabinfo.kmalloc-192.active_slabs
      6165            -0.1%       6159        slabinfo.kmalloc-192.num_objs
    146.80            -0.3%     146.33        slabinfo.kmalloc-192.num_slabs
      6378 ±  2%      +4.8%       6687        slabinfo.kmalloc-1k.active_objs
    202.00 ±  2%      +4.0%     210.00        slabinfo.kmalloc-1k.active_slabs
      6464 ±  2%      +4.1%       6730        slabinfo.kmalloc-1k.num_objs
    202.00 ±  2%      +4.0%     210.00        slabinfo.kmalloc-1k.num_slabs
      8765 ±  4%      -0.9%       8687 ±  3%  slabinfo.kmalloc-256.active_objs
    276.40 ±  4%      -1.6%     272.00 ±  3%  slabinfo.kmalloc-256.active_slabs
      8864 ±  4%      -1.7%       8718 ±  3%  slabinfo.kmalloc-256.num_objs
    276.40 ±  4%      -1.6%     272.00 ±  3%  slabinfo.kmalloc-256.num_slabs
      6091 ±  4%      -1.4%       6004 ±  2%  slabinfo.kmalloc-2k.active_objs
    386.80 ±  4%      -1.2%     382.33 ±  2%  slabinfo.kmalloc-2k.active_slabs
      6198 ±  4%      -1.2%       6125 ±  2%  slabinfo.kmalloc-2k.num_objs
    386.80 ±  4%      -1.2%     382.33 ±  2%  slabinfo.kmalloc-2k.num_slabs
     90267 ±  2%      +0.2%      90479        slabinfo.kmalloc-32.active_objs
    705.20 ±  2%      +0.4%     708.00        slabinfo.kmalloc-32.active_slabs
     90374 ±  2%      +0.4%      90705        slabinfo.kmalloc-32.num_objs
    705.20 ±  2%      +0.4%     708.00        slabinfo.kmalloc-32.num_slabs
      2132 ±  4%      -4.2%       2043        slabinfo.kmalloc-4k.active_objs
    273.40 ±  4%      -5.0%     259.67        slabinfo.kmalloc-4k.active_slabs
      2189 ±  4%      -4.9%       2081        slabinfo.kmalloc-4k.num_objs
    273.40 ±  4%      -5.0%     259.67        slabinfo.kmalloc-4k.num_slabs
     60206           +66.6%     100322        slabinfo.kmalloc-512.active_objs
      2210 ±  2%     +66.3%       3676 ±  3%  slabinfo.kmalloc-512.active_slabs
     70766 ±  2%     +66.3%     117666 ±  3%  slabinfo.kmalloc-512.num_objs
      2210 ±  2%     +66.3%       3676 ±  3%  slabinfo.kmalloc-512.num_slabs
     53775            +0.8%      54179        slabinfo.kmalloc-64.active_objs
    840.60            +0.8%     847.00        slabinfo.kmalloc-64.active_slabs
     53835            +0.8%      54247        slabinfo.kmalloc-64.num_objs
    840.60            +0.8%     847.00        slabinfo.kmalloc-64.num_slabs
     54761            +1.2%      55439        slabinfo.kmalloc-8.active_objs
    109.00            +0.9%     110.00        slabinfo.kmalloc-8.active_slabs
     55808            +0.9%      56320        slabinfo.kmalloc-8.num_objs
    109.00            +0.9%     110.00        slabinfo.kmalloc-8.num_slabs
    898.40            +0.5%     902.67        slabinfo.kmalloc-8k.active_objs
    229.80            +0.4%     230.67        slabinfo.kmalloc-8k.active_slabs
    920.80            +0.4%     924.67        slabinfo.kmalloc-8k.num_objs
    229.80            +0.4%     230.67        slabinfo.kmalloc-8k.num_slabs
      7901 ±  3%      -2.6%       7691        slabinfo.kmalloc-96.active_objs
    188.80 ±  4%      -2.0%     185.00        slabinfo.kmalloc-96.active_slabs
      7957 ±  3%      -2.4%       7770        slabinfo.kmalloc-96.num_objs
    188.80 ±  4%      -2.0%     185.00        slabinfo.kmalloc-96.num_slabs
      1107 ± 21%     -26.8%     810.67 ± 12%  slabinfo.kmalloc-rcl-128.active_objs
     34.60 ± 21%     -26.8%      25.33 ± 12%  slabinfo.kmalloc-rcl-128.active_slabs
      1107 ± 21%     -26.8%     810.67 ± 12%  slabinfo.kmalloc-rcl-128.num_objs
     34.60 ± 21%     -26.8%      25.33 ± 12%  slabinfo.kmalloc-rcl-128.num_slabs
    302.40 ± 13%     -25.9%     224.00 ± 17%  slabinfo.kmalloc-rcl-192.active_objs
      7.20 ± 13%     -25.9%       5.33 ± 17%  slabinfo.kmalloc-rcl-192.active_slabs
    302.40 ± 13%     -25.9%     224.00 ± 17%  slabinfo.kmalloc-rcl-192.num_objs
      7.20 ± 13%     -25.9%       5.33 ± 17%  slabinfo.kmalloc-rcl-192.num_slabs
    166.40 ± 18%     -23.1%     128.00 ± 20%  slabinfo.kmalloc-rcl-256.active_objs
      5.20 ± 18%     -23.1%       4.00 ± 20%  slabinfo.kmalloc-rcl-256.active_slabs
    166.40 ± 18%     -23.1%     128.00 ± 20%  slabinfo.kmalloc-rcl-256.num_objs
      5.20 ± 18%     -23.1%       4.00 ± 20%  slabinfo.kmalloc-rcl-256.num_slabs
      2136 ±  6%      +1.7%       2173        slabinfo.kmalloc-rcl-512.active_objs
     66.40 ±  7%      +1.9%      67.67        slabinfo.kmalloc-rcl-512.active_slabs
      2136 ±  6%      +1.7%       2173        slabinfo.kmalloc-rcl-512.num_objs
     66.40 ±  7%      +1.9%      67.67        slabinfo.kmalloc-rcl-512.num_slabs
      6517 ±  4%      -5.4%       6163 ±  4%  slabinfo.kmalloc-rcl-64.active_objs
    101.40 ±  4%      -5.3%      96.00 ±  4%  slabinfo.kmalloc-rcl-64.active_slabs
      6519 ±  4%      -5.5%       6164 ±  4%  slabinfo.kmalloc-rcl-64.num_objs
    101.40 ±  4%      -5.3%      96.00 ±  4%  slabinfo.kmalloc-rcl-64.num_slabs
      3120 ± 11%     -16.5%       2604 ±  5%  slabinfo.kmalloc-rcl-96.active_objs
     74.20 ± 12%     -16.4%      62.00 ±  5%  slabinfo.kmalloc-rcl-96.active_slabs
      3120 ± 11%     -16.5%       2604 ±  5%  slabinfo.kmalloc-rcl-96.num_objs
     74.20 ± 12%     -16.4%      62.00 ±  5%  slabinfo.kmalloc-rcl-96.num_slabs
    377.60 ±  6%      +7.3%     405.33 ± 19%  slabinfo.kmem_cache.active_objs
     11.80 ±  6%      +7.3%      12.67 ± 19%  slabinfo.kmem_cache.active_slabs
    377.60 ±  6%      +7.3%     405.33 ± 19%  slabinfo.kmem_cache.num_objs
     11.80 ±  6%      +7.3%      12.67 ± 19%  slabinfo.kmem_cache.num_slabs
    773.20 ±  6%     +15.5%     892.67 ± 17%  slabinfo.kmem_cache_node.active_objs
     12.80 ±  5%     +14.6%      14.67 ± 17%  slabinfo.kmem_cache_node.active_slabs
    819.20 ±  5%     +14.6%     938.67 ± 17%  slabinfo.kmem_cache_node.num_objs
     12.80 ±  5%     +14.6%      14.67 ± 17%  slabinfo.kmem_cache_node.num_slabs
     17532            -0.2%      17496        slabinfo.lsm_file_cache.active_objs
    102.20            -0.2%     102.00        slabinfo.lsm_file_cache.active_slabs
     17532            -0.2%      17496        slabinfo.lsm_file_cache.num_objs
    102.20            -0.2%     102.00        slabinfo.lsm_file_cache.num_slabs
      3205            -0.6%       3185        slabinfo.mm_struct.active_objs
    106.00            -0.6%     105.33        slabinfo.mm_struct.active_slabs
      3205            -0.6%       3185        slabinfo.mm_struct.num_objs
    106.00            -0.6%     105.33        slabinfo.mm_struct.num_slabs
    950.40 ± 14%      +0.2%     952.00 ± 11%  slabinfo.mnt_cache.active_objs
     18.60 ± 14%      +0.4%      18.67 ± 11%  slabinfo.mnt_cache.active_slabs
    950.40 ± 14%      +0.2%     952.00 ± 11%  slabinfo.mnt_cache.num_objs
     18.60 ± 14%      +0.4%      18.67 ± 11%  slabinfo.mnt_cache.num_slabs
     34.00            +0.0%      34.00        slabinfo.mqueue_inode_cache.active_objs
      1.00            +0.0%       1.00        slabinfo.mqueue_inode_cache.active_slabs
     34.00            +0.0%      34.00        slabinfo.mqueue_inode_cache.num_objs
      1.00            +0.0%       1.00        slabinfo.mqueue_inode_cache.num_slabs
    769.80            -0.0%     769.67        slabinfo.names_cache.active_objs
     96.20            -0.2%      96.00        slabinfo.names_cache.active_slabs
    769.80            -0.0%     769.67        slabinfo.names_cache.num_objs
     96.20            -0.2%      96.00        slabinfo.names_cache.num_slabs
    120.00            +0.0%     120.00        slabinfo.nfs_inode_cache.active_objs
      4.00            +0.0%       4.00        slabinfo.nfs_inode_cache.active_slabs
    120.00            +0.0%     120.00        slabinfo.nfs_inode_cache.num_objs
      4.00            +0.0%       4.00        slabinfo.nfs_inode_cache.num_slabs
     73.00 ± 13%      +2.7%      75.00 ± 13%  slabinfo.nfs_read_data.active_objs
      1.60 ± 30%      +4.2%       1.67 ± 28%  slabinfo.nfs_read_data.active_slabs
     73.00 ± 13%      +2.7%      75.00 ± 13%  slabinfo.nfs_read_data.num_objs
      1.60 ± 30%      +4.2%       1.67 ± 28%  slabinfo.nfs_read_data.num_slabs
    352.80 ± 26%     -18.0%     289.33 ± 20%  slabinfo.numa_policy.active_objs
      5.60 ± 24%     -16.7%       4.67 ± 20%  slabinfo.numa_policy.active_slabs
    352.80 ± 26%     -18.0%     289.33 ± 20%  slabinfo.numa_policy.num_objs
      5.60 ± 24%     -16.7%       4.67 ± 20%  slabinfo.numa_policy.num_slabs
      9425            +1.8%       9595        slabinfo.pde_opener.active_objs
     92.00            +1.4%      93.33        slabinfo.pde_opener.active_slabs
      9425            +1.8%       9595        slabinfo.pde_opener.num_objs
     92.00            +1.4%      93.33        slabinfo.pde_opener.num_slabs
      4537            -1.7%       4459        slabinfo.pid.active_objs
    141.20            -1.8%     138.67        slabinfo.pid.active_slabs
      4537            -1.7%       4459        slabinfo.pid.num_objs
    141.20            -1.8%     138.67        slabinfo.pid.num_slabs
    105.80 ± 70%     -47.1%      56.00        slabinfo.pid_namespace.active_objs
      1.80 ± 64%     -44.4%       1.00        slabinfo.pid_namespace.active_slabs
    105.80 ± 70%     -47.1%      56.00        slabinfo.pid_namespace.num_objs
      1.80 ± 64%     -44.4%       1.00        slabinfo.pid_namespace.num_slabs
      1652 ±  4%      +3.4%       1709 ±  6%  slabinfo.pool_workqueue.active_objs
     51.00 ±  4%      +3.3%      52.67 ±  7%  slabinfo.pool_workqueue.active_slabs
      1652 ±  4%      +3.4%       1709 ±  6%  slabinfo.pool_workqueue.num_objs
     51.00 ±  4%      +3.3%      52.67 ±  7%  slabinfo.pool_workqueue.num_slabs
      3864            -0.7%       3836        slabinfo.proc_dir_entry.active_objs
     92.00            -0.7%      91.33        slabinfo.proc_dir_entry.active_slabs
      3864            -0.7%       3836        slabinfo.proc_dir_entry.num_objs
     92.00            -0.7%      91.33        slabinfo.proc_dir_entry.num_slabs
     15443 ±  5%      -9.7%      13950        slabinfo.proc_inode_cache.active_objs
    329.00 ±  6%      -8.3%     301.67 ±  2%  slabinfo.proc_inode_cache.active_slabs
     15813 ±  6%      -8.3%      14501 ±  2%  slabinfo.proc_inode_cache.num_objs
    329.00 ±  6%      -8.3%     301.67 ±  2%  slabinfo.proc_inode_cache.num_slabs
    255149            -0.4%     254216        slabinfo.radix_tree_node.active_objs
      4558            -0.4%       4541        slabinfo.radix_tree_node.active_slabs
    255287            -0.4%     254355        slabinfo.radix_tree_node.num_objs
      4558            -0.4%       4541        slabinfo.radix_tree_node.num_slabs
    134.40 ±  5%      +3.2%     138.67 ±  5%  slabinfo.request_queue.active_objs
      8.40 ±  5%      +3.2%       8.67 ±  5%  slabinfo.request_queue.active_slabs
    134.40 ±  5%      +3.2%     138.67 ±  5%  slabinfo.request_queue.num_objs
      8.40 ±  5%      +3.2%       8.67 ±  5%  slabinfo.request_queue.num_slabs
     91.80 ± 22%     +11.1%     102.00        slabinfo.rpc_inode_cache.active_objs
      1.80 ± 22%     +11.1%       2.00        slabinfo.rpc_inode_cache.active_slabs
     91.80 ± 22%     +11.1%     102.00        slabinfo.rpc_inode_cache.num_objs
      1.80 ± 22%     +11.1%       2.00        slabinfo.rpc_inode_cache.num_slabs
    928.00            +0.0%     928.00        slabinfo.scsi_sense_cache.active_objs
     29.00            +0.0%      29.00        slabinfo.scsi_sense_cache.active_slabs
    928.00            +0.0%     928.00        slabinfo.scsi_sense_cache.num_objs
     29.00            +0.0%      29.00        slabinfo.scsi_sense_cache.num_slabs
      3264            +0.0%       3264        slabinfo.seq_file.active_objs
     96.00            +0.0%      96.00        slabinfo.seq_file.active_slabs
      3264            +0.0%       3264        slabinfo.seq_file.num_objs
     96.00            +0.0%      96.00        slabinfo.seq_file.num_slabs
      5449 ±  2%      +0.7%       5486 ±  2%  slabinfo.shmem_inode_cache.active_objs
    117.80 ±  2%      +0.5%     118.33 ±  2%  slabinfo.shmem_inode_cache.active_slabs
      5449 ±  2%      +0.7%       5486 ±  2%  slabinfo.shmem_inode_cache.num_objs
    117.80 ±  2%      +0.5%     118.33 ±  2%  slabinfo.shmem_inode_cache.num_slabs
      2552 ±  3%      -2.1%       2498 ±  2%  slabinfo.sighand_cache.active_objs
    172.20 ±  2%      -1.9%     169.00 ±  2%  slabinfo.sighand_cache.active_slabs
      2588 ±  2%      -1.8%       2541 ±  2%  slabinfo.sighand_cache.num_objs
    172.20 ±  2%      -1.9%     169.00 ±  2%  slabinfo.sighand_cache.num_slabs
      3887 ±  2%      -0.3%       3877        slabinfo.signal_cache.active_objs
    140.60 ±  2%      -0.7%     139.67        slabinfo.signal_cache.active_slabs
      3948 ±  2%      -0.6%       3926        slabinfo.signal_cache.num_objs
    140.60 ±  2%      -0.7%     139.67        slabinfo.signal_cache.num_slabs
    581.60 ± 14%      -3.4%     562.00 ± 10%  slabinfo.skbuff_fclone_cache.active_objs
     17.60 ± 16%      -3.4%      17.00 ± 12%  slabinfo.skbuff_fclone_cache.active_slabs
    581.60 ± 14%      -3.4%     562.00 ± 10%  slabinfo.skbuff_fclone_cache.num_objs
     17.60 ± 16%      -3.4%      17.00 ± 12%  slabinfo.skbuff_fclone_cache.num_slabs
      4339 ± 10%      +5.7%       4585 ± 10%  slabinfo.skbuff_head_cache.active_objs
    135.60 ± 10%      +6.2%     144.00 ± 10%  slabinfo.skbuff_head_cache.active_slabs
      4345 ± 10%      +6.2%       4617 ± 10%  slabinfo.skbuff_head_cache.num_objs
    135.60 ± 10%      +6.2%     144.00 ± 10%  slabinfo.skbuff_head_cache.num_slabs
      3405 ±  3%      -1.3%       3359        slabinfo.sock_inode_cache.active_objs
     86.60 ±  2%      -1.1%      85.67        slabinfo.sock_inode_cache.active_slabs
      3405 ±  3%      -1.3%       3359        slabinfo.sock_inode_cache.num_objs
     86.60 ±  2%      -1.1%      85.67        slabinfo.sock_inode_cache.num_slabs
      6129            +0.7%       6169        slabinfo.task_delay_info.active_objs
    119.80            +0.7%     120.67        slabinfo.task_delay_info.active_slabs
      6129            +0.7%       6169        slabinfo.task_delay_info.num_objs
    119.80            +0.7%     120.67        slabinfo.task_delay_info.num_slabs
      1296 ± 10%      +1.7%       1318 ±  3%  slabinfo.task_group.active_objs
     27.60 ± 10%      +3.9%      28.67 ±  3%  slabinfo.task_group.active_slabs
      1296 ± 10%      +1.7%       1318 ±  3%  slabinfo.task_group.num_objs
     27.60 ± 10%      +3.9%      28.67 ±  3%  slabinfo.task_group.num_slabs
      1593 ±  4%      -3.5%       1538 ±  2%  slabinfo.task_struct.active_objs
      1599 ±  4%      -3.4%       1544 ±  2%  slabinfo.task_struct.active_slabs
      1599 ±  4%      -3.4%       1544 ±  2%  slabinfo.task_struct.num_objs
      1599 ±  4%      -3.4%       1544 ±  2%  slabinfo.task_struct.num_slabs
    105.80            -2.0%     103.67        slabinfo.taskstats.active_objs
      2.00            +0.0%       2.00        slabinfo.taskstats.active_slabs
    105.80            -2.0%     103.67        slabinfo.taskstats.num_objs
      2.00            +0.0%       2.00        slabinfo.taskstats.num_slabs
      2633 ±  2%      -3.3%       2545 ±  3%  slabinfo.trace_event_file.active_objs
     57.20 ±  2%      -3.3%      55.33 ±  3%  slabinfo.trace_event_file.active_slabs
      2633 ±  2%      -3.3%       2545 ±  3%  slabinfo.trace_event_file.num_objs
     57.20 ±  2%      -3.3%      55.33 ±  3%  slabinfo.trace_event_file.num_slabs
    105.60 ± 23%      -6.2%      99.00 ± 27%  slabinfo.tw_sock_TCP.active_objs
      3.20 ± 23%      -6.3%       3.00 ± 27%  slabinfo.tw_sock_TCP.active_slabs
    105.60 ± 23%      -6.2%      99.00 ± 27%  slabinfo.tw_sock_TCP.num_objs
      3.20 ± 23%      -6.3%       3.00 ± 27%  slabinfo.tw_sock_TCP.num_slabs
   1345825           +75.7%    2364088        slabinfo.vm_area_struct.active_objs
     40117          +103.2%      81517        slabinfo.vm_area_struct.active_slabs
   1604716          +103.2%    3260692        slabinfo.vm_area_struct.num_objs
     40117          +103.2%      81517        slabinfo.vm_area_struct.num_slabs
      9416 ±  2%      +1.7%       9574 ±  2%  slabinfo.vmap_area.active_objs
    147.00 ±  2%      +1.6%     149.33 ±  2%  slabinfo.vmap_area.active_slabs
      9437 ±  2%      +1.6%       9584 ±  2%  slabinfo.vmap_area.num_objs
    147.00 ±  2%      +1.6%     149.33 ±  2%  slabinfo.vmap_area.num_slabs
     80.60 ± 29%      -1.2%      79.67 ± 14%  slabinfo.xfrm_state.active_objs
      1.40 ± 34%      -4.8%       1.33 ± 35%  slabinfo.xfrm_state.active_slabs
     80.60 ± 29%      -1.2%      79.67 ± 14%  slabinfo.xfrm_state.num_objs
      1.40 ± 34%      -4.8%       1.33 ± 35%  slabinfo.xfrm_state.num_slabs
    784.80 ±  2%      -0.1%     784.33        softirqs.BLOCK
      8.80 ± 84%     +21.2%      10.67 ±104%  softirqs.CPU0.BLOCK
      1.00            +0.0%       1.00        softirqs.CPU0.HI
    110.40 ± 41%     -25.1%      82.67 ± 58%  softirqs.CPU0.NET_RX
      4.00 ± 47%     -75.0%       1.00 ± 81%  softirqs.CPU0.NET_TX
      6886 ±  2%     -51.0%       3373 ±  3%  softirqs.CPU0.RCU
      4936 ± 10%      +1.1%       4992 ±  9%  softirqs.CPU0.SCHED
    113.20            -0.2%     113.00        softirqs.CPU0.TASKLET
      1962 ± 22%     -46.8%       1044 ± 32%  softirqs.CPU0.TIMER
      4.40 ±177%    +248.5%      15.33 ± 91%  softirqs.CPU1.BLOCK
     47.40 ± 22%   +2619.4%       1289 ± 99%  softirqs.CPU1.NET_RX
      1.00 ± 63%    +500.0%       6.00        softirqs.CPU1.NET_TX
      2997 ±  7%     +68.3%       5046 ± 32%  softirqs.CPU1.RCU
      4038 ± 15%      +8.5%       4382 ±  5%  softirqs.CPU1.SCHED
      0.00       +1.7e+102%       1.67 ± 74%  softirqs.CPU1.TASKLET
    205.40 ± 41%    +369.5%     964.33 ± 63%  softirqs.CPU1.TIMER
      7.20 ± 88%    -100.0%       0.00        softirqs.CPU10.BLOCK
      1936 ±  7%     +36.6%       2645        softirqs.CPU10.RCU
      3043 ± 11%      -8.4%       2787 ±  8%  softirqs.CPU10.SCHED
    170.00 ± 34%     -63.3%      62.33 ± 14%  softirqs.CPU10.TIMER
      7.20 ±186%     +62.0%      11.67 ± 74%  softirqs.CPU11.BLOCK
      1.00            +0.0%       1.00        softirqs.CPU11.HI
      0.00       +3.3e+101%       0.33 ±141%  softirqs.CPU11.NET_RX
      1972 ±  7%     +34.2%       2648 ±  2%  softirqs.CPU11.RCU
      2998 ±  7%      -7.8%       2764 ±  3%  softirqs.CPU11.SCHED
     54.00            +0.0%      54.00        softirqs.CPU11.TASKLET
    333.40 ± 62%     -81.5%      61.67        softirqs.CPU11.TIMER
      2.00 ±154%     -66.7%       0.67 ±141%  softirqs.CPU12.BLOCK
      0.00       +6.7e+101%       0.67 ±141%  softirqs.CPU12.NET_RX
      2196 ± 22%     +21.0%       2658        softirqs.CPU12.RCU
      2828 ±  7%      +4.0%       2942 ± 12%  softirqs.CPU12.SCHED
    193.40 ± 69%     -65.9%      66.00 ± 11%  softirqs.CPU12.TIMER
      8.00 ±154%      +8.3%       8.67 ±110%  softirqs.CPU13.BLOCK
      2077 ±  8%     +31.0%       2720 ±  6%  softirqs.CPU13.RCU
      3100 ± 13%      -4.9%       2947 ±  4%  softirqs.CPU13.SCHED
    178.00 ± 27%     +58.1%     281.33 ± 25%  softirqs.CPU13.TIMER
      3.20 ±170%     -89.6%       0.33 ±141%  softirqs.CPU14.BLOCK
      1970 ±  5%     +63.8%       3227 ± 19%  softirqs.CPU14.RCU
      3065 ±  8%      -4.7%       2922 ±  3%  softirqs.CPU14.SCHED
    253.40 ± 34%     -50.5%     125.33 ± 29%  softirqs.CPU14.TIMER
      0.00       +6.7e+101%       0.67 ±141%  softirqs.CPU15.BLOCK
      2.00            +0.0%       2.00        softirqs.CPU15.NET_RX
      2007 ±  8%     +38.1%       2773 ±  4%  softirqs.CPU15.RCU
      2821 ± 12%     +15.3%       3254 ± 10%  softirqs.CPU15.SCHED
      2.00            +0.0%       2.00        softirqs.CPU15.TASKLET
    351.00 ± 45%     -19.5%     282.67 ± 91%  softirqs.CPU15.TIMER
      6.60 ±177%    +233.3%      22.00 ± 94%  softirqs.CPU16.BLOCK
      2.00            +0.0%       2.00        softirqs.CPU16.NET_RX
      2043 ± 14%     +31.6%       2689 ±  4%  softirqs.CPU16.RCU
      3162 ±  7%      -7.8%       2917 ±  8%  softirqs.CPU16.SCHED
      1.60 ± 50%     -58.3%       0.67 ±141%  softirqs.CPU16.TASKLET
    384.00 ±115%     +62.8%     625.00 ±114%  softirqs.CPU16.TIMER
     21.00 ±100%     -77.8%       4.67 ±141%  softirqs.CPU17.BLOCK
      2.00            +0.0%       2.00        softirqs.CPU17.NET_RX
      2012 ±  9%     +26.7%       2550 ±  5%  softirqs.CPU17.RCU
      3035 ±  4%     -13.7%       2620 ±  6%  softirqs.CPU17.SCHED
     12.00 ±183%     -83.3%       2.00        softirqs.CPU17.TASKLET
    152.40 ± 56%    +316.9%     635.33 ±123%  softirqs.CPU17.TIMER
      1.80 ±123%    +214.8%       5.67 ±141%  softirqs.CPU18.BLOCK
      2.00            +0.0%       2.00        softirqs.CPU18.NET_RX
      1936 ±  8%     +43.1%       2771 ±  6%  softirqs.CPU18.RCU
      2916 ±  4%      -2.4%       2847 ±  6%  softirqs.CPU18.SCHED
      1.60 ± 50%     +25.0%       2.00        softirqs.CPU18.TASKLET
    208.60 ± 45%     -58.1%      87.33 ± 36%  softirqs.CPU18.TIMER
      0.60 ±133%   +2177.8%      13.67 ±141%  softirqs.CPU19.BLOCK
      2.00            +0.0%       2.00        softirqs.CPU19.NET_RX
      1925 ±  6%     +42.4%       2742        softirqs.CPU19.RCU
      2641 ± 18%      +6.4%       2810 ±  4%  softirqs.CPU19.SCHED
      2.00           -33.3%       1.33 ± 70%  softirqs.CPU19.TASKLET
    191.80 ± 36%     -30.7%     133.00 ± 34%  softirqs.CPU19.TIMER
      4.40 ±200%     -84.8%       0.67 ±141%  softirqs.CPU2.BLOCK
      2611 ±  3%     +35.0%       3526 ±  9%  softirqs.CPU2.RCU
      3550 ± 11%     -12.7%       3099 ±  6%  softirqs.CPU2.SCHED
      0.20 ±200%    -100.0%       0.00        softirqs.CPU2.TASKLET
    431.60 ± 77%     -47.9%     225.00 ± 20%  softirqs.CPU2.TIMER
      2.00            +0.0%       2.00        softirqs.CPU20.NET_RX
      0.00          -100.0%       0.00        softirqs.CPU20.NET_TX
      1932 ±  8%     +44.5%       2792 ±  2%  softirqs.CPU20.RCU
      2811 ±  8%      -1.4%       2772 ±  4%  softirqs.CPU20.SCHED
      2.00            +0.0%       2.00        softirqs.CPU20.TASKLET
    217.40 ± 54%     -51.5%     105.33 ± 20%  softirqs.CPU20.TIMER
      0.00       +3.3e+101%       0.33 ±141%  softirqs.CPU21.BLOCK
      2.20 ± 18%      -9.1%       2.00        softirqs.CPU21.NET_RX
      1926 ±  6%     +36.4%       2628 ±  3%  softirqs.CPU21.RCU
      2679 ±  7%      +4.9%       2809        softirqs.CPU21.SCHED
      2.00            +0.0%       2.00        softirqs.CPU21.TASKLET
    259.80 ± 40%     -28.5%     185.67 ± 56%  softirqs.CPU21.TIMER
      6.40 ±200%    -100.0%       0.00        softirqs.CPU22.BLOCK
      2.00            +0.0%       2.00        softirqs.CPU22.NET_RX
      2088 ± 20%     +50.8%       3149 ± 26%  softirqs.CPU22.RCU
      3141 ± 10%     -10.1%       2825 ± 19%  softirqs.CPU22.SCHED
      1.60 ± 50%     +25.0%       2.00        softirqs.CPU22.TASKLET
    381.20 ± 92%     +33.9%     510.33 ±124%  softirqs.CPU22.TIMER
      2.40 ±200%   +2538.9%      63.33 ±141%  softirqs.CPU23.BLOCK
      0.00          -100.0%       0.00        softirqs.CPU23.NET_TX
      1933 ± 12%     +39.7%       2700 ±  6%  softirqs.CPU23.RCU
      2848 ±  7%      -2.0%       2792 ±  8%  softirqs.CPU23.SCHED
      2.00           -33.3%       1.33 ± 70%  softirqs.CPU23.TASKLET
    343.00 ± 58%     -40.0%     205.67 ± 80%  softirqs.CPU23.TIMER
     20.60 ±116%      +5.2%      21.67 ±134%  softirqs.CPU24.BLOCK
      0.20 ±200%    -100.0%       0.00        softirqs.CPU24.NET_RX
      2688 ±  3%     +31.0%       3521 ±  6%  softirqs.CPU24.RCU
      2939 ±  9%     -11.5%       2601 ± 15%  softirqs.CPU24.SCHED
      0.00       +3.3e+101%       0.33 ±141%  softirqs.CPU24.TASKLET
    203.00 ± 31%    +140.4%     488.00 ±119%  softirqs.CPU24.TIMER
      6.40 ±177%    -100.0%       0.00        softirqs.CPU25.BLOCK
      0.00          -100.0%       0.00        softirqs.CPU25.NET_TX
      2737 ±  8%     +13.9%       3119 ±  2%  softirqs.CPU25.RCU
      3319 ± 12%     -17.1%       2750 ±  7%  softirqs.CPU25.SCHED
      0.00          -100.0%       0.00        softirqs.CPU25.TASKLET
    273.40 ± 46%     -62.1%     103.67 ± 35%  softirqs.CPU25.TIMER
      4.00 ±114%    +408.3%      20.33 ±127%  softirqs.CPU26.BLOCK
      1.00 ±200%    -100.0%       0.00        softirqs.CPU26.NET_TX
      2317 ±  5%     +30.1%       3014 ±  2%  softirqs.CPU26.RCU
      3248 ± 16%      -4.7%       3095 ± 12%  softirqs.CPU26.SCHED
      0.00          -100.0%       0.00        softirqs.CPU26.TASKLET
    403.00 ±125%     -21.2%     317.67 ± 97%  softirqs.CPU26.TIMER
     12.40 ±200%     -11.3%      11.00 ±128%  softirqs.CPU27.BLOCK
      2191 ±  6%     +25.8%       2756 ±  3%  softirqs.CPU27.RCU
      2933 ±  6%      -7.3%       2719 ±  7%  softirqs.CPU27.SCHED
      1.60 ± 30%     +25.0%       2.00        softirqs.CPU27.TASKLET
    360.20 ± 43%     +62.5%     585.33 ± 93%  softirqs.CPU27.TIMER
      0.00       +4.3e+103%      42.67 ±141%  softirqs.CPU28.BLOCK
      2005 ±  3%     +38.8%       2783 ±  2%  softirqs.CPU28.RCU
      3058 ±  5%     -11.0%       2720 ±  2%  softirqs.CPU28.SCHED
      6.20 ±143%     -67.7%       2.00        softirqs.CPU28.TASKLET
    305.40 ± 60%     -62.3%     115.00 ± 37%  softirqs.CPU28.TIMER
      5.80 ±200%    +256.3%      20.67 ±141%  softirqs.CPU29.BLOCK
      0.00       +1.3e+102%       1.33 ±141%  softirqs.CPU29.NET_TX
      2118 ± 18%     +31.3%       2782 ± 12%  softirqs.CPU29.RCU
      2837 ±  8%      +6.4%       3019 ± 13%  softirqs.CPU29.SCHED
      9.40 ±127%     -78.7%       2.00        softirqs.CPU29.TASKLET
    199.20 ± 43%    +380.8%     957.67 ± 56%  softirqs.CPU29.TIMER
      2.40 ±200%     +11.1%       2.67 ±141%  softirqs.CPU3.BLOCK
      0.80 ±200%    -100.0%       0.00        softirqs.CPU3.NET_TX
      2413 ±  7%     +33.8%       3229 ±  5%  softirqs.CPU3.RCU
      3226 ± 18%      -6.5%       3018 ±  2%  softirqs.CPU3.SCHED
      0.20 ±200%    -100.0%       0.00        softirqs.CPU3.TASKLET
    422.40 ±111%      +3.6%     437.67 ±112%  softirqs.CPU3.TIMER
      0.00          -100.0%       0.00        softirqs.CPU30.BLOCK
      0.00       +3.3e+101%       0.33 ±141%  softirqs.CPU30.NET_TX
      1920 ±  8%     +61.7%       3104 ± 14%  softirqs.CPU30.RCU
      2959 ±  8%      -3.3%       2860 ±  4%  softirqs.CPU30.SCHED
      1.60 ± 30%     +25.0%       2.00        softirqs.CPU30.TASKLET
    220.20 ± 59%     -33.1%     147.33 ± 69%  softirqs.CPU30.TIMER
      9.00 ±194%     -81.5%       1.67 ±141%  softirqs.CPU31.BLOCK
      0.00       +3.3e+101%       0.33 ±141%  softirqs.CPU31.NET_RX
      1966 ±  6%     +39.7%       2747 ±  5%  softirqs.CPU31.RCU
      3207 ±  9%      -9.2%       2911 ±  7%  softirqs.CPU31.SCHED
      1.80 ± 22%      -7.4%       1.67 ± 28%  softirqs.CPU31.TASKLET
    240.60 ± 35%     -25.3%     179.67 ± 46%  softirqs.CPU31.TIMER
     27.40 ±198%     -61.1%      10.67 ±141%  softirqs.CPU32.BLOCK
      0.00          -100.0%       0.00        softirqs.CPU32.NET_RX
      1947 ± 10%     +37.3%       2674 ± 13%  softirqs.CPU32.RCU
      3235 ±  9%     -17.0%       2685 ±  6%  softirqs.CPU32.SCHED
      1.80 ± 22%    +103.7%       3.67 ± 46%  softirqs.CPU32.TASKLET
    154.00 ± 31%     -19.5%     124.00 ± 23%  softirqs.CPU32.TIMER
     12.40 ±200%    -100.0%       0.00        softirqs.CPU33.BLOCK
      1840 ±  5%     +29.6%       2386 ±  4%  softirqs.CPU33.RCU
      2970 ± 11%      -4.2%       2846 ±  5%  softirqs.CPU33.SCHED
      1.80 ± 22%     +11.1%       2.00        softirqs.CPU33.TASKLET
    231.60 ± 45%     +32.3%     306.33 ±107%  softirqs.CPU33.TIMER
      0.00       +3.3e+101%       0.33 ±141%  softirqs.CPU34.BLOCK
      1854 ± 10%     +34.2%       2488        softirqs.CPU34.RCU
      2674 ±  4%     +10.1%       2946 ± 11%  softirqs.CPU34.SCHED
      2.00            +0.0%       2.00        softirqs.CPU34.TASKLET
    177.80 ± 37%     +22.2%     217.33 ± 22%  softirqs.CPU34.TIMER
     21.00 ±145%     +73.0%      36.33 ± 67%  softirqs.CPU35.BLOCK
      1991 ± 10%     +24.0%       2468 ±  6%  softirqs.CPU35.RCU
      3255 ±  8%     -14.1%       2795 ± 11%  softirqs.CPU35.SCHED
      0.00         +3e+102%       3.00 ±141%  softirqs.CPU35.TASKLET
    220.40 ± 54%     -57.5%      93.67 ± 47%  softirqs.CPU35.TIMER
     13.60 ±178%     -95.1%       0.67 ±141%  softirqs.CPU36.BLOCK
      1841 ±  9%     +31.7%       2425 ±  5%  softirqs.CPU36.RCU
      3068 ±  6%      -8.5%       2809 ±  8%  softirqs.CPU36.SCHED
    151.40 ± 40%    +118.4%     330.67 ± 87%  softirqs.CPU36.TIMER
     14.00 ±172%    -100.0%       0.00        softirqs.CPU37.BLOCK
      1864 ±  9%     +23.2%       2297        softirqs.CPU37.RCU
      2907 ±  6%      -1.9%       2852 ±  6%  softirqs.CPU37.SCHED
      0.00       +3.3e+101%       0.33 ±141%  softirqs.CPU37.TASKLET
    228.00 ± 27%     -43.1%     129.67 ± 53%  softirqs.CPU37.TIMER
      1.80 ±150%    +992.6%      19.67 ±141%  softirqs.CPU38.BLOCK
      0.00          -100.0%       0.00        softirqs.CPU38.NET_TX
      1803 ±  4%     +34.9%       2433 ± 11%  softirqs.CPU38.RCU
      3001 ± 10%      +3.3%       3100 ±  8%  softirqs.CPU38.SCHED
    189.00 ± 67%     -66.8%      62.67        softirqs.CPU38.TIMER
     25.60 ±140%    -100.0%       0.00        softirqs.CPU39.BLOCK
      0.20 ±200%    -100.0%       0.00        softirqs.CPU39.NET_RX
      1794 ±  7%     +35.5%       2431 ±  3%  softirqs.CPU39.RCU
      3072 ±  6%      -7.9%       2830 ±  7%  softirqs.CPU39.SCHED
      7.20 ±125%    -100.0%       0.00        softirqs.CPU39.TASKLET
    159.60 ± 35%     -48.0%      83.00 ± 26%  softirqs.CPU39.TIMER
      0.00       +8.7e+102%       8.67 ±141%  softirqs.CPU4.BLOCK
      0.20 ±200%    -100.0%       0.00        softirqs.CPU4.NET_RX
      2273 ± 13%     +36.7%       3107        softirqs.CPU4.RCU
      3131 ±  3%      +1.1%       3166 ± 10%  softirqs.CPU4.SCHED
    253.20 ± 58%      +8.0%     273.33 ± 36%  softirqs.CPU4.TIMER
      6.20 ±176%     -67.7%       2.00 ±141%  softirqs.CPU40.BLOCK
      0.20 ±200%    -100.0%       0.00        softirqs.CPU40.NET_RX
      1860 ±  2%     +28.4%       2389 ±  7%  softirqs.CPU40.RCU
      3268 ± 12%     -13.1%       2841 ±  7%  softirqs.CPU40.SCHED
      0.00       +6.7e+101%       0.67 ±141%  softirqs.CPU40.TASKLET
    249.00 ± 28%     -46.6%     133.00 ± 48%  softirqs.CPU40.TIMER
      5.80 ±175%     -82.8%       1.00 ± 81%  softirqs.CPU41.BLOCK
      1919 ±  6%     +43.6%       2756 ±  8%  softirqs.CPU41.RCU
      3147 ±  7%      -4.0%       3023 ±  3%  softirqs.CPU41.SCHED
    295.40 ± 36%     -38.4%     182.00 ± 58%  softirqs.CPU41.TIMER
      0.20 ±200%  +11400.0%      23.00 ±141%  softirqs.CPU42.BLOCK
      2008 ±  4%     +78.3%       3580 ± 47%  softirqs.CPU42.RCU
      3071 ± 14%     -10.0%       2763 ±  5%  softirqs.CPU42.SCHED
    297.00 ± 30%     +56.5%     464.67 ±120%  softirqs.CPU42.TIMER
     13.20 ±184%    -100.0%       0.00        softirqs.CPU43.BLOCK
      2040 ± 15%     +25.7%       2564 ± 11%  softirqs.CPU43.RCU
      3052 ±  5%      +5.5%       3219 ± 11%  softirqs.CPU43.SCHED
      0.00          -100.0%       0.00        softirqs.CPU43.TASKLET
    244.80 ± 36%     +94.3%     475.67 ± 71%  softirqs.CPU43.TIMER
     12.40 ±200%     -46.2%       6.67 ±141%  softirqs.CPU44.BLOCK
      1874 ± 16%     +23.8%       2319 ±  9%  softirqs.CPU44.RCU
      2901 ±  5%      -3.1%       2811 ±  3%  softirqs.CPU44.SCHED
    267.20 ± 52%     +84.8%     493.67 ± 94%  softirqs.CPU44.TIMER
     38.60 ±196%     -56.0%      17.00 ± 71%  softirqs.CPU45.BLOCK
      1791 ±  3%     +28.8%       2307 ±  3%  softirqs.CPU45.RCU
      3169 ±  4%     -11.0%       2820 ±  3%  softirqs.CPU45.SCHED
      0.00          -100.0%       0.00        softirqs.CPU45.TASKLET
    189.80 ± 57%     -64.2%      68.00 ± 14%  softirqs.CPU45.TIMER
      6.40 ±200%    +124.0%      14.33 ±141%  softirqs.CPU46.BLOCK
      0.20 ±200%    -100.0%       0.00        softirqs.CPU46.NET_RX
      1904 ±  9%     +23.7%       2355        softirqs.CPU46.RCU
      3032 ±  5%      -6.1%       2846 ±  8%  softirqs.CPU46.SCHED
      0.20 ±200%    -100.0%       0.00        softirqs.CPU46.TASKLET
    167.60 ± 35%     -10.9%     149.33 ± 10%  softirqs.CPU46.TIMER
     14.00 ± 94%     +40.5%      19.67 ± 60%  softirqs.CPU47.BLOCK
      0.20 ±200%    -100.0%       0.00        softirqs.CPU47.NET_RX
      2091 ± 16%     +11.2%       2325 ±  5%  softirqs.CPU47.RCU
      2418 ± 11%     +16.3%       2812 ± 11%  softirqs.CPU47.SCHED
    223.60 ± 20%    +441.4%       1210 ± 53%  softirqs.CPU47.TIMER
    200.00 ± 27%     -36.8%     126.33 ± 84%  softirqs.CPU48.BLOCK
      2.00            +0.0%       2.00        softirqs.CPU48.NET_RX
      0.40 ±122%    -100.0%       0.00        softirqs.CPU48.NET_TX
      2589 ±  5%      -2.5%       2525        softirqs.CPU48.RCU
      2756 ± 13%      -0.6%       2739 ± 12%  softirqs.CPU48.SCHED
      0.20 ±200%    +233.3%       0.67 ±141%  softirqs.CPU48.TASKLET
    174.60 ± 43%     -18.1%     143.00 ± 25%  softirqs.CPU48.TIMER
      0.00       +3.3e+101%       0.33 ±141%  softirqs.CPU49.BLOCK
      2.00            +0.0%       2.00        softirqs.CPU49.NET_RX
      0.00       +3.3e+101%       0.33 ±141%  softirqs.CPU49.NET_TX
      2523 ± 13%      +5.7%       2666        softirqs.CPU49.RCU
      2975 ± 13%     -10.7%       2656 ±  3%  softirqs.CPU49.SCHED
      0.00       +6.7e+102%       6.67 ±141%  softirqs.CPU49.TASKLET
    222.00 ± 42%     -51.1%     108.67 ± 25%  softirqs.CPU49.TIMER
      0.00         +4e+102%       4.00 ±141%  softirqs.CPU5.BLOCK
      0.20 ±200%    -100.0%       0.00        softirqs.CPU5.NET_RX
      2125 ±  7%     +39.4%       2962        softirqs.CPU5.RCU
      3090 ±  4%      -6.0%       2904 ±  4%  softirqs.CPU5.SCHED
    192.20 ± 48%     -48.8%      98.33 ± 47%  softirqs.CPU5.TIMER
      5.20 ±123%     -23.1%       4.00 ±141%  softirqs.CPU50.BLOCK
      2.00            +0.0%       2.00        softirqs.CPU50.NET_RX
      2040 ± 15%     +64.5%       3355 ± 17%  softirqs.CPU50.RCU
      3347 ± 18%      -6.4%       3132 ±  9%  softirqs.CPU50.SCHED
    655.80 ± 81%     -76.0%     157.67 ± 58%  softirqs.CPU50.TIMER
      2.00            +0.0%       2.00        softirqs.CPU51.NET_RX
      0.20 ±200%    -100.0%       0.00        softirqs.CPU51.NET_TX
      2047 ±  6%     +38.9%       2842 ±  6%  softirqs.CPU51.RCU
      3110 ±  7%      -4.0%       2987 ±  5%  softirqs.CPU51.SCHED
      0.20 ±200%    -100.0%       0.00        softirqs.CPU51.TASKLET
    211.20 ± 40%     -12.2%     185.33 ± 83%  softirqs.CPU51.TIMER
      2.60 ±200%    -100.0%       0.00        softirqs.CPU52.BLOCK
      2.00            +0.0%       2.00        softirqs.CPU52.NET_RX
      1919 ± 10%     +43.9%       2762 ± 15%  softirqs.CPU52.RCU
      2986 ±  8%      +9.9%       3282 ± 22%  softirqs.CPU52.SCHED
    354.40 ± 68%     +31.5%     466.00 ±114%  softirqs.CPU52.TIMER
      0.00       +4.7e+102%       4.67 ±141%  softirqs.CPU53.BLOCK
      2.00            +0.0%       2.00        softirqs.CPU53.NET_RX
      2139 ± 20%     +18.9%       2544        softirqs.CPU53.RCU
      3264 ± 12%      -9.9%       2942 ± 11%  softirqs.CPU53.SCHED
    350.80 ±123%     -72.0%      98.33 ± 46%  softirqs.CPU53.TIMER
      2.20 ± 18%      -9.1%       2.00        softirqs.CPU54.NET_RX
      0.00          -100.0%       0.00        softirqs.CPU54.NET_TX
      1920 ± 13%     +44.9%       2783 ± 13%  softirqs.CPU54.RCU
      2970 ±  6%      -4.8%       2828 ±  4%  softirqs.CPU54.SCHED
    145.80 ± 25%     -16.8%     121.33 ± 35%  softirqs.CPU54.TIMER
      2.40 ±200%    -100.0%       0.00        softirqs.CPU55.BLOCK
      2.20 ± 18%      -9.1%       2.00        softirqs.CPU55.NET_RX
      1727 ±  5%     +55.4%       2683 ± 11%  softirqs.CPU55.RCU
      2990 ±  8%      -1.4%       2948 ±  9%  softirqs.CPU55.SCHED
      3.00 ±200%     -88.9%       0.33 ±141%  softirqs.CPU55.TASKLET
    182.60 ± 44%     -25.3%     136.33 ± 19%  softirqs.CPU55.TIMER
      4.00 ±200%    -100.0%       0.00        softirqs.CPU56.BLOCK
      0.60 ±200%    -100.0%       0.00        softirqs.CPU56.NET_TX
      1653 ±  2%     +51.7%       2509 ±  3%  softirqs.CPU56.RCU
      3105 ± 10%      -4.7%       2961 ± 11%  softirqs.CPU56.SCHED
      1.20 ±200%    -100.0%       0.00        softirqs.CPU56.TASKLET
    406.00 ±135%     -67.2%     133.00 ± 65%  softirqs.CPU56.TIMER
      4.00 ±126%     +50.0%       6.00 ±141%  softirqs.CPU57.BLOCK
      2.00            +0.0%       2.00        softirqs.CPU57.NET_RX
      0.20 ±200%    -100.0%       0.00        softirqs.CPU57.NET_TX
      1907 ±  9%     +27.4%       2429        softirqs.CPU57.RCU
      3110 ± 14%      -4.8%       2962 ±  9%  softirqs.CPU57.SCHED
    195.80 ± 27%    +315.4%     813.33 ± 66%  softirqs.CPU57.TIMER
      4.80 ±200%     -44.4%       2.67 ± 93%  softirqs.CPU58.BLOCK
      2.00            +0.0%       2.00        softirqs.CPU58.NET_RX
      2147 ± 25%     +15.5%       2479 ±  6%  softirqs.CPU58.RCU
      3032 ±  7%      -0.1%       3029 ±  8%  softirqs.CPU58.SCHED
      0.00       +3.3e+101%       0.33 ±141%  softirqs.CPU58.TASKLET
    168.80 ± 46%      +9.6%     185.00 ± 78%  softirqs.CPU58.TIMER
      3.20 ±122%     -68.8%       1.00 ±141%  softirqs.CPU59.BLOCK
      2.00            +0.0%       2.00        softirqs.CPU59.NET_RX
      1792 ± 13%     +36.2%       2441 ±  2%  softirqs.CPU59.RCU
      3260 ± 12%      -6.0%       3066 ±  5%  softirqs.CPU59.SCHED
    174.40 ± 40%     -58.9%      71.67 ±  5%  softirqs.CPU59.TIMER
      0.00          -100.0%       0.00        softirqs.CPU6.BLOCK
      0.00          -100.0%       0.00        softirqs.CPU6.NET_RX
      2032 ±  5%     +61.6%       3285 ± 11%  softirqs.CPU6.RCU
      3021 ± 15%      -8.7%       2757 ±  6%  softirqs.CPU6.SCHED
    200.20 ± 42%      +1.2%     202.67 ± 53%  softirqs.CPU6.TIMER
     10.80 ±115%     -25.9%       8.00 ±106%  softirqs.CPU60.BLOCK
      2.00            +0.0%       2.00        softirqs.CPU60.NET_RX
      1699 ±  4%     +42.9%       2428 ±  5%  softirqs.CPU60.RCU
      3005 ±  8%      -5.6%       2835 ± 10%  softirqs.CPU60.SCHED
    244.80 ± 57%      +7.7%     263.67 ± 61%  softirqs.CPU60.TIMER
      2.80 ±200%      -4.8%       2.67 ±141%  softirqs.CPU61.BLOCK
      2.20 ± 18%      -9.1%       2.00        softirqs.CPU61.NET_RX
      1950 ± 27%     +20.5%       2351 ±  4%  softirqs.CPU61.RCU
      2924 ± 12%      -5.4%       2765 ±  9%  softirqs.CPU61.SCHED
    137.00 ± 44%     +36.3%     186.67 ± 57%  softirqs.CPU61.TIMER
      8.40 ±122%     -44.4%       4.67 ±141%  softirqs.CPU62.BLOCK
      2.00            +0.0%       2.00        softirqs.CPU62.NET_RX
      1741 ± 10%     +45.0%       2525 ± 11%  softirqs.CPU62.RCU
      3140 ±  9%     -10.6%       2808 ±  7%  softirqs.CPU62.SCHED
    223.60 ± 45%     -73.2%      60.00 ± 10%  softirqs.CPU62.TIMER
      2.40 ±200%     +11.1%       2.67 ± 93%  softirqs.CPU63.BLOCK
      2.00            +0.0%       2.00        softirqs.CPU63.NET_RX
      1675 ±  8%     +36.1%       2279 ±  9%  softirqs.CPU63.RCU
      2856 ± 10%      +3.7%       2963 ±  6%  softirqs.CPU63.SCHED
    210.40 ± 16%      +0.6%     211.67 ± 36%  softirqs.CPU63.TIMER
      1.20 ±200%     -44.4%       0.67 ±141%  softirqs.CPU64.BLOCK
      2.20 ± 18%      -9.1%       2.00        softirqs.CPU64.NET_RX
      1805 ±  4%     +31.3%       2371 ±  2%  softirqs.CPU64.RCU
      3093 ± 11%     -10.2%       2776 ±  9%  softirqs.CPU64.SCHED
    215.00 ± 32%     +49.6%     321.67 ± 96%  softirqs.CPU64.TIMER
      0.00          -100.0%       0.00        softirqs.CPU65.BLOCK
      0.20 ±200%    -100.0%       0.00        softirqs.CPU65.NET_RX
     11.40 ±  4%      -3.5%      11.00        softirqs.CPU65.NET_TX
      1753 ±  3%     +47.7%       2590 ±  5%  softirqs.CPU65.RCU
      3098 ±  3%      -9.8%       2793 ±  9%  softirqs.CPU65.SCHED
      0.00          -100.0%       0.00        softirqs.CPU65.TASKLET
    183.60 ± 25%     -30.6%     127.33 ± 55%  softirqs.CPU65.TIMER
      2.40 ±200%     +52.8%       3.67 ±141%  softirqs.CPU66.BLOCK
    626.40 ±155%     -88.6%      71.67 ±  7%  softirqs.CPU66.NET_RX
      2.20 ± 34%      +6.1%       2.33 ± 53%  softirqs.CPU66.NET_TX
      1796 ± 11%     +26.2%       2267        softirqs.CPU66.RCU
      3364 ± 11%     -12.6%       2940 ±  5%  softirqs.CPU66.SCHED
    373.20 ± 70%     +24.5%     464.67 ±122%  softirqs.CPU66.TIMER
    888.80 ±176%     -91.4%      76.67 ± 43%  softirqs.CPU67.NET_RX
      3.20 ± 75%     -37.5%       2.00 ± 40%  softirqs.CPU67.NET_TX
      1714 ±  5%     +40.1%       2403 ±  3%  softirqs.CPU67.RCU
      3384 ± 15%     -13.5%       2929 ±  8%  softirqs.CPU67.SCHED
      0.60 ±133%     -44.4%       0.33 ±141%  softirqs.CPU67.TASKLET
    250.80 ± 31%     -60.7%      98.67 ± 22%  softirqs.CPU67.TIMER
      0.40 ±122%    -100.0%       0.00        softirqs.CPU68.BLOCK
      1869 ±189%     -92.4%     142.67 ± 94%  softirqs.CPU68.NET_RX
      4.00 ± 57%     -75.0%       1.00 ± 81%  softirqs.CPU68.NET_TX
      1894 ± 17%     +33.3%       2525 ±  5%  softirqs.CPU68.RCU
      3332 ± 18%     -12.4%       2919 ±  6%  softirqs.CPU68.SCHED
      0.40 ±122%    -100.0%       0.00        softirqs.CPU68.TASKLET
    301.20 ± 33%     -57.6%     127.67 ± 26%  softirqs.CPU68.TIMER
    253.80 ±119%     -46.3%     136.33 ± 39%  softirqs.CPU69.NET_RX
      1.40 ± 34%     +66.7%       2.33 ± 72%  softirqs.CPU69.NET_TX
      1771 ±  8%     +42.2%       2519 ±  3%  softirqs.CPU69.RCU
      2996 ±  4%      -4.4%       2865 ± 13%  softirqs.CPU69.SCHED
      0.20 ±200%     +66.7%       0.33 ±141%  softirqs.CPU69.TASKLET
    244.40 ± 85%     -65.5%      84.33 ± 25%  softirqs.CPU69.TIMER
      0.00          -100.0%       0.00        softirqs.CPU7.NET_RX
      0.20 ±200%    -100.0%       0.00        softirqs.CPU7.NET_TX
      2008 ±  5%     +41.3%       2837        softirqs.CPU7.RCU
      3187 ± 11%      -8.5%       2915 ±  7%  softirqs.CPU7.SCHED
    158.00 ± 34%     -26.6%     116.00 ± 37%  softirqs.CPU7.TIMER
      9.20 ±127%     -96.4%       0.33 ±141%  softirqs.CPU70.BLOCK
    288.00 ±153%     +22.5%     352.67 ±108%  softirqs.CPU70.NET_RX
      2.40 ± 72%      -2.8%       2.33 ± 20%  softirqs.CPU70.NET_TX
      1653 ±  5%     +49.9%       2478 ±  7%  softirqs.CPU70.RCU
      3002 ±  8%      -3.7%       2890 ±  6%  softirqs.CPU70.SCHED
    165.20 ± 41%     +79.6%     296.67 ± 66%  softirqs.CPU70.TIMER
      4.00 ±200%      +0.0%       4.00 ±141%  softirqs.CPU71.BLOCK
    220.40 ±104%    +338.1%     965.67 ± 98%  softirqs.CPU71.NET_RX
      1.80 ± 22%     -25.9%       1.33 ± 35%  softirqs.CPU71.NET_TX
      1855 ±  7%     +38.4%       2567 ±  6%  softirqs.CPU71.RCU
      3131 ±  8%      -4.9%       2978 ± 17%  softirqs.CPU71.SCHED
      0.20 ±200%     +66.7%       0.33 ±141%  softirqs.CPU71.TASKLET
    230.80 ± 60%     -34.9%     150.33 ± 40%  softirqs.CPU71.TIMER
      0.40 ±200%   +2900.0%      12.00 ±118%  softirqs.CPU72.BLOCK
      2357 ±  2%     +17.0%       2759 ±  5%  softirqs.CPU72.RCU
      2871 ±  4%      -7.3%       2662 ±  4%  softirqs.CPU72.SCHED
      0.20 ±200%    -100.0%       0.00        softirqs.CPU72.TASKLET
    224.40 ± 40%     -65.2%      78.00 ± 16%  softirqs.CPU72.TIMER
     33.00 ± 92%    -100.0%       0.00        softirqs.CPU73.BLOCK
      0.20 ±200%    -100.0%       0.00        softirqs.CPU73.NET_RX
      2368 ± 11%      +7.6%       2549 ±  5%  softirqs.CPU73.RCU
      3173 ± 15%     -25.7%       2357 ± 12%  softirqs.CPU73.SCHED
    573.40 ± 90%     -41.9%     333.00 ±105%  softirqs.CPU73.TIMER
     13.20 ±178%    +124.7%      29.67 ±141%  softirqs.CPU74.BLOCK
      0.20 ±200%     +66.7%       0.33 ±141%  softirqs.CPU74.NET_RX
      1894 ±  9%     +28.9%       2441 ±  6%  softirqs.CPU74.RCU
      3186 ±  7%     -12.2%       2796 ±  9%  softirqs.CPU74.SCHED
      0.00          -100.0%       0.00        softirqs.CPU74.TASKLET
    476.80 ± 36%     -73.4%     127.00 ± 71%  softirqs.CPU74.TIMER
      0.80 ±145%    -100.0%       0.00        softirqs.CPU75.BLOCK
      0.00       +3.3e+101%       0.33 ±141%  softirqs.CPU75.NET_RX
      1743 ±  8%     +32.8%       2315 ±  6%  softirqs.CPU75.RCU
      3105 ±  8%     -12.9%       2704 ± 10%  softirqs.CPU75.SCHED
    235.80 ± 82%     -49.4%     119.33 ± 34%  softirqs.CPU75.TIMER
      0.20 ±200%  +11733.3%      23.67 ±135%  softirqs.CPU76.BLOCK
      0.00          -100.0%       0.00        softirqs.CPU76.NET_TX
      1642 ±  7%     +38.9%       2281        softirqs.CPU76.RCU
      3063 ±  6%      -0.9%       3037 ±  6%  softirqs.CPU76.SCHED
      0.20 ±200%    -100.0%       0.00        softirqs.CPU76.TASKLET
    268.00 ± 41%     -58.2%     112.00 ± 64%  softirqs.CPU76.TIMER
      5.80 ±200%    +256.3%      20.67 ±141%  softirqs.CPU77.BLOCK
      0.00       +1.7e+102%       1.67 ±141%  softirqs.CPU77.NET_TX
      1683 ± 14%     +43.9%       2423 ± 13%  softirqs.CPU77.RCU
      3018 ±  5%      +0.7%       3038 ± 16%  softirqs.CPU77.SCHED
    262.00 ± 21%    +159.7%     680.33 ± 83%  softirqs.CPU77.TIMER
      8.20 ±135%     +13.8%       9.33 ±126%  softirqs.CPU78.BLOCK
      1682 ±  3%     +38.6%       2331 ±  5%  softirqs.CPU78.RCU
      3179 ±  6%     -12.7%       2774 ±  4%  softirqs.CPU78.SCHED
    199.20 ± 18%      -7.1%     185.00 ± 78%  softirqs.CPU78.TIMER
      0.00       +6.7e+101%       0.67 ±141%  softirqs.CPU79.NET_RX
      1916 ± 13%     +76.9%       3390 ± 49%  softirqs.CPU79.RCU
      3214 ±  5%     -12.1%       2826 ±  6%  softirqs.CPU79.SCHED
    412.20 ± 61%     +15.2%     475.00 ± 90%  softirqs.CPU79.TIMER
      2.80 ±200%    -100.0%       0.00        softirqs.CPU8.BLOCK
      0.20 ±200%    -100.0%       0.00        softirqs.CPU8.NET_TX
      2195 ± 17%     +28.2%       2814 ±  2%  softirqs.CPU8.RCU
      2970 ± 12%      -1.5%       2926 ±  8%  softirqs.CPU8.SCHED
    231.00 ± 79%     -54.3%     105.67 ± 58%  softirqs.CPU8.TIMER
      1.80 ±101%     -63.0%       0.67 ±141%  softirqs.CPU80.BLOCK
      1758 ±  8%     +38.3%       2432 ±  8%  softirqs.CPU80.RCU
      2985 ±  5%      +0.9%       3013 ±  7%  softirqs.CPU80.SCHED
      0.20 ±200%     +66.7%       0.33 ±141%  softirqs.CPU80.TASKLET
    141.00 ± 45%     -15.4%     119.33 ± 35%  softirqs.CPU80.TIMER
     15.00 ±186%    -100.0%       0.00        softirqs.CPU81.BLOCK
      1613 ± 11%     +27.7%       2061 ±  4%  softirqs.CPU81.RCU
      3086 ± 10%      -8.8%       2814 ±  2%  softirqs.CPU81.SCHED
      0.40 ±200%    -100.0%       0.00        softirqs.CPU81.TASKLET
    183.80 ± 19%     +41.1%     259.33 ± 46%  softirqs.CPU81.TIMER
     27.60 ±131%    -100.0%       0.00        softirqs.CPU82.BLOCK
      0.20 ±200%    -100.0%       0.00        softirqs.CPU82.NET_RX
      1709 ± 11%     +24.7%       2131 ±  3%  softirqs.CPU82.RCU
      3088 ± 17%      -9.0%       2811 ±  4%  softirqs.CPU82.SCHED
      0.00          -100.0%       0.00        softirqs.CPU82.TASKLET
    280.00 ± 54%     -35.2%     181.33 ± 94%  softirqs.CPU82.TIMER
     23.60 ±200%    -100.0%       0.00        softirqs.CPU83.BLOCK
      0.00       +3.3e+101%       0.33 ±141%  softirqs.CPU83.NET_RX
      1630 ±  7%     +30.6%       2129 ±  2%  softirqs.CPU83.RCU
      3095 ± 12%      -1.7%       3042 ±  2%  softirqs.CPU83.SCHED
      0.20 ±200%    -100.0%       0.00        softirqs.CPU83.TASKLET
    271.60 ± 17%     -52.7%     128.33 ± 39%  softirqs.CPU83.TIMER
      7.20 ±173%     +29.6%       9.33 ±141%  softirqs.CPU84.BLOCK
      1656 ±  6%     +34.5%       2228        softirqs.CPU84.RCU
      3178 ± 11%      -2.0%       3114 ±  3%  softirqs.CPU84.SCHED
    338.80 ± 58%     -60.1%     135.33 ± 51%  softirqs.CPU84.TIMER
      6.80 ±185%     +61.8%      11.00 ±141%  softirqs.CPU85.BLOCK
      1670 ±  6%     +24.5%       2080 ±  2%  softirqs.CPU85.RCU
      3047 ±  7%      -2.4%       2976        softirqs.CPU85.SCHED
    233.00 ± 48%     -73.1%      62.67 ± 10%  softirqs.CPU85.TIMER
      1544 ±  9%     +30.1%       2009        softirqs.CPU86.RCU
      2992 ±  9%      -8.6%       2735 ±  2%  softirqs.CPU86.SCHED
    175.80 ± 20%    +155.2%     448.67 ± 71%  softirqs.CPU86.TIMER
      0.40 ±200%    -100.0%       0.00        softirqs.CPU87.BLOCK
      0.20 ±200%    -100.0%       0.00        softirqs.CPU87.NET_RX
      1542 ±  8%     +57.1%       2423 ±  6%  softirqs.CPU87.RCU
      2941 ±  7%      -5.5%       2780 ± 10%  softirqs.CPU87.SCHED
    111.80 ± 28%     +36.3%     152.33 ± 44%  softirqs.CPU87.TIMER
      0.20 ±200%    -100.0%       0.00        softirqs.CPU88.NET_RX
      0.00          -100.0%       0.00        softirqs.CPU88.NET_TX
      1601 ± 12%     +38.6%       2220 ±  6%  softirqs.CPU88.RCU
      3040 ±  5%      -7.1%       2825 ±  7%  softirqs.CPU88.SCHED
    200.20 ± 28%     -52.0%      96.00 ± 44%  softirqs.CPU88.TIMER
      0.00       +6.7e+101%       0.67 ±141%  softirqs.CPU89.BLOCK
      1707 ± 17%     +35.8%       2317 ± 18%  softirqs.CPU89.RCU
      3045 ±  6%      -6.8%       2837 ±  2%  softirqs.CPU89.SCHED
      0.20 ±200%    -100.0%       0.00        softirqs.CPU89.TASKLET
    297.00 ± 88%     -53.9%     137.00 ± 81%  softirqs.CPU89.TIMER
      2.80 ±200%     -76.2%       0.67 ±141%  softirqs.CPU9.BLOCK
      2193 ± 11%     +26.7%       2778 ±  3%  softirqs.CPU9.RCU
      3206 ± 12%     -15.5%       2708 ±  8%  softirqs.CPU9.SCHED
    198.20 ± 54%     -49.0%     101.00 ± 31%  softirqs.CPU9.TIMER
      0.20 ±200%  +11066.7%      22.33 ±125%  softirqs.CPU90.BLOCK
      0.00       +3.3e+101%       0.33 ±141%  softirqs.CPU90.NET_RX
      0.00          -100.0%       0.00        softirqs.CPU90.NET_TX
      1480 ±  4%     +41.7%       2097 ±  3%  softirqs.CPU90.RCU
      2937 ±  6%      +6.5%       3128 ±  6%  softirqs.CPU90.SCHED
    262.20 ± 76%     -15.2%     222.33 ± 68%  softirqs.CPU90.TIMER
      0.00       +8.7e+102%       8.67 ±141%  softirqs.CPU91.BLOCK
      0.00          -100.0%       0.00        softirqs.CPU91.NET_RX
      1690 ± 10%     +21.8%       2058        softirqs.CPU91.RCU
      3135 ±  5%      -7.1%       2912 ±  5%  softirqs.CPU91.SCHED
      0.00       +1.7e+102%       1.67 ±141%  softirqs.CPU91.TASKLET
    187.40 ± 40%     +94.2%     364.00 ±104%  softirqs.CPU91.TIMER
      0.00          -100.0%       0.00        softirqs.CPU92.NET_TX
      1622 ±  7%     +27.6%       2069 ±  6%  softirqs.CPU92.RCU
      3153 ±  4%      -9.8%       2845 ±  4%  softirqs.CPU92.SCHED
      0.00       +6.3e+102%       6.33 ±141%  softirqs.CPU92.TASKLET
    221.60 ± 48%     +42.6%     316.00 ± 99%  softirqs.CPU92.TIMER
      0.80 ±122%    -100.0%       0.00        softirqs.CPU93.BLOCK
      1557 ±  6%     +32.2%       2058 ±  2%  softirqs.CPU93.RCU
      3096           -12.8%       2700 ±  5%  softirqs.CPU93.SCHED
      0.00          -100.0%       0.00        softirqs.CPU93.TASKLET
    162.40 ± 22%     -63.3%      59.67 ± 14%  softirqs.CPU93.TIMER
      8.40 ±188%     -96.0%       0.33 ±141%  softirqs.CPU94.BLOCK
      1528 ±  8%     +32.8%       2029 ±  3%  softirqs.CPU94.RCU
      3050 ±  8%      -6.5%       2851 ±  7%  softirqs.CPU94.SCHED
    242.80 ± 39%     -37.0%     153.00 ± 36%  softirqs.CPU94.TIMER
      0.40 ±200%   +5066.7%      20.67 ±141%  softirqs.CPU95.BLOCK
      2161 ± 24%     +25.3%       2707 ±  8%  softirqs.CPU95.RCU
      3117 ± 13%      -9.3%       2825 ±  2%  softirqs.CPU95.SCHED
      0.00          -100.0%       0.00        softirqs.CPU95.TASKLET
    229.40 ± 28%      -5.0%     218.00 ± 70%  softirqs.CPU95.TIMER
      2.00            +0.0%       2.00        softirqs.HI
      4358 ± 73%     -27.2%       3170 ± 66%  softirqs.NET_RX
     36.60 ±  6%      -4.4%      35.00 ±  4%  softirqs.NET_TX
    191572 ±  4%     +31.8%     252582        softirqs.RCU
    296266            -5.5%     280002        softirqs.SCHED
    235.60 ±  7%      -5.3%     223.00        softirqs.TASKLET
     25759            -4.7%      24556        softirqs.TIMER
      0.00          -100.0%       0.00        interrupts.0:IO-APIC.2-edge.timer
      0.00          -100.0%       0.00        interrupts.31:PCI-MSI.48791552-edge.PCIe.PME,pciehp
      0.00          -100.0%       0.00        interrupts.32:PCI-MSI.48807936-edge.PCIe.PME,pciehp
      0.00          -100.0%       0.00        interrupts.342:PCI-MSI.327680-edge.xhci_hcd
      0.00          -100.0%       0.00        interrupts.344:PCI-MSI.65536-edge.ioat-msix
      0.00       +1.8e+103%      17.67 ±141%  interrupts.345:PCI-MSI.288768-edge.ahci[0000:00:11.5]
      0.00          -100.0%       0.00        interrupts.345:PCI-MSI.68681728-edge.nvme0q0
      0.00          -100.0%       0.00        interrupts.345:PCI-MSI.69206016-edge.nvme1q0
      0.00       +2.3e+103%      23.33 ±141%  interrupts.346:PCI-MSI.288768-edge.ahci[0000:00:11.5]
      0.00          -100.0%       0.00        interrupts.346:PCI-MSI.67584-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.346:PCI-MSI.68681728-edge.nvme0q0
      0.00          -100.0%       0.00        interrupts.346:PCI-MSI.69206016-edge.nvme1q0
     35.00 ± 81%    -100.0%       0.00        interrupts.347:PCI-MSI.288768-edge.ahci[0000:00:11.5]
      0.00          -100.0%       0.00        interrupts.347:PCI-MSI.67584-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.347:PCI-MSI.69206016-edge.nvme1q0
      0.00          -100.0%       0.00        interrupts.347:PCI-MSI.69632-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.348:PCI-MSI.67584-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.348:PCI-MSI.68681728-edge.nvme0q0
      0.00          -100.0%       0.00        interrupts.348:PCI-MSI.69632-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.348:PCI-MSI.71680-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.349:PCI-MSI.288768-edge.ahci[0000:00:11.5]
      0.00          -100.0%       0.00        interrupts.349:PCI-MSI.67584-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.349:PCI-MSI.68681728-edge.nvme0q0
      0.00          -100.0%       0.00        interrupts.349:PCI-MSI.69206016-edge.nvme1q0
      0.00          -100.0%       0.00        interrupts.349:PCI-MSI.69632-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.349:PCI-MSI.73728-edge.ioat-msix
     10.80 ±200%     +63.6%      17.67 ±141%  interrupts.350:PCI-MSI.288768-edge.ahci[0000:00:11.5]
      0.00          -100.0%       0.00        interrupts.350:PCI-MSI.69206016-edge.nvme1q0
      0.00          -100.0%       0.00        interrupts.350:PCI-MSI.69632-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.350:PCI-MSI.75776-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.351:PCI-MSI.68681728-edge.nvme0q0
      0.00          -100.0%       0.00        interrupts.351:PCI-MSI.69206016-edge.nvme1q0
      0.00          -100.0%       0.00        interrupts.351:PCI-MSI.71680-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.352:PCI-MSI.73728-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.352:PCI-MSI.77824-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.353:PCI-MSI.69206016-edge.nvme1q0
      0.00          -100.0%       0.00        interrupts.353:PCI-MSI.75776-edge.ioat-msix
     12.20 ±200%    -100.0%       0.00        interrupts.354:PCI-MSI.288768-edge.ahci[0000:00:11.5]
      0.00          -100.0%       0.00        interrupts.354:PCI-MSI.77824-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.355:PCI-MSI.376832-edge.ahci[0000:00:17.0]
      0.00          -100.0%       0.00        interrupts.355:PCI-MSI.79872-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.356:PCI-MSI.376832-edge.ahci[0000:00:17.0]
      0.00          -100.0%       0.00        interrupts.356:PCI-MSI.79872-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.357:PCI-MSI.67174400-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.358:PCI-MSI.376832-edge.ahci[0000:00:17.0]
      0.00          -100.0%       0.00        interrupts.358:PCI-MSI.67174400-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.359:PCI-MSI.67176448-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.360:PCI-MSI.376832-edge.ahci[0000:00:17.0]
      0.00          -100.0%       0.00        interrupts.360:PCI-MSI.67176448-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.360:PCI-MSI.67178496-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.361:PCI-MSI.67178496-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.361:PCI-MSI.67180544-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.362:PCI-MSI.67180544-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.362:PCI-MSI.67182592-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.363:PCI-MSI.67182592-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.363:PCI-MSI.67184640-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.364:PCI-MSI.376832-edge.ahci[0000:00:17.0]
      0.00          -100.0%       0.00        interrupts.364:PCI-MSI.67184640-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.364:PCI-MSI.67186688-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.365:PCI-MSI.67186688-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.365:PCI-MSI.67188736-edge.ioat-msix
      2.00 ±200%    -100.0%       0.00        interrupts.366:PCI-MSI.376832-edge.ahci[0000:00:17.0]
      0.00          -100.0%       0.00        interrupts.366:PCI-MSI.67188736-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.367:PCI-MSI.68681729-edge.nvme0q1
      0.00          -100.0%       0.00        interrupts.367:PCI-MSI.69206017-edge.nvme1q1
      0.00          -100.0%       0.00        interrupts.371:PCI-MSI.69206021-edge.nvme1q5
      0.00          -100.0%       0.00        interrupts.372:PCI-MSI.69206022-edge.nvme1q6
      0.00          -100.0%       0.00        interrupts.373:PCI-MSI.68681735-edge.nvme0q7
      0.00          -100.0%       0.00        interrupts.374:PCI-MSI.69206024-edge.nvme1q8
      0.00          -100.0%       0.00        interrupts.375:PCI-MSI.69206025-edge.nvme1q9
      0.00          -100.0%       0.00        interrupts.376:PCI-MSI.68681733-edge.nvme0q5
      0.00          -100.0%       0.00        interrupts.376:PCI-MSI.68681738-edge.nvme0q10
      0.00          -100.0%       0.00        interrupts.378:PCI-MSI.68681740-edge.nvme0q12
      0.00          -100.0%       0.00        interrupts.378:PCI-MSI.69206028-edge.nvme1q12
      0.00          -100.0%       0.00        interrupts.379:PCI-MSI.69206029-edge.nvme1q13
      0.00          -100.0%       0.00        interrupts.381:PCI-MSI.69206031-edge.nvme1q15
      0.00          -100.0%       0.00        interrupts.384:PCI-MSI.68681746-edge.nvme0q18
      0.00          -100.0%       0.00        interrupts.385:PCI-MSI.69206035-edge.nvme1q19
      0.00          -100.0%       0.00        interrupts.387:PCI-MSI.69206027-edge.nvme1q11
      0.00          -100.0%       0.00        interrupts.389:PCI-MSI.69206028-edge.nvme1q12
      0.00          -100.0%       0.00        interrupts.390:PCI-MSI.69206040-edge.nvme1q24
      0.00          -100.0%       0.00        interrupts.391:PCI-MSI.69206041-edge.nvme1q25
      0.00          -100.0%       0.00        interrupts.392:PCI-MSI.69206042-edge.nvme1q26
      0.00          -100.0%       0.00        interrupts.398:PCI-MSI.68681729-edge.nvme0q1
      0.00          -100.0%       0.00        interrupts.398:PCI-MSI.69206017-edge.nvme1q1
      0.00          -100.0%       0.00        interrupts.399:PCI-MSI.68681730-edge.nvme0q2
      0.00          -100.0%       0.00        interrupts.399:PCI-MSI.69206018-edge.nvme1q2
      0.00          -100.0%       0.00        interrupts.3:IO-APIC.3-edge
      0.00          -100.0%       0.00        interrupts.401:PCI-MSI.68681732-edge.nvme0q4
      0.00          -100.0%       0.00        interrupts.403:PCI-MSI.68681734-edge.nvme0q6
      0.00          -100.0%       0.00        interrupts.404:PCI-MSI.68681735-edge.nvme0q7
      0.00          -100.0%       0.00        interrupts.405:PCI-MSI.68681736-edge.nvme0q8
      0.00          -100.0%       0.00        interrupts.406:PCI-MSI.68681737-edge.nvme0q9
      0.00          -100.0%       0.00        interrupts.407:PCI-MSI.69206026-edge.nvme1q10
      0.00          -100.0%       0.00        interrupts.409:PCI-MSI.69206028-edge.nvme1q12
      0.00          -100.0%       0.00        interrupts.411:PCI-MSI.68681742-edge.nvme0q14
      0.00          -100.0%       0.00        interrupts.412:PCI-MSI.68681751-edge.nvme0q23
      0.00          -100.0%       0.00        interrupts.413:PCI-MSI.68681744-edge.nvme0q16
      0.00          -100.0%       0.00        interrupts.414:PCI-MSI.68681745-edge.nvme0q17
      0.00          -100.0%       0.00        interrupts.415:PCI-MSI.69206034-edge.nvme1q18
      0.00          -100.0%       0.00        interrupts.418:PCI-MSI.68681749-edge.nvme0q21
      0.00          -100.0%       0.00        interrupts.41:PCI-MSI.112721920-edge.PCIe.PME,pciehp
      0.00          -100.0%       0.00        interrupts.42:PCI-MSI.112738304-edge.PCIe.PME,pciehp
      0.00          -100.0%       0.00        interrupts.45:PCI-MSI.12582913-edge
      0.00          -100.0%       0.00        interrupts.46:PCI-MSI.12582914-edge
      0.00          -100.0%       0.00        interrupts.47:PCI-MSI.12582915-edge
      0.00          -100.0%       0.00        interrupts.48:PCI-MSI.12582916-edge
      0.00          -100.0%       0.00        interrupts.49:PCI-MSI.12582917-edge
      0.00          -100.0%       0.00        interrupts.4:IO-APIC.4-edge.ttyS0
      0.00          -100.0%       0.00        interrupts.50:PCI-MSI.12582918-edge
      0.00          -100.0%       0.00        interrupts.51:PCI-MSI.12582919-edge
      0.00          -100.0%       0.00        interrupts.52:PCI-MSI.12582920-edge
      0.00          -100.0%       0.00        interrupts.55:PCI-MSI.12584961-edge
      0.00          -100.0%       0.00        interrupts.56:PCI-MSI.12584962-edge
      0.00          -100.0%       0.00        interrupts.57:PCI-MSI.12584963-edge
      0.00          -100.0%       0.00        interrupts.58:PCI-MSI.12584964-edge
      0.00          -100.0%       0.00        interrupts.59:PCI-MSI.12584965-edge
      0.00          -100.0%       0.00        interrupts.60:PCI-MSI.12584966-edge
      0.00          -100.0%       0.00        interrupts.61:PCI-MSI.12584967-edge
      0.00          -100.0%       0.00        interrupts.62:PCI-MSI.12584968-edge
      0.00          -100.0%       0.00        interrupts.65:PCI-MSI.12587009-edge
      0.00          -100.0%       0.00        interrupts.66:PCI-MSI.12587010-edge
      0.00          -100.0%       0.00        interrupts.67:PCI-MSI.12587011-edge
      0.00          -100.0%       0.00        interrupts.68:PCI-MSI.12587012-edge
      0.00          -100.0%       0.00        interrupts.69:PCI-MSI.12587013-edge
      0.00          -100.0%       0.00        interrupts.70:PCI-MSI.12587014-edge
      0.00          -100.0%       0.00        interrupts.71:PCI-MSI.12587015-edge
      0.00          -100.0%       0.00        interrupts.72:PCI-MSI.12587016-edge
      0.00          -100.0%       0.00        interrupts.74:PCI-MSI.12589056-edge.eth3
      1189 ±161%     -91.2%     104.33 ± 10%  interrupts.75:PCI-MSI.12589057-edge.eth3-TxRx-0
      1628 ±187%     -94.1%      96.33 ± 24%  interrupts.76:PCI-MSI.12589058-edge.eth3-TxRx-1
      3389 ±194%     -93.4%     223.00 ± 95%  interrupts.77:PCI-MSI.12589059-edge.eth3-TxRx-2
    432.80 ±120%     -74.7%     109.67 ± 18%  interrupts.78:PCI-MSI.12589060-edge.eth3-TxRx-3
    502.60 ±167%     +21.2%     609.00 ±120%  interrupts.79:PCI-MSI.12589061-edge.eth3-TxRx-4
    241.60 ± 72%    +662.3%       1841 ±100%  interrupts.80:PCI-MSI.12589062-edge.eth3-TxRx-5
    125.20 ± 40%     +12.9%     141.33 ± 63%  interrupts.81:PCI-MSI.12589063-edge.eth3-TxRx-6
     67.00 ± 12%   +3288.6%       2270 ±112%  interrupts.82:PCI-MSI.12589064-edge.eth3-TxRx-7
      0.00          -100.0%       0.00        interrupts.8:IO-APIC.8-edge.rtc0
    117914 ± 41%     -49.0%      60118 ± 42%  interrupts.CAL:Function_call_interrupts
      0.00          -100.0%       0.00        interrupts.CPU0.0:IO-APIC.2-edge.timer
    125.20 ± 40%     +12.9%     141.33 ± 63%  interrupts.CPU0.81:PCI-MSI.12589063-edge.eth3-TxRx-6
      1743 ± 16%     -25.7%       1295 ± 16%  interrupts.CPU0.CAL:Function_call_interrupts
     45.20 ± 69%     -20.4%      36.00 ± 21%  interrupts.CPU0.IWI:IRQ_work_interrupts
    107476            -1.3%     106067        interrupts.CPU0.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU0.MCP:Machine_check_polls
     35344 ±  7%     +18.3%      41811        interrupts.CPU0.NMI:Non-maskable_interrupts
     35344 ±  7%     +18.3%      41811        interrupts.CPU0.PMI:Performance_monitoring_interrupts
     87.80 ± 35%     -10.0%      79.00 ± 19%  interrupts.CPU0.RES:Rescheduling_interrupts
      0.00          -100.0%       0.00        interrupts.CPU0.RTR:APIC_ICR_read_retries
     82.80 ±190%     -84.3%      13.00 ± 53%  interrupts.CPU0.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU1.413:PCI-MSI.68681744-edge.nvme0q16
     67.00 ± 12%   +3288.6%       2270 ±112%  interrupts.CPU1.82:PCI-MSI.12589064-edge.eth3-TxRx-7
      2076 ± 58%     -33.9%       1373 ± 40%  interrupts.CPU1.CAL:Function_call_interrupts
     45.00 ± 71%     -38.5%      27.67 ± 17%  interrupts.CPU1.IWI:IRQ_work_interrupts
    107466            -1.9%     105397        interrupts.CPU1.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU1.MCP:Machine_check_polls
     35451 ±  7%     +15.4%      40916        interrupts.CPU1.NMI:Non-maskable_interrupts
     35451 ±  7%     +15.4%      40916        interrupts.CPU1.PMI:Performance_monitoring_interrupts
     94.00 ± 32%     +54.3%     145.00 ± 37%  interrupts.CPU1.RES:Rescheduling_interrupts
      0.20 ±200%   +5900.0%      12.00 ±141%  interrupts.CPU1.TLB:TLB_shootdowns
      1229 ± 44%     -52.1%     589.00 ± 49%  interrupts.CPU10.CAL:Function_call_interrupts
     64.40 ± 40%     -61.7%      24.67 ± 30%  interrupts.CPU10.IWI:IRQ_work_interrupts
    104889            -0.5%     104324        interrupts.CPU10.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU10.MCP:Machine_check_polls
     36270 ±  6%      +9.8%      39825 ±  4%  interrupts.CPU10.NMI:Non-maskable_interrupts
     36270 ±  6%      +9.8%      39825 ±  4%  interrupts.CPU10.PMI:Performance_monitoring_interrupts
     70.80 ± 40%     -60.9%      27.67 ± 43%  interrupts.CPU10.RES:Rescheduling_interrupts
      0.00          -100.0%       0.00        interrupts.CPU10.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU11.342:PCI-MSI.327680-edge.xhci_hcd
      0.00          -100.0%       0.00        interrupts.CPU11.418:PCI-MSI.68681749-edge.nvme0q21
      1527 ± 64%     -63.6%     555.67 ± 47%  interrupts.CPU11.CAL:Function_call_interrupts
     39.00 ± 43%     -34.2%      25.67 ± 23%  interrupts.CPU11.IWI:IRQ_work_interrupts
    107139            -2.8%     104093        interrupts.CPU11.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU11.MCP:Machine_check_polls
     34802 ±  5%     +18.8%      41346        interrupts.CPU11.NMI:Non-maskable_interrupts
     34802 ±  5%     +18.8%      41346        interrupts.CPU11.PMI:Performance_monitoring_interrupts
     79.20 ± 83%     -40.7%      47.00 ± 49%  interrupts.CPU11.RES:Rescheduling_interrupts
      0.20 ±200%    -100.0%       0.00        interrupts.CPU11.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU12.8:IO-APIC.8-edge.rtc0
      1199 ± 43%     -54.4%     546.67 ± 47%  interrupts.CPU12.CAL:Function_call_interrupts
     38.20 ± 53%     -38.9%      23.33 ±  8%  interrupts.CPU12.IWI:IRQ_work_interrupts
    105614            -1.0%     104543        interrupts.CPU12.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU12.MCP:Machine_check_polls
     34818 ±  7%     +19.5%      41623        interrupts.CPU12.NMI:Non-maskable_interrupts
     34818 ±  7%     +19.5%      41623        interrupts.CPU12.PMI:Performance_monitoring_interrupts
    104.60 ± 45%     -73.6%      27.67 ± 25%  interrupts.CPU12.RES:Rescheduling_interrupts
      0.40 ±200%    +566.7%       2.67 ±141%  interrupts.CPU12.TLB:TLB_shootdowns
      1302 ± 22%     -53.2%     609.33 ± 50%  interrupts.CPU13.CAL:Function_call_interrupts
     51.20 ± 51%     -35.5%      33.00 ± 26%  interrupts.CPU13.IWI:IRQ_work_interrupts
    106875            -2.0%     104695        interrupts.CPU13.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU13.MCP:Machine_check_polls
     34490 ±  6%     +20.3%      41488        interrupts.CPU13.NMI:Non-maskable_interrupts
     34490 ±  6%     +20.3%      41488        interrupts.CPU13.PMI:Performance_monitoring_interrupts
     78.40 ± 88%     -49.4%      39.67 ± 45%  interrupts.CPU13.RES:Rescheduling_interrupts
      0.00         +6e+102%       6.00 ± 75%  interrupts.CPU13.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU14.4:IO-APIC.4-edge.ttyS0
      1167 ± 44%     -52.9%     550.00 ± 47%  interrupts.CPU14.CAL:Function_call_interrupts
     54.40 ± 52%     -42.4%      31.33 ± 33%  interrupts.CPU14.IWI:IRQ_work_interrupts
    106164            -2.2%     103815        interrupts.CPU14.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU14.MCP:Machine_check_polls
     36638 ±  4%     +12.8%      41325        interrupts.CPU14.NMI:Non-maskable_interrupts
     36638 ±  4%     +12.8%      41325        interrupts.CPU14.PMI:Performance_monitoring_interrupts
     83.20 ± 37%     -73.2%      22.33 ± 33%  interrupts.CPU14.RES:Rescheduling_interrupts
      0.60 ±200%    -100.0%       0.00        interrupts.CPU14.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU15.344:PCI-MSI.65536-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU15.45:PCI-MSI.12582913-edge
      1177 ± 39%     -46.9%     624.67 ± 39%  interrupts.CPU15.CAL:Function_call_interrupts
     36.40 ± 42%     -14.8%      31.00 ± 28%  interrupts.CPU15.IWI:IRQ_work_interrupts
    106322            -1.7%     104472        interrupts.CPU15.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU15.MCP:Machine_check_polls
     35907 ±  6%     +14.1%      40987        interrupts.CPU15.NMI:Non-maskable_interrupts
     35907 ±  6%     +14.1%      40987        interrupts.CPU15.PMI:Performance_monitoring_interrupts
    156.00 ±116%     -65.6%      53.67 ± 36%  interrupts.CPU15.RES:Rescheduling_interrupts
      0.00       +3.7e+102%       3.67 ±122%  interrupts.CPU15.TLB:TLB_shootdowns
      0.00       +1.8e+103%      17.67 ±141%  interrupts.CPU16.345:PCI-MSI.288768-edge.ahci[0000:00:11.5]
      0.00       +2.3e+103%      23.33 ±141%  interrupts.CPU16.346:PCI-MSI.288768-edge.ahci[0000:00:11.5]
      0.00          -100.0%       0.00        interrupts.CPU16.346:PCI-MSI.67584-edge.ioat-msix
     10.80 ±200%    -100.0%       0.00        interrupts.CPU16.347:PCI-MSI.288768-edge.ahci[0000:00:11.5]
      0.00          -100.0%       0.00        interrupts.CPU16.348:PCI-MSI.67584-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU16.46:PCI-MSI.12582914-edge
      1154 ± 43%     -50.1%     576.33 ± 48%  interrupts.CPU16.CAL:Function_call_interrupts
     52.60 ± 29%     -41.7%      30.67 ± 20%  interrupts.CPU16.IWI:IRQ_work_interrupts
    106527            -2.4%     103960        interrupts.CPU16.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU16.MCP:Machine_check_polls
     34764 ±  4%     +18.5%      41185        interrupts.CPU16.NMI:Non-maskable_interrupts
     34764 ±  4%     +18.5%      41185        interrupts.CPU16.PMI:Performance_monitoring_interrupts
     49.00 ± 57%     +13.6%      55.67 ± 76%  interrupts.CPU16.RES:Rescheduling_interrupts
      0.20 ±200%    -100.0%       0.00        interrupts.CPU16.TLB:TLB_shootdowns
     24.20 ±122%    -100.0%       0.00        interrupts.CPU17.347:PCI-MSI.288768-edge.ahci[0000:00:11.5]
      0.00          -100.0%       0.00        interrupts.CPU17.347:PCI-MSI.67584-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU17.347:PCI-MSI.69632-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU17.349:PCI-MSI.288768-edge.ahci[0000:00:11.5]
      0.00          -100.0%       0.00        interrupts.CPU17.349:PCI-MSI.67584-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU17.47:PCI-MSI.12582915-edge
      1182 ± 44%     -48.9%     604.67 ± 42%  interrupts.CPU17.CAL:Function_call_interrupts
     39.60 ± 51%     -31.0%      27.33 ± 32%  interrupts.CPU17.IWI:IRQ_work_interrupts
    106106            -2.2%     103754        interrupts.CPU17.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU17.MCP:Machine_check_polls
     36370 ±  6%     +13.2%      41168        interrupts.CPU17.NMI:Non-maskable_interrupts
     36370 ±  6%     +13.2%      41168        interrupts.CPU17.PMI:Performance_monitoring_interrupts
     58.60 ± 44%      +7.5%      63.00 ± 64%  interrupts.CPU17.RES:Rescheduling_interrupts
      0.00          -100.0%       0.00        interrupts.CPU17.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU18.348:PCI-MSI.69632-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU18.348:PCI-MSI.71680-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU18.349:PCI-MSI.288768-edge.ahci[0000:00:11.5]
      0.00          -100.0%       0.00        interrupts.CPU18.349:PCI-MSI.69632-edge.ioat-msix
     10.80 ±200%    -100.0%       0.00        interrupts.CPU18.350:PCI-MSI.288768-edge.ahci[0000:00:11.5]
      0.00          -100.0%       0.00        interrupts.CPU18.350:PCI-MSI.69632-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU18.48:PCI-MSI.12582916-edge
      1151 ± 43%     -54.6%     522.67 ± 45%  interrupts.CPU18.CAL:Function_call_interrupts
     30.60 ± 54%      -7.4%      28.33 ± 23%  interrupts.CPU18.IWI:IRQ_work_interrupts
    106264            -1.1%     105122        interrupts.CPU18.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU18.MCP:Machine_check_polls
     37200 ±  6%     +10.8%      41199        interrupts.CPU18.NMI:Non-maskable_interrupts
     37200 ±  6%     +10.8%      41199        interrupts.CPU18.PMI:Performance_monitoring_interrupts
     69.80 ± 55%     -44.1%      39.00 ± 56%  interrupts.CPU18.RES:Rescheduling_interrupts
      0.00          -100.0%       0.00        interrupts.CPU18.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU19.349:PCI-MSI.73728-edge.ioat-msix
      0.00       +1.8e+103%      17.67 ±141%  interrupts.CPU19.350:PCI-MSI.288768-edge.ahci[0000:00:11.5]
      0.00          -100.0%       0.00        interrupts.CPU19.351:PCI-MSI.71680-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU19.49:PCI-MSI.12582917-edge
      1144 ± 44%     -50.8%     563.00 ± 47%  interrupts.CPU19.CAL:Function_call_interrupts
     39.60 ± 54%     -19.2%      32.00 ± 26%  interrupts.CPU19.IWI:IRQ_work_interrupts
    105742            -1.7%     103955        interrupts.CPU19.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU19.MCP:Machine_check_polls
     36162 ±  5%     +13.9%      41201        interrupts.CPU19.NMI:Non-maskable_interrupts
     36162 ±  5%     +13.9%      41201        interrupts.CPU19.PMI:Performance_monitoring_interrupts
     51.00 ± 43%     -37.3%      32.00 ± 27%  interrupts.CPU19.RES:Rescheduling_interrupts
      0.20 ±200%    -100.0%       0.00        interrupts.CPU19.TLB:TLB_shootdowns
      1594 ± 33%     -49.0%     814.00 ±  8%  interrupts.CPU2.CAL:Function_call_interrupts
     58.40 ± 43%     -48.6%      30.00 ± 37%  interrupts.CPU2.IWI:IRQ_work_interrupts
    105913            -0.9%     105004        interrupts.CPU2.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU2.MCP:Machine_check_polls
     35248 ±  7%     +14.0%      40194 ±  5%  interrupts.CPU2.NMI:Non-maskable_interrupts
     35248 ±  7%     +14.0%      40194 ±  5%  interrupts.CPU2.PMI:Performance_monitoring_interrupts
    113.80 ± 36%      -7.1%     105.67 ± 18%  interrupts.CPU2.RES:Rescheduling_interrupts
      1.60 ±200%   +1150.0%      20.00 ± 74%  interrupts.CPU2.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU20.350:PCI-MSI.75776-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU20.352:PCI-MSI.73728-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU20.50:PCI-MSI.12582918-edge
      1213 ± 43%     -54.0%     558.67 ± 46%  interrupts.CPU20.CAL:Function_call_interrupts
     20.40 ±  5%     +47.1%      30.00 ±  7%  interrupts.CPU20.IWI:IRQ_work_interrupts
    104307            +0.4%     104744        interrupts.CPU20.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU20.MCP:Machine_check_polls
     33299 ±  2%     +24.7%      41519        interrupts.CPU20.NMI:Non-maskable_interrupts
     33299 ±  2%     +24.7%      41519        interrupts.CPU20.PMI:Performance_monitoring_interrupts
     61.60 ± 32%     -67.0%      20.33 ± 48%  interrupts.CPU20.RES:Rescheduling_interrupts
      0.00         +1e+102%       1.00 ±141%  interrupts.CPU20.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU21.352:PCI-MSI.77824-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU21.353:PCI-MSI.75776-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU21.51:PCI-MSI.12582919-edge
      1362 ± 53%     -57.0%     586.00 ± 46%  interrupts.CPU21.CAL:Function_call_interrupts
     30.60 ± 51%      -7.4%      28.33 ± 34%  interrupts.CPU21.IWI:IRQ_work_interrupts
    105105 ±  2%      -0.6%     104492        interrupts.CPU21.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU21.MCP:Machine_check_polls
     36342 ±  6%     +12.8%      40986        interrupts.CPU21.NMI:Non-maskable_interrupts
     36342 ±  6%     +12.8%      40986        interrupts.CPU21.PMI:Performance_monitoring_interrupts
     71.00 ± 43%     -28.2%      51.00 ± 50%  interrupts.CPU21.RES:Rescheduling_interrupts
      0.60 ±133%    -100.0%       0.00        interrupts.CPU21.TLB:TLB_shootdowns
     12.20 ±200%    -100.0%       0.00        interrupts.CPU22.354:PCI-MSI.288768-edge.ahci[0000:00:11.5]
      0.00          -100.0%       0.00        interrupts.CPU22.354:PCI-MSI.77824-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU22.52:PCI-MSI.12582920-edge
      1130 ± 43%     -51.1%     552.33 ± 46%  interrupts.CPU22.CAL:Function_call_interrupts
     22.60 ±  6%     +74.0%      39.33 ± 13%  interrupts.CPU22.IWI:IRQ_work_interrupts
    105349            -2.0%     103276        interrupts.CPU22.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU22.MCP:Machine_check_polls
     35790 ±  9%     +15.2%      41230        interrupts.CPU22.NMI:Non-maskable_interrupts
     35790 ±  9%     +15.2%      41230        interrupts.CPU22.PMI:Performance_monitoring_interrupts
     53.60 ± 40%     -50.2%      26.67 ± 46%  interrupts.CPU22.RES:Rescheduling_interrupts
      0.20 ±200%    -100.0%       0.00        interrupts.CPU22.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU23.355:PCI-MSI.376832-edge.ahci[0000:00:17.0]
      0.00          -100.0%       0.00        interrupts.CPU23.355:PCI-MSI.79872-edge.ioat-msix
      1141 ± 43%     -57.2%     488.33 ± 46%  interrupts.CPU23.CAL:Function_call_interrupts
     46.00 ± 67%     -32.6%      31.00 ± 22%  interrupts.CPU23.IWI:IRQ_work_interrupts
    105776 ±  2%      -1.1%     104605        interrupts.CPU23.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU23.MCP:Machine_check_polls
     36878 ±  5%     +11.9%      41277        interrupts.CPU23.NMI:Non-maskable_interrupts
     36878 ±  5%     +11.9%      41277        interrupts.CPU23.PMI:Performance_monitoring_interrupts
     63.60 ± 37%     -45.5%      34.67 ± 22%  interrupts.CPU23.RES:Rescheduling_interrupts
      0.00       +2.7e+102%       2.67 ±141%  interrupts.CPU23.TLB:TLB_shootdowns
      1292 ± 36%     -48.3%     668.33 ± 34%  interrupts.CPU24.CAL:Function_call_interrupts
     42.80 ± 39%     -23.7%      32.67 ± 25%  interrupts.CPU24.IWI:IRQ_work_interrupts
    107035            -1.9%     105051        interrupts.CPU24.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU24.MCP:Machine_check_polls
     36772 ±  7%     +11.0%      40806        interrupts.CPU24.NMI:Non-maskable_interrupts
     36772 ±  7%     +11.0%      40806        interrupts.CPU24.PMI:Performance_monitoring_interrupts
    508.00 ±123%     -83.1%      85.67 ± 31%  interrupts.CPU24.RES:Rescheduling_interrupts
      0.20 ±200%   +4900.0%      10.00 ± 58%  interrupts.CPU24.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU25.41:PCI-MSI.112721920-edge.PCIe.PME,pciehp
      1320 ± 21%     -48.8%     676.33 ± 39%  interrupts.CPU25.CAL:Function_call_interrupts
     38.00 ± 50%      -7.9%      35.00 ± 23%  interrupts.CPU25.IWI:IRQ_work_interrupts
    105956            -2.2%     103678        interrupts.CPU25.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU25.MCP:Machine_check_polls
     35852 ±  5%     +14.2%      40946 ±  2%  interrupts.CPU25.NMI:Non-maskable_interrupts
     35852 ±  5%     +14.2%      40946 ±  2%  interrupts.CPU25.PMI:Performance_monitoring_interrupts
     94.20 ± 34%      -2.0%      92.33 ± 13%  interrupts.CPU25.RES:Rescheduling_interrupts
      0.20 ±200%   +3733.3%       7.67 ±105%  interrupts.CPU25.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU26.42:PCI-MSI.112738304-edge.PCIe.PME,pciehp
      1712 ± 53%     -33.8%       1134 ± 16%  interrupts.CPU26.CAL:Function_call_interrupts
     44.60 ± 42%     -32.0%      30.33 ± 28%  interrupts.CPU26.IWI:IRQ_work_interrupts
    104913 ±  2%      -0.5%     104337        interrupts.CPU26.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU26.MCP:Machine_check_polls
     35996 ±  8%     +13.4%      40804 ±  2%  interrupts.CPU26.NMI:Non-maskable_interrupts
     35996 ±  8%     +13.4%      40804 ±  2%  interrupts.CPU26.PMI:Performance_monitoring_interrupts
    323.60 ±138%      -1.4%     319.00 ± 84%  interrupts.CPU26.RES:Rescheduling_interrupts
      0.20 ±200%     +66.7%       0.33 ±141%  interrupts.CPU26.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU27.357:PCI-MSI.67174400-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU27.358:PCI-MSI.67174400-edge.ioat-msix
      1275 ± 44%     -40.4%     759.67 ± 44%  interrupts.CPU27.CAL:Function_call_interrupts
     37.80 ± 85%     -38.3%      23.33 ± 17%  interrupts.CPU27.IWI:IRQ_work_interrupts
    104939 ±  2%      -1.8%     103032        interrupts.CPU27.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU27.MCP:Machine_check_polls
     36940 ±  7%     +10.5%      40803        interrupts.CPU27.NMI:Non-maskable_interrupts
     36940 ±  7%     +10.5%      40803        interrupts.CPU27.PMI:Performance_monitoring_interrupts
     73.20 ± 42%     +59.4%     116.67 ± 28%  interrupts.CPU27.RES:Rescheduling_interrupts
      0.00       +6.7e+101%       0.67 ±141%  interrupts.CPU27.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU28.359:PCI-MSI.67176448-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU28.360:PCI-MSI.67176448-edge.ioat-msix
      1391 ± 49%     -56.6%     603.67 ± 43%  interrupts.CPU28.CAL:Function_call_interrupts
     30.40 ± 49%     +22.8%      37.33 ± 13%  interrupts.CPU28.IWI:IRQ_work_interrupts
    105431            -1.7%     103629        interrupts.CPU28.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU28.MCP:Machine_check_polls
     38038 ±  8%      +5.4%      40078 ±  2%  interrupts.CPU28.NMI:Non-maskable_interrupts
     38038 ±  8%      +5.4%      40078 ±  2%  interrupts.CPU28.PMI:Performance_monitoring_interrupts
    194.80 ±101%     -72.6%      53.33 ± 23%  interrupts.CPU28.RES:Rescheduling_interrupts
     66.40 ±200%    -100.0%       0.00        interrupts.CPU28.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU29.360:PCI-MSI.67178496-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU29.361:PCI-MSI.67178496-edge.ioat-msix
      1191 ± 43%     -43.2%     676.33 ± 46%  interrupts.CPU29.CAL:Function_call_interrupts
     69.60 ± 22%     -42.5%      40.00 ± 12%  interrupts.CPU29.IWI:IRQ_work_interrupts
    106254            -2.5%     103547        interrupts.CPU29.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU29.MCP:Machine_check_polls
     36910 ±  5%     +11.8%      41267        interrupts.CPU29.NMI:Non-maskable_interrupts
     36910 ±  5%     +11.8%      41267        interrupts.CPU29.PMI:Performance_monitoring_interrupts
     49.80 ± 26%     +41.9%      70.67 ± 20%  interrupts.CPU29.RES:Rescheduling_interrupts
      0.40 ±122%   +1650.0%       7.00 ±141%  interrupts.CPU29.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU3.414:PCI-MSI.68681745-edge.nvme0q17
      1717 ± 63%     -44.3%     955.67 ± 42%  interrupts.CPU3.CAL:Function_call_interrupts
     53.60 ± 30%     -40.9%      31.67 ± 24%  interrupts.CPU3.IWI:IRQ_work_interrupts
    105699            -0.9%     104797        interrupts.CPU3.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU3.MCP:Machine_check_polls
     35746 ±  6%     +15.9%      41429        interrupts.CPU3.NMI:Non-maskable_interrupts
     35746 ±  6%     +15.9%      41429        interrupts.CPU3.PMI:Performance_monitoring_interrupts
     86.00 ± 22%      -5.4%      81.33 ± 30%  interrupts.CPU3.RES:Rescheduling_interrupts
      0.00       +6.7e+102%       6.67 ± 93%  interrupts.CPU3.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU30.361:PCI-MSI.67180544-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU30.362:PCI-MSI.67180544-edge.ioat-msix
      1215 ± 44%     -50.6%     600.00 ± 39%  interrupts.CPU30.CAL:Function_call_interrupts
     45.60 ± 68%     -10.1%      41.00 ± 12%  interrupts.CPU30.IWI:IRQ_work_interrupts
    105188            -0.6%     104548        interrupts.CPU30.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU30.MCP:Machine_check_polls
     35956 ±  5%     +13.9%      40943        interrupts.CPU30.NMI:Non-maskable_interrupts
     35956 ±  5%     +13.9%      40943        interrupts.CPU30.PMI:Performance_monitoring_interrupts
     71.20 ± 95%     -37.7%      44.33 ± 37%  interrupts.CPU30.RES:Rescheduling_interrupts
      0.00       +1.6e+103%      16.00 ±141%  interrupts.CPU30.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU31.362:PCI-MSI.67182592-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU31.363:PCI-MSI.67182592-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU31.401:PCI-MSI.68681732-edge.nvme0q4
      1170 ± 40%     -49.7%     589.33 ± 41%  interrupts.CPU31.CAL:Function_call_interrupts
     54.40 ± 28%     -34.4%      35.67 ± 37%  interrupts.CPU31.IWI:IRQ_work_interrupts
    105350 ±  2%      -0.6%     104674        interrupts.CPU31.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU31.MCP:Machine_check_polls
     36695 ±  3%      +6.1%      38944 ±  8%  interrupts.CPU31.NMI:Non-maskable_interrupts
     36695 ±  3%      +6.1%      38944 ±  8%  interrupts.CPU31.PMI:Performance_monitoring_interrupts
     44.00 ± 38%     +34.8%      59.33 ± 30%  interrupts.CPU31.RES:Rescheduling_interrupts
     44.40 ±198%     -88.0%       5.33 ±141%  interrupts.CPU31.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU32.363:PCI-MSI.67184640-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU32.364:PCI-MSI.67184640-edge.ioat-msix
      1480 ± 60%     -56.7%     641.67 ± 41%  interrupts.CPU32.CAL:Function_call_interrupts
     48.60 ± 68%     -41.7%      28.33 ± 27%  interrupts.CPU32.IWI:IRQ_work_interrupts
    105223            -0.6%     104608        interrupts.CPU32.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU32.MCP:Machine_check_polls
     36046 ±  6%     +13.0%      40735        interrupts.CPU32.NMI:Non-maskable_interrupts
     36046 ±  6%     +13.0%      40735        interrupts.CPU32.PMI:Performance_monitoring_interrupts
     43.80 ± 40%    +113.9%      93.67 ± 78%  interrupts.CPU32.RES:Rescheduling_interrupts
     17.60 ±200%     -29.9%      12.33 ± 53%  interrupts.CPU32.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU33.364:PCI-MSI.67186688-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU33.365:PCI-MSI.67186688-edge.ioat-msix
      1179 ± 38%     -47.2%     623.00 ± 45%  interrupts.CPU33.CAL:Function_call_interrupts
     45.20 ± 68%     -35.8%      29.00 ± 39%  interrupts.CPU33.IWI:IRQ_work_interrupts
    105800            -1.2%     104555        interrupts.CPU33.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU33.MCP:Machine_check_polls
     35765 ±  7%     +13.9%      40749        interrupts.CPU33.NMI:Non-maskable_interrupts
     35765 ±  7%     +13.9%      40749        interrupts.CPU33.PMI:Performance_monitoring_interrupts
     96.80 ± 73%      -5.3%      91.67 ± 65%  interrupts.CPU33.RES:Rescheduling_interrupts
      1.40 ±139%    +328.6%       6.00 ± 98%  interrupts.CPU33.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU34.365:PCI-MSI.67188736-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU34.366:PCI-MSI.67188736-edge.ioat-msix
      1253 ± 34%     -53.8%     579.00 ± 44%  interrupts.CPU34.CAL:Function_call_interrupts
     40.60 ± 68%     -17.9%      33.33 ± 23%  interrupts.CPU34.IWI:IRQ_work_interrupts
    104952            -0.3%     104594        interrupts.CPU34.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU34.MCP:Machine_check_polls
     37133 ±  6%      +9.6%      40704        interrupts.CPU34.NMI:Non-maskable_interrupts
     37133 ±  6%      +9.6%      40704        interrupts.CPU34.PMI:Performance_monitoring_interrupts
     95.80 ± 55%     -56.9%      41.33 ± 18%  interrupts.CPU34.RES:Rescheduling_interrupts
      0.00         +1e+103%      10.00 ±114%  interrupts.CPU34.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU35.403:PCI-MSI.68681734-edge.nvme0q6
      1161 ± 41%     -51.7%     561.00 ± 48%  interrupts.CPU35.CAL:Function_call_interrupts
     46.80 ± 43%     -38.0%      29.00 ± 34%  interrupts.CPU35.IWI:IRQ_work_interrupts
    106085            -2.3%     103668        interrupts.CPU35.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU35.MCP:Machine_check_polls
     35361 ±  6%     +15.7%      40921        interrupts.CPU35.NMI:Non-maskable_interrupts
     35361 ±  6%     +15.7%      40921        interrupts.CPU35.PMI:Performance_monitoring_interrupts
     60.80 ± 33%     -75.9%      14.67 ± 25%  interrupts.CPU35.RES:Rescheduling_interrupts
      0.40 ±200%   +1816.7%       7.67 ± 81%  interrupts.CPU35.TLB:TLB_shootdowns
      1148 ± 43%     -47.3%     605.67 ± 49%  interrupts.CPU36.CAL:Function_call_interrupts
     30.40 ± 53%      +4.2%      31.67 ± 23%  interrupts.CPU36.IWI:IRQ_work_interrupts
    104917            -1.4%     103480        interrupts.CPU36.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU36.MCP:Machine_check_polls
     36278 ±  9%     +11.8%      40572        interrupts.CPU36.NMI:Non-maskable_interrupts
     36278 ±  9%     +11.8%      40572        interrupts.CPU36.PMI:Performance_monitoring_interrupts
     78.60 ± 44%     -64.0%      28.33 ± 15%  interrupts.CPU36.RES:Rescheduling_interrupts
      0.00       +1.3e+103%      12.67 ± 87%  interrupts.CPU36.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU37.404:PCI-MSI.68681735-edge.nvme0q7
      1157 ± 43%     -48.2%     599.00 ± 36%  interrupts.CPU37.CAL:Function_call_interrupts
     38.20 ± 48%     -12.7%      33.33 ± 27%  interrupts.CPU37.IWI:IRQ_work_interrupts
    105480            -1.8%     103560        interrupts.CPU37.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU37.MCP:Machine_check_polls
     35362 ±  5%     +15.0%      40668        interrupts.CPU37.NMI:Non-maskable_interrupts
     35362 ±  5%     +15.0%      40668        interrupts.CPU37.PMI:Performance_monitoring_interrupts
     40.20 ± 44%     -44.4%      22.33 ± 25%  interrupts.CPU37.RES:Rescheduling_interrupts
      0.40 ±200%     -16.7%       0.33 ±141%  interrupts.CPU37.TLB:TLB_shootdowns
      1166 ± 43%     -51.2%     569.67 ± 48%  interrupts.CPU38.CAL:Function_call_interrupts
     34.60 ± 78%     -34.5%      22.67 ±  7%  interrupts.CPU38.IWI:IRQ_work_interrupts
    105830            -1.8%     103888        interrupts.CPU38.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU38.MCP:Machine_check_polls
     35914 ±  7%     +12.9%      40541        interrupts.CPU38.NMI:Non-maskable_interrupts
     35914 ±  7%     +12.9%      40541        interrupts.CPU38.PMI:Performance_monitoring_interrupts
     78.00 ± 64%     -76.9%      18.00 ± 12%  interrupts.CPU38.RES:Rescheduling_interrupts
      1.80 ±173%     -81.5%       0.33 ±141%  interrupts.CPU38.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU39.405:PCI-MSI.68681736-edge.nvme0q8
      1206 ± 44%     -52.4%     575.00 ± 46%  interrupts.CPU39.CAL:Function_call_interrupts
     30.00 ± 53%      +2.2%      30.67 ± 27%  interrupts.CPU39.IWI:IRQ_work_interrupts
    106171            -1.8%     104234        interrupts.CPU39.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU39.MCP:Machine_check_polls
     35164 ±  5%     +15.5%      40616        interrupts.CPU39.NMI:Non-maskable_interrupts
     35164 ±  5%     +15.5%      40616        interrupts.CPU39.PMI:Performance_monitoring_interrupts
     58.60 ± 73%     -53.9%      27.00 ± 19%  interrupts.CPU39.RES:Rescheduling_interrupts
      0.20 ±200%    -100.0%       0.00        interrupts.CPU39.TLB:TLB_shootdowns
      1258 ± 39%     -46.0%     680.33 ± 28%  interrupts.CPU4.CAL:Function_call_interrupts
     49.80 ± 49%     -59.8%      20.00 ±  8%  interrupts.CPU4.IWI:IRQ_work_interrupts
    105754            -1.0%     104715        interrupts.CPU4.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU4.MCP:Machine_check_polls
     38485 ±  4%      +1.8%      39159 ±  3%  interrupts.CPU4.NMI:Non-maskable_interrupts
     38485 ±  4%      +1.8%      39159 ±  3%  interrupts.CPU4.PMI:Performance_monitoring_interrupts
    106.00 ± 36%     +33.3%     141.33 ± 48%  interrupts.CPU4.RES:Rescheduling_interrupts
      0.00       +6.7e+101%       0.67 ±141%  interrupts.CPU4.TLB:TLB_shootdowns
      1184 ± 43%     -51.2%     578.33 ± 47%  interrupts.CPU40.CAL:Function_call_interrupts
     31.20 ± 46%     -12.4%      27.33 ± 22%  interrupts.CPU40.IWI:IRQ_work_interrupts
    106382            -1.9%     104310        interrupts.CPU40.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU40.MCP:Machine_check_polls
     38001 ±  3%      +7.3%      40775        interrupts.CPU40.NMI:Non-maskable_interrupts
     38001 ±  3%      +7.3%      40775        interrupts.CPU40.PMI:Performance_monitoring_interrupts
     61.20 ± 54%     -40.1%      36.67 ± 14%  interrupts.CPU40.RES:Rescheduling_interrupts
      0.00       +7.3e+102%       7.33 ±131%  interrupts.CPU40.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU41.406:PCI-MSI.68681737-edge.nvme0q9
      1178 ± 41%     -51.0%     577.33 ± 49%  interrupts.CPU41.CAL:Function_call_interrupts
     46.40 ± 39%     -44.0%      26.00 ± 11%  interrupts.CPU41.IWI:IRQ_work_interrupts
    105918            -0.6%     105239        interrupts.CPU41.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU41.MCP:Machine_check_polls
     37378            +8.8%      40674        interrupts.CPU41.NMI:Non-maskable_interrupts
     37378            +8.8%      40674        interrupts.CPU41.PMI:Performance_monitoring_interrupts
     56.60 ± 42%     -48.2%      29.33 ± 30%  interrupts.CPU41.RES:Rescheduling_interrupts
      0.00       +5.3e+102%       5.33 ±141%  interrupts.CPU41.TLB:TLB_shootdowns
      1209 ± 37%     -51.3%     589.67 ± 44%  interrupts.CPU42.CAL:Function_call_interrupts
     38.80 ± 59%     -33.8%      25.67 ± 25%  interrupts.CPU42.IWI:IRQ_work_interrupts
    106931            -2.9%     103872        interrupts.CPU42.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU42.MCP:Machine_check_polls
     34186 ±  7%     +18.6%      40549        interrupts.CPU42.NMI:Non-maskable_interrupts
     34186 ±  7%     +18.6%      40549        interrupts.CPU42.PMI:Performance_monitoring_interrupts
    104.60 ± 29%     -53.2%      49.00 ± 58%  interrupts.CPU42.RES:Rescheduling_interrupts
      0.00       +2.7e+102%       2.67 ±141%  interrupts.CPU42.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU43.407:PCI-MSI.69206026-edge.nvme1q10
      1146 ± 41%     -50.9%     563.00 ± 47%  interrupts.CPU43.CAL:Function_call_interrupts
     60.40 ± 58%     -39.3%      36.67 ± 26%  interrupts.CPU43.IWI:IRQ_work_interrupts
    105946            -2.1%     103720        interrupts.CPU43.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU43.MCP:Machine_check_polls
     37198 ±  4%      +9.7%      40800        interrupts.CPU43.NMI:Non-maskable_interrupts
     37198 ±  4%      +9.7%      40800        interrupts.CPU43.PMI:Performance_monitoring_interrupts
     80.80 ± 42%     -60.0%      32.33 ± 16%  interrupts.CPU43.RES:Rescheduling_interrupts
      0.60 ±133%   +1177.8%       7.67 ± 70%  interrupts.CPU43.TLB:TLB_shootdowns
      1139 ± 42%     -46.6%     608.33 ± 45%  interrupts.CPU44.CAL:Function_call_interrupts
     34.60 ± 68%      +7.9%      37.33 ± 27%  interrupts.CPU44.IWI:IRQ_work_interrupts
    105117            -1.5%     103556        interrupts.CPU44.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU44.MCP:Machine_check_polls
     36248 ±  8%     +13.5%      41148        interrupts.CPU44.NMI:Non-maskable_interrupts
     36248 ±  8%     +13.5%      41148        interrupts.CPU44.PMI:Performance_monitoring_interrupts
     83.40 ± 90%     -27.3%      60.67 ± 26%  interrupts.CPU44.RES:Rescheduling_interrupts
      1.60 ±170%     -37.5%       1.00 ±141%  interrupts.CPU44.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU45.387:PCI-MSI.69206027-edge.nvme1q11
      1167 ± 41%     -49.2%     593.00 ± 51%  interrupts.CPU45.CAL:Function_call_interrupts
     59.80 ± 29%     -61.5%      23.00 ±  3%  interrupts.CPU45.IWI:IRQ_work_interrupts
    106680            -3.1%     103357        interrupts.CPU45.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU45.MCP:Machine_check_polls
     36324 ±  7%     +10.3%      40065        interrupts.CPU45.NMI:Non-maskable_interrupts
     36324 ±  7%     +10.3%      40065        interrupts.CPU45.PMI:Performance_monitoring_interrupts
    133.60 ± 80%     -57.1%      57.33 ± 46%  interrupts.CPU45.RES:Rescheduling_interrupts
      1.60 ±170%     -79.2%       0.33 ±141%  interrupts.CPU45.TLB:TLB_shootdowns
      1176 ± 42%     -42.9%     671.67 ± 31%  interrupts.CPU46.CAL:Function_call_interrupts
     45.80 ± 68%     -18.5%      37.33 ± 27%  interrupts.CPU46.IWI:IRQ_work_interrupts
    104406            -0.7%     103655        interrupts.CPU46.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU46.MCP:Machine_check_polls
     36585 ± 10%     +13.4%      41474        interrupts.CPU46.NMI:Non-maskable_interrupts
     36585 ± 10%     +13.4%      41474        interrupts.CPU46.PMI:Performance_monitoring_interrupts
     74.00 ± 38%      +1.4%      75.00 ± 87%  interrupts.CPU46.RES:Rescheduling_interrupts
      0.00       +2.3e+103%      22.67 ± 12%  interrupts.CPU46.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU47.389:PCI-MSI.69206028-edge.nvme1q12
      0.00          -100.0%       0.00        interrupts.CPU47.409:PCI-MSI.69206028-edge.nvme1q12
      1415 ± 53%     -57.3%     604.00 ± 43%  interrupts.CPU47.CAL:Function_call_interrupts
     55.00 ± 53%     -57.6%      23.33 ±  7%  interrupts.CPU47.IWI:IRQ_work_interrupts
    105299            -1.1%     104095        interrupts.CPU47.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU47.MCP:Machine_check_polls
     37302 ± 10%      +9.1%      40692        interrupts.CPU47.NMI:Non-maskable_interrupts
     37302 ± 10%      +9.1%      40692        interrupts.CPU47.PMI:Performance_monitoring_interrupts
     87.00 ± 58%     -15.7%      73.33 ± 46%  interrupts.CPU47.RES:Rescheduling_interrupts
      2.20 ±200%    +218.2%       7.00 ± 34%  interrupts.CPU47.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU48.356:PCI-MSI.376832-edge.ahci[0000:00:17.0]
      0.00          -100.0%       0.00        interrupts.CPU48.356:PCI-MSI.79872-edge.ioat-msix
      0.00          -100.0%       0.00        interrupts.CPU48.358:PCI-MSI.376832-edge.ahci[0000:00:17.0]
      0.00          -100.0%       0.00        interrupts.CPU48.360:PCI-MSI.376832-edge.ahci[0000:00:17.0]
      0.00          -100.0%       0.00        interrupts.CPU48.364:PCI-MSI.376832-edge.ahci[0000:00:17.0]
      2.00 ±200%    -100.0%       0.00        interrupts.CPU48.366:PCI-MSI.376832-edge.ahci[0000:00:17.0]
      0.00          -100.0%       0.00        interrupts.CPU48.55:PCI-MSI.12584961-edge
      1280 ± 37%     -55.3%     573.00 ± 47%  interrupts.CPU48.CAL:Function_call_interrupts
     58.00 ± 58%     -42.0%      33.67 ± 30%  interrupts.CPU48.IWI:IRQ_work_interrupts
    106107            -1.5%     104468        interrupts.CPU48.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU48.MCP:Machine_check_polls
     35915 ±  8%     +14.9%      41254        interrupts.CPU48.NMI:Non-maskable_interrupts
     35915 ±  8%     +14.9%      41254        interrupts.CPU48.PMI:Performance_monitoring_interrupts
     59.60 ± 43%     -16.7%      49.67 ± 39%  interrupts.CPU48.RES:Rescheduling_interrupts
      0.20 ±200%    -100.0%       0.00        interrupts.CPU48.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU49.345:PCI-MSI.68681728-edge.nvme0q0
      0.00          -100.0%       0.00        interrupts.CPU49.345:PCI-MSI.69206016-edge.nvme1q0
      0.00          -100.0%       0.00        interrupts.CPU49.346:PCI-MSI.69206016-edge.nvme1q0
      0.00          -100.0%       0.00        interrupts.CPU49.348:PCI-MSI.68681728-edge.nvme0q0
      0.00          -100.0%       0.00        interrupts.CPU49.349:PCI-MSI.69206016-edge.nvme1q0
      0.00          -100.0%       0.00        interrupts.CPU49.350:PCI-MSI.69206016-edge.nvme1q0
      0.00          -100.0%       0.00        interrupts.CPU49.351:PCI-MSI.68681728-edge.nvme0q0
      0.00          -100.0%       0.00        interrupts.CPU49.351:PCI-MSI.69206016-edge.nvme1q0
      0.00          -100.0%       0.00        interrupts.CPU49.3:IO-APIC.3-edge
      0.00          -100.0%       0.00        interrupts.CPU49.56:PCI-MSI.12584962-edge
      1304 ± 38%     -49.3%     661.67 ± 41%  interrupts.CPU49.CAL:Function_call_interrupts
     46.20 ± 67%     -38.7%      28.33 ± 34%  interrupts.CPU49.IWI:IRQ_work_interrupts
    104634            -0.2%     104379        interrupts.CPU49.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU49.MCP:Machine_check_polls
     36454 ±  8%     +13.7%      41435 ±  2%  interrupts.CPU49.NMI:Non-maskable_interrupts
     36454 ±  8%     +13.7%      41435 ±  2%  interrupts.CPU49.PMI:Performance_monitoring_interrupts
     94.40 ±  9%      -8.5%      86.33 ± 23%  interrupts.CPU49.RES:Rescheduling_interrupts
      1.60 ±170%   +1191.7%      20.67 ±141%  interrupts.CPU49.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU5.31:PCI-MSI.48791552-edge.PCIe.PME,pciehp
      0.00          -100.0%       0.00        interrupts.CPU5.415:PCI-MSI.69206034-edge.nvme1q18
      1202 ± 44%     -41.0%     709.67 ± 38%  interrupts.CPU5.CAL:Function_call_interrupts
     73.80 ± 22%     -63.4%      27.00 ± 29%  interrupts.CPU5.IWI:IRQ_work_interrupts
    106142            -1.9%     104111        interrupts.CPU5.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU5.MCP:Machine_check_polls
     36562 ±  3%      +8.9%      39809 ±  4%  interrupts.CPU5.NMI:Non-maskable_interrupts
     36562 ±  3%      +8.9%      39809 ±  4%  interrupts.CPU5.PMI:Performance_monitoring_interrupts
     58.40 ± 35%    +120.3%     128.67 ± 40%  interrupts.CPU5.RES:Rescheduling_interrupts
      0.00       +8.7e+102%       8.67 ±141%  interrupts.CPU5.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU50.345:PCI-MSI.68681728-edge.nvme0q0
      0.00          -100.0%       0.00        interrupts.CPU50.346:PCI-MSI.68681728-edge.nvme0q0
      0.00          -100.0%       0.00        interrupts.CPU50.347:PCI-MSI.69206016-edge.nvme1q0
      0.00          -100.0%       0.00        interrupts.CPU50.348:PCI-MSI.68681728-edge.nvme0q0
      0.00          -100.0%       0.00        interrupts.CPU50.349:PCI-MSI.68681728-edge.nvme0q0
      0.00          -100.0%       0.00        interrupts.CPU50.350:PCI-MSI.69206016-edge.nvme1q0
      0.00          -100.0%       0.00        interrupts.CPU50.353:PCI-MSI.69206016-edge.nvme1q0
      0.00          -100.0%       0.00        interrupts.CPU50.57:PCI-MSI.12584963-edge
      1194 ± 41%     -45.9%     646.67 ± 42%  interrupts.CPU50.CAL:Function_call_interrupts
     45.80 ± 40%     -35.2%      29.67 ± 32%  interrupts.CPU50.IWI:IRQ_work_interrupts
    105279            -0.9%     104357        interrupts.CPU50.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU50.MCP:Machine_check_polls
     37528 ±  2%      +9.9%      41248        interrupts.CPU50.NMI:Non-maskable_interrupts
     37528 ±  2%      +9.9%      41248        interrupts.CPU50.PMI:Performance_monitoring_interrupts
     93.00 ± 73%     -15.1%      79.00 ± 12%  interrupts.CPU50.RES:Rescheduling_interrupts
      0.20 ±200%     +66.7%       0.33 ±141%  interrupts.CPU50.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU51.58:PCI-MSI.12584964-edge
      1176 ± 42%     -45.6%     640.67 ± 50%  interrupts.CPU51.CAL:Function_call_interrupts
     60.20 ± 40%     -56.8%      26.00 ± 17%  interrupts.CPU51.IWI:IRQ_work_interrupts
    106157            -2.0%     104034        interrupts.CPU51.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU51.MCP:Machine_check_polls
     36877 ±  6%     +10.3%      40679        interrupts.CPU51.NMI:Non-maskable_interrupts
     36877 ±  6%     +10.3%      40679        interrupts.CPU51.PMI:Performance_monitoring_interrupts
     62.40 ± 41%     -18.3%      51.00 ± 40%  interrupts.CPU51.RES:Rescheduling_interrupts
      0.20 ±200%    -100.0%       0.00        interrupts.CPU51.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU52.384:PCI-MSI.68681746-edge.nvme0q18
      0.00          -100.0%       0.00        interrupts.CPU52.59:PCI-MSI.12584965-edge
      1136 ± 44%     -48.9%     580.33 ± 43%  interrupts.CPU52.CAL:Function_call_interrupts
     50.20 ± 67%     -28.3%      36.00 ± 27%  interrupts.CPU52.IWI:IRQ_work_interrupts
    105211            -0.3%     104883        interrupts.CPU52.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU52.MCP:Machine_check_polls
     37420 ± 10%     +10.0%      41179        interrupts.CPU52.NMI:Non-maskable_interrupts
     37420 ± 10%     +10.0%      41179        interrupts.CPU52.PMI:Performance_monitoring_interrupts
     87.60 ± 67%     -46.0%      47.33 ± 36%  interrupts.CPU52.RES:Rescheduling_interrupts
    205.00 ±199%     -99.8%       0.33 ±141%  interrupts.CPU52.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU53.60:PCI-MSI.12584966-edge
      1166 ± 44%     -49.9%     584.33 ± 46%  interrupts.CPU53.CAL:Function_call_interrupts
     22.60 ±  9%      -4.1%      21.67 ±  2%  interrupts.CPU53.IWI:IRQ_work_interrupts
    106072            -0.5%     105555        interrupts.CPU53.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU53.MCP:Machine_check_polls
     35894 ±  7%     +14.6%      41127        interrupts.CPU53.NMI:Non-maskable_interrupts
     35894 ±  7%     +14.6%      41127        interrupts.CPU53.PMI:Performance_monitoring_interrupts
     65.40 ± 69%      +5.5%      69.00 ± 19%  interrupts.CPU53.RES:Rescheduling_interrupts
      0.20 ±200%     +66.7%       0.33 ±141%  interrupts.CPU53.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU54.385:PCI-MSI.69206035-edge.nvme1q19
      0.00          -100.0%       0.00        interrupts.CPU54.61:PCI-MSI.12584967-edge
      1145 ± 42%     -48.0%     595.00 ± 48%  interrupts.CPU54.CAL:Function_call_interrupts
     49.80 ± 51%     -33.7%      33.00 ± 29%  interrupts.CPU54.IWI:IRQ_work_interrupts
    104362            +0.2%     104559        interrupts.CPU54.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU54.MCP:Machine_check_polls
     36865 ±  4%     +11.9%      41254        interrupts.CPU54.NMI:Non-maskable_interrupts
     36865 ±  4%     +11.9%      41254        interrupts.CPU54.PMI:Performance_monitoring_interrupts
     50.00 ± 33%     +11.3%      55.67 ± 34%  interrupts.CPU54.RES:Rescheduling_interrupts
      3.40 ±185%    -100.0%       0.00        interrupts.CPU54.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU55.62:PCI-MSI.12584968-edge
      1137 ± 42%     -51.3%     554.00 ± 47%  interrupts.CPU55.CAL:Function_call_interrupts
     45.80 ± 63%     -41.0%      27.00 ± 28%  interrupts.CPU55.IWI:IRQ_work_interrupts
    105488            -0.5%     105005        interrupts.CPU55.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU55.MCP:Machine_check_polls
     34680 ±  7%     +18.1%      40941        interrupts.CPU55.NMI:Non-maskable_interrupts
     34680 ±  7%     +18.1%      40941        interrupts.CPU55.PMI:Performance_monitoring_interrupts
     56.60 ± 39%      -2.8%      55.00 ± 73%  interrupts.CPU55.RES:Rescheduling_interrupts
     33.80 ±194%     -99.0%       0.33 ±141%  interrupts.CPU55.TLB:TLB_shootdowns
      1155 ± 44%     -50.9%     567.67 ± 48%  interrupts.CPU56.CAL:Function_call_interrupts
     30.40 ± 52%     +10.7%      33.67 ± 26%  interrupts.CPU56.IWI:IRQ_work_interrupts
    106025 ±  2%      -1.3%     104695        interrupts.CPU56.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU56.MCP:Machine_check_polls
     35806 ±  6%     +14.8%      41111        interrupts.CPU56.NMI:Non-maskable_interrupts
     35806 ±  6%     +14.8%      41111        interrupts.CPU56.PMI:Performance_monitoring_interrupts
     60.60 ± 38%     -13.6%      52.33 ± 50%  interrupts.CPU56.RES:Rescheduling_interrupts
      0.40 ±122%    -100.0%       0.00        interrupts.CPU56.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU57.65:PCI-MSI.12587009-edge
      1217 ± 45%     -49.9%     610.33 ± 42%  interrupts.CPU57.CAL:Function_call_interrupts
     53.20 ± 54%     -49.2%      27.00 ± 21%  interrupts.CPU57.IWI:IRQ_work_interrupts
    105073            +0.1%     105170        interrupts.CPU57.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU57.MCP:Machine_check_polls
     36927 ±  6%     +11.0%      40972        interrupts.CPU57.NMI:Non-maskable_interrupts
     36927 ±  6%     +11.0%      40972        interrupts.CPU57.PMI:Performance_monitoring_interrupts
     67.40 ± 32%     +28.1%      86.33 ± 29%  interrupts.CPU57.RES:Rescheduling_interrupts
      0.00          -100.0%       0.00        interrupts.CPU57.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU58.66:PCI-MSI.12587010-edge
      1163 ± 43%     -51.6%     562.33 ± 48%  interrupts.CPU58.CAL:Function_call_interrupts
     43.60 ± 48%     -38.1%      27.00 ± 19%  interrupts.CPU58.IWI:IRQ_work_interrupts
    107719            -2.7%     104802        interrupts.CPU58.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU58.MCP:Machine_check_polls
     37449 ±  7%      +8.8%      40746        interrupts.CPU58.NMI:Non-maskable_interrupts
     37449 ±  7%      +8.8%      40746        interrupts.CPU58.PMI:Performance_monitoring_interrupts
     72.00 ± 72%     -56.9%      31.00 ± 44%  interrupts.CPU58.RES:Rescheduling_interrupts
      0.40 ±122%    -100.0%       0.00        interrupts.CPU58.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU59.67:PCI-MSI.12587011-edge
      1149 ± 44%     -50.2%     572.33 ± 43%  interrupts.CPU59.CAL:Function_call_interrupts
     60.60 ± 37%     -60.4%      24.00 ± 12%  interrupts.CPU59.IWI:IRQ_work_interrupts
    104343            +0.7%     105107        interrupts.CPU59.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU59.MCP:Machine_check_polls
     35970 ±  4%     +14.3%      41123        interrupts.CPU59.NMI:Non-maskable_interrupts
     35970 ±  4%     +14.3%      41123        interrupts.CPU59.PMI:Performance_monitoring_interrupts
     49.00 ± 70%     +57.8%      77.33 ± 78%  interrupts.CPU59.RES:Rescheduling_interrupts
      0.20 ±200%    -100.0%       0.00        interrupts.CPU59.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU6.32:PCI-MSI.48807936-edge.PCIe.PME,pciehp
      1160 ± 43%     -48.9%     593.00 ± 47%  interrupts.CPU6.CAL:Function_call_interrupts
     63.80 ± 32%     -62.9%      23.67 ± 13%  interrupts.CPU6.IWI:IRQ_work_interrupts
    106868            -1.4%     105362        interrupts.CPU6.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU6.MCP:Machine_check_polls
     37563 ±  2%      +9.0%      40946        interrupts.CPU6.NMI:Non-maskable_interrupts
     37563 ±  2%      +9.0%      40946        interrupts.CPU6.PMI:Performance_monitoring_interrupts
     55.20 ± 37%     -38.4%      34.00 ± 12%  interrupts.CPU6.RES:Rescheduling_interrupts
      0.40 ±122%    +483.3%       2.33 ±141%  interrupts.CPU6.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU60.68:PCI-MSI.12587012-edge
      1179 ± 44%     -53.6%     547.33 ± 47%  interrupts.CPU60.CAL:Function_call_interrupts
     37.80 ± 52%     -25.0%      28.33 ± 31%  interrupts.CPU60.IWI:IRQ_work_interrupts
    106971            -2.0%     104804        interrupts.CPU60.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU60.MCP:Machine_check_polls
     35528 ±  7%     +15.7%      41121        interrupts.CPU60.NMI:Non-maskable_interrupts
     35528 ±  7%     +15.7%      41121        interrupts.CPU60.PMI:Performance_monitoring_interrupts
    113.60 ± 66%     -63.0%      42.00 ± 79%  interrupts.CPU60.RES:Rescheduling_interrupts
      0.60 ±133%    -100.0%       0.00        interrupts.CPU60.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU61.69:PCI-MSI.12587013-edge
      1188 ± 43%     -52.7%     562.33 ± 47%  interrupts.CPU61.CAL:Function_call_interrupts
     46.80 ± 68%     -53.0%      22.00 ± 12%  interrupts.CPU61.IWI:IRQ_work_interrupts
    105340 ±  2%      -0.5%     104852        interrupts.CPU61.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU61.MCP:Machine_check_polls
     37616 ±  2%      +1.3%      38087 ±  9%  interrupts.CPU61.NMI:Non-maskable_interrupts
     37616 ±  2%      +1.3%      38087 ±  9%  interrupts.CPU61.PMI:Performance_monitoring_interrupts
     62.60 ± 61%     -67.0%      20.67 ± 18%  interrupts.CPU61.RES:Rescheduling_interrupts
      0.20 ±200%    -100.0%       0.00        interrupts.CPU61.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU62.412:PCI-MSI.68681751-edge.nvme0q23
      0.00          -100.0%       0.00        interrupts.CPU62.70:PCI-MSI.12587014-edge
      1148 ± 43%     -51.9%     552.67 ± 47%  interrupts.CPU62.CAL:Function_call_interrupts
     49.40 ± 62%     -58.2%      20.67 ±  6%  interrupts.CPU62.IWI:IRQ_work_interrupts
    106207            -0.6%     105550        interrupts.CPU62.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU62.MCP:Machine_check_polls
     36231 ±  7%     +10.7%      40102 ±  3%  interrupts.CPU62.NMI:Non-maskable_interrupts
     36231 ±  7%     +10.7%      40102 ±  3%  interrupts.CPU62.PMI:Performance_monitoring_interrupts
     77.60 ± 46%     -57.9%      32.67 ± 35%  interrupts.CPU62.RES:Rescheduling_interrupts
      1.00 ±154%     -33.3%       0.67 ±141%  interrupts.CPU62.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU63.71:PCI-MSI.12587015-edge
      1152 ± 42%     -51.3%     560.67 ± 46%  interrupts.CPU63.CAL:Function_call_interrupts
     33.00 ± 43%     -16.2%      27.67 ± 31%  interrupts.CPU63.IWI:IRQ_work_interrupts
    106674            -1.5%     105114        interrupts.CPU63.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU63.MCP:Machine_check_polls
     36221 ±  5%     +13.2%      41009        interrupts.CPU63.NMI:Non-maskable_interrupts
     36221 ±  5%     +13.2%      41009        interrupts.CPU63.PMI:Performance_monitoring_interrupts
     72.60 ± 98%     -16.0%      61.00 ± 22%  interrupts.CPU63.RES:Rescheduling_interrupts
      0.40 ±200%    -100.0%       0.00        interrupts.CPU63.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU64.390:PCI-MSI.69206040-edge.nvme1q24
      0.00          -100.0%       0.00        interrupts.CPU64.72:PCI-MSI.12587016-edge
      1289 ± 49%     -57.2%     552.33 ± 48%  interrupts.CPU64.CAL:Function_call_interrupts
     53.40 ± 53%     -61.3%      20.67 ±  2%  interrupts.CPU64.IWI:IRQ_work_interrupts
    106599            -1.3%     105265        interrupts.CPU64.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU64.MCP:Machine_check_polls
     37543 ±  3%      +7.8%      40471 ±  2%  interrupts.CPU64.NMI:Non-maskable_interrupts
     37543 ±  3%      +7.8%      40471 ±  2%  interrupts.CPU64.PMI:Performance_monitoring_interrupts
     42.80 ± 58%     -26.8%      31.33 ± 62%  interrupts.CPU64.RES:Rescheduling_interrupts
      0.80 ± 93%    -100.0%       0.00        interrupts.CPU64.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU65.74:PCI-MSI.12589056-edge.eth3
      1150 ± 43%     -52.1%     551.00 ± 47%  interrupts.CPU65.CAL:Function_call_interrupts
     45.40 ± 67%     -55.9%      20.00 ±  4%  interrupts.CPU65.IWI:IRQ_work_interrupts
    105239            -0.0%     105223        interrupts.CPU65.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU65.MCP:Machine_check_polls
     35937 ±  5%     +11.7%      40147 ±  2%  interrupts.CPU65.NMI:Non-maskable_interrupts
     35937 ±  5%     +11.7%      40147 ±  2%  interrupts.CPU65.PMI:Performance_monitoring_interrupts
     48.80 ± 33%     -44.0%      27.33 ± 45%  interrupts.CPU65.RES:Rescheduling_interrupts
      0.20 ±200%   +1233.3%       2.67 ±141%  interrupts.CPU65.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU66.391:PCI-MSI.69206041-edge.nvme1q25
      1189 ±161%     -91.2%     104.33 ± 10%  interrupts.CPU66.75:PCI-MSI.12589057-edge.eth3-TxRx-0
      1151 ± 42%     -50.3%     572.00 ± 46%  interrupts.CPU66.CAL:Function_call_interrupts
     59.00 ± 60%     -50.8%      29.00 ± 36%  interrupts.CPU66.IWI:IRQ_work_interrupts
    106152            -0.5%     105648        interrupts.CPU66.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU66.MCP:Machine_check_polls
     38444 ± 10%      +8.2%      41610 ±  2%  interrupts.CPU66.NMI:Non-maskable_interrupts
     38444 ± 10%      +8.2%      41610 ±  2%  interrupts.CPU66.PMI:Performance_monitoring_interrupts
     62.80 ± 27%     -30.5%      43.67 ± 54%  interrupts.CPU66.RES:Rescheduling_interrupts
      0.40 ±200%     +66.7%       0.67 ±141%  interrupts.CPU66.TLB:TLB_shootdowns
      1628 ±187%     -94.1%      96.33 ± 24%  interrupts.CPU67.76:PCI-MSI.12589058-edge.eth3-TxRx-1
      1176 ± 43%     -52.4%     560.33 ± 47%  interrupts.CPU67.CAL:Function_call_interrupts
     32.40 ± 46%     -35.2%      21.00        interrupts.CPU67.IWI:IRQ_work_interrupts
    106022            -0.3%     105733        interrupts.CPU67.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU67.MCP:Machine_check_polls
     35901 ±  5%     +14.3%      41043        interrupts.CPU67.NMI:Non-maskable_interrupts
     35901 ±  5%     +14.3%      41043        interrupts.CPU67.PMI:Performance_monitoring_interrupts
     57.80 ± 49%     -29.1%      41.00 ± 50%  interrupts.CPU67.RES:Rescheduling_interrupts
    568.60 ±199%    -100.0%       0.00        interrupts.CPU67.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU68.392:PCI-MSI.69206042-edge.nvme1q26
      3389 ±194%     -93.4%     223.00 ± 95%  interrupts.CPU68.77:PCI-MSI.12589059-edge.eth3-TxRx-2
      1172 ± 43%     -53.0%     550.33 ± 47%  interrupts.CPU68.CAL:Function_call_interrupts
     60.60 ± 42%     -70.8%      17.67 ±  2%  interrupts.CPU68.IWI:IRQ_work_interrupts
    107459            -2.8%     104481        interrupts.CPU68.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU68.MCP:Machine_check_polls
     35334 ±  5%      +5.6%      37302        interrupts.CPU68.NMI:Non-maskable_interrupts
     35334 ±  5%      +5.6%      37302        interrupts.CPU68.PMI:Performance_monitoring_interrupts
     65.20 ± 54%     -52.5%      31.00 ± 54%  interrupts.CPU68.RES:Rescheduling_interrupts
      0.80 ± 93%    -100.0%       0.00        interrupts.CPU68.TLB:TLB_shootdowns
    432.80 ±120%     -74.7%     109.67 ± 18%  interrupts.CPU69.78:PCI-MSI.12589060-edge.eth3-TxRx-3
      1159 ± 43%     -53.1%     543.67 ± 47%  interrupts.CPU69.CAL:Function_call_interrupts
     24.20 ±  3%     +21.2%      29.33 ± 29%  interrupts.CPU69.IWI:IRQ_work_interrupts
    106381            -1.6%     104721        interrupts.CPU69.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU69.MCP:Machine_check_polls
     38373            +6.5%      40885        interrupts.CPU69.NMI:Non-maskable_interrupts
     38373            +6.5%      40885        interrupts.CPU69.PMI:Performance_monitoring_interrupts
     59.20 ± 74%     -41.4%      34.67 ± 56%  interrupts.CPU69.RES:Rescheduling_interrupts
      0.40 ±122%    -100.0%       0.00        interrupts.CPU69.TLB:TLB_shootdowns
      1157 ± 42%     -45.4%     632.00 ± 50%  interrupts.CPU7.CAL:Function_call_interrupts
     48.40 ± 61%     -55.2%      21.67 ±  2%  interrupts.CPU7.IWI:IRQ_work_interrupts
    105610 ±  2%      -0.9%     104711        interrupts.CPU7.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU7.MCP:Machine_check_polls
     36345 ±  4%     +13.3%      41174        interrupts.CPU7.NMI:Non-maskable_interrupts
     36345 ±  4%     +13.3%      41174        interrupts.CPU7.PMI:Performance_monitoring_interrupts
     70.80 ± 74%     -15.7%      59.67 ± 41%  interrupts.CPU7.RES:Rescheduling_interrupts
      0.20 ±200%   +1233.3%       2.67 ±141%  interrupts.CPU7.TLB:TLB_shootdowns
    502.60 ±167%     +21.2%     609.00 ±120%  interrupts.CPU70.79:PCI-MSI.12589061-edge.eth3-TxRx-4
      1142 ± 43%     -51.8%     550.67 ± 46%  interrupts.CPU70.CAL:Function_call_interrupts
     46.20 ± 67%     -56.0%      20.33 ±  8%  interrupts.CPU70.IWI:IRQ_work_interrupts
    105503 ±  2%      -0.5%     105005        interrupts.CPU70.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU70.MCP:Machine_check_polls
     37743 ±  4%      +5.7%      39879 ±  4%  interrupts.CPU70.NMI:Non-maskable_interrupts
     37743 ±  4%      +5.7%      39879 ±  4%  interrupts.CPU70.PMI:Performance_monitoring_interrupts
     48.80 ± 45%     -18.0%      40.00 ± 72%  interrupts.CPU70.RES:Rescheduling_interrupts
      0.60 ±133%     -44.4%       0.33 ±141%  interrupts.CPU70.TLB:TLB_shootdowns
    241.60 ± 72%    +662.3%       1841 ±100%  interrupts.CPU71.80:PCI-MSI.12589062-edge.eth3-TxRx-5
      1174 ± 41%     -52.7%     555.33 ± 46%  interrupts.CPU71.CAL:Function_call_interrupts
     48.00 ± 61%     -34.7%      31.33 ± 27%  interrupts.CPU71.IWI:IRQ_work_interrupts
    105211            -0.3%     104865        interrupts.CPU71.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU71.MCP:Machine_check_polls
     36912 ±  6%     +11.3%      41085        interrupts.CPU71.NMI:Non-maskable_interrupts
     36912 ±  6%     +11.3%      41085        interrupts.CPU71.PMI:Performance_monitoring_interrupts
     43.60 ± 65%     -36.5%      27.67 ± 44%  interrupts.CPU71.RES:Rescheduling_interrupts
      0.80 ± 93%     -58.3%       0.33 ±141%  interrupts.CPU71.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU72.398:PCI-MSI.68681729-edge.nvme0q1
      0.00          -100.0%       0.00        interrupts.CPU72.398:PCI-MSI.69206017-edge.nvme1q1
      1281 ± 34%     -54.2%     586.33 ± 44%  interrupts.CPU72.CAL:Function_call_interrupts
     38.00 ± 49%     -37.7%      23.67 ± 15%  interrupts.CPU72.IWI:IRQ_work_interrupts
    104488            -0.4%     104077        interrupts.CPU72.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU72.MCP:Machine_check_polls
     36746 ±  7%     +11.6%      41024        interrupts.CPU72.NMI:Non-maskable_interrupts
     36746 ±  7%     +11.6%      41024        interrupts.CPU72.PMI:Performance_monitoring_interrupts
    228.40 ±102%     -82.8%      39.33 ± 30%  interrupts.CPU72.RES:Rescheduling_interrupts
      0.80 ±122%    -100.0%       0.00        interrupts.CPU72.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU73.367:PCI-MSI.68681729-edge.nvme0q1
      0.00          -100.0%       0.00        interrupts.CPU73.367:PCI-MSI.69206017-edge.nvme1q1
      1294 ± 37%     -51.4%     629.00 ± 42%  interrupts.CPU73.CAL:Function_call_interrupts
     29.80 ± 40%      +4.0%      31.00 ± 35%  interrupts.CPU73.IWI:IRQ_work_interrupts
    106119 ±  2%      -1.7%     104362        interrupts.CPU73.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU73.MCP:Machine_check_polls
     38003 ±  5%      +7.7%      40939        interrupts.CPU73.NMI:Non-maskable_interrupts
     38003 ±  5%      +7.7%      40939        interrupts.CPU73.PMI:Performance_monitoring_interrupts
     75.40 ± 29%      -3.6%      72.67 ± 28%  interrupts.CPU73.RES:Rescheduling_interrupts
      0.60 ±133%    -100.0%       0.00        interrupts.CPU73.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU74.399:PCI-MSI.68681730-edge.nvme0q2
      0.00          -100.0%       0.00        interrupts.CPU74.399:PCI-MSI.69206018-edge.nvme1q2
      1228 ± 42%     -48.3%     635.33 ± 40%  interrupts.CPU74.CAL:Function_call_interrupts
     61.00 ± 54%     -53.6%      28.33 ± 34%  interrupts.CPU74.IWI:IRQ_work_interrupts
    106208            -2.4%     103690        interrupts.CPU74.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU74.MCP:Machine_check_polls
     38616 ±  3%      +5.6%      40768        interrupts.CPU74.NMI:Non-maskable_interrupts
     38616 ±  3%      +5.6%      40768        interrupts.CPU74.PMI:Performance_monitoring_interrupts
    111.60 ± 73%     -51.6%      54.00 ± 50%  interrupts.CPU74.RES:Rescheduling_interrupts
     86.80 ±198%     -99.6%       0.33 ±141%  interrupts.CPU74.TLB:TLB_shootdowns
      1168 ± 41%     -46.2%     629.00 ± 41%  interrupts.CPU75.CAL:Function_call_interrupts
     53.40 ± 47%     -42.6%      30.67 ± 22%  interrupts.CPU75.IWI:IRQ_work_interrupts
    106626            -1.9%     104620        interrupts.CPU75.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU75.MCP:Machine_check_polls
     38362 ±  2%      +7.0%      41048        interrupts.CPU75.NMI:Non-maskable_interrupts
     38362 ±  2%      +7.0%      41048        interrupts.CPU75.PMI:Performance_monitoring_interrupts
     68.60 ± 41%     -23.7%      52.33 ± 36%  interrupts.CPU75.RES:Rescheduling_interrupts
      0.60 ±133%    -100.0%       0.00        interrupts.CPU75.TLB:TLB_shootdowns
      1129 ± 43%     -44.0%     633.00 ± 31%  interrupts.CPU76.CAL:Function_call_interrupts
     37.60 ± 51%      -7.8%      34.67 ± 29%  interrupts.CPU76.IWI:IRQ_work_interrupts
    106500            -2.2%     104158        interrupts.CPU76.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU76.MCP:Machine_check_polls
     34992 ±  9%     +16.9%      40889        interrupts.CPU76.NMI:Non-maskable_interrupts
     34992 ±  9%     +16.9%      40889        interrupts.CPU76.PMI:Performance_monitoring_interrupts
     45.20 ± 38%     -24.0%      34.33 ±  9%  interrupts.CPU76.RES:Rescheduling_interrupts
      0.80 ± 93%     -58.3%       0.33 ±141%  interrupts.CPU76.TLB:TLB_shootdowns
      1146 ± 42%     -44.8%     633.00 ± 46%  interrupts.CPU77.CAL:Function_call_interrupts
     49.40 ± 31%     -56.1%      21.67 ±  2%  interrupts.CPU77.IWI:IRQ_work_interrupts
    106334            -1.7%     104531        interrupts.CPU77.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU77.MCP:Machine_check_polls
     37297 ±  2%      +7.7%      40176        interrupts.CPU77.NMI:Non-maskable_interrupts
     37297 ±  2%      +7.7%      40176        interrupts.CPU77.PMI:Performance_monitoring_interrupts
     33.00 ± 33%     +37.4%      45.33 ± 55%  interrupts.CPU77.RES:Rescheduling_interrupts
      0.80 ± 50%    -100.0%       0.00        interrupts.CPU77.TLB:TLB_shootdowns
      1140 ± 43%     -49.4%     577.33 ± 45%  interrupts.CPU78.CAL:Function_call_interrupts
     23.40 ±  6%     +55.3%      36.33 ± 24%  interrupts.CPU78.IWI:IRQ_work_interrupts
    106173            -2.4%     103635        interrupts.CPU78.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU78.MCP:Machine_check_polls
     36301 ±  6%     +12.8%      40936        interrupts.CPU78.NMI:Non-maskable_interrupts
     36301 ±  6%     +12.8%      40936        interrupts.CPU78.PMI:Performance_monitoring_interrupts
     42.80 ± 33%     -11.2%      38.00 ± 57%  interrupts.CPU78.RES:Rescheduling_interrupts
      0.80 ± 93%    -100.0%       0.00        interrupts.CPU78.TLB:TLB_shootdowns
      1163 ± 43%     -51.3%     567.00 ± 46%  interrupts.CPU79.CAL:Function_call_interrupts
     45.20 ± 43%     -45.4%      24.67 ± 11%  interrupts.CPU79.IWI:IRQ_work_interrupts
    105861            -1.4%     104332        interrupts.CPU79.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU79.MCP:Machine_check_polls
     35532 ±  4%     +17.1%      41611 ±  3%  interrupts.CPU79.NMI:Non-maskable_interrupts
     35532 ±  4%     +17.1%      41611 ±  3%  interrupts.CPU79.PMI:Performance_monitoring_interrupts
     62.40 ± 66%     -43.4%      35.33 ± 22%  interrupts.CPU79.RES:Rescheduling_interrupts
      1.00 ± 63%     -66.7%       0.33 ±141%  interrupts.CPU79.TLB:TLB_shootdowns
      1145 ± 43%     -17.6%     943.33 ± 76%  interrupts.CPU8.CAL:Function_call_interrupts
     44.80 ± 43%     -52.4%      21.33 ±  9%  interrupts.CPU8.IWI:IRQ_work_interrupts
    106298            -1.6%     104562        interrupts.CPU8.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU8.MCP:Machine_check_polls
     36034 ±  3%     +11.6%      40213        interrupts.CPU8.NMI:Non-maskable_interrupts
     36034 ±  3%     +11.6%      40213        interrupts.CPU8.PMI:Performance_monitoring_interrupts
     45.20 ± 50%     -15.2%      38.33 ± 71%  interrupts.CPU8.RES:Rescheduling_interrupts
      0.60 ±200%    +177.8%       1.67 ±141%  interrupts.CPU8.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU80.371:PCI-MSI.69206021-edge.nvme1q5
      0.00          -100.0%       0.00        interrupts.CPU80.376:PCI-MSI.68681733-edge.nvme0q5
      1149 ± 43%     -47.1%     607.67 ± 34%  interrupts.CPU80.CAL:Function_call_interrupts
     21.80 ±  7%     +69.7%      37.00 ± 17%  interrupts.CPU80.IWI:IRQ_work_interrupts
    106798            -2.3%     104393        interrupts.CPU80.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU80.MCP:Machine_check_polls
     35077 ±  6%     +18.0%      41383        interrupts.CPU80.NMI:Non-maskable_interrupts
     35077 ±  6%     +18.0%      41383        interrupts.CPU80.PMI:Performance_monitoring_interrupts
     77.80 ±104%     -69.6%      23.67 ± 53%  interrupts.CPU80.RES:Rescheduling_interrupts
      5.40 ±163%     -93.8%       0.33 ±141%  interrupts.CPU80.TLB:TLB_shootdowns
      1140 ± 43%     -46.9%     605.00 ± 33%  interrupts.CPU81.CAL:Function_call_interrupts
     39.20 ± 80%      +8.0%      42.33 ±  6%  interrupts.CPU81.IWI:IRQ_work_interrupts
    105037            -1.9%     103020        interrupts.CPU81.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU81.MCP:Machine_check_polls
     37562 ±  8%     +11.1%      41714 ±  2%  interrupts.CPU81.NMI:Non-maskable_interrupts
     37562 ±  8%     +11.1%      41714 ±  2%  interrupts.CPU81.PMI:Performance_monitoring_interrupts
     43.60 ± 61%     -40.4%      26.00 ± 21%  interrupts.CPU81.RES:Rescheduling_interrupts
      7.80 ±181%     -95.7%       0.33 ±141%  interrupts.CPU81.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU82.372:PCI-MSI.69206022-edge.nvme1q6
      1162 ± 42%     -45.8%     630.00 ± 52%  interrupts.CPU82.CAL:Function_call_interrupts
     47.20 ± 64%     -39.3%      28.67 ± 35%  interrupts.CPU82.IWI:IRQ_work_interrupts
    106938            -2.3%     104486        interrupts.CPU82.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU82.MCP:Machine_check_polls
     37757 ±  6%      +9.0%      41157 ±  3%  interrupts.CPU82.NMI:Non-maskable_interrupts
     37757 ±  6%      +9.0%      41157 ±  3%  interrupts.CPU82.PMI:Performance_monitoring_interrupts
     55.80 ± 82%     -34.3%      36.67 ± 49%  interrupts.CPU82.RES:Rescheduling_interrupts
      1.80 ± 41%     -81.5%       0.33 ±141%  interrupts.CPU82.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU83.379:PCI-MSI.69206029-edge.nvme1q13
      1182 ± 44%     -47.4%     622.00 ± 42%  interrupts.CPU83.CAL:Function_call_interrupts
     37.80 ± 52%      -1.2%      37.33 ± 27%  interrupts.CPU83.IWI:IRQ_work_interrupts
    105482            -0.7%     104697        interrupts.CPU83.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU83.MCP:Machine_check_polls
     34286 ±  4%     +20.7%      41384        interrupts.CPU83.NMI:Non-maskable_interrupts
     34286 ±  4%     +20.7%      41384        interrupts.CPU83.PMI:Performance_monitoring_interrupts
     47.60 ± 69%     -24.4%      36.00 ± 45%  interrupts.CPU83.RES:Rescheduling_interrupts
      3.60 ±147%      -7.4%       3.33 ± 86%  interrupts.CPU83.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU84.373:PCI-MSI.68681735-edge.nvme0q7
      1185 ± 41%     -53.1%     556.00 ± 48%  interrupts.CPU84.CAL:Function_call_interrupts
     45.00 ± 68%     -34.8%      29.33 ± 33%  interrupts.CPU84.IWI:IRQ_work_interrupts
    106133            -1.3%     104799        interrupts.CPU84.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU84.MCP:Machine_check_polls
     35125 ±  7%     +17.1%      41123        interrupts.CPU84.NMI:Non-maskable_interrupts
     35125 ±  7%     +17.1%      41123        interrupts.CPU84.PMI:Performance_monitoring_interrupts
     49.80 ± 56%     -66.5%      16.67 ± 37%  interrupts.CPU84.RES:Rescheduling_interrupts
      0.60 ±133%     +66.7%       1.00 ±141%  interrupts.CPU84.TLB:TLB_shootdowns
      1150 ± 44%     -47.8%     600.33 ± 50%  interrupts.CPU85.CAL:Function_call_interrupts
     38.60 ± 79%     -46.5%      20.67 ±  2%  interrupts.CPU85.IWI:IRQ_work_interrupts
    106438            -2.0%     104319        interrupts.CPU85.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU85.MCP:Machine_check_polls
     37591 ±  6%      +9.0%      40969        interrupts.CPU85.NMI:Non-maskable_interrupts
     37591 ±  6%      +9.0%      40969        interrupts.CPU85.PMI:Performance_monitoring_interrupts
     45.60 ± 34%     +33.8%      61.00 ± 30%  interrupts.CPU85.RES:Rescheduling_interrupts
      1.00 ± 63%     +33.3%       1.33 ± 93%  interrupts.CPU85.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU86.374:PCI-MSI.69206024-edge.nvme1q8
      1184 ± 43%     -45.9%     641.00 ± 51%  interrupts.CPU86.CAL:Function_call_interrupts
     23.40 ±  8%     +56.7%      36.67 ± 26%  interrupts.CPU86.IWI:IRQ_work_interrupts
    104643            -1.6%     103010        interrupts.CPU86.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU86.MCP:Machine_check_polls
     36619 ±  7%     +12.2%      41099        interrupts.CPU86.NMI:Non-maskable_interrupts
     36619 ±  7%     +12.2%      41099        interrupts.CPU86.PMI:Performance_monitoring_interrupts
     96.20 ± 69%     -55.0%      43.33 ± 38%  interrupts.CPU86.RES:Rescheduling_interrupts
      0.80 ± 93%     -58.3%       0.33 ±141%  interrupts.CPU86.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU87.411:PCI-MSI.68681742-edge.nvme0q14
      1161 ± 43%     -45.8%     629.67 ± 51%  interrupts.CPU87.CAL:Function_call_interrupts
     38.40 ± 79%     -45.3%      21.00 ±  3%  interrupts.CPU87.IWI:IRQ_work_interrupts
    105294            -0.4%     104894        interrupts.CPU87.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU87.MCP:Machine_check_polls
     36854 ±  8%     +11.0%      40894 ±  2%  interrupts.CPU87.NMI:Non-maskable_interrupts
     36854 ±  8%     +11.0%      40894 ±  2%  interrupts.CPU87.PMI:Performance_monitoring_interrupts
     93.60 ± 62%     -76.9%      21.67 ± 30%  interrupts.CPU87.RES:Rescheduling_interrupts
     13.60 ±192%     -85.3%       2.00 ±108%  interrupts.CPU87.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU88.375:PCI-MSI.69206025-edge.nvme1q9
      1178 ± 43%     -51.6%     569.67 ± 48%  interrupts.CPU88.CAL:Function_call_interrupts
     56.80 ± 56%     -41.9%      33.00 ± 13%  interrupts.CPU88.IWI:IRQ_work_interrupts
    105543            -1.2%     104283        interrupts.CPU88.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU88.MCP:Machine_check_polls
     36893 ±  6%     +11.8%      41248        interrupts.CPU88.NMI:Non-maskable_interrupts
     36893 ±  6%     +11.8%      41248        interrupts.CPU88.PMI:Performance_monitoring_interrupts
     68.60 ± 66%     -44.1%      38.33 ± 19%  interrupts.CPU88.RES:Rescheduling_interrupts
      0.80 ± 93%     +25.0%       1.00        interrupts.CPU88.TLB:TLB_shootdowns
      1228 ± 35%     -54.7%     557.00 ± 47%  interrupts.CPU89.CAL:Function_call_interrupts
     38.20 ± 53%      -9.2%      34.67 ± 23%  interrupts.CPU89.IWI:IRQ_work_interrupts
    105435            -2.6%     102696        interrupts.CPU89.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU89.MCP:Machine_check_polls
     36102 ± 10%     +15.0%      41527 ±  2%  interrupts.CPU89.NMI:Non-maskable_interrupts
     36102 ± 10%     +15.0%      41527 ±  2%  interrupts.CPU89.PMI:Performance_monitoring_interrupts
     92.80 ± 48%     -70.9%      27.00 ± 42%  interrupts.CPU89.RES:Rescheduling_interrupts
    129.40 ±198%     -99.2%       1.00        interrupts.CPU89.TLB:TLB_shootdowns
      1172 ± 41%     -42.2%     677.67 ± 35%  interrupts.CPU9.CAL:Function_call_interrupts
     68.00 ± 42%     -57.8%      28.67 ± 40%  interrupts.CPU9.IWI:IRQ_work_interrupts
    106676            -2.3%     104256        interrupts.CPU9.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU9.MCP:Machine_check_polls
     38201 ±  2%      +6.9%      40850 ±  2%  interrupts.CPU9.NMI:Non-maskable_interrupts
     38201 ±  2%      +6.9%      40850 ±  2%  interrupts.CPU9.PMI:Performance_monitoring_interrupts
     73.00 ± 32%      -0.5%      72.67 ± 43%  interrupts.CPU9.RES:Rescheduling_interrupts
      0.20 ±200%   +1900.0%       4.00 ±141%  interrupts.CPU9.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU90.376:PCI-MSI.68681738-edge.nvme0q10
      1178 ± 44%     -52.5%     559.33 ± 49%  interrupts.CPU90.CAL:Function_call_interrupts
     30.20 ± 53%      +1.5%      30.67 ± 30%  interrupts.CPU90.IWI:IRQ_work_interrupts
    103590            +0.1%     103729        interrupts.CPU90.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU90.MCP:Machine_check_polls
     36362 ±  8%     +13.2%      41148        interrupts.CPU90.NMI:Non-maskable_interrupts
     36362 ±  8%     +13.2%      41148        interrupts.CPU90.PMI:Performance_monitoring_interrupts
     51.40 ± 51%     -48.8%      26.33 ± 51%  interrupts.CPU90.RES:Rescheduling_interrupts
      1.40 ±106%     -28.6%       1.00        interrupts.CPU90.TLB:TLB_shootdowns
      1124 ± 43%     -46.9%     597.67 ± 50%  interrupts.CPU91.CAL:Function_call_interrupts
     38.00 ± 51%      +0.0%      38.00 ± 22%  interrupts.CPU91.IWI:IRQ_work_interrupts
    106425 ±  2%      -1.8%     104491        interrupts.CPU91.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU91.MCP:Machine_check_polls
     36002 ±  5%     +15.3%      41517 ±  2%  interrupts.CPU91.NMI:Non-maskable_interrupts
     36002 ±  5%     +15.3%      41517 ±  2%  interrupts.CPU91.PMI:Performance_monitoring_interrupts
     77.80 ± 59%     -33.6%      51.67 ± 43%  interrupts.CPU91.RES:Rescheduling_interrupts
      0.40 ±122%   +1650.0%       7.00 ±112%  interrupts.CPU91.TLB:TLB_shootdowns
      1166 ± 41%     -48.7%     598.00 ± 39%  interrupts.CPU92.CAL:Function_call_interrupts
     31.00 ± 50%      +4.3%      32.33 ± 27%  interrupts.CPU92.IWI:IRQ_work_interrupts
    105500            -1.5%     103918        interrupts.CPU92.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU92.MCP:Machine_check_polls
     37063 ±  8%     +12.1%      41532 ±  3%  interrupts.CPU92.NMI:Non-maskable_interrupts
     37063 ±  8%     +12.1%      41532 ±  3%  interrupts.CPU92.PMI:Performance_monitoring_interrupts
     61.60 ± 35%     -48.1%      32.00 ± 73%  interrupts.CPU92.RES:Rescheduling_interrupts
      1.00 ±109%     +33.3%       1.33 ± 35%  interrupts.CPU92.TLB:TLB_shootdowns
      1178 ± 44%     -51.8%     568.00 ± 46%  interrupts.CPU93.CAL:Function_call_interrupts
     70.80 ± 40%     -68.9%      22.00 ±  7%  interrupts.CPU93.IWI:IRQ_work_interrupts
    104633            -0.5%     104066        interrupts.CPU93.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU93.MCP:Machine_check_polls
     38032 ±  2%      +7.7%      40967 ±  2%  interrupts.CPU93.NMI:Non-maskable_interrupts
     38032 ±  2%      +7.7%      40967 ±  2%  interrupts.CPU93.PMI:Performance_monitoring_interrupts
     82.60 ± 62%     -65.7%      28.33 ± 11%  interrupts.CPU93.RES:Rescheduling_interrupts
      1.00           -66.7%       0.33 ±141%  interrupts.CPU93.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU94.378:PCI-MSI.68681740-edge.nvme0q12
      0.00          -100.0%       0.00        interrupts.CPU94.378:PCI-MSI.69206028-edge.nvme1q12
      1170 ± 43%     -47.3%     617.33 ± 45%  interrupts.CPU94.CAL:Function_call_interrupts
     29.40 ± 55%     +14.5%      33.67 ± 25%  interrupts.CPU94.IWI:IRQ_work_interrupts
    105992            -2.5%     103340        interrupts.CPU94.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU94.MCP:Machine_check_polls
     34659 ±  5%     +19.5%      41429 ±  2%  interrupts.CPU94.NMI:Non-maskable_interrupts
     34659 ±  5%     +19.5%      41429 ±  2%  interrupts.CPU94.PMI:Performance_monitoring_interrupts
     69.80 ± 54%     -65.1%      24.33 ± 10%  interrupts.CPU94.RES:Rescheduling_interrupts
      1.20 ± 62%     -44.4%       0.67 ± 70%  interrupts.CPU94.TLB:TLB_shootdowns
      0.00          -100.0%       0.00        interrupts.CPU95.381:PCI-MSI.69206031-edge.nvme1q15
      1255 ± 38%     -51.1%     613.33 ± 40%  interrupts.CPU95.CAL:Function_call_interrupts
     35.80 ± 38%      +0.6%      36.00 ± 27%  interrupts.CPU95.IWI:IRQ_work_interrupts
    106774            -2.7%     103921        interrupts.CPU95.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.CPU95.MCP:Machine_check_polls
     42106 ±  9%      -1.4%      41536        interrupts.CPU95.NMI:Non-maskable_interrupts
     42106 ±  9%      -1.4%      41536        interrupts.CPU95.PMI:Performance_monitoring_interrupts
    181.80 ± 39%     -60.0%      72.67 ± 16%  interrupts.CPU95.RES:Rescheduling_interrupts
      7.40 ± 13%     -23.4%       5.67 ± 29%  interrupts.CPU95.TLB:TLB_shootdowns
      4228 ±  4%     -33.5%       2813 ±  2%  interrupts.IWI:IRQ_work_interrupts
  10161513            -1.4%   10021491        interrupts.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00        interrupts.MCP:Machine_check_polls
   3501659           +12.0%    3922994        interrupts.NMI:Non-maskable_interrupts
   3501659           +12.0%    3922994        interrupts.PMI:Performance_monitoring_interrupts
      7870 ± 19%     -34.8%       5128 ±  9%  interrupts.RES:Rescheduling_interrupts
      0.00          -100.0%       0.00        interrupts.RTR:APIC_ICR_read_retries
      1317 ±130%     -77.8%     292.67 ± 12%  interrupts.TLB:TLB_shootdowns
     43.97 ± 12%     -43.8        0.20 ±141%  perf-profile.calltrace.cycles-pp.ksys_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe
     43.89 ± 12%     -43.7        0.20 ±141%  perf-profile.calltrace.cycles-pp.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe
     42.03 ± 14%     -42.0        0.00        perf-profile.calltrace.cycles-pp.__mm_populate.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe
     41.95 ± 14%     -42.0        0.00        perf-profile.calltrace.cycles-pp.populate_vma_page_range.__mm_populate.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64
     41.95 ± 14%     -42.0        0.00        perf-profile.calltrace.cycles-pp.__get_user_pages.populate_vma_page_range.__mm_populate.vm_mmap_pgoff.ksys_mmap_pgoff
     41.60 ± 14%     -41.6        0.00        perf-profile.calltrace.cycles-pp.follow_page_pte.__get_user_pages.populate_vma_page_range.__mm_populate.vm_mmap_pgoff
     49.03 ±  7%     -40.1        8.92 ± 13%  perf-profile.calltrace.cycles-pp.__x64_sys_munmap.do_syscall_64.entry_SYSCALL_64_after_hwframe
     49.00 ±  7%     -40.1        8.89 ± 14%  perf-profile.calltrace.cycles-pp.__vm_munmap.__x64_sys_munmap.do_syscall_64.entry_SYSCALL_64_after_hwframe
     48.85 ±  7%     -40.0        8.81 ± 14%  perf-profile.calltrace.cycles-pp.__do_munmap.__vm_munmap.__x64_sys_munmap.do_syscall_64.entry_SYSCALL_64_after_hwframe
     27.05 ±  9%     -25.3        1.71 ± 44%  perf-profile.calltrace.cycles-pp.__munlock_pagevec.munlock_vma_pages_range.__do_munmap.__vm_munmap.__x64_sys_munmap
     27.29 ±  9%     -25.3        1.98 ± 39%  perf-profile.calltrace.cycles-pp.munlock_vma_pages_range.__do_munmap.__vm_munmap.__x64_sys_munmap.do_syscall_64
     23.70 ± 16%     -23.7        0.00        perf-profile.calltrace.cycles-pp.lru_add_drain.follow_page_pte.__get_user_pages.populate_vma_page_range.__mm_populate
     17.65 ± 11%     -17.6        0.00        perf-profile.calltrace.cycles-pp.lru_add_drain_cpu.lru_add_drain.follow_page_pte.__get_user_pages.populate_vma_page_range
     17.64 ± 11%     -17.6        0.00        perf-profile.calltrace.cycles-pp.pagevec_lru_move_fn.lru_add_drain_cpu.lru_add_drain.follow_page_pte.__get_user_pages
     17.56 ± 11%     -17.6        0.00        perf-profile.calltrace.cycles-pp.mlock_vma_page.follow_page_pte.__get_user_pages.populate_vma_page_range.__mm_populate
     17.53 ± 11%     -17.5        0.00        perf-profile.calltrace.cycles-pp.isolate_lru_page.mlock_vma_page.follow_page_pte.__get_user_pages.populate_vma_page_range
     17.26 ± 11%     -17.3        0.00        perf-profile.calltrace.cycles-pp._raw_spin_lock_irq.isolate_lru_page.mlock_vma_page.follow_page_pte.__get_user_pages
     17.18 ± 11%     -17.2        0.00        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irq.isolate_lru_page.mlock_vma_page.follow_page_pte
     17.12 ± 11%     -17.1        0.00        perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.pagevec_lru_move_fn.lru_add_drain_cpu.lru_add_drain.follow_page_pte
     17.02 ± 11%     -17.0        0.00        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.pagevec_lru_move_fn.lru_add_drain_cpu.lru_add_drain
     17.27 ±  6%     -13.6        3.65 ± 15%  perf-profile.calltrace.cycles-pp.unmap_region.__do_munmap.__vm_munmap.__x64_sys_munmap.do_syscall_64
     16.45 ±  6%     -13.4        3.09 ± 18%  perf-profile.calltrace.cycles-pp.unmap_vmas.unmap_region.__do_munmap.__vm_munmap.__x64_sys_munmap
     16.21 ±  5%     -13.3        2.87 ± 20%  perf-profile.calltrace.cycles-pp.zap_pte_range.unmap_page_range.unmap_vmas.unmap_region.__do_munmap
     16.36 ±  5%     -13.3        3.04 ± 19%  perf-profile.calltrace.cycles-pp.unmap_page_range.unmap_vmas.unmap_region.__do_munmap.__vm_munmap
     13.84 ±  3%     -13.0        0.87 ± 78%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.pagevec_lru_move_fn.lru_add_drain.free_pages_and_swap_cache.tlb_flush_mmu
     13.75 ±  3%     -13.0        0.80 ± 79%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.pagevec_lru_move_fn.lru_add_drain.free_pages_and_swap_cache
     13.58 ±  9%     -12.9        0.70 ± 80%  perf-profile.calltrace.cycles-pp.pagevec_lru_move_fn.__munlock_pagevec.munlock_vma_pages_range.__do_munmap.__vm_munmap
     14.59 ±  4%     -12.9        1.72 ± 34%  perf-profile.calltrace.cycles-pp.tlb_flush_mmu.zap_pte_range.unmap_page_range.unmap_vmas.unmap_region
     13.19 ±  9%     -12.8        0.35 ±141%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.pagevec_lru_move_fn.__munlock_pagevec.munlock_vma_pages_range.__do_munmap
     14.46 ±  4%     -12.8        1.65 ± 36%  perf-profile.calltrace.cycles-pp.free_pages_and_swap_cache.tlb_flush_mmu.zap_pte_range.unmap_page_range.unmap_vmas
     14.42 ±  4%     -12.8        1.63 ± 37%  perf-profile.calltrace.cycles-pp.lru_add_drain.free_pages_and_swap_cache.tlb_flush_mmu.zap_pte_range.unmap_page_range
     13.13 ±  9%     -12.8        0.34 ±141%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.pagevec_lru_move_fn.__munlock_pagevec.munlock_vma_pages_range
     13.14 ±  8%     -12.8        0.36 ±141%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irq.__munlock_pagevec.munlock_vma_pages_range.__do_munmap.__vm_munmap
     14.39 ±  3%     -12.8        1.61 ± 37%  perf-profile.calltrace.cycles-pp.pagevec_lru_move_fn.lru_add_drain.free_pages_and_swap_cache.tlb_flush_mmu.zap_pte_range
     13.06 ±  8%     -12.7        0.33 ±141%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irq.__munlock_pagevec.munlock_vma_pages_range.__do_munmap
      6.06 ± 33%      -6.1        0.00        perf-profile.calltrace.cycles-pp.pagevec_lru_move_fn.lru_add_drain.follow_page_pte.__get_user_pages.populate_vma_page_range
      5.85 ± 33%      -5.8        0.00        perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.pagevec_lru_move_fn.lru_add_drain.follow_page_pte.__get_user_pages
      5.82 ± 33%      -5.8        0.00        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.pagevec_lru_move_fn.lru_add_drain.follow_page_pte
      1.69 ± 32%      -1.7        0.00        perf-profile.calltrace.cycles-pp.do_mmap.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.60 ± 32%      -1.6        0.00        perf-profile.calltrace.cycles-pp.mmap_region.do_mmap.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64
      0.93 ± 33%      -0.9        0.00        perf-profile.calltrace.cycles-pp.asm_exc_page_fault
      0.92 ±125%      -0.9        0.00        perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.entry_SYSCALL_64_after_hwframe
      0.75 ± 24%      -0.8        0.00        perf-profile.calltrace.cycles-pp.exc_page_fault.asm_exc_page_fault
      0.73 ± 24%      -0.7        0.00        perf-profile.calltrace.cycles-pp.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      1.29 ± 25%      -0.6        0.74 ±  6%  perf-profile.calltrace.cycles-pp.remove_vma.__do_munmap.__vm_munmap.__x64_sys_munmap.do_syscall_64
      1.22 ± 25%      -0.5        0.70 ±  5%  perf-profile.calltrace.cycles-pp.kmem_cache_free.remove_vma.__do_munmap.__vm_munmap.__x64_sys_munmap
      1.65 ± 20%      -0.5        1.17 ±  5%  perf-profile.calltrace.cycles-pp.__split_vma.do_madvise.__x64_sys_madvise.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.45 ± 85%      -0.5        0.00        perf-profile.calltrace.cycles-pp.free_pgtables.unmap_region.__do_munmap.__vm_munmap.__x64_sys_munmap
      1.89 ± 20%      -0.4        1.44 ±  6%  perf-profile.calltrace.cycles-pp.__split_vma.__do_munmap.__vm_munmap.__x64_sys_munmap.do_syscall_64
      0.43 ± 84%      -0.4        0.00        perf-profile.calltrace.cycles-pp.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      0.35 ± 82%      -0.3        0.00        perf-profile.calltrace.cycles-pp.vm_area_dup.__split_vma.__do_munmap.__vm_munmap.__x64_sys_munmap
      0.30 ±122%      -0.3        0.00        perf-profile.calltrace.cycles-pp.unlink_file_vma.free_pgtables.unmap_region.__do_munmap.__vm_munmap
      0.27 ±122%      -0.3        0.00        perf-profile.calltrace.cycles-pp.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      0.23 ±122%      -0.2        0.00        perf-profile.calltrace.cycles-pp.do_fault.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault
      1.16 ± 20%      -0.2        0.93 ±  5%  perf-profile.calltrace.cycles-pp.__vma_adjust.__split_vma.do_madvise.__x64_sys_madvise.do_syscall_64
      0.21 ±122%      -0.2        0.00        perf-profile.calltrace.cycles-pp.find_vma.__do_munmap.__vm_munmap.__x64_sys_munmap.do_syscall_64
      0.21 ±122%      -0.2        0.00        perf-profile.calltrace.cycles-pp.flush_tlb_mm_range.zap_pte_range.unmap_page_range.unmap_vmas.unmap_region
      1.27 ± 20%      -0.2        1.09 ±  6%  perf-profile.calltrace.cycles-pp.__vma_adjust.__split_vma.__do_munmap.__vm_munmap.__x64_sys_munmap
      0.12 ±200%      -0.1        0.00        perf-profile.calltrace.cycles-pp.vma_link.mmap_region.do_mmap.vm_mmap_pgoff.ksys_mmap_pgoff
      0.10 ±200%      -0.1        0.00        perf-profile.calltrace.cycles-pp.vm_area_dup.__split_vma.do_madvise.__x64_sys_madvise.do_syscall_64
      0.10 ±200%      -0.1        0.00        perf-profile.calltrace.cycles-pp.vma_interval_tree_remove.unlink_file_vma.free_pgtables.unmap_region.__do_munmap
      0.00            +0.0        0.00        perf-profile.calltrace.cycles-pp.syscall
      0.00            +0.0        0.00        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.syscall
      0.00            +0.0        0.00        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.syscall
      0.00            +0.0        0.00        perf-profile.calltrace.cycles-pp.__do_sys_finit_module.do_syscall_64.entry_SYSCALL_64_after_hwframe.syscall
      0.00            +0.0        0.00        perf-profile.calltrace.cycles-pp.load_module.__do_sys_finit_module.do_syscall_64.entry_SYSCALL_64_after_hwframe.syscall
      0.00            +0.0        0.00        perf-profile.calltrace.cycles-pp.do_init_module.load_module.__do_sys_finit_module.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +0.0        0.00        perf-profile.calltrace.cycles-pp.do_one_initcall.do_init_module.load_module.__do_sys_finit_module.do_syscall_64
      0.00            +0.0        0.00        perf-profile.calltrace.cycles-pp.driver_register.do_one_initcall.do_init_module.load_module.__do_sys_finit_module
      0.00            +0.0        0.00        perf-profile.calltrace.cycles-pp.bus_add_driver.driver_register.do_one_initcall.do_init_module.load_module
      0.00            +0.0        0.00        perf-profile.calltrace.cycles-pp.bus_for_each_dev.bus_add_driver.driver_register.do_one_initcall.do_init_module
      0.00            +0.0        0.00        perf-profile.calltrace.cycles-pp.__driver_attach.bus_for_each_dev.bus_add_driver.driver_register.do_one_initcall
      0.00            +0.0        0.00        perf-profile.calltrace.cycles-pp.device_driver_attach.__driver_attach.bus_for_each_dev.bus_add_driver.driver_register
      0.00            +0.0        0.00        perf-profile.calltrace.cycles-pp.driver_probe_device.device_driver_attach.__driver_attach.bus_for_each_dev.bus_add_driver
      0.00            +0.0        0.00        perf-profile.calltrace.cycles-pp.really_probe.driver_probe_device.device_driver_attach.__driver_attach.bus_for_each_dev
      0.00            +0.0        0.00        perf-profile.calltrace.cycles-pp.nvdimm_bus_probe.really_probe.driver_probe_device.device_driver_attach.__driver_attach
      0.00            +0.0        0.00        perf-profile.calltrace.cycles-pp.dax_pmem_compat_probe.nvdimm_bus_probe.really_probe.driver_probe_device.device_driver_attach
      0.00            +0.0        0.00        perf-profile.calltrace.cycles-pp.dev_dax_probe.dax_pmem_compat_probe.nvdimm_bus_probe.really_probe.driver_probe_device
      0.00            +0.0        0.00        perf-profile.calltrace.cycles-pp.devm_memremap_pages.dev_dax_probe.dax_pmem_compat_probe.nvdimm_bus_probe.really_probe
      0.00            +0.0        0.00        perf-profile.calltrace.cycles-pp.memremap_pages.devm_memremap_pages.dev_dax_probe.dax_pmem_compat_probe.nvdimm_bus_probe
      0.00            +0.0        0.00        perf-profile.calltrace.cycles-pp.pagemap_range.memremap_pages.devm_memremap_pages.dev_dax_probe.dax_pmem_compat_probe
      0.00            +0.0        0.00        perf-profile.calltrace.cycles-pp.memmap_init_zone_device.pagemap_range.memremap_pages.devm_memremap_pages.dev_dax_probe
      0.00            +0.0        0.00        perf-profile.calltrace.cycles-pp.__libc_write
      0.00            +0.0        0.00        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__libc_write
      0.00            +0.0        0.00        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_write
      0.00            +0.0        0.00        perf-profile.calltrace.cycles-pp.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_write
      0.00            +0.0        0.00        perf-profile.calltrace.cycles-pp.new_sync_write.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +0.0        0.00        perf-profile.calltrace.cycles-pp.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_write
      0.00            +0.0        0.00        perf-profile.calltrace.cycles-pp.generic_file_write_iter.new_sync_write.vfs_write.ksys_write.do_syscall_64
      0.00            +0.0        0.00        perf-profile.calltrace.cycles-pp.__generic_file_write_iter.generic_file_write_iter.new_sync_write.vfs_write.ksys_write
      0.00            +0.0        0.00        perf-profile.calltrace.cycles-pp.generic_perform_write.__generic_file_write_iter.generic_file_write_iter.new_sync_write.vfs_write
      0.00            +0.0        0.00        perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt
      0.00            +0.0        0.00        perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      0.00            +0.0        0.00        perf-profile.calltrace.cycles-pp.ret_from_fork
      0.00            +0.0        0.00        perf-profile.calltrace.cycles-pp.kthread.ret_from_fork
      0.00            +0.0        0.00        perf-profile.calltrace.cycles-pp.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      0.00            +0.0        0.00        perf-profile.calltrace.cycles-pp.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      0.00            +0.0        0.00        perf-profile.calltrace.cycles-pp.worker_thread.kthread.ret_from_fork
      0.00            +0.0        0.00        perf-profile.calltrace.cycles-pp.process_one_work.worker_thread.kthread.ret_from_fork
      0.00            +0.0        0.00        perf-profile.calltrace.cycles-pp.drm_fb_helper_dirty_work.process_one_work.worker_thread.kthread.ret_from_fork
      0.00            +0.0        0.00        perf-profile.calltrace.cycles-pp.memcpy_erms.drm_fb_helper_dirty_work.process_one_work.worker_thread.kthread
      0.00            +0.0        0.00        perf-profile.calltrace.cycles-pp.iov_iter_copy_from_user_atomic.generic_perform_write.__generic_file_write_iter.generic_file_write_iter.new_sync_write
      0.00            +0.0        0.00        perf-profile.calltrace.cycles-pp.copyin.iov_iter_copy_from_user_atomic.generic_perform_write.__generic_file_write_iter.generic_file_write_iter
      0.00            +0.0        0.00        perf-profile.calltrace.cycles-pp.finished_loading.load_module.__do_sys_finit_module.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +0.0        0.00        perf-profile.calltrace.cycles-pp.__mutex_lock.finished_loading.load_module.__do_sys_finit_module.do_syscall_64
      0.00            +0.0        0.00        perf-profile.calltrace.cycles-pp.copy_user_enhanced_fast_string.copyin.iov_iter_copy_from_user_atomic.generic_perform_write.__generic_file_write_iter
      0.00            +0.0        0.00        perf-profile.calltrace.cycles-pp.osq_lock.__mutex_lock.finished_loading.load_module.__do_sys_finit_module
      0.00            +0.0        0.00        perf-profile.calltrace.cycles-pp.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      0.00            +0.0        0.00        perf-profile.calltrace.cycles-pp.shmem_write_end.generic_perform_write.__generic_file_write_iter.generic_file_write_iter.new_sync_write
      0.00            +0.0        0.00        perf-profile.calltrace.cycles-pp.tick_sched_timer.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt
      0.00            +0.0        0.00        perf-profile.calltrace.cycles-pp.tick_sched_handle.tick_sched_timer.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt
      0.00            +0.0        0.00        perf-profile.calltrace.cycles-pp.update_process_times.tick_sched_handle.tick_sched_timer.__hrtimer_run_queues.hrtimer_interrupt
      0.00            +0.0        0.00        perf-profile.calltrace.cycles-pp.scheduler_tick.update_process_times.tick_sched_handle.tick_sched_timer.__hrtimer_run_queues
      0.00            +0.0        0.00        perf-profile.calltrace.cycles-pp.prepare_to_wait_event.load_module.__do_sys_finit_module.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +0.0        0.00        perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.prepare_to_wait_event.load_module.__do_sys_finit_module.do_syscall_64
      0.00            +0.0        0.00        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.prepare_to_wait_event.load_module.__do_sys_finit_module
      0.00            +0.0        0.00        perf-profile.calltrace.cycles-pp.shmem_write_begin.generic_perform_write.__generic_file_write_iter.generic_file_write_iter.new_sync_write
      0.00            +0.0        0.00        perf-profile.calltrace.cycles-pp.shmem_getpage_gfp.shmem_write_begin.generic_perform_write.__generic_file_write_iter.generic_file_write_iter
      0.00            +0.0        0.00        perf-profile.calltrace.cycles-pp.task_tick_fair.scheduler_tick.update_process_times.tick_sched_handle.tick_sched_timer
      0.00            +0.0        0.00        perf-profile.calltrace.cycles-pp.khugepaged.kthread.ret_from_fork
      0.00            +0.0        0.00        perf-profile.calltrace.cycles-pp.khugepaged_scan_mm_slot.khugepaged.kthread.ret_from_fork
      0.00            +0.0        0.00        perf-profile.calltrace.cycles-pp.khugepaged_scan_pmd.khugepaged_scan_mm_slot.khugepaged.kthread.ret_from_fork
      0.00            +0.0        0.00        perf-profile.calltrace.cycles-pp.collapse_huge_page.khugepaged_scan_pmd.khugepaged_scan_mm_slot.khugepaged.kthread
      0.00            +0.0        0.00        perf-profile.calltrace.cycles-pp.iov_iter_fault_in_readable.generic_perform_write.__generic_file_write_iter.generic_file_write_iter.new_sync_write
      0.00            +0.0        0.00        perf-profile.calltrace.cycles-pp.__get_user_nocheck_1.iov_iter_fault_in_readable.generic_perform_write.__generic_file_write_iter.generic_file_write_iter
      0.00            +0.0        0.00        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.execve
      0.00            +0.0        0.00        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.execve
      0.00            +0.0        0.00        perf-profile.calltrace.cycles-pp.execve
      0.00            +0.0        0.00        perf-profile.calltrace.cycles-pp.__x64_sys_execve.do_syscall_64.entry_SYSCALL_64_after_hwframe.execve
      0.00            +0.0        0.00        perf-profile.calltrace.cycles-pp.do_execveat_common.__x64_sys_execve.do_syscall_64.entry_SYSCALL_64_after_hwframe.execve
      0.00            +0.0        0.00        perf-profile.calltrace.cycles-pp.irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      0.00            +0.0        0.00        perf-profile.calltrace.cycles-pp.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt
      0.00            +0.0        0.00        perf-profile.calltrace.cycles-pp.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt
      0.00            +0.0        0.00        perf-profile.calltrace.cycles-pp.clockevents_program_event.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      0.00            +0.0        0.00        perf-profile.calltrace.cycles-pp.asm_call_sysvec_on_stack.do_softirq_own_stack.irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      0.00            +0.0        0.00        perf-profile.calltrace.cycles-pp.do_softirq_own_stack.irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      0.00            +0.0        0.00        perf-profile.calltrace.cycles-pp.__softirqentry_text_start.asm_call_sysvec_on_stack.do_softirq_own_stack.irq_exit_rcu.sysvec_apic_timer_interrupt
      0.00            +0.0        0.00        perf-profile.calltrace.cycles-pp.unlock_page.shmem_write_end.generic_perform_write.__generic_file_write_iter.generic_file_write_iter
      0.00            +0.0        0.00        perf-profile.calltrace.cycles-pp.bprm_execve.do_execveat_common.__x64_sys_execve.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +0.0        0.00        perf-profile.calltrace.cycles-pp.copy_page.collapse_huge_page.khugepaged_scan_pmd.khugepaged_scan_mm_slot.khugepaged
      0.00            +0.0        0.00        perf-profile.calltrace.cycles-pp.ktime_get.clockevents_program_event.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt
      0.00            +0.0        0.00        perf-profile.calltrace.cycles-pp.__libc_fork
      0.00            +0.0        0.00        perf-profile.calltrace.cycles-pp.asm_exc_page_fault.__get_user_nocheck_1.iov_iter_fault_in_readable.generic_perform_write.__generic_file_write_iter
      0.00            +0.0        0.00        perf-profile.calltrace.cycles-pp.exec_binprm.bprm_execve.do_execveat_common.__x64_sys_execve.do_syscall_64
      0.00            +0.0        0.00        perf-profile.calltrace.cycles-pp.__libc_start_main
      0.00            +0.0        0.00        perf-profile.calltrace.cycles-pp.main.__libc_start_main
      0.00            +0.0        0.00        perf-profile.calltrace.cycles-pp.run_builtin.main.__libc_start_main
      0.00            +0.0        0.00        perf-profile.calltrace.cycles-pp.cmd_record.run_builtin.main.__libc_start_main
      0.00            +0.0        0.00        perf-profile.calltrace.cycles-pp.exc_page_fault.asm_exc_page_fault.__get_user_nocheck_1.iov_iter_fault_in_readable.generic_perform_write
      0.00            +0.0        0.00        perf-profile.calltrace.cycles-pp.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.__get_user_nocheck_1.iov_iter_fault_in_readable
      0.00            +0.0        0.00        perf-profile.calltrace.cycles-pp.load_elf_binary.exec_binprm.bprm_execve.do_execveat_common.__x64_sys_execve
      0.00            +0.0        0.00        perf-profile.calltrace.cycles-pp.ktime_get_update_offsets_now.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      0.00            +0.0        0.00        perf-profile.calltrace.cycles-pp.find_lock_entry.shmem_getpage_gfp.shmem_write_begin.generic_perform_write.__generic_file_write_iter
      0.00            +0.0        0.00        perf-profile.calltrace.cycles-pp.write
      0.00            +0.0        0.00        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.write
      0.00            +0.0        0.00        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
      0.00            +0.0        0.00        perf-profile.calltrace.cycles-pp.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
      0.00            +0.0        0.00        perf-profile.calltrace.cycles-pp.__fdget_pos.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_write
      0.00            +0.0        0.00        perf-profile.calltrace.cycles-pp.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
      0.00            +0.0        0.00        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__libc_fork
      0.00            +0.0        0.00        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_fork
      0.00            +0.0        0.00        perf-profile.calltrace.cycles-pp.__do_sys_clone.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_fork
      0.00            +0.0        0.00        perf-profile.calltrace.cycles-pp._do_fork.__do_sys_clone.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_fork
      0.00            +0.0        0.00        perf-profile.calltrace.cycles-pp.change_page_attr_set_clr.set_memory_ro.module_enable_ro.load_module.__do_sys_finit_module
      0.00            +0.0        0.00        perf-profile.calltrace.cycles-pp.module_enable_ro.load_module.__do_sys_finit_module.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +0.0        0.00        perf-profile.calltrace.cycles-pp.set_memory_ro.module_enable_ro.load_module.__do_sys_finit_module.do_syscall_64
      0.00            +0.0        0.00        perf-profile.calltrace.cycles-pp.record__mmap_read_evlist.cmd_record.run_builtin.main.__libc_start_main
      0.00            +0.0        0.00        perf-profile.calltrace.cycles-pp.read
      0.00            +0.0        0.00        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.read
      0.00            +0.0        0.00        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
      0.00            +0.0        0.00        perf-profile.calltrace.cycles-pp.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
      0.00            +0.0        0.00        perf-profile.calltrace.cycles-pp.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
      0.00            +0.0        0.00        perf-profile.calltrace.cycles-pp.perf_mmap__push.record__mmap_read_evlist.cmd_record.run_builtin.main
      0.00            +0.0        0.00        perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.finish_wait.load_module.__do_sys_finit_module.do_syscall_64
      0.00            +0.0        0.00        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.finish_wait.load_module.__do_sys_finit_module
      0.00            +0.0        0.00        perf-profile.calltrace.cycles-pp.finish_wait.load_module.__do_sys_finit_module.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +0.0        0.00        perf-profile.calltrace.cycles-pp.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.__get_user_nocheck_1
      0.00            +0.0        0.00        perf-profile.calltrace.cycles-pp.perf_mmap__read_head.perf_mmap__push.record__mmap_read_evlist.cmd_record.run_builtin
      0.00            +0.0        0.00        perf-profile.calltrace.cycles-pp.update_load_avg.task_tick_fair.scheduler_tick.update_process_times.tick_sched_handle
      0.00            +0.0        0.00        perf-profile.calltrace.cycles-pp.copy_process._do_fork.__do_sys_clone.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +0.0        0.00        perf-profile.calltrace.cycles-pp.task_work_run.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt
      0.00            +0.0        0.00        perf-profile.calltrace.cycles-pp.task_numa_work.task_work_run.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt
      0.00            +0.0        0.00        perf-profile.calltrace.cycles-pp.__pthread_enable_asynccancel
      0.00            +0.0        0.00        perf-profile.calltrace.cycles-pp.__x64_sys_exit_group.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +0.0        0.00        perf-profile.calltrace.cycles-pp.do_group_exit.__x64_sys_exit_group.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +0.0        0.00        perf-profile.calltrace.cycles-pp.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +0.0        0.00        perf-profile.calltrace.cycles-pp.vprintk_emit.devkmsg_emit.devkmsg_write.cold.new_sync_write.vfs_write
      0.00            +0.0        0.00        perf-profile.calltrace.cycles-pp.devkmsg_write.cold.new_sync_write.vfs_write.ksys_write.do_syscall_64
      0.00            +0.0        0.00        perf-profile.calltrace.cycles-pp.devkmsg_emit.devkmsg_write.cold.new_sync_write.vfs_write.ksys_write
      0.00            +0.0        0.00        perf-profile.calltrace.cycles-pp.up_write.generic_file_write_iter.new_sync_write.vfs_write.ksys_write
      0.00            +0.0        0.00        perf-profile.calltrace.cycles-pp.rcu_gp_kthread.kthread.ret_from_fork
      0.00            +0.0        0.00        perf-profile.calltrace.cycles-pp.change_protection.change_prot_numa.task_numa_work.task_work_run.exit_to_user_mode_prepare
      0.00            +0.0        0.00        perf-profile.calltrace.cycles-pp.change_prot_numa.task_numa_work.task_work_run.exit_to_user_mode_prepare.irqentry_exit_to_user_mode
      0.00            +0.0        0.00        perf-profile.calltrace.cycles-pp.on_each_cpu.cpa_flush.change_page_attr_set_clr.set_memory_ro.module_enable_ro
      0.00            +0.0        0.00        perf-profile.calltrace.cycles-pp.smp_call_function_many_cond.on_each_cpu.cpa_flush.change_page_attr_set_clr.set_memory_ro
      0.00            +0.0        0.00        perf-profile.calltrace.cycles-pp.cpa_flush.change_page_attr_set_clr.set_memory_ro.module_enable_ro.load_module
      0.00            +0.0        0.00        perf-profile.calltrace.cycles-pp.__fget_light.__fdget_pos.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +0.0        0.00        perf-profile.calltrace.cycles-pp.secondary_startup_64
      0.00            +0.0        0.00        perf-profile.calltrace.cycles-pp.start_secondary.secondary_startup_64
      0.00            +0.0        0.00        perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.secondary_startup_64
      0.00            +0.0        0.00        perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64
      0.00            +0.0        0.00        perf-profile.calltrace.cycles-pp.__fget_files.__fget_light.__fdget_pos.ksys_write.do_syscall_64
      0.00            +0.0        0.00        perf-profile.calltrace.cycles-pp.hrtimer_active.task_tick_fair.scheduler_tick.update_process_times.tick_sched_handle
      0.00            +0.0        0.00        perf-profile.calltrace.cycles-pp.__pthread_disable_asynccancel
      0.00            +0.0        0.00        perf-profile.calltrace.cycles-pp.mutex_unlock.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_write
      0.00            +0.0        0.00        perf-profile.calltrace.cycles-pp.cpuidle_enter.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64
      0.00            +0.0        0.00        perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry.start_secondary
      0.00            +0.0        0.00        perf-profile.calltrace.cycles-pp.__init_single_page.memmap_init_zone_device.pagemap_range.memremap_pages.devm_memremap_pages
      0.00            +0.0        0.00        perf-profile.calltrace.cycles-pp.find_get_entry.find_lock_entry.shmem_getpage_gfp.shmem_write_begin.generic_perform_write
      0.00            +0.0        0.00        perf-profile.calltrace.cycles-pp.console_unlock.vprintk_emit.devkmsg_emit.devkmsg_write.cold.new_sync_write
      0.00            +0.0        0.00        perf-profile.calltrace.cycles-pp.intel_idle.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry
      0.00            +0.0        0.00        perf-profile.calltrace.cycles-pp.begin_new_exec.load_elf_binary.exec_binprm.bprm_execve.do_execveat_common
      0.00            +0.0        0.00        perf-profile.calltrace.cycles-pp.do_sys_open.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +0.0        0.00        perf-profile.calltrace.cycles-pp.do_sys_openat2.do_sys_open.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +0.0        0.00        perf-profile.calltrace.cycles-pp.rebalance_domains.__softirqentry_text_start.asm_call_sysvec_on_stack.do_softirq_own_stack.irq_exit_rcu
      0.00            +0.0        0.00        perf-profile.calltrace.cycles-pp.run_timer_softirq.__softirqentry_text_start.asm_call_sysvec_on_stack.do_softirq_own_stack.irq_exit_rcu
      0.00            +0.0        0.00        perf-profile.calltrace.cycles-pp.__do_fault.do_fault.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
      0.00            +0.0        0.00        perf-profile.calltrace.cycles-pp.shmem_add_to_page_cache.shmem_getpage_gfp.shmem_write_begin.generic_perform_write.__generic_file_write_iter
      0.00            +0.0        0.00        perf-profile.calltrace.cycles-pp.wp_page_copy.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault
      0.00            +0.0        0.00        perf-profile.calltrace.cycles-pp.call_timer_fn.run_timer_softirq.__softirqentry_text_start.asm_call_sysvec_on_stack.do_softirq_own_stack
      0.00            +0.0        0.00        perf-profile.calltrace.cycles-pp.serial8250_console_write.console_unlock.vprintk_emit.devkmsg_emit.devkmsg_write.cold
      0.00            +0.0        0.00        perf-profile.calltrace.cycles-pp.rwsem_down_read_slowpath.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      0.00            +0.0        0.00        perf-profile.calltrace.cycles-pp.rwsem_optimistic_spin.rwsem_down_read_slowpath.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      0.00            +0.0        0.00        perf-profile.calltrace.cycles-pp.rwsem_spin_on_owner.rwsem_optimistic_spin.rwsem_down_read_slowpath.do_user_addr_fault.exc_page_fault
      0.00            +0.0        0.00        perf-profile.calltrace.cycles-pp.uart_console_write.serial8250_console_write.console_unlock.vprintk_emit.devkmsg_emit
      0.00            +0.0        0.00        perf-profile.calltrace.cycles-pp.wait_for_xmitr.serial8250_console_putchar.uart_console_write.serial8250_console_write.console_unlock
      0.00            +0.0        0.00        perf-profile.calltrace.cycles-pp.serial8250_console_putchar.uart_console_write.serial8250_console_write.console_unlock.vprintk_emit
      0.00            +0.0        0.00        perf-profile.calltrace.cycles-pp.io_serial_in.wait_for_xmitr.serial8250_console_putchar.uart_console_write.serial8250_console_write
      0.00            +0.0        0.00        perf-profile.calltrace.cycles-pp.mmput.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      0.00            +0.0        0.00        perf-profile.calltrace.cycles-pp.exit_mmap.mmput.do_exit.do_group_exit.__x64_sys_exit_group
      0.00            +0.0        0.00        perf-profile.calltrace.cycles-pp.do_filp_open.do_sys_openat2.do_sys_open.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +0.0        0.00        perf-profile.calltrace.cycles-pp.path_openat.do_filp_open.do_sys_openat2.do_sys_open.do_syscall_64
      0.00            +0.0        0.00        perf-profile.calltrace.cycles-pp.rcu_core.__softirqentry_text_start.asm_call_sysvec_on_stack.do_softirq_own_stack.irq_exit_rcu
      0.00            +0.0        0.00        perf-profile.calltrace.cycles-pp.__mutex_lock.load_module.__do_sys_finit_module.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +0.0        0.00        perf-profile.calltrace.cycles-pp.dup_mm.copy_process._do_fork.__do_sys_clone.do_syscall_64
      0.00            +0.0        0.00        perf-profile.calltrace.cycles-pp.osq_lock.__mutex_lock.load_module.__do_sys_finit_module.do_syscall_64
      0.00            +0.0        0.00        perf-profile.calltrace.cycles-pp.mmput.begin_new_exec.load_elf_binary.exec_binprm.bprm_execve
      0.00            +0.0        0.00        perf-profile.calltrace.cycles-pp.exit_mmap.mmput.begin_new_exec.load_elf_binary.exec_binprm
      0.00            +0.0        0.00        perf-profile.calltrace.cycles-pp.load_balance.rebalance_domains.__softirqentry_text_start.asm_call_sysvec_on_stack.do_softirq_own_stack
      0.00            +0.0        0.00        perf-profile.calltrace.cycles-pp.dup_mmap.dup_mm.copy_process._do_fork.__do_sys_clone
      0.00            +0.0        0.00        perf-profile.calltrace.cycles-pp.filemap_map_pages.do_fault.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
      0.00            +0.0        0.00        perf-profile.calltrace.cycles-pp.update_curr.task_tick_fair.scheduler_tick.update_process_times.tick_sched_handle
      0.00            +0.0        0.00        perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.memcpy_erms.drm_fb_helper_dirty_work.process_one_work.worker_thread
      0.00            +0.0        0.00        perf-profile.calltrace.cycles-pp.flush_tlb_mm_range.pmdp_huge_clear_flush.collapse_huge_page.khugepaged_scan_pmd.khugepaged_scan_mm_slot
      0.00            +0.0        0.00        perf-profile.calltrace.cycles-pp.pmdp_huge_clear_flush.collapse_huge_page.khugepaged_scan_pmd.khugepaged_scan_mm_slot.khugepaged
      0.00            +0.0        0.00        perf-profile.calltrace.cycles-pp.on_each_cpu_cond_mask.flush_tlb_mm_range.pmdp_huge_clear_flush.collapse_huge_page.khugepaged_scan_pmd
      0.00            +0.0        0.00        perf-profile.calltrace.cycles-pp.wait4
      0.00            +0.0        0.00        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.wait4
      0.00            +0.0        0.00        perf-profile.calltrace.cycles-pp.setlocale
      0.00            +0.0        0.00        perf-profile.calltrace.cycles-pp.seq_read.proc_reg_read.vfs_read.ksys_read.do_syscall_64
      0.00            +0.0        0.00        perf-profile.calltrace.cycles-pp.proc_reg_read.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +0.0        0.00        perf-profile.calltrace.cycles-pp.seq_read.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +0.0        0.00        perf-profile.calltrace.cycles-pp.copy_page.wp_page_copy.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
      0.00            +0.0        0.00        perf-profile.calltrace.cycles-pp.do_anonymous_page.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault
      0.00            +0.0        0.00        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.wait4
      0.00            +0.0        0.00        perf-profile.calltrace.cycles-pp.__do_sys_wait4.do_syscall_64.entry_SYSCALL_64_after_hwframe.wait4
      0.00            +0.0        0.00        perf-profile.calltrace.cycles-pp.kernel_wait4.__do_sys_wait4.do_syscall_64.entry_SYSCALL_64_after_hwframe.wait4
      0.00            +0.0        0.00        perf-profile.calltrace.cycles-pp.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +0.0        0.00        perf-profile.calltrace.cycles-pp.smp_call_function_many_cond.on_each_cpu.__change_page_attr_set_clr.__change_page_attr_set_clr.change_page_attr_set_clr
      0.00            +0.0        0.00        perf-profile.calltrace.cycles-pp.on_each_cpu.__change_page_attr_set_clr.__change_page_attr_set_clr.change_page_attr_set_clr.set_memory_ro
      0.00            +0.0        0.00        perf-profile.calltrace.cycles-pp.__change_page_attr_set_clr.__change_page_attr_set_clr.change_page_attr_set_clr.set_memory_ro.module_enable_ro
      0.55 ± 53%      +0.1        0.63 ±  7%  perf-profile.calltrace.cycles-pp.vma_interval_tree_insert.__vma_adjust.__split_vma.__do_munmap.__vm_munmap
      0.42 ± 82%      +0.2        0.63 ±  8%  perf-profile.calltrace.cycles-pp.vma_interval_tree_insert.__vma_adjust.__split_vma.do_madvise.__x64_sys_madvise
      1.36 ± 24%      +0.3        1.68 ±  9%  perf-profile.calltrace.cycles-pp.find_vma_prev.do_madvise.__x64_sys_madvise.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.34 ± 24%      +0.3        1.67 ±  9%  perf-profile.calltrace.cycles-pp.find_vma.find_vma_prev.do_madvise.__x64_sys_madvise.do_syscall_64
      0.00            +0.3        0.35 ± 70%  perf-profile.calltrace.cycles-pp.hrtimer_interrupt.__sysvec_apic_timer_interrupt.asm_call_sysvec_on_stack.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      0.00            +0.5        0.53 ±  2%  perf-profile.calltrace.cycles-pp.__sysvec_apic_timer_interrupt.asm_call_sysvec_on_stack.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.do_madvise
      0.00            +0.5        0.53 ±  2%  perf-profile.calltrace.cycles-pp.asm_call_sysvec_on_stack.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.do_madvise.__x64_sys_madvise
      0.00            +0.6        0.58 ±  2%  perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.do_madvise.__x64_sys_madvise.do_syscall_64
      0.00            +0.6        0.62 ±  3%  perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.do_madvise.__x64_sys_madvise.do_syscall_64.entry_SYSCALL_64_after_hwframe
     97.91            +1.7       99.63        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe
     96.78            +2.4       99.22        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +9.1        9.05        perf-profile.calltrace.cycles-pp.xas_find.do_madvise.__x64_sys_madvise.do_syscall_64.entry_SYSCALL_64_after_hwframe
      3.64 ± 22%     +85.5       89.18        perf-profile.calltrace.cycles-pp.do_madvise.__x64_sys_madvise.do_syscall_64.entry_SYSCALL_64_after_hwframe
      3.67 ± 22%     +86.1       89.78        perf-profile.calltrace.cycles-pp.__x64_sys_madvise.do_syscall_64.entry_SYSCALL_64_after_hwframe
     80.11 ±  5%     -78.0        2.12 ± 54%  perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
     51.71 ±  5%     -49.2        2.49 ± 39%  perf-profile.children.cycles-pp.pagevec_lru_move_fn
     50.07 ±  6%     -48.4        1.62 ± 51%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
     43.97 ± 12%     -43.5        0.48 ± 25%  perf-profile.children.cycles-pp.ksys_mmap_pgoff
     43.89 ± 12%     -43.4        0.47 ± 25%  perf-profile.children.cycles-pp.vm_mmap_pgoff
     42.03 ± 14%     -41.9        0.08 ± 20%  perf-profile.children.cycles-pp.__mm_populate
     41.95 ± 14%     -41.9        0.07 ± 20%  perf-profile.children.cycles-pp.populate_vma_page_range
     41.95 ± 14%     -41.9        0.07 ± 20%  perf-profile.children.cycles-pp.__get_user_pages
     41.77 ± 14%     -41.6        0.20 ± 11%  perf-profile.children.cycles-pp.follow_page_pte
     49.04 ±  7%     -40.1        8.92 ± 13%  perf-profile.children.cycles-pp.__x64_sys_munmap
     49.00 ±  7%     -40.1        8.90 ± 13%  perf-profile.children.cycles-pp.__vm_munmap
     48.87 ±  7%     -40.0        8.82 ± 14%  perf-profile.children.cycles-pp.__do_munmap
     38.17 ±  9%     -36.5        1.66 ± 36%  perf-profile.children.cycles-pp.lru_add_drain
     30.43 ±  5%     -29.8        0.62 ± 54%  perf-profile.children.cycles-pp._raw_spin_lock_irq
     27.06 ±  9%     -25.3        1.72 ± 43%  perf-profile.children.cycles-pp.__munlock_pagevec
     27.29 ±  9%     -25.3        1.98 ± 39%  perf-profile.children.cycles-pp.munlock_vma_pages_range
     17.70 ± 11%     -17.7        0.00        perf-profile.children.cycles-pp.lru_add_drain_cpu
     17.57 ± 11%     -17.6        0.00        perf-profile.children.cycles-pp.isolate_lru_page
     17.56 ± 11%     -17.6        0.00        perf-profile.children.cycles-pp.mlock_vma_page
     17.28 ±  6%     -13.6        3.66 ± 15%  perf-profile.children.cycles-pp.unmap_region
     16.45 ±  6%     -13.4        3.10 ± 18%  perf-profile.children.cycles-pp.unmap_vmas
     16.22 ±  5%     -13.3        2.87 ± 20%  perf-profile.children.cycles-pp.zap_pte_range
     16.37 ±  5%     -13.3        3.04 ± 19%  perf-profile.children.cycles-pp.unmap_page_range
     14.62 ±  4%     -12.9        1.75 ± 34%  perf-profile.children.cycles-pp.tlb_flush_mmu
     14.46 ±  4%     -12.8        1.65 ± 36%  perf-profile.children.cycles-pp.free_pages_and_swap_cache
      1.69 ± 32%      -1.3        0.37 ± 27%  perf-profile.children.cycles-pp.do_mmap
      1.60 ± 32%      -1.3        0.35 ± 26%  perf-profile.children.cycles-pp.mmap_region
      3.54 ± 20%      -0.9        2.61 ±  6%  perf-profile.children.cycles-pp.__split_vma
      0.94 ± 33%      -0.9        0.02 ±141%  perf-profile.children.cycles-pp.asm_exc_page_fault
      0.88 ± 20%      -0.8        0.07 ± 25%  perf-profile.children.cycles-pp.handle_mm_fault
      0.76 ± 24%      -0.7        0.02 ±141%  perf-profile.children.cycles-pp.exc_page_fault
      0.77 ± 20%      -0.7        0.05 ± 72%  perf-profile.children.cycles-pp.__handle_mm_fault
      0.74 ± 24%      -0.7        0.02 ±141%  perf-profile.children.cycles-pp.do_user_addr_fault
      1.06 ± 99%      -0.7        0.38 ±  6%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      0.68 ± 19%      -0.7        0.02 ±141%  perf-profile.children.cycles-pp.do_fault
      1.30 ± 25%      -0.5        0.75 ±  6%  perf-profile.children.cycles-pp.remove_vma
      0.93 ± 26%      -0.5        0.39 ±  4%  perf-profile.children.cycles-pp.kmem_cache_alloc
      1.23 ± 25%      -0.5        0.70 ±  5%  perf-profile.children.cycles-pp.kmem_cache_free
      0.92 ± 21%      -0.4        0.48 ±  4%  perf-profile.children.cycles-pp.vm_area_dup
      2.43 ± 20%      -0.4        2.03 ±  6%  perf-profile.children.cycles-pp.__vma_adjust
      0.48 ±  6%      -0.3        0.15 ± 19%  perf-profile.children.cycles-pp.__pagevec_lru_add_fn
      0.39 ± 30%      -0.3        0.08 ± 30%  perf-profile.children.cycles-pp.vma_link
      0.62 ±  9%      -0.3        0.33 ±  9%  perf-profile.children.cycles-pp.release_pages
      0.26 ± 19%      -0.3        0.00        perf-profile.children.cycles-pp.alloc_set_pte
      0.30 ± 37%      -0.2        0.06 ± 19%  perf-profile.children.cycles-pp.vm_area_alloc
      0.36 ± 19%      -0.2        0.14 ±  9%  perf-profile.children.cycles-pp.__mod_memcg_lruvec_state
      0.22 ± 23%      -0.2        0.00        perf-profile.children.cycles-pp.native_irq_return_iret
      0.25 ± 31%      -0.2        0.04 ± 76%  perf-profile.children.cycles-pp.perf_event_mmap
      0.21 ± 15%      -0.2        0.00        perf-profile.children.cycles-pp.filemap_map_pages
      0.20 ±102%      -0.2        0.00        perf-profile.children.cycles-pp.irqentry_exit_to_user_mode
      0.65 ± 27%      -0.2        0.45 ±  6%  perf-profile.children.cycles-pp.free_pgtables
      0.20 ± 21%      -0.2        0.00        perf-profile.children.cycles-pp.find_get_entry
      0.19 ± 24%      -0.2        0.00        perf-profile.children.cycles-pp.__do_fault
      0.18 ± 19%      -0.2        0.00        perf-profile.children.cycles-pp.shmem_getpage_gfp
      0.18 ± 18%      -0.2        0.00        perf-profile.children.cycles-pp.page_add_file_rmap
      0.42 ± 21%      -0.2        0.25 ±  5%  perf-profile.children.cycles-pp.flush_tlb_mm_range
      0.18 ± 22%      -0.2        0.00        perf-profile.children.cycles-pp.shmem_fault
      0.17 ± 24%      -0.2        0.00        perf-profile.children.cycles-pp.finish_fault
      0.57 ± 27%      -0.2        0.40 ±  7%  perf-profile.children.cycles-pp.unlink_file_vma
      0.30 ± 24%      -0.2        0.14 ±  8%  perf-profile.children.cycles-pp.refill_obj_stock
      0.34 ± 29%      -0.2        0.18 ±  2%  perf-profile.children.cycles-pp.__vma_link_rb
      0.17 ±  3%      -0.2        0.02 ±141%  perf-profile.children.cycles-pp.mem_cgroup_page_lruvec
      0.15 ± 26%      -0.2        0.00        perf-profile.children.cycles-pp.sync_regs
      0.15 ±  2%      -0.1        0.00        perf-profile.children.cycles-pp._raw_spin_unlock_irqrestore
      0.24 ± 21%      -0.1        0.10 ±  4%  perf-profile.children.cycles-pp.syscall_return_via_sysret
      0.13 ± 25%      -0.1        0.00        perf-profile.children.cycles-pp.find_lock_entry
      0.13 ± 12%      -0.1        0.00        perf-profile.children.cycles-pp.__mod_node_page_state
      0.55 ± 26%      -0.1        0.42 ±  5%  perf-profile.children.cycles-pp.vma_interval_tree_remove
      0.31 ± 21%      -0.1        0.17 ±  5%  perf-profile.children.cycles-pp.flush_tlb_func_common
      0.24 ±  4%      -0.1        0.11 ± 22%  perf-profile.children.cycles-pp.mem_cgroup_update_lru_size
      0.14 ± 20%      -0.1        0.02 ±141%  perf-profile.children.cycles-pp.xas_load
      0.16 ± 11%      -0.1        0.03 ± 70%  perf-profile.children.cycles-pp.__mod_lruvec_state
      0.27 ± 21%      -0.1        0.15 ±  5%  perf-profile.children.cycles-pp.native_flush_tlb_one_user
      0.19 ± 19%      -0.1        0.07 ±  6%  perf-profile.children.cycles-pp.__rb_insert_augmented
      0.12 ±  3%      -0.1        0.00        perf-profile.children.cycles-pp.lru_cache_add
      0.20 ± 23%      -0.1        0.09 ±  5%  perf-profile.children.cycles-pp.___might_sleep
      0.18 ± 20%      -0.1        0.07        perf-profile.children.cycles-pp.__mod_memcg_state
      0.21 ± 27%      -0.1        0.11 ±  8%  perf-profile.children.cycles-pp.drain_obj_stock
      0.11 ±  4%      -0.1        0.00        perf-profile.children.cycles-pp.putback_lru_page
      0.18 ± 21%      -0.1        0.07 ±  6%  perf-profile.children.cycles-pp.down_write_killable
      0.17 ± 32%      -0.1        0.07 ±  6%  perf-profile.children.cycles-pp.get_obj_cgroup_from_current
      0.21 ± 23%      -0.1        0.11 ±  4%  perf-profile.children.cycles-pp.page_remove_rmap
      1.39 ± 21%      -0.1        1.29 ±  7%  perf-profile.children.cycles-pp.vma_interval_tree_insert
      0.20 ± 26%      -0.1        0.11 ±  8%  perf-profile.children.cycles-pp.page_counter_uncharge
      0.09 ± 32%      -0.1        0.00        perf-profile.children.cycles-pp.d_path
      0.39 ± 11%      -0.1        0.30 ± 14%  perf-profile.children.cycles-pp.mark_page_accessed
      0.20 ± 24%      -0.1        0.11 ±  8%  perf-profile.children.cycles-pp.page_counter_cancel
      0.09 ± 25%      -0.1        0.00        perf-profile.children.cycles-pp.security_mmap_file
      0.14 ± 22%      -0.1        0.05 ±  8%  perf-profile.children.cycles-pp.obj_cgroup_charge
      0.14 ± 20%      -0.1        0.05        perf-profile.children.cycles-pp.__entry_text_start
      0.09 ± 20%      -0.1        0.00        perf-profile.children.cycles-pp.__might_sleep
      0.13 ± 22%      -0.1        0.05        perf-profile.children.cycles-pp.up_write
      0.08 ± 22%      -0.1        0.00        perf-profile.children.cycles-pp.fault_dirty_shared_page
      0.09 ± 19%      -0.1        0.02 ±141%  perf-profile.children.cycles-pp._cond_resched
      0.19 ± 29%      -0.1        0.12 ±  6%  perf-profile.children.cycles-pp.__rb_erase_color
      0.19 ± 33%      -0.1        0.12 ±  6%  perf-profile.children.cycles-pp.__slab_alloc
      0.07 ± 23%      -0.1        0.00        perf-profile.children.cycles-pp.syscall_enter_from_user_mode
      0.07 ±  5%      -0.1        0.00        perf-profile.children.cycles-pp.__libc_write
      0.09 ± 11%      -0.1        0.02 ±141%  perf-profile.children.cycles-pp.ksys_write
      0.09 ± 11%      -0.1        0.02 ±141%  perf-profile.children.cycles-pp.vfs_write
      0.07 ± 24%      -0.1        0.00        perf-profile.children.cycles-pp.tlb_finish_mmu
      0.07 ± 18%      -0.1        0.00        perf-profile.children.cycles-pp.__slab_free
      0.07 ± 20%      -0.1        0.00        perf-profile.children.cycles-pp.vma_interval_tree_augment_rotate
      0.14 ± 23%      -0.1        0.07 ±  6%  perf-profile.children.cycles-pp.__memcg_kmem_uncharge
      0.08 ± 12%      -0.1        0.02 ±141%  perf-profile.children.cycles-pp.new_sync_write
      0.06 ±  7%      -0.1        0.00        perf-profile.children.cycles-pp.generic_file_write_iter
      0.06 ±  7%      -0.1        0.00        perf-profile.children.cycles-pp.__generic_file_write_iter
      0.18 ±  4%      -0.1        0.12 ± 18%  perf-profile.children.cycles-pp.__list_add_valid
      0.06 ± 18%      -0.1        0.00        perf-profile.children.cycles-pp.cpumask_any_but
      0.06 ±  6%      -0.1        0.00        perf-profile.children.cycles-pp.generic_perform_write
      0.12 ± 21%      -0.1        0.06 ±  7%  perf-profile.children.cycles-pp.down_write
      0.11 ± 22%      -0.1        0.05 ±  8%  perf-profile.children.cycles-pp.vmacache_find
      0.06 ± 51%      -0.1        0.00        perf-profile.children.cycles-pp.ret_from_fork
      0.06 ± 51%      -0.1        0.00        perf-profile.children.cycles-pp.kthread
      0.17 ± 36%      -0.1        0.12 ±  4%  perf-profile.children.cycles-pp.___slab_alloc
      0.11 ± 28%      -0.0        0.06 ± 16%  perf-profile.children.cycles-pp.vma_merge
      0.05 ± 53%      -0.0        0.00        perf-profile.children.cycles-pp.page_mapping
      0.28 ±  7%      -0.0        0.24 ± 14%  perf-profile.children.cycles-pp.workingset_age_nonresident
      0.11 ± 15%      -0.0        0.06        perf-profile.children.cycles-pp.free_unref_page_list
      0.30 ±  7%      -0.0        0.26 ± 15%  perf-profile.children.cycles-pp.workingset_activation
      0.04 ± 51%      -0.0        0.00        perf-profile.children.cycles-pp.follow_page_mask
      0.04 ± 87%      -0.0        0.00        perf-profile.children.cycles-pp.prepend_path
      0.44 ±  6%      -0.0        0.40 ± 19%  perf-profile.children.cycles-pp.__activate_page
      0.04 ± 85%      -0.0        0.00        perf-profile.children.cycles-pp.perf_iterate_sb
      0.04 ± 83%      -0.0        0.00        perf-profile.children.cycles-pp.userfaultfd_unmap_prep
      0.04 ± 82%      -0.0        0.00        perf-profile.children.cycles-pp.syscall
      0.04 ± 82%      -0.0        0.00        perf-profile.children.cycles-pp.__do_sys_finit_module
      0.04 ± 82%      -0.0        0.00        perf-profile.children.cycles-pp.load_module
      0.04 ± 83%      -0.0        0.00        perf-profile.children.cycles-pp.vma_gap_callbacks_rotate
      0.04 ± 83%      -0.0        0.00        perf-profile.children.cycles-pp.__memcg_kmem_charge
      0.03 ± 82%      -0.0        0.00        perf-profile.children.cycles-pp.up_read
      0.03 ± 82%      -0.0        0.00        perf-profile.children.cycles-pp.tlb_gather_mmu
      0.03 ±123%      -0.0        0.00        perf-profile.children.cycles-pp.get_unmapped_area
      0.13 ± 20%      -0.0        0.10 ± 16%  perf-profile.children.cycles-pp.__list_del_entry_valid
      0.13 ± 13%      -0.0        0.11 ± 12%  perf-profile.children.cycles-pp.__munlock_isolate_lru_page
      0.02 ±125%      -0.0        0.00        perf-profile.children.cycles-pp.memcpy_erms
      0.02 ±125%      -0.0        0.00        perf-profile.children.cycles-pp.common_file_perm
      0.02 ±122%      -0.0        0.00        perf-profile.children.cycles-pp.rcu_all_qs
      0.02 ±122%      -0.0        0.00        perf-profile.children.cycles-pp.page_counter_try_charge
      0.02 ±122%      -0.0        0.00        perf-profile.children.cycles-pp.__count_memcg_events
      0.02 ±122%      -0.0        0.00        perf-profile.children.cycles-pp.downgrade_write
      0.02 ±123%      -0.0        0.00        perf-profile.children.cycles-pp.fput_many
      0.02 ±123%      -0.0        0.00        perf-profile.children.cycles-pp.put_cpu_partial
      0.02 ±123%      -0.0        0.00        perf-profile.children.cycles-pp.set_page_dirty
      0.02 ±122%      -0.0        0.00        perf-profile.children.cycles-pp.__set_page_dirty_no_writeback
      0.01 ±200%      -0.0        0.00        perf-profile.children.cycles-pp.vprintk_emit
      0.01 ±200%      -0.0        0.00        perf-profile.children.cycles-pp.console_unlock
      0.01 ±200%      -0.0        0.00        perf-profile.children.cycles-pp.prepend_name
      0.01 ±200%      -0.0        0.00        perf-profile.children.cycles-pp.__fget_files
      0.01 ±200%      -0.0        0.00        perf-profile.children.cycles-pp.unlock_page
      0.01 ±200%      -0.0        0.00        perf-profile.children.cycles-pp.activate_page
      0.01 ±200%      -0.0        0.00        perf-profile.children.cycles-pp.serial8250_console_write
      0.01 ±200%      -0.0        0.00        perf-profile.children.cycles-pp.uart_console_write
      0.01 ±200%      -0.0        0.00        perf-profile.children.cycles-pp._find_next_bit
      0.01 ±200%      -0.0        0.00        perf-profile.children.cycles-pp.khugepaged
      0.01 ±200%      -0.0        0.00        perf-profile.children.cycles-pp.khugepaged_scan_mm_slot
      0.01 ±200%      -0.0        0.00        perf-profile.children.cycles-pp.khugepaged_scan_pmd
      0.01 ±200%      -0.0        0.00        perf-profile.children.cycles-pp.collapse_huge_page
      0.01 ±200%      -0.0        0.00        perf-profile.children.cycles-pp.__remove_shared_vm_struct
      0.08 ± 13%      -0.0        0.07 ± 11%  perf-profile.children.cycles-pp.try_grab_page
      0.08 ± 24%      -0.0        0.07 ±  6%  perf-profile.children.cycles-pp.vmacache_update
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.do_init_module
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.do_one_initcall
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.driver_register
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.bus_add_driver
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.bus_for_each_dev
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.__driver_attach
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.device_driver_attach
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.driver_probe_device
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.really_probe
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.nvdimm_bus_probe
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.dax_pmem_compat_probe
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.dev_dax_probe
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.devm_memremap_pages
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.memremap_pages
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.pagemap_range
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.memmap_init_zone_device
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.worker_thread
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.process_one_work
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.drm_fb_helper_dirty_work
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.__mutex_lock
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.copy_user_enhanced_fast_string
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.iov_iter_copy_from_user_atomic
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.copyin
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.osq_lock
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.finished_loading
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.shmem_write_end
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.prepare_to_wait_event
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.copy_page
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.shmem_write_begin
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.iov_iter_fault_in_readable
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.__get_user_nocheck_1
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.irq_exit_rcu
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.__x64_sys_execve
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.do_execveat_common
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.__softirqentry_text_start
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.execve
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.on_each_cpu
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.smp_call_function_many_cond
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.do_softirq_own_stack
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.bprm_execve
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.change_page_attr_set_clr
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.__libc_fork
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.exec_binprm
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.__libc_start_main
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.main
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.run_builtin
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.cmd_record
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.load_elf_binary
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.ktime_get_update_offsets_now
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.write
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.__sched_text_start
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.__fdget_pos
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.cpa_flush
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.__do_sys_clone
      0.00            +0.0        0.00        perf-profile.children.cycles-pp._do_fork
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.try_to_wake_up
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.module_enable_ro
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.set_memory_ro
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.ksys_read
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.vfs_read
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.record__mmap_read_evlist
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.schedule
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.read
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.mmput
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.do_filp_open
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.path_openat
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.perf_mmap__push
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.finish_wait
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.exit_mmap
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.do_sys_open
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.do_sys_openat2
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.perf_mmap__read_head
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.select_task_rq_fair
      0.00            +0.0        0.00        perf-profile.children.cycles-pp._vm_unmap_aliases
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.copy_process
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.__alloc_pages_nodemask
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.__x64_sys_exit_group
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.do_group_exit
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.do_exit
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.seq_read
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.__purge_vmap_area_lazy
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.__pthread_enable_asynccancel
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.devkmsg_write.cold
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.devkmsg_emit
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.__init_single_page
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.wp_page_copy
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.change_protection
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.__fget_light
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.rcu_gp_kthread
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.get_page_from_freelist
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.load_balance
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.change_prot_numa
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.mutex_unlock
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.secondary_startup_64
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.start_secondary
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.cpu_startup_entry
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.do_idle
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.rebalance_domains
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.hrtimer_active
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.__pthread_disable_asynccancel
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.cpuidle_enter
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.cpuidle_enter_state
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.intel_idle
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.begin_new_exec
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.mutex_lock
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.run_timer_softirq
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.io_serial_in
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.shmem_add_to_page_cache
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.call_timer_fn
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.walk_component
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.wait_for_xmitr
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.clear_page_erms
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.dup_mm
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.link_path_walk
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.rcu_core
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.serial8250_console_putchar
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.__vunmap
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.change_p4d_range
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.set_pfnblock_flags_mask
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.find_busiest_group
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.perf_mmap_fault
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.dup_mmap
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.set_memory_x
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.update_sd_lb_stats
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.select_idle_sibling
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.prep_new_page
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.proc_reg_read
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.enqueue_task_fair
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.do_anonymous_page
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.__update_load_avg_se
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.ttwu_do_activate
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.setlocale
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.__wake_up_common_lock
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.find_idlest_group
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.pick_next_task_fair
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.alloc_pages_vma
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.__wake_up_common
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.enqueue_entity
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.flush_tlb_kernel_range
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.autoremove_wake_function
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.rcu_do_batch
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.schedule_timeout
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.force_qs_rnp
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.lapic_next_deadline
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.__update_load_avg_cfs_rq
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.do_huge_pmd_numa_page
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.migrate_misplaced_transhuge_page
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.down_read_trylock
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.update_rq_clock
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.migrate_page_copy
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.irqtime_account_irq
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.irq_work_run_list
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.__open64_nocancel
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.pipe_write
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.__lookup_slow
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.mem_cgroup_charge
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.irq_work_single
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.newidle_balance
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.rmqueue
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.new_sync_read
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.sched_exec
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.update_cfs_group
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.free_module
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.mutex_spin_on_owner
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.wake_up_new_task
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.run_local_timers
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.shmem_alloc_and_acct_page
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.asm_sysvec_irq_work
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.sysvec_irq_work
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.__sysvec_irq_work
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.arch_scale_freq_tick
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.__account_scheduler_latency
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.diskstats_show
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.smpboot_thread_fn
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.copy_page_range
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.filename_lookup
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.available_idle_cpu
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.path_lookupat
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.irq_work_run
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.printk
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.unlink_anon_vmas
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.wait4
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.alloc_empty_file
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.rcu_sched_clock_irq
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.__alloc_file
      0.00            +0.0        0.00        perf-profile.children.cycles-pp._raw_spin_trylock
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.update_irq_load_avg
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.sched_setaffinity
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.lookup_fast
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.step_into
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.__clear_user
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.shmem_alloc_page
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.d_alloc_parallel
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.sched_clock_cpu
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.get_arg_page
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.__get_user_pages_remote
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.dput
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.sysfs_kf_seq_show
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.sum_zone_numa_state
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.update_blocked_averages
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.__do_sys_wait4
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.__x64_sys_mprotect
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.do_mprotect_pkey
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.dev_attr_show
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.run_rebalance_domains
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.kernel_wait4
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.do_wait
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.perf_mmap_to_page
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.__get_free_pages
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.vmstat_start
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.sum_vm_events
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.pte_alloc_one
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.account_user_time
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.asm_sysvec_reschedule_ipi
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.__switch_to
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.mprotect_fixup
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.evlist__disable
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.elf_map
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.finish_task_switch
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.stack_trace_save_tsk
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.sched_clock
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.do_open_execat
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.release_pte_page
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.open64
      0.00            +0.0        0.00        perf-profile.children.cycles-pp._dl_addr
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.__memcg_kmem_charge_page
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.read_tsc
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.try_charge
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.blocking_notifier_call_chain
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.trace_module_notify
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.rmqueue_bulk
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.asm_sysvec_call_function_single
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.delay_tsc
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.update_nohz_stats
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.switch_mm_irqs_off
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.load_elf_interp
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.d_alloc
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.do_dentry_open
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.pipe_read
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.native_sched_clock
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.show_stat
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.__do_sys_newstat
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.vfs_statx
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.calc_global_load_tick
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.asm_common_interrupt
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.reweight_entity
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.copy_strings
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.common_interrupt
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.run_ksoftirqd
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.copy_pte_range
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.dequeue_task_fair
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.llist_add_batch
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.part_stat_read_all
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.check_preempt_curr
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.wait_task_zombie
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.ttwu_do_wakeup
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.__mmap
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.anon_vma_fork
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.copy_string_kernel
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.__pte_alloc
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.irq_enter_rcu
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.unlazy_walk
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.switch_fpu_return
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.check_preempt_wakeup
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.__fput
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.arch_stack_walk
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.__legitimize_path
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.alloc_bprm
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.release_task
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.vmstat_update
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.refresh_cpu_vm_stats
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.generic_file_buffered_read
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.__pmd_alloc
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.__close
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.blk_mq_queue_tag_busy_iter
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.mm_init
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.do_faccessat
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.blk_mq_in_flight
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.sysvec_call_function_single
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.__vmalloc_node_range
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.malloc
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.__dentry_kill
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.__x64_sys_sched_setaffinity
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.vt_console_print
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.lf
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.con_scroll
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.fbcon_scroll
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.node_read_numastat
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.__queue_work
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.fbcon_redraw
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.__pud_alloc
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.__sysvec_call_function_single
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.sched_ttwu_pending
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.__x64_sys_poll
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.do_sys_poll
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.node_read_vmstat
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.schedule_tail
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.setup_arg_pages
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.__poll
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.xas_find_conflict
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.__accumulate_pelt_segments
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.anon_vma_clone
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.__put_user_nocheck_4
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.dequeue_entity
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.call_rcu
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.pgd_alloc
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.fbcon_putcs
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.bit_putcs
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.cpuacct_charge
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.rcu_segcblist_enqueue
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.free_pcppages_bulk
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.__x86_indirect_thunk_rax
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.__legitimize_mnt
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.__d_lookup_rcu
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.d_add
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.net_rx_action
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.touch_atime
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.__x64_sys_readlink
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.do_readlinkat
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.simple_lookup
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.swake_up_locked
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.get_mem_cgroup_from_mm
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.__xstat64
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.resched_curr
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.tick_sched_do_timer
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.irqtime_account_process_tick
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.rcu_cblist_dequeue
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.sys_imageblit
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.__kernel_read
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.__d_alloc
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.security_file_permission
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.drm_fb_helper_sys_imageblit
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.igb_poll
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.shift_arg_pages
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.__close_nocancel
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.__fsnotify_parent
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.__remove_hrtimer
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.unwind_next_frame
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.file_update_time
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.__x64_sys_close
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.mod_sysfs_setup
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.pick_link
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.__send_signal
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.arch_do_signal
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.arch_dup_task_struct
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.open_exec
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.rcu_implicit_dynticks_qs
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.trigger_load_balance
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.lockref_put_or_lock
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.__cgroup_account_cputime_field
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.__mmdrop
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.ep_poll_callback
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.napi_complete_done
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.do_notify_parent
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.create_elf_tables
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.swake_up_one
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.anon_vma_interval_tree_remove
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.strnlen_user
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.__hrtimer_next_event_base
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.kstat_irqs
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.do_wp_page
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.inode_permission
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.allocate_slab
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.__kmalloc_node
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.getname_flags
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.set_pageblock_migratetype
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.handle_edge_irq
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.kstat_irqs_usr
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.__switch_to_asm
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.record__pushfn
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.put_task_stack
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.put_prev_entity
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.current_time
      0.00            +0.0        0.00        perf-profile.children.cycles-pp._copy_to_user
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.security_bprm_creds_for_exec
      0.00            +0.0        0.00        perf-profile.children.cycles-pp._IO_setvbuf
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.asm_sysvec_call_function
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.gro_normal_list
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.netif_receive_skb_list_internal
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.__netif_receive_skb_list_core
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.ip_list_rcv
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.signal_wake_up_state
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.sock_sendmsg
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.wake_up_q
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.rwsem_down_read_slowpath
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.rwsem_optimistic_spin
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.rwsem_spin_on_owner
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.pmdp_huge_clear_flush
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.on_each_cpu_cond_mask
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.__change_page_attr_set_clr
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.smp_call_function_single
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.pgd_free
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.schedule_idle
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.resolve_symbol
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.set_next_entity
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.flush_smp_call_function_queue
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.sysvec_call_function
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.timekeeping_advance
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.note_gp_changes
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.__sysvec_call_function
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.vsnprintf
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.do_task_dead
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.devkmsg_read
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.purge_fragmented_blocks_allcpus
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.prepare_creds
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.sendmsg
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.__sys_sendmsg
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.__acct_update_integrals
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.___sys_sendmsg
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.____sys_sendmsg
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.kobject_uevent_env
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.mem_cgroup_uncharge_list
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.lockref_get_not_dead
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.update_cfs_rq_h_load
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.__alloc_fd
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.__anon_vma_prepare
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.security_file_alloc
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.xas_create_range
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.__calc_delta
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.apparmor_file_alloc_security
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.__check_object_size
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.xas_create
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.uncharge_batch
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.preempt_schedule_common
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.epoll_wait
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.file_free_rcu
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.__d_lookup_done
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.strncpy_from_user
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.__x64_sys_ioctl
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.queue_work_on
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.__memcg_kmem_uncharge_page
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.set_memory_nx
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.osq_unlock
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.update_min_vruntime
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.kfree
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.__kmalloc
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.__setup_rt_frame
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.proc_invalidate_siblings_dcache
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.__close_fd
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.netlink_sendmsg
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.__free_pages_ok
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.__x64_sys_epoll_wait
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.do_epoll_wait
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.ep_poll
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.netlink_broadcast_filtered
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.__munmap
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.ioctl
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.down_read
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.perf_event_task_tick
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.strcmp
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.put_cred_rcu
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.pick_file
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.security_task_getsecid
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.enqueue_hrtimer
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.generic_update_time
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.find_symbol
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.each_symbol_section
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.find_exported_symbol_in_section
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.bsearch
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.mod_sysfs_teardown
      0.00            +0.0        0.00        perf-profile.children.cycles-pp._exit
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.recvmsg
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.account_process_tick
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.__mark_inode_dirty
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.vfprintf
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.timerqueue_add
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.timerqueue_del
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.__put_anon_vma
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.__put_task_struct
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.sock_def_readable
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.__sys_recvmsg
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.___sys_recvmsg
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.____sys_recvmsg
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.__x64_sys_pipe
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.__do_pipe_flags
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.complete
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.d_invalidate
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.do_pipe2
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.fifo_open
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.kernfs_remove_by_name_ns
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.ptep_clear_flush
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.shrink_dcache_parent
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.xas_alloc
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.__pipe
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.__hrtimer_get_next_event
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.path_init
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.apparmor_task_getsecid
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.perf_poll
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.create_pipe_files
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.wait_for_completion
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.__libc_read
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.kmsg_read
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.do_syslog
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.it_real_fn
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.kill_pid_info
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.sysfs_remove_group
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.access
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.memset_erms
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.rb_erase
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.vma_policy_mof
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.copy_fpstate_to_sigframe
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.page_add_new_anon_rmap
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.copy_page_to_iter
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.page_get_link
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.queue_delayed_work_on
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.security_file_open
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.perf_ioctl
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.wait_for_partner
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.__do_sys_newfstat
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.pagecache_get_page
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.remove_files
      0.00            +0.0        0.00        perf-profile.children.cycles-pp.netlink_broadcast
      0.05 ± 88%      +0.0        0.07 ± 14%  perf-profile.children.cycles-pp.get_partial_node
      0.26 ± 25%      +0.0        0.29 ±  7%  perf-profile.children.cycles-pp.__vma_rb_erase
      0.20 ± 15%      +0.0        0.24 ±  9%  perf-profile.children.cycles-pp.follow_page
      0.02 ±123%      +0.0        0.06 ± 19%  perf-profile.children.cycles-pp.clockevents_program_event
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.update_curr
      0.00            +0.1        0.06 ± 13%  perf-profile.children.cycles-pp.follow_pmd_mask
      0.01 ±200%      +0.1        0.07 ± 17%  perf-profile.children.cycles-pp.ktime_get
      0.00            +0.1        0.07 ±  6%  perf-profile.children.cycles-pp.update_load_avg
      0.29 ± 21%      +0.1        0.37 ±  5%  perf-profile.children.cycles-pp.exit_to_user_mode_prepare
      0.23 ± 23%      +0.1        0.32        perf-profile.children.cycles-pp._raw_spin_lock
      0.21 ± 22%      +0.1        0.31 ±  5%  perf-profile.children.cycles-pp.vma_migratable
      0.25 ± 22%      +0.1        0.35 ±  6%  perf-profile.children.cycles-pp.task_work_run
      0.25 ± 20%      +0.1        0.35 ±  6%  perf-profile.children.cycles-pp.task_numa_work
      0.08 ± 13%      +0.1        0.20 ±  2%  perf-profile.children.cycles-pp.task_tick_fair
      0.10 ± 11%      +0.2        0.29 ±  3%  perf-profile.children.cycles-pp.scheduler_tick
      1.86 ± 24%      +0.2        2.09 ±  7%  perf-profile.children.cycles-pp.find_vma
      0.14 ± 13%      +0.3        0.44 ±  2%  perf-profile.children.cycles-pp.update_process_times
      0.14 ± 13%      +0.3        0.44 ±  2%  perf-profile.children.cycles-pp.tick_sched_handle
      1.36 ± 24%      +0.3        1.68 ±  9%  perf-profile.children.cycles-pp.find_vma_prev
      0.15 ± 13%      +0.3        0.48 ±  2%  perf-profile.children.cycles-pp.tick_sched_timer
      0.16 ± 12%      +0.4        0.54 ±  2%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      0.23 ± 16%      +0.5        0.69 ±  2%  perf-profile.children.cycles-pp.hrtimer_interrupt
      0.24 ± 16%      +0.5        0.70 ±  3%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      0.35 ± 18%      +0.5        0.83 ±  2%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
      0.26 ± 14%      +0.5        0.77 ±  2%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      0.19 ± 10%      +0.5        0.70 ±  2%  perf-profile.children.cycles-pp.asm_call_sysvec_on_stack
     98.08            +1.6       99.73        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     96.94            +2.4       99.32        perf-profile.children.cycles-pp.do_syscall_64
      0.00            +8.6        8.60        perf-profile.children.cycles-pp.xas_find
      3.68 ± 22%     +86.1       89.79        perf-profile.children.cycles-pp.__x64_sys_madvise
      3.66 ± 22%     +86.1       89.78        perf-profile.children.cycles-pp.do_madvise
     80.11 ±  5%     -78.0        2.12 ± 53%  perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
      0.83 ±123%      -0.8        0.00        perf-profile.self.cycles-pp.syscall_exit_to_user_mode
      0.57 ± 33%      -0.4        0.14 ± 29%  perf-profile.self.cycles-pp.mmap_region
      0.81 ± 25%      -0.3        0.49 ±  5%  perf-profile.self.cycles-pp.kmem_cache_free
      0.55 ± 23%      -0.3        0.28 ± 11%  perf-profile.self.cycles-pp.zap_pte_range
      0.35 ± 23%      -0.2        0.12 ±  4%  perf-profile.self.cycles-pp.kmem_cache_alloc
      0.48 ±  8%      -0.2        0.26 ± 11%  perf-profile.self.cycles-pp.release_pages
      0.22 ± 23%      -0.2        0.00        perf-profile.self.cycles-pp.native_irq_return_iret
      0.17 ±  5%      -0.2        0.00        perf-profile.self.cycles-pp.mem_cgroup_page_lruvec
      0.34 ± 29%      -0.2        0.18 ±  2%  perf-profile.self.cycles-pp.__vma_link_rb
      0.48 ± 20%      -0.2        0.33 ±  4%  perf-profile.self.cycles-pp.__vma_adjust
      0.15 ± 24%      -0.1        0.00        perf-profile.self.cycles-pp.sync_regs
      0.24 ± 21%      -0.1        0.10 ±  4%  perf-profile.self.cycles-pp.syscall_return_via_sysret
      0.14 ±129%      -0.1        0.00        perf-profile.self.cycles-pp.irqentry_exit_to_user_mode
      0.20 ±  4%      -0.1        0.06 ± 19%  perf-profile.self.cycles-pp.__pagevec_lru_add_fn
      0.54 ± 26%      -0.1        0.41 ±  6%  perf-profile.self.cycles-pp.vma_interval_tree_remove
      0.26 ±  4%      -0.1        0.13 ± 24%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.24 ±  4%      -0.1        0.11 ± 22%  perf-profile.self.cycles-pp.mem_cgroup_update_lru_size
      0.13 ±  9%      -0.1        0.00        perf-profile.self.cycles-pp.__mod_node_page_state
      0.13 ± 20%      -0.1        0.00        perf-profile.self.cycles-pp.xas_load
      0.27 ± 17%      -0.1        0.14 ±  6%  perf-profile.self.cycles-pp.vm_area_dup
      0.27 ± 21%      -0.1        0.15 ±  5%  perf-profile.self.cycles-pp.native_flush_tlb_one_user
      0.18 ± 22%      -0.1        0.06 ±  7%  perf-profile.self.cycles-pp.__mod_memcg_lruvec_state
      0.11 ± 13%      -0.1        0.00        perf-profile.self.cycles-pp.follow_page_pte
      0.18 ± 18%      -0.1        0.07 ±  7%  perf-profile.self.cycles-pp.__mod_memcg_state
      0.19 ± 22%      -0.1        0.09 ±  5%  perf-profile.self.cycles-pp.___might_sleep
      0.17 ± 20%      -0.1        0.06 ±  7%  perf-profile.self.cycles-pp.__rb_insert_augmented
      1.39 ± 21%      -0.1        1.28 ±  7%  perf-profile.self.cycles-pp.vma_interval_tree_insert
      0.16 ±  6%      -0.1        0.06 ± 23%  perf-profile.self.cycles-pp._raw_spin_lock_irq
      0.16 ± 33%      -0.1        0.06 ±  7%  perf-profile.self.cycles-pp.get_obj_cgroup_from_current
      0.09 ± 21%      -0.1        0.00        perf-profile.self.cycles-pp.__handle_mm_fault
      0.09 ±  4%      -0.1        0.00        perf-profile.self.cycles-pp.lru_cache_add
      0.09 ±  7%      -0.1        0.00        perf-profile.self.cycles-pp.isolate_lru_page
      0.14 ± 20%      -0.1        0.05        perf-profile.self.cycles-pp.__entry_text_start
      0.19 ± 26%      -0.1        0.10 ±  8%  perf-profile.self.cycles-pp.page_counter_cancel
      0.09 ± 18%      -0.1        0.00        perf-profile.self.cycles-pp.refill_obj_stock
      0.08 ± 20%      -0.1        0.00        perf-profile.self.cycles-pp.down_write_killable
      0.13 ± 22%      -0.1        0.05        perf-profile.self.cycles-pp.up_write
      0.08 ± 33%      -0.1        0.00        perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.08 ± 22%      -0.1        0.00        perf-profile.self.cycles-pp.page_remove_rmap
      0.08 ± 13%      -0.1        0.00        perf-profile.self.cycles-pp.filemap_map_pages
      0.08 ± 20%      -0.1        0.00        perf-profile.self.cycles-pp.__might_sleep
      0.17 ± 21%      -0.1        0.10 ±  9%  perf-profile.self.cycles-pp.__split_vma
      0.07 ± 18%      -0.1        0.00        perf-profile.self.cycles-pp.handle_mm_fault
      0.07 ± 18%      -0.1        0.00        perf-profile.self.cycles-pp.page_add_file_rmap
      0.07 ± 23%      -0.1        0.00        perf-profile.self.cycles-pp.find_get_entry
      0.07 ± 24%      -0.1        0.00        perf-profile.self.cycles-pp.syscall_enter_from_user_mode
      0.07 ± 18%      -0.1        0.00        perf-profile.self.cycles-pp.__slab_free
      0.10 ± 29%      -0.1        0.03 ± 70%  perf-profile.self.cycles-pp.___slab_alloc
      0.10 ± 23%      -0.1        0.03 ± 70%  perf-profile.self.cycles-pp.vmacache_find
      0.18 ±  4%      -0.1        0.12 ± 18%  perf-profile.self.cycles-pp.__list_add_valid
      0.06 ± 18%      -0.1        0.00        perf-profile.self.cycles-pp.vma_interval_tree_augment_rotate
      0.06 ± 14%      -0.1        0.00        perf-profile.self.cycles-pp.obj_cgroup_charge
      0.16 ± 27%      -0.1        0.10 ±  8%  perf-profile.self.cycles-pp.__rb_erase_color
      0.16 ± 17%      -0.1        0.10 ± 19%  perf-profile.self.cycles-pp.__munlock_pagevec
      0.05 ± 53%      -0.1        0.00        perf-profile.self.cycles-pp.mark_page_accessed
      0.28 ±  7%      -0.1        0.23 ± 13%  perf-profile.self.cycles-pp.workingset_age_nonresident
      0.11 ± 15%      -0.0        0.06 ±  8%  perf-profile.self.cycles-pp.free_unref_page_list
      0.05 ± 52%      -0.0        0.00        perf-profile.self.cycles-pp.page_mapping
      0.10 ± 28%      -0.0        0.06 ± 16%  perf-profile.self.cycles-pp.vma_merge
      0.04 ± 51%      -0.0        0.00        perf-profile.self.cycles-pp.lru_add_drain_cpu
      0.04 ± 83%      -0.0        0.00        perf-profile.self.cycles-pp.down_write
      0.04 ± 82%      -0.0        0.00        perf-profile.self.cycles-pp.flush_tlb_mm_range
      0.04 ± 50%      -0.0        0.00        perf-profile.self.cycles-pp._raw_spin_unlock_irqrestore
      0.04 ± 83%      -0.0        0.00        perf-profile.self.cycles-pp.userfaultfd_unmap_prep
      0.23 ± 24%      -0.0        0.19 ±  4%  perf-profile.self.cycles-pp.__do_munmap
      0.03 ± 82%      -0.0        0.00        perf-profile.self.cycles-pp.up_read
      0.03 ± 82%      -0.0        0.00        perf-profile.self.cycles-pp.tlb_gather_mmu
      0.03 ± 81%      -0.0        0.00        perf-profile.self.cycles-pp.follow_page_mask
      0.03 ±123%      -0.0        0.00        perf-profile.self.cycles-pp.vma_gap_callbacks_rotate
      0.13 ± 20%      -0.0        0.10 ± 16%  perf-profile.self.cycles-pp.__list_del_entry_valid
      0.02 ±125%      -0.0        0.00        perf-profile.self.cycles-pp.perf_iterate_sb
      0.02 ±125%      -0.0        0.00        perf-profile.self.cycles-pp.memcpy_erms
      0.02 ±122%      -0.0        0.00        perf-profile.self.cycles-pp.downgrade_write
      0.02 ±123%      -0.0        0.00        perf-profile.self.cycles-pp._cond_resched
      0.02 ±123%      -0.0        0.00        perf-profile.self.cycles-pp.fput_many
      0.02 ±123%      -0.0        0.00        perf-profile.self.cycles-pp.page_counter_try_charge
      0.02 ±123%      -0.0        0.00        perf-profile.self.cycles-pp.__count_memcg_events
      0.02 ±122%      -0.0        0.00        perf-profile.self.cycles-pp.alloc_set_pte
      0.02 ±122%      -0.0        0.00        perf-profile.self.cycles-pp.__set_page_dirty_no_writeback
      0.15 ±  9%      -0.0        0.13 ± 16%  perf-profile.self.cycles-pp.__activate_page
      0.01 ±200%      -0.0        0.00        perf-profile.self.cycles-pp.common_file_perm
      0.01 ±200%      -0.0        0.00        perf-profile.self.cycles-pp.do_mmap
      0.01 ±200%      -0.0        0.00        perf-profile.self.cycles-pp.asm_exc_page_fault
      0.01 ±200%      -0.0        0.00        perf-profile.self.cycles-pp.do_user_addr_fault
      0.01 ±200%      -0.0        0.00        perf-profile.self.cycles-pp.exit_to_user_mode_prepare
      0.01 ±200%      -0.0        0.00        perf-profile.self.cycles-pp.perf_event_mmap
      0.01 ±200%      -0.0        0.00        perf-profile.self.cycles-pp.prepend_name
      0.01 ±200%      -0.0        0.00        perf-profile.self.cycles-pp.__fget_files
      0.01 ±200%      -0.0        0.00        perf-profile.self.cycles-pp.unlock_page
      0.01 ±200%      -0.0        0.00        perf-profile.self.cycles-pp.flush_tlb_func_common
      0.01 ±200%      -0.0        0.00        perf-profile.self.cycles-pp.tlb_finish_mmu
      0.01 ±200%      -0.0        0.00        perf-profile.self.cycles-pp._find_next_bit
      0.01 ±200%      -0.0        0.00        perf-profile.self.cycles-pp.__remove_shared_vm_struct
      0.08 ± 28%      -0.0        0.07        perf-profile.self.cycles-pp.vmacache_update
      0.08 ± 13%      -0.0        0.07 ± 11%  perf-profile.self.cycles-pp.try_grab_page
      0.00            +0.0        0.00        perf-profile.self.cycles-pp.memmap_init_zone_device
      0.00            +0.0        0.00        perf-profile.self.cycles-pp.copy_user_enhanced_fast_string
      0.00            +0.0        0.00        perf-profile.self.cycles-pp.osq_lock
      0.00            +0.0        0.00        perf-profile.self.cycles-pp.shmem_write_end
      0.00            +0.0        0.00        perf-profile.self.cycles-pp.copy_page
      0.00            +0.0        0.00        perf-profile.self.cycles-pp.smp_call_function_many_cond
      0.00            +0.0        0.00        perf-profile.self.cycles-pp.ktime_get_update_offsets_now
      0.00            +0.0        0.00        perf-profile.self.cycles-pp.perf_mmap__read_head
      0.00            +0.0        0.00        perf-profile.self.cycles-pp.__pthread_enable_asynccancel
      0.00            +0.0        0.00        perf-profile.self.cycles-pp.__get_user_nocheck_1
      0.00            +0.0        0.00        perf-profile.self.cycles-pp.mutex_unlock
      0.00            +0.0        0.00        perf-profile.self.cycles-pp.hrtimer_active
      0.00            +0.0        0.00        perf-profile.self.cycles-pp.__pthread_disable_asynccancel
      0.00            +0.0        0.00        perf-profile.self.cycles-pp.intel_idle
      0.00            +0.0        0.00        perf-profile.self.cycles-pp.mutex_lock
      0.00            +0.0        0.00        perf-profile.self.cycles-pp.io_serial_in
      0.00            +0.0        0.00        perf-profile.self.cycles-pp.find_lock_entry
      0.00            +0.0        0.00        perf-profile.self.cycles-pp.clear_page_erms
      0.00            +0.0        0.00        perf-profile.self.cycles-pp.__init_single_page
      0.00            +0.0        0.00        perf-profile.self.cycles-pp.set_pfnblock_flags_mask
      0.00            +0.0        0.00        perf-profile.self.cycles-pp.update_curr
      0.00            +0.0        0.00        perf-profile.self.cycles-pp.vprintk_emit
      0.00            +0.0        0.00        perf-profile.self.cycles-pp.__update_load_avg_se
      0.00            +0.0        0.00        perf-profile.self.cycles-pp.find_idlest_group
      0.00            +0.0        0.00        perf-profile.self.cycles-pp.update_load_avg
      0.00            +0.0        0.00        perf-profile.self.cycles-pp.lapic_next_deadline
      0.00            +0.0        0.00        perf-profile.self.cycles-pp.perf_mmap_fault
      0.00            +0.0        0.00        perf-profile.self.cycles-pp.down_read_trylock
      0.00            +0.0        0.00        perf-profile.self.cycles-pp.change_p4d_range
      0.00            +0.0        0.00        perf-profile.self.cycles-pp.update_sd_lb_stats
      0.00            +0.0        0.00        perf-profile.self.cycles-pp.__update_load_avg_cfs_rq
      0.00            +0.0        0.00        perf-profile.self.cycles-pp.task_tick_fair
      0.00            +0.0        0.00        perf-profile.self.cycles-pp.change_protection
      0.00            +0.0        0.00        perf-profile.self.cycles-pp.tick_sched_timer
      0.00            +0.0        0.00        perf-profile.self.cycles-pp.update_cfs_group
      0.00            +0.0        0.00        perf-profile.self.cycles-pp.mutex_spin_on_owner
      0.00            +0.0        0.00        perf-profile.self.cycles-pp.arch_scale_freq_tick
      0.00            +0.0        0.00        perf-profile.self.cycles-pp.available_idle_cpu
      0.00            +0.0        0.00        perf-profile.self.cycles-pp.run_local_timers
      0.00            +0.0        0.00        perf-profile.self.cycles-pp.select_idle_sibling
      0.00            +0.0        0.00        perf-profile.self.cycles-pp._raw_spin_trylock
      0.00            +0.0        0.00        perf-profile.self.cycles-pp.__sched_text_start
      0.00            +0.0        0.00        perf-profile.self.cycles-pp.shmem_add_to_page_cache
      0.00            +0.0        0.00        perf-profile.self.cycles-pp.rcu_sched_clock_irq
      0.00            +0.0        0.00        perf-profile.self.cycles-pp.update_irq_load_avg
      0.00            +0.0        0.00        perf-profile.self.cycles-pp.sum_zone_numa_state
      0.00            +0.0        0.00        perf-profile.self.cycles-pp.perf_mmap_to_page
      0.00            +0.0        0.00        perf-profile.self.cycles-pp.sum_vm_events
      0.00            +0.0        0.00        perf-profile.self.cycles-pp.__switch_to
      0.00            +0.0        0.00        perf-profile.self.cycles-pp._dl_addr
      0.00            +0.0        0.00        perf-profile.self.cycles-pp.irqtime_account_irq
      0.00            +0.0        0.00        perf-profile.self.cycles-pp.read_tsc
      0.00            +0.0        0.00        perf-profile.self.cycles-pp.trace_module_notify
      0.00            +0.0        0.00        perf-profile.self.cycles-pp.delay_tsc
      0.00            +0.0        0.00        perf-profile.self.cycles-pp.update_nohz_stats
      0.00            +0.0        0.00        perf-profile.self.cycles-pp.native_sched_clock
      0.00            +0.0        0.00        perf-profile.self.cycles-pp.__alloc_file
      0.00            +0.0        0.00        perf-profile.self.cycles-pp.rmqueue_bulk
      0.00            +0.0        0.00        perf-profile.self.cycles-pp.switch_mm_irqs_off
      0.00            +0.0        0.00        perf-profile.self.cycles-pp.calc_global_load_tick
      0.00            +0.0        0.00        perf-profile.self.cycles-pp.llist_add_batch
      0.00            +0.0        0.00        perf-profile.self.cycles-pp.part_stat_read_all
      0.00            +0.0        0.00        perf-profile.self.cycles-pp.__do_fault
      0.00            +0.0        0.00        perf-profile.self.cycles-pp.update_blocked_averages
      0.00            +0.0        0.00        perf-profile.self.cycles-pp.hrtimer_interrupt
      0.00            +0.0        0.00        perf-profile.self.cycles-pp.load_balance
      0.00            +0.0        0.00        perf-profile.self.cycles-pp.reweight_entity
      0.00            +0.0        0.00        perf-profile.self.cycles-pp.switch_fpu_return
      0.00            +0.0        0.00        perf-profile.self.cycles-pp.blk_mq_queue_tag_busy_iter
      0.00            +0.0        0.00        perf-profile.self.cycles-pp.update_rq_clock
      0.00            +0.0        0.00        perf-profile.self.cycles-pp.account_user_time
      0.00            +0.0        0.00        perf-profile.self.cycles-pp.try_charge
      0.00            +0.0        0.00        perf-profile.self.cycles-pp.xas_find_conflict
      0.00            +0.0        0.00        perf-profile.self.cycles-pp.cpuacct_charge
      0.00            +0.0        0.00        perf-profile.self.cycles-pp.rcu_segcblist_enqueue
      0.00            +0.0        0.00        perf-profile.self.cycles-pp.__legitimize_mnt
      0.00            +0.0        0.00        perf-profile.self.cycles-pp.collapse_huge_page
      0.00            +0.0        0.00        perf-profile.self.cycles-pp.record__mmap_read_evlist
      0.00            +0.0        0.00        perf-profile.self.cycles-pp.__d_lookup_rcu
      0.00            +0.0        0.00        perf-profile.self.cycles-pp.get_mem_cgroup_from_mm
      0.00            +0.0        0.00        perf-profile.self.cycles-pp.resched_curr
      0.00            +0.0        0.00        perf-profile.self.cycles-pp.irqtime_account_process_tick
      0.00            +0.0        0.00        perf-profile.self.cycles-pp.rcu_cblist_dequeue
      0.00            +0.0        0.00        perf-profile.self.cycles-pp.sys_imageblit
      0.00            +0.0        0.00        perf-profile.self.cycles-pp.__fsnotify_parent
      0.00            +0.0        0.00        perf-profile.self.cycles-pp.asm_sysvec_apic_timer_interrupt
      0.00            +0.0        0.00        perf-profile.self.cycles-pp.__hrtimer_run_queues
      0.00            +0.0        0.00        perf-profile.self.cycles-pp.scheduler_tick
      0.00            +0.0        0.00        perf-profile.self.cycles-pp.khugepaged_scan_pmd
      0.00            +0.0        0.00        perf-profile.self.cycles-pp.enqueue_entity
      0.00            +0.0        0.00        perf-profile.self.cycles-pp.refresh_cpu_vm_stats
      0.00            +0.0        0.00        perf-profile.self.cycles-pp.__accumulate_pelt_segments
      0.00            +0.0        0.00        perf-profile.self.cycles-pp.rcu_implicit_dynticks_qs
      0.00            +0.0        0.00        perf-profile.self.cycles-pp.trigger_load_balance
      0.00            +0.0        0.00        perf-profile.self.cycles-pp.anon_vma_interval_tree_remove
      0.00            +0.0        0.00        perf-profile.self.cycles-pp.strnlen_user
      0.00            +0.0        0.00        perf-profile.self.cycles-pp.__hrtimer_next_event_base
      0.00            +0.0        0.00        perf-profile.self.cycles-pp.kstat_irqs
      0.00            +0.0        0.00        perf-profile.self.cycles-pp.__switch_to_asm
      0.00            +0.0        0.00        perf-profile.self.cycles-pp.rwsem_spin_on_owner
      0.00            +0.0        0.00        perf-profile.self.cycles-pp.smp_call_function_single
      0.00            +0.0        0.00        perf-profile.self.cycles-pp._vm_unmap_aliases
      0.00            +0.0        0.00        perf-profile.self.cycles-pp.prep_new_page
      0.00            +0.0        0.00        perf-profile.self.cycles-pp.purge_fragmented_blocks_allcpus
      0.00            +0.0        0.00        perf-profile.self.cycles-pp.__acct_update_integrals
      0.00            +0.0        0.00        perf-profile.self.cycles-pp.lockref_get_not_dead
      0.00            +0.0        0.00        perf-profile.self.cycles-pp.update_cfs_rq_h_load
      0.00            +0.0        0.00        perf-profile.self.cycles-pp.do_dentry_open
      0.00            +0.0        0.00        perf-profile.self.cycles-pp.copy_pte_range
      0.00            +0.0        0.00        perf-profile.self.cycles-pp.__calc_delta
      0.00            +0.0        0.00        perf-profile.self.cycles-pp.apparmor_file_alloc_security
      0.00            +0.0        0.00        perf-profile.self.cycles-pp.select_task_rq_fair
      0.00            +0.0        0.00        perf-profile.self.cycles-pp.file_free_rcu
      0.00            +0.0        0.00        perf-profile.self.cycles-pp.osq_unlock
      0.00            +0.0        0.00        perf-profile.self.cycles-pp.update_min_vruntime
      0.00            +0.0        0.00        perf-profile.self.cycles-pp.__alloc_pages_nodemask
      0.00            +0.0        0.00        perf-profile.self.cycles-pp.stack_trace_save_tsk
      0.00            +0.0        0.00        perf-profile.self.cycles-pp.timekeeping_advance
      0.00            +0.0        0.00        perf-profile.self.cycles-pp.down_read
      0.00            +0.0        0.00        perf-profile.self.cycles-pp.perf_event_task_tick
      0.00            +0.0        0.00        perf-profile.self.cycles-pp.strcmp
      0.00            +0.0        0.00        perf-profile.self.cycles-pp.account_process_tick
      0.00            +0.0        0.00        perf-profile.self.cycles-pp.get_page_from_freelist
      0.00            +0.0        0.00        perf-profile.self.cycles-pp.rebalance_domains
      0.00            +0.0        0.00        perf-profile.self.cycles-pp.task_numa_work
      0.00            +0.0        0.00        perf-profile.self.cycles-pp.pick_next_task_fair
      0.00            +0.0        0.00        perf-profile.self.cycles-pp.sched_clock
      0.00            +0.0        0.00        perf-profile.self.cycles-pp.flush_smp_call_function_queue
      0.00            +0.0        0.00        perf-profile.self.cycles-pp.prepare_creds
      0.00            +0.0        0.00        perf-profile.self.cycles-pp.lockref_put_or_lock
      0.00            +0.0        0.00        perf-profile.self.cycles-pp.__mark_inode_dirty
      0.00            +0.0        0.00        perf-profile.self.cycles-pp.vfprintf
      0.00            +0.0        0.00        perf-profile.self.cycles-pp.__hrtimer_get_next_event
      0.00            +0.0        0.00        perf-profile.self.cycles-pp.memset_erms
      0.26 ± 25%      +0.0        0.28 ±  7%  perf-profile.self.cycles-pp.__vma_rb_erase
      0.11 ± 20%      +0.0        0.15 ±  8%  perf-profile.self.cycles-pp.unmap_page_range
      0.19 ± 21%      +0.1        0.24        perf-profile.self.cycles-pp._raw_spin_lock
      0.01 ±200%      +0.1        0.07 ± 14%  perf-profile.self.cycles-pp.ktime_get
      0.00            +0.1        0.06 ±  8%  perf-profile.self.cycles-pp.follow_pmd_mask
      0.21 ± 23%      +0.1        0.30 ±  6%  perf-profile.self.cycles-pp.vma_migratable
      1.67 ± 23%      +0.3        1.95 ±  8%  perf-profile.self.cycles-pp.find_vma
      0.00            +7.9        7.95        perf-profile.self.cycles-pp.xas_find
      0.30 ± 23%     +77.8       78.12        perf-profile.self.cycles-pp.do_madvise


Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


Thanks,
Rong Chen


--gMqNd2jlyJQcupG/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="config-5.9.0-02740-ge6e88712e43b7"

#
# Automatically generated file; DO NOT EDIT.
# Linux/x86_64 5.9.0 Kernel Configuration
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
CONFIG_KVM_AMD=m
CONFIG_KVM_AMD_SEV=y
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
CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
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
# CONFIG_SCSI_SAS_ATA is not set
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
# CONFIG_SCSI_ISCI is not set
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
CONFIG_TIGON3=y
CONFIG_TIGON3_HWMON=y
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
CONFIG_SKGE=y
# CONFIG_SKGE_DEBUG is not set
# CONFIG_SKGE_GENESIS is not set
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
CONFIG_YELLOWFIN=m
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
CONFIG_8139CP=y
CONFIG_8139TOO=y
CONFIG_8139TOO_PIO=y
# CONFIG_8139TOO_TUNE_TWISTER is not set
# CONFIG_8139TOO_8129 is not set
# CONFIG_8139_OLD_RX_RESET is not set
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
CONFIG_USB_CATC=y
CONFIG_USB_KAWETH=y
CONFIG_USB_PEGASUS=y
CONFIG_USB_RTL8150=y
CONFIG_USB_RTL8152=m
# CONFIG_USB_LAN78XX is not set
CONFIG_USB_USBNET=y
CONFIG_USB_NET_AX8817X=y
CONFIG_USB_NET_AX88179_178A=y
CONFIG_USB_NET_CDCETHER=y
CONFIG_USB_NET_CDC_EEM=y
CONFIG_USB_NET_CDC_NCM=y
# CONFIG_USB_NET_HUAWEI_CDC_NCM is not set
# CONFIG_USB_NET_CDC_MBIM is not set
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
# CONFIG_USB_ALI_M5632 is not set
# CONFIG_USB_AN2720 is not set
CONFIG_USB_BELKIN=y
CONFIG_USB_ARMLINUX=y
# CONFIG_USB_EPSON2888 is not set
# CONFIG_USB_KC2190 is not set
CONFIG_USB_NET_ZAURUS=y
# CONFIG_USB_NET_CX82310_ETH is not set
# CONFIG_USB_NET_KALMIA is not set
# CONFIG_USB_NET_QMI_WWAN is not set
# CONFIG_USB_HSO is not set
CONFIG_USB_NET_INT51X1=y
CONFIG_USB_IPHETH=y
CONFIG_USB_SIERRA_NET=y
# CONFIG_USB_VL600 is not set
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
CONFIG_NVM=y
# CONFIG_NVM_PBLK is not set

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
CONFIG_VIRTIO_CONSOLE=y
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
CONFIG_PINCTRL_INTEL=m
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
# CONFIG_CHARGER_BQ2515X is not set
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
CONFIG_VIRTIO_BALLOON=y
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
# CONFIG_MST_IRQ is not set
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
# CONFIG_EXT2_FS is not set
# CONFIG_EXT3_FS is not set
CONFIG_EXT4_FS=y
CONFIG_EXT4_USE_FOR_EXT2=y
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
CONFIG_CRYPTO_DEV_CCP_DD=y
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
CONFIG_RCU_PERF_TEST=m
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
# CONFIG_BITS_TEST is not set
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

--gMqNd2jlyJQcupG/
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment; filename=reproduce


for cpu_dir in /sys/devices/system/cpu/cpu[0-9]*
do
	online_file="$cpu_dir"/online
	[ -f "$online_file" ] && [ "$(cat "$online_file")" -eq 0 ] && continue

	file="$cpu_dir"/cpufreq/scaling_governor
	[ -f "$file" ] && echo "performance" > "$file"
done

 "stress-ng" "--timeout" "100" "--times" "--verify" "--metrics-brief" "--sequential" "96" "--class" "memory" "--minimize" "--exclude" "spawn,exec,swap,stack,atomic,bad-altstack,bsearch,context,full,heapsort,hsearch,judy,lockbus,lsearch,malloc,matrix-3d,matrix,mcontend,membarrier,memcpy,memfd,memrate,memthrash,mergesort,mincore,null,numa,pipe,pipeherd,qsort,radixsort,remap,resources,rmap,shellsort,skiplist,stackmmap,str,stream,tlb-shootdown,tree,tsearch,vm-addr,vm-rw,vm-segv,vm,wcs,zero,zlib"

--gMqNd2jlyJQcupG/
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment; filename="job.yaml"

---

#! jobs/stress-ng-part2.yaml
suite: stress-ng
testcase: stress-ng
category: benchmark
nr_threads: 100%
timeout: 30m
disk: 1HDD
testtime: 100s
stress-ng:
  class: memory
job_origin: "/lkp-src/allot/cyclic:p1:linux-devel:devel-hourly/lkp-csl-2sp5/stress-ng-part2.yaml"
perf-profile:
  delay: 10
  duration: 3
tf-c2c:
  duration: 5
  delay: 50

#! queue options
queue_cmdline_keys:
- user
schedule_notify_address: 
queue: feng
testbox: lkp-csl-2sp3
tbox_group: lkp-csl-2sp3
branch: linus/master
commit: e6e88712e43b7942df451508aafc2f083266f56b
kconfig: x86_64-rhel-8.3
repeat_to: 1
submit_id: 5f9640fe0b9a93aca5173202
job_file: "/lkp/jobs/scheduled/lkp-csl-2sp3/stress-ng-memory-performance-1HDD-100%-100s-ucode=0x400002c-monitor=3472ca3d-debian-10.4-x86_64-20200603.cgz-e6e88712e43b7942df4-20201026-44197-1tg089z-0.yaml"
id: '008ed50f01e323d445e3f1af001fe673bbc47dac'
queuer_version: "/lkp/feng/.src-20201026-111719"

#! hosts/lkp-csl-2sp3
model: Cascade Lake
nr_node: 2
nr_cpu: 96
memory: 128G
nr_hdd_partitions: 1
nr_ssd_partitions: 2
hdd_partitions: "/dev/disk/by-id/ata-WDC_WD2500BEKT-00PVMT0_WD-WX11A23L4840-part1"
ssd_partitions: "/dev/nvme1n1p1 /dev/nvme0n1p1"
rootfs_partition: "/dev/disk/by-id/ata-INTEL_SSDSC2CW240A3_CVCV204303WP240CGN-part1"
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
mpstat: 

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
- CONFIG_SECURITY_APPARMOR=y

#! include/stress-ng

#! include/testbox/lkp-csl-2sp3
need_kconfig_hw:
- CONFIG_IGB=y
- CONFIG_SATA_AHCI
- CONFIG_BLK_DEV_NVME
ucode: '0x400002c'
ucode_initrd: "/osimage/ucode/intel-ucode-20191114.cgz"

#! user overrides
user: feng
rootfs: debian-10.4-x86_64-20200603.cgz
monitor_sha: 3472ca3d
enqueue_time: 2020-10-26 11:22:39.104557027 +08:00
compiler: gcc-9
_id: 5f9640fe0b9a93aca5173202
_rt: "/result/stress-ng/memory-performance-1HDD-100%-100s-ucode=0x400002c-monitor=3472ca3d/lkp-csl-2sp3/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/e6e88712e43b7942df451508aafc2f083266f56b"

#! schedule options
kernel: "/pkg/linux/x86_64-rhel-8.3/gcc-9/e6e88712e43b7942df451508aafc2f083266f56b/vmlinuz-5.9.0-02740-ge6e88712e43b79"
result_root: "/result/stress-ng/memory-performance-1HDD-100%-100s-ucode=0x400002c-monitor=3472ca3d/lkp-csl-2sp3/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/e6e88712e43b7942df451508aafc2f083266f56b/0"
dequeue_time: 2020-10-26 11:26:47.298252968 +08:00
scheduler_version: "/lkp/lkp/.src-20201023-152631"
LKP_SERVER: internal-lkp-server
arch: x86_64
max_uptime: 1800
initrd: "/osimage/debian/debian-10.4-x86_64-20200603.cgz"
bootloader_append:
- root=/dev/ram0
- user=feng
- job=/lkp/jobs/scheduled/lkp-csl-2sp3/stress-ng-memory-performance-1HDD-100%-100s-ucode=0x400002c-monitor=3472ca3d-debian-10.4-x86_64-20200603.cgz-e6e88712e43b7942df4-20201026-44197-1tg089z-0.yaml
- ARCH=x86_64
- kconfig=x86_64-rhel-8.3
- branch=linus/master
- commit=e6e88712e43b7942df451508aafc2f083266f56b
- BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3/gcc-9/e6e88712e43b7942df451508aafc2f083266f56b/vmlinuz-5.9.0-02740-ge6e88712e43b79
- acpi_rsdp=0x68b85014
- max_uptime=1800
- RESULT_ROOT=/result/stress-ng/memory-performance-1HDD-100%-100s-ucode=0x400002c-monitor=3472ca3d/lkp-csl-2sp3/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/e6e88712e43b7942df451508aafc2f083266f56b/0
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
modules_initrd: "/pkg/linux/x86_64-rhel-8.3/gcc-9/e6e88712e43b7942df451508aafc2f083266f56b/modules.cgz"
bm_initrd: "/osimage/deps/debian-10.4-x86_64-20200603.cgz/run-ipconfig_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/lkp_20200709.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/rsync-rootfs_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/stress-ng_20201007.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/stress-ng-x86_64-0.11-06_20201007.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/perf_20200723.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/perf-x86_64-c85fb28b6f99-1_20201008.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/mpstat_20200714.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/sar-x86_64-34c92ae-1_20200702.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/hw_20200715.cgz"
lkp_initrd: "/osimage/user/feng/lkp-x86_64.cgz"
site: inn

#! /lkp/lkp/.src-20201023-152631/include/site/inn
LKP_CGI_PORT: 80
LKP_CIFS_PORT: 139
oom-killer: 
watchdog: 

#! runtime status
job_state: finished
last_kernel: 5.9.0-02739-gf5df8635c5a3c9
loadavg: 57.24 27.07 10.24 1/860 5648
start_time: '1550139127'
end_time: '1550139234'
version: "/lkp/feng/.src-20201026-111719:4f976aa:f7e65bf"

--gMqNd2jlyJQcupG/
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment; filename=job-script

#!/bin/sh

export_top_env()
{
	export suite='stress-ng'
	export testcase='stress-ng'
	export category='benchmark'
	export nr_threads=96
	export timeout='30m'
	export testtime=100
	export job_origin='/lkp-src/allot/cyclic:p1:linux-devel:devel-hourly/lkp-csl-2sp5/stress-ng-part2.yaml'
	export queue_cmdline_keys='user'
	export schedule_notify_address=
	export queue='feng'
	export testbox='lkp-csl-2sp3'
	export tbox_group='lkp-csl-2sp3'
	export branch='linus/master'
	export commit='e6e88712e43b7942df451508aafc2f083266f56b'
	export kconfig='x86_64-rhel-8.3'
	export repeat_to=1
	export submit_id='5f9640fe0b9a93aca5173202'
	export job_file='/lkp/jobs/scheduled/lkp-csl-2sp3/stress-ng-memory-performance-1HDD-100%-100s-ucode=0x400002c-monitor=3472ca3d-debian-10.4-x86_64-20200603.cgz-e6e88712e43b7942df4-20201026-44197-1tg089z-0.yaml'
	export id='008ed50f01e323d445e3f1af001fe673bbc47dac'
	export queuer_version='/lkp/feng/.src-20201026-111719'
	export model='Cascade Lake'
	export nr_node=2
	export nr_cpu=96
	export memory='128G'
	export nr_hdd_partitions=1
	export nr_ssd_partitions=2
	export hdd_partitions='/dev/disk/by-id/ata-WDC_WD2500BEKT-00PVMT0_WD-WX11A23L4840-part1'
	export ssd_partitions='/dev/nvme1n1p1 /dev/nvme0n1p1'
	export rootfs_partition='/dev/disk/by-id/ata-INTEL_SSDSC2CW240A3_CVCV204303WP240CGN-part1'
	export kernel_cmdline_hw='acpi_rsdp=0x68b85014'
	export brand='Intel(R) Xeon(R) Platinum 8260L CPU @ 2.40GHz'
	export need_kconfig='CONFIG_BLK_DEV_SD
CONFIG_SCSI
CONFIG_BLOCK=y
CONFIG_SATA_AHCI
CONFIG_SATA_AHCI_PLATFORM
CONFIG_ATA
CONFIG_PCI=y
CONFIG_SECURITY_APPARMOR=y'
	export need_kconfig_hw='CONFIG_IGB=y
CONFIG_SATA_AHCI
CONFIG_BLK_DEV_NVME'
	export ucode='0x400002c'
	export ucode_initrd='/osimage/ucode/intel-ucode-20191114.cgz'
	export user='feng'
	export rootfs='debian-10.4-x86_64-20200603.cgz'
	export monitor_sha='3472ca3d'
	export enqueue_time='2020-10-26 11:22:39 +0800'
	export compiler='gcc-9'
	export _id='5f9640fe0b9a93aca5173202'
	export _rt='/result/stress-ng/memory-performance-1HDD-100%-100s-ucode=0x400002c-monitor=3472ca3d/lkp-csl-2sp3/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/e6e88712e43b7942df451508aafc2f083266f56b'
	export kernel='/pkg/linux/x86_64-rhel-8.3/gcc-9/e6e88712e43b7942df451508aafc2f083266f56b/vmlinuz-5.9.0-02740-ge6e88712e43b79'
	export result_root='/result/stress-ng/memory-performance-1HDD-100%-100s-ucode=0x400002c-monitor=3472ca3d/lkp-csl-2sp3/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/e6e88712e43b7942df451508aafc2f083266f56b/0'
	export dequeue_time='2020-10-26 11:26:47 +0800'
	export scheduler_version='/lkp/lkp/.src-20201023-152631'
	export LKP_SERVER='internal-lkp-server'
	export arch='x86_64'
	export max_uptime=1800
	export initrd='/osimage/debian/debian-10.4-x86_64-20200603.cgz'
	export bootloader_append='root=/dev/ram0
user=feng
job=/lkp/jobs/scheduled/lkp-csl-2sp3/stress-ng-memory-performance-1HDD-100%-100s-ucode=0x400002c-monitor=3472ca3d-debian-10.4-x86_64-20200603.cgz-e6e88712e43b7942df4-20201026-44197-1tg089z-0.yaml
ARCH=x86_64
kconfig=x86_64-rhel-8.3
branch=linus/master
commit=e6e88712e43b7942df451508aafc2f083266f56b
BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3/gcc-9/e6e88712e43b7942df451508aafc2f083266f56b/vmlinuz-5.9.0-02740-ge6e88712e43b79
acpi_rsdp=0x68b85014
max_uptime=1800
RESULT_ROOT=/result/stress-ng/memory-performance-1HDD-100%-100s-ucode=0x400002c-monitor=3472ca3d/lkp-csl-2sp3/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/e6e88712e43b7942df451508aafc2f083266f56b/0
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
	export modules_initrd='/pkg/linux/x86_64-rhel-8.3/gcc-9/e6e88712e43b7942df451508aafc2f083266f56b/modules.cgz'
	export bm_initrd='/osimage/deps/debian-10.4-x86_64-20200603.cgz/run-ipconfig_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/lkp_20200709.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/rsync-rootfs_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/stress-ng_20201007.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/stress-ng-x86_64-0.11-06_20201007.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/perf_20200723.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/perf-x86_64-c85fb28b6f99-1_20201008.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/mpstat_20200714.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/sar-x86_64-34c92ae-1_20200702.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/hw_20200715.cgz'
	export lkp_initrd='/osimage/user/feng/lkp-x86_64.cgz'
	export site='inn'
	export LKP_CGI_PORT=80
	export LKP_CIFS_PORT=139
	export job_initrd='/lkp/jobs/scheduled/lkp-csl-2sp3/stress-ng-memory-performance-1HDD-100%-100s-ucode=0x400002c-monitor=3472ca3d-debian-10.4-x86_64-20200603.cgz-e6e88712e43b7942df4-20201026-44197-1tg089z-0.cgz'

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

	run_monitor delay=10 duration=3 $LKP_SRC/monitors/no-stdout/wrapper perf-profile
	run_monitor duration=5 delay=50 $LKP_SRC/monitors/wrapper tf-c2c
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
	run_monitor $LKP_SRC/monitors/wrapper mpstat
	run_monitor $LKP_SRC/monitors/wrapper oom-killer
	run_monitor $LKP_SRC/monitors/plain/watchdog

	run_test class='memory' $LKP_SRC/tests/wrapper stress-ng
}

extract_stats()
{
	export stats_part_begin=
	export stats_part_end=

	$LKP_SRC/stats/wrapper stress-ng
	$LKP_SRC/stats/wrapper perf-profile
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
	$LKP_SRC/stats/wrapper mpstat

	$LKP_SRC/stats/wrapper time stress-ng.time
	$LKP_SRC/stats/wrapper dmesg
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper last_state
	$LKP_SRC/stats/wrapper stderr
	$LKP_SRC/stats/wrapper time
}

"$@"

--gMqNd2jlyJQcupG/--
