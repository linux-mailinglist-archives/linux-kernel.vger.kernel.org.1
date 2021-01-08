Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34BDB2EED52
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 06:59:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbhAHF7J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 00:59:09 -0500
Received: from mga12.intel.com ([192.55.52.136]:27223 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725791AbhAHF7I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 00:59:08 -0500
IronPort-SDR: rcQQwKnyVxS6af51InlJ6KnFnVQPDmWvE7+YnbwcA64IIUOopTCocp/ko/ZuNX3b6Y1ttScQPZ
 kCkYlw9xf9rQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9857"; a="156731434"
X-IronPort-AV: E=Sophos;i="5.79,330,1602572400"; 
   d="scan'208";a="156731434"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2021 21:58:25 -0800
IronPort-SDR: hX2CuxYQGD3Lht5yBF5P2poMWdzplUtBxCdRsjw9oVV5oplAI5NQlsP+5wULA+UL+eodvwse0r
 9WoiiE/xvSgg==
X-IronPort-AV: E=Sophos;i="5.79,330,1602572400"; 
   d="scan'208";a="351575828"
Received: from xsang-optiplex-9020.sh.intel.com (HELO xsang-OptiPlex-9020) ([10.239.159.140])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2021 21:58:22 -0800
Date:   Fri, 8 Jan 2021 14:13:53 +0800
From:   Oliver Sang <oliver.sang@intel.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        kernel test robot <lkp@intel.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        Feng Tang <feng.tang@intel.com>, zhengjun.xing@intel.com
Subject: Re: [x86] d55564cfc2: will-it-scale.per_thread_ops -5.8% regression
Message-ID: <20210108061353.GA3437@xsang-OptiPlex-9020>
References: <20210107134723.GA28532@xsang-OptiPlex-9020>
 <CAHk-=wgQ5EEH3-GTK9KDB5mBmWjP25YHXC6_-V_KfWd0UTDTDQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=wgQ5EEH3-GTK9KDB5mBmWjP25YHXC6_-V_KfWd0UTDTDQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 07, 2021 at 09:43:54AM -0800, Linus Torvalds wrote:
> On Thu, Jan 7, 2021 at 5:32 AM kernel test robot <oliver.sang@intel.com> wrote:
> >
> > FYI, we noticed a -5.8% regression of will-it-scale.per_thread_ops due to commit:
> 
> Ok, that's noticeable.
> 
> And:
> 
> > commit: d55564cfc222326e944893eff0c4118353e349ec ("x86: Make __put_user() generate an out-of-line call")
> 
> Yeah, that wasn't supposed to cause any performance regressions. No
> core code should use __put_user() so much.
> 
> But:
> 
> > | testcase: change | will-it-scale: will-it-scale.per_process_ops -7.3% regression             |
> > | test machine     | 192 threads Intel(R) Xeon(R) Platinum 9242 CPU @ 2.30GHz with 192G memory |
> > | test parameters  | cpufreq_governor=performance                                              |
> > |                  | mode=process                                                              |
> > |                  | nr_task=100%                                                              |
> > |                  | test=poll2                                                                |
> > |                  | ucode=0x16                                                                |
> 
> Ok, it's poll(), and it's definitely the __put_user() there:
> 
> >       0.00            +1.8        1.77 ą  3%  perf-profile.children.cycles-pp.__put_user_nocheck_2
> >       0.00            +1.6        1.64 ą  3%  perf-profile.self.cycles-pp.__put_user_nocheck_2
> 
> And in fact, it's that final "write back the 16-bit revents field" at the end.
> 
> Which must have sucked before too, because it used to do a "stac/clac"
> for every word - but now it does it out of line.
> 
> The fix is to convert that loop to use "unsafe_put_user()" with the
> necessary accoutrements around it, and that should speed things up
> quite nicely. The (double) loop itself is actually just 14
> instructions, it's ridiculous how bad the code used to be, and how
> much better it is with the nice unsafe_put_user(). The whole double
> loop ends up being just
> 
>         lea    0x68(%rsp),%rsi
>         mov    %rcx,%rax
>   1:    mov    0x8(%rsi),%ecx
>         lea    0xc(%rsi),%rdx
>         test   %ecx,%ecx
>         je     3f
>         lea    (%rax,%rcx,8),%rdi
>   2:    movzwl 0x6(%rdx),%ecx
>         mov    %cx,0x6(%rax)
>         add    $0x8,%rax
>         add    $0x8,%rdx
>         cmp    %rdi,%rax
>         jne    2b
>   3:    mov    (%rsi),%rsi
>         test   %rsi,%rsi
>         jne    1b
> 
> with the attached patch.
> 
> Before, it would do the whole CLAC/STAC dance inside that loop for
> every entry (and with that commit d55564cfc22 it would be a function
> call, of course).
> 
> Can you verify that this fixes the regression (and in fact I'd expect
> it to improve that test-case)?

Hi Linus,

below is the result, the regression is fixed:
=========================================================================================
compiler/cpufreq_governor/kconfig/mode/nr_task/rootfs/tbox_group/test/testcase/ucode:
  gcc-9/performance/x86_64-rhel-8.3/thread/50%/debian-10.4-x86_64-20200603.cgz/lkp-ivb-2ep1/poll2/will-it-scale/0x42e

commit: 
  ea6f043fc9847e670b91dfbf1ef1cdff3451c152 ("x86: Make __get_user() generate an out-of-line call")
  d55564cfc222326e944893eff0c4118353e349ec ("x86: Make __put_user() generate an out-of-line call")
  51248db4caacc1b0b8dce788bc8b207a2e910c31 (your patch applied upon d55564cfc2)

ea6f043fc9847e67 d55564cfc222326e944893eff0c 51248db4caacc1b0b8dce788bc8 
---------------- --------------------------- --------------------------- 
         %stddev     %change         %stddev     %change         %stddev
             \          |                \          |                \  
   6600273            -5.8%    6218737            -0.2%    6585700        will-it-scale.24.threads
     49.29            -0.0%      49.28            -0.0%      49.27        will-it-scale.24.threads_idle
    275010            -5.8%     259113            -0.2%     274403        will-it-scale.per_thread_ops
    301.11            +0.0%     301.12            +0.0%     301.12        will-it-scale.time.elapsed_time
    301.11            +0.0%     301.12            +0.0%     301.12        will-it-scale.time.elapsed_time.max
      2.75 ± 15%     -18.2%       2.25 ± 19%     -27.3%       2.00 ± 35%  will-it-scale.time.involuntary_context_switches
      0.00       +2.5e+101%       0.25 ±173% +2.5e+101%       0.25 ±173%  will-it-scale.time.major_page_faults
      9363            +0.1%       9377            -0.2%       9340        will-it-scale.time.maximum_resident_set_size
      6346            -0.1%       6341            +0.1%       6351        will-it-scale.time.minor_page_faults
      4096            +0.0%       4096            +0.0%       4096        will-it-scale.time.page_size
      0.03 ± 23%      -8.3%       0.03 ± 15%      +8.3%       0.03 ± 13%  will-it-scale.time.system_time
      0.04 ± 11%     +13.3%       0.04 ± 10%     +13.3%       0.04 ± 10%  will-it-scale.time.user_time
     78.75 ±  2%      +3.2%      81.25 ±  2%      +1.9%      80.25        will-it-scale.time.voluntary_context_switches
   6600273            -5.8%    6218737            -0.2%    6585700        will-it-scale.workload
    325.58            +0.2%     326.18            -0.1%     325.24        uptime.boot
      8095            +0.0%       8096            -0.1%       8089        uptime.idle
     22.00            +1.6%      22.35            -0.5%      21.88        boot-time.boot
     14.04            -0.5%      13.97            +0.0%      14.04        boot-time.dhcp
    855.78 ±  2%      -0.9%     847.73            +0.8%     862.48 ±  2%  boot-time.idle
      0.46            -0.0%       0.46            -0.0%       0.46        boot-time.smp_boot
     49.44            +0.0       49.46            -0.0       49.42        mpstat.cpu.all.idle%
      0.91            +0.0        0.93            +0.0        0.91        mpstat.cpu.all.irq%
      0.03 ±  5%      +0.0        0.03 ±  2%      -0.0        0.03 ±  2%  mpstat.cpu.all.soft%
     43.51            +0.4       43.92            -0.0       43.48        mpstat.cpu.all.sys%
      6.12            -0.5        5.66 ±  2%      +0.0        6.16 ±  2%  mpstat.cpu.all.usr%
 1.358e+08 ±169%     +13.7%  1.545e+08 ±166%    +122.6%  3.023e+08 ± 99%  cpuidle.C1.time
   1948771 ±165%      +4.3%    2033298 ±162%    +102.0%    3935744 ± 97%  cpuidle.C1.usage
 1.136e+09 ± 88%      +5.4%  1.197e+09 ± 64%     -67.1%  3.736e+08 ±161%  cpuidle.C1E.time
   4064576 ± 90%     +42.0%    5773258 ± 57%     -52.0%    1951003 ±166%  cpuidle.C1E.usage
 5.904e+09 ± 14%      -1.3%  5.829e+09 ±  9%     +10.0%  6.496e+09 ±  7%  cpuidle.C6.time
   8682751 ± 34%     -20.5%    6902053 ±  2%      +0.9%    8764894 ± 37%  cpuidle.C6.usage
      7857 ± 14%     +27.4%      10011 ± 32%    +173.6%      21500 ± 58%  cpuidle.POLL.time
      4281 ± 19%      +9.6%       4694 ± 11%     +48.9%       6377 ± 22%  cpuidle.POLL.usage
      0.00          -100.0%       0.00          -100.0%       0.00        numa-numastat.node0.interleave_hit
    299058 ± 18%      +4.0%     310887 ± 26%     +17.3%     350733 ±  5%  numa-numastat.node0.local_node
    331642 ± 16%      -3.0%     321771 ± 28%     +13.0%     374777 ±  5%  numa-numastat.node0.numa_hit
     32585 ± 35%     -66.6%      10886 ±107%     -26.2%      24045 ± 54%  numa-numastat.node0.other_node
      0.00          -100.0%       0.00          -100.0%       0.00        numa-numastat.node1.interleave_hit
    401552 ± 13%      -2.5%     391705 ± 20%     -11.8%     354135 ±  8%  numa-numastat.node1.local_node
    412619 ± 12%      +2.9%     424478 ± 21%      -9.4%     373757 ±  7%  numa-numastat.node1.numa_hit
     11069 ±105%    +196.1%      32775 ± 35%     +77.3%      19624 ± 66%  numa-numastat.node1.other_node
    301.11            +0.0%     301.12            +0.0%     301.12        time.elapsed_time
    301.11            +0.0%     301.12            +0.0%     301.12        time.elapsed_time.max
      2.75 ± 15%     -18.2%       2.25 ± 19%     -27.3%       2.00 ± 35%  time.involuntary_context_switches
      0.00       +2.5e+101%       0.25 ±173% +2.5e+101%       0.25 ±173%  time.major_page_faults
      9363            +0.1%       9377            -0.2%       9340        time.maximum_resident_set_size
      6346            -0.1%       6341            +0.1%       6351        time.minor_page_faults
      4096            +0.0%       4096            +0.0%       4096        time.page_size
      0.03 ± 23%      -8.3%       0.03 ± 15%      +8.3%       0.03 ± 13%  time.system_time
      0.04 ± 11%     +13.3%       0.04 ± 10%     +13.3%       0.04 ± 10%  time.user_time
     78.75 ±  2%      +3.2%      81.25 ±  2%      +1.9%      80.25        time.voluntary_context_switches
     49.00            +0.0%      49.00            +0.0%      49.00        vmstat.cpu.id
     44.00            +0.0%      44.00            -0.6%      43.75        vmstat.cpu.sy
      6.00           -12.5%       5.25 ±  8%      +0.0%       6.00        vmstat.cpu.us
      0.00          -100.0%       0.00          -100.0%       0.00        vmstat.io.bi
      0.00          -100.0%       0.00          -100.0%       0.00        vmstat.io.bo
   1320991            -0.1%    1319289            +0.0%    1321094        vmstat.memory.cache
 1.131e+08            -0.0%  1.131e+08            +0.0%  1.131e+08        vmstat.memory.free
     23.75            -1.1%      23.50 ±  2%      -1.1%      23.50 ±  2%  vmstat.procs.r
      1444 ±  2%      -0.8%       1432 ±  2%      -2.7%       1406 ±  2%  vmstat.system.cs
     97445            -0.1%      97342            -0.1%      97327        vmstat.system.in
     66448 ±  2%      -2.7%      64632            +0.4%      66698        meminfo.Active
     66448 ±  2%      -2.7%      64632            +0.4%      66698        meminfo.Active(anon)
    161049            -0.5%     160308            +1.3%     163154        meminfo.AnonHugePages
    243172            -0.3%     242331            +0.7%     244931        meminfo.AnonPages
   1239608            -0.1%    1237751            +0.0%    1240036        meminfo.Cached
    199940            +0.0%     199940            +0.0%     199940        meminfo.CmaFree
    204800            +0.0%     204800            +0.0%     204800        meminfo.CmaTotal
  57695224            +0.0%   57695224            +0.0%   57695224        meminfo.CommitLimit
    581913            -0.4%     579726            +0.1%     582241        meminfo.Committed_AS
 1.033e+08            -2.5%  1.007e+08            -0.5%  1.028e+08        meminfo.DirectMap1G
  15760384 ±  7%     +16.7%   18393600 ±  9%      +3.2%   16269824 ± 10%  meminfo.DirectMap2M
    412468 ±  6%      -2.9%     400692 ±  6%      +3.6%     427316 ±  2%  meminfo.DirectMap4k
      2048            +0.0%       2048            +0.0%       2048        meminfo.Hugepagesize
    256010            -0.3%     255199            +0.7%     257786        meminfo.Inactive
    256010            -0.3%     255199            +0.7%     257786        meminfo.Inactive(anon)
     81147            +0.3%      81354            -0.4%      80851        meminfo.KReclaimable
     11619            +0.3%      11654            +0.2%      11641        meminfo.KernelStack
     35049            +0.1%      35072            +0.1%      35074        meminfo.Mapped
 1.126e+08            -0.0%  1.126e+08            +0.0%  1.126e+08        meminfo.MemAvailable
 1.131e+08            -0.0%  1.131e+08            +0.0%  1.131e+08        meminfo.MemFree
 1.154e+08            +0.0%  1.154e+08            +0.0%  1.154e+08        meminfo.MemTotal
   2291983            +0.0%    2293053            -0.1%    2289056        meminfo.Memused
    423.00 ±173%    -100.0%       0.00            -0.1%     422.50 ±173%  meminfo.Mlocked
      3112            -0.5%       3097            +0.4%       3126        meminfo.PageTables
     84297            -0.6%      83769            -0.3%      84072        meminfo.Percpu
     81147            +0.3%      81354            -0.4%      80851        meminfo.SReclaimable
    109653 ±  2%      +2.8%     112763            -1.0%     108555        meminfo.SUnreclaim
     79699            -2.3%      77838            +0.3%      79964        meminfo.Shmem
    190801            +1.7%     194118            -0.7%     189407        meminfo.Slab
   1159969            -0.0%    1159912            +0.0%    1160133        meminfo.Unevictable
 3.436e+10            +0.0%  3.436e+10            +0.0%  3.436e+10        meminfo.VmallocTotal
    139995            +0.7%     140967            -0.6%     139097        meminfo.VmallocUsed
      8403            -0.2%       8383            -0.2%       8386        meminfo.max_used_kB
     12434 ±135%     -78.0%       2729 ± 43%     +66.3%      20673 ± 91%  numa-meminfo.node0.Active
     12434 ±135%     -78.0%       2729 ± 43%     +66.3%      20673 ± 91%  numa-meminfo.node0.Active(anon)
     89160 ± 42%      -4.5%      85171 ± 47%      +8.4%      96620 ± 30%  numa-meminfo.node0.AnonHugePages
    133903 ± 31%      -7.9%     123279 ± 34%      +0.6%     134668 ± 25%  numa-meminfo.node0.AnonPages
    186998 ± 13%     -12.2%     164246 ± 14%     -12.2%     164114 ± 21%  numa-meminfo.node0.AnonPages.max
    598480 ±  5%      -0.4%     596078 ±  2%      +0.5%     601683 ±  3%  numa-meminfo.node0.FilePages
    143689 ± 29%      -9.1%     130556 ± 30%      -0.9%     142401 ± 26%  numa-meminfo.node0.Inactive
    143689 ± 29%      -9.1%     130556 ± 30%      -0.9%     142401 ± 26%  numa-meminfo.node0.Inactive(anon)
     40549 ± 10%      +9.9%      44562 ±  9%      -1.0%      40140 ± 11%  numa-meminfo.node0.KReclaimable
      6122 ±  3%      +0.6%       6156            -0.3%       6105 ±  6%  numa-meminfo.node0.KernelStack
     18407 ± 12%      -6.6%      17183 ± 13%      -5.6%      17379 ± 14%  numa-meminfo.node0.Mapped
  60608553            +0.0%   60617905            +0.0%   60622689        numa-meminfo.node0.MemFree
  61766680            +0.0%   61766680            +0.0%   61766680        numa-meminfo.node0.MemTotal
   1158125 ±  5%      -0.8%    1148774 ±  5%      -1.2%    1143989 ±  4%  numa-meminfo.node0.MemUsed
    181.25 ±173%    -100.0%       0.00            -0.1%     181.00 ±173%  numa-meminfo.node0.Mlocked
      1713 ± 23%      -4.2%       1641 ± 14%     -18.7%       1393 ± 18%  numa-meminfo.node0.PageTables
     40549 ± 10%      +9.9%      44562 ±  9%      -1.0%      40140 ± 11%  numa-meminfo.node0.SReclaimable
     61898 ±  9%      -1.4%      61026 ±  4%     -12.9%      53903 ± 14%  numa-meminfo.node0.SUnreclaim
     22383 ± 83%     -54.7%      10148 ± 45%     +27.6%      28561 ± 69%  numa-meminfo.node0.Shmem
    102448 ±  9%      +3.1%     105589 ±  5%      -8.2%      94043 ± 12%  numa-meminfo.node0.Slab
    576095 ±  3%      +1.7%     585929 ±  2%      -0.5%     573121 ±  3%  numa-meminfo.node0.Unevictable
     54018 ± 32%     +14.5%      61874 ±  2%     -14.8%      46028 ± 40%  numa-meminfo.node1.Active
     54018 ± 32%     +14.5%      61874 ±  2%     -14.8%      46028 ± 40%  numa-meminfo.node1.Active(anon)
     71950 ± 53%      +4.4%      75136 ± 52%      -7.5%      66551 ± 42%  numa-meminfo.node1.AnonHugePages
    109247 ± 38%      +9.0%     119046 ± 34%      +0.9%     110238 ± 30%  numa-meminfo.node1.AnonPages
    176112 ± 16%      -5.2%     166983 ± 25%     -10.6%     157468 ± 25%  numa-meminfo.node1.AnonPages.max
    641182 ±  4%      +0.1%     641688 ±  2%      -0.4%     638387 ±  3%  numa-meminfo.node1.FilePages
    112352 ± 37%     +11.0%     124681 ± 31%      +2.7%     115389 ± 32%  numa-meminfo.node1.Inactive
    112352 ± 37%     +11.0%     124681 ± 31%      +2.7%     115389 ± 32%  numa-meminfo.node1.Inactive(anon)
     40602 ±  9%      -9.4%      36796 ± 11%      +0.3%      40714 ± 12%  numa-meminfo.node1.KReclaimable
      5494 ±  3%      -0.0%       5493 ±  2%      +0.8%       5536 ±  8%  numa-meminfo.node1.KernelStack
     16511 ± 13%      +7.7%      17777 ± 13%      +6.3%      17552 ± 13%  numa-meminfo.node1.Mapped
  52490363            -0.0%   52479733            -0.0%   52478847        numa-meminfo.node1.MemFree
  53623768            +0.0%   53623768            +0.0%   53623768        numa-meminfo.node1.MemTotal
   1133403 ±  5%      +0.9%    1144034 ±  5%      +1.0%    1144919 ±  4%  numa-meminfo.node1.MemUsed
    243.25 ±173%    -100.0%       0.00            -0.7%     241.50 ±173%  numa-meminfo.node1.Mlocked
      1394 ± 27%      +4.4%       1456 ± 17%     +24.5%       1735 ± 17%  numa-meminfo.node1.PageTables
     40602 ±  9%      -9.4%      36796 ± 11%      +0.3%      40714 ± 12%  numa-meminfo.node1.SReclaimable
     47749 ±  8%      +8.3%      51732 ±  6%     +14.4%      54647 ± 14%  numa-meminfo.node1.SUnreclaim
     57369 ± 33%     +18.0%      67705 ±  6%     -10.3%      51436 ± 38%  numa-meminfo.node1.Shmem
     88352 ±  8%      +0.2%      88530 ±  7%      +7.9%      95362 ± 13%  numa-meminfo.node1.Slab
    583873 ±  3%      -1.7%     573982 ±  2%      +0.5%     587011 ±  2%  numa-meminfo.node1.Unevictable
      3116 ±136%     -78.1%     682.00 ± 43%     +66.4%       5183 ± 91%  numa-vmstat.node0.nr_active_anon
     33495 ± 31%      -8.0%      30822 ± 33%      +0.5%      33657 ± 25%  numa-vmstat.node0.nr_anon_pages
     43.25 ± 42%      -4.6%      41.25 ± 47%      +8.1%      46.75 ± 31%  numa-vmstat.node0.nr_anon_transparent_hugepages
    149625 ±  5%      -0.4%     149019 ±  2%      +0.5%     150432 ±  3%  numa-vmstat.node0.nr_file_pages
  15152125            +0.0%   15154498            +0.0%   15155727        numa-vmstat.node0.nr_free_pages
     35940 ± 29%      -9.2%      32642 ± 30%      -1.0%      35587 ± 26%  numa-vmstat.node0.nr_inactive_anon
      0.00          -100.0%       0.00       +2.5e+101%       0.25 ±173%  numa-vmstat.node0.nr_isolated_anon
      6123 ±  3%      +0.6%       6159            -0.4%       6100 ±  6%  numa-vmstat.node0.nr_kernel_stack
      4637 ± 12%      -6.4%       4342 ± 14%      -5.1%       4400 ± 13%  numa-vmstat.node0.nr_mapped
     45.25 ±173%    -100.0%       0.00            -0.6%      45.00 ±173%  numa-vmstat.node0.nr_mlock
    428.00 ± 23%      -4.3%     409.50 ± 14%     -19.1%     346.25 ± 18%  numa-vmstat.node0.nr_page_table_pages
      5601 ± 83%     -54.7%       2536 ± 45%     +27.7%       7152 ± 69%  numa-vmstat.node0.nr_shmem
     10136 ± 10%      +9.9%      11139 ±  9%      -1.0%      10034 ± 11%  numa-vmstat.node0.nr_slab_reclaimable
     15474 ±  9%      -1.4%      15255 ±  4%     -12.9%      13475 ± 14%  numa-vmstat.node0.nr_slab_unreclaimable
    144023 ±  3%      +1.7%     146481 ±  2%      -0.5%     143279 ±  3%  numa-vmstat.node0.nr_unevictable
      3116 ±136%     -78.1%     682.00 ± 43%     +66.4%       5183 ± 91%  numa-vmstat.node0.nr_zone_active_anon
     35940 ± 29%      -9.2%      32642 ± 30%      -1.0%      35587 ± 26%  numa-vmstat.node0.nr_zone_inactive_anon
    144023 ±  3%      +1.7%     146481 ±  2%      -0.5%     143279 ±  3%  numa-vmstat.node0.nr_zone_unevictable
    631829 ± 10%      +4.4%     659357 ± 16%      -0.9%     626203 ± 14%  numa-vmstat.node0.numa_hit
    157825            -0.1%     157714            -0.1%     157710        numa-vmstat.node0.numa_interleave
    595789 ± 11%      -3.7%     573797 ± 19%      -5.6%     562656 ± 19%  numa-vmstat.node0.numa_local
     36039 ± 29%    +137.4%      85559 ± 80%     +76.3%      63546 ± 84%  numa-vmstat.node0.numa_other
     13546 ± 32%     +14.5%      15514 ±  2%     -14.8%      11541 ± 40%  numa-vmstat.node1.nr_active_anon
     27281 ± 38%      +9.0%      29749 ± 34%      +1.0%      27555 ± 30%  numa-vmstat.node1.nr_anon_pages
     34.75 ± 54%      +4.3%      36.25 ± 52%      -7.9%      32.00 ± 42%  numa-vmstat.node1.nr_anon_transparent_hugepages
    160309 ±  4%      +0.1%     160444 ±  2%      -0.4%     159606 ±  3%  numa-vmstat.node1.nr_file_pages
     49985            +0.0%      49985            +0.0%      49985        numa-vmstat.node1.nr_free_cma
  13122613            -0.0%   13119939            -0.0%   13119764        numa-vmstat.node1.nr_free_pages
     28029 ± 37%     +11.1%      31134 ± 31%      +2.8%      28819 ± 32%  numa-vmstat.node1.nr_inactive_anon
      0.00          -100.0%       0.00          -100.0%       0.00        numa-vmstat.node1.nr_isolated_anon
      5494 ±  3%      +0.2%       5503 ±  2%      +0.8%       5536 ±  8%  numa-vmstat.node1.nr_kernel_stack
      4203 ± 13%      +7.3%       4511 ± 14%      +5.4%       4432 ± 13%  numa-vmstat.node1.nr_mapped
     60.75 ±173%    -100.0%       0.00            -0.8%      60.25 ±173%  numa-vmstat.node1.nr_mlock
    348.25 ± 26%      +5.1%     366.00 ± 17%     +24.4%     433.25 ± 16%  numa-vmstat.node1.nr_page_table_pages
     14356 ± 33%     +18.1%      16948 ±  6%     -10.4%      12868 ± 38%  numa-vmstat.node1.nr_shmem
     10149 ±  9%      -9.4%       9198 ± 11%      +0.3%      10178 ± 12%  numa-vmstat.node1.nr_slab_reclaimable
     11936 ±  8%      +8.3%      12932 ±  6%     +14.4%      13661 ± 14%  numa-vmstat.node1.nr_slab_unreclaimable
    145968 ±  3%      -1.7%     143495 ±  2%      +0.5%     146752 ±  2%  numa-vmstat.node1.nr_unevictable
     13546 ± 32%     +14.5%      15514 ±  2%     -14.8%      11541 ± 40%  numa-vmstat.node1.nr_zone_active_anon
     28029 ± 37%     +11.1%      31134 ± 31%      +2.8%      28819 ± 32%  numa-vmstat.node1.nr_zone_inactive_anon
    145968 ±  3%      -1.7%     143495 ±  2%      +0.5%     146752 ±  2%  numa-vmstat.node1.nr_zone_unevictable
    709902 ±  8%      -3.8%     682900 ± 16%      -0.3%     707710 ± 13%  numa-vmstat.node1.numa_hit
    157965            +0.1%     158074            +0.1%     158101        numa-vmstat.node1.numa_interleave
    537233 ± 11%      +4.3%     560075 ± 19%      +4.7%     562613 ± 20%  numa-vmstat.node1.numa_local
    172668 ±  6%     -28.9%     122825 ± 56%     -16.0%     145096 ± 37%  numa-vmstat.node1.numa_other
      0.00          -100.0%       0.00          -100.0%       0.00        proc-vmstat.compact_isolated
     16632 ±  2%      -2.9%      16151            +0.3%      16676        proc-vmstat.nr_active_anon
     60778            -0.3%      60583            +0.7%      61227        proc-vmstat.nr_anon_pages
     78.25            -0.6%      77.75            +1.0%      79.00        proc-vmstat.nr_anon_transparent_hugepages
   2809214            -0.0%    2809179            +0.0%    2809284        proc-vmstat.nr_dirty_background_threshold
   5625298            -0.0%    5625229            +0.0%    5625438        proc-vmstat.nr_dirty_threshold
    309918            -0.2%     309444            +0.0%     310025        proc-vmstat.nr_file_pages
     49985            +0.0%      49985            +0.0%      49985        proc-vmstat.nr_free_cma
  28274763            -0.0%   28274417            +0.0%   28275465        proc-vmstat.nr_free_pages
     63983            -0.3%      63813            +0.7%      64456        proc-vmstat.nr_inactive_anon
      0.25 ±173%      +0.0%       0.25 ±173%    -100.0%       0.00        proc-vmstat.nr_isolated_anon
     11618            +0.4%      11666            +0.2%      11642        proc-vmstat.nr_kernel_stack
      8834            +0.5%       8875            +0.3%       8860        proc-vmstat.nr_mapped
    106.00 ±173%    -100.0%       0.00            -0.5%     105.50 ±173%  proc-vmstat.nr_mlock
    777.50            -0.4%     774.50            +0.5%     781.50        proc-vmstat.nr_page_table_pages
     19941            -2.4%      19466            +0.3%      20007        proc-vmstat.nr_shmem
     20287            +0.3%      20339            -0.4%      20213        proc-vmstat.nr_slab_reclaimable
     27411 ±  2%      +2.8%      28189            -1.0%      27137        proc-vmstat.nr_slab_unreclaimable
    289992            -0.0%     289977            +0.0%     290033        proc-vmstat.nr_unevictable
     16632 ±  2%      -2.9%      16151            +0.3%      16676        proc-vmstat.nr_zone_active_anon
     63983            -0.3%      63813            +0.7%      64456        proc-vmstat.nr_zone_inactive_anon
    289992            -0.0%     289977            +0.0%     290033        proc-vmstat.nr_zone_unevictable
     13701 ± 44%     +25.0%      17122 ± 56%     +23.3%      16899 ± 68%  proc-vmstat.numa_hint_faults
      3617 ± 31%     +15.7%       4184 ± 45%     -19.1%       2924 ± 57%  proc-vmstat.numa_hint_faults_local
    773209            +0.2%     774447            +0.8%     779441        proc-vmstat.numa_hit
    128.50 ± 18%      +8.6%     139.50 ± 27%      +6.8%     137.25 ± 13%  proc-vmstat.numa_huge_pte_updates
      0.00          -100.0%       0.00          -100.0%       0.00        proc-vmstat.numa_interleave
    729544            +0.2%     730778            +0.9%     735763        proc-vmstat.numa_local
     43665            +0.0%      43669            +0.0%      43678        proc-vmstat.numa_other
     22735 ± 20%     -25.6%      16924 ± 63%     -24.1%      17250 ± 67%  proc-vmstat.numa_pages_migrated
    102986 ±  8%     +20.5%     124067 ± 12%     +15.2%     118602 ± 15%  proc-vmstat.numa_pte_updates
     24310 ±  2%      -2.4%      23729            -0.2%      24268        proc-vmstat.pgactivate
      0.00          -100.0%       0.00          -100.0%       0.00        proc-vmstat.pgalloc_dma
      0.00          -100.0%       0.00          -100.0%       0.00        proc-vmstat.pgalloc_dma32
    840269            -0.8%     833139            -0.5%     836309        proc-vmstat.pgalloc_normal
    914293            +0.3%     917239            +0.2%     915801        proc-vmstat.pgfault
    822698            -0.7%     816568            -0.6%     817626        proc-vmstat.pgfree
     22735 ± 20%     -25.6%      16924 ± 63%     -24.1%      17250 ± 67%  proc-vmstat.pgmigrate_success
      0.00          -100.0%       0.00          -100.0%       0.00        proc-vmstat.pgpgin
      0.00          -100.0%       0.00          -100.0%       0.00        proc-vmstat.pgpgout
     53809            +1.2%      54473 ±  2%      -1.1%      53219        proc-vmstat.pgreuse
     96.25            +0.8%      97.00            +0.8%      97.00        proc-vmstat.thp_collapse_alloc
      4.00            +0.0%       4.00            +0.0%       4.00        proc-vmstat.thp_deferred_split_page
      6.00 ± 11%     -12.5%       5.25 ±  8%      +4.2%       6.25 ±  6%  proc-vmstat.thp_fault_alloc
      4.00            +0.0%       4.00            +0.0%       4.00        proc-vmstat.thp_split_pmd
      0.00          -100.0%       0.00          -100.0%       0.00        proc-vmstat.thp_zero_page_alloc
     31.50 ±120%     -66.7%      10.50 ±  4%      +2.4%      32.25 ±115%  proc-vmstat.unevictable_pgs_culled
    146.50 ±173%    -100.0%       0.00            +0.0%     146.50 ±173%  proc-vmstat.unevictable_pgs_mlocked
      0.00          -100.0%       0.00          -100.0%       0.00        proc-vmstat.unevictable_pgs_rescued
   1145664            -0.2%    1143168            +0.1%    1146432        proc-vmstat.unevictable_pgs_scanned
      0.09 ± 21%      -6.0%       0.08 ± 17%     +14.1%       0.10 ± 30%  perf-stat.i.MPKI
 2.349e+10            +4.2%  2.449e+10            -0.3%  2.342e+10        perf-stat.i.branch-instructions
      0.21            -0.0        0.19            -0.0        0.21 ±  2%  perf-stat.i.branch-miss-rate%
  45979592            -6.1%   43181339            -0.5%   45737128        perf-stat.i.branch-misses
      2.32 ± 19%      +0.1        2.46 ±  5%     +11.4       13.75 ±140%  perf-stat.i.cache-miss-rate%
    218573 ±  7%      -3.6%     210638 ±  4%    +584.5%    1496037 ±146%  perf-stat.i.cache-misses
   7307239 ± 24%     -13.4%    6330199 ±  2%      +3.4%    7555492 ± 30%  perf-stat.i.cache-references
      1423 ±  3%      -1.0%       1408 ±  2%      -2.8%       1383 ±  2%  perf-stat.i.context-switches
      0.73            +1.0%       0.74            +2.8%       0.75        perf-stat.i.cpi
     48003            -0.0%      48002            -0.0%      48001        perf-stat.i.cpu-clock
  7.24e+10            -0.2%  7.227e+10            -0.1%  7.231e+10        perf-stat.i.cpu-cycles
     50.77            -0.0%      50.76            -0.0%      50.76        perf-stat.i.cpu-migrations
    611739 ±  3%      +2.3%     625658 ±  2%     -23.4%     468750 ± 56%  perf-stat.i.cycles-between-cache-misses
      0.17 ±  5%      -0.0        0.17 ±  6%      +0.0        0.18 ±  3%  perf-stat.i.dTLB-load-miss-rate%
  41247252 ±  5%      -2.9%   40056676 ±  6%      -2.3%   40280004 ±  3%  perf-stat.i.dTLB-load-misses
  2.36e+10            -2.4%  2.304e+10            -3.3%  2.282e+10        perf-stat.i.dTLB-loads
      0.10 ±  4%      -0.0        0.09            -0.0        0.10        perf-stat.i.dTLB-store-miss-rate%
  14580547 ±  4%      -8.3%   13364460            -3.2%   14117340        perf-stat.i.dTLB-store-misses
 1.432e+10            -0.3%  1.428e+10            -0.2%   1.43e+10        perf-stat.i.dTLB-stores
     95.47            +0.2       95.64            +0.2       95.70        perf-stat.i.iTLB-load-miss-rate%
   7364953            -5.1%    6985875            +0.7%    7419968        perf-stat.i.iTLB-load-misses
    346056 ±  3%      -8.7%     315837            -4.5%     330589        perf-stat.i.iTLB-loads
 9.903e+10            -1.1%  9.791e+10            -2.8%  9.624e+10        perf-stat.i.instructions
     13434            +4.3%      14007            -3.5%      12964        perf-stat.i.instructions-per-iTLB-miss
      1.37            -1.0%       1.35            -2.7%       1.33        perf-stat.i.ipc
      0.45 ± 12%      -0.3%       0.45 ± 27%      -5.3%       0.43 ±  6%  perf-stat.i.major-faults
      1.51            -0.2%       1.51            -0.1%       1.51        perf-stat.i.metric.GHz
      1.06 ±  9%     +11.2%       1.17 ±  9%     -19.9%       0.84 ± 48%  perf-stat.i.metric.K/sec
      1279            +0.6%       1287            -1.4%       1261        perf-stat.i.metric.M/sec
      2920            +0.3%       2928            +0.2%       2925        perf-stat.i.minor-faults
     46.34            +0.4       46.70            +0.8       47.17 ±  3%  perf-stat.i.node-load-miss-rate%
     75084 ±  5%      +0.8%      75722 ±  7%   +1167.6%     951736 ±159%  perf-stat.i.node-load-misses
    106550 ±  3%      -4.9%     101296 ±  3%    +863.7%    1026848 ±145%  perf-stat.i.node-loads
     25.89 ± 22%      +6.2       32.12 ± 16%      +4.2       30.12 ± 24%  perf-stat.i.node-store-miss-rate%
     32810 ± 17%     +20.5%      39528 ± 12%    +830.8%     305388 ±154%  perf-stat.i.node-store-misses
     94127 ±  5%      -1.1%      93133 ±  2%    +429.9%     498821 ±140%  perf-stat.i.node-stores
      2920            +0.3%       2929            +0.2%       2925        perf-stat.i.page-faults
     48003            -0.0%      48002            -0.0%      48001        perf-stat.i.task-clock
      0.07 ± 24%     -12.4%       0.06 ±  2%      +6.6%       0.08 ± 30%  perf-stat.overall.MPKI
      0.20            -0.0        0.18            -0.0        0.20        perf-stat.overall.branch-miss-rate%
      3.17 ± 22%      +0.2        3.34 ±  7%     +11.1       14.29 ±129%  perf-stat.overall.cache-miss-rate%
      0.73            +1.0%       0.74            +2.8%       0.75        perf-stat.overall.cpi
    332596 ±  7%      +3.2%     343294 ±  5%     -27.0%     242950 ± 55%  perf-stat.overall.cycles-between-cache-misses
      0.17 ±  5%      -0.0        0.17 ±  6%      +0.0        0.18 ±  3%  perf-stat.overall.dTLB-load-miss-rate%
      0.10 ±  4%      -0.0        0.09            -0.0        0.10        perf-stat.overall.dTLB-store-miss-rate%
     95.51            +0.2       95.67            +0.2       95.73        perf-stat.overall.iTLB-load-miss-rate%
     13447            +4.2%      14016            -3.5%      12971        perf-stat.overall.instructions-per-iTLB-miss
      1.37            -1.0%       1.35            -2.7%       1.33        perf-stat.overall.ipc
     41.32 ±  2%      +1.4       42.73 ±  2%      -2.2       39.11 ± 27%  perf-stat.overall.node-load-miss-rate%
     25.76 ± 14%      +3.9       29.68 ±  7%      +3.6       29.41 ± 21%  perf-stat.overall.node-store-miss-rate%
   4517015            +5.0%    4744020            -2.5%    4403195        perf-stat.overall.path-length
 2.341e+10            +4.2%   2.44e+10            -0.3%  2.334e+10        perf-stat.ps.branch-instructions
  45857713            -6.1%   43060109            -0.6%   45589839        perf-stat.ps.branch-misses
    218128 ±  7%      -3.6%     210355 ±  4%    +583.6%    1491074 ±146%  perf-stat.ps.cache-misses
   7284852 ± 24%     -13.4%    6310703 ±  2%      +3.4%    7529832 ± 29%  perf-stat.ps.cache-references
      1418 ±  2%      -1.0%       1404 ±  2%      -2.8%       1378 ±  2%  perf-stat.ps.context-switches
     47839            +0.0%      47839            -0.0%      47838        perf-stat.ps.cpu-clock
 7.216e+10            -0.2%  7.203e+10            -0.1%  7.206e+10        perf-stat.ps.cpu-cycles
     50.61            +0.0%      50.63            -0.0%      50.60        perf-stat.ps.cpu-migrations
  41104998 ±  5%      -2.9%   39920499 ±  6%      -2.3%   40142870 ±  3%  perf-stat.ps.dTLB-load-misses
 2.352e+10            -2.4%  2.296e+10            -3.3%  2.274e+10        perf-stat.ps.dTLB-loads
  14530174 ±  4%      -8.3%   13319056            -3.2%   14069255        perf-stat.ps.dTLB-store-misses
 1.427e+10            -0.3%  1.423e+10            -0.2%  1.425e+10        perf-stat.ps.dTLB-stores
   7339560            -5.1%    6961988            +0.7%    7394505        perf-stat.ps.iTLB-load-misses
    344856 ±  3%      -8.7%     314759            -4.5%     329476        perf-stat.ps.iTLB-loads
 9.869e+10            -1.1%  9.758e+10            -2.8%  9.592e+10        perf-stat.ps.instructions
      0.45 ± 12%      -0.6%       0.45 ± 27%      -5.8%       0.43 ±  6%  perf-stat.ps.major-faults
      2910            +0.3%       2919            +0.2%       2915        perf-stat.ps.minor-faults
     74922 ±  4%      +1.1%      75756 ±  7%   +1165.9%     948473 ±159%  perf-stat.ps.node-load-misses
    106317 ±  2%      -4.7%     101350 ±  3%    +863.0%    1023826 ±145%  perf-stat.ps.node-loads
     32700 ± 17%     +20.5%      39411 ± 12%    +830.7%     304348 ±154%  perf-stat.ps.node-store-misses
     93806 ±  5%      -1.0%      92850          +429.9%     497064 ±140%  perf-stat.ps.node-stores
      2910            +0.3%       2919            +0.2%       2916        perf-stat.ps.page-faults
     47839            +0.0%      47839            -0.0%      47838        perf-stat.ps.task-clock
 2.981e+13            -1.0%   2.95e+13            -2.7%    2.9e+13        perf-stat.total.instructions
      9.44 ±173%    +275.5%      35.44 ±112%    -100.0%       0.00        sched_debug.cfs_rq:/.MIN_vruntime.avg
    453.06 ±173%    +153.7%       1149 ±100%    -100.0%       0.00        sched_debug.cfs_rq:/.MIN_vruntime.max
      0.00            +0.0%       0.00            +0.0%       0.00        sched_debug.cfs_rq:/.MIN_vruntime.min
     64.71 ±173%    +199.0%     193.50 ±103%    -100.0%       0.00        sched_debug.cfs_rq:/.MIN_vruntime.stddev
     23412 ±  9%      -1.8%      22980 ±  5%      -3.6%      22559 ±  2%  sched_debug.cfs_rq:/.load.avg
    135906 ± 68%     -29.7%      95590 ± 90%     -68.7%      42523 ±  2%  sched_debug.cfs_rq:/.load.max
     31541 ± 40%     -19.1%      25501 ± 47%     -40.8%      18661        sched_debug.cfs_rq:/.load.stddev
     40.80 ±  9%      -6.9%      37.97 ±  7%     -22.5%      31.61 ±  6%  sched_debug.cfs_rq:/.load_avg.avg
    263.97 ± 31%      +2.7%     271.00 ± 28%     -21.0%     208.57 ±  9%  sched_debug.cfs_rq:/.load_avg.max
     71.12 ± 16%      -4.6%      67.86 ± 14%     -27.4%      51.63 ± 12%  sched_debug.cfs_rq:/.load_avg.stddev
      9.44 ±173%    +275.5%      35.44 ±112%    -100.0%       0.00        sched_debug.cfs_rq:/.max_vruntime.avg
    453.06 ±173%    +153.7%       1149 ±100%    -100.0%       0.00        sched_debug.cfs_rq:/.max_vruntime.max
      0.00            +0.0%       0.00            +0.0%       0.00        sched_debug.cfs_rq:/.max_vruntime.min
     64.71 ±173%    +199.0%     193.50 ±103%    -100.0%       0.00        sched_debug.cfs_rq:/.max_vruntime.stddev
   1790069 ± 14%      -2.4%    1746347 ± 10%      +9.7%    1963642 ± 10%  sched_debug.cfs_rq:/.min_vruntime.avg
   3324871 ± 10%      -5.5%    3141815 ± 10%      +5.5%    3506477 ±  9%  sched_debug.cfs_rq:/.min_vruntime.max
     10305 ± 12%      +9.2%      11251 ±  5%     +10.9%      11429 ± 13%  sched_debug.cfs_rq:/.min_vruntime.min
   1553952 ± 10%      -4.4%    1484815 ± 11%      +4.1%    1618422 ±  9%  sched_debug.cfs_rq:/.min_vruntime.stddev
      0.54 ±  4%      +2.0%       0.55            +4.8%       0.57 ±  2%  sched_debug.cfs_rq:/.nr_running.avg
      1.05 ±  8%      +0.0%       1.05 ±  8%      -4.8%       1.00        sched_debug.cfs_rq:/.nr_running.max
      0.49            -1.8%       0.48 ±  2%      -2.0%       0.48        sched_debug.cfs_rq:/.nr_running.stddev
     11.54 ± 34%     -30.7%       8.00 ± 38%     -92.3%       0.89 ±173%  sched_debug.cfs_rq:/.removed.load_avg.avg
    187.73 ±  9%      +2.7%     192.82 ±  6%     -77.3%      42.67 ±173%  sched_debug.cfs_rq:/.removed.load_avg.max
     44.04 ± 18%     -14.7%      37.55 ± 20%     -86.2%       6.09 ±173%  sched_debug.cfs_rq:/.removed.load_avg.stddev
      3.41 ± 25%     -31.8%       2.32 ± 59%     -91.5%       0.29 ±173%  sched_debug.cfs_rq:/.removed.runnable_avg.avg
     80.41 ± 12%     -16.4%      67.22 ± 35%     -82.6%      13.96 ±173%  sched_debug.cfs_rq:/.removed.runnable_avg.max
     14.60 ± 17%     -23.4%      11.18 ± 41%     -86.3%       1.99 ±173%  sched_debug.cfs_rq:/.removed.runnable_avg.stddev
      3.41 ± 25%     -32.5%       2.30 ± 60%     -91.5%       0.29 ±173%  sched_debug.cfs_rq:/.removed.util_avg.avg
     80.26 ± 13%     -17.4%      66.27 ± 38%     -82.6%      13.96 ±173%  sched_debug.cfs_rq:/.removed.util_avg.max
     14.58 ± 18%     -24.2%      11.06 ± 42%     -86.3%       1.99 ±173%  sched_debug.cfs_rq:/.removed.util_avg.stddev
    573.84 ±  4%      +2.6%     588.54 ±  2%      +2.7%     589.46        sched_debug.cfs_rq:/.runnable_avg.avg
      1080 ±  2%      +3.0%       1112 ±  3%      +1.7%       1098 ±  3%  sched_debug.cfs_rq:/.runnable_avg.max
    466.22            +0.4%     468.00            -0.6%     463.42        sched_debug.cfs_rq:/.runnable_avg.stddev
   -693492          -110.5%      72532 ±315%     -17.7%    -570411        sched_debug.cfs_rq:/.spread0.avg
    841329 ±116%     +74.5%    1468000 ± 20%     +15.6%     972419 ±124%  sched_debug.cfs_rq:/.spread0.max
  -2473255           -32.8%   -1662566            +2.0%   -2522613        sched_debug.cfs_rq:/.spread0.min
   1553954 ± 10%      -4.4%    1484816 ± 11%      +4.1%    1618425 ±  9%  sched_debug.cfs_rq:/.spread0.stddev
    573.35 ±  4%      +2.5%     587.65 ±  2%      +2.7%     588.97        sched_debug.cfs_rq:/.util_avg.avg
      1078 ±  2%      +2.9%       1110 ±  3%      +1.7%       1097 ±  2%  sched_debug.cfs_rq:/.util_avg.max
    465.94            +0.4%     467.80            -0.5%     463.48        sched_debug.cfs_rq:/.util_avg.stddev
    463.83 ±  6%      -8.5%     424.22 ±  8%      +2.6%     475.81 ±  4%  sched_debug.cfs_rq:/.util_est_enqueued.avg
      1025            +0.0%       1025            -2.3%       1001 ±  4%  sched_debug.cfs_rq:/.util_est_enqueued.max
    444.77            -4.1%     426.39 ±  4%      -0.9%     440.91        sched_debug.cfs_rq:/.util_est_enqueued.stddev
    788292 ±  2%      +3.4%     815300 ±  3%      +1.3%     798398        sched_debug.cpu.avg_idle.avg
   1000000            +4.1%    1041499 ±  4%      +1.9%    1019410 ±  3%  sched_debug.cpu.avg_idle.max
    332075 ± 14%     -19.3%     268045 ± 32%     -31.1%     228635 ± 28%  sched_debug.cpu.avg_idle.min
    183312 ±  6%      -5.4%     173435 ± 12%      +7.2%     196523 ±  6%  sched_debug.cpu.avg_idle.stddev
    158355 ±  9%      -4.5%     151305 ±  8%      +4.5%     165555 ±  7%  sched_debug.cpu.clock.avg
    158358 ±  9%      -4.5%     151307 ±  8%      +4.5%     165557 ±  7%  sched_debug.cpu.clock.max
    158352 ±  9%      -4.5%     151302 ±  8%      +4.5%     165552 ±  7%  sched_debug.cpu.clock.min
      1.49 ±  2%      +3.1%       1.54 ±  4%      +2.0%       1.52 ±  2%  sched_debug.cpu.clock.stddev
    156877 ±  9%      -4.5%     149877 ±  8%      +4.5%     164003 ±  7%  sched_debug.cpu.clock_task.avg
    157133 ±  9%      -4.4%     150160 ±  8%      +4.6%     164289 ±  7%  sched_debug.cpu.clock_task.max
    152998 ±  9%      -4.5%     146134 ±  8%      +4.8%     160273 ±  8%  sched_debug.cpu.clock_task.min
    646.41 ±  5%      -4.5%     617.05 ±  5%      -2.2%     632.02 ±  7%  sched_debug.cpu.clock_task.stddev
      1081            -1.7%       1062 ±  2%      +1.1%       1092        sched_debug.cpu.curr->pid.avg
      5344 ±  6%      -3.3%       5168 ±  6%      +3.5%       5532 ±  5%  sched_debug.cpu.curr->pid.max
      1186 ±  3%      -2.1%       1161 ±  2%      +1.1%       1200 ±  2%  sched_debug.cpu.curr->pid.stddev
    500307            +0.0%     500536            +0.3%     501946        sched_debug.cpu.max_idle_balance_cost.avg
    514770 ±  4%      +2.1%     525762 ±  5%     +10.4%     568130 ± 16%  sched_debug.cpu.max_idle_balance_cost.max
    500000            +0.0%     500000            +0.0%     500000        sched_debug.cpu.max_idle_balance_cost.min
      2109 ±173%     +74.4%       3679 ±112%    +380.2%      10130 ±139%  sched_debug.cpu.max_idle_balance_cost.stddev
      4294            -0.0%       4294            +0.0%       4294        sched_debug.cpu.next_balance.avg
      4294            -0.0%       4294            +0.0%       4294        sched_debug.cpu.next_balance.max
      4294            -0.0%       4294            +0.0%       4294        sched_debug.cpu.next_balance.min
      0.00 ± 15%     +15.5%       0.00 ± 40%     +14.7%       0.00 ± 30%  sched_debug.cpu.next_balance.stddev
      0.50            -1.6%       0.50            +0.5%       0.51        sched_debug.cpu.nr_running.avg
      1.09 ±  8%      +5.3%       1.15 ± 14%      -8.4%       1.00        sched_debug.cpu.nr_running.max
      0.50            -0.3%       0.50            -1.0%       0.49        sched_debug.cpu.nr_running.stddev
      6162 ±  7%      -4.0%       5914 ±  6%      +1.1%       6229 ±  6%  sched_debug.cpu.nr_switches.avg
     36915 ± 13%      +5.5%      38950 ±  8%      +2.3%      37775 ± 18%  sched_debug.cpu.nr_switches.max
      1264 ±  6%      -4.0%       1214 ±  5%      -0.7%       1255 ± 10%  sched_debug.cpu.nr_switches.min
      6813 ±  8%      -2.0%       6678 ±  3%      +0.2%       6827 ± 14%  sched_debug.cpu.nr_switches.stddev
      0.00 ±100%    -100.0%       0.00           -54.5%       0.00 ±173%  sched_debug.cpu.nr_uninterruptible.avg
     24.34 ± 36%     -29.3%      17.20 ± 26%     -33.2%      16.25 ± 27%  sched_debug.cpu.nr_uninterruptible.max
    -13.54           -17.3%     -11.20           -20.6%     -10.75        sched_debug.cpu.nr_uninterruptible.min
      6.34 ± 31%     -13.2%       5.50 ± 13%     -14.2%       5.44 ±  9%  sched_debug.cpu.nr_uninterruptible.stddev
    158353 ±  9%      -4.5%     151302 ±  8%      +4.5%     165552 ±  7%  sched_debug.cpu_clk
    996147            +0.0%     996147            +0.0%     996147        sched_debug.dl_rq:.dl_bw->bw.avg
    996147            +0.0%     996147            +0.0%     996147        sched_debug.dl_rq:.dl_bw->bw.max
    996147            +0.0%     996147            +0.0%     996147        sched_debug.dl_rq:.dl_bw->bw.min
 4.295e+09            -0.0%  4.295e+09            +0.0%  4.295e+09        sched_debug.jiffies
    157871 ±  9%      -4.5%     150820 ±  8%      +4.6%     165071 ±  7%  sched_debug.ktime
    950.00            +0.0%     950.00            +0.0%     950.00        sched_debug.rt_rq:/.rt_runtime.avg
    950.00            +0.0%     950.00            +0.0%     950.00        sched_debug.rt_rq:/.rt_runtime.max
    950.00            +0.0%     950.00            +0.0%     950.00        sched_debug.rt_rq:/.rt_runtime.min
    158754 ±  9%      -4.4%     151712 ±  8%      +4.6%     166002 ±  7%  sched_debug.sched_clk
      1.00            +0.0%       1.00            +0.0%       1.00        sched_debug.sched_clock_stable()
   4139835            +0.0%    4139835            +0.0%    4139835        sched_debug.sysctl_sched.sysctl_sched_features
     24.00            +0.0%      24.00            +0.0%      24.00        sched_debug.sysctl_sched.sysctl_sched_latency
      3.00            +0.0%       3.00            +0.0%       3.00        sched_debug.sysctl_sched.sysctl_sched_min_granularity
      1.00            +0.0%       1.00            +0.0%       1.00        sched_debug.sysctl_sched.sysctl_sched_tunable_scaling
      4.00            +0.0%       4.00            +0.0%       4.00        sched_debug.sysctl_sched.sysctl_sched_wakeup_granularity
      0.01 ±  5%      +9.7%       0.01 ±  5%      +6.5%       0.01 ±  5%  perf-sched.sch_delay.avg.ms.__sched_text_start.__sched_text_start.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.01 ±  8%     +21.4%       0.01 ±  6%     +19.0%       0.01 ±  3%  perf-sched.sch_delay.avg.ms.__sched_text_start.__sched_text_start.devkmsg_read.vfs_read.ksys_read
      0.01            -3.1%       0.01 ±  5%      -3.1%       0.01 ±  5%  perf-sched.sch_delay.avg.ms.__sched_text_start.__sched_text_start.do_nanosleep.hrtimer_nanosleep.__x64_sys_nanosleep
      0.01 ± 22%      +7.0%       0.01 ±  4%      +2.3%       0.01 ± 11%  perf-sched.sch_delay.avg.ms.__sched_text_start.__sched_text_start.do_syslog.part.0
      0.01            +4.2%       0.01 ±  6%      +0.0%       0.01        perf-sched.sch_delay.avg.ms.__sched_text_start.__sched_text_start.do_task_dead.do_exit.do_group_exit
      0.01            +6.3%       0.01 ±  5%      +3.1%       0.01 ±  5%  perf-sched.sch_delay.avg.ms.__sched_text_start.__sched_text_start.do_wait.kernel_wait4.__do_sys_wait4
      0.00        +1.3e+99%       0.00 ±173%  +1.3e+99%       0.00 ±173%  perf-sched.sch_delay.avg.ms.__sched_text_start.__sched_text_start.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_exc_page_fault
      0.00 ±173%    -100.0%       0.00          -100.0%       0.00        perf-sched.sch_delay.avg.ms.__sched_text_start.__sched_text_start.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt
      0.00        +2.5e+99%       0.00 ±173%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__sched_text_start.__sched_text_start.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_call_function_single
      0.01 ± 20%      -3.8%       0.01 ± 11%      -1.9%       0.01 ±  7%  perf-sched.sch_delay.avg.ms.__sched_text_start.__sched_text_start.futex_wait_queue_me.futex_wait.do_futex
      0.00 ±173%    -100.0%       0.00          -100.0%       0.00        perf-sched.sch_delay.avg.ms.__sched_text_start.__sched_text_start.io_schedule.put_and_wait_on_page_locked.do_swap_page
      0.00            +0.0%       0.00            +0.0%       0.00        perf-sched.sch_delay.avg.ms.__sched_text_start.__sched_text_start.pipe_read.new_sync_read.vfs_read
      0.00        +1.5e+99%       0.00 ±173%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__sched_text_start.__sched_text_start.preempt_schedule_common._cond_resched.dput
      0.00 ±173%    -100.0%       0.00          -100.0%       0.00        perf-sched.sch_delay.avg.ms.__sched_text_start.__sched_text_start.preempt_schedule_common._cond_resched.generic_file_buffered_read
      9.39 ± 57%     -77.9%       2.08 ±173%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__sched_text_start.__sched_text_start.preempt_schedule_common._cond_resched.mutex_lock
      0.00          -100.0%       0.00        +2.5e+98%       0.00 ±173%  perf-sched.sch_delay.avg.ms.__sched_text_start.__sched_text_start.preempt_schedule_common._cond_resched.stop_one_cpu
      0.00          -100.0%       0.00        +1.3e+99%       0.00 ±173%  perf-sched.sch_delay.avg.ms.__sched_text_start.__sched_text_start.preempt_schedule_common._cond_resched.zap_pte_range
      0.00 ± 57%     +11.1%       0.01 ± 58%     +44.4%       0.01 ±  7%  perf-sched.sch_delay.avg.ms.__sched_text_start.__sched_text_start.rcu_gp_kthread.kthread.ret_from_fork
      0.01 ±  8%      +2.6%       0.01            +2.6%       0.01 ±  7%  perf-sched.sch_delay.avg.ms.__sched_text_start.__sched_text_start.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait
      0.00 ± 23%     +50.0%       0.00 ± 11%      +0.0%       0.00 ± 23%  perf-sched.sch_delay.avg.ms.__sched_text_start.__sched_text_start.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop
      0.01 ± 26%     -12.1%       0.01 ±  5%     -15.2%       0.01        perf-sched.sch_delay.avg.ms.__sched_text_start.__sched_text_start.schedule_timeout.kcompactd.kthread
      0.01 ±111%    -100.0%       0.00            -3.2%       0.01 ± 57%  perf-sched.sch_delay.avg.ms.__sched_text_start.__sched_text_start.schedule_timeout.khugepaged.kthread
      0.01 ± 13%      -7.7%       0.01            +3.8%       0.01 ± 19%  perf-sched.sch_delay.avg.ms.__sched_text_start.__sched_text_start.schedule_timeout.rcu_gp_kthread.kthread
      0.01 ± 68%     -41.3%       0.01 ±  6%     -28.3%       0.01 ± 26%  perf-sched.sch_delay.avg.ms.__sched_text_start.__sched_text_start.schedule_timeout.wait_for_completion.__flush_work
      0.02 ±  7%    +241.5%       0.06 ±117%      -3.1%       0.02 ± 12%  perf-sched.sch_delay.avg.ms.__sched_text_start.__sched_text_start.smpboot_thread_fn.kthread.ret_from_fork
      0.01            -8.3%       0.01 ±  9%      -8.3%       0.01 ±  9%  perf-sched.sch_delay.avg.ms.__sched_text_start.__sched_text_start.wait_for_partner.fifo_open.do_dentry_open
      0.02 ± 50%     +53.1%       0.03 ± 46%     +97.5%       0.04 ±  5%  perf-sched.sch_delay.avg.ms.__sched_text_start.__sched_text_start.worker_thread.kthread.ret_from_fork
      0.01           +13.9%       0.01 ± 15%      +8.3%       0.01 ±  8%  perf-sched.sch_delay.max.ms.__sched_text_start.__sched_text_start.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.02 ± 17%     +16.7%       0.02 ±  8%     +21.2%       0.02 ±  6%  perf-sched.sch_delay.max.ms.__sched_text_start.__sched_text_start.devkmsg_read.vfs_read.ksys_read
      0.01 ± 32%     -14.3%       0.01 ± 39%     -26.8%       0.01 ± 21%  perf-sched.sch_delay.max.ms.__sched_text_start.__sched_text_start.do_nanosleep.hrtimer_nanosleep.__x64_sys_nanosleep
      0.02 ± 34%      -7.6%       0.02 ± 18%     -24.1%       0.01 ± 16%  perf-sched.sch_delay.max.ms.__sched_text_start.__sched_text_start.do_syslog.part.0
      0.02 ± 21%     +16.1%       0.03 ± 36%     -19.5%       0.02 ±  4%  perf-sched.sch_delay.max.ms.__sched_text_start.__sched_text_start.do_task_dead.do_exit.do_group_exit
      0.04 ±  9%     -22.5%       0.03 ± 11%     -25.4%       0.03 ± 18%  perf-sched.sch_delay.max.ms.__sched_text_start.__sched_text_start.do_wait.kernel_wait4.__do_sys_wait4
      0.00        +1.3e+99%       0.00 ±173%  +1.3e+99%       0.00 ±173%  perf-sched.sch_delay.max.ms.__sched_text_start.__sched_text_start.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_exc_page_fault
      0.00 ±102%     -58.3%       0.00 ±173%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__sched_text_start.__sched_text_start.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt
      0.00        +2.5e+99%       0.00 ±173%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__sched_text_start.__sched_text_start.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_call_function_single
      0.01 ±  5%      -1.7%       0.01 ±  5%      -3.4%       0.01 ±  7%  perf-sched.sch_delay.max.ms.__sched_text_start.__sched_text_start.exit_to_user_mode_prepare.syscall_exit_to_user_mode.entry_SYSCALL_64_after_hwframe
      0.02 ± 30%      -7.6%       0.02 ± 10%      -3.8%       0.02 ± 31%  perf-sched.sch_delay.max.ms.__sched_text_start.__sched_text_start.futex_wait_queue_me.futex_wait.do_futex
      0.00 ±173%    -100.0%       0.00          -100.0%       0.00        perf-sched.sch_delay.max.ms.__sched_text_start.__sched_text_start.io_schedule.put_and_wait_on_page_locked.do_swap_page
      0.03 ±  7%      -8.5%       0.03 ±  9%     -17.1%       0.02 ±  8%  perf-sched.sch_delay.max.ms.__sched_text_start.__sched_text_start.pipe_read.new_sync_read.vfs_read
      0.00 ±173%    -100.0%       0.00          -100.0%       0.00        perf-sched.sch_delay.max.ms.__sched_text_start.__sched_text_start.preempt_schedule_common._cond_resched.__kmalloc
      0.00        +1.5e+99%       0.00 ±173%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__sched_text_start.__sched_text_start.preempt_schedule_common._cond_resched.dput
      0.00 ±173%    -100.0%       0.00          -100.0%       0.00        perf-sched.sch_delay.max.ms.__sched_text_start.__sched_text_start.preempt_schedule_common._cond_resched.generic_file_buffered_read
      9.39 ± 57%     -66.7%       3.13 ±173%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__sched_text_start.__sched_text_start.preempt_schedule_common._cond_resched.mutex_lock
      0.02 ±  6%      +6.6%       0.02 ± 13%    +836.8%       0.18 ±155%  perf-sched.sch_delay.max.ms.__sched_text_start.__sched_text_start.preempt_schedule_common._cond_resched.stop_one_cpu
      0.00          -100.0%       0.00        +1.3e+99%       0.00 ±173%  perf-sched.sch_delay.max.ms.__sched_text_start.__sched_text_start.preempt_schedule_common._cond_resched.zap_pte_range
      0.01 ± 59%     +17.4%       0.01 ± 57%     +73.9%       0.01 ± 30%  perf-sched.sch_delay.max.ms.__sched_text_start.__sched_text_start.rcu_gp_kthread.kthread.ret_from_fork
      0.03 ± 54%     -23.4%       0.02 ± 10%     -26.1%       0.02 ±  8%  perf-sched.sch_delay.max.ms.__sched_text_start.__sched_text_start.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait
      0.02 ± 28%      -6.3%       0.01 ± 40%     -26.6%       0.01 ± 12%  perf-sched.sch_delay.max.ms.__sched_text_start.__sched_text_start.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop
      0.06 ±137%     -81.6%       0.01 ± 20%     -81.1%       0.01 ± 17%  perf-sched.sch_delay.max.ms.__sched_text_start.__sched_text_start.schedule_timeout.kcompactd.kthread
      0.01 ±111%    -100.0%       0.00            -3.2%       0.01 ± 57%  perf-sched.sch_delay.max.ms.__sched_text_start.__sched_text_start.schedule_timeout.khugepaged.kthread
      1.01 ±170%     -98.0%       0.02 ±  2%     +47.3%       1.49 ±171%  perf-sched.sch_delay.max.ms.__sched_text_start.__sched_text_start.schedule_timeout.rcu_gp_kthread.kthread
      0.01 ± 68%     -41.3%       0.01 ±  6%     -28.3%       0.01 ± 26%  perf-sched.sch_delay.max.ms.__sched_text_start.__sched_text_start.schedule_timeout.wait_for_completion.__flush_work
      6.55 ± 15%    +387.1%      31.90 ±131%      -9.4%       5.93 ± 21%  perf-sched.sch_delay.max.ms.__sched_text_start.__sched_text_start.smpboot_thread_fn.kthread.ret_from_fork
      0.02 ±  4%      +5.9%       0.02 ± 13%      +4.4%       0.02 ± 10%  perf-sched.sch_delay.max.ms.__sched_text_start.__sched_text_start.wait_for_partner.fifo_open.do_dentry_open
      6.19 ± 60%     +52.5%       9.44 ± 57%    +103.7%      12.61        perf-sched.sch_delay.max.ms.__sched_text_start.__sched_text_start.worker_thread.kthread.ret_from_fork
      0.01           +43.7%       0.01 ± 52%      +0.0%       0.01 ±  8%  perf-sched.total_sch_delay.average.ms
     12.55          +183.1%      35.53 ±111%      +0.5%      12.61        perf-sched.total_sch_delay.max.ms
    137.17            +0.3%     137.53            +0.1%     137.26        perf-sched.total_wait_and_delay.average.ms
      7187            -1.3%       7091            -1.0%       7113 ±  2%  perf-sched.total_wait_and_delay.count.ms
      7525 ±  6%      -3.0%       7300            -4.6%       7178        perf-sched.total_wait_and_delay.max.ms
    137.16            +0.3%     137.51            +0.1%     137.26        perf-sched.total_wait_time.average.ms
      7525 ±  6%      -3.0%       7300            -4.6%       7178        perf-sched.total_wait_time.max.ms
    899.70            -0.0%     899.70            -0.0%     899.70        perf-sched.wait_and_delay.avg.ms.__sched_text_start.__sched_text_start.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe
    249.36            +0.9%     251.64            +0.0%     249.42 ±  4%  perf-sched.wait_and_delay.avg.ms.__sched_text_start.__sched_text_start.devkmsg_read.vfs_read.ksys_read
    845.29 ±  2%      -0.8%     838.63 ±  3%      +1.4%     857.19        perf-sched.wait_and_delay.avg.ms.__sched_text_start.__sched_text_start.do_nanosleep.hrtimer_nanosleep.__x64_sys_nanosleep
    249.36            +0.9%     251.64            +0.0%     249.42 ±  4%  perf-sched.wait_and_delay.avg.ms.__sched_text_start.__sched_text_start.do_syslog.part.0
    274.01 ±  5%      -2.5%     267.20            +0.8%     276.30        perf-sched.wait_and_delay.avg.ms.__sched_text_start.__sched_text_start.do_task_dead.do_exit.do_group_exit
      1.15            +1.0%       1.17            +0.5%       1.16        perf-sched.wait_and_delay.avg.ms.__sched_text_start.__sched_text_start.do_wait.kernel_wait4.__do_sys_wait4
      0.01 ±173%     -21.8%       0.01 ±173%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.__sched_text_start.__sched_text_start.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt
      0.77 ±161%     -94.2%       0.04 ± 24%     -91.8%       0.06 ± 35%  perf-sched.wait_and_delay.avg.ms.__sched_text_start.__sched_text_start.exit_to_user_mode_prepare.syscall_exit_to_user_mode.entry_SYSCALL_64_after_hwframe
      0.00       +2.4e+104%     236.10 ±173%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.__sched_text_start.__sched_text_start.futex_wait_queue_me.futex_wait.do_futex
     68.87            -1.1%      68.10            -1.2%      68.03        perf-sched.wait_and_delay.avg.ms.__sched_text_start.__sched_text_start.pipe_read.new_sync_read.vfs_read
      0.01 ±173%    -100.0%       0.00          +283.0%       0.04 ±173%  perf-sched.wait_and_delay.avg.ms.__sched_text_start.__sched_text_start.preempt_schedule_common._cond_resched.__kmalloc
    328.68 ±173%    -100.0%       0.00          +455.7%       1826 ±173%  perf-sched.wait_and_delay.avg.ms.__sched_text_start.__sched_text_start.preempt_schedule_common._cond_resched.generic_perform_write
     18.48 ±  2%      -2.3%      18.06            -1.7%      18.17        perf-sched.wait_and_delay.avg.ms.__sched_text_start.__sched_text_start.preempt_schedule_common._cond_resched.stop_one_cpu
      0.00          -100.0%       0.00       +1.4e+102%       1.37 ±100%  perf-sched.wait_and_delay.avg.ms.__sched_text_start.__sched_text_start.rcu_gp_kthread.kthread.ret_from_fork
    246.58 ± 57%     +47.1%     362.61 ± 17%      +0.0%     246.62 ± 57%  perf-sched.wait_and_delay.avg.ms.__sched_text_start.__sched_text_start.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait
    536.32 ± 23%     +31.1%     703.02 ±  7%      -5.8%     505.05 ±  4%  perf-sched.wait_and_delay.avg.ms.__sched_text_start.__sched_text_start.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop
    478.79            +0.0%     478.79            -0.2%     477.79        perf-sched.wait_and_delay.avg.ms.__sched_text_start.__sched_text_start.schedule_timeout.kcompactd.kthread
      4.94 ±  5%      +2.1%       5.05 ±  6%      +3.1%       5.10 ±  5%  perf-sched.wait_and_delay.avg.ms.__sched_text_start.__sched_text_start.schedule_timeout.rcu_gp_kthread.kthread
    680.47 ±  2%      -0.0%     680.46 ±  2%      -0.5%     677.21 ±  2%  perf-sched.wait_and_delay.avg.ms.__sched_text_start.__sched_text_start.smpboot_thread_fn.kthread.ret_from_fork
      0.01            -8.3%       0.01 ±  9%      -8.3%       0.01 ±  9%  perf-sched.wait_and_delay.avg.ms.__sched_text_start.__sched_text_start.wait_for_partner.fifo_open.do_dentry_open
    388.12 ±  6%      -2.6%     378.01 ±  4%      +1.9%     395.60 ±  4%  perf-sched.wait_and_delay.avg.ms.__sched_text_start.__sched_text_start.worker_thread.kthread.ret_from_fork
     10.00            +0.0%      10.00            +0.0%      10.00        perf-sched.wait_and_delay.count.__sched_text_start.__sched_text_start.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe
      6.00            +0.0%       6.00            +0.0%       6.00        perf-sched.wait_and_delay.count.__sched_text_start.__sched_text_start.devkmsg_read.vfs_read.ksys_read
     21.00            +2.4%      21.50 ±  4%      +0.0%      21.00        perf-sched.wait_and_delay.count.__sched_text_start.__sched_text_start.do_nanosleep.hrtimer_nanosleep.__x64_sys_nanosleep
      6.00            +0.0%       6.00            +0.0%       6.00        perf-sched.wait_and_delay.count.__sched_text_start.__sched_text_start.do_syslog.part.0
    247.00            +0.3%     247.75            +0.0%     247.00        perf-sched.wait_and_delay.count.__sched_text_start.__sched_text_start.do_task_dead.do_exit.do_group_exit
    245.75            +0.3%     246.50            +0.1%     246.00        perf-sched.wait_and_delay.count.__sched_text_start.__sched_text_start.do_wait.kernel_wait4.__do_sys_wait4
      9.25 ±173%      -8.1%       8.50 ±173%    -100.0%       0.00        perf-sched.wait_and_delay.count.__sched_text_start.__sched_text_start.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt
    336.50 ±  8%      -5.5%     318.00 ± 11%      +1.9%     342.75 ± 12%  perf-sched.wait_and_delay.count.__sched_text_start.__sched_text_start.exit_to_user_mode_prepare.syscall_exit_to_user_mode.entry_SYSCALL_64_after_hwframe
      0.00       +1.8e+102%       1.75 ±173%    -100.0%       0.00        perf-sched.wait_and_delay.count.__sched_text_start.__sched_text_start.futex_wait_queue_me.futex_wait.do_futex
      2250            +1.0%       2272            +1.0%       2273        perf-sched.wait_and_delay.count.__sched_text_start.__sched_text_start.pipe_read.new_sync_read.vfs_read
     10.25 ±173%    -100.0%       0.00            -9.8%       9.25 ±173%  perf-sched.wait_and_delay.count.__sched_text_start.__sched_text_start.preempt_schedule_common._cond_resched.__kmalloc
      0.25 ±173%    -100.0%       0.00            +0.0%       0.25 ±173%  perf-sched.wait_and_delay.count.__sched_text_start.__sched_text_start.preempt_schedule_common._cond_resched.generic_perform_write
    576.00            -2.0%     564.25 ±  3%      -2.9%     559.25 ±  3%  perf-sched.wait_and_delay.count.__sched_text_start.__sched_text_start.preempt_schedule_common._cond_resched.stop_one_cpu
      0.00          -100.0%       0.00       +2.1e+103%      21.00 ±100%  perf-sched.wait_and_delay.count.__sched_text_start.__sched_text_start.rcu_gp_kthread.kthread.ret_from_fork
     26.25 ± 57%     +36.2%      35.75 ±  4%      +0.0%      26.25 ± 57%  perf-sched.wait_and_delay.count.__sched_text_start.__sched_text_start.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait
     65.50 ± 17%     -28.2%      47.00 ±  6%      -2.7%      63.75 ± 14%  perf-sched.wait_and_delay.count.__sched_text_start.__sched_text_start.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop
     40.00            +0.0%      40.00            -3.8%      38.50 ±  2%  perf-sched.wait_and_delay.count.__sched_text_start.__sched_text_start.schedule_timeout.kcompactd.kthread
      2016 ±  5%      -2.0%       1975 ±  6%      -3.2%       1952 ±  6%  perf-sched.wait_and_delay.count.__sched_text_start.__sched_text_start.schedule_timeout.rcu_gp_kthread.kthread
    674.00            -1.9%     661.50 ±  3%      -2.4%     658.00 ±  2%  perf-sched.wait_and_delay.count.__sched_text_start.__sched_text_start.smpboot_thread_fn.kthread.ret_from_fork
     72.00            +0.0%      72.00            +0.0%      72.00        perf-sched.wait_and_delay.count.__sched_text_start.__sched_text_start.wait_for_partner.fifo_open.do_dentry_open
    490.75 ±  4%      +0.7%     494.25 ±  3%      +0.8%     494.75 ±  7%  perf-sched.wait_and_delay.count.__sched_text_start.__sched_text_start.worker_thread.kthread.ret_from_fork
    999.69            +0.0%     999.69            +0.0%     999.69        perf-sched.wait_and_delay.max.ms.__sched_text_start.__sched_text_start.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1355 ±  2%      +2.2%       1385            +0.7%       1365 ±  4%  perf-sched.wait_and_delay.max.ms.__sched_text_start.__sched_text_start.devkmsg_read.vfs_read.ksys_read
      1000            -0.0%       1000            -0.0%       1000        perf-sched.wait_and_delay.max.ms.__sched_text_start.__sched_text_start.do_nanosleep.hrtimer_nanosleep.__x64_sys_nanosleep
      1355 ±  2%      +2.2%       1385            +0.7%       1365 ±  4%  perf-sched.wait_and_delay.max.ms.__sched_text_start.__sched_text_start.do_syslog.part.0
      4344 ± 54%     -50.9%       2135 ± 20%      -9.5%       3930 ± 36%  perf-sched.wait_and_delay.max.ms.__sched_text_start.__sched_text_start.do_task_dead.do_exit.do_group_exit
     26.34            +1.3%      26.68            +0.2%      26.39        perf-sched.wait_and_delay.max.ms.__sched_text_start.__sched_text_start.do_wait.kernel_wait4.__do_sys_wait4
      0.04 ±173%      -3.5%       0.03 ±173%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.__sched_text_start.__sched_text_start.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt
    252.42 ±171%     -99.1%       2.23 ±158%     -98.0%       4.95 ± 96%  perf-sched.wait_and_delay.max.ms.__sched_text_start.__sched_text_start.exit_to_user_mode_prepare.syscall_exit_to_user_mode.entry_SYSCALL_64_after_hwframe
      0.00       +1.6e+105%       1621 ±173%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.__sched_text_start.__sched_text_start.futex_wait_queue_me.futex_wait.do_futex
      1355 ±  2%      +2.2%       1385            +0.7%       1365 ±  4%  perf-sched.wait_and_delay.max.ms.__sched_text_start.__sched_text_start.pipe_read.new_sync_read.vfs_read
      0.04 ±173%    -100.0%       0.00         +2826.3%       1.11 ±173%  perf-sched.wait_and_delay.max.ms.__sched_text_start.__sched_text_start.preempt_schedule_common._cond_resched.__kmalloc
    328.68 ±173%    -100.0%       0.00          +455.7%       1826 ±173%  perf-sched.wait_and_delay.max.ms.__sched_text_start.__sched_text_start.preempt_schedule_common._cond_resched.generic_perform_write
      1532 ± 19%     -11.5%       1355 ±  7%     -11.0%       1363 ±  2%  perf-sched.wait_and_delay.max.ms.__sched_text_start.__sched_text_start.preempt_schedule_common._cond_resched.stop_one_cpu
      0.00          -100.0%       0.00       +2.5e+102%       2.50 ±100%  perf-sched.wait_and_delay.max.ms.__sched_text_start.__sched_text_start.rcu_gp_kthread.kthread.ret_from_fork
    750.37 ± 58%    +208.5%       2314 ± 94%      -0.6%     745.92 ± 57%  perf-sched.wait_and_delay.max.ms.__sched_text_start.__sched_text_start.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait
      7175            +1.7%       7300            -6.9%       6683 ± 11%  perf-sched.wait_and_delay.max.ms.__sched_text_start.__sched_text_start.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop
    505.00            -0.0%     504.75            +0.0%     505.00        perf-sched.wait_and_delay.max.ms.__sched_text_start.__sched_text_start.schedule_timeout.kcompactd.kthread
    164.76 ± 56%     -20.0%     131.76 ± 64%     -10.3%     147.75 ± 57%  perf-sched.wait_and_delay.max.ms.__sched_text_start.__sched_text_start.schedule_timeout.rcu_gp_kthread.kthread
      1805 ± 70%      -1.2%       1784 ± 71%     +38.9%       2507 ± 59%  perf-sched.wait_and_delay.max.ms.__sched_text_start.__sched_text_start.smpboot_thread_fn.kthread.ret_from_fork
      0.02 ±  4%      +5.9%       0.02 ± 13%      +4.4%       0.02 ± 10%  perf-sched.wait_and_delay.max.ms.__sched_text_start.__sched_text_start.wait_for_partner.fifo_open.do_dentry_open
      5407 ± 37%      -2.2%       5290 ± 18%     -23.7%       4124 ± 17%  perf-sched.wait_and_delay.max.ms.__sched_text_start.__sched_text_start.worker_thread.kthread.ret_from_fork
    899.69            -0.0%     899.69            -0.0%     899.69        perf-sched.wait_time.avg.ms.__sched_text_start.__sched_text_start.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe
    249.34            +0.9%     251.62            +0.0%     249.40 ±  4%  perf-sched.wait_time.avg.ms.__sched_text_start.__sched_text_start.devkmsg_read.vfs_read.ksys_read
    845.28 ±  2%      -0.8%     838.62 ±  3%      +1.4%     857.19        perf-sched.wait_time.avg.ms.__sched_text_start.__sched_text_start.do_nanosleep.hrtimer_nanosleep.__x64_sys_nanosleep
    249.35            +0.9%     251.63            +0.0%     249.41 ±  4%  perf-sched.wait_time.avg.ms.__sched_text_start.__sched_text_start.do_syslog.part.0
    274.00 ±  5%      -2.5%     267.19            +0.8%     276.30        perf-sched.wait_time.avg.ms.__sched_text_start.__sched_text_start.do_task_dead.do_exit.do_group_exit
      1.15            +0.9%       1.16            +0.5%       1.15        perf-sched.wait_time.avg.ms.__sched_text_start.__sched_text_start.do_wait.kernel_wait4.__do_sys_wait4
      0.06 ± 27%     -13.4%       0.05 ± 27%      -0.8%       0.06 ± 30%  perf-sched.wait_time.avg.ms.__sched_text_start.__sched_text_start.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt
      0.02 ±173%   +1818.2%       0.32 ±147%    +263.6%       0.06 ±100%  perf-sched.wait_time.avg.ms.__sched_text_start.__sched_text_start.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_call_function_single
      0.01 ±173%    -100.0%       0.00           +17.4%       0.01 ±173%  perf-sched.wait_time.avg.ms.__sched_text_start.__sched_text_start.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_irq_work
      0.04 ± 28%     -27.6%       0.03 ± 16%     -11.5%       0.03 ± 24%  perf-sched.wait_time.avg.ms.__sched_text_start.__sched_text_start.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi
      0.77 ±161%     -94.2%       0.04 ± 24%     -91.8%       0.06 ± 36%  perf-sched.wait_time.avg.ms.__sched_text_start.__sched_text_start.exit_to_user_mode_prepare.syscall_exit_to_user_mode.entry_SYSCALL_64_after_hwframe
     44.23 ± 25%    +504.5%     267.36 ±146%      -1.6%      43.52 ±  6%  perf-sched.wait_time.avg.ms.__sched_text_start.__sched_text_start.futex_wait_queue_me.futex_wait.do_futex
      0.01 ±173%    -100.0%       0.00          -100.0%       0.00        perf-sched.wait_time.avg.ms.__sched_text_start.__sched_text_start.io_schedule.__lock_page_killable.filemap_fault
      0.01 ±173%    -100.0%       0.00          -100.0%       0.00        perf-sched.wait_time.avg.ms.__sched_text_start.__sched_text_start.io_schedule.put_and_wait_on_page_locked.do_swap_page
     68.87            -1.1%      68.10            -1.2%      68.03        perf-sched.wait_time.avg.ms.__sched_text_start.__sched_text_start.pipe_read.new_sync_read.vfs_read
      0.05 ±  6%      -8.0%       0.04 ± 25%     +59.6%       0.07 ± 81%  perf-sched.wait_time.avg.ms.__sched_text_start.__sched_text_start.preempt_schedule_common._cond_resched.__kmalloc
    328.68 ±173%    -100.0%       0.00          +455.7%       1826 ±173%  perf-sched.wait_time.avg.ms.__sched_text_start.__sched_text_start.preempt_schedule_common._cond_resched.generic_perform_write
     18.48 ±  2%      -2.3%      18.06            -1.7%      18.17        perf-sched.wait_time.avg.ms.__sched_text_start.__sched_text_start.preempt_schedule_common._cond_resched.stop_one_cpu
      1.95 ± 60%      +7.9%       2.11 ± 60%     +32.5%       2.59 ± 13%  perf-sched.wait_time.avg.ms.__sched_text_start.__sched_text_start.rcu_gp_kthread.kthread.ret_from_fork
    275.42 ± 33%     +31.7%     362.60 ± 17%      +1.0%     278.22 ± 31%  perf-sched.wait_time.avg.ms.__sched_text_start.__sched_text_start.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait
    536.32 ± 23%     +31.1%     703.02 ±  7%      -5.8%     505.04 ±  4%  perf-sched.wait_time.avg.ms.__sched_text_start.__sched_text_start.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop
    478.78            +0.0%     478.78            -0.2%     477.78        perf-sched.wait_time.avg.ms.__sched_text_start.__sched_text_start.schedule_timeout.kcompactd.kthread
      0.01 ± 63%     -63.0%       0.01 ± 20%      +3.7%       0.01 ± 37%  perf-sched.wait_time.avg.ms.__sched_text_start.__sched_text_start.schedule_timeout.khugepaged.kthread
      4.94 ±  5%      +2.1%       5.04 ±  6%      +3.1%       5.09 ±  5%  perf-sched.wait_time.avg.ms.__sched_text_start.__sched_text_start.schedule_timeout.rcu_gp_kthread.kthread
      0.00        +4.3e+99%       0.00 ±173%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__sched_text_start.__sched_text_start.schedule_timeout.wait_for_completion.stop_one_cpu
    680.45 ±  2%      -0.0%     680.41 ±  2%      -0.5%     677.20 ±  2%  perf-sched.wait_time.avg.ms.__sched_text_start.__sched_text_start.smpboot_thread_fn.kthread.ret_from_fork
    388.10 ±  6%      -2.6%     377.98 ±  4%      +1.9%     395.56 ±  4%  perf-sched.wait_time.avg.ms.__sched_text_start.__sched_text_start.worker_thread.kthread.ret_from_fork
    999.68            +0.0%     999.68            -0.0%     999.68        perf-sched.wait_time.max.ms.__sched_text_start.__sched_text_start.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1355 ±  2%      +2.2%       1385            +0.7%       1365 ±  4%  perf-sched.wait_time.max.ms.__sched_text_start.__sched_text_start.devkmsg_read.vfs_read.ksys_read
      1000            +0.0%       1000            +0.0%       1000        perf-sched.wait_time.max.ms.__sched_text_start.__sched_text_start.do_nanosleep.hrtimer_nanosleep.__x64_sys_nanosleep
      1355 ±  2%      +2.2%       1385            +0.7%       1365 ±  4%  perf-sched.wait_time.max.ms.__sched_text_start.__sched_text_start.do_syslog.part.0
      4344 ± 54%     -50.9%       2135 ± 20%      -9.5%       3930 ± 36%  perf-sched.wait_time.max.ms.__sched_text_start.__sched_text_start.do_task_dead.do_exit.do_group_exit
     26.34            +1.3%      26.67            +0.2%      26.39        perf-sched.wait_time.max.ms.__sched_text_start.__sched_text_start.do_wait.kernel_wait4.__do_sys_wait4
      0.17 ± 42%     -38.5%       0.11 ± 40%     -10.0%       0.16 ± 52%  perf-sched.wait_time.max.ms.__sched_text_start.__sched_text_start.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt
      0.02 ±173%   +1389.4%       0.32 ±147%    +184.7%       0.06 ±100%  perf-sched.wait_time.max.ms.__sched_text_start.__sched_text_start.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_call_function_single
      0.01 ±173%    -100.0%       0.00           +17.4%       0.01 ±173%  perf-sched.wait_time.max.ms.__sched_text_start.__sched_text_start.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_irq_work
      0.07 ± 61%     -31.8%       0.05 ± 18%     +78.2%       0.12 ±105%  perf-sched.wait_time.max.ms.__sched_text_start.__sched_text_start.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi
    252.41 ±171%     -99.1%       2.23 ±158%     -98.0%       4.95 ± 96%  perf-sched.wait_time.max.ms.__sched_text_start.__sched_text_start.exit_to_user_mode_prepare.syscall_exit_to_user_mode.entry_SYSCALL_64_after_hwframe
    101.51 ± 33%   +1564.4%       1689 ±163%      -5.9%      95.56 ±  3%  perf-sched.wait_time.max.ms.__sched_text_start.__sched_text_start.futex_wait_queue_me.futex_wait.do_futex
      0.01 ±173%    -100.0%       0.00          -100.0%       0.00        perf-sched.wait_time.max.ms.__sched_text_start.__sched_text_start.io_schedule.__lock_page_killable.filemap_fault
      0.01 ±173%    -100.0%       0.00          -100.0%       0.00        perf-sched.wait_time.max.ms.__sched_text_start.__sched_text_start.io_schedule.put_and_wait_on_page_locked.do_swap_page
      1355 ±  2%      +2.2%       1385            +0.7%       1365 ±  4%  perf-sched.wait_time.max.ms.__sched_text_start.__sched_text_start.pipe_read.new_sync_read.vfs_read
      0.15 ±  7%      -1.8%       0.15 ± 54%    +673.4%       1.20 ±156%  perf-sched.wait_time.max.ms.__sched_text_start.__sched_text_start.preempt_schedule_common._cond_resched.__kmalloc
    328.68 ±173%    -100.0%       0.00          +455.7%       1826 ±173%  perf-sched.wait_time.max.ms.__sched_text_start.__sched_text_start.preempt_schedule_common._cond_resched.generic_perform_write
      1531 ± 19%     -11.5%       1355 ±  7%     -11.0%       1363 ±  2%  perf-sched.wait_time.max.ms.__sched_text_start.__sched_text_start.preempt_schedule_common._cond_resched.stop_one_cpu
      3.24 ± 59%     +15.5%       3.75 ± 57%     +46.1%       4.74 ±  9%  perf-sched.wait_time.max.ms.__sched_text_start.__sched_text_start.rcu_gp_kthread.kthread.ret_from_fork
    978.61 ±  6%    +136.5%       2314 ± 94%      -1.6%     962.78 ±  7%  perf-sched.wait_time.max.ms.__sched_text_start.__sched_text_start.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait
      7175            +1.7%       7300            -6.9%       6683 ± 11%  perf-sched.wait_time.max.ms.__sched_text_start.__sched_text_start.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop
    504.99            -0.0%     504.74            +0.0%     504.99        perf-sched.wait_time.max.ms.__sched_text_start.__sched_text_start.schedule_timeout.kcompactd.kthread
      0.01 ± 63%     -63.0%       0.01 ± 20%      +3.7%       0.01 ± 37%  perf-sched.wait_time.max.ms.__sched_text_start.__sched_text_start.schedule_timeout.khugepaged.kthread
    164.75 ± 56%     -20.0%     131.75 ± 64%     -10.3%     147.74 ± 57%  perf-sched.wait_time.max.ms.__sched_text_start.__sched_text_start.schedule_timeout.rcu_gp_kthread.kthread
      0.00        +4.3e+99%       0.00 ±173%    -100.0%       0.00        perf-sched.wait_time.max.ms.__sched_text_start.__sched_text_start.schedule_timeout.wait_for_completion.stop_one_cpu
      1804 ± 70%      -1.2%       1784 ± 71%     +38.9%       2507 ± 59%  perf-sched.wait_time.max.ms.__sched_text_start.__sched_text_start.smpboot_thread_fn.kthread.ret_from_fork
      5407 ± 37%      -2.2%       5290 ± 18%     -23.7%       4124 ± 17%  perf-sched.wait_time.max.ms.__sched_text_start.__sched_text_start.worker_thread.kthread.ret_from_fork
     28.50 ± 21%      -3.3       25.24 ±  7%      +0.2       28.72 ± 24%  perf-profile.calltrace.cycles-pp.cpuidle_enter.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64
     28.50 ± 21%      -3.3       25.24 ±  7%      +0.2       28.72 ± 24%  perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry.start_secondary
     28.51 ± 21%      -3.3       25.25 ±  7%      +0.2       28.72 ± 24%  perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.secondary_startup_64
     28.51 ± 21%      -3.3       25.25 ±  7%      +0.2       28.72 ± 24%  perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64
     28.51 ± 21%      -3.3       25.25 ±  7%      +0.2       28.72 ± 24%  perf-profile.calltrace.cycles-pp.start_secondary.secondary_startup_64
     28.68 ± 21%      -2.6       26.11 ±  5%      +0.3       29.02 ± 23%  perf-profile.calltrace.cycles-pp.intel_idle.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry
     28.68 ± 21%      -2.6       26.12 ±  5%      +0.3       29.03 ± 23%  perf-profile.calltrace.cycles-pp.secondary_startup_64
     26.78 ±  8%      -0.8       25.97            +0.1       26.88 ±  9%  perf-profile.calltrace.cycles-pp.__fget_light.do_sys_poll.__x64_sys_poll.do_syscall_64.entry_SYSCALL_64_after_hwframe
     19.07 ±  8%      -0.6       18.43 ±  2%      -0.2       18.88 ± 10%  perf-profile.calltrace.cycles-pp.fput_many.do_sys_poll.__x64_sys_poll.do_syscall_64.entry_SYSCALL_64_after_hwframe
     22.53 ±  8%      -0.6       21.89 ±  2%      +0.1       22.67 ±  8%  perf-profile.calltrace.cycles-pp.__fget_files.__fget_light.do_sys_poll.__x64_sys_poll.do_syscall_64
      1.92 ±  8%      -0.1        1.85 ±  2%      -0.1        1.87 ± 11%  perf-profile.calltrace.cycles-pp.__entry_text_start.__poll
      1.71 ±  9%      -0.1        1.65 ±  3%      -0.0        1.71 ±  8%  perf-profile.calltrace.cycles-pp.__fdget.do_sys_poll.__x64_sys_poll.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.69 ±  9%      -0.1        1.63 ±  3%      -0.0        1.66 ± 11%  perf-profile.calltrace.cycles-pp.fput.do_sys_poll.__x64_sys_poll.do_syscall_64.entry_SYSCALL_64_after_hwframe
      3.24 ±  9%      -0.0        3.20 ±  3%      -0.0        3.23 ±  9%  perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.entry_SYSCALL_64_after_hwframe.__poll
      2.86 ±  8%      -0.0        2.83            +0.0        2.89 ± 10%  perf-profile.calltrace.cycles-pp.testcase
      1.68 ±  9%      -0.0        1.66            -0.0        1.68 ± 12%  perf-profile.calltrace.cycles-pp.syscall_return_via_sysret.__poll
      1.04 ±  9%      -0.0        1.02 ±  4%      -0.0        1.01 ± 11%  perf-profile.calltrace.cycles-pp.__check_object_size.do_sys_poll.__x64_sys_poll.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.67 ± 11%      -0.0        0.65 ±  3%      -0.0        0.63 ± 10%  perf-profile.calltrace.cycles-pp.kfree.do_sys_poll.__x64_sys_poll.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.07 ±  7%      -0.0        1.06 ±  2%      -0.0        1.07 ±  8%  perf-profile.calltrace.cycles-pp.copy_user_enhanced_fast_string._copy_from_user.do_sys_poll.__x64_sys_poll.do_syscall_64
      1.44 ±  8%      -0.0        1.44 ±  2%      +0.0        1.44 ±  9%  perf-profile.calltrace.cycles-pp._copy_from_user.do_sys_poll.__x64_sys_poll.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +0.0        0.00            +0.1        0.14 ±173%  perf-profile.calltrace.cycles-pp.__kmalloc.do_sys_poll.__x64_sys_poll.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +0.1        0.13 ±173%      +0.0        0.00        perf-profile.calltrace.cycles-pp.__virt_addr_valid.__check_object_size.do_sys_poll.__x64_sys_poll.do_syscall_64
      0.17 ±173%      +0.7        0.87 ± 66%      +0.1        0.30 ±173%  perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_kernel.secondary_startup_64
      0.17 ±173%      +0.7        0.87 ± 66%      +0.1        0.30 ±173%  perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_kernel.secondary_startup_64
      0.17 ±173%      +0.7        0.87 ± 66%      +0.1        0.30 ±173%  perf-profile.calltrace.cycles-pp.cpuidle_enter.do_idle.cpu_startup_entry.start_kernel.secondary_startup_64
      0.17 ±173%      +0.7        0.87 ± 66%      +0.1        0.30 ±173%  perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry.start_kernel
      0.17 ±173%      +0.7        0.87 ± 66%      +0.1        0.30 ±173%  perf-profile.calltrace.cycles-pp.start_kernel.secondary_startup_64
      0.00            +1.0        0.98 ±  3%      +0.0        0.00        perf-profile.calltrace.cycles-pp.__put_user_nocheck_2.do_sys_poll.__x64_sys_poll.do_syscall_64.entry_SYSCALL_64_after_hwframe
     67.78 ±  8%      +2.5       70.30 ±  2%      -0.4       67.41 ±  9%  perf-profile.calltrace.cycles-pp.__poll
     63.81 ±  8%      +2.6       66.42 ±  2%      -0.3       63.51 ±  9%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__poll
     60.11 ±  8%      +2.7       62.76 ±  2%      -0.3       59.80 ±  9%  perf-profile.calltrace.cycles-pp.__x64_sys_poll.do_syscall_64.entry_SYSCALL_64_after_hwframe.__poll
     60.37 ±  8%      +2.7       63.03 ±  2%      -0.3       60.08 ±  9%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__poll
     58.02 ±  8%      +3.4       61.43 ±  2%      -0.2       57.77 ±  9%  perf-profile.calltrace.cycles-pp.do_sys_poll.__x64_sys_poll.do_syscall_64.entry_SYSCALL_64_after_hwframe.__poll
     28.51 ± 21%      -3.3       25.25 ±  7%      +0.2       28.72 ± 24%  perf-profile.children.cycles-pp.start_secondary
     28.68 ± 21%      -2.6       26.12 ±  5%      +0.4       29.03 ± 23%  perf-profile.children.cycles-pp.cpuidle_enter
     28.68 ± 21%      -2.6       26.12 ±  5%      +0.4       29.03 ± 23%  perf-profile.children.cycles-pp.cpuidle_enter_state
     28.68 ± 21%      -2.6       26.12 ±  5%      +0.3       29.03 ± 23%  perf-profile.children.cycles-pp.secondary_startup_64
     28.68 ± 21%      -2.6       26.12 ±  5%      +0.3       29.03 ± 23%  perf-profile.children.cycles-pp.cpu_startup_entry
     28.68 ± 21%      -2.6       26.12 ±  5%      +0.3       29.03 ± 23%  perf-profile.children.cycles-pp.do_idle
     28.68 ± 21%      -2.6       26.12 ±  5%      +0.3       29.02 ± 23%  perf-profile.children.cycles-pp.intel_idle
     25.94 ±  8%      -0.8       25.16            +0.1       26.04 ±  9%  perf-profile.children.cycles-pp.__fget_light
     22.54 ±  8%      -0.6       21.90 ±  2%      +0.1       22.68 ±  8%  perf-profile.children.cycles-pp.__fget_files
     18.23 ±  8%      -0.6       17.61 ±  2%      -0.2       18.05 ± 10%  perf-profile.children.cycles-pp.fput_many
      1.93 ±  8%      -0.1        1.86 ±  2%      -0.1        1.88 ± 11%  perf-profile.children.cycles-pp.__entry_text_start
      1.70 ±  8%      -0.1        1.65            -0.0        1.70 ±  9%  perf-profile.children.cycles-pp.__fdget
      3.27 ±  9%      -0.0        3.22 ±  3%      -0.0        3.25 ±  9%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      1.69 ± 10%      -0.0        1.65            -0.0        1.68 ± 11%  perf-profile.children.cycles-pp.fput
      0.67 ± 12%      -0.0        0.65 ±  2%      -0.0        0.64 ± 11%  perf-profile.children.cycles-pp.kfree
      0.29 ±  4%      -0.0        0.27 ±  8%      +0.0        0.30 ± 11%  perf-profile.children.cycles-pp.__check_heap_object
      1.89 ±  9%      -0.0        1.88            -0.0        1.88 ± 12%  perf-profile.children.cycles-pp.syscall_return_via_sysret
      0.13 ± 10%      -0.0        0.11 ±  7%      -0.0        0.11 ± 11%  perf-profile.children.cycles-pp.kmalloc_slab
      1.06 ±  9%      -0.0        1.05 ±  4%      -0.0        1.05 ± 12%  perf-profile.children.cycles-pp.__check_object_size
      1.09 ±  8%      -0.0        1.08 ±  2%      +0.0        1.09 ±  7%  perf-profile.children.cycles-pp.copy_user_enhanced_fast_string
      2.88 ±  8%      -0.0        2.87            +0.0        2.89 ± 10%  perf-profile.children.cycles-pp.testcase
      1.45 ±  8%      -0.0        1.45            +0.0        1.45 ±  9%  perf-profile.children.cycles-pp._copy_from_user
      0.16 ±  8%      -0.0        0.16 ±  5%      +0.0        0.17 ±  2%  perf-profile.children.cycles-pp.syscall_enter_from_user_mode
      0.06 ±  7%      -0.0        0.06 ±  9%      -0.0        0.04 ± 58%  perf-profile.children.cycles-pp.__unwind_start
      0.04 ± 58%      +0.0        0.04 ± 58%      -0.0        0.01 ±173%  perf-profile.children.cycles-pp.__x86_retpoline_rax
      0.01 ±173%      +0.0        0.01 ±173%      -0.0        0.00        perf-profile.children.cycles-pp.perf_output_sample
      0.01 ±173%      +0.0        0.01 ±173%      +0.0        0.03 ±100%  perf-profile.children.cycles-pp.poll_freewait
      0.00            +0.0        0.00            +0.0        0.01 ±173%  perf-profile.children.cycles-pp.do_user_addr_fault
      0.04 ± 58%      +0.0        0.04 ± 58%      -0.0        0.01 ±173%  perf-profile.children.cycles-pp.__get_user_nocheck_8
      0.39 ± 21%      +0.0        0.40 ± 20%      -0.1        0.34 ± 13%  perf-profile.children.cycles-pp.__virt_addr_valid
      0.05 ± 58%      +0.0        0.05            -0.0        0.04 ± 58%  perf-profile.children.cycles-pp.exit_to_user_mode_prepare
      0.12 ±  9%      +0.0        0.12 ±  5%      +0.0        0.12 ± 12%  perf-profile.children.cycles-pp.__might_sleep
      0.47 ±  8%      +0.0        0.47 ±  7%      +0.0        0.47 ± 12%  perf-profile.children.cycles-pp.__kmalloc
      0.15 ±  4%      +0.0        0.15 ±  5%      -0.0        0.12 ± 31%  perf-profile.children.cycles-pp.perf_callchain_kernel
      0.11            +0.0        0.11 ±  7%      -0.0        0.07 ± 58%  perf-profile.children.cycles-pp.unwind_next_frame
      0.07 ± 17%      +0.0        0.07 ± 14%      -0.0        0.07 ± 25%  perf-profile.children.cycles-pp.asm_exc_page_fault
      0.27 ± 10%      +0.0        0.27 ±  4%      -0.0        0.26 ± 11%  perf-profile.children.cycles-pp.__might_fault
      0.21 ±  6%      +0.0        0.22 ±  3%      -0.0        0.17 ± 29%  perf-profile.children.cycles-pp.get_perf_callchain
      0.21 ±  6%      +0.0        0.22 ±  3%      -0.0        0.17 ± 30%  perf-profile.children.cycles-pp.perf_callchain
      0.07 ± 10%      +0.0        0.08 ±  5%      -0.0        0.07 ±  6%  perf-profile.children.cycles-pp.asm_sysvec_irq_work
      0.07 ± 10%      +0.0        0.08 ±  5%      -0.0        0.07 ±  6%  perf-profile.children.cycles-pp.sysvec_irq_work
      0.07 ± 10%      +0.0        0.08 ±  5%      -0.0        0.07 ±  6%  perf-profile.children.cycles-pp.__sysvec_irq_work
      0.07 ± 10%      +0.0        0.08 ±  5%      -0.0        0.07 ±  6%  perf-profile.children.cycles-pp.irq_work_run
      0.07 ± 10%      +0.0        0.08 ±  5%      -0.0        0.07 ±  6%  perf-profile.children.cycles-pp.irq_work_run_list
      0.07 ± 10%      +0.0        0.08 ±  5%      -0.0        0.07 ±  6%  perf-profile.children.cycles-pp.irq_work_single
      0.07 ± 10%      +0.0        0.08 ±  5%      -0.0        0.07 ±  6%  perf-profile.children.cycles-pp.printk
      0.10 ±  4%      +0.0        0.11 ±  8%      +0.0        0.13 ± 12%  perf-profile.children.cycles-pp.___might_sleep
      0.29 ±  7%      +0.0        0.30 ±  5%      -0.1        0.23 ± 28%  perf-profile.children.cycles-pp.perf_swevent_overflow
      0.29 ±  7%      +0.0        0.30 ±  5%      -0.1        0.23 ± 28%  perf-profile.children.cycles-pp.__perf_event_overflow
      0.28 ±  8%      +0.0        0.29 ±  5%      -0.1        0.23 ± 28%  perf-profile.children.cycles-pp.perf_event_output_forward
      0.01 ±173%      +0.0        0.03 ±100%      -0.0        0.00        perf-profile.children.cycles-pp.ordered_events__queue
      0.00            +0.0        0.01 ±173%      +0.0        0.00        perf-profile.children.cycles-pp.proc_reg_read
      0.00            +0.0        0.01 ±173%      +0.0        0.00        perf-profile.children.cycles-pp.build_id__mark_dso_hit
      0.00            +0.0        0.01 ±173%      +0.0        0.01 ±173%  perf-profile.children.cycles-pp.poll_select_set_timeout
      0.00            +0.0        0.01 ±173%      +0.0        0.01 ±173%  perf-profile.children.cycles-pp._cond_resched
      0.23 ±  8%      +0.0        0.24 ±  5%      -0.0        0.19 ± 29%  perf-profile.children.cycles-pp.perf_prepare_sample
      0.15 ± 12%      +0.0        0.17 ±  9%      -0.0        0.15 ± 18%  perf-profile.children.cycles-pp.kthread
      0.15 ± 12%      +0.0        0.17 ±  9%      +0.0        0.15 ± 16%  perf-profile.children.cycles-pp.ret_from_fork
      0.07 ±  6%      +0.0        0.08 ±  8%      +0.0        0.07        perf-profile.children.cycles-pp.serial8250_console_putchar
      0.29 ±  7%      +0.0        0.31 ±  4%      -0.1        0.24 ± 28%  perf-profile.children.cycles-pp.perf_tp_event
      0.15 ± 12%      +0.0        0.16 ±  9%      -0.0        0.15 ± 15%  perf-profile.children.cycles-pp.process_one_work
      0.15 ± 12%      +0.0        0.16 ±  9%      -0.0        0.15 ± 15%  perf-profile.children.cycles-pp.drm_fb_helper_dirty_work
      0.15 ± 10%      +0.0        0.16 ± 11%      +0.0        0.15 ± 15%  perf-profile.children.cycles-pp.drm_atomic_helper_dirtyfb
      0.15 ± 10%      +0.0        0.16 ± 11%      +0.0        0.15 ± 15%  perf-profile.children.cycles-pp.drm_atomic_helper_commit
      0.15 ± 10%      +0.0        0.16 ± 11%      +0.0        0.15 ± 15%  perf-profile.children.cycles-pp.commit_tail
      0.15 ± 10%      +0.0        0.16 ± 11%      +0.0        0.15 ± 15%  perf-profile.children.cycles-pp.drm_atomic_helper_commit_tail
      0.15 ± 10%      +0.0        0.16 ± 11%      +0.0        0.15 ± 15%  perf-profile.children.cycles-pp.drm_atomic_helper_commit_planes
      0.15 ± 10%      +0.0        0.16 ± 11%      +0.0        0.15 ± 15%  perf-profile.children.cycles-pp.mgag200_simple_display_pipe_update
      0.15 ± 10%      +0.0        0.16 ± 11%      +0.0        0.15 ± 15%  perf-profile.children.cycles-pp.mgag200_handle_damage
      0.07 ±  5%      +0.0        0.09 ±  9%      +0.0        0.07 ±  5%  perf-profile.children.cycles-pp.vprintk_emit
      0.07 ±  5%      +0.0        0.09 ±  9%      +0.0        0.07 ±  5%  perf-profile.children.cycles-pp.console_unlock
      0.07            +0.0        0.08 ±  5%      +0.0        0.07 ±  5%  perf-profile.children.cycles-pp.serial8250_console_write
      0.03 ±100%      +0.0        0.04 ± 58%      -0.0        0.00        perf-profile.children.cycles-pp.machines__deliver_event
      0.03 ±100%      +0.0        0.04 ± 58%      -0.0        0.00        perf-profile.children.cycles-pp.seq_read
      0.04 ± 59%      +0.0        0.06 ± 11%      -0.0        0.03 ±100%  perf-profile.children.cycles-pp.perf_callchain_user
      0.01 ±173%      +0.0        0.03 ±100%      -0.0        0.00        perf-profile.children.cycles-pp.__libc_read
      0.07 ±  6%      +0.0        0.08 ± 10%      +0.0        0.07        perf-profile.children.cycles-pp.wait_for_xmitr
      0.03 ±100%      +0.0        0.04 ± 60%      -0.0        0.02 ±173%  perf-profile.children.cycles-pp.exc_page_fault
      0.31 ±  7%      +0.0        0.33 ±  4%      -0.1        0.26 ± 28%  perf-profile.children.cycles-pp.update_curr
      0.29 ±  6%      +0.0        0.31 ±  4%      -0.1        0.24 ± 28%  perf-profile.children.cycles-pp.perf_trace_sched_stat_runtime
      0.15 ± 12%      +0.0        0.17 ±  9%      +0.0        0.15 ± 18%  perf-profile.children.cycles-pp.worker_thread
      0.14 ±  9%      +0.0        0.16 ± 11%      +0.0        0.15 ± 15%  perf-profile.children.cycles-pp.drm_fb_memcpy_dstclip
      0.14 ±  9%      +0.0        0.16 ± 11%      +0.0        0.15 ± 15%  perf-profile.children.cycles-pp.memcpy_toio
      0.07 ±  6%      +0.0        0.08 ±  5%      +0.0        0.07        perf-profile.children.cycles-pp.uart_console_write
      0.03 ±100%      +0.0        0.04 ± 59%      -0.0        0.01 ±173%  perf-profile.children.cycles-pp.ksys_read
      0.03 ±100%      +0.0        0.04 ± 59%      -0.0        0.01 ±173%  perf-profile.children.cycles-pp.vfs_read
      0.35 ±  5%      +0.0        0.37 ±  4%      -0.1        0.29 ± 28%  perf-profile.children.cycles-pp.task_tick_fair
      0.40 ±  6%      +0.0        0.42 ±  3%      -0.0        0.35 ± 24%  perf-profile.children.cycles-pp.update_process_times
      0.41 ±  6%      +0.0        0.43 ±  3%      -0.0        0.37 ± 24%  perf-profile.children.cycles-pp.tick_sched_timer
      0.12 ± 33%      +0.0        0.15 ± 24%      +0.0        0.12 ± 21%  perf-profile.children.cycles-pp.__libc_start_main
      0.12 ± 33%      +0.0        0.15 ± 24%      +0.0        0.12 ± 21%  perf-profile.children.cycles-pp.main
      0.12 ± 33%      +0.0        0.15 ± 24%      +0.0        0.12 ± 21%  perf-profile.children.cycles-pp.run_builtin
      0.06 ± 63%      +0.0        0.08 ± 21%      +0.0        0.07 ± 11%  perf-profile.children.cycles-pp.__ordered_events__flush
      0.05 ± 61%      +0.0        0.07 ± 20%      +0.0        0.07 ±  6%  perf-profile.children.cycles-pp.perf_session__process_user_event
      0.40 ±  6%      +0.0        0.42 ±  2%      -0.0        0.35 ± 24%  perf-profile.children.cycles-pp.tick_sched_handle
      0.11 ±  9%      +0.0        0.14 ± 12%      -0.0        0.10 ±  8%  perf-profile.children.cycles-pp.poll@plt
      0.37 ±  6%      +0.0        0.40 ±  4%      -0.0        0.32 ± 26%  perf-profile.children.cycles-pp.scheduler_tick
      0.46 ±  5%      +0.0        0.48 ±  2%      -0.0        0.41 ± 21%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      0.00            +0.0        0.03 ±100%      +0.0        0.01 ±173%  perf-profile.children.cycles-pp.ksys_write
      0.00            +0.0        0.03 ±100%      +0.0        0.01 ±173%  perf-profile.children.cycles-pp.vfs_write
      0.00            +0.0        0.03 ±100%      +0.0        0.01 ±173%  perf-profile.children.cycles-pp.new_sync_write
      0.03 ±100%      +0.0        0.05 ± 58%      +0.0        0.04 ± 59%  perf-profile.children.cycles-pp.check_stack_object
      0.12 ± 37%      +0.0        0.14 ± 23%      +0.0        0.12 ± 25%  perf-profile.children.cycles-pp.cmd_sched
      0.10 ± 38%      +0.0        0.12 ± 20%      +0.0        0.11 ±  7%  perf-profile.children.cycles-pp.process_simple
      0.11 ± 37%      +0.0        0.14 ± 21%      +0.0        0.13 ±  6%  perf-profile.children.cycles-pp.record__finish_output
      0.11 ± 37%      +0.0        0.14 ± 21%      +0.0        0.13 ±  6%  perf-profile.children.cycles-pp.perf_session__process_events
      0.06 ± 63%      +0.0        0.08 ± 23%      +0.0        0.08 ±  5%  perf-profile.children.cycles-pp.perf_session__deliver_event
      0.01 ±173%      +0.0        0.04 ± 58%      +0.0        0.01 ±173%  perf-profile.children.cycles-pp.io_serial_in
      0.53 ±  6%      +0.0        0.56 ±  3%      -0.0        0.48 ± 19%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      0.52 ±  6%      +0.0        0.55 ±  2%      -0.1        0.47 ± 19%  perf-profile.children.cycles-pp.hrtimer_interrupt
      0.12 ± 37%      +0.0        0.15 ± 22%      +0.0        0.14 ±  6%  perf-profile.children.cycles-pp.cmd_record
      0.60 ±  6%      +0.0        0.64 ±  2%      -0.0        0.56 ± 16%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
      0.55 ±  6%      +0.0        0.59 ±  3%      -0.0        0.51 ± 17%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      0.53 ±  5%      +0.1        0.59 ±  2%      -0.0        0.50 ± 16%  perf-profile.children.cycles-pp.asm_call_sysvec_on_stack
      0.17 ±173%      +0.7        0.87 ± 66%      +0.1        0.30 ±173%  perf-profile.children.cycles-pp.start_kernel
      0.00            +1.8        1.77 ±  3%      +0.0        0.00        perf-profile.children.cycles-pp.__put_user_nocheck_2
     68.01 ±  8%      +2.5       70.51 ±  2%      -0.4       67.63 ±  9%  perf-profile.children.cycles-pp.__poll
     63.95 ±  8%      +2.6       66.58 ±  2%      -0.3       63.64 ±  9%  perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     60.11 ±  8%      +2.7       62.79 ±  2%      -0.3       59.83 ±  9%  perf-profile.children.cycles-pp.__x64_sys_poll
     59.75 ±  8%      +2.7       62.42 ±  2%      -0.3       59.49 ±  9%  perf-profile.children.cycles-pp.do_sys_poll
     60.49 ±  8%      +2.7       63.18 ±  2%      -0.3       60.20 ±  9%  perf-profile.children.cycles-pp.do_syscall_64
     28.68 ± 21%      -2.6       26.12 ±  5%      +0.3       29.02 ± 23%  perf-profile.self.cycles-pp.intel_idle
     22.34 ±  8%      -0.7       21.67 ±  2%      +0.1       22.49 ±  9%  perf-profile.self.cycles-pp.__fget_files
     17.23 ±  8%      -0.6       16.63 ±  2%      -0.2       17.07 ± 10%  perf-profile.self.cycles-pp.fput_many
      2.54 ±  7%      -0.1        2.43 ±  2%      -0.0        2.51 ± 11%  perf-profile.self.cycles-pp.__fget_light
      1.71 ±  8%      -0.1        1.66 ±  3%      -0.0        1.67 ± 11%  perf-profile.self.cycles-pp.__entry_text_start
      3.23 ±  9%      -0.0        3.18 ±  3%      -0.0        3.21 ±  9%  perf-profile.self.cycles-pp.syscall_exit_to_user_mode
      0.45 ±  7%      -0.0        0.42            -0.0        0.44 ±  8%  perf-profile.self.cycles-pp.__poll
      0.84 ±  7%      -0.0        0.81 ±  2%      +0.0        0.84 ±  9%  perf-profile.self.cycles-pp.__fdget
      0.28 ±  5%      -0.0        0.26 ±  7%      +0.0        0.29 ± 12%  perf-profile.self.cycles-pp.__check_heap_object
      0.66 ± 12%      -0.0        0.64 ±  2%      -0.0        0.63 ± 10%  perf-profile.self.cycles-pp.kfree
      0.85 ± 11%      -0.0        0.83 ±  3%      -0.0        0.84 ± 12%  perf-profile.self.cycles-pp.fput
      1.88 ± 10%      -0.0        1.87            -0.0        1.88 ± 12%  perf-profile.self.cycles-pp.syscall_return_via_sysret
      0.35 ±  6%      -0.0        0.34 ±  8%      +0.0        0.37 ± 11%  perf-profile.self.cycles-pp.__check_object_size
      1.08 ±  8%      -0.0        1.07 ±  2%      +0.0        1.08 ±  7%  perf-profile.self.cycles-pp.copy_user_enhanced_fast_string
      0.12 ± 11%      -0.0        0.11 ±  7%      -0.0        0.10 ± 10%  perf-profile.self.cycles-pp.kmalloc_slab
      0.19 ±  8%      -0.0        0.19 ±  6%      +0.0        0.19 ±  9%  perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      2.85 ±  8%      -0.0        2.85            +0.0        2.86 ± 10%  perf-profile.self.cycles-pp.testcase
      0.10 ± 11%      -0.0        0.10 ±  5%      +0.0        0.10 ± 13%  perf-profile.self.cycles-pp._copy_from_user
      0.14 ± 10%      -0.0        0.14 ±  7%      +0.0        0.15 ±  5%  perf-profile.self.cycles-pp.syscall_enter_from_user_mode
      0.10 ± 11%      -0.0        0.10 ± 15%      -0.0        0.10 ±  8%  perf-profile.self.cycles-pp.poll@plt
      0.03 ±100%      +0.0        0.03 ±100%      -0.0        0.00        perf-profile.self.cycles-pp.unwind_next_frame
      0.13 ± 12%      +0.0        0.13 ±  6%      -0.0        0.10 ± 14%  perf-profile.self.cycles-pp.__might_fault
      0.01 ±173%      +0.0        0.01 ±173%      -0.0        0.00        perf-profile.self.cycles-pp.__x86_retpoline_rax
      0.07 ± 17%      +0.0        0.07            -0.0        0.07 ± 16%  perf-profile.self.cycles-pp.do_syscall_64
      0.38 ± 19%      +0.0        0.39 ± 21%      -0.1        0.33 ± 13%  perf-profile.self.cycles-pp.__virt_addr_valid
      0.11 ±  8%      +0.0        0.11 ±  4%      +0.0        0.11 ± 12%  perf-profile.self.cycles-pp.__might_sleep
      0.30 ± 10%      +0.0        0.31            -0.0        0.29 ± 12%  perf-profile.self.cycles-pp.__x64_sys_poll
      0.11 ± 13%      +0.0        0.12 ± 12%      -0.0        0.11 ± 19%  perf-profile.self.cycles-pp.memcpy_toio
      0.09 ±  4%      +0.0        0.10 ±  7%      +0.0        0.12 ± 14%  perf-profile.self.cycles-pp.___might_sleep
      0.00            +0.0        0.01 ±173%      +0.0        0.00        perf-profile.self.cycles-pp.exit_to_user_mode_prepare
      0.00            +0.0        0.01 ±173%      +0.0        0.01 ±173%  perf-profile.self.cycles-pp.poll_select_set_timeout
      0.23 ± 11%      +0.0        0.25 ± 11%      +0.0        0.25 ± 17%  perf-profile.self.cycles-pp.__kmalloc
      0.01 ±173%      +0.0        0.04 ± 58%      +0.0        0.01 ±173%  perf-profile.self.cycles-pp.io_serial_in
      0.01 ±173%      +0.0        0.04 ± 59%      +0.0        0.03 ±100%  perf-profile.self.cycles-pp.check_stack_object
      0.00            +1.6        1.64 ±  3%      +0.0        0.00        perf-profile.self.cycles-pp.__put_user_nocheck_2
     11.79 ±  8%      +2.4       14.22 ±  2%      -0.1       11.66 ± 10%  perf-profile.self.cycles-pp.do_sys_poll
    659.00 ±  2%      +0.3%     661.25 ±  2%      -0.3%     657.00        softirqs.BLOCK
      0.25 ±173%   +3500.0%       9.00 ±110%   +7700.0%      19.50 ± 81%  softirqs.CPU0.BLOCK
      2.25 ± 19%     -11.1%       2.00           -11.1%       2.00        softirqs.CPU0.HI
      1.00            +0.0%       1.00            +0.0%       1.00        softirqs.CPU0.NET_RX
      0.00          -100.0%       0.00       +2.5e+101%       0.25 ±173%  softirqs.CPU0.NET_TX
     19606 ± 19%     -22.7%      15159 ± 12%      +4.0%      20398 ± 22%  softirqs.CPU0.RCU
     16113 ± 76%     +75.9%      28335 ± 19%     +23.1%      19832 ± 62%  softirqs.CPU0.SCHED
     48.50            +0.0%      48.50            +0.0%      48.50        softirqs.CPU0.TASKLET
      2180 ± 29%     -17.6%       1796 ± 18%     +15.3%       2515 ± 29%  softirqs.CPU0.TIMER
      8.00 ±100%     +50.0%      12.00 ±137%     -15.6%       6.75 ±164%  softirqs.CPU1.BLOCK
      1.00            +0.0%       1.00            +0.0%       1.00        softirqs.CPU1.NET_RX
     14.25 ±100%    -100.0%       0.00          -100.0%       0.00        softirqs.CPU1.NET_TX
     11740 ± 10%     +35.9%      15952 ± 20%      -2.1%      11489 ± 19%  softirqs.CPU1.RCU
     37963 ± 15%     -63.0%      14034 ±109%     -15.6%      32039 ± 30%  softirqs.CPU1.SCHED
      9.25 ±129%     -59.5%       3.75 ±113%     -78.4%       2.00        softirqs.CPU1.TASKLET
      1202 ± 63%     -54.1%     552.00 ±102%      -2.9%       1168 ± 47%  softirqs.CPU1.TIMER
      0.00          -100.0%       0.00         +1e+103%      10.50 ±173%  softirqs.CPU10.BLOCK
     12033 ± 25%     +33.8%      16100 ± 22%     +27.5%      15346 ± 22%  softirqs.CPU10.RCU
     32151 ± 50%     -57.5%      13671 ±116%     -49.9%      16106 ± 91%  softirqs.CPU10.SCHED
      1344 ± 95%     -93.9%      81.75 ± 52%     -76.9%     310.50 ±135%  softirqs.CPU10.TIMER
      0.25 ±173%    -100.0%       0.00          -100.0%       0.00        softirqs.CPU11.BLOCK
      7.00 ±173%    -100.0%       0.00           -96.4%       0.25 ±173%  softirqs.CPU11.NET_TX
     16583 ± 22%     -18.8%      13470 ± 31%     -31.0%      11450 ± 28%  softirqs.CPU11.RCU
     16016 ± 91%     +52.2%      24371 ± 61%     +93.6%      31005 ± 50%  softirqs.CPU11.SCHED
      2.75 ±173%     -81.8%       0.50 ±173%     -45.5%       1.50 ±110%  softirqs.CPU11.TASKLET
    427.75 ± 87%     -46.3%     229.75 ± 76%     +97.6%     845.25 ±100%  softirqs.CPU11.TIMER
      0.00       +5.2e+102%       5.25 ±173%    -100.0%       0.00        softirqs.CPU12.BLOCK
     11661 ± 13%      -1.5%      11484 ± 23%     +36.0%      15865 ± 21%  softirqs.CPU12.RCU
     29650 ± 51%     -27.0%      21641 ± 84%     -52.4%      14116 ±118%  softirqs.CPU12.SCHED
      0.50 ±173%    -100.0%       0.00          +250.0%       1.75 ±173%  softirqs.CPU12.TASKLET
      1023 ± 48%      +5.3%       1077 ± 85%     -60.3%     406.25 ±144%  softirqs.CPU12.TIMER
      0.00       +8.3e+102%       8.25 ±145%   +6e+102%       6.00 ±173%  softirqs.CPU13.BLOCK
     12535 ± 20%      +2.9%      12904 ± 32%      +4.7%      13121 ± 22%  softirqs.CPU13.RCU
     29105 ± 52%     -24.1%      22103 ± 87%     -22.4%      22571 ± 80%  softirqs.CPU13.SCHED
      0.00          -100.0%       0.00       +6.5e+102%       6.50 ±164%  softirqs.CPU13.TASKLET
      2957 ±139%     -91.8%     241.50 ± 84%     -67.5%     961.50 ±126%  softirqs.CPU13.TIMER
     21.25 ±111%     -89.4%       2.25 ± 79%     -27.1%      15.50 ±173%  softirqs.CPU14.BLOCK
     10593 ± 15%     +11.3%      11786 ± 15%     +56.0%      16525 ± 15%  softirqs.CPU14.RCU
     35229 ± 24%     -36.7%      22293 ± 80%     -71.8%       9920 ± 58%  softirqs.CPU14.SCHED
      2.00           +12.5%       2.25 ± 19%     +37.5%       2.75 ± 47%  softirqs.CPU14.TASKLET
    720.75 ±102%     +22.4%     882.50 ± 92%     -85.6%     103.50 ± 67%  softirqs.CPU14.TIMER
      0.00          -100.0%       0.00       +3.5e+102%       3.50 ±142%  softirqs.CPU15.BLOCK
      0.00       +2.5e+101%       0.25 ±173%    -100.0%       0.00        softirqs.CPU15.NET_TX
     16382 ±  7%     -13.5%      14178 ± 27%     -26.3%      12080 ± 30%  softirqs.CPU15.RCU
      6104 ± 60%    +257.0%      21793 ± 80%    +421.3%      31820 ± 52%  softirqs.CPU15.SCHED
      2.50 ± 34%    +250.0%       8.75 ± 89%     +30.0%       3.25 ± 66%  softirqs.CPU15.TASKLET
     50.75 ± 81%   +1654.7%     890.50 ± 93%   +1292.1%     706.50 ±105%  softirqs.CPU15.TIMER
      0.00          -100.0%       0.00       +2.5e+101%       0.25 ±173%  softirqs.CPU16.BLOCK
      0.00          -100.0%       0.00       +7.2e+102%       7.25 ±173%  softirqs.CPU16.NET_TX
     10898 ±  7%     +32.0%      14383 ± 30%     +42.6%      15543 ± 31%  softirqs.CPU16.RCU
     41161 ±  4%     -47.4%      21631 ± 88%     -44.0%      23054 ± 80%  softirqs.CPU16.SCHED
      2.00          +287.5%       7.75 ±128%      +0.0%       2.00        softirqs.CPU16.TASKLET
    949.75 ± 66%     -83.9%     152.50 ± 90%      -6.8%     885.50 ±140%  softirqs.CPU16.TIMER
     20.00 ±114%     -97.5%       0.50 ±173%    +177.5%      55.50 ± 68%  softirqs.CPU17.BLOCK
     19417 ±  6%     -19.2%      15693 ± 24%     -34.0%      12808 ± 27%  softirqs.CPU17.RCU
      3750 ± 30%    +244.3%      12912 ±121%    +758.7%      32202 ± 49%  softirqs.CPU17.SCHED
      6.75 ±121%     -70.4%       2.00            -3.7%       6.50 ± 69%  softirqs.CPU17.TASKLET
     49.00 ± 36%   +1464.3%     766.50 ±149%    +969.4%     524.00 ± 76%  softirqs.CPU17.TIMER
      0.00       +1.1e+103%      10.75 ±173% +2.5e+101%       0.25 ±173%  softirqs.CPU18.BLOCK
     13561 ± 22%     -11.1%      12056 ± 23%     +17.2%      15891 ± 20%  softirqs.CPU18.RCU
     31989 ± 49%     -15.4%      27063 ± 57%     -51.1%      15655 ± 89%  softirqs.CPU18.SCHED
      2.25 ± 19%     -11.1%       2.00           -11.1%       2.00        softirqs.CPU18.TASKLET
    931.75 ±100%     -16.7%     776.25 ±117%     -89.8%      95.00 ± 58%  softirqs.CPU18.TIMER
     77.75 ± 77%     -85.9%      11.00 ±173%     -89.7%       8.00 ±173%  softirqs.CPU19.BLOCK
     19330 ±  6%     -22.5%      14978 ± 26%     -36.7%      12241 ± 26%  softirqs.CPU19.RCU
      4492 ±  2%    +180.3%      12593 ±121%    +602.1%      31537 ± 50%  softirqs.CPU19.SCHED
      2.00            +0.0%       2.00            +0.0%       2.00        softirqs.CPU19.TASKLET
     33.25 ± 29%   +2142.1%     745.50 ±150%   +2139.1%     744.50 ±134%  softirqs.CPU19.TIMER
     27.00 ± 62%     -61.1%      10.50 ±173%     -99.1%       0.25 ±173%  softirqs.CPU2.BLOCK
      1.00            +0.0%       1.00            +0.0%       1.00        softirqs.CPU2.NET_RX
      7.50 ±165%    -100.0%       0.00            -3.3%       7.25 ±173%  softirqs.CPU2.NET_TX
     16086 ± 23%      +6.6%      17151 ± 18%      +0.6%      16181 ± 21%  softirqs.CPU2.RCU
     13153 ±124%     -18.8%      10683 ± 94%     +12.0%      14736 ±104%  softirqs.CPU2.SCHED
      1.50 ± 57%      +0.0%       1.50 ± 57%      +0.0%       1.50 ± 57%  softirqs.CPU2.TASKLET
    130.25 ± 94%    +111.7%     275.75 ± 81%    +481.2%     757.00 ±134%  softirqs.CPU2.TIMER
      5.25 ±140%     -90.5%       0.50 ±173%     -95.2%       0.25 ±173%  softirqs.CPU20.BLOCK
      0.00          -100.0%       0.00          -100.0%       0.00        softirqs.CPU20.NET_TX
     10942 ±  9%     +10.4%      12081 ± 24%     +39.4%      15257 ± 30%  softirqs.CPU20.RCU
     40598 ±  4%     -26.0%      30053 ± 49%     -52.2%      19417 ± 82%  softirqs.CPU20.SCHED
      2.00            +0.0%       2.00           +75.0%       3.50 ± 74%  softirqs.CPU20.TASKLET
      1257 ± 85%      +3.3%       1298 ±111%     -84.9%     189.25 ± 83%  softirqs.CPU20.TIMER
      2.75 ±152%    +845.5%      26.00 ± 99%    +218.2%       8.75 ±173%  softirqs.CPU21.BLOCK
     17365 ± 23%     -12.9%      15119 ± 25%     -22.2%      13504 ± 25%  softirqs.CPU21.RCU
     13980 ±117%      -7.4%      12938 ±115%     +20.6%      16854 ± 89%  softirqs.CPU21.SCHED
      2.00            +0.0%       2.00          +262.5%       7.25 ±125%  softirqs.CPU21.TASKLET
    434.75 ±164%     -82.1%      78.00 ± 87%     +95.0%     847.75 ±164%  softirqs.CPU21.TIMER
     16.25 ± 95%     -96.9%       0.50 ±173%     +86.2%      30.25 ±173%  softirqs.CPU22.BLOCK
     10625 ±  7%      +7.6%      11434 ± 24%     +49.1%      15844 ± 27%  softirqs.CPU22.RCU
     41026 ±  4%     -23.4%      31411 ± 49%     -66.9%      13560 ±116%  softirqs.CPU22.SCHED
      1185 ± 82%     -12.6%       1036 ± 66%     -60.5%     467.50 ±161%  softirqs.CPU22.TIMER
      6.00 ±154%    +629.2%      43.75 ±102%     -62.5%       2.25 ±148%  softirqs.CPU23.BLOCK
      0.00          -100.0%       0.00       +7.2e+102%       7.25 ±173%  softirqs.CPU23.NET_TX
     18415 ±  7%     -10.0%      16569 ± 10%      -3.7%      17732 ± 18%  softirqs.CPU23.RCU
      6500 ± 92%      +0.7%       6548 ± 84%     +43.5%       9330 ± 68%  softirqs.CPU23.SCHED
      0.75 ±173%    +200.0%       2.25 ±173%    -100.0%       0.00        softirqs.CPU23.TASKLET
    179.00 ±130%     -59.2%      73.00 ± 33%     +17.2%     209.75 ± 54%  softirqs.CPU23.TIMER
      9.00 ±173%     -66.7%       3.00 ±173%     +27.8%      11.50 ±153%  softirqs.CPU24.BLOCK
     14188 ± 28%     +13.8%      16141 ± 15%      -7.8%      13083 ± 15%  softirqs.CPU24.RCU
     23858 ± 65%     -23.4%      18277 ± 35%      +7.3%      25609 ± 52%  softirqs.CPU24.SCHED
      0.00         +5e+101%       0.50 ±173%    -100.0%       0.00        softirqs.CPU24.TASKLET
    373.75 ± 76%     -17.3%     309.00 ± 46%     -33.5%     248.50 ± 79%  softirqs.CPU24.TIMER
      9.00 ±173%     -22.2%       7.00 ±102%     -97.2%       0.25 ±173%  softirqs.CPU25.BLOCK
     17509 ± 16%     -24.9%      13148 ± 30%     -16.9%      14554 ± 23%  softirqs.CPU25.RCU
      7246 ± 87%    +333.9%      31446 ± 49%     +73.5%      12572 ± 73%  softirqs.CPU25.SCHED
      0.00       +2.3e+102%       2.25 ±173%    -100.0%       0.00        softirqs.CPU25.TASKLET
    284.75 ±123%     -22.2%     221.50 ± 99%     -60.2%     113.25 ± 57%  softirqs.CPU25.TIMER
     17.00 ±105%     -38.2%      10.50 ±173%     -38.2%      10.50 ±173%  softirqs.CPU26.BLOCK
      1559 ±128%    +294.5%       6152 ±140%     -64.1%     560.25 ±108%  softirqs.CPU26.NET_RX
      2.25 ± 19%     -11.1%       2.00 ± 35%     -44.4%       1.25 ±103%  softirqs.CPU26.NET_TX
     10591 ± 13%     +18.1%      12510 ± 13%      +5.6%      11183 ± 28%  softirqs.CPU26.RCU
     31383 ± 48%     +14.2%      35831 ± 31%      -4.9%      29860 ± 54%  softirqs.CPU26.SCHED
      0.25 ±173%   +1500.0%       4.00 ±173%      +0.0%       0.25 ±173%  softirqs.CPU26.TASKLET
    779.75 ± 67%     +20.6%     940.00 ± 71%    +210.9%       2424 ±110%  softirqs.CPU26.TIMER
      0.00       +1.7e+103%      16.50 ±107% +1.3e+103%      13.50 ±106%  softirqs.CPU27.BLOCK
      1248 ± 66%     -59.6%     503.75 ± 90%     -90.6%     117.25 ± 32%  softirqs.CPU27.NET_RX
      1.25 ± 34%     +20.0%       1.50 ± 33%      +0.0%       1.25 ± 34%  softirqs.CPU27.NET_TX
     16242 ± 25%     +15.9%      18820 ± 11%      -5.5%      15353 ± 23%  softirqs.CPU27.RCU
     13927 ±120%     -67.0%       4593 ±  4%      -3.1%      13491 ±123%  softirqs.CPU27.SCHED
      0.00          -100.0%       0.00       +6.3e+102%       6.25 ±138%  softirqs.CPU27.TASKLET
    301.00 ±156%     -61.7%     115.25 ± 54%     -67.3%      98.50 ± 80%  softirqs.CPU27.TIMER
     15.75 ± 99%     -74.6%       4.00 ±173%     -74.6%       4.00 ±173%  softirqs.CPU28.BLOCK
      1411 ±158%     +68.3%       2375 ±135%     -93.1%      98.00 ±  8%  softirqs.CPU28.NET_RX
      1.50 ± 33%      +0.0%       1.50 ± 74%      +0.0%       1.50 ± 33%  softirqs.CPU28.NET_TX
     12117 ± 12%      +5.6%      12790 ± 33%      +1.5%      12302 ± 22%  softirqs.CPU28.RCU
     30678 ± 41%     -27.2%      22334 ± 83%      +3.3%      31685 ± 49%  softirqs.CPU28.SCHED
     11.00 ± 98%     -86.4%       1.50 ±173%     -97.7%       0.25 ±173%  softirqs.CPU28.TASKLET
      1518 ± 32%     -66.5%     509.00 ±124%     -76.5%     357.25 ± 81%  softirqs.CPU28.TIMER
      0.00       +1.8e+103%      18.00 ±127% +5.5e+102%       5.50 ±173%  softirqs.CPU29.BLOCK
      3618 ± 98%     +22.9%       4447 ±100%     -59.0%       1481 ± 93%  softirqs.CPU29.NET_RX
      1.50 ± 57%     -16.7%       1.25 ± 66%     -16.7%       1.25 ± 34%  softirqs.CPU29.NET_TX
     14512 ± 25%      -3.1%      14064 ± 22%     +11.7%      16204 ± 20%  softirqs.CPU29.RCU
     21598 ± 83%     -36.1%      13811 ±115%     -36.6%      13695 ±116%  softirqs.CPU29.SCHED
      0.25 ±173%    -100.0%       0.00          -100.0%       0.00        softirqs.CPU29.TASKLET
    799.50 ± 89%     -65.4%     277.00 ±146%     -50.3%     397.00 ±156%  softirqs.CPU29.TIMER
      6.50 ±173%      +0.0%       6.50 ±173%      +3.8%       6.75 ±164%  softirqs.CPU3.BLOCK
      1.00            +0.0%       1.00            +0.0%       1.00        softirqs.CPU3.NET_RX
      0.00          -100.0%       0.00          -100.0%       0.00        softirqs.CPU3.NET_TX
     12734 ± 25%     -17.4%      10522 ±  9%      -1.2%      12578 ± 27%  softirqs.CPU3.RCU
     31188 ± 49%     +22.6%      38228 ±  9%      -7.2%      28930 ± 51%  softirqs.CPU3.SCHED
     10.00 ±138%     -80.0%       2.00           -85.0%       1.50 ± 57%  softirqs.CPU3.TASKLET
    193.50 ± 39%    +358.4%     887.00 ± 62%    +381.7%     932.00 ± 80%  softirqs.CPU3.TIMER
      2.00 ±173%     -87.5%       0.25 ±173%    -100.0%       0.00        softirqs.CPU30.BLOCK
      1152 ± 91%    +130.8%       2660 ±156%    +301.4%       4626 ±169%  softirqs.CPU30.NET_RX
      2.00 ± 35%     -37.5%       1.25 ± 34%     -50.0%       1.00 ± 70%  softirqs.CPU30.NET_TX
     12397 ± 30%      +0.9%      12515 ± 34%     -20.1%       9907 ± 10%  softirqs.CPU30.RCU
     30522 ± 49%      +5.3%      32152 ± 50%     +31.8%      40225 ±  2%  softirqs.CPU30.SCHED
      0.25 ±173%    +300.0%       1.00 ±173%    -100.0%       0.00        softirqs.CPU30.TASKLET
      4575 ±111%     -78.2%     998.75 ±115%     -83.1%     774.00 ± 34%  softirqs.CPU30.TIMER
     10.00 ±103%    -100.0%       0.00            -7.5%       9.25 ±167%  softirqs.CPU31.BLOCK
     96.75 ±  5%   +1466.7%       1515 ±161%    +381.9%     466.25 ± 82%  softirqs.CPU31.NET_RX
      0.75 ± 57%    +100.0%       1.50 ± 33%    +133.3%       1.75 ± 47%  softirqs.CPU31.NET_TX
     13605 ± 25%      -0.5%      13531 ± 32%     +14.6%      15587 ± 23%  softirqs.CPU31.RCU
     23740 ± 81%      -5.7%      22393 ± 82%     -45.5%      12930 ±116%  softirqs.CPU31.SCHED
      0.00       +1.8e+102%       1.75 ±173%    -100.0%       0.00        softirqs.CPU31.TASKLET
    853.50 ± 97%    +106.2%       1759 ±116%     -37.9%     529.75 ±143%  softirqs.CPU31.TIMER
      0.00       +2.5e+101%       0.25 ±173% +4.2e+102%       4.25 ±159%  softirqs.CPU32.BLOCK
      9242 ±136%     -91.0%     836.25 ±151%     -96.0%     367.00 ± 84%  softirqs.CPU32.NET_RX
      1.25 ± 34%    +560.0%       8.25 ±152%     +60.0%       2.00 ± 35%  softirqs.CPU32.NET_TX
     11900 ± 23%     -13.1%      10341 ±  9%     -17.9%       9774 ±  7%  softirqs.CPU32.RCU
     31651 ± 49%      +1.7%      32186 ± 49%     +16.3%      36826 ± 15%  softirqs.CPU32.SCHED
      0.25 ±173%    -100.0%       0.00          +700.0%       2.00 ±173%  softirqs.CPU32.TASKLET
    436.50 ± 68%     +61.6%     705.50 ± 43%    +128.1%     995.50 ±101%  softirqs.CPU32.TIMER
     10.75 ±167%    -100.0%       0.00           -95.3%       0.50 ±100%  softirqs.CPU33.BLOCK
    164.25 ± 54%    +434.1%     877.25 ±125%     +56.8%     257.50 ± 96%  softirqs.CPU33.NET_RX
      1.00 ± 70%   +1550.0%      16.50 ± 85%     +25.0%       1.25 ± 87%  softirqs.CPU33.NET_TX
     16312 ± 26%      +0.2%      16346 ±  5%     -10.2%      14644 ± 19%  softirqs.CPU33.RCU
     14243 ±118%     -30.1%       9949 ± 88%      -5.9%      13395 ±118%  softirqs.CPU33.SCHED
      0.00       +2.5e+101%       0.25 ±173%   +5e+102%       5.00 ±122%  softirqs.CPU33.TASKLET
    464.75 ±147%     +63.2%     758.50 ±110%      +5.6%     490.75 ±134%  softirqs.CPU33.TIMER
      0.00       +2.5e+101%       0.25 ±173%    -100.0%       0.00        softirqs.CPU34.BLOCK
      0.50 ±173%     -50.0%       0.25 ±173%    -100.0%       0.00        softirqs.CPU34.NET_TX
     17840 ± 30%     -29.9%      12514 ± 32%     -39.7%      10749 ± 15%  softirqs.CPU34.RCU
     12922 ±117%    +144.2%      31563 ± 51%    +102.4%      26150 ± 61%  softirqs.CPU34.SCHED
      3.00 ±173%     -91.7%       0.25 ±173%    -100.0%       0.00        softirqs.CPU34.TASKLET
    698.50 ± 83%     +22.9%     858.75 ± 50%    +571.9%       4693 ±159%  softirqs.CPU34.TIMER
      0.00         +9e+102%       9.00 ±173% +2.5e+101%       0.25 ±173%  softirqs.CPU35.BLOCK
      1.00            +0.0%       1.00            +0.0%       1.00        softirqs.CPU35.NET_RX
      0.00          -100.0%       0.00         +7e+102%       7.00 ±173%  softirqs.CPU35.NET_TX
     13521 ± 26%     +19.4%      16139 ± 19%      +8.6%      14686 ± 21%  softirqs.CPU35.RCU
     29371 ± 53%     -34.8%      19155 ± 80%     -55.3%      13120 ±114%  softirqs.CPU35.SCHED
      2.25 ± 19%     +11.1%       2.50 ± 20%     +44.4%       3.25 ± 50%  softirqs.CPU35.TASKLET
    874.75 ±101%     -30.8%     605.00 ± 99%     -75.3%     216.50 ±152%  softirqs.CPU35.TIMER
      0.00       +1.2e+103%      11.50 ±173%   +1e+103%      10.00 ±103%  softirqs.CPU36.BLOCK
      0.00          -100.0%       0.00       +2.5e+101%       0.25 ±173%  softirqs.CPU36.NET_TX
     15561 ± 32%      -7.7%      14357 ± 25%     -27.8%      11240 ± 10%  softirqs.CPU36.RCU
     16849 ± 93%     +33.6%      22508 ± 81%     +88.0%      31672 ± 50%  softirqs.CPU36.SCHED
      6.25 ±173%    -100.0%       0.00           -16.0%       5.25 ±173%  softirqs.CPU36.TASKLET
    870.50 ±126%     -65.6%     299.25 ±120%     +61.6%       1407 ±132%  softirqs.CPU36.TIMER
      7.00 ±173%     -82.1%       1.25 ±173%    -100.0%       0.00        softirqs.CPU37.BLOCK
     15273 ± 21%      +5.0%      16043 ± 13%      -1.7%      15015 ± 32%  softirqs.CPU37.RCU
     16449 ± 99%     +38.9%      22850 ± 80%     +25.4%      20630 ± 83%  softirqs.CPU37.SCHED
    453.00 ± 92%     +16.2%     526.25 ±116%      -9.2%     411.25 ±142%  softirqs.CPU37.TIMER
      0.00         +3e+103%      30.25 ±132%    -100.0%       0.00        softirqs.CPU38.BLOCK
      0.25 ±173%   +2700.0%       7.00 ±173%    -100.0%       0.00        softirqs.CPU38.NET_TX
     19258 ± 10%     -22.4%      14941 ± 31%     -35.1%      12506 ± 14%  softirqs.CPU38.RCU
      8721 ± 84%    +157.6%      22464 ± 78%    +310.3%      35784 ± 17%  softirqs.CPU38.SCHED
      0.25 ±173%    -100.0%       0.00          +800.0%       2.25 ±173%  softirqs.CPU38.TASKLET
    174.50 ±145%    +431.7%     927.75 ± 95%    +414.0%     897.00 ± 72%  softirqs.CPU38.TIMER
      0.50 ±173%   +2200.0%      11.50 ±173%   +2300.0%      12.00 ±158%  softirqs.CPU39.BLOCK
     11520 ± 14%     +23.8%      14259 ± 18%     +48.6%      17122 ± 25%  softirqs.CPU39.RCU
     39392 ±  7%     -43.3%      22330 ± 82%     -66.4%      13238 ±121%  softirqs.CPU39.SCHED
      0.25 ±173%    +900.0%       2.50 ±173%    -100.0%       0.00        softirqs.CPU39.TASKLET
      2005 ±142%     -89.6%     208.00 ±119%     -88.0%     239.75 ±144%  softirqs.CPU39.TIMER
      4.25 ±159%     -17.6%       3.50 ±173%    -100.0%       0.00        softirqs.CPU4.BLOCK
      1.00            +0.0%       1.00            +0.0%       1.00        softirqs.CPU4.NET_RX
     18470 ±  6%     -23.5%      14128 ± 29%      -7.8%      17025 ± 20%  softirqs.CPU4.RCU
      7406 ± 80%    +215.6%      23377 ± 80%     +63.7%      12123 ±129%  softirqs.CPU4.SCHED
      4.50 ± 96%     -66.7%       1.50 ± 57%     -55.6%       2.00        softirqs.CPU4.TASKLET
    450.75 ±103%      +8.6%     489.50 ±115%     -71.8%     127.25 ± 88%  softirqs.CPU4.TIMER
     14.25 ±100%     -19.3%      11.50 ±173%     -96.5%       0.50 ±173%  softirqs.CPU40.BLOCK
      0.00         +5e+101%       0.50 ±173%    -100.0%       0.00        softirqs.CPU40.NET_TX
     19452 ±  6%     -28.5%      13915 ± 17%     -36.5%      12345 ± 22%  softirqs.CPU40.RCU
      4314 ±  4%    +421.7%      22510 ± 80%    +415.8%      22253 ± 83%  softirqs.CPU40.SCHED
      0.00       +1.2e+103%      11.50 ±100%   +5e+101%       0.50 ±100%  softirqs.CPU40.TASKLET
     85.75 ± 85%    +234.7%     287.00 ± 97%    +311.4%     352.75 ± 91%  softirqs.CPU40.TIMER
      0.00          -100.0%       0.00       +1.2e+103%      12.00 ±173%  softirqs.CPU41.BLOCK
     10744 ±  6%      +7.8%      11578 ± 25%     +48.8%      15985 ± 22%  softirqs.CPU41.RCU
     41796 ±  2%     -25.1%      31312 ± 49%     -68.4%      13205 ±122%  softirqs.CPU41.SCHED
      0.50 ±173%   +1650.0%       8.75 ±173%    -100.0%       0.00        softirqs.CPU41.TASKLET
      1374 ±139%     +54.2%       2119 ±144%     -89.5%     144.25 ±142%  softirqs.CPU41.TIMER
      0.50 ±173%      +0.0%       0.50 ±173%   +8850.0%      44.75 ±173%  softirqs.CPU42.BLOCK
     17680 ± 23%     -13.0%      15373 ± 18%     -17.2%      14642 ± 28%  softirqs.CPU42.RCU
     13698 ±118%      -3.3%      13244 ±116%    +115.7%      29541 ± 51%  softirqs.CPU42.SCHED
      0.50 ±173%    +250.0%       1.75 ±142%     -50.0%       0.25 ±173%  softirqs.CPU42.TASKLET
    149.50 ± 93%    +163.5%     394.00 ±140%    +619.4%       1075 ±116%  softirqs.CPU42.TIMER
     28.00 ±100%     -98.2%       0.50 ±173%    -100.0%       0.00        softirqs.CPU43.BLOCK
     10851 ±  6%      +5.2%      11412 ± 21%     +41.7%      15375 ± 22%  softirqs.CPU43.RCU
     41192 ±  3%     -23.8%      31387 ± 48%     -67.1%      13537 ±117%  softirqs.CPU43.SCHED
      1.00 ±173%     -75.0%       0.25 ±173%     -25.0%       0.75 ±110%  softirqs.CPU43.TASKLET
    395.75 ±115%    +102.2%     800.25 ± 80%     -54.9%     178.50 ±148%  softirqs.CPU43.TIMER
      0.50 ±173%    -100.0%       0.00         +1400.0%       7.50 ±158%  softirqs.CPU44.BLOCK
     20418 ±  9%     -23.0%      15721 ± 22%     -33.6%      13552 ± 21%  softirqs.CPU44.RCU
      4067 ± 14%    +257.3%      14533 ± 99%    +528.1%      25546 ± 59%  softirqs.CPU44.SCHED
      6.50 ±164%    -100.0%       0.00           -42.3%       3.75 ±131%  softirqs.CPU44.TASKLET
     53.50 ± 97%    +806.1%     484.75 ±120%   +1304.7%     751.50 ± 97%  softirqs.CPU44.TIMER
     58.25 ±131%    -100.0%       0.00          -100.0%       0.00        softirqs.CPU45.BLOCK
      0.00          -100.0%       0.00          -100.0%       0.00        softirqs.CPU45.NET_TX
     13306 ± 36%     -11.2%      11817 ± 23%      +0.4%      13359 ± 20%  softirqs.CPU45.RCU
     31880 ± 48%      -2.2%      31177 ± 49%      -8.3%      29224 ± 52%  softirqs.CPU45.SCHED
      3.00 ±173%    -100.0%       0.00          -100.0%       0.00        softirqs.CPU45.TASKLET
    689.00 ± 62%      -6.6%     643.25 ± 66%    +118.3%       1504 ± 84%  softirqs.CPU45.TIMER
      0.00       +1.1e+103%      10.75 ±173%    -100.0%       0.00        softirqs.CPU46.BLOCK
     19591 ±  7%     -21.7%      15339 ± 25%     -37.7%      12202 ± 26%  softirqs.CPU46.RCU
      4230 ±  2%    +182.5%      11951 ±135%    +642.2%      31400 ± 50%  softirqs.CPU46.SCHED
      0.75 ±173%     -66.7%       0.25 ±173%    +633.3%       5.50 ±173%  softirqs.CPU46.TASKLET
     23.25 ± 21%   +3022.6%     726.00 ±163%   +8469.9%       1992 ± 91%  softirqs.CPU46.TIMER
      0.00       +7.7e+103%      76.75 ± 71% +7.5e+102%       7.50 ±158%  softirqs.CPU47.BLOCK
     11180 ± 13%      +1.4%      11341 ±  8%      +8.5%      12127 ±  9%  softirqs.CPU47.RCU
     37249 ± 13%      -1.5%      36683 ± 16%      -8.9%      33932 ± 17%  softirqs.CPU47.SCHED
      0.00          -100.0%       0.00       +3.5e+102%       3.50 ±157%  softirqs.CPU47.TASKLET
      2282 ±107%     -74.1%     591.50 ± 50%     -39.1%       1390 ± 85%  softirqs.CPU47.TIMER
     10.75 ±167%    -100.0%       0.00           +72.1%      18.50 ±133%  softirqs.CPU5.BLOCK
      1.00            +0.0%       1.00            +0.0%       1.00        softirqs.CPU5.NET_RX
      0.00          -100.0%       0.00       +2.5e+101%       0.25 ±173%  softirqs.CPU5.NET_TX
     14707 ± 30%     -17.6%      12117 ± 35%     -12.8%      12828 ± 26%  softirqs.CPU5.RCU
     23434 ± 67%     +33.9%      31386 ± 52%     +33.9%      31375 ± 50%  softirqs.CPU5.SCHED
      2.00            +0.0%       2.00           -25.0%       1.50 ± 57%  softirqs.CPU5.TASKLET
    187.50 ± 71%   +1639.9%       3262 ± 93%     +81.1%     339.50 ± 84%  softirqs.CPU5.TIMER
      0.00          -100.0%       0.00       +6.5e+102%       6.50 ±173%  softirqs.CPU6.BLOCK
      1.00            +0.0%       1.00            +0.0%       1.00        softirqs.CPU6.NET_RX
      0.25 ±173%    -100.0%       0.00          -100.0%       0.00        softirqs.CPU6.NET_TX
     16975 ± 24%      -5.9%      15965 ± 22%      +5.4%      17890 ±  8%  softirqs.CPU6.RCU
     15049 ±105%      -8.9%      13717 ±113%     -73.0%       4058 ±  7%  softirqs.CPU6.SCHED
      2.00          +275.0%       7.50 ±127%     +25.0%       2.50 ± 34%  softirqs.CPU6.TASKLET
    208.75 ±102%    +253.3%     737.50 ±111%     +43.5%     299.50 ±104%  softirqs.CPU6.TIMER
     43.50 ±173%     -79.3%       9.00 ±173%    -100.0%       0.00        softirqs.CPU7.BLOCK
     14964 ± 34%      -7.2%      13880 ± 27%     -18.5%      12199 ± 27%  softirqs.CPU7.RCU
     21843 ± 80%      +3.6%      22628 ± 80%     +44.3%      31530 ± 49%  softirqs.CPU7.SCHED
    185.00 ±171%     -98.2%       3.25 ± 50%     -98.9%       2.00        softirqs.CPU7.TASKLET
      1793 ±161%     -10.8%       1600 ±127%     -71.7%     507.75 ± 85%  softirqs.CPU7.TIMER
    226.75 ± 62%     +20.0%     272.00 ± 23%     +34.1%     304.00 ± 21%  softirqs.CPU8.BLOCK
     16497 ± 25%      -5.8%      15535 ± 28%      +4.0%      17162 ±  8%  softirqs.CPU8.RCU
     13789 ±123%      +1.5%      14001 ±117%     -49.0%       7031 ± 90%  softirqs.CPU8.SCHED
    597.75 ± 55%     +30.7%     781.25           +31.3%     784.75        softirqs.CPU8.TASKLET
    308.50 ±143%    +878.0%       3017 ±162%     -45.8%     167.25 ±146%  softirqs.CPU8.TIMER
      0.00       +6.7e+102%       6.75 ±164%    -100.0%       0.00        softirqs.CPU9.BLOCK
      0.25 ±173%    -100.0%       0.00          -100.0%       0.00        softirqs.CPU9.HI
     13678 ± 27%      -5.9%      12876 ± 40%      -9.5%      12377 ± 28%  softirqs.CPU9.RCU
     31545 ± 49%     +14.6%      36152 ± 25%      +1.2%      31919 ± 50%  softirqs.CPU9.SCHED
     83.00            -0.9%      82.25            +0.9%      83.75 ±  2%  softirqs.CPU9.TASKLET
    439.50 ± 46%    +109.2%     919.25 ± 52%     -32.8%     295.50 ± 49%  softirqs.CPU9.TIMER
      2.50 ± 20%     -20.0%       2.00           -20.0%       2.00        softirqs.HI
     18503 ± 90%      +4.7%      19377 ± 42%     -56.8%       7984 ± 88%  softirqs.NET_RX
     43.25 ±  3%      -0.6%      43.00 ±  5%      +0.0%      43.25 ±  4%  softirqs.NET_TX
    711396 ±  5%      -5.7%     670504 ±  4%      -4.9%     676860 ±  6%  softirqs.RCU
   1074239 ±  4%      -0.4%    1070231            -0.4%    1070269        softirqs.SCHED
      1005 ±  2%      -0.1%       1004            +0.3%       1008        softirqs.TASKLET
     39167 ±  7%      -3.1%      37944 ±  7%      -7.8%      36101 ±  5%  softirqs.TIMER
    133576            +0.0%     133629            +0.0%     133592        slabinfo.Acpi-Operand.active_objs
      2386            +0.0%       2386            +0.0%       2386        slabinfo.Acpi-Operand.active_slabs
    133624            +0.0%     133642            -0.0%     133619        slabinfo.Acpi-Operand.num_objs
      2386            +0.0%       2386            +0.0%       2386        slabinfo.Acpi-Operand.num_slabs
      1186 ± 10%      -3.1%       1149 ± 13%      -1.5%       1168 ±  9%  slabinfo.Acpi-Parse.active_objs
     16.25 ± 10%      -3.1%      15.75 ± 13%      -1.5%      16.00 ±  9%  slabinfo.Acpi-Parse.active_slabs
      1186 ± 10%      -3.1%       1149 ± 13%      -1.5%       1168 ±  9%  slabinfo.Acpi-Parse.num_objs
     16.25 ± 10%      -3.1%      15.75 ± 13%      -1.5%      16.00 ±  9%  slabinfo.Acpi-Parse.num_slabs
      2498            -0.0%       2497            -0.0%       2497        slabinfo.Acpi-State.active_objs
     48.50            -1.0%      48.00            -0.5%      48.25        slabinfo.Acpi-State.active_slabs
      2498            -0.0%       2497            -0.0%       2497        slabinfo.Acpi-State.num_objs
     48.50            -1.0%      48.00            -0.5%      48.25        slabinfo.Acpi-State.num_slabs
      1227 ±  6%      +3.4%       1269 ±  8%      +8.0%       1325 ±  7%  slabinfo.PING.active_objs
     38.00 ±  6%      +3.3%      39.25 ±  7%      +7.9%      41.00 ±  7%  slabinfo.PING.active_slabs
      1227 ±  6%      +3.4%       1269 ±  8%      +8.0%       1325 ±  7%  slabinfo.PING.num_objs
     38.00 ±  6%      +3.3%      39.25 ±  7%      +7.9%      41.00 ±  7%  slabinfo.PING.num_slabs
    352.00            +0.0%     352.00            +0.0%     352.00        slabinfo.RAW.active_objs
     11.00            +0.0%      11.00            +0.0%      11.00        slabinfo.RAW.active_slabs
    352.00            +0.0%     352.00            +0.0%     352.00        slabinfo.RAW.num_objs
     11.00            +0.0%      11.00            +0.0%      11.00        slabinfo.RAW.num_slabs
    182.00            +0.0%     182.00            +0.0%     182.00        slabinfo.RAWv6.active_objs
      7.00            +0.0%       7.00            +0.0%       7.00        slabinfo.RAWv6.active_slabs
    182.00            +0.0%     182.00            +0.0%     182.00        slabinfo.RAWv6.num_objs
      7.00            +0.0%       7.00            +0.0%       7.00        slabinfo.RAWv6.num_slabs
     42.00            -8.3%      38.50 ± 15%      +0.0%      42.00        slabinfo.TCP.active_objs
      3.00            -8.3%       2.75 ± 15%      +0.0%       3.00        slabinfo.TCP.active_slabs
     42.00            -8.3%      38.50 ± 15%      +0.0%      42.00        slabinfo.TCP.num_objs
      3.00            -8.3%       2.75 ± 15%      +0.0%       3.00        slabinfo.TCP.num_slabs
     22.75 ± 24%     +14.3%      26.00           +14.3%      26.00        slabinfo.TCPv6.active_objs
      1.75 ± 24%     +14.3%       2.00           +14.3%       2.00        slabinfo.TCPv6.active_slabs
     22.75 ± 24%     +14.3%      26.00           +14.3%      26.00        slabinfo.TCPv6.num_objs
      1.75 ± 24%     +14.3%       2.00           +14.3%       2.00        slabinfo.TCPv6.num_slabs
    126.75 ± 13%      -5.3%     120.00 ± 19%      +3.9%     131.75 ±  2%  slabinfo.UDPv6.active_objs
      4.75 ± 17%      -5.3%       4.50 ± 24%      +5.3%       5.00        slabinfo.UDPv6.active_slabs
    126.75 ± 13%      -5.3%     120.00 ± 19%      +3.9%     131.75 ±  2%  slabinfo.UDPv6.num_objs
      4.75 ± 17%      -5.3%       4.50 ± 24%      +5.3%       5.00        slabinfo.UDPv6.num_slabs
     16501 ±  2%      +1.3%      16720 ±  3%      +2.4%      16891 ±  2%  slabinfo.anon_vma.active_objs
    357.75 ±  2%      +1.3%     362.50 ±  3%      +2.4%     366.25 ±  2%  slabinfo.anon_vma.active_slabs
     16501 ±  2%      +1.3%      16720 ±  3%      +2.4%      16891 ±  2%  slabinfo.anon_vma.num_objs
    357.75 ±  2%      +1.3%     362.50 ±  3%      +2.4%     366.25 ±  2%  slabinfo.anon_vma.num_slabs
     37002 ±  3%      +0.0%      37002 ±  7%      +4.1%      38528 ±  4%  slabinfo.anon_vma_chain.active_objs
    585.00 ±  3%      -0.8%     580.25 ±  7%      +2.8%     601.25 ±  4%  slabinfo.anon_vma_chain.active_slabs
     37474 ±  3%      -0.8%      37175 ±  7%      +2.8%      38528 ±  4%  slabinfo.anon_vma_chain.num_objs
    585.00 ±  3%      -0.8%     580.25 ±  7%      +2.8%     601.25 ±  4%  slabinfo.anon_vma_chain.num_slabs
    409.50 ±  8%      -9.5%     370.50 ± 11%      -2.4%     399.75 ± 14%  slabinfo.bdev_cache.active_objs
     10.50 ±  8%      -9.5%       9.50 ± 11%      -2.4%      10.25 ± 14%  slabinfo.bdev_cache.active_slabs
    409.50 ±  8%      -9.5%     370.50 ± 11%      -2.4%     399.75 ± 14%  slabinfo.bdev_cache.num_objs
     10.50 ±  8%      -9.5%       9.50 ± 11%      -2.4%      10.25 ± 14%  slabinfo.bdev_cache.num_slabs
    108.00 ± 19%      -3.7%     104.00 ±  7%      -3.7%     104.00 ±  7%  slabinfo.biovec-128.active_objs
      6.75 ± 19%      -3.7%       6.50 ±  7%      -3.7%       6.50 ±  7%  slabinfo.biovec-128.active_slabs
    108.00 ± 19%      -3.7%     104.00 ±  7%      -3.7%     104.00 ±  7%  slabinfo.biovec-128.num_objs
      6.75 ± 19%      -3.7%       6.50 ±  7%      -3.7%       6.50 ±  7%  slabinfo.biovec-128.num_slabs
    280.00 ±  4%      -5.7%     264.00 ± 10%      +2.9%     288.00 ± 17%  slabinfo.biovec-64.active_objs
      8.75 ±  4%      -5.7%       8.25 ± 10%      +2.9%       9.00 ± 17%  slabinfo.biovec-64.active_slabs
    280.00 ±  4%      -5.7%     264.00 ± 10%      +2.9%     288.00 ± 17%  slabinfo.biovec-64.num_objs
      8.75 ±  4%      -5.7%       8.25 ± 10%      +2.9%       9.00 ± 17%  slabinfo.biovec-64.num_slabs
     84.00 ±  4%      +9.5%      92.00 ±  4%      -9.5%      76.00 ±  5%  slabinfo.biovec-max.active_objs
     10.50 ±  4%      +9.5%      11.50 ±  4%      -9.5%       9.50 ±  5%  slabinfo.biovec-max.active_slabs
     84.00 ±  4%      +9.5%      92.00 ±  4%      -9.5%      76.00 ±  5%  slabinfo.biovec-max.num_objs
     10.50 ±  4%      +9.5%      11.50 ±  4%      -9.5%       9.50 ±  5%  slabinfo.biovec-max.num_slabs
    477.75 ±  3%     -12.2%     419.25 ±  4%      -4.1%     458.25 ± 11%  slabinfo.blkdev_ioc.active_objs
     12.25 ±  3%     -12.2%      10.75 ±  4%      -4.1%      11.75 ± 11%  slabinfo.blkdev_ioc.active_slabs
    477.75 ±  3%     -12.2%     419.25 ±  4%      -4.1%     458.25 ± 11%  slabinfo.blkdev_ioc.num_objs
     12.25 ±  3%     -12.2%      10.75 ±  4%      -4.1%      11.75 ± 11%  slabinfo.blkdev_ioc.num_slabs
    136.50 ± 14%     +14.3%     156.00           -14.3%     117.00        slabinfo.buffer_head.active_objs
      3.50 ± 14%     +14.3%       4.00           -14.3%       3.00        slabinfo.buffer_head.active_slabs
    136.50 ± 14%     +14.3%     156.00           -14.3%     117.00        slabinfo.buffer_head.num_objs
      3.50 ± 14%     +14.3%       4.00           -14.3%       3.00        slabinfo.buffer_head.num_slabs
      2908 ±  2%      -1.4%       2866            +1.1%       2941 ±  2%  slabinfo.cred_jar.active_objs
     68.75 ±  2%      -1.1%      68.00            +1.5%      69.75 ±  2%  slabinfo.cred_jar.active_slabs
      2908 ±  2%      -1.4%       2866            +1.1%       2941 ±  2%  slabinfo.cred_jar.num_objs
     68.75 ±  2%      -1.1%      68.00            +1.5%      69.75 ±  2%  slabinfo.cred_jar.num_slabs
     42.00            +0.0%      42.00            +0.0%      42.00        slabinfo.dax_cache.active_objs
      1.00            +0.0%       1.00            +0.0%       1.00        slabinfo.dax_cache.active_slabs
     42.00            +0.0%      42.00            +0.0%      42.00        slabinfo.dax_cache.num_objs
      1.00            +0.0%       1.00            +0.0%       1.00        slabinfo.dax_cache.num_slabs
     93943            +0.7%      94600            -0.2%      93761        slabinfo.dentry.active_objs
      2258            +0.7%       2274            +0.2%       2261        slabinfo.dentry.active_slabs
     94861            +0.7%      95554            +0.2%      95025        slabinfo.dentry.num_objs
      2258            +0.7%       2274            +0.2%       2261        slabinfo.dentry.num_slabs
     30.00            +0.0%      30.00            +0.0%      30.00        slabinfo.dmaengine-unmap-128.active_objs
      1.00            +0.0%       1.00            +0.0%       1.00        slabinfo.dmaengine-unmap-128.active_slabs
     30.00            +0.0%      30.00            +0.0%      30.00        slabinfo.dmaengine-unmap-128.num_objs
      1.00            +0.0%       1.00            +0.0%       1.00        slabinfo.dmaengine-unmap-128.num_slabs
      1341 ± 11%      +2.5%       1374 ± 13%     -17.2%       1110 ±  8%  slabinfo.dmaengine-unmap-16.active_objs
     31.50 ± 12%      +2.4%      32.25 ± 14%     -17.5%      26.00 ±  8%  slabinfo.dmaengine-unmap-16.active_slabs
      1341 ± 11%      +2.5%       1374 ± 13%     -17.2%       1110 ±  8%  slabinfo.dmaengine-unmap-16.num_objs
     31.50 ± 12%      +2.4%      32.25 ± 14%     -17.5%      26.00 ±  8%  slabinfo.dmaengine-unmap-16.num_slabs
     15.00            +0.0%      15.00            +0.0%      15.00        slabinfo.dmaengine-unmap-256.active_objs
      1.00            +0.0%       1.00            +0.0%       1.00        slabinfo.dmaengine-unmap-256.active_slabs
     15.00            +0.0%      15.00            +0.0%      15.00        slabinfo.dmaengine-unmap-256.num_objs
      1.00            +0.0%       1.00            +0.0%       1.00        slabinfo.dmaengine-unmap-256.num_slabs
      2590 ±  2%      +0.9%       2613 ±  2%      -5.8%       2439 ±  3%  slabinfo.eventpoll_pwq.active_objs
     46.25 ±  2%      +0.5%      46.50 ±  3%      -5.9%      43.50 ±  4%  slabinfo.eventpoll_pwq.active_slabs
      2590 ±  2%      +0.9%       2613 ±  2%      -5.8%       2439 ±  3%  slabinfo.eventpoll_pwq.num_objs
     46.25 ±  2%      +0.5%      46.50 ±  3%      -5.9%      43.50 ±  4%  slabinfo.eventpoll_pwq.num_slabs
    781.00 ± 13%      -4.3%     747.50 ± 10%      -2.2%     764.00 ± 18%  slabinfo.file_lock_cache.active_objs
     21.00 ± 13%      -4.8%      20.00 ± 11%      -3.6%      20.25 ± 19%  slabinfo.file_lock_cache.active_slabs
    781.00 ± 13%      -4.3%     747.50 ± 10%      -2.2%     764.00 ± 18%  slabinfo.file_lock_cache.num_objs
     21.00 ± 13%      -4.8%      20.00 ± 11%      -3.6%      20.25 ± 19%  slabinfo.file_lock_cache.num_slabs
      2379            +1.3%       2410            +1.4%       2412        slabinfo.files_cache.active_objs
     51.00            +2.0%      52.00            +1.5%      51.75        slabinfo.files_cache.active_slabs
      2379            +1.3%       2410            +1.4%       2412        slabinfo.files_cache.num_objs
     51.00            +2.0%      52.00            +1.5%      51.75        slabinfo.files_cache.num_slabs
     24562 ±  4%     +10.3%      27098 ±  2%      +6.5%      26154        slabinfo.filp.active_objs
    395.25 ±  4%     +10.0%     434.75            +5.8%     418.00        slabinfo.filp.active_slabs
     25333 ±  4%     +10.0%      27863            +5.7%      26778        slabinfo.filp.num_objs
    395.25 ±  4%     +10.0%     434.75            +5.8%     418.00        slabinfo.filp.num_slabs
      2199 ±  8%     +12.1%       2464 ± 15%      -6.9%       2048 ±  4%  slabinfo.fsnotify_mark_connector.active_objs
     17.00 ±  7%     +13.2%      19.25 ± 15%      -5.9%      16.00 ±  4%  slabinfo.fsnotify_mark_connector.active_slabs
      2199 ±  8%     +12.1%       2464 ± 15%      -6.9%       2048 ±  4%  slabinfo.fsnotify_mark_connector.num_objs
     17.00 ±  7%     +13.2%      19.25 ± 15%      -5.9%      16.00 ±  4%  slabinfo.fsnotify_mark_connector.num_slabs
     19125            +0.3%      19188            -0.9%      18955        slabinfo.ftrace_event_field.active_objs
    225.00            +0.3%     225.75            -0.9%     223.00        slabinfo.ftrace_event_field.active_slabs
     19125            +0.3%      19188            -0.9%      18955        slabinfo.ftrace_event_field.num_objs
    225.00            +0.3%     225.75            -0.9%     223.00        slabinfo.ftrace_event_field.num_slabs
    104.00            +0.0%     104.00            +0.0%     104.00        slabinfo.hugetlbfs_inode_cache.active_objs
      2.00            +0.0%       2.00            +0.0%       2.00        slabinfo.hugetlbfs_inode_cache.active_slabs
    104.00            +0.0%     104.00            +0.0%     104.00        slabinfo.hugetlbfs_inode_cache.num_objs
      2.00            +0.0%       2.00            +0.0%       2.00        slabinfo.hugetlbfs_inode_cache.num_slabs
     71073            +0.4%      71363            -0.6%      70626        slabinfo.inode_cache.active_objs
      1319            +0.4%       1324            -0.6%       1311        slabinfo.inode_cache.active_slabs
     71263            +0.4%      71561            -0.6%      70827        slabinfo.inode_cache.num_objs
      1319            +0.4%       1324            -0.6%       1311        slabinfo.inode_cache.num_slabs
     44.00            +0.0%      44.00            +0.0%      44.00        slabinfo.ip6-frags.active_objs
      1.00            +0.0%       1.00            +0.0%       1.00        slabinfo.ip6-frags.active_slabs
     44.00            +0.0%      44.00            +0.0%      44.00        slabinfo.ip6-frags.num_objs
      1.00            +0.0%       1.00            +0.0%       1.00        slabinfo.ip6-frags.num_slabs
     55863            +0.5%      56160            -0.6%      55527        slabinfo.kernfs_node_cache.active_objs
    872.75            +0.5%     877.50            -0.6%     867.50        slabinfo.kernfs_node_cache.active_slabs
     55863            +0.5%      56160            -0.6%      55527        slabinfo.kernfs_node_cache.num_objs
    872.75            +0.5%     877.50            -0.6%     867.50        slabinfo.kernfs_node_cache.num_slabs
    944.25 ± 13%      +9.2%       1031 ± 16%      +4.8%     989.25 ± 13%  slabinfo.khugepaged_mm_slot.active_objs
     25.50 ± 13%     +10.8%      28.25 ± 16%      +4.9%      26.75 ± 13%  slabinfo.khugepaged_mm_slot.active_slabs
    944.25 ± 13%      +9.2%       1031 ± 16%      +4.8%     989.25 ± 13%  slabinfo.khugepaged_mm_slot.num_objs
     25.50 ± 13%     +10.8%      28.25 ± 16%      +4.9%      26.75 ± 13%  slabinfo.khugepaged_mm_slot.num_slabs
      4144            +0.3%       4158            -0.1%       4140        slabinfo.kmalloc-128.active_objs
     67.00 ±  2%      -1.5%      66.00            -1.5%      66.00 ±  2%  slabinfo.kmalloc-128.active_slabs
      4319 ±  3%      -1.4%       4258            -1.1%       4270 ±  2%  slabinfo.kmalloc-128.num_objs
     67.00 ±  2%      -1.5%      66.00            -1.5%      66.00 ±  2%  slabinfo.kmalloc-128.num_slabs
     18368            +1.0%      18560            +1.0%      18560        slabinfo.kmalloc-16.active_objs
     71.75            +1.0%      72.50            +1.0%      72.50        slabinfo.kmalloc-16.active_slabs
     18368            +1.0%      18560            +1.0%      18560        slabinfo.kmalloc-16.num_objs
     71.75            +1.0%      72.50            +1.0%      72.50        slabinfo.kmalloc-16.num_slabs
      2889            +0.5%       2904            +1.2%       2922        slabinfo.kmalloc-192.active_objs
     69.25            +1.1%      70.00            +2.2%      70.75        slabinfo.kmalloc-192.active_slabs
      2908            +1.1%       2940            +3.2%       3002        slabinfo.kmalloc-192.num_objs
     69.25            +1.1%      70.00            +2.2%      70.75        slabinfo.kmalloc-192.num_slabs
      3645 ±  4%      -0.0%       3645 ±  4%      -4.0%       3501        slabinfo.kmalloc-1k.active_objs
    116.50 ±  3%      -0.4%     116.00 ±  4%      -4.5%     111.25 ±  2%  slabinfo.kmalloc-1k.active_slabs
      3753 ±  3%      -0.3%       3743 ±  4%      -4.7%       3575 ±  2%  slabinfo.kmalloc-1k.num_objs
    116.50 ±  3%      -0.4%     116.00 ±  4%      -4.5%     111.25 ±  2%  slabinfo.kmalloc-1k.num_slabs
      5019            -0.4%       4998            -2.6%       4887        slabinfo.kmalloc-256.active_objs
     80.75            -0.3%      80.50 ±  2%      -2.8%      78.50        slabinfo.kmalloc-256.active_slabs
      5168            -0.1%       5162 ±  2%      -2.8%       5024        slabinfo.kmalloc-256.num_objs
     80.75            -0.3%      80.50 ±  2%      -2.8%      78.50        slabinfo.kmalloc-256.num_slabs
      3820 ±  2%      -2.3%       3731 ±  2%      +2.0%       3898 ±  3%  slabinfo.kmalloc-2k.active_objs
    245.25 ±  2%      -1.7%     241.00            +2.1%     250.50 ±  3%  slabinfo.kmalloc-2k.active_slabs
      3927 ±  2%      -1.6%       3863            +2.1%       4010 ±  3%  slabinfo.kmalloc-2k.num_objs
    245.25 ±  2%      -1.7%     241.00            +2.1%     250.50 ±  3%  slabinfo.kmalloc-2k.num_slabs
     53633 ±  2%      +1.8%      54583 ±  3%      -0.7%      53266 ±  3%  slabinfo.kmalloc-32.active_objs
    420.50            +2.3%     430.25 ±  3%      -0.5%     418.25 ±  3%  slabinfo.kmalloc-32.active_slabs
     53886 ±  2%      +2.2%      55081 ±  3%      -0.6%      53567 ±  4%  slabinfo.kmalloc-32.num_objs
    420.50            +2.3%     430.25 ±  3%      -0.5%     418.25 ±  3%  slabinfo.kmalloc-32.num_slabs
      1286            +0.5%       1292            +0.3%       1289 ±  2%  slabinfo.kmalloc-4k.active_objs
    162.50            +0.8%     163.75            +0.3%     163.00 ±  2%  slabinfo.kmalloc-4k.active_slabs
      1307            +0.8%       1317            +0.3%       1311 ±  2%  slabinfo.kmalloc-4k.num_objs
    162.50            +0.8%     163.75            +0.3%     163.00 ±  2%  slabinfo.kmalloc-4k.num_slabs
     13867 ±  2%      +0.2%      13891 ±  3%      +5.1%      14569 ±  4%  slabinfo.kmalloc-512.active_objs
    218.25            +0.0%     218.25 ±  3%      +5.4%     230.00 ±  4%  slabinfo.kmalloc-512.active_slabs
     13990            +0.1%      14009 ±  3%      +5.4%      14748 ±  4%  slabinfo.kmalloc-512.num_objs
    218.25            +0.0%     218.25 ±  3%      +5.4%     230.00 ±  4%  slabinfo.kmalloc-512.num_slabs
     34540            +1.5%      35051            -1.3%      34098        slabinfo.kmalloc-64.active_objs
    541.75            +1.3%     549.00            -1.3%     534.50        slabinfo.kmalloc-64.active_slabs
     34703            +1.2%      35136            -1.4%      34219        slabinfo.kmalloc-64.num_objs
    541.75            +1.3%     549.00            -1.3%     534.50        slabinfo.kmalloc-64.num_slabs
     27008 ±  2%      +0.9%      27264            -0.9%      26752        slabinfo.kmalloc-8.active_objs
     52.75 ±  2%      +0.9%      53.25            -0.9%      52.25        slabinfo.kmalloc-8.active_slabs
     27008 ±  2%      +0.9%      27264            -0.9%      26752        slabinfo.kmalloc-8.num_objs
     52.75 ±  2%      +0.9%      53.25            -0.9%      52.25        slabinfo.kmalloc-8.num_slabs
    344.00            +0.7%     346.25            +0.4%     345.25        slabinfo.kmalloc-8k.active_objs
     92.50            +0.5%      93.00            +0.3%      92.75        slabinfo.kmalloc-8k.active_slabs
    373.00            +0.5%     375.00            +0.3%     374.00        slabinfo.kmalloc-8k.num_objs
     92.50            +0.5%      93.00            +0.3%      92.75        slabinfo.kmalloc-8k.num_slabs
      6541 ±  3%      +4.1%       6806 ±  5%      +5.5%       6903 ±  3%  slabinfo.kmalloc-96.active_objs
    156.00 ±  2%      +4.0%     162.25 ±  5%      +6.1%     165.50 ±  3%  slabinfo.kmalloc-96.active_slabs
      6571 ±  2%      +4.2%       6848 ±  5%      +6.0%       6967 ±  3%  slabinfo.kmalloc-96.num_objs
    156.00 ±  2%      +4.0%     162.25 ±  5%      +6.1%     165.50 ±  3%  slabinfo.kmalloc-96.num_slabs
    592.00 ± 24%     +29.7%     768.00 ± 10%     +35.1%     800.00 ±  8%  slabinfo.kmalloc-rcl-128.active_objs
      9.25 ± 24%     +29.7%      12.00 ± 10%     +35.1%      12.50 ±  8%  slabinfo.kmalloc-rcl-128.active_slabs
    592.00 ± 24%     +29.7%     768.00 ± 10%     +35.1%     800.00 ±  8%  slabinfo.kmalloc-rcl-128.num_objs
      9.25 ± 24%     +29.7%      12.00 ± 10%     +35.1%      12.50 ±  8%  slabinfo.kmalloc-rcl-128.num_slabs
    420.00 ± 30%     +30.0%     546.00 ±  9%     +37.5%     577.50 ± 10%  slabinfo.kmalloc-rcl-192.active_objs
     10.00 ± 30%     +30.0%      13.00 ±  9%     +37.5%      13.75 ± 10%  slabinfo.kmalloc-rcl-192.active_slabs
    420.00 ± 30%     +30.0%     546.00 ±  9%     +37.5%     577.50 ± 10%  slabinfo.kmalloc-rcl-192.num_objs
     10.00 ± 30%     +30.0%      13.00 ±  9%     +37.5%      13.75 ± 10%  slabinfo.kmalloc-rcl-192.num_slabs
      2358 ±  7%      +1.2%       2386 ±  3%      -3.0%       2287 ±  7%  slabinfo.kmalloc-rcl-512.active_objs
     36.50 ±  8%      +0.7%      36.75 ±  2%      -4.1%      35.00 ±  7%  slabinfo.kmalloc-rcl-512.active_slabs
      2373 ±  8%      +1.2%       2402 ±  2%      -3.6%       2287 ±  7%  slabinfo.kmalloc-rcl-512.num_objs
     36.50 ±  8%      +0.7%      36.75 ±  2%      -4.1%      35.00 ±  7%  slabinfo.kmalloc-rcl-512.num_slabs
      5189 ±  4%      +5.4%       5468            +4.0%       5395 ±  4%  slabinfo.kmalloc-rcl-64.active_objs
     80.50 ±  5%      +5.9%      85.25            +4.0%      83.75 ±  4%  slabinfo.kmalloc-rcl-64.active_slabs
      5189 ±  4%      +6.1%       5506            +4.0%       5395 ±  4%  slabinfo.kmalloc-rcl-64.num_objs
     80.50 ±  5%      +5.9%      85.25            +4.0%      83.75 ±  4%  slabinfo.kmalloc-rcl-64.num_slabs
      1960 ± 12%      +7.7%       2110 ±  2%      +4.4%       2047 ±  6%  slabinfo.kmalloc-rcl-96.active_objs
     46.50 ± 12%      +8.1%      50.25 ±  2%      +4.8%      48.75 ±  6%  slabinfo.kmalloc-rcl-96.active_slabs
      1960 ± 12%      +7.7%       2110 ±  2%      +4.4%       2047 ±  6%  slabinfo.kmalloc-rcl-96.num_objs
     46.50 ± 12%      +8.1%      50.25 ±  2%      +4.8%      48.75 ±  6%  slabinfo.kmalloc-rcl-96.num_slabs
    720.00 ± 13%      +2.2%     736.00 ±  7%      -8.9%     656.00 ±  8%  slabinfo.kmem_cache.active_objs
     11.25 ± 13%      +2.2%      11.50 ±  7%      -8.9%      10.25 ±  8%  slabinfo.kmem_cache.active_slabs
    720.00 ± 13%      +2.2%     736.00 ±  7%      -8.9%     656.00 ±  8%  slabinfo.kmem_cache.num_objs
     11.25 ± 13%      +2.2%      11.50 ±  7%      -8.9%      10.25 ±  8%  slabinfo.kmem_cache.num_slabs
    872.00 ± 11%      +2.1%     890.00 ±  6%      -7.6%     806.00 ±  6%  slabinfo.kmem_cache_node.active_objs
     14.25 ± 10%      +1.8%      14.50 ±  5%      -7.0%      13.25 ±  6%  slabinfo.kmem_cache_node.active_slabs
    912.00 ± 10%      +1.8%     928.00 ±  5%      -7.0%     848.00 ±  6%  slabinfo.kmem_cache_node.num_objs
     14.25 ± 10%      +1.8%      14.50 ±  5%      -7.0%      13.25 ±  6%  slabinfo.kmem_cache_node.num_slabs
     11726 ±  5%      -3.0%      11379 ±  2%      -1.6%      11537        slabinfo.lsm_file_cache.active_objs
     68.25 ±  5%      -2.9%      66.25 ±  2%      -1.8%      67.00        slabinfo.lsm_file_cache.active_slabs
     11726 ±  5%      -3.0%      11379 ±  2%      -1.6%      11537        slabinfo.lsm_file_cache.num_objs
     68.25 ±  5%      -2.9%      66.25 ±  2%      -1.8%      67.00        slabinfo.lsm_file_cache.num_slabs
      1544            -1.0%       1530            +1.0%       1559        slabinfo.mm_struct.active_objs
     51.25            -0.5%      51.00            +1.0%      51.75        slabinfo.mm_struct.active_slabs
      1544            -1.0%       1530            +1.0%       1559        slabinfo.mm_struct.num_objs
     51.25            -0.5%      51.00            +1.0%      51.75        slabinfo.mm_struct.num_slabs
    764.50 ±  6%      +9.9%     840.50 ±  3%      -3.3%     739.00 ±  7%  slabinfo.mnt_cache.active_objs
     14.50 ±  7%      +6.9%      15.50 ±  3%      -3.4%      14.00 ±  5%  slabinfo.mnt_cache.active_slabs
    764.50 ±  6%      +9.9%     840.50 ±  3%      -3.3%     739.00 ±  7%  slabinfo.mnt_cache.num_objs
     14.50 ±  7%      +6.9%      15.50 ±  3%      -3.4%      14.00 ±  5%  slabinfo.mnt_cache.num_slabs
     34.00            +0.0%      34.00            +0.0%      34.00        slabinfo.mqueue_inode_cache.active_objs
      1.00            +0.0%       1.00            +0.0%       1.00        slabinfo.mqueue_inode_cache.active_slabs
     34.00            +0.0%      34.00            +0.0%      34.00        slabinfo.mqueue_inode_cache.num_objs
      1.00            +0.0%       1.00            +0.0%       1.00        slabinfo.mqueue_inode_cache.num_slabs
    386.00            -0.5%     384.00            -0.5%     384.00        slabinfo.names_cache.active_objs
     48.25            -0.5%      48.00            -0.5%      48.00        slabinfo.names_cache.active_slabs
    386.00            -0.5%     384.00            -0.5%     384.00        slabinfo.names_cache.num_objs
     48.25            -0.5%      48.00            -0.5%      48.00        slabinfo.names_cache.num_slabs
     36.00            +0.0%      36.00            +0.0%      36.00        slabinfo.nfs_read_data.active_objs
      1.00            +0.0%       1.00            +0.0%       1.00        slabinfo.nfs_read_data.active_slabs
     36.00            +0.0%      36.00            +0.0%      36.00        slabinfo.nfs_read_data.num_objs
      1.00            +0.0%       1.00            +0.0%       1.00        slabinfo.nfs_read_data.num_slabs
    248.00            +6.2%     263.50 ± 10%      +0.0%     248.00        slabinfo.numa_policy.active_objs
      4.00            +6.2%       4.25 ± 10%      +0.0%       4.00        slabinfo.numa_policy.active_slabs
    248.00            +6.2%     263.50 ± 10%      +0.0%     248.00        slabinfo.numa_policy.num_objs
      4.00            +6.2%       4.25 ± 10%      +0.0%       4.00        slabinfo.numa_policy.num_slabs
      4816            -1.7%       4733            -1.1%       4762        slabinfo.pde_opener.active_objs
     46.50            -1.6%      45.75 ±  2%      -1.1%      46.00 ±  2%  slabinfo.pde_opener.active_slabs
      4816            -1.7%       4733            -1.1%       4762        slabinfo.pde_opener.num_objs
     46.50            -1.6%      45.75 ±  2%      -1.1%      46.00 ±  2%  slabinfo.pde_opener.num_slabs
      3552            +0.0%       3552 ±  2%      -0.1%       3549        slabinfo.pid.active_objs
     55.50            +0.0%      55.50 ±  2%      -0.9%      55.00 ±  2%  slabinfo.pid.active_slabs
      3552            +0.0%       3552 ±  2%      -0.1%       3549        slabinfo.pid.num_objs
     55.50            +0.0%      55.50 ±  2%      -0.9%      55.00 ±  2%  slabinfo.pid.num_slabs
      2254 ±  4%      -2.4%       2200 ±  4%      +4.4%       2352 ±  7%  slabinfo.pool_workqueue.active_objs
     36.00 ±  3%      -4.2%      34.50 ±  4%      +0.7%      36.25 ±  7%  slabinfo.pool_workqueue.active_slabs
      2315 ±  4%      -4.0%       2222 ±  5%      +1.8%       2356 ±  7%  slabinfo.pool_workqueue.num_objs
     36.00 ±  3%      -4.2%      34.50 ±  4%      +0.7%      36.25 ±  7%  slabinfo.pool_workqueue.num_slabs
      1249            -1.7%       1228            -1.7%       1228        slabinfo.proc_dir_entry.active_objs
     29.75            -1.7%      29.25            -1.7%      29.25        slabinfo.proc_dir_entry.active_slabs
      1249            -1.7%       1228            -1.7%       1228        slabinfo.proc_dir_entry.num_objs
     29.75            -1.7%      29.25            -1.7%      29.25        slabinfo.proc_dir_entry.num_slabs
      8844 ±  2%      -2.4%       8631            -1.1%       8750 ±  2%  slabinfo.proc_inode_cache.active_objs
    185.50 ±  2%      -2.4%     181.00            -1.3%     183.00 ±  2%  slabinfo.proc_inode_cache.active_slabs
      8929 ±  2%      -2.3%       8724            -1.5%       8795 ±  2%  slabinfo.proc_inode_cache.num_objs
    185.50 ±  2%      -2.4%     181.00            -1.3%     183.00 ±  2%  slabinfo.proc_inode_cache.num_slabs
     18665            -0.3%      18600            -0.5%      18576        slabinfo.radix_tree_node.active_objs
    332.75            -0.4%     331.50            -0.5%     331.25        slabinfo.radix_tree_node.active_slabs
     18665            -0.3%      18600            -0.5%      18576        slabinfo.radix_tree_node.num_objs
    332.75            -0.4%     331.50            -0.5%     331.25        slabinfo.radix_tree_node.num_slabs
     33.75 ± 19%     +22.2%      41.25 ± 30%      +0.0%      33.75 ± 19%  slabinfo.request_queue.active_objs
      2.25 ± 19%     +22.2%       2.75 ± 30%      +0.0%       2.25 ± 19%  slabinfo.request_queue.active_slabs
     33.75 ± 19%     +22.2%      41.25 ± 30%      +0.0%      33.75 ± 19%  slabinfo.request_queue.num_objs
      2.25 ± 19%     +22.2%       2.75 ± 30%      +0.0%       2.25 ± 19%  slabinfo.request_queue.num_slabs
     51.00            +0.0%      51.00            +0.0%      51.00        slabinfo.rpc_inode_cache.active_objs
      1.00            +0.0%       1.00            +0.0%       1.00        slabinfo.rpc_inode_cache.active_slabs
     51.00            +0.0%      51.00            +0.0%      51.00        slabinfo.rpc_inode_cache.num_objs
      1.00            +0.0%       1.00            +0.0%       1.00        slabinfo.rpc_inode_cache.num_slabs
      1296 ±  2%      +1.2%       1312 ±  2%      +0.0%       1296 ±  2%  slabinfo.scsi_sense_cache.active_objs
     20.25 ±  2%      +1.2%      20.50 ±  2%      +0.0%      20.25 ±  2%  slabinfo.scsi_sense_cache.active_slabs
      1296 ±  2%      +1.2%       1312 ±  2%      +0.0%       1296 ±  2%  slabinfo.scsi_sense_cache.num_objs
     20.25 ±  2%      +1.2%      20.50 ±  2%      +0.0%      20.25 ±  2%  slabinfo.scsi_sense_cache.num_slabs
      3264            +0.0%       3264            +0.0%       3264        slabinfo.seq_file.active_objs
     48.00            +0.0%      48.00            +0.0%      48.00        slabinfo.seq_file.active_slabs
      3264            +0.0%       3264            +0.0%       3264        slabinfo.seq_file.num_objs
     48.00            +0.0%      48.00            +0.0%      48.00        slabinfo.seq_file.num_slabs
      5967            -0.1%       5958            -1.7%       5868        slabinfo.shmem_inode_cache.active_objs
    129.25 ±  2%      -0.2%     129.00            -1.7%     127.00        slabinfo.shmem_inode_cache.active_slabs
      5967            -0.1%       5959            -1.7%       5868        slabinfo.shmem_inode_cache.num_objs
    129.25 ±  2%      -0.2%     129.00            -1.7%     127.00        slabinfo.shmem_inode_cache.num_slabs
      1335 ±  3%      +1.1%       1349 ±  5%      -1.1%       1320        slabinfo.sighand_cache.active_objs
     91.50            +2.2%      93.50 ±  2%      +1.4%      92.75        slabinfo.sighand_cache.active_slabs
      1372            +2.4%       1406 ±  3%      +1.9%       1398        slabinfo.sighand_cache.num_objs
     91.50            +2.2%      93.50 ±  2%      +1.4%      92.75        slabinfo.sighand_cache.num_slabs
      2064 ±  2%      +0.7%       2078            +0.6%       2077 ±  2%  slabinfo.signal_cache.active_objs
     73.25 ±  2%      +0.7%      73.75 ±  2%      +0.3%      73.50 ±  2%  slabinfo.signal_cache.active_slabs
      2064 ±  2%      +0.7%       2078            +0.6%       2077 ±  2%  slabinfo.signal_cache.num_objs
     73.25 ±  2%      +0.7%      73.75 ±  2%      +0.3%      73.50 ±  2%  slabinfo.signal_cache.num_slabs
    624.00 ±  4%      -7.7%     576.00            -2.6%     608.00 ± 11%  slabinfo.skbuff_fclone_cache.active_objs
      9.75 ±  4%      -7.7%       9.00            -2.6%       9.50 ± 11%  slabinfo.skbuff_fclone_cache.active_slabs
    624.00 ±  4%      -7.7%     576.00            -2.6%     608.00 ± 11%  slabinfo.skbuff_fclone_cache.num_objs
      9.75 ±  4%      -7.7%       9.00            -2.6%       9.50 ± 11%  slabinfo.skbuff_fclone_cache.num_slabs
      4080 ± 11%      -5.1%       3872 ± 10%      -5.9%       3840 ±  9%  slabinfo.skbuff_head_cache.active_objs
     65.75 ±  8%      -6.1%      61.75 ±  8%      -6.5%      61.50 ±  8%  slabinfo.skbuff_head_cache.active_slabs
      4208 ±  8%      -6.1%       3952 ±  8%      -6.5%       3936 ±  8%  slabinfo.skbuff_head_cache.num_objs
     65.75 ±  8%      -6.1%      61.75 ±  8%      -6.5%      61.50 ±  8%  slabinfo.skbuff_head_cache.num_slabs
      2210 ±  3%      +0.4%       2219 ±  5%      +2.1%       2257 ±  3%  slabinfo.sock_inode_cache.active_objs
     56.50 ±  3%      +0.4%      56.75 ±  5%      +1.3%      57.25 ±  3%  slabinfo.sock_inode_cache.active_slabs
      2210 ±  3%      +0.4%       2219 ±  5%      +2.1%       2257 ±  3%  slabinfo.sock_inode_cache.num_objs
     56.50 ±  3%      +0.4%      56.75 ±  5%      +1.3%      57.25 ±  3%  slabinfo.sock_inode_cache.num_slabs
      3186            +0.0%       3187 ±  2%      +2.3%       3261        slabinfo.task_delay_info.active_objs
     62.00            +0.4%      62.25 ±  2%      +2.0%      63.25        slabinfo.task_delay_info.active_slabs
      3186            +0.0%       3187 ±  2%      +2.3%       3261        slabinfo.task_delay_info.num_objs
     62.00            +0.4%      62.25 ±  2%      +2.0%      63.25        slabinfo.task_delay_info.num_slabs
    880.50 ±  5%      -4.9%     837.50 ±  9%     +10.2%     970.25 ±  5%  slabinfo.task_group.active_objs
     20.50 ±  5%      -6.1%      19.25 ±  9%     +11.0%      22.75 ±  4%  slabinfo.task_group.active_slabs
    880.50 ±  5%      -4.9%     837.50 ±  9%     +10.2%     970.25 ±  5%  slabinfo.task_group.num_objs
     20.50 ±  5%      -6.1%      19.25 ±  9%     +11.0%      22.75 ±  4%  slabinfo.task_group.num_slabs
    990.25            +2.3%       1013            +0.1%     991.50        slabinfo.task_struct.active_objs
    335.00            +2.2%     342.25            -0.1%     334.75        slabinfo.task_struct.active_slabs
      1006            +2.2%       1028            -0.1%       1004        slabinfo.task_struct.num_objs
    335.00            +2.2%     342.25            -0.1%     334.75        slabinfo.task_struct.num_slabs
     95.75 ± 13%      +0.3%      96.00 ± 13%      +7.6%     103.00        slabinfo.taskstats.active_objs
      1.75 ± 24%      +0.0%       1.75 ± 24%     +14.3%       2.00        slabinfo.taskstats.active_slabs
     95.75 ± 13%      +0.3%      96.00 ± 13%      +7.6%     103.00        slabinfo.taskstats.num_objs
      1.75 ± 24%      +0.0%       1.75 ± 24%     +14.3%       2.00        slabinfo.taskstats.num_slabs
      2917            +2.5%       2990 ±  2%      -1.1%       2886        slabinfo.trace_event_file.active_objs
     63.25            +2.8%      65.00 ±  2%      -0.8%      62.75        slabinfo.trace_event_file.active_slabs
      2917            +2.5%       2990 ±  2%      -1.1%       2886        slabinfo.trace_event_file.num_objs
     63.25            +2.8%      65.00 ±  2%      -0.8%      62.75        slabinfo.trace_event_file.num_slabs
     66.00            +0.0%      66.00            +0.0%      66.00        slabinfo.tw_sock_TCP.active_objs
      1.00            +0.0%       1.00            +0.0%       1.00        slabinfo.tw_sock_TCP.active_slabs
     66.00            +0.0%      66.00            +0.0%      66.00        slabinfo.tw_sock_TCP.num_objs
      1.00            +0.0%       1.00            +0.0%       1.00        slabinfo.tw_sock_TCP.num_slabs
     29767 ±  6%      -2.5%      29025 ±  7%      +7.4%      31961 ±  5%  slabinfo.vm_area_struct.active_objs
    754.25 ±  6%      -2.6%     734.75 ±  7%      +7.3%     809.25 ±  5%  slabinfo.vm_area_struct.active_slabs
     30191 ±  6%      -2.6%      29416 ±  7%      +7.3%      32384 ±  5%  slabinfo.vm_area_struct.num_objs
    754.25 ±  6%      -2.6%     734.75 ±  7%      +7.3%     809.25 ±  5%  slabinfo.vm_area_struct.num_slabs
      6253 ±  2%      +7.7%       6733            +1.2%       6330 ±  3%  slabinfo.vmap_area.active_objs
    101.25 ±  2%      +7.2%     108.50            +1.2%     102.50 ±  3%  slabinfo.vmap_area.active_slabs
      6509 ±  2%      +6.9%       6961            +1.3%       6596 ±  3%  slabinfo.vmap_area.num_objs
    101.25 ±  2%      +7.2%     108.50            +1.2%     102.50 ±  3%  slabinfo.vmap_area.num_slabs
     45.00 ± 34%     -20.0%      36.00            +0.0%      45.00 ± 34%  slabinfo.xfs_btree_cur.active_objs
      1.25 ± 34%     -20.0%       1.00            +0.0%       1.25 ± 34%  slabinfo.xfs_btree_cur.active_slabs
     45.00 ± 34%     -20.0%      36.00            +0.0%      45.00 ± 34%  slabinfo.xfs_btree_cur.num_objs
      1.25 ± 34%     -20.0%       1.00            +0.0%       1.25 ± 34%  slabinfo.xfs_btree_cur.num_slabs
    147.00 ± 24%      +0.0%     147.00 ± 14%     +14.3%     168.00 ± 30%  slabinfo.xfs_buf.active_objs
      3.50 ± 24%      +0.0%       3.50 ± 14%     +14.3%       4.00 ± 30%  slabinfo.xfs_buf.active_slabs
    147.00 ± 24%      +0.0%     147.00 ± 14%     +14.3%     168.00 ± 30%  slabinfo.xfs_buf.num_objs
      3.50 ± 24%      +0.0%       3.50 ± 14%     +14.3%       4.00 ± 30%  slabinfo.xfs_buf.num_slabs
     38.00            +0.0%      38.00            +0.0%      38.00        slabinfo.xfs_efi_item.active_objs
      1.00            +0.0%       1.00            +0.0%       1.00        slabinfo.xfs_efi_item.active_slabs
     38.00            +0.0%      38.00            +0.0%      38.00        slabinfo.xfs_efi_item.num_objs
      1.00            +0.0%       1.00            +0.0%       1.00        slabinfo.xfs_efi_item.num_slabs
     96.00            +0.0%      96.00            +0.0%      96.00        slabinfo.xfs_inode.active_objs
      3.00            +0.0%       3.00            +0.0%       3.00        slabinfo.xfs_inode.active_slabs
     96.00            +0.0%      96.00            +0.0%      96.00        slabinfo.xfs_inode.num_objs
      3.00            +0.0%       3.00            +0.0%       3.00        slabinfo.xfs_inode.num_slabs
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.0:IO-APIC.2-edge.timer
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.20:IO-APIC.20-fasteoi.ehci_hcd:usb2
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.22:IO-APIC.22-fasteoi.ehci_hcd:usb1
      1776 ± 99%    +552.0%      11581 ±139%     -38.6%       1090 ±112%  interrupts.35:PCI-MSI.2621441-edge.eth0-TxRx-0
      2443 ± 67%     -59.8%     983.00 ± 92%     -91.7%     202.25 ± 22%  interrupts.36:PCI-MSI.2621442-edge.eth0-TxRx-1
      2792 ±159%     +64.4%       4590 ±139%     -93.7%     175.00 ±  5%  interrupts.37:PCI-MSI.2621443-edge.eth0-TxRx-2
      5994 ± 97%     +47.3%       8829 ±100%     -54.7%       2715 ± 94%  interrupts.38:PCI-MSI.2621444-edge.eth0-TxRx-3
      2001 ± 95%    +164.9%       5299 ±156%    +361.5%       9234 ±169%  interrupts.39:PCI-MSI.2621445-edge.eth0-TxRx-4
    179.25 ±  5%   +1577.8%       3007 ±162%    +404.3%     904.00 ± 84%  interrupts.40:PCI-MSI.2621446-edge.eth0-TxRx-5
     18460 ±136%     -91.0%       1655 ±153%     -96.4%     666.75 ± 82%  interrupts.41:PCI-MSI.2621447-edge.eth0-TxRx-6
    304.75 ± 56%    +447.1%       1667 ±133%     +61.5%     492.25 ±101%  interrupts.42:PCI-MSI.2621448-edge.eth0-TxRx-7
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.44:PCI-MSI.2623489-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.45:PCI-MSI.2623490-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.46:PCI-MSI.2623491-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.47:PCI-MSI.2623492-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.48:PCI-MSI.2623493-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.49:PCI-MSI.2623494-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.4:IO-APIC.4-edge.ttyS0
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.50:PCI-MSI.2623495-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.51:PCI-MSI.2623496-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.53:PCI-MSI.65536-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.55:PCI-MSI.67584-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.56:PCI-MSI.67584-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.56:PCI-MSI.69632-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.57:PCI-MSI.69632-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.57:PCI-MSI.71680-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.58:PCI-MSI.71680-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.58:PCI-MSI.73728-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.59:PCI-MSI.73728-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.59:PCI-MSI.75776-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.60:PCI-MSI.75776-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.60:PCI-MSI.77824-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.61:PCI-MSI.77824-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.61:PCI-MSI.79872-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.62:PCI-MSI.2097152-edge.isci-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.62:PCI-MSI.79872-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.63:PCI-MSI.2097152-edge.isci-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.63:PCI-MSI.67174400-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.64:PCI-MSI.2097152-edge.isci-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.64:PCI-MSI.67174400-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.64:PCI-MSI.79872-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.65:PCI-MSI.67174400-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.65:PCI-MSI.67176448-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.66:PCI-MSI.67174400-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.66:PCI-MSI.67176448-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.66:PCI-MSI.67178496-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.67:PCI-MSI.2097152-edge.isci-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.67:PCI-MSI.67176448-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.67:PCI-MSI.67178496-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.68:PCI-MSI.67176448-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.68:PCI-MSI.67178496-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.68:PCI-MSI.67180544-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.69:PCI-MSI.67178496-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.69:PCI-MSI.67180544-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.69:PCI-MSI.67182592-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.70:PCI-MSI.67180544-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.70:PCI-MSI.67182592-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.70:PCI-MSI.67184640-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.71:PCI-MSI.67182592-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.71:PCI-MSI.67184640-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.71:PCI-MSI.67186688-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.72:PCI-MSI.67184640-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.72:PCI-MSI.67188736-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.73:PCI-MSI.2097152-edge.isci-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.73:PCI-MSI.67186688-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.74:PCI-MSI.67188736-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.8:IO-APIC.8-edge.rtc0
     74767 ±  2%      +3.9%      77712 ±  4%      -5.3%      70821 ±  2%  interrupts.CAL:Function_call_interrupts
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU0.0:IO-APIC.2-edge.timer
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU0.45:PCI-MSI.2623490-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU0.55:PCI-MSI.67584-edge.ioat-msix
      1830 ± 19%     -36.4%       1163 ± 35%     -12.7%       1596 ± 33%  interrupts.CPU0.CAL:Function_call_interrupts
      0.75 ± 57%    +133.3%       1.75 ±116%     +66.7%       1.25 ± 66%  interrupts.CPU0.IWI:IRQ_work_interrupts
    605311            +0.0%     605481            -0.0%     605082        interrupts.CPU0.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU0.MCP:Machine_check_polls
      3493 ± 33%     +10.9%       3873 ± 60%     +70.4%       5952 ± 41%  interrupts.CPU0.NMI:Non-maskable_interrupts
      3493 ± 33%     +10.9%       3873 ± 60%     +70.4%       5952 ± 41%  interrupts.CPU0.PMI:Performance_monitoring_interrupts
    174.50 ± 72%     -33.7%     115.75 ± 50%     +12.2%     195.75 ± 45%  interrupts.CPU0.RES:Rescheduling_interrupts
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU0.RTR:APIC_ICR_read_retries
    650.75 ± 20%     -32.7%     438.25 ± 24%     -26.5%     478.00 ± 36%  interrupts.CPU0.TLB:TLB_shootdowns
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU1.46:PCI-MSI.2623491-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU1.56:PCI-MSI.67584-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU1.56:PCI-MSI.69632-edge.ioat-msix
      2064 ± 40%     -16.4%       1725 ± 30%     -21.2%       1626 ± 40%  interrupts.CPU1.CAL:Function_call_interrupts
      0.25 ±173%    +400.0%       1.25 ± 66%    +600.0%       1.75 ±116%  interrupts.CPU1.IWI:IRQ_work_interrupts
    605675            -0.0%     605668            -0.2%     604496        interrupts.CPU1.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU1.MCP:Machine_check_polls
      2892 ± 33%     +90.0%       5495 ± 51%      +3.3%       2987 ± 36%  interrupts.CPU1.NMI:Non-maskable_interrupts
      2892 ± 33%     +90.0%       5495 ± 51%      +3.3%       2987 ± 36%  interrupts.CPU1.PMI:Performance_monitoring_interrupts
     62.50 ± 71%    +160.0%     162.50 ± 59%     +57.6%      98.50 ± 35%  interrupts.CPU1.RES:Rescheduling_interrupts
    131.00 ±172%    +331.9%     565.75 ± 57%     +73.7%     227.50 ± 68%  interrupts.CPU1.TLB:TLB_shootdowns
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU10.8:IO-APIC.8-edge.rtc0
      1028 ± 26%     +22.1%       1256 ± 19%     +13.4%       1166 ± 17%  interrupts.CPU10.CAL:Function_call_interrupts
      0.50 ±173%    +150.0%       1.25 ± 66%    +100.0%       1.00 ± 70%  interrupts.CPU10.IWI:IRQ_work_interrupts
    605197            +0.1%     605510            -0.0%     604935        interrupts.CPU10.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU10.MCP:Machine_check_polls
      3444 ± 82%     +72.3%       5935 ± 41%     +41.8%       4882 ± 41%  interrupts.CPU10.NMI:Non-maskable_interrupts
      3444 ± 82%     +72.3%       5935 ± 41%     +41.8%       4882 ± 41%  interrupts.CPU10.PMI:Performance_monitoring_interrupts
     98.25 ±124%     +61.8%     159.00 ± 65%     +75.8%     172.75 ± 52%  interrupts.CPU10.RES:Rescheduling_interrupts
    184.75 ±172%    +201.8%     557.50 ± 58%     +75.8%     324.75 ± 71%  interrupts.CPU10.TLB:TLB_shootdowns
      1231 ± 25%      -7.5%       1139 ± 23%     -25.9%     913.25 ± 32%  interrupts.CPU11.CAL:Function_call_interrupts
      1.00 ± 70%     -50.0%       0.50 ±173%     -50.0%       0.50 ±100%  interrupts.CPU11.IWI:IRQ_work_interrupts
    605410            -0.0%     605162            -0.1%     604665        interrupts.CPU11.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU11.MCP:Machine_check_polls
      4535 ± 54%     -13.0%       3946 ± 64%     -21.8%       3547 ± 44%  interrupts.CPU11.NMI:Non-maskable_interrupts
      4535 ± 54%     -13.0%       3946 ± 64%     -21.8%       3547 ± 44%  interrupts.CPU11.PMI:Performance_monitoring_interrupts
    151.00 ± 71%     -43.9%      84.75 ± 80%     -79.0%      31.75 ± 60%  interrupts.CPU11.RES:Rescheduling_interrupts
    419.50 ± 79%     -42.9%     239.50 ±126%     -68.6%     131.75 ±173%  interrupts.CPU11.TLB:TLB_shootdowns
      1257 ± 20%      -6.0%       1181 ± 28%      +3.1%       1297 ± 20%  interrupts.CPU12.CAL:Function_call_interrupts
      1.75 ±116%     -71.4%       0.50 ±100%     -28.6%       1.25 ± 66%  interrupts.CPU12.IWI:IRQ_work_interrupts
    605545            +0.0%     605582            -0.1%     605127        interrupts.CPU12.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU12.MCP:Machine_check_polls
      4291 ± 54%     -33.6%       2847 ± 46%     +34.5%       5770 ± 46%  interrupts.CPU12.NMI:Non-maskable_interrupts
      4291 ± 54%     -33.6%       2847 ± 46%     +34.5%       5770 ± 46%  interrupts.CPU12.PMI:Performance_monitoring_interrupts
    106.00 ±103%     +28.3%     136.00 ± 84%     +79.5%     190.25 ± 60%  interrupts.CPU12.RES:Rescheduling_interrupts
    394.50 ± 73%     -12.0%     347.25 ±100%     +14.2%     450.50 ± 60%  interrupts.CPU12.TLB:TLB_shootdowns
      1656 ± 33%     +58.9%       2632 ± 84%     -28.0%       1192 ± 12%  interrupts.CPU13.CAL:Function_call_interrupts
      1.75 ±109%     -42.9%       1.00 ±100%     -57.1%       0.75 ±110%  interrupts.CPU13.IWI:IRQ_work_interrupts
    605309            +0.1%     605621            -0.0%     605223        interrupts.CPU13.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU13.MCP:Machine_check_polls
      3998 ± 27%     +16.3%       4650 ± 67%      +4.8%       4190 ± 61%  interrupts.CPU13.NMI:Non-maskable_interrupts
      3998 ± 27%     +16.3%       4650 ± 67%      +4.8%       4190 ± 61%  interrupts.CPU13.PMI:Performance_monitoring_interrupts
    111.50 ± 48%     +27.8%     142.50 ± 83%     +26.9%     141.50 ± 60%  interrupts.CPU13.RES:Rescheduling_interrupts
    314.75 ±101%     +30.7%     411.50 ± 81%     -16.8%     261.75 ± 97%  interrupts.CPU13.TLB:TLB_shootdowns
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU14.63:PCI-MSI.67174400-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU14.64:PCI-MSI.67174400-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU14.65:PCI-MSI.67174400-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU14.66:PCI-MSI.67174400-edge.ioat-msix
    899.00 ± 25%     +51.4%       1361 ± 20%     +36.2%       1224 ± 17%  interrupts.CPU14.CAL:Function_call_interrupts
      0.50 ±173%     +50.0%       0.75 ±110%    +250.0%       1.75 ± 24%  interrupts.CPU14.IWI:IRQ_work_interrupts
    604935            +0.1%     605707            +0.0%     605020        interrupts.CPU14.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU14.MCP:Machine_check_polls
      3066 ± 40%     +45.3%       4455 ± 52%    +102.7%       6215 ± 29%  interrupts.CPU14.NMI:Non-maskable_interrupts
      3066 ± 40%     +45.3%       4455 ± 52%    +102.7%       6215 ± 29%  interrupts.CPU14.PMI:Performance_monitoring_interrupts
     28.25 ± 24%    +248.7%      98.50 ± 60%    +550.4%     183.75 ± 62%  interrupts.CPU14.RES:Rescheduling_interrupts
    431.25 ±156%      +3.8%     447.75 ± 65%     +13.3%     488.75 ± 41%  interrupts.CPU14.TLB:TLB_shootdowns
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU15.65:PCI-MSI.67176448-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU15.66:PCI-MSI.67176448-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU15.67:PCI-MSI.67176448-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU15.68:PCI-MSI.67176448-edge.ioat-msix
      1443 ±  8%     -19.3%       1164 ± 22%     -31.5%     988.75 ±  9%  interrupts.CPU15.CAL:Function_call_interrupts
      1.25 ± 34%     -40.0%       0.75 ±110%     -40.0%       0.75 ±110%  interrupts.CPU15.IWI:IRQ_work_interrupts
    605278            -0.1%     604866            -0.0%     605052        interrupts.CPU15.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU15.MCP:Machine_check_polls
      5222 ± 34%     -14.7%       4452 ± 52%      -6.4%       4887 ± 47%  interrupts.CPU15.NMI:Non-maskable_interrupts
      5222 ± 34%     -14.7%       4452 ± 52%      -6.4%       4887 ± 47%  interrupts.CPU15.PMI:Performance_monitoring_interrupts
    182.50 ± 64%     -20.8%     144.50 ± 78%     -72.7%      49.75 ± 53%  interrupts.CPU15.RES:Rescheduling_interrupts
    722.25 ±  6%     -48.3%     373.75 ± 99%     -81.6%     132.75 ±171%  interrupts.CPU15.TLB:TLB_shootdowns
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU16.66:PCI-MSI.67178496-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU16.67:PCI-MSI.67178496-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU16.68:PCI-MSI.67178496-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU16.69:PCI-MSI.67178496-edge.ioat-msix
      2621 ±114%     -54.4%       1196 ± 25%     -46.9%       1392 ± 17%  interrupts.CPU16.CAL:Function_call_interrupts
      0.25 ±173%    +200.0%       0.75 ±110%    +100.0%       0.50 ±100%  interrupts.CPU16.IWI:IRQ_work_interrupts
    604784            +0.2%     605730            +0.0%     605010        interrupts.CPU16.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU16.MCP:Machine_check_polls
      2867 ± 60%     +47.8%       4237 ± 60%     +22.1%       3502 ± 21%  interrupts.CPU16.NMI:Non-maskable_interrupts
      2867 ± 60%     +47.8%       4237 ± 60%     +22.1%       3502 ± 21%  interrupts.CPU16.PMI:Performance_monitoring_interrupts
     68.25 ± 72%     +46.2%      99.75 ± 82%    +174.7%     187.50 ± 58%  interrupts.CPU16.RES:Rescheduling_interrupts
      0.75 ± 57%  +46933.3%     352.75 ±100%  +42200.0%     317.25 ±102%  interrupts.CPU16.TLB:TLB_shootdowns
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU17.68:PCI-MSI.67180544-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU17.69:PCI-MSI.67180544-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU17.70:PCI-MSI.67180544-edge.ioat-msix
      1480 ±  6%    +139.1%       3538 ±101%     -23.3%       1134 ± 11%  interrupts.CPU17.CAL:Function_call_interrupts
      1.75 ± 24%     -57.1%       0.75 ± 57%     -71.4%       0.50 ±100%  interrupts.CPU17.IWI:IRQ_work_interrupts
    605237            +0.1%     605554            -0.0%     605052        interrupts.CPU17.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU17.MCP:Machine_check_polls
      6463 ± 29%     -40.4%       3850 ± 14%     -45.1%       3547 ± 39%  interrupts.CPU17.NMI:Non-maskable_interrupts
      6463 ± 29%     -40.4%       3850 ± 14%     -45.1%       3547 ± 39%  interrupts.CPU17.PMI:Performance_monitoring_interrupts
    195.50 ± 53%     +22.6%     239.75 ± 38%     -81.5%      36.25 ± 56%  interrupts.CPU17.RES:Rescheduling_interrupts
    730.75 ±  3%     -22.5%     566.00 ± 57%     -80.4%     143.50 ±144%  interrupts.CPU17.TLB:TLB_shootdowns
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU18.69:PCI-MSI.67182592-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU18.70:PCI-MSI.67182592-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU18.71:PCI-MSI.67182592-edge.ioat-msix
      1128 ± 17%     +85.9%       2098 ± 62%     +14.8%       1295 ±  5%  interrupts.CPU18.CAL:Function_call_interrupts
      0.50 ±100%     -50.0%       0.25 ±173%    +150.0%       1.25 ± 66%  interrupts.CPU18.IWI:IRQ_work_interrupts
    604860            +0.1%     605593            +0.0%     604861        interrupts.CPU18.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU18.MCP:Machine_check_polls
      3552 ± 44%     -20.0%       2840 ± 33%     +55.1%       5509 ± 52%  interrupts.CPU18.NMI:Non-maskable_interrupts
      3552 ± 44%     -20.0%       2840 ± 33%     +55.1%       5509 ± 52%  interrupts.CPU18.PMI:Performance_monitoring_interrupts
    104.25 ±105%     -25.9%      77.25 ± 81%     +12.0%     116.75 ± 87%  interrupts.CPU18.RES:Rescheduling_interrupts
    170.25 ±168%      +1.8%     173.25 ±173%    +124.5%     382.25 ± 57%  interrupts.CPU18.TLB:TLB_shootdowns
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU19.70:PCI-MSI.67184640-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU19.71:PCI-MSI.67184640-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU19.72:PCI-MSI.67184640-edge.ioat-msix
      1573 ±  2%     -10.5%       1408 ± 21%     +10.4%       1736 ± 21%  interrupts.CPU19.CAL:Function_call_interrupts
      1.25 ± 34%      +0.0%       1.25 ± 66%     -60.0%       0.50 ±173%  interrupts.CPU19.IWI:IRQ_work_interrupts
    605253            +0.1%     605634            -0.1%     604734        interrupts.CPU19.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU19.MCP:Machine_check_polls
      5223 ± 34%      +6.8%       5581 ± 52%     -26.7%       3831 ± 68%  interrupts.CPU19.NMI:Non-maskable_interrupts
      5223 ± 34%      +6.8%       5581 ± 52%     -26.7%       3831 ± 68%  interrupts.CPU19.PMI:Performance_monitoring_interrupts
    206.75 ± 45%     -24.3%     156.50 ± 63%     -65.7%      71.00 ± 60%  interrupts.CPU19.RES:Rescheduling_interrupts
    735.75 ±  2%     -22.7%     568.75 ± 57%     -82.0%     132.75 ±170%  interrupts.CPU19.TLB:TLB_shootdowns
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU2.47:PCI-MSI.2623492-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU2.57:PCI-MSI.69632-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU2.57:PCI-MSI.71680-edge.ioat-msix
      1268 ± 20%     +53.2%       1942 ± 22%      -1.1%       1254 ± 15%  interrupts.CPU2.CAL:Function_call_interrupts
      1.50 ± 57%     +66.7%       2.50 ± 60%      +0.0%       1.50 ± 33%  interrupts.CPU2.IWI:IRQ_work_interrupts
    605262            +0.0%     605476            -0.0%     605077        interrupts.CPU2.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU2.MCP:Machine_check_polls
      6422 ± 34%      -7.1%       5967 ± 40%      -1.3%       6337 ± 25%  interrupts.CPU2.NMI:Non-maskable_interrupts
      6422 ± 34%      -7.1%       5967 ± 40%      -1.3%       6337 ± 25%  interrupts.CPU2.PMI:Performance_monitoring_interrupts
    178.50 ± 70%      +4.6%     186.75 ± 43%      -4.2%     171.00 ± 74%  interrupts.CPU2.RES:Rescheduling_interrupts
    555.00 ± 57%     +20.6%     669.50 ± 10%     -21.4%     436.50 ± 61%  interrupts.CPU2.TLB:TLB_shootdowns
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU20.71:PCI-MSI.67186688-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU20.73:PCI-MSI.67186688-edge.ioat-msix
      2498 ± 58%      -0.8%       2478 ± 78%     -51.5%       1211 ± 14%  interrupts.CPU20.CAL:Function_call_interrupts
      0.25 ±173%    +100.0%       0.50 ±173%    +400.0%       1.25 ± 66%  interrupts.CPU20.IWI:IRQ_work_interrupts
    605304            -0.0%     605245            -0.1%     604826        interrupts.CPU20.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU20.MCP:Machine_check_polls
      2755 ± 56%     +36.3%       3754 ± 72%    +108.7%       5749 ± 41%  interrupts.CPU20.NMI:Non-maskable_interrupts
      2755 ± 56%     +36.3%       3754 ± 72%    +108.7%       5749 ± 41%  interrupts.CPU20.PMI:Performance_monitoring_interrupts
     53.50 ± 63%     +71.0%      91.50 ± 69%    +183.2%     151.50 ± 68%  interrupts.CPU20.RES:Rescheduling_interrupts
     40.25 ±168%    +328.6%     172.50 ±164%    +928.6%     414.00 ± 64%  interrupts.CPU20.TLB:TLB_shootdowns
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU21.72:PCI-MSI.67188736-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU21.74:PCI-MSI.67188736-edge.ioat-msix
      1480 ± 12%      -7.1%       1374 ± 22%     -17.1%       1227 ± 20%  interrupts.CPU21.CAL:Function_call_interrupts
      1.25 ± 66%     -40.0%       0.75 ± 57%     -20.0%       1.00 ±100%  interrupts.CPU21.IWI:IRQ_work_interrupts
    605274            +0.0%     605524            -0.0%     605149        interrupts.CPU21.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU21.MCP:Machine_check_polls
      5636 ± 50%     -33.1%       3770 ± 18%      -0.6%       5602 ± 49%  interrupts.CPU21.NMI:Non-maskable_interrupts
      5636 ± 50%     -33.1%       3770 ± 18%      -0.6%       5602 ± 49%  interrupts.CPU21.PMI:Performance_monitoring_interrupts
    179.00 ± 67%     -15.1%     152.00 ± 70%      -3.6%     172.50 ± 60%  interrupts.CPU21.RES:Rescheduling_interrupts
    602.50 ± 48%      -5.1%     571.50 ± 57%     -38.5%     370.75 ± 80%  interrupts.CPU21.TLB:TLB_shootdowns
      1242 ± 51%     +90.4%       2365 ± 52%      +4.0%       1292 ± 20%  interrupts.CPU22.CAL:Function_call_interrupts
      0.25 ±173%    +100.0%       0.50 ±173%    +500.0%       1.50 ± 57%  interrupts.CPU22.IWI:IRQ_work_interrupts
    604681            +0.2%     605704            -0.0%     604546        interrupts.CPU22.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU22.MCP:Machine_check_polls
      3095 ± 51%      +2.3%       3167 ± 94%    +109.6%       6487 ± 45%  interrupts.CPU22.NMI:Non-maskable_interrupts
      3095 ± 51%      +2.3%       3167 ± 94%    +109.6%       6487 ± 45%  interrupts.CPU22.PMI:Performance_monitoring_interrupts
     27.50 ± 37%    +206.4%      84.25 ± 73%    +620.0%     198.00 ± 55%  interrupts.CPU22.RES:Rescheduling_interrupts
      1.00 ±122%  +17100.0%     172.00 ±172%  +46900.0%     470.00 ± 59%  interrupts.CPU22.TLB:TLB_shootdowns
      1438 ± 13%      -0.2%       1435 ± 17%     -17.2%       1190 ± 20%  interrupts.CPU23.CAL:Function_call_interrupts
      2.00 ± 50%      +0.0%       2.00 ± 61%     -25.0%       1.50 ± 57%  interrupts.CPU23.IWI:IRQ_work_interrupts
    605222            +0.1%     605600            -0.2%     603921        interrupts.CPU23.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU23.MCP:Machine_check_polls
      5396 ± 50%      +4.9%       5661 ± 38%     -15.4%       4564 ± 41%  interrupts.CPU23.NMI:Non-maskable_interrupts
      5396 ± 50%      +4.9%       5661 ± 38%     -15.4%       4564 ± 41%  interrupts.CPU23.PMI:Performance_monitoring_interrupts
    171.75 ± 51%      -0.6%     170.75 ± 55%     -15.4%     145.25 ± 71%  interrupts.CPU23.RES:Rescheduling_interrupts
    634.00 ± 32%      +0.0%     634.00 ± 39%     -39.8%     381.50 ± 58%  interrupts.CPU23.TLB:TLB_shootdowns
    997.25 ±  8%     +17.2%       1168 ±  9%     +23.4%       1230 ± 32%  interrupts.CPU24.CAL:Function_call_interrupts
      0.50 ±173%    +450.0%       2.75 ± 47%      +0.0%       0.50 ±173%  interrupts.CPU24.IWI:IRQ_work_interrupts
    605385            +0.0%     605410            -0.2%     604365        interrupts.CPU24.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU24.MCP:Machine_check_polls
      3880 ± 68%     +84.0%       7138 ± 28%     +10.8%       4300 ± 54%  interrupts.CPU24.NMI:Non-maskable_interrupts
      3880 ± 68%     +84.0%       7138 ± 28%     +10.8%       4300 ± 54%  interrupts.CPU24.PMI:Performance_monitoring_interrupts
     59.75 ± 59%     +76.2%     105.25 ± 11%     -21.3%      47.00 ± 39%  interrupts.CPU24.RES:Rescheduling_interrupts
    134.00 ± 99%    +134.9%     314.75 ± 40%      -8.8%     122.25 ± 64%  interrupts.CPU24.TLB:TLB_shootdowns
      1439 ± 14%     -29.1%       1019 ± 26%     +13.4%       1632 ± 41%  interrupts.CPU25.CAL:Function_call_interrupts
      1.50 ± 57%     -83.3%       0.25 ±173%     +83.3%       2.75 ± 69%  interrupts.CPU25.IWI:IRQ_work_interrupts
    605337            +0.1%     605720            -0.1%     604996        interrupts.CPU25.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU25.MCP:Machine_check_polls
      6907 ± 32%     -53.8%       3194 ± 17%      -3.5%       6665 ± 26%  interrupts.CPU25.NMI:Non-maskable_interrupts
      6907 ± 32%     -53.8%       3194 ± 17%      -3.5%       6665 ± 26%  interrupts.CPU25.PMI:Performance_monitoring_interrupts
    170.50 ± 51%     -56.7%      73.75 ± 90%      +2.3%     174.50 ± 55%  interrupts.CPU25.RES:Rescheduling_interrupts
    596.50 ± 39%     -71.8%     168.00 ±171%     -26.9%     436.25 ± 48%  interrupts.CPU25.TLB:TLB_shootdowns
      1776 ± 99%    +552.0%      11581 ±139%     -38.6%       1090 ±112%  interrupts.CPU26.35:PCI-MSI.2621441-edge.eth0-TxRx-0
      1073 ± 28%      -6.9%     999.00 ± 15%     +10.4%       1184 ± 22%  interrupts.CPU26.CAL:Function_call_interrupts
      0.25 ±173%      +0.0%       0.25 ±173%    +100.0%       0.50 ±173%  interrupts.CPU26.IWI:IRQ_work_interrupts
    605562            -0.0%     605348            -0.1%     605061        interrupts.CPU26.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU26.MCP:Machine_check_polls
      2838 ± 34%     -11.4%       2514 ± 45%     +34.2%       3808 ± 70%  interrupts.CPU26.NMI:Non-maskable_interrupts
      2838 ± 34%     -11.4%       2514 ± 45%     +34.2%       3808 ± 70%  interrupts.CPU26.PMI:Performance_monitoring_interrupts
     40.75 ± 82%     +13.5%      46.25 ± 45%     +91.4%      78.00 ± 65%  interrupts.CPU26.RES:Rescheduling_interrupts
    184.75 ±171%     -70.1%      55.25 ±172%     -24.8%     139.00 ±159%  interrupts.CPU26.TLB:TLB_shootdowns
      2443 ± 67%     -59.8%     983.00 ± 92%     -91.7%     202.25 ± 22%  interrupts.CPU27.36:PCI-MSI.2621442-edge.eth0-TxRx-1
      1414 ± 15%     +10.0%       1555 ±  3%      -6.6%       1320 ± 15%  interrupts.CPU27.CAL:Function_call_interrupts
      1.25 ± 66%     +20.0%       1.50 ± 33%     -20.0%       1.00 ± 70%  interrupts.CPU27.IWI:IRQ_work_interrupts
    605320            +0.0%     605518            -0.0%     605084        interrupts.CPU27.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU27.MCP:Machine_check_polls
      5815 ± 40%      +7.8%       6270 ± 33%     -15.0%       4943 ± 41%  interrupts.CPU27.NMI:Non-maskable_interrupts
      5815 ± 40%      +7.8%       6270 ± 33%     -15.0%       4943 ± 41%  interrupts.CPU27.PMI:Performance_monitoring_interrupts
    134.25 ± 79%     +51.2%     203.00 ± 35%      +0.0%     134.25 ± 92%  interrupts.CPU27.RES:Rescheduling_interrupts
    559.75 ± 58%     +30.7%     731.75 ±  6%     -21.2%     441.25 ± 60%  interrupts.CPU27.TLB:TLB_shootdowns
      2792 ±159%     +64.4%       4590 ±139%     -93.7%     175.00 ±  5%  interrupts.CPU28.37:PCI-MSI.2621443-edge.eth0-TxRx-2
      2926 ±102%     -56.0%       1288 ± 17%      +8.6%       3177 ± 60%  interrupts.CPU28.CAL:Function_call_interrupts
      0.00       +7.5e+101%       0.75 ±110% +2.5e+101%       0.25 ±173%  interrupts.CPU28.IWI:IRQ_work_interrupts
    605747            -0.0%     605646            -0.2%     604789        interrupts.CPU28.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU28.MCP:Machine_check_polls
      2534 ± 24%     +52.0%       3852 ± 73%     -16.3%       2121 ± 56%  interrupts.CPU28.NMI:Non-maskable_interrupts
      2534 ± 24%     +52.0%       3852 ± 73%     -16.3%       2121 ± 56%  interrupts.CPU28.PMI:Performance_monitoring_interrupts
    103.75 ± 65%      -5.3%      98.25 ± 59%      -6.5%      97.00 ± 40%  interrupts.CPU28.RES:Rescheduling_interrupts
     21.00 ±159%   +1695.2%     377.00 ± 99%    +541.7%     134.75 ±172%  interrupts.CPU28.TLB:TLB_shootdowns
      5994 ± 97%     +47.3%       8829 ±100%     -54.7%       2715 ± 94%  interrupts.CPU29.38:PCI-MSI.2621444-edge.eth0-TxRx-3
      1682 ± 17%      +5.8%       1780 ± 25%     -22.7%       1300 ± 19%  interrupts.CPU29.CAL:Function_call_interrupts
      0.75 ±110%     +66.7%       1.25 ± 66%     +33.3%       1.00 ± 70%  interrupts.CPU29.IWI:IRQ_work_interrupts
    605359            -0.1%     604771            -0.1%     604717        interrupts.CPU29.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU29.MCP:Machine_check_polls
      3022 ± 52%     +97.6%       5973 ± 40%     +63.0%       4928 ± 41%  interrupts.CPU29.NMI:Non-maskable_interrupts
      3022 ± 52%     +97.6%       5973 ± 40%     +63.0%       4928 ± 41%  interrupts.CPU29.PMI:Performance_monitoring_interrupts
    169.75 ± 60%      +1.8%     172.75 ± 53%     -16.1%     142.50 ± 74%  interrupts.CPU29.RES:Rescheduling_interrupts
    497.00 ± 62%      +8.2%     538.00 ± 57%      -9.7%     449.00 ± 61%  interrupts.CPU29.TLB:TLB_shootdowns
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU3.48:PCI-MSI.2623493-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU3.58:PCI-MSI.71680-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU3.58:PCI-MSI.73728-edge.ioat-msix
      1218 ± 42%     +28.8%       1569 ± 71%     -19.7%     978.50 ± 18%  interrupts.CPU3.CAL:Function_call_interrupts
      0.50 ±100%    -100.0%       0.00            +0.0%       0.50 ±173%  interrupts.CPU3.IWI:IRQ_work_interrupts
    605231            +0.0%     605343            -0.0%     605090        interrupts.CPU3.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU3.MCP:Machine_check_polls
      3916 ± 30%     -45.6%       2130 ± 32%      -1.1%       3875 ± 68%  interrupts.CPU3.NMI:Non-maskable_interrupts
      3916 ± 30%     -45.6%       2130 ± 32%      -1.1%       3875 ± 68%  interrupts.CPU3.PMI:Performance_monitoring_interrupts
    113.50 ± 95%     -24.0%      86.25 ± 95%     -27.1%      82.75 ±139%  interrupts.CPU3.RES:Rescheduling_interrupts
    199.75 ±161%     -92.2%      15.50 ±162%     -30.5%     138.75 ±170%  interrupts.CPU3.TLB:TLB_shootdowns
      2001 ± 95%    +164.9%       5299 ±156%    +361.5%       9234 ±169%  interrupts.CPU30.39:PCI-MSI.2621445-edge.eth0-TxRx-4
      1240 ± 23%    +115.5%       2672 ± 58%     +78.0%       2207 ± 47%  interrupts.CPU30.CAL:Function_call_interrupts
      0.50 ±173%     -50.0%       0.25 ±173%    -100.0%       0.00        interrupts.CPU30.IWI:IRQ_work_interrupts
    605342            +0.0%     605613            -0.1%     604856        interrupts.CPU30.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU30.MCP:Machine_check_polls
      3522 ± 80%     -39.6%       2126 ± 55%     -17.2%       2916 ±  2%  interrupts.CPU30.NMI:Non-maskable_interrupts
      3522 ± 80%     -39.6%       2126 ± 55%     -17.2%       2916 ±  2%  interrupts.CPU30.PMI:Performance_monitoring_interrupts
    133.75 ± 81%     -31.4%      91.75 ± 71%     -49.2%      68.00 ± 86%  interrupts.CPU30.RES:Rescheduling_interrupts
    284.50 ±107%     -36.7%     180.00 ±172%     -99.1%       2.50 ± 82%  interrupts.CPU30.TLB:TLB_shootdowns
    179.25 ±  5%   +1577.8%       3007 ±162%    +404.3%     904.00 ± 84%  interrupts.CPU31.40:PCI-MSI.2621446-edge.eth0-TxRx-5
      1845 ± 47%      -1.2%       1823 ± 50%     -30.7%       1278 ± 19%  interrupts.CPU31.CAL:Function_call_interrupts
      1.00 ±100%     -25.0%       0.75 ±110%     +25.0%       1.25 ± 66%  interrupts.CPU31.IWI:IRQ_work_interrupts
    605195            +0.1%     605548            -0.1%     604340        interrupts.CPU31.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU31.MCP:Machine_check_polls
      4519 ± 58%     -28.0%       3254 ± 37%     +32.8%       6000 ± 39%  interrupts.CPU31.NMI:Non-maskable_interrupts
      4519 ± 58%     -28.0%       3254 ± 37%     +32.8%       6000 ± 39%  interrupts.CPU31.PMI:Performance_monitoring_interrupts
    122.50 ± 90%     +40.6%     172.25 ± 58%     +64.1%     201.00 ± 62%  interrupts.CPU31.RES:Rescheduling_interrupts
    400.75 ± 92%      -8.9%     365.00 ±100%     +20.9%     484.50 ± 53%  interrupts.CPU31.TLB:TLB_shootdowns
     18460 ±136%     -91.0%       1655 ±153%     -96.4%     666.75 ± 82%  interrupts.CPU32.41:PCI-MSI.2621447-edge.eth0-TxRx-6
      2238 ± 72%     +29.5%       2898 ± 88%     +25.3%       2804 ± 61%  interrupts.CPU32.CAL:Function_call_interrupts
      0.50 ±173%      +0.0%       0.50 ±173%     +50.0%       0.75 ±173%  interrupts.CPU32.IWI:IRQ_work_interrupts
    604687            +0.1%     605543            -0.1%     604237        interrupts.CPU32.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU32.MCP:Machine_check_polls
      4082 ± 63%     -22.4%       3167 ± 94%      -8.6%       3732 ± 64%  interrupts.CPU32.NMI:Non-maskable_interrupts
      4082 ± 63%     -22.4%       3167 ± 94%      -8.6%       3732 ± 64%  interrupts.CPU32.PMI:Performance_monitoring_interrupts
    114.50 ± 96%     -25.3%      85.50 ± 78%     -32.3%      77.50 ± 27%  interrupts.CPU32.RES:Rescheduling_interrupts
    190.00 ±167%      -5.5%     179.50 ±172%     +31.7%     250.25 ±104%  interrupts.CPU32.TLB:TLB_shootdowns
    304.75 ± 56%    +447.1%       1667 ±133%     +61.5%     492.25 ±101%  interrupts.CPU33.42:PCI-MSI.2621448-edge.eth0-TxRx-7
      1915 ± 35%     -25.3%       1431 ± 16%     +48.5%       2844 ± 85%  interrupts.CPU33.CAL:Function_call_interrupts
      1.50 ± 57%      +0.0%       1.50 ± 33%     -33.3%       1.00 ± 70%  interrupts.CPU33.IWI:IRQ_work_interrupts
    605285            +0.0%     605539            -0.1%     604750        interrupts.CPU33.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU33.MCP:Machine_check_polls
      5829 ± 48%      +7.3%       6252 ± 33%     -16.0%       4899 ± 42%  interrupts.CPU33.NMI:Non-maskable_interrupts
      5829 ± 48%      +7.3%       6252 ± 33%     -16.0%       4899 ± 42%  interrupts.CPU33.PMI:Performance_monitoring_interrupts
    132.50 ± 76%     +34.0%     177.50 ± 50%     +70.6%     226.00 ± 51%  interrupts.CPU33.RES:Rescheduling_interrupts
    535.50 ± 58%      +8.6%     581.50 ± 45%     -14.5%     457.75 ± 60%  interrupts.CPU33.TLB:TLB_shootdowns
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU34.4:IO-APIC.4-edge.ttyS0
      1392 ± 22%     -25.6%       1036 ± 27%     -12.7%       1216 ± 18%  interrupts.CPU34.CAL:Function_call_interrupts
      1.50 ± 33%     -83.3%       0.25 ±173%     +33.3%       2.00 ± 93%  interrupts.CPU34.IWI:IRQ_work_interrupts
    605401            +0.0%     605572            -0.1%     604871        interrupts.CPU34.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU34.MCP:Machine_check_polls
      5969 ± 25%     -58.5%       2477 ± 46%     -27.5%       4330 ± 65%  interrupts.CPU34.NMI:Non-maskable_interrupts
      5969 ± 25%     -58.5%       2477 ± 46%     -27.5%       4330 ± 65%  interrupts.CPU34.PMI:Performance_monitoring_interrupts
    124.00 ± 84%     -43.8%      69.75 ± 92%     -33.7%      82.25 ± 94%  interrupts.CPU34.RES:Rescheduling_interrupts
      1345 ± 78%     -86.7%     179.50 ±172%     -80.3%     264.50 ± 98%  interrupts.CPU34.TLB:TLB_shootdowns
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU35.44:PCI-MSI.2623489-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU35.53:PCI-MSI.65536-edge.ioat-msix
      2543 ± 88%     -48.6%       1306 ± 19%     -49.1%       1294 ± 19%  interrupts.CPU35.CAL:Function_call_interrupts
      2.00 ±122%     -37.5%       1.25 ± 87%     -50.0%       1.00 ± 70%  interrupts.CPU35.IWI:IRQ_work_interrupts
    605182            +0.1%     605623            -0.1%     604633        interrupts.CPU35.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU35.MCP:Machine_check_polls
      4367 ± 66%      +9.1%       4763 ± 38%      +4.1%       4544 ± 54%  interrupts.CPU35.NMI:Non-maskable_interrupts
      4367 ± 66%      +9.1%       4763 ± 38%      +4.1%       4544 ± 54%  interrupts.CPU35.PMI:Performance_monitoring_interrupts
     79.75 ± 40%     +75.9%     140.25 ± 72%    +143.3%     194.00 ± 59%  interrupts.CPU35.RES:Rescheduling_interrupts
    333.00 ±103%     +47.7%     491.75 ± 61%     +35.2%     450.25 ± 60%  interrupts.CPU35.TLB:TLB_shootdowns
      1465 ± 17%      +0.2%       1467 ± 24%      -8.1%       1346 ± 27%  interrupts.CPU36.CAL:Function_call_interrupts
      1.25 ± 66%     -40.0%       0.75 ±110%     -80.0%       0.25 ±173%  interrupts.CPU36.IWI:IRQ_work_interrupts
    605624            +0.0%     605649            -0.0%     605407        interrupts.CPU36.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU36.MCP:Machine_check_polls
      5927 ± 41%     -29.0%       4209 ± 61%     -58.2%       2479 ± 45%  interrupts.CPU36.NMI:Non-maskable_interrupts
      5927 ± 41%     -29.0%       4209 ± 61%     -58.2%       2479 ± 45%  interrupts.CPU36.PMI:Performance_monitoring_interrupts
    156.50 ± 59%     -27.6%     113.25 ± 47%     -53.0%      73.50 ± 48%  interrupts.CPU36.RES:Rescheduling_interrupts
    427.75 ± 74%      -7.7%     395.00 ± 91%     -47.5%     224.50 ± 80%  interrupts.CPU36.TLB:TLB_shootdowns
      1636 ± 25%     -16.5%       1366 ± 20%      +5.2%       1722 ± 49%  interrupts.CPU37.CAL:Function_call_interrupts
      1.00 ± 70%     -50.0%       0.50 ±100%     -25.0%       0.75 ±110%  interrupts.CPU37.IWI:IRQ_work_interrupts
    605311            +0.1%     605639            -0.1%     604977        interrupts.CPU37.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU37.MCP:Machine_check_polls
      4891 ± 42%     -34.3%       3214 ± 33%     -13.9%       4211 ± 61%  interrupts.CPU37.NMI:Non-maskable_interrupts
      4891 ± 42%     -34.3%       3214 ± 33%     -13.9%       4211 ± 61%  interrupts.CPU37.PMI:Performance_monitoring_interrupts
    177.50 ± 47%     -35.1%     115.25 ± 44%     -27.9%     128.00 ± 91%  interrupts.CPU37.RES:Rescheduling_interrupts
    429.50 ± 76%     -18.5%     350.00 ± 99%     -27.4%     311.75 ±102%  interrupts.CPU37.TLB:TLB_shootdowns
      1610           +14.6%       1845 ± 13%     +11.4%       1793 ± 49%  interrupts.CPU38.CAL:Function_call_interrupts
      2.50 ± 60%     -70.0%       0.75 ±110%     -50.0%       1.25 ±173%  interrupts.CPU38.IWI:IRQ_work_interrupts
    605307            +0.0%     605456            -0.0%     605100        interrupts.CPU38.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU38.MCP:Machine_check_polls
      6011 ± 39%     -29.9%       4216 ± 61%     -53.5%       2794 ±  6%  interrupts.CPU38.NMI:Non-maskable_interrupts
      6011 ± 39%     -29.9%       4216 ± 61%     -53.5%       2794 ±  6%  interrupts.CPU38.PMI:Performance_monitoring_interrupts
    223.75 ± 44%     -16.2%     187.50 ± 48%     -70.8%      65.25 ± 56%  interrupts.CPU38.RES:Rescheduling_interrupts
    734.00 ±  9%     -44.9%     404.25 ± 92%     -83.4%     121.75 ±122%  interrupts.CPU38.TLB:TLB_shootdowns
      1730 ± 77%     -20.2%       1381 ± 21%     -24.5%       1306 ± 20%  interrupts.CPU39.CAL:Function_call_interrupts
      0.00       +7.5e+101%       0.75 ±110%   +1e+102%       1.00 ± 70%  interrupts.CPU39.IWI:IRQ_work_interrupts
    605466            -0.0%     605451            -0.2%     604258        interrupts.CPU39.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU39.MCP:Machine_check_polls
      2971 ±  3%      +9.2%       3245 ± 36%     +65.0%       4903 ± 42%  interrupts.CPU39.NMI:Non-maskable_interrupts
      2971 ±  3%      +9.2%       3245 ± 36%     +65.0%       4903 ± 42%  interrupts.CPU39.PMI:Performance_monitoring_interrupts
     65.50 ± 51%     +48.9%      97.50 ± 60%    +205.0%     199.75 ± 51%  interrupts.CPU39.RES:Rescheduling_interrupts
     22.75 ±150%   +1487.9%     361.25 ± 99%   +1949.5%     466.25 ± 60%  interrupts.CPU39.TLB:TLB_shootdowns
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU4.49:PCI-MSI.2623494-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU4.59:PCI-MSI.73728-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU4.59:PCI-MSI.75776-edge.ioat-msix
      1506 ±  6%     +35.9%       2047 ± 35%     -14.7%       1285 ± 21%  interrupts.CPU4.CAL:Function_call_interrupts
      1.50 ± 33%     -66.7%       0.50 ±100%     +16.7%       1.75 ± 24%  interrupts.CPU4.IWI:IRQ_work_interrupts
    605289            +0.1%     605622            -0.1%     604911        interrupts.CPU4.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU4.MCP:Machine_check_polls
      6131 ± 31%     -49.0%       3129 ± 36%     +25.6%       7698 ± 14%  interrupts.CPU4.NMI:Non-maskable_interrupts
      6131 ± 31%     -49.0%       3129 ± 36%     +25.6%       7698 ± 14%  interrupts.CPU4.PMI:Performance_monitoring_interrupts
    185.50 ± 61%      +1.1%     187.50 ± 46%     -12.3%     162.75 ± 84%  interrupts.CPU4.RES:Rescheduling_interrupts
    722.50 ±  4%     -52.0%     346.50 ±100%     -39.2%     439.50 ± 61%  interrupts.CPU4.TLB:TLB_shootdowns
      1526 ±  5%     -27.1%       1112 ± 23%     -27.8%       1101 ± 22%  interrupts.CPU40.CAL:Function_call_interrupts
      1.75 ± 24%     -71.4%       0.50 ±100%     -42.9%       1.00 ±100%  interrupts.CPU40.IWI:IRQ_work_interrupts
    605232            +0.1%     606066            -0.1%     604911        interrupts.CPU40.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU40.MCP:Machine_check_polls
      7314 ± 24%     -56.7%       3166 ± 35%     -33.1%       4895 ± 70%  interrupts.CPU40.NMI:Non-maskable_interrupts
      7314 ± 24%     -56.7%       3166 ± 35%     -33.1%       4895 ± 70%  interrupts.CPU40.PMI:Performance_monitoring_interrupts
    193.25 ± 54%     -40.0%     116.00 ± 98%     -71.0%      56.00 ±101%  interrupts.CPU40.RES:Rescheduling_interrupts
    737.75 ±  4%     -49.1%     375.50 ± 99%     -64.7%     260.50 ± 99%  interrupts.CPU40.TLB:TLB_shootdowns
      1666 ± 63%     -17.9%       1367 ± 41%     -24.7%       1254 ± 17%  interrupts.CPU41.CAL:Function_call_interrupts
      0.00       +2.5e+101%       0.25 ±173%   +1e+102%       1.00 ± 70%  interrupts.CPU41.IWI:IRQ_work_interrupts
    605534            -0.0%     605304            -0.1%     604725        interrupts.CPU41.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU41.MCP:Machine_check_polls
      2161 ± 32%     +31.4%       2839 ± 34%     +83.4%       3963 ± 16%  interrupts.CPU41.NMI:Non-maskable_interrupts
      2161 ± 32%     +31.4%       2839 ± 34%     +83.4%       3963 ± 16%  interrupts.CPU41.PMI:Performance_monitoring_interrupts
     19.75 ±111%    +287.3%      76.50 ± 87%    +932.9%     204.00 ± 47%  interrupts.CPU41.RES:Rescheduling_interrupts
      6.75 ± 82%   +2463.0%     173.00 ±171%   +6366.7%     436.50 ± 58%  interrupts.CPU41.TLB:TLB_shootdowns
      1349 ± 20%      +1.8%       1373 ± 23%     -10.5%       1207 ± 24%  interrupts.CPU42.CAL:Function_call_interrupts
      1.00 ± 70%     +25.0%       1.25 ± 66%     -25.0%       0.75 ±110%  interrupts.CPU42.IWI:IRQ_work_interrupts
    605253            +0.1%     605683            -0.1%     604852        interrupts.CPU42.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU42.MCP:Machine_check_polls
      4794 ± 45%     +24.0%       5945 ± 41%      +3.5%       4961 ± 46%  interrupts.CPU42.NMI:Non-maskable_interrupts
      4794 ± 45%     +24.0%       5945 ± 41%      +3.5%       4961 ± 46%  interrupts.CPU42.PMI:Performance_monitoring_interrupts
    122.25 ± 91%     +35.6%     165.75 ± 52%      +1.2%     123.75 ± 85%  interrupts.CPU42.RES:Rescheduling_interrupts
    572.00 ± 50%      -0.7%     568.25 ± 57%     -63.4%     209.25 ±147%  interrupts.CPU42.TLB:TLB_shootdowns
    996.25 ± 18%     +27.8%       1272 ± 34%     +34.9%       1344 ± 12%  interrupts.CPU43.CAL:Function_call_interrupts
      0.25 ±173%      +0.0%       0.25 ±173%    +400.0%       1.25 ± 66%  interrupts.CPU43.IWI:IRQ_work_interrupts
    605360            +0.1%     605683            -0.1%     604667        interrupts.CPU43.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU43.MCP:Machine_check_polls
      2857 ± 61%     -13.2%       2481 ± 45%     +75.5%       5013 ± 36%  interrupts.CPU43.NMI:Non-maskable_interrupts
      2857 ± 61%     -13.2%       2481 ± 45%     +75.5%       5013 ± 36%  interrupts.CPU43.PMI:Performance_monitoring_interrupts
     27.50 ± 45%    +155.5%      70.25 ± 90%    +587.3%     189.00 ± 61%  interrupts.CPU43.RES:Rescheduling_interrupts
      2.50 ± 72%   +6860.0%     174.00 ±171%  +17700.0%     445.00 ± 60%  interrupts.CPU43.TLB:TLB_shootdowns
      1578           -12.6%       1379 ± 22%     +64.5%       2596 ± 82%  interrupts.CPU44.CAL:Function_call_interrupts
      1.75 ± 24%     -14.3%       1.50 ± 57%     -71.4%       0.50 ±173%  interrupts.CPU44.IWI:IRQ_work_interrupts
    605345            +0.0%     605519            -0.1%     604690        interrupts.CPU44.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU44.MCP:Machine_check_polls
      6443 ± 29%      -7.4%       5966 ± 47%     -36.2%       4111 ± 61%  interrupts.CPU44.NMI:Non-maskable_interrupts
      6443 ± 29%      -7.4%       5966 ± 47%     -36.2%       4111 ± 61%  interrupts.CPU44.PMI:Performance_monitoring_interrupts
    193.50 ± 54%     -27.6%     140.00 ± 74%     -49.4%      98.00 ± 75%  interrupts.CPU44.RES:Rescheduling_interrupts
    746.75 ±  3%     -27.1%     544.75 ± 57%     -77.8%     165.50 ±130%  interrupts.CPU44.TLB:TLB_shootdowns
      1029 ± 25%     +89.0%       1945 ± 78%     +43.3%       1475 ± 43%  interrupts.CPU45.CAL:Function_call_interrupts
      0.75 ±110%     -66.7%       0.25 ±173%      +0.0%       0.75 ±110%  interrupts.CPU45.IWI:IRQ_work_interrupts
    605362            +0.0%     605588            -0.1%     604986        interrupts.CPU45.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU45.MCP:Machine_check_polls
      4517 ± 56%     -37.2%       2838 ± 34%      -7.2%       4192 ± 60%  interrupts.CPU45.NMI:Non-maskable_interrupts
      4517 ± 56%     -37.2%       2838 ± 34%      -7.2%       4192 ± 60%  interrupts.CPU45.PMI:Performance_monitoring_interrupts
     34.50 ± 89%    +108.7%      72.00 ± 94%    +232.6%     114.75 ± 60%  interrupts.CPU45.RES:Rescheduling_interrupts
    160.50 ±170%      +8.1%     173.50 ±170%     +48.6%     238.50 ±102%  interrupts.CPU45.TLB:TLB_shootdowns
      1580 ±  2%     -14.8%       1346 ± 20%     +28.5%       2030 ± 44%  interrupts.CPU46.CAL:Function_call_interrupts
      1.50 ± 33%     -50.0%       0.75 ± 57%     -83.3%       0.25 ±173%  interrupts.CPU46.IWI:IRQ_work_interrupts
    605230            +0.1%     605538            -0.1%     604401        interrupts.CPU46.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU46.MCP:Machine_check_polls
      5411 ± 31%     -28.8%       3853 ± 14%     -46.3%       2904 ± 30%  interrupts.CPU46.NMI:Non-maskable_interrupts
      5411 ± 31%     -28.8%       3853 ± 14%     -46.3%       2904 ± 30%  interrupts.CPU46.PMI:Performance_monitoring_interrupts
    194.00 ± 54%     -19.2%     156.75 ± 60%     -70.1%      58.00 ± 40%  interrupts.CPU46.RES:Rescheduling_interrupts
    740.25 ±  4%     -23.9%     563.25 ± 57%     -81.4%     137.75 ±167%  interrupts.CPU46.TLB:TLB_shootdowns
    933.25 ± 17%      +6.5%     994.25 ± 20%     +12.3%       1048 ± 22%  interrupts.CPU47.CAL:Function_call_interrupts
      0.75 ±110%     -33.3%       0.50 ±173%      +0.0%       0.75 ±110%  interrupts.CPU47.IWI:IRQ_work_interrupts
    604858            +0.1%     605291            -0.0%     604673        interrupts.CPU47.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU47.MCP:Machine_check_polls
      4349 ± 54%      -1.9%       4269 ± 57%      -1.7%       4275 ± 57%  interrupts.CPU47.NMI:Non-maskable_interrupts
      4349 ± 54%      -1.9%       4269 ± 57%      -1.7%       4275 ± 57%  interrupts.CPU47.PMI:Performance_monitoring_interrupts
     75.50 ± 71%     -16.6%      63.00 ± 96%     +28.1%      96.75 ± 78%  interrupts.CPU47.RES:Rescheduling_interrupts
    133.75 ±139%      +3.9%     139.00 ±145%     +65.4%     221.25 ± 79%  interrupts.CPU47.TLB:TLB_shootdowns
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU5.50:PCI-MSI.2623495-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU5.60:PCI-MSI.75776-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU5.60:PCI-MSI.77824-edge.ioat-msix
      1235 ± 22%     -13.6%       1068 ± 26%     -13.3%       1071 ± 23%  interrupts.CPU5.CAL:Function_call_interrupts
      1.25 ± 66%     -80.0%       0.25 ±173%     -60.0%       0.50 ±100%  interrupts.CPU5.IWI:IRQ_work_interrupts
    605436            +0.0%     605547            -0.1%     604758        interrupts.CPU5.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU5.MCP:Machine_check_polls
      6254 ± 37%     -60.0%       2503 ± 44%     -41.6%       3652 ± 22%  interrupts.CPU5.NMI:Non-maskable_interrupts
      6254 ± 37%     -60.0%       2503 ± 44%     -41.6%       3652 ± 22%  interrupts.CPU5.PMI:Performance_monitoring_interrupts
    124.25 ±103%     -35.0%      80.75 ± 73%     -28.0%      89.50 ±125%  interrupts.CPU5.RES:Rescheduling_interrupts
    254.50 ±118%    +600.3%       1782 ±150%     -45.8%     138.00 ±172%  interrupts.CPU5.TLB:TLB_shootdowns
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU6.51:PCI-MSI.2623496-edge
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU6.61:PCI-MSI.77824-edge.ioat-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU6.61:PCI-MSI.79872-edge.ioat-msix
      1533 ± 29%     -11.0%       1364 ± 20%      -7.1%       1424 ±  6%  interrupts.CPU6.CAL:Function_call_interrupts
      1.25 ± 66%     -40.0%       0.75 ± 57%     +60.0%       2.00        interrupts.CPU6.IWI:IRQ_work_interrupts
    605020            +0.1%     605659            -0.0%     604855        interrupts.CPU6.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU6.MCP:Machine_check_polls
      5949 ± 41%     -41.1%       3506 ± 33%     +36.2%       8104 ±  4%  interrupts.CPU6.NMI:Non-maskable_interrupts
      5949 ± 41%     -41.1%       3506 ± 33%     +36.2%       8104 ±  4%  interrupts.CPU6.PMI:Performance_monitoring_interrupts
    129.50 ± 81%     +23.9%     160.50 ± 60%     +53.9%     199.25 ± 54%  interrupts.CPU6.RES:Rescheduling_interrupts
    461.25 ± 69%     +20.0%     553.50 ± 58%     +27.0%     586.00 ± 16%  interrupts.CPU6.TLB:TLB_shootdowns
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU7.62:PCI-MSI.2097152-edge.isci-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU7.62:PCI-MSI.79872-edge.ioat-msix
      1470 ± 18%     -12.3%       1289 ± 26%     +38.4%       2033 ± 97%  interrupts.CPU7.CAL:Function_call_interrupts
      0.75 ±110%      +0.0%       0.75 ±110%      +0.0%       0.75 ±110%  interrupts.CPU7.IWI:IRQ_work_interrupts
    605330            +0.0%     605452            -0.1%     604814        interrupts.CPU7.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU7.MCP:Machine_check_polls
      4480 ± 51%     -14.1%       3850 ± 73%      +3.4%       4632 ± 48%  interrupts.CPU7.NMI:Non-maskable_interrupts
      4480 ± 51%     -14.1%       3850 ± 73%      +3.4%       4632 ± 48%  interrupts.CPU7.PMI:Performance_monitoring_interrupts
    130.50 ± 72%     -23.0%     100.50 ± 52%     -70.5%      38.50 ±104%  interrupts.CPU7.RES:Rescheduling_interrupts
    365.50 ±100%     +12.5%     411.25 ± 90%     -61.4%     141.25 ±171%  interrupts.CPU7.TLB:TLB_shootdowns
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU8.22:IO-APIC.22-fasteoi.ehci_hcd:usb1
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU8.63:PCI-MSI.2097152-edge.isci-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU8.64:PCI-MSI.2097152-edge.isci-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU8.67:PCI-MSI.2097152-edge.isci-msix
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU8.73:PCI-MSI.2097152-edge.isci-msix
      1332 ± 19%      +7.7%       1435 ± 15%      -2.0%       1305 ± 15%  interrupts.CPU8.CAL:Function_call_interrupts
      1.00 ± 70%      +0.0%       1.00 ± 70%     +25.0%       1.25 ± 66%  interrupts.CPU8.IWI:IRQ_work_interrupts
    605276            +0.0%     605504            -0.1%     604672        interrupts.CPU8.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU8.MCP:Machine_check_polls
      4586 ± 53%      +6.1%       4864 ± 43%     +23.6%       5668 ± 49%  interrupts.CPU8.NMI:Non-maskable_interrupts
      4586 ± 53%      +6.1%       4864 ± 43%     +23.6%       5668 ± 49%  interrupts.CPU8.PMI:Performance_monitoring_interrupts
    127.50 ± 88%     +52.9%     195.00 ± 35%     +49.6%     190.75 ± 59%  interrupts.CPU8.RES:Rescheduling_interrupts
    565.25 ± 57%      -1.1%     558.75 ± 58%     -14.4%     484.00 ± 44%  interrupts.CPU8.TLB:TLB_shootdowns
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU9.20:IO-APIC.20-fasteoi.ehci_hcd:usb2
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU9.64:PCI-MSI.79872-edge.ioat-msix
      2520 ± 94%     +44.6%       3645 ± 47%     -49.8%       1266 ± 21%  interrupts.CPU9.CAL:Function_call_interrupts
      0.50 ±173%    +150.0%       1.25 ±173%      +0.0%       0.50 ±100%  interrupts.CPU9.IWI:IRQ_work_interrupts
    605454            -0.1%     604785            -0.1%     604718        interrupts.CPU9.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.CPU9.MCP:Machine_check_polls
      3794 ± 70%     -41.7%       2210 ± 35%      -4.2%       3635 ± 40%  interrupts.CPU9.NMI:Non-maskable_interrupts
      3794 ± 70%     -41.7%       2210 ± 35%      -4.2%       3635 ± 40%  interrupts.CPU9.PMI:Performance_monitoring_interrupts
    105.75 ±106%     -40.0%      63.50 ± 75%     -53.7%      49.00 ± 52%  interrupts.CPU9.RES:Rescheduling_interrupts
    204.25 ±154%     -25.2%     152.75 ±173%     -35.5%     131.75 ±173%  interrupts.CPU9.TLB:TLB_shootdowns
     47.25 ±  9%     -13.8%      40.75 ±  4%      +0.0%      47.25 ±  7%  interrupts.IWI:IRQ_work_interrupts
  29053273            +0.0%   29064304            -0.1%   29030955        interrupts.LOC:Local_timer_interrupts
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.MCP:Machine_check_polls
    218408 ±  9%     -11.2%     193910 ±  4%      +2.0%     222726 ±  5%  interrupts.NMI:Non-maskable_interrupts
    218408 ±  9%     -11.2%     193910 ±  4%      +2.0%     222726 ±  5%  interrupts.PMI:Performance_monitoring_interrupts
      5885 ± 41%      +1.7%       5986 ± 25%      +2.9%       6055 ± 44%  interrupts.RES:Rescheduling_interrupts
      0.00          -100.0%       0.00          -100.0%       0.00        interrupts.RTR:APIC_ICR_read_retries
     19288 ±  7%      +0.9%      19465 ± 17%     -25.0%      14474 ± 13%  interrupts.TLB:TLB_shootdowns


> 
> NOTE! The patch is entirely untested. I verified that the code
> generation now looks sane, and it all looks ObviouslyCorrect(tm) to
> me, but mistakes happen and maybe I missed some detail..
> 
>                Linus


