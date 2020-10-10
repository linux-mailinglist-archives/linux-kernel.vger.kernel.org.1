Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2964D289FB0
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Oct 2020 11:59:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728815AbgJJJzN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Oct 2020 05:55:13 -0400
Received: from mga11.intel.com ([192.55.52.93]:51591 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726664AbgJJJth (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Oct 2020 05:49:37 -0400
IronPort-SDR: FJ+HQcqZE2U+jEiGsSvDAp/UKaDUaCG9Bk1qi4rfGLHiki3eMxvdInho4hvN5AIkQN9LWNF8b3
 FP+TusAyQWpw==
X-IronPort-AV: E=McAfee;i="6000,8403,9769"; a="162109863"
X-IronPort-AV: E=Sophos;i="5.77,358,1596524400"; 
   d="yaml'?scan'208";a="162109863"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2020 02:43:42 -0700
IronPort-SDR: xTjQtTzKA2yXNAuFW+D6rqmbMhpuoJxjp0U7Mxfy5tFgaH3/I65Kxr1UUN/qAfcLtF96B1k2hU
 W7uD5RlwpeFw==
X-IronPort-AV: E=Sophos;i="5.77,358,1596524400"; 
   d="yaml'?scan'208";a="529263092"
Received: from shao2-debian.sh.intel.com (HELO localhost) ([10.239.13.3])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2020 02:43:18 -0700
Date:   Sat, 10 Oct 2020 17:42:30 +0800
From:   kernel test robot <rong.a.chen@intel.com>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com, ying.huang@intel.com, feng.tang@intel.com,
        zhengjun.xing@intel.com
Subject: [f2fs] 79963d967b: aim7.jobs-per-min 468.8% improvement
Message-ID: <20201010094230.GB393@shao2-debian>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="mWEPrn9k3Wj8m9KK"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: NeoMutt/20170113 (1.7.2)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mWEPrn9k3Wj8m9KK
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Greeting,

FYI, we noticed a 468.8% improvement of aim7.jobs-per-min due to commit:


commit: 79963d967b492876fa17c8c2c2c17b7438683d9b ("f2fs: shrink node_write lock coverage")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master


in testcase: aim7
on test machine: 192 threads Intel(R) Xeon(R) Platinum 9242 CPU @ 2.30GHz with 192G memory
with following parameters:

	disk: 1BRD_48G
	fs: f2fs
	test: sync_disk_rw
	load: 200
	cpufreq_governor: performance
	ucode: 0x5002f01

test-description: AIM7 is a traditional UNIX system level benchmark suite which is used to test and measure the performance of multiuser system.
test-url: https://sourceforge.net/projects/aimbench/files/aim-suite7/





Details are as below:
-------------------------------------------------------------------------------------------------->


To reproduce:

        git clone https://github.com/intel/lkp-tests.git
        cd lkp-tests
        bin/lkp install job.yaml  # job file is attached in this email
        bin/lkp run     job.yaml

=========================================================================================
compiler/cpufreq_governor/disk/fs/kconfig/load/rootfs/tbox_group/test/testcase/ucode:
  gcc-9/performance/1BRD_48G/f2fs/x86_64-rhel-8.3/200/debian-10.4-x86_64-20200603.cgz/lkp-csl-2ap2/sync_disk_rw/aim7/0x5002f01

commit: 
  fa6795552a ("f2fs: fix to document reserved special compression extension")
  79963d967b ("f2fs: shrink node_write lock coverage")

fa6795552ad20509 79963d967b492876fa17c8c2c2c 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
      1370 ±  2%    +468.8%       7792 ± 15%  aim7.jobs-per-min
    876.51 ±  2%     -81.9%     158.27 ± 17%  aim7.time.elapsed_time
    876.51 ±  2%     -81.9%     158.27 ± 17%  aim7.time.elapsed_time.max
 1.604e+08            +3.3%  1.657e+08        aim7.time.file_system_outputs
     41711 ±  2%     -56.5%      18159 ±  8%  aim7.time.involuntary_context_switches
      2844            -1.5%       2800        aim7.time.maximum_resident_set_size
    117378 ±  4%     -55.7%      51974 ±  6%  aim7.time.minor_page_faults
     17820 ±  2%     -64.2%       6388 ± 11%  aim7.time.system_time
  15577866          +115.4%   33561536 ± 13%  aim7.time.voluntary_context_switches
     88.28           -11.6%      78.04 ±  2%  iostat.cpu.idle
     11.71 ±  2%     +87.1%      21.91 ±  8%  iostat.cpu.system
   4604431 ±  9%     -14.4%    3939581 ±  2%  numa-numastat.node2.local_node
   4629384 ±  9%     -14.4%    3964542 ±  3%  numa-numastat.node2.numa_hit
     88.25           -10.5       77.78 ±  2%  mpstat.cpu.all.idle%
      0.00 ±200%      +0.0        0.00 ±100%  mpstat.cpu.all.iowait%
     10.65 ±  2%     +10.5       21.16 ±  9%  mpstat.cpu.all.sys%
      0.01            +0.0        0.05 ± 17%  mpstat.cpu.all.usr%
     87.80           -11.8%      77.40 ±  2%  vmstat.cpu.id
     90927 ±  2%    +478.5%     526006 ± 16%  vmstat.io.bo
     21.40 ±  4%     +85.0%      39.60 ± 11%  vmstat.procs.r
     40230 ±  2%   +1010.3%     446688 ± 25%  vmstat.system.cs
    385344            +3.0%     396868        vmstat.system.in
 1.354e+11 ± 11%     -82.8%  2.323e+10 ± 19%  cpuidle.C1E.time
 2.672e+08 ± 23%     -71.6%   75950107 ±  7%  cpuidle.C1E.usage
 1.007e+10 ±137%     -98.3%  1.752e+08 ± 51%  cpuidle.C6.time
  16563905 ±149%     -97.9%     349707 ± 36%  cpuidle.C6.usage
   3816407 ± 20%    +109.1%    7979303 ± 22%  cpuidle.POLL.time
   1164151 ±  2%    +146.2%    2866043 ± 28%  cpuidle.POLL.usage
    231796           -26.6%     170051 ±  8%  meminfo.AnonHugePages
    679298 ±  5%     +10.5%     750947        meminfo.Committed_AS
     68768           +28.4%      88313 ±  3%  meminfo.Dirty
      1742 ± 18%     -49.7%     877.40 ± 51%  meminfo.Mlocked
     71475           +41.4%     101091 ± 15%  meminfo.Shmem
    517.00 ±  3%    +667.8%       3969 ± 31%  meminfo.Writeback
     61981 ±  2%    +463.8%     349439 ± 15%  meminfo.max_used_kB
     96239 ± 63%     -74.3%      24717 ± 44%  numa-meminfo.node0.AnonHugePages
     16746 ±  4%     +31.4%      22001 ±  3%  numa-meminfo.node0.Dirty
    214.20 ±  7%    +521.9%       1332 ± 27%  numa-meminfo.node0.Writeback
      1395 ±  2%     +20.3%       1678 ±  6%  numa-meminfo.node1.Active(file)
     17299 ±  3%     +29.1%      22334 ±  3%  numa-meminfo.node1.Dirty
    210.40 ±  9%    +508.3%       1279 ± 28%  numa-meminfo.node1.Writeback
     17612 ±  5%     +24.7%      21966 ±  3%  numa-meminfo.node2.Dirty
     51522 ±  6%     -10.6%      46075 ±  2%  numa-meminfo.node2.Inactive(file)
    208.60 ±  7%    +467.0%       1182 ± 23%  numa-meminfo.node2.Writeback
     74287 ± 18%    +120.3%     163676 ± 47%  numa-meminfo.node3.Active
     72903 ± 19%    +121.8%     161688 ± 47%  numa-meminfo.node3.Active(anon)
      1383 ±  3%     +43.6%       1987 ± 34%  numa-meminfo.node3.Active(file)
     16997 ±  2%     +29.7%      22046 ±  3%  numa-meminfo.node3.Dirty
    344385 ±  4%     +12.3%     386888 ±  2%  numa-meminfo.node3.FilePages
     47297 ± 14%     +72.4%      81527 ± 17%  numa-meminfo.node3.Shmem
    198.20 ±  4%    +471.1%       1132 ± 26%  numa-meminfo.node3.Writeback
    216435 ±  3%      -8.3%     198505        slabinfo.dentry.active_objs
      5188 ±  3%      -8.0%       4770        slabinfo.dentry.active_slabs
    217935 ±  3%      -8.0%     200398        slabinfo.dentry.num_objs
      5188 ±  3%      -8.0%       4770        slabinfo.dentry.num_slabs
     27011           -13.5%      23361        slabinfo.ext4_pending_reservation.active_objs
     27011           -13.5%      23361        slabinfo.ext4_pending_reservation.num_objs
    140304 ±  4%     -12.7%     122490 ±  3%  slabinfo.filp.active_objs
      2204 ±  3%     -12.6%       1927 ±  3%  slabinfo.filp.active_slabs
    141088 ±  3%     -12.6%     123363 ±  3%  slabinfo.filp.num_objs
      2204 ±  3%     -12.6%       1927 ±  3%  slabinfo.filp.num_slabs
    386.20 ± 12%     -62.7%     144.20 ±  3%  slabinfo.nfs_read_data.active_objs
    386.20 ± 12%     -62.7%     144.20 ±  3%  slabinfo.nfs_read_data.num_objs
      1133 ±  7%     -30.5%     787.60 ±  6%  slabinfo.skbuff_fclone_cache.active_objs
      1133 ±  7%     -30.5%     787.60 ±  6%  slabinfo.skbuff_fclone_cache.num_objs
      1585 ±  6%     -12.8%       1382 ±  9%  slabinfo.task_group.active_objs
      1585 ±  6%     -12.8%       1382 ±  9%  slabinfo.task_group.num_objs
     26573           -28.1%      19116 ±  3%  slabinfo.vmap_area.active_objs
    445.60           -33.0%     298.40 ±  3%  slabinfo.vmap_area.active_slabs
     28545           -33.0%      19130 ±  3%  slabinfo.vmap_area.num_objs
    445.60           -33.0%     298.40 ±  3%  slabinfo.vmap_area.num_slabs
      4185 ±  4%     +30.2%       5450 ±  3%  numa-vmstat.node0.nr_dirty
     51.80 ±  5%    +503.9%     312.80 ± 25%  numa-vmstat.node0.nr_writeback
      4312 ±  4%     +29.9%       5603        numa-vmstat.node0.nr_zone_write_pending
    348.80 ±  2%     +20.2%     419.20 ±  7%  numa-vmstat.node1.nr_active_file
      4329 ±  3%     +28.0%       5543        numa-vmstat.node1.nr_dirty
     93.00 ± 18%     -49.7%      46.80 ± 51%  numa-vmstat.node1.nr_mlock
     52.20 ±  7%    +468.2%     296.60 ± 23%  numa-vmstat.node1.nr_writeback
    348.80 ±  2%     +20.2%     419.20 ±  7%  numa-vmstat.node1.nr_zone_active_file
      4456 ±  4%     +27.0%       5662        numa-vmstat.node1.nr_zone_write_pending
   3004701 ±  6%      -9.0%    2735334 ±  4%  numa-vmstat.node1.numa_hit
   2911028 ±  6%      -9.9%    2623089 ±  4%  numa-vmstat.node1.numa_local
      4400 ±  5%     +24.4%       5473 ±  2%  numa-vmstat.node2.nr_dirty
     52.00 ±  9%    +455.8%     289.00 ± 24%  numa-vmstat.node2.nr_writeback
      4533 ±  5%     +24.2%       5631        numa-vmstat.node2.nr_zone_write_pending
   3186079 ±  8%     -13.3%    2761823 ±  3%  numa-vmstat.node2.numa_hit
   3077478 ±  8%     -13.4%    2665765 ±  3%  numa-vmstat.node2.numa_local
     18225 ± 19%    +121.8%      40417 ± 47%  numa-vmstat.node3.nr_active_anon
    345.60 ±  3%     +43.9%     497.20 ± 33%  numa-vmstat.node3.nr_active_file
      4248 ±  2%     +29.4%       5497        numa-vmstat.node3.nr_dirty
     86095 ±  4%     +12.3%      96722 ±  2%  numa-vmstat.node3.nr_file_pages
    153.80 ± 19%     -65.1%      53.60 ± 56%  numa-vmstat.node3.nr_mlock
     11822 ± 14%     +72.4%      20378 ± 17%  numa-vmstat.node3.nr_shmem
     49.00 ±  4%    +462.0%     275.40 ± 19%  numa-vmstat.node3.nr_writeback
     18225 ± 19%    +121.8%      40416 ± 47%  numa-vmstat.node3.nr_zone_active_anon
    345.60 ±  3%     +43.9%     497.20 ± 33%  numa-vmstat.node3.nr_zone_active_file
      4373 ±  2%     +28.9%       5636        numa-vmstat.node3.nr_zone_write_pending
     85549           +11.8%      95665 ±  3%  proc-vmstat.nr_active_anon
      1840           +12.7%       2074 ±  3%  proc-vmstat.nr_active_file
     73018            +3.7%      75737        proc-vmstat.nr_anon_pages
    112.60           -26.5%      82.80 ±  8%  proc-vmstat.nr_anon_transparent_hugepages
  19992743            +3.5%   20687022        proc-vmstat.nr_dirtied
     17157           +29.0%      22139 ±  3%  proc-vmstat.nr_dirty
    320292            +1.5%     325170        proc-vmstat.nr_file_pages
     49434            -5.7%      46605 ±  2%  proc-vmstat.nr_inactive_file
     29057            +7.7%      31304        proc-vmstat.nr_kernel_stack
      8420            +9.0%       9174 ±  4%  proc-vmstat.nr_mapped
    435.40 ± 18%     -49.7%     219.00 ± 51%  proc-vmstat.nr_mlock
     17867           +41.5%      25273 ± 15%  proc-vmstat.nr_shmem
     57803            -4.2%      55357        proc-vmstat.nr_slab_reclaimable
    128.80 ±  2%    +713.8%       1048 ± 29%  proc-vmstat.nr_writeback
  19901345            +3.5%   20594405        proc-vmstat.nr_written
     85549           +11.8%      95665 ±  3%  proc-vmstat.nr_zone_active_anon
      1840           +12.7%       2074 ±  3%  proc-vmstat.nr_zone_active_file
     49434            -5.7%      46605 ±  2%  proc-vmstat.nr_zone_inactive_file
     17668           +28.9%      22766 ±  3%  proc-vmstat.nr_zone_write_pending
    107218 ±  5%     -61.7%      41098 ±  5%  proc-vmstat.numa_hint_faults
     73720 ±  6%     -62.3%      27790 ±  5%  proc-vmstat.numa_hint_faults_local
  17699040           -10.0%   15922834        proc-vmstat.numa_hit
  17605500           -10.1%   15829310        proc-vmstat.numa_local
    110883 ±  9%     -57.6%      46987 ± 25%  proc-vmstat.numa_pte_updates
     22749 ±  5%     +66.6%      37908 ±  9%  proc-vmstat.pgactivate
  17877147           -10.5%   16001378        proc-vmstat.pgalloc_normal
     18254            +7.4%      19613        proc-vmstat.pgdeactivate
   3368698 ±  2%     -79.3%     696904 ± 14%  proc-vmstat.pgfault
   5326179           -34.6%    3481040 ±  2%  proc-vmstat.pgfree
  79655896            +3.5%   82432256        proc-vmstat.pgpgout
     36480            +7.5%      39217        proc-vmstat.pgrotated
      2.41          +139.0%       5.77 ± 13%  perf-stat.i.MPKI
 4.305e+09           +74.5%  7.514e+09 ±  6%  perf-stat.i.branch-instructions
      0.25            +0.3        0.54 ± 13%  perf-stat.i.branch-miss-rate%
   9787519          +210.0%   30344928 ± 16%  perf-stat.i.branch-misses
     37.38            +8.4       45.74 ±  2%  perf-stat.i.cache-miss-rate%
  17212612 ±  3%    +417.5%   89073152 ± 16%  perf-stat.i.cache-misses
  45692866 ±  2%    +313.7%   1.89e+08 ± 16%  perf-stat.i.cache-references
     40158 ±  2%   +1027.9%     452960 ± 26%  perf-stat.i.context-switches
 7.522e+10           +80.4%  1.357e+11 ±  7%  perf-stat.i.cpu-cycles
      1173 ±  2%    +820.3%      10798 ± 17%  perf-stat.i.cpu-migrations
      4477 ±  2%     -60.3%       1779 ± 11%  perf-stat.i.cycles-between-cache-misses
      0.03 ± 15%      +0.1        0.10 ± 19%  perf-stat.i.dTLB-load-miss-rate%
   1306799 ± 13%    +616.5%    9363238 ± 21%  perf-stat.i.dTLB-load-misses
 5.163e+09           +79.2%  9.255e+09 ±  6%  perf-stat.i.dTLB-loads
      0.01 ± 21%      +0.0        0.03 ± 12%  perf-stat.i.dTLB-store-miss-rate%
     53041 ± 20%    +577.3%     359241 ± 26%  perf-stat.i.dTLB-store-misses
 4.194e+08          +186.5%  1.202e+09 ± 15%  perf-stat.i.dTLB-stores
   3000111          +135.1%    7054045 ± 13%  perf-stat.i.iTLB-load-misses
   4886564          +128.8%   11179945 ± 15%  perf-stat.i.iTLB-loads
 2.029e+10           +76.6%  3.584e+10 ±  6%  perf-stat.i.instructions
      6775           -18.8%       5503 ±  8%  perf-stat.i.instructions-per-iTLB-miss
      0.39           +80.4%       0.71 ±  7%  perf-stat.i.metric.GHz
      1.09 ±  5%     -72.5%       0.30 ± 27%  perf-stat.i.metric.K/sec
     51.80           +83.2%      94.91 ±  7%  perf-stat.i.metric.M/sec
      3762           +12.6%       4236 ±  2%  perf-stat.i.minor-faults
   5501237 ±  2%    +592.7%   38108380 ± 17%  perf-stat.i.node-load-misses
    341091 ±  4%    +495.0%    2029602 ± 16%  perf-stat.i.node-loads
     93.96            +1.1       95.03        perf-stat.i.node-store-miss-rate%
   1717467 ±  2%    +646.8%   12825609 ± 18%  perf-stat.i.node-store-misses
    108726 ±  6%    +465.3%     614610 ± 17%  perf-stat.i.node-stores
      3762           +12.6%       4236 ±  2%  perf-stat.i.page-faults
      2.25          +133.1%       5.25 ± 12%  perf-stat.overall.MPKI
      0.23            +0.2        0.40 ± 12%  perf-stat.overall.branch-miss-rate%
     37.66            +9.5       47.12 ±  2%  perf-stat.overall.cache-miss-rate%
      3.71            +2.1%       3.78        perf-stat.overall.cpi
      4372           -64.5%       1553 ± 12%  perf-stat.overall.cycles-between-cache-misses
      0.03 ± 13%      +0.1        0.10 ± 17%  perf-stat.overall.dTLB-load-miss-rate%
      0.01 ± 20%      +0.0        0.03 ± 12%  perf-stat.overall.dTLB-store-miss-rate%
      6765           -23.9%       5149 ±  9%  perf-stat.overall.instructions-per-iTLB-miss
      0.27            -2.0%       0.26        perf-stat.overall.ipc
     94.05            +1.4       95.42        perf-stat.overall.node-store-miss-rate%
   4.3e+09           +73.8%  7.472e+09 ±  6%  perf-stat.ps.branch-instructions
   9778000          +208.2%   30137670 ± 16%  perf-stat.ps.branch-misses
  17192809 ±  3%    +414.5%   88461433 ± 16%  perf-stat.ps.cache-misses
  45641335 ±  2%    +311.4%  1.878e+08 ± 16%  perf-stat.ps.cache-references
     40112 ±  2%   +1021.3%     449796 ± 26%  perf-stat.ps.context-switches
 7.513e+10           +79.6%  1.349e+11 ±  8%  perf-stat.ps.cpu-cycles
      1172 ±  2%    +815.3%      10728 ± 17%  perf-stat.ps.cpu-migrations
   1305261 ± 13%    +611.7%    9289474 ± 21%  perf-stat.ps.dTLB-load-misses
 5.157e+09           +78.5%  9.204e+09 ±  6%  perf-stat.ps.dTLB-loads
     52985 ± 20%    +573.6%     356909 ± 26%  perf-stat.ps.dTLB-store-misses
 4.189e+08          +184.9%  1.194e+09 ± 15%  perf-stat.ps.dTLB-stores
   2996689          +133.8%    7006295 ± 13%  perf-stat.ps.iTLB-load-misses
   4880923          +127.5%   11102675 ± 15%  perf-stat.ps.iTLB-loads
 2.027e+10           +75.8%  3.564e+10 ±  6%  perf-stat.ps.instructions
      3757           +12.0%       4207 ±  2%  perf-stat.ps.minor-faults
   5495021 ±  2%    +588.8%   37849270 ± 17%  perf-stat.ps.node-load-misses
    340723 ±  4%    +491.8%    2016412 ± 15%  perf-stat.ps.node-loads
   1715501 ±  2%    +642.3%   12734422 ± 18%  perf-stat.ps.node-store-misses
    108608 ±  6%    +462.0%     610345 ± 17%  perf-stat.ps.node-stores
      3757           +12.0%       4207 ±  2%  perf-stat.ps.page-faults
 1.778e+13 ±  2%     -68.4%  5.621e+12 ± 12%  perf-stat.total.instructions
     43558 ±  5%     -68.1%      13889 ± 15%  sched_debug.cfs_rq:/.exec_clock.avg
     59229 ±  6%     -73.7%      15563 ± 15%  sched_debug.cfs_rq:/.exec_clock.max
     39429 ±  6%     -67.3%      12882 ± 14%  sched_debug.cfs_rq:/.exec_clock.min
      2347 ±  4%     -83.7%     382.25 ± 31%  sched_debug.cfs_rq:/.exec_clock.stddev
      4.90 ±  5%    +137.6%      11.65 ± 26%  sched_debug.cfs_rq:/.load_avg.avg
    125.09 ±  8%    +175.0%     343.98 ± 16%  sched_debug.cfs_rq:/.load_avg.max
     17.20 ±  8%    +158.1%      44.40 ± 23%  sched_debug.cfs_rq:/.load_avg.stddev
   1249606 ±  6%     -37.2%     784849 ± 24%  sched_debug.cfs_rq:/.min_vruntime.avg
   1565669 ±  5%     -45.8%     849305 ± 24%  sched_debug.cfs_rq:/.min_vruntime.max
   1125571 ±  7%     -36.5%     715126 ± 24%  sched_debug.cfs_rq:/.min_vruntime.min
     56525 ±  3%     -59.3%      22991 ± 22%  sched_debug.cfs_rq:/.min_vruntime.stddev
      0.11 ± 17%     +47.4%       0.17 ±  9%  sched_debug.cfs_rq:/.nr_running.avg
      0.30 ±  6%     +19.8%       0.36 ±  2%  sched_debug.cfs_rq:/.nr_running.stddev
      0.81 ± 14%     -97.3%       0.02 ± 60%  sched_debug.cfs_rq:/.nr_spread_over.avg
      4.20 ± 13%     -73.8%       1.10 ± 50%  sched_debug.cfs_rq:/.nr_spread_over.max
      0.55 ±  9%     -72.9%       0.15 ± 52%  sched_debug.cfs_rq:/.nr_spread_over.stddev
    136.81 ± 10%    +118.4%     298.75 ± 10%  sched_debug.cfs_rq:/.runnable_avg.avg
      1188 ±  4%     +43.2%       1701 ± 24%  sched_debug.cfs_rq:/.runnable_avg.max
    195.87 ±  4%     +54.2%     301.98 ± 21%  sched_debug.cfs_rq:/.runnable_avg.stddev
    315750 ± 14%     -66.4%     106242 ± 31%  sched_debug.cfs_rq:/.spread0.max
   -124387           -77.6%     -27893        sched_debug.cfs_rq:/.spread0.min
     56528 ±  3%     -59.3%      22985 ± 22%  sched_debug.cfs_rq:/.spread0.stddev
    109.01 ±  9%     +85.1%     201.72 ±  3%  sched_debug.cfs_rq:/.util_avg.avg
    800.14 ±  3%     +30.8%       1046 ± 12%  sched_debug.cfs_rq:/.util_avg.max
    156.60 ±  4%     +18.9%     186.16 ± 14%  sched_debug.cfs_rq:/.util_avg.stddev
     17.76 ± 17%     +86.3%      33.08 ±  9%  sched_debug.cfs_rq:/.util_est_enqueued.avg
     68.19 ±  8%     +43.4%      97.81 ± 10%  sched_debug.cfs_rq:/.util_est_enqueued.stddev
    776647           -18.6%     632133 ± 10%  sched_debug.cpu.avg_idle.avg
   1085484 ±  4%     +38.9%    1508053 ± 27%  sched_debug.cpu.avg_idle.max
     40752 ± 16%     -58.2%      17048 ± 65%  sched_debug.cpu.avg_idle.min
    448303 ±  5%     -76.1%     107028 ± 11%  sched_debug.cpu.clock.avg
    448318 ±  5%     -76.1%     107047 ± 11%  sched_debug.cpu.clock.max
    448288 ±  5%     -76.1%     107009 ± 11%  sched_debug.cpu.clock.min
      8.98 ±  4%     +23.5%      11.10 ±  4%  sched_debug.cpu.clock.stddev
    443708 ±  5%     -76.1%     106213 ± 11%  sched_debug.cpu.clock_task.avg
    444016 ±  5%     -76.0%     106373 ± 11%  sched_debug.cpu.clock_task.max
    435173 ±  5%     -77.4%      98297 ± 12%  sched_debug.cpu.clock_task.min
     16088 ±  4%     -65.5%       5546 ±  6%  sched_debug.cpu.curr->pid.max
      1562 ±  5%     -25.0%       1171 ±  3%  sched_debug.cpu.curr->pid.stddev
    574107 ±  5%     +67.9%     963985 ± 36%  sched_debug.cpu.max_idle_balance_cost.max
      8428 ± 49%    +472.2%      48227 ± 79%  sched_debug.cpu.max_idle_balance_cost.stddev
      0.11 ± 17%     +39.4%       0.15 ± 11%  sched_debug.cpu.nr_running.avg
      0.29 ±  7%     +14.0%       0.33 ±  3%  sched_debug.cpu.nr_running.stddev
     84963 ±  4%     +71.1%     145410 ± 14%  sched_debug.cpu.nr_switches.avg
    118995 ±  7%     +32.8%     158052 ± 14%  sched_debug.cpu.nr_switches.max
     78727 ±  4%     +77.2%     139470 ± 15%  sched_debug.cpu.nr_switches.min
      5200 ±  5%     -52.4%       2476 ± 11%  sched_debug.cpu.nr_switches.stddev
      0.81 ±  2%     -55.3%       0.36 ± 12%  sched_debug.cpu.nr_uninterruptible.avg
      1356 ±  7%     -64.1%     486.83 ± 12%  sched_debug.cpu.nr_uninterruptible.max
    -79.49           -46.4%     -42.58        sched_debug.cpu.nr_uninterruptible.min
    174.73 ±  4%     -68.5%      54.99 ± 15%  sched_debug.cpu.nr_uninterruptible.stddev
     84042 ±  4%     +73.5%     145814 ± 14%  sched_debug.cpu.sched_count.avg
     78099 ±  4%     +78.2%     139170 ± 15%  sched_debug.cpu.sched_count.min
      4846 ±  4%     -56.0%       2134 ± 11%  sched_debug.cpu.sched_count.stddev
     41262 ±  4%     +73.9%      71768 ± 14%  sched_debug.cpu.sched_goidle.avg
     38325 ±  4%     +78.7%      68469 ± 15%  sched_debug.cpu.sched_goidle.min
      2414 ±  4%     -56.6%       1048 ± 11%  sched_debug.cpu.sched_goidle.stddev
     43323 ±  4%     +72.1%      74551 ± 14%  sched_debug.cpu.ttwu_count.avg
     68008 ±  8%     +43.1%      97317 ± 13%  sched_debug.cpu.ttwu_count.max
     32779 ±  6%     +86.4%      61098 ± 14%  sched_debug.cpu.ttwu_count.min
      1525 ±  6%     -84.2%     241.21 ± 19%  sched_debug.cpu.ttwu_local.avg
      3446 ±  6%     -83.6%     565.65 ± 18%  sched_debug.cpu.ttwu_local.max
      1130 ±  8%     -84.1%     179.32 ± 16%  sched_debug.cpu.ttwu_local.min
    243.70 ±  6%     -81.8%      44.32 ± 28%  sched_debug.cpu.ttwu_local.stddev
    448287 ±  5%     -76.1%     107010 ± 11%  sched_debug.cpu_clk
    447410 ±  5%     -76.3%     106136 ± 12%  sched_debug.ktime
    448642 ±  5%     -76.1%     107367 ± 11%  sched_debug.sched_clk
     42.99 ±  5%     -43.0        0.00        perf-profile.calltrace.cycles-pp.rwsem_down_read_slowpath.__write_node_page.f2fs_fsync_node_pages.f2fs_do_sync_file.f2fs_file_write_iter
     42.66 ±  5%     -42.7        0.00        perf-profile.calltrace.cycles-pp.rwsem_optimistic_spin.rwsem_down_read_slowpath.__write_node_page.f2fs_fsync_node_pages.f2fs_do_sync_file
     40.14 ±  5%     -40.1        0.00        perf-profile.calltrace.cycles-pp.osq_lock.rwsem_optimistic_spin.rwsem_down_read_slowpath.__write_node_page.f2fs_fsync_node_pages
     47.64 ±  5%     -24.3       23.30 ± 20%  perf-profile.calltrace.cycles-pp.__write_node_page.f2fs_fsync_node_pages.f2fs_do_sync_file.f2fs_file_write_iter.new_sync_write
     12.39 ± 12%     -12.4        0.00        perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.f2fs_allocate_data_block.do_write_page.f2fs_outplace_write_data.f2fs_do_write_data_page
     12.32 ± 12%     -12.3        0.00        perf-profile.calltrace.cycles-pp.rwsem_optimistic_spin.rwsem_down_write_slowpath.f2fs_allocate_data_block.do_write_page.f2fs_outplace_write_data
     12.18 ± 12%     -12.2        0.00        perf-profile.calltrace.cycles-pp.osq_lock.rwsem_optimistic_spin.rwsem_down_write_slowpath.f2fs_allocate_data_block.do_write_page
     12.53 ± 12%     -10.0        2.53 ± 21%  perf-profile.calltrace.cycles-pp.f2fs_allocate_data_block.do_write_page.f2fs_outplace_write_data.f2fs_do_write_data_page.f2fs_write_single_data_page
     13.66 ± 12%      -7.4        6.28 ± 36%  perf-profile.calltrace.cycles-pp.do_write_page.f2fs_outplace_write_data.f2fs_do_write_data_page.f2fs_write_single_data_page.f2fs_write_cache_pages
     13.71 ± 12%      -7.2        6.47 ± 35%  perf-profile.calltrace.cycles-pp.f2fs_outplace_write_data.f2fs_do_write_data_page.f2fs_write_single_data_page.f2fs_write_cache_pages.f2fs_write_data_pages
     13.87 ± 12%      -4.5        9.38 ± 13%  perf-profile.calltrace.cycles-pp.f2fs_do_write_data_page.f2fs_write_single_data_page.f2fs_write_cache_pages.f2fs_write_data_pages.do_writepages
     13.90 ± 12%      -4.4        9.53 ± 13%  perf-profile.calltrace.cycles-pp.f2fs_write_single_data_page.f2fs_write_cache_pages.f2fs_write_data_pages.do_writepages.__filemap_fdatawrite_range
      3.95 ± 32%      -3.6        0.37 ± 82%  perf-profile.calltrace.cycles-pp.menu_select.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64
      4.43 ± 20%      -3.3        1.14 ± 22%  perf-profile.calltrace.cycles-pp.__irqentry_text_start.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry
      3.26 ± 25%      -2.2        1.06 ± 21%  perf-profile.calltrace.cycles-pp.smp_apic_timer_interrupt.__irqentry_text_start.cpuidle_enter_state.cpuidle_enter.do_idle
      1.56 ± 10%      -1.0        0.51 ± 51%  perf-profile.calltrace.cycles-pp.hrtimer_interrupt.smp_apic_timer_interrupt.__irqentry_text_start.cpuidle_enter_state.cpuidle_enter
      0.93 ±  3%      +0.6        1.58 ± 28%  perf-profile.calltrace.cycles-pp.osq_lock.__mutex_lock.f2fs_allocate_data_block.do_write_page.f2fs_do_write_node_page
      0.98 ±  3%      +0.8        1.80 ± 24%  perf-profile.calltrace.cycles-pp.__mutex_lock.f2fs_allocate_data_block.do_write_page.f2fs_do_write_node_page.__write_node_page
      0.00            +0.9        0.94 ± 30%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irq.rwsem_down_read_slowpath.f2fs_need_inode_block_update.f2fs_do_sync_file
      0.00            +1.0        0.96 ± 30%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irq.rwsem_down_read_slowpath.f2fs_need_inode_block_update.f2fs_do_sync_file.f2fs_file_write_iter
      1.06 ±  4%      +1.1        2.16 ± 19%  perf-profile.calltrace.cycles-pp.f2fs_allocate_data_block.do_write_page.f2fs_do_write_node_page.__write_node_page.f2fs_fsync_node_pages
      0.34 ± 82%      +1.4        1.73 ± 36%  perf-profile.calltrace.cycles-pp.osq_lock.rwsem_optimistic_spin.rwsem_down_read_slowpath.__submit_merged_write_cond.f2fs_write_cache_pages
      0.36 ± 82%      +1.5        1.86 ± 33%  perf-profile.calltrace.cycles-pp.rwsem_optimistic_spin.rwsem_down_read_slowpath.__submit_merged_write_cond.f2fs_write_cache_pages.f2fs_write_data_pages
      0.00            +1.5        1.51 ± 25%  perf-profile.calltrace.cycles-pp.find_get_pages_range_tag.pagevec_lookup_range_tag.f2fs_fsync_node_pages.f2fs_do_sync_file.f2fs_file_write_iter
      0.36 ± 82%      +1.5        1.87 ± 33%  perf-profile.calltrace.cycles-pp.rwsem_down_read_slowpath.__submit_merged_write_cond.f2fs_write_cache_pages.f2fs_write_data_pages.do_writepages
      0.00            +1.5        1.51 ± 25%  perf-profile.calltrace.cycles-pp.pagevec_lookup_range_tag.f2fs_fsync_node_pages.f2fs_do_sync_file.f2fs_file_write_iter.new_sync_write
      0.00            +1.5        1.55 ± 49%  perf-profile.calltrace.cycles-pp.f2fs_get_node_info.__write_node_page.f2fs_fsync_node_pages.f2fs_do_sync_file.f2fs_file_write_iter
      0.00            +1.7        1.68 ± 60%  perf-profile.calltrace.cycles-pp.osq_lock.rwsem_optimistic_spin.rwsem_down_read_slowpath.f2fs_need_dentry_mark.f2fs_fsync_node_pages
      0.00            +1.7        1.73 ± 59%  perf-profile.calltrace.cycles-pp.rwsem_optimistic_spin.rwsem_down_read_slowpath.f2fs_need_dentry_mark.f2fs_fsync_node_pages.f2fs_do_sync_file
      0.00            +1.9        1.85 ± 31%  perf-profile.calltrace.cycles-pp.osq_lock.__mutex_lock.f2fs_allocate_data_block.do_write_page.f2fs_outplace_write_data
      0.74 ± 15%      +1.9        2.62 ± 27%  perf-profile.calltrace.cycles-pp.__submit_merged_write_cond.f2fs_write_cache_pages.f2fs_write_data_pages.do_writepages.__filemap_fdatawrite_range
      0.00            +2.1        2.07 ± 51%  perf-profile.calltrace.cycles-pp.rwsem_down_read_slowpath.f2fs_need_dentry_mark.f2fs_fsync_node_pages.f2fs_do_sync_file.f2fs_file_write_iter
      0.60 ± 10%      +2.1        2.70 ± 40%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.__percpu_counter_sum.f2fs_space_for_roll_forward.f2fs_do_sync_file
      0.00            +2.1        2.11 ± 27%  perf-profile.calltrace.cycles-pp.__mutex_lock.f2fs_allocate_data_block.do_write_page.f2fs_outplace_write_data.f2fs_do_write_data_page
      0.61 ± 10%      +2.1        2.73 ± 39%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.__percpu_counter_sum.f2fs_space_for_roll_forward.f2fs_do_sync_file.f2fs_file_write_iter
      0.00            +2.2        2.16 ± 58%  perf-profile.calltrace.cycles-pp.osq_lock.rwsem_optimistic_spin.rwsem_down_read_slowpath.f2fs_get_node_info.f2fs_do_write_data_page
      0.00            +2.2        2.18 ± 49%  perf-profile.calltrace.cycles-pp.f2fs_need_dentry_mark.f2fs_fsync_node_pages.f2fs_do_sync_file.f2fs_file_write_iter.new_sync_write
      0.00            +2.2        2.23 ± 57%  perf-profile.calltrace.cycles-pp.rwsem_optimistic_spin.rwsem_down_read_slowpath.f2fs_get_node_info.f2fs_do_write_data_page.f2fs_write_single_data_page
      0.71 ±  9%      +2.4        3.10 ± 34%  perf-profile.calltrace.cycles-pp.__percpu_counter_sum.f2fs_space_for_roll_forward.f2fs_do_sync_file.f2fs_file_write_iter.new_sync_write
      0.72 ± 10%      +2.4        3.11 ± 34%  perf-profile.calltrace.cycles-pp.f2fs_space_for_roll_forward.f2fs_do_sync_file.f2fs_file_write_iter.new_sync_write.vfs_write
      1.06 ± 17%      +2.5        3.57 ± 51%  perf-profile.calltrace.cycles-pp.rwsem_optimistic_spin.rwsem_down_write_slowpath.f2fs_submit_page_write.do_write_page.f2fs_outplace_write_data
      1.07 ± 17%      +2.5        3.58 ± 51%  perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.f2fs_submit_page_write.do_write_page.f2fs_outplace_write_data.f2fs_do_write_data_page
      0.00            +2.5        2.52 ± 52%  perf-profile.calltrace.cycles-pp.rwsem_down_read_slowpath.f2fs_get_node_info.f2fs_do_write_data_page.f2fs_write_single_data_page.f2fs_write_cache_pages
      1.11 ± 16%      +2.6        3.72 ± 48%  perf-profile.calltrace.cycles-pp.f2fs_submit_page_write.do_write_page.f2fs_outplace_write_data.f2fs_do_write_data_page.f2fs_write_single_data_page
      0.00            +2.6        2.63 ± 50%  perf-profile.calltrace.cycles-pp.f2fs_get_node_info.f2fs_do_write_data_page.f2fs_write_single_data_page.f2fs_write_cache_pages.f2fs_write_data_pages
      0.00            +3.0        3.02 ± 62%  perf-profile.calltrace.cycles-pp.osq_lock.rwsem_optimistic_spin.rwsem_down_read_slowpath.f2fs_is_checkpointed_node.f2fs_do_sync_file
      0.00            +3.1        3.12 ± 63%  perf-profile.calltrace.cycles-pp.rwsem_optimistic_spin.rwsem_down_read_slowpath.f2fs_is_checkpointed_node.f2fs_do_sync_file.f2fs_file_write_iter
      0.00            +3.5        3.53 ± 55%  perf-profile.calltrace.cycles-pp.osq_lock.rwsem_optimistic_spin.rwsem_down_read_slowpath.f2fs_need_inode_block_update.f2fs_do_sync_file
      0.00            +3.6        3.65 ± 55%  perf-profile.calltrace.cycles-pp.rwsem_optimistic_spin.rwsem_down_read_slowpath.f2fs_need_inode_block_update.f2fs_do_sync_file.f2fs_file_write_iter
      0.00            +3.7        3.75 ± 53%  perf-profile.calltrace.cycles-pp.rwsem_down_read_slowpath.f2fs_is_checkpointed_node.f2fs_do_sync_file.f2fs_file_write_iter.new_sync_write
      0.00            +3.9        3.93 ± 51%  perf-profile.calltrace.cycles-pp.f2fs_is_checkpointed_node.f2fs_do_sync_file.f2fs_file_write_iter.new_sync_write.vfs_write
      0.00            +4.7        4.73 ± 43%  perf-profile.calltrace.cycles-pp.rwsem_down_read_slowpath.f2fs_need_inode_block_update.f2fs_do_sync_file.f2fs_file_write_iter.new_sync_write
      0.00            +4.9        4.87 ± 43%  perf-profile.calltrace.cycles-pp.f2fs_need_inode_block_update.f2fs_do_sync_file.f2fs_file_write_iter.new_sync_write.vfs_write
      0.00            +7.2        7.17 ± 29%  perf-profile.calltrace.cycles-pp.osq_lock.rwsem_optimistic_spin.rwsem_down_write_slowpath.set_node_addr.__write_node_page
      0.00            +7.6        7.58 ± 29%  perf-profile.calltrace.cycles-pp.rwsem_optimistic_spin.rwsem_down_write_slowpath.set_node_addr.__write_node_page.f2fs_fsync_node_pages
      0.00            +7.8        7.84 ± 29%  perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.set_node_addr.__write_node_page.f2fs_fsync_node_pages.f2fs_do_sync_file
      0.00            +7.9        7.92 ± 29%  perf-profile.calltrace.cycles-pp.set_node_addr.__write_node_page.f2fs_fsync_node_pages.f2fs_do_sync_file.f2fs_file_write_iter
      1.16 ±  5%      +9.9       11.04 ± 35%  perf-profile.calltrace.cycles-pp.osq_lock.rwsem_optimistic_spin.rwsem_down_read_slowpath.__submit_merged_write_cond.f2fs_fsync_node_pages
      1.20 ±  5%     +10.1       11.33 ± 35%  perf-profile.calltrace.cycles-pp.rwsem_optimistic_spin.rwsem_down_read_slowpath.__submit_merged_write_cond.f2fs_fsync_node_pages.f2fs_do_sync_file
      1.20 ±  5%     +10.2       11.37 ± 35%  perf-profile.calltrace.cycles-pp.rwsem_down_read_slowpath.__submit_merged_write_cond.f2fs_fsync_node_pages.f2fs_do_sync_file.f2fs_file_write_iter
      1.46 ±  5%     +11.1       12.53 ± 36%  perf-profile.calltrace.cycles-pp.__submit_merged_write_cond.f2fs_fsync_node_pages.f2fs_do_sync_file.f2fs_file_write_iter.new_sync_write
     47.64 ±  5%     -24.3       23.30 ± 20%  perf-profile.children.cycles-pp.__write_node_page
     45.03 ±  5%     -17.2       27.84 ± 12%  perf-profile.children.cycles-pp.rwsem_down_read_slowpath
     62.32 ±  6%     -14.0       48.35 ± 15%  perf-profile.children.cycles-pp.rwsem_optimistic_spin
     13.95 ± 11%      -9.3        4.69 ± 20%  perf-profile.children.cycles-pp.f2fs_allocate_data_block
     14.06 ± 12%      -7.6        6.47 ± 35%  perf-profile.children.cycles-pp.f2fs_outplace_write_data
     13.87 ± 12%      -4.5        9.38 ± 13%  perf-profile.children.cycles-pp.f2fs_do_write_data_page
     13.90 ± 12%      -4.4        9.53 ± 13%  perf-profile.children.cycles-pp.f2fs_write_single_data_page
      3.98 ± 32%      -3.4        0.53 ± 25%  perf-profile.children.cycles-pp.menu_select
      4.42 ± 19%      -2.8        1.67 ± 11%  perf-profile.children.cycles-pp.__irqentry_text_start
      3.81 ± 21%      -2.3        1.55 ± 10%  perf-profile.children.cycles-pp.smp_apic_timer_interrupt
      2.02 ±  7%      -1.0        1.01 ±  7%  perf-profile.children.cycles-pp.hrtimer_interrupt
      1.28 ± 54%      -0.9        0.36 ± 19%  perf-profile.children.cycles-pp.irq_exit
      1.37 ± 11%      -0.8        0.59 ± 18%  perf-profile.children.cycles-pp.ktime_get
      0.82 ± 68%      -0.6        0.22 ± 19%  perf-profile.children.cycles-pp.__softirqentry_text_start
      1.05 ±  5%      -0.5        0.56 ±  6%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      0.67 ± 32%      -0.4        0.26 ± 23%  perf-profile.children.cycles-pp.tick_nohz_get_sleep_length
      0.61 ± 32%      -0.4        0.22 ± 23%  perf-profile.children.cycles-pp.tick_nohz_next_event
      0.46 ± 79%      -0.4        0.10 ± 18%  perf-profile.children.cycles-pp.rebalance_domains
      0.82 ±  4%      -0.3        0.47 ±  9%  perf-profile.children.cycles-pp.tick_sched_timer
      0.64 ± 10%      -0.3        0.30 ± 17%  perf-profile.children.cycles-pp.clockevents_program_event
      0.47 ±  8%      -0.3        0.18 ± 18%  perf-profile.children.cycles-pp.irq_enter
      0.32 ± 82%      -0.3        0.06 ± 21%  perf-profile.children.cycles-pp._raw_spin_trylock
      0.61 ±  4%      -0.2        0.36 ± 13%  perf-profile.children.cycles-pp.tick_sched_handle
      0.30 ± 64%      -0.2        0.05 ± 50%  perf-profile.children.cycles-pp.native_irq_return_iret
      0.61 ±  3%      -0.2        0.36 ± 14%  perf-profile.children.cycles-pp.update_process_times
      0.39 ±  9%      -0.2        0.15 ± 21%  perf-profile.children.cycles-pp.tick_irq_enter
      0.32 ± 40%      -0.2        0.08 ± 51%  perf-profile.children.cycles-pp.timekeeping_max_deferment
      0.31 ± 25%      -0.2        0.09 ± 23%  perf-profile.children.cycles-pp.tick_nohz_irq_exit
      0.25 ± 40%      -0.2        0.03 ± 82%  perf-profile.children.cycles-pp.irqtime_account_irq
      0.41 ±  2%      -0.1        0.26 ± 20%  perf-profile.children.cycles-pp.scheduler_tick
      0.26 ± 10%      -0.1        0.11 ± 15%  perf-profile.children.cycles-pp.ktime_get_update_offsets_now
      0.15 ±  6%      -0.1        0.04 ± 50%  perf-profile.children.cycles-pp.perf_mux_hrtimer_handler
      0.19 ± 30%      -0.1        0.10 ± 21%  perf-profile.children.cycles-pp.get_next_timer_interrupt
      0.14 ± 26%      -0.1        0.06 ± 51%  perf-profile.children.cycles-pp.__next_timer_interrupt
      0.18 ± 41%      -0.1        0.11 ±  6%  perf-profile.children.cycles-pp.load_balance
      0.15 ± 36%      -0.1        0.09 ±  4%  perf-profile.children.cycles-pp.find_busiest_group
      0.15 ± 39%      -0.1        0.09 ±  8%  perf-profile.children.cycles-pp.update_sd_lb_stats
      0.08 ± 12%      -0.1        0.03 ± 81%  perf-profile.children.cycles-pp.read_tsc
      0.06 ± 12%      +0.0        0.10 ± 10%  perf-profile.children.cycles-pp.schedule_timeout
      0.06 ± 14%      +0.0        0.11 ± 10%  perf-profile.children.cycles-pp.wait_for_completion
      0.12 ±  6%      +0.1        0.18 ± 10%  perf-profile.children.cycles-pp.update_load_avg
      0.00            +0.1        0.06 ± 14%  perf-profile.children.cycles-pp.f2fs_inplace_write_data
      0.00            +0.1        0.06 ± 18%  perf-profile.children.cycles-pp.f2fs_update_inode
      0.08 ± 14%      +0.1        0.14 ± 10%  perf-profile.children.cycles-pp.pick_next_task_fair
      0.00            +0.1        0.07 ± 23%  perf-profile.children.cycles-pp.llist_add_batch
      0.00            +0.1        0.07 ± 23%  perf-profile.children.cycles-pp.read_node_page
      0.00            +0.1        0.07 ± 18%  perf-profile.children.cycles-pp.up_write
      0.00            +0.1        0.07 ± 15%  perf-profile.children.cycles-pp.__has_merged_page
      0.00            +0.1        0.07 ± 15%  perf-profile.children.cycles-pp.get_page_from_freelist
      0.00            +0.1        0.07 ± 20%  perf-profile.children.cycles-pp.__alloc_pages_nodemask
      0.00            +0.1        0.07 ± 27%  perf-profile.children.cycles-pp.__orc_find
      0.00            +0.1        0.07 ± 18%  perf-profile.children.cycles-pp.mutex_lock
      0.07 ±  7%      +0.1        0.15 ± 17%  perf-profile.children.cycles-pp.kthread
      0.07 ±  7%      +0.1        0.15 ± 19%  perf-profile.children.cycles-pp.ret_from_fork
      0.00            +0.1        0.08 ± 20%  perf-profile.children.cycles-pp.locate_dirty_segment
      0.00            +0.1        0.08 ± 31%  perf-profile.children.cycles-pp.update_cfs_rq_h_load
      0.00            +0.1        0.08 ± 22%  perf-profile.children.cycles-pp.update_curr
      0.00            +0.1        0.08 ± 22%  perf-profile.children.cycles-pp.__list_del_entry_valid
      0.00            +0.1        0.08 ± 12%  perf-profile.children.cycles-pp.f2fs_invalidate_blocks
      0.00            +0.1        0.09 ±  9%  perf-profile.children.cycles-pp.f2fs_do_truncate_blocks
      0.00            +0.1        0.09 ±  9%  perf-profile.children.cycles-pp.f2fs_truncate_data_blocks_range
      0.00            +0.1        0.09 ± 22%  perf-profile.children.cycles-pp.pagecache_get_page
      0.00            +0.1        0.09 ± 28%  perf-profile.children.cycles-pp.orc_find
      0.00            +0.1        0.09 ±  8%  perf-profile.children.cycles-pp.f2fs_truncate
      0.00            +0.1        0.09 ± 28%  perf-profile.children.cycles-pp.__radix_tree_lookup
      0.05 ±  9%      +0.1        0.15 ± 22%  perf-profile.children.cycles-pp.__test_set_page_writeback
      0.00            +0.1        0.10 ± 20%  perf-profile.children.cycles-pp.swake_up_locked
      0.00            +0.1        0.10 ± 19%  perf-profile.children.cycles-pp.complete
      0.09 ±  8%      +0.1        0.19 ± 12%  perf-profile.children.cycles-pp.f2fs_issue_flush
      0.00            +0.1        0.11 ± 21%  perf-profile.children.cycles-pp.f2fs_set_data_page_dirty
      0.00            +0.1        0.11 ± 26%  perf-profile.children.cycles-pp.ttwu_queue_wakelist
      0.00            +0.1        0.11 ± 18%  perf-profile.children.cycles-pp.down_write
      0.00            +0.1        0.12 ± 18%  perf-profile.children.cycles-pp.f2fs_submit_merged_ipu_write
      0.00            +0.1        0.12 ± 22%  perf-profile.children.cycles-pp.f2fs_update_inode_page
      0.00            +0.1        0.12 ± 22%  perf-profile.children.cycles-pp.end_page_writeback
      0.00            +0.1        0.12 ± 22%  perf-profile.children.cycles-pp.test_clear_page_writeback
      0.00            +0.1        0.12 ± 22%  perf-profile.children.cycles-pp.dequeue_entity
      0.05            +0.1        0.17 ± 22%  perf-profile.children.cycles-pp.brd_insert_page
      0.02 ±122%      +0.1        0.14 ± 20%  perf-profile.children.cycles-pp.f2fs_write_end
      0.00            +0.1        0.13 ± 28%  perf-profile.children.cycles-pp.__lookup_nat_cache
      0.00            +0.1        0.13 ± 24%  perf-profile.children.cycles-pp.dequeue_task_fair
      0.03 ± 81%      +0.1        0.16 ± 23%  perf-profile.children.cycles-pp.f2fs_is_valid_blkaddr
      0.00            +0.1        0.13 ± 19%  perf-profile.children.cycles-pp.f2fs_write_inode
      0.00            +0.1        0.13 ± 19%  perf-profile.children.cycles-pp.issue_flush_thread
      0.00            +0.1        0.14 ± 21%  perf-profile.children.cycles-pp.f2fs_balance_fs
      0.03 ± 82%      +0.1        0.18 ± 18%  perf-profile.children.cycles-pp.f2fs_set_data_blkaddr
      0.03 ± 82%      +0.1        0.18 ± 18%  perf-profile.children.cycles-pp.f2fs_update_data_blkaddr
      0.00            +0.1        0.14 ± 23%  perf-profile.children.cycles-pp.rwsem_mark_wake
      0.00            +0.1        0.15 ± 27%  perf-profile.children.cycles-pp.select_task_rq_fair
      0.00            +0.1        0.15 ± 26%  perf-profile.children.cycles-pp.osq_unlock
      0.00            +0.1        0.15 ± 25%  perf-profile.children.cycles-pp.schedule_idle
      0.02 ±122%      +0.1        0.17 ± 28%  perf-profile.children.cycles-pp.xas_find_marked
      0.06 ± 14%      +0.2        0.21 ± 19%  perf-profile.children.cycles-pp.f2fs_set_node_page_dirty
      0.00            +0.2        0.16 ± 28%  perf-profile.children.cycles-pp.__close
      0.00            +0.2        0.16 ± 28%  perf-profile.children.cycles-pp.__fput
      0.00            +0.2        0.16 ± 28%  perf-profile.children.cycles-pp.dput
      0.00            +0.2        0.16 ± 28%  perf-profile.children.cycles-pp.__dentry_kill
      0.00            +0.2        0.16 ± 28%  perf-profile.children.cycles-pp.evict
      0.00            +0.2        0.16 ± 28%  perf-profile.children.cycles-pp.f2fs_evict_inode
      0.06 ± 14%      +0.2        0.21 ± 20%  perf-profile.children.cycles-pp.__set_page_dirty_nobuffers
      0.00            +0.2        0.16 ± 23%  perf-profile.children.cycles-pp.update_sit_entry
      0.00            +0.2        0.16 ± 26%  perf-profile.children.cycles-pp.task_work_run
      0.00            +0.2        0.16 ± 26%  perf-profile.children.cycles-pp.exit_to_usermode_loop
      0.00            +0.2        0.16 ± 23%  perf-profile.children.cycles-pp.up_read
      0.05 ±  9%      +0.2        0.22 ± 21%  perf-profile.children.cycles-pp.__get_node_page
      0.08 ±  5%      +0.2        0.26 ± 22%  perf-profile.children.cycles-pp.f2fs_write_begin
      0.07 ± 12%      +0.2        0.27 ± 20%  perf-profile.children.cycles-pp.f2fs_write_end_io
      0.07 ± 11%      +0.2        0.29 ± 23%  perf-profile.children.cycles-pp.down_read
      0.14 ± 11%      +0.2        0.36 ± 18%  perf-profile.children.cycles-pp.schedule
      0.14 ±  8%      +0.2        0.37 ± 19%  perf-profile.children.cycles-pp._raw_spin_lock
      0.02 ±122%      +0.2        0.25 ± 25%  perf-profile.children.cycles-pp.unwind_next_frame
      0.10 ±  9%      +0.3        0.36 ± 20%  perf-profile.children.cycles-pp.brd_do_bvec
      0.06 ± 12%      +0.3        0.37 ± 24%  perf-profile.children.cycles-pp.arch_stack_walk
      0.13 ±  5%      +0.3        0.45 ± 20%  perf-profile.children.cycles-pp.generic_perform_write
      0.07 ± 12%      +0.3        0.40 ± 24%  perf-profile.children.cycles-pp.stack_trace_save_tsk
      0.16 ±  8%      +0.3        0.50 ± 19%  perf-profile.children.cycles-pp.__sched_text_start
      0.14 ±  5%      +0.3        0.48 ± 20%  perf-profile.children.cycles-pp.__generic_file_write_iter
      0.71 ±  6%      +0.4        1.11 ± 19%  perf-profile.children.cycles-pp.rwsem_spin_on_owner
      0.00            +0.4        0.42 ± 22%  perf-profile.children.cycles-pp.mutex_spin_on_owner
      0.16 ± 13%      +0.4        0.58 ± 20%  perf-profile.children.cycles-pp.__submit_merged_bio
      0.18 ± 10%      +0.5        0.64 ± 20%  perf-profile.children.cycles-pp.brd_make_request
      0.18 ±  8%      +0.5        0.66 ± 20%  perf-profile.children.cycles-pp.submit_bio
      0.18 ±  8%      +0.5        0.66 ± 20%  perf-profile.children.cycles-pp.generic_make_request
      0.09 ± 13%      +0.5        0.58 ± 26%  perf-profile.children.cycles-pp.__account_scheduler_latency
      0.10 ±  7%      +0.6        0.68 ± 25%  perf-profile.children.cycles-pp.sched_ttwu_pending
      0.10 ±  8%      +0.6        0.68 ± 26%  perf-profile.children.cycles-pp.release_pages
      0.10 ±  8%      +0.6        0.68 ± 26%  perf-profile.children.cycles-pp.__pagevec_release
      0.10 ±  3%      +0.6        0.72 ± 25%  perf-profile.children.cycles-pp.flush_smp_call_function_from_idle
      0.12 ± 10%      +0.7        0.77 ± 25%  perf-profile.children.cycles-pp.enqueue_entity
      0.08 ± 14%      +0.7        0.75 ± 26%  perf-profile.children.cycles-pp.wake_up_q
      0.11 ± 11%      +0.7        0.80 ± 25%  perf-profile.children.cycles-pp.try_to_wake_up
      0.13 ±  9%      +0.7        0.82 ± 25%  perf-profile.children.cycles-pp.enqueue_task_fair
      0.13 ±  9%      +0.7        0.83 ± 25%  perf-profile.children.cycles-pp.ttwu_do_activate
      0.13 ±  9%      +0.7        0.83 ± 25%  perf-profile.children.cycles-pp.activate_task
      0.10 ± 11%      +0.8        0.86 ± 26%  perf-profile.children.cycles-pp.rwsem_wake
      0.30 ±  7%      +1.2        1.52 ± 25%  perf-profile.children.cycles-pp.pagevec_lookup_range_tag
      0.30 ±  7%      +1.2        1.52 ± 25%  perf-profile.children.cycles-pp.find_get_pages_range_tag
      0.08 ± 23%      +2.1        2.20 ± 28%  perf-profile.children.cycles-pp._raw_spin_lock_irq
      0.00            +2.2        2.18 ± 49%  perf-profile.children.cycles-pp.f2fs_need_dentry_mark
      0.71 ±  9%      +2.4        3.10 ± 34%  perf-profile.children.cycles-pp.__percpu_counter_sum
      0.72 ± 10%      +2.4        3.11 ± 34%  perf-profile.children.cycles-pp.f2fs_space_for_roll_forward
      0.79 ±  7%      +2.5        3.32 ± 31%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      0.98 ±  3%      +2.9        3.90 ± 25%  perf-profile.children.cycles-pp.__mutex_lock
      0.00            +3.9        3.93 ± 51%  perf-profile.children.cycles-pp.f2fs_is_checkpointed_node
      0.10 ± 16%      +4.1        4.22 ± 50%  perf-profile.children.cycles-pp.f2fs_get_node_info
      0.72 ±  9%      +4.4        5.10 ± 21%  perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
      0.14 ± 12%      +4.7        4.87 ± 43%  perf-profile.children.cycles-pp.f2fs_need_inode_block_update
      0.17 ± 18%      +7.8        7.94 ± 29%  perf-profile.children.cycles-pp.set_node_addr
      2.28 ±  8%     +12.9       15.21 ± 34%  perf-profile.children.cycles-pp.__submit_merged_write_cond
      3.28 ± 32%      -3.0        0.26 ± 36%  perf-profile.self.cycles-pp.menu_select
      2.62 ±  4%      -2.0        0.63 ± 19%  perf-profile.self.cycles-pp.rwsem_optimistic_spin
      1.73 ± 24%      -1.6        0.16 ± 38%  perf-profile.self.cycles-pp.cpuidle_enter_state
      1.30 ± 11%      -0.8        0.55 ± 19%  perf-profile.self.cycles-pp.ktime_get
      0.32 ± 82%      -0.3        0.06 ± 21%  perf-profile.self.cycles-pp._raw_spin_trylock
      0.30 ± 64%      -0.2        0.05 ± 50%  perf-profile.self.cycles-pp.native_irq_return_iret
      0.32 ± 40%      -0.2        0.08 ± 51%  perf-profile.self.cycles-pp.timekeeping_max_deferment
      0.24 ± 11%      -0.1        0.10 ± 13%  perf-profile.self.cycles-pp.ktime_get_update_offsets_now
      0.00            +0.1        0.06 ± 12%  perf-profile.self.cycles-pp.f2fs_submit_page_write
      0.00            +0.1        0.06 ± 15%  perf-profile.self.cycles-pp.f2fs_write_data_pages
      0.00            +0.1        0.07 ± 15%  perf-profile.self.cycles-pp.mutex_lock
      0.00            +0.1        0.07 ± 23%  perf-profile.self.cycles-pp.llist_add_batch
      0.00            +0.1        0.07 ± 17%  perf-profile.self.cycles-pp.__has_merged_page
      0.00            +0.1        0.07 ± 18%  perf-profile.self.cycles-pp.up_write
      0.00            +0.1        0.07 ± 27%  perf-profile.self.cycles-pp.__orc_find
      0.00            +0.1        0.08 ± 31%  perf-profile.self.cycles-pp.update_cfs_rq_h_load
      0.00            +0.1        0.08 ± 22%  perf-profile.self.cycles-pp.__list_del_entry_valid
      0.00            +0.1        0.09 ± 28%  perf-profile.self.cycles-pp.__radix_tree_lookup
      0.01 ±200%      +0.1        0.10 ± 28%  perf-profile.self.cycles-pp._raw_spin_lock_irq
      0.00            +0.1        0.09 ± 29%  perf-profile.self.cycles-pp.__account_scheduler_latency
      0.00            +0.1        0.09 ± 17%  perf-profile.self.cycles-pp.f2fs_do_sync_file
      0.00            +0.1        0.10 ± 16%  perf-profile.self.cycles-pp.down_write
      0.00            +0.1        0.10 ± 27%  perf-profile.self.cycles-pp.__get_node_page
      0.00            +0.1        0.10 ± 27%  perf-profile.self.cycles-pp.try_to_wake_up
      0.00            +0.1        0.12 ± 20%  perf-profile.self.cycles-pp.f2fs_allocate_data_block
      0.00            +0.1        0.13 ± 21%  perf-profile.self.cycles-pp.unwind_next_frame
      0.01 ±200%      +0.1        0.14 ± 20%  perf-profile.self.cycles-pp.brd_do_bvec
      0.03 ± 81%      +0.1        0.16 ± 21%  perf-profile.self.cycles-pp.f2fs_is_valid_blkaddr
      0.00            +0.1        0.14 ± 21%  perf-profile.self.cycles-pp.f2fs_balance_fs
      0.00            +0.1        0.14 ± 25%  perf-profile.self.cycles-pp.osq_unlock
      0.02 ±122%      +0.1        0.17 ± 28%  perf-profile.self.cycles-pp.xas_find_marked
      0.00            +0.2        0.16 ± 21%  perf-profile.self.cycles-pp.update_sit_entry
      0.00            +0.2        0.16 ± 22%  perf-profile.self.cycles-pp.up_read
      0.06 ± 12%      +0.2        0.25 ± 24%  perf-profile.self.cycles-pp.f2fs_fsync_node_pages
      0.13 ±  8%      +0.2        0.33 ± 18%  perf-profile.self.cycles-pp._raw_spin_lock
      0.07 ± 11%      +0.2        0.28 ± 23%  perf-profile.self.cycles-pp.down_read
      0.12 ±  9%      +0.2        0.35 ± 23%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.08 ±  6%      +0.2        0.30 ± 16%  perf-profile.self.cycles-pp.__percpu_counter_sum
      0.00            +0.3        0.26 ± 24%  perf-profile.self.cycles-pp.rwsem_down_read_slowpath
      0.00            +0.4        0.42 ± 21%  perf-profile.self.cycles-pp.mutex_spin_on_owner
      0.09 ± 12%      +0.6        0.65 ± 26%  perf-profile.self.cycles-pp.release_pages
      0.45 ±  9%      +0.6        1.05 ± 20%  perf-profile.self.cycles-pp.rwsem_spin_on_owner
      0.25 ±  8%      +1.1        1.31 ± 25%  perf-profile.self.cycles-pp.find_get_pages_range_tag
      0.72 ±  9%      +4.4        5.10 ± 21%  perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
     43728 ±  4%     -29.1%      30986 ± 10%  softirqs.CPU0.RCU
    109444 ±  3%     -75.6%      26711 ± 13%  softirqs.CPU0.SCHED
    339195 ±  5%     -78.2%      73813 ± 16%  softirqs.CPU0.TIMER
     39399           -32.4%      26645 ±  8%  softirqs.CPU1.RCU
    103015 ±  3%     -75.9%      24851 ± 10%  softirqs.CPU1.SCHED
    315672 ±  5%     -79.6%      64493 ± 14%  softirqs.CPU1.TIMER
     38813           -32.0%      26409 ±  7%  softirqs.CPU10.RCU
    102980 ±  3%     -76.7%      23980 ± 13%  softirqs.CPU10.SCHED
    315372 ±  5%     -80.0%      63182 ± 16%  softirqs.CPU10.TIMER
     38721 ±  2%     -32.7%      26042 ±  7%  softirqs.CPU100.RCU
    103337 ±  4%     -77.0%      23811 ± 11%  softirqs.CPU100.SCHED
    321248 ±  5%     -80.8%      61781 ± 15%  softirqs.CPU100.TIMER
     38593 ±  2%     -32.2%      26164 ±  6%  softirqs.CPU101.RCU
    105394 ±  4%     -77.5%      23741 ± 11%  softirqs.CPU101.SCHED
    321052 ±  5%     -80.8%      61675 ± 15%  softirqs.CPU101.TIMER
     38708 ±  2%     -32.5%      26114 ±  7%  softirqs.CPU102.RCU
    105906 ±  3%     -77.7%      23601 ± 12%  softirqs.CPU102.SCHED
    321659 ±  5%     -80.8%      61831 ± 15%  softirqs.CPU102.TIMER
     38449           -32.2%      26072 ±  5%  softirqs.CPU103.RCU
    106174 ±  3%     -78.3%      22988 ±  7%  softirqs.CPU103.SCHED
    319597 ±  5%     -80.5%      62254 ± 14%  softirqs.CPU103.TIMER
     38271 ±  2%     -32.4%      25884 ±  6%  softirqs.CPU104.RCU
    104278 ±  2%     -77.3%      23691 ± 11%  softirqs.CPU104.SCHED
    317219 ±  5%     -80.7%      61369 ± 15%  softirqs.CPU104.TIMER
     38340           -32.3%      25955 ±  6%  softirqs.CPU105.RCU
    105404 ±  3%     -77.6%      23652 ± 10%  softirqs.CPU105.SCHED
    318495 ±  5%     -80.7%      61429 ± 15%  softirqs.CPU105.TIMER
     38466 ±  2%     -32.5%      25954 ±  6%  softirqs.CPU106.RCU
    105956 ±  3%     -78.1%      23172 ± 14%  softirqs.CPU106.SCHED
    320347 ±  5%     -80.9%      61315 ± 15%  softirqs.CPU106.TIMER
     38651 ±  2%     -32.5%      26077 ±  7%  softirqs.CPU107.RCU
    104312 ±  4%     -77.3%      23677 ± 11%  softirqs.CPU107.SCHED
    321286 ±  5%     -80.8%      61647 ± 15%  softirqs.CPU107.TIMER
     38814 ±  2%     -32.7%      26121 ±  7%  softirqs.CPU108.RCU
    105948 ±  2%     -77.7%      23599 ± 10%  softirqs.CPU108.SCHED
    321249 ±  4%     -80.9%      61270 ± 15%  softirqs.CPU108.TIMER
     38197 ±  2%     -32.6%      25756 ±  7%  softirqs.CPU109.RCU
    104668 ±  3%     -77.4%      23673 ± 11%  softirqs.CPU109.SCHED
    317400 ±  5%     -80.5%      61886 ± 14%  softirqs.CPU109.TIMER
     38930 ±  2%     -31.9%      26503 ±  6%  softirqs.CPU11.RCU
    104054 ±  2%     -77.2%      23719 ± 11%  softirqs.CPU11.SCHED
    314476 ±  5%     -80.0%      63014 ± 15%  softirqs.CPU11.TIMER
     38335 ±  2%     -32.5%      25865 ±  7%  softirqs.CPU110.RCU
    104575 ±  3%     -77.4%      23672 ± 10%  softirqs.CPU110.SCHED
    316664 ±  5%     -80.6%      61392 ± 15%  softirqs.CPU110.TIMER
     38404 ±  2%     -32.7%      25851 ±  6%  softirqs.CPU111.RCU
    105567 ±  3%     -77.6%      23654 ± 11%  softirqs.CPU111.SCHED
    323237 ±  5%     -81.0%      61533 ± 15%  softirqs.CPU111.TIMER
     38683 ±  2%     -30.9%      26734 ±  7%  softirqs.CPU112.RCU
    105755 ±  2%     -77.6%      23670 ± 11%  softirqs.CPU112.SCHED
    320786 ±  5%     -80.8%      61672 ± 15%  softirqs.CPU112.TIMER
     38881           -30.9%      26876 ±  8%  softirqs.CPU113.RCU
    106405 ±  3%     -77.6%      23790 ± 11%  softirqs.CPU113.SCHED
    321051 ±  5%     -80.7%      61815 ± 15%  softirqs.CPU113.TIMER
     39041 ±  2%     -31.6%      26695 ±  7%  softirqs.CPU114.RCU
    106151 ±  4%     -77.5%      23891 ± 11%  softirqs.CPU114.SCHED
    323320 ±  5%     -80.8%      62037 ± 15%  softirqs.CPU114.TIMER
     38871 ±  2%     -31.6%      26593 ±  7%  softirqs.CPU115.RCU
    105317 ±  3%     -77.5%      23735 ± 11%  softirqs.CPU115.SCHED
    319916 ±  5%     -80.8%      61449 ± 15%  softirqs.CPU115.TIMER
     38390 ±  3%     -30.7%      26593 ±  7%  softirqs.CPU116.RCU
    107012 ±  2%     -77.8%      23742 ± 10%  softirqs.CPU116.SCHED
    321325 ±  5%     -80.8%      61817 ± 15%  softirqs.CPU116.TIMER
     38776           -31.3%      26641 ±  6%  softirqs.CPU117.RCU
    105110 ±  4%     -77.4%      23763 ± 11%  softirqs.CPU117.SCHED
    319810 ±  4%     -80.8%      61422 ± 15%  softirqs.CPU117.TIMER
     38846 ±  2%     -31.4%      26640 ±  7%  softirqs.CPU118.RCU
    106071 ±  3%     -77.8%      23528 ± 10%  softirqs.CPU118.SCHED
    319672 ±  5%     -80.8%      61416 ± 15%  softirqs.CPU118.TIMER
     38855           -31.7%      26535 ±  7%  softirqs.CPU119.RCU
    105792 ±  2%     -77.5%      23805 ± 11%  softirqs.CPU119.SCHED
    319023 ±  5%     -80.8%      61371 ± 15%  softirqs.CPU119.TIMER
     39200 ±  2%     -32.2%      26569 ±  7%  softirqs.CPU12.RCU
    103205 ±  2%     -76.8%      23907 ± 11%  softirqs.CPU12.SCHED
    317087 ±  6%     -80.0%      63314 ± 16%  softirqs.CPU12.TIMER
     39395           -31.6%      26933 ±  8%  softirqs.CPU120.RCU
    105766 ±  2%     -77.6%      23701 ± 11%  softirqs.CPU120.SCHED
    324484 ±  3%     -80.8%      62154 ± 14%  softirqs.CPU120.TIMER
     39174           -32.4%      26488 ±  6%  softirqs.CPU121.RCU
    105328 ±  3%     -77.6%      23616 ± 10%  softirqs.CPU121.SCHED
    324237 ±  4%     -81.0%      61475 ± 14%  softirqs.CPU121.TIMER
     39304           -32.6%      26479 ±  6%  softirqs.CPU122.RCU
    105789 ±  3%     -77.9%      23424 ± 10%  softirqs.CPU122.SCHED
    325339 ±  4%     -81.3%      60837 ± 14%  softirqs.CPU122.TIMER
     39540 ±  2%     -32.7%      26594 ±  6%  softirqs.CPU123.RCU
    105462 ±  3%     -77.4%      23827 ± 11%  softirqs.CPU123.SCHED
    326564 ±  4%     -81.0%      62113 ± 15%  softirqs.CPU123.TIMER
     39343 ±  2%     -32.5%      26575 ±  6%  softirqs.CPU124.RCU
    105583 ±  2%     -77.5%      23751 ± 11%  softirqs.CPU124.SCHED
    325023 ±  4%     -81.0%      61742 ± 14%  softirqs.CPU124.TIMER
     39519           -32.7%      26613 ±  6%  softirqs.CPU125.RCU
    106100 ±  4%     -77.6%      23721 ± 11%  softirqs.CPU125.SCHED
    326100 ±  4%     -81.1%      61705 ± 14%  softirqs.CPU125.TIMER
     40241 ±  3%     -33.8%      26655 ±  6%  softirqs.CPU126.RCU
    106265 ±  3%     -77.6%      23816 ± 11%  softirqs.CPU126.SCHED
    326128 ±  4%     -81.1%      61787 ± 15%  softirqs.CPU126.TIMER
     39243           -32.0%      26681 ±  6%  softirqs.CPU127.RCU
    105479 ±  2%     -77.9%      23358 ±  8%  softirqs.CPU127.SCHED
    324707 ±  4%     -81.0%      61636 ± 15%  softirqs.CPU127.TIMER
     38935           -33.7%      25833 ±  6%  softirqs.CPU128.RCU
    104755           -77.6%      23511 ±  9%  softirqs.CPU128.SCHED
    322793 ±  4%     -80.9%      61692 ± 14%  softirqs.CPU128.TIMER
     38459           -33.1%      25724 ±  6%  softirqs.CPU129.RCU
    105830 ±  2%     -77.8%      23460 ± 10%  softirqs.CPU129.SCHED
    322798 ±  3%     -80.9%      61707 ± 15%  softirqs.CPU129.TIMER
     38843 ±  3%     -31.9%      26448 ±  7%  softirqs.CPU13.RCU
    104235 ±  3%     -77.1%      23901 ± 10%  softirqs.CPU13.SCHED
    317117 ±  5%     -79.9%      63752 ± 15%  softirqs.CPU13.TIMER
     38387           -32.8%      25815 ±  6%  softirqs.CPU130.RCU
    103814 ±  4%     -77.1%      23729 ± 11%  softirqs.CPU130.SCHED
    325519 ±  4%     -81.1%      61615 ± 15%  softirqs.CPU130.TIMER
     38841           -33.5%      25821 ±  6%  softirqs.CPU131.RCU
    106323 ±  3%     -77.6%      23825 ± 11%  softirqs.CPU131.SCHED
    325941 ±  4%     -80.9%      62158 ± 15%  softirqs.CPU131.TIMER
     39032           -33.5%      25947 ±  6%  softirqs.CPU132.RCU
    105094 ±  4%     -77.4%      23778 ± 11%  softirqs.CPU132.SCHED
    324315 ±  4%     -80.9%      61936 ± 15%  softirqs.CPU132.TIMER
     38376           -32.6%      25865 ±  6%  softirqs.CPU133.RCU
    104304 ±  3%     -77.2%      23766 ± 11%  softirqs.CPU133.SCHED
    321727 ±  3%     -80.8%      61666 ± 15%  softirqs.CPU133.TIMER
     38745           -33.5%      25757 ±  6%  softirqs.CPU134.RCU
    105482 ±  3%     -77.6%      23657 ± 11%  softirqs.CPU134.SCHED
    325026 ±  4%     -81.1%      61311 ± 15%  softirqs.CPU134.TIMER
     38436 ±  2%     -33.3%      25628 ±  6%  softirqs.CPU135.RCU
    105533 ±  4%     -77.5%      23704 ± 11%  softirqs.CPU135.SCHED
    323329 ±  4%     -80.9%      61679 ± 15%  softirqs.CPU135.TIMER
     38967 ±  4%     -34.2%      25647 ±  6%  softirqs.CPU136.RCU
    105374 ±  3%     -77.5%      23712 ± 11%  softirqs.CPU136.SCHED
    324202 ±  5%     -81.0%      61556 ± 15%  softirqs.CPU136.TIMER
     39130 ±  2%     -34.0%      25842 ±  6%  softirqs.CPU137.RCU
    106097 ±  3%     -77.6%      23809 ± 11%  softirqs.CPU137.SCHED
    325456 ±  4%     -81.0%      61786 ± 15%  softirqs.CPU137.TIMER
     38706 ±  2%     -33.0%      25944 ±  7%  softirqs.CPU138.RCU
    105803 ±  2%     -77.5%      23778 ± 11%  softirqs.CPU138.SCHED
    325891 ±  4%     -81.0%      61810 ± 14%  softirqs.CPU138.TIMER
     38605           -33.7%      25598 ±  6%  softirqs.CPU139.RCU
    105652 ±  3%     -77.6%      23663 ± 11%  softirqs.CPU139.SCHED
    323205 ±  4%     -81.0%      61438 ± 15%  softirqs.CPU139.TIMER
     38533 ±  2%     -31.8%      26279 ±  7%  softirqs.CPU14.RCU
    103886 ±  3%     -77.6%      23282 ± 13%  softirqs.CPU14.SCHED
    316556 ±  5%     -80.1%      62904 ± 15%  softirqs.CPU14.TIMER
     38456           -33.2%      25680 ±  6%  softirqs.CPU140.RCU
    105541 ±  3%     -77.5%      23797 ± 11%  softirqs.CPU140.SCHED
    323754 ±  3%     -80.9%      61937 ± 15%  softirqs.CPU140.TIMER
     38400           -33.2%      25665 ±  5%  softirqs.CPU141.RCU
    105977 ±  3%     -77.6%      23695 ± 11%  softirqs.CPU141.SCHED
    323714 ±  4%     -81.0%      61587 ± 14%  softirqs.CPU141.TIMER
     38760 ±  2%     -33.4%      25824 ±  6%  softirqs.CPU142.RCU
    105231 ±  2%     -77.4%      23831 ± 11%  softirqs.CPU142.SCHED
    323574 ±  4%     -80.9%      61889 ± 14%  softirqs.CPU142.TIMER
     39016 ±  2%     -34.1%      25693 ±  6%  softirqs.CPU143.RCU
    106323 ±  3%     -77.7%      23715 ± 10%  softirqs.CPU143.SCHED
    325075 ±  4%     -81.1%      61407 ± 14%  softirqs.CPU143.TIMER
     38355           -33.8%      25396 ±  5%  softirqs.CPU144.RCU
    105479 ±  3%     -77.4%      23853 ± 11%  softirqs.CPU144.SCHED
    317365 ±  4%     -80.7%      61116 ± 13%  softirqs.CPU144.TIMER
     38978           -34.5%      25520 ±  6%  softirqs.CPU145.RCU
    105315 ±  2%     -77.2%      23975 ± 12%  softirqs.CPU145.SCHED
    318767 ±  5%     -80.9%      61008 ± 14%  softirqs.CPU145.TIMER
     38207           -33.5%      25401 ±  6%  softirqs.CPU146.RCU
    105995 ±  2%     -77.6%      23771 ± 10%  softirqs.CPU146.SCHED
    320447 ±  5%     -80.9%      61313 ± 13%  softirqs.CPU146.TIMER
     38092           -33.6%      25299 ±  6%  softirqs.CPU147.RCU
    105805 ±  4%     -77.5%      23805 ± 10%  softirqs.CPU147.SCHED
    321396 ±  5%     -80.9%      61302 ± 13%  softirqs.CPU147.TIMER
     38227           -33.9%      25266 ±  5%  softirqs.CPU148.RCU
    106074 ±  2%     -77.6%      23736 ± 11%  softirqs.CPU148.SCHED
    320567 ±  5%     -81.0%      60823 ± 14%  softirqs.CPU148.TIMER
     38456           -33.4%      25596 ±  5%  softirqs.CPU149.RCU
    106480 ±  3%     -77.8%      23675 ± 11%  softirqs.CPU149.SCHED
    319766 ±  5%     -80.8%      61417 ± 13%  softirqs.CPU149.TIMER
     38913           -32.4%      26297 ±  7%  softirqs.CPU15.RCU
    104794 ±  2%     -77.2%      23850 ± 11%  softirqs.CPU15.SCHED
    315838 ±  5%     -80.1%      62944 ± 16%  softirqs.CPU15.TIMER
     38404           -34.4%      25189 ±  5%  softirqs.CPU150.RCU
    105312 ±  2%     -77.1%      24107 ± 13%  softirqs.CPU150.SCHED
    321235 ±  5%     -78.7%      68354 ± 32%  softirqs.CPU150.TIMER
     37573 ±  2%     -32.6%      25318 ±  5%  softirqs.CPU151.RCU
    101482 ±  4%     -76.7%      23681 ± 10%  softirqs.CPU151.SCHED
    315839 ±  4%     -80.8%      60629 ± 13%  softirqs.CPU151.TIMER
     37977           -32.3%      25711 ±  7%  softirqs.CPU152.RCU
    105444 ±  3%     -77.6%      23569 ± 11%  softirqs.CPU152.SCHED
    319250 ±  4%     -80.6%      61905 ± 15%  softirqs.CPU152.TIMER
     38260           -33.9%      25294 ±  5%  softirqs.CPU153.RCU
    106282 ±  3%     -77.7%      23725 ± 11%  softirqs.CPU153.SCHED
    320761 ±  5%     -81.0%      60821 ± 14%  softirqs.CPU153.TIMER
     38746 ±  2%     -33.2%      25894 ±  7%  softirqs.CPU154.RCU
    106104 ±  3%     -77.3%      24035 ± 12%  softirqs.CPU154.SCHED
    319478 ±  5%     -78.2%      69496 ± 29%  softirqs.CPU154.TIMER
     39070           -33.9%      25821 ±  6%  softirqs.CPU155.RCU
    105488 ±  2%     -77.8%      23443 ± 11%  softirqs.CPU155.SCHED
    320040 ±  4%     -81.0%      60769 ± 14%  softirqs.CPU155.TIMER
     38036           -33.3%      25387 ±  6%  softirqs.CPU156.RCU
    104271 ±  4%     -77.3%      23648 ± 11%  softirqs.CPU156.SCHED
    314164 ±  5%     -80.7%      60505 ± 14%  softirqs.CPU156.TIMER
     38224           -33.8%      25320 ±  6%  softirqs.CPU157.RCU
    103028 ±  3%     -77.3%      23414 ± 13%  softirqs.CPU157.SCHED
    315464 ±  4%     -80.8%      60589 ± 13%  softirqs.CPU157.TIMER
     37833           -33.7%      25076 ±  5%  softirqs.CPU158.RCU
    105898 ±  2%     -77.7%      23631 ± 10%  softirqs.CPU158.SCHED
    319067 ±  5%     -81.0%      60733 ± 13%  softirqs.CPU158.TIMER
     38156           -34.0%      25164 ±  5%  softirqs.CPU159.RCU
    104825 ±  3%     -77.5%      23631 ± 11%  softirqs.CPU159.SCHED
    319695 ±  4%     -81.1%      60493 ± 14%  softirqs.CPU159.TIMER
     39346 ±  2%     -30.9%      27170 ±  7%  softirqs.CPU16.RCU
    104094 ±  3%     -77.1%      23826 ± 11%  softirqs.CPU16.SCHED
    314323 ±  5%     -80.0%      62969 ± 15%  softirqs.CPU16.TIMER
     39627           -32.5%      26758 ±  5%  softirqs.CPU160.RCU
    107897 ±  3%     -78.7%      22964 ±  7%  softirqs.CPU160.SCHED
    347619 ± 14%     -82.6%      60577 ± 13%  softirqs.CPU160.TIMER
     39609           -32.3%      26804 ±  6%  softirqs.CPU161.RCU
    106352 ±  3%     -78.6%      22739 ± 11%  softirqs.CPU161.SCHED
    319768 ±  5%     -81.0%      60875 ± 13%  softirqs.CPU161.TIMER
     39982           -32.4%      27047 ±  6%  softirqs.CPU162.RCU
    106144 ±  3%     -78.5%      22864 ±  7%  softirqs.CPU162.SCHED
    318374 ±  5%     -81.0%      60411 ± 13%  softirqs.CPU162.TIMER
     39977           -32.4%      27026 ±  5%  softirqs.CPU163.RCU
    106157 ±  3%     -77.5%      23875 ± 11%  softirqs.CPU163.SCHED
    318535 ±  5%     -81.0%      60540 ± 13%  softirqs.CPU163.TIMER
     39834           -33.0%      26696 ±  6%  softirqs.CPU164.RCU
    106314 ±  3%     -78.5%      22811 ± 11%  softirqs.CPU164.SCHED
    321013 ±  5%     -81.1%      60670 ± 14%  softirqs.CPU164.TIMER
     39571           -31.8%      26994 ±  7%  softirqs.CPU165.RCU
    105687 ±  3%     -77.5%      23817 ± 11%  softirqs.CPU165.SCHED
    316976 ±  5%     -80.6%      61361 ± 16%  softirqs.CPU165.TIMER
     39769           -31.9%      27063 ±  4%  softirqs.CPU166.RCU
    106553 ±  3%     -77.8%      23697 ± 11%  softirqs.CPU166.SCHED
    319814 ±  5%     -81.0%      60740 ± 14%  softirqs.CPU166.TIMER
     40361 ±  2%     -33.7%      26774 ±  5%  softirqs.CPU167.RCU
    105717 ±  2%     -77.8%      23502 ± 12%  softirqs.CPU167.SCHED
    319158 ±  5%     -80.9%      60846 ± 14%  softirqs.CPU167.TIMER
     37451           -32.2%      25400 ±  6%  softirqs.CPU168.RCU
    106591 ±  3%     -78.0%      23455 ± 10%  softirqs.CPU168.SCHED
    326882 ±  3%     -81.0%      62146 ± 14%  softirqs.CPU168.TIMER
     37832           -33.5%      25145 ±  8%  softirqs.CPU169.RCU
    104005 ±  3%     -77.1%      23825 ± 10%  softirqs.CPU169.SCHED
    321720 ±  4%     -81.3%      60254 ± 16%  softirqs.CPU169.TIMER
     39409 ±  2%     -31.0%      27212 ±  7%  softirqs.CPU17.RCU
    104453 ±  3%     -77.2%      23823 ± 11%  softirqs.CPU17.SCHED
    314553 ±  5%     -80.0%      62997 ± 16%  softirqs.CPU17.TIMER
     37872           -33.0%      25381 ±  6%  softirqs.CPU170.RCU
    105879 ±  3%     -77.5%      23775 ± 12%  softirqs.CPU170.SCHED
    326178 ±  3%     -81.0%      61893 ± 15%  softirqs.CPU170.TIMER
     37495           -32.5%      25291 ±  6%  softirqs.CPU171.RCU
    106964 ±  3%     -77.6%      23987 ± 11%  softirqs.CPU171.SCHED
    327826 ±  4%     -81.1%      62056 ± 15%  softirqs.CPU171.TIMER
     37580           -33.0%      25191 ±  7%  softirqs.CPU172.RCU
    107225 ±  3%     -77.7%      23942 ± 11%  softirqs.CPU172.SCHED
    327592 ±  4%     -81.1%      61839 ± 15%  softirqs.CPU172.TIMER
     37452           -32.7%      25208 ±  7%  softirqs.CPU173.RCU
    106656 ±  3%     -77.4%      24109 ± 12%  softirqs.CPU173.SCHED
    324770 ±  3%     -80.8%      62264 ± 16%  softirqs.CPU173.TIMER
     37554           -32.3%      25439 ±  7%  softirqs.CPU174.RCU
    106980 ±  2%     -77.4%      24204 ± 10%  softirqs.CPU174.SCHED
    326356 ±  3%     -80.9%      62386 ± 14%  softirqs.CPU174.TIMER
     37500           -31.6%      25649 ±  8%  softirqs.CPU175.RCU
    105194 ±  2%     -77.6%      23524 ± 13%  softirqs.CPU175.SCHED
    320325 ±  2%     -80.9%      61250 ± 15%  softirqs.CPU175.TIMER
     36751           -33.4%      24483 ±  6%  softirqs.CPU176.RCU
    104153 ±  2%     -77.4%      23562 ± 12%  softirqs.CPU176.SCHED
    317899 ±  2%     -80.8%      61028 ± 15%  softirqs.CPU176.TIMER
     36901           -33.8%      24424 ±  6%  softirqs.CPU177.RCU
    104332 ±  6%     -77.2%      23759 ± 10%  softirqs.CPU177.SCHED
    324245 ±  4%     -81.2%      61016 ± 15%  softirqs.CPU177.TIMER
     36997 ±  2%     -33.8%      24493 ±  6%  softirqs.CPU178.RCU
    105760 ±  3%     -77.6%      23727 ± 11%  softirqs.CPU178.SCHED
    322862 ±  3%     -81.0%      61271 ± 15%  softirqs.CPU178.TIMER
     37132           -33.7%      24628 ±  6%  softirqs.CPU179.RCU
    106509 ±  2%     -77.6%      23815 ± 11%  softirqs.CPU179.SCHED
    326307 ±  3%     -81.1%      61651 ± 14%  softirqs.CPU179.TIMER
     39329 ±  2%     -31.5%      26932 ±  7%  softirqs.CPU18.RCU
    104815 ±  3%     -77.4%      23736 ± 11%  softirqs.CPU18.SCHED
    314958 ±  5%     -80.0%      62936 ± 15%  softirqs.CPU18.TIMER
     37339           -33.4%      24886 ±  7%  softirqs.CPU180.RCU
    105582 ±  4%     -77.4%      23819 ± 11%  softirqs.CPU180.SCHED
    323259 ±  3%     -80.9%      61867 ± 14%  softirqs.CPU180.TIMER
     37178           -33.3%      24806 ±  7%  softirqs.CPU181.RCU
    106714 ±  3%     -77.6%      23850 ± 10%  softirqs.CPU181.SCHED
    325532 ±  3%     -81.1%      61524 ± 15%  softirqs.CPU181.TIMER
     37293 ±  2%     -33.6%      24754 ±  5%  softirqs.CPU182.RCU
    106464 ±  3%     -77.6%      23854 ± 11%  softirqs.CPU182.SCHED
    324518 ±  3%     -81.1%      61251 ± 15%  softirqs.CPU182.TIMER
     36861 ±  2%     -33.8%      24418 ±  6%  softirqs.CPU183.RCU
    105652 ±  2%     -77.4%      23833 ± 10%  softirqs.CPU183.SCHED
    322813 ±  3%     -81.0%      61391 ± 14%  softirqs.CPU183.TIMER
     36576           -33.1%      24479 ±  6%  softirqs.CPU184.RCU
    105286 ±  2%     -77.4%      23769 ± 11%  softirqs.CPU184.SCHED
    318664 ±  2%     -80.8%      61061 ± 15%  softirqs.CPU184.TIMER
     37274 ±  2%     -34.5%      24409 ±  6%  softirqs.CPU185.RCU
    106155 ±  3%     -77.4%      23944 ± 11%  softirqs.CPU185.SCHED
    324516 ±  3%     -81.3%      60751 ± 17%  softirqs.CPU185.TIMER
     36927           -33.5%      24539 ±  6%  softirqs.CPU186.RCU
    106828 ±  3%     -77.7%      23843 ± 11%  softirqs.CPU186.SCHED
    326229 ±  3%     -81.1%      61783 ± 15%  softirqs.CPU186.TIMER
     36855           -32.8%      24750 ±  5%  softirqs.CPU187.RCU
    105125           -77.2%      23962 ± 10%  softirqs.CPU187.SCHED
    321392 ±  3%     -81.0%      61102 ± 15%  softirqs.CPU187.TIMER
     36738           -33.5%      24437 ±  6%  softirqs.CPU188.RCU
    105977 ±  2%     -77.5%      23827 ± 11%  softirqs.CPU188.SCHED
    324488 ±  4%     -81.1%      61472 ± 15%  softirqs.CPU188.TIMER
     36889           -33.7%      24457 ±  6%  softirqs.CPU189.RCU
    106623 ±  3%     -77.7%      23758 ± 10%  softirqs.CPU189.SCHED
    325816 ±  4%     -81.1%      61610 ± 15%  softirqs.CPU189.TIMER
     39485 ±  2%     -31.8%      26930 ±  7%  softirqs.CPU19.RCU
    103935 ±  3%     -77.1%      23769 ± 11%  softirqs.CPU19.SCHED
    314653 ±  5%     -80.1%      62605 ± 15%  softirqs.CPU19.TIMER
     37069           -33.1%      24797 ±  5%  softirqs.CPU190.RCU
    107051 ±  3%     -77.8%      23809 ± 11%  softirqs.CPU190.SCHED
    328056 ±  4%     -81.1%      61884 ± 15%  softirqs.CPU190.TIMER
     37553 ±  3%     -33.8%      24877 ±  5%  softirqs.CPU191.RCU
    107000 ±  3%     -77.9%      23671 ± 12%  softirqs.CPU191.SCHED
    326739 ±  4%     -81.0%      62158 ± 14%  softirqs.CPU191.TIMER
     39112           -32.1%      26561 ±  9%  softirqs.CPU2.RCU
    103603 ±  2%     -76.9%      23971 ± 10%  softirqs.CPU2.SCHED
    315235 ±  5%     -80.0%      63005 ± 16%  softirqs.CPU2.TIMER
     38746 ±  4%     -30.5%      26919 ±  7%  softirqs.CPU20.RCU
    105442 ±  2%     -77.7%      23520 ± 12%  softirqs.CPU20.SCHED
    344913 ± 12%     -81.7%      62974 ± 15%  softirqs.CPU20.TIMER
     39173           -30.8%      27124 ±  7%  softirqs.CPU21.RCU
    104010 ±  3%     -77.3%      23561 ± 11%  softirqs.CPU21.SCHED
    313897 ±  5%     -80.0%      62797 ± 15%  softirqs.CPU21.TIMER
     39553           -31.7%      27010 ±  7%  softirqs.CPU22.RCU
    104678 ±  3%     -77.3%      23718 ± 10%  softirqs.CPU22.SCHED
    315825 ±  5%     -80.2%      62673 ± 15%  softirqs.CPU22.TIMER
     39343 ±  2%     -31.2%      27068 ±  7%  softirqs.CPU23.RCU
    103357 ±  4%     -77.0%      23746 ± 11%  softirqs.CPU23.SCHED
    315053 ±  5%     -80.1%      62755 ± 15%  softirqs.CPU23.TIMER
     39838           -31.9%      27129 ±  6%  softirqs.CPU24.RCU
    101724 ±  2%     -76.5%      23885 ± 10%  softirqs.CPU24.SCHED
    322399 ±  3%     -80.3%      63455 ± 15%  softirqs.CPU24.TIMER
     39935           -32.3%      27051 ±  6%  softirqs.CPU25.RCU
    103556 ±  3%     -77.2%      23656 ± 10%  softirqs.CPU25.SCHED
    323520 ±  3%     -80.6%      62875 ± 15%  softirqs.CPU25.TIMER
     39717           -32.2%      26923 ±  6%  softirqs.CPU26.RCU
    102237 ±  4%     -77.9%      22585 ± 11%  softirqs.CPU26.SCHED
    317102 ±  3%     -81.3%      59454 ± 16%  softirqs.CPU26.TIMER
     39792           -32.0%      27070 ±  6%  softirqs.CPU27.RCU
    104949 ±  3%     -77.8%      23308 ± 12%  softirqs.CPU27.SCHED
    321255 ±  3%     -80.3%      63420 ± 15%  softirqs.CPU27.TIMER
     40447 ±  4%     -33.6%      26851 ±  6%  softirqs.CPU28.RCU
    104178 ±  3%     -77.2%      23701 ± 11%  softirqs.CPU28.SCHED
    322220 ±  3%     -80.5%      62878 ± 15%  softirqs.CPU28.TIMER
     40068 ±  2%     -32.8%      26929 ±  6%  softirqs.CPU29.RCU
    105244 ±  3%     -77.5%      23713 ± 11%  softirqs.CPU29.SCHED
    321058 ±  3%     -80.4%      62876 ± 15%  softirqs.CPU29.TIMER
     39036           -32.4%      26393 ±  6%  softirqs.CPU3.RCU
    105165 ±  3%     -77.2%      23937 ± 11%  softirqs.CPU3.SCHED
    316079 ±  5%     -80.0%      63183 ± 15%  softirqs.CPU3.TIMER
     39748           -32.1%      27005 ±  6%  softirqs.CPU30.RCU
    102851 ±  2%     -77.4%      23214 ± 14%  softirqs.CPU30.SCHED
    321305 ±  3%     -80.4%      62902 ± 15%  softirqs.CPU30.TIMER
     39629           -31.4%      27175 ±  6%  softirqs.CPU31.RCU
    103868 ±  2%     -77.1%      23793 ± 10%  softirqs.CPU31.SCHED
    320260 ±  3%     -80.3%      63232 ± 14%  softirqs.CPU31.TIMER
     39459           -33.0%      26425 ±  6%  softirqs.CPU32.RCU
    104500 ±  3%     -77.3%      23702 ± 11%  softirqs.CPU32.SCHED
    320466 ±  3%     -80.3%      63004 ± 15%  softirqs.CPU32.TIMER
     39202           -32.9%      26289 ±  6%  softirqs.CPU33.RCU
    104156 ±  3%     -77.2%      23729 ± 11%  softirqs.CPU33.SCHED
    320917 ±  3%     -80.3%      63114 ± 16%  softirqs.CPU33.TIMER
     39206           -32.5%      26470 ±  7%  softirqs.CPU34.RCU
    104050 ±  2%     -77.1%      23836 ± 11%  softirqs.CPU34.SCHED
    322745 ±  3%     -80.4%      63416 ± 16%  softirqs.CPU34.TIMER
     39259           -32.9%      26356 ±  6%  softirqs.CPU35.RCU
    104804 ±  3%     -77.3%      23774 ± 11%  softirqs.CPU35.SCHED
    320908 ±  3%     -80.3%      63181 ± 15%  softirqs.CPU35.TIMER
     39574 ±  2%     -33.6%      26259 ±  6%  softirqs.CPU36.RCU
    104792 ±  2%     -77.3%      23754 ± 11%  softirqs.CPU36.SCHED
    320375 ±  3%     -80.3%      62966 ± 15%  softirqs.CPU36.TIMER
     39237           -32.7%      26388 ±  6%  softirqs.CPU37.RCU
    103864 ±  3%     -77.2%      23695 ± 11%  softirqs.CPU37.SCHED
    323739 ±  3%     -80.6%      62810 ± 15%  softirqs.CPU37.TIMER
     39463           -33.6%      26209 ±  6%  softirqs.CPU38.RCU
    104503 ±  2%     -77.4%      23654 ± 11%  softirqs.CPU38.SCHED
    322559 ±  3%     -80.6%      62638 ± 15%  softirqs.CPU38.TIMER
     39381 ±  2%     -32.7%      26513 ±  7%  softirqs.CPU39.RCU
    102928 ±  4%     -76.9%      23733 ± 11%  softirqs.CPU39.SCHED
    322354 ±  2%     -80.3%      63459 ± 16%  softirqs.CPU39.TIMER
     39340           -32.4%      26602 ±  6%  softirqs.CPU4.RCU
    104042 ±  4%     -77.1%      23799 ± 12%  softirqs.CPU4.SCHED
    316106 ±  5%     -80.0%      63259 ± 16%  softirqs.CPU4.TIMER
     39540 ±  3%     -33.5%      26298 ±  7%  softirqs.CPU40.RCU
    104044 ±  3%     -77.1%      23873 ± 11%  softirqs.CPU40.SCHED
    320611 ±  3%     -80.4%      62906 ± 15%  softirqs.CPU40.TIMER
     39332           -33.3%      26219 ±  6%  softirqs.CPU41.RCU
    104642 ±  2%     -77.3%      23734 ± 11%  softirqs.CPU41.SCHED
    321284 ±  3%     -80.4%      62814 ± 15%  softirqs.CPU41.TIMER
     39297           -33.3%      26207 ±  6%  softirqs.CPU42.RCU
    104394 ±  3%     -77.3%      23704 ± 11%  softirqs.CPU42.SCHED
    320615 ±  3%     -80.4%      62835 ± 15%  softirqs.CPU42.TIMER
     39528           -33.4%      26340 ±  6%  softirqs.CPU43.RCU
    103840 ±  3%     -77.1%      23747 ± 11%  softirqs.CPU43.SCHED
    321044 ±  3%     -80.5%      62732 ± 15%  softirqs.CPU43.TIMER
     39291           -33.2%      26252 ±  6%  softirqs.CPU44.RCU
    104222 ±  3%     -77.3%      23611 ± 10%  softirqs.CPU44.SCHED
    319951 ±  3%     -80.4%      62781 ± 15%  softirqs.CPU44.TIMER
     39170           -33.5%      26041 ±  6%  softirqs.CPU45.RCU
    104312 ±  2%     -77.3%      23658 ± 11%  softirqs.CPU45.SCHED
    321419 ±  3%     -80.5%      62664 ± 15%  softirqs.CPU45.TIMER
     39168           -33.3%      26125 ±  6%  softirqs.CPU46.RCU
    104970 ±  3%     -77.4%      23758 ± 11%  softirqs.CPU46.SCHED
    321098 ±  3%     -80.4%      62962 ± 15%  softirqs.CPU46.TIMER
     39409 ±  2%     -33.5%      26192 ±  6%  softirqs.CPU47.RCU
    104346 ±  3%     -77.3%      23733 ± 11%  softirqs.CPU47.SCHED
    320909 ±  3%     -80.4%      62806 ± 15%  softirqs.CPU47.TIMER
     39070 ±  2%     -33.5%      25999 ±  5%  softirqs.CPU48.RCU
    101010 ±  3%     -76.2%      24012 ± 10%  softirqs.CPU48.SCHED
    314239 ±  3%     -80.1%      62614 ± 13%  softirqs.CPU48.TIMER
     38803           -33.6%      25751 ±  5%  softirqs.CPU49.RCU
    103195 ±  2%     -77.1%      23679 ± 10%  softirqs.CPU49.SCHED
    312361 ±  4%     -80.2%      61801 ± 14%  softirqs.CPU49.TIMER
     39185 ±  2%     -32.3%      26536 ±  6%  softirqs.CPU5.RCU
    104414 ±  3%     -77.4%      23590 ± 10%  softirqs.CPU5.SCHED
    316156 ±  5%     -80.0%      63117 ± 15%  softirqs.CPU5.TIMER
     38793           -33.5%      25779 ±  6%  softirqs.CPU50.RCU
    103973 ±  2%     -77.3%      23560 ± 12%  softirqs.CPU50.SCHED
    313392 ±  3%     -80.2%      62068 ± 14%  softirqs.CPU50.TIMER
     38688           -33.0%      25928 ±  4%  softirqs.CPU51.RCU
    104523 ±  3%     -77.4%      23651 ± 11%  softirqs.CPU51.SCHED
    314990 ±  3%     -80.1%      62785 ± 13%  softirqs.CPU51.TIMER
     38989           -33.9%      25790 ±  5%  softirqs.CPU52.RCU
    102869 ±  3%     -77.0%      23701 ± 11%  softirqs.CPU52.SCHED
    313144 ±  4%     -80.2%      61994 ± 14%  softirqs.CPU52.TIMER
     38983           -33.8%      25814 ±  5%  softirqs.CPU53.RCU
    101736 ±  5%     -76.7%      23656 ± 11%  softirqs.CPU53.SCHED
    312900 ±  4%     -80.1%      62166 ± 14%  softirqs.CPU53.TIMER
     38972           -34.5%      25510 ±  5%  softirqs.CPU54.RCU
    104553 ±  3%     -77.4%      23667 ± 11%  softirqs.CPU54.SCHED
    313818 ±  3%     -80.3%      61673 ± 13%  softirqs.CPU54.TIMER
     38582           -32.4%      26076 ±  4%  softirqs.CPU55.RCU
    104914 ±  5%     -77.5%      23571 ± 11%  softirqs.CPU55.SCHED
    347314 ± 16%     -81.9%      62753 ± 13%  softirqs.CPU55.TIMER
     38644           -31.4%      26511 ±  4%  softirqs.CPU56.RCU
    104080 ±  2%     -77.4%      23554 ± 11%  softirqs.CPU56.SCHED
    315039 ±  4%     -80.1%      62727 ± 13%  softirqs.CPU56.TIMER
     38978           -33.7%      25851 ±  5%  softirqs.CPU57.RCU
    104075 ±  3%     -77.3%      23648 ± 11%  softirqs.CPU57.SCHED
    313643 ±  3%     -80.3%      61873 ± 14%  softirqs.CPU57.TIMER
     39130           -34.7%      25548 ±  5%  softirqs.CPU58.RCU
    104597 ±  2%     -77.3%      23704 ± 11%  softirqs.CPU58.SCHED
    312916 ±  4%     -80.4%      61418 ± 13%  softirqs.CPU58.TIMER
     39114           -33.4%      26038 ±  5%  softirqs.CPU59.RCU
    103394 ±  3%     -77.1%      23663 ± 10%  softirqs.CPU59.SCHED
    313898 ±  4%     -80.3%      61940 ± 14%  softirqs.CPU59.TIMER
     39952 ±  2%     -33.2%      26696 ±  6%  softirqs.CPU6.RCU
    104455 ±  3%     -77.3%      23734 ± 11%  softirqs.CPU6.SCHED
    316951 ±  5%     -80.1%      63083 ± 15%  softirqs.CPU6.TIMER
     38420           -32.7%      25863 ±  5%  softirqs.CPU60.RCU
    103459 ±  3%     -77.2%      23557 ± 11%  softirqs.CPU60.SCHED
    311837 ±  4%     -80.2%      61728 ± 14%  softirqs.CPU60.TIMER
     38720           -33.1%      25918 ±  5%  softirqs.CPU61.RCU
    102683 ±  3%     -77.0%      23587 ± 11%  softirqs.CPU61.SCHED
    312631 ±  4%     -80.3%      61690 ± 14%  softirqs.CPU61.TIMER
     38901 ±  2%     -34.1%      25649 ±  5%  softirqs.CPU62.RCU
    104147 ±  2%     -77.6%      23308 ± 10%  softirqs.CPU62.SCHED
    313710 ±  3%     -80.2%      61995 ± 13%  softirqs.CPU62.TIMER
     38666           -33.6%      25658 ±  5%  softirqs.CPU63.RCU
    103943 ±  3%     -77.2%      23665 ± 11%  softirqs.CPU63.SCHED
    314619 ±  3%     -80.3%      61873 ± 14%  softirqs.CPU63.TIMER
     39046 ±  3%     -31.0%      26958 ±  5%  softirqs.CPU64.RCU
    104056 ±  2%     -77.3%      23652 ± 11%  softirqs.CPU64.SCHED
    309033 ±  5%     -80.0%      61939 ± 14%  softirqs.CPU64.TIMER
     40248 ±  2%     -32.1%      27333 ±  4%  softirqs.CPU65.RCU
    104117 ±  2%     -77.7%      23231 ± 14%  softirqs.CPU65.SCHED
    315140 ±  4%     -80.2%      62484 ± 13%  softirqs.CPU65.TIMER
     40156           -32.4%      27148 ±  5%  softirqs.CPU66.RCU
    102971 ±  3%     -77.1%      23579 ± 11%  softirqs.CPU66.SCHED
    312230 ±  4%     -80.2%      61820 ± 14%  softirqs.CPU66.TIMER
     39868           -31.1%      27487 ±  7%  softirqs.CPU67.RCU
    103836 ±  2%     -77.5%      23348 ± 11%  softirqs.CPU67.SCHED
    313111 ±  3%     -80.2%      61841 ± 13%  softirqs.CPU67.TIMER
     39795           -32.4%      26899 ±  6%  softirqs.CPU68.RCU
    103181 ±  2%     -77.1%      23667 ± 11%  softirqs.CPU68.SCHED
    314497 ±  3%     -80.3%      61852 ± 14%  softirqs.CPU68.TIMER
     39749           -32.6%      26774 ±  6%  softirqs.CPU69.RCU
    104574 ±  3%     -77.4%      23673 ± 10%  softirqs.CPU69.SCHED
    312780 ±  3%     -80.3%      61632 ± 14%  softirqs.CPU69.TIMER
     38887           -32.5%      26239 ±  6%  softirqs.CPU7.RCU
    102408 ±  3%     -76.9%      23672 ± 11%  softirqs.CPU7.SCHED
    314851 ±  5%     -80.1%      62755 ± 15%  softirqs.CPU7.TIMER
     39662           -32.0%      26960 ±  6%  softirqs.CPU70.RCU
    104018 ±  3%     -77.4%      23472 ±  9%  softirqs.CPU70.SCHED
    312736 ±  4%     -80.2%      61774 ± 13%  softirqs.CPU70.TIMER
     39676           -32.3%      26874 ±  6%  softirqs.CPU71.RCU
    103797 ±  3%     -77.2%      23660 ± 11%  softirqs.CPU71.SCHED
    313160 ±  3%     -80.3%      61776 ± 14%  softirqs.CPU71.TIMER
     37350           -30.8%      25835 ±  7%  softirqs.CPU72.RCU
    104241 ±  5%     -77.1%      23912 ± 10%  softirqs.CPU72.SCHED
    349237 ± 17%     -81.9%      63220 ± 14%  softirqs.CPU72.TIMER
     37794           -31.4%      25932 ±  5%  softirqs.CPU73.RCU
    102835 ±  3%     -76.7%      23984 ±  9%  softirqs.CPU73.SCHED
    314821 ±  2%     -78.3%      68316 ± 17%  softirqs.CPU73.TIMER
     37747           -32.5%      25483 ±  6%  softirqs.CPU74.RCU
    104486 ±  2%     -77.3%      23770 ± 10%  softirqs.CPU74.SCHED
    316070 ±  2%     -80.2%      62488 ± 15%  softirqs.CPU74.TIMER
     37742           -32.3%      25563 ±  6%  softirqs.CPU75.RCU
    104890 ±  3%     -77.2%      23865 ± 11%  softirqs.CPU75.SCHED
    317034 ±  2%     -80.2%      62693 ± 15%  softirqs.CPU75.TIMER
     37779           -32.2%      25604 ±  6%  softirqs.CPU76.RCU
    105067 ±  2%     -77.3%      23837 ± 11%  softirqs.CPU76.SCHED
    317236 ±  2%     -80.3%      62509 ± 15%  softirqs.CPU76.TIMER
     38022 ±  2%     -32.8%      25548 ±  6%  softirqs.CPU77.RCU
    104628 ±  2%     -77.5%      23576 ± 11%  softirqs.CPU77.SCHED
    316046 ±  2%     -80.2%      62444 ± 15%  softirqs.CPU77.TIMER
     37612           -32.3%      25469 ±  6%  softirqs.CPU78.RCU
    105005 ±  2%     -77.3%      23831 ± 11%  softirqs.CPU78.SCHED
    315935 ±  2%     -80.2%      62622 ± 15%  softirqs.CPU78.TIMER
     37667           -32.1%      25559 ±  6%  softirqs.CPU79.RCU
    103907 ±  2%     -77.1%      23800 ± 11%  softirqs.CPU79.SCHED
    314457 ±  2%     -80.2%      62281 ± 15%  softirqs.CPU79.TIMER
     38653 ±  2%     -31.9%      26322 ±  7%  softirqs.CPU8.RCU
    103998 ±  2%     -77.3%      23641 ± 11%  softirqs.CPU8.SCHED
    315378 ±  5%     -80.1%      62892 ± 15%  softirqs.CPU8.TIMER
     37124           -33.0%      24858 ±  6%  softirqs.CPU80.RCU
    103803 ±  2%     -77.1%      23739 ± 11%  softirqs.CPU80.SCHED
    315549 ±  2%     -80.3%      62103 ± 15%  softirqs.CPU80.TIMER
     37270 ±  2%     -33.2%      24914 ±  6%  softirqs.CPU81.RCU
    103551 ±  4%     -77.1%      23736 ± 10%  softirqs.CPU81.SCHED
    317088 ±  2%     -80.4%      62132 ± 15%  softirqs.CPU81.TIMER
     37348           -33.2%      24931 ±  6%  softirqs.CPU82.RCU
    104414 ±  2%     -77.2%      23788 ± 10%  softirqs.CPU82.SCHED
    314482           -80.2%      62256 ± 15%  softirqs.CPU82.TIMER
     37613           -32.8%      25279 ±  6%  softirqs.CPU83.RCU
    104932 ±  2%     -77.2%      23916 ± 10%  softirqs.CPU83.SCHED
    316202 ±  2%     -80.2%      62632 ± 15%  softirqs.CPU83.TIMER
     37563           -32.9%      25191 ±  6%  softirqs.CPU84.RCU
    104718 ±  2%     -77.3%      23788 ± 11%  softirqs.CPU84.SCHED
    315460 ±  2%     -80.2%      62432 ± 15%  softirqs.CPU84.TIMER
     37197           -33.2%      24853 ±  6%  softirqs.CPU85.RCU
    104180 ±  3%     -77.1%      23827 ± 11%  softirqs.CPU85.SCHED
    315747 ±  2%     -80.3%      62245 ± 15%  softirqs.CPU85.TIMER
     37230 ±  2%     -32.0%      25319 ±  8%  softirqs.CPU86.RCU
    104685 ±  2%     -77.4%      23689 ± 11%  softirqs.CPU86.SCHED
    315886 ±  2%     -80.0%      63059 ± 14%  softirqs.CPU86.TIMER
     37251           -32.7%      25075 ±  6%  softirqs.CPU87.RCU
    103911 ±  2%     -77.1%      23744 ± 11%  softirqs.CPU87.SCHED
    315595 ±  2%     -80.2%      62451 ± 14%  softirqs.CPU87.TIMER
     37193           -32.0%      25306 ±  7%  softirqs.CPU88.RCU
    104312 ±  2%     -77.1%      23924 ± 11%  softirqs.CPU88.SCHED
    314873 ±  2%     -80.2%      62324 ± 15%  softirqs.CPU88.TIMER
     37571           -33.3%      25067 ±  6%  softirqs.CPU89.RCU
    104982 ±  2%     -77.0%      24115 ± 10%  softirqs.CPU89.SCHED
    315543 ±  2%     -78.6%      67504 ± 14%  softirqs.CPU89.TIMER
     38667 ±  2%     -32.1%      26261 ±  7%  softirqs.CPU9.RCU
    103825 ±  3%     -77.2%      23708 ± 11%  softirqs.CPU9.SCHED
    316253 ±  5%     -80.1%      63015 ± 15%  softirqs.CPU9.TIMER
     37570           -32.7%      25266 ±  6%  softirqs.CPU90.RCU
    105134 ±  2%     -77.3%      23895 ± 11%  softirqs.CPU90.SCHED
    316147 ±  2%     -80.2%      62550 ± 15%  softirqs.CPU90.TIMER
     37218           -32.8%      24996 ±  6%  softirqs.CPU91.RCU
    104444 ±  2%     -77.2%      23824 ± 11%  softirqs.CPU91.SCHED
    315454 ±  2%     -80.3%      62208 ± 15%  softirqs.CPU91.TIMER
     37356           -33.0%      25021 ±  6%  softirqs.CPU92.RCU
    104467 ±  3%     -77.2%      23824 ± 10%  softirqs.CPU92.SCHED
    316063 ±  2%     -80.2%      62453 ± 15%  softirqs.CPU92.TIMER
     37322           -33.0%      25023 ±  6%  softirqs.CPU93.RCU
    104836 ±  3%     -77.2%      23879 ± 10%  softirqs.CPU93.SCHED
    316254 ±  2%     -80.3%      62443 ± 15%  softirqs.CPU93.TIMER
     37447           -33.0%      25085 ±  6%  softirqs.CPU94.RCU
    104385 ±  3%     -77.2%      23820 ± 11%  softirqs.CPU94.SCHED
    316766 ±  2%     -80.2%      62653 ± 15%  softirqs.CPU94.TIMER
     37578           -32.7%      25296 ±  6%  softirqs.CPU95.RCU
    103902 ±  2%     -81.0%      19731 ± 25%  softirqs.CPU95.SCHED
    316532 ±  2%     -80.3%      62436 ± 15%  softirqs.CPU95.TIMER
     37920 ±  2%     -33.1%      25370 ±  6%  softirqs.CPU96.RCU
    103993 ±  3%     -78.0%      22854 ±  8%  softirqs.CPU96.SCHED
    319704 ±  5%     -80.8%      61317 ± 15%  softirqs.CPU96.TIMER
     38322 ±  3%     -31.2%      26352 ±  5%  softirqs.CPU97.RCU
    106688 ±  4%     -77.9%      23595 ± 11%  softirqs.CPU97.SCHED
    348032 ± 15%     -82.4%      61294 ± 16%  softirqs.CPU97.TIMER
     38509           -31.9%      26208 ±  9%  softirqs.CPU98.RCU
    104992 ±  3%     -77.1%      23991 ± 10%  softirqs.CPU98.SCHED
    320751 ±  5%     -78.9%      67546 ± 16%  softirqs.CPU98.TIMER
     38375 ±  2%     -32.7%      25839 ±  7%  softirqs.CPU99.RCU
    106814 ±  3%     -77.8%      23763 ± 11%  softirqs.CPU99.SCHED
    323126 ±  5%     -80.8%      61980 ± 15%  softirqs.CPU99.TIMER
     13390 ± 38%     -79.6%       2728 ± 38%  softirqs.NET_RX
   7416427           -32.7%    4989933 ±  6%  softirqs.RCU
  20136151 ±  3%     -77.4%    4549197 ± 11%  softirqs.SCHED
  61478762 ±  3%     -80.6%   11950741 ± 15%  softirqs.TIMER
      7385 ± 55%     -80.8%       1420 ±159%  interrupts.31:PCI-MSI.524289-edge.eth0-TxRx-0
      8484 ± 33%     -85.9%       1194 ± 82%  interrupts.33:PCI-MSI.524291-edge.eth0-TxRx-2
      1754 ±  2%     -81.8%     319.20 ± 17%  interrupts.9:IO-APIC.9-fasteoi.acpi
   1041561           +41.0%    1468141 ±  7%  interrupts.CAL:Function_call_interrupts
      5699 ±  6%     +34.8%       7685 ±  7%  interrupts.CPU0.CAL:Function_call_interrupts
   1755350 ±  2%     -81.8%     319088 ± 17%  interrupts.CPU0.LOC:Local_timer_interrupts
      1128 ± 31%    +175.9%       3113 ± 14%  interrupts.CPU0.NMI:Non-maskable_interrupts
      1128 ± 31%    +175.9%       3113 ± 14%  interrupts.CPU0.PMI:Performance_monitoring_interrupts
    286.60 ± 22%     -50.7%     141.20 ± 22%  interrupts.CPU0.TLB:TLB_shootdowns
      1754 ±  2%     -81.8%     319.20 ± 17%  interrupts.CPU1.9:IO-APIC.9-fasteoi.acpi
      5845 ±  8%     +37.6%       8044 ±  9%  interrupts.CPU1.CAL:Function_call_interrupts
   1755144 ±  2%     -81.8%     319068 ± 17%  interrupts.CPU1.LOC:Local_timer_interrupts
      1384 ± 11%    +103.1%       2813 ± 13%  interrupts.CPU1.NMI:Non-maskable_interrupts
      1384 ± 11%    +103.1%       2813 ± 13%  interrupts.CPU1.PMI:Performance_monitoring_interrupts
      7385 ± 55%     -80.8%       1420 ±159%  interrupts.CPU10.31:PCI-MSI.524289-edge.eth0-TxRx-0
      5418 ±  2%     +40.8%       7626 ±  7%  interrupts.CPU10.CAL:Function_call_interrupts
   1755226 ±  2%     -81.8%     319039 ± 17%  interrupts.CPU10.LOC:Local_timer_interrupts
    252.00 ±  5%     +54.4%     389.20 ±  6%  interrupts.CPU10.RES:Rescheduling_interrupts
      5339           +46.1%       7801 ± 11%  interrupts.CPU100.CAL:Function_call_interrupts
   1754879 ±  2%     -81.8%     319030 ± 17%  interrupts.CPU100.LOC:Local_timer_interrupts
      1449 ±  4%    +101.9%       2927 ± 31%  interrupts.CPU100.NMI:Non-maskable_interrupts
      1449 ±  4%    +101.9%       2927 ± 31%  interrupts.CPU100.PMI:Performance_monitoring_interrupts
      5284 ±  2%     +45.6%       7693 ± 10%  interrupts.CPU101.CAL:Function_call_interrupts
   1755063 ±  2%     -81.8%     319017 ± 17%  interrupts.CPU101.LOC:Local_timer_interrupts
      1384 ±  9%    +131.8%       3208 ± 20%  interrupts.CPU101.NMI:Non-maskable_interrupts
      1384 ±  9%    +131.8%       3208 ± 20%  interrupts.CPU101.PMI:Performance_monitoring_interrupts
    336.20 ±  5%     +12.6%     378.60 ±  5%  interrupts.CPU101.RES:Rescheduling_interrupts
      5209           +48.1%       7717 ± 10%  interrupts.CPU102.CAL:Function_call_interrupts
   1754794 ±  2%     -81.8%     318938 ± 17%  interrupts.CPU102.LOC:Local_timer_interrupts
      1548 ±  8%    +108.7%       3231 ± 16%  interrupts.CPU102.NMI:Non-maskable_interrupts
      1548 ±  8%    +108.7%       3231 ± 16%  interrupts.CPU102.PMI:Performance_monitoring_interrupts
      5470 ±  4%     +43.2%       7835 ± 10%  interrupts.CPU103.CAL:Function_call_interrupts
   1755294 ±  2%     -81.8%     318978 ± 17%  interrupts.CPU103.LOC:Local_timer_interrupts
      1572 ± 12%     +95.1%       3066 ± 20%  interrupts.CPU103.NMI:Non-maskable_interrupts
      1572 ± 12%     +95.1%       3066 ± 20%  interrupts.CPU103.PMI:Performance_monitoring_interrupts
      5294 ±  2%     +44.7%       7662 ±  7%  interrupts.CPU104.CAL:Function_call_interrupts
   1755263 ±  2%     -81.8%     319010 ± 17%  interrupts.CPU104.LOC:Local_timer_interrupts
      1436 ± 13%    +121.3%       3178 ± 15%  interrupts.CPU104.NMI:Non-maskable_interrupts
      1436 ± 13%    +121.3%       3178 ± 15%  interrupts.CPU104.PMI:Performance_monitoring_interrupts
      5239 ±  2%     +45.3%       7615 ±  9%  interrupts.CPU105.CAL:Function_call_interrupts
   1755173 ±  2%     -81.8%     318998 ± 17%  interrupts.CPU105.LOC:Local_timer_interrupts
      1551 ± 16%    +105.1%       3181 ± 14%  interrupts.CPU105.NMI:Non-maskable_interrupts
      1551 ± 16%    +105.1%       3181 ± 14%  interrupts.CPU105.PMI:Performance_monitoring_interrupts
    341.40 ±  8%     +11.4%     380.20 ±  4%  interrupts.CPU105.RES:Rescheduling_interrupts
      5368 ±  3%     +43.8%       7719 ±  9%  interrupts.CPU106.CAL:Function_call_interrupts
   1755205 ±  2%     -81.8%     319002 ± 17%  interrupts.CPU106.LOC:Local_timer_interrupts
      1545 ±  6%     +86.2%       2878 ± 30%  interrupts.CPU106.NMI:Non-maskable_interrupts
      1545 ±  6%     +86.2%       2878 ± 30%  interrupts.CPU106.PMI:Performance_monitoring_interrupts
    346.20 ±  5%     +12.1%     388.20 ±  7%  interrupts.CPU106.RES:Rescheduling_interrupts
      5270           +45.3%       7658 ±  9%  interrupts.CPU107.CAL:Function_call_interrupts
   1755208 ±  2%     -81.8%     319004 ± 17%  interrupts.CPU107.LOC:Local_timer_interrupts
      1486 ± 10%     +98.7%       2953 ± 30%  interrupts.CPU107.NMI:Non-maskable_interrupts
      1486 ± 10%     +98.7%       2953 ± 30%  interrupts.CPU107.PMI:Performance_monitoring_interrupts
      5263           +46.6%       7719 ± 10%  interrupts.CPU108.CAL:Function_call_interrupts
   1755142 ±  2%     -81.8%     319012 ± 17%  interrupts.CPU108.LOC:Local_timer_interrupts
    337.80 ±  6%     +12.0%     378.20 ±  5%  interrupts.CPU108.RES:Rescheduling_interrupts
      5348 ±  4%     +44.0%       7704 ±  9%  interrupts.CPU109.CAL:Function_call_interrupts
   1755234 ±  2%     -81.8%     318993 ± 17%  interrupts.CPU109.LOC:Local_timer_interrupts
      1617 ± 16%    +102.8%       3281 ± 19%  interrupts.CPU109.NMI:Non-maskable_interrupts
      1617 ± 16%    +102.8%       3281 ± 19%  interrupts.CPU109.PMI:Performance_monitoring_interrupts
    347.20 ±  2%     +10.9%     385.00 ±  6%  interrupts.CPU109.RES:Rescheduling_interrupts
      5392 ±  2%     +41.0%       7602 ±  9%  interrupts.CPU11.CAL:Function_call_interrupts
   1755089 ±  2%     -81.8%     319025 ± 17%  interrupts.CPU11.LOC:Local_timer_interrupts
    237.80 ±  3%     +61.3%     383.60 ±  7%  interrupts.CPU11.RES:Rescheduling_interrupts
      5293           +44.4%       7641 ±  9%  interrupts.CPU110.CAL:Function_call_interrupts
   1755186 ±  2%     -81.8%     319004 ± 17%  interrupts.CPU110.LOC:Local_timer_interrupts
      1474 ± 11%    +114.2%       3158 ± 16%  interrupts.CPU110.NMI:Non-maskable_interrupts
      1474 ± 11%    +114.2%       3158 ± 16%  interrupts.CPU110.PMI:Performance_monitoring_interrupts
    327.60 ±  5%     +17.6%     385.40 ±  5%  interrupts.CPU110.RES:Rescheduling_interrupts
      5373 ±  2%     +45.9%       7838 ±  9%  interrupts.CPU111.CAL:Function_call_interrupts
   1755274 ±  2%     -81.8%     319025 ± 17%  interrupts.CPU111.LOC:Local_timer_interrupts
      1484 ±  5%    +108.0%       3086 ± 20%  interrupts.CPU111.NMI:Non-maskable_interrupts
      1484 ±  5%    +108.0%       3086 ± 20%  interrupts.CPU111.PMI:Performance_monitoring_interrupts
      5408 ±  3%     +44.4%       7808 ± 10%  interrupts.CPU112.CAL:Function_call_interrupts
   1755242 ±  2%     -81.8%     319001 ± 17%  interrupts.CPU112.LOC:Local_timer_interrupts
      1458 ± 12%    +115.5%       3143 ± 16%  interrupts.CPU112.NMI:Non-maskable_interrupts
      1458 ± 12%    +115.5%       3143 ± 16%  interrupts.CPU112.PMI:Performance_monitoring_interrupts
      5352 ±  3%     +46.4%       7837 ± 10%  interrupts.CPU113.CAL:Function_call_interrupts
   1755302 ±  2%     -81.8%     319001 ± 17%  interrupts.CPU113.LOC:Local_timer_interrupts
      5382 ±  5%     +48.1%       7969 ± 14%  interrupts.CPU114.CAL:Function_call_interrupts
   1755359 ±  2%     -81.8%     318999 ± 17%  interrupts.CPU114.LOC:Local_timer_interrupts
      1273 ± 14%    +151.2%       3199 ± 15%  interrupts.CPU114.NMI:Non-maskable_interrupts
      1273 ± 14%    +151.2%       3199 ± 15%  interrupts.CPU114.PMI:Performance_monitoring_interrupts
      5396 ±  2%     +44.6%       7802 ± 10%  interrupts.CPU115.CAL:Function_call_interrupts
   1755350 ±  2%     -81.8%     319009 ± 17%  interrupts.CPU115.LOC:Local_timer_interrupts
      5386 ±  3%     +41.3%       7611 ± 11%  interrupts.CPU116.CAL:Function_call_interrupts
   1755192 ±  2%     -81.8%     319004 ± 17%  interrupts.CPU116.LOC:Local_timer_interrupts
    338.80 ±  5%     +12.2%     380.00 ±  5%  interrupts.CPU116.RES:Rescheduling_interrupts
      5306 ±  3%     +44.7%       7679 ±  9%  interrupts.CPU117.CAL:Function_call_interrupts
   1755226 ±  2%     -81.8%     319012 ± 17%  interrupts.CPU117.LOC:Local_timer_interrupts
      5276           +50.4%       7934 ±  9%  interrupts.CPU118.CAL:Function_call_interrupts
   1755337 ±  2%     -81.8%     318992 ± 17%  interrupts.CPU118.LOC:Local_timer_interrupts
      1370 ± 19%    +101.0%       2753 ± 15%  interrupts.CPU118.NMI:Non-maskable_interrupts
      1370 ± 19%    +101.0%       2753 ± 15%  interrupts.CPU118.PMI:Performance_monitoring_interrupts
      5294 ±  3%     +46.3%       7744 ± 10%  interrupts.CPU119.CAL:Function_call_interrupts
   1755057 ±  2%     -81.8%     318997 ± 17%  interrupts.CPU119.LOC:Local_timer_interrupts
      8484 ± 33%     -85.9%       1194 ± 82%  interrupts.CPU12.33:PCI-MSI.524291-edge.eth0-TxRx-2
      5270 ±  2%     +46.5%       7722 ±  9%  interrupts.CPU12.CAL:Function_call_interrupts
   1755109 ±  2%     -81.8%     319041 ± 17%  interrupts.CPU12.LOC:Local_timer_interrupts
    250.60 ±  8%     +55.9%     390.60 ±  4%  interrupts.CPU12.RES:Rescheduling_interrupts
      5617 ±  2%     +38.7%       7791 ±  8%  interrupts.CPU120.CAL:Function_call_interrupts
   1754989 ±  2%     -81.8%     319037 ± 17%  interrupts.CPU120.LOC:Local_timer_interrupts
      1314 ± 17%    +105.8%       2704 ± 37%  interrupts.CPU120.NMI:Non-maskable_interrupts
      1314 ± 17%    +105.8%       2704 ± 37%  interrupts.CPU120.PMI:Performance_monitoring_interrupts
      5508 ±  2%     +38.9%       7653 ±  9%  interrupts.CPU121.CAL:Function_call_interrupts
   1755051 ±  2%     -81.8%     318996 ± 17%  interrupts.CPU121.LOC:Local_timer_interrupts
      1310 ± 29%    +101.3%       2638 ± 37%  interrupts.CPU121.NMI:Non-maskable_interrupts
      1310 ± 29%    +101.3%       2638 ± 37%  interrupts.CPU121.PMI:Performance_monitoring_interrupts
    337.60 ±  6%     +17.4%     396.20 ±  9%  interrupts.CPU121.RES:Rescheduling_interrupts
      5480 ±  4%     +37.2%       7518 ± 10%  interrupts.CPU122.CAL:Function_call_interrupts
   1755172 ±  2%     -81.8%     319043 ± 17%  interrupts.CPU122.LOC:Local_timer_interrupts
      1355 ± 22%    +136.5%       3204 ± 16%  interrupts.CPU122.NMI:Non-maskable_interrupts
      1355 ± 22%    +136.5%       3204 ± 16%  interrupts.CPU122.PMI:Performance_monitoring_interrupts
      5531 ±  5%     +34.2%       7421 ±  5%  interrupts.CPU123.CAL:Function_call_interrupts
   1755178 ±  2%     -81.8%     319022 ± 17%  interrupts.CPU123.LOC:Local_timer_interrupts
      1438 ± 19%    +103.1%       2920 ± 33%  interrupts.CPU123.NMI:Non-maskable_interrupts
      1438 ± 19%    +103.1%       2920 ± 33%  interrupts.CPU123.PMI:Performance_monitoring_interrupts
      5602 ±  4%     +35.7%       7600 ±  7%  interrupts.CPU124.CAL:Function_call_interrupts
   1755072 ±  2%     -81.8%     319009 ± 17%  interrupts.CPU124.LOC:Local_timer_interrupts
      1329 ± 24%    +148.3%       3301 ± 17%  interrupts.CPU124.NMI:Non-maskable_interrupts
      1329 ± 24%    +148.3%       3301 ± 17%  interrupts.CPU124.PMI:Performance_monitoring_interrupts
      5483 ±  5%     +38.5%       7592 ±  6%  interrupts.CPU125.CAL:Function_call_interrupts
   1755219 ±  2%     -81.8%     319022 ± 17%  interrupts.CPU125.LOC:Local_timer_interrupts
      1290 ± 22%    +152.7%       3261 ± 21%  interrupts.CPU125.NMI:Non-maskable_interrupts
      1290 ± 22%    +152.7%       3261 ± 21%  interrupts.CPU125.PMI:Performance_monitoring_interrupts
      5361 ±  4%     +42.4%       7636 ±  6%  interrupts.CPU126.CAL:Function_call_interrupts
   1755153 ±  2%     -81.8%     318966 ± 17%  interrupts.CPU126.LOC:Local_timer_interrupts
      1354 ± 25%    +139.0%       3237 ± 18%  interrupts.CPU126.NMI:Non-maskable_interrupts
      1354 ± 25%    +139.0%       3237 ± 18%  interrupts.CPU126.PMI:Performance_monitoring_interrupts
      5421 ±  2%     +42.9%       7748 ±  7%  interrupts.CPU127.CAL:Function_call_interrupts
   1755182 ±  2%     -81.8%     318981 ± 17%  interrupts.CPU127.LOC:Local_timer_interrupts
      1250 ± 25%    +112.1%       2652 ± 40%  interrupts.CPU127.NMI:Non-maskable_interrupts
      1250 ± 25%    +112.1%       2652 ± 40%  interrupts.CPU127.PMI:Performance_monitoring_interrupts
    341.20 ±  3%     +19.0%     406.00 ±  7%  interrupts.CPU127.RES:Rescheduling_interrupts
      5367 ±  2%     +39.6%       7493 ±  8%  interrupts.CPU128.CAL:Function_call_interrupts
   1755127 ±  2%     -81.8%     319008 ± 17%  interrupts.CPU128.LOC:Local_timer_interrupts
      1183 ± 28%    +150.2%       2960 ± 32%  interrupts.CPU128.NMI:Non-maskable_interrupts
      1183 ± 28%    +150.2%       2960 ± 32%  interrupts.CPU128.PMI:Performance_monitoring_interrupts
      5356 ±  3%     +40.6%       7532 ±  8%  interrupts.CPU129.CAL:Function_call_interrupts
   1755107 ±  2%     -81.8%     318981 ± 17%  interrupts.CPU129.LOC:Local_timer_interrupts
      1149 ± 34%    +155.2%       2931 ± 33%  interrupts.CPU129.NMI:Non-maskable_interrupts
      1149 ± 34%    +155.2%       2931 ± 33%  interrupts.CPU129.PMI:Performance_monitoring_interrupts
    327.00 ±  4%     +17.0%     382.60 ±  3%  interrupts.CPU129.RES:Rescheduling_interrupts
      5410 ±  2%     +43.7%       7777 ±  9%  interrupts.CPU13.CAL:Function_call_interrupts
   1755217 ±  2%     -81.8%     319020 ± 17%  interrupts.CPU13.LOC:Local_timer_interrupts
      5347 ±  3%     +40.5%       7514 ±  8%  interrupts.CPU130.CAL:Function_call_interrupts
   1755124 ±  2%     -81.8%     318996 ± 17%  interrupts.CPU130.LOC:Local_timer_interrupts
      1194 ± 30%    +141.9%       2890 ± 30%  interrupts.CPU130.NMI:Non-maskable_interrupts
      1194 ± 30%    +141.9%       2890 ± 30%  interrupts.CPU130.PMI:Performance_monitoring_interrupts
      5420 ±  2%     +37.5%       7453 ±  8%  interrupts.CPU131.CAL:Function_call_interrupts
   1755225 ±  2%     -81.8%     318996 ± 17%  interrupts.CPU131.LOC:Local_timer_interrupts
      1199 ± 27%    +106.1%       2471 ± 22%  interrupts.CPU131.NMI:Non-maskable_interrupts
      1199 ± 27%    +106.1%       2471 ± 22%  interrupts.CPU131.PMI:Performance_monitoring_interrupts
      5403 ±  4%     +40.4%       7585 ±  6%  interrupts.CPU132.CAL:Function_call_interrupts
   1755090 ±  2%     -81.8%     319012 ± 17%  interrupts.CPU132.LOC:Local_timer_interrupts
      1181 ± 38%    +170.3%       3194 ± 16%  interrupts.CPU132.NMI:Non-maskable_interrupts
      1181 ± 38%    +170.3%       3194 ± 16%  interrupts.CPU132.PMI:Performance_monitoring_interrupts
      5469 ±  2%     +37.1%       7501 ±  7%  interrupts.CPU133.CAL:Function_call_interrupts
   1755199 ±  2%     -81.8%     318984 ± 17%  interrupts.CPU133.LOC:Local_timer_interrupts
      1152 ± 26%    +143.3%       2804 ± 14%  interrupts.CPU133.NMI:Non-maskable_interrupts
      1152 ± 26%    +143.3%       2804 ± 14%  interrupts.CPU133.PMI:Performance_monitoring_interrupts
      5435 ±  4%     +41.8%       7710 ±  8%  interrupts.CPU134.CAL:Function_call_interrupts
   1755075 ±  2%     -81.8%     318958 ± 17%  interrupts.CPU134.LOC:Local_timer_interrupts
      1214 ± 19%    +130.2%       2796 ± 13%  interrupts.CPU134.NMI:Non-maskable_interrupts
      1214 ± 19%    +130.2%       2796 ± 13%  interrupts.CPU134.PMI:Performance_monitoring_interrupts
    340.80 ±  3%     +16.4%     396.80 ±  4%  interrupts.CPU134.RES:Rescheduling_interrupts
      5293 ±  3%     +42.1%       7523 ±  8%  interrupts.CPU135.CAL:Function_call_interrupts
   1755100 ±  2%     -81.8%     318897 ± 17%  interrupts.CPU135.LOC:Local_timer_interrupts
      1244 ± 25%     +98.2%       2465 ± 22%  interrupts.CPU135.NMI:Non-maskable_interrupts
      1244 ± 25%     +98.2%       2465 ± 22%  interrupts.CPU135.PMI:Performance_monitoring_interrupts
      5421 ±  2%     +39.4%       7558 ±  9%  interrupts.CPU136.CAL:Function_call_interrupts
   1755142 ±  2%     -81.8%     318930 ± 17%  interrupts.CPU136.LOC:Local_timer_interrupts
      1240 ± 33%    +143.2%       3017 ± 34%  interrupts.CPU136.NMI:Non-maskable_interrupts
      1240 ± 33%    +143.2%       3017 ± 34%  interrupts.CPU136.PMI:Performance_monitoring_interrupts
      5508 ±  6%     +36.5%       7518 ±  8%  interrupts.CPU137.CAL:Function_call_interrupts
   1755111 ±  2%     -81.8%     318983 ± 17%  interrupts.CPU137.LOC:Local_timer_interrupts
    943.00 ± 26%    +165.8%       2506 ± 22%  interrupts.CPU137.NMI:Non-maskable_interrupts
    943.00 ± 26%    +165.8%       2506 ± 22%  interrupts.CPU137.PMI:Performance_monitoring_interrupts
      5405 ±  3%     +39.0%       7514 ±  9%  interrupts.CPU138.CAL:Function_call_interrupts
   1755057 ±  2%     -81.8%     318998 ± 17%  interrupts.CPU138.LOC:Local_timer_interrupts
      1002 ± 24%    +166.3%       2668 ± 40%  interrupts.CPU138.NMI:Non-maskable_interrupts
      1002 ± 24%    +166.3%       2668 ± 40%  interrupts.CPU138.PMI:Performance_monitoring_interrupts
      5356 ±  3%     +42.6%       7638 ±  7%  interrupts.CPU139.CAL:Function_call_interrupts
   1755134 ±  2%     -81.8%     318972 ± 17%  interrupts.CPU139.LOC:Local_timer_interrupts
      1045 ± 32%    +146.0%       2571 ± 26%  interrupts.CPU139.NMI:Non-maskable_interrupts
      1045 ± 32%    +146.0%       2571 ± 26%  interrupts.CPU139.PMI:Performance_monitoring_interrupts
      5362 ±  3%     +43.7%       7708 ±  9%  interrupts.CPU14.CAL:Function_call_interrupts
   1755189 ±  2%     -81.8%     318811 ± 17%  interrupts.CPU14.LOC:Local_timer_interrupts
    257.40 ±  2%     +46.9%     378.20 ±  2%  interrupts.CPU14.RES:Rescheduling_interrupts
      5596 ±  7%     +32.6%       7421 ±  6%  interrupts.CPU140.CAL:Function_call_interrupts
   1755171 ±  2%     -81.8%     318981 ± 17%  interrupts.CPU140.LOC:Local_timer_interrupts
      1227 ± 28%    +135.8%       2894 ± 28%  interrupts.CPU140.NMI:Non-maskable_interrupts
      1227 ± 28%    +135.8%       2894 ± 28%  interrupts.CPU140.PMI:Performance_monitoring_interrupts
      5265 ±  3%     +42.9%       7524 ±  6%  interrupts.CPU141.CAL:Function_call_interrupts
   1755131 ±  2%     -81.8%     318946 ± 17%  interrupts.CPU141.LOC:Local_timer_interrupts
      1196 ± 26%    +169.6%       3225 ± 18%  interrupts.CPU141.NMI:Non-maskable_interrupts
      1196 ± 26%    +169.6%       3225 ± 18%  interrupts.CPU141.PMI:Performance_monitoring_interrupts
      5322 ±  2%     +40.6%       7481 ±  6%  interrupts.CPU142.CAL:Function_call_interrupts
   1755192 ±  2%     -81.8%     319001 ± 17%  interrupts.CPU142.LOC:Local_timer_interrupts
      1217 ± 24%    +111.4%       2573 ± 26%  interrupts.CPU142.NMI:Non-maskable_interrupts
      1217 ± 24%    +111.4%       2573 ± 26%  interrupts.CPU142.PMI:Performance_monitoring_interrupts
      5282 ±  3%     +43.0%       7552 ±  8%  interrupts.CPU143.CAL:Function_call_interrupts
   1755122 ±  2%     -81.8%     319018 ± 17%  interrupts.CPU143.LOC:Local_timer_interrupts
      1276 ± 19%    +133.4%       2978 ± 30%  interrupts.CPU143.NMI:Non-maskable_interrupts
      1276 ± 19%    +133.4%       2978 ± 30%  interrupts.CPU143.PMI:Performance_monitoring_interrupts
      5756 ±  9%     +30.8%       7527 ±  8%  interrupts.CPU144.CAL:Function_call_interrupts
   1755197 ±  2%     -81.8%     319021 ± 17%  interrupts.CPU144.LOC:Local_timer_interrupts
      1297 ± 26%    +133.7%       3032 ± 32%  interrupts.CPU144.NMI:Non-maskable_interrupts
      1297 ± 26%    +133.7%       3032 ± 32%  interrupts.CPU144.PMI:Performance_monitoring_interrupts
      5516 ±  6%     +35.9%       7496 ±  8%  interrupts.CPU145.CAL:Function_call_interrupts
   1755292 ±  2%     -81.8%     319043 ± 17%  interrupts.CPU145.LOC:Local_timer_interrupts
      5365 ±  2%     +39.0%       7458 ±  7%  interrupts.CPU146.CAL:Function_call_interrupts
   1755394 ±  2%     -81.8%     319042 ± 17%  interrupts.CPU146.LOC:Local_timer_interrupts
      5411 ±  2%     +37.0%       7411 ±  7%  interrupts.CPU147.CAL:Function_call_interrupts
   1755377 ±  2%     -81.8%     319041 ± 17%  interrupts.CPU147.LOC:Local_timer_interrupts
      5461 ±  3%     +35.6%       7407 ±  8%  interrupts.CPU148.CAL:Function_call_interrupts
   1755376 ±  2%     -81.8%     319038 ± 17%  interrupts.CPU148.LOC:Local_timer_interrupts
      1700 ± 11%     +92.0%       3266 ± 13%  interrupts.CPU148.NMI:Non-maskable_interrupts
      1700 ± 11%     +92.0%       3266 ± 13%  interrupts.CPU148.PMI:Performance_monitoring_interrupts
      5283           +39.3%       7360 ±  7%  interrupts.CPU149.CAL:Function_call_interrupts
   1755332 ±  2%     -81.8%     318973 ± 17%  interrupts.CPU149.LOC:Local_timer_interrupts
      1548 ±  9%    +111.8%       3280 ± 14%  interrupts.CPU149.NMI:Non-maskable_interrupts
      1548 ±  9%    +111.8%       3280 ± 14%  interrupts.CPU149.PMI:Performance_monitoring_interrupts
      5347           +44.3%       7719 ±  9%  interrupts.CPU15.CAL:Function_call_interrupts
   1755337 ±  2%     -81.8%     319027 ± 17%  interrupts.CPU15.LOC:Local_timer_interrupts
    241.40 ±  6%     +64.3%     396.60 ±  5%  interrupts.CPU15.RES:Rescheduling_interrupts
      5461 ±  4%     +40.5%       7672 ±  8%  interrupts.CPU150.CAL:Function_call_interrupts
   1754662 ±  2%     -81.8%     319072 ± 17%  interrupts.CPU150.LOC:Local_timer_interrupts
      1318 ± 24%    +141.3%       3180 ± 16%  interrupts.CPU150.NMI:Non-maskable_interrupts
      1318 ± 24%    +141.3%       3180 ± 16%  interrupts.CPU150.PMI:Performance_monitoring_interrupts
      5376 ±  2%     +38.7%       7457 ±  8%  interrupts.CPU151.CAL:Function_call_interrupts
   1755338 ±  2%     -81.8%     319011 ± 17%  interrupts.CPU151.LOC:Local_timer_interrupts
      1307 ± 23%    +143.7%       3186 ± 16%  interrupts.CPU151.NMI:Non-maskable_interrupts
      1307 ± 23%    +143.7%       3186 ± 16%  interrupts.CPU151.PMI:Performance_monitoring_interrupts
      5425 ±  3%     +34.7%       7309 ±  9%  interrupts.CPU152.CAL:Function_call_interrupts
   1754836 ±  2%     -81.8%     319012 ± 17%  interrupts.CPU152.LOC:Local_timer_interrupts
      1434 ± 28%     +94.1%       2785 ± 14%  interrupts.CPU152.NMI:Non-maskable_interrupts
      1434 ± 28%     +94.1%       2785 ± 14%  interrupts.CPU152.PMI:Performance_monitoring_interrupts
      5332 ±  2%     +39.0%       7411 ±  6%  interrupts.CPU153.CAL:Function_call_interrupts
   1755331 ±  2%     -81.8%     319021 ± 17%  interrupts.CPU153.LOC:Local_timer_interrupts
      1400 ± 25%    +133.6%       3271 ± 17%  interrupts.CPU153.NMI:Non-maskable_interrupts
      1400 ± 25%    +133.6%       3271 ± 17%  interrupts.CPU153.PMI:Performance_monitoring_interrupts
    316.60 ±  4%     +22.0%     386.20 ±  2%  interrupts.CPU153.RES:Rescheduling_interrupts
      5453 ±  4%     +36.0%       7415 ±  7%  interrupts.CPU154.CAL:Function_call_interrupts
   1755336 ±  2%     -81.8%     319010 ± 17%  interrupts.CPU154.LOC:Local_timer_interrupts
      1545 ± 28%    +114.1%       3308 ± 15%  interrupts.CPU154.NMI:Non-maskable_interrupts
      1545 ± 28%    +114.1%       3308 ± 15%  interrupts.CPU154.PMI:Performance_monitoring_interrupts
      5369 ±  3%     +42.0%       7623 ±  6%  interrupts.CPU155.CAL:Function_call_interrupts
   1755417 ±  2%     -81.8%     319032 ± 17%  interrupts.CPU155.LOC:Local_timer_interrupts
      1420 ± 21%    +131.1%       3281 ± 20%  interrupts.CPU155.NMI:Non-maskable_interrupts
      1420 ± 21%    +131.1%       3281 ± 20%  interrupts.CPU155.PMI:Performance_monitoring_interrupts
    320.00 ±  5%     +17.7%     376.60 ± 10%  interrupts.CPU155.RES:Rescheduling_interrupts
      5459           +35.2%       7378 ±  7%  interrupts.CPU156.CAL:Function_call_interrupts
   1755363 ±  2%     -81.8%     319007 ± 17%  interrupts.CPU156.LOC:Local_timer_interrupts
      1332 ± 31%    +108.3%       2775 ± 12%  interrupts.CPU156.NMI:Non-maskable_interrupts
      1332 ± 31%    +108.3%       2775 ± 12%  interrupts.CPU156.PMI:Performance_monitoring_interrupts
      5435 ±  4%     +38.5%       7526 ±  8%  interrupts.CPU157.CAL:Function_call_interrupts
   1755339 ±  2%     -81.8%     319021 ± 17%  interrupts.CPU157.LOC:Local_timer_interrupts
      1209 ± 19%    +174.2%       3315 ± 17%  interrupts.CPU157.NMI:Non-maskable_interrupts
      1209 ± 19%    +174.2%       3315 ± 17%  interrupts.CPU157.PMI:Performance_monitoring_interrupts
      5407 ±  4%     +35.0%       7300 ±  7%  interrupts.CPU158.CAL:Function_call_interrupts
   1755375 ±  2%     -81.8%     319014 ± 17%  interrupts.CPU158.LOC:Local_timer_interrupts
      1224 ± 25%    +174.2%       3357 ± 16%  interrupts.CPU158.NMI:Non-maskable_interrupts
      1224 ± 25%    +174.2%       3357 ± 16%  interrupts.CPU158.PMI:Performance_monitoring_interrupts
    324.60 ±  2%     +15.6%     375.20 ±  5%  interrupts.CPU158.RES:Rescheduling_interrupts
      5421           +36.6%       7406 ±  8%  interrupts.CPU159.CAL:Function_call_interrupts
   1754935 ±  2%     -81.8%     318998 ± 17%  interrupts.CPU159.LOC:Local_timer_interrupts
      1092 ± 18%    +161.6%       2857 ± 14%  interrupts.CPU159.NMI:Non-maskable_interrupts
      1092 ± 18%    +161.6%       2857 ± 14%  interrupts.CPU159.PMI:Performance_monitoring_interrupts
      5401 ±  3%     +42.2%       7679 ±  8%  interrupts.CPU16.CAL:Function_call_interrupts
   1755286 ±  2%     -81.8%     319010 ± 17%  interrupts.CPU16.LOC:Local_timer_interrupts
    261.60 ±  4%     +48.4%     388.20 ±  5%  interrupts.CPU16.RES:Rescheduling_interrupts
      5428 ±  3%     +34.9%       7324 ±  8%  interrupts.CPU160.CAL:Function_call_interrupts
   1755402 ±  2%     -81.8%     319017 ± 17%  interrupts.CPU160.LOC:Local_timer_interrupts
      1272 ± 20%    +151.3%       3197 ± 14%  interrupts.CPU160.NMI:Non-maskable_interrupts
      1272 ± 20%    +151.3%       3197 ± 14%  interrupts.CPU160.PMI:Performance_monitoring_interrupts
    322.00 ±  8%     +12.8%     363.20 ±  7%  interrupts.CPU160.RES:Rescheduling_interrupts
      5433 ±  3%     +38.7%       7537 ±  9%  interrupts.CPU161.CAL:Function_call_interrupts
   1755353 ±  2%     -81.8%     318926 ± 17%  interrupts.CPU161.LOC:Local_timer_interrupts
      1190 ± 23%    +169.9%       3211 ± 16%  interrupts.CPU161.NMI:Non-maskable_interrupts
      1190 ± 23%    +169.9%       3211 ± 16%  interrupts.CPU161.PMI:Performance_monitoring_interrupts
      5382 ±  4%     +40.1%       7542 ±  8%  interrupts.CPU162.CAL:Function_call_interrupts
   1755176 ±  2%     -81.8%     318797 ± 17%  interrupts.CPU162.LOC:Local_timer_interrupts
      1081 ± 19%    +165.4%       2870 ± 16%  interrupts.CPU162.NMI:Non-maskable_interrupts
      1081 ± 19%    +165.4%       2870 ± 16%  interrupts.CPU162.PMI:Performance_monitoring_interrupts
    347.60 ±  8%     +13.0%     392.80 ±  7%  interrupts.CPU162.RES:Rescheduling_interrupts
      5455 ±  2%     +36.9%       7470 ±  7%  interrupts.CPU163.CAL:Function_call_interrupts
   1755226 ±  2%     -81.8%     318966 ± 17%  interrupts.CPU163.LOC:Local_timer_interrupts
      1201 ± 27%    +170.6%       3250 ± 18%  interrupts.CPU163.NMI:Non-maskable_interrupts
      1201 ± 27%    +170.6%       3250 ± 18%  interrupts.CPU163.PMI:Performance_monitoring_interrupts
      5456 ±  3%     +34.2%       7321 ±  7%  interrupts.CPU164.CAL:Function_call_interrupts
   1755343 ±  2%     -81.8%     318983 ± 17%  interrupts.CPU164.LOC:Local_timer_interrupts
      1172 ± 31%    +109.1%       2451 ± 26%  interrupts.CPU164.NMI:Non-maskable_interrupts
      1172 ± 31%    +109.1%       2451 ± 26%  interrupts.CPU164.PMI:Performance_monitoring_interrupts
      5371 ±  2%     +39.8%       7508 ±  7%  interrupts.CPU165.CAL:Function_call_interrupts
   1755240 ±  2%     -81.8%     318998 ± 17%  interrupts.CPU165.LOC:Local_timer_interrupts
      1335 ± 32%    +108.6%       2785 ± 14%  interrupts.CPU165.NMI:Non-maskable_interrupts
      1335 ± 32%    +108.6%       2785 ± 14%  interrupts.CPU165.PMI:Performance_monitoring_interrupts
    316.40 ±  4%     +24.1%     392.80 ±  3%  interrupts.CPU165.RES:Rescheduling_interrupts
      5410 ±  3%     +36.9%       7405 ±  8%  interrupts.CPU166.CAL:Function_call_interrupts
   1755293 ±  2%     -81.8%     319003 ± 17%  interrupts.CPU166.LOC:Local_timer_interrupts
      1108 ± 22%    +150.4%       2775 ± 13%  interrupts.CPU166.NMI:Non-maskable_interrupts
      1108 ± 22%    +150.4%       2775 ± 13%  interrupts.CPU166.PMI:Performance_monitoring_interrupts
    307.80           +22.3%     376.40 ±  3%  interrupts.CPU166.RES:Rescheduling_interrupts
      5351 ±  4%     +38.4%       7405 ±  6%  interrupts.CPU167.CAL:Function_call_interrupts
   1755251 ±  2%     -81.8%     318988 ± 17%  interrupts.CPU167.LOC:Local_timer_interrupts
      1205 ± 33%    +173.9%       3301 ± 20%  interrupts.CPU167.NMI:Non-maskable_interrupts
      1205 ± 33%    +173.9%       3301 ± 20%  interrupts.CPU167.PMI:Performance_monitoring_interrupts
      5512 ±  3%     +41.6%       7806 ±  8%  interrupts.CPU168.CAL:Function_call_interrupts
   1754827 ±  2%     -81.8%     318969 ± 17%  interrupts.CPU168.LOC:Local_timer_interrupts
      1409 ± 22%    +136.8%       3338 ± 15%  interrupts.CPU168.NMI:Non-maskable_interrupts
      1409 ± 22%    +136.8%       3338 ± 15%  interrupts.CPU168.PMI:Performance_monitoring_interrupts
    322.00 ± 10%     +25.5%     404.20 ±  6%  interrupts.CPU168.RES:Rescheduling_interrupts
      5075           +53.3%       7778 ±  7%  interrupts.CPU169.CAL:Function_call_interrupts
   1755305 ±  2%     -81.8%     318958 ± 17%  interrupts.CPU169.LOC:Local_timer_interrupts
      1475 ± 11%    +114.7%       3166 ± 17%  interrupts.CPU169.NMI:Non-maskable_interrupts
      1475 ± 11%    +114.7%       3166 ± 17%  interrupts.CPU169.PMI:Performance_monitoring_interrupts
    318.80 ±  4%     +27.8%     407.40 ± 10%  interrupts.CPU169.RES:Rescheduling_interrupts
      5381           +47.3%       7924 ±  8%  interrupts.CPU17.CAL:Function_call_interrupts
   1755306 ±  2%     -81.8%     319105 ± 17%  interrupts.CPU17.LOC:Local_timer_interrupts
    246.80 ±  4%     +62.1%     400.00 ± 12%  interrupts.CPU17.RES:Rescheduling_interrupts
      5418 ±  4%     +44.4%       7822 ±  9%  interrupts.CPU170.CAL:Function_call_interrupts
   1755203 ±  2%     -81.8%     319064 ± 17%  interrupts.CPU170.LOC:Local_timer_interrupts
      1434 ±  4%    +126.5%       3248 ± 17%  interrupts.CPU170.NMI:Non-maskable_interrupts
      1434 ±  4%    +126.5%       3248 ± 17%  interrupts.CPU170.PMI:Performance_monitoring_interrupts
    316.20 ±  5%     +22.7%     388.00 ±  7%  interrupts.CPU170.RES:Rescheduling_interrupts
      5349 ±  2%     +45.2%       7768 ±  8%  interrupts.CPU171.CAL:Function_call_interrupts
   1755067 ±  2%     -81.8%     319004 ± 17%  interrupts.CPU171.LOC:Local_timer_interrupts
      1549 ±  9%     +79.9%       2787 ± 11%  interrupts.CPU171.NMI:Non-maskable_interrupts
      1549 ±  9%     +79.9%       2787 ± 11%  interrupts.CPU171.PMI:Performance_monitoring_interrupts
      5311 ±  3%     +47.2%       7820 ±  6%  interrupts.CPU172.CAL:Function_call_interrupts
   1755174 ±  2%     -81.8%     318984 ± 17%  interrupts.CPU172.LOC:Local_timer_interrupts
      1266 ± 25%    +160.5%       3298 ± 16%  interrupts.CPU172.NMI:Non-maskable_interrupts
      1266 ± 25%    +160.5%       3298 ± 16%  interrupts.CPU172.PMI:Performance_monitoring_interrupts
    317.00 ±  5%     +18.0%     374.00 ±  7%  interrupts.CPU172.RES:Rescheduling_interrupts
      5184 ±  5%     +50.2%       7788 ±  8%  interrupts.CPU173.CAL:Function_call_interrupts
   1755087 ±  2%     -81.8%     318960 ± 17%  interrupts.CPU173.LOC:Local_timer_interrupts
      1272 ± 26%    +156.5%       3264 ± 15%  interrupts.CPU173.NMI:Non-maskable_interrupts
      1272 ± 26%    +156.5%       3264 ± 15%  interrupts.CPU173.PMI:Performance_monitoring_interrupts
    306.40 ±  5%     +20.0%     367.60 ±  7%  interrupts.CPU173.RES:Rescheduling_interrupts
      5356 ±  4%     +43.2%       7671 ±  6%  interrupts.CPU174.CAL:Function_call_interrupts
   1755171 ±  2%     -81.8%     318984 ± 17%  interrupts.CPU174.LOC:Local_timer_interrupts
      1365 ± 21%    +144.8%       3343 ± 18%  interrupts.CPU174.NMI:Non-maskable_interrupts
      1365 ± 21%    +144.8%       3343 ± 18%  interrupts.CPU174.PMI:Performance_monitoring_interrupts
      5299           +50.3%       7963 ±  8%  interrupts.CPU175.CAL:Function_call_interrupts
   1755173 ±  2%     -81.8%     318930 ± 17%  interrupts.CPU175.LOC:Local_timer_interrupts
      1292 ± 37%    +143.9%       3153 ± 17%  interrupts.CPU175.NMI:Non-maskable_interrupts
      1292 ± 37%    +143.9%       3153 ± 17%  interrupts.CPU175.PMI:Performance_monitoring_interrupts
    295.20 ±  5%     +40.9%     416.00 ± 11%  interrupts.CPU175.RES:Rescheduling_interrupts
      5396 ±  2%     +49.7%       8081 ±  8%  interrupts.CPU176.CAL:Function_call_interrupts
   1755130 ±  2%     -81.8%     318961 ± 17%  interrupts.CPU176.LOC:Local_timer_interrupts
      1266 ± 20%    +117.1%       2749 ± 12%  interrupts.CPU176.NMI:Non-maskable_interrupts
      1266 ± 20%    +117.1%       2749 ± 12%  interrupts.CPU176.PMI:Performance_monitoring_interrupts
    308.60 ±  2%     +32.2%     408.00 ±  8%  interrupts.CPU176.RES:Rescheduling_interrupts
      5351 ±  4%     +44.7%       7744 ±  9%  interrupts.CPU177.CAL:Function_call_interrupts
   1754992 ±  2%     -81.8%     318959 ± 17%  interrupts.CPU177.LOC:Local_timer_interrupts
      1465 ± 28%    +120.5%       3231 ± 19%  interrupts.CPU177.NMI:Non-maskable_interrupts
      1465 ± 28%    +120.5%       3231 ± 19%  interrupts.CPU177.PMI:Performance_monitoring_interrupts
      5326 ±  3%     +45.4%       7744 ±  6%  interrupts.CPU178.CAL:Function_call_interrupts
   1755214 ±  2%     -81.8%     318942 ± 17%  interrupts.CPU178.LOC:Local_timer_interrupts
      1266 ± 21%    +158.9%       3278 ± 17%  interrupts.CPU178.NMI:Non-maskable_interrupts
      1266 ± 21%    +158.9%       3278 ± 17%  interrupts.CPU178.PMI:Performance_monitoring_interrupts
    319.40 ±  6%     +20.9%     386.20 ± 12%  interrupts.CPU178.RES:Rescheduling_interrupts
      5317 ±  2%     +47.6%       7850 ±  8%  interrupts.CPU179.CAL:Function_call_interrupts
   1755141 ±  2%     -81.8%     318949 ± 17%  interrupts.CPU179.LOC:Local_timer_interrupts
      1385 ± 29%    +129.1%       3175 ± 17%  interrupts.CPU179.NMI:Non-maskable_interrupts
      1385 ± 29%    +129.1%       3175 ± 17%  interrupts.CPU179.PMI:Performance_monitoring_interrupts
    308.60 ±  9%     +22.0%     376.40 ±  8%  interrupts.CPU179.RES:Rescheduling_interrupts
      5340 ±  3%     +50.5%       8039 ± 13%  interrupts.CPU18.CAL:Function_call_interrupts
   1755420 ±  2%     -81.8%     319066 ± 17%  interrupts.CPU18.LOC:Local_timer_interrupts
      1393 ± 13%    +134.9%       3272 ± 17%  interrupts.CPU18.NMI:Non-maskable_interrupts
      1393 ± 13%    +134.9%       3272 ± 17%  interrupts.CPU18.PMI:Performance_monitoring_interrupts
    255.60 ± 15%     +60.0%     409.00 ±  4%  interrupts.CPU18.RES:Rescheduling_interrupts
      5384 ±  3%     +45.9%       7855 ±  8%  interrupts.CPU180.CAL:Function_call_interrupts
   1755077 ±  2%     -81.8%     318950 ± 17%  interrupts.CPU180.LOC:Local_timer_interrupts
    294.40           +37.6%     405.00 ± 13%  interrupts.CPU180.RES:Rescheduling_interrupts
      5451 ±  5%     +43.8%       7840 ±  7%  interrupts.CPU181.CAL:Function_call_interrupts
   1754398 ±  2%     -81.8%     318936 ± 17%  interrupts.CPU181.LOC:Local_timer_interrupts
      1373 ± 25%    +103.6%       2796 ± 13%  interrupts.CPU181.NMI:Non-maskable_interrupts
      1373 ± 25%    +103.6%       2796 ± 13%  interrupts.CPU181.PMI:Performance_monitoring_interrupts
      5292 ±  4%     +47.5%       7804 ± 10%  interrupts.CPU182.CAL:Function_call_interrupts
   1754726 ±  2%     -81.8%     318926 ± 17%  interrupts.CPU182.LOC:Local_timer_interrupts
      1551 ± 38%    +112.8%       3300 ± 18%  interrupts.CPU182.NMI:Non-maskable_interrupts
      1551 ± 38%    +112.8%       3300 ± 18%  interrupts.CPU182.PMI:Performance_monitoring_interrupts
    294.20 ±  7%     +34.3%     395.20 ±  8%  interrupts.CPU182.RES:Rescheduling_interrupts
      5509 ±  3%     +42.5%       7853 ±  7%  interrupts.CPU183.CAL:Function_call_interrupts
   1754745 ±  2%     -81.8%     318944 ± 17%  interrupts.CPU183.LOC:Local_timer_interrupts
      1391 ± 24%    +107.8%       2892 ± 14%  interrupts.CPU183.NMI:Non-maskable_interrupts
      1391 ± 24%    +107.8%       2892 ± 14%  interrupts.CPU183.PMI:Performance_monitoring_interrupts
      5429 ±  5%     +45.3%       7891 ±  8%  interrupts.CPU184.CAL:Function_call_interrupts
   1754691 ±  2%     -81.8%     318948 ± 17%  interrupts.CPU184.LOC:Local_timer_interrupts
      1214 ± 23%    +171.2%       3294 ± 15%  interrupts.CPU184.NMI:Non-maskable_interrupts
      1214 ± 23%    +171.2%       3294 ± 15%  interrupts.CPU184.PMI:Performance_monitoring_interrupts
      5456 ±  3%     +43.8%       7843 ± 10%  interrupts.CPU185.CAL:Function_call_interrupts
   1754741 ±  2%     -81.8%     318915 ± 17%  interrupts.CPU185.LOC:Local_timer_interrupts
      1293 ± 24%    +117.6%       2814 ± 12%  interrupts.CPU185.NMI:Non-maskable_interrupts
      1293 ± 24%    +117.6%       2814 ± 12%  interrupts.CPU185.PMI:Performance_monitoring_interrupts
    297.20 ±  6%     +33.4%     396.40 ± 12%  interrupts.CPU185.RES:Rescheduling_interrupts
      5407 ±  3%     +45.7%       7878 ±  9%  interrupts.CPU186.CAL:Function_call_interrupts
   1754652 ±  2%     -81.8%     318948 ± 17%  interrupts.CPU186.LOC:Local_timer_interrupts
      1340 ± 22%    +143.4%       3262 ± 16%  interrupts.CPU186.NMI:Non-maskable_interrupts
      1340 ± 22%    +143.4%       3262 ± 16%  interrupts.CPU186.PMI:Performance_monitoring_interrupts
    294.80 ±  7%     +29.5%     381.80 ±  8%  interrupts.CPU186.RES:Rescheduling_interrupts
      5465 ±  4%     +46.9%       8027 ±  8%  interrupts.CPU187.CAL:Function_call_interrupts
   1754637 ±  2%     -81.8%     318876 ± 17%  interrupts.CPU187.LOC:Local_timer_interrupts
      5358 ±  2%     +44.5%       7741 ±  8%  interrupts.CPU188.CAL:Function_call_interrupts
   1754846 ±  2%     -81.8%     318936 ± 17%  interrupts.CPU188.LOC:Local_timer_interrupts
      1351 ±  7%    +113.6%       2885 ± 30%  interrupts.CPU188.NMI:Non-maskable_interrupts
      1351 ±  7%    +113.6%       2885 ± 30%  interrupts.CPU188.PMI:Performance_monitoring_interrupts
    289.20 ±  7%     +31.3%     379.80 ± 10%  interrupts.CPU188.RES:Rescheduling_interrupts
      5331 ±  2%     +46.5%       7812 ±  9%  interrupts.CPU189.CAL:Function_call_interrupts
   1754572 ±  2%     -81.8%     318925 ± 17%  interrupts.CPU189.LOC:Local_timer_interrupts
    293.60 ±  4%     +24.6%     365.80 ±  8%  interrupts.CPU189.RES:Rescheduling_interrupts
      5442           +45.4%       7913 ± 10%  interrupts.CPU19.CAL:Function_call_interrupts
   1755397 ±  2%     -81.8%     319061 ± 17%  interrupts.CPU19.LOC:Local_timer_interrupts
      1432 ±  7%    +124.8%       3221 ± 15%  interrupts.CPU19.NMI:Non-maskable_interrupts
      1432 ±  7%    +124.8%       3221 ± 15%  interrupts.CPU19.PMI:Performance_monitoring_interrupts
    249.20 ±  9%     +57.2%     391.80 ±  8%  interrupts.CPU19.RES:Rescheduling_interrupts
      5320 ±  2%     +48.3%       7888 ± 12%  interrupts.CPU190.CAL:Function_call_interrupts
   1755171 ±  2%     -81.8%     318921 ± 17%  interrupts.CPU190.LOC:Local_timer_interrupts
    271.80 ±  6%     +43.9%     391.00 ±  9%  interrupts.CPU190.RES:Rescheduling_interrupts
      5248 ±  4%     +43.3%       7523 ±  7%  interrupts.CPU191.CAL:Function_call_interrupts
   1755025 ±  2%     -81.8%     318973 ± 17%  interrupts.CPU191.LOC:Local_timer_interrupts
      1383 ± 16%    +110.0%       2905 ± 27%  interrupts.CPU191.NMI:Non-maskable_interrupts
      1383 ± 16%    +110.0%       2905 ± 27%  interrupts.CPU191.PMI:Performance_monitoring_interrupts
    280.60 ± 10%     +35.4%     380.00 ± 11%  interrupts.CPU191.RES:Rescheduling_interrupts
    160.20 ±128%     -82.0%      28.80 ± 20%  interrupts.CPU191.TLB:TLB_shootdowns
      5623 ±  3%     +40.6%       7908 ± 11%  interrupts.CPU2.CAL:Function_call_interrupts
   1754982 ±  2%     -81.8%     319004 ± 17%  interrupts.CPU2.LOC:Local_timer_interrupts
      1317 ± 29%    +141.3%       3178 ± 19%  interrupts.CPU2.NMI:Non-maskable_interrupts
      1317 ± 29%    +141.3%       3178 ± 19%  interrupts.CPU2.PMI:Performance_monitoring_interrupts
    273.40 ±  4%     +47.8%     404.00 ±  4%  interrupts.CPU2.RES:Rescheduling_interrupts
      5305           +43.1%       7593 ±  9%  interrupts.CPU20.CAL:Function_call_interrupts
   1755276 ±  2%     -81.8%     319057 ± 17%  interrupts.CPU20.LOC:Local_timer_interrupts
      1346 ± 22%    +122.6%       2997 ± 32%  interrupts.CPU20.NMI:Non-maskable_interrupts
      1346 ± 22%    +122.6%       2997 ± 32%  interrupts.CPU20.PMI:Performance_monitoring_interrupts
    257.20 ±  5%     +55.1%     399.00 ±  4%  interrupts.CPU20.RES:Rescheduling_interrupts
      5435 ±  3%     +38.0%       7500 ± 10%  interrupts.CPU21.CAL:Function_call_interrupts
   1755266 ±  2%     -81.8%     319059 ± 17%  interrupts.CPU21.LOC:Local_timer_interrupts
      5271 ±  2%     +45.7%       7683 ± 10%  interrupts.CPU22.CAL:Function_call_interrupts
   1755381 ±  2%     -81.8%     319068 ± 17%  interrupts.CPU22.LOC:Local_timer_interrupts
    268.80 ± 15%     +54.2%     414.60 ±  5%  interrupts.CPU22.RES:Rescheduling_interrupts
      5265 ±  2%     +43.9%       7577 ±  9%  interrupts.CPU23.CAL:Function_call_interrupts
   1755123 ±  2%     -81.8%     319038 ± 17%  interrupts.CPU23.LOC:Local_timer_interrupts
    281.20 ± 16%     +33.9%     376.60 ±  3%  interrupts.CPU23.RES:Rescheduling_interrupts
      5676 ±  4%     +33.8%       7591 ±  9%  interrupts.CPU24.CAL:Function_call_interrupts
   1755000 ±  2%     -81.8%     319038 ± 17%  interrupts.CPU24.LOC:Local_timer_interrupts
    256.80 ±  5%     -53.3%     119.80 ± 24%  interrupts.CPU24.TLB:TLB_shootdowns
      5851 ±  5%     +32.4%       7746 ±  8%  interrupts.CPU25.CAL:Function_call_interrupts
   1755106 ±  2%     -81.8%     319066 ± 17%  interrupts.CPU25.LOC:Local_timer_interrupts
      1437 ± 20%    +132.0%       3333 ± 16%  interrupts.CPU25.NMI:Non-maskable_interrupts
      1437 ± 20%    +132.0%       3333 ± 16%  interrupts.CPU25.PMI:Performance_monitoring_interrupts
      5591 ±  4%     +34.8%       7538 ±  8%  interrupts.CPU26.CAL:Function_call_interrupts
   1755186 ±  2%     -81.8%     319039 ± 17%  interrupts.CPU26.LOC:Local_timer_interrupts
      1288 ± 28%    +152.4%       3252 ± 16%  interrupts.CPU26.NMI:Non-maskable_interrupts
      1288 ± 28%    +152.4%       3252 ± 16%  interrupts.CPU26.PMI:Performance_monitoring_interrupts
      5465 ±  3%     +39.7%       7635 ±  9%  interrupts.CPU27.CAL:Function_call_interrupts
   1755194 ±  2%     -81.8%     319075 ± 17%  interrupts.CPU27.LOC:Local_timer_interrupts
      1440 ± 27%    +122.4%       3202 ± 17%  interrupts.CPU27.NMI:Non-maskable_interrupts
      1440 ± 27%    +122.4%       3202 ± 17%  interrupts.CPU27.PMI:Performance_monitoring_interrupts
    290.60 ±  4%     +29.0%     374.80 ±  9%  interrupts.CPU27.RES:Rescheduling_interrupts
      5600 ±  3%     +36.9%       7668 ±  8%  interrupts.CPU28.CAL:Function_call_interrupts
   1755121 ±  2%     -81.8%     319059 ± 17%  interrupts.CPU28.LOC:Local_timer_interrupts
      1269 ± 26%    +160.7%       3309 ± 20%  interrupts.CPU28.NMI:Non-maskable_interrupts
      1269 ± 26%    +160.7%       3309 ± 20%  interrupts.CPU28.PMI:Performance_monitoring_interrupts
    295.20 ±  5%     +27.8%     377.20 ±  4%  interrupts.CPU28.RES:Rescheduling_interrupts
      5660 ±  4%     +34.1%       7589 ±  7%  interrupts.CPU29.CAL:Function_call_interrupts
   1755232 ±  2%     -81.8%     318939 ± 17%  interrupts.CPU29.LOC:Local_timer_interrupts
      1231 ± 27%    +107.2%       2552 ± 21%  interrupts.CPU29.NMI:Non-maskable_interrupts
      1231 ± 27%    +107.2%       2552 ± 21%  interrupts.CPU29.PMI:Performance_monitoring_interrupts
      5671 ±  4%     +45.7%       8261 ± 11%  interrupts.CPU3.CAL:Function_call_interrupts
   1754838 ±  2%     -81.8%     318900 ± 17%  interrupts.CPU3.LOC:Local_timer_interrupts
      1282 ± 28%    +118.3%       2798 ± 11%  interrupts.CPU3.NMI:Non-maskable_interrupts
      1282 ± 28%    +118.3%       2798 ± 11%  interrupts.CPU3.PMI:Performance_monitoring_interrupts
    258.00 ±  6%     +47.5%     380.60 ±  6%  interrupts.CPU3.RES:Rescheduling_interrupts
      5469 ±  2%     +43.2%       7829 ±  7%  interrupts.CPU30.CAL:Function_call_interrupts
   1755078 ±  2%     -81.8%     319030 ± 17%  interrupts.CPU30.LOC:Local_timer_interrupts
      1552 ±  6%    +110.7%       3271 ± 15%  interrupts.CPU30.NMI:Non-maskable_interrupts
      1552 ±  6%    +110.7%       3271 ± 15%  interrupts.CPU30.PMI:Performance_monitoring_interrupts
      5505 ±  4%     +38.7%       7636 ±  7%  interrupts.CPU31.CAL:Function_call_interrupts
   1755239 ±  2%     -81.8%     319028 ± 17%  interrupts.CPU31.LOC:Local_timer_interrupts
      1252 ± 32%    +157.9%       3229 ± 16%  interrupts.CPU31.NMI:Non-maskable_interrupts
      1252 ± 32%    +157.9%       3229 ± 16%  interrupts.CPU31.PMI:Performance_monitoring_interrupts
    320.80 ±  6%     +19.3%     382.80 ±  7%  interrupts.CPU31.RES:Rescheduling_interrupts
      5425 ±  3%     +41.0%       7647 ±  7%  interrupts.CPU32.CAL:Function_call_interrupts
   1755153 ±  2%     -81.8%     319056 ± 17%  interrupts.CPU32.LOC:Local_timer_interrupts
      1341 ± 22%    +141.5%       3240 ± 16%  interrupts.CPU32.NMI:Non-maskable_interrupts
      1341 ± 22%    +141.5%       3240 ± 16%  interrupts.CPU32.PMI:Performance_monitoring_interrupts
    304.20 ±  3%     +28.7%     391.60 ±  3%  interrupts.CPU32.RES:Rescheduling_interrupts
      5541 ±  2%     +36.4%       7556 ±  6%  interrupts.CPU33.CAL:Function_call_interrupts
   1755148 ±  2%     -81.8%     319050 ± 17%  interrupts.CPU33.LOC:Local_timer_interrupts
      1279 ± 27%    +156.9%       3285 ± 16%  interrupts.CPU33.NMI:Non-maskable_interrupts
      1279 ± 27%    +156.9%       3285 ± 16%  interrupts.CPU33.PMI:Performance_monitoring_interrupts
    317.40 ±  5%     +20.9%     383.80 ± 12%  interrupts.CPU33.RES:Rescheduling_interrupts
      5494 ±  2%     +36.2%       7482 ±  8%  interrupts.CPU34.CAL:Function_call_interrupts
   1755171 ±  2%     -81.8%     319043 ± 17%  interrupts.CPU34.LOC:Local_timer_interrupts
      1427 ± 17%     +76.1%       2512 ± 27%  interrupts.CPU34.NMI:Non-maskable_interrupts
      1427 ± 17%     +76.1%       2512 ± 27%  interrupts.CPU34.PMI:Performance_monitoring_interrupts
    336.40 ±  6%     +25.1%     420.80 ± 13%  interrupts.CPU34.RES:Rescheduling_interrupts
      5412           +43.7%       7778 ±  8%  interrupts.CPU35.CAL:Function_call_interrupts
   1755214 ±  2%     -81.8%     319053 ± 17%  interrupts.CPU35.LOC:Local_timer_interrupts
      1528 ± 19%    +108.0%       3178 ± 16%  interrupts.CPU35.NMI:Non-maskable_interrupts
      1528 ± 19%    +108.0%       3178 ± 16%  interrupts.CPU35.PMI:Performance_monitoring_interrupts
    322.20 ±  3%     +18.7%     382.60 ±  7%  interrupts.CPU35.RES:Rescheduling_interrupts
     62.80 ± 93%     -84.1%      10.00 ± 68%  interrupts.CPU35.TLB:TLB_shootdowns
      5415 ±  2%     +38.5%       7498 ±  4%  interrupts.CPU36.CAL:Function_call_interrupts
   1755116 ±  2%     -81.8%     319056 ± 17%  interrupts.CPU36.LOC:Local_timer_interrupts
      1353 ± 24%    +116.2%       2925 ± 28%  interrupts.CPU36.NMI:Non-maskable_interrupts
      1353 ± 24%    +116.2%       2925 ± 28%  interrupts.CPU36.PMI:Performance_monitoring_interrupts
      5482 ±  2%     +40.9%       7727 ±  9%  interrupts.CPU37.CAL:Function_call_interrupts
   1755202 ±  2%     -81.8%     319041 ± 17%  interrupts.CPU37.LOC:Local_timer_interrupts
      5547 ±  2%     +36.5%       7572 ±  8%  interrupts.CPU38.CAL:Function_call_interrupts
   1755108 ±  2%     -81.8%     319013 ± 17%  interrupts.CPU38.LOC:Local_timer_interrupts
      1423 ± 27%    +107.7%       2957 ± 30%  interrupts.CPU38.NMI:Non-maskable_interrupts
      1423 ± 27%    +107.7%       2957 ± 30%  interrupts.CPU38.PMI:Performance_monitoring_interrupts
      5439 ±  2%     +38.0%       7505 ±  8%  interrupts.CPU39.CAL:Function_call_interrupts
   1755126 ±  2%     -81.8%     318908 ± 17%  interrupts.CPU39.LOC:Local_timer_interrupts
      1244 ± 31%    +128.4%       2843 ± 31%  interrupts.CPU39.NMI:Non-maskable_interrupts
      1244 ± 31%    +128.4%       2843 ± 31%  interrupts.CPU39.PMI:Performance_monitoring_interrupts
      5576 ±  7%     +43.6%       8005 ± 13%  interrupts.CPU4.CAL:Function_call_interrupts
   1754892 ±  2%     -81.8%     319027 ± 17%  interrupts.CPU4.LOC:Local_timer_interrupts
    280.60 ± 16%     +41.1%     395.80 ±  7%  interrupts.CPU4.RES:Rescheduling_interrupts
      5453 ±  2%     +39.8%       7622 ±  9%  interrupts.CPU40.CAL:Function_call_interrupts
   1755167 ±  2%     -81.8%     318970 ± 17%  interrupts.CPU40.LOC:Local_timer_interrupts
      1211 ± 30%    +141.2%       2921 ± 34%  interrupts.CPU40.NMI:Non-maskable_interrupts
      1211 ± 30%    +141.2%       2921 ± 34%  interrupts.CPU40.PMI:Performance_monitoring_interrupts
    340.40 ±  5%     +16.0%     394.80 ±  8%  interrupts.CPU40.RES:Rescheduling_interrupts
      5460 ±  3%     +36.2%       7437 ±  8%  interrupts.CPU41.CAL:Function_call_interrupts
   1755014 ±  2%     -81.8%     319046 ± 17%  interrupts.CPU41.LOC:Local_timer_interrupts
      1011 ± 36%    +159.2%       2622 ± 39%  interrupts.CPU41.NMI:Non-maskable_interrupts
      1011 ± 36%    +159.2%       2622 ± 39%  interrupts.CPU41.PMI:Performance_monitoring_interrupts
      5442 ±  3%     +37.9%       7502 ±  7%  interrupts.CPU42.CAL:Function_call_interrupts
   1755085 ±  2%     -81.8%     319064 ± 17%  interrupts.CPU42.LOC:Local_timer_interrupts
      5437           +39.7%       7596 ±  5%  interrupts.CPU43.CAL:Function_call_interrupts
   1755140 ±  2%     -81.8%     319016 ± 17%  interrupts.CPU43.LOC:Local_timer_interrupts
      1176 ± 29%    +118.5%       2571 ± 39%  interrupts.CPU43.NMI:Non-maskable_interrupts
      1176 ± 29%    +118.5%       2571 ± 39%  interrupts.CPU43.PMI:Performance_monitoring_interrupts
      5394 ±  2%     +43.6%       7745 ±  7%  interrupts.CPU44.CAL:Function_call_interrupts
   1755187 ±  2%     -81.8%     319040 ± 17%  interrupts.CPU44.LOC:Local_timer_interrupts
      1163 ± 29%    +183.1%       3294 ± 15%  interrupts.CPU44.NMI:Non-maskable_interrupts
      1163 ± 29%    +183.1%       3294 ± 15%  interrupts.CPU44.PMI:Performance_monitoring_interrupts
      5352           +39.2%       7452 ±  7%  interrupts.CPU45.CAL:Function_call_interrupts
   1755140 ±  2%     -81.8%     319049 ± 17%  interrupts.CPU45.LOC:Local_timer_interrupts
      1170 ± 27%    +173.9%       3204 ± 17%  interrupts.CPU45.NMI:Non-maskable_interrupts
      1170 ± 27%    +173.9%       3204 ± 17%  interrupts.CPU45.PMI:Performance_monitoring_interrupts
      5414 ±  5%     +42.5%       7718 ±  6%  interrupts.CPU46.CAL:Function_call_interrupts
   1755217 ±  2%     -81.8%     319055 ± 17%  interrupts.CPU46.LOC:Local_timer_interrupts
    993.40 ± 28%    +153.9%       2522 ± 28%  interrupts.CPU46.NMI:Non-maskable_interrupts
    993.40 ± 28%    +153.9%       2522 ± 28%  interrupts.CPU46.PMI:Performance_monitoring_interrupts
      5403 ±  2%     +37.6%       7435 ±  5%  interrupts.CPU47.CAL:Function_call_interrupts
   1755150 ±  2%     -81.8%     319054 ± 17%  interrupts.CPU47.LOC:Local_timer_interrupts
      1210 ± 31%    +121.5%       2681 ± 42%  interrupts.CPU47.NMI:Non-maskable_interrupts
      1210 ± 31%    +121.5%       2681 ± 42%  interrupts.CPU47.PMI:Performance_monitoring_interrupts
      5708 ±  3%     +31.9%       7529 ±  7%  interrupts.CPU48.CAL:Function_call_interrupts
   1755251 ±  2%     -81.8%     319078 ± 17%  interrupts.CPU48.LOC:Local_timer_interrupts
      1316 ± 18%    +128.0%       3002 ± 31%  interrupts.CPU48.NMI:Non-maskable_interrupts
      1316 ± 18%    +128.0%       3002 ± 31%  interrupts.CPU48.PMI:Performance_monitoring_interrupts
    271.40 ± 13%     -53.1%     127.20 ± 19%  interrupts.CPU48.TLB:TLB_shootdowns
      5593 ±  3%     +34.1%       7500 ±  7%  interrupts.CPU49.CAL:Function_call_interrupts
   1755189 ±  2%     -81.8%     319034 ± 17%  interrupts.CPU49.LOC:Local_timer_interrupts
      1352 ± 23%    +135.2%       3180 ± 19%  interrupts.CPU49.NMI:Non-maskable_interrupts
      1352 ± 23%    +135.2%       3180 ± 19%  interrupts.CPU49.PMI:Performance_monitoring_interrupts
    101.20 ± 47%     -67.0%      33.40 ± 23%  interrupts.CPU49.TLB:TLB_shootdowns
      5504 ±  7%     +43.4%       7892 ± 12%  interrupts.CPU5.CAL:Function_call_interrupts
   1755095 ±  2%     -81.8%     319069 ± 17%  interrupts.CPU5.LOC:Local_timer_interrupts
      1395 ± 28%     +98.6%       2772 ± 13%  interrupts.CPU5.NMI:Non-maskable_interrupts
      1395 ± 28%     +98.6%       2772 ± 13%  interrupts.CPU5.PMI:Performance_monitoring_interrupts
    253.60 ± 10%     +46.9%     372.60 ±  4%  interrupts.CPU5.RES:Rescheduling_interrupts
      5549 ±  3%     +34.1%       7442 ±  7%  interrupts.CPU50.CAL:Function_call_interrupts
   1755394 ±  2%     -81.8%     319040 ± 17%  interrupts.CPU50.LOC:Local_timer_interrupts
      1122 ± 36%    +192.4%       3282 ± 15%  interrupts.CPU50.NMI:Non-maskable_interrupts
      1122 ± 36%    +192.4%       3282 ± 15%  interrupts.CPU50.PMI:Performance_monitoring_interrupts
      5503 ±  2%     +32.5%       7294 ±  6%  interrupts.CPU51.CAL:Function_call_interrupts
   1755384 ±  2%     -81.8%     319047 ± 17%  interrupts.CPU51.LOC:Local_timer_interrupts
      1066 ± 31%    +171.0%       2890 ± 13%  interrupts.CPU51.NMI:Non-maskable_interrupts
      1066 ± 31%    +171.0%       2890 ± 13%  interrupts.CPU51.PMI:Performance_monitoring_interrupts
      5676 ±  5%     +31.4%       7460 ±  7%  interrupts.CPU52.CAL:Function_call_interrupts
   1755432 ±  2%     -81.8%     319051 ± 17%  interrupts.CPU52.LOC:Local_timer_interrupts
      1175 ± 27%    +149.3%       2930 ± 13%  interrupts.CPU52.NMI:Non-maskable_interrupts
      1175 ± 27%    +149.3%       2930 ± 13%  interrupts.CPU52.PMI:Performance_monitoring_interrupts
      5508 ±  3%     +34.5%       7408 ±  5%  interrupts.CPU53.CAL:Function_call_interrupts
   1755391 ±  2%     -81.8%     318971 ± 17%  interrupts.CPU53.LOC:Local_timer_interrupts
      1038 ± 30%    +175.9%       2864 ± 15%  interrupts.CPU53.NMI:Non-maskable_interrupts
      1038 ± 30%    +175.9%       2864 ± 15%  interrupts.CPU53.PMI:Performance_monitoring_interrupts
      5380           +38.9%       7473 ±  8%  interrupts.CPU54.CAL:Function_call_interrupts
   1754785 ±  2%     -81.8%     319030 ± 17%  interrupts.CPU54.LOC:Local_timer_interrupts
      1216 ± 30%    +164.3%       3215 ± 19%  interrupts.CPU54.NMI:Non-maskable_interrupts
      1216 ± 30%    +164.3%       3215 ± 19%  interrupts.CPU54.PMI:Performance_monitoring_interrupts
      5499 ±  3%     +35.3%       7439 ±  8%  interrupts.CPU55.CAL:Function_call_interrupts
   1755427 ±  2%     -81.8%     319050 ± 17%  interrupts.CPU55.LOC:Local_timer_interrupts
      1054 ± 32%    +197.3%       3135 ± 18%  interrupts.CPU55.NMI:Non-maskable_interrupts
      1054 ± 32%    +197.3%       3135 ± 18%  interrupts.CPU55.PMI:Performance_monitoring_interrupts
      5454 ±  2%     +35.0%       7362 ±  7%  interrupts.CPU56.CAL:Function_call_interrupts
   1754845 ±  2%     -81.8%     319054 ± 17%  interrupts.CPU56.LOC:Local_timer_interrupts
      1465 ± 29%    +116.7%       3175 ± 17%  interrupts.CPU56.NMI:Non-maskable_interrupts
      1465 ± 29%    +116.7%       3175 ± 17%  interrupts.CPU56.PMI:Performance_monitoring_interrupts
      5426           +36.7%       7416 ±  7%  interrupts.CPU57.CAL:Function_call_interrupts
   1755351 ±  2%     -81.8%     318923 ± 17%  interrupts.CPU57.LOC:Local_timer_interrupts
      1422 ± 29%    +132.9%       3312 ± 18%  interrupts.CPU57.NMI:Non-maskable_interrupts
      1422 ± 29%    +132.9%       3312 ± 18%  interrupts.CPU57.PMI:Performance_monitoring_interrupts
      5398           +36.2%       7351 ±  6%  interrupts.CPU58.CAL:Function_call_interrupts
   1755357 ±  2%     -81.8%     319045 ± 17%  interrupts.CPU58.LOC:Local_timer_interrupts
      1453 ± 34%    +122.4%       3231 ± 12%  interrupts.CPU58.NMI:Non-maskable_interrupts
      1453 ± 34%    +122.4%       3231 ± 12%  interrupts.CPU58.PMI:Performance_monitoring_interrupts
      5464           +36.5%       7456 ±  6%  interrupts.CPU59.CAL:Function_call_interrupts
   1755429 ±  2%     -81.8%     319040 ± 17%  interrupts.CPU59.LOC:Local_timer_interrupts
      1471 ± 29%    +122.9%       3280 ± 18%  interrupts.CPU59.NMI:Non-maskable_interrupts
      1471 ± 29%    +122.9%       3280 ± 18%  interrupts.CPU59.PMI:Performance_monitoring_interrupts
      5467 ±  6%     +41.7%       7746 ±  8%  interrupts.CPU6.CAL:Function_call_interrupts
   1754764 ±  2%     -81.8%     318979 ± 17%  interrupts.CPU6.LOC:Local_timer_interrupts
      1548 ±  5%    +105.4%       3179 ± 17%  interrupts.CPU6.NMI:Non-maskable_interrupts
      1548 ±  5%    +105.4%       3179 ± 17%  interrupts.CPU6.PMI:Performance_monitoring_interrupts
    265.20 ± 14%     +49.2%     395.80 ±  4%  interrupts.CPU6.RES:Rescheduling_interrupts
      5446           +32.7%       7229 ±  6%  interrupts.CPU60.CAL:Function_call_interrupts
   1755386 ±  2%     -81.8%     319013 ± 17%  interrupts.CPU60.LOC:Local_timer_interrupts
      1417 ± 15%    +124.3%       3179 ± 19%  interrupts.CPU60.NMI:Non-maskable_interrupts
      1417 ± 15%    +124.3%       3179 ± 19%  interrupts.CPU60.PMI:Performance_monitoring_interrupts
      5418 ±  2%     +34.6%       7293 ±  9%  interrupts.CPU61.CAL:Function_call_interrupts
   1755355 ±  2%     -81.8%     319033 ± 17%  interrupts.CPU61.LOC:Local_timer_interrupts
      1300 ±  3%    +120.9%       2871 ± 14%  interrupts.CPU61.NMI:Non-maskable_interrupts
      1300 ±  3%    +120.9%       2871 ± 14%  interrupts.CPU61.PMI:Performance_monitoring_interrupts
      5456 ±  2%     +37.7%       7513 ±  9%  interrupts.CPU62.CAL:Function_call_interrupts
   1755397 ±  2%     -81.8%     319027 ± 17%  interrupts.CPU62.LOC:Local_timer_interrupts
      1413 ± 14%    +133.2%       3296 ± 13%  interrupts.CPU62.NMI:Non-maskable_interrupts
      1413 ± 14%    +133.2%       3296 ± 13%  interrupts.CPU62.PMI:Performance_monitoring_interrupts
      5451 ±  5%     +35.7%       7399 ±  8%  interrupts.CPU63.CAL:Function_call_interrupts
   1754923 ±  2%     -81.8%     319040 ± 17%  interrupts.CPU63.LOC:Local_timer_interrupts
      1252 ± 18%    +161.0%       3269 ± 20%  interrupts.CPU63.NMI:Non-maskable_interrupts
      1252 ± 18%    +161.0%       3269 ± 20%  interrupts.CPU63.PMI:Performance_monitoring_interrupts
      5365           +38.1%       7409 ±  7%  interrupts.CPU64.CAL:Function_call_interrupts
   1755316 ±  2%     -81.8%     319037 ± 17%  interrupts.CPU64.LOC:Local_timer_interrupts
      1393 ±  8%    +100.6%       2795 ± 13%  interrupts.CPU64.NMI:Non-maskable_interrupts
      1393 ±  8%    +100.6%       2795 ± 13%  interrupts.CPU64.PMI:Performance_monitoring_interrupts
      5478 ±  2%     +37.6%       7539 ±  8%  interrupts.CPU65.CAL:Function_call_interrupts
   1755374 ±  2%     -81.8%     318998 ± 17%  interrupts.CPU65.LOC:Local_timer_interrupts
      1144 ± 22%    +157.7%       2949 ± 30%  interrupts.CPU65.NMI:Non-maskable_interrupts
      1144 ± 22%    +157.7%       2949 ± 30%  interrupts.CPU65.PMI:Performance_monitoring_interrupts
      5554 ±  2%     +33.5%       7412 ±  7%  interrupts.CPU66.CAL:Function_call_interrupts
   1755198 ±  2%     -81.8%     319029 ± 17%  interrupts.CPU66.LOC:Local_timer_interrupts
    871.60 ± 42%    +273.0%       3251 ± 18%  interrupts.CPU66.NMI:Non-maskable_interrupts
    871.60 ± 42%    +273.0%       3251 ± 18%  interrupts.CPU66.PMI:Performance_monitoring_interrupts
      5488 ±  3%     +37.9%       7566 ±  7%  interrupts.CPU67.CAL:Function_call_interrupts
   1755233 ±  2%     -81.8%     319016 ± 17%  interrupts.CPU67.LOC:Local_timer_interrupts
      1305 ± 39%    +149.4%       3256 ± 14%  interrupts.CPU67.NMI:Non-maskable_interrupts
      1305 ± 39%    +149.4%       3256 ± 14%  interrupts.CPU67.PMI:Performance_monitoring_interrupts
      5420 ±  4%     +35.5%       7343 ±  7%  interrupts.CPU68.CAL:Function_call_interrupts
   1755361 ±  2%     -81.8%     319002 ± 17%  interrupts.CPU68.LOC:Local_timer_interrupts
      1175 ± 29%    +173.5%       3214 ± 16%  interrupts.CPU68.NMI:Non-maskable_interrupts
      1175 ± 29%    +173.5%       3214 ± 16%  interrupts.CPU68.PMI:Performance_monitoring_interrupts
      5286 ±  2%     +40.2%       7414 ±  7%  interrupts.CPU69.CAL:Function_call_interrupts
   1755311 ±  2%     -81.8%     319028 ± 17%  interrupts.CPU69.LOC:Local_timer_interrupts
      1234 ± 33%    +157.3%       3177 ± 19%  interrupts.CPU69.NMI:Non-maskable_interrupts
      1234 ± 33%    +157.3%       3177 ± 19%  interrupts.CPU69.PMI:Performance_monitoring_interrupts
      5432 ±  2%     +47.0%       7984 ± 12%  interrupts.CPU7.CAL:Function_call_interrupts
   1755318 ±  2%     -81.8%     319023 ± 17%  interrupts.CPU7.LOC:Local_timer_interrupts
      1345 ± 35%    +104.8%       2755 ± 12%  interrupts.CPU7.NMI:Non-maskable_interrupts
      1345 ± 35%    +104.8%       2755 ± 12%  interrupts.CPU7.PMI:Performance_monitoring_interrupts
    276.80 ± 19%     +42.1%     393.40 ±  5%  interrupts.CPU7.RES:Rescheduling_interrupts
      5391 ±  2%     +39.3%       7512 ±  7%  interrupts.CPU70.CAL:Function_call_interrupts
   1755314 ±  2%     -81.8%     319081 ± 17%  interrupts.CPU70.LOC:Local_timer_interrupts
      1369 ± 22%    +109.5%       2868 ± 28%  interrupts.CPU70.NMI:Non-maskable_interrupts
      1369 ± 22%    +109.5%       2868 ± 28%  interrupts.CPU70.PMI:Performance_monitoring_interrupts
      5598 ±  6%     +34.5%       7529 ±  7%  interrupts.CPU71.CAL:Function_call_interrupts
   1755309 ±  2%     -81.8%     319063 ± 17%  interrupts.CPU71.LOC:Local_timer_interrupts
      1382 ± 19%    +131.5%       3200 ± 20%  interrupts.CPU71.NMI:Non-maskable_interrupts
      1382 ± 19%    +131.5%       3200 ± 20%  interrupts.CPU71.PMI:Performance_monitoring_interrupts
      5524 ±  3%     +44.4%       7979 ±  7%  interrupts.CPU72.CAL:Function_call_interrupts
   1754859 ±  2%     -81.8%     318960 ± 17%  interrupts.CPU72.LOC:Local_timer_interrupts
      1416 ± 22%    +133.0%       3300 ± 18%  interrupts.CPU72.NMI:Non-maskable_interrupts
      1416 ± 22%    +133.0%       3300 ± 18%  interrupts.CPU72.PMI:Performance_monitoring_interrupts
    282.40 ± 13%     -55.1%     126.80 ± 44%  interrupts.CPU72.TLB:TLB_shootdowns
      5532 ±  3%     +38.4%       7656 ±  8%  interrupts.CPU73.CAL:Function_call_interrupts
   1755278 ±  2%     -81.8%     319034 ± 17%  interrupts.CPU73.LOC:Local_timer_interrupts
      1315 ± 28%    +112.6%       2795 ± 13%  interrupts.CPU73.NMI:Non-maskable_interrupts
      1315 ± 28%    +112.6%       2795 ± 13%  interrupts.CPU73.PMI:Performance_monitoring_interrupts
      5507 ±  2%     +41.7%       7803 ±  9%  interrupts.CPU74.CAL:Function_call_interrupts
   1755170 ±  2%     -81.8%     319063 ± 17%  interrupts.CPU74.LOC:Local_timer_interrupts
      1253 ± 22%    +163.0%       3296 ± 15%  interrupts.CPU74.NMI:Non-maskable_interrupts
      1253 ± 22%    +163.0%       3296 ± 15%  interrupts.CPU74.PMI:Performance_monitoring_interrupts
      5414 ±  3%     +39.1%       7530 ±  7%  interrupts.CPU75.CAL:Function_call_interrupts
   1755047 ±  2%     -81.8%     318955 ± 17%  interrupts.CPU75.LOC:Local_timer_interrupts
      1407 ± 22%    +131.0%       3252 ± 16%  interrupts.CPU75.NMI:Non-maskable_interrupts
      1407 ± 22%    +131.0%       3252 ± 16%  interrupts.CPU75.PMI:Performance_monitoring_interrupts
      5500 ±  4%     +45.1%       7980 ±  7%  interrupts.CPU76.CAL:Function_call_interrupts
   1755174 ±  2%     -81.8%     318986 ± 17%  interrupts.CPU76.LOC:Local_timer_interrupts
      1336 ± 26%    +121.4%       2958 ± 30%  interrupts.CPU76.NMI:Non-maskable_interrupts
      1336 ± 26%    +121.4%       2958 ± 30%  interrupts.CPU76.PMI:Performance_monitoring_interrupts
      5371 ±  2%     +44.2%       7744 ± 10%  interrupts.CPU77.CAL:Function_call_interrupts
   1755056 ±  2%     -81.8%     318966 ± 17%  interrupts.CPU77.LOC:Local_timer_interrupts
      1295 ± 25%    +107.0%       2681 ± 39%  interrupts.CPU77.NMI:Non-maskable_interrupts
      1295 ± 25%    +107.0%       2681 ± 39%  interrupts.CPU77.PMI:Performance_monitoring_interrupts
      5466 ±  3%     +41.5%       7736 ±  6%  interrupts.CPU78.CAL:Function_call_interrupts
   1755141 ±  2%     -81.8%     319001 ± 17%  interrupts.CPU78.LOC:Local_timer_interrupts
    342.80 ±  3%     +16.0%     397.60 ± 10%  interrupts.CPU78.RES:Rescheduling_interrupts
      5467           +42.1%       7767 ±  7%  interrupts.CPU79.CAL:Function_call_interrupts
   1755134 ±  2%     -81.8%     318991 ± 17%  interrupts.CPU79.LOC:Local_timer_interrupts
      5590 ± 11%     +36.7%       7644 ±  9%  interrupts.CPU8.CAL:Function_call_interrupts
   1755151 ±  2%     -81.8%     319074 ± 17%  interrupts.CPU8.LOC:Local_timer_interrupts
      1286 ± 27%    +121.2%       2845 ± 30%  interrupts.CPU8.NMI:Non-maskable_interrupts
      1286 ± 27%    +121.2%       2845 ± 30%  interrupts.CPU8.PMI:Performance_monitoring_interrupts
    248.60 ± 11%     +61.0%     400.20 ±  5%  interrupts.CPU8.RES:Rescheduling_interrupts
      5395           +45.0%       7821 ±  9%  interrupts.CPU80.CAL:Function_call_interrupts
   1755125 ±  2%     -81.8%     318990 ± 17%  interrupts.CPU80.LOC:Local_timer_interrupts
      1289 ± 23%    +131.9%       2990 ± 31%  interrupts.CPU80.NMI:Non-maskable_interrupts
      1289 ± 23%    +131.9%       2990 ± 31%  interrupts.CPU80.PMI:Performance_monitoring_interrupts
    350.20 ±  5%     +18.4%     414.60 ±  8%  interrupts.CPU80.RES:Rescheduling_interrupts
      5367 ±  2%     +47.0%       7891 ± 10%  interrupts.CPU81.CAL:Function_call_interrupts
   1754991 ±  2%     -81.8%     318991 ± 17%  interrupts.CPU81.LOC:Local_timer_interrupts
      5322 ±  4%     +46.5%       7796 ±  9%  interrupts.CPU82.CAL:Function_call_interrupts
   1755214 ±  2%     -81.8%     318992 ± 17%  interrupts.CPU82.LOC:Local_timer_interrupts
      5350           +46.8%       7855 ±  8%  interrupts.CPU83.CAL:Function_call_interrupts
   1755169 ±  2%     -81.8%     318991 ± 17%  interrupts.CPU83.LOC:Local_timer_interrupts
      5404 ±  2%     +41.9%       7670 ±  7%  interrupts.CPU84.CAL:Function_call_interrupts
   1755110 ±  2%     -81.8%     318986 ± 17%  interrupts.CPU84.LOC:Local_timer_interrupts
      1266 ± 24%    +129.3%       2904 ± 32%  interrupts.CPU84.NMI:Non-maskable_interrupts
      1266 ± 24%    +129.3%       2904 ± 32%  interrupts.CPU84.PMI:Performance_monitoring_interrupts
      5539 ±  3%     +41.6%       7842 ±  7%  interrupts.CPU85.CAL:Function_call_interrupts
   1754435 ±  2%     -81.8%     318973 ± 17%  interrupts.CPU85.LOC:Local_timer_interrupts
      1392 ± 18%    +110.6%       2932 ± 32%  interrupts.CPU85.NMI:Non-maskable_interrupts
      1392 ± 18%    +110.6%       2932 ± 32%  interrupts.CPU85.PMI:Performance_monitoring_interrupts
      5440 ±  4%     +41.8%       7711 ±  9%  interrupts.CPU86.CAL:Function_call_interrupts
   1754725 ±  2%     -81.8%     318995 ± 17%  interrupts.CPU86.LOC:Local_timer_interrupts
      5402 ±  3%     +41.7%       7655 ±  9%  interrupts.CPU87.CAL:Function_call_interrupts
   1754744 ±  2%     -81.8%     318982 ± 17%  interrupts.CPU87.LOC:Local_timer_interrupts
      1611 ± 16%     +82.5%       2941 ± 27%  interrupts.CPU87.NMI:Non-maskable_interrupts
      1611 ± 16%     +82.5%       2941 ± 27%  interrupts.CPU87.PMI:Performance_monitoring_interrupts
      5435 ±  4%     +42.9%       7765 ±  6%  interrupts.CPU88.CAL:Function_call_interrupts
   1754726 ±  2%     -81.8%     318982 ± 17%  interrupts.CPU88.LOC:Local_timer_interrupts
      1370 ± 13%    +113.2%       2922 ± 30%  interrupts.CPU88.NMI:Non-maskable_interrupts
      1370 ± 13%    +113.2%       2922 ± 30%  interrupts.CPU88.PMI:Performance_monitoring_interrupts
      5347 ±  3%     +43.7%       7682 ±  6%  interrupts.CPU89.CAL:Function_call_interrupts
   1754752 ±  2%     -81.8%     319006 ± 17%  interrupts.CPU89.LOC:Local_timer_interrupts
      1400 ± 12%    +112.8%       2979 ± 32%  interrupts.CPU89.NMI:Non-maskable_interrupts
      1400 ± 12%    +112.8%       2979 ± 32%  interrupts.CPU89.PMI:Performance_monitoring_interrupts
    348.80 ±  2%     +17.7%     410.40 ±  8%  interrupts.CPU89.RES:Rescheduling_interrupts
      5123 ±  3%     +45.7%       7466 ±  7%  interrupts.CPU9.CAL:Function_call_interrupts
   1755185 ±  2%     -81.8%     319009 ± 17%  interrupts.CPU9.LOC:Local_timer_interrupts
      1288 ± 26%    +130.0%       2964 ± 31%  interrupts.CPU9.NMI:Non-maskable_interrupts
      1288 ± 26%    +130.0%       2964 ± 31%  interrupts.CPU9.PMI:Performance_monitoring_interrupts
    250.80 ±  3%     +55.9%     391.00 ±  5%  interrupts.CPU9.RES:Rescheduling_interrupts
      5370 ±  3%     +48.5%       7975 ± 11%  interrupts.CPU90.CAL:Function_call_interrupts
   1754701 ±  2%     -81.8%     318942 ± 17%  interrupts.CPU90.LOC:Local_timer_interrupts
      5489 ±  6%     +46.4%       8038 ±  8%  interrupts.CPU91.CAL:Function_call_interrupts
   1754714 ±  2%     -81.8%     318897 ± 17%  interrupts.CPU91.LOC:Local_timer_interrupts
      5357 ±  2%     +43.9%       7709 ±  7%  interrupts.CPU92.CAL:Function_call_interrupts
   1754857 ±  2%     -81.8%     318947 ± 17%  interrupts.CPU92.LOC:Local_timer_interrupts
      1208 ± 26%    +112.6%       2570 ± 35%  interrupts.CPU92.NMI:Non-maskable_interrupts
      1208 ± 26%    +112.6%       2570 ± 35%  interrupts.CPU92.PMI:Performance_monitoring_interrupts
      5463 ±  5%     +42.0%       7756 ±  9%  interrupts.CPU93.CAL:Function_call_interrupts
   1754602 ±  2%     -81.8%     318970 ± 17%  interrupts.CPU93.LOC:Local_timer_interrupts
      1327 ± 28%    +138.7%       3168 ± 18%  interrupts.CPU93.NMI:Non-maskable_interrupts
      1327 ± 28%    +138.7%       3168 ± 18%  interrupts.CPU93.PMI:Performance_monitoring_interrupts
    340.20           +16.3%     395.80 ±  5%  interrupts.CPU93.RES:Rescheduling_interrupts
      5252 ±  2%     +48.5%       7801 ± 12%  interrupts.CPU94.CAL:Function_call_interrupts
   1755185 ±  2%     -81.8%     318958 ± 17%  interrupts.CPU94.LOC:Local_timer_interrupts
      1415 ± 22%    +128.9%       3240 ± 14%  interrupts.CPU94.NMI:Non-maskable_interrupts
      1415 ± 22%    +128.9%       3240 ± 14%  interrupts.CPU94.PMI:Performance_monitoring_interrupts
    338.00 ±  3%     +11.7%     377.40 ±  7%  interrupts.CPU94.RES:Rescheduling_interrupts
      5398 ±  5%     +44.1%       7777 ±  8%  interrupts.CPU95.CAL:Function_call_interrupts
   1755057 ±  2%     -81.8%     318957 ± 17%  interrupts.CPU95.LOC:Local_timer_interrupts
      1269 ± 22%    +112.1%       2693 ± 42%  interrupts.CPU95.NMI:Non-maskable_interrupts
      1269 ± 22%    +112.1%       2693 ± 42%  interrupts.CPU95.PMI:Performance_monitoring_interrupts
      5477 ±  2%     +40.4%       7688 ± 10%  interrupts.CPU96.CAL:Function_call_interrupts
   1755228 ±  2%     -81.8%     319021 ± 17%  interrupts.CPU96.LOC:Local_timer_interrupts
      1189 ± 37%    +139.6%       2848 ± 30%  interrupts.CPU96.NMI:Non-maskable_interrupts
      1189 ± 37%    +139.6%       2848 ± 30%  interrupts.CPU96.PMI:Performance_monitoring_interrupts
    345.40 ±  4%     +12.7%     389.20 ±  7%  interrupts.CPU96.RES:Rescheduling_interrupts
      5512           +41.3%       7791 ±  9%  interrupts.CPU97.CAL:Function_call_interrupts
   1755138 ±  2%     -81.8%     319041 ± 17%  interrupts.CPU97.LOC:Local_timer_interrupts
      1298 ± 30%    +125.1%       2922 ± 29%  interrupts.CPU97.NMI:Non-maskable_interrupts
      1298 ± 30%    +125.1%       2922 ± 29%  interrupts.CPU97.PMI:Performance_monitoring_interrupts
      5433           +41.2%       7673 ±  9%  interrupts.CPU98.CAL:Function_call_interrupts
   1754957 ±  2%     -81.8%     319031 ± 17%  interrupts.CPU98.LOC:Local_timer_interrupts
      5391           +40.3%       7561 ± 10%  interrupts.CPU99.CAL:Function_call_interrupts
   1754878 ±  2%     -81.8%     318928 ± 17%  interrupts.CPU99.LOC:Local_timer_interrupts
      1420 ± 18%     +98.3%       2817 ± 28%  interrupts.CPU99.NMI:Non-maskable_interrupts
      1420 ± 18%     +98.3%       2817 ± 28%  interrupts.CPU99.PMI:Performance_monitoring_interrupts
      1.00         +6440.0%      65.40 ± 95%  interrupts.IWI:IRQ_work_interrupts
  3.37e+08 ±  2%     -81.8%   61248458 ± 17%  interrupts.LOC:Local_timer_interrupts
    384.00          -100.0%       0.00        interrupts.MCP:Machine_check_polls
    257000 ±  3%    +122.3%     571373 ± 16%  interrupts.NMI:Non-maskable_interrupts
    257000 ±  3%    +122.3%     571373 ± 16%  interrupts.PMI:Performance_monitoring_interrupts
      7131 ± 25%     -50.5%       3529 ± 27%  interrupts.TLB:TLB_shootdowns


                                                                                
                                  aim7.jobs-per-min                             
                                                                                
  10000 +-------------------------------------------------------------------+   
        |                 O                                                 |   
   9000 |-+      O             O   O    O        O   O                      |   
   8000 |-+  O                              O                               |   
        |             O                                                     |   
   7000 |-+                                                   O             |   
   6000 |-+                                               O                 |   
        |                                                                   |   
   5000 |-+                                                                 |   
   4000 |-+                                                                 |   
        |                                                                   |   
   3000 |-+                                                                 |   
   2000 |-+                                                                 |   
        |....+...   ..+...+....+...+....+...+....+...+....+...   ..+...+....|   
   1000 +-------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                                aim7.time.system_time                           
                                                                                
  20000 +-------------------------------------------------------------------+   
        |                                                                   |   
  18000 |....  ..+....+...   ..+...+....  ..+....+...+....  ..+....+...+....|   
  16000 |-+  +.           +..           +.                +.                |   
        |                                                                   |   
  14000 |-+                                                                 |   
        |                                                                   |   
  12000 |-+                                                                 |   
        |                                                                   |   
  10000 |-+                                                                 |   
   8000 |-+                                                                 |   
        |                                   O             O                 |   
   6000 |-+           O                          O   O        O             |   
        |    O   O        O    O   O    O                                   |   
   4000 +-------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                              aim7.time.elapsed_time                            
                                                                                
  1000 +--------------------------------------------------------------------+   
       |       .+....                                       ..+....         |   
   900 |.... ..      +...   ..+....+...+....+...+....   ..+.       +...+....|   
   800 |-+  +            +..                         +..                    |   
       |                                                                    |   
   700 |-+                                                                  |   
   600 |-+                                                                  |   
       |                                                                    |   
   500 |-+                                                                  |   
   400 |-+                                                                  |   
       |                                                                    |   
   300 |-+                                                                  |   
   200 |-+                                                O                 |   
       |    O   O    O        O    O   O    O   O    O        O             |   
   100 +--------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                            aim7.time.elapsed_time.max                          
                                                                                
  1000 +--------------------------------------------------------------------+   
       |       .+....                                       ..+....         |   
   900 |.... ..      +...   ..+....+...+....+...+....   ..+.       +...+....|   
   800 |-+  +            +..                         +..                    |   
       |                                                                    |   
   700 |-+                                                                  |   
   600 |-+                                                                  |   
       |                                                                    |   
   500 |-+                                                                  |   
   400 |-+                                                                  |   
       |                                                                    |   
   300 |-+                                                                  |   
   200 |-+                                                O                 |   
       |    O   O    O        O    O   O    O   O    O        O             |   
   100 +--------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                             aim7.time.minor_page_faults                        
                                                                                
  130000 +------------------------------------------------------------------+   
         |      ..+...       ..+...        ..+..             ..+..          |   
  120000 |-..+..      +....+.      .  ..+..     .   ..+...+..     .   ..+...|   
  110000 |.+                        +.           +..               +..      |   
         |                                                                  |   
  100000 |-+                                                                |   
   90000 |-+                                                                |   
         |                                                                  |   
   80000 |-+                                                                |   
   70000 |-+                                                                |   
         |                                                                  |   
   60000 |-+                                                   O            |   
   50000 |-+          O                      O        O   O                 |   
         |   O    O        O        O   O        O                          |   
   40000 +------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                         aim7.time.voluntary_context_switches                   
                                                                                
    4e+07 +-----------------------------------------------------------------+   
          |        O        O   O   O    O            O                     |   
          |                                  O                              |   
  3.5e+07 |-+          O                                                    |   
          |                                                                 |   
          |   O                                                             |   
    3e+07 |-+                                                  O            |   
          |                                               O                 |   
  2.5e+07 |-+                                                               |   
          |                                                                 |   
          |                                                                 |   
    2e+07 |-+                                                               |   
          |                                                                 |   
          |                                                                 |   
  1.5e+07 +-----------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                       aim7.time.involuntary_context_switches                   
                                                                                
  45000 +-------------------------------------------------------------------+   
        |....  ..+....                         ..+...       ..+....+...     |   
  40000 |-+  +.       +...+....+...+....+...+..      +....+.           +....|   
        |                                                                   |   
  35000 |-+                                                                 |   
        |                                                                   |   
  30000 |-+                                                                 |   
        |                                                                   |   
  25000 |-+                                                                 |   
        |                                                                   |   
  20000 |-+                                 O             O   O             |   
        |             O                          O   O                      |   
  15000 |-+  O   O        O    O   O    O                                   |   
        |                                                                   |   
  10000 +-------------------------------------------------------------------+   
                                                                                
                                                                                
[*] bisect-good sample
[O] bisect-bad  sample



Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


Thanks,
Rong Chen


--mWEPrn9k3Wj8m9KK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="config-5.7.0-14038-g79963d967b492"

#
# Automatically generated file; DO NOT EDIT.
# Linux/x86_64 5.7.0 Kernel Configuration
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
CONFIG_KERNEL_GZIP=y
# CONFIG_KERNEL_BZIP2 is not set
# CONFIG_KERNEL_LZMA is not set
# CONFIG_KERNEL_XZ is not set
# CONFIG_KERNEL_LZO is not set
# CONFIG_KERNEL_LZ4 is not set
CONFIG_DEFAULT_INIT=""
CONFIG_DEFAULT_HOSTNAME="(none)"
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_SYSVIPC_SYSCTL=y
CONFIG_POSIX_MQUEUE=y
CONFIG_POSIX_MQUEUE_SYSCTL=y
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
# CONFIG_SCHED_THERMAL_PRESSURE is not set
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
# CONFIG_ACPI_PROCFS_POWER is not set
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
CONFIG_HAVE_MEMORY_PRESENT=y
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
# CONFIG_TUN is not set
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
# CONFIG_MSCC_OCELOT_SWITCH is not set
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
# CONFIG_USB_RTL8152 is not set
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
# CONFIG_MT7915E is not set
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
CONFIG_HW_RANDOM_VIA=m
CONFIG_HW_RANDOM_VIRTIO=y
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
CONFIG_I2C_DESIGNWARE_PLATFORM=m
# CONFIG_I2C_DESIGNWARE_SLAVE is not set
# CONFIG_I2C_DESIGNWARE_PCI is not set
CONFIG_I2C_DESIGNWARE_BAYTRAIL=y
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
# CONFIG_SENSORS_MAX16601 is not set
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
CONFIG_MEDIA_CEC_SUPPORT=y
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
# CONFIG_USB_OTG_WHITELIST is not set
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
# CONFIG_INFINIBAND_EXP_LEGACY_VERBS_NEW_UAPI is not set
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
CONFIG_CRYPTO_USER_API_AEAD=y
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
CONFIG_DMA_NONCOHERENT_MMAP=y
CONFIG_DMA_REMAP=y
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
CONFIG_HAVE_ARCH_KGDB=y
# CONFIG_KGDB is not set
CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
# CONFIG_UBSAN is not set
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
# CONFIG_TEST_UDELAY is not set
# CONFIG_TEST_STATIC_KEYS is not set
# CONFIG_TEST_KMOD is not set
# CONFIG_TEST_MEMCAT_P is not set
# CONFIG_TEST_LIVEPATCH is not set
# CONFIG_TEST_STACKINIT is not set
# CONFIG_TEST_MEMINIT is not set
# CONFIG_TEST_HMM is not set
# CONFIG_MEMTEST is not set
# CONFIG_HYPERV_TESTING is not set
# end of Kernel Testing and Coverage
# end of Kernel hacking

--mWEPrn9k3Wj8m9KK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=job-script

#!/bin/sh

export_top_env()
{
	export suite='aim7'
	export testcase='aim7'
	export category='benchmark'
	export job_origin='/lkp-src/allot/cyclic:p1:linux-devel:devel-hourly/lkp-csl-2ap2/aim7-fs-1brd.yaml'
	export queue_cmdline_keys='branch
commit
queue_at_least_once'
	export queue='validate'
	export testbox='lkp-csl-2ap2'
	export tbox_group='lkp-csl-2ap2'
	export kconfig='x86_64-rhel-8.3'
	export submit_id='5f8073eff82c3815bb8e6d04'
	export job_file='/lkp/jobs/scheduled/lkp-csl-2ap2/aim7-performance-1BRD_48G-f2fs-200-sync_disk_rw-ucode=0x5002f01-monitor=e907e467-debian-10.4-x86_64-20200603.cgz-79963d967b49287-20201009-5563-17uhdrj-3.yaml'
	export id='5ddd43dd6ad5bd52dcc045b66a93c155a8067a95'
	export queuer_version='/lkp-src'
	export model='Cascade Lake'
	export nr_node=4
	export nr_cpu=192
	export memory='192G'
	export nr_ssd_partitions=1
	export hdd_partitions=
	export ssd_partitions='/dev/disk/by-id/nvme-INTEL_SSDPE2KX010T8_BTLJ910200B21P0FGN-part4'
	export rootfs_partition='LABEL=LKP-ROOTFS'
	export kernel_cmdline_hw='acpi_rsdp=0x67f44014'
	export brand='Intel(R) Xeon(R) Platinum 9242 CPU @ 2.30GHz'
	export timeout='1h'
	export commit='79963d967b492876fa17c8c2c2c17b7438683d9b'
	export need_kconfig_hw='CONFIG_IGB=y
CONFIG_BLK_DEV_NVME'
	export ucode='0x5002f01'
	export need_kconfig='CONFIG_BLK_DEV_RAM=m
CONFIG_BLK_DEV=y
CONFIG_BLOCK=y
CONFIG_F2FS_FS'
	export enqueue_time='2020-10-09 22:30:07 +0800'
	export _id='5f8073f4f82c3815bb8e6d05'
	export _rt='/result/aim7/performance-1BRD_48G-f2fs-200-sync_disk_rw-ucode=0x5002f01-monitor=e907e467/lkp-csl-2ap2/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/79963d967b492876fa17c8c2c2c17b7438683d9b'
	export user='lkp'
	export compiler='gcc-9'
	export head_commit='56491aaa40c3572f4bf08fa32854f454bba2e27b'
	export base_commit='9123e3a74ec7b934a4a099e98af6a61c2f80bbf5'
	export branch='linus/master'
	export rootfs='debian-10.4-x86_64-20200603.cgz'
	export monitor_sha='e907e467'
	export result_root='/result/aim7/performance-1BRD_48G-f2fs-200-sync_disk_rw-ucode=0x5002f01-monitor=e907e467/lkp-csl-2ap2/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/79963d967b492876fa17c8c2c2c17b7438683d9b/3'
	export scheduler_version='/lkp/lkp/.src-20201009-151851'
	export LKP_SERVER='inn'
	export arch='x86_64'
	export max_uptime=3600
	export initrd='/osimage/debian/debian-10.4-x86_64-20200603.cgz'
	export bootloader_append='root=/dev/ram0
user=lkp
job=/lkp/jobs/scheduled/lkp-csl-2ap2/aim7-performance-1BRD_48G-f2fs-200-sync_disk_rw-ucode=0x5002f01-monitor=e907e467-debian-10.4-x86_64-20200603.cgz-79963d967b49287-20201009-5563-17uhdrj-3.yaml
ARCH=x86_64
kconfig=x86_64-rhel-8.3
branch=linus/master
commit=79963d967b492876fa17c8c2c2c17b7438683d9b
BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3/gcc-9/79963d967b492876fa17c8c2c2c17b7438683d9b/vmlinuz-5.7.0-14038-g79963d967b492
acpi_rsdp=0x67f44014
max_uptime=3600
RESULT_ROOT=/result/aim7/performance-1BRD_48G-f2fs-200-sync_disk_rw-ucode=0x5002f01-monitor=e907e467/lkp-csl-2ap2/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/79963d967b492876fa17c8c2c2c17b7438683d9b/3
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
	export modules_initrd='/pkg/linux/x86_64-rhel-8.3/gcc-9/79963d967b492876fa17c8c2c2c17b7438683d9b/modules.cgz'
	export bm_initrd='/osimage/deps/debian-10.4-x86_64-20200603.cgz/run-ipconfig_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/lkp_20200709.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/rsync-rootfs_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/perf_20200723.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/perf-x86_64-c85fb28b6f99-1_20201008.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/fs_20200714.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/aim7-x86_64-1-1_20201007.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/mpstat_20200714.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/sar-x86_64-34c92ae-1_20200702.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/hw_20200715.cgz'
	export ucode_initrd='/osimage/ucode/intel-ucode-20200610.cgz'
	export lkp_initrd='/osimage/user/lkp/lkp-x86_64.cgz'
	export site='inn'
	export LKP_CGI_PORT=80
	export LKP_CIFS_PORT=139
	export last_kernel='5.9.0-rc1-intel-next-01283-g0e27f3961ed74'
	export repeat_to=4
	export queue_at_least_once=1
	export schedule_notify_address=
	export kernel='/pkg/linux/x86_64-rhel-8.3/gcc-9/79963d967b492876fa17c8c2c2c17b7438683d9b/vmlinuz-5.7.0-14038-g79963d967b492'
	export dequeue_time='2020-10-09 22:35:58 +0800'
	export job_initrd='/lkp/jobs/scheduled/lkp-csl-2ap2/aim7-performance-1BRD_48G-f2fs-200-sync_disk_rw-ucode=0x5002f01-monitor=e907e467-debian-10.4-x86_64-20200603.cgz-79963d967b49287-20201009-5563-17uhdrj-3.cgz'

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

	run_setup nr_brd=1 ramdisk_size=51539607552 $LKP_SRC/setup/disk

	run_setup fs='f2fs' $LKP_SRC/setup/fs

	run_setup $LKP_SRC/setup/cpufreq_governor 'performance'

	run_monitor delay=15 $LKP_SRC/monitors/no-stdout/wrapper perf-profile
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
	run_monitor $LKP_SRC/monitors/wrapper oom-killer
	run_monitor $LKP_SRC/monitors/plain/watchdog

	run_test test='sync_disk_rw' load=200 $LKP_SRC/tests/wrapper aim7
}

extract_stats()
{
	export stats_part_begin=
	export stats_part_end=

	$LKP_SRC/stats/wrapper perf-profile
	$LKP_SRC/stats/wrapper aim7
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

	$LKP_SRC/stats/wrapper time aim7.time
	$LKP_SRC/stats/wrapper dmesg
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper last_state
	$LKP_SRC/stats/wrapper stderr
	$LKP_SRC/stats/wrapper time
}

"$@"

--mWEPrn9k3Wj8m9KK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="job.yaml"

---

#! jobs/aim7-fs-1brd.yaml
suite: aim7
testcase: aim7
category: benchmark
perf-profile:
  delay: 15
disk: 1BRD_48G
fs: f2fs
aim7:
  test: sync_disk_rw
  load: 200
job_origin: "/lkp-src/allot/cyclic:p1:linux-devel:devel-hourly/lkp-csl-2ap2/aim7-fs-1brd.yaml"

#! queue options
queue_cmdline_keys:
- branch
- commit
- queue_at_least_once
queue: bisect
testbox: lkp-csl-2ap2
tbox_group: lkp-csl-2ap2
kconfig: x86_64-rhel-8.3
submit_id: 5f802b1ff82c381242639f2b
job_file: "/lkp/jobs/scheduled/lkp-csl-2ap2/aim7-performance-1BRD_48G-f2fs-200-sync_disk_rw-ucode=0x5002f01-monitor=e907e467-debian-10.4-x86_64-20200603.cgz-79963d967b49287-20201009-4674-170ymkp-0.yaml"
id: b9e064cfede82bd6df22e654a9bf511618dfbe56
queuer_version: "/lkp-src"

#! hosts/lkp-csl-2ap2
model: Cascade Lake
nr_node: 4
nr_cpu: 192
memory: 192G
nr_ssd_partitions: 1
hdd_partitions: 
ssd_partitions: "/dev/disk/by-id/nvme-INTEL_SSDPE2KX010T8_BTLJ910200B21P0FGN-part4"
rootfs_partition: LABEL=LKP-ROOTFS
kernel_cmdline_hw: acpi_rsdp=0x67f44014
brand: Intel(R) Xeon(R) Platinum 9242 CPU @ 2.30GHz

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

#! include/category/ALL
cpufreq_governor: performance

#! include/aim7
timeout: 1h

#! include/queue/cyclic
commit: 79963d967b492876fa17c8c2c2c17b7438683d9b

#! include/testbox/lkp-csl-2ap2
need_kconfig_hw:
- CONFIG_IGB=y
- CONFIG_BLK_DEV_NVME
ucode: '0x5002f01'

#! include/disk/nr_brd
need_kconfig:
- CONFIG_BLK_DEV_RAM=m
- CONFIG_BLK_DEV=y
- CONFIG_BLOCK=y
- CONFIG_F2FS_FS

#! include/fs/OTHERS
enqueue_time: 2020-10-09 17:19:27.791130619 +08:00
_id: 5f802b1ff82c381242639f2b
_rt: "/result/aim7/performance-1BRD_48G-f2fs-200-sync_disk_rw-ucode=0x5002f01-monitor=e907e467/lkp-csl-2ap2/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/79963d967b492876fa17c8c2c2c17b7438683d9b"

#! schedule options
user: lkp
compiler: gcc-9
head_commit: 56491aaa40c3572f4bf08fa32854f454bba2e27b
base_commit: 9123e3a74ec7b934a4a099e98af6a61c2f80bbf5
branch: linux-devel/devel-hourly-2020082022
rootfs: debian-10.4-x86_64-20200603.cgz
monitor_sha: e907e467
result_root: "/result/aim7/performance-1BRD_48G-f2fs-200-sync_disk_rw-ucode=0x5002f01-monitor=e907e467/lkp-csl-2ap2/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/79963d967b492876fa17c8c2c2c17b7438683d9b/0"
scheduler_version: "/lkp/lkp/.src-20201009-151851"
LKP_SERVER: inn
arch: x86_64
max_uptime: 3600
initrd: "/osimage/debian/debian-10.4-x86_64-20200603.cgz"
bootloader_append:
- root=/dev/ram0
- user=lkp
- job=/lkp/jobs/scheduled/lkp-csl-2ap2/aim7-performance-1BRD_48G-f2fs-200-sync_disk_rw-ucode=0x5002f01-monitor=e907e467-debian-10.4-x86_64-20200603.cgz-79963d967b49287-20201009-4674-170ymkp-0.yaml
- ARCH=x86_64
- kconfig=x86_64-rhel-8.3
- branch=linux-devel/devel-hourly-2020082022
- commit=79963d967b492876fa17c8c2c2c17b7438683d9b
- BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3/gcc-9/79963d967b492876fa17c8c2c2c17b7438683d9b/vmlinuz-5.7.0-14038-g79963d967b492
- acpi_rsdp=0x67f44014
- max_uptime=3600
- RESULT_ROOT=/result/aim7/performance-1BRD_48G-f2fs-200-sync_disk_rw-ucode=0x5002f01-monitor=e907e467/lkp-csl-2ap2/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/79963d967b492876fa17c8c2c2c17b7438683d9b/0
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
modules_initrd: "/pkg/linux/x86_64-rhel-8.3/gcc-9/79963d967b492876fa17c8c2c2c17b7438683d9b/modules.cgz"
bm_initrd: "/osimage/deps/debian-10.4-x86_64-20200603.cgz/run-ipconfig_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/lkp_20200709.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/rsync-rootfs_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/perf_20200723.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/perf-x86_64-c85fb28b6f99-1_20201008.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/fs_20200714.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/aim7-x86_64-1-1_20201007.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/mpstat_20200714.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/sar-x86_64-34c92ae-1_20200702.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/hw_20200715.cgz"
ucode_initrd: "/osimage/ucode/intel-ucode-20200610.cgz"
lkp_initrd: "/osimage/user/lkp/lkp-x86_64.cgz"
site: inn

#! /lkp/lkp/.src-20200822-215254/include/site/inn
LKP_CGI_PORT: 80
LKP_CIFS_PORT: 139
oom-killer: 
watchdog: 

#! runtime status
last_kernel: 5.4.0-rc7-00176-g599ea01ce0b32
repeat_to: 2
queue_at_least_once: 0
schedule_notify_address: 

#! user overrides
kernel: "/pkg/linux/x86_64-rhel-8.3/gcc-9/79963d967b492876fa17c8c2c2c17b7438683d9b/vmlinuz-5.7.0-14038-g79963d967b492"
dequeue_time: 2020-10-09 17:45:08.080498622 +08:00

#! /lkp/lkp/.src-20201009-151851/include/site/inn
job_state: finished
loadavg: 111.57 54.82 21.05 1/1473 7948
start_time: '1602236773'
end_time: '1602236909'
version: "/lkp/lkp/.src-20201009-151927:7f5d3234:105ca0bb8"

--mWEPrn9k3Wj8m9KK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=reproduce

 "modprobe" "-r" "brd"
 "modprobe" "brd" "rd_nr=1" "rd_size=50331648"
dmsetup remove_all
wipefs -a --force /dev/ram0
mkfs -t f2fs /dev/ram0
mkdir -p /fs/ram0
mount -t f2fs /dev/ram0 /fs/ram0

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
echo "/fs/ram0" > config

	(
		echo lkp-csl-2ap2
		echo sync_disk_rw

		echo 1
		echo 200
		echo 2
		echo 200
		echo 1
	) | ./multitask -t &

--mWEPrn9k3Wj8m9KK--
