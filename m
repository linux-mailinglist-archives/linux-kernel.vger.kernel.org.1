Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 041EC2B55BC
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 01:32:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731488AbgKQAcZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 19:32:25 -0500
Received: from mga11.intel.com ([192.55.52.93]:55138 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731471AbgKQAcY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 19:32:24 -0500
IronPort-SDR: HX/baFwaStrYy+yAlcy0FJuRwfxcEBqVs/fUUITk4MI45oVbw+mx8BXuijiF1TFH0AdDcNGwSl
 Sc+NCd3z9FtA==
X-IronPort-AV: E=McAfee;i="6000,8403,9807"; a="167328494"
X-IronPort-AV: E=Sophos;i="5.77,484,1596524400"; 
   d="xz'?gz'50?scan'50,208,50";a="167328494"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2020 16:32:14 -0800
IronPort-SDR: yWXugHbERHDP75fKXNOv8L/PX7oo7zwztFZ5pTyI59yqzGIS1as62VyW3aSE2+mXlcRCSzcNRn
 iIQLmLHL+myA==
X-IronPort-AV: E=Sophos;i="5.77,484,1596524400"; 
   d="xz'?gz'50?scan'50,208,50";a="533613448"
Received: from shao2-debian.sh.intel.com (HELO localhost) ([10.239.13.117])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2020 16:32:09 -0800
Date:   Tue, 17 Nov 2020 08:31:24 +0800
From:   kernel test robot <rong.a.chen@intel.com>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        LKP <lkp@lists.01.org>, lkp@intel.com
Subject: 5b9f8ff7b3 ("sched/debug: Output SD flag names rather than .."): [
  320.831182] BUG: KASAN: double-free or invalid-free in sd_ctl_doflags
Message-ID: <20201117003123.GB3723@shao2-debian>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="SLDf9lqlvOQaIe6s"
Content-Disposition: inline
User-Agent: Heirloom mailx 12.5 6/20/10
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--SLDf9lqlvOQaIe6s
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Greetings,

0day kernel testing robot got the below dmesg and the first bad commit is

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

commit 5b9f8ff7b320a34af3dbcf04edb40d9b04f22f4a
Author:     Valentin Schneider <valentin.schneider@arm.com>
AuthorDate: Mon Aug 17 12:29:52 2020 +0100
Commit:     Ingo Molnar <mingo@kernel.org>
CommitDate: Wed Aug 19 10:49:48 2020 +0200

    sched/debug: Output SD flag names rather than their values
    
    Decoding the output of /proc/sys/kernel/sched_domain/cpu*/domain*/flags has
    always been somewhat annoying, as one needs to go fetch the bit -> name
    mapping from the source code itself. This encoding can be saved in a script
    somewhere, but that isn't safe from flags being added, removed or even
    shuffled around.
    
    What matters for debugging purposes is to get *which* flags are set in a
    given domain, their associated value is pretty much meaningless.
    
    Make the sd flags debug file output flag names.
    
    Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
    Signed-off-by: Ingo Molnar <mingo@kernel.org>
    Acked-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
    Link: https://lore.kernel.org/r/20200817113003.20802-7-valentin.schneider@arm.com

65c5e25316  sched/topology: Verify SD_* flags setup when sched_debug is on
5b9f8ff7b3  sched/debug: Output SD flag names rather than their values
3cea11cd5e  Linux 5.10-rc2
+-------------------------------------------------+------------+------------+-----------+
|                                                 | 65c5e25316 | 5b9f8ff7b3 | v5.10-rc2 |
+-------------------------------------------------+------------+------------+-----------+
| boot_successes                                  | 824        | 523        | 322       |
| boot_failures                                   | 491        | 331        | 145       |
| WARNING:at_mm/usercopy.c:#usercopy_warn         | 439        | 292        | 143       |
| RIP:usercopy_warn                               | 439        | 292        | 143       |
| INFO:rcu_sched_self-detected_stall_on_CPU       | 38         | 22         |           |
| RIP:iov_iter_copy_from_user_atomic              | 26         | 15         |           |
| BUG:soft_lockup-CPU##stuck_for#s![trinity-c0:#] | 6          | 3          |           |
| Kernel_panic-not_syncing                        | 39         | 23         |           |
| RIP:ftrace_likely_update                        | 33         | 19         |           |
| BUG:soft_lockup-CPU##stuck_for#s![trinity-c6:#] | 5          | 3          |           |
| BUG:soft_lockup-CPU##stuck_for#s![trinity-c4:#] | 10         | 4          |           |
| WARNING:kernel_stack                            | 3          | 1          |           |
| BUG:soft_lockup-CPU##stuck_for#s![trinity-c2:#] | 6          | 2          |           |
| RIP:init_numa_balancing                         | 1          |            |           |
| BUG:soft_lockup-CPU##stuck_for#s![trinity-c5:#] | 5          | 2          |           |
| BUG:soft_lockup-CPU##stuck_for#s![trinity-c7:#] | 3          | 3          |           |
| RIP:default_idle                                | 2          | 2          |           |
| BUG:soft_lockup-CPU##stuck_for#s![trinity-c3:#] | 4          | 4          |           |
| BUG:kernel_hang_in_boot_stage                   | 8          | 1          | 1         |
| WARNING:at_fs/read_write.c:#vfs_copy_file_range | 1          |            |           |
| RIP:vfs_copy_file_range                         | 1          |            |           |
| invoked_oom-killer:gfp_mask=0x                  | 0          | 1          |           |
| Mem-Info                                        | 0          | 2          |           |
| BUG:KASAN:double-free_or_invalid-free_in_s      | 0          | 10         | 1         |
| RIP:_raw_spin_unlock_irq                        | 0          | 1          |           |
| BUG:kernel_reboot-without-warning_in_test_stage | 0          | 1          |           |
| BUG:soft_lockup-CPU##stuck_for#s![trinity-c1:#] | 0          | 1          |           |
| canonical_address#:#[##]                        | 0          | 1          |           |
| RIP:write_port                                  | 0          | 1          |           |
+-------------------------------------------------+------------+------------+-----------+

If you fix the issue, kindly add following tag
Reported-by: kernel test robot <rong.a.chen@intel.com>

[main] 175940 iterations. [F:131816 S:43081 HI:4371]
[main] 261312 iterations. [F:197423 S:62526 HI:4009]
[  317.933582] futex_wake_op: trinity-c2 tries to shift op by -723; fix this program
[main] 250542 iterations. [F:189030 S:60214 HI:4263]
[  320.826504] ==================================================================
[  320.831182] BUG: KASAN: double-free or invalid-free in sd_ctl_doflags+0x2f5/0x3c0
[  320.833579] 
[  320.834270] CPU: 1 PID: 11346 Comm: trinity-c1 Tainted: G            E     5.9.0-rc1-00104-g5b9f8ff7b320a #2
[  320.837287] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
[  320.839788] Call Trace:
[  320.840707]  dump_stack+0xa8/0xea
[  320.841872]  print_address_description+0x4f/0x70
[  320.843661]  ? kmsg_dump_rewind+0x160/0x160
[  320.845065]  ? sd_ctl_doflags+0x2f5/0x3c0
[  320.846408]  ? sd_ctl_doflags+0x2f5/0x3c0
[  320.847753]  kasan_report_invalid_free+0x56/0x80
[  320.849257]  __kasan_slab_free+0x121/0x140
[  320.850632]  kasan_slab_free+0xe/0x10
[  320.851895]  kfree+0x130/0x300
[  320.853001]  sd_ctl_doflags+0x2f5/0x3c0
[  320.854292]  ? kmalloc_array+0x60/0x60
[  320.855859]  ? proc_sys_call_handler+0x18b/0x3e0
[  320.857361]  proc_sys_call_handler+0x1ca/0x3e0
[  320.858825]  ? insert_header+0xee0/0xee0
[  320.860150]  proc_sys_read+0x11/0x20
[  320.861365]  do_iter_read+0x383/0x610
[  320.862609]  ? import_iovec+0xad/0x1b0
[  320.863873]  vfs_readv+0xc6/0x120
[  320.865022]  ? vfs_iocb_iter_write+0x3b0/0x3b0
[  320.873362]  ? _raw_spin_unlock_irqrestore+0x1e/0x40
[  320.875004]  ? _raw_spin_unlock_irq+0x13/0x20
[  320.876452]  ? do_setitimer+0x330/0x6c0
[  320.877658]  ? trace_hardirqs_on+0x49/0x1e0
[  320.879011]  ? do_raw_spin_unlock+0x165/0x2f0
[  320.880410]  ? _raw_spin_unlock_irq+0x13/0x20
[  320.881794]  ? do_setitimer+0x330/0x6c0
[  320.883044]  ? __fget_light+0x174/0x250
[  320.884299]  do_preadv+0x114/0x160
[  320.885451]  ? do_readv+0x200/0x200
[  320.886612]  ? trace_hardirqs_off_finish+0x45/0x1a0
[  320.888145]  __x64_sys_preadv+0x9a/0xf0
[  320.889394]  do_syscall_64+0x57/0x70
[  320.890576]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  320.892146] RIP: 0033:0x463519
[  320.893207] Code: 00 f3 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 db 59 00 00 c3 66 2e 0f 1f 84 00 00 00 00
[  320.898702] RSP: 002b:00007fff33658f28 EFLAGS: 00000246 ORIG_RAX: 0000000000000127
[  320.901115] RAX: ffffffffffffffda RBX: 0000000000000127 RCX: 0000000000463519
[  320.903291] RDX: 0000000000000044 RSI: 00000000012a5290 RDI: 0000000000000101
[  320.905446] RBP: 00007f0429c8a000 R08: 0000000031313131 R09: 0000000000000200
[  320.907667] R10: 0000000000000010 R11: 0000000000000246 R12: 0000000000000002
[  320.909820] R13: 00007f0429c8a058 R14: 000000000109a850 R15: 00007f0429c8a000
[  320.912014] 
[  320.912681] Allocated by task 11346:
[  320.913917]  kasan_save_stack+0x23/0x50
[  320.915232]  __kasan_kmalloc+0xde/0xf0
[  320.916866]  kasan_kmalloc+0x9/0x10
[  320.918121]  __kmalloc+0x1e4/0x410
[  320.919382]  kmalloc_array+0x43/0x60
[  320.920235]  sd_ctl_doflags+0x1a6/0x3c0
[  320.920941]  proc_sys_call_handler+0x1ca/0x3e0
[  320.921718]  proc_sys_read+0x11/0x20
[  320.922386]  do_iter_read+0x383/0x610
[  320.923061]  vfs_readv+0xc6/0x120
[  320.923707]  do_preadv+0x114/0x160
[  320.924360]  __x64_sys_preadv+0x9a/0xf0
[  320.925077]  do_syscall_64+0x57/0x70
[  320.925736]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  320.926599] 
[  320.926971] The buggy address belongs to the object at ffff8881e8e33200
[  320.926971]  which belongs to the cache kmalloc-96 of size 96
[  320.928969] The buggy address is located 16 bytes inside of

                                                          # HH:MM RESULT GOOD BAD GOOD_BUT_DIRTY DIRTY_NOT_BAD
git bisect start 6b02addb1d1748d21dd1261e46029b264be4e5a0 v5.8 --
git bisect good 005c53447a63cbce10de37406975a34d7bdc8704  # 03:49  G    901     0  330 330  Merge tag 'devprop-5.9-rc3' of git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm
git bisect good bed2a4433efe8bc1955cfd63713f39b0542efbbc  # 09:20  G    902     0  360 364  Merge remote-tracking branch 'reset/reset/next' into master
git bisect good 39424c3bcdc021f17f08c3dc3ec30d9366c1a6ae  # 17:47  G    904     0  366 366  Merge remote-tracking branch 'regmap/for-next' into master
git bisect  bad b1b1be0299c99199d87ac3b3a774419d3f2df2c7  # 19:50  B     93     1   44  44  Merge remote-tracking branch 'tty/tty-next' into master
git bisect good ace3d451d95ae878eecf3297489c85cd5e62d2d4  # 02:33  G    901     0  329 329  Merge remote-tracking branch 'audit/next' into master
git bisect  bad 48d93f3f79aee5666a738b9a86a91911d77f7688  # 06:00  B    393     1  156 156  Merge remote-tracking branch 'kvm-ppc/kvm-ppc-next' into master
git bisect  bad 9ea874987cf6c8eaffe005777436060b8230f0fa  # 08:49  B    266     1  104 104  Merge remote-tracking branch 'clockevents/timers/drivers/next' into master
git bisect good bea60d24f16679ab249287d682501d4038a83e2a  # 14:22  G    900     0  355 355  Merge remote-tracking branch 'spi/for-next' into master
git bisect  bad e78d6468da9befc77a7e651d0412af274a826c9a  # 15:11  B    244     1   85  85  Merge remote-tracking branch 'tip/auto-latest' into master
git bisect good ac3a5e30263f99ed60464188bb883b42c60c9d6e  # 17:50  G    901     0  363 363  Merge branch 'timers/core'
git bisect  bad c3803e61269bbea8c8eb2a812f6e574520ce6b0a  # 18:25  B    163     1   56  57  Merge branch 'objtool/core'
git bisect  bad 72f5b5b539a07fd15256364a8040792a56c84435  # 19:48  B    302     1  105 105  Merge branch 'perf/kprobes'
git bisect  bad 848785df48835eefebe0c4eb5da7690690b0a8b7  # 21:06  B     47     1   19  19  sched/topology: Move sd_flag_debug out of #ifdef CONFIG_SYSCTL
git bisect  bad 94b858fea1f2246a2fb7f7af21840fd14ced028f  # 22:08  B    125     1   54  54  sched/topology: Mark SD_BALANCE_WAKE as SDF_NEEDS_GROUPS
git bisect  bad 5b9f8ff7b320a34af3dbcf04edb40d9b04f22f4a  # 22:55  B     23     1   10  10  sched/debug: Output SD flag names rather than their values
git bisect good d54a9658a75633b839af7a2c6c758807678b8064  # 03:42  G    901     0  372 372  sched/topology: Split out SD_* flags declaration to its own file
git bisect good 65c5e253168dbbb52c20026b0c5b7a2f344b9197  # 06:09  G    905     0  372 372  sched/topology: Verify SD_* flags setup when sched_debug is on
# first bad commit: [5b9f8ff7b320a34af3dbcf04edb40d9b04f22f4a] sched/debug: Output SD flag names rather than their values
git bisect good 65c5e253168dbbb52c20026b0c5b7a2f344b9197  # 07:08  G   1000     0  186 558  sched/topology: Verify SD_* flags setup when sched_debug is on
# extra tests with debug options
git bisect  bad 5b9f8ff7b320a34af3dbcf04edb40d9b04f22f4a  # 08:13  B    310     1  133 133  sched/debug: Output SD flag names rather than their values
# extra tests on revert first bad commit
git bisect good 42455f6a04d80c81d88c30c1be83cfb5a5f25532  # 10:48  G    903     0  349 349  Revert "sched/debug: Output SD flag names rather than their values"
# good: [42455f6a04d80c81d88c30c1be83cfb5a5f25532] Revert "sched/debug: Output SD flag names rather than their values"
# extra tests on head commit of linus/master
git bisect  bad 3cea11cd5e3b00d91caf0b4730194039b45c5891  # 11:56  B    355     1  117 117  Linux 5.10-rc2
# bad: [3cea11cd5e3b00d91caf0b4730194039b45c5891] Linux 5.10-rc2
# extra tests on linus/master
# duplicated: [3cea11cd5e3b00d91caf0b4730194039b45c5891] Linux 5.10-rc2
# extra tests on linux-next/master
# 119: [4e78c578cb987725eef1cec7d11b6437109e9a49] Add linux-next specific files for 20201030

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/lkp@lists.01.org

--SLDf9lqlvOQaIe6s
Content-Type: application/gzip
Content-Disposition: attachment; filename="dmesg-quantal-vm-quantal-46:20201101234258:x86_64-randconfig-a002-20200920:5.9.0-rc1-00104-g5b9f8ff7b320a:2.gz"
Content-Transfer-Encoding: base64

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
G21c/VMBAA==

--SLDf9lqlvOQaIe6s
Content-Type: application/gzip
Content-Disposition: attachment; filename="dmesg-quantal-vm-quantal-100:20201102043455:x86_64-randconfig-a002-20200920:5.9.0-rc1-00103-g65c5e253168db:2.gz"
Content-Transfer-Encoding: base64

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
BZ78UwIA

--SLDf9lqlvOQaIe6s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="reproduce-quantal-vm-quantal-46:20201101234258:x86_64-randconfig-a002-20200920:5.9.0-rc1-00104-g5b9f8ff7b320a:2"

#!/bin/bash

kernel=$1
initrd=quantal-x86_64-trinity.cgz

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

--SLDf9lqlvOQaIe6s
Content-Type: application/x-xz
Content-Disposition: attachment; filename="53e8baadcb5e7e0a3f3571b298f6034a469897b3:gcc-9:x86_64-randconfig-a002-20200920:BUG:KASAN:double-free_or_invalid-free_in_s.xz"
Content-Transfer-Encoding: base64

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
AYnSCTx2dmKxxGf7AgAAAAAEWVo=

--SLDf9lqlvOQaIe6s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="config-5.9.0-rc1-00104-g5b9f8ff7b320a"

#
# Automatically generated file; DO NOT EDIT.
# Linux/x86_64 5.9.0-rc1 Kernel Configuration
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
CONFIG_CONSTRUCTORS=y
CONFIG_IRQ_WORK=y
CONFIG_BUILDTIME_TABLE_SORT=y
CONFIG_THREAD_INFO_IN_TASK=y

#
# General setup
#
CONFIG_INIT_ENV_ARG_LIMIT=32
# CONFIG_COMPILE_TEST is not set
CONFIG_UAPI_HEADER_TEST=y
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
# CONFIG_SYSVIPC is not set
# CONFIG_POSIX_MQUEUE is not set
CONFIG_WATCH_QUEUE=y
# CONFIG_CROSS_MEMORY_ATTACH is not set
CONFIG_USELIB=y
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
CONFIG_IRQ_SIM=y
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
# CONFIG_NO_HZ is not set
# CONFIG_HIGH_RES_TIMERS is not set
# end of Timers subsystem

CONFIG_PREEMPT_NONE=y
# CONFIG_PREEMPT_VOLUNTARY is not set
# CONFIG_PREEMPT is not set
CONFIG_PREEMPT_COUNT=y

#
# CPU/Task time and stats accounting
#
CONFIG_VIRT_CPU_ACCOUNTING=y
CONFIG_VIRT_CPU_ACCOUNTING_GEN=y
CONFIG_IRQ_TIME_ACCOUNTING=y
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

CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
CONFIG_IKHEADERS=y
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
# CONFIG_NUMA_BALANCING_DEFAULT_ENABLED is not set
CONFIG_CGROUPS=y
# CONFIG_MEMCG is not set
# CONFIG_BLK_CGROUP is not set
# CONFIG_CGROUP_SCHED is not set
# CONFIG_CGROUP_PIDS is not set
# CONFIG_CGROUP_RDMA is not set
# CONFIG_CGROUP_FREEZER is not set
# CONFIG_CPUSETS is not set
# CONFIG_CGROUP_DEVICE is not set
# CONFIG_CGROUP_CPUACCT is not set
# CONFIG_CGROUP_PERF is not set
# CONFIG_CGROUP_BPF is not set
# CONFIG_CGROUP_DEBUG is not set
CONFIG_NAMESPACES=y
CONFIG_UTS_NS=y
CONFIG_TIME_NS=y
# CONFIG_USER_NS is not set
# CONFIG_PID_NS is not set
CONFIG_NET_NS=y
CONFIG_CHECKPOINT_RESTORE=y
# CONFIG_SCHED_AUTOGROUP is not set
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
CONFIG_MEMBARRIER=y
CONFIG_KALLSYMS=y
# CONFIG_KALLSYMS_ALL is not set
CONFIG_KALLSYMS_ABSOLUTE_PERCPU=y
CONFIG_KALLSYMS_BASE_RELATIVE=y
CONFIG_BPF_SYSCALL=y
CONFIG_ARCH_WANT_DEFAULT_BPF_JIT=y
# CONFIG_BPF_JIT_ALWAYS_ON is not set
CONFIG_BPF_JIT_DEFAULT_ON=y
# CONFIG_USERFAULTFD is not set
CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=y
CONFIG_RSEQ=y
# CONFIG_EMBEDDED is not set
CONFIG_HAVE_PERF_EVENTS=y
CONFIG_PERF_USE_VMALLOC=y

#
# Kernel Performance Events And Counters
#
CONFIG_PERF_EVENTS=y
CONFIG_DEBUG_PERF_USE_VMALLOC=y
# end of Kernel Performance Events And Counters

CONFIG_VM_EVENT_COUNTERS=y
CONFIG_COMPAT_BRK=y
CONFIG_SLAB=y
# CONFIG_SLUB is not set
CONFIG_SLAB_MERGE_DEFAULT=y
CONFIG_SLAB_FREELIST_RANDOM=y
# CONFIG_SLAB_FREELIST_HARDENED is not set
# CONFIG_SHUFFLE_PAGE_ALLOCATOR is not set
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
CONFIG_KASAN_SHADOW_OFFSET=0xdffffc0000000000
CONFIG_X86_64_SMP=y
CONFIG_ARCH_SUPPORTS_UPROBES=y
CONFIG_FIX_EARLYCON_MEM=y
CONFIG_DYNAMIC_PHYSICAL_MASK=y
CONFIG_PGTABLE_LEVELS=4
CONFIG_CC_HAS_SANE_STACKPROTECTOR=y

#
# Processor type and features
#
CONFIG_ZONE_DMA=y
CONFIG_SMP=y
CONFIG_X86_FEATURE_NAMES=y
CONFIG_X86_X2APIC=y
# CONFIG_X86_MPPARSE is not set
CONFIG_GOLDFISH=y
# CONFIG_RETPOLINE is not set
# CONFIG_X86_CPU_RESCTRL is not set
# CONFIG_X86_EXTENDED_PLATFORM is not set
# CONFIG_X86_INTEL_LPSS is not set
# CONFIG_X86_AMD_PLATFORM_DEVICE is not set
# CONFIG_IOSF_MBI is not set
CONFIG_X86_SUPPORTS_MEMORY_FAILURE=y
# CONFIG_SCHED_OMIT_FRAME_POINTER is not set
CONFIG_HYPERVISOR_GUEST=y
CONFIG_PARAVIRT=y
# CONFIG_PARAVIRT_DEBUG is not set
# CONFIG_PARAVIRT_SPINLOCKS is not set
CONFIG_X86_HV_CALLBACK_VECTOR=y
# CONFIG_XEN is not set
CONFIG_KVM_GUEST=y
CONFIG_ARCH_CPUIDLE_HALTPOLL=y
# CONFIG_PVH is not set
# CONFIG_PARAVIRT_TIME_ACCOUNTING is not set
CONFIG_PARAVIRT_CLOCK=y
# CONFIG_JAILHOUSE_GUEST is not set
CONFIG_ACRN_GUEST=y
CONFIG_MK8=y
# CONFIG_MPSC is not set
# CONFIG_MCORE2 is not set
# CONFIG_MATOM is not set
# CONFIG_GENERIC_CPU is not set
CONFIG_X86_INTERNODE_CACHE_SHIFT=6
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_X86_INTEL_USERCOPY=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
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
CONFIG_DMI=y
# CONFIG_GART_IOMMU is not set
CONFIG_MAXSMP=y
CONFIG_NR_CPUS_RANGE_BEGIN=8192
CONFIG_NR_CPUS_RANGE_END=8192
CONFIG_NR_CPUS_DEFAULT=8192
CONFIG_NR_CPUS=8192
CONFIG_SCHED_SMT=y
CONFIG_SCHED_MC=y
# CONFIG_SCHED_MC_PRIO is not set
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
# CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS is not set
CONFIG_X86_MCE=y
# CONFIG_X86_MCELOG_LEGACY is not set
# CONFIG_X86_MCE_INTEL is not set
CONFIG_X86_MCE_AMD=y
CONFIG_X86_MCE_THRESHOLD=y
# CONFIG_X86_MCE_INJECT is not set

#
# Performance monitoring
#
CONFIG_PERF_EVENTS_INTEL_UNCORE=y
CONFIG_PERF_EVENTS_INTEL_RAPL=y
CONFIG_PERF_EVENTS_INTEL_CSTATE=y
CONFIG_PERF_EVENTS_AMD_POWER=y
# end of Performance monitoring

CONFIG_X86_16BIT=y
CONFIG_X86_ESPFIX64=y
CONFIG_X86_VSYSCALL_EMULATION=y
# CONFIG_X86_IOPL_IOPERM is not set
# CONFIG_I8K is not set
CONFIG_MICROCODE=y
CONFIG_MICROCODE_INTEL=y
# CONFIG_MICROCODE_AMD is not set
CONFIG_MICROCODE_OLD_INTERFACE=y
CONFIG_X86_MSR=y
CONFIG_X86_CPUID=y
# CONFIG_X86_5LEVEL is not set
CONFIG_X86_DIRECT_GBPAGES=y
# CONFIG_X86_CPA_STATISTICS is not set
CONFIG_AMD_MEM_ENCRYPT=y
CONFIG_AMD_MEM_ENCRYPT_ACTIVE_BY_DEFAULT=y
CONFIG_NUMA=y
CONFIG_AMD_NUMA=y
CONFIG_X86_64_ACPI_NUMA=y
CONFIG_NUMA_EMU=y
CONFIG_NODES_SHIFT=10
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_DEFAULT=y
CONFIG_ARCH_SELECT_MEMORY_MODEL=y
CONFIG_ILLEGAL_POINTER_VALUE=0xdead000000000000
# CONFIG_X86_PMEM_LEGACY is not set
CONFIG_X86_CHECK_BIOS_CORRUPTION=y
CONFIG_X86_BOOTPARAM_MEMORY_CORRUPTION_CHECK=y
CONFIG_X86_RESERVE_LOW=64
CONFIG_MTRR=y
CONFIG_MTRR_SANITIZER=y
CONFIG_MTRR_SANITIZER_ENABLE_DEFAULT=0
CONFIG_MTRR_SANITIZER_SPARE_REG_NR_DEFAULT=1
CONFIG_X86_PAT=y
CONFIG_ARCH_USES_PG_UNCACHED=y
CONFIG_ARCH_RANDOM=y
CONFIG_X86_SMAP=y
CONFIG_X86_UMIP=y
# CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS is not set
CONFIG_X86_INTEL_TSX_MODE_OFF=y
# CONFIG_X86_INTEL_TSX_MODE_ON is not set
# CONFIG_X86_INTEL_TSX_MODE_AUTO is not set
# CONFIG_EFI is not set
CONFIG_SECCOMP=y
# CONFIG_HZ_100 is not set
CONFIG_HZ_250=y
# CONFIG_HZ_300 is not set
# CONFIG_HZ_1000 is not set
CONFIG_HZ=250
CONFIG_KEXEC=y
# CONFIG_KEXEC_FILE is not set
CONFIG_CRASH_DUMP=y
CONFIG_PHYSICAL_START=0x1000000
CONFIG_RELOCATABLE=y
# CONFIG_RANDOMIZE_BASE is not set
CONFIG_PHYSICAL_ALIGN=0x200000
CONFIG_HOTPLUG_CPU=y
# CONFIG_BOOTPARAM_HOTPLUG_CPU0 is not set
CONFIG_DEBUG_HOTPLUG_CPU0=y
# CONFIG_COMPAT_VDSO is not set
CONFIG_LEGACY_VSYSCALL_EMULATE=y
# CONFIG_LEGACY_VSYSCALL_XONLY is not set
# CONFIG_LEGACY_VSYSCALL_NONE is not set
# CONFIG_CMDLINE_BOOL is not set
CONFIG_MODIFY_LDT_SYSCALL=y
CONFIG_HAVE_LIVEPATCH=y
# end of Processor type and features

CONFIG_ARCH_HAS_ADD_PAGES=y
CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
CONFIG_USE_PERCPU_NUMA_NODE_ID=y
CONFIG_ARCH_ENABLE_SPLIT_PMD_PTLOCK=y

#
# Power management and ACPI options
#
# CONFIG_SUSPEND is not set
# CONFIG_HIBERNATION is not set
CONFIG_PM=y
CONFIG_PM_DEBUG=y
# CONFIG_PM_ADVANCED_DEBUG is not set
CONFIG_PM_CLK=y
# CONFIG_WQ_POWER_EFFICIENT_DEFAULT is not set
CONFIG_ENERGY_MODEL=y
CONFIG_ARCH_SUPPORTS_ACPI=y
CONFIG_ACPI=y
CONFIG_ACPI_LEGACY_TABLES_LOOKUP=y
CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC=y
CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT=y
# CONFIG_ACPI_DEBUGGER is not set
CONFIG_ACPI_SPCR_TABLE=y
CONFIG_ACPI_LPIT=y
# CONFIG_ACPI_REV_OVERRIDE_POSSIBLE is not set
CONFIG_ACPI_EC_DEBUGFS=m
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=m
CONFIG_ACPI_BUTTON=y
# CONFIG_ACPI_VIDEO is not set
# CONFIG_ACPI_FAN is not set
# CONFIG_ACPI_DOCK is not set
CONFIG_ACPI_CPU_FREQ_PSS=y
CONFIG_ACPI_PROCESSOR_CSTATE=y
CONFIG_ACPI_PROCESSOR_IDLE=y
CONFIG_ACPI_PROCESSOR=y
# CONFIG_ACPI_IPMI is not set
CONFIG_ACPI_HOTPLUG_CPU=y
CONFIG_ACPI_PROCESSOR_AGGREGATOR=y
CONFIG_ACPI_THERMAL=y
CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
CONFIG_ACPI_TABLE_UPGRADE=y
CONFIG_ACPI_DEBUG=y
# CONFIG_ACPI_PCI_SLOT is not set
CONFIG_ACPI_CONTAINER=y
CONFIG_ACPI_HOTPLUG_IOAPIC=y
CONFIG_ACPI_SBS=m
CONFIG_ACPI_HED=y
CONFIG_ACPI_CUSTOM_METHOD=m
# CONFIG_ACPI_NFIT is not set
CONFIG_ACPI_NUMA=y
# CONFIG_ACPI_HMAT is not set
CONFIG_HAVE_ACPI_APEI=y
CONFIG_HAVE_ACPI_APEI_NMI=y
# CONFIG_ACPI_APEI is not set
# CONFIG_DPTF_POWER is not set
# CONFIG_PMIC_OPREGION is not set
CONFIG_ACPI_CONFIGFS=y
CONFIG_X86_PM_TIMER=y
# CONFIG_SFI is not set

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
# CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND is not set
CONFIG_CPU_FREQ_DEFAULT_GOV_CONSERVATIVE=y
# CONFIG_CPU_FREQ_DEFAULT_GOV_SCHEDUTIL is not set
CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
CONFIG_CPU_FREQ_GOV_POWERSAVE=y
# CONFIG_CPU_FREQ_GOV_USERSPACE is not set
CONFIG_CPU_FREQ_GOV_ONDEMAND=y
CONFIG_CPU_FREQ_GOV_CONSERVATIVE=y
# CONFIG_CPU_FREQ_GOV_SCHEDUTIL is not set

#
# CPU frequency scaling drivers
#
# CONFIG_CPUFREQ_DT is not set
# CONFIG_X86_INTEL_PSTATE is not set
CONFIG_X86_PCC_CPUFREQ=m
# CONFIG_X86_ACPI_CPUFREQ is not set
# CONFIG_X86_SPEEDSTEP_CENTRINO is not set
CONFIG_X86_P4_CLOCKMOD=y

#
# shared options
#
CONFIG_X86_SPEEDSTEP_LIB=y
# end of CPU Frequency scaling

#
# CPU Idle
#
CONFIG_CPU_IDLE=y
CONFIG_CPU_IDLE_GOV_LADDER=y
CONFIG_CPU_IDLE_GOV_MENU=y
# CONFIG_CPU_IDLE_GOV_TEO is not set
# CONFIG_CPU_IDLE_GOV_HALTPOLL is not set
CONFIG_HALTPOLL_CPUIDLE=m
# end of CPU Idle

# CONFIG_INTEL_IDLE is not set
# end of Power management and ACPI options

#
# Bus options (PCI etc.)
#
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
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
# end of Binary Emulations

#
# Firmware Drivers
#
CONFIG_EDD=m
CONFIG_EDD_OFF=y
CONFIG_FIRMWARE_MEMMAP=y
# CONFIG_DMIID is not set
CONFIG_DMI_SYSFS=m
CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK=y
CONFIG_ISCSI_IBFT_FIND=y
CONFIG_ISCSI_IBFT=m
# CONFIG_FW_CFG_SYSFS is not set
CONFIG_GOOGLE_FIRMWARE=y
# CONFIG_GOOGLE_SMI is not set
CONFIG_GOOGLE_COREBOOT_TABLE=y
CONFIG_GOOGLE_MEMCONSOLE=y
CONFIG_GOOGLE_MEMCONSOLE_X86_LEGACY=m
CONFIG_GOOGLE_MEMCONSOLE_COREBOOT=y
CONFIG_GOOGLE_VPD=y
CONFIG_EFI_EARLYCON=y

#
# Tegra firmware driver
#
# end of Tegra firmware driver
# end of Firmware Drivers

CONFIG_HAVE_KVM=y
CONFIG_VIRTUALIZATION=y
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
CONFIG_OPROFILE=y
# CONFIG_OPROFILE_EVENT_MULTIPLEX is not set
CONFIG_HAVE_OPROFILE=y
CONFIG_OPROFILE_NMI_TIMER=y
# CONFIG_KPROBES is not set
CONFIG_JUMP_LABEL=y
CONFIG_STATIC_KEYS_SELFTEST=y
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
CONFIG_HAVE_CMPXCHG_LOCAL=y
CONFIG_HAVE_CMPXCHG_DOUBLE=y
CONFIG_ARCH_WANT_COMPAT_IPC_PARSE_VERSION=y
CONFIG_ARCH_WANT_OLD_COMPAT_IPC=y
CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
CONFIG_SECCOMP_FILTER=y
CONFIG_HAVE_ARCH_STACKLEAK=y
CONFIG_HAVE_STACKPROTECTOR=y
# CONFIG_STACKPROTECTOR is not set
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
CONFIG_ISA_BUS_API=y
CONFIG_OLD_SIGSUSPEND3=y
CONFIG_COMPAT_OLD_SIGACTION=y
CONFIG_COMPAT_32BIT_TIME=y
CONFIG_HAVE_ARCH_VMAP_STACK=y
# CONFIG_VMAP_STACK is not set
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
# CONFIG_MODULE_UNLOAD is not set
# CONFIG_MODVERSIONS is not set
# CONFIG_MODULE_SRCVERSION_ALL is not set
CONFIG_MODULE_SIG=y
# CONFIG_MODULE_SIG_FORCE is not set
# CONFIG_MODULE_SIG_ALL is not set
# CONFIG_MODULE_SIG_SHA1 is not set
# CONFIG_MODULE_SIG_SHA224 is not set
# CONFIG_MODULE_SIG_SHA256 is not set
# CONFIG_MODULE_SIG_SHA384 is not set
CONFIG_MODULE_SIG_SHA512=y
CONFIG_MODULE_SIG_HASH="sha512"
# CONFIG_MODULE_COMPRESS is not set
# CONFIG_MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS is not set
# CONFIG_UNUSED_SYMBOLS is not set
CONFIG_TRIM_UNUSED_KSYMS=y
CONFIG_UNUSED_KSYMS_WHITELIST=""
CONFIG_MODULES_TREE_LOOKUP=y
CONFIG_BLOCK=y
CONFIG_BLK_SCSI_REQUEST=y
CONFIG_BLK_DEV_BSG=y
CONFIG_BLK_DEV_BSGLIB=y
CONFIG_BLK_DEV_INTEGRITY=y
CONFIG_BLK_DEV_INTEGRITY_T10=y
CONFIG_BLK_DEV_ZONED=y
CONFIG_BLK_CMDLINE_PARSER=y
CONFIG_BLK_WBT=y
CONFIG_BLK_WBT_MQ=y
# CONFIG_BLK_DEBUG_FS is not set
# CONFIG_BLK_SED_OPAL is not set
CONFIG_BLK_INLINE_ENCRYPTION=y
# CONFIG_BLK_INLINE_ENCRYPTION_FALLBACK is not set

#
# Partition Types
#
CONFIG_PARTITION_ADVANCED=y
# CONFIG_ACORN_PARTITION is not set
# CONFIG_AIX_PARTITION is not set
# CONFIG_OSF_PARTITION is not set
CONFIG_AMIGA_PARTITION=y
# CONFIG_ATARI_PARTITION is not set
# CONFIG_MAC_PARTITION is not set
# CONFIG_MSDOS_PARTITION is not set
CONFIG_LDM_PARTITION=y
# CONFIG_LDM_DEBUG is not set
# CONFIG_SGI_PARTITION is not set
CONFIG_ULTRIX_PARTITION=y
CONFIG_SUN_PARTITION=y
CONFIG_KARMA_PARTITION=y
# CONFIG_EFI_PARTITION is not set
# CONFIG_SYSV68_PARTITION is not set
CONFIG_CMDLINE_PARTITION=y
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

#
# Executable file formats
#
CONFIG_BINFMT_ELF=y
CONFIG_COMPAT_BINFMT_ELF=y
CONFIG_ELFCORE=y
# CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
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
CONFIG_MEMORY_ISOLATION=y
# CONFIG_MEMORY_HOTPLUG is not set
CONFIG_SPLIT_PTLOCK_CPUS=4
# CONFIG_COMPACTION is not set
# CONFIG_PAGE_REPORTING is not set
CONFIG_MIGRATION=y
CONFIG_CONTIG_ALLOC=y
CONFIG_PHYS_ADDR_T_64BIT=y
# CONFIG_BOUNCE is not set
CONFIG_VIRT_TO_BUS=y
# CONFIG_KSM is not set
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
CONFIG_ARCH_SUPPORTS_MEMORY_FAILURE=y
CONFIG_MEMORY_FAILURE=y
# CONFIG_HWPOISON_INJECT is not set
# CONFIG_TRANSPARENT_HUGEPAGE is not set
CONFIG_ARCH_WANTS_THP_SWAP=y
CONFIG_CLEANCACHE=y
# CONFIG_FRONTSWAP is not set
CONFIG_CMA=y
# CONFIG_CMA_DEBUG is not set
CONFIG_CMA_DEBUGFS=y
CONFIG_CMA_AREAS=7
CONFIG_MEM_SOFT_DIRTY=y
# CONFIG_ZPOOL is not set
# CONFIG_ZBUD is not set
CONFIG_ZSMALLOC=m
# CONFIG_ZSMALLOC_STAT is not set
CONFIG_GENERIC_EARLY_IOREMAP=y
# CONFIG_DEFERRED_STRUCT_PAGE_INIT is not set
# CONFIG_IDLE_PAGE_TRACKING is not set
CONFIG_ARCH_HAS_PTE_DEVMAP=y
CONFIG_FRAME_VECTOR=y
# CONFIG_PERCPU_STATS is not set
# CONFIG_GUP_BENCHMARK is not set
CONFIG_ARCH_HAS_PTE_SPECIAL=y
# end of Memory Management options

CONFIG_NET=y
CONFIG_NET_REDIRECT=y
CONFIG_SKB_EXTENSIONS=y

#
# Networking options
#
CONFIG_PACKET=m
CONFIG_PACKET_DIAG=m
CONFIG_UNIX=y
CONFIG_UNIX_SCM=y
# CONFIG_UNIX_DIAG is not set
CONFIG_TLS=m
# CONFIG_TLS_DEVICE is not set
CONFIG_TLS_TOE=y
CONFIG_XFRM=y
CONFIG_XFRM_ALGO=y
# CONFIG_XFRM_USER is not set
CONFIG_XFRM_INTERFACE=m
CONFIG_XFRM_SUB_POLICY=y
CONFIG_XFRM_MIGRATE=y
CONFIG_XFRM_STATISTICS=y
CONFIG_XFRM_AH=y
CONFIG_XFRM_ESP=m
CONFIG_XFRM_IPCOMP=m
CONFIG_NET_KEY=m
CONFIG_NET_KEY_MIGRATE=y
CONFIG_XFRM_ESPINTCP=y
# CONFIG_SMC is not set
# CONFIG_XDP_SOCKETS is not set
CONFIG_INET=y
# CONFIG_IP_MULTICAST is not set
# CONFIG_IP_ADVANCED_ROUTER is not set
CONFIG_IP_ROUTE_CLASSID=y
CONFIG_IP_PNP=y
CONFIG_IP_PNP_DHCP=y
# CONFIG_IP_PNP_BOOTP is not set
# CONFIG_IP_PNP_RARP is not set
CONFIG_NET_IPIP=m
CONFIG_NET_IPGRE_DEMUX=m
CONFIG_NET_IP_TUNNEL=y
CONFIG_NET_IPGRE=m
CONFIG_SYN_COOKIES=y
CONFIG_NET_IPVTI=m
CONFIG_NET_UDP_TUNNEL=y
CONFIG_NET_FOU=m
# CONFIG_NET_FOU_IP_TUNNELS is not set
CONFIG_INET_AH=y
CONFIG_INET_ESP=m
# CONFIG_INET_ESP_OFFLOAD is not set
CONFIG_INET_ESPINTCP=y
CONFIG_INET_IPCOMP=m
CONFIG_INET_XFRM_TUNNEL=m
CONFIG_INET_TUNNEL=m
CONFIG_INET_DIAG=m
CONFIG_INET_TCP_DIAG=m
CONFIG_INET_UDP_DIAG=m
CONFIG_INET_RAW_DIAG=m
CONFIG_INET_DIAG_DESTROY=y
CONFIG_TCP_CONG_ADVANCED=y
CONFIG_TCP_CONG_BIC=m
CONFIG_TCP_CONG_CUBIC=m
CONFIG_TCP_CONG_WESTWOOD=y
CONFIG_TCP_CONG_HTCP=m
CONFIG_TCP_CONG_HSTCP=m
CONFIG_TCP_CONG_HYBLA=y
CONFIG_TCP_CONG_VEGAS=y
# CONFIG_TCP_CONG_NV is not set
CONFIG_TCP_CONG_SCALABLE=y
# CONFIG_TCP_CONG_LP is not set
CONFIG_TCP_CONG_VENO=y
CONFIG_TCP_CONG_YEAH=y
# CONFIG_TCP_CONG_ILLINOIS is not set
CONFIG_TCP_CONG_DCTCP=m
CONFIG_TCP_CONG_CDG=m
# CONFIG_TCP_CONG_BBR is not set
CONFIG_DEFAULT_HYBLA=y
# CONFIG_DEFAULT_VEGAS is not set
# CONFIG_DEFAULT_VENO is not set
# CONFIG_DEFAULT_WESTWOOD is not set
# CONFIG_DEFAULT_RENO is not set
CONFIG_DEFAULT_TCP_CONG="hybla"
# CONFIG_TCP_MD5SIG is not set
CONFIG_IPV6=m
CONFIG_IPV6_ROUTER_PREF=y
# CONFIG_IPV6_ROUTE_INFO is not set
CONFIG_IPV6_OPTIMISTIC_DAD=y
CONFIG_INET6_AH=m
# CONFIG_INET6_ESP is not set
CONFIG_INET6_IPCOMP=m
# CONFIG_IPV6_MIP6 is not set
CONFIG_IPV6_ILA=m
CONFIG_INET6_XFRM_TUNNEL=m
CONFIG_INET6_TUNNEL=m
# CONFIG_IPV6_VTI is not set
CONFIG_IPV6_SIT=m
# CONFIG_IPV6_SIT_6RD is not set
CONFIG_IPV6_NDISC_NODETYPE=y
CONFIG_IPV6_TUNNEL=m
# CONFIG_IPV6_GRE is not set
CONFIG_IPV6_FOU=m
# CONFIG_IPV6_MULTIPLE_TABLES is not set
# CONFIG_IPV6_MROUTE is not set
# CONFIG_IPV6_SEG6_LWTUNNEL is not set
# CONFIG_IPV6_SEG6_HMAC is not set
CONFIG_IPV6_RPL_LWTUNNEL=y
CONFIG_MPTCP=y
CONFIG_INET_MPTCP_DIAG=m
# CONFIG_MPTCP_IPV6 is not set
# CONFIG_MPTCP_KUNIT_TESTS is not set
# CONFIG_NETWORK_SECMARK is not set
CONFIG_NET_PTP_CLASSIFY=y
CONFIG_NETWORK_PHY_TIMESTAMPING=y
CONFIG_NETFILTER=y
CONFIG_NETFILTER_ADVANCED=y
CONFIG_BRIDGE_NETFILTER=m

#
# Core Netfilter Configuration
#
# CONFIG_NETFILTER_INGRESS is not set
CONFIG_NETFILTER_NETLINK=y
CONFIG_NETFILTER_FAMILY_BRIDGE=y
CONFIG_NETFILTER_FAMILY_ARP=y
CONFIG_NETFILTER_NETLINK_ACCT=y
CONFIG_NETFILTER_NETLINK_QUEUE=y
CONFIG_NETFILTER_NETLINK_LOG=y
CONFIG_NETFILTER_NETLINK_OSF=y
CONFIG_NF_CONNTRACK=m
CONFIG_NF_LOG_COMMON=y
CONFIG_NF_LOG_NETDEV=y
CONFIG_NETFILTER_CONNCOUNT=m
CONFIG_NF_CONNTRACK_MARK=y
CONFIG_NF_CONNTRACK_ZONES=y
CONFIG_NF_CONNTRACK_PROCFS=y
# CONFIG_NF_CONNTRACK_EVENTS is not set
# CONFIG_NF_CONNTRACK_TIMEOUT is not set
# CONFIG_NF_CONNTRACK_TIMESTAMP is not set
CONFIG_NF_CONNTRACK_LABELS=y
# CONFIG_NF_CT_PROTO_DCCP is not set
CONFIG_NF_CT_PROTO_SCTP=y
CONFIG_NF_CT_PROTO_UDPLITE=y
# CONFIG_NF_CONNTRACK_AMANDA is not set
CONFIG_NF_CONNTRACK_FTP=m
CONFIG_NF_CONNTRACK_H323=m
# CONFIG_NF_CONNTRACK_IRC is not set
CONFIG_NF_CONNTRACK_BROADCAST=m
CONFIG_NF_CONNTRACK_NETBIOS_NS=m
CONFIG_NF_CONNTRACK_SNMP=m
# CONFIG_NF_CONNTRACK_PPTP is not set
# CONFIG_NF_CONNTRACK_SANE is not set
# CONFIG_NF_CONNTRACK_SIP is not set
CONFIG_NF_CONNTRACK_TFTP=m
CONFIG_NF_CT_NETLINK=m
# CONFIG_NETFILTER_NETLINK_GLUE_CT is not set
CONFIG_NF_NAT=m
CONFIG_NF_NAT_FTP=m
CONFIG_NF_NAT_TFTP=m
CONFIG_NF_NAT_REDIRECT=y
CONFIG_NF_NAT_MASQUERADE=y
CONFIG_NETFILTER_SYNPROXY=m
CONFIG_NF_TABLES=y
CONFIG_NF_TABLES_INET=y
# CONFIG_NF_TABLES_NETDEV is not set
CONFIG_NFT_NUMGEN=m
CONFIG_NFT_CT=m
CONFIG_NFT_COUNTER=y
CONFIG_NFT_CONNLIMIT=m
CONFIG_NFT_LOG=y
# CONFIG_NFT_LIMIT is not set
CONFIG_NFT_MASQ=m
# CONFIG_NFT_REDIR is not set
CONFIG_NFT_NAT=m
CONFIG_NFT_TUNNEL=y
# CONFIG_NFT_OBJREF is not set
CONFIG_NFT_QUEUE=m
CONFIG_NFT_QUOTA=y
CONFIG_NFT_REJECT=m
CONFIG_NFT_REJECT_INET=m
CONFIG_NFT_COMPAT=y
# CONFIG_NFT_HASH is not set
CONFIG_NFT_FIB=m
CONFIG_NFT_XFRM=m
# CONFIG_NFT_SOCKET is not set
CONFIG_NFT_OSF=y
# CONFIG_NFT_TPROXY is not set
CONFIG_NFT_SYNPROXY=m
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
CONFIG_NETFILTER_XT_TARGET_CLASSIFY=y
CONFIG_NETFILTER_XT_TARGET_CONNMARK=m
CONFIG_NETFILTER_XT_TARGET_HMARK=m
CONFIG_NETFILTER_XT_TARGET_IDLETIMER=m
# CONFIG_NETFILTER_XT_TARGET_LED is not set
# CONFIG_NETFILTER_XT_TARGET_LOG is not set
# CONFIG_NETFILTER_XT_TARGET_MARK is not set
CONFIG_NETFILTER_XT_NAT=m
CONFIG_NETFILTER_XT_TARGET_NETMAP=m
CONFIG_NETFILTER_XT_TARGET_NFLOG=y
CONFIG_NETFILTER_XT_TARGET_NFQUEUE=y
CONFIG_NETFILTER_XT_TARGET_RATEEST=y
CONFIG_NETFILTER_XT_TARGET_REDIRECT=m
# CONFIG_NETFILTER_XT_TARGET_MASQUERADE is not set
CONFIG_NETFILTER_XT_TARGET_TEE=m
CONFIG_NETFILTER_XT_TARGET_TCPMSS=m

#
# Xtables matches
#
# CONFIG_NETFILTER_XT_MATCH_ADDRTYPE is not set
CONFIG_NETFILTER_XT_MATCH_BPF=m
# CONFIG_NETFILTER_XT_MATCH_CGROUP is not set
CONFIG_NETFILTER_XT_MATCH_CLUSTER=m
CONFIG_NETFILTER_XT_MATCH_COMMENT=m
CONFIG_NETFILTER_XT_MATCH_CONNBYTES=m
CONFIG_NETFILTER_XT_MATCH_CONNLABEL=m
CONFIG_NETFILTER_XT_MATCH_CONNLIMIT=m
CONFIG_NETFILTER_XT_MATCH_CONNMARK=m
# CONFIG_NETFILTER_XT_MATCH_CONNTRACK is not set
# CONFIG_NETFILTER_XT_MATCH_CPU is not set
CONFIG_NETFILTER_XT_MATCH_DCCP=y
CONFIG_NETFILTER_XT_MATCH_DEVGROUP=m
# CONFIG_NETFILTER_XT_MATCH_DSCP is not set
CONFIG_NETFILTER_XT_MATCH_ECN=y
# CONFIG_NETFILTER_XT_MATCH_ESP is not set
# CONFIG_NETFILTER_XT_MATCH_HASHLIMIT is not set
CONFIG_NETFILTER_XT_MATCH_HELPER=m
CONFIG_NETFILTER_XT_MATCH_HL=y
CONFIG_NETFILTER_XT_MATCH_IPCOMP=y
# CONFIG_NETFILTER_XT_MATCH_IPRANGE is not set
CONFIG_NETFILTER_XT_MATCH_L2TP=m
# CONFIG_NETFILTER_XT_MATCH_LENGTH is not set
CONFIG_NETFILTER_XT_MATCH_LIMIT=y
CONFIG_NETFILTER_XT_MATCH_MAC=y
CONFIG_NETFILTER_XT_MATCH_MARK=m
# CONFIG_NETFILTER_XT_MATCH_MULTIPORT is not set
CONFIG_NETFILTER_XT_MATCH_NFACCT=y
# CONFIG_NETFILTER_XT_MATCH_OSF is not set
CONFIG_NETFILTER_XT_MATCH_OWNER=m
CONFIG_NETFILTER_XT_MATCH_POLICY=m
# CONFIG_NETFILTER_XT_MATCH_PHYSDEV is not set
CONFIG_NETFILTER_XT_MATCH_PKTTYPE=y
# CONFIG_NETFILTER_XT_MATCH_QUOTA is not set
CONFIG_NETFILTER_XT_MATCH_RATEEST=y
CONFIG_NETFILTER_XT_MATCH_REALM=y
# CONFIG_NETFILTER_XT_MATCH_RECENT is not set
# CONFIG_NETFILTER_XT_MATCH_SCTP is not set
CONFIG_NETFILTER_XT_MATCH_SOCKET=m
# CONFIG_NETFILTER_XT_MATCH_STATE is not set
# CONFIG_NETFILTER_XT_MATCH_STATISTIC is not set
CONFIG_NETFILTER_XT_MATCH_STRING=y
CONFIG_NETFILTER_XT_MATCH_TCPMSS=m
CONFIG_NETFILTER_XT_MATCH_TIME=y
# CONFIG_NETFILTER_XT_MATCH_U32 is not set
# end of Core Netfilter Configuration

CONFIG_IP_SET=m
CONFIG_IP_SET_MAX=256
CONFIG_IP_SET_BITMAP_IP=m
# CONFIG_IP_SET_BITMAP_IPMAC is not set
# CONFIG_IP_SET_BITMAP_PORT is not set
CONFIG_IP_SET_HASH_IP=m
CONFIG_IP_SET_HASH_IPMARK=m
# CONFIG_IP_SET_HASH_IPPORT is not set
CONFIG_IP_SET_HASH_IPPORTIP=m
# CONFIG_IP_SET_HASH_IPPORTNET is not set
# CONFIG_IP_SET_HASH_IPMAC is not set
CONFIG_IP_SET_HASH_MAC=m
CONFIG_IP_SET_HASH_NETPORTNET=m
# CONFIG_IP_SET_HASH_NET is not set
CONFIG_IP_SET_HASH_NETNET=m
CONFIG_IP_SET_HASH_NETPORT=m
CONFIG_IP_SET_HASH_NETIFACE=m
CONFIG_IP_SET_LIST_SET=m
# CONFIG_IP_VS is not set

#
# IP: Netfilter Configuration
#
CONFIG_NF_DEFRAG_IPV4=m
CONFIG_NF_SOCKET_IPV4=y
CONFIG_NF_TPROXY_IPV4=m
CONFIG_NF_TABLES_IPV4=y
CONFIG_NFT_REJECT_IPV4=m
# CONFIG_NFT_DUP_IPV4 is not set
# CONFIG_NFT_FIB_IPV4 is not set
CONFIG_NF_TABLES_ARP=y
CONFIG_NF_DUP_IPV4=m
# CONFIG_NF_LOG_ARP is not set
CONFIG_NF_LOG_IPV4=y
CONFIG_NF_REJECT_IPV4=m
CONFIG_NF_NAT_SNMP_BASIC=m
CONFIG_NF_NAT_H323=m
# CONFIG_IP_NF_IPTABLES is not set
CONFIG_IP_NF_ARPTABLES=y
# CONFIG_IP_NF_ARPFILTER is not set
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
# CONFIG_IP6_NF_IPTABLES is not set
# end of IPv6: Netfilter Configuration

CONFIG_NF_DEFRAG_IPV6=m

#
# DECnet: Netfilter Configuration
#
# CONFIG_DECNET_NF_GRABULATOR is not set
# end of DECnet: Netfilter Configuration

CONFIG_NF_TABLES_BRIDGE=m
CONFIG_NFT_BRIDGE_META=m
CONFIG_NFT_BRIDGE_REJECT=m
CONFIG_NF_LOG_BRIDGE=m
CONFIG_NF_CONNTRACK_BRIDGE=m
CONFIG_BRIDGE_NF_EBTABLES=m
# CONFIG_BRIDGE_EBT_BROUTE is not set
CONFIG_BRIDGE_EBT_T_FILTER=m
# CONFIG_BRIDGE_EBT_T_NAT is not set
# CONFIG_BRIDGE_EBT_802_3 is not set
CONFIG_BRIDGE_EBT_AMONG=m
CONFIG_BRIDGE_EBT_ARP=m
# CONFIG_BRIDGE_EBT_IP is not set
CONFIG_BRIDGE_EBT_IP6=m
CONFIG_BRIDGE_EBT_LIMIT=m
CONFIG_BRIDGE_EBT_MARK=m
CONFIG_BRIDGE_EBT_PKTTYPE=m
CONFIG_BRIDGE_EBT_STP=m
CONFIG_BRIDGE_EBT_VLAN=m
CONFIG_BRIDGE_EBT_ARPREPLY=m
CONFIG_BRIDGE_EBT_DNAT=m
CONFIG_BRIDGE_EBT_MARK_T=m
# CONFIG_BRIDGE_EBT_REDIRECT is not set
CONFIG_BRIDGE_EBT_SNAT=m
# CONFIG_BRIDGE_EBT_LOG is not set
CONFIG_BRIDGE_EBT_NFLOG=m
CONFIG_BPFILTER=y
# CONFIG_BPFILTER_UMH is not set
# CONFIG_IP_DCCP is not set
CONFIG_IP_SCTP=m
CONFIG_SCTP_DBG_OBJCNT=y
CONFIG_SCTP_DEFAULT_COOKIE_HMAC_MD5=y
# CONFIG_SCTP_DEFAULT_COOKIE_HMAC_SHA1 is not set
# CONFIG_SCTP_DEFAULT_COOKIE_HMAC_NONE is not set
CONFIG_SCTP_COOKIE_HMAC_MD5=y
CONFIG_SCTP_COOKIE_HMAC_SHA1=y
CONFIG_INET_SCTP_DIAG=m
# CONFIG_RDS is not set
# CONFIG_TIPC is not set
# CONFIG_ATM is not set
CONFIG_L2TP=m
# CONFIG_L2TP_DEBUGFS is not set
# CONFIG_L2TP_V3 is not set
CONFIG_STP=m
CONFIG_MRP=m
CONFIG_BRIDGE=m
CONFIG_BRIDGE_IGMP_SNOOPING=y
# CONFIG_BRIDGE_VLAN_FILTERING is not set
CONFIG_BRIDGE_MRP=y
CONFIG_HAVE_NET_DSA=y
CONFIG_NET_DSA=m
CONFIG_NET_DSA_TAG_8021Q=m
# CONFIG_NET_DSA_TAG_AR9331 is not set
CONFIG_NET_DSA_TAG_BRCM_COMMON=m
CONFIG_NET_DSA_TAG_BRCM=m
CONFIG_NET_DSA_TAG_BRCM_PREPEND=m
CONFIG_NET_DSA_TAG_GSWIP=m
CONFIG_NET_DSA_TAG_DSA=m
CONFIG_NET_DSA_TAG_EDSA=m
CONFIG_NET_DSA_TAG_MTK=m
CONFIG_NET_DSA_TAG_KSZ=m
CONFIG_NET_DSA_TAG_RTL4_A=m
# CONFIG_NET_DSA_TAG_OCELOT is not set
CONFIG_NET_DSA_TAG_QCA=m
CONFIG_NET_DSA_TAG_LAN9303=m
CONFIG_NET_DSA_TAG_SJA1105=m
CONFIG_NET_DSA_TAG_TRAILER=m
CONFIG_VLAN_8021Q=m
# CONFIG_VLAN_8021Q_GVRP is not set
CONFIG_VLAN_8021Q_MVRP=y
CONFIG_DECNET=y
# CONFIG_DECNET_ROUTER is not set
CONFIG_LLC=y
CONFIG_LLC2=y
CONFIG_ATALK=m
# CONFIG_DEV_APPLETALK is not set
CONFIG_X25=y
CONFIG_LAPB=m
CONFIG_PHONET=m
CONFIG_6LOWPAN=m
# CONFIG_6LOWPAN_DEBUGFS is not set
CONFIG_6LOWPAN_NHC=m
CONFIG_6LOWPAN_NHC_DEST=m
# CONFIG_6LOWPAN_NHC_FRAGMENT is not set
CONFIG_6LOWPAN_NHC_HOP=m
CONFIG_6LOWPAN_NHC_IPV6=m
CONFIG_6LOWPAN_NHC_MOBILITY=m
CONFIG_6LOWPAN_NHC_ROUTING=m
CONFIG_6LOWPAN_NHC_UDP=m
CONFIG_6LOWPAN_GHC_EXT_HDR_HOP=m
CONFIG_6LOWPAN_GHC_UDP=m
# CONFIG_6LOWPAN_GHC_ICMPV6 is not set
# CONFIG_6LOWPAN_GHC_EXT_HDR_DEST is not set
CONFIG_6LOWPAN_GHC_EXT_HDR_FRAG=m
CONFIG_6LOWPAN_GHC_EXT_HDR_ROUTE=m
CONFIG_IEEE802154=m
# CONFIG_IEEE802154_NL802154_EXPERIMENTAL is not set
CONFIG_IEEE802154_SOCKET=m
# CONFIG_IEEE802154_6LOWPAN is not set
CONFIG_MAC802154=m
CONFIG_NET_SCHED=y

#
# Queueing/Scheduling
#
CONFIG_NET_SCH_CBQ=y
CONFIG_NET_SCH_HTB=m
# CONFIG_NET_SCH_HFSC is not set
# CONFIG_NET_SCH_PRIO is not set
CONFIG_NET_SCH_MULTIQ=m
# CONFIG_NET_SCH_RED is not set
CONFIG_NET_SCH_SFB=m
# CONFIG_NET_SCH_SFQ is not set
CONFIG_NET_SCH_TEQL=y
CONFIG_NET_SCH_TBF=y
# CONFIG_NET_SCH_CBS is not set
CONFIG_NET_SCH_ETF=y
CONFIG_NET_SCH_TAPRIO=y
CONFIG_NET_SCH_GRED=y
CONFIG_NET_SCH_DSMARK=m
CONFIG_NET_SCH_NETEM=y
# CONFIG_NET_SCH_DRR is not set
CONFIG_NET_SCH_MQPRIO=m
CONFIG_NET_SCH_SKBPRIO=y
CONFIG_NET_SCH_CHOKE=y
CONFIG_NET_SCH_QFQ=m
# CONFIG_NET_SCH_CODEL is not set
# CONFIG_NET_SCH_FQ_CODEL is not set
CONFIG_NET_SCH_CAKE=y
CONFIG_NET_SCH_FQ=y
# CONFIG_NET_SCH_HHF is not set
CONFIG_NET_SCH_PIE=y
# CONFIG_NET_SCH_FQ_PIE is not set
# CONFIG_NET_SCH_INGRESS is not set
CONFIG_NET_SCH_PLUG=m
CONFIG_NET_SCH_ETS=m
CONFIG_NET_SCH_DEFAULT=y
# CONFIG_DEFAULT_FQ is not set
CONFIG_DEFAULT_PFIFO_FAST=y
CONFIG_DEFAULT_NET_SCH="pfifo_fast"

#
# Classification
#
CONFIG_NET_CLS=y
CONFIG_NET_CLS_BASIC=y
CONFIG_NET_CLS_TCINDEX=y
# CONFIG_NET_CLS_ROUTE4 is not set
CONFIG_NET_CLS_FW=y
# CONFIG_NET_CLS_U32 is not set
CONFIG_NET_CLS_RSVP=m
CONFIG_NET_CLS_RSVP6=y
CONFIG_NET_CLS_FLOW=y
# CONFIG_NET_CLS_CGROUP is not set
# CONFIG_NET_CLS_BPF is not set
# CONFIG_NET_CLS_FLOWER is not set
# CONFIG_NET_CLS_MATCHALL is not set
CONFIG_NET_EMATCH=y
CONFIG_NET_EMATCH_STACK=32
# CONFIG_NET_EMATCH_CMP is not set
CONFIG_NET_EMATCH_NBYTE=y
CONFIG_NET_EMATCH_U32=m
CONFIG_NET_EMATCH_META=m
CONFIG_NET_EMATCH_TEXT=m
# CONFIG_NET_EMATCH_IPSET is not set
CONFIG_NET_EMATCH_IPT=m
CONFIG_NET_CLS_ACT=y
CONFIG_NET_ACT_POLICE=m
CONFIG_NET_ACT_GACT=m
# CONFIG_GACT_PROB is not set
CONFIG_NET_ACT_MIRRED=y
CONFIG_NET_ACT_SAMPLE=y
CONFIG_NET_ACT_NAT=m
CONFIG_NET_ACT_PEDIT=m
CONFIG_NET_ACT_SIMP=y
CONFIG_NET_ACT_SKBEDIT=m
CONFIG_NET_ACT_CSUM=m
CONFIG_NET_ACT_MPLS=m
CONFIG_NET_ACT_VLAN=m
CONFIG_NET_ACT_BPF=y
# CONFIG_NET_ACT_SKBMOD is not set
CONFIG_NET_ACT_IFE=m
CONFIG_NET_ACT_TUNNEL_KEY=m
# CONFIG_NET_ACT_GATE is not set
# CONFIG_NET_IFE_SKBMARK is not set
CONFIG_NET_IFE_SKBPRIO=m
CONFIG_NET_IFE_SKBTCINDEX=m
# CONFIG_NET_TC_SKB_EXT is not set
CONFIG_NET_SCH_FIFO=y
CONFIG_DCB=y
CONFIG_DNS_RESOLVER=m
CONFIG_BATMAN_ADV=m
# CONFIG_BATMAN_ADV_BATMAN_V is not set
CONFIG_BATMAN_ADV_BLA=y
# CONFIG_BATMAN_ADV_DAT is not set
# CONFIG_BATMAN_ADV_NC is not set
# CONFIG_BATMAN_ADV_MCAST is not set
# CONFIG_BATMAN_ADV_DEBUGFS is not set
# CONFIG_BATMAN_ADV_DEBUG is not set
CONFIG_BATMAN_ADV_SYSFS=y
CONFIG_BATMAN_ADV_TRACING=y
CONFIG_OPENVSWITCH=m
CONFIG_OPENVSWITCH_GRE=m
CONFIG_OPENVSWITCH_VXLAN=m
CONFIG_VSOCKETS=m
CONFIG_VSOCKETS_DIAG=m
CONFIG_VSOCKETS_LOOPBACK=m
CONFIG_VIRTIO_VSOCKETS=m
CONFIG_VIRTIO_VSOCKETS_COMMON=m
CONFIG_NETLINK_DIAG=y
CONFIG_MPLS=y
CONFIG_NET_MPLS_GSO=y
# CONFIG_MPLS_ROUTING is not set
CONFIG_NET_NSH=m
# CONFIG_HSR is not set
CONFIG_NET_SWITCHDEV=y
# CONFIG_NET_L3_MASTER_DEV is not set
CONFIG_QRTR=m
CONFIG_QRTR_TUN=m
# CONFIG_QRTR_MHI is not set
# CONFIG_NET_NCSI is not set
CONFIG_RPS=y
CONFIG_RFS_ACCEL=y
CONFIG_XPS=y
# CONFIG_CGROUP_NET_PRIO is not set
# CONFIG_CGROUP_NET_CLASSID is not set
CONFIG_NET_RX_BUSY_POLL=y
CONFIG_BQL=y
CONFIG_BPF_JIT=y
CONFIG_NET_FLOW_LIMIT=y

#
# Network testing
#
CONFIG_NET_PKTGEN=m
CONFIG_NET_DROP_MONITOR=m
# end of Network testing
# end of Networking options

CONFIG_HAMRADIO=y

#
# Packet Radio protocols
#
CONFIG_AX25=y
CONFIG_AX25_DAMA_SLAVE=y
CONFIG_NETROM=m
# CONFIG_ROSE is not set

#
# AX.25 network device drivers
#
# CONFIG_MKISS is not set
# CONFIG_6PACK is not set
# CONFIG_BPQETHER is not set
CONFIG_BAYCOM_SER_FDX=m
CONFIG_BAYCOM_SER_HDX=y
CONFIG_BAYCOM_PAR=m
CONFIG_YAM=y
# end of AX.25 network device drivers

# CONFIG_CAN is not set
CONFIG_BT=m
# CONFIG_BT_BREDR is not set
# CONFIG_BT_LE is not set
CONFIG_BT_LEDS=y
CONFIG_BT_MSFTEXT=y
CONFIG_BT_DEBUGFS=y
# CONFIG_BT_SELFTEST is not set

#
# Bluetooth device drivers
#
CONFIG_BT_HCIBTSDIO=m
# CONFIG_BT_HCIUART is not set
CONFIG_BT_HCIVHCI=m
# CONFIG_BT_MRVL is not set
CONFIG_BT_MTKSDIO=m
# end of Bluetooth device drivers

CONFIG_AF_RXRPC=y
# CONFIG_AF_RXRPC_INJECT_LOSS is not set
CONFIG_AF_RXRPC_DEBUG=y
CONFIG_RXKAD=y
CONFIG_AF_KCM=y
CONFIG_STREAM_PARSER=y
CONFIG_WIRELESS=y
CONFIG_CFG80211=m
# CONFIG_NL80211_TESTMODE is not set
# CONFIG_CFG80211_DEVELOPER_WARNINGS is not set
CONFIG_CFG80211_REQUIRE_SIGNED_REGDB=y
CONFIG_CFG80211_USE_KERNEL_REGDB_KEYS=y
# CONFIG_CFG80211_DEFAULT_PS is not set
# CONFIG_CFG80211_DEBUGFS is not set
CONFIG_CFG80211_CRDA_SUPPORT=y
# CONFIG_CFG80211_WEXT is not set
CONFIG_MAC80211=m
CONFIG_MAC80211_HAS_RC=y
CONFIG_MAC80211_RC_MINSTREL=y
CONFIG_MAC80211_RC_DEFAULT_MINSTREL=y
CONFIG_MAC80211_RC_DEFAULT="minstrel_ht"
# CONFIG_MAC80211_MESH is not set
CONFIG_MAC80211_LEDS=y
CONFIG_MAC80211_DEBUGFS=y
# CONFIG_MAC80211_MESSAGE_TRACING is not set
CONFIG_MAC80211_DEBUG_MENU=y
# CONFIG_MAC80211_NOINLINE is not set
CONFIG_MAC80211_VERBOSE_DEBUG=y
CONFIG_MAC80211_MLME_DEBUG=y
CONFIG_MAC80211_STA_DEBUG=y
# CONFIG_MAC80211_HT_DEBUG is not set
# CONFIG_MAC80211_OCB_DEBUG is not set
# CONFIG_MAC80211_IBSS_DEBUG is not set
# CONFIG_MAC80211_PS_DEBUG is not set
# CONFIG_MAC80211_TDLS_DEBUG is not set
CONFIG_MAC80211_DEBUG_COUNTERS=y
CONFIG_MAC80211_STA_HASH_MAX_SIZE=0
# CONFIG_WIMAX is not set
CONFIG_RFKILL=m
CONFIG_RFKILL_LEDS=y
CONFIG_RFKILL_INPUT=y
CONFIG_RFKILL_GPIO=m
CONFIG_NET_9P=y
CONFIG_NET_9P_VIRTIO=m
CONFIG_NET_9P_RDMA=m
CONFIG_NET_9P_DEBUG=y
# CONFIG_CAIF is not set
CONFIG_CEPH_LIB=m
CONFIG_CEPH_LIB_PRETTYDEBUG=y
CONFIG_CEPH_LIB_USE_DNS_RESOLVER=y
CONFIG_NFC=m
CONFIG_NFC_DIGITAL=m
CONFIG_NFC_NCI=m
CONFIG_NFC_NCI_UART=m
CONFIG_NFC_HCI=m
CONFIG_NFC_SHDLC=y

#
# Near Field Communication (NFC) devices
#
# CONFIG_NFC_SIM is not set
CONFIG_NFC_FDP=m
CONFIG_NFC_FDP_I2C=m
# CONFIG_NFC_PN544_I2C is not set
# CONFIG_NFC_PN533_I2C is not set
CONFIG_NFC_MICROREAD=m
CONFIG_NFC_MICROREAD_I2C=m
# CONFIG_NFC_MRVL_UART is not set
CONFIG_NFC_ST21NFCA=m
CONFIG_NFC_ST21NFCA_I2C=m
CONFIG_NFC_ST_NCI=m
CONFIG_NFC_ST_NCI_I2C=m
CONFIG_NFC_NXP_NCI=m
# CONFIG_NFC_NXP_NCI_I2C is not set
CONFIG_NFC_S3FWRN5=m
CONFIG_NFC_S3FWRN5_I2C=m
# end of Near Field Communication (NFC) devices

CONFIG_PSAMPLE=y
CONFIG_NET_IFE=m
CONFIG_LWTUNNEL=y
CONFIG_LWTUNNEL_BPF=y
CONFIG_DST_CACHE=y
CONFIG_GRO_CELLS=y
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

# CONFIG_PCCARD is not set
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
CONFIG_FW_LOADER_USER_HELPER_FALLBACK=y
# CONFIG_FW_LOADER_COMPRESS is not set
# end of Firmware loader

CONFIG_ALLOW_DEV_COREDUMP=y
# CONFIG_DEBUG_DRIVER is not set
# CONFIG_DEBUG_DEVRES is not set
# CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
# CONFIG_PM_QOS_KUNIT_TEST is not set
CONFIG_TEST_ASYNC_DRIVER_PROBE=m
# CONFIG_KUNIT_DRIVER_PE_TEST is not set
CONFIG_GENERIC_CPU_AUTOPROBE=y
CONFIG_GENERIC_CPU_VULNERABILITIES=y
CONFIG_REGMAP=y
CONFIG_REGMAP_I2C=y
CONFIG_REGMAP_SLIMBUS=m
CONFIG_REGMAP_SPMI=y
CONFIG_REGMAP_MMIO=y
CONFIG_REGMAP_IRQ=y
CONFIG_REGMAP_SCCB=m
CONFIG_DMA_SHARED_BUFFER=y
CONFIG_DMA_FENCE_TRACE=y
# end of Generic Driver Options

#
# Bus devices
#
CONFIG_SIMPLE_PM_BUS=y
CONFIG_MHI_BUS=m
# end of Bus devices

CONFIG_CONNECTOR=y
CONFIG_PROC_EVENTS=y
CONFIG_GNSS=m
CONFIG_MTD=y
CONFIG_MTD_TESTS=m

#
# Partition parsers
#
CONFIG_MTD_AR7_PARTS=y
CONFIG_MTD_CMDLINE_PARTS=y
CONFIG_MTD_OF_PARTS=m
CONFIG_MTD_REDBOOT_PARTS=m
CONFIG_MTD_REDBOOT_DIRECTORY_BLOCK=-1
# CONFIG_MTD_REDBOOT_PARTS_UNALLOCATED is not set
CONFIG_MTD_REDBOOT_PARTS_READONLY=y
# end of Partition parsers

#
# User Modules And Translation Layers
#
CONFIG_MTD_BLKDEVS=y
CONFIG_MTD_BLOCK=y
CONFIG_FTL=y
CONFIG_NFTL=y
# CONFIG_NFTL_RW is not set
# CONFIG_INFTL is not set
# CONFIG_RFD_FTL is not set
CONFIG_SSFDC=m
# CONFIG_SM_FTL is not set
CONFIG_MTD_OOPS=m
CONFIG_MTD_PSTORE=m
CONFIG_MTD_SWAP=m
# CONFIG_MTD_PARTITIONED_MASTER is not set

#
# RAM/ROM/Flash chip drivers
#
CONFIG_MTD_CFI=y
# CONFIG_MTD_JEDECPROBE is not set
CONFIG_MTD_GEN_PROBE=y
CONFIG_MTD_CFI_ADV_OPTIONS=y
CONFIG_MTD_CFI_NOSWAP=y
# CONFIG_MTD_CFI_BE_BYTE_SWAP is not set
# CONFIG_MTD_CFI_LE_BYTE_SWAP is not set
CONFIG_MTD_CFI_GEOMETRY=y
CONFIG_MTD_MAP_BANK_WIDTH_1=y
CONFIG_MTD_MAP_BANK_WIDTH_2=y
# CONFIG_MTD_MAP_BANK_WIDTH_4 is not set
CONFIG_MTD_MAP_BANK_WIDTH_8=y
# CONFIG_MTD_MAP_BANK_WIDTH_16 is not set
# CONFIG_MTD_MAP_BANK_WIDTH_32 is not set
CONFIG_MTD_CFI_I1=y
# CONFIG_MTD_CFI_I2 is not set
# CONFIG_MTD_CFI_I4 is not set
CONFIG_MTD_CFI_I8=y
CONFIG_MTD_OTP=y
CONFIG_MTD_CFI_INTELEXT=m
CONFIG_MTD_CFI_AMDSTD=y
CONFIG_MTD_CFI_STAA=y
CONFIG_MTD_CFI_UTIL=y
CONFIG_MTD_RAM=m
# CONFIG_MTD_ROM is not set
# CONFIG_MTD_ABSENT is not set
# end of RAM/ROM/Flash chip drivers

#
# Mapping drivers for chip access
#
CONFIG_MTD_COMPLEX_MAPPINGS=y
CONFIG_MTD_PHYSMAP=m
# CONFIG_MTD_PHYSMAP_COMPAT is not set
CONFIG_MTD_PHYSMAP_OF=y
# CONFIG_MTD_PHYSMAP_VERSATILE is not set
CONFIG_MTD_PHYSMAP_GEMINI=y
# CONFIG_MTD_PHYSMAP_GPIO_ADDR is not set
CONFIG_MTD_SBC_GXX=m
# CONFIG_MTD_PCI is not set
# CONFIG_MTD_INTEL_VR_NOR is not set
CONFIG_MTD_PLATRAM=m
# end of Mapping drivers for chip access

#
# Self-contained MTD device drivers
#
# CONFIG_MTD_PMC551 is not set
# CONFIG_MTD_SLRAM is not set
CONFIG_MTD_PHRAM=m
CONFIG_MTD_MTDRAM=y
CONFIG_MTDRAM_TOTAL_SIZE=4096
CONFIG_MTDRAM_ERASE_SIZE=128
CONFIG_MTD_BLOCK2MTD=y

#
# Disk-On-Chip Device Drivers
#
# CONFIG_MTD_DOCG3 is not set
# end of Self-contained MTD device drivers

#
# NAND
#
CONFIG_MTD_NAND_CORE=m
CONFIG_MTD_ONENAND=m
CONFIG_MTD_ONENAND_VERIFY_WRITE=y
CONFIG_MTD_ONENAND_GENERIC=m
CONFIG_MTD_ONENAND_OTP=y
# CONFIG_MTD_ONENAND_2X_PROGRAM is not set
CONFIG_MTD_NAND_ECC_SW_HAMMING=m
CONFIG_MTD_NAND_ECC_SW_HAMMING_SMC=y
CONFIG_MTD_RAW_NAND=m
# CONFIG_MTD_NAND_ECC_SW_BCH is not set

#
# Raw/parallel NAND flash controllers
#
# CONFIG_MTD_NAND_DENALI_PCI is not set
# CONFIG_MTD_NAND_DENALI_DT is not set
# CONFIG_MTD_NAND_CAFE is not set
# CONFIG_MTD_NAND_MXIC is not set
CONFIG_MTD_NAND_GPIO=m
CONFIG_MTD_NAND_PLATFORM=m
CONFIG_MTD_NAND_CADENCE=m
CONFIG_MTD_NAND_ARASAN=m

#
# Misc
#
# CONFIG_MTD_NAND_NANDSIM is not set
# CONFIG_MTD_NAND_RICOH is not set
CONFIG_MTD_NAND_DISKONCHIP=m
# CONFIG_MTD_NAND_DISKONCHIP_PROBE_ADVANCED is not set
CONFIG_MTD_NAND_DISKONCHIP_PROBE_ADDRESS=0
CONFIG_MTD_NAND_DISKONCHIP_BBTWRITE=y
# end of NAND

#
# LPDDR & LPDDR2 PCM memory drivers
#
CONFIG_MTD_LPDDR=m
CONFIG_MTD_QINFO_PROBE=m
# end of LPDDR & LPDDR2 PCM memory drivers

CONFIG_MTD_UBI=m
CONFIG_MTD_UBI_WL_THRESHOLD=4096
CONFIG_MTD_UBI_BEB_LIMIT=20
CONFIG_MTD_UBI_FASTMAP=y
CONFIG_MTD_UBI_GLUEBI=m
CONFIG_MTD_UBI_BLOCK=y
CONFIG_MTD_HYPERBUS=y
CONFIG_DTC=y
CONFIG_OF=y
# CONFIG_OF_UNITTEST is not set
CONFIG_OF_FLATTREE=y
CONFIG_OF_KOBJ=y
CONFIG_OF_DYNAMIC=y
CONFIG_OF_ADDRESS=y
CONFIG_OF_IRQ=y
CONFIG_OF_NET=y
CONFIG_OF_MDIO=y
CONFIG_OF_RESOLVE=y
CONFIG_OF_OVERLAY=y
CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
# CONFIG_PARPORT_SERIAL is not set
CONFIG_PARPORT_PC_FIFO=y
CONFIG_PARPORT_PC_SUPERIO=y
CONFIG_PARPORT_AX88796=m
# CONFIG_PARPORT_1284 is not set
CONFIG_PARPORT_NOT_PC=y
CONFIG_PNP=y
# CONFIG_PNP_DEBUG_MESSAGES is not set

#
# Protocols
#
CONFIG_PNPACPI=y
CONFIG_BLK_DEV=y
# CONFIG_BLK_DEV_NULL_BLK is not set
# CONFIG_BLK_DEV_FD is not set
# CONFIG_PARIDE is not set
# CONFIG_BLK_DEV_PCIESSD_MTIP32XX is not set
# CONFIG_ZRAM is not set
# CONFIG_BLK_DEV_UMEM is not set
# CONFIG_BLK_DEV_LOOP is not set
# CONFIG_BLK_DEV_DRBD is not set
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_SKD is not set
# CONFIG_BLK_DEV_SX8 is not set
# CONFIG_BLK_DEV_RAM is not set
# CONFIG_CDROM_PKTCDVD is not set
# CONFIG_ATA_OVER_ETH is not set
# CONFIG_VIRTIO_BLK is not set
# CONFIG_BLK_DEV_RBD is not set
# CONFIG_BLK_DEV_RSXX is not set
# CONFIG_BLK_DEV_RNBD_CLIENT is not set

#
# NVME Support
#
CONFIG_NVME_CORE=y
# CONFIG_BLK_DEV_NVME is not set
# CONFIG_NVME_MULTIPATH is not set
CONFIG_NVME_HWMON=y
CONFIG_NVME_FABRICS=y
CONFIG_NVME_RDMA=m
CONFIG_NVME_FC=m
CONFIG_NVME_TARGET=y
# CONFIG_NVME_TARGET_PASSTHRU is not set
CONFIG_NVME_TARGET_LOOP=y
# CONFIG_NVME_TARGET_RDMA is not set
CONFIG_NVME_TARGET_FC=m
# CONFIG_NVME_TARGET_FCLOOP is not set
# CONFIG_NVME_TARGET_TCP is not set
# end of NVME Support

#
# Misc devices
#
CONFIG_SENSORS_LIS3LV02D=m
CONFIG_AD525X_DPOT=y
CONFIG_AD525X_DPOT_I2C=y
# CONFIG_DUMMY_IRQ is not set
# CONFIG_IBM_ASM is not set
# CONFIG_PHANTOM is not set
# CONFIG_TIFM_CORE is not set
CONFIG_ICS932S401=y
CONFIG_ENCLOSURE_SERVICES=m
# CONFIG_HP_ILO is not set
# CONFIG_APDS9802ALS is not set
CONFIG_ISL29003=y
CONFIG_ISL29020=m
CONFIG_SENSORS_TSL2550=y
# CONFIG_SENSORS_BH1770 is not set
CONFIG_SENSORS_APDS990X=m
CONFIG_HMC6352=m
CONFIG_DS1682=y
CONFIG_SRAM=y
# CONFIG_PCI_ENDPOINT_TEST is not set
CONFIG_XILINX_SDFEC=m
# CONFIG_PVPANIC is not set
# CONFIG_C2PORT is not set

#
# EEPROM support
#
# CONFIG_EEPROM_AT24 is not set
CONFIG_EEPROM_LEGACY=m
CONFIG_EEPROM_MAX6875=m
CONFIG_EEPROM_93CX6=m
# CONFIG_EEPROM_IDT_89HPESX is not set
# CONFIG_EEPROM_EE1004 is not set
# end of EEPROM support

# CONFIG_CB710_CORE is not set

#
# Texas Instruments shared transport line discipline
#
# CONFIG_TI_ST is not set
# end of Texas Instruments shared transport line discipline

# CONFIG_SENSORS_LIS3_I2C is not set
CONFIG_ALTERA_STAPL=y
# CONFIG_INTEL_MEI is not set
# CONFIG_INTEL_MEI_ME is not set
# CONFIG_INTEL_MEI_TXE is not set
# CONFIG_VMWARE_VMCI is not set

#
# Intel MIC & related support
#
# CONFIG_INTEL_MIC_BUS is not set
# CONFIG_SCIF_BUS is not set
CONFIG_VOP_BUS=y
# CONFIG_VOP is not set
# end of Intel MIC & related support

# CONFIG_GENWQE is not set
CONFIG_ECHO=y
# CONFIG_MISC_ALCOR_PCI is not set
# CONFIG_MISC_RTSX_PCI is not set
# CONFIG_HABANA_AI is not set
# end of Misc devices

CONFIG_HAVE_IDE=y
# CONFIG_IDE is not set

#
# SCSI device support
#
CONFIG_SCSI_MOD=y
# CONFIG_RAID_ATTRS is not set
CONFIG_SCSI=y
CONFIG_SCSI_DMA=y
CONFIG_SCSI_NETLINK=y
# CONFIG_SCSI_PROC_FS is not set

#
# SCSI support type (disk, tape, CD-ROM)
#
# CONFIG_BLK_DEV_SD is not set
CONFIG_CHR_DEV_ST=y
# CONFIG_BLK_DEV_SR is not set
# CONFIG_CHR_DEV_SG is not set
CONFIG_CHR_DEV_SCH=y
CONFIG_SCSI_ENCLOSURE=m
CONFIG_SCSI_CONSTANTS=y
# CONFIG_SCSI_LOGGING is not set
CONFIG_SCSI_SCAN_ASYNC=y

#
# SCSI Transports
#
CONFIG_SCSI_SPI_ATTRS=m
CONFIG_SCSI_FC_ATTRS=y
CONFIG_SCSI_ISCSI_ATTRS=y
CONFIG_SCSI_SAS_ATTRS=y
CONFIG_SCSI_SAS_LIBSAS=y
# CONFIG_SCSI_SAS_ATA is not set
CONFIG_SCSI_SAS_HOST_SMP=y
CONFIG_SCSI_SRP_ATTRS=m
# end of SCSI Transports

CONFIG_SCSI_LOWLEVEL=y
CONFIG_ISCSI_TCP=m
CONFIG_ISCSI_BOOT_SYSFS=y
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
# CONFIG_SCSI_MPT3SAS is not set
# CONFIG_SCSI_MPT2SAS is not set
# CONFIG_SCSI_SMARTPQI is not set
CONFIG_SCSI_UFSHCD=y
# CONFIG_SCSI_UFSHCD_PCI is not set
CONFIG_SCSI_UFSHCD_PLATFORM=y
# CONFIG_SCSI_UFS_CDNS_PLATFORM is not set
CONFIG_SCSI_UFS_DWC_TC_PLATFORM=m
# CONFIG_SCSI_UFS_BSG is not set
# CONFIG_SCSI_UFS_CRYPTO is not set
# CONFIG_SCSI_HPTIOP is not set
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_MYRB is not set
# CONFIG_SCSI_MYRS is not set
# CONFIG_VMWARE_PVSCSI is not set
# CONFIG_LIBFC is not set
# CONFIG_SCSI_SNIC is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_FDOMAIN_PCI is not set
# CONFIG_SCSI_GDTH is not set
# CONFIG_SCSI_ISCI is not set
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INITIO is not set
# CONFIG_SCSI_INIA100 is not set
CONFIG_SCSI_PPA=m
CONFIG_SCSI_IMM=m
CONFIG_SCSI_IZIP_EPP16=y
CONFIG_SCSI_IZIP_SLOW_CTR=y
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
CONFIG_SCSI_VIRTIO=m
# CONFIG_SCSI_CHELSIO_FCOE is not set
# CONFIG_SCSI_DH is not set
# end of SCSI device support

CONFIG_ATA=y
CONFIG_SATA_HOST=y
# CONFIG_ATA_VERBOSE_ERROR is not set
CONFIG_ATA_FORCE=y
# CONFIG_ATA_ACPI is not set
CONFIG_SATA_PMP=y

#
# Controllers with non-SFF native interface
#
# CONFIG_SATA_AHCI is not set
CONFIG_SATA_AHCI_PLATFORM=m
# CONFIG_AHCI_CEVA is not set
CONFIG_AHCI_QORIQ=m
# CONFIG_SATA_INIC162X is not set
# CONFIG_SATA_ACARD_AHCI is not set
# CONFIG_SATA_SIL24 is not set
# CONFIG_ATA_SFF is not set
# CONFIG_MD is not set
CONFIG_TARGET_CORE=m
CONFIG_TCM_IBLOCK=m
CONFIG_TCM_FILEIO=m
# CONFIG_TCM_PSCSI is not set
# CONFIG_TCM_USER2 is not set
CONFIG_LOOPBACK_TARGET=m
CONFIG_ISCSI_TARGET=m
CONFIG_SBP_TARGET=m
# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support
#
CONFIG_FIREWIRE=y
# CONFIG_FIREWIRE_OHCI is not set
CONFIG_FIREWIRE_SBP2=m
CONFIG_FIREWIRE_NET=m
# CONFIG_FIREWIRE_NOSY is not set
# end of IEEE 1394 (FireWire) support

# CONFIG_MACINTOSH_DRIVERS is not set
CONFIG_NETDEVICES=y
CONFIG_NET_CORE=y
# CONFIG_BONDING is not set
CONFIG_DUMMY=m
CONFIG_WIREGUARD=m
CONFIG_WIREGUARD_DEBUG=y
CONFIG_EQUALIZER=y
# CONFIG_NET_FC is not set
CONFIG_IFB=m
# CONFIG_NET_TEAM is not set
CONFIG_MACVLAN=y
CONFIG_MACVTAP=y
# CONFIG_IPVLAN is not set
CONFIG_VXLAN=y
# CONFIG_GENEVE is not set
CONFIG_BAREUDP=m
# CONFIG_GTP is not set
CONFIG_MACSEC=y
# CONFIG_NETCONSOLE is not set
# CONFIG_TUN is not set
CONFIG_TAP=y
# CONFIG_TUN_VNET_CROSS_LE is not set
CONFIG_VETH=m
CONFIG_VIRTIO_NET=m
CONFIG_NLMON=m
# CONFIG_ARCNET is not set

#
# Distributed Switch Architecture drivers
#
CONFIG_B53=m
# CONFIG_B53_MDIO_DRIVER is not set
CONFIG_B53_MMAP_DRIVER=m
CONFIG_B53_SRAB_DRIVER=m
CONFIG_B53_SERDES=m
CONFIG_NET_DSA_BCM_SF2=m
# CONFIG_NET_DSA_LOOP is not set
CONFIG_NET_DSA_LANTIQ_GSWIP=m
CONFIG_NET_DSA_MT7530=m
CONFIG_NET_DSA_MV88E6060=m
# CONFIG_NET_DSA_MICROCHIP_KSZ9477 is not set
# CONFIG_NET_DSA_MICROCHIP_KSZ8795 is not set
CONFIG_NET_DSA_MV88E6XXX=m
CONFIG_NET_DSA_MV88E6XXX_GLOBAL2=y
# CONFIG_NET_DSA_MV88E6XXX_PTP is not set
# CONFIG_NET_DSA_AR9331 is not set
CONFIG_NET_DSA_QCA8K=m
CONFIG_NET_DSA_REALTEK_SMI=m
CONFIG_NET_DSA_SMSC_LAN9303=m
# CONFIG_NET_DSA_SMSC_LAN9303_I2C is not set
CONFIG_NET_DSA_SMSC_LAN9303_MDIO=m
# CONFIG_NET_DSA_VITESSE_VSC73XX_PLATFORM is not set
# end of Distributed Switch Architecture drivers

CONFIG_ETHERNET=y
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
CONFIG_NET_VENDOR_AURORA=y
# CONFIG_AURORA_NB8800 is not set
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
# CONFIG_CAVIUM_PTP is not set
# CONFIG_LIQUIDIO is not set
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
# CONFIG_DNET is not set
CONFIG_NET_VENDOR_DEC=y
# CONFIG_NET_TULIP is not set
CONFIG_NET_VENDOR_DLINK=y
# CONFIG_DL2K is not set
# CONFIG_SUNDANCE is not set
CONFIG_NET_VENDOR_EMULEX=y
# CONFIG_BE2NET is not set
CONFIG_NET_VENDOR_EZCHIP=y
# CONFIG_EZCHIP_NPS_MANAGEMENT_ENET is not set
CONFIG_NET_VENDOR_GOOGLE=y
CONFIG_NET_VENDOR_HUAWEI=y
CONFIG_NET_VENDOR_I825XX=y
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
CONFIG_NET_VENDOR_MARVELL=y
# CONFIG_MVMDIO is not set
# CONFIG_SKGE is not set
# CONFIG_SKY2 is not set
CONFIG_NET_VENDOR_MELLANOX=y
# CONFIG_MLX4_EN is not set
# CONFIG_MLX5_CORE is not set
# CONFIG_MLXSW_CORE is not set
# CONFIG_MLXFW is not set
CONFIG_NET_VENDOR_MICREL=y
# CONFIG_KS8842 is not set
# CONFIG_KS8851_MLL is not set
# CONFIG_KSZ884X_PCI is not set
CONFIG_NET_VENDOR_MICROCHIP=y
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
# CONFIG_R8169 is not set
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
CONFIG_NET_SB1000=m
CONFIG_MDIO_DEVICE=y
CONFIG_MDIO_BUS=y
CONFIG_MDIO_DEVRES=y
CONFIG_MDIO_BCM_UNIMAC=m
CONFIG_MDIO_BITBANG=y
CONFIG_MDIO_BUS_MUX=y
CONFIG_MDIO_BUS_MUX_GPIO=y
# CONFIG_MDIO_BUS_MUX_MMIOREG is not set
# CONFIG_MDIO_BUS_MUX_MULTIPLEXER is not set
# CONFIG_MDIO_GPIO is not set
CONFIG_MDIO_HISI_FEMAC=m
CONFIG_MDIO_I2C=m
CONFIG_MDIO_IPQ4019=y
CONFIG_MDIO_IPQ8064=m
CONFIG_MDIO_MSCC_MIIM=y
# CONFIG_MDIO_OCTEON is not set
# CONFIG_MDIO_THUNDER is not set
CONFIG_MDIO_XPCS=m
CONFIG_PHYLINK=m
CONFIG_PHYLIB=y
CONFIG_SWPHY=y
CONFIG_LED_TRIGGER_PHY=y

#
# MII PHY device drivers
#
CONFIG_SFP=m
CONFIG_ADIN_PHY=m
CONFIG_AMD_PHY=m
CONFIG_AQUANTIA_PHY=y
# CONFIG_AX88796B_PHY is not set
CONFIG_BCM7XXX_PHY=y
CONFIG_BCM87XX_PHY=y
CONFIG_BCM_NET_PHYLIB=y
CONFIG_BROADCOM_PHY=y
CONFIG_BCM54140_PHY=m
CONFIG_BCM84881_PHY=m
# CONFIG_CICADA_PHY is not set
CONFIG_CORTINA_PHY=y
CONFIG_DAVICOM_PHY=m
CONFIG_DP83822_PHY=m
CONFIG_DP83TC811_PHY=y
CONFIG_DP83848_PHY=m
CONFIG_DP83867_PHY=m
# CONFIG_DP83869_PHY is not set
CONFIG_FIXED_PHY=y
CONFIG_ICPLUS_PHY=m
# CONFIG_INTEL_XWAY_PHY is not set
# CONFIG_LSI_ET1011C_PHY is not set
# CONFIG_LXT_PHY is not set
CONFIG_MARVELL_PHY=y
# CONFIG_MARVELL_10G_PHY is not set
CONFIG_MICREL_PHY=m
CONFIG_MICROCHIP_PHY=m
# CONFIG_MICROCHIP_T1_PHY is not set
# CONFIG_MICROSEMI_PHY is not set
CONFIG_NATIONAL_PHY=m
CONFIG_NXP_TJA11XX_PHY=m
# CONFIG_AT803X_PHY is not set
# CONFIG_QSEMI_PHY is not set
CONFIG_REALTEK_PHY=m
# CONFIG_RENESAS_PHY is not set
# CONFIG_ROCKCHIP_PHY is not set
CONFIG_SMSC_PHY=m
# CONFIG_STE10XP is not set
CONFIG_TERANETICS_PHY=y
CONFIG_VITESSE_PHY=y
CONFIG_XILINX_GMII2RGMII=m
CONFIG_PLIP=m
# CONFIG_PPP is not set
CONFIG_SLIP=m
# CONFIG_SLIP_COMPRESSED is not set
CONFIG_SLIP_SMART=y
CONFIG_SLIP_MODE_SLIP6=y

#
# Host-side USB support is needed for USB Network Adapter support
#
# CONFIG_WLAN is not set

#
# Enable WiMAX (Networking options) to see the WiMAX drivers
#
CONFIG_WAN=y
# CONFIG_LANMEDIA is not set
CONFIG_HDLC=m
# CONFIG_HDLC_RAW is not set
CONFIG_HDLC_RAW_ETH=m
CONFIG_HDLC_CISCO=m
# CONFIG_HDLC_FR is not set
CONFIG_HDLC_PPP=m
CONFIG_HDLC_X25=m
# CONFIG_PCI200SYN is not set
# CONFIG_WANXL is not set
# CONFIG_PC300TOO is not set
# CONFIG_FARSYNC is not set
# CONFIG_DLCI is not set
CONFIG_LAPBETHER=m
# CONFIG_X25_ASY is not set
CONFIG_SBNI=y
CONFIG_SBNI_MULTILINE=y
CONFIG_IEEE802154_DRIVERS=m
# CONFIG_IEEE802154_FAKELB is not set
CONFIG_IEEE802154_HWSIM=m
# CONFIG_VMXNET3 is not set
CONFIG_FUJITSU_ES=y
# CONFIG_NETDEVSIM is not set
CONFIG_NET_FAILOVER=m
# CONFIG_ISDN is not set
CONFIG_NVM=y
CONFIG_NVM_PBLK=m
# CONFIG_NVM_PBLK_DEBUG is not set

#
# Input device support
#
CONFIG_INPUT=y
CONFIG_INPUT_LEDS=y
CONFIG_INPUT_FF_MEMLESS=y
CONFIG_INPUT_POLLDEV=y
CONFIG_INPUT_SPARSEKMAP=y
CONFIG_INPUT_MATRIXKMAP=y

#
# Userland interfaces
#
# CONFIG_INPUT_MOUSEDEV is not set
CONFIG_INPUT_JOYDEV=y
# CONFIG_INPUT_EVDEV is not set
CONFIG_INPUT_EVBUG=y

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
# CONFIG_KEYBOARD_ADC is not set
# CONFIG_KEYBOARD_ADP5520 is not set
# CONFIG_KEYBOARD_ADP5588 is not set
# CONFIG_KEYBOARD_ADP5589 is not set
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
# CONFIG_KEYBOARD_GOLDFISH_EVENTS is not set
# CONFIG_KEYBOARD_STOWAWAY is not set
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_IQS62X is not set
# CONFIG_KEYBOARD_OMAP4 is not set
# CONFIG_KEYBOARD_TC3589X is not set
# CONFIG_KEYBOARD_TM2_TOUCHKEY is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_CROS_EC is not set
# CONFIG_KEYBOARD_CAP11XX is not set
# CONFIG_KEYBOARD_BCM is not set
CONFIG_INPUT_MOUSE=y
# CONFIG_MOUSE_PS2 is not set
# CONFIG_MOUSE_SERIAL is not set
# CONFIG_MOUSE_APPLETOUCH is not set
# CONFIG_MOUSE_BCM5974 is not set
# CONFIG_MOUSE_CYAPA is not set
# CONFIG_MOUSE_ELAN_I2C is not set
CONFIG_MOUSE_VSXXXAA=m
CONFIG_MOUSE_GPIO=y
# CONFIG_MOUSE_SYNAPTICS_I2C is not set
# CONFIG_MOUSE_SYNAPTICS_USB is not set
CONFIG_INPUT_JOYSTICK=y
# CONFIG_JOYSTICK_ANALOG is not set
CONFIG_JOYSTICK_A3D=m
CONFIG_JOYSTICK_ADI=m
CONFIG_JOYSTICK_COBRA=y
CONFIG_JOYSTICK_GF2K=y
CONFIG_JOYSTICK_GRIP=y
CONFIG_JOYSTICK_GRIP_MP=y
CONFIG_JOYSTICK_GUILLEMOT=m
CONFIG_JOYSTICK_INTERACT=y
CONFIG_JOYSTICK_SIDEWINDER=m
CONFIG_JOYSTICK_TMDC=m
CONFIG_JOYSTICK_IFORCE=m
# CONFIG_JOYSTICK_IFORCE_232 is not set
# CONFIG_JOYSTICK_WARRIOR is not set
# CONFIG_JOYSTICK_MAGELLAN is not set
# CONFIG_JOYSTICK_SPACEORB is not set
# CONFIG_JOYSTICK_SPACEBALL is not set
CONFIG_JOYSTICK_STINGER=m
CONFIG_JOYSTICK_TWIDJOY=m
CONFIG_JOYSTICK_ZHENHUA=y
# CONFIG_JOYSTICK_DB9 is not set
CONFIG_JOYSTICK_GAMECON=m
# CONFIG_JOYSTICK_TURBOGRAFX is not set
# CONFIG_JOYSTICK_AS5011 is not set
# CONFIG_JOYSTICK_JOYDUMP is not set
# CONFIG_JOYSTICK_XPAD is not set
# CONFIG_JOYSTICK_PXRC is not set
# CONFIG_JOYSTICK_FSIA6B is not set
CONFIG_INPUT_TABLET=y
# CONFIG_TABLET_USB_ACECAD is not set
# CONFIG_TABLET_USB_AIPTEK is not set
# CONFIG_TABLET_USB_HANWANG is not set
# CONFIG_TABLET_USB_KBTAB is not set
# CONFIG_TABLET_USB_PEGASUS is not set
CONFIG_TABLET_SERIAL_WACOM4=y
CONFIG_INPUT_TOUCHSCREEN=y
CONFIG_TOUCHSCREEN_PROPERTIES=y
CONFIG_TOUCHSCREEN_AD7879=y
CONFIG_TOUCHSCREEN_AD7879_I2C=y
CONFIG_TOUCHSCREEN_ADC=y
CONFIG_TOUCHSCREEN_AR1021_I2C=y
CONFIG_TOUCHSCREEN_ATMEL_MXT=m
CONFIG_TOUCHSCREEN_ATMEL_MXT_T37=y
# CONFIG_TOUCHSCREEN_AUO_PIXCIR is not set
# CONFIG_TOUCHSCREEN_BU21013 is not set
CONFIG_TOUCHSCREEN_BU21029=y
CONFIG_TOUCHSCREEN_CHIPONE_ICN8318=y
# CONFIG_TOUCHSCREEN_CHIPONE_ICN8505 is not set
CONFIG_TOUCHSCREEN_CY8CTMA140=m
CONFIG_TOUCHSCREEN_CY8CTMG110=m
CONFIG_TOUCHSCREEN_CYTTSP_CORE=m
CONFIG_TOUCHSCREEN_CYTTSP_I2C=m
# CONFIG_TOUCHSCREEN_CYTTSP4_CORE is not set
CONFIG_TOUCHSCREEN_DA9052=y
# CONFIG_TOUCHSCREEN_DYNAPRO is not set
CONFIG_TOUCHSCREEN_HAMPSHIRE=y
CONFIG_TOUCHSCREEN_EETI=m
# CONFIG_TOUCHSCREEN_EGALAX is not set
CONFIG_TOUCHSCREEN_EGALAX_SERIAL=y
# CONFIG_TOUCHSCREEN_EXC3000 is not set
CONFIG_TOUCHSCREEN_FUJITSU=y
# CONFIG_TOUCHSCREEN_GOODIX is not set
CONFIG_TOUCHSCREEN_HIDEEP=m
CONFIG_TOUCHSCREEN_ILI210X=m
CONFIG_TOUCHSCREEN_S6SY761=m
# CONFIG_TOUCHSCREEN_GUNZE is not set
CONFIG_TOUCHSCREEN_EKTF2127=m
# CONFIG_TOUCHSCREEN_ELAN is not set
CONFIG_TOUCHSCREEN_ELO=y
# CONFIG_TOUCHSCREEN_WACOM_W8001 is not set
CONFIG_TOUCHSCREEN_WACOM_I2C=y
CONFIG_TOUCHSCREEN_MAX11801=m
CONFIG_TOUCHSCREEN_MCS5000=y
CONFIG_TOUCHSCREEN_MMS114=m
CONFIG_TOUCHSCREEN_MELFAS_MIP4=m
CONFIG_TOUCHSCREEN_MTOUCH=m
CONFIG_TOUCHSCREEN_IMX6UL_TSC=y
# CONFIG_TOUCHSCREEN_INEXIO is not set
CONFIG_TOUCHSCREEN_MK712=m
# CONFIG_TOUCHSCREEN_PENMOUNT is not set
# CONFIG_TOUCHSCREEN_EDT_FT5X06 is not set
CONFIG_TOUCHSCREEN_TOUCHRIGHT=y
CONFIG_TOUCHSCREEN_TOUCHWIN=m
CONFIG_TOUCHSCREEN_PIXCIR=m
CONFIG_TOUCHSCREEN_WDT87XX_I2C=y
# CONFIG_TOUCHSCREEN_WM831X is not set
# CONFIG_TOUCHSCREEN_USB_COMPOSITE is not set
CONFIG_TOUCHSCREEN_TOUCHIT213=m
CONFIG_TOUCHSCREEN_TSC_SERIO=m
CONFIG_TOUCHSCREEN_TSC200X_CORE=y
CONFIG_TOUCHSCREEN_TSC2004=y
# CONFIG_TOUCHSCREEN_TSC2007 is not set
CONFIG_TOUCHSCREEN_RM_TS=m
# CONFIG_TOUCHSCREEN_SILEAD is not set
CONFIG_TOUCHSCREEN_SIS_I2C=y
CONFIG_TOUCHSCREEN_ST1232=m
CONFIG_TOUCHSCREEN_STMFTS=m
CONFIG_TOUCHSCREEN_SX8654=y
# CONFIG_TOUCHSCREEN_TPS6507X is not set
CONFIG_TOUCHSCREEN_ZET6223=y
CONFIG_TOUCHSCREEN_ZFORCE=m
CONFIG_TOUCHSCREEN_COLIBRI_VF50=m
# CONFIG_TOUCHSCREEN_ROHM_BU21023 is not set
CONFIG_TOUCHSCREEN_IQS5XX=y
CONFIG_INPUT_MISC=y
CONFIG_INPUT_88PM80X_ONKEY=m
CONFIG_INPUT_AD714X=m
# CONFIG_INPUT_AD714X_I2C is not set
# CONFIG_INPUT_ATMEL_CAPTOUCH is not set
# CONFIG_INPUT_BMA150 is not set
CONFIG_INPUT_E3X0_BUTTON=m
CONFIG_INPUT_PCSPKR=y
# CONFIG_INPUT_MAX77650_ONKEY is not set
CONFIG_INPUT_MAX77693_HAPTIC=y
# CONFIG_INPUT_MAX8997_HAPTIC is not set
CONFIG_INPUT_MMA8450=y
CONFIG_INPUT_APANEL=y
CONFIG_INPUT_GPIO_BEEPER=y
CONFIG_INPUT_GPIO_DECODER=m
CONFIG_INPUT_GPIO_VIBRA=m
CONFIG_INPUT_ATLAS_BTNS=m
# CONFIG_INPUT_ATI_REMOTE2 is not set
# CONFIG_INPUT_KEYSPAN_REMOTE is not set
CONFIG_INPUT_KXTJ9=m
# CONFIG_INPUT_POWERMATE is not set
# CONFIG_INPUT_YEALINK is not set
# CONFIG_INPUT_CM109 is not set
CONFIG_INPUT_REGULATOR_HAPTIC=m
CONFIG_INPUT_RETU_PWRBUTTON=m
# CONFIG_INPUT_TPS65218_PWRBUTTON is not set
# CONFIG_INPUT_TWL6040_VIBRA is not set
CONFIG_INPUT_UINPUT=m
CONFIG_INPUT_PCF50633_PMU=m
CONFIG_INPUT_PCF8574=m
CONFIG_INPUT_PWM_BEEPER=m
# CONFIG_INPUT_PWM_VIBRA is not set
CONFIG_INPUT_GPIO_ROTARY_ENCODER=m
# CONFIG_INPUT_DA9052_ONKEY is not set
CONFIG_INPUT_WM831X_ON=m
CONFIG_INPUT_ADXL34X=m
# CONFIG_INPUT_ADXL34X_I2C is not set
CONFIG_INPUT_IQS269A=y
CONFIG_INPUT_CMA3000=m
CONFIG_INPUT_CMA3000_I2C=m
CONFIG_INPUT_IDEAPAD_SLIDEBAR=m
CONFIG_INPUT_DRV260X_HAPTICS=y
CONFIG_INPUT_DRV2665_HAPTICS=y
# CONFIG_INPUT_DRV2667_HAPTICS is not set
# CONFIG_RMI4_CORE is not set

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
CONFIG_SERIO_CT82C710=y
CONFIG_SERIO_PARKBD=m
# CONFIG_SERIO_PCIPS2 is not set
CONFIG_SERIO_LIBPS2=y
CONFIG_SERIO_RAW=m
CONFIG_SERIO_ALTERA_PS2=y
# CONFIG_SERIO_PS2MULT is not set
CONFIG_SERIO_ARC_PS2=y
CONFIG_SERIO_APBPS2=y
CONFIG_SERIO_GPIO_PS2=m
CONFIG_USERIO=m
CONFIG_GAMEPORT=y
CONFIG_GAMEPORT_NS558=y
# CONFIG_GAMEPORT_L4 is not set
# CONFIG_GAMEPORT_EMU10K1 is not set
# CONFIG_GAMEPORT_FM801 is not set
# end of Hardware I/O ports
# end of Input device support

#
# Character devices
#
CONFIG_TTY=y
CONFIG_VT=y
CONFIG_CONSOLE_TRANSLATIONS=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y
CONFIG_VT_HW_CONSOLE_BINDING=y
CONFIG_UNIX98_PTYS=y
# CONFIG_LEGACY_PTYS is not set
# CONFIG_LDISC_AUTOLOAD is not set

#
# Serial drivers
#
CONFIG_SERIAL_EARLYCON=y
CONFIG_SERIAL_8250=y
CONFIG_SERIAL_8250_DEPRECATED_OPTIONS=y
CONFIG_SERIAL_8250_PNP=y
# CONFIG_SERIAL_8250_16550A_VARIANTS is not set
CONFIG_SERIAL_8250_FINTEK=y
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_DMA=y
CONFIG_SERIAL_8250_PCI=y
CONFIG_SERIAL_8250_EXAR=y
CONFIG_SERIAL_8250_NR_UARTS=4
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
# CONFIG_SERIAL_8250_EXTENDED is not set
CONFIG_SERIAL_8250_ASPEED_VUART=y
CONFIG_SERIAL_8250_DWLIB=y
CONFIG_SERIAL_8250_DW=y
# CONFIG_SERIAL_8250_RT288X is not set
CONFIG_SERIAL_8250_LPSS=y
CONFIG_SERIAL_8250_MID=y
# CONFIG_SERIAL_OF_PLATFORM is not set

#
# Non-8250 serial port support
#
# CONFIG_SERIAL_IMX_EARLYCON is not set
CONFIG_SERIAL_UARTLITE=m
CONFIG_SERIAL_UARTLITE_NR_UARTS=1
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
# CONFIG_SERIAL_JSM is not set
CONFIG_SERIAL_SIFIVE=m
CONFIG_SERIAL_LANTIQ=m
# CONFIG_SERIAL_SCCNXP is not set
# CONFIG_SERIAL_SC16IS7XX is not set
# CONFIG_SERIAL_ALTERA_JTAGUART is not set
CONFIG_SERIAL_ALTERA_UART=m
CONFIG_SERIAL_ALTERA_UART_MAXPORTS=4
CONFIG_SERIAL_ALTERA_UART_BAUDRATE=115200
# CONFIG_SERIAL_XILINX_PS_UART is not set
CONFIG_SERIAL_ARC=y
CONFIG_SERIAL_ARC_CONSOLE=y
CONFIG_SERIAL_ARC_NR_PORTS=1
# CONFIG_SERIAL_RP2 is not set
CONFIG_SERIAL_FSL_LPUART=y
# CONFIG_SERIAL_FSL_LPUART_CONSOLE is not set
# CONFIG_SERIAL_FSL_LINFLEXUART is not set
CONFIG_SERIAL_CONEXANT_DIGICOLOR=m
# CONFIG_SERIAL_SPRD is not set
# end of Serial drivers

CONFIG_SERIAL_MCTRL_GPIO=y
CONFIG_SERIAL_NONSTANDARD=y
# CONFIG_ROCKETPORT is not set
# CONFIG_CYCLADES is not set
# CONFIG_MOXA_INTELLIO is not set
# CONFIG_MOXA_SMARTIO is not set
# CONFIG_SYNCLINK is not set
# CONFIG_SYNCLINKMP is not set
# CONFIG_SYNCLINK_GT is not set
# CONFIG_ISI is not set
# CONFIG_N_HDLC is not set
CONFIG_GOLDFISH_TTY=y
CONFIG_GOLDFISH_TTY_EARLY_CONSOLE=y
# CONFIG_N_GSM is not set
# CONFIG_NOZOMI is not set
CONFIG_NULL_TTY=m
CONFIG_TRACE_ROUTER=y
CONFIG_TRACE_SINK=y
CONFIG_HVC_DRIVER=y
# CONFIG_SERIAL_DEV_BUS is not set
CONFIG_PRINTER=m
# CONFIG_LP_CONSOLE is not set
CONFIG_PPDEV=m
CONFIG_VIRTIO_CONSOLE=m
CONFIG_IPMI_HANDLER=m
CONFIG_IPMI_DMI_DECODE=y
CONFIG_IPMI_PLAT_DATA=y
CONFIG_IPMI_PANIC_EVENT=y
# CONFIG_IPMI_PANIC_STRING is not set
CONFIG_IPMI_DEVICE_INTERFACE=m
CONFIG_IPMI_SI=m
# CONFIG_IPMI_SSIF is not set
CONFIG_IPMI_WATCHDOG=m
# CONFIG_IPMI_POWEROFF is not set
CONFIG_IPMB_DEVICE_INTERFACE=m
# CONFIG_HW_RANDOM is not set
# CONFIG_APPLICOM is not set
CONFIG_MWAVE=m
CONFIG_DEVMEM=y
CONFIG_DEVKMEM=y
CONFIG_NVRAM=m
# CONFIG_RAW_DRIVER is not set
CONFIG_DEVPORT=y
CONFIG_HPET=y
# CONFIG_HPET_MMAP is not set
# CONFIG_HANGCHECK_TIMER is not set
CONFIG_TCG_TPM=y
CONFIG_TCG_TIS_CORE=m
CONFIG_TCG_TIS=m
CONFIG_TCG_TIS_I2C_ATMEL=y
CONFIG_TCG_TIS_I2C_INFINEON=y
CONFIG_TCG_TIS_I2C_NUVOTON=y
CONFIG_TCG_NSC=y
CONFIG_TCG_ATMEL=m
CONFIG_TCG_INFINEON=m
CONFIG_TCG_CRB=m
# CONFIG_TCG_VTPM_PROXY is not set
CONFIG_TCG_TIS_ST33ZP24=y
CONFIG_TCG_TIS_ST33ZP24_I2C=y
CONFIG_TELCLOCK=m
CONFIG_XILLYBUS=m
CONFIG_XILLYBUS_OF=m
# end of Character devices

# CONFIG_RANDOM_TRUST_CPU is not set
# CONFIG_RANDOM_TRUST_BOOTLOADER is not set

#
# I2C support
#
CONFIG_I2C=y
# CONFIG_ACPI_I2C_OPREGION is not set
CONFIG_I2C_BOARDINFO=y
# CONFIG_I2C_COMPAT is not set
# CONFIG_I2C_CHARDEV is not set
CONFIG_I2C_MUX=y

#
# Multiplexer I2C Chip support
#
CONFIG_I2C_ARB_GPIO_CHALLENGE=m
CONFIG_I2C_MUX_GPIO=y
CONFIG_I2C_MUX_GPMUX=m
# CONFIG_I2C_MUX_LTC4306 is not set
CONFIG_I2C_MUX_PCA9541=y
# CONFIG_I2C_MUX_PCA954x is not set
# CONFIG_I2C_MUX_PINCTRL is not set
CONFIG_I2C_MUX_REG=y
# CONFIG_I2C_DEMUX_PINCTRL is not set
CONFIG_I2C_MUX_MLXCPLD=m
# end of Multiplexer I2C Chip support

# CONFIG_I2C_HELPER_AUTO is not set
CONFIG_I2C_SMBUS=m

#
# I2C Algorithms
#
CONFIG_I2C_ALGOBIT=y
# CONFIG_I2C_ALGOPCF is not set
CONFIG_I2C_ALGOPCA=m
# end of I2C Algorithms

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
CONFIG_I2C_SCMI=m

#
# I2C system bus drivers (mostly embedded / system-on-chip)
#
# CONFIG_I2C_CBUS_GPIO is not set
# CONFIG_I2C_DESIGNWARE_PLATFORM is not set
# CONFIG_I2C_DESIGNWARE_PCI is not set
# CONFIG_I2C_EMEV2 is not set
CONFIG_I2C_GPIO=y
# CONFIG_I2C_GPIO_FAULT_INJECTOR is not set
CONFIG_I2C_KEMPLD=m
# CONFIG_I2C_OCORES is not set
CONFIG_I2C_PCA_PLATFORM=m
# CONFIG_I2C_RK3X is not set
# CONFIG_I2C_SIMTEC is not set
CONFIG_I2C_XILINX=y

#
# External I2C/SMBus adapter drivers
#
CONFIG_I2C_PARPORT=m
CONFIG_I2C_TAOS_EVM=m

#
# Other I2C/SMBus bus drivers
#
CONFIG_I2C_MLXCPLD=y
CONFIG_I2C_CROS_EC_TUNNEL=y
CONFIG_I2C_FSI=m
# end of I2C Hardware Bus support

# CONFIG_I2C_STUB is not set
CONFIG_I2C_SLAVE=y
CONFIG_I2C_SLAVE_EEPROM=y
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# end of I2C support

# CONFIG_I3C is not set
# CONFIG_SPI is not set
CONFIG_SPMI=y
CONFIG_HSI=y
CONFIG_HSI_BOARDINFO=y

#
# HSI controllers
#

#
# HSI clients
#
CONFIG_HSI_CHAR=y
CONFIG_PPS=m
# CONFIG_PPS_DEBUG is not set

#
# PPS clients support
#
CONFIG_PPS_CLIENT_KTIMER=m
CONFIG_PPS_CLIENT_LDISC=m
CONFIG_PPS_CLIENT_PARPORT=m
# CONFIG_PPS_CLIENT_GPIO is not set

#
# PPS generators support
#

#
# PTP clock support
#
CONFIG_PTP_1588_CLOCK=m
CONFIG_DP83640_PHY=m
CONFIG_PTP_1588_CLOCK_INES=m
CONFIG_PTP_1588_CLOCK_KVM=m
# CONFIG_PTP_1588_CLOCK_IDT82P33 is not set
CONFIG_PTP_1588_CLOCK_IDTCM=m
# CONFIG_PTP_1588_CLOCK_VMW is not set
# end of PTP clock support

CONFIG_PINCTRL=y
CONFIG_GENERIC_PINCTRL_GROUPS=y
CONFIG_PINMUX=y
CONFIG_GENERIC_PINMUX_FUNCTIONS=y
CONFIG_PINCONF=y
CONFIG_GENERIC_PINCONF=y
# CONFIG_DEBUG_PINCTRL is not set
CONFIG_PINCTRL_AS3722=m
# CONFIG_PINCTRL_AMD is not set
# CONFIG_PINCTRL_MCP23S08 is not set
CONFIG_PINCTRL_SINGLE=m
# CONFIG_PINCTRL_SX150X is not set
CONFIG_PINCTRL_STMFX=y
# CONFIG_PINCTRL_MAX77620 is not set
CONFIG_PINCTRL_OCELOT=y
CONFIG_PINCTRL_BAYTRAIL=y
CONFIG_PINCTRL_CHERRYVIEW=y
# CONFIG_PINCTRL_LYNXPOINT is not set
CONFIG_PINCTRL_INTEL=y
CONFIG_PINCTRL_BROXTON=m
CONFIG_PINCTRL_CANNONLAKE=m
# CONFIG_PINCTRL_CEDARFORK is not set
# CONFIG_PINCTRL_DENVERTON is not set
# CONFIG_PINCTRL_EMMITSBURG is not set
# CONFIG_PINCTRL_GEMINILAKE is not set
CONFIG_PINCTRL_ICELAKE=y
CONFIG_PINCTRL_JASPERLAKE=m
CONFIG_PINCTRL_LEWISBURG=m
CONFIG_PINCTRL_SUNRISEPOINT=y
CONFIG_PINCTRL_TIGERLAKE=m
CONFIG_PINCTRL_LOCHNAGAR=y
CONFIG_PINCTRL_MADERA=m
CONFIG_PINCTRL_CS47L15=y
CONFIG_PINCTRL_CS47L85=y
CONFIG_PINCTRL_CS47L90=y
CONFIG_PINCTRL_CS47L92=y
CONFIG_PINCTRL_EQUILIBRIUM=m
CONFIG_GPIOLIB=y
CONFIG_GPIOLIB_FASTPATH_LIMIT=512
CONFIG_OF_GPIO=y
CONFIG_GPIO_ACPI=y
CONFIG_GPIOLIB_IRQCHIP=y
CONFIG_DEBUG_GPIO=y
CONFIG_GPIO_SYSFS=y
CONFIG_GPIO_GENERIC=y
CONFIG_GPIO_MAX730X=m

#
# Memory mapped GPIO drivers
#
CONFIG_GPIO_74XX_MMIO=m
# CONFIG_GPIO_ALTERA is not set
# CONFIG_GPIO_AMDPT is not set
# CONFIG_GPIO_CADENCE is not set
CONFIG_GPIO_DWAPB=y
# CONFIG_GPIO_EXAR is not set
# CONFIG_GPIO_FTGPIO010 is not set
CONFIG_GPIO_GENERIC_PLATFORM=m
CONFIG_GPIO_GRGPIO=y
CONFIG_GPIO_HLWD=m
# CONFIG_GPIO_ICH is not set
# CONFIG_GPIO_LOGICVC is not set
CONFIG_GPIO_MB86S7X=y
CONFIG_GPIO_SAMA5D2_PIOBU=m
CONFIG_GPIO_SIFIVE=y
# CONFIG_GPIO_SIOX is not set
CONFIG_GPIO_SYSCON=m
# CONFIG_GPIO_VX855 is not set
# CONFIG_GPIO_WCD934X is not set
# CONFIG_GPIO_XILINX is not set
CONFIG_GPIO_AMD_FCH=m
# end of Memory mapped GPIO drivers

#
# Port-mapped I/O GPIO drivers
#
# CONFIG_GPIO_F7188X is not set
CONFIG_GPIO_IT87=m
# CONFIG_GPIO_SCH is not set
CONFIG_GPIO_SCH311X=m
CONFIG_GPIO_WINBOND=m
CONFIG_GPIO_WS16C48=y
# end of Port-mapped I/O GPIO drivers

#
# I2C GPIO expanders
#
CONFIG_GPIO_ADP5588=y
CONFIG_GPIO_ADP5588_IRQ=y
CONFIG_GPIO_ADNP=m
# CONFIG_GPIO_GW_PLD is not set
CONFIG_GPIO_MAX7300=m
CONFIG_GPIO_MAX732X=m
CONFIG_GPIO_PCA953X=m
CONFIG_GPIO_PCA953X_IRQ=y
# CONFIG_GPIO_PCA9570 is not set
# CONFIG_GPIO_PCF857X is not set
CONFIG_GPIO_TPIC2810=y
# end of I2C GPIO expanders

#
# MFD GPIO expanders
#
CONFIG_GPIO_ADP5520=y
# CONFIG_GPIO_BD70528 is not set
CONFIG_GPIO_BD71828=y
# CONFIG_GPIO_BD9571MWV is not set
CONFIG_GPIO_DA9052=y
CONFIG_GPIO_KEMPLD=m
# CONFIG_GPIO_LP3943 is not set
# CONFIG_GPIO_LP873X is not set
# CONFIG_GPIO_MADERA is not set
CONFIG_GPIO_MAX77620=y
# CONFIG_GPIO_MAX77650 is not set
# CONFIG_GPIO_RC5T583 is not set
CONFIG_GPIO_TC3589X=y
CONFIG_GPIO_TPS65086=y
# CONFIG_GPIO_TPS65218 is not set
CONFIG_GPIO_TPS65910=y
CONFIG_GPIO_TQMX86=m
CONFIG_GPIO_TWL6040=m
# CONFIG_GPIO_WHISKEY_COVE is not set
CONFIG_GPIO_WM831X=y
CONFIG_GPIO_WM8350=y
CONFIG_GPIO_WM8994=m
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
# CONFIG_GPIO_SODAVILLE is not set
# end of PCI GPIO expanders

CONFIG_GPIO_AGGREGATOR=m
CONFIG_GPIO_MOCKUP=m
CONFIG_W1=y
# CONFIG_W1_CON is not set

#
# 1-wire Bus Masters
#
# CONFIG_W1_MASTER_MATROX is not set
CONFIG_W1_MASTER_DS2482=m
CONFIG_W1_MASTER_DS1WM=y
CONFIG_W1_MASTER_GPIO=y
# CONFIG_W1_MASTER_SGI is not set
# end of 1-wire Bus Masters

#
# 1-wire Slaves
#
# CONFIG_W1_SLAVE_THERM is not set
CONFIG_W1_SLAVE_SMEM=m
CONFIG_W1_SLAVE_DS2405=m
CONFIG_W1_SLAVE_DS2408=y
# CONFIG_W1_SLAVE_DS2408_READBACK is not set
# CONFIG_W1_SLAVE_DS2413 is not set
# CONFIG_W1_SLAVE_DS2406 is not set
CONFIG_W1_SLAVE_DS2423=m
CONFIG_W1_SLAVE_DS2805=y
# CONFIG_W1_SLAVE_DS2430 is not set
# CONFIG_W1_SLAVE_DS2431 is not set
CONFIG_W1_SLAVE_DS2433=m
CONFIG_W1_SLAVE_DS2433_CRC=y
CONFIG_W1_SLAVE_DS2438=y
CONFIG_W1_SLAVE_DS250X=m
CONFIG_W1_SLAVE_DS2780=y
CONFIG_W1_SLAVE_DS2781=m
CONFIG_W1_SLAVE_DS28E04=m
# CONFIG_W1_SLAVE_DS28E17 is not set
# end of 1-wire Slaves

CONFIG_POWER_AVS=y
CONFIG_QCOM_CPR=m
CONFIG_POWER_RESET=y
CONFIG_POWER_RESET_AS3722=y
# CONFIG_POWER_RESET_GPIO is not set
# CONFIG_POWER_RESET_GPIO_RESTART is not set
CONFIG_POWER_RESET_LTC2952=y
CONFIG_POWER_RESET_RESTART=y
# CONFIG_POWER_RESET_SYSCON is not set
# CONFIG_POWER_RESET_SYSCON_POWEROFF is not set
# CONFIG_SYSCON_REBOOT_MODE is not set
# CONFIG_NVMEM_REBOOT_MODE is not set
CONFIG_POWER_SUPPLY=y
# CONFIG_POWER_SUPPLY_DEBUG is not set
# CONFIG_POWER_SUPPLY_HWMON is not set
# CONFIG_PDA_POWER is not set
CONFIG_GENERIC_ADC_BATTERY=y
# CONFIG_WM831X_BACKUP is not set
# CONFIG_WM831X_POWER is not set
CONFIG_WM8350_POWER=m
# CONFIG_TEST_POWER is not set
CONFIG_CHARGER_ADP5061=y
CONFIG_BATTERY_ACT8945A=m
CONFIG_BATTERY_CW2015=m
CONFIG_BATTERY_DS2760=y
CONFIG_BATTERY_DS2780=y
# CONFIG_BATTERY_DS2781 is not set
CONFIG_BATTERY_DS2782=y
# CONFIG_BATTERY_LEGO_EV3 is not set
# CONFIG_BATTERY_SBS is not set
CONFIG_CHARGER_SBS=y
# CONFIG_MANAGER_SBS is not set
CONFIG_BATTERY_BQ27XXX=m
# CONFIG_BATTERY_BQ27XXX_I2C is not set
CONFIG_BATTERY_BQ27XXX_HDQ=m
CONFIG_BATTERY_DA9052=m
# CONFIG_CHARGER_DA9150 is not set
CONFIG_BATTERY_DA9150=m
CONFIG_BATTERY_MAX17040=y
# CONFIG_BATTERY_MAX17042 is not set
# CONFIG_BATTERY_MAX1721X is not set
CONFIG_CHARGER_PCF50633=m
CONFIG_CHARGER_MAX8903=m
CONFIG_CHARGER_LP8727=y
# CONFIG_CHARGER_GPIO is not set
CONFIG_CHARGER_MANAGER=m
CONFIG_CHARGER_LT3651=m
CONFIG_CHARGER_DETECTOR_MAX14656=m
CONFIG_CHARGER_MAX77650=y
CONFIG_CHARGER_MAX8997=m
CONFIG_CHARGER_MP2629=y
# CONFIG_CHARGER_BQ2415X is not set
CONFIG_CHARGER_BQ24190=y
# CONFIG_CHARGER_BQ24257 is not set
# CONFIG_CHARGER_BQ24735 is not set
# CONFIG_CHARGER_BQ2515X is not set
CONFIG_CHARGER_BQ25890=m
CONFIG_CHARGER_SMB347=y
CONFIG_BATTERY_GAUGE_LTC2941=y
CONFIG_BATTERY_GOLDFISH=y
# CONFIG_BATTERY_RT5033 is not set
# CONFIG_CHARGER_RT9455 is not set
CONFIG_CHARGER_CROS_USBPD=m
# CONFIG_CHARGER_UCS1002 is not set
CONFIG_CHARGER_BD70528=m
CONFIG_CHARGER_BD99954=y
CONFIG_HWMON=y
CONFIG_HWMON_VID=y
# CONFIG_HWMON_DEBUG_CHIP is not set

#
# Native drivers
#
CONFIG_SENSORS_ABITUGURU=m
CONFIG_SENSORS_ABITUGURU3=m
# CONFIG_SENSORS_AD7414 is not set
# CONFIG_SENSORS_AD7418 is not set
# CONFIG_SENSORS_ADM1021 is not set
CONFIG_SENSORS_ADM1025=y
CONFIG_SENSORS_ADM1026=y
# CONFIG_SENSORS_ADM1029 is not set
CONFIG_SENSORS_ADM1031=m
CONFIG_SENSORS_ADM1177=y
# CONFIG_SENSORS_ADM9240 is not set
CONFIG_SENSORS_ADT7X10=y
CONFIG_SENSORS_ADT7410=y
# CONFIG_SENSORS_ADT7411 is not set
# CONFIG_SENSORS_ADT7462 is not set
CONFIG_SENSORS_ADT7470=m
CONFIG_SENSORS_ADT7475=y
CONFIG_SENSORS_AS370=y
CONFIG_SENSORS_ASC7621=m
# CONFIG_SENSORS_AXI_FAN_CONTROL is not set
# CONFIG_SENSORS_K8TEMP is not set
# CONFIG_SENSORS_K10TEMP is not set
# CONFIG_SENSORS_FAM15H_POWER is not set
CONFIG_SENSORS_AMD_ENERGY=m
CONFIG_SENSORS_APPLESMC=y
CONFIG_SENSORS_ASB100=y
CONFIG_SENSORS_ASPEED=m
CONFIG_SENSORS_ATXP1=m
# CONFIG_SENSORS_DRIVETEMP is not set
# CONFIG_SENSORS_DS620 is not set
# CONFIG_SENSORS_DS1621 is not set
CONFIG_SENSORS_DELL_SMM=m
# CONFIG_SENSORS_DA9052_ADC is not set
# CONFIG_SENSORS_I5K_AMB is not set
CONFIG_SENSORS_F71805F=m
# CONFIG_SENSORS_F71882FG is not set
CONFIG_SENSORS_F75375S=m
# CONFIG_SENSORS_GSC is not set
CONFIG_SENSORS_FSCHMD=y
# CONFIG_SENSORS_GL518SM is not set
# CONFIG_SENSORS_GL520SM is not set
CONFIG_SENSORS_G760A=m
CONFIG_SENSORS_G762=y
CONFIG_SENSORS_GPIO_FAN=m
CONFIG_SENSORS_HIH6130=y
CONFIG_SENSORS_IBMAEM=m
# CONFIG_SENSORS_IBMPEX is not set
CONFIG_SENSORS_IIO_HWMON=y
# CONFIG_SENSORS_I5500 is not set
CONFIG_SENSORS_CORETEMP=y
CONFIG_SENSORS_IT87=y
CONFIG_SENSORS_JC42=y
CONFIG_SENSORS_POWR1220=m
# CONFIG_SENSORS_LINEAGE is not set
CONFIG_SENSORS_LOCHNAGAR=m
CONFIG_SENSORS_LTC2945=m
# CONFIG_SENSORS_LTC2947_I2C is not set
# CONFIG_SENSORS_LTC2990 is not set
# CONFIG_SENSORS_LTC4151 is not set
# CONFIG_SENSORS_LTC4215 is not set
CONFIG_SENSORS_LTC4222=y
# CONFIG_SENSORS_LTC4245 is not set
CONFIG_SENSORS_LTC4260=m
# CONFIG_SENSORS_LTC4261 is not set
CONFIG_SENSORS_MAX16065=y
# CONFIG_SENSORS_MAX1619 is not set
CONFIG_SENSORS_MAX1668=y
CONFIG_SENSORS_MAX197=y
# CONFIG_SENSORS_MAX31730 is not set
CONFIG_SENSORS_MAX6621=y
CONFIG_SENSORS_MAX6639=m
CONFIG_SENSORS_MAX6642=y
# CONFIG_SENSORS_MAX6650 is not set
# CONFIG_SENSORS_MAX6697 is not set
CONFIG_SENSORS_MAX31790=m
# CONFIG_SENSORS_MCP3021 is not set
CONFIG_SENSORS_MLXREG_FAN=m
CONFIG_SENSORS_TC654=m
CONFIG_SENSORS_MENF21BMC_HWMON=y
CONFIG_SENSORS_LM63=m
CONFIG_SENSORS_LM73=y
CONFIG_SENSORS_LM75=y
# CONFIG_SENSORS_LM77 is not set
CONFIG_SENSORS_LM78=m
CONFIG_SENSORS_LM80=m
CONFIG_SENSORS_LM83=y
CONFIG_SENSORS_LM85=m
CONFIG_SENSORS_LM87=y
CONFIG_SENSORS_LM90=m
CONFIG_SENSORS_LM92=m
# CONFIG_SENSORS_LM93 is not set
# CONFIG_SENSORS_LM95234 is not set
CONFIG_SENSORS_LM95241=y
# CONFIG_SENSORS_LM95245 is not set
CONFIG_SENSORS_PC87360=y
# CONFIG_SENSORS_PC87427 is not set
CONFIG_SENSORS_NTC_THERMISTOR=y
CONFIG_SENSORS_NCT6683=y
CONFIG_SENSORS_NCT6775=y
CONFIG_SENSORS_NCT7802=m
CONFIG_SENSORS_NPCM7XX=y
CONFIG_SENSORS_PCF8591=y
# CONFIG_PMBUS is not set
CONFIG_SENSORS_PWM_FAN=y
CONFIG_SENSORS_SHT15=y
# CONFIG_SENSORS_SHT21 is not set
CONFIG_SENSORS_SHT3x=m
CONFIG_SENSORS_SHTC1=m
# CONFIG_SENSORS_SIS5595 is not set
CONFIG_SENSORS_DME1737=m
# CONFIG_SENSORS_EMC1403 is not set
CONFIG_SENSORS_EMC2103=y
CONFIG_SENSORS_EMC6W201=y
CONFIG_SENSORS_SMSC47M1=y
CONFIG_SENSORS_SMSC47M192=m
CONFIG_SENSORS_SMSC47B397=m
CONFIG_SENSORS_STTS751=y
CONFIG_SENSORS_SMM665=m
# CONFIG_SENSORS_ADC128D818 is not set
CONFIG_SENSORS_ADS7828=y
CONFIG_SENSORS_AMC6821=m
# CONFIG_SENSORS_INA209 is not set
# CONFIG_SENSORS_INA2XX is not set
# CONFIG_SENSORS_INA3221 is not set
# CONFIG_SENSORS_TC74 is not set
CONFIG_SENSORS_THMC50=y
CONFIG_SENSORS_TMP102=m
# CONFIG_SENSORS_TMP103 is not set
CONFIG_SENSORS_TMP108=y
CONFIG_SENSORS_TMP401=y
CONFIG_SENSORS_TMP421=m
# CONFIG_SENSORS_TMP513 is not set
# CONFIG_SENSORS_VIA_CPUTEMP is not set
# CONFIG_SENSORS_VIA686A is not set
# CONFIG_SENSORS_VT1211 is not set
# CONFIG_SENSORS_VT8231 is not set
# CONFIG_SENSORS_W83773G is not set
CONFIG_SENSORS_W83781D=m
# CONFIG_SENSORS_W83791D is not set
# CONFIG_SENSORS_W83792D is not set
# CONFIG_SENSORS_W83793 is not set
CONFIG_SENSORS_W83795=m
CONFIG_SENSORS_W83795_FANCTRL=y
CONFIG_SENSORS_W83L785TS=y
CONFIG_SENSORS_W83L786NG=y
# CONFIG_SENSORS_W83627HF is not set
CONFIG_SENSORS_W83627EHF=m
# CONFIG_SENSORS_WM831X is not set
# CONFIG_SENSORS_WM8350 is not set

#
# ACPI drivers
#
CONFIG_SENSORS_ACPI_POWER=m
CONFIG_SENSORS_ATK0110=y
CONFIG_THERMAL=y
# CONFIG_THERMAL_NETLINK is not set
CONFIG_THERMAL_STATISTICS=y
CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
CONFIG_THERMAL_HWMON=y
CONFIG_THERMAL_OF=y
CONFIG_THERMAL_WRITABLE_TRIPS=y
# CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE is not set
CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE=y
# CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
# CONFIG_THERMAL_DEFAULT_GOV_POWER_ALLOCATOR is not set
CONFIG_THERMAL_GOV_FAIR_SHARE=y
CONFIG_THERMAL_GOV_STEP_WISE=y
CONFIG_THERMAL_GOV_BANG_BANG=y
# CONFIG_THERMAL_GOV_USER_SPACE is not set
CONFIG_THERMAL_GOV_POWER_ALLOCATOR=y
CONFIG_CPU_THERMAL=y
CONFIG_CPU_FREQ_THERMAL=y
# CONFIG_DEVFREQ_THERMAL is not set
CONFIG_THERMAL_EMULATION=y
# CONFIG_THERMAL_MMIO is not set
CONFIG_MAX77620_THERMAL=m

#
# Intel thermal drivers
#
CONFIG_INTEL_POWERCLAMP=m
# CONFIG_INTEL_SOC_DTS_THERMAL is not set

#
# ACPI INT340X thermal drivers
#
# CONFIG_INT340X_THERMAL is not set
# end of ACPI INT340X thermal drivers

CONFIG_INTEL_BXT_PMIC_THERMAL=m
# CONFIG_INTEL_PCH_THERMAL is not set
# end of Intel thermal drivers

# CONFIG_GENERIC_ADC_THERMAL is not set
# CONFIG_WATCHDOG is not set
CONFIG_SSB_POSSIBLE=y
CONFIG_SSB=m
CONFIG_SSB_SPROM=y
CONFIG_SSB_PCIHOST_POSSIBLE=y
CONFIG_SSB_PCIHOST=y
CONFIG_SSB_SDIOHOST_POSSIBLE=y
CONFIG_SSB_SDIOHOST=y
CONFIG_SSB_DRIVER_PCICORE_POSSIBLE=y
# CONFIG_SSB_DRIVER_PCICORE is not set
# CONFIG_SSB_DRIVER_GPIO is not set
CONFIG_BCMA_POSSIBLE=y
CONFIG_BCMA=m
CONFIG_BCMA_HOST_PCI_POSSIBLE=y
CONFIG_BCMA_HOST_PCI=y
# CONFIG_BCMA_HOST_SOC is not set
CONFIG_BCMA_DRIVER_PCI=y
CONFIG_BCMA_DRIVER_GMAC_CMN=y
CONFIG_BCMA_DRIVER_GPIO=y
CONFIG_BCMA_DEBUG=y

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=y
CONFIG_MFD_ACT8945A=m
CONFIG_MFD_AS3711=y
CONFIG_MFD_AS3722=m
CONFIG_PMIC_ADP5520=y
CONFIG_MFD_AAT2870_CORE=y
CONFIG_MFD_ATMEL_FLEXCOM=y
CONFIG_MFD_ATMEL_HLCDC=m
CONFIG_MFD_BCM590XX=y
CONFIG_MFD_BD9571MWV=y
# CONFIG_MFD_AXP20X_I2C is not set
CONFIG_MFD_CROS_EC_DEV=m
CONFIG_MFD_MADERA=m
CONFIG_MFD_MADERA_I2C=m
CONFIG_MFD_CS47L15=y
# CONFIG_MFD_CS47L35 is not set
CONFIG_MFD_CS47L85=y
CONFIG_MFD_CS47L90=y
CONFIG_MFD_CS47L92=y
# CONFIG_PMIC_DA903X is not set
CONFIG_PMIC_DA9052=y
CONFIG_MFD_DA9052_I2C=y
# CONFIG_MFD_DA9055 is not set
# CONFIG_MFD_DA9062 is not set
# CONFIG_MFD_DA9063 is not set
CONFIG_MFD_DA9150=y
CONFIG_MFD_GATEWORKS_GSC=y
# CONFIG_MFD_MC13XXX_I2C is not set
CONFIG_MFD_MP2629=y
# CONFIG_MFD_HI6421_PMIC is not set
CONFIG_HTC_PASIC3=y
# CONFIG_HTC_I2CPLD is not set
# CONFIG_MFD_INTEL_QUARK_I2C_GPIO is not set
# CONFIG_LPC_ICH is not set
# CONFIG_LPC_SCH is not set
CONFIG_INTEL_SOC_PMIC_BXTWC=m
CONFIG_INTEL_SOC_PMIC_CHTDC_TI=y
# CONFIG_MFD_INTEL_LPSS_ACPI is not set
# CONFIG_MFD_INTEL_LPSS_PCI is not set
CONFIG_MFD_INTEL_PMC_BXT=y
CONFIG_MFD_IQS62X=m
# CONFIG_MFD_JANZ_CMODIO is not set
CONFIG_MFD_KEMPLD=m
CONFIG_MFD_88PM800=m
CONFIG_MFD_88PM805=y
# CONFIG_MFD_88PM860X is not set
# CONFIG_MFD_MAX14577 is not set
CONFIG_MFD_MAX77620=y
CONFIG_MFD_MAX77650=y
# CONFIG_MFD_MAX77686 is not set
# CONFIG_MFD_MAX77693 is not set
CONFIG_MFD_MAX77843=y
# CONFIG_MFD_MAX8907 is not set
# CONFIG_MFD_MAX8925 is not set
CONFIG_MFD_MAX8997=y
# CONFIG_MFD_MAX8998 is not set
CONFIG_MFD_MT6360=y
# CONFIG_MFD_MT6397 is not set
CONFIG_MFD_MENF21BMC=y
CONFIG_MFD_RETU=m
CONFIG_MFD_PCF50633=m
CONFIG_PCF50633_ADC=m
# CONFIG_PCF50633_GPIO is not set
# CONFIG_MFD_RDC321X is not set
CONFIG_MFD_RT5033=y
CONFIG_MFD_RC5T583=y
# CONFIG_MFD_RK808 is not set
# CONFIG_MFD_RN5T618 is not set
# CONFIG_MFD_SEC_CORE is not set
# CONFIG_MFD_SI476X_CORE is not set
# CONFIG_MFD_SM501 is not set
# CONFIG_MFD_SKY81452 is not set
# CONFIG_ABX500_CORE is not set
# CONFIG_MFD_STMPE is not set
CONFIG_MFD_SYSCON=y
# CONFIG_MFD_TI_AM335X_TSCADC is not set
CONFIG_MFD_LP3943=m
# CONFIG_MFD_LP8788 is not set
CONFIG_MFD_TI_LMU=y
# CONFIG_MFD_PALMAS is not set
CONFIG_TPS6105X=m
# CONFIG_TPS65010 is not set
CONFIG_TPS6507X=m
CONFIG_MFD_TPS65086=y
# CONFIG_MFD_TPS65090 is not set
# CONFIG_MFD_TPS65217 is not set
CONFIG_MFD_TI_LP873X=m
# CONFIG_MFD_TI_LP87565 is not set
CONFIG_MFD_TPS65218=y
# CONFIG_MFD_TPS6586X is not set
CONFIG_MFD_TPS65910=y
# CONFIG_MFD_TPS65912_I2C is not set
CONFIG_MFD_TPS80031=y
# CONFIG_TWL4030_CORE is not set
CONFIG_TWL6040_CORE=y
CONFIG_MFD_WL1273_CORE=m
# CONFIG_MFD_LM3533 is not set
CONFIG_MFD_TC3589X=y
CONFIG_MFD_TQMX86=m
# CONFIG_MFD_VX855 is not set
CONFIG_MFD_LOCHNAGAR=y
# CONFIG_MFD_ARIZONA_I2C is not set
# CONFIG_MFD_WM8400 is not set
CONFIG_MFD_WM831X=y
CONFIG_MFD_WM831X_I2C=y
CONFIG_MFD_WM8350=y
CONFIG_MFD_WM8350_I2C=y
CONFIG_MFD_WM8994=y
CONFIG_MFD_ROHM_BD718XX=y
CONFIG_MFD_ROHM_BD70528=m
CONFIG_MFD_ROHM_BD71828=y
# CONFIG_MFD_STPMIC1 is not set
CONFIG_MFD_STMFX=y
CONFIG_MFD_WCD934X=m
# end of Multifunction device drivers

CONFIG_REGULATOR=y
CONFIG_REGULATOR_DEBUG=y
CONFIG_REGULATOR_FIXED_VOLTAGE=m
# CONFIG_REGULATOR_VIRTUAL_CONSUMER is not set
# CONFIG_REGULATOR_USERSPACE_CONSUMER is not set
# CONFIG_REGULATOR_88PG86X is not set
CONFIG_REGULATOR_88PM800=m
CONFIG_REGULATOR_ACT8865=y
CONFIG_REGULATOR_ACT8945A=m
# CONFIG_REGULATOR_AD5398 is not set
CONFIG_REGULATOR_AAT2870=m
CONFIG_REGULATOR_AS3711=y
CONFIG_REGULATOR_AS3722=m
CONFIG_REGULATOR_BCM590XX=m
CONFIG_REGULATOR_BD70528=m
# CONFIG_REGULATOR_BD71828 is not set
CONFIG_REGULATOR_BD718XX=m
CONFIG_REGULATOR_BD9571MWV=y
# CONFIG_REGULATOR_CROS_EC is not set
CONFIG_REGULATOR_DA9052=y
# CONFIG_REGULATOR_DA9210 is not set
# CONFIG_REGULATOR_DA9211 is not set
# CONFIG_REGULATOR_FAN53555 is not set
# CONFIG_REGULATOR_FAN53880 is not set
CONFIG_REGULATOR_GPIO=m
CONFIG_REGULATOR_ISL9305=y
CONFIG_REGULATOR_ISL6271A=m
# CONFIG_REGULATOR_LM363X is not set
# CONFIG_REGULATOR_LOCHNAGAR is not set
CONFIG_REGULATOR_LP3971=y
CONFIG_REGULATOR_LP3972=m
CONFIG_REGULATOR_LP872X=y
CONFIG_REGULATOR_LP873X=m
CONFIG_REGULATOR_LP8755=m
CONFIG_REGULATOR_LTC3589=y
CONFIG_REGULATOR_LTC3676=m
# CONFIG_REGULATOR_MAX1586 is not set
# CONFIG_REGULATOR_MAX77620 is not set
CONFIG_REGULATOR_MAX77650=y
# CONFIG_REGULATOR_MAX8649 is not set
# CONFIG_REGULATOR_MAX8660 is not set
CONFIG_REGULATOR_MAX8952=m
CONFIG_REGULATOR_MAX8973=m
CONFIG_REGULATOR_MAX8997=m
# CONFIG_REGULATOR_MAX77693 is not set
# CONFIG_REGULATOR_MAX77826 is not set
CONFIG_REGULATOR_MCP16502=m
# CONFIG_REGULATOR_MP5416 is not set
CONFIG_REGULATOR_MP8859=m
CONFIG_REGULATOR_MP886X=y
CONFIG_REGULATOR_MPQ7920=m
CONFIG_REGULATOR_MT6311=m
# CONFIG_REGULATOR_PCA9450 is not set
# CONFIG_REGULATOR_PCF50633 is not set
CONFIG_REGULATOR_PFUZE100=m
CONFIG_REGULATOR_PV88060=y
CONFIG_REGULATOR_PV88080=m
CONFIG_REGULATOR_PV88090=m
CONFIG_REGULATOR_PWM=m
CONFIG_REGULATOR_QCOM_SPMI=y
# CONFIG_REGULATOR_QCOM_USB_VBUS is not set
# CONFIG_REGULATOR_RC5T583 is not set
CONFIG_REGULATOR_ROHM=m
# CONFIG_REGULATOR_RT5033 is not set
CONFIG_REGULATOR_SLG51000=m
CONFIG_REGULATOR_SY8106A=y
# CONFIG_REGULATOR_SY8824X is not set
# CONFIG_REGULATOR_SY8827N is not set
# CONFIG_REGULATOR_TPS51632 is not set
CONFIG_REGULATOR_TPS6105X=m
CONFIG_REGULATOR_TPS62360=y
CONFIG_REGULATOR_TPS65023=m
CONFIG_REGULATOR_TPS6507X=m
CONFIG_REGULATOR_TPS65086=m
CONFIG_REGULATOR_TPS65132=y
CONFIG_REGULATOR_TPS65218=m
CONFIG_REGULATOR_TPS65910=y
# CONFIG_REGULATOR_TPS80031 is not set
CONFIG_REGULATOR_VCTRL=y
CONFIG_REGULATOR_WM831X=m
CONFIG_REGULATOR_WM8350=m
# CONFIG_REGULATOR_WM8994 is not set
# CONFIG_REGULATOR_QCOM_LABIBB is not set
CONFIG_RC_CORE=m
# CONFIG_RC_MAP is not set
# CONFIG_LIRC is not set
# CONFIG_RC_DECODERS is not set
# CONFIG_RC_DEVICES is not set
CONFIG_CEC_CORE=m
# CONFIG_MEDIA_CEC_RC is not set
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
CONFIG_VIDEO_DEV=m
CONFIG_MEDIA_CONTROLLER=y
CONFIG_DVB_CORE=y
# end of Media core support

#
# Video4Linux options
#
CONFIG_VIDEO_V4L2=m
CONFIG_VIDEO_V4L2_I2C=y
CONFIG_VIDEO_V4L2_SUBDEV_API=y
# CONFIG_VIDEO_ADV_DEBUG is not set
CONFIG_VIDEO_FIXED_MINOR_RANGES=y
CONFIG_V4L2_FLASH_LED_CLASS=m
CONFIG_V4L2_FWNODE=m
# end of Video4Linux options

#
# Media controller options
#
# CONFIG_MEDIA_CONTROLLER_DVB is not set
# end of Media controller options

#
# Digital TV options
#
# CONFIG_DVB_NET is not set
CONFIG_DVB_MAX_ADAPTERS=16
CONFIG_DVB_DYNAMIC_MINORS=y
CONFIG_DVB_DEMUX_SECTION_LOSS_LOG=y
# CONFIG_DVB_ULE_DEBUG is not set
# end of Digital TV options

#
# Media drivers
#
# CONFIG_MEDIA_PCI_SUPPORT is not set
CONFIG_RADIO_ADAPTERS=y
CONFIG_RADIO_SI470X=m
CONFIG_I2C_SI470X=m
CONFIG_RADIO_SI4713=m
CONFIG_PLATFORM_SI4713=m
CONFIG_I2C_SI4713=m
# CONFIG_RADIO_MAXIRADIO is not set
# CONFIG_RADIO_TEA5764 is not set
CONFIG_RADIO_SAA7706H=m
CONFIG_RADIO_TEF6862=m
# CONFIG_RADIO_WL1273 is not set
CONFIG_MEDIA_COMMON_OPTIONS=y

#
# common driver options
#
CONFIG_VIDEOBUF2_CORE=m
CONFIG_VIDEOBUF2_V4L2=m
CONFIG_VIDEOBUF2_MEMOPS=m
CONFIG_VIDEOBUF2_VMALLOC=m
CONFIG_SMS_SIANO_MDTV=m
CONFIG_SMS_SIANO_RC=y
# CONFIG_V4L_PLATFORM_DRIVERS is not set
CONFIG_V4L_MEM2MEM_DRIVERS=y
# CONFIG_VIDEO_MEM2MEM_DEINTERLACE is not set
CONFIG_DVB_PLATFORM_DRIVERS=y
# CONFIG_SDR_PLATFORM_DRIVERS is not set

#
# MMC/SDIO DVB adapters
#
CONFIG_SMS_SDIO_DRV=m
# CONFIG_V4L_TEST_DRIVERS is not set

#
# FireWire (IEEE 1394) Adapters
#
CONFIG_DVB_FIREDTV=m
CONFIG_DVB_FIREDTV_INPUT=y
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
CONFIG_VIDEO_TDA7432=m
# CONFIG_VIDEO_TDA9840 is not set
CONFIG_VIDEO_TEA6415C=m
CONFIG_VIDEO_TEA6420=m
CONFIG_VIDEO_MSP3400=m
# CONFIG_VIDEO_CS3308 is not set
# CONFIG_VIDEO_CS5345 is not set
CONFIG_VIDEO_CS53L32A=m
# CONFIG_VIDEO_TLV320AIC23B is not set
CONFIG_VIDEO_UDA1342=m
# CONFIG_VIDEO_WM8775 is not set
# CONFIG_VIDEO_WM8739 is not set
CONFIG_VIDEO_VP27SMPX=m
CONFIG_VIDEO_SONY_BTF_MPX=m
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
CONFIG_VIDEO_ADV7183=m
CONFIG_VIDEO_ADV748X=m
CONFIG_VIDEO_ADV7604=m
# CONFIG_VIDEO_ADV7604_CEC is not set
CONFIG_VIDEO_ADV7842=m
CONFIG_VIDEO_ADV7842_CEC=y
CONFIG_VIDEO_BT819=m
CONFIG_VIDEO_BT856=m
# CONFIG_VIDEO_BT866 is not set
CONFIG_VIDEO_KS0127=m
# CONFIG_VIDEO_ML86V7667 is not set
CONFIG_VIDEO_SAA7110=m
CONFIG_VIDEO_SAA711X=m
CONFIG_VIDEO_TC358743=m
CONFIG_VIDEO_TC358743_CEC=y
CONFIG_VIDEO_TVP514X=m
# CONFIG_VIDEO_TVP5150 is not set
CONFIG_VIDEO_TVP7002=m
CONFIG_VIDEO_TW2804=m
# CONFIG_VIDEO_TW9903 is not set
# CONFIG_VIDEO_TW9906 is not set
CONFIG_VIDEO_TW9910=m
CONFIG_VIDEO_VPX3220=m
# CONFIG_VIDEO_MAX9286 is not set

#
# Video and audio decoders
#
# CONFIG_VIDEO_SAA717X is not set
CONFIG_VIDEO_CX25840=m
# end of Video decoders

#
# Video encoders
#
CONFIG_VIDEO_SAA7127=m
CONFIG_VIDEO_SAA7185=m
CONFIG_VIDEO_ADV7170=m
CONFIG_VIDEO_ADV7175=m
# CONFIG_VIDEO_ADV7343 is not set
CONFIG_VIDEO_ADV7393=m
# CONFIG_VIDEO_ADV7511 is not set
CONFIG_VIDEO_AD9389B=m
# CONFIG_VIDEO_AK881X is not set
CONFIG_VIDEO_THS8200=m
# end of Video encoders

#
# Video improvement chips
#
CONFIG_VIDEO_UPD64031A=m
# CONFIG_VIDEO_UPD64083 is not set
# end of Video improvement chips

#
# Audio/Video compression chips
#
CONFIG_VIDEO_SAA6752HS=m
# end of Audio/Video compression chips

#
# SDR tuner chips
#
CONFIG_SDR_MAX2175=m
# end of SDR tuner chips

#
# Miscellaneous helper chips
#
# CONFIG_VIDEO_THS7303 is not set
CONFIG_VIDEO_M52790=m
CONFIG_VIDEO_I2C=m
# CONFIG_VIDEO_ST_MIPID02 is not set
# end of Miscellaneous helper chips

#
# Camera sensor devices
#
CONFIG_VIDEO_APTINA_PLL=m
# CONFIG_VIDEO_HI556 is not set
# CONFIG_VIDEO_IMX214 is not set
CONFIG_VIDEO_IMX219=m
# CONFIG_VIDEO_IMX258 is not set
# CONFIG_VIDEO_IMX274 is not set
CONFIG_VIDEO_IMX290=m
CONFIG_VIDEO_IMX319=m
CONFIG_VIDEO_IMX355=m
CONFIG_VIDEO_OV2640=m
# CONFIG_VIDEO_OV2659 is not set
CONFIG_VIDEO_OV2680=m
CONFIG_VIDEO_OV2685=m
CONFIG_VIDEO_OV2740=m
CONFIG_VIDEO_OV5640=m
CONFIG_VIDEO_OV5645=m
CONFIG_VIDEO_OV5647=m
CONFIG_VIDEO_OV6650=m
CONFIG_VIDEO_OV5670=m
# CONFIG_VIDEO_OV5675 is not set
CONFIG_VIDEO_OV5695=m
CONFIG_VIDEO_OV7251=m
CONFIG_VIDEO_OV772X=m
# CONFIG_VIDEO_OV7640 is not set
CONFIG_VIDEO_OV7670=m
CONFIG_VIDEO_OV7740=m
CONFIG_VIDEO_OV8856=m
CONFIG_VIDEO_OV9640=m
CONFIG_VIDEO_OV9650=m
CONFIG_VIDEO_OV13858=m
# CONFIG_VIDEO_VS6624 is not set
CONFIG_VIDEO_MT9M001=m
# CONFIG_VIDEO_MT9M032 is not set
# CONFIG_VIDEO_MT9M111 is not set
CONFIG_VIDEO_MT9P031=m
CONFIG_VIDEO_MT9T001=m
CONFIG_VIDEO_MT9T112=m
CONFIG_VIDEO_MT9V011=m
# CONFIG_VIDEO_MT9V032 is not set
# CONFIG_VIDEO_MT9V111 is not set
CONFIG_VIDEO_SR030PC30=m
# CONFIG_VIDEO_NOON010PC30 is not set
CONFIG_VIDEO_M5MOLS=m
# CONFIG_VIDEO_RDACM20 is not set
CONFIG_VIDEO_RJ54N1=m
# CONFIG_VIDEO_S5K6AA is not set
# CONFIG_VIDEO_S5K6A3 is not set
# CONFIG_VIDEO_S5K4ECGX is not set
CONFIG_VIDEO_S5K5BAF=m
# CONFIG_VIDEO_SMIAPP is not set
# CONFIG_VIDEO_ET8EK8 is not set
# end of Camera sensor devices

#
# Lens drivers
#
CONFIG_VIDEO_AD5820=m
CONFIG_VIDEO_AK7375=m
# CONFIG_VIDEO_DW9714 is not set
# CONFIG_VIDEO_DW9768 is not set
CONFIG_VIDEO_DW9807_VCM=m
# end of Lens drivers

#
# Flash devices
#
CONFIG_VIDEO_ADP1653=m
# CONFIG_VIDEO_LM3560 is not set
# CONFIG_VIDEO_LM3646 is not set
# end of Flash devices

#
# SPI helper chips
#
# end of SPI helper chips

CONFIG_MEDIA_TUNER=y

#
# Customize TV tuners
#
CONFIG_MEDIA_TUNER_SIMPLE=y
CONFIG_MEDIA_TUNER_TDA18250=y
CONFIG_MEDIA_TUNER_TDA8290=m
CONFIG_MEDIA_TUNER_TDA827X=m
CONFIG_MEDIA_TUNER_TDA18271=y
CONFIG_MEDIA_TUNER_TDA9887=y
CONFIG_MEDIA_TUNER_TEA5761=m
# CONFIG_MEDIA_TUNER_TEA5767 is not set
CONFIG_MEDIA_TUNER_MT20XX=m
# CONFIG_MEDIA_TUNER_MT2060 is not set
CONFIG_MEDIA_TUNER_MT2063=m
# CONFIG_MEDIA_TUNER_MT2266 is not set
# CONFIG_MEDIA_TUNER_MT2131 is not set
# CONFIG_MEDIA_TUNER_QT1010 is not set
CONFIG_MEDIA_TUNER_XC2028=y
CONFIG_MEDIA_TUNER_XC5000=m
CONFIG_MEDIA_TUNER_XC4000=m
CONFIG_MEDIA_TUNER_MXL5005S=y
CONFIG_MEDIA_TUNER_MXL5007T=y
# CONFIG_MEDIA_TUNER_MC44S803 is not set
# CONFIG_MEDIA_TUNER_MAX2165 is not set
CONFIG_MEDIA_TUNER_TDA18218=m
CONFIG_MEDIA_TUNER_FC0011=y
CONFIG_MEDIA_TUNER_FC0012=m
# CONFIG_MEDIA_TUNER_FC0013 is not set
# CONFIG_MEDIA_TUNER_TDA18212 is not set
CONFIG_MEDIA_TUNER_E4000=m
CONFIG_MEDIA_TUNER_FC2580=m
# CONFIG_MEDIA_TUNER_M88RS6000T is not set
# CONFIG_MEDIA_TUNER_TUA9001 is not set
CONFIG_MEDIA_TUNER_SI2157=y
CONFIG_MEDIA_TUNER_IT913X=m
# CONFIG_MEDIA_TUNER_R820T is not set
CONFIG_MEDIA_TUNER_MXL301RF=m
CONFIG_MEDIA_TUNER_QM1D1C0042=y
CONFIG_MEDIA_TUNER_QM1D1B0004=y
# end of Customize TV tuners

#
# Customise DVB Frontends
#

#
# Multistandard (satellite) frontends
#
CONFIG_DVB_STB0899=y
CONFIG_DVB_STB6100=m
# CONFIG_DVB_STV090x is not set
CONFIG_DVB_STV0910=m
CONFIG_DVB_STV6110x=y
# CONFIG_DVB_STV6111 is not set
# CONFIG_DVB_MXL5XX is not set
CONFIG_DVB_M88DS3103=y

#
# Multistandard (cable + terrestrial) frontends
#
CONFIG_DVB_DRXK=m
CONFIG_DVB_TDA18271C2DD=m
CONFIG_DVB_SI2165=m
CONFIG_DVB_MN88472=y
CONFIG_DVB_MN88473=m

#
# DVB-S (satellite) frontends
#
CONFIG_DVB_CX24110=y
CONFIG_DVB_CX24123=y
CONFIG_DVB_MT312=m
CONFIG_DVB_ZL10036=y
CONFIG_DVB_ZL10039=y
CONFIG_DVB_S5H1420=y
# CONFIG_DVB_STV0288 is not set
# CONFIG_DVB_STB6000 is not set
CONFIG_DVB_STV0299=m
CONFIG_DVB_STV6110=m
CONFIG_DVB_STV0900=y
CONFIG_DVB_TDA8083=m
CONFIG_DVB_TDA10086=y
CONFIG_DVB_TDA8261=y
# CONFIG_DVB_VES1X93 is not set
CONFIG_DVB_TUNER_ITD1000=m
# CONFIG_DVB_TUNER_CX24113 is not set
CONFIG_DVB_TDA826X=m
CONFIG_DVB_TUA6100=y
CONFIG_DVB_CX24116=m
# CONFIG_DVB_CX24117 is not set
CONFIG_DVB_CX24120=m
CONFIG_DVB_SI21XX=m
# CONFIG_DVB_TS2020 is not set
# CONFIG_DVB_DS3000 is not set
# CONFIG_DVB_MB86A16 is not set
# CONFIG_DVB_TDA10071 is not set

#
# DVB-T (terrestrial) frontends
#
CONFIG_DVB_SP8870=m
# CONFIG_DVB_SP887X is not set
# CONFIG_DVB_CX22700 is not set
CONFIG_DVB_CX22702=m
CONFIG_DVB_S5H1432=m
# CONFIG_DVB_DRXD is not set
CONFIG_DVB_L64781=y
CONFIG_DVB_TDA1004X=m
CONFIG_DVB_NXT6000=y
CONFIG_DVB_MT352=m
# CONFIG_DVB_ZL10353 is not set
CONFIG_DVB_DIB3000MB=m
CONFIG_DVB_DIB3000MC=y
CONFIG_DVB_DIB7000M=y
CONFIG_DVB_DIB7000P=y
# CONFIG_DVB_DIB9000 is not set
CONFIG_DVB_TDA10048=y
# CONFIG_DVB_AF9013 is not set
CONFIG_DVB_EC100=y
# CONFIG_DVB_STV0367 is not set
CONFIG_DVB_CXD2820R=m
CONFIG_DVB_CXD2841ER=m
CONFIG_DVB_RTL2830=m
CONFIG_DVB_RTL2832=m
CONFIG_DVB_SI2168=y
CONFIG_DVB_ZD1301_DEMOD=m

#
# DVB-C (cable) frontends
#
CONFIG_DVB_VES1820=m
# CONFIG_DVB_TDA10021 is not set
CONFIG_DVB_TDA10023=y
CONFIG_DVB_STV0297=m

#
# ATSC (North American/Korean Terrestrial/Cable DTV) frontends
#
CONFIG_DVB_NXT200X=m
CONFIG_DVB_OR51211=y
CONFIG_DVB_OR51132=m
CONFIG_DVB_BCM3510=m
CONFIG_DVB_LGDT330X=m
CONFIG_DVB_LGDT3305=y
# CONFIG_DVB_LGDT3306A is not set
CONFIG_DVB_LG2160=y
CONFIG_DVB_S5H1409=y
CONFIG_DVB_AU8522=y
CONFIG_DVB_AU8522_DTV=y
CONFIG_DVB_AU8522_V4L=m
CONFIG_DVB_S5H1411=m

#
# ISDB-T (terrestrial) frontends
#
# CONFIG_DVB_S921 is not set
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
CONFIG_DVB_TUNER_DIB0070=m
CONFIG_DVB_TUNER_DIB0090=y

#
# SEC control devices for DVB-S
#
CONFIG_DVB_DRX39XYJ=m
CONFIG_DVB_LNBH25=y
CONFIG_DVB_LNBH29=m
CONFIG_DVB_LNBP21=m
CONFIG_DVB_LNBP22=y
CONFIG_DVB_ISL6405=m
CONFIG_DVB_ISL6421=y
CONFIG_DVB_ISL6423=y
CONFIG_DVB_A8293=y
# CONFIG_DVB_LGS8GL5 is not set
# CONFIG_DVB_LGS8GXX is not set
# CONFIG_DVB_ATBM8830 is not set
CONFIG_DVB_TDA665x=m
# CONFIG_DVB_IX2505V is not set
# CONFIG_DVB_M88RS2000 is not set
CONFIG_DVB_AF9033=m
CONFIG_DVB_HORUS3A=m
CONFIG_DVB_ASCOT2E=m
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
# CONFIG_DVB_DUMMY_FE is not set
# end of Media ancillary drivers

#
# Graphics support
#
# CONFIG_AGP is not set
CONFIG_VGA_ARB=y
CONFIG_VGA_ARB_MAX_GPUS=16
# CONFIG_DRM is not set

#
# ARM devices
#
# end of ARM devices

#
# Frame buffer Devices
#
CONFIG_FB_CMDLINE=y
CONFIG_FB_NOTIFY=y
CONFIG_FB=m
CONFIG_FIRMWARE_EDID=y
CONFIG_FB_CFB_FILLRECT=m
CONFIG_FB_CFB_COPYAREA=m
CONFIG_FB_CFB_IMAGEBLIT=m
CONFIG_FB_SYS_FILLRECT=m
CONFIG_FB_SYS_COPYAREA=m
CONFIG_FB_SYS_IMAGEBLIT=m
# CONFIG_FB_FOREIGN_ENDIAN is not set
CONFIG_FB_SYS_FOPS=m
CONFIG_FB_DEFERRED_IO=y
CONFIG_FB_BACKLIGHT=m
CONFIG_FB_MODE_HELPERS=y
CONFIG_FB_TILEBLITTING=y

#
# Frame buffer hardware drivers
#
# CONFIG_FB_CIRRUS is not set
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CYBER2000 is not set
# CONFIG_FB_ARC is not set
# CONFIG_FB_VGA16 is not set
CONFIG_FB_UVESA=m
# CONFIG_FB_N411 is not set
CONFIG_FB_HGA=m
CONFIG_FB_OPENCORES=m
CONFIG_FB_S1D13XXX=m
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
# CONFIG_FB_IBM_GXT4500 is not set
CONFIG_FB_GOLDFISH=m
# CONFIG_FB_VIRTUAL is not set
# CONFIG_FB_METRONOME is not set
# CONFIG_FB_MB862XX is not set
CONFIG_FB_SSD1307=m
# CONFIG_FB_SM712 is not set
# end of Frame buffer Devices

#
# Backlight & LCD device support
#
CONFIG_LCD_CLASS_DEVICE=m
CONFIG_LCD_PLATFORM=m
CONFIG_BACKLIGHT_CLASS_DEVICE=y
# CONFIG_BACKLIGHT_PWM is not set
# CONFIG_BACKLIGHT_DA9052 is not set
# CONFIG_BACKLIGHT_APPLE is not set
CONFIG_BACKLIGHT_QCOM_WLED=y
# CONFIG_BACKLIGHT_SAHARA is not set
CONFIG_BACKLIGHT_WM831X=y
CONFIG_BACKLIGHT_ADP5520=m
# CONFIG_BACKLIGHT_ADP8860 is not set
CONFIG_BACKLIGHT_ADP8870=m
CONFIG_BACKLIGHT_PCF50633=m
CONFIG_BACKLIGHT_AAT2870=m
CONFIG_BACKLIGHT_LM3630A=m
CONFIG_BACKLIGHT_LM3639=y
# CONFIG_BACKLIGHT_LP855X is not set
CONFIG_BACKLIGHT_AS3711=m
CONFIG_BACKLIGHT_GPIO=m
CONFIG_BACKLIGHT_LV5207LP=m
# CONFIG_BACKLIGHT_BD6107 is not set
CONFIG_BACKLIGHT_ARCXCNN=m
# CONFIG_BACKLIGHT_LED is not set
# end of Backlight & LCD device support

CONFIG_HDMI=y

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
# CONFIG_VGACON_SOFT_SCROLLBACK is not set
CONFIG_DUMMY_CONSOLE=y
CONFIG_DUMMY_CONSOLE_COLUMNS=80
CONFIG_DUMMY_CONSOLE_ROWS=25
CONFIG_FRAMEBUFFER_CONSOLE=y
CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY=y
# CONFIG_FRAMEBUFFER_CONSOLE_ROTATION is not set
# end of Console display driver support

CONFIG_LOGO=y
# CONFIG_LOGO_LINUX_MONO is not set
CONFIG_LOGO_LINUX_VGA16=y
CONFIG_LOGO_LINUX_CLUT224=y
# end of Graphics support

# CONFIG_SOUND is not set

#
# HID support
#
# CONFIG_HID is not set

#
# I2C HID support
#
# CONFIG_I2C_HID is not set
# end of I2C HID support

#
# Intel ISH HID support
#
# CONFIG_INTEL_ISH_HID is not set
# end of Intel ISH HID support
# end of HID support

CONFIG_USB_OHCI_LITTLE_ENDIAN=y
CONFIG_USB_SUPPORT=y
# CONFIG_USB_LED_TRIG is not set
# CONFIG_USB_ULPI_BUS is not set
# CONFIG_USB_CONN_GPIO is not set
CONFIG_USB_ARCH_HAS_HCD=y
# CONFIG_USB is not set
CONFIG_USB_PCI=y

#
# USB port drivers
#

#
# USB Physical Layer drivers
#
# CONFIG_NOP_USB_XCEIV is not set
# CONFIG_USB_GPIO_VBUS is not set
# CONFIG_TAHVO_USB is not set
# end of USB Physical Layer drivers

# CONFIG_USB_GADGET is not set
# CONFIG_TYPEC is not set
# CONFIG_USB_ROLE_SWITCH is not set
CONFIG_MMC=m
CONFIG_PWRSEQ_EMMC=m
CONFIG_PWRSEQ_SIMPLE=m
CONFIG_MMC_BLOCK=m
CONFIG_MMC_BLOCK_MINORS=8
CONFIG_SDIO_UART=m
CONFIG_MMC_TEST=m

#
# MMC/SD/SDIO Host Controller Drivers
#
# CONFIG_MMC_DEBUG is not set
# CONFIG_MMC_SDHCI is not set
CONFIG_MMC_WBSD=m
# CONFIG_MMC_TIFM_SD is not set
CONFIG_MMC_GOLDFISH=m
# CONFIG_MMC_CB710 is not set
# CONFIG_MMC_VIA_SDMMC is not set
CONFIG_MMC_USDHI6ROL0=m
# CONFIG_MMC_CQHCI is not set
# CONFIG_MMC_HSQ is not set
# CONFIG_MMC_TOSHIBA_PCI is not set
# CONFIG_MMC_MTK is not set
CONFIG_MEMSTICK=m
CONFIG_MEMSTICK_DEBUG=y

#
# MemoryStick drivers
#
# CONFIG_MEMSTICK_UNSAFE_RESUME is not set
# CONFIG_MSPRO_BLOCK is not set
CONFIG_MS_BLOCK=m

#
# MemoryStick Host Controller Drivers
#
# CONFIG_MEMSTICK_TIFM_MS is not set
# CONFIG_MEMSTICK_JMICRON_38X is not set
# CONFIG_MEMSTICK_R592 is not set
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y
CONFIG_LEDS_CLASS_FLASH=m
# CONFIG_LEDS_CLASS_MULTICOLOR is not set
# CONFIG_LEDS_BRIGHTNESS_HW_CHANGED is not set

#
# LED drivers
#
CONFIG_LEDS_AAT1290=m
# CONFIG_LEDS_AN30259A is not set
CONFIG_LEDS_APU=y
# CONFIG_LEDS_AS3645A is not set
# CONFIG_LEDS_AW2013 is not set
CONFIG_LEDS_BCM6328=m
CONFIG_LEDS_BCM6358=y
CONFIG_LEDS_LM3530=y
CONFIG_LEDS_LM3532=m
# CONFIG_LEDS_LM3642 is not set
CONFIG_LEDS_LM3692X=m
CONFIG_LEDS_LM3601X=m
# CONFIG_LEDS_PCA9532 is not set
# CONFIG_LEDS_GPIO is not set
# CONFIG_LEDS_LP3944 is not set
# CONFIG_LEDS_LP3952 is not set
CONFIG_LEDS_LP55XX_COMMON=m
# CONFIG_LEDS_LP5521 is not set
CONFIG_LEDS_LP5523=m
# CONFIG_LEDS_LP5562 is not set
# CONFIG_LEDS_LP8501 is not set
CONFIG_LEDS_LP8860=m
CONFIG_LEDS_CLEVO_MAIL=m
# CONFIG_LEDS_PCA955X is not set
CONFIG_LEDS_PCA963X=m
# CONFIG_LEDS_WM831X_STATUS is not set
# CONFIG_LEDS_WM8350 is not set
CONFIG_LEDS_DA9052=m
CONFIG_LEDS_PWM=y
# CONFIG_LEDS_REGULATOR is not set
CONFIG_LEDS_BD2802=y
# CONFIG_LEDS_INTEL_SS4200 is not set
# CONFIG_LEDS_LT3593 is not set
CONFIG_LEDS_ADP5520=m
# CONFIG_LEDS_TCA6507 is not set
CONFIG_LEDS_TLC591XX=y
CONFIG_LEDS_MAX77650=y
CONFIG_LEDS_MAX8997=m
CONFIG_LEDS_LM355x=m
CONFIG_LEDS_MENF21BMC=m
# CONFIG_LEDS_KTD2692 is not set
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
# CONFIG_LEDS_NIC78BX is not set
# CONFIG_LEDS_TI_LMU_COMMON is not set
CONFIG_LEDS_TPS6105X=m
CONFIG_LEDS_SGM3140=m

#
# LED Triggers
#
CONFIG_LEDS_TRIGGERS=y
CONFIG_LEDS_TRIGGER_TIMER=m
CONFIG_LEDS_TRIGGER_ONESHOT=m
CONFIG_LEDS_TRIGGER_DISK=y
CONFIG_LEDS_TRIGGER_MTD=y
CONFIG_LEDS_TRIGGER_HEARTBEAT=y
CONFIG_LEDS_TRIGGER_BACKLIGHT=m
# CONFIG_LEDS_TRIGGER_CPU is not set
# CONFIG_LEDS_TRIGGER_ACTIVITY is not set
# CONFIG_LEDS_TRIGGER_GPIO is not set
# CONFIG_LEDS_TRIGGER_DEFAULT_ON is not set

#
# iptables trigger is under Netfilter config (LED target)
#
# CONFIG_LEDS_TRIGGER_TRANSIENT is not set
CONFIG_LEDS_TRIGGER_CAMERA=y
# CONFIG_LEDS_TRIGGER_PANIC is not set
CONFIG_LEDS_TRIGGER_NETDEV=m
CONFIG_LEDS_TRIGGER_PATTERN=y
CONFIG_LEDS_TRIGGER_AUDIO=m
# CONFIG_ACCESSIBILITY is not set
CONFIG_INFINIBAND=m
# CONFIG_INFINIBAND_USER_MAD is not set
# CONFIG_INFINIBAND_USER_ACCESS is not set
CONFIG_INFINIBAND_ADDR_TRANS=y
CONFIG_INFINIBAND_ADDR_TRANS_CONFIGFS=y
# CONFIG_INFINIBAND_MTHCA is not set
# CONFIG_MLX4_INFINIBAND is not set
# CONFIG_INFINIBAND_OCRDMA is not set
# CONFIG_INFINIBAND_BNXT_RE is not set
# CONFIG_INFINIBAND_RDMAVT is not set
# CONFIG_RDMA_RXE is not set
CONFIG_RDMA_SIW=m
# CONFIG_INFINIBAND_IPOIB is not set
CONFIG_INFINIBAND_SRP=m
# CONFIG_INFINIBAND_SRPT is not set
CONFIG_INFINIBAND_ISER=m
CONFIG_INFINIBAND_ISERT=m
CONFIG_INFINIBAND_RTRS=m
CONFIG_INFINIBAND_RTRS_CLIENT=m
# CONFIG_INFINIBAND_RTRS_SERVER is not set
CONFIG_INFINIBAND_OPA_VNIC=m
CONFIG_EDAC_ATOMIC_SCRUB=y
CONFIG_EDAC_SUPPORT=y
# CONFIG_EDAC is not set
CONFIG_RTC_LIB=y
CONFIG_RTC_MC146818_LIB=y
# CONFIG_RTC_CLASS is not set
CONFIG_DMADEVICES=y
CONFIG_DMADEVICES_DEBUG=y
CONFIG_DMADEVICES_VDEBUG=y

#
# DMA Devices
#
CONFIG_DMA_ENGINE=y
CONFIG_DMA_VIRTUAL_CHANNELS=y
CONFIG_DMA_ACPI=y
CONFIG_DMA_OF=y
CONFIG_ALTERA_MSGDMA=m
# CONFIG_DW_AXI_DMAC is not set
# CONFIG_FSL_EDMA is not set
CONFIG_INTEL_IDMA64=m
# CONFIG_INTEL_IOATDMA is not set
# CONFIG_PLX_DMA is not set
# CONFIG_XILINX_ZYNQMP_DPDMA is not set
# CONFIG_QCOM_HIDMA_MGMT is not set
CONFIG_QCOM_HIDMA=m
CONFIG_DW_DMAC_CORE=y
CONFIG_DW_DMAC=m
# CONFIG_DW_DMAC_PCI is not set
CONFIG_HSU_DMA=y
CONFIG_SF_PDMA=y

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
CONFIG_UDMABUF=y
CONFIG_DMABUF_MOVE_NOTIFY=y
# CONFIG_DMABUF_SELFTESTS is not set
# CONFIG_DMABUF_HEAPS is not set
# end of DMABUF options

# CONFIG_AUXDISPLAY is not set
# CONFIG_PANEL is not set
CONFIG_UIO=m
# CONFIG_UIO_CIF is not set
CONFIG_UIO_PDRV_GENIRQ=m
# CONFIG_UIO_DMEM_GENIRQ is not set
# CONFIG_UIO_AEC is not set
# CONFIG_UIO_SERCOS3 is not set
# CONFIG_UIO_PCI_GENERIC is not set
# CONFIG_UIO_NETX is not set
CONFIG_UIO_PRUSS=m
# CONFIG_UIO_MF624 is not set
# CONFIG_VIRT_DRIVERS is not set
CONFIG_VIRTIO=m
# CONFIG_VIRTIO_MENU is not set
CONFIG_VDPA=m
CONFIG_VHOST_IOTLB=y
CONFIG_VHOST=y
CONFIG_VHOST_MENU=y
CONFIG_VHOST_NET=y
CONFIG_VHOST_SCSI=m
# CONFIG_VHOST_VSOCK is not set
# CONFIG_VHOST_VDPA is not set
# CONFIG_VHOST_CROSS_ENDIAN_LEGACY is not set

#
# Microsoft Hyper-V guest support
#
# CONFIG_HYPERV is not set
# end of Microsoft Hyper-V guest support

# CONFIG_GREYBUS is not set
# CONFIG_STAGING is not set
CONFIG_X86_PLATFORM_DEVICES=y
# CONFIG_ACPI_WMI is not set
# CONFIG_ACERHDF is not set
CONFIG_ACER_WIRELESS=m
# CONFIG_APPLE_GMUX is not set
CONFIG_ASUS_LAPTOP=m
# CONFIG_ASUS_WIRELESS is not set
CONFIG_DCDBAS=y
CONFIG_DELL_SMBIOS=m
# CONFIG_DELL_SMBIOS_SMM is not set
# CONFIG_DELL_LAPTOP is not set
# CONFIG_DELL_RBTN is not set
CONFIG_DELL_RBU=m
CONFIG_DELL_SMO8800=y
CONFIG_AMILO_RFKILL=m
CONFIG_FUJITSU_LAPTOP=y
CONFIG_FUJITSU_TABLET=m
CONFIG_GPD_POCKET_FAN=m
CONFIG_HP_ACCEL=m
CONFIG_HP_WIRELESS=m
# CONFIG_IBM_RTL is not set
CONFIG_IDEAPAD_LAPTOP=m
CONFIG_SENSORS_HDAPS=m
CONFIG_THINKPAD_ACPI=m
CONFIG_THINKPAD_ACPI_DEBUGFACILITIES=y
# CONFIG_THINKPAD_ACPI_DEBUG is not set
CONFIG_THINKPAD_ACPI_UNSAFE_LEDS=y
CONFIG_THINKPAD_ACPI_VIDEO=y
# CONFIG_THINKPAD_ACPI_HOTKEY_POLL is not set
# CONFIG_INTEL_HID_EVENT is not set
# CONFIG_INTEL_INT0002_VGPIO is not set
CONFIG_INTEL_MENLOW=y
CONFIG_INTEL_OAKTRAIL=m
# CONFIG_INTEL_VBTN is not set
CONFIG_SURFACE_3_POWER_OPREGION=m
CONFIG_SURFACE_PRO3_BUTTON=m
CONFIG_MSI_LAPTOP=m
# CONFIG_PCENGINES_APU2 is not set
CONFIG_SAMSUNG_LAPTOP=m
# CONFIG_SAMSUNG_Q10 is not set
CONFIG_TOSHIBA_BT_RFKILL=m
CONFIG_TOSHIBA_HAPS=m
# CONFIG_ACPI_CMPC is not set
CONFIG_COMPAL_LAPTOP=m
CONFIG_PANASONIC_LAPTOP=m
# CONFIG_SONY_LAPTOP is not set
# CONFIG_SYSTEM76_ACPI is not set
CONFIG_TOPSTAR_LAPTOP=y
CONFIG_I2C_MULTI_INSTANTIATE=m
CONFIG_MLX_PLATFORM=y
# CONFIG_INTEL_IPS is not set
CONFIG_INTEL_RST=m
# CONFIG_INTEL_SMARTCONNECT is not set

#
# Intel Speed Select Technology interface support
#
# CONFIG_INTEL_SPEED_SELECT_INTERFACE is not set
# end of Intel Speed Select Technology interface support

# CONFIG_INTEL_UNCORE_FREQ_CONTROL is not set
# CONFIG_INTEL_BXTWC_PMIC_TMU is not set
CONFIG_INTEL_CHTDC_TI_PWRBTN=m
# CONFIG_INTEL_PMC_CORE is not set
CONFIG_INTEL_PUNIT_IPC=y
CONFIG_INTEL_SCU_IPC=y
# CONFIG_INTEL_SCU_PCI is not set
# CONFIG_INTEL_SCU_PLATFORM is not set
CONFIG_INTEL_TELEMETRY=m
CONFIG_PMC_ATOM=y
# CONFIG_GOLDFISH_PIPE is not set
CONFIG_MFD_CROS_EC=m
CONFIG_CHROME_PLATFORMS=y
CONFIG_CHROMEOS_LAPTOP=y
CONFIG_CHROMEOS_PSTORE=y
CONFIG_CHROMEOS_TBMC=y
CONFIG_CROS_EC=y
CONFIG_CROS_EC_I2C=m
CONFIG_CROS_EC_LPC=y
CONFIG_CROS_EC_PROTO=y
# CONFIG_CROS_KBD_LED_BACKLIGHT is not set
# CONFIG_CROS_EC_CHARDEV is not set
# CONFIG_CROS_EC_LIGHTBAR is not set
CONFIG_CROS_EC_VBC=m
# CONFIG_CROS_EC_DEBUGFS is not set
CONFIG_CROS_EC_SENSORHUB=m
# CONFIG_CROS_EC_SYSFS is not set
CONFIG_CROS_USBPD_LOGGER=m
CONFIG_CROS_USBPD_NOTIFY=m
# CONFIG_WILCO_EC is not set
CONFIG_MELLANOX_PLATFORM=y
CONFIG_MLXREG_HOTPLUG=m
CONFIG_MLXREG_IO=m
CONFIG_HAVE_CLK=y
CONFIG_CLKDEV_LOOKUP=y
CONFIG_HAVE_CLK_PREPARE=y
CONFIG_COMMON_CLK=y
# CONFIG_COMMON_CLK_WM831X is not set
# CONFIG_CLK_HSDK is not set
# CONFIG_COMMON_CLK_MAX77686 is not set
# CONFIG_COMMON_CLK_MAX9485 is not set
# CONFIG_COMMON_CLK_SI5341 is not set
# CONFIG_COMMON_CLK_SI5351 is not set
# CONFIG_COMMON_CLK_SI514 is not set
# CONFIG_COMMON_CLK_SI544 is not set
# CONFIG_COMMON_CLK_SI570 is not set
# CONFIG_COMMON_CLK_CDCE706 is not set
# CONFIG_COMMON_CLK_CDCE925 is not set
# CONFIG_COMMON_CLK_CS2000_CP is not set
# CONFIG_CLK_TWL6040 is not set
# CONFIG_COMMON_CLK_LOCHNAGAR is not set
# CONFIG_COMMON_CLK_PWM is not set
# CONFIG_COMMON_CLK_VC5 is not set
# CONFIG_COMMON_CLK_BD718XX is not set
# CONFIG_COMMON_CLK_FIXED_MMIO is not set
# CONFIG_CLK_LGM_CGU is not set
# CONFIG_HWSPINLOCK is not set

#
# Clock Source drivers
#
CONFIG_TIMER_OF=y
CONFIG_TIMER_PROBE=y
CONFIG_CLKEVT_I8253=y
CONFIG_I8253_LOCK=y
CONFIG_CLKBLD_I8253=y
CONFIG_CLKSRC_MMIO=y
CONFIG_MICROCHIP_PIT64B=y
# end of Clock Source drivers

CONFIG_MAILBOX=y
# CONFIG_PLATFORM_MHU is not set
# CONFIG_PCC is not set
CONFIG_ALTERA_MBOX=m
# CONFIG_MAILBOX_TEST is not set
CONFIG_IOMMU_SUPPORT=y

#
# Generic IOMMU Pagetable Support
#
# end of Generic IOMMU Pagetable Support

CONFIG_IOMMU_DEBUGFS=y
# CONFIG_AMD_IOMMU is not set

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
# CONFIG_XILINX_VCU is not set
# end of Xilinx SoC drivers
# end of SOC (System On Chip) specific Drivers

CONFIG_PM_DEVFREQ=y

#
# DEVFREQ Governors
#
CONFIG_DEVFREQ_GOV_SIMPLE_ONDEMAND=y
# CONFIG_DEVFREQ_GOV_PERFORMANCE is not set
# CONFIG_DEVFREQ_GOV_POWERSAVE is not set
CONFIG_DEVFREQ_GOV_USERSPACE=m
# CONFIG_DEVFREQ_GOV_PASSIVE is not set

#
# DEVFREQ Drivers
#
CONFIG_PM_DEVFREQ_EVENT=y
CONFIG_EXTCON=y

#
# Extcon Device Drivers
#
CONFIG_EXTCON_ADC_JACK=y
CONFIG_EXTCON_FSA9480=y
# CONFIG_EXTCON_GPIO is not set
CONFIG_EXTCON_INTEL_INT3496=y
# CONFIG_EXTCON_MAX3355 is not set
# CONFIG_EXTCON_MAX77843 is not set
CONFIG_EXTCON_MAX8997=y
CONFIG_EXTCON_PTN5150=m
CONFIG_EXTCON_RT8973A=m
CONFIG_EXTCON_SM5502=m
CONFIG_EXTCON_USB_GPIO=m
CONFIG_EXTCON_USBC_CROS_EC=y
CONFIG_MEMORY=y
CONFIG_IIO=y
CONFIG_IIO_BUFFER=y
CONFIG_IIO_BUFFER_CB=y
CONFIG_IIO_BUFFER_DMA=m
CONFIG_IIO_BUFFER_DMAENGINE=m
CONFIG_IIO_BUFFER_HW_CONSUMER=m
CONFIG_IIO_KFIFO_BUF=y
CONFIG_IIO_TRIGGERED_BUFFER=y
CONFIG_IIO_CONFIGFS=m
CONFIG_IIO_TRIGGER=y
CONFIG_IIO_CONSUMERS_PER_TRIGGER=2
CONFIG_IIO_SW_DEVICE=m
CONFIG_IIO_SW_TRIGGER=m

#
# Accelerometers
#
CONFIG_ADXL372=m
CONFIG_ADXL372_I2C=m
CONFIG_BMA180=y
CONFIG_BMA400=m
CONFIG_BMA400_I2C=m
# CONFIG_BMC150_ACCEL is not set
# CONFIG_DA280 is not set
# CONFIG_DA311 is not set
CONFIG_DMARD06=m
CONFIG_DMARD09=m
CONFIG_DMARD10=y
CONFIG_IIO_CROS_EC_ACCEL_LEGACY=m
CONFIG_IIO_ST_ACCEL_3AXIS=m
CONFIG_IIO_ST_ACCEL_I2C_3AXIS=m
CONFIG_KXSD9=y
CONFIG_KXSD9_I2C=y
# CONFIG_KXCJK1013 is not set
CONFIG_MC3230=y
CONFIG_MMA7455=y
CONFIG_MMA7455_I2C=y
CONFIG_MMA7660=m
# CONFIG_MMA8452 is not set
CONFIG_MMA9551_CORE=y
CONFIG_MMA9551=y
CONFIG_MMA9553=m
# CONFIG_MXC4005 is not set
CONFIG_MXC6255=y
# CONFIG_STK8312 is not set
CONFIG_STK8BA50=m
# end of Accelerometers

#
# Analog to digital converters
#
CONFIG_AD7091R5=m
CONFIG_AD7291=y
CONFIG_AD7606=m
CONFIG_AD7606_IFACE_PARALLEL=m
CONFIG_AD799X=y
CONFIG_ADI_AXI_ADC=m
# CONFIG_CC10001_ADC is not set
CONFIG_DA9150_GPADC=y
# CONFIG_ENVELOPE_DETECTOR is not set
# CONFIG_HX711 is not set
# CONFIG_INA2XX_ADC is not set
CONFIG_LTC2471=m
# CONFIG_LTC2485 is not set
# CONFIG_LTC2497 is not set
CONFIG_MAX1363=m
# CONFIG_MAX9611 is not set
# CONFIG_MCP3422 is not set
CONFIG_MP2629_ADC=y
CONFIG_NAU7802=m
CONFIG_QCOM_VADC_COMMON=m
CONFIG_QCOM_SPMI_IADC=y
# CONFIG_QCOM_SPMI_VADC is not set
CONFIG_QCOM_SPMI_ADC5=m
CONFIG_SD_ADC_MODULATOR=m
# CONFIG_TI_ADC081C is not set
CONFIG_TI_ADS1015=m
CONFIG_VF610_ADC=m
# CONFIG_XILINX_XADC is not set
# end of Analog to digital converters

#
# Analog Front Ends
#
CONFIG_IIO_RESCALE=m
# end of Analog Front Ends

#
# Amplifiers
#
CONFIG_HMC425=m
# end of Amplifiers

#
# Chemical Sensors
#
# CONFIG_ATLAS_PH_SENSOR is not set
CONFIG_ATLAS_EZO_SENSOR=m
# CONFIG_BME680 is not set
CONFIG_CCS811=y
# CONFIG_IAQCORE is not set
# CONFIG_SCD30_CORE is not set
CONFIG_SENSIRION_SGP30=y
CONFIG_SPS30=m
CONFIG_VZ89X=y
# end of Chemical Sensors

CONFIG_IIO_CROS_EC_SENSORS_CORE=m
# CONFIG_IIO_CROS_EC_SENSORS is not set
CONFIG_IIO_CROS_EC_SENSORS_LID_ANGLE=m

#
# Hid Sensor IIO Common
#
# end of Hid Sensor IIO Common

CONFIG_IIO_MS_SENSORS_I2C=y

#
# SSP Sensor Common
#
# end of SSP Sensor Common

CONFIG_IIO_ST_SENSORS_I2C=y
CONFIG_IIO_ST_SENSORS_CORE=y

#
# Digital to analog converters
#
CONFIG_AD5064=y
# CONFIG_AD5380 is not set
# CONFIG_AD5446 is not set
# CONFIG_AD5593R is not set
CONFIG_AD5686=m
CONFIG_AD5696_I2C=m
# CONFIG_DPOT_DAC is not set
CONFIG_DS4424=m
CONFIG_M62332=y
CONFIG_MAX517=y
# CONFIG_MAX5821 is not set
# CONFIG_MCP4725 is not set
CONFIG_TI_DAC5571=y
CONFIG_VF610_DAC=m
# end of Digital to analog converters

#
# IIO dummy driver
#
CONFIG_IIO_SIMPLE_DUMMY=m
# CONFIG_IIO_SIMPLE_DUMMY_EVENTS is not set
CONFIG_IIO_SIMPLE_DUMMY_BUFFER=y
# end of IIO dummy driver

#
# Frequency Synthesizers DDS/PLL
#

#
# Clock Generator/Distribution
#
# end of Clock Generator/Distribution

#
# Phase-Locked Loop (PLL) frequency synthesizers
#
# end of Phase-Locked Loop (PLL) frequency synthesizers
# end of Frequency Synthesizers DDS/PLL

#
# Digital gyroscope sensors
#
# CONFIG_BMG160 is not set
CONFIG_FXAS21002C=y
CONFIG_FXAS21002C_I2C=y
CONFIG_MPU3050=y
CONFIG_MPU3050_I2C=y
# CONFIG_IIO_ST_GYRO_3AXIS is not set
CONFIG_ITG3200=m
# end of Digital gyroscope sensors

#
# Health Sensors
#

#
# Heart Rate Monitors
#
CONFIG_AFE4404=m
CONFIG_MAX30100=y
# CONFIG_MAX30102 is not set
# end of Heart Rate Monitors
# end of Health Sensors

#
# Humidity sensors
#
# CONFIG_AM2315 is not set
CONFIG_DHT11=m
CONFIG_HDC100X=m
CONFIG_HTS221=y
CONFIG_HTS221_I2C=y
CONFIG_HTU21=y
CONFIG_SI7005=y
# CONFIG_SI7020 is not set
# end of Humidity sensors

#
# Inertial measurement units
#
CONFIG_BMI160=y
CONFIG_BMI160_I2C=y
CONFIG_FXOS8700=m
CONFIG_FXOS8700_I2C=m
CONFIG_KMX61=m
# CONFIG_INV_ICM42600_I2C is not set
CONFIG_INV_MPU6050_IIO=m
CONFIG_INV_MPU6050_I2C=m
# CONFIG_IIO_ST_LSM6DSX is not set
# end of Inertial measurement units

#
# Light sensors
#
# CONFIG_ACPI_ALS is not set
# CONFIG_ADJD_S311 is not set
CONFIG_ADUX1020=y
CONFIG_AL3010=y
CONFIG_AL3320A=y
# CONFIG_APDS9300 is not set
CONFIG_APDS9960=m
CONFIG_BH1750=y
CONFIG_BH1780=m
CONFIG_CM32181=m
CONFIG_CM3232=m
CONFIG_CM3323=m
# CONFIG_CM3605 is not set
CONFIG_CM36651=y
# CONFIG_IIO_CROS_EC_LIGHT_PROX is not set
CONFIG_GP2AP002=m
CONFIG_GP2AP020A00F=y
CONFIG_IQS621_ALS=m
# CONFIG_SENSORS_ISL29018 is not set
# CONFIG_SENSORS_ISL29028 is not set
# CONFIG_ISL29125 is not set
CONFIG_JSA1212=m
# CONFIG_RPR0521 is not set
# CONFIG_LTR501 is not set
CONFIG_LV0104CS=y
# CONFIG_MAX44000 is not set
# CONFIG_MAX44009 is not set
# CONFIG_NOA1305 is not set
CONFIG_OPT3001=y
CONFIG_PA12203001=m
CONFIG_SI1133=y
# CONFIG_SI1145 is not set
CONFIG_STK3310=y
CONFIG_ST_UVIS25=y
CONFIG_ST_UVIS25_I2C=y
# CONFIG_TCS3414 is not set
# CONFIG_TCS3472 is not set
CONFIG_SENSORS_TSL2563=m
CONFIG_TSL2583=y
CONFIG_TSL2772=y
CONFIG_TSL4531=m
# CONFIG_US5182D is not set
CONFIG_VCNL4000=m
CONFIG_VCNL4035=m
# CONFIG_VEML6030 is not set
CONFIG_VEML6070=m
# CONFIG_VL6180 is not set
CONFIG_ZOPT2201=y
# end of Light sensors

#
# Magnetometer sensors
#
CONFIG_AK8974=m
CONFIG_AK8975=m
CONFIG_AK09911=m
# CONFIG_BMC150_MAGN_I2C is not set
# CONFIG_MAG3110 is not set
# CONFIG_MMC35240 is not set
CONFIG_IIO_ST_MAGN_3AXIS=y
CONFIG_IIO_ST_MAGN_I2C_3AXIS=y
# CONFIG_SENSORS_HMC5843_I2C is not set
CONFIG_SENSORS_RM3100=y
CONFIG_SENSORS_RM3100_I2C=y
# end of Magnetometer sensors

#
# Multiplexers
#
CONFIG_IIO_MUX=y
# end of Multiplexers

#
# Inclinometer sensors
#
# end of Inclinometer sensors

#
# Triggers - standalone
#
CONFIG_IIO_HRTIMER_TRIGGER=m
CONFIG_IIO_INTERRUPT_TRIGGER=y
CONFIG_IIO_TIGHTLOOP_TRIGGER=m
CONFIG_IIO_SYSFS_TRIGGER=m
# end of Triggers - standalone

#
# Linear and angular position sensors
#
CONFIG_IQS624_POS=m
# end of Linear and angular position sensors

#
# Digital potentiometers
#
# CONFIG_AD5272 is not set
# CONFIG_DS1803 is not set
# CONFIG_MAX5432 is not set
# CONFIG_MCP4018 is not set
CONFIG_MCP4531=m
CONFIG_TPL0102=m
# end of Digital potentiometers

#
# Digital potentiostats
#
CONFIG_LMP91000=m
# end of Digital potentiostats

#
# Pressure sensors
#
CONFIG_ABP060MG=y
# CONFIG_BMP280 is not set
CONFIG_IIO_CROS_EC_BARO=m
CONFIG_DLHL60D=m
CONFIG_DPS310=y
CONFIG_HP03=m
CONFIG_ICP10100=y
CONFIG_MPL115=m
CONFIG_MPL115_I2C=m
CONFIG_MPL3115=y
CONFIG_MS5611=y
# CONFIG_MS5611_I2C is not set
# CONFIG_MS5637 is not set
# CONFIG_IIO_ST_PRESS is not set
CONFIG_T5403=m
CONFIG_HP206C=y
# CONFIG_ZPA2326 is not set
# end of Pressure sensors

#
# Lightning sensors
#
# end of Lightning sensors

#
# Proximity and distance sensors
#
CONFIG_ISL29501=y
# CONFIG_LIDAR_LITE_V2 is not set
CONFIG_MB1232=m
# CONFIG_PING is not set
# CONFIG_RFD77402 is not set
CONFIG_SRF04=m
CONFIG_SX9310=m
CONFIG_SX9500=y
CONFIG_SRF08=y
CONFIG_VCNL3020=y
CONFIG_VL53L0X_I2C=y
# end of Proximity and distance sensors

#
# Resolver to digital converters
#
# end of Resolver to digital converters

#
# Temperature sensors
#
CONFIG_IQS620AT_TEMP=m
CONFIG_MLX90614=y
CONFIG_MLX90632=m
CONFIG_TMP006=y
# CONFIG_TMP007 is not set
CONFIG_TSYS01=y
CONFIG_TSYS02D=y
# end of Temperature sensors

# CONFIG_NTB is not set
# CONFIG_VME_BUS is not set
CONFIG_PWM=y
CONFIG_PWM_SYSFS=y
CONFIG_PWM_DEBUG=y
# CONFIG_PWM_ATMEL_HLCDC_PWM is not set
# CONFIG_PWM_CROS_EC is not set
CONFIG_PWM_FSL_FTM=m
CONFIG_PWM_IQS620A=m
CONFIG_PWM_LP3943=m
# CONFIG_PWM_LPSS_PCI is not set
# CONFIG_PWM_LPSS_PLATFORM is not set
# CONFIG_PWM_PCA9685 is not set

#
# IRQ chip support
#
CONFIG_IRQCHIP=y
# CONFIG_AL_FIC is not set
CONFIG_MADERA_IRQ=m
# end of IRQ chip support

CONFIG_IPACK_BUS=m
# CONFIG_BOARD_TPCI200 is not set
# CONFIG_SERIAL_IPOCTAL is not set
CONFIG_RESET_CONTROLLER=y
CONFIG_RESET_BRCMSTB_RESCAL=y
# CONFIG_RESET_INTEL_GW is not set
CONFIG_RESET_TI_SYSCON=m

#
# PHY Subsystem
#
CONFIG_GENERIC_PHY=y
CONFIG_GENERIC_PHY_MIPI_DPHY=y
# CONFIG_BCM_KONA_USB2_PHY is not set
# CONFIG_PHY_CADENCE_TORRENT is not set
# CONFIG_PHY_CADENCE_DPHY is not set
# CONFIG_PHY_CADENCE_SIERRA is not set
CONFIG_PHY_CADENCE_SALVO=y
# CONFIG_PHY_FSL_IMX8MQ_USB is not set
CONFIG_PHY_MIXEL_MIPI_DPHY=y
CONFIG_PHY_PXA_28NM_HSIC=y
CONFIG_PHY_PXA_28NM_USB2=y
# CONFIG_PHY_CPCAP_USB is not set
# CONFIG_PHY_MAPPHONE_MDM6600 is not set
CONFIG_PHY_OCELOT_SERDES=m
CONFIG_PHY_INTEL_COMBO=y
CONFIG_PHY_INTEL_EMMC=m
# end of PHY Subsystem

# CONFIG_POWERCAP is not set
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
CONFIG_ANDROID_BINDER_IPC=y
CONFIG_ANDROID_BINDERFS=y
CONFIG_ANDROID_BINDER_DEVICES="binder,hwbinder,vndbinder"
CONFIG_ANDROID_BINDER_IPC_SELFTEST=y
# end of Android

# CONFIG_LIBNVDIMM is not set
# CONFIG_DAX is not set
CONFIG_NVMEM=y
# CONFIG_NVMEM_SYSFS is not set
CONFIG_NVMEM_SPMI_SDAM=m

#
# HW tracing support
#
# CONFIG_STM is not set
CONFIG_INTEL_TH=y
# CONFIG_INTEL_TH_PCI is not set
CONFIG_INTEL_TH_ACPI=y
CONFIG_INTEL_TH_GTH=y
CONFIG_INTEL_TH_MSU=y
# CONFIG_INTEL_TH_PTI is not set
# CONFIG_INTEL_TH_DEBUG is not set
# end of HW tracing support

# CONFIG_FPGA is not set
CONFIG_FSI=m
# CONFIG_FSI_NEW_DEV_NODE is not set
# CONFIG_FSI_MASTER_GPIO is not set
CONFIG_FSI_MASTER_HUB=m
CONFIG_FSI_MASTER_ASPEED=m
# CONFIG_FSI_SCOM is not set
CONFIG_FSI_SBEFIFO=m
CONFIG_FSI_OCC=m
# CONFIG_TEE is not set
CONFIG_MULTIPLEXER=y

#
# Multiplexer drivers
#
CONFIG_MUX_ADG792A=y
CONFIG_MUX_GPIO=y
CONFIG_MUX_MMIO=y
# end of Multiplexer drivers

CONFIG_PM_OPP=y
# CONFIG_UNISYS_VISORBUS is not set
CONFIG_SIOX=m
CONFIG_SIOX_BUS_GPIO=m
CONFIG_SLIMBUS=y
# CONFIG_SLIM_QCOM_CTRL is not set
CONFIG_INTERCONNECT=y
CONFIG_COUNTER=y
# CONFIG_FTM_QUADDEC is not set
# CONFIG_MICROCHIP_TCB_CAPTURE is not set
# CONFIG_MOST is not set
# end of Device Drivers

#
# File systems
#
CONFIG_DCACHE_WORD_ACCESS=y
# CONFIG_VALIDATE_FS_PARSER is not set
CONFIG_FS_IOMAP=y
CONFIG_EXT2_FS=y
CONFIG_EXT2_FS_XATTR=y
CONFIG_EXT2_FS_POSIX_ACL=y
# CONFIG_EXT2_FS_SECURITY is not set
CONFIG_EXT3_FS=y
CONFIG_EXT3_FS_POSIX_ACL=y
# CONFIG_EXT3_FS_SECURITY is not set
CONFIG_EXT4_FS=y
CONFIG_EXT4_FS_POSIX_ACL=y
CONFIG_EXT4_FS_SECURITY=y
CONFIG_EXT4_DEBUG=y
CONFIG_EXT4_KUNIT_TESTS=m
CONFIG_JBD2=y
CONFIG_JBD2_DEBUG=y
CONFIG_FS_MBCACHE=y
# CONFIG_REISERFS_FS is not set
CONFIG_JFS_FS=m
# CONFIG_JFS_POSIX_ACL is not set
CONFIG_JFS_SECURITY=y
# CONFIG_JFS_DEBUG is not set
CONFIG_JFS_STATISTICS=y
CONFIG_XFS_FS=y
CONFIG_XFS_QUOTA=y
CONFIG_XFS_POSIX_ACL=y
# CONFIG_XFS_RT is not set
# CONFIG_XFS_ONLINE_SCRUB is not set
CONFIG_XFS_WARN=y
# CONFIG_XFS_DEBUG is not set
CONFIG_GFS2_FS=m
# CONFIG_GFS2_FS_LOCKING_DLM is not set
CONFIG_OCFS2_FS=m
# CONFIG_OCFS2_FS_O2CB is not set
CONFIG_OCFS2_FS_USERSPACE_CLUSTER=m
# CONFIG_OCFS2_FS_STATS is not set
# CONFIG_OCFS2_DEBUG_MASKLOG is not set
CONFIG_OCFS2_DEBUG_FS=y
CONFIG_BTRFS_FS=y
CONFIG_BTRFS_FS_POSIX_ACL=y
# CONFIG_BTRFS_FS_CHECK_INTEGRITY is not set
# CONFIG_BTRFS_FS_RUN_SANITY_TESTS is not set
# CONFIG_BTRFS_DEBUG is not set
# CONFIG_BTRFS_ASSERT is not set
CONFIG_BTRFS_FS_REF_VERIFY=y
CONFIG_NILFS2_FS=y
CONFIG_F2FS_FS=y
# CONFIG_F2FS_STAT_FS is not set
# CONFIG_F2FS_FS_XATTR is not set
CONFIG_F2FS_CHECK_FS=y
CONFIG_F2FS_IO_TRACE=y
# CONFIG_F2FS_FAULT_INJECTION is not set
# CONFIG_F2FS_FS_COMPRESSION is not set
CONFIG_ZONEFS_FS=m
# CONFIG_FS_DAX is not set
CONFIG_FS_POSIX_ACL=y
CONFIG_EXPORTFS=y
# CONFIG_EXPORTFS_BLOCK_OPS is not set
CONFIG_FILE_LOCKING=y
CONFIG_MANDATORY_FILE_LOCKING=y
# CONFIG_FS_ENCRYPTION is not set
# CONFIG_FS_VERITY is not set
CONFIG_FSNOTIFY=y
# CONFIG_DNOTIFY is not set
CONFIG_INOTIFY_USER=y
CONFIG_FANOTIFY=y
CONFIG_QUOTA=y
CONFIG_QUOTA_NETLINK_INTERFACE=y
# CONFIG_PRINT_QUOTA_WARNING is not set
# CONFIG_QUOTA_DEBUG is not set
CONFIG_QUOTA_TREE=m
CONFIG_QFMT_V1=y
CONFIG_QFMT_V2=m
CONFIG_QUOTACTL=y
CONFIG_QUOTACTL_COMPAT=y
CONFIG_AUTOFS4_FS=y
CONFIG_AUTOFS_FS=y
CONFIG_FUSE_FS=y
# CONFIG_CUSE is not set
CONFIG_VIRTIO_FS=m
CONFIG_OVERLAY_FS=y
CONFIG_OVERLAY_FS_REDIRECT_DIR=y
CONFIG_OVERLAY_FS_REDIRECT_ALWAYS_FOLLOW=y
# CONFIG_OVERLAY_FS_INDEX is not set
# CONFIG_OVERLAY_FS_XINO_AUTO is not set
CONFIG_OVERLAY_FS_METACOPY=y

#
# Caches
#
CONFIG_FSCACHE=y
# CONFIG_FSCACHE_STATS is not set
# CONFIG_FSCACHE_HISTOGRAM is not set
# CONFIG_FSCACHE_DEBUG is not set
CONFIG_FSCACHE_OBJECT_LIST=y
CONFIG_CACHEFILES=y
# CONFIG_CACHEFILES_DEBUG is not set
CONFIG_CACHEFILES_HISTOGRAM=y
# end of Caches

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=y
# CONFIG_JOLIET is not set
# CONFIG_ZISOFS is not set
CONFIG_UDF_FS=y
# end of CD-ROM/DVD Filesystems

#
# DOS/FAT/EXFAT/NT Filesystems
#
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
# CONFIG_VFAT_FS is not set
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_EXFAT_FS=y
CONFIG_EXFAT_DEFAULT_IOCHARSET="utf8"
CONFIG_NTFS_FS=y
# CONFIG_NTFS_DEBUG is not set
# CONFIG_NTFS_RW is not set
# end of DOS/FAT/EXFAT/NT Filesystems

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
# CONFIG_PROC_KCORE is not set
CONFIG_PROC_VMCORE=y
# CONFIG_PROC_VMCORE_DEVICE_DUMP is not set
CONFIG_PROC_SYSCTL=y
CONFIG_PROC_PAGE_MONITOR=y
CONFIG_PROC_CHILDREN=y
CONFIG_PROC_PID_ARCH_STATUS=y
CONFIG_KERNFS=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
# CONFIG_TMPFS_POSIX_ACL is not set
# CONFIG_TMPFS_XATTR is not set
# CONFIG_TMPFS_INODE64 is not set
# CONFIG_HUGETLBFS is not set
CONFIG_MEMFD_CREATE=y
CONFIG_ARCH_HAS_GIGANTIC_PAGE=y
CONFIG_CONFIGFS_FS=y
# end of Pseudo filesystems

CONFIG_MISC_FILESYSTEMS=y
CONFIG_ORANGEFS_FS=m
CONFIG_ADFS_FS=y
CONFIG_ADFS_FS_RW=y
CONFIG_AFFS_FS=m
CONFIG_ECRYPT_FS=m
CONFIG_ECRYPT_FS_MESSAGING=y
CONFIG_HFS_FS=y
CONFIG_HFSPLUS_FS=y
CONFIG_BEFS_FS=y
CONFIG_BEFS_DEBUG=y
# CONFIG_BFS_FS is not set
CONFIG_EFS_FS=m
CONFIG_JFFS2_FS=y
CONFIG_JFFS2_FS_DEBUG=0
# CONFIG_JFFS2_FS_WRITEBUFFER is not set
# CONFIG_JFFS2_SUMMARY is not set
CONFIG_JFFS2_FS_XATTR=y
CONFIG_JFFS2_FS_POSIX_ACL=y
CONFIG_JFFS2_FS_SECURITY=y
# CONFIG_JFFS2_COMPRESSION_OPTIONS is not set
CONFIG_JFFS2_ZLIB=y
CONFIG_JFFS2_RTIME=y
CONFIG_UBIFS_FS=m
# CONFIG_UBIFS_FS_ADVANCED_COMPR is not set
CONFIG_UBIFS_FS_LZO=y
CONFIG_UBIFS_FS_ZLIB=y
CONFIG_UBIFS_FS_ZSTD=y
# CONFIG_UBIFS_ATIME_SUPPORT is not set
CONFIG_UBIFS_FS_XATTR=y
CONFIG_UBIFS_FS_SECURITY=y
CONFIG_UBIFS_FS_AUTHENTICATION=y
CONFIG_CRAMFS=y
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
CONFIG_SQUASHFS_LZ4=y
# CONFIG_SQUASHFS_LZO is not set
# CONFIG_SQUASHFS_XZ is not set
CONFIG_SQUASHFS_ZSTD=y
CONFIG_SQUASHFS_4K_DEVBLK_SIZE=y
CONFIG_SQUASHFS_EMBEDDED=y
CONFIG_SQUASHFS_FRAGMENT_CACHE_SIZE=3
CONFIG_VXFS_FS=y
CONFIG_MINIX_FS=y
# CONFIG_OMFS_FS is not set
# CONFIG_HPFS_FS is not set
CONFIG_QNX4FS_FS=m
CONFIG_QNX6FS_FS=y
# CONFIG_QNX6FS_DEBUG is not set
CONFIG_ROMFS_FS=y
# CONFIG_ROMFS_BACKED_BY_BLOCK is not set
# CONFIG_ROMFS_BACKED_BY_MTD is not set
CONFIG_ROMFS_BACKED_BY_BOTH=y
CONFIG_ROMFS_ON_BLOCK=y
CONFIG_ROMFS_ON_MTD=y
CONFIG_PSTORE=y
CONFIG_PSTORE_DEFLATE_COMPRESS=m
CONFIG_PSTORE_LZO_COMPRESS=y
CONFIG_PSTORE_LZ4_COMPRESS=y
CONFIG_PSTORE_LZ4HC_COMPRESS=m
CONFIG_PSTORE_842_COMPRESS=y
CONFIG_PSTORE_ZSTD_COMPRESS=y
CONFIG_PSTORE_COMPRESS=y
# CONFIG_PSTORE_DEFLATE_COMPRESS_DEFAULT is not set
# CONFIG_PSTORE_LZO_COMPRESS_DEFAULT is not set
CONFIG_PSTORE_LZ4_COMPRESS_DEFAULT=y
# CONFIG_PSTORE_LZ4HC_COMPRESS_DEFAULT is not set
# CONFIG_PSTORE_842_COMPRESS_DEFAULT is not set
# CONFIG_PSTORE_ZSTD_COMPRESS_DEFAULT is not set
CONFIG_PSTORE_COMPRESS_DEFAULT="lz4"
CONFIG_PSTORE_CONSOLE=y
# CONFIG_PSTORE_PMSG is not set
# CONFIG_PSTORE_FTRACE is not set
CONFIG_PSTORE_RAM=y
CONFIG_PSTORE_ZONE=m
CONFIG_PSTORE_BLK=m
CONFIG_PSTORE_BLK_BLKDEV=""
CONFIG_PSTORE_BLK_KMSG_SIZE=64
CONFIG_PSTORE_BLK_MAX_REASON=2
CONFIG_PSTORE_BLK_CONSOLE_SIZE=64
# CONFIG_SYSV_FS is not set
CONFIG_UFS_FS=y
CONFIG_UFS_FS_WRITE=y
CONFIG_UFS_DEBUG=y
# CONFIG_EROFS_FS is not set
# CONFIG_NETWORK_FILESYSTEMS is not set
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
# CONFIG_NLS_CODEPAGE_437 is not set
CONFIG_NLS_CODEPAGE_737=y
CONFIG_NLS_CODEPAGE_775=m
# CONFIG_NLS_CODEPAGE_850 is not set
CONFIG_NLS_CODEPAGE_852=m
CONFIG_NLS_CODEPAGE_855=y
CONFIG_NLS_CODEPAGE_857=y
CONFIG_NLS_CODEPAGE_860=y
# CONFIG_NLS_CODEPAGE_861 is not set
# CONFIG_NLS_CODEPAGE_862 is not set
CONFIG_NLS_CODEPAGE_863=y
CONFIG_NLS_CODEPAGE_864=y
# CONFIG_NLS_CODEPAGE_865 is not set
CONFIG_NLS_CODEPAGE_866=m
CONFIG_NLS_CODEPAGE_869=y
CONFIG_NLS_CODEPAGE_936=m
# CONFIG_NLS_CODEPAGE_950 is not set
CONFIG_NLS_CODEPAGE_932=y
CONFIG_NLS_CODEPAGE_949=m
# CONFIG_NLS_CODEPAGE_874 is not set
CONFIG_NLS_ISO8859_8=m
CONFIG_NLS_CODEPAGE_1250=y
CONFIG_NLS_CODEPAGE_1251=y
CONFIG_NLS_ASCII=y
CONFIG_NLS_ISO8859_1=y
CONFIG_NLS_ISO8859_2=y
# CONFIG_NLS_ISO8859_3 is not set
CONFIG_NLS_ISO8859_4=y
# CONFIG_NLS_ISO8859_5 is not set
# CONFIG_NLS_ISO8859_6 is not set
# CONFIG_NLS_ISO8859_7 is not set
CONFIG_NLS_ISO8859_9=m
CONFIG_NLS_ISO8859_13=m
CONFIG_NLS_ISO8859_14=m
# CONFIG_NLS_ISO8859_15 is not set
CONFIG_NLS_KOI8_R=m
# CONFIG_NLS_KOI8_U is not set
CONFIG_NLS_MAC_ROMAN=m
CONFIG_NLS_MAC_CELTIC=m
CONFIG_NLS_MAC_CENTEURO=m
# CONFIG_NLS_MAC_CROATIAN is not set
CONFIG_NLS_MAC_CYRILLIC=m
CONFIG_NLS_MAC_GAELIC=m
CONFIG_NLS_MAC_GREEK=y
# CONFIG_NLS_MAC_ICELAND is not set
CONFIG_NLS_MAC_INUIT=m
CONFIG_NLS_MAC_ROMANIAN=y
CONFIG_NLS_MAC_TURKISH=m
CONFIG_NLS_UTF8=y
CONFIG_DLM=m
# CONFIG_DLM_DEBUG is not set
# CONFIG_UNICODE is not set
CONFIG_IO_WQ=y
# end of File systems

#
# Security options
#
CONFIG_KEYS=y
# CONFIG_KEYS_REQUEST_CACHE is not set
CONFIG_PERSISTENT_KEYRINGS=y
CONFIG_TRUSTED_KEYS=m
# CONFIG_ENCRYPTED_KEYS is not set
CONFIG_KEY_DH_OPERATIONS=y
CONFIG_KEY_NOTIFICATIONS=y
CONFIG_SECURITY_DMESG_RESTRICT=y
# CONFIG_SECURITY is not set
CONFIG_SECURITYFS=y
# CONFIG_PAGE_TABLE_ISOLATION is not set
CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
CONFIG_HARDENED_USERCOPY=y
CONFIG_HARDENED_USERCOPY_FALLBACK=y
# CONFIG_FORTIFY_SOURCE is not set
CONFIG_STATIC_USERMODEHELPER=y
CONFIG_STATIC_USERMODEHELPER_PATH="/sbin/usermode-helper"
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

CONFIG_XOR_BLOCKS=y
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
CONFIG_CRYPTO_USER=m
CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
CONFIG_CRYPTO_GF128MUL=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_NULL2=y
# CONFIG_CRYPTO_PCRYPT is not set
CONFIG_CRYPTO_CRYPTD=y
CONFIG_CRYPTO_AUTHENC=y
CONFIG_CRYPTO_TEST=m
CONFIG_CRYPTO_SIMD=y
CONFIG_CRYPTO_GLUE_HELPER_X86=y
CONFIG_CRYPTO_ENGINE=y

#
# Public-key cryptography
#
CONFIG_CRYPTO_RSA=y
CONFIG_CRYPTO_DH=y
CONFIG_CRYPTO_ECC=y
CONFIG_CRYPTO_ECDH=y
CONFIG_CRYPTO_ECRDSA=m
CONFIG_CRYPTO_CURVE25519=y
CONFIG_CRYPTO_CURVE25519_X86=y

#
# Authenticated Encryption with Associated Data
#
CONFIG_CRYPTO_CCM=m
CONFIG_CRYPTO_GCM=y
CONFIG_CRYPTO_CHACHA20POLY1305=y
# CONFIG_CRYPTO_AEGIS128 is not set
# CONFIG_CRYPTO_AEGIS128_AESNI_SSE2 is not set
CONFIG_CRYPTO_SEQIV=m
CONFIG_CRYPTO_ECHAINIV=m

#
# Block modes
#
CONFIG_CRYPTO_CBC=y
CONFIG_CRYPTO_CFB=y
CONFIG_CRYPTO_CTR=y
# CONFIG_CRYPTO_CTS is not set
CONFIG_CRYPTO_ECB=y
CONFIG_CRYPTO_LRW=m
CONFIG_CRYPTO_OFB=m
CONFIG_CRYPTO_PCBC=y
CONFIG_CRYPTO_XTS=y
# CONFIG_CRYPTO_KEYWRAP is not set
CONFIG_CRYPTO_NHPOLY1305=m
CONFIG_CRYPTO_NHPOLY1305_SSE2=m
CONFIG_CRYPTO_NHPOLY1305_AVX2=m
# CONFIG_CRYPTO_ADIANTUM is not set
CONFIG_CRYPTO_ESSIV=m

#
# Hash modes
#
CONFIG_CRYPTO_CMAC=y
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_XCBC=m
# CONFIG_CRYPTO_VMAC is not set

#
# Digest
#
CONFIG_CRYPTO_CRC32C=y
CONFIG_CRYPTO_CRC32C_INTEL=m
CONFIG_CRYPTO_CRC32=y
CONFIG_CRYPTO_CRC32_PCLMUL=y
CONFIG_CRYPTO_XXHASH=y
CONFIG_CRYPTO_BLAKE2B=y
CONFIG_CRYPTO_BLAKE2S=m
CONFIG_CRYPTO_BLAKE2S_X86=m
CONFIG_CRYPTO_CRCT10DIF=y
CONFIG_CRYPTO_CRCT10DIF_PCLMUL=y
CONFIG_CRYPTO_GHASH=y
CONFIG_CRYPTO_POLY1305=y
CONFIG_CRYPTO_POLY1305_X86_64=m
CONFIG_CRYPTO_MD4=m
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_MICHAEL_MIC=y
# CONFIG_CRYPTO_RMD128 is not set
CONFIG_CRYPTO_RMD160=m
CONFIG_CRYPTO_RMD256=y
# CONFIG_CRYPTO_RMD320 is not set
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA1_SSSE3=m
CONFIG_CRYPTO_SHA256_SSSE3=m
# CONFIG_CRYPTO_SHA512_SSSE3 is not set
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
CONFIG_CRYPTO_SHA3=y
CONFIG_CRYPTO_SM3=y
CONFIG_CRYPTO_STREEBOG=y
# CONFIG_CRYPTO_TGR192 is not set
CONFIG_CRYPTO_WP512=m
CONFIG_CRYPTO_GHASH_CLMUL_NI_INTEL=m

#
# Ciphers
#
CONFIG_CRYPTO_AES=y
CONFIG_CRYPTO_AES_TI=m
CONFIG_CRYPTO_AES_NI_INTEL=m
CONFIG_CRYPTO_ANUBIS=m
CONFIG_CRYPTO_ARC4=m
CONFIG_CRYPTO_BLOWFISH=m
CONFIG_CRYPTO_BLOWFISH_COMMON=y
CONFIG_CRYPTO_BLOWFISH_X86_64=y
CONFIG_CRYPTO_CAMELLIA=m
CONFIG_CRYPTO_CAMELLIA_X86_64=m
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX_X86_64=m
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX2_X86_64=m
CONFIG_CRYPTO_CAST_COMMON=y
CONFIG_CRYPTO_CAST5=y
# CONFIG_CRYPTO_CAST5_AVX_X86_64 is not set
CONFIG_CRYPTO_CAST6=y
CONFIG_CRYPTO_CAST6_AVX_X86_64=y
CONFIG_CRYPTO_DES=y
# CONFIG_CRYPTO_DES3_EDE_X86_64 is not set
CONFIG_CRYPTO_FCRYPT=y
CONFIG_CRYPTO_KHAZAD=m
CONFIG_CRYPTO_SALSA20=y
CONFIG_CRYPTO_CHACHA20=y
CONFIG_CRYPTO_CHACHA20_X86_64=y
CONFIG_CRYPTO_SEED=y
CONFIG_CRYPTO_SERPENT=y
CONFIG_CRYPTO_SERPENT_SSE2_X86_64=y
# CONFIG_CRYPTO_SERPENT_AVX_X86_64 is not set
# CONFIG_CRYPTO_SERPENT_AVX2_X86_64 is not set
# CONFIG_CRYPTO_SM4 is not set
CONFIG_CRYPTO_TEA=y
# CONFIG_CRYPTO_TWOFISH is not set
CONFIG_CRYPTO_TWOFISH_COMMON=m
CONFIG_CRYPTO_TWOFISH_X86_64=m
CONFIG_CRYPTO_TWOFISH_X86_64_3WAY=m
CONFIG_CRYPTO_TWOFISH_AVX_X86_64=m

#
# Compression
#
CONFIG_CRYPTO_DEFLATE=m
CONFIG_CRYPTO_LZO=y
CONFIG_CRYPTO_842=y
CONFIG_CRYPTO_LZ4=y
CONFIG_CRYPTO_LZ4HC=m
CONFIG_CRYPTO_ZSTD=y

#
# Random Number Generation
#
# CONFIG_CRYPTO_ANSI_CPRNG is not set
CONFIG_CRYPTO_DRBG_MENU=y
CONFIG_CRYPTO_DRBG_HMAC=y
# CONFIG_CRYPTO_DRBG_HASH is not set
# CONFIG_CRYPTO_DRBG_CTR is not set
CONFIG_CRYPTO_DRBG=y
CONFIG_CRYPTO_JITTERENTROPY=y
CONFIG_CRYPTO_USER_API=m
# CONFIG_CRYPTO_USER_API_HASH is not set
CONFIG_CRYPTO_USER_API_SKCIPHER=m
# CONFIG_CRYPTO_USER_API_RNG is not set
CONFIG_CRYPTO_USER_API_AEAD=m
CONFIG_CRYPTO_STATS=y
CONFIG_CRYPTO_HASH_INFO=y

#
# Crypto library routines
#
CONFIG_CRYPTO_LIB_AES=y
CONFIG_CRYPTO_LIB_ARC4=m
CONFIG_CRYPTO_ARCH_HAVE_LIB_BLAKE2S=m
CONFIG_CRYPTO_LIB_BLAKE2S_GENERIC=m
CONFIG_CRYPTO_LIB_BLAKE2S=m
CONFIG_CRYPTO_ARCH_HAVE_LIB_CHACHA=y
CONFIG_CRYPTO_LIB_CHACHA_GENERIC=y
CONFIG_CRYPTO_LIB_CHACHA=m
CONFIG_CRYPTO_ARCH_HAVE_LIB_CURVE25519=y
CONFIG_CRYPTO_LIB_CURVE25519_GENERIC=y
CONFIG_CRYPTO_LIB_CURVE25519=y
CONFIG_CRYPTO_LIB_DES=y
CONFIG_CRYPTO_LIB_POLY1305_RSIZE=11
CONFIG_CRYPTO_ARCH_HAVE_LIB_POLY1305=m
CONFIG_CRYPTO_LIB_POLY1305_GENERIC=y
CONFIG_CRYPTO_LIB_POLY1305=m
CONFIG_CRYPTO_LIB_CHACHA20POLY1305=m
CONFIG_CRYPTO_LIB_SHA256=y
CONFIG_CRYPTO_HW=y
CONFIG_CRYPTO_DEV_PADLOCK=m
# CONFIG_CRYPTO_DEV_PADLOCK_AES is not set
CONFIG_CRYPTO_DEV_PADLOCK_SHA=m
CONFIG_CRYPTO_DEV_ATMEL_I2C=m
CONFIG_CRYPTO_DEV_ATMEL_ECC=m
# CONFIG_CRYPTO_DEV_ATMEL_SHA204A is not set
# CONFIG_CRYPTO_DEV_CCP is not set
# CONFIG_CRYPTO_DEV_QAT_DH895xCC is not set
# CONFIG_CRYPTO_DEV_QAT_C3XXX is not set
# CONFIG_CRYPTO_DEV_QAT_C62X is not set
# CONFIG_CRYPTO_DEV_QAT_DH895xCCVF is not set
# CONFIG_CRYPTO_DEV_QAT_C3XXXVF is not set
# CONFIG_CRYPTO_DEV_QAT_C62XVF is not set
# CONFIG_CRYPTO_DEV_VIRTIO is not set
CONFIG_CRYPTO_DEV_SAFEXCEL=y
# CONFIG_CRYPTO_DEV_CCREE is not set
CONFIG_CRYPTO_DEV_AMLOGIC_GXL=y
CONFIG_CRYPTO_DEV_AMLOGIC_GXL_DEBUG=y
CONFIG_ASYMMETRIC_KEY_TYPE=y
CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=y
CONFIG_ASYMMETRIC_TPM_KEY_SUBTYPE=m
CONFIG_X509_CERTIFICATE_PARSER=y
CONFIG_PKCS8_PRIVATE_KEY_PARSER=y
# CONFIG_TPM_KEY_PARSER is not set
CONFIG_PKCS7_MESSAGE_PARSER=y
CONFIG_PKCS7_TEST_KEY=m
# CONFIG_SIGNED_PE_FILE_VERIFICATION is not set

#
# Certificates for signature checking
#
CONFIG_MODULE_SIG_KEY="certs/signing_key.pem"
CONFIG_SYSTEM_TRUSTED_KEYRING=y
CONFIG_SYSTEM_TRUSTED_KEYS=""
CONFIG_SYSTEM_EXTRA_CERTIFICATE=y
CONFIG_SYSTEM_EXTRA_CERTIFICATE_SIZE=4096
CONFIG_SECONDARY_TRUSTED_KEYRING=y
CONFIG_SYSTEM_BLACKLIST_KEYRING=y
CONFIG_SYSTEM_BLACKLIST_HASH_LIST=""
# end of Certificates for signature checking

CONFIG_BINARY_PRINTF=y

#
# Library routines
#
CONFIG_RAID6_PQ=y
# CONFIG_RAID6_PQ_BENCHMARK is not set
CONFIG_LINEAR_RANGES=y
CONFIG_PACKING=y
CONFIG_BITREVERSE=y
CONFIG_GENERIC_STRNCPY_FROM_USER=y
CONFIG_GENERIC_STRNLEN_USER=y
CONFIG_GENERIC_NET_UTILS=y
CONFIG_GENERIC_FIND_FIRST_BIT=y
CONFIG_CORDIC=y
CONFIG_PRIME_NUMBERS=m
CONFIG_RATIONAL=y
CONFIG_GENERIC_PCI_IOMAP=y
CONFIG_GENERIC_IOMAP=y
CONFIG_ARCH_USE_CMPXCHG_LOCKREF=y
CONFIG_ARCH_HAS_FAST_MULTIPLIER=y
CONFIG_ARCH_USE_SYM_ANNOTATIONS=y
CONFIG_CRC_CCITT=y
CONFIG_CRC16=y
CONFIG_CRC_T10DIF=y
CONFIG_CRC_ITU_T=y
CONFIG_CRC32=y
# CONFIG_CRC32_SELFTEST is not set
# CONFIG_CRC32_SLICEBY8 is not set
# CONFIG_CRC32_SLICEBY4 is not set
# CONFIG_CRC32_SARWATE is not set
CONFIG_CRC32_BIT=y
CONFIG_CRC64=y
CONFIG_CRC4=m
# CONFIG_CRC7 is not set
CONFIG_LIBCRC32C=y
CONFIG_CRC8=y
CONFIG_XXHASH=y
CONFIG_RANDOM32_SELFTEST=y
CONFIG_842_COMPRESS=y
CONFIG_842_DECOMPRESS=y
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_LZO_COMPRESS=y
CONFIG_LZO_DECOMPRESS=y
CONFIG_LZ4_COMPRESS=y
CONFIG_LZ4HC_COMPRESS=m
CONFIG_LZ4_DECOMPRESS=y
CONFIG_ZSTD_COMPRESS=y
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
CONFIG_REED_SOLOMON=y
CONFIG_REED_SOLOMON_ENC8=y
CONFIG_REED_SOLOMON_DEC8=y
CONFIG_REED_SOLOMON_DEC16=y
CONFIG_BCH=m
CONFIG_TEXTSEARCH=y
CONFIG_TEXTSEARCH_KMP=y
CONFIG_TEXTSEARCH_BM=y
CONFIG_TEXTSEARCH_FSM=y
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
CONFIG_CMA_SIZE_MBYTES=0
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
CONFIG_GLOB_SELFTEST=m
CONFIG_NLATTR=y
CONFIG_CLZ_TAB=y
CONFIG_IRQ_POLL=y
CONFIG_MPILIB=y
CONFIG_DIMLIB=y
CONFIG_LIBFDT=y
CONFIG_OID_REGISTRY=y
CONFIG_HAVE_GENERIC_VDSO=y
CONFIG_GENERIC_GETTIMEOFDAY=y
CONFIG_GENERIC_VDSO_TIME_NS=y
CONFIG_FONT_SUPPORT=y
# CONFIG_FONTS is not set
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y
CONFIG_SG_POOL=y
CONFIG_ARCH_HAS_PMEM_API=y
CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE=y
CONFIG_ARCH_HAS_UACCESS_MCSAFE=y
CONFIG_ARCH_STACKWALK=y
CONFIG_STACKDEPOT=y
CONFIG_SBITMAP=y
CONFIG_STRING_SELFTEST=m
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
# CONFIG_DEBUG_INFO_DWARF4 is not set
# CONFIG_GDB_SCRIPTS is not set
CONFIG_ENABLE_MUST_CHECK=y
CONFIG_FRAME_WARN=8192
# CONFIG_STRIP_ASM_SYMS is not set
# CONFIG_READABLE_ASM is not set
CONFIG_HEADERS_INSTALL=y
CONFIG_DEBUG_SECTION_MISMATCH=y
CONFIG_SECTION_MISMATCH_WARN_ONLY=y
CONFIG_FRAME_POINTER=y
# CONFIG_STACK_VALIDATION is not set
CONFIG_DEBUG_FORCE_WEAK_PER_CPU=y
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
CONFIG_DEBUG_MISC=y

#
# Memory Debugging
#
CONFIG_PAGE_EXTENSION=y
# CONFIG_DEBUG_PAGEALLOC is not set
# CONFIG_PAGE_OWNER is not set
CONFIG_PAGE_POISONING=y
CONFIG_PAGE_POISONING_NO_SANITY=y
CONFIG_PAGE_POISONING_ZERO=y
# CONFIG_DEBUG_PAGE_REF is not set
CONFIG_DEBUG_RODATA_TEST=y
CONFIG_ARCH_HAS_DEBUG_WX=y
CONFIG_DEBUG_WX=y
CONFIG_GENERIC_PTDUMP=y
CONFIG_PTDUMP_CORE=y
# CONFIG_PTDUMP_DEBUGFS is not set
CONFIG_DEBUG_OBJECTS=y
# CONFIG_DEBUG_OBJECTS_SELFTEST is not set
CONFIG_DEBUG_OBJECTS_FREE=y
CONFIG_DEBUG_OBJECTS_TIMERS=y
# CONFIG_DEBUG_OBJECTS_WORK is not set
CONFIG_DEBUG_OBJECTS_RCU_HEAD=y
CONFIG_DEBUG_OBJECTS_PERCPU_COUNTER=y
CONFIG_DEBUG_OBJECTS_ENABLE_DEFAULT=1
# CONFIG_DEBUG_SLAB is not set
CONFIG_HAVE_DEBUG_KMEMLEAK=y
# CONFIG_DEBUG_KMEMLEAK is not set
CONFIG_DEBUG_STACK_USAGE=y
# CONFIG_SCHED_STACK_END_CHECK is not set
CONFIG_ARCH_HAS_DEBUG_VM_PGTABLE=y
# CONFIG_DEBUG_VM is not set
CONFIG_DEBUG_VM_PGTABLE=y
CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
# CONFIG_DEBUG_VIRTUAL is not set
CONFIG_DEBUG_MEMORY_INIT=y
CONFIG_DEBUG_PER_CPU_MAPS=y
CONFIG_HAVE_ARCH_KASAN=y
CONFIG_HAVE_ARCH_KASAN_VMALLOC=y
CONFIG_CC_HAS_KASAN_GENERIC=y
CONFIG_CC_HAS_WORKING_NOSANITIZE_ADDRESS=y
CONFIG_KASAN=y
CONFIG_KASAN_GENERIC=y
# CONFIG_KASAN_OUTLINE is not set
CONFIG_KASAN_INLINE=y
CONFIG_KASAN_STACK=1
CONFIG_KASAN_VMALLOC=y
# CONFIG_TEST_KASAN is not set
# end of Memory Debugging

# CONFIG_DEBUG_SHIRQ is not set

#
# Debug Oops, Lockups and Hangs
#
# CONFIG_PANIC_ON_OOPS is not set
CONFIG_PANIC_ON_OOPS_VALUE=0
CONFIG_PANIC_TIMEOUT=0
CONFIG_LOCKUP_DETECTOR=y
CONFIG_SOFTLOCKUP_DETECTOR=y
CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC=y
CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC_VALUE=1
CONFIG_HARDLOCKUP_CHECK_TIMESTAMP=y
# CONFIG_HARDLOCKUP_DETECTOR is not set
# CONFIG_DETECT_HUNG_TASK is not set
# CONFIG_WQ_WATCHDOG is not set
CONFIG_TEST_LOCKUP=m
# end of Debug Oops, Lockups and Hangs

#
# Scheduler Debugging
#
CONFIG_SCHED_DEBUG=y
# CONFIG_SCHEDSTATS is not set
# end of Scheduler Debugging

# CONFIG_DEBUG_TIMEKEEPING is not set

#
# Lock Debugging (spinlocks, mutexes, etc...)
#
CONFIG_LOCK_DEBUGGING_SUPPORT=y
# CONFIG_PROVE_LOCKING is not set
# CONFIG_LOCK_STAT is not set
CONFIG_DEBUG_RT_MUTEXES=y
CONFIG_DEBUG_SPINLOCK=y
CONFIG_DEBUG_MUTEXES=y
# CONFIG_DEBUG_WW_MUTEX_SLOWPATH is not set
# CONFIG_DEBUG_RWSEMS is not set
# CONFIG_DEBUG_LOCK_ALLOC is not set
CONFIG_DEBUG_ATOMIC_SLEEP=y
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
CONFIG_LOCK_TORTURE_TEST=m
CONFIG_WW_MUTEX_SELFTEST=y
# end of Lock Debugging (spinlocks, mutexes, etc...)

CONFIG_TRACE_IRQFLAGS=y
CONFIG_TRACE_IRQFLAGS_NMI=y
CONFIG_STACKTRACE=y
# CONFIG_WARN_ALL_UNSEEDED_RANDOM is not set
# CONFIG_DEBUG_KOBJECT is not set
# CONFIG_DEBUG_KOBJECT_RELEASE is not set

#
# Debug kernel data structures
#
CONFIG_DEBUG_LIST=y
# CONFIG_DEBUG_PLIST is not set
# CONFIG_DEBUG_SG is not set
CONFIG_DEBUG_NOTIFIERS=y
CONFIG_BUG_ON_DATA_CORRUPTION=y
# end of Debug kernel data structures

# CONFIG_DEBUG_CREDENTIALS is not set

#
# RCU Debugging
#
CONFIG_TORTURE_TEST=m
# CONFIG_RCU_PERF_TEST is not set
CONFIG_RCU_TORTURE_TEST=m
# CONFIG_RCU_REF_SCALE_TEST is not set
CONFIG_RCU_CPU_STALL_TIMEOUT=21
CONFIG_RCU_TRACE=y
# CONFIG_RCU_EQS_DEBUG is not set
# end of RCU Debugging

CONFIG_DEBUG_WQ_FORCE_RR_CPU=y
# CONFIG_DEBUG_BLOCK_EXT_DEVT is not set
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
# CONFIG_BOOTTIME_TRACING is not set
CONFIG_FUNCTION_TRACER=y
# CONFIG_FUNCTION_GRAPH_TRACER is not set
# CONFIG_DYNAMIC_FTRACE is not set
# CONFIG_FUNCTION_PROFILER is not set
# CONFIG_STACK_TRACER is not set
CONFIG_IRQSOFF_TRACER=y
# CONFIG_SCHED_TRACER is not set
# CONFIG_HWLAT_TRACER is not set
# CONFIG_MMIOTRACE is not set
# CONFIG_FTRACE_SYSCALLS is not set
CONFIG_TRACER_SNAPSHOT=y
CONFIG_TRACER_SNAPSHOT_PER_CPU_SWAP=y
CONFIG_TRACE_BRANCH_PROFILING=y
# CONFIG_BRANCH_PROFILE_NONE is not set
CONFIG_PROFILE_ANNOTATED_BRANCHES=y
# CONFIG_PROFILE_ALL_BRANCHES is not set
CONFIG_TRACING_BRANCHES=y
CONFIG_BRANCH_TRACER=y
CONFIG_BLK_DEV_IO_TRACE=y
# CONFIG_UPROBE_EVENTS is not set
CONFIG_DYNAMIC_EVENTS=y
CONFIG_SYNTH_EVENTS=y
# CONFIG_HIST_TRIGGERS is not set
# CONFIG_TRACE_EVENT_INJECT is not set
# CONFIG_TRACEPOINT_BENCHMARK is not set
CONFIG_RING_BUFFER_BENCHMARK=m
CONFIG_TRACE_EVAL_MAP_FILE=y
# CONFIG_FTRACE_STARTUP_TEST is not set
# CONFIG_RING_BUFFER_STARTUP_TEST is not set
CONFIG_PREEMPTIRQ_DELAY_TEST=m
# CONFIG_SYNTH_EVENT_GEN_TEST is not set
# CONFIG_PROVIDE_OHCI1394_DMA_INIT is not set
# CONFIG_SAMPLES is not set
CONFIG_HAVE_ARCH_KCSAN=y
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
CONFIG_DEBUG_TLBFLUSH=y
CONFIG_HAVE_MMIOTRACE_SUPPORT=y
# CONFIG_X86_DECODER_SELFTEST is not set
# CONFIG_IO_DELAY_0X80 is not set
# CONFIG_IO_DELAY_0XED is not set
# CONFIG_IO_DELAY_UDELAY is not set
CONFIG_IO_DELAY_NONE=y
CONFIG_DEBUG_BOOT_PARAMS=y
# CONFIG_CPA_DEBUG is not set
# CONFIG_DEBUG_ENTRY is not set
# CONFIG_DEBUG_NMI_SELFTEST is not set
CONFIG_X86_DEBUG_FPU=y
# CONFIG_PUNIT_ATOM_DEBUG is not set
# CONFIG_UNWINDER_ORC is not set
CONFIG_UNWINDER_FRAME_POINTER=y
# end of x86 Debugging

#
# Kernel Testing and Coverage
#
CONFIG_KUNIT=y
# CONFIG_KUNIT_DEBUGFS is not set
CONFIG_KUNIT_TEST=m
# CONFIG_KUNIT_EXAMPLE_TEST is not set
# CONFIG_KUNIT_ALL_TESTS is not set
CONFIG_NOTIFIER_ERROR_INJECTION=y
CONFIG_PM_NOTIFIER_ERROR_INJECT=y
CONFIG_OF_RECONFIG_NOTIFIER_ERROR_INJECT=y
CONFIG_NETDEV_NOTIFIER_ERROR_INJECT=y
# CONFIG_FAULT_INJECTION is not set
CONFIG_CC_HAS_SANCOV_TRACE_PC=y
# CONFIG_RUNTIME_TESTING_MENU is not set
# CONFIG_MEMTEST is not set
# end of Kernel Testing and Coverage
# end of Kernel hacking

--SLDf9lqlvOQaIe6s--
