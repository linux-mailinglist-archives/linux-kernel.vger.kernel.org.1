Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C199292BFA
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 18:56:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730800AbgJSQ4h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 12:56:37 -0400
Received: from mga18.intel.com ([134.134.136.126]:36550 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730025AbgJSQ4f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 12:56:35 -0400
IronPort-SDR: 1aZLuJmzBVMVDiNInKycrjpCzsHDLFL9IaotgUj5HkNomWiJQBwd4upUjYutBwfD3QCSfn3CbX
 7Dg5MB4loxnA==
X-IronPort-AV: E=McAfee;i="6000,8403,9779"; a="154853457"
X-IronPort-AV: E=Sophos;i="5.77,395,1596524400"; 
   d="xz'?gz'50?scan'50,208,50";a="154853457"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2020 09:56:07 -0700
IronPort-SDR: Vn/LLoHjqaSHHoTkXlr85PkIpnHHLdRyy0GRo46/yC55KXikNf++Ia9bdz+sa0LgrR6QwFBWDK
 nY8YnhHueD+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,395,1596524400"; 
   d="xz'?gz'50?scan'50,208,50";a="315727307"
Received: from lkp-server01.sh.intel.com (HELO 88424da292e0) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 19 Oct 2020 09:56:01 -0700
Received: from kbuild by 88424da292e0 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kUYS0-0000C2-M1; Mon, 19 Oct 2020 16:56:00 +0000
Date:   Tue, 20 Oct 2020 00:55:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     lkp@intel.com, LKP <lkp@lists.01.org>,
        linux-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>, philip.li@intel.com
Subject: 4d004099a6 ("lockdep: Fix lockdep recursion"):  BUG: using
 __this_cpu_read() in preemptible [00000000] code: trinity-c6/526
Message-ID: <5f8dc512.pzfR1ahTGDOChwCh%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="=_5f8dc512.rwdag2xu/8z1nAkUsoq8Xyiq2TWdT0Slqmlff4YZBT2TgiNl"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--=_5f8dc512.rwdag2xu/8z1nAkUsoq8Xyiq2TWdT0Slqmlff4YZBT2TgiNl
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Greetings,

0day kernel testing robot got the below dmesg and the first bad commit is

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

commit 4d004099a668c41522242aa146a38cc4eb59cb1e
Author:     Peter Zijlstra <peterz@infradead.org>
AuthorDate: Fri Oct 2 11:04:21 2020 +0200
Commit:     Ingo Molnar <mingo@kernel.org>
CommitDate: Fri Oct 9 08:53:30 2020 +0200

    lockdep: Fix lockdep recursion
    
    Steve reported that lockdep_assert*irq*(), when nested inside lockdep
    itself, will trigger a false-positive.
    
    One example is the stack-trace code, as called from inside lockdep,
    triggering tracing, which in turn calls RCU, which then uses
    lockdep_assert_irqs_disabled().
    
    Fixes: a21ee6055c30 ("lockdep: Change hardirq{s_enabled,_context} to per-cpu variables")
    Reported-by: Steven Rostedt <rostedt@goodmis.org>
    Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
    Signed-off-by: Ingo Molnar <mingo@kernel.org>

2bb8945bcc  lockdep: Fix usage_traceoverflow
4d004099a6  lockdep: Fix lockdep recursion
7cf726a594  Merge tag 'linux-kselftest-kunit-5.10-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest
+--------------------------------------------------------------------+------------+------------+------------+
|                                                                    | 2bb8945bcc | 4d004099a6 | 7cf726a594 |
+--------------------------------------------------------------------+------------+------------+------------+
| boot_successes                                                     | 12         | 0          | 0          |
| boot_failures                                                      | 4          | 11         | 10         |
| Mem-Info                                                           | 4          |            |            |
| invoked_oom-killer:gfp_mask=0x                                     | 3          |            |            |
| EIP:__copy_user_ll                                                 | 1          |            |            |
| EIP:__get_user_4                                                   | 1          |            |            |
| EIP:__put_user_4                                                   | 1          |            |            |
| EIP:clear_user                                                     | 1          |            |            |
| BUG:using__this_cpu_read()in_preemptible                           | 0          | 11         | 10         |
| WARNING:suspicious_RCU_usage                                       | 0          | 6          | 8          |
| kernel/locking/lockdep.c:#RCU-list_traversed_in_non-reader_section | 0          | 6          | 8          |
+--------------------------------------------------------------------+------------+------------+------------+

If you fix the issue, kindly add following tag
Reported-by: kernel test robot <lkp@intel.com>

[child6:526] fstat64 (197) returned ENOSYS, marking as inactive.
[child4:551] fstatfs (28) returned ENOSYS, marking as inactive.
[child0:520] faccessat (307) returned ENOSYS, marking as inactive.
[child0:520] fstatfs (100) returned ENOSYS, marking as inactive.
[   91.880619] random: 2 urandom warning(s) missed due to ratelimiting
[   92.898145] BUG: using __this_cpu_read() in preemptible [00000000] code: trinity-c6/526
[   92.899792] caller is __this_cpu_preempt_check+0xf/0x11
[   92.900613] CPU: 0 PID: 526 Comm: trinity-c6 Not tainted 5.9.0-rc8-00208-g4d004099a668c4 #1
[   92.901913] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
[   92.903305] Call Trace:
[   92.903780]  dump_stack+0x6b/0x89
[   92.904363]  check_preemption_disabled+0x92/0xa4
[   92.905182]  __this_cpu_preempt_check+0xf/0x11
[   92.905968]  lockdep_hardirqs_on_prepare+0x2c/0x18f
[   92.906853]  trace_hardirqs_on+0x49/0x53
[   92.907578]  __bad_area_nosemaphore+0x3a/0x134
[   92.908363]  ? sysvec_kvm_asyncpf_interrupt+0x4b/0x4b
[   92.909051]  bad_area+0x37/0x3d
[   92.909523]  exc_page_fault+0x3ec/0x4bf
[   92.910228]  ? sysvec_kvm_asyncpf_interrupt+0x4b/0x4b
[   92.911156]  handle_exception+0x126/0x126
[   92.911939] EIP: 0x8084bf8
[   92.912445] Code: 90 90 53 8b 1d 20 8b ac 08 39 d9 0f 83 dc 00 00 00 5b 3b 0d 30 8b ac 08 0f 83 84 00 00 00 81 e9 80 00 00 00 81 e9 80 00 00 00 <66> 0f 7f 02 66 0f 7f 42 10 66 0f 7f 42 20 66 0f 7f 42 30 66 0f 7f
[   92.915660] EAX: 00000000 EBX: 08134000 ECX: 00000f00 EDX: b749d000
[   92.916771] ESI: b749d000 EDI: b749d000 EBP: b74a6030 ESP: bfd60e5c
[   92.917884] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b EFLAGS: 00010206
[   92.919184] BUG: using __this_cpu_read() in preemptible [00000000] code: trinity-c6/526
[   92.920653] caller is __this_cpu_preempt_check+0xf/0x11
[   92.921617] CPU: 0 PID: 526 Comm: trinity-c6 Not tainted 5.9.0-rc8-00208-g4d004099a668c4 #1
[   92.923048] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
[   92.924473] Call Trace:
[   92.924948]  dump_stack+0x6b/0x89
[   92.925556]  check_preemption_disabled+0x92/0xa4
[   92.926378]  ? __bad_area_nosemaphore+0x3a/0x134
[   92.927414]  __this_cpu_preempt_check+0xf/0x11
[   92.928225]  lockdep_hardirqs_on+0x36/0x115
[   92.928976]  trace_hardirqs_on+0x51/0x53
[   92.929681]  __bad_area_nosemaphore+0x3a/0x134
[   92.930651]  ? sysvec_kvm_asyncpf_interrupt+0x4b/0x4b
[   92.931576]  bad_area+0x37/0x3d
[   92.932116]  exc_page_fault+0x3ec/0x4bf
[   92.932814]  ? sysvec_kvm_asyncpf_interrupt+0x4b/0x4b
[   92.933694]  handle_exception+0x126/0x126
[   92.934408] EIP: 0x8084bf8
[   92.934895] Code: 90 90 53 8b 1d 20 8b ac 08 39 d9 0f 83 dc 00 00 00 5b 3b 0d 30 8b ac 08 0f 83 84 00 00 00 81 e9 80 00 00 00 81 e9 80 00 00 00 <66> 0f 7f 02 66 0f 7f 42 10 66 0f 7f 42 20 66 0f 7f 42 30 66 0f 7f
[   92.956477] EAX: 00000000 EBX: 08134000 ECX: 00000f00 EDX: b749d000
[   92.957593] ESI: b749d000 EDI: b749d000 EBP: b74a6030 ESP: bfd60e5c
[   92.958675] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b EFLAGS: 00010206
[   94.314817] caller is __this_cpu_preempt_check+0xf/0x11
[   94.315679] CPU: 1 PID: 712 Comm: trinity-c3 Not tainted 5.9.0-rc8-00208-g4d004099a668c4 #1
[   94.316820] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
[   94.317956] Call Trace:
[   94.318323]  dump_stack+0x6b/0x89
[   94.318788]  check_preemption_disabled+0x92/0xa4
[   94.319471]  __this_cpu_preempt_check+0xf/0x11
[   94.320089]  lockdep_hardirqs_on_prepare+0x2c/0x18f
[   94.320766]  trace_hardirqs_on+0x49/0x53
[   94.321305]  __bad_area_nosemaphore+0x3a/0x134
[   94.322042]  ? sysvec_kvm_asyncpf_interrupt+0x4b/0x4b
[   94.322750]  bad_area+0x37/0x3d
[   94.323226]  exc_page_fault+0x3ec/0x4bf
[   94.323786]  ? sysvec_kvm_asyncpf_interrupt+0x4b/0x4b
[   94.324490]  handle_exception+0x126/0x126
[   94.325043] EIP: 0x805bee0
[   94.325432] Code: 48 6a 00 57 e8 f1 c3 fe ff 83 c4 10 e9 b9 fd ff ff 89 f6 8d bc 27 00 00 00 00 8b 54 24 44 85 d2 74 28 31 ed be 64 00 00 00 90 <c6> 04 2f 25 e8 47 02 00 00 a8 01 b8 73 00 00 00 0f 44 c6 88 44 2f
[   94.327965] EAX: 0805bed8 EBX: 08134000 ECX: 00000008 EDX: 03ecb36e
[   94.328835] ESI: 00000064 EDI: b749b000 EBP: 00000000 ESP: bfd60d20
[   94.329671] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b EFLAGS: 00010246
[   94.330634] BUG: using __this_cpu_read() in preemptible [00000000] code: trinity-c3/712
[   94.331797] caller is __this_cpu_preempt_check+0xf/0x11
[   94.332536] CPU: 1 PID: 712 Comm: trinity-c3 Not tainted 5.9.0-rc8-00208-g4d004099a668c4 #1
[   94.333646] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
[   94.334783] Call Trace:
[   94.335140]  dump_stack+0x6b/0x89
[   94.339655]  check_preemption_disabled+0x92/0xa4
[   94.340307]  ? __bad_area_nosemaphore+0x3a/0x134
[   94.341086]  __this_cpu_preempt_check+0xf/0x11
[   94.341708]  lockdep_hardirqs_on+0x36/0x115
[   94.342298]  trace_hardirqs_on+0x51/0x53
[   94.342858]  __bad_area_nosemaphore+0x3a/0x134
[   94.343668]  ? sysvec_kvm_asyncpf_interrupt+0x4b/0x4b
[   94.344367]  bad_area+0x37/0x3d
[   94.344815]  exc_page_fault+0x3ec/0x4bf
[   94.345352]  ? sysvec_kvm_asyncpf_interrupt+0x4b/0x4b
[   94.346049]  handle_exception+0x126/0x126
[   94.346604] EIP: 0x805bee0
[   94.346997] Code: 48 6a 00 57 e8 f1 c3 fe ff 83 c4 10 e9 b9 fd ff ff 89 f6 8d bc 27 00 00 00 00 8b 54 24 44 85 d2 74 28 31 ed be 64 00 00 00 90 <c6> 04 2f 25 e8 47 02 00 00 a8 01 b8 73 00 00 00 0f 44 c6 88 44 2f
[   94.349539] EAX: 0805bed8 EBX: 08134000 ECX: 00000008 EDX: 03ecb36e
[   94.350401] ESI: 00000064 EDI: b749b000 EBP: 00000000 ESP: bfd60d20
[   94.355448] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b EFLAGS: 00010246
[   94.920644] init: tty5 main process (383) terminated with status 1
[   94.921975] init: tty5 main process ended, respawning
[   94.939382] init: tty4 main process (382) terminated with status 1
[   94.941160] init: tty4 main process ended, respawning
[   94.946647] init: tty2 main process (384) terminated with status 1
[   94.948054] init: tty2 main process ended, respawning
[   94.957691] init: tty3 main process (385) terminated with status 1
[   94.959206] init: tty3 main process ended, respawning
[   95.035891] init: tty6 main process (387) terminated with status 1
[   95.042798] init: tty6 main process ended, respawning
[   95.146323] BUG: using __this_cpu_read() in preemptible [00000000] code: trinity-c7/744
[   95.147923] caller is __this_cpu_preempt_check+0xf/0x11
[   95.148903] CPU: 0 PID: 744 Comm: trinity-c7 Not tainted 5.9.0-rc8-00208-g4d004099a668c4 #1
[   95.150277] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
[   95.151702] Call Trace:
[   95.152126]  dump_stack+0x6b/0x89
[   95.152620]  check_preemption_disabled+0x92/0xa4
[   95.153262]  __this_cpu_preempt_check+0xf/0x11
[   95.153893]  lockdep_hardirqs_on_prepare+0x2c/0x18f
[   95.154596]  trace_hardirqs_on+0x49/0x53
[   95.155285]  __bad_area_nosemaphore+0x3a/0x134
[   95.156227]  ? sysvec_kvm_asyncpf_interrupt+0x4b/0x4b
[   95.156991]  bad_area+0x37/0x3d
[   95.157539]  exc_page_fault+0x3ec/0x4bf
[   95.158234]  ? sysvec_kvm_asyncpf_interrupt+0x4b/0x4b
[   95.159010]  handle_exception+0x126/0x126
[   95.159742] EIP: 0x8084bf8
[   95.160193] Code: 90 90 53 8b 1d 20 8b ac 08 39 d9 0f 83 dc 00 00 00 5b 3b 0d 30 8b ac 08 0f 83 84 00 00 00 81 e9 80 00 00 00 81 e9 80 00 00 00 <66> 0f 7f 02 66 0f 7f 42 10 66 0f 7f 42 20 66 0f 7f 42 30 66 0f 7f
[   95.163390] EAX: 00000000 EBX: 08134000 ECX: 00000f00 EDX: b749b000
[   95.164499] ESI: b749b000 EDI: b749b000 EBP: b749f030 ESP: bfd60d0c
[   95.165575] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b EFLAGS: 00010206
[   95.166889] BUG: using __this_cpu_read() in preemptible [00000000] code: trinity-c7/744
[   95.168327] caller is __this_cpu_preempt_check+0xf/0x11
[   95.169290] CPU: 0 PID: 744 Comm: trinity-c7 Not tainted 5.9.0-rc8-00208-g4d004099a668c4 #1
[   95.170739] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
[   95.172231] Call Trace:
[   95.172694]  dump_stack+0x6b/0x89
[   95.173301]  check_preemption_disabled+0x92/0xa4
[   95.174102]  ? __bad_area_nosemaphore+0x3a/0x134
[   95.175095]  __this_cpu_preempt_check+0xf/0x11
[   95.175898]  lockdep_hardirqs_on+0x36/0x115
[   95.176595]  trace_hardirqs_on+0x51/0x53
[   95.177306]  __bad_area_nosemaphore+0x3a/0x134
[   95.178270]  ? sysvec_kvm_asyncpf_interrupt+0x4b/0x4b
[   95.179157]  bad_area+0x37/0x3d
[   95.179753]  exc_page_fault+0x3ec/0x4bf
[   95.180457]  ? sysvec_kvm_asyncpf_interrupt+0x4b/0x4b
[   95.181355]  handle_exception+0x126/0x126
[   95.182068] EIP: 0x8084bf8
[   95.182573] Code: 90 90 53 8b 1d 20 8b ac 08 39 d9 0f 83 dc 00 00 00 5b 3b 0d 30 8b ac 08 0f 83 84 00 00 00 81 e9 80 00 00 00 81 e9 80 00 00 00 <66> 0f 7f 02 66 0f 7f 42 10 66 0f 7f 42 20 66 0f 7f 42 30 66 0f 7f
[   95.185846] EAX: 00000000 EBX: 08134000 ECX: 00000f00 EDX: b749b000
[   95.186911] ESI: b749b000 EDI: b749b000 EBP: b749f030 ESP: bfd60d0c
[   95.188041] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b EFLAGS: 00010206
[main] 10100 iterations. [F:6736 S:3353 HI:878]
[main] Using pid_max = 32768
[main] futex: 0 owner:0 global:1
[main] Reserved/initialized 10 futexes.
[main] sysv_shm: id:20 size:8192 flags:7b0 ptr:(nil) global:1

                                                          # HH:MM RESULT GOOD BAD GOOD_BUT_DIRTY DIRTY_NOT_BAD
git bisect start 84caa4e94a3e78425c9c9222c5838dc18569ed53 bbf5c979011a099af5dc76498918ed7df445635b --
git bisect  bad dab538a37ee3643a27fa7dace841695022aa3b51  # 18:56  B      0     1   10   0  Merge 'tip/master' into devel-catchup-202010171728
git bisect good e47272658690b17657a850d466be4a0ece0fa845  # 19:15  G     10     0    8   8  0day base guard for 'devel-catchup-202010171728'
git bisect  bad 694b55be5ab7554ff27e30039c01c0ce777a76b2  # 19:31  B      0     2   11   0  Merge 'mptcp/export' into devel-catchup-202010171728
git bisect  bad 726eb70e0d34dc4bc4dada71f52bba8ed638431e  # 19:50  B      0     1   10   0  Merge tag 'char-misc-5.10-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc
git bisect  bad 527f6750d92beb9c787d8aba48477b1e834d64e5  # 20:07  B      0     1   10   0  kasan: remove mentions of unsupported Clang versions
git bisect  bad 647412daeb454b6dad12a6c6961ab90aac9e5d29  # 20:31  B      0     6   16   1  Merge tag 'mmc-v5.10' of git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc
git bisect  bad 3bff6112c80cecb76af5fe485506f96e8adb6122  # 20:41  B      0     1   10   0  Merge tag 'perf-core-2020-10-12' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
git bisect good f5f59336a9ae8f683772d6b8cb2d6732b5e567ea  # 21:11  G     10     0    8   8  Merge tag 'timers-core-2020-10-12' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
git bisect good edaa5ddf3833669a25654d42c0fb653dfdd906df  # 21:24  G     10     0    9   9  Merge tag 'sched-core-2020-10-12' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
git bisect  bad e6412f9833db23740ee848ab3d6e7af18dff82a6  # 21:36  B      0     4   13   0  Merge tag 'efi-core-2020-10-12' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
git bisect  bad e705d397965811ac528d7213b42d74ffe43caf38  # 22:01  B      0     2   11   0  Merge branch 'locking/urgent' into locking/core, to pick up fixes
git bisect good ad56450db86413ff911eb527b5a49e04a4345e61  # 22:28  G     11     0    7   7  locking/selftest: Add test cases for queued_read_lock()
git bisect good 5cdd25572a29e46f932d3e6eedbd07429de66431  # 22:53  G     11     0    9   9  seqlock: Use unique prefix for seqcount_t property accessors
git bisect good 6d1823ccc480866e571ab1206665d693aeb600cf  # 23:06  G     10     0    5   5  lockdep: Optimize the memory usage of circular queue
git bisect  bad baffd723e44dc3d7f84f0b8f1fe1ece00ddd2710  # 23:17  B      0     4   13   0  lockdep: Revert "lockdep: Use raw_cpu_*() for per-cpu variables"
git bisect  bad 4d004099a668c41522242aa146a38cc4eb59cb1e  # 23:39  B      0     1   10   0  lockdep: Fix lockdep recursion
git bisect good 2bb8945bcc1a768f2bc402a16c9610bba8d5187d  # 00:12  G     10     0    6   6  lockdep: Fix usage_traceoverflow
# first bad commit: [4d004099a668c41522242aa146a38cc4eb59cb1e] lockdep: Fix lockdep recursion
git bisect good 2bb8945bcc1a768f2bc402a16c9610bba8d5187d  # 00:20  G     33     0   21  27  lockdep: Fix usage_traceoverflow
# extra tests with debug options
git bisect  bad 4d004099a668c41522242aa146a38cc4eb59cb1e  # 00:38  B      0     9   18   0  lockdep: Fix lockdep recursion
# extra tests on head commit of linus/master
git bisect  bad 7cf726a59435301046250c42131554d9ccc566b8  # 00:49  B      0     4   13   0  Merge tag 'linux-kselftest-kunit-5.10-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest
# bad: [7cf726a59435301046250c42131554d9ccc566b8] Merge tag 'linux-kselftest-kunit-5.10-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest
# extra tests on linus/master
# duplicated: [7cf726a59435301046250c42131554d9ccc566b8] Merge tag 'linux-kselftest-kunit-5.10-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest
# extra tests on linux-next/master
# 119: [b2926c108f9fd225d3fe9ea73fb5c35f48735d20] Add linux-next specific files for 20201016

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/lkp@lists.01.org

--=_5f8dc512.rwdag2xu/8z1nAkUsoq8Xyiq2TWdT0Slqmlff4YZBT2TgiNl
Content-Type: application/gzip
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="dmesg-quantal-vm-quantal-75:20201019234025:i386-randconfig-a005-20201017:5.9.0-rc8-00208-g4d004099a668c4:1.gz"

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
FfzmP/31v8DPZ/8XGg4xM14sAgA=

--=_5f8dc512.rwdag2xu/8z1nAkUsoq8Xyiq2TWdT0Slqmlff4YZBT2TgiNl
Content-Type: application/gzip
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="dmesg-quantal-vm-quantal-102:20201020000235:i386-randconfig-a005-20201017:5.9.0-rc8-00207-g2bb8945bcc1a76:2.gz"

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
F7FSxthBRpoZX7qwgKebrHnSgB3k8bTWVi/EB+1toim0YAf5gAXmOCNj7CDTddKZ7CAfnIcc
3+IsO6ibPi5kB+EBW2aJihbsoCBECDnOCI5unBVAESPkLEXIgJP1LwLZDG5fsixJK4pQELoI
sTBKEcJPzf1WOBNmMCTJoTyNvSYUoSAcHl9bUoSCwPN56rfjFCFcteot2GwhmBT+rQEFJuAh
N2vQ2GIlwl+O3qAjOdXNHnlcSA1ZNsSVJCHXrxPd2MYPH2ePqrWusBDR+c6CLi101xir0N8H
rCINydjzg+58GzmgnvoFaEJeMU2oeDUcZjW6IbhBHKIIsQT2gW6I81MUIStiGqIIlbIhcpQf
FLRiZ7lxftBRVefwg2K13rz515v7++fVj/eP35OJT98/vI0/W/Xm20/rhyc0+HxLnBpcrN/c
rJ9uN9e3n9cfd+/f3T/xD+/++rK+wxbq//v2FmeAt12trjYf//PNZv28+vsiK/WKF2wDerj6
7erd/undD9vbp+/fUZbH7du+oB8+px9xr8BFvfn+h8/v/+HNN3/dfX55+/TT0zO+zd+8u3bm
zTdvd3fUtG8xCf6yeXhZ4U/8ICIMq7+P/8U/REOraXvfvP3MgxR/ePr8sKL/bulSf7fa0TXd
r+52z/j7e/yPwEfxtxUh6b/Crkd//dV390/P+x+37583D7/+Na5fWr39taJyuN0jfepuQ5nv
3z7u6I/484/r58132/uPq1s8P4rd003xt7eEM9zfrba7m5eP+PfH580KG3f3nu/66VtRZXeP
t+tPq6fn7e091fn26eHT+ifsHnf09PM9vvj944rG1Zv/8uYNgTV3W2pXuk17/w5f4t3j+jO+
0ncvdx+vebQ9rO9uN+/lm286u+sH/LX7GT/E41+v159+XP/0dB2/whbL2rw8bNfPuyv84Ro/
ByE8nz5dUw3vX57fY/u9+Qab6Op2TzfNT+/x1wfsNc/fX6H97z8/fXx/f4d/Yrtv0fDT/f6Z
kJCXh1yZu8+3133DvOe/vvnm/v7hqf/50/16e42vQt3rvSID958fntNf0OT28WZ79fn27v7x
enP/gtOQ5/fBjrW9+nT/8frT7ofdp/e7x8c339x+vKORin/lP775hiav+0+793i0xZJ268dP
P8U3oL/8RfxK4mxKb1mkK/76w8f1+ztGU7Ctfnzzzc3j+m7z3ftPt3cvf6Netvv0jv/9dkMv
+PLwFjcHQgpJ/u9Yyd//6U//fv0vf/jdf/v2/buH7z++43zvePBhQVu0ub/FziKETRnffdxs
3oZ3h2w6v1c3GyPUWrpNcFLc3Kz91koP23c/fKZC//PtBB8vfurd4/7q6buX5+39j3fUsP1n
uX7+7nH39N17J6ir/d3f/18clR/+6//5f3+3ehv73Qr/Fn/68I/45zf/H3Oy+s5t6A4A

--=_5f8dc512.rwdag2xu/8z1nAkUsoq8Xyiq2TWdT0Slqmlff4YZBT2TgiNl
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="reproduce-quantal-vm-quantal-75:20201019234025:i386-randconfig-a005-20201017:5.9.0-rc8-00208-g4d004099a668c4:1"

#!/bin/bash

kernel=$1
initrd=quantal-i386-trinity.cgz

wget --no-clobber https://download.01.org/0day-ci/lkp-qemu/osimage/quantal/$initrd

# make INSTALL_MOD_PATH=<mod-install-dir> modules_install
# cd <mod-install-dir>
# find lib/ | cpio -o -H newc --quiet | gzip > modules.cgz
[[ -f modules.cgz ]] || echo "warning: can't find modules.cgz"
cat $initrd modules.cgz > final_initrd.cgz

kvm=(
	qemu-system-x86_64
	-enable-kvm
	-cpu kvm64
	-kernel $kernel
	-initrd final_initrd.cgz
	-m 8192
	-smp 2
	-device e1000,netdev=net0
	-netdev user,id=net0,hostfwd=tcp::32032-:22
	-boot order=nc
	-no-reboot
	-watchdog i6300esb
	-watchdog-action debug
	-rtc base=localtime
	-serial stdio
	-display none
	-monitor null
)

append=(
	root=/dev/ram0
	hung_task_panic=1
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
	rw
	rcuperf.shutdown=0
	watchdog_thresh=60
)

"${kvm[@]}" -append "${append[*]}"

--=_5f8dc512.rwdag2xu/8z1nAkUsoq8Xyiq2TWdT0Slqmlff4YZBT2TgiNl
Content-Type: application/x-xz
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="84caa4e94a3e78425c9c9222c5838dc18569ed53:gcc-9:i386-randconfig-a005-20201017:BUG:using__this_cpu_read__in_preemptible.xz"

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

--=_5f8dc512.rwdag2xu/8z1nAkUsoq8Xyiq2TWdT0Slqmlff4YZBT2TgiNl
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="config-5.9.0-rc8-00208-g4d004099a668c4"

#
# Automatically generated file; DO NOT EDIT.
# Linux/i386 5.9.0-rc8 Kernel Configuration
#
CONFIG_CC_VERSION_TEXT="gcc-9 (Debian 9.3.0-15) 9.3.0"
CONFIG_CC_IS_GCC=y
CONFIG_GCC_VERSION=90300
CONFIG_LD_VERSION=235000000
CONFIG_CLANG_VERSION=0
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
# CONFIG_KERNEL_GZIP is not set
CONFIG_KERNEL_BZIP2=y
# CONFIG_KERNEL_LZMA is not set
# CONFIG_KERNEL_XZ is not set
# CONFIG_KERNEL_LZO is not set
# CONFIG_KERNEL_LZ4 is not set
# CONFIG_KERNEL_ZSTD is not set
CONFIG_DEFAULT_INIT=""
CONFIG_DEFAULT_HOSTNAME="(none)"
CONFIG_SYSVIPC=y
CONFIG_SYSVIPC_SYSCTL=y
# CONFIG_POSIX_MQUEUE is not set
CONFIG_WATCH_QUEUE=y
# CONFIG_CROSS_MEMORY_ATTACH is not set
# CONFIG_USELIB is not set
# CONFIG_AUDIT is not set
CONFIG_HAVE_ARCH_AUDITSYSCALL=y

#
# IRQ subsystem
#
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_GENERIC_IRQ_SHOW=y
CONFIG_GENERIC_IRQ_EFFECTIVE_AFF_MASK=y
CONFIG_GENERIC_PENDING_IRQ=y
CONFIG_GENERIC_IRQ_MIGRATION=y
CONFIG_HARDIRQS_SW_RESEND=y
CONFIG_GENERIC_IRQ_CHIP=y
CONFIG_IRQ_DOMAIN=y
CONFIG_IRQ_DOMAIN_HIERARCHY=y
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

#
# Timers subsystem
#
CONFIG_HZ_PERIODIC=y
# CONFIG_NO_HZ_IDLE is not set
# CONFIG_NO_HZ is not set
# CONFIG_HIGH_RES_TIMERS is not set
# end of Timers subsystem

# CONFIG_PREEMPT_NONE is not set
# CONFIG_PREEMPT_VOLUNTARY is not set
CONFIG_PREEMPT=y
CONFIG_PREEMPT_COUNT=y
CONFIG_PREEMPTION=y

#
# CPU/Task time and stats accounting
#
CONFIG_TICK_CPU_ACCOUNTING=y
# CONFIG_IRQ_TIME_ACCOUNTING is not set
CONFIG_HAVE_SCHED_AVG_IRQ=y
# CONFIG_BSD_PROCESS_ACCT is not set
# CONFIG_TASKSTATS is not set
# CONFIG_PSI is not set
# end of CPU/Task time and stats accounting

CONFIG_CPU_ISOLATION=y

#
# RCU Subsystem
#
CONFIG_TREE_RCU=y
CONFIG_PREEMPT_RCU=y
CONFIG_RCU_EXPERT=y
CONFIG_SRCU=y
CONFIG_TREE_SRCU=y
CONFIG_TASKS_RCU_GENERIC=y
CONFIG_TASKS_RCU=y
CONFIG_TASKS_RUDE_RCU=y
CONFIG_TASKS_TRACE_RCU=y
CONFIG_RCU_STALL_COMMON=y
CONFIG_RCU_NEED_SEGCBLIST=y
CONFIG_RCU_FANOUT=32
CONFIG_RCU_FANOUT_LEAF=16
CONFIG_RCU_BOOST=y
CONFIG_RCU_BOOST_DELAY=500
# CONFIG_RCU_NOCB_CPU is not set
# CONFIG_TASKS_TRACE_RCU_READ_MB is not set
# end of RCU Subsystem

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

CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=y
CONFIG_CGROUPS=y
CONFIG_PAGE_COUNTER=y
CONFIG_MEMCG=y
CONFIG_MEMCG_KMEM=y
# CONFIG_CGROUP_SCHED is not set
# CONFIG_CGROUP_PIDS is not set
CONFIG_CGROUP_RDMA=y
CONFIG_CGROUP_FREEZER=y
# CONFIG_CPUSETS is not set
CONFIG_CGROUP_DEVICE=y
CONFIG_CGROUP_CPUACCT=y
CONFIG_CGROUP_PERF=y
# CONFIG_CGROUP_DEBUG is not set
CONFIG_SOCK_CGROUP_DATA=y
# CONFIG_NAMESPACES is not set
# CONFIG_CHECKPOINT_RESTORE is not set
# CONFIG_SCHED_AUTOGROUP is not set
# CONFIG_SYSFS_DEPRECATED is not set
# CONFIG_RELAY is not set
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_RD_GZIP=y
CONFIG_RD_BZIP2=y
# CONFIG_RD_LZMA is not set
CONFIG_RD_XZ=y
# CONFIG_RD_LZO is not set
# CONFIG_RD_LZ4 is not set
CONFIG_RD_ZSTD=y
CONFIG_BOOT_CONFIG=y
# CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE is not set
CONFIG_CC_OPTIMIZE_FOR_SIZE=y
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
# CONFIG_POSIX_TIMERS is not set
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
# CONFIG_ADVISE_SYSCALLS is not set
# CONFIG_MEMBARRIER is not set
CONFIG_KALLSYMS=y
CONFIG_KALLSYMS_ALL=y
CONFIG_KALLSYMS_BASE_RELATIVE=y
# CONFIG_BPF_SYSCALL is not set
# CONFIG_USERFAULTFD is not set
CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=y
# CONFIG_RSEQ is not set
CONFIG_EMBEDDED=y
CONFIG_HAVE_PERF_EVENTS=y
CONFIG_PC104=y

#
# Kernel Performance Events And Counters
#
CONFIG_PERF_EVENTS=y
# CONFIG_DEBUG_PERF_USE_VMALLOC is not set
# end of Kernel Performance Events And Counters

CONFIG_VM_EVENT_COUNTERS=y
# CONFIG_SLUB_DEBUG is not set
# CONFIG_SLUB_MEMCG_SYSFS_ON is not set
# CONFIG_COMPAT_BRK is not set
# CONFIG_SLAB is not set
CONFIG_SLUB=y
# CONFIG_SLOB is not set
# CONFIG_SLAB_MERGE_DEFAULT is not set
# CONFIG_SLAB_FREELIST_RANDOM is not set
# CONFIG_SLAB_FREELIST_HARDENED is not set
# CONFIG_SHUFFLE_PAGE_ALLOCATOR is not set
# CONFIG_SLUB_CPU_PARTIAL is not set
# CONFIG_PROFILING is not set
CONFIG_TRACEPOINTS=y
# end of General setup

CONFIG_X86_32=y
CONFIG_FORCE_DYNAMIC_FTRACE=y
CONFIG_X86=y
CONFIG_INSTRUCTION_DECODER=y
CONFIG_OUTPUT_FORMAT="elf32-i386"
CONFIG_LOCKDEP_SUPPORT=y
CONFIG_STACKTRACE_SUPPORT=y
CONFIG_MMU=y
CONFIG_ARCH_MMAP_RND_BITS_MIN=8
CONFIG_ARCH_MMAP_RND_BITS_MAX=16
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MIN=8
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MAX=16
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_BUG=y
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
CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
CONFIG_X86_32_SMP=y
CONFIG_ARCH_SUPPORTS_UPROBES=y
CONFIG_FIX_EARLYCON_MEM=y
CONFIG_PGTABLE_LEVELS=3
CONFIG_CC_HAS_SANE_STACKPROTECTOR=y

#
# Processor type and features
#
# CONFIG_ZONE_DMA is not set
CONFIG_SMP=y
CONFIG_X86_FEATURE_NAMES=y
# CONFIG_X86_MPPARSE is not set
CONFIG_GOLDFISH=y
CONFIG_RETPOLINE=y
# CONFIG_X86_CPU_RESCTRL is not set
# CONFIG_X86_BIGSMP is not set
# CONFIG_X86_EXTENDED_PLATFORM is not set
# CONFIG_X86_INTEL_LPSS is not set
CONFIG_X86_AMD_PLATFORM_DEVICE=y
# CONFIG_IOSF_MBI is not set
# CONFIG_X86_32_IRIS is not set
# CONFIG_SCHED_OMIT_FRAME_POINTER is not set
CONFIG_HYPERVISOR_GUEST=y
CONFIG_PARAVIRT=y
# CONFIG_PARAVIRT_DEBUG is not set
CONFIG_PARAVIRT_SPINLOCKS=y
CONFIG_X86_HV_CALLBACK_VECTOR=y
CONFIG_KVM_GUEST=y
CONFIG_ARCH_CPUIDLE_HALTPOLL=y
# CONFIG_PVH is not set
CONFIG_PARAVIRT_TIME_ACCOUNTING=y
CONFIG_PARAVIRT_CLOCK=y
# CONFIG_M486SX is not set
# CONFIG_M486 is not set
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
# CONFIG_M686 is not set
# CONFIG_MPENTIUMII is not set
# CONFIG_MPENTIUMIII is not set
# CONFIG_MPENTIUMM is not set
# CONFIG_MPENTIUM4 is not set
# CONFIG_MK6 is not set
# CONFIG_MK7 is not set
# CONFIG_MK8 is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MEFFICEON is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP3D is not set
CONFIG_MELAN=y
# CONFIG_MGEODEGX1 is not set
# CONFIG_MGEODE_LX is not set
# CONFIG_MCYRIXIII is not set
# CONFIG_MVIAC3_2 is not set
# CONFIG_MVIAC7 is not set
# CONFIG_MCORE2 is not set
# CONFIG_MATOM is not set
# CONFIG_X86_GENERIC is not set
CONFIG_X86_INTERNODE_CACHE_SHIFT=4
CONFIG_X86_L1_CACHE_SHIFT=4
CONFIG_X86_ALIGNMENT_16=y
CONFIG_X86_CMPXCHG64=y
CONFIG_X86_MINIMUM_CPU_FAMILY=5
CONFIG_X86_DEBUGCTLMSR=y
CONFIG_IA32_FEAT_CTL=y
CONFIG_X86_VMX_FEATURE_NAMES=y
# CONFIG_PROCESSOR_SELECT is not set
CONFIG_CPU_SUP_INTEL=y
CONFIG_CPU_SUP_CYRIX_32=y
CONFIG_CPU_SUP_AMD=y
CONFIG_CPU_SUP_HYGON=y
CONFIG_CPU_SUP_CENTAUR=y
CONFIG_CPU_SUP_TRANSMETA_32=y
CONFIG_CPU_SUP_UMC_32=y
CONFIG_CPU_SUP_ZHAOXIN=y
CONFIG_HPET_TIMER=y
CONFIG_HPET_EMULATE_RTC=y
CONFIG_DMI=y
CONFIG_NR_CPUS_RANGE_BEGIN=2
CONFIG_NR_CPUS_RANGE_END=8
CONFIG_NR_CPUS_DEFAULT=8
CONFIG_NR_CPUS=8
CONFIG_SCHED_SMT=y
# CONFIG_SCHED_MC is not set
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS=y
# CONFIG_X86_MCE is not set

#
# Performance monitoring
#
CONFIG_PERF_EVENTS_INTEL_UNCORE=y
CONFIG_PERF_EVENTS_INTEL_RAPL=y
CONFIG_PERF_EVENTS_INTEL_CSTATE=y
CONFIG_PERF_EVENTS_AMD_POWER=y
# end of Performance monitoring

# CONFIG_X86_LEGACY_VM86 is not set
# CONFIG_X86_IOPL_IOPERM is not set
CONFIG_TOSHIBA=y
CONFIG_I8K=y
# CONFIG_X86_REBOOTFIXUPS is not set
# CONFIG_MICROCODE is not set
CONFIG_X86_MSR=y
# CONFIG_X86_CPUID is not set
CONFIG_NOHIGHMEM=y
# CONFIG_HIGHMEM4G is not set
CONFIG_VMSPLIT_3G=y
# CONFIG_VMSPLIT_2G is not set
# CONFIG_VMSPLIT_1G is not set
CONFIG_PAGE_OFFSET=0xC0000000
CONFIG_X86_PAE=y
CONFIG_X86_CPA_STATISTICS=y
CONFIG_ARCH_FLATMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SELECT_MEMORY_MODEL=y
CONFIG_ILLEGAL_POINTER_VALUE=0
# CONFIG_X86_CHECK_BIOS_CORRUPTION is not set
CONFIG_X86_RESERVE_LOW=64
# CONFIG_MTRR is not set
CONFIG_ARCH_RANDOM=y
# CONFIG_X86_SMAP is not set
# CONFIG_X86_UMIP is not set
CONFIG_X86_INTEL_TSX_MODE_OFF=y
# CONFIG_X86_INTEL_TSX_MODE_ON is not set
# CONFIG_X86_INTEL_TSX_MODE_AUTO is not set
CONFIG_EFI=y
CONFIG_EFI_STUB=y
CONFIG_SECCOMP=y
# CONFIG_HZ_100 is not set
CONFIG_HZ_250=y
# CONFIG_HZ_300 is not set
# CONFIG_HZ_1000 is not set
CONFIG_HZ=250
CONFIG_KEXEC=y
CONFIG_PHYSICAL_START=0x1000000
CONFIG_RELOCATABLE=y
# CONFIG_RANDOMIZE_BASE is not set
CONFIG_X86_NEED_RELOCS=y
CONFIG_PHYSICAL_ALIGN=0x200000
CONFIG_HOTPLUG_CPU=y
# CONFIG_BOOTPARAM_HOTPLUG_CPU0 is not set
CONFIG_DEBUG_HOTPLUG_CPU0=y
# CONFIG_COMPAT_VDSO is not set
# CONFIG_CMDLINE_BOOL is not set
# CONFIG_MODIFY_LDT_SYSCALL is not set
# end of Processor type and features

CONFIG_ARCH_ENABLE_SPLIT_PMD_PTLOCK=y

#
# Power management and ACPI options
#
CONFIG_SUSPEND=y
CONFIG_SUSPEND_FREEZER=y
# CONFIG_SUSPEND_SKIP_SYNC is not set
CONFIG_PM_SLEEP=y
CONFIG_PM_SLEEP_SMP=y
# CONFIG_PM_AUTOSLEEP is not set
# CONFIG_PM_WAKELOCKS is not set
CONFIG_PM=y
CONFIG_PM_DEBUG=y
CONFIG_PM_ADVANCED_DEBUG=y
# CONFIG_PM_TEST_SUSPEND is not set
CONFIG_PM_SLEEP_DEBUG=y
CONFIG_DPM_WATCHDOG=y
CONFIG_DPM_WATCHDOG_TIMEOUT=120
# CONFIG_PM_TRACE_RTC is not set
CONFIG_PM_CLK=y
# CONFIG_WQ_POWER_EFFICIENT_DEFAULT is not set
CONFIG_ARCH_SUPPORTS_ACPI=y
CONFIG_ACPI=y
CONFIG_ACPI_LEGACY_TABLES_LOOKUP=y
CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC=y
CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT=y
CONFIG_ACPI_DEBUGGER=y
# CONFIG_ACPI_DEBUGGER_USER is not set
# CONFIG_ACPI_SPCR_TABLE is not set
CONFIG_ACPI_SLEEP=y
CONFIG_ACPI_REV_OVERRIDE_POSSIBLE=y
CONFIG_ACPI_EC_DEBUGFS=y
# CONFIG_ACPI_AC is not set
# CONFIG_ACPI_BATTERY is not set
# CONFIG_ACPI_BUTTON is not set
CONFIG_ACPI_TINY_POWER_BUTTON=y
CONFIG_ACPI_TINY_POWER_BUTTON_SIGNAL=38
CONFIG_ACPI_VIDEO=y
CONFIG_ACPI_FAN=y
CONFIG_ACPI_TAD=y
# CONFIG_ACPI_DOCK is not set
CONFIG_ACPI_CPU_FREQ_PSS=y
CONFIG_ACPI_PROCESSOR_CSTATE=y
CONFIG_ACPI_PROCESSOR_IDLE=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_HOTPLUG_CPU=y
# CONFIG_ACPI_PROCESSOR_AGGREGATOR is not set
CONFIG_ACPI_THERMAL=y
CONFIG_ACPI_CUSTOM_DSDT_FILE=""
CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
# CONFIG_ACPI_TABLE_UPGRADE is not set
CONFIG_ACPI_DEBUG=y
# CONFIG_ACPI_PCI_SLOT is not set
CONFIG_ACPI_CONTAINER=y
CONFIG_ACPI_HOTPLUG_IOAPIC=y
CONFIG_ACPI_SBS=y
CONFIG_ACPI_HED=y
CONFIG_ACPI_CUSTOM_METHOD=y
# CONFIG_ACPI_BGRT is not set
# CONFIG_ACPI_REDUCED_HARDWARE_ONLY is not set
CONFIG_HAVE_ACPI_APEI=y
CONFIG_HAVE_ACPI_APEI_NMI=y
CONFIG_ACPI_APEI=y
# CONFIG_ACPI_APEI_GHES is not set
# CONFIG_ACPI_APEI_EINJ is not set
CONFIG_ACPI_APEI_ERST_DEBUG=y
# CONFIG_DPTF_POWER is not set
# CONFIG_PMIC_OPREGION is not set
CONFIG_ACPI_CONFIGFS=y
CONFIG_X86_PM_TIMER=y
CONFIG_SFI=y
CONFIG_X86_APM_BOOT=y
CONFIG_APM=y
CONFIG_APM_IGNORE_USER_SUSPEND=y
# CONFIG_APM_DO_ENABLE is not set
CONFIG_APM_CPU_IDLE=y
CONFIG_APM_DISPLAY_BLANK=y
# CONFIG_APM_ALLOW_INTS is not set

#
# CPU Frequency scaling
#
# CONFIG_CPU_FREQ is not set
# end of CPU Frequency scaling

#
# CPU Idle
#
CONFIG_CPU_IDLE=y
CONFIG_CPU_IDLE_GOV_LADDER=y
# CONFIG_CPU_IDLE_GOV_MENU is not set
# CONFIG_CPU_IDLE_GOV_TEO is not set
CONFIG_CPU_IDLE_GOV_HALTPOLL=y
CONFIG_HALTPOLL_CPUIDLE=y
# end of CPU Idle

# CONFIG_INTEL_IDLE is not set
# end of Power management and ACPI options

#
# Bus options (PCI etc.)
#
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GOMMCONFIG is not set
# CONFIG_PCI_GODIRECT is not set
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
# CONFIG_PCI_CNB20LE_QUIRK is not set
# CONFIG_ISA_BUS is not set
CONFIG_ISA_DMA_API=y
# CONFIG_ISA is not set
CONFIG_SCx200=y
CONFIG_SCx200HR_TIMER=y
# CONFIG_ALIX is not set
CONFIG_NET5501=y
# CONFIG_GEOS is not set
CONFIG_TS5500=y
CONFIG_AMD_NB=y
CONFIG_X86_SYSFB=y
# end of Bus options (PCI etc.)

#
# Binary Emulations
#
CONFIG_COMPAT_32=y
# end of Binary Emulations

CONFIG_HAVE_ATOMIC_IOMAP=y

#
# Firmware Drivers
#
CONFIG_EDD=y
# CONFIG_EDD_OFF is not set
CONFIG_FIRMWARE_MEMMAP=y
# CONFIG_DMIID is not set
# CONFIG_DMI_SYSFS is not set
CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK=y
# CONFIG_FW_CFG_SYSFS is not set
# CONFIG_GOOGLE_FIRMWARE is not set

#
# EFI (Extensible Firmware Interface) Support
#
CONFIG_EFI_VARS=y
CONFIG_EFI_ESRT=y
# CONFIG_EFI_VARS_PSTORE is not set
# CONFIG_EFI_RUNTIME_MAP is not set
# CONFIG_EFI_FAKE_MEMMAP is not set
CONFIG_EFI_RUNTIME_WRAPPERS=y
CONFIG_EFI_GENERIC_STUB_INITRD_CMDLINE_LOADER=y
CONFIG_EFI_BOOTLOADER_CONTROL=y
CONFIG_EFI_CAPSULE_LOADER=y
CONFIG_EFI_CAPSULE_QUIRK_QUARK_CSH=y
CONFIG_EFI_TEST=y
CONFIG_APPLE_PROPERTIES=y
CONFIG_RESET_ATTACK_MITIGATION=y
CONFIG_EFI_RCI2_TABLE=y
# CONFIG_EFI_DISABLE_PCI_DMA is not set
# end of EFI (Extensible Firmware Interface) Support

CONFIG_UEFI_CPER=y
CONFIG_UEFI_CPER_X86=y
CONFIG_EFI_DEV_PATH_PARSER=y
CONFIG_EFI_EARLYCON=y
# CONFIG_EFI_CUSTOM_SSDT_OVERLAYS is not set

#
# Tegra firmware driver
#
# end of Tegra firmware driver
# end of Firmware Drivers

CONFIG_HAVE_KVM=y
# CONFIG_VIRTUALIZATION is not set
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
CONFIG_HAVE_OPROFILE=y
CONFIG_OPROFILE_NMI_TIMER=y
# CONFIG_KPROBES is not set
# CONFIG_JUMP_LABEL is not set
CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y
CONFIG_ARCH_USE_BUILTIN_BSWAP=y
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
CONFIG_ARCH_32BIT_OFF_T=y
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
CONFIG_ARCH_WANT_IPC_PARSE_VERSION=y
CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
CONFIG_SECCOMP_FILTER=y
CONFIG_HAVE_ARCH_STACKLEAK=y
CONFIG_HAVE_STACKPROTECTOR=y
CONFIG_STACKPROTECTOR=y
CONFIG_STACKPROTECTOR_STRONG=y
CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES=y
CONFIG_HAVE_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_MOVE_PMD=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=y
CONFIG_HAVE_ARCH_HUGE_VMAP=y
CONFIG_ARCH_WANT_HUGE_PMD_SHARE=y
CONFIG_HAVE_MOD_ARCH_SPECIFIC=y
CONFIG_MODULES_USE_ELF_REL=y
CONFIG_ARCH_HAS_ELF_RANDOMIZE=y
CONFIG_HAVE_ARCH_MMAP_RND_BITS=y
CONFIG_HAVE_EXIT_THREAD=y
CONFIG_ARCH_MMAP_RND_BITS=8
CONFIG_ISA_BUS_API=y
CONFIG_CLONE_BACKWARDS=y
CONFIG_OLD_SIGSUSPEND3=y
CONFIG_OLD_SIGACTION=y
CONFIG_COMPAT_32BIT_TIME=y
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
CONFIG_MODULES=y
# CONFIG_MODULE_FORCE_LOAD is not set
# CONFIG_MODULE_UNLOAD is not set
# CONFIG_MODVERSIONS is not set
# CONFIG_MODULE_SRCVERSION_ALL is not set
# CONFIG_MODULE_SIG is not set
# CONFIG_MODULE_COMPRESS is not set
# CONFIG_MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS is not set
CONFIG_UNUSED_SYMBOLS=y
CONFIG_MODULES_TREE_LOOKUP=y
# CONFIG_BLOCK is not set
CONFIG_PADATA=y
CONFIG_ASN1=y
CONFIG_UNINLINE_SPIN_UNLOCK=y
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
CONFIG_ELFCORE=y
CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS=y
CONFIG_BINFMT_SCRIPT=y
CONFIG_BINFMT_MISC=y
CONFIG_COREDUMP=y
# end of Executable file formats

#
# Memory Management options
#
CONFIG_SELECT_MEMORY_MODEL=y
CONFIG_FLATMEM_MANUAL=y
# CONFIG_SPARSEMEM_MANUAL is not set
CONFIG_FLATMEM=y
CONFIG_FLAT_NODE_MEM_MAP=y
CONFIG_SPARSEMEM_STATIC=y
CONFIG_HAVE_FAST_GUP=y
CONFIG_MEMORY_ISOLATION=y
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_COMPACTION=y
# CONFIG_PAGE_REPORTING is not set
CONFIG_MIGRATION=y
CONFIG_CONTIG_ALLOC=y
CONFIG_PHYS_ADDR_T_64BIT=y
CONFIG_VIRT_TO_BUS=y
# CONFIG_KSM is not set
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
CONFIG_TRANSPARENT_HUGEPAGE=y
CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS=y
# CONFIG_TRANSPARENT_HUGEPAGE_MADVISE is not set
CONFIG_CLEANCACHE=y
CONFIG_CMA=y
# CONFIG_CMA_DEBUG is not set
CONFIG_CMA_DEBUGFS=y
CONFIG_CMA_AREAS=7
# CONFIG_ZPOOL is not set
CONFIG_ZBUD=y
CONFIG_ZSMALLOC=y
# CONFIG_ZSMALLOC_PGTABLE_MAPPING is not set
# CONFIG_ZSMALLOC_STAT is not set
CONFIG_GENERIC_EARLY_IOREMAP=y
CONFIG_IDLE_PAGE_TRACKING=y
CONFIG_FRAME_VECTOR=y
CONFIG_PERCPU_STATS=y
CONFIG_GUP_BENCHMARK=y
CONFIG_GUP_GET_PTE_LOW_HIGH=y
# CONFIG_READ_ONLY_THP_FOR_FS is not set
CONFIG_ARCH_HAS_PTE_SPECIAL=y
# end of Memory Management options

CONFIG_NET=y

#
# Networking options
#
CONFIG_PACKET=y
CONFIG_PACKET_DIAG=y
CONFIG_UNIX=y
CONFIG_UNIX_SCM=y
CONFIG_UNIX_DIAG=y
# CONFIG_TLS is not set
# CONFIG_XFRM_USER is not set
# CONFIG_NET_KEY is not set
CONFIG_INET=y
# CONFIG_IP_MULTICAST is not set
# CONFIG_IP_ADVANCED_ROUTER is not set
CONFIG_IP_PNP=y
CONFIG_IP_PNP_DHCP=y
# CONFIG_IP_PNP_BOOTP is not set
# CONFIG_IP_PNP_RARP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE_DEMUX is not set
CONFIG_NET_IP_TUNNEL=y
# CONFIG_SYN_COOKIES is not set
# CONFIG_NET_IPVTI is not set
# CONFIG_NET_FOU is not set
# CONFIG_NET_FOU_IP_TUNNELS is not set
# CONFIG_INET_AH is not set
# CONFIG_INET_ESP is not set
# CONFIG_INET_IPCOMP is not set
CONFIG_INET_TUNNEL=y
CONFIG_INET_DIAG=y
CONFIG_INET_TCP_DIAG=y
# CONFIG_INET_UDP_DIAG is not set
# CONFIG_INET_RAW_DIAG is not set
# CONFIG_INET_DIAG_DESTROY is not set
# CONFIG_TCP_CONG_ADVANCED is not set
CONFIG_TCP_CONG_CUBIC=y
CONFIG_DEFAULT_TCP_CONG="cubic"
# CONFIG_TCP_MD5SIG is not set
CONFIG_IPV6=y
# CONFIG_IPV6_ROUTER_PREF is not set
# CONFIG_IPV6_OPTIMISTIC_DAD is not set
# CONFIG_INET6_AH is not set
# CONFIG_INET6_ESP is not set
# CONFIG_INET6_IPCOMP is not set
# CONFIG_IPV6_MIP6 is not set
# CONFIG_IPV6_VTI is not set
CONFIG_IPV6_SIT=y
# CONFIG_IPV6_SIT_6RD is not set
CONFIG_IPV6_NDISC_NODETYPE=y
# CONFIG_IPV6_TUNNEL is not set
# CONFIG_IPV6_MULTIPLE_TABLES is not set
# CONFIG_IPV6_MROUTE is not set
# CONFIG_IPV6_SEG6_LWTUNNEL is not set
# CONFIG_IPV6_SEG6_HMAC is not set
# CONFIG_IPV6_RPL_LWTUNNEL is not set
# CONFIG_MPTCP is not set
CONFIG_NETWORK_SECMARK=y
# CONFIG_NETWORK_PHY_TIMESTAMPING is not set
# CONFIG_NETFILTER is not set
# CONFIG_BPFILTER is not set
# CONFIG_IP_DCCP is not set
# CONFIG_IP_SCTP is not set
# CONFIG_RDS is not set
# CONFIG_TIPC is not set
CONFIG_ATM=y
# CONFIG_ATM_CLIP is not set
CONFIG_ATM_LANE=y
# CONFIG_ATM_MPOA is not set
# CONFIG_ATM_BR2684 is not set
# CONFIG_L2TP is not set
CONFIG_STP=y
CONFIG_GARP=y
CONFIG_MRP=y
CONFIG_BRIDGE=y
CONFIG_BRIDGE_IGMP_SNOOPING=y
CONFIG_BRIDGE_VLAN_FILTERING=y
# CONFIG_BRIDGE_MRP is not set
CONFIG_HAVE_NET_DSA=y
# CONFIG_NET_DSA is not set
CONFIG_VLAN_8021Q=y
CONFIG_VLAN_8021Q_GVRP=y
CONFIG_VLAN_8021Q_MVRP=y
CONFIG_DECNET=y
CONFIG_DECNET_ROUTER=y
CONFIG_LLC=y
CONFIG_LLC2=y
CONFIG_ATALK=y
CONFIG_DEV_APPLETALK=y
CONFIG_IPDDP=y
CONFIG_IPDDP_ENCAP=y
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_PHONET is not set
# CONFIG_6LOWPAN is not set
# CONFIG_IEEE802154 is not set
CONFIG_NET_SCHED=y

#
# Queueing/Scheduling
#
CONFIG_NET_SCH_CBQ=y
CONFIG_NET_SCH_HTB=y
CONFIG_NET_SCH_HFSC=y
CONFIG_NET_SCH_ATM=y
CONFIG_NET_SCH_PRIO=y
# CONFIG_NET_SCH_MULTIQ is not set
# CONFIG_NET_SCH_RED is not set
CONFIG_NET_SCH_SFB=y
CONFIG_NET_SCH_SFQ=y
CONFIG_NET_SCH_TEQL=y
CONFIG_NET_SCH_TBF=y
# CONFIG_NET_SCH_CBS is not set
# CONFIG_NET_SCH_ETF is not set
CONFIG_NET_SCH_TAPRIO=y
CONFIG_NET_SCH_GRED=y
CONFIG_NET_SCH_DSMARK=y
CONFIG_NET_SCH_NETEM=y
# CONFIG_NET_SCH_DRR is not set
CONFIG_NET_SCH_MQPRIO=y
CONFIG_NET_SCH_SKBPRIO=y
CONFIG_NET_SCH_CHOKE=y
CONFIG_NET_SCH_QFQ=y
CONFIG_NET_SCH_CODEL=y
CONFIG_NET_SCH_FQ_CODEL=y
CONFIG_NET_SCH_CAKE=y
CONFIG_NET_SCH_FQ=y
CONFIG_NET_SCH_HHF=y
CONFIG_NET_SCH_PIE=y
# CONFIG_NET_SCH_FQ_PIE is not set
CONFIG_NET_SCH_PLUG=y
CONFIG_NET_SCH_ETS=y
# CONFIG_NET_SCH_DEFAULT is not set

#
# Classification
#
CONFIG_NET_CLS=y
CONFIG_NET_CLS_BASIC=y
# CONFIG_NET_CLS_TCINDEX is not set
# CONFIG_NET_CLS_ROUTE4 is not set
CONFIG_NET_CLS_FW=y
CONFIG_NET_CLS_U32=y
# CONFIG_CLS_U32_PERF is not set
# CONFIG_CLS_U32_MARK is not set
CONFIG_NET_CLS_RSVP=y
CONFIG_NET_CLS_RSVP6=y
# CONFIG_NET_CLS_FLOW is not set
CONFIG_NET_CLS_CGROUP=y
CONFIG_NET_CLS_BPF=y
CONFIG_NET_CLS_FLOWER=y
# CONFIG_NET_CLS_MATCHALL is not set
# CONFIG_NET_EMATCH is not set
# CONFIG_NET_CLS_ACT is not set
CONFIG_NET_SCH_FIFO=y
CONFIG_DCB=y
CONFIG_DNS_RESOLVER=y
# CONFIG_BATMAN_ADV is not set
# CONFIG_OPENVSWITCH is not set
CONFIG_VSOCKETS=y
# CONFIG_VSOCKETS_DIAG is not set
CONFIG_VSOCKETS_LOOPBACK=y
CONFIG_VIRTIO_VSOCKETS=y
CONFIG_VIRTIO_VSOCKETS_COMMON=y
CONFIG_HYPERV_VSOCKETS=y
CONFIG_NETLINK_DIAG=y
CONFIG_MPLS=y
CONFIG_NET_MPLS_GSO=y
CONFIG_MPLS_ROUTING=y
# CONFIG_MPLS_IPTUNNEL is not set
CONFIG_NET_NSH=y
CONFIG_HSR=y
# CONFIG_NET_SWITCHDEV is not set
# CONFIG_NET_L3_MASTER_DEV is not set
# CONFIG_QRTR is not set
# CONFIG_NET_NCSI is not set
CONFIG_RPS=y
CONFIG_RFS_ACCEL=y
CONFIG_XPS=y
# CONFIG_CGROUP_NET_PRIO is not set
CONFIG_CGROUP_NET_CLASSID=y
CONFIG_NET_RX_BUSY_POLL=y
CONFIG_BQL=y
# CONFIG_BPF_JIT is not set
CONFIG_NET_FLOW_LIMIT=y

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
# CONFIG_NET_DROP_MONITOR is not set
# end of Network testing
# end of Networking options

CONFIG_HAMRADIO=y

#
# Packet Radio protocols
#
# CONFIG_AX25 is not set
# CONFIG_CAN is not set
CONFIG_BT=y
# CONFIG_BT_BREDR is not set
# CONFIG_BT_LE is not set
# CONFIG_BT_LEDS is not set
# CONFIG_BT_MSFTEXT is not set
CONFIG_BT_DEBUGFS=y
# CONFIG_BT_SELFTEST is not set
# CONFIG_BT_FEATURE_DEBUG is not set

#
# Bluetooth device drivers
#
CONFIG_BT_INTEL=y
CONFIG_BT_BCM=y
CONFIG_BT_HCIBTUSB=y
# CONFIG_BT_HCIBTUSB_AUTOSUSPEND is not set
CONFIG_BT_HCIBTUSB_BCM=y
# CONFIG_BT_HCIBTUSB_MTK is not set
# CONFIG_BT_HCIBTUSB_RTL is not set
# CONFIG_BT_HCIUART is not set
CONFIG_BT_HCIBCM203X=y
CONFIG_BT_HCIBPA10X=y
# CONFIG_BT_HCIBFUSB is not set
CONFIG_BT_HCIDTL1=y
CONFIG_BT_HCIBT3C=y
CONFIG_BT_HCIBLUECARD=y
# CONFIG_BT_HCIVHCI is not set
# CONFIG_BT_MRVL is not set
CONFIG_BT_ATH3K=y
CONFIG_BT_MTKUART=y
# end of Bluetooth device drivers

# CONFIG_AF_RXRPC is not set
# CONFIG_AF_KCM is not set
CONFIG_FIB_RULES=y
# CONFIG_WIRELESS is not set
CONFIG_WIMAX=y
CONFIG_WIMAX_DEBUG_LEVEL=8
CONFIG_RFKILL=y
CONFIG_RFKILL_LEDS=y
CONFIG_RFKILL_INPUT=y
CONFIG_RFKILL_GPIO=y
CONFIG_NET_9P=y
CONFIG_NET_9P_VIRTIO=y
CONFIG_NET_9P_DEBUG=y
CONFIG_CAIF=y
# CONFIG_CAIF_DEBUG is not set
CONFIG_CAIF_NETDEV=y
CONFIG_CAIF_USB=y
# CONFIG_CEPH_LIB is not set
# CONFIG_NFC is not set
CONFIG_PSAMPLE=y
CONFIG_NET_IFE=y
CONFIG_LWTUNNEL=y
CONFIG_LWTUNNEL_BPF=y
CONFIG_DST_CACHE=y
CONFIG_GRO_CELLS=y
CONFIG_FAILOVER=y
# CONFIG_ETHTOOL_NETLINK is not set
CONFIG_HAVE_EBPF_JIT=y

#
# Device Drivers
#
CONFIG_HAVE_EISA=y
# CONFIG_EISA is not set
CONFIG_HAVE_PCI=y
CONFIG_PCI=y
CONFIG_PCI_DOMAINS=y
# CONFIG_PCIEPORTBUS is not set
CONFIG_PCIEASPM=y
CONFIG_PCIEASPM_DEFAULT=y
# CONFIG_PCIEASPM_POWERSAVE is not set
# CONFIG_PCIEASPM_POWER_SUPERSAVE is not set
# CONFIG_PCIEASPM_PERFORMANCE is not set
# CONFIG_PCIE_PTM is not set
# CONFIG_PCI_MSI is not set
CONFIG_PCI_QUIRKS=y
# CONFIG_PCI_DEBUG is not set
# CONFIG_PCI_STUB is not set
CONFIG_PCI_LOCKLESS_CONFIG=y
# CONFIG_PCI_IOV is not set
# CONFIG_PCI_PRI is not set
# CONFIG_PCI_PASID is not set
CONFIG_PCI_LABEL=y
# CONFIG_HOTPLUG_PCI is not set

#
# PCI controller drivers
#
# CONFIG_PCI_FTPCI100 is not set
# CONFIG_PCI_HOST_GENERIC is not set
# CONFIG_PCIE_XILINX is not set

#
# DesignWare PCI Core Support
#
# end of DesignWare PCI Core Support

#
# Mobiveil PCIe Core Support
#
# end of Mobiveil PCIe Core Support

#
# Cadence PCIe controllers support
#
# CONFIG_PCIE_CADENCE_PLAT_HOST is not set
# CONFIG_PCI_J721E_HOST is not set
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
CONFIG_PCMCIA=y
# CONFIG_PCMCIA_LOAD_CIS is not set
CONFIG_CARDBUS=y

#
# PC-card bridges
#
# CONFIG_YENTA is not set
# CONFIG_PD6729 is not set
# CONFIG_I82092 is not set
# CONFIG_RAPIDIO is not set

#
# Generic Driver Options
#
CONFIG_UEVENT_HELPER=y
CONFIG_UEVENT_HELPER_PATH=""
CONFIG_DEVTMPFS=y
CONFIG_DEVTMPFS_MOUNT=y
# CONFIG_STANDALONE is not set
CONFIG_PREVENT_FIRMWARE_BUILD=y

#
# Firmware loader
#
CONFIG_FW_LOADER=y
CONFIG_FW_LOADER_PAGED_BUF=y
CONFIG_EXTRA_FIRMWARE=""
CONFIG_FW_LOADER_USER_HELPER=y
CONFIG_FW_LOADER_USER_HELPER_FALLBACK=y
# CONFIG_FW_LOADER_COMPRESS is not set
CONFIG_FW_CACHE=y
# end of Firmware loader

CONFIG_WANT_DEV_COREDUMP=y
# CONFIG_ALLOW_DEV_COREDUMP is not set
# CONFIG_DEBUG_DRIVER is not set
CONFIG_DEBUG_DEVRES=y
# CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
# CONFIG_TEST_ASYNC_DRIVER_PROBE is not set
CONFIG_GENERIC_CPU_AUTOPROBE=y
CONFIG_GENERIC_CPU_VULNERABILITIES=y
CONFIG_REGMAP=y
CONFIG_REGMAP_I2C=y
CONFIG_REGMAP_SLIMBUS=y
CONFIG_REGMAP_SPI=y
CONFIG_REGMAP_W1=y
CONFIG_REGMAP_MMIO=y
CONFIG_REGMAP_IRQ=y
CONFIG_REGMAP_SCCB=y
CONFIG_REGMAP_I3C=y
CONFIG_DMA_SHARED_BUFFER=y
CONFIG_DMA_FENCE_TRACE=y
# end of Generic Driver Options

#
# Bus devices
#
CONFIG_MOXTET=y
CONFIG_SIMPLE_PM_BUS=y
# CONFIG_MHI_BUS is not set
# end of Bus devices

CONFIG_CONNECTOR=y
CONFIG_PROC_EVENTS=y
CONFIG_GNSS=y
CONFIG_GNSS_SERIAL=y
CONFIG_GNSS_MTK_SERIAL=y
# CONFIG_GNSS_SIRF_SERIAL is not set
CONFIG_GNSS_UBX_SERIAL=y
CONFIG_MTD=y
# CONFIG_MTD_TESTS is not set

#
# Partition parsers
#
CONFIG_MTD_AR7_PARTS=y
CONFIG_MTD_CMDLINE_PARTS=y
# CONFIG_MTD_OF_PARTS is not set
# CONFIG_MTD_REDBOOT_PARTS is not set
# end of Partition parsers

#
# User Modules And Translation Layers
#
CONFIG_MTD_OOPS=y
CONFIG_MTD_PARTITIONED_MASTER=y

#
# RAM/ROM/Flash chip drivers
#
CONFIG_MTD_CFI=y
CONFIG_MTD_JEDECPROBE=y
CONFIG_MTD_GEN_PROBE=y
# CONFIG_MTD_CFI_ADV_OPTIONS is not set
CONFIG_MTD_MAP_BANK_WIDTH_1=y
CONFIG_MTD_MAP_BANK_WIDTH_2=y
CONFIG_MTD_MAP_BANK_WIDTH_4=y
CONFIG_MTD_CFI_I1=y
CONFIG_MTD_CFI_I2=y
# CONFIG_MTD_CFI_INTELEXT is not set
CONFIG_MTD_CFI_AMDSTD=y
# CONFIG_MTD_CFI_STAA is not set
CONFIG_MTD_CFI_UTIL=y
CONFIG_MTD_RAM=y
CONFIG_MTD_ROM=y
CONFIG_MTD_ABSENT=y
# end of RAM/ROM/Flash chip drivers

#
# Mapping drivers for chip access
#
CONFIG_MTD_COMPLEX_MAPPINGS=y
# CONFIG_MTD_PHYSMAP is not set
# CONFIG_MTD_SC520CDP is not set
# CONFIG_MTD_NETSC520 is not set
# CONFIG_MTD_TS5500 is not set
CONFIG_MTD_SCx200_DOCFLASH=y
CONFIG_MTD_AMD76XROM=y
CONFIG_MTD_ICHXROM=y
# CONFIG_MTD_ESB2ROM is not set
# CONFIG_MTD_CK804XROM is not set
# CONFIG_MTD_SCB2_FLASH is not set
# CONFIG_MTD_NETtel is not set
CONFIG_MTD_L440GX=y
# CONFIG_MTD_PCI is not set
CONFIG_MTD_PCMCIA=y
# CONFIG_MTD_PCMCIA_ANONYMOUS is not set
# CONFIG_MTD_INTEL_VR_NOR is not set
CONFIG_MTD_PLATRAM=y
# end of Mapping drivers for chip access

#
# Self-contained MTD device drivers
#
# CONFIG_MTD_PMC551 is not set
# CONFIG_MTD_DATAFLASH is not set
CONFIG_MTD_MCHP23K256=y
CONFIG_MTD_SST25L=y
# CONFIG_MTD_SLRAM is not set
CONFIG_MTD_PHRAM=y
# CONFIG_MTD_MTDRAM is not set

#
# Disk-On-Chip Device Drivers
#
CONFIG_MTD_DOCG3=y
CONFIG_BCH_CONST_M=14
CONFIG_BCH_CONST_T=4
# end of Self-contained MTD device drivers

#
# NAND
#
CONFIG_MTD_NAND_CORE=y
CONFIG_MTD_ONENAND=y
CONFIG_MTD_ONENAND_VERIFY_WRITE=y
CONFIG_MTD_ONENAND_GENERIC=y
CONFIG_MTD_ONENAND_OTP=y
# CONFIG_MTD_ONENAND_2X_PROGRAM is not set
CONFIG_MTD_NAND_ECC_SW_HAMMING=y
# CONFIG_MTD_NAND_ECC_SW_HAMMING_SMC is not set
CONFIG_MTD_RAW_NAND=y
# CONFIG_MTD_NAND_ECC_SW_BCH is not set

#
# Raw/parallel NAND flash controllers
#
# CONFIG_MTD_NAND_DENALI_PCI is not set
# CONFIG_MTD_NAND_DENALI_DT is not set
# CONFIG_MTD_NAND_CAFE is not set
CONFIG_MTD_NAND_CS553X=y
CONFIG_MTD_NAND_MXIC=y
CONFIG_MTD_NAND_GPIO=y
CONFIG_MTD_NAND_PLATFORM=y
CONFIG_MTD_NAND_CADENCE=y
# CONFIG_MTD_NAND_ARASAN is not set

#
# Misc
#
CONFIG_MTD_NAND_NANDSIM=y
# CONFIG_MTD_NAND_RICOH is not set
# CONFIG_MTD_NAND_DISKONCHIP is not set
# CONFIG_MTD_SPI_NAND is not set
# end of NAND

#
# LPDDR & LPDDR2 PCM memory drivers
#
CONFIG_MTD_LPDDR=y
CONFIG_MTD_QINFO_PROBE=y
# end of LPDDR & LPDDR2 PCM memory drivers

CONFIG_MTD_SPI_NOR=y
# CONFIG_MTD_SPI_NOR_USE_4K_SECTORS is not set
CONFIG_SPI_INTEL_SPI=y
# CONFIG_SPI_INTEL_SPI_PCI is not set
CONFIG_SPI_INTEL_SPI_PLATFORM=y
# CONFIG_MTD_UBI is not set
CONFIG_MTD_HYPERBUS=y
CONFIG_DTC=y
CONFIG_OF=y
# CONFIG_OF_UNITTEST is not set
CONFIG_OF_FLATTREE=y
CONFIG_OF_EARLY_FLATTREE=y
CONFIG_OF_KOBJ=y
CONFIG_OF_ADDRESS=y
CONFIG_OF_IRQ=y
CONFIG_OF_NET=y
CONFIG_OF_MDIO=y
CONFIG_OF_RESERVED_MEM=y
# CONFIG_OF_OVERLAY is not set
CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
CONFIG_PARPORT=y
CONFIG_PARPORT_PC=y
# CONFIG_PARPORT_SERIAL is not set
# CONFIG_PARPORT_PC_FIFO is not set
CONFIG_PARPORT_PC_SUPERIO=y
CONFIG_PARPORT_PC_PCMCIA=y
CONFIG_PARPORT_AX88796=y
# CONFIG_PARPORT_1284 is not set
CONFIG_PARPORT_NOT_PC=y
CONFIG_PNP=y
# CONFIG_PNP_DEBUG_MESSAGES is not set

#
# Protocols
#
CONFIG_PNPACPI=y

#
# NVME Support
#
# end of NVME Support

#
# Misc devices
#
CONFIG_SENSORS_LIS3LV02D=y
CONFIG_AD525X_DPOT=y
CONFIG_AD525X_DPOT_I2C=y
# CONFIG_AD525X_DPOT_SPI is not set
CONFIG_DUMMY_IRQ=y
# CONFIG_IBM_ASM is not set
# CONFIG_PHANTOM is not set
# CONFIG_TIFM_CORE is not set
CONFIG_ICS932S401=y
# CONFIG_ENCLOSURE_SERVICES is not set
# CONFIG_HP_ILO is not set
# CONFIG_APDS9802ALS is not set
CONFIG_ISL29003=y
# CONFIG_ISL29020 is not set
CONFIG_SENSORS_TSL2550=y
CONFIG_SENSORS_BH1770=y
# CONFIG_SENSORS_APDS990X is not set
CONFIG_HMC6352=y
CONFIG_DS1682=y
# CONFIG_PCH_PHUB is not set
# CONFIG_LATTICE_ECP3_CONFIG is not set
CONFIG_SRAM=y
# CONFIG_PCI_ENDPOINT_TEST is not set
CONFIG_XILINX_SDFEC=y
# CONFIG_PVPANIC is not set
CONFIG_C2PORT=y
CONFIG_C2PORT_DURAMAR_2150=y

#
# EEPROM support
#
CONFIG_EEPROM_AT24=y
# CONFIG_EEPROM_AT25 is not set
# CONFIG_EEPROM_LEGACY is not set
CONFIG_EEPROM_MAX6875=y
CONFIG_EEPROM_93CX6=y
CONFIG_EEPROM_93XX46=y
CONFIG_EEPROM_IDT_89HPESX=y
# CONFIG_EEPROM_EE1004 is not set
# end of EEPROM support

# CONFIG_CB710_CORE is not set

#
# Texas Instruments shared transport line discipline
#
# CONFIG_TI_ST is not set
# end of Texas Instruments shared transport line discipline

CONFIG_SENSORS_LIS3_I2C=y
# CONFIG_ALTERA_STAPL is not set
# CONFIG_INTEL_MEI is not set
# CONFIG_INTEL_MEI_ME is not set
# CONFIG_INTEL_MEI_TXE is not set
# CONFIG_VMWARE_VMCI is not set

#
# Intel MIC & related support
#
# CONFIG_VOP_BUS is not set
# end of Intel MIC & related support

CONFIG_ECHO=y
# CONFIG_MISC_ALCOR_PCI is not set
# CONFIG_MISC_RTSX_PCI is not set
# CONFIG_MISC_RTSX_USB is not set
# CONFIG_HABANA_AI is not set
# end of Misc devices

CONFIG_HAVE_IDE=y

#
# SCSI device support
#
CONFIG_SCSI_MOD=y
# end of SCSI device support

# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support
#
CONFIG_FIREWIRE=y
# CONFIG_FIREWIRE_OHCI is not set
# CONFIG_FIREWIRE_NET is not set
# CONFIG_FIREWIRE_NOSY is not set
# end of IEEE 1394 (FireWire) support

CONFIG_MACINTOSH_DRIVERS=y
CONFIG_MAC_EMUMOUSEBTN=y
CONFIG_NETDEVICES=y
CONFIG_MII=y
CONFIG_NET_CORE=y
# CONFIG_BONDING is not set
CONFIG_DUMMY=y
# CONFIG_WIREGUARD is not set
CONFIG_EQUALIZER=y
CONFIG_NET_TEAM=y
CONFIG_NET_TEAM_MODE_BROADCAST=y
# CONFIG_NET_TEAM_MODE_ROUNDROBIN is not set
CONFIG_NET_TEAM_MODE_RANDOM=y
CONFIG_NET_TEAM_MODE_ACTIVEBACKUP=y
CONFIG_NET_TEAM_MODE_LOADBALANCE=y
CONFIG_MACVLAN=y
# CONFIG_MACVTAP is not set
# CONFIG_IPVLAN is not set
# CONFIG_VXLAN is not set
# CONFIG_GENEVE is not set
# CONFIG_BAREUDP is not set
# CONFIG_GTP is not set
CONFIG_MACSEC=y
CONFIG_NETCONSOLE=y
# CONFIG_NETCONSOLE_DYNAMIC is not set
CONFIG_NETPOLL=y
CONFIG_NET_POLL_CONTROLLER=y
# CONFIG_TUN is not set
# CONFIG_TUN_VNET_CROSS_LE is not set
CONFIG_VETH=y
# CONFIG_VIRTIO_NET is not set
# CONFIG_NLMON is not set
CONFIG_VSOCKMON=y
CONFIG_ARCNET=y
CONFIG_ARCNET_1201=y
CONFIG_ARCNET_1051=y
CONFIG_ARCNET_RAW=y
CONFIG_ARCNET_CAP=y
# CONFIG_ARCNET_COM90xx is not set
# CONFIG_ARCNET_COM90xxIO is not set
CONFIG_ARCNET_RIM_I=y
CONFIG_ARCNET_COM20020=y
# CONFIG_ARCNET_COM20020_PCI is not set
CONFIG_ARCNET_COM20020_CS=y
CONFIG_ATM_DRIVERS=y
CONFIG_ATM_DUMMY=y
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
# CONFIG_CAIF_DRIVERS is not set

#
# Distributed Switch Architecture drivers
#
# end of Distributed Switch Architecture drivers

CONFIG_ETHERNET=y
# CONFIG_NET_VENDOR_3COM is not set
CONFIG_NET_VENDOR_ADAPTEC=y
# CONFIG_ADAPTEC_STARFIRE is not set
CONFIG_NET_VENDOR_AGERE=y
# CONFIG_ET131X is not set
# CONFIG_NET_VENDOR_ALACRITECH is not set
CONFIG_NET_VENDOR_ALTEON=y
# CONFIG_ACENIC is not set
CONFIG_ALTERA_TSE=y
CONFIG_NET_VENDOR_AMAZON=y
CONFIG_NET_VENDOR_AMD=y
# CONFIG_AMD8111_ETH is not set
# CONFIG_PCNET32 is not set
CONFIG_PCMCIA_NMCLAN=y
CONFIG_AMD_XGBE=y
CONFIG_AMD_XGBE_DCB=y
CONFIG_AMD_XGBE_HAVE_ECC=y
CONFIG_NET_VENDOR_AQUANTIA=y
# CONFIG_NET_VENDOR_ARC is not set
CONFIG_NET_VENDOR_ATHEROS=y
# CONFIG_ATL2 is not set
# CONFIG_ATL1 is not set
# CONFIG_ATL1E is not set
# CONFIG_ATL1C is not set
# CONFIG_ALX is not set
# CONFIG_NET_VENDOR_AURORA is not set
# CONFIG_NET_VENDOR_BROADCOM is not set
CONFIG_NET_VENDOR_BROCADE=y
# CONFIG_BNA is not set
# CONFIG_NET_VENDOR_CADENCE is not set
# CONFIG_NET_VENDOR_CAVIUM is not set
CONFIG_NET_VENDOR_CHELSIO=y
# CONFIG_CHELSIO_T1 is not set
# CONFIG_CHELSIO_T3 is not set
# CONFIG_CHELSIO_T4 is not set
# CONFIG_CHELSIO_T4VF is not set
CONFIG_NET_VENDOR_CISCO=y
# CONFIG_ENIC is not set
CONFIG_NET_VENDOR_CORTINA=y
# CONFIG_GEMINI_ETHERNET is not set
# CONFIG_CX_ECAT is not set
CONFIG_DNET=y
CONFIG_NET_VENDOR_DEC=y
# CONFIG_NET_TULIP is not set
CONFIG_NET_VENDOR_DLINK=y
# CONFIG_DL2K is not set
# CONFIG_SUNDANCE is not set
CONFIG_NET_VENDOR_EMULEX=y
# CONFIG_BE2NET is not set
CONFIG_NET_VENDOR_EZCHIP=y
CONFIG_EZCHIP_NPS_MANAGEMENT_ENET=y
# CONFIG_NET_VENDOR_FUJITSU is not set
# CONFIG_NET_VENDOR_GOOGLE is not set
CONFIG_NET_VENDOR_HUAWEI=y
# CONFIG_NET_VENDOR_I825XX is not set
CONFIG_NET_VENDOR_INTEL=y
# CONFIG_E100 is not set
CONFIG_E1000=y
# CONFIG_E1000E is not set
# CONFIG_IGB is not set
# CONFIG_IGBVF is not set
# CONFIG_IXGB is not set
# CONFIG_IXGBE is not set
# CONFIG_I40E is not set
# CONFIG_IGC is not set
# CONFIG_JME is not set
# CONFIG_NET_VENDOR_MARVELL is not set
# CONFIG_NET_VENDOR_MELLANOX is not set
CONFIG_NET_VENDOR_MICREL=y
CONFIG_KS8842=y
CONFIG_KS8851=y
CONFIG_KS8851_MLL=y
# CONFIG_KSZ884X_PCI is not set
# CONFIG_NET_VENDOR_MICROCHIP is not set
CONFIG_NET_VENDOR_MICROSEMI=y
CONFIG_NET_VENDOR_MYRI=y
# CONFIG_MYRI10GE is not set
# CONFIG_FEALNX is not set
# CONFIG_NET_VENDOR_NATSEMI is not set
CONFIG_NET_VENDOR_NETERION=y
# CONFIG_S2IO is not set
# CONFIG_VXGE is not set
CONFIG_NET_VENDOR_NETRONOME=y
CONFIG_NET_VENDOR_NI=y
CONFIG_NI_XGE_MANAGEMENT_ENET=y
CONFIG_NET_VENDOR_NVIDIA=y
# CONFIG_FORCEDETH is not set
CONFIG_NET_VENDOR_OKI=y
# CONFIG_PCH_GBE is not set
CONFIG_ETHOC=y
CONFIG_NET_VENDOR_PACKET_ENGINES=y
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
# CONFIG_NET_VENDOR_PENSANDO is not set
CONFIG_NET_VENDOR_QLOGIC=y
# CONFIG_QLA3XXX is not set
# CONFIG_QLCNIC is not set
# CONFIG_NETXEN_NIC is not set
# CONFIG_QED is not set
CONFIG_NET_VENDOR_QUALCOMM=y
CONFIG_QCA7000=y
CONFIG_QCA7000_SPI=y
CONFIG_QCA7000_UART=y
CONFIG_QCOM_EMAC=y
CONFIG_RMNET=y
CONFIG_NET_VENDOR_RDC=y
# CONFIG_R6040 is not set
# CONFIG_NET_VENDOR_REALTEK is not set
CONFIG_NET_VENDOR_RENESAS=y
CONFIG_NET_VENDOR_ROCKER=y
CONFIG_NET_VENDOR_SAMSUNG=y
CONFIG_SXGBE_ETH=y
CONFIG_NET_VENDOR_SEEQ=y
# CONFIG_NET_VENDOR_SOLARFLARE is not set
CONFIG_NET_VENDOR_SILAN=y
# CONFIG_SC92031 is not set
CONFIG_NET_VENDOR_SIS=y
# CONFIG_SIS900 is not set
# CONFIG_SIS190 is not set
CONFIG_NET_VENDOR_SMSC=y
CONFIG_PCMCIA_SMC91C92=y
# CONFIG_EPIC100 is not set
CONFIG_SMSC911X=y
# CONFIG_SMSC9420 is not set
CONFIG_NET_VENDOR_SOCIONEXT=y
# CONFIG_NET_VENDOR_STMICRO is not set
CONFIG_NET_VENDOR_SUN=y
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNGEM is not set
# CONFIG_CASSINI is not set
# CONFIG_NIU is not set
# CONFIG_NET_VENDOR_SYNOPSYS is not set
CONFIG_NET_VENDOR_TEHUTI=y
# CONFIG_TEHUTI is not set
CONFIG_NET_VENDOR_TI=y
# CONFIG_TI_CPSW_PHY_SEL is not set
# CONFIG_TLAN is not set
# CONFIG_NET_VENDOR_VIA is not set
# CONFIG_NET_VENDOR_WIZNET is not set
CONFIG_NET_VENDOR_XILINX=y
# CONFIG_XILINX_AXI_EMAC is not set
# CONFIG_XILINX_LL_TEMAC is not set
# CONFIG_NET_VENDOR_XIRCOM is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
CONFIG_NET_SB1000=y
CONFIG_MDIO_DEVICE=y
CONFIG_MDIO_BUS=y
CONFIG_MDIO_DEVRES=y
CONFIG_MDIO_BCM_UNIMAC=y
CONFIG_MDIO_BITBANG=y
CONFIG_MDIO_BUS_MUX=y
# CONFIG_MDIO_BUS_MUX_GPIO is not set
CONFIG_MDIO_BUS_MUX_MMIOREG=y
CONFIG_MDIO_BUS_MUX_MULTIPLEXER=y
# CONFIG_MDIO_GPIO is not set
CONFIG_MDIO_HISI_FEMAC=y
CONFIG_MDIO_IPQ4019=y
CONFIG_MDIO_IPQ8064=y
# CONFIG_MDIO_MSCC_MIIM is not set
# CONFIG_MDIO_MVUSB is not set
CONFIG_MDIO_XPCS=y
CONFIG_PHYLIB=y
CONFIG_SWPHY=y
# CONFIG_LED_TRIGGER_PHY is not set

#
# MII PHY device drivers
#
# CONFIG_ADIN_PHY is not set
CONFIG_AMD_PHY=y
CONFIG_AQUANTIA_PHY=y
CONFIG_AX88796B_PHY=y
CONFIG_BCM7XXX_PHY=y
CONFIG_BCM87XX_PHY=y
CONFIG_BCM_NET_PHYLIB=y
CONFIG_BROADCOM_PHY=y
# CONFIG_BCM54140_PHY is not set
CONFIG_BCM84881_PHY=y
CONFIG_CICADA_PHY=y
# CONFIG_CORTINA_PHY is not set
CONFIG_DAVICOM_PHY=y
CONFIG_DP83822_PHY=y
CONFIG_DP83TC811_PHY=y
# CONFIG_DP83848_PHY is not set
CONFIG_DP83867_PHY=y
CONFIG_DP83869_PHY=y
CONFIG_FIXED_PHY=y
CONFIG_ICPLUS_PHY=y
CONFIG_INTEL_XWAY_PHY=y
CONFIG_LSI_ET1011C_PHY=y
CONFIG_LXT_PHY=y
# CONFIG_MARVELL_PHY is not set
CONFIG_MARVELL_10G_PHY=y
CONFIG_MICREL_PHY=y
CONFIG_MICROCHIP_PHY=y
CONFIG_MICROCHIP_T1_PHY=y
# CONFIG_MICROSEMI_PHY is not set
# CONFIG_NATIONAL_PHY is not set
# CONFIG_NXP_TJA11XX_PHY is not set
CONFIG_AT803X_PHY=y
# CONFIG_QSEMI_PHY is not set
CONFIG_REALTEK_PHY=y
CONFIG_RENESAS_PHY=y
CONFIG_ROCKCHIP_PHY=y
CONFIG_SMSC_PHY=y
CONFIG_STE10XP=y
CONFIG_TERANETICS_PHY=y
CONFIG_VITESSE_PHY=y
# CONFIG_XILINX_GMII2RGMII is not set
CONFIG_MICREL_KS8995MA=y
# CONFIG_PLIP is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set
# CONFIG_USB_NET_DRIVERS is not set
# CONFIG_WLAN is not set

#
# WiMAX Wireless Broadband devices
#
CONFIG_WIMAX_I2400M=y
CONFIG_WIMAX_I2400M_USB=y
CONFIG_WIMAX_I2400M_DEBUG_LEVEL=8
# end of WiMAX Wireless Broadband devices

CONFIG_WAN=y
# CONFIG_LANMEDIA is not set
CONFIG_HDLC=y
CONFIG_HDLC_RAW=y
# CONFIG_HDLC_RAW_ETH is not set
# CONFIG_HDLC_CISCO is not set
CONFIG_HDLC_FR=y
CONFIG_HDLC_PPP=y

#
# X.25/LAPB support is disabled
#
# CONFIG_PCI200SYN is not set
# CONFIG_WANXL is not set
# CONFIG_PC300TOO is not set
# CONFIG_FARSYNC is not set
CONFIG_DLCI=y
CONFIG_DLCI_MAX=8
# CONFIG_SBNI is not set
# CONFIG_VMXNET3 is not set
# CONFIG_FUJITSU_ES is not set
# CONFIG_HYPERV_NET is not set
# CONFIG_NETDEVSIM is not set
CONFIG_NET_FAILOVER=y
# CONFIG_ISDN is not set

#
# Input device support
#
CONFIG_INPUT=y
CONFIG_INPUT_LEDS=y
CONFIG_INPUT_FF_MEMLESS=y
# CONFIG_INPUT_POLLDEV is not set
# CONFIG_INPUT_SPARSEKMAP is not set
CONFIG_INPUT_MATRIXKMAP=y

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
# CONFIG_INPUT_MOUSEDEV_PSAUX is not set
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_INPUT_JOYDEV=y
# CONFIG_INPUT_EVDEV is not set
# CONFIG_INPUT_EVBUG is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ADC=y
# CONFIG_KEYBOARD_ADP5588 is not set
# CONFIG_KEYBOARD_ADP5589 is not set
CONFIG_KEYBOARD_APPLESPI=y
CONFIG_KEYBOARD_ATKBD=y
CONFIG_KEYBOARD_QT1050=y
# CONFIG_KEYBOARD_QT1070 is not set
CONFIG_KEYBOARD_QT2160=y
CONFIG_KEYBOARD_DLINK_DIR685=y
CONFIG_KEYBOARD_LKKBD=y
CONFIG_KEYBOARD_GPIO=y
CONFIG_KEYBOARD_GPIO_POLLED=y
CONFIG_KEYBOARD_TCA6416=y
CONFIG_KEYBOARD_TCA8418=y
CONFIG_KEYBOARD_MATRIX=y
CONFIG_KEYBOARD_LM8323=y
CONFIG_KEYBOARD_LM8333=y
CONFIG_KEYBOARD_MAX7359=y
# CONFIG_KEYBOARD_MCS is not set
# CONFIG_KEYBOARD_MPR121 is not set
CONFIG_KEYBOARD_NEWTON=y
CONFIG_KEYBOARD_OPENCORES=y
# CONFIG_KEYBOARD_SAMSUNG is not set
CONFIG_KEYBOARD_GOLDFISH_EVENTS=y
# CONFIG_KEYBOARD_STOWAWAY is not set
CONFIG_KEYBOARD_SUNKBD=y
CONFIG_KEYBOARD_STMPE=y
CONFIG_KEYBOARD_IQS62X=y
CONFIG_KEYBOARD_OMAP4=y
# CONFIG_KEYBOARD_TC3589X is not set
CONFIG_KEYBOARD_TM2_TOUCHKEY=y
CONFIG_KEYBOARD_XTKBD=y
CONFIG_KEYBOARD_CROS_EC=y
CONFIG_KEYBOARD_CAP11XX=y
# CONFIG_KEYBOARD_BCM is not set
# CONFIG_KEYBOARD_MTK_PMIC is not set
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
# CONFIG_MOUSE_PS2_ALPS is not set
# CONFIG_MOUSE_PS2_BYD is not set
# CONFIG_MOUSE_PS2_LOGIPS2PP is not set
CONFIG_MOUSE_PS2_SYNAPTICS=y
CONFIG_MOUSE_PS2_SYNAPTICS_SMBUS=y
CONFIG_MOUSE_PS2_CYPRESS=y
CONFIG_MOUSE_PS2_LIFEBOOK=y
# CONFIG_MOUSE_PS2_TRACKPOINT is not set
# CONFIG_MOUSE_PS2_ELANTECH is not set
# CONFIG_MOUSE_PS2_SENTELIC is not set
# CONFIG_MOUSE_PS2_TOUCHKIT is not set
CONFIG_MOUSE_PS2_FOCALTECH=y
# CONFIG_MOUSE_PS2_VMMOUSE is not set
CONFIG_MOUSE_PS2_SMBUS=y
# CONFIG_MOUSE_SERIAL is not set
CONFIG_MOUSE_APPLETOUCH=y
CONFIG_MOUSE_BCM5974=y
CONFIG_MOUSE_CYAPA=y
CONFIG_MOUSE_ELAN_I2C=y
CONFIG_MOUSE_ELAN_I2C_I2C=y
# CONFIG_MOUSE_ELAN_I2C_SMBUS is not set
# CONFIG_MOUSE_VSXXXAA is not set
# CONFIG_MOUSE_GPIO is not set
CONFIG_MOUSE_SYNAPTICS_I2C=y
# CONFIG_MOUSE_SYNAPTICS_USB is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TABLET is not set
CONFIG_INPUT_TOUCHSCREEN=y
CONFIG_TOUCHSCREEN_PROPERTIES=y
CONFIG_TOUCHSCREEN_ADS7846=y
CONFIG_TOUCHSCREEN_AD7877=y
# CONFIG_TOUCHSCREEN_AD7879 is not set
CONFIG_TOUCHSCREEN_ADC=y
CONFIG_TOUCHSCREEN_AR1021_I2C=y
CONFIG_TOUCHSCREEN_ATMEL_MXT=y
# CONFIG_TOUCHSCREEN_ATMEL_MXT_T37 is not set
# CONFIG_TOUCHSCREEN_AUO_PIXCIR is not set
CONFIG_TOUCHSCREEN_BU21013=y
CONFIG_TOUCHSCREEN_BU21029=y
CONFIG_TOUCHSCREEN_CHIPONE_ICN8318=y
# CONFIG_TOUCHSCREEN_CHIPONE_ICN8505 is not set
CONFIG_TOUCHSCREEN_CY8CTMA140=y
# CONFIG_TOUCHSCREEN_CY8CTMG110 is not set
CONFIG_TOUCHSCREEN_CYTTSP_CORE=y
CONFIG_TOUCHSCREEN_CYTTSP_I2C=y
# CONFIG_TOUCHSCREEN_CYTTSP_SPI is not set
CONFIG_TOUCHSCREEN_CYTTSP4_CORE=y
# CONFIG_TOUCHSCREEN_CYTTSP4_I2C is not set
# CONFIG_TOUCHSCREEN_CYTTSP4_SPI is not set
CONFIG_TOUCHSCREEN_DA9052=y
CONFIG_TOUCHSCREEN_DYNAPRO=y
CONFIG_TOUCHSCREEN_HAMPSHIRE=y
CONFIG_TOUCHSCREEN_EETI=y
# CONFIG_TOUCHSCREEN_EGALAX is not set
CONFIG_TOUCHSCREEN_EGALAX_SERIAL=y
# CONFIG_TOUCHSCREEN_EXC3000 is not set
CONFIG_TOUCHSCREEN_FUJITSU=y
# CONFIG_TOUCHSCREEN_GOODIX is not set
CONFIG_TOUCHSCREEN_HIDEEP=y
CONFIG_TOUCHSCREEN_ILI210X=y
CONFIG_TOUCHSCREEN_S6SY761=y
CONFIG_TOUCHSCREEN_GUNZE=y
CONFIG_TOUCHSCREEN_EKTF2127=y
# CONFIG_TOUCHSCREEN_ELAN is not set
CONFIG_TOUCHSCREEN_ELO=y
# CONFIG_TOUCHSCREEN_WACOM_W8001 is not set
CONFIG_TOUCHSCREEN_WACOM_I2C=y
# CONFIG_TOUCHSCREEN_MAX11801 is not set
CONFIG_TOUCHSCREEN_MCS5000=y
CONFIG_TOUCHSCREEN_MMS114=y
CONFIG_TOUCHSCREEN_MELFAS_MIP4=y
CONFIG_TOUCHSCREEN_MTOUCH=y
# CONFIG_TOUCHSCREEN_IMX6UL_TSC is not set
CONFIG_TOUCHSCREEN_INEXIO=y
# CONFIG_TOUCHSCREEN_MK712 is not set
CONFIG_TOUCHSCREEN_PENMOUNT=y
CONFIG_TOUCHSCREEN_EDT_FT5X06=y
# CONFIG_TOUCHSCREEN_TOUCHRIGHT is not set
# CONFIG_TOUCHSCREEN_TOUCHWIN is not set
# CONFIG_TOUCHSCREEN_PIXCIR is not set
CONFIG_TOUCHSCREEN_WDT87XX_I2C=y
# CONFIG_TOUCHSCREEN_USB_COMPOSITE is not set
# CONFIG_TOUCHSCREEN_MC13783 is not set
CONFIG_TOUCHSCREEN_TOUCHIT213=y
CONFIG_TOUCHSCREEN_TSC_SERIO=y
CONFIG_TOUCHSCREEN_TSC200X_CORE=y
CONFIG_TOUCHSCREEN_TSC2004=y
CONFIG_TOUCHSCREEN_TSC2005=y
# CONFIG_TOUCHSCREEN_TSC2007 is not set
CONFIG_TOUCHSCREEN_PCAP=y
CONFIG_TOUCHSCREEN_RM_TS=y
# CONFIG_TOUCHSCREEN_SILEAD is not set
CONFIG_TOUCHSCREEN_SIS_I2C=y
CONFIG_TOUCHSCREEN_ST1232=y
# CONFIG_TOUCHSCREEN_STMFTS is not set
CONFIG_TOUCHSCREEN_STMPE=y
CONFIG_TOUCHSCREEN_SUR40=y
# CONFIG_TOUCHSCREEN_SURFACE3_SPI is not set
CONFIG_TOUCHSCREEN_SX8654=y
CONFIG_TOUCHSCREEN_TPS6507X=y
# CONFIG_TOUCHSCREEN_ZET6223 is not set
# CONFIG_TOUCHSCREEN_ZFORCE is not set
CONFIG_TOUCHSCREEN_COLIBRI_VF50=y
# CONFIG_TOUCHSCREEN_ROHM_BU21023 is not set
CONFIG_TOUCHSCREEN_IQS5XX=y
# CONFIG_INPUT_MISC is not set
CONFIG_RMI4_CORE=y
CONFIG_RMI4_I2C=y
# CONFIG_RMI4_SPI is not set
# CONFIG_RMI4_SMB is not set
CONFIG_RMI4_F03=y
CONFIG_RMI4_F03_SERIO=y
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
CONFIG_SERIO_PARKBD=y
# CONFIG_SERIO_PCIPS2 is not set
CONFIG_SERIO_LIBPS2=y
CONFIG_SERIO_RAW=y
CONFIG_SERIO_ALTERA_PS2=y
# CONFIG_SERIO_PS2MULT is not set
# CONFIG_SERIO_ARC_PS2 is not set
CONFIG_SERIO_APBPS2=y
# CONFIG_HYPERV_KEYBOARD is not set
# CONFIG_SERIO_GPIO_PS2 is not set
CONFIG_USERIO=y
CONFIG_GAMEPORT=y
CONFIG_GAMEPORT_NS558=y
CONFIG_GAMEPORT_L4=y
# CONFIG_GAMEPORT_EMU10K1 is not set
# CONFIG_GAMEPORT_FM801 is not set
# end of Hardware I/O ports
# end of Input device support

#
# Character devices
#
CONFIG_TTY=y
# CONFIG_VT is not set
CONFIG_UNIX98_PTYS=y
CONFIG_LEGACY_PTYS=y
CONFIG_LEGACY_PTY_COUNT=256
CONFIG_LDISC_AUTOLOAD=y

#
# Serial drivers
#
CONFIG_SERIAL_EARLYCON=y
CONFIG_SERIAL_8250=y
CONFIG_SERIAL_8250_DEPRECATED_OPTIONS=y
CONFIG_SERIAL_8250_PNP=y
# CONFIG_SERIAL_8250_16550A_VARIANTS is not set
# CONFIG_SERIAL_8250_FINTEK is not set
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_DMA=y
CONFIG_SERIAL_8250_PCI=y
CONFIG_SERIAL_8250_EXAR=y
# CONFIG_SERIAL_8250_CS is not set
# CONFIG_SERIAL_8250_MEN_MCB is not set
CONFIG_SERIAL_8250_NR_UARTS=4
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
# CONFIG_SERIAL_8250_EXTENDED is not set
# CONFIG_SERIAL_8250_ASPEED_VUART is not set
CONFIG_SERIAL_8250_DWLIB=y
# CONFIG_SERIAL_8250_DW is not set
# CONFIG_SERIAL_8250_RT288X is not set
CONFIG_SERIAL_8250_LPSS=y
CONFIG_SERIAL_8250_MID=y
# CONFIG_SERIAL_OF_PLATFORM is not set

#
# Non-8250 serial port support
#
# CONFIG_SERIAL_MAX3100 is not set
# CONFIG_SERIAL_MAX310X is not set
# CONFIG_SERIAL_UARTLITE is not set
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
# CONFIG_SERIAL_JSM is not set
# CONFIG_SERIAL_SIFIVE is not set
# CONFIG_SERIAL_LANTIQ is not set
# CONFIG_SERIAL_SCCNXP is not set
# CONFIG_SERIAL_SC16IS7XX is not set
# CONFIG_SERIAL_TIMBERDALE is not set
# CONFIG_SERIAL_ALTERA_JTAGUART is not set
# CONFIG_SERIAL_ALTERA_UART is not set
# CONFIG_SERIAL_IFX6X60 is not set
# CONFIG_SERIAL_PCH_UART is not set
# CONFIG_SERIAL_XILINX_PS_UART is not set
# CONFIG_SERIAL_ARC is not set
# CONFIG_SERIAL_RP2 is not set
# CONFIG_SERIAL_FSL_LPUART is not set
# CONFIG_SERIAL_FSL_LINFLEXUART is not set
# CONFIG_SERIAL_CONEXANT_DIGICOLOR is not set
# CONFIG_SERIAL_MEN_Z135 is not set
# CONFIG_SERIAL_SPRD is not set
# end of Serial drivers

CONFIG_SERIAL_MCTRL_GPIO=y
# CONFIG_SERIAL_NONSTANDARD is not set
# CONFIG_GOLDFISH_TTY is not set
# CONFIG_N_GSM is not set
# CONFIG_NOZOMI is not set
# CONFIG_NULL_TTY is not set
# CONFIG_TRACE_SINK is not set
CONFIG_SERIAL_DEV_BUS=y
CONFIG_SERIAL_DEV_CTRL_TTYPORT=y
# CONFIG_TTY_PRINTK is not set
CONFIG_PRINTER=y
# CONFIG_LP_CONSOLE is not set
CONFIG_PPDEV=y
# CONFIG_VIRTIO_CONSOLE is not set
# CONFIG_IPMI_HANDLER is not set
CONFIG_IPMB_DEVICE_INTERFACE=y
CONFIG_HW_RANDOM=y
CONFIG_HW_RANDOM_TIMERIOMEM=y
CONFIG_HW_RANDOM_INTEL=y
CONFIG_HW_RANDOM_AMD=y
# CONFIG_HW_RANDOM_BA431 is not set
CONFIG_HW_RANDOM_GEODE=y
CONFIG_HW_RANDOM_VIA=y
# CONFIG_HW_RANDOM_VIRTIO is not set
# CONFIG_HW_RANDOM_CCTRNG is not set
# CONFIG_APPLICOM is not set
# CONFIG_SONYPI is not set

#
# PCMCIA character devices
#
# CONFIG_SYNCLINK_CS is not set
# CONFIG_CARDMAN_4000 is not set
# CONFIG_CARDMAN_4040 is not set
CONFIG_SCR24X=y
# CONFIG_IPWIRELESS is not set
# end of PCMCIA character devices

# CONFIG_MWAVE is not set
CONFIG_SCx200_GPIO=y
CONFIG_PC8736x_GPIO=y
CONFIG_NSC_GPIO=y
CONFIG_DEVMEM=y
# CONFIG_DEVKMEM is not set
CONFIG_NVRAM=y
CONFIG_DEVPORT=y
CONFIG_HPET=y
# CONFIG_HPET_MMAP is not set
CONFIG_HANGCHECK_TIMER=y
CONFIG_TCG_TPM=y
CONFIG_HW_RANDOM_TPM=y
CONFIG_TCG_TIS_CORE=y
# CONFIG_TCG_TIS is not set
CONFIG_TCG_TIS_SPI=y
# CONFIG_TCG_TIS_SPI_CR50 is not set
CONFIG_TCG_TIS_I2C_ATMEL=y
CONFIG_TCG_TIS_I2C_INFINEON=y
CONFIG_TCG_TIS_I2C_NUVOTON=y
CONFIG_TCG_NSC=y
CONFIG_TCG_ATMEL=y
# CONFIG_TCG_INFINEON is not set
CONFIG_TCG_CRB=y
CONFIG_TCG_VTPM_PROXY=y
CONFIG_TCG_TIS_ST33ZP24=y
CONFIG_TCG_TIS_ST33ZP24_I2C=y
CONFIG_TCG_TIS_ST33ZP24_SPI=y
CONFIG_TELCLOCK=y
# CONFIG_XILLYBUS is not set
# end of Character devices

CONFIG_RANDOM_TRUST_CPU=y
# CONFIG_RANDOM_TRUST_BOOTLOADER is not set

#
# I2C support
#
CONFIG_I2C=y
# CONFIG_ACPI_I2C_OPREGION is not set
CONFIG_I2C_BOARDINFO=y
# CONFIG_I2C_COMPAT is not set
CONFIG_I2C_CHARDEV=y
CONFIG_I2C_MUX=y

#
# Multiplexer I2C Chip support
#
CONFIG_I2C_ARB_GPIO_CHALLENGE=y
# CONFIG_I2C_MUX_GPIO is not set
# CONFIG_I2C_MUX_GPMUX is not set
CONFIG_I2C_MUX_LTC4306=y
# CONFIG_I2C_MUX_PCA9541 is not set
# CONFIG_I2C_MUX_PCA954x is not set
CONFIG_I2C_MUX_PINCTRL=y
CONFIG_I2C_MUX_REG=y
# CONFIG_I2C_DEMUX_PINCTRL is not set
CONFIG_I2C_MUX_MLXCPLD=y
# end of Multiplexer I2C Chip support

CONFIG_I2C_HELPER_AUTO=y
CONFIG_I2C_SMBUS=y
CONFIG_I2C_ALGOBIT=y
CONFIG_I2C_ALGOPCA=y

#
# I2C Hardware Bus support
#

#
# PC SMBus host controller drivers
#
# CONFIG_I2C_ALI1535 is not set
# CONFIG_I2C_ALI1563 is not set
# CONFIG_I2C_ALI15X3 is not set
# CONFIG_I2C_AMD756 is not set
# CONFIG_I2C_AMD8111 is not set
# CONFIG_I2C_AMD_MP2 is not set
# CONFIG_I2C_I801 is not set
# CONFIG_I2C_ISCH is not set
# CONFIG_I2C_ISMT is not set
# CONFIG_I2C_PIIX4 is not set
# CONFIG_I2C_CHT_WC is not set
# CONFIG_I2C_NFORCE2 is not set
# CONFIG_I2C_NVIDIA_GPU is not set
# CONFIG_I2C_SIS5595 is not set
# CONFIG_I2C_SIS630 is not set
# CONFIG_I2C_SIS96X is not set
# CONFIG_I2C_VIA is not set
# CONFIG_I2C_VIAPRO is not set

#
# ACPI drivers
#
CONFIG_I2C_SCMI=y

#
# I2C system bus drivers (mostly embedded / system-on-chip)
#
CONFIG_I2C_CBUS_GPIO=y
CONFIG_I2C_DESIGNWARE_CORE=y
# CONFIG_I2C_DESIGNWARE_SLAVE is not set
CONFIG_I2C_DESIGNWARE_PLATFORM=y
# CONFIG_I2C_DESIGNWARE_PCI is not set
# CONFIG_I2C_EG20T is not set
CONFIG_I2C_EMEV2=y
# CONFIG_I2C_GPIO is not set
# CONFIG_I2C_KEMPLD is not set
CONFIG_I2C_OCORES=y
CONFIG_I2C_PCA_PLATFORM=y
# CONFIG_I2C_PXA is not set
# CONFIG_I2C_RK3X is not set
CONFIG_I2C_SIMTEC=y
# CONFIG_I2C_XILINX is not set

#
# External I2C/SMBus adapter drivers
#
# CONFIG_I2C_DIOLAN_U2C is not set
CONFIG_I2C_PARPORT=y
CONFIG_I2C_ROBOTFUZZ_OSIF=y
# CONFIG_I2C_TAOS_EVM is not set
CONFIG_I2C_TINY_USB=y

#
# Other I2C/SMBus bus drivers
#
CONFIG_I2C_CROS_EC_TUNNEL=y
# CONFIG_SCx200_ACB is not set
# end of I2C Hardware Bus support

# CONFIG_I2C_STUB is not set
CONFIG_I2C_SLAVE=y
CONFIG_I2C_SLAVE_EEPROM=y
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# end of I2C support

CONFIG_I3C=y
# CONFIG_CDNS_I3C_MASTER is not set
# CONFIG_DW_I3C_MASTER is not set
CONFIG_SPI=y
# CONFIG_SPI_DEBUG is not set
CONFIG_SPI_MASTER=y
CONFIG_SPI_MEM=y

#
# SPI Master Controller Drivers
#
CONFIG_SPI_ALTERA=y
CONFIG_SPI_AXI_SPI_ENGINE=y
CONFIG_SPI_BITBANG=y
# CONFIG_SPI_BUTTERFLY is not set
# CONFIG_SPI_CADENCE is not set
CONFIG_SPI_DESIGNWARE=y
# CONFIG_SPI_DW_DMA is not set
# CONFIG_SPI_DW_PCI is not set
# CONFIG_SPI_DW_MMIO is not set
CONFIG_SPI_NXP_FLEXSPI=y
# CONFIG_SPI_GPIO is not set
# CONFIG_SPI_LM70_LLP is not set
CONFIG_SPI_FSL_LIB=y
CONFIG_SPI_FSL_SPI=y
# CONFIG_SPI_LANTIQ_SSC is not set
CONFIG_SPI_OC_TINY=y
CONFIG_SPI_PXA2XX=y
CONFIG_SPI_PXA2XX_PCI=y
CONFIG_SPI_ROCKCHIP=y
CONFIG_SPI_SC18IS602=y
CONFIG_SPI_SIFIVE=y
# CONFIG_SPI_MXIC is not set
# CONFIG_SPI_TOPCLIFF_PCH is not set
CONFIG_SPI_XCOMM=y
# CONFIG_SPI_XILINX is not set
CONFIG_SPI_ZYNQMP_GQSPI=y
# CONFIG_SPI_AMD is not set

#
# SPI Multiplexer support
#
CONFIG_SPI_MUX=y

#
# SPI Protocol Masters
#
CONFIG_SPI_SPIDEV=y
# CONFIG_SPI_LOOPBACK_TEST is not set
CONFIG_SPI_TLE62X0=y
CONFIG_SPI_SLAVE=y
CONFIG_SPI_SLAVE_TIME=y
CONFIG_SPI_SLAVE_SYSTEM_CONTROL=y
CONFIG_SPI_DYNAMIC=y
# CONFIG_SPMI is not set
CONFIG_HSI=y
CONFIG_HSI_BOARDINFO=y

#
# HSI controllers
#

#
# HSI clients
#
# CONFIG_HSI_CHAR is not set
CONFIG_PPS=y
# CONFIG_PPS_DEBUG is not set
# CONFIG_NTP_PPS is not set

#
# PPS clients support
#
CONFIG_PPS_CLIENT_KTIMER=y
# CONFIG_PPS_CLIENT_LDISC is not set
CONFIG_PPS_CLIENT_PARPORT=y
CONFIG_PPS_CLIENT_GPIO=y

#
# PPS generators support
#

#
# PTP clock support
#
# CONFIG_PTP_1588_CLOCK is not set

#
# Enable PHYLIB and NETWORK_PHY_TIMESTAMPING to see the additional clocks.
#
CONFIG_PTP_1588_CLOCK_PCH=y
# end of PTP clock support

CONFIG_PINCTRL=y
CONFIG_GENERIC_PINCTRL_GROUPS=y
CONFIG_PINMUX=y
CONFIG_GENERIC_PINMUX_FUNCTIONS=y
CONFIG_PINCONF=y
CONFIG_GENERIC_PINCONF=y
# CONFIG_DEBUG_PINCTRL is not set
CONFIG_PINCTRL_AS3722=y
# CONFIG_PINCTRL_AXP209 is not set
CONFIG_PINCTRL_AMD=y
CONFIG_PINCTRL_DA9062=y
# CONFIG_PINCTRL_MCP23S08 is not set
CONFIG_PINCTRL_SINGLE=y
# CONFIG_PINCTRL_SX150X is not set
CONFIG_PINCTRL_STMFX=y
CONFIG_PINCTRL_MAX77620=y
# CONFIG_PINCTRL_RK805 is not set
CONFIG_PINCTRL_OCELOT=y
# CONFIG_PINCTRL_BAYTRAIL is not set
CONFIG_PINCTRL_CHERRYVIEW=y
# CONFIG_PINCTRL_LYNXPOINT is not set
CONFIG_PINCTRL_INTEL=y
# CONFIG_PINCTRL_BROXTON is not set
CONFIG_PINCTRL_CANNONLAKE=y
CONFIG_PINCTRL_CEDARFORK=y
CONFIG_PINCTRL_DENVERTON=y
# CONFIG_PINCTRL_EMMITSBURG is not set
CONFIG_PINCTRL_GEMINILAKE=y
# CONFIG_PINCTRL_ICELAKE is not set
CONFIG_PINCTRL_JASPERLAKE=y
CONFIG_PINCTRL_LEWISBURG=y
CONFIG_PINCTRL_SUNRISEPOINT=y
CONFIG_PINCTRL_TIGERLAKE=y
# CONFIG_PINCTRL_LOCHNAGAR is not set
CONFIG_PINCTRL_EQUILIBRIUM=y
CONFIG_GPIOLIB=y
CONFIG_GPIOLIB_FASTPATH_LIMIT=512
CONFIG_OF_GPIO=y
CONFIG_GPIO_ACPI=y
CONFIG_GPIOLIB_IRQCHIP=y
# CONFIG_DEBUG_GPIO is not set
CONFIG_GPIO_SYSFS=y
CONFIG_GPIO_GENERIC=y
CONFIG_GPIO_MAX730X=y

#
# Memory mapped GPIO drivers
#
CONFIG_GPIO_74XX_MMIO=y
# CONFIG_GPIO_ALTERA is not set
# CONFIG_GPIO_AMDPT is not set
# CONFIG_GPIO_CADENCE is not set
CONFIG_GPIO_DWAPB=y
# CONFIG_GPIO_EXAR is not set
CONFIG_GPIO_FTGPIO010=y
# CONFIG_GPIO_GENERIC_PLATFORM is not set
CONFIG_GPIO_GRGPIO=y
# CONFIG_GPIO_HLWD is not set
# CONFIG_GPIO_ICH is not set
# CONFIG_GPIO_LOGICVC is not set
CONFIG_GPIO_MB86S7X=y
CONFIG_GPIO_MENZ127=y
# CONFIG_GPIO_SAMA5D2_PIOBU is not set
CONFIG_GPIO_SIFIVE=y
CONFIG_GPIO_SIOX=y
CONFIG_GPIO_SYSCON=y
# CONFIG_GPIO_VX855 is not set
CONFIG_GPIO_WCD934X=y
# CONFIG_GPIO_XILINX is not set
# CONFIG_GPIO_AMD_FCH is not set
# end of Memory mapped GPIO drivers

#
# Port-mapped I/O GPIO drivers
#
CONFIG_GPIO_104_DIO_48E=y
CONFIG_GPIO_104_IDIO_16=y
# CONFIG_GPIO_104_IDI_48 is not set
# CONFIG_GPIO_F7188X is not set
CONFIG_GPIO_GPIO_MM=y
# CONFIG_GPIO_IT87 is not set
# CONFIG_GPIO_SCH is not set
CONFIG_GPIO_SCH311X=y
CONFIG_GPIO_TS5500=y
CONFIG_GPIO_WINBOND=y
# CONFIG_GPIO_WS16C48 is not set
# end of Port-mapped I/O GPIO drivers

#
# I2C GPIO expanders
#
CONFIG_GPIO_ADP5588=y
CONFIG_GPIO_ADP5588_IRQ=y
# CONFIG_GPIO_ADNP is not set
CONFIG_GPIO_GW_PLD=y
# CONFIG_GPIO_MAX7300 is not set
CONFIG_GPIO_MAX732X=y
CONFIG_GPIO_MAX732X_IRQ=y
CONFIG_GPIO_PCA953X=y
# CONFIG_GPIO_PCA953X_IRQ is not set
CONFIG_GPIO_PCA9570=y
CONFIG_GPIO_PCF857X=y
CONFIG_GPIO_TPIC2810=y
# end of I2C GPIO expanders

#
# MFD GPIO expanders
#
CONFIG_GPIO_ARIZONA=y
# CONFIG_GPIO_BD70528 is not set
CONFIG_GPIO_BD71828=y
CONFIG_GPIO_BD9571MWV=y
CONFIG_GPIO_DA9052=y
CONFIG_GPIO_KEMPLD=y
CONFIG_GPIO_LP3943=y
# CONFIG_GPIO_LP873X is not set
CONFIG_GPIO_LP87565=y
CONFIG_GPIO_MAX77620=y
CONFIG_GPIO_MAX77650=y
# CONFIG_GPIO_STMPE is not set
CONFIG_GPIO_TC3589X=y
# CONFIG_GPIO_TPS65086 is not set
# CONFIG_GPIO_TPS65218 is not set
# CONFIG_GPIO_TPS6586X is not set
# CONFIG_GPIO_TPS65910 is not set
# CONFIG_GPIO_TPS65912 is not set
CONFIG_GPIO_TQMX86=y
CONFIG_GPIO_TWL6040=y
CONFIG_GPIO_WM8350=y
CONFIG_GPIO_WM8994=y
# end of MFD GPIO expanders

#
# PCI GPIO expanders
#
# CONFIG_GPIO_AMD8111 is not set
# CONFIG_GPIO_BT8XX is not set
# CONFIG_GPIO_ML_IOH is not set
# CONFIG_GPIO_PCH is not set
# CONFIG_GPIO_PCI_IDIO_16 is not set
# CONFIG_GPIO_PCIE_IDIO_24 is not set
# CONFIG_GPIO_RDC321X is not set
# CONFIG_GPIO_SODAVILLE is not set
# end of PCI GPIO expanders

#
# SPI GPIO expanders
#
# CONFIG_GPIO_74X164 is not set
CONFIG_GPIO_MAX3191X=y
CONFIG_GPIO_MAX7301=y
# CONFIG_GPIO_MC33880 is not set
CONFIG_GPIO_PISOSR=y
CONFIG_GPIO_XRA1403=y
CONFIG_GPIO_MOXTET=y
# end of SPI GPIO expanders

#
# USB GPIO expanders
#
# end of USB GPIO expanders

CONFIG_GPIO_AGGREGATOR=y
# CONFIG_GPIO_MOCKUP is not set
CONFIG_W1=y
CONFIG_W1_CON=y

#
# 1-wire Bus Masters
#
# CONFIG_W1_MASTER_MATROX is not set
CONFIG_W1_MASTER_DS2490=y
# CONFIG_W1_MASTER_DS2482 is not set
# CONFIG_W1_MASTER_DS1WM is not set
# CONFIG_W1_MASTER_GPIO is not set
CONFIG_W1_MASTER_SGI=y
# end of 1-wire Bus Masters

#
# 1-wire Slaves
#
# CONFIG_W1_SLAVE_THERM is not set
# CONFIG_W1_SLAVE_SMEM is not set
CONFIG_W1_SLAVE_DS2405=y
CONFIG_W1_SLAVE_DS2408=y
CONFIG_W1_SLAVE_DS2408_READBACK=y
CONFIG_W1_SLAVE_DS2413=y
# CONFIG_W1_SLAVE_DS2406 is not set
CONFIG_W1_SLAVE_DS2423=y
CONFIG_W1_SLAVE_DS2805=y
CONFIG_W1_SLAVE_DS2430=y
CONFIG_W1_SLAVE_DS2431=y
CONFIG_W1_SLAVE_DS2433=y
CONFIG_W1_SLAVE_DS2433_CRC=y
CONFIG_W1_SLAVE_DS2438=y
CONFIG_W1_SLAVE_DS250X=y
CONFIG_W1_SLAVE_DS2780=y
CONFIG_W1_SLAVE_DS2781=y
CONFIG_W1_SLAVE_DS28E04=y
CONFIG_W1_SLAVE_DS28E17=y
# end of 1-wire Slaves

# CONFIG_POWER_AVS is not set
# CONFIG_POWER_RESET is not set
CONFIG_POWER_SUPPLY=y
CONFIG_POWER_SUPPLY_DEBUG=y
# CONFIG_POWER_SUPPLY_HWMON is not set
CONFIG_PDA_POWER=y
# CONFIG_GENERIC_ADC_BATTERY is not set
CONFIG_WM8350_POWER=y
# CONFIG_TEST_POWER is not set
CONFIG_CHARGER_ADP5061=y
# CONFIG_BATTERY_ACT8945A is not set
CONFIG_BATTERY_CPCAP=y
# CONFIG_BATTERY_CW2015 is not set
# CONFIG_BATTERY_DS2760 is not set
CONFIG_BATTERY_DS2780=y
CONFIG_BATTERY_DS2781=y
CONFIG_BATTERY_DS2782=y
# CONFIG_BATTERY_LEGO_EV3 is not set
# CONFIG_BATTERY_SBS is not set
CONFIG_CHARGER_SBS=y
# CONFIG_MANAGER_SBS is not set
CONFIG_BATTERY_BQ27XXX=y
CONFIG_BATTERY_BQ27XXX_I2C=y
CONFIG_BATTERY_BQ27XXX_HDQ=y
# CONFIG_BATTERY_BQ27XXX_DT_UPDATES_NVM is not set
CONFIG_BATTERY_DA9052=y
CONFIG_CHARGER_AXP20X=y
CONFIG_BATTERY_AXP20X=y
# CONFIG_AXP20X_POWER is not set
CONFIG_AXP288_CHARGER=y
CONFIG_AXP288_FUEL_GAUGE=y
# CONFIG_BATTERY_MAX17040 is not set
# CONFIG_BATTERY_MAX17042 is not set
CONFIG_BATTERY_MAX1721X=y
# CONFIG_CHARGER_PCF50633 is not set
# CONFIG_CHARGER_MAX8903 is not set
CONFIG_CHARGER_LP8727=y
# CONFIG_CHARGER_LP8788 is not set
CONFIG_CHARGER_GPIO=y
CONFIG_CHARGER_MANAGER=y
CONFIG_CHARGER_LT3651=y
CONFIG_CHARGER_MAX14577=y
CONFIG_CHARGER_DETECTOR_MAX14656=y
# CONFIG_CHARGER_MAX77650 is not set
# CONFIG_CHARGER_MAX77693 is not set
CONFIG_CHARGER_MAX8998=y
CONFIG_CHARGER_BQ2415X=y
# CONFIG_CHARGER_BQ24190 is not set
CONFIG_CHARGER_BQ24257=y
CONFIG_CHARGER_BQ24735=y
# CONFIG_CHARGER_BQ2515X is not set
# CONFIG_CHARGER_BQ25890 is not set
# CONFIG_CHARGER_SMB347 is not set
CONFIG_CHARGER_TPS65217=y
# CONFIG_BATTERY_GAUGE_LTC2941 is not set
# CONFIG_BATTERY_GOLDFISH is not set
# CONFIG_BATTERY_RT5033 is not set
CONFIG_CHARGER_RT9455=y
CONFIG_CHARGER_CROS_USBPD=y
CONFIG_CHARGER_UCS1002=y
# CONFIG_CHARGER_BD70528 is not set
# CONFIG_CHARGER_BD99954 is not set
# CONFIG_CHARGER_WILCO is not set
CONFIG_HWMON=y
CONFIG_HWMON_VID=y
# CONFIG_HWMON_DEBUG_CHIP is not set

#
# Native drivers
#
# CONFIG_SENSORS_ABITUGURU is not set
# CONFIG_SENSORS_ABITUGURU3 is not set
CONFIG_SENSORS_AD7314=y
# CONFIG_SENSORS_AD7414 is not set
CONFIG_SENSORS_AD7418=y
# CONFIG_SENSORS_ADM1021 is not set
# CONFIG_SENSORS_ADM1025 is not set
CONFIG_SENSORS_ADM1026=y
CONFIG_SENSORS_ADM1029=y
CONFIG_SENSORS_ADM1031=y
CONFIG_SENSORS_ADM1177=y
CONFIG_SENSORS_ADM9240=y
CONFIG_SENSORS_ADT7X10=y
CONFIG_SENSORS_ADT7310=y
# CONFIG_SENSORS_ADT7410 is not set
CONFIG_SENSORS_ADT7411=y
CONFIG_SENSORS_ADT7462=y
CONFIG_SENSORS_ADT7470=y
CONFIG_SENSORS_ADT7475=y
# CONFIG_SENSORS_AS370 is not set
# CONFIG_SENSORS_ASC7621 is not set
CONFIG_SENSORS_AXI_FAN_CONTROL=y
# CONFIG_SENSORS_K8TEMP is not set
# CONFIG_SENSORS_K10TEMP is not set
# CONFIG_SENSORS_FAM15H_POWER is not set
CONFIG_SENSORS_AMD_ENERGY=y
CONFIG_SENSORS_APPLESMC=y
CONFIG_SENSORS_ASB100=y
CONFIG_SENSORS_ASPEED=y
CONFIG_SENSORS_ATXP1=y
CONFIG_SENSORS_CORSAIR_CPRO=y
CONFIG_SENSORS_DS620=y
CONFIG_SENSORS_DS1621=y
CONFIG_SENSORS_DELL_SMM=y
CONFIG_SENSORS_DA9052_ADC=y
# CONFIG_SENSORS_I5K_AMB is not set
CONFIG_SENSORS_F71805F=y
CONFIG_SENSORS_F71882FG=y
CONFIG_SENSORS_F75375S=y
# CONFIG_SENSORS_GSC is not set
CONFIG_SENSORS_MC13783_ADC=y
CONFIG_SENSORS_FSCHMD=y
CONFIG_SENSORS_GL518SM=y
CONFIG_SENSORS_GL520SM=y
CONFIG_SENSORS_G760A=y
CONFIG_SENSORS_G762=y
CONFIG_SENSORS_GPIO_FAN=y
CONFIG_SENSORS_HIH6130=y
# CONFIG_SENSORS_IIO_HWMON is not set
# CONFIG_SENSORS_I5500 is not set
CONFIG_SENSORS_CORETEMP=y
CONFIG_SENSORS_IT87=y
# CONFIG_SENSORS_JC42 is not set
CONFIG_SENSORS_POWR1220=y
# CONFIG_SENSORS_LINEAGE is not set
# CONFIG_SENSORS_LOCHNAGAR is not set
CONFIG_SENSORS_LTC2945=y
CONFIG_SENSORS_LTC2947=y
CONFIG_SENSORS_LTC2947_I2C=y
# CONFIG_SENSORS_LTC2947_SPI is not set
# CONFIG_SENSORS_LTC2990 is not set
CONFIG_SENSORS_LTC4151=y
# CONFIG_SENSORS_LTC4215 is not set
CONFIG_SENSORS_LTC4222=y
CONFIG_SENSORS_LTC4245=y
CONFIG_SENSORS_LTC4260=y
CONFIG_SENSORS_LTC4261=y
# CONFIG_SENSORS_MAX1111 is not set
# CONFIG_SENSORS_MAX16065 is not set
# CONFIG_SENSORS_MAX1619 is not set
CONFIG_SENSORS_MAX1668=y
CONFIG_SENSORS_MAX197=y
CONFIG_SENSORS_MAX31722=y
CONFIG_SENSORS_MAX31730=y
# CONFIG_SENSORS_MAX6621 is not set
# CONFIG_SENSORS_MAX6639 is not set
CONFIG_SENSORS_MAX6642=y
CONFIG_SENSORS_MAX6650=y
CONFIG_SENSORS_MAX6697=y
CONFIG_SENSORS_MAX31790=y
# CONFIG_SENSORS_MCP3021 is not set
# CONFIG_SENSORS_TC654 is not set
CONFIG_SENSORS_MENF21BMC_HWMON=y
# CONFIG_SENSORS_ADCXX is not set
CONFIG_SENSORS_LM63=y
# CONFIG_SENSORS_LM70 is not set
CONFIG_SENSORS_LM73=y
CONFIG_SENSORS_LM75=y
CONFIG_SENSORS_LM77=y
# CONFIG_SENSORS_LM78 is not set
CONFIG_SENSORS_LM80=y
CONFIG_SENSORS_LM83=y
# CONFIG_SENSORS_LM85 is not set
# CONFIG_SENSORS_LM87 is not set
CONFIG_SENSORS_LM90=y
CONFIG_SENSORS_LM92=y
CONFIG_SENSORS_LM93=y
CONFIG_SENSORS_LM95234=y
# CONFIG_SENSORS_LM95241 is not set
CONFIG_SENSORS_LM95245=y
# CONFIG_SENSORS_PC87360 is not set
CONFIG_SENSORS_PC87427=y
CONFIG_SENSORS_NTC_THERMISTOR=y
CONFIG_SENSORS_NCT6683=y
# CONFIG_SENSORS_NCT6775 is not set
CONFIG_SENSORS_NCT7802=y
CONFIG_SENSORS_NPCM7XX=y
# CONFIG_SENSORS_PCF8591 is not set
CONFIG_PMBUS=y
CONFIG_SENSORS_PMBUS=y
CONFIG_SENSORS_ADM1275=y
CONFIG_SENSORS_BEL_PFE=y
CONFIG_SENSORS_IBM_CFFPS=y
CONFIG_SENSORS_INSPUR_IPSPS=y
# CONFIG_SENSORS_IR35221 is not set
CONFIG_SENSORS_IR38064=y
CONFIG_SENSORS_IRPS5401=y
CONFIG_SENSORS_ISL68137=y
CONFIG_SENSORS_LM25066=y
CONFIG_SENSORS_LTC2978=y
CONFIG_SENSORS_LTC2978_REGULATOR=y
# CONFIG_SENSORS_LTC3815 is not set
# CONFIG_SENSORS_MAX16064 is not set
# CONFIG_SENSORS_MAX16601 is not set
CONFIG_SENSORS_MAX20730=y
CONFIG_SENSORS_MAX20751=y
CONFIG_SENSORS_MAX31785=y
# CONFIG_SENSORS_MAX34440 is not set
CONFIG_SENSORS_MAX8688=y
# CONFIG_SENSORS_PXE1610 is not set
# CONFIG_SENSORS_TPS40422 is not set
# CONFIG_SENSORS_TPS53679 is not set
CONFIG_SENSORS_UCD9000=y
CONFIG_SENSORS_UCD9200=y
CONFIG_SENSORS_XDPE122=y
CONFIG_SENSORS_ZL6100=y
CONFIG_SENSORS_PWM_FAN=y
# CONFIG_SENSORS_SHT15 is not set
CONFIG_SENSORS_SHT21=y
# CONFIG_SENSORS_SHT3x is not set
CONFIG_SENSORS_SHTC1=y
# CONFIG_SENSORS_SIS5595 is not set
# CONFIG_SENSORS_DME1737 is not set
CONFIG_SENSORS_EMC1403=y
CONFIG_SENSORS_EMC2103=y
CONFIG_SENSORS_EMC6W201=y
# CONFIG_SENSORS_SMSC47M1 is not set
CONFIG_SENSORS_SMSC47M192=y
# CONFIG_SENSORS_SMSC47B397 is not set
# CONFIG_SENSORS_STTS751 is not set
CONFIG_SENSORS_SMM665=y
# CONFIG_SENSORS_ADC128D818 is not set
CONFIG_SENSORS_ADS7828=y
CONFIG_SENSORS_ADS7871=y
CONFIG_SENSORS_AMC6821=y
CONFIG_SENSORS_INA209=y
# CONFIG_SENSORS_INA2XX is not set
# CONFIG_SENSORS_INA3221 is not set
CONFIG_SENSORS_TC74=y
# CONFIG_SENSORS_THMC50 is not set
CONFIG_SENSORS_TMP102=y
CONFIG_SENSORS_TMP103=y
CONFIG_SENSORS_TMP108=y
CONFIG_SENSORS_TMP401=y
CONFIG_SENSORS_TMP421=y
CONFIG_SENSORS_TMP513=y
CONFIG_SENSORS_VIA_CPUTEMP=y
# CONFIG_SENSORS_VIA686A is not set
CONFIG_SENSORS_VT1211=y
# CONFIG_SENSORS_VT8231 is not set
# CONFIG_SENSORS_W83773G is not set
CONFIG_SENSORS_W83781D=y
CONFIG_SENSORS_W83791D=y
# CONFIG_SENSORS_W83792D is not set
CONFIG_SENSORS_W83793=y
CONFIG_SENSORS_W83795=y
CONFIG_SENSORS_W83795_FANCTRL=y
CONFIG_SENSORS_W83L785TS=y
CONFIG_SENSORS_W83L786NG=y
CONFIG_SENSORS_W83627HF=y
# CONFIG_SENSORS_W83627EHF is not set
# CONFIG_SENSORS_WM8350 is not set

#
# ACPI drivers
#
# CONFIG_SENSORS_ACPI_POWER is not set
# CONFIG_SENSORS_ATK0110 is not set
CONFIG_THERMAL=y
# CONFIG_THERMAL_NETLINK is not set
# CONFIG_THERMAL_STATISTICS is not set
CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
CONFIG_THERMAL_HWMON=y
CONFIG_THERMAL_OF=y
CONFIG_THERMAL_WRITABLE_TRIPS=y
CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE=y
# CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
# CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
CONFIG_THERMAL_GOV_FAIR_SHARE=y
CONFIG_THERMAL_GOV_STEP_WISE=y
# CONFIG_THERMAL_GOV_BANG_BANG is not set
# CONFIG_THERMAL_GOV_USER_SPACE is not set
# CONFIG_CPU_THERMAL is not set
# CONFIG_DEVFREQ_THERMAL is not set
# CONFIG_THERMAL_EMULATION is not set
CONFIG_THERMAL_MMIO=y
CONFIG_MAX77620_THERMAL=y
# CONFIG_DA9062_THERMAL is not set

#
# Intel thermal drivers
#
CONFIG_INTEL_POWERCLAMP=y
# CONFIG_INTEL_SOC_DTS_THERMAL is not set

#
# ACPI INT340X thermal drivers
#
# CONFIG_INT340X_THERMAL is not set
# end of ACPI INT340X thermal drivers

# CONFIG_INTEL_PCH_THERMAL is not set
# end of Intel thermal drivers

CONFIG_GENERIC_ADC_THERMAL=y
# CONFIG_WATCHDOG is not set
CONFIG_SSB_POSSIBLE=y
CONFIG_SSB=y
CONFIG_SSB_SPROM=y
CONFIG_SSB_PCIHOST_POSSIBLE=y
CONFIG_SSB_PCIHOST=y
CONFIG_SSB_PCMCIAHOST_POSSIBLE=y
CONFIG_SSB_PCMCIAHOST=y
CONFIG_SSB_DRIVER_PCICORE_POSSIBLE=y
# CONFIG_SSB_DRIVER_PCICORE is not set
CONFIG_SSB_DRIVER_GPIO=y
CONFIG_BCMA_POSSIBLE=y
# CONFIG_BCMA is not set

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=y
# CONFIG_MFD_CS5535 is not set
CONFIG_MFD_ACT8945A=y
# CONFIG_MFD_AS3711 is not set
CONFIG_MFD_AS3722=y
# CONFIG_PMIC_ADP5520 is not set
# CONFIG_MFD_AAT2870_CORE is not set
# CONFIG_MFD_ATMEL_FLEXCOM is not set
CONFIG_MFD_ATMEL_HLCDC=y
CONFIG_MFD_BCM590XX=y
CONFIG_MFD_BD9571MWV=y
CONFIG_MFD_AXP20X=y
CONFIG_MFD_AXP20X_I2C=y
CONFIG_MFD_CROS_EC_DEV=y
# CONFIG_MFD_MADERA is not set
# CONFIG_PMIC_DA903X is not set
CONFIG_PMIC_DA9052=y
CONFIG_MFD_DA9052_SPI=y
# CONFIG_MFD_DA9052_I2C is not set
# CONFIG_MFD_DA9055 is not set
CONFIG_MFD_DA9062=y
CONFIG_MFD_DA9063=y
# CONFIG_MFD_DA9150 is not set
# CONFIG_MFD_DLN2 is not set
CONFIG_MFD_GATEWORKS_GSC=y
CONFIG_MFD_MC13XXX=y
CONFIG_MFD_MC13XXX_SPI=y
CONFIG_MFD_MC13XXX_I2C=y
# CONFIG_MFD_MP2629 is not set
CONFIG_MFD_HI6421_PMIC=y
# CONFIG_HTC_PASIC3 is not set
CONFIG_HTC_I2CPLD=y
# CONFIG_MFD_INTEL_QUARK_I2C_GPIO is not set
# CONFIG_LPC_ICH is not set
# CONFIG_LPC_SCH is not set
# CONFIG_INTEL_SOC_PMIC is not set
CONFIG_INTEL_SOC_PMIC_CHTWC=y
CONFIG_INTEL_SOC_PMIC_CHTDC_TI=y
CONFIG_MFD_INTEL_LPSS=y
CONFIG_MFD_INTEL_LPSS_ACPI=y
# CONFIG_MFD_INTEL_LPSS_PCI is not set
CONFIG_MFD_IQS62X=y
# CONFIG_MFD_JANZ_CMODIO is not set
CONFIG_MFD_KEMPLD=y
CONFIG_MFD_88PM800=y
CONFIG_MFD_88PM805=y
# CONFIG_MFD_88PM860X is not set
CONFIG_MFD_MAX14577=y
CONFIG_MFD_MAX77620=y
CONFIG_MFD_MAX77650=y
CONFIG_MFD_MAX77686=y
CONFIG_MFD_MAX77693=y
CONFIG_MFD_MAX77843=y
# CONFIG_MFD_MAX8907 is not set
# CONFIG_MFD_MAX8925 is not set
# CONFIG_MFD_MAX8997 is not set
CONFIG_MFD_MAX8998=y
CONFIG_MFD_MT6360=y
CONFIG_MFD_MT6397=y
CONFIG_MFD_MENF21BMC=y
CONFIG_EZX_PCAP=y
CONFIG_MFD_CPCAP=y
# CONFIG_MFD_VIPERBOARD is not set
# CONFIG_MFD_RETU is not set
CONFIG_MFD_PCF50633=y
CONFIG_PCF50633_ADC=y
CONFIG_PCF50633_GPIO=y
# CONFIG_MFD_RDC321X is not set
CONFIG_MFD_RT5033=y
# CONFIG_MFD_RC5T583 is not set
CONFIG_MFD_RK808=y
CONFIG_MFD_RN5T618=y
CONFIG_MFD_SEC_CORE=y
CONFIG_MFD_SI476X_CORE=y
# CONFIG_MFD_SM501 is not set
CONFIG_MFD_SKY81452=y
CONFIG_ABX500_CORE=y
CONFIG_AB3100_CORE=y
CONFIG_AB3100_OTP=y
CONFIG_MFD_STMPE=y

#
# STMicroelectronics STMPE Interface Drivers
#
# CONFIG_STMPE_I2C is not set
# CONFIG_STMPE_SPI is not set
# end of STMicroelectronics STMPE Interface Drivers

CONFIG_MFD_SYSCON=y
# CONFIG_MFD_TI_AM335X_TSCADC is not set
CONFIG_MFD_LP3943=y
CONFIG_MFD_LP8788=y
# CONFIG_MFD_TI_LMU is not set
# CONFIG_MFD_PALMAS is not set
CONFIG_TPS6105X=y
# CONFIG_TPS65010 is not set
# CONFIG_TPS6507X is not set
CONFIG_MFD_TPS65086=y
# CONFIG_MFD_TPS65090 is not set
CONFIG_MFD_TPS65217=y
# CONFIG_MFD_TPS68470 is not set
CONFIG_MFD_TI_LP873X=y
CONFIG_MFD_TI_LP87565=y
CONFIG_MFD_TPS65218=y
CONFIG_MFD_TPS6586X=y
CONFIG_MFD_TPS65910=y
CONFIG_MFD_TPS65912=y
CONFIG_MFD_TPS65912_I2C=y
CONFIG_MFD_TPS65912_SPI=y
CONFIG_MFD_TPS80031=y
# CONFIG_TWL4030_CORE is not set
CONFIG_TWL6040_CORE=y
CONFIG_MFD_WL1273_CORE=y
CONFIG_MFD_LM3533=y
# CONFIG_MFD_TIMBERDALE is not set
CONFIG_MFD_TC3589X=y
CONFIG_MFD_TQMX86=y
# CONFIG_MFD_VX855 is not set
CONFIG_MFD_LOCHNAGAR=y
CONFIG_MFD_ARIZONA=y
CONFIG_MFD_ARIZONA_I2C=y
# CONFIG_MFD_ARIZONA_SPI is not set
# CONFIG_MFD_CS47L24 is not set
# CONFIG_MFD_WM5102 is not set
# CONFIG_MFD_WM5110 is not set
CONFIG_MFD_WM8997=y
CONFIG_MFD_WM8998=y
# CONFIG_MFD_WM8400 is not set
# CONFIG_MFD_WM831X_I2C is not set
# CONFIG_MFD_WM831X_SPI is not set
CONFIG_MFD_WM8350=y
CONFIG_MFD_WM8350_I2C=y
CONFIG_MFD_WM8994=y
# CONFIG_MFD_ROHM_BD718XX is not set
CONFIG_MFD_ROHM_BD70528=y
CONFIG_MFD_ROHM_BD71828=y
CONFIG_MFD_STPMIC1=y
CONFIG_MFD_STMFX=y
CONFIG_MFD_WCD934X=y
# CONFIG_RAVE_SP_CORE is not set
# end of Multifunction device drivers

CONFIG_REGULATOR=y
CONFIG_REGULATOR_DEBUG=y
CONFIG_REGULATOR_FIXED_VOLTAGE=y
# CONFIG_REGULATOR_VIRTUAL_CONSUMER is not set
CONFIG_REGULATOR_USERSPACE_CONSUMER=y
CONFIG_REGULATOR_88PG86X=y
# CONFIG_REGULATOR_88PM800 is not set
CONFIG_REGULATOR_ACT8865=y
# CONFIG_REGULATOR_ACT8945A is not set
CONFIG_REGULATOR_AD5398=y
CONFIG_REGULATOR_AB3100=y
# CONFIG_REGULATOR_AS3722 is not set
CONFIG_REGULATOR_AXP20X=y
CONFIG_REGULATOR_BCM590XX=y
# CONFIG_REGULATOR_BD70528 is not set
# CONFIG_REGULATOR_BD71828 is not set
CONFIG_REGULATOR_BD9571MWV=y
CONFIG_REGULATOR_CPCAP=y
# CONFIG_REGULATOR_CROS_EC is not set
CONFIG_REGULATOR_DA9052=y
# CONFIG_REGULATOR_DA9062 is not set
CONFIG_REGULATOR_DA9063=y
CONFIG_REGULATOR_DA9210=y
CONFIG_REGULATOR_DA9211=y
CONFIG_REGULATOR_FAN53555=y
CONFIG_REGULATOR_FAN53880=y
# CONFIG_REGULATOR_GPIO is not set
CONFIG_REGULATOR_HI6421=y
# CONFIG_REGULATOR_HI6421V530 is not set
CONFIG_REGULATOR_ISL9305=y
# CONFIG_REGULATOR_ISL6271A is not set
CONFIG_REGULATOR_LOCHNAGAR=y
# CONFIG_REGULATOR_LP3971 is not set
CONFIG_REGULATOR_LP3972=y
# CONFIG_REGULATOR_LP872X is not set
# CONFIG_REGULATOR_LP873X is not set
CONFIG_REGULATOR_LP8755=y
# CONFIG_REGULATOR_LP87565 is not set
CONFIG_REGULATOR_LP8788=y
CONFIG_REGULATOR_LTC3589=y
# CONFIG_REGULATOR_LTC3676 is not set
CONFIG_REGULATOR_MAX14577=y
# CONFIG_REGULATOR_MAX1586 is not set
# CONFIG_REGULATOR_MAX77620 is not set
# CONFIG_REGULATOR_MAX77650 is not set
CONFIG_REGULATOR_MAX8649=y
# CONFIG_REGULATOR_MAX8660 is not set
CONFIG_REGULATOR_MAX8952=y
CONFIG_REGULATOR_MAX8973=y
CONFIG_REGULATOR_MAX8998=y
CONFIG_REGULATOR_MAX77686=y
CONFIG_REGULATOR_MAX77693=y
# CONFIG_REGULATOR_MAX77802 is not set
CONFIG_REGULATOR_MAX77826=y
CONFIG_REGULATOR_MC13XXX_CORE=y
# CONFIG_REGULATOR_MC13783 is not set
CONFIG_REGULATOR_MC13892=y
# CONFIG_REGULATOR_MCP16502 is not set
CONFIG_REGULATOR_MP5416=y
# CONFIG_REGULATOR_MP8859 is not set
CONFIG_REGULATOR_MP886X=y
# CONFIG_REGULATOR_MPQ7920 is not set
# CONFIG_REGULATOR_MT6311 is not set
# CONFIG_REGULATOR_MT6323 is not set
CONFIG_REGULATOR_MT6358=y
CONFIG_REGULATOR_MT6397=y
CONFIG_REGULATOR_PCA9450=y
CONFIG_REGULATOR_PCAP=y
CONFIG_REGULATOR_PCF50633=y
CONFIG_REGULATOR_PFUZE100=y
# CONFIG_REGULATOR_PV88060 is not set
# CONFIG_REGULATOR_PV88080 is not set
# CONFIG_REGULATOR_PV88090 is not set
CONFIG_REGULATOR_PWM=y
CONFIG_REGULATOR_RK808=y
CONFIG_REGULATOR_RN5T618=y
CONFIG_REGULATOR_RT5033=y
# CONFIG_REGULATOR_S2MPA01 is not set
CONFIG_REGULATOR_S2MPS11=y
# CONFIG_REGULATOR_S5M8767 is not set
CONFIG_REGULATOR_SKY81452=y
CONFIG_REGULATOR_SLG51000=y
CONFIG_REGULATOR_STPMIC1=y
# CONFIG_REGULATOR_SY8106A is not set
# CONFIG_REGULATOR_SY8824X is not set
CONFIG_REGULATOR_SY8827N=y
CONFIG_REGULATOR_TPS51632=y
CONFIG_REGULATOR_TPS6105X=y
CONFIG_REGULATOR_TPS62360=y
CONFIG_REGULATOR_TPS65023=y
# CONFIG_REGULATOR_TPS6507X is not set
# CONFIG_REGULATOR_TPS65086 is not set
# CONFIG_REGULATOR_TPS65132 is not set
CONFIG_REGULATOR_TPS65217=y
CONFIG_REGULATOR_TPS65218=y
CONFIG_REGULATOR_TPS6524X=y
CONFIG_REGULATOR_TPS6586X=y
CONFIG_REGULATOR_TPS65910=y
CONFIG_REGULATOR_TPS65912=y
# CONFIG_REGULATOR_TPS80031 is not set
CONFIG_REGULATOR_VCTRL=y
# CONFIG_REGULATOR_WM8350 is not set
CONFIG_REGULATOR_WM8994=y
CONFIG_RC_CORE=y
CONFIG_RC_MAP=y
CONFIG_LIRC=y
# CONFIG_RC_DECODERS is not set
# CONFIG_RC_DEVICES is not set
CONFIG_CEC_CORE=y
CONFIG_CEC_NOTIFIER=y
CONFIG_MEDIA_CEC_RC=y
# CONFIG_MEDIA_CEC_SUPPORT is not set
CONFIG_MEDIA_SUPPORT=y
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
CONFIG_VIDEO_DEV=y
CONFIG_MEDIA_CONTROLLER=y
CONFIG_DVB_CORE=y
# end of Media core support

#
# Video4Linux options
#
CONFIG_VIDEO_V4L2=y
CONFIG_VIDEO_V4L2_I2C=y
CONFIG_VIDEO_V4L2_SUBDEV_API=y
CONFIG_VIDEO_ADV_DEBUG=y
CONFIG_VIDEO_FIXED_MINOR_RANGES=y
CONFIG_VIDEO_TUNER=y
CONFIG_V4L2_MEM2MEM_DEV=y
CONFIG_V4L2_FWNODE=y
CONFIG_VIDEOBUF_GEN=y
CONFIG_VIDEOBUF_VMALLOC=y
# end of Video4Linux options

#
# Media controller options
#
CONFIG_MEDIA_CONTROLLER_DVB=y
# end of Media controller options

#
# Digital TV options
#
# CONFIG_DVB_MMAP is not set
CONFIG_DVB_NET=y
CONFIG_DVB_MAX_ADAPTERS=16
# CONFIG_DVB_DYNAMIC_MINORS is not set
# CONFIG_DVB_DEMUX_SECTION_LOSS_LOG is not set
# CONFIG_DVB_ULE_DEBUG is not set
# end of Digital TV options

#
# Media drivers
#
CONFIG_MEDIA_USB_SUPPORT=y

#
# Webcam devices
#
CONFIG_USB_VIDEO_CLASS=y
CONFIG_USB_VIDEO_CLASS_INPUT_EVDEV=y
CONFIG_USB_GSPCA=y
CONFIG_USB_M5602=y
# CONFIG_USB_STV06XX is not set
CONFIG_USB_GL860=y
CONFIG_USB_GSPCA_BENQ=y
CONFIG_USB_GSPCA_CONEX=y
CONFIG_USB_GSPCA_CPIA1=y
CONFIG_USB_GSPCA_DTCS033=y
# CONFIG_USB_GSPCA_ETOMS is not set
CONFIG_USB_GSPCA_FINEPIX=y
CONFIG_USB_GSPCA_JEILINJ=y
CONFIG_USB_GSPCA_JL2005BCD=y
CONFIG_USB_GSPCA_KINECT=y
# CONFIG_USB_GSPCA_KONICA is not set
# CONFIG_USB_GSPCA_MARS is not set
CONFIG_USB_GSPCA_MR97310A=y
# CONFIG_USB_GSPCA_NW80X is not set
CONFIG_USB_GSPCA_OV519=y
CONFIG_USB_GSPCA_OV534=y
CONFIG_USB_GSPCA_OV534_9=y
CONFIG_USB_GSPCA_PAC207=y
CONFIG_USB_GSPCA_PAC7302=y
CONFIG_USB_GSPCA_PAC7311=y
# CONFIG_USB_GSPCA_SE401 is not set
CONFIG_USB_GSPCA_SN9C2028=y
CONFIG_USB_GSPCA_SN9C20X=y
CONFIG_USB_GSPCA_SONIXB=y
CONFIG_USB_GSPCA_SONIXJ=y
CONFIG_USB_GSPCA_SPCA500=y
CONFIG_USB_GSPCA_SPCA501=y
CONFIG_USB_GSPCA_SPCA505=y
CONFIG_USB_GSPCA_SPCA506=y
# CONFIG_USB_GSPCA_SPCA508 is not set
# CONFIG_USB_GSPCA_SPCA561 is not set
# CONFIG_USB_GSPCA_SPCA1528 is not set
CONFIG_USB_GSPCA_SQ905=y
CONFIG_USB_GSPCA_SQ905C=y
CONFIG_USB_GSPCA_SQ930X=y
CONFIG_USB_GSPCA_STK014=y
CONFIG_USB_GSPCA_STK1135=y
CONFIG_USB_GSPCA_STV0680=y
CONFIG_USB_GSPCA_SUNPLUS=y
CONFIG_USB_GSPCA_T613=y
CONFIG_USB_GSPCA_TOPRO=y
# CONFIG_USB_GSPCA_TOUPTEK is not set
CONFIG_USB_GSPCA_TV8532=y
# CONFIG_USB_GSPCA_VC032X is not set
CONFIG_USB_GSPCA_VICAM=y
# CONFIG_USB_GSPCA_XIRLINK_CIT is not set
CONFIG_USB_GSPCA_ZC3XX=y
# CONFIG_USB_PWC is not set
CONFIG_VIDEO_CPIA2=y
CONFIG_USB_ZR364XX=y
CONFIG_USB_STKWEBCAM=y
# CONFIG_USB_S2255 is not set

#
# Analog TV USB devices
#
CONFIG_VIDEO_PVRUSB2=y
# CONFIG_VIDEO_PVRUSB2_SYSFS is not set
# CONFIG_VIDEO_PVRUSB2_DVB is not set
# CONFIG_VIDEO_HDPVR is not set
CONFIG_VIDEO_STK1160_COMMON=y
CONFIG_VIDEO_STK1160=y

#
# Analog/digital TV USB devices
#
CONFIG_VIDEO_AU0828=y
CONFIG_VIDEO_AU0828_V4L2=y
# CONFIG_VIDEO_AU0828_RC is not set
# CONFIG_VIDEO_CX231XX is not set
# CONFIG_VIDEO_TM6000 is not set

#
# Digital TV USB devices
#
CONFIG_DVB_USB=y
CONFIG_DVB_USB_DEBUG=y
CONFIG_DVB_USB_DIB3000MC=y
CONFIG_DVB_USB_A800=y
CONFIG_DVB_USB_DIBUSB_MB=y
CONFIG_DVB_USB_DIBUSB_MB_FAULTY=y
# CONFIG_DVB_USB_DIBUSB_MC is not set
# CONFIG_DVB_USB_DIB0700 is not set
CONFIG_DVB_USB_UMT_010=y
CONFIG_DVB_USB_CXUSB=y
CONFIG_DVB_USB_CXUSB_ANALOG=y
# CONFIG_DVB_USB_M920X is not set
# CONFIG_DVB_USB_DIGITV is not set
CONFIG_DVB_USB_VP7045=y
CONFIG_DVB_USB_VP702X=y
# CONFIG_DVB_USB_GP8PSK is not set
# CONFIG_DVB_USB_NOVA_T_USB2 is not set
CONFIG_DVB_USB_TTUSB2=y
# CONFIG_DVB_USB_DTT200U is not set
# CONFIG_DVB_USB_OPERA1 is not set
CONFIG_DVB_USB_AF9005=y
CONFIG_DVB_USB_AF9005_REMOTE=y
# CONFIG_DVB_USB_PCTV452E is not set
CONFIG_DVB_USB_DW2102=y
CONFIG_DVB_USB_CINERGY_T2=y
CONFIG_DVB_USB_DTV5100=y
CONFIG_DVB_USB_AZ6027=y
# CONFIG_DVB_USB_TECHNISAT_USB2 is not set
CONFIG_DVB_USB_V2=y
# CONFIG_DVB_USB_AF9015 is not set
CONFIG_DVB_USB_AF9035=y
# CONFIG_DVB_USB_ANYSEE is not set
# CONFIG_DVB_USB_AU6610 is not set
CONFIG_DVB_USB_AZ6007=y
CONFIG_DVB_USB_CE6230=y
# CONFIG_DVB_USB_EC168 is not set
# CONFIG_DVB_USB_GL861 is not set
# CONFIG_DVB_USB_LME2510 is not set
CONFIG_DVB_USB_MXL111SF=y
# CONFIG_DVB_USB_RTL28XXU is not set
# CONFIG_DVB_USB_DVBSKY is not set
CONFIG_DVB_USB_ZD1301=y
# CONFIG_DVB_TTUSB_BUDGET is not set
# CONFIG_DVB_TTUSB_DEC is not set
CONFIG_SMS_USB_DRV=y
CONFIG_DVB_B2C2_FLEXCOP_USB=y
CONFIG_DVB_B2C2_FLEXCOP_USB_DEBUG=y
CONFIG_DVB_AS102=y

#
# Webcam, TV (analog/digital) USB devices
#
CONFIG_VIDEO_EM28XX=y
CONFIG_VIDEO_EM28XX_V4L2=y
CONFIG_VIDEO_EM28XX_DVB=y
CONFIG_VIDEO_EM28XX_RC=y

#
# Software defined radio USB devices
#
# CONFIG_USB_AIRSPY is not set
# CONFIG_USB_HACKRF is not set
# CONFIG_USB_MSI2500 is not set
# CONFIG_MEDIA_PCI_SUPPORT is not set
# CONFIG_RADIO_ADAPTERS is not set
CONFIG_MEDIA_COMMON_OPTIONS=y

#
# common driver options
#
CONFIG_VIDEO_CX2341X=y
CONFIG_VIDEO_TVEEPROM=y
CONFIG_CYPRESS_FIRMWARE=y
CONFIG_VIDEOBUF2_CORE=y
CONFIG_VIDEOBUF2_V4L2=y
CONFIG_VIDEOBUF2_MEMOPS=y
CONFIG_VIDEOBUF2_DMA_CONTIG=y
CONFIG_VIDEOBUF2_VMALLOC=y
CONFIG_VIDEOBUF2_DMA_SG=y
CONFIG_DVB_B2C2_FLEXCOP=y
CONFIG_DVB_B2C2_FLEXCOP_DEBUG=y
CONFIG_SMS_SIANO_MDTV=y
# CONFIG_SMS_SIANO_RC is not set
CONFIG_V4L_PLATFORM_DRIVERS=y
# CONFIG_VIDEO_CAFE_CCIC is not set
# CONFIG_VIDEO_CADENCE is not set
CONFIG_VIDEO_ASPEED=y
# CONFIG_VIDEO_MUX is not set
# CONFIG_VIDEO_XILINX is not set
CONFIG_V4L_MEM2MEM_DRIVERS=y
CONFIG_VIDEO_MEM2MEM_DEINTERLACE=y
# CONFIG_DVB_PLATFORM_DRIVERS is not set
CONFIG_SDR_PLATFORM_DRIVERS=y
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
CONFIG_VIDEO_IR_I2C=y

#
# Audio decoders, processors and mixers
#
CONFIG_VIDEO_TVAUDIO=y
CONFIG_VIDEO_TDA7432=y
# CONFIG_VIDEO_TDA9840 is not set
# CONFIG_VIDEO_TEA6415C is not set
# CONFIG_VIDEO_TEA6420 is not set
CONFIG_VIDEO_MSP3400=y
# CONFIG_VIDEO_CS3308 is not set
CONFIG_VIDEO_CS5345=y
CONFIG_VIDEO_CS53L32A=y
# CONFIG_VIDEO_TLV320AIC23B is not set
CONFIG_VIDEO_UDA1342=y
CONFIG_VIDEO_WM8775=y
# CONFIG_VIDEO_WM8739 is not set
# CONFIG_VIDEO_VP27SMPX is not set
# CONFIG_VIDEO_SONY_BTF_MPX is not set
# end of Audio decoders, processors and mixers

#
# RDS decoders
#
CONFIG_VIDEO_SAA6588=y
# end of RDS decoders

#
# Video decoders
#
# CONFIG_VIDEO_ADV7180 is not set
# CONFIG_VIDEO_ADV7183 is not set
# CONFIG_VIDEO_ADV748X is not set
# CONFIG_VIDEO_ADV7604 is not set
CONFIG_VIDEO_ADV7842=y
CONFIG_VIDEO_ADV7842_CEC=y
# CONFIG_VIDEO_BT819 is not set
CONFIG_VIDEO_BT856=y
CONFIG_VIDEO_BT866=y
CONFIG_VIDEO_KS0127=y
CONFIG_VIDEO_ML86V7667=y
# CONFIG_VIDEO_SAA7110 is not set
CONFIG_VIDEO_SAA711X=y
CONFIG_VIDEO_TC358743=y
CONFIG_VIDEO_TC358743_CEC=y
CONFIG_VIDEO_TVP514X=y
CONFIG_VIDEO_TVP5150=y
CONFIG_VIDEO_TVP7002=y
CONFIG_VIDEO_TW2804=y
CONFIG_VIDEO_TW9903=y
CONFIG_VIDEO_TW9906=y
# CONFIG_VIDEO_TW9910 is not set
CONFIG_VIDEO_VPX3220=y
CONFIG_VIDEO_MAX9286=y

#
# Video and audio decoders
#
CONFIG_VIDEO_SAA717X=y
CONFIG_VIDEO_CX25840=y
# end of Video decoders

#
# Video encoders
#
CONFIG_VIDEO_SAA7127=y
CONFIG_VIDEO_SAA7185=y
# CONFIG_VIDEO_ADV7170 is not set
# CONFIG_VIDEO_ADV7175 is not set
CONFIG_VIDEO_ADV7343=y
CONFIG_VIDEO_ADV7393=y
CONFIG_VIDEO_AD9389B=y
CONFIG_VIDEO_AK881X=y
CONFIG_VIDEO_THS8200=y
# end of Video encoders

#
# Video improvement chips
#
CONFIG_VIDEO_UPD64031A=y
# CONFIG_VIDEO_UPD64083 is not set
# end of Video improvement chips

#
# Audio/Video compression chips
#
CONFIG_VIDEO_SAA6752HS=y
# end of Audio/Video compression chips

#
# SDR tuner chips
#
CONFIG_SDR_MAX2175=y
# end of SDR tuner chips

#
# Miscellaneous helper chips
#
# CONFIG_VIDEO_THS7303 is not set
# CONFIG_VIDEO_M52790 is not set
CONFIG_VIDEO_I2C=y
# CONFIG_VIDEO_ST_MIPID02 is not set
# end of Miscellaneous helper chips

#
# Camera sensor devices
#
CONFIG_VIDEO_APTINA_PLL=y
CONFIG_VIDEO_SMIAPP_PLL=y
CONFIG_VIDEO_HI556=y
# CONFIG_VIDEO_IMX214 is not set
CONFIG_VIDEO_IMX219=y
CONFIG_VIDEO_IMX258=y
CONFIG_VIDEO_IMX274=y
CONFIG_VIDEO_IMX290=y
# CONFIG_VIDEO_IMX319 is not set
CONFIG_VIDEO_IMX355=y
CONFIG_VIDEO_OV2640=y
CONFIG_VIDEO_OV2659=y
# CONFIG_VIDEO_OV2680 is not set
CONFIG_VIDEO_OV2685=y
CONFIG_VIDEO_OV2740=y
# CONFIG_VIDEO_OV5640 is not set
CONFIG_VIDEO_OV5645=y
CONFIG_VIDEO_OV5647=y
CONFIG_VIDEO_OV6650=y
CONFIG_VIDEO_OV5670=y
CONFIG_VIDEO_OV5675=y
# CONFIG_VIDEO_OV5695 is not set
# CONFIG_VIDEO_OV7251 is not set
CONFIG_VIDEO_OV772X=y
# CONFIG_VIDEO_OV7640 is not set
CONFIG_VIDEO_OV7670=y
# CONFIG_VIDEO_OV7740 is not set
CONFIG_VIDEO_OV8856=y
CONFIG_VIDEO_OV9640=y
# CONFIG_VIDEO_OV9650 is not set
CONFIG_VIDEO_OV13858=y
CONFIG_VIDEO_VS6624=y
CONFIG_VIDEO_MT9M001=y
CONFIG_VIDEO_MT9M032=y
CONFIG_VIDEO_MT9M111=y
# CONFIG_VIDEO_MT9P031 is not set
# CONFIG_VIDEO_MT9T001 is not set
CONFIG_VIDEO_MT9T112=y
CONFIG_VIDEO_MT9V011=y
CONFIG_VIDEO_MT9V032=y
# CONFIG_VIDEO_MT9V111 is not set
CONFIG_VIDEO_SR030PC30=y
CONFIG_VIDEO_NOON010PC30=y
CONFIG_VIDEO_M5MOLS=y
# CONFIG_VIDEO_RDACM20 is not set
# CONFIG_VIDEO_RJ54N1 is not set
# CONFIG_VIDEO_S5K6AA is not set
CONFIG_VIDEO_S5K6A3=y
# CONFIG_VIDEO_S5K4ECGX is not set
CONFIG_VIDEO_S5K5BAF=y
CONFIG_VIDEO_SMIAPP=y
CONFIG_VIDEO_ET8EK8=y
CONFIG_VIDEO_S5C73M3=y
# end of Camera sensor devices

#
# Lens drivers
#
# CONFIG_VIDEO_AD5820 is not set
CONFIG_VIDEO_AK7375=y
# CONFIG_VIDEO_DW9714 is not set
# CONFIG_VIDEO_DW9768 is not set
CONFIG_VIDEO_DW9807_VCM=y
# end of Lens drivers

#
# Flash devices
#
CONFIG_VIDEO_ADP1653=y
CONFIG_VIDEO_LM3560=y
# CONFIG_VIDEO_LM3646 is not set
# end of Flash devices

#
# SPI helper chips
#
CONFIG_VIDEO_GS1662=y
# end of SPI helper chips

#
# Media SPI Adapters
#
CONFIG_CXD2880_SPI_DRV=y
# end of Media SPI Adapters

CONFIG_MEDIA_TUNER=y

#
# Customize TV tuners
#
# CONFIG_MEDIA_TUNER_SIMPLE is not set
CONFIG_MEDIA_TUNER_TDA18250=y
# CONFIG_MEDIA_TUNER_TDA8290 is not set
# CONFIG_MEDIA_TUNER_TDA827X is not set
CONFIG_MEDIA_TUNER_TDA18271=y
CONFIG_MEDIA_TUNER_TDA9887=y
# CONFIG_MEDIA_TUNER_TEA5761 is not set
# CONFIG_MEDIA_TUNER_TEA5767 is not set
CONFIG_MEDIA_TUNER_MSI001=y
CONFIG_MEDIA_TUNER_MT20XX=y
# CONFIG_MEDIA_TUNER_MT2060 is not set
CONFIG_MEDIA_TUNER_MT2063=y
# CONFIG_MEDIA_TUNER_MT2266 is not set
CONFIG_MEDIA_TUNER_MT2131=y
CONFIG_MEDIA_TUNER_QT1010=y
CONFIG_MEDIA_TUNER_XC2028=y
CONFIG_MEDIA_TUNER_XC5000=y
CONFIG_MEDIA_TUNER_XC4000=y
# CONFIG_MEDIA_TUNER_MXL5005S is not set
# CONFIG_MEDIA_TUNER_MXL5007T is not set
# CONFIG_MEDIA_TUNER_MC44S803 is not set
CONFIG_MEDIA_TUNER_MAX2165=y
CONFIG_MEDIA_TUNER_TDA18218=y
CONFIG_MEDIA_TUNER_FC0011=y
# CONFIG_MEDIA_TUNER_FC0012 is not set
CONFIG_MEDIA_TUNER_FC0013=y
CONFIG_MEDIA_TUNER_TDA18212=y
CONFIG_MEDIA_TUNER_E4000=y
# CONFIG_MEDIA_TUNER_FC2580 is not set
# CONFIG_MEDIA_TUNER_M88RS6000T is not set
CONFIG_MEDIA_TUNER_TUA9001=y
CONFIG_MEDIA_TUNER_SI2157=y
CONFIG_MEDIA_TUNER_IT913X=y
CONFIG_MEDIA_TUNER_R820T=y
# CONFIG_MEDIA_TUNER_MXL301RF is not set
CONFIG_MEDIA_TUNER_QM1D1C0042=y
# CONFIG_MEDIA_TUNER_QM1D1B0004 is not set
# end of Customize TV tuners

#
# Customise DVB Frontends
#

#
# Multistandard (satellite) frontends
#
# CONFIG_DVB_STB0899 is not set
# CONFIG_DVB_STB6100 is not set
CONFIG_DVB_STV090x=y
CONFIG_DVB_STV0910=y
# CONFIG_DVB_STV6110x is not set
CONFIG_DVB_STV6111=y
# CONFIG_DVB_MXL5XX is not set
# CONFIG_DVB_M88DS3103 is not set

#
# Multistandard (cable + terrestrial) frontends
#
# CONFIG_DVB_DRXK is not set
# CONFIG_DVB_TDA18271C2DD is not set
CONFIG_DVB_SI2165=y
CONFIG_DVB_MN88472=y
CONFIG_DVB_MN88473=y

#
# DVB-S (satellite) frontends
#
# CONFIG_DVB_CX24110 is not set
CONFIG_DVB_CX24123=y
CONFIG_DVB_MT312=y
# CONFIG_DVB_ZL10036 is not set
# CONFIG_DVB_ZL10039 is not set
CONFIG_DVB_S5H1420=y
CONFIG_DVB_STV0288=y
CONFIG_DVB_STB6000=y
# CONFIG_DVB_STV0299 is not set
# CONFIG_DVB_STV6110 is not set
# CONFIG_DVB_STV0900 is not set
CONFIG_DVB_TDA8083=y
CONFIG_DVB_TDA10086=y
# CONFIG_DVB_TDA8261 is not set
CONFIG_DVB_VES1X93=y
CONFIG_DVB_TUNER_ITD1000=y
CONFIG_DVB_TUNER_CX24113=y
# CONFIG_DVB_TDA826X is not set
CONFIG_DVB_TUA6100=y
CONFIG_DVB_CX24116=y
CONFIG_DVB_CX24117=y
# CONFIG_DVB_CX24120 is not set
CONFIG_DVB_SI21XX=y
CONFIG_DVB_TS2020=y
CONFIG_DVB_DS3000=y
CONFIG_DVB_MB86A16=y
# CONFIG_DVB_TDA10071 is not set

#
# DVB-T (terrestrial) frontends
#
CONFIG_DVB_SP8870=y
CONFIG_DVB_SP887X=y
# CONFIG_DVB_CX22700 is not set
# CONFIG_DVB_CX22702 is not set
CONFIG_DVB_S5H1432=y
CONFIG_DVB_DRXD=y
CONFIG_DVB_L64781=y
CONFIG_DVB_TDA1004X=y
# CONFIG_DVB_NXT6000 is not set
# CONFIG_DVB_MT352 is not set
CONFIG_DVB_ZL10353=y
CONFIG_DVB_DIB3000MB=y
CONFIG_DVB_DIB3000MC=y
# CONFIG_DVB_DIB7000M is not set
# CONFIG_DVB_DIB7000P is not set
CONFIG_DVB_DIB9000=y
CONFIG_DVB_TDA10048=y
# CONFIG_DVB_AF9013 is not set
# CONFIG_DVB_EC100 is not set
CONFIG_DVB_STV0367=y
CONFIG_DVB_CXD2820R=y
CONFIG_DVB_CXD2841ER=y
# CONFIG_DVB_RTL2830 is not set
# CONFIG_DVB_RTL2832 is not set
# CONFIG_DVB_RTL2832_SDR is not set
CONFIG_DVB_SI2168=y
CONFIG_DVB_AS102_FE=y
CONFIG_DVB_ZD1301_DEMOD=y
CONFIG_DVB_CXD2880=y

#
# DVB-C (cable) frontends
#
CONFIG_DVB_VES1820=y
# CONFIG_DVB_TDA10021 is not set
CONFIG_DVB_TDA10023=y
CONFIG_DVB_STV0297=y

#
# ATSC (North American/Korean Terrestrial/Cable DTV) frontends
#
CONFIG_DVB_NXT200X=y
CONFIG_DVB_OR51211=y
CONFIG_DVB_OR51132=y
# CONFIG_DVB_BCM3510 is not set
# CONFIG_DVB_LGDT330X is not set
CONFIG_DVB_LGDT3305=y
CONFIG_DVB_LGDT3306A=y
# CONFIG_DVB_LG2160 is not set
CONFIG_DVB_S5H1409=y
CONFIG_DVB_AU8522=y
CONFIG_DVB_AU8522_DTV=y
# CONFIG_DVB_AU8522_V4L is not set
CONFIG_DVB_S5H1411=y

#
# ISDB-T (terrestrial) frontends
#
CONFIG_DVB_S921=y
CONFIG_DVB_DIB8000=y
CONFIG_DVB_MB86A20S=y

#
# ISDB-S (satellite) & ISDB-T (terrestrial) frontends
#
# CONFIG_DVB_TC90522 is not set
# CONFIG_DVB_MN88443X is not set

#
# Digital terrestrial only tuners/PLL
#
CONFIG_DVB_PLL=y
# CONFIG_DVB_TUNER_DIB0070 is not set
CONFIG_DVB_TUNER_DIB0090=y

#
# SEC control devices for DVB-S
#
CONFIG_DVB_DRX39XYJ=y
CONFIG_DVB_LNBH25=y
CONFIG_DVB_LNBH29=y
CONFIG_DVB_LNBP21=y
CONFIG_DVB_LNBP22=y
CONFIG_DVB_ISL6405=y
CONFIG_DVB_ISL6421=y
CONFIG_DVB_ISL6423=y
CONFIG_DVB_A8293=y
CONFIG_DVB_LGS8GL5=y
CONFIG_DVB_LGS8GXX=y
# CONFIG_DVB_ATBM8830 is not set
# CONFIG_DVB_TDA665x is not set
# CONFIG_DVB_IX2505V is not set
CONFIG_DVB_M88RS2000=y
CONFIG_DVB_AF9033=y
# CONFIG_DVB_HORUS3A is not set
CONFIG_DVB_ASCOT2E=y
# CONFIG_DVB_HELENE is not set

#
# Common Interface (EN50221) controller drivers
#
CONFIG_DVB_CXD2099=y
CONFIG_DVB_SP2=y
# end of Customise DVB Frontends

#
# Tools to develop new frontends
#
CONFIG_DVB_DUMMY_FE=y
# end of Media ancillary drivers

#
# Graphics support
#
# CONFIG_AGP is not set
CONFIG_VGA_ARB=y
CONFIG_VGA_ARB_MAX_GPUS=16
# CONFIG_VGA_SWITCHEROO is not set
CONFIG_DRM=y
CONFIG_DRM_MIPI_DBI=y
CONFIG_DRM_MIPI_DSI=y
CONFIG_DRM_DP_AUX_CHARDEV=y
# CONFIG_DRM_DEBUG_MM is not set
CONFIG_DRM_DEBUG_SELFTEST=y
CONFIG_DRM_KMS_HELPER=y
CONFIG_DRM_KMS_FB_HELPER=y
CONFIG_DRM_DEBUG_DP_MST_TOPOLOGY_REFS=y
# CONFIG_DRM_FBDEV_EMULATION is not set
# CONFIG_DRM_LOAD_EDID_FIRMWARE is not set
CONFIG_DRM_DP_CEC=y
CONFIG_DRM_GEM_CMA_HELPER=y
CONFIG_DRM_KMS_CMA_HELPER=y
CONFIG_DRM_GEM_SHMEM_HELPER=y
CONFIG_DRM_VM=y
CONFIG_DRM_SCHED=y

#
# I2C encoder or helper chips
#
CONFIG_DRM_I2C_CH7006=y
CONFIG_DRM_I2C_SIL164=y
# CONFIG_DRM_I2C_NXP_TDA998X is not set
CONFIG_DRM_I2C_NXP_TDA9950=y
# end of I2C encoder or helper chips

#
# ARM devices
#
# CONFIG_DRM_KOMEDA is not set
# end of ARM devices

# CONFIG_DRM_RADEON is not set
# CONFIG_DRM_AMDGPU is not set
# CONFIG_DRM_NOUVEAU is not set
# CONFIG_DRM_I915 is not set
CONFIG_DRM_VGEM=y
# CONFIG_DRM_VKMS is not set
# CONFIG_DRM_VMWGFX is not set
# CONFIG_DRM_GMA500 is not set
CONFIG_DRM_UDL=y
# CONFIG_DRM_AST is not set
# CONFIG_DRM_MGAG200 is not set
# CONFIG_DRM_RCAR_DW_HDMI is not set
# CONFIG_DRM_RCAR_LVDS is not set
# CONFIG_DRM_QXL is not set
# CONFIG_DRM_BOCHS is not set
# CONFIG_DRM_VIRTIO_GPU is not set
CONFIG_DRM_PANEL=y

#
# Display Panels
#
CONFIG_DRM_PANEL_ARM_VERSATILE=y
CONFIG_DRM_PANEL_ASUS_Z00T_TM5P5_NT35596=y
CONFIG_DRM_PANEL_BOE_HIMAX8279D=y
CONFIG_DRM_PANEL_BOE_TV101WUM_NL6=y
CONFIG_DRM_PANEL_LVDS=y
CONFIG_DRM_PANEL_SIMPLE=y
# CONFIG_DRM_PANEL_ELIDA_KD35T133 is not set
CONFIG_DRM_PANEL_FEIXIN_K101_IM2BA02=y
# CONFIG_DRM_PANEL_FEIYANG_FY07024DI26A30D is not set
CONFIG_DRM_PANEL_ILITEK_IL9322=y
CONFIG_DRM_PANEL_ILITEK_ILI9881C=y
# CONFIG_DRM_PANEL_INNOLUX_P079ZCA is not set
CONFIG_DRM_PANEL_JDI_LT070ME05000=y
CONFIG_DRM_PANEL_KINGDISPLAY_KD097D04=y
CONFIG_DRM_PANEL_LEADTEK_LTK050H3146W=y
CONFIG_DRM_PANEL_LEADTEK_LTK500HD1829=y
CONFIG_DRM_PANEL_SAMSUNG_LD9040=y
# CONFIG_DRM_PANEL_LG_LB035Q02 is not set
CONFIG_DRM_PANEL_LG_LG4573=y
CONFIG_DRM_PANEL_NEC_NL8048HL11=y
# CONFIG_DRM_PANEL_NOVATEK_NT35510 is not set
CONFIG_DRM_PANEL_NOVATEK_NT39016=y
CONFIG_DRM_PANEL_OLIMEX_LCD_OLINUXINO=y
# CONFIG_DRM_PANEL_ORISETECH_OTM8009A is not set
# CONFIG_DRM_PANEL_OSD_OSD101T2587_53TS is not set
# CONFIG_DRM_PANEL_PANASONIC_VVX10F034N00 is not set
CONFIG_DRM_PANEL_RASPBERRYPI_TOUCHSCREEN=y
CONFIG_DRM_PANEL_RAYDIUM_RM67191=y
CONFIG_DRM_PANEL_RAYDIUM_RM68200=y
CONFIG_DRM_PANEL_RONBO_RB070D30=y
CONFIG_DRM_PANEL_SAMSUNG_S6D16D0=y
CONFIG_DRM_PANEL_SAMSUNG_S6E3HA2=y
CONFIG_DRM_PANEL_SAMSUNG_S6E63J0X03=y
CONFIG_DRM_PANEL_SAMSUNG_S6E63M0=y
# CONFIG_DRM_PANEL_SAMSUNG_S6E88A0_AMS452EF01 is not set
CONFIG_DRM_PANEL_SAMSUNG_S6E8AA0=y
# CONFIG_DRM_PANEL_SEIKO_43WVF1G is not set
CONFIG_DRM_PANEL_SHARP_LQ101R1SX01=y
# CONFIG_DRM_PANEL_SHARP_LS037V7DW01 is not set
# CONFIG_DRM_PANEL_SHARP_LS043T1LE01 is not set
# CONFIG_DRM_PANEL_SITRONIX_ST7701 is not set
CONFIG_DRM_PANEL_SITRONIX_ST7703=y
CONFIG_DRM_PANEL_SITRONIX_ST7789V=y
CONFIG_DRM_PANEL_SONY_ACX424AKP=y
CONFIG_DRM_PANEL_SONY_ACX565AKM=y
CONFIG_DRM_PANEL_TPO_TD028TTEC1=y
CONFIG_DRM_PANEL_TPO_TD043MTEA1=y
CONFIG_DRM_PANEL_TPO_TPG110=y
CONFIG_DRM_PANEL_TRULY_NT35597_WQXGA=y
# CONFIG_DRM_PANEL_VISIONOX_RM69299 is not set
CONFIG_DRM_PANEL_XINPENG_XPP055C272=y
# end of Display Panels

CONFIG_DRM_BRIDGE=y
CONFIG_DRM_PANEL_BRIDGE=y

#
# Display Interface Bridges
#
# CONFIG_DRM_CDNS_DSI is not set
CONFIG_DRM_CHRONTEL_CH7033=y
CONFIG_DRM_DISPLAY_CONNECTOR=y
CONFIG_DRM_LVDS_CODEC=y
CONFIG_DRM_MEGACHIPS_STDPXXXX_GE_B850V3_FW=y
CONFIG_DRM_NWL_MIPI_DSI=y
CONFIG_DRM_NXP_PTN3460=y
CONFIG_DRM_PARADE_PS8622=y
CONFIG_DRM_PARADE_PS8640=y
# CONFIG_DRM_SIL_SII8620 is not set
CONFIG_DRM_SII902X=y
CONFIG_DRM_SII9234=y
CONFIG_DRM_SIMPLE_BRIDGE=y
# CONFIG_DRM_THINE_THC63LVD1024 is not set
# CONFIG_DRM_TOSHIBA_TC358764 is not set
CONFIG_DRM_TOSHIBA_TC358767=y
# CONFIG_DRM_TOSHIBA_TC358768 is not set
CONFIG_DRM_TI_TFP410=y
CONFIG_DRM_TI_SN65DSI86=y
CONFIG_DRM_TI_TPD12S015=y
CONFIG_DRM_ANALOGIX_ANX6345=y
# CONFIG_DRM_ANALOGIX_ANX78XX is not set
CONFIG_DRM_ANALOGIX_DP=y
CONFIG_DRM_I2C_ADV7511=y
CONFIG_DRM_I2C_ADV7511_CEC=y
# end of Display Interface Bridges

CONFIG_DRM_ETNAVIV=y
# CONFIG_DRM_ETNAVIV_THERMAL is not set
CONFIG_DRM_ARCPGU=y
CONFIG_DRM_MXS=y
CONFIG_DRM_MXSFB=y
# CONFIG_DRM_CIRRUS_QEMU is not set
CONFIG_DRM_GM12U320=y
CONFIG_TINYDRM_HX8357D=y
CONFIG_TINYDRM_ILI9225=y
# CONFIG_TINYDRM_ILI9341 is not set
CONFIG_TINYDRM_ILI9486=y
CONFIG_TINYDRM_MI0283QT=y
CONFIG_TINYDRM_REPAPER=y
# CONFIG_TINYDRM_ST7586 is not set
# CONFIG_TINYDRM_ST7735R is not set
# CONFIG_DRM_VBOXVIDEO is not set
CONFIG_DRM_LEGACY=y
# CONFIG_DRM_TDFX is not set
# CONFIG_DRM_R128 is not set
# CONFIG_DRM_MGA is not set
# CONFIG_DRM_VIA is not set
# CONFIG_DRM_SAVAGE is not set
CONFIG_DRM_EXPORT_FOR_TESTS=y
CONFIG_DRM_PANEL_ORIENTATION_QUIRKS=y
CONFIG_DRM_LIB_RANDOM=y

#
# Frame buffer Devices
#
CONFIG_FB_CMDLINE=y
CONFIG_FB_NOTIFY=y
CONFIG_FB=y
# CONFIG_FIRMWARE_EDID is not set
CONFIG_FB_CFB_FILLRECT=y
CONFIG_FB_CFB_COPYAREA=y
CONFIG_FB_CFB_IMAGEBLIT=y
CONFIG_FB_SYS_FILLRECT=y
CONFIG_FB_SYS_COPYAREA=y
CONFIG_FB_SYS_IMAGEBLIT=y
CONFIG_FB_FOREIGN_ENDIAN=y
# CONFIG_FB_BOTH_ENDIAN is not set
CONFIG_FB_BIG_ENDIAN=y
# CONFIG_FB_LITTLE_ENDIAN is not set
CONFIG_FB_SYS_FOPS=y
CONFIG_FB_DEFERRED_IO=y
CONFIG_FB_HECUBA=y
CONFIG_FB_BACKLIGHT=y
CONFIG_FB_MODE_HELPERS=y
CONFIG_FB_TILEBLITTING=y

#
# Frame buffer hardware drivers
#
# CONFIG_FB_CIRRUS is not set
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CYBER2000 is not set
CONFIG_FB_ARC=y
# CONFIG_FB_ASILIANT is not set
# CONFIG_FB_IMSTT is not set
# CONFIG_FB_VGA16 is not set
# CONFIG_FB_UVESA is not set
# CONFIG_FB_VESA is not set
# CONFIG_FB_EFI is not set
CONFIG_FB_N411=y
# CONFIG_FB_HGA is not set
CONFIG_FB_OPENCORES=y
CONFIG_FB_S1D13XXX=y
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
# CONFIG_FB_GEODE is not set
CONFIG_FB_SMSCUFX=y
CONFIG_FB_UDL=y
# CONFIG_FB_IBM_GXT4500 is not set
CONFIG_FB_GOLDFISH=y
CONFIG_FB_VIRTUAL=y
# CONFIG_FB_METRONOME is not set
# CONFIG_FB_MB862XX is not set
# CONFIG_FB_HYPERV is not set
# CONFIG_FB_SIMPLE is not set
CONFIG_FB_SSD1307=y
# CONFIG_FB_SM712 is not set
# end of Frame buffer Devices

#
# Backlight & LCD device support
#
CONFIG_LCD_CLASS_DEVICE=y
# CONFIG_LCD_L4F00242T03 is not set
CONFIG_LCD_LMS283GF05=y
CONFIG_LCD_LTV350QV=y
CONFIG_LCD_ILI922X=y
CONFIG_LCD_ILI9320=y
CONFIG_LCD_TDO24M=y
# CONFIG_LCD_VGG2432A4 is not set
CONFIG_LCD_PLATFORM=y
CONFIG_LCD_AMS369FG06=y
CONFIG_LCD_LMS501KF03=y
# CONFIG_LCD_HX8357 is not set
CONFIG_LCD_OTM3225A=y
CONFIG_BACKLIGHT_CLASS_DEVICE=y
CONFIG_BACKLIGHT_LM3533=y
# CONFIG_BACKLIGHT_PWM is not set
CONFIG_BACKLIGHT_DA9052=y
# CONFIG_BACKLIGHT_APPLE is not set
CONFIG_BACKLIGHT_QCOM_WLED=y
CONFIG_BACKLIGHT_SAHARA=y
# CONFIG_BACKLIGHT_ADP8860 is not set
CONFIG_BACKLIGHT_ADP8870=y
CONFIG_BACKLIGHT_PCF50633=y
# CONFIG_BACKLIGHT_LM3630A is not set
# CONFIG_BACKLIGHT_LM3639 is not set
# CONFIG_BACKLIGHT_LP855X is not set
CONFIG_BACKLIGHT_LP8788=y
CONFIG_BACKLIGHT_SKY81452=y
CONFIG_BACKLIGHT_TPS65217=y
CONFIG_BACKLIGHT_GPIO=y
# CONFIG_BACKLIGHT_LV5207LP is not set
CONFIG_BACKLIGHT_BD6107=y
CONFIG_BACKLIGHT_ARCXCNN=y
# CONFIG_BACKLIGHT_LED is not set
# end of Backlight & LCD device support

CONFIG_VIDEOMODE_HELPERS=y
CONFIG_HDMI=y
# CONFIG_LOGO is not set
# end of Graphics support

# CONFIG_SOUND is not set

#
# HID support
#
CONFIG_HID=y
CONFIG_HID_BATTERY_STRENGTH=y
CONFIG_HIDRAW=y
# CONFIG_UHID is not set
CONFIG_HID_GENERIC=y

#
# Special HID drivers
#
# CONFIG_HID_A4TECH is not set
CONFIG_HID_ACRUX=y
CONFIG_HID_ACRUX_FF=y
# CONFIG_HID_APPLE is not set
CONFIG_HID_AUREAL=y
CONFIG_HID_BELKIN=y
# CONFIG_HID_CHERRY is not set
CONFIG_HID_CHICONY=y
# CONFIG_HID_CORSAIR is not set
CONFIG_HID_COUGAR=y
CONFIG_HID_MACALLY=y
CONFIG_HID_CMEDIA=y
CONFIG_HID_CYPRESS=y
CONFIG_HID_DRAGONRISE=y
# CONFIG_DRAGONRISE_FF is not set
CONFIG_HID_EMS_FF=y
CONFIG_HID_ELECOM=y
CONFIG_HID_EZKEY=y
CONFIG_HID_GEMBIRD=y
CONFIG_HID_GFRM=y
# CONFIG_HID_GLORIOUS is not set
CONFIG_HID_KEYTOUCH=y
CONFIG_HID_KYE=y
CONFIG_HID_WALTOP=y
CONFIG_HID_VIEWSONIC=y
CONFIG_HID_GYRATION=y
CONFIG_HID_ICADE=y
CONFIG_HID_ITE=y
CONFIG_HID_JABRA=y
# CONFIG_HID_TWINHAN is not set
# CONFIG_HID_KENSINGTON is not set
# CONFIG_HID_LCPOWER is not set
# CONFIG_HID_LED is not set
CONFIG_HID_LENOVO=y
# CONFIG_HID_LOGITECH is not set
CONFIG_HID_MAGICMOUSE=y
CONFIG_HID_MALTRON=y
# CONFIG_HID_MAYFLASH is not set
# CONFIG_HID_REDRAGON is not set
CONFIG_HID_MICROSOFT=y
CONFIG_HID_MONTEREY=y
# CONFIG_HID_MULTITOUCH is not set
# CONFIG_HID_NTI is not set
CONFIG_HID_ORTEK=y
CONFIG_HID_PANTHERLORD=y
CONFIG_PANTHERLORD_FF=y
CONFIG_HID_PETALYNX=y
# CONFIG_HID_PICOLCD is not set
# CONFIG_HID_PLANTRONICS is not set
CONFIG_HID_PRIMAX=y
# CONFIG_HID_SAITEK is not set
# CONFIG_HID_SAMSUNG is not set
CONFIG_HID_SPEEDLINK=y
CONFIG_HID_STEAM=y
CONFIG_HID_STEELSERIES=y
# CONFIG_HID_SUNPLUS is not set
CONFIG_HID_RMI=y
# CONFIG_HID_GREENASIA is not set
# CONFIG_HID_HYPERV_MOUSE is not set
CONFIG_HID_SMARTJOYPLUS=y
# CONFIG_SMARTJOYPLUS_FF is not set
# CONFIG_HID_TIVO is not set
CONFIG_HID_TOPSEED=y
# CONFIG_HID_THINGM is not set
CONFIG_HID_THRUSTMASTER=y
# CONFIG_THRUSTMASTER_FF is not set
# CONFIG_HID_UDRAW_PS3 is not set
CONFIG_HID_WIIMOTE=y
CONFIG_HID_XINMO=y
CONFIG_HID_ZEROPLUS=y
CONFIG_ZEROPLUS_FF=y
# CONFIG_HID_ZYDACRON is not set
CONFIG_HID_SENSOR_HUB=y
CONFIG_HID_SENSOR_CUSTOM_SENSOR=y
# CONFIG_HID_ALPS is not set
# end of Special HID drivers

#
# USB HID support
#
# CONFIG_USB_HID is not set
# CONFIG_HID_PID is not set

#
# USB HID Boot Protocol drivers
#
CONFIG_USB_KBD=y
# CONFIG_USB_MOUSE is not set
# end of USB HID Boot Protocol drivers
# end of USB HID support

#
# I2C HID support
#
CONFIG_I2C_HID=y
# end of I2C HID support
# end of HID support

CONFIG_USB_OHCI_LITTLE_ENDIAN=y
CONFIG_USB_SUPPORT=y
CONFIG_USB_COMMON=y
CONFIG_USB_LED_TRIG=y
CONFIG_USB_ULPI_BUS=y
CONFIG_USB_CONN_GPIO=y
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB=y
CONFIG_USB_PCI=y
# CONFIG_USB_ANNOUNCE_NEW_DEVICES is not set

#
# Miscellaneous USB options
#
# CONFIG_USB_DEFAULT_PERSIST is not set
CONFIG_USB_DYNAMIC_MINORS=y
# CONFIG_USB_OTG is not set
CONFIG_USB_OTG_PRODUCTLIST=y
# CONFIG_USB_OTG_DISABLE_EXTERNAL_HUB is not set
CONFIG_USB_LEDS_TRIGGER_USBPORT=y
CONFIG_USB_AUTOSUSPEND_DELAY=2
# CONFIG_USB_MON is not set

#
# USB Host Controller Drivers
#
CONFIG_USB_C67X00_HCD=y
CONFIG_USB_XHCI_HCD=y
# CONFIG_USB_XHCI_DBGCAP is not set
CONFIG_USB_XHCI_PCI=y
CONFIG_USB_XHCI_PCI_RENESAS=y
CONFIG_USB_XHCI_PLATFORM=y
CONFIG_USB_EHCI_HCD=y
CONFIG_USB_EHCI_ROOT_HUB_TT=y
# CONFIG_USB_EHCI_TT_NEWSCHED is not set
CONFIG_USB_EHCI_PCI=y
CONFIG_USB_EHCI_FSL=y
CONFIG_USB_EHCI_HCD_PLATFORM=y
CONFIG_USB_OXU210HP_HCD=y
CONFIG_USB_ISP116X_HCD=y
# CONFIG_USB_FOTG210_HCD is not set
CONFIG_USB_MAX3421_HCD=y
CONFIG_USB_OHCI_HCD=y
CONFIG_USB_OHCI_HCD_PCI=y
CONFIG_USB_OHCI_HCD_SSB=y
CONFIG_USB_OHCI_HCD_PLATFORM=y
# CONFIG_USB_UHCI_HCD is not set
CONFIG_USB_U132_HCD=y
# CONFIG_USB_SL811_HCD is not set
# CONFIG_USB_R8A66597_HCD is not set
CONFIG_USB_HCD_SSB=y
CONFIG_USB_HCD_TEST_MODE=y

#
# USB Device Class drivers
#
# CONFIG_USB_ACM is not set
CONFIG_USB_PRINTER=y
# CONFIG_USB_WDM is not set
CONFIG_USB_TMC=y

#
# NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
#

#
# also be needed; see USB_STORAGE Help for more info
#

#
# USB Imaging devices
#
CONFIG_USB_MDC800=y
# CONFIG_USBIP_CORE is not set
CONFIG_USB_CDNS3=y
CONFIG_USB_CDNS3_HOST=y
CONFIG_USB_CDNS3_PCI_WRAP=y
CONFIG_USB_MUSB_HDRC=y
CONFIG_USB_MUSB_HOST=y

#
# Platform Glue Layer
#

#
# MUSB DMA mode
#
CONFIG_MUSB_PIO_ONLY=y
CONFIG_USB_DWC3=y
# CONFIG_USB_DWC3_ULPI is not set
CONFIG_USB_DWC3_HOST=y

#
# Platform Glue Driver Support
#
CONFIG_USB_DWC3_PCI=y
CONFIG_USB_DWC3_HAPS=y
# CONFIG_USB_DWC3_OF_SIMPLE is not set
# CONFIG_USB_DWC2 is not set
CONFIG_USB_CHIPIDEA=y
# CONFIG_USB_CHIPIDEA_HOST is not set
CONFIG_USB_CHIPIDEA_MSM=y
CONFIG_USB_CHIPIDEA_IMX=y
CONFIG_USB_CHIPIDEA_GENERIC=y
# CONFIG_USB_ISP1760 is not set

#
# USB port drivers
#
# CONFIG_USB_USS720 is not set
# CONFIG_USB_SERIAL is not set

#
# USB Miscellaneous drivers
#
CONFIG_USB_EMI62=y
# CONFIG_USB_EMI26 is not set
# CONFIG_USB_ADUTUX is not set
CONFIG_USB_SEVSEG=y
CONFIG_USB_LEGOTOWER=y
CONFIG_USB_LCD=y
CONFIG_USB_CYPRESS_CY7C63=y
CONFIG_USB_CYTHERM=y
# CONFIG_USB_IDMOUSE is not set
CONFIG_USB_FTDI_ELAN=y
CONFIG_USB_APPLEDISPLAY=y
# CONFIG_APPLE_MFI_FASTCHARGE is not set
CONFIG_USB_SISUSBVGA=y
CONFIG_USB_LD=y
# CONFIG_USB_TRANCEVIBRATOR is not set
CONFIG_USB_IOWARRIOR=y
# CONFIG_USB_TEST is not set
# CONFIG_USB_EHSET_TEST_FIXTURE is not set
# CONFIG_USB_ISIGHTFW is not set
CONFIG_USB_YUREX=y
CONFIG_USB_EZUSB_FX2=y
# CONFIG_USB_HUB_USB251XB is not set
CONFIG_USB_HSIC_USB3503=y
# CONFIG_USB_HSIC_USB4604 is not set
CONFIG_USB_LINK_LAYER_TEST=y
CONFIG_USB_CHAOSKEY=y
# CONFIG_USB_ATM is not set

#
# USB Physical Layer drivers
#
# CONFIG_NOP_USB_XCEIV is not set
# CONFIG_USB_GPIO_VBUS is not set
# CONFIG_USB_ISP1301 is not set
# end of USB Physical Layer drivers

# CONFIG_USB_GADGET is not set
# CONFIG_TYPEC is not set
CONFIG_USB_ROLE_SWITCH=y
CONFIG_USB_ROLES_INTEL_XHCI=y
# CONFIG_MMC is not set
# CONFIG_MEMSTICK is not set
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y
# CONFIG_LEDS_CLASS_FLASH is not set
# CONFIG_LEDS_CLASS_MULTICOLOR is not set
CONFIG_LEDS_BRIGHTNESS_HW_CHANGED=y

#
# LED drivers
#
CONFIG_LEDS_AN30259A=y
CONFIG_LEDS_APU=y
# CONFIG_LEDS_AW2013 is not set
# CONFIG_LEDS_BCM6328 is not set
CONFIG_LEDS_BCM6358=y
CONFIG_LEDS_CPCAP=y
# CONFIG_LEDS_CR0014114 is not set
CONFIG_LEDS_EL15203000=y
# CONFIG_LEDS_LM3530 is not set
# CONFIG_LEDS_LM3532 is not set
CONFIG_LEDS_LM3533=y
CONFIG_LEDS_LM3642=y
# CONFIG_LEDS_LM3692X is not set
CONFIG_LEDS_MT6323=y
CONFIG_LEDS_NET48XX=y
CONFIG_LEDS_WRAP=y
CONFIG_LEDS_PCA9532=y
# CONFIG_LEDS_PCA9532_GPIO is not set
# CONFIG_LEDS_GPIO is not set
# CONFIG_LEDS_LP3944 is not set
# CONFIG_LEDS_LP3952 is not set
CONFIG_LEDS_LP55XX_COMMON=y
CONFIG_LEDS_LP5521=y
CONFIG_LEDS_LP5523=y
CONFIG_LEDS_LP5562=y
CONFIG_LEDS_LP8501=y
CONFIG_LEDS_LP8788=y
CONFIG_LEDS_LP8860=y
CONFIG_LEDS_CLEVO_MAIL=y
# CONFIG_LEDS_PCA955X is not set
# CONFIG_LEDS_PCA963X is not set
CONFIG_LEDS_WM8350=y
# CONFIG_LEDS_DA9052 is not set
CONFIG_LEDS_DAC124S085=y
# CONFIG_LEDS_PWM is not set
# CONFIG_LEDS_REGULATOR is not set
CONFIG_LEDS_BD2802=y
# CONFIG_LEDS_INTEL_SS4200 is not set
# CONFIG_LEDS_LT3593 is not set
CONFIG_LEDS_MC13783=y
# CONFIG_LEDS_TCA6507 is not set
# CONFIG_LEDS_TLC591XX is not set
# CONFIG_LEDS_MAX77650 is not set
CONFIG_LEDS_LM355x=y
# CONFIG_LEDS_OT200 is not set
# CONFIG_LEDS_MENF21BMC is not set
CONFIG_LEDS_IS31FL319X=y
CONFIG_LEDS_IS31FL32XX=y

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
#
CONFIG_LEDS_BLINKM=y
# CONFIG_LEDS_SYSCON is not set
CONFIG_LEDS_MLXCPLD=y
# CONFIG_LEDS_MLXREG is not set
# CONFIG_LEDS_USER is not set
CONFIG_LEDS_NIC78BX=y
CONFIG_LEDS_SPI_BYTE=y
CONFIG_LEDS_TI_LMU_COMMON=y
CONFIG_LEDS_LM3697=y
# CONFIG_LEDS_TPS6105X is not set

#
# LED Triggers
#
CONFIG_LEDS_TRIGGERS=y
# CONFIG_LEDS_TRIGGER_TIMER is not set
CONFIG_LEDS_TRIGGER_ONESHOT=y
# CONFIG_LEDS_TRIGGER_MTD is not set
CONFIG_LEDS_TRIGGER_HEARTBEAT=y
# CONFIG_LEDS_TRIGGER_BACKLIGHT is not set
CONFIG_LEDS_TRIGGER_CPU=y
# CONFIG_LEDS_TRIGGER_ACTIVITY is not set
CONFIG_LEDS_TRIGGER_GPIO=y
CONFIG_LEDS_TRIGGER_DEFAULT_ON=y

#
# iptables trigger is under Netfilter config (LED target)
#
CONFIG_LEDS_TRIGGER_TRANSIENT=y
CONFIG_LEDS_TRIGGER_CAMERA=y
# CONFIG_LEDS_TRIGGER_PANIC is not set
CONFIG_LEDS_TRIGGER_NETDEV=y
CONFIG_LEDS_TRIGGER_PATTERN=y
CONFIG_LEDS_TRIGGER_AUDIO=y
# CONFIG_ACCESSIBILITY is not set
# CONFIG_INFINIBAND is not set
CONFIG_EDAC_ATOMIC_SCRUB=y
CONFIG_EDAC_SUPPORT=y
CONFIG_EDAC=y
CONFIG_EDAC_LEGACY_SYSFS=y
CONFIG_EDAC_DEBUG=y
# CONFIG_EDAC_AMD76X is not set
# CONFIG_EDAC_E7XXX is not set
# CONFIG_EDAC_E752X is not set
# CONFIG_EDAC_I82875P is not set
# CONFIG_EDAC_I82975X is not set
# CONFIG_EDAC_I3000 is not set
# CONFIG_EDAC_I3200 is not set
# CONFIG_EDAC_IE31200 is not set
# CONFIG_EDAC_X38 is not set
# CONFIG_EDAC_I5400 is not set
# CONFIG_EDAC_I82860 is not set
# CONFIG_EDAC_R82600 is not set
# CONFIG_EDAC_I5000 is not set
# CONFIG_EDAC_I5100 is not set
# CONFIG_EDAC_I7300 is not set
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
# CONFIG_RTC_INTF_SYSFS is not set
CONFIG_RTC_INTF_PROC=y
CONFIG_RTC_INTF_DEV=y
CONFIG_RTC_INTF_DEV_UIE_EMUL=y
# CONFIG_RTC_DRV_TEST is not set

#
# I2C RTC drivers
#
# CONFIG_RTC_DRV_88PM80X is not set
CONFIG_RTC_DRV_ABB5ZES3=y
CONFIG_RTC_DRV_ABEOZ9=y
CONFIG_RTC_DRV_ABX80X=y
# CONFIG_RTC_DRV_AS3722 is not set
CONFIG_RTC_DRV_DS1307=y
# CONFIG_RTC_DRV_DS1307_CENTURY is not set
# CONFIG_RTC_DRV_DS1374 is not set
# CONFIG_RTC_DRV_DS1672 is not set
CONFIG_RTC_DRV_HYM8563=y
# CONFIG_RTC_DRV_LP8788 is not set
CONFIG_RTC_DRV_MAX6900=y
# CONFIG_RTC_DRV_MAX8998 is not set
CONFIG_RTC_DRV_MAX77686=y
CONFIG_RTC_DRV_RK808=y
CONFIG_RTC_DRV_RS5C372=y
CONFIG_RTC_DRV_ISL1208=y
# CONFIG_RTC_DRV_ISL12022 is not set
# CONFIG_RTC_DRV_ISL12026 is not set
# CONFIG_RTC_DRV_X1205 is not set
CONFIG_RTC_DRV_PCF8523=y
CONFIG_RTC_DRV_PCF85063=y
CONFIG_RTC_DRV_PCF85363=y
CONFIG_RTC_DRV_PCF8563=y
# CONFIG_RTC_DRV_PCF8583 is not set
# CONFIG_RTC_DRV_M41T80 is not set
# CONFIG_RTC_DRV_BD70528 is not set
# CONFIG_RTC_DRV_BQ32K is not set
# CONFIG_RTC_DRV_TPS6586X is not set
CONFIG_RTC_DRV_TPS65910=y
# CONFIG_RTC_DRV_TPS80031 is not set
# CONFIG_RTC_DRV_RC5T619 is not set
# CONFIG_RTC_DRV_S35390A is not set
CONFIG_RTC_DRV_FM3130=y
CONFIG_RTC_DRV_RX8010=y
CONFIG_RTC_DRV_RX8581=y
CONFIG_RTC_DRV_RX8025=y
CONFIG_RTC_DRV_EM3027=y
CONFIG_RTC_DRV_RV3028=y
# CONFIG_RTC_DRV_RV8803 is not set
CONFIG_RTC_DRV_S5M=y
CONFIG_RTC_DRV_SD3078=y

#
# SPI RTC drivers
#
# CONFIG_RTC_DRV_M41T93 is not set
CONFIG_RTC_DRV_M41T94=y
CONFIG_RTC_DRV_DS1302=y
CONFIG_RTC_DRV_DS1305=y
CONFIG_RTC_DRV_DS1343=y
CONFIG_RTC_DRV_DS1347=y
CONFIG_RTC_DRV_DS1390=y
# CONFIG_RTC_DRV_MAX6916 is not set
CONFIG_RTC_DRV_R9701=y
CONFIG_RTC_DRV_RX4581=y
CONFIG_RTC_DRV_RX6110=y
CONFIG_RTC_DRV_RS5C348=y
# CONFIG_RTC_DRV_MAX6902 is not set
# CONFIG_RTC_DRV_PCF2123 is not set
# CONFIG_RTC_DRV_MCP795 is not set
CONFIG_RTC_I2C_AND_SPI=y

#
# SPI and I2C RTC drivers
#
CONFIG_RTC_DRV_DS3232=y
CONFIG_RTC_DRV_DS3232_HWMON=y
CONFIG_RTC_DRV_PCF2127=y
CONFIG_RTC_DRV_RV3029C2=y
# CONFIG_RTC_DRV_RV3029_HWMON is not set

#
# Platform RTC drivers
#
CONFIG_RTC_DRV_CMOS=y
CONFIG_RTC_DRV_DS1286=y
CONFIG_RTC_DRV_DS1511=y
CONFIG_RTC_DRV_DS1553=y
CONFIG_RTC_DRV_DS1685_FAMILY=y
# CONFIG_RTC_DRV_DS1685 is not set
# CONFIG_RTC_DRV_DS1689 is not set
# CONFIG_RTC_DRV_DS17285 is not set
CONFIG_RTC_DRV_DS17485=y
# CONFIG_RTC_DRV_DS17885 is not set
CONFIG_RTC_DRV_DS1742=y
# CONFIG_RTC_DRV_DS2404 is not set
# CONFIG_RTC_DRV_DA9052 is not set
# CONFIG_RTC_DRV_DA9063 is not set
CONFIG_RTC_DRV_STK17TA8=y
CONFIG_RTC_DRV_M48T86=y
CONFIG_RTC_DRV_M48T35=y
CONFIG_RTC_DRV_M48T59=y
# CONFIG_RTC_DRV_MSM6242 is not set
CONFIG_RTC_DRV_BQ4802=y
CONFIG_RTC_DRV_RP5C01=y
CONFIG_RTC_DRV_V3020=y
CONFIG_RTC_DRV_WM8350=y
CONFIG_RTC_DRV_PCF50633=y
# CONFIG_RTC_DRV_AB3100 is not set
CONFIG_RTC_DRV_ZYNQMP=y
# CONFIG_RTC_DRV_CROS_EC is not set

#
# on-CPU RTC drivers
#
CONFIG_RTC_DRV_CADENCE=y
CONFIG_RTC_DRV_FTRTC010=y
CONFIG_RTC_DRV_PCAP=y
# CONFIG_RTC_DRV_MC13XXX is not set
# CONFIG_RTC_DRV_MT6397 is not set
# CONFIG_RTC_DRV_R7301 is not set
CONFIG_RTC_DRV_CPCAP=y

#
# HID Sensor RTC drivers
#
# CONFIG_RTC_DRV_GOLDFISH is not set
CONFIG_RTC_DRV_WILCO_EC=y
CONFIG_DMADEVICES=y
CONFIG_DMADEVICES_DEBUG=y
# CONFIG_DMADEVICES_VDEBUG is not set

#
# DMA Devices
#
CONFIG_DMA_ENGINE=y
CONFIG_DMA_VIRTUAL_CHANNELS=y
CONFIG_DMA_ACPI=y
CONFIG_DMA_OF=y
CONFIG_ALTERA_MSGDMA=y
CONFIG_DW_AXI_DMAC=y
CONFIG_FSL_EDMA=y
# CONFIG_INTEL_IDMA64 is not set
# CONFIG_PCH_DMA is not set
# CONFIG_PLX_DMA is not set
# CONFIG_XILINX_ZYNQMP_DPDMA is not set
CONFIG_QCOM_HIDMA_MGMT=y
# CONFIG_QCOM_HIDMA is not set
CONFIG_DW_DMAC_CORE=y
CONFIG_DW_DMAC=y
# CONFIG_DW_DMAC_PCI is not set
CONFIG_HSU_DMA=y
# CONFIG_SF_PDMA is not set

#
# DMA Clients
#
CONFIG_ASYNC_TX_DMA=y
# CONFIG_DMATEST is not set

#
# DMABUF options
#
CONFIG_SYNC_FILE=y
# CONFIG_SW_SYNC is not set
# CONFIG_UDMABUF is not set
# CONFIG_DMABUF_MOVE_NOTIFY is not set
# CONFIG_DMABUF_SELFTESTS is not set
CONFIG_DMABUF_HEAPS=y
# CONFIG_DMABUF_HEAPS_SYSTEM is not set
# CONFIG_DMABUF_HEAPS_CMA is not set
# end of DMABUF options

CONFIG_AUXDISPLAY=y
CONFIG_HD44780=y
CONFIG_KS0108=y
CONFIG_KS0108_PORT=0x378
CONFIG_KS0108_DELAY=2
# CONFIG_CFAG12864B is not set
# CONFIG_IMG_ASCII_LCD is not set
# CONFIG_HT16K33 is not set
# CONFIG_PARPORT_PANEL is not set
CONFIG_PANEL_CHANGE_MESSAGE=y
CONFIG_PANEL_BOOT_MESSAGE=""
# CONFIG_CHARLCD_BL_OFF is not set
CONFIG_CHARLCD_BL_ON=y
# CONFIG_CHARLCD_BL_FLASH is not set
# CONFIG_PANEL is not set
CONFIG_CHARLCD=y
CONFIG_UIO=y
# CONFIG_UIO_CIF is not set
# CONFIG_UIO_PDRV_GENIRQ is not set
CONFIG_UIO_DMEM_GENIRQ=y
# CONFIG_UIO_AEC is not set
# CONFIG_UIO_SERCOS3 is not set
# CONFIG_UIO_PCI_GENERIC is not set
# CONFIG_UIO_NETX is not set
# CONFIG_UIO_PRUSS is not set
# CONFIG_UIO_MF624 is not set
CONFIG_UIO_HV_GENERIC=y
# CONFIG_VIRT_DRIVERS is not set
CONFIG_VIRTIO=y
# CONFIG_VIRTIO_MENU is not set
# CONFIG_VDPA is not set
CONFIG_VHOST_IOTLB=y
CONFIG_VHOST=y
CONFIG_VHOST_MENU=y
CONFIG_VHOST_NET=y
CONFIG_VHOST_VSOCK=y
# CONFIG_VHOST_CROSS_ENDIAN_LEGACY is not set

#
# Microsoft Hyper-V guest support
#
CONFIG_HYPERV=y
CONFIG_HYPERV_TIMER=y
CONFIG_HYPERV_UTILS=y
# CONFIG_HYPERV_BALLOON is not set
# end of Microsoft Hyper-V guest support

CONFIG_GREYBUS=y
CONFIG_GREYBUS_ES2=y
CONFIG_STAGING=y
# CONFIG_COMEDI is not set

#
# IIO staging drivers
#

#
# Accelerometers
#
# CONFIG_ADIS16203 is not set
CONFIG_ADIS16240=y
# end of Accelerometers

#
# Analog to digital converters
#
# CONFIG_AD7816 is not set
# CONFIG_AD7280 is not set
# end of Analog to digital converters

#
# Analog digital bi-direction converters
#
CONFIG_ADT7316=y
CONFIG_ADT7316_SPI=y
# CONFIG_ADT7316_I2C is not set
# end of Analog digital bi-direction converters

#
# Capacitance to digital converters
#
CONFIG_AD7150=y
CONFIG_AD7746=y
# end of Capacitance to digital converters

#
# Direct Digital Synthesis
#
# CONFIG_AD9832 is not set
CONFIG_AD9834=y
# end of Direct Digital Synthesis

#
# Network Analyzer, Impedance Converters
#
CONFIG_AD5933=y
# end of Network Analyzer, Impedance Converters

#
# Active energy metering IC
#
# CONFIG_ADE7854 is not set
# end of Active energy metering IC

#
# Resolver to digital converters
#
CONFIG_AD2S1210=y
# end of Resolver to digital converters
# end of IIO staging drivers

# CONFIG_FB_SM750 is not set
CONFIG_STAGING_MEDIA=y
# CONFIG_INTEL_ATOMISP is not set
# CONFIG_VIDEO_IPU3_IMGU is not set
CONFIG_VIDEO_USBVISION=y

#
# Android
#
# end of Android

CONFIG_STAGING_BOARD=y
# CONFIG_LTE_GDM724X is not set
# CONFIG_FIREWIRE_SERIAL is not set
CONFIG_GOLDFISH_AUDIO=y
# CONFIG_GS_FPGABOOT is not set
CONFIG_UNISYSSPAR=y
CONFIG_FB_TFT=y
# CONFIG_FB_TFT_AGM1264K_FL is not set
CONFIG_FB_TFT_BD663474=y
CONFIG_FB_TFT_HX8340BN=y
CONFIG_FB_TFT_HX8347D=y
CONFIG_FB_TFT_HX8353D=y
CONFIG_FB_TFT_HX8357D=y
CONFIG_FB_TFT_ILI9163=y
CONFIG_FB_TFT_ILI9320=y
CONFIG_FB_TFT_ILI9325=y
CONFIG_FB_TFT_ILI9340=y
CONFIG_FB_TFT_ILI9341=y
# CONFIG_FB_TFT_ILI9481 is not set
# CONFIG_FB_TFT_ILI9486 is not set
CONFIG_FB_TFT_PCD8544=y
CONFIG_FB_TFT_RA8875=y
CONFIG_FB_TFT_S6D02A1=y
# CONFIG_FB_TFT_S6D1121 is not set
# CONFIG_FB_TFT_SEPS525 is not set
CONFIG_FB_TFT_SH1106=y
CONFIG_FB_TFT_SSD1289=y
# CONFIG_FB_TFT_SSD1305 is not set
CONFIG_FB_TFT_SSD1306=y
# CONFIG_FB_TFT_SSD1331 is not set
CONFIG_FB_TFT_SSD1351=y
CONFIG_FB_TFT_ST7735R=y
CONFIG_FB_TFT_ST7789V=y
CONFIG_FB_TFT_TINYLCD=y
# CONFIG_FB_TFT_TLS8204 is not set
# CONFIG_FB_TFT_UC1611 is not set
CONFIG_FB_TFT_UC1701=y
CONFIG_FB_TFT_UPD161704=y
CONFIG_FB_TFT_WATTEROTT=y
CONFIG_MOST_COMPONENTS=y
# CONFIG_MOST_CDEV is not set
# CONFIG_MOST_NET is not set
# CONFIG_MOST_VIDEO is not set
# CONFIG_MOST_DIM2 is not set
CONFIG_MOST_I2C=y
CONFIG_GREYBUS_BOOTROM=y
CONFIG_GREYBUS_FIRMWARE=y
CONFIG_GREYBUS_HID=y
CONFIG_GREYBUS_LIGHT=y
CONFIG_GREYBUS_LOG=y
CONFIG_GREYBUS_LOOPBACK=y
# CONFIG_GREYBUS_POWER is not set
CONFIG_GREYBUS_RAW=y
CONFIG_GREYBUS_VIBRATOR=y
# CONFIG_GREYBUS_BRIDGED_PHY is not set
CONFIG_PI433=y

#
# Gasket devices
#
# end of Gasket devices

CONFIG_XIL_AXIS_FIFO=y
CONFIG_FIELDBUS_DEV=y
# CONFIG_HMS_ANYBUSS_BUS is not set
# CONFIG_KPC2000 is not set
# CONFIG_QLGE is not set
# CONFIG_X86_PLATFORM_DEVICES is not set
CONFIG_PMC_ATOM=y
CONFIG_GOLDFISH_PIPE=y
CONFIG_MFD_CROS_EC=y
CONFIG_CHROME_PLATFORMS=y
CONFIG_CHROMEOS_LAPTOP=y
CONFIG_CHROMEOS_PSTORE=y
# CONFIG_CHROMEOS_TBMC is not set
CONFIG_CROS_EC=y
CONFIG_CROS_EC_I2C=y
CONFIG_CROS_EC_RPMSG=y
CONFIG_CROS_EC_SPI=y
CONFIG_CROS_EC_LPC=y
CONFIG_CROS_EC_PROTO=y
# CONFIG_CROS_KBD_LED_BACKLIGHT is not set
CONFIG_CROS_EC_CHARDEV=y
CONFIG_CROS_EC_LIGHTBAR=y
CONFIG_CROS_EC_VBC=y
CONFIG_CROS_EC_DEBUGFS=y
# CONFIG_CROS_EC_SENSORHUB is not set
CONFIG_CROS_EC_SYSFS=y
# CONFIG_CROS_USBPD_LOGGER is not set
CONFIG_CROS_USBPD_NOTIFY=y
CONFIG_WILCO_EC=y
CONFIG_WILCO_EC_DEBUGFS=y
CONFIG_WILCO_EC_EVENTS=y
CONFIG_WILCO_EC_TELEMETRY=y
# CONFIG_MELLANOX_PLATFORM is not set
CONFIG_HAVE_CLK=y
CONFIG_CLKDEV_LOOKUP=y
CONFIG_HAVE_CLK_PREPARE=y
CONFIG_COMMON_CLK=y
# CONFIG_CLK_HSDK is not set
CONFIG_COMMON_CLK_MAX77686=y
CONFIG_COMMON_CLK_MAX9485=y
# CONFIG_COMMON_CLK_RK808 is not set
CONFIG_COMMON_CLK_SI5341=y
CONFIG_COMMON_CLK_SI5351=y
# CONFIG_COMMON_CLK_SI514 is not set
CONFIG_COMMON_CLK_SI544=y
CONFIG_COMMON_CLK_SI570=y
CONFIG_COMMON_CLK_CDCE706=y
# CONFIG_COMMON_CLK_CDCE925 is not set
CONFIG_COMMON_CLK_CS2000_CP=y
# CONFIG_COMMON_CLK_S2MPS11 is not set
CONFIG_CLK_TWL6040=y
# CONFIG_COMMON_CLK_LOCHNAGAR is not set
CONFIG_COMMON_CLK_PWM=y
CONFIG_COMMON_CLK_VC5=y
CONFIG_COMMON_CLK_BD718XX=y
# CONFIG_COMMON_CLK_FIXED_MMIO is not set
CONFIG_CLK_LGM_CGU=y
CONFIG_HWSPINLOCK=y

#
# Clock Source drivers
#
CONFIG_TIMER_OF=y
CONFIG_TIMER_PROBE=y
CONFIG_CLKSRC_I8253=y
CONFIG_CLKEVT_I8253=y
CONFIG_I8253_LOCK=y
CONFIG_CLKBLD_I8253=y
CONFIG_CLKSRC_MMIO=y
CONFIG_MICROCHIP_PIT64B=y
# end of Clock Source drivers

CONFIG_MAILBOX=y
CONFIG_PLATFORM_MHU=y
# CONFIG_PCC is not set
CONFIG_ALTERA_MBOX=y
# CONFIG_MAILBOX_TEST is not set
CONFIG_IOMMU_SUPPORT=y

#
# Generic IOMMU Pagetable Support
#
# end of Generic IOMMU Pagetable Support

CONFIG_IOMMU_DEBUGFS=y
# CONFIG_HYPERV_IOMMU is not set

#
# Remoteproc drivers
#
CONFIG_REMOTEPROC=y
# CONFIG_REMOTEPROC_CDEV is not set
# end of Remoteproc drivers

#
# Rpmsg drivers
#
CONFIG_RPMSG=y
CONFIG_RPMSG_CHAR=y
CONFIG_RPMSG_QCOM_GLINK=y
CONFIG_RPMSG_QCOM_GLINK_RPM=y
# CONFIG_RPMSG_VIRTIO is not set
# end of Rpmsg drivers

CONFIG_SOUNDWIRE=y

#
# SoundWire Devices
#

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

CONFIG_SOC_TI=y

#
# Xilinx SoC drivers
#
CONFIG_XILINX_VCU=y
# end of Xilinx SoC drivers
# end of SOC (System On Chip) specific Drivers

CONFIG_PM_DEVFREQ=y

#
# DEVFREQ Governors
#
CONFIG_DEVFREQ_GOV_SIMPLE_ONDEMAND=y
CONFIG_DEVFREQ_GOV_PERFORMANCE=y
CONFIG_DEVFREQ_GOV_POWERSAVE=y
CONFIG_DEVFREQ_GOV_USERSPACE=y
CONFIG_DEVFREQ_GOV_PASSIVE=y

#
# DEVFREQ Drivers
#
CONFIG_PM_DEVFREQ_EVENT=y
CONFIG_EXTCON=y

#
# Extcon Device Drivers
#
CONFIG_EXTCON_ADC_JACK=y
CONFIG_EXTCON_AXP288=y
# CONFIG_EXTCON_FSA9480 is not set
CONFIG_EXTCON_GPIO=y
CONFIG_EXTCON_INTEL_INT3496=y
# CONFIG_EXTCON_INTEL_CHT_WC is not set
# CONFIG_EXTCON_MAX14577 is not set
CONFIG_EXTCON_MAX3355=y
CONFIG_EXTCON_MAX77693=y
# CONFIG_EXTCON_MAX77843 is not set
CONFIG_EXTCON_PTN5150=y
CONFIG_EXTCON_RT8973A=y
CONFIG_EXTCON_SM5502=y
# CONFIG_EXTCON_USB_GPIO is not set
# CONFIG_EXTCON_USBC_CROS_EC is not set
CONFIG_MEMORY=y
CONFIG_IIO=y
CONFIG_IIO_BUFFER=y
CONFIG_IIO_BUFFER_CB=y
CONFIG_IIO_BUFFER_DMA=y
CONFIG_IIO_BUFFER_DMAENGINE=y
CONFIG_IIO_BUFFER_HW_CONSUMER=y
CONFIG_IIO_KFIFO_BUF=y
CONFIG_IIO_TRIGGERED_BUFFER=y
CONFIG_IIO_CONFIGFS=y
CONFIG_IIO_TRIGGER=y
CONFIG_IIO_CONSUMERS_PER_TRIGGER=2
CONFIG_IIO_SW_DEVICE=y
CONFIG_IIO_SW_TRIGGER=y
CONFIG_IIO_TRIGGERED_EVENT=y

#
# Accelerometers
#
# CONFIG_ADIS16201 is not set
# CONFIG_ADIS16209 is not set
CONFIG_ADXL345=y
CONFIG_ADXL345_I2C=y
CONFIG_ADXL345_SPI=y
CONFIG_ADXL372=y
CONFIG_ADXL372_SPI=y
CONFIG_ADXL372_I2C=y
CONFIG_BMA180=y
# CONFIG_BMA220 is not set
CONFIG_BMA400=y
CONFIG_BMA400_I2C=y
CONFIG_BMA400_SPI=y
CONFIG_BMC150_ACCEL=y
CONFIG_BMC150_ACCEL_I2C=y
CONFIG_BMC150_ACCEL_SPI=y
# CONFIG_DA280 is not set
CONFIG_DA311=y
CONFIG_DMARD06=y
CONFIG_DMARD09=y
CONFIG_DMARD10=y
# CONFIG_HID_SENSOR_ACCEL_3D is not set
CONFIG_KXSD9=y
# CONFIG_KXSD9_SPI is not set
CONFIG_KXSD9_I2C=y
# CONFIG_KXCJK1013 is not set
CONFIG_MC3230=y
CONFIG_MMA7455=y
# CONFIG_MMA7455_I2C is not set
CONFIG_MMA7455_SPI=y
# CONFIG_MMA7660 is not set
CONFIG_MMA8452=y
CONFIG_MMA9551_CORE=y
# CONFIG_MMA9551 is not set
CONFIG_MMA9553=y
# CONFIG_MXC4005 is not set
CONFIG_MXC6255=y
CONFIG_SCA3000=y
CONFIG_STK8312=y
CONFIG_STK8BA50=y
# end of Accelerometers

#
# Analog to digital converters
#
CONFIG_AD_SIGMA_DELTA=y
CONFIG_AD7091R5=y
CONFIG_AD7124=y
CONFIG_AD7192=y
CONFIG_AD7266=y
# CONFIG_AD7291 is not set
CONFIG_AD7292=y
# CONFIG_AD7298 is not set
CONFIG_AD7476=y
CONFIG_AD7606=y
CONFIG_AD7606_IFACE_PARALLEL=y
CONFIG_AD7606_IFACE_SPI=y
CONFIG_AD7766=y
CONFIG_AD7768_1=y
CONFIG_AD7780=y
# CONFIG_AD7791 is not set
CONFIG_AD7793=y
CONFIG_AD7887=y
CONFIG_AD7923=y
CONFIG_AD7949=y
CONFIG_AD799X=y
CONFIG_AD9467=y
CONFIG_ADI_AXI_ADC=y
CONFIG_AXP20X_ADC=y
CONFIG_AXP288_ADC=y
CONFIG_CC10001_ADC=y
CONFIG_CPCAP_ADC=y
CONFIG_ENVELOPE_DETECTOR=y
CONFIG_HI8435=y
CONFIG_HX711=y
CONFIG_INA2XX_ADC=y
CONFIG_LP8788_ADC=y
CONFIG_LTC2471=y
# CONFIG_LTC2485 is not set
CONFIG_LTC2496=y
# CONFIG_LTC2497 is not set
CONFIG_MAX1027=y
# CONFIG_MAX11100 is not set
# CONFIG_MAX1118 is not set
CONFIG_MAX1241=y
# CONFIG_MAX1363 is not set
# CONFIG_MAX9611 is not set
CONFIG_MCP320X=y
CONFIG_MCP3422=y
CONFIG_MCP3911=y
CONFIG_MEN_Z188_ADC=y
CONFIG_NAU7802=y
CONFIG_RN5T618_ADC=y
CONFIG_SD_ADC_MODULATOR=y
# CONFIG_STMPE_ADC is not set
CONFIG_STX104=y
CONFIG_TI_ADC081C=y
# CONFIG_TI_ADC0832 is not set
CONFIG_TI_ADC084S021=y
CONFIG_TI_ADC12138=y
# CONFIG_TI_ADC108S102 is not set
CONFIG_TI_ADC128S052=y
# CONFIG_TI_ADC161S626 is not set
CONFIG_TI_ADS1015=y
CONFIG_TI_ADS7950=y
# CONFIG_TI_ADS8344 is not set
CONFIG_TI_ADS8688=y
CONFIG_TI_ADS124S08=y
CONFIG_TI_TLC4541=y
CONFIG_VF610_ADC=y
CONFIG_XILINX_XADC=y
# end of Analog to digital converters

#
# Analog Front Ends
#
# CONFIG_IIO_RESCALE is not set
# end of Analog Front Ends

#
# Amplifiers
#
CONFIG_AD8366=y
CONFIG_HMC425=y
# end of Amplifiers

#
# Chemical Sensors
#
CONFIG_ATLAS_PH_SENSOR=y
# CONFIG_ATLAS_EZO_SENSOR is not set
CONFIG_BME680=y
CONFIG_BME680_I2C=y
CONFIG_BME680_SPI=y
CONFIG_CCS811=y
# CONFIG_IAQCORE is not set
CONFIG_PMS7003=y
CONFIG_SCD30_CORE=y
CONFIG_SCD30_I2C=y
CONFIG_SCD30_SERIAL=y
CONFIG_SENSIRION_SGP30=y
CONFIG_SPS30=y
# CONFIG_VZ89X is not set
# end of Chemical Sensors

#
# Hid Sensor IIO Common
#
CONFIG_HID_SENSOR_IIO_COMMON=y
CONFIG_HID_SENSOR_IIO_TRIGGER=y
# end of Hid Sensor IIO Common

CONFIG_IIO_MS_SENSORS_I2C=y

#
# SSP Sensor Common
#
# CONFIG_IIO_SSP_SENSORHUB is not set
# end of SSP Sensor Common

CONFIG_IIO_ST_SENSORS_I2C=y
CONFIG_IIO_ST_SENSORS_SPI=y
CONFIG_IIO_ST_SENSORS_CORE=y

#
# Digital to analog converters
#
# CONFIG_AD5064 is not set
CONFIG_AD5360=y
CONFIG_AD5380=y
CONFIG_AD5421=y
CONFIG_AD5446=y
# CONFIG_AD5449 is not set
CONFIG_AD5592R_BASE=y
# CONFIG_AD5592R is not set
CONFIG_AD5593R=y
# CONFIG_AD5504 is not set
# CONFIG_AD5624R_SPI is not set
CONFIG_AD5686=y
CONFIG_AD5686_SPI=y
CONFIG_AD5696_I2C=y
CONFIG_AD5755=y
CONFIG_AD5758=y
# CONFIG_AD5761 is not set
CONFIG_AD5764=y
CONFIG_AD5770R=y
# CONFIG_AD5791 is not set
CONFIG_AD7303=y
CONFIG_AD8801=y
CONFIG_CIO_DAC=y
CONFIG_DPOT_DAC=y
# CONFIG_DS4424 is not set
CONFIG_LTC1660=y
# CONFIG_LTC2632 is not set
# CONFIG_M62332 is not set
CONFIG_MAX517=y
CONFIG_MAX5821=y
CONFIG_MCP4725=y
CONFIG_MCP4922=y
CONFIG_TI_DAC082S085=y
CONFIG_TI_DAC5571=y
CONFIG_TI_DAC7311=y
CONFIG_TI_DAC7612=y
CONFIG_VF610_DAC=y
# end of Digital to analog converters

#
# IIO dummy driver
#
# CONFIG_IIO_SIMPLE_DUMMY is not set
# end of IIO dummy driver

#
# Frequency Synthesizers DDS/PLL
#

#
# Clock Generator/Distribution
#
CONFIG_AD9523=y
# end of Clock Generator/Distribution

#
# Phase-Locked Loop (PLL) frequency synthesizers
#
CONFIG_ADF4350=y
CONFIG_ADF4371=y
# end of Phase-Locked Loop (PLL) frequency synthesizers
# end of Frequency Synthesizers DDS/PLL

#
# Digital gyroscope sensors
#
CONFIG_ADIS16080=y
CONFIG_ADIS16130=y
CONFIG_ADIS16136=y
CONFIG_ADIS16260=y
CONFIG_ADXRS450=y
CONFIG_BMG160=y
CONFIG_BMG160_I2C=y
CONFIG_BMG160_SPI=y
# CONFIG_FXAS21002C is not set
# CONFIG_HID_SENSOR_GYRO_3D is not set
CONFIG_MPU3050=y
CONFIG_MPU3050_I2C=y
# CONFIG_IIO_ST_GYRO_3AXIS is not set
CONFIG_ITG3200=y
# end of Digital gyroscope sensors

#
# Health Sensors
#

#
# Heart Rate Monitors
#
# CONFIG_AFE4403 is not set
CONFIG_AFE4404=y
CONFIG_MAX30100=y
CONFIG_MAX30102=y
# end of Heart Rate Monitors
# end of Health Sensors

#
# Humidity sensors
#
CONFIG_AM2315=y
# CONFIG_DHT11 is not set
# CONFIG_HDC100X is not set
CONFIG_HID_SENSOR_HUMIDITY=y
CONFIG_HTS221=y
CONFIG_HTS221_I2C=y
CONFIG_HTS221_SPI=y
CONFIG_HTU21=y
CONFIG_SI7005=y
CONFIG_SI7020=y
# end of Humidity sensors

#
# Inertial measurement units
#
CONFIG_ADIS16400=y
CONFIG_ADIS16460=y
CONFIG_ADIS16475=y
CONFIG_ADIS16480=y
CONFIG_BMI160=y
CONFIG_BMI160_I2C=y
CONFIG_BMI160_SPI=y
CONFIG_FXOS8700=y
CONFIG_FXOS8700_I2C=y
# CONFIG_FXOS8700_SPI is not set
# CONFIG_KMX61 is not set
CONFIG_INV_ICM42600=y
CONFIG_INV_ICM42600_I2C=y
CONFIG_INV_ICM42600_SPI=y
CONFIG_INV_MPU6050_IIO=y
CONFIG_INV_MPU6050_I2C=y
# CONFIG_INV_MPU6050_SPI is not set
CONFIG_IIO_ST_LSM6DSX=y
CONFIG_IIO_ST_LSM6DSX_I2C=y
CONFIG_IIO_ST_LSM6DSX_SPI=y
CONFIG_IIO_ST_LSM6DSX_I3C=y
# end of Inertial measurement units

CONFIG_IIO_ADIS_LIB=y
CONFIG_IIO_ADIS_LIB_BUFFER=y

#
# Light sensors
#
CONFIG_ACPI_ALS=y
CONFIG_ADJD_S311=y
CONFIG_ADUX1020=y
CONFIG_AL3010=y
CONFIG_AL3320A=y
CONFIG_APDS9300=y
CONFIG_APDS9960=y
CONFIG_BH1750=y
CONFIG_BH1780=y
# CONFIG_CM32181 is not set
CONFIG_CM3232=y
CONFIG_CM3323=y
# CONFIG_CM3605 is not set
# CONFIG_CM36651 is not set
# CONFIG_GP2AP002 is not set
CONFIG_GP2AP020A00F=y
CONFIG_IQS621_ALS=y
# CONFIG_SENSORS_ISL29018 is not set
CONFIG_SENSORS_ISL29028=y
CONFIG_ISL29125=y
CONFIG_HID_SENSOR_ALS=y
# CONFIG_HID_SENSOR_PROX is not set
CONFIG_JSA1212=y
# CONFIG_RPR0521 is not set
# CONFIG_SENSORS_LM3533 is not set
CONFIG_LTR501=y
CONFIG_LV0104CS=y
CONFIG_MAX44000=y
CONFIG_MAX44009=y
# CONFIG_NOA1305 is not set
CONFIG_OPT3001=y
CONFIG_PA12203001=y
# CONFIG_SI1133 is not set
CONFIG_SI1145=y
CONFIG_STK3310=y
CONFIG_ST_UVIS25=y
CONFIG_ST_UVIS25_I2C=y
CONFIG_ST_UVIS25_SPI=y
CONFIG_TCS3414=y
CONFIG_TCS3472=y
CONFIG_SENSORS_TSL2563=y
CONFIG_TSL2583=y
CONFIG_TSL2772=y
# CONFIG_TSL4531 is not set
CONFIG_US5182D=y
CONFIG_VCNL4000=y
CONFIG_VCNL4035=y
# CONFIG_VEML6030 is not set
# CONFIG_VEML6070 is not set
CONFIG_VL6180=y
CONFIG_ZOPT2201=y
# end of Light sensors

#
# Magnetometer sensors
#
CONFIG_AK8974=y
CONFIG_AK8975=y
# CONFIG_AK09911 is not set
CONFIG_BMC150_MAGN=y
CONFIG_BMC150_MAGN_I2C=y
# CONFIG_BMC150_MAGN_SPI is not set
CONFIG_MAG3110=y
CONFIG_HID_SENSOR_MAGNETOMETER_3D=y
# CONFIG_MMC35240 is not set
CONFIG_IIO_ST_MAGN_3AXIS=y
CONFIG_IIO_ST_MAGN_I2C_3AXIS=y
CONFIG_IIO_ST_MAGN_SPI_3AXIS=y
CONFIG_SENSORS_HMC5843=y
# CONFIG_SENSORS_HMC5843_I2C is not set
CONFIG_SENSORS_HMC5843_SPI=y
# CONFIG_SENSORS_RM3100_I2C is not set
# CONFIG_SENSORS_RM3100_SPI is not set
# end of Magnetometer sensors

#
# Multiplexers
#
CONFIG_IIO_MUX=y
# end of Multiplexers

#
# Inclinometer sensors
#
CONFIG_HID_SENSOR_INCLINOMETER_3D=y
CONFIG_HID_SENSOR_DEVICE_ROTATION=y
# end of Inclinometer sensors

#
# Triggers - standalone
#
CONFIG_IIO_HRTIMER_TRIGGER=y
# CONFIG_IIO_INTERRUPT_TRIGGER is not set
CONFIG_IIO_TIGHTLOOP_TRIGGER=y
CONFIG_IIO_SYSFS_TRIGGER=y
# end of Triggers - standalone

#
# Linear and angular position sensors
#
CONFIG_IQS624_POS=y
# end of Linear and angular position sensors

#
# Digital potentiometers
#
CONFIG_AD5272=y
CONFIG_DS1803=y
# CONFIG_MAX5432 is not set
CONFIG_MAX5481=y
# CONFIG_MAX5487 is not set
CONFIG_MCP4018=y
CONFIG_MCP4131=y
CONFIG_MCP4531=y
CONFIG_MCP41010=y
CONFIG_TPL0102=y
# end of Digital potentiometers

#
# Digital potentiostats
#
# CONFIG_LMP91000 is not set
# end of Digital potentiostats

#
# Pressure sensors
#
CONFIG_ABP060MG=y
CONFIG_BMP280=y
CONFIG_BMP280_I2C=y
CONFIG_BMP280_SPI=y
# CONFIG_DLHL60D is not set
# CONFIG_DPS310 is not set
CONFIG_HID_SENSOR_PRESS=y
# CONFIG_HP03 is not set
CONFIG_ICP10100=y
CONFIG_MPL115=y
CONFIG_MPL115_I2C=y
CONFIG_MPL115_SPI=y
# CONFIG_MPL3115 is not set
# CONFIG_MS5611 is not set
CONFIG_MS5637=y
CONFIG_IIO_ST_PRESS=y
CONFIG_IIO_ST_PRESS_I2C=y
CONFIG_IIO_ST_PRESS_SPI=y
# CONFIG_T5403 is not set
# CONFIG_HP206C is not set
CONFIG_ZPA2326=y
CONFIG_ZPA2326_I2C=y
CONFIG_ZPA2326_SPI=y
# end of Pressure sensors

#
# Lightning sensors
#
CONFIG_AS3935=y
# end of Lightning sensors

#
# Proximity and distance sensors
#
# CONFIG_ISL29501 is not set
# CONFIG_LIDAR_LITE_V2 is not set
CONFIG_MB1232=y
CONFIG_PING=y
# CONFIG_RFD77402 is not set
CONFIG_SRF04=y
# CONFIG_SX9310 is not set
# CONFIG_SX9500 is not set
CONFIG_SRF08=y
CONFIG_VCNL3020=y
CONFIG_VL53L0X_I2C=y
# end of Proximity and distance sensors

#
# Resolver to digital converters
#
CONFIG_AD2S90=y
CONFIG_AD2S1200=y
# end of Resolver to digital converters

#
# Temperature sensors
#
CONFIG_IQS620AT_TEMP=y
CONFIG_LTC2983=y
CONFIG_MAXIM_THERMOCOUPLE=y
CONFIG_HID_SENSOR_TEMP=y
CONFIG_MLX90614=y
CONFIG_MLX90632=y
CONFIG_TMP006=y
# CONFIG_TMP007 is not set
# CONFIG_TSYS01 is not set
# CONFIG_TSYS02D is not set
CONFIG_MAX31856=y
# end of Temperature sensors

# CONFIG_NTB is not set
# CONFIG_VME_BUS is not set
CONFIG_PWM=y
CONFIG_PWM_SYSFS=y
# CONFIG_PWM_DEBUG is not set
CONFIG_PWM_ATMEL_HLCDC_PWM=y
CONFIG_PWM_CROS_EC=y
CONFIG_PWM_FSL_FTM=y
# CONFIG_PWM_IQS620A is not set
# CONFIG_PWM_LP3943 is not set
# CONFIG_PWM_LPSS_PCI is not set
# CONFIG_PWM_LPSS_PLATFORM is not set
# CONFIG_PWM_PCA9685 is not set
# CONFIG_PWM_STMPE is not set

#
# IRQ chip support
#
CONFIG_IRQCHIP=y
# CONFIG_AL_FIC is not set
# end of IRQ chip support

# CONFIG_IPACK_BUS is not set
CONFIG_RESET_CONTROLLER=y
CONFIG_RESET_BRCMSTB_RESCAL=y
CONFIG_RESET_INTEL_GW=y
# CONFIG_RESET_TI_SYSCON is not set

#
# PHY Subsystem
#
CONFIG_GENERIC_PHY=y
CONFIG_GENERIC_PHY_MIPI_DPHY=y
CONFIG_BCM_KONA_USB2_PHY=y
# CONFIG_PHY_CADENCE_TORRENT is not set
CONFIG_PHY_CADENCE_DPHY=y
CONFIG_PHY_CADENCE_SIERRA=y
# CONFIG_PHY_CADENCE_SALVO is not set
# CONFIG_PHY_FSL_IMX8MQ_USB is not set
# CONFIG_PHY_MIXEL_MIPI_DPHY is not set
CONFIG_PHY_PXA_28NM_HSIC=y
CONFIG_PHY_PXA_28NM_USB2=y
# CONFIG_PHY_CPCAP_USB is not set
CONFIG_PHY_MAPPHONE_MDM6600=y
CONFIG_PHY_OCELOT_SERDES=y
# CONFIG_PHY_QCOM_USB_HS is not set
# CONFIG_PHY_QCOM_USB_HSIC is not set
CONFIG_PHY_TUSB1210=y
# CONFIG_PHY_INTEL_COMBO is not set
# CONFIG_PHY_INTEL_EMMC is not set
# end of PHY Subsystem

# CONFIG_POWERCAP is not set
CONFIG_MCB=y
# CONFIG_MCB_PCI is not set
CONFIG_MCB_LPC=y

#
# Performance monitor support
#
# end of Performance monitor support

CONFIG_RAS=y
# CONFIG_USB4 is not set

#
# Android
#
# CONFIG_ANDROID is not set
# end of Android

CONFIG_DAX=y
# CONFIG_DEV_DAX is not set
CONFIG_NVMEM=y
CONFIG_NVMEM_SYSFS=y

#
# HW tracing support
#
CONFIG_STM=y
# CONFIG_STM_PROTO_BASIC is not set
CONFIG_STM_PROTO_SYS_T=y
CONFIG_STM_DUMMY=y
# CONFIG_STM_SOURCE_CONSOLE is not set
CONFIG_STM_SOURCE_HEARTBEAT=y
CONFIG_STM_SOURCE_FTRACE=y
# CONFIG_INTEL_TH is not set
# end of HW tracing support

CONFIG_FPGA=y
CONFIG_ALTERA_PR_IP_CORE=y
CONFIG_ALTERA_PR_IP_CORE_PLAT=y
CONFIG_FPGA_MGR_ALTERA_PS_SPI=y
# CONFIG_FPGA_MGR_ALTERA_CVP is not set
# CONFIG_FPGA_MGR_XILINX_SPI is not set
# CONFIG_FPGA_MGR_ICE40_SPI is not set
# CONFIG_FPGA_MGR_MACHXO2_SPI is not set
# CONFIG_FPGA_BRIDGE is not set
# CONFIG_FPGA_DFL is not set
# CONFIG_FSI is not set
# CONFIG_TEE is not set
CONFIG_MULTIPLEXER=y

#
# Multiplexer drivers
#
CONFIG_MUX_ADG792A=y
# CONFIG_MUX_ADGS1408 is not set
CONFIG_MUX_GPIO=y
CONFIG_MUX_MMIO=y
# end of Multiplexer drivers

CONFIG_PM_OPP=y
CONFIG_SIOX=y
# CONFIG_SIOX_BUS_GPIO is not set
CONFIG_SLIMBUS=y
# CONFIG_SLIM_QCOM_CTRL is not set
# CONFIG_INTERCONNECT is not set
CONFIG_COUNTER=y
CONFIG_104_QUAD_8=y
CONFIG_FTM_QUADDEC=y
CONFIG_MICROCHIP_TCB_CAPTURE=y
CONFIG_MOST=y
# CONFIG_MOST_USB_HDM is not set
# end of Device Drivers

#
# File systems
#
CONFIG_DCACHE_WORD_ACCESS=y
# CONFIG_VALIDATE_FS_PARSER is not set
CONFIG_FS_POSIX_ACL=y
CONFIG_EXPORTFS=y
CONFIG_EXPORTFS_BLOCK_OPS=y
CONFIG_FILE_LOCKING=y
CONFIG_MANDATORY_FILE_LOCKING=y
CONFIG_FS_ENCRYPTION=y
# CONFIG_FS_VERITY is not set
CONFIG_FSNOTIFY=y
CONFIG_DNOTIFY=y
CONFIG_INOTIFY_USER=y
# CONFIG_FANOTIFY is not set
CONFIG_QUOTA=y
CONFIG_QUOTA_NETLINK_INTERFACE=y
# CONFIG_PRINT_QUOTA_WARNING is not set
CONFIG_QUOTA_DEBUG=y
CONFIG_QFMT_V1=y
# CONFIG_QFMT_V2 is not set
CONFIG_QUOTACTL=y
# CONFIG_AUTOFS4_FS is not set
CONFIG_AUTOFS_FS=y
CONFIG_FUSE_FS=y
CONFIG_CUSE=y
# CONFIG_VIRTIO_FS is not set
CONFIG_OVERLAY_FS=y
CONFIG_OVERLAY_FS_REDIRECT_DIR=y
# CONFIG_OVERLAY_FS_REDIRECT_ALWAYS_FOLLOW is not set
CONFIG_OVERLAY_FS_INDEX=y
CONFIG_OVERLAY_FS_METACOPY=y

#
# Caches
#
# CONFIG_FSCACHE is not set
# end of Caches

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
# CONFIG_PROC_KCORE is not set
CONFIG_PROC_SYSCTL=y
CONFIG_PROC_PAGE_MONITOR=y
CONFIG_PROC_CHILDREN=y
CONFIG_PROC_PID_ARCH_STATUS=y
CONFIG_KERNFS=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
CONFIG_TMPFS_POSIX_ACL=y
CONFIG_TMPFS_XATTR=y
# CONFIG_HUGETLBFS is not set
CONFIG_MEMFD_CREATE=y
CONFIG_CONFIGFS_FS=y
# CONFIG_EFIVAR_FS is not set
# end of Pseudo filesystems

CONFIG_MISC_FILESYSTEMS=y
CONFIG_ORANGEFS_FS=y
CONFIG_ECRYPT_FS=y
CONFIG_ECRYPT_FS_MESSAGING=y
# CONFIG_JFFS2_FS is not set
CONFIG_CRAMFS=y
# CONFIG_CRAMFS_MTD is not set
# CONFIG_ROMFS_FS is not set
CONFIG_PSTORE=y
# CONFIG_PSTORE_DEFLATE_COMPRESS is not set
CONFIG_PSTORE_LZO_COMPRESS=y
# CONFIG_PSTORE_LZ4_COMPRESS is not set
CONFIG_PSTORE_LZ4HC_COMPRESS=y
# CONFIG_PSTORE_842_COMPRESS is not set
# CONFIG_PSTORE_ZSTD_COMPRESS is not set
CONFIG_PSTORE_COMPRESS=y
CONFIG_PSTORE_LZO_COMPRESS_DEFAULT=y
# CONFIG_PSTORE_LZ4HC_COMPRESS_DEFAULT is not set
CONFIG_PSTORE_COMPRESS_DEFAULT="lzo"
CONFIG_PSTORE_CONSOLE=y
# CONFIG_PSTORE_PMSG is not set
# CONFIG_PSTORE_FTRACE is not set
# CONFIG_PSTORE_RAM is not set
# CONFIG_NETWORK_FILESYSTEMS is not set
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=y
CONFIG_NLS_CODEPAGE_737=y
CONFIG_NLS_CODEPAGE_775=y
CONFIG_NLS_CODEPAGE_850=y
CONFIG_NLS_CODEPAGE_852=y
# CONFIG_NLS_CODEPAGE_855 is not set
# CONFIG_NLS_CODEPAGE_857 is not set
CONFIG_NLS_CODEPAGE_860=y
CONFIG_NLS_CODEPAGE_861=y
# CONFIG_NLS_CODEPAGE_862 is not set
# CONFIG_NLS_CODEPAGE_863 is not set
CONFIG_NLS_CODEPAGE_864=y
CONFIG_NLS_CODEPAGE_865=y
# CONFIG_NLS_CODEPAGE_866 is not set
# CONFIG_NLS_CODEPAGE_869 is not set
CONFIG_NLS_CODEPAGE_936=y
# CONFIG_NLS_CODEPAGE_950 is not set
CONFIG_NLS_CODEPAGE_932=y
# CONFIG_NLS_CODEPAGE_949 is not set
# CONFIG_NLS_CODEPAGE_874 is not set
CONFIG_NLS_ISO8859_8=y
# CONFIG_NLS_CODEPAGE_1250 is not set
CONFIG_NLS_CODEPAGE_1251=y
CONFIG_NLS_ASCII=y
CONFIG_NLS_ISO8859_1=y
CONFIG_NLS_ISO8859_2=y
# CONFIG_NLS_ISO8859_3 is not set
# CONFIG_NLS_ISO8859_4 is not set
CONFIG_NLS_ISO8859_5=y
CONFIG_NLS_ISO8859_6=y
# CONFIG_NLS_ISO8859_7 is not set
# CONFIG_NLS_ISO8859_9 is not set
CONFIG_NLS_ISO8859_13=y
CONFIG_NLS_ISO8859_14=y
CONFIG_NLS_ISO8859_15=y
# CONFIG_NLS_KOI8_R is not set
CONFIG_NLS_KOI8_U=y
CONFIG_NLS_MAC_ROMAN=y
CONFIG_NLS_MAC_CELTIC=y
CONFIG_NLS_MAC_CENTEURO=y
CONFIG_NLS_MAC_CROATIAN=y
CONFIG_NLS_MAC_CYRILLIC=y
CONFIG_NLS_MAC_GAELIC=y
# CONFIG_NLS_MAC_GREEK is not set
# CONFIG_NLS_MAC_ICELAND is not set
# CONFIG_NLS_MAC_INUIT is not set
CONFIG_NLS_MAC_ROMANIAN=y
# CONFIG_NLS_MAC_TURKISH is not set
CONFIG_NLS_UTF8=y
# CONFIG_DLM is not set
CONFIG_UNICODE=y
CONFIG_UNICODE_NORMALIZATION_SELFTEST=y
CONFIG_IO_WQ=y
# end of File systems

#
# Security options
#
CONFIG_KEYS=y
CONFIG_KEYS_REQUEST_CACHE=y
CONFIG_PERSISTENT_KEYRINGS=y
CONFIG_BIG_KEYS=y
# CONFIG_TRUSTED_KEYS is not set
# CONFIG_ENCRYPTED_KEYS is not set
CONFIG_KEY_DH_OPERATIONS=y
# CONFIG_KEY_NOTIFICATIONS is not set
# CONFIG_SECURITY_DMESG_RESTRICT is not set
# CONFIG_SECURITY is not set
CONFIG_SECURITYFS=y
# CONFIG_PAGE_TABLE_ISOLATION is not set
CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
# CONFIG_HARDENED_USERCOPY is not set
CONFIG_FORTIFY_SOURCE=y
# CONFIG_STATIC_USERMODEHELPER is not set
# CONFIG_IMA_SECURE_AND_OR_TRUSTED_BOOT is not set
CONFIG_DEFAULT_SECURITY_DAC=y
CONFIG_LSM="lockdown,yama,loadpin,safesetid,integrity,bpf"

#
# Kernel hardening options
#

#
# Memory initialization
#
CONFIG_INIT_STACK_NONE=y
CONFIG_INIT_ON_ALLOC_DEFAULT_ON=y
CONFIG_INIT_ON_FREE_DEFAULT_ON=y
# end of Memory initialization
# end of Kernel hardening options
# end of Security options

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
CONFIG_CRYPTO_KPP=y
CONFIG_CRYPTO_ACOMP2=y
CONFIG_CRYPTO_MANAGER=y
CONFIG_CRYPTO_MANAGER2=y
# CONFIG_CRYPTO_USER is not set
CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
CONFIG_CRYPTO_GF128MUL=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_NULL2=y
CONFIG_CRYPTO_PCRYPT=y
CONFIG_CRYPTO_CRYPTD=y
CONFIG_CRYPTO_AUTHENC=y
# CONFIG_CRYPTO_TEST is not set
CONFIG_CRYPTO_SIMD=y
CONFIG_CRYPTO_GLUE_HELPER_X86=y

#
# Public-key cryptography
#
CONFIG_CRYPTO_RSA=y
CONFIG_CRYPTO_DH=y
CONFIG_CRYPTO_ECC=y
CONFIG_CRYPTO_ECDH=y
CONFIG_CRYPTO_ECRDSA=y
CONFIG_CRYPTO_CURVE25519=y

#
# Authenticated Encryption with Associated Data
#
CONFIG_CRYPTO_CCM=y
CONFIG_CRYPTO_GCM=y
# CONFIG_CRYPTO_CHACHA20POLY1305 is not set
# CONFIG_CRYPTO_AEGIS128 is not set
CONFIG_CRYPTO_SEQIV=y
CONFIG_CRYPTO_ECHAINIV=y

#
# Block modes
#
CONFIG_CRYPTO_CBC=y
# CONFIG_CRYPTO_CFB is not set
CONFIG_CRYPTO_CTR=y
CONFIG_CRYPTO_CTS=y
CONFIG_CRYPTO_ECB=y
CONFIG_CRYPTO_LRW=y
# CONFIG_CRYPTO_OFB is not set
# CONFIG_CRYPTO_PCBC is not set
CONFIG_CRYPTO_XTS=y
# CONFIG_CRYPTO_KEYWRAP is not set
# CONFIG_CRYPTO_ADIANTUM is not set
# CONFIG_CRYPTO_ESSIV is not set

#
# Hash modes
#
CONFIG_CRYPTO_CMAC=y
CONFIG_CRYPTO_HMAC=y
# CONFIG_CRYPTO_XCBC is not set
CONFIG_CRYPTO_VMAC=y

#
# Digest
#
CONFIG_CRYPTO_CRC32C=y
CONFIG_CRYPTO_CRC32C_INTEL=y
CONFIG_CRYPTO_CRC32=y
# CONFIG_CRYPTO_CRC32_PCLMUL is not set
CONFIG_CRYPTO_XXHASH=y
CONFIG_CRYPTO_BLAKE2B=y
# CONFIG_CRYPTO_BLAKE2S is not set
# CONFIG_CRYPTO_CRCT10DIF is not set
CONFIG_CRYPTO_GHASH=y
CONFIG_CRYPTO_POLY1305=y
CONFIG_CRYPTO_MD4=y
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_MICHAEL_MIC=y
# CONFIG_CRYPTO_RMD128 is not set
CONFIG_CRYPTO_RMD160=y
CONFIG_CRYPTO_RMD256=y
# CONFIG_CRYPTO_RMD320 is not set
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
CONFIG_CRYPTO_SHA3=y
CONFIG_CRYPTO_SM3=y
CONFIG_CRYPTO_STREEBOG=y
# CONFIG_CRYPTO_TGR192 is not set
# CONFIG_CRYPTO_WP512 is not set

#
# Ciphers
#
CONFIG_CRYPTO_AES=y
CONFIG_CRYPTO_AES_TI=y
CONFIG_CRYPTO_AES_NI_INTEL=y
CONFIG_CRYPTO_ANUBIS=y
# CONFIG_CRYPTO_ARC4 is not set
CONFIG_CRYPTO_BLOWFISH=y
CONFIG_CRYPTO_BLOWFISH_COMMON=y
# CONFIG_CRYPTO_CAMELLIA is not set
CONFIG_CRYPTO_CAST_COMMON=y
# CONFIG_CRYPTO_CAST5 is not set
CONFIG_CRYPTO_CAST6=y
CONFIG_CRYPTO_DES=y
CONFIG_CRYPTO_FCRYPT=y
CONFIG_CRYPTO_KHAZAD=y
CONFIG_CRYPTO_SALSA20=y
CONFIG_CRYPTO_CHACHA20=y
# CONFIG_CRYPTO_SEED is not set
CONFIG_CRYPTO_SERPENT=y
CONFIG_CRYPTO_SERPENT_SSE2_586=y
CONFIG_CRYPTO_SM4=y
# CONFIG_CRYPTO_TEA is not set
# CONFIG_CRYPTO_TWOFISH is not set
CONFIG_CRYPTO_TWOFISH_COMMON=y
CONFIG_CRYPTO_TWOFISH_586=y

#
# Compression
#
CONFIG_CRYPTO_DEFLATE=y
CONFIG_CRYPTO_LZO=y
# CONFIG_CRYPTO_842 is not set
CONFIG_CRYPTO_LZ4=y
CONFIG_CRYPTO_LZ4HC=y
CONFIG_CRYPTO_ZSTD=y

#
# Random Number Generation
#
CONFIG_CRYPTO_ANSI_CPRNG=y
CONFIG_CRYPTO_DRBG_MENU=y
CONFIG_CRYPTO_DRBG_HMAC=y
# CONFIG_CRYPTO_DRBG_HASH is not set
# CONFIG_CRYPTO_DRBG_CTR is not set
CONFIG_CRYPTO_DRBG=y
CONFIG_CRYPTO_JITTERENTROPY=y
CONFIG_CRYPTO_USER_API=y
# CONFIG_CRYPTO_USER_API_HASH is not set
# CONFIG_CRYPTO_USER_API_SKCIPHER is not set
CONFIG_CRYPTO_USER_API_RNG=y
CONFIG_CRYPTO_USER_API_AEAD=y
CONFIG_CRYPTO_HASH_INFO=y

#
# Crypto library routines
#
CONFIG_CRYPTO_LIB_AES=y
CONFIG_CRYPTO_LIB_BLAKE2S_GENERIC=y
CONFIG_CRYPTO_LIB_BLAKE2S=y
CONFIG_CRYPTO_LIB_CHACHA_GENERIC=y
CONFIG_CRYPTO_LIB_CHACHA=y
CONFIG_CRYPTO_LIB_CURVE25519_GENERIC=y
# CONFIG_CRYPTO_LIB_CURVE25519 is not set
CONFIG_CRYPTO_LIB_DES=y
CONFIG_CRYPTO_LIB_POLY1305_RSIZE=1
CONFIG_CRYPTO_LIB_POLY1305_GENERIC=y
CONFIG_CRYPTO_LIB_POLY1305=y
CONFIG_CRYPTO_LIB_CHACHA20POLY1305=y
CONFIG_CRYPTO_LIB_SHA256=y
CONFIG_CRYPTO_HW=y
CONFIG_CRYPTO_DEV_PADLOCK=y
# CONFIG_CRYPTO_DEV_PADLOCK_AES is not set
CONFIG_CRYPTO_DEV_PADLOCK_SHA=y
# CONFIG_CRYPTO_DEV_GEODE is not set
CONFIG_CRYPTO_DEV_ATMEL_I2C=y
CONFIG_CRYPTO_DEV_ATMEL_ECC=y
CONFIG_CRYPTO_DEV_ATMEL_SHA204A=y
# CONFIG_CRYPTO_DEV_CCP is not set
# CONFIG_CRYPTO_DEV_QAT_DH895xCC is not set
# CONFIG_CRYPTO_DEV_QAT_C3XXX is not set
# CONFIG_CRYPTO_DEV_QAT_C62X is not set
# CONFIG_CRYPTO_DEV_QAT_DH895xCCVF is not set
# CONFIG_CRYPTO_DEV_QAT_C3XXXVF is not set
# CONFIG_CRYPTO_DEV_QAT_C62XVF is not set
# CONFIG_CRYPTO_DEV_VIRTIO is not set
# CONFIG_CRYPTO_DEV_SAFEXCEL is not set
CONFIG_CRYPTO_DEV_CCREE=y
# CONFIG_CRYPTO_DEV_AMLOGIC_GXL is not set
CONFIG_ASYMMETRIC_KEY_TYPE=y
# CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE is not set

#
# Certificates for signature checking
#
CONFIG_SYSTEM_TRUSTED_KEYRING=y
CONFIG_SYSTEM_TRUSTED_KEYS=""
CONFIG_SYSTEM_EXTRA_CERTIFICATE=y
CONFIG_SYSTEM_EXTRA_CERTIFICATE_SIZE=4096
# CONFIG_SECONDARY_TRUSTED_KEYRING is not set
# CONFIG_SYSTEM_BLACKLIST_KEYRING is not set
# end of Certificates for signature checking

CONFIG_BINARY_PRINTF=y

#
# Library routines
#
CONFIG_LINEAR_RANGES=y
CONFIG_PACKING=y
CONFIG_BITREVERSE=y
CONFIG_GENERIC_STRNCPY_FROM_USER=y
CONFIG_GENERIC_STRNLEN_USER=y
CONFIG_GENERIC_NET_UTILS=y
CONFIG_GENERIC_FIND_FIRST_BIT=y
# CONFIG_CORDIC is not set
CONFIG_PRIME_NUMBERS=y
CONFIG_RATIONAL=y
CONFIG_GENERIC_PCI_IOMAP=y
CONFIG_GENERIC_IOMAP=y
CONFIG_ARCH_HAS_FAST_MULTIPLIER=y
CONFIG_ARCH_USE_SYM_ANNOTATIONS=y
CONFIG_CRC_CCITT=y
CONFIG_CRC16=y
# CONFIG_CRC_T10DIF is not set
CONFIG_CRC_ITU_T=y
CONFIG_CRC32=y
# CONFIG_CRC32_SELFTEST is not set
# CONFIG_CRC32_SLICEBY8 is not set
CONFIG_CRC32_SLICEBY4=y
# CONFIG_CRC32_SARWATE is not set
# CONFIG_CRC32_BIT is not set
# CONFIG_CRC64 is not set
CONFIG_CRC4=y
# CONFIG_CRC7 is not set
CONFIG_LIBCRC32C=y
CONFIG_CRC8=y
CONFIG_XXHASH=y
# CONFIG_RANDOM32_SELFTEST is not set
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_LZO_COMPRESS=y
CONFIG_LZO_DECOMPRESS=y
CONFIG_LZ4_COMPRESS=y
CONFIG_LZ4HC_COMPRESS=y
CONFIG_LZ4_DECOMPRESS=y
CONFIG_ZSTD_COMPRESS=y
CONFIG_ZSTD_DECOMPRESS=y
CONFIG_XZ_DEC=y
# CONFIG_XZ_DEC_X86 is not set
# CONFIG_XZ_DEC_POWERPC is not set
CONFIG_XZ_DEC_IA64=y
# CONFIG_XZ_DEC_ARM is not set
CONFIG_XZ_DEC_ARMTHUMB=y
CONFIG_XZ_DEC_SPARC=y
CONFIG_XZ_DEC_BCJ=y
CONFIG_XZ_DEC_TEST=y
CONFIG_DECOMPRESS_GZIP=y
CONFIG_DECOMPRESS_BZIP2=y
CONFIG_DECOMPRESS_XZ=y
CONFIG_DECOMPRESS_ZSTD=y
CONFIG_GENERIC_ALLOCATOR=y
CONFIG_BCH=y
CONFIG_BCH_CONST_PARAMS=y
CONFIG_XARRAY_MULTI=y
CONFIG_ASSOCIATIVE_ARRAY=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT_MAP=y
CONFIG_HAS_DMA=y
CONFIG_NEED_SG_DMA_LENGTH=y
CONFIG_NEED_DMA_MAP_STATE=y
CONFIG_ARCH_DMA_ADDR_T_64BIT=y
CONFIG_DMA_DECLARE_COHERENT=y
CONFIG_SWIOTLB=y
CONFIG_DMA_CMA=y

#
# Default contiguous memory area size:
#
CONFIG_CMA_SIZE_PERCENTAGE=0
# CONFIG_CMA_SIZE_SEL_MBYTES is not set
CONFIG_CMA_SIZE_SEL_PERCENTAGE=y
# CONFIG_CMA_SIZE_SEL_MIN is not set
# CONFIG_CMA_SIZE_SEL_MAX is not set
CONFIG_CMA_ALIGNMENT=8
# CONFIG_DMA_API_DEBUG is not set
CONFIG_SGL_ALLOC=y
CONFIG_CHECK_SIGNATURE=y
CONFIG_CPU_RMAP=y
CONFIG_DQL=y
CONFIG_GLOB=y
CONFIG_GLOB_SELFTEST=y
CONFIG_NLATTR=y
CONFIG_CLZ_TAB=y
# CONFIG_IRQ_POLL is not set
CONFIG_MPILIB=y
CONFIG_LIBFDT=y
CONFIG_OID_REGISTRY=y
CONFIG_UCS2_STRING=y
CONFIG_HAVE_GENERIC_VDSO=y
CONFIG_GENERIC_GETTIMEOFDAY=y
CONFIG_GENERIC_VDSO_32=y
CONFIG_GENERIC_VDSO_TIME_NS=y
CONFIG_FONT_SUPPORT=y
CONFIG_FONT_8x16=y
CONFIG_FONT_AUTOSELECT=y
CONFIG_ARCH_STACKWALK=y
CONFIG_STACKDEPOT=y
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
# CONFIG_BOOT_PRINTK_DELAY is not set
# CONFIG_DYNAMIC_DEBUG is not set
# CONFIG_DYNAMIC_DEBUG_CORE is not set
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
# CONFIG_DEBUG_INFO_DWARF4 is not set
# CONFIG_GDB_SCRIPTS is not set
# CONFIG_ENABLE_MUST_CHECK is not set
CONFIG_FRAME_WARN=8192
# CONFIG_STRIP_ASM_SYMS is not set
CONFIG_READABLE_ASM=y
CONFIG_HEADERS_INSTALL=y
CONFIG_DEBUG_SECTION_MISMATCH=y
CONFIG_SECTION_MISMATCH_WARN_ONLY=y
CONFIG_DEBUG_FORCE_FUNCTION_ALIGN_32B=y
CONFIG_FRAME_POINTER=y
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
# end of Generic Kernel Debugging Instruments

CONFIG_DEBUG_KERNEL=y
# CONFIG_DEBUG_MISC is not set

#
# Memory Debugging
#
CONFIG_PAGE_EXTENSION=y
# CONFIG_DEBUG_PAGEALLOC is not set
CONFIG_PAGE_OWNER=y
# CONFIG_PAGE_POISONING is not set
CONFIG_DEBUG_PAGE_REF=y
# CONFIG_DEBUG_RODATA_TEST is not set
CONFIG_ARCH_HAS_DEBUG_WX=y
CONFIG_DEBUG_WX=y
CONFIG_GENERIC_PTDUMP=y
CONFIG_PTDUMP_CORE=y
# CONFIG_PTDUMP_DEBUGFS is not set
# CONFIG_DEBUG_OBJECTS is not set
CONFIG_SLUB_STATS=y
CONFIG_HAVE_DEBUG_KMEMLEAK=y
# CONFIG_DEBUG_KMEMLEAK is not set
# CONFIG_DEBUG_STACK_USAGE is not set
CONFIG_SCHED_STACK_END_CHECK=y
# CONFIG_DEBUG_VM is not set
CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
CONFIG_DEBUG_VIRTUAL=y
# CONFIG_DEBUG_MEMORY_INIT is not set
# CONFIG_DEBUG_PER_CPU_MAPS is not set
CONFIG_HAVE_DEBUG_STACKOVERFLOW=y
CONFIG_DEBUG_STACKOVERFLOW=y
CONFIG_CC_HAS_KASAN_GENERIC=y
CONFIG_CC_HAS_WORKING_NOSANITIZE_ADDRESS=y
# end of Memory Debugging

# CONFIG_DEBUG_SHIRQ is not set

#
# Debug Oops, Lockups and Hangs
#
CONFIG_PANIC_ON_OOPS=y
CONFIG_PANIC_ON_OOPS_VALUE=1
CONFIG_PANIC_TIMEOUT=0
CONFIG_LOCKUP_DETECTOR=y
CONFIG_SOFTLOCKUP_DETECTOR=y
CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC=y
CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC_VALUE=1
# CONFIG_HARDLOCKUP_DETECTOR is not set
# CONFIG_DETECT_HUNG_TASK is not set
CONFIG_WQ_WATCHDOG=y
# CONFIG_TEST_LOCKUP is not set
# end of Debug Oops, Lockups and Hangs

#
# Scheduler Debugging
#
# CONFIG_SCHED_DEBUG is not set
CONFIG_SCHED_INFO=y
CONFIG_SCHEDSTATS=y
# end of Scheduler Debugging

# CONFIG_DEBUG_TIMEKEEPING is not set
CONFIG_DEBUG_PREEMPT=y

#
# Lock Debugging (spinlocks, mutexes, etc...)
#
CONFIG_LOCK_DEBUGGING_SUPPORT=y
CONFIG_PROVE_LOCKING=y
# CONFIG_PROVE_RAW_LOCK_NESTING is not set
CONFIG_LOCK_STAT=y
CONFIG_DEBUG_RT_MUTEXES=y
CONFIG_DEBUG_SPINLOCK=y
CONFIG_DEBUG_MUTEXES=y
CONFIG_DEBUG_WW_MUTEX_SLOWPATH=y
CONFIG_DEBUG_RWSEMS=y
CONFIG_DEBUG_LOCK_ALLOC=y
CONFIG_LOCKDEP=y
# CONFIG_DEBUG_LOCKDEP is not set
CONFIG_DEBUG_ATOMIC_SLEEP=y
CONFIG_DEBUG_LOCKING_API_SELFTESTS=y
CONFIG_LOCK_TORTURE_TEST=y
CONFIG_WW_MUTEX_SELFTEST=y
# end of Lock Debugging (spinlocks, mutexes, etc...)

CONFIG_TRACE_IRQFLAGS=y
CONFIG_TRACE_IRQFLAGS_NMI=y
CONFIG_STACKTRACE=y
# CONFIG_WARN_ALL_UNSEEDED_RANDOM is not set
# CONFIG_DEBUG_KOBJECT is not set

#
# Debug kernel data structures
#
CONFIG_DEBUG_LIST=y
# CONFIG_DEBUG_PLIST is not set
# CONFIG_DEBUG_SG is not set
CONFIG_DEBUG_NOTIFIERS=y
# CONFIG_BUG_ON_DATA_CORRUPTION is not set
# end of Debug kernel data structures

CONFIG_DEBUG_CREDENTIALS=y

#
# RCU Debugging
#
CONFIG_PROVE_RCU=y
CONFIG_PROVE_RCU_LIST=y
CONFIG_TORTURE_TEST=y
CONFIG_RCU_PERF_TEST=y
# CONFIG_RCU_TORTURE_TEST is not set
# CONFIG_RCU_REF_SCALE_TEST is not set
CONFIG_RCU_CPU_STALL_TIMEOUT=21
# CONFIG_RCU_TRACE is not set
CONFIG_RCU_EQS_DEBUG=y
# end of RCU Debugging

CONFIG_DEBUG_WQ_FORCE_RR_CPU=y
CONFIG_CPU_HOTPLUG_STATE_CONTROL=y
# CONFIG_LATENCYTOP is not set
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
CONFIG_PREEMPTIRQ_TRACEPOINTS=y
CONFIG_TRACING=y
CONFIG_GENERIC_TRACER=y
CONFIG_TRACING_SUPPORT=y
CONFIG_FTRACE=y
CONFIG_BOOTTIME_TRACING=y
CONFIG_FUNCTION_TRACER=y
CONFIG_DYNAMIC_FTRACE=y
CONFIG_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=y
# CONFIG_FUNCTION_PROFILER is not set
CONFIG_STACK_TRACER=y
CONFIG_IRQSOFF_TRACER=y
# CONFIG_PREEMPT_TRACER is not set
CONFIG_SCHED_TRACER=y
CONFIG_HWLAT_TRACER=y
# CONFIG_MMIOTRACE is not set
CONFIG_FTRACE_SYSCALLS=y
CONFIG_TRACER_SNAPSHOT=y
CONFIG_TRACER_SNAPSHOT_PER_CPU_SWAP=y
CONFIG_BRANCH_PROFILE_NONE=y
# CONFIG_PROFILE_ANNOTATED_BRANCHES is not set
# CONFIG_UPROBE_EVENTS is not set
CONFIG_FTRACE_MCOUNT_RECORD=y
# CONFIG_SYNTH_EVENTS is not set
# CONFIG_HIST_TRIGGERS is not set
# CONFIG_TRACE_EVENT_INJECT is not set
CONFIG_TRACEPOINT_BENCHMARK=y
CONFIG_RING_BUFFER_BENCHMARK=y
# CONFIG_TRACE_EVAL_MAP_FILE is not set
# CONFIG_FTRACE_STARTUP_TEST is not set
# CONFIG_RING_BUFFER_STARTUP_TEST is not set
# CONFIG_PREEMPTIRQ_DELAY_TEST is not set
# CONFIG_PROVIDE_OHCI1394_DMA_INIT is not set
# CONFIG_SAMPLES is not set
CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y
CONFIG_STRICT_DEVMEM=y
CONFIG_IO_STRICT_DEVMEM=y

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
CONFIG_EFI_PGT_DUMP=y
# CONFIG_DEBUG_TLBFLUSH is not set
CONFIG_HAVE_MMIOTRACE_SUPPORT=y
# CONFIG_X86_DECODER_SELFTEST is not set
# CONFIG_IO_DELAY_0X80 is not set
# CONFIG_IO_DELAY_0XED is not set
# CONFIG_IO_DELAY_UDELAY is not set
CONFIG_IO_DELAY_NONE=y
# CONFIG_DEBUG_BOOT_PARAMS is not set
# CONFIG_CPA_DEBUG is not set
CONFIG_DEBUG_ENTRY=y
CONFIG_DEBUG_NMI_SELFTEST=y
CONFIG_X86_DEBUG_FPU=y
# CONFIG_PUNIT_ATOM_DEBUG is not set
CONFIG_UNWINDER_FRAME_POINTER=y
# end of x86 Debugging

#
# Kernel Testing and Coverage
#
# CONFIG_KUNIT is not set
# CONFIG_NOTIFIER_ERROR_INJECTION is not set
# CONFIG_FAULT_INJECTION is not set
CONFIG_CC_HAS_SANCOV_TRACE_PC=y
# CONFIG_RUNTIME_TESTING_MENU is not set
CONFIG_MEMTEST=y
CONFIG_HYPERV_TESTING=y
# end of Kernel Testing and Coverage
# end of Kernel hacking

--=_5f8dc512.rwdag2xu/8z1nAkUsoq8Xyiq2TWdT0Slqmlff4YZBT2TgiNl
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="config-5.9.0-rc8-00208-g4d004099a668c4"

#
# Automatically generated file; DO NOT EDIT.
# Linux/i386 5.9.0-rc8 Kernel Configuration
#
CONFIG_CC_VERSION_TEXT="gcc-9 (Debian 9.3.0-15) 9.3.0"
CONFIG_CC_IS_GCC=y
CONFIG_GCC_VERSION=90300
CONFIG_LD_VERSION=235000000
CONFIG_CLANG_VERSION=0
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
# CONFIG_KERNEL_GZIP is not set
CONFIG_KERNEL_BZIP2=y
# CONFIG_KERNEL_LZMA is not set
# CONFIG_KERNEL_XZ is not set
# CONFIG_KERNEL_LZO is not set
# CONFIG_KERNEL_LZ4 is not set
# CONFIG_KERNEL_ZSTD is not set
CONFIG_DEFAULT_INIT=""
CONFIG_DEFAULT_HOSTNAME="(none)"
CONFIG_SYSVIPC=y
CONFIG_SYSVIPC_SYSCTL=y
# CONFIG_POSIX_MQUEUE is not set
CONFIG_WATCH_QUEUE=y
# CONFIG_CROSS_MEMORY_ATTACH is not set
# CONFIG_USELIB is not set
# CONFIG_AUDIT is not set
CONFIG_HAVE_ARCH_AUDITSYSCALL=y

#
# IRQ subsystem
#
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_GENERIC_IRQ_SHOW=y
CONFIG_GENERIC_IRQ_EFFECTIVE_AFF_MASK=y
CONFIG_GENERIC_PENDING_IRQ=y
CONFIG_GENERIC_IRQ_MIGRATION=y
CONFIG_HARDIRQS_SW_RESEND=y
CONFIG_GENERIC_IRQ_CHIP=y
CONFIG_IRQ_DOMAIN=y
CONFIG_IRQ_DOMAIN_HIERARCHY=y
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

#
# Timers subsystem
#
CONFIG_HZ_PERIODIC=y
# CONFIG_NO_HZ_IDLE is not set
# CONFIG_NO_HZ is not set
# CONFIG_HIGH_RES_TIMERS is not set
# end of Timers subsystem

# CONFIG_PREEMPT_NONE is not set
# CONFIG_PREEMPT_VOLUNTARY is not set
CONFIG_PREEMPT=y
CONFIG_PREEMPT_COUNT=y
CONFIG_PREEMPTION=y

#
# CPU/Task time and stats accounting
#
CONFIG_TICK_CPU_ACCOUNTING=y
# CONFIG_IRQ_TIME_ACCOUNTING is not set
CONFIG_HAVE_SCHED_AVG_IRQ=y
# CONFIG_BSD_PROCESS_ACCT is not set
# CONFIG_TASKSTATS is not set
# CONFIG_PSI is not set
# end of CPU/Task time and stats accounting

CONFIG_CPU_ISOLATION=y

#
# RCU Subsystem
#
CONFIG_TREE_RCU=y
CONFIG_PREEMPT_RCU=y
CONFIG_RCU_EXPERT=y
CONFIG_SRCU=y
CONFIG_TREE_SRCU=y
CONFIG_TASKS_RCU_GENERIC=y
CONFIG_TASKS_RCU=y
CONFIG_TASKS_RUDE_RCU=y
CONFIG_TASKS_TRACE_RCU=y
CONFIG_RCU_STALL_COMMON=y
CONFIG_RCU_NEED_SEGCBLIST=y
CONFIG_RCU_FANOUT=32
CONFIG_RCU_FANOUT_LEAF=16
CONFIG_RCU_BOOST=y
CONFIG_RCU_BOOST_DELAY=500
# CONFIG_RCU_NOCB_CPU is not set
# CONFIG_TASKS_TRACE_RCU_READ_MB is not set
# end of RCU Subsystem

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

CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=y
CONFIG_CGROUPS=y
CONFIG_PAGE_COUNTER=y
CONFIG_MEMCG=y
CONFIG_MEMCG_KMEM=y
# CONFIG_CGROUP_SCHED is not set
# CONFIG_CGROUP_PIDS is not set
CONFIG_CGROUP_RDMA=y
CONFIG_CGROUP_FREEZER=y
# CONFIG_CPUSETS is not set
CONFIG_CGROUP_DEVICE=y
CONFIG_CGROUP_CPUACCT=y
CONFIG_CGROUP_PERF=y
# CONFIG_CGROUP_DEBUG is not set
CONFIG_SOCK_CGROUP_DATA=y
# CONFIG_NAMESPACES is not set
# CONFIG_CHECKPOINT_RESTORE is not set
# CONFIG_SCHED_AUTOGROUP is not set
# CONFIG_SYSFS_DEPRECATED is not set
# CONFIG_RELAY is not set
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_RD_GZIP=y
CONFIG_RD_BZIP2=y
# CONFIG_RD_LZMA is not set
CONFIG_RD_XZ=y
# CONFIG_RD_LZO is not set
# CONFIG_RD_LZ4 is not set
CONFIG_RD_ZSTD=y
CONFIG_BOOT_CONFIG=y
# CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE is not set
CONFIG_CC_OPTIMIZE_FOR_SIZE=y
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
# CONFIG_POSIX_TIMERS is not set
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
# CONFIG_ADVISE_SYSCALLS is not set
# CONFIG_MEMBARRIER is not set
CONFIG_KALLSYMS=y
CONFIG_KALLSYMS_ALL=y
CONFIG_KALLSYMS_BASE_RELATIVE=y
# CONFIG_BPF_SYSCALL is not set
# CONFIG_USERFAULTFD is not set
CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=y
# CONFIG_RSEQ is not set
CONFIG_EMBEDDED=y
CONFIG_HAVE_PERF_EVENTS=y
CONFIG_PC104=y

#
# Kernel Performance Events And Counters
#
CONFIG_PERF_EVENTS=y
# CONFIG_DEBUG_PERF_USE_VMALLOC is not set
# end of Kernel Performance Events And Counters

CONFIG_VM_EVENT_COUNTERS=y
# CONFIG_SLUB_DEBUG is not set
# CONFIG_SLUB_MEMCG_SYSFS_ON is not set
# CONFIG_COMPAT_BRK is not set
# CONFIG_SLAB is not set
CONFIG_SLUB=y
# CONFIG_SLOB is not set
# CONFIG_SLAB_MERGE_DEFAULT is not set
# CONFIG_SLAB_FREELIST_RANDOM is not set
# CONFIG_SLAB_FREELIST_HARDENED is not set
# CONFIG_SHUFFLE_PAGE_ALLOCATOR is not set
# CONFIG_SLUB_CPU_PARTIAL is not set
# CONFIG_PROFILING is not set
CONFIG_TRACEPOINTS=y
# end of General setup

CONFIG_X86_32=y
CONFIG_FORCE_DYNAMIC_FTRACE=y
CONFIG_X86=y
CONFIG_INSTRUCTION_DECODER=y
CONFIG_OUTPUT_FORMAT="elf32-i386"
CONFIG_LOCKDEP_SUPPORT=y
CONFIG_STACKTRACE_SUPPORT=y
CONFIG_MMU=y
CONFIG_ARCH_MMAP_RND_BITS_MIN=8
CONFIG_ARCH_MMAP_RND_BITS_MAX=16
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MIN=8
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MAX=16
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_BUG=y
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
CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
CONFIG_X86_32_SMP=y
CONFIG_ARCH_SUPPORTS_UPROBES=y
CONFIG_FIX_EARLYCON_MEM=y
CONFIG_PGTABLE_LEVELS=3
CONFIG_CC_HAS_SANE_STACKPROTECTOR=y

#
# Processor type and features
#
# CONFIG_ZONE_DMA is not set
CONFIG_SMP=y
CONFIG_X86_FEATURE_NAMES=y
# CONFIG_X86_MPPARSE is not set
CONFIG_GOLDFISH=y
CONFIG_RETPOLINE=y
# CONFIG_X86_CPU_RESCTRL is not set
# CONFIG_X86_BIGSMP is not set
# CONFIG_X86_EXTENDED_PLATFORM is not set
# CONFIG_X86_INTEL_LPSS is not set
CONFIG_X86_AMD_PLATFORM_DEVICE=y
# CONFIG_IOSF_MBI is not set
# CONFIG_X86_32_IRIS is not set
# CONFIG_SCHED_OMIT_FRAME_POINTER is not set
CONFIG_HYPERVISOR_GUEST=y
CONFIG_PARAVIRT=y
# CONFIG_PARAVIRT_DEBUG is not set
CONFIG_PARAVIRT_SPINLOCKS=y
CONFIG_X86_HV_CALLBACK_VECTOR=y
CONFIG_KVM_GUEST=y
CONFIG_ARCH_CPUIDLE_HALTPOLL=y
# CONFIG_PVH is not set
CONFIG_PARAVIRT_TIME_ACCOUNTING=y
CONFIG_PARAVIRT_CLOCK=y
# CONFIG_M486SX is not set
# CONFIG_M486 is not set
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
# CONFIG_M686 is not set
# CONFIG_MPENTIUMII is not set
# CONFIG_MPENTIUMIII is not set
# CONFIG_MPENTIUMM is not set
# CONFIG_MPENTIUM4 is not set
# CONFIG_MK6 is not set
# CONFIG_MK7 is not set
# CONFIG_MK8 is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MEFFICEON is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP3D is not set
CONFIG_MELAN=y
# CONFIG_MGEODEGX1 is not set
# CONFIG_MGEODE_LX is not set
# CONFIG_MCYRIXIII is not set
# CONFIG_MVIAC3_2 is not set
# CONFIG_MVIAC7 is not set
# CONFIG_MCORE2 is not set
# CONFIG_MATOM is not set
# CONFIG_X86_GENERIC is not set
CONFIG_X86_INTERNODE_CACHE_SHIFT=4
CONFIG_X86_L1_CACHE_SHIFT=4
CONFIG_X86_ALIGNMENT_16=y
CONFIG_X86_CMPXCHG64=y
CONFIG_X86_MINIMUM_CPU_FAMILY=5
CONFIG_X86_DEBUGCTLMSR=y
CONFIG_IA32_FEAT_CTL=y
CONFIG_X86_VMX_FEATURE_NAMES=y
# CONFIG_PROCESSOR_SELECT is not set
CONFIG_CPU_SUP_INTEL=y
CONFIG_CPU_SUP_CYRIX_32=y
CONFIG_CPU_SUP_AMD=y
CONFIG_CPU_SUP_HYGON=y
CONFIG_CPU_SUP_CENTAUR=y
CONFIG_CPU_SUP_TRANSMETA_32=y
CONFIG_CPU_SUP_UMC_32=y
CONFIG_CPU_SUP_ZHAOXIN=y
CONFIG_HPET_TIMER=y
CONFIG_HPET_EMULATE_RTC=y
CONFIG_DMI=y
CONFIG_NR_CPUS_RANGE_BEGIN=2
CONFIG_NR_CPUS_RANGE_END=8
CONFIG_NR_CPUS_DEFAULT=8
CONFIG_NR_CPUS=8
CONFIG_SCHED_SMT=y
# CONFIG_SCHED_MC is not set
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS=y
# CONFIG_X86_MCE is not set

#
# Performance monitoring
#
CONFIG_PERF_EVENTS_INTEL_UNCORE=y
CONFIG_PERF_EVENTS_INTEL_RAPL=y
CONFIG_PERF_EVENTS_INTEL_CSTATE=y
CONFIG_PERF_EVENTS_AMD_POWER=y
# end of Performance monitoring

# CONFIG_X86_LEGACY_VM86 is not set
# CONFIG_X86_IOPL_IOPERM is not set
CONFIG_TOSHIBA=y
CONFIG_I8K=y
# CONFIG_X86_REBOOTFIXUPS is not set
# CONFIG_MICROCODE is not set
CONFIG_X86_MSR=y
# CONFIG_X86_CPUID is not set
CONFIG_NOHIGHMEM=y
# CONFIG_HIGHMEM4G is not set
CONFIG_VMSPLIT_3G=y
# CONFIG_VMSPLIT_2G is not set
# CONFIG_VMSPLIT_1G is not set
CONFIG_PAGE_OFFSET=0xC0000000
CONFIG_X86_PAE=y
CONFIG_X86_CPA_STATISTICS=y
CONFIG_ARCH_FLATMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SELECT_MEMORY_MODEL=y
CONFIG_ILLEGAL_POINTER_VALUE=0
# CONFIG_X86_CHECK_BIOS_CORRUPTION is not set
CONFIG_X86_RESERVE_LOW=64
# CONFIG_MTRR is not set
CONFIG_ARCH_RANDOM=y
# CONFIG_X86_SMAP is not set
# CONFIG_X86_UMIP is not set
CONFIG_X86_INTEL_TSX_MODE_OFF=y
# CONFIG_X86_INTEL_TSX_MODE_ON is not set
# CONFIG_X86_INTEL_TSX_MODE_AUTO is not set
CONFIG_EFI=y
CONFIG_EFI_STUB=y
CONFIG_SECCOMP=y
# CONFIG_HZ_100 is not set
CONFIG_HZ_250=y
# CONFIG_HZ_300 is not set
# CONFIG_HZ_1000 is not set
CONFIG_HZ=250
CONFIG_KEXEC=y
CONFIG_PHYSICAL_START=0x1000000
CONFIG_RELOCATABLE=y
# CONFIG_RANDOMIZE_BASE is not set
CONFIG_X86_NEED_RELOCS=y
CONFIG_PHYSICAL_ALIGN=0x200000
CONFIG_HOTPLUG_CPU=y
# CONFIG_BOOTPARAM_HOTPLUG_CPU0 is not set
CONFIG_DEBUG_HOTPLUG_CPU0=y
# CONFIG_COMPAT_VDSO is not set
# CONFIG_CMDLINE_BOOL is not set
# CONFIG_MODIFY_LDT_SYSCALL is not set
# end of Processor type and features

CONFIG_ARCH_ENABLE_SPLIT_PMD_PTLOCK=y

#
# Power management and ACPI options
#
CONFIG_SUSPEND=y
CONFIG_SUSPEND_FREEZER=y
# CONFIG_SUSPEND_SKIP_SYNC is not set
CONFIG_PM_SLEEP=y
CONFIG_PM_SLEEP_SMP=y
# CONFIG_PM_AUTOSLEEP is not set
# CONFIG_PM_WAKELOCKS is not set
CONFIG_PM=y
CONFIG_PM_DEBUG=y
CONFIG_PM_ADVANCED_DEBUG=y
# CONFIG_PM_TEST_SUSPEND is not set
CONFIG_PM_SLEEP_DEBUG=y
CONFIG_DPM_WATCHDOG=y
CONFIG_DPM_WATCHDOG_TIMEOUT=120
# CONFIG_PM_TRACE_RTC is not set
CONFIG_PM_CLK=y
# CONFIG_WQ_POWER_EFFICIENT_DEFAULT is not set
CONFIG_ARCH_SUPPORTS_ACPI=y
CONFIG_ACPI=y
CONFIG_ACPI_LEGACY_TABLES_LOOKUP=y
CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC=y
CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT=y
CONFIG_ACPI_DEBUGGER=y
# CONFIG_ACPI_DEBUGGER_USER is not set
# CONFIG_ACPI_SPCR_TABLE is not set
CONFIG_ACPI_SLEEP=y
CONFIG_ACPI_REV_OVERRIDE_POSSIBLE=y
CONFIG_ACPI_EC_DEBUGFS=y
# CONFIG_ACPI_AC is not set
# CONFIG_ACPI_BATTERY is not set
# CONFIG_ACPI_BUTTON is not set
CONFIG_ACPI_TINY_POWER_BUTTON=y
CONFIG_ACPI_TINY_POWER_BUTTON_SIGNAL=38
CONFIG_ACPI_VIDEO=y
CONFIG_ACPI_FAN=y
CONFIG_ACPI_TAD=y
# CONFIG_ACPI_DOCK is not set
CONFIG_ACPI_CPU_FREQ_PSS=y
CONFIG_ACPI_PROCESSOR_CSTATE=y
CONFIG_ACPI_PROCESSOR_IDLE=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_HOTPLUG_CPU=y
# CONFIG_ACPI_PROCESSOR_AGGREGATOR is not set
CONFIG_ACPI_THERMAL=y
CONFIG_ACPI_CUSTOM_DSDT_FILE=""
CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
# CONFIG_ACPI_TABLE_UPGRADE is not set
CONFIG_ACPI_DEBUG=y
# CONFIG_ACPI_PCI_SLOT is not set
CONFIG_ACPI_CONTAINER=y
CONFIG_ACPI_HOTPLUG_IOAPIC=y
CONFIG_ACPI_SBS=y
CONFIG_ACPI_HED=y
CONFIG_ACPI_CUSTOM_METHOD=y
# CONFIG_ACPI_BGRT is not set
# CONFIG_ACPI_REDUCED_HARDWARE_ONLY is not set
CONFIG_HAVE_ACPI_APEI=y
CONFIG_HAVE_ACPI_APEI_NMI=y
CONFIG_ACPI_APEI=y
# CONFIG_ACPI_APEI_GHES is not set
# CONFIG_ACPI_APEI_EINJ is not set
CONFIG_ACPI_APEI_ERST_DEBUG=y
# CONFIG_DPTF_POWER is not set
# CONFIG_PMIC_OPREGION is not set
CONFIG_ACPI_CONFIGFS=y
CONFIG_X86_PM_TIMER=y
CONFIG_SFI=y
CONFIG_X86_APM_BOOT=y
CONFIG_APM=y
CONFIG_APM_IGNORE_USER_SUSPEND=y
# CONFIG_APM_DO_ENABLE is not set
CONFIG_APM_CPU_IDLE=y
CONFIG_APM_DISPLAY_BLANK=y
# CONFIG_APM_ALLOW_INTS is not set

#
# CPU Frequency scaling
#
# CONFIG_CPU_FREQ is not set
# end of CPU Frequency scaling

#
# CPU Idle
#
CONFIG_CPU_IDLE=y
CONFIG_CPU_IDLE_GOV_LADDER=y
# CONFIG_CPU_IDLE_GOV_MENU is not set
# CONFIG_CPU_IDLE_GOV_TEO is not set
CONFIG_CPU_IDLE_GOV_HALTPOLL=y
CONFIG_HALTPOLL_CPUIDLE=y
# end of CPU Idle

# CONFIG_INTEL_IDLE is not set
# end of Power management and ACPI options

#
# Bus options (PCI etc.)
#
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GOMMCONFIG is not set
# CONFIG_PCI_GODIRECT is not set
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
# CONFIG_PCI_CNB20LE_QUIRK is not set
# CONFIG_ISA_BUS is not set
CONFIG_ISA_DMA_API=y
# CONFIG_ISA is not set
CONFIG_SCx200=y
CONFIG_SCx200HR_TIMER=y
# CONFIG_ALIX is not set
CONFIG_NET5501=y
# CONFIG_GEOS is not set
CONFIG_TS5500=y
CONFIG_AMD_NB=y
CONFIG_X86_SYSFB=y
# end of Bus options (PCI etc.)

#
# Binary Emulations
#
CONFIG_COMPAT_32=y
# end of Binary Emulations

CONFIG_HAVE_ATOMIC_IOMAP=y

#
# Firmware Drivers
#
CONFIG_EDD=y
# CONFIG_EDD_OFF is not set
CONFIG_FIRMWARE_MEMMAP=y
# CONFIG_DMIID is not set
# CONFIG_DMI_SYSFS is not set
CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK=y
# CONFIG_FW_CFG_SYSFS is not set
# CONFIG_GOOGLE_FIRMWARE is not set

#
# EFI (Extensible Firmware Interface) Support
#
CONFIG_EFI_VARS=y
CONFIG_EFI_ESRT=y
# CONFIG_EFI_VARS_PSTORE is not set
# CONFIG_EFI_RUNTIME_MAP is not set
# CONFIG_EFI_FAKE_MEMMAP is not set
CONFIG_EFI_RUNTIME_WRAPPERS=y
CONFIG_EFI_GENERIC_STUB_INITRD_CMDLINE_LOADER=y
CONFIG_EFI_BOOTLOADER_CONTROL=y
CONFIG_EFI_CAPSULE_LOADER=y
CONFIG_EFI_CAPSULE_QUIRK_QUARK_CSH=y
CONFIG_EFI_TEST=y
CONFIG_APPLE_PROPERTIES=y
CONFIG_RESET_ATTACK_MITIGATION=y
CONFIG_EFI_RCI2_TABLE=y
# CONFIG_EFI_DISABLE_PCI_DMA is not set
# end of EFI (Extensible Firmware Interface) Support

CONFIG_UEFI_CPER=y
CONFIG_UEFI_CPER_X86=y
CONFIG_EFI_DEV_PATH_PARSER=y
CONFIG_EFI_EARLYCON=y
# CONFIG_EFI_CUSTOM_SSDT_OVERLAYS is not set

#
# Tegra firmware driver
#
# end of Tegra firmware driver
# end of Firmware Drivers

CONFIG_HAVE_KVM=y
# CONFIG_VIRTUALIZATION is not set
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
CONFIG_HAVE_OPROFILE=y
CONFIG_OPROFILE_NMI_TIMER=y
# CONFIG_KPROBES is not set
# CONFIG_JUMP_LABEL is not set
CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y
CONFIG_ARCH_USE_BUILTIN_BSWAP=y
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
CONFIG_ARCH_32BIT_OFF_T=y
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
CONFIG_ARCH_WANT_IPC_PARSE_VERSION=y
CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
CONFIG_SECCOMP_FILTER=y
CONFIG_HAVE_ARCH_STACKLEAK=y
CONFIG_HAVE_STACKPROTECTOR=y
CONFIG_STACKPROTECTOR=y
CONFIG_STACKPROTECTOR_STRONG=y
CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES=y
CONFIG_HAVE_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_MOVE_PMD=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=y
CONFIG_HAVE_ARCH_HUGE_VMAP=y
CONFIG_ARCH_WANT_HUGE_PMD_SHARE=y
CONFIG_HAVE_MOD_ARCH_SPECIFIC=y
CONFIG_MODULES_USE_ELF_REL=y
CONFIG_ARCH_HAS_ELF_RANDOMIZE=y
CONFIG_HAVE_ARCH_MMAP_RND_BITS=y
CONFIG_HAVE_EXIT_THREAD=y
CONFIG_ARCH_MMAP_RND_BITS=8
CONFIG_ISA_BUS_API=y
CONFIG_CLONE_BACKWARDS=y
CONFIG_OLD_SIGSUSPEND3=y
CONFIG_OLD_SIGACTION=y
CONFIG_COMPAT_32BIT_TIME=y
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
CONFIG_MODULES=y
# CONFIG_MODULE_FORCE_LOAD is not set
# CONFIG_MODULE_UNLOAD is not set
# CONFIG_MODVERSIONS is not set
# CONFIG_MODULE_SRCVERSION_ALL is not set
# CONFIG_MODULE_SIG is not set
# CONFIG_MODULE_COMPRESS is not set
# CONFIG_MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS is not set
CONFIG_UNUSED_SYMBOLS=y
CONFIG_MODULES_TREE_LOOKUP=y
# CONFIG_BLOCK is not set
CONFIG_PADATA=y
CONFIG_ASN1=y
CONFIG_UNINLINE_SPIN_UNLOCK=y
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
CONFIG_ELFCORE=y
CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS=y
CONFIG_BINFMT_SCRIPT=y
CONFIG_BINFMT_MISC=y
CONFIG_COREDUMP=y
# end of Executable file formats

#
# Memory Management options
#
CONFIG_SELECT_MEMORY_MODEL=y
CONFIG_FLATMEM_MANUAL=y
# CONFIG_SPARSEMEM_MANUAL is not set
CONFIG_FLATMEM=y
CONFIG_FLAT_NODE_MEM_MAP=y
CONFIG_SPARSEMEM_STATIC=y
CONFIG_HAVE_FAST_GUP=y
CONFIG_MEMORY_ISOLATION=y
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_COMPACTION=y
# CONFIG_PAGE_REPORTING is not set
CONFIG_MIGRATION=y
CONFIG_CONTIG_ALLOC=y
CONFIG_PHYS_ADDR_T_64BIT=y
CONFIG_VIRT_TO_BUS=y
# CONFIG_KSM is not set
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
CONFIG_TRANSPARENT_HUGEPAGE=y
CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS=y
# CONFIG_TRANSPARENT_HUGEPAGE_MADVISE is not set
CONFIG_CLEANCACHE=y
CONFIG_CMA=y
# CONFIG_CMA_DEBUG is not set
CONFIG_CMA_DEBUGFS=y
CONFIG_CMA_AREAS=7
# CONFIG_ZPOOL is not set
CONFIG_ZBUD=y
CONFIG_ZSMALLOC=y
# CONFIG_ZSMALLOC_PGTABLE_MAPPING is not set
# CONFIG_ZSMALLOC_STAT is not set
CONFIG_GENERIC_EARLY_IOREMAP=y
CONFIG_IDLE_PAGE_TRACKING=y
CONFIG_FRAME_VECTOR=y
CONFIG_PERCPU_STATS=y
CONFIG_GUP_BENCHMARK=y
CONFIG_GUP_GET_PTE_LOW_HIGH=y
# CONFIG_READ_ONLY_THP_FOR_FS is not set
CONFIG_ARCH_HAS_PTE_SPECIAL=y
# end of Memory Management options

CONFIG_NET=y

#
# Networking options
#
CONFIG_PACKET=y
CONFIG_PACKET_DIAG=y
CONFIG_UNIX=y
CONFIG_UNIX_SCM=y
CONFIG_UNIX_DIAG=y
# CONFIG_TLS is not set
# CONFIG_XFRM_USER is not set
# CONFIG_NET_KEY is not set
CONFIG_INET=y
# CONFIG_IP_MULTICAST is not set
# CONFIG_IP_ADVANCED_ROUTER is not set
CONFIG_IP_PNP=y
CONFIG_IP_PNP_DHCP=y
# CONFIG_IP_PNP_BOOTP is not set
# CONFIG_IP_PNP_RARP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE_DEMUX is not set
CONFIG_NET_IP_TUNNEL=y
# CONFIG_SYN_COOKIES is not set
# CONFIG_NET_IPVTI is not set
# CONFIG_NET_FOU is not set
# CONFIG_NET_FOU_IP_TUNNELS is not set
# CONFIG_INET_AH is not set
# CONFIG_INET_ESP is not set
# CONFIG_INET_IPCOMP is not set
CONFIG_INET_TUNNEL=y
CONFIG_INET_DIAG=y
CONFIG_INET_TCP_DIAG=y
# CONFIG_INET_UDP_DIAG is not set
# CONFIG_INET_RAW_DIAG is not set
# CONFIG_INET_DIAG_DESTROY is not set
# CONFIG_TCP_CONG_ADVANCED is not set
CONFIG_TCP_CONG_CUBIC=y
CONFIG_DEFAULT_TCP_CONG="cubic"
# CONFIG_TCP_MD5SIG is not set
CONFIG_IPV6=y
# CONFIG_IPV6_ROUTER_PREF is not set
# CONFIG_IPV6_OPTIMISTIC_DAD is not set
# CONFIG_INET6_AH is not set
# CONFIG_INET6_ESP is not set
# CONFIG_INET6_IPCOMP is not set
# CONFIG_IPV6_MIP6 is not set
# CONFIG_IPV6_VTI is not set
CONFIG_IPV6_SIT=y
# CONFIG_IPV6_SIT_6RD is not set
CONFIG_IPV6_NDISC_NODETYPE=y
# CONFIG_IPV6_TUNNEL is not set
# CONFIG_IPV6_MULTIPLE_TABLES is not set
# CONFIG_IPV6_MROUTE is not set
# CONFIG_IPV6_SEG6_LWTUNNEL is not set
# CONFIG_IPV6_SEG6_HMAC is not set
# CONFIG_IPV6_RPL_LWTUNNEL is not set
# CONFIG_MPTCP is not set
CONFIG_NETWORK_SECMARK=y
# CONFIG_NETWORK_PHY_TIMESTAMPING is not set
# CONFIG_NETFILTER is not set
# CONFIG_BPFILTER is not set
# CONFIG_IP_DCCP is not set
# CONFIG_IP_SCTP is not set
# CONFIG_RDS is not set
# CONFIG_TIPC is not set
CONFIG_ATM=y
# CONFIG_ATM_CLIP is not set
CONFIG_ATM_LANE=y
# CONFIG_ATM_MPOA is not set
# CONFIG_ATM_BR2684 is not set
# CONFIG_L2TP is not set
CONFIG_STP=y
CONFIG_GARP=y
CONFIG_MRP=y
CONFIG_BRIDGE=y
CONFIG_BRIDGE_IGMP_SNOOPING=y
CONFIG_BRIDGE_VLAN_FILTERING=y
# CONFIG_BRIDGE_MRP is not set
CONFIG_HAVE_NET_DSA=y
# CONFIG_NET_DSA is not set
CONFIG_VLAN_8021Q=y
CONFIG_VLAN_8021Q_GVRP=y
CONFIG_VLAN_8021Q_MVRP=y
CONFIG_DECNET=y
CONFIG_DECNET_ROUTER=y
CONFIG_LLC=y
CONFIG_LLC2=y
CONFIG_ATALK=y
CONFIG_DEV_APPLETALK=y
CONFIG_IPDDP=y
CONFIG_IPDDP_ENCAP=y
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_PHONET is not set
# CONFIG_6LOWPAN is not set
# CONFIG_IEEE802154 is not set
CONFIG_NET_SCHED=y

#
# Queueing/Scheduling
#
CONFIG_NET_SCH_CBQ=y
CONFIG_NET_SCH_HTB=y
CONFIG_NET_SCH_HFSC=y
CONFIG_NET_SCH_ATM=y
CONFIG_NET_SCH_PRIO=y
# CONFIG_NET_SCH_MULTIQ is not set
# CONFIG_NET_SCH_RED is not set
CONFIG_NET_SCH_SFB=y
CONFIG_NET_SCH_SFQ=y
CONFIG_NET_SCH_TEQL=y
CONFIG_NET_SCH_TBF=y
# CONFIG_NET_SCH_CBS is not set
# CONFIG_NET_SCH_ETF is not set
CONFIG_NET_SCH_TAPRIO=y
CONFIG_NET_SCH_GRED=y
CONFIG_NET_SCH_DSMARK=y
CONFIG_NET_SCH_NETEM=y
# CONFIG_NET_SCH_DRR is not set
CONFIG_NET_SCH_MQPRIO=y
CONFIG_NET_SCH_SKBPRIO=y
CONFIG_NET_SCH_CHOKE=y
CONFIG_NET_SCH_QFQ=y
CONFIG_NET_SCH_CODEL=y
CONFIG_NET_SCH_FQ_CODEL=y
CONFIG_NET_SCH_CAKE=y
CONFIG_NET_SCH_FQ=y
CONFIG_NET_SCH_HHF=y
CONFIG_NET_SCH_PIE=y
# CONFIG_NET_SCH_FQ_PIE is not set
CONFIG_NET_SCH_PLUG=y
CONFIG_NET_SCH_ETS=y
# CONFIG_NET_SCH_DEFAULT is not set

#
# Classification
#
CONFIG_NET_CLS=y
CONFIG_NET_CLS_BASIC=y
# CONFIG_NET_CLS_TCINDEX is not set
# CONFIG_NET_CLS_ROUTE4 is not set
CONFIG_NET_CLS_FW=y
CONFIG_NET_CLS_U32=y
# CONFIG_CLS_U32_PERF is not set
# CONFIG_CLS_U32_MARK is not set
CONFIG_NET_CLS_RSVP=y
CONFIG_NET_CLS_RSVP6=y
# CONFIG_NET_CLS_FLOW is not set
CONFIG_NET_CLS_CGROUP=y
CONFIG_NET_CLS_BPF=y
CONFIG_NET_CLS_FLOWER=y
# CONFIG_NET_CLS_MATCHALL is not set
# CONFIG_NET_EMATCH is not set
# CONFIG_NET_CLS_ACT is not set
CONFIG_NET_SCH_FIFO=y
CONFIG_DCB=y
CONFIG_DNS_RESOLVER=y
# CONFIG_BATMAN_ADV is not set
# CONFIG_OPENVSWITCH is not set
CONFIG_VSOCKETS=y
# CONFIG_VSOCKETS_DIAG is not set
CONFIG_VSOCKETS_LOOPBACK=y
CONFIG_VIRTIO_VSOCKETS=y
CONFIG_VIRTIO_VSOCKETS_COMMON=y
CONFIG_HYPERV_VSOCKETS=y
CONFIG_NETLINK_DIAG=y
CONFIG_MPLS=y
CONFIG_NET_MPLS_GSO=y
CONFIG_MPLS_ROUTING=y
# CONFIG_MPLS_IPTUNNEL is not set
CONFIG_NET_NSH=y
CONFIG_HSR=y
# CONFIG_NET_SWITCHDEV is not set
# CONFIG_NET_L3_MASTER_DEV is not set
# CONFIG_QRTR is not set
# CONFIG_NET_NCSI is not set
CONFIG_RPS=y
CONFIG_RFS_ACCEL=y
CONFIG_XPS=y
# CONFIG_CGROUP_NET_PRIO is not set
CONFIG_CGROUP_NET_CLASSID=y
CONFIG_NET_RX_BUSY_POLL=y
CONFIG_BQL=y
# CONFIG_BPF_JIT is not set
CONFIG_NET_FLOW_LIMIT=y

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
# CONFIG_NET_DROP_MONITOR is not set
# end of Network testing
# end of Networking options

CONFIG_HAMRADIO=y

#
# Packet Radio protocols
#
# CONFIG_AX25 is not set
# CONFIG_CAN is not set
CONFIG_BT=y
# CONFIG_BT_BREDR is not set
# CONFIG_BT_LE is not set
# CONFIG_BT_LEDS is not set
# CONFIG_BT_MSFTEXT is not set
CONFIG_BT_DEBUGFS=y
# CONFIG_BT_SELFTEST is not set
# CONFIG_BT_FEATURE_DEBUG is not set

#
# Bluetooth device drivers
#
CONFIG_BT_INTEL=y
CONFIG_BT_BCM=y
CONFIG_BT_HCIBTUSB=y
# CONFIG_BT_HCIBTUSB_AUTOSUSPEND is not set
CONFIG_BT_HCIBTUSB_BCM=y
# CONFIG_BT_HCIBTUSB_MTK is not set
# CONFIG_BT_HCIBTUSB_RTL is not set
# CONFIG_BT_HCIUART is not set
CONFIG_BT_HCIBCM203X=y
CONFIG_BT_HCIBPA10X=y
# CONFIG_BT_HCIBFUSB is not set
CONFIG_BT_HCIDTL1=y
CONFIG_BT_HCIBT3C=y
CONFIG_BT_HCIBLUECARD=y
# CONFIG_BT_HCIVHCI is not set
# CONFIG_BT_MRVL is not set
CONFIG_BT_ATH3K=y
CONFIG_BT_MTKUART=y
# end of Bluetooth device drivers

# CONFIG_AF_RXRPC is not set
# CONFIG_AF_KCM is not set
CONFIG_FIB_RULES=y
# CONFIG_WIRELESS is not set
CONFIG_WIMAX=y
CONFIG_WIMAX_DEBUG_LEVEL=8
CONFIG_RFKILL=y
CONFIG_RFKILL_LEDS=y
CONFIG_RFKILL_INPUT=y
CONFIG_RFKILL_GPIO=y
CONFIG_NET_9P=y
CONFIG_NET_9P_VIRTIO=y
CONFIG_NET_9P_DEBUG=y
CONFIG_CAIF=y
# CONFIG_CAIF_DEBUG is not set
CONFIG_CAIF_NETDEV=y
CONFIG_CAIF_USB=y
# CONFIG_CEPH_LIB is not set
# CONFIG_NFC is not set
CONFIG_PSAMPLE=y
CONFIG_NET_IFE=y
CONFIG_LWTUNNEL=y
CONFIG_LWTUNNEL_BPF=y
CONFIG_DST_CACHE=y
CONFIG_GRO_CELLS=y
CONFIG_FAILOVER=y
# CONFIG_ETHTOOL_NETLINK is not set
CONFIG_HAVE_EBPF_JIT=y

#
# Device Drivers
#
CONFIG_HAVE_EISA=y
# CONFIG_EISA is not set
CONFIG_HAVE_PCI=y
CONFIG_PCI=y
CONFIG_PCI_DOMAINS=y
# CONFIG_PCIEPORTBUS is not set
CONFIG_PCIEASPM=y
CONFIG_PCIEASPM_DEFAULT=y
# CONFIG_PCIEASPM_POWERSAVE is not set
# CONFIG_PCIEASPM_POWER_SUPERSAVE is not set
# CONFIG_PCIEASPM_PERFORMANCE is not set
# CONFIG_PCIE_PTM is not set
# CONFIG_PCI_MSI is not set
CONFIG_PCI_QUIRKS=y
# CONFIG_PCI_DEBUG is not set
# CONFIG_PCI_STUB is not set
CONFIG_PCI_LOCKLESS_CONFIG=y
# CONFIG_PCI_IOV is not set
# CONFIG_PCI_PRI is not set
# CONFIG_PCI_PASID is not set
CONFIG_PCI_LABEL=y
# CONFIG_HOTPLUG_PCI is not set

#
# PCI controller drivers
#
# CONFIG_PCI_FTPCI100 is not set
# CONFIG_PCI_HOST_GENERIC is not set
# CONFIG_PCIE_XILINX is not set

#
# DesignWare PCI Core Support
#
# end of DesignWare PCI Core Support

#
# Mobiveil PCIe Core Support
#
# end of Mobiveil PCIe Core Support

#
# Cadence PCIe controllers support
#
# CONFIG_PCIE_CADENCE_PLAT_HOST is not set
# CONFIG_PCI_J721E_HOST is not set
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
CONFIG_PCMCIA=y
# CONFIG_PCMCIA_LOAD_CIS is not set
CONFIG_CARDBUS=y

#
# PC-card bridges
#
# CONFIG_YENTA is not set
# CONFIG_PD6729 is not set
# CONFIG_I82092 is not set
# CONFIG_RAPIDIO is not set

#
# Generic Driver Options
#
CONFIG_UEVENT_HELPER=y
CONFIG_UEVENT_HELPER_PATH=""
CONFIG_DEVTMPFS=y
CONFIG_DEVTMPFS_MOUNT=y
# CONFIG_STANDALONE is not set
CONFIG_PREVENT_FIRMWARE_BUILD=y

#
# Firmware loader
#
CONFIG_FW_LOADER=y
CONFIG_FW_LOADER_PAGED_BUF=y
CONFIG_EXTRA_FIRMWARE=""
CONFIG_FW_LOADER_USER_HELPER=y
CONFIG_FW_LOADER_USER_HELPER_FALLBACK=y
# CONFIG_FW_LOADER_COMPRESS is not set
CONFIG_FW_CACHE=y
# end of Firmware loader

CONFIG_WANT_DEV_COREDUMP=y
# CONFIG_ALLOW_DEV_COREDUMP is not set
# CONFIG_DEBUG_DRIVER is not set
CONFIG_DEBUG_DEVRES=y
# CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
# CONFIG_TEST_ASYNC_DRIVER_PROBE is not set
CONFIG_GENERIC_CPU_AUTOPROBE=y
CONFIG_GENERIC_CPU_VULNERABILITIES=y
CONFIG_REGMAP=y
CONFIG_REGMAP_I2C=y
CONFIG_REGMAP_SLIMBUS=y
CONFIG_REGMAP_SPI=y
CONFIG_REGMAP_W1=y
CONFIG_REGMAP_MMIO=y
CONFIG_REGMAP_IRQ=y
CONFIG_REGMAP_SCCB=y
CONFIG_REGMAP_I3C=y
CONFIG_DMA_SHARED_BUFFER=y
CONFIG_DMA_FENCE_TRACE=y
# end of Generic Driver Options

#
# Bus devices
#
CONFIG_MOXTET=y
CONFIG_SIMPLE_PM_BUS=y
# CONFIG_MHI_BUS is not set
# end of Bus devices

CONFIG_CONNECTOR=y
CONFIG_PROC_EVENTS=y
CONFIG_GNSS=y
CONFIG_GNSS_SERIAL=y
CONFIG_GNSS_MTK_SERIAL=y
# CONFIG_GNSS_SIRF_SERIAL is not set
CONFIG_GNSS_UBX_SERIAL=y
CONFIG_MTD=y
# CONFIG_MTD_TESTS is not set

#
# Partition parsers
#
CONFIG_MTD_AR7_PARTS=y
CONFIG_MTD_CMDLINE_PARTS=y
# CONFIG_MTD_OF_PARTS is not set
# CONFIG_MTD_REDBOOT_PARTS is not set
# end of Partition parsers

#
# User Modules And Translation Layers
#
CONFIG_MTD_OOPS=y
CONFIG_MTD_PARTITIONED_MASTER=y

#
# RAM/ROM/Flash chip drivers
#
CONFIG_MTD_CFI=y
CONFIG_MTD_JEDECPROBE=y
CONFIG_MTD_GEN_PROBE=y
# CONFIG_MTD_CFI_ADV_OPTIONS is not set
CONFIG_MTD_MAP_BANK_WIDTH_1=y
CONFIG_MTD_MAP_BANK_WIDTH_2=y
CONFIG_MTD_MAP_BANK_WIDTH_4=y
CONFIG_MTD_CFI_I1=y
CONFIG_MTD_CFI_I2=y
# CONFIG_MTD_CFI_INTELEXT is not set
CONFIG_MTD_CFI_AMDSTD=y
# CONFIG_MTD_CFI_STAA is not set
CONFIG_MTD_CFI_UTIL=y
CONFIG_MTD_RAM=y
CONFIG_MTD_ROM=y
CONFIG_MTD_ABSENT=y
# end of RAM/ROM/Flash chip drivers

#
# Mapping drivers for chip access
#
CONFIG_MTD_COMPLEX_MAPPINGS=y
# CONFIG_MTD_PHYSMAP is not set
# CONFIG_MTD_SC520CDP is not set
# CONFIG_MTD_NETSC520 is not set
# CONFIG_MTD_TS5500 is not set
CONFIG_MTD_SCx200_DOCFLASH=y
CONFIG_MTD_AMD76XROM=y
CONFIG_MTD_ICHXROM=y
# CONFIG_MTD_ESB2ROM is not set
# CONFIG_MTD_CK804XROM is not set
# CONFIG_MTD_SCB2_FLASH is not set
# CONFIG_MTD_NETtel is not set
CONFIG_MTD_L440GX=y
# CONFIG_MTD_PCI is not set
CONFIG_MTD_PCMCIA=y
# CONFIG_MTD_PCMCIA_ANONYMOUS is not set
# CONFIG_MTD_INTEL_VR_NOR is not set
CONFIG_MTD_PLATRAM=y
# end of Mapping drivers for chip access

#
# Self-contained MTD device drivers
#
# CONFIG_MTD_PMC551 is not set
# CONFIG_MTD_DATAFLASH is not set
CONFIG_MTD_MCHP23K256=y
CONFIG_MTD_SST25L=y
# CONFIG_MTD_SLRAM is not set
CONFIG_MTD_PHRAM=y
# CONFIG_MTD_MTDRAM is not set

#
# Disk-On-Chip Device Drivers
#
CONFIG_MTD_DOCG3=y
CONFIG_BCH_CONST_M=14
CONFIG_BCH_CONST_T=4
# end of Self-contained MTD device drivers

#
# NAND
#
CONFIG_MTD_NAND_CORE=y
CONFIG_MTD_ONENAND=y
CONFIG_MTD_ONENAND_VERIFY_WRITE=y
CONFIG_MTD_ONENAND_GENERIC=y
CONFIG_MTD_ONENAND_OTP=y
# CONFIG_MTD_ONENAND_2X_PROGRAM is not set
CONFIG_MTD_NAND_ECC_SW_HAMMING=y
# CONFIG_MTD_NAND_ECC_SW_HAMMING_SMC is not set
CONFIG_MTD_RAW_NAND=y
# CONFIG_MTD_NAND_ECC_SW_BCH is not set

#
# Raw/parallel NAND flash controllers
#
# CONFIG_MTD_NAND_DENALI_PCI is not set
# CONFIG_MTD_NAND_DENALI_DT is not set
# CONFIG_MTD_NAND_CAFE is not set
CONFIG_MTD_NAND_CS553X=y
CONFIG_MTD_NAND_MXIC=y
CONFIG_MTD_NAND_GPIO=y
CONFIG_MTD_NAND_PLATFORM=y
CONFIG_MTD_NAND_CADENCE=y
# CONFIG_MTD_NAND_ARASAN is not set

#
# Misc
#
CONFIG_MTD_NAND_NANDSIM=y
# CONFIG_MTD_NAND_RICOH is not set
# CONFIG_MTD_NAND_DISKONCHIP is not set
# CONFIG_MTD_SPI_NAND is not set
# end of NAND

#
# LPDDR & LPDDR2 PCM memory drivers
#
CONFIG_MTD_LPDDR=y
CONFIG_MTD_QINFO_PROBE=y
# end of LPDDR & LPDDR2 PCM memory drivers

CONFIG_MTD_SPI_NOR=y
# CONFIG_MTD_SPI_NOR_USE_4K_SECTORS is not set
CONFIG_SPI_INTEL_SPI=y
# CONFIG_SPI_INTEL_SPI_PCI is not set
CONFIG_SPI_INTEL_SPI_PLATFORM=y
# CONFIG_MTD_UBI is not set
CONFIG_MTD_HYPERBUS=y
CONFIG_DTC=y
CONFIG_OF=y
# CONFIG_OF_UNITTEST is not set
CONFIG_OF_FLATTREE=y
CONFIG_OF_EARLY_FLATTREE=y
CONFIG_OF_KOBJ=y
CONFIG_OF_ADDRESS=y
CONFIG_OF_IRQ=y
CONFIG_OF_NET=y
CONFIG_OF_MDIO=y
CONFIG_OF_RESERVED_MEM=y
# CONFIG_OF_OVERLAY is not set
CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
CONFIG_PARPORT=y
CONFIG_PARPORT_PC=y
# CONFIG_PARPORT_SERIAL is not set
# CONFIG_PARPORT_PC_FIFO is not set
CONFIG_PARPORT_PC_SUPERIO=y
CONFIG_PARPORT_PC_PCMCIA=y
CONFIG_PARPORT_AX88796=y
# CONFIG_PARPORT_1284 is not set
CONFIG_PARPORT_NOT_PC=y
CONFIG_PNP=y
# CONFIG_PNP_DEBUG_MESSAGES is not set

#
# Protocols
#
CONFIG_PNPACPI=y

#
# NVME Support
#
# end of NVME Support

#
# Misc devices
#
CONFIG_SENSORS_LIS3LV02D=y
CONFIG_AD525X_DPOT=y
CONFIG_AD525X_DPOT_I2C=y
# CONFIG_AD525X_DPOT_SPI is not set
CONFIG_DUMMY_IRQ=y
# CONFIG_IBM_ASM is not set
# CONFIG_PHANTOM is not set
# CONFIG_TIFM_CORE is not set
CONFIG_ICS932S401=y
# CONFIG_ENCLOSURE_SERVICES is not set
# CONFIG_HP_ILO is not set
# CONFIG_APDS9802ALS is not set
CONFIG_ISL29003=y
# CONFIG_ISL29020 is not set
CONFIG_SENSORS_TSL2550=y
CONFIG_SENSORS_BH1770=y
# CONFIG_SENSORS_APDS990X is not set
CONFIG_HMC6352=y
CONFIG_DS1682=y
# CONFIG_PCH_PHUB is not set
# CONFIG_LATTICE_ECP3_CONFIG is not set
CONFIG_SRAM=y
# CONFIG_PCI_ENDPOINT_TEST is not set
CONFIG_XILINX_SDFEC=y
# CONFIG_PVPANIC is not set
CONFIG_C2PORT=y
CONFIG_C2PORT_DURAMAR_2150=y

#
# EEPROM support
#
CONFIG_EEPROM_AT24=y
# CONFIG_EEPROM_AT25 is not set
# CONFIG_EEPROM_LEGACY is not set
CONFIG_EEPROM_MAX6875=y
CONFIG_EEPROM_93CX6=y
CONFIG_EEPROM_93XX46=y
CONFIG_EEPROM_IDT_89HPESX=y
# CONFIG_EEPROM_EE1004 is not set
# end of EEPROM support

# CONFIG_CB710_CORE is not set

#
# Texas Instruments shared transport line discipline
#
# CONFIG_TI_ST is not set
# end of Texas Instruments shared transport line discipline

CONFIG_SENSORS_LIS3_I2C=y
# CONFIG_ALTERA_STAPL is not set
# CONFIG_INTEL_MEI is not set
# CONFIG_INTEL_MEI_ME is not set
# CONFIG_INTEL_MEI_TXE is not set
# CONFIG_VMWARE_VMCI is not set

#
# Intel MIC & related support
#
# CONFIG_VOP_BUS is not set
# end of Intel MIC & related support

CONFIG_ECHO=y
# CONFIG_MISC_ALCOR_PCI is not set
# CONFIG_MISC_RTSX_PCI is not set
# CONFIG_MISC_RTSX_USB is not set
# CONFIG_HABANA_AI is not set
# end of Misc devices

CONFIG_HAVE_IDE=y

#
# SCSI device support
#
CONFIG_SCSI_MOD=y
# end of SCSI device support

# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support
#
CONFIG_FIREWIRE=y
# CONFIG_FIREWIRE_OHCI is not set
# CONFIG_FIREWIRE_NET is not set
# CONFIG_FIREWIRE_NOSY is not set
# end of IEEE 1394 (FireWire) support

CONFIG_MACINTOSH_DRIVERS=y
CONFIG_MAC_EMUMOUSEBTN=y
CONFIG_NETDEVICES=y
CONFIG_MII=y
CONFIG_NET_CORE=y
# CONFIG_BONDING is not set
CONFIG_DUMMY=y
# CONFIG_WIREGUARD is not set
CONFIG_EQUALIZER=y
CONFIG_NET_TEAM=y
CONFIG_NET_TEAM_MODE_BROADCAST=y
# CONFIG_NET_TEAM_MODE_ROUNDROBIN is not set
CONFIG_NET_TEAM_MODE_RANDOM=y
CONFIG_NET_TEAM_MODE_ACTIVEBACKUP=y
CONFIG_NET_TEAM_MODE_LOADBALANCE=y
CONFIG_MACVLAN=y
# CONFIG_MACVTAP is not set
# CONFIG_IPVLAN is not set
# CONFIG_VXLAN is not set
# CONFIG_GENEVE is not set
# CONFIG_BAREUDP is not set
# CONFIG_GTP is not set
CONFIG_MACSEC=y
CONFIG_NETCONSOLE=y
# CONFIG_NETCONSOLE_DYNAMIC is not set
CONFIG_NETPOLL=y
CONFIG_NET_POLL_CONTROLLER=y
# CONFIG_TUN is not set
# CONFIG_TUN_VNET_CROSS_LE is not set
CONFIG_VETH=y
# CONFIG_VIRTIO_NET is not set
# CONFIG_NLMON is not set
CONFIG_VSOCKMON=y
CONFIG_ARCNET=y
CONFIG_ARCNET_1201=y
CONFIG_ARCNET_1051=y
CONFIG_ARCNET_RAW=y
CONFIG_ARCNET_CAP=y
# CONFIG_ARCNET_COM90xx is not set
# CONFIG_ARCNET_COM90xxIO is not set
CONFIG_ARCNET_RIM_I=y
CONFIG_ARCNET_COM20020=y
# CONFIG_ARCNET_COM20020_PCI is not set
CONFIG_ARCNET_COM20020_CS=y
CONFIG_ATM_DRIVERS=y
CONFIG_ATM_DUMMY=y
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
# CONFIG_CAIF_DRIVERS is not set

#
# Distributed Switch Architecture drivers
#
# end of Distributed Switch Architecture drivers

CONFIG_ETHERNET=y
# CONFIG_NET_VENDOR_3COM is not set
CONFIG_NET_VENDOR_ADAPTEC=y
# CONFIG_ADAPTEC_STARFIRE is not set
CONFIG_NET_VENDOR_AGERE=y
# CONFIG_ET131X is not set
# CONFIG_NET_VENDOR_ALACRITECH is not set
CONFIG_NET_VENDOR_ALTEON=y
# CONFIG_ACENIC is not set
CONFIG_ALTERA_TSE=y
CONFIG_NET_VENDOR_AMAZON=y
CONFIG_NET_VENDOR_AMD=y
# CONFIG_AMD8111_ETH is not set
# CONFIG_PCNET32 is not set
CONFIG_PCMCIA_NMCLAN=y
CONFIG_AMD_XGBE=y
CONFIG_AMD_XGBE_DCB=y
CONFIG_AMD_XGBE_HAVE_ECC=y
CONFIG_NET_VENDOR_AQUANTIA=y
# CONFIG_NET_VENDOR_ARC is not set
CONFIG_NET_VENDOR_ATHEROS=y
# CONFIG_ATL2 is not set
# CONFIG_ATL1 is not set
# CONFIG_ATL1E is not set
# CONFIG_ATL1C is not set
# CONFIG_ALX is not set
# CONFIG_NET_VENDOR_AURORA is not set
# CONFIG_NET_VENDOR_BROADCOM is not set
CONFIG_NET_VENDOR_BROCADE=y
# CONFIG_BNA is not set
# CONFIG_NET_VENDOR_CADENCE is not set
# CONFIG_NET_VENDOR_CAVIUM is not set
CONFIG_NET_VENDOR_CHELSIO=y
# CONFIG_CHELSIO_T1 is not set
# CONFIG_CHELSIO_T3 is not set
# CONFIG_CHELSIO_T4 is not set
# CONFIG_CHELSIO_T4VF is not set
CONFIG_NET_VENDOR_CISCO=y
# CONFIG_ENIC is not set
CONFIG_NET_VENDOR_CORTINA=y
# CONFIG_GEMINI_ETHERNET is not set
# CONFIG_CX_ECAT is not set
CONFIG_DNET=y
CONFIG_NET_VENDOR_DEC=y
# CONFIG_NET_TULIP is not set
CONFIG_NET_VENDOR_DLINK=y
# CONFIG_DL2K is not set
# CONFIG_SUNDANCE is not set
CONFIG_NET_VENDOR_EMULEX=y
# CONFIG_BE2NET is not set
CONFIG_NET_VENDOR_EZCHIP=y
CONFIG_EZCHIP_NPS_MANAGEMENT_ENET=y
# CONFIG_NET_VENDOR_FUJITSU is not set
# CONFIG_NET_VENDOR_GOOGLE is not set
CONFIG_NET_VENDOR_HUAWEI=y
# CONFIG_NET_VENDOR_I825XX is not set
CONFIG_NET_VENDOR_INTEL=y
# CONFIG_E100 is not set
CONFIG_E1000=y
# CONFIG_E1000E is not set
# CONFIG_IGB is not set
# CONFIG_IGBVF is not set
# CONFIG_IXGB is not set
# CONFIG_IXGBE is not set
# CONFIG_I40E is not set
# CONFIG_IGC is not set
# CONFIG_JME is not set
# CONFIG_NET_VENDOR_MARVELL is not set
# CONFIG_NET_VENDOR_MELLANOX is not set
CONFIG_NET_VENDOR_MICREL=y
CONFIG_KS8842=y
CONFIG_KS8851=y
CONFIG_KS8851_MLL=y
# CONFIG_KSZ884X_PCI is not set
# CONFIG_NET_VENDOR_MICROCHIP is not set
CONFIG_NET_VENDOR_MICROSEMI=y
CONFIG_NET_VENDOR_MYRI=y
# CONFIG_MYRI10GE is not set
# CONFIG_FEALNX is not set
# CONFIG_NET_VENDOR_NATSEMI is not set
CONFIG_NET_VENDOR_NETERION=y
# CONFIG_S2IO is not set
# CONFIG_VXGE is not set
CONFIG_NET_VENDOR_NETRONOME=y
CONFIG_NET_VENDOR_NI=y
CONFIG_NI_XGE_MANAGEMENT_ENET=y
CONFIG_NET_VENDOR_NVIDIA=y
# CONFIG_FORCEDETH is not set
CONFIG_NET_VENDOR_OKI=y
# CONFIG_PCH_GBE is not set
CONFIG_ETHOC=y
CONFIG_NET_VENDOR_PACKET_ENGINES=y
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
# CONFIG_NET_VENDOR_PENSANDO is not set
CONFIG_NET_VENDOR_QLOGIC=y
# CONFIG_QLA3XXX is not set
# CONFIG_QLCNIC is not set
# CONFIG_NETXEN_NIC is not set
# CONFIG_QED is not set
CONFIG_NET_VENDOR_QUALCOMM=y
CONFIG_QCA7000=y
CONFIG_QCA7000_SPI=y
CONFIG_QCA7000_UART=y
CONFIG_QCOM_EMAC=y
CONFIG_RMNET=y
CONFIG_NET_VENDOR_RDC=y
# CONFIG_R6040 is not set
# CONFIG_NET_VENDOR_REALTEK is not set
CONFIG_NET_VENDOR_RENESAS=y
CONFIG_NET_VENDOR_ROCKER=y
CONFIG_NET_VENDOR_SAMSUNG=y
CONFIG_SXGBE_ETH=y
CONFIG_NET_VENDOR_SEEQ=y
# CONFIG_NET_VENDOR_SOLARFLARE is not set
CONFIG_NET_VENDOR_SILAN=y
# CONFIG_SC92031 is not set
CONFIG_NET_VENDOR_SIS=y
# CONFIG_SIS900 is not set
# CONFIG_SIS190 is not set
CONFIG_NET_VENDOR_SMSC=y
CONFIG_PCMCIA_SMC91C92=y
# CONFIG_EPIC100 is not set
CONFIG_SMSC911X=y
# CONFIG_SMSC9420 is not set
CONFIG_NET_VENDOR_SOCIONEXT=y
# CONFIG_NET_VENDOR_STMICRO is not set
CONFIG_NET_VENDOR_SUN=y
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNGEM is not set
# CONFIG_CASSINI is not set
# CONFIG_NIU is not set
# CONFIG_NET_VENDOR_SYNOPSYS is not set
CONFIG_NET_VENDOR_TEHUTI=y
# CONFIG_TEHUTI is not set
CONFIG_NET_VENDOR_TI=y
# CONFIG_TI_CPSW_PHY_SEL is not set
# CONFIG_TLAN is not set
# CONFIG_NET_VENDOR_VIA is not set
# CONFIG_NET_VENDOR_WIZNET is not set
CONFIG_NET_VENDOR_XILINX=y
# CONFIG_XILINX_AXI_EMAC is not set
# CONFIG_XILINX_LL_TEMAC is not set
# CONFIG_NET_VENDOR_XIRCOM is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
CONFIG_NET_SB1000=y
CONFIG_MDIO_DEVICE=y
CONFIG_MDIO_BUS=y
CONFIG_MDIO_DEVRES=y
CONFIG_MDIO_BCM_UNIMAC=y
CONFIG_MDIO_BITBANG=y
CONFIG_MDIO_BUS_MUX=y
# CONFIG_MDIO_BUS_MUX_GPIO is not set
CONFIG_MDIO_BUS_MUX_MMIOREG=y
CONFIG_MDIO_BUS_MUX_MULTIPLEXER=y
# CONFIG_MDIO_GPIO is not set
CONFIG_MDIO_HISI_FEMAC=y
CONFIG_MDIO_IPQ4019=y
CONFIG_MDIO_IPQ8064=y
# CONFIG_MDIO_MSCC_MIIM is not set
# CONFIG_MDIO_MVUSB is not set
CONFIG_MDIO_XPCS=y
CONFIG_PHYLIB=y
CONFIG_SWPHY=y
# CONFIG_LED_TRIGGER_PHY is not set

#
# MII PHY device drivers
#
# CONFIG_ADIN_PHY is not set
CONFIG_AMD_PHY=y
CONFIG_AQUANTIA_PHY=y
CONFIG_AX88796B_PHY=y
CONFIG_BCM7XXX_PHY=y
CONFIG_BCM87XX_PHY=y
CONFIG_BCM_NET_PHYLIB=y
CONFIG_BROADCOM_PHY=y
# CONFIG_BCM54140_PHY is not set
CONFIG_BCM84881_PHY=y
CONFIG_CICADA_PHY=y
# CONFIG_CORTINA_PHY is not set
CONFIG_DAVICOM_PHY=y
CONFIG_DP83822_PHY=y
CONFIG_DP83TC811_PHY=y
# CONFIG_DP83848_PHY is not set
CONFIG_DP83867_PHY=y
CONFIG_DP83869_PHY=y
CONFIG_FIXED_PHY=y
CONFIG_ICPLUS_PHY=y
CONFIG_INTEL_XWAY_PHY=y
CONFIG_LSI_ET1011C_PHY=y
CONFIG_LXT_PHY=y
# CONFIG_MARVELL_PHY is not set
CONFIG_MARVELL_10G_PHY=y
CONFIG_MICREL_PHY=y
CONFIG_MICROCHIP_PHY=y
CONFIG_MICROCHIP_T1_PHY=y
# CONFIG_MICROSEMI_PHY is not set
# CONFIG_NATIONAL_PHY is not set
# CONFIG_NXP_TJA11XX_PHY is not set
CONFIG_AT803X_PHY=y
# CONFIG_QSEMI_PHY is not set
CONFIG_REALTEK_PHY=y
CONFIG_RENESAS_PHY=y
CONFIG_ROCKCHIP_PHY=y
CONFIG_SMSC_PHY=y
CONFIG_STE10XP=y
CONFIG_TERANETICS_PHY=y
CONFIG_VITESSE_PHY=y
# CONFIG_XILINX_GMII2RGMII is not set
CONFIG_MICREL_KS8995MA=y
# CONFIG_PLIP is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set
# CONFIG_USB_NET_DRIVERS is not set
# CONFIG_WLAN is not set

#
# WiMAX Wireless Broadband devices
#
CONFIG_WIMAX_I2400M=y
CONFIG_WIMAX_I2400M_USB=y
CONFIG_WIMAX_I2400M_DEBUG_LEVEL=8
# end of WiMAX Wireless Broadband devices

CONFIG_WAN=y
# CONFIG_LANMEDIA is not set
CONFIG_HDLC=y
CONFIG_HDLC_RAW=y
# CONFIG_HDLC_RAW_ETH is not set
# CONFIG_HDLC_CISCO is not set
CONFIG_HDLC_FR=y
CONFIG_HDLC_PPP=y

#
# X.25/LAPB support is disabled
#
# CONFIG_PCI200SYN is not set
# CONFIG_WANXL is not set
# CONFIG_PC300TOO is not set
# CONFIG_FARSYNC is not set
CONFIG_DLCI=y
CONFIG_DLCI_MAX=8
# CONFIG_SBNI is not set
# CONFIG_VMXNET3 is not set
# CONFIG_FUJITSU_ES is not set
# CONFIG_HYPERV_NET is not set
# CONFIG_NETDEVSIM is not set
CONFIG_NET_FAILOVER=y
# CONFIG_ISDN is not set

#
# Input device support
#
CONFIG_INPUT=y
CONFIG_INPUT_LEDS=y
CONFIG_INPUT_FF_MEMLESS=y
# CONFIG_INPUT_POLLDEV is not set
# CONFIG_INPUT_SPARSEKMAP is not set
CONFIG_INPUT_MATRIXKMAP=y

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
# CONFIG_INPUT_MOUSEDEV_PSAUX is not set
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_INPUT_JOYDEV=y
# CONFIG_INPUT_EVDEV is not set
# CONFIG_INPUT_EVBUG is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ADC=y
# CONFIG_KEYBOARD_ADP5588 is not set
# CONFIG_KEYBOARD_ADP5589 is not set
CONFIG_KEYBOARD_APPLESPI=y
CONFIG_KEYBOARD_ATKBD=y
CONFIG_KEYBOARD_QT1050=y
# CONFIG_KEYBOARD_QT1070 is not set
CONFIG_KEYBOARD_QT2160=y
CONFIG_KEYBOARD_DLINK_DIR685=y
CONFIG_KEYBOARD_LKKBD=y
CONFIG_KEYBOARD_GPIO=y
CONFIG_KEYBOARD_GPIO_POLLED=y
CONFIG_KEYBOARD_TCA6416=y
CONFIG_KEYBOARD_TCA8418=y
CONFIG_KEYBOARD_MATRIX=y
CONFIG_KEYBOARD_LM8323=y
CONFIG_KEYBOARD_LM8333=y
CONFIG_KEYBOARD_MAX7359=y
# CONFIG_KEYBOARD_MCS is not set
# CONFIG_KEYBOARD_MPR121 is not set
CONFIG_KEYBOARD_NEWTON=y
CONFIG_KEYBOARD_OPENCORES=y
# CONFIG_KEYBOARD_SAMSUNG is not set
CONFIG_KEYBOARD_GOLDFISH_EVENTS=y
# CONFIG_KEYBOARD_STOWAWAY is not set
CONFIG_KEYBOARD_SUNKBD=y
CONFIG_KEYBOARD_STMPE=y
CONFIG_KEYBOARD_IQS62X=y
CONFIG_KEYBOARD_OMAP4=y
# CONFIG_KEYBOARD_TC3589X is not set
CONFIG_KEYBOARD_TM2_TOUCHKEY=y
CONFIG_KEYBOARD_XTKBD=y
CONFIG_KEYBOARD_CROS_EC=y
CONFIG_KEYBOARD_CAP11XX=y
# CONFIG_KEYBOARD_BCM is not set
# CONFIG_KEYBOARD_MTK_PMIC is not set
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
# CONFIG_MOUSE_PS2_ALPS is not set
# CONFIG_MOUSE_PS2_BYD is not set
# CONFIG_MOUSE_PS2_LOGIPS2PP is not set
CONFIG_MOUSE_PS2_SYNAPTICS=y
CONFIG_MOUSE_PS2_SYNAPTICS_SMBUS=y
CONFIG_MOUSE_PS2_CYPRESS=y
CONFIG_MOUSE_PS2_LIFEBOOK=y
# CONFIG_MOUSE_PS2_TRACKPOINT is not set
# CONFIG_MOUSE_PS2_ELANTECH is not set
# CONFIG_MOUSE_PS2_SENTELIC is not set
# CONFIG_MOUSE_PS2_TOUCHKIT is not set
CONFIG_MOUSE_PS2_FOCALTECH=y
# CONFIG_MOUSE_PS2_VMMOUSE is not set
CONFIG_MOUSE_PS2_SMBUS=y
# CONFIG_MOUSE_SERIAL is not set
CONFIG_MOUSE_APPLETOUCH=y
CONFIG_MOUSE_BCM5974=y
CONFIG_MOUSE_CYAPA=y
CONFIG_MOUSE_ELAN_I2C=y
CONFIG_MOUSE_ELAN_I2C_I2C=y
# CONFIG_MOUSE_ELAN_I2C_SMBUS is not set
# CONFIG_MOUSE_VSXXXAA is not set
# CONFIG_MOUSE_GPIO is not set
CONFIG_MOUSE_SYNAPTICS_I2C=y
# CONFIG_MOUSE_SYNAPTICS_USB is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TABLET is not set
CONFIG_INPUT_TOUCHSCREEN=y
CONFIG_TOUCHSCREEN_PROPERTIES=y
CONFIG_TOUCHSCREEN_ADS7846=y
CONFIG_TOUCHSCREEN_AD7877=y
# CONFIG_TOUCHSCREEN_AD7879 is not set
CONFIG_TOUCHSCREEN_ADC=y
CONFIG_TOUCHSCREEN_AR1021_I2C=y
CONFIG_TOUCHSCREEN_ATMEL_MXT=y
# CONFIG_TOUCHSCREEN_ATMEL_MXT_T37 is not set
# CONFIG_TOUCHSCREEN_AUO_PIXCIR is not set
CONFIG_TOUCHSCREEN_BU21013=y
CONFIG_TOUCHSCREEN_BU21029=y
CONFIG_TOUCHSCREEN_CHIPONE_ICN8318=y
# CONFIG_TOUCHSCREEN_CHIPONE_ICN8505 is not set
CONFIG_TOUCHSCREEN_CY8CTMA140=y
# CONFIG_TOUCHSCREEN_CY8CTMG110 is not set
CONFIG_TOUCHSCREEN_CYTTSP_CORE=y
CONFIG_TOUCHSCREEN_CYTTSP_I2C=y
# CONFIG_TOUCHSCREEN_CYTTSP_SPI is not set
CONFIG_TOUCHSCREEN_CYTTSP4_CORE=y
# CONFIG_TOUCHSCREEN_CYTTSP4_I2C is not set
# CONFIG_TOUCHSCREEN_CYTTSP4_SPI is not set
CONFIG_TOUCHSCREEN_DA9052=y
CONFIG_TOUCHSCREEN_DYNAPRO=y
CONFIG_TOUCHSCREEN_HAMPSHIRE=y
CONFIG_TOUCHSCREEN_EETI=y
# CONFIG_TOUCHSCREEN_EGALAX is not set
CONFIG_TOUCHSCREEN_EGALAX_SERIAL=y
# CONFIG_TOUCHSCREEN_EXC3000 is not set
CONFIG_TOUCHSCREEN_FUJITSU=y
# CONFIG_TOUCHSCREEN_GOODIX is not set
CONFIG_TOUCHSCREEN_HIDEEP=y
CONFIG_TOUCHSCREEN_ILI210X=y
CONFIG_TOUCHSCREEN_S6SY761=y
CONFIG_TOUCHSCREEN_GUNZE=y
CONFIG_TOUCHSCREEN_EKTF2127=y
# CONFIG_TOUCHSCREEN_ELAN is not set
CONFIG_TOUCHSCREEN_ELO=y
# CONFIG_TOUCHSCREEN_WACOM_W8001 is not set
CONFIG_TOUCHSCREEN_WACOM_I2C=y
# CONFIG_TOUCHSCREEN_MAX11801 is not set
CONFIG_TOUCHSCREEN_MCS5000=y
CONFIG_TOUCHSCREEN_MMS114=y
CONFIG_TOUCHSCREEN_MELFAS_MIP4=y
CONFIG_TOUCHSCREEN_MTOUCH=y
# CONFIG_TOUCHSCREEN_IMX6UL_TSC is not set
CONFIG_TOUCHSCREEN_INEXIO=y
# CONFIG_TOUCHSCREEN_MK712 is not set
CONFIG_TOUCHSCREEN_PENMOUNT=y
CONFIG_TOUCHSCREEN_EDT_FT5X06=y
# CONFIG_TOUCHSCREEN_TOUCHRIGHT is not set
# CONFIG_TOUCHSCREEN_TOUCHWIN is not set
# CONFIG_TOUCHSCREEN_PIXCIR is not set
CONFIG_TOUCHSCREEN_WDT87XX_I2C=y
# CONFIG_TOUCHSCREEN_USB_COMPOSITE is not set
# CONFIG_TOUCHSCREEN_MC13783 is not set
CONFIG_TOUCHSCREEN_TOUCHIT213=y
CONFIG_TOUCHSCREEN_TSC_SERIO=y
CONFIG_TOUCHSCREEN_TSC200X_CORE=y
CONFIG_TOUCHSCREEN_TSC2004=y
CONFIG_TOUCHSCREEN_TSC2005=y
# CONFIG_TOUCHSCREEN_TSC2007 is not set
CONFIG_TOUCHSCREEN_PCAP=y
CONFIG_TOUCHSCREEN_RM_TS=y
# CONFIG_TOUCHSCREEN_SILEAD is not set
CONFIG_TOUCHSCREEN_SIS_I2C=y
CONFIG_TOUCHSCREEN_ST1232=y
# CONFIG_TOUCHSCREEN_STMFTS is not set
CONFIG_TOUCHSCREEN_STMPE=y
CONFIG_TOUCHSCREEN_SUR40=y
# CONFIG_TOUCHSCREEN_SURFACE3_SPI is not set
CONFIG_TOUCHSCREEN_SX8654=y
CONFIG_TOUCHSCREEN_TPS6507X=y
# CONFIG_TOUCHSCREEN_ZET6223 is not set
# CONFIG_TOUCHSCREEN_ZFORCE is not set
CONFIG_TOUCHSCREEN_COLIBRI_VF50=y
# CONFIG_TOUCHSCREEN_ROHM_BU21023 is not set
CONFIG_TOUCHSCREEN_IQS5XX=y
# CONFIG_INPUT_MISC is not set
CONFIG_RMI4_CORE=y
CONFIG_RMI4_I2C=y
# CONFIG_RMI4_SPI is not set
# CONFIG_RMI4_SMB is not set
CONFIG_RMI4_F03=y
CONFIG_RMI4_F03_SERIO=y
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
CONFIG_SERIO_PARKBD=y
# CONFIG_SERIO_PCIPS2 is not set
CONFIG_SERIO_LIBPS2=y
CONFIG_SERIO_RAW=y
CONFIG_SERIO_ALTERA_PS2=y
# CONFIG_SERIO_PS2MULT is not set
# CONFIG_SERIO_ARC_PS2 is not set
CONFIG_SERIO_APBPS2=y
# CONFIG_HYPERV_KEYBOARD is not set
# CONFIG_SERIO_GPIO_PS2 is not set
CONFIG_USERIO=y
CONFIG_GAMEPORT=y
CONFIG_GAMEPORT_NS558=y
CONFIG_GAMEPORT_L4=y
# CONFIG_GAMEPORT_EMU10K1 is not set
# CONFIG_GAMEPORT_FM801 is not set
# end of Hardware I/O ports
# end of Input device support

#
# Character devices
#
CONFIG_TTY=y
# CONFIG_VT is not set
CONFIG_UNIX98_PTYS=y
CONFIG_LEGACY_PTYS=y
CONFIG_LEGACY_PTY_COUNT=256
CONFIG_LDISC_AUTOLOAD=y

#
# Serial drivers
#
CONFIG_SERIAL_EARLYCON=y
CONFIG_SERIAL_8250=y
CONFIG_SERIAL_8250_DEPRECATED_OPTIONS=y
CONFIG_SERIAL_8250_PNP=y
# CONFIG_SERIAL_8250_16550A_VARIANTS is not set
# CONFIG_SERIAL_8250_FINTEK is not set
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_DMA=y
CONFIG_SERIAL_8250_PCI=y
CONFIG_SERIAL_8250_EXAR=y
# CONFIG_SERIAL_8250_CS is not set
# CONFIG_SERIAL_8250_MEN_MCB is not set
CONFIG_SERIAL_8250_NR_UARTS=4
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
# CONFIG_SERIAL_8250_EXTENDED is not set
# CONFIG_SERIAL_8250_ASPEED_VUART is not set
CONFIG_SERIAL_8250_DWLIB=y
# CONFIG_SERIAL_8250_DW is not set
# CONFIG_SERIAL_8250_RT288X is not set
CONFIG_SERIAL_8250_LPSS=y
CONFIG_SERIAL_8250_MID=y
# CONFIG_SERIAL_OF_PLATFORM is not set

#
# Non-8250 serial port support
#
# CONFIG_SERIAL_MAX3100 is not set
# CONFIG_SERIAL_MAX310X is not set
# CONFIG_SERIAL_UARTLITE is not set
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
# CONFIG_SERIAL_JSM is not set
# CONFIG_SERIAL_SIFIVE is not set
# CONFIG_SERIAL_LANTIQ is not set
# CONFIG_SERIAL_SCCNXP is not set
# CONFIG_SERIAL_SC16IS7XX is not set
# CONFIG_SERIAL_TIMBERDALE is not set
# CONFIG_SERIAL_ALTERA_JTAGUART is not set
# CONFIG_SERIAL_ALTERA_UART is not set
# CONFIG_SERIAL_IFX6X60 is not set
# CONFIG_SERIAL_PCH_UART is not set
# CONFIG_SERIAL_XILINX_PS_UART is not set
# CONFIG_SERIAL_ARC is not set
# CONFIG_SERIAL_RP2 is not set
# CONFIG_SERIAL_FSL_LPUART is not set
# CONFIG_SERIAL_FSL_LINFLEXUART is not set
# CONFIG_SERIAL_CONEXANT_DIGICOLOR is not set
# CONFIG_SERIAL_MEN_Z135 is not set
# CONFIG_SERIAL_SPRD is not set
# end of Serial drivers

CONFIG_SERIAL_MCTRL_GPIO=y
# CONFIG_SERIAL_NONSTANDARD is not set
# CONFIG_GOLDFISH_TTY is not set
# CONFIG_N_GSM is not set
# CONFIG_NOZOMI is not set
# CONFIG_NULL_TTY is not set
# CONFIG_TRACE_SINK is not set
CONFIG_SERIAL_DEV_BUS=y
CONFIG_SERIAL_DEV_CTRL_TTYPORT=y
# CONFIG_TTY_PRINTK is not set
CONFIG_PRINTER=y
# CONFIG_LP_CONSOLE is not set
CONFIG_PPDEV=y
# CONFIG_VIRTIO_CONSOLE is not set
# CONFIG_IPMI_HANDLER is not set
CONFIG_IPMB_DEVICE_INTERFACE=y
CONFIG_HW_RANDOM=y
CONFIG_HW_RANDOM_TIMERIOMEM=y
CONFIG_HW_RANDOM_INTEL=y
CONFIG_HW_RANDOM_AMD=y
# CONFIG_HW_RANDOM_BA431 is not set
CONFIG_HW_RANDOM_GEODE=y
CONFIG_HW_RANDOM_VIA=y
# CONFIG_HW_RANDOM_VIRTIO is not set
# CONFIG_HW_RANDOM_CCTRNG is not set
# CONFIG_APPLICOM is not set
# CONFIG_SONYPI is not set

#
# PCMCIA character devices
#
# CONFIG_SYNCLINK_CS is not set
# CONFIG_CARDMAN_4000 is not set
# CONFIG_CARDMAN_4040 is not set
CONFIG_SCR24X=y
# CONFIG_IPWIRELESS is not set
# end of PCMCIA character devices

# CONFIG_MWAVE is not set
CONFIG_SCx200_GPIO=y
CONFIG_PC8736x_GPIO=y
CONFIG_NSC_GPIO=y
CONFIG_DEVMEM=y
# CONFIG_DEVKMEM is not set
CONFIG_NVRAM=y
CONFIG_DEVPORT=y
CONFIG_HPET=y
# CONFIG_HPET_MMAP is not set
CONFIG_HANGCHECK_TIMER=y
CONFIG_TCG_TPM=y
CONFIG_HW_RANDOM_TPM=y
CONFIG_TCG_TIS_CORE=y
# CONFIG_TCG_TIS is not set
CONFIG_TCG_TIS_SPI=y
# CONFIG_TCG_TIS_SPI_CR50 is not set
CONFIG_TCG_TIS_I2C_ATMEL=y
CONFIG_TCG_TIS_I2C_INFINEON=y
CONFIG_TCG_TIS_I2C_NUVOTON=y
CONFIG_TCG_NSC=y
CONFIG_TCG_ATMEL=y
# CONFIG_TCG_INFINEON is not set
CONFIG_TCG_CRB=y
CONFIG_TCG_VTPM_PROXY=y
CONFIG_TCG_TIS_ST33ZP24=y
CONFIG_TCG_TIS_ST33ZP24_I2C=y
CONFIG_TCG_TIS_ST33ZP24_SPI=y
CONFIG_TELCLOCK=y
# CONFIG_XILLYBUS is not set
# end of Character devices

CONFIG_RANDOM_TRUST_CPU=y
# CONFIG_RANDOM_TRUST_BOOTLOADER is not set

#
# I2C support
#
CONFIG_I2C=y
# CONFIG_ACPI_I2C_OPREGION is not set
CONFIG_I2C_BOARDINFO=y
# CONFIG_I2C_COMPAT is not set
CONFIG_I2C_CHARDEV=y
CONFIG_I2C_MUX=y

#
# Multiplexer I2C Chip support
#
CONFIG_I2C_ARB_GPIO_CHALLENGE=y
# CONFIG_I2C_MUX_GPIO is not set
# CONFIG_I2C_MUX_GPMUX is not set
CONFIG_I2C_MUX_LTC4306=y
# CONFIG_I2C_MUX_PCA9541 is not set
# CONFIG_I2C_MUX_PCA954x is not set
CONFIG_I2C_MUX_PINCTRL=y
CONFIG_I2C_MUX_REG=y
# CONFIG_I2C_DEMUX_PINCTRL is not set
CONFIG_I2C_MUX_MLXCPLD=y
# end of Multiplexer I2C Chip support

CONFIG_I2C_HELPER_AUTO=y
CONFIG_I2C_SMBUS=y
CONFIG_I2C_ALGOBIT=y
CONFIG_I2C_ALGOPCA=y

#
# I2C Hardware Bus support
#

#
# PC SMBus host controller drivers
#
# CONFIG_I2C_ALI1535 is not set
# CONFIG_I2C_ALI1563 is not set
# CONFIG_I2C_ALI15X3 is not set
# CONFIG_I2C_AMD756 is not set
# CONFIG_I2C_AMD8111 is not set
# CONFIG_I2C_AMD_MP2 is not set
# CONFIG_I2C_I801 is not set
# CONFIG_I2C_ISCH is not set
# CONFIG_I2C_ISMT is not set
# CONFIG_I2C_PIIX4 is not set
# CONFIG_I2C_CHT_WC is not set
# CONFIG_I2C_NFORCE2 is not set
# CONFIG_I2C_NVIDIA_GPU is not set
# CONFIG_I2C_SIS5595 is not set
# CONFIG_I2C_SIS630 is not set
# CONFIG_I2C_SIS96X is not set
# CONFIG_I2C_VIA is not set
# CONFIG_I2C_VIAPRO is not set

#
# ACPI drivers
#
CONFIG_I2C_SCMI=y

#
# I2C system bus drivers (mostly embedded / system-on-chip)
#
CONFIG_I2C_CBUS_GPIO=y
CONFIG_I2C_DESIGNWARE_CORE=y
# CONFIG_I2C_DESIGNWARE_SLAVE is not set
CONFIG_I2C_DESIGNWARE_PLATFORM=y
# CONFIG_I2C_DESIGNWARE_PCI is not set
# CONFIG_I2C_EG20T is not set
CONFIG_I2C_EMEV2=y
# CONFIG_I2C_GPIO is not set
# CONFIG_I2C_KEMPLD is not set
CONFIG_I2C_OCORES=y
CONFIG_I2C_PCA_PLATFORM=y
# CONFIG_I2C_PXA is not set
# CONFIG_I2C_RK3X is not set
CONFIG_I2C_SIMTEC=y
# CONFIG_I2C_XILINX is not set

#
# External I2C/SMBus adapter drivers
#
# CONFIG_I2C_DIOLAN_U2C is not set
CONFIG_I2C_PARPORT=y
CONFIG_I2C_ROBOTFUZZ_OSIF=y
# CONFIG_I2C_TAOS_EVM is not set
CONFIG_I2C_TINY_USB=y

#
# Other I2C/SMBus bus drivers
#
CONFIG_I2C_CROS_EC_TUNNEL=y
# CONFIG_SCx200_ACB is not set
# end of I2C Hardware Bus support

# CONFIG_I2C_STUB is not set
CONFIG_I2C_SLAVE=y
CONFIG_I2C_SLAVE_EEPROM=y
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# end of I2C support

CONFIG_I3C=y
# CONFIG_CDNS_I3C_MASTER is not set
# CONFIG_DW_I3C_MASTER is not set
CONFIG_SPI=y
# CONFIG_SPI_DEBUG is not set
CONFIG_SPI_MASTER=y
CONFIG_SPI_MEM=y

#
# SPI Master Controller Drivers
#
CONFIG_SPI_ALTERA=y
CONFIG_SPI_AXI_SPI_ENGINE=y
CONFIG_SPI_BITBANG=y
# CONFIG_SPI_BUTTERFLY is not set
# CONFIG_SPI_CADENCE is not set
CONFIG_SPI_DESIGNWARE=y
# CONFIG_SPI_DW_DMA is not set
# CONFIG_SPI_DW_PCI is not set
# CONFIG_SPI_DW_MMIO is not set
CONFIG_SPI_NXP_FLEXSPI=y
# CONFIG_SPI_GPIO is not set
# CONFIG_SPI_LM70_LLP is not set
CONFIG_SPI_FSL_LIB=y
CONFIG_SPI_FSL_SPI=y
# CONFIG_SPI_LANTIQ_SSC is not set
CONFIG_SPI_OC_TINY=y
CONFIG_SPI_PXA2XX=y
CONFIG_SPI_PXA2XX_PCI=y
CONFIG_SPI_ROCKCHIP=y
CONFIG_SPI_SC18IS602=y
CONFIG_SPI_SIFIVE=y
# CONFIG_SPI_MXIC is not set
# CONFIG_SPI_TOPCLIFF_PCH is not set
CONFIG_SPI_XCOMM=y
# CONFIG_SPI_XILINX is not set
CONFIG_SPI_ZYNQMP_GQSPI=y
# CONFIG_SPI_AMD is not set

#
# SPI Multiplexer support
#
CONFIG_SPI_MUX=y

#
# SPI Protocol Masters
#
CONFIG_SPI_SPIDEV=y
# CONFIG_SPI_LOOPBACK_TEST is not set
CONFIG_SPI_TLE62X0=y
CONFIG_SPI_SLAVE=y
CONFIG_SPI_SLAVE_TIME=y
CONFIG_SPI_SLAVE_SYSTEM_CONTROL=y
CONFIG_SPI_DYNAMIC=y
# CONFIG_SPMI is not set
CONFIG_HSI=y
CONFIG_HSI_BOARDINFO=y

#
# HSI controllers
#

#
# HSI clients
#
# CONFIG_HSI_CHAR is not set
CONFIG_PPS=y
# CONFIG_PPS_DEBUG is not set
# CONFIG_NTP_PPS is not set

#
# PPS clients support
#
CONFIG_PPS_CLIENT_KTIMER=y
# CONFIG_PPS_CLIENT_LDISC is not set
CONFIG_PPS_CLIENT_PARPORT=y
CONFIG_PPS_CLIENT_GPIO=y

#
# PPS generators support
#

#
# PTP clock support
#
# CONFIG_PTP_1588_CLOCK is not set

#
# Enable PHYLIB and NETWORK_PHY_TIMESTAMPING to see the additional clocks.
#
CONFIG_PTP_1588_CLOCK_PCH=y
# end of PTP clock support

CONFIG_PINCTRL=y
CONFIG_GENERIC_PINCTRL_GROUPS=y
CONFIG_PINMUX=y
CONFIG_GENERIC_PINMUX_FUNCTIONS=y
CONFIG_PINCONF=y
CONFIG_GENERIC_PINCONF=y
# CONFIG_DEBUG_PINCTRL is not set
CONFIG_PINCTRL_AS3722=y
# CONFIG_PINCTRL_AXP209 is not set
CONFIG_PINCTRL_AMD=y
CONFIG_PINCTRL_DA9062=y
# CONFIG_PINCTRL_MCP23S08 is not set
CONFIG_PINCTRL_SINGLE=y
# CONFIG_PINCTRL_SX150X is not set
CONFIG_PINCTRL_STMFX=y
CONFIG_PINCTRL_MAX77620=y
# CONFIG_PINCTRL_RK805 is not set
CONFIG_PINCTRL_OCELOT=y
# CONFIG_PINCTRL_BAYTRAIL is not set
CONFIG_PINCTRL_CHERRYVIEW=y
# CONFIG_PINCTRL_LYNXPOINT is not set
CONFIG_PINCTRL_INTEL=y
# CONFIG_PINCTRL_BROXTON is not set
CONFIG_PINCTRL_CANNONLAKE=y
CONFIG_PINCTRL_CEDARFORK=y
CONFIG_PINCTRL_DENVERTON=y
# CONFIG_PINCTRL_EMMITSBURG is not set
CONFIG_PINCTRL_GEMINILAKE=y
# CONFIG_PINCTRL_ICELAKE is not set
CONFIG_PINCTRL_JASPERLAKE=y
CONFIG_PINCTRL_LEWISBURG=y
CONFIG_PINCTRL_SUNRISEPOINT=y
CONFIG_PINCTRL_TIGERLAKE=y
# CONFIG_PINCTRL_LOCHNAGAR is not set
CONFIG_PINCTRL_EQUILIBRIUM=y
CONFIG_GPIOLIB=y
CONFIG_GPIOLIB_FASTPATH_LIMIT=512
CONFIG_OF_GPIO=y
CONFIG_GPIO_ACPI=y
CONFIG_GPIOLIB_IRQCHIP=y
# CONFIG_DEBUG_GPIO is not set
CONFIG_GPIO_SYSFS=y
CONFIG_GPIO_GENERIC=y
CONFIG_GPIO_MAX730X=y

#
# Memory mapped GPIO drivers
#
CONFIG_GPIO_74XX_MMIO=y
# CONFIG_GPIO_ALTERA is not set
# CONFIG_GPIO_AMDPT is not set
# CONFIG_GPIO_CADENCE is not set
CONFIG_GPIO_DWAPB=y
# CONFIG_GPIO_EXAR is not set
CONFIG_GPIO_FTGPIO010=y
# CONFIG_GPIO_GENERIC_PLATFORM is not set
CONFIG_GPIO_GRGPIO=y
# CONFIG_GPIO_HLWD is not set
# CONFIG_GPIO_ICH is not set
# CONFIG_GPIO_LOGICVC is not set
CONFIG_GPIO_MB86S7X=y
CONFIG_GPIO_MENZ127=y
# CONFIG_GPIO_SAMA5D2_PIOBU is not set
CONFIG_GPIO_SIFIVE=y
CONFIG_GPIO_SIOX=y
CONFIG_GPIO_SYSCON=y
# CONFIG_GPIO_VX855 is not set
CONFIG_GPIO_WCD934X=y
# CONFIG_GPIO_XILINX is not set
# CONFIG_GPIO_AMD_FCH is not set
# end of Memory mapped GPIO drivers

#
# Port-mapped I/O GPIO drivers
#
CONFIG_GPIO_104_DIO_48E=y
CONFIG_GPIO_104_IDIO_16=y
# CONFIG_GPIO_104_IDI_48 is not set
# CONFIG_GPIO_F7188X is not set
CONFIG_GPIO_GPIO_MM=y
# CONFIG_GPIO_IT87 is not set
# CONFIG_GPIO_SCH is not set
CONFIG_GPIO_SCH311X=y
CONFIG_GPIO_TS5500=y
CONFIG_GPIO_WINBOND=y
# CONFIG_GPIO_WS16C48 is not set
# end of Port-mapped I/O GPIO drivers

#
# I2C GPIO expanders
#
CONFIG_GPIO_ADP5588=y
CONFIG_GPIO_ADP5588_IRQ=y
# CONFIG_GPIO_ADNP is not set
CONFIG_GPIO_GW_PLD=y
# CONFIG_GPIO_MAX7300 is not set
CONFIG_GPIO_MAX732X=y
CONFIG_GPIO_MAX732X_IRQ=y
CONFIG_GPIO_PCA953X=y
# CONFIG_GPIO_PCA953X_IRQ is not set
CONFIG_GPIO_PCA9570=y
CONFIG_GPIO_PCF857X=y
CONFIG_GPIO_TPIC2810=y
# end of I2C GPIO expanders

#
# MFD GPIO expanders
#
CONFIG_GPIO_ARIZONA=y
# CONFIG_GPIO_BD70528 is not set
CONFIG_GPIO_BD71828=y
CONFIG_GPIO_BD9571MWV=y
CONFIG_GPIO_DA9052=y
CONFIG_GPIO_KEMPLD=y
CONFIG_GPIO_LP3943=y
# CONFIG_GPIO_LP873X is not set
CONFIG_GPIO_LP87565=y
CONFIG_GPIO_MAX77620=y
CONFIG_GPIO_MAX77650=y
# CONFIG_GPIO_STMPE is not set
CONFIG_GPIO_TC3589X=y
# CONFIG_GPIO_TPS65086 is not set
# CONFIG_GPIO_TPS65218 is not set
# CONFIG_GPIO_TPS6586X is not set
# CONFIG_GPIO_TPS65910 is not set
# CONFIG_GPIO_TPS65912 is not set
CONFIG_GPIO_TQMX86=y
CONFIG_GPIO_TWL6040=y
CONFIG_GPIO_WM8350=y
CONFIG_GPIO_WM8994=y
# end of MFD GPIO expanders

#
# PCI GPIO expanders
#
# CONFIG_GPIO_AMD8111 is not set
# CONFIG_GPIO_BT8XX is not set
# CONFIG_GPIO_ML_IOH is not set
# CONFIG_GPIO_PCH is not set
# CONFIG_GPIO_PCI_IDIO_16 is not set
# CONFIG_GPIO_PCIE_IDIO_24 is not set
# CONFIG_GPIO_RDC321X is not set
# CONFIG_GPIO_SODAVILLE is not set
# end of PCI GPIO expanders

#
# SPI GPIO expanders
#
# CONFIG_GPIO_74X164 is not set
CONFIG_GPIO_MAX3191X=y
CONFIG_GPIO_MAX7301=y
# CONFIG_GPIO_MC33880 is not set
CONFIG_GPIO_PISOSR=y
CONFIG_GPIO_XRA1403=y
CONFIG_GPIO_MOXTET=y
# end of SPI GPIO expanders

#
# USB GPIO expanders
#
# end of USB GPIO expanders

CONFIG_GPIO_AGGREGATOR=y
# CONFIG_GPIO_MOCKUP is not set
CONFIG_W1=y
CONFIG_W1_CON=y

#
# 1-wire Bus Masters
#
# CONFIG_W1_MASTER_MATROX is not set
CONFIG_W1_MASTER_DS2490=y
# CONFIG_W1_MASTER_DS2482 is not set
# CONFIG_W1_MASTER_DS1WM is not set
# CONFIG_W1_MASTER_GPIO is not set
CONFIG_W1_MASTER_SGI=y
# end of 1-wire Bus Masters

#
# 1-wire Slaves
#
# CONFIG_W1_SLAVE_THERM is not set
# CONFIG_W1_SLAVE_SMEM is not set
CONFIG_W1_SLAVE_DS2405=y
CONFIG_W1_SLAVE_DS2408=y
CONFIG_W1_SLAVE_DS2408_READBACK=y
CONFIG_W1_SLAVE_DS2413=y
# CONFIG_W1_SLAVE_DS2406 is not set
CONFIG_W1_SLAVE_DS2423=y
CONFIG_W1_SLAVE_DS2805=y
CONFIG_W1_SLAVE_DS2430=y
CONFIG_W1_SLAVE_DS2431=y
CONFIG_W1_SLAVE_DS2433=y
CONFIG_W1_SLAVE_DS2433_CRC=y
CONFIG_W1_SLAVE_DS2438=y
CONFIG_W1_SLAVE_DS250X=y
CONFIG_W1_SLAVE_DS2780=y
CONFIG_W1_SLAVE_DS2781=y
CONFIG_W1_SLAVE_DS28E04=y
CONFIG_W1_SLAVE_DS28E17=y
# end of 1-wire Slaves

# CONFIG_POWER_AVS is not set
# CONFIG_POWER_RESET is not set
CONFIG_POWER_SUPPLY=y
CONFIG_POWER_SUPPLY_DEBUG=y
# CONFIG_POWER_SUPPLY_HWMON is not set
CONFIG_PDA_POWER=y
# CONFIG_GENERIC_ADC_BATTERY is not set
CONFIG_WM8350_POWER=y
# CONFIG_TEST_POWER is not set
CONFIG_CHARGER_ADP5061=y
# CONFIG_BATTERY_ACT8945A is not set
CONFIG_BATTERY_CPCAP=y
# CONFIG_BATTERY_CW2015 is not set
# CONFIG_BATTERY_DS2760 is not set
CONFIG_BATTERY_DS2780=y
CONFIG_BATTERY_DS2781=y
CONFIG_BATTERY_DS2782=y
# CONFIG_BATTERY_LEGO_EV3 is not set
# CONFIG_BATTERY_SBS is not set
CONFIG_CHARGER_SBS=y
# CONFIG_MANAGER_SBS is not set
CONFIG_BATTERY_BQ27XXX=y
CONFIG_BATTERY_BQ27XXX_I2C=y
CONFIG_BATTERY_BQ27XXX_HDQ=y
# CONFIG_BATTERY_BQ27XXX_DT_UPDATES_NVM is not set
CONFIG_BATTERY_DA9052=y
CONFIG_CHARGER_AXP20X=y
CONFIG_BATTERY_AXP20X=y
# CONFIG_AXP20X_POWER is not set
CONFIG_AXP288_CHARGER=y
CONFIG_AXP288_FUEL_GAUGE=y
# CONFIG_BATTERY_MAX17040 is not set
# CONFIG_BATTERY_MAX17042 is not set
CONFIG_BATTERY_MAX1721X=y
# CONFIG_CHARGER_PCF50633 is not set
# CONFIG_CHARGER_MAX8903 is not set
CONFIG_CHARGER_LP8727=y
# CONFIG_CHARGER_LP8788 is not set
CONFIG_CHARGER_GPIO=y
CONFIG_CHARGER_MANAGER=y
CONFIG_CHARGER_LT3651=y
CONFIG_CHARGER_MAX14577=y
CONFIG_CHARGER_DETECTOR_MAX14656=y
# CONFIG_CHARGER_MAX77650 is not set
# CONFIG_CHARGER_MAX77693 is not set
CONFIG_CHARGER_MAX8998=y
CONFIG_CHARGER_BQ2415X=y
# CONFIG_CHARGER_BQ24190 is not set
CONFIG_CHARGER_BQ24257=y
CONFIG_CHARGER_BQ24735=y
# CONFIG_CHARGER_BQ2515X is not set
# CONFIG_CHARGER_BQ25890 is not set
# CONFIG_CHARGER_SMB347 is not set
CONFIG_CHARGER_TPS65217=y
# CONFIG_BATTERY_GAUGE_LTC2941 is not set
# CONFIG_BATTERY_GOLDFISH is not set
# CONFIG_BATTERY_RT5033 is not set
CONFIG_CHARGER_RT9455=y
CONFIG_CHARGER_CROS_USBPD=y
CONFIG_CHARGER_UCS1002=y
# CONFIG_CHARGER_BD70528 is not set
# CONFIG_CHARGER_BD99954 is not set
# CONFIG_CHARGER_WILCO is not set
CONFIG_HWMON=y
CONFIG_HWMON_VID=y
# CONFIG_HWMON_DEBUG_CHIP is not set

#
# Native drivers
#
# CONFIG_SENSORS_ABITUGURU is not set
# CONFIG_SENSORS_ABITUGURU3 is not set
CONFIG_SENSORS_AD7314=y
# CONFIG_SENSORS_AD7414 is not set
CONFIG_SENSORS_AD7418=y
# CONFIG_SENSORS_ADM1021 is not set
# CONFIG_SENSORS_ADM1025 is not set
CONFIG_SENSORS_ADM1026=y
CONFIG_SENSORS_ADM1029=y
CONFIG_SENSORS_ADM1031=y
CONFIG_SENSORS_ADM1177=y
CONFIG_SENSORS_ADM9240=y
CONFIG_SENSORS_ADT7X10=y
CONFIG_SENSORS_ADT7310=y
# CONFIG_SENSORS_ADT7410 is not set
CONFIG_SENSORS_ADT7411=y
CONFIG_SENSORS_ADT7462=y
CONFIG_SENSORS_ADT7470=y
CONFIG_SENSORS_ADT7475=y
# CONFIG_SENSORS_AS370 is not set
# CONFIG_SENSORS_ASC7621 is not set
CONFIG_SENSORS_AXI_FAN_CONTROL=y
# CONFIG_SENSORS_K8TEMP is not set
# CONFIG_SENSORS_K10TEMP is not set
# CONFIG_SENSORS_FAM15H_POWER is not set
CONFIG_SENSORS_AMD_ENERGY=y
CONFIG_SENSORS_APPLESMC=y
CONFIG_SENSORS_ASB100=y
CONFIG_SENSORS_ASPEED=y
CONFIG_SENSORS_ATXP1=y
CONFIG_SENSORS_CORSAIR_CPRO=y
CONFIG_SENSORS_DS620=y
CONFIG_SENSORS_DS1621=y
CONFIG_SENSORS_DELL_SMM=y
CONFIG_SENSORS_DA9052_ADC=y
# CONFIG_SENSORS_I5K_AMB is not set
CONFIG_SENSORS_F71805F=y
CONFIG_SENSORS_F71882FG=y
CONFIG_SENSORS_F75375S=y
# CONFIG_SENSORS_GSC is not set
CONFIG_SENSORS_MC13783_ADC=y
CONFIG_SENSORS_FSCHMD=y
CONFIG_SENSORS_GL518SM=y
CONFIG_SENSORS_GL520SM=y
CONFIG_SENSORS_G760A=y
CONFIG_SENSORS_G762=y
CONFIG_SENSORS_GPIO_FAN=y
CONFIG_SENSORS_HIH6130=y
# CONFIG_SENSORS_IIO_HWMON is not set
# CONFIG_SENSORS_I5500 is not set
CONFIG_SENSORS_CORETEMP=y
CONFIG_SENSORS_IT87=y
# CONFIG_SENSORS_JC42 is not set
CONFIG_SENSORS_POWR1220=y
# CONFIG_SENSORS_LINEAGE is not set
# CONFIG_SENSORS_LOCHNAGAR is not set
CONFIG_SENSORS_LTC2945=y
CONFIG_SENSORS_LTC2947=y
CONFIG_SENSORS_LTC2947_I2C=y
# CONFIG_SENSORS_LTC2947_SPI is not set
# CONFIG_SENSORS_LTC2990 is not set
CONFIG_SENSORS_LTC4151=y
# CONFIG_SENSORS_LTC4215 is not set
CONFIG_SENSORS_LTC4222=y
CONFIG_SENSORS_LTC4245=y
CONFIG_SENSORS_LTC4260=y
CONFIG_SENSORS_LTC4261=y
# CONFIG_SENSORS_MAX1111 is not set
# CONFIG_SENSORS_MAX16065 is not set
# CONFIG_SENSORS_MAX1619 is not set
CONFIG_SENSORS_MAX1668=y
CONFIG_SENSORS_MAX197=y
CONFIG_SENSORS_MAX31722=y
CONFIG_SENSORS_MAX31730=y
# CONFIG_SENSORS_MAX6621 is not set
# CONFIG_SENSORS_MAX6639 is not set
CONFIG_SENSORS_MAX6642=y
CONFIG_SENSORS_MAX6650=y
CONFIG_SENSORS_MAX6697=y
CONFIG_SENSORS_MAX31790=y
# CONFIG_SENSORS_MCP3021 is not set
# CONFIG_SENSORS_TC654 is not set
CONFIG_SENSORS_MENF21BMC_HWMON=y
# CONFIG_SENSORS_ADCXX is not set
CONFIG_SENSORS_LM63=y
# CONFIG_SENSORS_LM70 is not set
CONFIG_SENSORS_LM73=y
CONFIG_SENSORS_LM75=y
CONFIG_SENSORS_LM77=y
# CONFIG_SENSORS_LM78 is not set
CONFIG_SENSORS_LM80=y
CONFIG_SENSORS_LM83=y
# CONFIG_SENSORS_LM85 is not set
# CONFIG_SENSORS_LM87 is not set
CONFIG_SENSORS_LM90=y
CONFIG_SENSORS_LM92=y
CONFIG_SENSORS_LM93=y
CONFIG_SENSORS_LM95234=y
# CONFIG_SENSORS_LM95241 is not set
CONFIG_SENSORS_LM95245=y
# CONFIG_SENSORS_PC87360 is not set
CONFIG_SENSORS_PC87427=y
CONFIG_SENSORS_NTC_THERMISTOR=y
CONFIG_SENSORS_NCT6683=y
# CONFIG_SENSORS_NCT6775 is not set
CONFIG_SENSORS_NCT7802=y
CONFIG_SENSORS_NPCM7XX=y
# CONFIG_SENSORS_PCF8591 is not set
CONFIG_PMBUS=y
CONFIG_SENSORS_PMBUS=y
CONFIG_SENSORS_ADM1275=y
CONFIG_SENSORS_BEL_PFE=y
CONFIG_SENSORS_IBM_CFFPS=y
CONFIG_SENSORS_INSPUR_IPSPS=y
# CONFIG_SENSORS_IR35221 is not set
CONFIG_SENSORS_IR38064=y
CONFIG_SENSORS_IRPS5401=y
CONFIG_SENSORS_ISL68137=y
CONFIG_SENSORS_LM25066=y
CONFIG_SENSORS_LTC2978=y
CONFIG_SENSORS_LTC2978_REGULATOR=y
# CONFIG_SENSORS_LTC3815 is not set
# CONFIG_SENSORS_MAX16064 is not set
# CONFIG_SENSORS_MAX16601 is not set
CONFIG_SENSORS_MAX20730=y
CONFIG_SENSORS_MAX20751=y
CONFIG_SENSORS_MAX31785=y
# CONFIG_SENSORS_MAX34440 is not set
CONFIG_SENSORS_MAX8688=y
# CONFIG_SENSORS_PXE1610 is not set
# CONFIG_SENSORS_TPS40422 is not set
# CONFIG_SENSORS_TPS53679 is not set
CONFIG_SENSORS_UCD9000=y
CONFIG_SENSORS_UCD9200=y
CONFIG_SENSORS_XDPE122=y
CONFIG_SENSORS_ZL6100=y
CONFIG_SENSORS_PWM_FAN=y
# CONFIG_SENSORS_SHT15 is not set
CONFIG_SENSORS_SHT21=y
# CONFIG_SENSORS_SHT3x is not set
CONFIG_SENSORS_SHTC1=y
# CONFIG_SENSORS_SIS5595 is not set
# CONFIG_SENSORS_DME1737 is not set
CONFIG_SENSORS_EMC1403=y
CONFIG_SENSORS_EMC2103=y
CONFIG_SENSORS_EMC6W201=y
# CONFIG_SENSORS_SMSC47M1 is not set
CONFIG_SENSORS_SMSC47M192=y
# CONFIG_SENSORS_SMSC47B397 is not set
# CONFIG_SENSORS_STTS751 is not set
CONFIG_SENSORS_SMM665=y
# CONFIG_SENSORS_ADC128D818 is not set
CONFIG_SENSORS_ADS7828=y
CONFIG_SENSORS_ADS7871=y
CONFIG_SENSORS_AMC6821=y
CONFIG_SENSORS_INA209=y
# CONFIG_SENSORS_INA2XX is not set
# CONFIG_SENSORS_INA3221 is not set
CONFIG_SENSORS_TC74=y
# CONFIG_SENSORS_THMC50 is not set
CONFIG_SENSORS_TMP102=y
CONFIG_SENSORS_TMP103=y
CONFIG_SENSORS_TMP108=y
CONFIG_SENSORS_TMP401=y
CONFIG_SENSORS_TMP421=y
CONFIG_SENSORS_TMP513=y
CONFIG_SENSORS_VIA_CPUTEMP=y
# CONFIG_SENSORS_VIA686A is not set
CONFIG_SENSORS_VT1211=y
# CONFIG_SENSORS_VT8231 is not set
# CONFIG_SENSORS_W83773G is not set
CONFIG_SENSORS_W83781D=y
CONFIG_SENSORS_W83791D=y
# CONFIG_SENSORS_W83792D is not set
CONFIG_SENSORS_W83793=y
CONFIG_SENSORS_W83795=y
CONFIG_SENSORS_W83795_FANCTRL=y
CONFIG_SENSORS_W83L785TS=y
CONFIG_SENSORS_W83L786NG=y
CONFIG_SENSORS_W83627HF=y
# CONFIG_SENSORS_W83627EHF is not set
# CONFIG_SENSORS_WM8350 is not set

#
# ACPI drivers
#
# CONFIG_SENSORS_ACPI_POWER is not set
# CONFIG_SENSORS_ATK0110 is not set
CONFIG_THERMAL=y
# CONFIG_THERMAL_NETLINK is not set
# CONFIG_THERMAL_STATISTICS is not set
CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
CONFIG_THERMAL_HWMON=y
CONFIG_THERMAL_OF=y
CONFIG_THERMAL_WRITABLE_TRIPS=y
CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE=y
# CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
# CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
CONFIG_THERMAL_GOV_FAIR_SHARE=y
CONFIG_THERMAL_GOV_STEP_WISE=y
# CONFIG_THERMAL_GOV_BANG_BANG is not set
# CONFIG_THERMAL_GOV_USER_SPACE is not set
# CONFIG_CPU_THERMAL is not set
# CONFIG_DEVFREQ_THERMAL is not set
# CONFIG_THERMAL_EMULATION is not set
CONFIG_THERMAL_MMIO=y
CONFIG_MAX77620_THERMAL=y
# CONFIG_DA9062_THERMAL is not set

#
# Intel thermal drivers
#
CONFIG_INTEL_POWERCLAMP=y
# CONFIG_INTEL_SOC_DTS_THERMAL is not set

#
# ACPI INT340X thermal drivers
#
# CONFIG_INT340X_THERMAL is not set
# end of ACPI INT340X thermal drivers

# CONFIG_INTEL_PCH_THERMAL is not set
# end of Intel thermal drivers

CONFIG_GENERIC_ADC_THERMAL=y
# CONFIG_WATCHDOG is not set
CONFIG_SSB_POSSIBLE=y
CONFIG_SSB=y
CONFIG_SSB_SPROM=y
CONFIG_SSB_PCIHOST_POSSIBLE=y
CONFIG_SSB_PCIHOST=y
CONFIG_SSB_PCMCIAHOST_POSSIBLE=y
CONFIG_SSB_PCMCIAHOST=y
CONFIG_SSB_DRIVER_PCICORE_POSSIBLE=y
# CONFIG_SSB_DRIVER_PCICORE is not set
CONFIG_SSB_DRIVER_GPIO=y
CONFIG_BCMA_POSSIBLE=y
# CONFIG_BCMA is not set

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=y
# CONFIG_MFD_CS5535 is not set
CONFIG_MFD_ACT8945A=y
# CONFIG_MFD_AS3711 is not set
CONFIG_MFD_AS3722=y
# CONFIG_PMIC_ADP5520 is not set
# CONFIG_MFD_AAT2870_CORE is not set
# CONFIG_MFD_ATMEL_FLEXCOM is not set
CONFIG_MFD_ATMEL_HLCDC=y
CONFIG_MFD_BCM590XX=y
CONFIG_MFD_BD9571MWV=y
CONFIG_MFD_AXP20X=y
CONFIG_MFD_AXP20X_I2C=y
CONFIG_MFD_CROS_EC_DEV=y
# CONFIG_MFD_MADERA is not set
# CONFIG_PMIC_DA903X is not set
CONFIG_PMIC_DA9052=y
CONFIG_MFD_DA9052_SPI=y
# CONFIG_MFD_DA9052_I2C is not set
# CONFIG_MFD_DA9055 is not set
CONFIG_MFD_DA9062=y
CONFIG_MFD_DA9063=y
# CONFIG_MFD_DA9150 is not set
# CONFIG_MFD_DLN2 is not set
CONFIG_MFD_GATEWORKS_GSC=y
CONFIG_MFD_MC13XXX=y
CONFIG_MFD_MC13XXX_SPI=y
CONFIG_MFD_MC13XXX_I2C=y
# CONFIG_MFD_MP2629 is not set
CONFIG_MFD_HI6421_PMIC=y
# CONFIG_HTC_PASIC3 is not set
CONFIG_HTC_I2CPLD=y
# CONFIG_MFD_INTEL_QUARK_I2C_GPIO is not set
# CONFIG_LPC_ICH is not set
# CONFIG_LPC_SCH is not set
# CONFIG_INTEL_SOC_PMIC is not set
CONFIG_INTEL_SOC_PMIC_CHTWC=y
CONFIG_INTEL_SOC_PMIC_CHTDC_TI=y
CONFIG_MFD_INTEL_LPSS=y
CONFIG_MFD_INTEL_LPSS_ACPI=y
# CONFIG_MFD_INTEL_LPSS_PCI is not set
CONFIG_MFD_IQS62X=y
# CONFIG_MFD_JANZ_CMODIO is not set
CONFIG_MFD_KEMPLD=y
CONFIG_MFD_88PM800=y
CONFIG_MFD_88PM805=y
# CONFIG_MFD_88PM860X is not set
CONFIG_MFD_MAX14577=y
CONFIG_MFD_MAX77620=y
CONFIG_MFD_MAX77650=y
CONFIG_MFD_MAX77686=y
CONFIG_MFD_MAX77693=y
CONFIG_MFD_MAX77843=y
# CONFIG_MFD_MAX8907 is not set
# CONFIG_MFD_MAX8925 is not set
# CONFIG_MFD_MAX8997 is not set
CONFIG_MFD_MAX8998=y
CONFIG_MFD_MT6360=y
CONFIG_MFD_MT6397=y
CONFIG_MFD_MENF21BMC=y
CONFIG_EZX_PCAP=y
CONFIG_MFD_CPCAP=y
# CONFIG_MFD_VIPERBOARD is not set
# CONFIG_MFD_RETU is not set
CONFIG_MFD_PCF50633=y
CONFIG_PCF50633_ADC=y
CONFIG_PCF50633_GPIO=y
# CONFIG_MFD_RDC321X is not set
CONFIG_MFD_RT5033=y
# CONFIG_MFD_RC5T583 is not set
CONFIG_MFD_RK808=y
CONFIG_MFD_RN5T618=y
CONFIG_MFD_SEC_CORE=y
CONFIG_MFD_SI476X_CORE=y
# CONFIG_MFD_SM501 is not set
CONFIG_MFD_SKY81452=y
CONFIG_ABX500_CORE=y
CONFIG_AB3100_CORE=y
CONFIG_AB3100_OTP=y
CONFIG_MFD_STMPE=y

#
# STMicroelectronics STMPE Interface Drivers
#
# CONFIG_STMPE_I2C is not set
# CONFIG_STMPE_SPI is not set
# end of STMicroelectronics STMPE Interface Drivers

CONFIG_MFD_SYSCON=y
# CONFIG_MFD_TI_AM335X_TSCADC is not set
CONFIG_MFD_LP3943=y
CONFIG_MFD_LP8788=y
# CONFIG_MFD_TI_LMU is not set
# CONFIG_MFD_PALMAS is not set
CONFIG_TPS6105X=y
# CONFIG_TPS65010 is not set
# CONFIG_TPS6507X is not set
CONFIG_MFD_TPS65086=y
# CONFIG_MFD_TPS65090 is not set
CONFIG_MFD_TPS65217=y
# CONFIG_MFD_TPS68470 is not set
CONFIG_MFD_TI_LP873X=y
CONFIG_MFD_TI_LP87565=y
CONFIG_MFD_TPS65218=y
CONFIG_MFD_TPS6586X=y
CONFIG_MFD_TPS65910=y
CONFIG_MFD_TPS65912=y
CONFIG_MFD_TPS65912_I2C=y
CONFIG_MFD_TPS65912_SPI=y
CONFIG_MFD_TPS80031=y
# CONFIG_TWL4030_CORE is not set
CONFIG_TWL6040_CORE=y
CONFIG_MFD_WL1273_CORE=y
CONFIG_MFD_LM3533=y
# CONFIG_MFD_TIMBERDALE is not set
CONFIG_MFD_TC3589X=y
CONFIG_MFD_TQMX86=y
# CONFIG_MFD_VX855 is not set
CONFIG_MFD_LOCHNAGAR=y
CONFIG_MFD_ARIZONA=y
CONFIG_MFD_ARIZONA_I2C=y
# CONFIG_MFD_ARIZONA_SPI is not set
# CONFIG_MFD_CS47L24 is not set
# CONFIG_MFD_WM5102 is not set
# CONFIG_MFD_WM5110 is not set
CONFIG_MFD_WM8997=y
CONFIG_MFD_WM8998=y
# CONFIG_MFD_WM8400 is not set
# CONFIG_MFD_WM831X_I2C is not set
# CONFIG_MFD_WM831X_SPI is not set
CONFIG_MFD_WM8350=y
CONFIG_MFD_WM8350_I2C=y
CONFIG_MFD_WM8994=y
# CONFIG_MFD_ROHM_BD718XX is not set
CONFIG_MFD_ROHM_BD70528=y
CONFIG_MFD_ROHM_BD71828=y
CONFIG_MFD_STPMIC1=y
CONFIG_MFD_STMFX=y
CONFIG_MFD_WCD934X=y
# CONFIG_RAVE_SP_CORE is not set
# end of Multifunction device drivers

CONFIG_REGULATOR=y
CONFIG_REGULATOR_DEBUG=y
CONFIG_REGULATOR_FIXED_VOLTAGE=y
# CONFIG_REGULATOR_VIRTUAL_CONSUMER is not set
CONFIG_REGULATOR_USERSPACE_CONSUMER=y
CONFIG_REGULATOR_88PG86X=y
# CONFIG_REGULATOR_88PM800 is not set
CONFIG_REGULATOR_ACT8865=y
# CONFIG_REGULATOR_ACT8945A is not set
CONFIG_REGULATOR_AD5398=y
CONFIG_REGULATOR_AB3100=y
# CONFIG_REGULATOR_AS3722 is not set
CONFIG_REGULATOR_AXP20X=y
CONFIG_REGULATOR_BCM590XX=y
# CONFIG_REGULATOR_BD70528 is not set
# CONFIG_REGULATOR_BD71828 is not set
CONFIG_REGULATOR_BD9571MWV=y
CONFIG_REGULATOR_CPCAP=y
# CONFIG_REGULATOR_CROS_EC is not set
CONFIG_REGULATOR_DA9052=y
# CONFIG_REGULATOR_DA9062 is not set
CONFIG_REGULATOR_DA9063=y
CONFIG_REGULATOR_DA9210=y
CONFIG_REGULATOR_DA9211=y
CONFIG_REGULATOR_FAN53555=y
CONFIG_REGULATOR_FAN53880=y
# CONFIG_REGULATOR_GPIO is not set
CONFIG_REGULATOR_HI6421=y
# CONFIG_REGULATOR_HI6421V530 is not set
CONFIG_REGULATOR_ISL9305=y
# CONFIG_REGULATOR_ISL6271A is not set
CONFIG_REGULATOR_LOCHNAGAR=y
# CONFIG_REGULATOR_LP3971 is not set
CONFIG_REGULATOR_LP3972=y
# CONFIG_REGULATOR_LP872X is not set
# CONFIG_REGULATOR_LP873X is not set
CONFIG_REGULATOR_LP8755=y
# CONFIG_REGULATOR_LP87565 is not set
CONFIG_REGULATOR_LP8788=y
CONFIG_REGULATOR_LTC3589=y
# CONFIG_REGULATOR_LTC3676 is not set
CONFIG_REGULATOR_MAX14577=y
# CONFIG_REGULATOR_MAX1586 is not set
# CONFIG_REGULATOR_MAX77620 is not set
# CONFIG_REGULATOR_MAX77650 is not set
CONFIG_REGULATOR_MAX8649=y
# CONFIG_REGULATOR_MAX8660 is not set
CONFIG_REGULATOR_MAX8952=y
CONFIG_REGULATOR_MAX8973=y
CONFIG_REGULATOR_MAX8998=y
CONFIG_REGULATOR_MAX77686=y
CONFIG_REGULATOR_MAX77693=y
# CONFIG_REGULATOR_MAX77802 is not set
CONFIG_REGULATOR_MAX77826=y
CONFIG_REGULATOR_MC13XXX_CORE=y
# CONFIG_REGULATOR_MC13783 is not set
CONFIG_REGULATOR_MC13892=y
# CONFIG_REGULATOR_MCP16502 is not set
CONFIG_REGULATOR_MP5416=y
# CONFIG_REGULATOR_MP8859 is not set
CONFIG_REGULATOR_MP886X=y
# CONFIG_REGULATOR_MPQ7920 is not set
# CONFIG_REGULATOR_MT6311 is not set
# CONFIG_REGULATOR_MT6323 is not set
CONFIG_REGULATOR_MT6358=y
CONFIG_REGULATOR_MT6397=y
CONFIG_REGULATOR_PCA9450=y
CONFIG_REGULATOR_PCAP=y
CONFIG_REGULATOR_PCF50633=y
CONFIG_REGULATOR_PFUZE100=y
# CONFIG_REGULATOR_PV88060 is not set
# CONFIG_REGULATOR_PV88080 is not set
# CONFIG_REGULATOR_PV88090 is not set
CONFIG_REGULATOR_PWM=y
CONFIG_REGULATOR_RK808=y
CONFIG_REGULATOR_RN5T618=y
CONFIG_REGULATOR_RT5033=y
# CONFIG_REGULATOR_S2MPA01 is not set
CONFIG_REGULATOR_S2MPS11=y
# CONFIG_REGULATOR_S5M8767 is not set
CONFIG_REGULATOR_SKY81452=y
CONFIG_REGULATOR_SLG51000=y
CONFIG_REGULATOR_STPMIC1=y
# CONFIG_REGULATOR_SY8106A is not set
# CONFIG_REGULATOR_SY8824X is not set
CONFIG_REGULATOR_SY8827N=y
CONFIG_REGULATOR_TPS51632=y
CONFIG_REGULATOR_TPS6105X=y
CONFIG_REGULATOR_TPS62360=y
CONFIG_REGULATOR_TPS65023=y
# CONFIG_REGULATOR_TPS6507X is not set
# CONFIG_REGULATOR_TPS65086 is not set
# CONFIG_REGULATOR_TPS65132 is not set
CONFIG_REGULATOR_TPS65217=y
CONFIG_REGULATOR_TPS65218=y
CONFIG_REGULATOR_TPS6524X=y
CONFIG_REGULATOR_TPS6586X=y
CONFIG_REGULATOR_TPS65910=y
CONFIG_REGULATOR_TPS65912=y
# CONFIG_REGULATOR_TPS80031 is not set
CONFIG_REGULATOR_VCTRL=y
# CONFIG_REGULATOR_WM8350 is not set
CONFIG_REGULATOR_WM8994=y
CONFIG_RC_CORE=y
CONFIG_RC_MAP=y
CONFIG_LIRC=y
# CONFIG_RC_DECODERS is not set
# CONFIG_RC_DEVICES is not set
CONFIG_CEC_CORE=y
CONFIG_CEC_NOTIFIER=y
CONFIG_MEDIA_CEC_RC=y
# CONFIG_MEDIA_CEC_SUPPORT is not set
CONFIG_MEDIA_SUPPORT=y
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
CONFIG_VIDEO_DEV=y
CONFIG_MEDIA_CONTROLLER=y
CONFIG_DVB_CORE=y
# end of Media core support

#
# Video4Linux options
#
CONFIG_VIDEO_V4L2=y
CONFIG_VIDEO_V4L2_I2C=y
CONFIG_VIDEO_V4L2_SUBDEV_API=y
CONFIG_VIDEO_ADV_DEBUG=y
CONFIG_VIDEO_FIXED_MINOR_RANGES=y
CONFIG_VIDEO_TUNER=y
CONFIG_V4L2_MEM2MEM_DEV=y
CONFIG_V4L2_FWNODE=y
CONFIG_VIDEOBUF_GEN=y
CONFIG_VIDEOBUF_VMALLOC=y
# end of Video4Linux options

#
# Media controller options
#
CONFIG_MEDIA_CONTROLLER_DVB=y
# end of Media controller options

#
# Digital TV options
#
# CONFIG_DVB_MMAP is not set
CONFIG_DVB_NET=y
CONFIG_DVB_MAX_ADAPTERS=16
# CONFIG_DVB_DYNAMIC_MINORS is not set
# CONFIG_DVB_DEMUX_SECTION_LOSS_LOG is not set
# CONFIG_DVB_ULE_DEBUG is not set
# end of Digital TV options

#
# Media drivers
#
CONFIG_MEDIA_USB_SUPPORT=y

#
# Webcam devices
#
CONFIG_USB_VIDEO_CLASS=y
CONFIG_USB_VIDEO_CLASS_INPUT_EVDEV=y
CONFIG_USB_GSPCA=y
CONFIG_USB_M5602=y
# CONFIG_USB_STV06XX is not set
CONFIG_USB_GL860=y
CONFIG_USB_GSPCA_BENQ=y
CONFIG_USB_GSPCA_CONEX=y
CONFIG_USB_GSPCA_CPIA1=y
CONFIG_USB_GSPCA_DTCS033=y
# CONFIG_USB_GSPCA_ETOMS is not set
CONFIG_USB_GSPCA_FINEPIX=y
CONFIG_USB_GSPCA_JEILINJ=y
CONFIG_USB_GSPCA_JL2005BCD=y
CONFIG_USB_GSPCA_KINECT=y
# CONFIG_USB_GSPCA_KONICA is not set
# CONFIG_USB_GSPCA_MARS is not set
CONFIG_USB_GSPCA_MR97310A=y
# CONFIG_USB_GSPCA_NW80X is not set
CONFIG_USB_GSPCA_OV519=y
CONFIG_USB_GSPCA_OV534=y
CONFIG_USB_GSPCA_OV534_9=y
CONFIG_USB_GSPCA_PAC207=y
CONFIG_USB_GSPCA_PAC7302=y
CONFIG_USB_GSPCA_PAC7311=y
# CONFIG_USB_GSPCA_SE401 is not set
CONFIG_USB_GSPCA_SN9C2028=y
CONFIG_USB_GSPCA_SN9C20X=y
CONFIG_USB_GSPCA_SONIXB=y
CONFIG_USB_GSPCA_SONIXJ=y
CONFIG_USB_GSPCA_SPCA500=y
CONFIG_USB_GSPCA_SPCA501=y
CONFIG_USB_GSPCA_SPCA505=y
CONFIG_USB_GSPCA_SPCA506=y
# CONFIG_USB_GSPCA_SPCA508 is not set
# CONFIG_USB_GSPCA_SPCA561 is not set
# CONFIG_USB_GSPCA_SPCA1528 is not set
CONFIG_USB_GSPCA_SQ905=y
CONFIG_USB_GSPCA_SQ905C=y
CONFIG_USB_GSPCA_SQ930X=y
CONFIG_USB_GSPCA_STK014=y
CONFIG_USB_GSPCA_STK1135=y
CONFIG_USB_GSPCA_STV0680=y
CONFIG_USB_GSPCA_SUNPLUS=y
CONFIG_USB_GSPCA_T613=y
CONFIG_USB_GSPCA_TOPRO=y
# CONFIG_USB_GSPCA_TOUPTEK is not set
CONFIG_USB_GSPCA_TV8532=y
# CONFIG_USB_GSPCA_VC032X is not set
CONFIG_USB_GSPCA_VICAM=y
# CONFIG_USB_GSPCA_XIRLINK_CIT is not set
CONFIG_USB_GSPCA_ZC3XX=y
# CONFIG_USB_PWC is not set
CONFIG_VIDEO_CPIA2=y
CONFIG_USB_ZR364XX=y
CONFIG_USB_STKWEBCAM=y
# CONFIG_USB_S2255 is not set

#
# Analog TV USB devices
#
CONFIG_VIDEO_PVRUSB2=y
# CONFIG_VIDEO_PVRUSB2_SYSFS is not set
# CONFIG_VIDEO_PVRUSB2_DVB is not set
# CONFIG_VIDEO_HDPVR is not set
CONFIG_VIDEO_STK1160_COMMON=y
CONFIG_VIDEO_STK1160=y

#
# Analog/digital TV USB devices
#
CONFIG_VIDEO_AU0828=y
CONFIG_VIDEO_AU0828_V4L2=y
# CONFIG_VIDEO_AU0828_RC is not set
# CONFIG_VIDEO_CX231XX is not set
# CONFIG_VIDEO_TM6000 is not set

#
# Digital TV USB devices
#
CONFIG_DVB_USB=y
CONFIG_DVB_USB_DEBUG=y
CONFIG_DVB_USB_DIB3000MC=y
CONFIG_DVB_USB_A800=y
CONFIG_DVB_USB_DIBUSB_MB=y
CONFIG_DVB_USB_DIBUSB_MB_FAULTY=y
# CONFIG_DVB_USB_DIBUSB_MC is not set
# CONFIG_DVB_USB_DIB0700 is not set
CONFIG_DVB_USB_UMT_010=y
CONFIG_DVB_USB_CXUSB=y
CONFIG_DVB_USB_CXUSB_ANALOG=y
# CONFIG_DVB_USB_M920X is not set
# CONFIG_DVB_USB_DIGITV is not set
CONFIG_DVB_USB_VP7045=y
CONFIG_DVB_USB_VP702X=y
# CONFIG_DVB_USB_GP8PSK is not set
# CONFIG_DVB_USB_NOVA_T_USB2 is not set
CONFIG_DVB_USB_TTUSB2=y
# CONFIG_DVB_USB_DTT200U is not set
# CONFIG_DVB_USB_OPERA1 is not set
CONFIG_DVB_USB_AF9005=y
CONFIG_DVB_USB_AF9005_REMOTE=y
# CONFIG_DVB_USB_PCTV452E is not set
CONFIG_DVB_USB_DW2102=y
CONFIG_DVB_USB_CINERGY_T2=y
CONFIG_DVB_USB_DTV5100=y
CONFIG_DVB_USB_AZ6027=y
# CONFIG_DVB_USB_TECHNISAT_USB2 is not set
CONFIG_DVB_USB_V2=y
# CONFIG_DVB_USB_AF9015 is not set
CONFIG_DVB_USB_AF9035=y
# CONFIG_DVB_USB_ANYSEE is not set
# CONFIG_DVB_USB_AU6610 is not set
CONFIG_DVB_USB_AZ6007=y
CONFIG_DVB_USB_CE6230=y
# CONFIG_DVB_USB_EC168 is not set
# CONFIG_DVB_USB_GL861 is not set
# CONFIG_DVB_USB_LME2510 is not set
CONFIG_DVB_USB_MXL111SF=y
# CONFIG_DVB_USB_RTL28XXU is not set
# CONFIG_DVB_USB_DVBSKY is not set
CONFIG_DVB_USB_ZD1301=y
# CONFIG_DVB_TTUSB_BUDGET is not set
# CONFIG_DVB_TTUSB_DEC is not set
CONFIG_SMS_USB_DRV=y
CONFIG_DVB_B2C2_FLEXCOP_USB=y
CONFIG_DVB_B2C2_FLEXCOP_USB_DEBUG=y
CONFIG_DVB_AS102=y

#
# Webcam, TV (analog/digital) USB devices
#
CONFIG_VIDEO_EM28XX=y
CONFIG_VIDEO_EM28XX_V4L2=y
CONFIG_VIDEO_EM28XX_DVB=y
CONFIG_VIDEO_EM28XX_RC=y

#
# Software defined radio USB devices
#
# CONFIG_USB_AIRSPY is not set
# CONFIG_USB_HACKRF is not set
# CONFIG_USB_MSI2500 is not set
# CONFIG_MEDIA_PCI_SUPPORT is not set
# CONFIG_RADIO_ADAPTERS is not set
CONFIG_MEDIA_COMMON_OPTIONS=y

#
# common driver options
#
CONFIG_VIDEO_CX2341X=y
CONFIG_VIDEO_TVEEPROM=y
CONFIG_CYPRESS_FIRMWARE=y
CONFIG_VIDEOBUF2_CORE=y
CONFIG_VIDEOBUF2_V4L2=y
CONFIG_VIDEOBUF2_MEMOPS=y
CONFIG_VIDEOBUF2_DMA_CONTIG=y
CONFIG_VIDEOBUF2_VMALLOC=y
CONFIG_VIDEOBUF2_DMA_SG=y
CONFIG_DVB_B2C2_FLEXCOP=y
CONFIG_DVB_B2C2_FLEXCOP_DEBUG=y
CONFIG_SMS_SIANO_MDTV=y
# CONFIG_SMS_SIANO_RC is not set
CONFIG_V4L_PLATFORM_DRIVERS=y
# CONFIG_VIDEO_CAFE_CCIC is not set
# CONFIG_VIDEO_CADENCE is not set
CONFIG_VIDEO_ASPEED=y
# CONFIG_VIDEO_MUX is not set
# CONFIG_VIDEO_XILINX is not set
CONFIG_V4L_MEM2MEM_DRIVERS=y
CONFIG_VIDEO_MEM2MEM_DEINTERLACE=y
# CONFIG_DVB_PLATFORM_DRIVERS is not set
CONFIG_SDR_PLATFORM_DRIVERS=y
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
CONFIG_VIDEO_IR_I2C=y

#
# Audio decoders, processors and mixers
#
CONFIG_VIDEO_TVAUDIO=y
CONFIG_VIDEO_TDA7432=y
# CONFIG_VIDEO_TDA9840 is not set
# CONFIG_VIDEO_TEA6415C is not set
# CONFIG_VIDEO_TEA6420 is not set
CONFIG_VIDEO_MSP3400=y
# CONFIG_VIDEO_CS3308 is not set
CONFIG_VIDEO_CS5345=y
CONFIG_VIDEO_CS53L32A=y
# CONFIG_VIDEO_TLV320AIC23B is not set
CONFIG_VIDEO_UDA1342=y
CONFIG_VIDEO_WM8775=y
# CONFIG_VIDEO_WM8739 is not set
# CONFIG_VIDEO_VP27SMPX is not set
# CONFIG_VIDEO_SONY_BTF_MPX is not set
# end of Audio decoders, processors and mixers

#
# RDS decoders
#
CONFIG_VIDEO_SAA6588=y
# end of RDS decoders

#
# Video decoders
#
# CONFIG_VIDEO_ADV7180 is not set
# CONFIG_VIDEO_ADV7183 is not set
# CONFIG_VIDEO_ADV748X is not set
# CONFIG_VIDEO_ADV7604 is not set
CONFIG_VIDEO_ADV7842=y
CONFIG_VIDEO_ADV7842_CEC=y
# CONFIG_VIDEO_BT819 is not set
CONFIG_VIDEO_BT856=y
CONFIG_VIDEO_BT866=y
CONFIG_VIDEO_KS0127=y
CONFIG_VIDEO_ML86V7667=y
# CONFIG_VIDEO_SAA7110 is not set
CONFIG_VIDEO_SAA711X=y
CONFIG_VIDEO_TC358743=y
CONFIG_VIDEO_TC358743_CEC=y
CONFIG_VIDEO_TVP514X=y
CONFIG_VIDEO_TVP5150=y
CONFIG_VIDEO_TVP7002=y
CONFIG_VIDEO_TW2804=y
CONFIG_VIDEO_TW9903=y
CONFIG_VIDEO_TW9906=y
# CONFIG_VIDEO_TW9910 is not set
CONFIG_VIDEO_VPX3220=y
CONFIG_VIDEO_MAX9286=y

#
# Video and audio decoders
#
CONFIG_VIDEO_SAA717X=y
CONFIG_VIDEO_CX25840=y
# end of Video decoders

#
# Video encoders
#
CONFIG_VIDEO_SAA7127=y
CONFIG_VIDEO_SAA7185=y
# CONFIG_VIDEO_ADV7170 is not set
# CONFIG_VIDEO_ADV7175 is not set
CONFIG_VIDEO_ADV7343=y
CONFIG_VIDEO_ADV7393=y
CONFIG_VIDEO_AD9389B=y
CONFIG_VIDEO_AK881X=y
CONFIG_VIDEO_THS8200=y
# end of Video encoders

#
# Video improvement chips
#
CONFIG_VIDEO_UPD64031A=y
# CONFIG_VIDEO_UPD64083 is not set
# end of Video improvement chips

#
# Audio/Video compression chips
#
CONFIG_VIDEO_SAA6752HS=y
# end of Audio/Video compression chips

#
# SDR tuner chips
#
CONFIG_SDR_MAX2175=y
# end of SDR tuner chips

#
# Miscellaneous helper chips
#
# CONFIG_VIDEO_THS7303 is not set
# CONFIG_VIDEO_M52790 is not set
CONFIG_VIDEO_I2C=y
# CONFIG_VIDEO_ST_MIPID02 is not set
# end of Miscellaneous helper chips

#
# Camera sensor devices
#
CONFIG_VIDEO_APTINA_PLL=y
CONFIG_VIDEO_SMIAPP_PLL=y
CONFIG_VIDEO_HI556=y
# CONFIG_VIDEO_IMX214 is not set
CONFIG_VIDEO_IMX219=y
CONFIG_VIDEO_IMX258=y
CONFIG_VIDEO_IMX274=y
CONFIG_VIDEO_IMX290=y
# CONFIG_VIDEO_IMX319 is not set
CONFIG_VIDEO_IMX355=y
CONFIG_VIDEO_OV2640=y
CONFIG_VIDEO_OV2659=y
# CONFIG_VIDEO_OV2680 is not set
CONFIG_VIDEO_OV2685=y
CONFIG_VIDEO_OV2740=y
# CONFIG_VIDEO_OV5640 is not set
CONFIG_VIDEO_OV5645=y
CONFIG_VIDEO_OV5647=y
CONFIG_VIDEO_OV6650=y
CONFIG_VIDEO_OV5670=y
CONFIG_VIDEO_OV5675=y
# CONFIG_VIDEO_OV5695 is not set
# CONFIG_VIDEO_OV7251 is not set
CONFIG_VIDEO_OV772X=y
# CONFIG_VIDEO_OV7640 is not set
CONFIG_VIDEO_OV7670=y
# CONFIG_VIDEO_OV7740 is not set
CONFIG_VIDEO_OV8856=y
CONFIG_VIDEO_OV9640=y
# CONFIG_VIDEO_OV9650 is not set
CONFIG_VIDEO_OV13858=y
CONFIG_VIDEO_VS6624=y
CONFIG_VIDEO_MT9M001=y
CONFIG_VIDEO_MT9M032=y
CONFIG_VIDEO_MT9M111=y
# CONFIG_VIDEO_MT9P031 is not set
# CONFIG_VIDEO_MT9T001 is not set
CONFIG_VIDEO_MT9T112=y
CONFIG_VIDEO_MT9V011=y
CONFIG_VIDEO_MT9V032=y
# CONFIG_VIDEO_MT9V111 is not set
CONFIG_VIDEO_SR030PC30=y
CONFIG_VIDEO_NOON010PC30=y
CONFIG_VIDEO_M5MOLS=y
# CONFIG_VIDEO_RDACM20 is not set
# CONFIG_VIDEO_RJ54N1 is not set
# CONFIG_VIDEO_S5K6AA is not set
CONFIG_VIDEO_S5K6A3=y
# CONFIG_VIDEO_S5K4ECGX is not set
CONFIG_VIDEO_S5K5BAF=y
CONFIG_VIDEO_SMIAPP=y
CONFIG_VIDEO_ET8EK8=y
CONFIG_VIDEO_S5C73M3=y
# end of Camera sensor devices

#
# Lens drivers
#
# CONFIG_VIDEO_AD5820 is not set
CONFIG_VIDEO_AK7375=y
# CONFIG_VIDEO_DW9714 is not set
# CONFIG_VIDEO_DW9768 is not set
CONFIG_VIDEO_DW9807_VCM=y
# end of Lens drivers

#
# Flash devices
#
CONFIG_VIDEO_ADP1653=y
CONFIG_VIDEO_LM3560=y
# CONFIG_VIDEO_LM3646 is not set
# end of Flash devices

#
# SPI helper chips
#
CONFIG_VIDEO_GS1662=y
# end of SPI helper chips

#
# Media SPI Adapters
#
CONFIG_CXD2880_SPI_DRV=y
# end of Media SPI Adapters

CONFIG_MEDIA_TUNER=y

#
# Customize TV tuners
#
# CONFIG_MEDIA_TUNER_SIMPLE is not set
CONFIG_MEDIA_TUNER_TDA18250=y
# CONFIG_MEDIA_TUNER_TDA8290 is not set
# CONFIG_MEDIA_TUNER_TDA827X is not set
CONFIG_MEDIA_TUNER_TDA18271=y
CONFIG_MEDIA_TUNER_TDA9887=y
# CONFIG_MEDIA_TUNER_TEA5761 is not set
# CONFIG_MEDIA_TUNER_TEA5767 is not set
CONFIG_MEDIA_TUNER_MSI001=y
CONFIG_MEDIA_TUNER_MT20XX=y
# CONFIG_MEDIA_TUNER_MT2060 is not set
CONFIG_MEDIA_TUNER_MT2063=y
# CONFIG_MEDIA_TUNER_MT2266 is not set
CONFIG_MEDIA_TUNER_MT2131=y
CONFIG_MEDIA_TUNER_QT1010=y
CONFIG_MEDIA_TUNER_XC2028=y
CONFIG_MEDIA_TUNER_XC5000=y
CONFIG_MEDIA_TUNER_XC4000=y
# CONFIG_MEDIA_TUNER_MXL5005S is not set
# CONFIG_MEDIA_TUNER_MXL5007T is not set
# CONFIG_MEDIA_TUNER_MC44S803 is not set
CONFIG_MEDIA_TUNER_MAX2165=y
CONFIG_MEDIA_TUNER_TDA18218=y
CONFIG_MEDIA_TUNER_FC0011=y
# CONFIG_MEDIA_TUNER_FC0012 is not set
CONFIG_MEDIA_TUNER_FC0013=y
CONFIG_MEDIA_TUNER_TDA18212=y
CONFIG_MEDIA_TUNER_E4000=y
# CONFIG_MEDIA_TUNER_FC2580 is not set
# CONFIG_MEDIA_TUNER_M88RS6000T is not set
CONFIG_MEDIA_TUNER_TUA9001=y
CONFIG_MEDIA_TUNER_SI2157=y
CONFIG_MEDIA_TUNER_IT913X=y
CONFIG_MEDIA_TUNER_R820T=y
# CONFIG_MEDIA_TUNER_MXL301RF is not set
CONFIG_MEDIA_TUNER_QM1D1C0042=y
# CONFIG_MEDIA_TUNER_QM1D1B0004 is not set
# end of Customize TV tuners

#
# Customise DVB Frontends
#

#
# Multistandard (satellite) frontends
#
# CONFIG_DVB_STB0899 is not set
# CONFIG_DVB_STB6100 is not set
CONFIG_DVB_STV090x=y
CONFIG_DVB_STV0910=y
# CONFIG_DVB_STV6110x is not set
CONFIG_DVB_STV6111=y
# CONFIG_DVB_MXL5XX is not set
# CONFIG_DVB_M88DS3103 is not set

#
# Multistandard (cable + terrestrial) frontends
#
# CONFIG_DVB_DRXK is not set
# CONFIG_DVB_TDA18271C2DD is not set
CONFIG_DVB_SI2165=y
CONFIG_DVB_MN88472=y
CONFIG_DVB_MN88473=y

#
# DVB-S (satellite) frontends
#
# CONFIG_DVB_CX24110 is not set
CONFIG_DVB_CX24123=y
CONFIG_DVB_MT312=y
# CONFIG_DVB_ZL10036 is not set
# CONFIG_DVB_ZL10039 is not set
CONFIG_DVB_S5H1420=y
CONFIG_DVB_STV0288=y
CONFIG_DVB_STB6000=y
# CONFIG_DVB_STV0299 is not set
# CONFIG_DVB_STV6110 is not set
# CONFIG_DVB_STV0900 is not set
CONFIG_DVB_TDA8083=y
CONFIG_DVB_TDA10086=y
# CONFIG_DVB_TDA8261 is not set
CONFIG_DVB_VES1X93=y
CONFIG_DVB_TUNER_ITD1000=y
CONFIG_DVB_TUNER_CX24113=y
# CONFIG_DVB_TDA826X is not set
CONFIG_DVB_TUA6100=y
CONFIG_DVB_CX24116=y
CONFIG_DVB_CX24117=y
# CONFIG_DVB_CX24120 is not set
CONFIG_DVB_SI21XX=y
CONFIG_DVB_TS2020=y
CONFIG_DVB_DS3000=y
CONFIG_DVB_MB86A16=y
# CONFIG_DVB_TDA10071 is not set

#
# DVB-T (terrestrial) frontends
#
CONFIG_DVB_SP8870=y
CONFIG_DVB_SP887X=y
# CONFIG_DVB_CX22700 is not set
# CONFIG_DVB_CX22702 is not set
CONFIG_DVB_S5H1432=y
CONFIG_DVB_DRXD=y
CONFIG_DVB_L64781=y
CONFIG_DVB_TDA1004X=y
# CONFIG_DVB_NXT6000 is not set
# CONFIG_DVB_MT352 is not set
CONFIG_DVB_ZL10353=y
CONFIG_DVB_DIB3000MB=y
CONFIG_DVB_DIB3000MC=y
# CONFIG_DVB_DIB7000M is not set
# CONFIG_DVB_DIB7000P is not set
CONFIG_DVB_DIB9000=y
CONFIG_DVB_TDA10048=y
# CONFIG_DVB_AF9013 is not set
# CONFIG_DVB_EC100 is not set
CONFIG_DVB_STV0367=y
CONFIG_DVB_CXD2820R=y
CONFIG_DVB_CXD2841ER=y
# CONFIG_DVB_RTL2830 is not set
# CONFIG_DVB_RTL2832 is not set
# CONFIG_DVB_RTL2832_SDR is not set
CONFIG_DVB_SI2168=y
CONFIG_DVB_AS102_FE=y
CONFIG_DVB_ZD1301_DEMOD=y
CONFIG_DVB_CXD2880=y

#
# DVB-C (cable) frontends
#
CONFIG_DVB_VES1820=y
# CONFIG_DVB_TDA10021 is not set
CONFIG_DVB_TDA10023=y
CONFIG_DVB_STV0297=y

#
# ATSC (North American/Korean Terrestrial/Cable DTV) frontends
#
CONFIG_DVB_NXT200X=y
CONFIG_DVB_OR51211=y
CONFIG_DVB_OR51132=y
# CONFIG_DVB_BCM3510 is not set
# CONFIG_DVB_LGDT330X is not set
CONFIG_DVB_LGDT3305=y
CONFIG_DVB_LGDT3306A=y
# CONFIG_DVB_LG2160 is not set
CONFIG_DVB_S5H1409=y
CONFIG_DVB_AU8522=y
CONFIG_DVB_AU8522_DTV=y
# CONFIG_DVB_AU8522_V4L is not set
CONFIG_DVB_S5H1411=y

#
# ISDB-T (terrestrial) frontends
#
CONFIG_DVB_S921=y
CONFIG_DVB_DIB8000=y
CONFIG_DVB_MB86A20S=y

#
# ISDB-S (satellite) & ISDB-T (terrestrial) frontends
#
# CONFIG_DVB_TC90522 is not set
# CONFIG_DVB_MN88443X is not set

#
# Digital terrestrial only tuners/PLL
#
CONFIG_DVB_PLL=y
# CONFIG_DVB_TUNER_DIB0070 is not set
CONFIG_DVB_TUNER_DIB0090=y

#
# SEC control devices for DVB-S
#
CONFIG_DVB_DRX39XYJ=y
CONFIG_DVB_LNBH25=y
CONFIG_DVB_LNBH29=y
CONFIG_DVB_LNBP21=y
CONFIG_DVB_LNBP22=y
CONFIG_DVB_ISL6405=y
CONFIG_DVB_ISL6421=y
CONFIG_DVB_ISL6423=y
CONFIG_DVB_A8293=y
CONFIG_DVB_LGS8GL5=y
CONFIG_DVB_LGS8GXX=y
# CONFIG_DVB_ATBM8830 is not set
# CONFIG_DVB_TDA665x is not set
# CONFIG_DVB_IX2505V is not set
CONFIG_DVB_M88RS2000=y
CONFIG_DVB_AF9033=y
# CONFIG_DVB_HORUS3A is not set
CONFIG_DVB_ASCOT2E=y
# CONFIG_DVB_HELENE is not set

#
# Common Interface (EN50221) controller drivers
#
CONFIG_DVB_CXD2099=y
CONFIG_DVB_SP2=y
# end of Customise DVB Frontends

#
# Tools to develop new frontends
#
CONFIG_DVB_DUMMY_FE=y
# end of Media ancillary drivers

#
# Graphics support
#
# CONFIG_AGP is not set
CONFIG_VGA_ARB=y
CONFIG_VGA_ARB_MAX_GPUS=16
# CONFIG_VGA_SWITCHEROO is not set
CONFIG_DRM=y
CONFIG_DRM_MIPI_DBI=y
CONFIG_DRM_MIPI_DSI=y
CONFIG_DRM_DP_AUX_CHARDEV=y
# CONFIG_DRM_DEBUG_MM is not set
CONFIG_DRM_DEBUG_SELFTEST=y
CONFIG_DRM_KMS_HELPER=y
CONFIG_DRM_KMS_FB_HELPER=y
CONFIG_DRM_DEBUG_DP_MST_TOPOLOGY_REFS=y
# CONFIG_DRM_FBDEV_EMULATION is not set
# CONFIG_DRM_LOAD_EDID_FIRMWARE is not set
CONFIG_DRM_DP_CEC=y
CONFIG_DRM_GEM_CMA_HELPER=y
CONFIG_DRM_KMS_CMA_HELPER=y
CONFIG_DRM_GEM_SHMEM_HELPER=y
CONFIG_DRM_VM=y
CONFIG_DRM_SCHED=y

#
# I2C encoder or helper chips
#
CONFIG_DRM_I2C_CH7006=y
CONFIG_DRM_I2C_SIL164=y
# CONFIG_DRM_I2C_NXP_TDA998X is not set
CONFIG_DRM_I2C_NXP_TDA9950=y
# end of I2C encoder or helper chips

#
# ARM devices
#
# CONFIG_DRM_KOMEDA is not set
# end of ARM devices

# CONFIG_DRM_RADEON is not set
# CONFIG_DRM_AMDGPU is not set
# CONFIG_DRM_NOUVEAU is not set
# CONFIG_DRM_I915 is not set
CONFIG_DRM_VGEM=y
# CONFIG_DRM_VKMS is not set
# CONFIG_DRM_VMWGFX is not set
# CONFIG_DRM_GMA500 is not set
CONFIG_DRM_UDL=y
# CONFIG_DRM_AST is not set
# CONFIG_DRM_MGAG200 is not set
# CONFIG_DRM_RCAR_DW_HDMI is not set
# CONFIG_DRM_RCAR_LVDS is not set
# CONFIG_DRM_QXL is not set
# CONFIG_DRM_BOCHS is not set
# CONFIG_DRM_VIRTIO_GPU is not set
CONFIG_DRM_PANEL=y

#
# Display Panels
#
CONFIG_DRM_PANEL_ARM_VERSATILE=y
CONFIG_DRM_PANEL_ASUS_Z00T_TM5P5_NT35596=y
CONFIG_DRM_PANEL_BOE_HIMAX8279D=y
CONFIG_DRM_PANEL_BOE_TV101WUM_NL6=y
CONFIG_DRM_PANEL_LVDS=y
CONFIG_DRM_PANEL_SIMPLE=y
# CONFIG_DRM_PANEL_ELIDA_KD35T133 is not set
CONFIG_DRM_PANEL_FEIXIN_K101_IM2BA02=y
# CONFIG_DRM_PANEL_FEIYANG_FY07024DI26A30D is not set
CONFIG_DRM_PANEL_ILITEK_IL9322=y
CONFIG_DRM_PANEL_ILITEK_ILI9881C=y
# CONFIG_DRM_PANEL_INNOLUX_P079ZCA is not set
CONFIG_DRM_PANEL_JDI_LT070ME05000=y
CONFIG_DRM_PANEL_KINGDISPLAY_KD097D04=y
CONFIG_DRM_PANEL_LEADTEK_LTK050H3146W=y
CONFIG_DRM_PANEL_LEADTEK_LTK500HD1829=y
CONFIG_DRM_PANEL_SAMSUNG_LD9040=y
# CONFIG_DRM_PANEL_LG_LB035Q02 is not set
CONFIG_DRM_PANEL_LG_LG4573=y
CONFIG_DRM_PANEL_NEC_NL8048HL11=y
# CONFIG_DRM_PANEL_NOVATEK_NT35510 is not set
CONFIG_DRM_PANEL_NOVATEK_NT39016=y
CONFIG_DRM_PANEL_OLIMEX_LCD_OLINUXINO=y
# CONFIG_DRM_PANEL_ORISETECH_OTM8009A is not set
# CONFIG_DRM_PANEL_OSD_OSD101T2587_53TS is not set
# CONFIG_DRM_PANEL_PANASONIC_VVX10F034N00 is not set
CONFIG_DRM_PANEL_RASPBERRYPI_TOUCHSCREEN=y
CONFIG_DRM_PANEL_RAYDIUM_RM67191=y
CONFIG_DRM_PANEL_RAYDIUM_RM68200=y
CONFIG_DRM_PANEL_RONBO_RB070D30=y
CONFIG_DRM_PANEL_SAMSUNG_S6D16D0=y
CONFIG_DRM_PANEL_SAMSUNG_S6E3HA2=y
CONFIG_DRM_PANEL_SAMSUNG_S6E63J0X03=y
CONFIG_DRM_PANEL_SAMSUNG_S6E63M0=y
# CONFIG_DRM_PANEL_SAMSUNG_S6E88A0_AMS452EF01 is not set
CONFIG_DRM_PANEL_SAMSUNG_S6E8AA0=y
# CONFIG_DRM_PANEL_SEIKO_43WVF1G is not set
CONFIG_DRM_PANEL_SHARP_LQ101R1SX01=y
# CONFIG_DRM_PANEL_SHARP_LS037V7DW01 is not set
# CONFIG_DRM_PANEL_SHARP_LS043T1LE01 is not set
# CONFIG_DRM_PANEL_SITRONIX_ST7701 is not set
CONFIG_DRM_PANEL_SITRONIX_ST7703=y
CONFIG_DRM_PANEL_SITRONIX_ST7789V=y
CONFIG_DRM_PANEL_SONY_ACX424AKP=y
CONFIG_DRM_PANEL_SONY_ACX565AKM=y
CONFIG_DRM_PANEL_TPO_TD028TTEC1=y
CONFIG_DRM_PANEL_TPO_TD043MTEA1=y
CONFIG_DRM_PANEL_TPO_TPG110=y
CONFIG_DRM_PANEL_TRULY_NT35597_WQXGA=y
# CONFIG_DRM_PANEL_VISIONOX_RM69299 is not set
CONFIG_DRM_PANEL_XINPENG_XPP055C272=y
# end of Display Panels

CONFIG_DRM_BRIDGE=y
CONFIG_DRM_PANEL_BRIDGE=y

#
# Display Interface Bridges
#
# CONFIG_DRM_CDNS_DSI is not set
CONFIG_DRM_CHRONTEL_CH7033=y
CONFIG_DRM_DISPLAY_CONNECTOR=y
CONFIG_DRM_LVDS_CODEC=y
CONFIG_DRM_MEGACHIPS_STDPXXXX_GE_B850V3_FW=y
CONFIG_DRM_NWL_MIPI_DSI=y
CONFIG_DRM_NXP_PTN3460=y
CONFIG_DRM_PARADE_PS8622=y
CONFIG_DRM_PARADE_PS8640=y
# CONFIG_DRM_SIL_SII8620 is not set
CONFIG_DRM_SII902X=y
CONFIG_DRM_SII9234=y
CONFIG_DRM_SIMPLE_BRIDGE=y
# CONFIG_DRM_THINE_THC63LVD1024 is not set
# CONFIG_DRM_TOSHIBA_TC358764 is not set
CONFIG_DRM_TOSHIBA_TC358767=y
# CONFIG_DRM_TOSHIBA_TC358768 is not set
CONFIG_DRM_TI_TFP410=y
CONFIG_DRM_TI_SN65DSI86=y
CONFIG_DRM_TI_TPD12S015=y
CONFIG_DRM_ANALOGIX_ANX6345=y
# CONFIG_DRM_ANALOGIX_ANX78XX is not set
CONFIG_DRM_ANALOGIX_DP=y
CONFIG_DRM_I2C_ADV7511=y
CONFIG_DRM_I2C_ADV7511_CEC=y
# end of Display Interface Bridges

CONFIG_DRM_ETNAVIV=y
# CONFIG_DRM_ETNAVIV_THERMAL is not set
CONFIG_DRM_ARCPGU=y
CONFIG_DRM_MXS=y
CONFIG_DRM_MXSFB=y
# CONFIG_DRM_CIRRUS_QEMU is not set
CONFIG_DRM_GM12U320=y
CONFIG_TINYDRM_HX8357D=y
CONFIG_TINYDRM_ILI9225=y
# CONFIG_TINYDRM_ILI9341 is not set
CONFIG_TINYDRM_ILI9486=y
CONFIG_TINYDRM_MI0283QT=y
CONFIG_TINYDRM_REPAPER=y
# CONFIG_TINYDRM_ST7586 is not set
# CONFIG_TINYDRM_ST7735R is not set
# CONFIG_DRM_VBOXVIDEO is not set
CONFIG_DRM_LEGACY=y
# CONFIG_DRM_TDFX is not set
# CONFIG_DRM_R128 is not set
# CONFIG_DRM_MGA is not set
# CONFIG_DRM_VIA is not set
# CONFIG_DRM_SAVAGE is not set
CONFIG_DRM_EXPORT_FOR_TESTS=y
CONFIG_DRM_PANEL_ORIENTATION_QUIRKS=y
CONFIG_DRM_LIB_RANDOM=y

#
# Frame buffer Devices
#
CONFIG_FB_CMDLINE=y
CONFIG_FB_NOTIFY=y
CONFIG_FB=y
# CONFIG_FIRMWARE_EDID is not set
CONFIG_FB_CFB_FILLRECT=y
CONFIG_FB_CFB_COPYAREA=y
CONFIG_FB_CFB_IMAGEBLIT=y
CONFIG_FB_SYS_FILLRECT=y
CONFIG_FB_SYS_COPYAREA=y
CONFIG_FB_SYS_IMAGEBLIT=y
CONFIG_FB_FOREIGN_ENDIAN=y
# CONFIG_FB_BOTH_ENDIAN is not set
CONFIG_FB_BIG_ENDIAN=y
# CONFIG_FB_LITTLE_ENDIAN is not set
CONFIG_FB_SYS_FOPS=y
CONFIG_FB_DEFERRED_IO=y
CONFIG_FB_HECUBA=y
CONFIG_FB_BACKLIGHT=y
CONFIG_FB_MODE_HELPERS=y
CONFIG_FB_TILEBLITTING=y

#
# Frame buffer hardware drivers
#
# CONFIG_FB_CIRRUS is not set
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CYBER2000 is not set
CONFIG_FB_ARC=y
# CONFIG_FB_ASILIANT is not set
# CONFIG_FB_IMSTT is not set
# CONFIG_FB_VGA16 is not set
# CONFIG_FB_UVESA is not set
# CONFIG_FB_VESA is not set
# CONFIG_FB_EFI is not set
CONFIG_FB_N411=y
# CONFIG_FB_HGA is not set
CONFIG_FB_OPENCORES=y
CONFIG_FB_S1D13XXX=y
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
# CONFIG_FB_GEODE is not set
CONFIG_FB_SMSCUFX=y
CONFIG_FB_UDL=y
# CONFIG_FB_IBM_GXT4500 is not set
CONFIG_FB_GOLDFISH=y
CONFIG_FB_VIRTUAL=y
# CONFIG_FB_METRONOME is not set
# CONFIG_FB_MB862XX is not set
# CONFIG_FB_HYPERV is not set
# CONFIG_FB_SIMPLE is not set
CONFIG_FB_SSD1307=y
# CONFIG_FB_SM712 is not set
# end of Frame buffer Devices

#
# Backlight & LCD device support
#
CONFIG_LCD_CLASS_DEVICE=y
# CONFIG_LCD_L4F00242T03 is not set
CONFIG_LCD_LMS283GF05=y
CONFIG_LCD_LTV350QV=y
CONFIG_LCD_ILI922X=y
CONFIG_LCD_ILI9320=y
CONFIG_LCD_TDO24M=y
# CONFIG_LCD_VGG2432A4 is not set
CONFIG_LCD_PLATFORM=y
CONFIG_LCD_AMS369FG06=y
CONFIG_LCD_LMS501KF03=y
# CONFIG_LCD_HX8357 is not set
CONFIG_LCD_OTM3225A=y
CONFIG_BACKLIGHT_CLASS_DEVICE=y
CONFIG_BACKLIGHT_LM3533=y
# CONFIG_BACKLIGHT_PWM is not set
CONFIG_BACKLIGHT_DA9052=y
# CONFIG_BACKLIGHT_APPLE is not set
CONFIG_BACKLIGHT_QCOM_WLED=y
CONFIG_BACKLIGHT_SAHARA=y
# CONFIG_BACKLIGHT_ADP8860 is not set
CONFIG_BACKLIGHT_ADP8870=y
CONFIG_BACKLIGHT_PCF50633=y
# CONFIG_BACKLIGHT_LM3630A is not set
# CONFIG_BACKLIGHT_LM3639 is not set
# CONFIG_BACKLIGHT_LP855X is not set
CONFIG_BACKLIGHT_LP8788=y
CONFIG_BACKLIGHT_SKY81452=y
CONFIG_BACKLIGHT_TPS65217=y
CONFIG_BACKLIGHT_GPIO=y
# CONFIG_BACKLIGHT_LV5207LP is not set
CONFIG_BACKLIGHT_BD6107=y
CONFIG_BACKLIGHT_ARCXCNN=y
# CONFIG_BACKLIGHT_LED is not set
# end of Backlight & LCD device support

CONFIG_VIDEOMODE_HELPERS=y
CONFIG_HDMI=y
# CONFIG_LOGO is not set
# end of Graphics support

# CONFIG_SOUND is not set

#
# HID support
#
CONFIG_HID=y
CONFIG_HID_BATTERY_STRENGTH=y
CONFIG_HIDRAW=y
# CONFIG_UHID is not set
CONFIG_HID_GENERIC=y

#
# Special HID drivers
#
# CONFIG_HID_A4TECH is not set
CONFIG_HID_ACRUX=y
CONFIG_HID_ACRUX_FF=y
# CONFIG_HID_APPLE is not set
CONFIG_HID_AUREAL=y
CONFIG_HID_BELKIN=y
# CONFIG_HID_CHERRY is not set
CONFIG_HID_CHICONY=y
# CONFIG_HID_CORSAIR is not set
CONFIG_HID_COUGAR=y
CONFIG_HID_MACALLY=y
CONFIG_HID_CMEDIA=y
CONFIG_HID_CYPRESS=y
CONFIG_HID_DRAGONRISE=y
# CONFIG_DRAGONRISE_FF is not set
CONFIG_HID_EMS_FF=y
CONFIG_HID_ELECOM=y
CONFIG_HID_EZKEY=y
CONFIG_HID_GEMBIRD=y
CONFIG_HID_GFRM=y
# CONFIG_HID_GLORIOUS is not set
CONFIG_HID_KEYTOUCH=y
CONFIG_HID_KYE=y
CONFIG_HID_WALTOP=y
CONFIG_HID_VIEWSONIC=y
CONFIG_HID_GYRATION=y
CONFIG_HID_ICADE=y
CONFIG_HID_ITE=y
CONFIG_HID_JABRA=y
# CONFIG_HID_TWINHAN is not set
# CONFIG_HID_KENSINGTON is not set
# CONFIG_HID_LCPOWER is not set
# CONFIG_HID_LED is not set
CONFIG_HID_LENOVO=y
# CONFIG_HID_LOGITECH is not set
CONFIG_HID_MAGICMOUSE=y
CONFIG_HID_MALTRON=y
# CONFIG_HID_MAYFLASH is not set
# CONFIG_HID_REDRAGON is not set
CONFIG_HID_MICROSOFT=y
CONFIG_HID_MONTEREY=y
# CONFIG_HID_MULTITOUCH is not set
# CONFIG_HID_NTI is not set
CONFIG_HID_ORTEK=y
CONFIG_HID_PANTHERLORD=y
CONFIG_PANTHERLORD_FF=y
CONFIG_HID_PETALYNX=y
# CONFIG_HID_PICOLCD is not set
# CONFIG_HID_PLANTRONICS is not set
CONFIG_HID_PRIMAX=y
# CONFIG_HID_SAITEK is not set
# CONFIG_HID_SAMSUNG is not set
CONFIG_HID_SPEEDLINK=y
CONFIG_HID_STEAM=y
CONFIG_HID_STEELSERIES=y
# CONFIG_HID_SUNPLUS is not set
CONFIG_HID_RMI=y
# CONFIG_HID_GREENASIA is not set
# CONFIG_HID_HYPERV_MOUSE is not set
CONFIG_HID_SMARTJOYPLUS=y
# CONFIG_SMARTJOYPLUS_FF is not set
# CONFIG_HID_TIVO is not set
CONFIG_HID_TOPSEED=y
# CONFIG_HID_THINGM is not set
CONFIG_HID_THRUSTMASTER=y
# CONFIG_THRUSTMASTER_FF is not set
# CONFIG_HID_UDRAW_PS3 is not set
CONFIG_HID_WIIMOTE=y
CONFIG_HID_XINMO=y
CONFIG_HID_ZEROPLUS=y
CONFIG_ZEROPLUS_FF=y
# CONFIG_HID_ZYDACRON is not set
CONFIG_HID_SENSOR_HUB=y
CONFIG_HID_SENSOR_CUSTOM_SENSOR=y
# CONFIG_HID_ALPS is not set
# end of Special HID drivers

#
# USB HID support
#
# CONFIG_USB_HID is not set
# CONFIG_HID_PID is not set

#
# USB HID Boot Protocol drivers
#
CONFIG_USB_KBD=y
# CONFIG_USB_MOUSE is not set
# end of USB HID Boot Protocol drivers
# end of USB HID support

#
# I2C HID support
#
CONFIG_I2C_HID=y
# end of I2C HID support
# end of HID support

CONFIG_USB_OHCI_LITTLE_ENDIAN=y
CONFIG_USB_SUPPORT=y
CONFIG_USB_COMMON=y
CONFIG_USB_LED_TRIG=y
CONFIG_USB_ULPI_BUS=y
CONFIG_USB_CONN_GPIO=y
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB=y
CONFIG_USB_PCI=y
# CONFIG_USB_ANNOUNCE_NEW_DEVICES is not set

#
# Miscellaneous USB options
#
# CONFIG_USB_DEFAULT_PERSIST is not set
CONFIG_USB_DYNAMIC_MINORS=y
# CONFIG_USB_OTG is not set
CONFIG_USB_OTG_PRODUCTLIST=y
# CONFIG_USB_OTG_DISABLE_EXTERNAL_HUB is not set
CONFIG_USB_LEDS_TRIGGER_USBPORT=y
CONFIG_USB_AUTOSUSPEND_DELAY=2
# CONFIG_USB_MON is not set

#
# USB Host Controller Drivers
#
CONFIG_USB_C67X00_HCD=y
CONFIG_USB_XHCI_HCD=y
# CONFIG_USB_XHCI_DBGCAP is not set
CONFIG_USB_XHCI_PCI=y
CONFIG_USB_XHCI_PCI_RENESAS=y
CONFIG_USB_XHCI_PLATFORM=y
CONFIG_USB_EHCI_HCD=y
CONFIG_USB_EHCI_ROOT_HUB_TT=y
# CONFIG_USB_EHCI_TT_NEWSCHED is not set
CONFIG_USB_EHCI_PCI=y
CONFIG_USB_EHCI_FSL=y
CONFIG_USB_EHCI_HCD_PLATFORM=y
CONFIG_USB_OXU210HP_HCD=y
CONFIG_USB_ISP116X_HCD=y
# CONFIG_USB_FOTG210_HCD is not set
CONFIG_USB_MAX3421_HCD=y
CONFIG_USB_OHCI_HCD=y
CONFIG_USB_OHCI_HCD_PCI=y
CONFIG_USB_OHCI_HCD_SSB=y
CONFIG_USB_OHCI_HCD_PLATFORM=y
# CONFIG_USB_UHCI_HCD is not set
CONFIG_USB_U132_HCD=y
# CONFIG_USB_SL811_HCD is not set
# CONFIG_USB_R8A66597_HCD is not set
CONFIG_USB_HCD_SSB=y
CONFIG_USB_HCD_TEST_MODE=y

#
# USB Device Class drivers
#
# CONFIG_USB_ACM is not set
CONFIG_USB_PRINTER=y
# CONFIG_USB_WDM is not set
CONFIG_USB_TMC=y

#
# NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
#

#
# also be needed; see USB_STORAGE Help for more info
#

#
# USB Imaging devices
#
CONFIG_USB_MDC800=y
# CONFIG_USBIP_CORE is not set
CONFIG_USB_CDNS3=y
CONFIG_USB_CDNS3_HOST=y
CONFIG_USB_CDNS3_PCI_WRAP=y
CONFIG_USB_MUSB_HDRC=y
CONFIG_USB_MUSB_HOST=y

#
# Platform Glue Layer
#

#
# MUSB DMA mode
#
CONFIG_MUSB_PIO_ONLY=y
CONFIG_USB_DWC3=y
# CONFIG_USB_DWC3_ULPI is not set
CONFIG_USB_DWC3_HOST=y

#
# Platform Glue Driver Support
#
CONFIG_USB_DWC3_PCI=y
CONFIG_USB_DWC3_HAPS=y
# CONFIG_USB_DWC3_OF_SIMPLE is not set
# CONFIG_USB_DWC2 is not set
CONFIG_USB_CHIPIDEA=y
# CONFIG_USB_CHIPIDEA_HOST is not set
CONFIG_USB_CHIPIDEA_MSM=y
CONFIG_USB_CHIPIDEA_IMX=y
CONFIG_USB_CHIPIDEA_GENERIC=y
# CONFIG_USB_ISP1760 is not set

#
# USB port drivers
#
# CONFIG_USB_USS720 is not set
# CONFIG_USB_SERIAL is not set

#
# USB Miscellaneous drivers
#
CONFIG_USB_EMI62=y
# CONFIG_USB_EMI26 is not set
# CONFIG_USB_ADUTUX is not set
CONFIG_USB_SEVSEG=y
CONFIG_USB_LEGOTOWER=y
CONFIG_USB_LCD=y
CONFIG_USB_CYPRESS_CY7C63=y
CONFIG_USB_CYTHERM=y
# CONFIG_USB_IDMOUSE is not set
CONFIG_USB_FTDI_ELAN=y
CONFIG_USB_APPLEDISPLAY=y
# CONFIG_APPLE_MFI_FASTCHARGE is not set
CONFIG_USB_SISUSBVGA=y
CONFIG_USB_LD=y
# CONFIG_USB_TRANCEVIBRATOR is not set
CONFIG_USB_IOWARRIOR=y
# CONFIG_USB_TEST is not set
# CONFIG_USB_EHSET_TEST_FIXTURE is not set
# CONFIG_USB_ISIGHTFW is not set
CONFIG_USB_YUREX=y
CONFIG_USB_EZUSB_FX2=y
# CONFIG_USB_HUB_USB251XB is not set
CONFIG_USB_HSIC_USB3503=y
# CONFIG_USB_HSIC_USB4604 is not set
CONFIG_USB_LINK_LAYER_TEST=y
CONFIG_USB_CHAOSKEY=y
# CONFIG_USB_ATM is not set

#
# USB Physical Layer drivers
#
# CONFIG_NOP_USB_XCEIV is not set
# CONFIG_USB_GPIO_VBUS is not set
# CONFIG_USB_ISP1301 is not set
# end of USB Physical Layer drivers

# CONFIG_USB_GADGET is not set
# CONFIG_TYPEC is not set
CONFIG_USB_ROLE_SWITCH=y
CONFIG_USB_ROLES_INTEL_XHCI=y
# CONFIG_MMC is not set
# CONFIG_MEMSTICK is not set
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y
# CONFIG_LEDS_CLASS_FLASH is not set
# CONFIG_LEDS_CLASS_MULTICOLOR is not set
CONFIG_LEDS_BRIGHTNESS_HW_CHANGED=y

#
# LED drivers
#
CONFIG_LEDS_AN30259A=y
CONFIG_LEDS_APU=y
# CONFIG_LEDS_AW2013 is not set
# CONFIG_LEDS_BCM6328 is not set
CONFIG_LEDS_BCM6358=y
CONFIG_LEDS_CPCAP=y
# CONFIG_LEDS_CR0014114 is not set
CONFIG_LEDS_EL15203000=y
# CONFIG_LEDS_LM3530 is not set
# CONFIG_LEDS_LM3532 is not set
CONFIG_LEDS_LM3533=y
CONFIG_LEDS_LM3642=y
# CONFIG_LEDS_LM3692X is not set
CONFIG_LEDS_MT6323=y
CONFIG_LEDS_NET48XX=y
CONFIG_LEDS_WRAP=y
CONFIG_LEDS_PCA9532=y
# CONFIG_LEDS_PCA9532_GPIO is not set
# CONFIG_LEDS_GPIO is not set
# CONFIG_LEDS_LP3944 is not set
# CONFIG_LEDS_LP3952 is not set
CONFIG_LEDS_LP55XX_COMMON=y
CONFIG_LEDS_LP5521=y
CONFIG_LEDS_LP5523=y
CONFIG_LEDS_LP5562=y
CONFIG_LEDS_LP8501=y
CONFIG_LEDS_LP8788=y
CONFIG_LEDS_LP8860=y
CONFIG_LEDS_CLEVO_MAIL=y
# CONFIG_LEDS_PCA955X is not set
# CONFIG_LEDS_PCA963X is not set
CONFIG_LEDS_WM8350=y
# CONFIG_LEDS_DA9052 is not set
CONFIG_LEDS_DAC124S085=y
# CONFIG_LEDS_PWM is not set
# CONFIG_LEDS_REGULATOR is not set
CONFIG_LEDS_BD2802=y
# CONFIG_LEDS_INTEL_SS4200 is not set
# CONFIG_LEDS_LT3593 is not set
CONFIG_LEDS_MC13783=y
# CONFIG_LEDS_TCA6507 is not set
# CONFIG_LEDS_TLC591XX is not set
# CONFIG_LEDS_MAX77650 is not set
CONFIG_LEDS_LM355x=y
# CONFIG_LEDS_OT200 is not set
# CONFIG_LEDS_MENF21BMC is not set
CONFIG_LEDS_IS31FL319X=y
CONFIG_LEDS_IS31FL32XX=y

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
#
CONFIG_LEDS_BLINKM=y
# CONFIG_LEDS_SYSCON is not set
CONFIG_LEDS_MLXCPLD=y
# CONFIG_LEDS_MLXREG is not set
# CONFIG_LEDS_USER is not set
CONFIG_LEDS_NIC78BX=y
CONFIG_LEDS_SPI_BYTE=y
CONFIG_LEDS_TI_LMU_COMMON=y
CONFIG_LEDS_LM3697=y
# CONFIG_LEDS_TPS6105X is not set

#
# LED Triggers
#
CONFIG_LEDS_TRIGGERS=y
# CONFIG_LEDS_TRIGGER_TIMER is not set
CONFIG_LEDS_TRIGGER_ONESHOT=y
# CONFIG_LEDS_TRIGGER_MTD is not set
CONFIG_LEDS_TRIGGER_HEARTBEAT=y
# CONFIG_LEDS_TRIGGER_BACKLIGHT is not set
CONFIG_LEDS_TRIGGER_CPU=y
# CONFIG_LEDS_TRIGGER_ACTIVITY is not set
CONFIG_LEDS_TRIGGER_GPIO=y
CONFIG_LEDS_TRIGGER_DEFAULT_ON=y

#
# iptables trigger is under Netfilter config (LED target)
#
CONFIG_LEDS_TRIGGER_TRANSIENT=y
CONFIG_LEDS_TRIGGER_CAMERA=y
# CONFIG_LEDS_TRIGGER_PANIC is not set
CONFIG_LEDS_TRIGGER_NETDEV=y
CONFIG_LEDS_TRIGGER_PATTERN=y
CONFIG_LEDS_TRIGGER_AUDIO=y
# CONFIG_ACCESSIBILITY is not set
# CONFIG_INFINIBAND is not set
CONFIG_EDAC_ATOMIC_SCRUB=y
CONFIG_EDAC_SUPPORT=y
CONFIG_EDAC=y
CONFIG_EDAC_LEGACY_SYSFS=y
CONFIG_EDAC_DEBUG=y
# CONFIG_EDAC_AMD76X is not set
# CONFIG_EDAC_E7XXX is not set
# CONFIG_EDAC_E752X is not set
# CONFIG_EDAC_I82875P is not set
# CONFIG_EDAC_I82975X is not set
# CONFIG_EDAC_I3000 is not set
# CONFIG_EDAC_I3200 is not set
# CONFIG_EDAC_IE31200 is not set
# CONFIG_EDAC_X38 is not set
# CONFIG_EDAC_I5400 is not set
# CONFIG_EDAC_I82860 is not set
# CONFIG_EDAC_R82600 is not set
# CONFIG_EDAC_I5000 is not set
# CONFIG_EDAC_I5100 is not set
# CONFIG_EDAC_I7300 is not set
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
# CONFIG_RTC_INTF_SYSFS is not set
CONFIG_RTC_INTF_PROC=y
CONFIG_RTC_INTF_DEV=y
CONFIG_RTC_INTF_DEV_UIE_EMUL=y
# CONFIG_RTC_DRV_TEST is not set

#
# I2C RTC drivers
#
# CONFIG_RTC_DRV_88PM80X is not set
CONFIG_RTC_DRV_ABB5ZES3=y
CONFIG_RTC_DRV_ABEOZ9=y
CONFIG_RTC_DRV_ABX80X=y
# CONFIG_RTC_DRV_AS3722 is not set
CONFIG_RTC_DRV_DS1307=y
# CONFIG_RTC_DRV_DS1307_CENTURY is not set
# CONFIG_RTC_DRV_DS1374 is not set
# CONFIG_RTC_DRV_DS1672 is not set
CONFIG_RTC_DRV_HYM8563=y
# CONFIG_RTC_DRV_LP8788 is not set
CONFIG_RTC_DRV_MAX6900=y
# CONFIG_RTC_DRV_MAX8998 is not set
CONFIG_RTC_DRV_MAX77686=y
CONFIG_RTC_DRV_RK808=y
CONFIG_RTC_DRV_RS5C372=y
CONFIG_RTC_DRV_ISL1208=y
# CONFIG_RTC_DRV_ISL12022 is not set
# CONFIG_RTC_DRV_ISL12026 is not set
# CONFIG_RTC_DRV_X1205 is not set
CONFIG_RTC_DRV_PCF8523=y
CONFIG_RTC_DRV_PCF85063=y
CONFIG_RTC_DRV_PCF85363=y
CONFIG_RTC_DRV_PCF8563=y
# CONFIG_RTC_DRV_PCF8583 is not set
# CONFIG_RTC_DRV_M41T80 is not set
# CONFIG_RTC_DRV_BD70528 is not set
# CONFIG_RTC_DRV_BQ32K is not set
# CONFIG_RTC_DRV_TPS6586X is not set
CONFIG_RTC_DRV_TPS65910=y
# CONFIG_RTC_DRV_TPS80031 is not set
# CONFIG_RTC_DRV_RC5T619 is not set
# CONFIG_RTC_DRV_S35390A is not set
CONFIG_RTC_DRV_FM3130=y
CONFIG_RTC_DRV_RX8010=y
CONFIG_RTC_DRV_RX8581=y
CONFIG_RTC_DRV_RX8025=y
CONFIG_RTC_DRV_EM3027=y
CONFIG_RTC_DRV_RV3028=y
# CONFIG_RTC_DRV_RV8803 is not set
CONFIG_RTC_DRV_S5M=y
CONFIG_RTC_DRV_SD3078=y

#
# SPI RTC drivers
#
# CONFIG_RTC_DRV_M41T93 is not set
CONFIG_RTC_DRV_M41T94=y
CONFIG_RTC_DRV_DS1302=y
CONFIG_RTC_DRV_DS1305=y
CONFIG_RTC_DRV_DS1343=y
CONFIG_RTC_DRV_DS1347=y
CONFIG_RTC_DRV_DS1390=y
# CONFIG_RTC_DRV_MAX6916 is not set
CONFIG_RTC_DRV_R9701=y
CONFIG_RTC_DRV_RX4581=y
CONFIG_RTC_DRV_RX6110=y
CONFIG_RTC_DRV_RS5C348=y
# CONFIG_RTC_DRV_MAX6902 is not set
# CONFIG_RTC_DRV_PCF2123 is not set
# CONFIG_RTC_DRV_MCP795 is not set
CONFIG_RTC_I2C_AND_SPI=y

#
# SPI and I2C RTC drivers
#
CONFIG_RTC_DRV_DS3232=y
CONFIG_RTC_DRV_DS3232_HWMON=y
CONFIG_RTC_DRV_PCF2127=y
CONFIG_RTC_DRV_RV3029C2=y
# CONFIG_RTC_DRV_RV3029_HWMON is not set

#
# Platform RTC drivers
#
CONFIG_RTC_DRV_CMOS=y
CONFIG_RTC_DRV_DS1286=y
CONFIG_RTC_DRV_DS1511=y
CONFIG_RTC_DRV_DS1553=y
CONFIG_RTC_DRV_DS1685_FAMILY=y
# CONFIG_RTC_DRV_DS1685 is not set
# CONFIG_RTC_DRV_DS1689 is not set
# CONFIG_RTC_DRV_DS17285 is not set
CONFIG_RTC_DRV_DS17485=y
# CONFIG_RTC_DRV_DS17885 is not set
CONFIG_RTC_DRV_DS1742=y
# CONFIG_RTC_DRV_DS2404 is not set
# CONFIG_RTC_DRV_DA9052 is not set
# CONFIG_RTC_DRV_DA9063 is not set
CONFIG_RTC_DRV_STK17TA8=y
CONFIG_RTC_DRV_M48T86=y
CONFIG_RTC_DRV_M48T35=y
CONFIG_RTC_DRV_M48T59=y
# CONFIG_RTC_DRV_MSM6242 is not set
CONFIG_RTC_DRV_BQ4802=y
CONFIG_RTC_DRV_RP5C01=y
CONFIG_RTC_DRV_V3020=y
CONFIG_RTC_DRV_WM8350=y
CONFIG_RTC_DRV_PCF50633=y
# CONFIG_RTC_DRV_AB3100 is not set
CONFIG_RTC_DRV_ZYNQMP=y
# CONFIG_RTC_DRV_CROS_EC is not set

#
# on-CPU RTC drivers
#
CONFIG_RTC_DRV_CADENCE=y
CONFIG_RTC_DRV_FTRTC010=y
CONFIG_RTC_DRV_PCAP=y
# CONFIG_RTC_DRV_MC13XXX is not set
# CONFIG_RTC_DRV_MT6397 is not set
# CONFIG_RTC_DRV_R7301 is not set
CONFIG_RTC_DRV_CPCAP=y

#
# HID Sensor RTC drivers
#
# CONFIG_RTC_DRV_GOLDFISH is not set
CONFIG_RTC_DRV_WILCO_EC=y
CONFIG_DMADEVICES=y
CONFIG_DMADEVICES_DEBUG=y
# CONFIG_DMADEVICES_VDEBUG is not set

#
# DMA Devices
#
CONFIG_DMA_ENGINE=y
CONFIG_DMA_VIRTUAL_CHANNELS=y
CONFIG_DMA_ACPI=y
CONFIG_DMA_OF=y
CONFIG_ALTERA_MSGDMA=y
CONFIG_DW_AXI_DMAC=y
CONFIG_FSL_EDMA=y
# CONFIG_INTEL_IDMA64 is not set
# CONFIG_PCH_DMA is not set
# CONFIG_PLX_DMA is not set
# CONFIG_XILINX_ZYNQMP_DPDMA is not set
CONFIG_QCOM_HIDMA_MGMT=y
# CONFIG_QCOM_HIDMA is not set
CONFIG_DW_DMAC_CORE=y
CONFIG_DW_DMAC=y
# CONFIG_DW_DMAC_PCI is not set
CONFIG_HSU_DMA=y
# CONFIG_SF_PDMA is not set

#
# DMA Clients
#
CONFIG_ASYNC_TX_DMA=y
# CONFIG_DMATEST is not set

#
# DMABUF options
#
CONFIG_SYNC_FILE=y
# CONFIG_SW_SYNC is not set
# CONFIG_UDMABUF is not set
# CONFIG_DMABUF_MOVE_NOTIFY is not set
# CONFIG_DMABUF_SELFTESTS is not set
CONFIG_DMABUF_HEAPS=y
# CONFIG_DMABUF_HEAPS_SYSTEM is not set
# CONFIG_DMABUF_HEAPS_CMA is not set
# end of DMABUF options

CONFIG_AUXDISPLAY=y
CONFIG_HD44780=y
CONFIG_KS0108=y
CONFIG_KS0108_PORT=0x378
CONFIG_KS0108_DELAY=2
# CONFIG_CFAG12864B is not set
# CONFIG_IMG_ASCII_LCD is not set
# CONFIG_HT16K33 is not set
# CONFIG_PARPORT_PANEL is not set
CONFIG_PANEL_CHANGE_MESSAGE=y
CONFIG_PANEL_BOOT_MESSAGE=""
# CONFIG_CHARLCD_BL_OFF is not set
CONFIG_CHARLCD_BL_ON=y
# CONFIG_CHARLCD_BL_FLASH is not set
# CONFIG_PANEL is not set
CONFIG_CHARLCD=y
CONFIG_UIO=y
# CONFIG_UIO_CIF is not set
# CONFIG_UIO_PDRV_GENIRQ is not set
CONFIG_UIO_DMEM_GENIRQ=y
# CONFIG_UIO_AEC is not set
# CONFIG_UIO_SERCOS3 is not set
# CONFIG_UIO_PCI_GENERIC is not set
# CONFIG_UIO_NETX is not set
# CONFIG_UIO_PRUSS is not set
# CONFIG_UIO_MF624 is not set
CONFIG_UIO_HV_GENERIC=y
# CONFIG_VIRT_DRIVERS is not set
CONFIG_VIRTIO=y
# CONFIG_VIRTIO_MENU is not set
# CONFIG_VDPA is not set
CONFIG_VHOST_IOTLB=y
CONFIG_VHOST=y
CONFIG_VHOST_MENU=y
CONFIG_VHOST_NET=y
CONFIG_VHOST_VSOCK=y
# CONFIG_VHOST_CROSS_ENDIAN_LEGACY is not set

#
# Microsoft Hyper-V guest support
#
CONFIG_HYPERV=y
CONFIG_HYPERV_TIMER=y
CONFIG_HYPERV_UTILS=y
# CONFIG_HYPERV_BALLOON is not set
# end of Microsoft Hyper-V guest support

CONFIG_GREYBUS=y
CONFIG_GREYBUS_ES2=y
CONFIG_STAGING=y
# CONFIG_COMEDI is not set

#
# IIO staging drivers
#

#
# Accelerometers
#
# CONFIG_ADIS16203 is not set
CONFIG_ADIS16240=y
# end of Accelerometers

#
# Analog to digital converters
#
# CONFIG_AD7816 is not set
# CONFIG_AD7280 is not set
# end of Analog to digital converters

#
# Analog digital bi-direction converters
#
CONFIG_ADT7316=y
CONFIG_ADT7316_SPI=y
# CONFIG_ADT7316_I2C is not set
# end of Analog digital bi-direction converters

#
# Capacitance to digital converters
#
CONFIG_AD7150=y
CONFIG_AD7746=y
# end of Capacitance to digital converters

#
# Direct Digital Synthesis
#
# CONFIG_AD9832 is not set
CONFIG_AD9834=y
# end of Direct Digital Synthesis

#
# Network Analyzer, Impedance Converters
#
CONFIG_AD5933=y
# end of Network Analyzer, Impedance Converters

#
# Active energy metering IC
#
# CONFIG_ADE7854 is not set
# end of Active energy metering IC

#
# Resolver to digital converters
#
CONFIG_AD2S1210=y
# end of Resolver to digital converters
# end of IIO staging drivers

# CONFIG_FB_SM750 is not set
CONFIG_STAGING_MEDIA=y
# CONFIG_INTEL_ATOMISP is not set
# CONFIG_VIDEO_IPU3_IMGU is not set
CONFIG_VIDEO_USBVISION=y

#
# Android
#
# end of Android

CONFIG_STAGING_BOARD=y
# CONFIG_LTE_GDM724X is not set
# CONFIG_FIREWIRE_SERIAL is not set
CONFIG_GOLDFISH_AUDIO=y
# CONFIG_GS_FPGABOOT is not set
CONFIG_UNISYSSPAR=y
CONFIG_FB_TFT=y
# CONFIG_FB_TFT_AGM1264K_FL is not set
CONFIG_FB_TFT_BD663474=y
CONFIG_FB_TFT_HX8340BN=y
CONFIG_FB_TFT_HX8347D=y
CONFIG_FB_TFT_HX8353D=y
CONFIG_FB_TFT_HX8357D=y
CONFIG_FB_TFT_ILI9163=y
CONFIG_FB_TFT_ILI9320=y
CONFIG_FB_TFT_ILI9325=y
CONFIG_FB_TFT_ILI9340=y
CONFIG_FB_TFT_ILI9341=y
# CONFIG_FB_TFT_ILI9481 is not set
# CONFIG_FB_TFT_ILI9486 is not set
CONFIG_FB_TFT_PCD8544=y
CONFIG_FB_TFT_RA8875=y
CONFIG_FB_TFT_S6D02A1=y
# CONFIG_FB_TFT_S6D1121 is not set
# CONFIG_FB_TFT_SEPS525 is not set
CONFIG_FB_TFT_SH1106=y
CONFIG_FB_TFT_SSD1289=y
# CONFIG_FB_TFT_SSD1305 is not set
CONFIG_FB_TFT_SSD1306=y
# CONFIG_FB_TFT_SSD1331 is not set
CONFIG_FB_TFT_SSD1351=y
CONFIG_FB_TFT_ST7735R=y
CONFIG_FB_TFT_ST7789V=y
CONFIG_FB_TFT_TINYLCD=y
# CONFIG_FB_TFT_TLS8204 is not set
# CONFIG_FB_TFT_UC1611 is not set
CONFIG_FB_TFT_UC1701=y
CONFIG_FB_TFT_UPD161704=y
CONFIG_FB_TFT_WATTEROTT=y
CONFIG_MOST_COMPONENTS=y
# CONFIG_MOST_CDEV is not set
# CONFIG_MOST_NET is not set
# CONFIG_MOST_VIDEO is not set
# CONFIG_MOST_DIM2 is not set
CONFIG_MOST_I2C=y
CONFIG_GREYBUS_BOOTROM=y
CONFIG_GREYBUS_FIRMWARE=y
CONFIG_GREYBUS_HID=y
CONFIG_GREYBUS_LIGHT=y
CONFIG_GREYBUS_LOG=y
CONFIG_GREYBUS_LOOPBACK=y
# CONFIG_GREYBUS_POWER is not set
CONFIG_GREYBUS_RAW=y
CONFIG_GREYBUS_VIBRATOR=y
# CONFIG_GREYBUS_BRIDGED_PHY is not set
CONFIG_PI433=y

#
# Gasket devices
#
# end of Gasket devices

CONFIG_XIL_AXIS_FIFO=y
CONFIG_FIELDBUS_DEV=y
# CONFIG_HMS_ANYBUSS_BUS is not set
# CONFIG_KPC2000 is not set
# CONFIG_QLGE is not set
# CONFIG_X86_PLATFORM_DEVICES is not set
CONFIG_PMC_ATOM=y
CONFIG_GOLDFISH_PIPE=y
CONFIG_MFD_CROS_EC=y
CONFIG_CHROME_PLATFORMS=y
CONFIG_CHROMEOS_LAPTOP=y
CONFIG_CHROMEOS_PSTORE=y
# CONFIG_CHROMEOS_TBMC is not set
CONFIG_CROS_EC=y
CONFIG_CROS_EC_I2C=y
CONFIG_CROS_EC_RPMSG=y
CONFIG_CROS_EC_SPI=y
CONFIG_CROS_EC_LPC=y
CONFIG_CROS_EC_PROTO=y
# CONFIG_CROS_KBD_LED_BACKLIGHT is not set
CONFIG_CROS_EC_CHARDEV=y
CONFIG_CROS_EC_LIGHTBAR=y
CONFIG_CROS_EC_VBC=y
CONFIG_CROS_EC_DEBUGFS=y
# CONFIG_CROS_EC_SENSORHUB is not set
CONFIG_CROS_EC_SYSFS=y
# CONFIG_CROS_USBPD_LOGGER is not set
CONFIG_CROS_USBPD_NOTIFY=y
CONFIG_WILCO_EC=y
CONFIG_WILCO_EC_DEBUGFS=y
CONFIG_WILCO_EC_EVENTS=y
CONFIG_WILCO_EC_TELEMETRY=y
# CONFIG_MELLANOX_PLATFORM is not set
CONFIG_HAVE_CLK=y
CONFIG_CLKDEV_LOOKUP=y
CONFIG_HAVE_CLK_PREPARE=y
CONFIG_COMMON_CLK=y
# CONFIG_CLK_HSDK is not set
CONFIG_COMMON_CLK_MAX77686=y
CONFIG_COMMON_CLK_MAX9485=y
# CONFIG_COMMON_CLK_RK808 is not set
CONFIG_COMMON_CLK_SI5341=y
CONFIG_COMMON_CLK_SI5351=y
# CONFIG_COMMON_CLK_SI514 is not set
CONFIG_COMMON_CLK_SI544=y
CONFIG_COMMON_CLK_SI570=y
CONFIG_COMMON_CLK_CDCE706=y
# CONFIG_COMMON_CLK_CDCE925 is not set
CONFIG_COMMON_CLK_CS2000_CP=y
# CONFIG_COMMON_CLK_S2MPS11 is not set
CONFIG_CLK_TWL6040=y
# CONFIG_COMMON_CLK_LOCHNAGAR is not set
CONFIG_COMMON_CLK_PWM=y
CONFIG_COMMON_CLK_VC5=y
CONFIG_COMMON_CLK_BD718XX=y
# CONFIG_COMMON_CLK_FIXED_MMIO is not set
CONFIG_CLK_LGM_CGU=y
CONFIG_HWSPINLOCK=y

#
# Clock Source drivers
#
CONFIG_TIMER_OF=y
CONFIG_TIMER_PROBE=y
CONFIG_CLKSRC_I8253=y
CONFIG_CLKEVT_I8253=y
CONFIG_I8253_LOCK=y
CONFIG_CLKBLD_I8253=y
CONFIG_CLKSRC_MMIO=y
CONFIG_MICROCHIP_PIT64B=y
# end of Clock Source drivers

CONFIG_MAILBOX=y
CONFIG_PLATFORM_MHU=y
# CONFIG_PCC is not set
CONFIG_ALTERA_MBOX=y
# CONFIG_MAILBOX_TEST is not set
CONFIG_IOMMU_SUPPORT=y

#
# Generic IOMMU Pagetable Support
#
# end of Generic IOMMU Pagetable Support

CONFIG_IOMMU_DEBUGFS=y
# CONFIG_HYPERV_IOMMU is not set

#
# Remoteproc drivers
#
CONFIG_REMOTEPROC=y
# CONFIG_REMOTEPROC_CDEV is not set
# end of Remoteproc drivers

#
# Rpmsg drivers
#
CONFIG_RPMSG=y
CONFIG_RPMSG_CHAR=y
CONFIG_RPMSG_QCOM_GLINK=y
CONFIG_RPMSG_QCOM_GLINK_RPM=y
# CONFIG_RPMSG_VIRTIO is not set
# end of Rpmsg drivers

CONFIG_SOUNDWIRE=y

#
# SoundWire Devices
#

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

CONFIG_SOC_TI=y

#
# Xilinx SoC drivers
#
CONFIG_XILINX_VCU=y
# end of Xilinx SoC drivers
# end of SOC (System On Chip) specific Drivers

CONFIG_PM_DEVFREQ=y

#
# DEVFREQ Governors
#
CONFIG_DEVFREQ_GOV_SIMPLE_ONDEMAND=y
CONFIG_DEVFREQ_GOV_PERFORMANCE=y
CONFIG_DEVFREQ_GOV_POWERSAVE=y
CONFIG_DEVFREQ_GOV_USERSPACE=y
CONFIG_DEVFREQ_GOV_PASSIVE=y

#
# DEVFREQ Drivers
#
CONFIG_PM_DEVFREQ_EVENT=y
CONFIG_EXTCON=y

#
# Extcon Device Drivers
#
CONFIG_EXTCON_ADC_JACK=y
CONFIG_EXTCON_AXP288=y
# CONFIG_EXTCON_FSA9480 is not set
CONFIG_EXTCON_GPIO=y
CONFIG_EXTCON_INTEL_INT3496=y
# CONFIG_EXTCON_INTEL_CHT_WC is not set
# CONFIG_EXTCON_MAX14577 is not set
CONFIG_EXTCON_MAX3355=y
CONFIG_EXTCON_MAX77693=y
# CONFIG_EXTCON_MAX77843 is not set
CONFIG_EXTCON_PTN5150=y
CONFIG_EXTCON_RT8973A=y
CONFIG_EXTCON_SM5502=y
# CONFIG_EXTCON_USB_GPIO is not set
# CONFIG_EXTCON_USBC_CROS_EC is not set
CONFIG_MEMORY=y
CONFIG_IIO=y
CONFIG_IIO_BUFFER=y
CONFIG_IIO_BUFFER_CB=y
CONFIG_IIO_BUFFER_DMA=y
CONFIG_IIO_BUFFER_DMAENGINE=y
CONFIG_IIO_BUFFER_HW_CONSUMER=y
CONFIG_IIO_KFIFO_BUF=y
CONFIG_IIO_TRIGGERED_BUFFER=y
CONFIG_IIO_CONFIGFS=y
CONFIG_IIO_TRIGGER=y
CONFIG_IIO_CONSUMERS_PER_TRIGGER=2
CONFIG_IIO_SW_DEVICE=y
CONFIG_IIO_SW_TRIGGER=y
CONFIG_IIO_TRIGGERED_EVENT=y

#
# Accelerometers
#
# CONFIG_ADIS16201 is not set
# CONFIG_ADIS16209 is not set
CONFIG_ADXL345=y
CONFIG_ADXL345_I2C=y
CONFIG_ADXL345_SPI=y
CONFIG_ADXL372=y
CONFIG_ADXL372_SPI=y
CONFIG_ADXL372_I2C=y
CONFIG_BMA180=y
# CONFIG_BMA220 is not set
CONFIG_BMA400=y
CONFIG_BMA400_I2C=y
CONFIG_BMA400_SPI=y
CONFIG_BMC150_ACCEL=y
CONFIG_BMC150_ACCEL_I2C=y
CONFIG_BMC150_ACCEL_SPI=y
# CONFIG_DA280 is not set
CONFIG_DA311=y
CONFIG_DMARD06=y
CONFIG_DMARD09=y
CONFIG_DMARD10=y
# CONFIG_HID_SENSOR_ACCEL_3D is not set
CONFIG_KXSD9=y
# CONFIG_KXSD9_SPI is not set
CONFIG_KXSD9_I2C=y
# CONFIG_KXCJK1013 is not set
CONFIG_MC3230=y
CONFIG_MMA7455=y
# CONFIG_MMA7455_I2C is not set
CONFIG_MMA7455_SPI=y
# CONFIG_MMA7660 is not set
CONFIG_MMA8452=y
CONFIG_MMA9551_CORE=y
# CONFIG_MMA9551 is not set
CONFIG_MMA9553=y
# CONFIG_MXC4005 is not set
CONFIG_MXC6255=y
CONFIG_SCA3000=y
CONFIG_STK8312=y
CONFIG_STK8BA50=y
# end of Accelerometers

#
# Analog to digital converters
#
CONFIG_AD_SIGMA_DELTA=y
CONFIG_AD7091R5=y
CONFIG_AD7124=y
CONFIG_AD7192=y
CONFIG_AD7266=y
# CONFIG_AD7291 is not set
CONFIG_AD7292=y
# CONFIG_AD7298 is not set
CONFIG_AD7476=y
CONFIG_AD7606=y
CONFIG_AD7606_IFACE_PARALLEL=y
CONFIG_AD7606_IFACE_SPI=y
CONFIG_AD7766=y
CONFIG_AD7768_1=y
CONFIG_AD7780=y
# CONFIG_AD7791 is not set
CONFIG_AD7793=y
CONFIG_AD7887=y
CONFIG_AD7923=y
CONFIG_AD7949=y
CONFIG_AD799X=y
CONFIG_AD9467=y
CONFIG_ADI_AXI_ADC=y
CONFIG_AXP20X_ADC=y
CONFIG_AXP288_ADC=y
CONFIG_CC10001_ADC=y
CONFIG_CPCAP_ADC=y
CONFIG_ENVELOPE_DETECTOR=y
CONFIG_HI8435=y
CONFIG_HX711=y
CONFIG_INA2XX_ADC=y
CONFIG_LP8788_ADC=y
CONFIG_LTC2471=y
# CONFIG_LTC2485 is not set
CONFIG_LTC2496=y
# CONFIG_LTC2497 is not set
CONFIG_MAX1027=y
# CONFIG_MAX11100 is not set
# CONFIG_MAX1118 is not set
CONFIG_MAX1241=y
# CONFIG_MAX1363 is not set
# CONFIG_MAX9611 is not set
CONFIG_MCP320X=y
CONFIG_MCP3422=y
CONFIG_MCP3911=y
CONFIG_MEN_Z188_ADC=y
CONFIG_NAU7802=y
CONFIG_RN5T618_ADC=y
CONFIG_SD_ADC_MODULATOR=y
# CONFIG_STMPE_ADC is not set
CONFIG_STX104=y
CONFIG_TI_ADC081C=y
# CONFIG_TI_ADC0832 is not set
CONFIG_TI_ADC084S021=y
CONFIG_TI_ADC12138=y
# CONFIG_TI_ADC108S102 is not set
CONFIG_TI_ADC128S052=y
# CONFIG_TI_ADC161S626 is not set
CONFIG_TI_ADS1015=y
CONFIG_TI_ADS7950=y
# CONFIG_TI_ADS8344 is not set
CONFIG_TI_ADS8688=y
CONFIG_TI_ADS124S08=y
CONFIG_TI_TLC4541=y
CONFIG_VF610_ADC=y
CONFIG_XILINX_XADC=y
# end of Analog to digital converters

#
# Analog Front Ends
#
# CONFIG_IIO_RESCALE is not set
# end of Analog Front Ends

#
# Amplifiers
#
CONFIG_AD8366=y
CONFIG_HMC425=y
# end of Amplifiers

#
# Chemical Sensors
#
CONFIG_ATLAS_PH_SENSOR=y
# CONFIG_ATLAS_EZO_SENSOR is not set
CONFIG_BME680=y
CONFIG_BME680_I2C=y
CONFIG_BME680_SPI=y
CONFIG_CCS811=y
# CONFIG_IAQCORE is not set
CONFIG_PMS7003=y
CONFIG_SCD30_CORE=y
CONFIG_SCD30_I2C=y
CONFIG_SCD30_SERIAL=y
CONFIG_SENSIRION_SGP30=y
CONFIG_SPS30=y
# CONFIG_VZ89X is not set
# end of Chemical Sensors

#
# Hid Sensor IIO Common
#
CONFIG_HID_SENSOR_IIO_COMMON=y
CONFIG_HID_SENSOR_IIO_TRIGGER=y
# end of Hid Sensor IIO Common

CONFIG_IIO_MS_SENSORS_I2C=y

#
# SSP Sensor Common
#
# CONFIG_IIO_SSP_SENSORHUB is not set
# end of SSP Sensor Common

CONFIG_IIO_ST_SENSORS_I2C=y
CONFIG_IIO_ST_SENSORS_SPI=y
CONFIG_IIO_ST_SENSORS_CORE=y

#
# Digital to analog converters
#
# CONFIG_AD5064 is not set
CONFIG_AD5360=y
CONFIG_AD5380=y
CONFIG_AD5421=y
CONFIG_AD5446=y
# CONFIG_AD5449 is not set
CONFIG_AD5592R_BASE=y
# CONFIG_AD5592R is not set
CONFIG_AD5593R=y
# CONFIG_AD5504 is not set
# CONFIG_AD5624R_SPI is not set
CONFIG_AD5686=y
CONFIG_AD5686_SPI=y
CONFIG_AD5696_I2C=y
CONFIG_AD5755=y
CONFIG_AD5758=y
# CONFIG_AD5761 is not set
CONFIG_AD5764=y
CONFIG_AD5770R=y
# CONFIG_AD5791 is not set
CONFIG_AD7303=y
CONFIG_AD8801=y
CONFIG_CIO_DAC=y
CONFIG_DPOT_DAC=y
# CONFIG_DS4424 is not set
CONFIG_LTC1660=y
# CONFIG_LTC2632 is not set
# CONFIG_M62332 is not set
CONFIG_MAX517=y
CONFIG_MAX5821=y
CONFIG_MCP4725=y
CONFIG_MCP4922=y
CONFIG_TI_DAC082S085=y
CONFIG_TI_DAC5571=y
CONFIG_TI_DAC7311=y
CONFIG_TI_DAC7612=y
CONFIG_VF610_DAC=y
# end of Digital to analog converters

#
# IIO dummy driver
#
# CONFIG_IIO_SIMPLE_DUMMY is not set
# end of IIO dummy driver

#
# Frequency Synthesizers DDS/PLL
#

#
# Clock Generator/Distribution
#
CONFIG_AD9523=y
# end of Clock Generator/Distribution

#
# Phase-Locked Loop (PLL) frequency synthesizers
#
CONFIG_ADF4350=y
CONFIG_ADF4371=y
# end of Phase-Locked Loop (PLL) frequency synthesizers
# end of Frequency Synthesizers DDS/PLL

#
# Digital gyroscope sensors
#
CONFIG_ADIS16080=y
CONFIG_ADIS16130=y
CONFIG_ADIS16136=y
CONFIG_ADIS16260=y
CONFIG_ADXRS450=y
CONFIG_BMG160=y
CONFIG_BMG160_I2C=y
CONFIG_BMG160_SPI=y
# CONFIG_FXAS21002C is not set
# CONFIG_HID_SENSOR_GYRO_3D is not set
CONFIG_MPU3050=y
CONFIG_MPU3050_I2C=y
# CONFIG_IIO_ST_GYRO_3AXIS is not set
CONFIG_ITG3200=y
# end of Digital gyroscope sensors

#
# Health Sensors
#

#
# Heart Rate Monitors
#
# CONFIG_AFE4403 is not set
CONFIG_AFE4404=y
CONFIG_MAX30100=y
CONFIG_MAX30102=y
# end of Heart Rate Monitors
# end of Health Sensors

#
# Humidity sensors
#
CONFIG_AM2315=y
# CONFIG_DHT11 is not set
# CONFIG_HDC100X is not set
CONFIG_HID_SENSOR_HUMIDITY=y
CONFIG_HTS221=y
CONFIG_HTS221_I2C=y
CONFIG_HTS221_SPI=y
CONFIG_HTU21=y
CONFIG_SI7005=y
CONFIG_SI7020=y
# end of Humidity sensors

#
# Inertial measurement units
#
CONFIG_ADIS16400=y
CONFIG_ADIS16460=y
CONFIG_ADIS16475=y
CONFIG_ADIS16480=y
CONFIG_BMI160=y
CONFIG_BMI160_I2C=y
CONFIG_BMI160_SPI=y
CONFIG_FXOS8700=y
CONFIG_FXOS8700_I2C=y
# CONFIG_FXOS8700_SPI is not set
# CONFIG_KMX61 is not set
CONFIG_INV_ICM42600=y
CONFIG_INV_ICM42600_I2C=y
CONFIG_INV_ICM42600_SPI=y
CONFIG_INV_MPU6050_IIO=y
CONFIG_INV_MPU6050_I2C=y
# CONFIG_INV_MPU6050_SPI is not set
CONFIG_IIO_ST_LSM6DSX=y
CONFIG_IIO_ST_LSM6DSX_I2C=y
CONFIG_IIO_ST_LSM6DSX_SPI=y
CONFIG_IIO_ST_LSM6DSX_I3C=y
# end of Inertial measurement units

CONFIG_IIO_ADIS_LIB=y
CONFIG_IIO_ADIS_LIB_BUFFER=y

#
# Light sensors
#
CONFIG_ACPI_ALS=y
CONFIG_ADJD_S311=y
CONFIG_ADUX1020=y
CONFIG_AL3010=y
CONFIG_AL3320A=y
CONFIG_APDS9300=y
CONFIG_APDS9960=y
CONFIG_BH1750=y
CONFIG_BH1780=y
# CONFIG_CM32181 is not set
CONFIG_CM3232=y
CONFIG_CM3323=y
# CONFIG_CM3605 is not set
# CONFIG_CM36651 is not set
# CONFIG_GP2AP002 is not set
CONFIG_GP2AP020A00F=y
CONFIG_IQS621_ALS=y
# CONFIG_SENSORS_ISL29018 is not set
CONFIG_SENSORS_ISL29028=y
CONFIG_ISL29125=y
CONFIG_HID_SENSOR_ALS=y
# CONFIG_HID_SENSOR_PROX is not set
CONFIG_JSA1212=y
# CONFIG_RPR0521 is not set
# CONFIG_SENSORS_LM3533 is not set
CONFIG_LTR501=y
CONFIG_LV0104CS=y
CONFIG_MAX44000=y
CONFIG_MAX44009=y
# CONFIG_NOA1305 is not set
CONFIG_OPT3001=y
CONFIG_PA12203001=y
# CONFIG_SI1133 is not set
CONFIG_SI1145=y
CONFIG_STK3310=y
CONFIG_ST_UVIS25=y
CONFIG_ST_UVIS25_I2C=y
CONFIG_ST_UVIS25_SPI=y
CONFIG_TCS3414=y
CONFIG_TCS3472=y
CONFIG_SENSORS_TSL2563=y
CONFIG_TSL2583=y
CONFIG_TSL2772=y
# CONFIG_TSL4531 is not set
CONFIG_US5182D=y
CONFIG_VCNL4000=y
CONFIG_VCNL4035=y
# CONFIG_VEML6030 is not set
# CONFIG_VEML6070 is not set
CONFIG_VL6180=y
CONFIG_ZOPT2201=y
# end of Light sensors

#
# Magnetometer sensors
#
CONFIG_AK8974=y
CONFIG_AK8975=y
# CONFIG_AK09911 is not set
CONFIG_BMC150_MAGN=y
CONFIG_BMC150_MAGN_I2C=y
# CONFIG_BMC150_MAGN_SPI is not set
CONFIG_MAG3110=y
CONFIG_HID_SENSOR_MAGNETOMETER_3D=y
# CONFIG_MMC35240 is not set
CONFIG_IIO_ST_MAGN_3AXIS=y
CONFIG_IIO_ST_MAGN_I2C_3AXIS=y
CONFIG_IIO_ST_MAGN_SPI_3AXIS=y
CONFIG_SENSORS_HMC5843=y
# CONFIG_SENSORS_HMC5843_I2C is not set
CONFIG_SENSORS_HMC5843_SPI=y
# CONFIG_SENSORS_RM3100_I2C is not set
# CONFIG_SENSORS_RM3100_SPI is not set
# end of Magnetometer sensors

#
# Multiplexers
#
CONFIG_IIO_MUX=y
# end of Multiplexers

#
# Inclinometer sensors
#
CONFIG_HID_SENSOR_INCLINOMETER_3D=y
CONFIG_HID_SENSOR_DEVICE_ROTATION=y
# end of Inclinometer sensors

#
# Triggers - standalone
#
CONFIG_IIO_HRTIMER_TRIGGER=y
# CONFIG_IIO_INTERRUPT_TRIGGER is not set
CONFIG_IIO_TIGHTLOOP_TRIGGER=y
CONFIG_IIO_SYSFS_TRIGGER=y
# end of Triggers - standalone

#
# Linear and angular position sensors
#
CONFIG_IQS624_POS=y
# end of Linear and angular position sensors

#
# Digital potentiometers
#
CONFIG_AD5272=y
CONFIG_DS1803=y
# CONFIG_MAX5432 is not set
CONFIG_MAX5481=y
# CONFIG_MAX5487 is not set
CONFIG_MCP4018=y
CONFIG_MCP4131=y
CONFIG_MCP4531=y
CONFIG_MCP41010=y
CONFIG_TPL0102=y
# end of Digital potentiometers

#
# Digital potentiostats
#
# CONFIG_LMP91000 is not set
# end of Digital potentiostats

#
# Pressure sensors
#
CONFIG_ABP060MG=y
CONFIG_BMP280=y
CONFIG_BMP280_I2C=y
CONFIG_BMP280_SPI=y
# CONFIG_DLHL60D is not set
# CONFIG_DPS310 is not set
CONFIG_HID_SENSOR_PRESS=y
# CONFIG_HP03 is not set
CONFIG_ICP10100=y
CONFIG_MPL115=y
CONFIG_MPL115_I2C=y
CONFIG_MPL115_SPI=y
# CONFIG_MPL3115 is not set
# CONFIG_MS5611 is not set
CONFIG_MS5637=y
CONFIG_IIO_ST_PRESS=y
CONFIG_IIO_ST_PRESS_I2C=y
CONFIG_IIO_ST_PRESS_SPI=y
# CONFIG_T5403 is not set
# CONFIG_HP206C is not set
CONFIG_ZPA2326=y
CONFIG_ZPA2326_I2C=y
CONFIG_ZPA2326_SPI=y
# end of Pressure sensors

#
# Lightning sensors
#
CONFIG_AS3935=y
# end of Lightning sensors

#
# Proximity and distance sensors
#
# CONFIG_ISL29501 is not set
# CONFIG_LIDAR_LITE_V2 is not set
CONFIG_MB1232=y
CONFIG_PING=y
# CONFIG_RFD77402 is not set
CONFIG_SRF04=y
# CONFIG_SX9310 is not set
# CONFIG_SX9500 is not set
CONFIG_SRF08=y
CONFIG_VCNL3020=y
CONFIG_VL53L0X_I2C=y
# end of Proximity and distance sensors

#
# Resolver to digital converters
#
CONFIG_AD2S90=y
CONFIG_AD2S1200=y
# end of Resolver to digital converters

#
# Temperature sensors
#
CONFIG_IQS620AT_TEMP=y
CONFIG_LTC2983=y
CONFIG_MAXIM_THERMOCOUPLE=y
CONFIG_HID_SENSOR_TEMP=y
CONFIG_MLX90614=y
CONFIG_MLX90632=y
CONFIG_TMP006=y
# CONFIG_TMP007 is not set
# CONFIG_TSYS01 is not set
# CONFIG_TSYS02D is not set
CONFIG_MAX31856=y
# end of Temperature sensors

# CONFIG_NTB is not set
# CONFIG_VME_BUS is not set
CONFIG_PWM=y
CONFIG_PWM_SYSFS=y
# CONFIG_PWM_DEBUG is not set
CONFIG_PWM_ATMEL_HLCDC_PWM=y
CONFIG_PWM_CROS_EC=y
CONFIG_PWM_FSL_FTM=y
# CONFIG_PWM_IQS620A is not set
# CONFIG_PWM_LP3943 is not set
# CONFIG_PWM_LPSS_PCI is not set
# CONFIG_PWM_LPSS_PLATFORM is not set
# CONFIG_PWM_PCA9685 is not set
# CONFIG_PWM_STMPE is not set

#
# IRQ chip support
#
CONFIG_IRQCHIP=y
# CONFIG_AL_FIC is not set
# end of IRQ chip support

# CONFIG_IPACK_BUS is not set
CONFIG_RESET_CONTROLLER=y
CONFIG_RESET_BRCMSTB_RESCAL=y
CONFIG_RESET_INTEL_GW=y
# CONFIG_RESET_TI_SYSCON is not set

#
# PHY Subsystem
#
CONFIG_GENERIC_PHY=y
CONFIG_GENERIC_PHY_MIPI_DPHY=y
CONFIG_BCM_KONA_USB2_PHY=y
# CONFIG_PHY_CADENCE_TORRENT is not set
CONFIG_PHY_CADENCE_DPHY=y
CONFIG_PHY_CADENCE_SIERRA=y
# CONFIG_PHY_CADENCE_SALVO is not set
# CONFIG_PHY_FSL_IMX8MQ_USB is not set
# CONFIG_PHY_MIXEL_MIPI_DPHY is not set
CONFIG_PHY_PXA_28NM_HSIC=y
CONFIG_PHY_PXA_28NM_USB2=y
# CONFIG_PHY_CPCAP_USB is not set
CONFIG_PHY_MAPPHONE_MDM6600=y
CONFIG_PHY_OCELOT_SERDES=y
# CONFIG_PHY_QCOM_USB_HS is not set
# CONFIG_PHY_QCOM_USB_HSIC is not set
CONFIG_PHY_TUSB1210=y
# CONFIG_PHY_INTEL_COMBO is not set
# CONFIG_PHY_INTEL_EMMC is not set
# end of PHY Subsystem

# CONFIG_POWERCAP is not set
CONFIG_MCB=y
# CONFIG_MCB_PCI is not set
CONFIG_MCB_LPC=y

#
# Performance monitor support
#
# end of Performance monitor support

CONFIG_RAS=y
# CONFIG_USB4 is not set

#
# Android
#
# CONFIG_ANDROID is not set
# end of Android

CONFIG_DAX=y
# CONFIG_DEV_DAX is not set
CONFIG_NVMEM=y
CONFIG_NVMEM_SYSFS=y

#
# HW tracing support
#
CONFIG_STM=y
# CONFIG_STM_PROTO_BASIC is not set
CONFIG_STM_PROTO_SYS_T=y
CONFIG_STM_DUMMY=y
# CONFIG_STM_SOURCE_CONSOLE is not set
CONFIG_STM_SOURCE_HEARTBEAT=y
CONFIG_STM_SOURCE_FTRACE=y
# CONFIG_INTEL_TH is not set
# end of HW tracing support

CONFIG_FPGA=y
CONFIG_ALTERA_PR_IP_CORE=y
CONFIG_ALTERA_PR_IP_CORE_PLAT=y
CONFIG_FPGA_MGR_ALTERA_PS_SPI=y
# CONFIG_FPGA_MGR_ALTERA_CVP is not set
# CONFIG_FPGA_MGR_XILINX_SPI is not set
# CONFIG_FPGA_MGR_ICE40_SPI is not set
# CONFIG_FPGA_MGR_MACHXO2_SPI is not set
# CONFIG_FPGA_BRIDGE is not set
# CONFIG_FPGA_DFL is not set
# CONFIG_FSI is not set
# CONFIG_TEE is not set
CONFIG_MULTIPLEXER=y

#
# Multiplexer drivers
#
CONFIG_MUX_ADG792A=y
# CONFIG_MUX_ADGS1408 is not set
CONFIG_MUX_GPIO=y
CONFIG_MUX_MMIO=y
# end of Multiplexer drivers

CONFIG_PM_OPP=y
CONFIG_SIOX=y
# CONFIG_SIOX_BUS_GPIO is not set
CONFIG_SLIMBUS=y
# CONFIG_SLIM_QCOM_CTRL is not set
# CONFIG_INTERCONNECT is not set
CONFIG_COUNTER=y
CONFIG_104_QUAD_8=y
CONFIG_FTM_QUADDEC=y
CONFIG_MICROCHIP_TCB_CAPTURE=y
CONFIG_MOST=y
# CONFIG_MOST_USB_HDM is not set
# end of Device Drivers

#
# File systems
#
CONFIG_DCACHE_WORD_ACCESS=y
# CONFIG_VALIDATE_FS_PARSER is not set
CONFIG_FS_POSIX_ACL=y
CONFIG_EXPORTFS=y
CONFIG_EXPORTFS_BLOCK_OPS=y
CONFIG_FILE_LOCKING=y
CONFIG_MANDATORY_FILE_LOCKING=y
CONFIG_FS_ENCRYPTION=y
# CONFIG_FS_VERITY is not set
CONFIG_FSNOTIFY=y
CONFIG_DNOTIFY=y
CONFIG_INOTIFY_USER=y
# CONFIG_FANOTIFY is not set
CONFIG_QUOTA=y
CONFIG_QUOTA_NETLINK_INTERFACE=y
# CONFIG_PRINT_QUOTA_WARNING is not set
CONFIG_QUOTA_DEBUG=y
CONFIG_QFMT_V1=y
# CONFIG_QFMT_V2 is not set
CONFIG_QUOTACTL=y
# CONFIG_AUTOFS4_FS is not set
CONFIG_AUTOFS_FS=y
CONFIG_FUSE_FS=y
CONFIG_CUSE=y
# CONFIG_VIRTIO_FS is not set
CONFIG_OVERLAY_FS=y
CONFIG_OVERLAY_FS_REDIRECT_DIR=y
# CONFIG_OVERLAY_FS_REDIRECT_ALWAYS_FOLLOW is not set
CONFIG_OVERLAY_FS_INDEX=y
CONFIG_OVERLAY_FS_METACOPY=y

#
# Caches
#
# CONFIG_FSCACHE is not set
# end of Caches

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
# CONFIG_PROC_KCORE is not set
CONFIG_PROC_SYSCTL=y
CONFIG_PROC_PAGE_MONITOR=y
CONFIG_PROC_CHILDREN=y
CONFIG_PROC_PID_ARCH_STATUS=y
CONFIG_KERNFS=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
CONFIG_TMPFS_POSIX_ACL=y
CONFIG_TMPFS_XATTR=y
# CONFIG_HUGETLBFS is not set
CONFIG_MEMFD_CREATE=y
CONFIG_CONFIGFS_FS=y
# CONFIG_EFIVAR_FS is not set
# end of Pseudo filesystems

CONFIG_MISC_FILESYSTEMS=y
CONFIG_ORANGEFS_FS=y
CONFIG_ECRYPT_FS=y
CONFIG_ECRYPT_FS_MESSAGING=y
# CONFIG_JFFS2_FS is not set
CONFIG_CRAMFS=y
# CONFIG_CRAMFS_MTD is not set
# CONFIG_ROMFS_FS is not set
CONFIG_PSTORE=y
# CONFIG_PSTORE_DEFLATE_COMPRESS is not set
CONFIG_PSTORE_LZO_COMPRESS=y
# CONFIG_PSTORE_LZ4_COMPRESS is not set
CONFIG_PSTORE_LZ4HC_COMPRESS=y
# CONFIG_PSTORE_842_COMPRESS is not set
# CONFIG_PSTORE_ZSTD_COMPRESS is not set
CONFIG_PSTORE_COMPRESS=y
CONFIG_PSTORE_LZO_COMPRESS_DEFAULT=y
# CONFIG_PSTORE_LZ4HC_COMPRESS_DEFAULT is not set
CONFIG_PSTORE_COMPRESS_DEFAULT="lzo"
CONFIG_PSTORE_CONSOLE=y
# CONFIG_PSTORE_PMSG is not set
# CONFIG_PSTORE_FTRACE is not set
# CONFIG_PSTORE_RAM is not set
# CONFIG_NETWORK_FILESYSTEMS is not set
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=y
CONFIG_NLS_CODEPAGE_737=y
CONFIG_NLS_CODEPAGE_775=y
CONFIG_NLS_CODEPAGE_850=y
CONFIG_NLS_CODEPAGE_852=y
# CONFIG_NLS_CODEPAGE_855 is not set
# CONFIG_NLS_CODEPAGE_857 is not set
CONFIG_NLS_CODEPAGE_860=y
CONFIG_NLS_CODEPAGE_861=y
# CONFIG_NLS_CODEPAGE_862 is not set
# CONFIG_NLS_CODEPAGE_863 is not set
CONFIG_NLS_CODEPAGE_864=y
CONFIG_NLS_CODEPAGE_865=y
# CONFIG_NLS_CODEPAGE_866 is not set
# CONFIG_NLS_CODEPAGE_869 is not set
CONFIG_NLS_CODEPAGE_936=y
# CONFIG_NLS_CODEPAGE_950 is not set
CONFIG_NLS_CODEPAGE_932=y
# CONFIG_NLS_CODEPAGE_949 is not set
# CONFIG_NLS_CODEPAGE_874 is not set
CONFIG_NLS_ISO8859_8=y
# CONFIG_NLS_CODEPAGE_1250 is not set
CONFIG_NLS_CODEPAGE_1251=y
CONFIG_NLS_ASCII=y
CONFIG_NLS_ISO8859_1=y
CONFIG_NLS_ISO8859_2=y
# CONFIG_NLS_ISO8859_3 is not set
# CONFIG_NLS_ISO8859_4 is not set
CONFIG_NLS_ISO8859_5=y
CONFIG_NLS_ISO8859_6=y
# CONFIG_NLS_ISO8859_7 is not set
# CONFIG_NLS_ISO8859_9 is not set
CONFIG_NLS_ISO8859_13=y
CONFIG_NLS_ISO8859_14=y
CONFIG_NLS_ISO8859_15=y
# CONFIG_NLS_KOI8_R is not set
CONFIG_NLS_KOI8_U=y
CONFIG_NLS_MAC_ROMAN=y
CONFIG_NLS_MAC_CELTIC=y
CONFIG_NLS_MAC_CENTEURO=y
CONFIG_NLS_MAC_CROATIAN=y
CONFIG_NLS_MAC_CYRILLIC=y
CONFIG_NLS_MAC_GAELIC=y
# CONFIG_NLS_MAC_GREEK is not set
# CONFIG_NLS_MAC_ICELAND is not set
# CONFIG_NLS_MAC_INUIT is not set
CONFIG_NLS_MAC_ROMANIAN=y
# CONFIG_NLS_MAC_TURKISH is not set
CONFIG_NLS_UTF8=y
# CONFIG_DLM is not set
CONFIG_UNICODE=y
CONFIG_UNICODE_NORMALIZATION_SELFTEST=y
CONFIG_IO_WQ=y
# end of File systems

#
# Security options
#
CONFIG_KEYS=y
CONFIG_KEYS_REQUEST_CACHE=y
CONFIG_PERSISTENT_KEYRINGS=y
CONFIG_BIG_KEYS=y
# CONFIG_TRUSTED_KEYS is not set
# CONFIG_ENCRYPTED_KEYS is not set
CONFIG_KEY_DH_OPERATIONS=y
# CONFIG_KEY_NOTIFICATIONS is not set
# CONFIG_SECURITY_DMESG_RESTRICT is not set
# CONFIG_SECURITY is not set
CONFIG_SECURITYFS=y
# CONFIG_PAGE_TABLE_ISOLATION is not set
CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
# CONFIG_HARDENED_USERCOPY is not set
CONFIG_FORTIFY_SOURCE=y
# CONFIG_STATIC_USERMODEHELPER is not set
# CONFIG_IMA_SECURE_AND_OR_TRUSTED_BOOT is not set
CONFIG_DEFAULT_SECURITY_DAC=y
CONFIG_LSM="lockdown,yama,loadpin,safesetid,integrity,bpf"

#
# Kernel hardening options
#

#
# Memory initialization
#
CONFIG_INIT_STACK_NONE=y
CONFIG_INIT_ON_ALLOC_DEFAULT_ON=y
CONFIG_INIT_ON_FREE_DEFAULT_ON=y
# end of Memory initialization
# end of Kernel hardening options
# end of Security options

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
CONFIG_CRYPTO_KPP=y
CONFIG_CRYPTO_ACOMP2=y
CONFIG_CRYPTO_MANAGER=y
CONFIG_CRYPTO_MANAGER2=y
# CONFIG_CRYPTO_USER is not set
CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
CONFIG_CRYPTO_GF128MUL=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_NULL2=y
CONFIG_CRYPTO_PCRYPT=y
CONFIG_CRYPTO_CRYPTD=y
CONFIG_CRYPTO_AUTHENC=y
# CONFIG_CRYPTO_TEST is not set
CONFIG_CRYPTO_SIMD=y
CONFIG_CRYPTO_GLUE_HELPER_X86=y

#
# Public-key cryptography
#
CONFIG_CRYPTO_RSA=y
CONFIG_CRYPTO_DH=y
CONFIG_CRYPTO_ECC=y
CONFIG_CRYPTO_ECDH=y
CONFIG_CRYPTO_ECRDSA=y
CONFIG_CRYPTO_CURVE25519=y

#
# Authenticated Encryption with Associated Data
#
CONFIG_CRYPTO_CCM=y
CONFIG_CRYPTO_GCM=y
# CONFIG_CRYPTO_CHACHA20POLY1305 is not set
# CONFIG_CRYPTO_AEGIS128 is not set
CONFIG_CRYPTO_SEQIV=y
CONFIG_CRYPTO_ECHAINIV=y

#
# Block modes
#
CONFIG_CRYPTO_CBC=y
# CONFIG_CRYPTO_CFB is not set
CONFIG_CRYPTO_CTR=y
CONFIG_CRYPTO_CTS=y
CONFIG_CRYPTO_ECB=y
CONFIG_CRYPTO_LRW=y
# CONFIG_CRYPTO_OFB is not set
# CONFIG_CRYPTO_PCBC is not set
CONFIG_CRYPTO_XTS=y
# CONFIG_CRYPTO_KEYWRAP is not set
# CONFIG_CRYPTO_ADIANTUM is not set
# CONFIG_CRYPTO_ESSIV is not set

#
# Hash modes
#
CONFIG_CRYPTO_CMAC=y
CONFIG_CRYPTO_HMAC=y
# CONFIG_CRYPTO_XCBC is not set
CONFIG_CRYPTO_VMAC=y

#
# Digest
#
CONFIG_CRYPTO_CRC32C=y
CONFIG_CRYPTO_CRC32C_INTEL=y
CONFIG_CRYPTO_CRC32=y
# CONFIG_CRYPTO_CRC32_PCLMUL is not set
CONFIG_CRYPTO_XXHASH=y
CONFIG_CRYPTO_BLAKE2B=y
# CONFIG_CRYPTO_BLAKE2S is not set
# CONFIG_CRYPTO_CRCT10DIF is not set
CONFIG_CRYPTO_GHASH=y
CONFIG_CRYPTO_POLY1305=y
CONFIG_CRYPTO_MD4=y
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_MICHAEL_MIC=y
# CONFIG_CRYPTO_RMD128 is not set
CONFIG_CRYPTO_RMD160=y
CONFIG_CRYPTO_RMD256=y
# CONFIG_CRYPTO_RMD320 is not set
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
CONFIG_CRYPTO_SHA3=y
CONFIG_CRYPTO_SM3=y
CONFIG_CRYPTO_STREEBOG=y
# CONFIG_CRYPTO_TGR192 is not set
# CONFIG_CRYPTO_WP512 is not set

#
# Ciphers
#
CONFIG_CRYPTO_AES=y
CONFIG_CRYPTO_AES_TI=y
CONFIG_CRYPTO_AES_NI_INTEL=y
CONFIG_CRYPTO_ANUBIS=y
# CONFIG_CRYPTO_ARC4 is not set
CONFIG_CRYPTO_BLOWFISH=y
CONFIG_CRYPTO_BLOWFISH_COMMON=y
# CONFIG_CRYPTO_CAMELLIA is not set
CONFIG_CRYPTO_CAST_COMMON=y
# CONFIG_CRYPTO_CAST5 is not set
CONFIG_CRYPTO_CAST6=y
CONFIG_CRYPTO_DES=y
CONFIG_CRYPTO_FCRYPT=y
CONFIG_CRYPTO_KHAZAD=y
CONFIG_CRYPTO_SALSA20=y
CONFIG_CRYPTO_CHACHA20=y
# CONFIG_CRYPTO_SEED is not set
CONFIG_CRYPTO_SERPENT=y
CONFIG_CRYPTO_SERPENT_SSE2_586=y
CONFIG_CRYPTO_SM4=y
# CONFIG_CRYPTO_TEA is not set
# CONFIG_CRYPTO_TWOFISH is not set
CONFIG_CRYPTO_TWOFISH_COMMON=y
CONFIG_CRYPTO_TWOFISH_586=y

#
# Compression
#
CONFIG_CRYPTO_DEFLATE=y
CONFIG_CRYPTO_LZO=y
# CONFIG_CRYPTO_842 is not set
CONFIG_CRYPTO_LZ4=y
CONFIG_CRYPTO_LZ4HC=y
CONFIG_CRYPTO_ZSTD=y

#
# Random Number Generation
#
CONFIG_CRYPTO_ANSI_CPRNG=y
CONFIG_CRYPTO_DRBG_MENU=y
CONFIG_CRYPTO_DRBG_HMAC=y
# CONFIG_CRYPTO_DRBG_HASH is not set
# CONFIG_CRYPTO_DRBG_CTR is not set
CONFIG_CRYPTO_DRBG=y
CONFIG_CRYPTO_JITTERENTROPY=y
CONFIG_CRYPTO_USER_API=y
# CONFIG_CRYPTO_USER_API_HASH is not set
# CONFIG_CRYPTO_USER_API_SKCIPHER is not set
CONFIG_CRYPTO_USER_API_RNG=y
CONFIG_CRYPTO_USER_API_AEAD=y
CONFIG_CRYPTO_HASH_INFO=y

#
# Crypto library routines
#
CONFIG_CRYPTO_LIB_AES=y
CONFIG_CRYPTO_LIB_BLAKE2S_GENERIC=y
CONFIG_CRYPTO_LIB_BLAKE2S=y
CONFIG_CRYPTO_LIB_CHACHA_GENERIC=y
CONFIG_CRYPTO_LIB_CHACHA=y
CONFIG_CRYPTO_LIB_CURVE25519_GENERIC=y
# CONFIG_CRYPTO_LIB_CURVE25519 is not set
CONFIG_CRYPTO_LIB_DES=y
CONFIG_CRYPTO_LIB_POLY1305_RSIZE=1
CONFIG_CRYPTO_LIB_POLY1305_GENERIC=y
CONFIG_CRYPTO_LIB_POLY1305=y
CONFIG_CRYPTO_LIB_CHACHA20POLY1305=y
CONFIG_CRYPTO_LIB_SHA256=y
CONFIG_CRYPTO_HW=y
CONFIG_CRYPTO_DEV_PADLOCK=y
# CONFIG_CRYPTO_DEV_PADLOCK_AES is not set
CONFIG_CRYPTO_DEV_PADLOCK_SHA=y
# CONFIG_CRYPTO_DEV_GEODE is not set
CONFIG_CRYPTO_DEV_ATMEL_I2C=y
CONFIG_CRYPTO_DEV_ATMEL_ECC=y
CONFIG_CRYPTO_DEV_ATMEL_SHA204A=y
# CONFIG_CRYPTO_DEV_CCP is not set
# CONFIG_CRYPTO_DEV_QAT_DH895xCC is not set
# CONFIG_CRYPTO_DEV_QAT_C3XXX is not set
# CONFIG_CRYPTO_DEV_QAT_C62X is not set
# CONFIG_CRYPTO_DEV_QAT_DH895xCCVF is not set
# CONFIG_CRYPTO_DEV_QAT_C3XXXVF is not set
# CONFIG_CRYPTO_DEV_QAT_C62XVF is not set
# CONFIG_CRYPTO_DEV_VIRTIO is not set
# CONFIG_CRYPTO_DEV_SAFEXCEL is not set
CONFIG_CRYPTO_DEV_CCREE=y
# CONFIG_CRYPTO_DEV_AMLOGIC_GXL is not set
CONFIG_ASYMMETRIC_KEY_TYPE=y
# CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE is not set

#
# Certificates for signature checking
#
CONFIG_SYSTEM_TRUSTED_KEYRING=y
CONFIG_SYSTEM_TRUSTED_KEYS=""
CONFIG_SYSTEM_EXTRA_CERTIFICATE=y
CONFIG_SYSTEM_EXTRA_CERTIFICATE_SIZE=4096
# CONFIG_SECONDARY_TRUSTED_KEYRING is not set
# CONFIG_SYSTEM_BLACKLIST_KEYRING is not set
# end of Certificates for signature checking

CONFIG_BINARY_PRINTF=y

#
# Library routines
#
CONFIG_LINEAR_RANGES=y
CONFIG_PACKING=y
CONFIG_BITREVERSE=y
CONFIG_GENERIC_STRNCPY_FROM_USER=y
CONFIG_GENERIC_STRNLEN_USER=y
CONFIG_GENERIC_NET_UTILS=y
CONFIG_GENERIC_FIND_FIRST_BIT=y
# CONFIG_CORDIC is not set
CONFIG_PRIME_NUMBERS=y
CONFIG_RATIONAL=y
CONFIG_GENERIC_PCI_IOMAP=y
CONFIG_GENERIC_IOMAP=y
CONFIG_ARCH_HAS_FAST_MULTIPLIER=y
CONFIG_ARCH_USE_SYM_ANNOTATIONS=y
CONFIG_CRC_CCITT=y
CONFIG_CRC16=y
# CONFIG_CRC_T10DIF is not set
CONFIG_CRC_ITU_T=y
CONFIG_CRC32=y
# CONFIG_CRC32_SELFTEST is not set
# CONFIG_CRC32_SLICEBY8 is not set
CONFIG_CRC32_SLICEBY4=y
# CONFIG_CRC32_SARWATE is not set
# CONFIG_CRC32_BIT is not set
# CONFIG_CRC64 is not set
CONFIG_CRC4=y
# CONFIG_CRC7 is not set
CONFIG_LIBCRC32C=y
CONFIG_CRC8=y
CONFIG_XXHASH=y
# CONFIG_RANDOM32_SELFTEST is not set
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_LZO_COMPRESS=y
CONFIG_LZO_DECOMPRESS=y
CONFIG_LZ4_COMPRESS=y
CONFIG_LZ4HC_COMPRESS=y
CONFIG_LZ4_DECOMPRESS=y
CONFIG_ZSTD_COMPRESS=y
CONFIG_ZSTD_DECOMPRESS=y
CONFIG_XZ_DEC=y
# CONFIG_XZ_DEC_X86 is not set
# CONFIG_XZ_DEC_POWERPC is not set
CONFIG_XZ_DEC_IA64=y
# CONFIG_XZ_DEC_ARM is not set
CONFIG_XZ_DEC_ARMTHUMB=y
CONFIG_XZ_DEC_SPARC=y
CONFIG_XZ_DEC_BCJ=y
CONFIG_XZ_DEC_TEST=y
CONFIG_DECOMPRESS_GZIP=y
CONFIG_DECOMPRESS_BZIP2=y
CONFIG_DECOMPRESS_XZ=y
CONFIG_DECOMPRESS_ZSTD=y
CONFIG_GENERIC_ALLOCATOR=y
CONFIG_BCH=y
CONFIG_BCH_CONST_PARAMS=y
CONFIG_XARRAY_MULTI=y
CONFIG_ASSOCIATIVE_ARRAY=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT_MAP=y
CONFIG_HAS_DMA=y
CONFIG_NEED_SG_DMA_LENGTH=y
CONFIG_NEED_DMA_MAP_STATE=y
CONFIG_ARCH_DMA_ADDR_T_64BIT=y
CONFIG_DMA_DECLARE_COHERENT=y
CONFIG_SWIOTLB=y
CONFIG_DMA_CMA=y

#
# Default contiguous memory area size:
#
CONFIG_CMA_SIZE_PERCENTAGE=0
# CONFIG_CMA_SIZE_SEL_MBYTES is not set
CONFIG_CMA_SIZE_SEL_PERCENTAGE=y
# CONFIG_CMA_SIZE_SEL_MIN is not set
# CONFIG_CMA_SIZE_SEL_MAX is not set
CONFIG_CMA_ALIGNMENT=8
# CONFIG_DMA_API_DEBUG is not set
CONFIG_SGL_ALLOC=y
CONFIG_CHECK_SIGNATURE=y
CONFIG_CPU_RMAP=y
CONFIG_DQL=y
CONFIG_GLOB=y
CONFIG_GLOB_SELFTEST=y
CONFIG_NLATTR=y
CONFIG_CLZ_TAB=y
# CONFIG_IRQ_POLL is not set
CONFIG_MPILIB=y
CONFIG_LIBFDT=y
CONFIG_OID_REGISTRY=y
CONFIG_UCS2_STRING=y
CONFIG_HAVE_GENERIC_VDSO=y
CONFIG_GENERIC_GETTIMEOFDAY=y
CONFIG_GENERIC_VDSO_32=y
CONFIG_GENERIC_VDSO_TIME_NS=y
CONFIG_FONT_SUPPORT=y
CONFIG_FONT_8x16=y
CONFIG_FONT_AUTOSELECT=y
CONFIG_ARCH_STACKWALK=y
CONFIG_STACKDEPOT=y
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
# CONFIG_BOOT_PRINTK_DELAY is not set
# CONFIG_DYNAMIC_DEBUG is not set
# CONFIG_DYNAMIC_DEBUG_CORE is not set
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
# CONFIG_DEBUG_INFO_DWARF4 is not set
# CONFIG_GDB_SCRIPTS is not set
# CONFIG_ENABLE_MUST_CHECK is not set
CONFIG_FRAME_WARN=8192
# CONFIG_STRIP_ASM_SYMS is not set
CONFIG_READABLE_ASM=y
CONFIG_HEADERS_INSTALL=y
CONFIG_DEBUG_SECTION_MISMATCH=y
CONFIG_SECTION_MISMATCH_WARN_ONLY=y
CONFIG_DEBUG_FORCE_FUNCTION_ALIGN_32B=y
CONFIG_FRAME_POINTER=y
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
# end of Generic Kernel Debugging Instruments

CONFIG_DEBUG_KERNEL=y
# CONFIG_DEBUG_MISC is not set

#
# Memory Debugging
#
CONFIG_PAGE_EXTENSION=y
# CONFIG_DEBUG_PAGEALLOC is not set
CONFIG_PAGE_OWNER=y
# CONFIG_PAGE_POISONING is not set
CONFIG_DEBUG_PAGE_REF=y
# CONFIG_DEBUG_RODATA_TEST is not set
CONFIG_ARCH_HAS_DEBUG_WX=y
CONFIG_DEBUG_WX=y
CONFIG_GENERIC_PTDUMP=y
CONFIG_PTDUMP_CORE=y
# CONFIG_PTDUMP_DEBUGFS is not set
# CONFIG_DEBUG_OBJECTS is not set
CONFIG_SLUB_STATS=y
CONFIG_HAVE_DEBUG_KMEMLEAK=y
# CONFIG_DEBUG_KMEMLEAK is not set
# CONFIG_DEBUG_STACK_USAGE is not set
CONFIG_SCHED_STACK_END_CHECK=y
# CONFIG_DEBUG_VM is not set
CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
CONFIG_DEBUG_VIRTUAL=y
# CONFIG_DEBUG_MEMORY_INIT is not set
# CONFIG_DEBUG_PER_CPU_MAPS is not set
CONFIG_HAVE_DEBUG_STACKOVERFLOW=y
CONFIG_DEBUG_STACKOVERFLOW=y
CONFIG_CC_HAS_KASAN_GENERIC=y
CONFIG_CC_HAS_WORKING_NOSANITIZE_ADDRESS=y
# end of Memory Debugging

# CONFIG_DEBUG_SHIRQ is not set

#
# Debug Oops, Lockups and Hangs
#
CONFIG_PANIC_ON_OOPS=y
CONFIG_PANIC_ON_OOPS_VALUE=1
CONFIG_PANIC_TIMEOUT=0
CONFIG_LOCKUP_DETECTOR=y
CONFIG_SOFTLOCKUP_DETECTOR=y
CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC=y
CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC_VALUE=1
# CONFIG_HARDLOCKUP_DETECTOR is not set
# CONFIG_DETECT_HUNG_TASK is not set
CONFIG_WQ_WATCHDOG=y
# CONFIG_TEST_LOCKUP is not set
# end of Debug Oops, Lockups and Hangs

#
# Scheduler Debugging
#
# CONFIG_SCHED_DEBUG is not set
CONFIG_SCHED_INFO=y
CONFIG_SCHEDSTATS=y
# end of Scheduler Debugging

# CONFIG_DEBUG_TIMEKEEPING is not set
CONFIG_DEBUG_PREEMPT=y

#
# Lock Debugging (spinlocks, mutexes, etc...)
#
CONFIG_LOCK_DEBUGGING_SUPPORT=y
CONFIG_PROVE_LOCKING=y
# CONFIG_PROVE_RAW_LOCK_NESTING is not set
CONFIG_LOCK_STAT=y
CONFIG_DEBUG_RT_MUTEXES=y
CONFIG_DEBUG_SPINLOCK=y
CONFIG_DEBUG_MUTEXES=y
CONFIG_DEBUG_WW_MUTEX_SLOWPATH=y
CONFIG_DEBUG_RWSEMS=y
CONFIG_DEBUG_LOCK_ALLOC=y
CONFIG_LOCKDEP=y
# CONFIG_DEBUG_LOCKDEP is not set
CONFIG_DEBUG_ATOMIC_SLEEP=y
CONFIG_DEBUG_LOCKING_API_SELFTESTS=y
CONFIG_LOCK_TORTURE_TEST=y
CONFIG_WW_MUTEX_SELFTEST=y
# end of Lock Debugging (spinlocks, mutexes, etc...)

CONFIG_TRACE_IRQFLAGS=y
CONFIG_TRACE_IRQFLAGS_NMI=y
CONFIG_STACKTRACE=y
# CONFIG_WARN_ALL_UNSEEDED_RANDOM is not set
# CONFIG_DEBUG_KOBJECT is not set

#
# Debug kernel data structures
#
CONFIG_DEBUG_LIST=y
# CONFIG_DEBUG_PLIST is not set
# CONFIG_DEBUG_SG is not set
CONFIG_DEBUG_NOTIFIERS=y
# CONFIG_BUG_ON_DATA_CORRUPTION is not set
# end of Debug kernel data structures

CONFIG_DEBUG_CREDENTIALS=y

#
# RCU Debugging
#
CONFIG_PROVE_RCU=y
CONFIG_PROVE_RCU_LIST=y
CONFIG_TORTURE_TEST=y
CONFIG_RCU_PERF_TEST=y
# CONFIG_RCU_TORTURE_TEST is not set
# CONFIG_RCU_REF_SCALE_TEST is not set
CONFIG_RCU_CPU_STALL_TIMEOUT=21
# CONFIG_RCU_TRACE is not set
CONFIG_RCU_EQS_DEBUG=y
# end of RCU Debugging

CONFIG_DEBUG_WQ_FORCE_RR_CPU=y
CONFIG_CPU_HOTPLUG_STATE_CONTROL=y
# CONFIG_LATENCYTOP is not set
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
CONFIG_PREEMPTIRQ_TRACEPOINTS=y
CONFIG_TRACING=y
CONFIG_GENERIC_TRACER=y
CONFIG_TRACING_SUPPORT=y
CONFIG_FTRACE=y
CONFIG_BOOTTIME_TRACING=y
CONFIG_FUNCTION_TRACER=y
CONFIG_DYNAMIC_FTRACE=y
CONFIG_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=y
# CONFIG_FUNCTION_PROFILER is not set
CONFIG_STACK_TRACER=y
CONFIG_IRQSOFF_TRACER=y
# CONFIG_PREEMPT_TRACER is not set
CONFIG_SCHED_TRACER=y
CONFIG_HWLAT_TRACER=y
# CONFIG_MMIOTRACE is not set
CONFIG_FTRACE_SYSCALLS=y
CONFIG_TRACER_SNAPSHOT=y
CONFIG_TRACER_SNAPSHOT_PER_CPU_SWAP=y
CONFIG_BRANCH_PROFILE_NONE=y
# CONFIG_PROFILE_ANNOTATED_BRANCHES is not set
# CONFIG_UPROBE_EVENTS is not set
CONFIG_FTRACE_MCOUNT_RECORD=y
# CONFIG_SYNTH_EVENTS is not set
# CONFIG_HIST_TRIGGERS is not set
# CONFIG_TRACE_EVENT_INJECT is not set
CONFIG_TRACEPOINT_BENCHMARK=y
CONFIG_RING_BUFFER_BENCHMARK=y
# CONFIG_TRACE_EVAL_MAP_FILE is not set
# CONFIG_FTRACE_STARTUP_TEST is not set
# CONFIG_RING_BUFFER_STARTUP_TEST is not set
# CONFIG_PREEMPTIRQ_DELAY_TEST is not set
# CONFIG_PROVIDE_OHCI1394_DMA_INIT is not set
# CONFIG_SAMPLES is not set
CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y
CONFIG_STRICT_DEVMEM=y
CONFIG_IO_STRICT_DEVMEM=y

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
CONFIG_EFI_PGT_DUMP=y
# CONFIG_DEBUG_TLBFLUSH is not set
CONFIG_HAVE_MMIOTRACE_SUPPORT=y
# CONFIG_X86_DECODER_SELFTEST is not set
# CONFIG_IO_DELAY_0X80 is not set
# CONFIG_IO_DELAY_0XED is not set
# CONFIG_IO_DELAY_UDELAY is not set
CONFIG_IO_DELAY_NONE=y
# CONFIG_DEBUG_BOOT_PARAMS is not set
# CONFIG_CPA_DEBUG is not set
CONFIG_DEBUG_ENTRY=y
CONFIG_DEBUG_NMI_SELFTEST=y
CONFIG_X86_DEBUG_FPU=y
# CONFIG_PUNIT_ATOM_DEBUG is not set
CONFIG_UNWINDER_FRAME_POINTER=y
# end of x86 Debugging

#
# Kernel Testing and Coverage
#
# CONFIG_KUNIT is not set
# CONFIG_NOTIFIER_ERROR_INJECTION is not set
# CONFIG_FAULT_INJECTION is not set
CONFIG_CC_HAS_SANCOV_TRACE_PC=y
# CONFIG_RUNTIME_TESTING_MENU is not set
CONFIG_MEMTEST=y
CONFIG_HYPERV_TESTING=y
# end of Kernel Testing and Coverage
# end of Kernel hacking

--=_5f8dc512.rwdag2xu/8z1nAkUsoq8Xyiq2TWdT0Slqmlff4YZBT2TgiNl--
