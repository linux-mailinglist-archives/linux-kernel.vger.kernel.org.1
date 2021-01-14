Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82AE72F5B53
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 08:32:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727235AbhANHao (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 02:30:44 -0500
Received: from mga03.intel.com ([134.134.136.65]:63310 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726127AbhANHam (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 02:30:42 -0500
IronPort-SDR: rm2qGK1at8RRJACbbSkmPKRNfDVxkX1Ks7mXZgL2IMwbRhY7AGDAPLfUCULWNBp6H9LjSQ6Yj7
 KiI1NNvaxOvw==
X-IronPort-AV: E=McAfee;i="6000,8403,9863"; a="178412761"
X-IronPort-AV: E=Sophos;i="5.79,346,1602572400"; 
   d="xz'?scan'208";a="178412761"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2021 23:29:52 -0800
IronPort-SDR: GRq5es3xV/ZwckPYOu+GvNSGZCSki+O2K3XVf7u1VBxtGLDEoT4Z+kUWUnHYpMDtLRqUPi/hFO
 SsOgJI/Ke4GQ==
X-IronPort-AV: E=Sophos;i="5.79,346,1602572400"; 
   d="xz'?scan'208";a="353803090"
Received: from xsang-optiplex-9020.sh.intel.com (HELO xsang-OptiPlex-9020) ([10.239.159.140])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2021 23:29:49 -0800
Date:   Thu, 14 Jan 2021 15:45:11 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com
Subject: [workqueue]  d5bff968ea:
 WARNING:at_kernel/workqueue.c:#process_one_work
Message-ID: <20210114074511.GA25699@xsang-OptiPlex-9020>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="pWyiEgJYm5f9v55/"
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pWyiEgJYm5f9v55/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


Greeting,

FYI, we noticed the following commit (built with gcc-9):

commit: d5bff968ea9cc005e632d9369c26cbd8148c93d5 ("workqueue: break affinity initiatively")
https://git.kernel.org/cgit/linux/kernel/git/paulmck/linux-rcu.git dev.2021.01.11b


in testcase: rcutorture
version: 
with following parameters:

	runtime: 300s
	test: cpuhotplug
	torture_type: srcud

test-description: rcutorture is rcutorture kernel module load/unload test.
test-url: https://www.kernel.org/doc/Documentation/RCU/torture.txt


on test machine: qemu-system-i386 -enable-kvm -cpu SandyBridge -smp 2 -m 8G

caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):


+--------------------------------------------------+------------+------------+
|                                                  | 6211b34f6e | d5bff968ea |
+--------------------------------------------------+------------+------------+
| boot_successes                                   | 4          | 0          |
| boot_failures                                    | 0          | 12         |
| WARNING:at_kernel/workqueue.c:#process_one_work  | 0          | 12         |
| EIP:process_one_work                             | 0          | 12         |
| WARNING:at_kernel/kthread.c:#kthread_set_per_cpu | 0          | 4          |
| EIP:kthread_set_per_cpu                          | 0          | 4          |
+--------------------------------------------------+------------+------------+


If you fix the issue, kindly add following tag
Reported-by: kernel test robot <oliver.sang@intel.com>


[   73.794288] WARNING: CPU: 0 PID: 22 at kernel/workqueue.c:2192 process_one_work (kbuild/src/consumer/kernel/workqueue.c:2192) 
[   73.795012] Modules linked in: rcutorture torture mousedev evbug input_leds led_class psmouse pcspkr tiny_power_button button
[   73.795949] CPU: 0 PID: 22 Comm: kworker/1:0 Not tainted 5.11.0-rc3-gd5bff968ea9c #2
[   73.796592] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
[   73.797280] Workqueue:  0x0 (rcu_gp)
[   73.797592] EIP: process_one_work (kbuild/src/consumer/kernel/workqueue.c:2192) 
[ 73.797980] Code: 37 64 a1 58 54 4c 43 39 45 24 74 2c 31 c9 ba 01 00 00 00 c7 04 24 01 00 00 00 b8 08 1d f5 42 e8 94 85 13 00 ff 05 b8 30 04 43 <0f> 0b ba 01 00 00 00 eb 22 8d 74 26 00 90 c7 04 24 01 00 00 00 31
All code
========
   0:	37                   	(bad)  
   1:	64 a1 58 54 4c 43 39 	movabs %fs:0x74244539434c5458,%eax
   8:	45 24 74 
   b:	2c 31                	sub    $0x31,%al
   d:	c9                   	leaveq 
   e:	ba 01 00 00 00       	mov    $0x1,%edx
  13:	c7 04 24 01 00 00 00 	movl   $0x1,(%rsp)
  1a:	b8 08 1d f5 42       	mov    $0x42f51d08,%eax
  1f:	e8 94 85 13 00       	callq  0x1385b8
  24:	ff 05 b8 30 04 43    	incl   0x430430b8(%rip)        # 0x430430e2
  2a:*	0f 0b                	ud2    		<-- trapping instruction
  2c:	ba 01 00 00 00       	mov    $0x1,%edx
  31:	eb 22                	jmp    0x55
  33:	8d 74 26 00          	lea    0x0(%rsi,%riz,1),%esi
  37:	90                   	nop
  38:	c7 04 24 01 00 00 00 	movl   $0x1,(%rsp)
  3f:	31                   	.byte 0x31

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2    
   2:	ba 01 00 00 00       	mov    $0x1,%edx
   7:	eb 22                	jmp    0x2b
   9:	8d 74 26 00          	lea    0x0(%rsi,%riz,1),%esi
   d:	90                   	nop
   e:	c7 04 24 01 00 00 00 	movl   $0x1,(%rsp)
  15:	31                   	.byte 0x31
[   73.799597] EAX: 42f51d08 EBX: 00000000 ECX: 00000000 EDX: 00000001
[   73.800143] ESI: 43c04720 EDI: df4140f4 EBP: de7f23c0 ESP: 43d7bf08
[   73.800688] DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068 EFLAGS: 00010002
[   73.801260] CR0: 80050033 CR2: 00aabcbc CR3: 7f9dc000 CR4: 000406d0
[   73.801784] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
[   73.802305] DR6: fffe0ff0 DR7: 00000400
[   73.802651] Call Trace:
[   73.802871] ? process_one_work (kbuild/src/consumer/kernel/workqueue.c:615 kbuild/src/consumer/kernel/workqueue.c:643 kbuild/src/consumer/kernel/workqueue.c:2248) 
[   73.803232] ? worker_thread (kbuild/src/consumer/include/linux/list.h:282 (discriminator 1) kbuild/src/consumer/kernel/workqueue.c:2424 (discriminator 1)) 
[   73.803567] ? kthread (kbuild/src/consumer/kernel/kthread.c:292 (discriminator 1)) 
[   73.803859] ? create_worker (kbuild/src/consumer/kernel/workqueue.c:2366) 
[   73.804192] ? kzalloc (kbuild/src/consumer/kernel/resource.c:166) 
[   73.804554] ? ret_from_fork (kbuild/src/consumer/arch/x86/entry/entry_32.S:856) 
[   73.804875] ---[ end trace 122a61cfdd814ce9 ]---
[   73.805580] kvm-guest: stealtime: cpu 1, msr 9e7e6ec0
[   73.883292] smpboot: CPU 1 is now offline
[   73.951310] x86: Booting SMP configuration:
[   73.951830] smpboot: Booting Node 0 Processor 1 APIC 0x1
[   73.952546] kvm-clock: cpu 1, msr 34f6021, secondary cpu clock
[   73.952580] masked ExtINT on CPU#1
[   73.989426] kvm-guest: stealtime: cpu 1, msr 9e7e6ec0
[   74.164842] smpboot: CPU 1 is now offline
[   74.231330] x86: Booting SMP configuration:
[   74.231866] smpboot: Booting Node 0 Processor 1 APIC 0x1
[   74.232581] kvm-clock: cpu 1, msr 34f6021, secondary cpu clock
[   74.232617] masked ExtINT on CPU#1
[   74.262076] kvm-guest: stealtime: cpu 1, msr 9e7e6ec0
[   74.433467] smpboot: CPU 1 is now offline
[   74.591312] x86: Booting SMP configuration:
[   74.591816] smpboot: Booting Node 0 Processor 1 APIC 0x1
[   74.592510] kvm-clock: cpu 1, msr 34f6021, secondary cpu clock
[   74.592546] masked ExtINT on CPU#1
[   74.641675] kvm-guest: stealtime: cpu 1, msr 9e7e6ec0
[   74.803293] smpboot: CPU 1 is now offline
[   74.841947] x86: Booting SMP configuration:
[   74.842481] smpboot: Booting Node 0 Processor 1 APIC 0x1
[   74.843206] kvm-clock: cpu 1, msr 34f6021, secondary cpu clock
[   74.843243] masked ExtINT on CPU#1
[   74.891673] kvm-guest: stealtime: cpu 1, msr 9e7e6ec0
[   74.973277] smpboot: CPU 1 is now offline
[   75.121309] x86: Booting SMP configuration:
[   75.121836] smpboot: Booting Node 0 Processor 1 APIC 0x1
[   75.122539] kvm-clock: cpu 1, msr 34f6021, secondary cpu clock
[   75.122573] masked ExtINT on CPU#1
[   75.171673] kvm-guest: stealtime: cpu 1, msr 9e7e6ec0
[   75.303292] smpboot: CPU 1 is now offline
[   75.341537] x86: Booting SMP configuration:
[   75.342087] smpboot: Booting Node 0 Processor 1 APIC 0x1
[   75.342822] kvm-clock: cpu 1, msr 34f6021, secondary cpu clock
[   75.342859] masked ExtINT on CPU#1
[   75.401637] kvm-guest: stealtime: cpu 1, msr 9e7e6ec0
[   75.523225] smpboot: CPU 1 is now offline
[   75.631293] x86: Booting SMP configuration:
[   75.631790] smpboot: Booting Node 0 Processor 1 APIC 0x1
[   75.632512] kvm-clock: cpu 1, msr 34f6021, secondary cpu clock
[   75.632544] masked ExtINT on CPU#1
[   75.681631] kvm-guest: stealtime: cpu 1, msr 9e7e6ec0
[   75.813300] smpboot: CPU 1 is now offline
[   75.861498] x86: Booting SMP configuration:
[   75.862040] smpboot: Booting Node 0 Processor 1 APIC 0x1
[   75.862763] kvm-clock: cpu 1, msr 34f6021, secondary cpu clock
[   75.862797] masked ExtINT on CPU#1
[   75.911656] kvm-guest: stealtime: cpu 1, msr 9e7e6ec0
[   76.043254] smpboot: CPU 1 is now offline
[   76.091495] x86: Booting SMP configuration:
[   76.092038] smpboot: Booting Node 0 Processor 1 APIC 0x1
[   76.092726] kvm-clock: cpu 1, msr 34f6021, secondary cpu clock
[   76.092758] masked ExtINT on CPU#1
[   76.141672] kvm-guest: stealtime: cpu 1, msr 9e7e6ec0
[   76.273386] smpboot: CPU 1 is now offline
[   76.321583] x86: Booting SMP configuration:
[   76.322137] smpboot: Booting Node 0 Processor 1 APIC 0x1
[   76.323186] kvm-clock: cpu 1, msr 34f6021, secondary cpu clock
[   76.323221] masked ExtINT on CPU#1
[   76.361613] kvm-guest: stealtime: cpu 1, msr 9e7e6ec0
[   76.453350] smpboot: CPU 1 is now offline
[   76.681296] x86: Booting SMP configuration:
[   76.681792] smpboot: Booting Node 0 Processor 1 APIC 0x1
[   76.682448] kvm-clock: cpu 1, msr 34f6021, secondary cpu clock
[   76.682479] masked ExtINT on CPU#1
[   76.731666] kvm-guest: stealtime: cpu 1, msr 9e7e6ec0
[   76.883233] smpboot: CPU 1 is now offline
[   77.191301] x86: Booting SMP configuration:
[   77.191829] smpboot: Booting Node 0 Processor 1 APIC 0x1
[   77.192554] kvm-clock: cpu 1, msr 34f6021, secondary cpu clock
[   77.192589] masked ExtINT on CPU#1
[   77.241673] kvm-guest: stealtime: cpu 1, msr 9e7e6ec0
[   77.323278] smpboot: CPU 1 is now offline
[   77.361452] x86: Booting SMP configuration:
[   77.361957] smpboot: Booting Node 0 Processor 1 APIC 0x1
[   77.362632] kvm-clock: cpu 1, msr 34f6021, secondary cpu clock
[   77.362668] masked ExtINT on CPU#1
[   77.411641] kvm-guest: stealtime: cpu 1, msr 9e7e6ec0
[   77.583568] smpboot: CPU 1 is now offline
[   77.691303] x86: Booting SMP configuration:
[   77.691851] smpboot: Booting Node 0 Processor 1 APIC 0x1
[   77.692549] kvm-clock: cpu 1, msr 34f6021, secondary cpu clock
[   77.692581] masked ExtINT on CPU#1
[   77.751809] kvm-guest: stealtime: cpu 1, msr 9e7e6ec0
[   78.032676] srcud-torture: rtc: (ptrval) ver: 922 tfle: 0 rta: 922 rtaf: 0 rtf: 913 rtmbe: 0 rtmbkf: 0/0 rtbe: 0 rtbke: 0 rtbre: 0 rtbf: 0 rtb: 0 nt: 552 onoff: 93/93:93/94 2,21:0,21 667:787 (HZ=100) barrier: 0/0:0 read-exits: 67 nocb-toggles: 0:0
[   78.035048] srcud-torture: Reader Pipe:  12631032 44 0 0 0 0 0 0 0 0 0
[   78.035759] srcud-torture: Reader Batch:  12630957 119 0 0 0 0 0 0 0 0 0
[   78.036507] srcud-torture: Free-Block Circulation:  921 921 920 919 918 917 916 915 914 913 0
[   78.037407] rcu: srcud-torture: Tree SRCU g6668 per-CPU(idx=1): 0(17,12 .) 1(-17,-12 .) T(0,0)
[   78.055649] smpboot: CPU 1 is now offline
[   78.121332] x86: Booting SMP configuration:
[   78.121837] smpboot: Booting Node 0 Processor 1 APIC 0x1
[   78.150644] kvm-clock: cpu 1, msr 34f6021, secondary cpu clock
[   78.150702] masked ExtINT on CPU#1
[   78.172354] kvm-guest: stealtime: cpu 1, msr 9e7e6ec0
[   78.343316] smpboot: CPU 1 is now offline
[   78.411398] x86: Booting SMP configuration:
[   78.411921] smpboot: Booting Node 0 Processor 1 APIC 0x1
[   78.412640] kvm-clock: cpu 1, msr 34f6021, secondary cpu clock
[   78.412675] masked ExtINT on CPU#1
[   78.437957] kvm-guest: stealtime: cpu 1, msr 9e7e6ec0


To reproduce:

        # build kernel
	cd linux
	cp config-5.11.0-rc3-gd5bff968ea9c .config
	make HOSTCC=gcc-9 CC=gcc-9 ARCH=i386 olddefconfig prepare modules_prepare bzImage

        git clone https://github.com/intel/lkp-tests.git
        cd lkp-tests
        bin/lkp qemu -k <bzImage> job-script # job-script is attached in this email



Thanks,
Oliver Sang


--pWyiEgJYm5f9v55/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="config-5.11.0-rc3-gd5bff968ea9c"

#
# Automatically generated file; DO NOT EDIT.
# Linux/i386 5.11.0-rc3 Kernel Configuration
#
CONFIG_CC_VERSION_TEXT="gcc-9 (Debian 9.3.0-15) 9.3.0"
CONFIG_CC_IS_GCC=y
CONFIG_GCC_VERSION=90300
CONFIG_LD_VERSION=235000000
CONFIG_CLANG_VERSION=0
CONFIG_LLD_VERSION=0
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
# CONFIG_KERNEL_BZIP2 is not set
# CONFIG_KERNEL_LZMA is not set
# CONFIG_KERNEL_XZ is not set
# CONFIG_KERNEL_LZO is not set
# CONFIG_KERNEL_LZ4 is not set
CONFIG_KERNEL_ZSTD=y
CONFIG_DEFAULT_INIT=""
CONFIG_DEFAULT_HOSTNAME="(none)"
# CONFIG_SWAP is not set
CONFIG_SYSVIPC=y
CONFIG_SYSVIPC_SYSCTL=y
# CONFIG_POSIX_MQUEUE is not set
# CONFIG_WATCH_QUEUE is not set
CONFIG_CROSS_MEMORY_ATTACH=y
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

#
# Timers subsystem
#
CONFIG_TICK_ONESHOT=y
CONFIG_HZ_PERIODIC=y
# CONFIG_NO_HZ_IDLE is not set
CONFIG_NO_HZ=y
CONFIG_HIGH_RES_TIMERS=y
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
CONFIG_RCU_NOCB_CPU=y
CONFIG_TASKS_TRACE_RCU_READ_MB=y
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
# CONFIG_UCLAMP_TASK is not set
# end of Scheduler features

CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=y
CONFIG_CGROUPS=y
# CONFIG_MEMCG is not set
CONFIG_BLK_CGROUP=y
CONFIG_CGROUP_SCHED=y
CONFIG_FAIR_GROUP_SCHED=y
CONFIG_CFS_BANDWIDTH=y
CONFIG_RT_GROUP_SCHED=y
CONFIG_CGROUP_PIDS=y
# CONFIG_CGROUP_RDMA is not set
CONFIG_CGROUP_FREEZER=y
CONFIG_CPUSETS=y
# CONFIG_PROC_PID_CPUSET is not set
# CONFIG_CGROUP_DEVICE is not set
CONFIG_CGROUP_CPUACCT=y
# CONFIG_CGROUP_PERF is not set
CONFIG_CGROUP_BPF=y
# CONFIG_CGROUP_DEBUG is not set
CONFIG_SOCK_CGROUP_DATA=y
# CONFIG_NAMESPACES is not set
CONFIG_CHECKPOINT_RESTORE=y
# CONFIG_SCHED_AUTOGROUP is not set
# CONFIG_SYSFS_DEPRECATED is not set
CONFIG_RELAY=y
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_RD_GZIP=y
CONFIG_RD_BZIP2=y
# CONFIG_RD_LZMA is not set
CONFIG_RD_XZ=y
CONFIG_RD_LZO=y
CONFIG_RD_LZ4=y
CONFIG_RD_ZSTD=y
CONFIG_BOOT_CONFIG=y
CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE=y
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
CONFIG_LD_ORPHAN_WARN=y
CONFIG_SYSCTL=y
CONFIG_HAVE_UID16=y
CONFIG_SYSCTL_EXCEPTION_TRACE=y
CONFIG_HAVE_PCSPKR_PLATFORM=y
CONFIG_BPF=y
CONFIG_EXPERT=y
CONFIG_UID16=y
CONFIG_MULTIUSER=y
# CONFIG_SGETMASK_SYSCALL is not set
CONFIG_SYSFS_SYSCALL=y
CONFIG_FHANDLE=y
# CONFIG_POSIX_TIMERS is not set
CONFIG_PRINTK=y
CONFIG_PRINTK_NMI=y
CONFIG_BUG=y
# CONFIG_ELF_CORE is not set
CONFIG_PCSPKR_PLATFORM=y
# CONFIG_BASE_FULL is not set
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
CONFIG_KALLSYMS_BASE_RELATIVE=y
CONFIG_BPF_SYSCALL=y
# CONFIG_BPF_PRELOAD is not set
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
CONFIG_SLUB_DEBUG=y
# CONFIG_COMPAT_BRK is not set
# CONFIG_SLAB is not set
CONFIG_SLUB=y
# CONFIG_SLOB is not set
CONFIG_SLAB_MERGE_DEFAULT=y
CONFIG_SLAB_FREELIST_RANDOM=y
# CONFIG_SLAB_FREELIST_HARDENED is not set
CONFIG_SHUFFLE_PAGE_ALLOCATOR=y
CONFIG_SLUB_CPU_PARTIAL=y
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
CONFIG_X86_32_SMP=y
CONFIG_X86_32_LAZY_GS=y
CONFIG_ARCH_SUPPORTS_UPROBES=y
CONFIG_FIX_EARLYCON_MEM=y
CONFIG_PGTABLE_LEVELS=2
CONFIG_CC_HAS_SANE_STACKPROTECTOR=y

#
# Processor type and features
#
CONFIG_ZONE_DMA=y
CONFIG_SMP=y
CONFIG_X86_FEATURE_NAMES=y
CONFIG_X86_MPPARSE=y
CONFIG_GOLDFISH=y
CONFIG_RETPOLINE=y
CONFIG_X86_CPU_RESCTRL=y
# CONFIG_X86_BIGSMP is not set
CONFIG_X86_EXTENDED_PLATFORM=y
# CONFIG_X86_GOLDFISH is not set
# CONFIG_X86_INTEL_MID is not set
# CONFIG_X86_INTEL_QUARK is not set
# CONFIG_X86_INTEL_LPSS is not set
CONFIG_X86_AMD_PLATFORM_DEVICE=y
# CONFIG_IOSF_MBI is not set
CONFIG_X86_RDC321X=y
# CONFIG_X86_32_NON_STANDARD is not set
CONFIG_X86_32_IRIS=y
# CONFIG_SCHED_OMIT_FRAME_POINTER is not set
CONFIG_HYPERVISOR_GUEST=y
CONFIG_PARAVIRT=y
# CONFIG_PARAVIRT_DEBUG is not set
# CONFIG_PARAVIRT_SPINLOCKS is not set
CONFIG_X86_HV_CALLBACK_VECTOR=y
CONFIG_KVM_GUEST=y
CONFIG_ARCH_CPUIDLE_HALTPOLL=y
# CONFIG_PVH is not set
# CONFIG_PARAVIRT_TIME_ACCOUNTING is not set
CONFIG_PARAVIRT_CLOCK=y
# CONFIG_M486SX is not set
# CONFIG_M486 is not set
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
CONFIG_M686=y
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
# CONFIG_MELAN is not set
# CONFIG_MGEODEGX1 is not set
# CONFIG_MGEODE_LX is not set
# CONFIG_MCYRIXIII is not set
# CONFIG_MVIAC3_2 is not set
# CONFIG_MVIAC7 is not set
# CONFIG_MCORE2 is not set
# CONFIG_MATOM is not set
# CONFIG_X86_GENERIC is not set
CONFIG_X86_INTERNODE_CACHE_SHIFT=5
CONFIG_X86_L1_CACHE_SHIFT=5
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_TSC=y
CONFIG_X86_CMPXCHG64=y
CONFIG_X86_CMOV=y
CONFIG_X86_MINIMUM_CPU_FAMILY=6
CONFIG_X86_DEBUGCTLMSR=y
CONFIG_IA32_FEAT_CTL=y
CONFIG_X86_VMX_FEATURE_NAMES=y
CONFIG_PROCESSOR_SELECT=y
CONFIG_CPU_SUP_INTEL=y
CONFIG_CPU_SUP_CYRIX_32=y
CONFIG_CPU_SUP_AMD=y
CONFIG_CPU_SUP_HYGON=y
CONFIG_CPU_SUP_CENTAUR=y
# CONFIG_CPU_SUP_TRANSMETA_32 is not set
CONFIG_CPU_SUP_UMC_32=y
# CONFIG_CPU_SUP_ZHAOXIN is not set
CONFIG_HPET_TIMER=y
CONFIG_DMI=y
CONFIG_NR_CPUS_RANGE_BEGIN=2
CONFIG_NR_CPUS_RANGE_END=8
CONFIG_NR_CPUS_DEFAULT=8
CONFIG_NR_CPUS=8
CONFIG_SCHED_SMT=y
# CONFIG_SCHED_MC is not set
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
# CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS is not set
CONFIG_X86_MCE=y
# CONFIG_X86_MCELOG_LEGACY is not set
CONFIG_X86_MCE_INTEL=y
CONFIG_X86_MCE_AMD=y
CONFIG_X86_ANCIENT_MCE=y
CONFIG_X86_MCE_THRESHOLD=y
CONFIG_X86_MCE_INJECT=y
CONFIG_X86_THERMAL_VECTOR=y

#
# Performance monitoring
#
CONFIG_PERF_EVENTS_INTEL_UNCORE=y
CONFIG_PERF_EVENTS_INTEL_RAPL=y
CONFIG_PERF_EVENTS_INTEL_CSTATE=y
# CONFIG_PERF_EVENTS_AMD_POWER is not set
# end of Performance monitoring

# CONFIG_X86_LEGACY_VM86 is not set
# CONFIG_X86_IOPL_IOPERM is not set
# CONFIG_TOSHIBA is not set
CONFIG_I8K=m
CONFIG_X86_REBOOTFIXUPS=y
CONFIG_MICROCODE=y
# CONFIG_MICROCODE_INTEL is not set
# CONFIG_MICROCODE_AMD is not set
# CONFIG_MICROCODE_OLD_INTERFACE is not set
CONFIG_X86_MSR=m
CONFIG_X86_CPUID=m
# CONFIG_NOHIGHMEM is not set
CONFIG_HIGHMEM4G=y
# CONFIG_HIGHMEM64G is not set
# CONFIG_VMSPLIT_3G is not set
# CONFIG_VMSPLIT_3G_OPT is not set
# CONFIG_VMSPLIT_2G is not set
# CONFIG_VMSPLIT_2G_OPT is not set
CONFIG_VMSPLIT_1G=y
CONFIG_PAGE_OFFSET=0x40000000
CONFIG_HIGHMEM=y
CONFIG_X86_CPA_STATISTICS=y
CONFIG_ARCH_FLATMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SELECT_MEMORY_MODEL=y
CONFIG_ILLEGAL_POINTER_VALUE=0
# CONFIG_HIGHPTE is not set
# CONFIG_X86_CHECK_BIOS_CORRUPTION is not set
CONFIG_X86_RESERVE_LOW=64
CONFIG_MTRR=y
CONFIG_MTRR_SANITIZER=y
CONFIG_MTRR_SANITIZER_ENABLE_DEFAULT=0
CONFIG_MTRR_SANITIZER_SPARE_REG_NR_DEFAULT=1
# CONFIG_X86_PAT is not set
CONFIG_ARCH_RANDOM=y
# CONFIG_X86_SMAP is not set
# CONFIG_X86_UMIP is not set
CONFIG_X86_INTEL_TSX_MODE_OFF=y
# CONFIG_X86_INTEL_TSX_MODE_ON is not set
# CONFIG_X86_INTEL_TSX_MODE_AUTO is not set
# CONFIG_EFI is not set
CONFIG_HZ_100=y
# CONFIG_HZ_250 is not set
# CONFIG_HZ_300 is not set
# CONFIG_HZ_1000 is not set
CONFIG_HZ=100
CONFIG_SCHED_HRTICK=y
CONFIG_KEXEC=y
CONFIG_CRASH_DUMP=y
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

CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y

#
# Power management and ACPI options
#
# CONFIG_SUSPEND is not set
CONFIG_PM=y
CONFIG_PM_DEBUG=y
CONFIG_PM_ADVANCED_DEBUG=y
CONFIG_DPM_WATCHDOG=y
CONFIG_DPM_WATCHDOG_TIMEOUT=120
CONFIG_PM_CLK=y
# CONFIG_WQ_POWER_EFFICIENT_DEFAULT is not set
CONFIG_ENERGY_MODEL=y
CONFIG_ARCH_SUPPORTS_ACPI=y
CONFIG_ACPI=y
CONFIG_ACPI_LEGACY_TABLES_LOOKUP=y
CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC=y
CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT=y
# CONFIG_ACPI_DEBUGGER is not set
# CONFIG_ACPI_SPCR_TABLE is not set
# CONFIG_ACPI_REV_OVERRIDE_POSSIBLE is not set
CONFIG_ACPI_EC_DEBUGFS=y
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=m
CONFIG_ACPI_TINY_POWER_BUTTON=m
CONFIG_ACPI_TINY_POWER_BUTTON_SIGNAL=38
# CONFIG_ACPI_VIDEO is not set
CONFIG_ACPI_FAN=m
CONFIG_ACPI_DOCK=y
# CONFIG_ACPI_PROCESSOR is not set
CONFIG_ACPI_IPMI=m
CONFIG_ACPI_CUSTOM_DSDT_FILE=""
CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
# CONFIG_ACPI_TABLE_UPGRADE is not set
# CONFIG_ACPI_DEBUG is not set
# CONFIG_ACPI_PCI_SLOT is not set
CONFIG_ACPI_CONTAINER=y
CONFIG_ACPI_HOTPLUG_IOAPIC=y
CONFIG_ACPI_SBS=m
CONFIG_ACPI_HED=y
CONFIG_ACPI_CUSTOM_METHOD=m
# CONFIG_ACPI_REDUCED_HARDWARE_ONLY is not set
CONFIG_HAVE_ACPI_APEI=y
CONFIG_HAVE_ACPI_APEI_NMI=y
# CONFIG_ACPI_APEI is not set
CONFIG_ACPI_DPTF=y
# CONFIG_DPTF_POWER is not set
CONFIG_DPTF_PCH_FIVR=y
CONFIG_ACPI_CONFIGFS=m
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
# CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_CONSERVATIVE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_SCHEDUTIL is not set
CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
CONFIG_CPU_FREQ_GOV_POWERSAVE=m
CONFIG_CPU_FREQ_GOV_USERSPACE=y
CONFIG_CPU_FREQ_GOV_ONDEMAND=y
CONFIG_CPU_FREQ_GOV_CONSERVATIVE=m
CONFIG_CPU_FREQ_GOV_SCHEDUTIL=y

#
# CPU frequency scaling drivers
#
# CONFIG_CPUFREQ_DT is not set
# CONFIG_X86_INTEL_PSTATE is not set
# CONFIG_X86_POWERNOW_K6 is not set
CONFIG_X86_POWERNOW_K7=m
# CONFIG_X86_GX_SUSPMOD is not set
CONFIG_X86_SPEEDSTEP_CENTRINO=m
CONFIG_X86_SPEEDSTEP_CENTRINO_TABLE=y
# CONFIG_X86_SPEEDSTEP_ICH is not set
# CONFIG_X86_SPEEDSTEP_SMI is not set
CONFIG_X86_P4_CLOCKMOD=m
CONFIG_X86_CPUFREQ_NFORCE2=y
# CONFIG_X86_LONGRUN is not set

#
# shared options
#
CONFIG_X86_SPEEDSTEP_LIB=m
# end of CPU Frequency scaling

#
# CPU Idle
#
# CONFIG_CPU_IDLE is not set
# end of CPU Idle
# end of Power management and ACPI options

#
# Bus options (PCI etc.)
#
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GOMMCONFIG is not set
# CONFIG_PCI_GODIRECT is not set
# CONFIG_PCI_GOOLPC is not set
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
CONFIG_PCI_OLPC=y
# CONFIG_PCI_CNB20LE_QUIRK is not set
CONFIG_ISA_BUS=y
CONFIG_ISA_DMA_API=y
CONFIG_ISA=y
CONFIG_SCx200=y
# CONFIG_SCx200HR_TIMER is not set
CONFIG_OLPC=y
# CONFIG_OLPC_XO15_SCI is not set
# CONFIG_ALIX is not set
CONFIG_NET5501=y
CONFIG_GEOS=y
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
CONFIG_EDD_OFF=y
# CONFIG_FIRMWARE_MEMMAP is not set
# CONFIG_DMIID is not set
CONFIG_DMI_SYSFS=y
CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK=y
CONFIG_FW_CFG_SYSFS=y
# CONFIG_FW_CFG_SYSFS_CMDLINE is not set
# CONFIG_GOOGLE_FIRMWARE is not set

#
# Tegra firmware driver
#
# end of Tegra firmware driver
# end of Firmware Drivers

CONFIG_HAVE_KVM=y
CONFIG_VIRTUALIZATION=y
# CONFIG_KVM is not set
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
CONFIG_JUMP_LABEL=y
CONFIG_STATIC_KEYS_SELFTEST=y
# CONFIG_STATIC_CALL_SELFTEST is not set
CONFIG_UPROBES=y
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
CONFIG_HAVE_ARCH_SECCOMP=y
CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
# CONFIG_SECCOMP is not set
CONFIG_HAVE_ARCH_STACKLEAK=y
CONFIG_HAVE_STACKPROTECTOR=y
# CONFIG_STACKPROTECTOR is not set
CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES=y
CONFIG_HAVE_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_MOVE_PUD=y
CONFIG_HAVE_MOVE_PMD=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=y
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
# CONFIG_LOCK_EVENT_COUNTS is not set
CONFIG_ARCH_HAS_MEM_ENCRYPT=y
CONFIG_HAVE_STATIC_CALL=y
CONFIG_ARCH_WANT_LD_ORPHAN_WARN=y
CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
CONFIG_ARCH_SPLIT_ARG64=y

#
# GCOV-based kernel profiling
#
CONFIG_GCOV_KERNEL=y
CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
# CONFIG_GCOV_PROFILE_ALL is not set
# end of GCOV-based kernel profiling

CONFIG_HAVE_GCC_PLUGINS=y
# end of General architecture-dependent options

CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=1
CONFIG_MODULES=y
CONFIG_MODULE_FORCE_LOAD=y
# CONFIG_MODULE_UNLOAD is not set
# CONFIG_MODVERSIONS is not set
# CONFIG_MODULE_SRCVERSION_ALL is not set
# CONFIG_MODULE_SIG is not set
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
# CONFIG_BLK_DEV_ZONED is not set
# CONFIG_BLK_DEV_THROTTLING is not set
CONFIG_BLK_CMDLINE_PARSER=y
# CONFIG_BLK_WBT is not set
# CONFIG_BLK_CGROUP_IOLATENCY is not set
# CONFIG_BLK_CGROUP_IOCOST is not set
# CONFIG_BLK_DEBUG_FS is not set
CONFIG_BLK_SED_OPAL=y
CONFIG_BLK_INLINE_ENCRYPTION=y
CONFIG_BLK_INLINE_ENCRYPTION_FALLBACK=y

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_AMIGA_PARTITION=y
CONFIG_MSDOS_PARTITION=y
CONFIG_EFI_PARTITION=y
# end of Partition Types

CONFIG_BLK_MQ_PCI=y
CONFIG_BLK_MQ_VIRTIO=y
CONFIG_BLK_PM=y

#
# IO Schedulers
#
# CONFIG_MQ_IOSCHED_DEADLINE is not set
# CONFIG_MQ_IOSCHED_KYBER is not set
CONFIG_IOSCHED_BFQ=y
# CONFIG_BFQ_GROUP_IOSCHED is not set
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
CONFIG_FREEZER=y

#
# Executable file formats
#
CONFIG_BINFMT_ELF=y
CONFIG_ELFCORE=y
CONFIG_BINFMT_SCRIPT=y
CONFIG_BINFMT_MISC=m
CONFIG_COREDUMP=y
# end of Executable file formats

#
# Memory Management options
#
CONFIG_SELECT_MEMORY_MODEL=y
# CONFIG_FLATMEM_MANUAL is not set
CONFIG_SPARSEMEM_MANUAL=y
CONFIG_SPARSEMEM=y
CONFIG_SPARSEMEM_STATIC=y
CONFIG_HAVE_FAST_GUP=y
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_COMPACTION=y
CONFIG_PAGE_REPORTING=y
CONFIG_MIGRATION=y
CONFIG_BOUNCE=y
CONFIG_VIRT_TO_BUS=y
# CONFIG_KSM is not set
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
# CONFIG_TRANSPARENT_HUGEPAGE is not set
CONFIG_CLEANCACHE=y
# CONFIG_CMA is not set
CONFIG_ZPOOL=y
CONFIG_ZBUD=m
# CONFIG_Z3FOLD is not set
CONFIG_ZSMALLOC=y
# CONFIG_ZSMALLOC_STAT is not set
CONFIG_GENERIC_EARLY_IOREMAP=y
CONFIG_IDLE_PAGE_TRACKING=y
CONFIG_FRAME_VECTOR=y
CONFIG_PERCPU_STATS=y
# CONFIG_GUP_TEST is not set
CONFIG_ARCH_HAS_PTE_SPECIAL=y
CONFIG_KMAP_LOCAL=y
# end of Memory Management options

CONFIG_NET=y

#
# Networking options
#
# CONFIG_PACKET is not set
CONFIG_UNIX=y
CONFIG_UNIX_SCM=y
# CONFIG_UNIX_DIAG is not set
# CONFIG_TLS is not set
# CONFIG_XFRM_USER is not set
# CONFIG_NET_KEY is not set
# CONFIG_XDP_SOCKETS is not set
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
# CONFIG_NETWORK_SECMARK is not set
# CONFIG_NETWORK_PHY_TIMESTAMPING is not set
# CONFIG_NETFILTER is not set
# CONFIG_BPFILTER is not set
# CONFIG_IP_DCCP is not set
# CONFIG_IP_SCTP is not set
# CONFIG_RDS is not set
# CONFIG_TIPC is not set
# CONFIG_ATM is not set
# CONFIG_L2TP is not set
# CONFIG_BRIDGE is not set
CONFIG_HAVE_NET_DSA=y
# CONFIG_NET_DSA is not set
# CONFIG_VLAN_8021Q is not set
# CONFIG_DECNET is not set
# CONFIG_LLC2 is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_PHONET is not set
# CONFIG_6LOWPAN is not set
# CONFIG_IEEE802154 is not set
# CONFIG_NET_SCHED is not set
# CONFIG_DCB is not set
CONFIG_DNS_RESOLVER=m
# CONFIG_BATMAN_ADV is not set
# CONFIG_OPENVSWITCH is not set
# CONFIG_VSOCKETS is not set
# CONFIG_NETLINK_DIAG is not set
# CONFIG_MPLS is not set
# CONFIG_NET_NSH is not set
# CONFIG_HSR is not set
# CONFIG_NET_SWITCHDEV is not set
# CONFIG_NET_L3_MASTER_DEV is not set
# CONFIG_QRTR is not set
# CONFIG_NET_NCSI is not set
CONFIG_RPS=y
CONFIG_RFS_ACCEL=y
CONFIG_XPS=y
# CONFIG_CGROUP_NET_PRIO is not set
# CONFIG_CGROUP_NET_CLASSID is not set
CONFIG_NET_RX_BUSY_POLL=y
CONFIG_BQL=y
# CONFIG_BPF_JIT is not set
# CONFIG_BPF_STREAM_PARSER is not set
CONFIG_NET_FLOW_LIMIT=y

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
# CONFIG_NET_DROP_MONITOR is not set
# end of Network testing
# end of Networking options

# CONFIG_HAMRADIO is not set
# CONFIG_CAN is not set
# CONFIG_BT is not set
# CONFIG_AF_RXRPC is not set
# CONFIG_AF_KCM is not set
CONFIG_WIRELESS=y
# CONFIG_CFG80211 is not set

#
# CFG80211 needs to be enabled for MAC80211
#
CONFIG_MAC80211_STA_HASH_MAX_SIZE=0
# CONFIG_RFKILL is not set
CONFIG_NET_9P=y
CONFIG_NET_9P_VIRTIO=y
# CONFIG_NET_9P_DEBUG is not set
# CONFIG_CAIF is not set
# CONFIG_CEPH_LIB is not set
# CONFIG_NFC is not set
# CONFIG_PSAMPLE is not set
# CONFIG_NET_IFE is not set
# CONFIG_LWTUNNEL is not set
CONFIG_DST_CACHE=y
CONFIG_GRO_CELLS=y
CONFIG_FAILOVER=m
CONFIG_ETHTOOL_NETLINK=y
CONFIG_HAVE_EBPF_JIT=y

#
# Device Drivers
#
CONFIG_HAVE_EISA=y
CONFIG_EISA=y
# CONFIG_EISA_VLB_PRIMING is not set
CONFIG_EISA_PCI_EISA=y
CONFIG_EISA_VIRTUAL_ROOT=y
CONFIG_EISA_NAMES=y
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
# CONFIG_PCIE_BUS_TUNE_OFF is not set
CONFIG_PCIE_BUS_DEFAULT=y
# CONFIG_PCIE_BUS_SAFE is not set
# CONFIG_PCIE_BUS_PERFORMANCE is not set
# CONFIG_PCIE_BUS_PEER2PEER is not set
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
# CONFIG_I82365 is not set
CONFIG_TCIC=y
CONFIG_PCMCIA_PROBE=y
CONFIG_PCCARD_NONSTATIC=y
# CONFIG_RAPIDIO is not set

#
# Generic Driver Options
#
# CONFIG_UEVENT_HELPER is not set
CONFIG_DEVTMPFS=y
CONFIG_DEVTMPFS_MOUNT=y
# CONFIG_STANDALONE is not set
# CONFIG_PREVENT_FIRMWARE_BUILD is not set

#
# Firmware loader
#
CONFIG_FW_LOADER=y
CONFIG_FW_LOADER_PAGED_BUF=y
CONFIG_EXTRA_FIRMWARE=""
CONFIG_FW_LOADER_USER_HELPER=y
CONFIG_FW_LOADER_USER_HELPER_FALLBACK=y
CONFIG_FW_LOADER_COMPRESS=y
# end of Firmware loader

# CONFIG_ALLOW_DEV_COREDUMP is not set
# CONFIG_DEBUG_DRIVER is not set
CONFIG_DEBUG_DEVRES=y
# CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
CONFIG_PM_QOS_KUNIT_TEST=y
# CONFIG_TEST_ASYNC_DRIVER_PROBE is not set
# CONFIG_KUNIT_DRIVER_PE_TEST is not set
CONFIG_GENERIC_CPU_AUTOPROBE=y
CONFIG_GENERIC_CPU_VULNERABILITIES=y
CONFIG_REGMAP=y
CONFIG_REGMAP_I2C=y
CONFIG_REGMAP_MMIO=y
CONFIG_REGMAP_IRQ=y
CONFIG_REGMAP_I3C=m
CONFIG_DMA_SHARED_BUFFER=y
CONFIG_DMA_FENCE_TRACE=y
# end of Generic Driver Options

#
# Bus devices
#
# CONFIG_SIMPLE_PM_BUS is not set
# CONFIG_MHI_BUS is not set
# end of Bus devices

# CONFIG_CONNECTOR is not set
CONFIG_GNSS=y
CONFIG_GNSS_SERIAL=y
CONFIG_GNSS_MTK_SERIAL=y
CONFIG_GNSS_SIRF_SERIAL=y
CONFIG_GNSS_UBX_SERIAL=y
# CONFIG_MTD is not set
CONFIG_DTC=y
CONFIG_OF=y
# CONFIG_OF_UNITTEST is not set
CONFIG_OF_FLATTREE=y
CONFIG_OF_PROMTREE=y
CONFIG_OF_KOBJ=y
CONFIG_OF_DYNAMIC=y
CONFIG_OF_ADDRESS=y
CONFIG_OF_IRQ=y
CONFIG_OF_NET=y
CONFIG_OF_RESOLVE=y
CONFIG_OF_OVERLAY=y
CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
CONFIG_PARPORT=y
# CONFIG_PARPORT_PC is not set
CONFIG_PARPORT_AX88796=m
# CONFIG_PARPORT_1284 is not set
CONFIG_PARPORT_NOT_PC=y
CONFIG_PNP=y
CONFIG_PNP_DEBUG_MESSAGES=y

#
# Protocols
#
# CONFIG_ISAPNP is not set
CONFIG_PNPBIOS=y
CONFIG_PNPBIOS_PROC_FS=y
CONFIG_PNPACPI=y
CONFIG_BLK_DEV=y
# CONFIG_BLK_DEV_NULL_BLK is not set
# CONFIG_BLK_DEV_FD is not set
# CONFIG_BLK_DEV_PCIESSD_MTIP32XX is not set
# CONFIG_ZRAM is not set
# CONFIG_BLK_DEV_UMEM is not set
# CONFIG_BLK_DEV_LOOP is not set
# CONFIG_BLK_DEV_DRBD is not set
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_SX8 is not set
# CONFIG_BLK_DEV_RAM is not set
# CONFIG_CDROM_PKTCDVD is not set
# CONFIG_ATA_OVER_ETH is not set
# CONFIG_VIRTIO_BLK is not set
# CONFIG_BLK_DEV_RBD is not set
# CONFIG_BLK_DEV_RSXX is not set

#
# NVME Support
#
CONFIG_NVME_CORE=y
# CONFIG_BLK_DEV_NVME is not set
CONFIG_NVME_MULTIPATH=y
CONFIG_NVME_FABRICS=y
# CONFIG_NVME_FC is not set
CONFIG_NVME_TARGET=y
# CONFIG_NVME_TARGET_PASSTHRU is not set
CONFIG_NVME_TARGET_LOOP=y
# CONFIG_NVME_TARGET_FC is not set
# CONFIG_NVME_TARGET_TCP is not set
# end of NVME Support

#
# Misc devices
#
CONFIG_SENSORS_LIS3LV02D=m
# CONFIG_AD525X_DPOT is not set
CONFIG_DUMMY_IRQ=y
# CONFIG_IBM_ASM is not set
# CONFIG_PHANTOM is not set
# CONFIG_TIFM_CORE is not set
CONFIG_ICS932S401=m
# CONFIG_ENCLOSURE_SERVICES is not set
# CONFIG_HP_ILO is not set
# CONFIG_APDS9802ALS is not set
CONFIG_ISL29003=m
CONFIG_ISL29020=m
CONFIG_SENSORS_TSL2550=m
CONFIG_SENSORS_BH1770=m
CONFIG_SENSORS_APDS990X=m
CONFIG_HMC6352=m
# CONFIG_DS1682 is not set
# CONFIG_PCH_PHUB is not set
CONFIG_SRAM=y
# CONFIG_PCI_ENDPOINT_TEST is not set
CONFIG_XILINX_SDFEC=m
CONFIG_MISC_RTSX=y
# CONFIG_PVPANIC is not set
CONFIG_HISI_HIKEY_USB=m
CONFIG_C2PORT=m
CONFIG_C2PORT_DURAMAR_2150=m

#
# EEPROM support
#
# CONFIG_EEPROM_AT24 is not set
CONFIG_EEPROM_LEGACY=m
# CONFIG_EEPROM_MAX6875 is not set
# CONFIG_EEPROM_93CX6 is not set
# CONFIG_EEPROM_IDT_89HPESX is not set
CONFIG_EEPROM_EE1004=m
# end of EEPROM support

# CONFIG_CB710_CORE is not set

#
# Texas Instruments shared transport line discipline
#
# CONFIG_TI_ST is not set
# end of Texas Instruments shared transport line discipline

CONFIG_SENSORS_LIS3_I2C=m
CONFIG_ALTERA_STAPL=m
# CONFIG_INTEL_MEI is not set
# CONFIG_INTEL_MEI_ME is not set
# CONFIG_INTEL_MEI_TXE is not set
# CONFIG_VMWARE_VMCI is not set
CONFIG_ECHO=y
# CONFIG_MISC_ALCOR_PCI is not set
# CONFIG_MISC_RTSX_PCI is not set
CONFIG_MISC_RTSX_USB=y
# CONFIG_HABANA_AI is not set
# end of Misc devices

CONFIG_HAVE_IDE=y
# CONFIG_IDE is not set

#
# SCSI device support
#
CONFIG_SCSI_MOD=m
# CONFIG_RAID_ATTRS is not set
CONFIG_SCSI=m
CONFIG_SCSI_DMA=y
CONFIG_SCSI_PROC_FS=y

#
# SCSI support type (disk, tape, CD-ROM)
#
# CONFIG_BLK_DEV_SD is not set
# CONFIG_CHR_DEV_ST is not set
# CONFIG_BLK_DEV_SR is not set
CONFIG_CHR_DEV_SG=m
CONFIG_CHR_DEV_SCH=m
# CONFIG_SCSI_CONSTANTS is not set
CONFIG_SCSI_LOGGING=y
# CONFIG_SCSI_SCAN_ASYNC is not set

#
# SCSI Transports
#
# CONFIG_SCSI_SPI_ATTRS is not set
# CONFIG_SCSI_FC_ATTRS is not set
# CONFIG_SCSI_ISCSI_ATTRS is not set
CONFIG_SCSI_SAS_ATTRS=m
CONFIG_SCSI_SAS_LIBSAS=m
# CONFIG_SCSI_SAS_ATA is not set
# CONFIG_SCSI_SAS_HOST_SMP is not set
CONFIG_SCSI_SRP_ATTRS=m
# end of SCSI Transports

# CONFIG_SCSI_LOWLEVEL is not set
CONFIG_SCSI_DH=y
CONFIG_SCSI_DH_RDAC=m
CONFIG_SCSI_DH_HP_SW=m
# CONFIG_SCSI_DH_EMC is not set
CONFIG_SCSI_DH_ALUA=m
# end of SCSI device support

CONFIG_ATA=m
CONFIG_SATA_HOST=y
CONFIG_PATA_TIMINGS=y
# CONFIG_ATA_VERBOSE_ERROR is not set
# CONFIG_ATA_FORCE is not set
CONFIG_ATA_ACPI=y
# CONFIG_SATA_ZPODD is not set
CONFIG_SATA_PMP=y

#
# Controllers with non-SFF native interface
#
# CONFIG_SATA_AHCI is not set
CONFIG_SATA_AHCI_PLATFORM=m
# CONFIG_AHCI_CEVA is not set
# CONFIG_AHCI_QORIQ is not set
# CONFIG_SATA_INIC162X is not set
# CONFIG_SATA_ACARD_AHCI is not set
# CONFIG_SATA_SIL24 is not set
# CONFIG_ATA_SFF is not set
# CONFIG_MD is not set
CONFIG_TARGET_CORE=y
CONFIG_TCM_IBLOCK=y
CONFIG_TCM_FILEIO=m
CONFIG_TCM_PSCSI=m
# CONFIG_LOOPBACK_TARGET is not set
# CONFIG_ISCSI_TARGET is not set
# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support
#
# CONFIG_FIREWIRE is not set
# CONFIG_FIREWIRE_NOSY is not set
# end of IEEE 1394 (FireWire) support

# CONFIG_MACINTOSH_DRIVERS is not set
CONFIG_NETDEVICES=y
CONFIG_NET_CORE=y
# CONFIG_BONDING is not set
# CONFIG_DUMMY is not set
# CONFIG_WIREGUARD is not set
# CONFIG_EQUALIZER is not set
# CONFIG_NET_FC is not set
# CONFIG_NET_TEAM is not set
# CONFIG_MACVLAN is not set
# CONFIG_IPVLAN is not set
# CONFIG_VXLAN is not set
# CONFIG_GENEVE is not set
# CONFIG_BAREUDP is not set
# CONFIG_GTP is not set
# CONFIG_MACSEC is not set
# CONFIG_NETCONSOLE is not set
# CONFIG_TUN is not set
# CONFIG_TUN_VNET_CROSS_LE is not set
# CONFIG_VETH is not set
CONFIG_VIRTIO_NET=m
# CONFIG_NLMON is not set
# CONFIG_ARCNET is not set

#
# Distributed Switch Architecture drivers
#
# end of Distributed Switch Architecture drivers

CONFIG_ETHERNET=y
CONFIG_NET_VENDOR_3COM=y
# CONFIG_EL3 is not set
# CONFIG_3C515 is not set
# CONFIG_PCMCIA_3C574 is not set
# CONFIG_PCMCIA_3C589 is not set
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
# CONFIG_LANCE is not set
# CONFIG_PCNET32 is not set
# CONFIG_PCMCIA_NMCLAN is not set
# CONFIG_NI65 is not set
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
CONFIG_NET_VENDOR_CHELSIO=y
# CONFIG_CHELSIO_T1 is not set
# CONFIG_CHELSIO_T3 is not set
# CONFIG_CHELSIO_T4 is not set
# CONFIG_CHELSIO_T4VF is not set
CONFIG_NET_VENDOR_CIRRUS=y
# CONFIG_CS89x0 is not set
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
CONFIG_NET_VENDOR_FUJITSU=y
# CONFIG_PCMCIA_FMVJ18X is not set
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
# CONFIG_PCMCIA_AXNET is not set
# CONFIG_NE2000 is not set
# CONFIG_NE2K_PCI is not set
# CONFIG_PCMCIA_PCNET is not set
# CONFIG_ULTRA is not set
# CONFIG_WD80x3 is not set
CONFIG_NET_VENDOR_NVIDIA=y
# CONFIG_FORCEDETH is not set
CONFIG_NET_VENDOR_OKI=y
# CONFIG_PCH_GBE is not set
# CONFIG_ETHOC is not set
CONFIG_NET_VENDOR_PACKET_ENGINES=y
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
CONFIG_NET_VENDOR_PENSANDO=y
CONFIG_NET_VENDOR_QLOGIC=y
# CONFIG_QLA3XXX is not set
# CONFIG_QLCNIC is not set
# CONFIG_NETXEN_NIC is not set
# CONFIG_QED is not set
CONFIG_NET_VENDOR_QUALCOMM=y
# CONFIG_QCA7000_UART is not set
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
# CONFIG_SMC9194 is not set
# CONFIG_PCMCIA_SMC91C92 is not set
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
CONFIG_NET_VENDOR_XIRCOM=y
# CONFIG_PCMCIA_XIRC2PS is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_NET_SB1000 is not set
# CONFIG_PHYLIB is not set
# CONFIG_MDIO_DEVICE is not set

#
# PCS device drivers
#
# end of PCS device drivers

# CONFIG_PLIP is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set
CONFIG_USB_NET_DRIVERS=y
# CONFIG_USB_CATC is not set
# CONFIG_USB_KAWETH is not set
# CONFIG_USB_PEGASUS is not set
# CONFIG_USB_RTL8150 is not set
# CONFIG_USB_RTL8152 is not set
# CONFIG_USB_LAN78XX is not set
# CONFIG_USB_USBNET is not set
# CONFIG_USB_IPHETH is not set
CONFIG_WLAN=y
CONFIG_WLAN_VENDOR_ADMTEK=y
CONFIG_WLAN_VENDOR_ATH=y
# CONFIG_ATH_DEBUG is not set
# CONFIG_ATH5K_PCI is not set
CONFIG_WLAN_VENDOR_ATMEL=y
CONFIG_WLAN_VENDOR_BROADCOM=y
CONFIG_WLAN_VENDOR_CISCO=y
CONFIG_WLAN_VENDOR_INTEL=y
CONFIG_WLAN_VENDOR_INTERSIL=y
# CONFIG_HOSTAP is not set
# CONFIG_PRISM54 is not set
CONFIG_WLAN_VENDOR_MARVELL=y
CONFIG_WLAN_VENDOR_MEDIATEK=y
CONFIG_WLAN_VENDOR_MICROCHIP=y
CONFIG_WLAN_VENDOR_RALINK=y
CONFIG_WLAN_VENDOR_REALTEK=y
CONFIG_WLAN_VENDOR_RSI=y
CONFIG_WLAN_VENDOR_ST=y
CONFIG_WLAN_VENDOR_TI=y
CONFIG_WLAN_VENDOR_ZYDAS=y
CONFIG_WLAN_VENDOR_QUANTENNA=y
# CONFIG_PCMCIA_RAYCS is not set
# CONFIG_WAN is not set
# CONFIG_VMXNET3 is not set
# CONFIG_FUJITSU_ES is not set
# CONFIG_NETDEVSIM is not set
CONFIG_NET_FAILOVER=m
# CONFIG_ISDN is not set
CONFIG_NVM=y
# CONFIG_NVM_PBLK is not set

#
# Input device support
#
CONFIG_INPUT=y
CONFIG_INPUT_LEDS=m
CONFIG_INPUT_FF_MEMLESS=m
CONFIG_INPUT_SPARSEKMAP=m
CONFIG_INPUT_MATRIXKMAP=m

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=m
# CONFIG_INPUT_MOUSEDEV_PSAUX is not set
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
# CONFIG_INPUT_JOYDEV is not set
# CONFIG_INPUT_EVDEV is not set
CONFIG_INPUT_EVBUG=m

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
# CONFIG_KEYBOARD_ADC is not set
# CONFIG_KEYBOARD_ADP5520 is not set
# CONFIG_KEYBOARD_ADP5588 is not set
CONFIG_KEYBOARD_ADP5589=m
CONFIG_KEYBOARD_ATKBD=y
CONFIG_KEYBOARD_QT1050=m
CONFIG_KEYBOARD_QT1070=m
CONFIG_KEYBOARD_QT2160=m
CONFIG_KEYBOARD_DLINK_DIR685=m
# CONFIG_KEYBOARD_LKKBD is not set
# CONFIG_KEYBOARD_GPIO is not set
# CONFIG_KEYBOARD_GPIO_POLLED is not set
CONFIG_KEYBOARD_TCA6416=m
# CONFIG_KEYBOARD_TCA8418 is not set
# CONFIG_KEYBOARD_MATRIX is not set
CONFIG_KEYBOARD_LM8323=m
CONFIG_KEYBOARD_LM8333=m
CONFIG_KEYBOARD_MAX7359=m
CONFIG_KEYBOARD_MCS=m
# CONFIG_KEYBOARD_MPR121 is not set
CONFIG_KEYBOARD_NEWTON=m
# CONFIG_KEYBOARD_OPENCORES is not set
# CONFIG_KEYBOARD_SAMSUNG is not set
# CONFIG_KEYBOARD_GOLDFISH_EVENTS is not set
CONFIG_KEYBOARD_STOWAWAY=m
CONFIG_KEYBOARD_SUNKBD=m
CONFIG_KEYBOARD_STMPE=m
# CONFIG_KEYBOARD_OMAP4 is not set
CONFIG_KEYBOARD_TC3589X=m
# CONFIG_KEYBOARD_TM2_TOUCHKEY is not set
CONFIG_KEYBOARD_TWL4030=m
CONFIG_KEYBOARD_XTKBD=m
# CONFIG_KEYBOARD_CAP11XX is not set
CONFIG_KEYBOARD_BCM=m
# CONFIG_KEYBOARD_MTK_PMIC is not set
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=m
CONFIG_MOUSE_PS2_ALPS=y
CONFIG_MOUSE_PS2_BYD=y
# CONFIG_MOUSE_PS2_LOGIPS2PP is not set
# CONFIG_MOUSE_PS2_SYNAPTICS is not set
# CONFIG_MOUSE_PS2_SYNAPTICS_SMBUS is not set
# CONFIG_MOUSE_PS2_CYPRESS is not set
CONFIG_MOUSE_PS2_LIFEBOOK=y
# CONFIG_MOUSE_PS2_TRACKPOINT is not set
# CONFIG_MOUSE_PS2_ELANTECH is not set
# CONFIG_MOUSE_PS2_SENTELIC is not set
CONFIG_MOUSE_PS2_TOUCHKIT=y
# CONFIG_MOUSE_PS2_OLPC is not set
# CONFIG_MOUSE_PS2_FOCALTECH is not set
# CONFIG_MOUSE_PS2_VMMOUSE is not set
# CONFIG_MOUSE_SERIAL is not set
CONFIG_MOUSE_APPLETOUCH=m
# CONFIG_MOUSE_BCM5974 is not set
# CONFIG_MOUSE_CYAPA is not set
CONFIG_MOUSE_ELAN_I2C=m
CONFIG_MOUSE_ELAN_I2C_I2C=y
# CONFIG_MOUSE_ELAN_I2C_SMBUS is not set
CONFIG_MOUSE_INPORT=m
CONFIG_MOUSE_ATIXL=y
CONFIG_MOUSE_LOGIBM=m
CONFIG_MOUSE_PC110PAD=m
CONFIG_MOUSE_VSXXXAA=m
CONFIG_MOUSE_GPIO=m
CONFIG_MOUSE_SYNAPTICS_I2C=m
CONFIG_MOUSE_SYNAPTICS_USB=m
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TABLET is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
CONFIG_INPUT_MISC=y
CONFIG_INPUT_88PM860X_ONKEY=m
CONFIG_INPUT_88PM80X_ONKEY=m
# CONFIG_INPUT_AD714X is not set
# CONFIG_INPUT_ATMEL_CAPTOUCH is not set
CONFIG_INPUT_BMA150=m
CONFIG_INPUT_E3X0_BUTTON=m
CONFIG_INPUT_PCSPKR=m
CONFIG_INPUT_MAX77650_ONKEY=m
CONFIG_INPUT_MAX77693_HAPTIC=m
CONFIG_INPUT_MAX8925_ONKEY=m
CONFIG_INPUT_MAX8997_HAPTIC=m
CONFIG_INPUT_MC13783_PWRBUTTON=m
# CONFIG_INPUT_MMA8450 is not set
# CONFIG_INPUT_APANEL is not set
# CONFIG_INPUT_GPIO_BEEPER is not set
CONFIG_INPUT_GPIO_DECODER=m
CONFIG_INPUT_GPIO_VIBRA=m
# CONFIG_INPUT_WISTRON_BTNS is not set
CONFIG_INPUT_ATLAS_BTNS=m
CONFIG_INPUT_ATI_REMOTE2=m
CONFIG_INPUT_KEYSPAN_REMOTE=m
# CONFIG_INPUT_KXTJ9 is not set
CONFIG_INPUT_POWERMATE=m
CONFIG_INPUT_YEALINK=m
CONFIG_INPUT_CM109=m
# CONFIG_INPUT_REGULATOR_HAPTIC is not set
CONFIG_INPUT_RETU_PWRBUTTON=m
CONFIG_INPUT_TPS65218_PWRBUTTON=m
CONFIG_INPUT_AXP20X_PEK=m
# CONFIG_INPUT_TWL4030_PWRBUTTON is not set
CONFIG_INPUT_TWL4030_VIBRA=m
CONFIG_INPUT_TWL6040_VIBRA=m
CONFIG_INPUT_UINPUT=m
# CONFIG_INPUT_PALMAS_PWRBUTTON is not set
CONFIG_INPUT_PCF50633_PMU=m
CONFIG_INPUT_PCF8574=m
# CONFIG_INPUT_PWM_BEEPER is not set
CONFIG_INPUT_PWM_VIBRA=m
# CONFIG_INPUT_GPIO_ROTARY_ENCODER is not set
CONFIG_INPUT_DA7280_HAPTICS=m
CONFIG_INPUT_DA9063_ONKEY=m
CONFIG_INPUT_ADXL34X=m
CONFIG_INPUT_ADXL34X_I2C=m
# CONFIG_INPUT_IMS_PCU is not set
CONFIG_INPUT_IQS269A=m
CONFIG_INPUT_CMA3000=m
CONFIG_INPUT_CMA3000_I2C=m
CONFIG_INPUT_IDEAPAD_SLIDEBAR=m
CONFIG_INPUT_DRV260X_HAPTICS=m
# CONFIG_INPUT_DRV2665_HAPTICS is not set
CONFIG_INPUT_DRV2667_HAPTICS=m
CONFIG_INPUT_RAVE_SP_PWRBUTTON=m
CONFIG_RMI4_CORE=m
CONFIG_RMI4_I2C=m
CONFIG_RMI4_SMB=m
# CONFIG_RMI4_F03 is not set
# CONFIG_RMI4_F11 is not set
# CONFIG_RMI4_F12 is not set
# CONFIG_RMI4_F30 is not set
# CONFIG_RMI4_F34 is not set
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
CONFIG_SERIO_CT82C710=y
CONFIG_SERIO_PARKBD=m
# CONFIG_SERIO_PCIPS2 is not set
CONFIG_SERIO_LIBPS2=y
CONFIG_SERIO_RAW=y
CONFIG_SERIO_ALTERA_PS2=m
CONFIG_SERIO_PS2MULT=m
CONFIG_SERIO_ARC_PS2=y
CONFIG_SERIO_APBPS2=y
# CONFIG_SERIO_GPIO_PS2 is not set
CONFIG_USERIO=y
# CONFIG_GAMEPORT is not set
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
# CONFIG_SERIAL_8250_DEPRECATED_OPTIONS is not set
# CONFIG_SERIAL_8250_PNP is not set
# CONFIG_SERIAL_8250_16550A_VARIANTS is not set
CONFIG_SERIAL_8250_FINTEK=y
CONFIG_SERIAL_8250_CONSOLE=y
# CONFIG_SERIAL_8250_DMA is not set
CONFIG_SERIAL_8250_PCI=y
CONFIG_SERIAL_8250_EXAR=y
# CONFIG_SERIAL_8250_CS is not set
CONFIG_SERIAL_8250_MEN_MCB=y
CONFIG_SERIAL_8250_NR_UARTS=4
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
CONFIG_SERIAL_8250_EXTENDED=y
CONFIG_SERIAL_8250_MANY_PORTS=y
# CONFIG_SERIAL_8250_FOURPORT is not set
CONFIG_SERIAL_8250_ACCENT=m
CONFIG_SERIAL_8250_ASPEED_VUART=m
# CONFIG_SERIAL_8250_BOCA is not set
# CONFIG_SERIAL_8250_EXAR_ST16C554 is not set
CONFIG_SERIAL_8250_HUB6=y
# CONFIG_SERIAL_8250_SHARE_IRQ is not set
# CONFIG_SERIAL_8250_DETECT_IRQ is not set
CONFIG_SERIAL_8250_RSA=y
CONFIG_SERIAL_8250_DWLIB=y
CONFIG_SERIAL_8250_DW=y
CONFIG_SERIAL_8250_RT288X=y
CONFIG_SERIAL_8250_LPSS=y
CONFIG_SERIAL_8250_MID=y
CONFIG_SERIAL_OF_PLATFORM=m

#
# Non-8250 serial port support
#
# CONFIG_SERIAL_UARTLITE is not set
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
# CONFIG_SERIAL_JSM is not set
CONFIG_SERIAL_SIFIVE=y
# CONFIG_SERIAL_SIFIVE_CONSOLE is not set
# CONFIG_SERIAL_LANTIQ is not set
CONFIG_SERIAL_SCCNXP=y
# CONFIG_SERIAL_SCCNXP_CONSOLE is not set
CONFIG_SERIAL_SC16IS7XX=y
# CONFIG_SERIAL_SC16IS7XX_I2C is not set
CONFIG_SERIAL_TIMBERDALE=m
CONFIG_SERIAL_BCM63XX=m
CONFIG_SERIAL_ALTERA_JTAGUART=m
# CONFIG_SERIAL_ALTERA_UART is not set
# CONFIG_SERIAL_PCH_UART is not set
CONFIG_SERIAL_XILINX_PS_UART=m
# CONFIG_SERIAL_ARC is not set
# CONFIG_SERIAL_RP2 is not set
# CONFIG_SERIAL_FSL_LPUART is not set
CONFIG_SERIAL_FSL_LINFLEXUART=y
CONFIG_SERIAL_FSL_LINFLEXUART_CONSOLE=y
CONFIG_SERIAL_CONEXANT_DIGICOLOR=m
CONFIG_SERIAL_MEN_Z135=y
# CONFIG_SERIAL_SPRD is not set
# end of Serial drivers

CONFIG_SERIAL_MCTRL_GPIO=y
# CONFIG_SERIAL_NONSTANDARD is not set
# CONFIG_GOLDFISH_TTY is not set
# CONFIG_N_GSM is not set
# CONFIG_NOZOMI is not set
CONFIG_NULL_TTY=y
# CONFIG_TRACE_SINK is not set
CONFIG_SERIAL_DEV_BUS=y
CONFIG_SERIAL_DEV_CTRL_TTYPORT=y
CONFIG_TTY_PRINTK=m
CONFIG_TTY_PRINTK_LEVEL=6
CONFIG_PRINTER=y
# CONFIG_LP_CONSOLE is not set
CONFIG_PPDEV=m
# CONFIG_VIRTIO_CONSOLE is not set
CONFIG_IPMI_HANDLER=y
CONFIG_IPMI_DMI_DECODE=y
CONFIG_IPMI_PLAT_DATA=y
CONFIG_IPMI_PANIC_EVENT=y
CONFIG_IPMI_PANIC_STRING=y
CONFIG_IPMI_DEVICE_INTERFACE=y
CONFIG_IPMI_SI=m
CONFIG_IPMI_SSIF=y
CONFIG_IPMI_WATCHDOG=m
# CONFIG_IPMI_POWEROFF is not set
# CONFIG_IPMB_DEVICE_INTERFACE is not set
# CONFIG_HW_RANDOM is not set
CONFIG_DTLK=y
# CONFIG_APPLICOM is not set
# CONFIG_SONYPI is not set

#
# PCMCIA character devices
#
# CONFIG_SYNCLINK_CS is not set
CONFIG_CARDMAN_4000=y
CONFIG_CARDMAN_4040=m
CONFIG_SCR24X=m
# CONFIG_IPWIRELESS is not set
# end of PCMCIA character devices

# CONFIG_MWAVE is not set
# CONFIG_SCx200_GPIO is not set
CONFIG_PC8736x_GPIO=m
CONFIG_NSC_GPIO=y
# CONFIG_DEVMEM is not set
# CONFIG_DEVKMEM is not set
CONFIG_NVRAM=y
# CONFIG_RAW_DRIVER is not set
CONFIG_DEVPORT=y
CONFIG_HPET=y
# CONFIG_HPET_MMAP is not set
CONFIG_HANGCHECK_TIMER=y
CONFIG_TCG_TPM=y
CONFIG_TCG_TIS_CORE=y
CONFIG_TCG_TIS=y
CONFIG_TCG_TIS_I2C_ATMEL=m
CONFIG_TCG_TIS_I2C_INFINEON=y
# CONFIG_TCG_TIS_I2C_NUVOTON is not set
CONFIG_TCG_NSC=m
CONFIG_TCG_ATMEL=y
CONFIG_TCG_INFINEON=m
# CONFIG_TCG_CRB is not set
# CONFIG_TCG_VTPM_PROXY is not set
CONFIG_TCG_TIS_ST33ZP24=y
CONFIG_TCG_TIS_ST33ZP24_I2C=y
CONFIG_TELCLOCK=y
# CONFIG_XILLYBUS is not set
# end of Character devices

CONFIG_RANDOM_TRUST_CPU=y
CONFIG_RANDOM_TRUST_BOOTLOADER=y

#
# I2C support
#
CONFIG_I2C=y
CONFIG_ACPI_I2C_OPREGION=y
CONFIG_I2C_BOARDINFO=y
CONFIG_I2C_COMPAT=y
# CONFIG_I2C_CHARDEV is not set
CONFIG_I2C_MUX=y

#
# Multiplexer I2C Chip support
#
CONFIG_I2C_ARB_GPIO_CHALLENGE=m
CONFIG_I2C_MUX_GPIO=y
CONFIG_I2C_MUX_GPMUX=y
CONFIG_I2C_MUX_LTC4306=m
CONFIG_I2C_MUX_PCA9541=y
CONFIG_I2C_MUX_PCA954x=m
CONFIG_I2C_MUX_PINCTRL=y
CONFIG_I2C_MUX_REG=m
CONFIG_I2C_DEMUX_PINCTRL=m
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
CONFIG_I2C_DESIGNWARE_CORE=y
CONFIG_I2C_DESIGNWARE_SLAVE=y
CONFIG_I2C_DESIGNWARE_PLATFORM=y
# CONFIG_I2C_DESIGNWARE_PCI is not set
# CONFIG_I2C_EG20T is not set
CONFIG_I2C_EMEV2=m
CONFIG_I2C_GPIO=y
# CONFIG_I2C_GPIO_FAULT_INJECTOR is not set
CONFIG_I2C_KEMPLD=y
CONFIG_I2C_OCORES=y
CONFIG_I2C_PCA_PLATFORM=m
# CONFIG_I2C_PXA is not set
CONFIG_I2C_RK3X=m
CONFIG_I2C_SIMTEC=m
# CONFIG_I2C_XILINX is not set

#
# External I2C/SMBus adapter drivers
#
CONFIG_I2C_DIOLAN_U2C=m
CONFIG_I2C_DLN2=m
# CONFIG_I2C_PARPORT is not set
# CONFIG_I2C_ROBOTFUZZ_OSIF is not set
CONFIG_I2C_TAOS_EVM=y
CONFIG_I2C_TINY_USB=m

#
# Other I2C/SMBus bus drivers
#
# CONFIG_I2C_PCA_ISA is not set
# CONFIG_SCx200_ACB is not set
CONFIG_I2C_FSI=y
# end of I2C Hardware Bus support

CONFIG_I2C_STUB=m
CONFIG_I2C_SLAVE=y
CONFIG_I2C_SLAVE_EEPROM=m
CONFIG_I2C_SLAVE_TESTUNIT=y
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# end of I2C support

CONFIG_I3C=y
CONFIG_CDNS_I3C_MASTER=m
CONFIG_DW_I3C_MASTER=y
CONFIG_MIPI_I3C_HCI=y
# CONFIG_SPI is not set
# CONFIG_SPMI is not set
CONFIG_HSI=m
CONFIG_HSI_BOARDINFO=y

#
# HSI controllers
#

#
# HSI clients
#
CONFIG_HSI_CHAR=m
# CONFIG_PPS is not set

#
# PTP clock support
#

#
# Enable PHYLIB and NETWORK_PHY_TIMESTAMPING to see the additional clocks.
#
# CONFIG_PTP_1588_CLOCK_PCH is not set
# end of PTP clock support

CONFIG_PINCTRL=y
CONFIG_GENERIC_PINCTRL_GROUPS=y
CONFIG_PINMUX=y
CONFIG_GENERIC_PINMUX_FUNCTIONS=y
CONFIG_PINCONF=y
CONFIG_GENERIC_PINCONF=y
# CONFIG_DEBUG_PINCTRL is not set
# CONFIG_PINCTRL_AS3722 is not set
CONFIG_PINCTRL_AXP209=y
# CONFIG_PINCTRL_AMD is not set
CONFIG_PINCTRL_DA9062=m
CONFIG_PINCTRL_MCP23S08_I2C=m
CONFIG_PINCTRL_MCP23S08=m
CONFIG_PINCTRL_SINGLE=y
# CONFIG_PINCTRL_SX150X is not set
CONFIG_PINCTRL_STMFX=y
CONFIG_PINCTRL_MAX77620=m
# CONFIG_PINCTRL_PALMAS is not set
CONFIG_PINCTRL_OCELOT=y
# CONFIG_PINCTRL_MICROCHIP_SGPIO is not set
CONFIG_PINCTRL_BAYTRAIL=y
CONFIG_PINCTRL_CHERRYVIEW=m
CONFIG_PINCTRL_LYNXPOINT=y
CONFIG_PINCTRL_INTEL=y
CONFIG_PINCTRL_ALDERLAKE=m
CONFIG_PINCTRL_BROXTON=m
CONFIG_PINCTRL_CANNONLAKE=m
CONFIG_PINCTRL_CEDARFORK=y
CONFIG_PINCTRL_DENVERTON=y
CONFIG_PINCTRL_ELKHARTLAKE=y
CONFIG_PINCTRL_EMMITSBURG=y
CONFIG_PINCTRL_GEMINILAKE=m
CONFIG_PINCTRL_ICELAKE=y
# CONFIG_PINCTRL_JASPERLAKE is not set
CONFIG_PINCTRL_LAKEFIELD=m
# CONFIG_PINCTRL_LEWISBURG is not set
# CONFIG_PINCTRL_SUNRISEPOINT is not set
CONFIG_PINCTRL_TIGERLAKE=y

#
# Renesas pinctrl drivers
#
# end of Renesas pinctrl drivers

CONFIG_PINCTRL_LOCHNAGAR=y
CONFIG_PINCTRL_MADERA=m
CONFIG_PINCTRL_CS47L15=y
CONFIG_PINCTRL_CS47L85=y
CONFIG_PINCTRL_EQUILIBRIUM=m
CONFIG_GPIOLIB=y
CONFIG_GPIOLIB_FASTPATH_LIMIT=512
CONFIG_OF_GPIO=y
CONFIG_GPIO_ACPI=y
CONFIG_GPIOLIB_IRQCHIP=y
# CONFIG_DEBUG_GPIO is not set
# CONFIG_GPIO_SYSFS is not set
CONFIG_GPIO_CDEV=y
CONFIG_GPIO_CDEV_V1=y
CONFIG_GPIO_GENERIC=y

#
# Memory mapped GPIO drivers
#
# CONFIG_GPIO_74XX_MMIO is not set
CONFIG_GPIO_ALTERA=m
CONFIG_GPIO_AMDPT=y
CONFIG_GPIO_CADENCE=y
# CONFIG_GPIO_DWAPB is not set
# CONFIG_GPIO_EXAR is not set
CONFIG_GPIO_FTGPIO010=y
CONFIG_GPIO_GENERIC_PLATFORM=m
CONFIG_GPIO_GRGPIO=m
# CONFIG_GPIO_HLWD is not set
# CONFIG_GPIO_ICH is not set
CONFIG_GPIO_LOGICVC=m
CONFIG_GPIO_MB86S7X=y
# CONFIG_GPIO_MENZ127 is not set
CONFIG_GPIO_SAMA5D2_PIOBU=m
CONFIG_GPIO_SIFIVE=y
CONFIG_GPIO_SYSCON=y
# CONFIG_GPIO_VX855 is not set
CONFIG_GPIO_XILINX=m
CONFIG_GPIO_AMD_FCH=y
# end of Memory mapped GPIO drivers

#
# Port-mapped I/O GPIO drivers
#
CONFIG_GPIO_104_DIO_48E=y
CONFIG_GPIO_104_IDIO_16=y
# CONFIG_GPIO_104_IDI_48 is not set
# CONFIG_GPIO_F7188X is not set
# CONFIG_GPIO_GPIO_MM is not set
# CONFIG_GPIO_IT87 is not set
# CONFIG_GPIO_SCH is not set
CONFIG_GPIO_SCH311X=y
CONFIG_GPIO_WINBOND=m
CONFIG_GPIO_WS16C48=y
# end of Port-mapped I/O GPIO drivers

#
# I2C GPIO expanders
#
# CONFIG_GPIO_ADP5588 is not set
CONFIG_GPIO_ADNP=m
CONFIG_GPIO_GW_PLD=m
# CONFIG_GPIO_MAX7300 is not set
CONFIG_GPIO_MAX732X=m
CONFIG_GPIO_PCA953X=m
CONFIG_GPIO_PCA953X_IRQ=y
# CONFIG_GPIO_PCA9570 is not set
CONFIG_GPIO_PCF857X=m
CONFIG_GPIO_TPIC2810=y
# end of I2C GPIO expanders

#
# MFD GPIO expanders
#
# CONFIG_GPIO_ADP5520 is not set
CONFIG_GPIO_ARIZONA=y
# CONFIG_GPIO_BD70528 is not set
# CONFIG_GPIO_BD71828 is not set
CONFIG_GPIO_DLN2=m
CONFIG_GPIO_KEMPLD=m
# CONFIG_GPIO_LP3943 is not set
# CONFIG_GPIO_LP873X is not set
# CONFIG_GPIO_MADERA is not set
# CONFIG_GPIO_MAX77620 is not set
CONFIG_GPIO_MAX77650=m
CONFIG_GPIO_PALMAS=y
CONFIG_GPIO_RC5T583=y
CONFIG_GPIO_STMPE=y
# CONFIG_GPIO_TC3589X is not set
CONFIG_GPIO_TPS65218=m
# CONFIG_GPIO_TPS6586X is not set
CONFIG_GPIO_TPS65912=y
CONFIG_GPIO_TQMX86=m
CONFIG_GPIO_TWL4030=y
# CONFIG_GPIO_TWL6040 is not set
# CONFIG_GPIO_WM8350 is not set
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
# USB GPIO expanders
#
# end of USB GPIO expanders

#
# Virtual GPIO drivers
#
CONFIG_GPIO_AGGREGATOR=y
CONFIG_GPIO_MOCKUP=m
# end of Virtual GPIO drivers

CONFIG_W1=y

#
# 1-wire Bus Masters
#
# CONFIG_W1_MASTER_MATROX is not set
CONFIG_W1_MASTER_DS2490=m
# CONFIG_W1_MASTER_DS2482 is not set
CONFIG_W1_MASTER_DS1WM=m
# CONFIG_W1_MASTER_GPIO is not set
CONFIG_W1_MASTER_SGI=m
# end of 1-wire Bus Masters

#
# 1-wire Slaves
#
CONFIG_W1_SLAVE_THERM=m
CONFIG_W1_SLAVE_SMEM=y
CONFIG_W1_SLAVE_DS2405=y
CONFIG_W1_SLAVE_DS2408=y
CONFIG_W1_SLAVE_DS2408_READBACK=y
# CONFIG_W1_SLAVE_DS2413 is not set
CONFIG_W1_SLAVE_DS2406=y
CONFIG_W1_SLAVE_DS2423=y
CONFIG_W1_SLAVE_DS2805=m
CONFIG_W1_SLAVE_DS2430=m
CONFIG_W1_SLAVE_DS2431=m
CONFIG_W1_SLAVE_DS2433=m
CONFIG_W1_SLAVE_DS2433_CRC=y
CONFIG_W1_SLAVE_DS2438=y
CONFIG_W1_SLAVE_DS250X=m
CONFIG_W1_SLAVE_DS2780=m
CONFIG_W1_SLAVE_DS2781=y
# CONFIG_W1_SLAVE_DS28E04 is not set
# CONFIG_W1_SLAVE_DS28E17 is not set
# end of 1-wire Slaves

CONFIG_POWER_RESET=y
CONFIG_POWER_RESET_AS3722=y
# CONFIG_POWER_RESET_GPIO is not set
# CONFIG_POWER_RESET_GPIO_RESTART is not set
# CONFIG_POWER_RESET_LTC2952 is not set
CONFIG_POWER_RESET_MT6323=y
# CONFIG_POWER_RESET_REGULATOR is not set
# CONFIG_POWER_RESET_RESTART is not set
# CONFIG_POWER_RESET_SYSCON is not set
CONFIG_POWER_RESET_SYSCON_POWEROFF=y
CONFIG_REBOOT_MODE=y
# CONFIG_SYSCON_REBOOT_MODE is not set
CONFIG_NVMEM_REBOOT_MODE=y
CONFIG_POWER_SUPPLY=y
# CONFIG_POWER_SUPPLY_DEBUG is not set
CONFIG_PDA_POWER=m
CONFIG_GENERIC_ADC_BATTERY=m
CONFIG_MAX8925_POWER=y
CONFIG_WM8350_POWER=y
CONFIG_TEST_POWER=y
# CONFIG_BATTERY_88PM860X is not set
# CONFIG_CHARGER_ADP5061 is not set
CONFIG_BATTERY_CW2015=m
CONFIG_BATTERY_DS2760=m
# CONFIG_BATTERY_DS2780 is not set
CONFIG_BATTERY_DS2781=y
# CONFIG_BATTERY_DS2782 is not set
CONFIG_BATTERY_OLPC=y
# CONFIG_BATTERY_SBS is not set
# CONFIG_CHARGER_SBS is not set
CONFIG_MANAGER_SBS=y
CONFIG_BATTERY_BQ27XXX=y
CONFIG_BATTERY_BQ27XXX_I2C=m
CONFIG_BATTERY_BQ27XXX_HDQ=m
CONFIG_BATTERY_BQ27XXX_DT_UPDATES_NVM=y
# CONFIG_CHARGER_DA9150 is not set
CONFIG_BATTERY_DA9150=m
CONFIG_CHARGER_AXP20X=m
# CONFIG_BATTERY_AXP20X is not set
CONFIG_AXP20X_POWER=m
# CONFIG_AXP288_CHARGER is not set
# CONFIG_AXP288_FUEL_GAUGE is not set
CONFIG_BATTERY_MAX17040=m
CONFIG_BATTERY_MAX17042=y
# CONFIG_BATTERY_MAX1721X is not set
CONFIG_BATTERY_TWL4030_MADC=m
CONFIG_CHARGER_PCF50633=m
CONFIG_BATTERY_RX51=m
CONFIG_CHARGER_ISP1704=m
CONFIG_CHARGER_MAX8903=m
CONFIG_CHARGER_TWL4030=m
CONFIG_CHARGER_LP8727=y
CONFIG_CHARGER_LP8788=m
# CONFIG_CHARGER_GPIO is not set
CONFIG_CHARGER_MANAGER=y
# CONFIG_CHARGER_LT3651 is not set
CONFIG_CHARGER_MAX14577=m
CONFIG_CHARGER_DETECTOR_MAX14656=y
# CONFIG_CHARGER_MAX77650 is not set
CONFIG_CHARGER_MAX8997=y
# CONFIG_CHARGER_MP2629 is not set
CONFIG_CHARGER_BQ2415X=m
CONFIG_CHARGER_BQ24190=y
CONFIG_CHARGER_BQ24257=y
CONFIG_CHARGER_BQ24735=m
CONFIG_CHARGER_BQ2515X=m
CONFIG_CHARGER_BQ25890=m
CONFIG_CHARGER_BQ25980=y
CONFIG_CHARGER_SMB347=m
CONFIG_BATTERY_GAUGE_LTC2941=m
CONFIG_BATTERY_GOLDFISH=y
# CONFIG_CHARGER_RT9455 is not set
# CONFIG_CHARGER_UCS1002 is not set
CONFIG_CHARGER_BD70528=y
# CONFIG_CHARGER_BD99954 is not set
CONFIG_RN5T618_POWER=m
CONFIG_HWMON=m
CONFIG_HWMON_VID=m
# CONFIG_HWMON_DEBUG_CHIP is not set

#
# Native drivers
#
CONFIG_SENSORS_ABITUGURU=m
CONFIG_SENSORS_ABITUGURU3=m
CONFIG_SENSORS_AD7414=m
CONFIG_SENSORS_AD7418=m
CONFIG_SENSORS_ADM1021=m
CONFIG_SENSORS_ADM1025=m
# CONFIG_SENSORS_ADM1026 is not set
CONFIG_SENSORS_ADM1029=m
CONFIG_SENSORS_ADM1031=m
# CONFIG_SENSORS_ADM1177 is not set
CONFIG_SENSORS_ADM9240=m
CONFIG_SENSORS_ADT7X10=m
CONFIG_SENSORS_ADT7410=m
# CONFIG_SENSORS_ADT7411 is not set
# CONFIG_SENSORS_ADT7462 is not set
# CONFIG_SENSORS_ADT7470 is not set
# CONFIG_SENSORS_ADT7475 is not set
# CONFIG_SENSORS_AS370 is not set
CONFIG_SENSORS_ASC7621=m
CONFIG_SENSORS_AXI_FAN_CONTROL=m
# CONFIG_SENSORS_K8TEMP is not set
# CONFIG_SENSORS_K10TEMP is not set
# CONFIG_SENSORS_FAM15H_POWER is not set
CONFIG_SENSORS_AMD_ENERGY=m
CONFIG_SENSORS_APPLESMC=m
# CONFIG_SENSORS_ASB100 is not set
# CONFIG_SENSORS_ASPEED is not set
CONFIG_SENSORS_ATXP1=m
CONFIG_SENSORS_DRIVETEMP=m
# CONFIG_SENSORS_DS620 is not set
CONFIG_SENSORS_DS1621=m
CONFIG_SENSORS_DELL_SMM=m
# CONFIG_SENSORS_I5K_AMB is not set
# CONFIG_SENSORS_F71805F is not set
# CONFIG_SENSORS_F71882FG is not set
# CONFIG_SENSORS_F75375S is not set
CONFIG_SENSORS_MC13783_ADC=m
# CONFIG_SENSORS_FSCHMD is not set
# CONFIG_SENSORS_GL518SM is not set
CONFIG_SENSORS_GL520SM=m
CONFIG_SENSORS_G760A=m
# CONFIG_SENSORS_G762 is not set
# CONFIG_SENSORS_GPIO_FAN is not set
# CONFIG_SENSORS_HIH6130 is not set
# CONFIG_SENSORS_IBMAEM is not set
# CONFIG_SENSORS_IBMPEX is not set
CONFIG_SENSORS_IIO_HWMON=m
# CONFIG_SENSORS_I5500 is not set
# CONFIG_SENSORS_CORETEMP is not set
CONFIG_SENSORS_IT87=m
# CONFIG_SENSORS_JC42 is not set
CONFIG_SENSORS_POWR1220=m
# CONFIG_SENSORS_LINEAGE is not set
CONFIG_SENSORS_LOCHNAGAR=m
# CONFIG_SENSORS_LTC2945 is not set
CONFIG_SENSORS_LTC2947=m
CONFIG_SENSORS_LTC2947_I2C=m
# CONFIG_SENSORS_LTC2990 is not set
CONFIG_SENSORS_LTC2992=m
# CONFIG_SENSORS_LTC4151 is not set
# CONFIG_SENSORS_LTC4215 is not set
CONFIG_SENSORS_LTC4222=m
CONFIG_SENSORS_LTC4245=m
CONFIG_SENSORS_LTC4260=m
# CONFIG_SENSORS_LTC4261 is not set
CONFIG_SENSORS_MAX127=m
CONFIG_SENSORS_MAX16065=m
# CONFIG_SENSORS_MAX1619 is not set
CONFIG_SENSORS_MAX1668=m
CONFIG_SENSORS_MAX197=m
CONFIG_SENSORS_MAX31730=m
CONFIG_SENSORS_MAX6621=m
CONFIG_SENSORS_MAX6639=m
# CONFIG_SENSORS_MAX6642 is not set
CONFIG_SENSORS_MAX6650=m
CONFIG_SENSORS_MAX6697=m
CONFIG_SENSORS_MAX31790=m
# CONFIG_SENSORS_MCP3021 is not set
# CONFIG_SENSORS_MLXREG_FAN is not set
CONFIG_SENSORS_TC654=m
CONFIG_SENSORS_MENF21BMC_HWMON=m
CONFIG_SENSORS_MR75203=m
CONFIG_SENSORS_LM63=m
CONFIG_SENSORS_LM73=m
# CONFIG_SENSORS_LM75 is not set
CONFIG_SENSORS_LM77=m
CONFIG_SENSORS_LM78=m
CONFIG_SENSORS_LM80=m
# CONFIG_SENSORS_LM83 is not set
CONFIG_SENSORS_LM85=m
CONFIG_SENSORS_LM87=m
# CONFIG_SENSORS_LM90 is not set
CONFIG_SENSORS_LM92=m
CONFIG_SENSORS_LM93=m
# CONFIG_SENSORS_LM95234 is not set
# CONFIG_SENSORS_LM95241 is not set
CONFIG_SENSORS_LM95245=m
CONFIG_SENSORS_PC87360=m
CONFIG_SENSORS_PC87427=m
CONFIG_SENSORS_NTC_THERMISTOR=m
CONFIG_SENSORS_NCT6683=m
CONFIG_SENSORS_NCT6775=m
CONFIG_SENSORS_NCT7802=m
# CONFIG_SENSORS_NPCM7XX is not set
CONFIG_SENSORS_PCF8591=m
CONFIG_PMBUS=m
CONFIG_SENSORS_PMBUS=m
CONFIG_SENSORS_ADM1266=m
CONFIG_SENSORS_ADM1275=m
# CONFIG_SENSORS_BEL_PFE is not set
CONFIG_SENSORS_IBM_CFFPS=m
# CONFIG_SENSORS_INSPUR_IPSPS is not set
# CONFIG_SENSORS_IR35221 is not set
# CONFIG_SENSORS_IR38064 is not set
CONFIG_SENSORS_IRPS5401=m
CONFIG_SENSORS_ISL68137=m
CONFIG_SENSORS_LM25066=m
# CONFIG_SENSORS_LTC2978 is not set
# CONFIG_SENSORS_LTC3815 is not set
# CONFIG_SENSORS_MAX16064 is not set
CONFIG_SENSORS_MAX16601=m
CONFIG_SENSORS_MAX20730=m
CONFIG_SENSORS_MAX20751=m
CONFIG_SENSORS_MAX31785=m
CONFIG_SENSORS_MAX34440=m
CONFIG_SENSORS_MAX8688=m
CONFIG_SENSORS_MP2975=m
CONFIG_SENSORS_PM6764TR=m
CONFIG_SENSORS_PXE1610=m
# CONFIG_SENSORS_Q54SJ108A2 is not set
CONFIG_SENSORS_TPS40422=m
CONFIG_SENSORS_TPS53679=m
CONFIG_SENSORS_UCD9000=m
CONFIG_SENSORS_UCD9200=m
CONFIG_SENSORS_XDPE122=m
CONFIG_SENSORS_ZL6100=m
CONFIG_SENSORS_PWM_FAN=m
CONFIG_SENSORS_SBTSI=m
# CONFIG_SENSORS_SHT15 is not set
CONFIG_SENSORS_SHT21=m
CONFIG_SENSORS_SHT3x=m
CONFIG_SENSORS_SHTC1=m
# CONFIG_SENSORS_SIS5595 is not set
CONFIG_SENSORS_DME1737=m
CONFIG_SENSORS_EMC1403=m
CONFIG_SENSORS_EMC2103=m
# CONFIG_SENSORS_EMC6W201 is not set
CONFIG_SENSORS_SMSC47M1=m
# CONFIG_SENSORS_SMSC47M192 is not set
CONFIG_SENSORS_SMSC47B397=m
CONFIG_SENSORS_STTS751=m
# CONFIG_SENSORS_SMM665 is not set
# CONFIG_SENSORS_ADC128D818 is not set
CONFIG_SENSORS_ADS7828=m
CONFIG_SENSORS_AMC6821=m
CONFIG_SENSORS_INA209=m
# CONFIG_SENSORS_INA2XX is not set
CONFIG_SENSORS_INA3221=m
CONFIG_SENSORS_TC74=m
# CONFIG_SENSORS_THMC50 is not set
CONFIG_SENSORS_TMP102=m
# CONFIG_SENSORS_TMP103 is not set
CONFIG_SENSORS_TMP108=m
CONFIG_SENSORS_TMP401=m
CONFIG_SENSORS_TMP421=m
CONFIG_SENSORS_TMP513=m
CONFIG_SENSORS_VIA_CPUTEMP=m
# CONFIG_SENSORS_VIA686A is not set
# CONFIG_SENSORS_VT1211 is not set
# CONFIG_SENSORS_VT8231 is not set
CONFIG_SENSORS_W83773G=m
# CONFIG_SENSORS_W83781D is not set
CONFIG_SENSORS_W83791D=m
# CONFIG_SENSORS_W83792D is not set
CONFIG_SENSORS_W83793=m
CONFIG_SENSORS_W83795=m
# CONFIG_SENSORS_W83795_FANCTRL is not set
# CONFIG_SENSORS_W83L785TS is not set
# CONFIG_SENSORS_W83L786NG is not set
# CONFIG_SENSORS_W83627HF is not set
CONFIG_SENSORS_W83627EHF=m
# CONFIG_SENSORS_WM8350 is not set

#
# ACPI drivers
#
# CONFIG_SENSORS_ACPI_POWER is not set
# CONFIG_SENSORS_ATK0110 is not set
CONFIG_THERMAL=y
# CONFIG_THERMAL_NETLINK is not set
CONFIG_THERMAL_STATISTICS=y
CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
CONFIG_THERMAL_OF=y
CONFIG_THERMAL_WRITABLE_TRIPS=y
# CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE is not set
# CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE=y
# CONFIG_THERMAL_DEFAULT_GOV_POWER_ALLOCATOR is not set
# CONFIG_THERMAL_GOV_FAIR_SHARE is not set
CONFIG_THERMAL_GOV_STEP_WISE=y
CONFIG_THERMAL_GOV_BANG_BANG=y
CONFIG_THERMAL_GOV_USER_SPACE=y
CONFIG_THERMAL_GOV_POWER_ALLOCATOR=y
CONFIG_CPU_THERMAL=y
# CONFIG_CPU_FREQ_THERMAL is not set
# CONFIG_DEVFREQ_THERMAL is not set
CONFIG_THERMAL_EMULATION=y
CONFIG_THERMAL_MMIO=y
CONFIG_MAX77620_THERMAL=m
# CONFIG_DA9062_THERMAL is not set

#
# Intel thermal drivers
#
CONFIG_INTEL_POWERCLAMP=m
CONFIG_X86_PKG_TEMP_THERMAL=m
# CONFIG_INTEL_SOC_DTS_THERMAL is not set

#
# ACPI INT340X thermal drivers
#
# CONFIG_INT340X_THERMAL is not set
# end of ACPI INT340X thermal drivers

# CONFIG_INTEL_PCH_THERMAL is not set
# end of Intel thermal drivers

# CONFIG_TI_SOC_THERMAL is not set
CONFIG_GENERIC_ADC_THERMAL=m
# CONFIG_WATCHDOG is not set
CONFIG_SSB_POSSIBLE=y
# CONFIG_SSB is not set
CONFIG_BCMA_POSSIBLE=y
CONFIG_BCMA=y
CONFIG_BCMA_HOST_PCI_POSSIBLE=y
CONFIG_BCMA_HOST_PCI=y
# CONFIG_BCMA_HOST_SOC is not set
CONFIG_BCMA_DRIVER_PCI=y
# CONFIG_BCMA_DRIVER_GMAC_CMN is not set
# CONFIG_BCMA_DRIVER_GPIO is not set
CONFIG_BCMA_DEBUG=y

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=y
# CONFIG_MFD_CS5535 is not set
# CONFIG_MFD_ACT8945A is not set
# CONFIG_MFD_AS3711 is not set
CONFIG_MFD_AS3722=y
CONFIG_PMIC_ADP5520=y
CONFIG_MFD_AAT2870_CORE=y
# CONFIG_MFD_ATMEL_FLEXCOM is not set
CONFIG_MFD_ATMEL_HLCDC=m
CONFIG_MFD_BCM590XX=y
# CONFIG_MFD_BD9571MWV is not set
CONFIG_MFD_AXP20X=y
CONFIG_MFD_AXP20X_I2C=y
CONFIG_MFD_MADERA=m
CONFIG_MFD_MADERA_I2C=m
CONFIG_MFD_CS47L15=y
# CONFIG_MFD_CS47L35 is not set
CONFIG_MFD_CS47L85=y
# CONFIG_MFD_CS47L90 is not set
# CONFIG_MFD_CS47L92 is not set
# CONFIG_PMIC_DA903X is not set
# CONFIG_MFD_DA9052_I2C is not set
# CONFIG_MFD_DA9055 is not set
CONFIG_MFD_DA9062=m
# CONFIG_MFD_DA9063 is not set
CONFIG_MFD_DA9150=m
CONFIG_MFD_DLN2=m
# CONFIG_MFD_GATEWORKS_GSC is not set
CONFIG_MFD_MC13XXX=m
CONFIG_MFD_MC13XXX_I2C=m
CONFIG_MFD_MP2629=y
CONFIG_MFD_HI6421_PMIC=y
CONFIG_HTC_PASIC3=m
# CONFIG_HTC_I2CPLD is not set
# CONFIG_MFD_INTEL_QUARK_I2C_GPIO is not set
# CONFIG_LPC_ICH is not set
# CONFIG_LPC_SCH is not set
# CONFIG_INTEL_SOC_PMIC is not set
# CONFIG_INTEL_SOC_PMIC_CHTWC is not set
# CONFIG_INTEL_SOC_PMIC_CHTDC_TI is not set
CONFIG_INTEL_SOC_PMIC_MRFLD=m
CONFIG_MFD_INTEL_LPSS=m
CONFIG_MFD_INTEL_LPSS_ACPI=m
# CONFIG_MFD_INTEL_LPSS_PCI is not set
# CONFIG_MFD_INTEL_MSIC is not set
# CONFIG_MFD_INTEL_PMC_BXT is not set
# CONFIG_MFD_INTEL_PMT is not set
# CONFIG_MFD_IQS62X is not set
# CONFIG_MFD_JANZ_CMODIO is not set
CONFIG_MFD_KEMPLD=y
CONFIG_MFD_88PM800=y
CONFIG_MFD_88PM805=m
CONFIG_MFD_88PM860X=y
CONFIG_MFD_MAX14577=y
CONFIG_MFD_MAX77620=y
CONFIG_MFD_MAX77650=m
CONFIG_MFD_MAX77686=y
# CONFIG_MFD_MAX77693 is not set
CONFIG_MFD_MAX77843=y
CONFIG_MFD_MAX8907=m
CONFIG_MFD_MAX8925=y
CONFIG_MFD_MAX8997=y
CONFIG_MFD_MAX8998=y
# CONFIG_MFD_MT6360 is not set
CONFIG_MFD_MT6397=m
CONFIG_MFD_MENF21BMC=m
# CONFIG_MFD_VIPERBOARD is not set
CONFIG_MFD_RETU=m
CONFIG_MFD_PCF50633=m
# CONFIG_PCF50633_ADC is not set
# CONFIG_PCF50633_GPIO is not set
# CONFIG_MFD_RDC321X is not set
# CONFIG_MFD_RT5033 is not set
CONFIG_MFD_RC5T583=y
# CONFIG_MFD_RK808 is not set
CONFIG_MFD_RN5T618=m
CONFIG_MFD_SEC_CORE=y
CONFIG_MFD_SI476X_CORE=y
# CONFIG_MFD_SM501 is not set
# CONFIG_MFD_SKY81452 is not set
# CONFIG_ABX500_CORE is not set
CONFIG_MFD_STMPE=y

#
# STMicroelectronics STMPE Interface Drivers
#
CONFIG_STMPE_I2C=y
# end of STMicroelectronics STMPE Interface Drivers

CONFIG_MFD_SYSCON=y
CONFIG_MFD_TI_AM335X_TSCADC=m
CONFIG_MFD_LP3943=m
CONFIG_MFD_LP8788=y
# CONFIG_MFD_TI_LMU is not set
CONFIG_MFD_PALMAS=y
CONFIG_TPS6105X=m
# CONFIG_TPS65010 is not set
CONFIG_TPS6507X=m
# CONFIG_MFD_TPS65086 is not set
# CONFIG_MFD_TPS65090 is not set
# CONFIG_MFD_TPS65217 is not set
# CONFIG_MFD_TPS68470 is not set
CONFIG_MFD_TI_LP873X=y
# CONFIG_MFD_TI_LP87565 is not set
CONFIG_MFD_TPS65218=y
CONFIG_MFD_TPS6586X=y
# CONFIG_MFD_TPS65910 is not set
CONFIG_MFD_TPS65912=y
CONFIG_MFD_TPS65912_I2C=y
CONFIG_MFD_TPS80031=y
CONFIG_TWL4030_CORE=y
CONFIG_MFD_TWL4030_AUDIO=y
CONFIG_TWL6040_CORE=y
CONFIG_MFD_WL1273_CORE=y
# CONFIG_MFD_LM3533 is not set
# CONFIG_MFD_TIMBERDALE is not set
CONFIG_MFD_TC3589X=y
CONFIG_MFD_TQMX86=m
# CONFIG_MFD_VX855 is not set
CONFIG_MFD_LOCHNAGAR=y
CONFIG_MFD_ARIZONA=y
CONFIG_MFD_ARIZONA_I2C=y
# CONFIG_MFD_CS47L24 is not set
# CONFIG_MFD_WM5102 is not set
# CONFIG_MFD_WM5110 is not set
# CONFIG_MFD_WM8997 is not set
CONFIG_MFD_WM8998=y
# CONFIG_MFD_WM8400 is not set
# CONFIG_MFD_WM831X_I2C is not set
CONFIG_MFD_WM8350=y
CONFIG_MFD_WM8350_I2C=y
# CONFIG_MFD_WM8994 is not set
CONFIG_MFD_ROHM_BD718XX=m
CONFIG_MFD_ROHM_BD70528=y
CONFIG_MFD_ROHM_BD71828=y
# CONFIG_MFD_STPMIC1 is not set
CONFIG_MFD_STMFX=y
CONFIG_RAVE_SP_CORE=m
# end of Multifunction device drivers

CONFIG_REGULATOR=y
# CONFIG_REGULATOR_DEBUG is not set
CONFIG_REGULATOR_FIXED_VOLTAGE=y
CONFIG_REGULATOR_VIRTUAL_CONSUMER=y
# CONFIG_REGULATOR_USERSPACE_CONSUMER is not set
CONFIG_REGULATOR_88PG86X=m
CONFIG_REGULATOR_88PM800=m
# CONFIG_REGULATOR_88PM8607 is not set
CONFIG_REGULATOR_ACT8865=y
# CONFIG_REGULATOR_AD5398 is not set
CONFIG_REGULATOR_AAT2870=y
CONFIG_REGULATOR_AS3722=y
# CONFIG_REGULATOR_AXP20X is not set
# CONFIG_REGULATOR_BCM590XX is not set
# CONFIG_REGULATOR_BD70528 is not set
CONFIG_REGULATOR_BD71828=m
# CONFIG_REGULATOR_BD718XX is not set
# CONFIG_REGULATOR_DA9062 is not set
# CONFIG_REGULATOR_DA9121 is not set
CONFIG_REGULATOR_DA9210=m
# CONFIG_REGULATOR_DA9211 is not set
CONFIG_REGULATOR_FAN53555=m
CONFIG_REGULATOR_FAN53880=y
# CONFIG_REGULATOR_GPIO is not set
CONFIG_REGULATOR_HI6421=y
CONFIG_REGULATOR_HI6421V530=y
CONFIG_REGULATOR_ISL9305=m
CONFIG_REGULATOR_ISL6271A=y
# CONFIG_REGULATOR_LOCHNAGAR is not set
CONFIG_REGULATOR_LP3971=m
CONFIG_REGULATOR_LP3972=y
# CONFIG_REGULATOR_LP872X is not set
CONFIG_REGULATOR_LP873X=y
CONFIG_REGULATOR_LP8755=m
CONFIG_REGULATOR_LP8788=m
# CONFIG_REGULATOR_LTC3589 is not set
# CONFIG_REGULATOR_LTC3676 is not set
# CONFIG_REGULATOR_MAX14577 is not set
CONFIG_REGULATOR_MAX1586=m
# CONFIG_REGULATOR_MAX77620 is not set
CONFIG_REGULATOR_MAX77650=m
CONFIG_REGULATOR_MAX8649=m
CONFIG_REGULATOR_MAX8660=m
CONFIG_REGULATOR_MAX8907=m
CONFIG_REGULATOR_MAX8925=y
CONFIG_REGULATOR_MAX8952=m
# CONFIG_REGULATOR_MAX8973 is not set
CONFIG_REGULATOR_MAX8997=y
# CONFIG_REGULATOR_MAX8998 is not set
CONFIG_REGULATOR_MAX77686=y
CONFIG_REGULATOR_MAX77693=m
CONFIG_REGULATOR_MAX77802=m
CONFIG_REGULATOR_MAX77826=y
CONFIG_REGULATOR_MC13XXX_CORE=m
# CONFIG_REGULATOR_MC13783 is not set
CONFIG_REGULATOR_MC13892=m
CONFIG_REGULATOR_MCP16502=m
# CONFIG_REGULATOR_MP5416 is not set
CONFIG_REGULATOR_MP8859=y
# CONFIG_REGULATOR_MP886X is not set
# CONFIG_REGULATOR_MPQ7920 is not set
CONFIG_REGULATOR_MT6311=m
# CONFIG_REGULATOR_MT6323 is not set
CONFIG_REGULATOR_MT6358=m
# CONFIG_REGULATOR_MT6397 is not set
CONFIG_REGULATOR_PALMAS=y
# CONFIG_REGULATOR_PCA9450 is not set
# CONFIG_REGULATOR_PCF50633 is not set
CONFIG_REGULATOR_PF8X00=m
# CONFIG_REGULATOR_PFUZE100 is not set
CONFIG_REGULATOR_PV88060=y
CONFIG_REGULATOR_PV88080=m
# CONFIG_REGULATOR_PV88090 is not set
CONFIG_REGULATOR_PWM=y
# CONFIG_REGULATOR_RASPBERRYPI_TOUCHSCREEN_ATTINY is not set
CONFIG_REGULATOR_RC5T583=y
CONFIG_REGULATOR_RN5T618=m
CONFIG_REGULATOR_ROHM=m
CONFIG_REGULATOR_RT4801=m
CONFIG_REGULATOR_RTMV20=y
# CONFIG_REGULATOR_S2MPA01 is not set
CONFIG_REGULATOR_S2MPS11=y
CONFIG_REGULATOR_S5M8767=m
# CONFIG_REGULATOR_SLG51000 is not set
CONFIG_REGULATOR_SY8106A=y
CONFIG_REGULATOR_SY8824X=m
# CONFIG_REGULATOR_SY8827N is not set
# CONFIG_REGULATOR_TPS51632 is not set
CONFIG_REGULATOR_TPS6105X=m
CONFIG_REGULATOR_TPS62360=y
# CONFIG_REGULATOR_TPS65023 is not set
CONFIG_REGULATOR_TPS6507X=m
# CONFIG_REGULATOR_TPS65132 is not set
CONFIG_REGULATOR_TPS65218=m
CONFIG_REGULATOR_TPS6586X=y
# CONFIG_REGULATOR_TPS65912 is not set
CONFIG_REGULATOR_TPS80031=m
# CONFIG_REGULATOR_TWL4030 is not set
# CONFIG_REGULATOR_VCTRL is not set
CONFIG_REGULATOR_WM8350=m
CONFIG_RC_CORE=m
CONFIG_RC_MAP=m
# CONFIG_LIRC is not set
CONFIG_RC_DECODERS=y
# CONFIG_IR_NEC_DECODER is not set
# CONFIG_IR_RC5_DECODER is not set
CONFIG_IR_RC6_DECODER=m
# CONFIG_IR_JVC_DECODER is not set
# CONFIG_IR_SONY_DECODER is not set
CONFIG_IR_SANYO_DECODER=m
CONFIG_IR_SHARP_DECODER=m
CONFIG_IR_MCE_KBD_DECODER=m
CONFIG_IR_XMP_DECODER=m
CONFIG_IR_IMON_DECODER=m
CONFIG_IR_RCMM_DECODER=m
# CONFIG_RC_DEVICES is not set
CONFIG_CEC_CORE=y
CONFIG_CEC_NOTIFIER=y
# CONFIG_MEDIA_CEC_SUPPORT is not set
CONFIG_MEDIA_SUPPORT=y
CONFIG_MEDIA_SUPPORT_FILTER=y
CONFIG_MEDIA_SUBDRV_AUTOSELECT=y

#
# Media device types
#
# CONFIG_MEDIA_CAMERA_SUPPORT is not set
CONFIG_MEDIA_ANALOG_TV_SUPPORT=y
CONFIG_MEDIA_DIGITAL_TV_SUPPORT=y
# CONFIG_MEDIA_RADIO_SUPPORT is not set
CONFIG_MEDIA_SDR_SUPPORT=y
# CONFIG_MEDIA_PLATFORM_SUPPORT is not set
CONFIG_MEDIA_TEST_SUPPORT=y
# end of Media device types

CONFIG_VIDEO_DEV=y
CONFIG_MEDIA_CONTROLLER=y
CONFIG_DVB_CORE=y

#
# Video4Linux options
#
CONFIG_VIDEO_V4L2=y
CONFIG_VIDEO_V4L2_I2C=y
CONFIG_VIDEO_V4L2_SUBDEV_API=y
# CONFIG_VIDEO_ADV_DEBUG is not set
# CONFIG_VIDEO_FIXED_MINOR_RANGES is not set
CONFIG_V4L2_MEM2MEM_DEV=y
CONFIG_V4L2_FLASH_LED_CLASS=m
CONFIG_V4L2_FWNODE=y
# end of Video4Linux options

#
# Media controller options
#
# CONFIG_MEDIA_CONTROLLER_DVB is not set
CONFIG_MEDIA_CONTROLLER_REQUEST_API=y

#
# Please notice that the enabled Media controller Request API is EXPERIMENTAL
#
# end of Media controller options

#
# Digital TV options
#
# CONFIG_DVB_MMAP is not set
CONFIG_DVB_NET=y
CONFIG_DVB_MAX_ADAPTERS=16
# CONFIG_DVB_DYNAMIC_MINORS is not set
# CONFIG_DVB_DEMUX_SECTION_LOSS_LOG is not set
CONFIG_DVB_ULE_DEBUG=y
# end of Digital TV options

#
# Media drivers
#

#
# Drivers filtered as selected at 'Filter media drivers'
#
# CONFIG_MEDIA_USB_SUPPORT is not set
# CONFIG_MEDIA_PCI_SUPPORT is not set
CONFIG_VIDEOBUF2_CORE=y
CONFIG_VIDEOBUF2_V4L2=y
CONFIG_VIDEOBUF2_MEMOPS=y
CONFIG_VIDEOBUF2_DMA_CONTIG=m
CONFIG_VIDEOBUF2_VMALLOC=y
CONFIG_VIDEO_V4L2_TPG=y
CONFIG_V4L_TEST_DRIVERS=y
CONFIG_VIDEO_VIMC=y
CONFIG_VIDEO_VIVID=m
CONFIG_VIDEO_VIVID_CEC=y
CONFIG_VIDEO_VIVID_MAX_DEVS=64
CONFIG_VIDEO_VIM2M=y
CONFIG_VIDEO_VICODEC=m
# CONFIG_DVB_TEST_DRIVERS is not set
# end of Media drivers

#
# Media ancillary drivers
#
CONFIG_MEDIA_ATTACH=y

#
# IR I2C driver auto-selected by 'Autoselect ancillary drivers'
#
# CONFIG_VIDEO_IR_I2C is not set

#
# Audio decoders, processors and mixers
#
CONFIG_VIDEO_TVAUDIO=y
# CONFIG_VIDEO_TDA7432 is not set
# CONFIG_VIDEO_TDA9840 is not set
CONFIG_VIDEO_TEA6415C=y
CONFIG_VIDEO_TEA6420=y
CONFIG_VIDEO_MSP3400=y
# CONFIG_VIDEO_CS3308 is not set
# CONFIG_VIDEO_CS5345 is not set
# CONFIG_VIDEO_CS53L32A is not set
CONFIG_VIDEO_TLV320AIC23B=y
CONFIG_VIDEO_UDA1342=y
# CONFIG_VIDEO_WM8775 is not set
CONFIG_VIDEO_WM8739=y
CONFIG_VIDEO_VP27SMPX=m
CONFIG_VIDEO_SONY_BTF_MPX=m
# end of Audio decoders, processors and mixers

#
# RDS decoders
#
CONFIG_VIDEO_SAA6588=y
# end of RDS decoders

#
# Video decoders
#
CONFIG_VIDEO_ADV7180=m
CONFIG_VIDEO_ADV7183=m
CONFIG_VIDEO_ADV748X=y
CONFIG_VIDEO_ADV7604=y
# CONFIG_VIDEO_ADV7604_CEC is not set
# CONFIG_VIDEO_ADV7842 is not set
CONFIG_VIDEO_BT819=y
# CONFIG_VIDEO_BT856 is not set
CONFIG_VIDEO_BT866=m
CONFIG_VIDEO_KS0127=y
CONFIG_VIDEO_ML86V7667=y
CONFIG_VIDEO_SAA7110=m
# CONFIG_VIDEO_SAA711X is not set
# CONFIG_VIDEO_TC358743 is not set
# CONFIG_VIDEO_TVP514X is not set
# CONFIG_VIDEO_TVP5150 is not set
# CONFIG_VIDEO_TVP7002 is not set
CONFIG_VIDEO_TW2804=y
# CONFIG_VIDEO_TW9903 is not set
# CONFIG_VIDEO_TW9906 is not set
CONFIG_VIDEO_TW9910=m
CONFIG_VIDEO_VPX3220=y
CONFIG_VIDEO_MAX9286=y

#
# Video and audio decoders
#
# CONFIG_VIDEO_SAA717X is not set
CONFIG_VIDEO_CX25840=y
# end of Video decoders

#
# Video encoders
#
CONFIG_VIDEO_SAA7127=m
CONFIG_VIDEO_SAA7185=y
# CONFIG_VIDEO_ADV7170 is not set
CONFIG_VIDEO_ADV7175=y
# CONFIG_VIDEO_ADV7343 is not set
# CONFIG_VIDEO_ADV7393 is not set
# CONFIG_VIDEO_AD9389B is not set
CONFIG_VIDEO_AK881X=m
# CONFIG_VIDEO_THS8200 is not set
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
CONFIG_SDR_MAX2175=m
# end of SDR tuner chips

#
# Miscellaneous helper chips
#
CONFIG_VIDEO_THS7303=y
# CONFIG_VIDEO_M52790 is not set
CONFIG_VIDEO_I2C=m
CONFIG_VIDEO_ST_MIPID02=y
# end of Miscellaneous helper chips

#
# SPI helper chips
#
# end of SPI helper chips

CONFIG_MEDIA_TUNER=y

#
# Customize TV tuners
#
CONFIG_MEDIA_TUNER_SIMPLE=y
CONFIG_MEDIA_TUNER_TDA18250=m
CONFIG_MEDIA_TUNER_TDA8290=y
CONFIG_MEDIA_TUNER_TDA827X=y
CONFIG_MEDIA_TUNER_TDA18271=y
CONFIG_MEDIA_TUNER_TDA9887=y
CONFIG_MEDIA_TUNER_TEA5761=y
CONFIG_MEDIA_TUNER_TEA5767=y
CONFIG_MEDIA_TUNER_MT20XX=y
# CONFIG_MEDIA_TUNER_MT2060 is not set
CONFIG_MEDIA_TUNER_MT2063=m
CONFIG_MEDIA_TUNER_MT2266=m
CONFIG_MEDIA_TUNER_MT2131=m
# CONFIG_MEDIA_TUNER_QT1010 is not set
CONFIG_MEDIA_TUNER_XC2028=y
CONFIG_MEDIA_TUNER_XC5000=y
CONFIG_MEDIA_TUNER_XC4000=y
CONFIG_MEDIA_TUNER_MXL5005S=m
CONFIG_MEDIA_TUNER_MXL5007T=m
CONFIG_MEDIA_TUNER_MC44S803=y
CONFIG_MEDIA_TUNER_MAX2165=m
# CONFIG_MEDIA_TUNER_TDA18218 is not set
CONFIG_MEDIA_TUNER_FC0011=m
# CONFIG_MEDIA_TUNER_FC0012 is not set
CONFIG_MEDIA_TUNER_FC0013=m
CONFIG_MEDIA_TUNER_TDA18212=y
CONFIG_MEDIA_TUNER_E4000=m
# CONFIG_MEDIA_TUNER_FC2580 is not set
CONFIG_MEDIA_TUNER_M88RS6000T=m
CONFIG_MEDIA_TUNER_TUA9001=m
CONFIG_MEDIA_TUNER_SI2157=y
CONFIG_MEDIA_TUNER_IT913X=y
CONFIG_MEDIA_TUNER_R820T=y
# CONFIG_MEDIA_TUNER_MXL301RF is not set
# CONFIG_MEDIA_TUNER_QM1D1C0042 is not set
# CONFIG_MEDIA_TUNER_QM1D1B0004 is not set
# end of Customize TV tuners

#
# Customise DVB Frontends
#

#
# Multistandard (satellite) frontends
#
CONFIG_DVB_STB0899=y
CONFIG_DVB_STB6100=y
CONFIG_DVB_STV090x=m
# CONFIG_DVB_STV0910 is not set
CONFIG_DVB_STV6110x=m
CONFIG_DVB_STV6111=y
CONFIG_DVB_MXL5XX=y
CONFIG_DVB_M88DS3103=m

#
# Multistandard (cable + terrestrial) frontends
#
CONFIG_DVB_DRXK=m
CONFIG_DVB_TDA18271C2DD=m
CONFIG_DVB_SI2165=y
CONFIG_DVB_MN88472=y
# CONFIG_DVB_MN88473 is not set

#
# DVB-S (satellite) frontends
#
CONFIG_DVB_CX24110=m
# CONFIG_DVB_CX24123 is not set
CONFIG_DVB_MT312=m
CONFIG_DVB_ZL10036=y
CONFIG_DVB_ZL10039=y
CONFIG_DVB_S5H1420=y
CONFIG_DVB_STV0288=y
CONFIG_DVB_STB6000=y
CONFIG_DVB_STV0299=y
CONFIG_DVB_STV6110=m
# CONFIG_DVB_STV0900 is not set
CONFIG_DVB_TDA8083=m
CONFIG_DVB_TDA10086=m
CONFIG_DVB_TDA8261=y
CONFIG_DVB_VES1X93=m
# CONFIG_DVB_TUNER_ITD1000 is not set
# CONFIG_DVB_TUNER_CX24113 is not set
# CONFIG_DVB_TDA826X is not set
# CONFIG_DVB_TUA6100 is not set
# CONFIG_DVB_CX24116 is not set
CONFIG_DVB_CX24117=m
# CONFIG_DVB_CX24120 is not set
CONFIG_DVB_SI21XX=m
CONFIG_DVB_TS2020=m
CONFIG_DVB_DS3000=y
# CONFIG_DVB_MB86A16 is not set
CONFIG_DVB_TDA10071=m

#
# DVB-T (terrestrial) frontends
#
# CONFIG_DVB_SP8870 is not set
CONFIG_DVB_SP887X=m
CONFIG_DVB_CX22700=y
# CONFIG_DVB_CX22702 is not set
CONFIG_DVB_S5H1432=y
CONFIG_DVB_DRXD=y
CONFIG_DVB_L64781=y
CONFIG_DVB_TDA1004X=m
# CONFIG_DVB_NXT6000 is not set
CONFIG_DVB_MT352=m
CONFIG_DVB_ZL10353=y
CONFIG_DVB_DIB3000MB=y
CONFIG_DVB_DIB3000MC=m
CONFIG_DVB_DIB7000M=y
# CONFIG_DVB_DIB7000P is not set
CONFIG_DVB_DIB9000=m
CONFIG_DVB_TDA10048=m
CONFIG_DVB_AF9013=y
# CONFIG_DVB_EC100 is not set
# CONFIG_DVB_STV0367 is not set
# CONFIG_DVB_CXD2820R is not set
CONFIG_DVB_CXD2841ER=y
CONFIG_DVB_RTL2830=y
CONFIG_DVB_RTL2832=y
CONFIG_DVB_RTL2832_SDR=m
# CONFIG_DVB_SI2168 is not set
CONFIG_DVB_ZD1301_DEMOD=m

#
# DVB-C (cable) frontends
#
# CONFIG_DVB_VES1820 is not set
# CONFIG_DVB_TDA10021 is not set
CONFIG_DVB_TDA10023=m
CONFIG_DVB_STV0297=y

#
# ATSC (North American/Korean Terrestrial/Cable DTV) frontends
#
CONFIG_DVB_NXT200X=y
CONFIG_DVB_OR51211=y
CONFIG_DVB_OR51132=y
CONFIG_DVB_BCM3510=y
# CONFIG_DVB_LGDT330X is not set
CONFIG_DVB_LGDT3305=m
# CONFIG_DVB_LGDT3306A is not set
CONFIG_DVB_LG2160=m
# CONFIG_DVB_S5H1409 is not set
CONFIG_DVB_AU8522=y
CONFIG_DVB_AU8522_DTV=y
CONFIG_DVB_AU8522_V4L=m
CONFIG_DVB_S5H1411=y

#
# ISDB-T (terrestrial) frontends
#
# CONFIG_DVB_S921 is not set
CONFIG_DVB_DIB8000=m
CONFIG_DVB_MB86A20S=y

#
# ISDB-S (satellite) & ISDB-T (terrestrial) frontends
#
CONFIG_DVB_TC90522=y
CONFIG_DVB_MN88443X=m

#
# Digital terrestrial only tuners/PLL
#
CONFIG_DVB_PLL=y
CONFIG_DVB_TUNER_DIB0070=y
# CONFIG_DVB_TUNER_DIB0090 is not set

#
# SEC control devices for DVB-S
#
# CONFIG_DVB_DRX39XYJ is not set
CONFIG_DVB_LNBH25=y
# CONFIG_DVB_LNBH29 is not set
# CONFIG_DVB_LNBP21 is not set
CONFIG_DVB_LNBP22=y
CONFIG_DVB_ISL6405=m
CONFIG_DVB_ISL6421=y
# CONFIG_DVB_ISL6423 is not set
CONFIG_DVB_A8293=y
CONFIG_DVB_LGS8GL5=m
CONFIG_DVB_LGS8GXX=m
CONFIG_DVB_ATBM8830=m
CONFIG_DVB_TDA665x=y
CONFIG_DVB_IX2505V=m
# CONFIG_DVB_M88RS2000 is not set
CONFIG_DVB_AF9033=m
CONFIG_DVB_HORUS3A=y
# CONFIG_DVB_ASCOT2E is not set
# CONFIG_DVB_HELENE is not set

#
# Common Interface (EN50221) controller drivers
#
# CONFIG_DVB_CXD2099 is not set
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
CONFIG_DRM_MIPI_DSI=y
# CONFIG_DRM_DP_AUX_CHARDEV is not set
# CONFIG_DRM_DEBUG_MM is not set
# CONFIG_DRM_DEBUG_SELFTEST is not set
CONFIG_DRM_KMS_HELPER=y
CONFIG_DRM_KMS_FB_HELPER=y
# CONFIG_DRM_DEBUG_DP_MST_TOPOLOGY_REFS is not set
# CONFIG_DRM_FBDEV_EMULATION is not set
CONFIG_DRM_LOAD_EDID_FIRMWARE=y
# CONFIG_DRM_DP_CEC is not set
CONFIG_DRM_GEM_CMA_HELPER=y
CONFIG_DRM_KMS_CMA_HELPER=y
CONFIG_DRM_GEM_SHMEM_HELPER=y
CONFIG_DRM_VM=y

#
# I2C encoder or helper chips
#
# CONFIG_DRM_I2C_CH7006 is not set
CONFIG_DRM_I2C_SIL164=y
# CONFIG_DRM_I2C_NXP_TDA998X is not set
# CONFIG_DRM_I2C_NXP_TDA9950 is not set
# end of I2C encoder or helper chips

#
# ARM devices
#
CONFIG_DRM_KOMEDA=y
# end of ARM devices

# CONFIG_DRM_RADEON is not set
# CONFIG_DRM_AMDGPU is not set
# CONFIG_DRM_NOUVEAU is not set
# CONFIG_DRM_I915 is not set
CONFIG_DRM_VGEM=m
CONFIG_DRM_VKMS=y
# CONFIG_DRM_VMWGFX is not set
# CONFIG_DRM_GMA500 is not set
CONFIG_DRM_UDL=y
# CONFIG_DRM_AST is not set
# CONFIG_DRM_MGAG200 is not set
CONFIG_DRM_RCAR_DW_HDMI=y
CONFIG_DRM_RCAR_LVDS=y
# CONFIG_DRM_QXL is not set
# CONFIG_DRM_BOCHS is not set
CONFIG_DRM_VIRTIO_GPU=y
CONFIG_DRM_PANEL=y

#
# Display Panels
#
CONFIG_DRM_PANEL_ARM_VERSATILE=m
# CONFIG_DRM_PANEL_ASUS_Z00T_TM5P5_NT35596 is not set
CONFIG_DRM_PANEL_BOE_HIMAX8279D=m
# CONFIG_DRM_PANEL_BOE_TV101WUM_NL6 is not set
CONFIG_DRM_PANEL_LVDS=m
CONFIG_DRM_PANEL_SIMPLE=m
CONFIG_DRM_PANEL_ELIDA_KD35T133=m
CONFIG_DRM_PANEL_FEIXIN_K101_IM2BA02=m
# CONFIG_DRM_PANEL_FEIYANG_FY07024DI26A30D is not set
CONFIG_DRM_PANEL_ILITEK_ILI9881C=m
CONFIG_DRM_PANEL_INNOLUX_P079ZCA=m
CONFIG_DRM_PANEL_JDI_LT070ME05000=m
CONFIG_DRM_PANEL_KINGDISPLAY_KD097D04=m
CONFIG_DRM_PANEL_LEADTEK_LTK050H3146W=m
CONFIG_DRM_PANEL_LEADTEK_LTK500HD1829=m
# CONFIG_DRM_PANEL_NOVATEK_NT35510 is not set
# CONFIG_DRM_PANEL_NOVATEK_NT36672A is not set
# CONFIG_DRM_PANEL_MANTIX_MLAF057WE51 is not set
CONFIG_DRM_PANEL_OLIMEX_LCD_OLINUXINO=m
CONFIG_DRM_PANEL_ORISETECH_OTM8009A=m
# CONFIG_DRM_PANEL_OSD_OSD101T2587_53TS is not set
# CONFIG_DRM_PANEL_PANASONIC_VVX10F034N00 is not set
CONFIG_DRM_PANEL_RASPBERRYPI_TOUCHSCREEN=y
CONFIG_DRM_PANEL_RAYDIUM_RM67191=m
CONFIG_DRM_PANEL_RAYDIUM_RM68200=m
CONFIG_DRM_PANEL_RONBO_RB070D30=m
# CONFIG_DRM_PANEL_SAMSUNG_S6D16D0 is not set
CONFIG_DRM_PANEL_SAMSUNG_S6E3HA2=m
# CONFIG_DRM_PANEL_SAMSUNG_S6E63J0X03 is not set
CONFIG_DRM_PANEL_SAMSUNG_S6E63M0=m
CONFIG_DRM_PANEL_SAMSUNG_S6E63M0_DSI=m
# CONFIG_DRM_PANEL_SAMSUNG_S6E88A0_AMS452EF01 is not set
CONFIG_DRM_PANEL_SAMSUNG_S6E8AA0=m
# CONFIG_DRM_PANEL_SAMSUNG_SOFEF00 is not set
# CONFIG_DRM_PANEL_SEIKO_43WVF1G is not set
# CONFIG_DRM_PANEL_SHARP_LQ101R1SX01 is not set
CONFIG_DRM_PANEL_SHARP_LS037V7DW01=y
CONFIG_DRM_PANEL_SHARP_LS043T1LE01=m
# CONFIG_DRM_PANEL_SITRONIX_ST7701 is not set
CONFIG_DRM_PANEL_SITRONIX_ST7703=m
CONFIG_DRM_PANEL_SONY_ACX424AKP=m
CONFIG_DRM_PANEL_TDO_TL070WSH30=m
# CONFIG_DRM_PANEL_TRULY_NT35597_WQXGA is not set
# CONFIG_DRM_PANEL_VISIONOX_RM69299 is not set
CONFIG_DRM_PANEL_XINPENG_XPP055C272=m
# end of Display Panels

CONFIG_DRM_BRIDGE=y
CONFIG_DRM_PANEL_BRIDGE=y

#
# Display Interface Bridges
#
CONFIG_DRM_CDNS_DSI=m
CONFIG_DRM_CHRONTEL_CH7033=y
CONFIG_DRM_DISPLAY_CONNECTOR=m
# CONFIG_DRM_LONTIUM_LT9611 is not set
# CONFIG_DRM_LONTIUM_LT9611UXC is not set
# CONFIG_DRM_LVDS_CODEC is not set
# CONFIG_DRM_MEGACHIPS_STDPXXXX_GE_B850V3_FW is not set
CONFIG_DRM_NWL_MIPI_DSI=m
CONFIG_DRM_NXP_PTN3460=y
CONFIG_DRM_PARADE_PS8622=m
# CONFIG_DRM_PARADE_PS8640 is not set
CONFIG_DRM_SIL_SII8620=m
CONFIG_DRM_SII902X=y
CONFIG_DRM_SII9234=y
# CONFIG_DRM_SIMPLE_BRIDGE is not set
# CONFIG_DRM_THINE_THC63LVD1024 is not set
# CONFIG_DRM_TOSHIBA_TC358762 is not set
CONFIG_DRM_TOSHIBA_TC358764=m
CONFIG_DRM_TOSHIBA_TC358767=m
CONFIG_DRM_TOSHIBA_TC358768=y
CONFIG_DRM_TOSHIBA_TC358775=m
CONFIG_DRM_TI_TFP410=y
# CONFIG_DRM_TI_SN65DSI86 is not set
CONFIG_DRM_TI_TPD12S015=y
CONFIG_DRM_ANALOGIX_ANX6345=y
# CONFIG_DRM_ANALOGIX_ANX78XX is not set
CONFIG_DRM_ANALOGIX_DP=y
CONFIG_DRM_ANALOGIX_ANX7625=y
CONFIG_DRM_I2C_ADV7511=m
CONFIG_DRM_I2C_ADV7511_CEC=y
CONFIG_DRM_CDNS_MHDP8546=y
CONFIG_DRM_DW_HDMI=y
CONFIG_DRM_DW_HDMI_CEC=y
# end of Display Interface Bridges

# CONFIG_DRM_ETNAVIV is not set
CONFIG_DRM_ARCPGU=m
CONFIG_DRM_MXS=y
CONFIG_DRM_MXSFB=y
# CONFIG_DRM_CIRRUS_QEMU is not set
# CONFIG_DRM_GM12U320 is not set
# CONFIG_DRM_VBOXVIDEO is not set
CONFIG_DRM_LEGACY=y
# CONFIG_DRM_TDFX is not set
# CONFIG_DRM_R128 is not set
# CONFIG_DRM_MGA is not set
# CONFIG_DRM_VIA is not set
# CONFIG_DRM_SAVAGE is not set
CONFIG_DRM_PANEL_ORIENTATION_QUIRKS=y

#
# Frame buffer Devices
#
CONFIG_FB_CMDLINE=y
CONFIG_FB_NOTIFY=y
CONFIG_FB=y
CONFIG_FIRMWARE_EDID=y
CONFIG_FB_BOOT_VESA_SUPPORT=y
CONFIG_FB_CFB_FILLRECT=y
CONFIG_FB_CFB_COPYAREA=y
CONFIG_FB_CFB_IMAGEBLIT=y
CONFIG_FB_SYS_FILLRECT=y
CONFIG_FB_SYS_COPYAREA=y
CONFIG_FB_SYS_IMAGEBLIT=y
CONFIG_FB_FOREIGN_ENDIAN=y
# CONFIG_FB_BOTH_ENDIAN is not set
# CONFIG_FB_BIG_ENDIAN is not set
CONFIG_FB_LITTLE_ENDIAN=y
CONFIG_FB_SYS_FOPS=y
CONFIG_FB_DEFERRED_IO=y
CONFIG_FB_HECUBA=y
CONFIG_FB_MODE_HELPERS=y
# CONFIG_FB_TILEBLITTING is not set

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
CONFIG_FB_VESA=y
CONFIG_FB_N411=y
CONFIG_FB_HGA=m
CONFIG_FB_OPENCORES=y
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
# CONFIG_FB_GEODE is not set
CONFIG_FB_SMSCUFX=m
# CONFIG_FB_UDL is not set
CONFIG_FB_IBM_GXT4500=m
# CONFIG_FB_GOLDFISH is not set
# CONFIG_FB_VIRTUAL is not set
CONFIG_FB_METRONOME=m
# CONFIG_FB_MB862XX is not set
CONFIG_FB_SIMPLE=y
# CONFIG_FB_SSD1307 is not set
# CONFIG_FB_SM712 is not set
# end of Frame buffer Devices

#
# Backlight & LCD device support
#
# CONFIG_LCD_CLASS_DEVICE is not set
CONFIG_BACKLIGHT_CLASS_DEVICE=m
CONFIG_BACKLIGHT_KTD253=m
CONFIG_BACKLIGHT_PWM=m
CONFIG_BACKLIGHT_MAX8925=m
CONFIG_BACKLIGHT_APPLE=m
CONFIG_BACKLIGHT_QCOM_WLED=m
CONFIG_BACKLIGHT_SAHARA=m
# CONFIG_BACKLIGHT_ADP5520 is not set
CONFIG_BACKLIGHT_ADP8860=m
# CONFIG_BACKLIGHT_ADP8870 is not set
CONFIG_BACKLIGHT_88PM860X=m
# CONFIG_BACKLIGHT_PCF50633 is not set
# CONFIG_BACKLIGHT_AAT2870 is not set
# CONFIG_BACKLIGHT_LM3630A is not set
CONFIG_BACKLIGHT_LM3639=m
CONFIG_BACKLIGHT_LP855X=m
# CONFIG_BACKLIGHT_LP8788 is not set
# CONFIG_BACKLIGHT_PANDORA is not set
# CONFIG_BACKLIGHT_GPIO is not set
# CONFIG_BACKLIGHT_LV5207LP is not set
# CONFIG_BACKLIGHT_BD6107 is not set
CONFIG_BACKLIGHT_ARCXCNN=m
CONFIG_BACKLIGHT_RAVE_SP=m
CONFIG_BACKLIGHT_LED=m
# end of Backlight & LCD device support

CONFIG_VIDEOMODE_HELPERS=y
CONFIG_HDMI=y
CONFIG_LOGO=y
CONFIG_LOGO_LINUX_MONO=y
# CONFIG_LOGO_LINUX_VGA16 is not set
# CONFIG_LOGO_LINUX_CLUT224 is not set
# end of Graphics support

# CONFIG_SOUND is not set

#
# HID support
#
# CONFIG_HID is not set

#
# USB HID support
#
# CONFIG_USB_HID is not set
CONFIG_HID_PID=y

#
# USB HID Boot Protocol drivers
#
CONFIG_USB_KBD=m
# CONFIG_USB_MOUSE is not set
# end of USB HID Boot Protocol drivers
# end of USB HID support

#
# I2C HID support
#
# CONFIG_I2C_HID is not set
# end of I2C HID support
# end of HID support

CONFIG_USB_OHCI_LITTLE_ENDIAN=y
CONFIG_USB_SUPPORT=y
CONFIG_USB_COMMON=y
CONFIG_USB_LED_TRIG=y
CONFIG_USB_ULPI_BUS=m
# CONFIG_USB_CONN_GPIO is not set
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB=y
CONFIG_USB_PCI=y
# CONFIG_USB_ANNOUNCE_NEW_DEVICES is not set

#
# Miscellaneous USB options
#
# CONFIG_USB_DEFAULT_PERSIST is not set
CONFIG_USB_FEW_INIT_RETRIES=y
# CONFIG_USB_DYNAMIC_MINORS is not set
CONFIG_USB_OTG=y
# CONFIG_USB_OTG_PRODUCTLIST is not set
CONFIG_USB_OTG_DISABLE_EXTERNAL_HUB=y
CONFIG_USB_OTG_FSM=m
CONFIG_USB_LEDS_TRIGGER_USBPORT=y
CONFIG_USB_AUTOSUSPEND_DELAY=2
CONFIG_USB_MON=y

#
# USB Host Controller Drivers
#
# CONFIG_USB_C67X00_HCD is not set
# CONFIG_USB_XHCI_HCD is not set
# CONFIG_USB_EHCI_HCD is not set
CONFIG_USB_OXU210HP_HCD=m
CONFIG_USB_ISP116X_HCD=y
CONFIG_USB_FOTG210_HCD=m
CONFIG_USB_OHCI_HCD=y
CONFIG_USB_OHCI_HCD_PCI=y
CONFIG_USB_OHCI_HCD_PLATFORM=y
# CONFIG_USB_UHCI_HCD is not set
CONFIG_USB_U132_HCD=m
# CONFIG_USB_SL811_HCD is not set
# CONFIG_USB_R8A66597_HCD is not set
CONFIG_USB_HCD_BCMA=y
# CONFIG_USB_HCD_TEST_MODE is not set

#
# USB Device Class drivers
#
# CONFIG_USB_ACM is not set
# CONFIG_USB_PRINTER is not set
CONFIG_USB_WDM=y
CONFIG_USB_TMC=m

#
# NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
#

#
# also be needed; see USB_STORAGE Help for more info
#
# CONFIG_USB_STORAGE is not set

#
# USB Imaging devices
#
# CONFIG_USB_MDC800 is not set
CONFIG_USB_MICROTEK=m
# CONFIG_USBIP_CORE is not set
# CONFIG_USB_CDNS3 is not set
# CONFIG_USB_MUSB_HDRC is not set
# CONFIG_USB_DWC3 is not set
CONFIG_USB_DWC2=m
# CONFIG_USB_DWC2_HOST is not set

#
# Gadget/Dual-role mode requires USB Gadget support to be enabled
#
# CONFIG_USB_DWC2_PERIPHERAL is not set
CONFIG_USB_DWC2_DUAL_ROLE=y
# CONFIG_USB_DWC2_PCI is not set
# CONFIG_USB_DWC2_DEBUG is not set
CONFIG_USB_DWC2_TRACK_MISSED_SOFS=y
CONFIG_USB_CHIPIDEA=m
# CONFIG_USB_CHIPIDEA_UDC is not set
CONFIG_USB_CHIPIDEA_PCI=m
# CONFIG_USB_CHIPIDEA_MSM is not set
# CONFIG_USB_CHIPIDEA_IMX is not set
CONFIG_USB_CHIPIDEA_GENERIC=m
CONFIG_USB_ISP1760=m
CONFIG_USB_ISP1761_UDC=y
# CONFIG_USB_ISP1760_HOST_ROLE is not set
CONFIG_USB_ISP1760_GADGET_ROLE=y
# CONFIG_USB_ISP1760_DUAL_ROLE is not set

#
# USB port drivers
#
CONFIG_USB_USS720=m
CONFIG_USB_SERIAL=m
# CONFIG_USB_SERIAL_GENERIC is not set
CONFIG_USB_SERIAL_SIMPLE=m
# CONFIG_USB_SERIAL_AIRCABLE is not set
# CONFIG_USB_SERIAL_ARK3116 is not set
CONFIG_USB_SERIAL_BELKIN=m
CONFIG_USB_SERIAL_CH341=m
CONFIG_USB_SERIAL_WHITEHEAT=m
CONFIG_USB_SERIAL_DIGI_ACCELEPORT=m
CONFIG_USB_SERIAL_CP210X=m
CONFIG_USB_SERIAL_CYPRESS_M8=m
# CONFIG_USB_SERIAL_EMPEG is not set
CONFIG_USB_SERIAL_FTDI_SIO=m
CONFIG_USB_SERIAL_VISOR=m
# CONFIG_USB_SERIAL_IPAQ is not set
# CONFIG_USB_SERIAL_IR is not set
CONFIG_USB_SERIAL_EDGEPORT=m
CONFIG_USB_SERIAL_EDGEPORT_TI=m
CONFIG_USB_SERIAL_F81232=m
CONFIG_USB_SERIAL_F8153X=m
# CONFIG_USB_SERIAL_GARMIN is not set
CONFIG_USB_SERIAL_IPW=m
# CONFIG_USB_SERIAL_IUU is not set
# CONFIG_USB_SERIAL_KEYSPAN_PDA is not set
CONFIG_USB_SERIAL_KEYSPAN=m
# CONFIG_USB_SERIAL_KLSI is not set
# CONFIG_USB_SERIAL_KOBIL_SCT is not set
CONFIG_USB_SERIAL_MCT_U232=m
CONFIG_USB_SERIAL_METRO=m
CONFIG_USB_SERIAL_MOS7720=m
# CONFIG_USB_SERIAL_MOS7715_PARPORT is not set
# CONFIG_USB_SERIAL_MOS7840 is not set
CONFIG_USB_SERIAL_MXUPORT=m
CONFIG_USB_SERIAL_NAVMAN=m
# CONFIG_USB_SERIAL_PL2303 is not set
CONFIG_USB_SERIAL_OTI6858=m
CONFIG_USB_SERIAL_QCAUX=m
# CONFIG_USB_SERIAL_QUALCOMM is not set
# CONFIG_USB_SERIAL_SPCP8X5 is not set
# CONFIG_USB_SERIAL_SAFE is not set
CONFIG_USB_SERIAL_SIERRAWIRELESS=m
CONFIG_USB_SERIAL_SYMBOL=m
# CONFIG_USB_SERIAL_TI is not set
CONFIG_USB_SERIAL_CYBERJACK=m
CONFIG_USB_SERIAL_WWAN=m
CONFIG_USB_SERIAL_OPTION=m
CONFIG_USB_SERIAL_OMNINET=m
CONFIG_USB_SERIAL_OPTICON=m
CONFIG_USB_SERIAL_XSENS_MT=m
CONFIG_USB_SERIAL_WISHBONE=m
# CONFIG_USB_SERIAL_SSU100 is not set
# CONFIG_USB_SERIAL_QT2 is not set
# CONFIG_USB_SERIAL_UPD78F0730 is not set
CONFIG_USB_SERIAL_DEBUG=m

#
# USB Miscellaneous drivers
#
CONFIG_USB_EMI62=y
CONFIG_USB_EMI26=m
CONFIG_USB_ADUTUX=y
# CONFIG_USB_SEVSEG is not set
CONFIG_USB_LEGOTOWER=m
# CONFIG_USB_LCD is not set
CONFIG_USB_CYPRESS_CY7C63=y
CONFIG_USB_CYTHERM=y
# CONFIG_USB_IDMOUSE is not set
CONFIG_USB_FTDI_ELAN=y
CONFIG_USB_APPLEDISPLAY=m
CONFIG_APPLE_MFI_FASTCHARGE=y
CONFIG_USB_LD=y
CONFIG_USB_TRANCEVIBRATOR=m
# CONFIG_USB_IOWARRIOR is not set
CONFIG_USB_TEST=y
CONFIG_USB_EHSET_TEST_FIXTURE=y
CONFIG_USB_ISIGHTFW=y
# CONFIG_USB_YUREX is not set
CONFIG_USB_EZUSB_FX2=y
# CONFIG_USB_HUB_USB251XB is not set
CONFIG_USB_HSIC_USB3503=m
# CONFIG_USB_HSIC_USB4604 is not set
CONFIG_USB_LINK_LAYER_TEST=y

#
# USB Physical Layer drivers
#
CONFIG_USB_PHY=y
CONFIG_NOP_USB_XCEIV=m
CONFIG_USB_GPIO_VBUS=m
CONFIG_TAHVO_USB=m
# CONFIG_TAHVO_USB_HOST_BY_DEFAULT is not set
# CONFIG_USB_ISP1301 is not set
# end of USB Physical Layer drivers

CONFIG_USB_GADGET=m
# CONFIG_USB_GADGET_DEBUG is not set
CONFIG_USB_GADGET_DEBUG_FILES=y
# CONFIG_USB_GADGET_DEBUG_FS is not set
CONFIG_USB_GADGET_VBUS_DRAW=2
CONFIG_USB_GADGET_STORAGE_NUM_BUFFERS=2
CONFIG_U_SERIAL_CONSOLE=y

#
# USB Peripheral Controller
#
CONFIG_USB_FUSB300=m
CONFIG_USB_FOTG210_UDC=m
CONFIG_USB_GR_UDC=m
# CONFIG_USB_R8A66597 is not set
CONFIG_USB_PXA27X=m
CONFIG_USB_MV_UDC=m
CONFIG_USB_MV_U3D=m
# CONFIG_USB_SNP_UDC_PLAT is not set
CONFIG_USB_M66592=m
CONFIG_USB_BDC_UDC=m

#
# Platform Support
#
CONFIG_USB_BDC_PCI=m
# CONFIG_USB_AMD5536UDC is not set
# CONFIG_USB_NET2272 is not set
# CONFIG_USB_NET2280 is not set
# CONFIG_USB_GOKU is not set
# CONFIG_USB_EG20T is not set
CONFIG_USB_GADGET_XILINX=m
# CONFIG_USB_DUMMY_HCD is not set
# end of USB Peripheral Controller

CONFIG_USB_LIBCOMPOSITE=m
CONFIG_USB_F_ACM=m
CONFIG_USB_F_SS_LB=m
CONFIG_USB_U_SERIAL=m
CONFIG_USB_F_SERIAL=m
CONFIG_USB_F_OBEX=m
CONFIG_USB_F_MASS_STORAGE=m
CONFIG_USB_F_FS=m
CONFIG_USB_F_HID=m
CONFIG_USB_F_PRINTER=m
CONFIG_USB_F_TCM=m
CONFIG_USB_CONFIGFS=m
# CONFIG_USB_CONFIGFS_SERIAL is not set
CONFIG_USB_CONFIGFS_ACM=y
CONFIG_USB_CONFIGFS_OBEX=y
# CONFIG_USB_CONFIGFS_NCM is not set
# CONFIG_USB_CONFIGFS_ECM is not set
# CONFIG_USB_CONFIGFS_ECM_SUBSET is not set
# CONFIG_USB_CONFIGFS_RNDIS is not set
# CONFIG_USB_CONFIGFS_EEM is not set
CONFIG_USB_CONFIGFS_MASS_STORAGE=y
CONFIG_USB_CONFIGFS_F_LB_SS=y
# CONFIG_USB_CONFIGFS_F_FS is not set
# CONFIG_USB_CONFIGFS_F_HID is not set
# CONFIG_USB_CONFIGFS_F_UVC is not set
# CONFIG_USB_CONFIGFS_F_PRINTER is not set
# CONFIG_USB_CONFIGFS_F_TCM is not set

#
# USB Gadget precomposed configurations
#
# CONFIG_USB_ZERO is not set
# CONFIG_USB_ETH is not set
# CONFIG_USB_G_NCM is not set
# CONFIG_USB_GADGETFS is not set
CONFIG_USB_FUNCTIONFS=m
# CONFIG_USB_FUNCTIONFS_ETH is not set
# CONFIG_USB_FUNCTIONFS_RNDIS is not set
CONFIG_USB_FUNCTIONFS_GENERIC=y
CONFIG_USB_MASS_STORAGE=m
CONFIG_USB_GADGET_TARGET=m
CONFIG_USB_G_SERIAL=m
CONFIG_USB_G_PRINTER=m
# CONFIG_USB_CDC_COMPOSITE is not set
# CONFIG_USB_G_ACM_MS is not set
# CONFIG_USB_G_MULTI is not set
CONFIG_USB_G_HID=m
CONFIG_USB_G_DBGP=m
CONFIG_USB_G_DBGP_PRINTK=y
# CONFIG_USB_G_DBGP_SERIAL is not set
# CONFIG_USB_G_WEBCAM is not set
CONFIG_USB_RAW_GADGET=m
# end of USB Gadget precomposed configurations

# CONFIG_TYPEC is not set
CONFIG_USB_ROLE_SWITCH=y
CONFIG_USB_ROLES_INTEL_XHCI=y
CONFIG_MMC=y
# CONFIG_PWRSEQ_EMMC is not set
CONFIG_PWRSEQ_SIMPLE=m
CONFIG_MMC_BLOCK=y
CONFIG_MMC_BLOCK_MINORS=8
CONFIG_SDIO_UART=m
# CONFIG_MMC_TEST is not set

#
# MMC/SD/SDIO Host Controller Drivers
#
CONFIG_MMC_DEBUG=y
CONFIG_MMC_SDHCI=y
CONFIG_MMC_SDHCI_IO_ACCESSORS=y
# CONFIG_MMC_SDHCI_PCI is not set
# CONFIG_MMC_SDHCI_ACPI is not set
CONFIG_MMC_SDHCI_PLTFM=y
CONFIG_MMC_SDHCI_OF_ARASAN=y
# CONFIG_MMC_SDHCI_OF_ASPEED is not set
CONFIG_MMC_SDHCI_OF_AT91=y
CONFIG_MMC_SDHCI_OF_DWCMSHC=m
CONFIG_MMC_SDHCI_CADENCE=m
# CONFIG_MMC_SDHCI_F_SDH30 is not set
# CONFIG_MMC_SDHCI_MILBEAUT is not set
# CONFIG_MMC_WBSD is not set
# CONFIG_MMC_TIFM_SD is not set
CONFIG_MMC_GOLDFISH=m
# CONFIG_MMC_SDRICOH_CS is not set
# CONFIG_MMC_CB710 is not set
# CONFIG_MMC_VIA_SDMMC is not set
CONFIG_MMC_VUB300=m
# CONFIG_MMC_USHC is not set
# CONFIG_MMC_USDHI6ROL0 is not set
CONFIG_MMC_REALTEK_USB=y
CONFIG_MMC_CQHCI=y
CONFIG_MMC_HSQ=m
# CONFIG_MMC_TOSHIBA_PCI is not set
CONFIG_MMC_MTK=m
CONFIG_MMC_SDHCI_XENON=m
CONFIG_MMC_SDHCI_OMAP=m
CONFIG_MMC_SDHCI_AM654=y
CONFIG_MMC_SDHCI_EXTERNAL_DMA=y
CONFIG_MEMSTICK=y
CONFIG_MEMSTICK_DEBUG=y

#
# MemoryStick drivers
#
CONFIG_MEMSTICK_UNSAFE_RESUME=y
CONFIG_MSPRO_BLOCK=y
CONFIG_MS_BLOCK=y

#
# MemoryStick Host Controller Drivers
#
# CONFIG_MEMSTICK_TIFM_MS is not set
# CONFIG_MEMSTICK_JMICRON_38X is not set
# CONFIG_MEMSTICK_R592 is not set
# CONFIG_MEMSTICK_REALTEK_USB is not set
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=m
CONFIG_LEDS_CLASS_FLASH=m
# CONFIG_LEDS_CLASS_MULTICOLOR is not set
CONFIG_LEDS_BRIGHTNESS_HW_CHANGED=y

#
# LED drivers
#
CONFIG_LEDS_88PM860X=m
CONFIG_LEDS_AAT1290=m
# CONFIG_LEDS_AN30259A is not set
CONFIG_LEDS_APU=m
CONFIG_LEDS_AS3645A=m
# CONFIG_LEDS_AW2013 is not set
# CONFIG_LEDS_BCM6328 is not set
CONFIG_LEDS_BCM6358=m
CONFIG_LEDS_LM3530=m
# CONFIG_LEDS_LM3532 is not set
# CONFIG_LEDS_LM3642 is not set
CONFIG_LEDS_LM3692X=m
CONFIG_LEDS_LM3601X=m
# CONFIG_LEDS_MT6323 is not set
CONFIG_LEDS_PCA9532=m
# CONFIG_LEDS_PCA9532_GPIO is not set
CONFIG_LEDS_GPIO=m
CONFIG_LEDS_LP3944=m
# CONFIG_LEDS_LP3952 is not set
CONFIG_LEDS_LP50XX=m
# CONFIG_LEDS_LP55XX_COMMON is not set
CONFIG_LEDS_LP8788=m
CONFIG_LEDS_LP8860=m
CONFIG_LEDS_CLEVO_MAIL=m
CONFIG_LEDS_PCA955X=m
CONFIG_LEDS_PCA955X_GPIO=y
CONFIG_LEDS_PCA963X=m
CONFIG_LEDS_WM8350=m
CONFIG_LEDS_PWM=m
CONFIG_LEDS_REGULATOR=m
# CONFIG_LEDS_BD2802 is not set
# CONFIG_LEDS_INTEL_SS4200 is not set
# CONFIG_LEDS_LT3593 is not set
CONFIG_LEDS_ADP5520=m
CONFIG_LEDS_MC13783=m
CONFIG_LEDS_TCA6507=m
CONFIG_LEDS_TLC591XX=m
CONFIG_LEDS_MAX77650=m
# CONFIG_LEDS_MAX8997 is not set
CONFIG_LEDS_LM355x=m
CONFIG_LEDS_OT200=m
# CONFIG_LEDS_MENF21BMC is not set
# CONFIG_LEDS_KTD2692 is not set
# CONFIG_LEDS_IS31FL319X is not set
# CONFIG_LEDS_IS31FL32XX is not set

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
#
# CONFIG_LEDS_BLINKM is not set
CONFIG_LEDS_MLXCPLD=m
CONFIG_LEDS_MLXREG=m
CONFIG_LEDS_USER=m
# CONFIG_LEDS_NIC78BX is not set
CONFIG_LEDS_TI_LMU_COMMON=m
CONFIG_LEDS_LM3697=m
CONFIG_LEDS_TPS6105X=m
CONFIG_LEDS_SGM3140=m

#
# LED Triggers
#
CONFIG_LEDS_TRIGGERS=y
CONFIG_LEDS_TRIGGER_TIMER=m
# CONFIG_LEDS_TRIGGER_ONESHOT is not set
CONFIG_LEDS_TRIGGER_DISK=y
CONFIG_LEDS_TRIGGER_HEARTBEAT=m
CONFIG_LEDS_TRIGGER_BACKLIGHT=m
CONFIG_LEDS_TRIGGER_CPU=y
# CONFIG_LEDS_TRIGGER_ACTIVITY is not set
# CONFIG_LEDS_TRIGGER_GPIO is not set
CONFIG_LEDS_TRIGGER_DEFAULT_ON=m

#
# iptables trigger is under Netfilter config (LED target)
#
CONFIG_LEDS_TRIGGER_TRANSIENT=m
CONFIG_LEDS_TRIGGER_CAMERA=y
CONFIG_LEDS_TRIGGER_PANIC=y
# CONFIG_LEDS_TRIGGER_NETDEV is not set
CONFIG_LEDS_TRIGGER_PATTERN=m
CONFIG_LEDS_TRIGGER_AUDIO=m
CONFIG_ACCESSIBILITY=y

#
# Speakup console speech
#
# end of Speakup console speech

# CONFIG_INFINIBAND is not set
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
CONFIG_DW_AXI_DMAC=y
CONFIG_FSL_EDMA=y
CONFIG_INTEL_IDMA64=m
# CONFIG_PCH_DMA is not set
# CONFIG_PLX_DMA is not set
CONFIG_XILINX_ZYNQMP_DPDMA=y
# CONFIG_QCOM_HIDMA_MGMT is not set
# CONFIG_QCOM_HIDMA is not set
# CONFIG_DW_DMAC is not set
# CONFIG_DW_DMAC_PCI is not set
# CONFIG_SF_PDMA is not set

#
# DMA Clients
#
CONFIG_ASYNC_TX_DMA=y
CONFIG_DMATEST=y
CONFIG_DMA_ENGINE_RAID=y

#
# DMABUF options
#
CONFIG_SYNC_FILE=y
CONFIG_SW_SYNC=y
# CONFIG_UDMABUF is not set
# CONFIG_DMABUF_MOVE_NOTIFY is not set
# CONFIG_DMABUF_SELFTESTS is not set
CONFIG_DMABUF_HEAPS=y
# CONFIG_DMABUF_HEAPS_SYSTEM is not set
# end of DMABUF options

CONFIG_AUXDISPLAY=y
CONFIG_CHARLCD=y
CONFIG_HD44780_COMMON=y
# CONFIG_HD44780 is not set
CONFIG_IMG_ASCII_LCD=y
# CONFIG_HT16K33 is not set
# CONFIG_LCD2S is not set
CONFIG_PARPORT_PANEL=y
CONFIG_PANEL_PARPORT=0
CONFIG_PANEL_PROFILE=5
CONFIG_PANEL_CHANGE_MESSAGE=y
CONFIG_PANEL_BOOT_MESSAGE=""
# CONFIG_CHARLCD_BL_OFF is not set
CONFIG_CHARLCD_BL_ON=y
# CONFIG_CHARLCD_BL_FLASH is not set
CONFIG_PANEL=y
# CONFIG_UIO is not set
CONFIG_IRQ_BYPASS_MANAGER=m
CONFIG_VIRT_DRIVERS=y
# CONFIG_VBOXGUEST is not set
# CONFIG_NITRO_ENCLAVES is not set
CONFIG_VIRTIO=y
CONFIG_VIRTIO_MENU=y
# CONFIG_VIRTIO_PCI is not set
CONFIG_VIRTIO_VDPA=y
# CONFIG_VIRTIO_BALLOON is not set
CONFIG_VIRTIO_INPUT=m
CONFIG_VIRTIO_MMIO=y
CONFIG_VIRTIO_MMIO_CMDLINE_DEVICES=y
CONFIG_VIRTIO_DMA_SHARED_BUFFER=y
CONFIG_VDPA=y
CONFIG_VHOST_IOTLB=m
CONFIG_VHOST=m
CONFIG_VHOST_MENU=y
# CONFIG_VHOST_NET is not set
CONFIG_VHOST_SCSI=m
CONFIG_VHOST_VDPA=m
# CONFIG_VHOST_CROSS_ENDIAN_LEGACY is not set

#
# Microsoft Hyper-V guest support
#
# CONFIG_HYPERV is not set
# end of Microsoft Hyper-V guest support

# CONFIG_GREYBUS is not set
# CONFIG_STAGING is not set
CONFIG_X86_PLATFORM_DEVICES=y
CONFIG_ACPI_WMI=m
CONFIG_WMI_BMOF=m
CONFIG_ALIENWARE_WMI=m
CONFIG_HUAWEI_WMI=m
CONFIG_INTEL_WMI_SBL_FW_UPDATE=m
CONFIG_INTEL_WMI_THUNDERBOLT=m
# CONFIG_MXM_WMI is not set
# CONFIG_PEAQ_WMI is not set
CONFIG_XIAOMI_WMI=m
CONFIG_ACERHDF=y
CONFIG_ACER_WIRELESS=m
# CONFIG_ACER_WMI is not set
# CONFIG_AMD_PMC is not set
# CONFIG_APPLE_GMUX is not set
# CONFIG_ASUS_LAPTOP is not set
# CONFIG_ASUS_WIRELESS is not set
CONFIG_DCDBAS=m
# CONFIG_DELL_SMBIOS is not set
# CONFIG_DELL_RBU is not set
CONFIG_DELL_SMO8800=m
CONFIG_DELL_WMI_SYSMAN=m
CONFIG_DELL_WMI_AIO=m
CONFIG_DELL_WMI_LED=m
CONFIG_FUJITSU_LAPTOP=m
CONFIG_FUJITSU_TABLET=m
CONFIG_GPD_POCKET_FAN=y
CONFIG_HP_ACCEL=m
# CONFIG_HP_WIRELESS is not set
CONFIG_HP_WMI=m
CONFIG_TC1100_WMI=m
# CONFIG_IBM_RTL is not set
CONFIG_SENSORS_HDAPS=m
# CONFIG_THINKPAD_ACPI is not set
CONFIG_INTEL_ATOMISP2_LED=m
CONFIG_INTEL_HID_EVENT=m
CONFIG_INTEL_INT0002_VGPIO=m
CONFIG_INTEL_VBTN=m
# CONFIG_MSI_WMI is not set
# CONFIG_XO15_EBOOK is not set
# CONFIG_PCENGINES_APU2 is not set
CONFIG_SAMSUNG_LAPTOP=m
# CONFIG_SAMSUNG_Q10 is not set
CONFIG_ACPI_TOSHIBA=m
# CONFIG_TOSHIBA_BT_RFKILL is not set
# CONFIG_TOSHIBA_HAPS is not set
# CONFIG_TOSHIBA_WMI is not set
# CONFIG_ACPI_CMPC is not set
# CONFIG_LG_LAPTOP is not set
CONFIG_PANASONIC_LAPTOP=m
CONFIG_SYSTEM76_ACPI=m
# CONFIG_TOPSTAR_LAPTOP is not set
CONFIG_I2C_MULTI_INSTANTIATE=m
CONFIG_MLX_PLATFORM=y
# CONFIG_INTEL_IPS is not set
CONFIG_INTEL_RST=y
CONFIG_INTEL_SMARTCONNECT=y
CONFIG_INTEL_MID_POWER_BUTTON=m
CONFIG_INTEL_MRFLD_PWRBTN=m
# CONFIG_INTEL_PMC_CORE is not set
CONFIG_INTEL_PMT_CLASS=y
# CONFIG_INTEL_PMT_TELEMETRY is not set
CONFIG_INTEL_PMT_CRASHLOG=y
# CONFIG_INTEL_PUNIT_IPC is not set
CONFIG_INTEL_SCU_IPC=y
CONFIG_INTEL_SCU=y
# CONFIG_INTEL_SCU_PCI is not set
CONFIG_INTEL_SCU_PLATFORM=m
CONFIG_INTEL_SCU_IPC_UTIL=m
CONFIG_PMC_ATOM=y
CONFIG_GOLDFISH_PIPE=y
# CONFIG_CHROME_PLATFORMS is not set
CONFIG_MELLANOX_PLATFORM=y
CONFIG_MLXREG_HOTPLUG=m
# CONFIG_MLXREG_IO is not set
CONFIG_OLPC_EC=y
CONFIG_SURFACE_PLATFORMS=y
CONFIG_SURFACE_3_POWER_OPREGION=y
CONFIG_SURFACE_GPE=y
# CONFIG_SURFACE_PRO3_BUTTON is not set
CONFIG_HAVE_CLK=y
CONFIG_CLKDEV_LOOKUP=y
CONFIG_HAVE_CLK_PREPARE=y
CONFIG_COMMON_CLK=y
CONFIG_COMMON_CLK_MAX77686=y
CONFIG_COMMON_CLK_MAX9485=m
CONFIG_COMMON_CLK_SI5341=y
CONFIG_COMMON_CLK_SI5351=y
# CONFIG_COMMON_CLK_SI514 is not set
CONFIG_COMMON_CLK_SI544=y
CONFIG_COMMON_CLK_SI570=m
CONFIG_COMMON_CLK_CDCE706=y
CONFIG_COMMON_CLK_CDCE925=y
# CONFIG_COMMON_CLK_CS2000_CP is not set
CONFIG_COMMON_CLK_S2MPS11=m
# CONFIG_CLK_TWL6040 is not set
# CONFIG_COMMON_CLK_LOCHNAGAR is not set
CONFIG_COMMON_CLK_PALMAS=m
CONFIG_COMMON_CLK_PWM=y
CONFIG_COMMON_CLK_VC5=y
CONFIG_COMMON_CLK_BD718XX=y
# CONFIG_COMMON_CLK_FIXED_MMIO is not set
# CONFIG_CLK_LGM_CGU is not set
CONFIG_HWSPINLOCK=y

#
# Clock Source drivers
#
CONFIG_CLKSRC_I8253=y
CONFIG_CLKEVT_I8253=y
CONFIG_I8253_LOCK=y
CONFIG_CLKBLD_I8253=y
# CONFIG_MICROCHIP_PIT64B is not set
# end of Clock Source drivers

# CONFIG_MAILBOX is not set
# CONFIG_IOMMU_SUPPORT is not set

#
# Remoteproc drivers
#
# CONFIG_REMOTEPROC is not set
# end of Remoteproc drivers

#
# Rpmsg drivers
#
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
# Enable LiteX SoC Builder specific drivers
#
# CONFIG_LITEX_SOC_CONTROLLER is not set
# end of Enable LiteX SoC Builder specific drivers

#
# Qualcomm SoC drivers
#
# end of Qualcomm SoC drivers

# CONFIG_SOC_TI is not set

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
# CONFIG_DEVFREQ_GOV_PERFORMANCE is not set
CONFIG_DEVFREQ_GOV_POWERSAVE=m
# CONFIG_DEVFREQ_GOV_USERSPACE is not set
CONFIG_DEVFREQ_GOV_PASSIVE=y

#
# DEVFREQ Drivers
#
# CONFIG_PM_DEVFREQ_EVENT is not set
CONFIG_EXTCON=y

#
# Extcon Device Drivers
#
CONFIG_EXTCON_ADC_JACK=m
CONFIG_EXTCON_AXP288=y
CONFIG_EXTCON_FSA9480=m
# CONFIG_EXTCON_GPIO is not set
CONFIG_EXTCON_INTEL_INT3496=m
CONFIG_EXTCON_INTEL_MRFLD=m
# CONFIG_EXTCON_MAX14577 is not set
CONFIG_EXTCON_MAX3355=y
CONFIG_EXTCON_MAX77843=y
CONFIG_EXTCON_MAX8997=m
CONFIG_EXTCON_PALMAS=m
# CONFIG_EXTCON_PTN5150 is not set
CONFIG_EXTCON_RT8973A=y
# CONFIG_EXTCON_SM5502 is not set
# CONFIG_EXTCON_USB_GPIO is not set
# CONFIG_EXTCON_USBC_TUSB320 is not set
CONFIG_MEMORY=y
CONFIG_IIO=m
CONFIG_IIO_BUFFER=y
CONFIG_IIO_BUFFER_CB=m
CONFIG_IIO_BUFFER_DMA=m
CONFIG_IIO_BUFFER_DMAENGINE=m
CONFIG_IIO_BUFFER_HW_CONSUMER=m
CONFIG_IIO_KFIFO_BUF=m
CONFIG_IIO_TRIGGERED_BUFFER=m
CONFIG_IIO_CONFIGFS=m
CONFIG_IIO_TRIGGER=y
CONFIG_IIO_CONSUMERS_PER_TRIGGER=2
CONFIG_IIO_SW_DEVICE=m
CONFIG_IIO_SW_TRIGGER=m
CONFIG_IIO_TRIGGERED_EVENT=m

#
# Accelerometers
#
CONFIG_ADXL372=m
CONFIG_ADXL372_I2C=m
CONFIG_BMA400=m
CONFIG_BMA400_I2C=m
CONFIG_BMC150_ACCEL=m
CONFIG_BMC150_ACCEL_I2C=m
CONFIG_DA280=m
CONFIG_DA311=m
CONFIG_DMARD06=m
CONFIG_DMARD09=m
CONFIG_DMARD10=m
# CONFIG_IIO_ST_ACCEL_3AXIS is not set
CONFIG_KXSD9=m
# CONFIG_KXSD9_I2C is not set
# CONFIG_KXCJK1013 is not set
# CONFIG_MC3230 is not set
# CONFIG_MMA7455_I2C is not set
# CONFIG_MMA7660 is not set
CONFIG_MMA8452=m
CONFIG_MMA9551_CORE=m
# CONFIG_MMA9551 is not set
CONFIG_MMA9553=m
# CONFIG_MXC4005 is not set
CONFIG_MXC6255=m
# CONFIG_STK8312 is not set
CONFIG_STK8BA50=m
# end of Accelerometers

#
# Analog to digital converters
#
CONFIG_AD7091R5=m
# CONFIG_AD7291 is not set
# CONFIG_AD7606_IFACE_PARALLEL is not set
CONFIG_AD799X=m
# CONFIG_ADI_AXI_ADC is not set
CONFIG_AXP20X_ADC=m
# CONFIG_AXP288_ADC is not set
# CONFIG_CC10001_ADC is not set
CONFIG_DA9150_GPADC=m
CONFIG_DLN2_ADC=m
CONFIG_ENVELOPE_DETECTOR=m
CONFIG_HX711=m
# CONFIG_INA2XX_ADC is not set
CONFIG_INTEL_MRFLD_ADC=m
CONFIG_LP8788_ADC=m
CONFIG_LTC2471=m
# CONFIG_LTC2485 is not set
CONFIG_LTC2497=m
CONFIG_MAX1363=m
# CONFIG_MAX9611 is not set
CONFIG_MCP3422=m
# CONFIG_MEN_Z188_ADC is not set
CONFIG_MP2629_ADC=m
# CONFIG_NAU7802 is not set
CONFIG_PALMAS_GPADC=m
CONFIG_RN5T618_ADC=m
# CONFIG_SD_ADC_MODULATOR is not set
# CONFIG_STMPE_ADC is not set
CONFIG_STX104=m
CONFIG_TI_ADC081C=m
# CONFIG_TI_ADS1015 is not set
CONFIG_TI_AM335X_ADC=m
CONFIG_TWL4030_MADC=m
# CONFIG_TWL6030_GPADC is not set
CONFIG_VF610_ADC=m
CONFIG_XILINX_XADC=m
# end of Analog to digital converters

#
# Analog Front Ends
#
# CONFIG_IIO_RESCALE is not set
# end of Analog Front Ends

#
# Amplifiers
#
CONFIG_HMC425=m
# end of Amplifiers

#
# Chemical Sensors
#
CONFIG_ATLAS_PH_SENSOR=m
CONFIG_ATLAS_EZO_SENSOR=m
CONFIG_BME680=m
CONFIG_BME680_I2C=m
# CONFIG_CCS811 is not set
CONFIG_IAQCORE=m
CONFIG_PMS7003=m
CONFIG_SCD30_CORE=m
CONFIG_SCD30_I2C=m
CONFIG_SCD30_SERIAL=m
CONFIG_SENSIRION_SGP30=m
# CONFIG_SPS30 is not set
CONFIG_VZ89X=m
# end of Chemical Sensors

#
# Hid Sensor IIO Common
#
# end of Hid Sensor IIO Common

CONFIG_IIO_MS_SENSORS_I2C=m

#
# SSP Sensor Common
#
# end of SSP Sensor Common

CONFIG_IIO_ST_SENSORS_I2C=m
CONFIG_IIO_ST_SENSORS_CORE=m

#
# Digital to analog converters
#
# CONFIG_AD5064 is not set
# CONFIG_AD5380 is not set
CONFIG_AD5446=m
CONFIG_AD5592R_BASE=m
CONFIG_AD5593R=m
CONFIG_AD5686=m
CONFIG_AD5696_I2C=m
CONFIG_CIO_DAC=m
CONFIG_DPOT_DAC=m
# CONFIG_DS4424 is not set
# CONFIG_M62332 is not set
CONFIG_MAX517=m
CONFIG_MAX5821=m
# CONFIG_MCP4725 is not set
CONFIG_TI_DAC5571=m
CONFIG_VF610_DAC=m
# end of Digital to analog converters

#
# IIO dummy driver
#
CONFIG_IIO_DUMMY_EVGEN=m
CONFIG_IIO_SIMPLE_DUMMY=m
CONFIG_IIO_SIMPLE_DUMMY_EVENTS=y
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
CONFIG_BMG160=m
CONFIG_BMG160_I2C=m
CONFIG_FXAS21002C=m
CONFIG_FXAS21002C_I2C=m
# CONFIG_MPU3050_I2C is not set
# CONFIG_IIO_ST_GYRO_3AXIS is not set
CONFIG_ITG3200=m
# end of Digital gyroscope sensors

#
# Health Sensors
#

#
# Heart Rate Monitors
#
# CONFIG_AFE4404 is not set
CONFIG_MAX30100=m
# CONFIG_MAX30102 is not set
# end of Heart Rate Monitors
# end of Health Sensors

#
# Humidity sensors
#
# CONFIG_AM2315 is not set
CONFIG_DHT11=m
# CONFIG_HDC100X is not set
CONFIG_HDC2010=m
CONFIG_HTS221=m
CONFIG_HTS221_I2C=m
CONFIG_HTU21=m
CONFIG_SI7005=m
# CONFIG_SI7020 is not set
# end of Humidity sensors

#
# Inertial measurement units
#
CONFIG_BMI160=m
CONFIG_BMI160_I2C=m
# CONFIG_FXOS8700_I2C is not set
CONFIG_KMX61=m
CONFIG_INV_ICM42600=m
CONFIG_INV_ICM42600_I2C=m
CONFIG_INV_MPU6050_IIO=m
CONFIG_INV_MPU6050_I2C=m
CONFIG_IIO_ST_LSM6DSX=m
CONFIG_IIO_ST_LSM6DSX_I2C=m
CONFIG_IIO_ST_LSM6DSX_I3C=m
# end of Inertial measurement units

#
# Light sensors
#
# CONFIG_ACPI_ALS is not set
CONFIG_ADJD_S311=m
CONFIG_ADUX1020=m
CONFIG_AL3010=m
CONFIG_AL3320A=m
# CONFIG_APDS9300 is not set
# CONFIG_APDS9960 is not set
CONFIG_AS73211=m
CONFIG_BH1750=m
CONFIG_BH1780=m
CONFIG_CM32181=m
CONFIG_CM3232=m
# CONFIG_CM3323 is not set
# CONFIG_CM3605 is not set
# CONFIG_CM36651 is not set
CONFIG_GP2AP002=m
# CONFIG_GP2AP020A00F is not set
CONFIG_SENSORS_ISL29018=m
# CONFIG_SENSORS_ISL29028 is not set
CONFIG_ISL29125=m
CONFIG_JSA1212=m
# CONFIG_RPR0521 is not set
# CONFIG_LTR501 is not set
# CONFIG_LV0104CS is not set
# CONFIG_MAX44000 is not set
CONFIG_MAX44009=m
CONFIG_NOA1305=m
# CONFIG_OPT3001 is not set
CONFIG_PA12203001=m
CONFIG_SI1133=m
# CONFIG_SI1145 is not set
CONFIG_STK3310=m
CONFIG_ST_UVIS25=m
CONFIG_ST_UVIS25_I2C=m
CONFIG_TCS3414=m
# CONFIG_TCS3472 is not set
CONFIG_SENSORS_TSL2563=m
CONFIG_TSL2583=m
CONFIG_TSL2772=m
CONFIG_TSL4531=m
# CONFIG_US5182D is not set
# CONFIG_VCNL4000 is not set
CONFIG_VCNL4035=m
CONFIG_VEML6030=m
CONFIG_VEML6070=m
CONFIG_VL6180=m
CONFIG_ZOPT2201=m
# end of Light sensors

#
# Magnetometer sensors
#
# CONFIG_AK8974 is not set
CONFIG_AK8975=m
CONFIG_AK09911=m
CONFIG_BMC150_MAGN=m
CONFIG_BMC150_MAGN_I2C=m
CONFIG_MAG3110=m
CONFIG_MMC35240=m
CONFIG_IIO_ST_MAGN_3AXIS=m
CONFIG_IIO_ST_MAGN_I2C_3AXIS=m
CONFIG_SENSORS_HMC5843=m
CONFIG_SENSORS_HMC5843_I2C=m
CONFIG_SENSORS_RM3100=m
CONFIG_SENSORS_RM3100_I2C=m
# end of Magnetometer sensors

#
# Multiplexers
#
CONFIG_IIO_MUX=m
# end of Multiplexers

#
# Inclinometer sensors
#
# end of Inclinometer sensors

#
# Triggers - standalone
#
CONFIG_IIO_HRTIMER_TRIGGER=m
CONFIG_IIO_INTERRUPT_TRIGGER=m
CONFIG_IIO_TIGHTLOOP_TRIGGER=m
CONFIG_IIO_SYSFS_TRIGGER=m
# end of Triggers - standalone

#
# Linear and angular position sensors
#
# end of Linear and angular position sensors

#
# Digital potentiometers
#
CONFIG_AD5272=m
CONFIG_DS1803=m
CONFIG_MAX5432=m
CONFIG_MCP4018=m
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
CONFIG_ABP060MG=m
# CONFIG_BMP280 is not set
CONFIG_DLHL60D=m
# CONFIG_DPS310 is not set
CONFIG_HP03=m
# CONFIG_ICP10100 is not set
# CONFIG_MPL115_I2C is not set
# CONFIG_MPL3115 is not set
# CONFIG_MS5611 is not set
CONFIG_MS5637=m
CONFIG_IIO_ST_PRESS=m
CONFIG_IIO_ST_PRESS_I2C=m
# CONFIG_T5403 is not set
CONFIG_HP206C=m
CONFIG_ZPA2326=m
CONFIG_ZPA2326_I2C=m
# end of Pressure sensors

#
# Lightning sensors
#
# end of Lightning sensors

#
# Proximity and distance sensors
#
# CONFIG_ISL29501 is not set
CONFIG_LIDAR_LITE_V2=m
# CONFIG_MB1232 is not set
CONFIG_PING=m
CONFIG_RFD77402=m
CONFIG_SRF04=m
CONFIG_SX9310=m
# CONFIG_SX9500 is not set
# CONFIG_SRF08 is not set
CONFIG_VCNL3020=m
# CONFIG_VL53L0X_I2C is not set
# end of Proximity and distance sensors

#
# Resolver to digital converters
#
# end of Resolver to digital converters

#
# Temperature sensors
#
CONFIG_MLX90614=m
CONFIG_MLX90632=m
# CONFIG_TMP006 is not set
CONFIG_TMP007=m
CONFIG_TSYS01=m
CONFIG_TSYS02D=m
# end of Temperature sensors

# CONFIG_NTB is not set
# CONFIG_VME_BUS is not set
CONFIG_PWM=y
CONFIG_PWM_SYSFS=y
CONFIG_PWM_DEBUG=y
# CONFIG_PWM_ATMEL_HLCDC_PWM is not set
# CONFIG_PWM_ATMEL_TCB is not set
# CONFIG_PWM_DWC is not set
# CONFIG_PWM_FSL_FTM is not set
CONFIG_PWM_INTEL_LGM=y
CONFIG_PWM_LP3943=m
CONFIG_PWM_LPSS=m
# CONFIG_PWM_LPSS_PCI is not set
CONFIG_PWM_LPSS_PLATFORM=m
# CONFIG_PWM_PCA9685 is not set
# CONFIG_PWM_STMPE is not set
CONFIG_PWM_TWL=y
CONFIG_PWM_TWL_LED=y

#
# IRQ chip support
#
CONFIG_IRQCHIP=y
# CONFIG_AL_FIC is not set
CONFIG_MADERA_IRQ=m
# end of IRQ chip support

CONFIG_IPACK_BUS=y
# CONFIG_BOARD_TPCI200 is not set
CONFIG_SERIAL_IPOCTAL=y
CONFIG_RESET_CONTROLLER=y
CONFIG_RESET_BRCMSTB_RESCAL=y
CONFIG_RESET_INTEL_GW=y
CONFIG_RESET_TI_SYSCON=m

#
# PHY Subsystem
#
CONFIG_GENERIC_PHY=y
CONFIG_GENERIC_PHY_MIPI_DPHY=y
CONFIG_USB_LGM_PHY=y
# CONFIG_BCM_KONA_USB2_PHY is not set
CONFIG_PHY_CADENCE_TORRENT=m
# CONFIG_PHY_CADENCE_DPHY is not set
CONFIG_PHY_CADENCE_SIERRA=m
CONFIG_PHY_CADENCE_SALVO=y
# CONFIG_PHY_FSL_IMX8MQ_USB is not set
# CONFIG_PHY_MIXEL_MIPI_DPHY is not set
CONFIG_PHY_PXA_28NM_HSIC=m
# CONFIG_PHY_PXA_28NM_USB2 is not set
CONFIG_PHY_CPCAP_USB=m
CONFIG_PHY_MAPPHONE_MDM6600=y
CONFIG_PHY_OCELOT_SERDES=m
CONFIG_PHY_QCOM_USB_HS=m
CONFIG_PHY_QCOM_USB_HSIC=m
# CONFIG_PHY_SAMSUNG_USB2 is not set
CONFIG_PHY_TUSB1210=m
CONFIG_PHY_INTEL_LGM_COMBO=y
CONFIG_PHY_INTEL_LGM_EMMC=m
# end of PHY Subsystem

CONFIG_POWERCAP=y
CONFIG_MCB=y
# CONFIG_MCB_PCI is not set
CONFIG_MCB_LPC=m

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
CONFIG_NVMEM=y
CONFIG_NVMEM_SYSFS=y
# CONFIG_RAVE_SP_EEPROM is not set

#
# HW tracing support
#
CONFIG_STM=y
CONFIG_STM_PROTO_BASIC=m
CONFIG_STM_PROTO_SYS_T=y
CONFIG_STM_DUMMY=m
CONFIG_STM_SOURCE_CONSOLE=m
CONFIG_STM_SOURCE_HEARTBEAT=m
# CONFIG_STM_SOURCE_FTRACE is not set
CONFIG_INTEL_TH=m
# CONFIG_INTEL_TH_PCI is not set
CONFIG_INTEL_TH_ACPI=m
# CONFIG_INTEL_TH_GTH is not set
CONFIG_INTEL_TH_STH=m
CONFIG_INTEL_TH_MSU=m
CONFIG_INTEL_TH_PTI=m
CONFIG_INTEL_TH_DEBUG=y
# end of HW tracing support

CONFIG_FPGA=y
# CONFIG_ALTERA_PR_IP_CORE is not set
# CONFIG_FPGA_MGR_ALTERA_CVP is not set
CONFIG_FPGA_BRIDGE=m
# CONFIG_ALTERA_FREEZE_BRIDGE is not set
CONFIG_XILINX_PR_DECOUPLER=m
CONFIG_FPGA_REGION=m
# CONFIG_OF_FPGA_REGION is not set
CONFIG_FPGA_DFL=m
# CONFIG_FPGA_DFL_FME is not set
CONFIG_FPGA_DFL_AFU=m
# CONFIG_FPGA_DFL_PCI is not set
CONFIG_FSI=y
CONFIG_FSI_NEW_DEV_NODE=y
CONFIG_FSI_MASTER_GPIO=m
# CONFIG_FSI_MASTER_HUB is not set
CONFIG_FSI_MASTER_ASPEED=m
CONFIG_FSI_SCOM=m
CONFIG_FSI_SBEFIFO=m
CONFIG_FSI_OCC=m
CONFIG_TEE=y

#
# TEE drivers
#
# end of TEE drivers

CONFIG_MULTIPLEXER=y

#
# Multiplexer drivers
#
CONFIG_MUX_ADG792A=m
CONFIG_MUX_GPIO=y
CONFIG_MUX_MMIO=m
# end of Multiplexer drivers

CONFIG_PM_OPP=y
# CONFIG_SIOX is not set
# CONFIG_SLIMBUS is not set
CONFIG_INTERCONNECT=y
# CONFIG_COUNTER is not set
# CONFIG_MOST is not set
# end of Device Drivers

#
# File systems
#
CONFIG_DCACHE_WORD_ACCESS=y
CONFIG_VALIDATE_FS_PARSER=y
CONFIG_FS_IOMAP=y
# CONFIG_EXT2_FS is not set
CONFIG_EXT3_FS=m
# CONFIG_EXT3_FS_POSIX_ACL is not set
# CONFIG_EXT3_FS_SECURITY is not set
CONFIG_EXT4_FS=y
CONFIG_EXT4_USE_FOR_EXT2=y
# CONFIG_EXT4_FS_POSIX_ACL is not set
# CONFIG_EXT4_FS_SECURITY is not set
# CONFIG_EXT4_DEBUG is not set
# CONFIG_EXT4_KUNIT_TESTS is not set
CONFIG_JBD2=y
CONFIG_JBD2_DEBUG=y
CONFIG_FS_MBCACHE=y
CONFIG_REISERFS_FS=y
# CONFIG_REISERFS_CHECK is not set
# CONFIG_REISERFS_PROC_INFO is not set
# CONFIG_REISERFS_FS_XATTR is not set
CONFIG_JFS_FS=m
CONFIG_JFS_POSIX_ACL=y
# CONFIG_JFS_SECURITY is not set
CONFIG_JFS_DEBUG=y
CONFIG_JFS_STATISTICS=y
CONFIG_XFS_FS=y
CONFIG_XFS_SUPPORT_V4=y
CONFIG_XFS_QUOTA=y
# CONFIG_XFS_POSIX_ACL is not set
CONFIG_XFS_RT=y
# CONFIG_XFS_ONLINE_SCRUB is not set
# CONFIG_XFS_WARN is not set
# CONFIG_XFS_DEBUG is not set
# CONFIG_GFS2_FS is not set
# CONFIG_OCFS2_FS is not set
CONFIG_BTRFS_FS=m
# CONFIG_BTRFS_FS_POSIX_ACL is not set
# CONFIG_BTRFS_FS_CHECK_INTEGRITY is not set
# CONFIG_BTRFS_FS_RUN_SANITY_TESTS is not set
CONFIG_BTRFS_DEBUG=y
# CONFIG_BTRFS_ASSERT is not set
CONFIG_BTRFS_FS_REF_VERIFY=y
CONFIG_NILFS2_FS=y
CONFIG_F2FS_FS=y
# CONFIG_F2FS_STAT_FS is not set
# CONFIG_F2FS_FS_XATTR is not set
CONFIG_F2FS_CHECK_FS=y
# CONFIG_F2FS_IO_TRACE is not set
CONFIG_F2FS_FAULT_INJECTION=y
CONFIG_F2FS_FS_COMPRESSION=y
CONFIG_F2FS_FS_LZO=y
CONFIG_F2FS_FS_LZ4=y
# CONFIG_F2FS_FS_ZSTD is not set
CONFIG_F2FS_FS_LZORLE=y
CONFIG_FS_DAX=y
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
# CONFIG_FANOTIFY is not set
CONFIG_QUOTA=y
# CONFIG_QUOTA_NETLINK_INTERFACE is not set
CONFIG_PRINT_QUOTA_WARNING=y
CONFIG_QUOTA_DEBUG=y
CONFIG_QFMT_V1=m
# CONFIG_QFMT_V2 is not set
CONFIG_QUOTACTL=y
CONFIG_AUTOFS4_FS=y
CONFIG_AUTOFS_FS=y
# CONFIG_FUSE_FS is not set
# CONFIG_OVERLAY_FS is not set

#
# Caches
#
# CONFIG_FSCACHE is not set
# end of Caches

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=y
# CONFIG_JOLIET is not set
CONFIG_ZISOFS=y
# CONFIG_UDF_FS is not set
# end of CD-ROM/DVD Filesystems

#
# DOS/FAT/EXFAT/NT Filesystems
#
CONFIG_FAT_FS=y
CONFIG_MSDOS_FS=m
CONFIG_VFAT_FS=y
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
CONFIG_FAT_DEFAULT_UTF8=y
CONFIG_EXFAT_FS=y
CONFIG_EXFAT_DEFAULT_IOCHARSET="utf8"
# CONFIG_NTFS_FS is not set
# end of DOS/FAT/EXFAT/NT Filesystems

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
# CONFIG_PROC_KCORE is not set
# CONFIG_PROC_VMCORE is not set
CONFIG_PROC_SYSCTL=y
CONFIG_PROC_PAGE_MONITOR=y
CONFIG_PROC_CHILDREN=y
CONFIG_PROC_PID_ARCH_STATUS=y
CONFIG_PROC_CPU_RESCTRL=y
CONFIG_KERNFS=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
# CONFIG_TMPFS_POSIX_ACL is not set
# CONFIG_TMPFS_XATTR is not set
# CONFIG_HUGETLBFS is not set
CONFIG_MEMFD_CREATE=y
CONFIG_CONFIGFS_FS=y
# end of Pseudo filesystems

CONFIG_MISC_FILESYSTEMS=y
CONFIG_ORANGEFS_FS=m
# CONFIG_ADFS_FS is not set
CONFIG_AFFS_FS=y
# CONFIG_ECRYPT_FS is not set
# CONFIG_HFS_FS is not set
CONFIG_HFSPLUS_FS=y
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
CONFIG_EFS_FS=m
CONFIG_CRAMFS=y
# CONFIG_CRAMFS_BLOCKDEV is not set
CONFIG_SQUASHFS=y
CONFIG_SQUASHFS_FILE_CACHE=y
# CONFIG_SQUASHFS_FILE_DIRECT is not set
# CONFIG_SQUASHFS_DECOMP_SINGLE is not set
# CONFIG_SQUASHFS_DECOMP_MULTI is not set
CONFIG_SQUASHFS_DECOMP_MULTI_PERCPU=y
# CONFIG_SQUASHFS_XATTR is not set
# CONFIG_SQUASHFS_ZLIB is not set
# CONFIG_SQUASHFS_LZ4 is not set
CONFIG_SQUASHFS_LZO=y
CONFIG_SQUASHFS_XZ=y
CONFIG_SQUASHFS_ZSTD=y
CONFIG_SQUASHFS_4K_DEVBLK_SIZE=y
CONFIG_SQUASHFS_EMBEDDED=y
CONFIG_SQUASHFS_FRAGMENT_CACHE_SIZE=3
# CONFIG_VXFS_FS is not set
CONFIG_MINIX_FS=y
CONFIG_OMFS_FS=y
CONFIG_HPFS_FS=y
CONFIG_QNX4FS_FS=y
CONFIG_QNX6FS_FS=y
CONFIG_QNX6FS_DEBUG=y
CONFIG_ROMFS_FS=m
CONFIG_ROMFS_BACKED_BY_BLOCK=y
CONFIG_ROMFS_ON_BLOCK=y
CONFIG_PSTORE=m
CONFIG_PSTORE_DEFAULT_KMSG_BYTES=10240
CONFIG_PSTORE_DEFLATE_COMPRESS=m
# CONFIG_PSTORE_LZO_COMPRESS is not set
# CONFIG_PSTORE_LZ4_COMPRESS is not set
# CONFIG_PSTORE_LZ4HC_COMPRESS is not set
# CONFIG_PSTORE_842_COMPRESS is not set
# CONFIG_PSTORE_ZSTD_COMPRESS is not set
CONFIG_PSTORE_COMPRESS=y
CONFIG_PSTORE_DEFLATE_COMPRESS_DEFAULT=y
CONFIG_PSTORE_COMPRESS_DEFAULT="deflate"
# CONFIG_PSTORE_CONSOLE is not set
CONFIG_PSTORE_PMSG=y
CONFIG_PSTORE_FTRACE=y
CONFIG_PSTORE_RAM=m
CONFIG_PSTORE_ZONE=m
CONFIG_PSTORE_BLK=m
CONFIG_PSTORE_BLK_BLKDEV=""
CONFIG_PSTORE_BLK_KMSG_SIZE=64
CONFIG_PSTORE_BLK_MAX_REASON=2
CONFIG_PSTORE_BLK_PMSG_SIZE=64
CONFIG_PSTORE_BLK_FTRACE_SIZE=64
CONFIG_SYSV_FS=m
CONFIG_UFS_FS=m
# CONFIG_UFS_FS_WRITE is not set
CONFIG_UFS_DEBUG=y
CONFIG_EROFS_FS=y
# CONFIG_EROFS_FS_DEBUG is not set
# CONFIG_EROFS_FS_XATTR is not set
CONFIG_EROFS_FS_ZIP=y
CONFIG_EROFS_FS_CLUSTER_PAGE_LIMIT=1
CONFIG_NETWORK_FILESYSTEMS=y
CONFIG_NFS_FS=y
CONFIG_NFS_V2=y
CONFIG_NFS_V3=y
# CONFIG_NFS_V3_ACL is not set
CONFIG_NFS_V4=m
# CONFIG_NFS_V4_1 is not set
# CONFIG_ROOT_NFS is not set
# CONFIG_NFS_USE_LEGACY_DNS is not set
CONFIG_NFS_USE_KERNEL_DNS=y
CONFIG_NFS_DISABLE_UDP_SUPPORT=y
# CONFIG_NFSD is not set
CONFIG_GRACE_PERIOD=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_NFS_COMMON=y
CONFIG_SUNRPC=y
CONFIG_SUNRPC_GSS=m
CONFIG_RPCSEC_GSS_KRB5=m
# CONFIG_SUNRPC_DISABLE_INSECURE_ENCTYPES is not set
# CONFIG_SUNRPC_DEBUG is not set
# CONFIG_CEPH_FS is not set
CONFIG_CIFS=m
# CONFIG_CIFS_STATS2 is not set
CONFIG_CIFS_ALLOW_INSECURE_LEGACY=y
# CONFIG_CIFS_WEAK_PW_HASH is not set
# CONFIG_CIFS_UPCALL is not set
# CONFIG_CIFS_XATTR is not set
CONFIG_CIFS_DEBUG=y
# CONFIG_CIFS_DEBUG2 is not set
# CONFIG_CIFS_DEBUG_DUMP_KEYS is not set
# CONFIG_CIFS_DFS_UPCALL is not set
# CONFIG_CIFS_SWN_UPCALL is not set
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set
# CONFIG_9P_FS is not set
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
# CONFIG_NLS_CODEPAGE_437 is not set
CONFIG_NLS_CODEPAGE_737=y
CONFIG_NLS_CODEPAGE_775=y
CONFIG_NLS_CODEPAGE_850=m
CONFIG_NLS_CODEPAGE_852=m
CONFIG_NLS_CODEPAGE_855=y
CONFIG_NLS_CODEPAGE_857=y
CONFIG_NLS_CODEPAGE_860=m
# CONFIG_NLS_CODEPAGE_861 is not set
CONFIG_NLS_CODEPAGE_862=y
CONFIG_NLS_CODEPAGE_863=m
# CONFIG_NLS_CODEPAGE_864 is not set
CONFIG_NLS_CODEPAGE_865=m
CONFIG_NLS_CODEPAGE_866=y
# CONFIG_NLS_CODEPAGE_869 is not set
CONFIG_NLS_CODEPAGE_936=m
CONFIG_NLS_CODEPAGE_950=y
CONFIG_NLS_CODEPAGE_932=m
CONFIG_NLS_CODEPAGE_949=y
CONFIG_NLS_CODEPAGE_874=y
CONFIG_NLS_ISO8859_8=m
CONFIG_NLS_CODEPAGE_1250=m
CONFIG_NLS_CODEPAGE_1251=y
CONFIG_NLS_ASCII=y
# CONFIG_NLS_ISO8859_1 is not set
CONFIG_NLS_ISO8859_2=m
CONFIG_NLS_ISO8859_3=m
CONFIG_NLS_ISO8859_4=m
CONFIG_NLS_ISO8859_5=y
CONFIG_NLS_ISO8859_6=y
CONFIG_NLS_ISO8859_7=y
CONFIG_NLS_ISO8859_9=y
# CONFIG_NLS_ISO8859_13 is not set
# CONFIG_NLS_ISO8859_14 is not set
# CONFIG_NLS_ISO8859_15 is not set
# CONFIG_NLS_KOI8_R is not set
CONFIG_NLS_KOI8_U=m
CONFIG_NLS_MAC_ROMAN=m
CONFIG_NLS_MAC_CELTIC=m
CONFIG_NLS_MAC_CENTEURO=y
CONFIG_NLS_MAC_CROATIAN=y
CONFIG_NLS_MAC_CYRILLIC=y
CONFIG_NLS_MAC_GAELIC=y
# CONFIG_NLS_MAC_GREEK is not set
CONFIG_NLS_MAC_ICELAND=m
CONFIG_NLS_MAC_INUIT=y
CONFIG_NLS_MAC_ROMANIAN=m
CONFIG_NLS_MAC_TURKISH=m
CONFIG_NLS_UTF8=y
# CONFIG_DLM is not set
# CONFIG_UNICODE is not set
CONFIG_IO_WQ=y
# end of File systems

#
# Security options
#
CONFIG_KEYS=y
# CONFIG_KEYS_REQUEST_CACHE is not set
# CONFIG_PERSISTENT_KEYRINGS is not set
# CONFIG_TRUSTED_KEYS is not set
# CONFIG_ENCRYPTED_KEYS is not set
# CONFIG_KEY_DH_OPERATIONS is not set
CONFIG_SECURITY_DMESG_RESTRICT=y
# CONFIG_SECURITY is not set
CONFIG_SECURITYFS=y
CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
CONFIG_HARDENED_USERCOPY=y
# CONFIG_HARDENED_USERCOPY_FALLBACK is not set
CONFIG_HARDENED_USERCOPY_PAGESPAN=y
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

CONFIG_XOR_BLOCKS=m
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
# CONFIG_CRYPTO_PCRYPT is not set
CONFIG_CRYPTO_CRYPTD=y
CONFIG_CRYPTO_AUTHENC=y
CONFIG_CRYPTO_TEST=y
CONFIG_CRYPTO_SIMD=y
CONFIG_CRYPTO_GLUE_HELPER_X86=y

#
# Public-key cryptography
#
# CONFIG_CRYPTO_RSA is not set
# CONFIG_CRYPTO_DH is not set
CONFIG_CRYPTO_ECC=y
CONFIG_CRYPTO_ECDH=y
CONFIG_CRYPTO_ECRDSA=y
CONFIG_CRYPTO_SM2=m
CONFIG_CRYPTO_CURVE25519=m

#
# Authenticated Encryption with Associated Data
#
CONFIG_CRYPTO_CCM=m
CONFIG_CRYPTO_GCM=y
CONFIG_CRYPTO_CHACHA20POLY1305=y
CONFIG_CRYPTO_AEGIS128=m
CONFIG_CRYPTO_SEQIV=y
# CONFIG_CRYPTO_ECHAINIV is not set

#
# Block modes
#
CONFIG_CRYPTO_CBC=m
CONFIG_CRYPTO_CFB=y
CONFIG_CRYPTO_CTR=y
CONFIG_CRYPTO_CTS=m
CONFIG_CRYPTO_ECB=m
CONFIG_CRYPTO_LRW=y
CONFIG_CRYPTO_OFB=m
CONFIG_CRYPTO_PCBC=m
CONFIG_CRYPTO_XTS=m
CONFIG_CRYPTO_KEYWRAP=m
CONFIG_CRYPTO_NHPOLY1305=m
CONFIG_CRYPTO_ADIANTUM=m
# CONFIG_CRYPTO_ESSIV is not set

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
CONFIG_CRYPTO_CRC32C_INTEL=y
CONFIG_CRYPTO_CRC32=y
CONFIG_CRYPTO_CRC32_PCLMUL=y
CONFIG_CRYPTO_XXHASH=m
CONFIG_CRYPTO_BLAKE2B=m
CONFIG_CRYPTO_BLAKE2S=y
CONFIG_CRYPTO_CRCT10DIF=y
CONFIG_CRYPTO_GHASH=y
CONFIG_CRYPTO_POLY1305=y
CONFIG_CRYPTO_MD4=y
CONFIG_CRYPTO_MD5=m
CONFIG_CRYPTO_MICHAEL_MIC=y
CONFIG_CRYPTO_RMD128=m
CONFIG_CRYPTO_RMD160=y
CONFIG_CRYPTO_RMD256=y
# CONFIG_CRYPTO_RMD320 is not set
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=m
# CONFIG_CRYPTO_SHA3 is not set
CONFIG_CRYPTO_SM3=m
CONFIG_CRYPTO_STREEBOG=y
# CONFIG_CRYPTO_TGR192 is not set
# CONFIG_CRYPTO_WP512 is not set

#
# Ciphers
#
CONFIG_CRYPTO_AES=y
CONFIG_CRYPTO_AES_TI=m
CONFIG_CRYPTO_AES_NI_INTEL=y
CONFIG_CRYPTO_BLOWFISH=m
CONFIG_CRYPTO_BLOWFISH_COMMON=m
CONFIG_CRYPTO_CAMELLIA=m
CONFIG_CRYPTO_CAST_COMMON=y
CONFIG_CRYPTO_CAST5=y
CONFIG_CRYPTO_CAST6=y
CONFIG_CRYPTO_DES=m
CONFIG_CRYPTO_FCRYPT=m
CONFIG_CRYPTO_SALSA20=m
CONFIG_CRYPTO_CHACHA20=y
CONFIG_CRYPTO_SERPENT=y
CONFIG_CRYPTO_SERPENT_SSE2_586=y
CONFIG_CRYPTO_SM4=m
# CONFIG_CRYPTO_TWOFISH is not set
CONFIG_CRYPTO_TWOFISH_COMMON=y
CONFIG_CRYPTO_TWOFISH_586=y

#
# Compression
#
CONFIG_CRYPTO_DEFLATE=y
CONFIG_CRYPTO_LZO=m
CONFIG_CRYPTO_842=m
CONFIG_CRYPTO_LZ4=m
# CONFIG_CRYPTO_LZ4HC is not set
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
# CONFIG_CRYPTO_USER_API_HASH is not set
# CONFIG_CRYPTO_USER_API_SKCIPHER is not set
# CONFIG_CRYPTO_USER_API_RNG is not set
# CONFIG_CRYPTO_USER_API_AEAD is not set
CONFIG_CRYPTO_HASH_INFO=y

#
# Crypto library routines
#
CONFIG_CRYPTO_LIB_AES=y
CONFIG_CRYPTO_LIB_ARC4=m
CONFIG_CRYPTO_LIB_BLAKE2S_GENERIC=y
CONFIG_CRYPTO_LIB_BLAKE2S=m
CONFIG_CRYPTO_LIB_CHACHA_GENERIC=y
CONFIG_CRYPTO_LIB_CHACHA=m
CONFIG_CRYPTO_LIB_CURVE25519_GENERIC=m
# CONFIG_CRYPTO_LIB_CURVE25519 is not set
CONFIG_CRYPTO_LIB_DES=m
CONFIG_CRYPTO_LIB_POLY1305_RSIZE=1
CONFIG_CRYPTO_LIB_POLY1305_GENERIC=y
CONFIG_CRYPTO_LIB_POLY1305=y
CONFIG_CRYPTO_LIB_CHACHA20POLY1305=m
CONFIG_CRYPTO_LIB_SHA256=y
# CONFIG_CRYPTO_HW is not set
# CONFIG_ASYMMETRIC_KEY_TYPE is not set

#
# Certificates for signature checking
#
# CONFIG_SYSTEM_BLACKLIST_KEYRING is not set
# end of Certificates for signature checking

CONFIG_BINARY_PRINTF=y

#
# Library routines
#
CONFIG_RAID6_PQ=m
# CONFIG_RAID6_PQ_BENCHMARK is not set
CONFIG_LINEAR_RANGES=y
CONFIG_PACKING=y
CONFIG_BITREVERSE=y
CONFIG_GENERIC_STRNCPY_FROM_USER=y
CONFIG_GENERIC_STRNLEN_USER=y
CONFIG_GENERIC_NET_UTILS=y
CONFIG_GENERIC_FIND_FIRST_BIT=y
CONFIG_CORDIC=y
# CONFIG_PRIME_NUMBERS is not set
CONFIG_RATIONAL=y
CONFIG_GENERIC_PCI_IOMAP=y
CONFIG_GENERIC_IOMAP=y
CONFIG_ARCH_HAS_FAST_MULTIPLIER=y
CONFIG_ARCH_USE_SYM_ANNOTATIONS=y
CONFIG_CRC_CCITT=y
CONFIG_CRC16=y
CONFIG_CRC_T10DIF=y
CONFIG_CRC_ITU_T=y
CONFIG_CRC32=y
CONFIG_CRC32_SELFTEST=m
# CONFIG_CRC32_SLICEBY8 is not set
CONFIG_CRC32_SLICEBY4=y
# CONFIG_CRC32_SARWATE is not set
# CONFIG_CRC32_BIT is not set
CONFIG_CRC64=y
CONFIG_CRC4=y
CONFIG_CRC7=m
CONFIG_LIBCRC32C=y
CONFIG_CRC8=m
CONFIG_XXHASH=y
# CONFIG_RANDOM32_SELFTEST is not set
CONFIG_842_COMPRESS=m
CONFIG_842_DECOMPRESS=m
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_LZO_COMPRESS=y
CONFIG_LZO_DECOMPRESS=y
CONFIG_LZ4_COMPRESS=y
CONFIG_LZ4_DECOMPRESS=y
CONFIG_ZSTD_COMPRESS=y
CONFIG_ZSTD_DECOMPRESS=y
CONFIG_XZ_DEC=y
# CONFIG_XZ_DEC_X86 is not set
# CONFIG_XZ_DEC_POWERPC is not set
# CONFIG_XZ_DEC_IA64 is not set
# CONFIG_XZ_DEC_ARM is not set
CONFIG_XZ_DEC_ARMTHUMB=y
# CONFIG_XZ_DEC_SPARC is not set
CONFIG_XZ_DEC_BCJ=y
# CONFIG_XZ_DEC_TEST is not set
CONFIG_DECOMPRESS_GZIP=y
CONFIG_DECOMPRESS_BZIP2=y
CONFIG_DECOMPRESS_XZ=y
CONFIG_DECOMPRESS_LZO=y
CONFIG_DECOMPRESS_LZ4=y
CONFIG_DECOMPRESS_ZSTD=y
CONFIG_GENERIC_ALLOCATOR=y
CONFIG_REED_SOLOMON=m
CONFIG_REED_SOLOMON_ENC8=y
CONFIG_REED_SOLOMON_DEC8=y
CONFIG_ASSOCIATIVE_ARRAY=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT_MAP=y
CONFIG_HAS_DMA=y
CONFIG_NEED_SG_DMA_LENGTH=y
# CONFIG_DMA_API_DEBUG is not set
CONFIG_DMA_MAP_BENCHMARK=y
CONFIG_SGL_ALLOC=y
CONFIG_CPUMASK_OFFSTACK=y
CONFIG_CPU_RMAP=y
CONFIG_DQL=y
CONFIG_GLOB=y
CONFIG_GLOB_SELFTEST=y
CONFIG_NLATTR=y
CONFIG_CLZ_TAB=y
# CONFIG_IRQ_POLL is not set
CONFIG_MPILIB=m
CONFIG_LIBFDT=y
CONFIG_OID_REGISTRY=y
CONFIG_HAVE_GENERIC_VDSO=y
CONFIG_GENERIC_GETTIMEOFDAY=y
CONFIG_GENERIC_VDSO_32=y
CONFIG_GENERIC_VDSO_TIME_NS=y
CONFIG_FONT_SUPPORT=y
CONFIG_FONT_8x16=y
CONFIG_FONT_AUTOSELECT=y
CONFIG_SG_POOL=y
CONFIG_ARCH_STACKWALK=y
CONFIG_SBITMAP=y
CONFIG_STRING_SELFTEST=y
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
# CONFIG_SYMBOLIC_ERRNAME is not set
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
CONFIG_FRAME_WARN=1024
CONFIG_STRIP_ASM_SYMS=y
CONFIG_READABLE_ASM=y
# CONFIG_HEADERS_INSTALL is not set
CONFIG_DEBUG_SECTION_MISMATCH=y
CONFIG_SECTION_MISMATCH_WARN_ONLY=y
CONFIG_DEBUG_FORCE_FUNCTION_ALIGN_32B=y
CONFIG_DEBUG_FORCE_WEAK_PER_CPU=y
# end of Compile-time checks and compiler options

#
# Generic Kernel Debugging Instruments
#
CONFIG_MAGIC_SYSRQ=y
CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x1
# CONFIG_MAGIC_SYSRQ_SERIAL is not set
CONFIG_DEBUG_FS=y
# CONFIG_DEBUG_FS_ALLOW_ALL is not set
# CONFIG_DEBUG_FS_DISALLOW_MOUNT is not set
CONFIG_DEBUG_FS_ALLOW_NONE=y
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
# CONFIG_DEBUG_PAGE_REF is not set
# CONFIG_DEBUG_RODATA_TEST is not set
CONFIG_ARCH_HAS_DEBUG_WX=y
# CONFIG_DEBUG_WX is not set
CONFIG_GENERIC_PTDUMP=y
CONFIG_PTDUMP_CORE=y
CONFIG_PTDUMP_DEBUGFS=y
# CONFIG_DEBUG_OBJECTS is not set
# CONFIG_SLUB_DEBUG_ON is not set
CONFIG_SLUB_STATS=y
CONFIG_HAVE_DEBUG_KMEMLEAK=y
# CONFIG_DEBUG_KMEMLEAK is not set
CONFIG_DEBUG_STACK_USAGE=y
# CONFIG_SCHED_STACK_END_CHECK is not set
CONFIG_ARCH_HAS_DEBUG_VM_PGTABLE=y
CONFIG_DEBUG_VM=y
# CONFIG_DEBUG_VM_VMACACHE is not set
# CONFIG_DEBUG_VM_RB is not set
# CONFIG_DEBUG_VM_PGFLAGS is not set
# CONFIG_DEBUG_VM_PGTABLE is not set
CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
CONFIG_DEBUG_VIRTUAL=y
CONFIG_DEBUG_MEMORY_INIT=y
CONFIG_DEBUG_PER_CPU_MAPS=y
CONFIG_DEBUG_KMAP_LOCAL=y
CONFIG_ARCH_SUPPORTS_KMAP_LOCAL_FORCE_MAP=y
CONFIG_DEBUG_KMAP_LOCAL_FORCE_MAP=y
CONFIG_DEBUG_HIGHMEM=y
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
# CONFIG_SOFTLOCKUP_DETECTOR is not set
# CONFIG_HARDLOCKUP_DETECTOR is not set
# CONFIG_DETECT_HUNG_TASK is not set
CONFIG_WQ_WATCHDOG=y
CONFIG_TEST_LOCKUP=m
# end of Debug Oops, Lockups and Hangs

#
# Scheduler Debugging
#
CONFIG_SCHED_DEBUG=y
CONFIG_SCHED_INFO=y
CONFIG_SCHEDSTATS=y
# end of Scheduler Debugging

# CONFIG_DEBUG_TIMEKEEPING is not set
# CONFIG_DEBUG_PREEMPT is not set

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
CONFIG_DEBUG_LOCK_ALLOC=y
CONFIG_LOCKDEP=y
# CONFIG_DEBUG_LOCKDEP is not set
CONFIG_DEBUG_ATOMIC_SLEEP=y
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
CONFIG_LOCK_TORTURE_TEST=m
CONFIG_WW_MUTEX_SELFTEST=m
# CONFIG_SCF_TORTURE_TEST is not set
# end of Lock Debugging (spinlocks, mutexes, etc...)

CONFIG_STACKTRACE=y
CONFIG_WARN_ALL_UNSEEDED_RANDOM=y
# CONFIG_DEBUG_KOBJECT is not set

#
# Debug kernel data structures
#
# CONFIG_DEBUG_LIST is not set
# CONFIG_DEBUG_PLIST is not set
# CONFIG_DEBUG_SG is not set
CONFIG_DEBUG_NOTIFIERS=y
# CONFIG_BUG_ON_DATA_CORRUPTION is not set
# end of Debug kernel data structures

CONFIG_DEBUG_CREDENTIALS=y

#
# RCU Debugging
#
CONFIG_TORTURE_TEST=m
CONFIG_RCU_SCALE_TEST=m
CONFIG_RCU_TORTURE_TEST=m
# CONFIG_RCU_REF_SCALE_TEST is not set
CONFIG_RCU_CPU_STALL_TIMEOUT=21
# CONFIG_RCU_TRACE is not set
# CONFIG_RCU_EQS_DEBUG is not set
# CONFIG_RCU_STRICT_GRACE_PERIOD is not set
# end of RCU Debugging

CONFIG_DEBUG_WQ_FORCE_RR_CPU=y
# CONFIG_DEBUG_BLOCK_EXT_DEVT is not set
CONFIG_CPU_HOTPLUG_STATE_CONTROL=y
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
CONFIG_PREEMPTIRQ_TRACEPOINTS=y
CONFIG_TRACING=y
CONFIG_GENERIC_TRACER=y
CONFIG_TRACING_SUPPORT=y
CONFIG_FTRACE=y
CONFIG_BOOTTIME_TRACING=y
CONFIG_FUNCTION_TRACER=y
# CONFIG_FUNCTION_GRAPH_TRACER is not set
CONFIG_DYNAMIC_FTRACE=y
CONFIG_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=y
CONFIG_FUNCTION_PROFILER=y
CONFIG_STACK_TRACER=y
CONFIG_TRACE_PREEMPT_TOGGLE=y
# CONFIG_IRQSOFF_TRACER is not set
CONFIG_PREEMPT_TRACER=y
CONFIG_SCHED_TRACER=y
# CONFIG_HWLAT_TRACER is not set
# CONFIG_MMIOTRACE is not set
# CONFIG_FTRACE_SYSCALLS is not set
CONFIG_TRACER_SNAPSHOT=y
CONFIG_TRACER_SNAPSHOT_PER_CPU_SWAP=y
CONFIG_TRACE_BRANCH_PROFILING=y
# CONFIG_BRANCH_PROFILE_NONE is not set
# CONFIG_PROFILE_ANNOTATED_BRANCHES is not set
CONFIG_PROFILE_ALL_BRANCHES=y
# CONFIG_BRANCH_TRACER is not set
CONFIG_BLK_DEV_IO_TRACE=y
CONFIG_UPROBE_EVENTS=y
CONFIG_BPF_EVENTS=y
CONFIG_DYNAMIC_EVENTS=y
CONFIG_PROBE_EVENTS=y
CONFIG_FTRACE_MCOUNT_RECORD=y
CONFIG_SYNTH_EVENTS=y
# CONFIG_HIST_TRIGGERS is not set
# CONFIG_TRACE_EVENT_INJECT is not set
CONFIG_TRACEPOINT_BENCHMARK=y
CONFIG_RING_BUFFER_BENCHMARK=m
# CONFIG_TRACE_EVAL_MAP_FILE is not set
CONFIG_FTRACE_RECORD_RECURSION=y
CONFIG_FTRACE_RECORD_RECURSION_SIZE=128
# CONFIG_RING_BUFFER_RECORD_RECURSION is not set
# CONFIG_GCOV_PROFILE_FTRACE is not set
# CONFIG_FTRACE_STARTUP_TEST is not set
# CONFIG_RING_BUFFER_STARTUP_TEST is not set
CONFIG_RING_BUFFER_VALIDATE_TIME_DELTAS=y
CONFIG_PREEMPTIRQ_DELAY_TEST=m
CONFIG_SYNTH_EVENT_GEN_TEST=y
# CONFIG_PROVIDE_OHCI1394_DMA_INIT is not set
CONFIG_SAMPLES=y
# CONFIG_SAMPLE_TRACE_EVENTS is not set
# CONFIG_SAMPLE_TRACE_PRINTK is not set
# CONFIG_SAMPLE_TRACE_ARRAY is not set
CONFIG_SAMPLE_KOBJECT=m
CONFIG_SAMPLE_HW_BREAKPOINT=m
CONFIG_SAMPLE_KFIFO=m
CONFIG_SAMPLE_CONFIGFS=m
# CONFIG_SAMPLE_VFIO_MDEV_MDPY_FB is not set
CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y
# CONFIG_STRICT_DEVMEM is not set

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
# CONFIG_DEBUG_TLBFLUSH is not set
CONFIG_HAVE_MMIOTRACE_SUPPORT=y
CONFIG_X86_DECODER_SELFTEST=y
# CONFIG_IO_DELAY_0X80 is not set
CONFIG_IO_DELAY_0XED=y
# CONFIG_IO_DELAY_UDELAY is not set
# CONFIG_IO_DELAY_NONE is not set
# CONFIG_DEBUG_BOOT_PARAMS is not set
# CONFIG_CPA_DEBUG is not set
CONFIG_DEBUG_ENTRY=y
# CONFIG_DEBUG_NMI_SELFTEST is not set
# CONFIG_X86_DEBUG_FPU is not set
# CONFIG_PUNIT_ATOM_DEBUG is not set
# CONFIG_UNWINDER_FRAME_POINTER is not set
CONFIG_UNWINDER_GUESS=y
# end of x86 Debugging

#
# Kernel Testing and Coverage
#
CONFIG_KUNIT=y
# CONFIG_KUNIT_DEBUGFS is not set
CONFIG_KUNIT_TEST=y
CONFIG_KUNIT_EXAMPLE_TEST=m
# CONFIG_KUNIT_ALL_TESTS is not set
CONFIG_NOTIFIER_ERROR_INJECTION=m
# CONFIG_PM_NOTIFIER_ERROR_INJECT is not set
# CONFIG_OF_RECONFIG_NOTIFIER_ERROR_INJECT is not set
# CONFIG_NETDEV_NOTIFIER_ERROR_INJECT is not set
CONFIG_FAULT_INJECTION=y
# CONFIG_FAILSLAB is not set
CONFIG_FAIL_PAGE_ALLOC=y
CONFIG_FAULT_INJECTION_USERCOPY=y
CONFIG_FAIL_MAKE_REQUEST=y
# CONFIG_FAIL_IO_TIMEOUT is not set
# CONFIG_FAIL_FUTEX is not set
CONFIG_FAULT_INJECTION_DEBUG_FS=y
CONFIG_FAIL_MMC_REQUEST=y
# CONFIG_FAULT_INJECTION_STACKTRACE_FILTER is not set
CONFIG_CC_HAS_SANCOV_TRACE_PC=y
# CONFIG_RUNTIME_TESTING_MENU is not set
CONFIG_MEMTEST=y
# end of Kernel Testing and Coverage
# end of Kernel hacking

--pWyiEgJYm5f9v55/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=job-script

#!/bin/sh

export_top_env()
{
	export suite='rcutorture'
	export testcase='rcutorture'
	export category='functional'
	export need_memory='300MB'
	export runtime=300
	export job_origin='/lkp-src/allot/rand/vm-snb-i386/rcutorture.yaml'
	export queue_cmdline_keys='branch
commit
queue_at_least_once'
	export queue='validate'
	export testbox='vm-snb-i386-125'
	export tbox_group='vm-snb-i386'
	export branch='rcu/dev.2021.01.11b'
	export commit='d5bff968ea9cc005e632d9369c26cbd8148c93d5'
	export kconfig='i386-randconfig-a014-20210112'
	export repeat_to=4
	export nr_vm=160
	export submit_id='5fff065a09b857125655fb39'
	export job_file='/lkp/jobs/scheduled/vm-snb-i386-125/rcutorture-300s-cpuhotplug-srcud-debian-i386-20191205.cgz-d5bff968ea9cc005e632d9369c26cbd8148c93d5-20210113-4694-1af2ygw-2.yaml'
	export id='c89fdae82cf8c94d869361d3394056dcd7671937'
	export queuer_version='/lkp-src'
	export model='qemu-system-i386 -enable-kvm -cpu SandyBridge'
	export nr_cpu=2
	export memory='8G'
	export need_kconfig='CONFIG_RCU_TORTURE_TEST=m
CONFIG_SECURITY_LOADPIN_ENABLED=n ~ "<= v4.19"
CONFIG_SECURITY_LOADPIN_ENFORCE=n ~ ">= v4.20"
CONFIG_KVM_GUEST=y'
	export ssh_base_port=23400
	export kernel_cmdline='vmalloc=512M'
	export rootfs='debian-i386-20191205.cgz'
	export compiler='gcc-9'
	export enqueue_time='2021-01-13 22:40:26 +0800'
	export _id='5fff065a09b857125655fb39'
	export _rt='/result/rcutorture/300s-cpuhotplug-srcud/vm-snb-i386/debian-i386-20191205.cgz/i386-randconfig-a014-20210112/gcc-9/d5bff968ea9cc005e632d9369c26cbd8148c93d5'
	export user='lkp'
	export LKP_SERVER='internal-lkp-server'
	export result_root='/result/rcutorture/300s-cpuhotplug-srcud/vm-snb-i386/debian-i386-20191205.cgz/i386-randconfig-a014-20210112/gcc-9/d5bff968ea9cc005e632d9369c26cbd8148c93d5/3'
	export scheduler_version='/lkp/lkp/src'
	export arch='i386'
	export max_uptime=2100
	export initrd='/osimage/debian/debian-i386-20191205.cgz'
	export bootloader_append='root=/dev/ram0
user=lkp
job=/lkp/jobs/scheduled/vm-snb-i386-125/rcutorture-300s-cpuhotplug-srcud-debian-i386-20191205.cgz-d5bff968ea9cc005e632d9369c26cbd8148c93d5-20210113-4694-1af2ygw-2.yaml
ARCH=i386
kconfig=i386-randconfig-a014-20210112
branch=rcu/dev.2021.01.11b
commit=d5bff968ea9cc005e632d9369c26cbd8148c93d5
BOOT_IMAGE=/pkg/linux/i386-randconfig-a014-20210112/gcc-9/d5bff968ea9cc005e632d9369c26cbd8148c93d5/vmlinuz-5.11.0-rc3-gd5bff968ea9c
vmalloc=512M
max_uptime=2100
RESULT_ROOT=/result/rcutorture/300s-cpuhotplug-srcud/vm-snb-i386/debian-i386-20191205.cgz/i386-randconfig-a014-20210112/gcc-9/d5bff968ea9cc005e632d9369c26cbd8148c93d5/3
LKP_SERVER=internal-lkp-server
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
	export modules_initrd='/pkg/linux/i386-randconfig-a014-20210112/gcc-9/d5bff968ea9cc005e632d9369c26cbd8148c93d5/modules.cgz'
	export bm_initrd='/osimage/deps/debian-i386-20191205.cgz/lkp_20201203.cgz'
	export lkp_initrd='/osimage/user/lkp/lkp-i386.cgz'
	export site='de7ff43d24d4'
	export queue_at_least_once=1
	export kernel='/pkg/linux/i386-randconfig-a014-20210112/gcc-9/d5bff968ea9cc005e632d9369c26cbd8148c93d5/vmlinuz-5.11.0-rc3-gd5bff968ea9c'
	export dequeue_time='2021-01-13 22:41:35 +0800'
	export job_initrd='/lkp/jobs/scheduled/vm-snb-i386-125/rcutorture-300s-cpuhotplug-srcud-debian-i386-20191205.cgz-d5bff968ea9cc005e632d9369c26cbd8148c93d5-20210113-4694-1af2ygw-2.cgz'

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

	run_monitor $LKP_SRC/monitors/wrapper kmsg
	run_monitor $LKP_SRC/monitors/wrapper heartbeat
	run_monitor $LKP_SRC/monitors/wrapper meminfo

	run_test test='cpuhotplug' torture_type='srcud' $LKP_SRC/tests/wrapper rcutorture
}

extract_stats()
{
	export stats_part_begin=
	export stats_part_end=

	$LKP_SRC/stats/wrapper rcutorture
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper meminfo

	$LKP_SRC/stats/wrapper time rcutorture.time
	$LKP_SRC/stats/wrapper dmesg
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper last_state
	$LKP_SRC/stats/wrapper stderr
	$LKP_SRC/stats/wrapper time
}

"$@"

--pWyiEgJYm5f9v55/
Content-Type: application/x-xz
Content-Disposition: attachment; filename="dmesg.xz"
Content-Transfer-Encoding: base64

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
AARZWg==

--pWyiEgJYm5f9v55/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=rcutorture

2021-01-13 14:42:59 modprobe rcutorture onoff_interval=3 onoff_holdoff=30 torture_type=srcud
2021-01-13 14:42:59 sleep 300
2021-01-13 14:47:59 rmmod rcutorture
[   17.733054] srcud-torture:--- Start of test: nreaders=1 nfakewriters=4 stat_interval=60 verbose=1 test_no_idle_hz=1 shuffle_interval=3 stutter=5 irqreader=1 fqs_duration=0 fqs_holdoff=0 fqs_stutter=3 test_boost=1/0 test_boost_interval=7 test_boost_duration=4 shutdown_secs=0 stall_cpu=0 stall_cpu_holdoff=10 stall_cpu_irqsoff=0 stall_cpu_block=0 n_barrier_cbs=0 onoff_interval=3 onoff_holdoff=30 read_exit_delay=13 read_exit_burst=16 nocbs_nthreads=0 nocbs_toggle=1000
[   17.740129] srcud-torture: Creating rcu_torture_writer task
[   17.748829] srcud-torture: Creating rcu_torture_fakewriter task
[   17.749719] srcud-torture: rcu_torture_writer task started
[   17.750467] srcud-torture: Creating rcu_torture_fakewriter task
[   17.752324] srcud-torture: rcu_torture_fakewriter task started
[   17.754719] srcud-torture: Creating rcu_torture_fakewriter task
[   17.756212] srcud-torture: rcu_torture_fakewriter task started
[   17.757965] srcud-torture: Creating rcu_torture_fakewriter task
[   17.759086] srcud-torture: rcu_torture_fakewriter task started
[   17.760840] srcud-torture: Creating rcu_torture_reader task
[   17.762479] srcud-torture: rcu_torture_fakewriter task started
[   17.768121] srcud-torture: Creating rcu_torture_stats task
[   17.769442] srcud-torture: rcu_torture_reader task started
[   17.771272] srcud-torture: Creating torture_shuffle task
[   17.771962] srcud-torture: rcu_torture_stats task started
[   17.772522] srcud-torture: Creating torture_stutter task
[   17.773098] srcud-torture: torture_shuffle task started
[   17.773731] srcud-torture: Creating torture_onoff task
[   17.777891] srcud-torture: torture_stutter task started
[   17.778637] srcud-torture: rcu_torture_fwd_prog_init: Disabled, unsupported by RCU flavor under test
[   17.779658] srcud-torture: Creating rcu_torture_read_exit task
[   17.780448] srcud-torture: torture_onoff task started
[   17.781057] srcud-torture: torture_onoff begin holdoff
[   17.782232] srcud-torture: rcu_torture_read_exit: Start of test
[   23.021193] srcud-torture: rcu_torture_read_exit: End of episode
[   36.601189] srcud-torture: rcu_torture_read_exit: Start of episode
[   36.701885] srcud-torture: rcu_torture_read_exit: End of episode
[   47.951349] srcud-torture: torture_onoff end holdoff
[   50.271279] srcud-torture: rcu_torture_read_exit: Start of episode
[   52.819284] srcud-torture: rcu_torture_read_exit: End of episode
[   66.351238] srcud-torture: rcu_torture_read_exit: Start of episode
[   66.423998] srcud-torture: rcu_torture_read_exit: End of episode
[   78.032676] srcud-torture: rtc: (ptrval) ver: 922 tfle: 0 rta: 922 rtaf: 0 rtf: 913 rtmbe: 0 rtmbkf: 0/0 rtbe: 0 rtbke: 0 rtbre: 0 rtbf: 0 rtb: 0 nt: 552 onoff: 93/93:93/94 2,21:0,21 667:787 (HZ=100) barrier: 0/0:0 read-exits: 67 nocb-toggles: 0:0
[   78.035048] srcud-torture: Reader Pipe:  12631032 44 0 0 0 0 0 0 0 0 0
[   78.035759] srcud-torture: Reader Batch:  12630957 119 0 0 0 0 0 0 0 0 0
[   78.036507] srcud-torture: Free-Block Circulation:  921 921 920 919 918 917 916 915 914 913 0
[   78.037407] rcu: srcud-torture: Tree SRCU g6668 per-CPU(idx=1): 0(17,12 .) 1(-17,-12 .) T(0,0)
[   80.031260] srcud-torture: rcu_torture_read_exit: Start of episode
[   82.768306] srcud-torture: rcu_torture_read_exit: End of episode
[   96.356103] srcud-torture: rcu_torture_read_exit: Start of episode
[   96.491459] srcud-torture: rcu_torture_read_exit: End of episode
[  110.111985] srcud-torture: rcu_torture_read_exit: Start of episode
[  112.811585] srcud-torture: rcu_torture_read_exit: End of episode
[  126.431178] srcud-torture: rcu_torture_read_exit: Start of episode
[  126.601479] srcud-torture: rcu_torture_read_exit: End of episode
[  138.831405] srcud-torture: rtc: 0b3462e0 ver: 1888 tfle: 0 rta: 1888 rtaf: 0 rtf: 1879 rtmbe: 0 rtmbkf: 0/0 rtbe: 0 rtbke: 0 rtbre: 0 rtbf: 0 rtb: 0 nt: 1205 onoff: 292/292:292/292 2,21:0,21 2022:2389 (HZ=100) barrier: 0/0:0 read-exits: 135 nocb-toggles: 0:0
[  138.833855] srcud-torture: Reader Pipe:  27128062 103 0 0 0 0 0 0 0 0 0
[  138.834584] srcud-torture: Reader Batch:  27127903 262 0 0 0 0 0 0 0 0 0
[  138.835306] srcud-torture: Free-Block Circulation:  1887 1887 1886 1885 1884 1883 1882 1881 1880 1879 0
[  138.836284] rcu: srcud-torture: Tree SRCU g13740 per-CPU(idx=1): 0(36,37 .) 1(-36,-37 .) T(0,0)
[  140.191292] srcud-torture: rcu_torture_read_exit: Start of episode
[  142.818048] srcud-torture: rcu_torture_read_exit: End of episode
[  156.431250] srcud-torture: rcu_torture_read_exit: Start of episode
[  156.531642] srcud-torture: rcu_torture_read_exit: End of episode
[  170.111340] srcud-torture: rcu_torture_read_exit: Start of episode
[  172.771560] srcud-torture: rcu_torture_read_exit: End of episode
[  186.351210] srcud-torture: rcu_torture_read_exit: Start of episode
[  186.473430] srcud-torture: rcu_torture_read_exit: End of episode
[  200.031280] srcud-torture: rcu_torture_read_exit: Start of episode
[  200.291845] srcud-torture: rtc: fa8cee33 ver: 2847 tfle: 0 rta: 2847 rtaf: 0 rtf: 2838 rtmbe: 0 rtmbkf: 0/0 rtbe: 0 rtbke: 0 rtbre: 0 rtbf: 0 rtb: 0 nt: 1845 onoff: 478/479:479/479 2,28:0,22 3368:3992 (HZ=100) barrier: 0/0:0 read-exits: 204 nocb-toggles: 0:0
[  200.294303] srcud-torture: Reader Pipe:  41704867 162 0 0 0 0 0 0 0 0 0
[  200.297080] srcud-torture: Reader Batch:  41704622 407 0 0 0 0 0 0 0 0 0
[  200.297827] srcud-torture: Free-Block Circulation:  2846 2846 2845 2844 2843 2842 2841 2840 2839 2838 0
[  200.298845] rcu: srcud-torture: Tree SRCU g20820 per-CPU(idx=1): 0(54,56 .) 1(-54,-56 .) T(0,0)
[  202.764252] srcud-torture: rcu_torture_read_exit: End of episode
[  216.367255] srcud-torture: rcu_torture_read_exit: Start of episode
[  216.377405] srcud-torture: rcu_torture_read_exit: End of episode
[  229.951238] srcud-torture: rcu_torture_read_exit: Start of episode
[  232.762949] srcud-torture: rcu_torture_read_exit: End of episode
[  246.351204] srcud-torture: rcu_torture_read_exit: Start of episode
[  246.353689] srcud-torture: rcu_torture_read_exit: End of episode
[  259.871299] srcud-torture: rcu_torture_read_exit: Start of episode
[  261.711316] srcud-torture: rtc: 7db38eed ver: 3968 tfle: 0 rta: 3968 rtaf: 0 rtf: 3959 rtmbe: 0 rtmbkf: 0/0 rtbe: 0 rtbke: 0 rtbre: 0 rtbf: 0 rtb: 0 nt: 2608 onoff: 682/682:682/683 2,28:0,22 4793:5599 (HZ=100) barrier: 0/0:0 read-exits: 272 nocb-toggles: 0:0
[  261.713957] srcud-torture: Reader Pipe:  58410915 221 0 0 0 0 0 0 0 0 0
[  261.714771] srcud-torture: Reader Batch:  58410548 588 0 0 0 0 0 0 0 0 0
[  261.715616] srcud-torture: Free-Block Circulation:  3967 3967 3966 3965 3964 3963 3962 3961 3960 3959 0
[  261.716732] rcu: srcud-torture: Tree SRCU g29064 per-CPU(idx=0): 0(72,75 .) 1(-72,-75 .) T(0,0)
[  262.762124] srcud-torture: rcu_torture_read_exit: End of episode
[  276.366847] srcud-torture: rcu_torture_read_exit: Start of episode
[  276.399043] srcud-torture: rcu_torture_read_exit: End of episode
[  289.951353] srcud-torture: rcu_torture_read_exit: Start of episode
[  292.773027] srcud-torture: rcu_torture_read_exit: End of episode
[  306.351185] srcud-torture: rcu_torture_read_exit: Start of episode
[  306.355251] srcud-torture: rcu_torture_read_exit: End of episode

--pWyiEgJYm5f9v55/--
